-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 18:23:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 14:32:42

local physics = require("physics")
local newBullet = require("classes.bullet").newBullet
local collisionFilters = require('libs.collisionFilters')

local _M = {}

function _M.newEnemyBullet(params)
	params.type = params.type or 'enemyBullet'
	params.w, params.h = 20, 8

	local enemyBullet = newBullet(params)
	enemyBullet.hp = params.hp or 5
	enemyBullet.tag = 'bullet'
	enemyBullet:setFillColor( 1, 0, 0  )

	physics.addBody(enemyBullet, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5, filter=collisionFilters.enemyBullet})
	enemyBullet.isSensor = true
	-- enemyBullet:applyLinearImpulse(-30, 0, enemyBullet.x, enemyBullet.y)
	enemyBullet:setLinearVelocity( -600, 0 )

	function enemyBullet:collision(event)
		if ( event.phase == "began" ) then
			self.alpha = 0
		elseif event.phase == "ended" then
			-- print("Collision of enemyBullet")
			self:destroy()
		end
	end
	enemyBullet:addEventListener( 'collision')

	return enemyBullet
end

return _M