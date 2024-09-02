extends CharacterBody2D

var movement_speed = 60.0
var hp = 100
var maxhp = 100
var last_movement = Vector2.UP
var time = 0

var experience = 0
var experience_level = 1
var collected_experience = 0

#Attacks
var ghostDrill = preload("res://Player/Attacks/ghost_drill.tscn")
var pickBoomerang = preload("res://Player/Attacks/pick_boomerang.tscn")
var magneticChisel = preload("res://Player/Attacks/magnetic_chisel.tscn")

#AttackNodes
@onready var ghostDrillTimer = get_node("%GhostDrillTimer")
@onready var ghostDrillAttackTimer = get_node("%GhostDrillAttackTimer")
@onready var pickBoomerangTimer = get_node("%PickBoomerangTimer")
@onready var pickBoomerangAttackTimer = get_node("%PickBoomerangAttackTimer")
@onready var chiselBase = get_node("%ChiselBase")

#@onready var pause_menu = $GUILayer/PauseMenu
#var paused = false

#UPGRADES
var collected_upgrades = []
var upgrade_options = []
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0


#GhostDrill
var ghostdrill_ammo = 0
var ghostdrill_baseammo = 0
var ghostdrill_attackspeed = 1.5
var ghostdrill_level = 0

#PickBoomerang
var pickboomerang_ammo = 0
var pickboomerang_baseammo = 0
var pickboomerang_attackspeed = 3
var pickboomerang_level = 0

#MagneticChisel
var chisel_ammo = 0
var chisel_level = 0


#enemy related
var enemy_close = []


@onready var sprite = $Sprite2D

#GUI
@onready var expBar = get_node("GUILayer/GUI/ExperienceBar")
@onready var lblLevel = get_node("GUILayer/GUI/ExperienceBar/lbl_level")
@onready var levelPanel = get_node("GUILayer/GUI/LevelUp")
@onready var upgradeOptions = get_node("GUILayer/GUI/LevelUp/upgradeOptions")
@onready var itemOptions = preload("res://Utility/item_option.tscn")
@onready var sndLevelUp = get_node("GUILayer/GUI/LevelUp/snd_levelUp")
@onready var healthBar = get_node("GUILayer/GUI/HealthBar")
@onready var lblTimer = get_node("GUILayer/GUI/lblTimer")
@onready var collectedWeapons = get_node("GUILayer/GUI/CollectedWeapons")
@onready var collectedUpgrades = get_node("GUILayer/GUI/CollectedUpgrades")
@onready var itemContainer = preload("res://Utility/item_container.tscn")

@onready var deathPanel = get_node("GUILayer/GUI/DeathPanel")
@onready var lblResult = get_node("GUILayer/GUI/DeathPanel/lbl_Result")
@onready var sndVictory = get_node("GUILayer/GUI/DeathPanel/snd_victory")
@onready var sndLose = get_node("GUILayer/GUI/DeathPanel/snd_lose")

func  _ready():
	upgrade_character("ghostdrill1")
	attack()
	set_expbar(experience, calculate_experiencecap())
	_on_hurt_box_hurt(0, 0, 0)
	$PlayerAnimation.play("Idle")


func _physics_process(delta):
	movement()

 
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov .x > 0:
		sprite.flip_h = false
		last_movement = mov
		$PlayerAnimation.play("walking")
	elif mov.x < 0:
		last_movement = mov
		sprite.flip_h = true
		$PlayerAnimation.play("walking")
	else:
		$PlayerAnimation.play("Idle")	
	
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()

func attack():
	if ghostdrill_level > 0:
		ghostDrillTimer.wait_time = ghostdrill_attackspeed * (1 - spell_cooldown)
		if ghostDrillTimer.is_stopped():
			ghostDrillTimer.start()
	
	if pickboomerang_level > 0:
		pickBoomerangTimer.wait_time = pickboomerang_attackspeed * (1 - spell_cooldown)
		if pickBoomerangTimer.is_stopped():
			pickBoomerangTimer.start()
			
	if chisel_level > 0:
		spawn_chisel()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= clamp (damage - armor, 1.0, 999.0)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <= 0:
		death()


func _on_ghost_drill_timer_timeout():
	ghostdrill_ammo += ghostdrill_baseammo + additional_attacks
	ghostDrillAttackTimer.start()


func _on_ghost_drill_attack_timer_timeout():
	if ghostdrill_ammo > 0:
		var ghostdrill_attack = ghostDrill.instantiate()
		ghostdrill_attack.position = position
		ghostdrill_attack.target = get_random_target()
		ghostdrill_attack.level = ghostdrill_level
		add_child(ghostdrill_attack)
		ghostdrill_ammo -= 1
		if ghostdrill_ammo > 0:
			ghostDrillAttackTimer.start()
		else:
			ghostDrillAttackTimer.stop()

func _on_pick_boomerang_timer_timeout():
	pickboomerang_ammo += pickboomerang_baseammo + additional_attacks
	pickBoomerangAttackTimer.start()


func _on_pick_boomerang_attack_timer_timeout():
	if pickboomerang_ammo > 0:
		var pickboomerang_attack = pickBoomerang.instantiate()
		pickboomerang_attack.position = position
		pickboomerang_attack.last_movement = last_movement
		pickboomerang_attack.level = pickboomerang_level
		add_child(pickboomerang_attack)
		pickboomerang_ammo -= 1
		if pickboomerang_ammo > 0:
			pickBoomerangAttackTimer.start()
		else:
			pickBoomerangAttackTimer.stop()


func spawn_chisel():
	var get_chisel_total = chiselBase.get_child_count()
	var calc_spawns = (chisel_ammo + additional_attacks) - get_chisel_total
	while calc_spawns > 0:
		var chisel_spawn = magneticChisel.instantiate()
		chisel_spawn.global_position = global_position
		chiselBase.add_child(chisel_spawn)
		calc_spawns -= 1
	#update chisel
	var get_chisels = chiselBase.get_children()
	for i in get_chisels:
		if i.has_method("update_chisel"):
			i.update_chisel()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)

func calculate_experience(gem_exp):
	var exp_requiered = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_requiered: #level up!!!
		collected_experience -= exp_requiered - experience
		experience_level += 1
		experience = 0
		exp_requiered = calculate_experiencecap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
	
	set_expbar(experience, exp_requiered)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level * 5
	elif experience_level < 40:
		exp_cap + 95 * (experience_level - 19) * 8
	else:
		exp_cap = 255 + (experience_level - 39) * 12
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func levelup():
	sndLevelUp.play()
	lblLevel.text = str("level: ", experience_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel, "position", Vector2(640, 100), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"ghostdrill1":
			ghostdrill_level = 1
			ghostdrill_baseammo += 1
		"ghostdrill2":
			ghostdrill_level = 2
			ghostdrill_baseammo += 1
		"ghostdrill3":
			ghostdrill_level = 3
		"ghostdrill4":
			ghostdrill_level = 4
			ghostdrill_baseammo += 2
		"pickboomerang1":
			pickboomerang_level = 1
			pickboomerang_baseammo += 1
		"pickboomerang2":
			pickboomerang_level = 2
			pickboomerang_baseammo += 1
		"pickboomerang3":
			pickboomerang_level = 3
			pickboomerang_attackspeed -= 0.5
		"pickboomerang4":
			pickboomerang_level = 4
			pickboomerang_baseammo += 1
		"magneticchisel1":
			chisel_level = 1
			chisel_ammo = 1
		"magneticchisel2":
			chisel_level = 2
		"magneticchisel3":
			chisel_level = 3
		"magneticchisel4":
			chisel_level = 4
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 20.0
		"upgradechip1","upgradechip2","upgradechip3","upgradechip4":
			spell_size += 0.10
		"hyperstopwatch1","hyperstopwatch2","hyperstopwatch3","hyperstopwatch4":
			spell_cooldown += 0.05
		"mechanicarm1","mechanicarm2":
			additional_attacks += 1
		"food":
			hp += 20
			hp = clamp(hp,0,maxhp)
			healthBar.max_value = maxhp
			healthBar.value = hp
	adjust_gui_collection(upgrade)
	attack()
	
	
	
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.position = Vector2(2000, 50)
	get_tree().paused = false
	calculate_experience(0)

func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #ENCONTRA YA COLECTADAS
			pass
		elif i in upgrade_options: #si la upgrade ya es una opcion
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #no elegi comida
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #checkea prerequisitos
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null

func change_time(argtime = 0):
	time = argtime
	var get_m = int(time / 60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0, get_m)
	if get_s < 10:
		get_s = str(0, get_s)
	lblTimer.text = str(get_m, ":", get_s)
	if time >= 300:
		
		get_tree().change_scene_to_file("res://end/gameWin.tscn")
	

func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDb.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = itemContainer.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
				"item":
					healthBar.max_value = maxhp
					healthBar.value = hp

func death():
	
	#deathPanel.visible = true
	#get_tree().paused = true
	#var tween = deathPanel.create_tween()
	#tween.tween_property(deathPanel, "position", Vector2(220, 50), 3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.play()
	if time >= 300:
		#lblResult.text = "Victoria!"
		sndVictory.play()
	else:
		#lblResult.text = "Perdiste..."
		get_tree().change_scene_to_file("res://end/gameOver.tscn")
		sndLose.play()

