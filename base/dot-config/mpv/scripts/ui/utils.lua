function scale_value(x0, x1, y0, y1, val)
    local m = (y1 - y0) / (x1 - x0)
    local b = y0 - (m * x0)
    return (m * val) + b
end

function get_element_hitbox(element)
    return element.hitbox.x1, element.hitbox.y1, element.hitbox.x2,
           element.hitbox.y2
end

function limit_range(min, max, val)
    if val > max then
        val = max
    elseif val < min then
        val = min
    end
    return val
end

-- translate value into element coordinates
function get_slider_ele_pos_for(element, val)

    local ele_pos = scale_value(element.slider.min.value,
                                element.slider.max.value,
                                element.slider.min.ele_pos,
                                element.slider.max.ele_pos, val)

    return limit_range(element.slider.min.ele_pos, element.slider.max.ele_pos,
                       ele_pos)
end

-- translates global (mouse) coordinates to value
function get_slider_value_at(element, glob_pos)

    local val = scale_value(element.slider.min.glob_pos,
                            element.slider.max.glob_pos,
                            element.slider.min.value, element.slider.max.value,
                            glob_pos)

    return limit_range(element.slider.min.value, element.slider.max.value, val)
end

-- multiplies two alpha values, formular can probably be improved
function mult_alpha(alphaA, alphaB)
    return 255 - (((1 - (alphaA / 255)) * (1 - (alphaB / 255))) * 255)
end

-- returns hitbox spanning coordinates (top left, bottom right corner)
-- according to alignment
function get_hitbox_coords(x, y, an, w, h)

    local alignments = {
        [1] = function() return x, y - h, x + w, y end,
        [2] = function() return x - (w / 2), y - h, x + (w / 2), y end,
        [3] = function() return x - w, y - h, x, y end,

        [4] = function() return x, y - (h / 2), x + w, y + (h / 2) end,
        [5] = function()
            return x - (w / 2), y - (h / 2), x + (w / 2), y + (h / 2)
        end,
        [6] = function() return x - w, y - (h / 2), x, y + (h / 2) end,

        [7] = function() return x, y, x + w, y + h end,
        [8] = function() return x - (w / 2), y, x + (w / 2), y + h end,
        [9] = function() return x - w, y, x, y + h end
    }

    return alignments[an]()
end

function get_hitbox_coords_geo(geometry)
    return get_hitbox_coords(geometry.x, geometry.y, geometry.an, geometry.w,
                             geometry.h)
end

-- ASS utils

function ass_draw_cir_cw(ass, x, y, r)
    ass:round_rect_cw(x - r, y - r, x + r, y + r, r)
end

function ass_draw_rr_h_cw(ass, x0, y0, x1, y1, r1, hexagon, r2)
    if hexagon then
        ass:hexagon_cw(x0, y0, x1, y1, r1, r2)
    else
        ass:round_rect_cw(x0, y0, x1, y1, r1, r2)
    end
end

function ass_draw_rr_h_ccw(ass, x0, y0, x1, y1, r1, hexagon, r2)
    if hexagon then
        ass:hexagon_ccw(x0, y0, x1, y1, r1, r2)
    else
        ass:round_rect_ccw(x0, y0, x1, y1, r1, r2)
    end
end
