-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 21:09:56


-- Enemy: aircraft
-- This enemy can be fire back enemybullet

local physics = require("physics")
local enemy = require("classes.enemy")
local newEnemyBullet = require("classes.enemyBullet").newEnemyBullet
local utils = require("libs.utils")
local sounds = require("libs.sounds")

local _M = enemy:newEnemy({hp=10, health=20, type="aircraftEnemy", w=80, h=80})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.shape:setFillColor( 0,1,1,0.8 )

	self.firingTimer = timer.performWithDelay( 3000, function() self:fire() end, 5)


end

_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end

-- fires bullet
function _M:fire()
	print("Firing bullet from player")
	sounds.play('aircraft_fire')
	-- sound.play('enemy_fire')
	-- create a self destructible bullet
	local bullet = newEnemyBullet({x = self.shape.x, y = self.shape.y, isExplosion = self.type == 'enemyBullet', hp=5})
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of aircraftEnemy")
		utils.print_table(event.other)
		if (event.other.tag == "shiva") then
			-- no sound, just destroying the object
			self:destroy()
		elseif (event.other.tag == "player") then
			sounds.play('aircraft_collide')
			self:destroy()
		else
			sounds.play('aircraft_hit')
			print("Collision of aircraftEnemy with player bullet")
			utils.print_table(self)
			utils.print_table(self.shape)
			self.shape.health = self.shape.health - event.other.hp
			if (self.shape.health <= 0) then
				self:destroy()
			end
		end
	end
end

function _M:tap(event)
	print("Tap of aircraftEnemy")
end

function _M:destroy()
	print("Destroying aircraftEnemy")
	if (self.shape ~= nil) then
		sounds.play('aircraft_destroy')
		transition.to(self.shape, {time=100, alpha=0.1})
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
		timer.cancel(self.firingTimer)
	end
end

return _M
