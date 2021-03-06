-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 17:06:15
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 14:31:40

-- Bullet visual effect
-- Bullet can be either can be of Player or Enemy, or it can act as an explosion visualisation.

local physics = require("physics")
local sounds = require('libs.sounds')

local _M = {}

function _M.newBullet(params)
	-- local bullet = display.newImageRect('images/bullets/' .. params.type .. '.png', params.w, params.h)
	local bullet = display.newRoundedRect( params.x, params.y, params.w, params.h, 1 )
	bullet.x, bullet.y = params.x, params.y
	bullet.type = params.type

	-- local selfDestroyTimer = timer.performWithDelay( 4000, function() bullet:selfDestroy() end, 1 )

	function bullet:collision(event)
		if event.phase == "began" then
			-- print("Collision of bullet with powerups")
			if (event.other.tag == "shiva") then
				-- No sound
			elseif (event.other.tag == "ammoRefill") then
				sounds.play('bullet_collide_ammo')
			elseif (event.other.tag == "fuelRefill") then
				sounds.play('bullet_collide_fuel')
			elseif (event.other.tag == "healthRefill") then
				sounds.play('bullet_collide_health')
			else
				sounds.play('bullet_collide')
			end
		end
	end

	function bullet:enterFrame(event)
		if(bullet.x ~= nil and (bullet.x >= display.contentWidth - 50 or bullet.x < 0)) then
			bullet:selfDestroy()
			-- print("Bullet entered frame!!!!!!!!!!!")
		end
	end
	Runtime:addEventListener( "enterFrame", function() bullet:enterFrame() end)

	-- function bullet:tap(event)
	-- 	print("Tap of bullet")
	-- end

	function bullet:selfDestroy()
		-- print("Self destroying bullet")
		if (self ~= nil) then
			Runtime:removeEventListener("enterFrame", self.enterFrame)
			physics.removeBody( self )
			self:removeSelf()
			self = nil;
		end
	end

	function bullet:destroy()
		-- print("FIred!!!!!!!!!!!!!!!!!1")
		if (self ~= nil and self.bodyType ~=nil) then
			transition.to(self, {time=1, alpha=0})
			timer.performWithDelay( 1,
				function()
					if (self ~= nil and self.bodyType ~=nil) then
						physics.removeBody( self );
					end
					-- self:removeSelf( );
					display.remove( self )
					self = nil;
					end,
				 1 )
			-- sounds.play('refill_destroy')
		end
	end

	return bullet
end

return _M