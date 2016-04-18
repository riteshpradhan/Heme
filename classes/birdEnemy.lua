-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 20:45:50
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-17 23:40:27


-- Enemy: bird
-- This enemy doesn't fire back


local physics = require("physics")
local enemy = require("classes.enemy")
local utils = require('libs.utils')
local sounds = require( "libs.sounds" ); 

local _M = enemy:newEnemy({hp=150, health=10, type='birdEnemy', test_param=88})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	self.shape.test_param = self.test_param
	-- self:move()
end


_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end


function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of birdEnemy")
		utils.print_table(event.other)
		if (event.other.tag == "player") then
			sounds.play('bird_collide')
			self:destroy()
		else
			sounds.play('bird_hit')
			print("Collision of birdEnemy with player bullet")
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
	print("Tap of birdEnemy")
	print (event.target)
end

function _M:destroy()
	print("Destroying birdEnemy")
	if (self.shape ~= nil) then
		sounds.play('bird_destroy')
		transition.to(self.shape, {time=100, alpha=0.1})
		timer.performWithDelay( 1, function() physics.removeBody( self.shape ); self.shape:removeSelf( ); self = nil end , 1 )
	end
end

function _M:myBird()
end


return _M