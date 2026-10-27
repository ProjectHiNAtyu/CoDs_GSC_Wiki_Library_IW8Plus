// scripts\mp\br\gametypes\br_publicevent_lootcratedrop.gsc  (hash_2f9500200025adda.gscc) (size: 8118 Bytes / 0x1fb6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41d2e577 (1104340343)
// size ...... 8118 (0x1fb6)
// includes .. 13  (offset: 0x1d3e)
// strings ... 38  (offset: 0x1da6)
// dev strs .. 0   (offset: 0x1fb6)
// exports ... 23  (offset: 0x11b2)
// cseg ...... 0x377 + 0xe3b (0x11b2)
// imports ... 69  (offset: 0x154a)
// animtree1 . 0   (offset: 0x1fb6)
// animtree2 . 0   (offset: 0x1fb6)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace br_publicevent_lootcratedrop;

// Namespace br_publicevent_lootcratedrop
// Params 0, eflags: 0x1
// Checksum 0x76ee57df, Offset: 0x395
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"lootcratedrop", &function_d478d40fabc589c9 );
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0xa58fa863, Offset: 0x3b4
// Size: 0x4c
function function_d478d40fabc589c9( eventinfo )
{
    eventinfo.activatefunc = &function_574da2f1bb3e7b2;
    eventinfo.postinitfunc = &function_6c32ec1b3fe09d93;
    utility::registersharedfunc( #"br_cashcrate", #"cashcrate_oncrateuse", &function_7d5c283a10c16742 );
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0xad8f5061, Offset: 0x408
// Size: 0xc
function initweaponcrate( eventinfo )
{
    
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0x3d652304, Offset: 0x41c
// Size: 0xc
function function_f0d0e1309980711e( eventinfo )
{
    
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0x5278202e, Offset: 0x430
// Size: 0x10
function function_6c32ec1b3fe09d93()
{
    thread function_ecab6d6335bc149d();
    postinitfunc();
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xa9984dc1, Offset: 0x448
// Size: 0x9
function function_e7d816ecbeb5d399()
{
    postinitfunc();
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xcebd312c, Offset: 0x459
// Size: 0x9
function function_36e698d69ffbfad4()
{
    postinitfunc();
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xfd4456c, Offset: 0x46a
// Size: 0x6d
function postinitfunc()
{
    if ( isdefined( level.lootcratepostinit ) )
    {
        return;
    }
    
    level.lootcratepostinit = 1;
    game[ "dialog" ][ "cash_drop" ] = "cash_wzan_ncmn";
    game[ "dialog" ][ "weapon_drop" ] = "drop_resupply";
    game[ "dialog" ][ "medical_drop" ] = "medical_announcement";
    level.conf_fx[ "vanish" ] = loadfxasset( "vfx_core_impacts_small_snowhit" );
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xa97cfbc9, Offset: 0x4df
// Size: 0xb
function function_574da2f1bb3e7b2()
{
    activateinternal( 3 );
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xe3798d35, Offset: 0x4f2
// Size: 0xb
function function_5927dd46da13485a()
{
    activateinternal( 1 );
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0x2bdde0a1, Offset: 0x505
// Size: 0xb
function function_1311bb208e586ab1()
{
    activateinternal( 2 );
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0x12c88d04, Offset: 0x518
// Size: 0x1c5
function activateinternal( lootcratestate )
{
    level.var_fec01d8ee18aaa91 = getdvarfloat( @"hash_302f97714cae9d45", 1 );
    crateinfo = spawnstruct();
    
    switch ( lootcratestate )
    {
        case 3:
            level.var_a559715e6a82cdab = getdvarint( @"hash_73e1b59a77872e46", 15000 );
            level thread br_lootchopper::init();
            level thread airdrop::function_2754449e14898546();
            crateinfo.var_63c98baeac70590c = "battle_royale_cash_crate";
            crateinfo.var_b83d7230d8e0c94 = "active";
            crateinfo.var_97038cf40f484d0d = "cashdrop_common_world";
            crateinfo.var_7eef4e77485c6ef = "on";
            crateinfo.var_94e0196ae25740b7 = "br_plunder_pe_cash_drop_active";
            crateinfo.var_2c3b5d765583fdd6 = "splash_list_jup_br";
            crateinfo.var_4076946b58197bc6 = "cash_drop";
            level.var_bea74285059cad6c = 0;
            break;
    }
    
    leveldata = airdrop::getleveldata( crateinfo.var_63c98baeac70590c );
    leveldata.capturestring = &"mp/generic_loot_crate_capture";
    leveldata.minimapicon = undefined;
    
    if ( isdefined( leveldata.var_1c537aa1fb8594a4 ) )
    {
        crateinfo.var_b83d7230d8e0c94 = leveldata.var_1c537aa1fb8594a4;
    }
    
    if ( !leveldata.disablesplash && isdefined( crateinfo.var_94e0196ae25740b7 ) )
    {
        br_publicevents::showsplashtoall( crateinfo.var_94e0196ae25740b7, crateinfo.var_2c3b5d765583fdd6 );
    }
    
    br_public::brleaderdialog( crateinfo.var_4076946b58197bc6, 1 );
    level.var_9db6eb11c1c26691 = [];
    br_supply_drops::function_f1b2aef69d09b0c( [ 1 ], "pe_crate_drop" );
}

// Namespace br_publicevent_lootcratedrop
// Params 2
// Checksum 0x7915e84a, Offset: 0x6e5
// Size: 0x367
function function_99f8c763aafc55f6( dropend, dropstruct )
{
    leveldata = airdrop::getleveldata( "battle_royale_cash_crate" );
    crateowner = undefined;
    crateteam = undefined;
    cratetype = "battle_royale_cash_crate";
    cratestartposition = ( dropend[ 0 ], dropend[ 1 ], 0 ) + ( 0, 0, level.var_4280cdebdfea8385 );
    crateangles = ( 0, randomfloat( 360 ), 0 );
    cratedestination = dropend;
    crate = airdrop::dropcrate( crateowner, crateteam, cratetype, cratestartposition, crateangles, cratedestination );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( !leveldata.var_1fc61fdb8add2a40 )
    {
        crate setscriptablepartstate( "trail", "active", 0 );
        crate.smokesignal = spawn( "script_model", cratestartposition + ( 0, 0, 58 ) );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal linkto( crate );
        crate.smokesignal setscriptablepartstate( "smoke_trail", "on" );
    }
    
    triggerobject = airdrop::gettriggerobject( crate );
    triggerobject.usetimeoverride = level.var_fec01d8ee18aaa91;
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        objidpoolmanager::objective_add_objective( objid, "current", crate.origin, "ui_map_icon_cash_drop" );
        objidpoolmanager::update_objective_setbackground( objid, 5 );
        objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
        objidpoolmanager::update_objective_onentity( objid, crate );
        objidpoolmanager::update_objective_setzoffset( objid, 75 );
        objidpoolmanager::update_objective_description( objid, &"mp_br_ingame/cash_drop" );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        objidpoolmanager::objective_showdistance( objid, 1 );
        var_ee7bc8b53cebd37e = getdvarfloat( @"hash_e9d0abfe80024d80", 11811 );
        var_35c6503701d9c2ca = getdvarfloat( @"hash_ec4adb02477bc5b2", 0.97 );
        var_1e1ecace3b3c2a63 = var_ee7bc8b53cebd37e * var_35c6503701d9c2ca;
        function_ac9886e0e2860e18( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        objidpoolmanager::function_373aaf492aabde6f( objid, 151, 171, 128 );
        function_d1fb910ef06fd658( objid, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        function_24edb8a97f6832f0( objid, 1 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !isbot( player ) && !player br_public::isplayeringulag() )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objid, player );
            }
        }
        
        crate.scriptedobjid = objid;
    }
    else
    {
        crate setscriptablepartstate( "objective_map", "cashdrop_common_world" );
    }
    
    crate.nevertimeout = 1;
    crate.smokescriptable = "ks_airdrop_crate_br";
    level.var_9db6eb11c1c26691[ level.var_9db6eb11c1c26691.size ] = crate;
    return crate;
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0x176f6048, Offset: 0xa55
// Size: 0x166
function function_7d5c283a10c16742( player )
{
    common_item::function_45c338c4003d5f13( self, 0 );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_publicevent_cratedrop" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        spawnoptions.var_90cdc5dbcd319e5d = 1;
        spawnoptions.ignoreents = [ self ];
        spawnoptions.analyticssource = "pe_crate_drop";
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
    }
    
    if ( isdefined( player.perks[ "specialty_br_extra_killstreak_chance" ] ) )
    {
        script::demoforcesre( "Removed br_lootcache::lootContentsAdjustKllChain. If that logic is desired, re-implement in a data-driven manner." );
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( isdefined( self.scriptedobjid ) )
    {
        objective_delete( self.scriptedobjid );
        objidpoolmanager::returnobjectiveid( self.scriptedobjid );
        self.scriptedobjid = undefined;
    }
    
    if ( game_utility::getgametype() == "risk" || game_utility::getgametype() == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xae509807, Offset: 0xbc3
// Size: 0xd8
function function_ecab6d6335bc149d()
{
    level waittill( #"br_supply_drops_init" );
    
    if ( isdefined( level.supplydroptypes[ "pe_crate_drop" ] ) )
    {
        return;
    }
    
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "pe_crate_drop", "military_carepackage_03_br", undefined, &function_7d5c283a10c16742 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "spawnDropCrate", &function_99f8c763aafc55f6 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "onPlayerEnterGulag", &function_5a85e0cf7b436bc5 );
    dropstruct br_supply_drops_common::function_9d48fde0cd4ee1d5( "pe_crate_drop", "onPlayerRespawn", &onplayerrespawn );
    dropstruct.var_7aab74785fcbe440 = 1;
    var_84b20951617728e4 = getdvarint( @"hash_6e2a7271b0aaecd4", 8000 );
    dropstruct.var_c491715796150d41 = var_84b20951617728e4 * var_84b20951617728e4;
    game[ "dialog" ][ "dropbag_incoming" ] = "drpb_wzan_gmst";
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0xf0c10155, Offset: 0xca3
// Size: 0xf6
function deactivate()
{
    foreach ( crate in level.var_9db6eb11c1c26691 )
    {
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        playfx( level.conf_fx[ "vanish" ], crate.origin );
        
        if ( isdefined( crate.smokesignal ) )
        {
            crate.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
            crate.smokesignal delete();
        }
        
        crate airdrop::deletecrateimmediate();
        level.var_9db6eb11c1c26691 = arrayremove( level.var_9db6eb11c1c26691, crate );
    }
}

// Namespace br_publicevent_lootcratedrop
// Params 1
// Checksum 0x413d8ca3, Offset: 0xda1
// Size: 0x96
function function_14d162f15e1c89ea( safecircles )
{
    weightedsum = 0;
    
    foreach ( circle in safecircles )
    {
        weightedsum += circle.radius;
    }
    
    return weightedsum;
}

// Namespace br_publicevent_lootcratedrop
// Params 2
// Checksum 0x64c2a915, Offset: 0xe40
// Size: 0xa7
function function_88da3c54afa4d06( safecircles, chosenweight )
{
    weightedsum = 0;
    
    foreach ( circle in safecircles )
    {
        weightedsum += circle.radius;
        
        if ( chosenweight <= weightedsum )
        {
            return circle;
        }
    }
}

// Namespace br_publicevent_lootcratedrop
// Params 3
// Checksum 0x1e8a82bf, Offset: 0xef0
// Size: 0x66
function function_f4a74d0985adbc4d( dangercircleorigin, var_cb24cf87629cbede, chosencircleradius )
{
    var_ab3b5f46ec0a597d = function_82be59d175c17525( dangercircleorigin, var_cb24cf87629cbede, chosencircleradius );
    droppoint = br_circle::getrandompointinboundscircle( var_ab3b5f46ec0a597d.origin, var_ab3b5f46ec0a597d.radius, 0, 0.85, 1, 1 );
    return droppoint;
}

// Namespace br_publicevent_lootcratedrop
// Params 3
// Checksum 0x6fb606a9, Offset: 0xf5f
// Size: 0xde
function function_82be59d175c17525( dangercircleorigin, var_cb24cf87629cbede, chosencircleradius )
{
    var_517b3190cb3e45c3 = distance2d( dangercircleorigin, var_cb24cf87629cbede );
    var_ccaa83380be3b1bb = int( chosencircleradius / 2 );
    
    if ( var_517b3190cb3e45c3 != 0 )
    {
        var_f4ebfd5d8b2a0da = int( var_cb24cf87629cbede[ 0 ] - var_ccaa83380be3b1bb / var_517b3190cb3e45c3 * ( var_cb24cf87629cbede[ 0 ] - dangercircleorigin[ 0 ] ) );
        var_f4ec0d5d8b2a30d = int( var_cb24cf87629cbede[ 1 ] - var_ccaa83380be3b1bb / var_517b3190cb3e45c3 * ( var_cb24cf87629cbede[ 1 ] - dangercircleorigin[ 1 ] ) );
    }
    else
    {
        var_f4ebfd5d8b2a0da = int( dangercircleorigin[ 0 ] );
        var_f4ec0d5d8b2a30d = int( dangercircleorigin[ 1 ] );
    }
    
    var_f4ebdd5d8b29c74 = 0;
    var_ab3b5f46ec0a597d = spawnstruct();
    var_ab3b5f46ec0a597d.origin = ( var_f4ebfd5d8b2a0da, var_f4ec0d5d8b2a30d, var_f4ebdd5d8b29c74 );
    var_ab3b5f46ec0a597d.radius = var_ccaa83380be3b1bb;
    return var_ab3b5f46ec0a597d;
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0x63f623ae, Offset: 0x1046
// Size: 0xb2
function function_5a85e0cf7b436bc5()
{
    if ( !( isdefined( self ) && isdefined( level.var_9db6eb11c1c26691 ) ) )
    {
        return;
    }
    
    foreach ( crate in level.var_9db6eb11c1c26691 )
    {
        if ( !( isdefined( crate ) && isdefined( crate.scriptedobjid ) ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( crate.scriptedobjid, self );
    }
}

// Namespace br_publicevent_lootcratedrop
// Params 0
// Checksum 0x49f92303, Offset: 0x1100
// Size: 0xb2
function onplayerrespawn()
{
    if ( !( isdefined( self ) && isdefined( level.var_9db6eb11c1c26691 ) ) )
    {
        return;
    }
    
    foreach ( crate in level.var_9db6eb11c1c26691 )
    {
        if ( !( isdefined( crate ) && isdefined( crate.scriptedobjid ) ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_addshowplayer( crate.scriptedobjid, self );
    }
}

