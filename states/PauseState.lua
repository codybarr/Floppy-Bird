--[[
	PauseState Class
	Author: Colton Ogden
	cogden@cs50.harvard.edu

	The PauseState class will be a transition state to pause the play state
	and return to it when the 'p' key is toggled.
]]

local Class = require('libs.hump.class')
PauseState = Class{__includes = BaseState}

function PauseState:init()

end

function PauseState:update(dt)
	if love.keyboard.wasPressed('p') then
		gStateMachine:change('play')
	end
end

function PauseState:render()
	for k, pair in pairs(self.pipePairs) do
		pair:render()
	end

	love.graphics.setFont(flappyFont)
	love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

	self.bird:render()
end

--[[
	Called when this state is transitioned to from another state.
]]
-- function PauseState:enter()
-- 	-- if we're coming from death, restart scrolling
-- 	scrolling = true
-- end

-- --[[
-- 	Called when this state changes to another state.
-- ]]
-- function PauseState:exit()
-- 	-- stop scrolling for the death/score screen
-- 	scrolling = false
-- end