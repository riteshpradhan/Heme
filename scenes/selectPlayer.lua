-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-19 19:03:39

-- load required library files
local widget = require("widget")
local composer = require( "composer" );
local scene = composer.newScene();
local sounds = require( "libs.sounds" );
local background = require('classes.background')
local hemeDatabox = require('libs.databox')

local title_text, box_1, box_2, heme, hemi, heme_current, hemi_current, button_back

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
    	hemeDatabox.defaultPlayer = selectedPlayer
    	print("current player => " .. hemeDatabox.defaultPlayer)
    	sounds.play('setting_item')
    end
    if(hemeDatabox.defaultPlayer == 'hemi') then
    	hemi_current.isVisible = true
    	heme_current.isVisible = false
    else
    	heme_current.isVisible = true
    	hemi_current.isVisible = false
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
	    fontSize = 40
	}
    title_text = display.newText(title_text_options)
    sceneGroup:insert(title_text)

	box_1 = display.newRoundedRect(display.contentCenterX - 250, display.contentCenterY, 300, 350, 20)
    box_1:setFillColor( 0.5, 0.5, 0.5, 0.5 )
    sceneGroup:insert(box_1)    

    heme_current = display.newImage("images/menu/OK.png")
    heme_current.x = display.contentCenterX - 250
    heme_current.y = display.contentCenterY + 210
    heme_current.isVisible = false
    sceneGroup:insert(heme_current);

    hemi_current = display.newImage("images/menu/OK.png")
    hemi_current.x = display.contentCenterX + 250
    hemi_current.y = display.contentCenterY + 210
    hemi_current.isVisible = false
    sceneGroup:insert(hemi_current);

    heme = display.newImage('images/enemy/birdEnemy.png')
    heme.x = display.contentCenterX - 250
    heme.y = display.contentCenterY
    heme:addEventListener( 'tap', function() setDefault('heme')  end)
    sceneGroup:insert(heme)    

    box_2 = display.newRoundedRect(display.contentCenterX + 250, display.contentCenterY, 300, 350, 20)
    box_2:setFillColor( 0.5, 0.5, 0.5, 0.5 )
    sceneGroup:insert(box_2)    

    hemi = display.newImage('images/enemy/birdEnemy.png')
    hemi.x = display.contentCenterX + 250
    hemi.y = display.contentCenterY
    hemi:addEventListener( 'tap', function() setDefault('hemi') end)
    sceneGroup:insert(hemi)    
	
    setDefault()
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if ( phase == "did" ) then
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