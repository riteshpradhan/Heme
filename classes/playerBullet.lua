-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 17:50:18
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-10 19:37:52

local physics = require("physics")
local newBullet = require("classes.bullet").newBullet
-- local newBullet = require("classes.bullet").new

local _M = {tag='bullet'}

function _M.newPlayerBullet(params)
-- function _M.new(params)
	params.type = 'playerBullet'
	params.w, params.h = 100, 30
	local playerBullet = newBullet(params)
	playerBullet.hp = params.hp or 10

	playerBullet:applyLinearImpulse(30, 0, playerBullet.x, playerBullet.y)

	function playerBullet:collision(event)
		if event.phase == "began" then
			print("Collision of playerBullet")
		end
	end


	function playerBullet:tap(event)
		print("Tap of playerBullet")
	end

	playerBullet:addEventListener( 'collision')
	playerBullet:addEventListener( 'tap')

	return playerBullet
end

return _M