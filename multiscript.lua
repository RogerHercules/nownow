-- กลุ่มของผู้ใช้ที่ได้รับอนุญาต
group1 = _G.Name1
group2 = _G.Name2
group3 = _G.Name3
group4 = _G.Name4
group5 = _G.Name5

-- ชื่อกลุ่มสำหรับแสดงใน UI
local groupNames = {
    "1", -- ชื่อสำหรับกลุ่ม 1
    "2", -- ชื่อสำหรับกลุ่ม 2
    "3", -- ชื่อสำหรับกลุ่ม 3
    "4", -- ชื่อสำหรับกลุ่ม 4
    "5" -- ชื่อสำหรับกลุ่ม 5
}

-- รับชื่อผู้เล่นปัจจุบัน
local playerName = game.Players.LocalPlayer.Name
local playerGroup = nil
local groupNumber = 0

-- ฟังก์ชั่นตรวจสอบว่าผู้เล่นอยู่ในกลุ่มที่กำหนดหรือไม่
local function isInGroup(username, group)
    for _, name in pairs(group) do
        if username == name then
            return true
        end
    end
    return false
end

local function createGroupUI(groupName, groupNum)
    -- สร้าง UI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GroupDisplayUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- สร้างเฟรมหลัก
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 150, 0, 70)
    mainFrame.Position = UDim2.new(0.5, -30, 0, 10) -- ขยับขวานิดหน่อยและขึ้นไปด้านบน
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- เพิ่มความโค้งให้มุมเฟรม
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame
    
    -- เส้นขอบชั้นนอก (แสงฟุ้ง)
    local uiStrokeOuter = Instance.new("UIStroke")
    uiStrokeOuter.Thickness = 10 -- ขอบหนากว่าสำหรับเอฟเฟกต์ฟุ้ง
    uiStrokeOuter.Transparency = 1 -- โปร่งแสงเพื่อดูฟุ้ง
    uiStrokeOuter.Parent = mainFrame
    
    -- เส้นขอบชั้นใน (สีรุ้งหลัก)
    local uiStrokeInner = Instance.new("UIStroke")
    uiStrokeInner.Thickness = 2 -- ขอบปกติ
    uiStrokeInner.Transparency = 6 -- ทึบแสง
    uiStrokeInner.Parent = mainFrame
    
    -- สร้างป้ายกลุ่ม
    local groupLabel = Instance.new("TextLabel")
    groupLabel.Name = "GroupLabel"
    groupLabel.Size = UDim2.new(1, 0, 0, 25)
    groupLabel.Position = UDim2.new(0, 0, 0, 5)
    groupLabel.BackgroundTransparency = 1
    groupLabel.Text = "GROUP"
    groupLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    groupLabel.Font = Enum.Font.GothamBold
    groupLabel.TextSize = 14
    groupLabel.Parent = mainFrame
    
    -- สร้างป้ายชื่อกลุ่ม
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 30)
    nameLabel.Position = UDim2.new(0, 0, 0, 25)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = groupName
    nameLabel.TextColor3 = groupNum == 1 and Color3.fromRGB(255, 215, 0) or 
                          groupNum == 2 and Color3.fromRGB(0, 191, 255) or 
                          groupNum == 3 and Color3.fromRGB(255, 26, 0) or 
                          groupNum == 4 and Color3.fromRGB(0, 191, 255) or 
                          Color3.fromRGB(0, 255, 153)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 18
    nameLabel.Parent = mainFrame
    
    -- เพิ่มเอฟเฟกต์การเคลื่อนไหวและสีรุ้ง
    local function animateUI()
        -- แอนิเมชันเคลื่อนเข้ามา
        for i = 1, 10 do
            mainFrame.Position = UDim2.new(0.5, -30 - i*5, 0, 10)
            task.wait(0.01)
        end
        
        task.wait(0.5)
        
        -- ลูปสีรุ้ง
        local hue = 0
        while true do
            hue = (hue + 0.02) % 1 -- ปรับความเร็วสีรุ้ง
            local color = Color3.fromHSV(hue, 1, 1) -- สร้างสีรุ้งด้วย HSV
            uiStrokeInner.Color = color -- ขอบชั้นใน
            uiStrokeOuter.Color = color -- ขอบชั้นนอก (ฟุ้ง)
            task.wait(0.05) -- ความเร็วการเปลี่ยนสี
        end
    end
    
    -- เริ่มเอฟเฟกต์
    coroutine.wrap(animateUI)()
    
    return screenGui
end

-- ตรวจสอบว่าผู้เล่นอยู่ในกลุ่มไหน
if isInGroup(playerName, group1) then
    -- เก็บข้อมูลกลุ่ม
    playerGroup = groupNames[1]
    groupNumber = 1
    
    -- รันสคริปต์สำหรับกลุ่ม 1
    print("คุณอยู่ในกลุ่มที่ 1: " .. playerGroup .. " กำลังโหลดสคริปต์...")
    loadstring(game:HttpGet(_G.scriptlua1[1]))()
    
elseif isInGroup(playerName, group2) then
    -- เก็บข้อมูลกลุ่ม
    playerGroup = groupNames[2]
    groupNumber = 2
    
    -- รันสคริปต์สำหรับกลุ่ม 2
    print("คุณอยู่ในกลุ่มที่ 2: " .. playerGroup .. " กำลังโหลดสคริปต์...")
    loadstring(game:HttpGet(_G.scriptlua1[2]))()

elseif isInGroup(playerName, group3) then
    -- เก็บข้อมูลกลุ่ม
    playerGroup = groupNames[3]
    groupNumber = 3
    
    -- รันสคริปต์สำหรับกลุ่ม 3
    print("คุณอยู่ในกลุ่มที่ 3: " .. playerGroup .. " กำลังโหลดสคริปต์...")
    loadstring(game:HttpGet(_G.scriptlua1[3]))()

elseif isInGroup(playerName, group4) then
    -- เก็บข้อมูลกลุ่ม
    playerGroup = groupNames[4]
    groupNumber = 4
    
    -- รันสคริปต์สำหรับกลุ่ม 4
    print("คุณอยู่ในกลุ่มที่ 4: " .. playerGroup .. " กำลังโหลดสคริปต์...")
    loadstring(game:HttpGet(_G.scriptlua1[4]))()

elseif isInGroup(playerName, group5) then
    -- เก็บข้อมูลกลุ่ม
    playerGroup = groupNames[5]
    groupNumber = 5
    
    -- รันสคริปต์สำหรับกลุ่ม 5
    print("คุณอยู่ในกลุ่มที่ 5: " .. playerGroup .. " กำลังโหลดสคริปต์...")
    loadstring(game:HttpGet(_G.scriptlua1[5]))()
    
else
    -- ถ้าไม่ได้อยู่ในกลุ่มไหนเลย
    print("ชื่อผู้ใช้ไม่ได้รับอนุญาต: " .. playerName)
    game.Players.LocalPlayer:Kick("คุณไม่ได้รับอนุญาตให้ใช้สคริปต์นี้")
end

-- สร้าง UI แสดงกลุ่มถ้าผู้เล่นได้รับอนุญาต
if playerGroup then
    createGroupUI(playerGroup, groupNumber)
    
    -- แสดงข้อความยืนยันการเริ่มทำงานของสคริปต์
    local notification = Instance.new("ScreenGui")
    notification.Name = "ExecutionNotification"
    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 50)
    frame.Position = UDim2.new(0.5, -125, 0.8, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = notification
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Text = "สคริปต์สำหรับกลุ่ม " .. playerGroup .. " เริ่มทำงานแล้ว!"
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.BackgroundTransparency = 1
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.Parent = frame
    
    -- ให้แจ้งเตือนหายไปหลังจาก 3 วินาที
    task.delay(3, function()
        notification:Destroy()
    end)
end
