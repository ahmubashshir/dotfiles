local shaders = {}

-- Anime4K: unset
shaders["none"] = {}
-- Anime4K: 480/720p (Faithful)
shaders["default_faithful"] = {
    "Upscale_CNN_L_x2_Denoise", "Auto_Downscale_Pre_x4", "Auto_Downscale_Pre_x4"
}
-- Anime4K: 1080p (Faithful)
shaders["hd_faithful"] = {"Denoise_Bilateral_Mode", "Upscale_CNN_M_x2_Deblur"}
-- Anime4K: 480/720p (Perceptual Quality)
shaders["default_perceptual"] = {
    "Upscale_CNN_L_x2_Denoise", "Auto_Downscale_Pre_x4", "DarkLines_HQ",
    "ThinLines_HQ", "Upscale_CNN_M_x2_Deblur"
}
-- Anime4K: 1080p (Perceptual Quality)
shaders["hd_perceptual"] = {
    "Denoise_Bilateral_Mode", "DarkLines_HQ", "ThinLines_HQ",
    "Upscale_CNN_M_x2_Deblur"
}
-- Anime4K: 480/720p (Perceptual Quality and Deblur)
shaders["default_deblur"] = {
    "Upscale_CNN_L_x2_Denoise", "Auto_Downscale_Pre_x4", "Deblur_DoG",
    "DarkLines_HQ", "ThinLines_HQ", "Upscale_CNN_M_x2_Deblur"
}
-- Anime4K: 1080p (Perceptual Quality and Deblur)
shaders["hd_deblur"] = {
    "Denoise_Bilateral_Mode", "Deblur_DoG", "DarkLines_HQ", "ThinLines_HQ",
    "Upscale_CNN_M_x2_Deblur"
}

return shaders
