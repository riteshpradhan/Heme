-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 19:32:35
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 15:22:24


-- Enemy: bird, aircraft
-- Enemy can be either can be of bird or aircraft

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local collisionFilters = require('libs.collisionFilters')

local _M = {tag='enemy', hp=5, health=20, type='default', w=40, h=40, x=0, y=0, xVel=0, yVel=0}

function _M:newEnemy(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In enemy", o)
	utils.print_table(o)
	print ("In enemy self", self)
	utils.print_table(self)

	return o
end

function _M:spawn()

	print("sefl: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/enemy/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'kinematic', {density = 2, friction = 0.5, bounce = 0.5, filter = collisionFilters.enemy})
	self.shape.filter = collisionFilters.enemy
	self.shape.isSensor = true
	self.shape.type = self.type
	self.shape.ref = self
	self.shape.health = self.health
	self.shape.hp = self.hp
	self.shape.tag = self.tag
	--kinematic body move with velocity --
	print ("Scroll speed: ", self.xVel)
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
	-- print("Collision of enemy")
	end

end


function _M:tap(event)
	print("Tap of enemy")
	print (event.target)
end


function _M:destroy()
	print("Destroying enemy")
	if (self ~= nil) then
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end


-- _M.shape:addEventListener("collision")
-- _M.shape:addEventListener("tap")

return _M