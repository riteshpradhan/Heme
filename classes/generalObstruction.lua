-- @Author: Ritesh Pradhan
-- @Date:   2016-04-14 22:14:39
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 19:33:42

-- Obstruction: general type
-- Types (tree; hill; building; windmill)
-- instant death on collision


local physics = require("physics")
local obstruction = require("classes.obstruction")
local utils = require('libs.utils')

local _M = obstruction:newObstruction({value=1, type='generalObstruction'})

_M.superSpawn = _M.spawn
function _M:spawn()
	self:superSpawn()
	-- self:move()
end

function _M:collision(event)
	if event.phase == "ended" then
		print("Collision of generalObstruction")
		-- collectible coin to certain extent
		self:destroy()
	end
end

function _M:tap(event)
	print("Tap of generalObstruction")
	print (event.target)
end

return _M
