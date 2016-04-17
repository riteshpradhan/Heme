-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:17:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 23:42:19

-- Heme Player
-- There is just one player

local physics = require('physics')
local toast = require('plugin.toast')

local sounds = require('libs.sounds')
local utils = require('libs.utils')
local hemeGlobals = require('libs.globals' )
local collisionFilters = require( 'libs.collisionFilters')

local newPlayerBullet = require('classes.playerBullet').newPlayerBullet
-- local newPlayerBullet = require('classes.playerBullet').new

local _M = {tag="player", xPos=display.contentWidth*.20, yPos=hemeGlobals.yLevel[2], ammo=0, health=100, fuel=0, width=48, height=48, type='default'}


function _M:newPlayer (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;

	utils.print_table(self)
	-- print(_M)
	return o
end



-- launch player once game starts
function _M:launch()
	print("Printng self: ")
		-- self.shape = display.newImageRect(params.g, 'images/player/' .. params.type .. '.png', 48, 48)
	self.shape = display.newImageRect('images/player/' .. self.type .. '.png', self.width, self.height)
	self.shape.ref = self;
	self.shape.tag = self.tag;
	self.shape.x, self.shape.y = self.xPos, self.yPos	--start position
	self.shape:setFillColor(1,0,0,0.9)
	physics.addBody(self.shape, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5, filter=collisionFilters.player}) -- While the player rests near the cannon, it's kinematic
	print(self.shape, self.shape.ref, self, self.shape.bodyType)

	utils.print_table(self.shape.ref)
	-- rotate by 90 degree and set at  certain height
	-- transition.to( self.shape, { time=4000, x=240, y=hemeGlobals.yLevel[2], rotation=90, transition=easing.inQuart } )
	-- self.shape.bodyType = 'dynamic' -- Change to dynamic so it can move with force and for collision
	self.isLaunched = true;
	-- start with Impulse
	-- self.shape:applyLinearImpulse(5, 0, self.shape.x, self.shape.y)
	self.shape:addEventListener('collision', self)
	self.shape:addEventListener('tap', self)
end




function _M:collision(event)
	if event.phase == "ended" then
		print("Collision with player")
		self.health = self.health - 1
		if (self.health > 0) then
			-- sound
			self.shape:setFillColor(1,0,0);
		else
			-- sound
			-- die
			self.shape:removeSelf();
			self = nil;
		end
	end
end



function _M:destroy()
	if self ~= nil and self.shape ~= nil then
		physics.removeBody( self.shape )
		self.shape:removeSelf( )
		sounds.play('player_destroy')
	end
end

-- fire bullets
function _M:fire()
	print("Firing bullet from player")
	-- sound.play('player_fire')
	-- create a self destructible bullet
	local bullet = newPlayerBullet({x = self.shape.x, y = self.shape.y, isExplosion = self.type == 'playerBullet', hp=3})

end

function _M:explode()
	sounds.play("player_explosion")
	-- explode animation if any
	self:destroy()
end

function _M:die()
	transition.to( self.shape, {time=2000, y=display.contentHeight-60, x=self.shape.x+ 100, rotation=270, transition=easing.outQuart} )
end


function _M:tap(event)
	print ("Testing tap")
	-- self:die()
	-- self:fire()
	toast.show("Bullet is fired by Heme")
end


return _M

