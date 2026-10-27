// script_26ccbfe3954cacf4  (hash_26ccbfe3954cacf4.gscc) (size: 46772 Bytes / 0xb6b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd624f8f (224546703)
// size ...... 46772 (0xb6b4)
// includes .. 29  (offset: 0xab30)
// strings ... 155 (offset: 0xac18)
// dev strs .. 57  (offset: 0xb3fc)
// exports ... 120 (offset: 0x731c)
// cseg ...... 0x136f + 0x5fad (0x731c)
// imports ... 295 (offset: 0x85dc)
// animtree1 . 0   (offset: 0xb6b4)
// animtree2 . 0   (offset: 0xb6b4)
#using script_23eca243497ca70a;
#using script_2e6a95dfe7dfc5f8;
#using script_44f4640b93ab1b47;
#using script_4a7080e904a6380e;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\playerlogic;

#namespace manager;

// Namespace manager
// Params 1
// Checksum 0x2b502ee4, Offset: 0x138d
// Size: 0x2fa
function initialize( var_7dc27bc9fa62c763 )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !bots_util::function_deef484b5b3a3977() )
    {
        return;
    }
    
    assert( isdefined( var_7dc27bc9fa62c763 ) );
    level.uibotmanager = {};
    level.uibotmanager.dormantbots = [];
    level.uibotmanager.uibots = [];
    level.uibotmanager.var_d3b6a107b3176710 = getdvarint( @"hash_1d46ca0f335af524", 0 ) != 0;
    level.uibotmanager.var_2432a9ec51aedf68 = getdvar( @"hash_341676d55f4c7c0c", "5,2,2,1" );
    level.uibotmanager.loglevel = clampint( getdvarint( @"hash_afc633027b98d7d", 1 ), 0, 4 );
    level.uibotmanager.var_6ba0b05a074ecd1d = [];
    level.uibotmanager.var_6ba0b05a074ecd1d[ 0 ] = "[DEBUG]";
    level.uibotmanager.var_6ba0b05a074ecd1d[ 1 ] = "[INFO]";
    level.uibotmanager.var_6ba0b05a074ecd1d[ 2 ] = "[WARNING]";
    level.uibotmanager.var_6ba0b05a074ecd1d[ 3 ] = "[ERROR]";
    level.uibotmanager.var_7dc27bc9fa62c763 = var_7dc27bc9fa62c763;
    level.uibotmanager.var_ed63de32b7d40373 = function_bf9aa97c60d35f0f();
    level.uibotmanager.var_e922d98b52d61f52 = [ 4:0, 3:0, 0, 1:0 ];
    var_25ecda8761ccbf7e = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_877a18e7356fb96d" ].var_d9dd3d1abbed36da;
    level.uibotmanager.var_d9dd3d1abbed36da = utility::function_edc4cc03e9e60b3e( @"hash_f03708bf6fbc5582", -1, var_25ecda8761ccbf7e );
    level callback::add( #"player_death", &onplayerkilled );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_end", &on_match_end );
    recycle_manager::initialize();
    thread function_9172e0fbaaa3798d();
    
    if ( recycle_manager::isenabled() )
    {
        thread function_df4d32c41e962dc5();
    }
    
    thread function_47514ccbc45eb8a();
    thread function_18bd5f2893d0e198();
    thread function_764608ba2cfbb62d();
    
    /#
        thread function_1fd14e2806a76525();
    #/
    
    if ( level.usegulag && !br_gametypes::isfeaturedisabled( #"gulag" ) )
    {
        thread function_c7fbba36ca4bf35a();
    }
    
    if ( getdvarint( @"scr_br_bot_survival_curve_enabled", 1 ) )
    {
        thread function_6a9696fd3d64bbf7();
    }
    
    thread function_d88688d031e642c2();
    uav_manager::function_7ec01a0dd5083696();
    
    if ( getdvarint( @"hash_429176496a1b2fd8", 0 ) )
    {
        thread function_1fb6dea113344bc4();
    }
    
    /#
        thread function_2a3829b69c301393();
    #/
    
    utility::registersharedfunc( #"player", #"hash_d4410b0e9a24e367", &function_cff59650647ee34 );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xa2e12ab9, Offset: 0x168f
// Size: 0x20, Type: bool
function private function_cff59650647ee34( player )
{
    return player function_5c79ebe77f7d0528() || player isuibot();
}

// Namespace manager
// Params 0
// Checksum 0x39586655, Offset: 0x16b8
// Size: 0xa1, Type: bool
function isenabled()
{
    if ( isdvardefined( @"hash_b7fcb658021d7931" ) )
    {
        return ( getdvarint( @"hash_b7fcb658021d7931" ) != 0 );
    }
    
    if ( level.gametypebundle.var_fd3a1a6b45be175c )
    {
        var_905c2d3dfc263764 = level.gametypebundle.var_fd3a1a6b45be175c[ #"hash_877a18e7356fb96d" ];
        
        if ( var_905c2d3dfc263764 )
        {
            return istrue( var_905c2d3dfc263764.var_9e8f30bc68961eef );
        }
    }
    
    buildversion = getbuildversion();
    return buildversion == "DEBUG" || buildversion == "TEST" || buildversion == "DEMO";
}

// Namespace manager
// Params 1
// Checksum 0x7ee3e10d, Offset: 0x1762
// Size: 0x134
function onplayerconnect( params )
{
    assert( isenabled() );
    player = self;
    
    if ( isdefined( player.uibotprofile.clientmatchdataid ) )
    {
        player.clientmatchdataid = player.uibotprofile.clientmatchdataid;
    }
    
    if ( !isbot( player ) )
    {
        reason = "human teammate connected. humanName=" + player.name + ", team=" + player.team;
        
        foreach ( botprofile in level.uibotmanager.uibots )
        {
            if ( botprofile.team == player.team )
            {
                botprofile ui_bot::activate( reason );
            }
        }
    }
}

// Namespace manager
// Params 1
// Checksum 0xf4f8ab76, Offset: 0x189e
// Size: 0x62
function onplayerdisconnect( params )
{
    assert( isenabled() );
    player = self;
    
    if ( isdefined( player.var_872374f4e7788b22 ) )
    {
        player.var_872374f4e7788b22.clientmatchdataid = player.clientmatchdataid;
        player.var_872374f4e7788b22 = undefined;
    }
}

// Namespace manager
// Params 1
// Checksum 0x8cd6e37, Offset: 0x1908
// Size: 0x37, Type: bool
function isteameliminated( team )
{
    alivecount = teams::getteamdata( team, "aliveCount" );
    
    if ( alivecount > 0 )
    {
        return false;
    }
    
    return !br::function_45fb04620e678531( team );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xc49f41f0, Offset: 0x1948
// Size: 0x5d8
function private function_1fb6dea113344bc4()
{
    level endon( #"game_ended" );
    
    if ( level.br_infils_disabled )
    {
        level waittill( #"spawned_bots" );
    }
    else
    {
        level waittill( #"br_circle_set" );
    }
    
    while ( true )
    {
        logstring( "[DumpBots] start" );
        uibotcount = level.uibotmanager.uibots.size;
        alivebots = 0;
        alivehuman = 0;
        activeteams = [];
        curtime = gettime();
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || player bots_gametype_br_super::iseliminated() )
            {
                continue;
            }
            
            if ( player isuibot() )
            {
                continue;
            }
            
            activeteams[ player.team ] = 1;
            
            if ( isbot( player ) )
            {
                alivebots++;
                continue;
            }
            
            alivehuman++;
        }
        
        alivecount = alivebots + alivehuman;
        logstring( "Time:" + curtime + ", TotalPlayers:" + alivecount + uibotcount + ", AliveHumans:" + alivehuman + ", AliveBots:" + alivebots + uibotcount + ", UIBots:" + uibotcount );
        
        if ( isdefined( level.br_circle.dangercircleent ) )
        {
            logstring( "Circle:" + level.br_circle.circleindex + " origin:" + level.br_circle.dangercircleent.origin );
        }
        
        logstring( "IsGulagShutDown:" + br::isgulagshutdown() );
        
        if ( level.uibotmanager.uibots.size > 0 )
        {
            logstring( "[DumpUIBots] start" );
            
            foreach ( bot in level.uibotmanager.uibots )
            {
                logstring( "[Dump UIBot] name:" + bot.name + " locked:" + bot.locked + " team:" + bot.team );
                ui_bot::validateuibotcount( bot.team );
            }
            
            logstring( "[DumpUIBots] end" );
        }
        
        logstring( "[DumpActiveTeams] start" );
        
        foreach ( team, v in activeteams )
        {
            logstring( "team:" + team );
            players = teams::getteamdata( team, "alivePlayers" );
            
            foreach ( player in players )
            {
                speed = length( player getvelocity() );
                status = isbot( player ) && isdefined( player.status ) ? player.status : "";
                logstring( "[Dump player] name:" + player.name + " origin:" + player.origin + " health:" + player.health + " speed:" + speed + " status:" + status );
                
                if ( isbot( player ) )
                {
                    if ( !isdefined( player.lastposition ) || distancesquared( player.origin, player.lastposition ) > 10 )
                    {
                        player.lasttimehavemove = curtime;
                    }
                    
                    player.lastposition = player.origin;
                    
                    if ( isdefined( player.lasttimehavemove ) && curtime - player.lasttimehavemove > 10000 )
                    {
                        logstring( "[Dump player] STUCKED!!! lastTimeHaveMove:" + player.lasttimehavemove - level.starttime + " stuck time:" + curtime - player.lasttimehavemove );
                        
                        /#
                            line( player.origin - ( 0, 0, 3000 ), player.origin + ( 0, 0, 5000 ), ( 1, 0, 0 ), 1, 0, 50 );
                            print3d( player.origin + ( 0, 0, 3000 ), "<dev string:x24>", ( 1, 0, 0 ), 1, 20, 50, 1 );
                        #/
                    }
                }
            }
        }
        
        logstring( "[DumpActiveTeams] end" );
        level utility::waittill_any_in_array_or_timeout( [ "ui_bot_counter_updated", "updatePlayerAndTeamCountUI" ], 1 );
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x9b5c489f, Offset: 0x1f28
// Size: 0xda
function private function_c7fbba36ca4bf35a()
{
    level endon( #"game_ended" );
    
    if ( level.br_infils_disabled )
    {
        level waittill( #"spawned_bots" );
    }
    else
    {
        level utility::waittill_all_in_array( [ "br_circle_set", "br_c130_left_bounds" ] );
    }
    
    timeout = getdvarint( @"hash_5d346678d4fb1795", 5000 );
    
    while ( !br::isgulagshutdown() )
    {
        if ( level.uibotmanager.uibots.size > 0 )
        {
            player = function_d1ca89bd343f89f3();
            
            if ( isdefined( player ) )
            {
                if ( gettime() - player.jailtime > timeout )
                {
                    arenaindex = player function_8da4f938452139be();
                    ui_bot::killsome( 1, 1, "DeployUIBotIntoGulag", arenaindex );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x91a5649, Offset: 0x200a
// Size: 0x15b
function private function_d1ca89bd343f89f3()
{
    targetplayer = undefined;
    var_ed23abc24b9184ab = undefined;
    
    foreach ( arena in level.gulag.arenas )
    {
        foreach ( match in arena.matches )
        {
            if ( match.size != 1 )
            {
                continue;
            }
            
            player = match[ 0 ];
            
            if ( !isdefined( player ) || isbot( player ) )
            {
                continue;
            }
            
            if ( !isdefined( var_ed23abc24b9184ab ) || player.jailtime < var_ed23abc24b9184ab )
            {
                var_ed23abc24b9184ab = player.jailtime;
                targetplayer = player;
            }
        }
    }
    
    return targetplayer;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x825c13a4, Offset: 0x216e
// Size: 0x64
function private function_8da4f938452139be()
{
    if ( !isdefined( self.arena ) )
    {
        return;
    }
    
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        if ( level.gulag.arenas[ i ] == self.arena )
        {
            return i;
        }
    }
}

// Namespace manager
// Params 1
// Checksum 0xbfc0c62b, Offset: 0x21db
// Size: 0x290
function tryrecycle( recycletype )
{
    if ( !isinitialized() )
    {
        return 0;
    }
    
    assert( isdefined( recycletype ) );
    assert( self.uibot );
    touibot = undefined;
    recyclereason = undefined;
    
    switch ( recycletype )
    {
        case 0:
            dist2d = getdvarint( @"hash_81156fddeb6b5508", level.var_d4909c0acc55763c.var_3540f4ae8e75d28e ?? 5900 );
            height = getdvarint( @"hash_b51792a54d2cc6df", 5900 );
            
            if ( dormant_bot::canberecycled( dist2d, height, 0 ) )
            {
                touibot = 0;
                recyclereason = "landing position meets the range [2D dist = " + dist2d + ", height = " + height + "] and not witnessed";
                dormant_bot::function_b4f756a19929b41f();
            }
            
            break;
        case 1:
            if ( function_f61bdf086a344ace( self ) == 0 )
            {
                touibot = 1;
                recyclereason = "prematch active player count limit";
            }
            
            break;
        case 2:
            if ( function_316d0d6cf6d4fbd5() < 0 )
            {
                touibot = 1;
                recyclereason = "infil active bot count limit";
            }
            
            break;
        case 3:
            if ( !bots_gametype_br_super::function_d0fa014a2d896bdc() && !bots_gametype_br_super::function_98c886e7b2c20b9c() )
            {
                recyclereason = "parachute stuck at " + self.origin;
                
                if ( !ui_bot::canberecycled() )
                {
                    super_bot::function_cb27523a07bf9c83( 1, self, "manager::tryrecycle", "cannot be recycled, kill it instead. recycleReason:" + recyclereason, "" );
                    self dodamage( self.health + 10000, self.origin, self );
                    return 0;
                }
                else
                {
                    touibot = 1;
                }
            }
            
            break;
        case 4:
            if ( function_39d8923dd95b43ad() )
            {
                recyclereason = "off_navmesh and not witnessed at" + self.origin;
                
                if ( ui_bot::function_9faf63b8dddbcc93() )
                {
                    thread trytorecoverfromoffnavmeshthread();
                }
                else if ( !ui_bot::canberecycled() )
                {
                    super_bot::function_cb27523a07bf9c83( 1, self, "manager::tryrecycle", "cannot be recycled, kill it instead. recycleReason:" + recyclereason, "" );
                    self dodamage( self.health + 10000, self.origin, self );
                    return 0;
                }
                else
                {
                    touibot = 1;
                }
            }
            
            break;
        case 5:
            /#
                touibot = 1;
                recyclereason = "<dev string:x33>";
            #/
            
            break;
        default:
            break;
    }
    
    if ( isdefined( touibot ) && !bots_gametype_br_super::function_8225394f018d1121() )
    {
        if ( touibot )
        {
            return ui_bot::tryrecycle( recyclereason, recycletype );
        }
        else
        {
            return dormant_bot::tryrecycle( recyclereason );
        }
        
        return;
    }
    
    return 0;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xbc063a11, Offset: 0x2473
// Size: 0x2b, Type: bool
function private function_39d8923dd95b43ad()
{
    return !bots_gametype_br_super::function_d0fa014a2d896bdc() && !bots_gametype_br_super::function_98c886e7b2c20b9c() && !( self isswimming() && bots_gametype_br_super::function_5a32ee48f4cdfdaa( 500 ) );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x2195a7ae, Offset: 0x24a7
// Size: 0x13e
function private trytorecoverfromoffnavmeshthread()
{
    if ( self.uibot.var_806750df455ec748 )
    {
        return;
    }
    
    self.uibot.var_806750df455ec748 = 1;
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"recycled_to_uibot" );
    self endon( #"try_to_recover_from_off_navmesh_thread_ended" );
    thread function_e79659793f31c39b();
    childthread function_15d01f0448c79e15();
    wait 3;
    deployedpos = undefined;
    radius = 200;
    
    while ( radius <= 1000 )
    {
        originalpos = self.origin;
        deployedpos = function_babece9e5564ab9( originalpos, radius );
        
        if ( deployedpos )
        {
            teleportafteroffnavmesh( originalpos, deployedpos, "teleport to ground deploy position" );
            return;
        }
        
        waitframe();
        radius += 100;
    }
    
    originalpos = self.origin;
    deployedpos = function_8e7f3061ba22c2b9();
    
    if ( deployedpos )
    {
        teleportafteroffnavmesh( originalpos, deployedpos, "teleport to safe landing spot" );
        return;
    }
    
    while ( !function_39d8923dd95b43ad() )
    {
        wait 1;
    }
    
    super_bot::function_cb27523a07bf9c83( 1, self, "manager::trytorecoverfromoffnavmeshthread", "kill bot after off-navmesh recovery failed: no nearby valid point and no safe landing spot", "" );
    self dodamage( self.health + 10000, self.origin, self );
}

// Namespace manager
// Params 0, eflags: 0xc
// Checksum 0xb22fe1aa, Offset: 0x25ed
// Size: 0x4c
function private function_e79659793f31c39b()
{
    self notify( #"hash_adf11f6b6f9a6b3c" );
    self endon( #"hash_adf11f6b6f9a6b3c" );
    utility::waittill_any_ents( self, "death_or_disconnect", self, "recycled_to_uibot", level, "game_ended", self, "try_to_recover_from_off_navmesh_thread_ended" );
    self.uibot.var_806750df455ec748 = undefined;
}

// Namespace manager
// Params 0, eflags: 0xc
// Checksum 0xffd97dd7, Offset: 0x2641
// Size: 0x41
function private function_15d01f0448c79e15()
{
    self notify( #"hash_1ee25dbf49c9fb62" );
    self endon( #"hash_1ee25dbf49c9fb62" );
    
    while ( true )
    {
        if ( ispointonnavmesh( self.origin, self ) )
        {
            self notify( #"try_to_recover_from_off_navmesh_thread_ended" );
            return;
        }
        
        waitframe();
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xef7a7ccf, Offset: 0x268a
// Size: 0x82
function private function_8e7f3061ba22c2b9()
{
    landingspots = level.var_b7611ddaf43956e1.var_7befb8d60420cd1;
    
    if ( !landingspots.size )
    {
        return;
    }
    
    var_e444e5d70d37734b = arrayrandomize( landingspots );
    
    for ( i = 0; i < var_e444e5d70d37734b.size ; i++ )
    {
        if ( i > 0 && i % 5 == 0 )
        {
            waitframe();
        }
        
        landingpos = var_e444e5d70d37734b[ i ];
        
        if ( function_d9d16b6c88a01ec0( landingpos, 0 ) )
        {
            return landingpos;
        }
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xb78b5130, Offset: 0x2715
// Size: 0x108
function private function_babece9e5564ab9( origin, radius )
{
    poscandidate = br_circle::getrandompointincircle( origin, radius, 0.9, 1, 1, 1, undefined, undefined, 1 );
    
    if ( !poscandidate )
    {
        return;
    }
    
    if ( function_d9d16b6c88a01ec0( poscandidate ) )
    {
        return poscandidate;
    }
    
    delta = poscandidate - origin;
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    var_358197c3c363f0da = origin - delta;
    droppedpos = function_9a3f1f15f63f174a( var_358197c3c363f0da, contents );
    
    if ( droppedpos )
    {
        return droppedpos;
    }
    
    waitframe();
    var_3bfd4c1369c44ff1 = ( origin[ 0 ] - delta[ 1 ], origin[ 1 ] + delta[ 0 ], origin[ 2 ] );
    droppedpos = function_9a3f1f15f63f174a( var_3bfd4c1369c44ff1, contents );
    
    if ( droppedpos )
    {
        return droppedpos;
    }
    
    var_3bfd491369c44958 = ( origin[ 0 ] + delta[ 1 ], origin[ 1 ] - delta[ 0 ], origin[ 2 ] );
    droppedpos = function_9a3f1f15f63f174a( var_3bfd491369c44958, contents );
    
    if ( droppedpos )
    {
        return droppedpos;
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xfe09749, Offset: 0x2826
// Size: 0x7c
function private function_9a3f1f15f63f174a( poscandidate, contents )
{
    var_1e87437938318e4d = 4000;
    var_eb1d012d76bb4611 = 50;
    poscandidate = br_public::droptogroundmultitrace( ( poscandidate[ 0 ], poscandidate[ 1 ], var_1e87437938318e4d ), undefined, undefined, contents );
    
    if ( !poscandidate )
    {
        return;
    }
    
    poscandidate = getclosestpointonnavmesh( poscandidate, self );
    
    if ( !poscandidate )
    {
        return;
    }
    
    poscandidate = br_public::droptogroundmultitrace( poscandidate, var_1e87437938318e4d, var_eb1d012d76bb4611 * -1, contents );
    
    if ( function_d9d16b6c88a01ec0( poscandidate ) )
    {
        return poscandidate;
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0x664f1569, Offset: 0x28ab
// Size: 0x80, Type: bool
function private function_d9d16b6c88a01ec0( poscandidate, var_c2ba0458c5e61bd2 = 1 )
{
    var_52369f6e13659a30 = 5;
    var_1b936cc6ee5ea5f4 = 45;
    
    if ( !poscandidate )
    {
        return false;
    }
    
    if ( var_c2ba0458c5e61bd2 )
    {
        if ( br_circle_util::gettimetilldangerforpoint( poscandidate ) < var_1b936cc6ee5ea5f4 )
        {
            return false;
        }
    }
    else if ( br_circle::function_6bf5d4e680297398( poscandidate ) )
    {
        return false;
    }
    
    if ( function_685c23b0b0ebf271( poscandidate ) )
    {
        return false;
    }
    
    if ( bots_gametype_br_super::function_209a171e55670383( poscandidate, var_52369f6e13659a30 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace manager
// Params 3, eflags: 0x4
// Checksum 0x424482b9, Offset: 0x2934
// Size: 0x6c
function private teleportafteroffnavmesh( prevpos, teleportpos, reason )
{
    super_bot::function_cb27523a07bf9c83( 1, self, "manager::teleportafteroffnavmesh", "teleport from " + prevpos + " to " + teleportpos + ". reason: " + reason, "" );
    namespace_ddca46d216b096e2::onplayerteleport( self, prevpos, teleportpos, reason );
    self setorigin( teleportpos );
    self notify( #"try_to_recover_from_off_navmesh_thread_ended" );
}

// Namespace manager
// Params 0
// Checksum 0x15a508ef, Offset: 0x29a8
// Size: 0xc, Type: bool
function isinitialized()
{
    return isdefined( level.uibotmanager );
}

// Namespace manager
// Params 0
// Checksum 0xd0cb197d, Offset: 0x29bd
// Size: 0x16, Type: bool
function function_5c79ebe77f7d0528()
{
    return istrue( self.uibot.var_5c79ebe77f7d0528 );
}

// Namespace manager
// Params 0
// Checksum 0x57678ff6, Offset: 0x29dc
// Size: 0x2c, Type: bool
function isuibot()
{
    return self.uibot.isuibot || self.uibot.var_a29e5f57c1ef9e35;
}

// Namespace manager
// Params 0
// Checksum 0xca411799, Offset: 0x2a11
// Size: 0x16, Type: bool
function function_7f3b0449df3d77e()
{
    return istrue( self.uibot.var_a29e5f57c1ef9e35 );
}

// Namespace manager
// Params 0
// Checksum 0xd128ed48, Offset: 0x2a30
// Size: 0x24
function function_cda6de7e2ba52066()
{
    if ( isinitialized() )
    {
        return level.uibotmanager.uibots;
    }
    
    return [];
}

// Namespace manager
// Params 0
// Checksum 0xb08acac4, Offset: 0x2a5c
// Size: 0x25
function function_6f7e22d4e6adac55()
{
    if ( isinitialized() )
    {
        return level.uibotmanager.uibots.size;
    }
    
    return 0;
}

// Namespace manager
// Params 2
// Checksum 0xd65121ba, Offset: 0x2a89
// Size: 0xbf, Type: bool
function function_4dfbc17508653434( team, squad )
{
    if ( isinitialized() )
    {
        foreach ( botprofile in level.uibotmanager.uibots )
        {
            if ( botprofile.team == team && botprofile.squad == squad )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x21c25b19, Offset: 0x2b51
// Size: 0x107
function private function_bf9aa97c60d35f0f()
{
    if ( !level.uibotmanager.var_d3b6a107b3176710 )
    {
        return;
    }
    
    weightsstring = level.uibotmanager.var_2432a9ec51aedf68;
    
    if ( !weightsstring )
    {
        return;
    }
    
    weightstrings = strtok( weightsstring, "," );
    size = weightstrings.size;
    assert( size <= 4, "<dev string:x62>" );
    
    if ( size <= 1 )
    {
        return;
    }
    
    list = [];
    sum = 0;
    
    for ( i = 0; i < size ; i++ )
    {
        weight = int( weightstrings[ i ] );
        
        if ( weight < 0 )
        {
            assertmsg( "<dev string:xac>" );
            return;
        }
        
        sum += weight;
        list[ i ] = sum;
    }
    
    if ( sum == 0 || sum == list[ 0 ] )
    {
        return;
    }
    
    return { #sum:sum, #list:list };
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x546e9b24, Offset: 0x2c61
// Size: 0x9d
function private onplayerkilled( deathdata )
{
    var_bd65b7cd5e58bb4c = isplayer( deathdata.attacker ) && !isbot( deathdata.attacker );
    var_366531bf23208fb1 = var_bd65b7cd5e58bb4c && isbot( deathdata.victim );
    
    if ( !var_366531bf23208fb1 )
    {
        return;
    }
    
    bot = deathdata.victim;
    
    if ( !isdefined( bot.var_f47c3623b7703db4 ) )
    {
        bot.var_f47c3623b7703db4 = 0;
    }
    
    bot.var_f47c3623b7703db4++;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x137b7e1f, Offset: 0x2d06
// Size: 0xa9
function private on_match_end( data )
{
    var_18c5517430ff983b = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        var_18c5517430ff983b[ var_18c5517430ff983b.size ] = level.uibotmanager.var_e922d98b52d61f52[ i ];
    }
    
    dlog_recordevent( "dlog_event_br_ui_bot_summary", [ "squad_deploy_total_switch_dvar_value", level.uibotmanager.var_d3b6a107b3176710, "squad_deploy_count_weight_dvar_value", level.uibotmanager.var_2432a9ec51aedf68, "count_of_squad_deploys", var_18c5517430ff983b ] );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x573ced9f, Offset: 0x2db7
// Size: 0x2e
function private function_58be13642e7817dd( player )
{
    if ( isbot( player ) )
    {
        function_a954c895198d5335( player );
        return;
    }
    
    player.engageinfo = {};
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x7e733c06, Offset: 0x2ded
// Size: 0x3e
function private function_a954c895198d5335( bot )
{
    assert( isbot( bot ) );
    
    if ( !isdefined( bot.uibot ) )
    {
        bot.uibot = {};
    }
    
    bot thread dormant_bot::thinkthread();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xd1b8fed6, Offset: 0x2e33
// Size: 0x3e
function private function_9172e0fbaaa3798d()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( isdefined( player ) )
        {
            function_58be13642e7817dd( player );
        }
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x2a1f09eb, Offset: 0x2e79
// Size: 0x62
function private function_df4d32c41e962dc5()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        pendingbots = recycle_manager::function_8bdda6f455e12bfd();
        
        for ( i = pendingbots.size - 1; i >= 0 ; i-- )
        {
            bot = pendingbots[ i ];
            function_a954c895198d5335( bot );
            pendingbots[ i ] = undefined;
        }
        
        waitframe();
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xbd910da4, Offset: 0x2ee3
// Size: 0x1e
function private function_47514ccbc45eb8a()
{
    level endon( #"game_ended" );
    level childthread function_8850918abb61de86();
    level childthread function_df17d2572872b866();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xe86c9856, Offset: 0x2f09
// Size: 0x19d
function private function_8850918abb61de86()
{
    if ( level.skipprematch )
    {
        return;
    }
    
    level waittill( #"player_spawned" );
    
    while ( gamelogic_mp::inprematch() )
    {
        /#
            if ( function_ea7657925c67cd44() )
            {
                wait 1;
                continue;
            }
        #/
        
        remainingslots = function_f61bdf086a344ace();
        ui_bot::activatesome( remainingslots, "SpawnInPrematch" );
        wait 1;
    }
    
    if ( function_a0e7b7d42c9dbf4b() )
    {
        level thread function_da026019a5507f80();
    }
    
    var_515c3f527c0693a3 = function_316d0d6cf6d4fbd5();
    
    if ( var_515c3f527c0693a3 < 0 )
    {
        /#
            if ( function_5038e868414d50c0() )
            {
                return;
            }
        #/
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && !player isuibot() )
            {
                success = player ui_bot::tryrecycle( "infil active bot count limit" );
                
                if ( success )
                {
                    var_515c3f527c0693a3++;
                    
                    if ( var_515c3f527c0693a3 == 0 )
                    {
                        break;
                    }
                }
            }
        }
        
        return;
    }
    
    if ( var_515c3f527c0693a3 > 0 )
    {
        /#
            if ( function_ea7657925c67cd44() )
            {
                return;
            }
        #/
        
        if ( getdvarint( @"hash_507246de68676735", 1 ) )
        {
            function_f64a7b2a5fce5239( var_515c3f527c0693a3, "ActivateUIBotsAfterPrematch early stage" );
        }
        else
        {
            function_5c94ef1851c7bd10();
        }
        
        var_515c3f527c0693a3 = function_316d0d6cf6d4fbd5();
        
        if ( var_515c3f527c0693a3 > 0 )
        {
            ui_bot::batchactivatesome( var_515c3f527c0693a3, "ActivateUIBotsAfterPrematch late stage" );
        }
    }
}

// Namespace manager
// Params 0
// Checksum 0x32578810, Offset: 0x30ae
// Size: 0x2a, Type: bool
function function_a0e7b7d42c9dbf4b()
{
    profilestart();
    profilestop();
    return getdvarint( @"hash_f4e1665e4314d4e4", 1 ) && !level.br_infils_disabled && !isdmzgamemode();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xf6941790, Offset: 0x30e2
// Size: 0xf0
function private function_da026019a5507f80()
{
    level endon( #"game_ended" );
    level endon( #"br_c130_left_bounds" );
    
    if ( level.var_b5bcc118447f65ed )
    {
        return;
    }
    
    level.var_b5bcc118447f65ed = 1;
    logstring( "[Super Bots] Pre-give infil loadout thread start" );
    var_32524209bfc55f0d = getdvarint( @"hash_2480b0403a09a434", 3 ) * 1000;
    var_7cf06aa875538a54 = getdvarfloat( @"hash_f05bffd4debf49ec", 0.1 );
    var_f6ac71b12eb3b56b = var_7cf06aa875538a54 * 1000;
    var_88442a91e2c94a92 = gettime() + var_32524209bfc55f0d - var_f6ac71b12eb3b56b;
    
    while ( true )
    {
        nowms = gettime();
        deltams = nowms - var_88442a91e2c94a92;
        
        if ( deltams >= var_f6ac71b12eb3b56b )
        {
            bot = function_7dcba56905ae5ed();
            
            if ( isdefined( bot ) )
            {
                bot function_1d9c63f8582cc949();
                var_88442a91e2c94a92 = nowms;
                wait var_7cf06aa875538a54;
                continue;
            }
        }
        
        waitframe();
    }
}

// Namespace manager
// Params 1
// Checksum 0x26ee7b01, Offset: 0x31da
// Size: 0xb6
function function_89073acfbf418766( bots )
{
    profilestart();
    
    if ( !isdefined( level.var_3d45b842164b33dd ) )
    {
        level.var_3d45b842164b33dd = [];
    }
    
    foreach ( bot in bots )
    {
        if ( isbot( bot ) )
        {
            bot thread function_892e2220ccaea456();
            level.var_3d45b842164b33dd[ level.var_3d45b842164b33dd.size ] = bot;
        }
    }
    
    profilestop();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x5226c5fe, Offset: 0x3298
// Size: 0x2c
function private function_892e2220ccaea456()
{
    utility::waittill_any_ents( self, "death_or_disconnect", self, "br_jump" );
    level.var_3d45b842164b33dd = arrayremove( level.var_3d45b842164b33dd, self );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x301928b5, Offset: 0x32cc
// Size: 0x67
function private function_7dcba56905ae5ed()
{
    profilestart();
    ret = undefined;
    queuesize = isdefined( level.var_3d45b842164b33dd ) ? level.var_3d45b842164b33dd.size : 0;
    
    if ( queuesize > 0 )
    {
        ret = level.var_3d45b842164b33dd[ queuesize - 1 ];
        level.var_3d45b842164b33dd[ level.var_3d45b842164b33dd.size - 1 ] = undefined;
    }
    
    profilestop();
    return ret;
}

// Namespace manager
// Params 0
// Checksum 0xbfc57fd3, Offset: 0x333d
// Size: 0x18
function function_aac2f27c8c7188b2()
{
    profilestart();
    
    if ( isbot( self ) )
    {
        profilestop();
        return self.PregiveInfilLoadout;
    }
    
    profilestop();
    return 0;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x69301ea5, Offset: 0x335f
// Size: 0x26
function private function_1d9c63f8582cc949()
{
    logstring( "[Super Bots] Pre-give infil jump loadout to " + self.name );
    
    if ( PregiveInfilLoadout() )
    {
        thread function_208d1d5a6f462861();
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x149388d4, Offset: 0x338d
// Size: 0x5f, Type: bool
function private PregiveInfilLoadout()
{
    if ( !isdefined( level.parachuterestoreweaponscb ) )
    {
        logstring( "[Super Bots] Skip pregive infil loadout, as level.parachuteRestoreWeaponsCB is undefined" );
        return false;
    }
    
    if ( level.parachuterestoreweaponscb == &br::nakeddrop )
    {
        br::function_a4e03dfaa3f6a302();
        return true;
    }
    
    if ( level.parachuterestoreweaponscb == &br::loadoutdrop )
    {
        function_50bb926e2643daab();
        return true;
    }
    
    logstring( "[Super Bots] Warning, unknown level.parachuteRestoreWeaponsCB detected in PregiveInfilLoadout" );
    return false;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x49f5442f, Offset: 0x33f5
// Size: 0x2b
function private function_50bb926e2643daab()
{
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( level.defaultfist ) )
    {
        inventory_utility::abortmonitoredweaponswitch( level.defaultfist );
    }
    
    br::loadoutdrop();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xb5e2bfe0, Offset: 0x3428
// Size: 0x8a
function private function_208d1d5a6f462861()
{
    level endon( #"game_ended" );
    
    if ( !isbot( self ) )
    {
        assertmsg( "<dev string:xfa>" );
        return;
    }
    
    self.PregiveInfilLoadout = 1;
    
    if ( "infil_jump_done" == utility::waittill_any_in_array_return( [ "death_or_disconnect", "infil_jump_done" ] ) )
    {
        utility::waittill_any_in_array_return( [ "death_or_disconnect", "parachute_complete" ] );
    }
    
    self.PregiveInfilLoadout = undefined;
    logstring( "[Super Bots] Clear the pre-give infil loadout flag from " + self.name );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x979857c1, Offset: 0x34ba
// Size: 0x1d
function private function_5c94ef1851c7bd10()
{
    utility::waittill_any_ents( level, "br_c130_in_bounds", level.br_ac130, "start_moving" );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xe50b78f, Offset: 0x34df
// Size: 0x29
function private function_aaec0ee04531bd65()
{
    function_5c94ef1851c7bd10();
    level.uibotmanager.var_28b9f929f3f6fcad = 1;
    logstring( "[Super Bots] MonitorC130StatesThread: C130 is in bounds or started moving, stop ActivateBotsForInfilSeq()." );
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xb46517e8, Offset: 0x3510
// Size: 0xb4
function private function_f64a7b2a5fce5239( count, reason )
{
    level.uibotmanager.var_28b9f929f3f6fcad = 0;
    level thread function_aaec0ee04531bd65();
    delay = getdvarint( @"hash_c08a6261affc6741", 3 );
    wait delay;
    
    for ( i = 0; i < count ; i++ )
    {
        if ( level.uibotmanager.var_28b9f929f3f6fcad )
        {
            logstring( "[Super Bots] ActivateBotsForInfilSeq: interrupted. completed=" + i + " total=" + count );
            return;
        }
        
        ui_bot::batchactivatesome( 1, reason );
        waitframe();
    }
    
    logstring( "[Super Bots] ActivateBotsForInfilSeq: completed activating " + count + " bots." );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xcefa7bf7, Offset: 0x35cc
// Size: 0xdc
function private function_f61bdf086a344ace( excludeplayer )
{
    assert( gamelogic_mp::inprematch() );
    activeplayercount = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && excludeplayer != player )
        {
            if ( !isbot( player ) || !player isuibot() )
            {
                activeplayercount++;
            }
        }
    }
    
    remainingslots = function_9228d096a2ad4d4e() - activeplayercount;
    
    if ( remainingslots < 0 )
    {
        remainingslots = 0;
    }
    
    return remainingslots;
}

// Namespace manager
// Params 0
// Checksum 0x5209ccee, Offset: 0x36b1
// Size: 0x11
function function_9228d096a2ad4d4e()
{
    return getdvarint( @"hash_e82992eec48cf830", 20 );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x8a675d70, Offset: 0x36cb
// Size: 0x76
function private function_316d0d6cf6d4fbd5()
{
    var_24818f4b29390812 = function_6d33e798ea133b26();
    var_8081ad022efece4e = getdvarfloat( @"hash_a9691c347e9bb21c", level.var_d4909c0acc55763c.var_8081ad022efece4e ?? 1 );
    var_627db0ab71a3c5a6 = int( var_24818f4b29390812 * clamp( var_8081ad022efece4e, 0, 1 ) );
    return var_627db0ab71a3c5a6 - var_24818f4b29390812 - level.uibotmanager.uibots.size;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xb4c5c045, Offset: 0x374a
// Size: 0x28
function private function_9ff832be0c4f3767()
{
    var_24818f4b29390812 = function_6d33e798ea133b26();
    var_e80c8c40878d9b3a = function_36190423313d0956();
    return var_24818f4b29390812 / var_e80c8c40878d9b3a;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x75fd9de, Offset: 0x377b
// Size: 0x5d
function private function_36190423313d0956()
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        uibotcount = 0;
        
        if ( !recycle_manager::isenabled() )
        {
            uibotcount = level.uibotmanager.uibots.size;
        }
        
        return ( level.players.size + uibotcount );
    }
    
    var_8edadc37f77744f7 = 0;
    return getpartyinfo( var_8edadc37f77744f7 ).size;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x9d93ecf5, Offset: 0x37e0
// Size: 0x14e
function private function_6d33e798ea133b26()
{
    botcount = 0;
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                botcount++;
            }
        }
        
        if ( !recycle_manager::isenabled() )
        {
            botcount += level.uibotmanager.uibots.size;
        }
    }
    else
    {
        var_8edadc37f77744f7 = 0;
        partymembers = getpartyinfo( var_8edadc37f77744f7 );
        
        foreach ( memberinfo in partymembers )
        {
            if ( memberinfo.isai )
            {
                botcount++;
            }
        }
    }
    
    return botcount;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xa9cc3c9f, Offset: 0x3937
// Size: 0x182
function private function_c3f5e944666b1d68( teamname )
{
    allteammembers = teams::getteamdata( teamname, "players" );
    var_9870b8dad8060290 = [];
    
    foreach ( player in allteammembers )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( player bots_gametype_br_super::iseliminated() )
        {
            continue;
        }
        
        var_23df525ae80cfbff = player br_public::isplayerinorgoingtogulag() || !namespace_ef4547f85724edd1::isaliveplayer( player ) || player isskydiving() || player isparachuting();
        
        if ( var_23df525ae80cfbff )
        {
            continue;
        }
        
        var_9870b8dad8060290[ var_9870b8dad8060290.size ] = player;
    }
    
    if ( var_9870b8dad8060290.size > 0 && bots_gametype_br_super::function_3130ca8d103182cd() )
    {
        foreach ( player in allteammembers )
        {
            if ( isbot( player ) && namespace_ef4547f85724edd1::isvalidplayer( player ) )
            {
                var_9870b8dad8060290[ var_9870b8dad8060290.size ] = player;
            }
        }
    }
    
    return var_9870b8dad8060290;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xcdf0408d, Offset: 0x3ac2
// Size: 0x21e
function private function_df17d2572872b866()
{
    if ( level.br_infils_disabled )
    {
        level waittill( #"player_spawned" );
    }
    else
    {
        level waittill( #"br_c130_left_bounds" );
    }
    
    terminatorenabled = getdvarint( @"hash_e7e9bb130c1ca431", 0 );
    
    if ( terminatorenabled )
    {
        thread terminatorthread();
    }
    
    while ( true )
    {
        /#
            if ( function_ea7657925c67cd44() )
            {
                wait 1;
                continue;
            }
        #/
        
        var_5853c9ff94881696 = [];
        hashuman = 0;
        var_3b9407427727d600 = 0;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                continue;
            }
            
            hashuman = 1;
            var_45d06df43637678b = player bots_gametype_br_super::iseliminated();
            
            if ( var_45d06df43637678b )
            {
                if ( !var_3b9407427727d600 && game_utility::getgametype() == "resurgence" && player.team )
                {
                    aliveteammates = teams::getteamdata( player.team, "alivePlayers" );
                    
                    if ( aliveteammates.size > 0 )
                    {
                        var_3b9407427727d600 = 1;
                    }
                }
                
                continue;
            }
            
            if ( player.team )
            {
                var_5853c9ff94881696[ player.team ] = 1;
            }
            
            var_3b9407427727d600 = 1;
        }
        
        nohumanalivebutspectating = hashuman && !var_3b9407427727d600;
        
        if ( nohumanalivebutspectating )
        {
            level.uibotmanager.var_9d03093deceb509e = 1;
            thread deployalluibotsthread( "noHumanAliveButSpectating" );
            level notify( #"hash_3b64378f01c42702" );
            break;
        }
        
        var_c5583991718a7b95 = var_5853c9ff94881696.size > 0;
        
        /#
            if ( getdvarint( @"hash_25920b075500f084", 0 ) )
            {
                var_c5583991718a7b95 = 0;
            }
        #/
        
        if ( !var_c5583991718a7b95 )
        {
            wait 1;
            continue;
        }
        
        function_c817ad5a3fa6b085( var_5853c9ff94881696 );
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0x874107ec, Offset: 0x3ce8
// Size: 0x19c
function private function_c817ad5a3fa6b085( var_5853c9ff94881696, var_4c96ec31fb14e73c )
{
    var_4c96ec31fb14e73c = getdvarint( @"hash_363cbfc382012add", 0 );
    var_6873bf8392794f3 = getdvarint( @"hash_19e17ef5c2c30b03", 100000 );
    framebudget = 1 / level.framedurationseconds;
    assert( framebudget > 0 );
    var_1bc32c8655564048 = int( ceil( var_5853c9ff94881696.size / framebudget ) );
    assert( var_1bc32c8655564048 > 0 );
    var_cb30333277559d2e = gettime();
    iteam = 0;
    
    foreach ( teamname, _ in var_5853c9ff94881696 )
    {
        if ( iteam > 0 && iteam % var_1bc32c8655564048 == 0 )
        {
            waitframe();
        }
        
        var_9870b8dad8060290 = function_c3f5e944666b1d68( teamname );
        
        if ( var_9870b8dad8060290.size > 0 )
        {
            function_a8da63f27e720669( var_9870b8dad8060290, 1 );
            
            if ( var_4c96ec31fb14e73c && !islategame() )
            {
                function_d81a1748445b5c80( var_9870b8dad8060290, var_6873bf8392794f3 );
            }
        }
        
        iteam++;
    }
    
    processingdurationms = gettime() - var_cb30333277559d2e;
    var_5ede1f96d1940ba0 = max( 1 - processingdurationms * 0.001, level.framedurationseconds );
    wait var_5ede1f96d1940ba0;
}

// Namespace manager
// Params 3, eflags: 0x4
// Checksum 0xdaf07498, Offset: 0x3e8c
// Size: 0x36d
function private function_a8da63f27e720669( teammembers, updateinterval, var_7d1337601407c4b6 )
{
    lategame = islategame();
    currenttime = gettime();
    var_a7a0c0db50171f48 = getdvarint( @"hash_3d8ce2c99aa4db2b", 1 ) * getdvarint( @"hash_3d8ce2c99aa4db2b", 1 );
    var_e5547906cba44ca4 = getdvarint( @"hash_9be4e2fbbfe8d9c5", 0 );
    assert( var_e5547906cba44ca4 >= 0 && var_e5547906cba44ca4 < 1000 );
    var_e5547906cba44ca4 *= updateinterval;
    var_2829f5261ca3d6fe = getdvarint( @"hash_e32340e297efbbdd", level.var_d4909c0acc55763c.var_ddc9581e26097219 ?? 45000 );
    
    if ( level.uibotmanager.var_d3b6a107b3176710 )
    {
        var_23ed539c4746866f = getdvarfloat( @"hash_dc5fb213944c652a", 3800 ) * getdvarfloat( @"hash_dc5fb213944c652a", 3800 );
        var_baedd674e0c44b50 = getdvarfloat( @"hash_7a2bb3526e928fe9", 3000 );
    }
    else
    {
        var_23ed539c4746866f = 0;
        var_baedd674e0c44b50 = 0;
    }
    
    var_50b068ef5caa9147 = [];
    
    foreach ( player in teammembers )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        var_b24ecf0a1e3b89fb = player bots_gametype_br_super::function_ed2438a9aac046ff( teammembers, 0, var_23ed539c4746866f );
        
        if ( lategame || isdefined( var_7d1337601407c4b6 ) )
        {
            shoulddeploy = 1;
        }
        else
        {
            var_d777bbbf47ed1abc = function_7bedabc7931a4ad4( var_b24ecf0a1e3b89fb, 0 );
            var_451d2e7fd1781553 = currenttime - var_d777bbbf47ed1abc;
            engageinfo = player.engageinfo;
            
            if ( engageinfo.var_d777bbbf47ed1abc != var_d777bbbf47ed1abc )
            {
                engageinfo.var_e8908f05f3239d11 = 0;
                engageinfo.var_d777bbbf47ed1abc = var_d777bbbf47ed1abc;
            }
            
            if ( var_451d2e7fd1781553 > 0 )
            {
                velocity = player getvelocity();
                speedsqr = lengthsquared( velocity );
                
                if ( speedsqr < var_a7a0c0db50171f48 )
                {
                    engageinfo.var_e8908f05f3239d11 += var_e5547906cba44ca4;
                }
            }
            
            shoulddeploy = var_451d2e7fd1781553 >= var_2829f5261ca3d6fe + engageinfo.var_e8908f05f3239d11;
            
            if ( shoulddeploy )
            {
                foreach ( member in var_b24ecf0a1e3b89fb )
                {
                    memberid = member getentitynumber();
                    
                    if ( !isdefined( var_50b068ef5caa9147[ memberid ] ) )
                    {
                        var_50b068ef5caa9147[ memberid ] = member function_bc43fc611d9ca696( var_baedd674e0c44b50 );
                    }
                    
                    if ( var_50b068ef5caa9147[ memberid ] )
                    {
                        shoulddeploy = 0;
                        break;
                    }
                }
            }
        }
        
        if ( shoulddeploy )
        {
            player.engageinfo.var_e8908f05f3239d11 = 0;
            player thread ui_bot::DeployEngagingBotsThread( var_b24ecf0a1e3b89fb, var_7d1337601407c4b6 );
        }
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xaf2f1e7a, Offset: 0x4201
// Size: 0xde
function private function_d81a1748445b5c80( teammembers, var_6873bf8392794f3 )
{
    currenttime = gettime();
    
    foreach ( player in teammembers )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        var_b24ecf0a1e3b89fb = player bots_gametype_br_super::function_ed2438a9aac046ff( teammembers );
        var_d777bbbf47ed1abc = function_7bedabc7931a4ad4( var_b24ecf0a1e3b89fb, 1 );
        var_451d2e7fd1781553 = currenttime - var_d777bbbf47ed1abc;
        
        if ( var_451d2e7fd1781553 >= var_6873bf8392794f3 )
        {
            player thread ui_bot::function_6affd1a72f874d5e( var_b24ecf0a1e3b89fb );
        }
    }
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xa9d44f45, Offset: 0x42e7
// Size: 0xac
function private function_7bedabc7931a4ad4( players, var_1533edc7745d018 )
{
    var_93ab82593997e895 = undefined;
    
    foreach ( player in players )
    {
        lasttime = player bots_gametype_br_super::function_8181bb30c95b9d6e( var_1533edc7745d018 );
        
        if ( lasttime <= var_93ab82593997e895 )
        {
            continue;
        }
        
        var_93ab82593997e895 = lasttime;
    }
    
    return var_93ab82593997e895;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xf8b1dda6, Offset: 0x439c
// Size: 0xc7, Type: bool
function private function_bc43fc611d9ca696( radius )
{
    if ( radius <= 0 )
    {
        return false;
    }
    
    teammembers = teams::getteamdata( self.team, "players" );
    var_387866edce1dd08f = utility::playersinsphere( self.origin, radius, teammembers );
    
    foreach ( player in var_387866edce1dd08f )
    {
        if ( namespace_ef4547f85724edd1::isvalidplayer( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace manager
// Params 0
// Checksum 0x562c489c, Offset: 0x446c
// Size: 0x23
function islategame()
{
    var_ffaf36e54180886c = function_55e0d31727ed1c59();
    
    if ( isdefined( var_ffaf36e54180886c ) )
    {
        return var_ffaf36e54180886c;
    }
    
    return function_7d5107561790e20e();
}

// Namespace manager
// Params 0
// Checksum 0x483a038, Offset: 0x4498
// Size: 0x1c, Type: bool
function function_7d5107561790e20e()
{
    return br::isgulagshutdown() || respawndisabled() || function_9aa423a8fcac9f1a();
}

// Namespace manager
// Params 0
// Checksum 0x81dfb5e1, Offset: 0x44bd
// Size: 0x57
function function_55e0d31727ed1c59()
{
    threshold = level.uibotmanager.var_d9dd3d1abbed36da;
    
    if ( threshold >= 0 && isdefined( level.br_circle.circleindex ) )
    {
        return ( level.br_circle.circleindex >= threshold );
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x238802f1, Offset: 0x451d
// Size: 0x2e, Type: bool
function private respawndisabled()
{
    return isdefined( level.brgametype.respawnenable ) && !level.brgametype.respawnenable;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x3ae0241d, Offset: 0x4554
// Size: 0x23, Type: bool
function private function_9aa423a8fcac9f1a()
{
    return isdefined( level.br_alt_mode_inflation ) && level.br_alt_mode_inflation.disabled;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x94eb5d8, Offset: 0x4580
// Size: 0x136
function private deployalluibotsthread( reason )
{
    level endon( #"game_ended" );
    logstring( "[Super Bots] DeployAllUIBotsThread start" );
    namespace_ddca46d216b096e2::function_a8bd6173ca7191ff( "begin", reason, level.uibotmanager.uibots.size );
    
    while ( level.uibotmanager.uibots.size > 0 )
    {
        count = level.uibotmanager.uibots.size;
        
        for ( i = 0; i < count ; i++ )
        {
            botprofile = ui_bot::function_f5217c40f361a65f();
            
            if ( !isdefined( botprofile ) )
            {
                break;
            }
            
            bot = botprofile ui_bot::activate( reason );
            
            if ( isdefined( bot ) )
            {
                streamtimeout = getdvarint( @"hash_a022906be1321bb1", 2 );
                deployedpos = bot br_spawnrespawn::playergetrespawnpoint( 0, streamtimeout ).origin;
                bot ui_bot::function_e3b21c39cf9362df( deployedpos, #"config", reason );
            }
        }
        
        wait 1;
    }
    
    namespace_ddca46d216b096e2::function_a8bd6173ca7191ff( "end", reason );
    logstring( "[Super Bots] DeployAllUIBotsThread end" );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x11c7b38e, Offset: 0x46be
// Size: 0xa4
function private function_18bd5f2893d0e198()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        msg = level utility::waittill_any_in_array_return( [ "ui_bot_counter_updated", "updatePlayerAndTeamCountUI" ] );
        
        if ( msg == "updatePlayerAndTeamCountUI" )
        {
            level.uibotmanager.dormantbots = function_5713d46873b29625( level.uibotmanager.dormantbots );
            level.uibotmanager.uibots = function_5713d46873b29625( level.uibotmanager.uibots );
        }
        
        function_f39931a3ba35902f();
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xc1fbf786, Offset: 0x476a
// Size: 0x187
function private function_f39931a3ba35902f()
{
    if ( getdvarint( @"hash_a2d26b607a32e157", 0 ) == 1 )
    {
        dormantbotnum = level.uibotmanager.dormantbots.size;
        uibotnum = level.uibotmanager.uibots.size;
        totalalivebotnum = 0;
        var_1a082453df7103a1 = 0;
        var_90acd7c2f9a8ac08 = 0;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                if ( !player bots_gametype_br_super::iseliminated() && !player isuibot() )
                {
                    if ( player br_public::isplayerinorgoingtogulag() )
                    {
                        var_1a082453df7103a1++;
                    }
                    else
                    {
                        totalalivebotnum++;
                    }
                }
                
                continue;
            }
            
            if ( bots_gametype_br_super::function_af39e3160ea3eca4( player ) )
            {
                var_90acd7c2f9a8ac08++;
            }
        }
        
        activebotnum = totalalivebotnum - dormantbotnum;
        var_a187995f65a64fdb = ( uibotnum << 24 ) + ( dormantbotnum << 16 ) + ( activebotnum << 8 ) + var_90acd7c2f9a8ac08;
        setomnvar( "ui_br_matchinfo_bot_stats", var_a187995f65a64fdb );
        setomnvar( "ui_br_matchinfo_bot_gulag_stats", var_1a082453df7103a1 );
        return;
    }
    
    setomnvar( "ui_br_matchinfo_bot_stats", 0 );
    setomnvar( "ui_br_matchinfo_bot_gulag_stats", 0 );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xedc44851, Offset: 0x48f9
// Size: 0x1c7
function private function_764608ba2cfbb62d()
{
    level endon( #"game_ended" );
    
    if ( level.br_infils_disabled )
    {
        level waittill( #"player_spawned" );
    }
    else
    {
        level waittill( #"br_c130_left_bounds" );
    }
    
    const_m = 1.15;
    const_n = 1.2;
    
    while ( true )
    {
        interval = getdvarint( @"hash_e0ec70c334cf532a", 30 );
        var_e62611239504fa06 = function_8418317300aae6fc();
        
        if ( var_e62611239504fa06 > 0 )
        {
            alivecount = function_121588beddc263f9();
            aliveratio = alivecount / var_e62611239504fa06;
            
            if ( aliveratio > const_m )
            {
                interval = clamp( pow( 1 / ( aliveratio - const_m ), const_n ), 1, interval );
            }
        }
        
        msg = level utility::waittill_any_in_array_or_timeout( [ "player_killed" ], interval );
        
        if ( msg == "player_killed" )
        {
            waitframe();
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_dd9f8b3596ac0b3d", 0 ) > 0 )
            {
                iprintln( "<dev string:x132>" );
                continue;
            }
        #/
        
        dormantbotcount = level.uibotmanager.dormantbots.size;
        
        if ( dormantbotcount != 0 )
        {
            var_d9287068b2cedc72 = undefined;
            
            for ( index = 0; index < dormantbotcount ; index++ )
            {
                dormantbot = level.uibotmanager.dormantbots[ index ];
                
                if ( !dormantbot bots_gametype_br_super::function_d0fa014a2d896bdc() )
                {
                    var_d9287068b2cedc72 = dormantbot;
                    break;
                }
            }
            
            if ( isdefined( var_d9287068b2cedc72 ) )
            {
                var_d9287068b2cedc72 dormant_bot::activate();
                var_d9287068b2cedc72 dodamage( var_d9287068b2cedc72.health + 10000, var_d9287068b2cedc72.origin, var_d9287068b2cedc72 );
            }
        }
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x62489643, Offset: 0x4ac8
// Size: 0x24
function private function_f36fea03ef7f1ac7()
{
    if ( getdvarint( @"hash_19a1138753a78216", 1 ) == 1 )
    {
        return function_5caf3c3a4fc8bcac();
    }
    
    return function_20d79c3a23413ff5();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xa4d7f7fd, Offset: 0x4af5
// Size: 0x2f8
function private function_20d79c3a23413ff5()
{
    tablename = "mp/br_bot_survival_curve.csv";
    partymaxplayers = getdvarint( @"party_maxplayers", 150 );
    var_fb33372fdd0090cd = tableexists( tablename );
    assert( var_fb33372fdd0090cd, "<dev string:x186>" );
    
    if ( var_fb33372fdd0090cd && isdefined( level.br_level.br_circledelaytimes ) )
    {
        var_e9e0e8b928051220 = 0;
        
        for ( circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount ; circleindex++ )
        {
            var_e9e0e8b928051220 += level.br_level.br_circleclosetimes[ circleindex ];
            var_e9e0e8b928051220 += level.br_level.br_circledelaytimes[ circleindex ];
        }
        
        points = [];
        targetmapname = getdvar( @"g_mapname" );
        targetgametype = game_utility::getgametype();
        targetpreset = getdvarint( @"scr_br_bot_survival_curve_preset", 0 );
        foundmap = 0;
        rownum = tablelookupgetnumrows( tablename );
        
        for ( row = 0; row < rownum ; row++ )
        {
            mapname = tablelookupbyrow( tablename, row, 0 );
            gametype = tablelookupbyrow( tablename, row, 1 );
            preset = int( tablelookupbyrow( tablename, row, 2 ) );
            
            if ( mapname == targetmapname && gametype == targetgametype && preset == targetpreset )
            {
                foundmap = 1;
                progress = int( tablelookupbyrow( tablename, row, 3 ) ) / 100;
                assert( progress >= 0 && progress <= 100 );
                aliveratio = int( tablelookupbyrow( tablename, row, 4 ) ) / 100;
                uibotratio = int( tablelookupbyrow( tablename, row, 5 ) ) / 100;
                threshold = int( tablelookupbyrow( tablename, row, 6 ) ) / 100;
                time = var_e9e0e8b928051220 * progress * 1000;
                alivecount = aliveratio * partymaxplayers;
                thresholdcount = alivecount * threshold;
                maxalivecount = min( alivecount + thresholdcount, partymaxplayers );
                var_d4441a2319b5a1d6 = alivecount - thresholdcount;
                uibotcount = uibotratio * partymaxplayers;
                point = [ #"ui_bot_count":uibotcount, #"min_alive_count":var_d4441a2319b5a1d6, #"max_alive_count":maxalivecount, #"alive_count":alivecount, #"time":time ];
                points[ points.size ] = point;
                continue;
            }
            
            if ( foundmap )
            {
                break;
            }
        }
        
        if ( points.size > 0 )
        {
            return points;
        }
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x7a149c85, Offset: 0x4df6
// Size: 0x1f7
function private function_a7e934abca28230d()
{
    curveentries = [];
    bundlehash = level.gametypebundle.var_4b340b623e2f11b4;
    
    if ( !bundlehash )
    {
        assertmsg( "<dev string:x1af>" );
        logstring( "[Super Bots][WARNING] GetCandidateSurvivalCurves: survival curve is not defined in gametypebundle." );
        return curveentries;
    }
    
    bundlename = getxhashhexname( bundlehash );
    
    /#
        bundlename = getxhashsourcename( bundlehash );
    #/
    
    bundle = getscriptbundle( bundlehash );
    
    if ( !bundle )
    {
        assertmsg( "<dev string:x1e0>" + bundlename + "<dev string:x1f7>" );
        logstring( "[Super Bots][WARNING] GetCandidateSurvivalCurves: survival curve bundle " + bundlename + " is not found." );
        return curveentries;
    }
    
    for ( i = 0; i < bundle.survivalentries.size ; i++ )
    {
        entry = bundle.survivalentries[ i ];
        survivalcurve = entry.survivalcurve;
        var_4a7ead2d62c12829 = survivalcurve.channel0.keyframes;
        var_3b8eacdcdfc29b8b = survivalcurve.channel1.keyframes;
        var_ce8a858c96c2ec1b = survivalcurve.channel2.keyframes;
        
        if ( !( isdefined( var_4a7ead2d62c12829 ) && isdefined( var_3b8eacdcdfc29b8b ) && isdefined( var_ce8a858c96c2ec1b ) ) )
        {
            assertmsg( "<dev string:x206>" + bundlename + "<dev string:x227>" );
            logstring( "[Super Bots][WARNING] GetCandidateSurvivalCurves: skip invalid entry because survivalCurve is not defined or keyframes are missing." );
            continue;
        }
        
        botpercent = entry.botpercent ?? 0;
        
        if ( botpercent <= 0 )
        {
            logstring( "[Super Bots] GetCandidateSurvivalCurves: skip entry because botPercent=" + botpercent );
            continue;
        }
        
        curveentries[ curveentries.size ] = entry;
        logstring( "[Super Bots] GetCandidateSurvivalCurves: found curve entry. botPercent=" + botpercent );
    }
    
    if ( curveentries.size == 0 )
    {
        assertmsg( "<dev string:x255>" + bundlename );
        logstring( "[Super Bots][WARNING] GetCandidateSurvivalCurves: no valid curve entry found in " + bundlename );
    }
    
    return curveentries;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xe690210f, Offset: 0x4ff6
// Size: 0xa8
function private function_3a4435b0c5bbecf9( curveentries )
{
    selectedindex = curveentries.size - 1;
    botpercent = function_9ff832be0c4f3767();
    threshold = 0;
    
    for ( i = 0; i < curveentries.size ; i++ )
    {
        entry = curveentries[ i ];
        threshold = entry.botpercent;
        
        if ( botpercent <= threshold )
        {
            selectedindex = i;
            break;
        }
    }
    
    entry = curveentries[ selectedindex ];
    logstring( "[Super Bots] SelectSurvivalCurveBaseOnBotPercent: " + " botPercent=" + botpercent + " threshold=" + threshold );
    return entry.survivalcurve;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x442de60f, Offset: 0x50a7
// Size: 0xcd
function private function_d4b6049c4972814f()
{
    curveentries = function_a7e934abca28230d();
    
    if ( curveentries.size == 0 )
    {
        return;
    }
    
    /#
        if ( isdvardefined( @"hash_7dc224f72323429e" ) )
        {
            curveindex = getdvarint( @"hash_7dc224f72323429e", 0 );
            
            if ( curveindex < 0 || curveindex >= curveentries.size )
            {
                assertmsg( "<dev string:x274>" + curveindex );
                logstring( "<dev string:x2af>" + curveindex );
                return;
            }
            
            logstring( "<dev string:x315>" + curveindex + "<dev string:x348>" + curveindex );
            return curveentries[ curveindex ].survivalcurve;
        }
    #/
    
    if ( !getdvarint( @"hash_ebf6ecfc4fb62005", 0 ) )
    {
        logstring( "[Super Bots] SelectSurvivalCurveBaseOnBotPercent: dynamic selection disabled, use the first valid curve." );
        return curveentries[ 0 ].survivalcurve;
    }
    
    return function_3a4435b0c5bbecf9( curveentries );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x1ab1a2e8, Offset: 0x517d
// Size: 0x2dd
function private function_5caf3c3a4fc8bcac()
{
    partymaxplayers = getdvarint( @"party_maxplayers", 150 );
    mapname = getdvar( @"g_mapname" );
    gametype = game_utility::getgametype();
    survivalcurve = function_d4b6049c4972814f();
    
    if ( !survivalcurve )
    {
        return;
    }
    
    var_4a7ead2d62c12829 = survivalcurve.channel0.keyframes;
    var_3b8eacdcdfc29b8b = survivalcurve.channel1.keyframes;
    var_ce8a858c96c2ec1b = survivalcurve.channel2.keyframes;
    var_e9e0e8b928051220 = 0;
    
    for ( circleindex = 0; circleindex < level.br_level.br_circleclosetimes.size - level.br_level.br_movingcirclecount ; circleindex++ )
    {
        var_e9e0e8b928051220 += level.br_level.br_circleclosetimes[ circleindex ];
        var_e9e0e8b928051220 += level.br_level.br_circledelaytimes[ circleindex ];
    }
    
    points = [];
    length = var_4a7ead2d62c12829.size;
    
    for ( i = 0; i < length ; i++ )
    {
        var_baa4d55197f58bc8 = var_4a7ead2d62c12829[ i ].valuex;
        
        if ( var_baa4d55197f58bc8 != var_3b8eacdcdfc29b8b[ i ].valuex || var_baa4d55197f58bc8 != var_ce8a858c96c2ec1b[ i ].valuex )
        {
            assertmsg( "<dev string:x377>" + mapname + "<dev string:x3b0>" + gametype + "<dev string:x3bd>" + i );
            return;
        }
        
        progress = var_baa4d55197f58bc8 / 100;
        var_d218cee6736ff114 = var_4a7ead2d62c12829[ i ].valuey / 100;
        var_8e2c856f6fcc83ca = var_3b8eacdcdfc29b8b[ i ].valuey / 100;
        uibotratio = var_ce8a858c96c2ec1b[ i ].valuey / 100;
        aliveratio = ( var_d218cee6736ff114 + var_8e2c856f6fcc83ca ) / 2;
        var_d218cee6736ff114 = min( var_d218cee6736ff114, 1 );
        time = var_e9e0e8b928051220 * progress * 1000;
        alivecount = aliveratio * partymaxplayers;
        maxalivecount = var_d218cee6736ff114 * partymaxplayers;
        var_d4441a2319b5a1d6 = var_8e2c856f6fcc83ca * partymaxplayers;
        uibotcount = uibotratio * partymaxplayers;
        points[ i ] = [ #"ui_bot_count":uibotcount, #"min_alive_count":var_d4441a2319b5a1d6, #"max_alive_count":maxalivecount, #"alive_count":alivecount, #"time":time ];
    }
    
    if ( points.size == 0 )
    {
        return;
    }
    
    return points;
}

// Namespace manager
// Params 1
// Checksum 0x8eb72fe5, Offset: 0x5463
// Size: 0x26
function function_fc996d837292d79e( updatenextpoint = 1 )
{
    return function_6ee212a277c0a5cd( #"ui_bot_count", updatenextpoint );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x406c9437, Offset: 0x5492
// Size: 0x26
function private function_8418317300aae6fc( updatenextpoint = 1 )
{
    return function_6ee212a277c0a5cd( #"alive_count", updatenextpoint );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x1edc04ab, Offset: 0x54c1
// Size: 0x26
function private function_112910f51b59d542( updatenextpoint = 1 )
{
    return function_6ee212a277c0a5cd( #"max_alive_count", updatenextpoint );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xb5feeef7, Offset: 0x54f0
// Size: 0x26
function private function_fed09fa7d889d868( updatenextpoint = 1 )
{
    return function_6ee212a277c0a5cd( #"min_alive_count", updatenextpoint );
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xf8f7a9d1, Offset: 0x551f
// Size: 0x17d
function private function_6ee212a277c0a5cd( key, updatenextpoint )
{
    if ( updatenextpoint )
    {
        function_fb05fc7137c029da();
    }
    
    survivalcurve = level.var_4b340b623e2f11b4;
    
    if ( !isdefined( survivalcurve ) )
    {
        return;
    }
    
    currenttime = gettime();
    nextpointindex = survivalcurve.nextpointindex;
    nextpoint = survivalcurve.points[ nextpointindex ];
    
    if ( nextpointindex == 0 )
    {
        expectedcount = nextpoint[ key ];
    }
    else
    {
        lastpoint = survivalcurve.points[ nextpointindex - 1 ];
        frac = math::lerp_fraction( lastpoint[ #"time" ], nextpoint[ #"time" ], currenttime );
        expectedcount = math::lerp( lastpoint[ key ], nextpoint[ key ], frac );
    }
    
    extracurve = survivalcurve.extracurve;
    
    if ( isdefined( extracurve ) )
    {
        if ( currenttime >= extracurve.endtime )
        {
            survivalcurve.extracurve = undefined;
        }
        else if ( currenttime >= extracurve.starttime )
        {
            frac = math::lerp_fraction( extracurve.starttime, extracurve.endtime, currenttime );
            expectedcount += math::lerp( extracurve.startplayercount, extracurve.endplayercount, frac );
        }
    }
    
    return int( round( expectedcount ) );
}

// Namespace manager
// Params 3, eflags: 0x4
// Checksum 0xa432992e, Offset: 0x56a5
// Size: 0x9a
function private function_38e30fdb8484aafc( index, point, curplayercount )
{
    logstring( "SurvivalCurve index: " + index + ", time: " + point[ #"time" ] / 1000 + ", minCnt: " + point[ #"min_alive_count" ] + ", expectedCnt: " + point[ #"alive_count" ] + ", maxCount: " + point[ #"max_alive_count" ] + ", expectedUIBotCnt: " + point[ #"ui_bot_count" ] + ", curPlayerCnt: " + ( curplayercount ?? "N/A" ) );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xe85ec575, Offset: 0x5747
// Size: 0x47
function private function_8ca612a8ce33e270()
{
    points = level.var_4b340b623e2f11b4.points;
    
    for ( i = 0; i < points.size ; i++ )
    {
        function_38e30fdb8484aafc( i, points[ i ] );
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xf6de24df, Offset: 0x5796
// Size: 0xc3
function private function_fb05fc7137c029da()
{
    points = level.var_4b340b623e2f11b4.points;
    
    if ( !isdefined( points ) )
    {
        return;
    }
    
    currenttime = gettime();
    
    for ( i = level.var_4b340b623e2f11b4.nextpointindex; i < points.size ; i++ )
    {
        if ( currenttime < points[ i ][ #"time" ] )
        {
            if ( level.var_4b340b623e2f11b4.nextpointindex < i )
            {
                function_38e30fdb8484aafc( i, points[ i ], function_121588beddc263f9() );
            }
            
            level.var_4b340b623e2f11b4.nextpointindex = i;
            return;
        }
    }
    
    level.var_4b340b623e2f11b4 = undefined;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x8716d55b, Offset: 0x5861
// Size: 0xfe
function private function_6a9696fd3d64bbf7()
{
    level endon( #"game_ended" );
    function_a1419386538a6720();
    waitforsignals = [];
    waitforsignals[ waitforsignals.size ] = level.br_infils_disabled ? "spawned_bots" : "br_c130_left_bounds";
    waitforsignals[ waitforsignals.size ] = "br_circle_init";
    level utility::waittill_all_in_array( waitforsignals );
    points = function_f36fea03ef7f1ac7();
    
    if ( !points )
    {
        return;
    }
    
    function_9dc302ead81ea76( points );
    namespace_ddca46d216b096e2::function_4cf99c9de20b6df0();
    function_8ca612a8ce33e270();
    
    while ( true )
    {
        var_e62611239504fa06 = function_8418317300aae6fc();
        
        if ( !isdefined( var_e62611239504fa06 ) )
        {
            break;
        }
        
        alivecount = function_121588beddc263f9();
        level.var_4b340b623e2f11b4.var_479511aca38d1db0 = alivecount < function_112910f51b59d542( 0 );
        
        if ( alivecount > var_e62611239504fa06 )
        {
            logstring( "[Super Bots] SurvivalCurve: too many survivors, kill a bot" );
            ui_bot::killsome( 1, 0, "SurvivalCurve" );
        }
        
        wait 1;
    }
    
    cleanupleftuibots();
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xa12bd5d7, Offset: 0x5967
// Size: 0xe1
function private function_9dc302ead81ea76( points )
{
    assert( isdefined( points ) && isdefined( level.br_circle.circleinittime ) );
    
    foreach ( point in points )
    {
        point[ #"time" ] += level.br_circle.circleinittime;
    }
    
    level.var_4b340b623e2f11b4 = { #nextpointindex:0, #points:points };
}

// Namespace manager
// Params 0, eflags: 0xc
// Checksum 0x7befa4d8, Offset: 0x5a50
// Size: 0x80
function private cleanupleftuibots()
{
    self notify( #"hash_ddacd4a1bae87024" );
    self endon( #"hash_ddacd4a1bae87024" );
    level.uibotmanager.var_9d03093deceb509e = 1;
    reason = "CleanUpLeftUIBots";
    namespace_ddca46d216b096e2::function_a8bd6173ca7191ff( "begin", reason, function_6f7e22d4e6adac55() );
    
    while ( function_6f7e22d4e6adac55() > 0 )
    {
        ui_bot::killsome( 1, 0, reason );
        wait 1;
    }
    
    namespace_ddca46d216b096e2::function_a8bd6173ca7191ff( "end", reason );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x95f8673e, Offset: 0x5ad8
// Size: 0xa
function private function_121588beddc263f9()
{
    return br::getalivecount( 1 );
}

// Namespace manager
// Params 1
// Checksum 0x5ee01f9e, Offset: 0x5aeb
// Size: 0x1ff
function SurvivalCurveMayConsiderBotDead( bot )
{
    if ( !isbot( bot ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_aefbe1721e059470", 0 ) )
        {
            return;
        }
        
        if ( function_5038e868414d50c0() && level.uibotmanager.devtest.var_7777bfa37c07b410 == bot.entity_number )
        {
            level.uibotmanager.devtest.var_7777bfa37c07b410 = undefined;
            
            if ( !bot ui_bot::canberecycled( 5 ) )
            {
                return;
            }
            
            bot.respawningfromtoken = 1;
            bot thread survivalcurvewaitrecyclethread( 5 );
            return 0;
        }
    #/
    
    if ( bot.var_deee3117dd8405fb )
    {
        bot.var_deee3117dd8405fb = undefined;
        return;
    }
    
    upperbound = function_112910f51b59d542();
    
    if ( !isdefined( upperbound ) )
    {
        return;
    }
    
    lowerbound = function_fed09fa7d889d868( 0 );
    alivecount = function_121588beddc263f9();
    
    if ( alivecount > upperbound )
    {
        br_utility::markplayeraseliminated( bot, "SurvivalCurveMayConsiderBotDead" );
        logstring( "[Super Bots] SurvivalCurve: mark bot as eliminated:" + bot.name + ", survivalCurveNextIdx: " + level.var_4b340b623e2f11b4.nextpointindex + ", aliveCount: " + alivecount + ", upperBound: " + upperbound + ", lowerBound: " + lowerbound );
        
        if ( bot br_public::hasrespawntoken() )
        {
            bot item_redeploy_token::function_16ab0a48337237ef( 1 );
        }
        
        return 1;
    }
    
    if ( alivecount < lowerbound )
    {
        context = "survivalCurveNextIdx: " + level.var_4b340b623e2f11b4.nextpointindex + ", aliveCount: " + alivecount + ", upperBound: " + upperbound + ", lowerBound: " + lowerbound;
        super_bot::function_cb27523a07bf9c83( 1, bot, "manager::survivalcurvemayconsiderbotdead", "try to recycle. recycleReason: " + context, "" );
        
        if ( !bot ui_bot::canberecycled() )
        {
            return;
        }
        
        bot.respawningfromtoken = 1;
        bot thread survivalcurvewaitrecyclethread();
        return 0;
    }
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0x9dc9c364, Offset: 0x5cf3
// Size: 0x153
function private survivalcurvewaitrecyclethread( type = undefined )
{
    level endon( #"game_ended" );
    assert( isdefined( self ) );
    name = self.name ?? "undefined";
    team = self.team ?? "undefined";
    xuid = self.xuid ?? "undefined";
    bba_id = self.bba_id ?? "undefined";
    var_a9e445b745036062 = 2;
    timeuntilspawn = playerlogic::timeuntilspawn( 1 ) + var_a9e445b745036062;
    super_bot::function_cb27523a07bf9c83( 1, self, "manager::survivalcurvewaitrecyclethread", "pending recycle bot. timeUntilSpawn=" + timeuntilspawn, "" );
    wait timeuntilspawn;
    
    if ( !isdefined( self ) )
    {
        super_bot::function_cb27523a07bf9c83( 1, undefined, "manager::survivalcurvewaitrecyclethread", "skip recycle. name=" + name + " team=" + team + " xuid=" + xuid + " BBA_Id=" + bba_id, "" );
        return;
    }
    
    result = ui_bot::tryrecycle( "SurvivalCurve recycle after killed", type );
    
    if ( !result )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "manager::survivalcurvewaitrecyclethread", "failed to recycle, let's kick it.", "" );
        bots_gametype_br_super::kickplayer();
    }
}

// Namespace manager
// Params 0
// Checksum 0x5e89cd13, Offset: 0x5e4e
// Size: 0x1a, Type: bool
function function_c8a525cf7247da07()
{
    return level.var_4b340b623e2f11b4.var_479511aca38d1db0 ?? 1;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x55a2d92b, Offset: 0x5e71
// Size: 0x16
function private function_d88688d031e642c2()
{
    level waittill( #"autotest_start" );
    cleanupleftuibots();
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xa68999b7, Offset: 0x5e8f
// Size: 0xb8
function private terminatorthread()
{
    level endon( #"game_ended" );
    duration = getdvarint( @"hash_6f2bcb1f13830539", 90000 );
    circleendtime = function_aae576036b9f3d7e();
    var_583ed70bbecdac34 = gettime();
    reason = "";
    
    while ( true )
    {
        if ( circleendtime > 0 && gettime() >= circleendtime )
        {
            reason = "It's too late";
            break;
        }
        
        if ( function_85b2e664bd3c929e() )
        {
            if ( gettime() - var_583ed70bbecdac34 >= duration )
            {
                reason = "only one team alive";
                break;
            }
        }
        else
        {
            var_583ed70bbecdac34 = gettime();
        }
        
        wait 1;
    }
    
    forceendgame( "Force end game due to terminator. " + reason );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x3d61b1ef, Offset: 0x5f4f
// Size: 0x133
function private function_aae576036b9f3d7e()
{
    if ( level.br_circle_disabled )
    {
        return 0;
    }
    
    if ( !isdefined( level.br_circle.circleinittime ) )
    {
        level waittill( #"br_circle_set" );
    }
    
    circleduration = 0;
    
    if ( isdefined( level.br_level.br_circledelaytimes ) )
    {
        for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
        {
            prewaittime = level.br_level.br_circledelaytimes[ i ];
            circleduration += prewaittime;
        }
    }
    
    if ( isdefined( level.br_level.br_circleclosetimes ) )
    {
        for ( i = 0; i < level.br_level.br_circleclosetimes.size ; i++ )
        {
            closetime = level.br_level.br_circleclosetimes[ i ];
            circleduration += closetime;
        }
    }
    
    return level.br_circle.circleinittime + circleduration * 1000 + getdvarint( @"hash_b601ee95f4a4ba2e", 0 );
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0xc5a1233e, Offset: 0x608b
// Size: 0xa8, Type: bool
function private function_85b2e664bd3c929e()
{
    aliveteamcount = 0;
    var_e9f382b47f4661e0 = function_a18f970a934462b7();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isteamalive( entry, var_e9f382b47f4661e0 ) )
        {
            aliveteamcount++;
            
            if ( aliveteamcount > 1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x1f02be28, Offset: 0x613c
// Size: 0x69, Type: bool
function private function_a18f970a934462b7()
{
    if ( level.br_circle_disabled )
    {
        return false;
    }
    
    if ( level.br_level.br_movingcirclecount <= 0 )
    {
        return false;
    }
    
    return level.br_circle.circleindex + 1 >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount;
}

// Namespace manager
// Params 2, eflags: 0x4
// Checksum 0xd5efc018, Offset: 0x61ae
// Size: 0xcf
function private isteamalive( team, var_e9f382b47f4661e0 )
{
    alivecount = teams::getteamdata( team, "aliveCount" );
    
    if ( alivecount <= 0 )
    {
        return 0;
    }
    
    if ( var_e9f382b47f4661e0 )
    {
        players = teams::getteamdata( team, "players" );
        
        foreach ( teammate in players )
        {
            if ( !isai( teammate ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    return 1;
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xe44a3400, Offset: 0x6285
// Size: 0xbe
function private forceendgame( reason )
{
    level.uibotmanager.var_9d03093deceb509e = 1;
    endgamemethod = getdvarint( @"hash_14a1f07fa4c28b94", 0 );
    logstring( "[KEY_MOMENT] ForceEndGame. endGameMethod=" + endgamemethod + " reason=" + reason );
    namespace_ddca46d216b096e2::debuglogforceendgame( endgamemethod );
    
    if ( endgamemethod == 0 )
    {
        thread gamelogic_mp::forceend();
        return;
    }
    
    winner = function_6cd6280dc187d330();
    assert( isdefined( winner ) );
    
    if ( isbrgamemode() )
    {
        playerendmatch();
    }
    
    if ( !br::function_ee15a28564f11e4e() )
    {
        thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "br_eliminated" ] );
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x2eb7e304, Offset: 0x634b
// Size: 0x13e
function private function_6cd6280dc187d330()
{
    var_e9f382b47f4661e0 = 1;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isteamalive( entry, var_e9f382b47f4661e0 ) )
        {
            return entry;
        }
    }
    
    var_e9f382b47f4661e0 = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isteamalive( entry, var_e9f382b47f4661e0 ) )
        {
            return entry;
        }
    }
    
    if ( level.uibotmanager.uibots.size > 0 )
    {
        return level.uibotmanager.uibots[ 0 ].team;
    }
}

// Namespace manager
// Params 0, eflags: 0x4
// Checksum 0x3ad321ec, Offset: 0x6492
// Size: 0x51
function private function_a1419386538a6720()
{
    if ( !level.var_9f3e65403fec466 )
    {
        return;
    }
    
    level.var_fc103f7365fbb014 = 1;
    level.var_cf1fcae916b081e7 = 0;
    level callback::add( #"jailbreak_event", &function_ae861b8f11ec04d1 );
    level callback::add( #"on_squad_eliminated", &onteameliminated );
}

// Namespace manager
// Params 1, eflags: 0x4
// Checksum 0xe13e6715, Offset: 0x64eb
// Size: 0x16e
function private function_ae861b8f11ec04d1( params )
{
    if ( params.var_f5457b2113554e6c )
    {
        level.var_cf1fcae916b081e7 = 1;
    }
    
    if ( !isdefined( level.var_4b340b623e2f11b4 ) )
    {
        logstring( "[Super Bots] OnDownButNotOut() called, but bot survival curve has not started." );
        return;
    }
    
    playercount = params.playercount;
    
    if ( playercount == 0 )
    {
        logstring( "[Super Bots] OnDownButNotOut() called, but no players to respawn." );
        return;
    }
    
    duration = getdvarfloat( @"hash_df1e2f7fe6c6f5d3", -1 );
    
    if ( duration <= 0 )
    {
        if ( level.var_9f3e65403fec466 == "CircleBeginClose" )
        {
            duration = level.br_level.br_circleclosetimes[ level.br_circle.circleindex ];
            
            if ( !( duration > 0 ) )
            {
                logstring( "[Super Bots] OnDownButNotOut() called, but dvar 'scr_br_bot_survival_curve_down_but_not_out_duration_sec' is <= 0, also circle close time is <= 0." );
                return;
            }
        }
        else
        {
            logstring( "[Super Bots] OnDownButNotOut() called, but dvar 'scr_br_bot_survival_curve_down_but_not_out_duration_sec' is <= 0, also not 'CircleBeginClose'." );
            return;
        }
    }
    
    duration *= 1000;
    starttime = gettime();
    endtime = starttime + duration;
    level.var_4b340b623e2f11b4.extracurve = { #endplayercount:0, #startplayercount:playercount, #endtime:endtime, #starttime:starttime };
    logstring( "[Super Bots] OnDownButNotOut() called, and player count is " + playercount + ", duration is " + duration + "ms." );
}

// Namespace manager
// Params 1
// Checksum 0x17048c1d, Offset: 0x6661
// Size: 0xcf
function onteameliminated( params )
{
    if ( !params.team )
    {
        return;
    }
    
    if ( !bots_gametype_br_super::function_cb32b9056c63191f( params.team ) )
    {
        return;
    }
    
    players = teams::getteamdata( params.team, "players" );
    
    foreach ( player in players )
    {
        if ( isbot( player ) )
        {
            player thread bots_gametype_br_super::function_7fb069819a6ed860( 1 );
        }
    }
}

/#

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0xdb831dd7, Offset: 0x6738
    // Size: 0xab, Type: dev
    function private function_2a3829b69c301393()
    {
        level waittill( #"player_spawned" );
        cmd = "<dev string:x3c7>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x42e>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x48f>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x4f4>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x569>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x5ec>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x65d>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        ui_bot::function_92888ac470f1c74();
        level thread function_2ae05c6e7545413b();
        level thread function_a1d5a6d0501670d();
        level thread function_eaa37b6ba6331cc1();
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0xe5f3a417, Offset: 0x67eb
    // Size: 0x302, Type: dev
    function private function_2ae05c6e7545413b()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players ) )
        {
            wait 1;
        }
        
        setdvarifuninitialized( @"hash_a2d26b607a32e157", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_a2d26b607a32e157", 0 ) == 1 )
            {
                totalalivebotnum = 0;
                var_51c6ad3bb8936eb8 = 0;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && !player bots_gametype_br_super::iseliminated() )
                    {
                        if ( player br_public::isplayerinorgoingtogulag() )
                        {
                            var_51c6ad3bb8936eb8++;
                            continue;
                        }
                        
                        if ( !player isuibot() )
                        {
                            totalalivebotnum++;
                            
                            if ( player function_5c79ebe77f7d0528() )
                            {
                                debugmsg = "<dev string:x6f0>";
                                
                                if ( player dormant_bot::issuspended() )
                                {
                                    debugmsg += "<dev string:x6f8>";
                                }
                                
                                if ( isdefined( player.recyclereason ) )
                                {
                                    debugmsg += "<dev string:x704>" + player.recyclereason;
                                }
                            }
                            else
                            {
                                debugmsg = "<dev string:x708>";
                            }
                            
                            print3d( player.origin + ( 0, 0, 100 ), debugmsg, ( 1, 0, 0 ), 1, 1, 70, 1 );
                        }
                    }
                }
                
                dormantbotnum = level.uibotmanager.dormantbots.size;
                uibotnum = level.uibotmanager.uibots.size;
                var_b01910a266afaf0c = dormantbotnum + uibotnum;
                var_73e3339ddbb28523 = gettime() + 1000;
                
                while ( gettime() < var_73e3339ddbb28523 )
                {
                    printtoscreen2d( 500, 100, "<dev string:x70f>" + var_b01910a266afaf0c + "<dev string:x72d>" + dormantbotnum + "<dev string:x72f>" + uibotnum + "<dev string:x731>" + var_51c6ad3bb8936eb8 + "<dev string:x744>" + totalalivebotnum - dormantbotnum, ( 1, 0, 0 ), 2 );
                    var_17670ea0f6a54984 = getdvarint( @"hash_ebf6ecfc4fb62005", 0 );
                    alivecount = function_121588beddc263f9();
                    var_e62611239504fa06 = function_8418317300aae6fc( 0 ) ?? 0;
                    lowerbound = function_fed09fa7d889d868( 0 ) ?? 0;
                    upperbound = function_112910f51b59d542( 0 ) ?? 0;
                    printtoscreen2d( 500, 150, "<dev string:x754>" + var_17670ea0f6a54984 + "<dev string:x76c>" + alivecount + "<dev string:x774>" + var_e62611239504fa06 + "<dev string:x77f>" + lowerbound + "<dev string:x787>" + upperbound, ( 1, 0, 0 ), 2 );
                    waitframe();
                }
                
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x19619e40, Offset: 0x6af5
    // Size: 0x106, Type: dev
    function private function_a1d5a6d0501670d()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players ) )
        {
            wait 1;
        }
        
        setdvarifuninitialized( @"hash_e7a0fc54a24bf343", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_e7a0fc54a24bf343", 0 ) == 1 )
            {
                setdvar( @"hash_e7a0fc54a24bf343", 0 );
                
                foreach ( player in level.players )
                {
                    if ( bots_gametype_br_super::isvalidbot( player ) )
                    {
                        if ( !gamelogic_mp::inprematch() )
                        {
                            player dormant_bot::tryrecycle( "<dev string:x78f>" );
                            continue;
                        }
                        
                        player ui_bot::tryrecycle( "<dev string:x78f>" );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x1ba9655, Offset: 0x6c03
    // Size: 0x1a4, Type: dev
    function private function_eaa37b6ba6331cc1()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_d95f6cfac74fa872", 0 );
        setdvarifuninitialized( @"hash_25920b075500f084", 0 );
        setdvarifuninitialized( @"hash_70561094fa4e91b5", 0 );
        setdvarifuninitialized( @"hash_dd9f8b3596ac0b3d", 0 );
        setdvarifuninitialized( @"hash_aefbe1721e059470", 0 );
        pauserecycle = getdvarint( @"hash_d95f6cfac74fa872", 0 );
        var_6a52e411000c8951 = getdvarint( @"hash_25920b075500f084", 0 );
        var_b1ebd7ca0aa725ba = getdvarint( @"hash_70561094fa4e91b5", 0 );
        var_383fc386c0e640d5 = getdvarint( @"hash_dd9f8b3596ac0b3d", 0 );
        var_4394ec224f07197d = getdvarint( @"hash_aefbe1721e059470", 0 );
        
        while ( true )
        {
            function_37fba6d441b1df45( pauserecycle, @"hash_d95f6cfac74fa872", "<dev string:x7a3>" );
            pauserecycle = getdvarint( @"hash_d95f6cfac74fa872", 0 );
            function_37fba6d441b1df45( var_6a52e411000c8951, @"hash_25920b075500f084", "<dev string:x7b0>" );
            var_6a52e411000c8951 = getdvarint( @"hash_25920b075500f084", 0 );
            function_37fba6d441b1df45( var_b1ebd7ca0aa725ba, @"hash_70561094fa4e91b5", "<dev string:x7bf>" );
            var_b1ebd7ca0aa725ba = getdvarint( @"hash_70561094fa4e91b5", 0 );
            function_37fba6d441b1df45( var_383fc386c0e640d5, @"hash_dd9f8b3596ac0b3d", "<dev string:x7d5>" );
            var_383fc386c0e640d5 = getdvarint( @"hash_dd9f8b3596ac0b3d", 0 );
            function_37fba6d441b1df45( var_4394ec224f07197d, @"hash_aefbe1721e059470", "<dev string:x7ea>" );
            var_4394ec224f07197d = getdvarint( @"hash_aefbe1721e059470", 0 );
            wait 1;
        }
    }

    // Namespace manager
    // Params 3, eflags: 0x4
    // Checksum 0xd16620fa, Offset: 0x6daf
    // Size: 0x55, Type: dev
    function private function_37fba6d441b1df45( dvarvalue, dvarname, hintstring )
    {
        if ( dvarvalue != getdvarint( dvarname, 0 ) )
        {
            if ( getdvarint( dvarname, 0 ) )
            {
                iprintln( hintstring + "<dev string:x80e>" );
                return;
            }
            
            iprintln( hintstring + "<dev string:x813>" );
        }
    }

    // Namespace manager
    // Params 0
    // Checksum 0xd8859e5c, Offset: 0x6e0c
    // Size: 0x1f, Type: dev
    function function_5038e868414d50c0()
    {
        mode = function_87149d30346521ee();
        return ( mode & 1 ) != 0;
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x5c05aa40, Offset: 0x6e33
    // Size: 0x1f, Type: dev
    function private function_ea7657925c67cd44()
    {
        mode = function_87149d30346521ee();
        return ( mode & 2 ) != 0;
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x9f99ac97, Offset: 0x6e5a
    // Size: 0x17, Type: dev
    function private function_87149d30346521ee()
    {
        profilestart();
        profilestop();
        return getdvarint( @"hash_2709329835b7cc67", 0 );
    }

    // Namespace manager
    // Params 2, eflags: 0x4
    // Checksum 0x48d8f810, Offset: 0x6e79
    // Size: 0x40, Type: dev
    function private function_9dfe400b20a16a46( dvar, resetvalue )
    {
        profilestart();
        value = getdvarint( dvar, resetvalue );
        
        if ( value != resetvalue )
        {
            setdvar( dvar, resetvalue );
        }
        
        profilestop();
        return value;
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0xa9e4ea9d, Offset: 0x6ec1
    // Size: 0x5b, Type: dev
    function private function_1fd14e2806a76525()
    {
        level endon( #"game_ended" );
        level.uibotmanager.devtest = {};
        
        while ( true )
        {
            function_ab9d2dce17c038c6();
            function_ea321c27c695af31();
            function_eafc15134d34d55f();
            function_fbf2f952457142c4();
            function_512e933f3537722c();
            function_63e558419ba5f155();
            wait 1;
        }
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x195eaa8e, Offset: 0x6f24
    // Size: 0x64, Type: dev
    function private function_ab9d2dce17c038c6()
    {
        entnum = function_9dfe400b20a16a46( @"hash_d4fe04e920c21b36", -1 );
        
        if ( entnum == -1 )
        {
            return;
        }
        
        ent = getentbynum( entnum );
        
        if ( isbot( ent ) )
        {
            level.uibotmanager.devtest.var_7777bfa37c07b410 = entnum;
        }
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x24b37375, Offset: 0x6f90
    // Size: 0x4f, Type: dev
    function private function_ea321c27c695af31()
    {
        entnum = function_9dfe400b20a16a46( @"hash_9e39dcdf6f0f15f6", -1 );
        
        if ( entnum == -1 )
        {
            return;
        }
        
        ent = getentbynum( entnum );
        
        if ( isbot( ent ) )
        {
            ent tryrecycle( 5 );
        }
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x7f478a3c, Offset: 0x6fe7
    // Size: 0x64, Type: dev
    function private function_eafc15134d34d55f()
    {
        index = function_9dfe400b20a16a46( @"hash_e17b2716ffe1a8d8", -1 );
        
        if ( index == -1 )
        {
            return;
        }
        
        tester = bots::get_human_player();
        
        if ( !tester )
        {
            assertmsg( "<dev string:x817>" );
            return;
        }
        
        function_a8da63f27e720669( [ tester ], 1, index );
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0xc7d17229, Offset: 0x7053
    // Size: 0x11a, Type: dev
    function private function_fbf2f952457142c4()
    {
        val = function_9dfe400b20a16a46( @"scr_ui_bot_list", 0 );
        
        if ( val == 0 )
        {
            return;
        }
        
        var_96dcab7cb4c298d2 = 30;
        var_ea2e848190eb3aed = 0;
        messagebuffer = "<dev string:x859>";
        println( "<dev string:x85a>" );
        uibotcount = level.uibotmanager.uibots.size;
        
        for ( i = 0; i < uibotcount ; i++ )
        {
            profile = level.uibotmanager.uibots[ i ];
            messagebuffer += "<dev string:x87d>" + string( i ) + "<dev string:x880>" + profile.name + "<dev string:x72d>" + profile.xuid + "<dev string:x882>";
            var_ea2e848190eb3aed++;
            
            if ( var_ea2e848190eb3aed >= var_96dcab7cb4c298d2 || i == uibotcount - 1 )
            {
                println( messagebuffer );
                var_ea2e848190eb3aed = 0;
                messagebuffer = "<dev string:x859>";
            }
        }
        
        println( "<dev string:x884>" );
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0x68b76f68, Offset: 0x7175
    // Size: 0x35, Type: dev
    function private function_512e933f3537722c()
    {
        val = function_9dfe400b20a16a46( @"hash_2c41bc1afb47f3c4", 0 );
        
        if ( val == 0 )
        {
            return;
        }
        
        level notify( #"ui_bot_counter_updated" );
    }

    // Namespace manager
    // Params 0, eflags: 0x4
    // Checksum 0xfc46c747, Offset: 0x71b2
    // Size: 0x16a, Type: dev
    function private function_63e558419ba5f155()
    {
        val = function_9dfe400b20a16a46( @"hash_5a404c03892abab7", 0 );
        
        if ( val == 0 )
        {
            return;
        }
        
        tester = bots::get_human_player();
        
        if ( !tester )
        {
            assertmsg( "<dev string:x8a5>" );
            return;
        }
        
        if ( tester.var_3415a7be076a6dd7 )
        {
            tester setorigin( tester.var_3415a7be076a6dd7 );
            tester setplayerangles( tester.var_3fa5250e2f109307 );
            
            if ( tester.var_bb939d3854d8eae2 != tester isufo() )
            {
                tester ufo();
            }
            
            tester.var_3415a7be076a6dd7 = undefined;
            tester.var_3fa5250e2f109307 = undefined;
            tester.var_bb939d3854d8eae2 = undefined;
            return;
        }
        
        tester.var_3415a7be076a6dd7 = tester getorigin();
        tester.var_3fa5250e2f109307 = tester getplayerangles();
        tester.var_bb939d3854d8eae2 = tester isufo();
        blackroompos = level.uibotmanager.var_7dc27bc9fa62c763;
        peekpos = level.uibotmanager.var_7dc27bc9fa62c763 + ( 0, 0, 100 );
        tester setorigin( peekpos );
        tester setplayerangles( vectortoangles( blackroompos - peekpos ) );
        
        if ( !tester.var_bb939d3854d8eae2 )
        {
            tester ufo();
        }
    }

#/
