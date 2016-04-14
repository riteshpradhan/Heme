-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 23:28:21
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-13 23:36:39


-- This collectible is used for long term bonus items during game play; power up levels and get more health, ammo and fuel
-- coin
-- medal

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')

local _M = {tag='collectible', type='default', w=50, h=50, x=1030, y=hemeGlobals.yLevel[1]}

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
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5})
	self.shape.isSensor = true
	self.shape.type = self.type
	self.shape:applyLinearImpulse(-5, 0, self.shape.x, self.shape.y)

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
	end

end


function _M:tap(event)
	print("Tapped of collectible")
	print (event.target)
end


function _M:destroy()
	print("Destroying collectible")
	if (self ~= nil) then
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end


return _M