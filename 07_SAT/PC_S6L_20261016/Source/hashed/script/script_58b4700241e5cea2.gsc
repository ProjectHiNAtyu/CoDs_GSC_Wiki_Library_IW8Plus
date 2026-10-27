// script_58b4700241e5cea2  (hash_58b4700241e5cea2.gscc) (size: 21439 Bytes / 0x53bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14b280a6 (347242662)
// size ...... 21439 (0x53bf)
// includes .. 20  (offset: 0x4f4b)
// strings ... 42  (offset: 0x4feb)
// dev strs .. 31  (offset: 0x524b)
// exports ... 64  (offset: 0x31c3)
// cseg ...... 0x3f2 + 0x2dd1 (0x31c3)
// imports ... 163 (offset: 0x3bc3)
// animtree1 . 0   (offset: 0x53bf)
// animtree2 . 0   (offset: 0x53bf)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace activity_hmh_hunt_squad;

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x5
// Checksum 0xdc996ddb, Offset: 0x410
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_hmh_hunt_squad", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x62e322ef, Offset: 0x439
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HUNT_SQUAD", &hunt_squad_activity_type_init );
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0x40cc7858, Offset: 0x454
// Size: 0xa8
function hunt_squad_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 0, &hunt_squad_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 1, &hunt_squad_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 2, &hunt_squad_activity_cleanup );
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 3, &hunt_squad_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 4, &function_1306012c3b2aff86 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HUNT_SQUAD", 5, &function_c8f446591d6b9c0b );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &hunt_squad_player_joined_activity, "REV_OB_HUNT_SQUAD" );
    level.ob_hunt_squad_throttle = throttle::throttle_initialize( "ob_hunt_squad_spawn", 10, level.framedurationseconds );
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0xd3bfdf4, Offset: 0x504
// Size: 0x4a
function hunt_squad_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    logstring( "HUNT SQUAD ACTIVITY IS ACTIVATED" );
    self.difficulty_region = get_variant_difficulty();
    thread function_b6cb9e106e349c1e();
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0xf46cd8df, Offset: 0x556
// Size: 0x1c9
function hunt_squad_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_1a119998172aa8a0 = 0;
    hunterdef = self.var_91c91f4a631c481d.hunterdef;
    victim = self.targetedsquad[ 0 ];
    radiusmin = self.var_91c91f4a631c481d.var_1ca58a63d88f0d47;
    radiusmax = self.var_91c91f4a631c481d.var_1cc97863d8b76069;
    
    foreach ( def in hunterdef )
    {
        radiusmin = min( radiusmin, def.var_1b5180042e5cfe2d ?? radiusmin );
        radiusmax = min( radiusmax, def.var_1b2e6a042e368613 ?? radiusmax );
    }
    
    assert( radiusmin < radiusmax );
    playerlist = level.players;
    playerlist = arrayremove( playerlist, self.targetedsquad );
    self.var_dcfc1eadd1e86272 = undefined;
    activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_started", playerlist );
    activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_started_warn_targeted", self.targetedsquad );
    activity_player_broadcasting::function_cb4750c84882dd07( "wcahuntbrief", self.playerparticipants );
    level thread function_45d1f879fcf29f59( self );
    thread function_29357ecfb245d347();
    thread function_f67111613ec2690a( victim );
    thread function_710f0a9a49728d51();
    thread function_5cbb75887a45e42c();
    thread function_f34c19c78edf7a4e();
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0xed2fd0aa, Offset: 0x727
// Size: 0x9
function hunt_squad_activity_cleanup()
{
    kill_all_hunters();
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0x64768a6b, Offset: 0x738
// Size: 0x2
function hunt_squad_activity_destroy()
{
    
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0xc84c032, Offset: 0x742
// Size: 0x140
function init()
{
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"scr_hmh_hunt_squad_enabled", 1 ) )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level.var_4b2393962da9d19c = { #var_97bec25a190e1e14:[], #var_9e9a016aa4ca19be:0, #var_87449c973343263:0, #activationcount:0, #enabled:0, #variantregistered:0, #activitydefname:%"hash_1068e56cdddad891", #var_784e036b356329cd:getdvarint( @"hash_9d7e3ea1b00412fe", 15 ), #var_315868abc72ccc5:getdvarint( @"hash_feac0d047bb7ac18", 1 ), #var_8aa6be9e14ba0614:[], #var_e3af1c9ba0bdba05:[], #var_cc0e4315eede2fec:[] };
    level callback::add( #"player_death", &function_9b68cee1bb4b2727 );
    
    if ( !function_94795680491a2202() )
    {
        return;
    }
    
    level.var_4b2393962da9d19c.variantregistered = function_dcb76b068a4df653();
    level.var_4b2393962da9d19c.enabled = level.var_4b2393962da9d19c.variantregistered;
    
    /#
        dev_registerdevgui();
    #/
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x552aefc4, Offset: 0x88a
// Size: 0x9d
function private function_9b68cee1bb4b2727( deathdata )
{
    if ( !level.var_4b2393962da9d19c || !level.var_4b2393962da9d19c.enabled )
    {
        return;
    }
    
    attacker = deathdata.attacker;
    victim = self;
    function_349fc9ab5337db6d( victim );
    
    if ( !attacker || !isplayer( attacker ) )
    {
        return;
    }
    
    if ( attacker == victim || attacker.team == victim.team )
    {
        return;
    }
    
    function_449d40709b5f1a8c( attacker, 1 );
}

// Namespace activity_hmh_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0x41d03b93, Offset: 0x92f
// Size: 0x12d
function private function_449d40709b5f1a8c( player, amount )
{
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    squadid = player.sessionsquadid;
    
    if ( !isdefined( squadid ) )
    {
        return;
    }
    
    playerentnum = player getentitynumber();
    
    if ( !isdefined( playerentnum ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_4b2393962da9d19c.var_8aa6be9e14ba0614[ playerentnum ] ) )
    {
        level.var_4b2393962da9d19c.var_8aa6be9e14ba0614[ playerentnum ] = 0;
    }
    
    level.var_4b2393962da9d19c.var_8aa6be9e14ba0614[ playerentnum ] += amount;
    level.var_4b2393962da9d19c.var_e3af1c9ba0bdba05[ squadid ] = function_a250cf03c3270063( squadid );
    threshold = getdvarint( @"hash_9d7e3ea1b00412fe", level.var_4b2393962da9d19c.var_784e036b356329cd );
    
    if ( level.var_4b2393962da9d19c.var_e3af1c9ba0bdba05[ squadid ] >= threshold )
    {
        function_476f45f7fd597c2c( player );
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x77b8865f, Offset: 0xa64
// Size: 0x8f
function private function_349fc9ab5337db6d( player )
{
    if ( !level.var_4b2393962da9d19c || !player )
    {
        return;
    }
    
    squadid = player.sessionsquadid;
    
    if ( !isdefined( squadid ) )
    {
        return;
    }
    
    playerentnum = player getentitynumber();
    
    if ( !isdefined( playerentnum ) )
    {
        return;
    }
    
    level.var_4b2393962da9d19c.var_8aa6be9e14ba0614[ playerentnum ] = 0;
    level.var_4b2393962da9d19c.var_e3af1c9ba0bdba05[ squadid ] = function_a250cf03c3270063( squadid );
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x5bb4a6f2, Offset: 0xafb
// Size: 0xef
function private function_a250cf03c3270063( squadid )
{
    if ( !level.var_4b2393962da9d19c || !isdefined( squadid ) )
    {
        return 0;
    }
    
    totalkills = 0;
    
    foreach ( squadplayer in level.players )
    {
        if ( !squadplayer || squadplayer.sessionsquadid != squadid )
        {
            continue;
        }
        
        playerentnum = squadplayer getentitynumber();
        
        if ( isdefined( playerentnum ) )
        {
            totalkills += level.var_4b2393962da9d19c.var_8aa6be9e14ba0614[ playerentnum ] ?? 0;
        }
    }
    
    return totalkills;
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x2b12d46e, Offset: 0xbf3
// Size: 0x11c
function private function_476f45f7fd597c2c( player )
{
    if ( !level.var_4b2393962da9d19c || !level.var_4b2393962da9d19c.enabled )
    {
        return;
    }
    
    maxactivations = getdvarint( @"hash_8f0a9040a050cdee", 1 );
    
    if ( level.var_4b2393962da9d19c.activationcount >= maxactivations )
    {
        return;
    }
    
    cooldownms = getdvarint( @"hash_d79bb4bb1609b76a", 0 ) * 1000;
    
    if ( cooldownms > 0 && gettime() - level.var_4b2393962da9d19c.var_87449c973343263 < cooldownms )
    {
        return;
    }
    
    if ( !function_94795680491a2202() || !function_dcb76b068a4df653() )
    {
        return;
    }
    
    level.var_4b2393962da9d19c.activationcount++;
    level.var_4b2393962da9d19c.var_87449c973343263 = gettime();
    var_5a4bbdc885dd9960 = getdvarint( @"hash_66b5917081a49322", 0 );
    
    if ( var_5a4bbdc885dd9960 )
    {
        function_14664e86c2ccaed8();
        return;
    }
    
    function_76eaea4f9323c791( player );
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xa6dbcd70, Offset: 0xd17
// Size: 0x6d
function private function_76eaea4f9323c791( player )
{
    function_e2e87588a9c4ae91();
    squadid = player.sessionsquadid;
    
    if ( !isdefined( squadid ) )
    {
        return;
    }
    
    squadmembers = teams::getteamdata( player.team, "players" );
    
    if ( !squadmembers || squadmembers.size == 0 )
    {
        return;
    }
    
    function_dfeb231670f5e38f( player, squadmembers, squadid );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xaebb46ab, Offset: 0xd8c
// Size: 0x149
function private function_14664e86c2ccaed8()
{
    function_e2e87588a9c4ae91();
    var_6836fa21fa1928c5 = [];
    
    foreach ( squadplayer in level.players )
    {
        if ( !squadplayer || !isalive( squadplayer ) )
        {
            continue;
        }
        
        squadid = squadplayer.sessionsquadid;
        
        if ( !isdefined( squadid ) || arraycontains( var_6836fa21fa1928c5, squadid ) )
        {
            continue;
        }
        
        var_6836fa21fa1928c5[ var_6836fa21fa1928c5.size ] = squadid;
        squadmembers = teams::getteamdata( squadplayer.team, "players" );
        
        if ( !squadmembers || squadmembers.size == 0 )
        {
            continue;
        }
        
        huntinstance = function_dfeb231670f5e38f( squadplayer, squadmembers, squadid );
        
        if ( huntinstance )
        {
            huntinstance.spawnslot = var_6836fa21fa1928c5.size - 1;
            huntinstance.spreadcount = 1;
            huntinstance.spawnmode = #"near_squad";
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 3, eflags: 0x4
// Checksum 0x8007d665, Offset: 0xedd
// Size: 0xf1
function private function_dfeb231670f5e38f( player, squadmembers, squadid )
{
    huntinstance = activity_instance_common::function_9b387cb1af0d5b4b( "hmh_hunt_squad" );
    
    if ( !huntinstance )
    {
        return;
    }
    
    huntinstance.team = player.team;
    huntinstance.targetedplayer = player;
    huntinstance.targetedsquad = squadmembers;
    huntinstance.var_9f001652cfede319 = squadid;
    huntinstance.var_1c5ec68ab5e06141 = level.var_4b2393962da9d19c.var_9e9a016aa4ca19be;
    level.var_4b2393962da9d19c.var_9e9a016aa4ca19be++;
    activity_participation::function_fb0ec90aaf6d4c61( huntinstance, squadmembers );
    level.var_4b2393962da9d19c.var_cc0e4315eede2fec[ level.var_4b2393962da9d19c.var_cc0e4315eede2fec.size ] = huntinstance;
    huntinstance thread function_6dc083a725d1f8ea( squadid );
    return huntinstance;
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x9809bcee, Offset: 0xfd7
// Size: 0xa1
function private function_6dc083a725d1f8ea( squadid )
{
    utility::waittill_any( "activity_failed", "activity_succeeded", "activity_ended", "instance_destroyed" );
    
    if ( level.var_4b2393962da9d19c )
    {
        level.var_4b2393962da9d19c.var_cc0e4315eede2fec = arrayremove( level.var_4b2393962da9d19c.var_cc0e4315eede2fec, self );
        level.var_4b2393962da9d19c.var_e3af1c9ba0bdba05[ squadid ] = 0;
        
        if ( isdefined( self.var_1c5ec68ab5e06141 ) )
        {
            level.var_4b2393962da9d19c.var_97bec25a190e1e14[ self.var_1c5ec68ab5e06141 ] = undefined;
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xd2a47b38, Offset: 0x1080
// Size: 0xa1, Type: bool
function private function_8b4b7d22f1a86d65( squadid )
{
    foreach ( instance in level.var_4b2393962da9d19c.var_cc0e4315eede2fec )
    {
        if ( instance && instance.var_9f001652cfede319 == squadid )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x3cb0b85d, Offset: 0x112a
// Size: 0xd2
function private function_e2e87588a9c4ae91()
{
    var_b325b71fe7dbe842 = [];
    
    foreach ( instance in level.var_4b2393962da9d19c.var_cc0e4315eede2fec )
    {
        if ( instance )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                var_b325b71fe7dbe842[ var_b325b71fe7dbe842.size ] = instance;
            }
        }
    }
    
    level.var_4b2393962da9d19c.var_cc0e4315eede2fec = var_b325b71fe7dbe842;
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xd9634a61, Offset: 0x1204
// Size: 0xa8, Type: bool
function private function_94795680491a2202()
{
    if ( !isdefined( level.activities.types[ "REV_OB_HUNT_SQUAD" ] ) )
    {
        activity_common::registeractivitytype( "REV_OB_HUNT_SQUAD", &hunt_squad_activity_type_init );
    }
    
    if ( isdefined( level.activities.types[ "REV_OB_HUNT_SQUAD" ] ) )
    {
        var_a7b237b60a134ca0 = activity_common::getactivityfunction( "REV_OB_HUNT_SQUAD", 0 );
        
        if ( var_a7b237b60a134ca0 != &hunt_squad_activity_setup )
        {
            hunt_squad_activity_type_init();
        }
    }
    
    return isdefined( level.activities.types[ "REV_OB_HUNT_SQUAD" ] ) && activity_common::getactivityfunction( "REV_OB_HUNT_SQUAD", 0 ) == &hunt_squad_activity_setup;
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xc09fc209, Offset: 0x12b5
// Size: 0xfc
function private function_dcb76b068a4df653()
{
    if ( level.var_4b2393962da9d19c.variantregistered )
    {
        return 1;
    }
    
    if ( isdefined( level.activities.definitions[ "hmh_hunt_squad" ] ) )
    {
        level.var_4b2393962da9d19c.variantregistered = 1;
        return 1;
    }
    
    bundlename = level.var_4b2393962da9d19c.activitydefname;
    
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = "activityDefinition:" + bundlename;
    }
    
    testbundle = getscriptbundle( bundlename );
    
    if ( !testbundle )
    {
        return 0;
    }
    
    activity_definition_utils::function_74af1ab4059e3c06( level.var_4b2393962da9d19c.activitydefname, "hmh_hunt_squad" );
    level.var_4b2393962da9d19c.variantregistered = isdefined( level.activities.definitions[ "hmh_hunt_squad" ] );
    return level.var_4b2393962da9d19c.variantregistered;
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xab3ae16b, Offset: 0x13ba
// Size: 0xf0
function private function_45d1f879fcf29f59( activityinstance )
{
    splashradius = getdvarfloat( @"hash_381ccfc11dad5358", 15000 );
    centerpoint = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    
    if ( !isdefined( centerpoint ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( utility::function_92fc197c20834b39( player, centerpoint, splashradius ) )
        {
            if ( arraycontains( activityinstance.playerparticipants, player ) )
            {
                player thread hud_message::showsplash( "hmh_hunt_squad_begin" );
                continue;
            }
            
            player thread hud_message::showsplash( "hmh_hunt_squad_started" );
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0
// Checksum 0xf04966be, Offset: 0x14b2
// Size: 0x72
function function_1306012c3b2aff86()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( self.hmhspawnorigin ) )
    {
        return self.hmhspawnorigin;
    }
    
    if ( self.targetedsquad && self.targetedsquad.size > 0 && self.targetedsquad[ 0 ] )
    {
        return self.targetedsquad[ 0 ].origin;
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1
// Checksum 0x6f1e5ce3, Offset: 0x152d
// Size: 0x7f
function function_c8f446591d6b9c0b( relevantinfostruct )
{
    player = self.playerparticipants[ 0 ];
    var_ed2431ff5fd3b5d8 = player.origin + anglestoforward( player.angles ) * 60;
    var_ed2431ff5fd3b5d8 = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    var_ed2431ff5fd3b5d8 = utility::drop_to_ground( var_ed2431ff5fd3b5d8 );
    return { #angles:( 0, 0, 0 ), #origin:var_ed2431ff5fd3b5d8 };
}

// Namespace activity_hmh_hunt_squad
// Params 1
// Checksum 0x409e462e, Offset: 0x15b5
// Size: 0x43
function hunt_squad_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xabd6bd91, Offset: 0x1600
// Size: 0x66
function private get_variant_difficulty()
{
    switch ( self.varianttag )
    {
        case #"hash_dd4f312323622680":
            return "difficulty_normal";
        case #"hash_c1bdd93a79fa145":
            return "difficulty_hard";
        case #"hash_e4fb02047562e71f":
            return "difficulty_darkaether";
        default:
            break;
    }
    
    return "difficulty5";
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xd87a91e0, Offset: 0x166f
// Size: 0xb3
function private function_b6cb9e106e349c1e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_983496ed0e255b87" );
    
    while ( !isdefined( self.targetedplayer ) || !self.targetedsquad || self.targetedsquad.size == 0 )
    {
        wait 0.5;
    }
    
    player = self.targetedplayer;
    thread function_4fcea5d5529a90a1();
    self waittill( #"hash_dc93e7c7dc0aa3b2" );
    
    if ( !self.playerparticipants || self.playerparticipants.size == 0 )
    {
        activity_participation::function_bc67362dace4370c( self, player );
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x493f09dc, Offset: 0x172a
// Size: 0x77
function private function_4fcea5d5529a90a1()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        wait 0.5;
        var_b5c90541b5c69991 = function_4fd2df065f9534dc();
        
        if ( var_b5c90541b5c69991 )
        {
            wait 10;
            var_b5c90541b5c69991 = function_4fd2df065f9534dc();
            
            if ( var_b5c90541b5c69991 )
            {
                self notify( #"hash_dc93e7c7dc0aa3b2" );
                return;
            }
        }
        
        if ( !var_b5c90541b5c69991 )
        {
            self notify( #"hash_983496ed0e255b87" );
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x9382014b, Offset: 0x17a9
// Size: 0x87, Type: bool
function private function_4fd2df065f9534dc()
{
    foreach ( player in self.targetedsquad )
    {
        if ( player && is_selectable_player( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_hmh_hunt_squad
// Params 4, eflags: 0x4
// Checksum 0x78580a59, Offset: 0x1839
// Size: 0xda
function private on_ai_spawn( requestid, activityinstance, agent, data )
{
    agent.difficulty = activityinstance.difficulty_region;
    function_b66e941d33f91758( agent.origin );
    
    if ( isdefined( agent getscriptablepartstate( "active_camo_fx", 0 ) ) )
    {
        agent setscriptablepartstate( "active_camo_fx", "on", 0 );
        agent thread function_718e2c7c44b4d325();
    }
    else
    {
        agent hide();
        agent thread function_e353264103650d50();
    }
    
    /#
        var_9bc0385277ad41da = getdvarint( @"scr_hunters_health", 0 );
        
        if ( var_9bc0385277ad41da )
        {
            agent.maxhealth = var_9bc0385277ad41da;
            agent.health = var_9bc0385277ad41da;
            agent.currenthealth = var_9bc0385277ad41da;
        }
    #/
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x95c7aeef, Offset: 0x191b
// Size: 0xd0
function private function_a61a461ccfa9d1bb()
{
    if ( self.hunters.size > 0 )
    {
        foreach ( hunter in self.hunters )
        {
            if ( hunter.unittype == "juggernaut" && hunter.subclass != "ob_specialist" )
            {
                if ( hunter.subclass == "juggerbot" )
                {
                    hunter.var_e94a0381e288005e = undefined;
                }
                
                hunter kill();
            }
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x2b85726d, Offset: 0x19f3
// Size: 0x74
function private function_ca8d0c48f716d11a()
{
    activity_player_broadcasting::function_cb4750c84882dd07( "wcahuntsuccess", self.playerparticipants );
    activity_definition_utils::updateprogress( 1, self );
    activity_instance_common::endactivity( self, 1 );
    
    if ( isdefined( self.team ) )
    {
        if ( getdvarint( @"hash_7cdc5807e35bcda2", 0 ) )
        {
            level thread gamelogic_mp::endgame( self.team, game[ "end_reason" ][ "Warzone Victory" ], game[ "end_reason" ][ "Warzone Victory" ] );
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0xa87ddd3f, Offset: 0x1a6f
// Size: 0x6a
function private function_710f0a9a49728d51()
{
    self notify( #"hash_a5e3d123072c7e3a" );
    self endon( #"hash_a5e3d123072c7e3a" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_f0236642e81742a6();
    self waittill( #"all_enemies_killed" );
    self.var_1a119998172aa8a0 = 1;
    self.var_dcfc1eadd1e86272 = #"all_enemies_killed";
    function_ca8d0c48f716d11a();
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x2418f44a, Offset: 0x1ae1
// Size: 0x5c
function private function_29357ecfb245d347()
{
    self endon( #"instance_destroyed" );
    self waittill( #"activity_succeeded" );
    
    if ( self.var_dcfc1eadd1e86272 == #"all_enemies_killed" )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "all_enemies_killed_success", self.playerparticipants );
        return;
    }
    
    activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_timer_elapsed_success", self.playerparticipants );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0x52057d27, Offset: 0x1b45
// Size: 0x76
function private function_f0236642e81742a6()
{
    self notify( #"hash_91463f5e7bc5179d" );
    self endon( #"hash_91463f5e7bc5179d" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self waittill( #"hunter_spawned" );
    self waittill( #"hash_38a920518e5eecbd" );
    
    while ( true )
    {
        if ( self.hunters.size <= 0 )
        {
            wait 1;
            self notify( #"all_enemies_killed" );
            break;
        }
        
        waitframe();
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0xc0c58684, Offset: 0x1bc3
// Size: 0xf9
function private function_5cbb75887a45e42c()
{
    self notify( #"hash_be07d2fcfa56920e" );
    self endon( #"hash_be07d2fcfa56920e" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        var_5f5c5a0192d0043e = 0;
        
        foreach ( player in self.targetedsquad )
        {
            if ( !is_eliminated( player ) )
            {
                var_5f5c5a0192d0043e = 1;
                break;
            }
        }
        
        if ( !var_5f5c5a0192d0043e )
        {
            self.var_1a119998172aa8a0 = 1;
            activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_failure", self.playerparticipants );
            activity_instance_common::endactivity( self, 0 );
            return;
        }
        
        waitframe();
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0xc
// Checksum 0xa75df72d, Offset: 0x1cc4
// Size: 0x10f
function private function_f67111613ec2690a( victim )
{
    self notify( #"hash_9acebb0117576d5c" );
    self endon( #"hash_9acebb0117576d5c" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_c4f995ee51dd96c9 = victim.origin;
    var_350a490a9d62d678 = 50;
    encounterbundle = self.var_91c91f4a631c481d.encounterbundle ?? %"hash_47af487e84de9ac9";
    
    if ( level.var_4b2393962da9d19c && isdefined( self.var_1c5ec68ab5e06141 ) )
    {
        level.var_4b2393962da9d19c.var_97bec25a190e1e14[ self.var_1c5ec68ab5e06141 ] = var_c4f995ee51dd96c9;
    }
    
    self.hmhspawnorigin = var_c4f995ee51dd96c9;
    var_54751450da1ab486 = getdvarfloat( @"scr_hmh_hunt_squad_encounter_radius", 15000 );
    bundleorigin = function_865c291d093a4931( var_c4f995ee51dd96c9, var_350a490a9d62d678, var_54751450da1ab486 );
    function_b556d7e2a5acc3c9( encounterbundle, bundleorigin, var_54751450da1ab486, 1 );
    function_31b57acf80ab192d();
}

// Namespace activity_hmh_hunt_squad
// Params 4, eflags: 0x4
// Checksum 0x77d087, Offset: 0x1ddb
// Size: 0xee
function private function_b556d7e2a5acc3c9( encounterbundle, var_baf209ff7a0a9961, encounterradius, notifysettled = 1 )
{
    self.var_5fd4f33182929db7 = 0;
    requestid = activity_ai_encounters::function_eb8506829193f5eb( encounterbundle, var_baf209ff7a0a9961, encounterradius, 1, 0, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( requestid, &on_ai_spawn, self );
    function_64ac8c4e752f4dca( requestid, 0 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( requestid, &function_31c7dda921228aff, self );
    utility::waittill_any_timeout( 5, "hunter_spawned" );
    
    if ( self.var_5fd4f33182929db7 > 0 )
    {
        while ( true )
        {
            var_7b8c2ae0fabf99b6 = self.var_5fd4f33182929db7;
            wait 5;
            
            if ( self.var_5fd4f33182929db7 == var_7b8c2ae0fabf99b6 )
            {
                break;
            }
        }
    }
    
    if ( notifysettled )
    {
        self notify( #"hash_38a920518e5eecbd" );
        activity_player_broadcasting::function_cb4750c84882dd07( "wcahuntclose", self.playerparticipants );
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x7a0228b9, Offset: 0x1ed1
// Size: 0x79
function private function_b66e941d33f91758( var_baf209ff7a0a9961 )
{
    smokegrenadeweapon = equipment_mp::getweaponfromequipmentref( "equip_smoke" );
    
    if ( smokegrenadeweapon )
    {
        smokegrenadeent = magicgrenademanual( smokegrenadeweapon.basename, var_baf209ff7a0a9961, ( 0, 0, -10 ), 0 );
        thread utility::delaythread( 0.05, &utility::play_sound_in_space, "smoke_grenade_expl_trans", smokegrenadeent.origin );
        wait 2;
    }
}

// Namespace activity_hmh_hunt_squad
// Params 4, eflags: 0x4
// Checksum 0x7ac3d9e8, Offset: 0x1f52
// Size: 0x205
function private agent_spawned_callback( request_id, userdata, agent, data )
{
    activity_instance = userdata;
    agent.activity_instance = activity_instance;
    agent.var_4f8a92ebabf37ee = 0;
    
    if ( !isdefined( activity_instance ) || activity_instance.state != "Active" )
    {
        assertmsg( "<dev string:x24>" + agent.origin );
        agent kill();
        return;
    }
    
    if ( !isdefined( activity_instance.hunters ) )
    {
        activity_instance.hunters = [];
    }
    
    activity_instance.hunters[ activity_instance.hunters.size ] = agent;
    agent callback::add( #"on_ai_damaged", &function_94b0d803de348edd );
    agent callback::add( #"on_ai_killed", &function_4ba9cac82361a653 );
    agent.var_789b7a49ee864fec = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( activity_instance.var_91c91f4a631c481d.objectivemarker, 0, 0 );
    objidpoolmanager::update_objective_onentity( agent.var_789b7a49ee864fec, agent );
    objidpoolmanager::objective_playermask_showtoall( agent.var_789b7a49ee864fec );
    hunter_def = activity_instance get_hunter_def( agent );
    agent.rush_radius = hunter_def.rushradius ?? 256;
    agent.var_1b5180042e5cfe2d = hunter_def.var_1b5180042e5cfe2d ?? activity_instance.var_91c91f4a631c481d.var_1ca58a63d88f0d47;
    agent.var_1b2e6a042e368613 = hunter_def.var_1b2e6a042e368613 ?? activity_instance.var_91c91f4a631c481d.var_1cc97863d8b76069;
    agent thread hunter_think( agent.rush_radius );
    agent thread function_cecfe95d3331d881( activity_instance.var_91c91f4a631c481d.huntercooldown );
}

// Namespace activity_hmh_hunt_squad
// Params 2
// Checksum 0x6c763b79, Offset: 0x215f
// Size: 0x112
function function_31c7dda921228aff( requestid, userdata )
{
    activity_instance = userdata;
    
    if ( !isdefined( activity_instance ) || activity_instance.state != "Active" )
    {
        logstring( "[Hunt Squad] hunter squad spawned but activity is not in active state!" );
    }
    
    data = function_9b649316adcccbaa( requestid );
    
    foreach ( agent in data.ai )
    {
        if ( isalive( agent ) )
        {
            agent_spawned_callback( requestid, userdata, agent, undefined );
        }
    }
    
    if ( !isdefined( activity_instance.var_5fd4f33182929db7 ) )
    {
        activity_instance.var_5fd4f33182929db7 = 0;
    }
    
    activity_instance.var_5fd4f33182929db7++;
    activity_instance notify( #"hunter_spawned" );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x9fdd5949, Offset: 0x2279
// Size: 0x81
function private function_31b57acf80ab192d()
{
    encounterradius = getdvarfloat( @"scr_hmh_hunt_squad_encounter_radius", 15000 );
    var_baf209ff7a0a9961 = function_865c291d093a4931( self.targetedsquad[ 0 ].origin, 0, encounterradius );
    requestid = activity_ai_encounters::function_eb8506829193f5eb( %"hash_bed5dd3624c373b", var_baf209ff7a0a9961, encounterradius, 1, 0, 1, 0 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_flood_fill, { #activityinstance:self } );
}

// Namespace activity_hmh_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0xff7d3a4f, Offset: 0x2302
// Size: 0x40
function private should_shutdown_flood_fill( requestid, userdata )
{
    activityinstance = userdata.activityinstance;
    
    if ( !activityinstance )
    {
        return 1;
    }
    
    return activityinstance.var_1a119998172aa8a0;
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x149447c5, Offset: 0x234b
// Size: 0xb3
function private get_hunter_def( agent )
{
    hunterdef = self.var_91c91f4a631c481d.hunterdef;
    
    foreach ( def in hunterdef )
    {
        if ( def.aisubclass == getxhashasset( agent.subclass ) )
        {
            return def;
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xb8aeb46f, Offset: 0x2407
// Size: 0x8e
function private function_94b0d803de348edd( params )
{
    attacker = params.eattacker;
    
    if ( self.activity_instance && self.activity_instance.state == "Active" && attacker && isplayer( attacker ) )
    {
        if ( !self.var_827963e03bcde4f2 )
        {
            self.var_827963e03bcde4f2 = attacker;
        }
        
        if ( self.var_535d5f86a8d4761b != attacker )
        {
            self.var_535d5f86a8d4761b = attacker;
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xf9004e31, Offset: 0x249d
// Size: 0x73
function private function_4ba9cac82361a653( params )
{
    activity_instance = self.activity_instance;
    
    if ( activity_instance && activity_instance.state == "Active" )
    {
        activity_instance.hunters = arrayremove( activity_instance.hunters, self );
        activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_789b7a49ee864fec );
        self.var_789b7a49ee864fec = undefined;
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x6d7c2ff2, Offset: 0x2518
// Size: 0x1d9
function private hunter_think( rushradius )
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.5;
        activityinstance = self.activity_instance;
        
        if ( !activityinstance || activityinstance.state != "Active" )
        {
            break;
        }
        
        var_c0ecbe656d191aa2 = !self.var_827963e03bcde4f2 || !is_selectable_player( self.var_827963e03bcde4f2 );
        
        if ( var_c0ecbe656d191aa2 )
        {
            self.var_827963e03bcde4f2 = activityinstance select_victim_player( self );
        }
        
        if ( self.var_827963e03bcde4f2 )
        {
            self getenemyinfo( self.var_827963e03bcde4f2 );
            goalpos = getclosestpointonnavmesh( self.var_827963e03bcde4f2.origin );
            disttoenemysquared = distancesquared( goalpos, self.origin );
            var_3db98cf41c81d71 = disttoenemysquared < squared( activityinstance.var_91c91f4a631c481d.hunterradius ) && disttoenemysquared > squared( rushradius );
            
            if ( !var_3db98cf41c81d71 )
            {
                self notify( #"hash_7078c4bdb4d4c709" );
                continue;
            }
            
            if ( issubstr( self.agent_type, "jugg" ) )
            {
                self.goalradius = int( rushradius );
                self.script_goalradius = rushradius;
                self setgoalpos( goalpos );
            }
            else
            {
                self notify( #"hash_7078c4bdb4d4c709" );
                thread ai_behavior::behavior_combatRushOrigin( self, goalpos, rushradius );
            }
            
            /#
                if ( getdvarint( @"scr_hunt_squad_debug", 0 ) )
                {
                    debugstar( goalpos, ( 1, 1, 0 ), 20, "<dev string:x6e>", 1 );
                    line( self.origin, goalpos, ( 1, 1, 0 ), 1, 0, 20 );
                }
            #/
        }
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x254a7ad4, Offset: 0x26f9
// Size: 0x7e
function private function_cecfe95d3331d881( huntercooldown )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( !self.var_827963e03bcde4f2 || !self.var_535d5f86a8d4761b || !is_selectable_player( self.var_535d5f86a8d4761b ) )
        {
            continue;
        }
        
        if ( self.var_827963e03bcde4f2 != self.var_535d5f86a8d4761b )
        {
            self.var_827963e03bcde4f2 = self.var_535d5f86a8d4761b;
        }
        
        wait huntercooldown;
    }
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x4af373ec, Offset: 0x277f
// Size: 0xce
function private select_victim_player( agent = undefined )
{
    activity_instance = self;
    candidates = [];
    
    foreach ( player in activity_instance.playerparticipants )
    {
        if ( is_selectable_player( player, agent ) )
        {
            candidates[ candidates.size ] = player;
        }
    }
    
    if ( candidates.size <= 0 )
    {
        return;
    }
    
    randindex = randomintrange( 0, candidates.size );
    return candidates[ randindex ];
}

// Namespace activity_hmh_hunt_squad
// Params 6, eflags: 0x4
// Checksum 0x13ac098c, Offset: 0x2856
// Size: 0xd2
function private random_origin( origin, radiusmin, radiusmax, direction = undefined, minangle = 0, maxangle = 360 )
{
    random_degree = randomfloatrange( minangle, maxangle );
    radius = sqrt( randomfloatrange( squared( radiusmin ), squared( radiusmax ) ) );
    
    if ( !isdefined( direction ) )
    {
        new_origin = origin + ( cos( random_degree ) * radius, sin( random_degree ) * radius, 0 );
    }
    else
    {
        new_origin = origin + rotatevector( direction, ( 0, random_degree, 0 ) ) * radius;
    }
    
    new_origin = utility::drop_to_ground( new_origin );
    return getclosestpointonnavmesh( new_origin );
}

// Namespace activity_hmh_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0x3b087e10, Offset: 0x2931
// Size: 0x6f, Type: bool
function private is_selectable_player( player, agent = undefined )
{
    if ( agent )
    {
        if ( distancesquared( player.origin, agent.origin ) > squared( self.var_91c91f4a631c481d.hunterradius ) )
        {
            return false;
        }
    }
    
    return !player::isinlaststand( player ) && !is_eliminated( player );
}

// Namespace activity_hmh_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x70da2626, Offset: 0x29a9
// Size: 0x22, Type: bool
function private is_eliminated( player )
{
    return !player::isreallyalive( player ) && !player::isinlaststand( player );
}

// Namespace activity_hmh_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0x6e2e9b97, Offset: 0x29d4
// Size: 0x2b2, Type: bool
function private is_valid_spawn_point( point, player_check_distance )
{
    activity_instance = self;
    
    if ( getdvarint( @"hash_9a90b66d9c0505d2", 1 ) )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( is_selectable_player( player ) && utility::ispointinsidecircle( player.origin, point, player_check_distance ) )
            {
                /#
                    if ( getdvarint( @"scr_hunt_squad_debug", 0 ) )
                    {
                        debugstar( point, ( 1, 0, 0 ), 2000, "<dev string:x8c>", 1 );
                        line( player.origin, point, ( 1, 0, 0 ), 1, 0, 2000 );
                    }
                #/
                
                return false;
            }
        }
        
        if ( hastacgraph() )
        {
            var_a82f0cfa39301f09 = findclosesttacpoint( point );
            
            if ( isdefined( var_a82f0cfa39301f09 ) )
            {
                foreach ( player in activity_instance.playerparticipants )
                {
                    var_ad9442398039a42d = findclosesttacpoint( player.origin );
                    
                    if ( isdefined( var_ad9442398039a42d ) && is_selectable_player( player ) && tacpointsvisible( var_a82f0cfa39301f09, var_ad9442398039a42d ) )
                    {
                        /#
                            if ( getdvarint( @"scr_hunt_squad_debug", 0 ) )
                            {
                                debugstar( point, ( 1, 0, 0 ), 2000, "<dev string:xa9>", 1 );
                                debugstar( var_a82f0cfa39301f09.origin, ( 1, 0.75, 0.75 ), 2000, "<dev string:xc1>", 1 );
                                debugstar( var_ad9442398039a42d.origin, ( 1, 0.75, 0.75 ), 2000, "<dev string:xe0>", 1 );
                                line( var_a82f0cfa39301f09.origin, point, ( 1, 0, 0 ), 1, 0, 2000 );
                                line( var_a82f0cfa39301f09.origin, var_ad9442398039a42d.origin, ( 1, 0.75, 0.75 ), 1, 0, 2000 );
                            }
                        #/
                        
                        return false;
                    }
                }
            }
        }
    }
    
    return true;
}

// Namespace activity_hmh_hunt_squad
// Params 6, eflags: 0x4
// Checksum 0xb5627b8b, Offset: 0x2c8f
// Size: 0xb2
function private function_865c291d093a4931( origin, radiusmin, radiusmax, direction = undefined, minangle = 0, maxangle = 360 )
{
    if ( !origin )
    {
        return;
    }
    
    point = undefined;
    
    for ( count = 0; count < 100 ; count++ )
    {
        point = random_origin( origin, radiusmin, radiusmax, direction, minangle, maxangle );
        
        if ( is_valid_spawn_point( point, radiusmin ) )
        {
            return point;
        }
        
        throttle::throttle_wait_in_queue( level.ob_hunt_squad_throttle, self );
    }
    
    return point;
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x57a0d58b, Offset: 0x2d4a
// Size: 0x4d
function private function_718e2c7c44b4d325()
{
    self endon( #"death" );
    self endon( #"recamo" );
    wait getdvarfloat( @"hash_934bad2d9cc21a83", 5 );
    
    if ( isdefined( self getscriptablepartstate( "active_camo_fx", 0 ) ) )
    {
        self setscriptablepartstate( "active_camo_fx", "deactivate", 0 );
    }
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x1835580d, Offset: 0x2d9f
// Size: 0x33
function private function_e353264103650d50()
{
    self endon( #"death" );
    self endon( #"recamo" );
    wait getdvarfloat( @"hash_934bad2d9cc21a83", 5 );
    self show();
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x58180649, Offset: 0x2dda
// Size: 0x3a
function private function_f34c19c78edf7a4e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level waittill( #"game_ended" );
    self.var_1a119998172aa8a0 = 1;
    activity_instance_common::function_9aeeabe50fc9cc3e( self );
}

// Namespace activity_hmh_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x13ee7d5a, Offset: 0x2e1c
// Size: 0xa2
function private kill_all_hunters()
{
    if ( !isdefined( self.hunters ) )
    {
        self.hunters = [];
    }
    
    foreach ( hunter in self.hunters )
    {
        if ( isalive( hunter ) )
        {
            hunter kill();
        }
    }
    
    self.hunters = [];
}

/#

    // Namespace activity_hmh_hunt_squad
    // Params 0, eflags: 0x4
    // Checksum 0x6ce0b55f, Offset: 0x2ec6
    // Size: 0x110, Type: dev
    function private dev_registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x106>" );
        devgui::add_devgui_func( "<dev string:x118>", "<dev string:x128>", &function_41eacb6bf141d0d5 );
        devgui::add_devgui_func( "<dev string:x147>", "<dev string:x159>", &function_649e856f13dc38f5 );
        devgui::add_devgui_func( "<dev string:x17a>", "<dev string:x191>", &function_6b14b015521f66f8 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x1b2>", @"hash_66b5917081a49322" );
        devgui::add_devgui_dvar( "<dev string:x1c4>", "<dev string:x1d1>" );
        devgui::add_devgui_dvar( "<dev string:x1f1>", "<dev string:x201>" );
        devgui::add_devgui_dvar( "<dev string:x224>", "<dev string:x23c>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x263>", @"hash_ecd0a713c561ab63" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x274>", @"hash_1c44f8109f1cb85f" );
        devgui::add_devgui_dvar( "<dev string:x283>", "<dev string:x297>" );
        devgui::add_devgui_dvar( "<dev string:x2be>", "<dev string:x2cf>" );
        devgui::add_devgui_dvar( "<dev string:x2f3>", "<dev string:x30f>" );
        devgui::add_devgui_dvar( "<dev string:x33e>", "<dev string:x350>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_hmh_hunt_squad
    // Params 0, eflags: 0x4
    // Checksum 0x5980c5e3, Offset: 0x2fde
    // Size: 0x93, Type: dev
    function private function_8bc28961b9c5ef30()
    {
        foreach ( player in level.players )
        {
            if ( player && !isbot( player ) && isalive( player ) )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace activity_hmh_hunt_squad
    // Params 0, eflags: 0x4
    // Checksum 0x11738a69, Offset: 0x3079
    // Size: 0xd8, Type: dev
    function private function_41eacb6bf141d0d5()
    {
        if ( !level.var_4b2393962da9d19c )
        {
            return;
        }
        
        if ( !function_94795680491a2202() || !function_dcb76b068a4df653() )
        {
            return;
        }
        
        player = function_8bc28961b9c5ef30();
        
        if ( !player )
        {
            return;
        }
        
        squadid = player.sessionsquadid;
        squadmembers = teams::getteamdata( player.team, "<dev string:x371>" );
        
        if ( !squadmembers || squadmembers.size == 0 )
        {
            squadmembers = [ player ];
        }
        
        huntinstance = function_dfeb231670f5e38f( player, squadmembers, squadid );
        
        if ( huntinstance )
        {
            huntinstance.spawnslot = 0;
            huntinstance.spreadcount = 1;
            huntinstance.spawnmode = #"near_squad";
        }
    }

    // Namespace activity_hmh_hunt_squad
    // Params 0, eflags: 0x4
    // Checksum 0xa36f0083, Offset: 0x3159
    // Size: 0x25, Type: dev
    function private function_649e856f13dc38f5()
    {
        player = function_8bc28961b9c5ef30();
        
        if ( player )
        {
            function_476f45f7fd597c2c( player );
        }
    }

    // Namespace activity_hmh_hunt_squad
    // Params 0, eflags: 0x4
    // Checksum 0xd0ea11ff, Offset: 0x3186
    // Size: 0x3d, Type: dev
    function private function_6b14b015521f66f8()
    {
        if ( !level.var_4b2393962da9d19c )
        {
            return;
        }
        
        level.var_4b2393962da9d19c.activationcount = 0;
        level.var_4b2393962da9d19c.var_87449c973343263 = 0;
    }

#/
