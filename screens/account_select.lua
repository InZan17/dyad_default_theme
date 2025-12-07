local current_position = get_window_position()

local sine = false

local time = 0

return Create.nine_patch_frame{
    slice_left=0.5,
    slice_right=0.5,
    slice_top=0.5,
    slice_bottom=0.5,
    size_left=inch(0.3),
    size_right=inch(0.3),
    size_top=inch(0.3),
    size_bottom=inch(0.3),

    background_texture=load_texture("background1.png"),

    scale = UDim2.new(inch(6),inch(4)),
    background_color = Color.from_rgb(0.9,0.9,0.9),

    init=function(self)
        self:put_center()
    end,

    Create.text_label{
        background_transparency=1,
        text = "Logged in accounts:",
        text_alignment = Enum.TextAlignment.Middle,
        font_size=inch(0.325),
        text_color = Color.from_rgb(0,0,0),
        scale = UDim2.new(rel(1), inch(0.5)),

        init=function(self)
            self:push_top()
        end,
    },

    Create.nine_patch_frame{
        scale = UDim2.new(rel(1) - inch(0.17), rel(1)-inch(1.075)),
        anchor = Vec2.new(0.5, 0),
        position = UDim2.new(rel(0.5), inch(0.6)),
        background_color = Color.from_rgb(0.5,0.5,0.5),
        background_texture=load_texture("background2.png"),
        run_script("playerlist.lua"),
        init=function(self)
        end
    },

    Create.np_text_label{
        anchor = Vec2.new(0.5,0),
        scale = UDim2.new(inch(2), inch(0.45)),
        position = UDim2.new(rel(0.5), inch(0.1)),
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
        init=function(self)
            self.background_texture = load_texture("round.png")
        end,
        on_click_release=function(self)
            load_screen("login")
        end
    }
}