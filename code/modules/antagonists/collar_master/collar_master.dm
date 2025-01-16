/datum/antagonist/collar_master
    name = "Collar Master"
    roundend_category = "collar masters"
    antagpanel_category = "Collar Master"
    var/obj/item/clothing/neck/roguetown/cursed_collar/my_collar
    var/static/list/animal_sounds = list(
        "lets out a whimper!",
        "whines softly.",
        "makes a pitiful noise.",
        "whimpers.",
        "lets out a submissive bark.",
        "mewls pathetically."
    )

/datum/antagonist/collar_master/on_gain()
    . = ..()
    if(my_collar)
        RegisterSignal(my_collar.victim, COMSIG_MOB_CLICKON, PROC_REF(check_pet_attack))
    owner.current.verbs += list(
        /mob/proc/collar_scry,
        /mob/proc/collar_listen,
        /mob/proc/collar_shock,
        /mob/proc/collar_message,
        /mob/proc/collar_force_surrender,
        /mob/proc/collar_force_naked,
        /mob/proc/collar_permit_clothing,
        /mob/proc/collar_toggle_silence,
        /mob/proc/collar_force_emote,
    )

/datum/antagonist/collar_master/proc/check_pet_attack(mob/living/carbon/human/pet, atom/target)
    SIGNAL_HANDLER
    if(!my_collar || !my_collar.victim || pet != my_collar.victim)
        return NONE

    if(target == owner.current && pet.a_intent == INTENT_HARM)
        pet.electrocute_act(25, my_collar, flags = SHOCK_NOGLOVES)
        pet.Paralyze(600)
        to_chat(pet, span_warning("The collar sends painful shocks through your body as you try to attack your master!"))
        playsound(pet, 'sound/blank.ogg', 50, TRUE)
        return COMPONENT_CANCEL_ATTACK

/datum/antagonist/collar_master/on_removal()
    owner.current.verbs -= list(
        /mob/proc/collar_scry,
        /mob/proc/collar_listen,
        /mob/proc/collar_shock,
        /mob/proc/collar_message,
		/mob/proc/collar_force_surrender,
        /mob/proc/collar_force_naked,
        /mob/proc/collar_permit_clothing,
        /mob/proc/collar_toggle_silence,
        /mob/proc/collar_force_emote,
    )
    . = ..()

/mob/proc/collar_control_menu()
    set name = "Collar Control"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

/mob/proc/select_pet(var/action)
    var/list/pets = list()
    for(var/datum/antagonist/collar_master/CM in mind.antag_datums)
        if(CM.my_collar && CM.my_collar.victim)
            pets[CM.my_collar.victim.name] = CM.my_collar

    if(!length(pets))
        return null

    var/choice = input(src, "Choose a pet:", "Pet Selection") as null|anything in pets
    if(!choice)
        return null
    return pets[choice]

/mob/proc/collar_scry()
    set name = "Scry on Pet"
    set category = "Collar"

    var/obj/item/clothing/neck/roguetown/cursed_collar/collar = select_pet("scry")
    if(!collar)
        return

    var/mob/dead/observer/screye/S = scry_ghost()
    if(S)
        S.ManualFollow(collar.victim)
        addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)

/mob/proc/collar_listen()
    set name = "Listen to Pet"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    CM.my_collar.listening = !CM.my_collar.listening
    to_chat(src, span_notice("You [CM.my_collar.listening ? "attune your mind to" : "cease listening through"] the collar."))

/mob/proc/collar_shock()
    set name = "Shock Pet"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    to_chat(src, span_warning("You cruelly shock your disobedient pet into submission."))
    to_chat(CM.my_collar.victim, span_danger("The collar sends painful shocks through your body!"))
    CM.my_collar.victim.electrocute_act(15, CM.my_collar, flags = SHOCK_NOGLOVES)
    CM.my_collar.victim.Knockdown(20)
    playsound(CM.my_collar.victim, 'sound/blank.ogg', 50, TRUE)

/mob/proc/collar_message()
    set name = "Send Message"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    var/message = input("What message do you want to send to your pet?", "Collar Message") as text|null
    if(!message)
        return

    to_chat(CM.my_collar.victim, span_warning("Your collar tingles as you hear your master's voice: [message]"))
    to_chat(src, span_notice("You send a message to your pet: \"[message]\""))
    playsound(CM.my_collar.victim, 'sound/blank.ogg', 50, TRUE)

/mob/proc/collar_force_surrender()
    set name = "Force Surrender"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    to_chat(src, span_warning("You force your pet to their knees, reminding them of their place."))
    to_chat(CM.my_collar.victim, span_userdanger("The collar forces you to your knees!"))
    CM.my_collar.victim.Paralyze(600)
    playsound(CM.my_collar.victim, 'sound/blank.ogg', 50, TRUE)

/mob/proc/collar_force_naked()
    set name = "Force Strip"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    to_chat(src, span_warning("You command your pet to strip, leaving them vulnerable and exposed."))
    to_chat(CM.my_collar.victim, span_userdanger("The collar's magic forces you to remove all your clothing!"))
    var/mob/living/victim = CM.my_collar.victim
    if(ishuman(victim))
        var/mob/living/carbon/human/H = victim
        for(var/obj/item/I in H.get_equipped_items())
            if(I == CM.my_collar) // Don't remove the collar itself
                continue
            if(H.dropItemToGround(I, TRUE))
                H.visible_message(span_warning("[H]'s [I.name] falls to the ground!"))

    ADD_TRAIT(victim, TRAIT_NUDIST, CURSED_ITEM_TRAIT)
    playsound(victim, 'sound/blank.ogg', 50, TRUE)

/mob/proc/collar_permit_clothing()
    set name = "Permit Clothing"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    var/mob/living/victim = CM.my_collar.victim
    to_chat(victim, span_notice("The collar's magic allows you to wear clothing again."))
    REMOVE_TRAIT(victim, TRAIT_NUDIST, CURSED_ITEM_TRAIT)
    playsound(victim, 'sound/blank.ogg', 50, TRUE)

/mob/proc/collar_toggle_silence()
    set name = "Toggle Pet Speech"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    CM.my_collar.silenced = !CM.my_collar.silenced
    if(CM.my_collar.silenced)
        to_chat(src, span_warning("You silence your pet, reducing them to animal noises only."))
    else
        to_chat(src, span_warning("You allow your pet to speak again, for now."))
    to_chat(CM.my_collar.victim, span_userdanger("The collar [CM.my_collar.silenced ? "forces you to speak like an animal!" : "allows you to speak normally again."]"))
    playsound(CM.my_collar.victim, 'sound/blank.ogg', 50, TRUE)

    if(CM.my_collar.silenced)
        RegisterSignal(CM.my_collar.victim, COMSIG_MOB_SAY, PROC_REF(handle_silenced_speech))
    else
        UnregisterSignal(CM.my_collar.victim, COMSIG_MOB_SAY)

/mob/proc/handle_silenced_speech(datum/source, list/speech_args)
    SIGNAL_HANDLER

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.silenced)
        return

    speech_args[SPEECH_MESSAGE] = ""
    emote("me", EMOTE_VISIBLE, pick(CM.animal_sounds))
    return TRUE // Just return TRUE to block speech

/mob/proc/collar_force_emote()
    set name = "Force Emote"
    set category = "Collar"

    var/datum/antagonist/collar_master/CM = mind?.has_antag_datum(/datum/antagonist/collar_master)
    if(!CM || !CM.my_collar || !CM.my_collar.victim)
        return

    var/emote = input(src, "What emote should your pet perform?", "Force Emote") as text|null
    if(!emote)
        return

    to_chat(src, span_warning("You force your pet to [emote]."))
    CM.my_collar.victim.say(emote, forced = TRUE)
    playsound(CM.my_collar.victim, 'sound/blank.ogg', 50, TRUE)
