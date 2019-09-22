script_name('Inst Tools')
script_version('1.0')
test_version = "1.0-preview 1"
script_author('Damien_Requeste, Roma_Mizantrop')
local sf = require 'sampfuncs'                                                                           
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev, sp = require 'lib.samp.events'
local lsg, sf               = pcall(require, 'sampfuncs')
local lkey, key             = pcall(require, 'vkeys')
local lsampev, sp           = pcall(require, 'lib.samp.events')
local lsphere, Sphere       = pcall(require, 'Sphere')
local lrkeys, rkeys         = pcall(require, 'rkeys')
local limadd, imadd         = pcall(require, 'imgui_addons')
local dlstatus              = require('moonloader').download_status
local limgui, imgui         = pcall(require, 'imgui')
local lcopas, copas       = pcall(require, 'copas')
local lhttp, http         = pcall(require, 'copas.http')
local lrequests, requests   = pcall(require, 'requests')
local wm                    = require 'lib.windows.message'
local gk                    = require 'game.keys'
local encoding              = require 'encoding'
local imgui = require 'imgui' -- загружаем библиотеку
local encoding = require 'encoding' -- загружаем библиотеку
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local lmem, memory = pcall(require, 'memory')
                     assert(lmem, 'Library \'memory\' not found')
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local btn_size = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)                              
local sInputEdit = imgui.ImBuffer(128)
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local memw = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "Inst Tools {ffffff}|"
players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
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
tMembers = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0

	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
	colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
	colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
	colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
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
    posX = 1358,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'Стажер',
    parol = 'Password',
    parolb = false,
	tarr = 'Сотрудник',
	tchat = false,
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
    ftext("Inst Tools успешно загрузился. Введите: /it для открытия меню скрипта", -1)
    ftext("Вы используете тестовую версию - "..test_version)
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Файл конфига успешно создан.", -1)
      cfg = inicfg.load(nil, 'instools/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Загружается библиотека '..v)
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
  local frakc = proverkk:match('.+Организация%:%s+(.+)%s+Ранг')
  local rang = proverkk:match('.+Ранг%:%s+(.+)%s+Работа')
  local telephone = proverkk:match('.+Телефон%:%s+(.+)%s+Законопослушность')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}Место для продажи лицензий', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
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
  sampRegisterChatCommand('it', it)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('blag', blag)
  sampRegisterChatCommand('cchat', cmd_cchat)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('nick', nick)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('lecture', lecture)
  sampRegisterChatCommand('find', cmd_find)
  sampRegisterChatCommand('uninvite', uninvite)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('По завершению введите команду еще раз.')
            else
                changetextpos = false
				inicfg.save(cfg, 'instools/config.ini') -- сохраняем все новые значения в конфиге
            end
        else
            ftext('Для начала включите инфо-бар.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Driving School' then
    submenus_show(fastmenu(id), "{008B8B}Inst Tools {ffffff}| Быстрое меню")
	else
	ftext('Возможно вы не состоите в автошколе {ff0000}[ctrl+R]')
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
                submenus_show(pkmmenu(id), "{008B8B}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}Уровень - "..sampGetPlayerScore(id).." ")
				else
			ftext('Возможно вы не состоите в автошколе {ff0000}[ctrl+R]')
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
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v or memw.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
Расценки на лицензии:

Водительские права
Для проживающих в штате от 1 до 2-х лет: 500$.
Для проживающих в штате от 3х - до 5-ти лет: 5.000$.
Для проживающих в штате от 6-ти до 15-ти лет: 10.000$.
Для проживающих в штате от 16 лет: 30.000$.
Рыболовство
Каждому жителю штата: 2.000$.
Водный транспорт
Каждому жителю штата: 5.000$.
Воздушный транспорт
Каждому жителю штата: 10.000$.
На оружие
Каждому жителю штата: 50.000$.
На бизнес
Каждому жителю штата: 100.000$.

I. ОБЩИЕ ПОЛОЖЕНИЯ

1.1 Устав Автошколы - документ устанавливающий нормы правил и порядка в организации.
1.2 Сотрудники Автошколы в обязательном порядке должны подчиняться коллегам, которые выше их по должности. (Исключение: Главы отделов и их заместители подчиняются исключительно Старшему составу)
1.3 Каждый сотрудник Автошколы обязан качественно и своевременно обслуживать клиентов.
1.4 Сотруднику Автошколы категорически запрещено не обслуживать клиентов из-за личной неприязни.
1.5 Незнание Устава Автошколы никаким образом не освобождает Вас от ответственности.
1.6 Запрещено выпрашивать повышения в любые чаты и в любой форме. (Исключение: при наступлении срока, Вы можете подойти к сотруднику из Старшего состава и сообщить ему об этом)
1.7 Устав Автошколы может быть изменён Управляющим в любое время. (Примечание: Управляющий в праве не оповестить Вас об этом, поэтому не пренебрегайте прочтением документации)
1.8 Данный Устав вступил в силу с 05.09.2019.
1.9 Управляющий имеет право нарушить Устав Автошколы.

II. ОБЯЗАННОСТИ ШТАТНЫХ СОТРУДНИКОВ АВТОШКОЛЫ

2.1 Штатными сотрудниками являются: Стажеры, Консультанты, Экзаменаторы не состоящие в отделе и сотрудники отделов (кроме заместителя и Главы отдела).

Штатные сотрудники обязаны:

2.2 Знать и соблюдать Устав Автошколы.
2.3 Знать и соблюдать все правила, а так же законы Штата.
2.4 Подавать пример своим вождением и знать ПДД.
2.5 Следить за очередностью обслуживаемых клиентов, а так же не отбирать клиентов у своих коллег.
2.6 Сотрудник Автошколы, прежде чем выдать лицензию, обязан попросить паспорт у клиента и заполнить бланк на лицензию его данными. (Наказание: выговор).
2.7 Вести разговор посредством делового стиля. (Наказание: предупреждение)..
2.8 Следить за своим поведением и избегать любых провокационных действий.
2.9 Отвечать на вопросы посетителей, которые касаются ПДД и видов лицензий. В остальных темах, Вы вправе отказаться от диалога.
2.10 Обязаны носить бейджик согласно тому или инному отделу, а так же без него:
2.10.1 Бейджик Стажеров - Консультантов - № 23.
2.10.2 Бейджик Экзаменатора - № 10.
2.10.3 Бейджик Заместителя Главы Отдела - № 8.
2.10.4 Бейджик Глав Отделов - № 12.
2.10.5 Бейджик Старшего Состава Автошколы - № 15.
2.11 В рабочее время сотрудник обязан носить униформу выданную в офисе.
2.12 Младший Инструктор обязан выбрать отдел, где он продолжит свою деятельность. (Без отдела дальнейшие повышения в должности проходить не будут)
2.13 Закрывать за собой двери в комнату отдыха, после входа или выхода из неё.
2.14 В случае если за стойкой отсутствует персонал, все штатные сотрудники отделов обязаны занять её.
2.15 Брать вертолет будучи в должности Координатор.

III. ОБЯЗАННОСТИ ГЛАВ ОТДЕЛОВ АВТОШКОЛЫ И ИХ ЗАМЕСТИТЕЛЕЙ

Главы отделов и из заместители обязаны:

3.1 Соблюдать пункты Устава, которые предназначены для штатных сотрудников. (Пункт Устава II - полностью).
3.2 Глава Отдела должен следить и своевременно вносить информацию по отделу в специальную таблицу созданной в Google-формах. (Каждый день: до 21-00).
3.3 Глава Отдела вправе сам выбрать своего заместителя.
3.4 Главы Отдела вправе выдавать выговоры сотрудникам в пределах Устава Автошколы и своих полномочий:
3.5 Назначение на должность Главы отдела в полном объёме относится к Старшему Составу.
3.6 В случае если за стойкой отсутствует персонал, Глава или Заместитель любого отдела обязан послать за неё подчиненного из своего отдела или же встать самому.
3.7 Если от сотрудника Старшего Состава поступило поручение встать за стойку, при условии отсутствия за ней менее 3-ёх человек из персонала - это обязательно к исполнению.

IV. РАБОЧИЙ ДЕНЬ В АВТОШКОЛЕ

4.1 В будни, рабочий день длится с 09:00 до 20:00. В выходные дни рабочий день длится с 10:00 до 19:00.
4.2 Время для перерыва (обеда) с 13:00 до 14:00.
4.3 В рабочее время запрещено носить любые аксессуары. (Исключение: береты, шляпы, очки, часы, усы, чемоданы и рюкзаки)
4.4 Запрещено покидать офис в рабочее время без разрешения ст.состава.
4.5 Время прибытия на работу, независимо от места проживания и нахождения — 10 минут.
4.6 По желанию сотрудник может остаться на ночную смену после конца рабочего дня.
4.7 Запрещено находиться на автомобильной ярмарке в рабочее время. (Исключение: возможно отпроситься у сотрудников Старшего Состава).
4.8 Разрешено в течение рабочего дня посещать МП от администраторов, а также системные МП (гонки / Base Jump / Paint Ball), но при этом сообщать в рацию, что вы отправляетесь на мероприятие
4.9 Разрешено покидать офис для доставки лицензий, проведения лекций гос. организациям.

V. СОТРУДНИКАМ АВТОШКОЛЫ ЗАПРЕЩАЕТСЯ

5.1 Покидать офис во время рабочего дня без разрешения Старшего состава.
5.2 Спать вне комнаты отдыха более 100 секунд. (Исключение: кроме сотрудников Старшего состава 7+ ранга).
5.3 Носить уни-форму не по должности. (Наказание: выговор I степени).
5.4 Хамить клиентам. (Наказание: увольнение, не зависимо от должности).
5.5 Сотруднику Автошколы категорически запрещено не обслуживать клиентов из-за личной неприязни.
5.6 Обманывать Старший Состав и коллег. (Наказание: увольнение из организации).
5.7 Находиться в AFK без ESC. (Наказание: увольнение из организации).
5.8 Использовать транспорт, принадлежащий Автошколе, в личных целях.
5.9 Работать на любой государственной работе, не снимая рабочую форму.
5.10 В открытую употреблять наркотические средства.
5.11 Использовать дверь в комнате отдыха в развлекательных намерениях.
5.12 Использовать нецензурные выражения будь это рация или обычное общение (как в IC так и в OOC чаты).
5.13 Писать в департамент во время ЧС- Чрезвычайной ситуации.
5.14 Играть в казино в рабочее время..
5.15 Игнорировать Старший Состав.
5.16 Прогуливать рабочий день.
5.17 Оскорблять коллег, а так же клиентов Автошколы.
5.18 Спать около кнопки открытия дверей, для выхода из комнаты отдыха.
5.19 Бегать и прыгать в пределах здания Автошколы.

VI. НАКАЗАНИЯ ЗА НАРУШЕНИЕ УСТАВА

6.1 Все виды наказаний строго регламентированы Уставом. Сотрудник Старшего состава не в праве выдавать иное наказание, а только лишь, то которое прописано.
6.2 Если наказание не прописано, выдать предупреждение с последующим выговором 1-ой степени.

VII. ПОЛОЖЕНИЯ ДЛЯ СТАРШЕГО СОСТАВА

7.1 Каждый сотрудник Старшего Состава (7+ ранг) обязан ежедневно до 00-00 публиковать на форуме в специальной теме реестр повышений/понижений/увольнений. (Наказание за халатное отношение - выговор).
7.2 Запрещено использовать свои должностные полномочия в личных целях. (Наказание за проступок - снятие с должности).
7.3 При неактиве, каждый в обязательном порядке отписать об это на форумном разделе. (Наказание - выговор, повторное - снятие).
7.4 По просьбе Управляющего в кротчайшее время являться в указанное место. (Наказание - предупреждение, выговор).
7.5 Отбирать рацию (/fmute) разрешено за следующие деяния:
7.5.1 Нарушение правил чатов (MetaGaming) - 5 минут с причиной "Бред в рацию".
7.5.2 Флуд в рацию (более 3 сообщений) - 10 минут с причиной "Баловство с рацией".
7.5.3 Выяснения отношений между сотрудниками - 10 минут обоим с причиной "Выяснение отношений".
7.5.4 Матерные выражения (в любой чат, будь это /r или /rb) - 20 минут с причиной "Нецензурная лексика".
7.5.5 Общение в /r не по теме организации - 5 минут с причиной "Засорение рации".
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Показываем информацию.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}В сети: "..gcount.." | {ae433d}Организация | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end

    function sp.onShowDialog(id, style, title, button1, button2, text)
        if id == 50 and msda then
            sampSendDialogResponse(id, 1, getMaskList(msvidat), _)
            msid = nil
            msda = false
            msvidat = nil
            return false
        end
        if id == 1 and cfg.main.parolb and #tostring(cfg.main.parol) >= 6 then
            sampSendDialogResponse(id, 1, _, tostring(cfg.main.parol))
            return false
        end
        end
        
function blag(arg)
  if #arg == 0 then
    ftext('Введите: /blag [ид] [фракция] [тип]')
    ftext('Тип: 1 - за транспортировку')
    return
  end
  local args = string.split(arg, " ", 3)
  args[3] = tonumber(args[3])
  if args[1] == nil or args[2] == nil or args[3] == nil then
    ftext('Введите: /blag [ид] [фракция] [тип]')
    ftext('Тип: 1 - за транспортировку')
    return   
  end
  local pid = tonumber(args[1])
  if pid == nil then ftext('Игрок не найден!') return end
  if not sampIsPlayerConnected(pid) then ftext('Игрок оффлайн!') return end
  local blags = {"транспортировку"}
  if args[3] < 1 or args[3] > #blags then ftext('Неверный тип!') return end
  sampSendChat(("/d %s, выражаю благодарность %s за %s. Цените!"):format(args[2], string.gsub(sampGetPlayerNickname(pid), "_", " "), blags[args[3]]))
end

function string.split(inputstr, sep, limit)
  if limit == nil then limit = 0 end
  if sep == nil then sep = "%s" end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    if i >= limit and limit > 0 then
      if t[i] == nil then
        t[i] = ""..str
      else
        t[i] = t[i]..sep..str
      end
    else
      t[i] = str
      i = i + 1
    end
  end
  return t
end

function cmd_cchat()
  memory.fill(sampGetChatInfoPtr() + 306, 0x0, 25200)
  memory.write(sampGetChatInfoPtr() + 306, 25562, 4, 0x0)
  memory.write(sampGetChatInfoPtr() + 0x63DA, 1, 1)
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{008B8B}Inst Tools {ffffff}| {ae433d}Сотрудники вне офиса {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{008B8B}Inst Tools {ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
if rank == 'Экзаменатор' or rank == 'Мл.Инструктор' or rank == "Инструктор" or rank == 'Координатор' or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or  rank == 'Директор' or  rank == 'Управляющий' then
  if id == nil then
    sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Введите: /vig [id] [причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{008B8B}Inst Tools {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{008B8B}Inst Tools {ffffff}| /vig [id] [причина]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Получает выговор по причине: %s.", cfg.main.tarr, rpname, pric))
		else 
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Получает выговор по причине: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- запрос местоположения
   if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or  rank == 'Директор' or  rank == 'Управляющий' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, доложите свое местоположение. На ответ 20 секунд.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, доложите свое местоположение. На ответ 20 секунд.", name))
			end
			else
			ftext('{FFFFFF} Игрок с данным ID не подключен к серверу или указан ваш ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Используйте: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Данная команда доступна с 7 ранга.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Стажёра',
		['2'] = 'Консультанта',
		['3'] = 'Экзаменатора',
		['4'] = 'Мл.Инструктора',
		['5'] = 'Инструктора',
		['6'] = 'Координатора',
		['7'] = 'Мл.Менеджера',
		['8'] = 'Ст.Менеджера',
		['9'] = 'Директора'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
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
				sampSendChat('/me снял старый бейджик с человека напротив стоящего')
				wait(1500)
				sampSendChat('/me убрал старый бейджик в карман')
				wait(1500)
                sampSendChat(string.format('/me достал новый бейджик %s', ranks))
				wait(1500)
				sampSendChat('/me закрепил на рубашку человеку напротив новый бейджик')
				wait(1500)
				else
				sampSendChat('/me сняла старый бейджик с человека напротив стоящего')
				wait(1500)
				sampSendChat('/me убрала старый бейджик в карман')
				wait(1500)
                sampSendChat(string.format('/me достала новый бейджик %s', ranks))
				wait(1500)
				sampSendChat('/me закрепила на рубашку человеку напротив новый бейджик')
				wait(1500)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(1500)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', cfg.main.tarr, plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks, plus == '+' and ', поздравляю' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до %s%s.', plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks, plus == '+' and ', поздравляю' or ''))
            end
			else 
			ftext('Вы ввели неверный тип [+/-]')
		end
		else 
			ftext('Введите: /giverank [id] [ранг] [+/-]')
		end
		else 
			ftext('Данная команда доступна с 7 ранга')
	  end
	  else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
	  end
   end)
 end

function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Директор' or  rank == 'Управляющий' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me достал(а) бейджик и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1500)
				sampSendChat(string.format('/invite %s', id))
			else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else 
			ftext('Введите: /invite [id]')
		end
		else 
			ftext('Данная команда доступна с 9 ранга')
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
                submenus_show(oinvite(id), "{008B8B}Inst Tools {ffffff}| Выбор отдела")
				else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else 
			ftext('Включите автотег в настройках')
		end
		else 
			ftext('Рядом с вами нет данного человека')
	  end
	  else 
			ftext('Рядом с вами нет данного человека')
	end
	  else 
			ftext('Введите: /oinv [id]')
	end
	  end)
   end
   
   function lecture(pam)
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
                submenus_show(lectures(id), "{008B8B}Inst Tools {ffffff}| Меню лекций для отделов")
				else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
            end
		else 
			ftext('Включите автотег в настройках')
		end
		else 
			ftext('Рядом с вами нет данного человека')
	  end
	  else 
			ftext('Рядом с вами нет данного человека')
	end
	  else 
			ftext('Введите: /lecture [id]')
	end
	  end)
   end
   
function nick(args)
  if #args == 0 then ftext("Введите: /nick [id] [0 - RP nick, 1 - NonRP nick]") return end
  args = string.split(args, " ")
  if #args == 1 then
    cmd_nick(args[1].." 0")
  elseif #args == 2 then
    local getID = tonumber(args[1])
    if getID == nil then ftext("Неверный ID игрока!") return end
    if not sampIsPlayerConnected(getID) then ftext("Игрок оффлайн!") return end 
    getID = sampGetPlayerNickname(getID)
    if tonumber(args[2]) == 1 then
      ftext("Ник \""..getID.."\" успешно скопирован в буфер обмена.")
    else
      getID = string.gsub(getID, "_", " ")
      ftext("РП Ник \""..getID.."\" успешно скопирован в буфер обмена.")
    end
    setClipboardText(getID)
  else
    ftext("Введите: /nick [id] [0 - RP nick, 1 - NonRP nick]")
    return
  end 
end

   function cmd_find(args)
  -- https://blast.hk/wiki/lua:processlineofsight
  if #args == 0 then
    if playerMarker ~= nil then
      removeBlip(playerMarker)
      removeBlip(playerRadar)
      playerMarker = nil
      playerRadar = nil
      playerMarkerId = nil
      ftext('Маркер успешно убран')
      return
    end
    ftext('Введите: /find [id]')
    return
  end
  local id = tonumber(args)
  if id == nil then ftext('Игрок оффлайн!') return end
  if not sampIsPlayerConnected(id) then ftext('Игрок оффлайн!') return end
  local result, ped = sampGetCharHandleBySampPlayerId(id)
  if not result then ftext('Игрок должен быть в зоне прорисовки') return end   
  if playerMarker ~= nil then
    removeBlip(playerMarker)
    removeBlip(playerRadar)
    playerMarkerId = nil
  end
  playerMarkerId = id
  playerMarker = addBlipForChar(ped)
  --changeBlipColour(playerMarker, 0xFF0000FF)
  local px, py, pz = getCharCoordinates(ped)
  playerRadar = addSpriteBlipForContactPoint(px, py, pz, 14)
  ftext(('Маркер установлен на игрока %s[%d]'):format(sampGetPlayerNickname(id), id))
  ftext('Чтобы убрать маркер, введите команду /find ещё раз')
end
 
 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me забрал(а) форму и бейджик у '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else 
			ftext('Игрок с данным ID не подключен к серверу или указан ваш ID')
		end
		else 
			ftext('Введите: /uninvite [id] [причина]')
		end
		else 
			ftext('Данная команда доступна с 8 ранга')
	  end
   end)
 end
 
 function lectures(id)
 return
{
  {
   title = "{008B8B}Инспекцонно-технический {FFFFFF}Отдел",
    onclick = function()
	sampSendChat('Приветствую, ты попал в «Инспекцонно-технический Отдел»')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Сейчас я тебе расскажу наши обязанности отдела:')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Перед проверкой/лекции обговаривать время с руководством государственной организации.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Проводить плановые проверки и лекции для гос. структур.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Выполнять поручения руководства отдела.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Носить бейдж своего отдела.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('В свободное от проверок время обслуживать клиентов автошколы.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Обязанности я сказал(а), теперь можете идти работать. Подробнее Вы можете почитать на офф.портале')
	end
   },
   {
   title = "{FFFFFF}Отдел {008B8B}Дополнительных Услуг",
    onclick = function()
	sampSendChat('Приветствую, ты попал в «Отдел Дополнительных Услуг»')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Сейчас я тебе расскажу наши обязанности отдела:')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Перед выездом оповестить руководство или старших состав в рацию.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Доставлять лицензии по государственным структурам штата Evolve. ')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('По окончанию доставки лицензии сообщить в рацию.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Оставлять недельный отчет о проделанной работе. В день минимум 3 выезда')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Выполнять поручения руководителя отдела и его заместителя а так же старшего состава. ')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Носить бейджик своего отдела.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('В свободное от доставки время помогать мл.составу в офисе.')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('При радиообмене использовать ТЕГ и должность своего отдела')
	wait(cfg.commands.zaderjka * 1000)
	sampSendChat('Обязанности я сказал(а), теперь можете идти работать. Подробнее Вы можете почитать на офф.портале')
	end
   },
 }
end
 
function oinvite(id)
 return
{
  {
   title = "{FFFFFF}Отдел {008B8B}Дополнительных Услуг ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника Дополнительных Услуг и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 14')
	wait(1500)
	sampSendChat('/b Тег в /r [Сотрудник ОДУ]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый сотрудник Инспекцонно-Лекционного Отдела.', cfg.main.tarr))
	end
   },
   {
   title = "{008B8B}Инспекцонно-технический {FFFFFF}Отдел ",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника Инспекцонно-технического Отдела и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 21')
	wait(1500)
	sampSendChat('/b тег в /r [Сотрудник ИТО]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый сотрудник Внештатного Отдела.', cfg.main.tarr))
	end
   },
 }
end

function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}Меню {008B8B}лекций",
    onclick = function()
	submenus_show(fthmenu(id), "{008B8B}Inst Tools {ffffff}| Меню лекций")
	end
   },
    {
   title = "{FFFFFF}Меню {008B8B}гос.новостей {ff0000}(Для Ст.Состава)",
    onclick = function()
	if rank == 'Директор' or  rank == 'Управляющий' then
	submenus_show(govmenu(id), "{008B8B}Inst Tools {ffffff}| Меню гос.новостей")
	else
	ftext('Вы не находитесь в Ст.Составе')
	end
	end
   },
   {
   title = "{FFFFFF}Меню {008B8B}отделов",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{008B8B}Inst Tools {ffffff}| Меню отделов")
	else
	ftext('Включите автотег в настройках')
	end
	end
   },
   {
   title = "{FFFFFF}Меню {008B8B}собеседования",
    onclick = function()
	submenus_show(sobes(id), "{008B8B}Inst Tools {ffffff}| Меню собеседования")
	end
   },
   {
   title = "{FFFFFF}Доставка лицензий {008B8B}в любую точку штата в /d{ff0000} (Для 4+ ранга)",
    onclick = function()
	if rank == 'Экзаменатор' or rank == 'Мл.Инструктор' or rank == 'Инструктор' or rank == 'Координатор' or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
	sampSendChat(string.format('/d OG, Осуществляется доставка лицензий в любую точку штата. Тел: %s.', tel))
	else
	ftext('Ваш ранг недостаточно высок')
	end
	end
   },
   {
   title = "{FFFFFF}Список {008B8B}сотрудников находящихся не в офисе",
    onclick = function()
	pX, pY, pZ = getCharCoordinates(playerPed)
	if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
	dmch()
	else
	ftext('Вы должны находиться в офисе')
	end
	end
   },
   {
   title = "{FFFFFF}Доложить в рацию о доставке лицензии {ff0000}(обязательно при доставке)",
    onclick = function()
    if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: Выехал(а) на доставку лицензий.', cfg.main.tarr))
        else
        sampSendChat(string.format('/r Выехал(а) на доставку лицензий.'))
        end
		dostavka = true
	end
   },
}
end

function sobes(id)
    return
    {
      {
        title = '{ffffff}» Приветствие и паспорт.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Приветствую, покажите пожалуйста свой паспорт, и мед.карту")
        wait(1500)
        sampSendChat("/b /showpass "..myid..", /me передал(а) мед.карту человеку напротив") 
		end
      },
      {
        title = '{ffffff}» Просмотр паспорта и мед.карты',
        onclick = function()
        sampSendChat("/me взял(а) паспорт в руки и мед.карту, после начал(а) вниматель осматривать")
        wait(4000)
        sampSendChat("/do Паспорт и мед.карта в руке.")
		end
      },
      {
        title = '{ffffff}» Информация о себе',
        onclick = function()
        local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Хорошо, расскажите о себе пожалуйста.")
        end
      },
      {
        title = '{ffffff}» Прошлое место работы',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Хорошо, раньше где-нибудь работали? Если да, скажите где, если не сложно.")
		end
      },
      {
        title = '{ffffff}» Опыт в сфере Автошколы',
        onclick = function()
        sampSendChat("Хорошо, имели раньше опыт в такой сфере как автошкола?")
		end
      },
      {
        title = '{ffffff}» IC термины',
        onclick = function()
        sampSendChat("Что по-вашему означает таково понятие как 'РП и МГ'?")
		end
      },
      {
        title = '{ffffff}» Что у меня над головой',
        onclick = function()
        sampSendChat("Что у меня над головой?")
		end
      },
      {
        title = '{ffffff}» Бланк с ответами, OOC термины',
        onclick = function()
        local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("/me взял(а) бланк со стола с вопросами и ручку")
        wait(4000)
        sampSendChat("/do Бланк и ручка в руке.")
        wait(4000)
        sampSendChat("/me передал(а) бланк с вопросами человеку на против")
        wait(4000)
        sampSendChat("/do На бланке написаны различные вопросы.")
        wait(4000)
        sampSendChat("/b ДМ, МГ, СК, ТК в /sms "..myid.."")
        wait(4000)
        sampSendChat("/me передал(а) бланк и ручку человеку напротив")                                                       
		end
      },
      {
        title = '{ffffff}» Просмотр бланка с ответами',
        onclick = function()
        sampSendChat("/me взял(а) бланк и ручку с рук человека на против, и начал(а) внимательно осматривать")
        wait(4000)
        sampSendChat("/do На бланке не найдено ошибок")
        wait(4000)
        sampSendChat("Хорошо, и я думаю...")
        wait(4000)
        sampSendChat("Вы нам подходите! Сейчас вам выдадут форму и бейджик.")
		end
      }            
    }
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}Пиар отдела в рацию (ИТО) {ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Желаете проводить лекции государственным организациям?', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Тогда тебе в «Инспекцонно-Техничнический Отдел»', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Экзаменатор".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}Пиар отдела в рацию (УДО) {ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Надоело сидеть в офисе или мало клиентов?', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Тогда тебе в «Отдел дополнительных услуг»', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Экзаменатор".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}Проверка степени износа тормозных колодок, дисков и барабанов",
    onclick = function()
	if cfg.main.male == true then
	sampSendChat("/me снял с плеча сумку, положив её на землю")
    wait(3500)
    sampSendChat("/do В сумке присутствует домкрат и набор инструментов")
    wait(3500)
    sampSendChat("/me открутил болты крепления колес")
    wait(3500)
    sampSendChat("/me постучал по колесу, и выдернул его из основания")
	wait(3500)
	sampSendChat("/me Штангерциркулем определил толщину диска")
	wait(3500)
	sampSendChat("/do Толщина состовляет 1,5 - 2,0 мм.")
	wait(3500)
	sampSendChat("/me проверил суппорты и на наличие следов утечки тормозной жидкости")
	wait(3500)
	sampSendChat("/me поставил колесо на болты и затянул их малым усилием, отпустив домкрат затянул болты")
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
	end
	if cfg.main.male == false then
	sampSendChat("/me сняла с плеча сумку, положив её на землю")
    wait(3500)
    sampSendChat("/do В сумке присутствует домкрат и набор инструментов")
    wait(3500)
    sampSendChat("/me открутила болты крепления колес")
    wait(3500)
    sampSendChat("/me постучала по колесу, и выдернула его из основания")
	wait(3500)
	sampSendChat("/me Штангерциркулем определила толщину диска")
	wait(3500)
	sampSendChat("/do Толщина состовляет 1,5 - 2,0 мм.")
	wait(3500)
	sampSendChat("/me проверила суппорты и на наличие следов утечки тормозной жидкости")
	wait(3500)
	sampSendChat("/me поставила колесо на болты и затянула их малым усилием, отпустив домкрат затянула болты")
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
   title = "{FFFFFF}Собеседование",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
    wait(5000)
    sampSendChat("/gov [Instructors]: Уважаемые жители штата, пожалyйста, прослyшайте объявление.")
    wait(5000)
    sampSendChat('/gov [Instructors]: В данный момент в офисе Автошколы проходит собеседование на должность "Стажер".')
    wait(5000)
    sampSendChat("/gov [Instructors]: Требования к соискателям: Шесть лет проживания в штате, стрессоустойчивость, опрятный вид.")
    wait(5000)
    sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Заработок Малоимущим",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Instructors] Уважаемые жители и гости штата, пожалуйста, минуточку внимания. ")
        wait(5000)
        sampSendChat('/gov [Instructors]: В данный момент на оф.портале Автошколы открыта тема "Заработок Малоимущим".')
        wait(5000)
        sampSendChat("/gov [Instructors]: Cо всеми подробностями вы можете ознакомиться на оф.портале. ")
        wait(5000)
        sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Стажировка",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Instructors] Уважаемые жители и гости штата, пожалуйста, минуточку внимания. ")
        wait(5000)
        sampSendChat('/gov [Instructors]: При прохождении стажировки в автошколе, вы можете получить 100.000.')
        wait(5000)
        sampSendChat("/gov [Instructors]: Cо всеми подробностями вы можете ознакомиться на оф.портале.")
        wait(5000)
        sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Вип карта клиента",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
    wait(5000)
    sampSendChat("/gov [Instructors] Уважаемые жители и гости штата, пожалуйста, минуточку внимания. ")
    wait(5000)
    sampSendChat('/gov [Instructors]: В данный момент на оф.портале Автошколы открыта тема "Вип карта клиента"')
    wait(5000)
    sampSendChat("/gov [Instructors]: Cо всеми подробностями вы можете ознакомиться на оф.портале. ")
    wait(5000)
    sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Заявка на экзаменатора",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Instructors]: Уважаемые жители штата, пожалyйста, прослyшайте объявление.")
        wait(5000)
        sampSendChat('/gov [Instructors]: В данный момент открыты заявления на должность "Экзаменатор".')
        wait(5000)
        sampSendChat("/gov [Instructors]: Со всеми критериями, Вы можете ознакомиться на оф.портале штата. ")
        wait(5000)
        sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Пиар филиала мэрии",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Instructors]: Уважаемые жители штата, пожалyйста, прослyшайте объявление.")
        wait(5000)
        sampSendChat('/gov [Instructors]: Автошкола расширяется и предоставляет услуги по выдаче лицензий в нашем филиале.')
        wait(5000)
        sampSendChat('/gov [Instructors]: Филиал находится на первом этаже Мэрии. С уважением, '..rank..' Автошколы - '..myname:gsub('_', ' ')..'.')
        wait(5000)
        sampSendChat("/d OG, освободил волну государственных новостей.")
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
   title = "{FFFFFF}Возражения на гос.волну",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Занимаю гос.волну на X. Возражения на п.")
	end
   },
   {
   title = "{FFFFFF}Занять гос. волну",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Возражений не поступило. Занимаю гос.волну на X")
	end
   },
   {
   title = "{FFFFFF}Напомнить о займе гос. волны",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Напоминаю что волна гос.новостей на X за Inst.")
	end
   },
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Вы ранее не получали входящих сообщений.", 0x046D63)
	end
end

function fthmenu(id)
 return
{
  {
    title = "{FFFFFF}Лекция для {008B8B}Стажёра",
    onclick = function()
	    sampSendChat("Приветствую. Вы приняты на Стажировку в Автошколу. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/me передал(а) бейджик Стажера Автошколы ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 23 ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Стажировка длится до того момента, пока вы не будете повышены до Консультанта. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Запрещено просить повышения или назначения на управляющую должность в любой форме. Как придет срок Вас вызовут. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Обязанности стажёров: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Смотреть как работают коллеги и учиться у них. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В рабочее время находиться в офисе. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Изучать устав и правила автошколы. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Для повышения в должности, Вам нужно будет сдать экзамен.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Всего у вас будет один экзамен - для повышения до консультанта. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Экзамен состоит из двух частей: Устав и расценки на лицензии. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Экзамен состоится не раньше чем через 3 часа после принятия.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b Устав и расценки на лицензии можно найти на форуме. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Дабы отбросить частые вопросы:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Стажер может выдавать только права. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Стажерами считаются сотрудники, находящиеся на должности Стажёр и Экзаменатор (по заявке). ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Офис разрешено покидать только с разрешения ст. Состава. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вертолет можно брать тоже только с разрешения ст. Состава. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("За столами спать запрещено. Спать разрешено только в комнате отдыха. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b В теме "Помощь для новичков" есть все нужные бинды, без них не работать! ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если возникнут вопросы обращайтесь к ст. Составу. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Спасибо,что прослушали мою лекцию. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если у вас имеются вопросы, задавайте. ")
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
    title = "{FFFFFF}Лекция для {008B8B}Экзаменатора",
    onclick = function()
	sampSendChat("Приветствую")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Поскольку вы приняты по заявке на должность Экзаменатора, вам необходимо определиться с отделом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 10")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ИТО - Отдел занимается проверкой государственных организаций")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("С участием транспорта, через проведение лекций и проверок гос. структур")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ОДУ - Отдел занимается доставкой лицензий госудрственным структурам штата Evolve")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("После 4-х дней активной работы.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вы получите бейджик Мл.Инструктора и будете считаться полноценным сотрудником.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Запрещено просить повышения или назначения на управляющую должность в любой форме.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Как придет срок Вашего повышения - обратитесь к ст. Составу")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Офис разрешено покидать только с разрешения ст. Состава.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вертолет можно брать тоже только с разрешения ст. Состава.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("За столами спать запрещено. Спать разрешено только в комнате отдыха.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Стажерами считаются сотрудники, находящиеся на должности Стажёр и Экзаменатор (по заявке).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('/b В теме "Помощь для новичков" есть все нужные бинды, без них не работать!')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если возникнут вопросы обращайтесь к ст. Составу.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Спасибо, что прослушали мою лекцию.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если у вас имеются вопросы, задавайте. ")
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
    title = "{FFFFFF}Лекция про {008B8B}ПДД",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "ПДД". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Каждый водитель должен быть пристегнут ремнем безопасности... ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... и только после этого начинать движение. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Водитель обязан пропускать пешеходов в специальных местах для перехода. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В случае, если кончается бензин или поломка двигателя необходимо сдвинуть автомобиль...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...или доехать до обочины и дождаться механика. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В Штате установлен скоростной режим: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В пределах города разрешается движение транспортных средств со скоростью не более 50 км/ч.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В жилых зонах и на дворовых территориях скорость движения не более 30 км/ч.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("За пределами городов и на автомагистралях ограничений по скорости нет. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если произошло ДТП, водитель обязан вызвать полицию и ждать приезда сотрудников. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Обгон ТС разрешен только с левой стороны, при этом водитель обязан убедиться...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("... что встречная полоса свободна для обгона. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Запрещена парковка в неположенных местах. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Разрешено парковаться: Обочина дороги, специально для этого отведенные места (стоянки). ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Водителю запрещается: ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Пересекать сплошную полосу. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Превышать допустимую скорость на определенном участке дороги. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Покидать место ДТП без договоренности с другим участником этого ДТП. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Создавать помехи другим транспортным средствам. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Садится за руль в нетрезвом состоянии. ")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этом лекция окончена. Спасибо за внимание.")
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
    title = "{FFFFFF}Лекция про {008B8B}Правила этикета",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Здравствуйте, уважаемые коллеги. Сейчас я Вам прочту лекцию на тему: «Правила этикета в нашей организации».')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Первым делом, после того как Вы прибыли на рабочее место…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("… Вам необходимо переодеться и по приветствовать своих коллег")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Не зависимо от ситуации, Вы должны сохранять спокойствие и…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…уважение к человеку, с кем ведёте диалог. На личность переходить…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…категорически запрещено. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ко всем сотрудникам и гражданам, в строгом порядке необходимо…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…обращаться на «Вы» и не в коем случае на «Ты».")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вежливо и грамотно предлагать услуги инструктора, вошедшим в…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…здание, но не кричать за стойкой.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Пользоваться рацией необходимо, только в рабочих целях…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…разговоры не по работе будут строго наказываться.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ну и конечно же по уходу с рабочего места, необходимо вежливо…")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…попрощаться с коллегами.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этом лекция подошла к своему логическому завершению…")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("…Спасибо за внимание.")
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
    title = "{FFFFFF}Лекция про {008B8B}Правильное обращение с оружием",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "Обращение с оружием".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Гражданам запрещено носить оружие не имея на него лицензию")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Для сотрудников силовых структур делается исключение. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Оружие разрешено использовать в случае:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.Самообороны, при нападении на вас. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Для выполнения своих служебных обязанностей.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.По прямому приказу людей, имеющих на это полномочия. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Тем не менее, существует ряд запретов связанных с оружием: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1.Запрещено носить оружие в открытом виде в многолюдных местах. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Запрещено приобретать оружие незаконно. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3.Запрещено расстреливать жителей без весомой причины.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("4.Запрещено использвать оружие для достижения личных целей. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В случае нарушения этих правил, у вас будет изъята лицензия. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Так же за подобные нарушения вас могут заключить под стражу. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этом все, спасибо за внимание.")
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
    title = "{FFFFFF}Лекция про {008B8B}Правила управления водным транспортом",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "Правила управления водным транспортом".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Прежде, чем отправится в плавание вы должны:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Убедиться в исправности мотора.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Проверить, нет ли водотечности в корпусе судна.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Проверить, не забыли ли вы взять с собой лицензию на право управления водным транспортом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Позаботиться о спасательных средствах для каждого человека в лодке (катере).")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. Запрещается:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Передавать управление водным транспортом другому лицу без соответствующих на то документов, особенно детям.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Выходить в плавание в условия ограниченной видимости, если ваша лодка не оборудована сигнальными огнями.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Перевозить людей в нетрезвом состоянии.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Создавать помехи для плавания судов.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Перемещение с одного судна на другое во время их движения.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Перевозить взрывоопасные и огнеопасные грузы на судах, для этого не предназначенных.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Принимать перед выходом наркотические вещества, спиртные напитки, тонизирующие лекарства и препараты.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ослаблять бдительность и внимание в процессе управления водным транспортом.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этом все, спасибо за внимание.")
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
    title = '{FFFFFF}Лекция {008B8B}"Как вести себя в экстремальных ситуациях"',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "Как себя вести в экстремальных ситуациях".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Тормоза придумали трусы, а умные ещё и «нафаршировали» их электроникой.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Так говорят люди, которые зачастую погибают.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Тормоз это пожалуй одна из главных частей автомобиля.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Самыми распространёнными причинами отказа тормозов являются...")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("...потеря тормозной жидкости из-за негерметичности системы.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Но вне зависимости от причин, следствие одно - автомобиль не возможно остановить обычным способом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("- Поэтому нужно использовать один из следующих вариантов: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Торможение двигателем.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Нужно применить торможение двигателем, то есть постепенно понижать передачи одну за другой.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2.Включение первой передачи или «паркинга».")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если другого выхода нет, то можно замедлить машину перейдя на первую передачу и заглушив двигатель.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("3. Контактное торможение.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Остановка с помощью препятствий бывает двух видов: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Первый, когда нет угрозы жизни, и есть возможность замедлить движение.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Это можно сделать, выехав на обочину или притираясь к бордюру.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Вторая самая критическая ситуация.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Когда продолжение движения может вызвать необратимые последствия.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Нужно тормозить в препятствие.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Оптимально для этого подойдут кусты или сугробы, хуже заборы и отбойники.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("И самое последнее, другие автомобили, фонарные столбы, остановки.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Это были самые основные способы остановки автомобиля.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Главное не паниковать и вы сможете спасти свою и возможно чью-то жизнь.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("На этом всё, спасибо за внимание, берегите себя и своих близких.")
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
    title = "{FFFFFF}Лекция про {008B8B}Правила рыбной ловли",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "Правила рыбной ловли".')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Правила рыбной ловли:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ловить рыбу разрешается только в разрешенных местах. (причал на пляже г.Лос-Сантос и за гольф клубом в г.Лас-Вентурас)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Рыбная ловля разрешена только разрешёнными орудиями ужения. (одна удочка с одним крючком либо спиннинг)")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Рыбная ловля разрешена исключительно в черте населенного пункта.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("2. Запрещается:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ловить рыбу с лодки.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ловить рыбу с применением взрывчатых и отравляющих веществ, с помощью электротока, с использованием колющих орудий.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ловить рыбу без наличия лицензии рыболова.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ловить рыбу в радиусе 500 метров от хозяйств, разводящих рыбу.")
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
    title = "{FFFFFF}Лекция про {008B8B}Пилотирование",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Сейчас я проведу лекцию на тему "Пилотирование". ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("1. Правила пилотирования: ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("При совершении полета нужно четко выполнять все инструкции и не отклоняться от выбранного курса. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Перед началом полета надо проверить технику на которой вы будете совершать полет. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Тренировочные полеты совершаются только при опытных пилотах. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Принимать перед вылетом наркотические вещества, спиртные напитки, тонизирующие лекарства и препараты.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ослаблять бдительность и внимание в процессе полета. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Полеты в запретных и опасных зонах, информации о которых нет на полетных картах. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Полет над населенными пунктами и скоплениями людей на открытой местности на высоте менее 300 метров.")
       wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Сближение самолетов ближе установленных правил расстояний. ")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этом все, спасибо за внимание.")
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
	local parolb = imgui.ImBool(cfg.main.parolb)
	local parolf = imgui.ImBuffer(u8(tostring(cfg.main.parol)), 256)
	local tchatb = imgui.ImBool(cfg.main.tchat)
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
    imgui.Begin(u8'Настройки##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Использовать автотег"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автотег', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Введите ваш Тег.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
    end
	imgui.Text(u8("Инфо-бар продаж лицензий"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Включить/Выключить инфо-бар', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Инфо-бар включен, установить положение /sethud' or 'Инфо-бар выключен')
    end
    imgui.Text(u8("Автологин"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Автологин', parolb) then
	cfg.main.parolb = parolb.v saveData(cfg, 'moonloader/config/instools/config.ini') end; 
        if parolb.v then
        if imgui.InputText(u8'Введите ваш пароль.', parolf, imgui.InputTextFlags.Password) then 
        cfg.main.parol = u8:decode(parolf.v) saveData(cfg, 'moonloader/config/instools/config.ini') end
        if imgui.Button(u8'Узнать пароль') then 
        ftext('Ваш пароль: {9966cc}'..cfg.main.parol) end
    end
    imgui.Text(u8 'Открывать чат на T')
    imgui.SameLine()
    if imadd.ToggleButton(u8'Открывать чат на T', tchatb) then
    saveData(cfg, 'moonloader/config/instools/config.ini') 
    cfg.main.tchat = tchatb.v end   
	imgui.Text(u8("Быстрый ответ на последнее смс"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Быстрый ответ смс', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Клавиша успешно изменена. Старое значение: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Новое значение: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/instools/keys.json')
	end
	imgui.Text(u8("Использовать автоклист"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автоклист', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Выберите значение клиста", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Использовать отыгровку раздевалки"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Использовать отыгровку раздевалки', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Мужские отыгровки"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Мужские отыгровки', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'Задержка в лекциях и отыгровках(сек)', waitbuffer,  4, 10) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Автоскрин лекций/гос.новостей"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Автоскрин лекций', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Сохранить настройки'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Настройки успешно сохранены.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- сохраняем все новые значения в конфиге
    end
    imgui.End()
   end
   if wasKeyPressed(key.VK_T) and cfg.main.tchat and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
            sampSetChatInputEnabled(true)
        end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Устав АШ'), ystwindow)
                for line in io.lines('moonloader\\instools\\ystavnewss.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.ShowCursor = true
            local x, y = getScreenResolution()
            local btn_size = imgui.ImVec2(-0.1, 0)
            imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin('Inst Tools | Main Menu ', second_window, mainw,  imgui.WindowFlags.NoResize)
	if imgui.Button(u8'Биндер', btn_size) then
                bMainWindow.v = not bMainWindow.v
            end
    if imgui.Button(u8'Настройки скрипта', btn_size) then
                first_window.v = not first_window.v
            end
    if imgui.Button(u8 'Сообщить об ошибке/идеи', btn_size) then os.execute('explorer "https://vk.com/ortemelyan"')
    btn_size = not btn_size
    end
    if imgui.Button(u8 'Пожертвование', btn_size) then os.execute('explorer "https://www.donationalerts.com/r/Speqzz"')
    btn_size = not btn_size
    end
    if imgui.Button(u8'Перезагрузить скрипт', btn_size) then
      showCursor(false)
      thisScript():reload()
    end
    if imgui.Button(u8 'Отключить скрипт', btn_size) then
      showCursor(false)
      thisScript():unload()
    end
    if imgui.Button(u8'Помощь', btn_size) then
      helps.v = not helps.v
    end
    imgui.End()
  end
  	if infbar.v then
                _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 140), imgui.Cond.FirstUseEver)
                imgui.Begin('Продано лицензий', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar) 
                imgui.CentrText(u8'Продано лицензий за сеанс:') 
                imgui.Separator()
                imgui.Text(u8 'Продано водительских прав:') imgui.SameLine() imgui.Text(u8 ''..prava..'')
				imgui.Text(u8 'Продано лицензий пилота:') imgui.SameLine() imgui.Text(u8 ''..pilot..'')
				imgui.Text(u8 'Продано лицензий на катера:') imgui.SameLine() imgui.Text(u8 ''..kater..'')
				imgui.Text(u8 'Продано лицензий рыболова:') imgui.SameLine() imgui.Text(u8 ''..ribolov..'')
				imgui.Text(u8 'Продано лицензий на оружие:') imgui.SameLine() imgui.Text(u8 ''..gun..'')
				imgui.Text(u8 'Продано лицензий на бизнес:') imgui.SameLine() imgui.Text(u8 ''..biznes..'')
                imgui.End()
    end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(3, 7))
                imgui.Begin(u8 'Помощь по скрипту', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Список команд", imgui.ImVec2(600, 340), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.TextColoredRGB('{FF0000}/it{CCCCCC} - Открыть меню скрипта')
                imgui.Separator()
                imgui.TextColoredRGB('{FF0000}/vig [id] [Причина]{CCCCCC} - Выдать выговор по рации')
                imgui.TextColoredRGB('{FF0000}/dmb{CCCCCC} - Открыть /members в диалоге')
                imgui.TextColoredRGB('{FF0000}/where [id]{CCCCCC} - Запросить местоположение по рации')
                imgui.TextColoredRGB('{FF0000}/yst{CCCCCC} - Открыть устав АШ')
				imgui.TextColoredRGB('{FF0000}/smsjob{CCCCCC} - Вызвать на работу весь мл.состав по смс')
                imgui.TextColoredRGB('{FF0000}/dlog{CCCCCC} - Открыть лог 25 последних сообщений в департамент')
				imgui.TextColoredRGB('{FF0000}/sethud{CCCCCC} - Установить позицию инфо-бара')
				imgui.TextColoredRGB('{FF0000}/oinv [id]{CCCCCC} - Принять к себе в отдел сотрудника')
                imgui.TextColoredRGB('{FF0000}/lecture [id]{CCCCCC} - Прочитать лекцию об отделе')
                imgui.TextColoredRGB('{FF0000}/adm {CCCCCC} - Альтернативая команда /admins (Доступно для всех)') 
				imgui.TextColoredRGB('{FF0000}/cchat{CCCCCC} - Очищает чат')
				imgui.TextColoredRGB('{FF0000}/blag [id] [фракция] [тип]{CCCCCC} - Выразить игроку благодарность в департамент')
				imgui.TextColoredRGB('{FF0000}/nick [id] [0-1]{CCCCCC} - Копирует ник игрока по его id. Параметр 0 копирует РПник, 1 копирует НОНрп ник')
				imgui.TextColoredRGB('{FF0000}/find [id]{CCCCCC} - Установить на указанного игрока маркер')
				imgui.Separator()
                imgui.TextColoredRGB('Клавиши: ')
                imgui.TextColoredRGB('{FF0000}ПКМ+Z на игрока{CCCCCC} - Меню взаимодействия')
                imgui.TextColoredRGB('{FF0000}F2{CCCCCC} - "Быстрое меню"')
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
                imgui.Begin(u8('Inst Tools | Обновление'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Вышло обновление скрипта Inst Tools до версии '..updversion..'. Что бы обновиться нажмите кнопку внизу.'))
                imgui.Separator()
                imgui.BeginChild("uuupdate", imgui.ImVec2(690, 200))
                for line in ttt:gmatch('[^\r\n]+') do
                    imgui.Text(line)
                end
                imgui.EndChild()
                imgui.Separator()
                imgui.PushItemWidth(305)
                if imgui.Button(u8("Обновить"), imgui.ImVec2(339, 25)) then
                    lua_thread.create(goupdate)
                    updwindows.v = false
                end
                imgui.SameLine()
                if imgui.Button(u8("Отложить обновление"), imgui.ImVec2(339, 25)) then
                    updwindows.v = false
                end
                imgui.End()
            end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | Биндер##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
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
				imgui.TextDisabled(u8("Пустое сообщение ..."))
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
			imgui.Checkbox(u8("Ввод") .. "##editCH" .. k, bIsEnterEdit)
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

	if imgui.Button(u8"Добавить клавишу") then
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

function showHelp(param) -- "вопросик" для скрипта
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
		if wparam == key.VK_ESCAPE then
                if not sampIsChatInputActive() and not sampIsDialogActive() and not sampIsScoreboardOpen() then
                    if second_window.v then second_window.v = false consumeWindowMessage(true, true) end
                    if ystwindow.v then ystwindow.v = false consumeWindowMessage(true, true) end
                    if updwindows.v then updwindows.v = false consumeWindowMessage(true, true) end
                    if memw.v then memw.v = false consumeWindowMessage(true, true) end
                    if bMainWindow.v then bMainWindow.v = false consumeWindowMessage(true, true) end
                    if helps.v then helps.v = false consumeWindowMessage(true, true) end
                    if first_window.v then first_window.v = false consumeWindowMessage(true, true) end
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
        ftext('Введите /r [текст]')
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
        ftext('Введите /f [текст]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x008B8B)
end

function it()
  if frac == 'Driving School' then
  second_window.v = not second_window.v
  else
  ftext('Возможно вы не состоите в автошколе {ff0000}[ctrl+R]')
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
        
function imgui.TextColoredRGB(text)
  local style = imgui.GetStyle()
  local colors = style.Colors
  local ImVec4 = imgui.ImVec4

  local explode_argb = function(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
  end

  local getcolor = function(color)
      if color:sub(1, 6):upper() == 'SSSSSS' then
          local r, g, b = colors[1].x, colors[1].y, colors[1].z
          local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
          return ImVec4(r, g, b, a / 255)
      end
      local color = type(color) == 'string' and tonumber(color, 16) or color
      if type(color) ~= 'number' then return end
      local r, g, b, a = explode_argb(color)
      return imgui.ImColor(r, g, b, a):GetVec4()
  end

  local render_text = function(text_)
      for w in text_:gmatch('[^\r\n]+') do
          local text, colors_, m = {}, {}, 1
          w = w:gsub('{(......)}', '{%1FF}')
          while w:find('{........}') do
              local n, k = w:find('{........}')
              local color = getcolor(w:sub(n + 1, k - 1))
              if color then
                  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                  colors_[#colors_ + 1] = color
                  m = n
              end
              w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
          end
          if text[0] then
              for i = 0, #text do
                  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                  imgui.SameLine(nil, 0)
              end
              imgui.NewLine()
          else imgui.Text(u8(w)) end
      end
  end
  render_text(text)
end

function apply_custom_style()
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2

  style.WindowPadding = imgui.ImVec2(10, 10)
  style.FramePadding = imgui.ImVec2(4, 4)
  style.WindowRounding = 0
  style.ChildWindowRounding = 0
  style.ItemSpacing = imgui.ImVec2(8.0, 5.0)
  style.ItemInnerSpacing = imgui.ImVec2(8, 6)
  style.ScrollbarSize = 13.0
  style.ScrollbarRounding = 0
  style.IndentSpacing = 25.0

  colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
  colors[clr.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
  colors[clr.WindowBg] = ImVec4(0.11, 0.10, 0.11, 1.00)
  colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.PopupBg] = ImVec4(0.11, 0.10, 0.11, 1.00)
  colors[clr.Border] = ImVec4(0.86, 0.86, 0.86, 1.00)
  colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.FrameBg] = ImVec4(0.21, 0.20, 0.21, 0.60)
  colors[clr.FrameBgHovered] = ImVec4(0.68, 0.25, 0.25, 0.75)
  colors[clr.FrameBgActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.TitleBg] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.TitleBgActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.MenuBarBg] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.ScrollbarBg] = ImVec4(0.56, 0.56, 0.58, 0.00)
  colors[clr.ScrollbarGrab] = ImVec4(0.56, 0.56, 0.58, 0.44)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 0.74)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.ComboBg] = ImVec4(0.15, 0.14, 0.15, 1.00)
  colors[clr.CheckMark] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.SliderGrab] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.SliderGrabActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.Button] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.ButtonHovered] = ImVec4(0.68, 0.25, 0.25, 0.75)
  colors[clr.ButtonActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.Header] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.HeaderHovered] = ImVec4(0.68, 0.25, 0.25, 0.75)
  colors[clr.HeaderActive] = ImVec4(0.68, 0.25, 0.25, 1.00)
  colors[clr.ResizeGrip] = ImVec4(1.00, 1.00, 1.00, 0.30)
  colors[clr.ResizeGripHovered] = ImVec4(1.00, 1.00, 1.00, 0.60)
  colors[clr.ResizeGripActive] = ImVec4(1.00, 1.00, 1.00, 0.90)
  colors[clr.CloseButton] = ImVec4(0.56, 0.56, 0.58, 0.75)
  colors[clr.CloseButtonHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.CloseButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.PlotLines] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.PlotLinesHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.PlotHistogram] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.PlotHistogramHovered] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.TextSelectedBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.ModalWindowDarkening] = ImVec4(0.00, 0.00, 0.00, 0.00)
end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{ffffff}» Инструктор",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{008B8B}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Цены лицензий",
        onclick = function()
        pID = tonumber(args)
	    pX, pY, pZ = getCharCoordinates(playerPed)
	    if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or rank == 'Управляющий' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(pricemenu(id), "{008B8B}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Вы должны находиться за стойкой')
		end
        end
      },
      {
        title = "{ffffff}» Вопросы",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(questimenu(id), "{008B8B}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Вы должны находиться за стойкой')
		end
        end
      },
      {
        title = "{ffffff}» Оформление",
        onclick = function()
        pID = tonumber(args)
		pX, pY, pZ = getCharCoordinates(playerPed)
		if sampGetPlayerNickname(Damien_Requeste) or dostavka or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' or getDistanceBetweenCoords3d(pX, pY, pZ, 2345.4177, 1667.5751, 3040.9524) < 2 or getDistanceBetweenCoords3d(pX, pY, pZ, 357.9535, 173.4858, 1008.3893) < 6 then
        submenus_show(oformenu(id), "{008B8B}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
	    ftext('Вы должны находиться за стойкой')
        end
		end
      },
	  {
        title = "{ffffff}» Ударить шокером",
        onclick = function()
		if cfg.main.male == true then
        sampSendChat("/me снял шокер с пояса")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me повесил шокер на пояс")
        end
	    if cfg.main.male == false then
        sampSendChat("/me сняла шокер с пояса")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me повесила шокер на пояс")
        end
		end
      }
    }
end

function questimenu(args)
    return
    {
      {
        title = '{5b83c2}« Раздел вопросов по ПДД »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Пару вопросов',
        onclick = function()
          sampSendChat("Сейчас я задам вам пару вопросов по ПДД. Готовы?")
		end
      },
      {
        title = '{ffffff}» Город{ff0000} 50 км/ч',
        onclick = function()
        sampSendChat("Какая максимальная скорость разрешена в городе?")
        end
      },
      {
        title = '{ffffff}» Жилая местность{ff0000} 30 км/ч',
        onclick = function()
        sampSendChat("Какая максимальная скорость разрешена в жилой местности?")
        end
      },
      {
        title = '{ffffff}» Обгон{ff0000} с левой стороны.',
        onclick = function()
        sampSendChat("С какой стороны разрешен обгон?")
        end
      },
      {
        title = '{ffffff}» ДТП',
        onclick = function()
        sampSendChat("Вы попали в ДТП. Ваши действия?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Оказать первую помощь пострадавшим. Вызвать МЧС и ПД и ждать их прибытия.", -1)
        end
      },
	  {
        title = '{ffffff}» Действия при остановке',
        onclick = function()
        sampSendChat("За вами едет автомобиль с включённой сиреной. Ваши действия?")
		wait(1500)
		ftext("{FFFFFF}- Правильный ответ: {A52A2A}Сбавить скорость и прижаться к обочине.", -1)
        end
      },
	  {
        title = '{5b83c2}« Раздел других вопросов»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}Цель ношения оружия',
        onclick = function()
        sampSendChat("Зачем вам лицензия на оружие?")
        end
      },
	  {
        title = '{ffffff}Хранение оружия',
        onclick = function()
        sampSendChat("Где вы будете хранить оружие?")
        end
      }
    }
end

function oformenu(id)
    return
    {
      {
        title = '{5b83c2}« Раздел оформления »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Права.',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал(а) чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		  sampSendChat("/givelicense "..id)
		  wait(1700)
		  sampCloseCurrentDialogWithButton(1)
		  wait(1700)
		  sampSendChat("Удачи на дорогах.")
		  if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
		  dostavka = false
		  end
		end
      },
      {
        title = '{ffffff}» Рыбалка',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал(а) чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{ffffff}» Пилот',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{ffffff}» Оружие{ff0000} со 2 уровня.',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал(а) чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{ffffff}» Катер',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{ffffff}» Бизнес',
        onclick = function()
          sampSendChat("/do Кейс с документами в руках инструктора.")
		  wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал(а) чистый бланк и начал его заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Лицензия в руке.")
		  wait(1700)
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{ffffff}» Оформление комплекта',
        onclick = function()
        sampSendChat("/do Кейс с документами в руках инструктора.")
		wait(1700)
		  sampSendChat("/me приоткрыл(а) кейс, после чего достал(а) стопку чистых бланков и начал их заполнять")
		  wait(1700)
		  sampSendChat("/me записал(а) паспортные данные покупателя")
		  wait(1700)
		  sampSendChat("/do Стопка лицензий в руке.")
		  wait(1700)
		sampSendChat('/me проставил(а) печати "Autoschool San Fierro" и передал(а) лицензии '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
        title = '{5b83c2}« Раздел стоимости »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Права.',
        onclick = function()
		if gmegaflvl <= 2 then
          sampSendChat("Стоимость лицензии на права составляет - 500$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl <= 5 then
		  sampSendChat("Стоимость лицензии на права составляет - 5.000$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl <= 15 then
		  sampSendChat("Стоимость лицензии на права составляет - 10.000$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl >= 16 then
		  sampSendChat("Стоимость лицензии на права составляет - 30.000$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
        end
		end
		end
		end
		end
      },
      {
        title = '{ffffff}» Рыбалка',
        onclick = function()
        sampSendChat("Стоимость лицензии на рыбалку составляет - 2.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Пилот',
        onclick = function()
        sampSendChat("Стоимость лицензии на пилотирование составляет - 10.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Оружие{ff0000} со 2 уровня.',
        onclick = function()
		if gmegaflvl > 1 then
        sampSendChat("Стоимость лицензии на оружие составляет - 50.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
		else
		sampSendChat("Данную лицензию можно приобрести с 2-х лет в штате.")
		end
        end
      },
	  {
        title = '{ffffff}» Бизнес{ff0000} при наличии бизнеса.',
        onclick = function()
        sampSendChat("Стоимость лицензии на бизнес составляет - 100.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Катер',
        onclick = function()
        sampSendChat("Стоимость лицензии на водные транспорты составляет - 5.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Комплект',
        onclick = function()
        sampSendChat("Рыболовство - 2.000$, Катер - 5.000$, Лицензия пилота - 10.000$, Лицензия на оружие - 50.000$.")
        end
      }
    }
end

function instmenu(id)
    return
    {
      {
        title = '{5b83c2}« Раздел инструктора »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Приветствие.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Здравствуйте. Я сотрудник автошколы "..myname:gsub('_', ' ')..", чем могу помочь?")
		wait(1500)
		sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')  
		end
      },
      {
        title = '{ffffff}» Паспорт',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Ваш паспорт, пожалуйста.")
		wait(1500)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{ffffff}» Попрощаться с клиентом',
        onclick = function()
        sampSendChat("Спасибо за покупку, всего Вам доброго.")
        end
      }
    }
end
function ystf()
    if not doesFileExist('moonloader/instools/ystavnewss.txt') then
        local file = io.open("moonloader/instools/ystavnewss.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Гражданский',
        [1] = 'Гражданский',
        [2] = 'Гражданский',
        [3] = 'Гражданский',
        [4] = 'Гражданский',
        [5] = 'Гражданский',
        [6] = 'Гражданский',
        [7] = 'Гражданский',
        [8] = 'Гражданский',
        [9] = 'Гражданский',
        [10] = 'Гражданский',
        [11] = 'Гражданский',
        [12] = 'Гражданский',
        [13] = 'Гражданский',
        [14] = 'Гражданский',
        [15] = 'Гражданский',
        [16] = 'Гражданский',
        [17] = 'Гражданский',
        [18] = 'Гражданский',
        [19] = 'Гражданский',
        [20] = 'Гражданский',
        [21] = 'Ballas',
        [22] = 'Гражданский',
        [23] = 'Гражданский',
        [24] = 'Гражданский',
        [25] = 'Гражданский',
        [26] = 'Гражданский',
        [27] = 'Гражданский',
        [28] = 'Гражданский',
        [29] = 'Гражданский',
        [30] = 'Rifa',
        [31] = 'Гражданский',
        [32] = 'Гражданский',
        [33] = 'Гражданский',
        [34] = 'Гражданский',
        [35] = 'Гражданский',
        [36] = 'Гражданский',
        [37] = 'Гражданский',
        [38] = 'Гражданский',
        [39] = 'Гражданский',
        [40] = 'Гражданский',
        [41] = 'Aztec',
        [42] = 'Гражданский',
        [43] = 'Гражданский',
        [44] = 'Aztec',
        [45] = 'Гражданский',
        [46] = 'Гражданский',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Гражданский',
        [50] = 'Гражданский',
        [51] = 'Гражданский',
        [52] = 'Гражданский',
        [53] = 'Гражданский',
        [54] = 'Гражданский',
        [55] = 'Гражданский',
        [56] = 'Grove',
        [57] = 'Мэрия',
        [58] = 'Гражданский',
        [59] = 'Автошкола',
        [60] = 'Гражданский',
        [61] = 'Армия',
        [62] = 'Гражданский',
        [63] = 'Гражданский',
        [64] = 'Гражданский',
        [65] = 'Гражданский', -- над подумать
        [66] = 'Гражданский',
        [67] = 'Гражданский',
        [68] = 'Гражданский',
        [69] = 'Гражданский',
        [70] = 'МОН',
        [71] = 'Гражданский',
        [72] = 'Гражданский',
        [73] = 'Army',
        [74] = 'Гражданский',
        [75] = 'Гражданский',
        [76] = 'Гражданский',
        [77] = 'Гражданский',
        [78] = 'Гражданский',
        [79] = 'Гражданский',
        [80] = 'Гражданский',
        [81] = 'Гражданский',
        [82] = 'Гражданский',
        [83] = 'Гражданский',
        [84] = 'Гражданский',
        [85] = 'Гражданский',
        [86] = 'Grove',
        [87] = 'Гражданский',
        [88] = 'Гражданский',
        [89] = 'Гражданский',
        [90] = 'Гражданский',
        [91] = 'Гражданский', -- под вопросом
        [92] = 'Гражданский',
        [93] = 'Гражданский',
        [94] = 'Гражданский',
        [95] = 'Гражданский',
        [96] = 'Гражданский',
        [97] = 'Гражданский',
        [98] = 'Мэрия',
        [99] = 'Гражданский',
        [100] = 'Байкер',
        [101] = 'Гражданский',
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
        [121] = 'Гражданский',
        [122] = 'Гражданский',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Гражданский',
        [129] = 'Гражданский',
        [130] = 'Гражданский',
        [131] = 'Гражданский',
        [132] = 'Гражданский',
        [133] = 'Гражданский',
        [134] = 'Гражданский',
        [135] = 'Гражданский',
        [136] = 'Гражданский',
        [137] = 'Гражданский',
        [138] = 'Гражданский',
        [139] = 'Гражданский',
        [140] = 'Гражданский',
        [141] = 'FBI',
        [142] = 'Гражданский',
        [143] = 'Гражданский',
        [144] = 'Гражданский',
        [145] = 'Гражданский',
        [146] = 'Гражданский',
        [147] = 'Мэрия',
        [148] = 'Гражданский',
        [149] = 'Grove',
        [150] = 'Мэрия',
        [151] = 'Гражданский',
        [152] = 'Гражданский',
        [153] = 'Гражданский',
        [154] = 'Гражданский',
        [155] = 'Гражданский',
        [156] = 'Гражданский',
        [157] = 'Гражданский',
        [158] = 'Гражданский',
        [159] = 'Гражданский',
        [160] = 'Гражданский',
        [161] = 'Гражданский',
        [162] = 'Гражданский',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Гражданский',
        [168] = 'Гражданский',
        [169] = 'Yakuza',
        [170] = 'Гражданский',
        [171] = 'Гражданский',
        [172] = 'Гражданский',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Гражданский',
        [177] = 'Гражданский',
        [178] = 'Гражданский',
        [179] = 'Army',
        [180] = 'Гражданский',
        [181] = 'Байкер',
        [182] = 'Гражданский',
        [183] = 'Гражданский',
        [184] = 'Гражданский',
        [185] = 'Гражданский',
        [186] = 'Yakuza',
        [187] = 'Мэрия',
        [188] = 'СМИ',
        [189] = 'Гражданский',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Гражданский',
        [193] = 'Aztec',
        [194] = 'Гражданский',
        [195] = 'Ballas',
        [196] = 'Гражданский',
        [197] = 'Гражданский',
        [198] = 'Гражданский',
        [199] = 'Гражданский',
        [200] = 'Гражданский',
        [201] = 'Гражданский',
        [202] = 'Гражданский',
        [203] = 'Гражданский',
        [204] = 'Гражданский',
        [205] = 'Гражданский',
        [206] = 'Гражданский',
        [207] = 'Гражданский',
        [208] = 'Yakuza',
        [209] = 'Гражданский',
        [210] = 'Гражданский',
        [211] = 'СМИ',
        [212] = 'Гражданский',
        [213] = 'Гражданский',
        [214] = 'LCN',
        [215] = 'Гражданский',
        [216] = 'Гражданский',
        [217] = 'СМИ',
        [218] = 'Гражданский',
        [219] = 'МОН',
        [220] = 'Гражданский',
        [221] = 'Гражданский',
        [222] = 'Гражданский',
        [223] = 'LCN',
        [224] = 'Гражданский',
        [225] = 'Гражданский',
        [226] = 'Rifa',
        [227] = 'Мэрия',
        [228] = 'Гражданский',
        [229] = 'Гражданский',
        [230] = 'Гражданский',
        [231] = 'Гражданский',
        [232] = 'Гражданский',
        [233] = 'Гражданский',
        [234] = 'Гражданский',
        [235] = 'Гражданский',
        [236] = 'Гражданский',
        [237] = 'Гражданский',
        [238] = 'Гражданский',
        [239] = 'Гражданский',
        [240] = 'Автошкола',
        [241] = 'Гражданский',
        [242] = 'Гражданский',
        [243] = 'Гражданский',
        [244] = 'Гражданский',
        [245] = 'Гражданский',
        [246] = 'Байкер',
        [247] = 'Байкер',
        [248] = 'Байкер',
        [249] = 'Гражданский',
        [250] = 'СМИ',
        [251] = 'Гражданский',
        [252] = 'Army',
        [253] = 'Гражданский',
        [254] = 'Байкер',
        [255] = 'Army',
        [256] = 'Гражданский',
        [257] = 'Гражданский',
        [258] = 'Гражданский',
        [259] = 'Гражданский',
        [260] = 'Гражданский',
        [261] = 'СМИ',
        [262] = 'Гражданский',
        [263] = 'Гражданский',
        [264] = 'Гражданский',
        [265] = 'Полиция',
        [266] = 'Полиция',
        [267] = 'Полиция',
        [268] = 'Гражданский',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Гражданский', -- надо подумать
        [274] = 'МОН',
        [275] = 'МОН',
        [276] = 'МОН',
        [277] = 'Гражданский',
        [278] = 'Гражданский',
        [279] = 'Гражданский',
        [280] = 'Полиция',
        [281] = 'Полиция',
        [282] = 'Полиция',
        [283] = 'Полиция',
        [284] = 'Полиция',
        [285] = 'Полиция',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Полиция',
        [289] = 'Гражданский',
        [290] = 'Гражданский',
        [291] = 'Гражданский',
        [292] = 'Aztec',
        [293] = 'Гражданский',
        [294] = 'Гражданский',
        [295] = 'Гражданский',
        [296] = 'Гражданский',
        [297] = 'Grove',
        [298] = 'Гражданский',
        [299] = 'Гражданский',
        [300] = 'Полиция',
        [301] = 'Полиция',
        [302] = 'Полиция',
        [303] = 'Полиция',
        [304] = 'Полиция',
        [305] = 'Полиция',
        [306] = 'Полиция',
        [307] = 'Полиция',
        [308] = 'МОН',
        [309] = 'Полиция',
        [310] = 'Полиция',
        [311] = 'Полиция'
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
                        ftext('Обнаружено обновление до версии '..updversion..'.')
					    updwindows.v = true
                        canupdate = true
                    else
                        print('Обновлений скрипта не обнаружено. Приятной игры.')
                        update = false
				    end
			    end
		    end
	    end
    end)
end


function smsjob()
  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' На данный момент сотрудников на работе мало. Поэтому держите путь на работу!')
            wait(1200)
        end
        players2 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else 
	ftext('Данная команда доступна с 7 ранга')
	end
end

function goupdate()
    ftext('Началось скачивание обновления. Скрипт перезагрузится через пару секунд.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        showCursor(false)
	    thisScript():reload()
    end
end)
end

function cmd_color() -- функция получения цвета строки, хз зачем она мне, но когда то юзал
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Цвет последней строки чата - {934054}[%d] (скопирован в буфер обмена)",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors = 
        {
		[1] = 'Зелёный',
		[2] = 'Светло-зелёный',
		[3] = 'Ярко-зелёный',
		[4] = 'Бирюзовый',
		[5] = 'Жёлто-зелёный',
		[6] = 'Темно-зелёный',
		[7] = 'Серо-зелёный',
		[8] = 'Красный',
		[9] = 'Ярко-красный',
		[10] = 'Оранжевый',
		[11] = 'Коричневый',
		[12] = 'Тёмно-красный',
		[13] = 'Серо-красный',
		[14] = 'Жёлто-оранжевый',
		[15] = 'Малиновый',
		[16] = 'Розовый',
		[17] = 'Синий',
		[18] = 'Голубой',
		[19] = 'Синяя сталь',
		[20] = 'Сине-зелёный',
		[21] = 'Тёмно-синий',
		[22] = 'Фиолетовый',
		[23] = 'Индиго',
		[24] = 'Серо-синий',
		[25] = 'Жёлтый',
		[26] = 'Кукурузный',
		[27] = 'Золотой',
		[28] = 'Старое золото',
		[29] = 'Оливковый',
		[30] = 'Серый',
		[31] = 'Серебро',
		[32] = 'Черный',
		[33] = 'Белый',
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
            ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('Рабочий день начат') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Цвет ника сменен на: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me открыл шкафчик")
                wait(1500)
                sampSendChat("/me снял свою одежду, после чего сложил ее в шкаф")
                wait(1500)
                sampSendChat("/me взял рабочую одежду, затем переоделся в нее")
                wait(1500)
                sampSendChat("/me нацепил бейджик на рубашку")
                wait(1500)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')  
				end
				if cfg.main.male == false then
				sampSendChat("/me открыла шкафчик")
                wait(1500)
                sampSendChat("/me сняла свою одежду, после чего сложила ее в шкаф")
                wait(1500)
                sampSendChat("/me взяла рабочую одежду, затем переоделась в нее")
                wait(1500)
                sampSendChat("/me нацепила бейджик на рубашку")
                wait(1500)
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Отправитель:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Отправитель: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Рабочий день окончен') and color ~= -1 then
        rabden = false
    end
	if text:find('приобрел лицензию на воздушный транспорт') then
        local Nicks = text:match('Игрок (.+) приобрел лицензию на воздушный транспорт. Сумма добавлена к зарплате.')
		pilot = pilot + 1
   end
   	if text:find('приобрел водительские права') then
        local Nicks = text:match('Игрок (.+) приобрел водительские права. Сумма добавлена к зарплате.')
		prava = prava + 1
   end
   	if text:find('приобрел лицензию на рыболовство') then
        local Nicks = text:match('Игрок (.+) приобрел лицензию на рыболовство. Сумма добавлена к зарплате.')
		ribolov = ribolov + 1
   end
   	if text:find('приобрел лицензию на морской транспорт') then
        local Nicks = text:match('Игрок (.+) приобрел лицензию на морской транспорт. Сумма добавлена к зарплате.')
		kater = kater + 1
   end
   	if text:find('приобрел лицензию на оружие') then
        local Nicks = text:match('Игрок (.+) приобрел лицензию на оружие. Сумма добавлена к зарплате.')
		gun = gun + 1
   end
   	if text:find('приобрел лицензию на бизнес') then
        local Nicks = text:match('Игрок (.+) приобрел лицензию на открытие бизнеса. Сумма добавлена к зарплате.')
		biznes = biznes + 1
   end
	if text:find('Вы выгнали (.+) из организации. Причина: (.+)') then
        local un1, un2 = text:match('Вы выгнали (.+) из организации. Причина: (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - Уволен(а) по причине "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - Уволен(а) по причине "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('передал(- а) удостоверение (.+)') then
        local inv1, inv2 = text:match('передал(- а) удостоверение (.+)')
		lua_thread.create(function()
		wait(5000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: Новый сотрудник Автошколы - %s. Добро пожаловать.', cfg.main.tarr, inv1:gsub('_', ' '), inv2))
        else
		sampSendChat(string.format('/r Новый сотрудник Автошколы - %s. Добро пожаловать.', inv1:gsub('_', ' '), inv2))
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
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
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
            if stat:find('Выходной') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Всего: %d+ человек') then
			local count = text:match('Всего: (%d+) человек')
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