-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 22:00:08
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-19 15:06:50

local _M = {}

local function print_table(t)
	if t  ~= nil then
		for k,v in pairs(t) do
			print("Key : ", k, " ==> ", v)
		end
	end
end

local function pauseGameTimers(t)
	print ("**********************************************************************************", #t)
	for i, v in ipairs(t) do
		print ("***********************************************%%%%***********************************", #t)
		if v ~= nil then
			timer.pause(v)
			print ("**************&&&&********************************************************************", #t)
		end
	end
end

local function resumeGameTimers(t)
	for i, v in ipairs(t) do
		if v ~= nil then
			timer.resume(v)
		end
	end
end

local function cancelGameTimers(t)
	for i, v in ipairs(t) do
		if v ~= nil then
			timer.cancel(v)
		end
	end
end

_M.print_table = print_table
_M.pauseGameTimers = pauseGameTimers
_M.resumeGameTimers = resumeGameTimers
_M.cancelGameTimers = cancelGameTimers
return _M