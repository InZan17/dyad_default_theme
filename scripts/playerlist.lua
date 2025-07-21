return Create.list{
    scale = UDim2.new(pct(100), pct(100)),
    child_size = UDim2.new(pct(100), inch(0.75)),
    color = Color.from_rgb(0.6,0.6,0.6),
    on_init=function(self)
        for i, account in ipairs(account_manager:get_available_accounts()) do
            Create.frame{
                create_player_head(account.skin, {
                    scale=UDim2.new(inch(0.75), inch(0.75)),
                    position=UDim2.new(inch(0.1), 0),
                }),
                Create.text{
                    scale=UDim2.new(pct(100) - inch(1), pct(100)),
                    position=UDim2.new(pct(100), 0),
                    anchor=Vec2.new(1, 0),
                    font_size = inch(0.2),
                    text_alignment =  Enum.TextAlignment.MiddleLeft,
                    text = "Username: "..account.username.."\nuuid: "..account.uuid,
                }
            }.parent = self
        end
    end
}