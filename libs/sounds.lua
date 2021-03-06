-- @Author: Ritesh Pradhan
-- @Date:   2016-04-09 17:42:51
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-21 00:41:42

-- Sounds library
-- Manager for the sound and music files.
-- Automatically loads files and keeps a track of them.
-- Use playSteam() for music files and play() for short SFX files.

local _M = {}

_M.isSoundOn = true
_M.isMusicOn = true

local sounds = {
	-- win = 'sounds/win.wav',
	-- lose = 'sounds/lose.wav',

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
    player_spawn = 'sounds/launch.wav',
    player_fire = 'sounds/Laser_Shoot4.wav',
    player_destroy = 'sounds/hit_ground.wav',
    player_collide = 'sounds/Explosion12.wav',
    player_collect_powerups = 'sounds/power_up_3.wav',
    player_health_refill = 'sounds/powerUp6.wav',
    player_ammo_refill = 'sounds/ammo_refill.wav',
    player_fuel_refill = 'sounds/powerUp8.wav',
    player_collect_collectible = 'sounds/Pickup_Coin19.wav',
    player_hit = 'sounds/Explosion12.wav',

    -- Enemy aircraft sounds
    aircraft_fire = 'sounds/Laser_Shoot5.wav',
    aircraft_destroy = 'sounds/Explosion9.wav',
    aircraft_hit = 'sounds/Explosion6.wav',
    aircraft_collide = 'sounds/Explosion6.wav',

    -- Enemy bird sounds
    bird_destroy = 'sounds/Randomize.wav',
    bird_hit = 'sounds/bird_hit.wav',
    bird_collide = 'sounds/bird_hit.wav',

    -- Store sounds
    purchase_coin = 'sounds/sell_buy_item.wav',
    purchase_ammo = 'sounds/sell_buy_item.wav',
    purchase_fuel = 'sounds/sell_buy_item.wav',
    purchase_health = 'sounds/sell_buy_item.wav',
    insufficient_fund = 'sounds/alert.wav',

    -- Bullet sounds
	bullet_collide = 'sounds/Explosion7.wav',
    bullet_collide_ammo = 'sounds/ammo_refill.wav',
    bullet_collide_fuel = 'sounds/Powerup7.wav',
    bullet_collide_health = 'sounds/Powerup4.wav',

    --- other sounds
    bg_music_menu = 'sounds/bg/ERH-BlueBeat-01-_loop_.wav',
    bg_music_game = 'sounds/bg/beach.wav',
    bg_music_game_over = 'sounds/bg/JordanTrudgett-battle-ccby3.wav',

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

function _M.stop(channel)
    currentStreamSound = nil
    if(channel) then
        audio.stop(channel)
    else
        audio.stop()
    end
end

function _M.play(sound, params)
    if not _M.isSoundOn then return end
    if not sounds[sound] then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    return audio.play(loadSound(sound), params)
end

function _M.musicStop()
    audio.stop(25)
end

function _M.musicPlay(sound, params)
    if not _M.isMusicOn then return end
    if not sounds[sound] and audio.isChannelPlaying(25) then
        print('sounds: no such sound: ' .. tostring(sound))
        return
    end
    _M.musicStop()
    return audio.play(loadSound(sound), {loops = -1, channel = 25})
end

return _M
