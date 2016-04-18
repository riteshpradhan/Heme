-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:17:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 20:32:47

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

local _M = {
				tag="player", xPos=display.contentWidth*.20, yPos=hemeGlobals.yLevel[2],
				ammo=100, health=100, fuel=100,
				coin=0, medal=0,
				width=48, height=48, type='default'
			}


function _M:newPlayer (o)
	o = o or {};
	setmetatable(o, self);
	self.__index = self;
	utils.print_table(self)
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
	self.shape.isPlasmaShielded = false
	print(self.shape, self.shape.ref, self, self.shape.bodyType)



	print("Self.shape.ref:", self.health, self.ammo)
	utils.print_table(self.shape.ref)
	print("Self.shape:")
	utils.print_table(self.shape)
	-- rotate by 90 degree and set at  certain height
	-- transition.to( self.shape, { time=4000, x=240, y=hemeGlobals.yLevel[2], rotation=90, transition=easing.inQuart } )
	-- self.shape.bodyType = 'dynamic' -- Change to dynamic so it can move with force and for collision
	self.isLaunched = true;

	self.shape:addEventListener('collision', self)
	self.shape:addEventListener('tap', self)
end



function _M:collision(event)
	if event.phase == "began" then
		print("Collision with player here")

		if self.isHyperDriveActive then
			print("hyperdrivePowerup is active; No collision effect in player; move fast")
			hemeGlobals.scrollSpeed = hemeGlobals.scrollSpeed * 3
		elseif self.isPlasmaShieldActive then
			print("plasmashieldPowerup is active; No collision effect in player")
		else
			utils.print_table(event.other)
			print(event.other.test_param)


			if (event.other.tag == "ground") then
				print ("player collided with groound")
				--destroy
				self:destroy()
			else
				if (event.other.tag == "enemy") then
					self.health = self.health - event.other.hp
					print("collides enemy here and now health is : ", self.health)
				elseif (event.other.tag == "bullet") then
					self.health = self.health - event.other.hp
				elseif (event.other.tag == "powerup") then
					-- use powerup
					if (event.other.type == "hyperdrivePowerup") then
						-- do something
						print("hyperdrivePowerup")
						self.isHyperDriveActive = false
						self.hyperTimer = timer.performWithDelay( 5000, function() self.isHyperDriveActive = false end , 1 )

					elseif (event.other.type == "plasmashieldPowerup") then
						-- do something
						print("plasmashieldPowerup")
						self.isPlasmaShieldActive = true
						self.plasmaTimer = timer.performWithDelay( 5000, function() self.isPlasmaShieldActive = false end , 1 )
					elseif (event.other.type == "airblastPowerup") then
						-- do something
						print("airblastPowerup")
						-- destroy nearby enemies.
					end
				elseif (event.other.tag == "refill") then
					-- do refill
					if (event.other.type == "ammoRefill") then
						self.ammo = self.ammo + event.other.value
					elseif (event.other.type == "fuelRefill") then
						self.fuel = self.fuel + event.other.value
					elseif (event.other.type == "healthRefill") then
						self.health = self.health + event.other.value
					end
				elseif (event.other.tag == "collectible") then
					if (event.other.type == "coinCollectible") then
						self.coin = self.coin + event.other.value
					elseif (event.other.type == "medalCollectible") then
						self.medal = self.medal + event.other.value
					end
				elseif (event.other.tag == "obstruction") then
					-- -- instant death; game over; destroy event
					self.health = 0
				end

				if (self.health > 0) then
					-- sound
					self.shape:setFillColor(1,0,0);
				else
					-- sound
					-- die ; falls to ground
					self:die()
				end
			end
		end

	end
end

function _M:destroy()
	if self ~= nil and self.shape ~= nil then
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
		sounds.play('player_destroy')
		-- game Over
		hemeGlobals.isGameOver = true
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
	self.shape:applyLinearImpulse(5, 25, self.shape.x, self.shape.y)
	-- transition.to( self.shape, {time=2000, y=display.contentHeight-60, x=self.shape.x+ 100, rotation=270, transition=easing.outQuart} )
end


function _M:tap(event)
	print ("Testing tap")
	-- self:die()
	-- self:fire()
	toast.show("Bullet is fired by Heme")
end


return _M

