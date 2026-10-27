// scripts\mp\br\gametypes\br_analytics.gsc  (hash_6a15e432500b045a.gscc) (size: 85947 Bytes / 0x14fbb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x81417b87 (2168552327)
// size ...... 85947 (0x14fbb)
// includes .. 33  (offset: 0x12997)
// strings ... 602 (offset: 0x12a9f)
// dev strs .. 2   (offset: 0x14f9f)
// exports ... 175 (offset: 0xeadf)
// cseg ...... 0x2f50 + 0xbb8f (0xeadf)
// imports ... 224 (offset: 0x10637)
// animtree1 . 0   (offset: 0x14fbb)
// animtree2 . 0   (offset: 0x14fbb)
#using script_2444b97a3516cbb0;
#using script_26ccbfe3954cacf4;
#using script_7381472113d2aa0b;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\ai_fortress;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\gamescore;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\matchdata;
#using scripts\mp\poi;
#using scripts\mp\supers;
#using scripts\mp\team_assimilation;

#namespace br_analytics;

// Namespace br_analytics
// Params 0
// Checksum 0x93cc24bf, Offset: 0x2f6e
// Size: 0x124
function branalytics_init()
{
    if ( isdefined( level.matchdata_br_onmatchstart ) )
    {
        return;
    }
    
    if ( false )
    {
        return;
    }
    
    if ( !branalytics_validation() )
    {
        return;
    }
    
    utility::registersharedfunc( #"analytics", #"agent_alloc", &function_23f12d9752a5ffac );
    utility::registersharedfunc( #"analytics", #"agent_spawn", &function_678567c990494032 );
    utility::registersharedfunc( #"analytics", #"agent_killed", &function_4abae0b31fa92566 );
    utility::registersharedfunc( #"analytics", #"branalytics_xpearned", &branalytics_xpearned );
    callback::add( #"br_circle_closed", &function_8f374dc9989d5f5d );
    level.branalytics_enabled = istrue( level.var_1d0723ba4b98bfcd );
    level.matchdata_br_onmatchstart = &onmatchstartbr;
    level.delayedeventtypes = [];
    level.var_e83383d9616d93e3 = getdvarint( @"hash_6169803d232444ff", 0 );
    
    if ( true )
    {
        level.var_e83383d9616d93e3 = 1;
        analyticsreset();
    }
    
    level thread function_9897f61794f65a6d();
    level thread function_234f492fa918bf26();
    level thread function_9e7bb75b3cafcae5();
    level thread function_3788dfc460cd62b4();
}

// Namespace br_analytics
// Params 2
// Checksum 0xa2633746, Offset: 0x309a
// Size: 0x3e
function function_c4a53a0ca37c9a7( info, var_5c371065f365077d )
{
    if ( isdedicatedserver() )
    {
        setdvar( @"hash_bd87b6ef2da571db", info );
    }
    
    if ( var_5c371065f365077d )
    {
        logstring( "[KEY_MOMENT] " + info );
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0x466ec0d, Offset: 0x30e0
// Size: 0x1f8
function function_9e7bb75b3cafcae5()
{
    level endon( #"game_ended" );
    wait 0.1;
    
    if ( !level.skipprematch )
    {
        function_c4a53a0ca37c9a7( "prematch_waiting" );
        level waittill( #"match_start_timer_beginning" );
        wait 1;
        function_c4a53a0ca37c9a7( "prematch_countdown begin", 1 );
        
        while ( isdefined( level.matchcountdowntime ) )
        {
            function_c4a53a0ca37c9a7( "prematch_countdown " + level.matchcountdowntime );
            wait 1;
        }
    }
    
    if ( !level.br_infils_disabled )
    {
        function_c4a53a0ca37c9a7( "prematch_cinematic begin", 1 );
        wait 2;
        
        while ( level.infilcinematicactive )
        {
            wait 1;
        }
        
        function_c4a53a0ca37c9a7( "prematch_cinematic end", 1 );
        wait 1;
        level notify( #"prematch_cinematic_end" );
    }
    
    logstring( "[KEY_MOMENT] Infil Sequence Done" );
    
    while ( true )
    {
        circleindex = 0;
        aliveplayers = 0;
        alivesquads = 0;
        
        foreach ( team in level.teamnamelist )
        {
            teamplayers = teams::getteamdata( team, "aliveCount" );
            
            if ( teamplayers > 0 )
            {
                aliveplayers += teamplayers;
                alivesquads += 1;
            }
        }
        
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            circleindex = level.br_circle.circleindex;
        }
        
        info = "circle=" + circleindex + " alive=" + aliveplayers + " squads=" + alivesquads;
        function_c4a53a0ca37c9a7( info );
        wait 10;
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0xf018301d, Offset: 0x32e0
// Size: 0x29
function function_2f67e414d20d202f()
{
    level endon( #"game_cleanup" );
    level waittill( #"br_ending_start" );
    function_c4a53a0ca37c9a7( "game_ended, watching exfil", 1 );
}

// Namespace br_analytics
// Params 0
// Checksum 0x19527645, Offset: 0x3311
// Size: 0x86
function function_3788dfc460cd62b4()
{
    level thread function_2f67e414d20d202f();
    level waittill( #"game_ended" );
    function_c4a53a0ca37c9a7( "game_ended, watching final kill", 1 );
    wait 1.5;
    function_c4a53a0ca37c9a7( "game_ended, watching splash", 1 );
    
    if ( isdefined( level.br_ending_delay ) )
    {
        wait level.br_ending_delay;
    }
    
    level waittill( #"round_end_finished" );
    function_c4a53a0ca37c9a7( "game_ended, round_end_finished", 1 );
    level waittill( #"game_cleanup" );
    function_c4a53a0ca37c9a7( "game_ended, game_cleanup", 1 );
}

// Namespace br_analytics
// Params 0
// Checksum 0x8cce443b, Offset: 0x339f
// Size: 0xe9
function function_234f492fa918bf26()
{
    level endon( #"game_ended" );
    
    if ( !isdedicatedserver() )
    {
        return;
    }
    
    level waittill( #"prematch_cinematic_end" );
    wait 45;
    function_3448f4d1cf3a201f( "br_peak", 30 );
    wait 31;
    maxplayers = getdvarint( @"party_maxplayers", 0 );
    playercount = level.players.size;
    
    if ( playercount > maxplayers - 20 || getdvarint( @"hash_cd9d15d61f6e2380", 0 ) > 0 )
    {
        runjqprofile( "br_peak", 1 );
        wait 2;
    }
    
    if ( getdvarint( @"br_endmatchaftercapture", 0 ) > 0 && isdefined( level.var_861afd6b8f08f49a ) )
    {
        logstring( "br_endMatchAfterCapture" );
        self thread [[ level.var_861afd6b8f08f49a ]]( level.brgametype.firstteam, game[ "end_reason" ][ "objective_completed" ] );
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0xd4447d38, Offset: 0x3490
// Size: 0x44f
function function_9897f61794f65a6d()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    level.branalytics_enabled = 1;
    humans = 0;
    bots = 0;
    headless = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isbot( player ) || istestclient( player ) || player manager::isuibot() )
        {
            bots += 1;
            _branalytics_addevent( "player_spawned", player getorigin(), 0, "", player );
            continue;
        }
        
        if ( player isplayerheadless() )
        {
            headless += 1;
            _branalytics_addevent( "player_spawned", player getorigin(), 13, "", player );
            continue;
        }
        
        humans += 1;
        _branalytics_addevent( "player_spawned", player getorigin(), 0, "", player );
    }
    
    logstring( "[KEY_MOMENT] Prematch Done" );
    logstring( "=============================================" );
    logstring( "bots       = " + bots );
    logstring( "headless   = " + headless );
    logstring( "humans     = " + humans );
    logstring( "uiBot      = " + manager::function_6f7e22d4e6adac55() );
    logstring( "=============================================" );
    timenow = _branalytics_geteventtimestamp();
    function_974554b1c5fb54d7( "prematch_done", ( 0, 0, 0 ), 0, int( timenow ), "", -1 );
    entity_index_circle = -3;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        time = timenow;
        circlecount = level.br_level.br_circleradii.size;
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        _branalytics_addevent( "multiCircleCount", ( 0, 0, 0 ), multicirclecount );
        
        for ( circleindex = 0; circleindex < circlecount - 1 ; circleindex++ )
        {
            radius = level.br_level.br_circleradii[ circleindex ];
            timedelay = level.br_level.br_circledelaytimes[ circleindex ] * 1000;
            timeclose = level.br_level.br_circleclosetimes[ circleindex ] * 1000;
            function_974554b1c5fb54d7( "circleTime", ( 0, 0, 0 ), 0, int( time ), "c" + string( circleindex ), entity_index_circle );
            
            if ( multicirclecount > 0 )
            {
                for ( i = 0; i < multicirclecount ; i++ )
                {
                    timemulti = time;
                    origin = level.br_multi_circle.circles[ i ].circlecenters[ circleindex ];
                    function_974554b1c5fb54d7( "circle" + string( i ), origin, int( radius ), int( timemulti ), "start", entity_index_circle - i );
                    timemulti += timedelay;
                    function_974554b1c5fb54d7( "circle" + string( i ), origin, int( radius ), int( timemulti ), "close", entity_index_circle - i );
                }
                
                time += timedelay;
                time += timeclose;
                continue;
            }
            
            origin = level.br_level.br_circlecenters[ circleindex ];
            
            if ( isdefined( timedelay ) && isdefined( timeclose ) )
            {
                function_974554b1c5fb54d7( "circle", origin, int( radius ), int( time ), "start", entity_index_circle );
                time += timedelay;
                function_974554b1c5fb54d7( "circle", origin, int( radius ), int( time ), "close", entity_index_circle );
                time += timeclose;
            }
        }
    }
    
    thread function_208a60c964dfc6fe();
}

// Namespace br_analytics
// Params 0
// Checksum 0x21e95a49, Offset: 0x38e7
// Size: 0xeb
function function_208a60c964dfc6fe()
{
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_bf9f0bb802285117", 1 ) )
    {
        return;
    }
    
    var_e817b2ec03173f98 = getdvarint( @"hash_e1eaeff3e2aacceb", 20 );
    
    while ( true )
    {
        waitframe();
        var_f2a4dde4f7937ba6 = var_e817b2ec03173f98 / maxint( level.players.size, 1 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                branalytics_inventory_snapshot( player, "heartbeat" );
            }
            
            wait var_f2a4dde4f7937ba6;
        }
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0x8856cfe4, Offset: 0x39da
// Size: 0x18, Type: bool
function _branalytics_addeventallowed()
{
    if ( !branalytics_validation() )
    {
        return false;
    }
    
    return istrue( level.branalytics_enabled );
}

// Namespace br_analytics
// Params 0
// Checksum 0x26cc9f94, Offset: 0x39fb
// Size: 0x14
function _branalytics_geteventtimestamp()
{
    time = gettime();
    return time;
}

// Namespace br_analytics
// Params 6
// Checksum 0xbd706e86, Offset: 0x3a18
// Size: 0x3aa
function function_974554b1c5fb54d7( type, origin, state, time, data, entnum )
{
    if ( !level.branalytics_enabled )
    {
        return;
    }
    
    if ( !isstring( data ) )
    {
        data = "";
    }
    
    if ( true )
    {
        if ( !isdefined( level.var_5a663f72a5c0469a ) )
        {
            level.var_5a663f72a5c0469a = [];
            level.var_3afd1e6062ee5b18 = [];
            level.var_3afd1e6062ee5b18[ "breadcrumb" ] = 1;
            level.var_3afd1e6062ee5b18[ "playerCount" ] = 1;
            level.var_3afd1e6062ee5b18[ "multiCircleCount" ] = 1;
            level.var_3afd1e6062ee5b18[ "player_spawned" ] = 1;
            level.var_3afd1e6062ee5b18[ "prematch_done" ] = 1;
            level.var_3afd1e6062ee5b18[ "dropkit" ] = 1;
            level.var_3afd1e6062ee5b18[ "bonusXpDebug" ] = 1;
            level.var_3afd1e6062ee5b18[ "xp_event_brWeaponXp" ] = 1;
            level.var_3afd1e6062ee5b18[ "gulag_end" ] = 1;
            level.var_3afd1e6062ee5b18[ "vehicle" ] = 1;
            level.var_3afd1e6062ee5b18[ "kiosk" ] = 1;
            level.var_3afd1e6062ee5b18[ "mission" ] = 1;
            level.var_3afd1e6062ee5b18[ "agent_spawn" ] = 1;
            level.var_3afd1e6062ee5b18[ "agent_alloc" ] = 1;
            level.var_3afd1e6062ee5b18[ "unlock_all_blacksite_doors" ] = 1;
            level.var_3afd1e6062ee5b18[ "fortress_rejected" ] = 1;
            level.var_3afd1e6062ee5b18[ "fortress_loot_zone" ] = 1;
            level.var_3afd1e6062ee5b18[ "fortress_undefined_zonebounds" ] = 1;
            level.var_3afd1e6062ee5b18[ "circle" ] = 1;
            level.var_3afd1e6062ee5b18[ "circle0" ] = 1;
            level.var_3afd1e6062ee5b18[ "circle1" ] = 1;
            level.var_3afd1e6062ee5b18[ "circle2" ] = 1;
        }
        
        dpincluded = !isdefined( level.var_3afd1e6062ee5b18[ type ] );
        var_af225b62480e92f4 = 0;
        var_1bd38b7c1c8d562e = 0;
        var_2ac41bce80cebc44 = 0;
        var_6d01858ade3ad69e = 0;
        
        if ( dpincluded )
        {
            if ( !isdefined( level.var_5a663f72a5c0469a[ type ] ) )
            {
                var_af225b62480e92f4 = 1;
                neweventtype = spawnstruct();
                neweventtype.index = level.var_5a663f72a5c0469a.size;
                neweventtype.datatypes = [];
                neweventtype.var_3ffc09b36b288eb2 = 0;
                level.var_5a663f72a5c0469a[ type ] = neweventtype;
            }
            
            dptype = level.var_5a663f72a5c0469a[ type ];
            var_6d01858ade3ad69e = dptype.index;
            
            if ( data != "" )
            {
                if ( !isdefined( dptype.datatypes[ data ] ) )
                {
                    var_2ac41bce80cebc44 = 1;
                    dptype.datatypes[ data ] = dptype.var_3ffc09b36b288eb2;
                    dptype.var_3ffc09b36b288eb2 += 1;
                }
                
                var_1bd38b7c1c8d562e = dptype.datatypes[ data ];
            }
        }
        
        analyticsaddevent( origin, type, state, time, data, entnum, dpincluded, var_6d01858ade3ad69e, var_af225b62480e92f4, var_1bd38b7c1c8d562e, var_2ac41bce80cebc44 );
    }
    
    if ( 0 && type != "breadcrumb" )
    {
        logstring( "[GAE]," + time + "," + entnum + "," + origin[ 0 ] + "," + origin[ 1 ] + "," + type + "," + state + "," + data );
    }
}

// Namespace br_analytics
// Params 5
// Checksum 0x51f2d97f, Offset: 0x3dca
// Size: 0xaf
function _branalytics_addevent( type, origin, state, data, ent )
{
    if ( !_branalytics_addeventallowed() )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    entnum = isdefined( ent ) ? ent getentitynumber() : -1;
    time = _branalytics_geteventtimestamp();
    function_974554b1c5fb54d7( type, origin, state, time, data, entnum );
    
    if ( isdefined( ent ) )
    {
        ent function_b0da78f7298f9896( time );
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0x1cd5698e, Offset: 0x3e81
// Size: 0x39
function function_8158a1a8b4e6ce48( type, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    _branalytics_addevent( type, ent.origin, 0, "", ent );
}

// Namespace br_analytics
// Params 4
// Checksum 0xda455edc, Offset: 0x3ec2
// Size: 0x47
function function_c0b2fd4f1305c12b( type, ent, state, data )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    _branalytics_addevent( type, ent.origin, state, data, ent );
}

// Namespace br_analytics
// Params 4
// Checksum 0x4c394529, Offset: 0x3f11
// Size: 0x131
function _branalytics_addeventdelayed( type, origin, ent, data )
{
    assert( isdefined( level.delayedeventtypes ) );
    assert( isdefined( type ) );
    assert( isdefined( origin ) );
    assert( isdefined( ent ) );
    
    if ( !isdefined( type ) )
    {
        type = "undefined";
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    if ( !isdefined( level.delayedeventtypes[ type ] ) )
    {
        level.delayedeventtypes[ type ] = [];
    }
    
    evt = spawnstruct();
    evt.type = type;
    evt.origin = origin;
    evt.ent = ent;
    evt.data = data;
    evt.state = 0;
    evt.time = _branalytics_geteventtimestamp();
    evtindex = level.delayedeventtypes[ type ].size;
    level.delayedeventtypes[ type ][ evtindex ] = evt;
}

// Namespace br_analytics
// Params 3
// Checksum 0x6bbea5b4, Offset: 0x404a
// Size: 0xe1
function branalytics_seteventdelayedstate( type, ent, state )
{
    if ( !( isdefined( type ) && isdefined( ent ) && isdefined( level.delayedeventtypes[ type ] ) ) )
    {
        return;
    }
    
    foreach ( evt in level.delayedeventtypes[ type ] )
    {
        if ( evt.ent == ent )
        {
            evt.time = _branalytics_geteventtimestamp();
            evt.state = state;
            return;
        }
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0x58d009d6, Offset: 0x4133
// Size: 0x6
function branalytics_validation()
{
    return isbrgamemode();
}

// Namespace br_analytics
// Params 3
// Checksum 0xd71703f1, Offset: 0x4142
// Size: 0x1d9
function branalytics_equipmentuse( player, objweapon, item_type )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    equipmentname = objweapon.basename;
    assert( isstring( equipmentname ) );
    
    if ( function_97de808fe549b3b7() )
    {
        player function_ad05aed95a44741e( -5131939735000893127, [ 11:item_type, 10:equipmentname, 9:level.br_circle.circleindex ?? -1, 8:utility::getplayeryaw( player ), 7:utility::getplayerpitch( player ), 6:player.origin[ 2 ], 5:player.origin[ 1 ], 4:player.origin[ 0 ] ] );
    }
    else
    {
        player dlog_recordplayerevent( "dlog_event_br_equipment_use", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "item_name", equipmentname, "item_type", item_type ] );
    }
    
    _branalytics_addevent( "equipment_use", player.origin, 0, equipmentname, player );
}

// Namespace br_analytics
// Params 5
// Checksum 0x4e9e3ad, Offset: 0x4323
// Size: 0x83f
function branalytics_down( attacker, victim, objweapon, deathtype, meansofdeath )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        id = attacker getentitynumber();
        function_c0b2fd4f1305c12b( "down_by_agent", victim, id, deathtype );
        return;
    }
    
    if ( !isent( attacker ) || !isplayer( attacker ) )
    {
        attacker_weapon_name = "world";
        attacker = victim;
    }
    else if ( isdefined( objweapon ) )
    {
        attacker_weapon_name = objweapon.basename;
    }
    else
    {
        attacker_weapon = attacker getcurrentweapon();
        attacker_weapon_name = attacker_weapon.basename;
    }
    
    assert( isstring( attacker_weapon_name ) );
    victim_weapon = player::isinlaststand( victim ) && isdefined( victim.laststandoldweaponobj ) ? victim.laststandoldweaponobj : victim.lastweaponused;
    victim_weapon_name = isdefined( victim_weapon ) ? victim_weapon.basename : "";
    assert( isstring( victim_weapon_name ) );
    var_71c9ca189a11eb61 = attacker getclientomnvar( "ui_br_objective_index" );
    
    if ( !isdefined( var_71c9ca189a11eb61 ) )
    {
        var_126a5ca1042827a4 = "none";
    }
    else
    {
        var_126a5ca1042827a4 = tablelookup( "mp/brmissions.csv", 0, var_71c9ca189a11eb61, 1 );
    }
    
    var_71c9ca189a11eb61 = victim getclientomnvar( "ui_br_objective_index" );
    
    if ( !isdefined( var_71c9ca189a11eb61 ) )
    {
        var_a999503a94e0d06d = "NONE";
    }
    else
    {
        var_a999503a94e0d06d = tablelookup( "mp/brmissions.csv", 0, var_71c9ca189a11eb61, 1 );
    }
    
    teammates = teams::getfriendlyplayers( victim.team, 1 );
    closestdistance = 2147483647;
    
    foreach ( teammate in teammates )
    {
        if ( teammate == victim )
        {
            continue;
        }
        
        dist = distance( victim.origin, teammate.origin );
        
        if ( dist < closestdistance || closestdistance == 2147483647 )
        {
            closestdistance = dist;
        }
    }
    
    currentxp = victim.pers[ "summary" ][ "xp" ];
    
    if ( isdefined( currentxp ) )
    {
        xp_earned = currentxp - victim.pers[ "telemetry" ].life.var_cf1e1f502926dd46;
    }
    else
    {
        xp_earned = 0;
    }
    
    attackerloadoutperks = attacker getloadoutperks();
    var_7690b6cb9fc8d973 = victim getloadoutperks();
    
    if ( function_97de808fe549b3b7() )
    {
        var_cab3c3aa8a3c14c1 = [ 6:attacker.fieldguides ?? [], 5:attacker.lootperks ?? [], 4:attacker function_c939268adb80782c(), attackerloadoutperks[ 2 ] ?? "", 2:attackerloadoutperks[ 1 ] ?? "", 1:attackerloadoutperks[ 0 ] ?? "" ];
        var_ab19130b503b0a7e = [ 6:victim.fieldguides ?? [], 5:victim.lootperks ?? [], 4:victim function_c939268adb80782c(), var_7690b6cb9fc8d973[ 2 ] ?? "", 2:var_7690b6cb9fc8d973[ 1 ] ?? "", 1:var_7690b6cb9fc8d973[ 0 ] ?? "" ];
        attacker function_ad05aed95a44741e( -2998049597667655650, [ 25:xp_earned, 24:int( closestdistance ), 23:meansofdeath, 22:deathtype, 21:var_a999503a94e0d06d, 20:victim_weapon_name, 19:utility::getplayeryaw( victim ), 18:utility::getplayerpitch( victim ), 17:victim.origin[ 2 ], 16:victim.origin[ 1 ], 15:victim.origin[ 0 ], 14:var_126a5ca1042827a4, 13:attacker_weapon_name, 12:level.br_circle.circleindex ?? -1, 11:utility::getplayeryaw( attacker ), 10:utility::getplayerpitch( attacker ), 9:attacker.origin[ 2 ], 8:attacker.origin[ 1 ], 7:attacker.origin[ 0 ], 6:var_ab19130b503b0a7e, 5:var_cab3c3aa8a3c14c1, 4:victim ] );
    }
    else
    {
        var_cab3c3aa8a3c14c1 = [ "loadout_perk_1", attackerloadoutperks[ 0 ] ?? "", "loadout_perk_2", attackerloadoutperks[ 1 ] ?? "", "loadout_perk_3", attackerloadoutperks[ 2 ] ?? "", "wildcard_perk", attacker function_c939268adb80782c(), "loot_perks", attacker.lootperks ?? [], "field_guides", attacker.fieldguides ?? [] ];
        var_ab19130b503b0a7e = [ "loadout_perk_1", var_7690b6cb9fc8d973[ 0 ] ?? "", "loadout_perk_2", var_7690b6cb9fc8d973[ 1 ] ?? "", "loadout_perk_3", var_7690b6cb9fc8d973[ 2 ] ?? "", "wildcard_perk", victim function_c939268adb80782c(), "loot_perks", victim.lootperks ?? [], "field_guides", victim.fieldguides ?? [] ];
        attacker dlog_recordplayerevent( "dlog_event_br_down", [ "victim", victim, "attacker_perks", var_cab3c3aa8a3c14c1, "victim_perks", var_ab19130b503b0a7e, "attacker" + "_x", attacker.origin[ 0 ], "attacker" + "_y", attacker.origin[ 1 ], "attacker" + "_z", attacker.origin[ 2 ], "attacker" + "_pitch", utility::getplayerpitch( attacker ), "attacker" + "_yaw", utility::getplayeryaw( attacker ), "circle_index", level.br_circle.circleindex ?? -1, "attacker_weapon", attacker_weapon_name, "attacker_active_mission", var_126a5ca1042827a4, "victim" + "_x", victim.origin[ 0 ], "victim" + "_y", victim.origin[ 1 ], "victim" + "_z", victim.origin[ 2 ], "victim" + "_pitch", utility::getplayerpitch( victim ), "victim" + "_yaw", utility::getplayeryaw( victim ), "victim_weapon", victim_weapon_name, "victim_active_mission", var_a999503a94e0d06d, "death_type", deathtype, "means_of_death", meansofdeath, "closest_victim_teammate_distance", int( closestdistance ), "xp_earned", xp_earned ] );
    }
    
    function_c0b2fd4f1305c12b( "down", victim, analytics::_getdeathstatecode( deathtype ), attacker_weapon_name );
    function_f36588b74135d9f4( attacker, victim );
}

// Namespace br_analytics
// Params 2, eflags: 0x4
// Checksum 0x23f0d099, Offset: 0x4b6a
// Size: 0x1f5
function private function_f36588b74135d9f4( attacker, victim )
{
    isplayeringulag = attacker br_public::isplayerinorgoingtogulag();
    
    if ( isplayeringulag )
    {
        return;
    }
    
    var_261eb58f4e03e1c1 = getclosestpointonnavmesh( attacker.origin );
    var_16a0e2f1a2fbbfe3 = 0;
    
    if ( var_261eb58f4e03e1c1[ 2 ] >= attacker.origin[ 2 ] + 60 )
    {
        var_16a0e2f1a2fbbfe3 = 1;
    }
    
    if ( !var_16a0e2f1a2fbbfe3 )
    {
        return;
    }
    
    var_e19d3f45bafc368f = br_public::function_5d8b60a1b01b8249();
    var_b5b42f7b65eecf19 = br_public::function_b4d14b7b48e551af();
    origin = ( attacker.origin[ 0 ], attacker.origin[ 1 ], var_e19d3f45bafc368f );
    end = ( attacker.origin[ 0 ], attacker.origin[ 1 ], var_b5b42f7b65eecf19 );
    var_69fd22f9e720e316 = 10;
    contents = trace::create_contents( 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1 );
    ignoreents = undefined;
    results = trace::sphere_trace_get_all_results( origin, end, var_69fd22f9e720e316, ignoreents, contents );
    
    /#
        if ( false )
        {
            line( origin, end, ( 1, 1, 1 ), 1, 0, 2000 );
            
            foreach ( result in results )
            {
                if ( result[ "<dev string:x24>" ] )
                {
                    sphere( result[ "<dev string:x24>" ], 5, ( 1, 0.64, 0 ), 0, 2000 );
                }
            }
        }
    #/
    
    attacker function_47e0389c871b2bfd( victim, results );
}

// Namespace br_analytics
// Params 2, eflags: 0x4
// Checksum 0x47efe975, Offset: 0x4d67
// Size: 0x32e
function private function_47e0389c871b2bfd( victim, results )
{
    attacker = self;
    var_9d615602afceee65 = attacker.origin[ 2 ] + 60;
    var_6cd07cbd2ef64d70 = 0;
    var_a0a0f5a65802fe10 = 0;
    var_dd15550a78aab0 = "";
    var_ec85c71db616a5c4 = "";
    
    foreach ( result in results )
    {
        if ( !result[ "position" ] )
        {
            continue;
        }
        
        surfacetype = result[ "surfaceflags" ] ? physics_getsurfacetypefromflags( result[ "surfaceflags" ] ) : undefined;
        var_9b31753aa2faa7d6 = surfacetype ? surfacetype[ "name" ] : "none";
        
        if ( result[ "position" ][ 2 ] > var_9d615602afceee65 )
        {
            var_6cd07cbd2ef64d70++;
            var_dd15550a78aab0 += var_9b31753aa2faa7d6 + ",";
            continue;
        }
        
        var_a0a0f5a65802fe10++;
        var_ec85c71db616a5c4 += var_9b31753aa2faa7d6 + ",";
    }
    
    eventparams = [ "attacker_x", attacker.origin[ 0 ] ?? 0, "attacker_y", attacker.origin[ 1 ] ?? 0, "attacker_z", attacker.origin[ 2 ] ?? 0, "is_attacker_freefalling", attacker isinfreefall() ?? -1, "is_attacker_in_water", attacker isswimming() ?? -1, "is_attacker_hanging", attacker ishanging() ?? -1, "is_attacker_parachuting", attacker isparachuting() ?? -1, "is_attacker_jumping", attacker isjumping() ?? -1, "is_attacker_in_vehicle", attacker vehicle::is_in_vehicle( 1 ) ?? -1, "victim_x", victim.origin[ 0 ] ?? 0, "victim_y", victim.origin[ 1 ] ?? 0, "victim_z", victim.origin[ 2 ] ?? 0, "trace_result_above", var_6cd07cbd2ef64d70 + ":" + var_dd15550a78aab0 ?? "", "trace_result_below", var_a0a0f5a65802fe10 + ":" + var_ec85c71db616a5c4 ?? "", "playlist_name", getplaylistname() ?? "" ];
    attacker dlog_recordplayerevent( "dlog_event_br_anticheat_suspicious_under_map_kill", eventparams );
}

// Namespace br_analytics
// Params 0, eflags: 0x4
// Checksum 0xd58f741a, Offset: 0x509d
// Size: 0xc0
function private getloadoutperks()
{
    var_d729a2def84cf0f6 = [];
    defaultperks = class::function_c8d9816a5c9f1f97( self );
    
    if ( isdefined( self.loadoutperks ) )
    {
        foreach ( perk in self.loadoutperks )
        {
            if ( isdefined( level.cacperks[ perk ] ) && !arraycontains( defaultperks, perk ) )
            {
                var_d729a2def84cf0f6[ var_d729a2def84cf0f6.size ] = perk;
            }
        }
    }
    
    return var_d729a2def84cf0f6;
}

// Namespace br_analytics
// Params 2
// Checksum 0x9f289983, Offset: 0x5166
// Size: 0x19f
function branalytics_revive( reviver, revivee )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    reviver dlog_recordplayerevent( "dlog_event_br_revive", [ "revivee", revivee, "reviver" + "_x", reviver.origin[ 0 ], "reviver" + "_y", reviver.origin[ 1 ], "reviver" + "_z", reviver.origin[ 2 ], "reviver" + "_pitch", utility::getplayerpitch( reviver ), "reviver" + "_yaw", utility::getplayeryaw( reviver ), "circle_index", level.br_circle.circleindex ?? -1, "revivee" + "_x", revivee.origin[ 0 ], "revivee" + "_y", revivee.origin[ 1 ], "revivee" + "_z", revivee.origin[ 2 ], "revivee" + "_pitch", utility::getplayerpitch( revivee ), "revivee" + "_yaw", utility::getplayeryaw( revivee ) ] );
    function_8158a1a8b4e6ce48( "revive", revivee );
}

// Namespace br_analytics
// Params 1
// Checksum 0x3a7da301, Offset: 0x530d
// Size: 0xef
function branalytics_selfrevive( revivee )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    revivee dlog_recordplayerevent( "dlog_event_br_selfrevive", [ "revivee" + "_x", revivee.origin[ 0 ], "revivee" + "_y", revivee.origin[ 1 ], "revivee" + "_z", revivee.origin[ 2 ], "revivee" + "_pitch", utility::getplayerpitch( revivee ), "revivee" + "_yaw", utility::getplayeryaw( revivee ), "circle_index", level.br_circle.circleindex ?? -1 ] );
    function_8158a1a8b4e6ce48( "selfRevive", revivee );
}

// Namespace br_analytics
// Params 11
// Checksum 0x128c81ba, Offset: 0x5404
// Size: 0x338
function branalytics_secondwind( revivee, laststandattacker, victim, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, var_8bdbcd3d7da5ab82, var_52b8bcac39b24683, bbledout, var_b717015fd4296ea6 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    revivee dlog_recordplayerevent( "dlog_event_br_secondwind", [ "lastStandAttacker", laststandattacker, "victim", victim, "revivee" + "_x", revivee.origin[ 0 ], "revivee" + "_y", revivee.origin[ 1 ], "revivee" + "_z", revivee.origin[ 2 ], "revivee" + "_pitch", utility::getplayerpitch( revivee ), "revivee" + "_yaw", utility::getplayeryaw( revivee ), "circle_index", level.br_circle.circleindex ?? -1, "laststandattacker" + "_x", laststandattacker.origin[ 0 ], "laststandattacker" + "_y", laststandattacker.origin[ 1 ], "laststandattacker" + "_z", laststandattacker.origin[ 2 ], "laststandattacker" + "_pitch", utility::getplayerpitch( laststandattacker ), "laststandattacker" + "_yaw", utility::getplayeryaw( laststandattacker ), "victim" + "_x", victim.origin[ 0 ], "victim" + "_y", victim.origin[ 1 ], "victim" + "_z", victim.origin[ 2 ], "victim" + "_pitch", utility::getplayerpitch( victim ), "victim" + "_yaw", utility::getplayeryaw( victim ), "only_cleanup", var_8bdbcd3d7da5ab82, "only_downed", var_52b8bcac39b24683, "bled_out", bbledout, "downed_seconds", var_b717015fd4296ea6, "means_of_death", meansofdeath ?? "", "weapon_name", weaponname ?? "", "laststand_means_of_death", laststandmeansofdeath ?? "", "laststand_weapon_name", laststandweaponname ?? "" ] );
    function_8158a1a8b4e6ce48( "secondWind", revivee.origin );
}

// Namespace br_analytics
// Params 0
// Checksum 0x2aa38ae4, Offset: 0x5744
// Size: 0x18
function branalytics_deployallowed()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_deploy_allowed", [] );
}

// Namespace br_analytics
// Params 1
// Checksum 0xf9927733, Offset: 0x5764
// Size: 0xe1
function branalytics_deploytriggered( player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_deploy_triggered", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1 ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x68d61c3c, Offset: 0x584d
// Size: 0x248
function function_253a50887835eec2( player, var_1db4f479a1d154cb )
{
    player.endmatchstats[ "lastLandingSpot" ] = player.origin;
    player dlog_recordplayerevent( "dlog_event_br_spawn_landing", [ "respawned_time", var_1db4f479a1d154cb.respawnedtime ?? 0, "landed_time", gettime(), "reason_respawn", var_1db4f479a1d154cb.reasonrespawn ?? "none", "respawn_x", var_1db4f479a1d154cb.respawnedx ?? -1, "respawn_y", var_1db4f479a1d154cb.respawnedy ?? -1, "respawn_z", var_1db4f479a1d154cb.respawnedz ?? -1, "recent_attacker_size", player.recentattackers.size ?? -1, "land_x", player.origin[ 0 ] ?? 0, "land_y", player.origin[ 1 ] ?? 0, "land_z", player.origin[ 2 ] ?? 0, "start_health", var_1db4f479a1d154cb.starthealth ?? -1, "start_armor", var_1db4f479a1d154cb.startarmor ?? -1, "end_health", player.health ?? -1, "end_armor", player.armorhealth ?? -1, "circle_index", level.br_circle.circleindex ?? -1, "map_name", game_utility::getmapname() ?? "", "playlist_id", getplaylistid(), "playlist_name", getplaylistname() ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0x18b82694, Offset: 0x5a9d
// Size: 0xef
function branalytics_landing( player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_deploy_land", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1 ] );
    function_8158a1a8b4e6ce48( "land", player );
}

// Namespace br_analytics
// Params 1
// Checksum 0xf743a58d, Offset: 0x5b94
// Size: 0x33
function branalytics_playercount( playercount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "playerCount", ( 0, 0, 0 ), 0, playercount );
}

// Namespace br_analytics
// Params 3
// Checksum 0x8c156d53, Offset: 0x5bcf
// Size: 0x13d
function branalytics_lootpickup( player, scriptablename, amount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    assert( isstring( scriptablename ) );
    assert( isint( amount ) );
    player dlog_recordplayerevent( "dlog_event_br_loot_pickup", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "item_name", scriptablename, "amount", amount ] );
    function_c0b2fd4f1305c12b( "loot_pickup", player, amount, scriptablename );
}

// Namespace br_analytics
// Params 4
// Checksum 0x6db1cd39, Offset: 0x5d14
// Size: 0x168
function branalytics_lootdrop( player, itemtype, var_c38c5b063df2473c, amount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    assert( isstring( itemtype ) );
    var_c38c5b063df2473c = istrue( var_c38c5b063df2473c );
    assert( isint( var_c38c5b063df2473c ) );
    assert( isint( amount ) );
    player dlog_recordplayerevent( "dlog_event_br_loot_drop", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "item_name", itemtype, "is_drop_from_weapon_switch", var_c38c5b063df2473c, "amount", amount ] );
    function_c0b2fd4f1305c12b( "loot_drop", player, amount, itemtype );
}

// Namespace br_analytics
// Params 0
// Checksum 0xf1c5081e, Offset: 0x5e84
// Size: 0x14b
function function_c6ed0838e835cb05()
{
    var_8ebacffc3bfbb6d3 = getdvarint( @"hash_54fdb5d3a5fb94ab", 0 ) == 1;
    
    if ( !var_8ebacffc3bfbb6d3 )
    {
        return;
    }
    
    var_9b3e53b654b642c7 = getdvarint( @"hash_918e9ae29c62f107", 1000 );
    var_146ccb936c6e89fa = getdvarint( @"hash_123fb8393a3fe2b4", 30000 );
    level waittill( #"br_c130_left_bounds" );
    var_a77c7c4d92e0baa3 = 5;
    proximitywait = 0.5;
    proximity_throttle = throttle::function_ac02df3f2e81cbab( "player_proximity_tracking", var_a77c7c4d92e0baa3, undefined, proximitywait );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || isbot( player ) || istestclient( player ) || player isplayerheadless() )
        {
            continue;
        }
        
        player thread function_46867c1aed655466( proximity_throttle, var_9b3e53b654b642c7, var_146ccb936c6e89fa );
        throttle::function_706ed379a3746335( proximity_throttle );
    }
}

// Namespace br_analytics
// Params 3
// Checksum 0xca2981b6, Offset: 0x5fd7
// Size: 0x2a2
function function_46867c1aed655466( proximity_throttle, var_9b3e53b654b642c7, var_146ccb936c6e89fa )
{
    player = self;
    player endon( #"disconnect" );
    
    while ( true )
    {
        while ( player br_public::isplayerinorgoingtogulag() || !isalive( player ) )
        {
            wait 3;
        }
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        nearbyplayers = function_6a293b884c444a20( level.players, player.origin, var_9b3e53b654b642c7 );
        
        if ( isdefined( player.var_7ad5065024752863 ) )
        {
            foreach ( var_a8ecc40df37f4d26 in player.var_7ad5065024752863 )
            {
                if ( arraycontains( nearbyplayers, var_a8ecc40df37f4d26 ) && isalive( player ) && isalive( var_a8ecc40df37f4d26 ) )
                {
                    continue;
                }
                
                player notify( #"analytics_proximity_tracking", var_a8ecc40df37f4d26 );
            }
        }
        
        foreach ( nearbyplayer in nearbyplayers )
        {
            if ( !isplayer( nearbyplayer ) || !isalive( nearbyplayer ) || player.team == nearbyplayer.team || nearbyplayer br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( !isdefined( player.var_7ad5065024752863 ) )
            {
                player.var_7ad5065024752863 = [];
            }
            
            if ( !isdefined( nearbyplayer.var_7ad5065024752863 ) )
            {
                nearbyplayer.var_7ad5065024752863 = [];
            }
            
            if ( !arraycontains( player.var_7ad5065024752863, nearbyplayer ) && !arraycontains( nearbyplayer.var_7ad5065024752863, player ) )
            {
                player.var_7ad5065024752863[ player.var_7ad5065024752863.size ] = nearbyplayer;
                player thread function_ca94084d171af326( nearbyplayer, var_9b3e53b654b642c7, var_146ccb936c6e89fa );
                
                if ( false )
                {
                    iprintlnbold( "Player " + player getentitynumber() + " enters proximity range of Player " + nearbyplayer getentitynumber() );
                }
            }
            
            throttle::function_1302aa73badc74f0( proximity_throttle );
            
            if ( !isdefined( player ) )
            {
                return;
            }
        }
        
        throttle::function_706ed379a3746335( proximity_throttle );
    }
}

// Namespace br_analytics
// Params 3
// Checksum 0xa61a8a00, Offset: 0x6281
// Size: 0x1dc
function function_ca94084d171af326( targetenemy, var_9b3e53b654b642c7, var_146ccb936c6e89fa )
{
    player = self;
    starttime = gettime();
    var_750beed136ee60f1 = player currency::get_currency_amount( "cash" ) ?? 0;
    var_fb416a0d6b61b69 = targetenemy currency::get_currency_amount( "cash" ) ?? 0;
    var_fa5df757dae79bd9 = player.endmatchstats[ "kioskRevives" ] ?? 0;
    var_a6eff21821c5c021 = targetenemy.endmatchstats[ "kioskRevives" ] ?? 0;
    
    /#
        player thread function_d1aa7901bdc46f34( targetenemy );
    #/
    
    waittillplayer = undefined;
    
    while ( waittillplayer != targetenemy )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player waittill( #"analytics_proximity_tracking", waittillplayer );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    duration = gettime() - starttime;
    
    if ( isdefined( targetenemy ) )
    {
        player.var_7ad5065024752863 = arrayremove( player.var_7ad5065024752863, targetenemy );
        var_5064ccb414b5dd5a = targetenemy getentitynumber();
    }
    else
    {
        player.var_7ad5065024752863 = function_5713d46873b29625( player.var_7ad5065024752863 );
        var_5064ccb414b5dd5a = "";
    }
    
    if ( false )
    {
        iprintlnbold( "Player " + player getentitynumber() + " was within " + var_9b3e53b654b642c7 + " units of Player " + var_5064ccb414b5dd5a + " for " + duration + " ms." );
    }
    
    if ( duration <= var_146ccb936c6e89fa )
    {
        return;
    }
    
    var_fa5df757dae79bd9 = ( player.endmatchstats[ "kioskRevives" ] ?? 0 ) - var_fa5df757dae79bd9;
    var_a6eff21821c5c021 = ( targetenemy.endmatchstats[ "kioskRevives" ] ?? 0 ) - var_a6eff21821c5c021;
    player function_258c9bf62e9f28fd( var_9b3e53b654b642c7, var_750beed136ee60f1, var_fa5df757dae79bd9, targetenemy, var_fb416a0d6b61b69, var_a6eff21821c5c021, duration );
}

// Namespace br_analytics
// Params 1
// Checksum 0x8617ff0b, Offset: 0x6465
// Size: 0x95
function function_d1aa7901bdc46f34( targetenemy )
{
    if ( true )
    {
        return;
    }
    
    player = self;
    
    while ( isdefined( player ) && isdefined( targetenemy ) && arraycontains( player.var_7ad5065024752863, targetenemy ) )
    {
        /#
            line( player.origin + ( 0, 0, 50 ), targetenemy.origin + ( 0, 0, 50 ), ( 0, 1, 0 ), 1, 0, 10 );
        #/
        
        wait 2;
    }
}

// Namespace br_analytics
// Params 7
// Checksum 0x3a564e28, Offset: 0x6502
// Size: 0x1ec
function function_258c9bf62e9f28fd( var_9b3e53b654b642c7, var_750beed136ee60f1, var_fa5df757dae79bd9, targetenemy, var_fb416a0d6b61b69, var_a6eff21821c5c021, duration )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "distance_threshold";
    eventparams[ eventparams.size ] = var_9b3e53b654b642c7;
    eventparams[ eventparams.size ] = "player_team";
    eventparams[ eventparams.size ] = player.team ?? "";
    eventparams[ eventparams.size ] = "player_starting_money";
    eventparams[ eventparams.size ] = var_750beed136ee60f1 ?? 0;
    eventparams[ eventparams.size ] = "player_ending_money";
    endingmoney = player currency::get_currency_amount( "cash" );
    eventparams[ eventparams.size ] = endingmoney ?? 0;
    eventparams[ eventparams.size ] = "player_buyback_count";
    eventparams[ eventparams.size ] = var_fa5df757dae79bd9 ?? 0;
    eventparams[ eventparams.size ] = "target_uno_id";
    eventparams[ eventparams.size ] = targetenemy getplayerunoid() ?? "-1";
    eventparams[ eventparams.size ] = "target_team";
    eventparams[ eventparams.size ] = targetenemy.team ?? "";
    eventparams[ eventparams.size ] = "target_starting_money";
    eventparams[ eventparams.size ] = var_fb416a0d6b61b69 ?? 0;
    eventparams[ eventparams.size ] = "target_ending_money";
    var_5e207e8aab1496b8 = player currency::get_currency_amount( "cash" );
    eventparams[ eventparams.size ] = var_5e207e8aab1496b8 ?? 0;
    eventparams[ eventparams.size ] = "target_buyback_count";
    eventparams[ eventparams.size ] = var_a6eff21821c5c021 ?? 0;
    eventparams[ eventparams.size ] = "duration";
    eventparams[ eventparams.size ] = duration ?? 0;
    eventparams[ eventparams.size ] = "circle_index";
    circleindex = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = circleindex;
    player dlog_recordplayerevent( "dlog_event_br_anticheat_proximity_tracking", eventparams );
}

// Namespace br_analytics
// Params 2
// Checksum 0x81b03e4a, Offset: 0x66f6
// Size: 0xf9
function branalytics_gulagstart( player, type )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_gulag_start", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "type", type ] );
}

// Namespace br_analytics
// Params 3
// Checksum 0x94f9df79, Offset: 0x67f7
// Size: 0x24d
function branalytics_gulagend( player, type, arena )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventref = "none";
    var_2be6f42177474597 = "none";
    
    if ( isdefined( arena ) )
    {
        event = br_gulag::function_bc6aa264f5495083( "getEventSettings", arena );
        
        if ( isdefined( event ) )
        {
            eventref = event.ref;
        }
    }
    
    if ( isdefined( arena ) )
    {
        namedarena = br_gulag::function_bc6aa264f5495083( "getNamedArenaSettings", arena );
        
        if ( isdefined( namedarena ) )
        {
            var_2be6f42177474597 = namedarena.ref;
        }
    }
    
    player dlog_recordplayerevent( "dlog_event_br_gulag_end", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "type", type, "event", eventref, "named_arena", var_2be6f42177474597, "primary", player.loadoutprimary ?? "", "secondary", player.loadoutsecondary ?? "", "starting_lethal", player.loadoutequipmentprimary ?? "", "starting_tactical", player.loadoutequipmentsecondary ?? "", "pickups", player.var_e47f2b0c6f184dcb ?? 0 ] );
    function_c0b2fd4f1305c12b( "gulag_end", player, 0, type );
}

// Namespace br_analytics
// Params 2
// Checksum 0x4105087f, Offset: 0x6a4c
// Size: 0x49
function function_9270501b07846b57( total_escapee, ladder_kill )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_gulag_ladder_escape_result", [ "total_escapee", total_escapee, "ladder_kill", ladder_kill ] );
}

// Namespace br_analytics
// Params 3
// Checksum 0x9823bd22, Offset: 0x6a9d
// Size: 0x39
function branalytics_respawn( player, var_f2d322e851a3ede3, context )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    function_c0b2fd4f1305c12b( "respawn", player, var_f2d322e851a3ede3, context );
}

// Namespace br_analytics
// Params 2
// Checksum 0x8d37a3a5, Offset: 0x6ade
// Size: 0x29
function branalytics_disconnect( player, var_44395f6e53805e0d )
{
    function_c0b2fd4f1305c12b( "disconnect", player, var_44395f6e53805e0d, "" );
}

// Namespace br_analytics
// Params 1
// Checksum 0x77876f27, Offset: 0x6b0f
// Size: 0x109
function function_fee36b475ad2140( player )
{
    if ( !( isdefined( player.var_138f03c718ddc220 ) && isdefined( player.var_29d3d6d1ca17b761 ) ) )
    {
        player.var_29d3d6d1ca17b761 = spawnstruct();
    }
    
    player.var_29d3d6d1ca17b761.loadoutindex = 0;
    player.var_29d3d6d1ca17b761.isdefaultloadout = 0;
    var_85573efda90ebf81 = player.pers[ "class" ];
    
    if ( getsubstr( var_85573efda90ebf81, 0, 7 ) == "default" )
    {
        player.var_29d3d6d1ca17b761.isdefaultloadout = 1;
        player.var_29d3d6d1ca17b761.loadoutindex = int( getsubstr( var_85573efda90ebf81, 7 ) );
        return;
    }
    
    if ( getsubstr( var_85573efda90ebf81, 0, 6 ) == "custom" )
    {
        player.var_29d3d6d1ca17b761.loadoutindex = int( getsubstr( var_85573efda90ebf81, 6 ) );
    }
}

// Namespace br_analytics
// Params 4
// Checksum 0xcae60bf3, Offset: 0x6c20
// Size: 0x19d
function branalytics_dropbagdeployed( player, dropbagpos, dropbagspawntypeenum, crate )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    function_fee36b475ad2140( player );
    var_29d3d6d1ca17b761 = player.var_29d3d6d1ca17b761;
    player dlog_recordplayerevent( "dlog_event_br_dropbag_deployed", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "drop_x", dropbagpos[ 0 ], "drop_y", dropbagpos[ 1 ], "drop_z", dropbagpos[ 2 ], "spawn_type", dropbagspawntypeenum, "loadout_index", var_29d3d6d1ca17b761.loadoutindex, "loadout_is_default", var_29d3d6d1ca17b761.isdefaultloadout ] );
    _branalytics_addeventdelayed( "dropkit", dropbagpos, crate, 0 );
}

// Namespace br_analytics
// Params 3
// Checksum 0xd63eb25a, Offset: 0x6dc5
// Size: 0x1b5
function branalytics_dropbagused( player, dropbagpos, crate )
{
    if ( !branalytics_validation() || !isdefined( player ) )
    {
        return;
    }
    
    function_fee36b475ad2140( player );
    var_29d3d6d1ca17b761 = player.var_29d3d6d1ca17b761;
    var_26bd817d2c424707 = player getplayerunoid();
    player dlog_recordplayerevent( "dlog_event_br_dropbag_used", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "drop_x", dropbagpos[ 0 ], "drop_y", dropbagpos[ 1 ], "drop_z", dropbagpos[ 2 ], "loadout_index", var_29d3d6d1ca17b761.loadoutindex, "loadout_is_default", var_29d3d6d1ca17b761.isdefaultloadout, "loadout_uno_id", var_26bd817d2c424707 ] );
    
    if ( _branalytics_addeventallowed() )
    {
        branalytics_seteventdelayedstate( "dropkit", crate, 1 );
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0xcef8cd4d, Offset: 0x6f82
// Size: 0x74
function branalytics_dropbagdestroyed( team, dropbagpos )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_dropbag_destroyed", [ "drop_team", team ?? "none", "drop_x", dropbagpos[ 0 ], "drop_y", dropbagpos[ 1 ], "drop_z", dropbagpos[ 2 ] ] );
}

// Namespace br_analytics
// Params 1, eflags: 0x4
// Checksum 0xf13e0b32, Offset: 0x6ffe
// Size: 0x108
function private function_8f374dc9989d5f5d( params )
{
    dlog_recordevent( "dlog_event_br_circle_close_end", arraycombine( function_b10a6237441cd488(), [ "circle_index", params.circleindex ?? 0, "start_radius", float( params.initialradius ) ?? 0, "end_radius", float( params.targetradius ) ?? 0, "circle_center_x", params.centertarget[ 0 ] ?? 0, "circle_center_y", params.centertarget[ 1 ] ?? 0, "start_closing_time_ms", gettime() - ( int( params.closetime * 1000 ) ?? 0 ), "end_closing_time_ms", gettime() ?? 0 ] ) );
}

// Namespace br_analytics
// Params 2
// Checksum 0x4eb933b1, Offset: 0x710e
// Size: 0xf9
function branalytics_circleenter( player, time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_circle_enter", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "time_spent_outside", time ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x60f08b8, Offset: 0x720f
// Size: 0xf9
function branalytics_circleexit( player, time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_circle_exit", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "time_spent_inside", time ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0xa6e35b75, Offset: 0x7310
// Size: 0x31
function function_623b979c5cc36014( time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_multi_circle_start_split", [ "time_circle_start_split", time ] );
}

// Namespace br_analytics
// Params 3
// Checksum 0xdb02be39, Offset: 0x7349
// Size: 0x61
function function_6eabc85117589f13( time, playercounts, teamcounts )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_multi_circle_end_split", [ "time_circle_end_split", time, "circle_player_count", playercounts, "circle_team_count", teamcounts ] );
}

// Namespace br_analytics
// Params 3
// Checksum 0xc32a95d, Offset: 0x73b2
// Size: 0x61
function function_407c9211584f9690( time, playercounts, teamcounts )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_multi_circle_start_merge", [ "time_circle_start_merge", time, "circle_player_count", playercounts, "circle_team_count", teamcounts ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0x71d34c11, Offset: 0x741b
// Size: 0x31
function function_fe227f5efacf59f7( time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_multi_circle_end_merge", [ "time_circle_end_merge", time ] );
}

// Namespace br_analytics
// Params 4
// Checksum 0xa86340f7, Offset: 0x7454
// Size: 0x1a0
function branalytics_planepath( centerpt, yaw, startpt, endpt )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    level waittill( #"prematch_done" );
    dlog_recordevent( "dlog_event_br_plane_path", [ "center_x", centerpt[ 0 ], "center_y", centerpt[ 1 ], "center_z", centerpt[ 2 ], "yaw", yaw, "start_x", startpt[ 0 ], "start_y", startpt[ 1 ], "start_z", startpt[ 2 ], "end_x", endpt[ 0 ], "end_y", endpt[ 1 ], "end_z", endpt[ 2 ] ] );
    
    if ( _branalytics_addeventallowed() )
    {
        entity_index_plane = -2;
        timenow = _branalytics_geteventtimestamp();
        var_5a46ff94499abed = timenow + 35000;
        traveldist = distance( startpt, endpt );
        travelduration = traveldist / br_c130::getc130speed() * 1000;
        var_70a3dd0eaef9c051 = var_5a46ff94499abed;
        var_168f23cacaaebf70 = var_70a3dd0eaef9c051 + travelduration;
        function_974554b1c5fb54d7( "plane", startpt, 0, int( var_70a3dd0eaef9c051 ), "", entity_index_plane );
        function_974554b1c5fb54d7( "plane", endpt, 0, int( var_168f23cacaaebf70 ), "", entity_index_plane );
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0x38dfb5af, Offset: 0x75fc
// Size: 0x4d9
function branalytics_economy_snapshot( activeplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    teamtotals = [];
    totalplunder = 0;
    playermax = 0;
    playermin = 5000;
    teammax = 0;
    teammin = 5000;
    
    foreach ( player in activeplayers )
    {
        if ( !isdefined( teamtotals[ player.team ] ) )
        {
            teamtotals[ player.team ] = 0;
        }
        
        var_6355b03aa74e720b = player currency::get_currency_amount( "cash" );
        
        if ( isdefined( var_6355b03aa74e720b ) )
        {
            totalplunder += var_6355b03aa74e720b;
            teamtotals[ player.team ] += var_6355b03aa74e720b;
            
            if ( var_6355b03aa74e720b > playermax )
            {
                playermax = var_6355b03aa74e720b;
            }
            
            if ( var_6355b03aa74e720b < playermin )
            {
                playermin = var_6355b03aa74e720b;
            }
        }
        
        if ( teamtotals[ player.team ] > teammax )
        {
            teammax = teamtotals[ player.team ];
        }
        
        if ( teamtotals[ player.team ] < teammin )
        {
            teammin = teamtotals[ player.team ];
        }
    }
    
    player_avg = int( safedivide( totalplunder, activeplayers.size ) );
    team_avg = int( safedivide( totalplunder, teamtotals.size ) );
    dlog_recordevent( "dlog_event_br_plunder_economy_snapshot", [ "num_players_alive", function_1a8e73ed7b0a15a3( activeplayers.size ), "num_teams_alive", function_1a8e73ed7b0a15a3( teamtotals.size ), "total_plunder_held", function_71861a459758f554( totalplunder ), "top_player_plunder_held", function_717d9645974fe75a( playermax ), "top_team_total_plunder_held", function_717d9645974fe75a( teammax ), "avg_player_plunder_held", function_717d9645974fe75a( player_avg ), "avg_team_total_plunder_held", function_717d9645974fe75a( team_avg ), "min_player_plunder_held", function_57af40bc485a1869( playermin ), "min_team_total_plunder_held", function_57af40bc485a1869( teammin ), "plunder_items_picked_up", isdefined( level.br_plunder ) ? function_57af40bc485a1869( level.br_plunder.plunder_items_picked_up ) : 0, "plunder_value_picked_up", isdefined( level.br_plunder ) ? function_57a654bc485025b7( level.br_plunder.plunder_value_picked_up ) : 0, "plunder_items_dropped", isdefined( level.br_plunder ) ? function_57af40bc485a1869( level.br_plunder.plunder_items_dropped ) : 0, "plunder_value_dropped", isdefined( level.br_plunder ) ? function_57a654bc485025b7( level.br_plunder.plunder_value_dropped ) : 0, "plunder_awarded_by_missions_total", isdefined( level.br_plunder ) ? function_57a654bc485025b7( level.br_plunder.plunder_awarded_by_missions_total ) : 0, "kiosk_spent_total", isdefined( level.br_plunder ) ? function_1a8e73ed7b0a15a3( level.br_plunder.kiosk_spent_total ) : 0, "kiosk_num_purchases", isdefined( level.br_plunder ) ? function_1a8e73ed7b0a15a3( level.br_plunder.kiosk_num_purchases ) : 0, "extraction_balloon_total_value", isdefined( level.br_plunder ) ? function_57af40bc485a1869( level.br_plunder.extraction_balloon_total_plunder ) : 0, "extraction_balloon_total_extractions", isdefined( level.br_plunder ) ? function_1a8e73ed7b0a15a3( level.br_plunder.extraction_balloon_num_completed ) : 0, "extraction_helicoptor_total_value", isdefined( level.br_plunder ) ? function_717d9645974fe75a( level.br_plunder.extraction_helicoptor_total_plunder ) : 0, "extraction_helicoptor_total_extractions", isdefined( level.br_plunder ) ? function_1a8e73ed7b0a15a3( level.br_plunder.extraction_helicoptor_num_completed ) : 0 ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0x35b4be29, Offset: 0x7add
// Size: 0x104
function function_429a6779981d0c80( player )
{
    primaryweaponobj = player getcurrentweapon();
    secondaryweaponobj = undefined;
    var_cc1262e66dbb1c79 = undefined;
    
    if ( isdefined( player.primaryweaponobj ) && primaryweaponobj != player.primaryweaponobj )
    {
        secondaryweaponobj = player.primaryweaponobj;
    }
    else if ( isdefined( player.secondaryweaponobj ) && primaryweaponobj != player.secondaryweaponobj )
    {
        secondaryweaponobj = player.secondaryweaponobj;
    }
    
    if ( isdefined( player.var_cc1262e66dbb1c79 ) && primaryweaponobj != player.var_cc1262e66dbb1c79 && secondaryweaponobj != player.var_cc1262e66dbb1c79 )
    {
        var_cc1262e66dbb1c79 = player.var_cc1262e66dbb1c79;
    }
    
    return [ safecheckweapon( primaryweaponobj ), safecheckweapon( secondaryweaponobj ), primaryweaponobj, secondaryweaponobj, safecheckweapon( var_cc1262e66dbb1c79 ) ];
}

// Namespace br_analytics
// Params 2
// Checksum 0x52611956, Offset: 0x7bea
// Size: 0x940
function branalytics_inventory_snapshot( player, reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    [ var_8214b25e44cd7a83, var_9fb1a0187fb5a373, primaryweapon, secondaryweapon, var_7ae956e6ee2b1053 ] = function_429a6779981d0c80( player );
    perks = [ "specialty_null", "specialty_null", "specialty_null" ];
    
    for ( index = 0; index < 3 ; index++ )
    {
        if ( isdefined( player.classstruct ) && isdefined( player.classstruct.loadoutperks[ index ] ) )
        {
            perks[ index ] = player.classstruct.loadoutperks[ index ];
        }
    }
    
    var_70e20149af0856b3 = item_ammo::function_925e40db4bc1e2fe( player, "brloot_ammo_919" ) ?? player.ammostock[ "brloot_ammo_919" ];
    var_1e5164a194e9953 = item_ammo::function_925e40db4bc1e2fe( player, "brloot_ammo_762" ) ?? player.ammostock[ "brloot_ammo_762" ];
    var_e3e9a74a02f96dda = item_ammo::function_925e40db4bc1e2fe( player, "brloot_ammo_12g" ) ?? player.ammostock[ "brloot_ammo_12g" ];
    var_aff4cda76d191b1 = item_ammo::function_925e40db4bc1e2fe( player, "brloot_ammo_50cal" ) ?? player.ammostock[ "brloot_ammo_50cal" ];
    ammo_stock_rocket = item_ammo::function_925e40db4bc1e2fe( player, "brloot_ammo_rocket" ) ?? player.ammostock[ "brloot_ammo_rocket" ];
    
    if ( function_97de808fe549b3b7() )
    {
        player function_ad05aed95a44741e( 324711411383090888, [ 43:var_7ae956e6ee2b1053, 42:player.fieldguides ?? [], 41:function_719c164597711fbb( gettime() - level.starttime ), 40:safecheckstring( player killstreaks::getkillstreakinslot( 1 ).streakname ?? "none" ), 39:function_1a8e73ed7b0a15a3( secondaryweapon.var_e4de3f79b4ac164f ?? 0 ), 38:function_1a8e73ed7b0a15a3( primaryweapon.var_e4de3f79b4ac164f ?? 0 ), 37:function_717d9645974fe75a( secondaryweapon ? player getweaponammoclip( secondaryweapon ) : 0 ), 36:function_717d9645974fe75a( secondaryweapon ? weaponclipsize( secondaryweapon ) : 0 ), 35:function_717d9645974fe75a( primaryweapon ? player getweaponammoclip( primaryweapon ) : 0 ), 34:function_717d9645974fe75a( primaryweapon ? weaponclipsize( primaryweapon ) : 0 ), 33:function_717d9645974fe75a( player.health ), 32:function_1a8e73ed7b0a15a3( player utility::callsharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6" ).tier ?? 0 ), 31:function_1a8e73ed7b0a15a3( player armor::function_22290101992e4874() ), 30:function_717d9645974fe75a( player.armorhealth ), 29:player.lootperks ?? [], 28:player function_c939268adb80782c(), 27:perks[ 2 ], 26:perks[ 1 ], 25:"specialty_null", 24:perks[ 0 ], 23:function_1a8e73ed7b0a15a3( ammo_stock_rocket ), 22:function_717d9645974fe75a( var_aff4cda76d191b1 ), 21:function_717d9645974fe75a( var_e3e9a74a02f96dda ), 20:function_717d9645974fe75a( var_1e5164a194e9953 ), 19:function_717d9645974fe75a( var_70e20149af0856b3 ), 18:function_71861a459758f554( player.plunderbanked ), 17:function_71861a459758f554( player currency::get_currency_amount( "cash" ) ), 16:isdefined( player.gasmaskequipped ) && player.gasmaskequipped == 1, 15:safecheckstring( player supers_mp::getsuperref() ?? "none" ), 14:safecheckstring( player.equipment[ "secondary" ] ), 13:safecheckstring( player.equipment[ "primary" ] ), 12:var_9fb1a0187fb5a373, 11:var_8214b25e44cd7a83, 9:level.br_circle.circleindex ?? -1, 8:utility::getplayeryaw( player ), 7:utility::getplayerpitch( player ), 6:player.origin[ 2 ], 5:player.origin[ 1 ], 4:player.origin[ 0 ], 10:reason ] );
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_inventory_snapshot", [ "reason", reason, "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "primary_weapon", var_8214b25e44cd7a83, "secondary_weapon", var_9fb1a0187fb5a373, "primary_equipment", safecheckstring( player.equipment[ "primary" ] ), "secondary_equipment", safecheckstring( player.equipment[ "secondary" ] ), "field_equipment", safecheckstring( player supers_mp::getsuperref() ?? "none" ), "has_gasmask", isdefined( player.gasmaskequipped ) && player.gasmaskequipped == 1, "plunder_total", function_71861a459758f554( player currency::get_currency_amount( "cash" ) ), "plunder_banked", function_71861a459758f554( player.plunderbanked ), "ammo_smg", function_717d9645974fe75a( var_70e20149af0856b3 ), "ammo_ar_lmg", function_717d9645974fe75a( var_1e5164a194e9953 ), "ammo_shotgun", function_717d9645974fe75a( var_e3e9a74a02f96dda ), "ammo_sniper", function_717d9645974fe75a( var_aff4cda76d191b1 ), "ammo_rockets", function_1a8e73ed7b0a15a3( ammo_stock_rocket ), "base_perk_1", perks[ 0 ], "base_perk_2", "specialty_null", "bonus_perk", perks[ 1 ], "ultimate_perk", perks[ 2 ], "wildcard_perk", player function_c939268adb80782c(), "loot_perks", player.lootperks ?? [], "current_armor", function_717d9645974fe75a( player.armorhealth ), "carried_plates", function_1a8e73ed7b0a15a3( player armor::function_22290101992e4874() ), "armor_upgrade_level", function_1a8e73ed7b0a15a3( player utility::callsharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6" ).tier ?? 0 ), "current_hp", function_717d9645974fe75a( player.health ), "primary_weapon_clip_size", function_717d9645974fe75a( primaryweapon ? weaponclipsize( primaryweapon ) : 0 ), "primary_weapon_ammo", function_717d9645974fe75a( primaryweapon ? player getweaponammoclip( primaryweapon ) : 0 ), "secondary_weapon_clip_size", function_717d9645974fe75a( secondaryweapon ? weaponclipsize( secondaryweapon ) : 0 ), "secondary_weapon_ammo", function_717d9645974fe75a( secondaryweapon ? player getweaponammoclip( secondaryweapon ) : 0 ), "primary_weapon_rarity", function_1a8e73ed7b0a15a3( primaryweapon.var_e4de3f79b4ac164f ?? 0 ), "secondary_weapon_rarity", function_1a8e73ed7b0a15a3( secondaryweapon.var_e4de3f79b4ac164f ?? 0 ), "killstreak", safecheckstring( player killstreaks::getkillstreakinslot( 1 ).streakname ?? "none" ), "time_in_match", function_719c164597711fbb( gettime() - level.starttime ), "field_guides", player.fieldguides ?? [], "tertiary_weapon", var_7ae956e6ee2b1053 ] );
}

// Namespace br_analytics
// Params 0
// Checksum 0xc52f9bfc, Offset: 0x8532
// Size: 0x95
function function_c939268adb80782c()
{
    if ( self.loadoutperks )
    {
        foreach ( perk in self.loadoutperks )
        {
            if ( level.wildcardbundles[ perk ] )
            {
                return perk;
            }
        }
    }
    
    return "wildcard_none";
}

// Namespace br_analytics
// Params 4
// Checksum 0x862219ab, Offset: 0x85d0
// Size: 0x1ea
function function_a08ffb4d30d1778c( player, plunderspent, weaponref, attachmentrefs )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "plunder_spent", plunderspent, "player_plunder_after_purchase", player currency::get_currency_amount( "cash" ), "weapon", safecheckstring( weaponref ) ];
    assert( weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() ) <= 8 );
    assert( weapon::getmaxsecondaryattachments( player class::function_facf39de1a82731a() ) <= 8 );
    assert( attachmentrefs.size <= 8 );
    
    for ( var_2dccc883ad1859d7 = 0; var_2dccc883ad1859d7 < 8 ; var_2dccc883ad1859d7++ )
    {
        eventparams[ eventparams.size ] = function_5d044133536d0766( "", [ "weapon_attachment_", string( var_2dccc883ad1859d7 ) ] );
        
        if ( isdefined( attachmentrefs[ var_2dccc883ad1859d7 ] ) )
        {
            eventparams[ eventparams.size ] = safecheckstring( attachmentrefs[ var_2dccc883ad1859d7 ] );
            continue;
        }
        
        eventparams[ eventparams.size ] = "none";
    }
    
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_loadout_weapon", eventparams );
}

// Namespace br_analytics
// Params 3
// Checksum 0xa90468d7, Offset: 0x87c2
// Size: 0x208
function branalytics_kiosk_purchaseloadout( player, plunderspent, loadoutdata )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_loadout", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "plunder_spent", plunderspent, "player_plunder_after_purchase", player currency::get_currency_amount( "cash" ), "primary_weapon", safecheckstring( loadoutdata.loadoutprimaryfullname ), "secondary_weapon", safecheckstring( loadoutdata.loadoutsecondaryfullname ), "primary_equipment", safecheckstring( loadoutdata.loadoutequipmentprimary ), "secondary_equipment", safecheckstring( loadoutdata.loadoutequipmentsecondary ), "base_perk_1", safecheckstring( loadoutdata.loadoutperks[ 0 ] ), "base_perk_2", "specialty_null", "bonus_perk", safecheckstring( loadoutdata.loadoutperks[ 1 ] ), "ultimate_perk", safecheckstring( loadoutdata.loadoutperks[ 2 ] ) ] );
}

// Namespace br_analytics
// Params 5
// Checksum 0xbc7a325, Offset: 0x89d2
// Size: 0x17f
function branalytics_kiosk_purchaseitem( player, plunderspent, purchasetype, itemname, kiosktype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_item", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "plunder_spent", function_717d9645974fe75a( plunderspent ), "player_plunder_after_purchase", function_717d9645974fe75a( player currency::get_currency_amount( "cash" ) ), "purchase_type", purchasetype, "item_name", itemname, "kiosk_type", kiosktype ?? "standard_kiosk" ] );
    function_c0b2fd4f1305c12b( "purchase", player, plunderspent, itemname );
}

// Namespace br_analytics
// Params 4
// Checksum 0xc8e5ff7a, Offset: 0x8b59
// Size: 0x1e8
function branalytics_kiosk_menu_event( player, menuevent, menueventparam, kiosktype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_kiosk_menu_event", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "kiosk_menu_owner_event", menuevent, "kiosk_menu_owner_event_param", menueventparam ?? "none", "kiosk_menu_owner_event_time", gettime() - level.starttime, "kiosk_menu_owner_kiosk", isdefined( player.br_kiosk ) ? player.br_kiosk.index : -1, "kiosk_menu_owner_allowed", istrue( player.armorykioskpurchaseallowed ), "kiosk_menu_owner_error", menuevent != "menu_close" && !isdefined( player.br_kiosk ) && !istrue( level.var_e298f874f79103ed ) ? "unexpected_undefined_kiosk" : "none", "kiosk_type", kiosktype ?? "standard_kiosk" ] );
}

// Namespace br_analytics
// Params 4
// Checksum 0x9aadd0f9, Offset: 0x8d49
// Size: 0x8f
function branalytics_plunder_placed_into_extraction( player, method, location, plunder_amount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_plunder_placed_into_extraction", [ "extraction_method", method, "plunder_placed_into_extraction", plunder_amount, "extraction_point_x", location[ 0 ], "extraction_point_y", location[ 1 ], "extraction_point_z", location[ 2 ] ] );
}

// Namespace br_analytics
// Params 5
// Checksum 0x29f9c3a3, Offset: 0x8de0
// Size: 0xb4
function branalytics_plunder_extraction_success( num_depositers, plunder_amount, method, contains_enemy_plunder, extraction_origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_plunder_extraction_success", [ "num_depositers", num_depositers, "plunder_extracted", plunder_amount, "method", method, "contains_enemy_plunder", contains_enemy_plunder, "extraction_origin_x", extraction_origin[ 0 ], "extraction_origin_y", extraction_origin[ 1 ], "extraction_origin_z", extraction_origin[ 2 ] ] );
}

// Namespace br_analytics
// Params 4
// Checksum 0x5140c95f, Offset: 0x8e9c
// Size: 0xbf
function branalytics_plunder_extraction_failure( plunder_dropped, method, extraction_origin, destruction_origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_plunder_extraction_failure", [ "plunder_dropped", plunder_dropped, "method", method, "extraction_origin_x", extraction_origin[ 0 ], "extraction_origin_y", extraction_origin[ 1 ], "extraction_origin_z", extraction_origin[ 2 ], "destruction_origin_x", destruction_origin[ 0 ], "destruction_origin_y", destruction_origin[ 1 ], "destruction_origin_z", destruction_origin[ 2 ] ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x6a850741, Offset: 0x8f63
// Size: 0x70
function branalytics_bonusxp_debugdata( xp, reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        xuid = self getxuid() + " " + reason;
    }
    else
    {
        xuid = "none " + reason;
    }
    
    xp = int( xp );
    _branalytics_addevent( "bonusXpDebug", ( 0, 0, 0 ), xp, xuid );
}

// Namespace br_analytics
// Params 2
// Checksum 0x23833c58, Offset: 0x8fdb
// Size: 0x5a
function branalytics_vehiclespawned( vehicle, refname )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( _branalytics_addeventallowed() && isdefined( level.prematchendtime ) )
    {
        _branalytics_addeventdelayed( "vehicle", vehicle.origin, vehicle, refname );
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0xd89a36db, Offset: 0x903d
// Size: 0x1ae
function function_ba7e47ee7f1974ec( player, teamdatas )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    successcounts = [];
    failcounts = [];
    minsucceeded = undefined;
    maxsucceeded = 0;
    minfailed = undefined;
    maxfailed = 0;
    
    foreach ( teamdata in teamdatas )
    {
        successcount = teamdata.successcount;
        successcounts[ successcounts.size ] = successcount;
        minsucceeded = isdefined( minsucceeded ) ? min( minsucceeded, successcount ) : successcount;
        maxsucceeded = max( maxsucceeded, successcount );
        failcount = teamdata.failcount;
        failcounts[ failcounts.size ] = failcount;
        minfailed = isdefined( minfailed ) ? min( minfailed, failcount ) : failcount;
        maxfailed = max( maxfailed, failcount );
    }
    
    dlog_recordevent( "dlog_event_br_bounty_royal_completed", [ "average_bounty_succeeded", utility::array_average( successcounts ), "max_bounty_succeeded", maxsucceeded, "min_bounty_succeeded", minsucceeded, "average_bounty_failed", utility::array_average( failcounts ), "max_bounty_failed", maxfailed, "min_bounty_failed", minfailed ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x1b2dbb79, Offset: 0x91f3
// Size: 0x111
function function_d35a53c77fb9ea2d( player, var_77ae4bc307b47e36 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    var_fa94b25ca4c43790 = istrue( var_77ae4bc307b47e36.var_fa94b25ca4c43790 );
    player dlog_recordplayerevent( "dlog_event_br_redeploy_drone_used", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "deployed_from_beacon", var_fa94b25ca4c43790 ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0x2210cbe2, Offset: 0x930c
// Size: 0xa2
function function_fef6725d302a8146( params )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_redeploy_drone_destroyed", [ "pos_x", params.pos[ 0 ], "pos_y", params.pos[ 1 ], "pos_z", params.pos[ 2 ], "circle_index", params.circle_index, "was_relocating", params.was_relocating ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0xde42516f, Offset: 0x93b6
// Size: 0x52
function function_57c1853cf6070a76( candeploy )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_beacon_used", [ "beacon_can_deploy", candeploy, "total_beacon_deployed", level.var_84113f58ceb29def.var_99940544898cd60a.size ] );
}

// Namespace br_analytics
// Params 0
// Checksum 0xf7564b2b, Offset: 0x9410
// Size: 0x39
function function_9f3cb493eb7c33ee()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_beacon_destroyed", [ "total_beacon_deployed", level.var_84113f58ceb29def.var_99940544898cd60a.size ] );
}

// Namespace br_analytics
// Params 4
// Checksum 0xe07f8806, Offset: 0x9451
// Size: 0x79
function branalytics_inittablets( num_missions, num_missions_active, num_missions_hidden, hide_percent )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_init", [ "num_missions", num_missions, "num_missions_active", num_missions_active, "num_missions_hidden", num_missions_hidden, "hide_percent", hide_percent ] );
}

// Namespace br_analytics
// Params 4
// Checksum 0x44dcb3c4, Offset: 0x94d2
// Size: 0x79
function branalytics_delayedshowtablets( circle_index, show_percent, num_valid, num_shown )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_repopulate", [ "circle_index", circle_index, "show_percent", show_percent, "num_valid", num_valid, "num_shown", num_shown ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0x73ee3e72, Offset: 0x9553
// Size: 0x107
function branalytics_spawntablet( tablet )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_spawn", [ "id", isdefined( tablet.index ) ? string( tablet.index ) : "invalid", "type", tablet.type, "origin_x", tablet.origin[ 0 ], "origin_y", tablet.origin[ 1 ], "origin_z", tablet.origin[ 2 ] ] );
    
    if ( _branalytics_addeventallowed() && isdefined( tablet.index ) )
    {
        _branalytics_addeventdelayed( "mission", tablet.origin, string( tablet.index ), tablet.tablettype );
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0x4bcdd248, Offset: 0x9662
// Size: 0xbd
function branalytics_invalidtablet( tablet )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_invalid", [ "id", isdefined( tablet.index ) ? string( tablet.index ) : "invalid", "type", tablet.type, "origin_x", tablet.origin[ 0 ], "origin_y", tablet.origin[ 1 ], "origin_z", tablet.origin[ 2 ] ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x64b677, Offset: 0x9727
// Size: 0x184
function branalytics_missionstart( missioninstance, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    teammates = teams::getfriendlyplayers( player.team, 1 );
    eventparams = _branalytics_headerplayerposrow( eventparams, teammates );
    eventparams[ eventparams.size ] = "id";
    eventparams[ eventparams.size ] = isdefined( missioninstance.tablet ) && isdefined( missioninstance.tablet.index ) ? string( missioninstance.tablet.index ) : "invalid";
    circleindex = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "type";
    eventparams[ eventparams.size ] = missioninstance.type.ref;
    eventparams[ eventparams.size ] = "is_legendary";
    eventparams[ eventparams.size ] = istrue( self.islegendarycontract );
    eventparams[ eventparams.size ] = "distance";
    eventparams[ eventparams.size ] = missioninstance.distance ?? 0;
    player dlog_recordplayerevent( "dlog_event_br_mission_start", eventparams );
    
    if ( _branalytics_addeventallowed() && isdefined( missioninstance.missionid ) )
    {
        branalytics_seteventdelayedstate( "mission", missioninstance.missionid, -1 );
    }
}

// Namespace br_analytics
// Params 4
// Checksum 0xb6b23331, Offset: 0x98b3
// Size: 0x19a
function branalytics_missionend( missioninstance, questtier, rewards, numteamplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_end", [ "id", missioninstance.missionid ?? "invalid", "result", missioninstance.result ?? "unknown", "reward_tier", questtier, "xp", rewards[ "xp" ] ?? 0, "weapon_xp", rewards[ "weapon_xp" ] ?? 0, "plunder", rewards[ "plunder" ] ?? 0, "num_teammates_awarded", numteamplayers ?? 0, "type", missioninstance.questcategory, "end_state", missioninstance.endstate ?? "invalid", "is_legendary", istrue( missioninstance.islegendarycontract ) ] );
    
    if ( _branalytics_addeventallowed() && isdefined( missioninstance.missionid ) )
    {
        if ( missioninstance.result == "success" )
        {
            branalytics_seteventdelayedstate( "mission", missioninstance.missionid, questtier );
            return;
        }
        
        branalytics_seteventdelayedstate( "mission", missioninstance.missionid, -1 );
    }
}

// Namespace br_analytics
// Params 3
// Checksum 0x8dfc26f4, Offset: 0x9a55
// Size: 0x240
function function_3330dd50820900c9( teaminfo, endreason, success )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    teammates = teams::getfriendlyplayers( teaminfo.targetteam, 0 );
    eventparams = [ "end_reason", endreason, "state_progress", istrue( success ) ? 5 : teaminfo.state, "collected_beryllium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "ber", 6 ) ) ), "collected_plutonium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "plu", 6 ) ) ), "collected_tritium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "tri", 6 ) ) ), "collected_gallium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "gal", 6 ) ) ), "collected_deuterium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "deu", 6 ) ) ), "collected_neptunium", istrue( teaminfo.var_7c14906613fde75c & br_elite_broken_arrow::function_18ff21e51998d8e6( br_elite_broken_arrow::function_ca621b047cf24253( "nep", 6 ) ) ), "num_teammates", teammates.size ];
    
    foreach ( player in teammates )
    {
        player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_end", eventparams );
    }
    
    successstate = istrue( success );
    _branalytics_addevent( "elite_broken_arrow_end", ( 0, 0, 0 ), successstate, endreason );
}

// Namespace br_analytics
// Params 2
// Checksum 0x5dd43c3b, Offset: 0x9c9d
// Size: 0x57
function function_66d8c82e5bfe396a( player, timeleft )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_defuse", [ "time_until_detonation", timeleft ] );
    _branalytics_addevent( "elite_broken_arrow_defuse", player getorigin(), timeleft, "time_until_detonation", player );
}

// Namespace br_analytics
// Params 2
// Checksum 0x80690252, Offset: 0x9cfc
// Size: 0x8c
function function_3616e4c972df7830( player, element )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_element_collect", [ "element_id", element.elementid, "time_from_spawn", gettime() - element.spawntime ] );
    _branalytics_addevent( "elite_broken_arrow_element_collect", player getorigin(), element.spawntime, element.elementid, player );
}

// Namespace br_analytics
// Params 2
// Checksum 0x329842dc, Offset: 0x9d90
// Size: 0x57
function function_3976c233fa7afe0e( player, var_b19dbcb3a572fd87 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_arm", [ "time_from_bombsite_spawn", var_b19dbcb3a572fd87 ] );
    _branalytics_addevent( "elite_broken_arrow_arm", player getorigin(), var_b19dbcb3a572fd87, "time_from_bombsite_spawn", player );
}

// Namespace br_analytics
// Params 3
// Checksum 0x546aeffa, Offset: 0x9def
// Size: 0x61
function function_2a3fd8c91d8471a8( playercount, cancelreason, var_e9b42ab7cb9dbdf6 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_elite_broken_arrow_match_invalid", [ "player_count", playercount, "cancel_reason", cancelreason, "player_disconnect_count", var_e9b42ab7cb9dbdf6 ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x46e63e0c, Offset: 0x9e58
// Size: 0x2f
function function_c4f1bc2567d5da00( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "initialize_fortress_kiosk", origin, state );
}

// Namespace br_analytics
// Params 3
// Checksum 0xb1f50711, Offset: 0x9e8f
// Size: 0x3b
function function_652e081ac81413f2( origin, data, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "kiosk_unusable_for_player", origin, 0, data, player );
}

// Namespace br_analytics
// Params 2
// Checksum 0x967de316, Offset: 0x9ed2
// Size: 0x2f
function function_50a1cbe375b7af1e( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "remove_kiosk", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x6056c91f, Offset: 0x9f09
// Size: 0x2f
function function_8388da16c0a648f3( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_rejected", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x756da922, Offset: 0x9f40
// Size: 0x2f
function function_7921776b3ede8652( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_blacksite", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x7380ba68, Offset: 0x9f77
// Size: 0x2f
function function_260394e330e2b430( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_fortress", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x74f6fbce, Offset: 0x9fae
// Size: 0x2f
function function_bedff60ccc7001ef( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_all_blacksite_doors", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x9de63844, Offset: 0x9fe5
// Size: 0x2f
function function_66135999ffc34351( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_all_fortress_interior_doors", origin, state );
}

// Namespace br_analytics
// Params 2
// Checksum 0x84d99e93, Offset: 0xa01c
// Size: 0x31
function branalytics_spawnboss( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_boss", origin, 0, data );
}

// Namespace br_analytics
// Params 1
// Checksum 0xe54fa62c, Offset: 0xa055
// Size: 0x25
function function_bcdbb0a74b3dd7cf( origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_first_blacksite_door", origin );
}

// Namespace br_analytics
// Params 1
// Checksum 0xd0c2bd9, Offset: 0xa082
// Size: 0x25
function function_53d2b9e1defc9123( origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "stronghold_captured", origin );
}

// Namespace br_analytics
// Params 2
// Checksum 0x457757b, Offset: 0xa0af
// Size: 0x31
function function_32a5495e17a9e823( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_loot_zone", origin, 0, data );
}

// Namespace br_analytics
// Params 2
// Checksum 0x5bae8772, Offset: 0xa0e8
// Size: 0x31
function function_7cef8d7c6fb93cba( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_undefined_zonebounds", origin, 0, data );
}

// Namespace br_analytics
// Params 2
// Checksum 0x442f0139, Offset: 0xa121
// Size: 0x31
function function_175ef6ef4a73e9b3( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_mismatched_zonebounds", origin, 0, data );
}

// Namespace br_analytics
// Params 3
// Checksum 0xce24d378, Offset: 0xa15a
// Size: 0x3f
function branalytics_interrogation( interrogator, state, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "interrogation", interrogator getorigin(), state, data, interrogator );
}

// Namespace br_analytics
// Params 2
// Checksum 0x4dd3d7a6, Offset: 0xa1a1
// Size: 0x3b
function function_d80c1d3823c08ce2( victim, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "interrogation_victim", victim getorigin(), state, "", victim );
}

// Namespace br_analytics
// Params 2
// Checksum 0xfaef50b5, Offset: 0xa1e4
// Size: 0x10c
function branalytics_teameliminated( team, teamplacement )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( isdefined( player ) )
        {
            player.pers[ "telemetry" ].is_early_disconnect = 0;
        }
    }
    
    dlog_recordevent( "dlog_event_br_team_eliminated", [ "team", team, "placement", teamplacement, "survival_time", isdefined( level.starttime ) ? gettime() - level.starttime : 0 ] );
}

// Namespace br_analytics
// Params 6
// Checksum 0xa525de5c, Offset: 0xa2f8
// Size: 0x70
function branalytics_xpearned( playerxp, weaponxp, lifeindex, weaponname, player, type )
{
    var_84040f8cfc0db71d = "xp_event";
    
    /#
        var_84040f8cfc0db71d = var_84040f8cfc0db71d + "<dev string:x2d>" + getxhashsourcename( type );
    #/
    
    _branalytics_addevent( var_84040f8cfc0db71d, ( playerxp, weaponxp, 0 ), lifeindex, weaponname, player );
}

// Namespace br_analytics
// Params 1
// Checksum 0x58a561dc, Offset: 0xa370
// Size: 0x41
function branalytics_publiceventstarted( eventtype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( !isdefined( eventtype ) )
    {
        eventtype = %"unknown";
    }
    
    dlog_recordevent( "dlog_event_br_public_event_start", [ "type", eventtype ] );
}

// Namespace br_analytics
// Params 1
// Checksum 0xe7def164, Offset: 0xa3b9
// Size: 0x41
function branalytics_publiceventended( eventtype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( !isdefined( eventtype ) )
    {
        eventtype = %"unknown";
    }
    
    dlog_recordevent( "dlog_event_br_public_event_end", [ "type", eventtype ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x51d9b2fe, Offset: 0xa402
// Size: 0x1de
function _branalytics_headerplayerposrow( params, players )
{
    assert( isarray( params ) );
    
    foreach ( player in players )
    {
        params[ params.size ] = "living_player_pos";
        rowparams = [];
        assert( isdefined( player.origin ) && isfloat( player.origin[ 0 ] ) );
        assert( isdefined( player.origin ) && isfloat( player.origin[ 1 ] ) );
        assert( isdefined( player.origin ) && isfloat( player.origin[ 2 ] ) );
        assert( isfloat( utility::getplayerpitch( player ) ) );
        assert( isfloat( utility::getplayeryaw( player ) ) );
        rowparams[ rowparams.size ] = "x";
        rowparams[ rowparams.size ] = player.origin[ 0 ];
        rowparams[ rowparams.size ] = "y";
        rowparams[ rowparams.size ] = player.origin[ 1 ];
        rowparams[ rowparams.size ] = "z";
        rowparams[ rowparams.size ] = player.origin[ 2 ];
        rowparams[ rowparams.size ] = "pitch";
        rowparams[ rowparams.size ] = utility::getplayerpitch( player );
        rowparams[ rowparams.size ] = "yaw";
        rowparams[ rowparams.size ] = utility::getplayeryaw( player );
        params[ params.size ] = rowparams;
    }
    
    return params;
}

// Namespace br_analytics
// Params 1
// Checksum 0xdf432654, Offset: 0xa5e9
// Size: 0x28
function safecheckstring( data )
{
    var_7237854e3be197ca = data;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "empty";
}

// Namespace br_analytics
// Params 1
// Checksum 0xb770cd2e, Offset: 0xa61a
// Size: 0x27
function safecheckweapon( data )
{
    if ( isdefined( data ) )
    {
        return data.basename;
    }
    
    return "empty";
}

// Namespace br_analytics
// Params 3
// Checksum 0x225d6670, Offset: 0xa649
// Size: 0x40
function function_8d88e238cdf5eb3d( data, datamin, datamax )
{
    if ( isdefined( datamin ) )
    {
        if ( data < datamin )
        {
            return datamin;
        }
    }
    
    if ( isdefined( datamax ) )
    {
        if ( data > datamax )
        {
            return datamax;
        }
    }
    
    return data;
}

// Namespace br_analytics
// Params 1
// Checksum 0xde6c6dbb, Offset: 0xa692
// Size: 0x3b
function function_d49250ccf3da062a( data )
{
    if ( isnumber( data ) )
    {
        data_min = -128;
        data_max = 127;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0x40ece12, Offset: 0xa6d6
// Size: 0x3d
function function_57af40bc485a1869( data )
{
    if ( isnumber( data ) )
    {
        data_min = -32768;
        data_max = 32767;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0xb15568b2, Offset: 0xa71c
// Size: 0x3d
function function_57a654bc485025b7( data )
{
    if ( isnumber( data ) )
    {
        data_min = undefined;
        data_max = 2147483647;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0x22ec119c, Offset: 0xa762
// Size: 0x19
function function_57903cbc4837bdbc( data )
{
    if ( isnumber( data ) )
    {
        return data;
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0xb831c3c9, Offset: 0xa784
// Size: 0x3a
function function_1a8e73ed7b0a15a3( data )
{
    if ( isnumber( data ) )
    {
        data_min = 0;
        data_max = 255;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0x45637c53, Offset: 0xa7c7
// Size: 0x3b
function function_717d9645974fe75a( data )
{
    if ( isnumber( data ) )
    {
        data_min = 0;
        data_max = 65535;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0x8fc7dac8, Offset: 0xa80b
// Size: 0x3d
function function_71861a459758f554( data )
{
    if ( isnumber( data ) )
    {
        data_min = 0;
        data_max = 4294967295;
        return function_8d88e238cdf5eb3d( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics
// Params 1
// Checksum 0x9c7ea3dd, Offset: 0xa851
// Size: 0x19
function function_719c164597711fbb( data )
{
    if ( isnumber( data ) )
    {
        return data;
    }
    
    return 0;
}

// Namespace br_analytics
// Params 2
// Checksum 0xb5ae09da, Offset: 0xa873
// Size: 0x32
function safedivide( data, divisor )
{
    if ( !isdefined( divisor ) || divisor <= 0 )
    {
        return ( data / 1 );
    }
    
    return data / divisor;
}

// Namespace br_analytics
// Params 0
// Checksum 0xd878bff8, Offset: 0xa8ad
// Size: 0x2f1
function branalytics_endgame()
{
    if ( _branalytics_addeventallowed() )
    {
        if ( isdefined( level.delayedeventtypes[ "vehicle" ] ) )
        {
            foreach ( evt in level.delayedeventtypes[ "vehicle" ] )
            {
                if ( !isdefined( evt.ent ) )
                {
                    evt.state = 1;
                    continue;
                }
                
                if ( distancesquared( evt.origin, evt.ent.origin ) > squared( 1000 ) )
                {
                    evt.state = 1;
                }
            }
        }
        
        if ( isdefined( level.common_armory_kiosk ) )
        {
            foreach ( kiosk in level.common_armory_kiosk.instances )
            {
                state = 0;
                
                if ( kiosk.visible )
                {
                    state = 1;
                }
                
                time = 0;
                entnum = -1;
                function_974554b1c5fb54d7( "kiosk", kiosk.origin, state, time, "", entnum );
            }
        }
        
        foreach ( typearray in level.delayedeventtypes )
        {
            foreach ( ev in typearray )
            {
                if ( isdefined( ev ) )
                {
                    function_974554b1c5fb54d7( ev.type, ev.origin, ev.state, ev.time, ev.data, -1 );
                }
            }
        }
    }
    
    if ( true )
    {
        analyticswritecsv();
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0x86c447a7, Offset: 0xaba6
// Size: 0x38, Type: bool
function function_a4982eae6367a9ce()
{
    if ( !isdefined( level.prematchendtime ) )
    {
        return false;
    }
    
    if ( !level.var_e83383d9616d93e3 )
    {
        return false;
    }
    
    if ( isplayer( self ) )
    {
        return true;
    }
    
    if ( isagent( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_analytics
// Params 0
// Checksum 0xba1c222b, Offset: 0xabe7
// Size: 0x196
function function_d023e0f6a0dda7fa()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_28ba7dc909d6dc03" );
    entnum = self getentitynumber();
    state = 0;
    data = "";
    nextstate = 0;
    nextdata = "";
    
    while ( true )
    {
        wait 30;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( self.gulag == 1 )
        {
            continue;
        }
        
        if ( isagent( self ) )
        {
            if ( isdefined( self.enemy ) )
            {
                nextstate = self.enemy getentitynumber();
            }
            else
            {
                nextstate = 0;
            }
            
            if ( isdefined( self.behaviorpackage ) )
            {
                nextdata = self.behaviorpackage.behavior;
            }
            else
            {
                nextdata = "";
            }
        }
        else if ( isplayer( self ) )
        {
            var_6355b03aa74e720b = currency::get_currency_amount( "cash" );
            
            if ( isdefined( var_6355b03aa74e720b ) )
            {
                nextstate = int( var_6355b03aa74e720b );
            }
            
            if ( isdefined( self.team ) )
            {
                nextdata = self.team;
            }
        }
        
        time = _branalytics_geteventtimestamp();
        
        if ( self.var_20e64768236c78cf < time - 30 || state != nextstate || data != nextdata )
        {
            self.var_20e64768236c78cf = time;
            state = nextstate;
            data = nextdata;
            function_974554b1c5fb54d7( "breadcrumb", self.origin, state, time, data, entnum );
        }
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0x6310f6c0, Offset: 0xad85
// Size: 0x45
function function_b0da78f7298f9896( time )
{
    if ( !function_a4982eae6367a9ce() )
    {
        return;
    }
    
    if ( !isdefined( self.var_20e64768236c78cf ) )
    {
        self.var_20e64768236c78cf = time;
        thread function_d023e0f6a0dda7fa();
        return;
    }
    
    self.var_20e64768236c78cf = time;
}

// Namespace br_analytics
// Params 2
// Checksum 0xc0267f59, Offset: 0xadd2
// Size: 0x26
function function_23f12d9752a5ffac( origin, data )
{
    _branalytics_addevent( "agent_alloc", origin, 0, data );
}

// Namespace br_analytics
// Params 1
// Checksum 0x82de30ef, Offset: 0xae00
// Size: 0x5e
function function_678567c990494032( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    state = 0;
    
    if ( ent.category == "gulag" )
    {
        state = 1;
    }
    
    data = ent.agent_type;
    function_c0b2fd4f1305c12b( "agent_spawn", ent, state, data );
}

// Namespace br_analytics
// Params 3
// Checksum 0xd54c93ac, Offset: 0xae66
// Size: 0xe4
function function_4abae0b31fa92566( ent, madedormant, attacker )
{
    if ( !isdefined( ent ) || !_branalytics_addeventallowed() )
    {
        return;
    }
    
    ent notify( #"hash_28ba7dc909d6dc03" );
    
    if ( madedormant )
    {
        attacker_weapon_name = "dormancy";
    }
    else if ( analytics::function_7dd239dfcb717b4b( attacker ) )
    {
        attacker_weapon_name = "world";
    }
    else
    {
        attacker_weapon = attacker getcurrentweapon();
        attacker_weapon_name = attacker_weapon.basename;
    }
    
    state = 0;
    
    if ( madedormant == 1 )
    {
        state = 1;
    }
    
    if ( isdefined( level.var_9a94340e3eb50374 ) && attacker_weapon_name != "world" && attacker_weapon_name != "dormancy" )
    {
        [[ level.var_9a94340e3eb50374 ]]( ent, attacker );
    }
    
    function_c0b2fd4f1305c12b( "agent_down", ent, state, attacker_weapon_name );
}

// Namespace br_analytics
// Params 2
// Checksum 0x8174fc0f, Offset: 0xaf52
// Size: 0x24
function function_5165f197e4a55ae4( origin, state )
{
    _branalytics_addevent( "stronghold_spawn", origin, state );
}

// Namespace br_analytics
// Params 1
// Checksum 0x49817780, Offset: 0xaf7e
// Size: 0x1a
function function_a58367d0a8c05a55( origin )
{
    _branalytics_addevent( "stronghold_despawn", origin );
}

// Namespace br_analytics
// Params 0
// Checksum 0x971761c2, Offset: 0xafa0
// Size: 0xb9
function function_6286c7f79415f1c8()
{
    if ( !getdvarint( @"hash_ec7375cc2a0ca633", 1 ) )
    {
        return;
    }
    
    level.var_576d9250466b546b = [];
    utility::registersharedfunc( #"gametype", #"onpickuptakenintobackpack", &function_4cb6421bf76003cd, 1 );
    level.var_9d2627a322ae8721 = &function_fdb9f50e15f0d08f;
    level.var_d07dd9893f7e474b = &function_87eb4e9014542156;
    level.var_727e58e87af99543 = &function_8514df40da031480;
    level.var_9a94340e3eb50374 = &function_6fa98f82a45739c9;
    level.var_18646a2f90081429 = &function_fe6dce8acdec34cd;
    level.var_1a46609d8b9f696 = &function_1cf6aeee5404790;
    
    if ( team_assimilation::function_8fe74e094005f15d() )
    {
        callback::add( #"player_assimilated", &function_f2c0f79c7ba93d09 );
    }
    
    thread function_6e585b68b8bb8ea3();
}

// Namespace br_analytics
// Params 0
// Checksum 0xea1222e5, Offset: 0xb061
// Size: 0xab
function function_6e585b68b8bb8ea3()
{
    level waittill( #"game_ended" );
    
    if ( level.fortressstruct.chosenfortresses.size > 0 )
    {
        foreach ( fortress in level.fortressstruct.chosenfortresses )
        {
            fortress function_2295232c222ad384();
        }
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0x82cc8bbd, Offset: 0xb114
// Size: 0x279
function function_fe6dce8acdec34cd( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( self.fortress ) )
    {
        return;
    }
    
    if ( !player function_1375c93b66042067( self.fortress ) )
    {
        return;
    }
    
    if ( isdefined( player.var_c33218f153f0feff ) && isdefined( player.var_c33218f153f0feff.fortress ) )
    {
        if ( player.var_c33218f153f0feff.fortress == self.fortress )
        {
            if ( player.var_c33218f153f0feff.timeoutpending )
            {
                player.var_c33218f153f0feff.timeoutpending = 0;
            }
            
            return;
        }
        else
        {
            proxtrigger = player.var_c33218f153f0feff.fortress.proximitytrigger;
            
            if ( isdefined( proxtrigger ) )
            {
                closervolume = function_e43a378ac090e68e( player, self, proxtrigger );
                
                if ( closervolume != self )
                {
                    return;
                }
            }
        }
    }
    else
    {
        closeststronghold = undefined;
        var_5d72f7202b98e3b7 = undefined;
        
        foreach ( sh in level.fortressstruct.chosenfortresses )
        {
            if ( !isdefined( sh ) || !player function_1375c93b66042067( sh ) )
            {
                continue;
            }
            
            dist = undefined;
            
            if ( isdefined( sh.missiontrigger ) && isdefined( sh.missiontrigger.origin ) )
            {
                dist = function_6a7a8cd990ce0aa0( player, sh.missiontrigger );
            }
            else if ( isdefined( sh.proximitytrigger ) && isdefined( sh.proximitytrigger.origin ) )
            {
                dist = function_6a7a8cd990ce0aa0( player, sh.proximitytrigger );
            }
            
            if ( isdefined( dist ) && ( !isdefined( closeststronghold ) || dist < var_5d72f7202b98e3b7 ) )
            {
                closeststronghold = sh;
                var_5d72f7202b98e3b7 = dist;
            }
        }
        
        if ( isdefined( closeststronghold ) )
        {
            player function_f7775bab6fc71d7a( closeststronghold );
        }
        
        return;
    }
    
    player function_f7775bab6fc71d7a( self.fortress );
}

// Namespace br_analytics
// Params 2, eflags: 0x4
// Checksum 0x4d65b4bf, Offset: 0xb395
// Size: 0xff
function private function_f7775bab6fc71d7a( fortress, timestamp )
{
    if ( isdefined( self.completedstrongholds ) && arraycontains( self.completedstrongholds, fortress ) )
    {
        return;
    }
    
    if ( isdefined( self.var_c33218f153f0feff ) && isdefined( self.var_c33218f153f0feff.fortress ) )
    {
        if ( self.var_c33218f153f0feff.fortress == fortress )
        {
            if ( self.var_c33218f153f0feff.timeoutpending )
            {
                self.var_c33218f153f0feff.timeoutpending = 0;
            }
            
            return;
        }
        else
        {
            function_ea440c271eefc5c9( "entered_different_stronghold", 0 );
        }
    }
    
    self.var_c33218f153f0feff = spawnstruct();
    self.var_c33218f153f0feff.fortress = fortress;
    self.var_c33218f153f0feff.var_d7b6acb38b6fbc0c = 1;
    
    if ( !isdefined( timestamp ) )
    {
        timestamp = gettime();
    }
    
    fortress function_547722ef173afbbd( self, timestamp );
}

// Namespace br_analytics
// Params 3, eflags: 0x4
// Checksum 0xee6c02e4, Offset: 0xb49c
// Size: 0xdf
function private function_ea440c271eefc5c9( reason, success, timestamp )
{
    if ( !( isdefined( self.var_c33218f153f0feff ) && isdefined( self.var_c33218f153f0feff.fortress ) ) )
    {
        return;
    }
    
    fortress = self.var_c33218f153f0feff.fortress;
    
    if ( self.var_c33218f153f0feff.timeoutpending )
    {
        self.var_c33218f153f0feff.timeoutpending = 0;
    }
    
    fortress function_da11fb82e02a1ca0( self, reason, success, timestamp );
    self.var_c33218f153f0feff = undefined;
    
    if ( fortress.teamattempts[ self.team ].activeplayers.size <= 0 )
    {
        fortress function_f33ab5fd3c041336( self.team, success );
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0xccab7d29, Offset: 0xb583
// Size: 0x5e, Type: bool
function function_1375c93b66042067( fortress )
{
    if ( !br_strongholds::brstronghold_isactive() )
    {
        return false;
    }
    
    if ( fortress.capturedteam == self.team )
    {
        return false;
    }
    
    if ( fortress.isblacksite )
    {
        return ( fortress.unlocked && !fortress.captured );
    }
    
    return true;
}

// Namespace br_analytics
// Params 3
// Checksum 0x1544e81b, Offset: 0xb5ea
// Size: 0xf6
function function_e43a378ac090e68e( player, volume1, volume2 )
{
    assert( isdefined( player ) );
    
    if ( !isdefined( volume1 ) )
    {
        return volume2;
    }
    else if ( !isdefined( volume2 ) )
    {
        return volume1;
    }
    
    var_3b440f5db06c7fc1 = ispointinvolume( player.origin, volume1 );
    var_3b440c5db06c7928 = ispointinvolume( player.origin, volume2 );
    
    if ( !var_3b440f5db06c7fc1 )
    {
        if ( !var_3b440c5db06c7928 )
        {
            return;
        }
        else
        {
            return volume2;
        }
    }
    else if ( !var_3b440c5db06c7928 )
    {
        return volume1;
    }
    
    var_f8f9b0ccf16ad6de = distance( player.origin, volume1.origin );
    var_373514cbee87947 = distance( player.origin, volume2.origin );
    
    if ( var_373514cbee87947 > var_f8f9b0ccf16ad6de )
    {
        return volume1;
    }
    
    if ( var_f8f9b0ccf16ad6de > var_373514cbee87947 )
    {
        return volume2;
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0x5ae201a5, Offset: 0xb6e9
// Size: 0x5a
function function_6a7a8cd990ce0aa0( player, volume )
{
    if ( isdefined( player ) && isdefined( player.origin ) && isdefined( volume ) && isdefined( volume.origin ) )
    {
        return distance( player.origin, volume.origin );
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0xaf58808a, Offset: 0xb74c
// Size: 0x7a
function function_1cf6aeee5404790( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( player.var_c33218f153f0feff ) )
    {
        if ( player.var_c33218f153f0feff.timeoutpending )
        {
            return;
        }
        
        player.var_c33218f153f0feff.timeoutpending = 1;
        player.var_c33218f153f0feff.timeoutstart = gettime();
        thread function_1df0e40be8fb82b5( player );
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0xfc83698, Offset: 0xb7ce
// Size: 0xb6
function function_1df0e40be8fb82b5( player )
{
    player endon( #"stop_timeout" );
    player endon( #"death_or_disconnect" );
    
    while ( isdefined( player.var_c33218f153f0feff ) && player.var_c33218f153f0feff.timeoutpending )
    {
        currenttime = gettime();
        
        if ( currenttime - player.var_c33218f153f0feff.timeoutstart >= getdvarint( @"hash_f09a64ced68b366e", 5000 ) && player.var_c33218f153f0feff.timeoutpending )
        {
            function_1091d3ad9ddd16bd( player );
            return;
        }
        
        wait 0.2;
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0x1dd42b71, Offset: 0xb88c
// Size: 0x9e
function function_5d67df7eec58703f( damagedata )
{
    victim = damagedata.victim;
    
    if ( isdefined( victim.modifiers ) && victim.modifiers[ "victiminstronghold" ] )
    {
        victimfortress = ai_fortress::function_386da8b7d1afe346( victim.origin );
        
        if ( isdefined( victimfortress ) )
        {
            if ( !isdefined( victimfortress.playerdeaths ) )
            {
                victimfortress.playerdeaths = 0;
            }
            
            victimfortress.playerdeaths++;
            victim function_ea440c271eefc5c9( "killed", 0 );
        }
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0xb12f570f, Offset: 0xb932
// Size: 0x1b
function function_1091d3ad9ddd16bd( player )
{
    player function_ea440c271eefc5c9( "timeout", 0 );
}

// Namespace br_analytics
// Params 2
// Checksum 0xd91c0ada, Offset: 0xb955
// Size: 0x7c
function function_6fa98f82a45739c9( ent, attacker )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    agentstruct = ent.agentstruct;
    
    if ( isdefined( agentstruct ) )
    {
        fortress = agentstruct.fortress;
        
        if ( isdefined( fortress ) )
        {
            if ( !isdefined( fortress.agentskilled ) )
            {
                fortress.agentskilled = 0;
            }
            
            fortress.agentskilled++;
        }
    }
}

// Namespace br_analytics
// Params 1
// Checksum 0xcdc26569, Offset: 0xb9d9
// Size: 0xec
function function_4cb6421bf76003cd( pickupent )
{
    if ( br_pickups::function_d1bdfe41ee9800f9( pickupent.scriptablename ) )
    {
        fortress = undefined;
        blacksite = undefined;
        
        if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.var_1fa50852a5cc3a1 ) && isdefined( pickupent.instance.blacksite ) )
        {
            fortress = pickupent.instance.var_1fa50852a5cc3a1;
            blacksite = pickupent.instance.blacksite;
        }
        else
        {
            fortress = pickupent.var_1fa50852a5cc3a1;
            blacksite = pickupent.blacksite;
        }
        
        if ( isdefined( fortress ) )
        {
            fortress.keypickedup = 1;
        }
        
        if ( isdefined( blacksite ) )
        {
            blacksite.keypickedup = 1;
        }
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0x3b6c0c81, Offset: 0xbacd
// Size: 0x59
function function_8514df40da031480( door, player )
{
    stronghold = door.fortress;
    
    if ( stronghold.isblacksite && !isdefined( stronghold.keyused ) )
    {
        stronghold.keyused = 1;
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0xacc9e4fc, Offset: 0xbb2e
// Size: 0x260
function function_87eb4e9014542156( teamname, success )
{
    if ( !isdefined( self.missioncleared ) )
    {
        self.missioncleared = istrue( success );
    }
    
    task = self.task;
    teams = function_72fb22ca64325446( task );
    
    if ( !isdefined( teams ) || teams.size <= 0 )
    {
        teams = [ teamname ];
    }
    
    foreach ( team in teams )
    {
        if ( isdefined( team ) && isdefined( self.teamattempts ) && isdefined( self.teamattempts[ team ] ) && isdefined( self.teamattempts[ team ].activeplayers ) )
        {
            teammembers = level.teamdata[ team ][ "players" ];
            reason = undefined;
            
            if ( success && team == teamname )
            {
                reason = "mission_success";
            }
            else if ( success )
            {
                reason = "mission_completed_by_another_team";
            }
            else
            {
                reason = "mission_failed";
            }
            
            foreach ( player in teammembers )
            {
                if ( success )
                {
                    if ( team == teamname || self.isblacksite )
                    {
                        if ( !isdefined( player.completedstrongholds ) )
                        {
                            player.completedstrongholds = [];
                        }
                        
                        player.completedstrongholds[ player.completedstrongholds.size ] = self;
                    }
                }
                
                if ( !isdefined( self.teamattempts[ team ] ) )
                {
                    break;
                }
                
                if ( arraycontains( self.teamattempts[ team ].activeplayers, player ) )
                {
                    player function_ea440c271eefc5c9( reason, success && team == teamname );
                }
            }
        }
    }
}

// Namespace br_analytics
// Params 2
// Checksum 0x46666c10, Offset: 0xbd96
// Size: 0x120
function function_fdb9f50e15f0d08f( teamname, success )
{
    teammembers = level.teamdata[ teamname ][ "players" ];
    reason = undefined;
    
    if ( success )
    {
        reason = "mission_success";
    }
    else
    {
        reason = "mission_failed";
    }
    
    foreach ( player in teammembers )
    {
        if ( success )
        {
            if ( !isdefined( player.completedstrongholds ) )
            {
                player.completedstrongholds = [];
            }
            
            player.completedstrongholds[ player.completedstrongholds.size ] = self;
        }
        
        if ( arraycontains( self.teamattempts[ teamname ].activeplayers, player ) )
        {
            player function_ea440c271eefc5c9( reason, istrue( success ) );
        }
    }
}

// Namespace br_analytics
// Params 1, eflags: 0x4
// Checksum 0x6afac0fd, Offset: 0xbebe
// Size: 0x11b
function private function_72fb22ca64325446( task )
{
    if ( task.teams.size > 0 )
    {
        return task.teams;
    }
    
    teams = [];
    
    foreach ( player in level.players )
    {
        if ( !arraycontains( teams, player.team ) && isdefined( player.var_c33218f153f0feff ) && isdefined( player.var_c33218f153f0feff.fortress ) && player.var_c33218f153f0feff.fortress.task == task )
        {
            teams[ teams.size ] = player.team;
        }
    }
    
    return teams;
}

// Namespace br_analytics
// Params 1, eflags: 0x4
// Checksum 0x29a6d5a2, Offset: 0xbfe2
// Size: 0x176
function private function_f2c0f79c7ba93d09( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    if ( isdefined( player.var_c33218f153f0feff ) && isdefined( player.var_c33218f153f0feff.fortress ) )
    {
        fortress = player.var_c33218f153f0feff.fortress;
        
        if ( isdefined( fortress.teamattempts[ oldteam ] ) )
        {
            fortress function_da11fb82e02a1ca0( self, "assimilation", 0, undefined, oldteam );
            
            if ( fortress.teamattempts[ oldteam ].activeplayers.size <= 0 )
            {
                if ( isdefined( fortress.teamattempts[ oldteam ].teamparticipants ) && ( fortress.teamattempts[ oldteam ].teamparticipants.size > 1 || fortress.teamattempts[ oldteam ].teamparticipants.size == 1 && fortress.teamattempts[ oldteam ].teamparticipants[ 0 ] != player ) )
                {
                    fortress function_f33ab5fd3c041336( oldteam, 0 );
                }
                else
                {
                    fortress.teamattempts[ oldteam ] = undefined;
                }
            }
        }
        
        fortress function_547722ef173afbbd( player, undefined, "assimilation" );
    }
}

// Namespace br_analytics
// Params 3, eflags: 0x4
// Checksum 0xb656e9f2, Offset: 0xc160
// Size: 0x293
function private function_547722ef173afbbd( player, timestamp, reason )
{
    fortress = self;
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    fortress function_453a644eb5a9ce81( player.team );
    
    if ( !arraycontains( fortress.teamattempts[ player.team ].teamparticipants, player ) )
    {
        fortress.teamattempts[ player.team ].teamparticipants[ fortress.teamattempts[ player.team ].teamparticipants.size ] = player;
    }
    
    if ( !arraycontains( fortress.teamattempts[ player.team ].activeplayers, player ) )
    {
        fortress.teamattempts[ player.team ].activeplayers[ fortress.teamattempts[ player.team ].activeplayers.size ] = player;
    }
    
    if ( !isdefined( fortress.teamattempts[ player.team ].attemptevents ) )
    {
        fortress.teamattempts[ player.team ].attemptevents = [];
    }
    
    attemptevent = spawnstruct();
    attemptevent.unoid = player getplayerunoid();
    attemptevent.type = "attempt_enter";
    
    if ( isdefined( reason ) )
    {
        attemptevent.reason = reason;
    }
    else
    {
        attemptevent.reason = "enter_volume";
    }
    
    if ( isdefined( timestamp ) )
    {
        attemptevent.timestamp = timestamp;
    }
    else
    {
        attemptevent.timestamp = gettime();
    }
    
    if ( !isdefined( fortress.teamattempts[ player.team ].attemptevents ) )
    {
        fortress.teamattempts[ player.team ].attemptevents = [];
    }
    
    fortress.teamattempts[ player.team ].attemptevents[ fortress.teamattempts[ player.team ].attemptevents.size ] = attemptevent;
}

// Namespace br_analytics
// Params 5, eflags: 0x4
// Checksum 0x7b113144, Offset: 0xc3fb
// Size: 0x1d0
function private function_da11fb82e02a1ca0( player, reason, success, timestamp, team )
{
    fortress = self;
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    if ( !isdefined( fortress.teamattempts[ team ] ) )
    {
        fortress.teamattempts[ team ] = spawnstruct();
    }
    
    if ( isdefined( fortress.teamattempts[ team ].activeplayers ) && arraycontains( fortress.teamattempts[ team ].activeplayers, player ) )
    {
        fortress.teamattempts[ team ].activeplayers = arrayremove( fortress.teamattempts[ team ].activeplayers, player );
    }
    
    attemptevent = spawnstruct();
    attemptevent.unoid = player getplayerunoid();
    attemptevent.type = "attempt_exit";
    attemptevent.reason = reason;
    
    if ( isdefined( timestamp ) )
    {
        attemptevent.timestamp = timestamp;
    }
    else
    {
        attemptevent.timestamp = gettime();
    }
    
    if ( !isdefined( fortress.teamattempts[ team ].attemptevents ) )
    {
        fortress.teamattempts[ team ].attemptevents = [];
    }
    
    fortress.teamattempts[ team ].attemptevents[ fortress.teamattempts[ team ].attemptevents.size ] = attemptevent;
}

// Namespace br_analytics
// Params 1
// Checksum 0x248c79eb, Offset: 0xc5d3
// Size: 0x104
function function_453a644eb5a9ce81( team )
{
    fortress = self;
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    if ( isdefined( fortress.teamattempts[ team ] ) )
    {
        return;
    }
    
    var_c462ab6fe29dfc9c = spawnstruct();
    var_c462ab6fe29dfc9c.activeplayers = [];
    var_c462ab6fe29dfc9c.fortress = string( fortress.name );
    var_c462ab6fe29dfc9c.starttime = gettime();
    var_c462ab6fe29dfc9c.endtime = undefined;
    var_c462ab6fe29dfc9c.team = team;
    var_c462ab6fe29dfc9c.teamparticipants = [];
    var_c462ab6fe29dfc9c.mission = fortress.task.ref;
    
    if ( isdefined( fortress.missioncleared ) )
    {
        var_c462ab6fe29dfc9c.mission = "secondary_objective";
    }
    
    fortress.teamattempts[ team ] = var_c462ab6fe29dfc9c;
}

// Namespace br_analytics
// Params 2
// Checksum 0x68df6488, Offset: 0xc6df
// Size: 0xf8
function function_f33ab5fd3c041336( team, success )
{
    assert( isdefined( team ) && isdefined( self.teamattempts[ team ] ) );
    
    if ( !isdefined( self.attempts ) )
    {
        self.attempts = 0;
    }
    
    self.attempts++;
    
    if ( success )
    {
        if ( !isdefined( self.successes ) )
        {
            self.successes = 0;
        }
        
        self.successes++;
    }
    else
    {
        if ( !isdefined( self.failures ) )
        {
            self.failures = 0;
        }
        
        self.failures++;
    }
    
    attemptstruct = self.teamattempts[ team ];
    attemptstruct.endtime = gettime();
    attemptstruct.success = success;
    attemptstruct.teamsize = teams::getteamcount( team, 0 );
    self.teamattempts[ team ] = undefined;
    function_233893654d77c47( attemptstruct );
}

// Namespace br_analytics
// Params 1
// Checksum 0x69fd8b9d, Offset: 0xc7df
// Size: 0x1e8
function function_233893654d77c47( attemptdata )
{
    playerevents = [];
    
    if ( attemptdata.attemptevents.size > 0 )
    {
        foreach ( ae in attemptdata.attemptevents )
        {
            playerevents[ playerevents.size ] = [ "event_type", ae.type, "reason", ae.reason, "timestamp", ae.timestamp, "uno_id", ae.unoid ];
        }
    }
    
    var_1d3416f259b7b0e7 = [ "player_events", playerevents, "fortress", attemptdata.fortress, "success", attemptdata.success, "mission", attemptdata.mission, "start_time", attemptdata.starttime, "end_time", attemptdata.endtime, "team", attemptdata.team, "team_size", attemptdata.teamsize, "team_participation_count", attemptdata.teamparticipants.size ];
    dlog_recordevent( "dlog_event_br_stronghold_attempt", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 0
// Checksum 0xc75e1ca4, Offset: 0xc9cf
// Size: 0x1fc
function function_75d9144fab811d63()
{
    player = self;
    playerteam = player.sessionteam;
    
    if ( !isdefined( playerteam ) )
    {
        playerteam = player.team;
    }
    
    teamsize = teams::getteamcount( playerteam, 0 );
    maxteamsize = game_utility::function_f24780eadd3fb772();
    
    if ( teamsize > maxteamsize )
    {
        params = [ "utc_connect_time_s", player.pers[ "telemetry" ].utc_connect_time_s, "team", playerteam, "join_type", player getjointype(), "skill", player getskill(), "party_id", player getpartyid(), "is_party_host", istrue( level.onlinegame ) ? player isfireteamleader() : 0, "was_keyboardmouse", player function_a36eded60cdc3922() != 1, "map", level.mapname, "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "game_type", game_utility::getgametype(), "sub_game_type", game_utility::getgametype(), "connect_index", player.pers[ "telemetry" ].connect_index ?? 0, "lobby_id", isdefined( getlobbyid() ) ? getlobbyid() : "", "is_ranked", istrue( level.leagueplaymatch ) || istrue( level.var_309e3d9dac389de6 ) ? 1 : 0 ];
        player dlog_recordplayerevent( "dlog_event_br_player_oversize_team", params );
    }
}

// Namespace br_analytics
// Params 0
// Checksum 0x81546360, Offset: 0xcbd3
// Size: 0x2ce
function function_2295232c222ad384()
{
    poi = "unknown";
    shname = "unknown";
    shorigin = "unknown";
    shtier = br_strongholds::function_999adf66330f4aa8();
    attempts = 0;
    successes = 0;
    failures = 0;
    playerdeaths = 0;
    agentdeaths = 0;
    loadoutstaken = 0;
    missioncleared = 0;
    keypickedup = istrue( self.keypickedup );
    unlocked = self.isblacksite && self.unlocked;
    
    if ( isdefined( self.poiname ) )
    {
        poi = self.poiname;
    }
    
    if ( isdefined( self.name ) )
    {
        shname = string( self.name );
    }
    
    if ( isdefined( self.origin ) )
    {
        shorigin = string( self.origin );
    }
    
    if ( isdefined( self.attempts ) )
    {
        attempts = self.attempts;
    }
    
    if ( isdefined( self.successes ) )
    {
        successes = self.successes;
    }
    
    if ( isdefined( self.failures ) )
    {
        failures = self.failures;
    }
    
    if ( isdefined( self.playerdeaths ) )
    {
        playerdeaths = self.playerdeaths;
    }
    
    if ( isdefined( self.agentskilled ) )
    {
        agentdeaths = self.agentskilled;
    }
    
    if ( isdefined( self.crate ) && isdefined( self.crate.var_43355c6fab4683be ) )
    {
        loadoutstaken = self.crate.var_43355c6fab4683be.size;
    }
    
    if ( isdefined( self.missioncleared ) )
    {
        missioncleared = istrue( self.missioncleared );
    }
    
    args = [ "poi", poi, "name", shname, "origin", shorigin, "tier", shtier, "is_blacksite", istrue( self.isblacksite ), "attempts", attempts, "successes", successes, "failures", failures, "player_deaths", playerdeaths, "ai_deaths", agentdeaths, "loadouts_taken", loadoutstaken, "mission_cleared", missioncleared, "key_picked_up", keypickedup, "blacksite_unlocked", unlocked ];
    dlog_recordevent( "dlog_event_br_stronghold_data", args );
}

// Namespace br_analytics
// Params 0
// Checksum 0xf6651842, Offset: 0xcea9
// Size: 0x297
function initcashtracking()
{
    level.cashtypes = [];
    level.cashtypes[ level.cashtypes.size ] = "loot";
    level.cashtypes[ level.cashtypes.size ] = "mission";
    level.cashtypes[ level.cashtypes.size ] = "combat";
    level.cashtypes[ level.cashtypes.size ] = "cache";
    level.cashtypes[ level.cashtypes.size ] = "cache_legendary";
    level.cashtypes[ level.cashtypes.size ] = "cache_scavenger";
    level.cashtypes[ level.cashtypes.size ] = "cache_secretstash";
    level.cashtypes[ level.cashtypes.size ] = "reusable_cache";
    level.cashtypes[ level.cashtypes.size ] = "cache_personal_supply";
    level.cashtypes[ level.cashtypes.size ] = "cache_personal_legacy";
    level.cashtypes[ level.cashtypes.size ] = "loot_chopper";
    level.cashtypes[ level.cashtypes.size ] = "c130_box";
    level.cashmetrics = [];
    
    foreach ( team in level.teamnamelist )
    {
        data = spawnstruct();
        data.sources = [];
        data.totaldata = [];
        
        foreach ( type in level.cashtypes )
        {
            data.sources[ type ] = 0;
            data.totaldata[ type ] = 0;
        }
        
        level.cashmetrics[ team ] = data;
    }
    
    level waittill( #"prematch_done" );
    level thread recordinterval();
}

// Namespace br_analytics
// Params 0
// Checksum 0x426ba75, Offset: 0xd148
// Size: 0x3a6
function recordinterval()
{
    for ( waittime = 60; !level.gameended ; waittime = max( 60 - updatetime, 0 ) )
    {
        level utility::waittill_notify_or_timeout( "game_ended", waittime );
        starttime = gettime();
        placements = gamescore::getteamscoreplacements();
        
        foreach ( team in level.teamnamelist )
        {
            if ( !isdefined( team ) )
            {
                continue;
            }
            
            time = matchdata::gettimefrommatchstart( gettime() );
            eventparams = [ "match_complete", 0, "time", time, "team", team, "placement", placements[ team ] ];
            
            foreach ( type in level.cashtypes )
            {
                value = level.cashmetrics[ team ].sources[ type ];
                eventparams[ eventparams.size ] = "cash_source_" + type;
                eventparams[ eventparams.size ] = value;
                level.cashmetrics[ team ].totaldata[ type ] += value;
                level.cashmetrics[ team ].sources[ type ] = 0;
            }
            
            dlog_recordevent( "dlog_event_blood_money_interval", eventparams );
            waitframe();
        }
        
        updatetime = ( gettime() - starttime ) * 0.001;
    }
    
    time = matchdata::gettimefrommatchstart( gettime() );
    placements = gamescore::getteamscoreplacements();
    
    foreach ( team in level.teamnamelist )
    {
        eventparams = [ "match_complete", 1, "time", time, "team", team, "placement", placements[ team ] ];
        
        foreach ( type in level.cashtypes )
        {
            value = level.cashmetrics[ team ].totaldata[ type ];
            eventparams[ eventparams.size ] = "cash_source_" + type;
            eventparams[ eventparams.size ] = value;
        }
        
        dlog_recordevent( "dlog_event_blood_money_interval", eventparams );
    }
}

// Namespace br_analytics
// Params 3
// Checksum 0xd03456f0, Offset: 0xd4f6
// Size: 0x8d
function trackcashevent( player, type, amount )
{
    if ( !( isdefined( level.cashmetrics ) && isdefined( player ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    team = player.team;
    level.cashmetrics[ team ].sources[ type ] += amount;
}

// Namespace br_analytics
// Params 0
// Checksum 0xaf72d197, Offset: 0xd58b
// Size: 0x9
function onmatchstartbr()
{
    thread _onmatchstartbr();
}

// Namespace br_analytics
// Params 0
// Checksum 0xb58cd9c7, Offset: 0xd59c
// Size: 0x3fb
function _onmatchstartbr()
{
    waittillframeend();
    assert( isarray( level.players ) );
    maxteamsize = level.maxteamsize ?? 0;
    playercount = level.players.size;
    teamcount = getteamcount();
    humanplayercount = 0;
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) || player isplayerheadless() )
        {
            continue;
        }
        
        humanplayercount++;
    }
    
    kioskrespawncost = level.common_armory_kiosk.teamrevivecost ?? 0;
    var_dbd7da832b22847c = level.usegulag ?? 0;
    
    if ( isdefined( level.gulag ) )
    {
        gulagmaxuses = level.gulag.maxuses ?? 0;
        gulagstartingarmor = level.gulag.numarmorhealth ?? 0;
        gulagspawnloot = level.gulag.spawnloot ?? 0;
    }
    else
    {
        gulagmaxuses = 0;
        gulagstartingarmor = 0;
        gulagspawnloot = 0;
    }
    
    missiontypeinfo = [];
    
    if ( getdvarint( @"scr_br_quests_enabled", 1 ) && isdefined( level.questinfo ) )
    {
        foreach ( type, info in level.questinfo.tabletinfo )
        {
            assert( isstring( type ) );
            missiontypeinfo[ missiontypeinfo.size ] = "name";
            missiontypeinfo[ missiontypeinfo.size ] = type;
            isenabled = istrue( info.enabled );
            missiontypeinfo[ missiontypeinfo.size ] = "is_enabled";
            missiontypeinfo[ missiontypeinfo.size ] = isenabled;
        }
    }
    
    playlistid = getplaylistid();
    prematchendtime = level.prematchendtime ?? -1;
    frame_duration = getframeduration();
    challenge_game_type = challenges::function_9edd00e9e48c0821() ?? 0;
    dlog_recordevent( "dlog_event_br_server_match_start", [ "br_mission_type_info", missiontypeinfo, "map", level.script, "sub_game_type", game_utility::getgametype(), "max_team_size", maxteamsize, "player_count", playercount, "human_player_count", humanplayercount, "team_count", teamcount, "kiosk_respawn_cost", kioskrespawncost, "gulag_active", var_dbd7da832b22847c, "gulag_max_uses", gulagmaxuses, "gulag_starting_armor", gulagstartingarmor, "gulag_spawn_loot", gulagspawnloot, "prematch_end_time", prematchendtime, "playlist_id", playlistid, "frame_duration", frame_duration, "challenge_game_type", challenge_game_type, "ui_bot_count", manager::function_6f7e22d4e6adac55(), "bba_enabled", istrue( namespace_ddca46d216b096e2::isenabled() ) ] );
}

// Namespace br_analytics
// Params 0
// Checksum 0x3bdbd9c1, Offset: 0xd99f
// Size: 0xc2
function getteamcount()
{
    teamcount = 0;
    
    foreach ( team in level.teamnamelist )
    {
        teamplayers = teams::getteamdata( team, "players" );
        
        if ( teamplayers.size > 0 || isdefined( level.uibotmanager ) && teams::getteamdata( team, "UIBotCount" ) > 0 )
        {
            teamcount++;
        }
    }
    
    return teamcount;
}

// Namespace br_analytics
// Params 0
// Checksum 0x917e1a2f, Offset: 0xda6a
// Size: 0x140
function function_4e78ec287f90302a()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    guardsattacked = 0;
    riotstriggered = 0;
    riotscompleted = 0;
    
    if ( isdefined( level.gulag ) && isdefined( level.gulag.arenas ) )
    {
        foreach ( arena in level.gulag.arenas )
        {
            guardsattacked += arena.var_3afe96a52c3f4adc ?? 0;
            riotstriggered += arena.riotsstarted ?? 0;
            riotscompleted += arena.riotscompleted ?? 0;
        }
    }
    
    dlog_recordevent( "dlog_event_br_riot_totals", [ "guards_attacked", guardsattacked, "riots_triggered", riotstriggered, "riots_completed", riotscompleted ] );
}

// Namespace br_analytics
// Params 6
// Checksum 0x4afe35cf, Offset: 0xdbb2
// Size: 0xa9
function function_97aaf58ee5152114( arenaid, circleindex, result, participants, leftovers, releasedplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_gulagbreak_result", [ "arena", arenaid, "circle_index", circleindex, "result", result, "participants", participants, "leftovers", leftovers, "released", releasedplayers ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0xf5e5d43b, Offset: 0xdc63
// Size: 0x93
function function_dbab3fcf4e472e0b( result, fail_reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    self dlog_recordplayerevent( "dlog_event_reinforcement_flare_use", [ "result", result, "fail_reason", fail_reason, "circle_index", isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) ? level.br_circle.circleindex : -1 ] );
}

// Namespace br_analytics
// Params 8
// Checksum 0x68d32421, Offset: 0xdcfe
// Size: 0xfa
function function_1d9ce94acd8288a1( squadtotal, placement, totalcash, looted, contracts, valuables, lostondeath, var_d80efe3fe45117fa )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    self dlog_recordplayerevent( "dlog_event_br_plunder_match_totals", [ "total_squad_cash", int( squadtotal ), "placement", int( placement ), "total_cash", int( totalcash ), "looted_cash", int( looted ), "contract_cash", int( contracts ), "valuable_cash", int( valuables ), "cash_lost_on_death", int( lostondeath ), "cash_lost_on_purchase", int( var_d80efe3fe45117fa ) ] );
}

// Namespace br_analytics
// Params 2
// Checksum 0x370b45ca, Offset: 0xde00
// Size: 0xf9
function function_3778f37c09318ff7( player, treelevel )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_ff_tree_level_achieved", [ "player" + "_x", player.origin[ 0 ], "player" + "_y", player.origin[ 1 ], "player" + "_z", player.origin[ 2 ], "player" + "_pitch", utility::getplayerpitch( player ), "player" + "_yaw", utility::getplayeryaw( player ), "circle_index", level.br_circle.circleindex ?? -1, "tree_level", treelevel ] );
}

// Namespace br_analytics
// Params 5
// Checksum 0x44c645c4, Offset: 0xdf01
// Size: 0xe7
function function_321f1c3b243efd10( valuablename, basevalue, quantity, cashtotal, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_valuable_sold", [ "valuable_name", valuablename, "base_sell_value", basevalue, "quantity", quantity, "cash_total", cashtotal, "match_time", game_utility::gettimepassed(), "closest_poi", poi::function_c14b808f44505866( player.origin ), "player_plunder_count", player currency::get_currency_amount( "cash" ), "player_plunder_banked", player.plunderbanked ] );
}

// Namespace br_analytics
// Params 0, eflags: 0x4
// Checksum 0x342f0184, Offset: 0xdff0
// Size: 0xd2
function private function_b10a6237441cd488()
{
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    game_type = game_utility::getgametype();
    map_name = game_utility::getmapname();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    return [ "map_name", map_name ?? "", "game_type", game_type ?? "", "playlist_id", playlist_id ?? 0, "playlist_name", playlist_name ?? "" ];
}

// Namespace br_analytics
// Params 3
// Checksum 0xe1aca8ea, Offset: 0xe0cb
// Size: 0xb0
function function_b63e427a9d8c7f20( activitytype = "unknown", activityorigin = ( 0, 0, 0 ), activityinstanceid = -1 )
{
    var_1d3416f259b7b0e7 = [ "activity_type", activitytype, "activity_instance_id", activityinstanceid, "activity_x", activityorigin[ 0 ], "activity_y", activityorigin[ 1 ], "activity_z", activityorigin[ 2 ] ];
    dlog_recordevent( "dlog_event_br_bongo_activity_init", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 2
// Checksum 0x264c2c17, Offset: 0xe183
// Size: 0xdf
function function_63a0465c6e14c930( activityinstance, player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    activityinstanceid = activityinstance.id;
    var_a106364c0b46144c = activityinstance.parentactivity.id;
    player.var_2600924941bba80e = ( player.var_2600924941bba80e ?? 0 ) + 1;
    player.var_27eda16ebaada9df = player.var_27eda16ebaada9df ?? [];
    player.var_27eda16ebaada9df[ activityinstanceid ] = { #var_c552d32715853a2f:gettime(), #id:player.var_2600924941bba80e };
    player function_8c1486cbdf085e91( player.origin, activityinstanceid, var_a106364c0b46144c, player.var_2600924941bba80e );
}

// Namespace br_analytics
// Params 4, eflags: 0x4
// Checksum 0x5082cafa, Offset: 0xe26a
// Size: 0xd3
function private function_8c1486cbdf085e91( playerorigin, activityinstance, parentinstance, var_619217a97e0cbb9a )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( activityinstance ) )
    {
        activityinstance = -1;
    }
    
    if ( !isdefined( playerorigin ) )
    {
        playerorigin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( parentinstance ) )
    {
        parentinstance = -1;
    }
    
    var_1d3416f259b7b0e7 = [ "player_x", playerorigin[ 0 ], "player_y", playerorigin[ 1 ], "player_z", playerorigin[ 2 ], "activity_instance_id", activityinstance, "activity_activation_id", var_619217a97e0cbb9a, "activity_parent_id", parentinstance ];
    self dlog_recordplayerevent( "dlog_event_br_bongo_activity_player_start", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 7
// Checksum 0xd99c52ba, Offset: 0xe345
// Size: 0x198
function function_d9845418c8b51cff( activityinstance, player, var_67d65d44a8ce8450, var_cd156d55d43f7689, var_cd156a55d43f6ff0, var_cd156b55d43f7223, var_cd157055d43f7d22 )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    activityinstanceid = activityinstance.id;
    var_a106364c0b46144c = activityinstance.parentactivity.id;
    var_27eda16ebaada9df = player.var_27eda16ebaada9df[ activityinstanceid ];
    var_98fbb88204cc722d = gettime() - var_27eda16ebaada9df.var_c552d32715853a2f;
    leavereason = "unknown";
    
    if ( isdefined( var_67d65d44a8ce8450 ) )
    {
        leavereason = var_67d65d44a8ce8450;
    }
    else
    {
        switch ( activity_instance_common::getactivitystate( activityinstance ) )
        {
            case #"hash_6b254522a347587b":
                leavereason = activityinstance.successfullycompleted == 1 ? "activity_success" : "activity_failed";
                break;
            case #"hash_b29bc111252c5ff3":
                leavereason = "activity_cleanup";
                break;
            case #"hash_d9fe739ef1ff5d6f":
                leavereason = isalive( player ) ? "activity_left" : "player_death";
                break;
            case #"hash_52776813dae194d3":
                leavereason = "activity_idle_left";
                break;
        }
    }
    
    player function_4de18a1a0c3bfeb0( player.origin, activityinstanceid, var_a106364c0b46144c, var_27eda16ebaada9df.id, var_98fbb88204cc722d, leavereason, var_cd156d55d43f7689, var_cd156a55d43f6ff0, var_cd156b55d43f7223, var_cd157055d43f7d22 );
    player.var_27eda16ebaada9df[ activityinstanceid ] = undefined;
}

// Namespace br_analytics
// Params 10, eflags: 0x4
// Checksum 0x63bcc7a, Offset: 0xe4e5
// Size: 0x197
function private function_4de18a1a0c3bfeb0( playerorigin, activityinstance, parentinstance, var_619217a97e0cbb9a, var_98fbb88204cc722d, result_string, custom_a, custom_b, custom_c, custom_d )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( activityinstance ) )
    {
        activityinstance = -1;
    }
    
    if ( !isdefined( parentinstance ) )
    {
        parentinstance = -1;
    }
    
    if ( !isdefined( playerorigin ) )
    {
        playerorigin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var_98fbb88204cc722d ) )
    {
        var_98fbb88204cc722d = 0;
    }
    
    if ( !isdefined( result_string ) )
    {
        result_string = "unknown";
    }
    
    if ( !isdefined( custom_a ) )
    {
        custom_a = 0;
    }
    
    if ( !isdefined( custom_b ) )
    {
        custom_b = 0;
    }
    
    if ( !isdefined( custom_c ) )
    {
        custom_c = 0;
    }
    
    if ( !isdefined( custom_d ) )
    {
        custom_d = 0;
    }
    
    var_1d3416f259b7b0e7 = [ "player_x", playerorigin[ 0 ], "player_y", playerorigin[ 1 ], "player_z", playerorigin[ 2 ], "activity_instance_id", activityinstance, "activity_activation_id", var_619217a97e0cbb9a, "time_spent_in_activity_ms", var_98fbb88204cc722d, "objective_result_a", custom_a, "objective_result_b", custom_b, "objective_result_c", custom_c, "objective_result_d", custom_d, "end_reason", result_string, "activity_parent_id", parentinstance ];
    self dlog_recordplayerevent( "dlog_event_br_bongo_activity_player_end", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 2
// Checksum 0x30585518, Offset: 0xe684
// Size: 0xbf
function function_29ad92fb1ce29560( activityinstance, player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    activityinstanceid = activityinstance.id;
    player.var_2600924941bba80e = ( player.var_2600924941bba80e ?? 0 ) + 1;
    player.var_27eda16ebaada9df = player.var_27eda16ebaada9df ?? [];
    player.var_27eda16ebaada9df[ activityinstanceid ] = { #var_c552d32715853a2f:gettime(), #id:player.var_2600924941bba80e };
    player function_ab496846b5cc1425( player.origin, player.angles, activityinstanceid );
}

// Namespace br_analytics
// Params 3, eflags: 0x4
// Checksum 0x7e0c6754, Offset: 0xe74b
// Size: 0xd8
function private function_ab496846b5cc1425( playerorigin, playerangles, activityinstance )
{
    assert( isplayer( self ) );
    activityinstance = activityinstance ?? -1;
    playerorigin = playerorigin ?? ( 0, 0, 0 );
    playerangles = playerangles ?? ( 0, 0, 0 );
    var_1d3416f259b7b0e7 = [ "player_x", playerorigin[ 0 ], "player_y", playerorigin[ 1 ], "player_z", playerorigin[ 2 ], "player_pitch", playerangles[ 0 ], "player_yaw", playerangles[ 1 ], "activity_instance_id", activityinstance ];
    self dlog_recordplayerevent( "dlog_event_br_bongo_cradle_bomb_player_enter", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 3
// Checksum 0xc7fd4838, Offset: 0xe82b
// Size: 0xab
function function_ac82ba72661fcfd5( activityinstance, player, endreason )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    activityinstanceid = activityinstance.id;
    var_27eda16ebaada9df = player.var_27eda16ebaada9df[ activityinstanceid ];
    var_98fbb88204cc722d = isdefined( var_27eda16ebaada9df ) ? gettime() - var_27eda16ebaada9df.var_c552d32715853a2f : -1;
    player function_e37ee52d8f00d45d( player.origin, player.angles, activityinstanceid, var_98fbb88204cc722d, endreason );
    player.var_27eda16ebaada9df[ activityinstanceid ] = undefined;
}

// Namespace br_analytics
// Params 5, eflags: 0x4
// Checksum 0xb9a95aba, Offset: 0xe8de
// Size: 0x11c
function private function_e37ee52d8f00d45d( playerorigin, playerangles, activityinstance, var_98fbb88204cc722d, var_32e5d2ef9e4f163e )
{
    assert( isplayer( self ) );
    activityinstance = activityinstance ?? -1;
    playerorigin = playerorigin ?? ( 0, 0, 0 );
    playerangles = playerangles ?? ( 0, 0, 0 );
    var_98fbb88204cc722d = var_98fbb88204cc722d ?? 0;
    var_32e5d2ef9e4f163e = var_32e5d2ef9e4f163e ?? "unknown";
    var_1d3416f259b7b0e7 = [ "player_x", playerorigin[ 0 ], "player_y", playerorigin[ 1 ], "player_z", playerorigin[ 2 ], "player_pitch", playerangles[ 0 ], "player_yaw", playerangles[ 1 ], "activity_instance_id", activityinstance, "time_spent_inside_ms", var_98fbb88204cc722d, "exit_reason", var_32e5d2ef9e4f163e ];
    self dlog_recordplayerevent( "dlog_event_br_bongo_cradle_bomb_player_exit", var_1d3416f259b7b0e7 );
}

// Namespace br_analytics
// Params 4
// Checksum 0xf0343e07, Offset: 0xea02
// Size: 0xdd
function function_9e4ae8c5b22fc08a( playerorigin, perkname, var_939d17e9f88245bc, perkdurationms )
{
    assert( isplayer( self ) );
    playerorigin = playerorigin ?? ( 0, 0, 0 );
    perkname = perkname ?? "unknown";
    var_939d17e9f88245bc = var_939d17e9f88245bc ?? 0;
    perkdurationms = perkdurationms ?? 0;
    var_1d3416f259b7b0e7 = [ "player_x", playerorigin[ 0 ], "player_y", playerorigin[ 1 ], "player_z", playerorigin[ 2 ], "perk_name", perkname, "time_since_looted_ms", var_939d17e9f88245bc, "perk_duration_ms", perkdurationms ];
    self dlog_recordplayerevent( "dlog_event_br_bongo_perk_usage", var_1d3416f259b7b0e7 );
}

