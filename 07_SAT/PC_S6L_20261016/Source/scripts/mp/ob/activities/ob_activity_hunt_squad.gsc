// scripts\mp\ob\activities\ob_activity_hunt_squad.gsc  (hash_31bb97fe8a0b59fa.gscc) (size: 21511 Bytes / 0x5407 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6412b8f3 (1678948595)
// size ...... 21511 (0x5407)
// includes .. 23  (offset: 0x511b)
// strings ... 33  (offset: 0x51d3)
// dev strs .. 10  (offset: 0x538f)
// exports ... 58  (offset: 0x3423)
// cseg ...... 0x371 + 0x30b2 (0x3423)
// imports ... 169 (offset: 0x3d33)
// animtree1 . 0   (offset: 0x5407)
// animtree2 . 0   (offset: 0x5407)
#using script_42e5e0757bb06731;
#using script_60cd1c57e94be8d7;
#using script_6e05fdc2c6f5fa06;
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
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\equipment;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_hunt_squad;

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x5
// Checksum 0xf694de62, Offset: 0x38f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_hunt_squad", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xafa24f9c, Offset: 0x3b8
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HUNT_SQUAD", &hunt_squad_activity_type_init );
}

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0x8d8d152b, Offset: 0x3d3
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

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0x73594a2, Offset: 0x483
// Size: 0x131
function hunt_squad_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.vtolsetting = self.var_91c91f4a631c481d.vtolsetting;
    self.hunter_counter = 0;
    self.vtoldata = namespace_cf9a4f547edbca10::function_879241d6eca278b();
    
    /#
        debug_init();
    #/
    
    logstring( "HUNT SQUAD ACTIVITY IS ACTIVATED" );
    setdvarifuninitialized( @"scr_hunt_squad_timer", self.var_91c91f4a631c481d.countdownsec );
    self.var_65df0799ff7d4a25 = [];
    self.var_c3f53e0e8f45dd31 = getdvarint( @"hash_25c8b76d3259140c", self.var_91c91f4a631c481d.var_c71fd8307e3dea01 );
    self.var_e0b295b2457dd6e1 = self.var_91c91f4a631c481d.var_a3338d17f7d2d638;
    self.var_76b2d47b9a08fb27 = self.var_91c91f4a631c481d.var_7651654968b9036;
    self.handler_list = [ "marshall", "karma" ];
    self.difficulty_region = get_variant_difficulty();
    thread function_b6cb9e106e349c1e();
}

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0x9e7bc6e6, Offset: 0x5bc
// Size: 0x1e7
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
    thread activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_warn_others", playerlist );
    thread activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_started_warn_targeted", self.targetedsquad );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcahuntbrief" );
    
    if ( self.vtolsetting.hasvtol )
    {
        spawn_vtol( victim );
    }
    
    thread function_da2adbc03bf402a0( victim );
    thread function_710f0a9a49728d51();
    thread function_5cbb75887a45e42c();
    thread function_9ce13e62fd1ad962();
    
    if ( self.enemyvtol )
    {
        self.enemyvtol vehicle_turnengineon();
        thread function_35f3dd5468f91472();
    }
}

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0x158b75c5, Offset: 0x7ab
// Size: 0x2
function hunt_squad_activity_cleanup()
{
    
}

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0xa389c767, Offset: 0x7b5
// Size: 0x2
function hunt_squad_activity_destroy()
{
    
}

/#

    // Namespace ob_activity_hunt_squad
    // Params 0
    // Checksum 0x2bb3b28c, Offset: 0x7bf
    // Size: 0x42, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2f>" + self.varianttag, "<dev string:x43>" + self.id, &function_708c64b3e2844664 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_hunt_squad
    // Params 1
    // Checksum 0x2c3c9014, Offset: 0x809
    // Size: 0x1d6, Type: dev
    function function_708c64b3e2844664( args )
    {
        player = level.players[ 0 ];
        clientnum = int( getdvar( @"hash_13d8008e8edc58d5", "<dev string:x5f>" ) );
        
        if ( clientnum != -1 )
        {
            client = utility::function_3bc2c606a1c39e2f( clientnum );
            
            if ( isplayer( client ) )
            {
                player = client;
            }
        }
        
        activityid = args[ 0 ];
        
        if ( activityid )
        {
            activity = level.activities.instances[ int( activityid ) ];
            squadid = namespace_1eb976e9755c4bbe::get_squad_id( player );
            squadmembers = player squad_utility::getsquadmembers();
            level.var_fd592aaf1a089f49[ squadid ] = activity.var_c3f53e0e8f45dd31;
            var_80d42672bf886089 = [];
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 0;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 6;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 9;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 15;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 18;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 23;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 26;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 30;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 35;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 40;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 45;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 48;
            var_80d42672bf886089[ var_80d42672bf886089.size ] = 60;
            fixed_loadout_index = 0;
            
            for ( index = 0; index < var_80d42672bf886089.size ; index++ )
            {
                if ( var_80d42672bf886089[ index ] > activity.var_76b2d47b9a08fb27 )
                {
                    break;
                }
                
                fixed_loadout_index = index;
            }
            
            setdvar( @"hash_242a3260d860611e", fixed_loadout_index + 1 );
            activity function_30470064a09e196( level.var_fd592aaf1a089f49[ squadid ], squadid, squadmembers );
            activity.targetedsquad = squadmembers;
            activity notify( #"target_selected", player );
        }
    }

#/

// Namespace ob_activity_hunt_squad
// Params 0
// Checksum 0x315084af, Offset: 0x9e7
// Size: 0x4a
function function_1306012c3b2aff86()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( self.enemyvtol )
    {
        centerpoint = self.enemyvtol.origin;
    }
    
    return centerpoint;
}

// Namespace ob_activity_hunt_squad
// Params 1
// Checksum 0xa8e111ef, Offset: 0xa3a
// Size: 0x7f
function function_c8f446591d6b9c0b( relevantinfostruct )
{
    player = self.playerparticipants[ 0 ];
    var_ed2431ff5fd3b5d8 = player.origin + anglestoforward( player.angles ) * 60;
    var_ed2431ff5fd3b5d8 = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    var_ed2431ff5fd3b5d8 = utility::drop_to_ground( var_ed2431ff5fd3b5d8 );
    return { #angles:( 0, 0, 0 ), #origin:var_ed2431ff5fd3b5d8 };
}

// Namespace ob_activity_hunt_squad
// Params 1
// Checksum 0x4cbbed33, Offset: 0xac2
// Size: 0xa4
function hunt_squad_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
    
    if ( self.countdown_begin )
    {
        timeremainingmillisec = self.countdown_begin + self.var_91c91f4a631c481d.countdownsec * 1000 - gettime();
        timeremainingsec = int( max( 0, timeremainingmillisec ) ) * 0.001;
        activity_definition_utils::updatetimer( timeremainingsec, self );
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x6c29f09d, Offset: 0xb6e
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

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x6f433d54, Offset: 0xbdd
// Size: 0xaf
function private function_35fb8ed572de424c( squad )
{
    var_8d6a97f6d7d72f3f = 0;
    
    foreach ( player in squad )
    {
        combatrating = player utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" );
        var_8d6a97f6d7d72f3f = max( combatrating, var_8d6a97f6d7d72f3f );
    }
    
    return var_8d6a97f6d7d72f3f;
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xc4d6366f, Offset: 0xc95
// Size: 0x6c
function private function_b6cb9e106e349c1e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_983496ed0e255b87" );
    thread function_e2163e12ce29a2a8();
    self waittill( #"target_selected", player );
    thread function_4fcea5d5529a90a1();
    self waittill( #"hash_dc93e7c7dc0aa3b2" );
    activity_participation::function_bc67362dace4370c( self, player );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x9da63a13, Offset: 0xd09
// Size: 0xd4
function private function_4fcea5d5529a90a1()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        wait 0.5;
        [ var_fe0a76be9631d013, var_f97c589d0431298b ] = function_4fd2df065f9534dc();
        var_b5c90541b5c69991 = var_fe0a76be9631d013 && !var_f97c589d0431298b;
        
        if ( var_b5c90541b5c69991 )
        {
            wait 10;
            [ var_fe0a76be9631d013, var_f97c589d0431298b ] = function_4fd2df065f9534dc();
            var_b5c90541b5c69991 = var_fe0a76be9631d013 && !var_f97c589d0431298b;
            
            if ( var_b5c90541b5c69991 )
            {
                self notify( #"hash_dc93e7c7dc0aa3b2" );
                return;
            }
        }
        
        if ( !var_fe0a76be9631d013 )
        {
            self notify( #"hash_983496ed0e255b87" );
            self.targetedsquad = undefined;
            wait 0.5;
            thread function_b6cb9e106e349c1e();
            return;
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xa3d3d543, Offset: 0xde5
// Size: 0xc7
function private function_4fd2df065f9534dc()
{
    var_fe0a76be9631d013 = 0;
    
    foreach ( player in self.targetedsquad )
    {
        if ( player && is_selectable_player( player ) )
        {
            var_fe0a76be9631d013 = 1;
            
            if ( player.activities.participatingactivities.size > 0 )
            {
                return [ 1, 1 ];
            }
        }
    }
    
    return [ var_fe0a76be9631d013, 0 ];
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x87ddb8a7, Offset: 0xeb5
// Size: 0x16e
function private function_e2163e12ce29a2a8()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"target_selected" );
    
    while ( true )
    {
        var_74014831d161e50f = [];
        
        foreach ( player in level.players )
        {
            waitframe();
            squadid = namespace_1eb976e9755c4bbe::get_squad_id( player );
            
            if ( var_74014831d161e50f[ squadid ] )
            {
                continue;
            }
            
            var_74014831d161e50f[ squadid ] = 1;
            squadmembers = player squad_utility::getsquadmembers();
            var_4ac3d076fb76b3ba = namespace_1eb976e9755c4bbe::get_squad_points( squadid );
            var_cb6ea7b0f3465697 = function_35fb8ed572de424c( squadmembers );
            var_1785cfbf3e6054f7 = var_cb6ea7b0f3465697 >= self.var_e0b295b2457dd6e1 && var_cb6ea7b0f3465697 <= self.var_76b2d47b9a08fb27;
            
            if ( var_4ac3d076fb76b3ba && var_1785cfbf3e6054f7 )
            {
                function_30470064a09e196( var_4ac3d076fb76b3ba, squadid, squadmembers );
                
                if ( var_4ac3d076fb76b3ba >= self.var_c3f53e0e8f45dd31 )
                {
                    self.targetedsquad = squadmembers;
                    self notify( #"target_selected", player );
                    return;
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_hunt_squad
// Params 4, eflags: 0x4
// Checksum 0xc7321563, Offset: 0x102b
// Size: 0x87
function private on_ai_spawn( requestid, activityinstance, agent, data )
{
    agent ob_humans::function_5bc0e59d126a6295( activityinstance.difficulty_region );
    
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

// Namespace ob_activity_hunt_squad
// Params 3, eflags: 0x4
// Checksum 0x3795eb19, Offset: 0x10ba
// Size: 0x7a
function private function_30470064a09e196( var_10c1726b32f12f2a, squadid, squad )
{
    if ( self.var_65df0799ff7d4a25[ squadid ] )
    {
        return;
    }
    
    var_de133a9220fa385f = float( var_10c1726b32f12f2a ) >= float( self.var_c3f53e0e8f45dd31 * 75 ) / 100;
    
    if ( var_de133a9220fa385f )
    {
        thread ob_activity_vo_utility::function_639b0047db8aec67( self, "wcahuntactivate", squad );
        self.var_65df0799ff7d4a25[ squadid ] = 1;
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xa78d7d92, Offset: 0x113c
// Size: 0xc8
function private function_2d197403a3a53925()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"all_enemies_killed" );
    countdown = getdvarint( @"scr_hunt_squad_timer", self.var_91c91f4a631c481d.countdownsec );
    activity_definition_utils::updatetimer( countdown, self );
    self.countdown_begin = gettime();
    thread count_down_broadcast( countdown );
    wait countdown;
    self notify( #"hunt_squad_timer_elapsed" );
    self.var_1a119998172aa8a0 = 1;
    function_252f38a16aef19cd();
    function_a61a461ccfa9d1bb();
    activity_player_broadcasting::function_cb4750c84882dd07( "hunt_squad_timer_elapsed_success", self.playerparticipants );
    self.successtype = #"timer_elapsed";
    function_ca8d0c48f716d11a();
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x251174e5, Offset: 0x120c
// Size: 0x3e
function private function_252f38a16aef19cd()
{
    enemyvtol = self.enemyvtol;
    
    if ( enemyvtol )
    {
        enemyvtol thread [[ self.vtoldata.flyaway ]]();
        self.enemyvtol = undefined;
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x5886c39c, Offset: 0x1252
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

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x88fb92df, Offset: 0x132a
// Size: 0x109
function private count_down_broadcast( time_remain_sec )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    broadcast_list = activity_instance.var_91c91f4a631c481d.broadcastlist;
    
    foreach ( broadcast in broadcast_list )
    {
        countdown = broadcast.countdownsec;
        
        if ( countdown < time_remain_sec )
        {
            time_to_wait = time_remain_sec - countdown;
            wait time_to_wait;
            time_remain_sec = countdown;
            activity_instance activity_player_broadcasting::function_cb4750c84882dd07( broadcast.activationname, activity_instance.playerparticipants );
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0xe9deeedf, Offset: 0x143b
// Size: 0x11c
function private function_56049680fd6e2da7()
{
    self notify( #"hash_90d7af00003e54d6" );
    self endon( #"hash_90d7af00003e54d6" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( self.enemyvtol && self.vtolsetting.hasvtol && self.vtolsetting.var_66fc7df58a2b1da )
    {
        self.enemyvtol waittill( #"explode" );
        self.enemyvtol playsound( "evt_hunt_squad_vtol_explo_lr" );
        self.bossspawnpoint = self.enemyvtol.origin;
        self.enemyvtol = undefined;
        ob_activity_vo_utility::function_639b0047db8aec67( self, "wcahuntbossintro" );
        playsoundatpos( self.bossspawnpoint, "evt_hunt_squad_juggerbot_airdrop_start_spawn" );
    }
    
    thread function_f0236642e81742a6();
    self waittill( #"all_enemies_killed" );
    activity_player_broadcasting::function_cb4750c84882dd07( "all_enemies_killed_success", self.playerparticipants );
    self.successtype = #"all_enemies_killed";
    function_ca8d0c48f716d11a();
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x94f3c80f, Offset: 0x155f
// Size: 0x23
function private function_ca8d0c48f716d11a()
{
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcahuntsuccess" );
    activity_definition_utils::updateprogress( 1, self );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0x9f8e7753, Offset: 0x158a
// Size: 0x40
function private function_710f0a9a49728d51()
{
    self notify( #"hash_3d3902cf9077ff6f" );
    self endon( #"hash_3d3902cf9077ff6f" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_56049680fd6e2da7();
    thread function_2d197403a3a53925();
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0xb898495b, Offset: 0x15d2
// Size: 0xda
function private function_f0236642e81742a6()
{
    self notify( #"hash_e565e70541dbd375" );
    self endon( #"hash_e565e70541dbd375" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hunt_squad_timer_elapsed" );
    encounterradius = self.var_91c91f4a631c481d.encounterradius;
    
    if ( self.vtolsetting.hasvtol && self.vtolsetting.var_66fc7df58a2b1da )
    {
        self.bossphase = 1;
        function_b556d7e2a5acc3c9( %"hash_40deeb8ba15076fb", self.bossspawnpoint, encounterradius );
    }
    
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

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0xc
// Checksum 0xede4e348, Offset: 0x16b4
// Size: 0xf5
function private function_5cbb75887a45e42c()
{
    self notify( #"hash_af1e8a34c4219789" );
    self endon( #"hash_af1e8a34c4219789" );
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
        
        if ( !var_5f5c5a0192d0043e || function_90c797f7000ce71() )
        {
            function_252f38a16aef19cd();
            self.var_1a119998172aa8a0 = 1;
            activity_instance_common::endactivity( self, 0 );
            return;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x6d39e66d, Offset: 0x17b1
// Size: 0x89, Type: bool
function private function_90c797f7000ce71()
{
    foreach ( player in self.targetedsquad )
    {
        if ( !arraycontains( level.var_6ccf11392270179e, player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0xc
// Checksum 0xe2bd518e, Offset: 0x1843
// Size: 0x151
function private function_da2adbc03bf402a0( victim )
{
    self notify( #"hash_c9969fb089ae21db" );
    self endon( #"hash_c9969fb089ae21db" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    enemyvtol = self.enemyvtol;
    
    while ( enemyvtol && !enemyvtol.isneartarget )
    {
        waitframe();
    }
    
    wait 2;
    var_c4f995ee51dd96c9 = enemyvtol ? enemyvtol.origin : victim.origin;
    var_350a490a9d62d678 = enemyvtol ? 0 : 50;
    encounterradius = self.var_91c91f4a631c481d.encounterradius;
    var_baf209ff7a0a9961 = function_865c291d093a4931( var_c4f995ee51dd96c9, var_350a490a9d62d678, encounterradius );
    encounterbundle = self.var_91c91f4a631c481d.encounterbundle ?? %"hash_47af487e84de9ac9";
    function_b556d7e2a5acc3c9( encounterbundle, var_baf209ff7a0a9961, encounterradius );
    function_31b57acf80ab192d();
    
    if ( enemyvtol && self.vtolsetting.hasvtol && !self.vtolsetting.var_66fc7df58a2b1da )
    {
        function_252f38a16aef19cd();
    }
}

// Namespace ob_activity_hunt_squad
// Params 3, eflags: 0x4
// Checksum 0x46e88d98, Offset: 0x199c
// Size: 0x91
function private function_b556d7e2a5acc3c9( encounterbundle, var_baf209ff7a0a9961, encounterradius )
{
    function_b66e941d33f91758( var_baf209ff7a0a9961 );
    requestid = activity_ai_encounters::function_eb8506829193f5eb( encounterbundle, var_baf209ff7a0a9961, encounterradius, 1, 0, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( requestid, &on_ai_spawn, self );
    function_64ac8c4e752f4dca( requestid, 0 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( requestid, &function_31c7dda921228aff, self );
    utility::waittill_any_timeout( 5, "hunter_spawned" );
    
    if ( !self.bossphase )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( self, "wcahuntclose" );
    }
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xb74345ca, Offset: 0x1a35
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

// Namespace ob_activity_hunt_squad
// Params 4, eflags: 0x4
// Checksum 0xc96f9d3d, Offset: 0x1ab6
// Size: 0x23a
function private agent_spawned_callback( request_id, userdata, agent, data )
{
    activity_instance = userdata;
    agent.activity_instance = activity_instance;
    agent.var_4f8a92ebabf37ee = 0;
    
    if ( !isdefined( activity_instance ) || activity_instance.state != "Active" )
    {
        assertmsg( "<dev string:x62>" + agent.origin );
        agent kill();
        return;
    }
    
    activity_instance.hunter_counter++;
    
    if ( !isdefined( activity_instance.hunters ) )
    {
        activity_instance.hunters = [];
    }
    
    activity_instance.hunters[ activity_instance.hunters.size ] = agent;
    
    if ( agent.subclass == "juggerbot" )
    {
        agent.var_e94a0381e288005e = #"hash_a107c5f937a8876e";
    }
    
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

// Namespace ob_activity_hunt_squad
// Params 2
// Checksum 0xab897603, Offset: 0x1cf8
// Size: 0xeb
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
    
    activity_instance notify( #"hunter_spawned" );
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xbd8e9a04, Offset: 0x1deb
// Size: 0x81
function private function_31b57acf80ab192d()
{
    enemyvtol = self.enemyvtol;
    
    if ( enemyvtol )
    {
        var_baf209ff7a0a9961 = function_865c291d093a4931( enemyvtol.origin, 0, 1500 );
        function_b66e941d33f91758( var_baf209ff7a0a9961 );
        requestid = activity_ai_encounters::function_eb8506829193f5eb( %"hash_56a3634ad8cf1b1b", var_baf209ff7a0a9961, 1500, 1, 0, 1, 0 );
        activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_flood_fill, { #activityinstance:self } );
    }
}

// Namespace ob_activity_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0xe0a9c937, Offset: 0x1e74
// Size: 0x50
function private should_shutdown_flood_fill( requestid, userdata )
{
    activityinstance = userdata.activityinstance;
    
    if ( !activityinstance || !activityinstance.enemyvtol )
    {
        return 1;
    }
    
    return activityinstance.var_1a119998172aa8a0;
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xf7426ba0, Offset: 0x1ecd
// Size: 0x198
function private spawn_vtol( victim )
{
    var_1d847054e3aef4b0 = { #var_606f01dce2492f65:1, #var_cec48ccf7bfb7369:1, #hashighvis:1, #var_76d248a3f9ee1e4f:1, #isattacking:0, #var_24954f14e27b448d:1, #maxhealth:self.vtolsetting.vtolmaxhealth, #target:victim, #var_6434572d2f2dc708:%"hash_4e256d4bbec9a232" };
    self.vtoltarget = victim;
    self.enemyvtol = self [[ self.vtoldata.spawn ]]( var_1d847054e3aef4b0 );
    self.enemyvtol.useshield = self.vtolsetting.var_af299ff1c873d0e7;
    self.enemyvtol namespace_cf9a4f547edbca10::function_495220db898177a0( self.enemyvtol.useshield );
    self.enemyvtol vehicleshowonminimap( 0 );
    self.enemyvtol vehicle_allowplayerstandon( 0 );
    self.enemyvtol thread [[ self.vtoldata.var_2f436ee6869ef2b2 ]]( victim, 1, undefined, 0 );
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_activity_hunt_squad" );
    objidpoolmanager::function_1a27e9b999215f16( self.enemyvtol.vtolid, hovercardid );
    thread function_3aae6ff88980b58d( self.enemyvtol );
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xb8c0fd44, Offset: 0x206d
// Size: 0x64
function private function_3aae6ff88980b58d( enemyvtol )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    enemyvtol endon( #"death" );
    enemyvtol endon( #"flyaway" );
    
    while ( true )
    {
        wait 60;
        
        if ( self.var_185680fbcb662a49 )
        {
            break;
        }
        
        activity_player_broadcasting::function_cb4750c84882dd07( "wcahuntvtolpilot" );
    }
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xd9d52ab6, Offset: 0x20d9
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

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x75efd91c, Offset: 0x2195
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

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x3e4a1870, Offset: 0x222b
// Size: 0x118
function private function_4ba9cac82361a653( params )
{
    activity_instance = self.activity_instance;
    
    if ( activity_instance && activity_instance.state == "Active" )
    {
        activity_instance.hunters = arrayremove( activity_instance.hunters, self );
        activity_instance.hunter_counter--;
        activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_789b7a49ee864fec );
        self.var_789b7a49ee864fec = undefined;
        var_9f98ad111c422428 = activity_instance.vtolsetting.hasvtol && activity_instance.vtolsetting.var_66fc7df58a2b1da;
        
        if ( var_9f98ad111c422428 && !activity_instance.bossphase && activity_instance.hunter_counter == 0 )
        {
            activity_instance.var_185680fbcb662a49 = 1;
            ob_activity_vo_utility::function_639b0047db8aec67( self.activity_instance, "wcahuntvtol" );
            
            if ( !activity_instance.var_4f9845cbd433929f )
            {
                activity_instance thread function_13b212b1ff2e051c();
            }
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xac2d9fde, Offset: 0x234b
// Size: 0x277
function private function_9ce13e62fd1ad962()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    enemyvtol = self.enemyvtol;
    
    while ( true )
    {
        foreach ( agent in self.hunters )
        {
            mindistancesq = 3.40282e+38;
            
            if ( isalive( agent ) )
            {
                foreach ( player in self.targetedsquad )
                {
                    if ( !is_eliminated( player ) )
                    {
                        mindistancesq = min( mindistancesq, distancesquared( player.origin, agent.origin ) );
                    }
                }
                
                currenttime = gettime();
                
                if ( !isdefined( agent.var_289bf44eb11f595b ) )
                {
                    agent.var_289bf44eb11f595b = 0;
                }
                
                if ( mindistancesq <= squared( self.var_91c91f4a631c481d.hunterradius ) || mindistancesq == 3.40282e+38 )
                {
                    agent.var_289bf44eb11f595b = currenttime;
                    
                    if ( !self.var_ba36b18f9ac4eb53 )
                    {
                        self.var_ba36b18f9ac4eb53 = 1;
                    }
                }
                
                var_765ab156d20e4cd4 = currenttime - agent.var_289bf44eb11f595b >= self.var_91c91f4a631c481d.var_6868416a769e6532 * 1000;
                var_cffdabd951a4432e = getinfluencedistanceatposition( agent.origin ) > self.var_91c91f4a631c481d.hunterradius;
                var_2cec8d68db4b0b70 = enemyvtol && enemyvtol.isneartarget || !enemyvtol;
                
                if ( var_765ab156d20e4cd4 && var_cffdabd951a4432e && var_2cec8d68db4b0b70 )
                {
                    agent.var_289bf44eb11f595b = currenttime;
                    function_706d9c2ce121efee();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xc060440d, Offset: 0x25ca
// Size: 0x60
function private function_35f3dd5468f91472()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    enemyvtol = self.enemyvtol;
    enemyvtol endon( #"death" );
    enemyvtol endon( #"flyaway" );
    
    while ( true )
    {
        function_cd3756da4e5470f7();
        function_36dbbb21c9c2d763();
        waitframe();
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x3db9bdde, Offset: 0x2632
// Size: 0xdf
function private function_cd3756da4e5470f7()
{
    var_f0a13c26c5bbfbf7 = self.vtoltarget;
    
    if ( !var_f0a13c26c5bbfbf7 || !is_selectable_player( var_f0a13c26c5bbfbf7 ) )
    {
        foreach ( player in self.targetedsquad )
        {
            if ( self.enemyvtol && is_selectable_player( player ) )
            {
                self.enemyvtol [[ self.vtoldata.switchtarget ]]( player );
                self.vtoltarget = player;
                break;
            }
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0x70333367, Offset: 0x2719
// Size: 0x1be
function private function_36dbbb21c9c2d763()
{
    hunters = self.hunters;
    enemyvtol = self.enemyvtol;
    
    if ( !enemyvtol )
    {
        return;
    }
    
    var_9c643caf50145aab = 0;
    
    if ( hunters && hunters.size > 0 )
    {
        foreach ( hunter in hunters )
        {
            if ( !self.vtoltarget )
            {
                return;
            }
            
            if ( !isalive( hunter ) )
            {
                continue;
            }
            
            var_e8dfa47f74f462df = distance( self.vtoltarget.origin, hunter.origin );
            
            if ( var_e8dfa47f74f462df > self.vtolsetting.var_acf918541194b4da )
            {
                continue;
            }
            
            var_9c643caf50145aab = 1;
        }
    }
    
    if ( ( enemyvtol.isneartarget || self.var_ba36b18f9ac4eb53 ) && !var_9c643caf50145aab && !self.var_4f9845cbd433929f )
    {
        thread function_13b212b1ff2e051c();
        return;
    }
    
    if ( var_9c643caf50145aab )
    {
        self notify( #"hash_8661b1d35fda61a2" );
        self.var_4f9845cbd433929f = 0;
        
        if ( enemyvtol.isattacking )
        {
            enemyvtol [[ self.vtoldata.stopattacking ]]();
            wait self.vtolsetting.var_cb72de43dd51e218;
            
            if ( enemyvtol.useshield )
            {
                enemyvtol namespace_cf9a4f547edbca10::function_495220db898177a0( 1 );
            }
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xfc74c715, Offset: 0x28df
// Size: 0x13c
function private function_13b212b1ff2e051c()
{
    enemyvtol = self.enemyvtol;
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_8661b1d35fda61a2" );
    enemyvtol endon( #"death" );
    enemyvtol endon( #"explode" );
    enemyvtol endon( #"flyaway" );
    enemyvtol endon( #"crashing" );
    self.var_4f9845cbd433929f = 1;
    
    while ( true )
    {
        if ( enemyvtol.isattacking )
        {
            enemyvtol [[ self.vtoldata.stopattacking ]]();
            wait self.vtolsetting.var_cb72de43dd51e218;
            
            if ( enemyvtol.useshield )
            {
                enemyvtol namespace_cf9a4f547edbca10::function_495220db898177a0( 1 );
            }
        }
        
        wait self.vtolsetting.var_f1181c3d4cfa3f06;
        
        if ( !enemyvtol.isattacking )
        {
            enemyvtol [[ self.vtoldata.startattacking ]]();
            
            if ( enemyvtol.useshield )
            {
                enemyvtol namespace_cf9a4f547edbca10::function_495220db898177a0( 0 );
            }
        }
        
        wait self.vtolsetting.var_ee8cfd7ac4baaaf6;
    }
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xc5078774, Offset: 0x2a23
// Size: 0x1e4
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
            
            self setstealthstate( "combat" );
            
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
                    debugstar( goalpos, ( 1, 1, 0 ), 20, "<dev string:xac>", 1 );
                    line( self.origin, goalpos, ( 1, 1, 0 ), 1, 0, 20 );
                }
            #/
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0xe80b17a7, Offset: 0x2c0f
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

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x8d0c3ee0, Offset: 0x2c95
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

// Namespace ob_activity_hunt_squad
// Params 6, eflags: 0x4
// Checksum 0xdeed64ff, Offset: 0x2d6c
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

// Namespace ob_activity_hunt_squad
// Params 0, eflags: 0x4
// Checksum 0xabcaddcb, Offset: 0x2e47
// Size: 0x134
function private function_706d9c2ce121efee()
{
    foreach ( agent in self.hunters )
    {
        if ( isalive( agent ) && self.targetedsquad.size > 0 )
        {
            enemyvtol = self.enemyvtol;
            targetedplayer = enemyvtol ? enemyvtol.targetedentity : self.targetedsquad[ 0 ];
            var_e6e0bebfd8b57958 = enemyvtol ? enemyvtol.origin : targetedplayer.origin;
            spawnpos = function_865c291d093a4931( var_e6e0bebfd8b57958, 0, 500 );
            
            if ( !spawnpos )
            {
                continue;
            }
            
            angles = vectortoangles( targetedplayer.origin - spawnpos );
            agent teleport_hunter( spawnpos, angles );
        }
    }
}

// Namespace ob_activity_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0x189f4f29, Offset: 0x2f83
// Size: 0x83, Type: bool
function private is_selectable_player( player, agent = undefined )
{
    if ( agent )
    {
        if ( distancesquared( player.origin, agent.origin ) > squared( self.var_91c91f4a631c481d.hunterradius ) )
        {
            return false;
        }
    }
    
    return !player::isinlaststand( player ) && !player ob_laststand::is_eliminated() && !arraycontains( level.var_6ccf11392270179e, player );
}

// Namespace ob_activity_hunt_squad
// Params 1, eflags: 0x4
// Checksum 0x5cd3a389, Offset: 0x300f
// Size: 0x14
function private is_eliminated( player )
{
    return player ob_laststand::is_eliminated();
}

// Namespace ob_activity_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0xa9d1d69b, Offset: 0x302c
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
                        debugstar( point, ( 1, 0, 0 ), 2000, "<dev string:xca>", 1 );
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
                                debugstar( point, ( 1, 0, 0 ), 2000, "<dev string:xe7>", 1 );
                                debugstar( var_a82f0cfa39301f09.origin, ( 1, 0.75, 0.75 ), 2000, "<dev string:xff>", 1 );
                                debugstar( var_ad9442398039a42d.origin, ( 1, 0.75, 0.75 ), 2000, "<dev string:x11e>", 1 );
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

// Namespace ob_activity_hunt_squad
// Params 6, eflags: 0x4
// Checksum 0x729d3687, Offset: 0x32e7
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

// Namespace ob_activity_hunt_squad
// Params 2, eflags: 0x4
// Checksum 0xadf5edf2, Offset: 0x33a2
// Size: 0x81
function private teleport_hunter( neworigin, angles )
{
    oldposition = self.origin;
    newposition = self getdroptofloorposition( neworigin );
    
    if ( !newposition || distancesquared( oldposition, newposition ) < squared( 500 ) )
    {
        return;
    }
    
    function_b66e941d33f91758( newposition );
    self setorigin( newposition );
    self clearenemy();
    self.angles = angles;
    self.var_827963e03bcde4f2 = undefined;
}

