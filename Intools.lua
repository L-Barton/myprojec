script_name('Inst Tools')
script_version('4.2')
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
local helps = imgui.ImBool(false)
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
players2 = {'{ffffff}Дата принятия\t{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
frak = nil
rang = nil
ttt = nil
rabden = false
tload = false
tLastKeys = {}
departament = {}
vixodid = {}
function apply_custom_style() -- паблик дизайн андровиры, который юзался в скрипте ранее

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
    ftext("Скрипт успешно загружен. /tset - основное меню.", -1)
	ftext('Автором данного скрипта является Damien_Requeste')
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{139BEC}IT {ffffff}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(instools, 'instools/config.ini') then
      sampAddChatMessage("{139BEC}IT {ffffff}| Файл конфига успешно создан.", -1)
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
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{139BEC}IT {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{139BEC}IT {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'instools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Driving School' then
    submenus_show(fastmenu(id), "{139BEC}IT {ffffff}| Быстрое меню")
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
                submenus_show(pkmmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}Уровень - "..sampGetPlayerScore(id).." ")
				else
			ftext('Возможно вы не состоите в автошколе {ff0000}[ctrl+R]')
				end
            end
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v
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

[1] Общее положение Автошколы:

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
• 2.5 Сотрудник Автошколы, прежде чем выдать лицензию, обязан попросить паспорт у клиента и заполнить бланк на лицензию его данными. Простая выдача лицензии без паспорта и заполнения бланка приведёт к вынесению выговора сотруднику;?
• 2.6 Сотрудник Автошколы обязаны придерживаться диалога в официальном стиле;?
• 2.7 Сотрудник Автошколы обязаны следить за собой и избегать любых агрессивных и провокационных действий;?
• 2.8 Сотрудник Автошколы обязаны отвечать на задаваемые посетителями вопросы, касаемые лицензий и ПДД. На вопросы, не относящиеся к работе инструкторов, сотрудник в праве не отвечать;?
• 2.9 Сотрудники обязаны носить бейджики согласно принадлежности к тому или иному отделу.
• 2.9.1 Сотрудники старшего состава обязаны носить Бейджик - № 15. 
• 2.9.2 Cотрудники без отдела обязаны носить Бейджик - № 4. 
• 2.9.3 Глава отдела носит Бейджик №12.
• 2.9.4 Заместитель главы отдела носит Бейджик №8.
• 2.9.5 Сотрудник Отдела Inspection Department обязан носить Бейджик №21.
• 2.9.6 Сотрудник Отдела Стажировки обязан носить Бейджик №6.
• 2.9.7 Ответственный за работу в Филиале Бейджик №26
• 2.9.8 Сотрудник который приходится Экзаменатором по заявке обязан носить Бейджик № 19.
• 2.9.9 Сотрудники находящиеся на стажировке обязаны носить бейджик Бейджик - № 23.
• 2.9.10 Куратор автошколы должен носить Бейджик - № 28.
• 2.10 Сотрудник Автошколы обязан подчиняться старшим по должности.
• 2.11 В рабочее время сотрудник обязан носить униформу выданную в офисе.
• 2.12 Сотрудник Автошколы обязан выбрать отдел после получения им должности "Экзаменатор". (Сотрудники без отдела не будут повышаться).
• 2.13 Сотрудник Автошколы обязан качественно обслуживать своих клиентов.
• 2.14 Сотрудник Автошколы обязан спать только в комнате отдыха в офисе Автошколы. (Исключение: Старшему Составу разрешено спать в комнате отдыха в офисе Автошколы и на парковке в личных автомобилях)
• 2.15 Сотрудник Автошколы, находящийся в должности Мл.Менеджера и выше, обязан обновлять реестр каждый день до 00:00.
• 2.16 Сотрудник Автошколы, находящийся в должности Мл.Менеджера и выше, обязан докладывать по рации о каждом увольнении/повышении/понижении. 
• 2.17 Каждый сотрудник после входа (выхода) в комнату отдыха должен закрывать за собой двери.
• 2.18 Сотрудник Автошколы, продавший лицензию на бизнес без заявления владельца получает выговор I степени;


[3] Рабочий день в Автошколе:

• 3.1 В будни, рабочий день длится с 09:00 до 20:00. В выходные дни рабочий день длится с 10:00 до 19:00.
• 3.2 Время для перерыва (обеда) с 13:00 до 14:00.
• 3.3 В рабочее время запрещено носить любые аксессуары. (Исключение: очки, часы, усы и чемоданы)
• 3.4 Запрещено покидать офис в рабочее время без разрешения ст.состава.
• 3.5 Время прибытия на работу, независимо от места проживания — 15 минут.
• 3.6 Каждый сотрудник, опаздывающий на работу по любым причинам, вправе отсрочить свое прибытие, уведомив об этом руководство Автошколы.(не более чем на 10 минут)
• 3.7 По желанию сотрудник может остаться на ночную смену после конца рабочего дня.
• 3.8 Запрещено находиться на автомобильной ярмарке в рабочее время.
• 3.9 Разрешено в течение рабочего дня посещать МП от администраторов, а также системные МП (гонки / Base Jump / Paint Ball), но при этом сообщать в рацию, что вы отправляетесь на мероприятие;?
• 3.10 Разрешено покидать офис для доставки лицензий, проведения лекций гос. организациям, а также чтобы покушать.?


[4] Сотрудникам Автошколы запрещается:

• 4.1 Покидать рабочее место без разрешения старших.
• 4.2 Младшему составу запрещено спать вне комнаты отдыха.
• 4.3 Носить одежду не по своей должности.
• 4.4 Брать вертолет без разрешения.
• 4.5 Хамить клиентам.
• 4.6 Запрещено отказывать в обслуживании клиента, если у Вас к нему личная неприязнь;?
• 4.7 Запрещено выдавать лицензии без проведения экзамена;?
• 4.8 Запрещено вводить в заблуждение и обманывать старший состав и коллег;?
• 4.9 Отбирать друг у друга клиентов.
• 4.10 Находиться в казино в рабочее время.
• 4.11 Носить любые аксессуары, за исключением очков и часов и беретов.
• 4.12 Спать более десяти минут (600 секунд) каждый час во время рабочего дня. Исключения: работа в ночную смену, работа с оф. порталом (отчет) или разрешение Управляющего.
• 4.13 За АФК без ESC следует наказание от предупреждения, до увольнения.?
• 4.14 Заводить разговоры о повышении или назначения на управляющую должность в любой форме ( В любые чаты, в том числе /f, /fb, /b, /sms ).
• 4.15 Использовать транспорт, принадлежащий Автошколе, в личных целях.
• 4.16 Работать на любой государственной работе, не снимая рабочую форму.
• 4.17 Посещать автомобильную ярмарку в рабочее время.
• 4.18 Запрещается Употребление Наркотиков и Алкоголя
• 4.19 Запрещено использовать дверь в комнате отдыха в развлекательных намерениях.
• 4.20 Запрещено выдавать лицензию на бизнес без заявления владельца.
• 4.21 Запрещено использовать нецензурные выражения (как в IC так и в OOC чаты)
• 4.22 Запрещено хранить запрещенные материалы и наркотические вещества.


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

Примечания:

За нарушение этих правил в IC вы будете уволены с причиной "нарушение проф. этики". 
За нарушение этих правил в ООС вы будете уволены с причиной "аморальное поведение", согласно РП легенде для всех вы совершили некий аморальный поступок.
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

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Ник\t{ffffff}Ранг\t{ffffff}Статус'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{139BEC}Inst Tools {ffffff}| {ae433d}Сотрудники вне офиса {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{139BEC}Inst Tools {ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
  if id == nil then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Введите: /vig ID Причина", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{139BEC}Inst Tools {ffffff}| Введите: /vig ID ПРИЧИНА", -1)
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
   if rank == 'Координатор' or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
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
		ftext('{FFFFFF}Данная команда доступна с 6 ранга.', 0x046D63)
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
                submenus_show(oinvite(id), "{139BEC}IT {ffffff}| Выбор отдела")
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
 
function oinvite(id)
 return
{
  {
   title = "{FFFFFF}Human Resources {139BEC}Department",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника HRD и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 6')
	wait(1500)
	sampSendChat('/b тег в /r [Emp of HRD]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Сотрудник HRD.', cfg.main.tarr))
	end
   },
   {
   title = "{FFFFFF}Inspection {139BEC}Department",
    onclick = function()
	sampSendChat('/me достал(а) бейджик Сотрудника ID и передал(а) его '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(1500)
	sampSendChat('/b /clist 21')
	wait(1500)
	sampSendChat('/b тег в /r [Emp.ID]')
	wait(1500)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - новый Сотрудник ID.', cfg.main.tarr))
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}Меню {139BEC}лекций",
    onclick = function()
	submenus_show(fthmenu(id), "{139BEC}IT {ffffff}| Меню лекций")
	end
   },
    {
   title = "{FFFFFF}Меню {139BEC}гос.новостей {ff0000}(Для Ст.Состава)",
    onclick = function()
	if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
	submenus_show(govmenu(id), "{139BEC}IT {ffffff}| Меню гос.новостей")
	else
	ftext('Вы не находитесь в Ст.Составе')
	end
	end
   },
   {
   title = "{FFFFFF}Меню {139BEC}отделов",
    onclick = function()
	if cfg.main.tarb then
	submenus_show(otmenu(id), "{139BEC}IT {ffffff}| Меню отделов")
	else
	ftext('Включите автотег в настройках')
	end
	end
   },
   {
   title = "{FFFFFF}Доставка лицензий {139BEC}в любую точку штата в /d{ff0000}(Для 4+ ранга)",
    onclick = function()
	if rank == 'Мл.Инструктор' or rank == 'Инструктор' or rank == 'Координатор' or rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
	sampSendChat(string.format('/d OG, Осуществляется доставка лицензий в любую точку штата. Тел: %s.', tel))
	else
	ftext('Ваш ранг недостаточно высок')
	end
	end
   },
   {
   title = "{FFFFFF}Список {139BEC}сотрудников находящихся не в офисе",
    onclick = function()
	pX, pY, pZ = getCharCoordinates(playerPed)
	if getDistanceBetweenCoords3d(pX, pY, pZ, 2351.8020, 1660.9800, 3041.0605) < 50 then
	dmch()
	else
	ftext('Вы должны находиться в офисе')
	end
	end
   }
}
end

function otmenu(id)
 return
{
  {
   title = "{FFFFFF}Пиар отдела в рацию (HRD) {ff0000}(Для глав/замов отдела)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Уважаемые сотрудники, минуточку внимания.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: В Human Resources Department производится пополнение сотрудников.', cfg.main.tarr))
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
	wait(1200)
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
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
    title = "{FFFFFF}Лекция для {139BEC}Стажёра",
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
        sampSendChat("Если возникнут вопросы обращайтесь к Сотрудникам HRD либо к ст. Составу. ")
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
    title = "{FFFFFF}Лекция для {139BEC}Экзаменатора",
    onclick = function()
	sampSendChat("Приветствую")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Поскольку вы приняты по заявке на должность Экзаменатора, вам необходимо определиться с отделом.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /clist 19")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("HRD - Human Resources Department, занимающийся непосредственно обучением стажёров.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("ID - Inspection Department, занимающийся профилактикой нарушений и аварийных ситуаций.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("С участием транспорта, через проведение лекций и проверок гос. структур")
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
        sampSendChat("Если возникнут вопросы обращайтесь к Сотрудникам HRD либо к ст. Составу.")
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
    title = "{FFFFFF}Лекция про {139BEC}ПДД",
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
    title = "{FFFFFF}Лекция про {139BEC}Правильное обращение с оружием",
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
    title = "{FFFFFF}Лекция про {139BEC}Правила управления водным транспортом",
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
    title = '{FFFFFF}Лекция {139BEC}"Как вести себя в экстремальных ситуациях"',
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
        sampSendChat("Вторая — самая критическая ситуация.")
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Когда продолжение движения может вызвать необратимые последствия.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Нужно тормозить в препятствие.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("Оптимально для этого подойдут кусты или сугробы, хуже — заборы и отбойники.")
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat("И самое последнее — другие автомобили, фонарные столбы, остановки.")
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
    title = "{FFFFFF}Лекция про {139BEC}Правила рыбной ловли",
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
    title = "{FFFFFF}Лекция про {139BEC}Пилотирование",
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
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(u8'Настройки##1', first_window, imgui.WindowFlags.NoResize)
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
	if imgui.SliderInt(u8'Задержка в лекциях (сек)', waitbuffer,  4, 10) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Автоскрин лекций"))
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
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Inst Tools | Устав АШ'), ystwindow)
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
	local text = 'Разработчик:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Damien_Requeste')
    imgui.Separator()
	if imgui.Button(u8'Биндер', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Настройки скрипта', imgui.ImVec2(120, 30)) then
      first_window.v = not first_window.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Перезагрузить скрипт', imgui.ImVec2(150, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(u8'Помощь', imgui.ImVec2(55, 30)) then
      helps.v = not helps.v
    end
	imgui.Separator()
	imgui.BeginChild("Информация", imgui.ImVec2(410, 100), true)
	imgui.Text(u8 'Имя и Фамилия:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Должность:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Номер телефона:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Тег в рацию:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Номер бейджика:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Текущая дата: %s")).x)/3.5)
	imgui.Text(u8(string.format("Текущая дата: %s", os.date())))
    imgui.End()
  end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(u8 'Помощь по скрипту', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Список команд", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/tset - Открыть меню скрипта')
                imgui.Separator()
                imgui.BulletText(u8 '/vig [id] [Причина] - Выдать выговор по рации')
                imgui.BulletText(u8 '/dmb - Открыть /members в диалоге')
                imgui.BulletText(u8 '/where [id] - Запросить местоположение по рации')
                imgui.BulletText(u8 '/yst - Открыть устав АШ')
				imgui.BulletText(u8 '/smsjob - Вызвать на работу весь мл.состав по смс')
                imgui.BulletText(u8 '/dlog - Открыть лог 25 последних сообщений в департамент')
				imgui.Separator()
                imgui.BulletText(u8 'Клавиши: ')
                imgui.BulletText(u8 'ПКМ+Z на игрока - Меню взаимодействия')
                imgui.BulletText(u8 'F2 - "Быстрое меню"')
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
                imgui.Text(u8('Вышло обновление скрипта Inst Tools до версии '..updversion..'. Что бы обновиться нажмите кнопку внизу. Список изменений:'))
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
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function tset()
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

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{ffffff}» Инструктор",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Цены лицензий",
        onclick = function()
        pID = tonumber(args)
        submenus_show(pricemenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Вопросы",
        onclick = function()
        pID = tonumber(args)
        submenus_show(questimenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Оформление",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{139BEC}Inst Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		  sampSendChat('/me поставил печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		  sampSendChat('/me поставил(а) печать "Autoschool San Fierro" и передал(а) лицензию '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
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
		if gmegaflvl > 1 then
        sampSendChat("Стоимость данной лицензии составляет - 50.000$.")
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
    if not doesFileExist('moonloader/instools/ystav.txt') then
        local file = io.open("moonloader/instools/ystav.txt", "w")
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
				updversion = info.latest
                ttt = updlist1
			    if info and info.latest then
                    version = tonumber(info.latest)
                    if version > tonumber(thisScript().version) then
                        ftext('Обнаружено обновление до версии '..updversion..'.')
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

function smsjob()
  if rank == 'Мл.Менеджер' or rank == 'Ст.Менеджер' or rank == 'Директор' or  rank == 'Управляющий' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' На работу')
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

function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
            ftext('Цвет ника сменен на: {'..color..'}' .. cfg.main.clist)
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
                ftext('Цвет ника сменен на: {'..color..'}' .. cfg.main.clist)
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
    if text:find('Рабочий день окончен') and color ~= -1 then
        rabden = false
    end
	if text:find('Вы выгнали') then
        local un1, un2 = text:match('Вы выгнали (.+) из организации. Причина: .+')
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - Уволен(а) по причине "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - Уволен(а) по причине "%s".', un1:gsub('_', ' '), un2))
		end
    end
	if text:find('Вы предложили (.+) вступить в Driving School.') then
        local inv1 = text:match('Вы предложили (.+) вступить в Driving School.')
		lua_thread.create(function()
		wait(5000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: Новый сотрудник Автошколы - %s. Добро пожаловать.', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r Новый сотрудник Автошколы - %s. Добро пожаловать.', inv1:gsub('_', ' ')))
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