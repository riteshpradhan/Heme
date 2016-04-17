-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 22:00:08
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-16 23:36:06

local _M = {}

local function print_table(t)
	if t  ~= nil then
		for k,v in pairs(t) do
			print("Key : ", k, " ==> ", v)
		end
	end
end

_M.print_table = print_table
return _M