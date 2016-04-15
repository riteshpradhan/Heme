-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 21:52:06
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-14 22:39:51

-- This is also enemy but industrible one
-- static type; infinite mass
-- Player collide and falls to ground.
-- types
-- buildings
-- windmill

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')

local _M = {tag='obstruction', type='default', w=30, h=80, x=830, y=hemeGlobals.yLevel[1], xVel=-100, yVel=0}

function _M:newObstruction(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In obstruction")
	utils.print_table(o)
	return o
end

function _M:spawn()
	print("obstruction self: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/obstruction/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5})
	self.shape.type = self.type
	self.shape:setLinearVelocity( self.xVel, self.yVel )

	self.shape:addEventListener("collision", self)
	self.shape:addEventListener("tap", self)
end


function _M:collision(event)
	if event.phase == "ended" then
	-- print("Collision of obstruction")
	end

end


function _M:tap(event)
	print("Tapped of obstruction")
	print (event.target)
end


function _M:destroy()
	print("Destroying obstruction")
	if (self ~= nil) then
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end


return _M