-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:42:01
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-15 20:36:30

-- This powerup is used at the instant of consumption. Amazing powerups
-- airblast
-- hyperdrive
-- plasmashield

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local collisionFilters = require( 'libs.collisionFilters')

local _M = {tag='powerup', type='default', w=50, h=50, x=1030, y=hemeGlobals.yLevel[1], xVel=-10, yVel=0}

function _M:newPowerup(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In powerup")
	utils.print_table(o)
	return o
end

function _M:spawn()
	print("powerup self: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/powerup/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5, filter = collisionFilters.powerup})
	self.shape.isSensor = true
	self.shape.type = self.type
	-- self.shape:applyLinearImpulse(-5, 0, self.shape.x, self.shape.y)
	self.shape:setLinearVelocity( self.xVel, self.yVel )


	self.shape:addEventListener("collision", self)
	self.shape:addEventListener("tap", self)
end

function _M:move()
	print("In move here :", self.y, hemeGlobals.yLevel[1])
	if (self.y == hemeGlobals.yLevel[1]) then
		self:moveUp()
	else
		self:moveDown()
	end
end

function _M:moveDown()
	self.x = self.x - 20
	local time = math.random(1000,3000)
	transition.to(self.shape, {time=time, y=self.y+100, x=self.x-20, onComplete=function() self:moveUp() end})
end

function _M:moveUp()
	self.x = self.x - 20
	local time = math.random(1000,3000)
	transition.to(self.shape, {time=time, y=self.y-100, x=self.x-20, onComplete=function() self:moveDown() end})
end

function _M:collision(event)
	if event.phase == "ended" then
	-- print("Collision of powerup")
	end

end


function _M:tap(event)
	print("Tapped of powerup")
	print (event.target)
end


function _M:destroy()
	print("Destroying powerup")
	if (self ~= nil) then
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end


return _M