local PLUGIN = PLUGIN
PLUGIN.name = "HealthBarEnhanced"
PLUGIN.author = "cheerio1521"
PLUGIN.description = "Just adds a Health Bar that looks decent, you don't have to credit me if your going to modify it or use it."

surface.CreateFont("HUD_Font", {
    font = "Arial",
    size = 24,
    weight = 800,
    antialias = true
})

function PLUGIN:HUDShouldDraw(name)
    local block = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
    }

    if (block[name]) then
        return false
    end
end

local smoothHealth = 100

function PLUGIN:HUDPaint()
    local client = LocalPlayer()
    if not client:Alive() then return end

    local health = math.max(client:Health(), 0)
    local maxHealth = client:GetMaxHealth()
    smoothHealth = Lerp(0.1, smoothHealth, health)

    local healthPercent = math.Clamp(smoothHealth / maxHealth, 0, 1)

    local x, y = 20, 20
    local width, height = 250, 30

    local healthColor = Color(255 * (1 - healthPercent), 255 * healthPercent, 50, 255)

    draw.RoundedBox(10, x - 5, y - 5, width + 10, height + 10, Color(0, 0, 0, 200))

    surface.SetDrawColor(healthColor)
    surface.DrawRect(x, y, width * healthPercent, height)

    draw.SimpleTextOutlined("Health: " .. math.Round(smoothHealth), "HUD_Font", x + width / 2, y + height / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 150))
end


