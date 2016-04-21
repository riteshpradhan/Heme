-- @Author: Kush Chandra Shrestha
-- @Date:   2016-04-15 23:45:03
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 23:06:51

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


local lotsOfText = [[



HEME

Developers
1. Kush Chandra Shrestha
2. Ritesh Pradhan
3. Samyam Acharya


Sound Effects
1. http://soundbible.com
2. http://opengameart.org/content/100-plus-game-sound-effects-wavoggm4a
    Copyright/Attribution Notice:
    you do not have to add a link but if you want to credit me feel free. Damaged Panda

Background Music
1. Menu Music:
    ERH-BlueBeat-01-_loop_.wav
    http://opengameart.org/content/bluebeat-01-loop-cyberpunk-lab-music
    "BlueBeat 01" Copyright 2007 ERH http://www.freesound.org/people/ERH/ , License: http://creativecommons.org/licenses/by/3.0/

2. Game Music:
    beach.wav
    http://opengameart.org/content/42-monster-rpg-2-music-tracks
    These are the music files (in FLAC and OGG formats) from the recently open sourced Monster RPG 2. (Except jungle_ambience, which is not original).

    The game is licensed under the Give It Your Own License, License, and I've chosen to re-license them under CC0, but I'm sure the good folks at Nooskewl Games would appreciate a shout out if you use their works.

3. GameOver Music:
    JordanTrudgett-battle-ccby3.wav
    http://opengameart.org/content/fantasy-action-rpg-soundtrack-14-tracks-for-ardentryst-by-jordan-trudgett
    Copyright 2008 Jordan Trudgett | http://jordan.trudgett.com/ - Licensed under CC BY 3.0 http://creativecommons.org/licenses/by/3.0/

Code Ideas:
    1. Corona Cannon | The MIT License | Copyright (c) 2016 Corona Labs, Inc. https://coronalabs.com/

Images
    1. Hema
         Licensed under CC BY 3.0 http://creativecommons.org/licenses/by/3.0/


                    Copyright@2016  Heme Studios
]]


function scrollToBottom(event)
    scrollView:scrollTo( "bottom", {time=20000, onComplete=scrollToTop} )
end

function scrollToTop(event)
    scrollView:scrollTo( "top", { time=10, onComplete=scrollToBottom } )
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
 --    local bgImage = display.newImage("images/scenes/credits.png")
 --    bgImage.x = display.contentCenterX
	-- bgImage.y = display.contentCenterY
 --    sceneGroup:insert(bgImage)

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

    local caption = display.newText( sceneGroup, "CREDITS", display.contentCenterX, 75, "Comic Sans MS", 80 )
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
        backgroundColor = { 0.3, 0.3, 0.3, 0.6 },
    }


    local creditsText = display.newText( lotsOfText, 0, 0, 1100, 0, "Comic Sans MS", 30 )
    creditsText:setFillColor( 1 )
    creditsText.x = display.contentCenterX
    creditsText.y = display.contentCenterY + 600
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

return scene
