-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 22:58:39
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-18 21:18:10


-- This refill is used for instant bonus items during game play
-- fuel
-- health
-- ammo

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local collisionFilters = require( 'libs.collisionFilters')

local _M = {tag='refill', type='default', w=65, h=65, x=1030, y=hemeGlobals.yLevel[1], value=10, xVel=-10, yVel=0, value=10}

function _M:newRefill(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In refill")
	utils.print_table(o)
	return o
end

function _M:spawn()
	print("refill self: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/refill/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5, filter = collisionFilters.refill})
	self.shape.isSensor = true
	self.shape.type = self.type
	self.shape.value = self.value
	self.shape.tag = self.tag
	self.shape.ref = self
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
	if event.phase == "began" then
		print("Collision of Refill")
		self:destroy()
	elseif event.phase == "ended" then
		-- print("Collision of Refill")
		-- self:destroy()
	end
end

function _M:tap(event)
	print("Tapped of Refill")
	print (event.target)
end

function _M:destroy()
	print("Destroying Refill")
	if (self ~= nil and self.shape ~= nil) then
		transition.to(self, {time=100, alpha=0})
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
		-- sounds.play('refill_destroy')
	end
end

return _M