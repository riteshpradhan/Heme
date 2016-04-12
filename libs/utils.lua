-- @Author: Ritesh Pradhan
-- @Date:   2016-04-10 22:00:08
-- @Last Modified by:   Ritesh Pradhan
-- @Last Modified time: 2016-04-10 22:34:29

local _M = {}

local function print_table(t)
	for k,v in pairs(t) do

		print("Key : ", k, " ==> ", v)

	end
end

_M.print_table = print_table
return _M