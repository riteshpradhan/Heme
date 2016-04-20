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
local obstruction           = require ('classes.obstruction')
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
-- local physicsBodies = {}
local displayBodies = {}

local scoreBoardG = display.newGroup( )
-- local scoreBoardRect
local allBodiesG = display.newGroup( )

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
local obstructionType = {"castle", "tree"}

-- local enemyTimer
-- local obstructionTimer
-- local refillTimer
-- local powerupTimer
-- local collectibleTimer

-------- functions  -----------
local getDeltaTime = {}
local enterFrame = {}
local touchHandler = {}
local tapHandler = {}
local onGameOver = {}
local destroyBodies = {}
local createObjects = {}



function createObjects()

    local function createEnemy()
        local yPos = math.random(3)
        if (math.random( 5 ) % 5 ) == 0 then --generates aircraft 1 out of 5 enemies
            local aircraft = aircraftEnemy:newEnemy({g=nil, x=display.contentWidth, y=hemeGlobals.yLevel[yPos], xVel=-scrollSpeed*20})
            aircraft:spawn()
            table.insert(hemeGlobals.physicsBodies, aircraft)
            allBodiesG:insert(aircraft.shape)
        else
            local bird = birdEnemy:newEnemy({g=nil, x=display.contentWidth, y=hemeGlobals.yLevel[yPos], xVel=-scrollSpeed*30, ritesh=9999})
            bird:spawn()
            table.insert(hemeGlobals.physicsBodies, bird)
            allBodiesG:insert(bird.shape)
        end
    end

    local function createObstruction()
        local obsW, obsH = math.random(75, 250), math.random( 250, 400 )
        local obs = obstruction:newObstruction({g=nil, x=display.contentWidth, xVel=-scrollSpeed*10, type=obstructionType[math.random(2)], w=obsW, h=obsH})
        obs:spawn()
        table.insert(hemeGlobals.physicsBodies, obs)
        allBodiesG:insert(obs.shape)
    end

    local function createRefill()
        local r = math.random(3)
        local yPos = math.random(3)
        if r == 1 then
            local ammor = ammoRefill:newRefill({xVel=-scrollSpeed*10, y=hemeGlobals.yLevel[yPos]})
            ammor:spawn()
            table.insert(hemeGlobals.physicsBodies, ammor)
            allBodiesG:insert(ammor.shape)
        elseif r == 2 then
            local fuelr = fuelRefill:newRefill({xVel=-scrollSpeed*15, y=hemeGlobals.yLevel[yPos]})
            fuelr:spawn()
            table.insert(hemeGlobals.physicsBodies, fuelr)
            allBodiesG:insert(fuelr.shape)
        else
            local healthr = healthRefill:newRefill({xVel=-scrollSpeed*20, y=hemeGlobals.yLevel[yPos]})
            healthr:spawn()
            table.insert(hemeGlobals.physicsBodies, healthr)
            allBodiesG:insert(healthr.shape)
        end
    end

    local function createPowerup()
        local r = math.random(3)
        local yPos = math.random(3)
        if r == 1 then
            local a = airblastPowerup:newPowerup({xVel=-scrollSpeed*12, y=hemeGlobals.yLevel[yPos]})
            a:spawn()
            table.insert(hemeGlobals.physicsBodies, a)
            allBodiesG:insert(a.shape)
        elseif r == 2 then
            local b = hyperdrivePowerup:newPowerup({xVel=-scrollSpeed*17, y=hemeGlobals.yLevel[yPos]})
            b:spawn()
            table.insert(hemeGlobals.physicsBodies, b)
            allBodiesG:insert(b.shape)
        else
            local c = plasmashieldPowerup:newPowerup({xVel=-scrollSpeed*22, y=hemeGlobals.yLevel[yPos]})
            c:spawn()
            table.insert(hemeGlobals.physicsBodies, c)
            allBodiesG:insert(c.shape)
        end
    end

    local function createCollectible()
        local yPos = math.random(3)
        if (math.random(25) % 25 == 0) then
            local m = medalCollectible:newCollectible({xVel=-scrollSpeed*30, y=hemeGlobals.yLevel[yPos]})
            m:spawn()
            table.insert(hemeGlobals.physicsBodies, m)
            allBodiesG:insert(m.shape)
        else
            local c = coinCollectible:newCollectible({xVel=-scrollSpeed*25, y=hemeGlobals.yLevel[yPos]})
            c:spawn()
            table.insert(hemeGlobals.physicsBodies, c)
            allBodiesG:insert(c.shape)
        end
    end

    local enemyTimer = timer.performWithDelay( 2000, function() createEnemy() end, -1 )
    local obstructionTimer = timer.performWithDelay( 5000, function() createObstruction() end, -1 )
    local refillTimer = timer.performWithDelay( 6000, function() createRefill() end, -1 )
    local powerupTimer = timer.performWithDelay( 10000, function() createPowerup() end, -1 )
    local collectibleTimer = timer.performWithDelay( 8000, function() createCollectible() end, -1 )

    table.insert( hemeGlobals.gameTimers, enemyTimer )
    table.insert( hemeGlobals.gameTimers, obstructionTimer )
    table.insert( hemeGlobals.gameTimers, refillTimer )
    table.insert( hemeGlobals.gameTimers, powerupTimer )
    table.insert( hemeGlobals.gameTimers, collectibleTimer )
    print ("**********************************************************************************", #hemeGlobals.gameTimers)
end

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
    physics.pause()
    transition.pause()

    print ("**********************************************************************************", #hemeGlobals.gameTimers)
    utils.pauseGameTimers(hemeGlobals.gameTimers)
    -- timer.pause(enemyTimer)
    -- timer.pause(obstructionTimer)
    -- timer.pause(refillTimer)
    -- timer.pause(powerupTimer)
    -- timer.pause(collectibleTimer)

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
    print(#hemeGlobals.physicsBodies)
    for i, obj in ipairs( hemeGlobals.physicsBodies ) do
        print( "Start destruction .... ")
        print(i, obj)
        if (obj.bodyType ~= nil) then
            print("...", obj.tag)
           -- physics.removeBody( obj )
           obj:destroy()
        elseif (obj.shape ~= nil and obj.shape.bodyType ~= nil) then
            print("... ...", obj.shape.type)
           -- physics.removeBody( obj.shape )
           obj:destroy()
        end
        utils.print_table(obj.shape)
        print("End destruction .... ")
    end
    hemeGlobals.physicsBodies = {} -- clear

    -- destroy display bodies
    displayBodies = {}
end


function onGameOver()
    print ("Game is over: dispatched")
    Runtime:removeEventListener("enterFrame", enterFrame)
    -- transition.cancel()
    -- destroyBodies()

    local params = {distance = currentDistance, medal = currentMedal, coin = currentCoin }
    local sceneOpt = {effect = "crossFade", time = 1000, params=params}
    sounds.stop(25)
    composer.gotoScene("scenes.gameover", sceneOpt)
end



-- function scene:enterFrame(event)
--     local dt = getDeltaTime()
--     bg:moveBg(dt, scrollSpeed)
-- end


function scene:resumeGame()
    physics.start();
    transition.resume();

    -- timer.resume(enemyTimer)
    -- timer.resume(obstructionTimer)
    -- timer.resume(refillTimer)
    -- timer.resume(powerupTimer)
    -- timer.resume(collectibleTimer)

    utils.resumeGameTimers(hemeGlobals.gameTimers)
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


    -- local medalImageRect = display.newImageRect( scoreBoardG, "images/medal.png", eachImageRectWidth, 60 )
    -- currentMedalText = display.newText( scoreBoardG, currentMedal, 0.6 * eachBoxWidth, 40, "fonts/Mistral.ttf", 55 )
    currentMedalText = display.newText( scoreBoardG, currentMedal, 0.6 * eachBoxWidth, 40, native.systemFont, 55 )
    currentMedalText:setFillColor(1,1,0)

    -- local coinImageRect = display.newImageRect( scoreBoardG, "images/coin.png", eachImageRectWidth, 60 )
    -- currentCoinText = display.newText( scoreBoardG, currentCoin, 1.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentCoinText = display.newText( scoreBoardG, currentCoin, 1.65 * eachBoxWidth, 40, native.systemFont, 55 )
    currentCoinText:setFillColor(1,1,0)

    -- local ammoImageRect = display.newImageRect( scoreBoardG, "images/ammo.png", eachImageRectWidth, 60 )
    -- currentAmmoText = display.newText( scoreBoardG, currentAmmo, 2.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentAmmoText = display.newText( scoreBoardG, currentAmmo, 2.65 * eachBoxWidth, 40, native.systemFont, 55 )
    currentAmmoText:setFillColor(1,1,0)

    -- local fuelImageRect = display.newImageRect( scoreBoardG, "images/fuel.png", eachImageRectWidth, 60 )
    -- currentFuelText = display.newText( scoreBoardG, currentFuel, 3.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentFuelText = display.newText( scoreBoardG, currentFuel, 3.65 * eachBoxWidth, 40, native.systemFont, 55 )
    currentFuelText:setFillColor(1,1,0)

    -- local healthImageRect = display.newImageRect( scoreBoardG, "images/health.png", eachImageRectWidth, 60 )
    -- currentHealthText = display.newText( scoreBoardG, currentHealth, 4.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentHealthText = display.newText( scoreBoardG, currentHealth, 4.65 * eachBoxWidth, 40, native.systemFont, 55 )
    currentHealthText:setFillColor(1,1,0)

    -- local distanceImageRect = display.newImageRect( scoreBoardG, "images/distance.png", eachImageRectWidth, 60 )
    -- currentDistanceText = display.newText( scoreBoardG, currentDistance, 5.65 * eachBoxWidth, 40, "/fonts/Mistral.ttf", 55 )
    currentDistanceText = display.newText( scoreBoardG, currentDistance, 5.65 * eachBoxWidth, 40, native.systemFont, 55 )
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

    if(hemeDatabox.isMusicOn) then
        if(audio.isChannelPlaying( 25 )) then
            sounds.stop(25)
        end
        sounds.play('bg_music_game', {loops = -1, channel = 25})
    end

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)

        physics.start()
        -- physics.setGravity( 0, 0 )
        hemeGlobals.physicsBodies = {}
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
        createObjects()



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
        sceneGroup:insert( allBodiesG )

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

        --cancel timer
        -- timer.cancel(enemyTimer)
        -- timer.cancel(obstructionTimer)
        -- timer.cancel(refillTimer)
        -- timer.cancel(powerupTimer)
        -- timer.cancel(collectibleTimer)

        utils.cancelGameTimers(hemeGlobals.gameTimers)

        --stop Animation
        transition.cancel( )

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
        physics.pause( )
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
