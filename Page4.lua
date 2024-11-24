local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 4
local narration = audio.loadStream("assets/page4.mp3")
local audioHandler

local function updatePageText()
    if myText then
        myText.text = " " .. currentPage
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
    
    local title = display.newText({
        parent = sceneGroup, 
        text = "O mapeamento genético é um exame que analisa a sequência do DNA, permitindo entender como os genes funcionam e como mutações podem afetar a saúde. Esse processo envolve a coleta de uma amostra de sangue ou saliva, a partir da qual o DNA é isolado e sequenciado. Através desse mapeamento, os médicos conseguem identificar mutações que aumentam o risco de doenças, especialmente o câncer hereditário.",
        x = 380,
        y = 250, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    title:setFillColor(0, 0, 0)

    
    local infoText = display.newText({
        parent = sceneGroup, 
        text = "O que é o mapeamento genético e qual a sua importância?",
        x = 380,
        y = 50, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 39  
    })
    infoText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Arraste as partes faltantes da sequência de DNA para os espaços em branco para completá-la corretamente. Tente encontrar uma sequência que não indique uma mutação",
        x = 380,
        y = 450, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    infoText:setFillColor(0, 0, 0)
    

    myText = display.newText(sceneGroup, " " .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)


    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page5", {
            effect = "flip",
            time = 300,
        })
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page3", {
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
        currentPage = 4 
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
