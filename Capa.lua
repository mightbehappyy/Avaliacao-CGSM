-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local composer = require("composer")

local scene = composer.newScene()

-- create()
function scene:create(event)
    local sceneGroup = self.view

    -- Set up background
    local bg = display.newImage(sceneGroup, "assets/cover.png")
    bg.x = 383
    bg.y = 500
    bg.height = 1120

    -- Set up "Next" button
    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    local padding = (btNxt.height + btNxt.width) / 6
    btNxt.x = display.contentWidth - btNxt.width + 100
    btNxt.y = display.contentHeight - padding + 20

    -- Set up "Sound" button
    local soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.height = 30
    soundBt.width = 30
    soundBt.y = soundBt.height - 30
    soundBt.x = display.contentWidth - soundBt.width

    -- Add listener for "Next" button
    btNxt:addEventListener("tap", function(event)
        composer.gotoScene("Page2", {
            effect = "flip",
            time = 300
        })
    end)

    -- Adjust "Next" button dimensions
    btNxt.height = 100
    btNxt.width = 250
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
