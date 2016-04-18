-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 21:09:56
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-18 00:09:36

-- Enemy: aircraft
-- This enemy can be fire back enemybullet

local physics = require("physics")
local enemy = require("classes.enemy")
local newEnemyBullet = require("classes.enemyBullet").newEnemyBullet
local utils = require("libs.utils")

local _M = enemy:newEnemy({hp=10, health=20, type="aircraftEnemy", w=80, h=80})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.shape:setFillColor( 0,1,1,0.8 )
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
	local bullet = newPlayerBullet({x = self.x, y = self.y, isExplosion = self.type == 'enemyBullet'})
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of aircraftEnemy")
		utils.print_table(event.other)
		if (event.other.tag == "player") then
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
	end
end

return _M










-- function _M.newAircraftEnemy(params)
-- 	params.type = params.type or 'aircraftEnemy'
-- 	local aircraftEnemy = newEnemy(params)

-- 	aircraftEnemy.superMove = aircraftEnemy.move()

-- 	function aircraftEnemy:move()
-- 		-- new movement if any required.
-- 		self:superMove()
-- 	end

-- 	-- fires bullet
-- 	function aircraft:fire()
-- 		print("Firing bullet from player")
-- 		-- sound.play('enemy_fire')
-- 		-- create a self destructible bullet
-- 		local bullet = newPlayerBullet({x = self.x, y = self.y, isExplosion = self.type == 'enemyBullet'})

-- 	end

-- 	function aircraftEnemy:collision(event)
-- 		print("Collision of aircraftEnemy")
-- 	end


-- 	function aircraftEnemy:tap(event)
-- 		print("Tap of aircraftEnemy")
-- 	end


-- 	function aircraftEnemy:destroy()
-- 		print("Destroying aircraftEnemy")
-- 		if (aircraftEnemy ~= nil) then
-- 			transition.to(aircraftEnemy, {time=100, alpha=0})
-- 			aircraftEnemy:removeSelf( )
-- 		end
-- 	end

-- 	aircraftEnemy:addEventListener("collision")
-- 	aircraftEnemy:addEventListener("tap")

-- 	return aircraftEnemy
-- end

-- return _M