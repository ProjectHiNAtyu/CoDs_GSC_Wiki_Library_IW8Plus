// scripts\mp\br\gametypes\br_publicevent_auavscan.gsc  (hash_14e055205236c408.gscc) (size: 10449 Bytes / 0x28d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb50ac6a5 (3037382309)
// size ...... 10449 (0x28d1)
// includes .. 11  (offset: 0x25f9)
// strings ... 38  (offset: 0x2651)
// dev strs .. 3   (offset: 0x28ad)
// exports ... 35  (offset: 0x1789)
// cseg ...... 0x3d4 + 0x13b5 (0x1789)
// imports ... 73  (offset: 0x1d01)
// animtree1 . 0   (offset: 0x28d1)
// animtree2 . 0   (offset: 0x28d1)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\class;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_message;

#namespace br_publicevent_auavscan;

// Namespace br_publicevent_auavscan
// Params 0, eflags: 0x1
// Checksum 0xd9b66e71, Offset: 0x3f2
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"auavscan", &init );
}

// Namespace br_publicevent_auavscan
// Params 1
// Checksum 0x1c1d05c0, Offset: 0x411
// Size: 0x5f
function init( eventinfo )
{
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
    callback::add( #"player_spawned", &onplayerspawned );
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xd7a48cc7, Offset: 0x478
// Size: 0x20c
function postinitfunc()
{
    game[ "dialog" ][ "pe_auavscan_name" ] = "ccpt_wzan_name";
    game[ "dialog" ][ "pe_auavscan_boost" ] = "ccpt_wzan_boos";
    game[ "dialog" ][ "pe_auavscan_anticipation" ] = "ccpt_wzan_ntcp";
    game[ "dialog" ][ "pe_auavscan_anticipation_water" ] = "ccpt_wzan_ntcw";
    game[ "dialog" ][ "pe_auavscan_clear" ] = "ccpt_wzan_cler";
    game[ "dialog" ][ "pe_auavscan_spotted" ] = "ccpt_wzan_sptt";
    game[ "dialog" ][ "pe_auavscan_unseen" ] = "ccpt_wzan_nsen";
    game[ "dialog" ][ "pe_auavscan_enemies_spotted" ] = "ccpt_wzan_nmsp";
    game[ "music" ][ "pe_auavscan_music_spotted" ] = [ "auavscan_player_spotted" ];
    game[ "music" ][ "pe_auavscan_music_not_spotted" ] = [ "auavscan_player_not_spotted" ];
    level.pe_auavscan = spawnstruct();
    level.pe_auavscan.var_540e4f741fbdf347 = getdvarfloat( @"hash_c99bfc3e5afba5c1", 12.5 );
    level.pe_auavscan.var_9ab6feee0359a10a = getdvarfloat( @"hash_2c9cd3eeac399508", 20 );
    level.pe_auavscan.var_955821a6a0c71344 = getdvarfloat( @"hash_412b4e845571f956", 5 );
    level.pe_auavscan.var_a7e9986a639755ef = getdvarfloat( @"hash_714066e581602c95", 3 );
    level.pe_auavscan.var_db18ecf26aef6e7c = getdvarfloat( @"hash_bfbe620dc5c15a26", 5 );
    level.pe_auavscan.var_80f12610ae2c9b29 = getdvarfloat( @"hash_2d42a2458e48b139", 5 );
    level.pe_auavscan.minstarttime = getdvarfloat( @"hash_a03525c8d67db059", 90 );
    level.pe_auavscan.maxstarttime = getdvarfloat( @"hash_a01237c8d6579037", 565 );
    level.var_f4732b8d53fc36ce = 1;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x37bd7b7f, Offset: 0x68c
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x46bd8749, Offset: 0x6c3
// Size: 0x6e
function calculateeventstarttime()
{
    if ( level.pe_auavscan.maxstarttime > level.pe_auavscan.minstarttime )
    {
        return randomfloatrange( level.pe_auavscan.minstarttime, level.pe_auavscan.maxstarttime );
    }
    
    return level.pe_auavscan.minstarttime;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x9e52dfae, Offset: 0x739
// Size: 0x75
function activatefunc()
{
    level endon( #"game_ended" );
    
    if ( !level.var_f4732b8d53fc36ce )
    {
        script::demoforcesre( "Occupation Scan activated but not initialized." );
        return;
    }
    
    function_c30618a9c3aef8db();
    level.pe_auavscan.spotted_players = [];
    br_publicevents::showsplashtoall( "br_pe_auavscan_incoming", "splash_list_br_pe_auavscan" );
    level thread br_public::brleaderdialog( "pe_auavscan_name", 1, undefined, 0, 0, undefined );
    wait 3.5;
    thread scananticipation();
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x5a2c1413, Offset: 0x7b6
// Size: 0x5e
function function_c30618a9c3aef8db()
{
    if ( isdefined( level.starttimefrommatchstart ) )
    {
        var_fc60fe850575a3df = level.pe_auavscan.minstarttime * 1000 + level.starttimefrommatchstart;
        
        if ( var_fc60fe850575a3df > gettime() )
        {
            waittime = ( var_fc60fe850575a3df - gettime() ) / 1000;
            wait waittime;
        }
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x2b3d052e, Offset: 0x81c
// Size: 0x1c4
function scananticipation()
{
    level endon( #"game_ended" );
    var_ccac589024249048 = gettime() + level.pe_auavscan.var_540e4f741fbdf347 * 1000;
    thread function_7ea4b2e9b5d13b7e();
    level thread br_public::brleaderdialog( "pe_auavscan_boost", 1, undefined, 0, 0, undefined );
    setomnvar( "ui_publicevent_timer_type", 7 );
    setomnvar( "ui_publicevent_timer", var_ccac589024249048 );
    setomnvar( "ui_minimap_pulse", 1 );
    level.pe_auavscan_active = 1;
    thread function_2d5e448879f698dc();
    thread function_543548342a2d6fc();
    wait level.pe_auavscan.var_540e4f741fbdf347;
    var_1f161920375dd42d = gettime() + level.pe_auavscan.var_955821a6a0c71344 * 1000;
    setomnvar( "ui_publicevent_timer_type", 8 );
    setomnvar( "ui_publicevent_timer", var_1f161920375dd42d );
    level.activeadvanceduavcount += level.teamnamelist.size;
    
    foreach ( player in level.players )
    {
        if ( !player function_4c740987764c0ee7() )
        {
            continue;
        }
        
        player.var_e8358ebbd9814fc2 = 1;
        player thread radaractive();
        
        if ( player isplayerhidden() )
        {
            player thread scanactive( var_1f161920375dd42d );
            continue;
        }
        
        player thread function_1789eb184d4295b2();
    }
    
    level notify( #"uav_update" );
    function_c9522f542d3d0cea();
}

// Namespace br_publicevent_auavscan
// Params 1
// Checksum 0x855a8063, Offset: 0x9e8
// Size: 0x43
function scanactive( var_1f161920375dd42d )
{
    level endon( #"game_ended" );
    thread function_3d69a0a9ba2d4863( var_1f161920375dd42d );
    thread watchweaponfired( var_1f161920375dd42d );
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 0 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 1 );
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x80b99509, Offset: 0xa33
// Size: 0x25
function radaractive()
{
    level endon( #"game_ended" );
    self playsoundtoplayer( #"hash_dc04d68208e64993", self );
    function_e0728f969906d8c1();
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xa92af526, Offset: 0xa60
// Size: 0xa9
function function_c9522f542d3d0cea()
{
    wait level.pe_auavscan.var_955821a6a0c71344;
    scanend();
    
    if ( level.pe_auavscan.spotted_players.size == 0 )
    {
        level thread br_public::brleaderdialog( "pe_auavscan_unseen", 1, undefined, 0, 0, undefined );
    }
    else
    {
        wait level.pe_auavscan.var_9ab6feee0359a10a;
        level thread br_public::brleaderdialog( "pe_auavscan_clear", 1, level.pe_auavscan.spotted_players, 0, 0, undefined );
    }
    
    level.activeadvanceduavcount -= level.teamnamelist.size;
    radarend();
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x4cec296a, Offset: 0xb11
// Size: 0xec
function scanend()
{
    level notify( #"hash_82a0f7e3f3aaa87a" );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var_e8bf831bc8a7fb17 = level.players.size;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            var_e8bf831bc8a7fb17--;
            continue;
        }
        
        if ( player.var_67f9271bfc789fd4 )
        {
            var_e8bf831bc8a7fb17--;
        }
        
        player function_23263efc10eadaeb();
    }
    
    branalytics_pe_auavscan( var_e8bf831bc8a7fb17, level.pe_auavscan.spotted_players.size );
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x96d8dfa5, Offset: 0xc05
// Size: 0x178
function function_23263efc10eadaeb()
{
    if ( !self.var_1789eb184d4295b2 )
    {
        self notify( #"hash_25eed09e76cb9102" );
        
        if ( isalive( self ) && !br_public::isplayerinorgoingtogulag() && self.var_e8358ebbd9814fc2 )
        {
            thread points::giveunifiedpoints( #"br_pe_auavscan_unspotted" );
            numtracks = game[ "music" ][ "pe_auavscan_music_not_spotted" ].size;
            tracknum = randomint( numtracks );
            self setplayermusicstate( game[ "music" ][ "pe_auavscan_music_not_spotted" ][ tracknum ] );
            self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 0 );
        }
    }
    
    if ( !self.var_67f9271bfc789fd4 && level.pe_auavscan.spotted_players.size > 0 )
    {
        hasspottedenemy = undefined;
        
        foreach ( potentialenemy in level.pe_auavscan.spotted_players )
        {
            if ( potentialenemy.team != self.team )
            {
                hasspottedenemy = 1;
                break;
            }
        }
        
        if ( hasspottedenemy )
        {
            level thread br_public::brleaderdialogplayer( "pe_auavscan_enemies_spotted", self, 1, 0, 0, undefined );
        }
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xd896cd7a, Offset: 0xd85
// Size: 0x9b
function radarend()
{
    level.pe_auavscan_active = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_e9d2ba0ee6e5216e();
    }
    
    level notify( #"uav_update" );
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xa7d63501, Offset: 0xe28
// Size: 0x7a
function function_e9d2ba0ee6e5216e()
{
    self notify( #"pe_auavscan_end" );
    player::function_e4f77222086e66b( 0 );
    self setplayeradvanceduavdot( 0 );
    self function_b61d02621fd0a2d8( 0 );
    
    if ( self.var_1789eb184d4295b2 )
    {
        self.var_63af23aefc9695 = gettime();
    }
    
    self.var_1789eb184d4295b2 = undefined;
    self.var_e8358ebbd9814fc2 = undefined;
    self.var_67f9271bfc789fd4 = undefined;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 0 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 0 );
    resetradar();
}

// Namespace br_publicevent_auavscan
// Params 1
// Checksum 0xdc07723a, Offset: 0xeaa
// Size: 0x62
function function_3d69a0a9ba2d4863( var_1f161920375dd42d )
{
    level endon( #"game_ended" );
    level endon( #"hash_82a0f7e3f3aaa87a" );
    self endon( #"death_or_disconnect" );
    player::function_e4f77222086e66b( 1 );
    self function_b61d02621fd0a2d8( 0 );
    
    while ( var_1f161920375dd42d > gettime() )
    {
        if ( !isplayerhidden() )
        {
            thread function_1789eb184d4295b2();
            break;
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_auavscan
// Params 1
// Checksum 0xff4827c1, Offset: 0xf14
// Size: 0xd2
function watchweaponfired( var_1f161920375dd42d )
{
    level endon( #"game_ended" );
    level endon( #"hash_82a0f7e3f3aaa87a" );
    self endon( #"pe_auavscan_player_spotted" );
    self endon( #"death_or_disconnect" );
    
    while ( var_1f161920375dd42d > gettime() )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( self.var_1789eb184d4295b2 )
        {
            break;
        }
        
        if ( class::isweaponsilenced( objweapon ) )
        {
            continue;
        }
        
        player::function_e4f77222086e66b( 0 );
        self function_b61d02621fd0a2d8( 0 );
        self setplayeradvanceduavdot( 1 );
        wait level.pe_auavscan.var_80f12610ae2c9b29;
        self setplayeradvanceduavdot( 0 );
        self function_b61d02621fd0a2d8( istrue( self.var_1789eb184d4295b2 ) );
        player::function_e4f77222086e66b( !self.var_1789eb184d4295b2 );
    }
}

// Namespace br_publicevent_auavscan
// Params 1
// Checksum 0x7745a055, Offset: 0xfee
// Size: 0x5d
function onplayerspawned( params )
{
    if ( level.pe_auavscan_active )
    {
        excludeplayer();
        resetradar();
        player::function_e4f77222086e66b( 1 );
        self function_b61d02621fd0a2d8( 0 );
        self setplayeradvanceduavdot( 0 );
        self.var_1789eb184d4295b2 = undefined;
        self.var_e8358ebbd9814fc2 = undefined;
        level notify( #"uav_update" );
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xef56ec45, Offset: 0x1053
// Size: 0x127
function function_2d5e448879f698dc()
{
    level endon( #"game_ended" );
    
    if ( level.pe_auavscan.var_540e4f741fbdf347 >= level.pe_auavscan.var_a7e9986a639755ef )
    {
        warningtime = level.pe_auavscan.var_540e4f741fbdf347 - level.pe_auavscan.var_a7e9986a639755ef;
        wait warningtime;
        
        foreach ( player in level.players )
        {
            if ( !player function_4c740987764c0ee7() || player isplayerhidden() )
            {
                continue;
            }
            
            var_a5ce3d46545b6e5a = player isswimming() ? "pe_auavscan_anticipation_water" : "pe_auavscan_anticipation";
            level thread br_public::brleaderdialogplayer( var_a5ce3d46545b6e5a, player, 1, 0, 0, undefined );
        }
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x9758f7c6, Offset: 0x1182
// Size: 0x100
function function_543548342a2d6fc()
{
    level endon( #"game_ended" );
    
    if ( level.pe_auavscan.var_540e4f741fbdf347 >= level.pe_auavscan.var_db18ecf26aef6e7c )
    {
        excludetime = level.pe_auavscan.var_540e4f741fbdf347 - level.pe_auavscan.var_db18ecf26aef6e7c;
        wait excludetime;
    }
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) && !player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player excludeplayer();
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x436f4384, Offset: 0x128a
// Size: 0x26
function excludeplayer()
{
    self.var_67f9271bfc789fd4 = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", -1 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 0 );
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x555046d8, Offset: 0x12b8
// Size: 0x20, Type: bool
function function_4c740987764c0ee7()
{
    return isalive( self ) && !br_public::isplayerinorgoingtogulag() && !self.var_67f9271bfc789fd4;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xf5652a93, Offset: 0x12e1
// Size: 0x111
function function_1789eb184d4295b2()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"pe_auavscan_player_spotted" );
    level.pe_auavscan.spotted_players[ level.pe_auavscan.spotted_players.size ] = self;
    self.var_1789eb184d4295b2 = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 1 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 2 );
    hud_message::showsplash( "br_pe_auavscan_spotted", undefined, undefined, undefined, undefined, "splash_list_br_pe_auavscan" );
    level thread br_public::brleaderdialogplayer( "pe_auavscan_spotted", self, 1, 0, 0, undefined );
    self setplayeradvanceduavdot( 0 );
    player::function_e4f77222086e66b( 0 );
    self function_b61d02621fd0a2d8( 1 );
    thread function_b651242fee555740();
    wait 0.25;
    numtracks = game[ "music" ][ "pe_auavscan_music_spotted" ].size;
    tracknum = randomint( numtracks );
    self setplayermusicstate( game[ "music" ][ "pe_auavscan_music_spotted" ][ tracknum ] );
    self playsoundtoplayer( #"sfx_occupation_scan_spotted_flash", self );
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xb1984857, Offset: 0x13fa
// Size: 0x49
function function_b651242fee555740()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.iszombie )
    {
        self visionsetnakedforplayer( "pe_auavscan_flash", 0.075 );
        wait 0.1;
        player::restorebasevisionset( 2.5 );
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xdf55c5d0, Offset: 0x144b
// Size: 0x56
function function_e0728f969906d8c1()
{
    forceradarstrength = level.uavbestid;
    radartype = "constant_radar";
    activeadvanceduavs = 1;
    skipuavupdate = 1;
    activateforceradar( radartype, forceradarstrength, activeadvanceduavs, skipuavupdate );
    self.hasradar = 1;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x9ab2e2b2, Offset: 0x14a9
// Size: 0x53
function resetradar()
{
    forceradarstrength = level.uavnoneid;
    radartype = "normal_radar";
    activeadvanceduavs = 0;
    skipuavupdate = undefined;
    activateforceradar( radartype, forceradarstrength, activeadvanceduavs, skipuavupdate );
    self.hasradar = 0;
}

// Namespace br_publicevent_auavscan
// Params 4
// Checksum 0xf79fad17, Offset: 0x1504
// Size: 0xc0
function activateforceradar( radartype, forceradarstrength, activeadvanceduavs, skipuavupdate )
{
    level.radarmode[ self.guid ] = radartype;
    self.radarstrength = forceradarstrength;
    level.activeuavs[ self.guid + "_radarStrength" ] = forceradarstrength;
    level.activeadvanceduavs[ self.guid ] = activeadvanceduavs;
    self.skipuavupdate = skipuavupdate;
    var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
    
    if ( isdefined( var_ec86cf09b79859c3 ) )
    {
        level [[ var_ec86cf09b79859c3 ]]( [ self ] );
    }
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x8d28cbf7, Offset: 0x15cc
// Size: 0xd9
function function_7ea4b2e9b5d13b7e()
{
    level endon( #"game_ended" );
    
    if ( level.pe_auavscan.var_540e4f741fbdf347 >= 13 )
    {
        wait level.pe_auavscan.var_540e4f741fbdf347 - 13;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            player thread function_98da8fcee9c02674();
        }
    }
    
    wait 13;
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0x4ae0ceb0, Offset: 0x16ad
// Size: 0x3e
function function_98da8fcee9c02674()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self playlocalsound( "uin_wz2_occupation_pre_scan_timer" );
    utility::waittill_any_timeout( 13, "death" );
    self stoplocalsound( "uin_wz2_occupation_pre_scan_timer" );
}

// Namespace br_publicevent_auavscan
// Params 2
// Checksum 0x92646c3e, Offset: 0x16f3
// Size: 0x15
function branalytics_pe_auavscan( availableplayerscount, spottedplayerscount )
{
    
}

// Namespace br_publicevent_auavscan
// Params 0
// Checksum 0xd5a409a6, Offset: 0x1710
// Size: 0x17, Type: bool
function isplayerhidden()
{
    return self getstance() == "prone" || swim_common::isplayerunderwater();
}

/#

    // Namespace br_publicevent_auavscan
    // Params 0
    // Checksum 0x9865d23b, Offset: 0x1730
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_auavscan
    // Params 0
    // Checksum 0x6d5f4ff2, Offset: 0x173d
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x46>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_auavscan
    // Params 0
    // Checksum 0x780280b5, Offset: 0x1773
    // Size: 0x16, Type: dev
    function debug_start_event()
    {
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"auavscan" );
    }

#/
