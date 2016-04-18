-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 01:02:00
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 19:34:09

-- Powerup: plasmashield
-- Super amazing power up; No collision with enemy;  if possible :D
-- Derived from powerup Class
-- can cause no health damage of player


local physics = require("physics")
local powerup = require("classes.powerup")
local utils = require('libs.utils')

local _M = powerup:newPowerup({damage=10, type='plasmashieldPowerup'})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.shape.damage = self.damage
end


function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of plasmashieldPowerup")
		-- collectible coin to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of plasmashieldPowerup")
	print (event.target)
end


return _M
