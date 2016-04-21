-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 21:20:16
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-20 21:07:59

local _M = {}
_M.yLevel = {[1]=460, [2]=330, [3]=200, [4]=160}
_M.scrollSpeed = 2
_M.gameTimers = {}
_M.physicsBodies = {}

_M.isGameOver = false
_M.isCoinUpdate = false
_M.isMedalUpdate = false
_M.isAmmoUpdate = false
_M.isFuelUpdate = false
_M.isHealthUpdate = false

return _M