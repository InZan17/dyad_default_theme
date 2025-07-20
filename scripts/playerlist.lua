return Create.list{
    scale = UDim2.new(pct(100), pct(100)),
    child_size = UDim2.new(pct(100), inch(1)),
    color = Color.from_rgb(0.6,0.6,0.6),
    on_init=function(self)
        for i, account in ipairs(account_manager:get_available_accounts()) do
            Create.frame{
                Create.quad{
                    scale=UDim2.new(pct(100), pct(100)),
                    on_init=function(self)
                        self.texture = account.skin
                    end
                },
                Create.text{
                    scale=UDim2.new(pct(100), pct(100)),
                    text_alignment =  Enum.TextAlignment.MiddleLeft,
                    text = "Username: "..account.username.."\nuuid: "..account.uuid,
                }
            }.parent = self
        end
    end
}