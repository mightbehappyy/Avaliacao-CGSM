local composer = require("composer")
local widget = require("widget")


local scene = composer.newScene()

local myText
local currentPage = 3


local function updatePageText()
    if myText then
        myText.text = " " .. currentPage
    end
end

local function closeModal()
    if modalGroup then
        modalGroup:removeSelf()
        modalGroup = nil
        isModalVisible = false
    end
end

local function closeConnections()
    if connectionGroup then
        for i = connectionGroup.numChildren, 1, -1 do
            display.remove(connectionGroup[i])
        end
    end
end

local function showModal(infoText)
    if isModalVisible then return end
    isModalVisible = true

    modalGroup = display.newGroup()
    scene.view:insert(modalGroup)

    local modalBackground = display.newRoundedRect(modalGroup, display.contentCenterX, display.contentCenterY, 500, 300, 30)
    modalBackground:setFillColor(0.7, 0.7, 0.7, 0.8)

    local modalText = display.newText({
        parent = modalGroup,
        text = infoText,
        x = display.contentCenterX,
        y = display.contentCenterY - 50,
        width = 450,
        font = native.systemFont,
        fontSize = 20,
        align = "center"
    })
    modalText:setFillColor(0, 0, 0)

    local closeButton = widget.newButton({
        label = "Fechar",
        x = display.contentCenterX,
        y = display.contentCenterY + 100,
        shape = "roundedRect",
        width = 150,
        height = 40,
        cornerRadius = 5,
        fillColor = { default = { 0.2, 0.6, 1 }, over = { 0.2, 0.5, 0.9 } },
        labelColor = { default = { 1, 1, 1 }, over = { 1, 1, 1 } },
        onRelease = closeModal
    })
    modalGroup:insert(closeButton)
end

local function createConnection(x, y, number)
    local lineSpacing = 10
    connectionGroup = display.newGroup()
    scene.view:insert(connectionGroup)

    if number > 2 then
        local connections = display.newImage(connectionGroup, "assets/three_connections.png")
        if not connections then
            print("Error: Image 'three_connections.png' not found!")
            return
        end
        connections.height = 50
        connections.width = 150
        connections.x = x
        connections.y = y
        y = y + 100

        local connections1 = display.newImage(connectionGroup, "assets/three_connections.png")
        if not connections1 then
            print("Error: Image 'three_connections.png' not found!")
            return
        end
        connections1.height = 50
        connections1.width = 150
        connections1.x = x
        connections1.y = y
    else
        
        local connections = display.newImage(connectionGroup, "assets/double_connections.png")
        if not connections then
            print("Error: Image 'three_connections.png' not found!")
            return
        end
        connections.height = 50
        connections.width = 150
        connections.x = x
        connections.y = y
        y = y + 298

        local connections1 = display.newImage(connectionGroup, "assets/double_connections.png")
        if not connections1 then
            print("Error: Image 'three_connections.png' not found!")
            return
        end
        connections1.height = 50
        connections1.width = 150
        connections1.x = x
        connections1.y = y
        
    end
end




local function guanineConnection()
    createConnection(350, 650, 3)
end

local function adenineConnection()
    createConnection(350, 551, 2)
end

local function onGuanineTap(event)
    showModal("A guanina forma três ligações de hidrogênio com a citosina. Essas três ligações são mais fortes do que as duas ligações entre A e T. Isso torna o pareamento G-C mais robusto e contribui para a rigidez estrutural da molécula de DNA.")
    guanineConnection()
end

local function onCytosineTap(event)
    showModal("A guanina forma três ligações de hidrogênio com a citosina. Essas três ligações são mais fortes do que as duas ligações entre A e T. Isso torna o pareamento G-C mais robusto e contribui para a rigidez estrutural da molécula de DNA.")
    guanineConnection()        
end

local function onTemineTap(event)
    showModal("A adenina sempre se pareia com a timina, formando duas ligações de hidrogênio. Essa combinação é fundamental para a estabilidade da estrutura do DNA, mantendo as duas fitas unidas de maneira precisa e complementar.")
    adenineConnection() 
end

local function onAdenineTap(event)
    showModal("A adenina sempre se pareia com a timina, formando duas ligações de hidrogênio. Essa combinação é fundamental para a estabilidade da estrutura do DNA, mantendo as duas fitas unidas de maneira precisa e complementar.")
    adenineConnection()
end

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bg = display.newImage(sceneGroup, "assets/background.png")
    bg.x = 383
    bg.y = 500 
    bg.height = 1120

    bg.fill.effect = "filter.blurGaussian"

    
    bg.fill.effect.horizontal.blurSize = 5
    bg.fill.effect.horizontal.sigma = 30
    bg.fill.effect.vertical.blurSize = 5
    bg.fill.effect.vertical.sigma = 30
    
    local btPrev = display.newImage(sceneGroup, "assets/previous.png")
    local btprevPadding = (btPrev.height + btPrev.width) / 6
    
    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    btNxt.x = display.contentWidth - btNxt.width + 100
    btNxt.y = display.contentHeight - btprevPadding + 20
    
    local soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.height = 25
    soundBt.width = 25
    soundBt.y = 0
    soundBt.x = soundBt.width

    title = display.newText(sceneGroup, "Bases Nitrogenadas", 325, 20, native.systemFont, 60)
    title:setFillColor(0, 0, 0)
    
    local infoText = display.newText({
        parent = sceneGroup, 
        text = "As bases nitrogenadas são componentes essenciais dos nucleotídeos no DNA, divididas em purinas (adenina e guanina) e pirimidinas (citosina e timina). No DNA, adenina emparelha-se com timina, enquanto guanina se emparelha com citosina, formando ligações de hidrogênio que mantêm as duas cadeias da dupla hélice unidas. A sequência dessas bases codifica as informações genéticas, que determinam características hereditárias e orientam a síntese de proteínas.",
        x = 380,
        y = 200, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 23    
    })
    infoText:setFillColor(0, 0, 0)


    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Clique nas bases nitrogenadas Adenina (A), Timina (T), Guanina (G) e Citosina (C). para descobrir mais sobre como elas formam a estrutura do DNA.",
        x = 380,
        y = 380, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 23    
    })
    infoText:setFillColor(0, 0, 0)
    
    local centerX = 200
    local centerY = 700
    local width = 50
    local height = 430

    local rectangle = display.newRect(sceneGroup, centerX, centerY, width, height)
    rectangle:setFillColor(0, 0, 1)

    local centerX = 500
    local centerY = 700
    local width = 50
    local height = 430

    local rectangle1 = display.newRect(sceneGroup,centerX, centerY, width, height)
    rectangle1:setFillColor(0, 0, 1)
    
    

    myText = display.newText(sceneGroup, " " .. currentPage, display.contentCenterX, 980, native.systemFont, 40)
    myText:setFillColor(0, 0, 0)


    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page4", {
            effect = "flip",
            time = 300,
        })
    end)

    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", {
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

    local timine = display.newImage(sceneGroup, "assets/t.png")
    local guanine = display.newImage(sceneGroup, "assets/g.png")
    local adenine = display.newImage(sceneGroup, "assets/a.png")
    local cytosine = display.newImage(sceneGroup, "assets/c.png")
    
    timine.height = 50
    timine.width = 50
    timine.x = 250
    timine.y = 550

    guanine.height = 50
    guanine.width = 50
    guanine.x = 250
    guanine.y = 650

    adenine.height = 50
    adenine.width = 50
    adenine.x = 450
    adenine.y = 550

    cytosine.height = 50
    cytosine.width = 50
    cytosine.x = 450
    cytosine.y = 650

    local timine1 = display.newImage(sceneGroup, "assets/t.png")
    local guanine1 = display.newImage(sceneGroup, "assets/g.png")
    local adenine1 = display.newImage(sceneGroup, "assets/a.png")
    local cytosine1 = display.newImage(sceneGroup, "assets/c.png")

    timine1.height = 50
    timine1.width = 50
    timine1.x = 250
    timine1.y = 850

    guanine1.height = 50
    guanine1.width = 50
    guanine1.x = 450
    guanine1.y = 750

    adenine1.height = 50
    adenine1.width = 50
    adenine1.x = 450
    adenine1.y = 850

    cytosine1.height = 50
    cytosine1.width = 50
    cytosine1.x = 250
    cytosine1.y = 750

    guanine:addEventListener("tap", onGuanineTap)
    guanine1:addEventListener("tap", onGuanineTap)
    cytosine:addEventListener("tap", onCytosineTap)
    cytosine1:addEventListener("tap", onCytosineTap)
    adenine1:addEventListener("tap", onAdenineTap)
    adenine:addEventListener("tap", onAdenineTap)
    timine:addEventListener("tap", onTemineTap)
    timine1:addEventListener("tap", onTemineTap)


end

local function onGuaninecytosineButtonPress(event)
    print("Guanine or cytosine pressed")
end

local function onAdenineTimineButtonPress(event)
    print("Adenine or Timine pressed")
end

function scene:hide(event)
    local phase = event.phase
    if phase == "will" then
        closeModal() 
        closeConnections()
    end
end

-- show()
function scene:show(event)
    local phase = event.phase
    if phase == "did" then
        currentPage = 3
        updatePageText()  
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
