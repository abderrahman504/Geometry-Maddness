extends Node

var sceneRoot : Node2D; # This is a variable that contains the root of the world scene
var player : KinematicBody2D;
var playerPistol : Node;
var playerExists : bool = false;
var tween : Tween;
var randNoGen : RandomNumberGenerator
var MainMenu : String = "res://Scenes&Scripts/UI/Menu.tscn";
var DeathMenu : String = "res://Scenes&Scripts/UI/you died.tscn";
var Level2Transition : String = "res://Scenes&Scripts/UI/level2_ani.tscn";
var bullet : String = "res://Scenes&Scripts/Other/Bullet.tscn";#The bullet scene path
var healthbarPath : String = "res://Scenes&Scripts/Other/HealthBar.tscn";
var hitEffect : String = "res://Scenes&Scripts/Other/HitEffect.tscn";
var shatterEffect : String = "res://Scenes&Scripts/Other/ShatterEffect.tscn";
var minionPath : String = "res://Scenes&Scripts/Characters/Minion.tscn";
var healthPickupPath : String = "res://Scenes&Scripts/Pickups/HealthPickup.tscn";
var GunPaths : Dictionary = {
	"shotgun"    : "res://Scenes&Scripts/Guns/Shotgun.tscn",
	"machinegun" : "res://Scenes&Scripts/Guns/Machinegun.tscn",
	"pistol"     : "res://Scenes&Scripts/Guns/Pistol.tscn",
	"split rifle": "res://Scenes&Scripts/Guns/SplitRifle.tscn",
	"heavy canon": "res://Scenes&Scripts/Guns/HeavyCanon.tscn",
	"mixed gun"  : "res://Scenes&Scripts/Guns/MixedGun.tscn"};

var GunDropPaths : Dictionary = {
	"shotgun" : "res://Scenes&Scripts/Pickups/ShotgunPickup.tscn",
	"machinegun" : "res://Scenes&Scripts/Pickups/MachinegunPickup.tscn",
	"split rifle" : "res://Scenes&Scripts/Pickups/SplitRiflePickup.tscn",
	"heavy canon" : "res://Scenes&Scripts/Pickups/HeavyCanonPickup.tscn"};

var enemyPaths : Array = [
	"res://Scenes&Scripts/Characters/Square.tscn", 
	"res://Scenes&Scripts/Characters/Hexagon.tscn", 
	"res://Scenes&Scripts/Characters/Pentagon.tscn"];

var lvl2EnemyPaths : Array = [
	"res://Scenes&Scripts/Characters/Lvl2Square.tscn",
	"res://Scenes&Scripts/Characters/Lvl2Hexagon.tscn",
	"res://Scenes&Scripts/Characters/Lvl2Pentagon.tscn"];



#Colour-to-gun mapping
enum GUNTYPES {Machinegun, HeavyCanon, SplitRifle, Shotgun, Pistol, Mixed} 
enum COLOURS {Red, Blue, Yellow, Green, Grey, Orange}
var colours : PoolColorArray = PoolColorArray([Color("f60c0c"), Color("174fe4"), Color("f6f918"), Color("03a327"), Color("666666"), Color("e87d00")])
var colourToGunMap : Array = [
	{"gun": GUNTYPES.Machinegun, "colour": COLOURS.Red}, 
	{"gun": GUNTYPES.HeavyCanon, "colour": COLOURS.Blue}, 
	{"gun": GUNTYPES.Pistol, "colour": COLOURS.Grey}, 
	{"gun": GUNTYPES.Shotgun, "colour": COLOURS.Green}, 
	{"gun": GUNTYPES.SplitRifle, "colour": COLOURS.Yellow}]






