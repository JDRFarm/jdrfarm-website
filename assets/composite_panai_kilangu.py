"""
Composite: remove foreground basket from hero image, place palm_kil bundles (cutout).
"""
from __future__ import annotations

import os
from pathlib import Path

import cv2
import numpy as np
from PIL import Image

ASSETS = Path(r"C:\Users\dell12\.cursor\projects\d-AI-web\assets")
IMG1 = ASSETS / "c__Users_dell12_AppData_Roaming_Cursor_User_workspaceStorage_a8bf3e6195658bb91bb542f84d90c059_images_ee690a5f-1916-4c54-8b22-986b43ee143b-467cf441-dca8-4aad-b8aa-6b8201a65d77.png"
IMG3 = ASSETS / "c__Users_dell12_AppData_Roaming_Cursor_User_workspaceStorage_a8bf3e6195658bb91bb542f84d90c059_images_palm_kil-22399c4a-c2ad-4a5b-acc6-54f5a519a0d6.png"
OUT = Path(__file__).resolve().parent / "panai-kilangu-hero-no-basket.png"


def white_to_alpha_rgba(im: Image.Image, white_thresh: int = 245) -> Image.Image:
    arr = np.array(im.convert("RGBA"))
    r, g, b, a = arr[:, :, 0], arr[:, :, 1], arr[:, :, 2], arr[:, :, 3]
    light = (r > white_thresh) & (g > white_thresh) & (b > white_thresh)
    arr[:, :, 3] = np.where(light, 0, a)
    # Slight warm lift to match golden-hour tabletop
    arr[:, :, 0] = np.clip(arr[:, :, 0].astype(np.int16) + 8, 0, 255).astype(np.uint8)
    arr[:, :, 1] = np.clip(arr[:, :, 1].astype(np.int16) + 3, 0, 255).astype(np.uint8)
    return Image.fromarray(arr, "RGBA")


def basket_mask(h: int, w: int) -> np.ndarray:
    """Tight ellipse over only the woven basket + sprouts inside it (682x1024 hero)."""
    mask = np.zeros((h, w), np.uint8)
    cx = int(w * 0.148)
    cy = int(h * 0.752)
    ax = int(w * 0.095)
    ay = int(h * 0.082)
    cv2.ellipse(mask, (cx, cy), (ax, ay), angle=-12, startAngle=0, endAngle=360, color=255, thickness=-1)
    clip = np.zeros_like(mask)
    y0, y1 = int(h * 0.655), int(h * 0.868)
    x1 = int(w * 0.32)
    clip[y0:y1, 0:x1] = 255
    mask = cv2.bitwise_and(mask, clip)
    cv2.GaussianBlur(mask, (0, 0), sigmaX=7, sigmaY=7, dst=mask)
    _, mask = cv2.threshold(mask, 127, 255, cv2.THRESH_BINARY)
    return mask


def dilate_mask_soft(mask: np.ndarray, iters: int = 4) -> np.ndarray:
    k = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5))
    return cv2.dilate(mask, k, iterations=iters)


def clone_table_patch(rgb: np.ndarray, mask_u8: np.ndarray) -> np.ndarray:
    """Replace mask with a tabletop crop from the right; match mean color to left edge to hide seams."""
    h, w, _ = rgb.shape
    idx = np.where(mask_u8 > 127)
    if idx[0].size == 0:
        return rgb
    y0, y1 = int(idx[0].min()), int(idx[0].max())
    x0, x1 = int(idx[1].min()), int(idx[1].max())
    ph = y1 - y0 + 1
    pw = x1 - x0 + 1
    src_x = int(w * 0.62)
    if src_x + pw > w:
        src_x = max(0, w - pw - 1)
    patch = rgb[y0 : y1 + 1, src_x : src_x + pw].copy().astype(np.float32)
    if patch.shape[1] != pw or patch.shape[0] != ph:
        patch = cv2.resize(patch, (pw, ph), interpolation=cv2.INTER_LINEAR).astype(np.float32)

    x_ref0 = max(0, x0 - 14)
    border = rgb[y0 : y1 + 1, x_ref0:x0].astype(np.float32)
    if border.size > 0:
        b_mean = border.reshape(-1, 3).mean(axis=0)
        p_mean = patch.reshape(-1, 3).mean(axis=0)
        patch = np.clip(patch + (b_mean - p_mean), 0, 255)

    out = rgb.copy()
    roi_m = mask_u8[y0 : y1 + 1, x0 : x0 + pw]
    a = (roi_m.astype(np.float32) / 255.0)[..., None]
    roi = out[y0 : y1 + 1, x0 : x0 + pw].astype(np.float32)
    blended = roi * (1.0 - a) + patch * a
    roi[:] = blended.astype(np.uint8)
    return out


def main() -> None:
    base = Image.open(IMG1).convert("RGB")
    w, h = base.size
    np_base = np.array(base)
    m = basket_mask(h, w)
    m_fill = dilate_mask_soft(m)
    result_rgb = clone_table_patch(np_base, m_fill)

    overlay = Image.fromarray(result_rgb, "RGB").convert("RGBA")
    cut = white_to_alpha_rgba(Image.open(IMG3).convert("RGBA"))

    # Scale to sit on wood only (narrow so it does not overlap the pouch label)
    target_w = int(w * 0.22)
    ratio = target_w / cut.width
    new_h = max(1, int(cut.height * ratio))
    cut = cut.resize((target_w, new_h), Image.Resampling.LANCZOS)

    # Bottom-left on table; stay left of pouch face
    x = int(w * 0.018)
    y = h - new_h - int(h * 0.118)
    overlay.paste(cut, (x, y), cut)

    overlay.convert("RGB").save(OUT, "PNG", optimize=True)
    print("Wrote", OUT)


if __name__ == "__main__":
    main()
