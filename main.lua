-- @Author: Ritesh Pradhan
-- @Date:   2016-04-08 13:51:34
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 14:13:01

local physics = require( "widget" )
local physics = require( "physics" )
physics.start( )
physics.setGravity( 0, 0 )
-- physics.setDrawMode( 'hybrid' )

--------- globals and utils -----------
local hemeDatabox = require('libs.databox') -- This library automatically loads and saves it's storage into databox.json inside Documents directory
local sounds = require( "libs.sounds" );


local composer = require( "composer" )
local scene = composer.newScene()

-- -------------- Initialization -----------
hemeDatabox()
sounds.isSoundOn = hemeDatabox.isSoundOn
sounds.isMusicOn = hemeDatabox.isMusicOn
-- ------------------------------------------


local function enterMenu(event)
	display.remove( hemeSplash );
	hemeSplash = nil;

	local sceneOpt = {
		effect = "crossFade",
		time = 1500
	}
	-- load first scene
	composer.gotoScene( "scenes.menu", sceneOpt);
end

local hemeSplash = display.newImage( "images/splashScreen.png", display.contentCenterX, display.contentCenterY)

timer.performWithDelay(1000,
					function()
						transition.fadeOut( hemeSplash, {time=1000, onComplete=enterMenu} );
					end
					, 1)
