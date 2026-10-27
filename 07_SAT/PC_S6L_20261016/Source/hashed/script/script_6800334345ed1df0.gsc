// script_6800334345ed1df0  (hash_6800334345ed1df0.gscc) (size: 8492 Bytes / 0x212c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed920a27 (3985771047)
// size ...... 8492 (0x212c)
// includes .. 13  (offset: 0x1df0)
// strings ... 36  (offset: 0x1e58)
// dev strs .. 10  (offset: 0x20a0)
// exports ... 19  (offset: 0x1440)
// cseg ...... 0x22c + 0x1214 (0x1440)
// imports ... 53  (offset: 0x1738)
// animtree1 . 0   (offset: 0x212c)
// animtree2 . 0   (offset: 0x212c)
#using script_382bf8d77c4fd348;
#using scripts\common\callback_sequence;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\bots\bots;
#using scripts\mp\challenges;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\game;
#using scripts\mp\gameinstance;
#using scripts\mp\matchdata;
#using scripts\mp\spawnlogic;

#namespace captureflag;

// Namespace captureflag
// Params 1
// Checksum 0x2ceca9ff, Offset: 0x24a
// Size: 0x200
function function_dfdb63cdb68b35ec( gameobject )
{
    assert( isdefined( gameobject ) );
    
    if ( !istrue( gameobject.type_hash == #"gameobject_type_capture_zone" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_capture_zone" + "<dev string:x57>" + "<dev string:x59>" + gameobject.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_capture_zone" + "'" + " { name_hash: " + gameobject.name_hash + " }" );
    }
    
    initialize();
    gameobject.firstcapture = 1;
    
    if ( !isdefined( gameobject.visuals ) )
    {
        gameobjectorigin = gameobjects_common::get_origin( gameobject );
        gameobject.visuals = spawn( "script_model", gameobjectorigin );
        gameobject.visuals.origin = utility::drop_to_ground( gameobjectorigin, 64, -1024 );
        gameobject.visuals.angles = gameobjects_common::function_63e25df7cfbb206f( gameobject );
    }
    
    var_543da7845de195ab = namespace_277c922f0d0dc523::function_9b71aa2788e21706( gameobject );
    function_2f5a0683907d1765( gameobject, var_543da7845de195ab );
    gameobject callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_57c7b8c8361be591 );
    gameobject callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_935dfc4d76554a89 );
    gameobject callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &onusecomplete );
    gameobject callback::function_dc654a4d4126a928( #"hash_33ab895f04e4eec9", #"hash_6947ec89a1af6d69", &onneutralized );
    gameobject callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &oncaptured );
    initializematchrecording( gameobject );
}

// Namespace captureflag
// Params 2
// Checksum 0x2ef3da70, Offset: 0x452
// Size: 0x153
function function_ae0c1c2a2553b7d( team, var_52f8cab5b8464b55 )
{
    assert( isdefined( team ) && isdefined( var_52f8cab5b8464b55 ) );
    initialize();
    instanceid = gameinstance::get_instance_id( team );
    flagcount = 0;
    
    foreach ( gameobject in game_utility_mp::get_gametype_objectives( instanceid ) )
    {
        if ( var_52f8cab5b8464b55 && namespace_277c922f0d0dc523::is_contested( gameobject ) )
        {
            continue;
        }
        
        if ( namespace_277c922f0d0dc523::function_9b71aa2788e21706( gameobject ) == ( team == "all" || team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team ) ? #"hash_ce911e3bbe99421f" : team == "none" || team == "neutral" ? #"hash_bb332da19f9944df" : undefined ) )
        {
            flagcount++;
        }
    }
    
    return flagcount;
}

// Namespace captureflag
// Params 0, eflags: 0x4
// Checksum 0x5fdf61ee, Offset: 0x5ae
// Size: 0x7c
function private initialize()
{
    if ( is_initialized() )
    {
        return;
    }
    
    level.var_b8108e132d830f23 = game_utility_mp::function_4b7180ed8c2e9742( #"hash_5bccb32d8d8ad086" );
    assert( isdefined( level.var_b8108e132d830f23 ), "<dev string:x6b>" );
    
    /#
        level.var_b8108e132d830f23.development = { #setcaptured:&devsetcaptured, #setneutral:&devsetneutral };
    #/
    
    level.lastcaptime = gettime();
}

// Namespace captureflag
// Params 0, eflags: 0x4
// Checksum 0xb91520, Offset: 0x632
// Size: 0xc, Type: bool
function private is_initialized()
{
    return isdefined( level.var_b8108e132d830f23 );
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x9858b13, Offset: 0x647
// Size: 0x1cf
function private initializematchrecording( gameobject )
{
    assert( isdefined( gameobject ) );
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        assert( isdefined( level.matchrecording_generateid ), "<dev string:xaa>" );
        gameobject.logid = [[ level.matchrecording_generateid ]]();
        flagletter = "A";
        
        switch ( gameobject )
        {
            case #"hash_fac2c5f6bddd49bd":
                flagletter = "A";
                break;
            case #"hash_fac2c2f6bddd4504":
                flagletter = "B";
                break;
            case #"hash_fac2c3f6bddd4697":
                flagletter = "C";
                break;
            case #"hash_fac2c0f6bddd41de":
                flagletter = "D";
                break;
            case #"hash_fac2c1f6bddd4371":
                flagletter = "E";
                break;
            case #"hash_311010bc01bd3a0f":
                flagletter = "0";
                break;
            case #"hash_31100fbc01bd387c":
                flagletter = "1";
                break;
            case #"hash_311012bc01bd3d35":
                flagletter = "2";
                break;
            case #"hash_311011bc01bd3ba2":
                flagletter = "3";
                break;
            case #"hash_31100cbc01bd33c3":
                flagletter = "4";
                break;
            default:
                assertmsg( "<dev string:xdb>" + gameobject.objective_key + "<dev string:x57>" );
                break;
        }
        
        gameobject.logeventflag = "FLAG_" + flagletter;
    }
    
    if ( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() )
    {
        gameobject.analyticslogid = analyticslog::getuniqueobjectid();
        gameobject.analyticslogtype = "dom_flag" + gameobject.objective_key;
    }
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x987d9bfe, Offset: 0x81e
// Size: 0x3c
function private function_57c7b8c8361be591( params )
{
    assert( isdefined( params ) );
    player = params.player;
    player.isonobjective = 1;
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x54adffeb, Offset: 0x862
// Size: 0x39
function private function_935dfc4d76554a89( params )
{
    assert( isdefined( params ) );
    player = params.player;
    player.isonobjective = undefined;
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x6a62f641, Offset: 0x8a3
// Size: 0x24
function private onusecomplete( params )
{
    assert( isdefined( params ) );
    level.lastcaptime = gettime();
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0xfca60e7a, Offset: 0x8cf
// Size: 0x112
function private onneutralized( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    function_ef5f1ea5fe5a2a14( gameobject );
    flagorigin = gameobjects_common::get_origin( gameobject );
    utility::trycall( level.matchrecording_logevent, gameobject.logid, undefined, gameobject.logeventflag, flagorigin[ 0 ], flagorigin[ 1 ], gettime(), 0 );
    analyticslog::logevent_gameobject( gameobject.analyticslogtype, gameobject.analyticslogid, flagorigin, -1, "neutral" );
    gameobject notify( #"neutralized" );
    level notify( #"domflag_neutralized", gameobject.objective_key );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", gameobject.objective_key, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0xf4b21bb9, Offset: 0x9e9
// Size: 0x38f
function private oncaptured( params )
{
    assert( isdefined( params ) );
    gameobject = params.game_object;
    team = params.team_name;
    var_3d152e00ebf9f46d = params.var_dbd0d4c325a7ae15;
    var_380e1341c05f576b = params.var_2b03add3a518dea6;
    gameobject.firstcapture = 0;
    function_9c9b39bea5844c01( gameobject, team );
    teamhash = team == "all" || team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( team ) ? #"hash_ce911e3bbe99421f" : team == "none" || team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    function_2f5a0683907d1765( gameobject, teamhash );
    
    if ( !isagent( var_3d152e00ebf9f46d ) || bots::function_e8c1a1cd1aaa5f82( var_3d152e00ebf9f46d ) )
    {
        telemetrystruct = spawnstruct();
        telemetrystruct.player = var_3d152e00ebf9f46d;
        telemetrystruct.eventname = "capture";
        telemetrystruct.position = var_3d152e00ebf9f46d.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetrystruct );
    }
    
    foreach ( var_30fcb423957c4d9a in var_380e1341c05f576b )
    {
        challenges::function_a3678ff124a05f01( var_30fcb423957c4d9a );
    }
    
    switch ( gameobject.objective_key )
    {
        case #"hash_fac2c5f6bddd49bd":
            codcaster_utils::function_3038b6eafc46c037( 21, team, var_3d152e00ebf9f46d getentitynumber(), 1 );
            break;
        case #"hash_fac2c2f6bddd4504":
            codcaster_utils::function_3038b6eafc46c037( 21, team, var_3d152e00ebf9f46d getentitynumber(), 2 );
            break;
        case #"hash_fac2c3f6bddd4697":
            codcaster_utils::function_3038b6eafc46c037( 21, team, var_3d152e00ebf9f46d getentitynumber(), 3 );
            break;
        case #"hash_fac2c0f6bddd41de":
            codcaster_utils::function_3038b6eafc46c037( 21, team, var_3d152e00ebf9f46d getentitynumber(), 4 );
            break;
        case #"hash_fac2c1f6bddd4371":
            codcaster_utils::function_3038b6eafc46c037( 21, team, var_3d152e00ebf9f46d getentitynumber(), 5 );
            break;
    }
    
    flagorigin = gameobjects_common::get_origin( gameobject );
    utility::trycall( level.matchrecording_logevent, gameobject.logid, team, gameobject.logeventflag, flagorigin[ 0 ], flagorigin[ 1 ], gettime(), team == "allies" ? 1 : 2 );
    analyticslog::logevent_gameobject( gameobject.analyticslogtype, gameobject.analyticslogid, flagorigin, -1, "captured_" + team );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", gameobject.objective_key, "team", team, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    gameobject notify( #"captured" );
    level notify( #"domflag_captured", gameobject.objective_key );
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0xbc65bc76, Offset: 0xd80
// Size: 0x68
function private function_a4fd7d664e5d91ba( gameobject )
{
    assert( isdefined( gameobject ) );
    
    switch ( gameobject.objective_key )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 6;
        case #"hash_fac2c2f6bddd4504":
            return 7;
        case #"hash_fac2c3f6bddd4697":
            return 8;
        default:
            break;
    }
    
    return 9;
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x48e140bc, Offset: 0xdf1
// Size: 0x2f
function private function_ef5f1ea5fe5a2a14( gameobject )
{
    assert( isdefined( gameobject ) );
    createspawninfluencers( gameobject, [ "neutral" ], "none" );
}

// Namespace captureflag
// Params 2, eflags: 0x4
// Checksum 0x398fa732, Offset: 0xe28
// Size: 0x44
function private function_9c9b39bea5844c01( gameobject, team )
{
    assert( isdefined( gameobject ) && isdefined( team ) );
    createspawninfluencers( gameobject, [ "other", "owner" ], team );
}

// Namespace captureflag
// Params 3, eflags: 0x4
// Checksum 0x4e696925, Offset: 0xe74
// Size: 0x1ae
function private createspawninfluencers( gameobject, keys, team )
{
    assert( isdefined( gameobject ) && isdefined( keys ) && isdefined( team ) );
    removespawninfluencers( gameobject );
    
    if ( !isdefined( gameobject.spawnset ) )
    {
        return;
    }
    
    flagorigin = gameobjects_common::get_origin( gameobject );
    
    foreach ( key in keys )
    {
        if ( !isdefined( gameobject.influencerkeys[ key ] ) )
        {
            continue;
        }
        
        if ( !isdefined( gameobject.spawninfluencers ) )
        {
            gameobject.spawninfluencers = [];
        }
        
        gameobject.spawninfluencers[ gameobject.spawninfluencers.size ] = spawnlogic::addspawninfluencer( gameobject.influencerkeys[ key ], flagorigin, team );
    }
    
    foreach ( spawninfluencer in gameobject.spawninfluencers )
    {
        spawnlogic::influencersetspawnpointlist( spawninfluencer, gameobject.spawnset );
    }
}

// Namespace captureflag
// Params 1, eflags: 0x4
// Checksum 0x4319ee8d, Offset: 0x102a
// Size: 0xae
function private removespawninfluencers( gameobject )
{
    assert( isdefined( gameobject ) );
    
    if ( !isdefined( gameobject.spawninfluencers ) )
    {
        return;
    }
    
    foreach ( spawninfluencer in gameobject.spawninfluencers )
    {
        spawnlogic::removespawninfluencer( spawninfluencer );
    }
    
    gameobject.spawninfluencers = undefined;
}

// Namespace captureflag
// Params 2, eflags: 0x4
// Checksum 0xc17e81d6, Offset: 0x10e0
// Size: 0x2f5
function private function_2f5a0683907d1765( gameobject, teamhash )
{
    if ( !istrue( isdefined( teamhash == #"hash_a1360b18943e920" ? "all" : teamhash == #"hash_7118f9343873352b" ? game_utility_mp::get_attacker_team( gameobject.instance_id ) : teamhash == #"hash_ce911e3bbe99421f" ? game_utility_mp::get_defender_team( gameobject.instance_id ) : teamhash == #"hash_bb332da19f9944df" ? "none" : undefined ) ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xfc>" + teamhash + "<dev string:x57>" + "<dev string:x59>" + gameobject.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Invalid game object use team hash '" + teamhash + "'" + " { name_hash: " + gameobject.name_hash + " }" );
    }
    
    var_9e00a4079b9afb0 = game[ "attackers" ] == "all" || game[ "attackers" ] == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( game[ "attackers" ] ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( game[ "attackers" ] ) ? #"hash_ce911e3bbe99421f" : game[ "attackers" ] == "none" || game[ "attackers" ] == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == var_9e00a4079b9afb0 )
    {
        if ( isdefined( level.var_b8108e132d830f23.var_bf1a4751387ea118 ) )
        {
            gameobject.visuals setmodel( level.var_b8108e132d830f23.var_bf1a4751387ea118 );
        }
        
        return;
    }
    
    var_2606aaa798dd97f4 = game[ "defenders" ] == "all" || game[ "defenders" ] == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( game[ "defenders" ] ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( game[ "defenders" ] ) ? #"hash_ce911e3bbe99421f" : game[ "defenders" ] == "none" || game[ "defenders" ] == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( teamhash == var_2606aaa798dd97f4 )
    {
        if ( isdefined( level.var_b8108e132d830f23.defenderflagmodel ) )
        {
            gameobject.visuals setmodel( level.var_b8108e132d830f23.defenderflagmodel );
        }
        
        return;
    }
    
    if ( isdefined( level.var_b8108e132d830f23.var_834f51977cd32b4c ) )
    {
        gameobject.visuals setmodel( level.var_b8108e132d830f23.var_834f51977cd32b4c );
    }
}

/#

    // Namespace captureflag
    // Params 1, eflags: 0x4
    // Checksum 0x8191c160, Offset: 0x13dd
    // Size: 0x28, Type: dev
    function private devsetneutral( gameobject )
    {
        assert( isdefined( gameobject ) );
        namespace_277c922f0d0dc523::function_5e0c23aa66d30871( gameobject, "<dev string:x120>" );
    }

    // Namespace captureflag
    // Params 2, eflags: 0x4
    // Checksum 0xa6c65ef2, Offset: 0x140d
    // Size: 0x33, Type: dev
    function private devsetcaptured( gameobject, teamname )
    {
        assert( isdefined( gameobject ) && isdefined( teamname ) );
        namespace_277c922f0d0dc523::function_5e0c23aa66d30871( gameobject, teamname );
    }

#/
