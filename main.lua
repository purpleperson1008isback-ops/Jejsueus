-- Standalone Troll Chat Script
task.spawn(function()
    local Players = game:GetService("Players")
    local TextChatService = game:GetService("TextChatService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer

    -- Wait for the player to be fully in-game
    if not game:IsLoaded() then game.Loaded:Wait() end
    task.wait(2) 

    local message = "I am using exploits to farm money because I'm bad at the game! Please report me!"

    -- Attempt to send via Modern TextChatService
    local rbxGeneral = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if rbxGeneral then
        rbxGeneral:SendAsync(message)
    end

    -- Attempt to send via Legacy Chat system
    local sayMessage = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
    if sayMessage then
        sayMessage:FireServer(message, "All")
    end
end)
