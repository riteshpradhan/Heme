-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:25:32
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 19:31:44

-- Refill: ammo
-- Instant Bonus
-- Derived from refill class


local physics = require("physics")
local refill = require("classes.refill")
local utils = require('libs.utils')

local _M = refill:newRefill({value=5, type='ammoRefill'})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	-- self:move()
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of ammoRefill")
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of ammoRefill")
	print (event.target)
end


return _M
