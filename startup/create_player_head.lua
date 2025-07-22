create_player_head = function(texture, properties)
    local frame_table = {
        Create.quad{
            scale=UDim2.new(pct(100), pct(100)),
            uv_scale=Vec2.new(1 / 8, 1 / 8),
            uv_offset=Vec2.new(5 / 8, 6 / 8),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(pct(50), pct(50)),
            on_init=function(self)
                self.texture = texture
            end
        },
        Create.quad{
            scale=UDim2.new(pct(90), pct(90)),
            uv_scale=Vec2.new(1 / 8, 1 / 8),
            uv_offset=Vec2.new(1 / 8, 6 / 8),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(pct(50), pct(50)),
            on_init=function(self)
                self.texture = texture
            end
        },
        Create.quad{
            scale=UDim2.new(pct(95), pct(95)),
            uv_scale=Vec2.new(-1 / 8, 1 / 8),
            uv_offset=Vec2.new(8 / 8, 6 / 8),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(pct(50), pct(50)),
            on_init=function(self)
                self.texture = texture
            end
        },
    }

    for k,v in pairs(frame_table) do properties[k] = v end

    return Create.frame(properties)
end