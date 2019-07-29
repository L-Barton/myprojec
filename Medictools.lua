script_name('Medic Tools')
script_version('1.1')
script_author('Roma_Mizantrop')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
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
ctag = "Medic Tools {ffffff}|"
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

local fileb = getWorkingDirectory() .. "\\config\\medictools.bind"
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

local medictools =
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
cfg = inicfg.load(nil, 'medictools/config.ini')

local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
    ftext("Medic Tools успешно загружен. Введите: /mt для получения дальнейшей информации", -1)
  end
  if not doesDirectoryExist('moonloader/config/medictools/') then createDirectory('moonloader/config/medictools/') end
  if cfg == nil then
    sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Отсутсвует файл конфига, создаем.", -1)
    if inicfg.save(medictools, 'medictools/config.ini') then
      sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Файл конфига успешно создан.", -1)
      cfg = inicfg.load(nil, 'medictools/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Загружается библиотека '..v)
        end
    end
	if not doesFileExist("moonloader/config/medictools/keys.json") then
        local fa = io.open("moonloader/config/medictools/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/medictools/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/medictools') then createDirectory('moonloader/medictools') end
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
  sampRegisterChatCommand('mt', mt)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('blag', blag)
  sampRegisterChatCommand('pd', cmd_pd)
  sampRegisterChatCommand('cchat', cmd_cchat)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('nick', nick)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('find', cmd_find)
  sampRegisterChatCommand('uninvite', uninvite)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('По завершению введите команду еще раз.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medictools/config.ini') -- сохраняем все новые значения в конфиге
            end
        else
            ftext('Для начала включите инфо-бар.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Отсутсвует файл конфига, создаем.", -1)
      if inicfg.save(medictools, 'medictools/config.ini') then
        sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Файл конфига успешно создан.", -1)
        cfg = inicfg.load(nil, 'medictools/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
	if frac == 'Hospital' then
    submenus_show(fastmenu(id), "{008B8B}Medic Tools {ffffff}| Быстрое меню")
	else
	ftext('Возможно вы не состоите в MOH {ff0000}[ctrl+R]')
	end
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
			if frac == 'Hospital' then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] {ffffff}Уровень - "..sampGetPlayerScore(id).." ")
				else
			ftext('Возможно вы не состоите в MOH {ff0000}[ctrl+R]')
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
1.1 - Все статьи и правила, изложенные в данном документе, обязательны к исполнению. 
1.2 - За нарушение статей и правил сотрудник получает наказание. Вид наказания выбирается начальством. 
1.3 - Решение главного врача является окончательным и обжалованию не подлежит. 
1.4 - Устав может дополняться и изменяться Главным Врачом в любое время. 
1.5 - Нарушить устав или же приказать нарушить его может лишь Главный Врач. 

2.1 - Сотрудник министерства здравоохранения обязан оказывать медицинскую помощь всем, независимо от материального состояния, положения в обществе, религии, расы и так далее. 
2.1.1 - Нарушая пункт "2.1" - вы нарушаете клятву Гиппократа, следовательно вы будете уволены независимо от должности. 
2.2 - Сотрудник обязан госпитализировать больного, если на это есть необходимость. 
2.3 - Медицинский работник не имеет права брать деньги или материальные ценности от больного с целью возвышения его приоритета. Исключение: Наркологи. 
2.4 - Запрещено самостоятельно менять цены на лечение от наркозависимости. 
2.5 - Категорически запрещено лечить без отыгрывания Role Play. | Наказание: Выговор | Понижение | Увольнение. 
2.6 - Если у пациента нет денег на лечение, сотрудник по своему желанию может дать необходимую сумму пациенту. 
2.7 - Сотрудник обязан общаться в официально-деловом стиле. 
2.8 - Сотрудник обязан занимать любой свободный, положенный по должности пост, сразу же после заступления на работу. 
2.9 - Каждый сотрудник обязан с уважением относиться к каждому сотруднику, независимо от должности. 
2.10 - Сотрудник имеет право высказать своё мнение Главному Врачу или его заместителям по телефону или при личной встрече.
2.10.1 - Высказывать возражение на приказ по Рации запрещено.
2.11 - Парковать личный транспорт сотрудник обязан исключительно на стоянке для личного транспорта. 
2.12 - За неправильную парковку сотрудник обязан оплатить штраф в размере 5.000$. Деньги пойдут в фонд Министерства. 
2.13 - Отдыхать сотрудник обязан исключительно в ординаторской больницы.

3.1 - График работы в будние дни (Пн. — Пт.) начинается с 08:00 и заканчивается в 21:00. После окончания рабочей смены сотрудники может ехать домой или вправе остаться на ночную смену. 
3.3.1 - Запрещается нахождение в выходном более 15 минут | Наказание: Наряд | Выговор | Увольнение. 
3.2 - График работы в выходные дни (Сб. — Вс.) начинается с 9:00 и заканчивается в 17:00. 
3.3 - Каждый сотрудник по прибытию в штат обязан явиться на работу в течение 15 минут. 
3.5 - Обеденный перерыв начинается в 13:00 до 14:00 ежедневно. 
3.6 - Работа по похищениям / терактам осуществляется круглосуточно. 
3.7 - Главный врач вправе изменить рабочее время в любой день.

4.1 - Медицинский работник имеет право пользоваться специализированными каретами скорой медицинской помощи. 
4.2 - Медицинские работники, имеющие должность спасателя и выше, имеют право пользоваться специализированными вертолетами, принадлежащие Министерству Здравоохранения. 
4.3 - Водитель спец. кареты скорой медицинской помощи обязан поддерживать ее состояние, уровень бензина не должен падать ниже 20 литров. 
4.3.1 - Если у водителя кареты скорой медицинской помощи нет денег на поддержку её рабочего состояния, и заправки топлива, он обязан перед эксплуатацией сообщить руководству и отказаться от использовании кареты. 
4.4 - Задействовать спец. сигналы водитель может только если он спешит на вызов, либо везёт пациента в больницу. 
4.4.1 - Использование спец.сигналов в личных и других целях запрещено. Наказание: Выговор | Понижение. 
4.5 - Выезд на встречную полосу, даже если Вы едете с задействованным спец.сигналом, строго запрещен. Наказание: Наряд| Выговор. 
4.6 - Категорически запрещена стояка посреди проезжей части. | Наказание: Выговор. 
4.7 - Запрещено использовать транспорт Министерства Здравоохранения в личных целях. | Наказание: Выговор | Понижение. 
4.7.1 - Запрещено подрабатывать таксистом на карете. Наказание: Выговор | Понижение. Исключение: Подвезти коллегу до больницы. 
4.7.2 - Категорически запрещено спать (AFK) в спец. карете на посту или посреди проезжей части более 120 секунд. | Наказание: Выговор. 
4.8 - Специализированные автомобили «Stratum» у больницы разрешено брать с должности Мед.Брат и только в служебных целях. 

5.1 - Медицинский работник может быть повышен в должности лишь за отличную работу. 
5.1.1 - Экзамены для повышения квалификации проходят согласно утвержденным нормам. 
5.1.2 - Повысить сотрудника до Психолога и выше может только Главный Врач, либо его прямой заместитель. 
5.1.3 - Запрещено повышать или понижать кого-либо по приказу министра или мэра штата. 
5.2 - Запрещается выпрашивать или намекать на повышение. | Наказание: Понижение | Увольнение. Исключение: Напомнить о своих сроках для повышения квалификации. 
5.3 - Наличие одного выговора является предупреждением. | Наличие второго выговора карается понижением в должности | Наличие трёх выговоров карается увольнением. 
5.3.1 - Система выговоров действует на всех сотрудников без исключения. 
5.3.2 - Выговор может быть снят , отработкой в наряде. Примечание: Только легкие нарушения. 
5.3.3 - Выговор может снять только выдавший или же Глав.Врач и его Прямой Заместитель. 
5.4 - Заходить в Кабинет Глав Врача без стука и его разрешения запрещено. | Наказание: Наряд.
5.5 - Медицинский работник может быть уволен за: жалобы, плохую работу, несоблюдение Устава, низкий уровень квалификации, по решению начальства, а так же по собственному желанию. 

6.1 - Медицинские работники обязательно должны быть вежливыми и обращаться к старшим по должности коллегам строго на «Вы». 
6.1.2 - Обращение к коллеге идет по форме: Должность, Имя сотрудника, обращение. Пример: Психолог Александр, можно с Вами поговорить?; Хирург Ник, Можно Вас на минуту? 
6.2 - В речи медицинского работника не допускается брань, ругань, любые формы унижения, а так же оскорбительные слова в сторону коллег и граждан штата. | Наказание: Наряд | Выговор. 
6.3 - Запрещается вводить в заблуждение руководство, а также своих коллег. | Наказание: Понижение | Увольнение. 
6.4 - Запрещено говорить невпопад (флудить) в рацию министерства, а также в рацию департамента. | Наказание: Выговор | Понижение. | Увольнение 
6.5 - Запрещено говорить в рацию департамента без уважительной причины. Наказание: Выговор Понижение ( Это рация, в которую можно обратиться за помощью к SAPD, FBI, Army SA,а в частности, в случае похищения или теракта. )
6.5.1 - Говорить по рации департамента могут лишь сотрудники, получившие должность Спасатель | Наказание: Понижение | Увольнение. Исключение: Похищение. 
6.6 - Запрещается выяснять отношения, материться. | Наказание: Понижение | Увольнение. 
6.6.1 - Запрещается выяснение отношений с использованием рации. | Наказание: Выговор | Понижение. 
6.7 - Запрещается драться, вести себя неадекватно. | Наказание: Наряд | Выговор. 
6.8 - Запрещается рекламировать что-либо с целью продажи в рацию министерства или департамента. | Наказание: Выговор | Понижение. 
6.9 - Сотрудник обязан поприветствовать коллегу при встрече, даже если у них нет дружественных отношений. 
6.10 - Любому сотруднику министерства запрещается нарушать законы штата (MG), уголовный и административный кодексы. | Наказание: Выговор | Понижение. 
6.11 - Запрещается помогать преступнику скрыться или уходить от преступления самим. | Наказание: Выговор |Понижение. 
6.12 - Запрещается хранить наркотические вещества. | Наказание: Увольнение. 
6.12.1 - Запрещается употребление наркотических веществ, а также быть в алкогольном опьянении на работе. | Наказание: Увольнение. 
6.13 - Запрещается хранить краденные военные материалы или оружие без лицензии. | Наказание: Увольнение. 
6.14 - Запрещается заниматься авто угоном в любое время. Наказание: | Наказание: Увольнение. 
6.15 - Запрещается подрабатывать в рабочее время. | Наказание: Понижение | Увольнение. 
6.16 - Запрещается посещать казино в рабочее время. | Наказание: Понижение | Увольнение. 
6.17 - Запрещается посещать авто ярмарку и заниматься перепродажей авто и домов в рабочее время. | Наказание: Выговор | Понижение | Увольнение. 
6.18 -Если сотрудник МОН подает жалобу на коллегу и есть подозрение на умышленный "слив" сотрудника , Глав.Врач может отказать в жалобе. | Наказание: Увольнение.

7.1 - Медицинский работник имеет право взять отпуск или неактив. 
7.1.1 - В отпуск или неактив разрешено уходить с должности Доктор (6 ранг). 
7.2 - Длительность отпуска или неактива указывается самим мед. работником, подписать может только Главный Врач. 
7.2.1 - В заявлении на отпуск обязательно нужно указать дату окончания отпуска. В противном случае, в отпуске будет отказано. 
7.2.2 - Минимальный срок отпуска 7 дней. Максимальный срок 21 день. 
7.3 - В случае, если мед. работник возвращается в указанный срок, его должность восстанавливается. 
7.4 - В случае, если мед. работник не возвращается в указанный срок, его должность окончательно аннулируется. 
7.5 - Медицинский работник может вернуться из отпуска в любое время (до указанного срока). 
7.6 - Заместителям главного врача в отпуск можно уйти не более одного раза в 2 месяца. 
7.7 - Хирургам в отпуск можно уйти не более одного раз в месяц. 
7.8 - В отпуске запрещается состоять в криминальных сферах. 

8.1 - Медицинский работник, отправленный на пост или патруль, обязан докладывать о состоянии на посту/патруле каждые 5 минут. Отсутствие доклада карается выговором. 
8.2 - Доклад имеет форму: /r [Отдел]: Доклад || Пост: __ || Вылечено: __ ||. 
8.2.1 - Запрещено мешать OOC и IC информацию. Например: Докладываю: Покинул пост || Причина: (( AFK )). AFK, ОФФ заменять словами «Отдохнуть», «Отдых». Например: Докладываю: Покинул пост || Причина: Отдых. 
8.3 - Медицинская помощь на призывах в армии осуществляются с должности Санитар и выше. 
8.3.1 - Интерны имеют право ехать на призыв только в случае отсутствия Санитаров, Мед.Работников и Спасателей. 

9.1 - У каждого сотрудника министерства согласно занимаемой должности полагается соответствующая форма.
9.2 - Сотрудники обязаны при себе иметь бейдж согласно своей должности/отдела.
9.2.1 - Ношение бейджика или формы не по должности | Наказание: Наряд | Выговор
9.2.2 - Ношение мужчинам женской формы | Наказание: Наряд | Выговор 
9.2.3 - Отсутствие бейджика на форме во время рабочего дня/ночного дежурства | Наказание: Выговор 
9.2.4 - Отказ от смены формы, надетой не по должности | Наказание: Увольнение 
9.3 - Сотрудники могут использовать такие аксессуары, как чемодан, рюкзак, затемненные очки. 
9.3.1 - Использовать аксессуары в виде масок, ёлок, коробок и любых других предметов, неприемлемых для формы врача | Наказание: Выговор | Понижение | Увольнение



Последние изменения. писал(а):
[ UPD - 17.07.2019 ]
6.18 - Если сотрудник МОН подает жалобу на коллегу и есть подозрение на умышленный "слив" сотрудника , Глав.Врач может отказать в жалобе. | Наказание: Увольнение. Добавлено
5.4 - Заходить в Кабинет Глав Врача без стука и его разрешения запрещено. | Наказание: Наряд. Изменено
4.5 - Выезд на встречную полосу, даже если Вы едете с задействованным спец.сигналом, строго запрещен. Наказание: Наряд| Выговор. Изменено 
4.7 - Запрещено использовать транспорт Министерства Здравоохранения в личных целях. | Наказание: Выговор | Понижение. Изменено 
4.8 - Специализированные автомобили «Stratum» у больницы разрешено брать с должности Мед.Брат и только в служебных целях. Изменено 
6.2 - В речи медицинского работника не допускается брань, ругань, любые формы унижения, а так же оскорбительные слова в сторону коллег и граждан штата. | Наказание: Наряд | Выговор.Изменено
6.7 - Запрещается драться, вести себя неадекватно. | Наказание: Наряд | Выговор. Изменено
9.2.1 - Ношение бейджика или формы не по должности | Наказание: Наряд | Выговор Изменен
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

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.глав.Врача' or rank == 'Глав.Врач' then
  if id == nil then
    sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Введите: /vig [id] [причина]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{008B8B}Medic Tools {ffffff}| Игрок с ID: "..id.." не подключен к серверу.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{008B8B}Medic Tools {ffffff}| /vig [id] [причина]", -1)
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
   if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.глав.Врача' or rank == 'Глав.Врач' then
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

        
function blag(pam)
    local id, frack, pric = pam:match('(%d+) (%a+) (.+)')
    if id and frack and pric and sampIsPlayerConnected(id) then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/d %s, благодарю %s за %s. Цените!", frack, rpname, pric))
    else
        ftext("Введите: /blag [id] [Фракция] [Причина]", -1)
    end
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
			sampShowDialog(716, "{008B8B}Medic Tools {ffffff}| {ae433d}Сотрудники вне офиса {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Показываем информацию.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{008B8B}Medic Tools {ffffff} | Лог сообщений департамента', table.concat(departament, '\n'), '»', 'x', 0)
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Интерн',
		['2'] = 'Санитар',
		['3'] = 'Мед.брат',
		['4'] = 'Спасатель',
		['5'] = 'Нарколог',
		['6'] = 'Доктор',
		['7'] = 'Психолог',
		['8'] = 'Хирург',
		['9'] = 'Зам.Глав.Врача'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.глав.Врача' or rank == 'Глав.Врач' then
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

function fastmenu(id)
 return
{
  {
   title = "{FFFFFF}Меню {008B8B}лекций",
    onclick = function()
	submenus_show(fthmenu(id), "{008B8B}Medic Tools {ffffff}| Меню лекций")
	end
   },
    {
   title = "{FFFFFF}Меню {008B8B}гос.новостей {ff0000}(Для Ст.Состава)",
    onclick = function()
	if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.глав.Врача' or rank == 'Глав.Врач' then
	submenus_show(govmenu(id), "{008B8B}Medic Tools {ffffff}| Меню гос.новостей")
	else
	ftext('Вам нельзя открывать')
	end
	end
   },
}
end

function govmenu(id)
 return
{
  {
   title = "{FFFFFF}Собеседование в интернатуру",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
    wait(5000)
    sampSendChat("/gov [Medic]: Уважаемые жители и гости нашего штата минуточку внимания.")
    wait(5000)
    sampSendChat('/gov [Medic]: Собеседование в интернатуру г.Los-Santos началось.')
    wait(5000)
    sampSendChat("/gov [Medic]: Высокая ЗП, бесплатные отели. Критерии: 3-х летняя прописка в штате, наличие мед. диплома.")
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
   title = "{FFFFFF}Проходит собеседование",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Medic]: Уважаемые жители и гости нашего штата минуточку внимания.")
        wait(5000)
        sampSendChat('/gov [Medic]: В данный момент проходит собеседование в интернатуру г.Los-Santos.')
        wait(5000)
        sampSendChat("/gov [Medic]: Высокая ЗП, бесплатные отели. Критерии: 3-х летняя прописка в штате, наличие мед. диплома.")
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
   title = "{FFFFFF}Конец собеседования",
    onclick = function()
	sampSendChat("/d OG, занял волну государственных новостей.")
        wait(5000)
        sampSendChat("/gov [Medic]: Уважаемые жители и гости нашего штата, собеседование подошло к концу.")
        wait(5000)
        sampSendChat('/gov [Medic]: Спешу вам сообщить, что на оф. сайте "Ministry of Health" открыты заявления для работы по контракту.')
        wait(5000)
        sampSendChat("/gov [Medic]: Заявление вы можете оставить на следующие должности: 'Нарколог и Мед Брат'.")
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
   title = "{FFFFFF}Занять гос. волну",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Занимаю гос.волну на X. Возражения на п.")
	end
   },
   {
   title = "{FFFFFF}Напомнить о займе гос. волны",
    onclick = function()
	sampSetChatInputEnabled(true)
	sampSetChatInputText("/d OG, Напоминаю что волна гос.новостей на X за MOH.")
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
    title = "{FFFFFF}Вступительная лекция",
    onclick = function()
        sampSendChat("Приветствую, новоприбывшие коллеги. Добро пожаловать в Министерство здравоохранения.")
        wait(cfg.commands.zaderjka * 1000) 
        sampSendChat("Вашим руководством являются: старший состав, заведующий вашим отделением и его заместители.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Рацию департамента разрешено использовать исключительно с должности мед. брата.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b /d разрешен 3 рангам и выше.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ваша основная обязанность в министерстве - оказание мед. помощи гражданам Штата..")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat(".. вне зависимости от расы пострадавшего, его религии, соц. положения и так далее.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Также, пока вы находитесь в нашем отделении, вы обязаны стоять на посту..")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat(".. либо патрулировать города, это по желанию, а также своевременно докладывать в рацию.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Доклады делаются раз в пять минут. Ни больше, ни меньше.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b Форма докладов:")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b При заступлении: /r [Интернатура]: Заступил на пост: Вокзал.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b Обычный: /r [Интернатура]: Пост: Мэрия | Вылечено: 0.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b При наличии напарника: /r [Интернатура]: Пост: Мэрия | Вылечено: 0 | Напарник: И. Иван.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b При уходе с поста: /r [Интернатура]: Покинул пост: Мэрия | Причина: Сон.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b При начале патруля: /r [Интернатура]: Начал патруль города LS.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b Обычный: /r [Интернатура]: Веду патруль города LS | Вылечено: 0.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("/b При завершении патруля: /r [Интернатура]: Завершил патруль города LS.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На работу вы должны прибыть ровно через пятнадцать минут.")
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Исключений для этого правила нет и оно действует для всех.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Всем тем, кто будет хамить коллегам и руководству светит путевка в ЧС министерства..") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat(".. со всеми почестями и прилагающимся. И это еще в лучшем случае.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("В худшем - я организую для него пикник..") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat(".. в лесу с червями, а органы бесстрашного найдут в баночках для анализов.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Также, хотелось бы сказать следующее:") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Разумеется, найдутся те, кто класть хотел на сие правила.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Если они продержатся здесь больше недели - это будет чудом и я поверю в Бога.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Для всех остальных, любящих трудится, скажу то, что вас ждет светлое будущее.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Ну и последнее: для того, чтобы получить повышение, вам нужно сдать клятву Гиппократа.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("Сдать ее вы сможете завтра, когда подойдет срок.") 
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat("На этой ноте я заканчиваю свой инструктаж. Вопросы сможете задать, когда я раздам бейджи.")
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
    title = "{FFFFFF}Первая помощь при кровотечении",
    onclick = function()
       sampSendChat("Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при кровотечении». ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Нужно четко понимать, что артериальное кровотечение представляет смертельную опасность для жизни. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Первое, что требуется – перекрыть сосуд выше поврежденного места. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Для этого прижмите артерию пальцами и срочно готовьте жгут. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Используйте в таком случае любые подходящие средства: ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("шарф, платок, ремень, оторвите длинный кусок одежды.") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Стягивайте жгут до тех пор, пока кровь не перестанет сочиться из раны. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("В случае венозного кровотечения действия повторяются, за исключением того, что..") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. жгут накладывается чуть ниже поврежденного места. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Следует помнить, что при обоих видах кровотечения жгут накладывается не более двух часов..") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. в жаркую погоду и не более часа в холодную. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("При капиллярном кровотечении следует обработать поврежденное место перекисью водорода.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. и наложить пластырь, либо перебинтовать рану. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Спасибо за внимание.")
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
   title = "{FFFFFF}Первая помощь при сотрясении мозга",
    onclick = function()
       sampSendChat("Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при сотрясении мозга».")
       wait(cfg.commands.zaderjka * 1000) 
       sampSendChat("Его признаками являются головокружение, головная боль, нарушение памяти, возникающие.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. после травмы черепа. Оказывая первую помощь.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. прежде всего нужно обеспечить проходимость дыхательных путей. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Для этого переверните пострадавшего на бок. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("В таком положении улучшается снабжение мозга кровью.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. а следовательно - кислородом, не западает язык. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Если человек не приходит в сознание более 30 минут..") 
       wait(cfg.commands.zaderjka * 1000) 
       sampSendChat(".. можно заподозрить тяжелую черепно-мозговую травму — ушиб мозга. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("В этом случае необходимо срочно вызвать врача и доставить пострадавшего в лечебное учреждение. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Спасибо за внимание.")
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
   title = "{FFFFFF}Первая помощь при обмороках",
    onclick = function()
      sampSendChat("Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при обмороках». ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Обмороки сопровождаются кратковременной потерей сознания, вызванной.. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat(".. недостаточным кровоснабжением мозга. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Обморок могут вызвать: резкая боль, эмоциональный стресс, ССБ и так далее. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Бессознательному состоянию обычно предшествует резкое ухудшение самочувствия: ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("нарастает слабость, появляются тошнота, головокружение, шум или звон в ушах. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Затем человек бледнеет, покрывается холодным потом и внезапно теряет сознание. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Первая помощь должна быть направлена на улучшение кровоснабжения мозга.. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat(".. и обеспечение свободного дыхания. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Если пострадавший находится в душном, плохо проветренном помещении, то.. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat(".. откройте окно, включите вентилятор или вынесите потерявшего сознание на воздух.")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Протрите его лицо и шею холодной водой, похлопайте по щекам и.. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat(".. дайте пострадавшему понюхать ватку, смоченную нашатырным спиртом. ")
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat("Спасибо за внимание.")
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
    title = "{FFFFFF}Первая помощь при переломах",
    onclick = function()
       sampSendChat("Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при переломах». ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Переломы классифицируются на полный и неполный по полноте разрыва кости, со смещением.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. и без смещения по позиции обломков друг по отношению к другу.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. открытый и закрытый по наличию повреждения кожи.") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Симптомы перелома: ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("сильная боль в месте травмы, деформация конечности, неестественное положение конечности.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. отек, кровоизлияние. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Первая помощь при переломах всегда включает в себя: восстановление целостности кости..") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. остановку кровотечения, антисептическую обработку раны.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. иммобилизацию конечности. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Больного необходимо очень бережно транспортировать в медицинское учреждение для оказания.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. медицинской помощи.")
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
    title = "{FFFFFF}Первая помощь при ДТП",
    onclick = function()
       sampSendChat("Приветствую, коллеги. Сегодня я прочту Вам лекцию на тему «Первая помощь при ДТП». ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Оказывая первую помощь, необходимо действовать по правилам. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Немедленно определите характер и источник травмы. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Наиболее частые травмы в случае ДТП - сочетание повреждений черепа.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. и нижних конечностей и грудной клетки. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Необходимо извлечь пострадавшего из автомобиля, осмотреть его. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Далее следует оказать первую помощь в соответствии с выявленными травмами. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Выявив их, требуется перенести пострадавшего в безопасное место.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. укрыть от холода, зноя или дождя и вызвать врача, а затем.. ")
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat(".. организовать транспортировку пострадавшего в лечебное учреждение.") 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat("Спасибо за внимание.")
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
	imgui.Text(u8("Инфо-бар продаж лицензий"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Включить/Выключить инфо-бар', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Инфо-бар включен, установить положение /sethud' or 'Инфо-бар выключен')
    end
	end
	imgui.Text(u8("Быстрый ответ на последнее смс"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Быстрый ответ смс', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Клавиша успешно изменена. Старое значение: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Новое значение: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medictools/keys.json')
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
    inicfg.save(cfg, 'medictools/config.ini') -- сохраняем все новые значения в конфиге
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | Устав MOH'), ystwindow)
                for line in io.lines('moonloader\\medictools\\ystav.txt') do
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
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 5))
    imgui.Begin('Medic Tools | Main Menu | Version: '..thisScript().version, second_window, mainw,  imgui.WindowFlags.NoResize)
	local text = 'Автор:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.43, 0.65 , 0.44, 2.0), 'Roma Mizantrop')
    imgui.Separator()
	if imgui.Button(u8'Биндер', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Настройки скрипта', imgui.ImVec2(120, 30)) then
      first_window.v = not first_window.v
    end
    imgui.SameLine()
    if imgui.Button(u8 'Сообщить об ошибке/баге', imgui.ImVec2(170, 30)) then os.execute('explorer "https://vk.com/ortemelyan"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(u8'Перезагрузить скрипт', imgui.ImVec2(150, 30)) then
      showCursor(false)
      thisScript():reload()
    end
    if imgui.Button(u8 'Отключить скрипт', imgui.ImVec2(120, 30), btn_size) then
      showCursor(false)
      thisScript():unload()
    end
	imgui.SameLine()
    if imgui.Button(u8'Помощь', imgui.ImVec2(55, 30)) then
      helps.v = not helps.v
    end
	imgui.Separator()
	imgui.BeginChild("Информация", imgui.ImVec2(410, 150), true)
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
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Текущая дата: %s")).x)/1.5)
	imgui.Text(u8(string.format("Текущая дата: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
                _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 180), imgui.Cond.FirstUseEver)
                imgui.Begin('Здесь скоро что-то будет!', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar) 
                imgui.CentrText(u8'Здесь скоро что-то будет!') 
                imgui.Separator()
                imgui.End()
    end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(3, 7))
                imgui.Begin(u8 'Помощь по скрипту', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Список команд", imgui.ImVec2(525, 385), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.TextColoredRGB('{FF0000}/mt{CCCCCC} - Открыть меню скрипта')
                imgui.Separator()
                imgui.TextColoredRGB('{FF0000}/vig [id] [Причина]{CCCCCC} - Выдать выговор по рации')
                imgui.TextColoredRGB('{FF0000}/dmb{CCCCCC} - Открыть /members в диалоге')
                imgui.TextColoredRGB('{FF0000}/yst{CCCCCC} - Открыть устав MOH')
				imgui.TextColoredRGB('{FF0000}/smsjob{CCCCCC} - Вызвать на работу весь мл.состав по смс')
                imgui.TextColoredRGB('{FF0000}/dlog{CCCCCC} - Открыть лог 25 последних сообщений в департамент')
				imgui.TextColoredRGB('{FF0000}/cchat{CCCCCC} - Очищает чат')
				imgui.TextColoredRGB('{FF0000}/blag [ид] [фракция] [тип]{CCCCCC} - Выразить игроку благодарность в департамент')
				imgui.TextColoredRGB('{FF0000}/nick [id] [0-1]{CCCCCC} - Копирует ник игрока по его id. Параметр 0 копирует РПник, 1 копирует НОНрп ник')
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
                imgui.Begin(u8('Medic Tools | Обновление'), updwindows, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
                imgui.Text(u8('Вышло обновление скрипта Medic Tools до версии '..updversion..'. Что бы обновиться нажмите кнопку внизу.'))
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
		local fa = io.open("moonloader/config/medictools/keys.json", "w")
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

function mt()
  if frac == 'Hospital' then
  second_window.v = not second_window.v
  else
  ftext('Возможно вы не состоите в MOH {ff0000}[ctrl+R]')
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
        title = "{ffffff}» Нурофен",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medicmenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Горло",
        onclick = function()
        pID = tonumber(args)
        submenus_show(gorlomenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Нашатырь",
        onclick = function()
        pID = tonumber(args)
        submenus_show(nawmenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Наркозависимость",
        onclick = function()
        pID = tonumber(args)
        submenus_show(narkomenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{ffffff}» Меню рентгена, порезов, переломов",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{008B8B}Medic Tools {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
    }
end

function gorlomenu(args)
    return
    {
      {
        title = '{ffffff}» Приветствие',
        onclick = function()
          sampSendChat("Здравствуйте, что вас беспокоит?")
		end
      },
      {
        title = '{ffffff}» Осмотр горла',
        onclick = function()
        sampSendChat("Хорошо, откройте рот.")
        wait(4000)
        sampSendChat("/me осмотрел горло")
        wait(4000)
        sampSendChat("/me достал аптечку")
        wait(4000)
        sampSendChat("/me нашел необходимый препарат")
        wait(4000)
        sampSendChat("/do Стопангин в руке.")
        wait(4000)
        sampSendChat("/me побрызгал горло пострадавшего Стопангином")
        wait(4000)
        sampSendChat("/heal "..id)
        wait(4000)
        sampSendChat("Удачного дня, не болейте.") 
		end
      }
    }
end

function narkomenu(args)
    return
    {
      {
        title = '{ffffff}» Приветствие',
        onclick = function()
        local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Здравствуйте. Я нарколог "..myname:gsub('_', ' ').."")
        wait(4000)
        sampSendChat("Стоимость сеанса от наркозависимости составляет 10.000$.")
		end
      },
      {
        title = '{ffffff}» Начало сеанса',
        onclick = function()
        sampSendChat("Присаживайтесь на кушетку и закатайте рукав.")
        wait(5000)
        sampSendChat("/do Шприц в руке.")
        wait(4000)
        sampSendChat("/me взял ватку смоченную мед.спиртом и обработал место укол")
        wait(4000)
        sampSendChat("/me затянул жгут на руке пациента, после чего ввел инъекцию ")
        wait(4000)
        sampSendChat("/me снял жгут и приложил ватку к месту укола")
        wait(4000)
        sampSendChat("/healaddict "..id" [10000]")
        wait(4000)
        sampSendChat("После проведения данного сеанса употреблять наркотические вещества категорически запрещено")
        wait(4000)
        sampSendChat("Всего доброго.") 
		end
      }
    }
end

function renmenu(args)
    return
    {
      {
        title = '{5b83c2}« Список процедур »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Рентгеновский аппарат',
        onclick = function()
        sampSendChat("Ложитесь на кушетку и лежите смирно.")
        wait(4000)
        sampSendChat("/me включил рентгеновский аппарат")
        wait(4000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
        wait(4000)
        sampSendChat("/me провел рентгеновским аппаратом по поврежденному участку")
        wait(4000)
        sampSendChat("/me рассматривает снимок")
        wait(4000)
        sampSendChat("/try обнаружил перелом") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом конечностей »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом конечностей',
        onclick = function()
        sampSendChat("Садитесь на кушетку.")
        wait(4000)
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(4000)
        sampSendChat("/do Рентгеновский аппарат зашумел.")
        wait(4000)
        sampSendChat("/me взял шприц с обезбаливающим, после чего обезболил поврежденный участок")
        wait(4000)
        sampSendChat("/me провел репозицию поврежденного участка")
        wait(4000)
        sampSendChat("/me подготовил гипсовый пороошок")
        wait(4000)
        sampSendChat("/me раскатил бинт вдоль стола, после чего втер гипсовый раствор")
        wait(4000)
        sampSendChat("/me свернул бинт, после чего зафиксировал перелом")
        wait(4000)
        sampSendChat("Приходите через месяц. Всего доброго!")
        wait(4000)
        sampSendChat("/me снял перчатки и бросил их в урну возле стола") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента перелом позвоночника/ребер »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Перелом позвоночника/ребер',
        onclick = function()
        sampSendChat("/me осторожно уклал пострадавшего на операционный стол")
        wait(4000)
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(4000)
        sampSendChat("/me подключил пострадавшего к капельнице")
        wait(4000)
        sampSendChat("/me намочил ватку спиртом и обработал кожу на руке пациента")
        wait(4000)
        sampSendChat("/me внутривенно ввел Фторотан")
        wait(4000)
        sampSendChat("/do Наркоз начинает действовать, пациент потерял сознание.")
        wait(4000)
        sampSendChat("/me достал скальпель и пинцет")
        wait(4000)
        sampSendChat("/me с помощью различных инструментов произвел репозицию поврежденного участка")
        wait(4000)
        sampSendChat("/me достал из тумбочки специальный корсет")
        wait(4000)
        sampSendChat("/me зафиксировал поврежденный участок с помощью карсета")
        wait(4000)
        sampSendChat("/me снял перчатки и бросил их в урну возле стола")
        wait(4000)
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий")
        wait(4000)
        sampSendChat("/do Прошло некоторое время, пациент пришел в сознание.") 
		end
      },
      {
        title = '{5b83c2}« Если у пациента глубокий порез »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Глубокий порез',
        onclick = function()
        sampSendChat("/me взял со стола перчатки и надел их")
        wait(4000)
        sampSendChat("/me провел осмотр пациента")
        wait(4000)
        sampSendChat("/me определил степень тяжести пореза у пациента")
        wait(4000)
        sampSendChat("/me обезболил поврежденный участок")
        wait(4000)
        sampSendChat("/me достал из мед. сумки жгут и наложил его поверх повреждения")
        wait(4000)
        sampSendChat("/me разложил хирургические инструменты на столе")
        wait(4000)
        sampSendChat("/me взял специальные иглу и нити")
        wait(4000)
        sampSendChat("/me зашил кровеносный сосуд и проверил пульс")
        wait(4000)
        sampSendChat("/me протер кровь и зашил место пореза")
        wait(4000)
        sampSendChat("/me отложил иглу и нити в сторону")
        wait(4000)
        sampSendChat("/me снял жгут, взял бинты и перебинтовал поврежденный участок кожи")
        wait(4000)
        sampSendChat("До свадьбы заживет, удачного дня, не болейте.")
        wait(4000)
        sampSendChat("/me убрал в отдельный контейнер грязный инструментарий") 
		end
      },
    }
end


function nawmenu(args)
    return
    {
      {
        title = '{ffffff}» Обработка ватки нашатырём',
        onclick = function()
        sampSendChat("/me открыл аптечку")
        wait(4000)
        sampSendChat("/me достал из аптечки ватку и нашатырь")
        wait(4000)
        sampSendChat("/me обработал ватку нашатырем, после чего поднес к носу пострадавшего")
        wait(4000)
        sampSendChat("/me водит ваткой вокруг носа")
        wait(4000)
        sampSendChat("Не волнуйтесь, у вас случился в обморок.")
        wait(4000)
        sampSendChat("Сейчас мы доставим вас в больницу, где разберемся с причиной данного недуга.") 
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

function medicmenu(id)
    return
    {
      {
        title = '{ffffff}» Приветствие.',
        onclick = function()
        sampSendChat("Здравствуйте, что вас беспокоит?") 
		end
      },
      {
        title = '{ffffff}» Дать препарат',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Хорошо, сейчас я вам помогу")
		wait(4000)
		sampSendChat("/me достал аптечку")
		wait(4000)
		sampSendChat("/me нашёл необходимый препарат")
		wait(4000)
		sampSendChat("/do Нурофен в руке")
		wait(4000)
		sampSendChat("/me передал пациенту лекарство и дал запить водой")
		wait(4000)
		sampSendChat("/heal "..id)
		wait(4000)
		sampSendChat("Удачного дня, не болейте")                                        		
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/medictools/ystav.txt') then
        local file = io.open("moonloader/medictools/ystav.txt", "w")
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
	downloadUrlToFile('https://raw.githubusercontent.com/Misanthrope123/myprojec/master/updatemedic.json', fpath, function(id, status, p1, p2)
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
  if rank == 'Психолог' or rank == 'Хирург' or rank == 'Зам.глав.Врача' or rank == 'Глав.Врач' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' На работу, у вас есть 15 минут, чтобы прибыть на работу. Затем последует понижение/увольнение')
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
        local inv1 = text:match('передал(- а) удостоверение (.+)')
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