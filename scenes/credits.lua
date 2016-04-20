-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:45:03
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-17 22:43:38

-- load required library files
local widget = require("widget")
local composer = require( "composer" ); 
local scene = composer.newScene();
local sounds = require( "libs.sounds" ); 
local images = require("libs.images");

function scene:create( event ) 
    local sceneGroup = self.view

    local function btnBackHandler(event)
        sounds.play('back')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.menu", sceneOpt)
	end

    -- Load Background image
    local bgImage = display.newImage("images/scenes/credits.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

    local backButton = widget.newButton(
        {
            x = 125,
            y = 70,
            sheet = images.backButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onRelease = btnBackHandler
        }
    )
    sceneGroup:insert(backButton)
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