-- scan character handles
---[[
local charas = {
    autopcr.getUnitAddr(104701, 5, 13),
    autopcr.getUnitAddr(101701, 5, 15),
    autopcr.getUnitAddr(104301, 5, 13),
    autopcr.getUnitAddr(106301, 5, 15),
    autopcr.getUnitAddr(103801, 5, 15)
};
--]]
-- data for 1600x900
---[[ minitouch test
minitouch.connect("localhost", 1111);
for i = 0, 4 do
    minitouch.setPos(5 - i, 400 + i * 208, 860);
end
minitouch.setPos(6, 1544, 716); --auto
minitouch.setPos(7, 1544, 839); --forward
minitouch.setPos(8, 1512, 43);  --pause
--]]

--[[ mouse calibration
for i = 1, 5 do
    autopcr.calibrate(i);
end
--]]

---[[ auto ub
while (autopcr.getTime() > 1) --when not end
do
    for i = 2, 5 do --judge every chara
        if (autopcr.getTp(charas[i]) == 1000) --ready for tp
        then
            autopcr.waitTillCrit(charas[i], 85, false, 300 + autopcr.getFrame());
            print('trying to press '..i, 'frame='..autopcr.getFrame())
            --autopcr.framePress(i);
            minitouch.framePress(i); --trigger ub press
            break;
        end
    end
end
--]]

--[[ benchmark
autopcr.setOffset(2, 0); -- hyperparam, 2 frame offset for minitouch

autopcr.waitFrame(2000);
minitouch.press(1);
autopcr.waitFrame(2500);
minitouch.press(2);
autopcr.waitFrame(3000);
minitouch.press(3);
autopcr.waitFrame(3500);
minitouch.press(4);
autopcr.waitFrame(4000);
minitouch.press(5);
--]]

--[[ crit test
local chara = autopcr.getUnitAddr(106301, 5, 15)
local boss = 85;
local last = 0;

while (true)
do
    local now = autopcr.nextCrit();
    if (now ~= last)
    then
        last = now;
        local crit = autopcr.getCrit(chara, boss, false);
        if (now < crit)
        then
            print('yls必定暴击 crit rate = '..crit, 'next crit = '..now);
        else
            print('yls必定不暴击 crit rate = '..crit, 'next crit = '..now);
        end
    end
end
--]]

autopcr.waitTime(.5);
minitouch.framePress(8);