-- @Author: Ritesh Pradhan
-- @Date:   2016-04-18 20:24:29
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 14:25:10

-- Shiva the destructor;
-- whatever get collided to this object get destroyed.
-- this is universal destructor of physics objects

local physics = require('physics')
physics.start()

local _M = {}

function _M.newShiva()
	local shiva = display.newRect( 5, display.contentHeight/2, 10, display.contentHeight - 100)
    physics.addBody( shiva, 'dynamic', {isSensor = true} )
    shiva:setFillColor( 1,1,1,0 )
    shiva.tag = "shiva"

    function shiva:collision(event)
    	if (event.phase == "ended") then
	    	-- print("Destroy event.other without sound")
    	end
    end

    function shiva:destroy()
    	-- print("Destroying shiva")
    	if(self ~= nil) then
    		physics.removeBody( self )
    		self:removeSelf( )
    		self = nil
    	end
    end

    shiva:addEventListener( "collision" )

    return shiva
end

return _M