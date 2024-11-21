local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 2  


local function updatePageText()
    if myText then
        myText.text = "" .. currentPage
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

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
    
    title = display.newText(sceneGroup, "O que é DNA?", 250, 50, native.systemFont, 60)
    title:setFillColor(0, 0, 0)
    
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


    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Faça o gesto de pinça sobre João para ampliar a imagem e revelar o DNA de joão.",
        x = 380,
        y = 450, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 25    
    })
    infoText:setFillColor(0, 0, 0)
    
    local personImage = display.newImage(sceneGroup, "assets/joao.png")
    personImage.height = 800
    personImage.width = 400
    personImage.y = 600
    personImage.x = display.contentCenterX

    local arrowAndText = display.newText(sceneGroup, "<  João", 500, 700, native.systemFont, 40)
    arrowAndText:setFillColor(0, 0, 0)

    myText = display.newText(sceneGroup, " " .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)


    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page3", {
            effect = "flip",
            time = 300,
        })
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Capa", {
            effect = "flip",
            time = 300
        })
    end)

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
        currentPage = 2
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
