class "EventBus"

function EventBus:__construct
	self.listeners = {}
end

function EventBus:subscribe(events, listener)
	--checks if event already has an entry, if not create it
	local addEvent = function(event, listener)
		if self.listeners[event] then
			table.insert(self.listener[event], listener)
		else
			self.listener[event] = {listener}
		end
	end
	
	if type(events) == "string" then
		addEvent(events, listener)
	elseif type(events) == "table" then
		for i, event in ipairs(events) do
			addEvent(event, listener)
		end
	end
end

function EventBus:post(event, ...)
	--check if event exists
	if not self.listeners[event] then return end
	
	for i, listener in ipairs(self.listener[event]) do
		listener[](...)
	end
end
