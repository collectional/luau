local groupid = 3461453

local n_n = {  
    [5] = true,  
    [7] = true   
}

local x_x = {  
    [5] = "Community Staff",
    [7] = "Moderator"
}

local players = game:GetService("Players")
local gui = game:GetService("StarterGui")
local status = nil

local function detected()
    local mods = {}
    for _, p in ipairs(players:GetPlayers()) do
        local r = p:rr(groupid)
        if n_n[r] then
            table.insert(mods, {name = p.Name, rank = r})
        end
    end
    return mods
end

local function check()
    local mods = detected()
    local mod = #mods > 0

    if mod ~= (status ~= nil and #status > 0) or mod then
        status = mods

        if mod then
            local lines = {}
            for _, m in ipairs(mods) do
                lines[#lines + 1] = "mod detected | " .. m.name .. " " .. x_x[m.rank]
            end

            gui:SetCore("SendNotification", {
                Title = "haha",
                Text = table.concat(lines, "\n"),
                Duration = 5
            })
        else
            gui:SetCore("SendNotification", {
                Title = "haha",
                Text = "no mods detected",
                Duration = 5
            })
        end
    end
end

wait(2)
check()

players.PlayerAdded:Connect(check)
players.PlayerRemoving:Connect(check)
