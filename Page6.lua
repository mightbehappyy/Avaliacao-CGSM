local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 6
local narration = audio.loadStream("assets/pag6.mp3")
local audioHandler
local muteText
local soundBt
local gen1
local gen2
local crossed_gen1, crossed_gen2
local crossingOverActive = false

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

-- Function to check if two objects collide
local function checkCollision(obj1, obj2)
    -- Simple collision check using bounding box
    if obj1.x < obj2.x + obj2.width and obj1.x + obj1.width > obj2.x and
       obj1.y < obj2.y + obj2.height and obj1.y + obj1.height > obj2.y then
        return true
    end
    return false
end

local function moveChromosomes()

    transition.to(gen1, {x = gen1.x + 250, time = 3000, onComplete = function()
        
    end})


    transition.to(gen2, {x = gen2.x - 250, time = 3000, onComplete = function()
        
    end})
end

local function moveChromosomesAway()
    transition.to(crossed_gen1, {x = crossed_gen1.x - 250, time = 3000, onComplete = function()
        
    end})

    transition.to(crossed_gen2, {x = crossed_gen1.x + 250, time = 3000, onComplete = function()
        
    end})
end

local function handleChromosomeCollision()

    if checkCollision(gen1, gen2) and not crossingOverActive then

        gen1.isVisible = false
        gen2.isVisible = false


        crossed_gen1.isVisible = true
        crossed_gen2.isVisible = true


        crossingOverActive = true
        moveChromosomesAway()
    end
end

local function onEnterFrame(event)
    handleChromosomeCollision()
end



local function startChromosomeMovement()
    moveChromosomes() 
end


local function handleCrossingOver()
    if not crossingOverActive then

        crossed_gen1.isVisible = true
        crossed_gen2.isVisible = true
        gen1.isVisible = false
        gen2.isVisible = false
        crossingOverActive = true 
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Audio and background
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

    muteText = display.newText({
        parent = sceneGroup,
        text = "Desligar áudio",
        x = display.contentCenterX,
        y = 950,
        font = native.systemFont,
        fontSize = 25
    })
    muteText:setFillColor(0, 0, 0)

    -- Buttons for navigation
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
    
    -- Initialize chromosome images and set visibility
    crossed_gen1 = display.newImage(sceneGroup, "assets/crossed_cromo1.png")
    crossed_gen2 = display.newImage(sceneGroup, "assets/crossed_cromo2.png")
    crossed_gen1.isVisible = false
    crossed_gen2.isVisible = false
    crossed_gen1.x = display.contentCenterY - 150
    crossed_gen1.y = display.contentCenterY + 200
    crossed_gen1.width = crossed_gen1.width * 0.7
    crossed_gen1.height = crossed_gen1.height * 0.7

    crossed_gen2.x = display.contentCenterX + 50
    crossed_gen2.y = display.contentCenterY + 196   
    crossed_gen2.width = crossed_gen2.width * 0.7
    crossed_gen2.height = crossed_gen2.height * 0.7

    -- Initialize chromosome positions
    gen1 = display.newImage(sceneGroup, "assets/uncrossed_cromo1.png")
    gen2 = display.newImage(sceneGroup, "assets/uncrossed_cromo2.png")
    gen1.x = display.contentCenterX - 250
    gen1.y = display.contentCenterY + 200
    gen1.width = gen1.width * 0.7
    gen1.height = gen1.height * 0.7

    gen2.x = display.contentCenterX + 230
    gen2.y = display.contentCenterY + 200
    gen2.width = gen2.width * 0.7
    gen2.height = gen2.height * 0.7

    
    soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.height = 50
    soundBt.width = 50
    soundBt.y = 900
    soundBt.x = display.contentCenterX
    soundBt:addEventListener("tap", toggleMute)

    
    local crossingover = display.newImage(sceneGroup, "assets/crossingover.png")
    crossingover.x = display.contentCenterX
    crossingover.y = display.contentCenterY + 50
    crossingover.width = crossingover.width * 0.5 
    crossingover.height = crossingover.height * 0.5
    crossingover:addEventListener("tap", startChromosomeMovement)

    -- Page text and title
    myText = display.newText(sceneGroup, "" .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)
    
    local title = display.newText({
        parent = sceneGroup, 
        text = "O crossing over ocorre na prófase I da meiose, onde segmentos de cromátides não irmãs trocam partes entre cromossomos homólogos. Esse processo é essencial para a recombinação genética, aumentando a diversidade nas células descendentes. A troca de segmentos resulta em novas combinações de alelos, contribuindo para a variabilidade genética. Essa variabilidade é vantajosa, pois gera indivíduos com características únicas que podem ser mais bem adaptados ao ambiente, desempenhando um papel fundamental na evolução das espécies. O crossing over permite que genes que estavam inicialmente ligados se separem, resultando em gametas com diferentes combinações genéticas. Portanto, o crossing over é um mecanismo crucial para a diversidade genética e a adaptação das populações.",
        x = 410,
        y = 270, 
        width = 720, 
        font = native.systemFont, 
        fontSize = 25    
    })
    title:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Crossing over",
        x = 410,
        y = 10, 
        width = 700, 
        font = native.systemFont, 
        fontSize = 39  
    })
    infoText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "A seguir uma representação visual do que ocorre no crossing over",
        x = 370,
        y = 525, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    infoText:setFillColor(0, 0, 0)

    -- Navigation buttons
    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("ContraCapa", {effect = "flip", time = 300})
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page5", {effect = "flip", time = 300})
    end)

    
    -- Add enter frame listener for collision detection
    Runtime:addEventListener("enterFrame", onEnterFrame)
end

local function resetPageState()
    
    gen1.x = display.contentCenterX - 250
    gen1.y = display.contentCenterY + 200
    gen1.isVisible = true

    gen2.x = display.contentCenterX + 230
    gen2.y = display.contentCenterY + 200
    gen2.isVisible = true

    crossed_gen1.isVisible = false
    crossed_gen2.isVisible = false

    crossed_gen1.x = display.contentCenterY - 150
    crossed_gen1.y = display.contentCenterY + 200

    crossed_gen2.x = display.contentCenterX + 50
    crossed_gen2.y = display.contentCenterY + 196   
    
    
    crossingOverActive = false

    
end



function scene:hide(event)
    if event.phase == "will" then
        if audio.isChannelActive(1) then
            audio.stop(1)
        end
        resetPageState()
    end
end

function scene:show(event)
    if event.phase == "did" then
        currentPage = 6
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
            narration = audio.loadStream("assets/pag6.mp3")
            musicChannel = audio.play(narration, {loops = 0, channel = 1})
        end
    end
end

function scene:destroy(event)
    if narration then
        audio.dispose(narration)
        narration = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
