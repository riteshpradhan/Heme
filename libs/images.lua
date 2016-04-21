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
local hema = {}
local bird = {}
local aircraft = {}
------------------------------------------------------
------------- HEME -----------------------------------
local hemeOption = { width=194, height=76, numFrames=2, sheetContentWidth=388, sheetContentHeight=76 }
local hemeSheet = graphics.newImageSheet( 'images/player/hemeSheet.png', hemeOption )
local hemeSequenceData = { name="heme", start=1, count=2, time=200 }
heme.sheet = hemeSheet
heme.sequenceData = hemeSequenceData

-------------------------------------------------------
---------------------- HEMA ---------------------------
local hemaOption = { width=194, height=76, numFrames=2, sheetContentWidth=388, sheetContentHeight=76 }
local hemaSheet = graphics.newImageSheet( 'images/player/hemaSheet.png', hemaOption )
local hemaSequenceData = { name="hema", start=1, count=2, time=200 }
hema.sheet = hemaSheet
hema.sequenceData = hemaSequenceData

------------------------------------------------------
------------- BIRD -----------------------------------
local birdOption = { width=83, height=45, numFrames=2, sheetContentWidth=166, sheetContentHeight=45 }
local birdSheet = graphics.newImageSheet( 'images/enemy/birdEnemySheet.png', birdOption )
local birdSequenceData = { name="bird", start=1, count=2, time=200 }
bird.sheet = birdSheet
bird.sequenceData = birdSequenceData

------------------------------------------------------
------------- AIRCRAFT -----------------------------------
local aircraftOption = { width=175, height=76, numFrames=2, sheetContentWidth=350, sheetContentHeight=76 }
local aircraftSheet = graphics.newImageSheet( 'images/enemy/aircraftEnemySheet.png', aircraftOption )
local aircraftSequenceData = { name="aircraft", start=1, count=2, time=200 }
aircraft.sheet = aircraftSheet
aircraft.sequenceData = aircraftSequenceData


------------------------ STORE BUTTONS --------------------
-----------------------------------------------------------
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
_M.hema = hema
_M.kush = kush
_M.birdEnemy = bird
_M.aircraftEnemy = aircraft
_M.buttonSheet = buttonSheet
_M.storeButtonSheet = storeButtonSheet
_M.backButtonSheet = backButtonSheet

return _M

