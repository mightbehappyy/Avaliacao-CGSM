local composer = require("composer")
local scene = composer.newScene()

local currentPage = 2
local myText
local personImage
local instructionText
local isScaled = false
local musicChannel
local soundBt
local narration = audio.loadStream("assets/pag2.mp3")
local audioHandler

-- Update page text
local function updatePageText()
    if myText then
        myText.text = "" .. currentPage
    end
end

-- Toggle mute state
local function toggleMute()
    local isMuted = composer.getVariable("isMuted") or false
    isMuted = not isMuted
    composer.setVariable("isMuted", isMuted)
    
    if isMuted then
        audio.setVolume(0, {channel = musicChannel})
        soundBt.fill = {type = "image", filename = "assets/mute-icon.png"}
    else
        audio.setVolume(1, {channel = musicChannel})
        soundBt.fill = {type = "image", filename = "assets/sound-icon.png"}
    end
end

-- Create the scene
function scene:create(event)
    local sceneGroup = self.view

    
    system.activate("multitouch")
    audioHandler = audio.play(narration)
    
    local bg = display.newImage(sceneGroup, "assets/background.png")
    bg.fill.effect = "filter.blurGaussian"
    bg.fill.effect.horizontal.blurSize = 5
    bg.fill.effect.horizontal.sigma = 30
    bg.fill.effect.vertical.blurSize = 5
    bg.fill.effect.vertical.sigma = 30
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg.height = 1120

    
    local btPrev = display.newImage(sceneGroup, "assets/previous.png")
    btPrev.x = 135
    btPrev.y = display.contentHeight - 80
    btPrev.height = 100
    btPrev.width = 250

    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    btNxt.x = display.contentWidth - 135
    btNxt.y = display.contentHeight - 80
    btNxt.height = 100
    btNxt.width = 245

    
    local title = display.newText(sceneGroup, "O que é DNA?", display.contentCenterX, 50, native.systemFont, 60)
    title:setFillColor(0, 0, 0)

    
    instructionText = display.newText({
        parent = sceneGroup,
        text = "Faça o gesto de pinça sobre João para ampliar a imagem e revelar o DNA de João.",
        x = display.contentCenterX,
        y = 450,
        width = 650,
        font = native.systemFont,
        fontSize = 25
    })
    instructionText:setFillColor(0, 0, 0)

    
    local infoText = display.newText({
        parent = sceneGroup,
        text = "O DNA (ácido desoxirribonucleico) é uma molécula que carrega a informação genética da maioria dos seres vivos. Ele é composto por nucleotídeos, e em sua forma típica, apresenta-se como uma dupla-hélice. O DNA pode ser encontrado no núcleo das células eucarióticas e em organelas como mitocôndrias e cloroplastos. Nos organismos procariontes, ele está presente no nucleoide.",
        x = 380,
        y = 250,
        width = 650,
        font = native.systemFont,
        fontSize = 25
    })
    infoText:setFillColor(0, 0, 0)

    
    personImage = display.newImage(sceneGroup, "assets/joao.png")
    personImage.x = display.contentCenterX
    personImage.y = 600
    personImage.height = 800
    personImage.width = 400

    
    myText = display.newText(sceneGroup, "" .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)

    
    soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.x = 50
    soundBt.y = 50
    soundBt.height = 50
    soundBt.width = 50
    soundBt:addEventListener("tap", toggleMute)

    -- Button Listeners
    btNxt:addEventListener("tap", function()
        composer.gotoScene("Page3", {effect = "flip", time = 300})
    end)
    btPrev:addEventListener("tap", function()
        composer.gotoScene("Capa", {effect = "flip", time = 300})
    end)
end

-- Show the scene
function scene:show(event)
    if event.phase == "did" then
        currentPage = 2
        updatePageText()

    
        -- Set Mute State
        local isMuted = composer.getVariable("isMuted") or false
        if isMuted then
            audio.setVolume(0, {channel = musicChannel})
            soundBt.fill = {type = "image", filename = "assets/mute-icon.png"}
        else
            audio.setVolume(1, {channel = musicChannel})
            soundBt.fill = {type = "image", filename = "assets/sound-icon.png"}
        end
    end
end

function scene:hide(event)
    if event.phase == "will" then
        
        audio.stop(musicChannel)
    end
end

-- Destroy the scene
function scene:destroy(event)
    if backgroundMusic then
        audio.dispose(backgroundMusic)
        backgroundMusic = nil
    end
end

-- Scene Listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
