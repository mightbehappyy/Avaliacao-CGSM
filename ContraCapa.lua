local composer = require("composer")

local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view
    
    local bg = display.newImage(sceneGroup, "assets/countercover.png")
    bg.height = 1050
    bg.x = 383
    bg.y = 500 
    local btPrev = display.newImage(sceneGroup, "assets/previous.png")
    local btprevPadding = (btPrev.height + btPrev.width) / 6
    
    local soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.height = 25
    soundBt.width = 25
    soundBt.y = 0
    soundBt.x = soundBt.width


    btPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page6", {
            effect = "flip",
            time = 300
        })
    end)

    btPrev.x = 0 + btprevPadding + 70
    btPrev.y = display.contentHeight - (btprevPadding - 20)
    
    btPrev.height = 100
    btPrev.width = 250


end

-- show()
function scene:show(event)
    local phase = event.phase
    if phase == "did" then

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
