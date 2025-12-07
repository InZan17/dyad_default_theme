local frame = Create.frame{
    scale=UDim2.new(rel(0.5), rel(0.5)),
    Create.text_label{
        scale=UDim2.new(rel(0.5), rel(0.5)),
        init=function(self)
            self.text_scaling = Enum.TextScaling.Fit
            self:put_center()
        end
    }
}

return frame