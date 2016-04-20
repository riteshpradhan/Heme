-- @Author: Ritesh Pradhan
-- @Date:   2016-04-19 00:45:09
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-19 21:13:44

local widget = require('widget')
local composer = require( "composer" )
local scene = composer.newScene()
local hemeDatabox = require('libs.databox')
local utils = require("libs.utils");
local sounds = require( "libs.sounds" );

local awesomeG = display.newGroup( )
local awesomenessT

function scene:create( event )
    local sceneGroup = self.view
    local params = event.params

 --    local function btnBackHandler(event)
 --        sounds.play('back')
 --     	local sceneOpt = {effect = "crossFade", time = 600}
 --        composer.gotoScene("scenes.menu", sceneOpt)
	-- end

    local function btnRestartHandler(event)
        sounds.play('back')
        local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.game", sceneOpt)
    end

    local function btnMenuHandler(event)
        sounds.play('back')
        local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.menu", sceneOpt)
    end

    -- Load Background image
    local bgImage = display.newImage("images/scenes/help.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

    local button_menu = widget.newButton({
        defaultFile = "images/menu/menu.png",
        onRelease = btnMenuHandler
    })
    button_menu.x = display.contentCenterX - 100
    button_menu.y = display.contentCenterY + 200
    sceneGroup:insert(button_menu)

    local button_restart = widget.newButton({
        defaultFile = "images/menu/restart.png",
        onRelease = btnRestartHandler
    })
    button_restart.x = display.contentCenterX + 100
    button_restart.y = display.contentCenterY + 200
    sceneGroup:insert(button_restart)

    local rect = display.newRect( awesomeG, display.contentCenterX, display.contentCenterY, 400, 200 )
    rect:setFillColor( 1,1,0,0.4 )

    awesomenessT = display.newText( awesomeG, params.distance, display.contentCenterX, display.contentCenterY, native.systemFont, 80 )
    awesomenessT:setFillColor( 1,0,0 )

    sceneGroup:insert( awesomeG )
end

function scene:show( event )
    local sceneGroup = self.view

    if(hemeDatabox.isMusicOn) then
        if(audio.isChannelPlaying( 25 )) then
            sounds.stop(25)
        end
        sounds.play('bg_music_game_over', {loops = -1, channel = 25})
    end

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