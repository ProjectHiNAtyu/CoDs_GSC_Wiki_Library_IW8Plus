// scripts\mp\common\killstreaks\uav_bigmap.gsc  (hash_40ba88e19d658263.gscc) (size: 11048 Bytes / 0x2b28 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5fa03463 (1604334691)
// size ...... 11048 (0x2b28)
// includes .. 9   (offset: 0x29b0)
// strings ... 20  (offset: 0x29f8)
// dev strs .. 2   (offset: 0x2b0c)
// exports ... 28  (offset: 0x1d94)
// cseg ...... 0x1b0 + 0x1be4 (0x1d94)
// imports ... 64  (offset: 0x21f4)
// animtree1 . 0   (offset: 0x2b28)
// animtree2 . 0   (offset: 0x2b28)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;

#namespace uav_bigmap;

// Namespace uav_bigmap
// Params 0
// Checksum 0xa708acc9, Offset: 0x1ce
// Size: 0x83
function init()
{
    if ( !level.gamemodebundle.var_e876c69bd1505313 )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"uav_bigmap", #"init" ) )
    {
        [[ utility::getsharedfunc( #"uav_bigmap", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"uav_bigmap", #"hash_acaf7bc0b1152d15", &function_f133891d6d0f96d0 );
    init_uav_bigmap_vo();
    init_uav_bigmap_manager();
    function_7588e4ffc24f59bd();
}

// Namespace uav_bigmap
// Params 0
// Checksum 0xdf428cc1, Offset: 0x259
// Size: 0x4d
function init_uav_bigmap_vo()
{
    game[ "dialog" ][ "uav_bigmap_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "uav_bigmap_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "uav_bigmap_destroyed" ] = "killstreak_remote_operator" + "_crash";
}

// Namespace uav_bigmap
// Params 0
// Checksum 0x19402048, Offset: 0x2ae
// Size: 0x28
function init_uav_bigmap_manager()
{
    level.var_97592a5d2d301d66 = [];
    
    if ( level.var_f3d1cde89907a07a )
    {
        level thread function_ec35adbea6877503();
    }
    
    level thread function_df9ba601bfa0836d();
}

// Namespace uav_bigmap
// Params 0
// Checksum 0xd4bd61ff, Offset: 0x2de
// Size: 0xc, Type: bool
function function_cdd5542320f92744()
{
    return isdefined( level.var_97592a5d2d301d66 );
}

// Namespace uav_bigmap
// Params 0
// Checksum 0x48c00dd0, Offset: 0x2f3
// Size: 0x2c
function function_ec35adbea6877503()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player thread function_c9589f478c719208();
    }
}

// Namespace uav_bigmap
// Params 0
// Checksum 0xa3e552f0, Offset: 0x327
// Size: 0x5b
function function_c9589f478c719208()
{
    self endon( #"disconnect" );
    
    while ( !isdefined( self.sessionsquadid ) || self.sessionsquadid == 1 )
    {
        waitframe();
    }
    
    if ( !isdefined( level.var_97592a5d2d301d66[ self.sessionsquadid ] ) )
    {
        level.var_97592a5d2d301d66[ self.sessionsquadid ] = [];
    }
}

// Namespace uav_bigmap
// Params 0
// Checksum 0xd67cb52a, Offset: 0x38a
// Size: 0x42
function function_7588e4ffc24f59bd()
{
    level.var_944be9a343c2d532 = [];
    level.var_2bd5b97e4da21a38 = getdvarint( @"hash_edc4fc6257558716", 0 );
    level.var_2fde8bfecaf815ae = getdvarint( @"hash_6892d0cc92ee7da1", 0 );
    level thread function_11da248897945625();
}

// Namespace uav_bigmap
// Params 0
// Checksum 0xf1cab4d, Offset: 0x3d4
// Size: 0x4a8
function function_df9ba601bfa0836d()
{
    level endon( #"game_ended" );
    var_cd54403f6796a783 = 0;
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( var_507804a13c031220, teamarray in level.var_97592a5d2d301d66 )
        {
            if ( teamarray.size > 0 )
            {
                cleanarray = 0;
                
                foreach ( i, uavstruct in teamarray )
                {
                    if ( !isdefined( uavstruct ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( uavstruct.owner ) )
                    {
                        teamarray[ i ] = undefined;
                        cleanarray = 1;
                        continue;
                    }
                    
                    removeuav = 0;
                    
                    for ( index = uavstruct.starttimes.size - 1; index >= 0 ; index-- )
                    {
                        if ( uavstruct.starttimes[ index ] + uavstruct.duration * 1000 < currenttime )
                        {
                            starttime = uavstruct.starttimes[ index ];
                            streakinfo = uavstruct.var_589794fde22c2da1[ starttime ];
                            level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
                            uavstruct.starttimes[ index ] = undefined;
                            uavstruct.owner killstreak_utility::recordkillstreakendstats( uavstruct.streakinfo );
                            uavstruct.owner.activeuavcount--;
                            uavstruct.owner killstreak_utility::playkillstreaktacomdialog( uavstruct.streakinfo, "uav_leave", #"leave", 1 );
                            
                            /#
                                if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
                                {
                                    [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>", uavstruct.owner );
                                }
                            #/
                            
                            removeuav = 1;
                        }
                    }
                    
                    if ( removeuav )
                    {
                        uavstruct.starttimes = function_5713d46873b29625( uavstruct.starttimes );
                    }
                    
                    if ( uavstruct.starttimes.size == 0 )
                    {
                        teamarray[ i ] = undefined;
                        cleanarray = 1;
                        continue;
                    }
                    
                    if ( !player::isreallyalive( uavstruct.owner ) )
                    {
                        teamarray[ i ] = undefined;
                        cleanarray = 1;
                    }
                }
                
                if ( cleanarray )
                {
                    level.var_97592a5d2d301d66[ var_507804a13c031220 ] = function_5713d46873b29625( teamarray );
                    teammates = level.teamdata[ var_507804a13c031220 ][ "players" ];
                    var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
                    
                    if ( isdefined( var_ec86cf09b79859c3 ) )
                    {
                        level [[ var_ec86cf09b79859c3 ]]( teammates );
                    }
                    
                    if ( level.var_97592a5d2d301d66[ var_507804a13c031220 ].size == 0 )
                    {
                        level.var_97592a5d2d301d66[ var_507804a13c031220 ] = undefined;
                        var_cd54403f6796a783 = 1;
                    }
                }
                
                foreach ( uavstruct in level.var_97592a5d2d301d66[ var_507804a13c031220 ] )
                {
                    uavcount = uavstruct.starttimes.size;
                    var_ce9dfd21b51750df = uavstruct.sweepinterval * 1000;
                    
                    if ( uavstruct.lastpingtime + var_ce9dfd21b51750df / uavcount < currenttime )
                    {
                        function_7359f721a496db01( uavstruct );
                        function_c0b3b2a1f1e2ac5e( uavstruct.owner.team, uavstruct.owner.origin, uavstruct.radius, uavstruct.sweepinterval + 0.05 );
                    }
                }
            }
        }
        
        if ( var_cd54403f6796a783 )
        {
            level.var_97592a5d2d301d66 = function_f943bef551ff028c( level.var_97592a5d2d301d66 );
            var_cd54403f6796a783 = 0;
        }
        
        waitframe();
    }
}

// Namespace uav_bigmap
// Params 2
// Checksum 0xfb4a9b0d, Offset: 0x884
// Size: 0xe2, Type: bool
function function_45375faf54fa8ecc( owner, victim )
{
    if ( !function_cdd5542320f92744() )
    {
        return false;
    }
    
    var_507804a13c031220 = level.var_f3d1cde89907a07a ? owner.sessionsquadid : owner.team;
    
    for ( playeridx = 0; playeridx < level.var_97592a5d2d301d66[ var_507804a13c031220 ].size ; playeridx++ )
    {
        uavstruct = level.var_97592a5d2d301d66[ var_507804a13c031220 ][ playeridx ];
        uavcount = uavstruct.starttimes.size;
        
        if ( uavcount > 0 && distance2d( uavstruct.owner.origin, victim.origin ) < uavstruct.radius )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xc3f6325e, Offset: 0x96f
// Size: 0x16f
function function_f133891d6d0f96d0( cuavradius )
{
    if ( !function_cdd5542320f92744() )
    {
        return;
    }
    
    var_10512c58ef1a1a53 = level.var_f3d1cde89907a07a ? self.sessionsquadid : self.team;
    
    foreach ( var_507804a13c031220, teamarray in level.var_97592a5d2d301d66 )
    {
        if ( var_507804a13c031220 == var_10512c58ef1a1a53 )
        {
            continue;
        }
        
        foreach ( uavstruct in teamarray )
        {
            if ( uavstruct.starttimes.size > 0 && distance2dsquared( uavstruct.owner.origin, self.origin ) < cuavradius * cuavradius )
            {
                thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"cuav_blackout" );
            }
        }
    }
}

// Namespace uav_bigmap
// Params 2
// Checksum 0x2aa14c58, Offset: 0xae6
// Size: 0xb0
function function_ba754e08de8b60cf( players, duration )
{
    pingexpiration = gettime() + duration * 1000;
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        function_9540ab0c97dfef52( player, pingexpiration );
    }
}

// Namespace uav_bigmap
// Params 4
// Checksum 0x8502a86c, Offset: 0xb9e
// Size: 0xe7
function function_c0b3b2a1f1e2ac5e( ownerteam, pinglocation, pingradius, duration )
{
    if ( level.var_2bd5b97e4da21a38 || !isbrgamemode() )
    {
        return;
    }
    
    pingexpiration = gettime() + duration * 1000;
    var_ada04fdfc33eed26 = getplayersinradius( pinglocation, pingradius );
    
    foreach ( player in var_ada04fdfc33eed26 )
    {
        if ( player.team != ownerteam )
        {
            function_9540ab0c97dfef52( player, pingexpiration );
        }
    }
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xa879de65, Offset: 0xc8d
// Size: 0xe5
function function_398f10fa41a95950( ownerteam )
{
    if ( level.var_2fde8bfecaf815ae || !isbrgamemode() )
    {
        return;
    }
    
    duration = level.uavsettings[ "directional_uav" ].timeout;
    currentend = gettime() + duration * 1000;
    
    foreach ( player in level.players )
    {
        if ( player.team != ownerteam )
        {
            function_9540ab0c97dfef52( player, currentend );
        }
    }
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xcf5be25c, Offset: 0xd7a
// Size: 0x1e
function function_aa02db0d280b765d( duration )
{
    function_ba754e08de8b60cf( level.players, duration );
}

// Namespace uav_bigmap
// Params 2, eflags: 0x4
// Checksum 0xb7b020d, Offset: 0xda0
// Size: 0xe1
function private function_9540ab0c97dfef52( player, pingexpiration )
{
    player setclientomnvar( "ui_br_under_uav", 1 );
    
    if ( !isdefined( level.var_944be9a343c2d532 ) )
    {
        level.var_944be9a343c2d532 = [];
    }
    
    var_af8ae404de135379 = player getentitynumber();
    
    if ( isdefined( level.var_944be9a343c2d532[ var_af8ae404de135379 ] ) )
    {
        if ( pingexpiration > level.var_944be9a343c2d532[ var_af8ae404de135379 ].pingexpiration )
        {
            level.var_944be9a343c2d532[ var_af8ae404de135379 ].player = player;
            level.var_944be9a343c2d532[ var_af8ae404de135379 ].pingexpiration = pingexpiration;
        }
        
        return;
    }
    
    pingstruct = spawnstruct();
    pingstruct.player = player;
    pingstruct.pingexpiration = pingexpiration;
    level.var_944be9a343c2d532[ var_af8ae404de135379 ] = pingstruct;
}

// Namespace uav_bigmap
// Params 0, eflags: 0x4
// Checksum 0x2791c96c, Offset: 0xe89
// Size: 0x130
function private function_11da248897945625()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_944be9a343c2d532 ) )
    {
        level.var_944be9a343c2d532 = [];
    }
    
    while ( true )
    {
        if ( level.var_944be9a343c2d532.size > 0 )
        {
            currenttime = gettime();
            keys = getarraykeys( level.var_944be9a343c2d532 );
            
            foreach ( key in keys )
            {
                if ( level.var_944be9a343c2d532[ key ].pingexpiration < currenttime )
                {
                    if ( isplayer( level.var_944be9a343c2d532[ key ].player ) )
                    {
                        level.var_944be9a343c2d532[ key ].player setclientomnvar( "ui_br_under_uav", 0 );
                    }
                    
                    level.var_944be9a343c2d532[ key ] = undefined;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace uav_bigmap
// Params 1
// Checksum 0x73720960, Offset: 0xfc1
// Size: 0x142, Type: bool
function function_752a6b34640a086b( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !level.gamemodebundle.var_e876c69bd1505313 )
    {
        assertmsg( "<dev string:x3b>" );
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "uav" ];
    deploymentweapon = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deploymentweapon ) );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "uav", self.origin );
    }
    
    function_41b1964ddad116a9( self, streakinfo );
    return true;
}

// Namespace uav_bigmap
// Params 2
// Checksum 0x14c9774c, Offset: 0x110c
// Size: 0x350
function function_41b1964ddad116a9( owner, streakinfo )
{
    if ( !level.gamemodebundle.var_e876c69bd1505313 )
    {
        assertmsg( "<dev string:x3b>" );
        return;
    }
    
    if ( !isdefined( level.var_97592a5d2d301d66 ) )
    {
        level thread init();
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        owner [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, "uavUsed" );
    }
    
    calloutsplash = level.uavsettings[ "uav" ].teamsplash;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( calloutsplash, owner );
    }
    
    idx = level.var_f3d1cde89907a07a ? owner.sessionsquadid : owner.team;
    var_18c1f81cbb0c3240 = function_e900240ba503213c( idx );
    
    if ( var_18c1f81cbb0c3240 + 1 >= getdvarint( @"hash_306f1f0806522199", 4 ) )
    {
        if ( function_6762aa74e2508325( owner ) )
        {
            level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
            function_f2fbdd0338461bcb( idx );
            function_398f10fa41a95950( owner.team );
            challenges::function_37e945722d6497f3( owner, "br_three_uav", 1 );
            return;
        }
    }
    
    vostreakname = streakinfo.streakname;
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        owner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( vostreakname );
        var_65934120c2efeb81 = 2;
    }
    
    isbr = isbrgamemode();
    
    if ( isbr )
    {
        killstreak_utility::killstreak_dangernotifyplayersinrange( owner, owner.team, 11600, vostreakname, undefined, isbrgamemode() ? 6000 : 1000 );
    }
    else
    {
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, vostreakname + "_use", #"use", 1, var_65934120c2efeb81 );
    }
    
    playerstruct = function_17f93121881b4278( owner );
    
    if ( isdefined( playerstruct ) )
    {
        ts = gettime();
        playerstruct.starttimes[ playerstruct.starttimes.size ] = ts;
        playerstruct.var_589794fde22c2da1[ ts ] = streakinfo;
    }
    else
    {
        function_f037a15a80f0ca5d( owner, streakinfo );
    }
    
    if ( !isdefined( owner.activeuavcount ) )
    {
        owner.activeuavcount = 0;
    }
    
    owner.activeuavcount++;
    idx = level.var_f3d1cde89907a07a ? owner.sessionsquadid : owner.team;
    teammates = player_utility::getteamarray( idx );
    var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
    
    if ( isdefined( var_ec86cf09b79859c3 ) )
    {
        level [[ var_ec86cf09b79859c3 ]]( teammates );
    }
}

// Namespace uav_bigmap
// Params 1
// Checksum 0x1b10b416, Offset: 0x1464
// Size: 0xad
function function_e900240ba503213c( idx )
{
    uavcount = 0;
    
    if ( isdefined( level.var_97592a5d2d301d66[ idx ] ) )
    {
        foreach ( struct in level.var_97592a5d2d301d66[ idx ] )
        {
            uavcount += struct.starttimes.size;
        }
    }
    
    return uavcount;
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xf63fb1f0, Offset: 0x151a
// Size: 0x13a
function function_f2fbdd0338461bcb( idx )
{
    if ( isdefined( level.var_97592a5d2d301d66[ idx ] ) )
    {
        for ( playeridx = level.var_97592a5d2d301d66[ idx ].size - 1; playeridx >= 0 ; playeridx-- )
        {
            uavstruct = level.var_97592a5d2d301d66[ idx ][ playeridx ];
            
            foreach ( starttime in uavstruct.starttimes )
            {
                uavstruct.owner.activeuavcount--;
                streakinfo = uavstruct.var_589794fde22c2da1[ starttime ];
                uavstruct.owner killstreak_utility::recordkillstreakendstats( streakinfo );
                level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
            }
            
            level.var_97592a5d2d301d66[ idx ][ playeridx ] = undefined;
        }
    }
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xac3fc66a, Offset: 0x165c
// Size: 0xc9, Type: bool
function function_6762aa74e2508325( owner )
{
    streakinfo = killstreak_utility::createstreakinfo( "directional_uav", owner );
    streakinfo.skipequippedstreakcheck = 1;
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    params = { #streakinfo:streakinfo };
    callback::callback( #"killstreak_can_trigger", params );
    streakinfo.var_b35866e4fc1f1f4a = params.var_a5f86abee0af9c2f;
    return owner uav::uav_use( streakinfo.streakname, streakinfo );
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xccd99b63, Offset: 0x172e
// Size: 0xe3
function function_17f93121881b4278( player )
{
    playerstruct = undefined;
    idx = level.var_f3d1cde89907a07a ? player.sessionsquadid : player.team;
    
    if ( isdefined( level.var_97592a5d2d301d66[ idx ] ) )
    {
        foreach ( struct in level.var_97592a5d2d301d66[ idx ] )
        {
            if ( struct.owner == player )
            {
                playerstruct = struct;
                break;
            }
        }
    }
    
    return playerstruct;
}

// Namespace uav_bigmap
// Params 2
// Checksum 0x23860fae, Offset: 0x181a
// Size: 0x1a2
function function_f037a15a80f0ca5d( owner, streakinfo )
{
    bundle = level.gametypebundle;
    duration = utility::function_48f723fdc612ec65( @"scr_uav_bigmap_timeout", 25, bundle.var_f738855a40c5ac91 );
    sweeptime = utility::function_48f723fdc612ec65( @"scr_uav_bigmap_sweep_duration", 2, bundle.var_d9a8237f66e1022e );
    sweepinterval = utility::function_48f723fdc612ec65( @"scr_uav_bigmap_sweep_interval", 4, bundle.var_94a39fbc9c5dd0f7 );
    radius = utility::function_edc4cc03e9e60b3e( @"scr_uav_bigmap_sweep_radius", 12000, bundle.var_9f913f23b2d8b8a0 );
    distancecutoff = bundle.var_fa865846ded6a14 ?? -1;
    
    if ( isdefined( owner.perks[ "specialty_overwatch" ] ) && !isbrgamemode() )
    {
        sweeptime *= 0.5;
        sweepinterval *= 0.5;
    }
    
    if ( isdefined( owner.perks[ "specialty_uav_buff" ] ) )
    {
        duration *= level.var_1099f076e66a8a09 ?? 1;
        radius = int( radius * ( level.var_2ab3ff8456131beb ?? 1 ) );
    }
    
    var_721dd47f5c82b12f = isdefined( owner.perks[ "specialty_directional_uav" ] ) ? 6 : undefined;
    uavstruct = function_14229cccfe2ec9fb( owner, radius, duration, sweeptime, sweepinterval, streakinfo, var_721dd47f5c82b12f, undefined, distancecutoff );
    function_2bdb84ac950b456a( uavstruct );
}

// Namespace uav_bigmap
// Params 1
// Checksum 0xbfe23d5a, Offset: 0x19c4
// Size: 0x76
function function_2bdb84ac950b456a( uavstruct )
{
    idx = level.var_f3d1cde89907a07a ? uavstruct.squadindex : uavstruct.team;
    
    if ( !isdefined( level.var_97592a5d2d301d66[ idx ] ) )
    {
        level.var_97592a5d2d301d66[ idx ] = [];
    }
    
    level.var_97592a5d2d301d66[ idx ][ level.var_97592a5d2d301d66[ idx ].size ] = uavstruct;
}

// Namespace uav_bigmap
// Params 9
// Checksum 0x2a49a02d, Offset: 0x1a42
// Size: 0x17a
function function_14229cccfe2ec9fb( owner, radius, duration, sweeptime, sweepinterval, streakinfo, var_1ebc7727cd34f6de, fadetimeoverride, maxdistance )
{
    uavdata = spawnstruct();
    timestamp = gettime();
    uavdata.var_589794fde22c2da1[ timestamp ] = streakinfo;
    uavdata.starttimes = [];
    uavdata.starttimes[ 0 ] = timestamp;
    uavdata.owner = owner;
    uavdata.team = owner.team;
    uavdata.squadindex = owner.sessionsquadid;
    uavdata.uavtype = "uav";
    uavdata.lastpingtime = 0;
    uavdata.radius = radius;
    uavdata.sweeptime = sweeptime;
    uavdata.sweepinterval = sweepinterval;
    uavdata.duration = duration;
    uavdata.streakinfo = streakinfo;
    uavdata.var_1ebc7727cd34f6de = var_1ebc7727cd34f6de ?? -1;
    uavdata.fadetimeoverride = fadetimeoverride ?? -1;
    uavdata.maxdistance = maxdistance ?? -1;
    return uavdata;
}

// Namespace uav_bigmap
// Params 1
// Checksum 0x2b0200da, Offset: 0x1bc5
// Size: 0x166
function function_7359f721a496db01( uavstruct )
{
    if ( level.teambased )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            function_8f96afa046010e4f( uavstruct.owner.origin, uavstruct.squadindex, uavstruct.radius, int( uavstruct.sweeptime * 1000 ), uavstruct.var_1ebc7727cd34f6de, uavstruct.fadetimeoverride, uavstruct.maxdistance );
        }
        else
        {
            triggerportableradarpingteam( uavstruct.owner.origin, uavstruct.team, uavstruct.radius, int( uavstruct.sweeptime * 1000 ), uavstruct.var_1ebc7727cd34f6de, uavstruct.fadetimeoverride, uavstruct.maxdistance );
        }
    }
    else
    {
        triggerportableradarping( uavstruct.owner.origin, uavstruct.owner, uavstruct.radius, int( uavstruct.sweeptime * 1000 ), uavstruct.var_1ebc7727cd34f6de, uavstruct.fadetimeoverride, uavstruct.maxdistance );
    }
    
    uavstruct.lastpingtime = gettime();
}

// Namespace uav_bigmap
// Params 1
// Checksum 0x49516fe5, Offset: 0x1d33
// Size: 0x60
function function_7a3c1e8741828e6a( player )
{
    var_427bc14632a56a3a = 0;
    idx = level.var_f3d1cde89907a07a ? player.sessionsquadid : player.team;
    
    if ( level.var_97592a5d2d301d66[ idx ].size > 0 )
    {
        var_427bc14632a56a3a = 1;
    }
    
    return var_427bc14632a56a3a;
}

