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
local muteText

-- Update page text
local function updatePageText()
    if myText then
        myText.text = "" .. currentPage
    end
end


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

-- Create the scene
function scene:create(event)
    local sceneGroup = self.view

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
    bg.x = 385
    bg.y = 550


    
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

    muteText = display.newText({
        parent = sceneGroup, 
        text = "Desligar áudio",
        x = display.contentCenterX,
        y = 950,  
        font = native.systemFont, 
        fontSize = 25    
    })
    muteText:setFillColor(0, 0, 0)
    
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
    soundBt.x = display.contentCenterX
    soundBt.y = 920
    soundBt.height = 50
    soundBt.width = 50
    soundBt:addEventListener("tap", toggleMute)

    
    btNxt:addEventListener("tap", function()
        composer.gotoScene("Page3", {effect = "flip", time = 300})
    end)
    btPrev:addEventListener("tap", function()
        composer.gotoScene("Capa", {effect = "flip", time = 300})
    end)
end

function scene:hide(event)
    if event.phase == "will" then
        if audio.isChannelActive(1) then
            audio.stop(1)
        end
    end
end


function scene:show(event)
    if event.phase == "did" then
        currentPage = 2 
        updatePageText()
        
        
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
            narration = audio.loadStream("assets/pag2.mp3")
            musicChannel = audio.play(narration, {loops = 0, channel = 1})
        end
    end
end

function scene:destroy(event)
    if narration then
        audio.dispose(narration)
        narration = nil
        audio.stop(1)
    end
end


-- Scene Listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
