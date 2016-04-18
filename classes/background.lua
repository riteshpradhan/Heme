-- @Author: Ritesh Pradhan
-- @Date:   2016-04-16 20:28:52
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-17 20:12:26

local utils = require('libs.utils')

local _M = {tag="background", bgImage="images/scenes/bg.jpg", runtime=0, defaultScrollSpeed=5, type='default'}

function _M:newBackground (o)
    o = o or {};
    setmetatable(o, self);
    self.__index = self;
    utils.print_table(self)
    return o
end


function _M:addScrollableBg (img)
    -- Add First bg image
    self.bg1 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    self.bg1.fill = img
    self.bg1.x = display.contentCenterX
    self.bg1.y = display.contentCenterY
    self.bg1:toBack()

    -- Add Second bg image
    self.bg2 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    self.bg2.fill = img
    self.bg2.x = display.contentCenterX + display.actualContentWidth - 5
    self.bg2.y = display.contentCenterY -- - display.actualContentHeight
    self.bg2:toBack()
end

function _M:moveBg(dt, speed)
	local scrollSpeed = speed or self.defaultScrollSpeed
    self.bg1.x = self.bg1.x - scrollSpeed * dt
    self.bg2.x = self.bg2.x - scrollSpeed * dt
    -- if (bg1.x - display.contentWidth/2) > display.actualContentWidth then
    if(self.bg1.x + display.contentWidth / 2) <= 0 then
        self.bg1:translate(self.bg1.contentWidth * 2 - 8, 0)
    end
    if (self.bg2.x + display.contentWidth / 2 ) <= 0 then
        -- bg2:translate(0, -bg2.contentHeight * 2)
        self.bg2:translate(self.bg2.contentWidth * 2 - 8, 0)

    end
end


function _M:destroy()
    if (self.bg1 ~= nil and self.bg2 ~= nil) then
        transition.to(self.bg1, {time=100, alpha=0})
        timer.performWithDelay( 1, function() self.bg1:removeSelf( ); self.bg2:removeSelf( ) end , 1 )
    end
end

return _M
