-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 01:00:17
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 19:33:15


-- Powerup: hyperdrive
-- Super amazing power up; Passes at enormous speed;  if possible :D
-- Derived from powerup Class
-- can cause no health damage of player


local physics = require("physics")
local powerup = require("classes.powerup")
local utils = require('libs.utils')

local _M = powerup:newPowerup({damage=10, type='hyperdrivePowerup'})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.shape.damage = self.damage
end


_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of hyperdrivePowerup")
		-- collectible coin to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of hyperdrivePowerup")
	print (event.target)
end

return _M
