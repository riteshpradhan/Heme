-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:39:21
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 13:44:35

-- Collectible: medal
-- Long term  Bonus
-- Derived from collectible class
-- can increase overall level of health, ammo and fuel


local physics = require("physics")
local collectible = require("classes.collectible")
local utils = require('libs.utils')

local _M = collectible:newCollectible({value=1, type='medalCollectible'})

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
	if event.phase == "began" then
		self.shape.alpha = 0
	elseif event.phase == "ended" then
		print("Collision of medalCollectible")
		-- collectible medal to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of medalCollectible")
	print (event.target)
end

function _M:destroy()
	print("Destroying medalCollectible")
	if (self.shape ~= nil) then
		transition.to(self.shape, {time=1, alpha=0})
		self.shape:removeSelf( )
	end
end

return _M
