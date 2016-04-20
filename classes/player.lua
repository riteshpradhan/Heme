-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:17:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 18:31:16


-- Heme Player
-- There is just one player

local physics = require('physics')
physics.start()

local toast = require('plugin.toast')

local images = require('libs.images')
local sounds = require('libs.sounds')
local utils = require('libs.utils')
local hemeGlobals = require('libs.globals' )
local collisionFilters = require( 'libs.collisionFilters')
local toastMaker = require('libs.toastMaker' )

local newPlayerBullet = require('classes.playerBullet').newPlayerBullet
-- local newPlayerBullet = require('classes.playerBullet').new

local _M = {
				tag="player", xPos=display.contentWidth*.20, yPos=hemeGlobals.yLevel[2],
				ammo=200, health=100, fuel=100,
				coin=0, medal=0,
				width=48, height=48, type='default',
				g=nil
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

	self.playerSprite = display.newSprite( images[self.type].sheet, images[self.type].sequenceData )
	self.playerSprite.x, self.playerSprite.y = self.xPos, self.yPos
	self.playerSprite:play()

	-- self.shape = display.newImageRect('images/player/' .. self.type .. '.png', self.width, self.height)
	self.shape = display.newRect(0,0,194,76)
	self.shape.ref = self;
	self.shape.tag = self.tag;
	self.shape.x, self.shape.y = self.xPos, self.yPos	--start position
	self.shape:setFillColor(1,0,0,0)
	sounds.play('player_spawn')
	physics.addBody(self.shape, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5, filter=collisionFilters.player}) -- While the player rests near the cannon, it's kinematic

	self.isHyperDriveActive = false
	self.isPlasmaShieldActive = false
	self.shape.isSensor = false
	self.isLaunched = true;

	self.parent = self.g
	hemeGlobals.isGameOver = false
	hemeGlobals.isCoinUpdate = false
	hemeGlobals.isMedalUpdate = false
	hemeGlobals.isAmmoUpdate = false
	hemeGlobals.isFuelUpdate = false
	hemeGlobals.isHealthUpdate = false

	self.shape:addEventListener('collision', self)
	self.shape:addEventListener('tap', self)
end



function _M:collision(event)
	if event.phase == "began" then
		print("Collision with player here")

		-- if self.isHyperDriveActive then
		-- 	print("hyperdrivePowerup is active; No collision effect in player; move fast")
		-- 	hemeGlobals.scrollSpeed = hemeGlobals.scrollSpeed + 10
		-- elseif self.isPlasmaShieldActive then
		if self.isPlasmaShieldActive then
			print("plasmashieldPowerup is active; No collision effect in player")
		else
			utils.print_table(event.other)
			print(event.other.test_param)

			if (event.other.tag == "ground") then
				sounds.play('player_destroy')
				print ("player collided with groound")
				--destroy
				hemeGlobals.isGameOver = true
				-- self:destroy()
			else
				if (event.other.tag == "enemy") then
					sounds.play('player_collide')
					self.health = self.health - event.other.hp
					hemeGlobals.isHealthUpdate = true
					print("collides enemy here and now health is : ", self.health)
				elseif (event.other.tag == "bullet") then
					sounds.play('player_hit')
					self.health = self.health - event.other.hp
					hemeGlobals.isHealthUpdate = true
				elseif (event.other.tag == "powerup") then
					-- use powerup
					sounds.play('player_collect_collectible')
					if (event.other.type == "hyperdrivePowerup") then
						-- do something
						print("hyperdrivePowerup")
						self.isHyperDriveActive = true
						self.shape.isSensor = true
						toastMaker.makeToast(self.parent, "Hyperdrive Powerup!!")
						transition.blink( self.playerSprite, {time=500, tag="blink"} )
						self.hyperTimer = timer.performWithDelay( 5000,
																function()
																	self.isHyperDriveActive = false;
																	self.shape.isSensor = false;
																	transition.cancel('blink');
																	self.playerSprite.alpha = 1;
																	hemeGlobals.scrollSpeed = hemeGlobals.scrollSpeed - 10
																end ,
																1 )
						table.insert(hemeGlobals.gameTimers, self.hyperTimer)
					elseif (event.other.type == "plasmashieldPowerup") then
						-- do something
						print("plasmashieldPowerup")
						self.isPlasmaShieldActive = true
						self.shape.isSensor = true
						toastMaker.makeToast(self.parent, "PlasmaShield Powerup!!")
						transition.blink( self.playerSprite, {time=500, tag="blink"} )
						self.plasmaTimer = timer.performWithDelay( 5000,
																function()
																	self.isPlasmaShieldActive = false;
																	self.shape.isSensor = false;
																	transition.cancel('blink');
																	self.playerSprite.alpha = 1;
																end,
																1 )
						table.insert(hemeGlobals.gameTimers, self.hyperTimer)
					elseif (event.other.type == "airblastPowerup") then
						-- do something
						print("airblastPowerup")
						-- destroy nearby enemies.
					end
				elseif (event.other.tag == "refill") then
					-- do refill
					if (event.other.type == "ammoRefill") then
						sounds.play('player_ammo_refill')
						toastMaker.makeToast(self.parent, "Ammo Refill!!")
						self.ammo = self.ammo + event.other.value
						hemeGlobals.isAmmoUpdate = true
					elseif (event.other.type == "fuelRefill") then
						sounds.play('player_fuel_refill')
						toastMaker.makeToast(self.parent, "Fuel Refill!!")
						self.fuel = self.fuel + event.other.value
						hemeGlobals.isFuelUpdate = true
					elseif (event.other.type == "healthRefill") then
						sounds.play('player_health_refill')
						toastMaker.makeToast(self.parent, "Health Refill!!")
						self.health = self.health + event.other.value
						hemeGlobals.isHealthUpdate = true
					end
				elseif (event.other.tag == "collectible") then
					sounds.play('player_collect_collectible')
					if (event.other.type == "coinCollectible") then
						toastMaker.makeToast(self.parent, "+1 Coin")
						self.coin = self.coin + event.other.value
						hemeGlobals.isCoinUpdate = true
					elseif (event.other.type == "medalCollectible") then
						toastMaker.makeToast(self.parent, "+1 Medal")
						self.medal = self.medal + event.other.value
						hemeGlobals.isMedalUpdate = true
					end
				elseif (event.other.tag == "obstruction") then
					sounds.play('player_collide')
					-- -- instant death; game over; destroy event
					self.health = 0
				end

				if (self.health > 0) then
					-- sound
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
		physics.start()
		if(self.playerSprite ~= nil ) then
			self.playerSprite:removeSelf()
		end
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
	if (self.ammo > 0) then
		local bullet = newPlayerBullet({x = self.shape.x, y = self.shape.y, isExplosion = self.type == 'playerBullet', hp=5})
		table.insert( hemeGlobals.physicsBodies, bullet )
		sounds.play('player_fire')
	else
		toastMaker.makeToast(self.parent, "Cartridge Empty!!")
	end
end

function _M:explode()
	sounds.play("player_explosion")
	-- explode animation if any
	self:destroy()
end

function _M:die()
	-- self.shape:applyLinearImpulse(5, 25, self.shape.x, self.shape.y)
	transition.to( self.shape, {time=4000, y=display.contentHeight-60, x=self.shape.x+ 100, rotation=720, transition=easing.outQuart} )
	transition.to( self.playerSprite, {time=4000, y=display.contentHeight-60, x=self.playerSprite.x+ 100, rotation=720, xScale=0.2, yScale=0.2, transition=easing.outQuart} )
	sounds.play('player_destroy')
end


function _M:tap(event)
	print ("Testing tap")
	-- self:die()
	-- self:fire()
	toast.show("Bullet is fired by Heme")
end


return _M

