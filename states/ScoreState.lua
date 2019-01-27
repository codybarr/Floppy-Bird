--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

local Class = require('libs.hump.class')
ScoreState = Class{__includes = BaseState}
local isTouchOS = love.system.getOS() == "Android" or love.system.getOS() == "iOS"

local trophies = {
	['bronze'] = love.graphics.newImage('assets/images/trophy-bronze.png'),
	['silver'] = love.graphics.newImage('assets/images/trophy-silver.png'),
	['gold'] = love.graphics.newImage('assets/images/trophy-gold.png')
}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
	if love.keyboard.wasPressed('enter')
		or love.keyboard.wasPressed('return') -- keyboard
		or love.mouse.wasPressed(1) -- mouse
		or love.touch.wasTouched == true then -- touch
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
	love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
	
	trophyX, trophyY = VIRTUAL_WIDTH / 2 - trophies['bronze']:getWidth() / 2, VIRTUAL_HEIGHT / 2 - trophies['bronze']:getHeight() / 2

	if self.score >= 20 then
		love.graphics.draw(trophies['gold'], trophyX, trophyY)
	elseif self.score >= 10 then
		love.graphics.draw(trophies['silver'], trophyX, trophyY)
	elseif self.score >= 5 then
		love.graphics.draw(trophies['bronze'], trophyX, trophyY)
	else
		love.graphics.setFont(smallFont)
		love.graphics.printf('Sorry, you need at least 5 points to earn a trophy', 0, trophyY + 20, VIRTUAL_WIDTH, 'center')
	end
	

	message = string.format("%s to Play Again!", isTouchOS == true and "Tap" or "Press Enter")
	love.graphics.setFont(mediumFont)
    love.graphics.printf(message, 0, 180, VIRTUAL_WIDTH, 'center')
end