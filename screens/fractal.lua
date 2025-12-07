local material = create_material{
    frag = "hue.frag",
}

local time = 0

local ratio = math.sqrt(0.5)

local trunk_height = 1-ratio
local frame_height = (1 - trunk_height) * 2

local scaled_trunk_position = (frame_height - 1) / frame_height
local scaled_trunk_height = trunk_height / frame_height

local max_angle_range_deg = 360

local override_angle1 = nil -- 0.75
local override_angle2 = nil -- -0.25

local angle1 = 0
local angle2 = 0

local blur_size = 0.05

local white_blur_mul = 0.6

local resolution_mult = 4

local rerender_count = 10

local blur_res_mult = 0.4

local max_angle_range_0_1 = max_angle_range_deg / 360

local extended_frame_height = frame_height + blur_size * 2

function hslToRgb(h, s, l)
    h = h / 360
    s = s / 100
    l = l / 100

    local r, g, b;

    if s == 0 then
        r, g, b = l, l, l; -- achromatic
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1 / 6 then return p + (q - p) * 6 * t end
            if t < 1 / 2 then return q end
            if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
            return p;
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s;
        local p = 2 * l - q;
        r = hue2rgb(p, q, h + 1 / 3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1 / 3);
    end

    return r * 255, g * 255, b * 255, 255
end

local rendered_frame = Create.texture_frame{
    background_transparency=1,
    resolution_mult=resolution_mult,
    Create.texture_frame{
        background_transparency=1,
        resolution_mult=resolution_mult,
        rerender_count=rerender_count,
        texture_format=Enum.TextureFormat.RGBA16F,
        double_buffer=true,
        scale=UDim2.new(rel(1 / extended_frame_height * frame_height), rel(1 / extended_frame_height * frame_height)),
        init=function(self)
            self:put_center()
        end,
        Create.frame{
            snap_to_pixels=false,
            init=function(self)
                self.anchor = Vec2.new(0.5,0)
                self.scale = UDim2.new(rel(0.006), rel(scaled_trunk_height))
                self.position = UDim2.new(rel(0.5), rel(scaled_trunk_position))
                self.background_color = Color.from_rgb(1,0,0)
            end,
            update=function(self)
                request_render()
                angle1 = override_angle1 or (input.mouse_pos.y/screen_height)*-2 + 1
                angle2 = override_angle2 or (input.mouse_pos.x/screen_width)*-2 + 1
            end
        },
        Create.frame{
            snap_to_pixels=false,
            init=function(self)
                self.scale = UDim2.new(rel(ratio), rel(ratio))
                self.anchor = Vec2.new(0.5,trunk_height)
                self.position = UDim2.new(rel(0.5), rel(scaled_trunk_position + scaled_trunk_height))
                self.rotation = (angle1*max_angle_range_0_1*math.pi)
                self.background_material = (material)
                self.background_texture = self.parent.render_texture
                self.background_color = Color.from_rgb(0.5,0.5,0)
            end,
            update=function(self)
                self.rotation = (angle2*max_angle_range_0_1*math.pi)
            end
        },
        Create.frame{
            snap_to_pixels=false,
            init=function(self)
                self.scale = UDim2.new(rel(ratio), rel(ratio))
                self.anchor = Vec2.new(0.5,trunk_height)
                self.position = UDim2.new(rel(0.5), rel(scaled_trunk_position + scaled_trunk_height))
                self.rotation = (angle2*max_angle_range_0_1*math.pi)
                self.background_material = (material)
                self.background_texture = self.parent.render_texture
                self.background_color = Color.from_rgb(0.5,0,0)
            end,
            update=function(self)
                self.rotation = (angle1*max_angle_range_0_1*math.pi)
            end
        }
    },
};

local gauss_material = create_material{
    frag = "gauss.frag",
    uniforms = {
        blur_size = "Int1",
        pixel_offset = "Float2"
    },
}

rendered_frame.view_material = gauss_material:clone()

local blur_x_frame = Create.texture_frame{
    background_transparency=1,
    resolution_mult=resolution_mult * blur_res_mult,
    update=function(self)
        rendered_frame.view_material:set_float2("pixel_offset", 1/(screen_height * extended_frame_height * self.resolution_mult), 0)
        rendered_frame.view_material:set_int1("blur_size", math.ceil(screen_height * extended_frame_height * self.resolution_mult * blur_size))
    end,
    rendered_frame
}

blur_x_frame.view_material = gauss_material:clone()


local smaller_blur_frame = Create.texture_frame{
    background_transparency=1,
    resolution_mult=resolution_mult * blur_res_mult,
    Create.texture_frame{
        background_transparency=1,
        resolution_mult=resolution_mult * blur_res_mult,
        init=function(self)
            self.view_material = gauss_material:clone()
            self:update()
        end,
        update=function(self)
            self.view_material:set_float2("pixel_offset", 1/(screen_height * extended_frame_height * self.resolution_mult), 0)
            self.view_material:set_int1("blur_size", math.ceil(screen_height * extended_frame_height * self.resolution_mult * blur_size * white_blur_mul))
        end,
        Create.frame{
            scale=UDim2.new(rel(1), rel(1)),
            init=function(self)
                self.background_texture = rendered_frame.render_texture
                self.background_material = gauss_material:clone()
                self:update()
            end,
            update=function(self)
                self.background_material:set_float2("pixel_offset", 0, 1/(screen_height * extended_frame_height * self.parent.resolution_mult))
                self.background_material:set_int1("blur_size", math.ceil(screen_height * extended_frame_height * self.parent.resolution_mult * blur_size * white_blur_mul))
            end
        }
    }
}

local blurred_frame = Create.texture_frame{
    background_transparency=1,
    resolution_mult=resolution_mult * blur_res_mult,
    update=function(self)
        blur_x_frame.view_material:set_float2("pixel_offset", 0, 1/(screen_height * extended_frame_height * self.resolution_mult))
        blur_x_frame.view_material:set_int1("blur_size", math.ceil(screen_height * extended_frame_height * self.resolution_mult * blur_size))
    end,
    blur_x_frame,
    smaller_blur_frame
}

local bloom_material = create_material{
    frag = "bloom_combine.frag",
    textures = {"stem_tex", "smaller_blur_tex"},
}

blurred_frame.view_material = bloom_material
blurred_frame.view_material:set_texture("stem_tex", rendered_frame.render_texture)
blurred_frame.view_material:set_texture("smaller_blur_tex", smaller_blur_frame.render_texture)

return Create.frame{
    background_color=Color.from_rgb(0.031, 0.031, 0.031),
    Create.texture_frame{
        background_transparency=1,
        resolution_mult=resolution_mult,
        scale=UDim2.new(rel_y(extended_frame_height), rel_y(extended_frame_height)),
        init=function(self)
            self:put_center()
            self:push_top()
            self.position = self.position + UDim2.new(0, rel(blur_size))
        end,
        update=function(self)
            if input:is_key_pressed("Space") then
                self:capture()
            end
        end,
        blurred_frame
    }
}