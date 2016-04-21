-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:28:21
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 13:43:56


-- This collectible is used for long term bonus items during game play; power up levels and get more health, ammo and fuel
-- coin
-- medal

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local sounds = require('libs.sounds')
local collisionFilters = require( 'libs.collisionFilters')

local _M = {tag='collectible', type='default', w=50, h=50, x=1330, y=hemeGlobals.yLevel[1], xVel=-10, yVel=0, value=1}

function _M:newCollectible(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In collectible")
	utils.print_table(o)
	return o
end

function _M:spawn()
	print("collectible self: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/collectible/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5, filter =collisionFilters.collectible})
	self.shape.isSensor = true
	self.shape.type = self.type
	self.shape.tag = self.tag
	self.shape.value = self.value
	self.shape.ref = self
	--kinematic body move with velocity --
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
		-- print("Collision of collectible")
		self:destroy()
	end
end


function _M:tap(event)
	print("Tapped of collectible")
	print (event.target)
end


function _M:destroy()
	print("Destroying collectible")
	if (self ~= nil and self.shape ~= nil) then
		transition.to(self, {time=1, alpha=0})
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
		sounds.play('refill_destroy')
	end
end


return _M