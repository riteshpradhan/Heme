-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-16 01:05:55
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-16 15:45:28

-- load required library files
local widget = require("widget")
local composer = require( "composer" ); 
local scene = composer.newScene();

function scene:create( event ) 
    local sceneGroup = self.view

    -- Load Background image
    local obox = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight); 
    obox:setFillColor(0,0,0,0.8);
    sceneGroup:insert(obox)

    local is_playing = true
    local x_offset, y_offset = 0, 0
    if(is_playing) then
        x_offset = 400  
        y_offset = 230
    end
    local function btnBackHandler(event)
        local sceneOpt = {effect = "fade", time = 400}
        composer.gotoScene("scenes.menu", sceneOpt)
    end

    if(is_playing) then
        local button_menu = widget.newButton({
            defaultFile = "images/menu/menu.png",
        })
        button_menu.x = display.contentCenterX - 200
    	button_menu.y = display.contentCenterY
        sceneGroup:insert(button_menu)

        local button_play = widget.newButton({
            defaultFile = "images/menu/play.png",
        })
        button_play.x = display.contentCenterX
        button_play.y = display.contentCenterY
        sceneGroup:insert(button_play)

        local button_restart = widget.newButton({
            defaultFile = "images/menu/restart.png",
        })
        button_restart.x = display.contentCenterX + 200
        button_restart.y = display.contentCenterY
        sceneGroup:insert(button_restart)
    end

	local button_music = widget.newButton({
        defaultFile = "images/menu/music_on.png",
    })
    button_music.x = display.contentCenterX - 100 + x_offset
	button_music.y = display.contentCenterY + y_offset
    sceneGroup:insert(button_music)

    local button_sound = widget.newButton({
        defaultFile = "images/menu/sound_on.png",
    })
    button_sound.x = display.contentCenterX + 100 + x_offset
    button_sound.y = display.contentCenterY + y_offset
    sceneGroup:insert(button_sound)

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