GetExecutioner = function(filename)
  local str = filename
  local temp = ""
  local result = ""
  for i = str:len(), 1, -1 do
    if str:sub(i,i) ~= "." then
      temp = temp..str:sub(i,i)
    else
      break
    end
  end

  for j = temp:len(), 1, -1 do
    result = result..temp:sub(j,j)
  end

  if(result == "py") then
    return "python3 "
  else
    return result
  end
end
