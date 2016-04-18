-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:05:55
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-16 22:41:52

-- load required library files
local widget = require("widget")
local composer = require( "composer" ); 
local background = require('classes.background')

local scene = composer.newScene();

local runtime = 0
local scrollSpeed = 1

function getDeltaTime()
   local temp = system.getTimer()
   local dt = (temp-runtime) / (1000/60)
   runtime = temp
   return dt
end

function enterFrame()
    local dt = getDeltaTime()
    bg:moveBg(dt, scrollSpeed)

end

function scene:create( event ) 
    local sceneGroup = self.view
    -- bg.addScrollableBg()
    local bgImage = { type="image", filename="images/scenes/bg.jpg" }
    bg = background:newBackground()
    bg:addScrollableBg(bgImage)
    Runtime:addEventListener("enterFrame", enterFrame)

    sceneGroup:insert(bg.bg1);
    sceneGroup:insert(bg.bg2);


    local function btnCreditsHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.credits", sceneOpt)
	end

	local function btnHelpHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.help", sceneOpt)
	end

    local function btnPlayHandler(event)
        local sceneOpt = {effect = "fade", time = 800}
        composer.gotoScene("scenes.game", sceneOpt)
    end

    local function btnCartHandler(event)
        local sceneOpt = {effect = "slideLeft", time = 800}
        composer.gotoScene("scenes.store", sceneOpt)
    end

    local function btnSettingsHandler(event)
        local options = {
            isModal = true,
            effect = "fade",
            time = 400,
            params = {is_playing = false}
        }
        composer.showOverlay( "scenes.settings", options )
	end

	local function btnHelpHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.help", sceneOpt)
	end

    -- Load Background image
    local titleImage = display.newImage("images/menu/titleImage.png")
    titleImage.x = display.contentCenterX
	titleImage.y = display.contentCenterY - 200
    sceneGroup:insert(titleImage)

    local button_settings = widget.newButton({
        defaultFile = "images/menu/setting.png",
        onRelease = btnSettingsHandler
    })
    button_settings.x = 100
	button_settings.y = display.contentHeight - 100	
    sceneGroup:insert(button_settings)

	local button_help = widget.newButton({
        defaultFile = "images/menu/help.png",
        onRelease = btnHelpHandler
    })
    button_help.x = 250
	button_help.y = display.contentHeight - 100	
    sceneGroup:insert(button_help)

    local button_credits = widget.newButton({
        defaultFile = "images/menu/information.png",
        onRelease = btnCreditsHandler
    })	
    button_credits.x = 400
	button_credits.y = display.contentHeight - 100	
    sceneGroup:insert(button_credits)

    local button_cart = widget.newButton({
        defaultFile = "images/menu/cart.png",
        onRelease = btnCartHandler
    })
    button_cart.x = display.contentWidth - 100	
	button_cart.y = display.contentHeight - 100	
    sceneGroup:insert(button_cart)

    local button_play = widget.newButton({
        defaultFile = "images/menu/play.png",
        onRelease = btnPlayHandler
    })
    button_play.x = display.contentCenterX
	button_play.y = display.contentCenterY
    sceneGroup:insert(button_play)

	
end

function scene:show( event )
    local sceneGroup = self.view 
    local phase = event.phase
    local params = event.params
    if ( phase == "did" ) then
        -- bg = background:newBackground()
    end


end

-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
return scene;