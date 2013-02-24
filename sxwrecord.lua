args={...}
if #args==1 then
print("Press F1 to stop recording")
print("Recording in 3...")
sleep(1)
print("Recording in 2...")
sleep(1)
print("Recording in 1...")
sleep(1)
else
print("Usage: sxwrecord <file>")
os.queueEvent("terminate")
os.pullEvent()
end
--Config
local timing=0.5
--End of config

local rec={}
local sleeptime=0
local rterm=term
local nterm={}

term.clear()
term.setCursorPos(1,1)
print("Recording!")

function change(name, ...)
local act={}
act.name=name
act.param=arg
record(act)
end
function record(act)
act.time=sleeptime
term.insert(rec, textutils.serialize(act))
sleeptime=0
end

function nterm.write(str)
rterm.write(srt)
change("write", str)
end
function nterm.clear()
rterm.clear()
change("clear")
end
function nterm.clearLine()
rterm.clearLine()
change("clearLine")
end
function nterm.setCursorPos(x,y)
rterm.setCursorPos(x,y)
change("setCursorPos", x, y)
end
function nterm.setCursorBlink(val)
rterm.setCursorBlink(val)
change("setCursorBlink", val)
end
function nterm.scroll(amt)
rterm.scroll(amt)
change("scroll", amt)
end
function nterm.setTextColor(c)
rterm.setTextColor(c)
change("setTextColor", c)
end
function nterm.setBackgroundColor(c)
rterm.setBackgroundColor(c)
change("setBackgroundColor")
end

function timeloop()
while true do
sleep(timing)
sleeptime=sleeptime+timing
end
end

function endloop()
while true do
e,p=os.pullEvent("key")
if p==keys["f1"] then
return
end
end
end

function rshell()
shell.run("/rom/programs/shell")
end
for k,v in pairs(nterm) do
term[k]=v
end

--parallel.waitForAny(endloop,timeloop,rshell)
for k,v in pairs(rterm) do
term[k]=v
end
term.clear()
term.setCursorPos(1,1)
print("Recording ended!")
fs.delete(args[1])
local file=fs.open(args[1], "w")
--file.write(textutils.serialize(rec))
file.close()