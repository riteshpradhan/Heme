local circle;
local box;

local bg1  
local bg2  
local runtime = 0  
local scrollSpeed = 5


local function addScrollableBg()  
    local bgImage = { type="image", filename="bg.jpg" }
    -- Add First bg image
    bg1 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    bg1.fill = bgImage
    bg1.x = display.contentCenterX
    bg1.y = display.contentCenterY
    -- Add Second bg image
    bg2 = display.newRect(0, 0, display.contentWidth, display.actualContentHeight)
    bg2.fill = bgImage
    bg2.x = display.contentCenterX + display.actualContentWidth
    bg2.y = display.contentCenterY -- - display.actualContentHeight
end
local function moveBg(dt)  
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

local function getDeltaTime()  
   local temp = system.getTimer()
   local dt = (temp-runtime) / (1000/60)
   runtime = temp
   return dt
end
local function enterFrame()  
    local dt = getDeltaTime()
    moveBg(dt)
end


local function tapHandler(event)
	print("Tapped!")
end

local function touchHandler(event)
    local swipeLength = math.abs(event.y - event.yStart) 
    local t = event.target
    local phase = event.phase
    if "began" == phase then
        return true
    elseif "moved" == phase then
        if (event.yStart > event.y and swipeLength > 50 ) then 
            transition.to( circle, { time=50, y=(circle.y - 180) } )
        elseif event.yStart < event.y and swipeLength > 50 then 
            transition.to( circle, { time=50, y=(circle.y + 180) } )
            -- print( "Swiped Down", circle.y )                
        end         	
    elseif "ended" == phase or "cancelled" == phase then
                    print( "Position: ", circle.y )

    end
end


function init()  
    addScrollableBg()
    Runtime:addEventListener("enterFrame", enterFrame)
	circle = display.newCircle(280, display.contentCenterY, 60);
	circle:setFillColor(0.7,1,0.4);
	Runtime:addEventListener("touch", touchHandler);


end
init()  





