LAUNCHER:start_sign_in()

return Create.frame{
    on_init=function (self)
    end,
    Create.text{
        text="there is no code",
        font_family=HELVETICA,
        font_size=inch(0.8),
        text_alignment=Enum.TextAlignment.TopMiddle,
        on_init=function (self)
            self.text_color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(0,inch(1))
            self.position = UDim2.new(pct(50),pct(50) + inch(1.5))
            self.anchor = Vec2.new(0.5,1)
        end,
        update=function(self)
            local info = LAUNCHER:get_process_info()

            self.text = info.stage
        end
    },
    Create.text{
        text="Please enter this code on this website to login.",
        font_family=HELVETICA,
        text_alignment=Enum.TextAlignment.Middle,
        font_size=inch(0.4),
        on_init=function (self)
            self.text_color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(4),inch(3))
            self.position = UDim2.new(pct(50),pct(50))
            self.anchor = Vec2.new(0.5,0.5)
        end,
        update=function(self)
            local info = LAUNCHER:get_process_info()

            self.text = info.description
        end
    },
    Create.text{
        text="there is no uri",
        font_family=HELVETICA,
        font_size=inch(0.6),
        text_alignment=Enum.TextAlignment.BottomMiddle,
        interactable=true,
        on_init=function (self)
            self.text_color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(1),inch(1))
            self.position = UDim2.new(pct(50),pct(50) - inch(1.5))
            self.anchor = Vec2.new(0.5,0)
        end,
        on_click=function (self)
            LAUNCHER:open_sign_in_url()
        end
    },
    Create.quad{
        on_init=function (self)
            self.color = Color.from_rgb_255(150,150,150)
            self.scale = UDim2.new(inch(4),inch(3))
            self.position = UDim2.new(pct(50),pct(50))
            self.anchor = Vec2.new(0.5,0.5)
        end
    },
    Create.text{
        text="back",
        font_family=HELVETICA,
        font_size=inch(0.2),
        interactable=true,
        on_init=function (self)
            self.text_color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(1),inch(1))
            self.position = UDim2.new(pct(5),pct(5))
            self.anchor = Vec2.new(0.5,0)
        end,
        on_click=function (self)
            LAUNCHER:stop_active_process()
            load_screen("account_select")
        end
    },
}
