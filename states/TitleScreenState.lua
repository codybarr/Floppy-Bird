--[[
	TitleScreenState Class

	The TitleScreenState is the starting screen of the game, shown on startup. It should
	display "Press Enter" and also our highest score.
]]

local Class = require('libs.hump.class')
TitleScreenState = Class{__includes = BaseState}
local isTouchOS = love.system.getOS() == "Android" or love.system.getOS() == "iOS"

function TitleScreenState:init()
	-- nothing
end

function TitleScreenState:update(dt)
	if love.keyboard.wasPressed('enter') -- keyboard
		or love.keyboard.wasPressed('return') -- keyboard
		or love.mouse.wasPressed(1) -- mouse
		or love.touch.wasTouched == true then -- touch
		gStateMachine:change('countdown')
	end
end

function TitleScreenState:render()
	love.graphics.setFont(flappyFont)
	love.graphics.printf('Floppy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(mediumFont)
	
	msg = isTouchOS == true and 'Tap to Play' or 'Press Enter'
	love.graphics.printf(msg, 0, 100, VIRTUAL_WIDTH, 'center')
end