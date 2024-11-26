local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 5
local narration = audio.loadStream("assets/pag5.mp3")
local audioHandler
local soundBt
local muteText
local lens
local cell, chromosome, gene
local imageType = "cell" 
local movementLimit = 400
local lens

local function updatePageText()
    if myText then
        myText.text = " " .. currentPage
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

-- create()
function scene:create(event)
    local sceneGroup = self.view
    
    audioHandler = audio.play(narration)

    local bg = display.newImage(sceneGroup, "assets/background.png")
    
    bg.fill.effect = "filter.blurGaussian"
    
    bg.fill.effect.horizontal.blurSize = 5
    bg.fill.effect.horizontal.sigma = 30
    bg.fill.effect.vertical.blurSize = 5
    bg.fill.effect.vertical.sigma = 30

    bg.x = 383
    bg.y = 500 
    bg.height = 1120

    soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.x = display.contentCenterX
    soundBt.y = 900
    soundBt.height = 50
    soundBt.width = 50
    soundBt:addEventListener("tap", toggleMute)

    muteText = display.newText({
        parent = sceneGroup, 
        text = "Desligar áudio",
        x = display.contentCenterX,
        y = 940,  
        font = native.systemFont, 
        fontSize = 25    
    })
    muteText:setFillColor(0, 0, 0)

    local cell = display.newImage(sceneGroup, "assets/cell.png")
    cell.x = display.contentCenterX + 40
    cell.y = display.contentCenterY + 200
    cell.width = cell.width * 0.4
    cell.height = cell.height * 0.4

    lens = display.newImage(sceneGroup, "assets/lens.png")
    lens.x = display.contentCenterX
    lens.y = display.contentCenterY + 210
    lens.width = lens.width * 0.65
    lens.height = lens.height * 0.65

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
    
    
    local title = display.newText({
        parent = sceneGroup, 
        text = "Os cromossomos são estruturas formadas por DNA e proteínas, formando a cromatina. Em células eucariontes, são lineares e localizados no núcleo, enquanto em procariontes, são circulares. Durante a divisão celular, a cromatina se condensa em cromossomos visíveis, especialmente na metáfase. Cada cromossomo possui um centrômero, que conecta cromátides irmãs, e classifica-os como metacêntricos, submetacêntricos, acrocêntricos ou telocêntricos, dependendo da posição do centrômero. As extremidades, chamadas telômeros, protegem o DNA e evitam a degradação. Os humanos têm 46 cromossomos em células somáticas (diploides) e 23 em células sexuais (haploides), fundamentais para a fertilização e estabilidade do número cromossômico.",
        x = 390,
        y = 275, 
        width = 720, 
        font = native.systemFont, 
        fontSize = 25    
    })
    title:setFillColor(0, 0, 0)

    
    local title = display.newText({
        parent = sceneGroup, 
        text = "Cromossomos",
        x = 600,
        y = 40  , 
        width = 720, 
        font = native.systemFont, 
        fontSize = 39  
    })
    title:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Mova seu dispositivo para visualizar o cromossomo da celula eucarioente a seguir, aproxime-se para examinar a estrutura do cromossomo detalhadamente.",
        x = 350,
        y = 520, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    infoText:setFillColor(0, 0, 0)
    
    myText = display.newText(sceneGroup, " " .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)

    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page6", {
            effect = "flip",
            time = 300,
        })
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page4", {
            effect = "flip",
            time = 300
        })
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
        currentPage = 5
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
            narration = audio.loadStream("assets/pag5.mp3")
            musicChannel = audio.play(narration, {loops = 0, channel = 1})
        end
    end
end

function scene:destroy(event)
    -- Dispose of the narration audio to free memory
    if narration then
        audio.dispose(narration)
        narration = nil
    end
end

-- Scene event function listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
