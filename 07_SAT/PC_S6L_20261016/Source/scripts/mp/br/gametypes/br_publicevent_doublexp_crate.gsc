// scripts\mp\br\gametypes\br_publicevent_doublexp_crate.gsc  (hash_06307b7c1024bea9.gscc) (size: 5169 Bytes / 0x1431 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70adfe27 (1890450983)
// size ...... 5169 (0x1431)
// includes .. 11  (offset: 0x1229)
// strings ... 27  (offset: 0x1281)
// dev strs .. 5   (offset: 0x13f5)
// exports ... 15  (offset: 0xb49)
// cseg ...... 0x29a + 0x8af (0xb49)
// imports ... 40  (offset: 0xda1)
// animtree1 . 0   (offset: 0x1431)
// animtree2 . 0   (offset: 0x1431)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace br_publicevent_doublexp_crate;

// Namespace br_publicevent_doublexp_crate
// Params 0, eflags: 0x1
// Checksum 0xad4144d7, Offset: 0x2b8
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"doublexp_crate", &init );
}

// Namespace br_publicevent_doublexp_crate
// Params 1
// Checksum 0x8f5dca42, Offset: 0x2d7
// Size: 0x66
function init( eventinfo )
{
    if ( getdvarint( @"scr_br_pe_doublexp_crate_enabled", 1 ) == 0 )
    {
        return;
    }
    
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.canactivatefunc = &function_7a420b2caca4891b;
    eventinfo.activatefunc = &function_60ab9ef644b1e60d;
    initdialog();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x8e42ddd9, Offset: 0x345
// Size: 0x3b
function initdialog()
{
    game[ "dialog" ][ "dbxp_inbound" ] = "dblx_wzan_nbnd";
    game[ "dialog" ][ "dbxp_boost" ] = "dblx_wzan_boos";
    game[ "dialog" ][ "dbxp_active" ] = "dblx_wzan_dbxc";
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x5f40fc77, Offset: 0x388
// Size: 0x11f
function postinitfunc()
{
    level.var_a96adc48a346553a = spawnstruct();
    level.var_a96adc48a346553a.var_ea179ae4df3a64f3 = getdvarint( @"scr_br_pe_doublexp_crate_count", 5 );
    level.var_a96adc48a346553a.xpmultiplier = getdvarfloat( @"scr_br_pe_doublexp_crate_multiplier", 2 );
    level.var_a96adc48a346553a.var_f358ba80826a9f86 = getdvarint( @"hash_1ba89b1c84ffbfa1", 1 );
    level.var_a96adc48a346553a.var_e3fc4a7818ad9104 = getdvarint( @"hash_9ffcaa81d06c9318", 1 );
    level.var_a96adc48a346553a.var_8514f1e6e7596d6a = getdvarint( @"hash_9a2d81522af9d92e", 1 );
    level.var_a96adc48a346553a.var_8c9bdd93eba13810 = getdvarint( @"hash_65abe17beb8e62f6", 1 );
    level.var_a96adc48a346553a.var_4a0271ed43846837 = [];
    assert( level.var_a96adc48a346553a.xpmultiplier >= 1, "<dev string:x24>" );
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x15ad2acb, Offset: 0x4af
// Size: 0x5d, Type: bool
function function_7a420b2caca4891b()
{
    if ( level.br_multi_circle_enabled && !level.br_multi_circle_objectives_enabled && level.br_circle.circleindex > -1 && br_circle_util::function_7c3401c47d505872() > 1 && !br_circle_util::function_23705baf6673b0ed() )
    {
        return false;
    }
    
    if ( br_public::function_73ed6e27eb5e7544() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x55501f14, Offset: 0x515
// Size: 0xab
function function_60ab9ef644b1e60d()
{
    assetname = utility::callsharedfunc( #"gametype", #"hash_5cb07a01f1d566fe" ) ?? "airdrop_doublexp_crate";
    assert( airdrop_scriptbundle::function_fa19528c206bd43( assetname ), "<dev string:x56>" );
    br_publicevents::showsplashtoall( "br_pe_doublexp_crate_start", "splash_list_br_pe_doublexp_crate" );
    level thread br_public::brleaderdialog( "dbxp_inbound", 1, undefined, 0, 1, undefined );
    function_af1b0f0759f33540();
    
    if ( airdrop_scriptbundle::function_fa19528c206bd43( assetname ) )
    {
        var_2e90b3768bb1b63f = airdrop_scriptbundle::startairdrop( assetname );
        level.var_a96adc48a346553a.dlogdata[ "nbOfCratesDropped" ] = var_2e90b3768bb1b63f;
    }
}

// Namespace br_publicevent_doublexp_crate
// Params 1
// Checksum 0x2d040cd0, Offset: 0x5c8
// Size: 0x2cc
function function_abcea032e1fe2aa0( crate )
{
    player = self;
    xpmultiplier = level.var_a96adc48a346553a.xpmultiplier;
    
    if ( level.var_a96adc48a346553a.var_f358ba80826a9f86 )
    {
        teamplayers = function_5713d46873b29625( teams::getteamdata( player.team, "players" ) );
        affectedplayers = teamplayers;
        
        if ( level.var_a96adc48a346553a.var_e3fc4a7818ad9104 )
        {
            rank::addteamrankxpmultiplier( xpmultiplier, player.team, "battle_royale_doublexp_crate" );
        }
        
        if ( level.var_a96adc48a346553a.var_8514f1e6e7596d6a )
        {
            foreach ( teamplayer in teamplayers )
            {
                teamplayer weaponrank::addweaponrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
            }
        }
    }
    else
    {
        affectedplayers = [ player ];
        
        if ( level.var_a96adc48a346553a.var_e3fc4a7818ad9104 )
        {
            player rank::addrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
        }
        
        if ( level.var_a96adc48a346553a.var_8514f1e6e7596d6a )
        {
            player weaponrank::addweaponrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
        }
    }
    
    player function_c3d0b1a7e5cdbd06();
    level.var_a96adc48a346553a.dlogdata[ "nbOfCratesUsed" ] = level.var_a96adc48a346553a.dlogdata[ "nbOfCratesUsed" ] + 1;
    
    if ( player function_6f7f85fc3dddde8() )
    {
        level thread br_public::brleaderdialog( "dbxp_active", undefined, affectedplayers, 1, 1, undefined );
        
        if ( !level.var_a96adc48a346553a.var_8c9bdd93eba13810 )
        {
            return;
        }
        
        foreach ( affectedplayer in affectedplayers )
        {
            if ( level.var_a96adc48a346553a.var_e3fc4a7818ad9104 )
            {
                affectedplayer hud_message::showsplash( "event_double_xp", undefined, self );
            }
            
            if ( level.var_a96adc48a346553a.var_8514f1e6e7596d6a )
            {
                affectedplayer hud_message::showsplash( "event_double_weapon_xp", undefined, self );
            }
        }
        
        return;
    }
    
    lower_message::setlowermessageomnvar( "doublexp_crate_already_used", undefined, 5 );
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x275e00ba, Offset: 0x89c
// Size: 0x8a, Type: bool
function function_6f7f85fc3dddde8()
{
    player = self;
    var_39f0cd66322f9c6b = level.var_a96adc48a346553a.var_f358ba80826a9f86 ? player.team : player;
    
    if ( arraycontains( level.var_a96adc48a346553a.var_4a0271ed43846837, var_39f0cd66322f9c6b ) )
    {
        return false;
    }
    
    level.var_a96adc48a346553a.var_4a0271ed43846837[ level.var_a96adc48a346553a.var_4a0271ed43846837.size ] = var_39f0cd66322f9c6b;
    return true;
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0xf9353e5a, Offset: 0x92f
// Size: 0x6c
function function_af1b0f0759f33540()
{
    if ( isdefined( level.var_a96adc48a346553a.dlogdata ) )
    {
        return;
    }
    
    level.var_a96adc48a346553a.dlogdata = [];
    level.var_a96adc48a346553a.dlogdata[ "nbOfCratesDropped" ] = 0;
    level.var_a96adc48a346553a.dlogdata[ "nbOfCratesUsed" ] = 0;
    thread function_e209358b028ad7b8();
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0x303bda97, Offset: 0x9a3
// Size: 0x86
function function_e209358b028ad7b8()
{
    level waittill( #"game_ended" );
    dlog_recordevent( "dlog_event_doublexp_crate_match_event", [ "nb_of_crates_dropped", level.var_a96adc48a346553a.dlogdata[ "nbOfCratesDropped" ], "nb_of_crates_used", level.var_a96adc48a346553a.dlogdata[ "nbOfCratesUsed" ], "crate_benefits_entire_team", level.var_a96adc48a346553a.var_f358ba80826a9f86 ] );
}

// Namespace br_publicevent_doublexp_crate
// Params 0
// Checksum 0xd2d6f1c3, Offset: 0xa31
// Size: 0xb7
function function_c3d0b1a7e5cdbd06()
{
    circleindex = 0;
    
    if ( level.br_circle.circleindex >= 0 )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    self dlog_recordplayerevent( "dlog_event_doublexp_crate_participation", [ "player_x", self.origin[ 0 ], "player_y", self.origin[ 1 ], "player_z", self.origin[ 2 ], "team", self.team, "circle_index", circleindex ] );
}

/#

    // Namespace br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0x16e51dce, Offset: 0xaf0
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0x31fa5535, Offset: 0xafd
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7d>" );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:x99>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0xded07f21, Offset: 0xb33
    // Size: 0x16, Type: dev
    function debug_start_event()
    {
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"doublexp_crate" );
    }

#/
