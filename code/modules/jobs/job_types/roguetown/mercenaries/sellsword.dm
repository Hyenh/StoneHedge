//mercs that are unaffiliated with guilds would be sellswords i suppose.
/datum/job/roguetown/mercenary/sellsword
	title = "Sellsword"
	flag = SELLSWORD
	department_flag = MERCENARIES
	tutorial = "You are a common sellsword, regarded as scum by many. You travelled the isle working as a bodyguard, mercenary or a cutthroat. You're loyal to your own well being and the sounds mammons make in your pouch."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword
	display_order = JDO_SELLSWORD
	selection_color = JCOLOR_MERCENARY
	faction = "Station"
	total_positions = 10
	spawn_positions = 10
	min_pq = 8
	max_pq = null
	advclass_cat_rolls = list(CTAG_SELLSWORD = 20)
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE

/datum/outfit/job/roguetown/mercenary/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/mace

/datum/job/roguetown/mercenary/sellsword/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/longsword
	name = "Swordsman"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword/longsword
	tutorial = "You are well versed in the ways of the longsword.\
	You have a steel sword and a leather helmet."
	category_tags = list(CTAG_SELLSWORD)

/datum/advclass/rapier
	name = "Fencer"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword/rapier
	tutorial = "You are well versed in the ways of the rapier.\
	You have a rapier and a tricorn."
	category_tags = list(CTAG_SELLSWORD)

/datum/advclass/cutlass
	name = "Cutthroat"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDSPLUS
	outfit = /datum/outfit/job/roguetown/mercenary/sellsword/cutlass
	tutorial = "You are well versed in the ways of the cutlass.\
	You have a cutlass and a maritime outfit."
	category_tags = list(CTAG_SELLSWORD)

/datum/outfit/job/roguetown/mercenary/sellsword/longsword/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	beltr = /obj/item/rogueweapon/sword
	if(prob(40))
		beltr = /obj/item/rogueweapon/sword/long
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/mace

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)

	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 3, TRUE) // builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 3, TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/tracking, 1, TRUE) //Hearthstone change.
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/mercenary/sellsword/rapier/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/tricorn
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	beltr = /obj/item/rogueweapon/sword/rapier
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/mace

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)

	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 3, TRUE) // builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 3, TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/tracking, 1, TRUE) //Hearthstone change.
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/outfit/job/roguetown/mercenary/sellsword/cutlass/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/bandana
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	beltr = /obj/item/rogueweapon/sword/cutlass
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/mace

	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger)

	if(H.mind)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/maces, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/combat/knives, 4, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/crafting, 3 , TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/masonry, 3, TRUE) // builders
		H.mind.adjust_skillrank_up_to(/datum/skill/craft/carpentry, 3, TRUE) //builders
		H.mind.adjust_skillrank_up_to(/datum/skill/misc/tracking, 1, TRUE) //Hearthstone change.
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("perception", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
