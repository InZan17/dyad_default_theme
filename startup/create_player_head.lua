local small_number = 0.001

print(rel(0.25) + inch(12))

create_player_head = function(texture, properties)
    local frame_table = {
        Create.quad{
            scale=UDim2.new(rel(1), rel(1)),
            uv_scale=Vec2.new(1 / 8 - small_number, 1 / 8 - small_number),
            uv_offset=Vec2.new(5 / 8 + small_number / 2, 6 / 8 + small_number / 2),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(rel(0.5), rel(0.5)),
            on_init=function(self)
                self.texture = texture
            end
        },
        Create.quad{
            scale=UDim2.new(rel(0.9), rel(0.9)),
            uv_scale=Vec2.new(1 / 8 - small_number, 1 / 8 - small_number),
            uv_offset=Vec2.new(1 / 8 + small_number / 2, 6 / 8 + small_number / 2),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(rel(0.5), rel(0.5)),
            on_init=function(self)
                self.texture = texture
            end
        },
        Create.quad{
            scale=UDim2.new(rel(0.95), rel(0.95)),
            uv_scale=Vec2.new(-1 / 8 - small_number, 1 / 8 - small_number),
            uv_offset=Vec2.new(8 / 8 + small_number / 2, 6 / 8 + small_number / 2),
            anchor=Vec2.new(0.5, 0.5),
            position=UDim2.new(rel(0.5), rel(0.5)),
            on_init=function(self)
                self.texture = texture
            end
        },
    }

    for k,v in pairs(frame_table) do properties[k] = v end

    return Create.frame(properties)
end