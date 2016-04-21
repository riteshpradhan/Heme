-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 21:09:56


-- Enemy: aircraft
-- This enemy can be fire back enemybullet

local physics = require("physics")
local enemy = require("classes.enemy")
local newEnemyBullet = require("classes.enemyBullet").newEnemyBullet
local utils = require("libs.utils")
local sounds = require("libs.sounds")
local hemeGlobals = require('libs.globals')


local _M = enemy:newEnemy({hp=10, health=9, type="aircraftEnemy", w=175, h=76})


_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.firingTimer = timer.performWithDelay( 2000, function() self:fire() end, 5)
	table.insert( hemeGlobals.gameTimers, self.firingTimer)
end

_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end

-- fires bullet
function _M:fire()
	-- print("Firing bullet from player")
	sounds.play('aircraft_fire')
	-- sound.play('enemy_fire')
	-- create a self destructible bullet
	local bullet = newEnemyBullet({x = self.shape.x -100, y = self.shape.y, isExplosion = self.type == 'enemyBullet', hp=5})
	table.insert( hemeGlobals.physicsBodies, bullet )
end

function _M:collision(event)
	if ( event.phase == "began" ) then
		-- print("Collision of aircraftEnemy")
		-- utils.print_table(event.other)
		if (event.other.tag == "shiva") then
			-- no sound, just destroying the object
			self.enemySprite.alpha = 0
			-- self:destroy()
		elseif (event.other.tag == "player") then
			sounds.play('aircraft_collide')
			self.enemySprite.alpha = 0
			-- self:destroy()111111
		else
			sounds.play('aircraft_hit')
			-- self.shape.health = self.shape.health - event.other.hp

			if (self.shape.health <= 0) then
				sounds.play('aircraft_destroy')
				self.enemySprite.alpha = 0
				-- self:destroy()
			end
		end
	elseif event.phase == "ended" then
		-- utils.print_table(event.other)
		if (event.other.tag == "shiva") then
			self:destroy()
		elseif (event.other.tag == "player") then
			self:destroy()
		else
			self.shape.health = self.shape.health - event.other.hp
			if (self.shape.health <= 0) then
				self:destroy()
			end
		end
	end
end

-- function _M:tap(event)
-- 	print("Tap of aircraftEnemy")
-- end

function _M:destroy()
	-- print("Destroying aircraftEnemy")
	if (self.shape ~= nil) then
		transition.to(self.shape, {time=1, alpha=0})
		timer.cancel(self.firingTimer)
		timer.performWithDelay( 1,
							function()
								physics.removeBody( self.shape );
								self.shape:removeSelf( );
								if(self.enemySprite ~= nil ) then
									self.enemySprite:removeSelf();
								end
								self = nil;
							end,
						 	1 )
	end
end

return _M
