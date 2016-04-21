-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:45:03
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 19:58:39

-- load required library files
local widget = require("widget")
local composer = require( "composer" );
local scene = composer.newScene();
local sounds = require( "libs.sounds" );
local images = require("libs.images");

local scrollView
local scrollTimer

local scrollListener = {}
local onScrollComplete = {}
local scrollToTop = {}
local scrollToBottom = {}


local lotsOfText = [[This is
                    Test
                    Toast
                    . No not transition.scaleTo( target, params )
                    but scroll view it is.
                    sdfa
                    dfs
                    fa
                    dfsad
                    fadf
                    addEventListenerfa
                    dfsadads
                    f
                    dfsadadsdf
                    sdfasd
                    function sdfasdfsd
                        fsd
                        f
                        sdfasdfsdsd
                        sdfasdfsdsdsd
                        f
                        sdfasdfsdsdsdsd
                        fsd
                        fsd
                        f
                        sdfasdfsdsdsdsdfds
                        ( ... )
                        -- body
                    end]]


function scrollToBottom(event)
    scrollView:scrollTo( "bottom", { time=8000, onComplete=scrollToTop} )
end

function scrollToTop(event)
    scrollView:scrollTo( "top", { time=100, onComplete=scrollToBottom } )
end

function scrollListener(event)
    local phase = event.phase
    local direction = event.direction

    if event.limitReached then
        if direction == "up" then
            print("Reached top limit")
        elseif direction == "down" then
            print("Reached down limit")
        end
    end
end




function scene:create( event )
    local sceneGroup = self.view

    local function btnBackHandler(event)
        sounds.play('back')
		local sceneOpt = {effect = "crossFade", time = 600}
        composer.gotoScene("scenes.menu", sceneOpt)
	end

    -- Load Background image
    local bgImage = display.newImage("images/scenes/credits.png")
    bgImage.x = display.contentCenterX
	bgImage.y = display.contentCenterY
    sceneGroup:insert(bgImage)

    local backButton = widget.newButton(
        {
            x = 125,
            y = 70,
            sheet = images.backButtonSheet,
            defaultFrame = 1,
            overFrame = 2,
            onRelease = btnBackHandler
        }
    )

    local caption = display.newText( sceneGroup, "CREDITS", display.contentCenterX, 100, "Comic Sans MS", 80 )
    caption:setFillColor( 0,0.5,0.3 )

    scrollView = widget.newScrollView
    {
        left = 100,
        top = 150,
        width = display.contentWidth - 200,
        height = display.contentHeight - 200,
        topPadding = 50,
        bottomPadding = 50,
        horizentalScrollDisabled = true,
        verticalScrollDisabled = false,
        listener = scrollListener,
        backgroundColor = { 0.2, 0.2, 0.2, 0.6 },
    }


    local creditsText = display.newText( lotsOfText, 0, 0, 500, 0, "Comic Sans MS", 30 )
    creditsText:setFillColor( 1 )
    creditsText.x = display.contentCenterX
    creditsText.y = display.contentCenterY + 200
    scrollView:insert( creditsText )


    sceneGroup:insert(scrollView)
    sceneGroup:insert(backButton)


end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if ( phase == "will") then
        scrollView:scrollToPosition({ time=100, y=100 } )
    elseif ( phase == "did" ) then
        -- scrollView:scrollToPosition( { time = 100, y=100, onComplete=scrollToBottom} )
        scrollTimer = timer.performWithDelay( 500, scrollToBottom, 1 )
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    local params = event.params
    if ( phase == "will") then
        timer.cancel(scrollTimer)
    elseif ( phase == "did" ) then
    end
end
-- Added event listener for scene
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
return scene;