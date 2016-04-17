-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 17:06:15
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 22:05:10

-- Bullet visual effect
-- Bullet can be either can be of Player or Enemy, or it can act as an explosion visualisation.

local physics = require("physics")

local _M = {}

function _M.newBullet(params)
-- function _M.new(params)
	-- local bullet = display.newImageRect(params.g, 'images/bullets/' .. params.type .. '.png', params.w, params.h)
	local bullet = display.newImageRect('images/bullets/' .. params.type .. '.png', params.w, params.h)
	bullet.x, bullet.y = params.x, params.y
	bullet.type = params.type
	-- physics.addBody(bullet, 'dynamic', {density = 2, friction = 0.5, bounce = 0.5})

	local selfDestroyTimer = timer.performWithDelay( 4000, function() bullet:selfDestroy() end, 1 )

	-- function bullet:collision(event)
	-- 	print("Collision of bullet")
	-- end


	function bullet:tap(event)
		print("Tap of bullet")
	end

	function bullet:selfDestroy()
		print("Self destroying bullet")
		if (self ~= nil) then
			timer.cancel( selfDestroyTimer )
			transition.to(self, {time=100, alpha=0})
			self:removeSelf( )
		end
	end

	-- bullet:addEventListener( 'collision')
	-- bullet:addEventListener( 'tap')

	return bullet
end

return _M