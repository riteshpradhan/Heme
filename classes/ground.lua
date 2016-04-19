-- @Author: Ritesh Pradhan
-- @Date:   2016-04-15 20:53:04
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-19 01:25:28

-- Ground To start launching: player


local physics = require("physics")
local hemeGlobals = require('libs.globals')
local utils = require('libs.utils')
local collisionFilters = require('libs.collisionFilters')

local _M = {tag='ground', type='default', w=display.contentWidth, h=30, x=display.contentCenterX, y=display.contentHeight - 15}

function _M:newGround(params)
	local o = params or {}
	setmetatable(o, self);
	self.__index = self;
	print ("In ground")
	utils.print_table(o)
	return o
end

function _M:spawn()

	print("sefl: " )
	utils.print_table(self)

	-- self.shape = display.newImageRect('images/ground/' .. self.type .. '.png', self.w, self.h)
	self.shape = display.newRect( self.x, self.y, self.w, self.h )
	self.shape.x, self.shape.y = self.x, self.y
	physics.addBody(self.shape, 'static', {density = 2, friction = 0.5, bounce = 0.5, filter = collisionFilters.ground})
	-- physics.addBody(self.shape, 'static', {density = 2, friction = 0.5, bounce = 0.5})
	self.shape.type = self.type
	self.shape.tag = self.tag
	self.shape.ref = self
	self.shape:addEventListener("collision", self)
	self.shape:addEventListener("tap", self)

end


function _M:collision(event)
	if event.phase == "began" then
		print("Collision of ground wiht ", event.other.tag)
		self:destroy()
	end

end


function _M:tap(event)
	print("Tap of ground")
	print (event.target)
end


function _M:destroy()
	print("Destroying ground")
	if (self ~= nil and self.shape ~= nil) then
		transition.to(self, {time=100, alpha=0})
		timer.performWithDelay( 10,
				function()
					if(self.shape.bodyType ~= nil) then
						physics.removeBody( self.shape );
					end
					self.shape:removeSelf( );
					self = nil
					end ,
				1 )
	end
end


return _M