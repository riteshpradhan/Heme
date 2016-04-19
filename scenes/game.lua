-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 20:30:58



local physics = require("physics")
-- physics.start()

local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

local background = require('classes.background')
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local sounds = require( "libs.sounds" );
local hemeDatabox = require('libs.databox')

---------- classes -------------
local player                = require ('classes.player')
local ground                = require( 'classes.ground')
local newShiva              = require( 'classes.shiva').newShiva

local birdEnemy             = require ('classes.birdEnemy')
local aircraftEnemy         = require ('classes.aircraftEnemy')
local generalObstruction    = require ('classes.generalObstruction')
local ammoRefill            = require ('classes.ammoRefill')
local fuelRefill            = require ('classes.fuelRefill')
local healthRefill          = require ('classes.healthRefill')
local airblastPowerup       = require ('classes.airblastPowerup')
local hyperdrivePowerup     = require ('classes.hyperdrivePowerup')
local plasmashieldPowerup   = require ('classes.plasmashieldPowerup')
local coinCollectible       = require ('classes.coinCollectible')
local medalCollectible      = require ('classes.medalCollectible')




-- -----------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here
-- -------------------------------------------------------------------------------
local physicsBodies = {}
local displayBodies = {}

local scoreBoardG = display.newGroup( )
-- local scoreBoardRect

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
local scrollSpeed = hemeGlobals.scrollSpeed
local heme
local ground1
local lordShiva
local counter = 0
local button_pause

-------- functions  -----------
local getDeltaTime = {}
local enterFrame = {}
local touchHandler = {}
local tapHandler = {}
local onGameOver = {}
local destroyBodies = {}




function getDeltaTime()
   local temp = system.getTimer()
   local dt = (temp-runtime) / (1000/60)
   runtime = temp
   return dt
end


function touchHandler(event)
    local swipeLength = math.abs(event.y - event.yStart)
    local t = event.target
    local phase = event.phase
    if "began" == phase then
        return true
    elseif "moved" == phase then
        if (event.yStart > event.y and swipeLength > 50 ) then
            if (heme.shape.y == hemeGlobals.yLevel[1]) then
                transition.to( heme.shape, { time=50, y=hemeGlobals.yLevel[2] } )
                transition.to( heme.playerSprite, { time=50, y=hemeGlobals.yLevel[2] } )
            elseif (heme.shape.y == hemeGlobals.yLevel[2]) then
                transition.to( heme.shape, { time=50, y=hemeGlobals.yLevel[3] } )
                transition.to( heme.playerSprite, { time=50, y=hemeGlobals.yLevel[3] } )
            end
        elseif event.yStart < event.y and swipeLength > 50 then
            if (heme.shape.y == hemeGlobals.yLevel[3]) then
                transition.to( heme.shape, { time=50, y=hemeGlobals.yLevel[2] } )
                transition.to( heme.playerSprite, { time=50, y=hemeGlobals.yLevel[2] } )
            elseif (heme.shape.y == hemeGlobals.yLevel[2]) then
                transition.to( heme.shape, { time=50, y=hemeGlobals.yLevel[1] } )
                transition.to( heme.playerSprite, { time=50, y=hemeGlobals.yLevel[1] } )
            end
        end
    elseif "ended" == phase or "cancelled" == phase then
                    print( "Position: ", heme.shape.y , heme.shape.x)
    end
end


function tapHandler(event)
    print("Tapped runtime tap listener")
    heme:fire()
end


function btnPauseHandler(event)
    sounds.play('pause')
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


function enterFrame()
    if hemeGlobals.isGameOver then
        onGameOver()
    end
    local dt = getDeltaTime()
    bg:moveBg(dt, scrollSpeed)

    counter = counter + 1
    if (counter % 20) == 0 then
        currentDistance = currentDistance + scrollSpeed/hemeGlobals.scrollSpeed
        currentDistanceText.text = currentDistance
        if (currentDistance == 20) then
            scrollSpeed = scrollSpeed + 5
        end
    end
end


function destroyBodies()
    -- destroy physics bodies
    print(#physicsBodies)
    for i, obj in ipairs( physicsBodies ) do
        print( "Start destruction .... ", obj.shape.bodyType)
        print(i, obj)
        print("...")
        if (obj.bodyType ~= nil) then
           -- physics.removeBody( obj )
           obj:destroy()
        elseif (obj.shape ~= nil and obj.shape.bodyType ~= nil) then
           -- physics.removeBody( obj.shape )
           obj:destroy()
        end
        utils.print_table(obj.shape)
        print("End destruction .... ")
    end
    physicsBodies = {} -- clear

    -- destroy display bodies
    displayBodies = {}
end


function onGameOver()
    print ("Game is over: dispatched")
    Runtime:removeEventListener("enterFrame", enterFrame)
    transition.cancel()
    destroyBodies()
    physics.stop( )
end


function scene:enterFrame(event)
    local dt = getDeltaTime()
    bg:moveBg(dt, scrollSpeed)
end


function scene:resumeGame()
    physics.start();
    transition.resume();
    Runtime:addEventListener("enterFrame", enterFrame)
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    button_pause = widget.newButton({
        defaultFile = "images/menu/pause.png",
        onRelease = btnPauseHandler,
    })
    button_pause.alpha=0.5
    button_pause.x = display.contentCenterX
    button_pause.y = display.contentHeight - 100
    sceneGroup:insert(button_pause)

    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local bgImage = { type="image", filename="images/scenes/bg.jpg" }
    bg = background:newBackground()
    bg:addScrollableBg(bgImage)





    -- scoreBoardRect = display.newRect(display.contentCenterX, 50, display.contentWidth, 100 )
    -- scoreBoardRect:setFillColor( 1, 0, 0, 0.5 )

    local scoreBoardImage = display.newImage("images/scenes/scoreBoardIcons.png")
    scoreBoardImage.x = display.contentCenterX;
    scoreBoardImage.y = 36;
    scoreBoardImage:toFront();


    local eachBoxWidth = display.contentWidth/6
    local eachImageRectWidth = 0.2 * eachBoxWidth
    local eachTextRectWidth = 0.5 * eachBoxWidth


    local medalImageRect = display.newImageRect( scoreBoardG, "images/medal.png", eachImageRectWidth, 60 )
    currentMedalText = display.newText( scoreBoardG, currentMedal, 0.6 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentMedalText:setFillColor(1,1,0)

    local coinImageRect = display.newImageRect( scoreBoardG, "images/coin.png", eachImageRectWidth, 60 )
    currentCoinText = display.newText( scoreBoardG, currentCoin, 1.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentCoinText:setFillColor(1,1,0)

    local ammoImageRect = display.newImageRect( scoreBoardG, "images/ammo.png", eachImageRectWidth, 60 )
    currentAmmoText = display.newText( scoreBoardG, currentAmmo, 2.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentAmmoText:setFillColor(1,1,0)

    local fuelImageRect = display.newImageRect( scoreBoardG, "images/fuel.png", eachImageRectWidth, 60 )
    currentFuelText = display.newText( scoreBoardG, currentFuel, 3.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentFuelText:setFillColor(1,1,0)

    local healthImageRect = display.newImageRect( scoreBoardG, "images/health.png", eachImageRectWidth, 60 )
    currentHealthText = display.newText( scoreBoardG, currentHealth, 4.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentHealthText:setFillColor(1,1,0)

    local distanceImageRect = display.newImageRect( scoreBoardG, "images/distance.png", eachImageRectWidth, 60 )
    currentDistanceText = display.newText( scoreBoardG, currentDistance, 5.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentDistanceText:setFillColor(1,1,0)

    sceneGroup:insert(scoreBoardG)

    print("Table")
    print(bg.bg1)
    utils.print_table(bg)
    sceneGroup:insert( bg.bg1 )
    sceneGroup:insert( bg.bg2 )
    sceneGroup:insert(scoreBoardImage);

    -- Runtime:addEventListener( "onGameOver", listener )
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)

        physics.start()
        physicsBodies = {}
        hemeGlobals.isGameOver = false

        button_pause:toFront();
        -- Single player Instance
        local params = {g=nil, type='heme', ammo=55}
		heme = player:newPlayer(params)
		heme:launch()

        -- Single ground Instance
        ground1 = ground:newGround()
        ground1:spawn()

        -- Single left off screen instance
        lordShiva = newShiva()

        -- Randomly generate many enemies; powerups; refills; collectible
        -- insert all into physicsBodies
        print("Scroll speed is : ", scrollSpeed)
		local bird = birdEnemy:newEnemy({g=nil, x=display.contentWidth, y=hemeGlobals.yLevel[2], xVel=-scrollSpeed*30, ritesh=9999})
		bird:spawn()
        table.insert(physicsBodies, bird)

        local aircraft = aircraftEnemy:newEnemy({g=nil, x=display.contentWidth, y=hemeGlobals.yLevel[1], xVel=-scrollSpeed*20})
        aircraft:spawn()
        table.insert(physicsBodies, aircraft)

        -- table.insert(physicsBodies, ground1)

		currentMedalText.text = currentMedal
		currentCoinText.text = currentCoin
		currentAmmoText.text = currentAmmo
		currentFuelText.text = currentFuel
		currentHealthText.text = currentHealth
		currentDistanceText.text = currentDistance


        sceneGroup:insert( scoreBoardG )
        sceneGroup:insert( heme.shape )
        sceneGroup:insert( heme.playerSprite )
        sceneGroup:insert( scoreBoardG )
        sceneGroup:insert( ground1.shape )
        sceneGroup:insert( lordShiva )

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
        Runtime:addEventListener("touch", touchHandler)
        Runtime:addEventListener( "tap", tapHandler )
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

        -- destroy physical objects
        if(heme ~= nil) then
            heme:destroy()
        end
        if(ground1 ~= nil) then
            ground1:destroy()
        end
        if(lordShiva ~= nil) then
            lordShiva:destroy()
        end
        -- destroy all other bodies
        destroyBodies()

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
-- scene:addEventListener( "enterFrame", scene )
-- -------------------------------------------------------------------------------

return scene
