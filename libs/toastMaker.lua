-- @Author: Ritesh Pradhan
-- @Date:   2016-04-20 17:50:21
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 18:29:57


local _M = {}

function _M.makeToast(parentGroup, toastText)
	local myToast = display.newText( parentGroup, toastText, display.contentCenterX, display.contentCenterY, "Comic Sans MS", 60 )
    myToast:setFillColor( 0, 0, 0, 0.6 )
    myToast.x = display.contentCenterX
    myToast.y = display.contentCenterY - 250
    transition.fadeOut( myToast, {time=700} )
end


return _M