-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 00:55:25
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 20:13:20


-- Powerup: airblast
-- Super amazing power up; Blows nearby enemies;  if possible :D
-- Derived from powerup Class
-- can cause severe damages to enemies


local physics = require("physics")
local powerup = require("classes.powerup")
local utils = require('libs.utils')

local _M = powerup:newPowerup({damage=10, type='airblastPowerup'})

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
		print("Collision of airblastPowerup")
		-- collectible coin to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of airblastPowerup")
	print (event.target)
end

return _M
