-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-19 19:03:39

-- load required library files
local widget = require("widget")
local composer = require( "composer" );
local scene = composer.newScene();
local sounds = require( "libs.sounds" );
local background = require('classes.background')
local hemeDatabox = require('libs.databox')

local title_text, hemeBox, hemaBox, heme, hema, heme_current, hema_current, button_back

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

function setDefault(selectedPlayer)
	if(selectedPlayer ~= nil) then
    	hemeDatabox.player = selectedPlayer
    	print("current player => " .. hemeDatabox.defaultPlayer)
    	sounds.play('back')
    end

    if(hemeDatabox.player == 'hema') then
    	hema_current.isVisible = true
    	heme_current.isVisible = false
    else
    	heme_current.isVisible = true
    	hema_current.isVisible = false
    end
end

function scene:create( event )
    local sceneGroup = self.view

    local bgImage = { type="image", filename="images/scenes/bg.jpg" }
    bg = background:newBackground()
    bg:addScrollableBg(bgImage)


    sceneGroup:insert(bg.bg1);
    sceneGroup:insert(bg.bg2);

    function btnBackHandler(event)
        sounds.play('back')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.menu", sceneOpt)
	end

    button_back = widget.newButton({
        defaultFile = "images/menu/back.png",
        onRelease = btnBackHandler
    })
    button_back.x = 100
	button_back.y = display.contentHeight - 100
    sceneGroup:insert(button_back)

    local title_text_options =
	{
	    text = "SELECT PLAYER",
	    x = display.contentCenterX,
	    y = 130,
	    font = "Comic Sans MS",
	    fontSize = 50,
	}
    title_text = display.newText(title_text_options)
    title_text:setFillColor( 0, 0.5, 0 )
    sceneGroup:insert(title_text)

	hemeBox = display.newRoundedRect(display.contentCenterX - 250, display.contentCenterY, 300, 350, 20)
    hemeBox:setFillColor( 0.5, 0.5, 0.5, 0.5 )
    hemeBox:addEventListener( "tap", function() setDefault('heme')  end)
    sceneGroup:insert(hemeBox)

    hemeName = display.newText( "Heme", 0, 0, "Comic Sans MS", 50 )
    hemeName.x = display.contentCenterX - 250
    hemeName.y = display.contentCenterY + 210
    hemeName:setFillColor( 0, 0.5, 0 )
    sceneGroup:insert(hemeName);

    heme_current = display.newImage("images/menu/OK.png")
    heme_current.x = display.contentCenterX - 150
    heme_current.y = display.contentCenterY + 130
    heme_current.isVisible = false
    sceneGroup:insert(heme_current);

    hemaBox = display.newRoundedRect(display.contentCenterX + 250, display.contentCenterY, 300, 350, 20)
    hemaBox:setFillColor( 0.5, 0.5, 0.5, 0.5 )
    hemaBox:addEventListener( 'tap', function() setDefault('hema') end)
    sceneGroup:insert(hemaBox)

    hemaName = display.newText( "Hema", 0, 0, "Comic Sans MS", 50 )
    hemaName.x = display.contentCenterX + 250
    hemaName.y = display.contentCenterY + 210
    hemaName:setFillColor( 0, 0.5, 0 )
    sceneGroup:insert(hemaName);

    hema_current = display.newImage("images/menu/OK.png")
    hema_current.x = display.contentCenterX + 350
    hema_current.y = display.contentCenterY + 130
    hema_current.isVisible = false
    sceneGroup:insert(hema_current);

    heme = display.newImage('images/player/heme.png')
    heme.x = display.contentCenterX - 250
    heme.y = display.contentCenterY
    sceneGroup:insert(heme)

    hema = display.newImage('images/player/hema.png')
    hema.x = display.contentCenterX + 250
    hema.y = display.contentCenterY
    sceneGroup:insert(hema)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if ( phase == "did" ) then
        setDefault()
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