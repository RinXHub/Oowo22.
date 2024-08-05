getgenv().AttackedCount = getgenv().AttackedCount or 0
spawn(
    function()
        local MT = getrawmetatable(game)
        local OldNameCall = MT.__namecall
        setreadonly(MT, false)
        MT.__namecall =
            newcclosure(
            function(self, ...)
                local Method = getnamecallmethod()
                local Args = {...}
                pcall(
                    function()
                        if Method == "FireServer" and self.Name == "RigControllerEvent" and Args[1] == "hit" then
                            getgenv().AttackedCount = getgenv().AttackedCount + 1
                        end
                    end
                )
                return OldNameCall(self, unpack(Args))
            end
        )
    end
)
jg = {}
function jg:GetCount()
    return getgenv().AttackedCount
end
return jg