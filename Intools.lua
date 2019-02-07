<<<<<<< HEAD
п»їscript_name('Inst Tools')
script_version('2.4')
script_author('Damien_Requeste')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- загружаем библиотеку
local encoding = require 'encoding' -- загружаем библиотеку
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
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- указываем кодировку по умолчанию, она должна совпадать с кодировкой файла. CP1251 - это Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "ITools {ffffff}|"
players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
players2 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
frak = nil
rang = nil
ttt = nil
rabden = false
tload = false
tLastKeys = {}
departament = {}
function apply_custom_style()
  imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

style.Alpha = 1.0
style.ChildWindowRounding = 3
style.WindowRounding = 3
style.GrabRounding = 1
style.GrabMinSize = 20
style.FrameRounding = 3

colors[clr.Text] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextDisabled] = ImVec4(0.00, 0.40, 0.41, 1.00)
colors[clr.WindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.Border] = ImVec4(0.00, 1.00, 1.00, 0.65)
colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg] = ImVec4(0.44, 0.80, 0.80, 0.18)
colors[clr.FrameBgHovered] = ImVec4(0.44, 0.80, 0.80, 0.27)
colors[clr.FrameBgActive] = ImVec4(0.44, 0.81, 0.86, 0.66)
colors[clr.TitleBg] = ImVec4(0.14, 0.18, 0.21, 0.73)
colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.54)
colors[clr.TitleBgActive] = ImVec4(0.00, 1.00, 1.00, 0.27)
colors[clr.MenuBarBg] = ImVec4(0.00, 0.00, 0.00, 0.20)
colors[clr.ScrollbarBg] = ImVec4(0.22, 0.29, 0.30, 0.71)
colors[clr.ScrollbarGrab] = ImVec4(0.00, 1.00, 1.00, 0.44)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.ComboBg] = ImVec4(0.16, 0.24, 0.22, 0.60)
colors[clr.CheckMark] = ImVec4(0.00, 1.00, 1.00, 0.68)
colors[clr.SliderGrab] = ImVec4(0.00, 1.00, 1.00, 0.36)
colors[clr.SliderGrabActive] = ImVec4(0.00, 1.00, 1.00, 0.76)
colors[clr.Button] = ImVec4(0.00, 0.65, 0.65, 0.46)
colors[clr.ButtonHovered] = ImVec4(0.01, 1.00, 1.00, 0.43)
colors[clr.ButtonActive] = ImVec4(0.00, 1.00, 1.00, 0.62)
colors[clr.Header] = ImVec4(0.00, 1.00, 1.00, 0.33)
colors[clr.HeaderHovered] = ImVec4(0.00, 1.00, 1.00, 0.42)
colors[clr.HeaderActive] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGrip] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGripHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ResizeGripActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.CloseButton] = ImVec4(0.00, 0.78, 0.78, 0.35)
colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.78, 0.78, 0.47)
colors[clr.CloseButtonActive] = ImVec4(0.00, 0.78, 0.78, 1.00)
colors[clr.PlotLines] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotLinesHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogramHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.00, 1.00, 1.00, 0.22)
colors[clr.ModalWindowDarkening] = ImVec4(0.04, 0.10, 0.09, 0.51)
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
    tar = 'Стажер',
	tarr = 'тэг',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0
  },
  commands = 
  {
    ticket = false,
	zaderjka = 5000
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
    ftext("Скрипт успешно загружен. /thelp - помощь по командам, /tset - настройки скрипта.", -1)
	ftext('Автором данного скрипта является Damien_Requeste')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{47f4f0}IT {ffffff}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{47f4f0}IT {ffffff}| Файл конфига успешно создан.", -1)
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
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/instools') then createDirectory('moonloader/instools') end
  hk = require 'lib.imcustom.hotkey'
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
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('thelp', thelp)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('tset', tset)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{47f4f0}IT {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{47f4f0}IT {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{47f4f0}IT {ffffff}| Быстрое меню")
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] Уровень - "..sampGetPlayerScore(id).." ")
            end
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v
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

Общее положение Автошколы:

• 1.1 Устав Автошколы устанавливает положения, которым должны следовать все сотрудники Автошколы.
• 1.2 Сотрудники Автошколы обязаны подчиняться старшим по должности.
• 1.3 Сотрудники Автошколы обязаны качественно обслуживать своих клиентов.
• 1.4 Сотрудники Автошколы может выезжать на вызовы гос. структур для продажи лицензий.
• 1.5 Незнание устава не освобождает вас от ответственности.
• 1.6 Запрещены любые разговоры о повышении или назначении на управляющую должность в любой форме ( В любые чаты, в том числе /f, /fb, /b, /sms ).
• 1.7 Устав может быть изменен в любое время Управляющим Автошколы.


[2] Обязанности сотрудников Автошколы:

• 2.1 Сотрудник Автошколы обязан соблюдать Устав Автошколы. 
• 2.2 Сотрудник Автошколы обязан знать и соблюдать все правила и законы штата. 
• 2.3 Сотрудник Автошколы должен следить за соблюдение очередности при обслуживании клиентов.
• 2.4 Сотрудник Автошколы обязан подавать пример идеальным вождением и отличным знанием ПДД.
• 2.5 Сотрудники обязаны носить бейджики согласно принадлежности к тому или иному отделу.
• 2.5.1 Сотрудники старшего состава обязаны носить Бейджик - № 15. 
• 2.5.2 Cотрудники без отдела обязаны носить Бейджик - № 4. 
• 2.5.3 Глава отдела носит Бейджик №12.
• 2.5.4 Заместитель главы отдела стажировки носит Бейджик №25.
• 2.5.5 Сотрудник Отдела Инспекции обязан носить Бейджик №21.
• 2.5.6 Сотрудник Отдела Стажировки обязан носить Бейджик №30.
• 2.5.7 Сотрудник который приходится Экзаменатором по заявке обязан носить Бейджик № 19.
• 2.5.8 Сотрудники находящиеся на стажировке обязаны носить бейджик Бейджик - № 23.
• 2.5.9 Куратор автошколы может носить любой бейджик.
• 2.6 Сотрудник Автошколы обязан подчиняться старшим по должности.
• 2.7 В рабочее время сотрудник обязан носить униформу выданную в офисе.
• 2.8 Сотрудник Автошколы обязан выбрать отдел после получения им должности "Экзаменатор". (Сотрудники без отдела не будут повышаться).
• 2.9 Сотрудник Автошколы обязан качественно обслуживать своих клиентов.
• 2.10 Сотрудник Автошколы обязан спать только в комнате отдыха в офисе Автошколы. (Исключение: Старшему Составу разрешено спать в комнате отдыха в офисе Автошколы и на парковке в личных автомобилях)
• 2.11 Сотрудник Автошколы, находящийся в должности Мл.Менеджера и выше, обязан обновлять реестр каждый день до 00:00.
• 2.12 Сотрудник Автошколы, находящийся в должности Мл.Менеджера и выше, обязан докладывать по рации о каждом увольнении/повышении/понижении. 
• 2.13 Каждый сотрудник после входа (выхода) в комнату отдыха должен закрывать за собой двери.


[3] Рабочий день в Автошколе:

• 3.1 В будни, рабочий день длится с 09:00 до 21:00. В выходные дни рабочий день длится с 09:00 до 20:00.
• 3.2 Время для перерыва (обеда) с 13:00 до 14:00.
• 3.3 В рабочее время запрещено носить любые аксессуары. (Исключение: очки, часы, усы и чемоданы)
• 3.4 Запрещено покидать офис в рабочее время без разрешения ст.состава.
• 3.5 Время прибытия на работу, независимо от места проживания — 15 минут.
• 3.6 Каждый сотрудник, опаздывающий на работу по любым причинам, вправе отсрочить свое прибытие, уведомив об этом руководство Автошколы.(не более чем на 10 минут)
• 3.7 По желанию сотрудник может остаться на ночную смену после конца рабочего дня.
• 3.8 Запрещено находиться на автомобильной ярмарке в рабочее время.


[4] Сотрудникам Автошколы запрещается:

• 4.1 Покидать рабочее место без разрешения старших.
• 4.2 Младшему составу запрещено спать вне комнаты отдыха.
• 4.3 Носить одежду не по своей должности.
• 4.4 Брать вертолет без разрешения.
• 4.5 Хамить клиентам.
• 4.6 Отбирать друг у друга клиентов.
• 4.7 Находиться в казино в рабочее время.
• 4.8 Носить любые аксессуары, за исключением очков и часов и беретов.
• 4.9 Спать более десяти минут (600 секунд) каждый час во время рабочего дня. Исключения: работа в ночную смену, работа с оф. порталом (отчет) или разрешение Управляющего.
• 4.10 Заводить разговоры о повышении или назначения на управляющую должность в любой форме ( В любые чаты, в том числе /f, /fb, /b, /sms ).
• 4.11 Использовать транспорт, принадлежащий Автошколе, в личных целях.
• 4.12 Работать на любой государственной работе, не снимая рабочую форму.
• 4.13 Посещать автомобильную ярмарку в рабочее время.
• 4.14 Запрещается Употребление Наркотиков и Алкоголя
• 4.15 Запрещено использовать дверь в комнате отдыха в развлекательных намерениях.


[5] Иерархия и руководство отделов автошколы:

• 5.1 В старший состав Автошколы входят сотрудники с должности младшего Менеджера.
• 5.2 Сотрудники старшего состава без должности не имеют тэга в рации.
• 5.3 Набирать к себе в отдел сотрудников можно только с должности "Экзаменатор".
• 5.4 Главой отдела может быть сотрудник в должности инструктора и выше.
• 5.5 Заместителем главы отдела может быть сотрудник в должности мл. инструктора и выше.


[6] Наказания за нарушение устава:

• 6.1 За нарушение устава, сотрудник может получить наказание на усмотрение старшего состава Автошколы.

Профессиональная этика:

Профессиональная этика - множество нравственных норм, при помощи которых определяется направление взаимоотношений человека определенной профессии с неопределенным кругом лиц (неизбежность контакта с этими лицами обусловлена профессией человека). 
По причине участившихся случаев ссор, споров, и националистических шуток была создана данная тема, её цель объяснить людям, которые ещё не получили от жизни опыт позволяющий различить уместность шутки, когда, как и что уместно писать.

Таким образом можно сделать вывод, что профессиональная этика сотрудников Автошколы определяется характером обязанностей возложенных на наш коллектив. А обязанности у нас очень важные для поддержания РП атмосферы. 
Чем же мы заняты? Автошкола играет важную роль на нашем сервере прежде всего из-за того, что является одной из первых организаций, членов которой встречают новые игроки и безусловно это первое место, где они прикоснутся к понятию РП, а значит сотрудники Автошколы должны быть максимально адекватными, как в отношении к игрокам, так и во внутренних взаимоотношениях коллектива.

• Беспочвенная грубость в отношении любых сотрудников ниже вас по карьерной лестнице, в особенности стажеров - является неприемлемой. 
• Следует различать "безобидную шутку", над которой посмеются все во главе с объектом шутки и шутку которая может затронуть национальные, религиозные, остросоциальные вопросы, а также причинить моральный вред неокрепшим умам некоторых юных игроков. 
• Не стоит бравировать своим остроумием перед всеми, если из вас "так и прет острота" - поделитесь этим с кем-то наедине, а если у вас есть претензии решайте их в /sms чат. 
• Мат считается неприемлемым. 
• Следует с уважением относиться к человеку старше вас по должности, если вам кажется что он в чем-то не прав, то пишите лидеру в ЛС. 
• Не допускается выдача информации старшим сотрудником получившим её от младшего, которая может изменить отношение окружающих к нему ( допустим если игрок согласно пункту выше, пожаловался лидеру в ЛС, лидер не имеет право раскрывать это никому, кроме администрации).

За нарушение этих правил в IC вы будете уволены с причиной "нарушение проф. этики". 
За нарушение этих правил в ООС вы будете уволены с причиной "аморальное поведение", согласно РП легенде для всех вы совершили некий аморальный поступок.
]]

function dmb()
	lua_thread.create(function()
		status = true
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
		players2 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		players1 = {'{ffffff}Ник\t{ffffff}Ранг'}
		gcount = nil
	end)
end

function dlog()
    sampShowDialog(97987, '{47f4f0}Inst Tools {ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
  if id == nil then
    sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| Введите: /vig ID Причина", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| Введите: /vig ID ПРИЧИНА", -1)
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

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Стажер',
		['2'] = 'Консультант',
		['3'] = 'Экзаменатор',
		['4'] = 'Мл.Инструктор',
		['5'] = 'Инструктор',
		['6'] = 'Координатор',
		['7'] = 'Мл.Менеджер',
		['8'] = 'Ст.Менеджер',
		['9'] = 'Директор'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if cfg.main.givra then
	if sampIsPlayerConnected(id) then
	  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
				sampSendChat('/me снял(а) старый бейджик с человека напротив стоящего')
				wait(1500)
				sampSendChat('/me убрал(а) старый бейджик в карман')
				wait(1500)
                sampSendChat(string.format('/me достал(а) новый бейджик с надписью "%s"', ranks))
				wait(1500)
				sampSendChat('/me закрепила(а) на рубашку человеку на против новый бейджик')
				wait(1500)
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(1500)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до "%s".', cfg.main.tarr, plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s в должности до "%s".', plus == '+' and 'Повышен(а)' or 'Понижен(а)', ranks))
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
				wait(5000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: Новый сотрудник Автошколы - '..sampGetPlayerNickname(id):gsub('_', ' ')..'.', cfg.main.tarr))
                else
				sampSendChat('/r Новый сотрудник Автошколы - '..sampGetPlayerNickname(id):gsub('_', ' ')..'.')
            end
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
 
 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me забрал(а) бейджик у '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
				wait(2000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Уволен по причине "%s".', cfg.main.tarr, pri4ina))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Уволен по причине "%s".', pri4ina))
            end
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
 
function thelp()
    lua_thread.create(function()
        submenus_show(thelpsub(), '{47f4f0}Inst Tools {ffffff}| Help')
    end)
end

function thelpsub()
    return
{
    {
        title = '{47f4f0}/tset {ffffff}- Открыть меню скрипта',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/tset')
        end
    },
    {
        title = '{47f4f0}/thelp {ffffff} - Помощь по скрипту',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/thelp ')
        end
    },
    {
        title = '{47f4f0}/vig [id] Причина{ffffff} - Выдать выговор по рации',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/vig ')
        end
    },
	{
        title = '{47f4f0}/dmb {ffffff} - Открыть /members в диалоге',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/dmb ')
        end
    },
	{
        title = '{47f4f0}/yst {ffffff} - Открыть устав АШ',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/yst ')
        end
    },
	{
        title = '{47f4f0}/dlog{ffffff} - Открыть лог 25 последних сообщений в департамент',
        onclick = function()
            sampSetChatInputText('/dlog')
            sampSetChatInputEnabled(true)
        end
    },
    {
        title = '{47f4f0}Клавиши:',
        onclick = function()
        end
    },
	{
        title = '{47f4f0}ПКМ+Z на игрока {ffffff}- Меню взаимодействия',
        onclick = function()
        end
    },
    {
        title = '{47f4f0}'..key.id_to_name(cfg.keys.fastmenu)..' {ffffff}- "Быстрое меню"',
        onclick = function()
        end
    }
}
end

function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}Меню {47f4f0}лекций",
    onclick = function()
	submenus_show(fthmenu(id), "{47f4f0}IT {ffffff}| Меню лекций")
	end
   },
    {
   title = "{FFFFFF}Меню {47f4f0}гос.новостей {ff0000}(Для Ст.Состава)",
    onclick = function()
	if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
	submenus_show(govmenu(id), "{47f4f0}IT {ffffff}| Меню гос.новостей")
	else
	ftext('Вы не находитесь в Ст.Составе')
	end
	end
   },
   {
   title = "{FFFFFF}Меню {47f4f0}отделов",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{47f4f0}IT {ffffff}| Меню отделов")
	else
	ftext('Включите автотег в настройках')
	end
	end
   },
   {
   title = "{FFFFFF}Доставка лицензий {47f4f0}в любую точку штата в /d{ff0000}(Для 4+ ранга)",
    onclick = function()
	if rank == 'Мл.Инструктор' or rank == 'Инструктор' or rank == 'Координатор' or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
	sampSendChat(string.format('/d OG, Осуществляется доставка лицензий в любую точку штата. Тел: %s.', tel))
	else
	ftext('Ваш ранг недостаточно высок')
	end
	end
   }
}
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}Пиар отдела в рацию (ОС) {ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В Отдел Стажировки производится пополнение сотрудников.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Экзаменатор".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}Пиар отдела в рацию (ID) {ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В Inspection Department производится пополнение сотрудников.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Вступить в отдел можно с должности "Экзаменатор".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Для подробной информации пишите на п.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}Тех.осмотр авто гос.организаций",
    onclick = function()
	if cfg.main.male == true then
	sampSendChat("/me записал данные о проверяемой гос.организации")
    wait(3500)
    sampSendChat("/me начал осматривать внешнее состояние автомобиля")
    wait(3500)
    sampSendChat("/me открыл капот")
    wait(3500)
    sampSendChat("/do Капот открыт.")
	wait(3500)
	sampSendChat("/me достал с чемодана для инструментов фонарик и начал осматривать двигатель")
	wait(3500)
	sampSendChat("/try двигатель в норме")
	wait(3500)
	sampSendChat("/me начал проверять давление в шинах.")
	wait(3500)
	sampSendChat("/try давление в норме")
	wait(3500)
	sampSendChat("/me проверяет автомобиль на наличие повреждений")
	wait(3500)
	sampSendChat("/try повреждения не обнаружены")
	wait(3500)
	sampSendChat("/me достал блокнот с ручкой, после чего записал все результаты проверки")
	wait(3500)
	sampSendChat("/me поставил подпись и закрыл блокнот")
	end
	if cfg.main.male == false then
	sampSendChat("/me записала данные о проверяемой гос.организации")
    wait(3500)
    sampSendChat("/me начала осматривать внешнее состояние автомобиля")
    wait(3500)
    sampSendChat("/me открыла капот")
    wait(3500)
    sampSendChat("/do Капот открыт.")
	wait(3500)
	sampSendChat("/me достала с чемодана для инструментов фонарик и начала осматривать двигатель")
	wait(3500)
	sampSendChat("/try двигатель в норме")
	wait(3500)
	sampSendChat("/me начала проверять давление в шинах.")
	wait(3500)
	sampSendChat("/try давление в норме")
	wait(3500)
	sampSendChat("/me проверяет автомобиль на наличие повреждений")
	wait(3500)
	sampSendChat("/try повреждения не обнаружены")
	wait(3500)
	sampSendChat("/me достала блокнот с ручкой, после чего записала все результаты проверки")
	wait(3500)
	sampSendChat("/me поставила подпись и закрыла блокнот")
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
	end
   },
   {
   title = "{FFFFFF}Занять гос. волну",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Занимаю гос.волну на")
	end
   },
   {
   title = "{FFFFFF}Напомнить о займе гос. волны",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Напоминаю что волна гос.новостей за Автошколой на")
	end
   }
}
end

function fthmenu(id)
 return
{
  {
    title = "{FFFFFF}Лекция для {47f4f0}Стажёра",
    onclick = function()
	    sampSendChat("Приветствую. Вы приняты на Стажировку в Автошколу. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("/me передал(а) бейджик Стажера Автошколы ")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b /clist 23 ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Стажировка длится до того момента, пока вы не будете повышены до Консультанта. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Запрещено просить повышения или назначения на управляющую должность в любой форме. Как придет срок Вас вызовут. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Обязанности стажёров: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Смотреть как работают коллеги и учиться у них. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("В рабочее время находиться в офисе. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Изучать устав и правила автошколы. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Для повышения в должности, Вам нужно будет сдать экзамен.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Всего у вас будет один экзамен - для повышения до консультанта. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Экзамен состоит из двух частей: Устав и расценки на лицензии. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Экзамен состоится не раньше чем через 3 часа после принятия.")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b Устав и расценки на лицензии можно найти на форуме. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Дабы отбросить частые вопросы:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Стажер может выдавать только права. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Стажерами считаются сотрудники, находящиеся на должности Стажёр и Экзаменатор (по заявке). ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Офис разрешено покидать только с разрешения ст. Состава. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Вертолет можно брать тоже только с разрешения ст. Состава. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("За столами спать запрещено. Спать разрешено только в комнате отдыха. ")
        wait(cfg.commands.zaderjka)
        sampSendChat('/b В теме "Помощь для новичков" есть все нужные бинды, без них не работать! ')
        wait(cfg.commands.zaderjka)
        sampSendChat("Если возникнут вопросы обращайтесь к Сотрудникам Отдела Стажировки либо к ст. Составу. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Спасибо,что прослушали мою лекцию. ")
    end
  },
   {
    title = "{FFFFFF}Лекция для {47f4f0}Экзаменатора",
    onclick = function()
	sampSendChat("Приветствую")
        wait(cfg.commands.zaderjka)
        sampSendChat("Поскольку вы приняты по заявке на должность Экзаменатора, вам необходимо определиться с отделом.")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b /clist 19")
        wait(cfg.commands.zaderjka)
        sampSendChat("ОС - отдел стажировки, занимающийся непосредственно обучением стажёров.")
        wait(cfg.commands.zaderjka)
        sampSendChat("ID - Inspection Department, занимающийся профилактикой нарушений и аварийных ситуаций.")
        wait(cfg.commands.zaderjka)
        sampSendChat("С участием транспорта, через проведение лекций и проверок гос. структур")
        wait(cfg.commands.zaderjka)
        sampSendChat("После четерех дней активной работы.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Вы получите бейджик Мл.Инструктора и будете считаться полноценным сотрудником.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Запрещено просить повышения или назначения на управляющую должность в любой форме.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Как придет срок Вашего повышения - обратитесь к ст. Составу")
        wait(cfg.commands.zaderjka)
        sampSendChat("Офис разрешено покидать только с разрешения ст. Состава.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Вертолет можно брать тоже только с разрешения ст. Состава.")
        wait(cfg.commands.zaderjka)
        sampSendChat("За столами спать запрещено. Спать разрешено только в комнате отдыха.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Стажерами считаются сотрудники, находящиеся на должности Стажёр и Экзаменатор (по заявке).")
        wait(cfg.commands.zaderjka)
        sampSendChat('/b В теме "Помощь для новичков" есть все нужные бинды, без них не работать!')
        wait(cfg.commands.zaderjka)
        sampSendChat("Если возникнут вопросы обращайтесь к Сотрудникам Отдела Стажировки либо к ст. Составу.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Спасибо, что прослушали мою лекцию.")
	end
   },
   {
    title = "{FFFFFF}Лекция про {47f4f0}ПДД",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('Сейчас я проведу лекцию на тему "ПДД". ')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. Скоростной режим в штате: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("В городе ограничение скорости 50 км/ч. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("В жилой зоне - 30 км/ч. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("За пределами города скорость не ограничена. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Водитель обязан: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("При ДТП вызывать полицию и оказать мед. помощь при необходимости. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("При виде машин со спец. сигналами прижаться к обочине и пропустить.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Останавливаться по первому требованию сотрудников полиции. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Двигаться по правой полосе, не пересекая сплошную линию. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Пристегнуться перед началом движения. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Пропускать пешеходов на пешеходных переходах.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ездить исключительно в трезвом состоянии. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Двигаться, не создавая помех другому транспорту.")
        wait(cfg.commands.zaderjka)
        sampSendChat("На этом лекция окончена. Спасибо за внимание.")
	end
   },
   {
    title = "{FFFFFF}Лекция про {47f4f0}Правильное обращение с оружием",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('Сейчас я проведу лекцию на тему "Обращение с оружием".')
        wait(cfg.commands.zaderjka)
        sampSendChat("Гражданам запрещено носить оружие не имея на него лицензию")
        wait(cfg.commands.zaderjka)
        sampSendChat("Для сотрудников силовых структур делается исключение. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Оружие разрешено использовать в случае:")
        wait(cfg.commands.zaderjka)
        sampSendChat("1.Самообороны, при нападении на вас. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2.Для выполнения своих служебных обязанностей.")
        wait(cfg.commands.zaderjka)
        sampSendChat("3.По прямому приказу людей, имеющих на это полномочия. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Тем не менее, существует ряд запретов связанных с оружием: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("1.Запрещено носить оружие в открытом виде в многолюдных местах. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2.Запрещено приобретать оружие незаконно. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("3.Запрещено расстреливать жителей без весомой причины.")
        wait(cfg.commands.zaderjka)
        sampSendChat("4.Запрещено использвать оружие для достижения личных целей. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("В случае нарушения этих правил, у вас будет изъята лицензия. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Так же за подобные нарушения вас могут заключить под стражу. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("На этом все, спасибо за внимание.")
	end
   },
      {
    title = "{FFFFFF}Лекция про {47f4f0}Правила управления водным транспортом",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('Сейчас я проведу лекцию на тему "Правила управления водным транспортом".')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. Прежде, чем отправится в плавание вы должны:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Убедиться в исправности мотора.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Проверить, нет ли водотечности в корпусе судна.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Проверить, не забыли ли вы взять с собой лицензию на право управления водным транспортом.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Позаботиться о спасательных средствах для каждого человека в лодке (катере).")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Запрещается:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Передавать управление водным транспортом другому лицу без соответствующих на то документов, особенно детям.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Выходить в плавание в условия ограниченной видимости, если ваша лодка не оборудована сигнальными огнями.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Перевозить людей в нетрезвом состоянии.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Создавать помехи для плавания судов.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Перемещение с одного судна на другое во время их движения.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Перевозить взрывоопасные и огнеопасные грузы на судах, для этого не предназначенных.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Принимать перед выходом наркотические вещества, спиртные напитки, тонизирующие лекарства и препараты.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ослаблять бдительность и внимание в процессе управления водным транспортом.")
		wait(cfg.commands.zaderjka)
        sampSendChat("На этом все, спасибо за внимание.")
	end
   },
        {
    title = "{FFFFFF}Лекция про {47f4f0}Правила рыбной ловли",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('Сейчас я проведу лекцию на тему "Правила рыбной ловли".')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. Правила рыбной ловли:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ловить рыбу разрешается только в разрешенных местах. (причал на пляже г.Лос-Сантос и за гольф клубом в г.Лас-Вентурас)")
        wait(cfg.commands.zaderjka)
        sampSendChat("Рыбная ловля разрешена только разрешёнными орудиями ужения. (одна удочка с одним крючком либо спиннинг)")
        wait(cfg.commands.zaderjka)
        sampSendChat("Рыбная ловля разрешена исключительно в черте населенного пункта.")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Запрещается:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ловить рыбу с лодки.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ловить рыбу с применением взрывчатых и отравляющих веществ, с помощью электротока, с использованием колющих орудий.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ловить рыбу без наличия лицензии рыболова.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ловить рыбу в радиусе 500 метров от хозяйств, разводящих рыбу.")
	end
   },
      {
    title = "{FFFFFF}Лекция про {47f4f0}Пилотирование",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Всех приветствую. Я сотрудник Автошколы "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('Сейчас я проведу лекцию на тему "Пилотирование". ')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. Правила пилотирования: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("При совершении полета нужно четко выполнять все инструкции и не отклоняться от выбранного курса. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Перед началом полета надо проверить технику на которой вы будете совершать полет. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Тренировочные полеты совершаются только при опытных пилотах. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Принимать перед вылетом наркотические вещества, спиртные напитки, тонизирующие лекарства и препараты.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Ослаблять бдительность и внимание в процессе полета. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Полеты в запретных и опасных зонах, информации о которых нет на полетных картах. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Полет над населенными пунктами и скоплениями людей на открытой местности на высоте менее 300 метров.")
       wait(cfg.commands.zaderjka)
        sampSendChat("Сближение самолетов ближе установленных правил расстояний. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("На этом все, спасибо за внимание.")
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
	local clisto = imgui.ImBool(cfg.main.clisto)
	local givra = imgui.ImBool(cfg.main.givra)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
	imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth/2, iScreenHeight/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(380, 320), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'Настройки##1', first_window)
	imgui.PushItemWidth(100)
	imgui.Text(u8("Использовать автотег"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать автотег', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Введите ваш Тег.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
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
	imgui.Text(u8("Использовать отыгровку /giverank"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Использовать отыгровку /giverank', givra) then
        cfg.main.givra = not cfg.main.givra
    end
	if imgui.InputInt(u8'Задержка в лекциях', waitbuffer) then
     cfg.commands.zaderjka = waitbuffer.v
    end
    if imgui.CustomButton(u8('Сохранить настройки'), imgui.ImVec4(0.11, 0.79, 0.07, 0.40), imgui.ImVec4(0.11, 0.79, 0.07, 1.00), imgui.ImVec4(0.11, 0.79, 0.07, 0.76), btn_size) then
	ftext('Настройки успешно сохранены.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- сохраняем все новые значения в конфиге
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Устав АШ'), ystwindow)
                for line in io.lines('moonloader\\instools\\yst.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local x, y = getScreenResolution()
    local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.Begin('Inst Tools | Main Menu', second_window, imgui.WindowFlags.NoResize)
	if imgui.Button(u8'Биндер', btn_size) then
      bMainWindow.v = not bMainWindow.v
    end
    if imgui.Button(u8'Настройки скрипта', btn_size) then
      first_window.v = not first_window.v
    end
	if imgui.Button(u8'Проверить обновление скрипта', btn_size) then
      updwindows.v = not updwindows.v
    end
    if imgui.Button(u8'Перезагрузить скрипт', btn_size) then
      showCursor(false)
      thisScript():reload()
    end
    imgui.End()
  end
    if updwindows.v then
                local updlist = ttt
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(700, 290), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Обновление'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Вышло обновление скрипта Inst Tools. Что бы обновиться нажмите кнопку внизу. Список изменений:'))
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
   imgui.SetNextWindowSize(imgui.ImVec2(800, 500), imgui.Cond.FirstUseEver)

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
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x3D85C6)
end

function tset()
  second_window.v = not second_window.v
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
    return
    {
      {
        title = "{ffffff}» Цены лицензий",
        onclick = function()
        pID = tonumber(args)
        submenus_show(pricemenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Инструктор",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Вопросы",
        onclick = function()
        pID = tonumber(args)
        submenus_show(questimenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Оформление",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ударить шокером",
        onclick = function()
        sampSendChat("/me снял шокер с пояса.")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me повесил шокер на пояс")
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
		sampAddChatMessage("{47f4f0}[IT] {FFFFFF}- Правильный ответ: {A52A2A}Оказать первую помощь пострадавшим. Вызвать МЧС и ПД и ждать их прибытия.", -1)
        end
      },
	  {
        title = '{5b83c2}« Раздел других вопросов»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}Оружие',
        onclick = function()
        sampSendChat("Зачем вам оружие?")
        end
      },
	  {
        title = '{ffffff}Покажите документ на бизнес',
        onclick = function()
        sampSendChat("Пожалуйста предоставте документ на наличие бизнеса.")
		wait(1500)
		sampSendChat("/b /me показал документ на бизнес")
        end
      },
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		  sampSendChat("/givelicense "..id)
		  wait(1700)
		  sampCloseCurrentDialogWithButton(1)
		  wait(1700)
		  sampSendChat("Удачи на дорогах.")
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(2)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(1)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(4)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
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
		  sampSendChat('/me поставил печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(3)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
        sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(5)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      }
    }
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
          sampSendChat("Стоимость данной лицензии составляет - 500$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl <= 5 then
		  sampSendChat("Стоимость данной лицензии составляет - 5.000$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl <= 15 then
		  sampSendChat("Стоимость данной лицензии составляет - 10.000$.")
		  wait(1500)
		  sampSendChat("Оформляем?")	  
		else if gmegaflvl >= 16 then
		  sampSendChat("Стоимость данной лицензии составляет - 30.000$.")
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
        sampSendChat("Стоимость данной лицензии составляет - 2.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Пилот',
        onclick = function()
        sampSendChat("Стоимость данной лицензии составляет - 10.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Оружие{ff0000} со 2 уровня.',
        onclick = function()
        sampSendChat("Стоимость данной лицензии составляет - 50.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
	  {
        title = '{ffffff}» Бизнес{ff0000} при наличии бизнеса.',
        onclick = function()
        sampSendChat("Стоимость данной лицензии составляет - 100.000$.")
		wait(1500)
		sampSendChat("Оформляем?")
        end
      },
      {
        title = '{ffffff}» Катер',
        onclick = function()
        sampSendChat("Стоимость данной лицензии составляет - 5.000$.")
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
		sampSendChat('/do На рубашке бейджик с надписью "'..rank..'" | '..myname:gsub('_', ' ')..'.')  
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
		sampSendChat('/me проставил(а) печати "Autoschool San Fierro" и передал лицензии '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
    if not doesFileExist('moonloader/instools/yst.txt') then
        local file = io.open("moonloader/instools/yst.txt", "w")
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
	downloadUrlToFile('https://raw.githubusercontent.com/Damein68/lua/master/update.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
			    local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('Обнаружено обновление.')
                        ftext('Примечание: Если у вас не появилось окошко введите /tset')
					    updwindows.v = true
                    else
                        ftext('Обновлений скрипта не обнаружено. Приятной игры.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
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

function sampev.onSendSpawn()
    if cfg.main.clistb and rabden then
        lua_thread.create(function()
            wait(1200)
            ftext('Цвет ника сменен на: {9966cc}' .. cfg.main.clist)
            sampSendChat('/clist '..cfg.main.clist)
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('Рабочий день начат') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
                ftext('Цвет ника сменен на: {9966cc}' .. cfg.main.clist)
                sampSendChat('/clist '..tonumber(cfg.main.clist))
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
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..'" | '..myname:gsub('_', ' ')..'.')  
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
                sampSendChat('/do На рубашке бейджик с надписью "'..rank..'" | '..myname:gsub('_', ' ')..'.')
				end
			end
            end)
        end
	  end
    end
    if text:find('Рабочий день окончен') and color ~= -1 then
        rabden = false
    end
	if color == -8224086 then
        local colors = ("{%06X}"):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors.."[%H:%M:%S] ") .. text)
    end
	if status then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players2, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', nick, id, rang, stat))
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
=======
script_name('Inst Tools')
script_version('2.4')
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
players2 = {'{ffffff}РќРёРє\t{ffffff}Р Р°РЅРі\t{ffffff}РЎС‚Р°С‚СѓСЃ'}
frak = nil
rang = nil
ttt = nil
rabden = false
tload = false
tLastKeys = {}
departament = {}
function apply_custom_style()
  imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

style.Alpha = 1.0
style.ChildWindowRounding = 3
style.WindowRounding = 3
style.GrabRounding = 1
style.GrabMinSize = 20
style.FrameRounding = 3

colors[clr.Text] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextDisabled] = ImVec4(0.00, 0.40, 0.41, 1.00)
colors[clr.WindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.Border] = ImVec4(0.00, 1.00, 1.00, 0.65)
colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg] = ImVec4(0.44, 0.80, 0.80, 0.18)
colors[clr.FrameBgHovered] = ImVec4(0.44, 0.80, 0.80, 0.27)
colors[clr.FrameBgActive] = ImVec4(0.44, 0.81, 0.86, 0.66)
colors[clr.TitleBg] = ImVec4(0.14, 0.18, 0.21, 0.73)
colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.54)
colors[clr.TitleBgActive] = ImVec4(0.00, 1.00, 1.00, 0.27)
colors[clr.MenuBarBg] = ImVec4(0.00, 0.00, 0.00, 0.20)
colors[clr.ScrollbarBg] = ImVec4(0.22, 0.29, 0.30, 0.71)
colors[clr.ScrollbarGrab] = ImVec4(0.00, 1.00, 1.00, 0.44)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.ComboBg] = ImVec4(0.16, 0.24, 0.22, 0.60)
colors[clr.CheckMark] = ImVec4(0.00, 1.00, 1.00, 0.68)
colors[clr.SliderGrab] = ImVec4(0.00, 1.00, 1.00, 0.36)
colors[clr.SliderGrabActive] = ImVec4(0.00, 1.00, 1.00, 0.76)
colors[clr.Button] = ImVec4(0.00, 0.65, 0.65, 0.46)
colors[clr.ButtonHovered] = ImVec4(0.01, 1.00, 1.00, 0.43)
colors[clr.ButtonActive] = ImVec4(0.00, 1.00, 1.00, 0.62)
colors[clr.Header] = ImVec4(0.00, 1.00, 1.00, 0.33)
colors[clr.HeaderHovered] = ImVec4(0.00, 1.00, 1.00, 0.42)
colors[clr.HeaderActive] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGrip] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGripHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ResizeGripActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.CloseButton] = ImVec4(0.00, 0.78, 0.78, 0.35)
colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.78, 0.78, 0.47)
colors[clr.CloseButtonActive] = ImVec4(0.00, 0.78, 0.78, 1.00)
colors[clr.PlotLines] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotLinesHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogramHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.00, 1.00, 1.00, 0.22)
colors[clr.ModalWindowDarkening] = ImVec4(0.04, 0.10, 0.09, 0.51)
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
	zaderjka = 5000
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
    ftext("РЎРєСЂРёРїС‚ СѓСЃРїРµС€РЅРѕ Р·Р°РіСЂСѓР¶РµРЅ. /thelp - РїРѕРјРѕС‰СЊ РїРѕ РєРѕРјР°РЅРґР°Рј, /tset - РЅР°СЃС‚СЂРѕР№РєРё СЃРєСЂРёРїС‚Р°.", -1)
	ftext('РђРІС‚РѕСЂРѕРј РґР°РЅРЅРѕРіРѕ СЃРєСЂРёРїС‚Р° СЏРІР»СЏРµС‚СЃСЏ Damien_Requeste')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{47f4f0}IT {ffffff}| РћС‚СЃСѓС‚СЃРІСѓРµС‚ С„Р°Р№Р» РєРѕРЅС„РёРіР°, СЃРѕР·РґР°РµРј.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{47f4f0}IT {ffffff}| Р¤Р°Р№Р» РєРѕРЅС„РёРіР° СѓСЃРїРµС€РЅРѕ СЃРѕР·РґР°РЅ.", -1)
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
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/instools') then createDirectory('moonloader/instools') end
  hk = require 'lib.imcustom.hotkey'
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
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('thelp', thelp)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('tset', tset)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{47f4f0}IT {ffffff}| РћС‚СЃСѓС‚СЃРІСѓРµС‚ С„Р°Р№Р» РєРѕРЅС„РёРіР°, СЃРѕР·РґР°РµРј.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{47f4f0}IT {ffffff}| Р¤Р°Р№Р» РєРѕРЅС„РёРіР° СѓСЃРїРµС€РЅРѕ СЃРѕР·РґР°РЅ.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{47f4f0}IT {ffffff}| Р‘С‹СЃС‚СЂРѕРµ РјРµРЅСЋ")
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] РЈСЂРѕРІРµРЅСЊ - "..sampGetPlayerScore(id).." ")
            end
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v
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

РћР±С‰РµРµ РїРѕР»РѕР¶РµРЅРёРµ РђРІС‚РѕС€РєРѕР»С‹:

вЂў 1.1 РЈСЃС‚Р°РІ РђРІС‚РѕС€РєРѕР»С‹ СѓСЃС‚Р°РЅР°РІР»РёРІР°РµС‚ РїРѕР»РѕР¶РµРЅРёСЏ, РєРѕС‚РѕСЂС‹Рј РґРѕР»Р¶РЅС‹ СЃР»РµРґРѕРІР°С‚СЊ РІСЃРµ СЃРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹.
вЂў 1.2 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РїРѕРґС‡РёРЅСЏС‚СЊСЃСЏ СЃС‚Р°СЂС€РёРј РїРѕ РґРѕР»Р¶РЅРѕСЃС‚Рё.
вЂў 1.3 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅС‹ РєР°С‡РµСЃС‚РІРµРЅРЅРѕ РѕР±СЃР»СѓР¶РёРІР°С‚СЊ СЃРІРѕРёС… РєР»РёРµРЅС‚РѕРІ.
вЂў 1.4 РЎРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РјРѕР¶РµС‚ РІС‹РµР·Р¶Р°С‚СЊ РЅР° РІС‹Р·РѕРІС‹ РіРѕСЃ. СЃС‚СЂСѓРєС‚СѓСЂ РґР»СЏ РїСЂРѕРґР°Р¶Рё Р»РёС†РµРЅР·РёР№.
вЂў 1.5 РќРµР·РЅР°РЅРёРµ СѓСЃС‚Р°РІР° РЅРµ РѕСЃРІРѕР±РѕР¶РґР°РµС‚ РІР°СЃ РѕС‚ РѕС‚РІРµС‚СЃС‚РІРµРЅРЅРѕСЃС‚Рё.
вЂў 1.6 Р—Р°РїСЂРµС‰РµРЅС‹ Р»СЋР±С‹Рµ СЂР°Р·РіРѕРІРѕСЂС‹ Рѕ РїРѕРІС‹С€РµРЅРёРё РёР»Рё РЅР°Р·РЅР°С‡РµРЅРёРё РЅР° СѓРїСЂР°РІР»СЏСЋС‰СѓСЋ РґРѕР»Р¶РЅРѕСЃС‚СЊ РІ Р»СЋР±РѕР№ С„РѕСЂРјРµ ( Р’ Р»СЋР±С‹Рµ С‡Р°С‚С‹, РІ С‚РѕРј С‡РёСЃР»Рµ /f, /fb, /b, /sms ).
вЂў 1.7 РЈСЃС‚Р°РІ РјРѕР¶РµС‚ Р±С‹С‚СЊ РёР·РјРµРЅРµРЅ РІ Р»СЋР±РѕРµ РІСЂРµРјСЏ РЈРїСЂР°РІР»СЏСЋС‰РёРј РђРІС‚РѕС€РєРѕР»С‹.


[2] РћР±СЏР·Р°РЅРЅРѕСЃС‚Рё СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РђРІС‚РѕС€РєРѕР»С‹:

вЂў 2.1 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ СЃРѕР±Р»СЋРґР°С‚СЊ РЈСЃС‚Р°РІ РђРІС‚РѕС€РєРѕР»С‹. 
вЂў 2.2 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ Р·РЅР°С‚СЊ Рё СЃРѕР±Р»СЋРґР°С‚СЊ РІСЃРµ РїСЂР°РІРёР»Р° Рё Р·Р°РєРѕРЅС‹ С€С‚Р°С‚Р°. 
вЂў 2.3 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РґРѕР»Р¶РµРЅ СЃР»РµРґРёС‚СЊ Р·Р° СЃРѕР±Р»СЋРґРµРЅРёРµ РѕС‡РµСЂРµРґРЅРѕСЃС‚Рё РїСЂРё РѕР±СЃР»СѓР¶РёРІР°РЅРёРё РєР»РёРµРЅС‚РѕРІ.
вЂў 2.4 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РїРѕРґР°РІР°С‚СЊ РїСЂРёРјРµСЂ РёРґРµР°Р»СЊРЅС‹Рј РІРѕР¶РґРµРЅРёРµРј Рё РѕС‚Р»РёС‡РЅС‹Рј Р·РЅР°РЅРёРµРј РџР”Р”.
вЂў 2.5 РЎРѕС‚СЂСѓРґРЅРёРєРё РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р±РµР№РґР¶РёРєРё СЃРѕРіР»Р°СЃРЅРѕ РїСЂРёРЅР°РґР»РµР¶РЅРѕСЃС‚Рё Рє С‚РѕРјСѓ РёР»Рё РёРЅРѕРјСѓ РѕС‚РґРµР»Сѓ.
вЂў 2.5.1 РЎРѕС‚СЂСѓРґРЅРёРєРё СЃС‚Р°СЂС€РµРіРѕ СЃРѕСЃС‚Р°РІР° РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє - в„– 15. 
вЂў 2.5.2 CРѕС‚СЂСѓРґРЅРёРєРё Р±РµР· РѕС‚РґРµР»Р° РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє - в„– 4. 
вЂў 2.5.3 Р“Р»Р°РІР° РѕС‚РґРµР»Р° РЅРѕСЃРёС‚ Р‘РµР№РґР¶РёРє в„–12.
вЂў 2.5.4 Р—Р°РјРµСЃС‚РёС‚РµР»СЊ РіР»Р°РІС‹ РѕС‚РґРµР»Р° СЃС‚Р°Р¶РёСЂРѕРІРєРё РЅРѕСЃРёС‚ Р‘РµР№РґР¶РёРє в„–25.
вЂў 2.5.5 РЎРѕС‚СЂСѓРґРЅРёРє РћС‚РґРµР»Р° РРЅСЃРїРµРєС†РёРё РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„–21.
вЂў 2.5.6 РЎРѕС‚СЂСѓРґРЅРёРє РћС‚РґРµР»Р° РЎС‚Р°Р¶РёСЂРѕРІРєРё РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„–30.
вЂў 2.5.7 РЎРѕС‚СЂСѓРґРЅРёРє РєРѕС‚РѕСЂС‹Р№ РїСЂРёС…РѕРґРёС‚СЃСЏ Р­РєР·Р°РјРµРЅР°С‚РѕСЂРѕРј РїРѕ Р·Р°СЏРІРєРµ РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ Р‘РµР№РґР¶РёРє в„– 19.
вЂў 2.5.8 РЎРѕС‚СЂСѓРґРЅРёРєРё РЅР°С…РѕРґСЏС‰РёРµСЃСЏ РЅР° СЃС‚Р°Р¶РёСЂРѕРІРєРµ РѕР±СЏР·Р°РЅС‹ РЅРѕСЃРёС‚СЊ Р±РµР№РґР¶РёРє Р‘РµР№РґР¶РёРє - в„– 23.
вЂў 2.5.9 РљСѓСЂР°С‚РѕСЂ Р°РІС‚РѕС€РєРѕР»С‹ РјРѕР¶РµС‚ РЅРѕСЃРёС‚СЊ Р»СЋР±РѕР№ Р±РµР№РґР¶РёРє.
вЂў 2.6 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РїРѕРґС‡РёРЅСЏС‚СЊСЃСЏ СЃС‚Р°СЂС€РёРј РїРѕ РґРѕР»Р¶РЅРѕСЃС‚Рё.
вЂў 2.7 Р’ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ СЃРѕС‚СЂСѓРґРЅРёРє РѕР±СЏР·Р°РЅ РЅРѕСЃРёС‚СЊ СѓРЅРёС„РѕСЂРјСѓ РІС‹РґР°РЅРЅСѓСЋ РІ РѕС„РёСЃРµ.
вЂў 2.8 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РІС‹Р±СЂР°С‚СЊ РѕС‚РґРµР» РїРѕСЃР»Рµ РїРѕР»СѓС‡РµРЅРёСЏ РёРј РґРѕР»Р¶РЅРѕСЃС‚Рё "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ". (РЎРѕС‚СЂСѓРґРЅРёРєРё Р±РµР· РѕС‚РґРµР»Р° РЅРµ Р±СѓРґСѓС‚ РїРѕРІС‹С€Р°С‚СЊСЃСЏ).
вЂў 2.9 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ РєР°С‡РµСЃС‚РІРµРЅРЅРѕ РѕР±СЃР»СѓР¶РёРІР°С‚СЊ СЃРІРѕРёС… РєР»РёРµРЅС‚РѕРІ.
вЂў 2.10 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ РѕР±СЏР·Р°РЅ СЃРїР°С‚СЊ С‚РѕР»СЊРєРѕ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р° РІ РѕС„РёСЃРµ РђРІС‚РѕС€РєРѕР»С‹. (РСЃРєР»СЋС‡РµРЅРёРµ: РЎС‚Р°СЂС€РµРјСѓ РЎРѕСЃС‚Р°РІСѓ СЂР°Р·СЂРµС€РµРЅРѕ СЃРїР°С‚СЊ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р° РІ РѕС„РёСЃРµ РђРІС‚РѕС€РєРѕР»С‹ Рё РЅР° РїР°СЂРєРѕРІРєРµ РІ Р»РёС‡РЅС‹С… Р°РІС‚РѕРјРѕР±РёР»СЏС…)
вЂў 2.11 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹, РЅР°С…РѕРґСЏС‰РёР№СЃСЏ РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РњР».РњРµРЅРµРґР¶РµСЂР° Рё РІС‹С€Рµ, РѕР±СЏР·Р°РЅ РѕР±РЅРѕРІР»СЏС‚СЊ СЂРµРµСЃС‚СЂ РєР°Р¶РґС‹Р№ РґРµРЅСЊ РґРѕ 00:00.
вЂў 2.12 РЎРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹, РЅР°С…РѕРґСЏС‰РёР№СЃСЏ РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РњР».РњРµРЅРµРґР¶РµСЂР° Рё РІС‹С€Рµ, РѕР±СЏР·Р°РЅ РґРѕРєР»Р°РґС‹РІР°С‚СЊ РїРѕ СЂР°С†РёРё Рѕ РєР°Р¶РґРѕРј СѓРІРѕР»СЊРЅРµРЅРёРё/РїРѕРІС‹С€РµРЅРёРё/РїРѕРЅРёР¶РµРЅРёРё. 
вЂў 2.13 РљР°Р¶РґС‹Р№ СЃРѕС‚СЂСѓРґРЅРёРє РїРѕСЃР»Рµ РІС…РѕРґР° (РІС‹С…РѕРґР°) РІ РєРѕРјРЅР°С‚Сѓ РѕС‚РґС‹С…Р° РґРѕР»Р¶РµРЅ Р·Р°РєСЂС‹РІР°С‚СЊ Р·Р° СЃРѕР±РѕР№ РґРІРµСЂРё.


[3] Р Р°Р±РѕС‡РёР№ РґРµРЅСЊ РІ РђРІС‚РѕС€РєРѕР»Рµ:

вЂў 3.1 Р’ Р±СѓРґРЅРё, СЂР°Р±РѕС‡РёР№ РґРµРЅСЊ РґР»РёС‚СЃСЏ СЃ 09:00 РґРѕ 21:00. Р’ РІС‹С…РѕРґРЅС‹Рµ РґРЅРё СЂР°Р±РѕС‡РёР№ РґРµРЅСЊ РґР»РёС‚СЃСЏ СЃ 09:00 РґРѕ 20:00.
вЂў 3.2 Р’СЂРµРјСЏ РґР»СЏ РїРµСЂРµСЂС‹РІР° (РѕР±РµРґР°) СЃ 13:00 РґРѕ 14:00.
вЂў 3.3 Р’ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ Р·Р°РїСЂРµС‰РµРЅРѕ РЅРѕСЃРёС‚СЊ Р»СЋР±С‹Рµ Р°РєСЃРµСЃСЃСѓР°СЂС‹. (РСЃРєР»СЋС‡РµРЅРёРµ: РѕС‡РєРё, С‡Р°СЃС‹, СѓСЃС‹ Рё С‡РµРјРѕРґР°РЅС‹)
вЂў 3.4 Р—Р°РїСЂРµС‰РµРЅРѕ РїРѕРєРёРґР°С‚СЊ РѕС„РёСЃ РІ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ Р±РµР· СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚.СЃРѕСЃС‚Р°РІР°.
вЂў 3.5 Р’СЂРµРјСЏ РїСЂРёР±С‹С‚РёСЏ РЅР° СЂР°Р±РѕС‚Сѓ, РЅРµР·Р°РІРёСЃРёРјРѕ РѕС‚ РјРµСЃС‚Р° РїСЂРѕР¶РёРІР°РЅРёСЏ вЂ” 15 РјРёРЅСѓС‚.
вЂў 3.6 РљР°Р¶РґС‹Р№ СЃРѕС‚СЂСѓРґРЅРёРє, РѕРїР°Р·РґС‹РІР°СЋС‰РёР№ РЅР° СЂР°Р±РѕС‚Сѓ РїРѕ Р»СЋР±С‹Рј РїСЂРёС‡РёРЅР°Рј, РІРїСЂР°РІРµ РѕС‚СЃСЂРѕС‡РёС‚СЊ СЃРІРѕРµ РїСЂРёР±С‹С‚РёРµ, СѓРІРµРґРѕРјРёРІ РѕР± СЌС‚РѕРј СЂСѓРєРѕРІРѕРґСЃС‚РІРѕ РђРІС‚РѕС€РєРѕР»С‹.(РЅРµ Р±РѕР»РµРµ С‡РµРј РЅР° 10 РјРёРЅСѓС‚)
вЂў 3.7 РџРѕ Р¶РµР»Р°РЅРёСЋ СЃРѕС‚СЂСѓРґРЅРёРє РјРѕР¶РµС‚ РѕСЃС‚Р°С‚СЊСЃСЏ РЅР° РЅРѕС‡РЅСѓСЋ СЃРјРµРЅСѓ РїРѕСЃР»Рµ РєРѕРЅС†Р° СЂР°Р±РѕС‡РµРіРѕ РґРЅСЏ.
вЂў 3.8 Р—Р°РїСЂРµС‰РµРЅРѕ РЅР°С…РѕРґРёС‚СЊСЃСЏ РЅР° Р°РІС‚РѕРјРѕР±РёР»СЊРЅРѕР№ СЏСЂРјР°СЂРєРµ РІ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ.


[4] РЎРѕС‚СЂСѓРґРЅРёРєР°Рј РђРІС‚РѕС€РєРѕР»С‹ Р·Р°РїСЂРµС‰Р°РµС‚СЃСЏ:

вЂў 4.1 РџРѕРєРёРґР°С‚СЊ СЂР°Р±РѕС‡РµРµ РјРµСЃС‚Рѕ Р±РµР· СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚Р°СЂС€РёС….
вЂў 4.2 РњР»Р°РґС€РµРјСѓ СЃРѕСЃС‚Р°РІСѓ Р·Р°РїСЂРµС‰РµРЅРѕ СЃРїР°С‚СЊ РІРЅРµ РєРѕРјРЅР°С‚С‹ РѕС‚РґС‹С…Р°.
вЂў 4.3 РќРѕСЃРёС‚СЊ РѕРґРµР¶РґСѓ РЅРµ РїРѕ СЃРІРѕРµР№ РґРѕР»Р¶РЅРѕСЃС‚Рё.
вЂў 4.4 Р‘СЂР°С‚СЊ РІРµСЂС‚РѕР»РµС‚ Р±РµР· СЂР°Р·СЂРµС€РµРЅРёСЏ.
вЂў 4.5 РҐР°РјРёС‚СЊ РєР»РёРµРЅС‚Р°Рј.
вЂў 4.6 РћС‚Р±РёСЂР°С‚СЊ РґСЂСѓРі Сѓ РґСЂСѓРіР° РєР»РёРµРЅС‚РѕРІ.
вЂў 4.7 РќР°С…РѕРґРёС‚СЊСЃСЏ РІ РєР°Р·РёРЅРѕ РІ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ.
вЂў 4.8 РќРѕСЃРёС‚СЊ Р»СЋР±С‹Рµ Р°РєСЃРµСЃСЃСѓР°СЂС‹, Р·Р° РёСЃРєР»СЋС‡РµРЅРёРµРј РѕС‡РєРѕРІ Рё С‡Р°СЃРѕРІ Рё Р±РµСЂРµС‚РѕРІ.
вЂў 4.9 РЎРїР°С‚СЊ Р±РѕР»РµРµ РґРµСЃСЏС‚Рё РјРёРЅСѓС‚ (600 СЃРµРєСѓРЅРґ) РєР°Р¶РґС‹Р№ С‡Р°СЃ РІРѕ РІСЂРµРјСЏ СЂР°Р±РѕС‡РµРіРѕ РґРЅСЏ. РСЃРєР»СЋС‡РµРЅРёСЏ: СЂР°Р±РѕС‚Р° РІ РЅРѕС‡РЅСѓСЋ СЃРјРµРЅСѓ, СЂР°Р±РѕС‚Р° СЃ РѕС„. РїРѕСЂС‚Р°Р»РѕРј (РѕС‚С‡РµС‚) РёР»Рё СЂР°Р·СЂРµС€РµРЅРёРµ РЈРїСЂР°РІР»СЏСЋС‰РµРіРѕ.
вЂў 4.10 Р—Р°РІРѕРґРёС‚СЊ СЂР°Р·РіРѕРІРѕСЂС‹ Рѕ РїРѕРІС‹С€РµРЅРёРё РёР»Рё РЅР°Р·РЅР°С‡РµРЅРёСЏ РЅР° СѓРїСЂР°РІР»СЏСЋС‰СѓСЋ РґРѕР»Р¶РЅРѕСЃС‚СЊ РІ Р»СЋР±РѕР№ С„РѕСЂРјРµ ( Р’ Р»СЋР±С‹Рµ С‡Р°С‚С‹, РІ С‚РѕРј С‡РёСЃР»Рµ /f, /fb, /b, /sms ).
вЂў 4.11 РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ С‚СЂР°РЅСЃРїРѕСЂС‚, РїСЂРёРЅР°РґР»РµР¶Р°С‰РёР№ РђРІС‚РѕС€РєРѕР»Рµ, РІ Р»РёС‡РЅС‹С… С†РµР»СЏС….
вЂў 4.12 Р Р°Р±РѕС‚Р°С‚СЊ РЅР° Р»СЋР±РѕР№ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅРѕР№ СЂР°Р±РѕС‚Рµ, РЅРµ СЃРЅРёРјР°СЏ СЂР°Р±РѕС‡СѓСЋ С„РѕСЂРјСѓ.
вЂў 4.13 РџРѕСЃРµС‰Р°С‚СЊ Р°РІС‚РѕРјРѕР±РёР»СЊРЅСѓСЋ СЏСЂРјР°СЂРєСѓ РІ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ.
вЂў 4.14 Р—Р°РїСЂРµС‰Р°РµС‚СЃСЏ РЈРїРѕС‚СЂРµР±Р»РµРЅРёРµ РќР°СЂРєРѕС‚РёРєРѕРІ Рё РђР»РєРѕРіРѕР»СЏ
вЂў 4.15 Р—Р°РїСЂРµС‰РµРЅРѕ РёСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РґРІРµСЂСЊ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р° РІ СЂР°Р·РІР»РµРєР°С‚РµР»СЊРЅС‹С… РЅР°РјРµСЂРµРЅРёСЏС….


[5] РРµСЂР°СЂС…РёСЏ Рё СЂСѓРєРѕРІРѕРґСЃС‚РІРѕ РѕС‚РґРµР»РѕРІ Р°РІС‚РѕС€РєРѕР»С‹:

вЂў 5.1 Р’ СЃС‚Р°СЂС€РёР№ СЃРѕСЃС‚Р°РІ РђРІС‚РѕС€РєРѕР»С‹ РІС…РѕРґСЏС‚ СЃРѕС‚СЂСѓРґРЅРёРєРё СЃ РґРѕР»Р¶РЅРѕСЃС‚Рё РјР»Р°РґС€РµРіРѕ РњРµРЅРµРґР¶РµСЂР°.
вЂў 5.2 РЎРѕС‚СЂСѓРґРЅРёРєРё СЃС‚Р°СЂС€РµРіРѕ СЃРѕСЃС‚Р°РІР° Р±РµР· РґРѕР»Р¶РЅРѕСЃС‚Рё РЅРµ РёРјРµСЋС‚ С‚СЌРіР° РІ СЂР°С†РёРё.
вЂў 5.3 РќР°Р±РёСЂР°С‚СЊ Рє СЃРµР±Рµ РІ РѕС‚РґРµР» СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РјРѕР¶РЅРѕ С‚РѕР»СЊРєРѕ СЃ РґРѕР»Р¶РЅРѕСЃС‚Рё "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ".
вЂў 5.4 Р“Р»Р°РІРѕР№ РѕС‚РґРµР»Р° РјРѕР¶РµС‚ Р±С‹С‚СЊ СЃРѕС‚СЂСѓРґРЅРёРє РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РёРЅСЃС‚СЂСѓРєС‚РѕСЂР° Рё РІС‹С€Рµ.
вЂў 5.5 Р—Р°РјРµСЃС‚РёС‚РµР»РµРј РіР»Р°РІС‹ РѕС‚РґРµР»Р° РјРѕР¶РµС‚ Р±С‹С‚СЊ СЃРѕС‚СЂСѓРґРЅРёРє РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РјР». РёРЅСЃС‚СЂСѓРєС‚РѕСЂР° Рё РІС‹С€Рµ.


[6] РќР°РєР°Р·Р°РЅРёСЏ Р·Р° РЅР°СЂСѓС€РµРЅРёРµ СѓСЃС‚Р°РІР°:

вЂў 6.1 Р—Р° РЅР°СЂСѓС€РµРЅРёРµ СѓСЃС‚Р°РІР°, СЃРѕС‚СЂСѓРґРЅРёРє РјРѕР¶РµС‚ РїРѕР»СѓС‡РёС‚СЊ РЅР°РєР°Р·Р°РЅРёРµ РЅР° СѓСЃРјРѕС‚СЂРµРЅРёРµ СЃС‚Р°СЂС€РµРіРѕ СЃРѕСЃС‚Р°РІР° РђРІС‚РѕС€РєРѕР»С‹.

РџСЂРѕС„РµСЃСЃРёРѕРЅР°Р»СЊРЅР°СЏ СЌС‚РёРєР°:

РџСЂРѕС„РµСЃСЃРёРѕРЅР°Р»СЊРЅР°СЏ СЌС‚РёРєР° - РјРЅРѕР¶РµСЃС‚РІРѕ РЅСЂР°РІСЃС‚РІРµРЅРЅС‹С… РЅРѕСЂРј, РїСЂРё РїРѕРјРѕС‰Рё РєРѕС‚РѕСЂС‹С… РѕРїСЂРµРґРµР»СЏРµС‚СЃСЏ РЅР°РїСЂР°РІР»РµРЅРёРµ РІР·Р°РёРјРѕРѕС‚РЅРѕС€РµРЅРёР№ С‡РµР»РѕРІРµРєР° РѕРїСЂРµРґРµР»РµРЅРЅРѕР№ РїСЂРѕС„РµСЃСЃРёРё СЃ РЅРµРѕРїСЂРµРґРµР»РµРЅРЅС‹Рј РєСЂСѓРіРѕРј Р»РёС† (РЅРµРёР·Р±РµР¶РЅРѕСЃС‚СЊ РєРѕРЅС‚Р°РєС‚Р° СЃ СЌС‚РёРјРё Р»РёС†Р°РјРё РѕР±СѓСЃР»РѕРІР»РµРЅР° РїСЂРѕС„РµСЃСЃРёРµР№ С‡РµР»РѕРІРµРєР°). 
РџРѕ РїСЂРёС‡РёРЅРµ СѓС‡Р°СЃС‚РёРІС€РёС…СЃСЏ СЃР»СѓС‡Р°РµРІ СЃСЃРѕСЂ, СЃРїРѕСЂРѕРІ, Рё РЅР°С†РёРѕРЅР°Р»РёСЃС‚РёС‡РµСЃРєРёС… С€СѓС‚РѕРє Р±С‹Р»Р° СЃРѕР·РґР°РЅР° РґР°РЅРЅР°СЏ С‚РµРјР°, РµС‘ С†РµР»СЊ РѕР±СЉСЏСЃРЅРёС‚СЊ Р»СЋРґСЏРј, РєРѕС‚РѕСЂС‹Рµ РµС‰С‘ РЅРµ РїРѕР»СѓС‡РёР»Рё РѕС‚ Р¶РёР·РЅРё РѕРїС‹С‚ РїРѕР·РІРѕР»СЏСЋС‰РёР№ СЂР°Р·Р»РёС‡РёС‚СЊ СѓРјРµСЃС‚РЅРѕСЃС‚СЊ С€СѓС‚РєРё, РєРѕРіРґР°, РєР°Рє Рё С‡С‚Рѕ СѓРјРµСЃС‚РЅРѕ РїРёСЃР°С‚СЊ.

РўР°РєРёРј РѕР±СЂР°Р·РѕРј РјРѕР¶РЅРѕ СЃРґРµР»Р°С‚СЊ РІС‹РІРѕРґ, С‡С‚Рѕ РїСЂРѕС„РµСЃСЃРёРѕРЅР°Р»СЊРЅР°СЏ СЌС‚РёРєР° СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РђРІС‚РѕС€РєРѕР»С‹ РѕРїСЂРµРґРµР»СЏРµС‚СЃСЏ С…Р°СЂР°РєС‚РµСЂРѕРј РѕР±СЏР·Р°РЅРЅРѕСЃС‚РµР№ РІРѕР·Р»РѕР¶РµРЅРЅС‹С… РЅР° РЅР°С€ РєРѕР»Р»РµРєС‚РёРІ. Рђ РѕР±СЏР·Р°РЅРЅРѕСЃС‚Рё Сѓ РЅР°СЃ РѕС‡РµРЅСЊ РІР°Р¶РЅС‹Рµ РґР»СЏ РїРѕРґРґРµСЂР¶Р°РЅРёСЏ Р Рџ Р°С‚РјРѕСЃС„РµСЂС‹. 
Р§РµРј Р¶Рµ РјС‹ Р·Р°РЅСЏС‚С‹? РђРІС‚РѕС€РєРѕР»Р° РёРіСЂР°РµС‚ РІР°Р¶РЅСѓСЋ СЂРѕР»СЊ РЅР° РЅР°С€РµРј СЃРµСЂРІРµСЂРµ РїСЂРµР¶РґРµ РІСЃРµРіРѕ РёР·-Р·Р° С‚РѕРіРѕ, С‡С‚Рѕ СЏРІР»СЏРµС‚СЃСЏ РѕРґРЅРѕР№ РёР· РїРµСЂРІС‹С… РѕСЂРіР°РЅРёР·Р°С†РёР№, С‡Р»РµРЅРѕРІ РєРѕС‚РѕСЂРѕР№ РІСЃС‚СЂРµС‡Р°СЋС‚ РЅРѕРІС‹Рµ РёРіСЂРѕРєРё Рё Р±РµР·СѓСЃР»РѕРІРЅРѕ СЌС‚Рѕ РїРµСЂРІРѕРµ РјРµСЃС‚Рѕ, РіРґРµ РѕРЅРё РїСЂРёРєРѕСЃРЅСѓС‚СЃСЏ Рє РїРѕРЅСЏС‚РёСЋ Р Рџ, Р° Р·РЅР°С‡РёС‚ СЃРѕС‚СЂСѓРґРЅРёРєРё РђРІС‚РѕС€РєРѕР»С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ РјР°РєСЃРёРјР°Р»СЊРЅРѕ Р°РґРµРєРІР°С‚РЅС‹РјРё, РєР°Рє РІ РѕС‚РЅРѕС€РµРЅРёРё Рє РёРіСЂРѕРєР°Рј, С‚Р°Рє Рё РІРѕ РІРЅСѓС‚СЂРµРЅРЅРёС… РІР·Р°РёРјРѕРѕС‚РЅРѕС€РµРЅРёСЏС… РєРѕР»Р»РµРєС‚РёРІР°.

вЂў Р‘РµСЃРїРѕС‡РІРµРЅРЅР°СЏ РіСЂСѓР±РѕСЃС‚СЊ РІ РѕС‚РЅРѕС€РµРЅРёРё Р»СЋР±С‹С… СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РЅРёР¶Рµ РІР°СЃ РїРѕ РєР°СЂСЊРµСЂРЅРѕР№ Р»РµСЃС‚РЅРёС†Рµ, РІ РѕСЃРѕР±РµРЅРЅРѕСЃС‚Рё СЃС‚Р°Р¶РµСЂРѕРІ - СЏРІР»СЏРµС‚СЃСЏ РЅРµРїСЂРёРµРјР»РµРјРѕР№. 
вЂў РЎР»РµРґСѓРµС‚ СЂР°Р·Р»РёС‡Р°С‚СЊ "Р±РµР·РѕР±РёРґРЅСѓСЋ С€СѓС‚РєСѓ", РЅР°Рґ РєРѕС‚РѕСЂРѕР№ РїРѕСЃРјРµСЋС‚СЃСЏ РІСЃРµ РІРѕ РіР»Р°РІРµ СЃ РѕР±СЉРµРєС‚РѕРј С€СѓС‚РєРё Рё С€СѓС‚РєСѓ РєРѕС‚РѕСЂР°СЏ РјРѕР¶РµС‚ Р·Р°С‚СЂРѕРЅСѓС‚СЊ РЅР°С†РёРѕРЅР°Р»СЊРЅС‹Рµ, СЂРµР»РёРіРёРѕР·РЅС‹Рµ, РѕСЃС‚СЂРѕСЃРѕС†РёР°Р»СЊРЅС‹Рµ РІРѕРїСЂРѕСЃС‹, Р° С‚Р°РєР¶Рµ РїСЂРёС‡РёРЅРёС‚СЊ РјРѕСЂР°Р»СЊРЅС‹Р№ РІСЂРµРґ РЅРµРѕРєСЂРµРїС€РёРј СѓРјР°Рј РЅРµРєРѕС‚РѕСЂС‹С… СЋРЅС‹С… РёРіСЂРѕРєРѕРІ. 
вЂў РќРµ СЃС‚РѕРёС‚ Р±СЂР°РІРёСЂРѕРІР°С‚СЊ СЃРІРѕРёРј РѕСЃС‚СЂРѕСѓРјРёРµРј РїРµСЂРµРґ РІСЃРµРјРё, РµСЃР»Рё РёР· РІР°СЃ "С‚Р°Рє Рё РїСЂРµС‚ РѕСЃС‚СЂРѕС‚Р°" - РїРѕРґРµР»РёС‚РµСЃСЊ СЌС‚РёРј СЃ РєРµРј-С‚Рѕ РЅР°РµРґРёРЅРµ, Р° РµСЃР»Рё Сѓ РІР°СЃ РµСЃС‚СЊ РїСЂРµС‚РµРЅР·РёРё СЂРµС€Р°Р№С‚Рµ РёС… РІ /sms С‡Р°С‚. 
вЂў РњР°С‚ СЃС‡РёС‚Р°РµС‚СЃСЏ РЅРµРїСЂРёРµРјР»РµРјС‹Рј. 
вЂў РЎР»РµРґСѓРµС‚ СЃ СѓРІР°Р¶РµРЅРёРµРј РѕС‚РЅРѕСЃРёС‚СЊСЃСЏ Рє С‡РµР»РѕРІРµРєСѓ СЃС‚Р°СЂС€Рµ РІР°СЃ РїРѕ РґРѕР»Р¶РЅРѕСЃС‚Рё, РµСЃР»Рё РІР°Рј РєР°Р¶РµС‚СЃСЏ С‡С‚Рѕ РѕРЅ РІ С‡РµРј-С‚Рѕ РЅРµ РїСЂР°РІ, С‚Рѕ РїРёС€РёС‚Рµ Р»РёРґРµСЂСѓ РІ Р›РЎ. 
вЂў РќРµ РґРѕРїСѓСЃРєР°РµС‚СЃСЏ РІС‹РґР°С‡Р° РёРЅС„РѕСЂРјР°С†РёРё СЃС‚Р°СЂС€РёРј СЃРѕС‚СЂСѓРґРЅРёРєРѕРј РїРѕР»СѓС‡РёРІС€РёРј РµС‘ РѕС‚ РјР»Р°РґС€РµРіРѕ, РєРѕС‚РѕСЂР°СЏ РјРѕР¶РµС‚ РёР·РјРµРЅРёС‚СЊ РѕС‚РЅРѕС€РµРЅРёРµ РѕРєСЂСѓР¶Р°СЋС‰РёС… Рє РЅРµРјСѓ ( РґРѕРїСѓСЃС‚РёРј РµСЃР»Рё РёРіСЂРѕРє СЃРѕРіР»Р°СЃРЅРѕ РїСѓРЅРєС‚Сѓ РІС‹С€Рµ, РїРѕР¶Р°Р»РѕРІР°Р»СЃСЏ Р»РёРґРµСЂСѓ РІ Р›РЎ, Р»РёРґРµСЂ РЅРµ РёРјРµРµС‚ РїСЂР°РІРѕ СЂР°СЃРєСЂС‹РІР°С‚СЊ СЌС‚Рѕ РЅРёРєРѕРјСѓ, РєСЂРѕРјРµ Р°РґРјРёРЅРёСЃС‚СЂР°С†РёРё).

Р—Р° РЅР°СЂСѓС€РµРЅРёРµ СЌС‚РёС… РїСЂР°РІРёР» РІ IC РІС‹ Р±СѓРґРµС‚Рµ СѓРІРѕР»РµРЅС‹ СЃ РїСЂРёС‡РёРЅРѕР№ "РЅР°СЂСѓС€РµРЅРёРµ РїСЂРѕС„. СЌС‚РёРєРё". 
Р—Р° РЅР°СЂСѓС€РµРЅРёРµ СЌС‚РёС… РїСЂР°РІРёР» РІ РћРћРЎ РІС‹ Р±СѓРґРµС‚Рµ СѓРІРѕР»РµРЅС‹ СЃ РїСЂРёС‡РёРЅРѕР№ "Р°РјРѕСЂР°Р»СЊРЅРѕРµ РїРѕРІРµРґРµРЅРёРµ", СЃРѕРіР»Р°СЃРЅРѕ Р Рџ Р»РµРіРµРЅРґРµ РґР»СЏ РІСЃРµС… РІС‹ СЃРѕРІРµСЂС€РёР»Рё РЅРµРєРёР№ Р°РјРѕСЂР°Р»СЊРЅС‹Р№ РїРѕСЃС‚СѓРїРѕРє.
]]

function dmb()
	lua_thread.create(function()
		status = true
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}Р’ СЃРµС‚Рё: "..gcount.." | {ae433d}РћСЂРіР°РЅРёР·Р°С†РёСЏ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- РџРѕРєР°Р·С‹РІР°РµРј РёРЅС„РѕСЂРјР°С†РёСЋ.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}Р’ СЃРµС‚Рё: "..gcount.." | {ae433d}РћСЂРіР°РЅРёР·Р°С†РёСЏ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- РџРѕРєР°Р·С‹РІР°РµРј РёРЅС„РѕСЂРјР°С†РёСЋ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		players2 = {'{ffffff}РќРёРє\t{ffffff}Р Р°РЅРі\t{ffffff}РЎС‚Р°С‚СѓСЃ'}
		players1 = {'{ffffff}РќРёРє\t{ffffff}Р Р°РЅРі'}
		gcount = nil
	end)
end

function dlog()
    sampShowDialog(97987, '{47f4f0}Inst Tools {ffffff} | Р›РѕРі СЃРѕРѕР±С‰РµРЅРёР№ РґРµРїР°СЂС‚Р°РјРµРЅС‚Р°', table.concat(departament, '\n'), 'В»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'РњР».РњРµРЅРµРґР¶РµСЂ' or rank == 'РЎС‚.РњРµРЅРµРґР¶РµСЂ' or rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
  if id == nil then
    sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| Р’РІРµРґРёС‚Рµ: /vig ID РџСЂРёС‡РёРЅР°", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| РРіСЂРѕРє СЃ ID: "..id.." РЅРµ РїРѕРґРєР»СЋС‡РµРЅ Рє СЃРµСЂРІРµСЂСѓ.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{47f4f0}Inst Tools {ffffff}| Р’РІРµРґРёС‚Рµ: /vig ID РџР РР§РРќРђ", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - РџРѕР»СѓС‡Р°РµС‚ РІС‹РіРѕРІРѕСЂ РїРѕ РїСЂРёС‡РёРЅРµ: %s.", cfg.main.tarr, rpname, pric))
		else 
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - РџРѕР»СѓС‡Р°РµС‚ РІС‹РіРѕРІРѕСЂ РїРѕ РїСЂРёС‡РёРЅРµ: %s.", rpname, pric))
      end
  end
end
end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'РЎС‚Р°Р¶РµСЂ',
		['2'] = 'РљРѕРЅСЃСѓР»СЊС‚Р°РЅС‚',
		['3'] = 'Р­РєР·Р°РјРµРЅР°С‚РѕСЂ',
		['4'] = 'РњР».РРЅСЃС‚СЂСѓРєС‚РѕСЂ',
		['5'] = 'РРЅСЃС‚СЂСѓРєС‚РѕСЂ',
		['6'] = 'РљРѕРѕСЂРґРёРЅР°С‚РѕСЂ',
		['7'] = 'РњР».РњРµРЅРµРґР¶РµСЂ',
		['8'] = 'РЎС‚.РњРµРЅРµРґР¶РµСЂ',
		['9'] = 'Р”РёСЂРµРєС‚РѕСЂ'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if cfg.main.givra then
	if sampIsPlayerConnected(id) then
	  if rank == 'РњР».РњРµРЅРµРґР¶РµСЂ' or rank == 'РЎС‚.РњРµРЅРµРґР¶РµСЂ' or rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
				sampSendChat('/me СЃРЅСЏР»(Р°) СЃС‚Р°СЂС‹Р№ Р±РµР№РґР¶РёРє СЃ С‡РµР»РѕРІРµРєР° РЅР°РїСЂРѕС‚РёРІ СЃС‚РѕСЏС‰РµРіРѕ')
				wait(1500)
				sampSendChat('/me СѓР±СЂР°Р»(Р°) СЃС‚Р°СЂС‹Р№ Р±РµР№РґР¶РёРє РІ РєР°СЂРјР°РЅ')
				wait(1500)
                sampSendChat(string.format('/me РґРѕСЃС‚Р°Р»(Р°) РЅРѕРІС‹Р№ Р±РµР№РґР¶РёРє СЃ РЅР°РґРїРёСЃСЊСЋ "%s"', ranks))
				wait(1500)
				sampSendChat('/me Р·Р°РєСЂРµРїРёР»Р°(Р°) РЅР° СЂСѓР±Р°С€РєСѓ С‡РµР»РѕРІРµРєСѓ РЅР° РїСЂРѕС‚РёРІ РЅРѕРІС‹Р№ Р±РµР№РґР¶РёРє')
				wait(1500)
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(1500)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РґРѕ "%s".', cfg.main.tarr, plus == '+' and 'РџРѕРІС‹С€РµРЅ(Р°)' or 'РџРѕРЅРёР¶РµРЅ(Р°)', ranks))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s РІ РґРѕР»Р¶РЅРѕСЃС‚Рё РґРѕ "%s".', plus == '+' and 'РџРѕРІС‹С€РµРЅ(Р°)' or 'РџРѕРЅРёР¶РµРЅ(Р°)', ranks))
            end
			else 
			ftext('Р’С‹ РІРІРµР»Рё РЅРµРІРµСЂРЅС‹Р№ С‚РёРї [+/-]')
		end
		else 
			ftext('Р’РІРµРґРёС‚Рµ: /giverank [id] [СЂР°РЅРі] [+/-]')
		end
		else 
			ftext('Р”Р°РЅРЅР°СЏ РєРѕРјР°РЅРґР° РґРѕСЃС‚СѓРїРЅР° СЃ 7 СЂР°РЅРіР°')
	  end
	  else 
			ftext('РРіСЂРѕРє СЃ РґР°РЅРЅС‹Рј ID РЅРµ РїРѕРґРєР»СЋС‡РµРЅ Рє СЃРµСЂРІРµСЂСѓ РёР»Рё СѓРєР°Р·Р°РЅ РІР°С€ ID')
	  end
	end
   end)
 end

function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me РґРѕСЃС‚Р°Р»(Р°) Р±РµР№РґР¶РёРє Рё РїРµСЂРµРґР°Р»(Р°) РµРіРѕ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1500)
				sampSendChat(string.format('/invite %s', id))
				wait(5000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: РќРѕРІС‹Р№ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ - '..sampGetPlayerNickname(id):gsub('_', ' ')..'.', cfg.main.tarr))
                else
				sampSendChat('/r РќРѕРІС‹Р№ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ - '..sampGetPlayerNickname(id):gsub('_', ' ')..'.')
            end
			else 
			ftext('РРіСЂРѕРє СЃ РґР°РЅРЅС‹Рј ID РЅРµ РїРѕРґРєР»СЋС‡РµРЅ Рє СЃРµСЂРІРµСЂСѓ РёР»Рё СѓРєР°Р·Р°РЅ РІР°С€ ID')
		end
		else 
			ftext('Р’РІРµРґРёС‚Рµ: /invite [id]')
		end
		else 
			ftext('Р”Р°РЅРЅР°СЏ РєРѕРјР°РЅРґР° РґРѕСЃС‚СѓРїРЅР° СЃ 9 СЂР°РЅРіР°')
	  end
   end)
 end
 
 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'РЎС‚.РњРµРЅРµРґР¶РµСЂ' or rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me Р·Р°Р±СЂР°Р»(Р°) Р±РµР№РґР¶РёРє Сѓ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
				wait(2000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - РЈРІРѕР»РµРЅ РїРѕ РїСЂРёС‡РёРЅРµ "%s".', cfg.main.tarr, pri4ina))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - РЈРІРѕР»РµРЅ РїРѕ РїСЂРёС‡РёРЅРµ "%s".', pri4ina))
            end
			else 
			ftext('РРіСЂРѕРє СЃ РґР°РЅРЅС‹Рј ID РЅРµ РїРѕРґРєР»СЋС‡РµРЅ Рє СЃРµСЂРІРµСЂСѓ РёР»Рё СѓРєР°Р·Р°РЅ РІР°С€ ID')
		end
		else 
			ftext('Р’РІРµРґРёС‚Рµ: /uninvite [id] [РїСЂРёС‡РёРЅР°]')
		end
		else 
			ftext('Р”Р°РЅРЅР°СЏ РєРѕРјР°РЅРґР° РґРѕСЃС‚СѓРїРЅР° СЃ 8 СЂР°РЅРіР°')
	  end
   end)
 end
 
function thelp()
    lua_thread.create(function()
        submenus_show(thelpsub(), '{47f4f0}Inst Tools {ffffff}| Help')
    end)
end

function thelpsub()
    return
{
    {
        title = '{47f4f0}/tset {ffffff}- РћС‚РєСЂС‹С‚СЊ РјРµРЅСЋ СЃРєСЂРёРїС‚Р°',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/tset')
        end
    },
    {
        title = '{47f4f0}/thelp {ffffff} - РџРѕРјРѕС‰СЊ РїРѕ СЃРєСЂРёРїС‚Сѓ',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/thelp ')
        end
    },
    {
        title = '{47f4f0}/vig [id] РџСЂРёС‡РёРЅР°{ffffff} - Р’С‹РґР°С‚СЊ РІС‹РіРѕРІРѕСЂ РїРѕ СЂР°С†РёРё',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/vig ')
        end
    },
	{
        title = '{47f4f0}/dmb {ffffff} - РћС‚РєСЂС‹С‚СЊ /members РІ РґРёР°Р»РѕРіРµ',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/dmb ')
        end
    },
	{
        title = '{47f4f0}/yst {ffffff} - РћС‚РєСЂС‹С‚СЊ СѓСЃС‚Р°РІ РђРЁ',
        onclick = function()
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/yst ')
        end
    },
	{
        title = '{47f4f0}/dlog{ffffff} - РћС‚РєСЂС‹С‚СЊ Р»РѕРі 25 РїРѕСЃР»РµРґРЅРёС… СЃРѕРѕР±С‰РµРЅРёР№ РІ РґРµРїР°СЂС‚Р°РјРµРЅС‚',
        onclick = function()
            sampSetChatInputText('/dlog')
            sampSetChatInputEnabled(true)
        end
    },
    {
        title = '{47f4f0}РљР»Р°РІРёС€Рё:',
        onclick = function()
        end
    },
	{
        title = '{47f4f0}РџРљРњ+Z РЅР° РёРіСЂРѕРєР° {ffffff}- РњРµРЅСЋ РІР·Р°РёРјРѕРґРµР№СЃС‚РІРёСЏ',
        onclick = function()
        end
    },
    {
        title = '{47f4f0}'..key.id_to_name(cfg.keys.fastmenu)..' {ffffff}- "Р‘С‹СЃС‚СЂРѕРµ РјРµРЅСЋ"',
        onclick = function()
        end
    }
}
end

function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}РњРµРЅСЋ {47f4f0}Р»РµРєС†РёР№",
    onclick = function()
	submenus_show(fthmenu(id), "{47f4f0}IT {ffffff}| РњРµРЅСЋ Р»РµРєС†РёР№")
	end
   },
    {
   title = "{FFFFFF}РњРµРЅСЋ {47f4f0}РіРѕСЃ.РЅРѕРІРѕСЃС‚РµР№ {ff0000}(Р”Р»СЏ РЎС‚.РЎРѕСЃС‚Р°РІР°)",
    onclick = function()
	if rank == 'РњР».РњРµРЅРµРґР¶РµСЂ' or rank == 'РЎС‚.РњРµРЅРµРґР¶РµСЂ' or rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
	submenus_show(govmenu(id), "{47f4f0}IT {ffffff}| РњРµРЅСЋ РіРѕСЃ.РЅРѕРІРѕСЃС‚РµР№")
	else
	ftext('Р’С‹ РЅРµ РЅР°С…РѕРґРёС‚РµСЃСЊ РІ РЎС‚.РЎРѕСЃС‚Р°РІРµ')
	end
	end
   },
   {
   title = "{FFFFFF}РњРµРЅСЋ {47f4f0}РѕС‚РґРµР»РѕРІ",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{47f4f0}IT {ffffff}| РњРµРЅСЋ РѕС‚РґРµР»РѕРІ")
	else
	ftext('Р’РєР»СЋС‡РёС‚Рµ Р°РІС‚РѕС‚РµРі РІ РЅР°СЃС‚СЂРѕР№РєР°С…')
	end
	end
   },
   {
   title = "{FFFFFF}Р”РѕСЃС‚Р°РІРєР° Р»РёС†РµРЅР·РёР№ {47f4f0}РІ Р»СЋР±СѓСЋ С‚РѕС‡РєСѓ С€С‚Р°С‚Р° РІ /d{ff0000}(Р”Р»СЏ 4+ СЂР°РЅРіР°)",
    onclick = function()
	if rank == 'РњР».РРЅСЃС‚СЂСѓРєС‚РѕСЂ' or rank == 'РРЅСЃС‚СЂСѓРєС‚РѕСЂ' or rank == 'РљРѕРѕСЂРґРёРЅР°С‚РѕСЂ' or rank == 'РњР».РњРµРЅРµРґР¶РµСЂ' or rank == 'РЎС‚.РњРµРЅРµРґР¶РµСЂ' or rank == 'Р”РёСЂРµРєС‚РѕСЂ' or  rank == 'РЈРїСЂР°РІР»СЏСЋС‰РёР№' then
	sampSendChat(string.format('/d OG, РћСЃСѓС‰РµСЃС‚РІР»СЏРµС‚СЃСЏ РґРѕСЃС‚Р°РІРєР° Р»РёС†РµРЅР·РёР№ РІ Р»СЋР±СѓСЋ С‚РѕС‡РєСѓ С€С‚Р°С‚Р°. РўРµР»: %s.', tel))
	else
	ftext('Р’Р°С€ СЂР°РЅРі РЅРµРґРѕСЃС‚Р°С‚РѕС‡РЅРѕ РІС‹СЃРѕРє')
	end
	end
   }
}
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}РџРёР°СЂ РѕС‚РґРµР»Р° РІ СЂР°С†РёСЋ (РћРЎ) {ff0000}(Р”Р»СЏ РіР»Р°РІ/Р·Р°РјРѕРІ РѕС‚РґРµР»Р°)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: РЈРІР°Р¶Р°РµРјС‹Рµ СЃРѕС‚СЂСѓРґРЅРёРєРё, РјРёРЅСѓС‚РѕС‡РєСѓ РІРЅРёРјР°РЅРёСЏ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р’ РћС‚РґРµР» РЎС‚Р°Р¶РёСЂРѕРІРєРё РїСЂРѕРёР·РІРѕРґРёС‚СЃСЏ РїРѕРїРѕР»РЅРµРЅРёРµ СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р’СЃС‚СѓРїРёС‚СЊ РІ РѕС‚РґРµР» РјРѕР¶РЅРѕ СЃ РґРѕР»Р¶РЅРѕСЃС‚Рё "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р”Р»СЏ РїРѕРґСЂРѕР±РЅРѕР№ РёРЅС„РѕСЂРјР°С†РёРё РїРёС€РёС‚Рµ РЅР° Рї.'..myid..'.', cfg.main.tarr))
	end
   },
    {
   title = "{FFFFFF}РџРёР°СЂ РѕС‚РґРµР»Р° РІ СЂР°С†РёСЋ (ID) {ff0000}(Р”Р»СЏ РіР»Р°РІ/Р·Р°РјРѕРІ РѕС‚РґРµР»Р°)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: РЈРІР°Р¶Р°РµРјС‹Рµ СЃРѕС‚СЂСѓРґРЅРёРєРё, РјРёРЅСѓС‚РѕС‡РєСѓ РІРЅРёРјР°РЅРёСЏ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р’ Inspection Department РїСЂРѕРёР·РІРѕРґРёС‚СЃСЏ РїРѕРїРѕР»РЅРµРЅРёРµ СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р’СЃС‚СѓРїРёС‚СЊ РІ РѕС‚РґРµР» РјРѕР¶РЅРѕ СЃ РґРѕР»Р¶РЅРѕСЃС‚Рё "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Р”Р»СЏ РїРѕРґСЂРѕР±РЅРѕР№ РёРЅС„РѕСЂРјР°С†РёРё РїРёС€РёС‚Рµ РЅР° Рї.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}РўРµС….РѕСЃРјРѕС‚СЂ Р°РІС‚Рѕ РіРѕСЃ.РѕСЂРіР°РЅРёР·Р°С†РёР№",
    onclick = function()
	if cfg.main.male == true then
	sampSendChat("/me Р·Р°РїРёСЃР°Р» РґР°РЅРЅС‹Рµ Рѕ РїСЂРѕРІРµСЂСЏРµРјРѕР№ РіРѕСЃ.РѕСЂРіР°РЅРёР·Р°С†РёРё")
    wait(3500)
    sampSendChat("/me РЅР°С‡Р°Р» РѕСЃРјР°С‚СЂРёРІР°С‚СЊ РІРЅРµС€РЅРµРµ СЃРѕСЃС‚РѕСЏРЅРёРµ Р°РІС‚РѕРјРѕР±РёР»СЏ")
    wait(3500)
    sampSendChat("/me РѕС‚РєСЂС‹Р» РєР°РїРѕС‚")
    wait(3500)
    sampSendChat("/do РљР°РїРѕС‚ РѕС‚РєСЂС‹С‚.")
	wait(3500)
	sampSendChat("/me РґРѕСЃС‚Р°Р» СЃ С‡РµРјРѕРґР°РЅР° РґР»СЏ РёРЅСЃС‚СЂСѓРјРµРЅС‚РѕРІ С„РѕРЅР°СЂРёРє Рё РЅР°С‡Р°Р» РѕСЃРјР°С‚СЂРёРІР°С‚СЊ РґРІРёРіР°С‚РµР»СЊ")
	wait(3500)
	sampSendChat("/try РґРІРёРіР°С‚РµР»СЊ РІ РЅРѕСЂРјРµ")
	wait(3500)
	sampSendChat("/me РЅР°С‡Р°Р» РїСЂРѕРІРµСЂСЏС‚СЊ РґР°РІР»РµРЅРёРµ РІ С€РёРЅР°С….")
	wait(3500)
	sampSendChat("/try РґР°РІР»РµРЅРёРµ РІ РЅРѕСЂРјРµ")
	wait(3500)
	sampSendChat("/me РїСЂРѕРІРµСЂСЏРµС‚ Р°РІС‚РѕРјРѕР±РёР»СЊ РЅР° РЅР°Р»РёС‡РёРµ РїРѕРІСЂРµР¶РґРµРЅРёР№")
	wait(3500)
	sampSendChat("/try РїРѕРІСЂРµР¶РґРµРЅРёСЏ РЅРµ РѕР±РЅР°СЂСѓР¶РµРЅС‹")
	wait(3500)
	sampSendChat("/me РґРѕСЃС‚Р°Р» Р±Р»РѕРєРЅРѕС‚ СЃ СЂСѓС‡РєРѕР№, РїРѕСЃР»Рµ С‡РµРіРѕ Р·Р°РїРёСЃР°Р» РІСЃРµ СЂРµР·СѓР»СЊС‚Р°С‚С‹ РїСЂРѕРІРµСЂРєРё")
	wait(3500)
	sampSendChat("/me РїРѕСЃС‚Р°РІРёР» РїРѕРґРїРёСЃСЊ Рё Р·Р°РєСЂС‹Р» Р±Р»РѕРєРЅРѕС‚")
	end
	if cfg.main.male == false then
	sampSendChat("/me Р·Р°РїРёСЃР°Р»Р° РґР°РЅРЅС‹Рµ Рѕ РїСЂРѕРІРµСЂСЏРµРјРѕР№ РіРѕСЃ.РѕСЂРіР°РЅРёР·Р°С†РёРё")
    wait(3500)
    sampSendChat("/me РЅР°С‡Р°Р»Р° РѕСЃРјР°С‚СЂРёРІР°С‚СЊ РІРЅРµС€РЅРµРµ СЃРѕСЃС‚РѕСЏРЅРёРµ Р°РІС‚РѕРјРѕР±РёР»СЏ")
    wait(3500)
    sampSendChat("/me РѕС‚РєСЂС‹Р»Р° РєР°РїРѕС‚")
    wait(3500)
    sampSendChat("/do РљР°РїРѕС‚ РѕС‚РєСЂС‹С‚.")
	wait(3500)
	sampSendChat("/me РґРѕСЃС‚Р°Р»Р° СЃ С‡РµРјРѕРґР°РЅР° РґР»СЏ РёРЅСЃС‚СЂСѓРјРµРЅС‚РѕРІ С„РѕРЅР°СЂРёРє Рё РЅР°С‡Р°Р»Р° РѕСЃРјР°С‚СЂРёРІР°С‚СЊ РґРІРёРіР°С‚РµР»СЊ")
	wait(3500)
	sampSendChat("/try РґРІРёРіР°С‚РµР»СЊ РІ РЅРѕСЂРјРµ")
	wait(3500)
	sampSendChat("/me РЅР°С‡Р°Р»Р° РїСЂРѕРІРµСЂСЏС‚СЊ РґР°РІР»РµРЅРёРµ РІ С€РёРЅР°С….")
	wait(3500)
	sampSendChat("/try РґР°РІР»РµРЅРёРµ РІ РЅРѕСЂРјРµ")
	wait(3500)
	sampSendChat("/me РїСЂРѕРІРµСЂСЏРµС‚ Р°РІС‚РѕРјРѕР±РёР»СЊ РЅР° РЅР°Р»РёС‡РёРµ РїРѕРІСЂРµР¶РґРµРЅРёР№")
	wait(3500)
	sampSendChat("/try РїРѕРІСЂРµР¶РґРµРЅРёСЏ РЅРµ РѕР±РЅР°СЂСѓР¶РµРЅС‹")
	wait(3500)
	sampSendChat("/me РґРѕСЃС‚Р°Р»Р° Р±Р»РѕРєРЅРѕС‚ СЃ СЂСѓС‡РєРѕР№, РїРѕСЃР»Рµ С‡РµРіРѕ Р·Р°РїРёСЃР°Р»Р° РІСЃРµ СЂРµР·СѓР»СЊС‚Р°С‚С‹ РїСЂРѕРІРµСЂРєРё")
	wait(3500)
	sampSendChat("/me РїРѕСЃС‚Р°РІРёР»Р° РїРѕРґРїРёСЃСЊ Рё Р·Р°РєСЂС‹Р»Р° Р±Р»РѕРєРЅРѕС‚")
	end
	end
   }
}
end

function govmenu(id)
 return
{
  {
   title = "{FFFFFF}РЎРѕР±РµСЃРµРґРѕРІР°РЅРёРµ",
    onclick = function()
	sampSendChat("/d OG, Р·Р°РЅСЏР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
    wait(5000)
    sampSendChat("/gov [Instructors]: РЈРІР°Р¶Р°РµРјС‹Рµ Р¶РёС‚РµР»Рё С€С‚Р°С‚Р°, РїРѕР¶Р°Р»yР№СЃС‚Р°, РїСЂРѕСЃР»yС€Р°Р№С‚Рµ РѕР±СЉСЏРІР»РµРЅРёРµ.")
    wait(5000)
    sampSendChat('/gov [Instructors]: Р’ РґР°РЅРЅС‹Р№ РјРѕРјРµРЅС‚ РІ РѕС„РёСЃРµ РђРІС‚РѕС€РєРѕР»С‹ РїСЂРѕС…РѕРґРёС‚ СЃРѕР±РµСЃРµРґРѕРІР°РЅРёРµ РЅР° РґРѕР»Р¶РЅРѕСЃС‚СЊ "РЎС‚Р°Р¶РµСЂ".')
    wait(5000)
    sampSendChat("/gov [Instructors]: РўСЂРµР±РѕРІР°РЅРёСЏ Рє СЃРѕРёСЃРєР°С‚РµР»СЏРј: РЁРµСЃС‚СЊ Р»РµС‚ РїСЂРѕР¶РёРІР°РЅРёСЏ РІ С€С‚Р°С‚Рµ, СЃС‚СЂРµСЃСЃРѕСѓСЃС‚РѕР№С‡РёРІРѕСЃС‚СЊ, РѕРїСЂСЏС‚РЅС‹Р№ РІРёРґ.")
    wait(5000)
    sampSendChat("/d OG, РѕСЃРІРѕР±РѕРґРёР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
	end
   },
    {
   title = "{FFFFFF}Р—Р°СЏРІРєР° РЅР° СЌРєР·Р°РјРµРЅР°С‚РѕСЂР°",
    onclick = function()
	sampSendChat("/d OG, Р·Р°РЅСЏР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
        wait(5000)
        sampSendChat("/gov [Instructors]: РЈРІР°Р¶Р°РµРјС‹Рµ Р¶РёС‚РµР»Рё С€С‚Р°С‚Р°, РїРѕР¶Р°Р»yР№СЃС‚Р°, РїСЂРѕСЃР»yС€Р°Р№С‚Рµ РѕР±СЉСЏРІР»РµРЅРёРµ.")
        wait(5000)
        sampSendChat('/gov [Instructors]: Р’ РґР°РЅРЅС‹Р№ РјРѕРјРµРЅС‚ РѕС‚РєСЂС‹С‚С‹ Р·Р°СЏРІР»РµРЅРёСЏ РЅР° РґРѕР»Р¶РЅРѕСЃС‚СЊ "Р­РєР·Р°РјРµРЅР°С‚РѕСЂ".')
        wait(5000)
        sampSendChat("/gov [Instructors]: РЎРѕ РІСЃРµРјРё РєСЂРёС‚РµСЂРёСЏРјРё, Р’С‹ РјРѕР¶РµС‚Рµ РѕР·РЅР°РєРѕРјРёС‚СЊСЃСЏ РЅР° РѕС„.РїРѕСЂС‚Р°Р»Рµ С€С‚Р°С‚Р°. ")
        wait(5000)
        sampSendChat("/d OG, РѕСЃРІРѕР±РѕРґРёР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
	end
   },
   {
   title = "{FFFFFF}РџРёР°СЂ С„РёР»РёР°Р»Р° РјСЌСЂРёРё",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, Р·Р°РЅСЏР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
        wait(5000)
        sampSendChat("/gov [Instructors]: РЈРІР°Р¶Р°РµРјС‹Рµ Р¶РёС‚РµР»Рё С€С‚Р°С‚Р°, РїРѕР¶Р°Р»yР№СЃС‚Р°, РїСЂРѕСЃР»yС€Р°Р№С‚Рµ РѕР±СЉСЏРІР»РµРЅРёРµ.")
        wait(5000)
        sampSendChat('/gov [Instructors]: РђРІС‚РѕС€РєРѕР»Р° СЂР°СЃС€РёСЂСЏРµС‚СЃСЏ Рё РїСЂРµРґРѕСЃС‚Р°РІР»СЏРµС‚ СѓСЃР»СѓРіРё РїРѕ РІС‹РґР°С‡Рµ Р»РёС†РµРЅР·РёР№ РІ РЅР°С€РµРј С„РёР»РёР°Р»Рµ.')
        wait(5000)
        sampSendChat('/gov [Instructors]: Р¤РёР»РёР°Р» РЅР°С…РѕРґРёС‚СЃСЏ РЅР° РїРµСЂРІРѕРј СЌС‚Р°Р¶Рµ РњСЌСЂРёРё. РЎ СѓРІР°Р¶РµРЅРёРµРј, '..rank..' РђРІС‚РѕС€РєРѕР»С‹ - '..myname:gsub('_', ' ')..'.')
        wait(5000)
        sampSendChat("/d OG, РѕСЃРІРѕР±РѕРґРёР» РІРѕР»РЅСѓ РіРѕСЃСѓРґР°СЂСЃС‚РІРµРЅРЅС‹С… РЅРѕРІРѕСЃС‚РµР№.")
	end
   },
   {
   title = "{FFFFFF}Р—Р°РЅСЏС‚СЊ РіРѕСЃ. РІРѕР»РЅСѓ",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Р—Р°РЅРёРјР°СЋ РіРѕСЃ.РІРѕР»РЅСѓ РЅР°")
	end
   },
   {
   title = "{FFFFFF}РќР°РїРѕРјРЅРёС‚СЊ Рѕ Р·Р°Р№РјРµ РіРѕСЃ. РІРѕР»РЅС‹",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, РќР°РїРѕРјРёРЅР°СЋ С‡С‚Рѕ РІРѕР»РЅР° РіРѕСЃ.РЅРѕРІРѕСЃС‚РµР№ Р·Р° РђРІС‚РѕС€РєРѕР»РѕР№ РЅР°")
	end
   }
}
end

function fthmenu(id)
 return
{
  {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РґР»СЏ {47f4f0}РЎС‚Р°Р¶С‘СЂР°",
    onclick = function()
	    sampSendChat("РџСЂРёРІРµС‚СЃС‚РІСѓСЋ. Р’С‹ РїСЂРёРЅСЏС‚С‹ РЅР° РЎС‚Р°Р¶РёСЂРѕРІРєСѓ РІ РђРІС‚РѕС€РєРѕР»Сѓ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("/me РїРµСЂРµРґР°Р»(Р°) Р±РµР№РґР¶РёРє РЎС‚Р°Р¶РµСЂР° РђРІС‚РѕС€РєРѕР»С‹ ")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b /clist 23 ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎС‚Р°Р¶РёСЂРѕРІРєР° РґР»РёС‚СЃСЏ РґРѕ С‚РѕРіРѕ РјРѕРјРµРЅС‚Р°, РїРѕРєР° РІС‹ РЅРµ Р±СѓРґРµС‚Рµ РїРѕРІС‹С€РµРЅС‹ РґРѕ РљРѕРЅСЃСѓР»СЊС‚Р°РЅС‚Р°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р—Р°РїСЂРµС‰РµРЅРѕ РїСЂРѕСЃРёС‚СЊ РїРѕРІС‹С€РµРЅРёСЏ РёР»Рё РЅР°Р·РЅР°С‡РµРЅРёСЏ РЅР° СѓРїСЂР°РІР»СЏСЋС‰СѓСЋ РґРѕР»Р¶РЅРѕСЃС‚СЊ РІ Р»СЋР±РѕР№ С„РѕСЂРјРµ. РљР°Рє РїСЂРёРґРµС‚ СЃСЂРѕРє Р’Р°СЃ РІС‹Р·РѕРІСѓС‚. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћР±СЏР·Р°РЅРЅРѕСЃС‚Рё СЃС‚Р°Р¶С‘СЂРѕРІ: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎРјРѕС‚СЂРµС‚СЊ РєР°Рє СЂР°Р±РѕС‚Р°СЋС‚ РєРѕР»Р»РµРіРё Рё СѓС‡РёС‚СЊСЃСЏ Сѓ РЅРёС…. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’ СЂР°Р±РѕС‡РµРµ РІСЂРµРјСЏ РЅР°С…РѕРґРёС‚СЊСЃСЏ РІ РѕС„РёСЃРµ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РР·СѓС‡Р°С‚СЊ СѓСЃС‚Р°РІ Рё РїСЂР°РІРёР»Р° Р°РІС‚РѕС€РєРѕР»С‹. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р”Р»СЏ РїРѕРІС‹С€РµРЅРёСЏ РІ РґРѕР»Р¶РЅРѕСЃС‚Рё, Р’Р°Рј РЅСѓР¶РЅРѕ Р±СѓРґРµС‚ СЃРґР°С‚СЊ СЌРєР·Р°РјРµРЅ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’СЃРµРіРѕ Сѓ РІР°СЃ Р±СѓРґРµС‚ РѕРґРёРЅ СЌРєР·Р°РјРµРЅ - РґР»СЏ РїРѕРІС‹С€РµРЅРёСЏ РґРѕ РєРѕРЅСЃСѓР»СЊС‚Р°РЅС‚Р°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р­РєР·Р°РјРµРЅ СЃРѕСЃС‚РѕРёС‚ РёР· РґРІСѓС… С‡Р°СЃС‚РµР№: РЈСЃС‚Р°РІ Рё СЂР°СЃС†РµРЅРєРё РЅР° Р»РёС†РµРЅР·РёРё. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р­РєР·Р°РјРµРЅ СЃРѕСЃС‚РѕРёС‚СЃСЏ РЅРµ СЂР°РЅСЊС€Рµ С‡РµРј С‡РµСЂРµР· 3 С‡Р°СЃР° РїРѕСЃР»Рµ РїСЂРёРЅСЏС‚РёСЏ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b РЈСЃС‚Р°РІ Рё СЂР°СЃС†РµРЅРєРё РЅР° Р»РёС†РµРЅР·РёРё РјРѕР¶РЅРѕ РЅР°Р№С‚Рё РЅР° С„РѕСЂСѓРјРµ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р”Р°Р±С‹ РѕС‚Р±СЂРѕСЃРёС‚СЊ С‡Р°СЃС‚С‹Рµ РІРѕРїСЂРѕСЃС‹:")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎС‚Р°Р¶РµСЂ РјРѕР¶РµС‚ РІС‹РґР°РІР°С‚СЊ С‚РѕР»СЊРєРѕ РїСЂР°РІР°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎС‚Р°Р¶РµСЂР°РјРё СЃС‡РёС‚Р°СЋС‚СЃСЏ СЃРѕС‚СЂСѓРґРЅРёРєРё, РЅР°С…РѕРґСЏС‰РёРµСЃСЏ РЅР° РґРѕР»Р¶РЅРѕСЃС‚Рё РЎС‚Р°Р¶С‘СЂ Рё Р­РєР·Р°РјРµРЅР°С‚РѕСЂ (РїРѕ Р·Р°СЏРІРєРµ). ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћС„РёСЃ СЂР°Р·СЂРµС€РµРЅРѕ РїРѕРєРёРґР°С‚СЊ С‚РѕР»СЊРєРѕ СЃ СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚. РЎРѕСЃС‚Р°РІР°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’РµСЂС‚РѕР»РµС‚ РјРѕР¶РЅРѕ Р±СЂР°С‚СЊ С‚РѕР¶Рµ С‚РѕР»СЊРєРѕ СЃ СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚. РЎРѕСЃС‚Р°РІР°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р—Р° СЃС‚РѕР»Р°РјРё СЃРїР°С‚СЊ Р·Р°РїСЂРµС‰РµРЅРѕ. РЎРїР°С‚СЊ СЂР°Р·СЂРµС€РµРЅРѕ С‚РѕР»СЊРєРѕ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat('/b Р’ С‚РµРјРµ "РџРѕРјРѕС‰СЊ РґР»СЏ РЅРѕРІРёС‡РєРѕРІ" РµСЃС‚СЊ РІСЃРµ РЅСѓР¶РЅС‹Рµ Р±РёРЅРґС‹, Р±РµР· РЅРёС… РЅРµ СЂР°Р±РѕС‚Р°С‚СЊ! ')
        wait(cfg.commands.zaderjka)
        sampSendChat("Р•СЃР»Рё РІРѕР·РЅРёРєРЅСѓС‚ РІРѕРїСЂРѕСЃС‹ РѕР±СЂР°С‰Р°Р№С‚РµСЃСЊ Рє РЎРѕС‚СЂСѓРґРЅРёРєР°Рј РћС‚РґРµР»Р° РЎС‚Р°Р¶РёСЂРѕРІРєРё Р»РёР±Рѕ Рє СЃС‚. РЎРѕСЃС‚Р°РІСѓ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎРїР°СЃРёР±Рѕ,С‡С‚Рѕ РїСЂРѕСЃР»СѓС€Р°Р»Рё РјРѕСЋ Р»РµРєС†РёСЋ. ")
    end
  },
   {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РґР»СЏ {47f4f0}Р­РєР·Р°РјРµРЅР°С‚РѕСЂР°",
    onclick = function()
	sampSendChat("РџСЂРёРІРµС‚СЃС‚РІСѓСЋ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРѕСЃРєРѕР»СЊРєСѓ РІС‹ РїСЂРёРЅСЏС‚С‹ РїРѕ Р·Р°СЏРІРєРµ РЅР° РґРѕР»Р¶РЅРѕСЃС‚СЊ Р­РєР·Р°РјРµРЅР°С‚РѕСЂР°, РІР°Рј РЅРµРѕР±С…РѕРґРёРјРѕ РѕРїСЂРµРґРµР»РёС‚СЊСЃСЏ СЃ РѕС‚РґРµР»РѕРј.")
        wait(cfg.commands.zaderjka)
        sampSendChat("/b /clist 19")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћРЎ - РѕС‚РґРµР» СЃС‚Р°Р¶РёСЂРѕРІРєРё, Р·Р°РЅРёРјР°СЋС‰РёР№СЃСЏ РЅРµРїРѕСЃСЂРµРґСЃС‚РІРµРЅРЅРѕ РѕР±СѓС‡РµРЅРёРµРј СЃС‚Р°Р¶С‘СЂРѕРІ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("ID - Inspection Department, Р·Р°РЅРёРјР°СЋС‰РёР№СЃСЏ РїСЂРѕС„РёР»Р°РєС‚РёРєРѕР№ РЅР°СЂСѓС€РµРЅРёР№ Рё Р°РІР°СЂРёР№РЅС‹С… СЃРёС‚СѓР°С†РёР№.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎ СѓС‡Р°СЃС‚РёРµРј С‚СЂР°РЅСЃРїРѕСЂС‚Р°, С‡РµСЂРµР· РїСЂРѕРІРµРґРµРЅРёРµ Р»РµРєС†РёР№ Рё РїСЂРѕРІРµСЂРѕРє РіРѕСЃ. СЃС‚СЂСѓРєС‚СѓСЂ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРѕСЃР»Рµ С‡РµС‚РµСЂРµС… РґРЅРµР№ Р°РєС‚РёРІРЅРѕР№ СЂР°Р±РѕС‚С‹.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’С‹ РїРѕР»СѓС‡РёС‚Рµ Р±РµР№РґР¶РёРє РњР».РРЅСЃС‚СЂСѓРєС‚РѕСЂР° Рё Р±СѓРґРµС‚Рµ СЃС‡РёС‚Р°С‚СЊСЃСЏ РїРѕР»РЅРѕС†РµРЅРЅС‹Рј СЃРѕС‚СЂСѓРґРЅРёРєРѕРј.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р—Р°РїСЂРµС‰РµРЅРѕ РїСЂРѕСЃРёС‚СЊ РїРѕРІС‹С€РµРЅРёСЏ РёР»Рё РЅР°Р·РЅР°С‡РµРЅРёСЏ РЅР° СѓРїСЂР°РІР»СЏСЋС‰СѓСЋ РґРѕР»Р¶РЅРѕСЃС‚СЊ РІ Р»СЋР±РѕР№ С„РѕСЂРјРµ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РљР°Рє РїСЂРёРґРµС‚ СЃСЂРѕРє Р’Р°С€РµРіРѕ РїРѕРІС‹С€РµРЅРёСЏ - РѕР±СЂР°С‚РёС‚РµСЃСЊ Рє СЃС‚. РЎРѕСЃС‚Р°РІСѓ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћС„РёСЃ СЂР°Р·СЂРµС€РµРЅРѕ РїРѕРєРёРґР°С‚СЊ С‚РѕР»СЊРєРѕ СЃ СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚. РЎРѕСЃС‚Р°РІР°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’РµСЂС‚РѕР»РµС‚ РјРѕР¶РЅРѕ Р±СЂР°С‚СЊ С‚РѕР¶Рµ С‚РѕР»СЊРєРѕ СЃ СЂР°Р·СЂРµС€РµРЅРёСЏ СЃС‚. РЎРѕСЃС‚Р°РІР°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р—Р° СЃС‚РѕР»Р°РјРё СЃРїР°С‚СЊ Р·Р°РїСЂРµС‰РµРЅРѕ. РЎРїР°С‚СЊ СЂР°Р·СЂРµС€РµРЅРѕ С‚РѕР»СЊРєРѕ РІ РєРѕРјРЅР°С‚Рµ РѕС‚РґС‹С…Р°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎС‚Р°Р¶РµСЂР°РјРё СЃС‡РёС‚Р°СЋС‚СЃСЏ СЃРѕС‚СЂСѓРґРЅРёРєРё, РЅР°С…РѕРґСЏС‰РёРµСЃСЏ РЅР° РґРѕР»Р¶РЅРѕСЃС‚Рё РЎС‚Р°Р¶С‘СЂ Рё Р­РєР·Р°РјРµРЅР°С‚РѕСЂ (РїРѕ Р·Р°СЏРІРєРµ).")
        wait(cfg.commands.zaderjka)
        sampSendChat('/b Р’ С‚РµРјРµ "РџРѕРјРѕС‰СЊ РґР»СЏ РЅРѕРІРёС‡РєРѕРІ" РµСЃС‚СЊ РІСЃРµ РЅСѓР¶РЅС‹Рµ Р±РёРЅРґС‹, Р±РµР· РЅРёС… РЅРµ СЂР°Р±РѕС‚Р°С‚СЊ!')
        wait(cfg.commands.zaderjka)
        sampSendChat("Р•СЃР»Рё РІРѕР·РЅРёРєРЅСѓС‚ РІРѕРїСЂРѕСЃС‹ РѕР±СЂР°С‰Р°Р№С‚РµСЃСЊ Рє РЎРѕС‚СЂСѓРґРЅРёРєР°Рј РћС‚РґРµР»Р° РЎС‚Р°Р¶РёСЂРѕРІРєРё Р»РёР±Рѕ Рє СЃС‚. РЎРѕСЃС‚Р°РІСѓ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎРїР°СЃРёР±Рѕ, С‡С‚Рѕ РїСЂРѕСЃР»СѓС€Р°Р»Рё РјРѕСЋ Р»РµРєС†РёСЋ.")
	end
   },
   {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РїСЂРѕ {47f4f0}РџР”Р”",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р’СЃРµС… РїСЂРёРІРµС‚СЃС‚РІСѓСЋ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('РЎРµР№С‡Р°СЃ СЏ РїСЂРѕРІРµРґСѓ Р»РµРєС†РёСЋ РЅР° С‚РµРјСѓ "РџР”Р”". ')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. РЎРєРѕСЂРѕСЃС‚РЅРѕР№ СЂРµР¶РёРј РІ С€С‚Р°С‚Рµ: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’ РіРѕСЂРѕРґРµ РѕРіСЂР°РЅРёС‡РµРЅРёРµ СЃРєРѕСЂРѕСЃС‚Рё 50 РєРј/С‡. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’ Р¶РёР»РѕР№ Р·РѕРЅРµ - 30 РєРј/С‡. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р—Р° РїСЂРµРґРµР»Р°РјРё РіРѕСЂРѕРґР° СЃРєРѕСЂРѕСЃС‚СЊ РЅРµ РѕРіСЂР°РЅРёС‡РµРЅР°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Р’РѕРґРёС‚РµР»СЊ РѕР±СЏР·Р°РЅ: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРё Р”РўРџ РІС‹Р·С‹РІР°С‚СЊ РїРѕР»РёС†РёСЋ Рё РѕРєР°Р·Р°С‚СЊ РјРµРґ. РїРѕРјРѕС‰СЊ РїСЂРё РЅРµРѕР±С…РѕРґРёРјРѕСЃС‚Рё. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРё РІРёРґРµ РјР°С€РёРЅ СЃРѕ СЃРїРµС†. СЃРёРіРЅР°Р»Р°РјРё РїСЂРёР¶Р°С‚СЊСЃСЏ Рє РѕР±РѕС‡РёРЅРµ Рё РїСЂРѕРїСѓСЃС‚РёС‚СЊ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћСЃС‚Р°РЅР°РІР»РёРІР°С‚СЊСЃСЏ РїРѕ РїРµСЂРІРѕРјСѓ С‚СЂРµР±РѕРІР°РЅРёСЋ СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ РїРѕР»РёС†РёРё. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р”РІРёРіР°С‚СЊСЃСЏ РїРѕ РїСЂР°РІРѕР№ РїРѕР»РѕСЃРµ, РЅРµ РїРµСЂРµСЃРµРєР°СЏ СЃРїР»РѕС€РЅСѓСЋ Р»РёРЅРёСЋ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРёСЃС‚РµРіРЅСѓС‚СЊСЃСЏ РїРµСЂРµРґ РЅР°С‡Р°Р»РѕРј РґРІРёР¶РµРЅРёСЏ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРѕРїСѓСЃРєР°С‚СЊ РїРµС€РµС…РѕРґРѕРІ РЅР° РїРµС€РµС…РѕРґРЅС‹С… РїРµСЂРµС…РѕРґР°С….")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р•Р·РґРёС‚СЊ РёСЃРєР»СЋС‡РёС‚РµР»СЊРЅРѕ РІ С‚СЂРµР·РІРѕРј СЃРѕСЃС‚РѕСЏРЅРёРё. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р”РІРёРіР°С‚СЊСЃСЏ, РЅРµ СЃРѕР·РґР°РІР°СЏ РїРѕРјРµС… РґСЂСѓРіРѕРјСѓ С‚СЂР°РЅСЃРїРѕСЂС‚Сѓ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РќР° СЌС‚РѕРј Р»РµРєС†РёСЏ РѕРєРѕРЅС‡РµРЅР°. РЎРїР°СЃРёР±Рѕ Р·Р° РІРЅРёРјР°РЅРёРµ.")
	end
   },
   {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РїСЂРѕ {47f4f0}РџСЂР°РІРёР»СЊРЅРѕРµ РѕР±СЂР°С‰РµРЅРёРµ СЃ РѕСЂСѓР¶РёРµРј",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р’СЃРµС… РїСЂРёРІРµС‚СЃС‚РІСѓСЋ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('РЎРµР№С‡Р°СЃ СЏ РїСЂРѕРІРµРґСѓ Р»РµРєС†РёСЋ РЅР° С‚РµРјСѓ "РћР±СЂР°С‰РµРЅРёРµ СЃ РѕСЂСѓР¶РёРµРј".')
        wait(cfg.commands.zaderjka)
        sampSendChat("Р“СЂР°Р¶РґР°РЅР°Рј Р·Р°РїСЂРµС‰РµРЅРѕ РЅРѕСЃРёС‚СЊ РѕСЂСѓР¶РёРµ РЅРµ РёРјРµСЏ РЅР° РЅРµРіРѕ Р»РёС†РµРЅР·РёСЋ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р”Р»СЏ СЃРѕС‚СЂСѓРґРЅРёРєРѕРІ СЃРёР»РѕРІС‹С… СЃС‚СЂСѓРєС‚СѓСЂ РґРµР»Р°РµС‚СЃСЏ РёСЃРєР»СЋС‡РµРЅРёРµ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћСЂСѓР¶РёРµ СЂР°Р·СЂРµС€РµРЅРѕ РёСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РІ СЃР»СѓС‡Р°Рµ:")
        wait(cfg.commands.zaderjka)
        sampSendChat("1.РЎР°РјРѕРѕР±РѕСЂРѕРЅС‹, РїСЂРё РЅР°РїР°РґРµРЅРёРё РЅР° РІР°СЃ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2.Р”Р»СЏ РІС‹РїРѕР»РЅРµРЅРёСЏ СЃРІРѕРёС… СЃР»СѓР¶РµР±РЅС‹С… РѕР±СЏР·Р°РЅРЅРѕСЃС‚РµР№.")
        wait(cfg.commands.zaderjka)
        sampSendChat("3.РџРѕ РїСЂСЏРјРѕРјСѓ РїСЂРёРєР°Р·Сѓ Р»СЋРґРµР№, РёРјРµСЋС‰РёС… РЅР° СЌС‚Рѕ РїРѕР»РЅРѕРјРѕС‡РёСЏ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РўРµРј РЅРµ РјРµРЅРµРµ, СЃСѓС‰РµСЃС‚РІСѓРµС‚ СЂСЏРґ Р·Р°РїСЂРµС‚РѕРІ СЃРІСЏР·Р°РЅРЅС‹С… СЃ РѕСЂСѓР¶РёРµРј: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("1.Р—Р°РїСЂРµС‰РµРЅРѕ РЅРѕСЃРёС‚СЊ РѕСЂСѓР¶РёРµ РІ РѕС‚РєСЂС‹С‚РѕРј РІРёРґРµ РІ РјРЅРѕРіРѕР»СЋРґРЅС‹С… РјРµСЃС‚Р°С…. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("2.Р—Р°РїСЂРµС‰РµРЅРѕ РїСЂРёРѕР±СЂРµС‚Р°С‚СЊ РѕСЂСѓР¶РёРµ РЅРµР·Р°РєРѕРЅРЅРѕ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("3.Р—Р°РїСЂРµС‰РµРЅРѕ СЂР°СЃСЃС‚СЂРµР»РёРІР°С‚СЊ Р¶РёС‚РµР»РµР№ Р±РµР· РІРµСЃРѕРјРѕР№ РїСЂРёС‡РёРЅС‹.")
        wait(cfg.commands.zaderjka)
        sampSendChat("4.Р—Р°РїСЂРµС‰РµРЅРѕ РёСЃРїРѕР»СЊР·РІР°С‚СЊ РѕСЂСѓР¶РёРµ РґР»СЏ РґРѕСЃС‚РёР¶РµРЅРёСЏ Р»РёС‡РЅС‹С… С†РµР»РµР№. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’ СЃР»СѓС‡Р°Рµ РЅР°СЂСѓС€РµРЅРёСЏ СЌС‚РёС… РїСЂР°РІРёР», Сѓ РІР°СЃ Р±СѓРґРµС‚ РёР·СЉСЏС‚Р° Р»РёС†РµРЅР·РёСЏ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РўР°Рє Р¶Рµ Р·Р° РїРѕРґРѕР±РЅС‹Рµ РЅР°СЂСѓС€РµРЅРёСЏ РІР°СЃ РјРѕРіСѓС‚ Р·Р°РєР»СЋС‡РёС‚СЊ РїРѕРґ СЃС‚СЂР°Р¶Сѓ. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РќР° СЌС‚РѕРј РІСЃРµ, СЃРїР°СЃРёР±Рѕ Р·Р° РІРЅРёРјР°РЅРёРµ.")
	end
   },
      {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РїСЂРѕ {47f4f0}РџСЂР°РІРёР»Р° СѓРїСЂР°РІР»РµРЅРёСЏ РІРѕРґРЅС‹Рј С‚СЂР°РЅСЃРїРѕСЂС‚РѕРј",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р’СЃРµС… РїСЂРёРІРµС‚СЃС‚РІСѓСЋ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('РЎРµР№С‡Р°СЃ СЏ РїСЂРѕРІРµРґСѓ Р»РµРєС†РёСЋ РЅР° С‚РµРјСѓ "РџСЂР°РІРёР»Р° СѓРїСЂР°РІР»РµРЅРёСЏ РІРѕРґРЅС‹Рј С‚СЂР°РЅСЃРїРѕСЂС‚РѕРј".')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. РџСЂРµР¶РґРµ, С‡РµРј РѕС‚РїСЂР°РІРёС‚СЃСЏ РІ РїР»Р°РІР°РЅРёРµ РІС‹ РґРѕР»Р¶РЅС‹:")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЈР±РµРґРёС‚СЊСЃСЏ РІ РёСЃРїСЂР°РІРЅРѕСЃС‚Рё РјРѕС‚РѕСЂР°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРѕРІРµСЂРёС‚СЊ, РЅРµС‚ Р»Рё РІРѕРґРѕС‚РµС‡РЅРѕСЃС‚Рё РІ РєРѕСЂРїСѓСЃРµ СЃСѓРґРЅР°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРѕРІРµСЂРёС‚СЊ, РЅРµ Р·Р°Р±С‹Р»Рё Р»Рё РІС‹ РІР·СЏС‚СЊ СЃ СЃРѕР±РѕР№ Р»РёС†РµРЅР·РёСЋ РЅР° РїСЂР°РІРѕ СѓРїСЂР°РІР»РµРЅРёСЏ РІРѕРґРЅС‹Рј С‚СЂР°РЅСЃРїРѕСЂС‚РѕРј.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРѕР·Р°Р±РѕС‚РёС‚СЊСЃСЏ Рѕ СЃРїР°СЃР°С‚РµР»СЊРЅС‹С… СЃСЂРµРґСЃС‚РІР°С… РґР»СЏ РєР°Р¶РґРѕРіРѕ С‡РµР»РѕРІРµРєР° РІ Р»РѕРґРєРµ (РєР°С‚РµСЂРµ).")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Р—Р°РїСЂРµС‰Р°РµС‚СЃСЏ:")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРµСЂРµРґР°РІР°С‚СЊ СѓРїСЂР°РІР»РµРЅРёРµ РІРѕРґРЅС‹Рј С‚СЂР°РЅСЃРїРѕСЂС‚РѕРј РґСЂСѓРіРѕРјСѓ Р»РёС†Сѓ Р±РµР· СЃРѕРѕС‚РІРµС‚СЃС‚РІСѓСЋС‰РёС… РЅР° С‚Рѕ РґРѕРєСѓРјРµРЅС‚РѕРІ, РѕСЃРѕР±РµРЅРЅРѕ РґРµС‚СЏРј.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р’С‹С…РѕРґРёС‚СЊ РІ РїР»Р°РІР°РЅРёРµ РІ СѓСЃР»РѕРІРёСЏ РѕРіСЂР°РЅРёС‡РµРЅРЅРѕР№ РІРёРґРёРјРѕСЃС‚Рё, РµСЃР»Рё РІР°С€Р° Р»РѕРґРєР° РЅРµ РѕР±РѕСЂСѓРґРѕРІР°РЅР° СЃРёРіРЅР°Р»СЊРЅС‹РјРё РѕРіРЅСЏРјРё.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРµСЂРµРІРѕР·РёС‚СЊ Р»СЋРґРµР№ РІ РЅРµС‚СЂРµР·РІРѕРј СЃРѕСЃС‚РѕСЏРЅРёРё.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РЎРѕР·РґР°РІР°С‚СЊ РїРѕРјРµС…Рё РґР»СЏ РїР»Р°РІР°РЅРёСЏ СЃСѓРґРѕРІ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРµСЂРµРјРµС‰РµРЅРёРµ СЃ РѕРґРЅРѕРіРѕ СЃСѓРґРЅР° РЅР° РґСЂСѓРіРѕРµ РІРѕ РІСЂРµРјСЏ РёС… РґРІРёР¶РµРЅРёСЏ.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРµСЂРµРІРѕР·РёС‚СЊ РІР·СЂС‹РІРѕРѕРїР°СЃРЅС‹Рµ Рё РѕРіРЅРµРѕРїР°СЃРЅС‹Рµ РіСЂСѓР·С‹ РЅР° СЃСѓРґР°С…, РґР»СЏ СЌС‚РѕРіРѕ РЅРµ РїСЂРµРґРЅР°Р·РЅР°С‡РµРЅРЅС‹С….")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРёРЅРёРјР°С‚СЊ РїРµСЂРµРґ РІС‹С…РѕРґРѕРј РЅР°СЂРєРѕС‚РёС‡РµСЃРєРёРµ РІРµС‰РµСЃС‚РІР°, СЃРїРёСЂС‚РЅС‹Рµ РЅР°РїРёС‚РєРё, С‚РѕРЅРёР·РёСЂСѓСЋС‰РёРµ Р»РµРєР°СЂСЃС‚РІР° Рё РїСЂРµРїР°СЂР°С‚С‹.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћСЃР»Р°Р±Р»СЏС‚СЊ Р±РґРёС‚РµР»СЊРЅРѕСЃС‚СЊ Рё РІРЅРёРјР°РЅРёРµ РІ РїСЂРѕС†РµСЃСЃРµ СѓРїСЂР°РІР»РµРЅРёСЏ РІРѕРґРЅС‹Рј С‚СЂР°РЅСЃРїРѕСЂС‚РѕРј.")
		wait(cfg.commands.zaderjka)
        sampSendChat("РќР° СЌС‚РѕРј РІСЃРµ, СЃРїР°СЃРёР±Рѕ Р·Р° РІРЅРёРјР°РЅРёРµ.")
	end
   },
        {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РїСЂРѕ {47f4f0}РџСЂР°РІРёР»Р° СЂС‹Р±РЅРѕР№ Р»РѕРІР»Рё",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р’СЃРµС… РїСЂРёРІРµС‚СЃС‚РІСѓСЋ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('РЎРµР№С‡Р°СЃ СЏ РїСЂРѕРІРµРґСѓ Р»РµРєС†РёСЋ РЅР° С‚РµРјСѓ "РџСЂР°РІРёР»Р° СЂС‹Р±РЅРѕР№ Р»РѕРІР»Рё".')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. РџСЂР°РІРёР»Р° СЂС‹Р±РЅРѕР№ Р»РѕРІР»Рё:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р›РѕРІРёС‚СЊ СЂС‹Р±Сѓ СЂР°Р·СЂРµС€Р°РµС‚СЃСЏ С‚РѕР»СЊРєРѕ РІ СЂР°Р·СЂРµС€РµРЅРЅС‹С… РјРµСЃС‚Р°С…. (РїСЂРёС‡Р°Р» РЅР° РїР»СЏР¶Рµ Рі.Р›РѕСЃ-РЎР°РЅС‚РѕСЃ Рё Р·Р° РіРѕР»СЊС„ РєР»СѓР±РѕРј РІ Рі.Р›Р°СЃ-Р’РµРЅС‚СѓСЂР°СЃ)")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р С‹Р±РЅР°СЏ Р»РѕРІР»СЏ СЂР°Р·СЂРµС€РµРЅР° С‚РѕР»СЊРєРѕ СЂР°Р·СЂРµС€С‘РЅРЅС‹РјРё РѕСЂСѓРґРёСЏРјРё СѓР¶РµРЅРёСЏ. (РѕРґРЅР° СѓРґРѕС‡РєР° СЃ РѕРґРЅРёРј РєСЂСЋС‡РєРѕРј Р»РёР±Рѕ СЃРїРёРЅРЅРёРЅРі)")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р С‹Р±РЅР°СЏ Р»РѕРІР»СЏ СЂР°Р·СЂРµС€РµРЅР° РёСЃРєР»СЋС‡РёС‚РµР»СЊРЅРѕ РІ С‡РµСЂС‚Рµ РЅР°СЃРµР»РµРЅРЅРѕРіРѕ РїСѓРЅРєС‚Р°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("2. Р—Р°РїСЂРµС‰Р°РµС‚СЃСЏ:")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р›РѕРІРёС‚СЊ СЂС‹Р±Сѓ СЃ Р»РѕРґРєРё.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р›РѕРІРёС‚СЊ СЂС‹Р±Сѓ СЃ РїСЂРёРјРµРЅРµРЅРёРµРј РІР·СЂС‹РІС‡Р°С‚С‹С… Рё РѕС‚СЂР°РІР»СЏСЋС‰РёС… РІРµС‰РµСЃС‚РІ, СЃ РїРѕРјРѕС‰СЊСЋ СЌР»РµРєС‚СЂРѕС‚РѕРєР°, СЃ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёРµРј РєРѕР»СЋС‰РёС… РѕСЂСѓРґРёР№.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р›РѕРІРёС‚СЊ СЂС‹Р±Сѓ Р±РµР· РЅР°Р»РёС‡РёСЏ Р»РёС†РµРЅР·РёРё СЂС‹Р±РѕР»РѕРІР°.")
        wait(cfg.commands.zaderjka)
        sampSendChat("Р›РѕРІРёС‚СЊ СЂС‹Р±Сѓ РІ СЂР°РґРёСѓСЃРµ 500 РјРµС‚СЂРѕРІ РѕС‚ С…РѕР·СЏР№СЃС‚РІ, СЂР°Р·РІРѕРґСЏС‰РёС… СЂС‹Р±Сѓ.")
	end
   },
      {
    title = "{FFFFFF}Р›РµРєС†РёСЏ РїСЂРѕ {47f4f0}РџРёР»РѕС‚РёСЂРѕРІР°РЅРёРµ",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р’СЃРµС… РїСЂРёРІРµС‚СЃС‚РІСѓСЋ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє РђРІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..". ")
        wait(cfg.commands.zaderjka)
        sampSendChat('РЎРµР№С‡Р°СЃ СЏ РїСЂРѕРІРµРґСѓ Р»РµРєС†РёСЋ РЅР° С‚РµРјСѓ "РџРёР»РѕС‚РёСЂРѕРІР°РЅРёРµ". ')
        wait(cfg.commands.zaderjka)
        sampSendChat("1. РџСЂР°РІРёР»Р° РїРёР»РѕС‚РёСЂРѕРІР°РЅРёСЏ: ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРё СЃРѕРІРµСЂС€РµРЅРёРё РїРѕР»РµС‚Р° РЅСѓР¶РЅРѕ С‡РµС‚РєРѕ РІС‹РїРѕР»РЅСЏС‚СЊ РІСЃРµ РёРЅСЃС‚СЂСѓРєС†РёРё Рё РЅРµ РѕС‚РєР»РѕРЅСЏС‚СЊСЃСЏ РѕС‚ РІС‹Р±СЂР°РЅРЅРѕРіРѕ РєСѓСЂСЃР°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРµСЂРµРґ РЅР°С‡Р°Р»РѕРј РїРѕР»РµС‚Р° РЅР°РґРѕ РїСЂРѕРІРµСЂРёС‚СЊ С‚РµС…РЅРёРєСѓ РЅР° РєРѕС‚РѕСЂРѕР№ РІС‹ Р±СѓРґРµС‚Рµ СЃРѕРІРµСЂС€Р°С‚СЊ РїРѕР»РµС‚. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РўСЂРµРЅРёСЂРѕРІРѕС‡РЅС‹Рµ РїРѕР»РµС‚С‹ СЃРѕРІРµСЂС€Р°СЋС‚СЃСЏ С‚РѕР»СЊРєРѕ РїСЂРё РѕРїС‹С‚РЅС‹С… РїРёР»РѕС‚Р°С…. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџСЂРёРЅРёРјР°С‚СЊ РїРµСЂРµРґ РІС‹Р»РµС‚РѕРј РЅР°СЂРєРѕС‚РёС‡РµСЃРєРёРµ РІРµС‰РµСЃС‚РІР°, СЃРїРёСЂС‚РЅС‹Рµ РЅР°РїРёС‚РєРё, С‚РѕРЅРёР·РёСЂСѓСЋС‰РёРµ Р»РµРєР°СЂСЃС‚РІР° Рё РїСЂРµРїР°СЂР°С‚С‹.")
        wait(cfg.commands.zaderjka)
        sampSendChat("РћСЃР»Р°Р±Р»СЏС‚СЊ Р±РґРёС‚РµР»СЊРЅРѕСЃС‚СЊ Рё РІРЅРёРјР°РЅРёРµ РІ РїСЂРѕС†РµСЃСЃРµ РїРѕР»РµС‚Р°. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРѕР»РµС‚С‹ РІ Р·Р°РїСЂРµС‚РЅС‹С… Рё РѕРїР°СЃРЅС‹С… Р·РѕРЅР°С…, РёРЅС„РѕСЂРјР°С†РёРё Рѕ РєРѕС‚РѕСЂС‹С… РЅРµС‚ РЅР° РїРѕР»РµС‚РЅС‹С… РєР°СЂС‚Р°С…. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РџРѕР»РµС‚ РЅР°Рґ РЅР°СЃРµР»РµРЅРЅС‹РјРё РїСѓРЅРєС‚Р°РјРё Рё СЃРєРѕРїР»РµРЅРёСЏРјРё Р»СЋРґРµР№ РЅР° РѕС‚РєСЂС‹С‚РѕР№ РјРµСЃС‚РЅРѕСЃС‚Рё РЅР° РІС‹СЃРѕС‚Рµ РјРµРЅРµРµ 300 РјРµС‚СЂРѕРІ.")
       wait(cfg.commands.zaderjka)
        sampSendChat("РЎР±Р»РёР¶РµРЅРёРµ СЃР°РјРѕР»РµС‚РѕРІ Р±Р»РёР¶Рµ СѓСЃС‚Р°РЅРѕРІР»РµРЅРЅС‹С… РїСЂР°РІРёР» СЂР°СЃСЃС‚РѕСЏРЅРёР№. ")
        wait(cfg.commands.zaderjka)
        sampSendChat("РќР° СЌС‚РѕРј РІСЃРµ, СЃРїР°СЃРёР±Рѕ Р·Р° РІРЅРёРјР°РЅРёРµ.")
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
	local clisto = imgui.ImBool(cfg.main.clisto)
	local givra = imgui.ImBool(cfg.main.givra)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
	imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth/2, iScreenHeight/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(380, 320), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'РќР°СЃС‚СЂРѕР№РєРё##1', first_window)
	imgui.PushItemWidth(100)
	imgui.Text(u8("РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ Р°РІС‚РѕС‚РµРі"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ Р°РІС‚РѕС‚РµРі', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Р’РІРµРґРёС‚Рµ РІР°С€ РўРµРі.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ Р°РІС‚РѕРєР»РёСЃС‚"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ Р°РІС‚РѕРєР»РёСЃС‚', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Р’С‹Р±РµСЂРёС‚Рµ Р·РЅР°С‡РµРЅРёРµ РєР»РёСЃС‚Р°", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РѕС‚С‹РіСЂРѕРІРєСѓ СЂР°Р·РґРµРІР°Р»РєРё"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РѕС‚С‹РіСЂРѕРІРєСѓ СЂР°Р·РґРµРІР°Р»РєРё', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("РњСѓР¶СЃРєРёРµ РѕС‚С‹РіСЂРѕРІРєРё"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'РњСѓР¶СЃРєРёРµ РѕС‚С‹РіСЂРѕРІРєРё', stateb) then
        cfg.main.male = not cfg.main.male
    end
	imgui.Text(u8("РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РѕС‚С‹РіСЂРѕРІРєСѓ /giverank"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'РСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РѕС‚С‹РіСЂРѕРІРєСѓ /giverank', givra) then
        cfg.main.givra = not cfg.main.givra
    end
	if imgui.InputInt(u8'Р—Р°РґРµСЂР¶РєР° РІ Р»РµРєС†РёСЏС…', waitbuffer) then
     cfg.commands.zaderjka = waitbuffer.v
    end
    if imgui.CustomButton(u8('РЎРѕС…СЂР°РЅРёС‚СЊ РЅР°СЃС‚СЂРѕР№РєРё'), imgui.ImVec4(0.11, 0.79, 0.07, 0.40), imgui.ImVec4(0.11, 0.79, 0.07, 1.00), imgui.ImVec4(0.11, 0.79, 0.07, 0.76), btn_size) then
	ftext('РќР°СЃС‚СЂРѕР№РєРё СѓСЃРїРµС€РЅРѕ СЃРѕС…СЂР°РЅРµРЅС‹.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- СЃРѕС…СЂР°РЅСЏРµРј РІСЃРµ РЅРѕРІС‹Рµ Р·РЅР°С‡РµРЅРёСЏ РІ РєРѕРЅС„РёРіРµ
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | РЈСЃС‚Р°РІ РђРЁ'), ystwindow)
                for line in io.lines('moonloader\\instools\\yst.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local x, y = getScreenResolution()
    local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(x/2, y/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(300, 300), imgui.Cond.FirstUseEver)
    imgui.Begin('Inst Tools | Main Menu', second_window, imgui.WindowFlags.NoResize)
	if imgui.Button(u8'Р‘РёРЅРґРµСЂ', btn_size) then
      bMainWindow.v = not bMainWindow.v
    end
    if imgui.Button(u8'РќР°СЃС‚СЂРѕР№РєРё СЃРєСЂРёРїС‚Р°', btn_size) then
      first_window.v = not first_window.v
    end
	if imgui.Button(u8'РџСЂРѕРІРµСЂРёС‚СЊ РѕР±РЅРѕРІР»РµРЅРёРµ СЃРєСЂРёРїС‚Р°', btn_size) then
      updwindows.v = not updwindows.v
    end
    if imgui.Button(u8'РџРµСЂРµР·Р°РіСЂСѓР·РёС‚СЊ СЃРєСЂРёРїС‚', btn_size) then
      showCursor(false)
      thisScript():reload()
    end
    imgui.End()
  end
    if updwindows.v then
                local updlist = ttt
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(700, 290), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | РћР±РЅРѕРІР»РµРЅРёРµ'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Р’С‹С€Р»Рѕ РѕР±РЅРѕРІР»РµРЅРёРµ СЃРєСЂРёРїС‚Р° Inst Tools. Р§С‚Рѕ Р±С‹ РѕР±РЅРѕРІРёС‚СЊСЃСЏ РЅР°Р¶РјРёС‚Рµ РєРЅРѕРїРєСѓ РІРЅРёР·Сѓ. РЎРїРёСЃРѕРє РёР·РјРµРЅРµРЅРёР№:'))
                imgui.Separator()
                imgui.BeginChild("uuupdate", imgui.ImVec2(690, 200))
                for line in ttt:gmatch('[^\r\n]+') do
                    imgui.Text(line)
                end
                imgui.EndChild()
                imgui.Separator()
                imgui.PushItemWidth(305)
                if imgui.Button(u8("РћР±РЅРѕРІРёС‚СЊ"), imgui.ImVec2(339, 25)) then
                    lua_thread.create(goupdate)
                    updwindows.v = false
                end
                imgui.SameLine()
                if imgui.Button(u8("РћС‚Р»РѕР¶РёС‚СЊ РѕР±РЅРѕРІР»РµРЅРёРµ"), imgui.ImVec2(339, 25)) then
                    updwindows.v = false
                end
                imgui.End()
            end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}
   
   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 500), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("IT | Р‘РёРЅРґРµСЂ##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
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
				imgui.TextDisabled(u8("РџСѓСЃС‚РѕРµ СЃРѕРѕР±С‰РµРЅРёРµ ..."))
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
			imgui.Checkbox(u8("Р’РІРѕРґ") .. "##editCH" .. k, bIsEnterEdit)
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

	if imgui.Button(u8"Р”РѕР±Р°РІРёС‚СЊ РєР»Р°РІРёС€Сѓ") then
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
    select_button, close_button, back_button = select_button or 'В»', close_button or 'x', back_button or 'В«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' В»' or v.title)
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
        ftext('Р’РІРµРґРёС‚Рµ /r [С‚РµРєСЃС‚]')
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
        ftext('Р’РІРµРґРёС‚Рµ /f [С‚РµРєСЃС‚]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x3D85C6)
end

function tset()
  second_window.v = not second_window.v
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
    return
    {
      {
        title = "{ffffff}В» Р¦РµРЅС‹ Р»РёС†РµРЅР·РёР№",
        onclick = function()
        pID = tonumber(args)
        submenus_show(pricemenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}В» РРЅСЃС‚СЂСѓРєС‚РѕСЂ",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}В» Р’РѕРїСЂРѕСЃС‹",
        onclick = function()
        pID = tonumber(args)
        submenus_show(questimenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}В» РћС„РѕСЂРјР»РµРЅРёРµ",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{47f4f0}Inst Tools {ffffff}| "..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}В» РЈРґР°СЂРёС‚СЊ С€РѕРєРµСЂРѕРј",
        onclick = function()
        sampSendChat("/me СЃРЅСЏР» С€РѕРєРµСЂ СЃ РїРѕСЏСЃР°.")
        wait(1500)
        sampSendChat("/itazer")
        wait(1500)
        sampSendChat("/me РїРѕРІРµСЃРёР» С€РѕРєРµСЂ РЅР° РїРѕСЏСЃ")
        end
      }
    }
end

function questimenu(args)
    return
    {
      {
        title = '{5b83c2}В« Р Р°Р·РґРµР» РІРѕРїСЂРѕСЃРѕРІ РїРѕ РџР”Р” В»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}В» РџР°СЂСѓ РІРѕРїСЂРѕСЃРѕРІ',
        onclick = function()
          sampSendChat("РЎРµР№С‡Р°СЃ СЏ Р·Р°РґР°Рј РІР°Рј РїР°СЂСѓ РІРѕРїСЂРѕСЃРѕРІ РїРѕ РџР”Р”. Р“РѕС‚РѕРІС‹?")
		end
      },
      {
        title = '{ffffff}В» Р“РѕСЂРѕРґ{ff0000} 50 РєРј/С‡',
        onclick = function()
        sampSendChat("РљР°РєР°СЏ РјР°РєСЃРёРјР°Р»СЊРЅР°СЏ СЃРєРѕСЂРѕСЃС‚СЊ СЂР°Р·СЂРµС€РµРЅР° РІ РіРѕСЂРѕРґРµ?")
        end
      },
      {
        title = '{ffffff}В» Р–РёР»Р°СЏ РјРµСЃС‚РЅРѕСЃС‚СЊ{ff0000} 30 РєРј/С‡',
        onclick = function()
        sampSendChat("РљР°РєР°СЏ РјР°РєСЃРёРјР°Р»СЊРЅР°СЏ СЃРєРѕСЂРѕСЃС‚СЊ СЂР°Р·СЂРµС€РµРЅР° РІ Р¶РёР»РѕР№ РјРµСЃС‚РЅРѕСЃС‚Рё?")
        end
      },
      {
        title = '{ffffff}В» РћР±РіРѕРЅ{ff0000} СЃ Р»РµРІРѕР№ СЃС‚РѕСЂРѕРЅС‹.',
        onclick = function()
        sampSendChat("РЎ РєР°РєРѕР№ СЃС‚РѕСЂРѕРЅС‹ СЂР°Р·СЂРµС€РµРЅ РѕР±РіРѕРЅ?")
        end
      },
      {
        title = '{ffffff}В» Р”РўРџ',
        onclick = function()
        sampSendChat("Р’С‹ РїРѕРїР°Р»Рё РІ Р”РўРџ. Р’Р°С€Рё РґРµР№СЃС‚РІРёСЏ?")
		wait(1500)
		sampAddChatMessage("{47f4f0}[IT] {FFFFFF}- РџСЂР°РІРёР»СЊРЅС‹Р№ РѕС‚РІРµС‚: {A52A2A}РћРєР°Р·Р°С‚СЊ РїРµСЂРІСѓСЋ РїРѕРјРѕС‰СЊ РїРѕСЃС‚СЂР°РґР°РІС€РёРј. Р’С‹Р·РІР°С‚СЊ РњР§РЎ Рё РџР” Рё Р¶РґР°С‚СЊ РёС… РїСЂРёР±С‹С‚РёСЏ.", -1)
        end
      },
	  {
        title = '{5b83c2}В« Р Р°Р·РґРµР» РґСЂСѓРіРёС… РІРѕРїСЂРѕСЃРѕРІВ»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}РћСЂСѓР¶РёРµ',
        onclick = function()
        sampSendChat("Р—Р°С‡РµРј РІР°Рј РѕСЂСѓР¶РёРµ?")
        end
      },
	  {
        title = '{ffffff}РџРѕРєР°Р¶РёС‚Рµ РґРѕРєСѓРјРµРЅС‚ РЅР° Р±РёР·РЅРµСЃ',
        onclick = function()
        sampSendChat("РџРѕР¶Р°Р»СѓР№СЃС‚Р° РїСЂРµРґРѕСЃС‚Р°РІС‚Рµ РґРѕРєСѓРјРµРЅС‚ РЅР° РЅР°Р»РёС‡РёРµ Р±РёР·РЅРµСЃР°.")
		wait(1500)
		sampSendChat("/b /me РїРѕРєР°Р·Р°Р» РґРѕРєСѓРјРµРЅС‚ РЅР° Р±РёР·РЅРµСЃ")
        end
      },
    }
end

function oformenu(id)
    return
    {
      {
        title = '{5b83c2}В« Р Р°Р·РґРµР» РѕС„РѕСЂРјР»РµРЅРёСЏ В»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}В» РџСЂР°РІР°.',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р»(Р°) С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		  sampSendChat("/givelicense "..id)
		  wait(1700)
		  sampCloseCurrentDialogWithButton(1)
		  wait(1700)
		  sampSendChat("РЈРґР°С‡Рё РЅР° РґРѕСЂРѕРіР°С….")
		end
      },
      {
        title = '{ffffff}В» Р С‹Р±Р°Р»РєР°',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р»(Р°) С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(2)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      },
      {
        title = '{ffffff}В» РџРёР»РѕС‚',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р» С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(1)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      },
      {
        title = '{ffffff}В» РћСЂСѓР¶РёРµ{ff0000} СЃРѕ 2 СѓСЂРѕРІРЅСЏ.',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р»(Р°) С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(4)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      },
      {
        title = '{ffffff}В» РљР°С‚РµСЂ',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р» С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР» РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
		sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(3)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      },
      {
        title = '{ffffff}В» Р‘РёР·РЅРµСЃ',
        onclick = function()
          sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		  wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р»(Р°) С‡РёСЃС‚С‹Р№ Р±Р»Р°РЅРє Рё РЅР°С‡Р°Р» РµРіРѕ Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do Р›РёС†РµРЅР·РёСЏ РІ СЂСѓРєРµ.")
		  wait(1700)
		  sampSendChat('/me РїРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚СЊ "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёСЋ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1700)
        sampSendChat("/givelicense "..id)
		wait(1700)
		sampSetCurrentDialogListItem(5)
		wait(1700)
		sampCloseCurrentDialogWithButton(1)
        end
      }
    }
end

function pricemenu(args)
    return
    {
      {
        title = '{5b83c2}В« Р Р°Р·РґРµР» СЃС‚РѕРёРјРѕСЃС‚Рё В»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}В» РџСЂР°РІР°.',
        onclick = function()
		if gmegaflvl <= 2 then
          sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 500$.")
		  wait(1500)
		  sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")	  
		else if gmegaflvl <= 5 then
		  sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 5.000$.")
		  wait(1500)
		  sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")	  
		else if gmegaflvl <= 15 then
		  sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 10.000$.")
		  wait(1500)
		  sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")	  
		else if gmegaflvl >= 16 then
		  sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 30.000$.")
		  wait(1500)
		  sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")	  
        end
		end
		end
		end
		end
      },
      {
        title = '{ffffff}В» Р С‹Р±Р°Р»РєР°',
        onclick = function()
        sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 2.000$.")
		wait(1500)
		sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")
        end
      },
      {
        title = '{ffffff}В» РџРёР»РѕС‚',
        onclick = function()
        sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 10.000$.")
		wait(1500)
		sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")
        end
      },
      {
        title = '{ffffff}В» РћСЂСѓР¶РёРµ{ff0000} СЃРѕ 2 СѓСЂРѕРІРЅСЏ.',
        onclick = function()
        sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 50.000$.")
		wait(1500)
		sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")
        end
      },
	  {
        title = '{ffffff}В» Р‘РёР·РЅРµСЃ{ff0000} РїСЂРё РЅР°Р»РёС‡РёРё Р±РёР·РЅРµСЃР°.',
        onclick = function()
        sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 100.000$.")
		wait(1500)
		sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")
        end
      },
      {
        title = '{ffffff}В» РљР°С‚РµСЂ',
        onclick = function()
        sampSendChat("РЎС‚РѕРёРјРѕСЃС‚СЊ РґР°РЅРЅРѕР№ Р»РёС†РµРЅР·РёРё СЃРѕСЃС‚Р°РІР»СЏРµС‚ - 5.000$.")
		wait(1500)
		sampSendChat("РћС„РѕСЂРјР»СЏРµРј?")
        end
      },
      {
        title = '{ffffff}В» РљРѕРјРїР»РµРєС‚',
        onclick = function()
        sampSendChat("Р С‹Р±РѕР»РѕРІСЃС‚РІРѕ - 2.000$, РљР°С‚РµСЂ - 5.000$, Р›РёС†РµРЅР·РёСЏ РїРёР»РѕС‚Р° - 10.000$, Р›РёС†РµРЅР·РёСЏ РЅР° РѕСЂСѓР¶РёРµ - 50.000$.")
        end
      }
    }
end

function instmenu(id)
    return
    {
      {
        title = '{5b83c2}В« Р Р°Р·РґРµР» РёРЅСЃС‚СЂСѓРєС‚РѕСЂР° В»',
        onclick = function()
        end
      },
      {
        title = '{ffffff}В» РџСЂРёРІРµС‚СЃС‚РІРёРµ.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Р—РґСЂР°РІСЃС‚РІСѓР№С‚Рµ. РЇ СЃРѕС‚СЂСѓРґРЅРёРє Р°РІС‚РѕС€РєРѕР»С‹ "..myname:gsub('_', ' ')..", С‡РµРј РјРѕРіСѓ РїРѕРјРѕС‡СЊ?")
		wait(1500)
		sampSendChat('/do РќР° СЂСѓР±Р°С€РєРµ Р±РµР№РґР¶РёРє СЃ РЅР°РґРїРёСЃСЊСЋ "'..rank..'" | '..myname:gsub('_', ' ')..'.')  
		end
      },
      {
        title = '{ffffff}В» РџР°СЃРїРѕСЂС‚',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Р’Р°С€ РїР°СЃРїРѕСЂС‚, РїРѕР¶Р°Р»СѓР№СЃС‚Р°.")
		wait(1500)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
      {
        title = '{ffffff}В» РћС„РѕСЂРјР»РµРЅРёРµ РєРѕРјРїР»РµРєС‚Р°',
        onclick = function()
        sampSendChat("/do РљРµР№СЃ СЃ РґРѕРєСѓРјРµРЅС‚Р°РјРё РІ СЂСѓРєР°С… РёРЅСЃС‚СЂСѓРєС‚РѕСЂР°.")
		wait(1700)
		  sampSendChat("/me РїСЂРёРѕС‚РєСЂС‹Р»(Р°) РєРµР№СЃ, РїРѕСЃР»Рµ С‡РµРіРѕ РґРѕСЃС‚Р°Р»(Р°) СЃС‚РѕРїРєСѓ С‡РёСЃС‚С‹С… Р±Р»Р°РЅРєРѕРІ Рё РЅР°С‡Р°Р» РёС… Р·Р°РїРѕР»РЅСЏС‚СЊ")
		  wait(1700)
		  sampSendChat("/me Р·Р°РїРёСЃР°Р»(Р°) РїР°СЃРїРѕСЂС‚РЅС‹Рµ РґР°РЅРЅС‹Рµ РїРѕРєСѓРїР°С‚РµР»СЏ")
		  wait(1700)
		  sampSendChat("/do РЎС‚РѕРїРєР° Р»РёС†РµРЅР·РёР№ РІ СЂСѓРєРµ.")
		  wait(1700)
		sampSendChat('/me РїСЂРѕСЃС‚Р°РІРёР»(Р°) РїРµС‡Р°С‚Рё "Autoschool San Fierro" Рё РїРµСЂРµРґР°Р» Р»РёС†РµРЅР·РёРё '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        end
      },
	  {
        title = '{ffffff}В» РџРѕРїСЂРѕС‰Р°С‚СЊСЃСЏ СЃ РєР»РёРµРЅС‚РѕРј',
        onclick = function()
        sampSendChat("РЎРїР°СЃРёР±Рѕ Р·Р° РїРѕРєСѓРїРєСѓ, РІСЃРµРіРѕ Р’Р°Рј РґРѕР±СЂРѕРіРѕ.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/instools/yst.txt') then
        local file = io.open("moonloader/instools/yst.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end

function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [1] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [2] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [3] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [4] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [5] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [6] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [7] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [8] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [9] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [10] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [11] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [12] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [13] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [14] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [15] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [16] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [17] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [18] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [19] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [20] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [21] = 'Ballas',
        [22] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [23] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [24] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [25] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [26] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [27] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [28] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [29] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [30] = 'Rifa',
        [31] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [32] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [33] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [34] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [35] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [36] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [37] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [38] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [39] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [40] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [41] = 'Aztec',
        [42] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [43] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [44] = 'Aztec',
        [45] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [46] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [50] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [51] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [52] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [53] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [54] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [55] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [56] = 'Grove',
        [57] = 'РњСЌСЂРёСЏ',
        [58] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [59] = 'РђРІС‚РѕС€РєРѕР»Р°',
        [60] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [61] = 'РђСЂРјРёСЏ',
        [62] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [63] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [64] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [65] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№', -- РЅР°Рґ РїРѕРґСѓРјР°С‚СЊ
        [66] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [67] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [68] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [69] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [70] = 'РњРћРќ',
        [71] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [72] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [73] = 'Army',
        [74] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [75] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [76] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [77] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [78] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [79] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [80] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [81] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [82] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [83] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [84] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [85] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [86] = 'Grove',
        [87] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [88] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [89] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [90] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [91] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№', -- РїРѕРґ РІРѕРїСЂРѕСЃРѕРј
        [92] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [93] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [94] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [95] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [96] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [97] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [98] = 'РњСЌСЂРёСЏ',
        [99] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [100] = 'Р‘Р°Р№РєРµСЂ',
        [101] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
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
        [121] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [122] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [129] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [130] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [131] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [132] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [133] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [134] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [135] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [136] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [137] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [138] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [139] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [140] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [141] = 'FBI',
        [142] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [143] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [144] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [145] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [146] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [147] = 'РњСЌСЂРёСЏ',
        [148] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [149] = 'Grove',
        [150] = 'РњСЌСЂРёСЏ',
        [151] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [152] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [153] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [154] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [155] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [156] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [157] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [158] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [159] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [160] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [161] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [162] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [168] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [169] = 'Yakuza',
        [170] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [171] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [172] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [177] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [178] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [179] = 'Army',
        [180] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [181] = 'Р‘Р°Р№РєРµСЂ',
        [182] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [183] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [184] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [185] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [186] = 'Yakuza',
        [187] = 'РњСЌСЂРёСЏ',
        [188] = 'РЎРњР',
        [189] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [193] = 'Aztec',
        [194] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [195] = 'Ballas',
        [196] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [197] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [198] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [199] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [200] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [201] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [202] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [203] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [204] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [205] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [206] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [207] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [208] = 'Yakuza',
        [209] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [210] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [211] = 'РЎРњР',
        [212] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [213] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [214] = 'LCN',
        [215] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [216] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [217] = 'РЎРњР',
        [218] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [219] = 'РњРћРќ',
        [220] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [221] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [222] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [223] = 'LCN',
        [224] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [225] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [226] = 'Rifa',
        [227] = 'РњСЌСЂРёСЏ',
        [228] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [229] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [230] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [231] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [232] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [233] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [234] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [235] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [236] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [237] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [238] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [239] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [240] = 'РђРІС‚РѕС€РєРѕР»Р°',
        [241] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [242] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [243] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [244] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [245] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [246] = 'Р‘Р°Р№РєРµСЂ',
        [247] = 'Р‘Р°Р№РєРµСЂ',
        [248] = 'Р‘Р°Р№РєРµСЂ',
        [249] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [250] = 'РЎРњР',
        [251] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [252] = 'Army',
        [253] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [254] = 'Р‘Р°Р№РєРµСЂ',
        [255] = 'Army',
        [256] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [257] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [258] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [259] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [260] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [261] = 'РЎРњР',
        [262] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [263] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [264] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [265] = 'РџРѕР»РёС†РёСЏ',
        [266] = 'РџРѕР»РёС†РёСЏ',
        [267] = 'РџРѕР»РёС†РёСЏ',
        [268] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№', -- РЅР°РґРѕ РїРѕРґСѓРјР°С‚СЊ
        [274] = 'РњРћРќ',
        [275] = 'РњРћРќ',
        [276] = 'РњРћРќ',
        [277] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [278] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [279] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [280] = 'РџРѕР»РёС†РёСЏ',
        [281] = 'РџРѕР»РёС†РёСЏ',
        [282] = 'РџРѕР»РёС†РёСЏ',
        [283] = 'РџРѕР»РёС†РёСЏ',
        [284] = 'РџРѕР»РёС†РёСЏ',
        [285] = 'РџРѕР»РёС†РёСЏ',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'РџРѕР»РёС†РёСЏ',
        [289] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [290] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [291] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [292] = 'Aztec',
        [293] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [294] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [295] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [296] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [297] = 'Grove',
        [298] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [299] = 'Р“СЂР°Р¶РґР°РЅСЃРєРёР№',
        [300] = 'РџРѕР»РёС†РёСЏ',
        [301] = 'РџРѕР»РёС†РёСЏ',
        [302] = 'РџРѕР»РёС†РёСЏ',
        [303] = 'РџРѕР»РёС†РёСЏ',
        [304] = 'РџРѕР»РёС†РёСЏ',
        [305] = 'РџРѕР»РёС†РёСЏ',
        [306] = 'РџРѕР»РёС†РёСЏ',
        [307] = 'РџРѕР»РёС†РёСЏ',
        [308] = 'РњРћРќ',
        [309] = 'РџРѕР»РёС†РёСЏ',
        [310] = 'РџРѕР»РёС†РёСЏ',
        [311] = 'РџРѕР»РёС†РёСЏ'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function update()
	local fpath = os.getenv('TEMP') .. '\\update.json'
	downloadUrlToFile('https://raw.githubusercontent.com/Damein68/lua/master/update.json', fpath, function(id, status, p1, p2)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local f = io.open(fpath, 'r')
            if f then
			    local info = decodeJson(f:read('*a'))
                updatelink = info.updateurl
                updlist1 = info.updlist
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('РћР±РЅР°СЂСѓР¶РµРЅРѕ РѕР±РЅРѕРІР»РµРЅРёРµ.')
                        ftext('РџСЂРёРјРµС‡Р°РЅРёРµ: Р•СЃР»Рё Сѓ РІР°СЃ РЅРµ РїРѕСЏРІРёР»РѕСЃСЊ РѕРєРѕС€РєРѕ РІРІРµРґРёС‚Рµ /tset')
					    updwindows.v = true
                    else
                        ftext('РћР±РЅРѕРІР»РµРЅРёР№ СЃРєСЂРёРїС‚Р° РЅРµ РѕР±РЅР°СЂСѓР¶РµРЅРѕ. РџСЂРёСЏС‚РЅРѕР№ РёРіСЂС‹.', -1)
                        update = false
				    end
			    end
		    end
	    end
    end)
end

function goupdate()
    ftext('РќР°С‡Р°Р»РѕСЃСЊ СЃРєР°С‡РёРІР°РЅРёРµ РѕР±РЅРѕРІР»РµРЅРёСЏ. РЎРєСЂРёРїС‚ РїРµСЂРµР·Р°РіСЂСѓР·РёС‚СЃСЏ С‡РµСЂРµР· РїР°СЂСѓ СЃРµРєСѓРЅРґ.', -1)
    wait(300)
    downloadUrlToFile(updatelink, thisScript().path, function(id3, status1, p13, p23)
    if status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
        showCursor(false)
	    thisScript():reload()
    end
end)
end

function sampev.onSendSpawn()
    if cfg.main.clistb and rabden then
        lua_thread.create(function()
            wait(1200)
            ftext('Р¦РІРµС‚ РЅРёРєР° СЃРјРµРЅРµРЅ РЅР°: {9966cc}' .. cfg.main.clist)
            sampSendChat('/clist '..cfg.main.clist)
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('Р Р°Р±РѕС‡РёР№ РґРµРЅСЊ РЅР°С‡Р°С‚') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
                ftext('Р¦РІРµС‚ РЅРёРєР° СЃРјРµРЅРµРЅ РЅР°: {9966cc}' .. cfg.main.clist)
                sampSendChat('/clist '..tonumber(cfg.main.clist))
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me РѕС‚РєСЂС‹Р» С€РєР°С„С‡РёРє")
                wait(1500)
                sampSendChat("/me СЃРЅСЏР» СЃРІРѕСЋ РѕРґРµР¶РґСѓ, РїРѕСЃР»Рµ С‡РµРіРѕ СЃР»РѕР¶РёР» РµРµ РІ С€РєР°С„")
                wait(1500)
                sampSendChat("/me РІР·СЏР» СЂР°Р±РѕС‡СѓСЋ РѕРґРµР¶РґСѓ, Р·Р°С‚РµРј РїРµСЂРµРѕРґРµР»СЃСЏ РІ РЅРµРµ")
                wait(1500)
                sampSendChat("/me РЅР°С†РµРїРёР» Р±РµР№РґР¶РёРє РЅР° СЂСѓР±Р°С€РєСѓ")
                wait(1500)
                sampSendChat('/do РќР° СЂСѓР±Р°С€РєРµ Р±РµР№РґР¶РёРє СЃ РЅР°РґРїРёСЃСЊСЋ "'..rank..'" | '..myname:gsub('_', ' ')..'.')  
				end
				if cfg.main.male == false then
				sampSendChat("/me РѕС‚РєСЂС‹Р»Р° С€РєР°С„С‡РёРє")
                wait(1500)
                sampSendChat("/me СЃРЅСЏР»Р° СЃРІРѕСЋ РѕРґРµР¶РґСѓ, РїРѕСЃР»Рµ С‡РµРіРѕ СЃР»РѕР¶РёР»Р° РµРµ РІ С€РєР°С„")
                wait(1500)
                sampSendChat("/me РІР·СЏР»Р° СЂР°Р±РѕС‡СѓСЋ РѕРґРµР¶РґСѓ, Р·Р°С‚РµРј РїРµСЂРµРѕРґРµР»Р°СЃСЊ РІ РЅРµРµ")
                wait(1500)
                sampSendChat("/me РЅР°С†РµРїРёР»Р° Р±РµР№РґР¶РёРє РЅР° СЂСѓР±Р°С€РєСѓ")
                wait(1500)
                sampSendChat('/do РќР° СЂСѓР±Р°С€РєРµ Р±РµР№РґР¶РёРє СЃ РЅР°РґРїРёСЃСЊСЋ "'..rank..'" | '..myname:gsub('_', ' ')..'.')
				end
			end
            end)
        end
	  end
    end
    if text:find('Р Р°Р±РѕС‡РёР№ РґРµРЅСЊ РѕРєРѕРЅС‡РµРЅ') and color ~= -1 then
        rabden = false
    end
	if color == -8224086 then
        local colors = ("{%06X}"):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors.."[%H:%M:%S] ") .. text)
    end
	if status then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players2, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', nick, id, rang, stat))
			return false
		end
		if text:match('Р’СЃРµРіРѕ: %d+ С‡РµР»РѕРІРµРє') then
			local count = text:match('Р’СЃРµРіРѕ: (%d+) С‡РµР»РѕРІРµРє')
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
>>>>>>> 9a0d3c97249eef6a05472977d500342828e56e4b
