local button_height_inch = 0.65
local padding_inch = 0.1

return Create.list{
    scale = UDim2.new(pct(100), pct(100)),
    child_size = UDim2.new(pct(100), inch(button_height_inch)),
    on_init=function(self)
        for i, account in ipairs(LAUNCHER:get_available_accounts()) do

            print(account)

            local hovered = false
            local show_text_speed = 4

            local text_position = 0

            Create.frame{
                Create.frame{
                    scale=UDim2.new(pct(100) - inch(padding_inch), pct(100) - inch(padding_inch)),
                    position=UDim2.new(pct(50), pct(50)),
                    anchor=Vec2.new(0.5, 0.5),
                    create_player_head(account.skin, {
                        scale=UDim2.new(inch(button_height_inch - padding_inch), inch(button_height_inch - padding_inch)),
                    }),
                    Create.text{
                        scale=UDim2.new(pct(100) - inch(button_height_inch + padding_inch), pct(100)),
                        position=UDim2.new(pct(100), 0),
                        anchor=Vec2.new(1, 0),
                        font_size = inch(0.25),
                        text_alignment =  Enum.TextAlignment.MiddleLeft,
                        text = account.username,
                    },
                    Create.text{
                        scale=UDim2.new(inch(1.75), pct(100)),
                        position=UDim2.new(pct(100), 0),
                        anchor=Vec2.new(0, 0),
                        font_size = inch(0.25),
                        text_alignment =  Enum.TextAlignment.MiddleRight,
                        text = "Use account ",
                        update=function(self)
                            if hovered then
                                text_position += delta_time * show_text_speed
                            else
                                text_position -= delta_time * show_text_speed
                            end

                            text_position = math.clamp(text_position, 0, 1)

                            self.anchor = Vec2.new(math.sin((text_position * math.pi) / 2), 0)
                        end
                    }
                },
                Create.quad{
                    interactable=true,
                    scale=UDim2.new(pct(100), pct(100)),
                    on_init=function(self)
                        self:on_un_hover()
                    end,
                    on_hover=function(self)
                        self.color = Color.from_rgba(1, 1, 1, 0.8)
                        hovered = true
                    end,
                    on_un_hover=function(self)
                        self.color = Color.from_rgba(0, 0, 0, 0)
                        hovered = false
                    end,
                    on_click_release=function(self)
                        self.parent.enabled = false
                        LAUNCHER:start_profile_update(account.uuid, function(result)
                            print(result.description)
                            self.parent.enabled = true
                        end)
                    end
                }
            }.parent = self
        end
    end
}