-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 23:24:20
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 01:35:38

-- Puff visual effect
-- Puff can be either white when a ball, a block or a bug dies, or it can act as an explosion visualisation.

local _M = {}

local specs = {
	{w = 191, h = 180},
	{w = 203, h = 185},
	{w = 196, h = 175},
	{w = 180, h = 182},
	{w = 185, h = 181}
}

function _M.newPuff(params)
	local index = math.random(1, 5)
	local puff = display.newImageRect(params.g, 'images/puffs/' .. index .. '.png', specs[index].w, specs[index].h)
	puff.x, puff.y = params.x, params.y
	local fromScale, toScale = math.random(0.1, 0.2), math.random(2, 3)
	puff:scale(fromScale, fromScale)

	if params.isExplosion then
		puff:setFillColor(1, 0.9, 0.5)
	end

	transition.to(puff, {time = math.random(200, 400), xScale = toScale, yScale = toScale, alpha = 0, onComplete = function(object)
		object:removeSelf()
	end})

	return puff
end

return _M

local physicsDisplayObjects = {}

...

function scene:createScene(event)
    ...
    local displayObject1 = ... -- display object
    physics.addBody(displayObject1, ...) -- transform it into a physics body
    table.insert(physicsDisplayObjects, displayObject1)
    ...
end

...

function something()
    ...
    for i,obj in ipairs(physicsDisplayObjects) do
        physics.removeBody(obj) -- revert obj into regular display object
    end
    physicsDisplayObjects = {} -- clear
    ...
end

...
