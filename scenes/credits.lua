-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:45:03
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-16 14:34:21

-- load required library files
local widget = require("widget")
local composer = require( "composer" ); 
local scene = composer.newScene();

function scene:create( event ) 
    local sceneGroup = self.view

    local function btnBackHandler(event)
		local sceneOpt = {effect = "flipFadeOutIn", time = 200}
        composer.gotoScene("scenes.menu", sceneOpt)
	end

    -- Load Background image
    local bgImage = display.newImage("images/scenes/credits.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

    local button_back = widget.newButton({
        defaultFile = "images/menu/back.png",
        onRelease = btnBackHandler
    })
    button_back.x = 100
	button_back.y = display.contentHeight - 100	
    sceneGroup:insert(button_back)
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