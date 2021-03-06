-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 21:52:06
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 14:50:29

-- This is also enemy but industrible one
-- static type; infinite mass
-- Player collide and falls to ground.
-- types
-- buildings
-- windmill

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local sounds = require( 'libs.sounds')
local utils = require('libs.utils')
local collisionFilters = require( 'libs.collisionFilters')


local _M = {tag='obstruction', type='default', w=50, h=280, x=1350, y=display.contentHeight-40, xVel=-100, yVel=0}

function _M:newObstruction(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	return o
end

function _M:spawn()
	self.shape = display.newImageRect('images/obstruction/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, display.contentHeight - self.h/2
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5, filter = collisionFilters.obstruction})
	self.shape.type = self.type
	self.shape.tag = self.tag
	self.shape.ref = self
	self.shape:setLinearVelocity( self.xVel, self.yVel )

	self.shape:addEventListener("collision", self)
	-- self.shape:addEventListener("tap", self)
end


function _M:collision(event)
	if event.phase == "began" then
		-- print("in obstruction. Player is Sensor ", event.other.isSensor)
	elseif event.phase == "ended" then
		-- print("Collision of obstruction")
		-- self:destroy()
	end

end


-- function _M:tap(event)
-- 	print("Tapped of obstruction")
-- 	print (event.target)
-- end


function _M:destroy()
	-- print("Destroying obstruction")
	if (self ~= nil and self.shape ~= nil) then
		transition.to(self, {time=1, alpha=0})
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
		-- sounds.play('powerup_destroy')
	end
end


return _M