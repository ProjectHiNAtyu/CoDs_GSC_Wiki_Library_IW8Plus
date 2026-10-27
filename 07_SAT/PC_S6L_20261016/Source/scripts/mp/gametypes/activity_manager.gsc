// scripts\mp\gametypes\activity_manager.gsc  (hash_03314add7998ab13.gscc) (size: 41064 Bytes / 0xa068 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c81c6f4 (2088879860)
// size ...... 41064 (0xa068)
// includes .. 48  (offset: 0x9ad4)
// strings ... 39  (offset: 0x9c54)
// dev strs .. 32  (offset: 0x9edc)
// exports ... 82  (offset: 0x70c0)
// cseg ...... 0x45b + 0x6c65 (0x70c0)
// imports ... 229 (offset: 0x7d90)
// animtree1 . 0   (offset: 0xa068)
// animtree2 . 0   (offset: 0xa068)
#using script_12443be69148a4fa;
#using script_140ac362d2879191;
#using script_1924b557dd30ebee;
#using script_1df45ceb0bf3f253;
#using script_1f9db1ea1ffd6741;
#using script_299b5dbadaf2b146;
#using script_3becc4e343ab1c2a;
#using script_45583617ae826370;
#using script_4cf6e8a5c419dee5;
#using script_599653855a4317f1;
#using script_5d96636dc9c4a988;
#using script_68fc38d757ac68d3;
#using script_6b2366be043a898a;
#using script_6c9403ef6e857f6e;
#using script_7439d62b3781dc9f;
#using script_75e52fe033895595;
#using script_770669934978bef0;
#using script_79e727c8633026e2;
#using script_7e92d5dd2cf1bc89;
#using script_844f2da395ef1a3;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_task_person_of_interest;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\poi;
#using scripts\mp\talking_gun;
#using scripts\mp\team_assimilation;
#using scripts\mp\teams;
#using scripts\mp\telemetry_mp;

#namespace activity_manager;

// Namespace activity_manager
// Params 0
// Checksum 0x619f681a, Offset: 0x479
// Size: 0x2dd
function function_40cd457dbeb09b94()
{
    lui_game_event_aggregator::registeronluieventcallback( &function_d0e6047d9a07b7fb );
    
    if ( level.autoassignfirstquest == 1 || getdvarint( @"hash_85b85aad9f4aefea", 1 ) == 0 )
    {
        return;
    }
    
    if ( !level.var_372917288315121c )
    {
        while ( !( isdefined( level.struct_class_names ) && isdefined( level.aibudgets ) ) || function_7c7f41d3fd5028a5( "everybody" ) <= 0 || !isdefined( level.lockedvolumes ) || !level.fortressstruct.var_6dc29464d93d3edd || !isdefined( level.startpoints ) )
        {
            waitframe();
        }
    }
    else if ( level.var_372917288315121c )
    {
        while ( !( isdefined( level.fortressstruct ) && isdefined( level.fortressstruct.chosenfortresses ) ) )
        {
            waitframe();
        }
    }
    
    level.var_f9ba6d6273c5cc67 = spawnstruct();
    level.var_f9ba6d6273c5cc67.teamlist = [];
    level.var_f9ba6d6273c5cc67.activities = [];
    level.var_e7d6fcb6a0103940 = [];
    
    foreach ( node in utility::getstructarray( "dmz_missionObjectiveUniversal", "script_noteworthy" ) )
    {
        level.var_e7d6fcb6a0103940[ level.var_e7d6fcb6a0103940.size ] = node;
    }
    
    level.var_f9ba6d6273c5cc67.var_921dda87ef83581c = getscriptbundle( getgametypescriptbundle().dmzactivities );
    
    if ( !isdefined( level.var_f9ba6d6273c5cc67.var_921dda87ef83581c ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    level.var_f9ba6d6273c5cc67.var_ca2624de39435df5 = getdvarint( @"hash_10fcfffe932c9bd5", 1 );
    level.var_98b7a1da8764e395 = getdvarint( @"hash_a598966b6e53fde8", 1 );
    level.var_185eda8a5a2d1fc7 = getdvarint( @"hash_51ca2e83111f7340", 0 );
    level.var_2a22b67ae4fc308e = getdvarint( @"hash_a17f8c87a9ffefa6", 1 );
    level.var_53805a466ab65049 = getdvarint( @"hash_f173806bc718ddd1", 0 );
    level.activityautoassign = getdvarint( @"scr_activity_autoassign", 0 );
    
    if ( level.var_372917288315121c )
    {
        level.activityautoassign = 0;
    }
    
    level thread function_35d9d389f8866736();
    level thread function_bd24be4a5abfb781();
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &activity_changeteams );
    }
    
    /#
        level thread activity_debugdvars();
    #/
}

// Namespace activity_manager
// Params 6
// Checksum 0x7b0531ce, Offset: 0x75e
// Size: 0x43
function function_cc01b12c4fc2d248( instance, part, state, player, bautouse, usestring )
{
    thread function_89e4869128e7a19a( instance, player );
}

// Namespace activity_manager
// Params 1
// Checksum 0xbdb7b1, Offset: 0x7a9
// Size: 0x76
function onteameliminated( team )
{
    if ( function_52cb56af0d85e094( team ) )
    {
        activity = function_25e2a500662e347( team );
        
        if ( isdefined( activity ) )
        {
            telemetry_mp::function_390c5cfc04cca2d9( activity, "fail", team );
            activity.tasks[ 0 ] function_5abb1c2f65633a8f( team );
        }
    }
    
    teamcount = teams::getactiveteamcount();
    
    if ( teamcount == 1 )
    {
        namespace_76299fb251d3aacd::function_424225e6612178eb();
    }
}

/#

    // Namespace activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0x786d6acc, Offset: 0x827
    // Size: 0x89e, Type: dev
    function private activity_debugdvars()
    {
        setdvar( @"hash_38667c3d89e33b7b", 0 );
        setdvar( @"hash_b141c2b278951739", 0 );
        setdvar( @"hash_d53193725af8249a", 0 );
        setdvar( @"hash_49015467bf99bb3b", 0 );
        
        while ( true )
        {
            waitframe();
            
            if ( isdefined( level.var_f9ba6d6273c5cc67.spawndata ) )
            {
                foreach ( name, spawndata in level.var_f9ba6d6273c5cc67.spawndata )
                {
                    if ( getdvarint( hashcat( @"hash_31a2bba2a258c4a2", name, "<dev string:x43>" ), 0 ) == 1 || getdvarint( hashcat( @"hash_31a2bba2a258c4a2", name, "<dev string:x4d>" ), 0 ) == 1 )
                    {
                        tobot = getdvarint( hashcat( @"hash_31a2bba2a258c4a2", name, "<dev string:x4d>" ), 0 ) == 1;
                        setdvar( hashcat( @"hash_31a2bba2a258c4a2", name, "<dev string:x43>" ), 0 );
                        setdvar( hashcat( @"hash_31a2bba2a258c4a2", name, "<dev string:x4d>" ), 0 );
                        activity = undefined;
                        
                        foreach ( act in level.var_f9ba6d6273c5cc67.activities )
                        {
                            if ( name == act.name )
                            {
                                activity = act;
                                break;
                            }
                        }
                        
                        if ( !isdefined( activity ) )
                        {
                            node = undefined;
                            
                            foreach ( testnode in spawndata.nodes )
                            {
                                if ( function_600a7e9e3b0623bb( testnode.origin, spawndata.exclusionradius, spawndata.var_e932a99b1cb1d5f2, name ) )
                                {
                                    node = testnode;
                                    break;
                                }
                            }
                            
                            if ( isdefined( node ) )
                            {
                                activity = function_2fc499a089d80b10( node, name, spawndata, 1 );
                            }
                            else
                            {
                                assert( "<dev string:x5b>" + name + "<dev string:x78>" );
                            }
                        }
                        
                        team = level.players[ 0 ].team;
                        
                        if ( tobot )
                        {
                            foreach ( player in level.players )
                            {
                                if ( isbot( player ) )
                                {
                                    team = player.team;
                                    break;
                                }
                            }
                        }
                        
                        activity activity_assign( team, undefined, level.players[ 0 ] );
                    }
                }
                
                if ( getdvarint( @"hash_ef7e3cb3eb287471", 0 ) )
                {
                    setdvar( @"hash_ef7e3cb3eb287471", 0 );
                    player = level.players[ 0 ];
                    
                    if ( function_52cb56af0d85e094( player.team ) )
                    {
                        activity = function_25e2a500662e347( player.team );
                        activity.tasks[ 0 ] function_5abb1c2f65633a8f( player.team );
                    }
                }
                
                if ( getdvarint( @"hash_e1cbc0efccbb05da", 0 ) )
                {
                    printtoscreen2d( 50, 50, "<dev string:x9a>" );
                    y = 50;
                    total = 0;
                    
                    foreach ( name, spawndata in level.var_f9ba6d6273c5cc67.spawndata )
                    {
                        total += spawndata.spawned;
                        text = name + "<dev string:xa9>" + spawndata.spawned;
                        y += 20;
                        printtoscreen2d( 50, y, text );
                    }
                    
                    y += 20;
                    printtoscreen2d( 50, y, "<dev string:xb2>" + total );
                }
            }
            
            if ( getdvarint( @"hash_b141c2b278951739", 0 ) == 1 )
            {
                taskindex = level.var_f9ba6d6273c5cc67.activities[ 0 ].teams[ level.players[ 0 ].team ];
                task = level.var_f9ba6d6273c5cc67.activities[ 0 ].tasks[ taskindex ];
                task activity_taskended();
                setdvar( @"hash_b141c2b278951739", 0 );
            }
            
            if ( getdvarint( @"hash_38667c3d89e33b7b", 0 ) == 1 )
            {
                activity = function_a6448d048cf432e1( level.players[ 0 ] );
                activity activity_assign( level.players[ 0 ].team );
                setdvar( @"hash_38667c3d89e33b7b", 0 );
            }
            
            if ( getdvarint( @"hash_d53193725af8249a" ) )
            {
                setdvar( @"hash_d53193725af8249a", 0 );
                spawnpoint = level.players[ 0 ];
                activitystarter = spawnscriptable( "<dev string:xba>" + "<dev string:xd3>", spawnpoint.origin, spawnpoint.angles );
                activitystarter function_a4194904aa550aab();
                activitystarter.var_3d8d29dbd1993bc5 = randomint( level.var_f9ba6d6273c5cc67.var_921dda87ef83581c.activities.size );
                activitystarter.var_5466cf6a45c64069 = randomint( 100 ) + 1;
                activitystarter.poiindex = randomint( 8 );
                
                if ( !isdefined( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 ) )
                {
                    level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = [];
                }
                
                prevsize = level.var_f9ba6d6273c5cc67.var_9433e6119f67c877.size;
                level.var_f9ba6d6273c5cc67.var_9433e6119f67c877[ level.var_f9ba6d6273c5cc67.var_9433e6119f67c877.size ] = activitystarter;
                
                if ( prevsize == 0 )
                {
                    level thread function_bd24be4a5abfb781();
                }
            }
            
            if ( getdvarint( @"hash_2039b0d4553f1be2", 0 ) )
            {
                setdvar( @"hash_2039b0d4553f1be2", 0 );
                
                if ( !isdefined( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 ) )
                {
                    level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = [];
                }
                
                foreach ( activitystarter in level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 )
                {
                    activitystarter function_2a0e4909a5f9b6a4();
                }
            }
            
            if ( getdvarint( @"hash_49015467bf99bb3b", 0 ) == 1 )
            {
                setdvar( @"hash_49015467bf99bb3b", 0 );
                node = spawnstruct();
                node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 200;
                node.angles = level.players[ 0 ].angles;
                dmz_safes::function_7bc9699baa708b2c( node );
            }
        }
    }

#/

// Namespace activity_manager
// Params 3
// Checksum 0xe8bec176, Offset: 0x10cd
// Size: 0x56
function function_f61a1f535aab4194( data, createfunc, nodes )
{
    assert( isdefined( data ) && isdefined( createfunc ) && isdefined( nodes ), "<dev string:xda>" );
    data.createfunc = createfunc;
    data.nodes = nodes;
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0xc0e3fffe, Offset: 0x112b
// Size: 0x737
function private activity_getspawndata()
{
    spawndata = [];
    
    /#
        debug = getdvarint( @"hash_4ca9133f642d177f", 0 ) == 1;
    #/
    
    startpoints = [];
    
    foreach ( set in level.startpoints )
    {
        if ( isdefined( set.points ) )
        {
            foreach ( point in set.points )
            {
                if ( isdefined( point.origin ) )
                {
                    startpoints[ startpoints.size ] = point.origin;
                }
            }
        }
        
        if ( isdefined( set.origin ) )
        {
            startpoints[ startpoints.size ] = set.origin;
        }
    }
    
    numrows = level.var_f9ba6d6273c5cc67.var_921dda87ef83581c.activities.size;
    
    for ( row = 0; row < numrows ; row++ )
    {
        var_353201177ee9ec05 = getscriptbundle( level.var_f9ba6d6273c5cc67.var_921dda87ef83581c.activities[ row ].activity );
        enabled = int( var_353201177ee9ec05.enabled );
        name = var_353201177ee9ec05.name;
        function_887ae09e82d10e1f( name, row );
        enabledoverride = getdvarint( hashcat( @"hash_1b5fb36050170b0f", name, "_enabled" ), -1 );
        
        if ( enabledoverride != -1 )
        {
            enabled = enabledoverride;
        }
        
        if ( !enabled )
        {
            continue;
        }
        
        data = spawnstruct();
        data.index = row;
        data.type = var_353201177ee9ec05.type;
        data.cashreward = int( var_353201177ee9ec05.cashreward );
        data.difficulty = int( var_353201177ee9ec05.difficulty );
        data.priority = float( var_353201177ee9ec05.spawningpriority );
        data.exclusionradius = float( var_353201177ee9ec05.exclusionradius );
        data.var_e932a99b1cb1d5f2 = float( var_353201177ee9ec05.var_e932a99b1cb1d5f2 );
        data.minspawncount = int( var_353201177ee9ec05.minspawncount );
        data.maxspawncount = int( var_353201177ee9ec05.maxspawncount );
        data.var_7553b36ae672a0b6 = float( var_353201177ee9ec05.var_7553b36ae672a0b6 );
        data.var_ed0de95c3396b1f1 = float( var_353201177ee9ec05.var_ed0de95c3396b1f1 );
        playerspawnexclusion = int( var_353201177ee9ec05.playerspawnexclusion );
        
        if ( playerspawnexclusion > 0 )
        {
            foreach ( startpoint in startpoints )
            {
                function_55ff49e4c914388d( startpoint, playerspawnexclusion, name, 1 );
                
                /#
                    if ( debug )
                    {
                        utility::draw_circle( startpoint + ( 0, 0, 800 ), playerspawnexclusion, ( 0, 1, 1 ), 1, 0, 20000 );
                    }
                #/
            }
        }
        
        tospawn = getdvarint( hashcat( @"hash_1b5fb36050170b0f", name, "_numberToSpawn" ), -1 );
        
        if ( tospawn != -1 )
        {
            data.minspawncount = tospawn;
            data.maxspawncount = tospawn;
        }
        
        assert( data.minspawncount <= data.maxspawncount, "<dev string:x10b>" + name + "<dev string:x12d>" );
        
        switch ( name )
        {
            case #"hash_f4a9126c03d3385b":
                namespace_521b355ce75f6eac::dmztask_getspawndata( data );
                break;
            case #"hash_194f31f722d1fa09":
                namespace_3ea8ef47cd7b240c::dmztask_getspawndata( data );
                break;
            case #"hash_e91729d4ef79ca26":
                namespace_4c5dd9edb2d6e4a8::dmztask_getspawndata( data );
                break;
            case #"hash_75b6db03edb1e84e":
                namespace_9db1e12416591c99::dmztask_getspawndata( data );
                break;
            case #"hash_e9d9fcb8daba8602":
                namespace_1ff0dda307309968::dmztask_getspawndata( data );
                break;
            case #"hash_82ea0e6e4f123b62":
                namespace_5ab652de57e3c043::dmztask_getspawndata( data );
                break;
            case #"hash_514d922eb8aed0b1":
                break;
            case #"hash_8fe6af6c550e39bc":
                namespace_137eb3a00b0ea8c6::dmztask_getspawndata( data );
                break;
            case #"hash_cf3abe09f0094696":
                namespace_996bfb64308a48f2::dmztask_getspawndata( data );
                break;
            case #"hash_e0b82e0f064c17d6":
                namespace_87e5a35991b973ad::dmztask_getspawndata( data );
                break;
            case #"hash_9682e089e580b4b8":
                namespace_a7cd3da1542a2432::dmztask_getspawndata( data );
                break;
            case #"hash_1e754eb11fa62651":
                namespace_60341451ae3e5462::dmztask_getspawndata( data );
                break;
            case #"hash_9db32d30f2603c35":
                namespace_b0d5e7f43c6af238::dmztask_getspawndata( data );
                break;
            case #"hash_37bb23543c319104":
                namespace_76299fb251d3aacd::dmztask_getspawndata( data );
                break;
            case #"hash_be386dc37be6968e":
                namespace_7101146850c37273::dmztask_getspawndata( data );
                break;
            case #"hash_4f62da1c4ed6f790":
                namespace_ddf564e165b3abd3::dmztask_getspawndata( data );
                break;
            case #"hash_218ddcea32fa5fbc":
                namespace_84d989e8789e6a05::dmztask_getspawndata( data );
                break;
            case #"hash_5c317bf7b4be6e08":
                break;
            case #"hash_88570f89de3f4680":
                namespace_1958d9cb901e3991::dmztask_getspawndata( data );
                break;
            default:
                assertmsg( "<dev string:x146>" + name );
                break;
        }
        
        data.tospawn = randomintrange( data.minspawncount, data.maxspawncount + 1 );
        
        if ( !isarray( data.nodes ) || data.nodes.size == 0 || data.tospawn <= 0 )
        {
            continue;
        }
        
        data.spawned = 0;
        data.nodes = arrayrandomize( data.nodes );
        spawndata[ name ] = data;
    }
    
    /#
        level.var_f9ba6d6273c5cc67.spawndata = spawndata;
    #/
    
    return spawndata;
}

// Namespace activity_manager
// Params 0
// Checksum 0x96fb9470, Offset: 0x186b
// Size: 0x15a
function function_5367512ef4e95dcb()
{
    spawndata = [];
    numrows = tablelookupgetnumrows( "mp/bractivities.csv" );
    
    for ( row = 0; row < numrows ; row++ )
    {
        enabled = int( tablelookupbyrow( "mp/bractivities.csv", row, 2 ) );
        name = tablelookupbyrow( "mp/bractivities.csv", row, 0 );
        function_887ae09e82d10e1f( name, row );
        
        if ( !enabled )
        {
            continue;
        }
        
        data = spawnstruct();
        data.index = row;
        data.type = tablelookupbyrow( "mp/bractivities.csv", row, 3 );
        data.cashreward = int( tablelookupbyrow( "mp/bractivities.csv", row, 4 ) );
        
        switch ( name )
        {
            case #"hash_7e9cf92ed0a526f1":
                namespace_dc3a0c120a108a2::brtask_getspawndata( data );
                break;
            case #"hash_890e226c519dc6ab":
                br_task_person_of_interest::brtask_getspawndata( data );
                break;
            case #"hash_dd93195493d0c818":
                namespace_a69d9116df130921::brtask_getspawndata( data );
                break;
            default:
                assertmsg( "<dev string:x19b>" + name );
                break;
        }
        
        spawndata[ name ] = data;
    }
    
    level.var_f9ba6d6273c5cc67.spawndatamap = spawndata;
}

// Namespace activity_manager
// Params 1
// Checksum 0xaf7e5802, Offset: 0x19cd
// Size: 0x41
function function_5746d96d32bb36e5( name )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.spawndatamap ) )
    {
        function_5367512ef4e95dcb();
    }
    
    return level.var_f9ba6d6273c5cc67.spawndatamap[ name ];
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0xc752b33b, Offset: 0x1a17
// Size: 0x58
function private function_887ae09e82d10e1f( type, index )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.typeindexes ) )
    {
        level.var_f9ba6d6273c5cc67.typeindexes = [];
    }
    
    level.var_f9ba6d6273c5cc67.typeindexes[ type ] = index;
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x614d2550, Offset: 0x1a77
// Size: 0x5b
function private function_f01ee87256c40e98( type )
{
    assert( isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67.typeindexes[ type ] ) );
    return level.var_f9ba6d6273c5cc67.typeindexes[ type ];
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0xfd687aaa, Offset: 0x1adb
// Size: 0x73
function private function_5ce68265130e80ae()
{
    level.var_f9ba6d6273c5cc67.spawndatamap = activity_getspawndata();
    level.var_f9ba6d6273c5cc67.var_ced95f4b6629704 = getdvarint( @"hash_b44c01cc57de403d", 15 );
    function_1a4e5dded70b786c( level.var_f9ba6d6273c5cc67.spawndatamap );
    function_1ba6d16c49e84d6f( level.var_f9ba6d6273c5cc67.spawndatamap );
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x5358d732, Offset: 0x1b56
// Size: 0x2fe
function private function_1a4e5dded70b786c( spawndatamap )
{
    if ( !poi::poi_issystemactive() )
    {
        return;
    }
    
    var_cb195b3461af4fd8 = getdvarint( @"hash_870dad054972bf3e", 2 );
    var_b5a9e30a53d6d2eb = [];
    
    foreach ( poiname, _ in level.poi )
    {
        tospawn = getdvarint( hashcat( @"hash_c6cea952b5d6724c", poiname ), issubstr( poiname, "suburb" ) ? 0 : var_cb195b3461af4fd8 );
        
        if ( tospawn > 0 )
        {
            var_b5a9e30a53d6d2eb[ poiname ] = tospawn;
        }
    }
    
    var_28cd182256f431cc = 0;
    
    while ( true )
    {
        [ name, spawndata ] = function_9f092abf03036756( spawndatamap );
        
        if ( !( isdefined( name ) && isdefined( spawndata ) ) )
        {
            return;
        }
        
        foreach ( index, node in spawndata.nodes )
        {
            if ( !isdefined( node.script_poi ) )
            {
                node.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
            }
            
            if ( isdefined( node.script_poi ) && var_b5a9e30a53d6d2eb[ node.script_poi ] > 0 && function_600a7e9e3b0623bb( node.origin, spawndata.exclusionradius, spawndata.var_e932a99b1cb1d5f2, name ) && !br_dmz_radiation::function_704454416dce7454( node.origin ) )
            {
                function_2fc499a089d80b10( node, name, spawndata, getdvarint( @"hash_4ca9133f642d177f", 0 ) == 1 );
                var_b5a9e30a53d6d2eb[ node.script_poi ]--;
                
                if ( var_b5a9e30a53d6d2eb[ node.script_poi ] <= 0 )
                {
                    var_b5a9e30a53d6d2eb[ node.script_poi ] = undefined;
                }
                
                spawndata.nodes[ index ] = undefined;
                var_28cd182256f431cc++;
                
                if ( var_28cd182256f431cc >= level.var_f9ba6d6273c5cc67.var_ced95f4b6629704 )
                {
                    var_28cd182256f431cc -= level.var_f9ba6d6273c5cc67.var_ced95f4b6629704;
                    waitframe();
                }
                
                if ( var_b5a9e30a53d6d2eb.size <= 0 )
                {
                    return;
                }
                
                spawndata.spawned++;
                
                if ( spawndata.spawned >= spawndata.tospawn )
                {
                    break;
                }
            }
        }
        
        spawndatamap[ name ] = undefined;
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0xc16751d2, Offset: 0x1e5c
// Size: 0x208
function private function_1ba6d16c49e84d6f( spawndatamap )
{
    var_28cd182256f431cc = 0;
    
    while ( true )
    {
        [ name, spawndata ] = function_9f092abf03036756( spawndatamap );
        
        if ( !( isdefined( name ) && isdefined( spawndata ) ) )
        {
            break;
        }
        
        if ( spawndata.spawned < spawndata.tospawn )
        {
            foreach ( node in spawndata.nodes )
            {
                if ( !isdefined( node.script_poi ) )
                {
                    node.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
                }
                
                if ( function_600a7e9e3b0623bb( node.origin, spawndata.exclusionradius, spawndata.var_e932a99b1cb1d5f2, name ) && ( !poi::poi_issystemactive() || !isdefined( node.script_poi ) || poi::poi_ispoiactive( node.script_poi ) ) && !br_dmz_radiation::function_704454416dce7454( node.origin ) )
                {
                    function_2fc499a089d80b10( node, name, spawndata, getdvarint( @"hash_4ca9133f642d177f", 0 ) == 1 );
                    var_28cd182256f431cc++;
                    
                    if ( var_28cd182256f431cc >= level.var_f9ba6d6273c5cc67.var_ced95f4b6629704 )
                    {
                        var_28cd182256f431cc -= level.var_f9ba6d6273c5cc67.var_ced95f4b6629704;
                        waitframe();
                    }
                    
                    spawndata.spawned++;
                    
                    if ( spawndata.spawned >= spawndata.tospawn )
                    {
                        break;
                    }
                }
            }
        }
        
        spawndatamap[ name ] = undefined;
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0x9050dd00, Offset: 0x206c
// Size: 0xf3
function function_16b18cf53a24f5a0( name )
{
    triggerowner = self;
    spawndata = function_5746d96d32bb36e5( name );
    activity = function_60275d3b5b92ba14();
    
    if ( isdefined( triggerowner.fortresstype ) )
    {
        activity.fortress = triggerowner;
    }
    
    activity.tasks[ 0 ] = [[ spawndata.createfunc ]]( activity, triggerowner );
    activity.cashreward = spawndata.cashreward;
    activity.name = name;
    activity.origin = triggerowner.origin;
    activity.type = spawndata.type;
    level.var_f9ba6d6273c5cc67.activities[ activity.id ] = activity;
    return activity activity_initactivity();
}

// Namespace activity_manager
// Params 4, eflags: 0x4
// Checksum 0x68e6c3f8, Offset: 0x2168
// Size: 0x289
function private function_2fc499a089d80b10( node, name, spawndata, debug )
{
    if ( poi::poi_issystemactive() && !isdefined( node.script_poi ) )
    {
        node.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
    }
    
    if ( ai_fortress::fortress_issystemactive() && !isdefined( node.fortress ) )
    {
        node.fortress = ai_fortress::function_386da8b7d1afe346( node.origin );
    }
    
    function_55ff49e4c914388d( node.origin, spawndata.exclusionradius, name );
    activity = function_60275d3b5b92ba14();
    activity.tasks[ 0 ] = [[ spawndata.createfunc ]]( activity, node );
    activity.cashreward = spawndata.cashreward;
    activity.name = name;
    activity.origin = node.origin;
    activity.script_poi = node.script_poi;
    activity.fortress = node.fortress;
    activity.type = spawndata.type;
    level.var_f9ba6d6273c5cc67.activities[ activity.id ] = activity;
    
    /#
        dmz_logging::addlogevent( name, name, "<dev string:x1ef>", undefined, activity.id, undefined, activity.script_poi, activity.origin );
    #/
    
    activity thread activity_initactivity();
    
    /#
        if ( debug )
        {
            line( node.origin, node.origin + ( 0, 0, 4096 ), ( 0, 1, 1 ), 1, 0, 20000 );
            utility::draw_circle( node.origin + ( 0, 0, 800 ), spawndata.exclusionradius, ( 1, 0, 0 ), 1, 0, 20000 );
            utility::draw_circle( node.origin + ( 0, 0, 800 ), spawndata.var_e932a99b1cb1d5f2, ( 1, 1, 0 ), 1, 0, 20000 );
        }
    #/
    
    return activity;
}

// Namespace activity_manager
// Params 4, eflags: 0x4
// Checksum 0xe303010d, Offset: 0x23fa
// Size: 0x154, Type: bool
function private function_600a7e9e3b0623bb( origin, var_4c9d62b6d49e88cf, var_ef37c59c8e1054b3, name )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.exclusionpoints ) )
    {
        level.var_f9ba6d6273c5cc67.exclusionpoints = [];
    }
    
    foreach ( point in level.var_f9ba6d6273c5cc67.exclusionpoints )
    {
        dist = distance( origin, point.origin );
        
        if ( point.onlyexcludename )
        {
            if ( point.name == name && dist < point.radius )
            {
                return false;
            }
            
            continue;
        }
        
        if ( dist < point.radius || dist < var_4c9d62b6d49e88cf || point.name == name && dist < var_ef37c59c8e1054b3 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace activity_manager
// Params 4, eflags: 0x4
// Checksum 0xe1ca51a9, Offset: 0x2557
// Size: 0xc5
function private function_55ff49e4c914388d( origin, radius, name, onlyexcludename )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.exclusionpoints ) )
    {
        level.var_f9ba6d6273c5cc67.exclusionpoints = [];
    }
    
    point = spawnstruct();
    point.origin = origin;
    point.radius = radius;
    point.name = name;
    point.onlyexcludename = onlyexcludename;
    level.var_f9ba6d6273c5cc67.exclusionpoints[ level.var_f9ba6d6273c5cc67.exclusionpoints.size ] = point;
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x1a6b74e4, Offset: 0x2624
// Size: 0xe6
function private function_9f092abf03036756( spawndata )
{
    if ( !isdefined( spawndata ) || spawndata.size <= 0 )
    {
        return [ undefined, undefined ];
    }
    
    maxpriority = -1;
    bestname = undefined;
    bestdata = undefined;
    
    foreach ( name, data in spawndata )
    {
        if ( data.priority > maxpriority )
        {
            maxpriority = data.priority;
            bestname = name;
            bestdata = data;
        }
    }
    
    return [ bestname, bestdata ];
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0xcb92b394, Offset: 0x2713
// Size: 0xab
function private activity_initactivity()
{
    foreach ( index, task in self.tasks )
    {
        task.index = index;
        
        if ( isdefined( task.funcs[ "onInit" ] ) )
        {
            task [[ task.funcs[ "onInit" ] ]]();
        }
    }
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x5abe4ffb, Offset: 0x27c6
// Size: 0x1d0
function private function_35d9d389f8866736()
{
    var_516beacebfd7727c = 0;
    level.var_f9ba6d6273c5cc67.teamsinfo = [];
    
    if ( level.var_372917288315121c )
    {
        level br_strongholds::function_7438154839bbbe49( 1 );
        
        if ( level.var_c4c93eb6e6cb65d8 )
        {
            foreach ( agent in function_8e8b213809f3c0ef( "everybody" ) )
            {
                function_25023c2e3e50fa00( agent.team );
            }
            
            var_516beacebfd7727c = function_7c7f41d3fd5028a5( "everybody" );
        }
    }
    else
    {
        level function_5ce68265130e80ae();
        level thread function_614fcc38c9833114();
        level function_1890c4391d7c65c6();
        
        if ( getdvarint( @"hash_5ebc91cfdc6a2402", 0 ) )
        {
            level thread namespace_76299fb251d3aacd::function_abfc1364a8043fe1();
        }
    }
    
    level.var_f9ba6d6273c5cc67.totalplayers = level.players.size + var_516beacebfd7727c;
    
    foreach ( player in level.players )
    {
        function_25023c2e3e50fa00( player.team );
    }
    
    var_6695a2993e158c1c = getdvarint( @"hash_7aa1f51e05f1bd54", 5 );
    
    if ( var_6695a2993e158c1c > 0 )
    {
        level thread function_5bece90343632f7c( var_6695a2993e158c1c );
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x8e2fe8b, Offset: 0x299e
// Size: 0x141
function private function_5bece90343632f7c( var_6695a2993e158c1c )
{
    while ( true )
    {
        if ( level.var_f9ba6d6273c5cc67.totalplayers < level.players.size )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( level.var_f9ba6d6273c5cc67.teamsinfo[ player.team ] ) )
                {
                    function_25023c2e3e50fa00( player.team );
                }
            }
        }
        
        level.var_f9ba6d6273c5cc67.totalplayers = level.players.size;
        
        if ( level.var_c4c93eb6e6cb65d8 )
        {
            level.var_f9ba6d6273c5cc67.totalplayers = level.players.size + level.aibudgets.spawned[ "everybody" ].size;
        }
        
        wait var_6695a2993e158c1c;
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0xd0611cb5, Offset: 0x2ae7
// Size: 0x198
function private function_25023c2e3e50fa00( teamname )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ] ) )
    {
        level.var_f9ba6d6273c5cc67.teamlist[ level.var_f9ba6d6273c5cc67.teamlist.size ] = teamname;
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ] = spawnstruct();
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].trackingids = [];
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].trackingindex = -1;
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activities = [];
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].activitiescompleted = 0;
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].active = 0;
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].volumeactivities = [];
        
        if ( level.activityautoassign > 1 )
        {
            if ( !function_52cb56af0d85e094( teamname ) )
            {
                player = teams::getteamdata( teamname, "players" )[ 0 ];
                
                if ( isdefined( player ) )
                {
                    activity = function_a6448d048cf432e1( player );
                    
                    if ( isdefined( activity ) )
                    {
                        activity activity_assign( teamname );
                    }
                }
            }
        }
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0x721435e3, Offset: 0x2c87
// Size: 0x1ce
function function_93138313116d2f3e( missiontrigger, activity )
{
    triggerowner = self;
    level endon( #"game_ended" );
    missiontrigger endon( #"deleted" );
    missiontrigger endon( #"activity_ended" );
    missiontrigger.touchents = [];
    missiontrigger.var_311cf43f7ca50818 = [];
    triggerowner thread function_16b18cf53a24f5a0( activity );
    
    while ( true )
    {
        validenter = 0;
        missiontrigger waittill( #"trigger", ent );
        
        if ( !triggerowner.unlocked || level.var_2ddd4f34a029fb86 && !triggerowner.infiltrated )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() && !isdefined( ent.streakinfo ) )
        {
            occupants = vehicle_occupancy::get_all_occupants( ent );
            
            if ( !isdefined( occupants ) )
            {
                continue;
            }
            
            foreach ( occupant in occupants )
            {
                if ( missiontrigger function_90e1f75526d9456( occupant ) )
                {
                    validenter = missiontrigger function_3a45feafe78c4c78( occupant, missiontrigger.entnum, triggerowner );
                    
                    if ( validenter )
                    {
                        missiontrigger function_d53829514feedc4f( occupant );
                    }
                }
            }
            
            continue;
        }
        
        if ( missiontrigger function_90e1f75526d9456( ent ) )
        {
            validenter = missiontrigger function_3a45feafe78c4c78( ent, missiontrigger.entnum, triggerowner );
            
            if ( validenter )
            {
                missiontrigger function_d53829514feedc4f( ent );
            }
        }
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0x80814f3d, Offset: 0x2e5d
// Size: 0x84
function function_d53829514feedc4f( player )
{
    missiontrigger = self;
    playerentnum = player getentitynumber();
    
    if ( !isdefined( missiontrigger.touchents[ playerentnum ] ) )
    {
        missiontrigger notify( #"hash_dc7414dbd8411b32", player );
        missiontrigger.touchents[ playerentnum ] = player;
        missiontrigger.var_311cf43f7ca50818[ playerentnum ] = gettime();
        return;
    }
    
    missiontrigger.var_311cf43f7ca50818[ playerentnum ] = gettime();
}

// Namespace activity_manager
// Params 1
// Checksum 0xab0190dd, Offset: 0x2ee9
// Size: 0xb9, Type: bool
function function_90e1f75526d9456( player )
{
    triggervol = self;
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( triggervol.trigger_off )
    {
        return false;
    }
    
    if ( !level.var_c4c93eb6e6cb65d8 )
    {
        if ( !isbot( player ) && game_utility_common::isaigameparticipant( player ) )
        {
            return false;
        }
        
        if ( !game_utility_common::isgameparticipant( player ) )
        {
            return false;
        }
        
        if ( isagent( player ) && !( isdefined( player.team ) && isdefined( triggervol.numtouching[ player.team ] ) ) )
        {
            return false;
        }
    }
    
    if ( player.classname == "script_vehicle" )
    {
        return false;
    }
    
    return true;
}

// Namespace activity_manager
// Params 3
// Checksum 0x81a2fd42, Offset: 0x2fab
// Size: 0x28
function function_3a45feafe78c4c78( player, triggerentnum, triggerowner )
{
    return function_8b0682f67e4df7de( player, triggerentnum, triggerowner );
}

// Namespace activity_manager
// Params 2
// Checksum 0xe9226604, Offset: 0x2fdc
// Size: 0x26a
function function_e7c5a361b3642470( missiontrigger, var_d8d451311562bd9c )
{
    assert( isdefined( missiontrigger ), "<dev string:x1fd>" );
    task = self;
    level endon( #"game_ended" );
    missiontrigger endon( #"deleted" );
    missiontrigger endon( #"activity_ended" );
    
    if ( !isdefined( var_d8d451311562bd9c ) )
    {
        var_d8d451311562bd9c = 9000;
    }
    
    resolutionms = 0;
    
    if ( !isdefined( missiontrigger.resolutionms ) )
    {
        resolutionms = 300;
    }
    else
    {
        resolutionms = missiontrigger.resolutionms;
    }
    
    resolutions = resolutionms / 1000;
    assert( resolutions > 0, "<dev string:x234>" );
    
    while ( true )
    {
        wait resolutions;
        waittillframeend();
        
        foreach ( playerentnum, touchent in missiontrigger.touchents )
        {
            if ( !isdefined( touchent ) )
            {
                missiontrigger.touchents[ playerentnum ] = undefined;
                missiontrigger.var_311cf43f7ca50818[ playerentnum ] = undefined;
                continue;
            }
            
            assert( isdefined( missiontrigger.var_311cf43f7ca50818[ playerentnum ] ), "<dev string:x260>" );
            currenttime = gettime();
            var_7b60738d2c66d7dc = currenttime - missiontrigger.var_311cf43f7ca50818[ playerentnum ];
            
            if ( var_7b60738d2c66d7dc > var_d8d451311562bd9c )
            {
                missiontrigger notify( #"hash_4c6655a461df2ba4", touchent );
                
                if ( isdefined( task.funcs[ "onPlayerExitTimeout" ] ) )
                {
                    task thread [[ task.funcs[ "onPlayerExitTimeout" ] ]]( touchent );
                }
                
                missiontrigger.touchents[ playerentnum ] = undefined;
                missiontrigger.var_311cf43f7ca50818[ playerentnum ] = undefined;
                continue;
            }
            
            if ( var_7b60738d2c66d7dc > resolutionms )
            {
                if ( isdefined( task.funcs[ "onPlayerExitVolume" ] ) )
                {
                    task thread [[ task.funcs[ "onPlayerExitVolume" ] ]]( touchent );
                }
                
                continue;
            }
            
            if ( touchent.var_5111d0ec51f4ab00 )
            {
                if ( isdefined( task.funcs[ "onPlayerReenterVolume" ] ) )
                {
                    task thread [[ task.funcs[ "onPlayerReenterVolume" ] ]]( touchent );
                }
            }
        }
    }
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0xc86a1495, Offset: 0x324e
// Size: 0x1c9
function private function_614fcc38c9833114()
{
    while ( true )
    {
        foreach ( activity in level.var_f9ba6d6273c5cc67.activities )
        {
            if ( isdefined( activity ) )
            {
                foreach ( team, index in activity.teams )
                {
                    if ( !level.var_f9ba6d6273c5cc67.teamsinfo[ team ].active )
                    {
                        foreach ( player in teams::getteamdata( team, "players" ) )
                        {
                            if ( distancesquared( player.origin, activity.origin ) < activity.var_4b27bec635fbc94b )
                            {
                                activity activity_start( team );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0xfcd8ed33, Offset: 0x341f
// Size: 0x2de, Type: bool
function function_7b786da5dcd7eeb9( triggerowner )
{
    player = self;
    
    if ( player.var_964ef67e77a897bc )
    {
        return false;
    }
    
    if ( !level.var_f9ba6d6273c5cc67.teamsinfo[ player.team ].active )
    {
        if ( !isdefined( triggerowner.task ) )
        {
            return false;
        }
    }
    else if ( !arraycontains( triggerowner.task.players, player ) )
    {
        volumeactivities = level.var_f9ba6d6273c5cc67.teamsinfo[ player.team ].volumeactivities;
        
        foreach ( activity in volumeactivities )
        {
            if ( !isdefined( activity.tasks ) )
            {
                continue;
            }
            
            foreach ( task in activity.tasks )
            {
                if ( !isdefined( task ) )
                {
                    continue;
                }
                
                if ( arraycontains( task.players, player ) )
                {
                    var_3f30c48156d8292b = distance2d( task.circlecenter, player.origin );
                    var_7a7a32c76ec9d55b = distance2d( triggerowner.task.circlecenter, player.origin );
                    
                    if ( var_3f30c48156d8292b > var_7a7a32c76ec9d55b && !player.var_964ef67e77a897bc )
                    {
                        player thread function_31fbec20f8d12308( task.activity, triggerowner.task.activity );
                    }
                    
                    return false;
                }
            }
        }
    }
    else if ( arraycontains( triggerowner.task.players, player ) )
    {
        return true;
    }
    
    player playlocalsound( "mp_dmz_phone_pickup" );
    triggerowner.task.activity activity_assign( player.team, undefined, player, 1 );
    triggerowner.task.activity function_32b9e607f063d72( player.team );
    return true;
}

// Namespace activity_manager
// Params 3
// Checksum 0xf5a96ac1, Offset: 0x3706
// Size: 0x2f, Type: bool
function function_8b0682f67e4df7de( player, triggerentnum, triggerowner )
{
    if ( isdefined( triggerowner ) )
    {
        return player function_7b786da5dcd7eeb9( triggerowner );
    }
    
    return false;
}

// Namespace activity_manager
// Params 3
// Checksum 0x920501f2, Offset: 0x373e
// Size: 0x3b1
function activity_taskended( task, completingteam, var_4bdc367855270ff8 )
{
    var_7f474d20b727b577 = isdefined( completingteam );
    var_f0aee23ddaca0fcf = task.index + 1;
    
    foreach ( var_35c88b61b980ff6f in task.teams )
    {
        victor = var_7f474d20b727b577 && var_35c88b61b980ff6f == completingteam;
        
        if ( var_f0aee23ddaca0fcf >= self.tasks.size )
        {
            dmz_task_utils::function_a34948873e789a50( var_35c88b61b980ff6f );
            overlord::function_ec9b8fd48f81a9e7( teams::getteamdata( var_35c88b61b980ff6f, "players" ), self.name );
            level.var_f9ba6d6273c5cc67.teamsinfo[ var_35c88b61b980ff6f ].active = 0;
            
            if ( victor )
            {
                players = teams::getteamdata( var_35c88b61b980ff6f, "players" );
                
                foreach ( player in players )
                {
                    if ( !isdefined( player.brmissionscompleted ) )
                    {
                        player.brmissionscompleted = 0;
                    }
                    
                    player.brmissionscompleted++;
                    player points::doscoreevent( #"dmz_contract_complete" );
                    
                    if ( level.var_b8ce9185137f1694 )
                    {
                        player setclientomnvar( "ui_dmz_missions_completed", 0 );
                    }
                    
                    player br_public::updatebrscoreboardstat( "missionsCompleted", player.brmissionscompleted );
                }
                
                level.var_f9ba6d6273c5cc67.teamsinfo[ var_35c88b61b980ff6f ].activitiescompleted++;
                telemetry_mp::function_390c5cfc04cca2d9( self, "success", completingteam );
                starterpoi = undefined;
                
                if ( isdefined( self.activitystarter ) && isdefined( self.activitystarter.starterpoi ) )
                {
                    starterpoi = self.activitystarter.starterpoi;
                }
                
                callback::callback( "team_engaged_activity", { #poi:starterpoi, #iscompletion:1, #activityref:self.name, #team:completingteam } );
                
                if ( isdefined( level.var_ada9165e7db9197f ) )
                {
                    level [[ level.var_ada9165e7db9197f ]]( var_35c88b61b980ff6f, self );
                }
            }
            
            if ( !var_4bdc367855270ff8 )
            {
                thread dmz_task_utils::function_c249649ab8c62a3e( var_35c88b61b980ff6f );
            }
            
            continue;
        }
        
        self.tasks[ var_f0aee23ddaca0fcf ].teams[ self.tasks[ var_f0aee23ddaca0fcf ].teams.size ] = var_35c88b61b980ff6f;
        self.teams[ var_35c88b61b980ff6f ] = var_f0aee23ddaca0fcf;
        dmz_task_utils::function_4a4efabf70334bfb( self.tasks[ var_f0aee23ddaca0fcf ].refindex, self.tasks[ var_f0aee23ddaca0fcf ].tier, var_35c88b61b980ff6f );
        function_3be785040271bc1f( var_35c88b61b980ff6f, "onTeamStart" );
        self.tasks[ var_f0aee23ddaca0fcf ].started = 1;
    }
    
    if ( var_f0aee23ddaca0fcf >= self.tasks.size )
    {
        activity_ended( completingteam );
    }
    
    task notify( #"task_ended" );
}

// Namespace activity_manager
// Params 1
// Checksum 0xfa57773b, Offset: 0x3af7
// Size: 0x1df
function activity_ended( completingteam )
{
    level.var_f9ba6d6273c5cc67.activities[ self.id ] = undefined;
    
    if ( isdefined( self.activitystarter ) )
    {
        level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = arrayremove( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877, self.activitystarter );
        self.activitystarter setscriptablepartstate( "brloot_activity_starter", "hidden" );
    }
    
    foreach ( team, task in self.teams )
    {
        level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities = arrayremove( level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities, self.id );
        
        if ( !function_52cb56af0d85e094( team ) )
        {
            function_38a66d429906d908( team, 1 );
        }
        
        if ( level.activityautoassign > 0 )
        {
            if ( !function_52cb56af0d85e094( team ) )
            {
                player = teams::getteamdata( team, "players" )[ 0 ];
                
                if ( isdefined( player ) )
                {
                    activity = function_a6448d048cf432e1( player );
                    
                    if ( isdefined( activity ) )
                    {
                        activity activity_assign( team );
                    }
                }
            }
        }
        
        if ( !level.var_f9ba6d6273c5cc67.teamsinfo[ team ].active )
        {
            function_989ab2ce3ed11ab8( team );
        }
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x474fb1f6, Offset: 0x3cde
// Size: 0xbb
function private activity_start( team )
{
    assert( !level.var_f9ba6d6273c5cc67.teamsinfo[ team ].active, "<dev string:x28e>" );
    level.var_f9ba6d6273c5cc67.teamsinfo[ team ].active = 1;
    function_3be785040271bc1f( team, "onTeamStart" );
    self.tasks[ 0 ].started = 1;
    task = activity_currenttask( self, team );
    dmz_task_utils::function_4a4efabf70334bfb( task.refindex, dmz_task_utils::function_d4ea0f16e1d32f37( self.cashreward ), team );
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x287650b9, Offset: 0x3da1
// Size: 0x47
function private function_32b9e607f063d72( team )
{
    level.var_f9ba6d6273c5cc67.teamsinfo[ team ].active = 1;
    self.tasks[ 0 ].started = 1;
}

// Namespace activity_manager
// Params 2
// Checksum 0xe6208a11, Offset: 0x3df0
// Size: 0xef
function function_fe7b31ede83c60e4( player, team )
{
    assert( function_52cb56af0d85e094( team ), "<dev string:x2d3>" );
    activity = function_25e2a500662e347( team );
    activity function_3113c447798e3741( player, team );
    
    foreach ( task in activity.tasks )
    {
        if ( isdefined( task.funcs[ "onPlayerJoined" ] ) )
        {
            task thread [[ task.funcs[ "onPlayerJoined" ] ]]( player );
        }
    }
    
    activity function_b3084af09c057a1c( team );
}

// Namespace activity_manager
// Params 0
// Checksum 0xd5c55ab0, Offset: 0x3ee7
// Size: 0x2f
function function_bb3becac4babbb4d()
{
    dmz_task_utils::task_ended();
    
    if ( isdefined( self.funcs[ "onForceEnd" ] ) )
    {
        self thread [[ self.funcs[ "onForceEnd" ] ]]();
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0x9680ac16, Offset: 0x3f1e
// Size: 0x34
function function_5abb1c2f65633a8f( team )
{
    if ( isdefined( self.funcs[ "onCancel" ] ) )
    {
        self thread [[ self.funcs[ "onCancel" ] ]]( team );
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0x376b45aa, Offset: 0x3f5a
// Size: 0x1b8
function activity_removeplayer( player, team )
{
    assert( function_52cb56af0d85e094( team ), "<dev string:x311>" );
    activity = function_25e2a500662e347( team );
    dmz_task_utils::function_9b0ef5309a210b35( player );
    
    if ( isdefined( activity.tasks[ 0 ].icon ) )
    {
        activity.tasks[ 0 ] dmz_task_utils::function_d8d9112f1e68fa2b( player );
    }
    else if ( isdefined( activity.tasks[ 0 ].objidnum ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( activity.tasks[ 0 ].objidnum, player );
    }
    
    foreach ( task in activity.tasks )
    {
        if ( isdefined( task.funcs[ "onPlayerRemoved" ] ) )
        {
            task thread [[ task.funcs[ "onPlayerRemoved" ] ]]( player );
        }
    }
    
    if ( isdefined( activity.var_e702f7ee6139a98d ) )
    {
        activity.var_e702f7ee6139a98d = arrayremove( activity.var_e702f7ee6139a98d, player );
    }
    
    if ( !activity.tasks[ 0 ] function_c00e48e59a9eac0() )
    {
        activity.tasks[ 0 ] function_5abb1c2f65633a8f( team );
        return;
    }
    
    activity function_b3084af09c057a1c( team );
}

// Namespace activity_manager
// Params 2
// Checksum 0x4aeeebe1, Offset: 0x411a
// Size: 0xa0, Type: bool
function function_31fbec20f8d12308( toremove, toadd )
{
    player = self;
    
    if ( player.var_964ef67e77a897bc )
    {
        return false;
    }
    
    player.var_964ef67e77a897bc = 1;
    toremove activity_removeplayer( player, player.team );
    wait 3;
    player playlocalsound( "mp_dmz_phone_pickup" );
    toadd activity_assign( player.team, undefined, player, 1 );
    toadd function_32b9e607f063d72( player.team );
    player.var_964ef67e77a897bc = 0;
    return true;
}

// Namespace activity_manager
// Params 1
// Checksum 0x589cc53f, Offset: 0x41c3
// Size: 0xa3
function activity_changeteams( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    if ( function_52cb56af0d85e094( oldteam ) )
    {
        activity_removeplayer( player, oldteam );
    }
    
    dmz_task_utils::function_9b0ef5309a210b35( player );
    var_7f76ec5aadf95aa0 = function_52cb56af0d85e094( newteam );
    
    if ( function_52cb56af0d85e094( newteam ) )
    {
        function_fe7b31ede83c60e4( player, newteam );
    }
    
    function_9658fe6aabcb4b6( player, !var_7f76ec5aadf95aa0 || player.canhackcontracts );
}

// Namespace activity_manager
// Params 4
// Checksum 0x8b0e60b9, Offset: 0x426e
// Size: 0x39e
function activity_assign( team, taskindex, var_8c953eb201608663, var_22737c8bc0ae6496 )
{
    if ( function_52cb56af0d85e094( team ) && !var_22737c8bc0ae6496 )
    {
        return;
    }
    
    if ( !isdefined( taskindex ) )
    {
        taskindex = 0;
    }
    
    if ( isdefined( self.activitystarter ) )
    {
        level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = arrayremove( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877, self.activitystarter );
        self.activitystarter setscriptablepartstate( "brloot_activity_starter", "hidden" );
    }
    
    if ( level.var_b8ce9185137f1694 )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            player setclientomnvar( "ui_dmz_missions_completed", 1 );
        }
    }
    
    if ( isdefined( var_8c953eb201608663 ) && !game_utility_common::isaigameparticipant( var_8c953eb201608663 ) )
    {
        function_38a66d429906d908( team, 0 );
        overlord::function_887cf4f7cba8cfa8( teams::getteamdata( team, "players" ), self.name, 75 );
    }
    
    self.teams[ team ] = taskindex;
    
    if ( !arraycontains( self.tasks[ taskindex ].teams, team ) )
    {
        self.tasks[ taskindex ].teams[ self.tasks[ taskindex ].teams.size ] = team;
    }
    
    level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities[ level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities.size ] = self.id;
    self.var_48423c6dad66d9c3 = var_8c953eb201608663;
    
    if ( isdefined( var_8c953eb201608663 ) && !game_utility_common::isaigameparticipant( var_8c953eb201608663 ) )
    {
        thread function_c95b9a7098d8ec3d( team, var_8c953eb201608663 );
    }
    
    foreach ( task in self.tasks )
    {
        if ( isdefined( task.funcs[ "onTeamAssigned" ] ) )
        {
            task thread [[ task.funcs[ "onTeamAssigned" ] ]]( team );
        }
        
        if ( isdefined( var_8c953eb201608663 ) && isdefined( task.funcs[ "onPlayerAssigned" ] ) && isdefined( task.funcs[ "onPlayerJoined" ] ) )
        {
            task function_b1c648fd47942640( team, var_8c953eb201608663 );
        }
    }
    
    starterpoi = undefined;
    
    if ( isdefined( self.activitystarter ) && isdefined( self.activitystarter.starterpoi ) )
    {
        starterpoi = self.activitystarter.starterpoi;
    }
    
    if ( isdefined( var_8c953eb201608663 ) )
    {
        callback::callback( "team_engaged_activity", { #poi:starterpoi, #iscompletion:0, #activityref:self.name, #team:team } );
    }
    
    talking_gun::function_8f186d78b8efdebd( team, self );
}

// Namespace activity_manager
// Params 2
// Checksum 0x85941812, Offset: 0x4614
// Size: 0x22a
function function_b1c648fd47942640( teamname, player )
{
    task = self;
    var_a7afd8e1d6eb5e26 = task.teams.size == 1;
    assignfirstplayer = task.players.size == 0;
    var_8302f6fc711888f4 = 0;
    var_955cb444ad96f48e = 0;
    size = level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].volumeactivities.size;
    
    if ( assignfirstplayer )
    {
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].volumeactivities[ size ] = task.activity;
        task thread [[ task.funcs[ "onPlayerAssigned" ] ]]( teamname, player );
        return;
    }
    
    if ( task.teams.size >= 0 )
    {
        foreach ( activityplayer in task.players )
        {
            if ( !( isdefined( activityplayer ) && isdefined( activityplayer.team ) ) )
            {
                continue;
            }
            
            if ( player.team == activityplayer.team )
            {
                var_8302f6fc711888f4 = 1;
                break;
            }
        }
        
        if ( !var_8302f6fc711888f4 && !var_a7afd8e1d6eb5e26 )
        {
            var_955cb444ad96f48e = 1;
        }
    }
    
    if ( var_8302f6fc711888f4 )
    {
        task thread [[ task.funcs[ "onPlayerJoined" ] ]]( player );
        return;
    }
    
    if ( !assignfirstplayer && var_955cb444ad96f48e )
    {
        level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ].volumeactivities[ size ] = task.activity;
        task thread [[ task.funcs[ "onPlayerAssigned" ] ]]( teamname, player );
        return;
    }
    
    assert( 0, "<dev string:x357>" );
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0x67aa42cf, Offset: 0x4846
// Size: 0xbb
function private function_3113c447798e3741( player, team )
{
    if ( level.var_53805a466ab65049 && !level.var_372917288315121c )
    {
        task = activity_currenttask( self, team );
        dmz_task_utils::function_d1003180abd8ac5f( player, task.refindex );
    }
    
    if ( isdefined( self.tasks[ 0 ].icon ) )
    {
        self.tasks[ 0 ] dmz_task_utils::function_dc6a173a36eef985( player );
        return;
    }
    
    if ( isdefined( self.tasks[ 0 ].objidnum ) )
    {
        objective_showtoplayersinmask( self.tasks[ 0 ].objidnum );
    }
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0xc4c0c877, Offset: 0x4909
// Size: 0x2b7
function private function_c95b9a7098d8ec3d( team, var_8c953eb201608663 )
{
    info = level.var_f9ba6d6273c5cc67.teamsinfo[ team ];
    info.trackingindex += 1;
    info.trackingindex = info.trackingindex >= level.var_2a22b67ae4fc308e ? 0 : info.trackingindex;
    
    foreach ( index, id in info.trackingids )
    {
        if ( !isdefined( level.var_f9ba6d6273c5cc67.activities[ id ] ) )
        {
            info.trackingindex = index;
        }
    }
    
    if ( isdefined( info.trackingids[ info.trackingindex ] ) )
    {
        prevactivity = level.var_f9ba6d6273c5cc67.activities[ info.trackingids[ info.trackingindex ] ];
        
        if ( isdefined( prevactivity ) )
        {
            if ( level.var_185eda8a5a2d1fc7 == 0 )
            {
                return;
            }
            
            if ( isdefined( self.tasks[ 0 ].icon ) )
            {
                prevactivity.tasks[ 0 ] dmz_task_utils::function_1f1750516b1142e3( team );
            }
            else if ( isdefined( self.tasks[ 0 ].objidnum ) )
            {
                prevactivity.tasks[ 0 ] dmz_task_utils::function_205740d04dd0c548( team );
            }
        }
    }
    
    info.trackingids[ info.trackingindex ] = self.id;
    
    if ( level.var_53805a466ab65049 && !level.var_372917288315121c )
    {
        task = activity_currenttask( self, team );
        dmz_task_utils::function_4a4efabf70334bfb( task.refindex, dmz_task_utils::function_d4ea0f16e1d32f37( self.cashreward ), team );
    }
    
    if ( !isdefined( self.tasks[ 0 ].icon ) && !isdefined( self.tasks[ 0 ].objidnum ) )
    {
        return;
    }
    
    self.tasks[ 0 ] endon( #"task_ended" );
    self.tasks[ 0 ] function_57f52e88c7a82e87( team, var_8c953eb201608663, 1 );
}

// Namespace activity_manager
// Params 3
// Checksum 0x9986b0f6, Offset: 0x4bc8
// Size: 0x112
function function_57f52e88c7a82e87( team, var_8c953eb201608663, shouldping )
{
    wait 2.4;
    
    if ( isdefined( self.icon ) )
    {
        dmz_task_utils::function_678cd11cba7c85a9( team );
    }
    else if ( isdefined( self.objidnum ) )
    {
        dmz_task_utils::function_e8e696b0cfb1838e( team );
    }
    
    if ( !isdefined( var_8c953eb201608663 ) )
    {
        return;
    }
    
    if ( shouldping )
    {
        wait 2;
        
        if ( isdefined( self.objidnum ) || isdefined( self.icon ) )
        {
            origin = self.origin;
            
            if ( isdefined( self.iconorigin ) )
            {
                origin = self.iconorigin;
            }
            
            if ( isdefined( self.curorigin ) )
            {
                origin = self.curorigin;
            }
            
            if ( isdefined( self.offset3d ) )
            {
                origin += self.offset3d;
            }
            
            idnum = self.icon ?? self.objidnum;
            objidpoolmanager::objective_set_play_intro( idnum, 0 );
            var_8c953eb201608663 calloutmarkerping::function_5d7b7302e94b97c2( idnum, origin );
        }
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x290ae283, Offset: 0x4ce2
// Size: 0x1d5
function private function_989ab2ce3ed11ab8( team )
{
    if ( !function_52cb56af0d85e094( team ) )
    {
        return;
    }
    
    mainplayer = teams::getteamdata( team, "players" )[ 0 ];
    
    if ( !isdefined( mainplayer ) )
    {
        return;
    }
    
    closestid = level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities[ 0 ];
    closestdist = 100000000;
    
    foreach ( id in level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities )
    {
        activityloc = level.var_f9ba6d6273c5cc67.activities[ id ].origin;
        dist = distancesquared( activityloc, mainplayer.origin );
        assert( isdefined( dist ), "<dev string:x37a>" + level.var_f9ba6d6273c5cc67.activities[ id ].tasks[ 0 ].ref );
        
        if ( dist < closestdist )
        {
            closestdist = dist;
            closestid = id;
        }
    }
    
    if ( !arraycontains( level.var_f9ba6d6273c5cc67.teamsinfo[ team ].trackingids, closestid ) )
    {
        level.var_f9ba6d6273c5cc67.activities[ closestid ] thread function_c95b9a7098d8ec3d( team, mainplayer );
    }
}

// Namespace activity_manager
// Params 0
// Checksum 0xf2d1c772, Offset: 0x4ebf
// Size: 0x177
function activity_onextract()
{
    if ( isdefined( level.var_f9ba6d6273c5cc67.teamsinfo[ self.team ].activities ) )
    {
        foreach ( activityindex in level.var_f9ba6d6273c5cc67.teamsinfo[ self.team ].activities )
        {
            activity = level.var_f9ba6d6273c5cc67.activities[ activityindex ];
            
            foreach ( task in activity.tasks )
            {
                if ( isdefined( task.funcs[ "onExtract" ] ) )
                {
                    task thread [[ task.funcs[ "onExtract" ] ]]( self );
                }
            }
        }
    }
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x30e704b4, Offset: 0x503e
// Size: 0xa5
function private function_60275d3b5b92ba14()
{
    activity = spawnstruct();
    activity.currenttask = 0;
    activity.id = function_e609c0e8102904ba();
    activity.teams = [];
    activity.tasks = [];
    activity.markerradius = 2500;
    activity.var_4b27bec635fbc94b = activity.markerradius * activity.markerradius;
    activity.origin = ( 0, 0, 0 );
    activity.isexclusive = 0;
    return activity;
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x258336d, Offset: 0x50ec
// Size: 0x6f
function private function_e609c0e8102904ba()
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.var_3bea3d8c73535b23 ) )
    {
        level.var_f9ba6d6273c5cc67.var_3bea3d8c73535b23 = 0;
    }
    else
    {
        level.var_f9ba6d6273c5cc67.var_3bea3d8c73535b23 += 1;
    }
    
    return level.var_f9ba6d6273c5cc67.var_3bea3d8c73535b23;
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0xbcfa5124, Offset: 0x5164
// Size: 0x18f
function private function_bd24be4a5abfb781()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 ) )
    {
        waitframe();
    }
    
    var_f1bdd7730d2ef7d3 = 160000;
    function_bebd3db7f356c6cf( var_f1bdd7730d2ef7d3 );
    
    while ( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.origin ) && isdefined( player.team ) && isalive( player ) && ( !function_52cb56af0d85e094( player.team ) || player.canhackcontracts ) )
            {
                closestphone = function_47c86977a18df38b( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877, player.origin, 400 );
                
                if ( isdefined( closestphone ) )
                {
                    player omnvar_utility::setcachedclientomnvar( "ui_dmz_activity_starter_activity_type", closestphone.var_3d8d29dbd1993bc5 );
                    player omnvar_utility::setcachedclientomnvar( "ui_dmz_activity_starter_poi_name", closestphone.poiindex );
                    namespace_84d989e8789e6a05::function_d1aad829093cf458( closestphone, player );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0xf6cdfa0, Offset: 0x52fb
// Size: 0x135
function private function_bebd3db7f356c6cf( mindistancesq )
{
    foreach ( activitystarter in level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 )
    {
        foreach ( var_679b687389d2b100 in level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 )
        {
            if ( activitystarter == var_679b687389d2b100 )
            {
                continue;
            }
            
            if ( distancesquared( activitystarter.origin, var_679b687389d2b100.origin ) <= mindistancesq )
            {
                println( "<dev string:x393>" );
            }
        }
    }
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x835ad08f, Offset: 0x5438
// Size: 0x4d6
function private function_1890c4391d7c65c6()
{
    level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = [];
    var_4fc454782bd1b5fa = [];
    
    foreach ( activity in level.var_f9ba6d6273c5cc67.activities )
    {
        if ( !isdefined( var_4fc454782bd1b5fa[ activity.type ] ) )
        {
            var_4fc454782bd1b5fa[ activity.type ] = [];
        }
        
        var_4fc454782bd1b5fa[ activity.type ][ var_4fc454782bd1b5fa[ activity.type ].size ] = activity;
    }
    
    var_a84257ed4e3a6458 = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "brloot_activity_starter" );
    var_a84257ed4e3a6458 = function_578f9dbb7e4791bf( var_a84257ed4e3a6458 );
    var_bd42be70744d35f2 = [];
    
    foreach ( activitystarter in var_a84257ed4e3a6458 )
    {
        type = getsubstr( activitystarter.type, 24 );
        
        if ( !isdefined( var_bd42be70744d35f2[ type ] ) )
        {
            var_bd42be70744d35f2[ type ] = [];
        }
        
        var_bd42be70744d35f2[ type ][ var_bd42be70744d35f2[ type ].size ] = activitystarter;
    }
    
    foreach ( type, activitylist in var_4fc454782bd1b5fa )
    {
        if ( !isdefined( var_bd42be70744d35f2[ type ] ) )
        {
            assertmsg( "<dev string:x433>" + type + "<dev string:x44d>" );
            continue;
        }
        
        foreach ( activity in activitylist )
        {
            var_bea0d4937c8e7c32 = squared( level.var_f9ba6d6273c5cc67.spawndatamap[ activity.name ].var_7553b36ae672a0b6 );
            var_ca28a825d8aa74ab = squared( level.var_f9ba6d6273c5cc67.spawndatamap[ activity.name ].var_ed0de95c3396b1f1 );
            activitystarter = activity_getbestspawnpoint( var_bd42be70744d35f2[ type ], activity.origin, var_bea0d4937c8e7c32, var_ca28a825d8aa74ab );
            
            if ( isdefined( activitystarter ) )
            {
                var_bd42be70744d35f2[ type ] = arrayremove( var_bd42be70744d35f2[ type ], activitystarter );
                activitystarter.var_5466cf6a45c64069 = int( clamp( distance( activity.origin, activitystarter.origin ) / 200, 1, 100 ) );
                activitystarter.var_3d8d29dbd1993bc5 = function_f01ee87256c40e98( activity.name );
                activitystarter.poiindex = poi::function_98b6b43120545617( poi::poi_findpoioriginisin( activity.origin, undefined, undefined, 1 ) );
                activitystarter.starterpoi = poi::poi_findpoioriginisin( activitystarter.origin, 0, 0, 0 );
                activitystarter.activity = activity;
                activity.activitystarter = activitystarter;
                activitystarter function_a4194904aa550aab();
                level.var_f9ba6d6273c5cc67.var_9433e6119f67c877[ level.var_f9ba6d6273c5cc67.var_9433e6119f67c877.size ] = activitystarter;
                
                /#
                    dmz_logging::addlogevent( "<dev string:x467>", activity.name, "<dev string:x478>", "<dev string:x485>", undefined, activity.id, activity.script_poi, activitystarter.origin );
                    
                    if ( getdvarint( @"hash_458fa5763ddccd6b", 0 ) == 1 )
                    {
                        line( activitystarter.origin, activity.origin, ( 0, 0, 1 ), 1, 0, 20000 );
                        line( activitystarter.origin, activitystarter.origin + ( 0, 0, 3000 ), ( 1, 0, 1 ), 1, 0, 20000 );
                    }
                #/
            }
        }
    }
    
    level notify( #"hash_29296cdcd614b984" );
}

// Namespace activity_manager
// Params 0
// Checksum 0x11e4d6ff, Offset: 0x5916
// Size: 0x3b
function function_a4194904aa550aab()
{
    if ( level.var_f9ba6d6273c5cc67.var_ca2624de39435df5 )
    {
        self setscriptablepartstate( "brloot_activity_starter", "visible" );
        return;
    }
    
    self setscriptablepartstate( "brloot_activity_starter", "visible_no_icon" );
}

// Namespace activity_manager
// Params 0
// Checksum 0x21932850, Offset: 0x5959
// Size: 0x24
function function_2a0e4909a5f9b6a4()
{
    level notify( "tablethide_kill_callout_" + self.origin );
    self setscriptablepartstate( "brloot_activity_starter", "hidden" );
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x925eb5be, Offset: 0x5985
// Size: 0x199
function private function_578f9dbb7e4791bf( locations )
{
    locksandkeys::function_774c7440eb2cceab();
    validlocations = [];
    var_19f8fd52b318c193 = getdvarint( @"hash_b54c660e3e9515b2", 1000 );
    var_26adf1586888b8a3 = var_19f8fd52b318c193 * var_19f8fd52b318c193;
    
    foreach ( location in locations )
    {
        if ( ( !br_dmz_radiation::radiation_isinit() || !br_dmz_radiation::function_704454416dce7454( location.origin ) ) && poi::function_4da557e2eb873ee6( location.origin ) && ( !isdefined( level.uniquedoors ) || level.uniquedoors.size == 0 || distance( sortbydistance( level.uniquedoors, location.origin )[ 0 ].origin, location.origin ) > 350 ) && ( validlocations.size == 0 || distancesquared( sortbydistance( validlocations, location.origin )[ 0 ].origin, location.origin ) > var_26adf1586888b8a3 ) && !ai_fortress::function_f45832ffece5dbb( location.origin ) )
        {
            validlocations[ validlocations.size ] = location;
        }
    }
    
    return validlocations;
}

// Namespace activity_manager
// Params 4, eflags: 0x4
// Checksum 0xfc3ea9c9, Offset: 0x5b27
// Size: 0xfb
function private activity_getbestspawnpoint( structs, origin, mindistancesq, var_cd83f5cfe53ba0d9 )
{
    bestoption = undefined;
    bestdiff = 999999999;
    
    foreach ( struct in structs )
    {
        dist = distancesquared( struct.origin, origin );
        diff = abs( dist - var_cd83f5cfe53ba0d9 );
        
        if ( diff < bestdiff && dist > mindistancesq )
        {
            if ( bestdiff < 150 )
            {
                return struct;
            }
            
            bestoption = struct;
            bestdiff = diff;
        }
    }
    
    return bestoption;
}

// Namespace activity_manager
// Params 1
// Checksum 0x5e72e6b8, Offset: 0x5c2b
// Size: 0x21c
function function_a6448d048cf432e1( player )
{
    if ( !isdefined( level.var_f9ba6d6273c5cc67.activities ) || level.var_f9ba6d6273c5cc67.activities.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_f9ba6d6273c5cc67.scoring ) )
    {
        function_10de9efdc0d10182();
    }
    
    exfils = teams::getteamdata( player.team, "exfils" );
    assert( isdefined( exfils ), "<dev string:x4a1>" + player.team );
    playerorigin = player.origin;
    exfilorigin = undefined;
    var_4716a3bed556494c = undefined;
    scorealignment = 0;
    
    if ( exfils.size > 0 )
    {
        exfilorigin = function_47c86977a18df38b( exfils, playerorigin ).origin;
        var_4716a3bed556494c = exfilorigin - playerorigin;
        scorealignment = distance( exfilorigin, playerorigin ) > 2000;
    }
    
    var_930d3f5c210ab3d8 = sortbydistance( level.var_f9ba6d6273c5cc67.activities, playerorigin );
    var_73623694e54fc406 = [];
    activitiesscored = 0;
    
    for ( index = 0; index < var_930d3f5c210ab3d8.size && activitiesscored < 10 ; index++ )
    {
        activity = var_930d3f5c210ab3d8[ index ];
        
        if ( isdefined( activity.teams[ player.team ] ) )
        {
            continue;
        }
        
        activityorigin = activity.origin;
        score = 0;
        score += function_2a98ca85084b913b( playerorigin, activityorigin );
        
        if ( isdefined( exfilorigin ) )
        {
            score += function_77afbbc932edf638( playerorigin, exfilorigin );
        }
        
        if ( scorealignment )
        {
            score += function_12d607dce6a895b1( playerorigin, activityorigin, var_4716a3bed556494c );
        }
        
        activitiesscored++;
        var_73623694e54fc406[ index ] = score;
    }
    
    if ( activitiesscored <= 0 )
    {
        return;
    }
    
    var_73623694e54fc406 = function_33f22edb1bd946e7( var_73623694e54fc406 );
    chosenindex = function_30717c6dbdefe5ea( var_73623694e54fc406 );
    
    /#
        function_da68525d81c6d5c5( var_930d3f5c210ab3d8, var_73623694e54fc406, chosenindex );
    #/
    
    return var_930d3f5c210ab3d8[ chosenindex ];
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x427737cf, Offset: 0x5e50
// Size: 0xbe
function private function_10de9efdc0d10182()
{
    scoring = spawnstruct();
    scoring.var_5aad03fc27d9ba1d = getdvarfloat( @"hash_c508e27b819d49b2", 0.15 );
    scoring.var_8164a89981c6820c = getdvarfloat( @"hash_58211513a78506af", 0.3 );
    scoring.exfilweight = getdvarfloat( @"hash_c321cda536bc126e", 0.3 );
    scoring.alignmentweight = getdvarfloat( @"hash_7cdac9442bc68fb2", 0.25 );
    scoring.var_fe032ca6577af015 = getdvarfloat( @"hash_f88016cb082a72ec", 0.5 );
    level.var_f9ba6d6273c5cc67.scoring = scoring;
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0xd76b4891, Offset: 0x5f16
// Size: 0xa3
function private function_2a98ca85084b913b( playerorigin, activityorigin )
{
    dist = distance( activityorigin, playerorigin );
    var_69073e8e0135d5fa = ( 15000 - dist ) / 15000;
    var_69073e8e0135d5fa *= level.var_f9ba6d6273c5cc67.scoring.var_5aad03fc27d9ba1d;
    var_634cdbed082ccee9 = ( 40000 - dist ) / 40000;
    var_634cdbed082ccee9 *= level.var_f9ba6d6273c5cc67.scoring.var_8164a89981c6820c;
    return max( 0, var_69073e8e0135d5fa ) + max( 0, var_634cdbed082ccee9 );
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0x78df5aac, Offset: 0x5fc2
// Size: 0x61
function private function_77afbbc932edf638( playerorigin, exfilorigin )
{
    dist = distance( exfilorigin, playerorigin );
    distscore = ( 15000 - dist ) / 15000;
    return max( 0, distscore * level.var_f9ba6d6273c5cc67.scoring.exfilweight );
}

// Namespace activity_manager
// Params 3, eflags: 0x4
// Checksum 0xcdbb7825, Offset: 0x602c
// Size: 0x6c
function private function_12d607dce6a895b1( playerorigin, activityorigin, var_4716a3bed556494c )
{
    var_496d8830cb3ae005 = activityorigin - playerorigin;
    angle = math::anglebetweenvectors( var_496d8830cb3ae005, var_4716a3bed556494c );
    return max( 0, ( 1 - angle / 180 ) * level.var_f9ba6d6273c5cc67.scoring.alignmentweight );
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0x90cb8700, Offset: 0x60a1
// Size: 0x1c8
function private function_33f22edb1bd946e7( var_67698a3a67beb45 )
{
    if ( var_67698a3a67beb45.size <= 1 )
    {
        return var_67698a3a67beb45;
    }
    
    minscore = 100;
    maxscore = -100;
    
    foreach ( score in var_67698a3a67beb45 )
    {
        if ( score < minscore )
        {
            minscore = score;
        }
        
        if ( score > maxscore )
        {
            maxscore = score;
        }
    }
    
    range = maxscore - minscore;
    
    if ( range <= 0 )
    {
        foreach ( key, score in var_67698a3a67beb45 )
        {
            var_67698a3a67beb45[ key ] = 1;
        }
    }
    else
    {
        foreach ( key, score in var_67698a3a67beb45 )
        {
            normalizedscore = max( 0, ( score - minscore ) / range );
            
            if ( normalizedscore < level.var_f9ba6d6273c5cc67.scoring.var_fe032ca6577af015 )
            {
                normalizedscore = 0;
            }
            
            var_67698a3a67beb45[ key ] = normalizedscore;
        }
    }
    
    return var_67698a3a67beb45;
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0xae626f54, Offset: 0x6272
// Size: 0x107
function private function_30717c6dbdefe5ea( var_67698a3a67beb45 )
{
    totalscore = 0;
    
    foreach ( score in var_67698a3a67beb45 )
    {
        totalscore += score;
    }
    
    randomval = randomfloat( totalscore );
    
    foreach ( key, score in var_67698a3a67beb45 )
    {
        randomval -= score;
        
        if ( randomval <= 0 )
        {
            return key;
        }
    }
    
    return key;
}

/#

    // Namespace activity_manager
    // Params 3, eflags: 0x4
    // Checksum 0xa337f887, Offset: 0x6382
    // Size: 0xf1, Type: dev
    function private function_da68525d81c6d5c5( var_930d3f5c210ab3d8, var_73623694e54fc406, chosenindex )
    {
        if ( getdvarint( @"hash_e0b8b49a793faf58", 0 ) == 1 )
        {
            for ( index = 0; index < var_930d3f5c210ab3d8.size ; index++ )
            {
                vectorheight = 1000;
                color = ( 1, 0, 0 );
                activity = var_930d3f5c210ab3d8[ index ];
                
                if ( isdefined( var_73623694e54fc406[ index ] ) )
                {
                    vectorheight += 4000 * var_73623694e54fc406[ index ];
                    
                    if ( index == chosenindex )
                    {
                        color = ( 0, 1, 0 );
                    }
                    else if ( var_73623694e54fc406[ index ] > 0 )
                    {
                        color = ( 0, 0, 1 );
                    }
                }
                
                line( activity.origin, activity.origin + ( 0, 0, vectorheight ), color, 1, 0, 800 );
            }
        }
    }

#/

// Namespace activity_manager
// Params 2
// Checksum 0xb0f777d6, Offset: 0x647b
// Size: 0xb1
function function_89e4869128e7a19a( struct, player )
{
    instance = struct.instance;
    activity = instance.activity;
    level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 = arrayremove( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877, instance );
    instance setscriptablepartstate( "brloot_activity_starter", "hidden" );
    player playlocalsound( "mp_dmz_phone_pickup" );
    player dmz_task_utils::function_ce0c366b96d23996();
    
    if ( isdefined( activity ) )
    {
        activity activity_assign( player.team, undefined, player );
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0x41d508f, Offset: 0x6534
// Size: 0x6a
function function_1b0328fe661260fd( container, player )
{
    container notify( #"stopringing" );
    container dmz_task_utils::function_fc392c6e7813fcf1();
    player dmz_task_utils::function_ce0c366b96d23996( "intel_put_usb_in_tablet" );
    activity = function_a6448d048cf432e1( player );
    
    if ( isdefined( activity ) )
    {
        activity activity_assign( player.team, undefined, player );
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0xc536cdda, Offset: 0x65a6
// Size: 0x93
function function_38a66d429906d908( team, show )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        function_9658fe6aabcb4b6( player, show );
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0x7b601241, Offset: 0x6641
// Size: 0xd1
function function_9658fe6aabcb4b6( player, show )
{
    if ( isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 ) && isdefined( player ) )
    {
        foreach ( starter in level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 )
        {
            if ( show )
            {
                starter enablescriptableplayeruse( player );
                continue;
            }
            
            starter disablescriptableplayeruse( player );
        }
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0xe46fde6c, Offset: 0x671a
// Size: 0x81, Type: bool
function function_52cb56af0d85e094( team )
{
    return isdefined( team ) && isdefined( level.var_f9ba6d6273c5cc67 ) && isdefined( level.var_f9ba6d6273c5cc67.teamsinfo[ team ] ) && isdefined( level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities ) && level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities.size > 0;
}

// Namespace activity_manager
// Params 1
// Checksum 0x68a8d125, Offset: 0x67a4
// Size: 0x4f
function function_a7c6aab0d0a8ba71( player )
{
    if ( !function_52cb56af0d85e094( player.team ) )
    {
        return;
    }
    
    activity = function_25e2a500662e347( player.team );
    
    if ( isdefined( activity ) )
    {
        return activity function_82e26a198ed15088( player );
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0x203da1b, Offset: 0x67fb
// Size: 0xe3, Type: bool
function function_6ca6a856d360b94e( team, fortress )
{
    if ( function_52cb56af0d85e094( team ) )
    {
        foreach ( id in level.var_f9ba6d6273c5cc67.teamsinfo[ team ].activities )
        {
            activity = level.var_f9ba6d6273c5cc67.activities[ id ];
            
            if ( isdefined( activity ) && activity.fortress == fortress )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace activity_manager
// Params 2
// Checksum 0x8559c51c, Offset: 0x68e7
// Size: 0x57
function activity_currenttask( activity, team )
{
    if ( isdefined( activity ) && isdefined( activity.tasks ) && isdefined( activity.teams[ team ] ) )
    {
        return activity.tasks[ activity.teams[ team ] ];
    }
}

// Namespace activity_manager
// Params 2, eflags: 0x4
// Checksum 0x5e9b7453, Offset: 0x6947
// Size: 0x55
function private function_3be785040271bc1f( team, func )
{
    task = activity_currenttask( self, team );
    
    if ( isdefined( task ) && isdefined( task.funcs[ func ] ) )
    {
        task thread [[ task.funcs[ func ] ]]( team );
    }
}

// Namespace activity_manager
// Params 1
// Checksum 0xdc50aa29, Offset: 0x69a4
// Size: 0x45
function function_82e26a198ed15088( player )
{
    if ( isdefined( self.teams[ player.team ] ) )
    {
        return self.tasks[ self.teams[ player.team ] ];
    }
}

// Namespace activity_manager
// Params 1, eflags: 0x4
// Checksum 0xa03edd75, Offset: 0x69f2
// Size: 0x78
function private function_25e2a500662e347( team )
{
    info = level.var_f9ba6d6273c5cc67.teamsinfo[ team ];
    trackingid = info.trackingids[ info.trackingindex ];
    var_7237854e3be197ca = level.var_f9ba6d6273c5cc67.activities[ trackingid ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace activity_manager
// Params 0, eflags: 0x4
// Checksum 0x8f7f92b1, Offset: 0x6a72
// Size: 0x95, Type: bool
function private function_c00e48e59a9eac0()
{
    foreach ( team in self.teams )
    {
        players = teams::getteamdata( team, "players" );
        
        if ( players.size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_manager
// Params 2
// Checksum 0x6cc1a545, Offset: 0x6b10
// Size: 0x168
function function_1a4ef82bc898efb6( team, var_45022aec78c92013 )
{
    task = self;
    players = [];
    
    foreach ( player in task.players )
    {
        if ( !( isdefined( player ) && isdefined( player.team ) ) )
        {
            continue;
        }
        
        var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
        
        if ( var_7537e34d05ee8017 && !var_45022aec78c92013 )
        {
            continue;
        }
        
        var_30e04d37612cbdc3 = arraycontains( task.teams, team );
        var_b37f50f2dbd4d380 = player.team == team;
        var_3d4e295d39e6f5cf = arraycontains( task.teams, player.team );
        
        if ( isdefined( team ) && !var_30e04d37612cbdc3 )
        {
            continue;
        }
        
        if ( isdefined( team ) && !var_b37f50f2dbd4d380 )
        {
            continue;
        }
        
        if ( !isdefined( team ) && !var_3d4e295d39e6f5cf )
        {
            continue;
        }
        
        players[ players.size ] = player;
    }
    
    return players;
}

// Namespace activity_manager
// Params 1
// Checksum 0xbdebae82, Offset: 0x6c81
// Size: 0xc2
function function_483220f91c7432ff( team )
{
    if ( !isdefined( self.var_e702f7ee6139a98d ) )
    {
        self.var_e702f7ee6139a98d = [];
    }
    
    numplayers = 0;
    playersonteam = teams::getsquadmates( team, undefined, 1 );
    
    foreach ( player in playersonteam )
    {
        if ( arraycontains( self.var_e702f7ee6139a98d, player ) )
        {
            numplayers++;
        }
    }
    
    return numplayers;
}

// Namespace activity_manager
// Params 1
// Checksum 0xe853e3f1, Offset: 0x6d4c
// Size: 0x144, Type: bool
function function_b3084af09c057a1c( team )
{
    if ( !isdefined( self.var_e702f7ee6139a98d ) )
    {
        self.var_e702f7ee6139a98d = [];
    }
    
    playersonteam = teams::getsquadmates( team, undefined, 1 );
    
    if ( function_483220f91c7432ff( team ) == playersonteam.size )
    {
        if ( !self.tasks[ 0 ].var_915be4e8320e7b88 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"mission_cancel_complete", team, 1 );
        }
        
        self.tasks[ 0 ] function_5abb1c2f65633a8f( team );
        
        foreach ( player in playersonteam )
        {
            player setclientomnvar( "ui_br_contract_cancellation_state", 0 );
        }
        
        if ( !self.tasks[ 0 ].var_80d42eaedca52d3c )
        {
            br_gametype_dmz::showdmzsplash( "dmz_contract_cancelled_" + self.type, playersonteam );
        }
        
        return true;
    }
    
    return false;
}

// Namespace activity_manager
// Params 0
// Checksum 0x1ba7520c, Offset: 0x6e99
// Size: 0x1e4
function function_dd0946f1bbae40f3()
{
    if ( isdefined( self ) && isdefined( self.team ) && function_52cb56af0d85e094( self.team ) )
    {
        activity = function_25e2a500662e347( self.team );
        
        if ( !isdefined( activity ) )
        {
            assertmsg( "<dev string:x4d9>" );
            return;
        }
        
        if ( !isdefined( activity.var_e702f7ee6139a98d ) )
        {
            activity.var_e702f7ee6139a98d = [];
        }
        
        if ( arraycontains( activity.var_e702f7ee6139a98d, self ) )
        {
            activity function_b3084af09c057a1c( self.team );
            return;
        }
        
        activity.var_e702f7ee6139a98d[ activity.var_e702f7ee6139a98d.size ] = self;
        
        if ( !activity function_b3084af09c057a1c( self.team ) )
        {
            squadmates = teams::getsquadmates( self.team, undefined, 1 );
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"mission_cancel_request", arrayremove( squadmates, activity.var_e702f7ee6139a98d ) );
            var_196ba86d7faa9e2b = activity function_483220f91c7432ff( self.team );
            totalplayers = squadmates.size;
            combineddata = var_196ba86d7faa9e2b | totalplayers << 3;
            
            foreach ( player in squadmates )
            {
                player setclientomnvar( "ui_br_contract_cancellation_state", combineddata );
            }
            
            br_gametype_dmz::showdmzsplash( "dmz_contract_pending_" + activity.type, squadmates, undefined, combineddata );
        }
    }
}

// Namespace activity_manager
// Params 2
// Checksum 0xbeadf6bc, Offset: 0x7085
// Size: 0x3b
function function_d0e6047d9a07b7fb( notification, value )
{
    if ( isdefined( notification ) )
    {
        switch ( notification )
        {
            case #"hash_9fd64c8b171158f":
                function_dd0946f1bbae40f3();
                break;
        }
    }
}

