local composer = require("composer")

local scene = composer.newScene()

local myText
local currentPage = 4
local narration = audio.loadStream("assets/pag4.mp3")
local audioHandler
local muteText
local targetX = 385
local targetY = display.contentCenterY + 35

local targetX2 = 385
local targetY2 = display.contentCenterY + 200

local isFirstLocationRight = nil
local isSecondLocationRight = nil
local sceneGroup
local mutation
local mutationText
local right_dna2
local right_dna
local wrong_dna
local wrong_dna2

local function updatePageText()
    if myText then
        myText.text = " " .. currentPage
    end
end

local function isAtTargetLocation(piece)
    local tolerance = 40

    if math.abs(piece.x - targetX) < tolerance and math.abs(piece.y - targetY) < tolerance then
        return true
    end
    return false
end


local function isAtTargetLocation2(piece)
    local tolerance = 40

    if math.abs(piece.x - targetX2) < tolerance and math.abs(piece.y - targetY2) < tolerance then
        return true
    end
    return false
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


local function onPieceTouch(event)
    local piece = event.target

    if event.phase == "began" then
        display.currentStage:setFocus(piece)
        piece.isFocus = true
        piece.x0 = event.x - piece.x
        piece.y0 = event.y - piece.y
    elseif piece.isFocus then
        if event.phase == "moved" then
            piece.x = event.x - piece.x0
            piece.y = event.y - piece.y0
        elseif event.phase == "ended" or event.phase == "cancelled" then
            display.currentStage:setFocus(nil)
            piece.isFocus = false

            
            if mutation then
                mutation:removeSelf()
                mutation = nil
            end
            if mutationText then
                mutationText:removeSelf()
                mutationText = nil
            end

            -- Check conditions
            if isAtTargetLocation(piece) then
                if piece.name == "right" or piece.name == "right1" then
                    isFirstLocationRight = true
                    piece:removeEventListener("touch", onPieceTouch)
                    piece.isDraggable = false
                end
            end

            if isAtTargetLocation2(piece) then
                if piece.name == "right" or piece.name == "right1" then
                    isSecondLocationRight = true
                    piece:removeEventListener("touch", onPieceTouch)
                    piece.isDraggable = false
                end
            end

            
            if isSecondLocationRight and isFirstLocationRight then
                mutation = display.newImage(sceneGroup, "assets/thumps.png")
                mutation.x = display.contentCenterX + 280
                mutation.y = display.contentCenterY + 125
                mutation:scale(0.8, 0.8)

                mutationText = display.newText({
                    parent = sceneGroup, 
                    text = "Nenhuma Mutação encontrada!",
                    x = 670,
                    y = display.contentCenterY + 250,  
                    width = 200,
                    font = native.systemFont,
                    fontSize = 25,
                    align = "center"
                })
                right_dna:removeEventListener("touch", onPieceTouch)
                right_dna2:removeEventListener("touch", onPieceTouch)
                wrong_dna:removeEventListener("touch", onPieceTouch)
                wrong_dna2:removeEventListener("touch", onPieceTouch)
                mutationText:setFillColor(0, 1, 0)
            else
                mutation = display.newImage(sceneGroup, "assets/thumbsdown.png")
                mutation.x = display.contentCenterX + 280
                mutation.y = display.contentCenterY + 125
                mutation:scale(0.8, 0.8)

                mutationText = display.newText({
                    parent = sceneGroup, 
                    text = "Mutação encontrada",
                    x = 650,
                    y = display.contentCenterY + 250,  
                    width = 200,
                    font = native.systemFont,
                    fontSize = 25,
                    align = "center"
                })
                mutationText:setFillColor(1, 0, 0)
            end
        end
    end
    return true
end





-- create()
function scene:create(event)
    sceneGroup = self.view
    
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
    btPrev.x = 135
    btPrev.y = display.contentHeight - 80
    btPrev.height = 100
    btPrev.width = 250

    local btNxt = display.newImage(sceneGroup, "assets/next.png")
    btNxt.x = display.contentWidth - 135
    btNxt.y = display.contentHeight - 80
    btNxt.height = 100
    btNxt.width = 245
    
    soundBt = display.newImage(sceneGroup, "assets/sound-icon.png")
    soundBt.x = display.contentCenterX
    soundBt.y = 890
    soundBt.height = 50
    soundBt.width = 50
    soundBt:addEventListener("tap", toggleMute)

    local title = display.newText({
        parent = sceneGroup, 
        text = "O mapeamento genético é um exame que analisa a sequência do DNA, permitindo entender como os genes funcionam e como mutações podem afetar a saúde. Esse processo envolve a coleta de uma amostra de sangue ou saliva, a partir da qual o DNA é isolado e sequenciado. Através desse mapeamento, os médicos conseguem identificar mutações que aumentam o risco de doenças, especialmente o câncer hereditário.",
        x = 380,
        y = 250, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 23    
    })
    title:setFillColor(0, 0, 0)

    mutation = display.newImage(sceneGroup, "assets/poke.png")
    mutation.x = 650
    mutation.y = display.contentCenterY + 120

    mutationText = display.newText({
        parent = sceneGroup, 
        text = "Gene Incompleto",
        x = 650,
        y = display.contentCenterY + 250,  
        width = 650,
        font = native.systemFont, 
        fontSize = 25,
        align = "center"
    })
    mutationText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "O que é o mapeamento genético e qual a sua importância?",
        x = display.contentCenterX,
        y = 70, 
        width = 650,
        font = native.systemFont, 
        fontSize = 39,
        align = "center"
    })
    
    muteText = display.newText({
        parent = sceneGroup, 
        text = "Desligar áudio",
        x = display.contentCenterX,
        y = 940,  
        font = native.systemFont, 
        fontSize = 20  
    })
    muteText:setFillColor(0, 0, 0)
    
    
    infoText.anchorX = 0.5
    
    infoText:setFillColor(0, 0, 0)

    local infoText = display.newText({
        parent = sceneGroup, 
        text = "Arraste as partes faltantes da sequência de DNA para os espaços em branco para completá-la corretamente. Tente encontrar uma sequência que não indique uma mutação",
        x = 380,
        y = 400, 
        width = 650, 
        font = native.systemFont, 
        fontSize = 20    
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


    local line_dna = display.newImage(sceneGroup, "assets/r_dna2.png")
    line_dna.x = display.contentCenterX
    line_dna.y = display.contentCenterY - 45

    line_dna.width = line_dna.width * 0.4
    line_dna.height = line_dna.height * 0.4

    local line_dna1 = display.newImage(sceneGroup, "assets/r_dna2.png")
    line_dna1.x = display.contentCenterX
    line_dna1.y = display.contentCenterY + 280

    line_dna1.width = line_dna1.width * 0.4
    line_dna1.height = line_dna1.height * 0.4

    local line_dna3 = display.newImage(sceneGroup, "assets/r_dna2.png")
    line_dna3.x = display.contentCenterX
    line_dna3.y = display.contentCenterY + 117
    line_dna3.width = line_dna3.width * 0.4
    line_dna3.height = line_dna3.height * 0.4


    
    right_dna2 = display.newImage(sceneGroup, "assets/r_dna2.png")
    right_dna2.x = 100
    right_dna2.y = display.contentCenterY + 198
    right_dna2.width = right_dna2.width * 0.4
    right_dna2.height = right_dna2.height * 0.4
    

    right_dna = display.newImage(sceneGroup, "assets/r_dna2.png")
    right_dna.x = 170
    right_dna.y = display.contentCenterY + 60
    right_dna.width = right_dna.width * 0.4
    right_dna.height = right_dna.height * 0.4


    wrong_dna = display.newImage(sceneGroup, "assets/w_dna1.png")
    wrong_dna.x = 100
    wrong_dna.y = display.contentCenterY  + 60

    wrong_dna.width = wrong_dna.width * 0.4
    wrong_dna.height = wrong_dna.height * 0.4 

    wrong_dna2 = display.newImage(sceneGroup, "assets/w_dna2.png")
    wrong_dna2.x = 170
    wrong_dna2.y = display.contentCenterY  + 200

    wrong_dna2.width = wrong_dna2.width * 0.4
    wrong_dna2.height = wrong_dna2.height * 0.4 
    
    right_dna2:addEventListener("touch", onPieceTouch)
    wrong_dna:addEventListener("touch", onPieceTouch)
    right_dna:addEventListener("touch", onPieceTouch)
    wrong_dna2:addEventListener("touch", onPieceTouch)

    right_dna2.name = "right1"
    right_dna.name = "right"
    wrong_dna.name = "wrong"
    wrong_dna2.name = "wrong1"
        
    
    local targetRectangle = display.newRect(sceneGroup, targetX, targetY, 50, 50)
    targetRectangle:setFillColor(0, 1, 0, 0.3)
    targetRectangle:setStrokeColor(0, 1, 0)
    targetRectangle.strokeWidth = 3  

    local targetRectangle2 = display.newRect(sceneGroup, targetX2, targetY2, 50, 50)
    targetRectangle2:setFillColor(0, 1, 0, 0.3)  
    targetRectangle2:setStrokeColor(0, 1, 0)  
    targetRectangle2.strokeWidth = 3 
end

function scene:hide(event)
    if event.phase == "will" then
        
        if audio.isChannelActive(1) then
            audio.stop(1)
        end

        
        isFirstLocationRight = nil
        isSecondLocationRight = nil

        
        if mutation then
            mutation:removeSelf()
            mutation = nil
        end

        if mutationText then
            mutationText:removeSelf()
            mutationText = nil
        end

        right_dna2.x = 100
        right_dna2.y = display.contentCenterY + 198
        right_dna.x = 170
        right_dna.y = display.contentCenterY + 60
        wrong_dna.x = 100
        wrong_dna.y = display.contentCenterY  + 60
        wrong_dna2.x = 170
        wrong_dna2.y = display.contentCenterY  + 200
        right_dna2:addEventListener("touch", onPieceTouch)
        wrong_dna:addEventListener("touch", onPieceTouch)
        right_dna:addEventListener("touch", onPieceTouch)
        wrong_dna2:addEventListener("touch", onPieceTouch)
        mutation = display.newImage(sceneGroup, "assets/poke.png")
    mutation.x = 650
    mutation.y = display.contentCenterY + 120
    end
end


function scene:show(event)
    if event.phase == "did" then
        
        currentPage = 4
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
            if narration then
                audio.dispose(narration)
            end
            narration = audio.loadStream("assets/pag4.mp3")
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
