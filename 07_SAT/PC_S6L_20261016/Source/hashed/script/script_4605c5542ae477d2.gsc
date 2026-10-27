// script_4605c5542ae477d2  (hash_4605c5542ae477d2.gscc) (size: 55977 Bytes / 0xdaa9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97a0de65 (2543902309)
// size ...... 55977 (0xdaa9)
// includes .. 25  (offset: 0xc58d)
// strings ... 159 (offset: 0xc655)
// dev strs .. 195 (offset: 0xd0a5)
// exports ... 121 (offset: 0x8831)
// cseg ...... 0x1001 + 0x7830 (0x8831)
// imports ... 309 (offset: 0x9b19)
// animtree1 . 0   (offset: 0xdaa9)
// animtree2 . 0   (offset: 0xdaa9)
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_publicevent_jailbreak;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;

#namespace namespace_341ed135e9592d8;

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x5
// Checksum 0x6169695e, Offset: 0x101f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_blood_moon", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0xedd58239, Offset: 0x1048
// Size: 0x6c
function pre_main()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_blood_moon" };
    br_map_quest::register( quest );
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0x922d0cf8, Offset: 0x10bc
// Size: 0x21
function on_init()
{
    quest_set_dvars();
    quest_set_variables();
    quest_set_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0x92515059, Offset: 0x10e5
// Size: 0x68
function on_precache()
{
    utility::add_fx( "blood_moon_cursed_player", "vfx_sat_levels_mp_saw_manticore_ee_bmoon_torso_trail" );
    utility::add_fx( "blood_moon_chanting_note_spawn", "vfx_t10_levels_zm_topaz_zoe_intr" );
    utility::add_fx( "blood_moon_chanting_note_amb", "vfx_t10_levels_zm_topaz_zoe_rep_amb" );
    utility::add_fx( "blood_moon_jumpscare", "vfx_t10_levels_zm_topaz_jump_scare_camera" );
    utility::add_fx( "blood_moon_awakening_start", "vfx_sat_levels_mp_saw_manticore_ee_bmoon_start_screen_camera" );
    utility::add_fx( "blood_moon_offering_beam", "vfx_sat_levels_mp_saw_manticore_beam" );
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0xb0245545, Offset: 0x1155
// Size: 0x1e
function on_start()
{
    gathering_init();
    chanting_init();
    offering_init();
    clue_init();
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0xa13d0c9f, Offset: 0x117b
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0xfcb54180, Offset: 0x1185
// Size: 0x2c9
function on_infil()
{
    foreach ( loc in self.chanting_locs )
    {
        loc.scriptable setscriptablepartstate( "quest_wz_blood_moon_chanting_player", "usable" );
        loc.var_49cbf3bb8e5a92e5 setscriptablepartstate( "quest_wz_blood_moon_chanting_player", "usable" );
        
        if ( isdefined( loc.grenade_locs ) )
        {
            loc.grenade_locs = arrayrandomize( loc.grenade_locs );
            grenade_bundle = getscriptbundle( "itemspawnentry:wz_sat_item_tactical_gas" );
            
            for ( i = 0; i < 2 ; i++ )
            {
                grenade_loc = loc.grenade_locs[ i ];
                spawn_options = common_item::function_bc5ff2958b71a708( grenade_loc.origin, grenade_loc.angles );
                common_item::function_61c2c0251e742ffd( grenade_bundle, 1, spawn_options );
            }
        }
    }
    
    foreach ( loc in self.offering_placement_locs )
    {
        loc.scriptable setscriptablepartstate( "quest_wz_blood_moon_offering_placement", "usable" );
    }
    
    self.offering_trigger thread offering_circle_trigger_wait();
    
    if ( isdefined( self.clue_projector ) )
    {
        self.clue_projector setscriptablepartstate( "quest_wz_blood_moon_clue_projector", "usable" );
    }
    
    if ( isdefined( self.gathering_stone.hard_hat ) )
    {
        self.gathering_stone.hard_hat setscriptablepartstate( "quest_saw_blood_moon_hard_hat", "covering_stone" );
    }
    
    if ( isdefined( self.gathering_vial.var_d302487567ef6a70.collision ) )
    {
        self.gathering_vial.var_d302487567ef6a70 setscriptablepartstate( "quest_saw_blood_moon_centrifuge", "open" );
        self.gathering_vial.var_d302487567ef6a70.collision setscriptablepartstate( "quest_saw_blood_moon_centrifuge_collision", "can_damage" );
    }
    
    if ( isdefined( self.clue_folder ) )
    {
        self.clue_folder setscriptablepartstate( "folder", "visible_outline" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x41c4e0a5, Offset: 0x1456
// Size: 0xe0
function private quest_set_dvars()
{
    br_map_quest::add_setting( "offering_timer", 180 );
    br_map_quest::add_setting( "souls_required", 10 );
    br_map_quest::add_setting( "souls_per_cursed_kill", 2 );
    br_map_quest::add_setting( "souls_per_other_kill", 1 );
    br_map_quest::add_setting( "offering_num_progress_states", 5 );
    br_map_quest::add_setting( "cursed_weapon_pickup_timer", 30 );
    br_map_quest::add_setting( "offering_circle_radius", 2000 );
    br_map_quest::add_setting( "offering_circle_reveal_radius", 250 );
    br_map_quest::add_setting( "awakening_timer", 30 );
    br_map_quest::add_setting( "chanting_jump_scare", 1 );
    br_map_quest::add_setting( "offering_use_beams", 1 );
    br_map_quest::add_setting( "offering_kills_from_cursed_only", 0 );
    br_map_quest::add_setting( "offering_kills_from_squad_only", 0 );
    br_map_quest::add_setting( "offering_give_cursed_armor_regen", 0 );
    br_map_quest::add_setting( "offering_use_sigils", 1 );
    br_map_quest::add_setting( "awakening_jailbreak", 1 );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x7a51ccf1, Offset: 0x153e
// Size: 0x914
function private quest_set_variables()
{
    self.bones_locs = [];
    self.stone_locs = [];
    self.vial_locs = [];
    self.gathering_locs = utility::getstructarray( "blood_moon_gathering_item" );
    
    foreach ( loc in self.gathering_locs )
    {
        if ( issubstr( loc.script_noteworthy, "bones" ) )
        {
            self.bones_locs[ self.bones_locs.size ] = loc;
            continue;
        }
        
        if ( issubstr( loc.script_noteworthy, "stone" ) )
        {
            loc.target_loc = utility::getstruct( loc.target );
            self.stone_locs[ self.stone_locs.size ] = loc;
            continue;
        }
        
        if ( issubstr( loc.script_noteworthy, "vial" ) )
        {
            self.vial_locs[ self.vial_locs.size ] = loc;
        }
    }
    
    self.centrifuges = getentitylessscriptablearray( "scriptable_" + "quest_saw_blood_moon_centrifuge", #classname );
    
    foreach ( var_d302487567ef6a70 in self.centrifuges )
    {
        foreach ( loc in self.vial_locs )
        {
            if ( loc.script_noteworthy == var_d302487567ef6a70.script_noteworthy )
            {
                var_d302487567ef6a70.vial_loc = loc;
                loc.var_d302487567ef6a70 = var_d302487567ef6a70;
            }
        }
    }
    
    self.hard_hats = getentitylessscriptablearray( "scriptable_" + "quest_saw_blood_moon_hard_hat", #classname );
    
    foreach ( hard_hat in self.hard_hats )
    {
        foreach ( loc in self.stone_locs )
        {
            if ( loc.script_noteworthy == hard_hat.script_noteworthy )
            {
                hard_hat.stone_loc = loc;
                loc.hard_hat = hard_hat;
            }
        }
    }
    
    self.chanting_locs = utility::getstructarray( "blood_moon_chanting_player" );
    self.var_9bcf156b09ff3397 = utility::getstructarray( "blood_moon_chanting_grenade" );
    self.chanting_note_locs = utility::getstructarray( "blood_moon_chanting_note" );
    
    foreach ( loc in self.chanting_locs )
    {
        loc.mirror_loc = utility::getstruct( loc.target );
        
        foreach ( grenade_loc in self.var_9bcf156b09ff3397 )
        {
            if ( grenade_loc.script_noteworthy == loc.script_noteworthy )
            {
                if ( !isdefined( loc.grenade_locs ) )
                {
                    loc.grenade_locs = [];
                }
                
                loc.grenade_locs[ loc.grenade_locs.size ] = grenade_loc;
            }
        }
        
        foreach ( note_loc in self.chanting_note_locs )
        {
            if ( note_loc.script_noteworthy == loc.script_noteworthy )
            {
                loc.note = note_loc;
            }
        }
    }
    
    self.chanting_sigil_locs = utility::getstructarray( "blood_moon_chanting_sigil" );
    self.offering_placement_locs = utility::getstructarray( "blood_moon_offering_placement", "script_noteworthy" );
    
    foreach ( loc in self.offering_placement_locs )
    {
        loc.linked_loc = utility::getstruct( loc.target );
        loc.sigil_loc = { #angles:loc.angles, #origin:loc.origin + ( 0, 0, 5 ) };
    }
    
    self.offering_center_loc = utility::getstruct( "blood_moon_offering_center" );
    self.var_628441f14963c43f = utility::getstruct( "blood_moon_offering_sword" );
    self.var_628441f14963c43f.down_pos = utility::getstruct( self.var_628441f14963c43f.target );
    self.awakening_monster = getentitylessscriptablearray( "monster_card", #script_noteworthy )[ 0 ];
    self.awakening_moon = getentitylessscriptablearray( "blood_moon_moon", #script_noteworthy )[ 0 ];
    self.clue_sheet_loc = utility::getstruct( "blood_moon_clue_sheet" );
    self.var_820fbff513da3d71 = utility::getstruct( "blood_moon_clue_sheet_folder" );
    self.clue_projector_loc = utility::getstruct( "blood_moon_clue_projector" );
    self.var_9f74dd8b05a6454 = utility::getstruct( "blood_moon_clue_image" );
    self.offering_timer = br_map_quest::get_setting( "offering_timer" );
    self.souls_required = br_map_quest::get_setting( "souls_required" );
    self.souls_per_cursed_kill = br_map_quest::get_setting( "souls_per_cursed_kill" );
    self.souls_per_other_kill = br_map_quest::get_setting( "souls_per_other_kill" );
    self.offering_num_progress_states = br_map_quest::get_setting( "offering_num_progress_states" );
    self.offering_circle_radius = br_map_quest::get_setting( "offering_circle_radius" );
    self.offering_circle_radius_sq = squared( self.offering_circle_radius );
    self.offering_circle_reveal_radius = br_map_quest::get_setting( "offering_circle_reveal_radius" );
    self.kills_from_cursed_only = br_map_quest::get_setting( "offering_kills_from_cursed_only" );
    self.kills_from_squad_only = br_map_quest::get_setting( "offering_kills_from_squad_only" );
    self.give_cursed_armor_regen = br_map_quest::get_setting( "offering_give_cursed_armor_regen" );
    self.offering_use_beams = br_map_quest::get_setting( "offering_use_beams" );
    self.offering_use_sigils = br_map_quest::get_setting( "offering_use_sigils" );
    self.cursed_weapon_pickup_timer = br_map_quest::get_setting( "cursed_weapon_pickup_timer" );
    self.awakening_timer = br_map_quest::get_setting( "awakening_timer" );
    self.awakening_jailbreak = br_map_quest::get_setting( "awakening_jailbreak" );
    self.chanting_jump_scare = br_map_quest::get_setting( "chanting_jump_scare" );
    self.sky = spawn( "script_model", ( 0, 0, 0 ) );
    self.sky setmodel( "quest_saw_blood_moon_sky" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x4bd8902d, Offset: 0x1e5a
// Size: 0xd4
function private quest_set_callbacks()
{
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_blood_moon_bones", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_blood_moon_stone", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_blood_moon_vial", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_blood_moon_clue", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_blood_moon_clue_projector", &function_bd94f8f01b476ba );
    scriptable::scriptable_addusedcallbackbypart( "quest_saw_blood_moon_chanting_note", &function_7a330d856a488dce );
    scriptable::scriptable_adddamagedcallback( &function_e7c3293cf599f153 );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x4e962db6, Offset: 0x1f36
// Size: 0xf6
function private on_quest_item_pickup( params )
{
    if ( isdefined( params.scriptable.placement_scr.gathering_item_placed ) )
    {
        params.scriptable.placement_scr.gathering_item_placed = undefined;
    }
    
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    switch ( params.bundle.ref )
    {
        case #"hash_d7e37ec373938130":
            break;
        case #"hash_fc8a2bda6c045cde":
            break;
        case #"hash_c7ab0f46e59ac169":
            break;
        case #"hash_9f239988735457cc":
            quest.clue_projector enablescriptableplayeruse( self );
            quest.clue_folder setscriptablepartstate( "folder", "visible_no_outline" );
            break;
        default:
            return;
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x1c6da6d2, Offset: 0x2034
// Size: 0x99
function private function_c18d0f4047e3fa65( params )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    switch ( params.bundle.ref )
    {
        case #"hash_d7e37ec373938130":
            break;
        case #"hash_fc8a2bda6c045cde":
            break;
        case #"hash_c7ab0f46e59ac169":
            break;
        case #"hash_9f239988735457cc":
            quest.clue_projector function_7653c765b6c7b815();
            break;
        default:
            return;
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x922f665d, Offset: 0x20d5
// Size: 0x197
function private gathering_init()
{
    self.gathering_bones = utility::array_random( self.bones_locs );
    bones_spawn = common_item::function_bc5ff2958b71a708( self.gathering_bones.origin, self.gathering_bones.angles );
    self.gathering_bones.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_bones", 1, bones_spawn );
    self.gathering_stone = utility::array_random( self.stone_locs );
    spawn_options = common_item::function_bc5ff2958b71a708( self.gathering_stone.origin, self.gathering_stone.angles );
    self.gathering_stone.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_stone", 1, spawn_options );
    self.gathering_stone.loot setscriptablepartstate( "brloot_wz_quest_blood_moon_stone", "visible_no_outline_unusable" );
    self.gathering_vial = utility::array_random( self.vial_locs );
    collision = spawnscriptable( "quest_saw_blood_moon_centrifuge_collision", self.gathering_vial.var_d302487567ef6a70.origin, self.gathering_vial.var_d302487567ef6a70.angles, undefined, function_67b78af3c33ac9a8( 1.5 ) );
    self.gathering_vial.var_d302487567ef6a70.collision = collision;
}

// Namespace namespace_341ed135e9592d8
// Params 11, eflags: 0x4
// Checksum 0x13e1ebe9, Offset: 0x2274
// Size: 0xbe
function private function_e7c3293cf599f153( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    if ( instance.type == "quest_saw_blood_moon_centrifuge_collision" )
    {
        thread function_8f0d417a5822e955( instance );
        instance setscriptablepartstate( "quest_saw_blood_moon_centrifuge_collision", "off" );
        return;
    }
    
    if ( instance.type == "quest_saw_blood_moon_hard_hat" )
    {
        thread function_f141c0283ddd91ac( instance );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x84ce8aaf, Offset: 0x233a
// Size: 0xe7
function private function_8f0d417a5822e955( var_d302487567ef6a70 )
{
    level endon( #"game_ended" );
    waitframe();
    var_d302487567ef6a70 freescriptable();
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest.gathering_vial.var_d302487567ef6a70 setscriptablepartstate( "quest_saw_blood_moon_centrifuge", "animation" );
    vial_spawn = common_item::function_f5dfaa3bbdf99a33( quest.gathering_vial.origin, quest.gathering_vial.var_d302487567ef6a70.origin + ( 0, 0, 10 ), quest.gathering_vial.angles );
    quest.gathering_vial.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_vial", 1, vial_spawn );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xab1d53e2, Offset: 0x2429
// Size: 0xed
function private function_f141c0283ddd91ac( hard_hat )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    start_pos = hard_hat.stone_loc.target_loc.origin;
    var_a463ae2da33beab8 = distance2d( start_pos, hard_hat.origin );
    end_pos = hard_hat.origin + vectornormalize( start_pos - hard_hat.origin ) * var_a463ae2da33beab8 * 2;
    new_hat = utility::function_38add6d321fde077( "quest_saw_blood_moon_hard_hat_fly", start_pos, end_pos, "quest_saw_blood_moon_hard_hat_fly", "fly" );
    waitframe();
    quest.gathering_stone.loot setscriptablepartstate( "brloot_wz_quest_blood_moon_stone", "visible" );
    hard_hat setscriptablepartstate( "quest_saw_blood_moon_hard_hat", "off" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x8a55a409, Offset: 0x251e
// Size: 0x199
function private chanting_init()
{
    foreach ( loc in self.chanting_locs )
    {
        loc.scriptable = spawnscriptable( "quest_wz_blood_moon_chanting_player", loc.origin, loc.angles );
        loc.scriptable.quest = self;
        interaction::register_scriptable_interact( loc.scriptable, &function_c5221c1f1d7b732a, undefined, undefined, &chanting_hint_callback );
        loc.var_49cbf3bb8e5a92e5 = spawnscriptable( "quest_wz_blood_moon_chanting_player", loc.mirror_loc.origin, loc.mirror_loc.angles );
        loc.var_49cbf3bb8e5a92e5.record_player = loc.scriptable;
        interaction::register_scriptable_interact( loc.var_49cbf3bb8e5a92e5, &function_330c5a46f367f444, undefined, undefined, &function_27cc7046c0345fe2 );
        loc.scriptable.note = spawnscriptable( "quest_saw_blood_moon_chanting_note", loc.note.origin, loc.note.angles );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xddc65e67, Offset: 0x26bf
// Size: 0xa7
function private function_c5221c1f1d7b732a( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !self.record_playing )
    {
        self.record_playing = 1;
        self setscriptablepartstate( "quest_wz_blood_moon_chanting_player", "disabled" );
        self setscriptablepartstate( "fx", "playing" );
        player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
        
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        /#
            debug::print3d( self, "<dev string:x4f>", ( 0, 1, 0 ), undefined, "<dev string:x60>", undefined, 1, 0.5, 15 );
        #/
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x6ef7c0c3, Offset: 0x276e
// Size: 0x1d4
function private function_330c5a46f367f444( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( player.gasmaskhealth || player getinairpocket() || !player getclientomnvar( "ui_br_player_is_in_gas_from_grenade" ) || !self.record_player.record_playing )
    {
        return;
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest.chanting_complete = 1;
    quest notify( #"chanting_complete" );
    
    foreach ( loc in quest.chanting_locs )
    {
        loc.scriptable setscriptablepartstate( "quest_wz_blood_moon_chanting_player", "disabled" );
        loc.var_49cbf3bb8e5a92e5 setscriptablepartstate( "quest_wz_blood_moon_chanting_player", "disabled" );
    }
    
    self.record_player setscriptablepartstate( "fx", "playing_reverse" );
    
    /#
        iprintlnbold( "<dev string:x81>" );
        level notify( #"hash_4f9e5c77ab9afdae" );
        debug::print3d( self.record_player, "<dev string:xa5>", ( 1, 0, 0 ), undefined, "<dev string:x60>", undefined, 1, 0.5, 15 );
    #/
    
    wait 2;
    self.record_player.note setscriptablepartstate( "quest_saw_blood_moon_chanting_note", "visible" );
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0xe0812db5, Offset: 0x294a
// Size: 0x71
function private chanting_hint_callback( interact, player )
{
    if ( !interact.record_playing )
    {
        return { #var_26bbd300351fde34:0, #string:&"mp_saw_manticore/blood_moon_chanting_player", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0xa8f56980, Offset: 0x29c4
// Size: 0xa4
function private function_27cc7046c0345fe2( interact, player )
{
    if ( !player.gasmaskhealth && !player getinairpocket() && player getclientomnvar( "ui_br_player_is_in_gas_from_grenade" ) && interact.record_player.record_playing )
    {
        return { #var_26bbd300351fde34:0, #string:&"mp_saw_manticore/blood_moon_chanting_player_reverse", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace namespace_341ed135e9592d8
// Params 6, eflags: 0x4
// Checksum 0x3f3003db, Offset: 0x2a71
// Size: 0xad
function private function_7a330d856a488dce( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    if ( quest.chanting_jump_scare && !quest.jumpscare_triggered )
    {
        quest.jumpscare_triggered = 1;
        player thread chanting_note_jumpscare();
        quest function_aff264a0c5174e2();
    }
    
    player interactive_notes::open_note( quest.offering_note_data, instance.origin );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x35b06517, Offset: 0x2b26
// Size: 0x14b
function private function_aff264a0c5174e2()
{
    foreach ( placement in self.var_ed0928dc0b8e9a8 )
    {
        foreach ( loc in self.chanting_sigil_locs )
        {
            if ( placement.var_6810b82ce9302a09 == loc.script_noteworthy )
            {
                loc.scriptable = spawnscriptable( "quest_wz_blood_moon_chanting_sigil", loc.origin, loc.angles );
                loc.scriptable setscriptablepartstate( "quest_wz_blood_moon_chanting_sigil", "sigil_0" + placement.script_int );
            }
        }
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x547d4060, Offset: 0x2c79
// Size: 0xa0
function private function_d0991560c1d287cd()
{
    foreach ( loc in self.chanting_sigil_locs )
    {
        if ( isdefined( loc.scriptable ) )
        {
            loc.scriptable freescriptable();
        }
    }
    
    /#
        level notify( #"hash_275f7a4c5bb974e2" );
    #/
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xc85e1cb1, Offset: 0x2d21
// Size: 0x4e
function private chanting_note_jumpscare()
{
    val::set( "blood_moon_note", "show_hud", 0 );
    playfxontagforclients( utility::getfx( "blood_moon_jumpscare" ), self, "j_head", self );
    self playsoundtoplayer( "evt_zm_tpz_ee_jump_scare_cursed_scream", self );
    wait 1.8;
    val::reset( "blood_moon_note", "show_hud" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x75e80dd8, Offset: 0x2d77
// Size: 0x240
function private offering_init()
{
    foreach ( loc in self.offering_placement_locs )
    {
        loc.scriptable = spawnscriptable( "quest_wz_blood_moon_offering_placement", loc.origin, loc.angles );
        loc.scriptable = interaction::register_scriptable_interact( loc.scriptable, &function_3bf3ec176e032502, undefined, undefined, &function_fc427adfd4940d50 );
    }
    
    self.offering_center_loc.scriptable = spawnscriptable( "quest_wz_blood_moon_offering_placement", self.var_628441f14963c43f.origin, self.var_628441f14963c43f.angles );
    self.offering_center_loc.scriptable = interaction::register_scriptable_interact( self.offering_center_loc.scriptable, &function_478516d4ab1ed822, undefined, undefined, &function_a64f12996ddbfdc9 );
    self.var_ed0928dc0b8e9a8 = [];
    self.offering_placement_locs = arrayrandomize( self.offering_placement_locs );
    item_types = [ 2:"vial", "stone", 0:"bones" ];
    
    for ( i = 0; i < item_types.size ; i++ )
    {
        self.offering_placement_locs[ i ].chosen = 1;
        self.var_ed0928dc0b8e9a8[ i ] = self.offering_placement_locs[ i ];
        self.var_ed0928dc0b8e9a8[ i ].var_6810b82ce9302a09 = item_types[ i ];
    }
    
    self.offering_trigger = spawn( "noent_volume_trigger_radius", self.offering_center_loc.origin, 0, self.offering_circle_reveal_radius, self.offering_circle_reveal_radius );
    self.var_a311af3658c69102 = [];
    self.offering_note_data = interactive_notes::create_note_data( "manticore_blood_moon" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0x827b6293, Offset: 0x2fbf
// Size: 0xc4
function private offering_circle_trigger_wait()
{
    self notify( #"hash_c112244fc349d5f0" );
    self endon( #"hash_c112244fc349d5f0" );
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest endon( #"offering_circle_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        ent_id = ent getentitynumber();
        
        if ( isdefined( quest.players_near_circle[ ent_id ] ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( !ent function_afab7d843e2cb0a4() )
        {
            continue;
        }
        
        quest.players_near_circle[ ent_id ] = ent;
        ent thread function_6d03537c3e4f5936( self );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xf7cc70ac, Offset: 0x308b
// Size: 0x66
function private function_6d03537c3e4f5936( trigger )
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest endon( #"offering_circle_trigger" );
    quest function_627af2d69218fe0b( self );
    
    while ( player::isreallyalive( self ) && self istouching( trigger ) )
    {
        waitframe();
    }
    
    function_b8b5cc70ef066f0f();
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xe1140170, Offset: 0x30f9
// Size: 0xa4
function private function_627af2d69218fe0b( player )
{
    payload = [ #"teamselect", player getentitynumber() ];
    new_circle = spawnscriptable( "quest_wz_blood_moon_offering_circle_per_player", self.offering_center_loc.origin, self.offering_center_loc.angles, undefined, payload );
    new_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle_per_player", "on_inert_per_player" );
    player.var_255e46635823be98 = new_circle;
    self.var_a311af3658c69102[ self.var_a311af3658c69102.size ] = new_circle;
    return new_circle;
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x93f43969, Offset: 0x31a6
// Size: 0x4d
function private function_b8b5cc70ef066f0f()
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    ent_id = self getentitynumber();
    quest.players_near_circle[ ent_id ] = undefined;
    
    if ( isdefined( self.var_255e46635823be98 ) )
    {
        quest function_1b9d81dcfccd4bb2( self );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x7d732b8f, Offset: 0x31fb
// Size: 0x5e
function private function_1b9d81dcfccd4bb2( player )
{
    self.var_a311af3658c69102 = arrayremove( self.var_a311af3658c69102, player.var_255e46635823be98 );
    player.var_255e46635823be98 setscriptablepartstate( "quest_wz_blood_moon_offering_circle_per_player", "on_disappear_per_player" );
    player.var_255e46635823be98 utility::delaycall( 3, &freescriptable );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x20a63f9c, Offset: 0x3261
// Size: 0x1de
function private function_3bf3ec176e032502( player )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    if ( !player function_afab7d843e2cb0a4() || isdefined( self.gathering_item_placed ) )
    {
        return;
    }
    
    spawn_options = common_item::function_bc5ff2958b71a708( self.origin, self.angles );
    
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_bones" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_blood_moon_bones" );
        quest.gathering_bones.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_bones", 1, spawn_options );
        quest.gathering_bones.loot.placement_scr = self;
        self.gathering_item_placed = "bones";
    }
    else if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_stone" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_blood_moon_stone" );
        quest.gathering_stone.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_stone", 1, spawn_options );
        quest.gathering_stone.loot.placement_scr = self;
        self.gathering_item_placed = "stone";
    }
    else if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_vial" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_blood_moon_vial" );
        quest.gathering_vial.loot = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_vial", 1, spawn_options );
        quest.gathering_vial.loot.placement_scr = self;
        self.gathering_item_placed = "vial";
    }
    
    if ( !isdefined( quest.offering_circle ) )
    {
        quest thread function_4bfe8213be665fdb();
    }
    
    quest function_e67d84bb8b26861c();
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x1344f664, Offset: 0x3447
// Size: 0x19b
function private function_4bfe8213be665fdb( remove_trigger = 1 )
{
    foreach ( player in self.players_near_circle )
    {
        player notify( #"offering_circle_trigger" );
        player.var_255e46635823be98 = undefined;
    }
    
    if ( remove_trigger )
    {
        if ( isdefined( self.offering_trigger ) )
        {
            self.offering_trigger delete();
        }
        
        self notify( #"offering_circle_trigger" );
    }
    
    self.offering_circle = spawnscriptable( "quest_wz_blood_moon_offering_circle", self.offering_center_loc.origin, self.offering_center_loc.angles );
    self.offering_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle", "on_inert" );
    self.players_near_circle = undefined;
    wait 3;
    
    foreach ( ritual_circle in self.var_a311af3658c69102 )
    {
        ritual_circle freescriptable();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0x5aa3b06b, Offset: 0x35ea
// Size: 0x121
function private function_fc427adfd4940d50( interact, player )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    if ( isdefined( player ) && player.interactions_disabled || interact.var_94d1ab5da995e573 || !player function_afab7d843e2cb0a4() || isdefined( interact.gathering_item_placed ) || quest.offering_started )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_bones" ) )
    {
        var_e883a56cd422913 = &"mp_saw_manticore/blood_moon_offering_placement_bones";
    }
    else if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_stone" ) )
    {
        var_e883a56cd422913 = &"mp_saw_manticore/blood_moon_offering_placement_stone";
    }
    else if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_vial" ) )
    {
        var_e883a56cd422913 = &"mp_saw_manticore/blood_moon_offering_placement_vial";
    }
    
    return { #var_26bbd300351fde34:0, #string:var_e883a56cd422913, #type:"HINT_BUTTON" };
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0xea4b27eb, Offset: 0x3714
// Size: 0xcf
function private function_a64f12996ddbfdc9( interact, player )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    if ( isdefined( player ) && player.interactions_disabled || interact.var_94d1ab5da995e573 || !quest.var_c36a64fd02ee912d || !player.blood_moon_curse || player != quest.cursed_player )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"mp_saw_manticore/blood_moon_complete_ritual", #type:"HINT_BUTTON" };
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x693f7747, Offset: 0x37ec
// Size: 0x13
function private function_478516d4ab1ed822( player )
{
    thread function_a88f8e9b1f83f4ac();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xd405a2fe, Offset: 0x3807
// Size: 0x110
function private function_a88f8e9b1f83f4ac()
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "quest_wz_blood_moon_offering_placement", "disabled" );
    self setscriptablepartstate( "fx", "placed" );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest offering_reset_player();
    quest.cursed_weapon = utility::spawn_model( "wm_jup_jp23_me_swhiskey_5019", quest.var_628441f14963c43f.origin, quest.var_628441f14963c43f.angles - ( 0, 90, 0 ) );
    quest thread function_6b556077add8edc();
    wait 0.5;
    self setscriptablepartstate( "fx", "moving" );
    quest.cursed_weapon moveto( quest.var_628441f14963c43f.down_pos.origin, 0.3 );
    quest.cursed_weapon waittill( #"movedone" );
    quest thread function_5bb4771ad751d54c();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x4d2bd43d, Offset: 0x391f
// Size: 0xe1
function private function_bc679cf4139d07e5()
{
    self.cursed_player item_weapon::function_9beed18e7ff92b95( {} );
    self.cursed_player item_weapon::function_ec55b6cd928fb1a6( self.cursed_player, self.old_melee_weapon );
    
    foreach ( weapon in self.cursed_player_weapons )
    {
        self.cursed_player item_weapon::function_ec55b6cd928fb1a6( self.cursed_player, weapon );
    }
    
    if ( self.give_cursed_armor_regen )
    {
        self.cursed_player perk::removeperk( "specialty_armor_regen" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xe02b0ca9, Offset: 0x3a08
// Size: 0x2b, Type: bool
function private function_afab7d843e2cb0a4()
{
    return br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_bones" ) || br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_stone" ) || br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_vial" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xfc926fa9, Offset: 0x3a3c
// Size: 0x19a
function private function_e67d84bb8b26861c()
{
    correct_items = 0;
    
    foreach ( loc in self.var_ed0928dc0b8e9a8 )
    {
        if ( loc.scriptable.gathering_item_placed == loc.var_6810b82ce9302a09 )
        {
            correct_items++;
        }
    }
    
    if ( correct_items == 3 )
    {
        self.offering_started = 1;
        self.gathering_bones.loot setscriptablepartstate( "brloot_wz_quest_blood_moon_bones", "visible_no_outline_unusable" );
        self.gathering_stone.loot setscriptablepartstate( "brloot_wz_quest_blood_moon_stone", "visible_no_outline_unusable" );
        self.gathering_vial.loot setscriptablepartstate( "brloot_wz_quest_blood_moon_vial", "visible_no_outline_unusable" );
        
        foreach ( loc in self.offering_placement_locs )
        {
            loc.scriptable freescriptable();
        }
        
        thread offering_spawn_weapon();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x57b03fa9, Offset: 0x3bde
// Size: 0x169
function private offering_spawn_weapon( skip_timer = 0 )
{
    level endon( #"game_ended" );
    wait 1;
    self.offering_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle", "on_weapon_spawn" );
    spawn_options = common_item::function_bc5ff2958b71a708( self.var_628441f14963c43f.down_pos.origin, self.var_628441f14963c43f.down_pos.angles );
    spawn_options.var_50e31f8c119ef961 = 1;
    spawn_options.var_17415ad785d0eab6 = "brloot_weapon_me_swhiskey_blood_moon";
    self.cursed_weapon = common_item::items_spawnitemfromscriptable( "brloot_weapon_me_swhiskey_blood_moon", undefined, spawn_options );
    thread function_6b556077add8edc();
    
    if ( !skip_timer )
    {
        thread function_bdcfa816c8790e20();
    }
    
    self.cursed_pedestal = utility::spawn_model( "t10_zm_ancient_box_pedestal", self.offering_center_loc.origin, self.offering_center_loc.angles );
    
    if ( !level callback::exists( #"player_used_item", &function_65ad1169caabbb2c ) )
    {
        level callback::add( #"player_used_item", &function_65ad1169caabbb2c );
    }
    
    if ( !level callback::exists( #"player_item_pickup", &function_54053186f7779a6d ) )
    {
        level callback::add( #"player_item_pickup", &function_54053186f7779a6d );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x89c088d7, Offset: 0x3d4f
// Size: 0x4a
function private function_6b556077add8edc()
{
    wait 1;
    
    if ( isdefined( self.cursed_weapon ) )
    {
        self.cursed_weapon_fx = spawnscriptable( "quest_saw_blood_moon_cursed_weapon_fx", self.cursed_weapon.origin, self.cursed_weapon.angles );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xa1256f81, Offset: 0x3da1
// Size: 0x37
function private function_bdcfa816c8790e20()
{
    level endon( #"game_ended" );
    self endon( #"offering_ritual_start" );
    self endon( #"offering_complete" );
    wait self.cursed_weapon_pickup_timer;
    offering_cleanup();
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x11a0a956, Offset: 0x3de0
// Size: 0xe8
function private function_65ad1169caabbb2c( params )
{
    if ( params.itembundle.weaponblueprint != %"saw_jp23_me_swhiskey_blood_moon" )
    {
        return;
    }
    
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest.old_melee_weapon = self.var_cc1262e66dbb1c79;
    quest.cursed_player_weapons = [];
    
    for ( index = self.primaryinventory.size - 1; index >= 0 ; index-- )
    {
        weapon = item_weapon::items_weapon_removeweapon( { #dontdrop:1, #weapon:self.primaryinventory[ index ] } );
        quest.cursed_player_weapons[ quest.cursed_player_weapons.size ] = weapon.weaponobj;
    }
    
    thread watch_laststand_revive();
}

// Namespace namespace_341ed135e9592d8
// Params 0
// Checksum 0xdde6caa5, Offset: 0x3ed0
// Size: 0xe0
function watch_laststand_revive()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    quest endon( #"offering_complete" );
    
    while ( true )
    {
        self waittill( #"last_stand_exit" );
        
        foreach ( weapon in self.weaponlist )
        {
            if ( weapon.basename == "jup_jp23_me_swhiskey_mp" )
            {
                self switchtoweaponimmediate( weapon );
                break;
            }
        }
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xa80bc7ab, Offset: 0x3fb8
// Size: 0x80
function private function_54053186f7779a6d( params )
{
    if ( params.itembundlename == "itemspawnentry:wz_item_quest_blood_moon_me_blood_moon" )
    {
        quest = br_map_quest::get_quest( "mtc_blood_moon" );
        quest function_770cd04adb1dd1bf( self );
        quest offering_ritual_start();
        
        if ( isdefined( quest.cursed_weapon_fx ) )
        {
            quest.cursed_weapon_fx setscriptablepartstate( "quest_saw_blood_moon_cursed_weapon_fx", "taken" );
        }
        
        /#
            iprintlnbold( "<dev string:xad>" );
        #/
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xf4d6146, Offset: 0x4040
// Size: 0x97
function private function_770cd04adb1dd1bf( player )
{
    self.cursed_player = player;
    player.blood_moon_curse = 1;
    player val::set( "mtc_blood_moon", "weapon_switch", 0 );
    player val::set( "mtc_blood_moon", "disallow_loot_but_auto_loot", 1 );
    player val::set( "mtc_blood_moon", "crate_use", 0 );
    player val::set( "mtc_blood_moon", "allow_revive_teammate", 0 );
    
    if ( self.give_cursed_armor_regen )
    {
        player perk::giveperk( "specialty_armor_regen" );
    }
    
    function_c7e9a6ea01c46a10();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xe7d8af42, Offset: 0x40df
// Size: 0x176
function private function_c7e9a6ea01c46a10()
{
    if ( !isdefined( self.objectiveiconid ) )
    {
        br_contract_manager::createquestobjicon( "sat_ui_icon_obit_death_skull", "active", self.cursed_player.origin + ( 0, 0, 100 ) );
        objective_disableping( self.objectiveiconid, 1 );
    }
    
    foreach ( player in level.players )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
    
    foreach ( player in teams::getteamdata( self.cursed_player.team, "players" ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    thread function_efbb22540c41f00c();
    thread function_7a9efee6f704d4a( self.cursed_player );
    self.cursed_player thread function_7670e9998ebbf678();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x8c745e56, Offset: 0x425d
// Size: 0x23
function private function_7670e9998ebbf678()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    function_9a045442b9532feb( self );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x71f552dc, Offset: 0x4288
// Size: 0x93
function private function_7a9efee6f704d4a( player )
{
    if ( isdefined( player.var_9dee20737748828 ) )
    {
        return;
    }
    
    player.var_9dee20737748828 = utility::spawn_tag_origin( player gettagorigin( "j_spineupper" ) );
    player.var_9dee20737748828 linkto( player, "j_spineupper" );
    player.var_9dee20737748828 show();
    player.var_9dee20737748828 forcenetfieldhighlod( 1 );
    waitframe();
    playfxontag( utility::getfx( "blood_moon_cursed_player" ), player.var_9dee20737748828, "tag_origin" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0x6510549f, Offset: 0x4323
// Size: 0x86
function private function_efbb22540c41f00c()
{
    self notify( #"hash_52c8c1eb07e932b9" );
    self endon( #"hash_52c8c1eb07e932b9" );
    level endon( #"game_ended" );
    self endon( #"offering_complete" );
    
    if ( isdefined( self.cursed_player ) )
    {
        self.cursed_player endon( #"death_or_disconnect" );
    }
    
    while ( true )
    {
        br_contract_manager::movequestobjicon( self.cursed_player.origin + ( 0, 0, 100 ) );
        wait 10;
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x516f7fb, Offset: 0x43b1
// Size: 0x1a2
function private offering_ritual_start()
{
    if ( !self.offering_active )
    {
        self notify( #"offering_ritual_start" );
        self.offering_active = 1;
        
        if ( !isdefined( self.var_96eb78ba5e9f3386 ) )
        {
            self.var_96eb78ba5e9f3386 = 0;
        }
        
        self.var_1471d4de11223fd5 = self.souls_required / self.offering_num_progress_states;
        self.var_d8eae5219c37a016 = 0;
        game_utility::questcircle_create( "BloodMoon_Br", self.offering_center_loc.origin, self.offering_circle_radius );
        thread offering_timer();
        self.offering_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle", "on_activate" );
        function_d0991560c1d287cd();
        
        if ( self.offering_use_beams )
        {
            function_a501e333e2d626e5();
        }
    }
    
    game_utility::questcircle_hidefromall();
    
    foreach ( player in teams::getteamdata( self.cursed_player.team, "players" ) )
    {
        game_utility::questcircle_showtoplayer( player );
    }
    
    if ( !level callback::exists( #"player_death", &on_player_killed ) )
    {
        level callback::add( #"player_death", &on_player_killed );
    }
    
    /#
        level notify( #"hash_3745da03a462d9b0" );
        level notify( #"hash_4f9e5c77ab9afdae" );
    #/
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0xa0123e16, Offset: 0x455b
// Size: 0x44
function private offering_timer()
{
    self notify( #"hash_14d9c24ce02153d8" );
    self endon( #"hash_14d9c24ce02153d8" );
    level endon( #"game_ended" );
    self endon( #"offering_complete" );
    wait self.offering_timer;
    thread function_5bb4771ad751d54c( 0 );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x43eb1a26, Offset: 0x45a7
// Size: 0x2f
function private function_f6f45eee464b1f92()
{
    self.var_c36a64fd02ee912d = 1;
    self.offering_center_loc.scriptable setscriptablepartstate( "quest_wz_blood_moon_offering_placement", "usable" );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x7098d2f6, Offset: 0x45de
// Size: 0xb7
function private function_5bb4771ad751d54c( var_da46b4f296148eae = 1 )
{
    self notify( #"offering_complete" );
    self.offering_active = 0;
    
    if ( var_da46b4f296148eae )
    {
        if ( isdefined( self.cursed_player ) )
        {
            params = { #completed_by:teams::getteamdata( self.cursed_player.team, "players" ), #is_successful:1 };
            br_map_quest::on_completed( params );
        }
        
        self.offering_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle", "on_complete" );
        thread awakening_start();
    }
    else
    {
        offering_reset_player();
    }
    
    offering_cleanup( var_da46b4f296148eae );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0xa07f795, Offset: 0x469d
// Size: 0x2a4
function private on_player_killed( params )
{
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    
    if ( quest.is_completed && arraycontains( quest.completed_by, params.victim ) )
    {
        function_9a045442b9532feb( params.victim );
    }
    
    if ( !quest.offering_active )
    {
        return;
    }
    
    within_range = distancesquared( params.victim.origin, quest.offering_center_loc.origin ) < quest.offering_circle_radius_sq;
    
    if ( params.victim == quest.cursed_player )
    {
        quest function_411e0dc472d218db();
        spawn_options = common_item::items_initspawnoptions_spawnfromentity( params.victim );
        quest.cursed_weapon = common_item::items_spawnitemfromscriptable( "brloot_weapon_me_swhiskey_blood_moon", undefined, spawn_options );
        quest thread function_6b556077add8edc();
        
        if ( !level callback::exists( #"player_item_pickup", &function_54053186f7779a6d ) )
        {
            level callback::add( #"player_item_pickup", &function_54053186f7779a6d );
        }
        
        return;
    }
    
    if ( params.objweapon.receiverblueprint.attachmentdata == "saw_jp23_me_swhiskey_rec_blood_moon" && within_range )
    {
        for ( i = 0; i < quest.souls_per_cursed_kill ; i++ )
        {
            quest thread function_e202f5a7f8d0e89f( params.victim, quest.var_628441f14963c43f.down_pos.origin );
        }
        
        params.attacker thread points::doscoreevent( #"hash_38156755a5030e55" );
        return;
    }
    
    if ( !quest.kills_from_cursed_only && within_range )
    {
        if ( quest.kills_from_squad_only && params.attacker.team != quest.cursed_player.team )
        {
            return;
        }
        
        for ( i = 0; i < quest.souls_per_other_kill ; i++ )
        {
            quest thread function_e202f5a7f8d0e89f( params.victim, quest.var_628441f14963c43f.down_pos.origin );
        }
        
        params.attacker thread points::doscoreevent( #"hash_6996995e5fa3f79f" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x7126e685, Offset: 0x4949
// Size: 0x32
function private offering_reset_player()
{
    if ( isdefined( self.cursed_player ) )
    {
        function_411e0dc472d218db();
        function_bc679cf4139d07e5();
        self.cursed_player val::reset_all( "mtc_blood_moon" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x7fe0d9b4, Offset: 0x4983
// Size: 0x4b
function private function_9a045442b9532feb( player )
{
    if ( isdefined( player.var_9dee20737748828 ) )
    {
        stopfxontag( utility::getfx( "blood_moon_cursed_player" ), player.var_9dee20737748828, "tag_origin" );
        player.var_9dee20737748828 delete();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x23ef9d32, Offset: 0x49d6
// Size: 0x30
function private function_411e0dc472d218db()
{
    function_9a045442b9532feb( self.cursed_player );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        br_contract_manager::deletequestobjicon();
        self.objectiveiconid = undefined;
    }
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0x126cd704, Offset: 0x4a0e
// Size: 0x372
function private function_e202f5a7f8d0e89f( var_2318ee398b583154, end_position )
{
    level endon( #"game_ended" );
    self endon( #"offering_complete" );
    
    if ( isdefined( self.cursed_player ) )
    {
        self.cursed_player endon( #"death_or_disconnect" );
    }
    
    if ( !isdefined( self.var_c2f02e38c8454a9a ) )
    {
        self.var_c2f02e38c8454a9a = [];
    }
    
    vfx_root = utility::spawn_model( "quest_saw_blood_moon_soul_wisp", var_2318ee398b583154.origin );
    vfx_root forcenetfieldhighlod( 1 );
    self.var_c2f02e38c8454a9a[ self.var_c2f02e38c8454a9a.size ] = vfx_root;
    start_position = var_2318ee398b583154.origin + ( 0, 0, 100 );
    vfx_root setscriptablepartstate( "quest_saw_blood_moon_soul_wisp", "created" );
    vfx_root moveto( start_position, 1.5 );
    wait 1.5;
    vfx_root.angles = vectortoangles( end_position - start_position );
    var_4f58ae3108177d2c = distance( start_position, end_position );
    var_36340753cb0e64d5 = var_4f58ae3108177d2c / 10;
    speed = 100 * var_36340753cb0e64d5 + 250;
    speed += randomfloatrange( -1 * speed * 0.2 / 2, speed * 0.2 / 2 );
    
    if ( speed < 250 )
    {
        speed = 250;
    }
    
    if ( speed > 350 )
    {
        speed = 350;
    }
    
    duration = var_4f58ae3108177d2c / speed;
    start_timestamp = gettime();
    current_timestamp = start_timestamp;
    spiral_seed = randomint( 360 );
    spiral_frequency = randomfloatrange( 1, 3 );
    spiral_magnitude = randomintrange( 30, 50 );
    offset_z = 0;
    var_37b66bef2ccb4209 = start_position[ 2 ] - end_position[ 2 ];
    
    if ( var_37b66bef2ccb4209 < 60 )
    {
        target_z_offset = randomintrange( 40, 60 ) + var_37b66bef2ccb4209 / 2;
    }
    else if ( var_37b66bef2ccb4209 < 120 )
    {
        target_z_offset = randomintrange( 0, 40 ) + var_37b66bef2ccb4209 / 2;
    }
    else
    {
        target_z_offset = randomintrange( -40, 0 ) + var_37b66bef2ccb4209 / 2;
    }
    
    lerp_value = 0;
    
    while ( lerp_value < 1 )
    {
        current_timestamp = gettime();
        spiral_angle = spiral_seed + spiral_frequency * lerp_value * 180;
        lerp_spiral_magnitude = sin( lerp_value * 180 ) * spiral_magnitude;
        var_83b5f6ccc840848e = rotatepointaroundvector( anglestoforward( vfx_root.angles ), lerp_spiral_magnitude * anglestoright( vfx_root.angles ), spiral_angle );
        v_z_offset = ( 0, 0, target_z_offset * sin( lerp_value * 180 + sin( lerp_value * 180 ) / -1 ) );
        target_position = vectorlerp( start_position, end_position, lerp_value ) + v_z_offset + var_83b5f6ccc840848e;
        vfx_root.origin = target_position;
        lerp_value = pow( ( current_timestamp - start_timestamp ) / 1000 / duration, 1.1 );
        waitframe();
    }
    
    if ( self.offering_active && !self.var_c36a64fd02ee912d )
    {
        thread function_78d2143ce22fdf75();
    }
    
    vfx_root setscriptablepartstate( "quest_saw_blood_moon_soul_wisp", "off" );
    
    if ( self.complete )
    {
    }
    
    wait 2;
    self.var_c2f02e38c8454a9a = arrayremove( self.var_c2f02e38c8454a9a, vfx_root );
    vfx_root delete();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x2d68f8b8, Offset: 0x4d88
// Size: 0xbf
function private function_78d2143ce22fdf75()
{
    self.var_96eb78ba5e9f3386++;
    
    if ( self.var_96eb78ba5e9f3386 == self.var_1471d4de11223fd5 )
    {
        self.var_d8eae5219c37a016++;
        self.offering_circle setscriptablepartstate( "quest_wz_blood_moon_offering_circle", "on_progress_0" + self.var_d8eae5219c37a016 );
        self.var_96eb78ba5e9f3386 = 0;
        
        if ( self.offering_use_beams )
        {
            offering_spawn_beam();
        }
        
        if ( self.offering_use_sigils )
        {
            function_61d604e2e42a532f();
        }
    }
    
    /#
        iprintlnbold( "<dev string:xba>" + self.var_d8eae5219c37a016 );
    #/
    
    if ( self.var_d8eae5219c37a016 >= self.offering_num_progress_states )
    {
        function_f6f45eee464b1f92();
        
        /#
            iprintlnbold( "<dev string:xe7>" );
        #/
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xc2bde714, Offset: 0x4e4f
// Size: 0xaf
function private function_a501e333e2d626e5()
{
    foreach ( loc in self.offering_placement_locs )
    {
        loc.beam_ent = utility::spawn_model( "quest_saw_blood_moon_beam_impact", loc.origin + ( 0, 0, 10 ), ( 0, 0, 0 ) );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x97cf3996, Offset: 0x4f06
// Size: 0x129
function private offering_spawn_beam()
{
    foreach ( loc in self.offering_placement_locs )
    {
        if ( loc.script_int == self.var_d8eae5219c37a016 )
        {
            var_93c3e7bb3f019adf = loc;
            break;
        }
    }
    
    if ( !var_93c3e7bb3f019adf )
    {
        return;
    }
    
    var_93c3e7bb3f019adf.beam = function_fc8c9b9ac6af4fa8( var_93c3e7bb3f019adf.beam_ent, var_93c3e7bb3f019adf.linked_loc.beam_ent );
    var_93c3e7bb3f019adf.beam_ent setscriptablepartstate( "quest_saw_blood_moon_beam_impact", "beam_impact_off" );
    
    if ( !var_93c3e7bb3f019adf.linked_loc.beam )
    {
        var_93c3e7bb3f019adf.linked_loc.beam_ent setscriptablepartstate( "quest_saw_blood_moon_beam_impact", "beam_impact_on" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 2, eflags: 0x4
// Checksum 0x7e1ab8d3, Offset: 0x5037
// Size: 0x5e
function private function_fc8c9b9ac6af4fa8( var_13bd7fbae2189950, var_5c4d64b2e9db0bd5 )
{
    if ( !isdefined( var_13bd7fbae2189950 ) || !isdefined( var_5c4d64b2e9db0bd5 ) )
    {
        return;
    }
    
    beam_data = { #beam_blocked:0, #beam_end:var_5c4d64b2e9db0bd5, #beam_start:var_13bd7fbae2189950 };
    waitframe();
    beam_data function_76a70e3e7fbd91fe();
    return beam_data;
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x91a4ec05, Offset: 0x509e
// Size: 0x5e
function private function_76a70e3e7fbd91fe()
{
    if ( isdefined( self.beam_vfx ) && isdefined( self.beam_start ) && isdefined( self.beam_end ) )
    {
        return;
    }
    
    self.beam_vfx = playfxontagsbetweenclients( utility::getfx( "blood_moon_offering_beam" ), self.beam_start, "tag_origin", self.beam_end, "tag_origin" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x73037066, Offset: 0x5104
// Size: 0x35
function private function_f69b529e6ce47f11()
{
    if ( isdefined( self.beam_vfx ) )
    {
        self.beam_start = undefined;
        self.beam_end delete();
        self.beam_vfx delete();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xf1308521, Offset: 0x5141
// Size: 0xf1
function private function_61d604e2e42a532f()
{
    foreach ( loc in self.offering_placement_locs )
    {
        if ( loc.script_int == self.var_d8eae5219c37a016 )
        {
            sigil_loc = loc;
            break;
        }
    }
    
    if ( !sigil_loc )
    {
        return;
    }
    
    sigil_loc.scriptable = spawnscriptable( "quest_wz_blood_moon_offering_circle_sigil", sigil_loc.origin, sigil_loc.angles );
    sigil_loc.scriptable setscriptablepartstate( "sigil_0" + sigil_loc.script_int, "on" );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x32dd19af, Offset: 0x523a
// Size: 0x38e
function private offering_cleanup( blood_moon_active = 0 )
{
    if ( isdefined( self.cursed_weapon ) && !isent( self.cursed_weapon ) )
    {
        self.cursed_weapon freescriptable();
    }
    
    foreach ( loc in self.offering_placement_locs )
    {
        if ( isdefined( loc.scriptable ) )
        {
            loc.scriptable freescriptable();
        }
    }
    
    if ( isdefined( self.offering_center_loc.scriptable ) )
    {
        self.offering_center_loc.scriptable freescriptable();
    }
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
    
    foreach ( wisp in self.var_c2f02e38c8454a9a )
    {
        wisp delete();
    }
    
    level callback::remove( #"player_used_item", &function_65ad1169caabbb2c );
    level callback::remove( #"player_item_pickup", &function_54053186f7779a6d );
    level callback::remove( #"player_death", &on_player_killed );
    
    if ( !blood_moon_active )
    {
        if ( isdefined( self.cursed_player ) )
        {
            self.cursed_player val::reset_all( "mtc_blood_moon" );
            self.cursed_player.blood_moon_curse = undefined;
            self.cursed_player = undefined;
        }
        
        if ( isent( self.cursed_weapon ) )
        {
            self.cursed_weapon delete();
        }
        
        if ( isdefined( self.cursed_weapon_fx ) )
        {
            self.cursed_weapon_fx freescriptable();
        }
        
        if ( isdefined( self.cursed_pedestal ) )
        {
            self.cursed_pedestal delete();
        }
        
        if ( isdefined( self.offering_circle ) )
        {
            self.offering_circle freescriptable();
        }
        
        if ( isdefined( self.gathering_bones.loot ) )
        {
            self.gathering_bones.loot freescriptable();
        }
        
        if ( isdefined( self.gathering_stone.loot ) )
        {
            self.gathering_stone.loot freescriptable();
        }
        
        if ( isdefined( self.gathering_vial.loot ) )
        {
            self.gathering_vial.loot freescriptable();
        }
        
        foreach ( loc in self.offering_placement_locs )
        {
            if ( isdefined( loc.beam ) )
            {
                loc.beam function_f69b529e6ce47f11();
            }
        }
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xc4548813, Offset: 0x55d0
// Size: 0xba
function private awakening_start()
{
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"player_disconnect", &on_player_disconnect ) )
    {
        level callback::add( #"player_disconnect", &on_player_disconnect );
    }
    
    level notify( #"blood_moon_awakening_start" );
    awakening_splash();
    wait 3;
    thread function_3492ce8518c885e2();
    thread function_3c44a62aafc69c3e();
    wait 1.5;
    thread function_5f3191a6c20f5e04();
    thread function_ad53344a99529565();
    function_2f1c5c84a8466efa();
    thread function_456d84d9f0382884();
    thread function_3e2da4cff31d6d62();
    
    if ( self.awakening_jailbreak )
    {
        function_ee2bbd3ffc77c64f();
    }
    
    thread awakening_timer();
    level callback::remove( #"player_death", &on_player_killed );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x365d98c, Offset: 0x5692
// Size: 0x183
function private awakening_splash( blood_moon = 1 )
{
    if ( blood_moon )
    {
        if ( self.completed_by.size == 0 )
        {
            team = level.players[ 0 ].team;
        }
        else
        {
            team = self.completed_by[ 0 ].team;
        }
        
        teamindex = function_f02c63b99c9614c9( level.allteamnamelist, team );
        
        foreach ( player in level.players )
        {
            player thread hud_message::showsplash( "quest_blood_moon_awakening_begin", teamindex, undefined, undefined, undefined, "splash_list_saw_map_mp_saw_manticore" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "quest_blood_moon_awakening_end", undefined, undefined, undefined, undefined, "splash_list_saw_map_mp_saw_manticore" );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xebfe7401, Offset: 0x581d
// Size: 0xbd
function private function_3492ce8518c885e2()
{
    foreach ( player in level.players )
    {
        playfxontagforclients( utility::getfx( "blood_moon_awakening_start" ), player, "j_head", player );
        var_947bb4706c5ccfaa = player hud_util::function_cd054751d2d5b5c5( "black" );
        var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( player, 1, 1, 1, 1 );
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x95a28ad3, Offset: 0x58e2
// Size: 0x5f
function private function_3c44a62aafc69c3e( blood_moon = 1 )
{
    if ( !hasareaswap( "mp_saw_manticore_district_states" ) )
    {
        return;
    }
    
    state_name = blood_moon ? "blood_moon_on" : "blood_moon_off";
    setareaswaphint( "mp_saw_manticore_district_states", state_name );
    wait 1.5;
    setareaswapstate( "mp_saw_manticore_district_states", state_name );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x87799e0, Offset: 0x5949
// Size: 0x163
function private function_ad53344a99529565( blood_moon = 1 )
{
    if ( blood_moon )
    {
        foreach ( player in level.players )
        {
            player function_32a61f2d28fb282c( "mtc_ee_awakening", "script", 0, "ambient", "mix" );
        }
        
        self.var_279e499e5a389982 = spawnscriptable( "quest_saw_bloodmoon_sky_monster_audio", ( 11635, -5538, 1688 ) );
        waitframe();
        self.var_279e499e5a389982 setscriptablepartstate( "sfx", "visible" );
        return;
    }
    
    foreach ( player in level.players )
    {
        player clearpriorityclienttriggeraudiozone( "script", 2 );
    }
    
    self.var_279e499e5a389982 freescriptable();
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x4fa33019, Offset: 0x5ab4
// Size: 0x226
function private function_2f1c5c84a8466efa( blood_moon = 1 )
{
    if ( blood_moon )
    {
        foreach ( player in level.players )
        {
            function_ad915db840c90fb3( 1023, 2, undefined, undefined, player );
        }
        
        self.sky setscriptablepartstate( "awakening", "on" );
        
        if ( isdefined( self.awakening_monster ) )
        {
            self.awakening_monster setscriptablepartstate( "card", "on" );
        }
        
        if ( isdefined( self.awakening_moon ) )
        {
            self.awakening_moon setscriptablepartstate( "moon", "on" );
        }
        
        if ( !isdefined( self.awakening_lightning ) )
        {
            self.awakening_lightning = spawnscriptable( "quest_saw_blood_moon_lightning_strikes", ( 0, 0, 2000 ), ( 0, 0, 0 ) );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        function_ad915db840c90fb3( 1023, 1, undefined, undefined, player );
    }
    
    self.sky setscriptablepartstate( "awakening", "off" );
    
    if ( isdefined( self.awakening_monster ) )
    {
        self.awakening_monster setscriptablepartstate( "card", "off" );
    }
    
    if ( isdefined( self.awakening_moon ) )
    {
        self.awakening_moon setscriptablepartstate( "moon", "off" );
    }
    
    if ( isdefined( self.awakening_lightning ) )
    {
        self.awakening_lightning freescriptable();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x79bf41e6, Offset: 0x5ce2
// Size: 0xb7
function private function_5f3191a6c20f5e04()
{
    if ( isdefined( self.cursed_player ) )
    {
        foreach ( player in teams::getteamdata( self.cursed_player.team, "players" ) )
        {
            player thread points::doscoreevent( #"hash_99f501b35ebbd039" );
            challenges::function_37e945722d6497f3( player, "manticore_sq_blood_moon", 1, 0 );
        }
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xe7a9f761, Offset: 0x5da1
// Size: 0x1f
function private awakening_timer()
{
    level endon( #"game_ended" );
    wait self.awakening_timer;
    thread awakening_end();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xe4b47ee3, Offset: 0x5dc8
// Size: 0x4c
function private awakening_end()
{
    level notify( #"blood_moon_awakening_end" );
    awakening_splash( 0 );
    wait 3;
    thread function_3492ce8518c885e2();
    thread function_3c44a62aafc69c3e( 0 );
    wait 1.5;
    thread function_93b74f27654e85fd();
    thread function_ad53344a99529565( 0 );
    function_2f1c5c84a8466efa( 0 );
    offering_cleanup();
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x9f38afb, Offset: 0x5e1c
// Size: 0xdc
function private function_3e2da4cff31d6d62()
{
    if ( self.completed_by.size == 0 )
    {
        team = level.players[ 0 ].team;
    }
    else
    {
        team = self.completed_by[ 0 ].team;
    }
    
    awakening_team = teams::getteamdata( team, "players" );
    
    foreach ( teammate in awakening_team )
    {
        thread function_7a9efee6f704d4a( teammate );
        teammate thread function_1843198083877557();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x67dbad35, Offset: 0x5f00
// Size: 0x1a4
function private function_93b74f27654e85fd()
{
    level endon( #"game_ended" );
    
    if ( self.completed_by.size == 0 )
    {
        team = level.players[ 0 ].team;
    }
    else
    {
        team = self.completed_by[ 0 ].team;
    }
    
    awakening_team = teams::getteamdata( team, "players" );
    
    foreach ( teammate in awakening_team )
    {
        if ( !isalive( teammate ) )
        {
            continue;
        }
        
        teammate perk::giveperk( "specialty_hunter" );
        teammate perk::giveperk( "specialty_regen_aura" );
        teammate thread function_7fbd03f0c961e53c();
    }
    
    level utility::waittill_any_timeout( 120, "blood_moon_awakening_start" );
    awakening_team = teams::getteamdata( team, "players" );
    
    foreach ( teammate in awakening_team )
    {
        function_574d5d7445503cf7( teammate );
    }
    
    level callback::remove( #"player_disconnect", &on_player_disconnect );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0x2c00f613, Offset: 0x60ac
// Size: 0x36
function private function_1843198083877557()
{
    self notify( #"hash_91f271ee7eca674b" );
    self endon( #"hash_91f271ee7eca674b" );
    level waittill( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_9a045442b9532feb( self );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0x3dea7984, Offset: 0x60ea
// Size: 0x46
function private function_7fbd03f0c961e53c()
{
    self notify( #"hash_be66eaabdbdb4809" );
    self endon( #"hash_be66eaabdbdb4809" );
    level waittill( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    perk::removeperk( "specialty_hunter" );
    perk::removeperk( "specialty_regen_aura" );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0xc
// Checksum 0xdc8b6868, Offset: 0x6138
// Size: 0x58
function private function_456d84d9f0382884()
{
    self notify( #"hash_45c4745f8556135d" );
    self endon( #"hash_45c4745f8556135d" );
    level endon( #"blood_moon_awakening_end" );
    level waittill( #"game_ended" );
    thread function_3492ce8518c885e2();
    thread function_3c44a62aafc69c3e( 0 );
    wait 1.5;
    thread function_ad53344a99529565( 0 );
    function_2f1c5c84a8466efa( 0 );
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x89d1d264, Offset: 0x6198
// Size: 0x31
function private function_574d5d7445503cf7( player )
{
    player perk::removeperk( "specialty_hunter" );
    player perk::removeperk( "specialty_regen_aura" );
    function_9a045442b9532feb( player );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0x85361177, Offset: 0x61d1
// Size: 0x8f
function private function_ee2bbd3ffc77c64f()
{
    playerlist = br_publicevent_jailbreak::buildrespawnlist( 0 );
    
    foreach ( player in playerlist )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread br_publicevent_jailbreak::respawnplayer();
    }
}

// Namespace namespace_341ed135e9592d8
// Params 1, eflags: 0x4
// Checksum 0x50a07f4d, Offset: 0x6268
// Size: 0x14
function private on_player_disconnect( params )
{
    function_574d5d7445503cf7( self );
}

// Namespace namespace_341ed135e9592d8
// Params 0, eflags: 0x4
// Checksum 0xb7b46545, Offset: 0x6284
// Size: 0x108
function private clue_init()
{
    spawn_options = common_item::function_bc5ff2958b71a708( self.clue_sheet_loc.origin, self.clue_sheet_loc.angles );
    self.clue_sheet = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_clue", 1, spawn_options );
    self.clue_folder = spawnscriptable( "quest_saw_blood_moon_clue_folder", self.var_820fbff513da3d71.origin, self.var_820fbff513da3d71.angles );
    self.clue_projector = spawnscriptable( "quest_wz_blood_moon_clue_projector", self.clue_projector_loc.origin, self.clue_projector_loc.angles );
    self.clue_projector function_7653c765b6c7b815();
    self.clue_projection_map = spawnscriptable( "quest_wz_blood_moon_clue_projection", self.var_9f74dd8b05a6454.origin, self.var_9f74dd8b05a6454.angles );
}

// Namespace namespace_341ed135e9592d8
// Params 6, eflags: 0x4
// Checksum 0xe1c2a0e3, Offset: 0x6394
// Size: 0x20f
function private function_bd94f8f01b476ba( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_quest_inventory::has_quest_item( "wz_consumable_quest_blood_moon_clue" ) )
    {
        return;
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    quest = br_map_quest::get_quest( "mtc_blood_moon" );
    instance setscriptablepartstate( "quest_wz_blood_moon_clue_projector", "disabled" );
    instance setscriptablepartstate( "fx", "on" );
    spawn_options = common_item::function_bc5ff2958b71a708( quest.clue_projector_loc.origin, quest.clue_projector_loc.angles );
    quest.clue_sheet = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_blood_moon_clue", 1, spawn_options );
    quest.clue_sheet setscriptablepartstate( "brloot_wz_quest_blood_moon_clue", "visible_no_outline_unusable" );
    player br_quest_inventory::consume_quest_item( "wz_consumable_quest_blood_moon_clue" );
    quest.clue_projection_map setscriptablepartstate( "quest_wz_blood_moon_clue_projection", "on" );
    quest.clue_projection_map setscriptablepartstate( "gathering_bones", "on_" + quest.gathering_bones.script_noteworthy );
    quest.clue_projection_map setscriptablepartstate( "gathering_stone", "on_" + quest.gathering_stone.script_noteworthy );
    quest.clue_projection_map setscriptablepartstate( "gathering_vial", "on_" + quest.gathering_vial.script_noteworthy );
    
    /#
        iprintlnbold( "<dev string:x113>" );
        quest.var_c819f91a118fbd81 = 0;
        quest.var_90cc0bc35401df9e = 0;
        level notify( #"hash_f04051e83704f39b" );
        level notify( #"hash_275f7a4c5bb974e2" );
        function_e2fc0640e6255680();
        function_e60d08af7146cd71();
        function_348a8667e0dba9f9();
    #/
}

/#

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xa4b9ea89, Offset: 0x65ab
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xcd1c73ce, Offset: 0x65bf
    // Size: 0x6bc, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x132>" + level.mapname + "<dev string:x141>" + "<dev string:x143>" + "<dev string:x141>" );
        devgui::add_devgui_func( "<dev string:x152>", "<dev string:x174>", &function_e2fc0640e6255680 );
        devgui::add_devgui_func( "<dev string:x198>", "<dev string:x1ad>", &function_3562453b832f65db );
        devgui::add_devgui_func( "<dev string:x1d3>", "<dev string:x1f5>", &function_f09bdd6a7815e163 );
        devgui::add_devgui_func( "<dev string:x21a>", "<dev string:x23d>", &function_e60d08af7146cd71 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x260>", "<dev string:x274>", &function_59f5f5549983b499 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a0>", "<dev string:x2b3>", &function_59f5f5549983b499 );
        devgui::add_devgui_func( "<dev string:x2de>", "<dev string:x2fa>", &function_7b4035fface4f0c7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x320>", "<dev string:x339>", &function_64421aecc07d8b85 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x364>", "<dev string:x37d>", &function_64421aecc07d8b85 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a8>", "<dev string:x3c0>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3f2>", "<dev string:x40a>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43c>", "<dev string:x454>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x486>", "<dev string:x49e>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d0>", "<dev string:x4e8>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51a>", "<dev string:x532>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x564>", "<dev string:x57c>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5ae>", "<dev string:x5c6>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f8>", "<dev string:x610>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x642>", "<dev string:x65a>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x68c>", "<dev string:x6a3>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6d4>", "<dev string:x6eb>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x71c>", "<dev string:x733>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x764>", "<dev string:x77b>", &function_cf756afd5c782a87 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7ac>", "<dev string:x7c3>", &function_cf756afd5c782a87 );
        devgui::add_devgui_func( "<dev string:x7f4>", "<dev string:x80e>", &function_348a8667e0dba9f9 );
        devgui::add_devgui_func( "<dev string:x831>", "<dev string:x854>", &function_5b4ee051d95d43aa );
        devgui::add_devgui_func( "<dev string:x87d>", "<dev string:x89a>", &function_726509570f1a2454 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8c6>", "<dev string:x8f2>", &function_a64400989bedad5d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x932>", "<dev string:x95f>", &function_a64400989bedad5d );
        devgui::add_devgui_func( "<dev string:x9a3>", "<dev string:x9c2>", &function_ea636a07f1b4ffd );
        devgui::add_devgui_func( "<dev string:x9e7>", "<dev string:xa05>", &function_5f5bd2204bf56fa );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa31>", "<dev string:xa51>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa82>", "<dev string:xaa2>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xad3>", "<dev string:xaf1>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb1f>", "<dev string:xb3d>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb6b>", "<dev string:xb89>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbb7>", "<dev string:xbd5>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc03>", "<dev string:xc21>", &function_a12f5d9038c01bd3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc4f>", "<dev string:xc84>", &function_c3215862e313bd0c );
        devgui::function_cd4e263c1f3018ae( "<dev string:xca9>", "<dev string:xcde>", &function_c3215862e313bd0c );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd03>", "<dev string:xd23>", &function_e444365fd360517e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd49>", "<dev string:xd69>", &function_e444365fd360517e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd8f>", "<dev string:xdaf>", &function_e444365fd360517e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdd5>", "<dev string:xdf5>", &function_e444365fd360517e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe1b>", "<dev string:xe3b>", &function_e444365fd360517e );
        devgui::add_devgui_func( "<dev string:xe61>", "<dev string:xe7d>", &function_62036c4794310d6a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xea8>", "<dev string:xec4>", &function_38f94a6c9d06ca0b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xeec>", "<dev string:xf06>", &function_38f94a6c9d06ca0b );
        devgui::add_devgui_func( "<dev string:xf2e>", "<dev string:xf47>", &function_fc12b5020369d6eb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf70>", "<dev string:xf84>", &function_764b7cdb4eff47b5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfab>", "<dev string:xfc1>", &function_764b7cdb4eff47b5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfe8>", "<dev string:xffc>", &function_7f74eeb0bed56b4e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1023>", "<dev string:x1039>", &function_7f74eeb0bed56b4e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1060>", "<dev string:x1072>", &function_bf7d64fadfd3e229 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1093>", "<dev string:x10a7>", &function_bf7d64fadfd3e229 );
        devgui::add_devgui_func( "<dev string:x10c8>", "<dev string:x10e6>", &debug_awakening_start );
        devgui::add_devgui_func( "<dev string:x110b>", "<dev string:x112b>", &function_95bbb87bcfde35bb );
        devgui::add_devgui_func( "<dev string:x1153>", "<dev string:x117b>", &function_f1d9dded661be639 );
        devgui::add_devgui_func( "<dev string:x11a0>", "<dev string:x11bf>", &function_2c8aa09a1583930c );
        devgui::add_devgui_func( "<dev string:x11e5>", "<dev string:x11fd>", &function_d34a0de737971743 );
        devgui::add_devgui_func( "<dev string:x1222>", "<dev string:x1233>", &function_8564515a4d6e7e1d );
        devgui::add_devgui_func( "<dev string:x1256>", "<dev string:x126c>", &function_e9e347698cb57670 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1294>", "<dev string:x12a2>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12e8>", "<dev string:x12f6>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x133d>", "<dev string:x134a>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1384>", "<dev string:x1391>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13cb>", "<dev string:x13d8>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1412>", "<dev string:x1421>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1454>", "<dev string:x1461>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x149b>", "<dev string:x14a8>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x14e2>", "<dev string:x14ef>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1529>", "<dev string:x1538>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x156b>", "<dev string:x1577>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15af>", "<dev string:x15bb>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15f3>", "<dev string:x15ff>", &function_d2fcf93e8127e4e1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1637>", "<dev string:x1645>", &function_d2fcf93e8127e4e1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x8af85e91, Offset: 0x6c83
    // Size: 0x1bf, Type: dev
    function private function_e2fc0640e6255680()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( quest.var_c819f91a118fbd81 )
        {
            quest.var_c819f91a118fbd81 = 0;
            level notify( #"hash_f04051e83704f39b" );
            return;
        }
        
        quest.var_c819f91a118fbd81 = 1;
        debug::sphere( quest.gathering_bones, 30, ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
        debug::line( quest.gathering_bones, quest.gathering_bones.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
        debug::sphere( quest.gathering_stone, 30, ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
        debug::line( quest.gathering_stone, quest.gathering_stone.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
        debug::sphere( quest.gathering_vial, 30, ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
        debug::line( quest.gathering_vial, quest.gathering_vial.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x1677>", "<dev string:x1692>" );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x81195124, Offset: 0x6e4a
    // Size: 0xf4, Type: dev
    function private function_3562453b832f65db()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        level.player br_quest_inventory::add_quest_item( "<dev string:x1698>" );
        level.player br_quest_inventory::add_quest_item( "<dev string:x16bd>" );
        level.player br_quest_inventory::add_quest_item( "<dev string:x16e2>" );
        
        if ( isdefined( quest.gathering_bones.loot ) )
        {
            quest.gathering_bones.loot freescriptable();
        }
        
        if ( isdefined( quest.gathering_stone.loot ) )
        {
            quest.gathering_stone.loot freescriptable();
        }
        
        if ( isdefined( quest.gathering_vial.loot ) )
        {
            quest.gathering_vial.loot freescriptable();
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x4bce4e2b, Offset: 0x6f46
    // Size: 0x2b2, Type: dev
    function private function_f09bdd6a7815e163()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( isdefined( quest.gathering_bones.loot ) )
        {
            quest.gathering_bones.loot freescriptable();
        }
        
        if ( isdefined( quest.gathering_stone.loot ) )
        {
            quest.gathering_stone.loot freescriptable();
        }
        
        if ( isdefined( quest.gathering_vial.loot ) )
        {
            quest.gathering_vial.loot freescriptable();
        }
        
        foreach ( loc in quest.bones_locs )
        {
            bones_spawn = common_item::function_bc5ff2958b71a708( loc.origin, loc.angles );
            bones_scr = common_item::items_spawnitemfromscriptable( "<dev string:x1706>", 1, bones_spawn );
        }
        
        foreach ( loc in quest.stone_locs )
        {
            stone_spawn = common_item::function_bc5ff2958b71a708( loc.origin, loc.angles );
            stone_scr = common_item::items_spawnitemfromscriptable( "<dev string:x1727>", 1, stone_spawn );
        }
        
        foreach ( loc in quest.vial_locs )
        {
            vial_spawn = common_item::function_bc5ff2958b71a708( loc.origin, loc.angles );
            vial_scr = common_item::items_spawnitemfromscriptable( "<dev string:x1748>", 1, vial_spawn );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x3c254ca3, Offset: 0x7200
    // Size: 0x133, Type: dev
    function private function_e60d08af7146cd71()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( quest.var_90cc0bc35401df9e )
        {
            quest.var_90cc0bc35401df9e = 0;
            level notify( #"hash_275f7a4c5bb974e2" );
            return;
        }
        
        quest.var_90cc0bc35401df9e = 1;
        
        foreach ( loc in quest.chanting_locs )
        {
            debug::sphere( loc.scriptable, 30, ( 0, 0, 1 ), undefined, "<dev string:x1768>" );
            debug::line( loc.scriptable, loc.scriptable.origin + ( 0, 0, 1000 ), ( 0, 0, 1 ), undefined, "<dev string:x1768>" );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0xe6af6e7f, Offset: 0x733b
    // Size: 0xb8, Type: dev
    function private function_59f5f5549983b499( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        foreach ( loc in quest.chanting_locs )
        {
            loc.scriptable.note setscriptablepartstate( "<dev string:x1782>", params[ 0 ] );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x938cce5a, Offset: 0x73fb
    // Size: 0x2e, Type: dev
    function private function_7b4035fface4f0c7()
    {
        itembundle = getscriptbundle( "<dev string:x17a5>" );
        level.player common_item::function_360e96e0447f17f9( itembundle, 2 );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x542dabb4, Offset: 0x7431
    // Size: 0x47, Type: dev
    function private function_64421aecc07d8b85( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( params[ 0 ] == "<dev string:x17cd>" )
        {
            quest function_aff264a0c5174e2();
            return;
        }
        
        quest function_d0991560c1d287cd();
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x7ad337df, Offset: 0x7480
    // Size: 0x110, Type: dev
    function private function_cf756afd5c782a87( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        foreach ( loc in quest.chanting_sigil_locs )
        {
            if ( loc.script_noteworthy == params[ 0 ] )
            {
                if ( !loc.scriptable )
                {
                    loc.scriptable = spawnscriptable( "<dev string:x17cf>", loc.origin, loc.angles );
                }
                
                loc.scriptable setscriptablepartstate( "<dev string:x17cf>", "<dev string:x17f2>" + params[ 1 ] );
                break;
            }
        }
        
        level notify( #"hash_275f7a4c5bb974e2" );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x3b934d5c, Offset: 0x7598
    // Size: 0xc5, Type: dev
    function private function_348a8667e0dba9f9()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( quest.var_b8b86c88c082daa )
        {
            quest.var_b8b86c88c082daa = 0;
            level notify( #"hash_3745da03a462d9b0" );
            return;
        }
        
        quest.var_b8b86c88c082daa = 1;
        loc = quest.offering_center_loc;
        debug::sphere( loc, 30, ( 1, 0, 0 ), undefined, "<dev string:x17fa>" );
        debug::line( loc.origin, loc.origin + ( 0, 0, 1000 ), ( 1, 0, 0 ), undefined, "<dev string:x17fa>" );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x34207d4d, Offset: 0x7665
    // Size: 0x1da, Type: dev
    function private function_5b4ee051d95d43aa()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( quest.var_26316720780b7f45 )
        {
            quest.var_26316720780b7f45 = 0;
            level notify( #"hash_3745da03a462d9b0" );
            return;
        }
        
        quest.var_26316720780b7f45 = 1;
        
        foreach ( loc in quest.offering_placement_locs )
        {
            debug::line( loc.origin, loc.origin + ( 0, 0, 1000 ), loc.chosen ? ( 0, 1, 0 ) : ( 1, 0, 0 ), undefined, "<dev string:x17fa>" );
        }
        
        foreach ( placement in quest.var_ed0928dc0b8e9a8 )
        {
            debug_origin = placement.origin + ( 0, 0, 20 );
            debug::print3d( debug_origin, placement.var_6810b82ce9302a09, ( 0, 1, 0 ), undefined, "<dev string:x17fa>" );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x27b680de, Offset: 0x7847
    // Size: 0x40, Type: dev
    function private function_726509570f1a2454()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !isdefined( quest.offering_circle ) )
        {
            quest thread function_4bfe8213be665fdb();
        }
        
        quest thread offering_spawn_weapon( 1 );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0xf6cb913c, Offset: 0x788f
    // Size: 0xd7, Type: dev
    function private function_a64400989bedad5d( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( isdefined( quest.offering_circle ) )
        {
            quest.offering_circle freescriptable();
        }
        
        switch ( params[ 0 ] )
        {
            case #"hash_704bfd310959a48d":
                if ( !isdefined( quest.debug_player_circle ) )
                {
                    quest.debug_player_circle = quest function_627af2d69218fe0b( level.player );
                }
                else
                {
                    quest.debug_player_circle setscriptablepartstate( "<dev string:x1828>", params[ 0 ] );
                }
                
                break;
            case #"hash_accfff1bdec087a":
                if ( isdefined( quest.debug_player_circle ) )
                {
                    quest function_1b9d81dcfccd4bb2( level.player );
                }
                
                break;
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xbed93921, Offset: 0x796e
    // Size: 0x55, Type: dev
    function private function_ea636a07f1b4ffd()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( isdefined( quest.debug_player_circle ) )
        {
            quest.debug_player_circle freescriptable();
        }
        
        if ( !isdefined( quest.offering_circle ) )
        {
            quest function_4bfe8213be665fdb( 0 );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xaafa3a67, Offset: 0x79cb
    // Size: 0x88, Type: dev
    function private function_5f5bd2204bf56fa()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( isdefined( quest.debug_player_circle ) )
        {
            quest.var_a311af3658c69102 = arrayremove( quest.var_a311af3658c69102, level.player.var_255e46635823be98 );
            quest.debug_player_circle freescriptable();
        }
        
        if ( isdefined( quest.offering_circle ) )
        {
            quest.offering_circle freescriptable();
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0xa7d9eda5, Offset: 0x7a5b
    // Size: 0x28e, Type: dev
    function private function_a12f5d9038c01bd3( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( params[ 0 ] == "<dev string:x186f>" )
        {
            foreach ( loc in quest.offering_placement_locs )
            {
                if ( !loc.scriptable )
                {
                    loc.scriptable = spawnscriptable( "<dev string:x1874>", loc.origin, loc.angles );
                }
                
                loc.scriptable setscriptablepartstate( "<dev string:x17f2>" + loc.script_int, "<dev string:x189e>" );
            }
            
            return;
        }
        
        if ( params[ 0 ] == "<dev string:x18a1>" )
        {
            foreach ( loc in quest.offering_placement_locs )
            {
                if ( loc.scriptable )
                {
                    loc.scriptable freescriptable();
                }
            }
            
            return;
        }
        
        foreach ( loc in quest.offering_placement_locs )
        {
            if ( loc.script_int == int( params[ 0 ] ) )
            {
                sigil_loc = loc;
                break;
            }
        }
        
        if ( !sigil_loc )
        {
            return;
        }
        
        if ( !sigil_loc.scriptable )
        {
            sigil_loc.scriptable = spawnscriptable( "<dev string:x1874>", sigil_loc.origin, sigil_loc.angles );
        }
        
        sigil_loc.scriptable setscriptablepartstate( "<dev string:x17f2>" + sigil_loc.script_int, "<dev string:x189e>" );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0xe1e183e6, Offset: 0x7cf1
    // Size: 0x18a, Type: dev
    function private function_c3215862e313bd0c( params )
    {
        cameracenter = level.player getvieworigin();
        cameraorientation = level.player getplayerangles();
        cameraforward = anglestoforward( cameraorientation );
        cameratraceend = cameracenter + cameraforward * 1000;
        ignorearray = level.player;
        contentarray = trace::create_itemclip_contents();
        deploytrace = trace::ray_trace( cameracenter, cameratraceend, ignorearray, contentarray, 0, 0, 1 );
        deploypos = deploytrace[ "<dev string:x18a6>" ];
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !quest.offering_active )
        {
            return;
        }
        
        var_2318ee398b583154 = { #origin:deploypos };
        within_range = distancesquared( var_2318ee398b583154.origin, quest.offering_center_loc.origin ) < quest.offering_circle_radius_sq;
        
        if ( !within_range )
        {
            iprintlnbold( "<dev string:x18af>" );
            return;
        }
        
        for ( i = 0; i < int( params[ 0 ] ) ; i++ )
        {
            quest thread function_e202f5a7f8d0e89f( var_2318ee398b583154, quest.var_628441f14963c43f.down_pos.origin + ( 0, 0, 30 ) );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x293f5482, Offset: 0x7e83
    // Size: 0x170, Type: dev
    function private function_e444365fd360517e( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !isdefined( quest.offering_placement_locs[ 0 ].beam_ent ) )
        {
            quest function_a501e333e2d626e5();
        }
        
        foreach ( loc in quest.offering_placement_locs )
        {
            if ( loc.script_int == int( params[ 0 ] ) )
            {
                var_93c3e7bb3f019adf = loc;
                break;
            }
        }
        
        if ( !var_93c3e7bb3f019adf )
        {
            return;
        }
        
        var_93c3e7bb3f019adf.beam = function_fc8c9b9ac6af4fa8( var_93c3e7bb3f019adf.beam_ent, var_93c3e7bb3f019adf.linked_loc.beam_ent );
        var_93c3e7bb3f019adf.beam_ent setscriptablepartstate( "<dev string:x18d4>", "<dev string:x18f5>" );
        
        if ( !var_93c3e7bb3f019adf.linked_loc.beam )
        {
            var_93c3e7bb3f019adf.linked_loc.beam_ent setscriptablepartstate( "<dev string:x18d4>", "<dev string:x1905>" );
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xdf87860d, Offset: 0x7ffb
    // Size: 0xad, Type: dev
    function private function_62036c4794310d6a()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        foreach ( loc in quest.offering_placement_locs )
        {
            if ( isdefined( loc.beam ) )
            {
                loc.beam function_f69b529e6ce47f11();
            }
        }
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x851d6e48, Offset: 0x80b0
    // Size: 0x36, Type: dev
    function private function_38f94a6c9d06ca0b( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        quest awakening_splash( int( params[ 0 ] ) );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xb4dc5c62, Offset: 0x80ee
    // Size: 0xc, Type: dev
    function private function_fc12b5020369d6eb()
    {
        thread function_3492ce8518c885e2();
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x1f68b987, Offset: 0x8102
    // Size: 0x41, Type: dev
    function private function_764b7cdb4eff47b5( params )
    {
        thread function_3c44a62aafc69c3e( int( params[ 0 ] ) );
        iprintlnbold( "<dev string:x1914>" + ( params[ 0 ] == "<dev string:x192d>" ? "<dev string:x192f>" : "<dev string:x1932>" ) );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x4da70f06, Offset: 0x814b
    // Size: 0x5a, Type: dev
    function private function_7f74eeb0bed56b4e( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        quest thread function_ad53344a99529565( int( params[ 0 ] ) );
        iprintlnbold( "<dev string:x1936>" + ( params[ 0 ] == "<dev string:x192d>" ? "<dev string:x192f>" : "<dev string:x1932>" ) );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0xd86f49a4, Offset: 0x81ad
    // Size: 0x5a, Type: dev
    function private function_bf7d64fadfd3e229( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        quest thread function_2f1c5c84a8466efa( int( params[ 0 ] ) );
        iprintlnbold( "<dev string:x194f>" + ( params[ 0 ] == "<dev string:x192d>" ? "<dev string:x192f>" : "<dev string:x1932>" ) );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x52f47d33, Offset: 0x820f
    // Size: 0x25, Type: dev
    function private debug_awakening_start()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        quest awakening_start();
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0x2636d273, Offset: 0x823c
    // Size: 0x124, Type: dev
    function private function_95bbb87bcfde35bb()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !isdefined( quest.var_bf74d1bc18c59e15 ) )
        {
            quest.var_bf74d1bc18c59e15 = -1;
        }
        
        quest.var_bf74d1bc18c59e15++;
        
        if ( quest.var_bf74d1bc18c59e15 == quest.gathering_locs.size )
        {
            quest.var_bf74d1bc18c59e15 = 0;
        }
        
        item = quest.gathering_locs[ quest.var_bf74d1bc18c59e15 ];
        nav_origin = getclosestpointonnavmesh( item.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], item.origin[ 2 ] );
        angles = vectortoangles( item.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - item.origin ) * 50;
        level.player setorigin( origin );
        level.player setplayerangles( angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xf0ff5184, Offset: 0x8368
    // Size: 0x124, Type: dev
    function private function_f1d9dded661be639()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !isdefined( quest.var_65680e12eee7a8ff ) )
        {
            quest.var_65680e12eee7a8ff = -1;
        }
        
        quest.var_65680e12eee7a8ff++;
        
        if ( quest.var_65680e12eee7a8ff == quest.chanting_locs.size )
        {
            quest.var_65680e12eee7a8ff = 0;
        }
        
        record_player = quest.chanting_locs[ quest.var_65680e12eee7a8ff ];
        nav_origin = getclosestpointonnavmesh( record_player.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], record_player.origin[ 2 ] );
        angles = vectortoangles( record_player.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - record_player.origin ) * 50;
        level.player setorigin( origin );
        level.player setplayerangles( angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xa062ffaf, Offset: 0x8494
    // Size: 0x124, Type: dev
    function private function_2c8aa09a1583930c()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        
        if ( !isdefined( quest.var_36d7535c76d46e9c ) )
        {
            quest.var_36d7535c76d46e9c = -1;
        }
        
        quest.var_36d7535c76d46e9c++;
        
        if ( quest.var_36d7535c76d46e9c == quest.var_9bcf156b09ff3397.size )
        {
            quest.var_36d7535c76d46e9c = 0;
        }
        
        item = quest.var_9bcf156b09ff3397[ quest.var_36d7535c76d46e9c ];
        nav_origin = getclosestpointonnavmesh( item.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], item.origin[ 2 ] );
        angles = vectortoangles( item.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - item.origin ) * 50;
        level.player setorigin( origin );
        level.player setplayerangles( angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xb391add3, Offset: 0x85c0
    // Size: 0x66, Type: dev
    function private function_d34a0de737971743()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        level.player setorigin( quest.offering_placement_locs[ 0 ].origin );
        level.player setplayerangles( quest.offering_placement_locs[ 0 ].angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xe61989cc, Offset: 0x862e
    // Size: 0xdb, Type: dev
    function private function_8564515a4d6e7e1d()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        nav_origin = getclosestpointonnavmesh( quest.clue_sheet_loc.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], quest.clue_sheet_loc.origin[ 2 ] );
        angles = vectortoangles( quest.clue_sheet_loc.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - quest.clue_sheet_loc.origin ) * 50;
        level.player setorigin( origin );
        level.player setplayerangles( angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 0, eflags: 0x4
    // Checksum 0xce8d80d7, Offset: 0x8711
    // Size: 0xdb, Type: dev
    function private function_e9e347698cb57670()
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        nav_origin = getclosestpointonnavmesh( quest.clue_projector_loc.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], quest.clue_projector_loc.origin[ 2 ] );
        angles = vectortoangles( quest.clue_projector_loc.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - quest.clue_projector_loc.origin ) * 50;
        level.player setorigin( origin );
        level.player setplayerangles( angles );
    }

    // Namespace namespace_341ed135e9592d8
    // Params 1, eflags: 0x4
    // Checksum 0x4640efd5, Offset: 0x87f4
    // Size: 0x3d, Type: dev
    function private function_d2fcf93e8127e4e1( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x143>" );
        quest.clue_projection_map setscriptablepartstate( params[ 0 ], params[ 1 ] );
    }

#/
