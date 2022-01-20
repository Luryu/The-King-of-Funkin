function setDefault(id)
end

function start (song)
end

function update (elapsed)
	if curStep >= 128 and curStep <= 165 then 
		tweenCameraZoom(1.2,(crochet * 4) / 1000)		
	end

	-- if morebounce then 
	--	for i=0,7 do
	--		setActorY(_G['defaultStrum'..i..'Y'] + 18 * math.cos((currentBeat*2 * math.pi)), i)
	--	end
	--end
	--if swayslow then
	--	for i=4,7 do
	--		setActorX(_G['defaultStrum'..i..'X'] + 128 * math.sin(currentBeat*0.10 * math.pi), i)
	--		setActorY(_G['defaultStrum'..i..'Y'] + 18 * math.cos((currentBeat*0.45 + i*0.5 * math.pi)), i)
	--	end
	--end
end

local xTo0 = 0
local xTo1 = 0
local xTo2 = 0
local xTo3 = 0
local xTo4 = 0
local xTo5 = 0
local xTo6 = 0
local xTo7 = 0
local startBumping = false
local lastStep = 0

function twoPlayer()
		for i=0,3 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 365, getActorAngle(i) + 360, 0.5, 'setDefault')
			tweenFadeIn(i,1, 0.5)
		end
		for i=4,7 do
			tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 275, getActorAngle(i) + 360, 0.5, 'setDefault')
		end
end

function onePlayer()
	for i=0,3 do
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] + 365,getActorAngle(i) + 360, 0.5, 'setDefault')
		tweenFadeOut(i,0, 0.5)
    end
	for i =4,7 do 
		tweenPosXAngle(i, _G['defaultStrum'..i..'X'] - 275,getActorAngle(i) + 360, 0.5, 'setDefault')
	end
end

function bumpArrows()
    setActorX(xTo0, 0)
    tweenPos(0,xTo0 + 30,getActorY(0),0.25)
    setActorX(xTo1, 1)
    tweenPos(1,xTo1 + 15,getActorY(1),0.25)

    setActorX(xTo2, 2)
    tweenPos(2,xTo2 - 15,getActorY(2),0.25)
    setActorX(xTo3, 3)
    tweenPos(3,xTo3 - 30, getActorY(3),0.25)

    setActorX(xTo4, 4)
    tweenPos(4,xTo4 + 30,getActorY(4),0.25)
    setActorX(xTo5, 5)
    tweenPos(5,xTo5 + 15,getActorY(5),0.25)

    setActorX(xTo6, 6)
    tweenPos(6,xTo6 - 15,getActorY(6),0.25)
    setActorX(xTo7, 7)
    tweenPos(7,xTo7 - 30, getActorY(7),0.25)
end

function beatHit (beat)

end

function stepHit (step)
	if lastStep ~= step then
		lastStep = step
	end
end