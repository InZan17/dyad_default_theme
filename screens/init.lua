local current_position = get_window_position()

local sine = false

local time = 0

return Create.frame{
    anchor = Vec2.new(0.5,0.5),
    position = UDim2.new(pct(50),pct(50)),
    scale = UDim2.new(inch(6),inch(4)),
    color = Color.from_rgb(0.5,0.5,0.5),

    Create.text{
        font_size = inch(0.25),
        text = "Here are your logged in accounts:",
        text_alignment = Enum.TextAlignment.TopMiddle,
        text_scaling = Enum.TextScaling.Fit,
        color = Color.from_rgb(0,0,0),
        scale = UDim2.new(pct(100), inch(0.25)),
        position = UDim2.new(0, pct(100)-inch(0.1));
        anchor = Vec2.new(0, 1)
    },

    Create.frame{
        scale = UDim2.new(pct(100), pct(100)-inch(1)),
        position = UDim2.new(0, inch(0.6));
        run_script("playerlist.lua"),
    },

    Create.text{
        anchor = Vec2.new(0.5,0),
        scale = UDim2.new(inch(2), inch(0.5)),
        position = UDim2.new(pct(50), inch(0.05)),
        text = "Add account.",
        font_size = inch(0.25),
        text_alignment = Enum.TextAlignment.Middle,
        text_scaling = Enum.TextScaling.Fit,
    },

    Create.quad{
        anchor = Vec2.new(0.5,0),
        scale = UDim2.new(inch(2), inch(0.5)),
        position = UDim2.new(pct(50), inch(0.05)),
        interactable = true,
        on_click_release=function(self)
            load_screen("login")
        end
    }
}