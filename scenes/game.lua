-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 20:30:58
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 23:59:57


local composer = require( "composer" )
local scene = composer.newScene()

local bg = require('classes.background')
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local hemeDatabox = require('libs.databox')

---------- classes -------------
local player = require ('classes.player')
local birdEnemy = require ('classes.birdEnemy')
local ground = require( 'classes.ground')

-- -----------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here
-- -------------------------------------------------------------------------------

local scoreBoardG = display.newGroup( )
local scoreBoardRect

local currentMedalText
local currentCoinText
local currentAmmoText
local currentFuelText
local currentHealthText
local currentDistanceText

local currentMedal = 0
local currentCoin = 0
local currentAmmo = hemeDatabox.ammo
local currentFuel = hemeDatabox.fuel
local currentHealth = hemeDatabox.health
local currentDistance = 0


local runtime = 0
local scrollSpeed = 5
local heme
local ground1

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

function tapHandler(event)
    print("Tapped runtime tap listener")
    heme:fire()
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    bg.addScrollableBg()

    ground1 = ground:newGround()
    ground1:spawn()

    scoreBoardRect = display.newRect(display.contentCenterX, 50, display.contentWidth, 100 )
    scoreBoardRect:setFillColor( 1, 0, 0, 0.5 )
    local eachBoxWidth = display.contentWidth/6
    local eachImageRectWidth = 0.2 * eachBoxWidth
    local eachTextRectWidth = 0.5 * eachBoxWidth

    local medalImageRect = display.newImageRect( scoreBoardG, "images/medal.png", eachImageRectWidth, 60 )
    currentMedalText = display.newText( scoreBoardG, currentMedal, 0.65 * eachBoxWidth, 50, native.systemFont, 40 )

    local coinImageRect = display.newImageRect( scoreBoardG, "images/coin.png", eachImageRectWidth, 60 )
    currentCoinText = display.newText( scoreBoardG, currentCoin, 1.65 * eachBoxWidth, 50, native.systemFont, 40 )

    local ammoImageRect = display.newImageRect( scoreBoardG, "images/ammo.png", eachImageRectWidth, 60 )
    currentAmmoText = display.newText( scoreBoardG, currentAmmo, 2.65 * eachBoxWidth, 50, native.systemFont, 40 )

    local fuelImageRect = display.newImageRect( scoreBoardG, "images/fuel.png", eachImageRectWidth, 60 )
    currentFuelText = display.newText( scoreBoardG, currentFuel, 3.65 * eachBoxWidth, 50, native.systemFont, 40 )

    local healthImageRect = display.newImageRect( scoreBoardG, "images/health.png", eachImageRectWidth, 60 )
    currentHealthText = display.newText( scoreBoardG, currentHealth, 4.65 * eachBoxWidth, 50, native.systemFont, 40 )

    local distanceImageRect = display.newImageRect( scoreBoardG, "images/distance.png", eachImageRectWidth, 60 )
    currentDistanceText = display.newText( scoreBoardG, currentDistance, 5.65 * eachBoxWidth, 50, native.systemFont, 40 )

    sceneGroup:insert(scoreBoardG)

    Runtime:addEventListener("touch", touchHandler)
    Runtime:addEventListener( "tap", tapHandler )
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

		local bird = birdEnemy:newEnemy({g=nil, x=display.contentWidth, y=hemeGlobals.yLevel[2], xVel=-scrollSpeed*30})
		bird:spawn()

		currentMedalText.text = currentMedal
		currentCoinText.text = currentCoin
		currentAmmoText.text = currentAmmo
		currentFuelText.text = currentFuel
		currentHealthText.text = currentHealth
		currentDistanceText.text = currentDistance

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
        Runtime:removeEventListener("tap", tapHandler)



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
