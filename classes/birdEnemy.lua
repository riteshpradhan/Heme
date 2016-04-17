-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 20:45:50
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 23:59:31


-- Enemy: bird
-- This enemy doesn't fire back


local physics = require("physics")
local enemy = require("classes.enemy")
local utils = require('libs.utils')

local _M = enemy:newEnemy({hp=5, health=10, type='birdEnemy', test_param=88})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	-- self:move()
end


_M.superMove = _M.move
function _M:move()
	-- new movement if any required.
	self:superMove()
end


function _M:collision(event)
	if event.phase == "began" then
		print("Collision of birdEnemy")
		utils.print_table(event.other)
		if (event.other.tag == "player") then
			self:destroy()
		else
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
		transition.to(self.shape, {time=100, alpha=0})
		self.shape:removeSelf( )
	end
end

function _M:myBird()
end


return _M