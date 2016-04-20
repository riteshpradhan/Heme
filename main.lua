-- @Author: Ritesh Pradhan
-- @Date:   2016-04-08 13:51:34
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 18:33:09

local physics = require( "widget" )
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
-- physics.setDrawMode( 'hybrid' )


--------- globals and utils -----------
-- local hemeGlobals = require( "libs.globals")
-- local utils = require( 'libs.utils')
local hemeDatabox = require('libs.databox') -- This library automatically loads and saves it's storage into databox.json inside Documents directory
local sounds = require( "libs.sounds" );

-- ---------- classes -------------
-- local player = require ('classes.player')
-- local birdEnemy = require ('classes.birdEnemy')
-- -- local newAircraftEnemy = require ('classes.aircraftEnemy')
-- local aircraftEnemy = require ('classes.aircraftEnemy')
-- local dynamicBirdEnemy = require('classes.dynamicBirdEnemy')
-- local obs = require('classes.generalObstruction')


local composer = require( "composer" )
-- local scene = composer.newScene()

-- local toast = require('plugin.toast')
-- ----------------------------------------------------
-- -------------- Initialization -----------
hemeDatabox()
sounds.isSoundOn = hemeDatabox.isSoundOn
sounds.isMusicOn = hemeDatabox.isMusicOn

-- ------------------------------------------

-- print("Testing player")

-- local params = {g=nil, type='bomb'}
-- local heme = player:newPlayer(params)
-- heme:launch()


-- local bird = birdEnemy:newEnemy({g=nil, x=display.contentCenterX, y=hemeGlobals.yLevel[2]})
-- bird:spawn()
-- local bird = birdEnemy({g=nil, type='birdEnemy', x=display.contentCenterX, y=hemeGlobals.yLevel[2]})

-- local aircraft = aircraftEnemy:newEnemy({g=nil, type='aircraftEnemy', x=display.contentCenterX + 300, y=hemeGlobals.yLevel[1]})
-- aircraft:spawn()

-- local dynamicBird = dynamicBirdEnemy:newEnemy({g=nil, w=20, h=50})
-- dynamicBird:spawn()

-- local tree = obs:newObstruction({g=nil, type='tree', xVel=-5})
-- tree:spawn()


-------------  Testing databox -----------------------
-- print ("Is sound ON? : ", hemeDatabox.isSoundOn)
-- print ("Ammo: ", hemeDatabox.ammo)
-- print ("Is ritesh present ? : ", hemeDatabox.ritesh)
-- hemeDatabox.ritesh = 999
-- print ("Is ritesh present ? : ", hemeDatabox.ritesh)
-- hemeDatabox.ammo = hemeDatabox.ammo + 1
-- hemeDatabox({ ["ammo"] = 100, bbbbbbbb= 8})
-- print(type(hemeDatabox))

-- ------------------------------------------------------
-- ------------- alert test ----------------------------
-- ---- physics pause -----
-- ---- transition pause -----

-- local options = {effect='fade', time=1000}
-- native.showAlert('Corona Cannon', 'Are you sure you want to go to menu?', {'Yes', 'Cancel'}, function(event)
-- 		if event.action == 'clicked' and event.index == 1 then
-- 			physics.pause()
-- 			transition.pause()
-- 			composer.gotoScene( 'scenes.menu', options )
-- 		end
-- 	end)
-----------------------------------------------------



-- composer.gotoScene( 'scenes.store',  options)

-- composer.gotoScene( 'scenes.game', options )

--------------------- Kush Code ---------------------------------
-----------------------------------------------------------------

local sceneOpt = {
					effect = "flipFadeOutIn",
					time = 200
				}
composer.gotoScene("scenes.menu", sceneOpt)
