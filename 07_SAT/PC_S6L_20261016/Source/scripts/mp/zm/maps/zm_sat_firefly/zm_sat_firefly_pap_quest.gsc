// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_pap_quest.gsc  (hash_74f37bb9f65747ec.gscc) (size: 79081 Bytes / 0x134e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15dacf33 (366661427)
// size ...... 79081 (0x134e9)
// includes .. 32  (offset: 0x12155)
// strings ... 212 (offset: 0x12255)
// dev strs .. 40  (offset: 0x132e5)
// exports ... 180 (offset: 0xcae1)
// cseg ...... 0x11d4 + 0xb90d (0xcae1)
// imports ... 412 (offset: 0xe701)
// animtree1 . 0   (offset: 0x134e9)
// animtree2 . 0   (offset: 0x134e9)
#using script_2345a75c9a066520;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\doorbuy;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_pap_quest;

// Namespace zm_sat_firefly_pap_quest
// Params 0
// Checksum 0xf6bd99cd, Offset: 0x11f2
// Size: 0x3ac
function init()
{
    level thread function_277e591e97d5d692();
    level._effect[ "generator_blast" ] = loadfxasset( "vfx_t10_levels_zm_quartz_clearing_blast" );
    
    if ( !( isusingmatchrulesdata() && getmatchrulesdata( "zmData", "papQuest" ) ) )
    {
        if ( utility::issharedfuncdefined( #"firefly_pap_quest", #"hash_c87b411e7826157c" ) )
        {
            level thread utility::callsharedfunc( #"firefly_pap_quest", #"hash_c87b411e7826157c" );
            return;
        }
        
        level thread function_b354eae9b61a5138();
        return;
    }
    
    level utility::registersharedfunc( #"veh_pluto", #"hash_db077913b65c7469", &on_pluto_spawned );
    level utility::registersharedfunc( #"firefly_pap_quest", #"hash_dd921d8e3237e83a", &function_5c8cae29c3778e59 );
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_script_quest_pap_cs_completed" );
    level.pap_quest = zm_quest::get_quest( #"firefly_pap_quest" );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"find_tedd", &function_ea341c314dc1aadc, &function_43ef8d1264a156d3 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"grab_tedd", &function_ea341f314dc1b175, &function_43ef8e1264a15906 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_173b90792d621e7b", &function_ea341e314dc1af42, &function_43ef8f1264a15b39 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_58b1560ac31a150f", &function_ea3419314dc1a443, &function_43ef901264a15d6c );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_58b1570ac31a16c2", &function_ea3418314dc1a210, &function_43ef911264a15f9f );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_77439cafa364fc99", &function_ea341b314dc1a8a9, &function_43ef921264a161d2 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_cadac07a2223c10b", &function_ea341a314dc1a676, &function_43ef931264a16405 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_5e0384efb03fb23d", &function_ea3424314dc1bc74, &function_43ef951264a1686b );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_9d836a50954dd2a5", &function_d244ed6e00eae737, &function_92a21734ed21306 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_5d0575e20f0d331b", &function_d244ee6e00eae96a, &function_92a20734ed210d3 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_75327ace4466fad5", &function_d244ef6e00eaeb9d, &function_92a1f734ed20ea0 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"flip_power_switch_sunken", &function_d244e96e00eade6b, &function_92a25734ed21bd2 );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_b17f76ec152a269b", &function_d244eb6e00eae2d1, &function_92a23734ed2176c );
    zm_quest::register_quest_step( #"firefly_pap_quest", #"hash_173b91792d62202e", &function_d244e46e00ead36c, &function_92a2a734ed226d1 );
    level.var_759d027eca7a10d1 = zm_quest::get_quest( #"hash_9deee04807c7b80c" );
    zm_quest::register_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation_setup", &function_6a64790c2f45edb3, &function_5633a9780ace8c72 );
    zm_quest::register_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation", &function_6a647a0c2f45efe6, &function_5633a8780ace8a3f );
    zm_quest::register_quest_step( #"hash_9deee04807c7b80c", #"flip_power_switch", &function_6a647b0c2f45f219, &function_5633a7780ace880c );
    level thread pap_setup();
    level callback::add( #"player_connect", &on_player_connect );
    
    if ( level.pap_quest.completed == 0 )
    {
        level val::set( "task_firefly_pap", "task_logic_activate", 0 );
    }
    
    /#
        init_pap_debug();
    #/
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xaa374e7b, Offset: 0x15a6
// Size: 0x1a6
function private function_277e591e97d5d692()
{
    level endon( #"game_ended" );
    level utility::flag_set( "power_on" );
    level utility::flag_wait( "open_sesame" );
    
    if ( getdvarint( @"hash_5f0836c6f2287300", 1 ) )
    {
        level function_4f30728f9d7763b8();
        
        foreach ( step in level.pap_quest.steps )
        {
            level zm_quest::function_e65609834444650c( step, 0 );
        }
        
        level thread namespace_5ce9a33f888d9be5::function_d897dbe501977ee4();
        level thread zm_sat_firefly_script_garage::function_4aaca8864b49d3b7();
    }
    else if ( level.pap_quest )
    {
        foreach ( step in level.pap_quest.steps )
        {
            level zm_quest::function_e65609834444650c( step, 0 );
        }
    }
    
    level utility::flag_set( "power_on1" );
    level utility::flag_set( "power_on2" );
    level utility::flag_set( "power_on3" );
    activateworldevent( "we_lgt_power_on_ashwood" );
    activateworldevent( "we_lgt_power_on_cabin" );
    activateworldevent( "we_lgt_power_on_farm" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x23b34ed4, Offset: 0x1754
// Size: 0x93
function private function_4f30728f9d7763b8()
{
    foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
    {
        var_55a3da08bd6a9a23 function_20189923a1c8d801( 1 );
        var_55a3da08bd6a9a23 activate_generator( undefined, 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x54b1fe79, Offset: 0x17ef
// Size: 0x6e
function private pap_setup()
{
    level endon( #"game_ended" );
    level.var_1f0b531f139f7db0 = 1;
    level init_pap_assets();
    level callback::add( #"player_connect", &on_player_connect_pap );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"firefly_pap_quest" );
    level thread zm_quest::start_quest( #"hash_9deee04807c7b80c" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x4261cab9, Offset: 0x1865
// Size: 0x4c
function private init_pap_assets()
{
    level.pap_quest.var_fce0c3e197569778 = [];
    level.pap_quest.var_a3e31c6af9c21d0c = [];
    level thread function_cc27ea6e90481be();
    level thread function_3dda3630e8e4bdb5();
    level thread setup_aether_generator_assets();
    level thread setup_power_switch_assets();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xc80f7eb0, Offset: 0x18b9
// Size: 0x1f6
function private function_cc27ea6e90481be()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "common_items_init" );
    level utility::flag_wait( "items_database_init" );
    var_7e65eb02bfdf2f8a = utility::getstruct( "pap_drain_grate", "targetname" );
    level.pap_quest.var_b95b6a86019e33dc = spawnscriptable( %"zm_sat_firefly_pap_sewer_grate", var_7e65eb02bfdf2f8a.origin, var_7e65eb02bfdf2f8a.angles );
    s_tedd = utility::getstruct( "tedd_head_spawn", "targetname" );
    itembundle = getscriptbundle( %"hash_77e9d6437336e65b" );
    spawnoptions = common_item::function_bc5ff2958b71a708( s_tedd.origin, s_tedd.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    positioningdata = common_item::function_b4bee4333994e45a( s_tedd.origin, s_tedd.angles );
    level.pap_quest.item_tedd = common_item::function_2352d25db9e97696( itembundle, 1, positioningdata, spawnoptions );
    level.pap_quest.item_tedd setscriptablepartstate( "zmloot_quest_firefly_pap_tedd", "unusable" );
    level.pap_quest.item_tedd.disable_dragged = 1;
    level.pap_quest.s_tedd = s_tedd;
    level.pap_quest.tedd_vo_ent = utility::function_1808878d1c511ce8( s_tedd.origin, s_tedd.angles );
    level callback::add( "quest_item_used", &on_pap_quest_item_used );
    level.pap_quest.item_tedd thread function_a2f0e0447c2c1e0e();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x36f2ca1, Offset: 0x1ab7
// Size: 0x2f
function private function_b354eae9b61a5138()
{
    level.pap_quest = spawnstruct();
    level thread function_50c7b9d446723569();
    level thread function_d506f6bdc0198dca();
    level thread function_7558e3f6107eac5a();
    level thread function_e168acc075c9b365();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3030d64, Offset: 0x1aee
// Size: 0x18e
function private function_50c7b9d446723569()
{
    level utility::flag_wait( "common_items_init" );
    level utility::flag_wait( "items_database_init" );
    var_7e65eb02bfdf2f8a = utility::getstruct( "pap_drain_grate", "targetname" );
    level.pap_quest.var_b95b6a86019e33dc = spawnscriptable( %"zm_sat_firefly_pap_sewer_grate", var_7e65eb02bfdf2f8a.origin, var_7e65eb02bfdf2f8a.angles );
    s_tedd = utility::getstruct( "tedd_head_spawn", "targetname" );
    itembundle = getscriptbundle( %"hash_77e9d6437336e65b" );
    spawnoptions = common_item::function_bc5ff2958b71a708( s_tedd.origin, s_tedd.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    positioningdata = common_item::function_b4bee4333994e45a( s_tedd.origin, s_tedd.angles );
    level.pap_quest.item_tedd = common_item::function_2352d25db9e97696( itembundle, 1, positioningdata, spawnoptions );
    level.pap_quest.item_tedd setscriptablepartstate( "zmloot_quest_firefly_pap_tedd", "unusable" );
    level.pap_quest.item_tedd.disable_dragged = 1;
    level.pap_quest.s_tedd = s_tedd;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xae2e2bd0, Offset: 0x1c84
// Size: 0x25e
function private function_d506f6bdc0198dca()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    a_door_triggers = getnoentvolumearray( "pap_wood_barrier_trig", #targetname );
    var_c54aa7f2ae6c37f3 = utility::getstructarray( "pap_wood_barrier", "targetname" );
    
    foreach ( struct in var_c54aa7f2ae6c37f3 )
    {
        var_332e3744433bf2a = getentarray( struct.target, #targetname );
        
        foreach ( mdl in var_332e3744433bf2a )
        {
            wood_barrier_sbl = namespace_5ce9a33f888d9be5::function_b599e26a924c173b( mdl );
            
            foreach ( trig in a_door_triggers )
            {
                doorbuy_hint_ent = getent( trig.target, #target );
                doorbuy_hint_ent.var_a0d364b16ee53ab6 = &"";
                
                if ( trig.target == struct.target )
                {
                    trig.center_struct = struct;
                    
                    if ( !isdefined( trig.a_door_sbls ) )
                    {
                        trig.a_door_sbls = [];
                    }
                    
                    trig.a_door_sbls[ trig.a_door_sbls.size ] = wood_barrier_sbl;
                }
            }
        }
    }
    
    level utility::flag_set( "firefly_pap_doors_init" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x6dad643, Offset: 0x1eea
// Size: 0x200
function private function_7558e3f6107eac5a()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    level.pap_quest.a_generators = [];
    var_7781158486c6c66 = utility::getstructarray( "aether_generator", "targetname" );
    
    foreach ( struct in var_7781158486c6c66 )
    {
        generator_sbl = utility::spawn_model( %"sat_zm_aether_energy_generator_main_on_fxanim", struct.origin, struct.angles );
        generator_sbl setscriptablepartstate( "fx", "on" );
        var_222f2450b7c9d25e = utility::spawn_model( %"sat_zm_aether_energy_generator_main_fxanim", struct.origin, struct.angles );
        generator_sbl.a_cylinders = [];
        
        for ( i = 1; i <= 3 ; i++ )
        {
            origin = var_222f2450b7c9d25e gettagorigin( "tag_generator_0" + int( i ) );
            angles = var_222f2450b7c9d25e gettagangles( "tag_generator_0" + int( i ) );
            cylinder = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_cylinder", origin, angles );
            cylinder setscriptablepartstate( "fx", "on" );
            
            if ( i == 2 )
            {
                cylinder setscriptablepartstate( "liquid", "liquid02" );
            }
            
            if ( i == 3 )
            {
                cylinder setscriptablepartstate( "liquid", "liquid03" );
            }
            
            generator_sbl.a_cylinders[ generator_sbl.a_cylinders.size ] = cylinder;
        }
        
        var_222f2450b7c9d25e delete();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x8326509b, Offset: 0x20f2
// Size: 0x1eb
function private function_e168acc075c9b365()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    var_b5809cfa7fb65f9 = utility::getstructarray( "power_switch", "targetname" );
    
    foreach ( struct in var_b5809cfa7fb65f9 )
    {
        if ( struct.script_parameters == "lakefront" )
        {
            switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch_lake", struct.origin, struct.angles );
            switch_sbl setscriptablepartstate( "electrical_box", "on" );
            continue;
        }
        
        if ( struct.script_parameters == "sunken" )
        {
            switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch_small", struct.origin, struct.angles );
        }
        else
        {
            switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch", struct.origin, struct.angles );
        }
        
        switch_sbl setscriptablepartstate( "usable", "unusable" );
        s_handle = utility::getstruct( struct.target, "targetname" );
        switch_sbl.handle_mdl = utility::spawn_model( %"sat_zm_power_switch_handle", s_handle.origin, s_handle.angles );
        switch_sbl.handle_mdl setscriptablepartstate( "base", "hide" );
        switch_sbl.handle_mdl calloutmarkerping::function_608710c894185549();
        switch_sbl thread rotate_flip_power_switch();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf9fce7fd, Offset: 0x22e5
// Size: 0x13
function private on_player_connect_pap( params )
{
    thread molotov_used_watcher();
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xfe19eae9, Offset: 0x2300
// Size: 0xcf
function private function_ea341c314dc1aadc( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( !b_skipped )
    {
        a_s_waypoints = utility::getstructarray( "pap_step_1_waypoint", "targetname" );
        
        foreach ( struct in a_s_waypoints )
        {
            level function_38448ec66340d598( struct.origin, "pap_step_1" );
        }
    }
    
    level utility::flag_wait( "doorbuy_janus_warehouse_bought" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xa8bfe968, Offset: 0x23d7
// Size: 0x4e
function private function_43ef8d1264a156d3( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        level pap_quest_open_doorbuy( "janus_warehouse_db_instance" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x50b2d6d2, Offset: 0x242d
// Size: 0x192
function private function_ea341f314dc1b175( b_skipped, b_save_restored )
{
    level.pap_quest.tedd_dmg_trig = getent( "trig_damage_drain", #targetname );
    
    if ( zm_save::function_1dda3554974a999e() && zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"grate_opened" ) && !level.pap_quest.restarted )
    {
        level.pap_quest.tedd_dmg_trig grate_opened();
    }
    
    if ( isdefined( level.pap_quest.tedd_dmg_trig ) )
    {
        level.pap_quest.tedd_dmg_trig thread function_429868805d9d42d7();
    }
    
    if ( !b_skipped )
    {
        if ( !level utility::flag( "pap_step_2_part_1_complete" ) )
        {
            level function_38448ec66340d598( level.pap_quest.tedd_dmg_trig.origin, "pap_step_2", undefined, undefined, undefined, [ level.pap_quest.item_tedd ] );
            level utility::flag_wait( "pap_step_2_part_1_complete" );
            level function_45b00b1b3a595819();
        }
        
        level function_38448ec66340d598( level.pap_quest.item_tedd.origin + ( 0, 0, 15 ), "pap_step_2" );
        level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"grab_tedd" );
    }
    
    level utility::flag_wait( "pap_step_2_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x33832f0f, Offset: 0x25c7
// Size: 0xeb
function private function_43ef8e1264a15906( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped )
    {
        level utility::flag_set( "pap_step_2_complete" );
        
        if ( isdefined( level.pap_quest.tedd_dmg_trig ) )
        {
            level.pap_quest.tedd_dmg_trig delete();
        }
        
        if ( isdefined( level.pap_quest.var_e1a3cf08917630d9 ) )
        {
            level.pap_quest.var_e1a3cf08917630d9 delete();
        }
        
        if ( isdefined( level.pap_quest.item_tedd ) )
        {
            level common_item::function_869d7676e359a627( level.pap_quest.item_tedd );
            level function_d36bcd4a6aa8ee3();
        }
        
        level.pap_quest.var_b95b6a86019e33dc utility::function_32b24db3127bff40( "body", "open" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xbbe96480, Offset: 0x26ba
// Size: 0xdb
function private function_429868805d9d42d7()
{
    level endon( #"game_ended" );
    trig = self;
    trig endon( #"death" );
    
    while ( true )
    {
        trig waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( attacker ) && meansofdeath == "MOD_MELEE" && !player::isinlaststand( attacker ) && !attacker.ismutantinjection )
        {
            grate_opened();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xc1c62ca3, Offset: 0x279d
// Size: 0x75
function private grate_opened()
{
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"grate_opened", 1 );
    level.pap_quest.var_b95b6a86019e33dc setscriptablepartstate( "body", "open" );
    level.pap_quest.item_tedd setscriptablepartstate( "zmloot_quest_firefly_pap_tedd", "visible" );
    level utility::flag_set( "pap_step_2_part_1_complete" );
    self delete();
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xbb389afa, Offset: 0x281a
// Size: 0x157
function private function_d36bcd4a6aa8ee3( player )
{
    if ( !getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"pluto_upgrade", 0, #"stage", 1 );
    }
    
    if ( isdefined( player ) )
    {
        player playsound( #"evt_quest_pap_head_pickup" );
        
        if ( !getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
        {
            zm_quest::show_splash_item_picked_up( #"pluto_upgrade", #"stage", 1, player );
        }
        
        foreach ( other_player in level.players )
        {
            other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_1" );
        }
        
        level.pap_quest.tedd_vo_ent linkto( player, "j_spine4" );
    }
    
    level.pap_quest.tedd_vo_ent thread function_125fb2ac6fe73ce4( player );
    level utility::flag_set( "pap_step_2_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x20ac3e90, Offset: 0x2979
// Size: 0x50
function private function_ea341e314dc1af42( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level function_38448ec66340d598( level.wonder_veh, "pap_step_3", undefined, undefined, 100, [ level.wonder_veh ] );
    }
    
    level utility::flag_wait( "pap_step_3_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x18758cf, Offset: 0x29d1
// Size: 0x9c
function private function_43ef8f1264a15b39( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !level.pap_quest.restarted )
    {
        level utility::flag_set( "pap_step_3_complete" );
        level utility::flag_set( "upgraded_pluto_to_stage_" + 1 );
        level.wonder_veh.stagerequested = 1;
        
        if ( isdefined( level.wonder_veh.tedd_interact ) )
        {
            level.wonder_veh.tedd_interact delete();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x3c017224, Offset: 0x2a75
// Size: 0x30
function private function_ea3419314dc1a443( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_1f7b116ed77f6769();
        level utility::flag_wait( "pap_step_4_part_1_complete" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x9a7dcea8, Offset: 0x2aad
// Size: 0x5b
function private function_43ef901264a15d6c( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped )
    {
        if ( !b_save_restored && !level utility::flag( "pap_step_4_part_1_complete" ) )
        {
            level function_cf1384abab133a48();
        }
        
        level utility::flag_set( "pap_step_4_part_1_complete" );
        
        if ( b_save_restored )
        {
            level thread function_238c293ee822b30b();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x929de578, Offset: 0x2b10
// Size: 0x133
function private function_1f7b116ed77f6769()
{
    level endon( #"game_ended" );
    level endon( #"pap_step_4_part_1_complete" );
    
    while ( true )
    {
        if ( level.wonder_veh.occupants.size < 1 )
        {
            function_55a4a97a308a2684( "pap_step_4" );
            var_8c567f816a359de4 = 0;
        }
        else
        {
            if ( !level utility::flag( "pap_hint_vo_played" ) )
            {
                level utility::flag_set( "pap_hint_vo_played" );
                level thread function_624179b4c70b7fcc();
            }
            
            if ( !var_8c567f816a359de4 )
            {
                level function_45b00b1b3a595819();
                
                foreach ( trig in level.pap_quest.var_b5657eb862efe0c0 )
                {
                    level function_38448ec66340d598( trig.origin, "pap_step_4", undefined, undefined, undefined, trig.a_door_sbls );
                }
                
                var_8c567f816a359de4 = 1;
            }
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x6a170bd0, Offset: 0x2c4b
// Size: 0x94
function private function_ea3418314dc1a210( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_91e1b6e56bc4671c();
        var_1c6fbca79eeead93 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"wood_barrier_side" );
        
        if ( var_1c6fbca79eeead93 == 2 )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"travel_to_farm" );
        }
        else
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"hash_895b54b6a9ac3f63" );
        }
    }
    
    level utility::flag_wait( "pap_step_4_part_2_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x770ad8fe, Offset: 0x2ce7
// Size: 0x4f
function private function_43ef911264a15f9f( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped )
    {
        if ( !b_save_restored && !level utility::flag( "pap_step_4_part_2_complete" ) )
        {
            level function_cf1384abab133a48( 0 );
        }
        
        level utility::flag_set( "pap_step_4_part_2_complete" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xcb58afa0, Offset: 0x2d3e
// Size: 0xad
function private function_91e1b6e56bc4671c()
{
    level endon( #"game_ended" );
    level endon( #"pap_step_4_part_2_complete" );
    
    while ( true )
    {
        if ( level.wonder_veh.occupants.size < 1 )
        {
            function_55a4a97a308a2684( "pap_step_5" );
            var_8c567f816a359de4 = 0;
        }
        else if ( !var_8c567f816a359de4 )
        {
            level function_45b00b1b3a595819();
            barrier = function_aa6c0481c3c4cb69();
            
            if ( !barrier )
            {
                return;
            }
            
            level function_38448ec66340d598( barrier.origin, "pap_step_5", undefined, undefined, undefined, barrier.a_door_sbls );
            var_8c567f816a359de4 = 1;
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x20f76b77, Offset: 0x2df3
// Size: 0x1a7
function private function_ea341b314dc1a8a9( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        if ( zm_save::function_1dda3554974a999e() )
        {
            level utility::flag_wait( "pap_quest_generator_save_restore_complete" );
        }
        
        var_55a3da08bd6a9a23 = function_7e66039289e9ad28();
        
        if ( var_55a3da08bd6a9a23 utility::ent_flag( "cooling_down" ) )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"generator_cooldown" );
            var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "cooling_down" );
            level function_7006f17257efb8b8( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
            level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_6", 1, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
            level utility::flag_set( "player_found_first_generator" );
        }
        
        if ( !level utility::flag( "player_found_first_generator" ) )
        {
            if ( var_55a3da08bd6a9a23.loc_str == "farm" )
            {
                level function_38448ec66340d598( utility::getstruct( "farm_generator_bread_crumb", "targetname" ).origin, "pap_step_6", undefined, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
                level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"hash_b178bde2554d26d" );
            }
            else
            {
                level function_38448ec66340d598( utility::getstruct( "lakefront_generator_bread_crumb", "targetname" ).origin, "pap_step_6", undefined, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
                level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"hash_cc37078ac8023112" );
            }
            
            level thread function_1579c2b5d0399e56( var_55a3da08bd6a9a23 );
        }
    }
    
    level waittill( #"clear_infestation_event_started" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x3361b779, Offset: 0x2fa2
// Size: 0x122
function private function_1579c2b5d0399e56( var_55a3da08bd6a9a23 )
{
    level endon( #"game_ended" );
    level endon( #"clear_infestation_event_started" );
    level endon( #"player_found_first_generator" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, var_55a3da08bd6a9a23.origin ) < squared( 1100 ) )
            {
                level function_45b00b1b3a595819();
                level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_6", 1, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
                level function_7006f17257efb8b8( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1e0a4c27, Offset: 0x30cc
// Size: 0x32
function private function_43ef921264a161d2( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level utility::flag_set( "player_found_first_generator" );
    level function_2f72e545c8669b3e();
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb29a0173, Offset: 0x3106
// Size: 0x28f
function private function_ea341a314dc1a676( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( var_55a3da08bd6a9a23 utility::ent_flag( "infestation_event_active" ) )
            {
                active_generator = var_55a3da08bd6a9a23;
                
                if ( active_generator.loc_str == "farm" )
                {
                    level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 2 );
                    continue;
                }
                
                if ( active_generator.loc_str == "lakefront" )
                {
                    level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 1 );
                }
            }
        }
        
        if ( !isdefined( active_generator ) && !level utility::flag( "first_generator_cleared" ) )
        {
            level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
        }
        
        if ( !active_generator && level utility::flag( "first_generator_cleared" ) )
        {
            return;
        }
        
        level function_38448ec66340d598( active_generator.origin + ( 0, 0, 150 ), "pap_step_7", undefined, undefined, undefined, [ active_generator ] );
        level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"firefly_pap_quest", #"hash_cadac07a2223c10b" );
        active_generator utility::ent_flag_waitopen_any( "infestation_event_active" );
        var_6c44c9956e947f07 = 0;
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) )
            {
                var_6c44c9956e947f07 = 1;
            }
        }
        
        if ( !var_6c44c9956e947f07 )
        {
            level function_45b00b1b3a595819();
            level zm_quest::function_fb3af5600f6a9441( 3, 1, #"firefly_pap_quest", #"hash_cadac07a2223c10b" );
            waitframe();
            level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x213bb50e, Offset: 0x339d
// Size: 0x4c
function private function_43ef931264a16405( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        /#
            level function_e709e22b5fc8c849();
        #/
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x2072bcb1, Offset: 0x33f1
// Size: 0xd2
function private function_ea3424314dc1bc74( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = function_7e66039289e9ad28();
        
        if ( var_55a3da08bd6a9a23.loc_str == "lakefront" )
        {
            power_switch_offset = ( 0, 0, 20 );
            var_271a6de87733ce81 = var_55a3da08bd6a9a23.power_switch_sbl;
        }
        else
        {
            power_switch_offset = ( 0, 0, 65 );
            var_271a6de87733ce81 = var_55a3da08bd6a9a23.power_switch_sbl.handle_mdl;
        }
        
        level function_38448ec66340d598( var_55a3da08bd6a9a23.power_switch_sbl.origin + power_switch_offset, "pap_step_9", undefined, undefined, undefined, [ var_271a6de87733ce81 ] );
    }
    
    level utility::flag_wait( "generator_1_activated" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x18faef25, Offset: 0x34cb
// Size: 0x7d
function private function_43ef951264a1686b( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
    {
        zm_quest::complete_objective_waypoints( level.pap_quest.var_4414bdbce2a8fb63 );
    }
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        /#
            level function_267eca0a92304404();
        #/
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xa40a3f75, Offset: 0x3550
// Size: 0x111
function private function_d244ed6e00eae737( b_skipped, b_save_restored )
{
    level thread zm_quest::update_round_cap( 5 );
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"hash_3eb02b0d2b27321a" ) )
    {
        level utility::flag_set( "pap_step_11_part_1_complete" );
    }
    
    if ( !b_skipped )
    {
        if ( !level callback::exists( "zone_changed", &function_3cd251d730126743 ) )
        {
            level callback::add( "zone_changed", &function_3cd251d730126743 );
        }
        
        level thread function_95ab5a1065dfed29();
        var_55a3da08bd6a9a23 = function_dbdf455da9d150da();
        assert( isdefined( var_55a3da08bd6a9a23.var_d4ac234ee368c2ca.script_noteworthy ), "<dev string:x24>" );
        level.pap_quest.var_2a16792569c9403a = var_55a3da08bd6a9a23.var_d4ac234ee368c2ca.script_noteworthy;
        level utility::flag_wait( "pap_step_11_part_1_complete" );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"hash_3eb02b0d2b27321a", 1 );
        level utility::flag_wait( "pap_step_11_complete" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x2fd79d53, Offset: 0x3669
// Size: 0x74
function private function_92a21734ed21306( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level callback::remove( "zone_changed", &function_3cd251d730126743 );
    
    if ( b_skipped )
    {
        level utility::flag_set( "pap_step_11_part_1_complete" );
        level utility::flag_set( "pap_step_11_complete" );
        
        if ( !b_save_restored && !level.pap_quest.restarted )
        {
            level function_4c752ef567f5993b();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0x8d2a8fcb, Offset: 0x36e5
// Size: 0x191
function private function_95ab5a1065dfed29()
{
    self notify( #"hash_35a12591c5f2f54" );
    self endon( #"hash_35a12591c5f2f54" );
    level endon( #"game_ended" );
    level endon( #"pap_step_11_complete" );
    var_56426d867cf70813 = 0;
    var_56426e867cf70a46 = 0;
    
    while ( true )
    {
        if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
        {
            wait 0.2;
            continue;
        }
        
        if ( level.wonder_veh.occupants.size < 1 )
        {
            function_55a4a97a308a2684( "pap_step_11" );
            var_56426d867cf70813 = 0;
            var_56426e867cf70a46 = 0;
        }
        else if ( !utility::flag( "pap_step_11_part_1_complete" ) )
        {
            if ( !var_56426d867cf70813 )
            {
                level function_45b00b1b3a595819();
                var_55a3da08bd6a9a23 = function_dbdf455da9d150da();
                level.pap_quest.var_2a16792569c9403a = var_55a3da08bd6a9a23.var_d4ac234ee368c2ca.script_noteworthy;
                level function_38448ec66340d598( var_55a3da08bd6a9a23.var_d4ac234ee368c2ca.origin, "pap_step_11" );
                var_56426d867cf70813 = 1;
                var_56426e867cf70a46 = 0;
            }
        }
        else if ( !var_56426e867cf70a46 )
        {
            level function_45b00b1b3a595819();
            var_55a3da08bd6a9a23 = function_dbdf455da9d150da();
            level.pap_quest.var_2a16792569c9403a = var_55a3da08bd6a9a23.var_d4ac234ee368c2ca.script_noteworthy;
            level function_38448ec66340d598( var_55a3da08bd6a9a23.var_d4ac224ee368c097.origin, "pap_step_11" );
            var_56426d867cf70813 = 0;
            var_56426e867cf70a46 = 1;
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x5c4adad5, Offset: 0x387e
// Size: 0x9c
function private function_3cd251d730126743( params )
{
    if ( params.zone_struct.script_zone_name == level.pap_quest.var_2a16792569c9403a )
    {
        level utility::flag_set( "pap_step_11_part_1_complete" );
    }
    
    if ( params.zone_struct.script_zone_name == "zone_sunken_north" || params.zone_struct.script_zone_name == "zone_sunken" )
    {
        level utility::flag_set( "pap_step_11_part_1_complete" );
        level utility::flag_set( "pap_step_11_complete" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x712a60d0, Offset: 0x3922
// Size: 0x2e1
function private function_d244ee6e00eae96a( b_skipped, b_save_restored )
{
    var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "sunken" ];
    assert( isdefined( var_55a3da08bd6a9a23 ), "<dev string:x77>" );
    
    if ( !b_skipped )
    {
        if ( zm_save::function_1dda3554974a999e() )
        {
            level utility::flag_wait( "pap_quest_generator_save_restore_complete" );
        }
        
        if ( !level utility::flag( "player_up_in_sunken" ) && !level zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"hash_f710813281bfa13d" ) )
        {
            a_s_ascenders = utility::getstructarray( "pap_ascender", "targetname" );
            
            foreach ( struct in a_s_ascenders )
            {
                level function_38448ec66340d598( struct.origin, "pap_step_12" );
            }
            
            if ( !level callback::exists( "zone_changed", &function_ae4413573e611898 ) )
            {
                level callback::add( "zone_changed", &function_ae4413573e611898 );
            }
            
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"hash_8003094480a90051" );
            level utility::flag_wait_any_array( [ "player_up_in_sunken", "doorbuy_sunken_bridge_bought" ] );
            level function_45b00b1b3a595819();
        }
        
        if ( var_55a3da08bd6a9a23 utility::ent_flag( "cooling_down" ) && zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"hash_1e8ab1b59c374367" ) )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"generator_cooldown" );
            var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "cooling_down" );
            level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_12", 1, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
        }
        else if ( !level utility::flag( "doorbuy_sunken_bridge_bought" ) )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"hash_8003094480a90051" );
            level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_12", 1, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
            level utility::flag_wait( "doorbuy_sunken_bridge_bought" );
            level function_45b00b1b3a595819();
        }
        
        level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_12", 1, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
        level function_7006f17257efb8b8( #"firefly_pap_quest", #"hash_5d0575e20f0d331b" );
    }
    
    level waittill( #"clear_infestation_event_started_sunken" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x42cc33ac, Offset: 0x3c0b
// Size: 0x68
function private function_92a20734ed210d3( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level callback::remove( "zone_changed", &function_ae4413573e611898 );
    level function_2f72e545c8669b3e();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        level pap_quest_open_doorbuy( "sunken_bridge_db_instance" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf310b3ba, Offset: 0x3c7b
// Size: 0x84
function private function_ae4413573e611898( params )
{
    if ( params.zone_struct.script_zone_name == "zone_sunken_brothel" || params.zone_struct.script_zone_name == "zone_sunken_sheriff_exterior" )
    {
        level utility::flag_set( "player_up_in_sunken" );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"hash_f710813281bfa13d", 1 );
        level callback::remove( "zone_changed", &function_ae4413573e611898 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb2a60a5d, Offset: 0x3d07
// Size: 0xe6
function private function_d244ef6e00eaeb9d( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "sunken" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_step_13", undefined, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
        var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "infestation_event_active" );
        
        if ( !var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) )
        {
            level zm_quest::function_fb3af5600f6a9441( 3, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
            waitframe();
            level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", #"hash_5d0575e20f0d331b" );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x6f9ded0e, Offset: 0x3df5
// Size: 0x63
function private function_92a1f734ed20ea0( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        level.pap_quest.a_generators[ "sunken" ] function_20189923a1c8d801( 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x9bd74a76, Offset: 0x3e60
// Size: 0x9a
function private function_d244e96e00eade6b( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "sunken" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.power_switch_sbl.origin + ( -10, 0, 35 ), "pap_step_15", undefined, undefined, undefined, [ var_55a3da08bd6a9a23.power_switch_sbl.handle_mdl ] );
    }
    
    level utility::flag_wait( "generator_sunken_activated" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xdf7b13d2, Offset: 0x3f02
// Size: 0x8f
function private function_92a25734ed21bd2( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    sunken_generator = level.pap_quest.a_generators[ "sunken" ];
    
    if ( b_skipped && !b_save_restored )
    {
        /#
            sunken_generator.power_switch_sbl attempt_flip_power_switch( undefined, b_skipped );
        #/
    }
    
    if ( b_save_restored )
    {
        if ( level zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"garage_opened" ) )
        {
            level thread zm_sat_firefly_script_garage::function_4aaca8864b49d3b7();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x66ba6fa2, Offset: 0x3f99
// Size: 0x107
function private function_d244eb6e00eae2d1( b_skipped, b_save_restored )
{
    utility::registersharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb", &function_2a0d81b12c44bd4 );
    
    if ( !b_skipped )
    {
        level thread function_91d709734fcd1978();
        level thread function_de23a7977d7489b9( "pap_step_17", #"hash_b17f76ec152a269b" );
        
        if ( !( level.wonder_veh.occupants.size > 0 ) )
        {
            level endon( #"shed_upgrade_available" );
            
            if ( !level callback::exists( #"player_vehicle_enter", &function_311992ba5cb5b360 ) )
            {
                level callback::add( #"player_vehicle_enter", &function_311992ba5cb5b360 );
            }
            
            level waittill( #"player_entered_pluto" );
            level function_45b00b1b3a595819();
        }
    }
    
    /#
        if ( b_skipped && !b_save_restored && level.wonder_veh )
        {
            level.wonder_veh thread zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
            level utility::flag_set( "<dev string:x99>" );
        }
    #/
    
    level utility::flag_wait( "shed_upgrade_available" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb55e9651, Offset: 0x40a8
// Size: 0x40
function private function_92a23734ed2176c( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level callback::remove( #"player_vehicle_enter", &function_311992ba5cb5b360 );
    
    if ( b_skipped )
    {
        level thread zm_sat_firefly_script_garage::function_4aaca8864b49d3b7();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0xc
// Checksum 0x434c79f6, Offset: 0x40f0
// Size: 0x117
function private function_de23a7977d7489b9( var_3fb65a129e9cbad8, step_ref )
{
    self notify( #"hash_625fa73d7427b4a9" );
    self endon( #"hash_625fa73d7427b4a9" );
    level endon( #"game_ended" );
    level endon( #"shed_upgrade_available" );
    step = zm_quest::get_quest_step( #"firefly_pap_quest", step_ref );
    
    while ( true )
    {
        if ( step.completed )
        {
            return;
        }
        
        if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
        {
            wait 0.2;
            continue;
        }
        
        if ( !level.wonder_veh.occupants.size > 0 )
        {
            function_55a4a97a308a2684( var_3fb65a129e9cbad8 );
            var_8c567f816a359de4 = 0;
        }
        else if ( !var_8c567f816a359de4 )
        {
            level function_45b00b1b3a595819();
            level function_38448ec66340d598( level.s_garage.s_pluto_spawn.origin + ( 0, 0, 75 ), var_3fb65a129e9cbad8 );
            var_8c567f816a359de4 = 1;
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0xccb94692, Offset: 0x420f
// Size: 0x11e
function private function_91d709734fcd1978()
{
    self notify( #"hash_6a5560ea871dd61b" );
    self endon( #"hash_6a5560ea871dd61b" );
    level endon( #"game_ended" );
    level endon( "upgraded_pluto_to_stage_" + 2 );
    
    while ( true )
    {
        if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_4b9482ccfc73d4d2" ) )
        {
            if ( utility::callsharedfunc( #"veh_pluto", #"hash_4b9482ccfc73d4d2" ) )
            {
                level utility::flag_set( "shed_upgrade_available" );
            }
            else
            {
                step = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_173b91792d62202e" );
                
                if ( step.started && !step.completed )
                {
                    zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", #"hash_b17f76ec152a269b" );
                    return;
                }
                
                level utility::flag_clear( "shed_upgrade_available" );
            }
        }
        else
        {
            assert( "<dev string:xb0>" );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x6354a4be, Offset: 0x4335
// Size: 0x164
function private function_d244e46e00ead36c( b_skipped, b_save_restored )
{
    if ( !utility::issharedfuncdefined( #"veh_pluto", #"hash_65c3903a874d7bdb" ) )
    {
        utility::registersharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb", &function_2a0d81b12c44bd4 );
    }
    
    if ( !b_skipped )
    {
        level function_38448ec66340d598( utility::getstruct( "garage_pap_hanging_part", "targetname" ).origin + ( 0, 0, 18 ), "pap_step_18" );
    }
    
    /#
        if ( b_skipped && !b_save_restored && level.wonder_veh )
        {
            level.wonder_veh.stagerequested = 2;
        }
    #/
    
    level utility::flag_wait( "upgraded_pluto_to_stage_" + 2 );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"papsuccess" );
    
    if ( !b_skipped )
    {
        if ( isplayer( level.wonder_veh.var_17aacd04863e2127 ) )
        {
            level.pap_quest.var_5ea5579f09400c6c = level.wonder_veh.var_17aacd04863e2127 calloutmarkerping::function_920a63c06abdefe8( level.wonder_veh.pap_sbl getscriptableindex() );
            level thread function_5eb1056596873164();
        }
    }
    
    level val::reset( "task_firefly_pap", "task_logic_activate" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x7d3204f1, Offset: 0x44a1
// Size: 0xe0
function private function_92a2a734ed226d1( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    utility::registersharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb", undefined );
    
    if ( !getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"pluto_upgrade", 0, #"stage", 2 );
    }
    
    level thread function_b4093883de542108();
    
    if ( b_skipped )
    {
        level utility::flag_set( "upgraded_pluto_to_stage_" + 2 );
        level.wonder_veh.stagerequested = 2;
        level zm_sat_firefly_script_garage::function_102a2b6455cb506a();
        level val::reset( "task_firefly_pap", "task_logic_activate" );
        
        if ( !b_save_restored && !level.pap_quest.restarted )
        {
            level.wonder_veh thread zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3e649584, Offset: 0x4589
// Size: 0x4
function private function_2a0d81b12c44bd4()
{
    return 2;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x5d230b39, Offset: 0x4596
// Size: 0x2b
function private function_5eb1056596873164()
{
    level endon( #"game_ended" );
    wait 30;
    level.wonder_veh.pap_sbl calloutmarkerping::function_608710c894185549();
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xe4f26d18, Offset: 0x45c9
// Size: 0x13c
function private function_6a64790c2f45edb3( b_skipped, b_save_restored )
{
    if ( level.var_759d027eca7a10d1.restarted && !level.pap_quest utility::ent_flag( "zm_quest_completed" ) )
    {
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", level.pap_quest.steps[ level.pap_quest.var_7be076c9078045aa ].ref );
    }
    
    level utility::flag_wait( "first_generator_cleared" );
    
    if ( !b_skipped )
    {
        level thread function_b4093883de542108();
    }
    
    if ( !level utility::flag( "player_found_second_generator_at_lake_or_farm" ) )
    {
        level thread function_6489b5819582a033();
    }
    
    if ( level.var_759d027eca7a10d1.restarted )
    {
        var_55a3da08bd6a9a23 = get_last_generator();
        var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "cooling_down" );
        level thread function_b4093883de542108();
    }
    
    level waittill( #"hash_2471703945bc8d31" );
    
    if ( level.pap_quest.a_generators[ "sunken" ] utility::ent_flag( "infestation_event_active" ) )
    {
        level thread zm_quest::restart_quest( #"hash_9deee04807c7b80c" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x348c419a, Offset: 0x470d
// Size: 0x31
function private function_5633a9780ace8c72( b_skipped, b_save_restored )
{
    level utility::flag_set( "player_found_second_generator_at_lake_or_farm" );
    zm_quest::clear_all_guidance();
    level function_2f72e545c8669b3e();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x82304008, Offset: 0x4746
// Size: 0x11f
function private function_6489b5819582a033()
{
    level endon( #"game_ended" );
    level endon( #"clear_infestation_event_started" );
    
    if ( !level.pap_quest.completed )
    {
        level.pap_quest waittill( #"zm_quest_completed" );
    }
    
    var_55a3da08bd6a9a23 = get_last_generator();
    
    if ( !isdefined( var_55a3da08bd6a9a23 ) )
    {
        return;
    }
    
    var_55a3da08bd6a9a23 endon( #"infestation_cleared" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, var_55a3da08bd6a9a23.origin ) < squared( 1100 ) )
            {
                level utility::flag_set( "player_found_second_generator_at_lake_or_farm" );
                level thread function_b4093883de542108();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x92f6c5a4, Offset: 0x486d
// Size: 0x262
function private function_6a647a0c2f45efe6( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        if ( level.pap_quest.a_generators[ "farm" ] utility::ent_flag( "infestation_cleared" ) && level.pap_quest.a_generators[ "lakefront" ] utility::ent_flag( "infestation_cleared" ) )
        {
            return;
        }
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( var_55a3da08bd6a9a23.loc_str != "sunken" && var_55a3da08bd6a9a23 utility::ent_flag( "infestation_event_active" ) )
            {
                active_generator = var_55a3da08bd6a9a23;
            }
        }
        
        if ( !isdefined( active_generator ) )
        {
            level thread zm_quest::function_80abdea0cd4c89a7( #"hash_9deee04807c7b80c", #"clear_infestation_setup" );
        }
        
        if ( !level.pap_quest utility::ent_flag( "zm_quest_completed" ) )
        {
            level function_45b00b1b3a595819();
        }
        
        if ( active_generator == level.pap_quest.curr_generator )
        {
            level.pap_quest.var_4414bdbce2a8fb63 = zm_quest::function_b98d4144845ffc13( "pap_last_generator_step_2", 1, "ui_icon_zm_objective", "icon_small_medium", "current", active_generator.origin + ( 0, 0, 90 ), undefined, undefined, undefined, 0, 1 );
            level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"hash_9deee04807c7b80c", #"clear_infestation" );
        }
        
        active_generator utility::ent_flag_waitopen_any( "infestation_event_active" );
        
        if ( !active_generator utility::ent_flag( "infestation_cleared" ) )
        {
            zm_quest::complete_objective_waypoints( level.pap_quest.var_4414bdbce2a8fb63 );
            level.pap_quest.var_4414bdbce2a8fb63 = undefined;
            level zm_quest::function_fb3af5600f6a9441( 3, 1, #"hash_9deee04807c7b80c", #"clear_infestation" );
            waitframe();
            level thread zm_quest::function_80abdea0cd4c89a7( #"hash_9deee04807c7b80c", #"clear_infestation_setup" );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xfde66d05, Offset: 0x4ad7
// Size: 0xce
function private function_5633a8780ace8a3f( b_skipped, b_save_restored )
{
    if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
    {
        zm_quest::complete_objective_waypoints( level.pap_quest.var_4414bdbce2a8fb63 );
        level.pap_quest.var_4414bdbce2a8fb63 = undefined;
    }
    
    if ( !level.pap_quest utility::ent_flag( "zm_quest_completed" ) && !b_skipped )
    {
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", level.pap_quest.steps[ level.pap_quest.var_7be076c9078045aa ].ref );
    }
    
    if ( b_skipped && !b_save_restored )
    {
        level function_4f30728f9d7763b8();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x49d47e4b, Offset: 0x4bad
// Size: 0x6d
function private function_6a647b0c2f45f219( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_b4093883de542108();
    }
    
    level.pap_quest.a_generators[ "farm" ] utility::ent_flag_wait( "activated" );
    level.pap_quest.a_generators[ "lakefront" ] utility::ent_flag_wait( "activated" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x697f119a, Offset: 0x4c22
// Size: 0x13d
function private function_5633a7780ace880c( b_skipped, b_save_restored )
{
    level thread function_196abf749b081332();
    
    if ( isdefined( level.pap_quest.var_4414bdbce2a8fb63 ) )
    {
        zm_quest::complete_objective_waypoints( level.pap_quest.var_4414bdbce2a8fb63 );
        level.pap_quest.var_4414bdbce2a8fb63 = undefined;
    }
    
    if ( zm_quest::function_209ca091001f4c64( #"hash_cda4e7df69dd352a" ) )
    {
        level zm_quest::function_fb3af5600f6a9441( 4, 1, #"hash_cda4e7df69dd352a", #"flip_power_switch_last" );
        level utility::delaythread( 2.5, &zm_quest::function_fba942a1cfd85f5d, 0, 1, #"hash_cda4e7df69dd352a", #"flip_power_switch_last" );
    }
    
    if ( !level.pap_quest utility::ent_flag( "zm_quest_completed" ) && !b_skipped )
    {
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", level.pap_quest.steps[ level.pap_quest.var_7be076c9078045aa ].ref );
    }
    
    level utility::delaythread( 2.5, &function_e150b30c0436dc49 );
    level utility::delaythread( 2.5, &function_2f72e545c8669b3e );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xa136ab13, Offset: 0x4d67
// Size: 0x76
function private function_e150b30c0436dc49()
{
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"clear_infestation_setup" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"flip_power_switch_last" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"clear_infestation_setup" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"flip_power_switch_last" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x6775bf0f, Offset: 0x4de5
// Size: 0x97
function private get_last_generator()
{
    if ( !level.pap_quest.a_generators[ "farm" ] utility::ent_flag( "infestation_cleared" ) )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
    }
    else if ( !level.pap_quest.a_generators[ "lakefront" ] utility::ent_flag( "infestation_cleared" ) )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "lakefront" ];
    }
    
    return var_55a3da08bd6a9a23;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0x8001cba0, Offset: 0x4e85
// Size: 0x45
function private function_196abf749b081332()
{
    self notify( #"hash_ba23e16967f8c2c2" );
    self endon( #"hash_ba23e16967f8c2c2" );
    level endon( #"game_ended" );
    level.pap_quest utility::ent_flag_wait( "zm_quest_completed" );
    level thread zm_quest::update_round_cap( 7 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0x5ed59937, Offset: 0x4ed2
// Size: 0x2ad
function private function_b4093883de542108()
{
    self notify( #"hash_1ba3a91be34c84ce" );
    self endon( #"hash_1ba3a91be34c84ce" );
    level endon( #"game_ended" );
    level.var_759d027eca7a10d1 endon( #"zm_quest_completed" );
    level.pap_quest utility::ent_flag_wait( "zm_quest_completed" );
    quest_step = level.var_759d027eca7a10d1.steps[ level.var_759d027eca7a10d1.var_7be076c9078045aa ];
    
    if ( quest_step.ref == #"flip_power_switch" )
    {
        if ( !level.pap_quest.a_generators[ "farm" ] utility::ent_flag( "activated" ) )
        {
            var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
            power_switch_offset = 65;
        }
        else
        {
            var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "lakefront" ];
            power_switch_offset = 20;
        }
        
        level.pap_quest.var_4414bdbce2a8fb63 = zm_quest::function_b98d4144845ffc13( "pap_last_generator_step_3", 1, "ui_icon_zm_objective", "icon_small_medium", "current", var_55a3da08bd6a9a23.power_switch_sbl.origin + ( 0, 0, power_switch_offset ), undefined, undefined, undefined, 0, 1 );
        level thread function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"flip_power_switch_last" );
    }
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        if ( quest_step.ref == #"clear_infestation_setup" )
        {
            step_ref = #"clear_infestation_setup";
            
            if ( !level.pap_quest.a_generators[ "farm" ] utility::ent_flag( "infestation_cleared" ) )
            {
                var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
                
                if ( !level utility::flag( "player_found_second_generator_at_lake_or_farm" ) )
                {
                    step_ref = #"hash_b178bde2554d26d";
                }
                else if ( var_55a3da08bd6a9a23 utility::ent_flag( "cooling_down" ) )
                {
                    step_ref = #"generator_cooldown";
                }
            }
            else
            {
                var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "lakefront" ];
                
                if ( !level utility::flag( "player_found_second_generator_at_lake_or_farm" ) )
                {
                    step_ref = #"hash_cc37078ac8023112";
                }
                else if ( var_55a3da08bd6a9a23 utility::ent_flag( "cooling_down" ) )
                {
                    step_ref = #"generator_cooldown";
                }
            }
            
            level thread zm_quest::update_guidance( [ [ var_55a3da08bd6a9a23, 90 ] ], #"hash_cda4e7df69dd352a", step_ref, 1 );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x63969ffd, Offset: 0x5187
// Size: 0x24
function private on_pluto_spawned()
{
    level utility::registersharedfunc( #"veh_pluto", #"hash_db077913b65c7469", undefined );
    thread function_1dec8d91038deedb();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x60637c85, Offset: 0x51b3
// Size: 0xd0
function private function_1dec8d91038deedb()
{
    level endon( #"game_ended" );
    level.wonder_veh.tedd_interact = interaction::register_interact( level.wonder_veh.origin + ( 0, 0, 30 ), 100, &function_ef2dbfbbbad6d10e, &function_5cb8e682fe2bbb54 );
    level.wonder_veh.tedd_interact endon( #"death" );
    level.wonder_veh.tedd_interact sethintonobstruction( "show" );
    level.wonder_veh.tedd_interact setusableenabled( 0 );
    level utility::flag_wait( "pap_step_2_complete" );
    level.wonder_veh.tedd_interact setusableenabled( 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xae0eef7e, Offset: 0x528b
// Size: 0xdd
function private function_5cb8e682fe2bbb54( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.b_in_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #icon:"sat_ui_icon_hud_minmap_wondervehicle01_stage01", #buttoncallout:&"zm_sat_firefly/pluto_install", #description:&"zm_sat_firefly/pluto_upgrade_1", #title:&"zm_sat_firefly/pluto_r_title", #type:"HINT_BUTTON" };
    return hintstring_obj;
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xa3afe32b, Offset: 0x5371
// Size: 0x16b
function private function_ef2dbfbbbad6d10e( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( self.b_in_use )
    {
        return;
    }
    
    self.b_in_use = 1;
    val::set( "upgrading_pluto", "killstreaks", 0 );
    player setscriptablepartstate( "sndCrafting", "crafting", 0 );
    player thread zm_interaction::function_307c21197e0798d4( &"zm_sat_firefly/shed_upgrade_caption" );
    player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"upgrading_pluto" } );
    result = player zm_interaction::function_df340931f1a0fe6e( 2, self, self.interact_use_range );
    
    if ( player.var_a0de55e36be21b7a )
    {
        player thread zm_interaction::function_7c7ed762cd4d0333();
    }
    
    if ( player )
    {
        if ( result )
        {
            player setscriptablepartstate( "sndCrafting", "success", 0 );
        }
        else
        {
            player setscriptablepartstate( "sndCrafting", "fail", 0 );
        }
        
        player zm_quest::function_b94186b3fb991490( { #craft_reason:"upgrading_pluto" } );
        player val::reset_all( "upgrading_pluto" );
    }
    
    if ( result )
    {
        level thread function_f67e8ae93efa90b4( player );
        level.wonder_veh.stagerequested = 1;
        level utility::flag_set( "pap_step_3_complete" );
        
        if ( self )
        {
            self delete();
        }
        
        return;
    }
    
    self.b_in_use = 0;
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xd211ccf6, Offset: 0x54e4
// Size: 0x30
function private function_311992ba5cb5b360( params )
{
    if ( params.vehicle.var_b6a3f46ec4332fd8 )
    {
        level notify( #"player_entered_pluto" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x1730f51c, Offset: 0x551c
// Size: 0x36f
function private function_3dda3630e8e4bdb5()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    a_door_triggers = getnoentvolumearray( "pap_wood_barrier_trig", #targetname );
    var_c54aa7f2ae6c37f3 = utility::getstructarray( "pap_wood_barrier", "targetname" );
    
    foreach ( struct in var_c54aa7f2ae6c37f3 )
    {
        var_332e3744433bf2a = getentarray( struct.target, #targetname );
        
        foreach ( mdl in var_332e3744433bf2a )
        {
            wood_barrier_sbl = namespace_5ce9a33f888d9be5::function_b599e26a924c173b( mdl );
            
            foreach ( trig in a_door_triggers )
            {
                doorbuy_hint_ent = getent( trig.target, #target );
                doorbuy_hint_ent.var_a0d364b16ee53ab6 = &"zm_sat_firefly/pluto_wood_barrier_hint";
                
                if ( trig.target == struct.target )
                {
                    trig.center_struct = struct;
                    
                    if ( !isdefined( trig.a_door_sbls ) )
                    {
                        trig.a_door_sbls = [];
                    }
                    
                    trig.a_door_sbls[ trig.a_door_sbls.size ] = wood_barrier_sbl;
                }
            }
        }
    }
    
    level.pap_quest.var_b5657eb862efe0c0 = [];
    level.pap_quest.var_f438f7b962be3ab = [];
    
    foreach ( trig in a_door_triggers )
    {
        if ( trig.script_noteworthy == "janus_door" )
        {
            level.pap_quest.var_b5657eb862efe0c0[ level.pap_quest.var_b5657eb862efe0c0.size ] = trig;
        }
        else
        {
            level.pap_quest.var_f438f7b962be3ab[ level.pap_quest.var_f438f7b962be3ab.size ] = trig;
        }
        
        /#
            trig thread debug_draw_trig();
        #/
        
        trig thread namespace_5ce9a33f888d9be5::function_d850fff2db81e7e();
        trig callback::add( "wood_barrier_broken", &function_3898286ad0b06777 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x6ed5ca0c, Offset: 0x5893
// Size: 0xaa
function private function_3898286ad0b06777( params )
{
    if ( self.script_noteworthy == "janus_door" )
    {
        level utility::flag_set( "pap_step_4_part_1_complete" );
    }
    else
    {
        level utility::flag_set( "pap_step_4_part_2_complete" );
    }
    
    if ( !params.var_9682afafe2425248 )
    {
        if ( self.target == "janus_to_lakefront_ts_db" || self.target == "lakefront_to_janus_ts_db" )
        {
            level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 1 );
            return;
        }
        
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 2 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x6adb9fa3, Offset: 0x5945
// Size: 0xbf
function private function_cf1384abab133a48( var_114a601036e2d680 = 1 )
{
    var_8f384e04d48758bd = level.pap_quest.var_b5657eb862efe0c0;
    
    if ( !var_114a601036e2d680 )
    {
        var_8f384e04d48758bd = level.pap_quest.var_f438f7b962be3ab;
    }
    
    foreach ( trig in var_8f384e04d48758bd )
    {
        trig namespace_5ce9a33f888d9be5::break_wood_barrier();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x6199bba7, Offset: 0x5a0c
// Size: 0x1b2
function private function_238c293ee822b30b()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    a_door_triggers = getnoentvolumearray( "pap_wood_barrier_trig", #targetname );
    var_e5ccbf542c55e9dd = getnoentvolumearray( "zone_unlock_trig", #targetname );
    a_door_triggers = arraycombine( a_door_triggers, var_e5ccbf542c55e9dd );
    
    foreach ( trig in a_door_triggers )
    {
        a_doors = getentarray( trig.target, #targetname );
        
        if ( a_doors.size < 1 )
        {
            trig namespace_5ce9a33f888d9be5::break_wood_barrier( 1 );
        }
    }
    
    var_1684fa089b74b11a = utility::getstructarray( "power_gate_model", "targetname" );
    
    foreach ( struct in var_1684fa089b74b11a )
    {
        a_doors = getentarray( struct.target, #targetname );
        
        if ( a_doors.size < 1 )
        {
            level pap_quest_open_doorbuy( struct.target );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x6065c367, Offset: 0x5bc6
// Size: 0x68
function private function_aa6c0481c3c4cb69()
{
    var_1c6fbca79eeead93 = level zm_quest::function_73720cdf21c3cfd7( #"firefly_pap_quest", #"wood_barrier_side" );
    
    if ( var_1c6fbca79eeead93 == 2 )
    {
        barrier = getnoentvolumearray( "farm_to_janus_ts_db", #target )[ 0 ];
    }
    else
    {
        barrier = getnoentvolumearray( "lakefront_to_janus_ts_db", #target )[ 0 ];
    }
    
    return barrier;
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xc1ae00e3, Offset: 0x5c37
// Size: 0xf6
function private function_1b74fe7664a8ad8f( doorbuy_targetname, step )
{
    a_doors = getentarray( doorbuy_targetname, #target );
    
    foreach ( door in a_doors )
    {
        objectiveid = zm_quest::function_b98d4144845ffc13( step, 1, "ui_icon_zm_objective", "icon_small_medium", "current", door.origin, undefined, undefined, undefined, 0, 1 );
        level.pap_quest.var_fce0c3e197569778[ level.pap_quest.var_fce0c3e197569778.size ] = objectiveid;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x7168eaa6, Offset: 0x5d35
// Size: 0x1bb
function private pap_quest_open_doorbuy( door_targetname, var_d2d01d58b7e1e970 = 0 )
{
    a_doors = getentarray( door_targetname, #target );
    
    foreach ( door in a_doors )
    {
        if ( var_d2d01d58b7e1e970 )
        {
            a_door_models = getentarray( door.target, #targetname );
            
            foreach ( mdl in a_door_models )
            {
                if ( mdl.model == "sat_zm_gate_frame_metal_01" || mdl.model == "sat_zm_gate_frame_metal_02" )
                {
                    fx = spawnscriptable( %"zm_sat_firefly_pap_power_gate", mdl.origin, mdl.angles );
                    fx utility::scriptable_setparententity( mdl );
                    fx setscriptablepartstate( "fx", "open" );
                    fx utility::delaythread( 4, &function_3ecb3a3a0cfd30d3 );
                }
            }
        }
        
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xa8bc1065, Offset: 0x5ef8
// Size: 0x8
function private function_3ecb3a3a0cfd30d3()
{
    self freescriptable();
}

/#

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x140f8241, Offset: 0x5f08
    // Size: 0x36, Type: dev
    function private debug_draw_trig()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( !getdvarint( @"hash_b2a03725aa1e2ff5", 0 ) )
            {
                waitframe();
                continue;
            }
            
            drawtrigger( self );
            waitframe();
        }
    }

#/

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xec3d9dc3, Offset: 0x5f46
// Size: 0x805
function private setup_aether_generator_assets()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    utility::registersharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7", &function_1f7fc83b06996fec );
    level.pap_quest.a_generators = [];
    var_7781158486c6c66 = utility::getstructarray( "aether_generator", "targetname" );
    
    foreach ( struct in var_7781158486c6c66 )
    {
        generator_sbl = utility::spawn_model( %"sat_zm_aether_energy_generator_main_fxanim", struct.origin, struct.angles );
        generator_sbl.a_cylinders = [];
        
        for ( i = 1; i <= 3 ; i++ )
        {
            origin = generator_sbl gettagorigin( "tag_generator_0" + int( i ) );
            angles = generator_sbl gettagangles( "tag_generator_0" + int( i ) );
            cylinder = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_cylinder", origin, angles );
            
            if ( i == 2 )
            {
                cylinder setscriptablepartstate( "liquid", "liquid02" );
            }
            
            if ( i == 3 )
            {
                cylinder setscriptablepartstate( "liquid", "liquid03" );
            }
            
            generator_sbl.a_cylinders[ generator_sbl.a_cylinders.size ] = cylinder;
        }
        
        generator_sbl.curr_stage = 2;
        generator_sbl.var_725afa5fbef29930 = [];
        generator_sbl.loc_str = struct.script_parameters;
        generator_sbl.var_bb3cfcbf65750e32 = struct.script_power;
        generator_sbl.interact = interaction::register_scriptable_interact( generator_sbl getlinkedscriptableinstance(), &function_11839ec085cbe55f, undefined, undefined, &generator_hint );
        generator_sbl.var_fd850913e59c56a8 = function_7367854d740d847();
        
        if ( !isdefined( level.pap_quest.a_generators[ struct.script_parameters ] ) )
        {
            level.pap_quest.a_generators[ struct.script_parameters ] = generator_sbl;
        }
    }
    
    var_7cd7fa26e8731c59 = utility::getstructarray( "aether_generator_pustule", "targetname" );
    
    foreach ( struct in var_7cd7fa26e8731c59 )
    {
        assert( isdefined( level.pap_quest.a_generators[ struct.script_parameters ] ), "<dev string:x101>" );
        
        if ( !isdefined( level.pap_quest.a_generators[ struct.script_parameters ].var_4d0b4c7baa1aec17 ) )
        {
            level.pap_quest.a_generators[ struct.script_parameters ].var_4d0b4c7baa1aec17 = [];
        }
        
        switch ( int( struct.script_label ) )
        {
            case 1:
                pustule = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_pustule_01", struct.origin, struct.angles );
                break;
            case 2:
                pustule = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_pustule_02", struct.origin, struct.angles );
                break;
            case 3:
                pustule = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_pustule_03", struct.origin, struct.angles );
                break;
            default:
                assertmsg( "<dev string:x12a>" );
                break;
        }
        
        pustule.var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ struct.script_parameters ];
        level.pap_quest.a_generators[ struct.script_parameters ].var_4d0b4c7baa1aec17[ level.pap_quest.a_generators[ struct.script_parameters ].var_4d0b4c7baa1aec17.size ] = pustule;
        
        if ( utility::issharedfuncdefined( #"zm_dinj", #"hash_82f3df73536352e5" ) )
        {
            utility::callsharedfunc( #"zm_dinj", #"hash_82f3df73536352e5", pustule );
        }
    }
    
    scriptable::scriptable_adddamagedcallback( &pustule_damaged );
    scriptable::scriptable_adddamagedcallback( &function_32d7ec6937cda318 );
    a_s_cores = utility::getstructarray( "aether_generator_infestation_core", "targetname" );
    
    foreach ( struct in a_s_cores )
    {
        assert( isdefined( level.pap_quest.a_generators[ struct.script_parameters ] ), "<dev string:x153>" );
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ struct.script_parameters ];
        var_2e34876e86fba0d0 = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_infestation_core", var_55a3da08bd6a9a23.origin, var_55a3da08bd6a9a23.angles );
        var_2e34876e86fba0d0.vines = spawnscriptable( %"zm_sat_firefly_pap_aether_generator_infestation_core_vines", var_55a3da08bd6a9a23.origin, var_55a3da08bd6a9a23.angles );
        var_2e34876e86fba0d0 setscriptablepartstate( "health", "ignore_damage" );
        var_2e34876e86fba0d0.var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ struct.script_parameters ];
        level.pap_quest.a_generators[ struct.script_parameters ].var_2e34876e86fba0d0 = var_2e34876e86fba0d0;
        
        if ( utility::issharedfuncdefined( #"zm_dinj", #"hash_82f3df73536352e5" ) )
        {
            utility::callsharedfunc( #"zm_dinj", #"hash_82f3df73536352e5", var_2e34876e86fba0d0 );
        }
    }
    
    if ( level zm_save::function_1dda3554974a999e() )
    {
        level thread function_28cd5c7d2ae192f();
    }
    
    foreach ( player in level.players )
    {
        player thread molotov_used_watcher();
    }
    
    foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
    {
        var_55a3da08bd6a9a23 thread function_bd6b9a54f91ef7df();
    }
    
    level utility::flag_set( "pap_generator_assets_init_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf8cbb584, Offset: 0x6753
// Size: 0xed
function private function_1f7fc83b06996fec( potential_enemies )
{
    foreach ( enemy in potential_enemies )
    {
        if ( isdefined( enemy[ "scriptable" ] ) )
        {
            if ( issubstr( enemy[ "scriptable" ].type, "zm_sat_firefly_pap_aether_generator_pustule" ) )
            {
                pustule_damaged( self, self, enemy[ "scriptable" ], 50, undefined, "MOD_ELEMENTAL_DARK" );
                continue;
            }
            
            if ( issubstr( enemy[ "scriptable" ].type, "zm_sat_firefly_pap_aether_generator_infestation_core" ) )
            {
                function_32d7ec6937cda318( self, self, enemy[ "scriptable" ], 50, undefined, "MOD_ELEMENTAL_DARK" );
            }
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0xeb98c939, Offset: 0x6848
// Size: 0x14d
function private function_bd6b9a54f91ef7df()
{
    self notify( #"hash_38958f363ae56614" );
    self endon( #"hash_38958f363ae56614" );
    level endon( #"game_ended" );
    self endon( #"infestation_cleared" );
    level utility::flag_wait( "begin_round_logic" );
    
    switch ( self.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            save_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_57ced84c016c6c03" );
            break;
        case #"hash_9c5e8152de8ef99":
            save_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" );
            break;
        case #"hash_eff0649069653dd":
            save_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_1e8ab1b59c374367" );
            break;
        default:
            assertmsg( "<dev string:x17f>" );
            break;
    }
    
    if ( save_progress )
    {
        return;
    }
    
    zone_struct = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    while ( true )
    {
        if ( zone_struct.is_enabled )
        {
            function_892cee25f9038001();
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xcd116e1c, Offset: 0x699d
// Size: 0x221
function private function_1c2a5173b92f8069( var_4d0b4c7baa1aec17 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !isdefined( self.var_fb44f2f10bdb1bd8 ) )
    {
        self.var_fb44f2f10bdb1bd8 = [];
    }
    
    switch ( level.players.size )
    {
        case 1:
            var_4c2edd757396ffbe = randomintrange( 9, 11 );
            break;
        case 2:
            var_4c2edd757396ffbe = randomintrange( 10, 12 );
            break;
        case 3:
            var_4c2edd757396ffbe = randomintrange( 11, 13 );
            break;
        case 4:
            var_4c2edd757396ffbe = randomintrange( 12, 14 );
            break;
        default:
            var_4c2edd757396ffbe = randomintrange( 9, 11 );
            break;
    }
    
    pustule_health = self.var_fd850913e59c56a8 / var_4c2edd757396ffbe;
    var_4c2edd757396ffbe -= self.var_fb44f2f10bdb1bd8.size;
    
    foreach ( pustule in self.var_fb44f2f10bdb1bd8 )
    {
        pustule activate_pustule( pustule_health );
    }
    
    if ( var_4c2edd757396ffbe < 1 )
    {
        return;
    }
    
    var_4d0b4c7baa1aec17 = arrayrandomize( var_4d0b4c7baa1aec17 );
    
    foreach ( index, pustule in var_4d0b4c7baa1aec17 )
    {
        if ( index >= var_4c2edd757396ffbe )
        {
            break;
        }
        
        if ( arraycontains( self.var_fb44f2f10bdb1bd8, pustule ) )
        {
            continue;
        }
        
        pustule activate_pustule( pustule_health );
        self.var_fb44f2f10bdb1bd8[ self.var_fb44f2f10bdb1bd8.size ] = pustule;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xc235aee5, Offset: 0x6bc6
// Size: 0x64
function private activate_pustule( pustule_health )
{
    pustule = self;
    pustule.destroyed = 0;
    pustule.health = pustule_health;
    pustule.var_af9564bb9a74d19f = pustule_health;
    pustule setscriptablepartstate( "body", "show" );
    pustule setscriptablepartstate( "health", "damage_detect" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x1097bf75, Offset: 0x6c32
// Size: 0xac
function private function_5209673ff777c461()
{
    var_29f4889fe5e1dc0a = self.var_fd850913e59c56a8 / self.var_fb44f2f10bdb1bd8.size;
    
    foreach ( pustule in self.var_fb44f2f10bdb1bd8 )
    {
        pustule.health = var_29f4889fe5e1dc0a;
        pustule.var_af9564bb9a74d19f = var_29f4889fe5e1dc0a;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3db34355, Offset: 0x6ce6
// Size: 0x84
function private function_7367854d740d847()
{
    switch ( level.players.size )
    {
        case 1:
            var_f93a08c86c2cd513 = 800;
            break;
        case 2:
            var_f93a08c86c2cd513 = 1000;
            break;
        case 3:
            var_f93a08c86c2cd513 = 1100;
            break;
        case 4:
            var_f93a08c86c2cd513 = 1100;
            break;
        default:
            var_f93a08c86c2cd513 = 800;
            break;
    }
    
    return var_f93a08c86c2cd513;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x8eef31f4, Offset: 0x6d73
// Size: 0x84
function private function_45fc1397bf6c0924()
{
    switch ( level.players.size )
    {
        case 1:
            var_f93a08c86c2cd513 = 500;
            break;
        case 2:
            var_f93a08c86c2cd513 = 750;
            break;
        case 3:
            var_f93a08c86c2cd513 = 1000;
            break;
        case 4:
            var_f93a08c86c2cd513 = 1250;
            break;
        default:
            var_f93a08c86c2cd513 = 500;
            break;
    }
    
    return var_f93a08c86c2cd513;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x8c2639d, Offset: 0x6e00
// Size: 0x359
function private function_28cd5c7d2ae192f()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "pap_generator_assets_init_complete" );
    lake_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_57ced84c016c6c03" );
    
    if ( isdefined( lake_progress ) )
    {
        switch ( lake_progress )
        {
            case 1:
                level.pap_quest.a_generators[ "lakefront" ] function_20189923a1c8d801( 1, 1 );
                break;
            case 2:
                level.pap_quest.a_generators[ "lakefront" ] function_7dcb9145104fe9af();
                break;
            case 3:
                level.pap_quest.a_generators[ "lakefront" ] thread function_5c8cae29c3778e59( 1 );
                break;
            case 4:
                level.pap_quest.a_generators[ "lakefront" ] function_892cee25f9038001();
                break;
            default:
                break;
        }
    }
    
    farm_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" );
    
    if ( isdefined( farm_progress ) )
    {
        switch ( farm_progress )
        {
            case 1:
                level.pap_quest.a_generators[ "farm" ] function_20189923a1c8d801( 1, 1 );
                break;
            case 2:
                level.pap_quest.a_generators[ "farm" ] function_7dcb9145104fe9af();
                break;
            case 3:
                level.pap_quest.a_generators[ "farm" ] thread function_5c8cae29c3778e59( 1 );
                break;
            case 4:
                level.pap_quest.a_generators[ "farm" ] function_892cee25f9038001();
                break;
            default:
                break;
        }
    }
    
    sunken_progress = zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_1e8ab1b59c374367" );
    
    if ( isdefined( sunken_progress ) )
    {
        switch ( sunken_progress )
        {
            case 1:
                level.pap_quest.a_generators[ "sunken" ] function_20189923a1c8d801( 1, 1 );
                break;
            case 2:
                level.pap_quest.a_generators[ "sunken" ] function_7dcb9145104fe9af();
                break;
            case 3:
                level.pap_quest.a_generators[ "sunken" ] thread function_5c8cae29c3778e59( 1 );
                break;
            case 4:
                level.pap_quest.a_generators[ "sunken" ] function_892cee25f9038001();
                break;
            default:
                break;
        }
    }
    
    level utility::flag_set( "pap_quest_generator_save_restore_complete" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xd9ea384a, Offset: 0x7161
// Size: 0x7c
function private function_7e66039289e9ad28()
{
    var_1c6fbca79eeead93 = level zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"wood_barrier_side" );
    
    if ( var_1c6fbca79eeead93 == 2 )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
    }
    else
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "lakefront" ];
    }
    
    return var_55a3da08bd6a9a23;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x9471b0e9, Offset: 0x71e6
// Size: 0x1a2
function private function_dbdf455da9d150da()
{
    if ( zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_57ced84c016c6c03" ) == 2 && zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" ) == 2 )
    {
        var_620a38a69407feca = distance2dsquared( level.wonder_veh.origin, level.pap_quest.a_generators[ "lakefront" ].origin );
        var_cd6a4b8d5041a135 = distance2dsquared( level.wonder_veh.origin, level.pap_quest.a_generators[ "farm" ].origin );
        
        if ( var_620a38a69407feca < var_cd6a4b8d5041a135 )
        {
            return level.pap_quest.a_generators[ "lakefront" ];
        }
        else
        {
            return level.pap_quest.a_generators[ "farm" ];
        }
        
        return;
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_57ced84c016c6c03" ) == 2 )
    {
        return level.pap_quest.a_generators[ "lakefront" ];
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" ) == 2 )
    {
        return level.pap_quest.a_generators[ "farm" ];
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 11, eflags: 0x4
// Checksum 0x73a88e0b, Offset: 0x7390
// Size: 0x1c0
function private pustule_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_firefly_pap_aether_generator_pustule_01" && instance.type != %"zm_sat_firefly_pap_aether_generator_pustule_02" && instance.type != %"zm_sat_firefly_pap_aether_generator_pustule_03" || instance.destroyed )
    {
        return;
    }
    
    if ( instance.var_55a3da08bd6a9a23 utility::ent_flag( "stage_changing" ) )
    {
        return;
    }
    
    if ( isdefined( instance.health ) )
    {
        if ( isplayer( eattacker ) )
        {
            idamage = instance function_40d810b7cf594a30( idamage, smeansofdeath, objweapon, einflictor );
            
            if ( !instance.var_55a3da08bd6a9a23 utility::ent_flag( "infestation_event_active" ) )
            {
                instance.var_55a3da08bd6a9a23 function_e407f1f156fa0e80( eattacker );
            }
            
            if ( idamage > 0 )
            {
                instance.health -= idamage;
                eattacker damagefeedback::updatehitmarker( "standard", instance.health <= 0, undefined, 0, undefined );
            }
            
            if ( instance.health <= 0 )
            {
                instance setscriptablepartstate( "health", "ignore_damage" );
                instance setscriptablepartstate( "body", "bursted" );
                instance.destroyed = 1;
                instance.var_55a3da08bd6a9a23 function_ea2137afc8a3b24f();
            }
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 4, eflags: 0x4
// Checksum 0x6f811fd8, Offset: 0x7558
// Size: 0x1e9
function private function_40d810b7cf594a30( idamage, smeansofdeath, objweapon, einflictor )
{
    max_health = self.var_af9564bb9a74d19f;
    
    if ( isdefined( einflictor ) )
    {
        if ( !isdefined( einflictor.var_1b47dc19ddc8f2ca ) )
        {
            einflictor.var_1b47dc19ddc8f2ca = 0;
        }
    }
    
    if ( isdefined( objweapon ) && weapon::iswonderweapon( objweapon ) )
    {
        if ( smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            idamage = function_7e38b19400aafd9d( einflictor, idamage );
        }
        
        return idamage;
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_a5123f4d02745600":
            var_8f98d87abe348e13 = int( max_health * 0.5 ) + 1;
            idamage = int( min( idamage, var_8f98d87abe348e13 ) );
            return idamage;
        default:
            break;
    }
    
    if ( objweapon.classname == "grenade" )
    {
        idamage = function_7e38b19400aafd9d( einflictor, idamage );
        return idamage;
    }
    
    if ( objweapon.basename == "rcxd" )
    {
        if ( smeansofdeath != "MOD_EXPLOSIVE" )
        {
            return 0;
        }
        else
        {
            var_8f98d87abe348e13 = int( max_health * 1 );
            idamage = int( min( idamage, var_8f98d87abe348e13 ) );
        }
        
        return idamage;
    }
    
    if ( objweapon.classname == "rocketlauncher" )
    {
        if ( utility::issharedfuncdefined( #"zm_dinj", #"get_weapon_name" ) )
        {
            if ( objweapon.basename == utility::callsharedfunc( #"zm_dinj", #"get_weapon_name" ) )
            {
                if ( smeansofdeath == "MOD_PROJECTILE" )
                {
                    idamage = int( max_health * 0.51 );
                }
                else if ( smeansofdeath == "MOD_IMPACT" )
                {
                    idamage = int( max_health * 1 );
                }
                
                return idamage;
            }
        }
        
        if ( objweapon.basename == "sat_ks_compound_mp" )
        {
            return idamage;
        }
        
        idamage = function_7e38b19400aafd9d( einflictor, idamage );
        return idamage;
    }
    
    return idamage;
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xf223064c, Offset: 0x774a
// Size: 0xa9
function private function_7e38b19400aafd9d( einflictor, idamage )
{
    current_time = gettime();
    
    if ( !isdefined( einflictor ) )
    {
        return idamage;
    }
    
    if ( isdefined( einflictor.var_ccece36867a1c869 ) && einflictor.var_ccece36867a1c869 - current_time > 100 )
    {
        einflictor.var_ccece36867a1c869 = gettime();
        einflictor.var_1b47dc19ddc8f2ca = 1;
    }
    else if ( einflictor.var_1b47dc19ddc8f2ca >= 20 )
    {
        idamage = 0;
    }
    else
    {
        einflictor.var_ccece36867a1c869 = gettime();
        einflictor.var_1b47dc19ddc8f2ca++;
    }
    
    return idamage;
}

// Namespace zm_sat_firefly_pap_quest
// Params 11, eflags: 0x4
// Checksum 0x60fcd5d4, Offset: 0x77fc
// Size: 0xfa
function private function_32d7ec6937cda318( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_firefly_pap_aether_generator_infestation_core" )
    {
        return;
    }
    
    if ( instance.var_55a3da08bd6a9a23.curr_stage != 1 || instance.var_55a3da08bd6a9a23 utility::ent_flag( "stage_changing" ) )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        idamage = instance function_1738a9033650c95e( idamage, smeansofdeath, objweapon );
        
        if ( idamage > 0 )
        {
            eattacker damagefeedback::updatehitmarker( "standard", undefined, 1, 0, undefined );
            instance.var_55a3da08bd6a9a23 function_ea2137afc8a3b24f( idamage );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x81f6e8c1, Offset: 0x78fe
// Size: 0x1da
function private function_1738a9033650c95e( idamage, smeansofdeath, objweapon )
{
    max_health = self.var_55a3da08bd6a9a23.var_86434b12a77588d7;
    
    if ( isdefined( objweapon ) && weapon::iswonderweapon( objweapon ) )
    {
        var_8f98d87abe348e13 = int( max_health * 0.51 );
        idamage = int( min( idamage, var_8f98d87abe348e13 ) );
        return idamage;
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_a5123f4d02745600":
            var_8f98d87abe348e13 = int( max_health * 0.15 ) + 1;
            idamage = int( min( idamage, var_8f98d87abe348e13 ) );
            return idamage;
        default:
            break;
    }
    
    if ( objweapon.classname == "grenade" )
    {
        var_8f98d87abe348e13 = int( max_health * 0.51 );
        idamage = int( min( idamage, var_8f98d87abe348e13 ) );
        return idamage;
    }
    
    if ( objweapon.basename == "rcxd" )
    {
        if ( smeansofdeath != "MOD_EXPLOSIVE" )
        {
            return 0;
        }
        else
        {
            var_8f98d87abe348e13 = int( max_health * 0.51 );
            idamage = int( min( idamage, var_8f98d87abe348e13 ) );
        }
        
        return idamage;
    }
    
    if ( objweapon.classname == "rocketlauncher" )
    {
        if ( utility::issharedfuncdefined( #"zm_dinj", #"get_weapon_name" ) )
        {
            if ( objweapon.basename == utility::callsharedfunc( #"zm_dinj", #"get_weapon_name" ) )
            {
                if ( smeansofdeath == "MOD_PROJECTILE" )
                {
                    idamage = int( max_health * 0.15 );
                }
                else if ( smeansofdeath == "MOD_IMPACT" )
                {
                    idamage = int( max_health * 0.35 );
                }
                
                return idamage;
            }
        }
        
        var_8f98d87abe348e13 = int( max_health * 1 );
        idamage = int( min( idamage, var_8f98d87abe348e13 ) );
        return idamage;
    }
    
    return idamage;
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xa199cedf, Offset: 0x7ae1
// Size: 0x1d4
function private function_ea2137afc8a3b24f( n_dmg_amount )
{
    if ( self.curr_stage != 1 )
    {
        b_cleared = function_d67123b017a26934();
        
        if ( b_cleared )
        {
            self notify( #"end_curr_state" );
            var_40239747c9290ca6 = self.curr_stage - 1;
            
            switch ( var_40239747c9290ca6 )
            {
                case 1:
                    function_e473767afd8ade08();
                    break;
                default:
                    break;
            }
        }
        else
        {
            var_3471316e3ec32d4a = get_pustule_progress_percent();
            
            if ( self == level.pap_quest.curr_generator )
            {
                if ( self.loc_str == "sunken" )
                {
                    level zm_quest::function_9f49b2a045ece8ae( var_3471316e3ec32d4a, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
                }
                else
                {
                    function_ffd992482ca10a76( var_3471316e3ec32d4a );
                }
            }
        }
        
        return;
    }
    
    self.var_fd850913e59c56a8 -= n_dmg_amount;
    
    if ( self.var_fd850913e59c56a8 <= 0 )
    {
        /#
            iprintlnbold( "<dev string:x19d>" );
        #/
        
        self notify( #"end_curr_state" );
        var_962c36abf8fc1624 = 0;
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) )
            {
                var_962c36abf8fc1624++;
            }
        }
        
        if ( var_962c36abf8fc1624 == 0 )
        {
            thread function_f29a971fb5b401d9();
        }
        
        function_20189923a1c8d801();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xcda1e421, Offset: 0x7cbd
// Size: 0x92
function private function_d67123b017a26934()
{
    var_f8c0db3845f6672f = 1;
    
    foreach ( pustule in self.var_fb44f2f10bdb1bd8 )
    {
        if ( !pustule.destroyed )
        {
            var_f8c0db3845f6672f = 0;
        }
    }
    
    return var_f8c0db3845f6672f;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x5b7c355e, Offset: 0x7d58
// Size: 0xb9
function private get_pustule_progress_percent()
{
    var_2eca7dc2f0b7b425 = self.var_fb44f2f10bdb1bd8.size;
    var_74e47ec77c7aec8 = 0;
    
    foreach ( pustule in self.var_fb44f2f10bdb1bd8 )
    {
        if ( !pustule.destroyed )
        {
            var_74e47ec77c7aec8++;
        }
    }
    
    var_5a8534fc98aaa306 = var_74e47ec77c7aec8 / var_2eca7dc2f0b7b425;
    return 80 * var_5a8534fc98aaa306 + 20;
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0xc
// Checksum 0xa828bdc, Offset: 0x7e1a
// Size: 0x1c9
function private molotov_used_watcher()
{
    self notify( #"hash_7ae593900f857012" );
    self endon( #"hash_7ae593900f857012" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_559ad6ce148c89f3", grenade );
        var_4d0b4c7baa1aec17 = getentitylessscriptablearray( %"zm_sat_firefly_pap_aether_generator_pustule_01", undefined, grenade.origin, 30 );
        var_4d0b4c7baa1aec17 = arraycombine( var_4d0b4c7baa1aec17, getentitylessscriptablearray( %"zm_sat_firefly_pap_aether_generator_pustule_02", undefined, grenade.origin, 30 ) );
        var_4d0b4c7baa1aec17 = arraycombine( var_4d0b4c7baa1aec17, getentitylessscriptablearray( %"zm_sat_firefly_pap_aether_generator_pustule_03", undefined, grenade.origin, 30 ) );
        
        foreach ( pustule in var_4d0b4c7baa1aec17 )
        {
            pustule thread function_6bc32f047ad1046c( self, grenade );
        }
        
        a_cores = getentitylessscriptablearray( %"zm_sat_firefly_pap_aether_generator_infestation_core", undefined, grenade.origin, 95 );
        
        foreach ( core in a_cores )
        {
            core thread function_6bc32f047ad1046c( self, grenade );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0xc
// Checksum 0xc97a2418, Offset: 0x7feb
// Size: 0x162
function private function_6bc32f047ad1046c( player, grenade )
{
    self notify( #"hash_9a813a08567d94cb" );
    self endon( #"hash_9a813a08567d94cb" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self.var_55a3da08bd6a9a23 endon( #"cooling_down" );
    time_elapsed = 0;
    
    while ( true )
    {
        if ( time_elapsed >= 8 )
        {
            return;
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( self getscriptablepartstate( "health" ) == "ignore_damage" || self getscriptablepartstate( "body" ) == "hidden" )
        {
            wait 0.25;
            time_elapsed += 0.25;
            continue;
        }
        
        if ( self.type == %"zm_sat_firefly_pap_aether_generator_pustule_01" || self.type == %"zm_sat_firefly_pap_aether_generator_pustule_02" || self.type == %"zm_sat_firefly_pap_aether_generator_pustule_03" )
        {
            pustule_damaged( undefined, player, self, 15, undefined, "MOD_EXPLOSIVE", grenade.object_weapon );
        }
        else if ( self.type == %"zm_sat_firefly_pap_aether_generator_infestation_core" )
        {
            function_32d7ec6937cda318( undefined, player, self, 15, undefined, "MOD_EXPLOSIVE", grenade.object_weapon );
        }
        
        wait 0.25;
        time_elapsed += 0.25;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x61c7083a, Offset: 0x8155
// Size: 0x1f
function private function_99e59c97b426f7e4()
{
    level endon( #"game_ended" );
    wait 1.5;
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xf540c6cb, Offset: 0x817c
// Size: 0x179
function private function_e407f1f156fa0e80( starting_player )
{
    /#
        iprintlnbold( "<dev string:x1bc>" );
    #/
    
    if ( !level utility::flag( "first_clear_infestation_event_started" ) )
    {
        level utility::flag_set( "first_clear_infestation_event_started" );
        starting_player thread function_3ad7970229098e00();
    }
    
    if ( !isdefined( level.pap_quest.curr_generator ) )
    {
        level.pap_quest.curr_generator = self;
    }
    
    if ( self.loc_str == "sunken" )
    {
        level notify( #"clear_infestation_event_started_sunken" );
    }
    else
    {
        level notify( #"hash_2471703945bc8d31" );
        var_541f95354e1eb1d1 = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_cadac07a2223c10b" );
        
        if ( !var_541f95354e1eb1d1.completed )
        {
            var_541f94354e1eaf9e = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
            level zm_quest::function_e65609834444650c( var_541f94354e1eaf9e, 0 );
        }
    }
    
    self.var_fd850913e59c56a8 = function_7367854d740d847();
    function_5209673ff777c461();
    level notify( #"clear_infestation_event_started" );
    
    if ( !isdefined( self.var_5a59e4113644766b ) )
    {
        self.var_5a59e4113644766b = 1;
    }
    else
    {
        self.var_5a59e4113644766b++;
    }
    
    self setscriptablepartstate( "audio", "stinger_begin" );
    function_a49c78e7e4973e7e( 3 );
    utility::ent_flag_set( "infestation_event_active" );
    thread function_5bac3a0f0ebc8253();
    thread function_8d09937a343f0011();
    function_67fb65497998083();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x17a4cae8, Offset: 0x82fd
// Size: 0x20a
function private function_8d09937a343f0011()
{
    level endon( #"game_ended" );
    self endon( #"infestation_cleared" );
    b_on_hud = 0;
    
    if ( !level utility::flag( "clear_infestation_hud_timer_in_progress" ) )
    {
        b_on_hud = 1;
        level utility::flag_set( "clear_infestation_hud_timer_in_progress" );
        thread function_fd6ff76c73e2d908();
        
        if ( level.pap_quest.ref == #"hash_6da5e0cc8bfa9384" )
        {
            key_ref = #"hash_6da5e0cc8bfa9384";
            step_ref = #"clear_infestation";
        }
        else if ( level.pap_quest.ref == #"hash_2b20061a83c98bc8" )
        {
            key_ref = #"hash_2b20061a83c98bc8";
            step_ref = #"clear_infestation";
        }
        else if ( self.loc_str == "sunken" )
        {
            key_ref = #"firefly_pap_quest";
            step_ref = #"hash_75327ace4466fad5";
        }
        else if ( utility::flag( "first_generator_cleared" ) )
        {
            key_ref = #"hash_9deee04807c7b80c";
            step_ref = #"clear_infestation";
        }
        else
        {
            key_ref = #"firefly_pap_quest";
            step_ref = #"hash_cadac07a2223c10b";
        }
        
        step = zm_quest::get_quest_step( key_ref, step_ref );
        step thread function_11b494bcb828faeb();
        step utility::waittill_any( "zm_quest_step_tracker_showing", "splash_before_tracker_timeout" );
    }
    
    time_left = getdvarint( @"hash_dd75894db09e49fe", 30 );
    
    while ( true )
    {
        if ( b_on_hud )
        {
            zm_quest::function_612a9ad0db22c29c( time_left * 1000, 1, key_ref, step_ref );
            var_3471316e3ec32d4a = get_pustule_progress_percent();
            
            if ( self == level.pap_quest.curr_generator )
            {
                if ( self.loc_str == "sunken" )
                {
                    level zm_quest::function_9f49b2a045ece8ae( var_3471316e3ec32d4a, 1, key_ref, step_ref );
                }
                else
                {
                    function_ffd992482ca10a76( var_3471316e3ec32d4a );
                }
            }
        }
        
        wait 1;
        time_left--;
        
        if ( time_left <= 0 )
        {
            function_5c8cae29c3778e59();
            return;
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x78fc5f97, Offset: 0x850f
// Size: 0x29
function private function_11b494bcb828faeb()
{
    level endon( #"game_ended" );
    self endon( #"zm_quest_step_tracker_showing" );
    wait 10;
    self notify( #"splash_before_tracker_timeout" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xacf416e7, Offset: 0x8540
// Size: 0x2c
function private function_fd6ff76c73e2d908()
{
    level endon( #"game_ended" );
    utility::ent_flag_wait_any( "infestation_cleared", "cooling_down" );
    level utility::flag_clear( "clear_infestation_hud_timer_in_progress" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x4b48752a, Offset: 0x8574
// Size: 0x1ce
function private function_5bac3a0f0ebc8253()
{
    level endon( #"game_ended" );
    self endon( #"infestation_cleared" );
    self endon( #"cooling_down" );
    a_alive_players = utility::get_alive_players();
    max_spawn_count = a_alive_players.size * 5 + 10;
    round_number = zm_round_logic::get_rb_round_number();
    var_de539f54e6451957 = function_3807d834d4cba337();
    zombie_spawn_interval = 2;
    
    if ( zm_utility::get_round_number() > 4 )
    {
        zombie_spawn_interval = 5;
    }
    else if ( self.var_5a59e4113644766b > 2 )
    {
        zombie_spawn_interval = 5;
    }
    
    spawner_zombie_type = "zombie_base";
    
    while ( utility::ent_flag( "infestation_event_active" ) )
    {
        zombies_count = zm_utility::get_active_zombies_count();
        var_ae1ed70b7b50bc1a = getaiarrayinradius( self.origin, 750, zm_utility::get_zombie_team() );
        
        if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            var_29155e0ed4821acf = arraycombineunique( var_ae1ed70b7b50bc1a, self.var_725afa5fbef29930 );
            var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ], var_29155e0ed4821acf );
            
            if ( !var_d7b3a1f33b95bf77 )
            {
                waitframe();
                continue;
            }
        }
        
        if ( var_ae1ed70b7b50bc1a.size >= max_spawn_count )
        {
            waitframe();
            continue;
        }
        
        spawners = zone_spawner::function_20c574a6ba7cc5c6( var_de539f54e6451957, spawner_zombie_type );
        
        if ( !isdefined( spawners ) || spawners.size <= 0 )
        {
            waitframe();
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        spawnerdist = distancesquared( self.origin, zmb_spawner.origin );
        
        if ( spawnerdist > squared( 800 ) )
        {
            waitframe();
            continue;
        }
        
        thread function_727a6ade54c0d137( spawner_zombie_type, zmb_spawner, round_number );
        wait zombie_spawn_interval;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x5934159f, Offset: 0x874a
// Size: 0xb5
function private function_3807d834d4cba337()
{
    assert( isdefined( self.loc_str ), "<dev string:x1d6>" );
    
    switch ( self.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            var_cfdcb332178e0755 = [ "zone_lakefront_cliffs_south" ];
            break;
        case #"hash_9c5e8152de8ef99":
            var_cfdcb332178e0755 = [ "zone_farm", "zone_farm_gate" ];
            break;
        case #"hash_eff0649069653dd":
            var_cfdcb332178e0755 = [ "zone_sunken_platform", "zone_sunken_platform_close_to_brothel" ];
            break;
        default:
            assertmsg( "<dev string:x17f>" );
            break;
    }
    
    return var_cfdcb332178e0755;
}

// Namespace zm_sat_firefly_pap_quest
// Params 3, eflags: 0x4
// Checksum 0x393f8342, Offset: 0x8808
// Size: 0x142
function private function_727a6ade54c0d137( zombie_type, spawner, round_number )
{
    if ( !utility::ent_flag( "infestation_event_active" ) )
    {
        return;
    }
    
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie zombie_emergence_spawning::function_80623a2279a4d888();
        zombie val::set( "firefly_pap_quest", "allow_brot", 0 );
        zombie val::set( "firefly_pap_quest", "ignore_cleanup", 1 );
        zombie.ignore_enemy_count = 1;
        zombie.no_powerups = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.var_4ba4d2d97fbec4d4 = 1;
        zombie callback::add( #"on_ai_killed", &function_e6721f649aae3843, { #var_55a3da08bd6a9a23:self } );
        zombie zombie_utils::set_zombie_round_difficulty( round_number );
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        self.var_725afa5fbef29930[ self.var_725afa5fbef29930.size ] = zombie;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xe6d0790e, Offset: 0x8952
// Size: 0x5d
function private function_e6721f649aae3843( params, s_additional_params )
{
    if ( isdefined( s_additional_params.var_55a3da08bd6a9a23.var_725afa5fbef29930 ) )
    {
        s_additional_params.var_55a3da08bd6a9a23.var_725afa5fbef29930 = function_46f9072493651dc9( s_additional_params.var_55a3da08bd6a9a23.var_725afa5fbef29930 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x409d9cf8, Offset: 0x89b7
// Size: 0x162
function private function_892cee25f9038001()
{
    level endon( #"game_ended" );
    utility::ent_flag_set( "stage_changing" );
    utility::ent_flag_clear( "infestation_event_active" );
    self.curr_stage = 2;
    self.var_fdd148a56ef7ce64 = 1;
    
    if ( self == level.pap_quest.curr_generator )
    {
        if ( self.loc_str == "sunken" )
        {
            level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
        }
        else
        {
            function_ffd992482ca10a76( 100 );
        }
    }
    
    function_a49c78e7e4973e7e( 4 );
    
    /#
        iprintlnbold( "<dev string:x207>" );
    #/
    
    self setscriptablepartstate( "audio", "stinger_respawn" );
    
    foreach ( cylinder in self.a_cylinders )
    {
        cylinder setscriptablepartstate( "fx", "infestation_active" );
    }
    
    function_1c2a5173b92f8069( self.var_4d0b4c7baa1aec17 );
    self.var_fd850913e59c56a8 = function_7367854d740d847();
    utility::ent_flag_clear( "stage_changing" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xb445531c, Offset: 0x8b21
// Size: 0x22e
function private function_e473767afd8ade08()
{
    level endon( #"game_ended" );
    utility::ent_flag_set( "stage_changing" );
    utility::ent_flag_set( "infestation_event_active" );
    self.curr_stage = 1;
    
    if ( self == level.pap_quest.curr_generator )
    {
        if ( self.loc_str == "sunken" )
        {
            level zm_quest::function_9f49b2a045ece8ae( 20, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
        }
        else
        {
            function_ffd992482ca10a76( 20 );
        }
    }
    
    waitframe();
    self.var_2e34876e86fba0d0 setscriptablepartstate( "body", "show" );
    self.var_2e34876e86fba0d0 setscriptablepartstate( "health", "damage_detect" );
    self.var_2e34876e86fba0d0.vines setscriptablepartstate( "body", "hide" );
    self setscriptablepartstate( "fx", "layer_destroyed" );
    self setscriptablepartstate( "audio", "stinger_core" );
    
    foreach ( pustule in self.var_4d0b4c7baa1aec17 )
    {
        pustule utility::function_32b24db3127bff40( "body", "hidden" );
    }
    
    foreach ( cylinder in self.a_cylinders )
    {
        cylinder setscriptablepartstate( "fx", "layer_destroyed" );
    }
    
    self.var_fd850913e59c56a8 = function_45fc1397bf6c0924();
    self.var_86434b12a77588d7 = self.var_fd850913e59c56a8;
    function_67fb65497998083();
    utility::ent_flag_clear( "stage_changing" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xd95da87a, Offset: 0x8d57
// Size: 0x57d
function private function_20189923a1c8d801( b_skip_wait = 0, var_9682afafe2425248 = 0 )
{
    if ( utility::ent_flag( "infestation_cleared" ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    if ( level utility::flag( "first_generator_cleared" ) && self.loc_str != "sunken" )
    {
        step = zm_quest::get_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation_setup" );
        
        if ( !step.completed )
        {
            level zm_quest::function_e65609834444650c( step, undefined, 0 );
        }
        
        step = zm_quest::get_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation" );
        
        if ( !step.completed )
        {
            level zm_quest::function_e65609834444650c( step, undefined, 0 );
        }
    }
    
    if ( self.loc_str != "lakefront" && self.power_switch_sbl getscriptablepartstate( "audio" ) != "on" )
    {
        self.power_switch_sbl.handle_mdl setscriptablepartstate( "base", "static" );
    }
    else if ( self.loc_str == "lakefront" && self.power_switch_sbl getscriptablepartstate( "electrical_box" ) != "on" )
    {
        self.power_switch_sbl setscriptablepartstate( "base", "static" );
    }
    
    utility::ent_flag_set( "stage_changing" );
    utility::ent_flag_clear( "infestation_event_active" );
    utility::ent_flag_set( "infestation_cleared" );
    
    switch ( self.loc_str )
    {
        case #"hash_9c5e8152de8ef99":
            level utility::flag_set( "first_generator_cleared" );
            
            if ( !var_9682afafe2425248 )
            {
                zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 2 );
            }
            
            function_ffd992482ca10a76( 0 );
            break;
        case #"hash_2f38b0d124dff2c9":
            level utility::flag_set( "first_generator_cleared" );
            
            if ( !var_9682afafe2425248 )
            {
                zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 1 );
            }
            
            function_ffd992482ca10a76( 0 );
            break;
        case #"hash_eff0649069653dd":
            if ( isdefined( level.pap_quest.curr_generator ) && self == level.pap_quest.curr_generator )
            {
                level zm_quest::function_9f49b2a045ece8ae( 0, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
            }
            
            break;
        default:
            assertmsg( "<dev string:x21d>" );
            break;
    }
    
    if ( self == level.pap_quest.curr_generator )
    {
        level.pap_quest.curr_generator = undefined;
    }
    
    function_a49c78e7e4973e7e( 1 );
    
    /#
        iprintlnbold( "<dev string:x245>" );
    #/
    
    if ( !b_skip_wait )
    {
        waitframe();
        
        if ( self.loc_str != "sunken" )
        {
            var_1e5d9b3acb8a3e5d = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_77439cafa364fc99" );
            var_1e5d9a3acb8a3c2a = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_cadac07a2223c10b" );
            
            if ( !var_1e5d9b3acb8a3e5d.completed )
            {
                level zm_quest::function_e65609834444650c( var_1e5d9b3acb8a3e5d );
            }
            
            if ( !var_1e5d9a3acb8a3c2a.completed )
            {
                level zm_quest::function_e65609834444650c( var_1e5d9a3acb8a3c2a, undefined, 0 );
            }
        }
        else
        {
            step = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_5d0575e20f0d331b" );
            
            if ( !step.completed )
            {
                level zm_quest::function_e65609834444650c( step );
            }
            
            step = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_75327ace4466fad5" );
            
            if ( !step.completed )
            {
                level zm_quest::function_e65609834444650c( step, undefined, 0 );
            }
        }
    }
    
    self setscriptablepartstate( "audio", "stinger_success" );
    self setscriptablepartstate( "fx", "cleared" );
    
    foreach ( cylinder in self.a_cylinders )
    {
        cylinder setscriptablepartstate( "fx", "cleared" );
    }
    
    self.var_2e34876e86fba0d0 setscriptablepartstate( "body", "bursted" );
    self.var_2e34876e86fba0d0 thread utility::delaythread( 3, &function_99e59c97b426f7e4 );
    self.var_2e34876e86fba0d0.vines freescriptable();
    
    foreach ( pustule in self.var_4d0b4c7baa1aec17 )
    {
        pustule freescriptable();
    }
    
    function_9efe4fb54799f9e8();
    function_67fb65497998083( "evt_ee_complete_success_stinger" );
    utility::ent_flag_clear( "stage_changing" );
    
    if ( self.power_switch_sbl utility::ent_flag( "on" ) )
    {
        activate_generator( var_9682afafe2425248 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1
// Checksum 0x8af7668f, Offset: 0x92dc
// Size: 0x2c0
function function_5c8cae29c3778e59( b_save_restored = 0 )
{
    level endon( #"game_ended" );
    self notify( #"end_curr_state" );
    utility::ent_flag_clear( "infestation_event_active" );
    utility::ent_flag_set( "cooling_down" );
    self.curr_stage = 0;
    
    if ( !b_save_restored )
    {
        if ( !level utility::flag( "generator_failed_first_time" ) )
        {
            level utility::flag_set( "generator_failed_first_time" );
            thread function_26ad7e7aed602b4d();
        }
    }
    else
    {
        level utility::flag_set( "generator_failed_first_time" );
    }
    
    if ( self == level.pap_quest.curr_generator )
    {
        if ( self.loc_str == "sunken" )
        {
            level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"firefly_pap_quest", #"hash_75327ace4466fad5" );
        }
        else
        {
            function_ffd992482ca10a76( 100 );
        }
        
        level.pap_quest.curr_generator = undefined;
    }
    
    function_a49c78e7e4973e7e( 3 );
    
    /#
        iprintlnbold( "<dev string:x259>" );
    #/
    
    waitframe();
    self.var_2e34876e86fba0d0 setscriptablepartstate( "body", "cooldown" );
    self.var_2e34876e86fba0d0.vines setscriptablepartstate( "body", "covered" );
    self setscriptablepartstate( "audio", "stinger_fail" );
    
    foreach ( pustule in self.var_fb44f2f10bdb1bd8 )
    {
        if ( pustule getscriptablepartstate( "body" ) == "show" )
        {
            pustule setscriptablepartstate( "body", "stone" );
            continue;
        }
        
        arrayremove( self.var_fb44f2f10bdb1bd8, pustule );
    }
    
    self setscriptablepartstate( "fx", "failed" );
    
    foreach ( cylinder in self.a_cylinders )
    {
        cylinder setscriptablepartstate( "fx", "failed" );
    }
    
    function_9efe4fb54799f9e8();
    
    if ( b_save_restored )
    {
        level waittill( #"on_round_start" );
    }
    
    level waittill( #"on_round_start" );
    utility::ent_flag_clear( "cooling_down" );
    thread function_892cee25f9038001();
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xea8c5472, Offset: 0x95a4
// Size: 0x22
function private function_7dcb9145104fe9af()
{
    level endon( #"game_ended" );
    function_20189923a1c8d801( 1, 1 );
    activate_generator( 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x30ba18e3, Offset: 0x95ce
// Size: 0x1a8
function private function_a49c78e7e4973e7e( stage )
{
    if ( !isdefined( stage ) )
    {
        switch ( self.loc_str )
        {
            case #"hash_2f38b0d124dff2c9":
                level zm_quest::function_6265be8d0549e1b1( level.pap_quest.ref, #"hash_57ced84c016c6c03" );
                break;
            case #"hash_9c5e8152de8ef99":
                level zm_quest::function_6265be8d0549e1b1( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" );
                break;
            case #"hash_eff0649069653dd":
                level zm_quest::function_6265be8d0549e1b1( level.pap_quest.ref, #"hash_1e8ab1b59c374367" );
                break;
            default:
                assertmsg( "<dev string:x17f>" );
                break;
        }
        
        return;
    }
    
    switch ( self.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"hash_57ced84c016c6c03", stage );
            break;
        case #"hash_9c5e8152de8ef99":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"hash_2b65c5a85d3afd93", stage );
            break;
        case #"hash_eff0649069653dd":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"hash_1e8ab1b59c374367", stage );
            break;
        default:
            assertmsg( "<dev string:x17f>" );
            break;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x4dfd3f2c, Offset: 0x977e
// Size: 0x12f
function private function_9efe4fb54799f9e8()
{
    level endon( #"game_ended" );
    playfxontag( level._effect[ "generator_blast" ], self, "tag_origin" );
    wait 0.5;
    
    foreach ( zom in self.var_725afa5fbef29930 )
    {
        zom thread function_a7c08aebf358218();
    }
    
    var_f1e09242bd38f8a = getaiarrayinradius( self.origin, 800, zm_utility::get_zombie_team() );
    
    foreach ( zom in var_f1e09242bd38f8a )
    {
        zom thread function_a7c08aebf358218();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x7cfce554, Offset: 0x98b5
// Size: 0x16b
function private function_a7c08aebf358218()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.aicategory == "hvt" || self.aicategory == "boss" )
    {
        return;
    }
    
    if ( !zm_utility::is_active_zombie( self ) )
    {
        return;
    }
    
    if ( val::get( "damageshield" ) )
    {
        return;
    }
    
    if ( self.var_698cf8d8d4a8cbb9 )
    {
        self.nuked = 1;
        self.full_gib = 1;
        self.forceannihilate = 1;
        self.no_powerups = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self.var_66504c8a8a5ed6dd = 1;
        self kill();
    }
    
    if ( !self.var_4ba4d2d97fbec4d4 && self.aicategory != "normal" )
    {
        zm_cleanup_manager::function_44f5bec4abb163f1( undefined, 1 );
        return;
    }
    
    zombie_stun::stun_ai( 100 );
    wait randomfloatrange( 0.25, 0.5 );
    
    if ( isalive( self ) )
    {
        if ( !self.var_4ba4d2d97fbec4d4 && self.aicategory == "normal" )
        {
            zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        self.nuked = 1;
        self.full_gib = 1;
        self.forceannihilate = 1;
        self.no_powerups = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self.var_66504c8a8a5ed6dd = 1;
        self kill();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x8cca291a, Offset: 0x9a28
// Size: 0xb6
function private function_67fb65497998083( sound_alias_override )
{
    a_players = getplayersinradius( self.origin, 500 );
    
    foreach ( player in a_players )
    {
        player playrumbleonentity( "damage_heavy" );
        player earthquakeforplayer( 0.3, 2, player.origin, 100 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x630adbfb, Offset: 0x9ae6
// Size: 0x89
function private generator_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( isdefined( level.var_cbe0c7aecbbd5064 ) )
    {
        return [[ level.var_cbe0c7aecbbd5064 ]]( interact, player );
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xe4a8118a, Offset: 0x9b78
// Size: 0x3e
function private function_11839ec085cbe55f( player )
{
    if ( isdefined( level.var_ef98efe43679ef7a ) )
    {
        return [[ level.var_ef98efe43679ef7a ]]( self, player );
    }
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1
// Checksum 0x681d1ed, Offset: 0x9bbf
// Size: 0x72
function on_player_connect( params )
{
    if ( level utility::flag_exist( "power_on1" ) )
    {
        utility::delaythread( 10, &function_e9389fe557ab47ee, "we_lgt_power_on_cabin" );
    }
    
    if ( level utility::flag_exist( "power_on2" ) )
    {
        utility::delaythread( 10, &function_e9389fe557ab47ee, "we_lgt_power_on_farm" );
    }
    
    if ( level utility::flag_exist( "power_on3" ) )
    {
        utility::delaythread( 10, &function_e9389fe557ab47ee, "we_lgt_power_on_ashwood" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x50697007, Offset: 0x9c39
// Size: 0x13
function private function_e9389fe557ab47ee( world_event )
{
    activateworldevent( world_event );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x4d6eb9fc, Offset: 0x9c54
// Size: 0x13
function private function_2887c738fc2a5395( world_event )
{
    deactivateworldevent( world_event );
}

// Namespace zm_sat_firefly_pap_quest
// Params 3, eflags: 0x4
// Checksum 0xe6c09680, Offset: 0x9c6f
// Size: 0x480
function private activate_generator( var_9682afafe2425248 = 0, b_skip_wait = 0, activating_player )
{
    level endon( #"game_ended" );
    
    if ( !var_9682afafe2425248 && activating_player )
    {
        var_8ed81d894da30d42 = 0;
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( var_55a3da08bd6a9a23 utility::ent_flag( "activated" ) )
            {
                var_8ed81d894da30d42++;
            }
        }
        
        if ( var_8ed81d894da30d42 == 0 )
        {
            thread function_bdc49698e401c257( activating_player );
        }
        else if ( var_8ed81d894da30d42 == 2 )
        {
            thread function_10452585f63bcddf( activating_player );
        }
    }
    
    if ( utility::ent_flag( "activated" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "activated" );
    
    if ( var_9682afafe2425248 )
    {
        b_skip_wait = 1;
    }
    
    /#
        iprintlnbold( "<dev string:x272>" );
    #/
    
    function_a49c78e7e4973e7e( 2 );
    self setmodel( %"sat_zm_aether_energy_generator_main_on_fxanim" );
    self setscriptablepartstate( "fx", "activate" );
    thread generator_rumble_manager();
    
    if ( !var_9682afafe2425248 )
    {
        foreach ( cylinder in self.a_cylinders )
        {
            cylinder setscriptablepartstate( "fx", "on" );
        }
    }
    else
    {
        foreach ( cylinder in self.a_cylinders )
        {
            cylinder setscriptablepartstate( "fx", "force_on" );
        }
    }
    
    switch ( self.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            level utility::flag_set( "generator_1_activated" );
            
            if ( !var_9682afafe2425248 )
            {
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 1 );
            }
            
            if ( !b_skip_wait )
            {
                wait 5;
            }
            
            level utility::flag_set( "power_on1" );
            activateworldevent( "we_lgt_power_on_cabin" );
            level function_7e95b2322b9820b6( "lakefront" );
            break;
        case #"hash_9c5e8152de8ef99":
            level utility::flag_set( "generator_1_activated" );
            
            if ( !var_9682afafe2425248 )
            {
                level zm_quest::function_4eefe6de31f5ddab( #"firefly_pap_quest", #"wood_barrier_side", 2 );
            }
            
            if ( !b_skip_wait )
            {
                wait 0.6;
                wait 5;
            }
            
            level utility::flag_set( "power_on2" );
            activateworldevent( "we_lgt_power_on_farm" );
            level function_7e95b2322b9820b6( "farm" );
            break;
        case #"hash_eff0649069653dd":
            level utility::flag_set( "generator_sunken_activated" );
            
            if ( !b_skip_wait )
            {
                wait 0.6;
                wait 5;
            }
            
            level utility::flag_set( "power_on3" );
            activateworldevent( "we_lgt_power_on_ashwood" );
            level function_7e95b2322b9820b6( "sunken" );
            break;
        default:
            assert( "<dev string:x287>" + self.loc_str );
            break;
    }
    
    utility::flag_set( self.var_bb3cfcbf65750e32 );
    
    if ( level utility::flag( "power_on2" ) && level utility::flag( "power_on1" ) )
    {
        foreach ( step in level.var_759d027eca7a10d1.steps )
        {
            if ( !step.completed )
            {
                level zm_quest::function_e65609834444650c( step );
            }
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3b557891, Offset: 0xa0f7
// Size: 0x5d
function private generator_rumble_manager()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"generator_rumble" );
        thread zm_utility::function_1d82e63812f9640a( self.origin, 200, 0.5, "damage_heavy", 0.2, 300, "damage_light", 0.15 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x51f119b0, Offset: 0xa15c
// Size: 0x3c4
function private setup_power_switch_assets()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "pap_generator_assets_init_complete" );
    var_b5809cfa7fb65f9 = utility::getstructarray( "power_switch", "targetname" );
    
    foreach ( struct in var_b5809cfa7fb65f9 )
    {
        assert( isdefined( level.pap_quest.a_generators[ struct.script_parameters ] ), "<dev string:x2b2>" );
        
        if ( struct.script_parameters == "lakefront" )
        {
            switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch_lake", struct.origin, struct.angles );
            switch_sbl thread function_e3e5bc3589b6c96e();
        }
        else
        {
            if ( struct.script_parameters == "sunken" )
            {
                switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch_small", struct.origin, struct.angles );
            }
            else
            {
                switch_sbl = spawnscriptable( %"zm_sat_firefly_pap_power_switch", struct.origin, struct.angles );
            }
            
            s_handle = utility::getstruct( struct.target, "targetname" );
            switch_sbl.handle_mdl = utility::spawn_model( %"sat_zm_power_switch_handle", s_handle.origin, s_handle.angles );
        }
        
        switch_interact = interaction::register_scriptable_interact( switch_sbl, &attempt_flip_power_switch, undefined, undefined, &power_switch_hint );
        switch_interact.var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ struct.script_parameters ];
        level.pap_quest.a_generators[ struct.script_parameters ].power_switch_sbl = switch_sbl;
    }
    
    a_waypoints = utility::getstructarray( "travel_to_sunken_waypoint_1", "targetname" );
    
    foreach ( struct in a_waypoints )
    {
        assert( isdefined( struct.script_parameters ), "<dev string:x2f8>" );
        level.pap_quest.a_generators[ struct.script_parameters ].var_d4ac234ee368c2ca = struct;
    }
    
    a_waypoints = utility::getstructarray( "travel_to_sunken_waypoint_2", "targetname" );
    
    foreach ( struct in a_waypoints )
    {
        assert( isdefined( struct.script_parameters ), "<dev string:x2f8>" );
        level.pap_quest.a_generators[ struct.script_parameters ].var_d4ac224ee368c097 = struct;
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level thread function_b24cbe85607f5b23();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb9c07ed6, Offset: 0xa528
// Size: 0x102
function private power_switch_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) )
    {
        hintstring_obj = { #icon:"sat_ui_icon_zm_generic_power_switch", #buttoncallout:&"SHARED_HINTSTRINGS/USE", #description:&"zm_sat_firefly/pap_power_switch_desc", #title:&"zm_sat_firefly/pap_power_switch_title", #type:"HINT_BUTTON" };
        return hintstring_obj;
    }
    else
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_firefly_pap_quest
// Params 3, eflags: 0x4
// Checksum 0xa51e04af, Offset: 0xa633
// Size: 0x29f
function private attempt_flip_power_switch( player, var_9682afafe2425248 = 0, b_skipped = 0 )
{
    if ( utility::ent_flag( "on" ) )
    {
        return;
    }
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( utility::ent_flag( "power_switch_reset_in_progress" ) )
    {
        return;
    }
    
    if ( !self.var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) )
    {
        level endon( #"game_ended" );
        utility::ent_flag_set( "power_switch_reset_in_progress" );
        
        if ( self.var_55a3da08bd6a9a23.loc_str != "lakefront" )
        {
            self setscriptablepartstate( "audio", "on_nopower" );
            rotate_flip_power_switch();
            wait 0.5;
            self setscriptablepartstate( "audio", "on_to_off" );
            rotate_flip_power_switch( 0.5, 1 );
        }
        else
        {
            self setscriptablepartstate( "electrical_box", "on_and_then_reset" );
            wait 0.75;
        }
        
        utility::ent_flag_clear( "power_switch_reset_in_progress" );
        return;
    }
    
    if ( self.var_55a3da08bd6a9a23.loc_str != "lakefront" )
    {
        self setscriptablepartstate( "audio", "on" );
        thread rotate_flip_power_switch();
        self.handle_mdl setscriptablepartstate( "base", "hide" );
        self.handle_mdl calloutmarkerping::function_608710c894185549();
    }
    
    self.var_55a3da08bd6a9a23 thread activate_generator( var_9682afafe2425248, b_skipped, player );
    
    switch ( self.var_55a3da08bd6a9a23.loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"power_switch_lakefront", 1 );
            break;
        case #"hash_9c5e8152de8ef99":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"power_switch_farm", 1 );
            break;
        case #"hash_eff0649069653dd":
            level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"power_switch_sunken", 1 );
            break;
        default:
            assertmsg( "<dev string:x342>" );
            break;
    }
    
    utility::ent_flag_set( "on" );
    
    if ( self.var_55a3da08bd6a9a23.loc_str != "lakefront" )
    {
        self setscriptablepartstate( "usable", "unusable" );
        return;
    }
    
    self setscriptablepartstate( "electrical_box", "on" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x127b309e, Offset: 0xa8da
// Size: 0x2b
function private function_e3e5bc3589b6c96e()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_lakefront_cabin_bought" );
    self setscriptablepartstate( "electrical_box", "off" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xf4251999, Offset: 0xa90d
// Size: 0xaa
function private rotate_flip_power_switch( time, b_rotate_off = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( time ) )
    {
        time = 0.35;
    }
    
    rotation = -90;
    
    if ( b_rotate_off )
    {
        rotation = 90;
    }
    
    model_switch = self.handle_mdl;
    model_switch rotateto( model_switch.angles + ( 0, 0, rotation ), time );
    
    if ( !b_rotate_off )
    {
        model_switch setscriptablepartstate( "fx", "on" );
    }
    
    model_switch waittill( #"rotatedone" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xd9f1f2a0, Offset: 0xa9bf
// Size: 0x11c
function private function_b24cbe85607f5b23()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "pap_quest_generator_save_restore_complete" );
    
    if ( level zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"power_switch_lakefront" ) )
    {
        level.pap_quest.a_generators[ "lakefront" ].power_switch_sbl attempt_flip_power_switch( undefined, 1 );
    }
    
    if ( level zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"power_switch_farm" ) )
    {
        level.pap_quest.a_generators[ "farm" ].power_switch_sbl attempt_flip_power_switch( undefined, 1 );
    }
    
    if ( level zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"power_switch_sunken" ) )
    {
        level.pap_quest.a_generators[ "sunken" ].power_switch_sbl attempt_flip_power_switch( undefined, 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x2d1f0503, Offset: 0xaae3
// Size: 0xbb
function private function_7e95b2322b9820b6( loc_str )
{
    level endon( #"game_ended" );
    
    if ( level.var_3972df70ae115143 )
    {
        return;
    }
    
    level utility::flag_wait( "doorbuy_init_complete" );
    assert( isdefined( loc_str ), "<dev string:x374>" );
    
    switch ( loc_str )
    {
        case #"hash_2f38b0d124dff2c9":
            level pap_quest_open_doorbuy( "sunken_to_lakefront_ts_db", 1 );
            break;
        case #"hash_9c5e8152de8ef99":
            level pap_quest_open_doorbuy( "sunken_to_farm_ts_db", 1 );
            break;
        case #"hash_eff0649069653dd":
            level function_4c752ef567f5993b();
            break;
        default:
            assertmsg( "<dev string:x3a8>" );
            break;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0
// Checksum 0x601ab9e, Offset: 0xaba6
// Size: 0x69
function function_4c752ef567f5993b()
{
    level notify( #"hash_1a8aa5be8a431960" );
    
    if ( level.var_3972df70ae115143 )
    {
        return;
    }
    
    level pap_quest_open_doorbuy( "sunken_to_lakefront_ts_db", 1 );
    level pap_quest_open_doorbuy( "sunken_to_farm_ts_db", 1 );
    
    if ( !getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        level pap_quest_open_doorbuy( "sunken_to_115_ts_db", 1 );
        level pap_quest_open_doorbuy( "sunken_to_launchpad_ts_db", 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x35b03ec5, Offset: 0xac17
// Size: 0x130
function private function_5c2332507afde5af( var_9fbdfdf0aa8b449e )
{
    level endon( #"game_ended" );
    level endon( #"hash_1a8aa5be8a431960" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            foreach ( gate in var_9fbdfdf0aa8b449e )
            {
                if ( distancesquared( player.origin, gate.origin ) <= squared( 650 ) )
                {
                    return;
                }
            }
            
            waitframe();
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0
// Checksum 0x397b0377, Offset: 0xad4f
// Size: 0x10d
function function_f538355bb1ac751a()
{
    level endon( #"game_ended" );
    level.var_3972df70ae115143 = 1;
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_script_quest_pap_cs_completed" );
    level.pap_quest = zm_quest::get_quest( #"hash_6da5e0cc8bfa9384" );
    level.pap_quest.var_a3e31c6af9c21d0c = [];
    zm_quest::register_quest_step( #"hash_6da5e0cc8bfa9384", #"clear_infestation_setup", &function_2d8a491c43b82794, &function_26b9fc4e19878bc7 );
    zm_quest::register_quest_step( #"hash_6da5e0cc8bfa9384", #"clear_infestation", &function_2d8a4c1c43b82e2d, &function_26b9fd4e19878dfa );
    zm_quest::register_quest_step( #"hash_6da5e0cc8bfa9384", #"flip_power_switch", &function_2d8a4b1c43b82bfa, &function_26b9fe4e1987902d );
    level function_7e12e31678bcd7a8();
    level callback::add( #"player_connect", &on_player_connect_pap );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"hash_6da5e0cc8bfa9384" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x835b0e2d, Offset: 0xae64
// Size: 0xea
function private function_7e12e31678bcd7a8()
{
    level endon( #"game_ended" );
    level.pap_quest.var_fce0c3e197569778 = [];
    level thread function_50c7b9d446723569();
    level thread function_d506f6bdc0198dca();
    level setup_aether_generator_assets();
    level setup_power_switch_assets();
    level utility::flag_wait( "pap_generator_assets_init_complete" );
    level.pap_quest.a_generators[ "sunken" ].power_switch_sbl attempt_flip_power_switch();
    level.pap_quest.a_generators[ "sunken" ] activate_generator( undefined, 1 );
    level.pap_quest.a_generators[ "lakefront" ].power_switch_sbl attempt_flip_power_switch();
    level.pap_quest.a_generators[ "lakefront" ] activate_generator( undefined, 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x1f0b7690, Offset: 0xaf56
// Size: 0xfe
function private function_2d8a491c43b82794( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_farm_survival_step_1", undefined, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
        
        if ( level.pap_quest.restarted || zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_2b65c5a85d3afd93" ) == 3 )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"generator_cooldown" );
            var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "cooling_down" );
            level function_7006f17257efb8b8( #"hash_6da5e0cc8bfa9384", #"clear_infestation_setup" );
        }
    }
    
    level waittill( #"clear_infestation_event_started" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x71dd7185, Offset: 0xb05c
// Size: 0x25
function private function_26b9fc4e19878bc7( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level function_2f72e545c8669b3e();
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x9691446c, Offset: 0xb089
// Size: 0xee
function private function_2d8a4c1c43b82e2d( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        active_generator = level.pap_quest.a_generators[ "farm" ];
        level function_38448ec66340d598( active_generator.origin + ( 0, 0, 150 ), "pap_farm_survival_step_2", undefined, undefined, undefined, [ active_generator ] );
        level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"hash_6da5e0cc8bfa9384", #"clear_infestation" );
        active_generator utility::ent_flag_waitopen_any( "infestation_event_active" );
        
        if ( !active_generator utility::ent_flag( "infestation_cleared" ) )
        {
            level function_45b00b1b3a595819();
            level zm_quest::function_fb3af5600f6a9441( 3, 1, #"hash_6da5e0cc8bfa9384", #"clear_infestation" );
            waitframe();
            level thread zm_quest::function_80abdea0cd4c89a7( #"hash_6da5e0cc8bfa9384", #"clear_infestation_setup" );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x790b0e2f, Offset: 0xb17f
// Size: 0x4c
function private function_26b9fd4e19878dfa( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        /#
            level function_7d796b42ed821579();
        #/
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x5fb37a3b, Offset: 0xb1d3
// Size: 0xb2
function private function_2d8a4b1c43b82bfa( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "farm" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.power_switch_sbl.origin + ( 0, 0, 65 ), "pap_farm_survival_step_3", undefined, undefined, undefined, [ var_55a3da08bd6a9a23.power_switch_sbl.handle_mdl ] );
    }
    
    level.pap_quest.a_generators[ "farm" ] utility::ent_flag_wait( "activated" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x275e71fb, Offset: 0xb28d
// Size: 0x4c
function private function_26b9fe4e1987902d( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        /#
            level function_267eca0a92304404();
        #/
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0
// Checksum 0x1340aee8, Offset: 0xb2e1
// Size: 0x143
function function_2aa22232fa3bfbf6()
{
    level endon( #"game_ended" );
    level.var_6f60871b44475daa = 1;
    level.var_3972df70ae115143 = 1;
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_script_quest_pap_cs_completed" );
    level.pap_quest = zm_quest::get_quest( #"hash_2b20061a83c98bc8" );
    level.pap_quest.var_a3e31c6af9c21d0c = [];
    zm_quest::register_quest_step( #"hash_2b20061a83c98bc8", #"clear_infestation_setup", &function_fbf0c6fba65765f0, &function_2a360d5d041a755b );
    zm_quest::register_quest_step( #"hash_2b20061a83c98bc8", #"clear_infestation", &function_fbf0c9fba6576c89, &function_2a360e5d041a778e );
    zm_quest::register_quest_step( #"hash_2b20061a83c98bc8", #"flip_power_switch", &function_fbf0c8fba6576a56, &function_2a360f5d041a79c1 );
    level function_f0ebb55589aae00c();
    level callback::add( #"player_connect", &on_player_connect_pap );
    
    if ( level.pap_quest.completed == 0 )
    {
        level val::set( "task_firefly_pap", "task_logic_activate", 0 );
    }
    
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"hash_2b20061a83c98bc8" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3c3c8b4b, Offset: 0xb42c
// Size: 0xea
function private function_f0ebb55589aae00c()
{
    level endon( #"game_ended" );
    level.pap_quest.var_fce0c3e197569778 = [];
    level thread function_50c7b9d446723569();
    level thread function_d506f6bdc0198dca();
    level setup_aether_generator_assets();
    level setup_power_switch_assets();
    level utility::flag_wait( "pap_generator_assets_init_complete" );
    level.pap_quest.a_generators[ "farm" ].power_switch_sbl attempt_flip_power_switch();
    level.pap_quest.a_generators[ "farm" ] activate_generator( undefined, 1 );
    level.pap_quest.a_generators[ "lakefront" ].power_switch_sbl attempt_flip_power_switch();
    level.pap_quest.a_generators[ "lakefront" ] activate_generator( undefined, 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xb34883d, Offset: 0xb51e
// Size: 0xfe
function private function_fbf0c6fba65765f0( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "sunken" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.origin + ( 0, 0, 150 ), "pap_sunken_survival_step_1", undefined, undefined, undefined, [ var_55a3da08bd6a9a23 ] );
        
        if ( level.pap_quest.restarted || zm_quest::function_73720cdf21c3cfd7( level.pap_quest.ref, #"hash_1e8ab1b59c374367" ) == 3 )
        {
            level function_7006f17257efb8b8( #"hash_cda4e7df69dd352a", #"generator_cooldown" );
            var_55a3da08bd6a9a23 utility::ent_flag_waitopen_any( "cooling_down" );
            level function_7006f17257efb8b8( #"hash_2b20061a83c98bc8", #"clear_infestation_setup" );
        }
    }
    
    level waittill( #"clear_infestation_event_started" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xd9773ecc, Offset: 0xb624
// Size: 0x25
function private function_2a360d5d041a755b( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level function_2f72e545c8669b3e();
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x43a30435, Offset: 0xb651
// Size: 0xee
function private function_fbf0c9fba6576c89( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        active_generator = level.pap_quest.a_generators[ "sunken" ];
        level function_38448ec66340d598( active_generator.origin + ( 0, 0, 150 ), "pap_sunken_survival_step_2", undefined, undefined, undefined, [ active_generator ] );
        level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"hash_2b20061a83c98bc8", #"clear_infestation" );
        active_generator utility::ent_flag_waitopen_any( "infestation_event_active" );
        
        if ( !active_generator utility::ent_flag( "infestation_cleared" ) )
        {
            level function_45b00b1b3a595819();
            level zm_quest::function_fb3af5600f6a9441( 3, 1, #"hash_2b20061a83c98bc8", #"clear_infestation" );
            waitframe();
            level thread zm_quest::function_80abdea0cd4c89a7( #"hash_2b20061a83c98bc8", #"clear_infestation_setup" );
        }
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x4a3e1dc9, Offset: 0xb747
// Size: 0x4c
function private function_2a360e5d041a778e( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        /#
            level function_d8c12d1853433b9d();
        #/
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0x5e6cbc0, Offset: 0xb79b
// Size: 0xb2
function private function_fbf0c8fba6576a56( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "sunken" ];
        level function_38448ec66340d598( var_55a3da08bd6a9a23.power_switch_sbl.origin + ( -10, 0, 35 ), "pap_sunken_survival_step_3", undefined, undefined, undefined, [ var_55a3da08bd6a9a23.power_switch_sbl.handle_mdl ] );
    }
    
    level.pap_quest.a_generators[ "sunken" ] utility::ent_flag_wait( "activated" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xa6ac98d6, Offset: 0xb855
// Size: 0x70
function private function_2a360f5d041a79c1( b_skipped, b_save_restored )
{
    level function_45b00b1b3a595819();
    level val::reset( "task_firefly_pap", "task_logic_activate" );
    
    if ( b_skipped && !b_save_restored && !level.pap_quest.restarted )
    {
        level val::reset( "task_firefly_pap", "task_logic_activate" );
        
        /#
            level function_38a28bc1b6831a56();
        #/
    }
}

/#

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x6c3e8c77, Offset: 0xb8cd
    // Size: 0x10c, Type: dev
    function private function_e709e22b5fc8c849()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            var_1e5d943acb8a2ef8 = zm_quest::get_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation_setup" );
            var_1e5d973acb8a3591 = zm_quest::get_quest_step( #"hash_9deee04807c7b80c", #"clear_infestation" );
            zm_quest::function_e65609834444650c( var_1e5d943acb8a2ef8, undefined, 1 );
            zm_quest::function_e65609834444650c( var_1e5d973acb8a3591, undefined, 1 );
            
            foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
            {
                if ( var_55a3da08bd6a9a23.loc_str != "<dev string:x3cc>" )
                {
                    var_55a3da08bd6a9a23 function_20189923a1c8d801( 1 );
                }
            }
        }
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0xc4e65108, Offset: 0xb9e1
    // Size: 0x47, Type: dev
    function private function_7d796b42ed821579()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "<dev string:x3d3>" ];
            var_55a3da08bd6a9a23 function_20189923a1c8d801( 1 );
        }
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x5f790da7, Offset: 0xba30
    // Size: 0x47, Type: dev
    function private function_d8c12d1853433b9d()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "<dev string:x3cc>" ];
            var_55a3da08bd6a9a23 function_20189923a1c8d801( 1 );
        }
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0xe8e9d9e4, Offset: 0xba7f
    // Size: 0xc0, Type: dev
    function private function_267eca0a92304404()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
            {
                if ( var_55a3da08bd6a9a23.loc_str != "<dev string:x3cc>" )
                {
                    var_55a3da08bd6a9a23.power_switch_sbl attempt_flip_power_switch();
                    var_55a3da08bd6a9a23 activate_generator();
                }
            }
        }
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x67dde0f0, Offset: 0xbb47
    // Size: 0x57, Type: dev
    function private function_38a28bc1b6831a56()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            var_55a3da08bd6a9a23 = level.pap_quest.a_generators[ "<dev string:x3cc>" ];
            var_55a3da08bd6a9a23.power_switch_sbl attempt_flip_power_switch();
            var_55a3da08bd6a9a23 activate_generator();
        }
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x7d29a73, Offset: 0xbba6
    // Size: 0x4b, Type: dev
    function private function_cacb3190f6081c61()
    {
        if ( getdvarint( @"hash_bfbddb32ffc1ffa", 1 ) )
        {
            level pap_quest_open_doorbuy( "<dev string:x3d8>" );
            level pap_quest_open_doorbuy( "<dev string:x3ee>" );
            level pap_quest_open_doorbuy( "<dev string:x406>" );
            level pap_quest_open_doorbuy( "<dev string:x422>" );
        }
    }

#/

// Namespace zm_sat_firefly_pap_quest
// Params 0
// Checksum 0x41d103f2, Offset: 0xbbf9
// Size: 0x28
function pap_on_garage_opened()
{
    level zm_quest::function_4eefe6de31f5ddab( level.pap_quest.ref, #"garage_opened", 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 2, eflags: 0x4
// Checksum 0xfba28cb4, Offset: 0xbc29
// Size: 0x72
function private function_43c010e79a05f667( step_ref, flag_step_complete )
{
    level endon( flag_step_complete );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.wonder_veh.occupants.size < 1 )
        {
            level callback::remove( #"player_vehicle_enter", &function_311992ba5cb5b360 );
            zm_quest::function_80abdea0cd4c89a7( #"firefly_pap_quest", step_ref );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 4, eflags: 0x4
// Checksum 0xc1d9e4ce, Offset: 0xbca3
// Size: 0x64
function private function_7006f17257efb8b8( key_ref, step_ref, huddata, var_6573b2bbd219d66 = 2 )
{
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, key_ref, step_ref );
    level zm_quest::function_fb3af5600f6a9441( var_6573b2bbd219d66, 1, key_ref, step_ref );
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        level thread zm_quest::update_guidance( huddata, key_ref, step_ref );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x82d1674f, Offset: 0xbd0f
// Size: 0x198
function private function_2f72e545c8669b3e()
{
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"generator_cooldown" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"hash_b178bde2554d26d" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"hash_cc37078ac8023112" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"hash_8003094480a90051" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"travel_to_farm" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"hash_895b54b6a9ac3f63" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_cda4e7df69dd352a", #"grab_tedd" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"generator_cooldown" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"hash_b178bde2554d26d" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"hash_cc37078ac8023112" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"hash_8003094480a90051" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"travel_to_farm" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"hash_895b54b6a9ac3f63" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_cda4e7df69dd352a", #"grab_tedd" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x37fdf8e1, Offset: 0xbeaf
// Size: 0xc4
function private function_55a4a97a308a2684( name )
{
    if ( level.wonder_veh.health <= 50 )
    {
        if ( !level utility::flag( "marker_pluto_repair_active" ) )
        {
            level function_45b00b1b3a595819();
            level function_38448ec66340d598( level.wonder_veh, name, undefined, &"zm_sat_firefly/repair", 100, [ level.wonder_veh ] );
            level utility::flag_set( "marker_pluto_repair_active" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "marker_pluto_active" ) )
    {
        level function_45b00b1b3a595819();
        level function_38448ec66340d598( level.wonder_veh, name, undefined, undefined, 100, [ level.wonder_veh ] );
        level utility::flag_set( "marker_pluto_active" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x64691524, Offset: 0xbf7b
// Size: 0x1c
function private function_7d20fb299554cb15()
{
    level utility::flag_clear( "marker_pluto_repair_active" );
    level utility::flag_clear( "marker_pluto_active" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x36398e3b, Offset: 0xbf9f
// Size: 0x138
function private function_45b00b1b3a595819()
{
    foreach ( id in level.pap_quest.var_fce0c3e197569778 )
    {
        level zm_quest::complete_objective_waypoints( id );
    }
    
    level.pap_quest.var_fce0c3e197569778 = [];
    
    foreach ( target in level.pap_quest.var_a3e31c6af9c21d0c )
    {
        calloutmarkerping::function_ab4e5514677fba94( target );
    }
    
    level.pap_quest.var_a3e31c6af9c21d0c = [];
    function_7d20fb299554cb15();
}

// Namespace zm_sat_firefly_pap_quest
// Params 6, eflags: 0x4
// Checksum 0x91b57866, Offset: 0xc0df
// Size: 0x1b0
function private function_38448ec66340d598( origin_or_ent, step_name, b_play_intro = 1, str_label, offset, var_895bdd0db4c4515 )
{
    if ( zm_quest::function_209ca091001f4c64( #"hash_9deee04807c7b80c" ) )
    {
        return;
    }
    
    if ( isent( origin_or_ent ) )
    {
        objectiveid = zm_quest::function_dc297429579c6e7f( step_name, 1, "ui_icon_zm_objective", "icon_small_medium", "current", origin_or_ent, offset, str_label, undefined, 0, b_play_intro, 0 );
    }
    else
    {
        objectiveid = zm_quest::function_b98d4144845ffc13( step_name, 1, "ui_icon_zm_objective", "icon_small_medium", "current", origin_or_ent, undefined, str_label, undefined, 0, b_play_intro );
    }
    
    if ( !level.pap_quest.var_a3e31c6af9c21d0c )
    {
        level.pap_quest.var_a3e31c6af9c21d0c = [];
    }
    
    foreach ( target in var_895bdd0db4c4515 )
    {
        if ( isdefined( objectiveid ) )
        {
            calloutmarkerping::function_9bd4bf4f8fe74b16( target, objectiveid, 6 );
            level.pap_quest.var_a3e31c6af9c21d0c[ level.pap_quest.var_a3e31c6af9c21d0c.size ] = target;
        }
    }
    
    level.pap_quest.var_fce0c3e197569778[ level.pap_quest.var_fce0c3e197569778.size ] = objectiveid;
    return objectiveid;
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xd7a074b3, Offset: 0xc298
// Size: 0x60
function private on_pap_quest_item_used( params )
{
    itembundle = params.bundle;
    
    switch ( itembundle.ref )
    {
        case #"hash_410bb687e9af691e":
            level function_d36bcd4a6aa8ee3( self );
            break;
        default:
            break;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x309599bb, Offset: 0xc300
// Size: 0x136
function private function_ffd992482ca10a76( amount )
{
    if ( self == level.pap_quest.curr_generator )
    {
        if ( level.pap_quest.ref == #"firefly_pap_quest" )
        {
            var_1e5d9a3acb8a3c2a = zm_quest::get_quest_step( #"firefly_pap_quest", #"hash_cadac07a2223c10b" );
            
            if ( var_1e5d9a3acb8a3c2a.completed )
            {
                key = #"hash_9deee04807c7b80c";
                step_ref = #"clear_infestation";
            }
            else
            {
                key = #"firefly_pap_quest";
                step_ref = #"hash_cadac07a2223c10b";
            }
        }
        else if ( level.pap_quest.ref == #"hash_6da5e0cc8bfa9384" )
        {
            key = #"hash_6da5e0cc8bfa9384";
            step_ref = #"clear_infestation";
        }
        else if ( level.pap_quest.ref == #"hash_2b20061a83c98bc8" )
        {
            key = #"hash_2b20061a83c98bc8";
            step_ref = #"clear_infestation";
        }
        
        level zm_quest::function_9f49b2a045ece8ae( amount, 1, key, step_ref );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xa2e865ad, Offset: 0xc43e
// Size: 0xbe
function private function_a2f0e0447c2c1e0e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level utility::flag_wait( "match_start_vo_done" );
    wait 2;
    
    if ( level utility::flag( "end_of_round_vo_playing" ) )
    {
        zm_quest::function_8934bb2a9028bdc5();
    }
    
    level.pap_quest.tedd_vo_ent dialogue::say( #"hash_7d8f10727a91944b" );
    
    for ( timer = 0; true ; timer++ )
    {
        if ( timer >= 30 )
        {
            timer = 0;
            
            if ( level utility::flag( "end_of_round_vo_playing" ) )
            {
                continue;
            }
            
            level.pap_quest.tedd_vo_ent dialogue::say( #"hash_7d8f10727a91944b" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x7ff2d64a, Offset: 0xc504
// Size: 0xb0
function private function_125fb2ac6fe73ce4( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self stopsounds();
    dialogue::stop_dialogue();
    
    if ( player )
    {
        if ( player zm_vo::is_tedd() )
        {
            player zm_vo::function_8c1a12974bd11f01( #"hash_7f76d06eb62c5874", #"bc_flavor_player_positive" );
        }
        else if ( !level utility::flag( "end_of_round_vo_playing" ) && level utility::flag( "match_start_vo_done" ) )
        {
            dialogue::say( #"hash_72ddef7273f05a0f" );
            player zm_vo::function_8c1a12974bd11f01( #"hash_70108cf331f27c8e", #"bc_flavor_player_positive" );
        }
    }
    
    self delete();
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xc4ac40f0, Offset: 0xc5bc
// Size: 0x7e
function private function_f67e8ae93efa90b4( player )
{
    level endon( #"game_ended" );
    
    if ( player )
    {
        player endon( #"death_or_disconnect" );
        utility::flag_wait( "tedd_attached" );
        player zm_vo::function_8c1a12974bd11f01( #"silver_install", #"bc_flavor_player_positive" );
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_bddb4186453f868", 1 );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xfa3b3cbe, Offset: 0xc642
// Size: 0x3e
function private function_624179b4c70b7fcc()
{
    level endon( #"game_ended" );
    wait 3;
    level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_bd9c8186450318d", 1 );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0xa3acc1e2, Offset: 0xc688
// Size: 0x33
function private function_3ad7970229098e00()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    zm_vo::function_8c1a12974bd11f01( #"hash_12973f35a416ac58", #"hash_5212ed7ec42f115a" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x4b0b9320, Offset: 0xc6c3
// Size: 0x64
function private function_26ad7e7aed602b4d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    a_players = getplayersinradius( self.origin, 800 );
    
    if ( a_players.size > 0 )
    {
        player = a_players[ randomint( a_players.size ) ];
        level battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 0, eflags: 0x4
// Checksum 0x3902a843, Offset: 0xc72f
// Size: 0x106
function private function_f29a971fb5b401d9()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    a_players = getplayersinradius( self.origin, 800 );
    a_players = arrayrandomize( a_players );
    
    foreach ( player in a_players )
    {
        if ( player zm_vo::is_hero_operator() )
        {
            var_db75d3de862ce072 = player zm_vo::function_8c1a12974bd11f01( #"hash_a9f8c97ffdb8fda6" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
    }
    
    if ( !var_db75d3de862ce072 && a_players.size > 0 )
    {
        player = a_players[ randomint( a_players.size ) ];
        player zm_vo::function_8c1a12974bd11f01( #"hash_a9f8c97ffdb8fda6", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0x165d7ceb, Offset: 0xc83d
// Size: 0x43
function private function_bdc49698e401c257( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    player zm_vo::function_8c1a12974bd11f01( #"hash_736702e6410bba3d" );
}

// Namespace zm_sat_firefly_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xa2971543, Offset: 0xc888
// Size: 0x4c
function private function_10452585f63bcddf( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    player zm_vo::function_8c1a12974bd11f01( #"hash_bac00820214d900f", #"bc_flavor_player_positive" );
}

/#

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x5e74aa53, Offset: 0xc8dc
    // Size: 0x70, Type: dev
    function private init_pap_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x445>" );
        devgui::add_devgui_func( "<dev string:x462>", "<dev string:x485>", &function_89b33e43b119172f );
        devgui::add_devgui_func( "<dev string:x498>", "<dev string:x4c2>", &function_ab39312f545b3854 );
        devgui::add_devgui_func( "<dev string:x4dc>", "<dev string:x501>", &function_2538c7867f97b3de );
        devgui::add_devgui_func( "<dev string:x516>", "<dev string:x53d>", &function_bd02a2ed53d7815a );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x3b906892, Offset: 0xc954
    // Size: 0x27, Type: dev
    function private function_ab39312f545b3854()
    {
        level.pap_quest.a_generators[ "<dev string:x554>" ] function_20189923a1c8d801( 1 );
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x19849ccf, Offset: 0xc983
    // Size: 0x27, Type: dev
    function private function_2538c7867f97b3de()
    {
        level.pap_quest.a_generators[ "<dev string:x3d3>" ] function_20189923a1c8d801( 1 );
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x7a77f37e, Offset: 0xc9b2
    // Size: 0x27, Type: dev
    function private function_bd02a2ed53d7815a()
    {
        level.pap_quest.a_generators[ "<dev string:x3cc>" ] function_20189923a1c8d801( 1 );
    }

    // Namespace zm_sat_firefly_pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0xd0b7fc07, Offset: 0xc9e1
    // Size: 0x100, Type: dev
    function private function_89b33e43b119172f()
    {
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            foreach ( pustule in var_55a3da08bd6a9a23.var_4d0b4c7baa1aec17 )
            {
                pustule setscriptablepartstate( "<dev string:x55e>", "<dev string:x563>" );
            }
        }
    }

#/
