// scripts\mp\zm\ztron\ztron_bonus_room.gsc  (hash_6137b1347e4f3445.gscc) (size: 28228 Bytes / 0x6e44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d248aec (2099546860)
// size ...... 28228 (0x6e44)
// includes .. 18  (offset: 0x6598)
// strings ... 95  (offset: 0x6628)
// dev strs .. 54  (offset: 0x6bbc)
// exports ... 53  (offset: 0x4810)
// cseg ...... 0x804 + 0x400c (0x4810)
// imports ... 177 (offset: 0x5058)
// animtree1 . 0   (offset: 0x6e44)
// animtree2 . 0   (offset: 0x6e44)
#using script_2b3f8b011222f912;
#using script_31ee2a173f3499b7;
#using script_54a05cbb2455bc6f;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_bonus_room;

// Namespace ztron_bonus_room
// Params 0
// Checksum 0x50a2ca47, Offset: 0x822
// Size: 0x898
function init()
{
    level.ztron.bonusRooms = [];
    level.ztron.var_add97c5e82e892bf = [];
    level.ztron.var_5a4f8972e996f97c = getdvarint( @"hash_4700b25cb53e7303" );
    var_a8d8980c65b4b0de = utility::getstructarray( "bonus", "targetname" );
    
    foreach ( room in var_a8d8980c65b4b0de )
    {
        room.name = room.script_noteworthy;
        room.type = room.script_label ?? room.name;
        room.minlevel = 0;
        room.maxvisits = 999;
        room.var_feda109afe10f2ca = 0;
        room.cooldowntimeout = 0;
        room.cooldownms = 1800000;
        
        if ( isdefined( room.script_parameters ) )
        {
            args = strtok( room.script_parameters, ";" );
            room.var_6210dc1f68bbfa57 = int( args[ 0 ] );
            
            if ( args.size > 1 )
            {
                room.var_feda109afe10f2ca = int( args[ 1 ] );
            }
            
            if ( args.size > 2 )
            {
                room.killidle = int( args[ 2 ] );
            }
            
            if ( args.size > 3 )
            {
                room.killtimeout = int( args[ 3 ] );
            }
            
            if ( args.size > 4 )
            {
                room.timeout = int( args[ 4 ] );
            }
            
            if ( args.size > 5 )
            {
                room.lightstate = int( args[ 5 ] );
            }
            
            if ( args.size > 6 )
            {
                room.maxvisits = int( args[ 6 ] );
            }
            
            if ( args.size > 7 )
            {
                room.minlevel = int( args[ 7 ] );
            }
            
            if ( args.size > 8 )
            {
                room.var_acecf1de8ec2250a = int( args[ 8 ] );
            }
            
            if ( args.size > 9 )
            {
                room.cooldownms = int( args[ 9 ] * 1000 );
            }
        }
        
        room.playersstarts = utility::getstructarray( "bonus_" + room.name + "_player_spawnpoint", "targetname" );
        room.hazards = utility::getstructarray( "bonus_" + room.name + "_hazard", "targetname" );
        room.var_8260f0f996dc9927 = utility::getstructarray( "bonus_" + room.name + "_pickup", "targetname" );
        room.enemyspawnpoints = utility::getstructarray( "bonus_" + room.name + "_enemy_spawn", "targetname" );
        room.var_5290e343e7cabade = utility::getstruct( "bonus_" + room.name + "_room_center" );
        room.exit = ztron_util::function_95ca81ff822c3de4( "bonus_" + room.name + "_exit", #targetname );
        room.abort = ztron_util::function_95ca81ff822c3de4( "bonus_" + room.name + "_abort", #targetname );
        room.checkpoints = ztron_util::function_2d9de5c7b97db39( "bonus_" + room.name + "_checkpoint", #targetname );
        room.deadzones = ztron_util::function_2d9de5c7b97db39( "bonus_" + room.name + "_deadzone", #targetname );
        room.var_fa8d8a6bab814752 = ztron_util::function_2d9de5c7b97db39( "bonus_" + room.name + "_camera_tweak", #targetname );
        room.enemytriggers = ztron_util::function_2d9de5c7b97db39( room.name + "_enemy_trigger", #targetname );
        room.hazardzone = 0;
        room.discoveryNeeded = 0;
        var_190e5fd247eb323e = getent( "bonus_" + room.name + "_heli_height_lock", #targetname );
        
        if ( var_190e5fd247eb323e && var_190e5fd247eb323e.classname == "script_brushmodel" )
        {
            var_190e5fd247eb323e notsolid();
            room.var_bd9df22b9216b2af = var_190e5fd247eb323e;
        }
        
        room.var_a6fb8def3d6b72e9 = 0;
        
        if ( room.name == "plunder" || room.name == "shadow_vault" || room.name == "fate" || room.name == "rail_shooter" || room.name == "racing2" || room.name == "nuke_vault" || room.name == "fall_100" )
        {
            room.special_context = 1;
        }
        
        if ( room.name == "fate" || room.name == "eggxit" || room.name == "shadow_vault" || room.name == "nuke_vault" )
        {
            room.hazardzone = 1;
            room.deathallowed = 1;
        }
        
        if ( room.name == "racing" || room.name == "racing2" || room.name == "side_scroller1" || room.name == "side_scroller2" || room.name == "side_scroller3" || room.name == "eggxit" || room.name == "shadow_vault" || room.name == "nuke_vault" || room.name == "fate" || room.name == "fall_100" )
        {
            room.var_a6fb8def3d6b72e9 = 1;
        }
        
        level.ztron.bonusRooms[ room.name ] = room;
    }
    
    utility::flag_set( "ztron_bonus_room_initialized", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_travel_warning", "evt_ztron_travel_warning" );
    level.ztron.var_a583cea4fa0bd2f9 = [ "plunder", "shadow_vault", "nuke_vault" ];
    level.ztron.var_10a012e15e4f420e = [ "duck_farm", "boom_room", "treasure", "power_room", "hangar", "armory" ];
    level.ztron.var_3fc307370ce6c061 = level.ztron.var_10a012e15e4f420e;
    level.ztron.var_bc4e90116753fae1 = [ "fall_100", "racing2", "racing", "side_scroller1", "side_scroller2", "side_scroller3", "rail_shooter" ];
    level.ztron.var_fd9556652429d73 = [ "shadow_vault", "fate", "eggxit", "nuke_vault" ];
    
    /#
        level thread function_ac7ee3673d6e340d();
        level thread function_27f2ca27d747d0ea();
    #/
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0xe44c73d7, Offset: 0x10c2
// Size: 0x12c
function main()
{
    self notify( #"hash_7ecb55d2bc03de8e" );
    self endon( #"hash_7ecb55d2bc03de8e" );
    level.ztron.var_8a9067aa4cd65369 = undefined;
    level.ztron.var_86ab4cc5041791bb = undefined;
    level.ztron.lastBonusRoomRound = 1;
    
    foreach ( room in level.ztron.bonusRooms )
    {
        room.instancecount = 0;
        room.cooldowntimeout = 0;
    }
    
    level.ztron.var_b669c00c4c0cdf55 = 20;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        level.ztron.var_b669c00c4c0cdf55 = 4;
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xdd29d4f0, Offset: 0x11f6
// Size: 0x9a
function function_3397393d2126b3fb( name )
{
    foreach ( room in level.ztron.bonusRooms )
    {
        if ( room.name == name )
        {
            return room;
        }
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x76b659ae, Offset: 0x1298
// Size: 0x18b
function function_411cd9152bb19dd9( roundnumber = level.ztron.roundnumber )
{
    possibles = [];
    
    foreach ( room in level.ztron.bonusRooms )
    {
        if ( room.maxvisits != 999 && room.maxvisits <= 0 )
        {
            continue;
        }
        
        if ( room.cooldowntimeout > gettime() )
        {
            continue;
        }
        
        if ( roundnumber < room.minlevel )
        {
            continue;
        }
        
        if ( roundnumber >= room.var_acecf1de8ec2250a )
        {
            continue;
        }
        
        if ( room.discoveryNeeded )
        {
            continue;
        }
        
        if ( room.special_context )
        {
            continue;
        }
        
        if ( room.neverallow )
        {
            continue;
        }
        
        if ( level.ztron.var_95d8c7a469393957 )
        {
            if ( issubstr( room.name, "racing" ) )
            {
                continue;
            }
        }
        
        possibles[ possibles.size ] = room;
    }
    
    if ( possibles.size == 0 )
    {
        return;
    }
    
    return possibles[ randomint( possibles.size ) ];
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x1066972b, Offset: 0x142c
// Size: 0xab
function function_98dedbfc79dc3572( type )
{
    roomsarray = [];
    
    foreach ( room in level.ztron.bonusRooms )
    {
        if ( room.type == type )
        {
            roomsarray[ roomsarray.size ] = room;
        }
    }
    
    return roomsarray;
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0x9d4da296, Offset: 0x14e0
// Size: 0x109
function function_cc95fac45228eccd()
{
    if ( level.ztron.var_3fc307370ce6c061.size <= 0 )
    {
        level.ztron.var_3fc307370ce6c061 = level.ztron.var_10a012e15e4f420e;
    }
    
    for ( room = level.ztron.var_3fc307370ce6c061[ randomint( level.ztron.var_3fc307370ce6c061.size ) ]; level.ztron.var_50aba2982d27f7a5 == room ; room = level.ztron.var_3fc307370ce6c061[ randomint( level.ztron.var_3fc307370ce6c061.size ) ] )
    {
    }
    
    level.ztron.var_3fc307370ce6c061 = arrayremove( level.ztron.var_3fc307370ce6c061, room );
    level.ztron.var_50aba2982d27f7a5 = room;
    return room;
}

// Namespace ztron_bonus_room
// Params 2
// Checksum 0xa20a003, Offset: 0x15f2
// Size: 0x57
function function_1804325e677e0fc8( name, round = 0 )
{
    room = function_3397393d2126b3fb( name );
    
    if ( isdefined( room ) && round > 0 )
    {
        level.ztron.var_add97c5e82e892bf[ round ] = room;
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xf76a193f, Offset: 0x1651
// Size: 0xc4
function function_b018ee630661e155( name )
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    ztron_debug::debugmsg( "^^^^^^^^^^^^^           ZTRON forcing bonus room to: " + name + " Current World State = " + level.ztron.var_291105dfc6b5a9b8 );
    level.ztron.var_86ab4cc5041791bb = name;
    room = function_3397393d2126b3fb( level.ztron.var_86ab4cc5041791bb );
    assert( isdefined( room ), "<dev string:x24>" );
    level thread ztron_arena::function_3f42f859ddaaacdb( room.playersstarts[ 0 ].origin, 1, undefined, undefined, "ztron_round_stopped_spawning", "round_over" );
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0xfafcc701, Offset: 0x171d
// Size: 0x15
function function_93b4a149aa740e42()
{
    level.ztron.var_86ab4cc5041791bb = undefined;
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0xa1aa5334, Offset: 0x173a
// Size: 0x6e
function function_5420aba3a322972d()
{
    if ( isdefined( level.ztron.var_86ab4cc5041791bb ) )
    {
        room = function_3397393d2126b3fb( level.ztron.var_86ab4cc5041791bb );
    }
    
    if ( !isdefined( room ) )
    {
        room = level.ztron.var_add97c5e82e892bf[ level.ztron.roundnumber ];
    }
    
    return room;
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0xb97ddd5c, Offset: 0x17b1
// Size: 0x9b
function function_7e1e5feb0aa2cd09()
{
    room = function_5420aba3a322972d();
    
    if ( isdefined( room ) )
    {
        if ( !room.neverallow )
        {
            return room;
        }
    }
    
    if ( level.ztron.var_4b6834fb472ff3dc )
    {
        return;
    }
    
    if ( level.ztron.roundnumber < level.ztron.var_b669c00c4c0cdf55 )
    {
        return;
    }
    
    level.ztron.var_59e36a5ae1929a41 = function_411cd9152bb19dd9();
    return level.ztron.var_59e36a5ae1929a41;
}

// Namespace ztron_bonus_room
// Params 2
// Checksum 0x1e932d51, Offset: 0x1855
// Size: 0x184, Type: bool
function try_activate_bonus_room( player, returnlightstate )
{
    if ( level.ztron.blitzmode )
    {
        return false;
    }
    
    room = function_5420aba3a322972d();
    
    if ( isdefined( room ) )
    {
        if ( room.neverallow )
        {
            return false;
        }
        
        level thread activate_bonus_room( room, returnlightstate );
        return true;
    }
    
    if ( level.ztron.var_4b6834fb472ff3dc )
    {
        return false;
    }
    
    if ( level.ztron.roundnumber < level.ztron.var_b669c00c4c0cdf55 )
    {
        return false;
    }
    
    var_bf9611110d3c96d6 = level.ztron.roundnumber - level.ztron.lastBonusRoomRound;
    range_decrease = var_bf9611110d3c96d6 * 6;
    
    if ( isdefined( player ) && player ztron_fate::function_c93d5c389d532c34( 2, 1 ) )
    {
        range_decrease += getdvarint( @"hash_f52da643dc958014", 22 );
    }
    
    rand_range = int( clamp( 100 - range_decrease, 15, 100 ) );
    roll = randomint( rand_range );
    
    if ( roll < 15 )
    {
        room = level.ztron.var_59e36a5ae1929a41;
        
        if ( !isdefined( room ) )
        {
            return false;
        }
        
        level.ztron.var_59e36a5ae1929a41 = undefined;
        level thread activate_bonus_room( room, returnlightstate );
        return true;
    }
    
    return false;
}

// Namespace ztron_bonus_room
// Params 4
// Checksum 0xb5f2c85a, Offset: 0x19e2
// Size: 0x10c
function function_8366aa370d503825( trigger, fadedistance = 0, icon = "ui_hud_ztron_icon_round_exit", text = &"ztron_hud/exit" )
{
    level notify( #"bonusRoomExitSet" );
    objectiveindex = objidpoolmanager::requestobjectiveid();
    
    if ( objectiveindex != -1 )
    {
        objectoffset = ( 0, 0, 80 );
        objidpoolmanager::objective_add_objective( objectiveindex, "current", trigger.origin + objectoffset, icon );
        objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
        objidpoolmanager::objective_playermask_showtoall( objectiveindex );
        objidpoolmanager::objective_showdistance( objectiveindex, 0 );
        objidpoolmanager::objective_set_play_intro( objectiveindex, 0 );
        objidpoolmanager::objective_set_play_outro( objectiveindex, 0 );
        objidpoolmanager::update_objective_setfriendlylabel( objectiveindex, text );
        objidpoolmanager::update_objective_setneutrallabel( objectiveindex, text );
        objidpoolmanager::update_objective_setenemylabel( objectiveindex, text );
        
        if ( fadedistance )
        {
            objidpoolmanager::function_de3fb937d4f45f38( objectiveindex, 512, 1024 );
        }
    }
    
    return objectiveindex;
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xc5ae47b0, Offset: 0x1af7
// Size: 0xef
function function_96dda45c77d80d18( room )
{
    self notify( #"hash_be029fe5380b15c6" );
    self endon( #"hash_be029fe5380b15c6" );
    level utility::waittill_any_return( "bonus_room_expired" );
    level.ztron.var_e1b2540e2c81f811 = undefined;
    level.var_823f78c605f46c5c = istrue( level.ztron.var_74a3707334cfe144 );
    
    foreach ( player in level.players )
    {
        player ztron_camera::function_9d2ce447580a6290();
        player.ztron.var_8a46e28ad02229a8 = undefined;
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x5fb3cd7f, Offset: 0x1bee
// Size: 0x12c
function function_85a66f6a1d0a37ba( room )
{
    player = self;
    
    if ( !player ztron_player_utility::function_a120489ddd3aa5ce() )
    {
        return;
    }
    
    if ( player ztron_player_utility::isplayerspectating() )
    {
        return;
    }
    
    player ztron_arena::function_793958a7b608eb74( 1 );
    
    if ( room.var_6210dc1f68bbfa57 != 2 )
    {
        if ( room.var_6210dc1f68bbfa57 == 0 )
        {
            if ( player.ztron.var_a4c2f70bbc713f98 && !level.ztron.var_74a3707334cfe144 )
            {
                player notify( #"hash_463ac41b7bf90869" );
            }
            
            player ztron_camera::function_79d64be315aa51c9( 5 );
        }
        else if ( room.var_6210dc1f68bbfa57 == 1 )
        {
            if ( player.ztron.var_a4c2f70bbc713f98 && !level.ztron.var_74a3707334cfe144 )
            {
                player notify( #"hash_463ac41b7bf90869" );
            }
            
            player ztron_camera::function_45b3c6e393d142a7();
        }
        
        player.ztron.var_8a46e28ad02229a8 = room.var_6210dc1f68bbfa57 == 0;
        player ztron_camera::function_1873609edbd36982();
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x9b3c396a, Offset: 0x1d22
// Size: 0xd8
function function_9b800a2fabd66102( room )
{
    level.ztron.var_e1b2540e2c81f811 = room.var_e1b2540e2c81f811;
    
    if ( level.ztron.var_74a3707334cfe144 )
    {
        level.var_823f78c605f46c5c = !level.ztron.var_e1b2540e2c81f811;
    }
    
    foreach ( player in level.players )
    {
        player function_85a66f6a1d0a37ba( room );
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xb9fdd2ca, Offset: 0x1e02
// Size: 0x2a9
function function_69fec77c1f7f7038( room )
{
    ztron_camera::function_90951f3fca05e46a( room.origin, room.angles );
    
    foreach ( player in level.players )
    {
        if ( !player ztron_player_utility::function_a120489ddd3aa5ce() )
        {
            continue;
        }
        
        if ( player ztron_player_utility::isplayerspectating() )
        {
            continue;
        }
        
        player notify( #"ztron_player_dump_vehicle" );
        player notify( #"ztron_playerdumpfps" );
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        if ( !player ztron_player_utility::function_a120489ddd3aa5ce() )
        {
            continue;
        }
        
        if ( player ztron_player_utility::isplayerspectating() )
        {
            continue;
        }
        
        playerstart = room.playersstarts[ player.sessionuimemberindex ];
        player thread ztron_util::teleport_player( playerstart.origin, playerstart.angles ?? ( 0, 0, 0 ) );
        player ztron_player_utility::function_e914a81b9f8ce0c8( playerstart.origin );
    }
    
    ztron_player_utility::function_28d3a926aa4df460();
    waitframe();
    level notify( #"hash_a41416bce603e07" );
    function_9b800a2fabd66102( room );
    
    if ( isdefined( room.var_d822af3942fcbc3d ) )
    {
        [[ room.var_d822af3942fcbc3d ]]( room );
    }
    
    thread function_96dda45c77d80d18( room );
    level ztron_camera::function_517f03fc102b896d( 1 );
    wait 1;
    level ztron_camera::function_517f03fc102b896d( 0 );
    var_4cb4ae83b0343ae = !room.var_7ea107d140fc9891;
    
    foreach ( player in level.players )
    {
        player ztron_util::fade_in( var_4cb4ae83b0343ae );
    }
    
    level utility::flag_clear( "ztron_screen_faded" );
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xf7211d14, Offset: 0x20b3
// Size: 0x483
function function_f7a8bdcd439072ca( room )
{
    level notify( #"bonus_room_cleanup" );
    
    if ( !isdefined( room ) )
    {
        return;
    }
    
    function_93b4a149aa740e42();
    ztron_util::killallenemies();
    var_1e463889d28f9647 = [ room.exit, room.abort ];
    
    foreach ( exit in var_1e463889d28f9647 )
    {
        if ( isdefined( exit.objectiveindex ) )
        {
            objidpoolmanager::returnobjectiveid( exit.objectiveindex );
            exit.objectiveindex = undefined;
        }
    }
    
    ztron_util::killallenemies();
    level thread ztron_item::function_25f69b2b896fd56();
    
    foreach ( trap in room.hazards )
    {
        trap notify( #"destroy_hazard" );
    }
    
    if ( isdefined( room.checkpoints ) )
    {
        foreach ( checkpoint in room.checkpoints )
        {
            checkpoint triggerdisable();
            checkpoint notify( #"disable_trigger" );
        }
    }
    
    if ( isdefined( room.deadzones ) )
    {
        foreach ( deadzone in room.deadzones )
        {
            deadzone triggerdisable();
            deadzone notify( #"disable_trigger" );
        }
    }
    
    if ( isdefined( room.var_fa8d8a6bab814752 ) )
    {
        foreach ( tweakzone in room.var_fa8d8a6bab814752 )
        {
            tweakzone notify( #"deactivate" );
        }
    }
    
    if ( isdefined( room.cleanupcallback ) )
    {
        level thread [[ room.cleanupcallback ]]( room );
    }
    
    ztron_ui::function_881375a170813656();
    level notify( #"bonus_room_completed" );
    
    foreach ( player in level.players )
    {
        player notify( #"bonus_room_completed" );
        
        if ( player isonascender() )
        {
            player dropoffascender();
        }
    }
    
    level.ztron.var_8a9067aa4cd65369 = undefined;
    function_e9aa3623cb56435e();
    ztron_ui::function_559d7c88c3ffd811();
    room.instancecount++;
    room.discoveryNeeded = 0;
    room.cooldowntimeout = room.cooldownms + gettime();
    
    if ( room.maxvisits > 0 && room.maxvisits != 999 )
    {
        room.maxvisits--;
    }
    
    level.ztron.var_519604ae28900909 = room;
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x73171837, Offset: 0x253e
// Size: 0x134
function function_db191e373bb0ad9d( labels )
{
    self notify( #"hash_3a84bd483e301749" );
    self endon( #"hash_3a84bd483e301749" );
    level endon( #"bonus_room_completed", #"ztron_game_is_over", #"bonus_room_abort_closed" );
    level endon( #"slayer_round_finished" );
    self endon( #"death" );
    playerscount = 0;
    
    while ( true )
    {
        if ( self function_b0b72d20769d0233() && self.objectiveindex != -1 && ztron_util::function_9bb4cd8565cc00() > 1 )
        {
            players = ztron_util::function_a5baa3e740328ff1();
            
            if ( players.size != playerscount )
            {
                if ( players.size == 1 )
                {
                    leavingplayer = players[ 0 ];
                    leavingplayer ztron_ui::function_e5c28b773c483dbb( "MULTIPLAYER_LEAVE" );
                }
                
                playerscount = players.size;
                labelindex = clampint( playerscount, 0, labels.size );
                label = labels[ labelindex ];
                objidpoolmanager::update_objective_setfriendlylabel( self.objectiveindex, label );
                objidpoolmanager::update_objective_setneutrallabel( self.objectiveindex, label );
                objidpoolmanager::update_objective_setenemylabel( self.objectiveindex, label );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x3039b75a, Offset: 0x267a
// Size: 0x10e
function function_fb8865f100227f3c( room )
{
    self notify( #"hash_cf91d5ed3d5e447d" );
    self endon( #"hash_cf91d5ed3d5e447d" );
    level endon( #"bonus_room_completed", #"ztron_game_is_over", #"bonus_room_abort_closed" );
    self.objectiveindex = function_8366aa370d503825( self, room.var_d4ea8a279b48a561, "ui_hud_ztron_icon_abort_exit", &"ztron_hud/abort" );
    labels = [ &"ztron_hud/abort", &"ztron_hud/abort_12", &"ztron_hud/abort_22" ];
    thread function_db191e373bb0ad9d( labels );
    
    while ( room.exit )
    {
        self waittill( #"trigger" );
        
        if ( !ztron_util::function_615c5e65f63b006a( self ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( self function_b0b72d20769d0233() && room.exit function_b0b72d20769d0233() )
        {
            room.exit notify( #"abort" );
            break;
        }
    }
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0xd5388b59, Offset: 0x2790
// Size: 0xb5
function private function_7cad3967445641d8( sec )
{
    level endon( #"deactivate_bonus_room", #"game_reset", #"game_over", #"ztron_game_is_over" );
    wait sec;
    
    foreach ( player in level.players )
    {
        ztron_sound::ztron_playsound( "ztron_travel_warning", undefined, player );
    }
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0xe656d010, Offset: 0x284d
// Size: 0x21
function function_ca17ce0e05c6a943()
{
    self triggerdisable();
    wait 5;
    self triggerenable();
    self.objectiveindex = function_8366aa370d503825( self );
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xb178716f, Offset: 0x2876
// Size: 0x62
function function_9595e8f0926735a4( room )
{
    if ( isdefined( room.abort.objectiveindex ) )
    {
        objidpoolmanager::returnobjectiveid( room.abort.objectiveindex );
        room.abort.objectiveindex = undefined;
    }
    
    level notify( #"bonus_room_abort_closed" );
}

// Namespace ztron_bonus_room
// Params 0
// Checksum 0x16c412a4, Offset: 0x28e0
// Size: 0x84, Type: bool
function function_928916d5ea295c3c()
{
    foreach ( player in level.players )
    {
        if ( player.var_d9f82b082e1118d3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0xa442201c, Offset: 0x296d
// Size: 0x422
function function_13d291f7bfd1febe( room )
{
    timeout = room.timeout ?? 120;
    
    if ( room.abort )
    {
        room.abort thread function_fb8865f100227f3c( room );
    }
    
    if ( isdefined( room.exit ) )
    {
        if ( !room.var_1fbfe6996f3460d9 )
        {
            if ( room.var_76a1c6d566d98aed )
            {
                room.exit.objectiveindex = function_8366aa370d503825( room.exit );
            }
            else
            {
                room.exit thread function_ca17ce0e05c6a943();
            }
        }
        
        labels = [ &"ztron_hud/exit", &"ztron_hud/exit_12", &"ztron_hud/exit_22" ];
        room.exit thread function_db191e373bb0ad9d( labels );
        hintcooldown = 0;
        
        if ( timeout == 999 || level.ztron.var_5a4f8972e996f97c )
        {
            while ( true )
            {
                result = room.exit utility::waittill_any_return( "trigger", "abort", "lost", "won" );
                
                if ( room.exit function_b0b72d20769d0233() )
                {
                    if ( result == "lost" || result == "won" )
                    {
                        break;
                    }
                    
                    if ( !room.abort )
                    {
                        if ( !ztron_util::function_615c5e65f63b006a( room.exit ) )
                        {
                            wait 0.1;
                            continue;
                        }
                    }
                    
                    if ( function_928916d5ea295c3c() == 0 )
                    {
                        break;
                    }
                    
                    if ( gettime() > hintcooldown )
                    {
                        level thread ztron_ui::function_6e791be3702fa2a8( "STORE_PLAYER_IS_BROWSNING_HINT", 0, 8, 1 );
                        hintcooldown = gettime() + 12000;
                    }
                    
                    wait 0.1;
                    continue;
                }
            }
        }
        else
        {
            if ( !room.var_a3f88f4d9c9c6b73 )
            {
                ztron_ui::function_f41315c660256627( timeout * 1000 );
                level thread function_7cad3967445641d8( timeout - 10 );
            }
            
            endtime = gettime() + timeout * 1000;
            
            while ( endtime > gettime() )
            {
                result = room.exit utility::waittill_any_timeout( 1, "trigger", "abort", "lost", "won" );
                
                if ( result == "timeout" )
                {
                    continue;
                }
                
                if ( room.exit function_b0b72d20769d0233() )
                {
                    if ( result == "lost" || result == "won" )
                    {
                        win = result == "won";
                        level notify( #"bonus_room_exit_taken", { #success:win } );
                        break;
                    }
                    
                    if ( !room.abort )
                    {
                        if ( !ztron_util::function_615c5e65f63b006a( room.exit ) )
                        {
                            continue;
                        }
                    }
                    
                    if ( function_928916d5ea295c3c() == 0 )
                    {
                        win = result == "abort" ? 0 : 1;
                        level notify( #"bonus_room_exit_taken", { #success:win } );
                        break;
                    }
                    
                    if ( gettime() > hintcooldown )
                    {
                        level thread ztron_ui::function_6e791be3702fa2a8( "STORE_PLAYER_IS_BROWSNING_HINT", 0, 8, 1 );
                        hintcooldown = gettime() + 12000;
                    }
                    
                    continue;
                }
            }
        }
    }
    else if ( room.notimeout )
    {
        room waittill( #"room_done" );
    }
    else
    {
        ztron_ui::function_f41315c660256627( timeout * 1000 );
        room utility::waittill_any_timeout( timeout, "room_done" );
    }
    
    foreach ( player in level.players )
    {
        player notify( #"force_close_store" );
    }
    
    ztron_sound::ztron_playsound( "ztron_travel_doors_chosen" );
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x5b4d3749, Offset: 0x2d97
// Size: 0x156
function function_6365d67128b01ae5( room )
{
    level.ztron.var_8a9067aa4cd65369 = room;
    level.ztron.var_f7b816a2c01df30a = gettime();
    level.ztron.lastBonusRoomRound = level.ztron.roundnumber;
    level.ztron.slayer.forcedbonusroom = undefined;
    ztron_weather::setlightstate( 0 );
    level.ztron.itemdef.var_a6fb8def3d6b72e9 = room.var_a6fb8def3d6b72e9;
    
    if ( isdefined( room.var_5290e343e7cabade ) )
    {
        ztron_camera::function_740408a841dcb4a5( room.var_5290e343e7cabade.origin );
        level.ztron.var_b25ff0c59f404fc9 = 1;
    }
    
    if ( isdefined( room.setupcallback ) )
    {
        level thread [[ room.setupcallback ]]( room );
    }
    
    if ( isdefined( room.var_bd9df22b9216b2af ) )
    {
        setdvar( @"hash_535b4826432520f3", room.var_bd9df22b9216b2af getentitynumber() );
    }
    else
    {
        setdvar( @"hash_535b4826432520f3", -1 );
    }
    
    function_e9aa3623cb56435e();
}

// Namespace ztron_bonus_room
// Params 2
// Checksum 0x7dd8f415, Offset: 0x2ef5
// Size: 0x3d8
function activate_bonus_room( room, returnlightstate )
{
    level endon( #"ztron_game_is_over", #"bonus_room_completed" );
    level notify( #"activate_bonus_room", { #room:room } );
    ztron_debug::debugmsg( "^^^^^^^^^^^^^           ZTRON activating bonus room to: " + room.name + " Current World State = " + level.ztron.var_291105dfc6b5a9b8 );
    ztron_util::killallenemies();
    ztron_ui::function_f6f4dd304ac8569b();
    ztron_ui::function_4eb411ba146450();
    returnstate = ztron_main::function_6cacd29a4f2b9588( 3 );
    assert( returnstate == 1, "<dev string:x38>" + returnstate );
    
    foreach ( player in level.players )
    {
        player thread ztron_player_utility::function_ca24a0915072a8f6( room.playersstarts[ 0 ].origin, 0 );
        
        if ( room.hazardzone )
        {
            player ztron_player_utility::function_dac9f20d4461a130();
        }
    }
    
    function_6365d67128b01ae5( room );
    thread function_47ff16843850e089( room );
    thread function_efa785634083003c( room );
    waitframe();
    level notify( #"bonus_room_ready" );
    
    foreach ( player in level.players )
    {
        player notify( #"bonus_room_ready" );
    }
    
    ztron_sound::function_ac1e49175da7897d( "bonusRoomEvent", "bonusRoomActivated", room.name );
    oldorientation = level.ztron.arenaCamFlip;
    ztron_arena::function_f2e9dd5fcbd74bd( room.var_feda109afe10f2ca );
    function_69fec77c1f7f7038( room );
    function_c7cfaa398ac28daf( room.name );
    function_7b857b0389dcb1c4( room );
    function_4e59d7aaccaa9a5( room );
    function_2b795f92ecc5fd9( room );
    level notify( #"hash_9d2492f7742c7564" );
    level thread ztron_arena::function_8ece8896a459622e( 1, 10, returnlightstate, "bonusRoomExitSet" );
    var_4ba2514616c6eacb = gettime();
    function_13d291f7bfd1febe( room );
    ztron_ui::function_ce7fbecb1ea8d56f();
    
    if ( !room.blockfadeout )
    {
        ztron_util::function_9ecee6f38c56d30f( 1 );
    }
    
    if ( !room.var_15fa3a91a0532c84 )
    {
        level notify( #"bonus_room_expired" );
    }
    
    ztron_sound::function_ac1e49175da7897d( "bonusRoomEvent", "bonusRoomDeactivated", room.name );
    level notify( #"deactivate_bonus_room" );
    waittillframeend();
    ztron_main::function_6cacd29a4f2b9588( returnstate );
    ztron_camera::function_b75a71ef33e0e6cc();
    
    if ( !room.blockfadeout )
    {
        if ( isdefined( oldorientation ) )
        {
            ztron_arena::function_f2e9dd5fcbd74bd( oldorientation );
        }
    }
    
    var_73d14bf25269a649 = int( ( gettime() - var_4ba2514616c6eacb ) / 1000 );
    
    foreach ( player in level.players )
    {
        player thread ztron_player_utility::function_402a17b12b263a82();
        ztron_player_utility::function_9137f806254e5d71( player, var_73d14bf25269a649 );
    }
    
    waittillframeend();
    level thread function_f7a8bdcd439072ca( room );
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0xf78d1b55, Offset: 0x32d5
// Size: 0xb1
function private function_7b857b0389dcb1c4( room )
{
    if ( !isdefined( room.checkpoints ) || room.checkpoints.size == 0 )
    {
        return;
    }
    
    foreach ( checkpoint in room.checkpoints )
    {
        checkpoint thread monitorcheckpoint();
        checkpoint triggerenable();
    }
}

// Namespace ztron_bonus_room
// Params 0, eflags: 0xc
// Checksum 0xd3e53dfe, Offset: 0x338e
// Size: 0xf7
function private monitorcheckpoint()
{
    self notify( #"hash_533660f0293e8986" );
    self endon( #"hash_533660f0293e8986" );
    self endon( #"death" );
    self endon( #"disable_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( self function_b0b72d20769d0233() )
        {
            if ( isplayer( ent ) )
            {
                player = ent;
            }
            else if ( ent vehicle::is_vehicle() && isplayer( ent.owner ) )
            {
                player = ent.owner;
            }
            
            if ( player )
            {
                safecheckpoint = self.origin;
                
                if ( self.target )
                {
                    target = utility::getstruct( self.target, "targetname" );
                    safecheckpoint = target.origin;
                }
                
                player ztron_player_utility::function_e914a81b9f8ce0c8( safecheckpoint );
            }
        }
    }
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0x35fb3d1d, Offset: 0x348d
// Size: 0xb1
function private function_4e59d7aaccaa9a5( room )
{
    if ( !isdefined( room.deadzones ) || room.deadzones.size == 0 )
    {
        return;
    }
    
    foreach ( deadzone in room.deadzones )
    {
        deadzone thread monitordeadzone();
        deadzone triggerenable();
    }
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0x4f95c36e, Offset: 0x3546
// Size: 0xaa
function private function_2b795f92ecc5fd9( room )
{
    if ( !isdefined( room.var_fa8d8a6bab814752 ) || room.var_fa8d8a6bab814752.size == 0 )
    {
        return;
    }
    
    foreach ( tweakzone in room.var_fa8d8a6bab814752 )
    {
        tweakzone thread ztron_arena::function_78148da55f00880e();
    }
}

// Namespace ztron_bonus_room
// Params 0, eflags: 0xc
// Checksum 0xc79ef270, Offset: 0x35f8
// Size: 0xe3
function private monitordeadzone()
{
    self notify( #"hash_7a7be39b56c634bb" );
    self endon( #"hash_7a7be39b56c634bb" );
    self endon( #"death" );
    self endon( #"disable_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !self function_b0b72d20769d0233() )
        {
            continue;
        }
        
        player = undefined;
        
        if ( isplayer( ent ) )
        {
            player = ent;
            
            if ( !player ztron_player_utility::function_b22546586c836fe9() )
            {
                continue;
            }
        }
        else if ( ent vehicle::is_vehicle() && isplayer( ent.owner ) )
        {
            player = ent.owner;
        }
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.ztron.var_752bd0f0c94ae04a )
        {
            continue;
        }
        
        player thread function_60904095c36f2500( self );
    }
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0xc
// Checksum 0xfb76cc66, Offset: 0x36e3
// Size: 0xbf
function private function_60904095c36f2500( trigger )
{
    self notify( #"hash_bfe2970947bfb8df" );
    self endon( #"hash_bfe2970947bfb8df" );
    self endon( #"disconnect" );
    self.ztron.var_752bd0f0c94ae04a = 1;
    
    if ( !self.ztron.vehicle && !self.isjuggernaut )
    {
        self.ztron.dmggrace = gettime();
        self dodamage( self.health + 100, self.origin, trigger );
    }
    
    wait 1;
    ztron_player_utility::function_d078263c76543d67();
    self.ztron.var_752bd0f0c94ae04a = 0;
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0xc
// Checksum 0x683e0bad, Offset: 0x37aa
// Size: 0x5e
function private function_47ff16843850e089( room )
{
    self notify( #"hash_485ab9a0324fd91c" );
    self endon( #"hash_485ab9a0324fd91c" );
    level endon( #"bonus_room_completed", #"ztron_game_is_over" );
    level waittill( #"hash_a41416bce603e07" );
    
    if ( !room.var_6a5f366ee6f9f320 )
    {
        room thread ztron_item::function_6607be6e510e8f54();
    }
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0xc
// Checksum 0xf8c92f7f, Offset: 0x3810
// Size: 0x58
function private function_efa785634083003c( room )
{
    self notify( #"hash_b7978051aeb0c0cf" );
    self endon( #"hash_b7978051aeb0c0cf" );
    level endon( #"bonus_room_completed", #"ztron_game_is_over" );
    level waittill( #"hash_a41416bce603e07" );
    ztron_hazard::function_ff91beb643f81d0b( room.hazards );
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0x79edadff, Offset: 0x3870
// Size: 0x58
function private function_c7cfaa398ac28daf( var_432837c73cc5752 )
{
    if ( isdefined( level.ztron.var_bcfb9c8ab89ea6e6 ) )
    {
        [[ level.ztron.var_bcfb9c8ab89ea6e6 ]]( var_432837c73cc5752 );
    }
    else
    {
        ztron_ui::function_c970ade722a495c3( get_room_category( var_432837c73cc5752 ), var_432837c73cc5752 );
    }
    
    function_e74307718f343ff9( var_432837c73cc5752 );
}

// Namespace ztron_bonus_room
// Params 6
// Checksum 0x402c1b1f, Offset: 0x38d0
// Size: 0x3e5
function function_bd3a5142e2a2e9d6( enemyspot, var_465991bdb1b256f3 = 0, interval = 0, healthscale = 0, var_ad6e19dfdd790b25 = 0, suicidetime = 0 )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    if ( !isdefined( enemyspot.script_noteworthy ) )
    {
        return;
    }
    
    enemyspot.targetplayer = enemyspot ztron_util::function_2f4d27d87e05d778();
    radius = 30;
    minradius = 10;
    
    if ( isdefined( enemyspot.radius ) )
    {
        radius = enemyspot.radius;
    }
    
    if ( radius <= minradius )
    {
        minradius = 0;
    }
    
    movespeedoverride = int( enemyspot.script_parameters ?? 0 );
    
    switch ( movespeedoverride )
    {
        case 1:
            movespeedoverride = "walk";
            break;
        case 2:
            movespeedoverride = "run";
            break;
        case 3:
            movespeedoverride = "sprint";
            break;
        case 0:
        default:
            movespeedoverride = undefined;
            break;
    }
    
    var_588fb2984e5a8417 = strtok( enemyspot.script_noteworthy, "|" );
    
    foreach ( enemydata in var_588fb2984e5a8417 )
    {
        args = strtok( enemydata, ";" );
        name = args[ 0 ];
        
        if ( !isdefined( name ) )
        {
            continue;
        }
        
        count = 1;
        
        if ( args.size > 1 )
        {
            count = int( args[ 1 ] );
        }
        
        aitypedef = ztron_enemy::function_96eea0d09d5640d1( name );
        
        if ( !isdefined( aitypedef ) )
        {
            continue;
        }
        
        ztron_debug::debugmsg( "spawn" + self.name + "Enemies: " + name + " count: " + count + " minRadius: " + minradius + " radius: " + radius );
        
        if ( isdefined( self.enemyspawning ) )
        {
            self.enemyspawning++;
        }
        
        for ( i = 0; i < count ; i++ )
        {
            pos = enemyspot.origin + anglestoforward( ( 0, randomfloat( 360 ), 0 ) ) * ( minradius + randomfloat( radius - minradius ) );
            enemy = ztron_enemy::function_acee91c445fafd29( aitypedef, pos, enemyspot.targetplayer, undefined, 1, 1 );
            
            if ( healthscale > 0 )
            {
                basehealth = ( clamp( enemy.maxhealth - level.ztron.var_f1569c16a29ffcbf, 0, 35000 ) + 90 ) * healthscale;
                overridehealth = basehealth + basehealth * ( level.players.size - 1 ) * var_ad6e19dfdd790b25;
                enemy ztron_ai_zombie::zombie_sethealth( overridehealth );
            }
            
            if ( movespeedoverride )
            {
                enemy.var_361a087ab08adc1c = movespeedoverride;
            }
            
            if ( var_465991bdb1b256f3 )
            {
                enemy notify( #"kill_think" );
            }
            
            if ( suicidetime > 0 && !enemy.ztron.boss )
            {
                enemy thread ztron_util::function_ea0a0be5c5468c48( suicidetime );
            }
            
            if ( interval > 0 )
            {
                wait interval;
            }
        }
        
        if ( isdefined( self.enemyspawning ) )
        {
            self.enemyspawning--;
        }
    }
}

// Namespace ztron_bonus_room
// Params 0, eflags: 0x4
// Checksum 0xd5e6c509, Offset: 0x3cbd
// Size: 0x61
function private function_e9aa3623cb56435e()
{
    roomindex = -1;
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
    {
        roomindex = ztron_ui::function_fc76def703d56598( %"hash_4433117c19d41455", level.ztron.var_8a9067aa4cd65369.name );
    }
    
    setomnvar( "ui_ztron_current_bonus_room", roomindex );
}

// Namespace ztron_bonus_room
// Params 1, eflags: 0x4
// Checksum 0x4902f335, Offset: 0x3d26
// Size: 0x268
function private function_e74307718f343ff9( var_432837c73cc5752 )
{
    var_4b6d3128810fce2a = undefined;
    
    switch ( var_432837c73cc5752 )
    {
        case #"hash_39f2e38de2fe6593":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchrr";
            break;
        case #"hash_7baf29a6546e13bd":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchca";
            break;
        case #"hash_d432550773b20b34":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchf100";
            break;
        case #"hash_9cbfc152ded8c43":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchrofcl";
            var_4b6d3128810fce2a = "dx_zm_ztr4_anno_anz4_d4rofhn";
            break;
        case #"hash_37c1d95c5679fc73":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchmrmc";
            break;
        case #"hash_7365391eec7c2427":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchie";
            break;
        case #"hash_4f76b82b53e822a":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4sbchhosb";
            break;
        case #"hash_46102be38855bbb7":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmarm";
            break;
        case #"hash_6ee2104b177eb8f9":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmcp";
            break;
        case #"hash_2a7f3b90f14d4a48":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmkbrm";
            break;
        case #"hash_3d9ccd28b21cb88e":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmvhdpt";
            break;
        case #"hash_b51c5d96fa396084":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmtrs";
            break;
        case #"hash_7baf26a6546e0f04":
        case #"hash_7baf28a6546e122a":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnarplt";
            break;
        case #"hash_59b8e9d05b31ff9":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmpln";
            break;
        case #"hash_96ca15781128c35c":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4bnrmut";
            break;
        case #"hash_30ba56d4c28ea166":
        case #"hash_dbff2d1db59baa17":
            dialogsoundalias = "dx_zm_ztr4_anno_anz4_d4dngadci";
            break;
        default:
            dialogsoundalias = undefined;
            break;
    }
    
    roomtype = get_room_category( var_432837c73cc5752 );
    splashalias = roomtype;
    
    switch ( roomtype )
    {
        case #"hash_a70a4916a979acbe":
            var_8a4c45fef27f6a80 = "dx_zm_ztr4_anno_anz4_d4bnrmdsc";
            break;
        case #"hash_72c977f0f668d52d":
            var_8a4c45fef27f6a80 = "dx_zm_ztr4_anno_anz4_d4rcinf";
            break;
        case #"hash_a740b56a6e7ad838":
            var_8a4c45fef27f6a80 = "dx_zm_ztr4_anno_anz4_d4sbchhz";
            break;
        default:
            var_8a4c45fef27f6a80 = undefined;
            break;
    }
    
    ztron_sound::ztron_playsound( splashalias );
    ztron_util::function_40ad6a6cc144aa3f( var_8a4c45fef27f6a80 );
    ztron_util::function_40ad6a6cc144aa3f( dialogsoundalias, 1 );
    ztron_util::function_40ad6a6cc144aa3f( var_4b6d3128810fce2a, 1 );
}

// Namespace ztron_bonus_room
// Params 1
// Checksum 0x4d08d9d1, Offset: 0x3f96
// Size: 0x10c
function get_room_category( ref )
{
    bonusRooms = [ "duck_farm", "boom_room", "plunder", "treasure", "power_room", "hangar", "armory" ];
    silverbackchallenges = [ "fall_100", "racing2", "racing", "side_scroller1", "side_scroller2", "side_scroller3", "rail_shooter" ];
    hazardzones = [ "shadow_vault", "fate", "eggxit", "nuke_vault" ];
    
    if ( arraycontains( bonusRooms, ref ) )
    {
        return "bonus_room";
    }
    else if ( arraycontains( silverbackchallenges, ref ) )
    {
        return "silverback_challenge";
    }
    else if ( arraycontains( hazardzones, ref ) )
    {
        return "hazard_zone";
    }
    
    return "uncategorized";
}

/#

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x21aea303, Offset: 0x40ab
    // Size: 0x103, Type: dev
    function function_98fd2d009c0a5115()
    {
        self notify( #"hash_55069a7f2fa449fd" );
        self endon( #"hash_55069a7f2fa449fd" );
        lastarena = level.ztron.active_arena;
        roundsleft = clampint( level.ztron.arena_rounds_left, 1, 4 );
        ztron_arena::function_6fc50167bb958c08( 1 );
        ztron_util::killallenemies();
        ztron_util::function_494e6b73ea596cc7( 3 );
        ztron_util::function_9ecee6f38c56d30f( 1 );
        
        if ( isdefined( lastarena ) )
        {
            lastarena ztron_arena::function_88c5627b236319bf();
            lastarena ztron_arena::function_221d68c3fc140fa3();
            lastarena thread ztron_arena::deactivatearena();
            waitframe();
        }
        
        ztron_arena::function_db224292347b1b3d();
        ztron_util::function_9ecee6f38c56d30f( 1 );
        try_activate_bonus_room( level.players[ 0 ], ztron_weather::function_8bfe19c4541053f2() );
        level utility::waittill_any( "<dev string:x7b>" );
        
        if ( isdefined( lastarena ) )
        {
            level thread ztron_arena::changearena( lastarena.id, roundsleft );
            return;
        }
        
        level thread ztron_arena::changearena( 0, 4 );
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x579f239e, Offset: 0x41b6
    // Size: 0x44, Type: dev
    function function_36b7464cef2d4bbb( params )
    {
        if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
        {
            function_cbdc7523e6d1f3b();
            wait 2;
        }
        
        name = params[ 0 ];
        function_b018ee630661e155( name );
        thread function_98fd2d009c0a5115();
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x3c77cccc, Offset: 0x4202
    // Size: 0x105, Type: dev
    function function_1748d46bedd66532( params )
    {
        index = int( params[ 0 ] );
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( isdefined( room ) )
        {
            checkpoint = room.checkpoints[ index % room.checkpoints.size ];
            
            foreach ( player in level.players )
            {
                player thread ztron_util::teleport_player( checkpoint.origin, checkpoint.angles ?? player.angles );
            }
        }
    }

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x3d81d24e, Offset: 0x430f
    // Size: 0x67, Type: dev
    function function_cbdc7523e6d1f3b()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( isdefined( room ) )
        {
            room notify( #"room_done" );
            
            if ( isdefined( room.exit ) )
            {
                room.exit notify( #"lost", level.players[ 0 ] );
            }
        }
    }

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x81fca128, Offset: 0x437e
    // Size: 0xcb, Type: dev
    function function_5c3bcf67070481b3()
    {
        var_bd8add1d3badd314 = [];
        var_bd8add1d3badd314[ "<dev string:x90>" ] = "<dev string:x9c>";
        var_bd8add1d3badd314[ "<dev string:xa6>" ] = "<dev string:xae>";
        var_bd8add1d3badd314[ "<dev string:xb7>" ] = "<dev string:xc2>";
        var_bd8add1d3badd314[ "<dev string:xcc>" ] = "<dev string:xdb>";
        var_bd8add1d3badd314[ "<dev string:xe3>" ] = "<dev string:xf6>";
        var_bd8add1d3badd314[ "<dev string:xfe>" ] = "<dev string:x10a>";
        var_bd8add1d3badd314[ "<dev string:x111>" ] = "<dev string:x11c>";
        var_bd8add1d3badd314[ "<dev string:x121>" ] = "<dev string:x12d>";
        var_bd8add1d3badd314[ "<dev string:x13c>" ] = "<dev string:x148>";
        var_bd8add1d3badd314[ "<dev string:x157>" ] = "<dev string:x172>";
        var_bd8add1d3badd314[ "<dev string:x181>" ] = "<dev string:x18f>";
        var_bd8add1d3badd314[ "<dev string:x198>" ] = "<dev string:x1a4>";
        var_bd8add1d3badd314[ "<dev string:x1af>" ] = "<dev string:x1bc>";
        var_bd8add1d3badd314[ "<dev string:x1c3>" ] = "<dev string:x1cf>";
        return var_bd8add1d3badd314;
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x39ed4ee4, Offset: 0x4451
    // Size: 0x9d, Type: dev
    function function_a3d5eeab59a68ff9( roomref )
    {
        var_bd8add1d3badd314 = function_5c3bcf67070481b3();
        
        foreach ( displayname, ref in var_bd8add1d3badd314 )
        {
            if ( ref == roomref )
            {
                return displayname;
            }
        }
        
        return roomref ?? "<dev string:x1d6>";
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x2fd5ddee, Offset: 0x44f6
    // Size: 0x18, Type: dev
    function function_72803b16e108580( displayname )
    {
        return "<dev string:x1e2>" + displayname;
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x5545b2d9, Offset: 0x4516
    // Size: 0x2c, Type: dev
    function function_26fbf99313eff547( ref )
    {
        displayname = function_a3d5eeab59a68ff9( ref );
        return function_72803b16e108580( displayname );
    }

    // Namespace ztron_bonus_room
    // Params 1
    // Checksum 0x422a9ae2, Offset: 0x454a
    // Size: 0x75, Type: dev
    function function_a83ec139a79f9d7e( ref )
    {
        category = get_room_category( ref );
        
        switch ( category )
        {
            case #"hash_a70a4916a979acbe":
                return "<dev string:x1fa>";
            case #"hash_72c977f0f668d52d":
                return "<dev string:x21a>";
            case #"hash_a740b56a6e7ad838":
                return "<dev string:x23b>";
            default:
                return "<dev string:x247>";
        }
    }

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x1ab5e72e, Offset: 0x45c7
    // Size: 0x116, Type: dev
    function function_dbd4bafdb005d916()
    {
        foreach ( ref, room in level.ztron.bonusRooms )
        {
            displayname = function_a3d5eeab59a68ff9( ref );
            devgui::function_cd4e263c1f3018ae( "<dev string:x255>" + function_a83ec139a79f9d7e( ref ) + "<dev string:x267>" + displayname, "<dev string:x269>" + ref, &function_36b7464cef2d4bbb );
            categoryname = function_72803b16e108580( displayname );
            
            for ( i = 0; i < room.checkpoints.size ; i++ )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x286>" + categoryname + "<dev string:x296>" + i, "<dev string:x2b1>" + i, &function_1748d46bedd66532 );
            }
        }
    }

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x57efc4ce, Offset: 0x46e5
    // Size: 0x35, Type: dev
    function function_ac7ee3673d6e340d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2cc>" );
        function_dbd4bafdb005d916();
        devgui::add_devgui_func( "<dev string:x2e0>", "<dev string:x2fd>", &function_cbdc7523e6d1f3b );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_bonus_room
    // Params 0
    // Checksum 0x5986450c, Offset: 0x4722
    // Size: 0xee, Type: dev
    function function_27f2ca27d747d0ea()
    {
        foreach ( name, room in level.ztron.bonusRooms )
        {
            ztron_debug::debugmsg( "<dev string:x318>" + name + "<dev string:x32d>" + room.type + "<dev string:x336>" + ( room.maxvisits ?? "<dev string:x344>" ) + "<dev string:x34e>" + ( room.minlevel ?? "<dev string:x35b>" ) + "<dev string:x35d>" + ( room.var_acecf1de8ec2250a ?? "<dev string:x36a>" ) );
        }
    }

#/
