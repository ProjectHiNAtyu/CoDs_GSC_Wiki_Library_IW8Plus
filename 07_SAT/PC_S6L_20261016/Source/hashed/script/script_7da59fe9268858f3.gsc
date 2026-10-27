// script_7da59fe9268858f3  (hash_7da59fe9268858f3.gscc) (size: 5876 Bytes / 0x16f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32958937 (848660791)
// size ...... 5876 (0x16f4)
// includes .. 5   (offset: 0x15b8)
// strings ... 18  (offset: 0x15e0)
// dev strs .. 4   (offset: 0x16c4)
// exports ... 16  (offset: 0xc5c)
// cseg ...... 0x1a0 + 0xabc (0xc5c)
// imports ... 60  (offset: 0xedc)
// animtree1 . 0   (offset: 0x16f4)
// animtree2 . 0   (offset: 0x16f4)
#using script_699d3b456bfdd52f;
#using scripts\common\dev_menu;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;

#namespace namespace_9e3a64b15429f7c9;

/#

    // Namespace namespace_9e3a64b15429f7c9
    // Params 0
    // Checksum 0x7c8dea35, Offset: 0x1be
    // Size: 0x36, Type: dev
    function init()
    {
        setdvarifuninitialized( @"hash_5d83147342337f0b", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_5d83147342337f0b" ) > 0 )
            {
                thread spawn_ai_mode();
            }
            
            waitframe();
        }
    }

    // Namespace namespace_9e3a64b15429f7c9
    // Params 0
    // Checksum 0xc4be04cb, Offset: 0x1fc
    // Size: 0x1fc, Type: dev
    function spawn_ai_mode()
    {
        utility::registersharedfunc( #"poi", #"poi_issystemactive", &disable_poi );
        setdvarifuninitialized( @"hash_5d83147342337f0b", 0 );
        dvar = @"hash_5d83147342337f0b";
        var_e94ea66442aafa8b = @"hash_f6ac786807a5e9cb";
        setdvar( @"hash_bb1a296df27c0f74", 0 );
        spawnaimode = spawnstruct();
        spawnaimode.nextusepress = 0;
        spawnaimode.gameon = 0;
        spawnaimode.gamestarted = 0;
        spawnaimode.placedais = [];
        spawnaimode.placedenemies = [];
        spawnaimode.selectedaitype = "<dev string:x24>";
        spawnaimode.mode = "<dev string:x2e>";
        spawnaimode.storedweapons = take_weapons_away();
        spawnaimode.goalradius = 64;
        level.debug.spawnaimode = spawnaimode;
        thread debug_cursor( 1 );
        dev_menu::init_menus();
        menu_default();
        
        while ( getdvarint( dvar ) )
        {
            input();
            waitframe();
        }
        
        give_weapons_back( spawnaimode.storedweapons );
        level.debug.spawnaimode = undefined;
        possible_menus = [ "<dev string:x36>" ];
        
        foreach ( menuname in possible_menus )
        {
            dev_menu::disable_menu( "<dev string:x43>" );
            dev_menu::destroy_menu( menuname );
        }
        
        level notify( #"stop_debug_cursor" );
    }

#/

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xd1c4bfe, Offset: 0x400
// Size: 0x37e
function spawn_scenario()
{
    angles = ( 0, 0, 0 );
    spawnaimode = level.debug.spawnaimode;
    numai = 2;
    airadius = 200;
    aipadding = 128;
    numem = 4;
    enemydistance = 600;
    enemyradius = 300;
    enemypadding = 128;
    
    if ( canpressuse() )
    {
        if ( spawnaimode.mode != "default" )
        {
            return;
        }
        
        level.player.ignoreme = 1;
        function_f2558192cd801ed4();
        spawnaimode.ally_origin = level.debug.cursor_pos;
        tacpoints = function_62301cb6c3432997( level.debug.cursor_pos, airadius, aipadding, numai );
        
        if ( !isdefined( tacpoints ) || tacpoints.size < numai )
        {
            iprintlnbold( "Not enough tacpoints found" );
            return;
        }
        
        for ( i = 0; i < numai ; i++ )
        {
            point = tacpoints[ randomint( tacpoints.size ) ];
            tacpoints = arrayremove( tacpoints, point );
            newai = create_agent( point.groundpos, angles, function_79c823f7276acce1( 1 ), "covernn_allies", level.player.team );
            
            if ( isdefined( newai ) )
            {
                spawnaimode.placedais[ spawnaimode.placedais.size ] = newai;
                spawnaimode.highlightent = newai;
            }
            
            waitframe();
        }
        
        player_forward = anglestoforward( level.player.angles );
        spawnaimode.enemy_origin = ( level.debug.cursor_pos[ 0 ] + player_forward[ 0 ] * enemydistance, level.debug.cursor_pos[ 1 ] + player_forward[ 1 ] * enemydistance, level.debug.cursor_pos[ 2 ] );
        enemy_tacpoints = function_62301cb6c3432997( spawnaimode.enemy_origin, enemyradius, enemypadding, numem );
        
        for ( i = 0; i < numem ; i++ )
        {
            point = enemy_tacpoints[ randomint( enemy_tacpoints.size ) ];
            enemy_tacpoints = arrayremove( enemy_tacpoints, point );
            newenemy = create_agent( point.groundpos, angles, function_79c823f7276acce1( 0 ), "covernn_enemies", "team_hundred_ninety_four" );
            
            if ( isdefined( newenemy ) )
            {
                spawnaimode.placedenemies[ spawnaimode.placedenemies.size ] = newenemy;
                spawnaimode.highlightent = newenemy;
            }
            
            waitframe();
        }
        
        function_ae46b35c9dbb79cf();
        delayusetime();
        
        foreach ( placedai in spawnaimode.placedais )
        {
            placedai thread function_ef0aa4a050bec677( placedai.enemy );
            waitframe();
        }
    }
}

// Namespace namespace_9e3a64b15429f7c9
// Params 5
// Checksum 0x47258c93, Offset: 0x786
// Size: 0x120
function create_agent( origin, angles, type, subcategory, team )
{
    ent = ai_mp_controller::ai_mp_requestspawnagent( type, origin, angles, "low", "everybody", subcategory, team, undefined, undefined, undefined, undefined, undefined, 0 );
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent.aitype = type;
    ent.agentteam = team;
    ent.team = team;
    ent.dontevershoot = 1;
    ent.var_f2b209eadf78deeb = 1;
    ent.disablepistol = 1;
    ent.dontmelee = 1;
    ent.var_d5fd37ace96a974 = 1;
    ent.ignoreall = 0;
    ent.ignoreme = 0;
    ent setgoalpos( ent.origin, 32 );
    ent function_fa32376aaa88a7a2( ent.origin, 2048 );
    ent thread label_self( type );
    return ent;
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x961208d5, Offset: 0x8af
// Size: 0x16f
function function_f2558192cd801ed4()
{
    spawnaimode = level.debug.spawnaimode;
    remove_selected( spawnaimode.selectedent );
    spawnaimode.occupiednodes = undefined;
    agents = function_3b71aa1bfab81002( "everybody" );
    
    foreach ( ai in spawnaimode.placedais )
    {
        ai notify( #"retarget" );
        ai agent_utils::despawnagent();
    }
    
    spawnaimode.placedais = [];
    
    foreach ( ai in spawnaimode.placedenemies )
    {
        ai notify( #"retarget" );
        ai agent_utils::despawnagent();
    }
    
    spawnaimode.placedenemies = [];
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x331b84f7, Offset: 0xa26
// Size: 0x82
function menu_default()
{
    spawnaimode = level.debug.spawnaimode;
    menu = "spawnai_main";
    options = "spawnai_options";
    dev_menu::add_menu( menu, "Main" );
    dev_menu::add_menu( options, "Options" );
    dev_menu::add_menuoptions( menu, "Spawn Scenario", &spawn_scenario, spawnaimode.selectedaitype );
    dev_menu::enable_menu( menu );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x969b16f7, Offset: 0xab0
// Size: 0x129
function function_ae46b35c9dbb79cf()
{
    spawnaimode = level.debug.spawnaimode;
    dev_menu::disable_menu( "current_menu" );
    options = "spawnai_options";
    
    if ( dev_menu::menu_exists( options ) )
    {
        dev_menu::destroy_menu( options );
    }
    
    dev_menu::add_menu( options, "Options" );
    dev_menu::add_menuoptions( options, "Respawn Scenario", &spawn_scenario );
    dev_menu::add_menuoptions( options, "Inc/Dec Soldier Padding", &function_3a30c828a3fd9c60, &function_8a387d80fd022de4, function_f9298c1604f9e65f( spawnaimode.placedais, spawnaimode.ally_origin ) );
    dev_menu::add_menuoptions( options, "Inc/Dec Enemy Padding", &function_91804b7fc4b1cf4a, &function_458646455426f5c6, function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.enemy_origin ) );
    dev_menu::add_menuoptions( options, "Inc/Dec Engagement Dist", &function_ff04a67c8aa5a0bb, &function_9c7b688144bc1e2b, function_f9298c1604f9e65f( spawnaimode.placedenemies, spawnaimode.ally_origin ) );
    dev_menu::add_menuoptions( options, "Record Data", &function_d95322f6d718605d );
    dev_menu::enable_menu( options );
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xd12d22cc, Offset: 0xbe1
// Size: 0x8
function function_3a30c828a3fd9c60()
{
    return function_7973bc6aa83754f0();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xf4fdf9cc, Offset: 0xbf2
// Size: 0x8
function function_8a387d80fd022de4()
{
    return function_d8a17f8e640afb34();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xd108f217, Offset: 0xc03
// Size: 0x8
function function_91804b7fc4b1cf4a()
{
    return function_138c8ac9339e913a();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0xd12d22cc, Offset: 0xc14
// Size: 0x8
function function_458646455426f5c6()
{
    return function_d50ca80033c9a7f6();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x5403f64a, Offset: 0xc25
// Size: 0x8
function function_ff04a67c8aa5a0bb()
{
    return function_340236c8a810352f();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x88c54f0, Offset: 0xc36
// Size: 0x8
function function_9c7b688144bc1e2b()
{
    return function_f2da74831e0f5a63();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x9235fd76, Offset: 0xc47
// Size: 0x9
function function_d95322f6d718605d()
{
    collect_data();
}

// Namespace namespace_9e3a64b15429f7c9
// Params 0
// Checksum 0x92c0220c, Offset: 0xc58
// Size: 0x3, Type: bool
function disable_poi()
{
    return false;
}

