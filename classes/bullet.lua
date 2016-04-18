-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 17:06:15
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-17 19:03:41

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

	-- local selfDestroyTimer = timer.performWithDelay( 4000, function() bullet:selfDestroy() end, 1 )

	-- function bullet:collision(event)
	-- 	print("Collision of bullet")
	-- end

	function bullet:enterFrame(event)
		-- print(display.contentWidth .. " --- " .. bullet.x)
		if(bullet.x ~= nil and bullet.x >= display.contentWidth - 150) then
			bullet:selfDestroy()
			-- print("destroy hereeeeee")
		end
	end
	Runtime:addEventListener( "enterFrame", function() bullet:enterFrame() end)

	function bullet:tap(event)
		print("Tap of bullet")
	end

	function bullet:selfDestroy()
		-- print("Self destroying bullet")
		if (self ~= nil) then
			-- timer.cancel( selfDestroyTimer )
			-- transition.to(self, {time=100, alpha=0})
			Runtime:removeEventListener( "enterFrame" , self.enterFrame)
			self:removeSelf( )
		end
	end

	-- bullet:addEventListener( 'collision')
	-- bullet:addEventListener( 'tap')

	return bullet
end

return _M