// scripts\mp\br\gametypes\br_circle.gsc  (hash_5925e714a9b193a8.gscc) (size: 74189 Bytes / 0x121cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ccd378f (751646607)
// size ...... 74189 (0x121cd)
// includes .. 42  (offset: 0x116bd)
// strings ... 138 (offset: 0x1180d)
// dev strs .. 42  (offset: 0x11fb5)
// exports ... 160 (offset: 0xcd75)
// cseg ...... 0xfc2 + 0xbdb3 (0xcd75)
// imports ... 360 (offset: 0xe675)
// animtree1 . 0   (offset: 0x121cd)
// animtree2 . 0   (offset: 0x121cd)
#using script_be7da0439d09064;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\scriptable_group;
#using scripts\common\scriptable_group_spatial;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_multi_circle;
#using scripts\mp\br\gametypes\br_multi_circle_objectives;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\music_br;
#using scripts\mp\operator;
#using scripts\mp\rank;
#using scripts\mp\teamrevive;
#using scripts\mp\weaponrank;

#namespace br_circle;

// Namespace br_circle/event_7a787c1686d7435d
// Params 1, eflags: 0x24
// Checksum 0x78bd98b3, Offset: 0xfe0
// Size: 0x1ac
function private event_handler[event_7a787c1686d7435d] init_circles_callback( params )
{
    if ( getdvarint( @"hash_6beae9bf7f44342f", 0 ) == 0 )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "codmas_clash" )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        var_44e411c3470f5178 = getdvarfloat( @"hash_ddfa90008c99da3c", 0.25 ) > randomfloat( 1 );
        
        if ( !var_44e411c3470f5178 )
        {
            setdvar( @"scr_br_circle_disable", 1 );
        }
    }
    
    br_gametypes::init();
    
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        return;
    }
    
    mapcorners = function_80bbfbe3999458de();
    assert( isdefined( mapcorners ) );
    level.mapcorners[ 0 ] = { #angles:( 0, 0, 0 ), #origin:mapcorners.corner0 };
    level.mapcorners[ 1 ] = { #angles:( 0, 0, 0 ), #origin:mapcorners.corner1 };
    setdvar( @"hash_4c6bb55c1c24b215", 1 );
    setdvar( @"hash_ec3624dc00480c76", 1 );
    setdvar( @"hash_67a8c844bad5a45b", 0 );
    br::function_a4785bf1d05110c2();
    level.var_c8cb79f46406cf7c = 1;
    initcircle();
    
    if ( getcodegate( #"hash_7fff7c13f6cce76f" ) )
    {
        assert( isdefined( level.br_multi_circle.circles[ 0 ].circlecenters ) );
        function_626886d8f1aefaed();
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x535dd3ae, Offset: 0x1194
// Size: 0x13a
function function_626886d8f1aefaed()
{
    foreach ( index, circle in level.br_multi_circle.circles[ 0 ].circlecenters )
    {
        items = level.br_level.var_bb4814756532fa4e[ index ].items;
        
        if ( !isdefined( items ) || items.size == 0 )
        {
            continue;
        }
        
        quantities = level.br_level.var_bb4814756532fa4e[ index ].quantities;
        circlecenter = circle;
        circleradius = level.br_level.br_circleradii[ index ];
        function_842e2f26565e43fd( circlecenter, circleradius, index, items, quantities );
    }
    
    level.br_level.var_bb4814756532fa4e = undefined;
}

// Namespace br_circle
// Params 0
// Checksum 0xff1eeec, Offset: 0x12d6
// Size: 0x3c3
function initcircle()
{
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        level.br_circle_disabled = 1;
        return;
    }
    
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    level.br_circle = spawnstruct();
    level.br_circle.mapbounds = level.br_level.br_mapbounds;
    
    if ( getdvarint( @"scr_br_circle_fixed_damage", 10 ) > 0 )
    {
        level.br_circle.damagetick = [ getdvarint( @"scr_br_circle_fixed_damage", 10 ) ];
    }
    else if ( level.mapname == "mp_quarry2" || level.mapname == "mp_prison" || level.mapname == "mp_lumber" )
    {
        level.br_circle.damagetick = [ 10, 10, 10, 10, 10 ];
    }
    else
    {
        level.br_circle.damagetick = [ 10, 10, 10, 10, 10, 10, 10, 10 ];
    }
    
    level.var_b98489098cfce81e = utility::function_b104528d84ca3561( utility::function_49a778e73bbb0f58( @"hash_3897ae07679d4523", "1574, 1259, 1000, 1000, 1000, 1000, 1000, 1000, 0, 0, 0", level.gametypebundle.var_b7ca6f7452a72290 ) );
    level.var_ea96217a33eb6457 = getdvarint( @"hash_bc78c3747f2a6ab4", level.var_b98489098cfce81e[ 0 ] );
    level.br_circle.circleindex = -1;
    level.br_circle.var_bdb61cc517e4942d = 0;
    br_multi_circle::init();
    br_multi_circle_objectives::init();
    
    if ( br_gametypes::isfeatureenabled( #"hash_7bf340059947e149" ) )
    {
        return;
    }
    
    setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ 0 ] );
    var_4bbed1a93af3bfdd = level.br_level.br_circleclosetimes.size;
    setomnvar( "ui_br_total_circle_collapse_count", var_4bbed1a93af3bfdd );
    level.br_circle.fadedurationsec = 4;
    
    if ( isdefined( level.var_24950bfd23e063a1 ) )
    {
        level.br_circle.br_finalcircleoverride = function_4483d0837431d23a();
        [[ level.var_24950bfd23e063a1 ]]();
    }
    else
    {
        _precalcsafecirclecenters();
    }
    
    br_multi_circle::function_f34344b1123f1dc0();
    
    if ( getdvarint( @"hash_6ce99c9bce6e5660", 0 ) )
    {
        function_ffd6be4c479488cf();
    }
    
    if ( function_b1e7d42b185c8d31() )
    {
        pausecircle( 1 );
    }
    
    if ( getdvarint( @"hash_9f5afc54c84a812b", 1 ) )
    {
        level.br_circle.var_a316f0f6121d5abd = 1;
        level.br_circle.var_e0a093ff48d4512 = getdvarfloat( @"hash_cd84628561dcacbc", 1200 );
        level.var_9d2af55ce6b7b87d = getdvarfloat( @"hash_71bc6776b51c0865", 500 );
        level.br_circle.var_218f8c7ea7365164 = getdvarint( @"hash_7fa93af1d06c9917", 1000 );
    }
    
    utility::registersharedfunc( #"br_circle", #"hash_e2f87d36729a4f5a", &function_609e9d6d7f9935ff );
    utility::registersharedfunc( #"br_circle", #"playcoughaudio", &tryplaycoughaudio );
    utility::registersharedfunc( #"br_circle", #"hash_3d3cfb00b346b128", &function_2b56c0c1d9436a89 );
    
    /#
        setdevdvarifuninitialized( @"br_circle_pause", 0 );
    #/
}

// Namespace br_circle
// Params 0
// Checksum 0xf003a05, Offset: 0x16a1
// Size: 0x184
function function_8f3d20a0b39d229c()
{
    br_circleclosetimes = function_80e73aae920b910b( getdvar( @"scr_br_circleclosetimes_override", "" ) );
    br_circledelaytimes = function_80e73aae920b910b( getdvar( @"scr_br_circledelaytimes_override", "" ) );
    br_circleshowdelaydanger = function_80e73aae920b910b( getdvar( @"scr_br_circleshowdelaydanger_override", "" ) );
    br_circleshowdelaysafe = function_80e73aae920b910b( getdvar( @"scr_br_circleshowdelaysafe_override", "" ) );
    br_circleminimapradii = function_80e73aae920b910b( getdvar( @"scr_br_circleminimapradii_override", "" ) );
    br_circleradii = function_80e73aae920b910b( getdvar( @"scr_br_circleradii_override", "" ) );
    
    if ( br_circleclosetimes.size > 0 )
    {
        level.br_level.br_circleclosetimes = br_circleclosetimes;
    }
    
    if ( br_circledelaytimes.size > 0 )
    {
        level.br_level.br_circledelaytimes = br_circledelaytimes;
    }
    
    if ( br_circleshowdelaydanger.size > 0 )
    {
        level.br_level.br_circleshowdelaydanger = br_circleshowdelaydanger;
    }
    
    if ( br_circleshowdelaysafe.size > 0 )
    {
        level.br_level.br_circleshowdelaysafe = br_circleshowdelaysafe;
    }
    
    if ( br_circleminimapradii.size > 0 )
    {
        level.br_level.br_circleminimapradii = br_circleminimapradii;
    }
    
    if ( br_circleradii.size > 0 )
    {
        level.br_level.br_circleradii = br_circleradii;
    }
}

// Namespace br_circle
// Params 1
// Checksum 0xcf012a8e, Offset: 0x182d
// Size: 0x4b
function function_80e73aae920b910b( dvarvalue )
{
    array = strtok( dvarvalue, " " );
    
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] = int( array[ i ] );
    }
    
    return array;
}

// Namespace br_circle
// Params 1
// Checksum 0xf6cd4367, Offset: 0x1881
// Size: 0x4b
function function_783ad1757ca38c2a( dvarvalue )
{
    array = strtok( dvarvalue, " " );
    
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] = float( array[ i ] );
    }
    
    return array;
}

// Namespace br_circle
// Params 0
// Checksum 0x9f3368a9, Offset: 0x18d5
// Size: 0x4a
function function_2b56c0c1d9436a89()
{
    if ( !isdefined( level.br_circle.circleindex ) )
    {
        assert( isdefined( level.br_circle.circleindex ) );
        return;
    }
    
    return level.br_circle.circleindex;
}

// Namespace br_circle
// Params 4
// Checksum 0x9cea9d62, Offset: 0x1928
// Size: 0x3a8
function initcirclepoststarttocircleindex( origin, startcircledelay, startcircleindex, startcircleclosetime )
{
    if ( isdefined( level.br_circle ) )
    {
        return;
    }
    
    level.br_circle = spawnstruct();
    level.br_circle.mapbounds = level.br_level.br_mapbounds;
    level.br_circle.damagetick = [ 10, 10, 10, 10, 10, 10, 10, 10 ];
    maxindex = level.br_level.br_circleclosetimes.size - 1;
    
    if ( !isdefined( startcircleindex ) || startcircleindex < 0 )
    {
        startcircleindex = 0;
    }
    else if ( startcircleindex > maxindex )
    {
        startcircleindex = maxindex;
    }
    
    newsize = level.br_level.br_circleclosetimes.size - startcircleindex;
    var_9a2b13dc5e5549f1 = level.br_level.br_circleradii[ 0 ];
    
    if ( !isdefined( startcircleclosetime ) || startcircleclosetime <= 0 )
    {
        startcircleclosetime = level.br_level.br_circleclosetimes[ 0 ];
    }
    
    level.br_circle.fadedurationsec = 4;
    level.br_circle.circleindex = -1;
    level.br_level.circle_defaults = undefined;
    level.br_circle.damagetick = copycirclearraystartingat( level.br_circle.damagetick, startcircleindex );
    level.br_level.br_circleclosetimes = copycirclearraystartingat( level.br_level.br_circleclosetimes, startcircleindex );
    level.br_level.br_circledelaytimes = getzeroarray( newsize, startcircledelay );
    level.br_level.br_circleshowdelaydanger = getzeroarray( newsize, startcircledelay );
    level.br_level.br_circleshowdelaysafe = copycirclearraystartingat( level.br_level.br_circleshowdelaysafe, startcircleindex );
    level.br_level.br_circleminimapradii = copycirclearraystartingat( level.br_level.br_circleminimapradii, startcircleindex );
    level.br_level.br_circleradii = copycirclearraystartingat( level.br_level.br_circleradii, startcircleindex );
    level.br_level.br_circleradii[ 0 ] = var_9a2b13dc5e5549f1;
    level.br_level.br_circleclosetimes[ 0 ] = startcircleclosetime;
    applycirclesettings();
    level thread _precalcsafecirclecenters( origin );
    level notify( #"hash_161c3d8f1cc2d1ea" );
    
    if ( isdefined( level.circlepeeks ) )
    {
        foreach ( circlepeek in level.circlepeeks )
        {
            circlepeek game_utility::questcircle_delete();
        }
        
        level.circlepeeks = undefined;
        br_circle_peek::setupcirclepeek();
    }
    
    thread runcircles( 0 );
}

// Namespace br_circle
// Params 2
// Checksum 0xa74addde, Offset: 0x1cd8
// Size: 0x2f
function copycirclearraystartingat( circlearray, startindex )
{
    if ( startindex == 0 )
    {
        return circlearray;
    }
    
    circlearray = utility::array_slice( circlearray, startindex, circlearray.size );
    return circlearray;
}

// Namespace br_circle
// Params 2
// Checksum 0xbc542eb5, Offset: 0x1d10
// Size: 0x4a
function getzeroarray( size, var_8c2d7efc6766a2ed )
{
    newarray = [];
    newarray[ 0 ] = var_8c2d7efc6766a2ed;
    
    for ( i = 1; i < size ; i++ )
    {
        newarray[ newarray.size ] = 0;
    }
    
    return newarray;
}

// Namespace br_circle
// Params 0
// Checksum 0xd7e5666c, Offset: 0x1d63
// Size: 0xe
function function_99d7e80e97d57e3d()
{
    return self.origin[ 2 ];
}

// Namespace br_circle
// Params 0
// Checksum 0xb7f280b9, Offset: 0x1d7a
// Size: 0x79
function getsafecircleorigin()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        return ( level.br_circle.safecircleent.origin[ 0 ], level.br_circle.safecircleent.origin[ 1 ], 0 );
    }
    
    return ( 0, 0, 0 );
}

// Namespace br_circle
// Params 0
// Checksum 0x9f70a001, Offset: 0x1dfb
// Size: 0x4c
function getsafecircleradius()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        return level.br_circle.safecircleent.origin[ 2 ];
    }
    
    return 0;
}

// Namespace br_circle
// Params 0
// Checksum 0xed4d46d2, Offset: 0x1e4f
// Size: 0x79
function getdangercircleorigin()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        return ( level.br_circle.dangercircleent.origin[ 0 ], level.br_circle.dangercircleent.origin[ 1 ], 0 );
    }
    
    return ( 0, 0, 0 );
}

// Namespace br_circle
// Params 0
// Checksum 0x847ef204, Offset: 0x1ed0
// Size: 0x4c
function getdangercircleradius()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        return level.br_circle.dangercircleent.origin[ 2 ];
    }
    
    return 0;
}

// Namespace br_circle
// Params 0
// Checksum 0xd8d2953b, Offset: 0x1f24
// Size: 0x59
function getnextsafecircleorigin()
{
    var_e608edf69e913c66 = level.br_circle.circleindex + 2;
    
    if ( var_e608edf69e913c66 < level.br_level.br_circlecenters.size )
    {
        return level.br_level.br_circlecenters[ var_e608edf69e913c66 ];
    }
    
    return;
}

// Namespace br_circle
// Params 0
// Checksum 0x3d5fad7f, Offset: 0x1f85
// Size: 0x59
function getnextsafecircleradius()
{
    var_e608edf69e913c66 = level.br_circle.circleindex + 2;
    
    if ( var_e608edf69e913c66 < level.br_level.br_circleradii.size )
    {
        return level.br_level.br_circleradii[ var_e608edf69e913c66 ];
    }
    
    return;
}

// Namespace br_circle
// Params 0
// Checksum 0x846d43a3, Offset: 0x1fe6
// Size: 0x51
function function_9eac7d8c846aabd0()
{
    if ( function_cd50329a10799649() && ( level.br_level.var_7a7b3389cf47133f ?? 0 ) > 0 )
    {
        return ( level.br_level.br_circleclosetimes.size - level.br_level.var_7a7b3389cf47133f );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x6131ce37, Offset: 0x2040
// Size: 0x51
function function_9448d46c0e4395c1()
{
    if ( function_cd50329a10799649() && ( level.br_level.br_numcirclesfollowtrain ?? 0 ) > 0 )
    {
        return ( level.br_level.br_circleclosetimes.size - level.br_level.br_numcirclesfollowtrain );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0xa76d9a8e, Offset: 0x209a
// Size: 0x2a, Type: bool
function function_a860b6cc615c4bdb( circleindex )
{
    firstindex = function_9448d46c0e4395c1();
    
    if ( isdefined( firstindex ) )
    {
        return ( circleindex >= firstindex );
    }
    
    return false;
}

// Namespace br_circle
// Params 0
// Checksum 0x7cd5b1d0, Offset: 0x20cd
// Size: 0x38, Type: bool
function canseesafecircleui()
{
    return isdefined( level.br_circle.safecircleent ) && !level.br_circle.safecircleent.hidden;
}

// Namespace br_circle
// Params 0
// Checksum 0x534c72bc, Offset: 0x210e
// Size: 0x38, Type: bool
function canseedangercircleui()
{
    return isdefined( level.br_circle.dangercircleent ) && !level.br_circle.dangercircleent.hidden;
}

// Namespace br_circle
// Params 0
// Checksum 0xe8352a06, Offset: 0x214f
// Size: 0x85
function playercanseedangercircleworld()
{
    if ( self.wasingulag )
    {
        return 0;
    }
    
    if ( self.gulag )
    {
        if ( self.gulagarena || self.jailed || self.playinggulagbink )
        {
            return 0;
        }
    }
    
    if ( self.brwinnerscircle )
    {
        return 0;
    }
    
    var_7237854e3be197ca = utility::callsharedfunc( #"gametype", #"hash_635ab7086e09b95a" );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return canseedangercircleui();
}

// Namespace br_circle
// Params 2
// Checksum 0x949e5c5e, Offset: 0x21dd
// Size: 0x93, Type: bool
function cancircledamageplayer( player, var_a615ecfbb607a52c )
{
    var_a615ecfbb607a52c = var_a615ecfbb607a52c ?? player.origin;
    return isalive( player ) && player playercanseedangercircleworld() && !player.gulag && !player.inrespawnc130 && !player br_public::playeriszombie() && !isdefined( player.c130 ) && ( !br_circle_util::function_4c6afbf2b757376a( var_a615ecfbb607a52c, 0 ) || br_circle_util::function_4c6afbf2b757376a( var_a615ecfbb607a52c, 1 ) );
}

// Namespace br_circle
// Params 1
// Checksum 0x6175d3f5, Offset: 0x2279
// Size: 0x19b
function tryplaycoughaudio( var_4d4ea97287df7e3a )
{
    player = self;
    
    if ( !player player::isreallyalive() )
    {
        return;
    }
    
    if ( player.extracted )
    {
        return;
    }
    
    if ( !isdefined( player.operatorcustomization ) )
    {
        return;
    }
    
    if ( player killstreak::isjuggernaut() )
    {
        return;
    }
    
    if ( gettime() < player.brcirclecoughnexttime )
    {
        return;
    }
    
    var_6adc81daededc882 = randomintrange( 5000, 7000 );
    
    if ( isdefined( var_4d4ea97287df7e3a ) )
    {
        var_6adc81daededc882 = var_4d4ea97287df7e3a;
    }
    
    player.brcirclecoughnexttime = gettime() + var_6adc81daededc882;
    
    if ( !isai( player ) )
    {
        player playsoundtoplayer( "gas_player_cough", player, player );
    }
    
    var_553ba779c31e442 = "allies_male_cough";
    operatorteam = br_public::brgetoperatorteam( player );
    
    if ( operatorteam == "axis" )
    {
        if ( player operator::isfemale() )
        {
            var_553ba779c31e442 = "axis_female_cough";
        }
        else
        {
            var_553ba779c31e442 = "axis_male_cough";
        }
    }
    else if ( player operator::isfemale() )
    {
        var_553ba779c31e442 = "allies_female_cough";
    }
    else
    {
        var_553ba779c31e442 = "allies_male_cough";
    }
    
    var_8d27e0901584cdf7 = randomint( game[ "dialogue" ][ var_553ba779c31e442 ].size );
    coughsoundalias = game[ "dialogue" ][ var_553ba779c31e442 ][ var_8d27e0901584cdf7 ];
    
    if ( isdefined( player ) && player player::isreallyalive() )
    {
        player playsoundtoteam( coughsoundalias, game[ "attackers" ], player, player );
        player playsoundtoteam( coughsoundalias, game[ "defenders" ], player, player );
        
        if ( level.br_circle.var_a316f0f6121d5abd )
        {
            player thread function_609e9d6d7f9935ff();
        }
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x6e3dce78, Offset: 0x241c
// Size: 0x143
function function_609e9d6d7f9935ff()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    players_nearby = getplayersinradius( player.origin, level.br_circle.var_e0a093ff48d4512, level.var_9d2af55ce6b7b87d, 0, player );
    teams_nearby = [];
    
    foreach ( player_nearby in players_nearby )
    {
        teams_nearby = arraycombineunique( teams_nearby, [ player_nearby.team ] );
        player.var_22750a5d42d618f9[ player_nearby getentitynumber() ] = gettime();
    }
    
    if ( teams_nearby.size <= 0 )
    {
        return;
    }
    
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 1 );
    waitframe();
    player function_71c7c5be98d11198( teams_nearby, level.br_circle.var_218f8c7ea7365164, 1 );
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 0 );
}

// Namespace br_circle
// Params 0
// Checksum 0x566b3764, Offset: 0x2567
// Size: 0xc4
function function_c35a754faad844f9()
{
    player = self;
    player endon( #"hash_f94cc10797ca601d" );
    
    if ( !getdvarint( @"hash_5c784f7a2a4d3851", 1 ) )
    {
        return;
    }
    
    if ( !( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.var_e022d9f89cd838bf ) && isdefined( level.gamemodebundle.var_196c42c2bfaca663 ) ) || player.var_e022d9f89cd838bf )
    {
        return;
    }
    
    player.var_e022d9f89cd838bf = 1;
    player shellshock_utility_cpmp::_shellshock( level.gamemodebundle.var_e022d9f89cd838bf, #"gas", level.gamemodebundle.var_196c42c2bfaca663, 1 );
}

// Namespace br_circle
// Params 0
// Checksum 0x8417d596, Offset: 0x2633
// Size: 0x54
function function_7877e6f8368fbec2()
{
    player = self;
    
    if ( !getdvarint( @"hash_5c784f7a2a4d3851", 1 ) )
    {
        return;
    }
    
    if ( !player.var_e022d9f89cd838bf )
    {
        return;
    }
    
    player notify( #"hash_f94cc10797ca601d" );
    shellshock_utility_cpmp::_stopshellshock();
    player.var_e022d9f89cd838bf = 0;
}

// Namespace br_circle
// Params 0
// Checksum 0x49851f66, Offset: 0x268f
// Size: 0x12, Type: bool
function function_28022533626c7db1()
{
    return getdvarint( @"hash_e3e49befc1ddb73d", 0 ) != 0;
}

// Namespace br_circle
// Params 0
// Checksum 0xc40c2cb1, Offset: 0x26aa
// Size: 0x1b
function function_7c8eed6cfb6b2ae2()
{
    if ( function_28022533626c7db1() )
    {
        thread hud_message::showsplash( #"hash_11478e5d18b62b91" );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x4c49a117, Offset: 0x26cd
// Size: 0x59
function function_37a534e2ce4843e()
{
    if ( !isdefined( self.var_2f8b6417bc00b4a0 ) )
    {
        self.var_2f8b6417bc00b4a0 = gettime();
        self.var_5bc7e5e30914b70d = self.var_2f8b6417bc00b4a0;
        val::set( "br_circle", "show_ui_gasmask_overlay", 1 );
        function_7c8eed6cfb6b2ae2();
        callback::callback( #"hash_2fd481f23e5e677a" );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0xa61f7bff, Offset: 0x272e
// Size: 0x52
function function_15ffd24619fcfc01()
{
    var_fcba65208c7cd4a9 = isdefined( self.var_2f8b6417bc00b4a0 );
    self.var_2f8b6417bc00b4a0 = undefined;
    self.var_5bc7e5e30914b70d = undefined;
    val::reset( "br_circle", "show_ui_gasmask_overlay" );
    
    if ( var_fcba65208c7cd4a9 )
    {
        callback::callback( #"hash_6dd1d7b87f599c7c" );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x9e7fbd80, Offset: 0x2788
// Size: 0x75
function function_a1994b835c9c1590()
{
    if ( !isdefined( self.var_2f8b6417bc00b4a0 ) )
    {
        return;
    }
    
    now = gettime();
    lasttick = self.var_5bc7e5e30914b70d ?? self.var_2f8b6417bc00b4a0;
    delta = now - lasttick;
    
    if ( delta > 0 )
    {
        self.var_2f8b6417bc00b4a0 += delta;
    }
    
    self.var_5bc7e5e30914b70d = now;
}

// Namespace br_circle
// Params 0
// Checksum 0x6890f910, Offset: 0x2805
// Size: 0x1e
function function_f7798f06003358e2()
{
    if ( !isdefined( self.var_2f8b6417bc00b4a0 ) )
    {
        return;
    }
    
    self.var_5bc7e5e30914b70d = gettime();
}

// Namespace br_circle
// Params 1
// Checksum 0x9e13629, Offset: 0x282b
// Size: 0x49
function relocatecircles( var_c7b9fbbb249b7a30 )
{
    level endon( #"game_ended" );
    level notify( #"br_circle_relocation" );
    level _precalcsafecirclecenters( var_c7b9fbbb249b7a30, undefined, undefined, 1 );
    level br_multi_circle::function_b8bba7914486922b( 1 );
    level callback::callback( "circle_relocation" );
}

// Namespace br_circle
// Params 0
// Checksum 0x3f1bff00, Offset: 0x287c
// Size: 0x1b0
function function_60fec44444cbd5d2()
{
    defaulttimes = [ 35, 50, 65, 80 ];
    var_98d20aa66d8439f2 = [ 2, 4, 6, 10 ];
    assert( defaulttimes.size == var_98d20aa66d8439f2.size );
    data = spawnstruct();
    data.enabled = getdvarint( @"hash_a4814b42abcaa1d7", 1 );
    data.var_4fede1a43bc36ae9 = getdvarint( @"hash_8799dcded2374711", 4 );
    data.timeinseconds = [];
    data.multipliers = [];
    curtime = 0;
    curmult = 1;
    
    for ( i = 0; i < data.var_4fede1a43bc36ae9 ; i++ )
    {
        defaulttime = undefined;
        defaultmult = undefined;
        
        if ( i < defaulttimes.size )
        {
            defaulttime = defaulttimes[ i ];
            defaultmult = var_98d20aa66d8439f2[ i ];
            curtime = defaulttime;
            curmult = defaultmult;
        }
        else
        {
            curtime += 1;
            curmult += 1;
            defaulttime = curtime;
            defaultmult = curmult;
        }
        
        data.timeinseconds[ i ] = getdvarfloat( hashcat( @"hash_1e5bced3bad4bb2c", i + 1 ), defaulttime );
        data.multipliers[ i ] = getdvarfloat( hashcat( @"hash_73aa78457e1fa15d", i + 1 ), defaultmult );
    }
    
    return data;
}

// Namespace br_circle
// Params 0
// Checksum 0x38c560f6, Offset: 0x2a35
// Size: 0xa9
function function_592a1188adc2f827()
{
    circleindex = level.br_circle.circleindex;
    
    if ( !isdefined( circleindex ) || circleindex < 0 )
    {
        return 0;
    }
    
    if ( circleindex > level.br_circle.damagetick.size - 1 )
    {
        circleindex = level.br_circle.damagetick.size - 1;
    }
    
    damagetick = level.br_circle.damagetick[ circleindex ];
    
    if ( isdefined( level.circledamagemultiplier ) )
    {
        damagetick = int( damagetick * level.circledamagemultiplier );
    }
    
    return damagetick;
}

// Namespace br_circle
// Params 2
// Checksum 0x472d6ac8, Offset: 0x2ae7
// Size: 0xbf
function function_eaac348121cbeb8c( data, damagetick )
{
    if ( !data.enabled )
    {
        return damagetick;
    }
    
    if ( !isdefined( self.var_2f8b6417bc00b4a0 ) )
    {
        return damagetick;
    }
    
    var_15e482ac17bd9341 = ( gettime() - self.var_2f8b6417bc00b4a0 ) * 0.001;
    
    for ( i = data.var_4fede1a43bc36ae9 - 1; i >= 0 ; i-- )
    {
        curtime = data.timeinseconds[ i ];
        
        if ( var_15e482ac17bd9341 >= curtime )
        {
            curmult = data.multipliers[ i ];
            return int( damagetick * curmult );
        }
    }
    
    return damagetick;
}

// Namespace br_circle
// Params 3
// Checksum 0x34aaff34, Offset: 0x2baf
// Size: 0x6f, Type: bool
function function_6bf5d4e680297398( origin, dangercircleorigin, dangercircleradius )
{
    /#
        if ( level.mapname == "<dev string:x24>" && getdvarint( @"hash_97ab1e3e328ddff9", 0 ) == 0 )
        {
            return false;
        }
    #/
    
    if ( !isdefined( dangercircleorigin ) )
    {
        dangercircleorigin = getdangercircleorigin();
    }
    
    if ( !isdefined( dangercircleradius ) )
    {
        dangercircleradius = getdangercircleradius();
    }
    
    return distance2dsquared( dangercircleorigin, origin ) > dangercircleradius * dangercircleradius;
}

// Namespace br_circle
// Params 1
// Checksum 0x2e25c0c4, Offset: 0x2c27
// Size: 0xb5, Type: bool
function ispointwithininitialdangercircle( origin )
{
    if ( !( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) && isdefined( level.br_level.br_circleradii ) ) )
    {
        return true;
    }
    
    var_fc831e535e80517b = ( level.br_level.br_circlecenters[ 0 ][ 0 ], level.br_level.br_circlecenters[ 0 ][ 1 ], 0 );
    var_27fca4ef122e54e7 = squared( level.br_level.br_circleradii[ 0 ] );
    return distance2dsquared( var_fc831e535e80517b, origin ) < var_27fca4ef122e54e7;
}

// Namespace br_circle
// Params 0
// Checksum 0xf48449ce, Offset: 0x2ce5
// Size: 0x59c
function circledamagetick()
{
    level endon( #"game_ended" );
    level endon( #"hash_87ff3ffade90233e" );
    
    while ( level.br_circle.circleindex < 0 )
    {
        waitframe();
    }
    
    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        level waittill( #"infils_ready" );
    }
    
    circledelaytime = level.br_level.br_circledelaytimes[ 0 ];
    circlefadeduration = level.br_circle.fadedurationsec;
    function_3cd2087fed4e663a( circledelaytime, circlefadeduration, 0, 1 );
    thresholdradius = getdvarfloat( @"scr_br_circle_object_cleanup_threshold", 1000 );
    var_16fa12dd34d85976 = function_60fec44444cbd5d2();
    
    while ( true )
    {
        if ( isdefined( level.br_circle.dangercircleent ) )
        {
            index = level.br_circle.circleindex;
            damagetick = function_592a1188adc2f827();
            
            if ( damagetick > 0 )
            {
                dangercircleorigin = getdangercircleorigin();
                dangercircleradius = getdangercircleradius();
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( player ) && player getinairpocket() )
                    {
                        continue;
                    }
                    
                    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) && player.plotarmor )
                    {
                        player function_15ffd24619fcfc01();
                        
                        if ( getdvarint( @"hash_acff883bb1879e40", 0 ) )
                        {
                            logstring( "CIRCLE DAMAGE LOGGING: Resetting player gas timer for " + player.name + " during circle index " + index + "for circleEarlyStart and plotArmor." );
                        }
                        
                        continue;
                    }
                    
                    var_d3d5e207911ff294 = 0;
                    var_ab48f32caa0a08a0 = player.origin;
                    
                    if ( utility::issharedfuncdefined( #"gametype", #"hash_cb7f08e35dbda7cf" ) )
                    {
                        var_ab48f32caa0a08a0 = player utility::callsharedfunc( #"gametype", #"hash_cb7f08e35dbda7cf" );
                    }
                    
                    if ( function_6bf5d4e680297398( var_ab48f32caa0a08a0, dangercircleorigin, dangercircleradius ) )
                    {
                        if ( player cancircledamageplayer( player, var_ab48f32caa0a08a0 ) )
                        {
                            var_d3d5e207911ff294 = 1;
                            player function_37a534e2ce4843e();
                            
                            if ( getdvarint( @"scr_time_in_gas_damage_modifier_enabled", 0 ) == 1 )
                            {
                                modifieddamagetick = player function_eaac348121cbeb8c( var_16fa12dd34d85976, damagetick );
                            }
                            else
                            {
                                modifieddamagetick = damagetick;
                            }
                            
                            gasmaskdamage = modifieddamagetick;
                            
                            if ( isdefined( level.var_8939aaad719c1058 ) && isdefined( level.var_a497e1f1038f9d84 ) && level.br_circle.circleindex <= level.var_8939aaad719c1058 )
                            {
                                gasmaskdamage *= level.var_a497e1f1038f9d84;
                            }
                            
                            var_2750d2ea26afa177 = 0;
                            
                            if ( gasmask::hasgasmask( player ) )
                            {
                                var_2750d2ea26afa177 = 1;
                                
                                if ( br_pickups::function_8bb363a772f35700( player ) )
                                {
                                    if ( player.var_ccaedd955fabd3b4 )
                                    {
                                        player notify( #"gasmask_buffer_reset" );
                                    }
                                    else if ( level.var_48fc5a6351d1343c > 0 )
                                    {
                                        player.var_ccaedd955fabd3b4 = 1;
                                        player thread br_pickups::function_cde7bb308b1cf12f();
                                    }
                                }
                                
                                if ( player.var_ccaedd955fabd3b4 )
                                {
                                    if ( !player.gasmaskequipped )
                                    {
                                        player function_b591cdbc3dcd9112( modifieddamagetick );
                                    }
                                    
                                    player gasmask::processdamage( gasmaskdamage );
                                }
                                else if ( player.gasmaskhealth <= 0 )
                                {
                                    player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    player br_pickups::function_5375ae93bfe708df();
                                    player br_pickups::function_219547e563ff9527();
                                }
                                else
                                {
                                    player br_pickups::gasmaskon( "br_circle" );
                                    player gasmask::processdamage( gasmaskdamage );
                                }
                            }
                            else
                            {
                                player function_b591cdbc3dcd9112( modifieddamagetick );
                            }
                            
                            if ( var_2750d2ea26afa177 )
                            {
                                player function_a1994b835c9c1590();
                            }
                            else
                            {
                                player function_f7798f06003358e2();
                            }
                            
                            if ( common_inventory::function_5c64d2b24a8c3e18() )
                            {
                                player common_inventory::function_6525f6bbec67b15e( level.var_6a8b6f867f6e7ad4, gasmaskdamage );
                            }
                        }
                        else
                        {
                            if ( getdvarint( @"hash_acff883bb1879e40", 0 ) )
                            {
                                logstring( "CIRCLE DAMAGE LOGGING: Resetting player gas timer for " + player.name + " during circle index " + index + "for failing canCircleDamagePlayer check." );
                            }
                            
                            player function_15ffd24619fcfc01();
                            player function_7877e6f8368fbec2();
                        }
                    }
                    else
                    {
                        player function_15ffd24619fcfc01();
                        player function_7877e6f8368fbec2();
                        
                        if ( gasmask::hasgasmask( player ) )
                        {
                            if ( br_pickups::function_8bb363a772f35700( player ) )
                            {
                                if ( player.var_ccaedd955fabd3b4 )
                                {
                                    player notify( #"gasmask_buffer_reset" );
                                }
                                else if ( level.var_48fc5a6351d1343c > 0 )
                                {
                                    player.var_ccaedd955fabd3b4 = 1;
                                    player thread br_pickups::function_cde7bb308b1cf12f();
                                }
                            }
                            
                            if ( player.var_ccaedd955fabd3b4 )
                            {
                                continue;
                            }
                            else if ( player.gasmaskhealth <= 0 )
                            {
                                player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                player br_pickups::function_5375ae93bfe708df();
                            }
                            else
                            {
                                player br_pickups::gasmaskoff( "br_circle" );
                            }
                        }
                    }
                    
                    if ( isbrgamemode() )
                    {
                        player updateindangercirclestate( var_d3d5e207911ff294 );
                    }
                }
                
                if ( !br_circle_util::function_32ead8efde5943f5() )
                {
                    br_circle_util::function_d9144b81cd9502a9( dangercircleorigin, dangercircleradius, thresholdradius );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x4aa94267, Offset: 0x3289
// Size: 0x1a8
function function_b591cdbc3dcd9112( modifieddamagetick )
{
    player = self;
    
    if ( isdefined( level.modifybrgasdamage ) )
    {
        modifieddamagetick = player [[ level.modifybrgasdamage ]]( modifieddamagetick );
    }
    
    if ( player killstreak::isjuggernaut() )
    {
        modifieddamagetick = juggernaut::function_9d3c45be0af60321( modifieddamagetick );
    }
    
    if ( player ismeatshieldvictim() )
    {
        modifieddamagetick *= level.meatshieldhealthscale ?? 1;
    }
    
    finalperc = 1;
    
    if ( isdefined( player.var_8ee8efc2c797c4a ) )
    {
        finalperc += player.var_8ee8efc2c797c4a;
    }
    
    if ( player.var_a5ac861674d151de )
    {
        finalperc += player.var_a5ac861674d151de;
    }
    
    modifieddamagetick *= finalperc;
    
    if ( getdvarint( @"hash_acff883bb1879e40", 0 ) && modifieddamagetick <= 0 )
    {
        logstring( "CIRCLE DAMAGE LOGGING: Logging modifiedDamageTick of zero for " + player.name + "." );
    }
    
    var_1cb6b6bbdfc6eee7 = 0;
    
    if ( utility::issharedfuncdefined( #"activity_cradle_gas", #"hash_89cf90274de1da20" ) )
    {
        var_1cb6b6bbdfc6eee7 = utility::callsharedfunc( #"activity_cradle_gas", #"hash_89cf90274de1da20", player.origin );
    }
    
    dflags = undefined;
    
    if ( var_1cb6b6bbdfc6eee7 )
    {
        dflags = 4194304;
    }
    
    player dodamage( modifieddamagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br", "none", undefined, dflags );
    player armor::damagearmor( modifieddamagetick );
    
    if ( !level.gametypebundle.var_65d2db5ddbc5f88b )
    {
        player tryplaycoughaudio();
    }
    
    player function_c35a754faad844f9();
}

// Namespace br_circle
// Params 1
// Checksum 0x885e983c, Offset: 0x3439
// Size: 0xd8
function updateindangercirclestate( isincircle )
{
    if ( !isdefined( self.isincircle ) )
    {
        self.isincircle = isincircle;
        self.lastcircleeventtime = gettime();
    }
    
    if ( self.isincircle != isincircle )
    {
        self.isincircle = isincircle;
        perkfunctions::outlander_updatemovespeed();
        currenttime = gettime();
        
        if ( isincircle )
        {
            br_analytics::branalytics_circleenter( self, currenttime - self.lastcircleeventtime );
            br_ftue_popups::ftue_triggertip( "br_ftue_gas" );
            
            if ( self.gasmaskequipped )
            {
                self clearsoundsubmix( "wz2_fly_gasmask" );
            }
        }
        else
        {
            br_analytics::branalytics_circleexit( self, currenttime - self.lastcircleeventtime );
            
            if ( self.gasmaskequipped )
            {
                self setsoundsubmix( "wz2_fly_gasmask" );
            }
        }
        
        self.lastcircleeventtime = currenttime;
    }
}

// Namespace br_circle
// Params 5
// Checksum 0xcbff05cd, Offset: 0x3519
// Size: 0x45c
function startuiclosetimer( waittime, var_fade5044da9ae670, var_b2827c0c6de965f2, circleindex, skipsplash )
{
    level endon( #"game_ended" );
    
    if ( !level.var_b30d3cfccd6d0b0f )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( waittime * 1000 ) );
    }
    
    var_8951c88675abbc66 = function_8bdcbb2e3fe350() || game_utility::getgametype() == "zxp" || game_utility::getgametype() == "plunder";
    
    if ( !var_fade5044da9ae670 && !skipsplash )
    {
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && !player br_public::isplayeringulag() )
            {
                if ( utility::issharedfuncdefined( #"gametype", #"hash_e02f140c76607c7d" ) )
                {
                    utility::callsharedfunc( #"gametype", #"hash_e02f140c76607c7d" );
                    continue;
                }
                
                if ( var_b2827c0c6de965f2 )
                {
                    if ( getdvarint( @"hash_ad4aed3730427bc5", 1 ) )
                    {
                        player thread hud_message::showsplash( "br_final_circle_buystations_disabled" );
                    }
                    else
                    {
                        player thread hud_message::showsplash( "br_final_circle" );
                    }
                    
                    continue;
                }
                
                if ( !var_8951c88675abbc66 || circleindex > 1 )
                {
                    player thread hud_message::showsplash( "br_new_circle" );
                }
            }
        }
    }
    
    if ( !isdefined( level.chokeholdcircle ) )
    {
        if ( var_b2827c0c6de965f2 )
        {
            setomnvar( "ui_br_circle_state", 3 );
        }
        else
        {
            setomnvar( "ui_br_circle_state", 0 );
        }
    }
    
    var_bdb61cc517e4942d = var_b2827c0c6de965f2 && level.br_circle.var_bdb61cc517e4942d && !( isdefined( level.isstandardsandbox ) && !level.isstandardsandbox );
    
    if ( var_bdb61cc517e4942d )
    {
        level thread music_br::function_fe87426d6e01e1a5( level.br_circle.circleindex, level.br_level.br_circleclosetimes.size );
    }
    
    remindertimes = [ 60, 30, 20, 10, 0 ];
    startindex = remindertimes.size - 1;
    
    for ( i = 0; i < remindertimes.size ; i++ )
    {
        if ( waittime > remindertimes[ i ] )
        {
            startindex = i;
            break;
        }
    }
    
    if ( waittime < remindertimes[ startindex ] )
    {
        return;
    }
    
    wait waittime - remindertimes[ startindex ];
    
    for ( i = startindex; i < remindertimes.size - 1 ; i++ )
    {
        if ( i == 2 )
        {
            var_bdb61cc517e4942d = !var_b2827c0c6de965f2 && level.br_circle.var_bdb61cc517e4942d && !( isdefined( level.isstandardsandbox ) && !level.isstandardsandbox );
            
            if ( var_bdb61cc517e4942d )
            {
                level thread music_br::function_fe87426d6e01e1a5( level.br_circle.circleindex, level.br_level.br_circleclosetimes.size );
            }
        }
        
        if ( i == 3 )
        {
            if ( !isdefined( level.chokeholdcircle ) )
            {
                setomnvar( "ui_br_circle_state", 2 );
            }
        }
        
        wait remindertimes[ i ] - remindertimes[ i + 1 ];
    }
    
    level notify( #"br_circle_closing" );
    codcaster_utils::function_3038b6eafc46c037( 0 );
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && !player br_public::isplayeringulag() && ( !var_8951c88675abbc66 || circleindex > 0 ) && !skipsplash )
        {
            player thread hud_message::showsplash( "br_circle_moving" );
            player br_ftue_popups::ftue_triggertip( "br_ftue_circle" );
        }
    }
    
    if ( !isdefined( level.chokeholdcircle ) )
    {
        setomnvar( "ui_br_circle_state", 1 );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x6673165f, Offset: 0x397d
// Size: 0x19
function _hidesafecircleui()
{
    setomnvar( "ui_br_circle0_start_time", 0 );
    setomnvar( "ui_br_circle0_duration", 1 );
}

// Namespace br_circle
// Params 1
// Checksum 0x1925b8cb, Offset: 0x399e
// Size: 0x24
function setpreviewuicircle( safecircleent )
{
    setomnvar( "ui_br_circle0_start_entity", safecircleent );
    setomnvar( "ui_br_circle0_end_entity", safecircleent );
}

// Namespace br_circle
// Params 4
// Checksum 0xc85ae29f, Offset: 0x39ca
// Size: 0xbe
function setstaticuicircles( duration, safecircleent, var_2416571fce2a1220, var_b2827c0c6de965f2 )
{
    circleduration = function_bd089538e624a41a( duration );
    setomnvar( "ui_br_circle0_start_time", gettime() );
    setomnvar( "ui_br_circle0_duration", circleduration );
    setomnvar( "ui_br_circle0_start_entity", safecircleent );
    setomnvar( "ui_br_circle0_end_entity", safecircleent );
    
    if ( var_b2827c0c6de965f2 )
    {
        _hidesafecircleui();
    }
    
    circleduration = function_679d03d3bcd0aadc( duration );
    setomnvar( "ui_br_circle1_start_time", gettime() );
    setomnvar( "ui_br_circle1_duration", circleduration );
    setomnvar( "ui_br_circle1_start_entity", var_2416571fce2a1220 );
    setomnvar( "ui_br_circle1_end_entity", var_2416571fce2a1220 );
    thread updatecirclehide( duration );
}

// Namespace br_circle
// Params 4
// Checksum 0xd4402577, Offset: 0x3a90
// Size: 0xbe
function setclosinguicircle( duration, safecircleent, var_2416571fce2a1220, var_b2827c0c6de965f2 )
{
    circleduration = function_bd089538e624a41a( duration );
    setomnvar( "ui_br_circle0_start_time", gettime() );
    setomnvar( "ui_br_circle0_duration", circleduration );
    setomnvar( "ui_br_circle0_start_entity", safecircleent );
    setomnvar( "ui_br_circle0_end_entity", safecircleent );
    
    if ( var_b2827c0c6de965f2 )
    {
        _hidesafecircleui();
    }
    
    circleduration = function_679d03d3bcd0aadc( duration );
    setomnvar( "ui_br_circle1_start_time", gettime() );
    setomnvar( "ui_br_circle1_duration", circleduration );
    setomnvar( "ui_br_circle1_start_entity", var_2416571fce2a1220 );
    setomnvar( "ui_br_circle1_end_entity", safecircleent );
    thread updatecirclehide( duration );
}

// Namespace br_circle
// Params 1
// Checksum 0xf53f0d, Offset: 0x3b56
// Size: 0x7b
function updatecirclehide( duration )
{
    level notify( #"hash_b806d01795ce530a" );
    level endon( #"hash_b806d01795ce530a" );
    
    while ( true )
    {
        level waittill( #"hash_7f6b2a7b2d05df3e" );
        circleduration = function_bd089538e624a41a( duration );
        setomnvar( "ui_br_circle0_duration", circleduration );
        circleduration = function_679d03d3bcd0aadc( duration );
        setomnvar( "ui_br_circle1_duration", circleduration );
        level notify( #"hash_d6cd3354841442ca" );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x260640c2, Offset: 0x3bd9
// Size: 0x25
function function_679d03d3bcd0aadc( default_duration )
{
    if ( canseedangercircleui() )
    {
        return int( default_duration * 1000 );
    }
    
    return 0;
}

// Namespace br_circle
// Params 1
// Checksum 0x5e75b0ad, Offset: 0x3c06
// Size: 0x25
function function_bd089538e624a41a( default_duration )
{
    if ( canseesafecircleui() )
    {
        return int( default_duration * 1000 );
    }
    
    return 0;
}

// Namespace br_circle
// Params 0
// Checksum 0xf9f1bec, Offset: 0x3c33
// Size: 0x5e, Type: bool
function islastcircle()
{
    return level.br_circle.circleindex >= level.br_level.br_circleradii.size - 1 || !( level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ] > 0 );
}

// Namespace br_circle
// Params 2
// Checksum 0x6818dd1c, Offset: 0x3c9a
// Size: 0x8d
function gettimetillcircleclosing( circleindex, timeoffset )
{
    assert( circleindex >= 0 );
    
    if ( !isdefined( timeoffset ) )
    {
        timeoffset = 0;
    }
    
    circlestart = level.br_circle.starttime / 1000;
    timefrom = gettime() / 1000 + timeoffset;
    timeremaining = timefrom - circlestart - level.br_level.br_circledelaytimes[ circleindex ];
    return max( timeremaining, 0 );
}

// Namespace br_circle
// Params 2
// Checksum 0x986dedb1, Offset: 0x3d30
// Size: 0x8d
function function_bb029e29e4b5fa38( circleindex, timeoffset )
{
    assert( circleindex >= 0 );
    
    if ( !isdefined( timeoffset ) )
    {
        timeoffset = 0;
    }
    
    circlestart = level.br_circle.starttime / 1000;
    timefrom = gettime() / 1000 + timeoffset;
    timeremaining = timefrom - circlestart - level.br_level.br_circleclosetimes[ circleindex ];
    return max( timeremaining, 0 );
}

// Namespace br_circle
// Params 1
// Checksum 0x60874332, Offset: 0x3dc6
// Size: 0x6a
function circleduration( circleindex )
{
    assert( circleindex >= 0 );
    delaytime = level.br_level.br_circledelaytimes[ circleindex ];
    closetime = level.br_level.br_circleclosetimes[ circleindex ];
    totaltime = delaytime + closetime;
    return totaltime;
}

// Namespace br_circle
// Params 0
// Checksum 0x42693748, Offset: 0x3e39
// Size: 0x79
function function_f30ad5eda1a16d44()
{
    curcircleindex = level.br_circle.circleindex;
    var_68ed9d341a4fee90 = circleduration( curcircleindex );
    var_be1f8b0f54852bbb = level.br_circle.starttime / 1000;
    var_e2cfe32fe1c70427 = gettime() / 1000 - var_be1f8b0f54852bbb;
    assert( var_e2cfe32fe1c70427 >= 0 );
    return var_68ed9d341a4fee90 - var_e2cfe32fe1c70427;
}

// Namespace br_circle
// Params 3
// Checksum 0x372333d6, Offset: 0x3ebb
// Size: 0x31b
function function_4f1b5201e3062411( player, var_566819e204437d34, timeoffset )
{
    var_5cbb6fb07c209bb5 = arrayrandomize( teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid, 1 ) );
    targetsquadmember = undefined;
    
    foreach ( squadmember in var_5cbb6fb07c209bb5 )
    {
        if ( squadmember != player )
        {
            targetsquadmember = squadmember;
            break;
        }
    }
    
    if ( !isdefined( targetsquadmember ) )
    {
        return;
    }
    
    point = targetsquadmember.origin;
    currcircleindex = level.br_circle.circleindex;
    var_2d428d80b5b6d5f1 = gettimetillcircleclosing( currcircleindex, var_566819e204437d34 + timeoffset );
    nextcircleindex = int( min( currcircleindex + 1, level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount - 1 ) );
    currcircleclosetime = level.br_level.br_circleclosetimes[ currcircleindex ];
    var_abd6c870dd24b7c7 = level.br_level.br_circlecenters[ currcircleindex ];
    currcircleradius = level.br_level.br_circleradii[ currcircleindex ];
    nextcirclecenter = level.br_level.br_circlecenters[ nextcircleindex ];
    nextcircleradius = level.br_level.br_circleradii[ nextcircleindex ];
    closingspeedcenter = ( nextcirclecenter - var_abd6c870dd24b7c7 ) / currcircleclosetime;
    var_a9db1aded4c39d1e = ( nextcircleradius - currcircleradius ) / currcircleclosetime;
    var_b818a959976989aa = var_abd6c870dd24b7c7 + closingspeedcenter * var_2d428d80b5b6d5f1;
    targetcircleradius = currcircleradius + var_a9db1aded4c39d1e * var_2d428d80b5b6d5f1;
    dist = distance2d( point, var_b818a959976989aa );
    checkbadcircles = getdvarint( @"hash_7525f014f690c068", 0 );
    distaway = getdvarfloat( @"hash_f8eebbe68b000328", 1000 );
    targetpoint = point + ( var_b818a959976989aa - point ) * distaway / dist;
    
    if ( isvalidpointinbounds( targetpoint, checkbadcircles, var_566819e204437d34 + timeoffset ) )
    {
        return targetpoint;
    }
    
    var_1ab9d5541ebc6762 = getdvarfloat( @"hash_921a01e1bee01d8b", 0.5 );
    distaway = dist * var_1ab9d5541ebc6762;
    targetpoint = point + ( var_b818a959976989aa - point ) * distaway / dist;
    
    if ( isvalidpointinbounds( targetpoint, checkbadcircles, var_566819e204437d34 + timeoffset ) )
    {
        return targetpoint;
    }
    
    vector = point - var_b818a959976989aa;
    targetpoint = var_b818a959976989aa + targetcircleradius / dist * vector;
    
    if ( isvalidpointinbounds( targetpoint, checkbadcircles, var_566819e204437d34 + timeoffset ) )
    {
        return targetpoint;
    }
}

// Namespace br_circle
// Params 3
// Checksum 0xf47e1ee4, Offset: 0x41df
// Size: 0x66, Type: bool
function isvalidpointinbounds( point, checkbadcircleareas, var_566819e204437d34 )
{
    if ( !br_c130::ispointinbounds( point, 1 ) )
    {
        return false;
    }
    
    if ( checkbadcircleareas && _ispointinbadarea( point ) )
    {
        return false;
    }
    
    if ( isdefined( var_566819e204437d34 ) )
    {
        var_848876b000d62aab = getmintimetillpointindangercircle( point );
        
        if ( var_566819e204437d34 > var_848876b000d62aab )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_circle
// Params 2
// Checksum 0xdc95ef33, Offset: 0x424e
// Size: 0x167
function function_7816347ed744dd74( position, var_e0f63dc1095a434d )
{
    if ( getdvarint( @"hash_4dbb6218c0808e6c", 0 ) == 0 && isdefined( position ) && isdefined( level.var_256941f347945772 ) )
    {
        foreach ( area in level.var_256941f347945772 )
        {
            distsq = distance2dsquared( position, area.origin );
            
            if ( distsq < area.radiussq )
            {
                if ( isdefined( var_e0f63dc1095a434d ) )
                {
                    direction = vectornormalize( var_e0f63dc1095a434d - area.origin );
                }
                else
                {
                    var_f2ab277de8d101f3 = level.br_level.br_mapcenter ?? ( 0, 0, 0 );
                    direction = vectornormalize( var_f2ab277de8d101f3 - area.origin );
                }
                
                var_e2727075b8a7e201 = area.origin + direction * area.radius;
                return var_e2727075b8a7e201;
            }
        }
    }
    
    return position;
}

// Namespace br_circle
// Params 2
// Checksum 0x8c22d977, Offset: 0x43be
// Size: 0x11c
function function_15469901d945c6e6( radiuspercent, var_566819e204437d34 )
{
    aliveteammembers = level.teamdata[ self.team ][ "alivePlayers" ];
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) && isdefined( aliveteammembers ) )
    {
        var_5cbb6fb07c209bb5 = arraysort( aliveteammembers, undefined, &function_be879c8063ce865f );
        
        foreach ( squadmember in var_5cbb6fb07c209bb5 )
        {
            if ( squadmember != self )
            {
                if ( squadmember br_public::isplayerinorgoingtogulag() == 0 )
                {
                    perimeterpoint = function_de9710111e2e7156( squadmember.origin, radiuspercent, var_566819e204437d34 );
                    
                    if ( isdefined( perimeterpoint ) )
                    {
                        return perimeterpoint;
                    }
                }
            }
        }
    }
}

// Namespace br_circle
// Params 2
// Checksum 0x5cd4053f, Offset: 0x44e3
// Size: 0x2c, Type: bool
function function_be879c8063ce865f( player1, player2 )
{
    return player1.health >= player2.health;
}

// Namespace br_circle
// Params 2
// Checksum 0xb940a395, Offset: 0x4518
// Size: 0x129
function function_7f760bea4038ceb9( radiuspercent, var_566819e204437d34 )
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        foreach ( crate in level.br_crates )
        {
            if ( !( isdefined( crate ) && isdefined( crate.team ) ) || crate.team != self.team )
            {
                continue;
            }
            
            if ( isdefined( crate.playerscaptured ) && isdefined( crate.playerscaptured[ self getentitynumber() ] ) )
            {
                continue;
            }
            
            perimeterpoint = function_de9710111e2e7156( crate.origin, radiuspercent, var_566819e204437d34 );
            
            if ( isdefined( perimeterpoint ) )
            {
                return perimeterpoint;
            }
        }
    }
}

// Namespace br_circle
// Params 3
// Checksum 0x72fc0765, Offset: 0x464a
// Size: 0x1c8
function function_de9710111e2e7156( targetpos, radiuspercent, var_566819e204437d34 )
{
    safeorigins = br_circle_util::function_a698f8bf61cd6736();
    saferadii = br_circle_util::function_803e68e98c8f47a8();
    dangerorigins = br_circle_util::function_af7123cc5e0fb96c();
    dangerradii = br_circle_util::function_1a92b7a87aa9aec6();
    checkbadcircles = getdvarint( @"hash_a7a08b8f08b5bc60", 1 );
    currentclosestpoint = undefined;
    var_91067319163e342e = undefined;
    
    for ( index = 0; index < safeorigins.size ; index++ )
    {
        saferadius = saferadii[ index ];
        dangerorigin = dangerorigins[ index ];
        dangerradius = dangerradii[ index ];
        var_1bcdc2264170cdea = saferadius * saferadius;
        
        if ( var_1bcdc2264170cdea > 0 )
        {
            targetdistance = distance2d( targetpos, dangerorigin );
            
            if ( targetdistance <= 0.01 )
            {
                continue;
            }
            
            totalsteps = 4;
            
            for ( currentstep = totalsteps; currentstep >= 0 ; currentstep-- )
            {
                testdistance = dangerradius * currentstep / totalsteps;
                perimeterpoint = ( targetpos - dangerorigin ) * testdistance / targetdistance * radiuspercent + dangerorigin;
                
                if ( isvalidpointinbounds( perimeterpoint, checkbadcircles, var_566819e204437d34 ) )
                {
                    if ( getdvarint( @"hash_7017ad29dbedc8b1", 1 ) == 1 && isnavmeshloaded() )
                    {
                        perimeterpoint = getclosestpointonnavmesh( perimeterpoint );
                        
                        if ( !isvalidpointinbounds( perimeterpoint, checkbadcircles, var_566819e204437d34 ) )
                        {
                            continue;
                        }
                    }
                    
                    perimeterdist = distance2dsquared( perimeterpoint, targetpos );
                    
                    if ( !isdefined( var_91067319163e342e ) || perimeterdist < var_91067319163e342e )
                    {
                        currentclosestpoint = perimeterpoint;
                        var_91067319163e342e = perimeterdist;
                    }
                    
                    break;
                }
            }
        }
    }
    
    return currentclosestpoint;
}

// Namespace br_circle
// Params 4
// Checksum 0x88a5799d, Offset: 0x481b
// Size: 0x1ca
function function_7a96da43cc32dea( targetpos, radiuspercent, var_566819e204437d34, var_af1d660257ecfca1 )
{
    safeorigins = br_circle_util::function_a698f8bf61cd6736();
    saferadii = br_circle_util::function_803e68e98c8f47a8();
    dangerorigins = br_circle_util::function_af7123cc5e0fb96c();
    dangerradii = br_circle_util::function_1a92b7a87aa9aec6();
    checkbadcircles = getdvarint( @"hash_a7a08b8f08b5bc60", 1 );
    currentclosestpoint = undefined;
    var_91067319163e342e = undefined;
    
    for ( index = 0; index < safeorigins.size ; index++ )
    {
        saferadius = saferadii[ index ];
        dangerorigin = dangerorigins[ index ];
        dangerradius = dangerradii[ index ];
        var_1bcdc2264170cdea = saferadius * saferadius;
        
        if ( var_1bcdc2264170cdea > 0 )
        {
            targetdistance = distance2d( targetpos, dangerorigin );
            totalsteps = 4;
            
            for ( currentstep = totalsteps; currentstep >= 0 ; currentstep-- )
            {
                stepratio = currentstep / totalsteps;
                vector = targetpos - dangerorigin;
                
                if ( targetdistance > dangerradius )
                {
                    vector = vector / targetdistance * dangerradius;
                }
                
                perimeterpoint = vector * stepratio * radiuspercent + dangerorigin;
                
                if ( isvalidpointinbounds( perimeterpoint, checkbadcircles, var_566819e204437d34 ) )
                {
                    if ( var_af1d660257ecfca1 && isnavmeshloaded() )
                    {
                        perimeterpoint = getclosestpointonnavmesh( perimeterpoint );
                        
                        if ( !isvalidpointinbounds( perimeterpoint, checkbadcircles, var_566819e204437d34 ) )
                        {
                            continue;
                        }
                    }
                    
                    perimeterdist = distance2dsquared( perimeterpoint, targetpos );
                    
                    if ( !isdefined( var_91067319163e342e ) || perimeterdist < var_91067319163e342e )
                    {
                        currentclosestpoint = perimeterpoint;
                        var_91067319163e342e = perimeterdist;
                    }
                    
                    break;
                }
            }
        }
    }
    
    return currentclosestpoint;
}

// Namespace br_circle
// Params 10
// Checksum 0x81ff47ff, Offset: 0x49ee
// Size: 0x163
function getrandompointinboundscircle( origin, radius, percentmin, percentmax, droptoground, var_f5661efe10a6d8d5, checkbadcircleareas, var_566819e204437d34, anglemin, anglemax )
{
    pointinbounds = origin;
    
    if ( !isdefined( anglemin ) )
    {
        anglemin = 0;
    }
    
    if ( !isdefined( anglemax ) )
    {
        anglemax = 360;
    }
    
    for ( testcount = 0; testcount < 8 ; testcount++ )
    {
        randompoint = getrandompointincircle( origin, radius, percentmin, percentmax, droptoground, 0, anglemin, anglemax );
        
        if ( isvalidpointinbounds( randompoint, checkbadcircleareas, var_566819e204437d34 ) )
        {
            var_ccb8855d22e4682 = randompoint;
            
            if ( var_f5661efe10a6d8d5 && isnavmeshloaded() )
            {
                randompoint = getclosestpointonnavmesh( var_ccb8855d22e4682 );
                
                if ( isvalidpointinbounds( randompoint, checkbadcircleareas, var_566819e204437d34 ) )
                {
                    pointinbounds = randompoint;
                    break;
                }
            }
            else
            {
                pointinbounds = randompoint;
                break;
            }
        }
        
        dirtocenter = level.br_level.br_circlecenters[ 0 ] - origin;
        dirtocenter = ( dirtocenter[ 0 ], dirtocenter[ 1 ], 0 );
        yaw = vectortoangles( dirtocenter )[ 1 ];
        delta = ( 1 - testcount / 8 ) * 180;
        anglemin = yaw - delta;
        anglemax = yaw + delta;
    }
    
    return pointinbounds;
}

// Namespace br_circle
// Params 9
// Checksum 0x6c96ec67, Offset: 0x4b5a
// Size: 0x21a
function getrandompointincircle( origin, radius, percentmin, percentmax, droptoground = 1, var_f5661efe10a6d8d5 = 1, minangle = 0, maxangle = 360, var_e16ebe37f520aa5b = 0 )
{
    if ( radius <= 0 )
    {
        return origin;
    }
    
    mindistpercent = 0;
    
    if ( isdefined( percentmin ) )
    {
        assert( percentmin >= 0 && percentmin <= 1 );
        mindistpercent = percentmin;
    }
    
    maxdistpercent = 1;
    
    if ( isdefined( percentmax ) )
    {
        assert( percentmax >= 0 && percentmax <= 1 );
        maxdistpercent = percentmax;
    }
    
    assert( mindistpercent <= maxdistpercent );
    assert( minangle <= maxangle );
    assert( !( !var_f5661efe10a6d8d5 && var_e16ebe37f520aa5b ) );
    minchoice = squared( radius * mindistpercent );
    maxchoice = squared( radius * maxdistpercent );
    r = undefined;
    
    if ( minchoice == maxchoice )
    {
        r = sqrt( minchoice );
    }
    else
    {
        r = sqrt( randomfloatrange( minchoice, maxchoice ) );
    }
    
    theta = minangle + randomfloat( maxangle - minangle );
    offset = ( r * cos( theta ), r * sin( theta ), 0 );
    randompoint = origin + offset;
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    
    if ( droptoground )
    {
        randompoint = br_public::droptogroundmultitrace( ( origin[ 0 ], origin[ 1 ], 4000 ) + offset, undefined, undefined, contents );
    }
    
    if ( var_f5661efe10a6d8d5 && isnavmeshloaded() )
    {
        randompoint = getclosestpointonnavmesh( randompoint );
        
        if ( var_e16ebe37f520aa5b )
        {
            randompoint = br_public::droptogroundmultitrace( randompoint, 4000, -50, contents );
        }
    }
    
    return randompoint;
}

// Namespace br_circle
// Params 2
// Checksum 0xac9ca8c5, Offset: 0x4d7d
// Size: 0x67
function getrandompointincurrentcircle( percentmin, percentmax )
{
    dangercircleorigin = getdangercircleorigin();
    dist = level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ];
    return getrandompointincircle( dangercircleorigin, dist, percentmin, percentmax );
}

// Namespace br_circle
// Params 2
// Checksum 0xc9b54886, Offset: 0x4ded
// Size: 0x43
function getrandompointinsafecircle( percentmin, percentmax )
{
    safecircleorigin = getsafecircleorigin();
    safecircleradius = getsafecircleradius();
    return getrandompointincircle( safecircleorigin, safecircleradius, percentmin, percentmax );
}

// Namespace br_circle
// Params 2
// Checksum 0x10a49107, Offset: 0x4e39
// Size: 0x43
function getrandompointinboundssafecircle( percentmin, percentmax )
{
    safecircleorigin = getsafecircleorigin();
    safecircleradius = getsafecircleradius();
    return getrandompointinboundscircle( safecircleorigin, safecircleradius, percentmin, percentmax );
}

// Namespace br_circle
// Params 1
// Checksum 0x4b8a7f77, Offset: 0x4e85
// Size: 0x4e, Type: bool
function ispointincurrentsafecircle( point )
{
    safecircleorigin = getsafecircleorigin();
    safecircleradius = getsafecircleradius();
    
    if ( safecircleradius <= 0 )
    {
        return false;
    }
    
    var_327d0ede8b4fc0c5 = distance2dsquared( point, safecircleorigin );
    return var_327d0ede8b4fc0c5 < safecircleradius * safecircleradius;
}

// Namespace br_circle
// Params 1
// Checksum 0x41db924b, Offset: 0x4edc
// Size: 0x5b, Type: bool
function ispointinnextsafecircle( point )
{
    nextsafecircleorigin = getnextsafecircleorigin();
    nextsafecircleradius = getnextsafecircleradius();
    
    if ( !( isdefined( nextsafecircleorigin ) && isdefined( nextsafecircleradius ) ) )
    {
        return false;
    }
    
    var_327d0ede8b4fc0c5 = distance2dsquared( point, nextsafecircleorigin );
    
    if ( var_327d0ede8b4fc0c5 < nextsafecircleradius * nextsafecircleradius )
    {
        return true;
    }
    
    return false;
}

// Namespace br_circle
// Params 1
// Checksum 0xd0dd62b2, Offset: 0x4f40
// Size: 0x4c
function function_1cd6dea2d52a69b8( point )
{
    nextsafecircleorigin = getnextsafecircleorigin();
    nextsafecircleradius = getnextsafecircleradius();
    
    if ( !( isdefined( nextsafecircleorigin ) && isdefined( nextsafecircleradius ) ) )
    {
        return 0;
    }
    
    return max( distance2d( point, nextsafecircleorigin ) - nextsafecircleradius, 0 );
}

// Namespace br_circle
// Params 2
// Checksum 0x2c1b9728, Offset: 0x4f95
// Size: 0x62, Type: bool
function function_52d62d96409e20b( point, gracedistance )
{
    circleorigin = getdangercircleorigin();
    circleradius = getdangercircleradius();
    circleradius += gracedistance ?? 0;
    circleradius = max( circleradius, 0 );
    radiussquared = circleradius * circleradius;
    return distance2dsquared( point, circleorigin ) < radiussquared;
}

// Namespace br_circle
// Params 0
// Checksum 0xfc0d512b, Offset: 0x5000
// Size: 0xad
function dangercircleenthidefromplayers()
{
    self endon( #"death" );
    
    while ( true )
    {
        self show();
        
        foreach ( player in level.players )
        {
            if ( !player playercanseedangercircleworld() )
            {
                self hidefromplayer( player );
            }
        }
        
        level waittill( #"hash_7f6b2a7b2d05df3e" );
    }
}

/#

    // Namespace br_circle
    // Params 3
    // Checksum 0x1babdcee, Offset: 0x50b5
    // Size: 0x539, Type: dev
    function function_739ec06b6dd24e18( maxpoints, areacount, circleindex )
    {
        level notify( #"hash_a0cc9c70697b5e83" );
        level endon( #"hash_a0cc9c70697b5e83" );
        endpoints = [];
        
        if ( !isdefined( maxpoints ) )
        {
            maxpoints = 1000;
        }
        
        if ( !isdefined( areacount ) )
        {
            areacount = 10;
        }
        
        if ( !isdefined( circleindex ) )
        {
            circleindex = level.br_level.br_circlecenters.size - 1 - level.br_level.br_movingcirclecount;
        }
        
        xmin = level.mapcorners[ 0 ].origin[ 0 ];
        xmax = level.mapcorners[ 1 ].origin[ 0 ];
        
        if ( xmax < xmin )
        {
            xmin = level.mapcorners[ 1 ].origin[ 0 ];
            xmax = level.mapcorners[ 0 ].origin[ 0 ];
        }
        
        xsize = xmax - xmin;
        var_50c81b9c8a4f67ce = xsize / areacount;
        ymin = level.mapcorners[ 0 ].origin[ 1 ];
        ymax = level.mapcorners[ 1 ].origin[ 1 ];
        
        if ( ymax < ymin )
        {
            ymin = level.mapcorners[ 1 ].origin[ 1 ];
            ymax = level.mapcorners[ 0 ].origin[ 1 ];
        }
        
        ysize = ymax - ymin;
        var_794a94878a1aab1 = ysize / areacount;
        areacounts = [];
        
        for ( x = 0; x < areacount ; x++ )
        {
            areacounts[ x ] = [];
            
            for ( y = 0; y < areacount ; y++ )
            {
                areacounts[ x ][ y ] = 0;
            }
        }
        
        waitevery = 500;
        maxcount = 0;
        
        for ( i = 0; i < maxpoints ; i++ )
        {
            var_4eeeeceea43cf695 = !circleindex || circleindex == level.br_level.br_circlecenters.size - 1 - level.br_level.br_movingcirclecount;
            br_multi_circle::function_b22f2da5fcf44995();
            _precalcsafecirclecenters( undefined, 1, var_4eeeeceea43cf695 );
            point = level.br_level.br_circlecenters[ circleindex ];
            pointx = point[ 0 ];
            
            if ( pointx < xmin || pointx > xmax )
            {
                continue;
            }
            
            x = int( ( pointx - xmin ) / ( xmax - xmin ) * areacount );
            pointy = point[ 1 ];
            
            if ( pointy < ymin || pointy > ymax )
            {
                continue;
            }
            
            y = int( ( pointy - ymin ) / ( ymax - ymin ) * areacount );
            areacounts[ x ][ y ] += 1;
            
            if ( areacounts[ x ][ y ] > maxcount )
            {
                maxcount = areacounts[ x ][ y ];
            }
            
            if ( !( ( i + 1 ) % waitevery ) )
            {
                waitframe();
            }
        }
        
        _precalcsafecirclecenters();
        mincount = maxcount;
        
        for ( x = 0; x < areacount ; x++ )
        {
            for ( y = 0; y < areacount ; y++ )
            {
                if ( areacounts[ x ][ y ] < mincount )
                {
                    mincount = areacounts[ x ][ y ];
                }
            }
        }
        
        deltacount = maxcount - mincount;
        
        while ( true )
        {
            for ( x = 0; x <= areacount ; x++ )
            {
                line( ( xmin + x * var_50c81b9c8a4f67ce, ymin, 0 ), ( xmin + x * var_50c81b9c8a4f67ce, ymax, 0 ), ( 1, 1, 0 ) );
            }
            
            for ( y = 0; y <= areacount ; y++ )
            {
                line( ( xmin, ymin + y * var_50c81b9c8a4f67ce, 0 ), ( xmax, ymin + y * var_50c81b9c8a4f67ce, 0 ), ( 1, 1, 0 ) );
            }
            
            for ( x = 0; x < areacount ; x++ )
            {
                for ( y = 0; y < areacount ; y++ )
                {
                    count = areacounts[ x ][ y ];
                    
                    if ( count == 0 )
                    {
                        continue;
                    }
                    
                    if ( deltacount )
                    {
                        colorfrac = ( count - mincount ) / deltacount;
                    }
                    else
                    {
                        colorfrac = 1;
                    }
                    
                    if ( colorfrac < 0.25 )
                    {
                        color = ( 0, colorfrac / 0.25, 1 );
                    }
                    else if ( colorfrac < 0.5 )
                    {
                        colorfrac -= 0.25;
                        color = ( 0, 1, 1 - colorfrac / 0.25 );
                    }
                    else if ( colorfrac < 0.75 )
                    {
                        colorfrac -= 0.5;
                        color = ( colorfrac / 0.25, 1, 0 );
                    }
                    else
                    {
                        colorfrac -= 0.75;
                        color = ( 1, 1 - colorfrac / 0.25, 0 );
                    }
                    
                    scale = var_50c81b9c8a4f67ce / 32;
                    print3d( ( xmin + x * var_50c81b9c8a4f67ce + var_50c81b9c8a4f67ce / 2, ymin + y * var_50c81b9c8a4f67ce + var_794a94878a1aab1 / 2, 0 ), string( count ), color, 1, scale, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_circle
    // Params 1
    // Checksum 0x3d58c8ac, Offset: 0x55f6
    // Size: 0x224, Type: dev
    function function_f8f0a0bdd3398227( simulations )
    {
        level notify( #"hash_25e8e73ef98fc6f4" );
        level endon( #"hash_25e8e73ef98fc6f4" );
        
        if ( isdefined( level.var_f8f0a0bdd3398227 ) )
        {
            level.var_f8f0a0bdd3398227 = undefined;
            return;
        }
        
        level.var_f8f0a0bdd3398227 = 1;
        circlesimulations = [];
        
        for ( i = 0; i < simulations ; i++ )
        {
            br_multi_circle::function_b22f2da5fcf44995();
            _precalcsafecirclecenters( undefined, 1 );
            var_fe01212b7d478ba9 = spawnstruct();
            var_fe01212b7d478ba9.circlecenters = arraycopy( level.br_level.br_circlecenters );
            var_fe01212b7d478ba9.color = ( randomfloatrange( 0.2, 1 ), randomfloatrange( 0.2, 1 ), randomfloatrange( 0.2, 1 ) );
            circlesimulations[ circlesimulations.size ] = var_fe01212b7d478ba9;
        }
        
        endingcircleindex = level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount - 1;
        startingcircleindex = 1;
        
        while ( true )
        {
            foreach ( var_fe01212b7d478ba9 in circlesimulations )
            {
                circlecenters = var_fe01212b7d478ba9.circlecenters;
                color = var_fe01212b7d478ba9.color;
                circleindex = startingcircleindex;
                
                while ( circleindex <= endingcircleindex )
                {
                    print3d( circlecenters[ circleindex ], string( circleindex ), color, 1, 25, 1 );
                    sphere( circlecenters[ circleindex ], 180, color, 0, 1 );
                    
                    if ( circleindex != startingcircleindex )
                    {
                        cylinder( circlecenters[ circleindex - 1 ], circlecenters[ circleindex ], 20, color, 0, 1 );
                    }
                    
                    circleindex += 1;
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_circle
// Params 0
// Checksum 0xe09b6202, Offset: 0x5822
// Size: 0xa6
function function_4483d0837431d23a()
{
    var_29ac0d44d2faf59b = getdvarvector( @"hash_9c956e70471179f5", ( 0, 0, 0 ) );
    
    if ( lengthsquared( var_29ac0d44d2faf59b ) > 0 )
    {
        level.br_circle.br_finalcircleoverride = var_29ac0d44d2faf59b;
    }
    else if ( utility::issharedfuncdefined( #"gametype", #"getfinalcirclecenter" ) )
    {
        level.br_circle.br_finalcircleoverride = utility::callsharedfunc( #"gametype", #"getfinalcirclecenter" );
    }
    
    return level.br_circle.br_finalcircleoverride;
}

// Namespace br_circle
// Params 1
// Checksum 0xf7f79f8a, Offset: 0x58d1
// Size: 0x11b, Type: bool
function _ispointinbadarea( point )
{
    if ( getdvarint( @"hash_507e524ae2b21f76", 0 ) == 1 )
    {
        return false;
    }
    
    if ( !isdefined( level.br_badcircleareas ) || level.br_badcircleareas.size == 0 )
    {
        return false;
    }
    
    foreach ( area in level.br_badcircleareas )
    {
        if ( isstruct( area ) )
        {
            distsq = distance2dsquared( point, area.origin );
            
            if ( distsq < area.radiussq )
            {
                return true;
            }
            
            continue;
        }
        
        testpoint = ( point[ 0 ], point[ 1 ], area.origin[ 2 ] );
        
        if ( ispointinvolume( testpoint, area ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_circle
// Params 1
// Checksum 0x180a90f6, Offset: 0x59f5
// Size: 0xf9
function function_15db2a7b70ccd184( circleindex )
{
    var_c7fdad2d7d7aaf23 = getdvarfloat( @"hash_35d088c38ab6c27", 0.7 );
    playerspeed = var_c7fdad2d7d7aaf23 * getdvarfloat( @"scr_br_circle_max_speed", 200 );
    radius = level.br_level.br_circleradii[ circleindex ];
    closetime = level.br_level.br_circleclosetimes[ circleindex ];
    
    if ( !isdefined( closetime ) || closetime == 0 )
    {
        return 0;
    }
    
    prevradius = level.br_level.br_circleradii[ circleindex + 1 ];
    deltaradius = radius - prevradius;
    radiusspeed = deltaradius / closetime;
    maxmovespeed = max( 0, playerspeed - radiusspeed );
    maxmovedist = maxmovespeed * closetime;
    return maxmovedist;
}

// Namespace br_circle
// Params 3
// Checksum 0xdaf95aa6, Offset: 0x5af7
// Size: 0x177
function function_b9bcde53836ee19d( var_166af41bb4bf7ac0, var_158e6dde8e14b6b, nodlog )
{
    movedistances = [];
    startcenter = level.br_level.br_circlecenters[ var_166af41bb4bf7ac0 ];
    endcenter = level.br_level.br_circlecenters[ var_158e6dde8e14b6b ];
    var_484987054d287200 = distance2d( endcenter, startcenter );
    maxmovedistance = 0;
    
    for ( circleindex = var_166af41bb4bf7ac0; circleindex >= var_158e6dde8e14b6b ; circleindex-- )
    {
        movedistances[ circleindex ] = function_15db2a7b70ccd184( circleindex );
        maxmovedistance += movedistances[ circleindex ];
    }
    
    if ( maxmovedistance < var_484987054d287200 )
    {
        if ( !nodlog )
        {
            dlog_recordevent( "dlog_event_br_circle_fixed_distance_warning", [ "circle_distance", var_484987054d287200, "max_circle_distance", maxmovedistance ] );
        }
        
        maxmovedistance = var_484987054d287200;
    }
    
    slack = maxmovedistance - var_484987054d287200;
    var_6fe22476833fd02f = [];
    
    foreach ( circleindex, movedist in movedistances )
    {
        var_6fe22476833fd02f[ circleindex ] = movedist - slack * movedist / maxmovedistance;
    }
    
    return var_6fe22476833fd02f;
}

// Namespace br_circle
// Params 4
// Checksum 0x58509bc2, Offset: 0x5c77
// Size: 0x13f
function function_96fa9b9e3522a32b( circleindex, movedist, fixedcircleindex, var_f5661efe10a6d8d5 )
{
    var_5cc956bd4180845e = level.br_level.br_circlecenters[ circleindex + 1 ];
    var_d2944fa584b98539 = level.br_level.br_circlecenters[ fixedcircleindex ];
    var_75eb339c0e0b026b = distance2d( var_5cc956bd4180845e, var_d2944fa584b98539 );
    circledist = var_75eb339c0e0b026b - movedist;
    var_55244b9e4fcd773c = var_5cc956bd4180845e - var_d2944fa584b98539;
    var_f0e4e30506c4a4aa = vectortoangles( var_55244b9e4fcd773c )[ 1 ];
    maxmovedist = function_15db2a7b70ccd184( circleindex );
    var_416a3c769333d873 = ( circledist * circledist + var_75eb339c0e0b026b * var_75eb339c0e0b026b - maxmovedist * maxmovedist ) / 2 * circledist * var_75eb339c0e0b026b;
    var_416a3c769333d873 = clamp( var_416a3c769333d873, -1, 1 );
    var_147c6dae0976c610 = acos( var_416a3c769333d873 );
    anglemin = var_f0e4e30506c4a4aa - var_147c6dae0976c610;
    anglemax = var_f0e4e30506c4a4aa + var_147c6dae0976c610;
    circlecenter = getrandompointinboundscircle( var_d2944fa584b98539, circledist, 1, 1, 1, var_f5661efe10a6d8d5, 1, undefined, anglemin, anglemax );
    return circlecenter;
}

// Namespace br_circle
// Params 3
// Checksum 0x86a48a2f, Offset: 0x5dbf
// Size: 0x74
function function_1152bb64decdfdb2( var_166af41bb4bf7ac0, var_158e6dde8e14b6b, var_f5661efe10a6d8d5 )
{
    var_8e6b52076c623b = function_b9bcde53836ee19d( var_166af41bb4bf7ac0, var_158e6dde8e14b6b );
    
    for ( circleindex = var_166af41bb4bf7ac0 - 1; circleindex > var_158e6dde8e14b6b ; circleindex-- )
    {
        level.br_level.br_circlecenters[ circleindex ] = function_96fa9b9e3522a32b( circleindex, var_8e6b52076c623b[ circleindex ], var_158e6dde8e14b6b, var_f5661efe10a6d8d5 );
    }
}

// Namespace br_circle
// Params 2, eflags: 0x4
// Checksum 0x150d3110, Offset: 0x5e3b
// Size: 0x6f
function private function_2241938959bc4aaf( totaltime, resolution )
{
    if ( totaltime == 0 )
    {
        return [ 0 ];
    }
    
    fixedcount = int( int( totaltime ) / resolution );
    balancetime = totaltime - fixedcount * resolution;
    segments = array_init_fill( resolution, fixedcount );
    
    if ( balancetime > 0 )
    {
        segments[ segments.size ] = balancetime;
    }
    
    return segments;
}

// Namespace br_circle
// Params 1, eflags: 0x4
// Checksum 0x59f8bacb, Offset: 0x5eb3
// Size: 0x47e
function private function_ace358d50240b963( lastcircleindex )
{
    segmentresolution = max( getdvarint( @"hash_d967dddcba563fb8", 20 ), 1 );
    segmenttimes = [];
    segmentradii = [];
    segmentmetadata = [];
    trainspeeds = [];
    segmentidx = 0;
    
    for ( index = 0; index < lastcircleindex ; index++ )
    {
        delaytime = level.br_level.br_circledelaytimes[ index ];
        closetime = level.br_level.br_circleclosetimes[ index ];
        startradius = level.br_level.br_circleradii[ index ];
        endradius = level.br_level.br_circleradii[ index + 1 ];
        
        if ( index >= function_9448d46c0e4395c1() )
        {
            delaysegments = function_2241938959bc4aaf( delaytime, segmentresolution );
            closesegments = function_2241938959bc4aaf( closetime, segmentresolution );
        }
        else
        {
            delaysegments = [ delaytime ];
            closesegments = [ closetime ];
        }
        
        delaysegments[ 0 ] += getframeduration() / 1000;
        segmentinfo = spawnstruct();
        segmentinfo.firstidx = segmentidx;
        segmentinfo.var_6de279516d254c77 = delaysegments.size;
        segmentinfo.var_502d509caa111294 = closesegments.size;
        segmentinfo.lastidx = segmentidx + delaysegments.size + closesegments.size - 1;
        segmentmetadata[ index ] = segmentinfo;
        trainspeeds[ segmentidx ] = level.br_level.var_105c73c4aed728af[ index ];
        
        if ( isdefined( level.br_level.var_47dce2c0ac95b4ca[ index ] ) )
        {
            trainspeeds[ segmentidx + delaysegments.size ] = level.br_level.var_47dce2c0ac95b4ca[ index ];
        }
        
        for ( i = 0; i < segmentinfo.var_6de279516d254c77 ; i++ )
        {
            segmenttimes[ segmenttimes.size ] = delaysegments[ i ];
            segmentradii[ segmentradii.size ] = startradius;
        }
        
        var_4658758b46e91a9e = 0;
        
        for ( i = 0; i < segmentinfo.var_502d509caa111294 ; i++ )
        {
            segmenttimes[ segmenttimes.size ] = closesegments[ i ];
            
            if ( closetime > 0 )
            {
                var_4658758b46e91a9e += closesegments[ i ];
                segmentradii[ segmentradii.size ] = math::lerp( startradius, endradius, var_4658758b46e91a9e / closetime );
                continue;
            }
            
            segmentradii[ segmentradii.size ] = endradius;
        }
        
        segmentidx = segmentinfo.lastidx + 1;
    }
    
    utility::flag_wait( "wztrain_array_set" );
    
    if ( !utility::issharedfuncdefined( #"br_movingtrain", #"predictcargotrainpositions" ) )
    {
        assertmsg( "<dev string:x34>" );
        return;
    }
    
    predictfunc = utility::getsharedfunc( #"br_movingtrain", #"predictcargotrainpositions" );
    var_37c868993ab87d07 = level.var_4391838d26dd3baf ? 0 : level.wztrain_info.maxrate[ "cargo_train" ];
    segmentpositions = [[ predictfunc ]]( segmenttimes, trainspeeds, level.br_level.var_45fd3e811cfba537, var_37c868993ab87d07 );
    var_585e70d8c72724f = [[ predictfunc ]]( [ 0 ], [ var_37c868993ab87d07 ], level.br_level.var_45fd3e811cfba537, var_37c868993ab87d07 );
    arrayinsert( segmentpositions, var_585e70d8c72724f[ 0 ], 0 );
    arrayinsert( segmentradii, level.br_level.br_circleradii[ 0 ], 0 );
    level.br_level.var_c0b6a8a6ac25a9fa = segmentpositions;
    level.br_level.var_40380d99600dbf9 = segmentradii;
    level.br_level.var_9a633989648fd22 = segmenttimes;
    level.br_level.var_4589b8916defbe51 = segmentmetadata;
    var_acaaf7bb861e15cf = [];
    
    for ( index = 0; index < segmentmetadata.size ; index++ )
    {
        var_acaaf7bb861e15cf[ var_acaaf7bb861e15cf.size ] = segmentpositions[ segmentmetadata[ index ].lastidx + 1 ];
    }
    
    println( "<dev string:x6b>" + "<dev string:x91>" + level.br_level.br_numcirclesfollowtrain + "<dev string:x9e>" + level.br_level.var_9a633989648fd22.size + "<dev string:xab>" );
    return var_acaaf7bb861e15cf;
}

// Namespace br_circle
// Params 4
// Checksum 0xf0eacbc0, Offset: 0x633a
// Size: 0xf56
function _precalcsafecirclecenters( var_c7b9fbbb249b7a30, nodlog, var_51d03fccd06565e7, isrelocate )
{
    level.br_circle.br_finalcircleoverride = var_c7b9fbbb249b7a30 ?? function_4483d0837431d23a();
    
    if ( !isrelocate )
    {
        level.br_level.br_circlecenters = [];
    }
    
    mapcenter = ( level.br_circle.mapbounds[ 0 ] + level.br_circle.mapbounds[ 1 ] ) * 0.5;
    mapcenterfinal = utility::callsharedfunc( #"gametype", #"mapcenterfinalcircle" );
    
    if ( isdefined( mapcenterfinal ) )
    {
        mapcenter = mapcenterfinal;
    }
    
    level.br_level.br_circlecenters[ 0 ] = ( mapcenter[ 0 ], mapcenter[ 1 ], 0 );
    centerx = mapcenter[ 0 ];
    centery = mapcenter[ 1 ];
    
    if ( level.br_level.staticcircle )
    {
        level.br_level.br_circlecenters[ 0 ] = br_public::droptogroundmultitrace( ( centerx, centery, 4000 ) );
        level.br_level.br_circlecenters[ 1 ] = level.br_level.br_circlecenters[ 0 ];
        return;
    }
    
    var_f5661efe10a6d8d5 = getdvarint( @"hash_67a8c844bad5a45b", 0 );
    
    if ( !var_f5661efe10a6d8d5 && br_gametypes::isfeatureenabled( #"circlesnaptonavmesh" ) )
    {
        var_f5661efe10a6d8d5 = 1;
    }
    
    lastcircleindex = level.br_level.br_circleradii.size - 1 - level.br_level.br_movingcirclecount;
    var_8e059e02ba8219dc = function_9eac7d8c846aabd0();
    
    if ( isdefined( var_8e059e02ba8219dc ) )
    {
        var_3ce91cee152f6e8b = var_8e059e02ba8219dc + 1;
    }
    else
    {
        var_3ce91cee152f6e8b = lastcircleindex + 1;
    }
    
    if ( isdefined( level.br_circle.br_finalcircleoverride ) )
    {
        testx = level.br_circle.br_finalcircleoverride[ 0 ];
        testy = level.br_circle.br_finalcircleoverride[ 1 ];
        ispointinbounds = br_c130::ispointinbounds( ( testx, testy, 0 ), 1 );
        ispointinbadarea = !isrelocate && _ispointinbadarea( ( testx, testy, 0 ) );
        isvalidpointbr = ispointinbounds && !ispointinbadarea;
        
        if ( isvalidpointbr )
        {
            centerx = testx;
            centery = testy;
        }
    }
    else if ( var_3ce91cee152f6e8b <= lastcircleindex )
    {
        var_b6bc0d42fdda5703 = function_ace358d50240b963( lastcircleindex );
        
        if ( isdefined( var_b6bc0d42fdda5703 ) )
        {
            centerx = var_b6bc0d42fdda5703[ lastcircleindex - 1 ][ 0 ];
            centery = var_b6bc0d42fdda5703[ lastcircleindex - 1 ][ 1 ];
        }
    }
    else if ( getdvarint( hashcat( @"hash_6e15be73eb8cd142", lastcircleindex ), 0 ) )
    {
        var_9e36dd9160afdd42 = getdvarvector( hashcat( @"hash_1f5d1ccbe88f98a5", lastcircleindex ), ( 0, 0, 0 ) );
        centerx = var_9e36dd9160afdd42[ 0 ];
        centery = var_9e36dd9160afdd42[ 1 ];
    }
    else if ( level.br_level.br_finalcircleoverridelist && level.br_level.br_finalcircleoverridelist.size > 0 )
    {
        var_bfb40a27c45ecc1c = undefined;
        
        if ( level.br_level.var_7f8039de85ee6dbb )
        {
            randomweight = randomfloatrange( 0, level.br_level.var_c93031d6a0cb9851 );
            
            foreach ( circleoverride in level.br_level.br_finalcircleoverridelist )
            {
                if ( randomweight < circleoverride.circleweight )
                {
                    var_bfb40a27c45ecc1c = circleoverride;
                    break;
                }
            }
        }
        else
        {
            var_bfb40a27c45ecc1c = level.br_level.br_finalcircleoverridelist[ level.br_level.br_finalcircleoverrideindex ];
        }
        
        var_849e9b307762aa26 = var_bfb40a27c45ecc1c.circleorigin;
        var_8759a6ae5c4e6222 = var_bfb40a27c45ecc1c.circleradius;
        
        if ( var_8759a6ae5c4e6222 > 0 )
        {
            var_849e9b307762aa26 = getrandompointinboundscircle( var_849e9b307762aa26, var_8759a6ae5c4e6222, 0, 1, 1, 1, 1 );
        }
        
        centerx = var_849e9b307762aa26[ 0 ];
        centery = var_849e9b307762aa26[ 1 ];
    }
    else
    {
        if ( !isdefined( level.br_level.var_dbdfcf36a5283b6c ) )
        {
            level.br_level.var_dbdfcf36a5283b6c = 1;
        }
        
        var_3d55e722ff7402a8 = level.br_level.var_dbdfcf36a5283b6c * level.br_level.br_circleradii[ 1 ];
        radiusbounds = [];
        radiusbounds[ 0 ] = level.br_circle.mapbounds[ 0 ][ 0 ] - var_3d55e722ff7402a8;
        radiusbounds[ 1 ] = level.br_circle.mapbounds[ 0 ][ 1 ] - var_3d55e722ff7402a8;
        radiusbounds[ 2 ] = level.br_circle.mapbounds[ 1 ][ 0 ] + var_3d55e722ff7402a8;
        radiusbounds[ 3 ] = level.br_circle.mapbounds[ 1 ][ 1 ] + var_3d55e722ff7402a8;
        xmin = min( radiusbounds[ 0 ], radiusbounds[ 2 ] );
        xmax = max( radiusbounds[ 0 ], radiusbounds[ 2 ] );
        ymin = min( radiusbounds[ 1 ], radiusbounds[ 3 ] );
        ymax = max( radiusbounds[ 1 ], radiusbounds[ 3 ] );
        contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        
        for ( testcount = 0; testcount < 8 ; testcount++ )
        {
            testx = randomfloatrange( xmin, xmax );
            testy = randomfloatrange( ymin, ymax );
            
            if ( br_c130::ispointinbounds( ( testx, testy, 0 ), 1 ) && !_ispointinbadarea( ( testx, testy, 0 ) ) )
            {
                var_5b0e82962562b9fb = 1;
                
                if ( var_f5661efe10a6d8d5 && isnavmeshloaded() )
                {
                    groundpos = br_public::droptogroundmultitrace( ( testx, testy, 4000 ), undefined, undefined, contents );
                    navmeshpoint = getclosestpointonnavmesh( groundpos );
                    
                    if ( distance2dsquared( navmeshpoint, ( testx, testy, 0 ) ) > 10000 )
                    {
                        var_5b0e82962562b9fb = 0;
                    }
                }
                
                if ( var_5b0e82962562b9fb )
                {
                    centerx = testx;
                    centery = testy;
                    break;
                }
            }
            
            xmin *= 0.9;
            xmax *= 0.9;
            ymin *= 0.9;
            ymax *= 0.9;
        }
    }
    
    if ( !isdefined( centerx ) )
    {
        centerx = 0;
    }
    
    if ( !isdefined( centery ) )
    {
        centery = 0;
    }
    
    level.br_level.br_circlecenters[ lastcircleindex ] = br_public::droptogroundmultitrace( ( centerx, centery, 4000 ) );
    
    if ( var_51d03fccd06565e7 )
    {
        return;
    }
    
    playerspeed = getdvarfloat( @"scr_br_circle_max_speed", 200 );
    var_2fa0821fba9a90e8 = level.br_level.var_64ad486784315ba3;
    circleindex = lastcircleindex - 1;
    
    if ( isdefined( var_b6bc0d42fdda5703 ) )
    {
        while ( circleindex >= var_3ce91cee152f6e8b )
        {
            circlecenter = var_b6bc0d42fdda5703[ circleindex - 1 ];
            level.br_level.br_circlecenters[ circleindex ] = br_public::droptogroundmultitrace( ( circlecenter[ 0 ], circlecenter[ 1 ], 4000 ) );
            
            /#
                if ( getdvarint( hashcat( @"hash_6e15be73eb8cd142", circleindex ), 0 ) )
                {
                    println( "<dev string:xb6>" + circleindex + "<dev string:xcd>" );
                }
            #/
            
            circleindex--;
        }
    }
    
    var_59db3501b141e27d = circleindex + 1;
    
    for ( fixedcircleindex = circleindex; fixedcircleindex >= 0 ; fixedcircleindex-- )
    {
        if ( getdvarint( hashcat( @"hash_6e15be73eb8cd142", fixedcircleindex ), 0 ) )
        {
            var_aa8f7ec385bc439a = getdvarvector( hashcat( @"hash_1f5d1ccbe88f98a5", fixedcircleindex ), ( 0, 0, 0 ) );
            level.br_level.br_circlecenters[ fixedcircleindex ] = br_public::droptogroundmultitrace( ( var_aa8f7ec385bc439a[ 0 ], var_aa8f7ec385bc439a[ 1 ], 4000 ) );
            function_1152bb64decdfdb2( var_59db3501b141e27d, fixedcircleindex, var_f5661efe10a6d8d5 );
            var_59db3501b141e27d = fixedcircleindex;
            circleindex = fixedcircleindex - 1;
        }
    }
    
    var_530b6f18e3a46460 = level.br_level.var_98e6821ab144b8d9;
    var_234c5107fa2b3e3f = level.br_level.var_7e739a9de67d1a8c ?? level.br_level.br_circlecenters[ 0 ];
    var_a11274598f476939 = level.br_level.var_203a565ba2a26fc6;
    var_bcdf1e33507a292f = level.br_level.var_2457c58ebaf817e0;
    var_4de5b35566623f17 = level.br_level.var_dded74b431b2cb82;
    var_40f55bf90bb52dcd = level.br_level.var_80cee42e1ff0fffc;
    var_eac0a84c0e465ca = level.br_level.var_50719e549fcfb63f;
    var_60759283a13e1e1e = isrelocate ? level.br_circle.circleindex + 2 : 0;
    
    while ( circleindex >= var_60759283a13e1e1e )
    {
        origin = level.br_level.br_circlecenters[ circleindex + 1 ];
        radius = level.br_level.br_circleradii[ circleindex ];
        minpct = 0;
        maxpct = 1 - level.br_level.br_circleradii[ circleindex + 1 ] / radius;
        
        if ( isfunction( level.br_circle.var_2e11f4ecf29d6512 ) )
        {
            [ var_9f46b41753acf49d, var_107f53d37bcb9a7f ] = [[ level.br_circle.var_2e11f4ecf29d6512 ]]( circleindex + 1 );
            
            if ( isdefined( var_9f46b41753acf49d ) )
            {
                minpct = var_eac0a84c0e465ca ? var_9f46b41753acf49d : max( var_9f46b41753acf49d, minpct );
            }
            
            if ( isdefined( var_107f53d37bcb9a7f ) )
            {
                maxpct = var_eac0a84c0e465ca ? var_107f53d37bcb9a7f : min( var_107f53d37bcb9a7f, maxpct );
            }
        }
        else if ( var_eac0a84c0e465ca && !br_circle_util::function_22abcafc992ddca7( circleindex ) )
        {
            minpct = level.br_level.var_7bf9015446cbfd9b;
            maxpct = level.br_level.var_9464d2fac246c751;
        }
        
        pct = minpct + randomfloat( maxpct - minpct );
        closetime = level.br_level.br_circleclosetimes[ circleindex ] == 0 ? 1 : level.br_level.br_circleclosetimes[ circleindex ];
        prevradius = level.br_level.br_circleradii[ circleindex + 1 ];
        deltaradius = radius - prevradius;
        var_c0e571077a799999 = deltaradius + radius * pct;
        playermovedistance = playerspeed * closetime;
        distancediff = max( 0, playermovedistance - deltaradius );
        var_e1eb29d231c0441c = distancediff / radius;
        var_cea5ca4e5dcb3be1 = var_c0e571077a799999 > playermovedistance;
        
        if ( var_cea5ca4e5dcb3be1 && !nodlog )
        {
            circlespeed = var_c0e571077a799999 / closetime;
            dlog_recordevent( "dlog_event_br_circle_speed_warning", [ "player_speed", playerspeed, "circle_speed", circlespeed, "circle_close_time", float( closetime ), "circle_current_radius", float( radius ), "circle_next_radius", float( prevradius ) ] );
        }
        
        if ( circleindex || br_gametypes::isfeatureenabled( #"hash_ad1f683df4f2cacd" ) )
        {
            if ( var_2fa0821fba9a90e8 && var_cea5ca4e5dcb3be1 )
            {
                pct = minpct + randomfloat( var_e1eb29d231c0441c - minpct );
            }
            
            anglemin = undefined;
            anglemax = undefined;
            
            if ( var_530b6f18e3a46460 )
            {
                tomapcenter = var_234c5107fa2b3e3f - origin;
                var_101fe83e31d569ca = vectortoangles( tomapcenter );
                mapcenteryaw = var_101fe83e31d569ca[ 1 ];
                disttocenter = length2d( tomapcenter );
                theta = math::remap( disttocenter, var_40f55bf90bb52dcd, var_4de5b35566623f17, var_a11274598f476939, var_bcdf1e33507a292f );
                theta = clamp( theta, var_a11274598f476939, var_bcdf1e33507a292f );
                anglemin = mapcenteryaw - theta * 0.5;
                anglemax = mapcenteryaw + theta * 0.5;
            }
            
            level.br_level.br_circlecenters[ circleindex ] = getrandompointinboundscircle( origin, radius, pct, pct, 1, var_f5661efe10a6d8d5, 1, undefined, anglemin, anglemax );
        }
        
        circleindex--;
    }
    
    if ( level.br_level.br_movingcirclecount > 0 )
    {
        movingcirclemovedistmin = level.br_level.br_movingcirclemovedistmin ?? 100;
        movingcirclemovedistmax = level.br_level.br_movingcirclemovedistmax ?? 300;
        
        for ( var_6c9ce0aedc5e8d38 = 0; var_6c9ce0aedc5e8d38 < level.br_level.br_movingcirclecount ; var_6c9ce0aedc5e8d38++ )
        {
            circleindex = lastcircleindex + var_6c9ce0aedc5e8d38;
            var_21860b69ae9914c1 = circleindex - 1;
            prevcircleradius = level.br_level.br_circleradii[ var_21860b69ae9914c1 ];
            var_b0be625a484743f5 = level.br_level.br_circlecenters[ var_21860b69ae9914c1 ];
            currentcircleradius = level.br_level.br_circleradii[ circleindex ];
            mindist = prevcircleradius + currentcircleradius + movingcirclemovedistmin;
            maxdist = prevcircleradius + currentcircleradius + movingcirclemovedistmax;
            radius = maxdist;
            var_107f53d37bcb9a7f = 1;
            
            if ( isfunction( level.br_circle.var_6c75683522d175ff ) )
            {
                radius = 0;
                [ mindist, var_107f53d37bcb9a7f ] = [[ level.br_circle.var_6c75683522d175ff ]]( circleindex + 1 );
            }
            
            var_e7aa50d861347ca6 = getrandompointinboundscircle( var_b0be625a484743f5, radius, mindist / maxdist, var_107f53d37bcb9a7f, 1, var_f5661efe10a6d8d5, 1 );
            level.br_level.br_circlecenters[ circleindex ] = var_e7aa50d861347ca6;
        }
        
        lastcircleindex += level.br_level.br_movingcirclecount;
        level.br_level.br_circlecenters[ lastcircleindex ] = getrandompointinboundscircle( var_e7aa50d861347ca6, currentcircleradius, 0, 1, 1, var_f5661efe10a6d8d5, 1 );
    }
    
    level notify( #"calc_circle_centers" );
    utility::flag_set( "calc_circle_centers" );
}

// Namespace br_circle
// Params 0
// Checksum 0xfad12c71, Offset: 0x7298
// Size: 0xc1
function getfinalcirclecenter()
{
    lastcircleindex = level.br_level.br_circleradii.size - 2 - level.br_level.br_movingcirclecount;
    
    if ( !isdefined( level.br_level.br_circlecenters ) )
    {
        assertmsg( "<dev string:xec>" );
        return ( 0, 0, 0 );
    }
    
    if ( !isdefined( level.br_level.br_circlecenters[ lastcircleindex ] ) )
    {
        assertmsg( "<dev string:x149>" + lastcircleindex + "<dev string:x165>" );
        return ( 0, 0, 0 );
    }
    
    return level.br_level.br_circlecenters[ lastcircleindex ];
}

// Namespace br_circle
// Params 1
// Checksum 0x3cc81173, Offset: 0x7362
// Size: 0x4b
function runcircles( var_e4b308e319a579e1 )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    
    if ( isdefined( level.var_897bde4d916801b4 ) )
    {
        [[ level.var_897bde4d916801b4 ]]( var_e4b308e319a579e1 );
        return;
    }
    
    function_9ed792247244bd2b( var_e4b308e319a579e1 );
}

// Namespace br_circle
// Params 1
// Checksum 0xd5b61216, Offset: 0x73b5
// Size: 0x3d0
function function_9ed792247244bd2b( var_e4b308e319a579e1 )
{
    level.br_circle.safecircleent = spawn( "script_model", ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], level.br_level.br_circleradii[ 1 ] ) );
    level.br_circle.safecircleent.hidden = 0;
    level.br_circle.safecircleui = spawn( "script_model", level.br_circle.safecircleent.origin );
    level.br_circle.safecircleui.hidden = 0;
    level.br_circle.dangercircleent = spawnbrcircle( level.br_level.br_circlecenters[ 0 ][ 0 ], level.br_level.br_circlecenters[ 0 ][ 1 ], level.br_level.br_circleradii[ 0 ] );
    level.br_circle.dangercircleent.hidden = 0;
    level.br_circle.dangercircleent thread dangercircleenthidefromplayers();
    level.br_circle.dangercircleui = spawn( "script_model", level.br_circle.dangercircleent.origin );
    level.br_circle.dangercircleui.hidden = 0;
    hidedangercircle();
    function_6e7a2c1b9f799487();
    setpreviewuicircle( level.br_circle.safecircleent );
    
    if ( var_e4b308e319a579e1 && !br_gametypes::isfeatureenabled( #"circleearlystart" ) && !level.br_prematchstarted )
    {
        level waittill( #"infils_ready" );
    }
    
    if ( level.usegulag )
    {
        br_gulag::setupgulagtimer();
    }
    
    showdangercircle();
    level.br_circle thread circledamagetick();
    level thread stopcirclesatgameend();
    level.br_circle.circleinittime = gettime();
    flags::gameflaginit( "br_circle_init", 1 );
    
    if ( isdefined( level.br_level.br_circledelaytimes ) )
    {
        for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
        {
            circletimer( i );
            
            if ( isdefined( level.var_10a51e753c9ee204 ) )
            {
                foreach ( callback in level.var_10a51e753c9ee204 )
                {
                    [[ callback ]]();
                }
            }
        }
    }
    
    if ( isdefined( level.var_24ab63605cf6c1d1 ) )
    {
        foreach ( callback in level.var_24ab63605cf6c1d1 )
        {
            [[ callback ]]();
        }
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x599f440f, Offset: 0x778d
// Size: 0xcc
function stopcirclesatgameend()
{
    level notify( #"hash_c3543c8c23f6624e" );
    level endon( #"hash_c3543c8c23f6624e" );
    level utility::waittill_any( "game_ended", "br_ending_start" );
    
    if ( isbrgamemode() )
    {
        setomnvar( "ui_hardpoint_timer", 0 );
    }
    
    if ( getdvarint( @"hash_5854369d7b98c88b", 0 ) )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_br_multi_circle_player_inside", 0 );
        }
    }
}

// Namespace br_circle
// Params 2
// Checksum 0x6eecc257, Offset: 0x7861
// Size: 0xe2
function getcircleindexforpoint( point, startfrom = 0 )
{
    if ( !isdefined( level.br_circle ) )
    {
        return -1;
    }
    
    circleindex = -1;
    
    for ( i = startfrom; i < level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount ; i++ )
    {
        center = level.br_level.br_circlecenters[ i ];
        radius = level.br_level.br_circleradii[ i ];
        dist = distance2dsquared( point, center );
        
        if ( dist >= squared( radius ) )
        {
            break;
        }
        
        circleindex = i;
    }
    
    return circleindex;
}

// Namespace br_circle
// Params 1
// Checksum 0x26a8bf9, Offset: 0x794c
// Size: 0x44f
function getmintimetillpointindangercircle( point )
{
    if ( level.br_circle_disabled )
    {
        return 99999;
    }
    
    if ( !isdefined( level.br_circle ) )
    {
        return -1;
    }
    
    if ( level.br_level.staticcircle )
    {
        return -1;
    }
    
    safetime = 0;
    
    if ( level.br_circle.circleindex >= 0 )
    {
        circleindex = level.br_circle.circleindex;
        circlestarttime = level.br_circle.starttime;
        currentradius = level.br_circle.dangercircleent.origin[ 2 ];
        currentorigin = level.br_circle.dangercircleent.origin;
        
        if ( circleindex >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount )
        {
            return safetime;
        }
    }
    else
    {
        circleindex = 0;
        circlestarttime = gettime();
        currentradius = level.br_level.br_circleradii[ 0 ];
        currentorigin = level.br_level.br_circlecenters[ 0 ];
    }
    
    var_f3fc2cfcf71f4244 = getdvarint( @"hash_cf757888073e9093", 0 );
    
    if ( var_f3fc2cfcf71f4244 )
    {
        if ( distance2d( currentorigin, point ) > currentradius )
        {
            return safetime;
        }
        
        pointindex = getcircleindexforpoint( point, circleindex + 1 );
        
        if ( pointindex == -1 )
        {
            pointindex = circleindex;
        }
    }
    else
    {
        pointindex = getcircleindexforpoint( point );
    }
    
    if ( pointindex < 0 )
    {
        return safetime;
    }
    else if ( pointindex < circleindex )
    {
        return safetime;
    }
    else if ( pointindex == circleindex )
    {
        if ( distance2d( currentorigin, point ) > currentradius )
        {
            return safetime;
        }
    }
    else if ( pointindex >= level.br_level.br_circlecenters.size - 1 )
    {
        return 99999;
    }
    
    for ( i = circleindex + 1; i < pointindex ; i++ )
    {
        safetime += level.br_level.br_circleclosetimes[ i ];
        safetime += level.br_level.br_circledelaytimes[ i ];
    }
    
    delaytime = level.br_level.br_circledelaytimes[ circleindex ];
    closetime = level.br_level.br_circleclosetimes[ circleindex ];
    timepassed = ( gettime() - circlestarttime ) / 1000;
    
    if ( pointindex > circleindex )
    {
        totaltime = delaytime + closetime;
        safetime += totaltime - timepassed;
        testindex = pointindex;
        startorigin = level.br_level.br_circlecenters[ pointindex ];
        endorigin = level.br_level.br_circlecenters[ pointindex + 1 ];
        startradius = level.br_level.br_circleradii[ pointindex ];
        endradius = level.br_level.br_circleradii[ pointindex + 1 ];
        delaytimeremaining = level.br_level.br_circledelaytimes[ pointindex ];
        closetimeremaining = level.br_level.br_circleclosetimes[ pointindex ];
    }
    else
    {
        testindex = circleindex;
        startorigin = currentorigin;
        endorigin = level.br_level.br_circlecenters[ circleindex + 1 ];
        startradius = currentradius;
        endradius = level.br_level.br_circleradii[ circleindex + 1 ];
        
        if ( timepassed < delaytime )
        {
            delaytimeremaining = delaytime - timepassed;
            closetimeremaining = closetime;
        }
        else
        {
            delaytimeremaining = 0;
            closetimeremaining = closetime - timepassed - delaytime;
        }
    }
    
    if ( function_a860b6cc615c4bdb( testindex ) )
    {
        safetime += function_aafc99565360be9d( point, testindex, startorigin, startradius, delaytimeremaining, closetimeremaining );
    }
    else
    {
        safetime += delaytimeremaining;
        safetime += function_2b79ea1c0d706c5b( point, startorigin, endorigin, startradius, endradius, closetimeremaining );
    }
    
    return safetime;
}

// Namespace br_circle
// Params 6
// Checksum 0x1e8c6741, Offset: 0x7da4
// Size: 0x213
function function_2b79ea1c0d706c5b( point, startorigin, endorigin, startradius, endradius, timeremaining )
{
    startradius = float( startradius );
    endradius = float( endradius );
    a = point[ 0 ];
    b = startorigin[ 0 ];
    var_dcb96e715d41ac1b = a - b;
    c = ( endorigin[ 0 ] - startorigin[ 0 ] ) / timeremaining;
    cs = c * c;
    d = point[ 1 ];
    e = startorigin[ 1 ];
    dminuse = d - e;
    f = ( endorigin[ 1 ] - startorigin[ 1 ] ) / timeremaining;
    fs = f * f;
    g = startradius;
    gs = g * g;
    h = ( endradius - startradius ) / timeremaining;
    hs = h * h;
    p1s = pow( 2 * c * var_dcb96e715d41ac1b + 2 * f * dminuse + 2 * g * h, 2 ) - 4 * ( -1 * cs - fs + hs ) * ( -1 * pow( var_dcb96e715d41ac1b, 2 ) - pow( dminuse, 2 ) + gs );
    p1 = sqrt( max( 0, p1s ) );
    p2 = -2 * c * var_dcb96e715d41ac1b - 2 * f * dminuse - 2 * g * h;
    p3 = 2 * ( -1 * cs - fs + hs );
    
    if ( p3 == 0 )
    {
        return 0;
    }
    
    neg = ( -1 * p1 + p2 ) / p3;
    pos = ( p1 + p2 ) / p3;
    
    if ( neg < 0 )
    {
        return pos;
    }
    
    if ( pos < 0 )
    {
        return neg;
    }
    
    return min( neg, pos );
}

// Namespace br_circle
// Params 6
// Checksum 0x50b36039, Offset: 0x7fbf
// Size: 0x20f
function function_aafc99565360be9d( point, testindex, startorigin, startradius, delaytimeremaining, closetimeremaining )
{
    exittime = 0;
    var_925da1cdaa57c436 = level.br_level.var_4589b8916defbe51[ testindex ].firstidx;
    var_4b7c960b2e2531df = level.br_level.var_4589b8916defbe51[ testindex ].lastidx;
    totaltimeremaining = delaytimeremaining + closetimeremaining;
    circleduration = level.br_level.br_circledelaytimes[ testindex ] + level.br_level.br_circleclosetimes[ testindex ];
    var_41c2c58c13d98361 = 0;
    var_70a0b705f9505590 = 0;
    
    for ( segmentidx = var_925da1cdaa57c436; segmentidx <= var_4b7c960b2e2531df ; segmentidx++ )
    {
        segmenttime = level.br_level.var_9a633989648fd22[ segmentidx ];
        var_70a0b705f9505590 += segmenttime;
        
        if ( circleduration - var_70a0b705f9505590 > totaltimeremaining )
        {
            continue;
        }
        else if ( circleduration - var_41c2c58c13d98361 > totaltimeremaining )
        {
            segmenttimeremaining = totaltimeremaining - circleduration - var_70a0b705f9505590;
        }
        else
        {
            segmenttimeremaining = segmenttime;
            startorigin = level.br_level.var_c0b6a8a6ac25a9fa[ segmentidx ];
            startradius = level.br_level.var_40380d99600dbf9[ segmentidx ];
        }
        
        endorigin = level.br_level.var_c0b6a8a6ac25a9fa[ segmentidx + 1 ];
        endradius = level.br_level.var_40380d99600dbf9[ segmentidx + 1 ];
        
        if ( distance2d( endorigin, point ) >= endradius )
        {
            exittime += function_2b79ea1c0d706c5b( point, startorigin, endorigin, startradius, endradius, segmenttimeremaining );
            return exittime;
        }
        
        exittime += segmenttimeremaining;
        var_41c2c58c13d98361 += segmenttime;
    }
    
    return exittime;
}

// Namespace br_circle
// Params 0
// Checksum 0x44bbcc91, Offset: 0x81d7
// Size: 0x70
function hidedangercircle()
{
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleui ) ) )
    {
        return;
    }
    
    level.br_circle.dangercircleui.hidden++;
    level.br_circle.dangercircleent.hidden++;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_circle
// Params 0
// Checksum 0x6efc090e, Offset: 0x824f
// Size: 0x4a
function hidesafecircle()
{
    level.br_circle.safecircleui.hidden++;
    level.br_circle.safecircleent.hidden++;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_circle
// Params 0
// Checksum 0x9d9f52ec, Offset: 0x82a1
// Size: 0x136
function showdangercircle()
{
    washidden = level.br_circle.dangercircleent.hidden || level.br_circle.dangercircleent.hidden;
    level.br_circle.dangercircleui.hidden--;
    level.br_circle.dangercircleent.hidden--;
    assert( level.br_circle.dangercircleui.hidden >= 0 );
    assert( level.br_circle.dangercircleent.hidden >= 0 );
    ishidden = level.br_circle.dangercircleui.hidden || level.br_circle.dangercircleent.hidden;
    
    if ( washidden && !ishidden )
    {
        level notify( #"hash_7f6b2a7b2d05df3e" );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x36b94051, Offset: 0x83df
// Size: 0x136
function showsafecircle()
{
    washidden = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
    level.br_circle.safecircleui.hidden--;
    level.br_circle.safecircleent.hidden--;
    assert( level.br_circle.safecircleui.hidden >= 0 );
    assert( level.br_circle.safecircleent.hidden >= 0 );
    ishidden = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
    
    if ( washidden && !ishidden )
    {
        level notify( #"hash_7f6b2a7b2d05df3e" );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0xcad53f92, Offset: 0x851d
// Size: 0x86
function function_e98a23d4789c4baa( circleindex )
{
    var_50d8d96499063904 = level.br_level.br_circleshowdelaydanger[ circleindex ];
    
    if ( var_50d8d96499063904 > 0 )
    {
        hidedangercircle();
        utility::delaythread( var_50d8d96499063904, &showdangercircle );
    }
    
    var_a63487c39a86bdd2 = level.br_level.br_circleshowdelaysafe[ circleindex ];
    
    if ( var_a63487c39a86bdd2 > 0 )
    {
        hidesafecircle();
        utility::delaythread( var_a63487c39a86bdd2, &showsafecircle );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x1b1f34dd, Offset: 0x85ab
// Size: 0x75a
function circletimer( circleindex )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    
    /#
        function_3a56eb4241432224();
    #/
    
    if ( utility::callsharedfunc( #"gametype", #"circletimer", circleindex ) )
    {
        return;
    }
    
    level.br_circle.starttime = gettime();
    level.br_circle.circleindex = circleindex;
    var_fade5044da9ae670 = circleindex == 0;
    var_b2827c0c6de965f2 = circleindex == level.br_level.br_circleclosetimes.size - 1;
    prewaittime = level.br_level.br_circledelaytimes[ circleindex ];
    closetime = level.br_level.br_circleclosetimes[ circleindex ];
    targetradius = level.br_level.br_circleradii[ circleindex + 1 ];
    
    if ( var_b2827c0c6de965f2 )
    {
        level notify( #"br_final_circle" );
        utility::flag_set( "br_final_circle" );
        function_5c9ddcba6203ddee();
        function_d91ea0c341fce1d0();
    }
    else
    {
        function_1e4592376152dfc1();
    }
    
    function_b3038175405aa2e3();
    
    if ( function_8bdcbb2e3fe350() )
    {
        setomnvar( "ui_br_circle_num", circleindex );
    }
    else
    {
        setomnvar( "ui_br_circle_num", circleindex + 1 );
    }
    
    thread br_gulag::circletimer( circleindex );
    utility::callsharedfunc( #"gametype", #"hash_7b9ee3109b54b52b", circleindex );
    assert( isdefined( level.br_level.br_circleminimapradii[ circleindex ] ), "<dev string:x196>" + circleindex + "<dev string:x1bd>" );
    level thread br_lerp_minimap_zoom( circleindex );
    groundposcenter = level.br_level.br_circlecenters[ circleindex + 1 ];
    level.br_circle.centertarget = groundposcenter;
    level.br_circle.safecircleent.origin = ( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], targetradius );
    level.respawnclosets = gathervalidspawnclosets( groundposcenter, targetradius );
    cleanupoutercrates();
    gatheroutercrates( groundposcenter, targetradius );
    function_e98a23d4789c4baa( circleindex );
    level thread startuiclosetimer( prewaittime, var_fade5044da9ae670, var_b2827c0c6de965f2, circleindex );
    level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
    level.br_circle.dangercircleui.origin = getdangercircleorigin() + ( 0, 0, getdangercircleradius() );
    setstaticuicircles( prewaittime, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_b2827c0c6de965f2 );
    
    if ( canplaycircleopendialog( circleindex ) )
    {
        if ( var_fade5044da9ae670 )
        {
            br_public::brleaderdialog( "first_circle", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
        }
        else
        {
            br_public::brleaderdialog( "new_circle", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
        }
    }
    
    if ( level.usegulag )
    {
        level thread br_gulag::transitioncircle( targetradius, prewaittime );
    }
    
    level notify( #"br_circle_set" );
    wait prewaittime;
    function_6e7a2c1b9f799487();
    level notify( #"br_circle_started" );
    level.circleclosing = 1;
    
    if ( !level.var_b30d3cfccd6d0b0f )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( closetime * 1000 ) );
    }
    
    if ( canplaycircleclosedialog( circleindex ) )
    {
        if ( var_b2827c0c6de965f2 )
        {
            br_public::brleaderdialog( "final_circle", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
        }
        else
        {
            br_public::brleaderdialog( "circle_closing", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
            waittime = level.br_level.br_circledelaytimes[ circleindex ] / 5;
            thread brcirclebattlechatter( circleindex, waittime );
        }
    }
    
    level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
    level.br_circle.dangercircleui.origin = getdangercircleorigin() + ( 0, 0, getdangercircleradius() );
    initialradius = getdangercircleradius();
    setclosinguicircle( int( closetime ), level.br_circle.safecircleent, level.br_circle.dangercircleui, var_b2827c0c6de965f2 );
    level.br_circle.dangercircleent brcirclemoveto( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], targetradius, closetime );
    isplayingmusic = !level.br_circle.var_bdb61cc517e4942d && !( isdefined( level.isstandardsandbox ) && !level.isstandardsandbox );
    
    if ( isplayingmusic )
    {
        level thread music_br::function_fe87426d6e01e1a5( level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, 0.4 );
    }
    
    wait closetime;
    function_6e7a2c1b9f799487();
    
    if ( resetdangercircleorigin( circleindex ) )
    {
        if ( getdvarint( @"hash_e0a1364a76dd764e", 1 ) )
        {
            level.br_circle.dangercircleent.origin = ( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], targetradius );
        }
    }
    
    utility::callsharedfunc( #"gametype", #"hash_1fee89b95d0070b1", var_b2827c0c6de965f2 );
    callback::callback( #"br_circle_closed", { #centertarget:level.br_circle.centertarget, #closetime:closetime, #targetradius:targetradius, #initialradius:initialradius, #var_b2827c0c6de965f2:var_b2827c0c6de965f2, #circleindex:circleindex } );
    var_6b76927ceb6baf97 = 5;
    
    if ( var_6b76927ceb6baf97 > 0 && circleindex < var_6b76927ceb6baf97 )
    {
        rank::addglobalrankxpmultiplier( 1.2, "cirlceMult_" + string( circleindex ) );
        weaponrank::addweaponrankxpmultiplier( 1.2, "cirlceMult_" + string( circleindex ) );
    }
    
    level notify( #"br_circle_closed" );
    level.circleclosing = 0;
    
    if ( isdefined( groundposcenter ) && isdefined( targetradius ) )
    {
        cleanupouterspawnclosets( groundposcenter, targetradius );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0xb60bc0bb, Offset: 0x8d0d
// Size: 0x36
function function_1e4592376152dfc1()
{
    level.var_ea96217a33eb6457 = level.var_b98489098cfce81e[ level.br_circle.circleindex ] ?? level.var_b98489098cfce81e[ 0 ];
}

// Namespace br_circle
// Params 0
// Checksum 0xbe3a4e28, Offset: 0x8d4b
// Size: 0x19
function function_5c9ddcba6203ddee()
{
    level.var_ea96217a33eb6457 = getdvarint( @"hash_45e63325bd676d5c", 0 );
}

// Namespace br_circle
// Params 0
// Checksum 0x8d28ce6e, Offset: 0x8d6c
// Size: 0xca
function function_d91ea0c341fce1d0()
{
    if ( !level.vehicle.aircraft )
    {
        return;
    }
    
    foreach ( vehicle in level.vehicle.aircraft )
    {
        if ( !vehicle || !isalive( vehicle ) )
        {
            continue;
        }
        
        vehicle vehicle_occupancy::disable_engine();
        vehicle dodamage( 99999, vehicle.origin, undefined, undefined );
    }
}

// Namespace br_circle
// Params 0
// Checksum 0xd7caae70, Offset: 0x8e3e
// Size: 0x63
function function_b3038175405aa2e3()
{
    var_af6f57f587847803 = getdvar( @"hash_439cce5f9d1de509", "brloot_health_adrenaline_saw,brloot_self_revive,brloot_self_revive_advanced,brloot_offhand_deconstation" );
    var_f3018484d12da4e8 = strtok( var_af6f57f587847803, "," );
    
    if ( level.commonitem.var_d9665d85ee830b4c == 0 )
    {
        scriptable_group::function_cf6114f2daaf2924( var_f3018484d12da4e8 );
        return;
    }
    
    level thread scriptable_group_spatial::function_50e6dd6d052fdd09( var_f3018484d12da4e8 );
}

// Namespace br_circle
// Params 0
// Checksum 0x426af25c, Offset: 0x8ea9
// Size: 0x12, Type: bool
function function_717dd784da5f9fa0()
{
    return getdvarint( @"hash_47d8674c992e098", 0 ) > 0;
}

// Namespace br_circle
// Params 0
// Checksum 0x24083f3d, Offset: 0x8ec4
// Size: 0x1c, Type: bool
function function_b1e7d42b185c8d31()
{
    return function_717dd784da5f9fa0() && getdvarint( @"hash_192990fc79b06600", 0 ) > 0;
}

// Namespace br_circle
// Params 0
// Checksum 0x5ae2184e, Offset: 0x8ee9
// Size: 0x3b
function function_42b27c52d689e0bc()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.ispaused ) )
    {
        return level.br_circle.ispaused;
    }
    
    return 0;
}

// Namespace br_circle
// Params 1
// Checksum 0x2a6463ab, Offset: 0x8f2d
// Size: 0x97
function pausecircle( value )
{
    if ( !function_717dd784da5f9fa0() || !isdefined( level.br_circle ) || level.br_circle.ispaused == value )
    {
        return;
    }
    
    level.br_circle.ispaused = value;
    
    if ( level.br_circle.ispaused )
    {
        level.br_circle notify( #"hash_8a7be244e0fd1bc0" );
        return;
    }
    
    level.br_circle notify( #"circle_unpaused" );
}

// Namespace br_circle
// Params 0
// Checksum 0x866bdcd1, Offset: 0x8fcc
// Size: 0x2a
function function_6e7a2c1b9f799487()
{
    if ( function_717dd784da5f9fa0() && function_42b27c52d689e0bc() )
    {
        level.br_circle waittill( #"circle_unpaused" );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x434e853a, Offset: 0x8ffe
// Size: 0x146
function br_lerp_minimap_zoom( circleindex )
{
    level endon( #"game_ended" );
    
    if ( circleindex > 0 )
    {
        previousindex = circleindex - 1;
        goalzoom = level.br_level.br_circleminimapradii[ circleindex ];
        previouszoom = level.br_level.br_circleminimapradii[ previousindex ];
        
        if ( goalzoom == previouszoom )
        {
            return;
        }
        
        zoominterval = 0.05;
        totallerptime = 2;
        var_f0123deeb34dac4c = totallerptime / zoominterval;
        var_b9be49d42bca1d90 = int( ( previouszoom - goalzoom ) / var_f0123deeb34dac4c );
        var_2f15f801377e7439 = level.br_level.br_circleminimapradii[ previousindex ];
        
        for ( i = 0; i < var_f0123deeb34dac4c ; i++ )
        {
            var_2f15f801377e7439 -= var_b9be49d42bca1d90;
            setomnvar( "ui_br_minimap_radius", var_2f15f801377e7439 );
            wait zoominterval;
        }
        
        setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ circleindex ] );
        return;
    }
    
    setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ circleindex ] );
}

// Namespace br_circle
// Params 2
// Checksum 0x7a078caa, Offset: 0x914c
// Size: 0x152
function cleanupouterspawnclosets( center, saferadius )
{
    radsqr = saferadius * saferadius;
    
    if ( isdefined( level.revivetriggers ) )
    {
        foreach ( guid, revive in level.revivetriggers )
        {
            if ( isdefined( revive ) && distance2dsquared( center, revive.trigger.origin ) > radsqr )
            {
                validclosets = gathervalidspawnclosets( revive.trigger.origin, saferadius );
                
                if ( validclosets.size > 0 )
                {
                    println( "<dev string:x216>" + validclosets.size + "<dev string:x223>" + validclosets[ 0 ].origin );
                    revive.victim teamrevive::relocatetrigger( validclosets[ 0 ].origin );
                    continue;
                }
                
                revive.victim teamrevive::removetrigger( guid );
            }
        }
    }
}

// Namespace br_circle
// Params 2
// Checksum 0xba3f7c31, Offset: 0x92a6
// Size: 0x46
function gathervalidspawnclosets( center, safecircleradius )
{
    if ( isdefined( level.respawnclosets ) )
    {
        respawnclosets = utility::get_array_of_closest( center, level.respawnclosets, undefined, undefined, safecircleradius );
        return respawnclosets;
    }
}

// Namespace br_circle
// Params 2
// Checksum 0x3b34fd23, Offset: 0x92f5
// Size: 0xc8
function gatheroutercrates( center, saferadius )
{
    radsqr = saferadius * saferadius;
    
    foreach ( crate in level.br_crates )
    {
        if ( isdefined( crate ) && distance2dsquared( center, crate.origin ) > radsqr )
        {
            level.var_e091695dc2372402[ level.var_e091695dc2372402.size ] = crate;
        }
    }
}

// Namespace br_circle
// Params 0
// Checksum 0xedc2c19c, Offset: 0x93c5
// Size: 0x9c
function cleanupoutercrates()
{
    foreach ( crate in level.var_e091695dc2372402 )
    {
        if ( isdefined( crate ) && crate.curprogress == 0 )
        {
            crate thread airdrop::destroycrate();
        }
    }
    
    level.var_e091695dc2372402 = [];
}

// Namespace br_circle
// Params 1, eflags: 0x4
// Checksum 0x50707ea0, Offset: 0x9469
// Size: 0x14
function private copycirclesettings( to_copy )
{
    to_copy[ to_copy.size ] = undefined;
    return to_copy;
}

// Namespace br_circle
// Params 0
// Checksum 0xead3f587, Offset: 0x9486
// Size: 0x16, Type: bool
function function_3c9a51f3294e7238()
{
    return isdefined( level.br_level.circle_defaults );
}

// Namespace br_circle
// Params 0
// Checksum 0x48655774, Offset: 0x94a5
// Size: 0x15
function function_21f7eb72cdc6d5f9()
{
    level.br_level.circle_defaults = undefined;
}

// Namespace br_circle
// Params 0
// Checksum 0xe28d3002, Offset: 0x94c2
// Size: 0x126
function function_ff9a245ba72436d5()
{
    assert( !function_3c9a51f3294e7238() );
    level.br_level.circle_defaults = spawnstruct();
    defaults = level.br_level.circle_defaults;
    defaults.br_circleradii = copycirclesettings( level.br_level.br_circleradii );
    defaults.br_circleclosetimes = copycirclesettings( level.br_level.br_circleclosetimes );
    defaults.br_circledelaytimes = copycirclesettings( level.br_level.br_circledelaytimes );
    defaults.br_circleminimapradii = copycirclesettings( level.br_level.br_circleminimapradii );
    defaults.br_circleshowdelaydanger = copycirclesettings( level.br_level.br_circleshowdelaydanger );
    defaults.br_circleshowdelaysafe = copycirclesettings( level.br_level.br_circleshowdelaysafe );
}

// Namespace br_circle
// Params 0
// Checksum 0xcb428961, Offset: 0x95f0
// Size: 0x10d
function function_fa71252c63a87e16()
{
    assert( function_3c9a51f3294e7238() );
    defaults = level.br_level.circle_defaults;
    level.br_level.br_circleradii = copycirclesettings( defaults.br_circleradii );
    level.br_level.br_circleclosetimes = copycirclesettings( defaults.br_circleclosetimes );
    level.br_level.br_circledelaytimes = copycirclesettings( defaults.br_circledelaytimes );
    level.br_level.br_circleminimapradii = copycirclesettings( defaults.br_circleminimapradii );
    level.br_level.br_circleshowdelaydanger = copycirclesettings( defaults.br_circleshowdelaydanger );
    level.br_level.br_circleshowdelaysafe = copycirclesettings( defaults.br_circleshowdelaysafe );
}

// Namespace br_circle
// Params 2
// Checksum 0x81e220eb, Offset: 0x9705
// Size: 0x43
function array_init_fill( value, count )
{
    array = [];
    
    for ( i = 0; i < count ; i++ )
    {
        array[ array.size ] = value;
    }
    
    return array;
}

// Namespace br_circle
// Params 6
// Checksum 0xadda6909, Offset: 0x9751
// Size: 0x11d
function array_init_distribute( value, num, reverse, a, b, c )
{
    results = [];
    
    if ( !isdefined( a ) )
    {
        a = 0;
    }
    
    if ( !isdefined( b ) )
    {
        b = 0.5;
    }
    
    if ( !isdefined( c ) )
    {
        c = 0.1;
    }
    
    if ( !isdefined( reverse ) )
    {
        reverse = 0;
    }
    
    totalarea = a / 3 + b / 2 + c;
    
    for ( i = 0; i < num ; i++ )
    {
        if ( reverse )
        {
            index = num - i - 1;
        }
        else
        {
            index = i;
        }
        
        sectionarea = ( a * ( 6 * i * i + 6 * i + 2 ) + 3 * num * ( 2 * b * i + b + 2 * c * num ) ) / 6 * num * num * num;
        sectionscale = sectionarea / totalarea;
        results[ index ] = sectionscale * value;
    }
    
    return results;
}

// Namespace br_circle
// Params 6
// Checksum 0x414e26ff, Offset: 0x9877
// Size: 0x2ee
function extendcirclelist( circleradius, circleclosetime, circledelaytime, circleminimapradius, circleshowdelaydanger = 0, circleshowdelaysafe = 0 )
{
    if ( !isarray( circleradius ) )
    {
        circleradius = [ circleradius ];
    }
    
    if ( !isarray( circleclosetime ) )
    {
        circleclosetime = array_init_fill( circleclosetime, circleradius.size );
    }
    
    if ( !isarray( circledelaytime ) )
    {
        circledelaytime = array_init_fill( circledelaytime, circleradius.size );
    }
    
    if ( !isarray( circleminimapradius ) )
    {
        circleminimapradius = array_init_fill( circleminimapradius, circleradius.size );
    }
    
    if ( !isarray( circleshowdelaydanger ) )
    {
        circleshowdelaydanger = array_init_fill( circleshowdelaydanger, circleradius.size );
    }
    
    if ( !isarray( circleshowdelaysafe ) )
    {
        circleshowdelaysafe = array_init_fill( circleshowdelaysafe, circleradius.size );
    }
    
    assert( circleradius.size == circleclosetime.size );
    assert( circleradius.size == circledelaytime.size );
    assert( circleradius.size == circleminimapradius.size );
    assert( circleradius.size == circleshowdelaydanger.size );
    assert( circleradius.size == circleshowdelaysafe.size );
    lastradius = level.br_level.br_circleradii[ level.br_level.br_circleradii.size - 1 ];
    level.br_level.br_circleradii[ level.br_level.br_circleradii.size - 1 ] = undefined;
    
    for ( i = 0; i < circleradius.size ; i++ )
    {
        size = level.br_level.br_circleradii.size;
        level.br_level.br_circleradii[ size ] = circleradius[ i ];
        size = level.br_level.br_circleclosetimes.size;
        level.br_level.br_circleclosetimes[ size ] = circleclosetime[ i ];
        size = level.br_level.br_circledelaytimes.size;
        level.br_level.br_circledelaytimes[ size ] = circledelaytime[ i ];
        size = level.br_level.br_circleminimapradii.size;
        level.br_level.br_circleminimapradii[ size ] = circleminimapradius[ i ];
        size = level.br_level.br_circleshowdelaydanger.size;
        level.br_level.br_circleshowdelaydanger[ size ] = circleshowdelaydanger[ i ];
        size = level.br_level.br_circleshowdelaysafe.size;
        level.br_level.br_circleshowdelaysafe[ size ] = circleshowdelaysafe[ i ];
    }
    
    level.br_level.br_circleradii[ level.br_level.br_circleradii.size ] = lastradius;
}

// Namespace br_circle
// Params 0
// Checksum 0xc3b58ea9, Offset: 0x9b6d
// Size: 0x3b, Type: bool
function function_7b11652a9a16e021()
{
    if ( !level.br_level.var_1a347713967d5dfa )
    {
        return false;
    }
    
    if ( function_cd50329a10799649() || br_gametypes::isfeaturedisabled( #"movingcircle" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_circle
// Params 0
// Checksum 0xd568393, Offset: 0x9bb1
// Size: 0x20, Type: bool
function function_cd50329a10799649()
{
    if ( br_gametypes::isfeaturedisabled( #"traincircle" ) )
    {
        return false;
    }
    
    return istrue( level.var_5ce976cd7a61808e );
}

// Namespace br_circle
// Params 1
// Checksum 0xcd4fd3d4, Offset: 0x9bda
// Size: 0x264
function initfinalcircleoverride( circlesettings )
{
    level.br_level.var_7f8039de85ee6dbb = utility::function_edc4cc03e9e60b3e( @"hash_50f3248965c9dd60", 1, circlesettings.var_8dd20b04399b80a4 );
    level.br_level.br_finalcircleoverrideindex = utility::function_edc4cc03e9e60b3e( @"hash_d63eb5581b0fff41", 0, circlesettings.finalcircleoverrideindex );
    
    if ( !circlesettings.var_ce4571b30505e62 || circlesettings.finalcircleoverridelist.size <= 0 )
    {
        return;
    }
    
    totalweight = 0;
    finalcircleoverridelist = [];
    
    foreach ( i, var_2824d76606ada4b6 in circlesettings.finalcircleoverridelist )
    {
        var_c7d7cbfadeb826fe = utility::function_edc4cc03e9e60b3e( @"hash_7d461902d6aff5a6", 0, var_2824d76606ada4b6.disablecircle );
        
        if ( var_c7d7cbfadeb826fe )
        {
            continue;
        }
        
        circleweight = utility::function_48f723fdc612ec65( hashcat( @"hash_8c4c67425a650428", i ), 1, var_2824d76606ada4b6.circleweight );
        
        if ( circleweight > 0 )
        {
            circleorigin = ( var_2824d76606ada4b6.circleorigin.x, var_2824d76606ada4b6.circleorigin.y, 0 );
            totalweight += circleweight;
            circleoverride = { #circleweight:totalweight, #circleradius:utility::function_48f723fdc612ec65( hashcat( @"hash_344035b4cafb742", i ), 0, var_2824d76606ada4b6.circleradiusarea ), #circleorigin:utility::function_5eb6ca497c84f302( hashcat( @"hash_6e1b8aec4b6e90de", i ), ( 0, 0, 0 ), circleorigin ) };
            finalcircleoverridelist[ finalcircleoverridelist.size ] = circleoverride;
        }
    }
    
    level.br_level.var_c93031d6a0cb9851 = totalweight;
    level.br_level.br_finalcircleoverridelist = finalcircleoverridelist;
}

// Namespace br_circle
// Params 1
// Checksum 0x72768620, Offset: 0x9e46
// Size: 0x23f
function function_362b728132e1c3e7( circlesettings )
{
    movingcirclemovedistmin = utility::function_48f723fdc612ec65( @"scr_br_moving_circle_move_dist_min", 100, circlesettings.movingcirclemovedistmin );
    movingcirclemovedistmax = utility::function_48f723fdc612ec65( @"scr_br_moving_circle_move_dist_max", 300, circlesettings.movingcirclemovedistmax );
    
    if ( movingcirclemovedistmax < movingcirclemovedistmin )
    {
        script::demoforcesre( "movingCircleMoveDistMax should be upper than movingCircleMoveDistMin in brcircleSettings gdt file" );
        movingcirclemovedistmax = movingcirclemovedistmin;
    }
    
    level.br_level.var_1a347713967d5dfa = utility::function_edc4cc03e9e60b3e( @"scr_br_moving_circle_enabled", 1, circlesettings.var_1dd030cd421b6402 );
    level.br_level.br_movingcirclemovedistmin = movingcirclemovedistmin;
    level.br_level.br_movingcirclemovedistmax = movingcirclemovedistmax;
    movingcircleclosetimes = [];
    movingcircledelaytimes = [];
    movingcircleminimapradii = [];
    movingcircleradii = [];
    
    foreach ( circle in circlesettings.movingcircles )
    {
        movingcircleclosetimes[ movingcircleclosetimes.size ] = circle.circleclosetime ?? 0;
        movingcircledelaytimes[ movingcircledelaytimes.size ] = circle.circledelaytime ?? 0;
        movingcircleminimapradii[ movingcircleminimapradii.size ] = circle.circleminimapradii ?? 0;
        movingcircleradii[ movingcircleradii.size ] = circle.circleradius ?? 0;
    }
    
    level.br_level.br_movingcirclecount = circlesettings.movingcircles.size ?? 0;
    level.br_level.var_f559a63aa2239387 = movingcircleclosetimes;
    level.br_level.var_a57e303b613cd742 = movingcircledelaytimes;
    level.br_level.var_4c433f05818902f5 = movingcircleminimapradii;
    level.br_level.var_25d7e557844272ba = movingcircleradii;
}

// Namespace br_circle
// Params 0
// Checksum 0x8e040719, Offset: 0xa08d
// Size: 0xde
function applymovingcircles()
{
    if ( !function_7b11652a9a16e021() )
    {
        level.br_level.br_movingcirclecount = 0;
        level.br_level.br_movingcirclegulagcloseoffset = 0;
        return;
    }
    
    if ( level.br_level.var_813132fd5ea28526 )
    {
        return;
    }
    
    level.br_level.var_813132fd5ea28526 = 1;
    extendcirclelist( level.br_level.var_25d7e557844272ba, level.br_level.var_f559a63aa2239387, level.br_level.var_a57e303b613cd742, level.br_level.var_4c433f05818902f5 );
    level.br_level.br_movingcirclegulagcloseoffset = level.br_level.br_movingcirclecount;
}

// Namespace br_circle
// Params 0
// Checksum 0xbef0bfb0, Offset: 0xa173
// Size: 0x346
function function_501ac17c64e45a95()
{
    if ( !function_cd50329a10799649() )
    {
        level.br_level.var_7a7b3389cf47133f = 0;
        level.br_level.br_numcirclesfollowtrain = 0;
        return;
    }
    
    level.br_level.var_7a7b3389cf47133f = getmatchrulesdata( "brData", "numCirclesAtTrain" );
    level.br_level.br_numcirclesfollowtrain = getmatchrulesdata( "brData", "numCirclesFollowTrain" );
    var_158cadc50da685f2 = getmatchrulesdata( "brData", "perCircleTrainSpeeds" );
    var_144bd5aa1614a39c = function_783ad1757ca38c2a( var_158cadc50da685f2 );
    level.br_level.var_105c73c4aed728af = [];
    var_c4b8bb59262b12a1 = getmatchrulesdata( "brData", "perCircleCloseTrainSpeedOverrides" );
    var_eabffa1bbb079455 = strtok( var_c4b8bb59262b12a1, " " );
    level.br_level.var_47dce2c0ac95b4ca = [];
    level.br_level.var_45fd3e811cfba537 = getmatchrulesdata( "brData", "circleTrainAcceleration" );
    var_68de7cdb515c311d = getmatchrulesdata( "brData", "circleTrainRadiusOverrides" );
    radiusoverrides = strtok( var_68de7cdb515c311d, " " );
    level.br_level.var_e1bf3184db6c5364 = [];
    var_46067f9d1f863168 = var_144bd5aa1614a39c.size - 1;
    
    for ( i = level.br_level.br_circleclosetimes.size - 1; i >= 0 ; i-- )
    {
        if ( var_46067f9d1f863168 >= 0 )
        {
            level.br_level.var_105c73c4aed728af[ i ] = var_144bd5aa1614a39c[ var_46067f9d1f863168 ];
            var_46067f9d1f863168 -= 1;
            continue;
        }
        
        if ( isdefined( level.br_level.var_105c73c4aed728af[ i + 1 ] ) )
        {
            level.br_level.var_105c73c4aed728af[ i ] = level.br_level.var_105c73c4aed728af[ i + 1 ];
        }
    }
    
    var_12d0c232a9549b8d = var_eabffa1bbb079455.size - 1;
    
    for ( i = level.br_level.br_circleclosetimes.size - 1; i >= 0 ; i-- )
    {
        if ( var_12d0c232a9549b8d < 0 )
        {
            break;
        }
        
        if ( var_eabffa1bbb079455[ var_12d0c232a9549b8d ] != "?" )
        {
            level.br_level.var_47dce2c0ac95b4ca[ i ] = float( var_eabffa1bbb079455[ var_12d0c232a9549b8d ] );
        }
        
        var_12d0c232a9549b8d -= 1;
    }
    
    var_957b02748308deed = level.br_level.br_circleradii.size - 1;
    var_12d0c232a9549b8d = radiusoverrides.size - 1;
    
    for ( i = 0; i < level.br_level.var_7a7b3389cf47133f ; i++ )
    {
        if ( var_12d0c232a9549b8d < 0 || var_957b02748308deed < 0 )
        {
            break;
        }
        
        if ( radiusoverrides[ var_12d0c232a9549b8d ] != "?" )
        {
            newradius = int( radiusoverrides[ var_12d0c232a9549b8d ] );
            level.br_level.br_circleradii[ var_957b02748308deed ] = newradius;
            level.br_level.var_e1bf3184db6c5364[ var_957b02748308deed ] = newradius;
        }
        
        var_12d0c232a9549b8d -= 1;
        var_957b02748308deed -= 1;
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x537afcaf, Offset: 0xa4c1
// Size: 0x336
function applycirclesetdvars()
{
    br = level.br_level;
    numcircles = br.br_circleclosetimes.size;
    finalradius = br.br_circleradii[ numcircles ];
    
    for ( i = 0; i < numcircles + 1 ; i++ )
    {
        name_hash = hashcat( @"scr_br_circle_set_", i );
        var_7676550ef5a597e5 = "scr_br_circle_set_" + i;
        value = getdvar( name_hash, "" );
        
        if ( value == "" )
        {
            continue;
        }
        
        if ( value == "delete" )
        {
            for ( j = i; j < numcircles ; j++ )
            {
                br.br_circleradii[ j ] = undefined;
                br.br_circleclosetimes[ j ] = undefined;
                br.br_circledelaytimes[ j ] = undefined;
                br.br_circleminimapradii[ j ] = undefined;
                br.br_circleshowdelaydanger[ j ] = undefined;
                br.br_circleshowdelaysafe[ j ] = undefined;
            }
            
            br.br_circleradii[ i ] = finalradius;
            br.br_circleradii[ j ] = undefined;
            break;
        }
        
        toks = strtok( value, "," );
        
        if ( i >= numcircles )
        {
            var_4842c71711d6d4b7 = 6;
            circlesettingsassert( toks.size == var_4842c71711d6d4b7, "Dvar: " + var_7676550ef5a597e5 + " has " + toks.size + " values, expected " + var_4842c71711d6d4b7 );
            
            if ( toks.size != var_4842c71711d6d4b7 )
            {
                break;
            }
            
            var_8a0d3fa164b2d6ab = 1;
            
            for ( j = 0; j < var_4842c71711d6d4b7 ; j++ )
            {
                if ( toks[ j ] == "?" )
                {
                    var_8a0d3fa164b2d6ab = 0;
                    break;
                }
            }
            
            circlesettingsassert( var_8a0d3fa164b2d6ab, "Dvar: " + var_7676550ef5a597e5 + " has requires all " + var_4842c71711d6d4b7 + " values set" );
            
            if ( !var_8a0d3fa164b2d6ab )
            {
                break;
            }
        }
        
        for ( j = 0; j < toks.size ; j++ )
        {
            tok = toks[ j ];
            
            if ( tok == "?" )
            {
                continue;
            }
            
            switch ( j )
            {
                case 0:
                    br.br_circleradii[ i ] = int( tok );
                    break;
                case 1:
                    br.br_circleclosetimes[ i ] = int( tok );
                    break;
                case 2:
                    br.br_circledelaytimes[ i ] = int( tok );
                    break;
                case 3:
                    br.br_circleminimapradii[ i ] = int( tok );
                    break;
                case 4:
                    br.br_circleshowdelaydanger[ i ] = int( tok );
                    break;
                case 5:
                    br.br_circleshowdelaysafe[ i ] = int( tok );
                    break;
                default:
                    break;
            }
        }
        
        if ( i >= numcircles )
        {
            br.br_circleradii[ i + 1 ] = finalradius;
            numcircles++;
        }
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x2bf6bcdb, Offset: 0xa7ff
// Size: 0x9d
function function_cfdf3903125095d7()
{
    var_b014b6ab04743106 = getdvar( @"scr_br_circlesettings", "" );
    
    if ( !isdefined( var_b014b6ab04743106 ) || var_b014b6ab04743106 == "" )
    {
        mapinfo = level.mapinfobundle;
        
        if ( !isdefined( mapinfo ) )
        {
            mapinfo = getmapscriptbundle();
        }
        
        if ( !isdefined( mapinfo.defaultcirclesettings ) )
        {
            assertmsg( "<dev string:x235>" + mapinfo.mapname + "<dev string:x270>" );
            return;
        }
        
        var_b014b6ab04743106 = "brcirclesettings:" + mapinfo.defaultcirclesettings;
    }
    
    initcirclesettings( var_b014b6ab04743106 );
}

// Namespace br_circle
// Params 1
// Checksum 0x15e99f6, Offset: 0xa8a4
// Size: 0x438
function initcirclesettings( circlesettingsbundle )
{
    circlesettings = getscriptbundle( circlesettingsbundle );
    
    if ( !isdefined( circlesettings ) )
    {
        assertmsg( "<dev string:x2ac>" + circlesettingsbundle );
        return;
    }
    
    level.br_level.var_3e33f6f2aa777d47 = circlesettings.var_3e33f6f2aa777d47;
    function_eadfc74d68e5633( circlesettings );
    level.br_level.br_circleclosetimes = [];
    level.br_level.br_circledelaytimes = [];
    level.br_level.br_circleshowdelaydanger = [];
    level.br_level.br_circleshowdelaysafe = [];
    level.br_level.br_circleminimapradii = [];
    level.br_level.br_circleradii = [];
    
    foreach ( var_5c9803b0202b162c in circlesettings.circle_list )
    {
        circle = var_5c9803b0202b162c.defaultproperties;
        level.br_level.br_circleclosetimes[ level.br_level.br_circleclosetimes.size ] = circle.circleclosetime ?? 0;
        level.br_level.br_circledelaytimes[ level.br_level.br_circledelaytimes.size ] = circle.circledelaytime ?? 0;
        level.br_level.br_circleshowdelaydanger[ level.br_level.br_circleshowdelaydanger.size ] = circle.circleshowdelaydanger ?? 0;
        level.br_level.br_circleshowdelaysafe[ level.br_level.br_circleshowdelaysafe.size ] = circle.circleshowdelaysafe ?? 0;
        level.br_level.br_circleminimapradii[ level.br_level.br_circleminimapradii.size ] = circle.circleminimapradii ?? 0;
        level.br_level.br_circleradii[ level.br_level.br_circleradii.size ] = circle.circleradius ?? 0;
    }
    
    if ( getcodegate( #"hash_7fff7c13f6cce76f" ) )
    {
        function_c46fff58e8236114( circlesettings );
    }
    
    if ( getdvarint( @"hash_4c6bb55c1c24b215", 0 ) == 1 )
    {
        level.br_badcircleareas = [];
        
        foreach ( badcircle in circlesettings.var_6dc23b26b3fb30e5 )
        {
            origin = ( badcircle.x, badcircle.y, badcircle.z );
            radius = badcircle.radius;
            level.br_badcircleareas[ level.br_badcircleareas.size ] = createinvalidcirclearea( origin, radius );
        }
    }
    
    function_f4ac2b2d551a3949( circlesettings.feature_settings );
    level.br_level.br_circleradii[ level.br_level.br_circleradii.size ] = 0;
    level.br_level.var_dbdfcf36a5283b6c = utility::function_48f723fdc612ec65( @"scr_br_circle_first_placement_scale", 1, circlesettings.var_17a6e9c41ecc4f2b );
    initfinalcircleoverride( circlesettings );
    function_362b728132e1c3e7( circlesettings );
}

// Namespace br_circle
// Params 1
// Checksum 0xf9cb11bc, Offset: 0xace4
// Size: 0x1ca
function function_c46fff58e8236114( circlesettings )
{
    level.br_level.var_bb4814756532fa4e = [];
    
    foreach ( var_5c9803b0202b162c in circlesettings.circle_list )
    {
        var_d4ce4feaf2096953 = spawnstruct();
        var_d4ce4feaf2096953.items = [];
        var_d4ce4feaf2096953.quantities = [];
        
        foreach ( item in var_5c9803b0202b162c.var_8b5270de14dff72e )
        {
            if ( !isdefined( item.var_a2df0c82c76f136f ) || item.var_a2df0c82c76f136f == "" )
            {
                continue;
            }
            
            var_d4ce4feaf2096953.items[ var_d4ce4feaf2096953.items.size ] = item.var_a2df0c82c76f136f;
            var_d4ce4feaf2096953.quantities[ var_d4ce4feaf2096953.quantities.size ] = item.itemspawnquantity ?? 0;
        }
        
        level.br_level.var_bb4814756532fa4e[ level.br_level.var_bb4814756532fa4e.size ] = var_d4ce4feaf2096953;
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x2cfa242a, Offset: 0xaeb6
// Size: 0x200
function function_eadfc74d68e5633( circlesettings )
{
    var_4de5b35566623f17 = utility::function_48f723fdc612ec65( @"hash_357248a19e6e2e6c", 10000, circlesettings.var_4de5b35566623f17 );
    var_40f55bf90bb52dcd = utility::function_48f723fdc612ec65( @"hash_8b1c4ddad73b9352", 30000, circlesettings.var_40f55bf90bb52dcd );
    var_a11274598f476939 = utility::function_48f723fdc612ec65( @"hash_be07e52acb983430", 30, circlesettings.var_a11274598f476939 );
    var_bcdf1e33507a292f = utility::function_48f723fdc612ec65( @"hash_94d6e49f6f5a39b6", 180, circlesettings.var_bcdf1e33507a292f );
    
    if ( var_40f55bf90bb52dcd < var_4de5b35566623f17 )
    {
        script::demoforcesre( "centeringMaxDist should be upper than centeringMinDist in brcircleSettings gdt file" );
        var_40f55bf90bb52dcd = var_4de5b35566623f17;
    }
    
    if ( var_bcdf1e33507a292f < var_a11274598f476939 )
    {
        script::demoforcesre( "centeringMaxTheta should be upper than centeringMinTheta in brcircleSettings gdt file" );
        var_bcdf1e33507a292f = var_a11274598f476939;
    }
    
    var_234c5107fa2b3e3f = getdvarvector( @"hash_394a1a053c87ca53", ( 0, 0, 0 ) );
    
    if ( var_234c5107fa2b3e3f == ( 0, 0, 0 ) )
    {
        var_ffb04799df7de207 = circlesettings.var_234c5107fa2b3e3f;
        var_234c5107fa2b3e3f = circlesettings.var_d4b5599a486371df ? ( var_ffb04799df7de207.x, var_ffb04799df7de207.y, var_ffb04799df7de207.z ) : undefined;
    }
    
    level.br_level.var_98e6821ab144b8d9 = utility::function_edc4cc03e9e60b3e( @"hash_b9941bb7847f3ca", 1, circlesettings.var_530b6f18e3a46460 );
    level.br_level.var_7e739a9de67d1a8c = var_234c5107fa2b3e3f;
    level.br_level.var_dded74b431b2cb82 = var_4de5b35566623f17;
    level.br_level.var_80cee42e1ff0fffc = var_40f55bf90bb52dcd;
    level.br_level.var_203a565ba2a26fc6 = var_a11274598f476939;
    level.br_level.var_2457c58ebaf817e0 = var_bcdf1e33507a292f;
}

// Namespace br_circle
// Params 1
// Checksum 0x31fcf561, Offset: 0xb0be
// Size: 0x198
function function_f4ac2b2d551a3949( featuresettings )
{
    if ( !featuresettings.planeSnapToOOB )
    {
        br_gametypes::disablefeature( #"planesnaptooob" );
    }
    
    if ( featuresettings.planeUseCircleRadius )
    {
        br_gametypes::enablefeature( #"planeusecircleradius" );
    }
    
    if ( !featuresettings.randomizeCircleCenter )
    {
        br_gametypes::disablefeature( #"randomizecirclecenter" );
    }
    
    if ( featuresettings.circleearlystart )
    {
        br_gametypes::enablefeature( #"circleearlystart" );
    }
    
    if ( featuresettings.var_ec8ef21fa531304b && getdvarint( @"hash_b5bee43a352643a4", 0 ) )
    {
        br_gametypes::enablefeature( #"hash_157c5a44d6ce8df6" );
    }
    
    if ( featuresettings.var_b95593bd70ed6ec6 )
    {
        br_gametypes::enablefeature( #"hash_ad1f683df4f2cacd" );
    }
    
    level.br_level.var_64ad486784315ba3 = utility::function_edc4cc03e9e60b3e( @"scr_br_circle_clamp_max_circle_speed", 0, featuresettings.var_2fa0821fba9a90e8 );
    level.br_level.var_50719e549fcfb63f = utility::function_edc4cc03e9e60b3e( @"scr_br_circle_allow_inner_circle_to_overlap_outer_circle", 0, featuresettings.var_eb74296c2dde743a );
    level.br_level.var_7bf9015446cbfd9b = utility::function_48f723fdc612ec65( @"hash_6cff10aacd3a4e09", 0, featuresettings.var_590d438e7b4daae8 );
    level.br_level.var_9464d2fac246c751 = utility::function_48f723fdc612ec65( @"hash_5f9e5a3415477b43", 1, featuresettings.var_6ffac7f169526dfa );
}

// Namespace br_circle
// Params 1
// Checksum 0x38934ac9, Offset: 0xb25e
// Size: 0x183
function applycirclesettings( var_9b567f3d606453ce )
{
    if ( getdvarint( @"hash_50fbd5c6df33794b", 1 ) )
    {
        if ( function_3c9a51f3294e7238() )
        {
            function_fa71252c63a87e16();
        }
        else
        {
            function_ff9a245ba72436d5();
        }
    }
    
    if ( !var_9b567f3d606453ce )
    {
        function_8f3d20a0b39d229c();
        applymovingcircles();
        applycirclesetdvars();
    }
    
    timescale = getmatchrulesdata( "brData", "circleTimeScale" );
    br = level.br_level;
    br.br_circleclosetimes = _applydvarstosettings( br.br_circleclosetimes, "close_time", timescale );
    br.br_circledelaytimes = _applydvarstosettings( br.br_circledelaytimes, "delay_time", timescale );
    br.br_circleshowdelaydanger = _applydvarstosettings( br.br_circleshowdelaydanger, "show_delay_danger", timescale );
    br.br_circleshowdelaysafe = _applydvarstosettings( br.br_circleshowdelaysafe, "show_delay_safe", timescale );
    function_501ac17c64e45a95();
    
    if ( !isdefined( br.br_circleradiizero ) )
    {
        br.br_circleradiizero = level.br_level.br_circleradii[ 0 ];
    }
    
    assertcirclesettings();
    
    if ( utility::issharedfuncdefined( #"hash_d0fa8819c2bd6e19", #"hash_853067603230110" ) )
    {
        [[ utility::getsharedfunc( #"hash_d0fa8819c2bd6e19", #"hash_853067603230110" ) ]]();
    }
}

// Namespace br_circle
// Params 3
// Checksum 0xf54df991, Offset: 0xb3e9
// Size: 0xb4
function _applydvarstosettings( settings, dvarstr, timescale )
{
    dvartimescale = getdvarfloat( hashcat( @"hash_2f30e28124ff7895", dvarstr, "_scale" ), 1 );
    
    for ( i = 0; i < settings.size ; i++ )
    {
        closetime = getdvarfloat( hashcat( @"hash_f3544a0fde0fb9b6", dvarstr, "_", string( i ) ), -1 );
        
        if ( closetime > 0 )
        {
            settings[ i ] = closetime;
        }
        
        settings[ i ] *= timescale;
        settings[ i ] *= dvartimescale;
    }
    
    return settings;
}

// Namespace br_circle
// Params 0
// Checksum 0xb355bebd, Offset: 0xb4a6
// Size: 0x41d
function assertcirclesettings()
{
    circlesettingsassert( isdefined( level.br_level.br_circleclosetimes ), "level.br_level.br_circleCloseTimes not defined" );
    circlesettingsassert( isdefined( level.br_level.br_circledelaytimes ), "level.br_level.br_circleDelayTimes not defined" );
    circlesettingsassert( isdefined( level.br_level.br_circleshowdelaydanger ), "level.br_level.br_circleShowDelayDanger not defined" );
    circlesettingsassert( isdefined( level.br_level.br_circleshowdelaysafe ), "level.br_level.br_circleShowDelaySafe not defined" );
    circlesettingsassert( isdefined( level.br_level.br_circleminimapradii ), "level.br_level.br_circleMinimapRadii not defined" );
    circlesettingsassert( isdefined( level.br_level.br_circleradii ), "level.br_level.br_circleDelayTimes not defined" );
    numcircles = level.br_level.br_circleclosetimes.size;
    circlesettingsassert( numcircles == level.br_level.br_circledelaytimes.size, "level.br_level.br_circleDelayTimes size != " + numcircles );
    circlesettingsassert( numcircles == level.br_level.br_circleshowdelaydanger.size, "level.br_level.br_circleShowDelayDanger size != " + numcircles );
    circlesettingsassert( numcircles == level.br_level.br_circleshowdelaysafe.size, "level.br_level.br_circleShowDelaySafe size != " + numcircles );
    circlesettingsassert( numcircles == level.br_level.br_circleminimapradii.size, "level.br_level.br_circleMinimapRadii size != " + numcircles );
    circlesettingsassert( numcircles == level.br_level.br_circleradii.size - 1, "level.br_level.br_circleRadii size-1 != " + numcircles );
    
    for ( i = 0; i < numcircles ; i++ )
    {
        delaytime = level.br_level.br_circledelaytimes[ i ];
        
        if ( !isdefined( delaytime ) )
        {
            circlesettingsassert( 0, "level.br_level.br_circleDelayTimes[" + i + "] undefined, expected contiguous array of " + numcircles + " elements" );
            continue;
        }
        
        var_ce925f2f0ca201cf = level.br_level.br_circleshowdelaydanger[ i ];
        
        if ( !isdefined( var_ce925f2f0ca201cf ) )
        {
            circlesettingsassert( 0, "level.br_level.br_circleShowDelayDanger[" + i + "] undefined, expected contiguous array of " + numcircles + " elements" );
        }
        else
        {
            circlesettingsassert( var_ce925f2f0ca201cf <= delaytime, "level.br_level.br_circleShowDelayDanger[" + i + "] " + var_ce925f2f0ca201cf + " > " + delaytime );
        }
        
        var_4e56d6d0b920c251 = level.br_level.br_circleshowdelaysafe[ i ];
        
        if ( !isdefined( var_4e56d6d0b920c251 ) )
        {
            circlesettingsassert( 0, "level.br_level.br_circleShowDelaySafe[" + i + "] undefined, expected contiguous array of " + numcircles + " elements" );
            continue;
        }
        
        circlesettingsassert( var_4e56d6d0b920c251 <= delaytime, "level.br_level.br_circleShowDelaySafe[" + i + "] " + var_4e56d6d0b920c251 + " > " + delaytime );
    }
    
    if ( function_7b11652a9a16e021() )
    {
        circlesettingsassert( level.br_level.br_circleradii[ 0 ] == level.br_level.br_circleradiizero, "Changing circle radius 0 is not supported" );
    }
    
    if ( function_cd50329a10799649() )
    {
        circlesettingsassert( level.br_level.var_7a7b3389cf47133f <= numcircles && level.br_level.var_7a7b3389cf47133f > 0, "Improper match rules for train tracking, require: 0 < numCirclesAtTrain <= numCircles" );
        circlesettingsassert( level.br_level.br_numcirclesfollowtrain >= 0, "Improper match rules for train tracking, require: 0 <= br_numCirclesFollowTrain" );
        circlesettingsassert( level.br_level.var_7a7b3389cf47133f >= level.br_level.br_numcirclesfollowtrain + 1, "Improper match rules for train tracking, require: numCirclesAtTrain >= ( numCirclesFollowTrain + 1 )" );
        circlesettingsassert( level.br_level.var_105c73c4aed728af.size > 0, "Improper match rules for train tracking, require at least one value for perCircleTrainSpeeds!" );
        circlesettingsassert( level.br_level.var_45fd3e811cfba537 > 0, "Improper match rules for train tracking, require: circleTrainAcceleration > 0" );
        circlesettingsassert( level.br_level.br_movingcirclecount == 0, "Cannot simultaneously support train tracking and moving circles!" );
    }
}

// Namespace br_circle
// Params 2
// Checksum 0xa0efcf52, Offset: 0xb8cb
// Size: 0x25
function circlesettingsassert( value, msg )
{
    if ( !value )
    {
        assertmsg( msg );
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x138d84d, Offset: 0xb8f8
// Size: 0xeb
function getcircleclosetime( targetindex )
{
    if ( !isdefined( level.br_level ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.br_level.br_circledelaytimes ) || !level.br_level.br_circledelaytimes.size )
    {
        return 0;
    }
    
    numcircles = level.br_level.br_circledelaytimes.size;
    
    if ( targetindex >= numcircles )
    {
        targetindex = numcircles - 1;
    }
    
    time = 0;
    
    for ( circleindex = 0; circleindex <= targetindex ; circleindex++ )
    {
        timedelay = level.br_level.br_circledelaytimes[ circleindex ];
        timeclose = level.br_level.br_circleclosetimes[ circleindex ];
        time = time + timedelay + timeclose;
    }
    
    return time;
}

// Namespace br_circle
// Params 2
// Checksum 0x32a87924, Offset: 0xb9ec
// Size: 0xd2
function brcirclebattlechatter( circleindex, delaytime )
{
    if ( isdefined( delaytime ) )
    {
        wait delaytime;
    }
    
    foreach ( team in level.teamnamelist )
    {
        squadindices = br_public::function_ec36cf40e2b38aa6( team );
        
        for ( i = 0; i < squadindices.size ; i++ )
        {
            squadindex = squadindices[ i ];
            level thread doteamcirclebattlechatter( team, squadindex );
        }
    }
}

// Namespace br_circle
// Params 2
// Checksum 0xf8627b6c, Offset: 0xbac6
// Size: 0x198
function doteamcirclebattlechatter( team, squadindex )
{
    safecircleorigin = getsafecircleorigin();
    safecircleradius = getsafecircleradius();
    aliveplayers = teams::function_d032b36d01bbbab3( team, squadindex, 1 );
    validplayers = [];
    
    foreach ( player in aliveplayers )
    {
        if ( !player br_public::isplayerinorgoingtogulag() )
        {
            validplayers[ validplayers.size ] = player;
        }
    }
    
    if ( validplayers.size <= 1 )
    {
        return;
    }
    
    players = sortbydistance( validplayers, safecircleorigin );
    eventname = undefined;
    var_ee0708ceaee47a0a = distance2dsquared( safecircleorigin, players[ 0 ].origin );
    
    if ( var_ee0708ceaee47a0a > safecircleradius * safecircleradius )
    {
        if ( var_ee0708ceaee47a0a > safecircleradius * safecircleradius * 4 )
        {
            eventname = "sitrep_circle_outfar";
        }
        else
        {
            eventname = "sitrep_circle_out";
        }
    }
    else
    {
        var_69083dcde32d03ee = distance2dsquared( safecircleorigin, players[ players.size - 1 ].origin );
        
        if ( var_69083dcde32d03ee > safecircleradius * safecircleradius )
        {
            eventname = "sitrep_circle_mixed";
        }
        else
        {
            eventname = "sitrep_circle_in";
        }
    }
    
    dialog = "br_" + eventname;
    br_public::brleaderdialog( dialog, 1, players );
}

// Namespace br_circle
// Params 2
// Checksum 0x791e1748, Offset: 0xbc66
// Size: 0x53
function createinvalidcirclearea( origin, radius )
{
    zone = spawnstruct();
    zone.origin = origin;
    zone.radius = radius;
    zone.radiussq = radius * radius;
    return zone;
}

// Namespace br_circle
// Params 1
// Checksum 0xb638296d, Offset: 0xbcc2
// Size: 0xd8
function canplaycircleopendialog( circleindex )
{
    canplay = 1;
    currentgamemode = game_utility::getgametype();
    
    if ( level.brgametype.var_9256fa11e2fabc29 )
    {
        canplay = 0;
    }
    else if ( function_8bdcbb2e3fe350() || currentgamemode == "kingslayer" || currentgamemode == "zxp" || currentgamemode == "killcount" )
    {
        if ( circleindex <= 1 )
        {
            canplay = 0;
        }
    }
    else if ( currentgamemode == "dmz" || currentgamemode == "resurgence" || currentgamemode == "plunder" || currentgamemode == "truckwar" )
    {
        canplay = 0;
    }
    else if ( utility::callsharedfunc( #"gametype", #"hash_d53ce3b1c99bc782", circleindex ) )
    {
        canplay = 0;
    }
    
    return canplay;
}

// Namespace br_circle
// Params 1
// Checksum 0x423401d1, Offset: 0xbda3
// Size: 0x68
function canplaycircleclosedialog( circleindex )
{
    canplay = 1;
    currentgamemode = game_utility::getgametype();
    
    if ( function_8bdcbb2e3fe350() || currentgamemode == "zxp" )
    {
        if ( circleindex == 0 )
        {
            canplay = 0;
        }
    }
    else if ( currentgamemode == "dmz" || currentgamemode == "plunder" )
    {
        canplay = 0;
    }
    
    return canplay;
}

// Namespace br_circle
// Params 1
// Checksum 0x83869fe0, Offset: 0xbe14
// Size: 0x73
function resetdangercircleorigin( circleindex )
{
    var_132e147738627713 = 0;
    currentgamemode = game_utility::getgametype();
    
    switch ( currentgamemode )
    {
        case #"hash_7e740e691d49b6c0":
        case #"hash_bfabc434c59611fa":
        case #"hash_d542616c7a17d00d":
        case #"hash_dddecc2751311914":
            if ( circleindex == 0 )
            {
                var_132e147738627713 = 1;
            }
            
            break;
    }
    
    return var_132e147738627713;
}

// Namespace br_circle
// Params 6
// Checksum 0xcc069fc3, Offset: 0xbe90
// Size: 0x12f
function registercirclecallbacks( var_51b8d621f112d544, dangercircletickfunc, var_dbcb6135303d9065, var_b885925a21cebcae, var_d8397cbc3ff9bc8d, var_8a06f7c7c5431e82 )
{
    if ( isdefined( dangercircletickfunc ) )
    {
        if ( !isdefined( level.dangercircletickcallbacks ) )
        {
            level.dangercircletickcallbacks = [];
        }
        
        level.dangercircletickcallbacks[ var_51b8d621f112d544 ] = dangercircletickfunc;
    }
    
    if ( isdefined( var_dbcb6135303d9065 ) )
    {
        if ( !isdefined( level.var_6b09a5bedb4b1dd9 ) )
        {
            level.var_6b09a5bedb4b1dd9 = [];
        }
        
        if ( !isdefined( level.var_af97f7342b1418a9 ) )
        {
            level.var_af97f7342b1418a9 = [];
        }
        
        level.var_6b09a5bedb4b1dd9[ var_51b8d621f112d544 ] = var_dbcb6135303d9065;
        level.var_af97f7342b1418a9[ var_51b8d621f112d544 ] = [];
    }
    
    if ( isdefined( var_b885925a21cebcae ) )
    {
        if ( !isdefined( level.var_3c9c22b4e483957 ) )
        {
            level.var_3c9c22b4e483957 = [];
        }
        
        level.var_3c9c22b4e483957[ var_51b8d621f112d544 ] = var_b885925a21cebcae;
    }
    
    if ( isdefined( var_d8397cbc3ff9bc8d ) )
    {
        if ( !isdefined( level.var_24ab63605cf6c1d1 ) )
        {
            level.var_24ab63605cf6c1d1 = [];
        }
        
        level.var_24ab63605cf6c1d1[ var_51b8d621f112d544 ] = var_d8397cbc3ff9bc8d;
    }
    
    if ( isdefined( var_8a06f7c7c5431e82 ) )
    {
        if ( !isdefined( level.var_10a51e753c9ee204 ) )
        {
            level.var_10a51e753c9ee204 = [];
        }
        
        level.var_10a51e753c9ee204[ var_51b8d621f112d544 ] = var_8a06f7c7c5431e82;
    }
}

// Namespace br_circle
// Params 1
// Checksum 0x1661920d, Offset: 0xbfc7
// Size: 0xa2
function function_e441e2dbc58966e8( var_51b8d621f112d544 )
{
    if ( isdefined( level.dangercircletickcallbacks ) )
    {
        level.dangercircletickcallbacks[ var_51b8d621f112d544 ] = undefined;
    }
    
    if ( isdefined( level.var_6b09a5bedb4b1dd9 ) )
    {
        level.var_6b09a5bedb4b1dd9[ var_51b8d621f112d544 ] = undefined;
    }
    
    if ( isdefined( level.var_af97f7342b1418a9 ) )
    {
        level.var_af97f7342b1418a9[ var_51b8d621f112d544 ] = undefined;
    }
    
    if ( isdefined( level.var_3c9c22b4e483957 ) )
    {
        level.var_3c9c22b4e483957[ var_51b8d621f112d544 ] = undefined;
    }
    
    if ( isdefined( level.var_24ab63605cf6c1d1 ) )
    {
        level.var_24ab63605cf6c1d1[ var_51b8d621f112d544 ] = undefined;
    }
    
    if ( isdefined( level.var_10a51e753c9ee204 ) )
    {
        level.var_10a51e753c9ee204[ var_51b8d621f112d544 ] = undefined;
    }
}

// Namespace br_circle
// Params 0
// Checksum 0x6b721887, Offset: 0xc071
// Size: 0x11
function function_8bdcbb2e3fe350()
{
    return br_gametypes::isfeatureenabled( #"hash_157c5a44d6ce8df6" );
}

// Namespace br_circle
// Params 0
// Checksum 0x780daa9b, Offset: 0xc08b
// Size: 0x168
function function_ffd6be4c479488cf()
{
    level.br_circle.var_9ebd0f8d958e1255 = spawnstruct();
    level.br_circle.var_9c78100dfeb070c7 = spawnstruct();
    first_circle_index = function_8bdcbb2e3fe350() ? 1 : 0;
    second_circle_index = first_circle_index + 1;
    level.br_circle.var_9ebd0f8d958e1255 game_utility::questcircle_create( "Prematch_Preview_Danger_Circle_BR", ( level.br_level.br_circlecenters[ first_circle_index ][ 0 ], level.br_level.br_circlecenters[ first_circle_index ][ 1 ], 0 ), level.br_level.br_circleradii[ first_circle_index ] );
    level.br_circle.var_9c78100dfeb070c7 game_utility::questcircle_create( "Prematch_Preview_Safe_Circle_BR", ( level.br_level.br_circlecenters[ second_circle_index ][ 0 ], level.br_level.br_circlecenters[ second_circle_index ][ 1 ], 0 ), level.br_level.br_circleradii[ second_circle_index ] );
    level.br_circle.var_9ebd0f8d958e1255 game_utility::questcircle_showtoall();
    level.br_circle.var_9c78100dfeb070c7 game_utility::questcircle_showtoall();
    level thread function_af7692111a355c3f();
}

// Namespace br_circle
// Params 0
// Checksum 0x6c4e71ab, Offset: 0xc1fb
// Size: 0x4f
function function_af7692111a355c3f()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_over" );
    level.br_circle.var_9ebd0f8d958e1255 game_utility::questcircle_delete();
    level.br_circle.var_9c78100dfeb070c7 game_utility::questcircle_delete();
}

/#

    // Namespace br_circle
    // Params 0
    // Checksum 0xd336af21, Offset: 0xc252
    // Size: 0x1f1, Type: dev
    function function_ec745e14474a5010()
    {
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        player = level.player;
        startx = 40;
        starty = -32;
        lineheight = 16;
        header = player hud_util::createfontstring( "<dev string:x2e1>", 1.2 );
        header.alpha = 1;
        header.color = ( 1, 1, 0 );
        header hud_util::setpoint( "<dev string:x2e9>", undefined, startx, starty );
        header setdevtext( "<dev string:x2f4>" );
        circleorigin = player hud_util::createfontstring( "<dev string:x2e1>", 1.2 );
        circleorigin.alpha = 1;
        circleorigin.color = ( 1, 1, 0 );
        circleorigin hud_util::setpoint( "<dev string:x2e9>", undefined, startx, starty + lineheight );
        circleradius = player hud_util::createfontstring( "<dev string:x2e1>", 1.2 );
        circleradius.alpha = 1;
        circleradius.color = ( 1, 1, 0 );
        circleradius hud_util::setpoint( "<dev string:x2e9>", undefined, startx, starty + lineheight * 2 );
        circletime = player hud_util::createfontstring( "<dev string:x2e1>", 1.2 );
        circletime.alpha = 1;
        circletime.color = ( 1, 1, 0 );
        circletime hud_util::setpoint( "<dev string:x2e9>", undefined, startx, starty + lineheight * 3 );
        function_1e8befba74d4bd76( header, circleorigin, circleradius, circletime );
        header destroy();
        circleorigin destroy();
        circleradius destroy();
        circletime destroy();
    }

    // Namespace br_circle
    // Params 4
    // Checksum 0xbd8c50d4, Offset: 0xc44b
    // Size: 0xca, Type: dev
    function function_1e8befba74d4bd76( header, circleorigin, circleradius, circletime )
    {
        level endon( #"hash_91be8b9c5f60d37e" );
        
        while ( true )
        {
            header clearalltextafterhudelem();
            origin = getdangercircleorigin();
            radius = getdangercircleradius();
            circleorigin setdevtext( "<dev string:x300>" + int( origin[ 0 ] ) + "<dev string:x30a>" + int( origin[ 1 ] ) + "<dev string:x30c>" );
            circleradius setdevtext( "<dev string:x30e>" + int( radius ) );
            circletime setdevtext( "<dev string:x317>" + getmintimetillpointindangercircle( level.player.origin ) );
            waitframe();
        }
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0x56fb01aa, Offset: 0xc51d
    // Size: 0x11, Type: dev
    function function_8d0e0ec09bdb1035()
    {
        level notify( #"hash_91be8b9c5f60d37e" );
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0xc214263c, Offset: 0xc536
    // Size: 0xb6, Type: dev
    function function_3a56eb4241432224()
    {
        waspaused = 0;
        pausestarttime = gettime();
        
        while ( getdvarint( @"br_circle_pause", 0 ) > 0 )
        {
            if ( ( gettime() - pausestarttime ) % 10000 == 0 )
            {
                iprintln( "<dev string:x325>" );
            }
            
            circleduration = function_bd089538e624a41a( 10000 );
            setomnvar( "<dev string:x35a>", gettime() );
            setomnvar( "<dev string:x373>", circleduration );
            circleduration = function_679d03d3bcd0aadc( 10000 );
            setomnvar( "<dev string:x38a>", gettime() );
            setomnvar( "<dev string:x3a3>", circleduration );
            waspaused = 1;
            waitframe();
        }
        
        if ( waspaused )
        {
            iprintln( "<dev string:x3ba>" );
        }
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0xfcd37512, Offset: 0xc5f4
    // Size: 0x354, Type: dev
    function function_caf9c07d71471a7c()
    {
        level notify( #"hash_d4bada988c582e57" );
        level endon( #"hash_d4bada988c582e57" );
        colors = [ ( 1, 1, 1 ), ( 0.764706, 0.25098, 0.129412 ), ( 0.380392, 0.647059, 0.309804 ), ( 0.427451, 0.811765, 0.964706 ), ( 0.929412, 0.796078, 0.337255 ), ( 1, 0.0431373, 0.843137 ), ( 0.380392, 0.278431, 0.517647 ), ( 1, 0.658824, 0.647059 ), ( 0.380392, 0.780392, 0.803922 ), ( 1, 1, 1 ), ( 0.501961, 0.501961, 0.501961 ), ( 0.898039, 0.6, 0 ), ( 0, 0, 0 ), ( 0.929412, 0.796078, 0.337255 ) ];
        firstcolorindex = 1;
        lastcolorindex = 1;
        skipcolor = [];
        skipcolor[ firstcolorindex ] = 1;
        skipcolor[ lastcolorindex ] = 1;
        skipcolor[ 0 ] = 1;
        skipcolor[ 9 ] = 1;
        skipcolor[ 10 ] = 1;
        skipcolor[ 12 ] = 1;
        skipcolor[ 13 ] = 1;
        thread function_9336340064096825();
        test_colors = [ "<dev string:x3cb>", "<dev string:x3d2>", "<dev string:x3d7>" ];
        
        for ( spawnents = 1; true ; spawnents = 0 )
        {
            waitframe();
            
            if ( !isdefined( level.br_level.br_circlecenters ) || !level.br_level.br_circlecenters.size )
            {
                continue;
            }
            
            colorindex = 0;
            
            for ( circleindex = 0; circleindex < level.br_level.br_circlecenters.size ; circleindex++ )
            {
                radius = level.br_level.br_circleradii[ circleindex ];
                center = level.br_level.br_circlecenters[ circleindex ];
                
                if ( circleindex == 0 )
                {
                    currentcolorindex = firstcolorindex;
                }
                else if ( circleindex == level.br_level.br_circlecenters.size - 1 )
                {
                    currentcolorindex = lastcolorindex;
                }
                else
                {
                    while ( skipcolor[ colorindex ] )
                    {
                        colorindex = ( colorindex + 1 ) % colors.size;
                    }
                    
                    currentcolorindex = colorindex;
                    colorindex = ( colorindex + 1 ) % colors.size;
                }
                
                color = colors[ currentcolorindex ];
                utility::draw_circle( center, max( 5, radius ), color, 1, 0, 1 );
                print3d( center, "<dev string:x3de>" + circleindex + "<dev string:x3e1>" + radius, color, 1, 1, 1, 1 );
                
                if ( spawnents )
                {
                    circleent = spawnstruct();
                    circleent game_utility::questcircle_create( "<dev string:x3e6>" + test_colors[ circleindex % test_colors.size ], center, max( 50, radius ) );
                    circleent game_utility::questcircle_showtoall();
                    circleent thread function_c9108882f07c55a9();
                }
            }
        }
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0xef2b25ac, Offset: 0xc950
    // Size: 0x25, Type: dev
    function function_9336340064096825()
    {
        level endon( #"hash_d4bada988c582e57" );
        level waittill( #"calc_circle_centers" );
        thread function_caf9c07d71471a7c();
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0x2295c2bf, Offset: 0xc97d
    // Size: 0x34, Type: dev
    function function_c9108882f07c55a9()
    {
        self.mapcircle endon( #"death" );
        level waittill( #"hash_d4bada988c582e57" );
        self.mapcircle delete();
    }

    // Namespace br_circle
    // Params 0
    // Checksum 0x4aa8bb40, Offset: 0xc9b9
    // Size: 0x11, Type: dev
    function function_d77c846c9723ce93()
    {
        level notify( #"hash_d4bada988c582e57" );
    }

    // Namespace br_circle
    // Params 2
    // Checksum 0xa381cd60, Offset: 0xc9d2
    // Size: 0x60, Type: dev
    function function_3aab6f3bb1f831f7( args, circletype )
    {
        if ( !level.var_58a4558ed2954c5e )
        {
            level.var_58a4558ed2954c5e = 1;
            level thread function_86d6df2ba8e74fce( args, circletype );
            return;
        }
        
        level.var_58a4558ed2954c5e = undefined;
        level notify( #"hash_784147420a181d51" );
        level notify( #"hash_d4bada988c582e57" );
    }

    // Namespace br_circle
    // Params 2
    // Checksum 0x26618f41, Offset: 0xca3a
    // Size: 0x33b, Type: dev
    function function_86d6df2ba8e74fce( args, circletype )
    {
        level notify( #"hash_784147420a181d51" );
        level endon( #"hash_784147420a181d51" );
        testpt = undefined;
        
        if ( args.size > 0 )
        {
            testpt = spawnstruct();
            testpt.radius = int( args[ 0 ] );
            host = gamelogic_mp::gethostplayer();
            start = host geteye();
            dir = anglestoforward( host getplayerangles() );
            end = start + dir * 50000;
            trace = trace::ray_trace( start, end, host );
            testpt.origin = trace[ "<dev string:x3f2>" ];
        }
        
        spawnents = 1;
        
        while ( true )
        {
            if ( !isdefined( circletype ) || circletype === "<dev string:x3fb>" )
            {
                foreach ( area in level.br_badcircleareas )
                {
                    utility::draw_circle( area.origin, area.radius, ( 1, 1, 1 ), 1, 0, 1 );
                    
                    if ( spawnents )
                    {
                        circleent = spawnstruct();
                        circleent game_utility::questcircle_create( "<dev string:x406>", area.origin, area.radius );
                        circleent game_utility::questcircle_showtoall();
                        circleent thread function_c9108882f07c55a9();
                    }
                }
            }
            
            if ( !isdefined( circletype ) || circletype === "<dev string:x411>" )
            {
                foreach ( area in level.var_256941f347945772 )
                {
                    utility::draw_circle( area.origin, area.radius, ( 1, 1, 0 ), 1, 0, 1 );
                    
                    if ( spawnents )
                    {
                        circleent = spawnstruct();
                        circleent game_utility::questcircle_create( "<dev string:x406>", area.origin, area.radius );
                        circleent game_utility::questcircle_showtoall();
                        circleent thread function_c9108882f07c55a9();
                    }
                }
            }
            
            if ( isdefined( testpt ) )
            {
                utility::draw_circle( testpt.origin, testpt.radius, ( 1, 1, 1 ), 1, 0, 1 );
                
                if ( spawnents )
                {
                    circleent = spawnstruct();
                    circleent game_utility::questcircle_create( "<dev string:x406>", testpt.origin, testpt.radius );
                    circleent thread function_c9108882f07c55a9();
                }
            }
            
            spawnents = 0;
            waitframe();
        }
    }

#/
