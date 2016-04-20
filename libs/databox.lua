-- @Author: Ritesh Pradhan
-- @Date:   2016-04-15 21:23:06
-- @Last Modified by:   Kush Chandra Shrestha
-- @Last Modified time: 2016-04-19 19:38:39


-- Databox
-- This library automatically loads and saves it's storage into databox.json inside Documents directory.
-- It uses metatables to do it's job.
-- Require the library and call it with a table of default values. Only 1 level deep table is supported.
-- supported values are strings, numbers and booleans.
-- It will create and populate the file on the first run. If file already exists, it will load it's content into the data table.
-- Accessing data is simple like databox.someKey
-- Saving data is automatic on key change, you only need to set a value like databox.someKey = 'someValue'
-- If you update default values, all new values will be added into the existing file.

local json = require('json')

local data = {}
local defaultData = {
                        ammo=100, fuel=100, health=100,
                        coin=0, medal=0, player="heme", highscore=0, totalMiles=0,
                        isSoundOn = true, isMusicOn = true, isHelpShown = false,
                        medalBuyCoin = 5, coinBuyAmmo = 200, coinBuyFuel = 500, coinBuyHealth = 300,
                        coinAdd = 50, ammoAdd = 10, fuelAdd = 10, healthAdd = 10,
                        defaultPlayer = 'heme'
                    }

local path = system.pathForFile('databox.json', system.DocumentsDirectory)

-- Copy tables by value
-- Nested tables are not supported
local function shallowcopy(t)
    local copy = {}
    for k, v in pairs(t) do
        if type(k) == 'string' then
            if type(v) == 'number' or type(v) == 'string' or type(v) == 'boolean' then
                copy[k] = v
            else
                print('databox: Values of type "' .. type(v) .. '" are not supported.')
            end
        end
    end
    return copy
end

-- When saving,  save to disk
local function saveData()
    local file = io.open(path, 'w')
    if file then
        file:write(json.encode(data))
        io.close(file)
    end
end

-- When loading, try  reading from disk
-- If no file  - load defaults
local function loadData()
    local file = io.open(path, 'r')
    if file then
        data = json.decode(file:read('*a'))
        io.close(file)
    else
        data = shallowcopy(defaultData)
        saveData()
    end
end

-- If you update your app and set new defaults, check if an old file has all the keys
local function patchIfNewDefaultData()
    local isPatched = false
    for k, v in pairs(defaultData) do
        if data[k] == nil then
            data[k] = v
            isPatched = true
        end
    end
    if isPatched then
        saveData()
    end
end

-- Metatables action!
local mt = {
    __index = function(t, k) -- On indexing, just return a field from the data table
        return data[k]
    end,
    __newindex = function(t, k, value) -- On setting an index, save the data table automatically
        data[k] = value
        saveData()
    end,
    __call = function(t, value) -- On calling, initiate with defaults
        if type(value) == 'table' then
            defaultData = shallowcopy(value)
        end
        loadData()
        patchIfNewDefaultData()
    end
}

local _M = {}
setmetatable(_M, mt)
return _M
