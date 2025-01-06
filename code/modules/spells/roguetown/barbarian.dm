// Barbarian
/obj/effect/proc_holder/spell/self/barbarian_rage
	name = "Rage"
	desc = "Fly into a rage increasing your physical stats."
	range = 1
	overlay_state = "bcry"
	releasedrain = 30
	cast_without_targets = TRUE
	charge_max = 60 SECONDS
	movement_interrupt = FALSE
	sound = 'sound/vo/male/warrior/rage (3).ogg' //change for gender later or do warcry which I don't know how to do rn.
	associated_skill = /datum/skill/magic/druidic
	invocation = "RAAAAAAAAAAAAAA!!"
	miracle = FALSE
	invocation_type = "shout" //can be none, whisper, emote and shout
	requires_arms = FALSE

/obj/effect/proc_holder/spell/self/barbarian_rage/cast(list/targets, mob/user)
	. = ..()
	var/mob/living/target = user
	if(!target.has_status_effect(/datum/status_effect/debuff/barbfalter))
		user.visible_message("<span class='info'>[user]'s muscles tense up beyond imagination.</span>", "<span class='notice'>My muscles tense up beyond imagination.</span>")
		user.add_stress(/datum/stressevent/barbarian_rage)
		target.apply_status_effect(/datum/status_effect/buff/barbarian_rage)
		return TRUE
	return FALSE

/datum/status_effect/buff/barbarian_rage
	id = "barbarian rage"
	alert_type = /atom/movable/screen/alert/status_effect/buff/barbarian_rage
	effectedstats = list("endurance" = 4, "strength" = 2, "intelligence" = -2, "perception" = -4)
	duration = 45 SECONDS


/atom/movable/screen/alert/status_effect/buff/barbarian_rage
	name = "Rage"
	desc = "Rage fills my heart and my muscles."
	icon_state = "buff"

/datum/status_effect/buff/barbarian_rage/nextmove_modifier()
	return 0.75

/datum/status_effect/buff/barbarian_rage/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		ADD_TRAIT(C, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(C, TRAIT_NOROGSTAM, TRAIT_GENERIC)

/datum/status_effect/buff/barbarian_rage/on_remove()
	var/mob/living/carbon/M = owner
	var/mob/living/target = owner
	target.adjustOxyLoss(50)
	target.visible_message("<span class='info'>[owner]'s rage subsides.</span>", "<span class='notice'>My rage subsides.</span>")
	target.apply_status_effect(/datum/status_effect/debuff/barbfalter)
	REMOVE_TRAIT(target, TRAIT_NOPAIN, TRAIT_GENERIC)
	REMOVE_TRAIT(target, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	M.updatehealth()
	. = ..()

/datum/stressevent/barbarian_rage
	timer = 10 MINUTES
	stressadd = 3 //reduced from 8 since we use less stress caps in stonehedge.
	max_stacks = 8 //don't rage spam or you WILL have a heart attack

/datum/status_effect/debuff/barbfalter
	id = "barbfalter"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/barbfalter
	effectedstats = list("strength" = -2, "speed" = -2, "endurance" = -2, "constitution" = -2, "perception" = -2)

/datum/status_effect/debuff/barbfalter/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		ADD_TRAIT(C, TRAIT_NORUN, TRAIT_GENERIC)

/datum/status_effect/debuff/barbfalter/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		REMOVE_TRAIT(C, TRAIT_NORUN, TRAIT_GENERIC)


/atom/movable/screen/alert/status_effect/debuff/barbfalter
	name = "Faltering"
	desc = "I've pushed myself to my limit. I must rest to restore my strenght."
	icon_state = "muscles"

//claws for the ravager
/obj/effect/proc_holder/spell/self/rav_claws
	name = "Ravager Claws"
	desc = "!"
	overlay_state = "claws"
	antimagic_allowed = TRUE
	charge_max = 20 //2 seconds
	var/extended = FALSE

/obj/effect/proc_holder/spell/self/rav_claws/cast(mob/user = usr)
	..()
	var/obj/item/rogueweapon/rav_claw/left/l
	var/obj/item/rogueweapon/rav_claw/right/r

	l = user.get_active_held_item()
	r = user.get_inactive_held_item()
	if(extended)
		if(istype(user.get_active_held_item(), /obj/item/rogueweapon/rav_claw))
			user.dropItemToGround(l, TRUE)
			user.dropItemToGround(r, TRUE)
			user.visible_message("<span class='info'>[user]'s claws retract.</span>", "<span class='notice'>Claws retract back into my hands.</span>")
			extended = FALSE
	else
		l = new(user,1)
		r = new(user,2)
		ADD_TRAIT(l, TRAIT_NODROP, TRAIT_GENERIC)
		ADD_TRAIT(r, TRAIT_NODROP, TRAIT_GENERIC)
		ADD_TRAIT(l, TRAIT_NOEMBED, TRAIT_GENERIC)
		ADD_TRAIT(r, TRAIT_NOEMBED, TRAIT_GENERIC)
		user.put_in_hands(l, TRUE, FALSE, TRUE)
		user.put_in_hands(r, TRUE, FALSE, TRUE)
		user.visible_message("<span class='info'>[user]'s claws extend.</span>", "<span class='notice'>Claws extend from my hands.</span>")
		extended = TRUE

/obj/item/rogueweapon/rav_claw //this is essentially a hunting knife that uses unarmed. Not that op
	name = "Claw"
	desc = ""
	item_state = null
	lefthand_file = null
	righthand_file = null
	icon = 'icons/roguetown/weapons/32.dmi'
	max_blade_int = 900
	max_integrity = 900
	force = 12
	block_chance = 0
	wdefense = 3
	armor_penetration = 8
	associated_skill = /datum/skill/combat/unarmed
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_SMALL
	can_parry = TRUE
	sharpness = IS_SHARP
	parrysound = "bladedmedium"
	swingsound = BLADEWOOSH_MED
	possible_item_intents = list(/datum/intent/simple/werewolf)
	parrysound = list('sound/combat/parry/parrygen.ogg')
	embedding = list("embedded_pain_multiplier" = 0, "embed_chance" = 0, "embedded_fall_chance" = 0)
	item_flags = DROPDEL

/obj/item/rogueweapon/rav_claw/right
	icon_state = "claw_r"

/obj/item/rogueweapon/rav_claw/left
	icon_state = "claw_l"
