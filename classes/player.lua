-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:17:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-10 17:18:00

-- Heme Player
-- There is just one player

local physics = require('physics')
local sounds = require('libs.sounds')
-- local newBullet = require('classes.playerBullet').newBullet


local _M = {tag="player", xPos=40, yPos=display.contentHeight-60, ammo=0, health=0, fuel=0, width=48, height=48}


function _M:newPlayer (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	-- self.shape = display.newImageRect(params.g, 'images/player/' .. params.type .. '.png', 48, 48)
	self.shape = display.newImageRect('images/player/' .. params.type .. '.png', self.width, self.height)
	self.shape.ref = self;
	self.shape.tag = self.tag;
	self.shape.x, self.shape.y = self.xPos, self.yPos	--start position
	self.shape:setFillColor(1,0,0,0.9)
	physics.addBody(self.shape, 'static', {density = 2, friction = 0.5, bounce = 0.5}) -- While the player rests near the cannon, it's static
	print(self.shape, self.shape.ref, self, self.shape.bodyType)
	return o;
end



-- launch player once game starts
function _M:launch()
	-- rotate by 90 degree and set at  certain height
	transition.to( self.shape, { time=4000, x=240, y=60, rotation=90, transition=easing.inQuart } )
	self.shape.bodyType = 'dynamic' -- Change to dynamic so it can move with force and for collision
	self.isLaunched = true;
	-- start with Impulse
	self.shape:applyLinearImpulse(5, 0, self.shape.x, self.shape.y)
	self.shape:addEventListener('collision', self)
	self.shape:addEventListener('tap', self)
end




function _M:collision(event)
	self.health = self.health - 1
	if (self.HP > 0) then
		-- sound
		self.shape:setFillColor(1,0,0);
	else
		-- sound
		-- die
		self.shape:removeSelf();
		self = nil;
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
	sound.play('player_fire')
	-- create a self destructible bullet
	-- newBullet({g = params.g, x = self.x, y = self.y, isExplosion = self.type == 'playerBullet'})

end

function _M:explode()
	sounds.play("player_explosion")
	-- explode animation if any
	self.destroy()
end

function _M:die()
	transition.to( self.shape, {time=2000, y=display.contentHeight-60, x=self.shape.x+ 100, rotation=270, transition=easing.outQuart} )
end


function _M:tap(event)
	print ("Testing tap")
	self:die()
end


return _M

