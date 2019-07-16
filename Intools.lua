script_name('Inst Tools')
script_version('5.8')
script_author('Damien_Requeste')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- Р·Р°РіСЂСѓР¶Р°РµРј Р±РёР±Р»РёРѕС‚РµРєСѓ
local encoding = require 'encoding' -- Р·Р°РіСЂСѓР¶Р°РµРј Р±РёР±Р»РёРѕС‚РµРєСѓ
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- СѓРєР°Р·С‹РІР°РµРј РєРѕРґРёСЂРѕРІРєСѓ РїРѕ СѓРјРѕР»С‡Р°РЅРёСЋ, РѕРЅР° РґРѕР»Р¶РЅР° СЃРѕРІРїР°РґР°С‚СЊ СЃ РєРѕРґРёСЂРѕРІРєРѕР№ С„Р°Р№Р»Р°. CP1251 - СЌС‚Рѕ Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "ITools {ffffff}|"
players1 = {'{ffffff}РќРёРє\t{ffffff}Р Р°РЅРі'}
players2 = {'{ffffff}Р”Р°С‚Р° РїСЂРёРЅСЏС‚РёСЏ\t{ffffff}РќРёРє\t{ffffff}Р Р°РЅРі\t{ffffff}РЎС‚Р°С‚СѓСЃ'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
prava = 0
pilot = 0
kater = 0
gun = 0
ribolov = 0
biznes = 0
departament = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style() -- РїР°Р±Р»РёРє РґРёР·Р°Р№РЅ Р°РЅРґСЂРѕРІРёСЂС‹, РєРѕС‚РѕСЂС‹Р№ СЋР·Р°Р»СЃСЏ РІ СЃРєСЂРёРїС‚Рµ СЂР°РЅРµРµ

	imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 5.0
    style.FramePadding = ImVec2(5, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
	style.GrabRounding = 3.0
	style.WindowTitleAlign = ImVec2(0.5, 0.5)


	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 0.50)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 0.80)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	--colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.TitleBgCollapsed] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.61, 0.92, 0.83)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 0.50) 	
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 0.50)
    colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    --colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    --colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.70)
    colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.80)

	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 0.98)
    --colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBg] = ImVec4(0.13, 0.12, 0.15, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.07, 0.61, 0.92, 0.83)

end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\instools.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "/time",
            v = {key.VK_3}
        }
	}
end

local instools =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'РЎС‚Р°Р¶РµСЂ',
	tarr = 'С‚СЌРі',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0
  },
  commands = 
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 97,
	tazer = 97,
	fastmenu = 113
  }
}
cfg = inicfg.load(nil, 'instools/config.ini')

local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
    ftext("РЎРєСЂРёРїС‚ СѓСЃРїРµС€РЅРѕ Р·Р°РіСЂСѓР¶РµРЅ. /tset - РѕСЃРЅРѕРІРЅРѕРµ РјРµРЅСЋ.", -1)
	ftext('РђРІС‚РѕСЂРѕРј РґР°РЅРЅРѕРіРѕ СЃРєСЂРёРїС‚Р° СЏРІР»СЏРµС‚СЃСЏ: Damien_Requeste', -1)
    ftext('РЎРєСЂРёРїС‚ РґРѕСЂР°Р±РѕС‚Р°РЅ: Roma_Mizantrop')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{139BEC}IT {ffffff}| РћС‚СЃСѓС‚СЃРІСѓРµС‚ С„Р°Р№Р» РєРѕРЅС„РёРіР°, СЃРѕР·РґР°РµРј.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{139BEC}IT {ffffff}| Р¤Р°Р№Р» РєРѕРЅС„РёРіР° СѓСЃРїРµС€РЅРѕ СЃРѕР·РґР°РЅ.", -1)
      cfg = inicfg.load(nil, 'instools/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Р—Р°РіСЂСѓР¶Р°РµС‚СЃСЏ Р±РёР±Р»РёРѕС‚РµРєР° '..v)
        end
    end
	if not doesFileExist("moonloader/config/instools/keys.json") then
        local fa = io.open("moonloader/config/instools/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/instools/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/instools') then createDirectory('moonloader/instools') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+РћСЂРіР°РЅРёР·Р°С†РёСЏ%:%s+(.+)%s+Р Р°РЅРі')
  local rang = proverkk:match('.+Р Р°РЅРі%:%s+(.+)%s+Р Р°Р±РѕС‚Р°')
  local telephone = proverkk:match('.+РўРµР»РµС„РѕРЅ%:%s+(.+)%s+Р—Р°РєРѕРЅРѕРїРѕСЃР»СѓС€РЅРѕСЃС‚СЊ')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}РњРµСЃС‚Рѕ РґР»СЏ РїСЂРѕРґР°Р¶Рё Р»РёС†РµРЅР·РёР№', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('dcol', cmd_color)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('tset', tset)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('uninvite', uninvite)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('РџРѕ Р·Р°РІРµСЂС€РµРЅРёСЋ РІРІРµРґРёС‚Рµ РєРѕРјР°РЅРґСѓ РµС‰Рµ СЂР°Р·.')
            else
                changetextpos = false
				inicfg.save(cfg, 'instools/config.ini') -- СЃРѕС…СЂР°РЅСЏРµРј РІСЃРµ РЅРѕРІС‹Рµ Р·РЅР°С‡РµРЅРёСЏ РІ РєРѕРЅС„РёРіРµ
            end
        else
            ftext('Р”Р»СЏ РЅР°С‡Р°Р»Р° РІРєР»СЋС‡РёС‚Рµ РёРЅС„Рѕ-Р±Р°СЂ.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{139BEC}IT {ffffff}| РћС‚СЃСѓС‚СЃРІСѓРµС‚ С„Р°Р№Р» РєРѕРЅС„РёРіР°, СЃРѕР·РґР°РµРј.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{139BEC}IT {ffffff}| Р¤Р°Р№Р» РєРѕРЅС„РёРіР° СѓСЃРїРµС€РЅРѕ СЃРѕР·РґР°РЅ.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Driving School' then
    submenus_show(fastmenu(id), "{139BEC}IT {ffffff}| Р‘С‹СЃС‚СЂРѕРµ РјРµРЅСЋ")
	else
	ftext('Р’РѕР·РјРѕР¶РЅРѕ РІС‹ РЅРµ СЃРѕСЃС‚РѕРёС‚Рµ РІ Р°РІС‚РѕС€РєРѕР»Рµ {ff0000}[ctrl+R]')
	end
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
			if frac == 'Driving School' then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}РЈСЂРѕРІРµРЅСЊ - "..sampGetPlayerScore(id).." ")
				else
			ftext('Р’РѕР·РјРѕР¶РЅРѕ РІС‹ РЅРµ СЃРѕСЃС‚РѕРёС‚Рµ РІ Р°РІС‚РѕС€РєРѕР»Рµ {ff0000}[ctrl+R]')
				end
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
Р Р°СЃС†РµРЅРєРё РЅР° Р»РёС†РµРЅР·РёРё:

Р’РѕРґРёС‚РµР»СЊСЃРєРёРµ РїСЂР°РІР°
Р”Р»СЏ РїСЂРѕР¶РёРІР°СЋС‰РёС… РІ С€С‚Р°С‚Рµ РѕС‚ 1 РґРѕ 2-С… Р»РµС‚: 500$.
Р”Р»СЏ РїСЂРѕР¶РёРІР°СЋС‰РёС… РІ С€С‚Р°С‚Рµ РѕС‚ 3С… - РґРѕ 5-С‚Рё Р»РµС‚: 5.000$.
Р”Р»СЏ РїСЂРѕР¶РёРІР°СЋС‰РёС… РІ С€С‚Р°С‚Рµ РѕС‚ 6-С‚Рё РґРѕ 15-С‚Рё Р»РµС‚: 10.000$.
Р”Р»СЏ РїСЂРѕР¶РёРІР°СЋС‰РёС… РІ С€С‚Р°С‚Рµ РѕС‚ 16 Р»РµС‚: 30.000$.
Р С‹Р±РѕР»РѕРІСЃС‚РІРѕ
РљР°Р¶РґРѕРјСѓ Р¶РёС‚РµР»СЋ С€С‚Р°С‚Р°: 2.000$.
Р’РѕРґРЅС‹Р№ С‚СЂР°РЅСЃРїРѕСЂС‚
РљР°Р¶РґРѕРјСѓ Р¶РёС‚РµР»СЋ С€С‚Р°С‚Р°: 5.000$.
Р’РѕР·РґСѓС€РЅС‹Р№ С‚СЂР°РЅСЃРїРѕСЂС‚
РљР°Р¶РґРѕРјСѓ Р¶РёС‚РµР»СЋ С€С‚Р°С‚Р°: 10.000$.
РќР° РѕСЂСѓР¶РёРµ
РљР°Р¶РґРѕРјСѓ Р¶РёС‚РµР»СЋ С€С‚Р°С‚Р°: 50.000$.
РќР° Р±РёР·РЅРµСЃ
РљР°Р¶РґРѕРјСѓ Р¶РёС‚РµР»СЋ С€С‚Р°С‚Р°: 100.000$.

[1] РћР±С‰РµРµ РїРѕР»РѕР¶РµРЅРёРµ РђРІС‚РѕС€РєРѕР»С‹: РїРёСЃР°Р»(Р°):

? 1.1 РЈСЃС‚Р°РІ РђРІС‚РѕС€РєРѕР»С‹ СѓСЃС‚Р°РЅР°РІР»РёРІР°РµС‚ РїРѕР»РѕР¶РµРЅРёСЏ, РєРѕС‚РѕСЂС‹Рј РґРѕР»Р¶РЅС‹ СЃР»РµРґРѕРІР°С‚СЊ РІСЃРµ СЃРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹.
? 1.2 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РїРѕРґС‡РёРЅСЏС‚СЊСЃСЏ СЃС‚Р°СЂС€РёРј РїРѕ РґРѕР»Р¶РЅРѕСЃС‚Рё.
? 1.3 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РєР°С‡РµСЃС‚РІРµРЅРЅРѕ РѕР±СЃР»СѓР¶РёРІР°С‚СЊ СЃРІРѕРёС… РєР»РёРµРЅС‚РѕРІ.
? 1.4 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РјРѕР¶РµС‚ РІС‹РµР·Р¶Р°С‚СЊ РЅР° РІС‹Р·РѕРІС‹ РіРѕСЃ. СЃС‚СЂСѓРєС‚СѓСЂ РґР»СЏ РїСЂРѕРґР°Р¶Рё Р»РёС†РµРЅР·РёР№.
? 1.5 РќРµР·РЅР°РЅРёРµ СѓСЃС‚Р°РІР° РЅРµ РѕСЃРІРѕР±РѕР¶РґР°РµС‚ РІР°СЃ РѕС‚ РѕС‚РІРµС‚СЃС‚РІРµРЅРЅРѕСЃС‚Рё.
? 1.6 Р—Р°РїСЂРµС‰РµРЅС‹ Р»СЋР±С‹Рµ СЂР°Р·РіРѕРІРѕСЂС‹ Рѕ РїРѕРІС‹С€РµРЅРёРё РёР»Рё РЅР°Р·РЅР°С‡РµРЅРёРё РЅР° СѓРїСЂР°РІР»СЏСЋС‰СѓСЋ РґРѕР»Р¶РЅРѕСЃС‚СЊ РІ Р»СЋР±РѕР№ С„РѕСЂРјРµ ( Р’ Р»СЋР±С‹Рµ С‡Р°С‚С‹, РІ С‚РѕРј С‡РёСЃР»Рµ /f, /fb, /b, /sms ).
? 1.7 РЈСЃС‚Р°РІ РјРѕР¶РµС‚ Р±С‹С‚СЊ РёР·РјРµРЅРµРЅ РІ Р»СЋР±РѕРµ РІСЂРµРјСЏ РЈРїСЂР°РІР»СЏСЋС‰РёРј РђРІС‚РѕС€РєРѕР»С‹.


[2] РћР±СЏР·Р°РЅРЅРѕСЃС‚Рё СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РђРІС‚РѕС€РєРѕР»С‹: РїРёСЃР°Р»(Р°):

? 2.1 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ СЃРѕР±Р»СЋРґР°С‚СЊ РЈСЃС‚Р°РІ РђРІС‚РѕС€РєРѕР»С‹. 
? 2.2 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ Р·РЅР°С‚СЊ Рё СЃРѕР±Р»СЋРґР°С‚СЊ РІСЃРµ РїСЂР°РІРёР»Р° Рё Р·Р°РєРѕРЅС‹ С€С‚Р°С‚Р°. 
? 2.3 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РґРѕР»Р¶РµРЅ СЃР»РµРґРёС‚СЊ Р·Р° СЃРѕР±Р»СЋРґРµРЅРёРµ РѕС‡РµСЂРµРґРЅРѕСЃС‚Рё РїСЂРё РѕР±СЃР»СѓР¶РёРІР°РЅРёРё РєР»РёРµРЅС‚РѕРІ.
? 2.4 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РїРѕРґР°РІР°С‚СЊ РїСЂРёРјРµСЂ РёРґРµР°Р»СЊРЅС‹Рј РІРѕР¶РґРµРЅРёРµРј Рё РѕС‚Р»РёС‡РЅС‹Рј Р·РЅР°РЅРёРµРј РџР”Р”.
? 2.5 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹, РїСЂРµР¶РґРµ С‡РµРј РІС‹РґР°С‚СЊ Р»РёС†РµРЅР·РёСЋ, РѕР±СЏР·Р°РЅ РїРѕРїСЂРѕСЃРёС‚СЊ РїР°СЃРїРѕСЂС‚ Сѓ РєР»РёРµРЅС‚Р° Рё Р·Р°РїРѕР»РЅРёС‚СЊ Р±Р»Р°РЅРє РЅР° Р»РёС†РµРЅР·РёСЋ РµРіРѕ РґР°РЅРЅС‹РјРё. РџСЂРѕСЃС‚Р°СЏ РІС‹РґР°С‡Р° Р»РёС†РµРЅР·РёРё Р±РµР· РїР°СЃРїРѕСЂС‚Р° Рё Р·Р°РїРѕР»РЅРµРЅРёСЏ Р±Р»Р°РЅРєР° РїСЂРёРІРµРґС‘С‚ Рє РІС‹РЅРµСЃРµРЅРёСЋ РІС‹РіРѕРІРѕСЂР° СЃРѕС‚СЂСѓРґРЅРёРєСѓ;?
? 2.6 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РїСЂРёРґРµСЂР¶РёРІР°С‚СЊСЃСЏ РґРёР°Р»РѕРіР° РІ РѕС„РёС†РёР°Р»СЊРЅРѕРј СЃС‚РёР»Рµ;?
? 2.7 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ СЃР»РµРґРёС‚СЊ Р·Р° СЃРѕР±РѕР№ Рё РёР·Р±РµРіР°С‚СЊ Р»СЋР±С‹С… Р°РіСЂРµСЃСЃРёРІРЅС‹С… Рё РїСЂРѕРІРѕРєР°С†РёРѕРЅРЅС‹С… РґРµР№СЃС‚РІРёР№;?
? 2.8 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РѕС‚РІРµС‡Р°С‚СЊ РЅР° Р·Р°РґР°РІР°РµРјС‹Рµ РїРѕСЃРµС‚РёС‚РµР»СЏРјРё РІРѕРїСЂРѕСЃС‹, РєР°СЃР°РµРјС‹Рµ Р»РёС†РµРЅР·РёР№ Рё РџР”Р”. РќР° РІРѕРїСЂРѕСЃС‹, РЅРµ РѕС‚РЅРѕСЃСЏС‰РёРµСЃСЏ Рє СЂР°Р±РѕС‚Рµ РёРЅСЃС‚СЂСѓРєС‚РѕСЂРѕРІ, СЃРѕС‚СЂСѓРґРЅРёРє РІ РїСЂР°РІРµ РЅРµ РѕС‚РІРµС‡Р°С‚СЊ;?
? 2.9 РЎРѕС‚СЂСѓРґРЅРёРєРё РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р±РµР№РґР¶РёРєРё СЃРѕРіР»Р°СЃРЅРѕ РїСЂРёРЅР°РґР»РµР¶РЅРѕСЃС‚Рё Рє С‚РѕРјСѓ РёР»Рё РёРЅРѕРјСѓ РѕС‚РґРµР»Сѓ.
? 2.9.1 РЎРѕС‚СЂСѓРґРЅРёРєРё СЃС‚Р°СЂС€РµРіРѕ СЃРѕСЃС‚Р°РІР° РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє - в„– 15. 
? 2.9.2 CРѕС‚СЂСѓРґРЅРёРєРё Р±РµР· РѕС‚РґРµР»Р° РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє - в„– 4. 
? 2.9.3 Р“Р»Р°РІР° РѕС‚РґРµР»Р° РЅРѕСЃРёС‚ Р‘РµР№РґР¶РёРє в„–12.
? 2.9.4 Р—Р°РјРµСЃС‚РёС‚РµР»СЊ РіР»Р°РІС‹ РѕС‚РґРµР»Р° РЅРѕСЃРёС‚ Р‘РµР№РґР¶РёРє в„–8.
? 2.9.5 РЎРѕС‚СЂСѓРґРЅРёРє РћС‚РґРµР»Р° РљРѕРЅС‚СЂРѕР»СЏ РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„–16.
? 2.9.6 РЎРѕС‚СЂСѓРґРЅРёРє РћС‚РґРµР»Р° РЎС‚Р°Р¶РёСЂРѕРІРєРё РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„–6.
? 2.9.7 РћС‚РІРµС‚СЃС‚РІРµРЅРЅС‹Р№ Р·Р° СЂР°Р±РѕС‚Сѓ РІ Р¤РёР»РёР°Р»Рµ Р‘РµР№РґР¶РёРє в„–26
? 2.9.8 РЎРѕС‚СЂСѓРґРЅРёРє РєРѕС‚РѕСЂС‹Р№ РїСЂРёС…РѕРґРёС‚СЃСЏ Р­РєР·Р°РјРµРЅР°С‚РѕСЂРѕРј РїРѕ Р·Р°СЏРІРєРµ РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„– 10.
? 2.9.9 РЎРѕС‚СЂСѓРґРЅРёРєРё РЅР°С…РѕРґСЏС‰РёРµСЃСЏ РЅР° СЃС‚Р°Р¶РёСЂРѕРІРєРµ РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р±РµР№РґР¶РёРє Р‘РµР№РґР¶РёРє - в„– 23.
? 2.9.10 РљСѓСЂР°С‚РѕСЂ Р°РІС‚РѕС€РєРѕР»С‹ РґРѕР»Р¶РµРЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє - в„– 28.
? 2.10 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РїРѕРґС‡РёРЅСЏС‚СЊСЃСЏ СЃС‚Р°СЂС€РёРј РїРѕ РґРѕР»Р¶РЅРѕСЃС‚Рё.
? 2.11 Р’ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ СЃРѕС‚СЂСѓРґРЅРёРє РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ СѓРЅРёС„РѕСЂРјСѓ РІС‹РґР°РЅРЅСѓСЋ РІ РѕС„РёСЃРµ.
? 2.12 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РІС‹Р±СЂР°С‚СЊ РѕС‚РґРµР» РїРѕСЃР»Рµ РїРѕР»СѓС‡РµРЅРёСЏ РёРј РґРѕР»Р¶РЅРѕСЃС‚Рё "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ". (РЎРѕС‚СЂСѓРґРЅРёРєРё Р±РµР· РѕС‚РґРµР»Р° РЅРµ Р±СѓРґСѓС‚ РїРѕРІС‹С€Р°С‚СЊСЃСЏ).
? 2.13 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РєР°С‡РµСЃС‚РІРµРЅРЅРѕ РѕР±СЃР»СѓР¶РёРІР°С‚СЊ СЃРІРѕРёС… РєР»РёРµРЅС‚РѕРІ.
? 2.14 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ СЃРїР°С‚СЊ С‚РѕР»СЊРєРѕ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р° РІ РѕС„РёСЃРµ РђРІС‚РѕС€РєРѕР»С‹. (Р
