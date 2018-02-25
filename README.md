# Justice Altis Alpha 0.2.1

## Inspiration
The basic idea of guerrilla units fighting regular army
and some basic mechanics are inspired by barbolani's Antistasi.
But I intend to make the mission more hardcore.

## Mission background
Year 2040. After 2035 incident Altis has joined CSAT.
The Armed Forces have been equipped by CSAT standards.
Civil rights and corruption situation became even worse.

In 2039 several severe internal CSAT conflicts have been started.
There was a tactical nuke exchange in South-East Asia.
CSAT has withdrawn it's financial support from Altis.
And the international community also has it's attention elsewhere.

Liberal views have started to gain popularity on Altis.
As a reaction to this Altis Prime Minister have consolidated his power.
Internet and mobile connections to the outside world have been severed.
The propaganda machine have been started.
Some of the most notable opposition leaders have disappeared without a trace.

Most of the remaining govenrment resources are beeing spent on the military.
Poverty rises, humanitarian situation deteriorates.

A small opposition group from Agios Konstantinos with some former
AAF military experience decided to start a guerrilla movement.

## Why alpha?
Current state in my opinion is a "minimal viable product".
You can play it, you can win and you can loose.
The basic gameplay outline is close enough to what is planned for the final version.

But the testing has been provided only by me and a couple of my friends.
Some very important features like counterattacks are not there.
Some mechanics are implemented on the most basic level.
Mission balance is likely not very good.

When all the intended features are there and the most crude solutions
are fixed I'll move the mission to Beta stage.

## Any issues?
Report on github https://github.com/nazarovtr/justice/issues

Attach your client and server rpt logs if possible. List the mods you are using.

The project project is open source and I'd appreciate some help with it.

## Manual

### Setup
Single player and vanilla saves are not supported.
You may play alone in a multiplayer game but you'll have much better experience in coop.
You'll need different roles and there is no AI on your side in Justice.
Dedicated server, even on one of the player's machines can significantly increase performance by more effective resource utilization.
But you'll need at least 16 GiB of memory and at least quad core hight frequency CPU.

There are 3 mission parameters which can be changed in multiplayer lobby.
- One forbids non-hosts and non-admins to become commanders. By default anyone can be a commander.
- Another one sets mission starting time.
Default early morning is recommended because players do not have any night-time gear at the start.
- A third one allows to set spawn distance - distance at which cities and enemy bases will become populated.
Default 1800 meters is a good tradeoff between gameplay and performance.
On high-end servers the value should be increased.

### Save system
At the start of the mission all players will see load dialog.
Any player can load one of the saves stored in his local profile (same place where the KotH progress is stored) or start a new game.
The player who does so becomes a commander.
Other players may do nothing or press "I am not a commander" button.

Any player can save the progress in his local profile using "persistent save" action on the main crate of guerrilla base.
This save then may be used to continue from that point on another server.

Vehicles inside base circle are saved.
Items inside vehicles are saved too.

Items equipped by players at the moment of the save and who are at the base are saved inside the main crate.
If a player is on the base but in a vehicle his items are saved in that vehicle.

### Base deployment
Commander has a menu action to deploy a base. The base consists of 4 items.
- A man who is there just as a temporary solution for base detection purposes,
- A main gray crate which is the equipment container. It also have several base management menu actions. Most notably "Move base" action.
- An auxilary green crate. It is intended to be used when the main crate will be full. You load items into it and then use an action on it to transfer everything to the main storage. Unfortunately there is no way to increase size of the container through mission scripting.
- A lamp to illuminate the base at night.

The commander should deploy and move the base several times on an open ground first to get used to it before trying to fit it in a building.

Having a base in some concealed place or maybe even in a building is a good idea.
Random patrols may detect it and destroy.
In case of base loss all the loot in it will be lost.
But the commander will be able to deploy a new base.

You may skip time on the base through action attached to the lamp.

### UI
There is a top state bar on each player's screen. It contains the most important information.
There you can see commander name, recruit count, money which is not yet used, guerrilla rating, guerrilla anti-rating, enemy rating, enemy anti-rating and current undercover state.

### Rating system
Both guerrilla movement and enemy forces have rating and anti-rating.

Rating is a percentage of population which supports you and anti-rating is a percentage which is against.

Raising your rating gives you more recruits and other bonuses like different items and even vehicles appearing on your base.

Every time a player dies recruit count is decreased.
If it is decreased to zero, the mission will be failed.

There is a fixed amount of recruitable units on Altis.
So you should try not to die much.

### Undercover
Undercover "not" means that player will be shot at by enemy.
"Civilian" means that enemies will treat the player as civilian.
When your undercover status changes to "not" you will see a hint with the reason.
Basically to stay undercover you should not openly wear weapons or armor,
drive military vehicles, get on enemy bases, drive offroad around enemy bases,
plant explosives, hang around dead bodies or other players who are not undercover themselves.

### First steps
The playable characters start at their homes at Agios Konstantinos.
Their vehicles are marked on the map.
I recommend to loot all the vehicles and take as many as you can with you.
Vehicles are a valuable resource in Justice.

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
