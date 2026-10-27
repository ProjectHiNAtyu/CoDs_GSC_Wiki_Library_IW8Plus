// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_big_mouth.gsc  (hash_5cdd368b8be4e967.gscc) (size: 12939 Bytes / 0x328b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd286ad8c (3532041612)
// size ...... 12939 (0x328b)
// includes .. 17  (offset: 0x2fdf)
// strings ... 35  (offset: 0x3067)
// dev strs .. 1   (offset: 0x327f)
// exports ... 38  (offset: 0x1d5b)
// cseg ...... 0x299 + 0x1ac2 (0x1d5b)
// imports ... 101 (offset: 0x234b)
// animtree1 . 0   (offset: 0x328b)
// animtree2 . 0   (offset: 0x328b)
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_charm;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\brainrot;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\currency;
#using scripts\mp\damage;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_ee_big_mouth;

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x5
// Checksum 0xd4fbbe19, Offset: 0x2b7
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_c40e2c20cc576be7", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xd5179e8b, Offset: 0x2e4
// Size: 0x180
function private pre_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_a20adc2fd994aec6", 1 ) )
    {
        return;
    }
    
    level.ee_big_mouth = { #var_11c47092d96cb852:getdvarint( @"hash_e8ca6ed336efd021", 2 ), #max_brainrot:getdvarint( @"hash_e90f9f50947d5cc7", 10 ), #var_c02cbcc6197d870c:getdvarint( @"hash_4f5d2271f653bea6", 2000 ), #trap_cooldown_duration:getdvarfloat( @"hash_d1abda8f5ac084a", 60 ), #brainrot_radius:getdvarint( @"hash_ad9ce3ae3068e663", 300 ), #attract_duration:getdvarfloat( @"hash_8147c1505005e9bf", 15 ), #var_c81a917552049716:getdvarint( @"hash_76e3cdabe2194319", 1000 ) };
    utility::registersharedfunc( #"hash_86f4e49ae129fde9", #"hash_7467f5003c091d84", &function_7907bfc8f77a06ca );
    zm_quest::register_quest_step( #"hash_c40e2c20cc576be7", #"pick_up_bass", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_c40e2c20cc576be7", #"hash_3e98ccb8501c25c9", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_c40e2c20cc576be7", #"mount_bass", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xb68c23e7, Offset: 0x46c
// Size: 0x81
function private post_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_a20adc2fd994aec6", 1 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_751860b2594aec78();
    level thread function_3476a0d48bdb2b52();
    level thread function_57eb79c94880c514();
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_c40e2c20cc576be7" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0xae93ed38, Offset: 0x4f5
// Size: 0x31
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( #"hash_9527c2e2202590a1" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x6dd69969, Offset: 0x52e
// Size: 0x42
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_9527c2e2202590a1" );
        zm_sat_locust_util::function_a70056d3a99eace5( #"big_mouth_bass" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0x1aa36feb, Offset: 0x578
// Size: 0xae
function private function_751860b2594aec78()
{
    utility::flag_wait_all( "scriptables_ready" );
    loc = utility::getstruct( "william_loc" );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:loc.angles, #spawnorigin:loc.origin, #asset:"zmloot_sat_locust_quest_william" };
    item = zm_sat_locust_util::spawn_quest_item( params );
    level callback::add( "quest_item_used", &function_c4ba2bc0a7b024bd );
    zm_sat_locust_util::function_295a36ef38f5acae( #"big_mouth_bass", item );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x10561149, Offset: 0x62e
// Size: 0x75
function private function_c4ba2bc0a7b024bd( params )
{
    if ( params.bundle.scriptable != %"zmloot_sat_locust_quest_william" )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    params.player function_13915f3e921f0f49();
    utility::flag_set( #"hash_9527c2e2202590a1" );
    level callback::remove( "quest_item_used", &function_c4ba2bc0a7b024bd );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xce5c1005, Offset: 0x6ab
// Size: 0x1e
function private function_13915f3e921f0f49()
{
    wait 2;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_886461537bf2ee65", #"bc_flavor_player_positive" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x379aa7ab, Offset: 0x6d1
// Size: 0x31
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( #"hash_9527bfe220258b88" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0xb22b7c74, Offset: 0x70a
// Size: 0x4e
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_9527bfe220258b88" );
        utility::flag_set( "picked_up_william_from_tedd_task" );
    }
    
    zm_sat_locust_util::function_a70056d3a99eace5( #"hash_6ee534811166ea48" );
    profilestop();
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xedb21478, Offset: 0x760
// Size: 0x14
function private function_3476a0d48bdb2b52()
{
    level callback::add( "teddtask_begin", &function_d9381e6572bc2ff7 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0xb8afac9, Offset: 0x77c
// Size: 0x12c
function private function_d9381e6572bc2ff7( params )
{
    if ( !utility::flag( #"hash_9527c2e2202590a1" ) )
    {
        return;
    }
    
    model = params.s_active_task.mdl_teddtasks;
    var_25e5121dcacdffa4 = model.origin + anglestoleft( model.angles ) * 10 + anglestoup( model.angles ) * 25 + anglestoforward( model.angles ) * -5;
    var_82fb01db4c58032 = model.angles - ( 0, 0, 90 );
    model.fish_scriptable = spawnscriptable( "sat_zm_prop_william", var_25e5121dcacdffa4, var_82fb01db4c58032 );
    model.fish_scriptable setscriptablepartstate( "usable", "enabled" );
    interaction::register_scriptable_interact( model.fish_scriptable, &function_a628e5cbd023bc55, undefined, undefined, &function_5b47658b70bff0c9 );
    model.fish_scriptable.parent = model;
    model.fish_scriptable thread function_da62f3590161c382();
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0x9e4f8c30, Offset: 0x8b0
// Size: 0x21
function private function_da62f3590161c382()
{
    level endon( #"game_ended" );
    level waittill( #"task_ended" );
    self freescriptable();
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0xca7ad683, Offset: 0x8d9
// Size: 0xe7
function private function_a628e5cbd023bc55( player )
{
    if ( !utility::flag_exist( "picked_up_william_from_tedd_task" ) )
    {
        utility::flag_set( "picked_up_william_from_tedd_task" );
    }
    
    if ( !utility::flag( "picked_up_william_from_tedd_task" ) )
    {
        return;
    }
    
    self setscriptablepartstate( "sat_zm_prop_william", "enabled" );
    self setscriptablepartstate( "usable", "disabled" );
    self setscriptablepartstate( "fx", "placed" );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self.parent setcandamage( 1 );
    self.parent.health = 9999;
    self.parent thread damage::monitordamage( self.parent.health, "hitequip", undefined, &function_33e6e3fa0bcae99c, 0, undefined, undefined, 0 );
    utility::flag_clear( "picked_up_william_from_tedd_task" );
    level callback::add( "tedd_task_end", &function_1c99984e29709cb2 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x8ca1b37a, Offset: 0x9c8
// Size: 0x36
function private function_5b47658b70bff0c9( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x33a74210, Offset: 0xa07
// Size: 0x8c, Type: bool
function private function_33e6e3fa0bcae99c( params )
{
    if ( !isdefined( self.fish_scriptable ) || self.fish_scriptable getscriptablepartstate( "sat_zm_prop_william" ) != "enabled" )
    {
        return false;
    }
    
    if ( params.meansofdeath == "MOD_IMPACT" && issubstr( params.inflictor.equipmentref, "shockstick" ) && !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_6ee534811166ea48" ) )
    {
        thread function_a288f7c1c047c905( params );
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x27fa1170, Offset: 0xa9c
// Size: 0xa2
function private function_a288f7c1c047c905( params )
{
    self setcandamage( 0 );
    params.inflictor utility::delaycall( level.framedurationseconds, &setscriptablepartstate, #"electric", #"active", 0 );
    params.inflictor utility::delaycall( level.framedurationseconds, &setscriptablepartstate, #"detonate", #"detonate", 0 );
    params.inflictor thread shock_stick::function_1d426c8b1b9484bb();
    self setscriptablepartstate( "big_mouth_ee_shocked", "on" );
    self.malfunctioning = 1;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0xe83764d3, Offset: 0xb46
// Size: 0x287
function private function_1c99984e29709cb2( params )
{
    if ( !isdefined( level.var_a3eb428773fa9129 ) || !isdefined( level.var_a3eb428773fa9129.origin ) || !isdefined( level.var_a3eb428773fa9129.angles ) )
    {
        return;
    }
    
    spawn_origin = level.var_a3eb428773fa9129.origin + anglestoup( level.var_a3eb428773fa9129.angles ) * 40;
    spawn_angles = level.var_a3eb428773fa9129.angles;
    right_offset = anglestoright( level.var_a3eb428773fa9129.angles );
    end_origin = level.var_a3eb428773fa9129.origin + anglestoforward( level.var_a3eb428773fa9129.angles ) * 60;
    malfunctioning = level.var_a3eb428773fa9129.mdl_teddtasks.malfunctioning;
    level.var_a3eb428773fa9129.mdl_teddtasks setscriptablepartstate( "big_mouth_ee_shocked", "off" );
    wait 4;
    spawn_params = { #spawntype:#"spawn_to_pos_from_pos", #toangles:spawn_angles, #fromorigin:spawn_origin, #toorigin:end_origin + right_offset * 10, #asset:%"zmloot_sat_locust_quest_william" };
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_3e378b4045058047", item );
    level callback::add( "quest_item_used", &function_d5fe7ad50b88b140 );
    
    if ( params.mastery_achieved && malfunctioning )
    {
        spawn_params = { #spawntype:#"spawn_to_pos_from_pos", #toangles:spawn_angles, #fromorigin:spawn_origin, #toorigin:end_origin - right_offset * 10, #asset:%"zmloot_sat_locust_quest_thurgood" };
        item = zm_sat_locust_util::spawn_quest_item( spawn_params );
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_6ee534811166ea48", item );
        level callback::add( "quest_item_used", &function_90a910c6715e7c77 );
        level callback::remove( "teddtask_begin", &function_d9381e6572bc2ff7 );
    }
    
    level callback::remove( "tedd_task_end", &function_1c99984e29709cb2 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x4b9485bc, Offset: 0xdd5
// Size: 0x5f
function private function_d5fe7ad50b88b140( params )
{
    if ( params.bundle.scriptable != %"zmloot_sat_locust_quest_william" )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    utility::flag_set( "picked_up_william_from_tedd_task" );
    level callback::remove( "quest_item_used", &function_d5fe7ad50b88b140 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0xa8b93cca, Offset: 0xe3c
// Size: 0x75
function private function_90a910c6715e7c77( params )
{
    if ( params.bundle.scriptable != %"zmloot_sat_locust_quest_thurgood" )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    utility::flag_set( #"hash_9527bfe220258b88" );
    params.player thread function_8bad22ab3d4de6ff();
    level callback::remove( "quest_item_used", &function_90a910c6715e7c77 );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0x54adb129, Offset: 0xeb9
// Size: 0x1e
function private function_8bad22ab3d4de6ff()
{
    wait 1;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_528567a14ffd5cc6", #"bc_flavor_player_positive" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x2f1c215b, Offset: 0xedf
// Size: 0x65
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    trap = zm_sat_locust_util::get_quest_reference( #"hash_8acd2d75861c4172" );
    trap setscriptablepartstate( #"usable", #"enabled" );
    utility::flag_wait( #"hash_9527c0e220258d3b" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x2996ac0, Offset: 0xf4c
// Size: 0xc6
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    trap = zm_sat_locust_util::get_quest_reference( #"hash_8acd2d75861c4172" );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( #"hash_9527c0e220258d3b" );
        trap setscriptablepartstate( #"sat_zm_prop_william_trap", #"enabled" );
        trap setscriptablepartstate( #"usable", #"enabled" );
        trap setscriptablepartstate( #"ping", #"enabled" );
        trap.dialog_ent thread function_c711c89c6fc28018();
    }
    
    trap interaction::set_interact_use_callback( &function_91a2a6c709560d1e );
    trap interaction::set_interact_hint_callback( &trap_hint );
    profilestop();
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xb0206be, Offset: 0x101a
// Size: 0xd2
function private function_57eb79c94880c514()
{
    utility::flag_wait( "scriptables_ready" );
    trap_loc = utility::getstruct( "william_mount" );
    trap = spawnscriptable( %"sat_zm_prop_william_trap", trap_loc.origin, trap_loc.angles );
    interaction::register_scriptable_interact( trap, &function_b42488b3108612d7, undefined, undefined, &function_8345c0c22bcf764b );
    trap.dialog_ent = utility::spawn_tag_origin( trap.origin, trap.angles );
    trap.dialog_ent.team = "allies";
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_8acd2d75861c4172", trap );
    level callback::add( #"on_ai_killed", &function_decd741b757310ca );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x4019609, Offset: 0x10f4
// Size: 0xd8
function private function_decd741b757310ca( params )
{
    attacker = params.eattacker;
    
    if ( isdefined( attacker ) && isdefined( attacker.var_bd22ba6c600a23a3 ) && attacker.var_c6e8f7a48520dc46 )
    {
        trap = zm_sat_locust_util::get_quest_reference( #"hash_8acd2d75861c4172" );
        
        if ( !trap.var_86cf269985455fb1 )
        {
            trap.var_86cf269985455fb1 = 1;
            attacker.var_bd22ba6c600a23a3 thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_610330c821d05ff8", #"bc_flavor_player_positive" );
        }
        
        attacker.big_mouth_kills++;
        
        if ( attacker.big_mouth_kills >= level.ee_big_mouth.var_11c47092d96cb852 )
        {
            attacker brainrot::function_8259e310173767bd();
        }
    }
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0x7c8ebd4d, Offset: 0x11d4
// Size: 0x10
function private function_7907bfc8f77a06ca()
{
    self.var_e797f68de73ece4e = "_big_mouth";
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x4af23070, Offset: 0x11ec
// Size: 0x108
function private function_b42488b3108612d7( player )
{
    if ( !utility::flag( "picked_up_william_from_tedd_task" ) )
    {
        return;
    }
    
    params = { #hud_description:&"zm_sat_locust/mounting_tedd", #use_object:self, #hold_time:3, #craft_reason:#"hash_765a12a7527099ad" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    self notify( #"search_complete" );
    
    if ( result )
    {
        self setscriptablepartstate( #"sat_zm_prop_william_trap", #"enabled" );
        self setscriptablepartstate( #"ping", #"enabled" );
        thread big_mouth_trap_activate( player );
        player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_artifact_1" );
        utility::flag_set( #"hash_9527c0e220258d3b" );
        return;
    }
    
    wait 1;
    self setscriptablepartstate( "usable", "enabled" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0x3c92bb59, Offset: 0x12fc
// Size: 0x36
function private function_8345c0c22bcf764b( interact, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x89db60a7, Offset: 0x133b
// Size: 0x93
function private function_91a2a6c709560d1e( player )
{
    if ( utility::flag( "zm_vote_active" ) )
    {
        return;
    }
    
    if ( level.ee_big_mouth.activated || level.ee_big_mouth.on_cooldown )
    {
        return;
    }
    
    if ( !player currency::attempt_purchase( #"essence", level.ee_big_mouth.var_c02cbcc6197d870c, 1 ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    thread big_mouth_trap_activate( player );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x815f3d79, Offset: 0x13d6
// Size: 0x174
function private big_mouth_trap_activate( player )
{
    level endon( #"game_ended" );
    level.ee_big_mouth.activated = 1;
    
    if ( self getscriptablepartstate( #"animation" ) == "nudge" )
    {
        thread function_76ea1bc5eb10d537();
    }
    
    self setscriptablepartstate( #"fx", #"active" );
    self setscriptablepartstate( #"audio", #"song" );
    thread function_35461c026ce30e47();
    self.attractor = zombie_attractor_manager::add_attractor( self, 2, level.ee_big_mouth.var_c81a917552049716, 0, undefined, &function_91bea590dddfe0b0 );
    wait level.ee_big_mouth.attract_duration;
    zombie_attractor_manager::remove_attractor( self );
    thread function_f53ef33f658943fe( player );
    wait 25;
    level.ee_big_mouth.activated = 0;
    self.dialog_ent notify( #"enable_idle" );
    self setscriptablepartstate( #"fx", #"off" );
    self setscriptablepartstate( #"audio", #"off" );
    thread function_d89052547f213a7f();
    
    if ( !self.var_86cf269985455fb1 && isalive( player ) )
    {
        self.var_86cf269985455fb1 = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_610330c821d05ff8", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0xcf90b15, Offset: 0x1552
// Size: 0x4f, Type: bool
function private function_91bea590dddfe0b0( attractor, zombie )
{
    if ( self.subclass == "zombie_base" || self.subclass == "zombie_base_luna" )
    {
        zombie.var_e797f68de73ece4e = "_big_mouth";
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 1, eflags: 0x4
// Checksum 0x3c257c96, Offset: 0x15aa
// Size: 0x33e
function private function_f53ef33f658943fe( player )
{
    player_team = player.team;
    var_3e5df7c437647749 = getaiarrayinradius( self.origin, level.ee_big_mouth.brainrot_radius, zm_utility::get_zombie_team() );
    self setscriptablepartstate( #"blast", #"on" );
    
    foreach ( zombie in var_3e5df7c437647749 )
    {
        zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
    }
    
    var_98a6b249fd70f37e = getaiarrayinradius( self.origin, level.ee_big_mouth.var_c81a917552049716, zm_utility::get_zombie_team() );
    
    foreach ( zombie in var_98a6b249fd70f37e )
    {
        if ( zombie.var_e797f68de73ece4e == "_big_mouth" )
        {
            zombie.var_e797f68de73ece4e = undefined;
        }
    }
    
    var_5f7ae2b5f87aaea6 = brainrot::get_brainrot_time() + 5;
    brainrotted_zombies = [];
    
    foreach ( zombie in var_3e5df7c437647749 )
    {
        if ( zombie brainrot::function_49ffc995621dbc95() )
        {
            zombie effect_charm::charm( var_5f7ae2b5f87aaea6, player, &brainrot::function_8259e310173767bd, "toxic" );
            zombie brainrot::function_a8dd3ca93248e895( player, undefined, 1 );
            zombie.var_c6e8f7a48520dc46 = 1;
            brainrotted_zombies[ brainrotted_zombies.size ] = zombie;
            zombie.big_mouth_kills = 0;
        }
        
        if ( brainrotted_zombies.size > level.ee_big_mouth.max_brainrot )
        {
            break;
        }
    }
    
    waitframe();
    
    if ( player_team )
    {
        var_b1bd125687531701 = [];
        
        foreach ( zombie in brainrotted_zombies )
        {
            if ( zombie && isalive( zombie ) && zombie.var_c6e8f7a48520dc46 )
            {
                var_b1bd125687531701[ var_b1bd125687531701.size ] = zombie;
            }
        }
        
        level notify( #"highvis_reload_outline", player_team, var_b1bd125687531701, 1 );
    }
    
    if ( !self.looping_dialog )
    {
        self.dialog_ent thread function_c711c89c6fc28018();
    }
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0x3b76ee4b, Offset: 0x18f0
// Size: 0x65
function private function_d89052547f213a7f()
{
    level endon( #"game_ended" );
    level.ee_big_mouth.on_cooldown = 1;
    wait level.ee_big_mouth.trap_cooldown_duration;
    self setscriptablepartstate( #"usable", #"enabled" );
    level.ee_big_mouth.on_cooldown = 0;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 2, eflags: 0x4
// Checksum 0xba46546, Offset: 0x195d
// Size: 0x1bd
function private trap_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled || interact.var_94d1ab5da995e573 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    hintstring_obj = { #interactable:1, #aux_text:"", #icon_text_value:level.ee_big_mouth.var_c02cbcc6197d870c, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"ui_mp_br_icon_fish", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #description:&"zm_sat_locust/big_mouth_desc", #title:&"zm_sat_locust/big_mouth_title", #type:"HINT_BUTTON" };
    
    if ( !player currency::can_afford( #"essence", level.ee_big_mouth.var_c02cbcc6197d870c ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hintstring_obj.interactable = 0;
    }
    
    if ( level.ee_big_mouth.activated )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/TRAP_ACTIVATE_HINT";
        hintstring_obj.interactable = 0;
    }
    
    if ( level.ee_big_mouth.on_cooldown )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT";
        hintstring_obj.interactable = 0;
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0xc
// Checksum 0x211dc87f, Offset: 0x1b23
// Size: 0x87
function private function_76ea1bc5eb10d537()
{
    self notify( #"hash_8210685455eab57" );
    self endon( #"hash_8210685455eab57" );
    level endon( #"game_ended" );
    self.var_4148fedecfbeb55b = -1;
    start_time = gettime();
    
    while ( self getscriptablepartstate( #"animation" ) == "nudge" )
    {
        waitframe();
    }
    
    self notify( #"nudge_finished" );
    end_time = gettime();
    self.var_4148fedecfbeb55b = ( end_time - start_time ) / 1000;
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0, eflags: 0x4
// Checksum 0xe7964677, Offset: 0x1bb2
// Size: 0xf8
function private function_35461c026ce30e47()
{
    level endon( #"game_ended" );
    var_17e53713cad723bb = 0;
    
    if ( self.var_4148fedecfbeb55b == -1 )
    {
        self waittill( #"nudge_finished" );
        var_17e53713cad723bb = self.var_4148fedecfbeb55b;
        self.var_4148fedecfbeb55b = undefined;
    }
    
    total_wait_time = level.ee_big_mouth.attract_duration + 25 - var_17e53713cad723bb;
    singing_anim_duration = 11.333;
    var_6a96556f4de3abf4 = 4;
    
    while ( total_wait_time >= singing_anim_duration )
    {
        total_wait_time -= singing_anim_duration;
        self setscriptablepartstate( #"animation", #"active" );
        wait singing_anim_duration;
    }
    
    while ( total_wait_time >= var_6a96556f4de3abf4 )
    {
        total_wait_time -= var_6a96556f4de3abf4;
        self setscriptablepartstate( #"animation", #"nudge" );
        wait var_6a96556f4de3abf4;
    }
    
    self setscriptablepartstate( #"animation", #"inactive" );
}

// Namespace zm_sat_locust_ee_big_mouth
// Params 0
// Checksum 0x142cd5dd, Offset: 0x1cb2
// Size: 0xa9
function function_c711c89c6fc28018()
{
    level endon( #"game_ended" );
    trap = zm_sat_locust_util::get_quest_reference( #"hash_8acd2d75861c4172" );
    trap.looping_dialog = 1;
    
    while ( true )
    {
        if ( level.ee_big_mouth.activated )
        {
            self waittill( #"enable_idle" );
            wait 3;
        }
        
        thread dialogue::say( "dx_zm_lesd_estg_slvn_lesdbmsid" );
        trap setscriptablepartstate( #"animation", #"nudge" );
        wait 5;
        trap setscriptablepartstate( #"animation", #"inactive" );
        wait 25;
    }
}

