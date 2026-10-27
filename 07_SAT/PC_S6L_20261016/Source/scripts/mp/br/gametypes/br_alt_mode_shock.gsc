// scripts\mp\br\gametypes\br_alt_mode_shock.gsc  (hash_3d7467789846797a.gscc) (size: 13098 Bytes / 0x332a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95cd979c (2513278876)
// size ...... 13098 (0x332a)
// includes .. 20  (offset: 0x2fc2)
// strings ... 30  (offset: 0x3062)
// dev strs .. 9   (offset: 0x32ae)
// exports ... 35  (offset: 0x1bde)
// cseg ...... 0x2d5 + 0x1909 (0x1bde)
// imports ... 123 (offset: 0x2156)
// animtree1 . 0   (offset: 0x332a)
// animtree2 . 0   (offset: 0x332a)
#using script_26ccbfe3954cacf4;
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\shock_buff;
#using scripts\mp\hud_message;

#namespace br_alt_mode_shock;

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0x219ccd8e, Offset: 0x2f3
// Size: 0x76
function init()
{
    if ( !function_480f16a04286f001() )
    {
        return;
    }
    
    flags::initgameflags();
    flags::gameflaginit( "shock_initialized", 0 );
    thread function_de7931b7d56cbfb8();
    level.var_3f58b1591b1d651a = [];
    var_ba308e891318c893 = getdvar( @"hash_b2c0fa0cf2e0316c", "" );
    
    if ( var_ba308e891318c893 != "" )
    {
        level.var_3f58b1591b1d651a = strtok( var_ba308e891318c893, "," );
    }
    
    shock_buff::function_642998694251794e();
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0x5d092d56, Offset: 0x371
// Size: 0x10
function function_480f16a04286f001()
{
    return getdvarint( @"scr_br_alt_mode_shock", 0 );
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xef64ecc7, Offset: 0x38a
// Size: 0xb0
function function_de7931b7d56cbfb8()
{
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &onplayerkilled );
    utility::registersharedfunc( #"gametype", #"endgame", &function_2ead6d7add3d72 );
    utility::registersharedfunc( #"gametype", #"onPlayerDamaged", &onplayerdamaged );
    connect_event_aggregator::registeronconnectcallback( &onplayerconnected );
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    
    if ( challenges::challengesenabled() )
    {
        utility::registersharedfunc( #"gametype", #"hash_969c5ee84971009d", &function_ec5ef1fd62e80294 );
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xd2859dc9, Offset: 0x442
// Size: 0xf9
function onplayerconnected()
{
    player = self;
    
    if ( !isdefined( player.pers[ "ae_shock_fire_boost_kill" ] ) )
    {
        player.pers[ "ae_shock_fire_boost_kill" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "ae_shock_speed_boost_cache" ] ) )
    {
        player.pers[ "ae_shock_speed_boost_cache" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "lightning_strike" ] ) )
    {
        player.pers[ "lightning_strike" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "shock_speed_boost" ] ) )
    {
        player.pers[ "shock_speed_boost" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "shock_eyes_on" ] ) )
    {
        player.pers[ "shock_eyes_on" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "shock_fire_boost" ] ) )
    {
        player.pers[ "shock_fire_boost" ] = 0;
    }
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xe178360, Offset: 0x543
// Size: 0x15
function onplayerdisconnect( player )
{
    player function_a95516c20f4a9a29();
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xb3a885f7, Offset: 0x560
// Size: 0x124
function function_a95516c20f4a9a29()
{
    player = self;
    
    if ( isdefined( player.pers[ "dlog_event_br_shock_player_match_end_sent" ] ) || !telemetry_utils::is_valid_client( player ) || player.var_5a792f9fdacf9283 && !level.gameended )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_shock_player_match_end", [ "ae_shock_fire_boost_kill", player.pers[ "ae_shock_speed_boost_cache" ], "ae_shock_speed_boost_cache", player.pers[ "ae_shock_speed_boost_cache" ], "lightning_strike", player.pers[ "lightning_strike" ], "shock_speed_boost", player.pers[ "shock_speed_boost" ], "shock_eyes_on", player.pers[ "shock_eyes_on" ], "shock_fire_boost", player.pers[ "shock_fire_boost" ] ] );
    player.pers[ "dlog_event_br_shock_player_match_end_sent" ] = 1;
}

// Namespace br_alt_mode_shock
// Params 2
// Checksum 0x24252c09, Offset: 0x68c
// Size: 0x23f
function function_ec5ef1fd62e80294( player, instance )
{
    if ( !player challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !player shock_buff::function_c1adf60b0d7bb249( "shock_speed_boost" ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_1066877fa63f86fe ) )
    {
        player.var_1066877fa63f86fe = [];
    }
    
    currenttime = gettime();
    player.var_1066877fa63f86fe[ player.var_1066877fa63f86fe.size ] = currenttime;
    
    if ( player.var_1066877fa63f86fe.size > 1 )
    {
        withintime = getdvarint( @"hash_accfafdccde7c34f", 15 );
        
        for ( totaltime = ( currenttime - player.var_1066877fa63f86fe[ 0 ] ) / 1000; totaltime >= withintime ; totaltime = ( currenttime - player.var_1066877fa63f86fe[ 0 ] ) / 1000 )
        {
            player.var_1066877fa63f86fe = arrayremove( player.var_1066877fa63f86fe, player.var_1066877fa63f86fe[ 0 ] );
            
            if ( player.var_1066877fa63f86fe.size <= 1 )
            {
                break;
            }
        }
        
        lootcount = getdvarint( @"hash_1f03b39194b28f25", 3 );
        
        if ( player.var_1066877fa63f86fe.size == lootcount )
        {
            challenges::function_ed57a973bf4fe0fc( player, lootcount, withintime );
            player function_89cbae02d2a5baf();
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "ae_shock_speed_boost_cache" ] ) )
                {
                    player.leaderboarddata[ "ae_shock_speed_boost_cache" ] = player.leaderboarddata[ "ae_shock_speed_boost_cache" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "ae_shock_speed_boost_cache" ] ) )
                {
                    [[ level.leaderboardfunc[ "ae_shock_speed_boost_cache" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( player.pers[ "ae_shock_speed_boost_cache" ] ) )
                {
                    player.pers[ "ae_shock_speed_boost_cache" ] = player.pers[ "ae_shock_speed_boost_cache" ] + 1;
                }
            }
        }
    }
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0x27dc083d, Offset: 0x8d3
// Size: 0xc
function function_89cbae02d2a5baf()
{
    self.var_1066877fa63f86fe = [];
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x438dc948, Offset: 0x8e7
// Size: 0x7d
function onplayerdamaged( damagedata )
{
    attacker = damagedata.attacker;
    victim = damagedata.victim;
    
    if ( isplayer( attacker ) && isplayer( victim ) && attacker != victim )
    {
        currenttime = gettime();
        attacker.lastcombattime = currenttime;
        victim.lastcombattime = currenttime;
    }
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xc98b8c22, Offset: 0x96c
// Size: 0x4d, Type: bool
function function_50beb4b33b0610d4( player )
{
    if ( !isdefined( player.lastcombattime ) )
    {
        return false;
    }
    
    exitcombattime = getdvarfloat( @"hash_a5e5e96b1a6d2576", 5000 );
    return gettime() - player.lastcombattime < exitcombattime;
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x59234bac, Offset: 0x9c2
// Size: 0x37
function onplayerspawned( params )
{
    shock_buff::function_9d4bf23a66b6bbef();
    thread function_d07bc8bb6d9cbdc1();
    
    /#
        if ( getdvarint( @"hash_fd8d66fc9e6216fb", 0 ) > 0 )
        {
            thread function_921c0adef6604ca2();
        }
    #/
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xa7cc86d1, Offset: 0xa01
// Size: 0x15e
function onplayerkilled( deathdata )
{
    deathdata.victim function_ca8ce4a188c8b8b7();
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( isdefined( attacker ) && attacker != victim && attacker challenges::challengesenabledforplayer() && attacker shock_buff::function_c1adf60b0d7bb249( "shock_fire_boost" ) )
    {
        challenges::function_1b9535068b88ec7e( attacker );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "ae_shock_fire_boost_kill" ] ) )
            {
                attacker.leaderboarddata[ "ae_shock_fire_boost_kill" ] = attacker.leaderboarddata[ "ae_shock_fire_boost_kill" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "ae_shock_fire_boost_kill" ] ) )
            {
                [[ level.leaderboardfunc[ "ae_shock_fire_boost_kill" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "ae_shock_fire_boost_kill" ] ) )
            {
                attacker.pers[ "ae_shock_fire_boost_kill" ] = attacker.pers[ "ae_shock_fire_boost_kill" ] + 1;
            }
        }
    }
}

// Namespace br_alt_mode_shock
// Params 2
// Checksum 0x99883f0e, Offset: 0xb67
// Size: 0x97
function function_2ead6d7add3d72( winner, endreasontext )
{
    foreach ( player in level.players )
    {
        player function_ca8ce4a188c8b8b7();
        player function_a95516c20f4a9a29();
    }
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xd7055187, Offset: 0xc06
// Size: 0x28
function function_ca8ce4a188c8b8b7()
{
    if ( !isdefined( self.shockbuffs ) )
    {
        return;
    }
    
    shock_buff::function_a4aac4f8ccebe67b();
    function_20e9574ae840be4d( 0 );
    function_bf0a1941c1bac989( 0 );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x3f9561cb, Offset: 0xc36
// Size: 0x37
function function_20e9574ae840be4d( enable )
{
    if ( enable )
    {
        self setscriptablepartstate( "shockStickVfx", "vfx_start_nosound", 1 );
        return;
    }
    
    self setscriptablepartstate( "shockStickVfx", "off", 0 );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x6469de33, Offset: 0xc75
// Size: 0x84
function function_bf0a1941c1bac989( enable )
{
    if ( enable )
    {
        if ( !isdefined( self.var_5aa9e02ed9cdd564 ) )
        {
            self.var_5aa9e02ed9cdd564 = spawnfxforclient( utility::getfx( "vfx_lightning_zaps_screen_1p" ), self.origin, self, ( 0, 0, 1 ) );
            triggerfx( self.var_5aa9e02ed9cdd564 );
        }
        
        return;
    }
    
    if ( isdefined( self.var_5aa9e02ed9cdd564 ) )
    {
        self.var_5aa9e02ed9cdd564 delete();
        self.var_5aa9e02ed9cdd564 = undefined;
    }
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x9e31b1fc, Offset: 0xd01
// Size: 0x60
function function_bd778b50021ced7e( buff )
{
    if ( self.shockbuffs.size <= 0 )
    {
        function_20e9574ae840be4d( 0 );
        function_bf0a1941c1bac989( 0 );
    }
    
    if ( challenges::challengesenabledforplayer() && buff.key == "shock_speed_boost" && !shock_buff::function_c1adf60b0d7bb249( "shock_speed_boost" ) )
    {
        function_89cbae02d2a5baf();
    }
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0x8b36bb19, Offset: 0xd69
// Size: 0x9e
function function_d07bc8bb6d9cbdc1()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_9d6ce2517d65ac33();
    childthread function_825e237e2ad7d47c();
    var_d67d829d73f734e5 = getdvarfloat( @"hash_b4eda4f58d672a7f", 12 );
    var_d6a18c9d741fc59b = getdvarfloat( @"hash_b4cab2f58d410191", 22 );
    zapdelay = randomfloatrange( var_d67d829d73f734e5, var_d6a18c9d741fc59b );
    wait zapdelay;
    
    while ( true )
    {
        if ( function_a72053a138949752( self ) )
        {
            function_3ae6f1ad93385f49( self );
        }
        
        zapcd = randomfloatrange( var_d67d829d73f734e5, var_d6a18c9d741fc59b );
        wait zapcd;
    }
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xef47f026, Offset: 0xe0f
// Size: 0x37
function function_9d6ce2517d65ac33()
{
    flags::gameflagwait( "prematch_fade_done" );
    
    while ( self.plotarmor || self.brneverlanded || !self isonground() )
    {
        wait 1;
    }
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0xf452ede0, Offset: 0xe4e
// Size: 0x3d
function function_825e237e2ad7d47c()
{
    delay = getdvarint( @"hash_885e7f2a0d7182ee", 3 );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    hud_message::showsplash( "splash_br_shock_thunder_rolling" );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x373327e9, Offset: 0xe93
// Size: 0x93, Type: bool
function function_a72053a138949752( player )
{
    if ( player.plotarmor || player.insertingarmorplate || player.revivingteammate || player isreloading() || player shock_buff::function_190baf3bc469fb5e().size >= shock_buff::function_322bb369bc3160d4() || player manager::isuibot() || !player::isaliveandnotinlaststand( player ) || player br_public::isplayerinorgoingtogulag() || player isskydiving() || player isswimming() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xfcaa3e3, Offset: 0xf2f
// Size: 0x174
function function_3ae6f1ad93385f49( player )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "lightning_strike" ] ) )
        {
            player.leaderboarddata[ "lightning_strike" ] = player.leaderboarddata[ "lightning_strike" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "lightning_strike" ] ) )
        {
            [[ level.leaderboardfunc[ "lightning_strike" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "lightning_strike" ] ) )
        {
            player.pers[ "lightning_strike" ] = player.pers[ "lightning_strike" ] + 1;
        }
    }
    
    hitpos = function_f15688ff57b3243b( player );
    
    if ( isdefined( hitpos ) )
    {
        function_d3e51c8e2d814e6( hitpos );
        return;
    }
    
    buffdata = function_d2e3bc65463e8438( player );
    
    if ( isdefined( buffdata ) )
    {
        if ( function_c08f8ed5129f5124( player ) )
        {
            function_f0bd3045ed2ce68e( player );
            function_f455d1eeeacc0cbc( player, buffdata );
            
            if ( player challenges::challengesenabledforplayer() )
            {
                challenges::function_5c77e5a42636de6( player );
            }
            
            return;
        }
    }
    
    function_efb888735cd58f01( player );
    player hud_message::showsplash( "splash_br_shock_miss_lightning" );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x1d9acfdc, Offset: 0x10ab
// Size: 0x15e
function function_f15688ff57b3243b( player )
{
    var_53a9762cc77bb63f = 20000;
    hitpos = undefined;
    ignores = [];
    ignores[ ignores.size ] = player;
    
    if ( player vehicle::is_in_vehicle() && level.var_3f58b1591b1d651a.size > 0 && arraycontains( level.var_3f58b1591b1d651a, player.vehicle.vehiclename ) )
    {
        ignores[ ignores.size ] = player.vehicle;
    }
    
    startpos = player.origin + ( 0, 0, var_53a9762cc77bb63f );
    endpos = player utility::function_68061c3d21a6d57a();
    var_919ac9ffb4147a4e = trace::ray_trace( startpos, endpos, ignores );
    
    /#
        if ( getdvarint( @"hash_fd8d66fc9e6216fb", 0 ) > 0 )
        {
            if ( player ishost() )
            {
                sphere( endpos, 3, ( 0, 1, 0 ) );
                
                if ( var_919ac9ffb4147a4e[ "<dev string:x4a>" ] != "<dev string:x52>" )
                {
                    line( endpos, var_919ac9ffb4147a4e[ "<dev string:x5f>" ], ( 0, 1, 0 ) );
                    sphere( var_919ac9ffb4147a4e[ "<dev string:x5f>" ], 3, ( 1, 0, 0 ) );
                }
            }
        }
    #/
    
    if ( var_919ac9ffb4147a4e[ "hittype" ] != "hittype_none" )
    {
        return var_919ac9ffb4147a4e[ "position" ];
    }
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x58e3c452, Offset: 0x1212
// Size: 0x44, Type: bool
function function_c08f8ed5129f5124( player )
{
    if ( function_50beb4b33b0610d4( player ) )
    {
        return false;
    }
    
    var_e2599aca71194720 = getdvarint( @"hash_c288f49184627af2", 60 );
    
    if ( randomint( 100 ) <= var_e2599aca71194720 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x1654603c, Offset: 0x125f
// Size: 0x168
function function_d2e3bc65463e8438( player )
{
    bufflist = [];
    data = shock_buff::function_bac1dfda54ed1fc();
    randommax = 0;
    
    foreach ( buffdata in data )
    {
        if ( !player shock_buff::function_bb948d60922e522( buffdata.key ) )
        {
            continue;
        }
        
        bufflist[ bufflist.size ] = buffdata;
        randommax += buffdata.droprate;
    }
    
    if ( bufflist.size == 0 )
    {
        return;
    }
    
    random = randomint( randommax );
    
    foreach ( buffdata in bufflist )
    {
        if ( random < buffdata.droprate )
        {
            return buffdata;
        }
        
        random -= buffdata.droprate;
    }
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xa8b0906c, Offset: 0x13d0
// Size: 0x32
function function_f0bd3045ed2ce68e( player )
{
    pos = function_5bbaf47fa57682d2( player );
    function_d3e51c8e2d814e6( pos );
    thread function_60fdaaf9f726c3d2( player );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xfd23cb8b, Offset: 0x140a
// Size: 0x93
function function_5bbaf47fa57682d2( player )
{
    var_3f4643679b6da444 = -200;
    frontdistance = getdvarfloat( @"hash_6a4e69f0e6f7122d", 20 );
    eyefront = player geteye() + anglestoforward( player.angles ) * frontdistance;
    var_ebd05da452925eb5 = trace::ray_trace( eyefront, eyefront + ( 0, 0, var_3f4643679b6da444 ), player );
    
    if ( var_ebd05da452925eb5[ "hittype" ] == "hittype_none" )
    {
        return player.origin;
    }
    
    return var_ebd05da452925eb5[ "position" ];
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x72ec92b4, Offset: 0x14a6
// Size: 0x19e
function function_60fdaaf9f726c3d2( player )
{
    player endon( #"disconnect" );
    zapshock = weapon::_launchgrenade( "shock_stick_mp", player.origin, player.origin );
    zapshock.owner = player;
    zapshock.tableinfo = weapon::getequipmenttableinfo( equipment_mp::function_fdc4a655fbde0dec( "shock_stick_mp" ) );
    zapshock hide();
    totalduration = getdvarfloat( @"hash_d21a0f0a7c8c6372", 5 );
    tickinterval = getdvarfloat( @"hash_7f89ae53cd0da6ad", 0.2 );
    weaponobj = makeweapon( "shock_stick_mp" );
    tickcount = totalduration / tickinterval;
    zapshock thread function_30b380e3b9fe0a56( totalduration + 1 );
    player thread function_c5380fdb0d6edddc();
    player val::set( "haywire_controls", "fire", 0 );
    player.var_192ff6d823148f9a = 1;
    
    for ( ticks = 0; ticks < tickcount ; ticks++ )
    {
        if ( level.gameended || !isalive( player ) || player br_public::isplayerinorgoingtogulag() )
        {
            data = damage_utility::packdamagedata( player, player, 1, weaponobj, "MOD_EXPLOSIVE", player, player.origin );
            shock_stick::function_396a585ccd7071f5( data, 0 );
            return;
        }
        
        zapshock childthread shock_stick::shockstick_applyhaywire( player, weaponobj, 0 );
        wait tickinterval;
    }
    
    player waittill( #"haywire_cleared" );
    player function_20e9574ae840be4d( 1 );
}

// Namespace br_alt_mode_shock
// Params 0
// Checksum 0x19a16c6e, Offset: 0x164c
// Size: 0x69
function function_c5380fdb0d6edddc()
{
    var_19a2aa973d9467e = getdvarfloat( @"hash_6799c2080e73f921", 2 );
    
    if ( var_19a2aa973d9467e <= 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"hash_ec44c9c6c131f8a9" );
    self endon( #"hash_ec44c9c6c131f8a9" );
    function_bf0a1941c1bac989( 1 );
    wait var_19a2aa973d9467e;
    function_bf0a1941c1bac989( 0 );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0xe395e192, Offset: 0x16bd
// Size: 0x1c
function function_30b380e3b9fe0a56( seconds )
{
    if ( seconds > 0 )
    {
        wait seconds;
    }
    
    self delete();
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x7525ba59, Offset: 0x16e1
// Size: 0xcd
function function_efb888735cd58f01( player )
{
    var_d6309eb37536ae42 = 2500;
    var_bf15edbcbfc83375 = getdvarint( @"hash_3a31681b83a56ea4", 50 );
    var_bf38d7bcbfee4acb = getdvarint( @"hash_3a54761b83cbd526", 150 );
    var_960a0b91b8eaa86d = getdvarint( @"hash_4a1af0e83be72850", 45 );
    rotatevec = rotatepointaroundvector( anglestoup( player.angles ), anglestoforward( player.angles ), randomfloatrange( -1 * var_960a0b91b8eaa86d, var_960a0b91b8eaa86d ) );
    pos = player.origin + rotatevec * randomintrange( var_bf15edbcbfc83375, var_bf38d7bcbfee4acb );
    function_d3e51c8e2d814e6( utility::drop_to_ground( pos, var_d6309eb37536ae42 ) );
}

// Namespace br_alt_mode_shock
// Params 1
// Checksum 0x162fecdd, Offset: 0x17b6
// Size: 0x30
function function_d3e51c8e2d814e6( pos )
{
    playfx( utility::getfx( "vfx_lightning_zaps_main" ), pos );
    playfx( utility::getfx( "vfx_lightning_zaps_impact" ), pos );
}

// Namespace br_alt_mode_shock
// Params 2
// Checksum 0x2bb8a094, Offset: 0x17ee
// Size: 0x1fb
function function_f455d1eeeacc0cbc( player, buffdata )
{
    zap_damage = getdvarint( @"hash_14b8e62a4d7da687", 20 );
    
    if ( zap_damage >= player.health )
    {
        zap_damage = player.health - 1;
    }
    
    damaged = player dodamage( zap_damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "shock_thunder_mp_br" );
    player shock_buff::function_41848c552f45f2e4( buffdata, &function_bd778b50021ced7e );
    
    switch ( buffdata.key )
    {
        case #"hash_8371b837bfe6bb85":
        case #"hash_cf70d9fcb8cdbfa0":
        case #"hash_dac037286f1fbfe6":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ buffdata.key ] ) )
                {
                    player.leaderboarddata[ buffdata.key ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ buffdata.key ] ) )
                {
                    [[ level.leaderboardfunc[ buffdata.key ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( player.pers[ buffdata.key ] ) )
                {
                    player.pers[ buffdata.key ] += 1;
                }
            }
            
            break;
        default:
            assertmsg( "<dev string:x68>" + buffdata.key );
            break;
    }
}

/#

    // Namespace br_alt_mode_shock
    // Params 0
    // Checksum 0x97a46a9d, Offset: 0x19f1
    // Size: 0x1ed, Type: dev
    function function_921c0adef6604ca2()
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        function_9d6ce2517d65ac33();
        
        while ( true )
        {
            color = ( 1, 0, 0 );
            
            if ( function_a72053a138949752( self ) )
            {
                debugmsg = "<dev string:xa7>";
                
                if ( isdefined( function_f15688ff57b3243b( self ) ) )
                {
                    debugmsg += "<dev string:xaf>";
                }
                
                if ( function_50beb4b33b0610d4( self ) )
                {
                    debugmsg += "<dev string:xb7>";
                }
            }
            else
            {
                debugmsg = "<dev string:xc1>";
                color = ( 0, 1, 0 );
            }
            
            if ( self ishost() )
            {
                childthread utility::debugprinttoscreen( debugmsg, 0.1, 300, 300, color );
            }
            else
            {
                print3d( self.origin + ( 0, 0, 50 ), debugmsg, ( 1, 0, 0 ), 1, 0.5, 1, 1 );
            }
            
            if ( isdefined( self.shockbuffs ) )
            {
                index = 1;
                color = ( 0, 0, 1 );
                
                foreach ( buff in self.shockbuffs )
                {
                    debugmsg = buff.key;
                    
                    if ( self ishost() )
                    {
                        childthread utility::debugprinttoscreen( debugmsg, 0.1, 300, 300 + index * 20, color );
                    }
                    else
                    {
                        print3d( self.origin + ( 0, 0, 50 + index * 10 ), debugmsg, color, 1, 0.5, 1, 1 );
                    }
                    
                    index++;
                }
            }
            
            waitframe();
        }
    }

#/
