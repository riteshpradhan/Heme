-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 18:23:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-10 22:23:08

local physics = require("physics")
local newBullet = require("classes.bullet").newBullet

local _M = {}

function _M.newEnemyBullet(params)
	params.type = param.type or 'enemyBullet'
	params.w, params.h = 100, 50

	local enemyBullet = newBullet(params)
	enemyBullet.hp = params.hp or 5

	enemyBullet:applyLinearImpulse(-30, 0, enemyBullet.x, enemyBullet.y)

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