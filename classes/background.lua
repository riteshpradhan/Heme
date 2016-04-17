-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 20:28:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 21:03:29

local background = {}

local bg1
local bg2
local runtime = 0
local defaultScrollSpeed = 5


local function addScrollableBg()
    local bgImage = { type="image", filename="images/scenes/bg.jpg" }
    -- Add First bg image
    bg1 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    bg1.fill = bgImage
    bg1.x = display.contentCenterX
    bg1.y = display.contentCenterY
    bg1:toBack()

    -- Add Second bg image
    bg2 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    bg2.fill = bgImage
    bg2.x = display.contentCenterX + display.actualContentWidth
    bg2.y = display.contentCenterY -- - display.actualContentHeight
    bg2:toBack()
end

local function moveBg(dt, scrollSpeed)
	scrollSpeed = scrollSpeed or defaultScrollSpeed
    bg1.x = bg1.x - scrollSpeed * dt
    bg2.x = bg2.x - scrollSpeed * dt
    -- if (bg1.x - display.contentWidth/2) > display.actualContentWidth then
    if(bg1.x + display.contentWidth / 2) <= 0 then
    	print("translate bg 1!!!!!!!!!!!!")
        bg1:translate(bg1.contentWidth * 2, 0)
    end
    if (bg2.x + display.contentWidth / 2 ) <= 0 then
        -- bg2:translate(0, -bg2.contentHeight * 2)
        bg2:translate(bg2.contentWidth * 2, 0)

    end
end

background.addScrollableBg = addScrollableBg
background.moveBg = moveBg

return background