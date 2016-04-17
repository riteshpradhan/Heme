-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 20:30:58
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-16 23:13:26

local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

local bg = require('classes.background')
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local hemeDatabox = require('libs.databox')

---------- classes -------------
local player = require ('classes.player')
local birdEnemy = require ('classes.birdEnemy')


-- -----------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here
-- -------------------------------------------------------------------------------

local runtime = 0
local scrollSpeed = 5
local heme


-------- functions  -----------
local getDeltaTime = {}
local enterFrame = {}
local touchHandler = {}
local tapHandler = {}


function getDeltaTime()
   local temp = system.getTimer()
   local dt = (temp-runtime) / (1000/60)
   runtime = temp
   return dt
end

function enterFrame()
    local dt = getDeltaTime()
    bg.moveBg(dt, scrollSpeed)
end

function scene:resumeGame()
    physics.start();
    transition.resume();    
    Runtime:addEventListener("enterFrame", enterFrame) 
end

function touchHandler(event)
    local swipeLength = math.abs(event.y - event.yStart)
    local t = event.target
    local phase = event.phase
    if "began" == phase then
        return true
    elseif "moved" == phase then
        if (event.yStart > event.y and swipeLength > 50 ) then
            transition.to( heme.shape, { time=50, y=(heme.shape.y - 180) } )
        elseif event.yStart < event.y and swipeLength > 50 then
            transition.to( heme.shape, { time=50, y=(heme.shape.y + 180) } )
            -- print( "Swiped Down", heme.shape.y )
        end
    elseif "ended" == phase or "cancelled" == phase then
                    print( "Position: ", heme.shape.y )

    end
end

function btnPauseHandler(event)
    local options = {
        isModal = true,
        effect = "fade",
        time = 400,
        params = {is_playing = true}
    }
    physics.pause();
    transition.pause();
    Runtime:removeEventListener("enterFrame", enterFrame)
    composer.showOverlay( "scenes.settings", options )
    -- physics.start();
        -- transition.resume();
        -- game_status = true
        -- composer.hideOverlay( "scenes.settings")
end


-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    game_status = true;
    local button_pause = widget.newButton({
        defaultFile = "images/menu/pause.png",
        onRelease = btnPauseHandler
    })
    button_pause.x = display.contentCenterX
    button_pause.y = display.contentHeight - 100 
    sceneGroup:insert(button_pause)

    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    bg.addScrollableBg()
    Runtime:addEventListener("touch", touchHandler)
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
        local params = {g=nil, type='bomb'}
		heme = player:newPlayer(params)
		heme:launch()

		local bird = birdEnemy:newEnemy({g=nil, x=display.contentCenterX, y=hemeGlobals.yLevel[2], xVel=-scrollSpeed*50})
		bird:spawn()


    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
        Runtime:addEventListener("enterFrame", enterFrame)
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
        Runtime:removeEventListener( "enterFrame", enterFrame )
        Runtime:removeEventListener("touch", touchHandler)

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
