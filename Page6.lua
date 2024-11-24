local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 6
local narration = audio.loadStream("assets/page6.mp3")
local audioHandler

local function updatePageText()
    if myText then
        myText.text = "" .. currentPage
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

    local btPrev = display.newImage(sceneGroup, "assets/previous.png")
    local btprevPadding = (btPrev.height + btPrev.width) / 6
    btPrev.x = 0 + btprevPadding
    btPrev.y = display.contentHeight - btprevPadding
    
    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    btNxt.x = display.contentWidth - btNxt.width + 100
    btNxt.y = display.contentHeight - btprevPadding + 20
    
    local soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.height = 25
    soundBt.width = 25
    soundBt.y = 0
    soundBt.x = soundBt.width

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
        y = 10  , 
        width = 700, 
        font = native.systemFont, 
        fontSize = 39  
    })
    infoText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "A seguir uma representação visual do que ocorre no crossing over",
        x = 385,
        y = 575, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    infoText:setFillColor(0, 0, 0)

    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("ContraCapa", {
            effect = "flip",
            time = 300,
        })
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page5", {
            effect = "flip",
            time = 300
        })
    end)

    btPrev.x = 0 + btprevPadding
    btPrev.y = display.contentHeight - btprevPadding
    btNxt.height = 100
    btNxt.width = 250


    btPrev.x = btprevPadding
    btPrev.y = display.contentHeight - (btprevPadding)

    btPrev.x = btprevPadding + 80
    btPrev.y = display.contentHeight - (btprevPadding - 20)
    
    btPrev.height = 100
    btPrev.width = 250
    
end

-- show()
function scene:show(event)
    local phase = event.phase
    if phase == "did" then
        currentPage = 6
        updatePageText()  
    end
end

-- hide()
function scene:hide(event)
    local phase = event.phase
    if phase == "will" then

    end
end

-- destroy()
function scene:destroy(event)
 
end

-- Scene event function listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
