local Util = {}

Util.merge_tables = function(first, second)
  for k, v in pairs(second) do first[k] = v end
  return first
end

return Util
