-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 00:33:25
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 01:54:15




local composer = require( "composer" )
local scene = composer.newScene()
local toast = require('plugin.toast')
local widget = require("widget")
local sounds = require( "libs.sounds" );
local images = require("libs.images")

local hemeDatabox = require('libs.databox')


-- Local forward references should go here
-- -------------------------------------------------------------------------------


local currentAmmo = hemeDatabox.ammo
local currentFuel = hemeDatabox.fuel
local currentHealth = hemeDatabox.health
local currentCoin = hemeDatabox.totalCoin
local currentMedal = hemeDatabox.totalMedal


local storeG = display.newGroup()
local coinStoreG = display.newGroup()
local ammoG = display.newGroup()
local fuelG = display.newGroup()
local healthG = display.newGroup()
local topBarG = display.newGroup( )

local topCurrentMedalT
local topCurrentCoinT

local coinCurrentT
local ammoCurrentT
local fuelCurrentT
local healthCurrentT

local buyCoin = {}
local buyAmmo = {}
local buyFuel = {}
local buyHealth = {}


print("IN store: Coin: ", currentCoin)


function buyCoin(event)
	if (currentMedal < hemeDatabox.medalBuyCoin) then
        sounds.play('insufficient_fund')
		toast.show("Insufficient Medal!")
	else
        sounds.play('purchase_coin')
		currentMedal = currentMedal - hemeDatabox.medalBuyCoin
		currentCoin = currentCoin + hemeDatabox.coinAdd

		topCurrentMedalT.text = currentMedal
		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
	end
end

function buyAmmo(event)
	if (currentCoin < hemeDatabox.coinBuyAmmo) then
        sounds.play('insufficient_fund')
		toast.show("Insufficient Fund!")
	else
        sounds.play('purchase_ammo')
		currentCoin = currentCoin - hemeDatabox.coinBuyAmmo
		currentAmmo = currentAmmo + hemeDatabox.ammoAdd

		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
		ammoCurrentT.text = currentAmmo
	end
end

function buyFuel(event)
	if (currentCoin < hemeDatabox.coinBuyFuel) then
        sounds.play('insufficient_fund')
		toast.show("Insufficient Fund!")
	else
        sounds.play('purchase_fuel')
		currentCoin = currentCoin - hemeDatabox.coinBuyFuel
		currentFuel = currentFuel + hemeDatabox.fuelAdd

		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
		fuelCurrentT.text = currentFuel

	end
end

function buyHealth(event)

	if (currentCoin < hemeDatabox.coinBuyHealth) then
        sounds.play('insufficient_fund')
		toast.show("Insufficient Fund!")
	else
        sounds.play('purchase_health')
		currentCoin = currentCoin - hemeDatabox.coinBuyHealth
		currentHealth = currentHealth + hemeDatabox.healthAdd

		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
		healthCurrentT.text = currentHealth
	end
end

-- "scene:create()"
function scene:create( event )
    local sceneGroup = self.view

    local function btnBackHandler(event)
        sounds.play('back')
        local sceneOpt = {effect = "slideRight", time = 800}
        composer.gotoScene("scenes.menu", sceneOpt)
    end


    local backButton = widget.newButton(
        {
            x = 125,
            y = 70,
            sheet = images.backButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onRelease = btnBackHandler
        }
    )





    -- Initialize the scene here
    local storeBG = display.newImage('images/scenes/store.jpg')
    storeBG.x = display.contentCenterX;
    storeBG.y = display.contentCenterY;

    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    -- 60 - 245 - 60 - 245 - 60 - 245 - 60 - 245 - 60

    topCurrentMedalT = display.newText( topBarG, currentMedal, display.contentWidth - 300, 60, "Comic Sans MS", 40)
    topCurrentCoinT = display.newText( topBarG, currentCoin, display.contentWidth - 100, 60, "Comic Sans MS", 40)
    topCurrentMedalT:setFillColor( 1,1,0 )
    topCurrentCoinT:setFillColor( 1,1,0 )
    topBarG:insert( topCurrentMedalT )
    topBarG:insert( topCurrentCoinT )


    coinCurrentT = display.newText( coinStoreG, currentCoin, 160, 180, "Comic Sans MS",   40)
    local coinRT = display.newText( coinStoreG, "+"..hemeDatabox.coinAdd, 150, 485, "Comic Sans MS",	40)

    ammoCurrentT = display.newText( ammoG, currentAmmo, 490, 180, "Comic Sans MS",  40)
    local ammoRT = display.newText( ammoG, "+"..hemeDatabox.ammoAdd, 470, 485, "Comic Sans MS",	40)

    fuelCurrentT = display.newText( fuelG, currentFuel, 800, 180, "Comic Sans MS",  40)
    local fuelRT = display.newText( fuelG, "+"..hemeDatabox.fuelAdd, 780, 485, "Comic Sans MS",	40 )

    healthCurrentT = display.newText( healthG, currentHealth, 1120, 180, "Comic Sans MS",   40)
    local healthRT = display.newText( healthG, "+"..hemeDatabox.healthAdd, 1100, 485, "Comic Sans MS",	40 )


    local medalButton = widget.newButton(
        {
            x = 165,
            y = 600,
            font = "Comic Sans MS",
            fontSize = 40,
            sheet = images.storeButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            label = "M "..hemeDatabox.medalBuyCoin,
            labelColor = { default={ 0, 0.5, 0 }, over={ 0, 0, 0, 0.5 } },
            onRelease = buyCoin
        }
    )

    local ammoButton = widget.newButton(
        {
            x = 485,
            y = 600,
            font = "Comic Sans MS",
            fontSize = 40,
            sheet = images.storeButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            label = "$"..hemeDatabox.coinBuyAmmo,
            labelColor = { default={ 0, 0.5, 0 }, over={ 0, 0, 0, 0.5 } },
            onRelease = buyAmmo
        }
    )

    local fuelButton = widget.newButton(
        {
            x = 805,
            y = 600,
            font = "Comic Sans MS",
            fontSize = 40,
            sheet = images.storeButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            label = "$"..hemeDatabox.coinBuyFuel,
            labelColor = { default={ 0, 0.5, 0 }, over={ 0, 0, 0, 0.5 } },
            onRelease = buyFuel
        }
    )

    local healthButton = widget.newButton(
        {
            x = 1125,
            y = 600,
            font = "Comic Sans MS",
            fontSize = 40,
            sheet = images.storeButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            label = "$"..hemeDatabox.coinBuyHealth,
            labelColor = { default={ 0, 0.5, 0 }, over={ 0, 0, 0, 0.5 } },
            onRelease = buyHealth
        }
    )


    storeG:insert( storeBG )
    storeG:insert( topBarG )
    storeG:insert( coinStoreG )
    storeG:insert( ammoG )
    storeG:insert( fuelG )
    storeG:insert( healthG )
    storeG:insert( medalButton )
    storeG:insert( ammoButton )
    storeG:insert( fuelButton )
    storeG:insert( healthButton )


    -- storeG.y = storeG.y + 50

    sceneGroup:insert( storeG )
    sceneGroup:insert(backButton)

end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)

        currentAmmo = hemeDatabox.ammo
        currentFuel = hemeDatabox.fuel
        currentHealth = hemeDatabox.health
        currentCoin = hemeDatabox.totalCoin
        currentMedal = hemeDatabox.totalMedal

        topCurrentMedalT.text = hemeDatabox.totalMedal
		topCurrentCoinT.text = hemeDatabox.totalCoin

		coinCurrentT.text = hemeDatabox.totalCoin
		ammoCurrentT.text = hemeDatabox.ammo
		fuelCurrentT.text = hemeDatabox.fuel
		healthCurrentT.text = hemeDatabox.health


    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
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
        hemeDatabox.ammo = currentAmmo
		hemeDatabox.fuel = currentFuel
		hemeDatabox.health = currentHealth
		hemeDatabox.totalCoin = currentCoin
		hemeDatabox.totalMedal = currentMedal

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
