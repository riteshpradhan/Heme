-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:05:55
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-20 21:53:41

-- load required library files
local widget = require("widget")
local composer = require( "composer" )
local background = require('classes.background')
local hemeDatabox = require('libs.databox')

local sounds = require( "libs.sounds" );
local scene = composer.newScene();

local runtime = 0
local scrollSpeed = 1
local bg

local getDeltaTime = {}
local enterFrame = {}

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
    local bgImage = { type="image", filename="images/scenes/bg2.jpg" }
    bg = background:newBackground()
    bg:addScrollableBg(bgImage)


    sceneGroup:insert(bg.bg1);
    sceneGroup:insert(bg.bg2);


    local function btnCreditsHandler(event)
        sounds.play('menu_item')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.credits", sceneOpt)
	end

	local function btnHelpHandler(event)
        sounds.play('menu_item')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.help", sceneOpt)
	end

    local function btnPlayHandler(event)
        sounds.play('play')
        sounds.stop(25)
        local sceneOpt = {effect = "fade", time = 800}
        composer.gotoScene("scenes.game", sceneOpt)
    end

    local function btnCartHandler(event)
        sounds.play('menu_item')
        local sceneOpt = {effect = "slideLeft", time = 800}
        composer.gotoScene("scenes.store", sceneOpt)
    end

    local function btnPlayerChangeHandler(event)
        sounds.play('menu_item')
        local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.selectPlayer", sceneOpt)
    end

    local function btnSettingsHandler(event)
        sounds.play('menu_item')
        local options = {
            isModal = true,
            effect = "fade",
            time = 400,
            params = {is_playing = false}
        }
        composer.showOverlay( "scenes.settings", options )
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

    local button_select_player = widget.newButton({
        defaultFile = "images/menu/favorite.png",
        onRelease = btnPlayerChangeHandler
    })
    button_select_player.x = 250
    button_select_player.y = display.contentHeight - 100
    sceneGroup:insert(button_select_player)

	local button_help = widget.newButton({
        defaultFile = "images/menu/help.png",
        onRelease = btnHelpHandler
    })
    button_help.x = 400
	button_help.y = display.contentHeight - 100
    sceneGroup:insert(button_help)

    local button_credits = widget.newButton({
        defaultFile = "images/menu/information.png",
        onRelease = btnCreditsHandler
    })
    button_credits.x = 550
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
        -- if(hemeDatabox.isMusicOn) then
            -- if(audio.isChannelPlaying( 25 )) then
                -- sounds.stop(25)
            -- end
            -- sounds.musicPlay('bg_music_menu', {loops = -1, channel = 25})
            sounds.musicPlay('bg_music_menu')
        -- end
        -- bg = background:newBackground()
        print("Scroll speed is : ", scrollSpeed)
        print("HEre")
        Runtime:addEventListener("enterFrame", enterFrame)
    end
end

function scene:hide ( event )
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if(phase == "will") then
        Runtime:removeEventListener("enterFrame", enterFrame)
    end
end
-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
return scene;