script_name('Inst Tools')
script_version('5.7')
script_author('Damien_Requeste')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- çàãðóæàåì áèáëèîòåêó
local encoding = require 'encoding' -- çàãðóæàåì áèáëèîòåêó
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
encoding.default = 'CP1251' -- óêàçûâàåì êîäèðîâêó ïî óìîë÷àíèþ, îíà äîëæíà ñîâïàäàòü ñ êîäèðîâêîé ôàéëà. CP1251 - ýòî Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "ITools {ffffff}|"
players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
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
function apply_custom_style() -- ïàáëèê äèçàéí àíäðîâèðû, êîòîðûé þçàëñÿ â ñêðèïòå ðàíåå

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
    tar = 'Ñòàæåð',
	tarr = 'òýã',
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
    ftext("Ñêðèïò óñïåøíî çàãðóæåí. /tset - îñíîâíîå ìåíþ.", -1)
	ftext('Àâòîðîì äàííîãî ñêðèïòà ÿâëÿåòñÿ: Damien_Requeste', -1)
    ftext('Ñêðèïò äîðàáîòàí: Roma_Mizantrop')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{139BEC}IT {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{139BEC}IT {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
      cfg = inicfg.load(nil, 'instools/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Çàãðóæàåòñÿ áèáëèîòåêà '..v)
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
  local frakc = proverkk:match('.+Îðãàíèçàöèÿ%:%s+(.+)%s+Ðàíã')
  local rang = proverkk:match('.+Ðàíã%:%s+(.+)%s+Ðàáîòà')
  local telephone = proverkk:match('.+Òåëåôîí%:%s+(.+)%s+Çàêîíîïîñëóøíîñòü')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}Ìåñòî äëÿ ïðîäàæè ëèöåíçèé', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
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
                ftext('Ïî çàâåðøåíèþ ââåäèòå êîìàíäó åùå ðàç.')
            else
                changetextpos = false
				inicfg.save(cfg, 'instools/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
            end
        else
            ftext('Äëÿ íà÷àëà âêëþ÷èòå èíôî-áàð.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{139BEC}IT {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{139BEC}IT {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Driving School' then
    submenus_show(fastmenu(id), "{139BEC}IT {ffffff}| Áûñòðîå ìåíþ")
	else
	ftext('Âîçìîæíî âû íå ñîñòîèòå â àâòîøêîëå {ff0000}[ctrl+R]')
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
                submenus_show(pkmmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}Óðîâåíü - "..sampGetPlayerScore(id).." ")
				else
			ftext('Âîçìîæíî âû íå ñîñòîèòå â àâòîøêîëå {ff0000}[ctrl+R]')
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
Ðàñöåíêè íà ëèöåíçèè:

Âîäèòåëüñêèå ïðàâà
Äëÿ ïðîæèâàþùèõ â øòàòå îò 1 äî 2-õ ëåò: 500$.
Äëÿ ïðîæèâàþùèõ â øòàòå îò 3õ - äî 5-òè ëåò: 5.000$.
Äëÿ ïðîæèâàþùèõ â øòàòå îò 6-òè äî 15-òè ëåò: 10.000$.
Äëÿ ïðîæèâàþùèõ â øòàòå îò 16 ëåò: 30.000$.
Ðûáîëîâñòâî
Êàæäîìó æèòåëþ øòàòà: 2.000$.
Âîäíûé òðàíñïîðò
Êàæäîìó æèòåëþ øòàòà: 5.000$.
Âîçäóøíûé òðàíñïîðò
Êàæäîìó æèòåëþ øòàòà: 10.000$.
Íà îðóæèå
Êàæäîìó æèòåëþ øòàòà: 50.000$.
Íà áèçíåñ
Êàæäîìó æèòåëþ øòàòà: 100.000$.

[1] Îáùåå ïîëîæåíèå Àâòîøêîëû: ïèñàë(à):

 1.1 Óñòàâ Àâòîøêîëû óñòàíàâëèâàåò ïîëîæåíèÿ, êîòîðûì äîëæíû ñëåäîâàòü âñå ñîòðóäíèêè Àâòîøêîëû.
 1.2 Ñîòðóäíèêè Àâòîøêîëû îáÿçàíû ïîä÷èíÿòüñÿ ñòàðøèì ïî äîëæíîñòè.
 1.3 Ñîòðóäíèêè Àâòîøêîëû îáÿçàíû êà÷åñòâåííî îáñëóæèâàòü ñâîèõ êëèåíòîâ.
 1.4 Ñîòðóäíèêè Àâòîøêîëû ìîæåò âûåçæàòü íà âûçîâû ãîñ. ñòðóêòóð äëÿ ïðîäàæè ëèöåíçèé.
 1.5 Íåçíàíèå óñòàâà íå îñâîáîæäàåò âàñ îò îòâåòñòâåííîñòè.
 1.6 Çàïðåùåíû ëþáûå ðàçãîâîðû î ïîâûøåíèè èëè íàçíà÷åíèè íà óïðàâëÿþùóþ äîëæíîñòü â ëþáîé ôîðìå ( Â ëþáûå ÷àòû, â òîì ÷èñëå /f, /fb, /b, /sms ).
 1.7 Óñòàâ ìîæåò áûòü èçìåíåí â ëþáîå âðåìÿ Óïðàâëÿþùèì Àâòîøêîëû.


[2] Îáÿçàííîñòè ñîòðóäíèêîâ Àâòîøêîëû: ïèñàë(à):

 2.1 Ñîòðóäíèê Àâòîøêîëû îáÿçàí ñîáëþäàòü Óñòàâ Àâòîøêîëû. 
 2.2 Ñîòðóäíèê Àâòîøêîëû îáÿçàí çíàòü è ñîáëþäàòü âñå ïðàâèëà è çàêîíû øòàòà. 
 2.3 Ñîòðóäíèê Àâòîøêîëû äîëæåí ñëåäèòü çà ñîáëþäåíèå î÷åðåäíîñòè ïðè îáñëóæèâàíèè êëèåíòîâ.
 2.4 Ñîòðóäíèê Àâòîøêîëû îáÿçàí ïîäàâàòü ïðèìåð èäåàëüíûì âîæäåíèåì è îòëè÷íûì çíàíèåì ÏÄÄ.
 2.5 Ñîòðóäíèê Àâòîøêîëû, ïðåæäå ÷åì âûäàòü ëèöåíçèþ, îáÿçàí ïîïðîñèòü ïàñïîðò ó êëèåíòà è çàïîëíèòü áëàíê íà ëèöåíçèþ åãî äàííûìè. Ïðîñòàÿ âûäà÷à ëèöåíçèè áåç ïàñïîðòà è çàïîëíåíèÿ áëàíêà ïðèâåä¸ò ê âûíåñåíèþ âûãîâîðà ñîòðóäíèêó;?
 2.6 Ñîòðóäíèê Àâòîøêîëû îáÿçàíû ïðèäåðæèâàòüñÿ äèàëîãà â îôèöèàëüíîì ñòèëå;?
 2.7 Ñîòðóäíèê Àâòîøêîëû îáÿçàíû ñëåäèòü çà ñîáîé è èçáåãàòü ëþáûõ àãðåññèâíûõ è ïðîâîêàöèîííûõ äåéñòâèé;?
 2.8 Ñîòðóäíèê Àâòîøêîëû îáÿçàíû îòâå÷àòü íà çàäàâàåìûå ïîñåòèòåëÿìè âîïðîñû, êàñàåìûå ëèöåíçèé è ÏÄÄ. Íà âîïðîñû, íå îòíîñÿùèåñÿ ê ðàáîòå èíñòðóêòîðîâ, ñîòðóäíèê â ïðàâå íå îòâå÷àòü;?
 2.9 Ñîòðóäíèêè îáÿçàíû íîñèòü áåéäæèêè ñîãëàñíî ïðèíàäëåæíîñòè ê òîìó èëè èíîìó îòäåëó.
 2.9.1 Ñîòðóäíèêè ñòàðøåãî ñîñòàâà îáÿçàíû íîñèòü Áåéäæèê - ¹ 15. 
 2.9.2 Cîòðóäíèêè áåç îòäåëà îáÿçàíû íîñèòü Áåéäæèê - ¹ 4. 
 2.9.3 Ãëàâà îòäåëà íîñèò Áåéäæèê ¹12.
 2.9.4 Çàìåñòèòåëü ãëàâû îòäåëà íîñèò Áåéäæèê ¹8.
 2.9.5 Ñîòðóäíèê Îòäåëà Êîíòðîëÿ îáÿçàí íîñèòü Áåéäæèê ¹16.
 2.9.6 Ñîòðóäíèê Îòäåëà Ñòàæèðîâêè îáÿçàí íîñèòü Áåéäæèê ¹6.
 2.9.7 Îòâåòñòâåííûé çà ðàáîòó â Ôèëèàëå Áåéäæèê ¹26
 2.9.8 Ñîòðóäíèê êîòîðûé ïðèõîäèòñÿ Ýêçàìåíàòîðîì ïî çàÿâêå îáÿçàí íîñèòü Áåéäæèê ¹ 10.
 2.9.9 Ñîòðóäíèêè íàõîäÿùèåñÿ íà ñòàæèðîâêå îáÿçàíû íîñèòü áåéäæèê Áåéäæèê - ¹ 23.
 2.9.10 Êóðàòîð àâòîøêîëû äîëæåí íîñèòü Áåéäæèê - ¹ 28.
 2.10 Ñîòðóäíèê Àâòîøêîëû îáÿçàí ïîä÷èíÿòüñÿ ñòàðøèì ïî äîëæíîñòè.
 2.11 Â ðàáî÷åå âðåìÿ ñîòðóäíèê îáÿçàí íîñèòü óíèôîðìó âûäàííóþ â îôèñå.
 2.12 Ñîòðóäíèê Àâòîøêîëû îáÿçàí âûáðàòü îòäåë ïîñëå ïîëó÷åíèÿ èì äîëæíîñòè "Ýêçàìåíàòîð". (Ñîòðóäíèêè áåç îòäåëà íå áóäóò ïîâûøàòüñÿ).
 2.13 Ñîòðóäíèê Àâòîøêîëû îáÿçàí êà÷åñòâåííî îáñëóæèâàòü ñâîèõ êëèåíòîâ.
 2.14 Ñîòðóäíèê Àâòîøêîëû îáÿçàí ñïàòü òîëüêî â êîìíàòå îòäûõà â îôèñå Àâòîøêîëû. (Èñêëþ÷åíèå: Ñòàðøåìó Ñîñòàâó ðàçðåøåíî ñïàòü â êîìíàòå îòäûõà â îôèñå Àâòîøêîëû è íà ïàðêîâêå â ëè÷íûõ àâòîìîáèëÿõ)
 2.15 Ñîòðóäíèê Àâòîøêîëû, íàõîäÿùèéñÿ â äîëæíîñòè Ìë.Ìåíåäæåðà è âûøå, îáÿçàí îáíîâëÿòü ðååñòð êàæäûé äåíü äî 00:00.
 2.16 Ñîòðóäíèê Àâòîøêîëû, íàõîäÿùèéñÿ â äîëæíîñòè Ìë.Ìåíåäæåðà è âûøå, îáÿçàí äîêëàäûâàòü ïî ðàöèè î êàæäîì óâîëüíåíèè/ïîâûøåíèè/ïîíèæåíèè. 
 2.17 Êàæäûé ñîòðóäíèê ïîñëå âõîäà (âûõîäà) â êîìíàòó îòäûõà äîëæåí çàêðûâàòü çà ñîáîé äâåðè.
 2.18 Ñîòðóäíèê Àâòîøêîëû, ïðîäàâøèé ëèöåíçèþ íà áèçíåñ áåç çàÿâëåíèÿ âëàäåëüöà ïîëó÷àåò âûãîâîð I ñòåïåíè;
 2.19 Ñîòðóäíèê Àâòîøêîëû, çàíèìàþùèé äîëæíîñòü Ìë.Èíñòðóêòîðà è âûøå, äîëæåí âûåçæàòü íà âûçîâû ïî çàêàçó ëèöåíçèé.


[3] Ðàáî÷èé äåíü â Àâòîøêîëå: ïèñàë(à):

 3.1 Â áóäíè, ðàáî÷èé äåíü äëèòñÿ ñ 08:00 äî 21:00. Â âûõîäíûå äíè ðàáî÷èé äåíü äëèòñÿ ñ 9:00 äî 20:00.
 3.2 Âðåìÿ äëÿ ïåðåðûâà (îáåäà) ñ 13:00 äî 14:00.
 3.3 Â ðàáî÷åå âðåìÿ çàïðåùåíî íîñèòü ëþáûå àêñåññóàðû. (Èñêëþ÷åíèå: áåðåòû, øëÿïû, î÷êè, ÷àñû, óñû, ÷åìîäàíû è ðþêçàêè)
 3.4 Çàïðåùåíî ïîêèäàòü îôèñ â ðàáî÷åå âðåìÿ áåç ðàçðåøåíèÿ ñò.ñîñòàâà.
 3.5 Âðåìÿ ïðèáûòèÿ íà ðàáîòó, íåçàâèñèìî îò ìåñòà ïðîæèâàíèÿ  15 ìèíóò.
 3.6 Êàæäûé ñîòðóäíèê, îïàçäûâàþùèé íà ðàáîòó ïî ëþáûì ïðè÷èíàì, âïðàâå îòñðî÷èòü ñâîå ïðèáûòèå, óâåäîìèâ îá ýòîì ðóêîâîäñòâî Àâòîøêîëû.(íå áîëåå ÷åì íà 10 ìèíóò)
 3.7 Ïî æåëàíèþ ñîòðóäíèê ìîæåò îñòàòüñÿ íà íî÷íóþ ñìåíó ïîñëå êîíöà ðàáî÷åãî äíÿ.
 3.8 Çàïðåùåíî íàõîäèòüñÿ íà àâòîìîáèëüíîé ÿðìàðêå â ðàáî÷åå âðåìÿ.
 3.9 Ðàçðåøåíî â òå÷åíèå ðàáî÷åãî äíÿ ïîñåùàòü ÌÏ îò àäìèíèñòðàòîðîâ, à òàêæå ñèñòåìíûå ÌÏ (ãîíêè / Base Jump / Paint Ball), íî ïðè ýòîì ñîîáùàòü â ðàöèþ, ÷òî âû îòïðàâëÿåòåñü íà ìåðîïðèÿòèå;?
 3.10 Ðàçðåøåíî ïîêèäàòü îôèñ äëÿ äîñòàâêè ëèöåíçèé, ïðîâåäåíèÿ ëåêöèé ãîñ. îðãàíèçàöèÿì, à òàêæå ÷òîáû ïîêóøàòü.?


[4] Ñîòðóäíèêàì Àâòîøêîëû çàïðåùàåòñÿ: ïèñàë(à):

 4.1 Ïîêèäàòü ðàáî÷åå ìåñòî áåç ðàçðåøåíèÿ ñòàðøèõ.
 4.2 Ìëàäøåìó ñîñòàâó çàïðåùåíî ñïàòü âíå êîìíàòû îòäûõà.
 4.3 Íîñèòü îäåæäó íå ïî ñâîåé äîëæíîñòè.
 4.4 Áðàòü âåðòîëåò áåç ðàçðåøåíèÿ.
 4.5 Õàìèòü êëèåíòàì.
 4.6 Çàïðåùåíî îòêàçûâàòü â îáñëóæèâàíèè êëèåíòà, åñëè ó Âàñ ê íåìó ëè÷íàÿ íåïðèÿçíü;?
 4.7 Çàïðåùåíî âûäàâàòü ëèöåíçèè áåç ïðîâåäåíèÿ ýêçàìåíà;?
 4.8 Çàïðåùåíî ââîäèòü â çàáëóæäåíèå è îáìàíûâàòü ñòàðøèé ñîñòàâ è êîëëåã;?
 4.9 Îòáèðàòü äðóã ó äðóãà êëèåíòîâ.
 4.10 Íàõîäèòüñÿ â êàçèíî â ðàáî÷åå âðåìÿ.
 4.11 Íîñèòü ëþáûå àêñåññóàðû, çà èñêëþ÷åíèåì î÷êîâ è ÷àñîâ è áåðåòîâ.
 4.12 Ñïàòü áîëåå äåñÿòè ìèíóò (600 ñåêóíä) êàæäûé ÷àñ âî âðåìÿ ðàáî÷åãî äíÿ. Èñêëþ÷åíèÿ: ñòàðøèé ñîñòàâ, ðàáîòà â íî÷íóþ ñìåíó, ðàáîòà ñ îô. ïîðòàëîì (îò÷åò) èëè ðàçðåøåíèå Óïðàâëÿþùåãî. (
 4.13 Çà ÀÔÊ áåç ESC ñëåäóåò íàêàçàíèå îò ïðåäóïðåæäåíèÿ, äî óâîëüíåíèÿ.?
 4.14 Çàâîäèòü ðàçãîâîðû î ïîâûøåíèè èëè íàçíà÷åíèÿ íà óïðàâëÿþùóþ äîëæíîñòü â ëþáîé ôîðìå ( Â ëþáûå ÷àòû, â òîì ÷èñëå /f, /fb, /b, /sms ).
 4.15 Èñïîëüçîâàòü òðàíñïîðò, ïðèíàäëåæàùèé Àâòîøêîëå, â ëè÷íûõ öåëÿõ.
 4.16 Ðàáîòàòü íà ëþáîé ãîñóäàðñòâåííîé ðàáîòå, íå ñíèìàÿ ðàáî÷óþ ôîðìó.
 4.17 Ïîñåùàòü àâòîìîáèëüíóþ ÿðìàðêó â ðàáî÷åå âðåìÿ.
 4.18 Çàïðåùàåòñÿ Óïîòðåáëåíèå Íàðêîòèêîâ è Àëêîãîëÿ
 4.19 Çàïðåùåíî èñïîëüçîâàòü äâåðü â êîìíàòå îòäûõà â ðàçâëåêàòåëüíûõ íàìåðåíèÿõ.
 4.20 Çàïðåùåíî âûäàâàòü ëèöåíçèþ íà áèçíåñ áåç çàÿâëåíèÿ âëàäåëüöà.
 4.21 Çàïðåùåíî èñïîëüçîâàòü íåöåíçóðíûå âûðàæåíèÿ (êàê â IC òàê è â OOC ÷àòû)
 4.22 Çàïðåùåíî õðàíèòü çàïðåùåííûå ìàòåðèàëû è íàðêîòè÷åñêèå âåùåñòâà.
 4.23 Çàïðåùåíî ïèñàòü â äåïàðòàìåíò âî âðåìÿ ×Ñ- ×ðåçâû÷àéíîé ñèòóàöèè.


[5] Èåðàðõèÿ è ðóêîâîäñòâî îòäåëîâ àâòîøêîëû: ïèñàë(à):

 5.1 Â ñòàðøèé ñîñòàâ Àâòîøêîëû âõîäÿò ñîòðóäíèêè ñ äîëæíîñòè ìëàäøåãî Ìåíåäæåðà.
 5.2 Ñîòðóäíèêè ñòàðøåãî ñîñòàâà áåç äîëæíîñòè íå èìåþò òýãà â ðàöèè.
 5.3 Íàáèðàòü ê ñåáå â îòäåë ñîòðóäíèêîâ ìîæíî òîëüêî ñ äîëæíîñòè "Ýêçàìåíàòîð".
 5.4 Ãëàâîé îòäåëà ìîæåò áûòü ñîòðóäíèê â äîëæíîñòè èíñòðóêòîðà è âûøå.
 5.5 Çàìåñòèòåëåì ãëàâû îòäåëà ìîæåò áûòü ñîòðóäíèê â äîëæíîñòè ìë. èíñòðóêòîðà è âûøå.


[6] Íàêàçàíèÿ çà íàðóøåíèå óñòàâà: ïèñàë(à):

 6.1 Çà íàðóøåíèå óñòàâà, ñîòðóäíèê ìîæåò ïîëó÷èòü íàêàçàíèå íà óñìîòðåíèå ñòàðøåãî ñîñòàâà Àâòîøêîëû.


Èçîáðàæåíèå


Èçîáðàæåíèå · Ïðîôåññèîíàëüíàÿ ýòèêà ïèñàë(à):

Ïðîôåññèîíàëüíàÿ ýòèêà - ìíîæåñòâî íðàâñòâåííûõ íîðì, ïðè ïîìîùè êîòîðûõ îïðåäåëÿåòñÿ íàïðàâëåíèå âçàèìîîòíîøåíèé ÷åëîâåêà îïðåäåëåííîé ïðîôåññèè ñ íåîïðåäåëåííûì êðóãîì ëèö (íåèçáåæíîñòü êîíòàêòà ñ ýòèìè ëèöàìè îáóñëîâëåíà ïðîôåññèåé ÷åëîâåêà). 
Ïî ïðè÷èíå ó÷àñòèâøèõñÿ ñëó÷àåâ ññîð, ñïîðîâ, è íàöèîíàëèñòè÷åñêèõ øóòîê áûëà ñîçäàíà äàííàÿ òåìà, å¸ öåëü îáúÿñíèòü ëþäÿì, êîòîðûå åù¸ íå ïîëó÷èëè îò æèçíè îïûò ïîçâîëÿþùèé ðàçëè÷èòü óìåñòíîñòü øóòêè, êîãäà, êàê è ÷òî óìåñòíî ïèñàòü.


Èçîáðàæåíèå · ïèñàë(à):

Òàêèì îáðàçîì ìîæíî ñäåëàòü âûâîä, ÷òî ïðîôåññèîíàëüíàÿ ýòèêà ñîòðóäíèêîâ Àâòîøêîëû îïðåäåëÿåòñÿ õàðàêòåðîì îáÿçàííîñòåé âîçëîæåííûõ íà íàø êîëëåêòèâ. À îáÿçàííîñòè ó íàñ î÷åíü âàæíûå äëÿ ïîääåðæàíèÿ ÐÏ àòìîñôåðû. 
×åì æå ìû çàíÿòû? Àâòîøêîëà èãðàåò âàæíóþ ðîëü íà íàøåì ñåðâåðå ïðåæäå âñåãî èç-çà òîãî, ÷òî ÿâëÿåòñÿ îäíîé èç ïåðâûõ îðãàíèçàöèé, ÷ëåíîâ êîòîðîé âñòðå÷àþò íîâûå èãðîêè è áåçóñëîâíî ýòî ïåðâîå ìåñòî, ãäå îíè ïðèêîñíóòñÿ ê ïîíÿòèþ ÐÏ, à çíà÷èò ñîòðóäíèêè Àâòîøêîëû äîëæíû áûòü ìàêñèìàëüíî àäåêâàòíûìè, êàê â îòíîøåíèè ê èãðîêàì, òàê è âî âíóòðåííèõ âçàèìîîòíîøåíèÿõ êîëëåêòèâà.


Èçîáðàæåíèå · ïèñàë(à):

 Áåñïî÷âåííàÿ ãðóáîñòü â îòíîøåíèè ëþáûõ ñîòðóäíèêîâ íèæå âàñ ïî êàðüåðíîé ëåñòíèöå, â îñîáåííîñòè ñòàæåðîâ - ÿâëÿåòñÿ íåïðèåìëåìîé. 
 Ñëåäóåò ðàçëè÷àòü "áåçîáèäíóþ øóòêó", íàä êîòîðîé ïîñìåþòñÿ âñå âî ãëàâå ñ îáúåêòîì øóòêè è øóòêó êîòîðàÿ ìîæåò çàòðîíóòü íàöèîíàëüíûå, ðåëèãèîçíûå, îñòðîñîöèàëüíûå âîïðîñû, à òàêæå ïðè÷èíèòü ìîðàëüíûé âðåä íåîêðåïøèì óìàì íåêîòîðûõ þíûõ èãðîêîâ. 
 Íå ñòîèò áðàâèðîâàòü ñâîèì îñòðîóìèåì ïåðåä âñåìè, åñëè èç âàñ "òàê è ïðåò îñòðîòà" - ïîäåëèòåñü ýòèì ñ êåì-òî íàåäèíå, à åñëè ó âàñ åñòü ïðåòåíçèè ðåøàéòå èõ â /sms ÷àò. 
 Ìàò ñ÷èòàåòñÿ íåïðèåìëåìûì. 
 Ñëåäóåò ñ óâàæåíèåì îòíîñèòüñÿ ê ÷åëîâåêó ñòàðøå âàñ ïî äîëæíîñòè, åñëè âàì êàæåòñÿ ÷òî îí â ÷åì-òî íå ïðàâ, òî ïèøèòå ëèäåðó â ËÑ. 
 Íå äîïóñêàåòñÿ âûäà÷à èíôîðìàöèè ñòàðøèì ñîòðóäíèêîì ïîëó÷èâøèì å¸ îò ìëàäøåãî, êîòîðàÿ ìîæåò èçìåíèòü îòíîøåíèå îêðóæàþùèõ ê íåìó ( äîïóñòèì åñëè èãðîê ñîãëàñíî ïóíêòó âûøå, ïîæàëîâàëñÿ ëèäåðó â ËÑ, ëèäåð íå èìååò ïðàâî ðàñêðûâàòü ýòî íèêîìó, êðîìå àäìèíèñòðàöèè).


Èçîáðàæåíèå · Ïðèìå÷àíèÿ: ïèñàë(à):

Çà íàðóøåíèå ýòèõ ïðàâèë â IC âû áóäåòå óâîëåíû ñ ïðè÷èíîé "íàðóøåíèå ïðîô. ýòèêè". 
Çà íàðóøåíèå ýòèõ ïðàâèë â ÎÎÑ âû áóäåòå óâîëåíû ñ ïðè÷èíîé "àìîðàëüíîå ïîâåäåíèå", ñîãëàñíî ÐÏ ëåãåíäå äëÿ âñåõ âû ñîâåðøèëè íåêèé àìîðàëüíûé ïîñòóïîê.
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{139BEC}Inst Tools {ffffff}| {ae433d}Ñîòðóäíèêè âíå îôèñà {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{139BEC}Inst Tools {ffffff} | Ëîã ñîîáùåíèé äåïàðòàìåíòà', table.concat(departament, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
if rank == 'Ýêçàìåíàòîð' or rank == 'Ìë.Èíñòðóêòîð' or rank == "Èíñòðóêòîð" or rank == 'Êîîðäèíàòîð' or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or  rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
  if id == nil then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Ââåäèòå: /vig ID Ïðè÷èíà", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Ââåäèòå: /vig ID ÏÐÈ×ÈÍÀ", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else 
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- çàïðîñ ìåñòîïîëîæåíèÿ
   if rank == 'Ýêçàìåíàòîð' or rank == 'Ìë.Èíñòðóêòîð' or rank == "Èíñòðóêòîð" or rank == 'Êîîðäèíàòîð' or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or  rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", name))
			end
			else
			ftext('{FFFFFF} Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Èñïîëüçóéòå: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Äàííàÿ êîìàíäà äîñòóïíà ñ 4 ðàíãà.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Ñòàæ¸ðà',
		['2'] = 'Êîíñóëüòàíòà',
		['3'] = 'Ýêçàìåíàòîðà',
		['4'] = 'Ìë.Èíñòðóêòîðà',
		['5'] = 'Èíñòðóêòîðà',
		['6'] = 'Êîîðäèíàòîðà',
		['7'] = 'Ìë.Ìåíåäæåðà',
		['8'] = 'Ñò.Ìåíåäæåðà',
		['9'] = 'Äèðåêòîðà'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)	
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(1500)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(1500)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(1500)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(1500)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(1500)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(1500)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(1500)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(1500)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(1500)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', cfg.main.tarr, plus == '+' and 'Ïîâûøåí(à)' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', ïîçäðàâëÿþ' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', plus == '+' and 'Ïîâûøåí(à)' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', ïîçäðàâëÿþ' or ''))
            end
			else 
			ftext('Âû ââåëè íåâåðíûé òèï [+/-]')
		end
		else 
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else 
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà')
	  end
	  else 
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
	  end
   end)
 end

function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1500)
				sampSendChat(string.format('/invite %s', id))
			else 
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else 
			ftext('Ââåäèòå: /invite [id]')
		end
		else 
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 9 ðàíãà')
	  end
   end)
 end
 
 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)	
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{139BEC}IT {ffffff}| Âûáîð îòäåëà")
				else 
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
            end
		else 
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ')
		end
		else 
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	  end
	  else 
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	end
	  else 
			ftext('Ââåäèòå: /oinv [id]')
	end
	  end)
   end
 
 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me çàáðàë(à) ôîðìó è áåéäæèê ó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else 
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else 
			ftext('Ââåäèòå: /uninvite [id] [ïðè÷èíà]')
		end
		else 
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 8 ðàíãà')
	  end
   end)
 end
 
function oinvite(id)
 return
{
  {
   title = "{FFFFFF}Îòäåë {139BEC}Ñòàæèðîâêè",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà ÎÑ è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 6')
	wait(1500)
	sampSendChat('/b òåã â /r [Ñîòðóäíèê ÎÑ]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñîòðóäíèê ÎÑ.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}Îòäåë {139BEC}Êîíòðîëÿ",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà ÎÊ è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 21')
	wait(1500)
	sampSendChat('/b òåã â /r [Ñîòðóäíèê ÎÊ]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñîòðóäíèê ÎÊ.', cfg.main.tarr))
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}Ìåíþ {139BEC}ëåêöèé",
    onclick = function()
	submenus_show(fthmenu(id), "{139BEC}IT {ffffff}| Ìåíþ ëåêöèé")
	end
   },
    {
   title = "{FFFFFF}Ìåíþ {139BEC}ãîñ.íîâîñòåé {ff0000}(Äëÿ Ñò.Ñîñòàâà)",
    onclick = function()
	if rank == 'Èíñòðóêòîð' or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
	submenus_show(govmenu(id), "{139BEC}IT {ffffff}| Ìåíþ ãîñ.íîâîñòåé")
	else
	ftext('Âû íå íàõîäèòåñü â Ñò.Ñîñòàâå')
	end
	end
   },
   {
   title = "{FFFFFF}Ìåíþ {139BEC}îòäåëîâ",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{139BEC}IT {ffffff}| Ìåíþ îòäåëîâ")
	else
	ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ')
	end
	end
   },
   {
   title = "{FFFFFF}Äîñòàâêà ëèöåíçèé {139BEC}â ëþáóþ òî÷êó øòàòà â /d{ff0000}(Äëÿ 4+ ðàíãà)",
    onclick = function()
	if rank == 'Ìë.Èíñòðóêòîð' or rank == 'Èíñòðóêòîð' or rank == 'Êîîðäèíàòîð' or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
	sampSendChat(string.format('/d OG, Îñóùåñòâëÿåòñÿ äîñòàâêà ëèöåíçèé â ëþáóþ òî÷êó øòàòà. Òåë: %s.', tel))
	else
	ftext('Âàø ðàíã íåäîñòàòî÷íî âûñîê')
	end
	end
   },
   {
   title = "{FFFFFF}Ñïèñîê {139BEC}ñîòðóäíèêîâ íàõîäÿùèõñÿ íå â îôèñå",
    onclick = function()
	pX, pY, pZ = getCharCoordinates(playerPed)
	if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
	dmch()
	else
	ftext('Âû äîëæíû íàõîäèòüñÿ â îôèñå')
	end
	end
   },
   {
   title = "{FFFFFF}Äîëîæèòü â ðàöèþ î äîñòàâêå ëèöåíçèè {ff0000}(îáÿçàòåëüíî ïðè äîñòàâêå)",
    onclick = function()
    if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: Âûåõàë íà äîñòàâêó ëèöåíçèè.', cfg.main.tarr))
        else
        sampSendChat(string.format('/r Âûåõàë íà äîñòàâêó ëèöåíçèè.'))
        end
		dostavka = true
	end
   }
}
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}Ïèàð îòäåëà â ðàöèþ (ÎÑ) {ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â Îòäåë Ñòàæèðîâêè ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ýêçàìåíàòîð".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}Ïèàð îòäåëà â ðàöèþ (OK) {ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â Îòäåë Êîíòðîëÿ ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ýêçàìåíàòîð".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}Óñòàâ (OK) {ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Çà íàðóøåíèÿ ïóíêòîâ óñòàâà, Âû áóäåòå ïîëó÷àòü âûãîâîð.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ×òîáû èçáåæàòü ýòîãî, íå íàðóøàéòå è ê Âàì íå áóäåò ïðèòåíçèé.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Ñïàñèáî çà ïîíèìàíèå.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}Òåõ.îñìîòð àâòî ãîñ.îðãàíèçàöèé",
    onclick = function()
	if cfg.main.male == true then
	sampSendChat("/me çàïèñàë äàííûå î ïðîâåðÿåìîé ãîñ.îðãàíèçàöèè")
    wait(3500)
    sampSendChat("/me íà÷àë îñìàòðèâàòü âíåøíåå ñîñòîÿíèå àâòîìîáèëÿ")
    wait(3500)
    sampSendChat("/me îòêðûë êàïîò")
    wait(3500)
    sampSendChat("/do Êàïîò îòêðûò.")
	wait(3500)
	sampSendChat("/me äîñòàë ñ ÷åìîäàíà äëÿ èíñòðóìåíòîâ ôîíàðèê è íà÷àë îñìàòðèâàòü äâèãàòåëü")
	wait(3500)
	sampSendChat("/try äâèãàòåëü â íîðìå")
	wait(3500)
	sampSendChat("/me íà÷àë ïðîâåðÿòü äàâëåíèå â øèíàõ.")
	wait(3500)
	sampSendChat("/try äàâëåíèå â íîðìå")
	wait(3500)
	sampSendChat("/me ïðîâåðÿåò àâòîìîáèëü íà íàëè÷èå ïîâðåæäåíèé")
	wait(3500)
	sampSendChat("/try ïîâðåæäåíèÿ íå îáíàðóæåíû")
	wait(3500)
	sampSendChat("/me äîñòàë áëîêíîò ñ ðó÷êîé, ïîñëå ÷åãî çàïèñàë âñå ðåçóëüòàòû ïðîâåðêè")
	wait(3500)
	sampSendChat("/me ïîñòàâèë ïîäïèñü è çàêðûë áëîêíîò")
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
	end
	if cfg.main.male == false then
	sampSendChat("/me çàïèñàëà äàííûå î ïðîâåðÿåìîé ãîñ.îðãàíèçàöèè")
    wait(3500)
    sampSendChat("/me íà÷àëà îñìàòðèâàòü âíåøíåå ñîñòîÿíèå àâòîìîáèëÿ")
    wait(3500)
    sampSendChat("/me îòêðûëà êàïîò")
    wait(3500)
    sampSendChat("/do Êàïîò îòêðûò.")
	wait(3500)
	sampSendChat("/me äîñòàëà ñ ÷åìîäàíà äëÿ èíñòðóìåíòîâ ôîíàðèê è íà÷àëà îñìàòðèâàòü äâèãàòåëü")
	wait(3500)
	sampSendChat("/try äâèãàòåëü â íîðìå")
	wait(3500)
	sampSendChat("/me íà÷àëà ïðîâåðÿòü äàâëåíèå â øèíàõ.")
	wait(3500)
	sampSendChat("/try äàâëåíèå â íîðìå")
	wait(3500)
	sampSendChat("/me ïðîâåðÿåò àâòîìîáèëü íà íàëè÷èå ïîâðåæäåíèé")
	wait(3500)
	sampSendChat("/try ïîâðåæäåíèÿ íå îáíàðóæåíû")
	wait(3500)
	sampSendChat("/me äîñòàëà áëîêíîò ñ ðó÷êîé, ïîñëå ÷åãî çàïèñàëà âñå ðåçóëüòàòû ïðîâåðêè")
	wait(3500)
	sampSendChat("/me ïîñòàâèëà ïîäïèñü è çàêðûëà áëîêíîò")
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
	end
	end
   }
}
end

function govmenu(id)
 return
{
  {
   title = "{FFFFFF}Ñîáåñåäîâàíèå",
    onclick = function()
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
    wait(5000)
    sampSendChat("/gov [Instructors]: Óâàæàåìûå æèòåëè øòàòà, ïîæàëyéñòà, ïðîñëyøàéòå îáúÿâëåíèå.")
    wait(5000)
    sampSendChat('/gov [Instructors]: Â äàííûé ìîìåíò â îôèñå Àâòîøêîëû ïðîõîäèò ñîáåñåäîâàíèå íà äîëæíîñòü "Ñòàæåð".')
    wait(5000)
    sampSendChat("/gov [Instructors]: Òðåáîâàíèÿ ê ñîèñêàòåëÿì: Øåñòü ëåò ïðîæèâàíèÿ â øòàòå, ñòðåññîóñòîé÷èâîñòü, îïðÿòíûé âèä.")
    wait(5000)
    sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },
  {
   title = "{FFFFFF}Çàðàáîòîê Ìàëîèìóùèì",
    onclick = function()
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(5000)
        sampSendChat("/gov [Instructors] Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ïîæàëóéñòà, ìèíóòî÷êó âíèìàíèÿ. ")
        wait(5000)
        sampSendChat('/gov [Instructors]: Â äàííûé ìîìåíò íà îô.ïîðòàëå Àâòîøêîëû îòêðûòà òåìà "Çàðàáîòîê Ìàëîèìóùèì".')
        wait(5000)
        sampSendChat("/gov [Instructors]: Cî âñåìè ïîäðîáíîñòÿìè âû ìîæåòå îçíàêîìèòüñÿ íà îô.ïîðòàëå. ")
        wait(5000)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },
  {
   title = "{FFFFFF}Ñòàæèðîâêà",
    onclick = function()
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(5000)
        sampSendChat("/gov [Instructors] Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ïîæàëóéñòà, ìèíóòî÷êó âíèìàíèÿ. ")
        wait(5000)
        sampSendChat('/gov [Instructors]: Ïðè ïðîõîæäåíèè ñòàæèðîâêè â àâòîøêîëå, âû ìîæåòå ïîëó÷èòü 100.000.')
        wait(5000)
        sampSendChat("/gov [Instructors]: Cî âñåìè ïîäðîáíîñòÿìè âû ìîæåòå îçíàêîìèòüñÿ íà îô.ïîðòàëå.")
        wait(5000)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },   
  {
   title = "{FFFFFF}Âèï êàðòà êëèåíòà",
    onclick = function()
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
    wait(5000)
    sampSendChat("/gov [Instructors] Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ïîæàëóéñòà, ìèíóòî÷êó âíèìàíèÿ. ")
    wait(5000)
    sampSendChat('/gov [Instructors]: Â äàííûé ìîìåíò íà îô.ïîðòàëå Àâòîøêîëû îòêðûòà òåìà "Âèï êàðòà êëèåíòà"')
    wait(5000)
    sampSendChat("/gov [Instructors]: Cî âñåìè ïîäðîáíîñòÿìè âû ìîæåòå îçíàêîìèòüñÿ íà îô.ïîðòàëå. ")
    wait(5000)
    sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },   
    {
   title = "{FFFFFF}Çàÿâêà íà ýêçàìåíàòîðà",
    onclick = function()
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(5000)
        sampSendChat("/gov [Instructors]: Óâàæàåìûå æèòåëè øòàòà, ïîæàëyéñòà, ïðîñëyøàéòå îáúÿâëåíèå.")
        wait(5000)
        sampSendChat('/gov [Instructors]: Â äàííûé ìîìåíò îòêðûòû çàÿâëåíèÿ íà äîëæíîñòü "Ýêçàìåíàòîð".')
        wait(5000)
        sampSendChat("/gov [Instructors]: Ñî âñåìè êðèòåðèÿìè, Âû ìîæåòå îçíàêîìèòüñÿ íà îô.ïîðòàëå øòàòà. ")
        wait(5000)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },
   {
   title = "{FFFFFF}Ïèàð ôèëèàëà ìýðèè",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(5000)
        sampSendChat("/gov [Instructors]: Óâàæàåìûå æèòåëè øòàòà, ïîæàëyéñòà, ïðîñëyøàéòå îáúÿâëåíèå.")
        wait(5000)
        sampSendChat('/gov [Instructors]: Àâòîøêîëà ðàñøèðÿåòñÿ è ïðåäîñòàâëÿåò óñëóãè ïî âûäà÷å ëèöåíçèé â íàøåì ôèëèàëå.')
        wait(5000)
        sampSendChat('/gov [Instructors]: Ôèëèàë íàõîäèòñÿ íà ïåðâîì ýòàæå Ìýðèè. Ñ óâàæåíèåì, '..rank..' Àâòîøêîëû - '..myname:gsub('_', ' ')..'.')
        wait(5000)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
	end
   },
   {
   title = "{FFFFFF}Çàíÿòü ãîñ. âîëíó",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Çàíèìàþ ãîñ.âîëíó íà X. Âîçðàæåíèÿ íà ï.")
	end
   },
   {
   title = "{FFFFFF}Íàïîìíèòü î çàéìå ãîñ. âîëíû",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Íàïîìèíàþ ÷òî âîëíà ãîñ.íîâîñòåé íà X çà Inst.")
	end
   },
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Âû ðàíåå íå ïîëó÷àëè âõîäÿùèõ ñîîáùåíèé.", 0x046D63)
	end
end

function fthmenu(id)
 return
{
  {
    title = "{FFFFFF}Ëåêöèÿ äëÿ {139BEC}Ñòàæ¸ðà",
    onclick = function()
	    sampSendChat("Ïðèâåòñòâóþ. Âû ïðèíÿòû íà Ñòàæèðîâêó â Àâòîøêîëó. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me ïåðåäàë(à) áåéäæèê Ñòàæåðà Àâòîøêîëû ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 23 ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñòàæèðîâêà äëèòñÿ äî òîãî ìîìåíòà, ïîêà âû íå áóäåòå ïîâûøåíû äî Êîíñóëüòàíòà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çàïðåùåíî ïðîñèòü ïîâûøåíèÿ èëè íàçíà÷åíèÿ íà óïðàâëÿþùóþ äîëæíîñòü â ëþáîé ôîðìå. Êàê ïðèäåò ñðîê Âàñ âûçîâóò. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îáÿçàííîñòè ñòàæ¸ðîâ: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñìîòðåòü êàê ðàáîòàþò êîëëåãè è ó÷èòüñÿ ó íèõ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â ðàáî÷åå âðåìÿ íàõîäèòüñÿ â îôèñå. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Èçó÷àòü óñòàâ è ïðàâèëà àâòîøêîëû. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Äëÿ ïîâûøåíèÿ â äîëæíîñòè, Âàì íóæíî áóäåò ñäàòü ýêçàìåí.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âñåãî ó âàñ áóäåò îäèí ýêçàìåí - äëÿ ïîâûøåíèÿ äî êîíñóëüòàíòà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ýêçàìåí ñîñòîèò èç äâóõ ÷àñòåé: Óñòàâ è ðàñöåíêè íà ëèöåíçèè. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ýêçàìåí ñîñòîèòñÿ íå ðàíüøå ÷åì ÷åðåç 3 ÷àñà ïîñëå ïðèíÿòèÿ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b Óñòàâ è ðàñöåíêè íà ëèöåíçèè ìîæíî íàéòè íà ôîðóìå. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Äàáû îòáðîñèòü ÷àñòûå âîïðîñû:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñòàæåð ìîæåò âûäàâàòü òîëüêî ïðàâà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñòàæåðàìè ñ÷èòàþòñÿ ñîòðóäíèêè, íàõîäÿùèåñÿ íà äîëæíîñòè Ñòàæ¸ð è Ýêçàìåíàòîð (ïî çàÿâêå). ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îôèñ ðàçðåøåíî ïîêèäàòü òîëüêî ñ ðàçðåøåíèÿ ñò. Ñîñòàâà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âåðòîëåò ìîæíî áðàòü òîæå òîëüêî ñ ðàçðåøåíèÿ ñò. Ñîñòàâà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çà ñòîëàìè ñïàòü çàïðåùåíî. Ñïàòü ðàçðåøåíî òîëüêî â êîìíàòå îòäûõà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b Â òåìå "Ïîìîùü äëÿ íîâè÷êîâ" åñòü âñå íóæíûå áèíäû, áåç íèõ íå ðàáîòàòü! ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè âîçíèêíóò âîïðîñû îáðàùàéòåñü ê Ñîòðóäíèêàì ÎÑ ëèáî ê ñò. Ñîñòàâó. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñïàñèáî,÷òî ïðîñëóøàëè ìîþ ëåêöèþ. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè ó âàñ èìåþòñÿ âîïðîñû, çàäàâàéòå. ")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = "{FFFFFF}Ëåêöèÿ äëÿ {139BEC}Ýêçàìåíàòîðà",
    onclick = function()
	sampSendChat("Ïðèâåòñòâóþ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîñêîëüêó âû ïðèíÿòû ïî çàÿâêå íà äîëæíîñòü Ýêçàìåíàòîðà, âàì íåîáõîäèìî îïðåäåëèòüñÿ ñ îòäåëîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 10")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ÎÑ - Îòäåë Ñòàæèðîâêè, çàíèìàþùèéñÿ íåïîñðåäñòâåííî îáó÷åíèåì ñòàæ¸ðîâ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ÎÊ - Îòäåë Êîíòðîëÿ, çàíèìàþùèéñÿ ïðîôèëàêòèêîé íàðóøåíèé è àâàðèéíûõ ñèòóàöèé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñ ó÷àñòèåì òðàíñïîðòà, ÷åðåç ïðîâåäåíèå ëåêöèé è ïðîâåðîê ãîñ. ñòðóêòóð")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîñëå 4-õ äíåé àêòèâíîé ðàáîòû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âû ïîëó÷èòå áåéäæèê Ìë.Èíñòðóêòîðà è áóäåòå ñ÷èòàòüñÿ ïîëíîöåííûì ñîòðóäíèêîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çàïðåùåíî ïðîñèòü ïîâûøåíèÿ èëè íàçíà÷åíèÿ íà óïðàâëÿþùóþ äîëæíîñòü â ëþáîé ôîðìå.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Êàê ïðèäåò ñðîê Âàøåãî ïîâûøåíèÿ - îáðàòèòåñü ê ñò. Ñîñòàâó")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îôèñ ðàçðåøåíî ïîêèäàòü òîëüêî ñ ðàçðåøåíèÿ ñò. Ñîñòàâà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âåðòîëåò ìîæíî áðàòü òîæå òîëüêî ñ ðàçðåøåíèÿ ñò. Ñîñòàâà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çà ñòîëàìè ñïàòü çàïðåùåíî. Ñïàòü ðàçðåøåíî òîëüêî â êîìíàòå îòäûõà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñòàæåðàìè ñ÷èòàþòñÿ ñîòðóäíèêè, íàõîäÿùèåñÿ íà äîëæíîñòè Ñòàæ¸ð è Ýêçàìåíàòîð (ïî çàÿâêå).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b Â òåìå "Ïîìîùü äëÿ íîâè÷êîâ" åñòü âñå íóæíûå áèíäû, áåç íèõ íå ðàáîòàòü!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè âîçíèêíóò âîïðîñû îáðàùàéòåñü ê Ñîòðóäíèêàì ÎÑ ëèáî ê ñò. Ñîñòàâó.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñïàñèáî, ÷òî ïðîñëóøàëè ìîþ ëåêöèþ.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè ó âàñ èìåþòñÿ âîïðîñû, çàäàâàéòå. ")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
   {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}ÏÄÄ",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "ÏÄÄ". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Êàæäûé âîäèòåëü äîëæåí áûòü ïðèñòåãíóò ðåìíåì áåçîïàñíîñòè... ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... è òîëüêî ïîñëå ýòîãî íà÷èíàòü äâèæåíèå. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âîäèòåëü îáÿçàí ïðîïóñêàòü ïåøåõîäîâ â ñïåöèàëüíûõ ìåñòàõ äëÿ ïåðåõîäà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â ñëó÷àå, åñëè êîí÷àåòñÿ áåíçèí èëè ïîëîìêà äâèãàòåëÿ íåîáõîäèìî ñäâèíóòü àâòîìîáèëü...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...èëè äîåõàòü äî îáî÷èíû è äîæäàòüñÿ ìåõàíèêà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â Øòàòå óñòàíîâëåí ñêîðîñòíîé ðåæèì: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â ïðåäåëàõ ãîðîäà ðàçðåøàåòñÿ äâèæåíèå òðàíñïîðòíûõ ñðåäñòâ ñî ñêîðîñòüþ íå áîëåå 50 êì/÷.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â æèëûõ çîíàõ è íà äâîðîâûõ òåððèòîðèÿõ ñêîðîñòü äâèæåíèÿ íå áîëåå 30 êì/÷.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çà ïðåäåëàìè ãîðîäîâ è íà àâòîìàãèñòðàëÿõ îãðàíè÷åíèé ïî ñêîðîñòè íåò. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè ïðîèçîøëî ÄÒÏ, âîäèòåëü îáÿçàí âûçâàòü ïîëèöèþ è æäàòü ïðèåçäà ñîòðóäíèêîâ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îáãîí ÒÑ ðàçðåøåí òîëüêî ñ ëåâîé ñòîðîíû, ïðè ýòîì âîäèòåëü îáÿçàí óáåäèòüñÿ...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... ÷òî âñòðå÷íàÿ ïîëîñà ñâîáîäíà äëÿ îáãîíà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Çàïðåùåíà ïàðêîâêà â íåïîëîæåííûõ ìåñòàõ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ðàçðåøåíî ïàðêîâàòüñÿ: Îáî÷èíà äîðîãè, ñïåöèàëüíî äëÿ ýòîãî îòâåäåííûå ìåñòà (ñòîÿíêè). ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âîäèòåëþ çàïðåùàåòñÿ: ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåñåêàòü ñïëîøíóþ ïîëîñó. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðåâûøàòü äîïóñòèìóþ ñêîðîñòü íà îïðåäåëåííîì ó÷àñòêå äîðîãè. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîêèäàòü ìåñòî ÄÒÏ áåç äîãîâîðåííîñòè ñ äðóãèì ó÷àñòíèêîì ýòîãî ÄÒÏ. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñîçäàâàòü ïîìåõè äðóãèì òðàíñïîðòíûì ñðåäñòâàì. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñàäèòñÿ çà ðóëü â íåòðåçâîì ñîñòîÿíèè. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íà ýòîì ëåêöèÿ îêîí÷åíà. Ñïàñèáî çà âíèìàíèå.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
      {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}ÏÐÀÂÈËÀ ÝÒÈÊÅÒÀ",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Çäðàâñòâóéòå, óâàæàåìûå êîëëåãè. Ñåé÷àñ ÿ Âàì ïðî÷òó ëåêöèþ íà òåìó: «Ïðàâèëà ýòèêåòà â íàøåé îðãàíèçàöèè». ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðâûì äåëîì, ïîñëå òîãî êàê Âû ïðèáûëè íà ðàáî÷åå ìåñòî ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat(" Âàì íåîáõîäèìî ïåðåîäåòüñÿ è ïî ïðèâåòñòâîâàòü ñâîèõ êîëëåã.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íå çàâèñèìî îò ñèòóàöèè, Âû äîëæíû ñîõðàíÿòü ñïîêîéñòâèå è")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("óâàæåíèå ê ÷åëîâåêó, ñ êåì âåä¸òå äèàëîã. Íà ëè÷íîñòü ïåðåõîäèòü")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("êàòåãîðè÷åñêè çàïðåùåíî. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Êî âñåì ñîòðóäíèêàì è ãðàæäàíàì, â ñòðîãîì ïîðÿäêå íåîáõîäèìî")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("îáðàùàòüñÿ íà «Âû» è íå â êîåì ñëó÷àå íà «Òû».")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âåæëèâî è ãðàìîòíî ïðåäëàãàòü óñëóãè èíñòðóêòîðà, âîøåäøèì â")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("çäàíèå, íî íå êðè÷àòü çà ñòîéêîé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîëüçîâàòüñÿ ðàöèåé íåîáõîäèìî, òîëüêî â ðàáî÷èõ öåëÿõ ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ðàçãîâîðû íå ïî ðàáîòå áóäóò ñòðîãî íàêàçûâàòüñÿ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íó è êîíå÷íî æå ïî óõîäó ñ ðàáî÷åãî ìåñòà, íåîáõîäèìî âåæëèâî ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ïîïðîùàòüñÿ ñ êîëëåãàìè. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íà ýòîì ëåêöèÿ ïîäîøëà ê ñâîåìó ëîãè÷åñêîìó çàâåðøåíèþ ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñïàñèáî çà âíèìàíèå. ")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	},
   {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}Ïðàâèëüíîå îáðàùåíèå ñ îðóæèåì",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Îáðàùåíèå ñ îðóæèåì".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ãðàæäàíàì çàïðåùåíî íîñèòü îðóæèå íå èìåÿ íà íåãî ëèöåíçèþ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Äëÿ ñîòðóäíèêîâ ñèëîâûõ ñòðóêòóð äåëàåòñÿ èñêëþ÷åíèå. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îðóæèå ðàçðåøåíî èñïîëüçîâàòü â ñëó÷àå:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.Ñàìîîáîðîíû, ïðè íàïàäåíèè íà âàñ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Äëÿ âûïîëíåíèÿ ñâîèõ ñëóæåáíûõ îáÿçàííîñòåé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.Ïî ïðÿìîìó ïðèêàçó ëþäåé, èìåþùèõ íà ýòî ïîëíîìî÷èÿ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òåì íå ìåíåå, ñóùåñòâóåò ðÿä çàïðåòîâ ñâÿçàííûõ ñ îðóæèåì: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.Çàïðåùåíî íîñèòü îðóæèå â îòêðûòîì âèäå â ìíîãîëþäíûõ ìåñòàõ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Çàïðåùåíî ïðèîáðåòàòü îðóæèå íåçàêîííî. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.Çàïðåùåíî ðàññòðåëèâàòü æèòåëåé áåç âåñîìîé ïðè÷èíû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("4.Çàïðåùåíî èñïîëüçâàòü îðóæèå äëÿ äîñòèæåíèÿ ëè÷íûõ öåëåé. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Â ñëó÷àå íàðóøåíèÿ ýòèõ ïðàâèë, ó âàñ áóäåò èçúÿòà ëèöåíçèÿ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òàê æå çà ïîäîáíûå íàðóøåíèÿ âàñ ìîãóò çàêëþ÷èòü ïîä ñòðàæó. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íà ýòîì âñå, ñïàñèáî çà âíèìàíèå.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
      {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}Ïðàâèëà óïðàâëåíèÿ âîäíûì òðàíñïîðòîì",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Ïðàâèëà óïðàâëåíèÿ âîäíûì òðàíñïîðòîì".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Ïðåæäå, ÷åì îòïðàâèòñÿ â ïëàâàíèå âû äîëæíû:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Óáåäèòüñÿ â èñïðàâíîñòè ìîòîðà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðîâåðèòü, íåò ëè âîäîòå÷íîñòè â êîðïóñå ñóäíà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðîâåðèòü, íå çàáûëè ëè âû âçÿòü ñ ñîáîé ëèöåíçèþ íà ïðàâî óïðàâëåíèÿ âîäíûì òðàíñïîðòîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîçàáîòèòüñÿ î ñïàñàòåëüíûõ ñðåäñòâàõ äëÿ êàæäîãî ÷åëîâåêà â ëîäêå (êàòåðå).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. Çàïðåùàåòñÿ:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåäàâàòü óïðàâëåíèå âîäíûì òðàíñïîðòîì äðóãîìó ëèöó áåç ñîîòâåòñòâóþùèõ íà òî äîêóìåíòîâ, îñîáåííî äåòÿì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âûõîäèòü â ïëàâàíèå â óñëîâèÿ îãðàíè÷åííîé âèäèìîñòè, åñëè âàøà ëîäêà íå îáîðóäîâàíà ñèãíàëüíûìè îãíÿìè.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåâîçèòü ëþäåé â íåòðåçâîì ñîñòîÿíèè.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñîçäàâàòü ïîìåõè äëÿ ïëàâàíèÿ ñóäîâ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåìåùåíèå ñ îäíîãî ñóäíà íà äðóãîå âî âðåìÿ èõ äâèæåíèÿ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåâîçèòü âçðûâîîïàñíûå è îãíåîïàñíûå ãðóçû íà ñóäàõ, äëÿ ýòîãî íå ïðåäíàçíà÷åííûõ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðèíèìàòü ïåðåä âûõîäîì íàðêîòè÷åñêèå âåùåñòâà, ñïèðòíûå íàïèòêè, òîíèçèðóþùèå ëåêàðñòâà è ïðåïàðàòû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îñëàáëÿòü áäèòåëüíîñòü è âíèìàíèå â ïðîöåññå óïðàâëåíèÿ âîäíûì òðàíñïîðòîì.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íà ýòîì âñå, ñïàñèáî çà âíèìàíèå.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
         {
    title = '{FFFFFF}Ëåêöèÿ {139BEC}"Êàê âåñòè ñåáÿ â ýêñòðåìàëüíûõ ñèòóàöèÿõ"',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Êàê ñåáÿ âåñòè â ýêñòðåìàëüíûõ ñèòóàöèÿõ".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òîðìîçà ïðèäóìàëè òðóñû, à óìíûå åù¸ è «íàôàðøèðîâàëè» èõ ýëåêòðîíèêîé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òàê ãîâîðÿò ëþäè, êîòîðûå çà÷àñòóþ ïîãèáàþò.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òîðìîç ýòî ïîæàëóé îäíà èç ãëàâíûõ ÷àñòåé àâòîìîáèëÿ.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Ñàìûìè ðàñïðîñòðàí¸ííûìè ïðè÷èíàìè îòêàçà òîðìîçîâ ÿâëÿþòñÿ...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...ïîòåðÿ òîðìîçíîé æèäêîñòè èç-çà íåãåðìåòè÷íîñòè ñèñòåìû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Íî âíå çàâèñèìîñòè îò ïðè÷èí, ñëåäñòâèå îäíî - àâòîìîáèëü íå âîçìîæíî îñòàíîâèòü îáû÷íûì ñïîñîáîì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Ïîýòîìó íóæíî èñïîëüçîâàòü îäèí èç ñëåäóþùèõ âàðèàíòîâ: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Òîðìîæåíèå äâèãàòåëåì.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íóæíî ïðèìåíèòü òîðìîæåíèå äâèãàòåëåì, òî åñòü ïîñòåïåííî ïîíèæàòü ïåðåäà÷è îäíó çà äðóãîé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Âêëþ÷åíèå ïåðâîé ïåðåäà÷è èëè «ïàðêèíãà».")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Åñëè äðóãîãî âûõîäà íåò, òî ìîæíî çàìåäëèòü ìàøèíó ïåðåéäÿ íà ïåðâóþ ïåðåäà÷ó è çàãëóøèâ äâèãàòåëü.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3. Êîíòàêòíîå òîðìîæåíèå.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îñòàíîâêà ñ ïîìîùüþ ïðåïÿòñòâèé áûâàåò äâóõ âèäîâ: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðâûé, êîãäà íåò óãðîçû æèçíè, è åñòü âîçìîæíîñòü çàìåäëèòü äâèæåíèå.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ýòî ìîæíî ñäåëàòü, âûåõàâ íà îáî÷èíó èëè ïðèòèðàÿñü ê áîðäþðó.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Âòîðàÿ  ñàìàÿ êðèòè÷åñêàÿ ñèòóàöèÿ.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Êîãäà ïðîäîëæåíèå äâèæåíèÿ ìîæåò âûçâàòü íåîáðàòèìûå ïîñëåäñòâèÿ.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Íóæíî òîðìîçèòü â ïðåïÿòñòâèå.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Îïòèìàëüíî äëÿ ýòîãî ïîäîéäóò êóñòû èëè ñóãðîáû, õóæå  çàáîðû è îòáîéíèêè.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("È ñàìîå ïîñëåäíåå  äðóãèå àâòîìîáèëè, ôîíàðíûå ñòîëáû, îñòàíîâêè.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Ýòî áûëè ñàìûå îñíîâíûå ñïîñîáû îñòàíîâêè àâòîìîáèëÿ.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Ãëàâíîå íå ïàíèêîâàòü è âû ñìîæåòå ñïàñòè ñâîþ è âîçìîæíî ÷üþ-òî æèçíü.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Íà ýòîì âñ¸, ñïàñèáî çà âíèìàíèå, áåðåãèòå ñåáÿ è ñâîèõ áëèçêèõ.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
        {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}Ïðàâèëà ðûáíîé ëîâëè",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Ïðàâèëà ðûáíîé ëîâëè".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Ïðàâèëà ðûáíîé ëîâëè:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ëîâèòü ðûáó ðàçðåøàåòñÿ òîëüêî â ðàçðåøåííûõ ìåñòàõ. (ïðè÷àë íà ïëÿæå ã.Ëîñ-Ñàíòîñ è çà ãîëüô êëóáîì â ã.Ëàñ-Âåíòóðàñ)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ðûáíàÿ ëîâëÿ ðàçðåøåíà òîëüêî ðàçðåø¸ííûìè îðóäèÿìè óæåíèÿ. (îäíà óäî÷êà ñ îäíèì êðþ÷êîì ëèáî ñïèííèíã)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ðûáíàÿ ëîâëÿ ðàçðåøåíà èñêëþ÷èòåëüíî â ÷åðòå íàñåëåííîãî ïóíêòà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. Çàïðåùàåòñÿ:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ëîâèòü ðûáó ñ ëîäêè.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ëîâèòü ðûáó ñ ïðèìåíåíèåì âçðûâ÷àòûõ è îòðàâëÿþùèõ âåùåñòâ, ñ ïîìîùüþ ýëåêòðîòîêà, ñ èñïîëüçîâàíèåì êîëþùèõ îðóäèé.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ëîâèòü ðûáó áåç íàëè÷èÿ ëèöåíçèè ðûáîëîâà.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ëîâèòü ðûáó â ðàäèóñå 500 ìåòðîâ îò õîçÿéñòâ, ðàçâîäÿùèõ ðûáó.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
      {
    title = "{FFFFFF}Ëåêöèÿ ïðî {139BEC}Ïèëîòèðîâàíèå",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Âñåõ ïðèâåòñòâóþ. ß ñîòðóäíèê Àâòîøêîëû "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ïðîâåäó ëåêöèþ íà òåìó "Ïèëîòèðîâàíèå". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Ïðàâèëà ïèëîòèðîâàíèÿ: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðè ñîâåðøåíèè ïîëåòà íóæíî ÷åòêî âûïîëíÿòü âñå èíñòðóêöèè è íå îòêëîíÿòüñÿ îò âûáðàííîãî êóðñà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïåðåä íà÷àëîì ïîëåòà íàäî ïðîâåðèòü òåõíèêó íà êîòîðîé âû áóäåòå ñîâåðøàòü ïîëåò. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Òðåíèðîâî÷íûå ïîëåòû ñîâåðøàþòñÿ òîëüêî ïðè îïûòíûõ ïèëîòàõ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïðèíèìàòü ïåðåä âûëåòîì íàðêîòè÷åñêèå âåùåñòâà, ñïèðòíûå íàïèòêè, òîíèçèðóþùèå ëåêàðñòâà è ïðåïàðàòû.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Îñëàáëÿòü áäèòåëüíîñòü è âíèìàíèå â ïðîöåññå ïîëåòà. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîëåòû â çàïðåòíûõ è îïàñíûõ çîíàõ, èíôîðìàöèè î êîòîðûõ íåò íà ïîëåòíûõ êàðòàõ. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ïîëåò íàä íàñåëåííûìè ïóíêòàìè è ñêîïëåíèÿìè ëþäåé íà îòêðûòîé ìåñòíîñòè íà âûñîòå ìåíåå 300 ìåòðîâ.")
       wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ñáëèæåíèå ñàìîëåòîâ áëèæå óñòàíîâëåííûõ ïðàâèë ðàññòîÿíèé. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Íà ýòîì âñå, ñïàñèáî çà âíèìàíèå.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(u8'Íàñòðîéêè##1', first_window, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Èñïîëüçîâàòü àâòîòåã"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîòåã', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Ââåäèòå âàø Òåã.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	imgui.Text(u8("Èíôî-áàð ïðîäàæ ëèöåíçèé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Âêëþ÷èòü/Âûêëþ÷èòü èíôî-áàð', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Èíôî-áàð âêëþ÷åí, óñòàíîâèòü ïîëîæåíèå /sethud' or 'Èíôî-áàð âûêëþ÷åí')
    end
	end
	imgui.Text(u8("Áûñòðûé îòâåò íà ïîñëåäíåå ñìñ"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Áûñòðûé îòâåò ñìñ', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Êëàâèøà óñïåøíî èçìåíåíà. Ñòàðîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Íîâîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/instools/keys.json')
	end
	imgui.Text(u8("Èñïîëüçîâàòü àâòîêëèñò"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîêëèñò', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Âûáåðèòå çíà÷åíèå êëèñòà", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Ìóæñêèå îòûãðîâêè"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Ìóæñêèå îòûãðîâêè', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'Çàäåðæêà â ëåêöèÿõ (ñåê)', waitbuffer,  4, 10) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Àâòîñêðèí ëåêöèé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Àâòîñêðèí ëåêöèé', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Ñîõðàíèòü íàñòðîéêè'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Íàñòðîéêè óñïåøíî ñîõðàíåíû.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Óñòàâ ÀØ'), ystwindow)
                for line in io.lines('moonloader\\instools\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin('Inst Tools | Main Menu', second_window, imgui.WindowFlags.NoResize)
	local text = 'Ðàçðàáîò÷èê:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Roma_Mizantrop')
    imgui.Separator()
	if imgui.Button(u8'Áèíäåð', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Íàñòðîéêè ñêðèïòà', imgui.ImVec2(120, 30)) then
      first_window.v = not first_window.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Ïåðåçàãðóçèòü ñêðèïò', imgui.ImVec2(150, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(u8'Ïîìîùü', imgui.ImVec2(55, 30)) then
      helps.v = not helps.v
    end
	imgui.Separator()
	imgui.BeginChild("Èíôîðìàöèÿ", imgui.ImVec2(410, 100), true)
	imgui.Text(u8 'Èìÿ è Ôàìèëèÿ:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Äîëæíîñòü:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Íîìåð òåëåôîíà:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Òåã â ðàöèþ:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Íîìåð áåéäæèêà:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Òåêóùàÿ äàòà: %s")).x)/3.5)
	imgui.Text(u8(string.format("Òåêóùàÿ äàòà: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
                _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
                local myping = sampGetPlayerPing(myid)
                imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 180), imgui.Cond.FirstUseEver)
                imgui.Begin('Ïðîäàíî ëèöåíçèé', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
                imgui.CentrText(u8'Ïðîäàíî ëèöåíçèé çà ñåàíñ:')
                imgui.Separator()
				imgui.Text(u8 'Âîäèòåëüñêèå ïðàâà:') imgui.SameLine() imgui.Text(u8 ''..prava..'')
				imgui.Text(u8 'Ëèöåíçèé ïèëîòà:') imgui.SameLine() imgui.Text(u8 ''..pilot..'')
				imgui.Text(u8 'Ëèöåíçèé íà êàòåðà:') imgui.SameLine() imgui.Text(u8 ''..kater..'')
				imgui.Text(u8 'Ëèöåíçèé ðûáîëîâà:') imgui.SameLine() imgui.Text(u8 ''..ribolov..'')
				imgui.Text(u8 'Ëèöåíçèé íà îðóæèå:') imgui.SameLine() imgui.Text(u8 ''..gun..'')
				imgui.Text(u8 'Ëèöåíçèé íà áèçíåñ:') imgui.SameLine() imgui.Text(u8 ''..biznes..'')
                imgui.End()
    end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(u8 'Ïîìîùü ïî ñêðèïòó', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Ñïèñîê êîìàíä", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/tset - Îòêðûòü ìåíþ ñêðèïòà')
                imgui.Separator()
                imgui.BulletText(u8 '/vig [id] [Ïðè÷èíà] - Âûäàòü âûãîâîð ïî ðàöèè')
                imgui.BulletText(u8 '/dmb - Îòêðûòü /members â äèàëîãå')
                imgui.BulletText(u8 '/where [id] - Çàïðîñèòü ìåñòîïîëîæåíèå ïî ðàöèè')
                imgui.BulletText(u8 '/yst - Îòêðûòü óñòàâ ÀØ')
				imgui.BulletText(u8 '/smsjob - Âûçâàòü íà ðàáîòó âåñü ìë.ñîñòàâ ïî ñìñ')
                imgui.BulletText(u8 '/dlog - Îòêðûòü ëîã 25 ïîñëåäíèõ ñîîáùåíèé â äåïàðòàìåíò')
				imgui.BulletText(u8 '/sethud - Óñòàíîâèòü ïîçèöèþ èíôî-áàðà')
				imgui.Separator()
                imgui.BulletText(u8 'Êëàâèøè: ')
                imgui.BulletText(u8 'ÏÊÌ+Z íà èãðîêà - Ìåíþ âçàèìîäåéñòâèÿ')
                imgui.BulletText(u8 'F2 - "Áûñòðîå ìåíþ"')
				imgui.EndChild()
                imgui.End()
    end
    if updwindows.v then
                local updlist = ttt
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(700, 330), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Îáíîâëåíèå'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Âûøëî îáíîâëåíèå ñêðèïòà Inst Tools äî âåðñèè '..updversion..'. ×òî áû îáíîâèòüñÿ íàæìèòå êíîïêó âíèçó. Ñïèñîê èçìåíåíèé:'))
                imgui.Separator()
                imgui.BeginChild("uuupdate", imgui.ImVec2(690, 200))
                for line in ttt:gmatch('[^\r\n]+') do
                    imgui.Text(line)
                end
                imgui.EndChild()
                imgui.Separator()
                imgui.PushItemWidth(305)
                if imgui.Button(u8("Îáíîâèòü"), imgui.ImVec2(339, 25)) then
                    lua_thread.create(goupdate)
                    updwindows.v = false
                end
                imgui.SameLine()
                if imgui.Button(u8("Îòëîæèòü îáíîâëåíèå"), imgui.ImVec2(339, 25)) then
                    updwindows.v = false
                end
                imgui.End()
            end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | Áèíäåð##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("Ïóñòîå ñîîáùåíèå ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("Ââîä") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"Äîáàâèòü êëàâèøó") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "âîïðîñèê" äëÿ ñêðèïòà
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/instools/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '»', close_button or 'x', back_button or '«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' »' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('Ââåäèòå /r [òåêñò]')
    end
end
function f(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/f [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/f %s', pam))
        end
    else
        ftext('Ââåäèòå /f [òåêñò]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function tset()
  if frac == 'Driving School' then
  second_window.v = not second_window.v
  else
  ftext('Âîçìîæíî âû íå ñîñòîèòå â àâòîøêîëå {ff0000}[ctrl+R]')
  end
end	

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{ffffff}» Èíñòðóêòîð",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Öåíû ëèöåíçèé",
        onclick = function()
        pID = tonumber(args)
	    pX, pY, pZ = getCharCoordinates(playerPed)
	    if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or rank == 'Óïðàâëÿþùèé' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(pricemenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Âû äîëæíû íàõîäèòüñÿ çà ñòîéêîé')
		end
        end
      },
      {
        title = "{ffffff}» Âîïðîñû",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(questimenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Âû äîëæíû íàõîäèòüñÿ çà ñòîéêîé')
		end
        end
      },
      {
        title = "{ffffff}» Îôîðìëåíèå",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(oformenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Âû äîëæíû íàõîäèòüñÿ çà ñòîéêîé')
        end
		end
      },
	  {
        title = "{ffffff}» Óäàðèòü øîêåðîì",
        onclick = function()
		if cfg.main.male == true then
        sampSendChat("/me ñíÿë øîêåð ñ ïîÿñà")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me ïîâåñèë øîêåð íà ïîÿñ")
        end
	    if cfg.main.male == false then
        sampSendChat("/me ñíÿëà øîêåð ñ ïîÿñà")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me ïîâåñèëà øîêåð íà ïîÿñ")
        end
		end
      }
    }
end

function questimenu(args)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë âîïðîñîâ ïî ÏÄÄ »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïàðó âîïðîñîâ',
        onclick = function()
          sampSendChat("Ñåé÷àñ ÿ çàäàì âàì ïàðó âîïðîñîâ ïî ÏÄÄ. Ãîòîâû?")
		end
      },
      {
        title = '{ffffff}» Ãîðîä{ff0000} 50 êì/÷',
        onclick = function()
        sampSendChat("Êàêàÿ ìàêñèìàëüíàÿ ñêîðîñòü ðàçðåøåíà â ãîðîäå?")
        end
      },
      {
        title = '{ffffff}» Æèëàÿ ìåñòíîñòü{ff0000} 30 êì/÷',
        onclick = function()
        sampSendChat("Êàêàÿ ìàêñèìàëüíàÿ ñêîðîñòü ðàçðåøåíà â æèëîé ìåñòíîñòè?")
        end
      },
      {
        title = '{ffffff}» Îáãîí{ff0000} ñ ëåâîé ñòîðîíû.',
        onclick = function()
        sampSendChat("Ñ êàêîé ñòîðîíû ðàçðåøåí îáãîí?")
        end
      },
      {
        title = '{ffffff}» ÄÒÏ',
        onclick = function()
        sampSendChat("Âû ïîïàëè â ÄÒÏ. Âàøè äåéñòâèÿ?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Îêàçàòü ïåðâóþ ïîìîùü ïîñòðàäàâøèì. Âûçâàòü Ì×Ñ è ÏÄ è æäàòü èõ ïðèáûòèÿ.", -1)
        end
      },
	  {
        title = '{ffffff}» Äåéñòâèÿ ïðè îñòàíîâêå',
        onclick = function()
        sampSendChat("Çà âàìè åäåò àâòîìîáèëü ñ âêëþ÷¸ííîé ñèðåíîé. Âàøè äåéñòâèÿ?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñáàâèòü ñêîðîñòü è ïðèæàòüñÿ ê îáî÷èíå.", -1)
        end
      },
	  {
        title = '{5b83c2}« Ðàçäåë äðóãèõ âîïðîñîâ»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}Öåëü íîøåíèÿ îðóæèÿ',
        onclick = function()
        sampSendChat("Çà÷åì âàì ëèöåíçèÿ íà îðóæèå?")
        end
      },
	  {
        title = '{ffffff}Õðàíåíèå îðóæèÿ',
        onclick = function()
        sampSendChat("Ãäå âû áóäåòå õðàíèòü îðóæèå?")
        end
      }
    }
end

function oformenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë îôîðìëåíèÿ »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïðàâà.',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë(à) ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë(à) ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		  sampSendChat("/givelicense "..id)
		  wait(1700)
		  sampCloseCurrentDialogWithButton(1)
		  wait(1700)
		  sampSendChat("Óäà÷è íà äîðîãàõ.")
		  if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		  end
		end
      },
      {
        title = '{ffffff}» Ðûáàëêà',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë(à) ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë(à) ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(2)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}» Ïèëîò',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë(à) ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(1)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}» Îðóæèå{ff0000} ñî 2 óðîâíÿ.',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë(à) ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë(à) ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(4)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}» Êàòåð',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(3)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
      {
        title = '{ffffff}» Áèçíåñ',
        onclick = function()
          sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		  wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë(à) ÷èñòûé áëàíê è íà÷àë åãî çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ëèöåíçèÿ â ðóêå.")
		  wait(1700)
		  sampSendChat('/me ïîñòàâèë(à) ïå÷àòü "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèþ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
        sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(5)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      },
	  {
        title = '{ffffff}» Îôîðìëåíèå êîìïëåêòà',
        onclick = function()
        sampSendChat("/do Êåéñ ñ äîêóìåíòàìè â ðóêàõ èíñòðóêòîðà.")
		wait(1700)
		  sampSendChat("/me ïðèîòêðûë(à) êåéñ, ïîñëå ÷åãî äîñòàë(à) ñòîïêó ÷èñòûõ áëàíêîâ è íà÷àë èõ çàïîëíÿòü")
		  wait(1700)
		  sampSendChat("/me çàïèñàë(à) ïàñïîðòíûå äàííûå ïîêóïàòåëÿ")
		  wait(1700)
		  sampSendChat("/do Ñòîïêà ëèöåíçèé â ðóêå.")
		  wait(1700)
		sampSendChat('/me ïðîñòàâèë(à) ïå÷àòè "Autoschool San Fierro" è ïåðåäàë(à) ëèöåíçèè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		end
        end
      }
    }
end

function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end

function pricemenu(args)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë ñòîèìîñòè »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïðàâà.',
        onclick = function()
		if gmegaflvl <= 2 then
          sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 500$.")
		  wait(1500)
		  sampSendChat("Îôîðìëÿåì?")	  
		else if gmegaflvl <= 5 then
		  sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 5.000$.")
		  wait(1500)
		  sampSendChat("Îôîðìëÿåì?")	  
		else if gmegaflvl <= 15 then
		  sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 10.000$.")
		  wait(1500)
		  sampSendChat("Îôîðìëÿåì?")	  
		else if gmegaflvl >= 16 then
		  sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 30.000$.")
		  wait(1500)
		  sampSendChat("Îôîðìëÿåì?")	  
        end
		end
		end
		end
		end
      },
      {
        title = '{ffffff}» Ðûáàëêà',
        onclick = function()
        sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 2.000$.")
		wait(1500)
		sampSendChat("Îôîðìëÿåì?")
        end
      },
      {
        title = '{ffffff}» Ïèëîò',
        onclick = function()
        sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 10.000$.")
		wait(1500)
		sampSendChat("Îôîðìëÿåì?")
        end
      },
      {
        title = '{ffffff}» Îðóæèå{ff0000} ñî 2 óðîâíÿ.',
        onclick = function()
		if gmegaflvl > 1 then
        sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 50.000$.")
		wait(1500)
		sampSendChat("Îôîðìëÿåì?")
		else
		sampSendChat("Äàííóþ ëèöåíçèþ ìîæíî ïðèîáðåñòè ñ 2-õ ëåò â øòàòå.")
		end
        end
      },
	  {
        title = '{ffffff}» Áèçíåñ{ff0000} ïðè íàëè÷èè áèçíåñà.',
        onclick = function()
        sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 100.000$.")
		wait(1500)
		sampSendChat("Îôîðìëÿåì?")
        end
      },
      {
        title = '{ffffff}» Êàòåð',
        onclick = function()
        sampSendChat("Ñòîèìîñòü äàííîé ëèöåíçèè ñîñòàâëÿåò - 5.000$.")
		wait(1500)
		sampSendChat("Îôîðìëÿåì?")
        end
      },
      {
        title = '{ffffff}» Êîìïëåêò',
        onclick = function()
        sampSendChat("Ðûáîëîâñòâî - 2.000$, Êàòåð - 5.000$, Ëèöåíçèÿ ïèëîòà - 10.000$, Ëèöåíçèÿ íà îðóæèå - 50.000$.")
        end
      }
    }
end

function instmenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë èíñòðóêòîðà »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Çäðàâñòâóéòå. ß ñîòðóäíèê àâòîøêîëû "..myname:gsub('_', ' ')..", ÷åì ìîãó ïîìî÷ü?")
		wait(1500)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')  
		end
      },
      {
        title = '{ffffff}» Ïàñïîðò',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Âàø ïàñïîðò, ïîæàëóéñòà.")
		wait(1500)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{ffffff}» Ïîïðîùàòüñÿ ñ êëèåíòîì',
        onclick = function()
        sampSendChat("Ñïàñèáî çà ïîêóïêó, âñåãî Âàì äîáðîãî.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/instools/ystav.txt') then
        local file = io.open("moonloader/instools/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Ãðàæäàíñêèé',
        [1] = 'Ãðàæäàíñêèé',
        [2] = 'Ãðàæäàíñêèé',
        [3] = 'Ãðàæäàíñêèé',
        [4] = 'Ãðàæäàíñêèé',
        [5] = 'Ãðàæäàíñêèé',
        [6] = 'Ãðàæäàíñêèé',
        [7] = 'Ãðàæäàíñêèé',
        [8] = 'Ãðàæäàíñêèé',
        [9] = 'Ãðàæäàíñêèé',
        [10] = 'Ãðàæäàíñêèé',
        [11] = 'Ãðàæäàíñêèé',
        [12] = 'Ãðàæäàíñêèé',
        [13] = 'Ãðàæäàíñêèé',
        [14] = 'Ãðàæäàíñêèé',
        [15] = 'Ãðàæäàíñêèé',
        [16] = 'Ãðàæäàíñêèé',
        [17] = 'Ãðàæäàíñêèé',
        [18] = 'Ãðàæäàíñêèé',
        [19] = 'Ãðàæäàíñêèé',
        [20] = 'Ãðàæäàíñêèé',
        [21] = 'Ballas',
        [22] = 'Ãðàæäàíñêèé',
        [23] = 'Ãðàæäàíñêèé',
        [24] = 'Ãðàæäàíñêèé',
        [25] = 'Ãðàæäàíñêèé',
        [26] = 'Ãðàæäàíñêèé',
        [27] = 'Ãðàæäàíñêèé',
        [28] = 'Ãðàæäàíñêèé',
        [29] = 'Ãðàæäàíñêèé',
        [30] = 'Rifa',
        [31] = 'Ãðàæäàíñêèé',
        [32] = 'Ãðàæäàíñêèé',
        [33] = 'Ãðàæäàíñêèé',
        [34] = 'Ãðàæäàíñêèé',
        [35] = 'Ãðàæäàíñêèé',
        [36] = 'Ãðàæäàíñêèé',
        [37] = 'Ãðàæäàíñêèé',
        [38] = 'Ãðàæäàíñêèé',
        [39] = 'Ãðàæäàíñêèé',
        [40] = 'Ãðàæäàíñêèé',
        [41] = 'Aztec',
        [42] = 'Ãðàæäàíñêèé',
        [43] = 'Ãðàæäàíñêèé',
        [44] = 'Aztec',
        [45] = 'Ãðàæäàíñêèé',
        [46] = 'Ãðàæäàíñêèé',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Ãðàæäàíñêèé',
        [50] = 'Ãðàæäàíñêèé',
        [51] = 'Ãðàæäàíñêèé',
        [52] = 'Ãðàæäàíñêèé',
        [53] = 'Ãðàæäàíñêèé',
        [54] = 'Ãðàæäàíñêèé',
        [55] = 'Ãðàæäàíñêèé',
        [56] = 'Grove',
        [57] = 'Ìýðèÿ',
        [58] = 'Ãðàæäàíñêèé',
        [59] = 'Àâòîøêîëà',
        [60] = 'Ãðàæäàíñêèé',
        [61] = 'Àðìèÿ',
        [62] = 'Ãðàæäàíñêèé',
        [63] = 'Ãðàæäàíñêèé',
        [64] = 'Ãðàæäàíñêèé',
        [65] = 'Ãðàæäàíñêèé', -- íàä ïîäóìàòü
        [66] = 'Ãðàæäàíñêèé',
        [67] = 'Ãðàæäàíñêèé',
        [68] = 'Ãðàæäàíñêèé',
        [69] = 'Ãðàæäàíñêèé',
        [70] = 'ÌÎÍ',
        [71] = 'Ãðàæäàíñêèé',
        [72] = 'Ãðàæäàíñêèé',
        [73] = 'Army',
        [74] = 'Ãðàæäàíñêèé',
        [75] = 'Ãðàæäàíñêèé',
        [76] = 'Ãðàæäàíñêèé',
        [77] = 'Ãðàæäàíñêèé',
        [78] = 'Ãðàæäàíñêèé',
        [79] = 'Ãðàæäàíñêèé',
        [80] = 'Ãðàæäàíñêèé',
        [81] = 'Ãðàæäàíñêèé',
        [82] = 'Ãðàæäàíñêèé',
        [83] = 'Ãðàæäàíñêèé',
        [84] = 'Ãðàæäàíñêèé',
        [85] = 'Ãðàæäàíñêèé',
        [86] = 'Grove',
        [87] = 'Ãðàæäàíñêèé',
        [88] = 'Ãðàæäàíñêèé',
        [89] = 'Ãðàæäàíñêèé',
        [90] = 'Ãðàæäàíñêèé',
        [91] = 'Ãðàæäàíñêèé', -- ïîä âîïðîñîì
        [92] = 'Ãðàæäàíñêèé',
        [93] = 'Ãðàæäàíñêèé',
        [94] = 'Ãðàæäàíñêèé',
        [95] = 'Ãðàæäàíñêèé',
        [96] = 'Ãðàæäàíñêèé',
        [97] = 'Ãðàæäàíñêèé',
        [98] = 'Ìýðèÿ',
        [99] = 'Ãðàæäàíñêèé',
        [100] = 'Áàéêåð',
        [101] = 'Ãðàæäàíñêèé',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = 'Ãðàæäàíñêèé',
        [122] = 'Ãðàæäàíñêèé',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Ãðàæäàíñêèé',
        [129] = 'Ãðàæäàíñêèé',
        [130] = 'Ãðàæäàíñêèé',
        [131] = 'Ãðàæäàíñêèé',
        [132] = 'Ãðàæäàíñêèé',
        [133] = 'Ãðàæäàíñêèé',
        [134] = 'Ãðàæäàíñêèé',
        [135] = 'Ãðàæäàíñêèé',
        [136] = 'Ãðàæäàíñêèé',
        [137] = 'Ãðàæäàíñêèé',
        [138] = 'Ãðàæäàíñêèé',
        [139] = 'Ãðàæäàíñêèé',
        [140] = 'Ãðàæäàíñêèé',
        [141] = 'FBI',
        [142] = 'Ãðàæäàíñêèé',
        [143] = 'Ãðàæäàíñêèé',
        [144] = 'Ãðàæäàíñêèé',
        [145] = 'Ãðàæäàíñêèé',
        [146] = 'Ãðàæäàíñêèé',
        [147] = 'Ìýðèÿ',
        [148] = 'Ãðàæäàíñêèé',
        [149] = 'Grove',
        [150] = 'Ìýðèÿ',
        [151] = 'Ãðàæäàíñêèé',
        [152] = 'Ãðàæäàíñêèé',
        [153] = 'Ãðàæäàíñêèé',
        [154] = 'Ãðàæäàíñêèé',
        [155] = 'Ãðàæäàíñêèé',
        [156] = 'Ãðàæäàíñêèé',
        [157] = 'Ãðàæäàíñêèé',
        [158] = 'Ãðàæäàíñêèé',
        [159] = 'Ãðàæäàíñêèé',
        [160] = 'Ãðàæäàíñêèé',
        [161] = 'Ãðàæäàíñêèé',
        [162] = 'Ãðàæäàíñêèé',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Ãðàæäàíñêèé',
        [168] = 'Ãðàæäàíñêèé',
        [169] = 'Yakuza',
        [170] = 'Ãðàæäàíñêèé',
        [171] = 'Ãðàæäàíñêèé',
        [172] = 'Ãðàæäàíñêèé',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Ãðàæäàíñêèé',
        [177] = 'Ãðàæäàíñêèé',
        [178] = 'Ãðàæäàíñêèé',
        [179] = 'Army',
        [180] = 'Ãðàæäàíñêèé',
        [181] = 'Áàéêåð',
        [182] = 'Ãðàæäàíñêèé',
        [183] = 'Ãðàæäàíñêèé',
        [184] = 'Ãðàæäàíñêèé',
        [185] = 'Ãðàæäàíñêèé',
        [186] = 'Yakuza',
        [187] = 'Ìýðèÿ',
        [188] = 'ÑÌÈ',
        [189] = 'Ãðàæäàíñêèé',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Ãðàæäàíñêèé',
        [193] = 'Aztec',
        [194] = 'Ãðàæäàíñêèé',
        [195] = 'Ballas',
        [196] = 'Ãðàæäàíñêèé',
        [197] = 'Ãðàæäàíñêèé',
        [198] = 'Ãðàæäàíñêèé',
        [199] = 'Ãðàæäàíñêèé',
        [200] = 'Ãðàæäàíñêèé',
        [201] = 'Ãðàæäàíñêèé',
        [202] = 'Ãðàæäàíñêèé',
        [203] = 'Ãðàæäàíñêèé',
        [204] = 'Ãðàæäàíñêèé',
        [205] = 'Ãðàæäàíñêèé',
        [206] = 'Ãðàæäàíñêèé',
        [207] = 'Ãðàæäàíñêèé',
        [208] = 'Yakuza',
        [209] = 'Ãðàæäàíñêèé',
        [210] = 'Ãðàæäàíñêèé',
        [211] = 'ÑÌÈ',
        [212] = 'Ãðàæäàíñêèé',
        [213] = 'Ãðàæäàíñêèé',
        [214] = 'LCN',
        [215] = 'Ãðàæäàíñêèé',
        [216] = 'Ãðàæäàíñêèé',
        [217] = 'ÑÌÈ',
        [218] = 'Ãðàæäàíñêèé',
        [219] = 'ÌÎÍ',
        [220] = 'Ãðàæäàíñêèé',
        [221] = 'Ãðàæäàíñêèé',
        [222] = 'Ãðàæäàíñêèé',
        [223] = 'LCN',
        [224] = 'Ãðàæäàíñêèé',
        [225] = 'Ãðàæäàíñêèé',
        [226] = 'Rifa',
        [227] = 'Ìýðèÿ',
        [228] = 'Ãðàæäàíñêèé',
        [229] = 'Ãðàæäàíñêèé',
        [230] = 'Ãðàæäàíñêèé',
        [231] = 'Ãðàæäàíñêèé',
        [232] = 'Ãðàæäàíñêèé',
        [233] = 'Ãðàæäàíñêèé',
        [234] = 'Ãðàæäàíñêèé',
        [235] = 'Ãðàæäàíñêèé',
        [236] = 'Ãðàæäàíñêèé',
        [237] = 'Ãðàæäàíñêèé',
        [238] = 'Ãðàæäàíñêèé',
        [239] = 'Ãðàæäàíñêèé',
        [240] = 'Àâòîøêîëà',
        [241] = 'Ãðàæäàíñêèé',
        [242] = 'Ãðàæäàíñêèé',
        [243] = 'Ãðàæäàíñêèé',
        [244] = 'Ãðàæäàíñêèé',
        [245] = 'Ãðàæäàíñêèé',
        [246] = 'Áàéêåð',
        [247] = 'Áàéêåð',
        [248] = 'Áàéêåð',
        [249] = 'Ãðàæäàíñêèé',
        [250] = 'ÑÌÈ',
        [251] = 'Ãðàæäàíñêèé',
        [252] = 'Army',
        [253] = 'Ãðàæäàíñêèé',
        [254] = 'Áàéêåð',
        [255] = 'Army',
        [256] = 'Ãðàæäàíñêèé',
        [257] = 'Ãðàæäàíñêèé',
        [258] = 'Ãðàæäàíñêèé',
        [259] = 'Ãðàæäàíñêèé',
        [260] = 'Ãðàæäàíñêèé',
        [261] = 'ÑÌÈ',
        [262] = 'Ãðàæäàíñêèé',
        [263] = 'Ãðàæäàíñêèé',
        [264] = 'Ãðàæäàíñêèé',
        [265] = 'Ïîëèöèÿ',
        [266] = 'Ïîëèöèÿ',
        [267] = 'Ïîëèöèÿ',
        [268] = 'Ãðàæäàíñêèé',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Ãðàæäàíñêèé', -- íàäî ïîäóìàòü
        [274] = 'ÌÎÍ',
        [275] = 'ÌÎÍ',
        [276] = 'ÌÎÍ',
        [277] = 'Ãðàæäàíñêèé',
        [278] = 'Ãðàæäàíñêèé',
        [279] = 'Ãðàæäàíñêèé',
        [280] = 'Ïîëèöèÿ',
        [281] = 'Ïîëèöèÿ',
        [282] = 'Ïîëèöèÿ',
        [283] = 'Ïîëèöèÿ',
        [284] = 'Ïîëèöèÿ',
        [285] = 'Ïîëèöèÿ',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Ïîëèöèÿ',
        [289] = 'Ãðàæäàíñêèé',
        [290] = 'Ãðàæäàíñêèé',
        [291] = 'Ãðàæäàíñêèé',
        [292] = 'Aztec',
        [293] = 'Ãðàæäàíñêèé',
        [294] = 'Ãðàæäàíñêèé',
        [295] = 'Ãðàæäàíñêèé',
        [296] = 'Ãðàæäàíñêèé',
        [297] = 'Grove',
        [298] = 'Ãðàæäàíñêèé',
        [299] = 'Ãðàæäàíñêèé',
        [300] = 'Ïîëèöèÿ',
        [301] = 'Ïîëèöèÿ',
        [302] = 'Ïîëèöèÿ',
        [303] = 'Ïîëèöèÿ',
        [304] = 'Ïîëèöèÿ',
        [305] = 'Ïîëèöèÿ',
        [306] = 'Ïîëèöèÿ',
        [307] = 'Ïîëèöèÿ',
        [308] = 'ÌÎÍ',
        [309] = 'Ïîëèöèÿ',
        [310] = 'Ïîëèöèÿ',
        [311] = 'Ïîëèöèÿ'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function update()
	local fpath = os.getenv('TEMP') .. '\\update.json'
	downloadUrlToFile('https://raw.githubusercontent.com/Misanthrope123/myprojec/master/update.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
			    local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
				updversion = info.latest
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('Îáíàðóæåíî îáíîâëåíèå äî âåðñèè '..updversion..'.')
					    updwindows.v = true
                    else
                        ftext('Îáíîâëåíèé ñêðèïòà íå îáíàðóæåíî. Ïðèÿòíîé èãðû.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
end

function smsjob()
  if rank == 'Ýêçàìåíàòîð' or rank == 'Ìë.Èíñòðóêòîð' or rank == 'Èíñòðóêòîð' or rank == 'Êîîðäèíàòîð' or rank == 'Ìë.Ìåíåäæåð' or rank == 'Ñò.Ìåíåäæåð' or rank == 'Äèðåêòîð' or  rank == 'Óïðàâëÿþùèé' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Íà ðàáîòó')
            wait(1200)
        end
        players2 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else 
	ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 3 ðàíãà')
	end
end

function goupdate()
    ftext('Íà÷àëîñü ñêà÷èâàíèå îáíîâëåíèÿ. Ñêðèïò ïåðåçàãðóçèòñÿ ÷åðåç ïàðó ñåêóíä.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        showCursor(false)
	    thisScript():reload()
    end
end)
end

function cmd_color() -- ôóíêöèÿ ïîëó÷åíèÿ öâåòà ñòðîêè, õç çà÷åì îíà ìíå, íî êîãäà òî þçàë
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Öâåò ïîñëåäíåé ñòðîêè ÷àòà - {934054}[%d] (ñêîïèðîâàí â áóôåð îáìåíà)",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors = 
        {
		[1] = 'Çåë¸íûé',
		[2] = 'Ñâåòëî-çåë¸íûé',
		[3] = 'ßðêî-çåë¸íûé',
		[4] = 'Áèðþçîâûé',
		[5] = 'Æ¸ëòî-çåë¸íûé',
		[6] = 'Òåìíî-çåë¸íûé',
		[7] = 'Ñåðî-çåë¸íûé',
		[8] = 'Êðàñíûé',
		[9] = 'ßðêî-êðàñíûé',
		[10] = 'Îðàíæåâûé',
		[11] = 'Êîðè÷íåâûé',
		[12] = 'Ò¸ìíî-êðàñíûé',
		[13] = 'Ñåðî-êðàñíûé',
		[14] = 'Æ¸ëòî-îðàíæåâûé',
		[15] = 'Ìàëèíîâûé',
		[16] = 'Ðîçîâûé',
		[17] = 'Ñèíèé',
		[18] = 'Ãîëóáîé',
		[19] = 'Ñèíÿÿ ñòàëü',
		[20] = 'Ñèíå-çåë¸íûé',
		[21] = 'Ò¸ìíî-ñèíèé',
		[22] = 'Ôèîëåòîâûé',
		[23] = 'Èíäèãî',
		[24] = 'Ñåðî-ñèíèé',
		[25] = 'Æ¸ëòûé',
		[26] = 'Êóêóðóçíûé',
		[27] = 'Çîëîòîé',
		[28] = 'Ñòàðîå çîëîòî',
		[29] = 'Îëèâêîâûé',
		[30] = 'Ñåðûé',
		[31] = 'Ñåðåáðî',
		[32] = '×åðíûé',
		[33] = 'Áåëûé',
		}
	return colors[id]
end

function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('Ðàáî÷èé äåíü íà÷àò') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me îòêðûë øêàô÷èê")
                wait(1500)
                sampSendChat("/me ñíÿë ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèë åå â øêàô")
                wait(1500)
                sampSendChat("/me âçÿë ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëñÿ â íåå")
                wait(1500)
                sampSendChat("/me íàöåïèë áåéäæèê íà ðóáàøêó")
                wait(1500)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')  
				end
				if cfg.main.male == false then
				sampSendChat("/me îòêðûëà øêàô÷èê")
                wait(1500)
                sampSendChat("/me ñíÿëà ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèëà åå â øêàô")
                wait(1500)
                sampSendChat("/me âçÿëà ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëàñü â íåå")
                wait(1500)
                sampSendChat("/me íàöåïèëà áåéäæèê íà ðóáàøêó")
                wait(1500)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Îòïðàâèòåëü:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Îòïðàâèòåëü: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Ðàáî÷èé äåíü îêîí÷åí') and color ~= -1 then
        rabden = false
    end
	if text:find('ïðèîáðåë ëèöåíçèþ íà âîçäóøíûé òðàíñïîðò') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà âîçäóøíûé òðàíñïîðò. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		pilot = pilot + 1
   end
   	if text:find('ïðèîáðåë âîäèòåëüñêèå ïðàâà') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë âîäèòåëüñêèå ïðàâà. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		prava = prava + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà ðûáîëîâñòâî') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà ðûáîëîâñòâî. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		ribolov = ribolov + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà ìîðñêîé òðàíñïîðò') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà ìîðñêîé òðàíñïîðò. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		kater = kater + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà îðóæèå') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà îðóæèå. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		gun = gun + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà áèçíåñ') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà îòêðûòèå áèçíåñà. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		biznes = biznes + 1
   end
	if text:find('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+)') then
        local un1, un2 = text:match('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - Óâîëåí(à) ïî ïðè÷èíå "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - Óâîëåí(à) ïî ïðè÷èíå "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)') then
        local inv1 = text:match('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)')
		lua_thread.create(function()
		wait(5000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: Íîâûé ñîòðóäíèê Àâòîøêîëû - %s. Äîáðî ïîæàëîâàòü.', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r Íîâûé ñîòðóäíèê Àâòîøêîëû - %s. Äîáðî ïîæàëîâàòü.', inv1:gsub('_', ' ')))
		end
		end)
    end
	if color == -8224086 then
        local colors = ("{%06X}"):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors.."[%H:%M:%S] ") .. text)
    end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
					
					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('Âûõîäíîé') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end
