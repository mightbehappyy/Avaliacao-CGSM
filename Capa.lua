-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local composer = require("composer")

local scene = composer.newScene()
local narration = audio.loadStream("assets/capa.mp3")
local audioHandler
local muteText

local function toggleMute()
    local isMuted = composer.getVariable("isMuted") or false
    isMuted = not isMuted
    composer.setVariable("isMuted", isMuted)

    if isMuted then
        audio.setVolume(0, {channel = musicChannel})
        soundBt.fill = {type = "image", filename = "assets/mute-icon.png"}
        muteText.text = "Ligar áudio"
    else
        audio.setVolume(1, {channel = musicChannel})
        soundBt.fill = {type = "image", filename = "assets/sound-icon.png"}
        muteText.text = "Desligar áudio"
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    audioHandler = audio.play(narration)

    -- Set up background
    local bg = display.newImage(sceneGroup, "assets/cover.png")
    bg.x = 385
    bg.y = 550
    bg.height = 1120

    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    btNxt.x = display.contentWidth - 135
    btNxt.y = display.contentHeight - 80
    btNxt.height = 100
    btNxt.width = 245

    soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.x = display.contentCenterX
    soundBt.y = 920
    soundBt.height = 50
    soundBt.width = 50
    soundBt:addEventListener("tap", toggleMute)

    muteText = display.newText({
        parent = sceneGroup, 
        text = "Desligar áudio",
        x = display.contentCenterX,
        y = 950,  
        font = native.systemFont, 
        fontSize = 25    
    })
    muteText:setFillColor(0, 0, 0)
    

    -- Add listener for "Next" button
    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page2", {
            effect = "flip",
            time = 300
        })
    end)

    -- Adjust "Next" button dimensions
    btNxt.height = 100
    btNxt.width = 250
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        local isMuted = composer.getVariable("isMuted") or false
        if isMuted then
            audio.setVolume(0, {channel = musicChannel})
            soundBt.fill = {type = "image", filename = "assets/mute-icon.png"}
            muteText.text = "Ligar áudio"
        else
            audio.setVolume(1, {channel = musicChannel})
            soundBt.fill = {type = "image", filename = "assets/sound-icon.png"}
            muteText.text = "Desligar áudio"
        end
        
        if not audio.isChannelActive(1) then
            narration = audio.loadStream("assets/capa.mp3")
            musicChannel = audio.play(narration, {loops = 0, channel = 1})
        end
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
    end
end

-- hide()
function scene:hide(event)
    if event.phase == "will" then
        if audio.isChannelActive(1) then
            audio.stop(1)
        end
    end
end


-- destroy()
function scene:destroy(event)
    if narration then
        audio.dispose(narration)
        narration = nil
        audio.stop(1)
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
