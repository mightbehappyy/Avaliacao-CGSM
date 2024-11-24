local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 5
local narration = audio.loadStream("assets/page5.mp3")
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
        text = "Os cromossomos são estruturas formadas por DNA e proteínas, formando a cromatina. Em células eucariontes, são lineares e localizados no núcleo, enquanto em procariontes, são circulares. Durante a divisão celular, a cromatina se condensa em cromossomos visíveis, especialmente na metáfase. Cada cromossomo possui um centrômero, que conecta cromátides irmãs, e classifica-os como metacêntricos, submetacêntricos, acrocêntricos ou telocêntricos, dependendo da posição do centrômero. As extremidades, chamadas telômeros, protegem o DNA e evitam a degradação. Os humanos têm 46 cromossomos em células somáticas (diploides) e 23 em células sexuais (haploides), fundamentais para a fertilização e estabilidade do número cromossômico.",
        x = 380,
        y = 270, 
        width = 720, 
        font = native.systemFont, 
        fontSize = 25    
    })
    title:setFillColor(0, 0, 0)

    
    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Cromossomos",
        x = 380,
        y = 10  , 
        width = 720, 
        font = native.systemFont, 
        fontSize = 39  
    })
    infoText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Mova seu dispositivo para visualizar o cromossomo da celula eucarioente a seguir, aproxime-se para examinar a estrutura do cromossomo detalhadamente.",
        x = 350,
        y = 575, 
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
        currentPage = 5
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
