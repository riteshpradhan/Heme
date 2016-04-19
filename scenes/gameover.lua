-- @Author: Ritesh Pradhan
-- @Date:   2016-04-19 00:45:09
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-19 01:10:11

local widget = require('widget')
local composer = require( "composer" )
local scene = composer.newScene()
local sounds = require( "libs.sounds" );

local awesomeG = display.newGroup( )
local awesomenessT

function scene:create( event )
    local sceneGroup = self.view
    local params = event.params

    local function btnBackHandler(event)
        sounds.play('back')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.menu", sceneOpt)
	end

    -- Load Background image
    local bgImage = display.newImage("images/scenes/help.png")
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

    local rect = display.newRect( awesomeG, display.contentCenterX, display.contentCenterY, 400, 200 )
    rect:setFillColor( 1,1,0,0.4 )

    awesomenessT = display.newText( awesomeG, params.distance, display.contentCenterX, display.contentCenterY, native.systemFont, 80 )
    awesomenessT:setFillColor( 1,0,0 )

    sceneGroup:insert( awesomeG )
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if ( phase == "will") then
    	awesomenessT.text = params.distance
    elseif ( phase == "did" ) then

    end
end

-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;