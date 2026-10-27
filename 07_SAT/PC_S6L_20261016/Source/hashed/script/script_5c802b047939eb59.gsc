// script_5c802b047939eb59  (hash_5c802b047939eb59.gscc) (size: 4797 Bytes / 0x12bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x145fdbfa (341826554)
// size ...... 4797 (0x12bd)
// includes .. 7   (offset: 0x1185)
// strings ... 14  (offset: 0x11bd)
// dev strs .. 7   (offset: 0x1269)
// exports ... 19  (offset: 0x8e1)
// cseg ...... 0x17c + 0x765 (0x8e1)
// imports ... 51  (offset: 0xbd9)
// animtree1 . 0   (offset: 0x12bd)
// animtree2 . 0   (offset: 0x12bd)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace quest_dartboard;

// Namespace quest_dartboard
// Params 0, eflags: 0x5
// Checksum 0xd450cbbb, Offset: 0x19a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"dd_dartboard", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_dartboard
// Params 0
// Checksum 0xefb98522, Offset: 0x1c3
// Size: 0x6c
function pre_main()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"dartboard" };
    br_map_quest::register( quest );
}

// Namespace quest_dartboard
// Params 0
// Checksum 0xb86e9bde, Offset: 0x237
// Size: 0x9b
function on_init()
{
    set_dvars();
    self.dartboard = spawn( "script_model", ( -4826, -1108, 1232 ) );
    self.dartboard.angles = ( 0, 180, 0 );
    self.dartboard setmodel( "decor_dartboard_01" );
    self.dartboard.bullseye = self.dartboard.origin;
    thread locked_door_init();
    rewards_init();
    
    /#
        debug_init();
    #/
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x76dd3fab, Offset: 0x2da
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_dartboard
// Params 0
// Checksum 0xa7ab462a, Offset: 0x2e4
// Size: 0x2
function on_start()
{
    
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x4be09a1b, Offset: 0x2ee
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_dartboard
// Params 0
// Checksum 0xcfe7285, Offset: 0x2f8
// Size: 0x17
function on_infil()
{
    thread function_109b09955513f061();
    reward_caches_spawn();
    spawn_items();
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x55cfab91, Offset: 0x317
// Size: 0x10
function set_dvars()
{
    br_map_quest::add_setting( "dartboard_num_caches", 1 );
}

// Namespace quest_dartboard
// Params 0
// Checksum 0xf4b3cb03, Offset: 0x32f
// Size: 0x44
function locked_door_init()
{
    utility::flag_wait( "scriptables_ready" );
    self.var_53f3c3f754962461 = scriptable_door_utility::scriptable_door_get_in_radius( self.dartboard.bullseye, 200, 100 )[ 0 ];
    self.var_53f3c3f754962461 scriptabledoorlock();
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x1af91cc, Offset: 0x37b
// Size: 0x2a
function rewards_init()
{
    self.cache_locs = utility::getstructarray( "dartboard_cache" );
    self.staged_item_locs = utility::getstructarray( "dartboard_item" );
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x3b5a229b, Offset: 0x3ad
// Size: 0xdf
function reward_caches_spawn()
{
    self.cache_locs = arrayrandomize( self.cache_locs );
    caches_spawned = 0;
    
    foreach ( loc in self.cache_locs )
    {
        if ( caches_spawned == br_map_quest::get_setting( "dartboard_num_caches" ) )
        {
            continue;
        }
        
        common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", loc.origin, loc.angles, undefined, "wz_sat_resurgence_zone_global" );
        loc = undefined;
        caches_spawned++;
    }
    
    self.cache_locs = undefined;
}

// Namespace quest_dartboard
// Params 0, eflags: 0x4
// Checksum 0x3edac763, Offset: 0x494
// Size: 0x7b
function private spawn_items()
{
    foreach ( staged_item_loc in self.staged_item_locs )
    {
        spawn_item_individual( staged_item_loc );
    }
}

// Namespace quest_dartboard
// Params 1, eflags: 0x4
// Checksum 0x7f955f3b, Offset: 0x517
// Size: 0xc6
function private spawn_item_individual( staged_loc )
{
    if ( !isdefined( staged_loc.script_noteworthy ) )
    {
        return;
    }
    
    item_bundle = getscriptbundle( "itemspawnentry:" + staged_loc.script_noteworthy );
    spawnoptions = common_item::function_bc5ff2958b71a708( staged_loc.origin, staged_loc.angles );
    spawnoptions.critical = 1;
    scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
    
    if ( isdefined( scriptable ) && scriptable getscriptableparthasstate( scriptable.type, #"visible_staged_weapon" ) )
    {
        scriptable setscriptablepartstate( scriptable.type, #"visible_staged_weapon" );
    }
}

// Namespace quest_dartboard
// Params 0
// Checksum 0x53b85593, Offset: 0x5e5
// Size: 0x1a2
function function_109b09955513f061()
{
    level endon( #"game_ended" );
    self.dartboard setcandamage( 1 );
    
    while ( true )
    {
        self.dartboard waittill( #"damage", damage, attacker, direction, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( objweapon ) && objweapon.basename == "sat_combataxe_wz" && distance( point, self.dartboard.bullseye ) < 20 )
        {
            Axe = spawnscriptable( "brloot_offhand_combataxe", point + vectornormalize( direction ) * -7, vectortoangles( direction ) + ( -90, 90, -60 ) );
            Axe.count = 1;
            inflictor delete();
            break;
        }
    }
    
    wait 0.2;
    self.var_53f3c3f754962461 scriptabledoorbashopen( "left" );
    playsoundatpos( ( -4982, -1171, 1218 ), "evt_dartboard_door_unlock" );
    br_map_quest::on_completed( { #completed_by:[ attacker ], #is_successful:1 } );
}

/#

    // Namespace quest_dartboard
    // Params 0, eflags: 0x4
    // Checksum 0xb222724a, Offset: 0x78f
    // Size: 0x16, Type: dev
    function private debug_init()
    {
        devgui_init();
        self.var_6e918fbbece6ba20 = 0;
    }

    // Namespace quest_dartboard
    // Params 0, eflags: 0x4
    // Checksum 0x555c1fd5, Offset: 0x7ad
    // Size: 0x4a, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x33>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e>", "<dev string:x57>", &devgui_dartboard );
        devgui::function_cd4e263c1f3018ae( "<dev string:x69>", "<dev string:x7f>", &devgui_dartboard );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_dartboard
    // Params 1, eflags: 0x4
    // Checksum 0xa68becb0, Offset: 0x7ff
    // Size: 0x19, Type: dev
    function private devgui_dartboard( params )
    {
        level thread debug_dartboard( params );
    }

    // Namespace quest_dartboard
    // Params 1
    // Checksum 0xc64db917, Offset: 0x820
    // Size: 0xc1, Type: dev
    function debug_dartboard( params )
    {
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                level.player setorigin( ( -5417, -1096, 1317 ) );
                level.player setplayerangles( ( 5, 325, 0 ) );
                break;
            case 1:
                level.player setorigin( ( -5206, -1102, 1173 ) );
                level.player setplayerangles( ( 358, 359, 0 ) );
                break;
            default:
                assertmsg( "<dev string:x91>" );
                break;
        }
    }

#/
