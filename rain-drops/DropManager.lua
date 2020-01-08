require "lib.classes.class"
--------------------------------------------------------------------------------------------------------
local DropManager = class(function(self)
    self.drops = {}
    self.times = {}
    self.speeds = {}
    self.purge_dt = 5
    self.drop_width = 0.002
    self.max_expansion_speed = 0.3
    self.time_to_disappear = 1
end)

function DropManager.addRandomDrop(self, current_time)
    local drop = {math.random(), math.random() }
    table.insert(self.drops, drop)
    table.insert(self.times, current_time)
    table.insert(self.speeds, math.random()*self.max_expansion_speed + 0.001)
end

function DropManager.purge(self, current_time)
    local survivor_drops = {}
    local survivor_times = {}
    local survivor_speeds = {}

    for i = 1, (#self.drops) do
        if self.times[i] > (current_time - self.purge_dt) then
            table.insert(survivor_drops, self.drops[i])
            table.insert(survivor_times, self.times[i])
            table.insert(survivor_speeds, self.speeds[i])
        end
    end

    self.drops = survivor_drops
    self.times = survivor_times
    self.speeds = survivor_speeds
end

function DropManager.getDrops(self)
    return self.drops
end

function DropManager.getTimes(self)
    return self.times
end

function DropManager.getDropWidth(self)
    return self.drop_width
end

function DropManager.getExpansionSpeeds(self)
    return self.speeds
end

function DropManager.getMaxExpansionSpeeds(self)
    return self.speeds
end

function DropManager.getTimeToDisappear(self)
    return self.time_to_disappear
end

return DropManager