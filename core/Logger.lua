class "Logger"

Logger.Level = table.immutable{
  ERROR = {name = "ERROR", importance = 1},
  WARN = {name = "WARN", importance = 2},
  INFO = {name = "INFO", importance = 3},
  DEBUG = {name = "DEBUG", importance = 4}
}

function Logger:__construct(level)
  if not level then level = Logger.Level.DEBUG end
  self.level = level
  if not level.name or not level.importance then
    error("invalid logging level passed to Logger constructor")
  end
end

function Logger:log(level, msg, ...)
  if level.importance <= self.level.importance then
    self:doLog(level, msg, ...)
  end
end

function Logger:error(msg, ...)
  self:log(Logger.Level.ERROR, msg, ...)
end

function Logger:warn(msg, ...)
  self:log(Logger.Level.WARN, msg, ...)
end

function Logger:info(msg, ...)
  self:log(Logger.Level.INFO, msg, ...)
end

function Logger:debug(msg, ...)
  self:log(Logger.Level.DEBUG, msg, ...)
end

function Logger:formatMessage(level, msg, ...)
  local args = {...}
  local fArgs = {}
  for i, j in ipairs(args) do
      fArgs[i] = type(j) == "table" and textutils.serialize(j) or j
  end
  return string.format("[%s]:%s", level.name, string.format(msg, unpack(fArgs)))
end

function Logger:doLog(level, msg, ...)
  print(self:formatMessage(level, msg, ...))
end

class "FileLogger" :extends(Logger)

function FileLogger:__construct(file, level)
  self.__super:__construct(level)
  if not file then error("missing file argument in FileLogger constructor") end
  self.file = file
end

function FileLogger:doLog(level, msg, ...)
  if not fs.exists(self.file) then
    if  not fs.precedingPathExists(self.file) then
      fs.mkPrecedingPath(self.file)
    end
    fs.open(self.file, "w").close()
  end
  
  local handle = fs.open(self.file, "a")
  handle.writeLine(self:formatMessage(level, msg, ...))
  handle.close()
end

class "MultiLogger" :extends(Logger)

function MultiLogger:__construct(level, file)
  FileLogger.__construct(self, level)
end

function MultiLogger:doLog(level, msg, ...)
  Logger.doLog(self, level, msg, ...)
  FileLogger.doLog(self, level, msg, ...)
end

__logger = MultiLogger:new("logs/global")

function log(level, msg, ...)
  __logger:log(level, msg, ...)
end

function Error(msg, ...) --to prevent name clashes
  log(Logger.Level.ERROR, msg, ...)
end

function warn(msg, ...)
  log(Logger.Level.WARN, msg, ...)
end

function info(msg, ...)
  log(Logger.Level.INFO, msg, ...)
end

function debug(msg, ...)
  log(Logger.Level.DEBUG, msg, ...)
end