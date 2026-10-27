// script_3d2770dc09c1243  (hash_03d2770dc09c1243.gscc) (size: 13175 Bytes / 0x3377 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e9b7f35 (2392555317)
// size ...... 13175 (0x3377)
// includes .. 16  (offset: 0x3027)
// strings ... 46  (offset: 0x30a7)
// dev strs .. 12  (offset: 0x32db)
// exports ... 43  (offset: 0x1afb)
// cseg ...... 0x3ed + 0x170e (0x1afb)
// imports ... 125 (offset: 0x21b3)
// animtree1 . 0   (offset: 0x3377)
// animtree2 . 0   (offset: 0x3377)
#using script_1593390328d4b03f;
#using script_2054aeaae312dd57;
#using script_2986aa4b0ff2bddf;
#using script_47e50634bcd54a6d;
#using script_77aea2ef08e83635;
#using script_79a6268aa7298ac4;
#using script_dfbffa20f9a73d;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_util;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\utility\print;
#using scripts\mp\gamelogic;
#using scripts\mp\load;

#namespace mit;

// Namespace mit
// Params 0
// Checksum 0x6ad8e3f5, Offset: 0x40b
// Size: 0x10
function function_d154accecda01f06()
{
    return getdvarint( @"hash_ca89406fb9548d3d", 0 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x90da48ed, Offset: 0x424
// Size: 0x10
function private checkdoor()
{
    return getdvarint( @"hash_a26ae46918350c7", 0 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x5f6c5cb9, Offset: 0x43d
// Size: 0x11
function private function_6b82d17438b0b5ac()
{
    return getdvarint( @"hash_abc7f3036a7a549b", 1 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xedec0e78, Offset: 0x457
// Size: 0x10
function private checktraversal()
{
    return getdvarint( @"hash_b0eefb927ba15201", 0 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x3476c3df, Offset: 0x470
// Size: 0x10
function private function_afb23a3ce8e6ae8f()
{
    return getdvarint( @"hash_eb781589d9dabf4f", 0 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xb7fd03dc, Offset: 0x489
// Size: 0x10
function private checkwindow()
{
    return getdvarint( @"hash_3af754b1c955b13", 0 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xf1ee156c, Offset: 0x4a2
// Size: 0x10e
function private mapinitialize()
{
    level.mit = spawnstruct();
    level.mit.var_ab856b914f0c2035 = getdvarint( @"hash_a7c59e9830aa5637", 0 );
    level.mit.var_5997808963fceff2 = 1;
    level.var_af2ad1dfcd5919b6 = 1;
    
    if ( !isbrgamemode() )
    {
        br_c130::setc130heightoverrides();
    }
    
    level.mit.spawnpointminradius = getdvarint( @"hash_27572078d01a0677", 50 );
    level.mit.spawnpointmaxradius = getdvarint( @"hash_f6297cf726b2f395", 100 );
    spawnpointenabled = getdvarint( @"hash_f7910830506b8974", 0 );
    
    if ( spawnpointenabled )
    {
        level.mit.spawnpoint = getdvarvector( @"scr_mit_spawnpoint" );
        level.getspawnpoint = &getspawnpoint;
    }
    else
    {
        level.var_a5512b4db91f092e = &function_a5512b4db91f092e;
    }
    
    level thread spawnbotsthread();
}

// Namespace mit
// Params 0
// Checksum 0x84c37e0, Offset: 0x5b8
// Size: 0x86
function getspawnpoint()
{
    spawnpoint = spawnstruct();
    spawnpoint.origin = function_a66a11326520eb0b( level.mit.spawnpoint, level.mit.spawnpointminradius, level.mit.spawnpointmaxradius );
    spawnpoint.angles = ( 0, 0, 0 );
    spawnpoint.index = 1;
    return spawnpoint;
}

// Namespace mit
// Params 0
// Checksum 0x3e4ddd3f, Offset: 0x647
// Size: 0x125
function initialize()
{
    mapinitialize();
    
    /#
        mit_dev::function_de79bb826fe1097b();
        level thread function_3922f6d71634bc3f();
    #/
    
    level.bot_funcs[ "player_spawned_gamemode" ] = &botinitialize;
    level.bot_funcs[ "gametype_think" ] = &function_51f58d9b48ae6331;
    
    if ( isbrgamemode() )
    {
        utility::registersharedfunc( #"gametype", #"onplayerkilled", &br_onplayerkilled );
        utility::registersharedfunc( #"gametype", #"playershouldrespawn", &br_playershouldrespawn );
    }
    else
    {
        level.onplayerkilled = &onplayerkilled;
    }
    
    mit_roaming::init();
    
    if ( checkwindow() )
    {
        thread mit_windows::function_8232085c6a3ac69c();
    }
    
    /#
        if ( function_168f26942e588420() )
        {
            return;
        }
    #/
    
    if ( checkdoor() )
    {
        mit_doors::init();
    }
    
    if ( checktraversal() )
    {
        mit_traversals::init();
    }
    
    if ( function_afb23a3ce8e6ae8f() )
    {
        namespace_f049c34dec12ef04::init();
    }
    
    if ( function_6b82d17438b0b5ac() )
    {
        namespace_8fae7b668e6e3cb::function_fff4014a6853e75a();
    }
    
    level thread function_71b523f34aad6ddd();
    
    /#
        level.mit.screenshotqueue = [];
        level thread function_6eed1564fe044d15();
    #/
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xcc9015fd, Offset: 0x774
// Size: 0x3e
function private botinitialize()
{
    self.onlyscriptenemy = 1;
    bots_util_mp::bot_set_personality( "run_and_gun" );
    self botsetflag( "disable_random_goal", 1 );
    self.mit = spawnstruct();
    self.hasrespawntoken = 1;
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xa50211eb, Offset: 0x7ba
// Size: 0x2e
function private function_a5512b4db91f092e()
{
    return generatespawnpoints( level.mit.spawnpointminradius, level.mit.spawnpointmaxradius );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x1846b760, Offset: 0x7f1
// Size: 0x6f
function private spawnbotsthread()
{
    level waittill( #"player_spawned" );
    level.numlives = 0;
    setdvar( @"hash_89556297eaab6b6a", 0 );
    result = level utility::waittill_any_timeout( 10, "spawned_bots" );
    
    if ( result == "timeout" )
    {
        botcount = getdvarint( @"hash_a9944abc2f276e96", 0 );
        level thread bots_gametype_br_super::function_e4c2402be634598b( botcount );
    }
}

// Namespace mit
// Params 2
// Checksum 0x5e88de06, Offset: 0x868
// Size: 0xb3
function function_adbdc8fee4453bd7( bot, waitseconds )
{
    pathevents = [ "goal", "off_navmesh", "bad_path_door_blocker_door_owner", "bad_path_door_blocker_invalid_client", "bad_path_stuck", "bad_path_stuck_in_traversal", "bad_path_fell_over_edge", "bad_path_fell_over_edge_when_jumping", "bad_path_no_path_to_script_goal", "bad_path_no_path_to_zone_goal", "bad_path_goal_cleared", "bad_path_owner_collide", "bad_path_tacpoint_invalid", "bad_path_no_tac_point", "bad_path_dvar" ];
    return bot utility::waittill_any_in_array_or_timeout( pathevents, waitseconds );
}

// Namespace mit
// Params 1, eflags: 0x4
// Checksum 0xcffe9f62, Offset: 0x924
// Size: 0x60
function private br_onplayerkilled( deathdata )
{
    if ( isdefined( self.mit.onplayerkilled ) )
    {
        [[ self.mit.onplayerkilled ]]( deathdata );
    }
    
    self.hasrespawntoken = 1;
    self.pers[ "lives" ]++;
    self.liveragdoll = 0;
}

// Namespace mit
// Params 10, eflags: 0x4
// Checksum 0xecdc5c0c, Offset: 0x98c
// Size: 0xa4
function private onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    deathdata = { #meansofdeath:smeansofdeath };
    
    if ( isdefined( self.mit.onplayerkilled ) )
    {
        [[ self.mit.onplayerkilled ]]( deathdata );
    }
}

// Namespace mit
// Params 3
// Checksum 0x7e9d77fb, Offset: 0xa38
// Size: 0x4f
function botteleport( position, distancetolerance, var_d27633705e390ce )
{
    self botsetflag( "disable_movement", 1 );
    errorstring = botteleport_internal( position, distancetolerance, var_d27633705e390ce );
    self botsetflag( "disable_movement", 0 );
    return errorstring;
}

// Namespace mit
// Params 3, eflags: 0x4
// Checksum 0xa2c4a7e2, Offset: 0xa90
// Size: 0x15c
function private botteleport_internal( position, distancetolerance, var_d27633705e390ce )
{
    self botclearscriptgoal();
    self setvelocity( ( 0, 0, 0 ) );
    
    if ( !function_e13cdc992cbb013b() )
    {
        return "unstoppable movement";
    }
    
    clippos = position;
    
    if ( isdefined( var_d27633705e390ce ) )
    {
        var_52cd110ae279e9ac = -30 - var_d27633705e390ce;
        contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water" ] );
        clippos = utility::drop_to_ground( position, var_d27633705e390ce, var_52cd110ae279e9ac, undefined, contents );
        
        if ( floatequal( clippos[ 2 ] - position[ 2 ], var_52cd110ae279e9ac, 1 ) )
        {
            return "no clip";
        }
    }
    
    while ( self islinked() )
    {
        wait 0.5;
    }
    
    beforetp = self.origin;
    self setorigin( clippos );
    
    if ( !function_e13cdc992cbb013b() )
    {
        return "still sliding";
    }
    
    dist = distance( position, self.origin );
    
    if ( dist > distancetolerance && !( self isswimming() || utility::ispointinwater( self.origin ) ) )
    {
        return ( "inaccurate " + dist + "/" + distancetolerance + ", bot's position before tp:" + beforetp );
    }
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x6e26a203, Offset: 0xbf4
// Size: 0x7b, Type: bool
function private function_e13cdc992cbb013b()
{
    waitframe();
    waitframe();
    var_1735a38f8fd5c67b = 20;
    var_e9a4e18d652d6bc2 = function_39ee610d2625a324( var_1735a38f8fd5c67b );
    starttime = function_9f2a98ba9eb78c4d();
    endtime = starttime + var_e9a4e18d652d6bc2;
    
    while ( self getvelocity() != ( 0, 0, 0 ) && !self isswimming() )
    {
        wait 0.1;
        
        if ( function_9f2a98ba9eb78c4d() >= endtime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mit
// Params 3
// Checksum 0x4b85ad47, Offset: 0xc78
// Size: 0xdd
function outputlog( category, reportstr, append )
{
    var_78100ea68a71a994 = 2048;
    
    if ( append )
    {
        header = "[MIT]+";
    }
    else
    {
        header = "[MIT]" + category + ";";
    }
    
    maxlength = var_78100ea68a71a994 - header.size;
    
    if ( reportstr.size <= maxlength )
    {
        logstring( header + reportstr );
        return;
    }
    
    for ( startindex = 0; startindex < reportstr.size ; startindex = endindex )
    {
        endindex = int( min( startindex + maxlength, reportstr.size ) );
        substring = getsubstring( reportstr, startindex, endindex );
        logstring( header + substring );
        
        if ( startindex == 0 )
        {
            header = "[MIT]+";
            maxlength = var_78100ea68a71a994 - header.size;
        }
    }
}

// Namespace mit
// Params 3, eflags: 0x4
// Checksum 0x9a53219, Offset: 0xd5d
// Size: 0x6e
function private getsubstring( str, start, end )
{
    var_9d1fa1b3cd1a1b54 = 1023;
    substring = "";
    
    while ( end - start > var_9d1fa1b3cd1a1b54 )
    {
        substring += getsubstr( str, start, start + var_9d1fa1b3cd1a1b54 );
        start += var_9d1fa1b3cd1a1b54;
    }
    
    substring += getsubstr( str, start, end );
    return substring;
}

// Namespace mit
// Params 3
// Checksum 0xc6c2018, Offset: 0xdd4
// Size: 0x29, Type: bool
function floatequal( float1, float2, epsilon )
{
    return abs( float1 - float2 ) < epsilon;
}

// Namespace mit
// Params 4
// Checksum 0x46e7326b, Offset: 0xe06
// Size: 0x206, Type: bool
function function_57b388b15cd6d2a5( p1, p2, q1, q2 )
{
    pxmax = p1[ 0 ] > p2[ 0 ] ? p1[ 0 ] : p2[ 0 ];
    pxmin = p1[ 0 ] > p2[ 0 ] ? p2[ 0 ] : p1[ 0 ];
    var_c0656b4974739ad = p1[ 1 ] > p2[ 1 ] ? p1[ 1 ] : p2[ 1 ];
    var_be340b49720c193 = p1[ 1 ] > p2[ 1 ] ? p2[ 1 ] : p1[ 1 ];
    qxmax = q1[ 0 ] > q2[ 0 ] ? q1[ 0 ] : q2[ 0 ];
    qxmin = q1[ 0 ] > q2[ 0 ] ? q2[ 0 ] : q1[ 0 ];
    var_6750351558997656 = q1[ 1 ] > q2[ 1 ] ? q1[ 1 ] : q2[ 1 ];
    var_672d471558735634 = q1[ 1 ] > q2[ 1 ] ? q2[ 1 ] : q1[ 1 ];
    
    if ( pxmax < qxmin || qxmax < pxmin || var_c0656b4974739ad < var_672d471558735634 || var_6750351558997656 < var_be340b49720c193 )
    {
        return false;
    }
    
    res1 = ( p1[ 0 ] - p2[ 0 ] ) * ( q1[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q1[ 0 ] - p2[ 0 ] );
    res2 = ( p1[ 0 ] - p2[ 0 ] ) * ( q2[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q2[ 0 ] - p2[ 0 ] );
    res3 = ( q1[ 0 ] - q2[ 0 ] ) * ( p1[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p1[ 0 ] - q2[ 0 ] );
    res4 = ( q1[ 0 ] - q2[ 0 ] ) * ( p2[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p2[ 0 ] - q2[ 0 ] );
    return res1 * res2 <= 0 && res3 * res4 <= 0;
}

// Namespace mit
// Params 0
// Checksum 0x6932e374, Offset: 0x1015
// Size: 0xb
function function_9f2a98ba9eb78c4d()
{
    return gettime() * gettimescale();
}

// Namespace mit
// Params 1
// Checksum 0xe9c8fd51, Offset: 0x1029
// Size: 0x57
function function_39ee610d2625a324( durationsec )
{
    actualdurationms = durationsec * 1000;
    
    if ( gettimescale() == 4 )
    {
        var_20ea60a338f536bc = 0.5;
        assert( gettimescale() * var_20ea60a338f536bc >= 1 );
        actualdurationms /= var_20ea60a338f536bc;
    }
    
    return actualdurationms;
}

// Namespace mit
// Params 2, eflags: 0x4
// Checksum 0x61bbbce3, Offset: 0x1089
// Size: 0xc5
function private generatespawnpoints( secondaryminradius, secondarymaxradius )
{
    points = [];
    num = getdvarint( @"hash_a9944abc2f276e96", 1 ) + 1;
    
    for ( i = 0; i < num ; i++ )
    {
        randompoint = bots_util_mp::function_478281ff275ed942();
        startpoint = spawnstruct();
        startpoint.origin = function_a66a11326520eb0b( randompoint, secondaryminradius, secondarymaxradius );
        startpoint.angles = ( 0, randomfloat( 360 ), 0 );
        startpoint.team = undefined;
        startpoint.script_label = "InteriorSpawnPoint";
        points[ points.size ] = startpoint;
    }
    
    return points;
}

// Namespace mit
// Params 3, eflags: 0x4
// Checksum 0x69810e9f, Offset: 0x1157
// Size: 0x4a
function private function_a66a11326520eb0b( point, secondaryminradius, secondarymaxradius )
{
    assert( secondaryminradius > 0 && secondarymaxradius > secondaryminradius );
    return br_circle::getrandompointincircle( point, secondarymaxradius, float( secondaryminradius ) / secondarymaxradius, 1, 1, 1 );
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xd480e075, Offset: 0x11aa
// Size: 0x59
function private function_51f58d9b48ae6331()
{
    self notify( #"hash_e61ddf6c7e40c65e" );
    self endon( #"hash_e61ddf6c7e40c65e" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( checkwindow() )
    {
        while ( !mit_windows::isinitialized() )
        {
            waitframe();
        }
    }
    
    while ( true )
    {
        function_880a0ae7900bc428();
        waitframe();
    }
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xbf99899f, Offset: 0x120b
// Size: 0x58
function private function_71b523f34aad6ddd()
{
    level endon( #"game_ended" );
    startime = getsystemtime();
    
    while ( true )
    {
        time = ( getsystemtime() - startime ) * 1000;
        outputlog( "Timer", "The game has been running for:" + print::getformattedtimestamp( time ) );
        wait 60;
    }
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0x3294f013, Offset: 0x126b
// Size: 0x4, Type: bool
function private br_playershouldrespawn()
{
    return true;
}

// Namespace mit
// Params 3, eflags: 0x4
// Checksum 0xf5bb3895, Offset: 0x1278
// Size: 0x49
function private runtest( name, testprocess, endhandler )
{
    thread function_17f628d93a74ad69( name, endhandler );
    thread function_22c87ef73c91fe83( name, testprocess );
    utility::waittill_any_in_array( [ name, "death_or_disconnect" ] );
}

// Namespace mit
// Params 2, eflags: 0x4
// Checksum 0xa20bb5b5, Offset: 0x12c9
// Size: 0x35
function private function_22c87ef73c91fe83( name, testprocess )
{
    self endon( name );
    self endon( #"death_or_disconnect" );
    function_da958646af59bd4a( testprocess );
    waitframe();
    self notify( name );
}

// Namespace mit
// Params 1, eflags: 0x4
// Checksum 0xd403cdb2, Offset: 0x1306
// Size: 0x2a
function private function_da958646af59bd4a( testprocess )
{
    /#
        if ( function_168f26942e588420() )
        {
            self endon( #"hash_aef39e4f069d3cee" );
        }
    #/
    
    self [[ testprocess ]]();
}

// Namespace mit
// Params 2, eflags: 0x4
// Checksum 0x747c901, Offset: 0x1338
// Size: 0x32
function private function_17f628d93a74ad69( name, endhandler )
{
    utility::waittill_any_in_array( [ name, "death_or_disconnect" ] );
    self [[ endhandler ]]();
}

// Namespace mit
// Params 0, eflags: 0x4
// Checksum 0xae02b5e, Offset: 0x1372
// Size: 0x221
function private function_880a0ae7900bc428()
{
    /#
        if ( function_168f26942e588420() )
        {
            if ( mit_dev::function_8e86bb7229f75af4() )
            {
                runtest( "<dev string:x24>", &mit_dev::function_8c73559ab29ba7a9, &mit_roaming::endhandler );
                return;
            }
            
            if ( mit_dev::function_6029df97b80478b5() )
            {
                runtest( "<dev string:x2c>", &mit_dev::function_9853b5c1f82853d0, &mit_windows::endhandler );
            }
            
            return;
        }
    #/
    
    if ( function_afb23a3ce8e6ae8f() && !level.mit.lootchecked )
    {
        level thread namespace_f049c34dec12ef04::function_ea4702e96396446c();
        level.mit.lootchecked = 1;
    }
    
    if ( checkdoor() && mit_doors::function_119b9a096f5511d2() )
    {
        runtest( "door", &mit_doors::testprocess, &mit_doors::endhandler );
        return;
    }
    
    if ( checktraversal() && mit_traversals::function_119b9a096f5511d2() )
    {
        runtest( "traversal", &mit_traversals::testprocess, &mit_traversals::endhandler );
        return;
    }
    
    if ( checkwindow() && mit_windows::function_119b9a096f5511d2() )
    {
        runtest( "window", &mit_windows::testprocess, &mit_windows::endhandler );
        return;
    }
    
    if ( mit_roaming::function_119b9a096f5511d2() )
    {
        level.mit.var_5997808963fceff2 = 0;
        runtest( "roaming", &mit_roaming::testprocess, &mit_roaming::endhandler );
        return;
    }
    
    self.mit.var_e16079b75c47af8b = 1;
    gameend = 1;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            continue;
        }
        
        if ( !player.mit.var_e16079b75c47af8b )
        {
            gameend = 0;
            break;
        }
    }
    
    if ( gameend )
    {
        level thread gamelogic_mp::forceend();
    }
    
    self notify( #"hash_e61ddf6c7e40c65e" );
}

// Namespace mit
// Params 0
// Checksum 0xbb08674c, Offset: 0x159b
// Size: 0x1d
function function_74297d4ab194404()
{
    /#
        if ( function_168f26942e588420() )
        {
            return;
        }
    #/
    
    level.struct_filter_override = &filterstructs;
}

// Namespace mit
// Params 1, eflags: 0x4
// Checksum 0x4f4d1baf, Offset: 0x15c0
// Size: 0x2b
function private filterstructs( struct )
{
    if ( struct.targetname == "gulag" )
    {
        return 1;
    }
    
    return load::filterstructs( struct );
}

/#

    // Namespace mit
    // Params 0
    // Checksum 0x94f20de0, Offset: 0x15f4
    // Size: 0x14, Type: dev
    function function_168f26942e588420()
    {
        return getdvarint( @"hash_16a69b03592ae6ea", 0 );
    }

    // Namespace mit
    // Params 5
    // Checksum 0xbaf48548, Offset: 0x1610
    // Size: 0xc8, Type: dev
    function requestscreenshot( testphase, targetpos, camerapos, originaltask, var_5d233476ee119367 )
    {
        info = spawnstruct();
        info.camerapos = camerapos;
        info.cameraangle = vectortoangles( targetpos - camerapos );
        info.testphase = testphase;
        info.targetpos = targetpos;
        info.originaltask = originaltask;
        info.var_5d233476ee119367 = var_5d233476ee119367;
        level.mit.screenshotqueue[ level.mit.screenshotqueue.size ] = info;
    }

    // Namespace mit
    // Params 0
    // Checksum 0xd8193ddf, Offset: 0x16e0
    // Size: 0x2ab, Type: dev
    function function_6eed1564fe044d15()
    {
        level endon( #"game_ended" );
        level waittill( #"player_spawned", player );
        setdvar( @"ai_shownavmesh", 2 );
        setdvar( @"hash_3c48eaf332022cd9", 1 );
        defaultplayer = level.players[ 0 ];
        defaultplayer dontinterpolate();
        
        while ( true )
        {
            if ( !getdvarint( @"hash_824c718cad3c0f17", 1 ) || level.mit.screenshotqueue.size == 0 )
            {
                wait 1;
                continue;
            }
            
            if ( !defaultplayer isnoclip() )
            {
                defaultplayer noclip();
            }
            
            screenshottask = level.mit.screenshotqueue[ 0 ];
            
            if ( level.mit.var_5997808963fceff2 && function_c8d2c7574f6f586d( screenshottask.targetpos ) )
            {
                wait 2;
                continue;
            }
            
            if ( screenshottask.testphase == "<dev string:x33>" )
            {
                defaultplayer thread mit_traversals::function_cd1aea26e26d352a( screenshottask.originaltask );
            }
            else if ( screenshottask.testphase == "<dev string:x3d>" )
            {
                defaultplayer thread mit_windows::highlightwindow( screenshottask.originaltask );
            }
            else if ( screenshottask.testphase == "<dev string:x44>" )
            {
                defaultplayer thread mit_roaming::function_ba0ca1493008e3( screenshottask.targetpos );
            }
            
            level.mit.screenshotqueue[ 0 ] = undefined;
            function_cdc669dbc8ea2101( level.mit.screenshotqueue );
            defaultplayer setorigin( screenshottask.camerapos );
            defaultplayer setplayerangles( screenshottask.cameraangle );
            wait 0.2;
            posstring = int( screenshottask.targetpos[ 0 ] ) + "<dev string:x4c>" + int( screenshottask.targetpos[ 1 ] ) + "<dev string:x4c>" + int( screenshottask.targetpos[ 2 ] );
            screenshotfilename = "<dev string:x4e>" + screenshottask.testphase + "<dev string:x4c>" + posstring + "<dev string:x59>" + screenshottask.var_5d233476ee119367;
            adddebugcommand( "<dev string:x65>" + screenshotfilename + "<dev string:x75>" );
            wait 0.5;
            
            if ( screenshottask.testphase == "<dev string:x44>" )
            {
                level notify( "<dev string:x78>" + screenshottask.var_5d233476ee119367 );
            }
            
            if ( defaultplayer isnoclip() )
            {
                defaultplayer noclip();
            }
        }
    }

    // Namespace mit
    // Params 1
    // Checksum 0x4a4d7b6, Offset: 0x1993
    // Size: 0xb5, Type: dev
    function function_c8d2c7574f6f586d( pos )
    {
        foreach ( player in level.players )
        {
            if ( !( namespace_ef4547f85724edd1::isvalidplayer( player ) && isbot( player ) ) )
            {
                continue;
            }
            
            if ( distance2dsquared( pos, player.origin ) < 10000 )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace mit
    // Params 0, eflags: 0x4
    // Checksum 0xa8485177, Offset: 0x1a50
    // Size: 0x44, Type: dev
    function private function_3922f6d71634bc3f()
    {
        level waittill( #"player_spawned" );
        
        if ( getdvarint( @"hash_1992a1ad0bd6723b", 0 ) != 0 )
        {
            adddebugcommand( "<dev string:x99>" );
            wait 1;
            assert( gettimescale() == 4 );
        }
    }

#/

// Namespace mit
// Params 3
// Checksum 0xeba7a32a, Offset: 0x1a9c
// Size: 0x5f
function function_655ffb35317b1edb( toverify, expectedlength, arraydefault )
{
    if ( isarray( toverify ) && toverify.size == expectedlength )
    {
        return toverify;
    }
    
    if ( isvector( toverify ) )
    {
        return [ toverify[ 0 ], toverify[ 1 ], toverify[ 2 ] ];
    }
    
    return arraydefault;
}

