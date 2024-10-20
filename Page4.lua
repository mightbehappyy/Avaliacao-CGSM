local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 4


local function updatePageText()
    if myText then
        myText.text = "Pagina " .. currentPage
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view
    
    local bg = display.newRect(sceneGroup, 0, 0, 1800, 2990)
    bg.fill = {1, 0, 0, 1}
    
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

    myText = display.newText(sceneGroup, "Pagina " .. currentPage, display.contentCenterX, display.contentCenterY, native.systemFont, 40)
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
