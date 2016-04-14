-- @Author: Ritesh Pradhan
-- @Date:   2016-04-13 22:56:46
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-13 22:57:57

-- Enemy: aircraft
-- This enemy can be fire back enemybullet
-- Dynamic

local physics = require("physics")
local enemy = require("classes.dynamicEnemy")
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
	-- sound.play('enemy_fire')
	-- create a self destructible bullet
	local bullet = newPlayerBullet({x = self.x, y = self.y, isExplosion = self.type == 'enemyBullet'})
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of aircraftEnemy")
	end
end

function _M:tap(event)
	print("Tap of aircraftEnemy")
end


function _M:destroy()
	print("Destroying aircraftEnemy")
	if (self ~= nil) then
		transition.to(self, {time=100, alpha=0})
		self:removeSelf( )
	end
end

return _M

