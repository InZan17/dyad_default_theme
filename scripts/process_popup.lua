local frame_actor = Create.frame{
    on_hover=function(this: FrameActor)
    end,
    Create.frame{
    }
}


local a = frame_actor[1]

frame_actor:early_update()

if input.char_events[1]["repeat"] then
print("hi")
end
