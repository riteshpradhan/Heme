-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 18:23:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-15 20:30:35

local physics = require("physics")
local newBullet = require("classes.bullet").newBullet
local collisionFilters = require('libs.collisionFilters')

local _M = {}

function _M.newEnemyBullet(params)
	params.type = param.type or 'enemyBullet'
	params.w, params.h = 100, 50

	local enemyBullet = newBullet(params)
	enemyBullet.hp = params.hp or 5
	playerBullet.tag = 'bullet'

	physics.addBody(enemyBullet, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5, filter=collisionFilters.enemyBullet})
	-- enemyBullet:applyLinearImpulse(-30, 0, enemyBullet.x, enemyBullet.y)
	enemyBullet:setLinearVelocity( -30, 0 )


	function enemyBullet:collision(event)
		print("Collision of enemyBullet")
	end
	enemyBullet:addEventListener( 'collision')

	function enemyBullet:tap(event)
		print("Tap of enemyBullet")
	end

	return enemyBullet
end

return _M