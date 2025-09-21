local current_position = get_window_position()

local sine = false

local time = 0

return Create.frame{
    scale = UDim2.new(inch(6),inch(4)),
    color = Color.from_rgb(0.5,0.5,0.5),

    on_init=function(self)
        self:put_center()
    end,

    Create.text{
        text = "Logged in accounts:",
        text_alignment = Enum.TextAlignment.TopMiddle,
        text_scaling = Enum.TextScaling.Max,
        text_color = Color.from_rgb(0,0,0),
        scale = UDim2.new(rel(1), inch(0.35)),

        on_init=function(self)
            self:push_top()
        end,
    },

    Create.frame{
        scale = UDim2.new(rel(1), rel(1)-inch(1)),
        position = UDim2.new(0, inch(0.6));
        run_script("playerlist.lua"),
        Create.quad{
            scale = UDim2.new(rel(1), rel(1)),
            color = Color.from_rgb(0.8,0.8,0.8),
        }
    },

    Create.np_text_label{
        anchor = Vec2.new(0.5,0),
        scale = UDim2.new(inch(2), inch(0.5)),
        position = UDim2.new(rel(0.5), inch(0.05)),
        text = "Add account.",
        font_size = inch(0.25),
        text_alignment = Enum.TextAlignment.Middle,
        text_scaling = Enum.TextScaling.Fit,
        interactable = true,

        slice_left=0.5,
        slice_right=0.5,
        slice_top=0.5,
        slice_bottom=0.5,
        size_left=inch(1),
        size_right=inch(1),
        size_top=inch(1),
        size_bottom=inch(1),
        side_overflow_behaviour=Enum.SideOverflowBehaviour.Shrink,
        
        background_clicked_color = Color.from_rgb(1,0,0),
        background_hovered_color = Color.from_rgb(1,1,0),
        on_init=function(self)
            self.background_texture = load_texture("round.png")
        end,
        on_click_release=function(self)
            load_screen("login")
        end
    },
}