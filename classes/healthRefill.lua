-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:19:41
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-13 23:30:04

-- Refill: health
-- Instant Bonus
-- Derived from refill class


local physics = require("physics")
local refill = require("classes.refill")
local utils = require('libs.utils')

local _M = refill:newRefill({value=15, type='healthRefill'})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	-- self:move()
end


_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end


function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of healthRefill")
		-- refill health to certain extent
	end
end

function _M:tap(event)
	print("Tap of healthRefill")
	print (event.target)
end

function _M:destroy()
	print("Destroying healthRefill")
	if (self.shape ~= nil) then
		transition.to(self.shape, {time=100, alpha=0})
		self.shape:removeSelf( )
	end
end


return _M
