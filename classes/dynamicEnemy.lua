-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 22:19:05
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-13 22:28:08

-- Enemy: bird, aircraft
-- Enemy can be either can be of bird or aircraft
-- Dynamic Body enemy; Moves with force rather transition

local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')

local _M = {tag='enemy', hp=5, health=20, type='default', w=40, h=40, x=1030, y=hemeGlobals.yLevel[1]}

function _M:newEnemy(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	-- self.__newindex = function(o, k, v) rawset(self, k, v) end
	print ("In enenmy")
	utils.print_table(o)
	return o
end

function _M:spawn()

	print("sefl: " )
	utils.print_table(self)

	self.shape = display.newImageRect('images/enemy/' .. self.type .. '.png', self.w, self.h)
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5})
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
		self.shape.bodyType = "kinematic"
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end


-- _M.shape:addEventListener("collision")
-- _M.shape:addEventListener("tap")

return _M