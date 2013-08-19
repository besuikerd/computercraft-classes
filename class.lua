--load settings
local handle = fs.open("classes_settings", "r")
_G["__class_settings"] = textutils.unserialize(handle.readAll())
handle.close()
print(__class_settings.repo)
