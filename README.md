# Justice Altis Alpha 0.6.0
Russian version below / Русская версия ниже.
## Inspiration
The basic idea of guerrilla units fighting regular army and some basic mechanics are inspired by barbolani's Antistasi. But I intend to make the mission more hardcore.

## Mission background
Year 2040. After 2035 incident Altis has joined CSAT. The Armed Forces have been equipped by CSAT standards. Civil rights and corruption situation became even worse.

In 2039 several severe internal CSAT conflicts have been started. There was a tactical nuke exchange in South-East Asia. CSAT has withdrawn it's financial support from Altis. And the international community also has it's attention elsewhere.

Liberal views have started to gain popularity on Altis. As a reaction to this Altis Prime Minister have consolidated his power. Internet and mobile connections to the outside world have been severed. The propaganda machine have been started. Some of the most notable opposition leaders have disappeared without a trace.

Most of the remaining government resources are beeing spent on the military. Poverty rises, humanitarian situation deteriorates.

A small opposition group from Agios Konstantinos with some former AAF military experience decided to start a guerrilla movement.

## Why alpha?
Current state in my opinion is a "minimal viable product". You can play it, you can win and you can loose. The basic gameplay outline is close enough to what is planned for the final version.

But the testing has been provided only by me and a couple of my friends. Some very important features are not there. Some mechanics are implemented on the most basic level. Mission balance is likely not very good.

When all the intended features are there and the most crude solutions are fixed I'll move the mission to Beta stage.

## Any issues?
Report on github https://github.com/nazarovtr/justice/issues

Attach your client and server rpt logs if possible. List the mods you are using.

The project is open source and I'd appreciate some help with it.

## Manual

### Setup
Single player and vanilla saves are not supported. You may play alone in a multiplayer game but you'll have much better experience in coop. You'll need different roles and there is no AI on your side in Justice. Dedicated server, even on one of the player's machines can significantly increase performance by more effective resource utilization. But you'll need at least 16 GiB of memory and at least quad core high frequency CPU.

There are 3 mission parameters which can be changed in multiplayer lobby.
- One forbids non-hosts and non-admins to become commanders. By default anyone can be a commander.
- Another one sets mission starting time. Default early morning is recommended because players do not have any night-time gear at the start.
- A third one allows to set spawn distance - distance at which cities and enemy bases will become populated. Default 1800 meters is a good tradeoff between gameplay and performance. On high-end servers the value should be increased.

### Save system
At the start of the mission all players will see load dialog. Any player can load one of the saves stored in his local profile (same place where the KotH progress is stored) or start a new game. The player who does so becomes a commander. Other players may do nothing or press "I am not a commander" button.

Any player can save the progress in his local profile using "Save game" action on the main crate of guerrilla base. This save then may be used to continue from that point on another server.

Vehicles inside base circle are saved. Items inside vehicles are saved too.

Items equipped by players at the moment of the save and who are at the base are saved inside the main crate. If a player is on the base but in a vehicle his items are saved in that vehicle.

### Base deployment
Commander has a menu action to deploy a base. The base consists of 4 items.
- A man who is there just as a temporary solution for base detection purposes.
- A main gray crate which is the equipment container. It also have several base management menu actions. Most notably "Move base" action.
- An auxilary green crate. It is intended to be used when the main crate will be full. You load items into it and then use an action on it to transfer everything to the main storage. Unfortunately there is no way to increase size of the container through mission scripting.
- A lamp to illuminate the base at night and to skip time.

The commander should deploy and move the base several times on an open ground first to get used to it before trying to fit it in a building. Having a base in some concealed place or maybe even in a building is a good idea. Random patrols may detect it and destroy. In case of base loss all the loot in it will be lost. But the commander will be able to deploy a new base.

### UI
There is a top state bar on each player's screen. It contains the most important information. There you can see commander name, recruit count, money which is not yet used, guerrilla rating, guerrilla anti-rating, enemy rating, enemy anti-rating and current undercover state.

### Rating system
Both guerrilla movement and enemy forces have rating and anti-rating.

Rating is a percentage of population which supports you and anti-rating is a percentage which is against.

Raising your rating gives you more recruits and other bonuses like different items and even vehicles appearing on your base.

You gain rating by capturing bases and destroying or stealing enemy vehicles. You lose some amount of rating for just killing people, because the soldiers are citizens too and they have families. So the cleanest approach is to destroy enemy vehicles with the least possible loss of life.

Every time a player dies recruit count is decreased. If it is decreased to zero, the mission will be failed.

There is a fixed amount of recruitable units on Altis. So you should try not to die much.

### Undercover
Undercover "not" means that player will be shot at by enemy. "Civilian" means that enemies will treat the player as civilian. When your undercover status changes to "not" you will see a hint with the reason. Basically to stay undercover you should not openly wear weapons or armor, drive military vehicles, get on enemy bases, drive offroad around enemy bases, plant explosives, hang around dead bodies or other players who are not undercover themselves.

### First steps
The playable characters start at their homes at Agios Konstantinos. Their vehicles are marked on the map. I recommend to loot all the vehicles and take as many as you can with you. Vehicles are a valuable resource in Justice.

Players with medic and especially engineer roles are highly recommended.

You may go and attack something right away or you may find a good place for the base first, deploy it there and save your game.

### Mission goal
Right now there are two basic ways to win.

The first is to wipe out most of enemy bases.

The second is to raise enemy anti-rating to 50%.

There are several endings which depend on player rating, enemy rating and losses on both sides.

### Additional features
- You may collect loot from enemy bodies into a vehicle by using a menu action on the body.
- By clicking on the map you can set "point of interest" circles inside of which nothing will be despawned.
- You can load loot from a vehicle to the main crate through main crate menu action.

## Mod support
The mission was tested and works with ACE 3, TFAR, Arma Enhanced Movement, Advanced Towing, bCombat, ASR AI and VCOM.

## Recommended mod setup
Arma Enhanced Movement, Advanced Towing.

ACE and/or some AI mod if you want.

Actually Justice is a very good starting point to get acquainted with ACE, TFAR and other hardcore mods.

## Вдохновление
Базовая идея повстанцев, противостоящих регулярной армии, и некоторые базовые механики вдохновлены миссией Antistasi разработчика barbolani. Но моя цель сделать миссию более хардкорной и реалистичной.

## Предыстория миссии
2040 год. После инцидента 2035 года Алтис присоединился к CSAT. Вооружённые силы были экипированы по их образцу. Ситуация с коррупцией и гражданскими правами ухудшилась.

В 2039 началось несколько крупных конфликтов внутри CSAT. В юго-восточной Азии произошёл обмен тактическими ядерными зарядами. CSAT прекратил финансовую поддержку Алтиса. Внимание мирового сообщества сосредоточено на крупных конфликтах.

Либеральные взгляды стали набирать популярность на Алтисе. В качестве реакции на это премьер министр консолидировал власть в своих руках. Интернет и мобильная связь со внешним миром были отключены. Была запущена машина пропаганды. Наиболее влиятельные лидеры оппозиции исчезли без следа.

Большая часть скудных государственных ресурсов тратится на военные нужды. Уровень бедности растёт, гуманитарная ситуация ухудшается.

Маленькая группа оппозиции из Айос-Константиноса с военным опытом в рамках AAF решила начать вооружённое восстание.

## Почему альфа?
Текущее состояние, на мой взгляд, это "минимальный жизнеспособный продукт". Миссия работает, можно победить, можно проиграть. Геймплей уже относительно близок к тому, что запланировано в финальной версии.

Но миссия тестировалась только мной и парой моих друзей. Многие принципиально важные элементы не реализованы. Некоторые механики реализованы на базовом уровне. Вероятно, баланс не в лучшем состоянии.

Когда все запланированные элементы будут реализованы, я переведу миссию в состояние беты.

## Что-то не работает?
Создавайте задачи на гитхабе: https://github.com/nazarovtr/justice/issues

Перечислите использованные моды. Желательно приложить rpt логи клиента и сервера.

Это open-source проект, и я был бы рад чьей-либо помощи в разработке.

## Руководство

### Запуск
Одиночная игра и стандартные сэйвы не поддерживаются. Можно играть в одиночку, запустив миссию в многопользовательском режиме, но миссия сделана для кооперативной игры. Вам пригодятся солдаты различных ролей, а в Justice нет ботов на вашей стороне.

Выделенный сервер, даже установленный на компьютере одного из игроков, может существенно увеличить производительность миссии за счёт более эффективной утилизации ресурсов. Но только если на этом сервере не меньше 16 Гб оперативной памяти и высокочастотный четырёхядерный процессор.

В мультиплеерном лобби можно настроить 3 параметра миссии:
- Один разрешает только админам или хостам становиться командирами. По умолчанию любой игрок может быть командиром.
- Другой позволяет настроить время старта миссии. По умолчанию выбрано раннее утро, так как игроки стартуют без ночного снаряжения.
- Третий разрешает настроить дистанцию спауна - это расстояние, на котором на базах и в городах появляются боты. Выбранные по умолчанию 1800 метров - золотая середина между производительностью и геймплеем. На мощных серверах дистанцию стоит увеличивать.

### Система сохранений
На старте миссии все игроки увидят диалог загрузки игры. Любой игрок может загрузить одно из сохранений своего локального профиля (там же хранится прогресс KotH) или начать новую игру. Сделавший это становится командиром. Остальные могут просто ждать или нажать на кнопку "Я не командир".

Любой игрок может сохранить прогресс миссии в своём локальном профиле, используя действие "Сохранить игру" на главном хранилище базы повстанцев. Это сохранение потом можно использовать на любом сервере.

Техника в пределах полупрозрачного круга вокруг базы сохраняется. Предметы в этой технике тоже сохраняются.

Предметы экипировки игроков, находящихся на базе, сохраняются в хранилище базы. Если игрок в технике на базе, то его снаряжение сохраняется в этой технике.

### Развёртывание базы.
У командира в меню есть действие "Развернуть базу". База состоит из 4 элементов.
- Человек, являющийся просто временным решением для обнаружения базы врагом.
- Главный серый ящик - хранилище снаряжения. На этом же ящике есть несколько важных действий, главное из которых - "Передвинуть базу"
- Вспомогательный зелёный ящик, который придётся использовать, когда заполнится основной ящик. Сначала вещи грузятся в него, а потом при помощи действия на нём, перегружаются в основной. К сожалению, только в рамках скриптов невозможно увеличить размер контейнера.
- Лампа для ночного освещения базы и проматывания времени.

Командиру стоит потренироваться в развёртывании базы на открытой ровной местности, перед тем как попробовать развернуть её в здании. База в плохо видимом месте или в здании - хорошая идея, так как случайный патруль может на неё наткнуться и уничтожить. В этом случае всё снаряжение будет потеряно, но командир сможет развернуть новую базу.

### Интерфейс
В верхней части экрана у каждого игрока есть строка состояния с самой важной информацией. Там указаны: имя командира, количество повстанцев, деньги (пока не используются), рейтинг повстанцев, антирейтинг повстанцев, рейтинг врагов, антирейтинг врагов и текущий режим "под прикрытием".

### Система рейтинга
И повстанцы, и враги имеют рейтинг и антирейтинг.

Рейтинг - процент населения, поддерживающий вас, антирейтинг - выступающий против вас.

Повышение рейтинга приносит вам больше добровольцев и других бонусов вроде появляющихся на базе предметов и даже гражданской техники.

Повысить рейтинг можно захватом баз и уничтожением или угоном вражеской техники. Так как солдаты - это тоже жители острова, и у них есть семьи, вы немного теряете рейтинг просто убивая их. Самый чистый подход - уничтожение вражеской техники с минимальными жертвами.

При каждой смерти игрока уменьшается количество повстанцев. При понижении до нуля миссия считается проваленной.

На Алтисе фиксированное количество людей, способных присоединиться к повстанцам, так что старайтесь умирать пореже.

### Под прикрытием
Режим "нет" означает, что враги будут стрелять по игроку. "Гражданский" значит, что враги будут считать игрока гражданским. Когда режим меняется на "нет", отобразится подсказка с причиной. В общих чертах, чтобы оставаться под прикрытием, не нужно открыто носить оружие или броню, ездить на военной технике, заходить на вражеские базы, ездить вокруг них не по дорогам, устанавливать взрывчатку, находиться рядом с трупами или другими игроками, которые не под прикрытием.

### Первые шаги
Игроки начинают в своих домах в Айос-Константинос. Их транспорт отмечен на карте, и я рекомендую собрать снаряжение из него и забрать с собой как можно больше. Техника - очень ценный ресурс в Justice.

Кому-то из игроков рекомендуется выбирать роли медиков и инженеров.

Можно сразу что-то атаковать, или можно сначала найти хорошее место для базы, развернуть её и сохраниться.

### Цель миссии
Пока есть два способа победить.

Первый - уничтожить почти все вражеские базы.

Второй - поднять антирейтинг врагов до 50%.

Концовок несколько. Они зависят от рейтинга, антирейтинга и потерь с обеих сторон.

### Дополнительные возможности
- Можно автоматически собирать снаряжение врагов в ближайшую технику при помощи соответствующего действия на трупе.
- Кликая на карте, можно добавлять круги "точек интереса", внутри которых ничего не деспаунится.
- Снаряжение из техники в хранилище базы можно перегружать действием на главном ящике.

## Поддержка модов
Миссия была протестирована и работает с ACE 3, TFAR, Arma Enhanced Movement, Advanced Towing, bCombat, ASR AI и VCOM.

## Рекомендуемые моды
Arma Enhanced Movement, Advanced Towing.

ACE и/или какой-то из модов искусственного интеллекта по желанию.

На самом деле, Justice - очень хорошая миссия для освоения ACE, TFAR и других хардкорных модов.