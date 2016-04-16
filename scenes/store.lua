-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 00:33:25
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 15:37:02




local composer = require( "composer" )
local scene = composer.newScene()
local toast = require('plugin.toast')

local hemeDatabox = require('libs.databox')


-- Local forward references should go here
-- -------------------------------------------------------------------------------
hemeDatabox.coin = 1000


local currentAmmo = hemeDatabox.ammo
local currentFuel = hemeDatabox.fuel
local currentHealth = hemeDatabox.health
local currentCoin = hemeDatabox.coin
local currentMedal = hemeDatabox.medal


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
		toast.show("Insufficient Fund!")
	else
		currentMedal = currentMedal - hemeDatabox.medalBuyCoin
		currentCoin = currentCoin + hemeDatabox.coinAdd

		topCurrentMedalT.text = currentMedal
		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
	end
end

function buyAmmo(event)
	if (currentCoin < hemeDatabox.coinBuyAmmo) then
		toast.show("Insufficient Fund!")
	else
		currentCoin = currentCoin - hemeDatabox.coinBuyAmmo
		currentAmmo = currentAmmo + hemeDatabox.ammoAdd

		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
		ammoCurrentT.text = currentAmmo
	end
end

function buyFuel(event)
	if (currentCoin < hemeDatabox.coinBuyFuel) then
		toast.show("Insufficient Fund!")
	else
		currentCoin = currentCoin - hemeDatabox.coinBuyFuel
		currentFuel = currentFuel + hemeDatabox.fuelAdd

		topCurrentCoinT.text = currentCoin
		coinCurrentT.text = currentCoin
		fuelCurrentT.text = currentFuel

	end
end

function buyHealth(event)
	if (currentCoin < hemeDatabox.coinBuyHealth) then
		toast.show("Insufficient Fund!")
	else
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
    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.

    -- 60 - 245 - 60 - 245 - 60 - 245 - 60 - 245 - 60

    topCurrentMedalT = display.newText( topBarG, currentMedal, 100, 50, native.systemFont, 40)
    topCurrentCoinT = display.newText( topBarG, currentCoin, display.contentWidth - 100, 50, native.systemFont, 40)
    topBarG:insert( topCurrentMedalT )
    topBarG:insert( topCurrentCoinT )
    storeG:insert( topBarG )

    local coinR = display.newRect( coinStoreG, 180, 300, 240, 400 ); coinR:setFillColor( 1, 0, 0 )
    local coinB = display.newRect( coinStoreG, 180, 570, 240, 100 ); coinB:setFillColor( .8,.8,.8 )
    local coinRT = display.newText( coinStoreG, "+"..hemeDatabox.coinAdd, 180, 230, native.systemFont,	40)
    coinCurrentT = display.newText( coinStoreG, currentCoin, 180, 470, native.systemFont,	40)
    local coinBT = display.newText( coinStoreG, hemeDatabox.medalBuyCoin, 180, 570, native.systemFont, 40)
    coinBT:setFillColor( 0,0,0 )

    local ammoR = display.newRect( ammoG, 480, 300, 240, 400 ); ammoR:setFillColor( 1, 0, 0 )
    local ammoB = display.newRect( ammoG, 480, 570, 240, 100 )
    local ammoRT = display.newText( ammoG, "+"..hemeDatabox.ammoAdd, 480, 230, native.systemFont,	40)
    ammoCurrentT = display.newText( ammoG, currentAmmo, 480, 470, native.systemFont,	40)
    local ammoBT = display.newText( ammoG, hemeDatabox.coinBuyAmmo, 480, 570, native.systemFont,	40 )
    ammoBT:setFillColor( 0,0,0 )

    local fuelR = display.newRect( fuelG, 780, 300, 240, 400 ); fuelR:setFillColor( 1, 0, 0 )
    local fuelB = display.newRect( fuelG, 780, 570, 240, 100 )
    local fuelRT = display.newText( fuelG, "+"..hemeDatabox.fuelAdd, 780, 230, native.systemFont,	40 )
    fuelCurrentT = display.newText( fuelG, currentFuel, 780, 470, native.systemFont,	40)
    local fuelBT = display.newText( fuelG, hemeDatabox.coinBuyFuel, 780, 570, native.systemFont,	40 )
    fuelBT:setFillColor( 0,0,0 )

    local healthR = display.newRect( healthG, 1080, 300, 240, 400 ); healthR:setFillColor( 1, 0, 0 )
    local healthB = display.newRect( healthG, 1080, 570, 240, 100 )
    local healthRT = display.newText( healthG, "+"..hemeDatabox.healthAdd, 1080, 230, native.systemFont,	40 )
    healthCurrentT = display.newText( healthG, currentHealth, 1080, 470, native.systemFont,	40)
    local healthBT = display.newText( healthG, hemeDatabox.coinBuyHealth, 1080, 570, native.systemFont,	40 )
    healthBT:setFillColor( 0,0,0 )


    coinB:addEventListener( "tap", buyCoin )
    ammoB:addEventListener( "tap", buyAmmo )
    fuelB:addEventListener( "tap", buyFuel )
    healthB:addEventListener( "tap", buyHealth )

    storeG:insert( coinStoreG )
    storeG:insert( ammoG )
    storeG:insert( fuelG )
    storeG:insert( healthG )
    -- storeG.y = storeG.y + 50

    sceneGroup:insert( storeG )

end


-- "scene:show()"
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
        topCurrentMedalT.text = currentMedal
		topCurrentCoinT.text = currentCoin

		coinCurrentT.text = currentCoin
		ammoCurrentT.text = currentAmmo
		fuelCurrentT.text = currentFuel
		healthCurrentT.text = currentHealth

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
		hemeDatabox.coin = currentCoin
		hemeDatabox.medal = currentMedal
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
