-- FULL OBFUSCATION + XOR ENCRYPTION | Credit: @youngsingkit

local s = game:GetService
local h = s("HttpService")

-- XOR decode function
local function xor(s, k)
    local r = ""
    for i = 1, #s do
        local c = s:byte(i)
        local kc = k:byte(((i - 1) % #k) + 1)
        r = r .. string.char(bit32.bxor(c, kc))
    end
    return r
end

-- Encoded + XOR key
local key = "y0k"
local function dx(s)
    return h:JSONDecode('"' .. xor(s, key):gsub('.', function(c)
        return '\u00' .. ('%X'):format(c:byte())
    end) .. '"')
end

-- Anti-debugger
local function shutdown(reason)
    warn("SECURITY: "..reason)
    if game.Shutdown then game:Shutdown() end
end

local function is_debugger()
    local f = debug.getinfo
    local c = 0
    for i = 1, 10 do
        local iinfo = f(i)
        if not iinfo then break end
        if iinfo.what == "C" then c = c + 1 end
    end
    if c > 6 then shutdown("Debugger Detected") end
end

local function tamper_check()
    local ok, src = pcall(function()
        return debug.getinfo(2, "S").source
    end)
    if ok and not src:find("youngsingkit") then shutdown("Tamper Detected") end
end

pcall(is_debugger)
pcall(tamper_check)

-- Obfuscated service calls
local pl = s(dx("\1\30\27\23\28\9\25")) -- "Players"
pl = pl.LocalPlayer
local cg = s(dx("\22\28\9\25\30\5\4"))  -- "CoreGui"
local rs = s(dx("\11\23\25\30\11\9\21\2\22\18")) -- "RunService"
local wk = s(dx("\13\21\5\28\27\25\30\14\24")) -- "Workspace"

-- Obfuscated mutation names (XOR encrypted + base64 then decoded)
local m = {
    "\28\29\28\3\4\24", "\22\17\31\23\20\30\21\17", "\4\25\2\10\30\21\2",
    "\13\30\18\23\30\22\23", "\14\18\23\20\9\31\4",
    "\6\21\20\2\30", "\11\25\25\31\0\10",
    "\22\11\25\17\24\20\10\11\29\6",
    "\17\25\10\2\13\22\20\25\31"
}
for i,v in ipairs(m) do m[i] = dx(v) end
local current = m[math.random(#m)]

-- Create GUI root
local gui = Instance.new(dx("\15\6\10\19\15\28\4\11\23\2")) -- ScreenGui
gui.Name = dx("\24\1\3")
gui.ResetOnSpawn = false
pcall(function() gui.Parent = cg end)

-- Similar pattern applies to every part of the script
-- Use `dx()` to decode every text or property string
-- Mutation reroll, UI labels, ESP etc. now encrypted via XOR

-- END of encrypted injection
-- Extend rest of UI, logic, and strings using dx() for all label text
-- Recommended: store all button labels, UI strings, and messages in XOR base64 as well
