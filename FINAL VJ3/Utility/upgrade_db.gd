extends Node


const ICON_PATH = "res://Textures/Upgrades/"
const WEAPON_PATH = "res://Textures/Weapons/"
const UPGRADES = {
	"ghostdrill1":{
		"icon": WEAPON_PATH + "GhostDrill.png",
		"displayname": "Taladro Fantasma",
		"details": "Un taladro fantasma que se dispara hacia un enemigo al azar",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"ghostdrill2":{
		"icon": WEAPON_PATH + "GhostDrill.png",
		"displayname": "Taladro Fantasma",
		"details": "Dispara un Taladro Fantasma adicional",
		"level": "Level: 2",
		"prerequisite": ["ghostdrill1"],
		"type": "weapon"
	},
	"ghostdrill3": {
		"icon": WEAPON_PATH + "GhostDrill.png",
		"displayname": "Ice Spear",
		"details": "Los Taladros Fantasmas ahora atraviesan un enemigo adicional y hacen + 3 de daño",
		"level": "Level: 3",
		"prerequisite": ["ghostdrill2"],
		"type": "weapon"
	},
	"ghostdrill4": {
		"icon": WEAPON_PATH + "GhostDrill.png",
		"displayname": "Ice Spear",
		"details": "Se disparan 2 Taladros Fantasmas adicionales",
		"level": "Level: 4",
		"prerequisite": ["ghostdrill3"],
		"type": "weapon"
	},
	"magneticchisel1": {
		"icon": WEAPON_PATH + "MagneticChiselAttack.png",
		"displayname": "Cincel Magnetico",
		"details": "Un Cincel Magnetico te seguira y atacara enemigos en una linea recta",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"magneticchisel2": {
		"icon": WEAPON_PATH + "MagneticChiselAttack.png",
		"displayname": "Cincel Magnetico",
		"details": "El Cincel Magnetico atacará un enemigo adicional por ataque",
		"level": "Level: 2",
		"prerequisite": ["magneticchisel1"],
		"type": "weapon"
	},
	"magneticchisel3": {
		"icon": WEAPON_PATH + "MagneticChiselAttack.png",
		"displayname": "Cincel Magnetico",
		"details": "El Cincel Magnetico atacará otro enemigo adicional por ataque",
		"level": "Level: 3",
		"prerequisite": ["magneticchisel2"],
		"type": "weapon"
	},
	"magneticchisel4": {
		"icon": WEAPON_PATH + "MagneticChiselAttack.png",
		"displayname": "Cincel Magnetico",
		"details": "El Cincel Magnetico ahora hace + 5 de daño por ataque y el retroceso aumenta un 20%",
		"level": "Level: 4",
		"prerequisite": ["magneticchisel3"],
		"type": "weapon"
	},
	"pickboomerang1": {
		"icon": WEAPON_PATH + "PickBoomerang.png",
		"displayname": "pickboomerang",
		"details": "Un Pico Boomerang se dispara en una direccion al azar",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"pickboomerang2": {
		"icon": WEAPON_PATH + "PickBoomerang.png",
		"displayname": "pickboomerang",
		"details": "Un Pico Boomerang adicional es disparado",
		"level": "Level: 2",
		"prerequisite": ["pickboomerang1"],
		"type": "weapon"
	},
	"pickboomerang3": {
		"icon": WEAPON_PATH + "PickBoomerang.png",
		"displayname": "pickboomerang",
		"details": "Se reduce por 0.5% el enfriamiento del Pico Boomerang",
		"level": "Level: 3",
		"prerequisite": ["pickboomerang2"],
		"type": "weapon"
	},
	"pickboomerang4": {
		"icon": WEAPON_PATH + "PickBoomerang.png",
		"displayname": "pickboomerang",
		"details": "Un Pico Boomerang adicional es disparado y el retroceso aumenta un 25%",
		"level": "Level: 4",
		"prerequisite": ["pickboomerang3"],
		"type": "weapon"
	},
	"speed1": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Botas de Trotamundo",
		"details": "La velocidad de movimiento base aumenta un 50%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Botas de Trotamundo",
		"details": "La velocidad de movimiento base aumenta un 50% adicional",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Botas de Trotamundo",
		"details": "La velocidad de movimiento base aumenta un 50% adicional",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boots.png",
		"displayname": "Botas de Trotamundo",
		"details": "La velocidad de movimiento base aumenta un 50% adicional",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"armor1": {
		"icon": ICON_PATH + "Helmet.png",
		"displayname": "Casco de Minero",
		"details": "Reduce el Daño en 1",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "Helmet.png",
		"displayname": "Casco de Minero",
		"details": "Reduce el Daño en 1 punto adicional",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "Helmet.png",
		"displayname": "Casco de Minero",
		"details": "Reduce el Daño en 1 punto adicional",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "Helmet.png",
		"displayname": "Casco de Minero",
		"details": "Reduce el Daño en 1 punto adicional",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"upgradechip1": {
		"icon": ICON_PATH + "UpgradeChip.png",
		"displayname": "Chip de Mejora",
		"details": "Incrementa un 10% el tamaño base de los ataques",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"upgradechip2": {
		"icon": ICON_PATH + "UpgradeChip.png",
		"displayname": "Chip de Mejora",
		"details": "Incrementa un 10% el tamaño base de los ataques",
		"level": "Level: 2",
		"prerequisite": ["upgradechip1"],
		"type": "upgrade"
	},
	"upgradechip3": {
		"icon": ICON_PATH + "UpgradeChip.png",
		"displayname": "Chip de Mejora",
		"details": "Incrementa un 10% el tamaño base de los ataques",
		"level": "Level: 3",
		"prerequisite": ["upgradechip2"],
		"type": "upgrade"
	},
	"upgradechip4": {
		"icon": ICON_PATH + "UpgradeChip.png",
		"displayname": "Chip de Mejora",
		"details": "Incrementa un 10% el tamaño base de los ataques",
		"level": "Level: 4",
		"prerequisite": ["upgradechip3"],
		"type": "upgrade"
	},
	"hyperstopwatch1": {
		"icon": ICON_PATH + "HyperStopwatch.png",
		"displayname": "Hiper Cronometro",
		"details": "Reduce el enfriamiento base de los ataques un 5%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"hyperstopwatch2": {
		"icon": ICON_PATH + "HyperStopwatch.png",
		"displayname": "Hiper Cronometro",
		"details": "Reduce el enfriamiento base de los ataques un 5%",
		"level": "Level: 2",
		"prerequisite": ["hyperstopwatch1"],
		"type": "upgrade"
	},
	"hyperstopwatch3": {
		"icon": ICON_PATH + "HyperStopwatch.png",
		"displayname": "Hiper Cronometro",
		"details": "Reduce el enfriamiento base de los ataques un 5%",
		"level": "Level: 3",
		"prerequisite": ["hyperstopwatch2"],
		"type": "upgrade"
	},
	"hyperstopwatch4": {
		"icon": ICON_PATH + "HyperStopwatch.png",
		"displayname": "Hiper Cronometro",
		"details": "Reduce el enfriamiento base de los ataques un 5%",
		"level": "Level: 4",
		"prerequisite": ["hyperstopwatch3"],
		"type": "upgrade"
	},
	"mechanicarm1": {
		"icon": ICON_PATH + "MechanicArm.png",
		"displayname": "Brazo Mecanico",
		"details": "Tus ataques ahora disparan 1 ataque adicional",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"mechanicarm2": {
		"icon": ICON_PATH + "MechanicArm.png",
		"displayname": "Brazo Mecanico",
		"details": "Tus ataques ahora disparan 1 ataque adicional",
		"level": "Level: 2",
		"prerequisite": ["mechanicarm1"],
		"type": "upgrade"
	},
	"food":{
		"icon": ICON_PATH + "food.png",
		"displayname": "Comida",
		"details": "Cura 20 puntos de Vida",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
