-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 21:20:16
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-19 14:49:37

local _M = {}
_M.yLevel = {[1]=460, [2]=360, [3]=200, [4]=160}
_M.isGameOver = false
_M.scrollSpeed = 5
_M.gameTimers = {}
_M.physicsBodies = {}
return _M