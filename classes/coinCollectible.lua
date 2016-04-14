-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:36:56
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-14 00:58:40

-- Collectible: coin
-- Long term  Bonus
-- Derived from collectible class
-- can increase overall level of health, ammo and fuel


local physics = require("physics")
local collectible = require("classes.collectible")
local utils = require('libs.utils')

local _M = collectible:newCollectible({value=1, type='coinCollectible'})

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
		print("Collision of coinCollectible")
		-- collectible coin to certain extent
	end
end

function _M:tap(event)
	print("Tap of coinCollectible")
	print (event.target)
end

function _M:destroy()
	print("Destroying coinCollectible")
	if (self.shape ~= nil) then
		transition.to(self.shape, {time=100, alpha=0})
		self.shape:removeSelf( )
	end
end

return _M
