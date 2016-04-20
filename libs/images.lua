-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:43:04

-- all sprite loads here

--[[
-- Library for preloading all image sheet
-- Make data sequence
-- Create sheet and import when necessary accross game
-- Contains all sprites
]]

-- self.sheetIdleData = { width=194, height=76, numFrames=2, sheetContentWidth=388, sheetContentHeight=76 }
-- self.sheetIdle = graphics.newImageSheet( 'images/player/hemeIdleSheet.png', self.sheetIdleData )
-- self.idleSequenceData = { name="idle", start=1, count=2, time=200 }
-- self.idleAnimation = display.newSprite( self.sheetIdle, self.idleSequenceData )
-- self.idleAnimation.x, self.idleAnimation.y = self.xPos, self.yPos
-- self.idleAnimation:play()





local _M = {}

local heme = {}
local kush = {}

------------------------------------------------------
------------- HEME -----------------------------------
local hemeOption = { width=194, height=76, numFrames=2, sheetContentWidth=388, sheetContentHeight=76 }
local hemeSheet = graphics.newImageSheet( 'images/player/hemeSheet.png', hemeOption )
local hemeSequenceData = { name="heme", start=1, count=2, time=200 }
heme.sheet = hemeSheet
heme.sequenceData = hemeSequenceData

--------------------------------------------------------
---------- KUSH-----------------------------------------
local kushOption =
{
	frames = {
		{ x = 1, y = 2, width = 16, height = 25}, --frame 1
		{ x = 18, y = 2, width = 16, height = 25}, --frame 2
		{ x = 35, y = 2, width = 16, height = 25}, --frame 3
		{ x = 52, y = 2, width = 16, height = 25}, --frame 4
		{ x = 1, y = 54, width = 16, height = 24}, --ready1
		{ x = 19, y = 54, width = 16, height = 24}, --ready2
		{ x = 37, y = 54, width = 29, height = 24}, -- rock
		{ x = 67, y = 54, width = 33, height = 24}, -- scissor
		{ x = 101, y = 54, width = 33, height = 24}, --paper
	}
};
local kushSheet = graphics.newImageSheet( "imges/player/kush.png", kushOption );

-- Create alex animation sequence for animation
local kushSequenceData = {
	{name = "normal", start=1 , count = 4, time = 800},
	{name = "faster", frames = {1,2,3,4}, time = 400},
	{name = "shake", frames={5,6}, time = 500},
	{name = "rock", frames={7}},
	{name = "paper", frames={9}},
	{name = "scissor", frames={8}},
}
kush.sheet = kushSheet
kush.sequenceData = kushSequenceData

--------------------------------------------------
------------------- Button ------------------------
local buttonOption = {
	frames =
	{
		{ x = 3, y = 2, width=70, height = 22}, --frame 1
		{ x = 78, y = 2, width=70, height = 22}, --frame 2
	}
};
local buttonSheet = graphics.newImageSheet( "button.png", buttonOption );


-- local storeButtonOption = {
-- 	frames = {
-- 		{}
-- 	}

-- }


-- btnGo = widget.newButton( {
-- 			x = 200,
-- 			y = 20,
-- 			id = "btnGo",
-- 			label = "Go!",
-- 			labelColor = { default={ 0, 0, 0 }, over={ 0, 0, 0 } }, sheet = buttonSheet,
-- 			defaultFrame = 1,
-- 			overFrame = 2,
-- 			onPress = go,
-- 		} );

local storeButtonOptions = {
    width = 236,
    height = 81,
    numFrames = 2,
    sheetContentWidth = 472,
    sheetContentHeight = 81
}

local storeButtonSheet = graphics.newImageSheet( "images/scenes/storeButton.png", storeButtonOptions )

local backButtonOptions = {
	width = 128,
	height = 99,
	numFrames = 2,
	sheetContentWidth = 256,
	sheetContentHeight = 99
}

local backButtonSheet = graphics.newImageSheet("images/scenes/backButton.png", backButtonOptions)

----------------------------------------------------
-------- Insert eveything in libs.images table --------
_M.heme = heme
_M.kush = kush
_M.buttonSheet = buttonSheet
_M.storeButtonSheet = storeButtonSheet
_M.backButtonSheet = backButtonSheet

return _M

