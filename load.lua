os.loadAPI("classes")
old_force = classloader.force

force_load(true)
local args = {...}
if(#args == 1) then
  import(args[1])
end
force_load(old_force)