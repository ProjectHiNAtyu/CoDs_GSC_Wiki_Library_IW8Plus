// script_2c92f3b5c431083f  (hash_2c92f3b5c431083f.gscc) (size: 10976 Bytes / 0x2ae0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bc10866 (1002506342)
// size ...... 10976 (0x2ae0)
// includes .. 13  (offset: 0x2880)
// strings ... 27  (offset: 0x28e8)
// dev strs .. 1   (offset: 0x2ad4)
// exports ... 37  (offset: 0x1944)
// cseg ...... 0x2c4 + 0x1680 (0x1944)
// imports ... 78  (offset: 0x1f0c)
// animtree1 . 0   (offset: 0x2ae0)
// animtree2 . 0   (offset: 0x2ae0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\swim_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\class;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_message;

#namespace namespace_d0b3a0f4af126e9f;

// Namespace namespace_d0b3a0f4af126e9f
// Params 0, eflags: 0x5
// Checksum 0xb6712265, Offset: 0x2e2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_6e8ef2dd548a67e4", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0, eflags: 0x4
// Checksum 0xb76b96ec, Offset: 0x30b
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_AUAVSCAN", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_AUAVSCAN" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0x1ba97885, Offset: 0x33b
// Size: 0x1d
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.waitfunc = &waitfunc;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xe8d588ea, Offset: 0x360
// Size: 0x74
function activity_type_init()
{
    if ( getdvarint( @"hash_d2210a829f0a2d4f", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AUAVSCAN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AUAVSCAN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AUAVSCAN", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_AUAVSCAN", 3, &function_d4acef179eb9f9b2 );
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xd5e98153, Offset: 0x3dc
// Size: 0x4a
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    function_1e220aa7a73d4641();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x98257be8, Offset: 0x42e
// Size: 0x52
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    function_c30618a9c3aef8db();
    level.pe_auavscan.spotted_players = [];
    wait 3.5;
    thread scananticipation();
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0x46a8cd84, Offset: 0x488
// Size: 0x2d
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    radarend();
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xf61cfa3e, Offset: 0x4bd
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x9932afe5, Offset: 0x4e1
// Size: 0x38b
function function_1e220aa7a73d4641()
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "pe_auavscan_name" ] ) )
    {
        game[ "dialog" ][ "pe_auavscan_name" ] = self.var_332f929de1894b2b.namevo;
        game[ "dialog" ][ "pe_auavscan_boost" ] = self.var_332f929de1894b2b.boostvo;
        game[ "dialog" ][ "pe_auavscan_anticipation" ] = self.var_332f929de1894b2b.anticipationvo;
        game[ "dialog" ][ "pe_auavscan_anticipation_water" ] = self.var_332f929de1894b2b.var_f033b9c84fba726d;
        game[ "dialog" ][ "pe_auavscan_clear" ] = self.var_332f929de1894b2b.clearvo;
        game[ "dialog" ][ "pe_auavscan_spotted" ] = self.var_332f929de1894b2b.spottedvo;
        game[ "dialog" ][ "pe_auavscan_unseen" ] = self.var_332f929de1894b2b.unseenvo;
        game[ "dialog" ][ "pe_auavscan_enemies_spotted" ] = self.var_332f929de1894b2b.var_3372843d553bf5e4;
        game[ "music" ][ "pe_auavscan_music_spotted" ] = [ "auavscan_player_spotted" ];
        game[ "music" ][ "pe_auavscan_music_not_spotted" ] = [ "auavscan_player_not_spotted" ];
    }
    
    level.pe_auavscan = spawnstruct();
    level.pe_auavscan.var_540e4f741fbdf347 = self.var_332f929de1894b2b.anticipationduration;
    level.pe_auavscan.var_9ab6feee0359a10a = self.var_332f929de1894b2b.radarduration;
    level.pe_auavscan.var_955821a6a0c71344 = self.var_332f929de1894b2b.proneduration;
    level.pe_auavscan.var_a7e9986a639755ef = self.var_332f929de1894b2b.var_9b0ad83e98dae479;
    level.pe_auavscan.var_db18ecf26aef6e7c = self.var_332f929de1894b2b.respawnthreshold;
    level.pe_auavscan.var_80f12610ae2c9b29 = self.var_332f929de1894b2b.var_80f12610ae2c9b29;
    level.pe_auavscan.minstarttime = self.var_332f929de1894b2b.var_98500b20ababf16c;
    level.pe_auavscan.maxstarttime = self.var_332f929de1894b2b.var_982c1920ab83957e;
    level.pe_auavscan.var_5658dafc2b6a1118 = self.var_332f929de1894b2b.var_5658dafc2b6a1118;
    level.pe_auavscan.visionsetholdtime = self.var_332f929de1894b2b.visionsetholdtime;
    level.pe_auavscan.var_de17805e03126dda = self.var_332f929de1894b2b.var_de17805e03126dda;
    level.pe_auavscan.var_f939f8ccb14c9714 = self.var_332f929de1894b2b.var_f939f8ccb14c9714;
    level.pe_auavscan.var_71c130511ee70ad2 = self.var_332f929de1894b2b.var_71c130511ee70ad2;
    level.pe_auavscan.var_1b270c68021287e5 = self.var_332f929de1894b2b.var_1b270c68021287e5;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xffb91f9d, Offset: 0x874
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x8eb9e3ab, Offset: 0x8ab
// Size: 0x6e
function calculateeventstarttime()
{
    if ( level.pe_auavscan.maxstarttime > level.pe_auavscan.minstarttime )
    {
        return randomfloatrange( level.pe_auavscan.minstarttime, level.pe_auavscan.maxstarttime );
    }
    
    return level.pe_auavscan.minstarttime;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xad3495cf, Offset: 0x921
// Size: 0x1d5
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
    setomnvar( "ui_publicevent_timer_type", 0 );
    wait 0.1;
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x7b57435c, Offset: 0xafe
// Size: 0x10c
function function_7ea4b2e9b5d13b7e()
{
    level endon( #"game_ended" );
    
    if ( level.pe_auavscan.var_540e4f741fbdf347 >= level.pe_auavscan.var_71c130511ee70ad2 )
    {
        wait level.pe_auavscan.var_540e4f741fbdf347 - level.pe_auavscan.var_71c130511ee70ad2;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            player thread function_98da8fcee9c02674();
        }
    }
    
    wait level.pe_auavscan.var_71c130511ee70ad2;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x72f5e40f, Offset: 0xc12
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x9dd68076, Offset: 0xc78
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x5f5c9324, Offset: 0xda7
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x6bb6b398, Offset: 0xeaf
// Size: 0x26
function excludeplayer()
{
    self.var_67f9271bfc789fd4 = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", -1 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 0 );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x9d54223a, Offset: 0xedd
// Size: 0x20, Type: bool
function function_4c740987764c0ee7()
{
    return isalive( self ) && !br_public::isplayerinorgoingtogulag() && !self.var_67f9271bfc789fd4;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x1da06d44, Offset: 0xf06
// Size: 0x17, Type: bool
function isplayerhidden()
{
    return self getstance() == "prone" || swim_common::isplayerunderwater();
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0xad83707f, Offset: 0xf26
// Size: 0x43
function scanactive( var_1f161920375dd42d )
{
    level endon( #"game_ended" );
    thread function_3d69a0a9ba2d4863( var_1f161920375dd42d );
    thread watchweaponfired( var_1f161920375dd42d );
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 0 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 1 );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xa8606515, Offset: 0xf71
// Size: 0x25
function radaractive()
{
    level endon( #"game_ended" );
    self playsoundtoplayer( #"hash_dc04d68208e64993", self );
    function_e0728f969906d8c1();
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xfc9b2bfe, Offset: 0xf9e
// Size: 0xac
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
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x55876f9a, Offset: 0x1052
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x4852768, Offset: 0x1146
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x582a8c84, Offset: 0x12c6
// Size: 0x116
function function_1789eb184d4295b2()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"pe_auavscan_player_spotted" );
    level.pe_auavscan.spotted_players[ level.pe_auavscan.spotted_players.size ] = self;
    self.var_1789eb184d4295b2 = 1;
    self setclientomnvar( "ui_publicevent_auavscan_spotted", 1 );
    self setclientomnvar( "ui_publicevent_fullscreen_atlas_type", 2 );
    hud_message::showsplash( level.pe_auavscan.var_1b270c68021287e5 );
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0xfa89613b, Offset: 0x13e4
// Size: 0x73
function function_b651242fee555740()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.iszombie )
    {
        self visionsetnakedforplayer( "pe_auavscan_flash", level.pe_auavscan.var_5658dafc2b6a1118 );
        wait level.pe_auavscan.visionsetholdtime;
        player::restorebasevisionset( level.pe_auavscan.var_de17805e03126dda );
    }
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x7522e2ee, Offset: 0x145f
// Size: 0x61
function function_e0728f969906d8c1()
{
    forceradarstrength = level.uavbestid;
    radartype = "constant_radar";
    activeadvanceduavs = 1;
    skipuavupdate = 1;
    activateforceradar( radartype, forceradarstrength, activeadvanceduavs, skipuavupdate );
    self.hasradar = 1;
    self.radarshowenemydirection = 1;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x30c5c58d, Offset: 0x14c8
// Size: 0x5d
function resetradar()
{
    forceradarstrength = level.uavnoneid;
    radartype = "normal_radar";
    activeadvanceduavs = 0;
    skipuavupdate = undefined;
    activateforceradar( radartype, forceradarstrength, activeadvanceduavs, skipuavupdate );
    self.hasradar = 0;
    self.radarshowenemydirection = 0;
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 4
// Checksum 0xdf465d0b, Offset: 0x152d
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x1092a998, Offset: 0x15f5
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x8f0fc51d, Offset: 0x1698
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0xf4de8226, Offset: 0x171a
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0x374c4323, Offset: 0x1784
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

// Namespace namespace_d0b3a0f4af126e9f
// Params 0
// Checksum 0x1e466b41, Offset: 0x185e
// Size: 0x64
function function_98da8fcee9c02674()
{
    level endon( #"game_ended" );
    self playlocalsound( level.pe_auavscan.var_f939f8ccb14c9714 );
    utility::waittill_any_timeout( level.pe_auavscan.var_71c130511ee70ad2, "death", "disconnect" );
    self stoplocalsound( level.pe_auavscan.var_f939f8ccb14c9714 );
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 2
// Checksum 0xbabd9c22, Offset: 0x18ca
// Size: 0x15
function branalytics_pe_auavscan( availableplayerscount, spottedplayerscount )
{
    
}

// Namespace namespace_d0b3a0f4af126e9f
// Params 1
// Checksum 0x5f9c5049, Offset: 0x18e7
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

