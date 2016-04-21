-- @Author: Ritesh Pradhan
-- @Date:   2016-04-19 00:45:09
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-20 21:43:14

local widget = require('widget')
local composer = require( "composer" )
local scene = composer.newScene()
local hemeDatabox = require('libs.databox')
local utils = require("libs.utils");
local sounds = require( "libs.sounds" );

local awesomeG = display.newGroup( )
local awesomenessT

local highScoreT
local currentScoreT
local currentCoinT
local currentMedalT


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
    local bgImage = display.newImage("images/scenes/gameOverScreen.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

    local button_menu = widget.newButton({
        defaultFile = "images/menu/menu.png",
        onRelease = btnMenuHandler
    })
    button_menu.x = display.contentCenterX - 100
    button_menu.y = display.contentCenterY + 250
    sceneGroup:insert(button_menu)

    local button_restart = widget.newButton({
        defaultFile = "images/menu/restart.png",
        onRelease = btnRestartHandler
    })
    button_restart.x = display.contentCenterX + 100
    button_restart.y = display.contentCenterY + 250
    sceneGroup:insert(button_restart)


    --- 800 263
            -- 325

    highScoreT = display.newText( awesomeG, hemeDatabox.highscore, 800, 265, "Comic Sans MS", 40 )
    currentScoreT = display.newText( awesomeG, params.distance, 800, 325, "Comic Sans MS", 40 )
    currentCoinT = display.newText( awesomeG, params.coin, 800, 380, "Comic Sans MS", 40 )
    currentMedalT = display.newText( awesomeG, params.medal, 800, 450, "Comic Sans MS", 40 )

    sceneGroup:insert( awesomeG )
end

function scene:show( event )
    local sceneGroup = self.view

    -- if(hemeDatabox.isMusicOn) then
        -- if(audio.isChannelPlaying( 25 )) then
            -- sounds.stop(25)
        -- end
        -- sounds.musicPlay('bg_music_game_over', {loops = -1, channel = 25})
    -- end
    sounds.musicPlay('bg_music_game_over')

    local phase = event.phase
    local params = event.params
    if ( phase == "will") then
    	highScoreT.text = hemeDatabox.highscore
        currentScoreT.text = params.distance
        currentCoinT.text = params.coin
        currentMedalT.text = params.medal
    elseif ( phase == "did" ) then

    end
end

-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );

return scene;