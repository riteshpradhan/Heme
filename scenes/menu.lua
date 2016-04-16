-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:05:55
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-16 15:28:38

-- load required library files
local widget = require("widget")
local composer = require( "composer" ); 
local scene = composer.newScene();

function scene:create( event ) 
    local sceneGroup = self.view

    local function btnCreditsHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.credits", sceneOpt)
	end

	local function btnHelpHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.help", sceneOpt)
	end

    local function btnSettingsHandler(event)
		-- local sceneOpt = {effect = "flipFadeOutIn", time = 200}
  --       composer.gotoScene("scenes.settings", sceneOpt)

        -- Options table for the overlay scene "pause.lua"
        local options = {
            isModal = true,
            effect = "fade",
            time = 400
        }

        composer.showOverlay( "scenes.settings", options )
	end

	local function btnHelpHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.help", sceneOpt)
	end

    -- Load Background image
    local bgImage = display.newImage("images/menu/bg.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

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
        defaultFile = "images/menu/cart.png"
    })
    button_cart.x = display.contentWidth - 100	
	button_cart.y = display.contentHeight - 100	
    sceneGroup:insert(button_cart)

    local button_play = widget.newButton({
        defaultFile = "images/menu/play.png"
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
        
    end
end

-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
return scene;