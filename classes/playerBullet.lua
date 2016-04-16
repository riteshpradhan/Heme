-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 17:50:18
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-15 20:30:54

local physics = require("physics")
local newBullet = require("classes.bullet").newBullet
-- local newBullet = require("classes.bullet").new
local collisionFilters = require( 'libs.collisionFilters')

local _M = {tag='bullet'}

function _M.newPlayerBullet(params)
-- function _M.new(params)
	params.type = params.type or'playerBullet'
	params.w, params.h = 100, 30
	local playerBullet = newBullet(params)
	playerBullet.hp = params.hp or 10
	playerBullet.tag = 'bullet'

	physics.addBody(playerBullet, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5, filter=collisionFilters.playerBullet})
	-- playerBullet:applyLinearImpulse(30, 0, playerBullet.x, playerBullet.y)
	--kinematic body move with velocity --
	playerBullet:setLinearVelocity( 300, 0 )

	function playerBullet:collision(event)
		if event.phase == "began" then
			print("Collision of playerBullet")
		end
	end


	function playerBullet:tap(event)
		print("Tap of playerBullet of hp: ", self.hp, self.tag)

	end

	playerBullet:addEventListener( 'collision')
	playerBullet:addEventListener( 'tap')

	return playerBullet
end

return _M