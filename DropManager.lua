require "lib.classes.class"
--------------------------------------------------------------------------------------------------------
local DropManager = class(function(self)
    self.drops = {}
    self.times = {}
    self.purge_dt = 5
    self.drop_width = 0.003
    self.expansion_speed = 0.3
    self.time_to_disappear = 1
end)

function DropManager.addRandomDrop(self, current_time)
    local drop = {math.random(), math.random() }
    table.insert(self.drops, drop)
    table.insert(self.times, current_time)
end

function DropManager.purge(self, current_time)
    local survivor_drops = {}
    local survivor_times = {}

    for i = 1, (#self.drops) do
        if self.times[i] > (current_time - self.purge_dt) then
            table.insert(survivor_drops, self.drops[i])
            table.insert(survivor_times, self.times[i])
        end
    end

    self.drops = survivor_drops
    self.times = survivor_times
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

function DropManager.getExpansionSpeed(self)
    return self.expansion_speed
end

function DropManager.getTimeToDisappear(self)
    return self.time_to_disappear
end

return DropManager