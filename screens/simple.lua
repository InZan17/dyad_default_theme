local frame = Create.frame{
    scale=UDim2.new(rel(0.5), rel(0.5)),
    Create.text{
        scale=UDim2.new(rel(0.5), rel(0.5)),
        on_init=function(self)
            self.text_scaling = Enum.TextScaling.Fit
            self:put_center()
        end
    },
    Create.quad{
        scale=UDim2.new(rel(0.5), rel(0.5)),
        on_init=function(self)
            self:put_center()
        end
    }
}

return frame