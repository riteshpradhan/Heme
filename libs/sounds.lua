-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:42:51
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-18 00:09:01

-- Sounds library
-- Manager for the sound and music files.
-- Automatically loads files and keeps a track of them.
-- Use playSteam() for music files and play() for short SFX files.

local _M = {}

_M.isSoundOn = true
_M.isMusicOn = true

local sounds = {
	win = 'sounds/win.wav',
	lose = 'sounds/lose.wav',

    -- Menu item sounds
    play = 'sounds/select-settings.wav',
    pause = 'sounds/click-off.wav',  
    menu_item = 'sounds/click-on.wav',
    back = 'sounds/click-off.wav',

    -- Setting item sounds
    setting_item = 'sounds/select-settings.wav',
    music_toggle_on = 'sounds/select-menu.wav',
    music_toggle_off = 'sounds/select-menu.wav',
    sound_toggle_on = 'sounds/select-menu.wav',
    sound_toggle_off = 'sounds/select-menu.wav',

    -- Player sounds
    player_spawn = 'sounds/fire-player.wav',
    player_fire = 'sounds/fire-player.wav',
    player_destroy = 'sounds/fire-player.wav',
    player_collide = 'sounds/fire-player.wav',
    player_collect_powerups = 'sounds/fire-player.wav',
    player_collect_refills = 'sounds/fire-player.wav',
    player_collect_collectible = 'sounds/fire-player.wav',
    player_hit = 'sounds/fire-player.wav',

    -- Enemy aircraft sounds
    aircraft_fire = 'sounds/fire-enemy.wav',
    aircraft_destroy = 'sounds/fire-player.wav',
    aircraft_hit = 'sounds/fire-player.wav',
    aircraft_collide = 'sounds/fire-enemy.wav',

    -- Enemy bird sounds
    bird_destroy = 'sounds/fire-player.wav',
    bird_hit = 'sounds/fire-player.wav',
    bird_collide = 'sounds/fire-enemy.wav',

    -- Store sounds
    purchase_coin = 'sounds/coins.wav',
    purchase_ammo = 'sounds/select-menu.wav',
    purchase_fuel = 'sounds/select-menu.wav',
    purchase_health = 'sounds/select-menu.wav',
    insufficient_fund = 'sounds/alert.wav',
	--- other sounds
}

-- Reserve two channels for streams and switch between them with a nice fade out / fade in transition
local audioChannel, otherAudioChannel, currentStreamSound = 1, 2
function _M.playStream(sound, force)
    if not _M.isMusicOn then return end
    if not sounds[sound] then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    sound = sounds[sound]
    if currentStreamSound == sound and not force then return end
    audio.fadeOut({channel = audioChannel, time = 1000})
    audioChannel, otherAudioChannel = otherAudioChannel, audioChannel
    audio.setVolume(0.5, {channel = audioChannel})
    audio.play(audio.loadStream(sound), {channel = audioChannel, loops = -1, fadein = 1000})
    currentStreamSound = sound
end
audio.reserveChannels(2)

-- Keep all loaded sounds here
local loadedSounds = {}
local function loadSound(sound)
    if not loadedSounds[sound] then
        loadedSounds[sound] = audio.loadSound(sounds[sound])
    end
    return loadedSounds[sound]
end

function _M.play(sound, params)
    if not _M.isSoundOn then return end
    if not sounds[sound] then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    return audio.play(loadSound(sound), params)
end

function _M.stop()
    currentStreamSound = nil
    audio.stop()
end

return _M
