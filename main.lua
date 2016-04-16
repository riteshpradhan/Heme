-- @Author: Ritesh Pradhan
-- @Date:   2016-04-08 13:51:34
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-15 21:34:35

local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
physics.setDrawMode( 'hybrid' )

--------- globals and utils -----------
local hemeGlobals = require( "libs.globals")
local utils = require( 'libs.utils')
local hemeDatabox = require('libs.databox') -- This library automatically loads and saves it's storage into databox.json inside Documents directory


---------- classes -------------
local player = require ('classes.player')
local birdEnemy = require ('classes.birdEnemy')
-- local newAircraftEnemy = require ('classes.aircraftEnemy')
local aircraftEnemy = require ('classes.aircraftEnemy')
local dynamicBirdEnemy = require('classes.dynamicBirdEnemy')
local obs = require('classes.generalObstruction')



print("Testing player")

local params = {g=nil, type='bomb'}
local heme = player:newPlayer(params)
heme:launch()


local bird = birdEnemy:newEnemy({g=nil, x=display.contentCenterX, y=hemeGlobals.yLevel[2]})
bird:spawn()
-- local bird = birdEnemy({g=nil, type='birdEnemy', x=display.contentCenterX, y=hemeGlobals.yLevel[2]})

local aircraft = aircraftEnemy:newEnemy({g=nil, type='aircraftEnemy', x=display.contentCenterX + 300, y=hemeGlobals.yLevel[1]})
aircraft:spawn()

local dynamicBird = dynamicBirdEnemy:newEnemy({g=nil, w=20, h=50})
dynamicBird:spawn()

local tree = obs:newObstruction({g=nil, type='tree', xVel=-5})
tree:spawn()


-- Testing databox
hemeDatabox({
	isSoundOn = true,
	isMusicOn = true,
	isHelpShown = false,
})


print ("Is sound ON? : ", hemeDatabox.isSoundOn)
print ("Is ritesh present ? ? : ", hemeDatabox.ritesh)
