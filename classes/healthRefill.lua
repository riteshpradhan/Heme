-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:19:41
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 19:32:22

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

function _M:collision(event)
	if event.phase == "began" then
		self.shape.alpha = 0
	elseif event.phase == "ended" then
		print("Collision of healthRefill")
		-- refill health to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of healthRefill")
	print (event.target)
end


return _M
