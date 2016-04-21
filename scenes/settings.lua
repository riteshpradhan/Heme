-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-16 01:05:55
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-20 21:41:32


-- load required library files
local widget = require("widget");
local composer = require("composer");
local hemeDatabox = require('libs.databox')
local utils = require("libs.utils");
local sounds = require( "libs.sounds" );
local images = require("libs.images");
local scene = composer.newScene();

function scene:create( event )
end
function scene:show( event )
    local sceneGroup = self.view

    if(event.phase == "will") then
        local parent = event.parent

        local sceneGroup = self.view
        -- Load Background image
        local obox = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight);
        obox:setFillColor(0,0,0,0.8);
        sceneGroup:insert(obox)

        local is_playing = event.params.is_playing
        local x_offset, y_offset = 0, 0

        if(is_playing) then
            x_offset = 400
            y_offset = 230
        end

        local function btnMenuHandler(event)
            sounds.play('back')
            if(is_playing) then
                local sceneOpt = {effect = "fade", time = 400}
                composer.gotoScene("scenes.menu", sceneOpt)
            else
                composer.hideOverlay( "fade", 400 )
            end
        end

        local button_music, button_sound, button_back, button_play
        local function btnMusicHandler(event)
            button_music:removeSelf()
            if(hemeDatabox.isMusicOn == true) then
                hemeDatabox.isMusicOn = false
                sounds.isMusicOn = hemeDatabox.isMusicOn
                -- if(audio.isChannelPlaying( 25 )) then
                    sounds.musicStop()
                -- end
                
                sounds.play('music_toggle_off')
                button_music = widget.newButton({
                    defaultFile = "images/menu/music_off.png",
                    onRelease = btnMusicHandler
                })
            else
                hemeDatabox.isMusicOn = true
                sounds.isMusicOn = hemeDatabox.isMusicOn
                -- if(audio.isChannelPlaying( 25 ) == false) then
                    if(is_playing) then
                        sounds.musicPlay('bg_music_game')
                    else
                        sounds.musicPlay('bg_music_menu')
                    end
                -- end
                
                sounds.play('music_toggle_on')
                button_music = widget.newButton({
                    defaultFile = "images/menu/music_on.png",
                    onRelease = btnMusicHandler
                })
            end
            button_music.x = display.contentCenterX - 100 + x_offset
            button_music.y = display.contentCenterY + y_offset
            sceneGroup:insert(button_music)
        end

        local function btnSoundHandler(event)
            button_sound:removeSelf()
            if(hemeDatabox.isSoundOn == true) then
                hemeDatabox.isSoundOn = false
                -- sounds.play('sound_toggle_off')
                sounds.isSoundOn = hemeDatabox.isSoundOn
                button_sound = widget.newButton({
                    defaultFile = "images/menu/sound_off.png",
                    onRelease = btnSoundHandler
                })
            else
                hemeDatabox.isSoundOn = true
                sounds.isSoundOn = hemeDatabox.isSoundOn
                sounds.play('sound_toggle_on')
                button_sound = widget.newButton({
                    defaultFile = "images/menu/sound_on.png",
                    onRelease = btnSoundHandler
                })
            end
            button_sound.x = display.contentCenterX + 100 + x_offset
            button_sound.y = display.contentCenterY + y_offset
            sceneGroup:insert(button_sound)
        end

        function returnTapEvent(event)
            return true;
        end

        local function btnPlayHandler(event)
            utils.print_table(event)
            if(event.target == button_play) then
                sounds.play('play')
            else
                sounds.play('back')
            end
            button_play:addEventListener("tap", returnTapEvent);
            parent:resumeGame()
            composer.hideOverlay( "fade", 400 )
        end

        -- local function btnRestartHandler(event)
        --     sounds.play('back')
        --     print("restarts here")
        -- end

        if(is_playing) then
            local button_menu = widget.newButton({
                defaultFile = "images/menu/menu.png",
                onRelease = btnMenuHandler
            })
            button_menu.x = display.contentCenterX + 100
        	button_menu.y = display.contentCenterY + y_offset
            sceneGroup:insert(button_menu)
            button_menu:toFront()

            button_play = widget.newButton({
                defaultFile = "images/menu/play.png",
                onRelease = btnPlayHandler
            })
            button_play.x = display.contentCenterX 
            button_play.y = display.contentCenterY
            sceneGroup:insert(button_play)
            button_play:toFront()

            -- local button_restart = widget.newButton({
            --     defaultFile = "images/menu/restart.png",
            --     onRelease = btnRestartHandler
            -- })
            -- button_restart.x = display.contentCenterX + 200
            -- button_restart.y = display.contentCenterY
            -- sceneGroup:insert(button_restart)

            -- button_back = widget.newButton({
            --     defaultFile = "images/menu/back.png",
            --     onRelease = btnPlayHandler
            -- })
        else
            local button_back = widget.newButton(
                {
                    x = 125,
                    y = 90,
                    sheet = images.backButtonSheet,
                    defaultFrame = 1,
                    overFrame = 2,
                    onRelease = btnMenuHandler
                }
            )

            sceneGroup:insert(button_back)
        end

        if(hemeDatabox.isMusicOn == true) then
            button_music = widget.newButton({
                defaultFile = "images/menu/music_on.png",
                onRelease = btnMusicHandler
            })
        else
            button_music = widget.newButton({
                defaultFile = "images/menu/music_off.png",
                onRelease = btnMusicHandler
            })
        end

        button_music.x = display.contentCenterX - 100 + x_offset
    	button_music.y = display.contentCenterY + y_offset
        sceneGroup:insert(button_music)
        button_music:toFront()

        if(hemeDatabox.isSoundOn == true) then
            button_sound = widget.newButton({
                defaultFile = "images/menu/sound_on.png",
                onRelease = btnSoundHandler
            })
        else
            button_sound = widget.newButton({
                defaultFile = "images/menu/sound_off.png",
                onRelease = btnSoundHandler
            })
        end
        button_sound.x = display.contentCenterX + 100 + x_offset
        button_sound.y = display.contentCenterY + y_offset
        sceneGroup:insert(button_sound)
        button_sound:toFront()
    end
end

-- function scene:show( event )
--     local sceneGroup = self.view
--     local phase = event.phase
--     local params = event.params
--     if ( phase == "did" ) then

--     end
-- end

-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
return scene;