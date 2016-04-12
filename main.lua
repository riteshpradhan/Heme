-- @Author: Ritesh Pradhan
-- @Date:   2016-04-08 13:51:34
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-12 00:34:44

local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )

local player = require ('classes.player')
local birdEnemy = require ('classes.birdEnemy')
-- local newAircraftEnemy = require ('classes.aircraftEnemy')
local aircraftEnemy = require ('classes.aircraftEnemy')
local hemeGlobals = require( "libs.globals")
local utils = require( 'libs.utils')

print("Testing player")

local params = {g=nil, type='bomb'}
local heme = player:newPlayer(params)
heme:launch()



local bird = birdEnemy:newEnemy({g=nil, x=display.contentCenterX, y=hemeGlobals.yLevel[2]})
bird:spawn()
-- local bird = birdEnemy({g=nil, type='birdEnemy', x=display.contentCenterX, y=hemeGlobals.yLevel[2]})

local aircraft = aircraftEnemy:newEnemy({g=nil, type='aircraftEnemy', x=display.contentCenterX + 300, y=hemeGlobals.yLevel[1]})
aircraft:spawn()