-- console.lua

console = {}

function consolelua()
    startup = startup + 1
end

maxFiles = 17

if not ( love.filesystem.getInfo("tbconsolelogs.txt") ) then
    love.filesystem.write("tbconsolelogs.txt", "")
end

function console.log(str)
    local consoledata = love.filesystem.read("tbconsolelogs.txt")
    love.filesystem.write("tbconsolelogs.txt", consoledata.."\n"..str)
    if startup >= maxFiles then
        console.log("bootup success")
    else
        console.log("bootup error, "..(maxFiles - startup).." files not loaded...")
    end
    print(str)
end

function console.load()
    console.log("---------------------------------")
    console.log("Running \"The Box\" on LÖVE "..love.getVersion())
end

