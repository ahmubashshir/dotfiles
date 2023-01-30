local shaders = {}
shaders.psep = package.config:sub(1, 1)

-- Anime4K: common
shaders["common"] = {{"Restore", "Clamp_Highlights"}}
shaders["hq"] = {}
shaders["fast"] = {}
-- Anime4K: Mode A (High-end GPUs)
shaders["hq"]["a"] = {
    {"Restore", "Restore_CNN_VL"}, {"Upscale", "Upscale_CNN_x2_VL"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_M"}
}

-- Anime4K: Mode B (High-end GPUs)
shaders["hq"]["b"] = {
    {"Restore", "Restore_CNN_Soft_VL"}, {"Upscale", "Upscale_CNN_x2_VL"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_M"}
}
-- Anime4K: Mode C  (High-end GPUs)
shaders["hq"]["c"] = {
    {"Upscale+Denoise", "Upscale_Denoise_CNN_x2_VL"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_M"}
}

-- Anime4K: Mode AA (High-end GPUs)
shaders["hq"]["aa"] = {
    {"Restore", "Restore_CNN_VL"}, {"Upscale", "Upscale_CNN_x2_VL"},
    {"Restore", "Restore_CNN_M"}, {"Upscale", "AutoDownscalePre_x2"},
    {"Upscale", "AutoDownscalePre_x4"}, {"Upscale", "Upscale_CNN_x2_M"}
}
-- Anime4K: Mode BB (High-end GPUs)
shaders["hq"]["bb"] = {
    {"Restore", "Restore_CNN_Soft_VL"}, {"Upscale", "Upscale_CNN_x2_VL"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Restore", "Restore_CNN_Soft_M"}, {"Upscale", "Upscale_CNN_x2_M"}
}
-- Anime4K: Mode CA (High-end GPUs)
shaders["hq"]["ca"] = {
    {"Upscale+Denoise", "Upscale_Denoise_CNN_x2_VL"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Restore", "Restore_CNN_Soft_M"}, {"Upscale", "Upscale_CNN_x2_M"}
}
-- Anime4K: Mode A (Mid/low-end GPUs)
shaders["fast"]["a"] = {
    {"Restore", "Restore_CNN_M"}, {"Upscale", "Upscale_CNN_x2_M"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_S"}
}
-- Anime4K: Mode B (Mid/low-end GPUs)
shaders["fast"]["b"] = {
    {"Restore", "Restore_CNN_Soft_M"}, {"Upscale", "Upscale_CNN_x2_M"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_S"}
}

-- Anime4K: Mode C (Mid/low-end GPUs)
shaders["fast"]["c"] = {
    {"Upscale+Denoise", "Upscale_Denoise_CNN_x2_M"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Upscale", "Upscale_CNN_x2_S"}
}

-- Anime4K: Mode AA (Mid/low-end GPUs)
shaders["fast"]["aa"] = {
    {"Restore", "Restore_CNN_M"}, {"Upscale", "Upscale_CNN_x2_M"},
    {"Restore", "Restore_CNN_S"}, {"Upscale", "AutoDownscalePre_x2"},
    {"Upscale", "AutoDownscalePre_x4"}, {"Upscale", "Upscale_CNN_x2_S"}
}

-- Anime4K: Mode BB (Mid/low-end GPUs)
shaders["fast"]["bb"] = {
    {"Restore", "Restore_CNN_Soft_M"}, {"Upscale", "Upscale_CNN_x2_M"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Restore", "Restore_CNN_Soft_S"}, {"Upscale", "Upscale_CNN_x2_S"}
}

-- Anime4K: Mode CA (Mid/low-end GPUs)
shaders["fast"]["ca"] = {
    {"Upscale+Denoise", "Upscale_Denoise_CNN_x2_M"},
    {"Upscale", "AutoDownscalePre_x2"}, {"Upscale", "AutoDownscalePre_x4"},
    {"Restore", "Restore_CNN_Soft_S"}, {"Upscale", "Upscale_CNN_x2_S"}
}

function shaders.resolve(tshader)
    local tab = table.unpack ~= nil
                and {table.unpack(tshader)}
                or {unpack(tshader)}
    local last = table.maxn(tab)
    tab[last] = "Anime4K_" .. tab[last] .. ".glsl"
    return table.concat(tab, shaders.psep)
end

return shaders
