// script_52c92112815cedb  (hash_052c92112815cedb.gscc) (size: 16513 Bytes / 0x4081 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a41f8c6 (1245837510)
// size ...... 16513 (0x4081)
// includes .. 22  (offset: 0x3d31)
// strings ... 42  (offset: 0x3de1)
// dev strs .. 6   (offset: 0x4039)
// exports ... 44  (offset: 0x26a1)
// cseg ...... 0x3e2 + 0x22bf (0x26a1)
// imports ... 134 (offset: 0x2d81)
// animtree1 . 0   (offset: 0x4081)
// animtree2 . 0   (offset: 0x4081)
#using script_10f6fed49001c470;
#using script_294e8d1ebcb1de03;
#using script_48a5b607db42e429;
#using script_73805a7d72edcbab;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;

#namespace namespace_9d7e01970b106799;

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x5
// Checksum 0x2ee4604e, Offset: 0x400
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"hash_735fc0fea76e8b53", [ #"activity_common", #"hash_a7c9bf1de28fd508" ], &function_538033a540e63c70, undefined );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x41207353, Offset: 0x43b
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_IRONCLAD_BUNKER_PHASE", &activity_type_init );
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0x6fbbf781, Offset: 0x456
// Size: 0x204
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_BUNKER_PHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_BUNKER_PHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_BUNKER_PHASE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_BUNKER_PHASE", 3, &function_d4acef179eb9f9b2 );
    level.elite_ironclad.bunker = { #structs:[] };
    
    foreach ( script_noteworthy in [ "cq_buystation", "cq_cache" ] )
    {
        foreach ( struct in utility::getstructarray( script_noteworthy, "script_noteworthy" ) )
        {
            if ( !isdefined( level.elite_ironclad.bunker.structs[ script_noteworthy ] ) )
            {
                level.elite_ironclad.bunker.structs[ script_noteworthy ] = [];
            }
            
            level.elite_ironclad.bunker.structs[ script_noteworthy ][ level.elite_ironclad.bunker.structs[ script_noteworthy ].size ] = struct;
        }
    }
    
    /#
        if ( getdvarint( @"hash_f9f928c78b3ef153", 0 ) )
        {
            level thread function_4f45bcac9a8c3376();
        }
        
        function_e604b819860705ae();
    #/
}

/#

    // Namespace namespace_9d7e01970b106799
    // Params 0, eflags: 0x4
    // Checksum 0xd599b922, Offset: 0x662
    // Size: 0x3c, Type: dev
    function private function_e604b819860705ae()
    {
        var_2ba69d88abe636ca = "<dev string:x24>";
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca );
        devgui::add_devgui_func( "<dev string:x70>", "<dev string:x8a>", &function_a36ecc5af9b525fc );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_9d7e01970b106799
    // Params 0, eflags: 0x4
    // Checksum 0x60eea942, Offset: 0x6a6
    // Size: 0x8a, Type: dev
    function private function_48a9174eeda2decd()
    {
        foreach ( activity_instance in activity_common::function_394486cf35d84dc8() )
        {
            if ( activity_instance_common::getactivitytype( activity_instance ) != "<dev string:xa4>" )
            {
                continue;
            }
            
            return activity_instance;
        }
        
        return;
    }

    // Namespace namespace_9d7e01970b106799
    // Params 0
    // Checksum 0x416e3634, Offset: 0x738
    // Size: 0x7d, Type: dev
    function function_a36ecc5af9b525fc()
    {
        host = gamelogic_mp::gethostplayer( 1 );
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        activity = function_48a9174eeda2decd();
        
        if ( !isdefined( activity ) || !isdefined( activity.bunker_hatch ) )
        {
            return;
        }
        
        var_b718a4324486dcc = getclosestpointonnavmesh( activity.bunker_hatch.origin );
        
        if ( !isdefined( var_b718a4324486dcc ) )
        {
            return;
        }
        
        host setorigin( var_b718a4324486dcc );
    }

#/

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0x43550d50, Offset: 0x7bd
// Size: 0x53
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( activity_instance );
    activity_instance.analytics = {};
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0x36a6757a, Offset: 0x818
// Size: 0x26d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_bunker" );
    level.elite_ironclad.team_info.state = 5;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    hud_util::showsplashtoteam( activity_instance.team, "elite_ironclad_console_start", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    computer = activity_instance get_bunker_computer();
    bunker_hatch = namespace_e14671bfc73f6500::function_160bda82ad64eb2d( computer.origin );
    
    if ( getdvarint( @"hash_a353af43e8b24574", 1 ) || getdvarint( @"hash_335ee4106d778c93", 1 ) )
    {
        thread namespace_e14671bfc73f6500::function_b7ac27ac5cb3126f( bunker_hatch.origin );
    }
    
    activity_instance.computer = computer;
    activity_instance.bunker_hatch = bunker_hatch;
    bunker_hatch function_d3d061ec1b1b1b85();
    activity_instance create_quest_circle( computer.origin );
    activity_instance function_9556e98f76b66365( computer.origin + ( 0, 0, 36 ) );
    activity_instance thread pause_gas_circle();
    activity_instance thread relocate_gas_circle( computer.origin );
    kiosk_instance = common_kiosk::function_27da31038bf50233( get_kiosk_spawn( computer.origin ) );
    common_kiosk::hideobjective( kiosk_instance );
    thread function_79469e158e26fb6e();
    
    foreach ( cache_spawn in get_cache_spawns( computer.origin ) )
    {
        common_cache::function_9bc018c1b8aad720( "br_elite_ironclad_bunker_cache", cache_spawn.origin, cache_spawn.angles, undefined, level.commonitem.var_f4a0cd0e44af4832 );
    }
    
    activity_instance.analytics.start_time = gettime();
    activity_instance thread function_664c8dc40839effe();
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x8b4398d9, Offset: 0xa8d
// Size: 0x61
function private function_664c8dc40839effe()
{
    self endon( #"ActivityEnd" );
    self endon( #"instance_destroyed" );
    level waittill( #"hash_442174b0f51c4742", unoid );
    self.analytics.hatch_opened_time = gettime();
    self.analytics.hatch_opened_player = unoid;
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x21a5940e, Offset: 0xaf6
// Size: 0x9a
function private function_79469e158e26fb6e()
{
    scriptable = get_bunker_computer();
    origin = scriptable.origin + ( 0, 0, -100 );
    var_51f93ffee496dc9 = spawnscriptable( "wz_sat_scriptable_ironclad_bunker_computer", origin, scriptable.angles );
    var_51f90ffee496730 = spawnscriptable( "wz_sat_scriptable_ironclad_bunker_computer", origin, scriptable.angles );
    waitframe();
    var_51f93ffee496dc9 setscriptablepartstate( "computer", "stream_screen_1" );
    var_51f90ffee496730 setscriptablepartstate( "computer", "stream_screen_2" );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0xba749f1a, Offset: 0xb98
// Size: 0x123
function private function_d3d061ec1b1b1b85()
{
    interact = interaction::register_interact( self.origin + ( 0, 0, 30 ), 100, &function_123366e738382e0c, &can_open_bunker );
    interact.bunker_hatch = self;
    self.interact = interact;
    interact setusefov( 180 );
    interact setusepriority( -2 );
    interact sethintdisplayrange( 500 );
    interact disableplayeruseforallplayers();
    
    foreach ( player in level.teamdata[ level.elite_ironclad.cq_team ][ "players" ] )
    {
        interact enableplayeruse( player );
    }
    
    /#
        if ( getdvarint( @"hash_598b9ca170274e0e", 0 ) == 1 )
        {
            interact thread debug_draw_interact( interact );
        }
    #/
}

// Namespace namespace_9d7e01970b106799
// Params 2, eflags: 0x4
// Checksum 0x591d99bc, Offset: 0xcc3
// Size: 0xfe
function private can_open_bunker( usable, player )
{
    if ( player.team != level.elite_ironclad.cq_team )
    {
        return { #interactable:0, #string:&"", #type:"HINT_NODISPLAY" };
    }
    
    var_aa428fed24d02e9b = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
    
    if ( var_aa428fed24d02e9b.name == %"hash_18bbe4ece9b75940" )
    {
        return { #interactable:1, #string:&"hash_62037841571b0671", #type:"HINT_BUTTON" };
    }
    
    return { #interactable:0, #string:&"hash_51e5a7a01f196023", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x8454b8c3, Offset: 0xdca
// Size: 0xee
function private function_123366e738382e0c( player )
{
    var_aa428fed24d02e9b = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
    
    if ( var_aa428fed24d02e9b.name == %"hash_18bbe4ece9b75940" )
    {
        namespace_e14671bfc73f6500::function_b823cb475a92c33c( self.bunker_hatch.origin );
        namespace_e14671bfc73f6500::function_57187b3d0e82cd9c( self.bunker_hatch, 2 );
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_bunker_step_start", #scope:1 } );
        level.elite_ironclad.team_info.state = 6;
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
        self disableplayeruseforallplayers();
        level notify( #"hash_442174b0f51c4742", player getplayerunoid() );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0x536e409b, Offset: 0xec0
// Size: 0x36
function activity_ended()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance.analytics.ended_time = gettime();
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0x61a26973, Offset: 0xefe
// Size: 0x177
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance.bunker_hatch.interact delete();
    activity_instance.interact delete();
    activity_instance game_utility::questcircle_delete();
    a = activity_instance.analytics;
    origin = activity_instance_common::function_776ee11e7acc64a5( activity_instance );
    dlog_recordevent( "dlog_event_br_elite_ironclad_bunker", [ "start_time", a.start_time ?? 0, "hatch_opened_time", a.hatch_opened_time ?? 0, "drive_inserted_time", a.drive_inserted_time ?? 0, "ended_time", a.ended_time ?? 0, "x", origin[ 0 ], "y", origin[ 1 ], "z", origin[ 2 ], "hatch_opened_player", a.hatch_opened_player ?? 0, "drive_inserted_player", a.drive_inserted_player ?? 0, "ended_player", a.ended_player ?? 0 ] );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x688360b9, Offset: 0x107d
// Size: 0x52
function private get_bunker_computer()
{
    activity_instance = self;
    computers = getentitylessscriptablearray( "cq_computer", #script_noteworthy );
    origin = activity_instance_common::function_776ee11e7acc64a5( activity_instance );
    computer = utility::get_closest_filtered( origin, computers );
    return computer;
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x2ab3118c, Offset: 0x10d8
// Size: 0x1f
function private get_bunker_origin()
{
    scriptable = get_bunker_computer();
    return scriptable.origin;
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x494504d1, Offset: 0x1100
// Size: 0x24
function private get_room_origin()
{
    var_b5796ba09bdd5562 = ( 49.25, -338.5, -337.5 );
    return get_bunker_origin() - var_b5796ba09bdd5562;
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x75ad53d2, Offset: 0x112d
// Size: 0xe7
function private get_kiosk_spawn( bunker_origin )
{
    foreach ( struct in level.elite_ironclad.bunker.structs[ "cq_buystation" ] )
    {
        if ( distance2dsquared( struct.origin, bunker_origin ) <= 1000000 )
        {
            return struct;
        }
    }
    
    return { #angles:( 0, 0, 0 ), #origin:( -16, -160, -336 ) + get_room_origin() };
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x38a089f0, Offset: 0x121d
// Size: 0x148
function private get_cache_spawns( bunker_origin )
{
    cache_spawns = [];
    
    foreach ( struct in level.elite_ironclad.bunker.structs[ "cq_cache" ] )
    {
        if ( distance2dsquared( struct.origin, bunker_origin ) <= 1000000 )
        {
            cache_spawns[ cache_spawns.size ] = struct;
        }
    }
    
    if ( cache_spawns.size )
    {
        return cache_spawns;
    }
    
    var_89ca1e6b98bafeb4 = get_room_origin();
    return [ { #angles:( 0, 180, 0 ), #origin:( 40, 72, -336 ) + var_89ca1e6b98bafeb4 }, { #angles:( 0, 90, 0 ), #origin:( 120, 0, -336 ) + var_89ca1e6b98bafeb4 } ];
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x3b0d1edd, Offset: 0x136d
// Size: 0x15a
function private relocate_gas_circle( origin )
{
    activity = self;
    level endon( #"game_ended" );
    relocatedcircleradius = utility::function_edc4cc03e9e60b3e( @"hash_f447e56f0bba1282", 25000, self.var_332f929de1894b2b.var_8bb1212dac2e5612 );
    
    if ( getdvarint( @"hash_2e3efa34bacc9b3b", 0 ) == 1 )
    {
        function_62b6208065ec5d98( relocatedcircleradius );
    }
    else if ( getdvarint( @"hash_c46fd50f74910053", 1 ) == 1 )
    {
        function_f2297c4e992f95de( relocatedcircleradius );
    }
    
    if ( getdvarint( @"hash_461a6706bfc596bc", 1 ) == 1 )
    {
        var_29efba2c60f03c7a = utility::function_edc4cc03e9e60b3e( @"hash_eef3da452c3bfe5a", 300, self.var_332f929de1894b2b.var_52a33f78726c8c2d );
        activity thread adjust_circle_close_time( var_29efba2c60f03c7a );
    }
    
    if ( getdvarint( @"hash_8aae0f5df1a59b1b", 1 ) == 1 )
    {
        var_9376c48f583b5e58 = utility::function_edc4cc03e9e60b3e( @"hash_797addb6e88dca74", 2000, self.var_332f929de1894b2b.var_b0b2341c12c43a5c );
        origin += math::random_vector_2d() * randomfloatrange( 0, var_9376c48f583b5e58 );
    }
    
    level.br_circle.var_2e11f4ecf29d6512 = &function_161291fd0eb6aab3;
    level thread br_circle::relocatecircles( origin );
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x9cd0aadb, Offset: 0x14cf
// Size: 0x1f
function private function_161291fd0eb6aab3( circleindex )
{
    return [ 0, 0 ];
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0xa581f0d7, Offset: 0x14f7
// Size: 0x12c
function private adjust_circle_close_time( var_29efba2c60f03c7a )
{
    activity = self;
    activity endon( #"activity_failed" );
    level endon( #"game_ended" );
    level waittill( #"calc_circle_centers" );
    var_3d77a543be283bd9 = level.br_circle.circleindex + 1;
    circledistance = distance2d( level.br_level.br_circlecenters[ var_3d77a543be283bd9 ], level.br_level.br_circlecenters[ var_3d77a543be283bd9 + 1 ] );
    radiusdiff = level.br_level.br_circleradii[ var_3d77a543be283bd9 ] - level.br_level.br_circleradii[ var_3d77a543be283bd9 + 1 ];
    var_90d12cf3c2917c38 = circledistance + radiusdiff;
    var_f845e35058e35154 = var_90d12cf3c2917c38 / level.br_level.br_circleclosetimes[ var_3d77a543be283bd9 ];
    
    if ( var_f845e35058e35154 > var_29efba2c60f03c7a )
    {
        level.br_level.br_circleclosetimes[ var_3d77a543be283bd9 ] = int( var_90d12cf3c2917c38 / var_29efba2c60f03c7a );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 1
// Checksum 0x12122f06, Offset: 0x162b
// Size: 0xc1
function function_62b6208065ec5d98( relocatedcircleradius )
{
    var_f9a7e0376f46c876 = getdvarfloat( @"hash_e5f12241f3e05666", 0.5 );
    var_e608edf69e913c66 = level.br_circle.circleindex + 2;
    
    for ( i = var_e608edf69e913c66; i < level.br_level.br_circleradii.size ; i++ )
    {
        level.br_level.br_circleradii[ i ] = relocatedcircleradius;
        relocatedcircleradius *= var_f9a7e0376f46c876;
    }
    
    level.br_level.br_circleradii[ level.br_level.br_circleradii.size - 1 ] = 0;
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0x7d1369ac, Offset: 0x16f4
// Size: 0x11d
function private function_f2297c4e992f95de( relocatedcircleradius )
{
    var_f9a7e0376f46c876 = getdvarfloat( @"hash_b4290488b3f4a07", 0.5 );
    var_e608edf69e913c66 = level.br_circle.circleindex + 2;
    lastcircleindex = level.br_level.br_circleradii.size - 1 - level.br_level.br_movingcirclecount;
    lastcircleradii = level.br_level.br_circleradii[ lastcircleindex ];
    
    if ( var_e608edf69e913c66 >= lastcircleindex )
    {
        level.br_circle.var_6c75683522d175ff = &function_161291fd0eb6aab3;
        function_62b6208065ec5d98( relocatedcircleradius );
        return;
    }
    
    for ( i = var_e608edf69e913c66; i < lastcircleindex ; i++ )
    {
        level.br_level.br_circleradii[ i ] = int( relocatedcircleradius );
        
        if ( relocatedcircleradius * var_f9a7e0376f46c876 > lastcircleradii )
        {
            relocatedcircleradius *= var_f9a7e0376f46c876;
            continue;
        }
        
        relocatedcircleradius -= ( relocatedcircleradius - lastcircleradii ) * var_f9a7e0376f46c876;
    }
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x61866505, Offset: 0x1819
// Size: 0x68
function private pause_gas_circle()
{
    activity = self;
    activity endon( #"activity_failed" );
    level endon( #"game_ended" );
    
    if ( !level.circleclosing )
    {
        level waittill( #"br_circle_started" );
    }
    
    level waittill( #"br_circle_started" );
    setdvar( @"hash_47d8674c992e098", 1 );
    br_circle::pausecircle( 1 );
}

// Namespace namespace_9d7e01970b106799
// Params 1
// Checksum 0xf8a6de, Offset: 0x1889
// Size: 0x9d
function create_quest_circle( origin )
{
    game_utility::questcircle_create( "bunker_mystery_circle", origin, 500 );
    game_utility::questcircle_hidefromall();
    
    foreach ( player in self.playerparticipants )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 1
// Checksum 0x1b6cb21a, Offset: 0x192e
// Size: 0xf3
function function_9556e98f76b66365( origin )
{
    interact = interaction::register_interact( origin, 60, &function_ae767d7ac0111355, &function_786e517e29503b71 );
    interact setcursorhint( "HINT_BUTTON" );
    interact sethinticon( "ui_map_icon_elite_crown" );
    interact disableplayeruseforallplayers();
    
    foreach ( player in level.teamdata[ level.elite_ironclad.cq_team ][ "players" ] )
    {
        interact enableplayeruse( player );
    }
    
    interact.activity = self;
    self.interact = interact;
}

// Namespace namespace_9d7e01970b106799
// Params 1
// Checksum 0x3c0e8313, Offset: 0x1a29
// Size: 0x46
function function_ae767d7ac0111355( player )
{
    interact = self;
    
    if ( !interact.hasharddrive )
    {
        interact function_5fc199db625223a8( player );
        return;
    }
    
    interact function_94b4c526ee45f780( player );
    interact stoploopsound();
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0xcb4188e4, Offset: 0x1a77
// Size: 0x201
function private function_5fc199db625223a8( player )
{
    if ( !player function_dbb369258e8a5af3() )
    {
        return;
    }
    
    interact = self;
    activity = interact.activity;
    computer = activity.computer;
    players = activity.playerparticipants;
    
    foreach ( participant in players )
    {
        participant.plotarmor = undefined;
    }
    
    player thread function_3ad7bf3150980aa8();
    player consume_hard_drive();
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_da5de86e82247545( player, %"hash_18bbe4ece9b75940", 0 );
    level.elite_ironclad.team_info.state = 7;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    interact makeunusable();
    computer set_computer_state( 1 );
    activity.analytics.drive_inserted_time = gettime();
    activity.analytics.drive_inserted_player = player getplayerunoid();
    activity function_b1493b9f53392e15();
    activity function_1b4714e1899745ad();
    wait 1;
    level.elite_ironclad.team_info.state = 8;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    interact makeusable();
    interact.hasharddrive = 1;
    interact playloopsound( "evt_ironclad_bunker_console_ready_waiting" );
}

// Namespace namespace_9d7e01970b106799
// Params 1, eflags: 0x4
// Checksum 0xb216a240, Offset: 0x1c80
// Size: 0xef
function private function_94b4c526ee45f780( player )
{
    interact = self;
    activity = interact.activity;
    computer = activity.computer;
    interact makeunusable();
    computer set_computer_state( 2 );
    activity.analytics.ended_player = player getplayerunoid();
    level.elite_ironclad.team_info.state = 9;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    activity spawn_truck();
    hud_util::showsplashtoallexceptteam( activity.team, activity.var_332f929de1894b2b.var_9f792ec4605db541, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    activity_instance_common::endactivity( activity, 1 );
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0xfaef2caa, Offset: 0x1d77
// Size: 0x4f
function function_3ad7bf3150980aa8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    weapobj = makeweapon( "saw_ges_plyr_hard_drive" );
    self giveandfireoffhand( weapobj );
    wait 1.5;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x61ebd447, Offset: 0x1dce
// Size: 0x88, Type: bool
function private function_dbb369258e8a5af3()
{
    player = self;
    
    if ( player common_inventory::function_383caa18a4383073( 139800 ) )
    {
        return true;
    }
    
    itemtype = common_item::function_9deb822f286163b1( 139800 );
    var_8fb8e1fb220cca48 = player common_item::function_c4c43ebb7aa636dc( itemtype, spawnstruct(), 0 );
    
    if ( var_8fb8e1fb220cca48 && var_8fb8e1fb220cca48.name )
    {
        currentlootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        return ( currentlootid == 139800 );
    }
    
    return false;
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x46eb2be4, Offset: 0x1e5f
// Size: 0x5c
function private consume_hard_drive()
{
    player = self;
    
    if ( player common_inventory::function_383caa18a4383073( 139800 ) )
    {
        player common_inventory::function_d1993196b2bcf62d( 139800, 1 );
        return;
    }
    
    itemtype = common_item::function_9deb822f286163b1( 139800 );
    player common_item::function_bbba261e6fdc7e52( itemtype, { #count:1 }, 0 );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0xee041943, Offset: 0x1ec3
// Size: 0xc8
function private function_b1493b9f53392e15()
{
    foreach ( player in level.players )
    {
        game_utility::questcircle_showtoplayer( player );
    }
    
    hud_util::showsplashtoallexceptteam( self.team, self.var_332f929de1894b2b.var_91b16c68d0499ae3, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_bunker_enemy_step_start", #scope:2 } );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0xba693899, Offset: 0x1f93
// Size: 0x208
function private function_1b4714e1899745ad()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity.decodetime = 0;
    decodetime = utility::function_48f723fdc612ec65( @"hash_33c2bdce6eb3c140", 20, activity.var_332f929de1894b2b.decodetime );
    
    while ( true )
    {
        activity function_8087c3502069a640();
        activity.var_4a62b0f6788ba18e = activity.decodetime / 1000 / decodetime;
        players = activity.playerparticipants;
        
        foreach ( player in players )
        {
            player setclientomnvar( "ui_securing_progress", activity.var_4a62b0f6788ba18e );
        }
        
        waitframe();
        activity.decodetime += level.frameduration;
        
        if ( activity.decodetime >= decodetime * 1000 )
        {
            break;
        }
    }
    
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_bunker_secured", #scope:1 } );
    
    foreach ( player in activity.playerparticipants )
    {
        player setclientomnvar( "ui_securing", 0 );
        player setclientomnvar( "ui_securing_progress", 0 );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0x304f9d69, Offset: 0x21a3
// Size: 0xae
function private function_8087c3502069a640()
{
    foreach ( player in self.playerparticipants )
    {
        var_3fa54b6f21d04b52 = 1;
        var_3fa54b6f21d04b52 &= player::isreallyalive( player );
        
        if ( var_3fa54b6f21d04b52 )
        {
            player setclientomnvar( "ui_securing", 27 );
            continue;
        }
        
        player setclientomnvar( "ui_securing", 0 );
    }
}

// Namespace namespace_9d7e01970b106799
// Params 1
// Checksum 0xd91ed073, Offset: 0x2259
// Size: 0xbd
function set_computer_state( state )
{
    computer = self;
    computer.state = state % 4;
    
    switch ( computer.state )
    {
        case 0:
            computer setscriptablepartstate( "computer", "bootup" );
            break;
        case 1:
            computer setscriptablepartstate( "computer", "ready" );
            break;
        case 2:
            computer setscriptablepartstate( "computer", "active" );
            break;
        case 3:
            computer setscriptablepartstate( "computer", "inactive" );
            break;
    }
}

// Namespace namespace_9d7e01970b106799
// Params 0
// Checksum 0xb117ef82, Offset: 0x231e
// Size: 0x3e
function spawn_truck()
{
    activity = self;
    dropdata = activity get_truck_drop_data();
    elite_ironclad_truck::spawn_launcher( dropdata.origin, dropdata.angles );
}

// Namespace namespace_9d7e01970b106799
// Params 0, eflags: 0x4
// Checksum 0xe3f7bba3, Offset: 0x2364
// Size: 0x72
function private get_truck_drop_data()
{
    activity = self;
    computerorigin = activity.computer.origin;
    truck_path = elite_ironclad_truck::function_4e3cabfb53aa6261( computerorigin );
    spawn_data = { #angles:vectortoangles( vectornormalize( truck_path[ 1 ] - truck_path[ 0 ] ) ), #origin:truck_path[ 0 ] };
    return spawn_data;
}

// Namespace namespace_9d7e01970b106799
// Params 2
// Checksum 0xbdd1cb5d, Offset: 0x23df
// Size: 0xec
function function_786e517e29503b71( interact, player )
{
    if ( player.team != level.elite_ironclad.cq_team )
    {
        return { #interactable:0, #string:&"", #type:"HINT_NODISPLAY" };
    }
    
    if ( interact.hasharddrive )
    {
        return { #string:&"hash_291c2e8db99c8ea9", #type:"HINT_BUTTON" };
    }
    
    if ( !player function_dbb369258e8a5af3() )
    {
        return { #interactable:0, #string:&"hash_51e5a7a01f196023", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"hash_7c8f90193bc8c576", #type:"HINT_BUTTON" };
}

/#

    // Namespace namespace_9d7e01970b106799
    // Params 0, eflags: 0x4
    // Checksum 0xb78e8c30, Offset: 0x24d4
    // Size: 0xe3, Type: dev
    function private function_4f45bcac9a8c3376()
    {
        level endon( #"game_ended" );
        computers = getentitylessscriptablearray( "<dev string:xc6>", #script_noteworthy );
        
        while ( true )
        {
            waitframe();
            
            foreach ( computer in computers )
            {
                print3d( computer.origin + ( 0, 0, 500 ), "<dev string:xd2>" + computer.targetname, ( 0, 0.75, 0 ), 1, 50, 1, 1 );
            }
        }
    }

    // Namespace namespace_9d7e01970b106799
    // Params 1, eflags: 0x4
    // Checksum 0x8b84bb7d, Offset: 0x25bf
    // Size: 0xe2, Type: dev
    function private debug_draw_interact( interact )
    {
        if ( !isdefined( interact ) )
        {
            return;
        }
        
        drawframes = 15;
        color = ( 0, 1, 0 );
        
        while ( isdefined( interact ) )
        {
            origin = interact.origin;
            cylinder( origin, origin + ( 0, 0, interact.interact_use_range ), interact.interact_use_range, color, 0, drawframes );
            forward = anglestoforward( interact.angles );
            arrowend = origin + forward * interact.interact_use_range * 1.5;
            line( origin, arrowend, ( 1, 0, 0 ), 1, 0, drawframes );
            wait level.framedurationseconds * drawframes;
        }
    }

#/
