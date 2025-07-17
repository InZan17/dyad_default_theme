local current_time_unchanged = 0
local current_time = 0
local frames = 0
local current_frames = 0

account_manager:start_sign_in()

return Create.frame{
    on_init=function (self)
    end,

    Create.text{
        text="0 fps",
        font_family=HELVETICA,
        text_alignment=Enum.TextAlignment.TopLeft,
        font_size=px(18),
        on_init=function (self)
            self.scale = UDim2.new(pct(100) - px(8), pct(100) - px(8))
            self.color = Color.from_rgb_255(255,255,255)
            self.anchor = Vec2.new(1,0)
            self.position = UDim2.new(pct(100),0)
        end,
        update=function(self)
            current_time = current_time + delta_time
            current_time_unchanged = current_time_unchanged + delta_time
            frames = frames + 1
            
            if current_time > 1 then
                current_frames = frames
                current_time = current_time - 1
                frames = 0
            end
            
            self.text = (tostring(current_frames).." FPS\n"..tostring(current_time_unchanged).." seconds since screen was loaded.")
        end
    },
    Create.text{
        text="there is no code",
        font_family=HELVETICA,
        font_size=inch(0.8),
        text_alignment=Enum.TextAlignment.TopMiddle,
        on_init=function (self)
            self.color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(0,inch(1))
            self.position = UDim2.new(pct(50),pct(50) + inch(1.5))
            self.anchor = Vec2.new(0.5,1)
        end,
        update=function(self)
            local status = account_manager:get_auth_status()

            self.text = status.status
        end
    },
    Create.text{
        text="Please enter this code on this website to login.",
        font_family=HELVETICA,
        text_alignment=Enum.TextAlignment.Middle,
        font_size=inch(0.4),
        on_init=function (self)
            self.color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(4),inch(3))
            self.position = UDim2.new(pct(50),pct(50))
            self.anchor = Vec2.new(0.5,0.5)
        end,
        update=function(self)
            local status = account_manager:get_auth_status()

            self.text = status.description
        end
    },
    Create.text{
        text="there is no uri",
        font_family=HELVETICA,
        font_size=inch(0.6),
        text_alignment=Enum.TextAlignment.BottomMiddle,
        interactable=true,
        on_init=function (self)
            self.color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(1),inch(1))
            self.position = UDim2.new(pct(50),pct(50) - inch(1.5))
            self.anchor = Vec2.new(0.5,0)
        end,
        on_click=function (self)
            account_manager:open_auth_url()
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
        text="bakc",
        font_family=HELVETICA,
        font_size=inch(0.2),
        interactable=true,
        on_init=function (self)
            self.color = Color.from_rgb_255(255,255,255)
            self.scale = UDim2.new(inch(1),inch(1))
            self.position = UDim2.new(pct(5),pct(5))
            self.anchor = Vec2.new(0.5,0)
        end,
        on_click=function (self)
            load_screen("init")
        end
    },
}
