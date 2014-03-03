os.loadAPI("classes")
old_force = classloader.force

force_load(true)
local args = {...}
if(#args >= 1) then
  print(args[2] == "false")
  import(args[1], not args[2] and true or args[2] and args[2] ~= "false")
end
force_load(old_force)