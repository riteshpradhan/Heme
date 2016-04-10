-- @Author: Ritesh Pradhan
-- @Date:   2016-04-08 13:51:34
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-10 13:59:42

local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )

local player = require ('classes.player')


print("Testing player")

params = {g=nil, type='bomb'}
local heme = player:newPlayer(params)
heme:launch()