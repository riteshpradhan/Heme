-- @Author: ritesh
-- @Date:   2016-04-08 13:51:14
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 01:08:17

local normalW, normalH = 720, 1280

-- This calculation extends the standard letterbox scaling
-- Using this point x = 0, y = 0 is always in the top left corner of the screen on all devices
-- And x = display.contentWidth, y = display.contentHeight is always in the bottom right corner
local w, h = display.pixelWidth, display.pixelHeight
local scale = math.max(normalW / w, normalH / h)
w, h = w * scale, h * scale

application = {
    content = {
		width = w,
        height = h,
        scale = 'letterbox',
        fps = 60,
        imageSuffix = {
			['@2x'] = 1.1,
            --['@4x'] = 2.1
		}
    }
}
