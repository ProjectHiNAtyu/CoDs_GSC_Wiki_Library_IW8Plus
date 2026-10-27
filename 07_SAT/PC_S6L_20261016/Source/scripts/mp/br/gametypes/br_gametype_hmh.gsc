// scripts\mp\br\gametypes\br_gametype_hmh.gsc  (hash_1d8f8a27067ba0fc.gscc) (size: 39608 Bytes / 0x9ab8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1e2f82f (2716006447)
// size ...... 39608 (0x9ab8)
// includes .. 53  (offset: 0x9384)
// strings ... 94  (offset: 0x952c)
// dev strs .. 5   (offset: 0x9a78)
// exports ... 97  (offset: 0x5e70)
// cseg ...... 0x8ad + 0x55c3 (0x5e70)
// imports ... 309 (offset: 0x6d98)
// animtree1 . 0   (offset: 0x9ab8)
// animtree2 . 0   (offset: 0x9ab8)
#using script_26ccbfe3954cacf4;
#using script_3953cae29477fdd4;
#using script_58b4700241e5cea2;
#using script_6e841597aa154b0f;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\common\weapon;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametype_bongo;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametype_vanilla;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_hmh_bots;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_skill_tracks;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\systems\ob_analytics_activity;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\vehicles\vehicle_upgrade_mp;
#using scripts\mp\weapons;

#namespace br_gametype_hmh;

// Namespace br_gametype_hmh
// Params 0
// Checksum 0xcbe608cd, Offset: 0x8cb
// Size: 0x71
function main()
{
    utility::registersharedfunc( #"bongo", #"init_ltm", &init );
    utility::registersharedfunc( #"bongo", #"hash_e438fed9d0ae7675", &function_b5bc7d5d35358959 );
    utility::registersharedfunc( #"bongo", #"onspawnplayer_ltm", &function_8e2d7ff181f693cc );
    level.var_2c65a4a6e05bcef7 = "hmh_redeploy_capture_point";
    br_gametype_bongo::main();
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x563dd929, Offset: 0x944
// Size: 0x5d6
function private init()
{
    level.brgametype.issolos = game_utility::function_f24780eadd3fb772() == 1;
    level.var_b53174d3e41fb5da = 2;
    
    if ( !isdefined( level.brgametype.hop_bundle ) )
    {
        level.brgametype.hop_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_hop" );
    }
    
    level.brgametype.hop_bundle.var_60c9f931e4893279 = "bongo_hmh_legendary_crate";
    level.brgametype.hop_bundle.var_be19117fb13d726e = "wz_sat_br_bongo_hmh_zone_global";
    level.var_c4bd1afa9e7b69cd = level.brgametype.hop_bundle.var_c4bd1afa9e7b69cd ?? 0;
    
    if ( !level.vehiclespawnoverrides )
    {
        level.vehiclespawnoverrides = [];
    }
    
    level.vehiclespawnoverrides[ "veh_sat_medium_truck_wz" ] = %"hash_2bc60bc155f4749f";
    level.vehiclespawnoverrides[ "veh_sat_civ_lnd_dirt_bike_wz" ] = %"hash_571d270e5b1dcf17";
    level.vehiclespawnoverrides[ "veh_sat_mil_light_heli_wz" ] = %"hash_4f4500a71019c5e3";
    level.vehiclespawnoverrides[ "veh_sat_medium_truck_wz_hp" ] = %"hash_2bc60bc155f4749f";
    level.vehiclespawnoverrides[ "veh_sat_atv_wz_hp" ] = %"vehiclebundle:veh_sat_atv_wz";
    level.vehiclespawnoverrides[ "veh_sat_utv_wz_hp" ] = %"vehiclebundle:veh_sat_atv_wz";
    level.vehiclespawnoverrides[ "veh_sat_mil_light_heli_wz_hp" ] = %"hash_4f4500a71019c5e3";
    level.vehiclespawnoverrides[ "veh_sat_mil_lnd_cargo_truck_wz" ] = %"hash_5efdddfa8f702be2";
    setdvar( @"hash_b84d48c20350a132", 0 );
    setdvar( @"hash_11f4120851436805", 0 );
    setdvar( @"hash_6850f1f63b812e1", 0 );
    setdvar( @"hash_c826281b89a28526", 0 );
    lockradius = getdvarint( @"hash_ed5b1b2587a0dd4d", 80 );
    level.var_59584ca20ff01a28 = lockradius * lockradius;
    level.var_277208e783378009 = getdvarint( @"hash_44f3d533bae3d7fd", 1 ) == 1;
    
    if ( !level.var_277208e783378009 )
    {
        utility::registersharedfunc( #"gametype", #"playerkilledspawn", &playerkilledspawn );
        utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &function_cbf66fd6e7daaf90 );
        utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &function_ba6d7b0fe924389b );
        utility::registersharedfunc( #"gametype", #"triggerrespawnoverlay", &function_c259643cd2165569 );
    }
    else
    {
        level.respawndelay = int( getmatchrulesdata( "commonOption", "respawnDelay" ) );
        setdvar( @"scr_bongo_respawn_delay", level.respawndelay );
    }
    
    level callback::add( #"on_squad_eliminated", &onteameliminated );
    br_gametypes::enablefeature( #"hash_5265bc3379d9cf51" );
    br_gametypes::enablefeature( #"hash_a1e2467effef085c" );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &onstartgametype );
    utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
    utility::registersharedfunc( #"gametype", #"hash_730736e67a16d49f", &getbestspectatecandidate );
    vehicle_upgrade_mp::init();
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"elimination_assist", &function_472b28d34f164f40 );
    level callback::add( #"br_player_respawn", &onplayerrespawn );
    level callback::add( "lootcache_looted", &function_5dab87b36071db7d );
    level callback::add( #"player_vehicle_enter", &onentervehicle );
    level callback::add( #"game_ended", &ongameended );
    utility::registersharedfunc( #"gametype", #"playernakeddroploadout", &function_e420416b9e859080 );
    utility::registersharedfunc( #"skill_tracks", #"hash_9e804612aa8be619", &function_7414d550371be2ff );
    utility::registersharedfunc( #"vtol_warship", #"hash_cae65ac11ecaf3b7", &function_64cd7f1cf59c39ea );
    level.hmhhvt = { #activitydefname:level.brgametype.hop_bundle.var_87f679b699a326c7 ?? #"wz_sat_activity_mostwanted_bongo_hp", #variantregistered:0, #var_cc0e4315eede2fec:[] };
    level.var_703d53e4b3785bc = { #var_e2af8b2122ee4255:[], #activitydefname:level.brgametype.hop_bundle.var_f2c27f31f3820b34 ?? #"hash_17bff3162d096f4d", #variantregistered:0, #var_cc0e4315eede2fec:[] };
    level thread function_3fa06d951ea60aea();
    level thread function_b91ba360679fcc56();
    level thread activity_hmh_hunt_squad::init();
    level.opencaches = [];
    level.var_81350fe8269259c3 = [];
    
    if ( !level.var_277208e783378009 )
    {
        level.var_be7dc7b1a3809a1f = 0;
        level.var_142284b8acb971a6 = 1;
        level.brgametype.enabledfeatures[ #"hash_7a655b41b7ab5262" ] = undefined;
    }
    
    level.var_6d454742ba233c0b = 1;
    level.var_3849192d8ea84f19 = 5;
    level.var_e59843fd7ff816d1 = "wz_sat_br_spawn_list_bongo_hop_safecrack";
    setomnvar( "ui_br_resurgence_respawn_enabled", 0 );
    level.brgametype.enabledfeatures[ #"hash_7a655b41b7ab5262" ] = undefined;
    level.brgametype.var_fdfb65e9b9a5f91b = 1;
    br_hmh_bots::init();
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x2a03ce84, Offset: 0xf22
// Size: 0x23
function private function_64cd7f1cf59c39ea( owner )
{
    return max( 0, 2500 - owner.origin[ 2 ] );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xb82279c1, Offset: 0xf4e
// Size: 0xb1
function private onstartgametype()
{
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &ob_analytics_activity::function_48061001a97cc2f8 );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &ob_analytics_activity::on_activity_complete );
    activity_common::function_2dd4f07fa5c3e911( "ActivityFailure", &ob_analytics_activity::on_activity_failed );
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &ob_analytics_activity::on_activity_begin );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &ob_analytics_activity::function_4b55ce0113456ec6 );
    common_item::function_13398f0f1186a3f8( "br_loot_cache_bongo_hop_legendary", &function_ad651c9cff8165a4 );
    function_6bf21f2e19a101a4();
    thread function_f8ab127e5452263a();
    
    if ( !level.var_277208e783378009 )
    {
        thread function_ae481b601e125c6b();
    }
    
    thread function_4c6cd4783450e543();
    thread function_f080e4cf163b830();
    thread function_99692dd379330422();
    thread function_b213ad5718fa5ef4();
    
    /#
        level thread function_a5bb50a5edc47a15();
    #/
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xab0fd485, Offset: 0x1007
// Size: 0x57
function private function_8e2d7ff181f693cc()
{
    self.var_96cf2501d50dd6c = 0;
    
    if ( getdvarint( @"hash_5e1dbfa58dce97f2", 0 ) )
    {
        thread setupthrusters();
    }
    
    br_hmh_bots::onspawnplayer();
    var_3ef15531acadcf90 = getdvarint( @"hash_e6647378e211af20", 120 ) * 1000;
    self setclientomnvar( "ui_cranked_timer_time_max", var_3ef15531acadcf90 );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xc225771, Offset: 0x1066
// Size: 0xbf
function private function_f8ab127e5452263a()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player setclientomnvar( "ui_br_resurgence_respawn_type", level.brgametype.issolos );
            player.respawndelay = 0;
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x51af95e4, Offset: 0x112d
// Size: 0x114
function private function_4c6cd4783450e543()
{
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( #"hash_adf88e612ee7a412", player );
    }
    
    flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( #"hash_b4e98d49408eade0", player );
    }
}

/#

    // Namespace br_gametype_hmh
    // Params 0, eflags: 0x4
    // Checksum 0x502261c0, Offset: 0x1249
    // Size: 0x1a4, Type: dev
    function private function_a5bb50a5edc47a15()
    {
        level endon( #"game_ended" );
        
        for ( ;; )
        {
            wait 0.5;
            debugval = getdvarint( @"hash_d1b23d4cb7270cfd", 0 );
            
            if ( debugval == 1 )
            {
                setdvar( @"hash_d1b23d4cb7270cfd", 0 );
                setomnvar( "<dev string:x24>", 1 );
                setomnvar( "<dev string:x45>", int( gettime() + 90000 ) - 1 );
                br_public::brleaderdialog( "<dev string:x64>", undefined, undefined, undefined, undefined, undefined );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        player thread hud_message::showsplash( "<dev string:x76>" );
                    }
                }
                
                continue;
            }
            
            if ( debugval == 2 )
            {
                setdvar( @"hash_d1b23d4cb7270cfd", 0 );
                setomnvar( "<dev string:x45>", 0 );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        player thread hud_message::showsplash( "<dev string:xa6>" );
                    }
                }
            }
        }
    }

#/

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xd02ad3f3, Offset: 0x13f5
// Size: 0x28c
function private function_ae481b601e125c6b()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "br_circle_init" );
    var_11d7be6b49a57b52 = level.var_528d678aa54b1f26;
    
    if ( !isdefined( var_11d7be6b49a57b52 ) || var_11d7be6b49a57b52 <= 0 )
    {
        return;
    }
    
    if ( var_11d7be6b49a57b52 > level.br_level.br_circleclosetimes.size )
    {
        var_11d7be6b49a57b52 = level.br_level.br_circleclosetimes.size;
    }
    
    totaltime = 0;
    
    for ( i = 0; i < var_11d7be6b49a57b52 ; i++ )
    {
        totaltime += level.br_level.br_circleclosetimes[ i ] + level.br_level.br_circledelaytimes[ i ];
    }
    
    totaltimems = int( totaltime * 1000 );
    starttimems = gettime();
    var_95ad0500abb003ce = starttimems + totaltimems;
    setomnvar( "ui_resurgence_respawn_end_time", var_95ad0500abb003ce );
    
    for ( remainingtimems = totaltimems; remainingtimems > 90000 ; remainingtimems = totaltimems - elapsedtimems )
    {
        wait ( remainingtimems - 90000 ) / 1000;
        elapsedtimems = gettime() - starttimems;
    }
    
    setomnvar( "ui_resurgence_respawn_end_time", int( gettime() + remainingtimems ) - 1 );
    br_public::brleaderdialog( "resurgence_ending", undefined, undefined, undefined, undefined, undefined );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread hud_message::showsplash( "br_resurgence_reinforcement_closing_improvement" );
        }
    }
    
    while ( level.brgametype.respawnenable )
    {
        wait 0.5;
    }
    
    setomnvar( "ui_resurgence_respawn_end_time", 0 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread hud_message::showsplash( "br_resurgence_reinforcement_closed_improvement" );
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xa82f9a13, Offset: 0x1689
// Size: 0x26a
function private onplayerdeath( params )
{
    waittillframeend();
    victim = params.victim;
    
    if ( !victim || !isplayer( victim ) )
    {
        return;
    }
    
    attacker = params.attacker;
    
    if ( attacker && isplayer( attacker ) )
    {
        attacker function_8256173efac818fc();
    }
    
    if ( victim && victim.killstreakstarttime )
    {
        victim.killstreakstarttime = undefined;
        victim setclientomnvar( "ui_cranked_timer_time", 0 );
        
        if ( getdvarint( @"hash_b149f089546bdc2", 0 ) )
        {
            victim function_d55213200ed88525( victim.var_1f7050a4c29b6a13 );
        }
    }
    
    victim.var_6f3a28d74f47aee7 = undefined;
    players = teams::getteamdata( victim.team, "players" );
    alivecount = 0;
    aliveplayer = undefined;
    
    foreach ( player in players )
    {
        if ( isalive( player ) )
        {
            alivecount++;
            aliveplayer = player;
        }
        
        if ( alivecount > 1 )
        {
            break;
        }
    }
    
    if ( alivecount == 1 )
    {
        if ( !isdefined( aliveplayer.var_16e45cf806b30914 ) )
        {
            aliveplayer.var_16e45cf806b30914 = 0;
        }
        
        var_e1029c6ae14b8b18 = getdvarint( @"hash_b42a67be32906fe", 240 ) * 1000;
        
        if ( gettime() - aliveplayer.var_16e45cf806b30914 > var_e1029c6ae14b8b18 )
        {
            aliveplayer playsoundtoplayer( #"hash_bed2fa4f8ecce8b8", aliveplayer );
            aliveplayer.var_16e45cf806b30914 = gettime();
        }
        
        return;
    }
    
    if ( alivecount == 0 )
    {
        foreach ( player in players )
        {
            player playsoundtoplayer( #"hash_c3a5e249482bbfde", player );
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x503edbfc, Offset: 0x18fb
// Size: 0x2e
function private onplayerrespawn( params )
{
    player = params.player;
    
    if ( !isalive( player ) )
    {
        return;
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xa11239cb, Offset: 0x1931
// Size: 0x3c
function private function_472b28d34f164f40( params )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( !self || !isalive( self ) )
    {
        return;
    }
    
    level function_f4ac88e550995552( self );
    function_8256173efac818fc();
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x187d567, Offset: 0x1975
// Size: 0x84
function private function_8256173efac818fc()
{
    var_645910e050313893 = self.var_c1ffac14a5dafd35 || level.var_4c1500769aa35467 && self.skilllevel >= level.var_4c1500769aa35467.skills.size;
    
    if ( !var_645910e050313893 )
    {
        return;
    }
    
    self.killstreakstarttime = gettime();
    var_3ef15531acadcf90 = getdvarint( @"hash_e6647378e211af20", 120 ) * 1000;
    self setclientomnvar( "ui_cranked_timer_time", var_3ef15531acadcf90 );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x4076afda, Offset: 0x1a01
// Size: 0x5d
function private function_f4ac88e550995552( player )
{
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    wasactive = player.var_96cf2501d50dd6c > gettime();
    player.var_96cf2501d50dd6c = gettime() + 15000;
    
    if ( !wasactive )
    {
        player thread function_edc62717805a311e();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0x2db796d8, Offset: 0x1a66
// Size: 0x1a5
function private function_b213ad5718fa5ef4()
{
    self notify( #"hash_5735f0a55148b632" );
    self endon( #"hash_5735f0a55148b632" );
    level endon( #"game_ended" );
    var_3ef15531acadcf90 = getdvarint( @"hash_e6647378e211af20", 120 ) * 1000;
    var_b947e19e6aa0e9b6 = getdvarint( @"hash_ed0305b1f5274ab6", 30 ) * 1000;
    
    while ( true )
    {
        waitframe();
        timenow = gettime();
        
        foreach ( player in level.players )
        {
            if ( player && isalive( player ) && player.killstreakstarttime )
            {
                var_3902573037dcb65f = timenow - player.killstreakstarttime;
                
                if ( !player.var_9e751942d15371c3 && var_3902573037dcb65f >= var_b947e19e6aa0e9b6 )
                {
                    player playsoundtoplayer( #"hash_e7c81eece10720d", player );
                    player.var_9e751942d15371c3 = 1;
                    continue;
                }
                
                if ( var_3902573037dcb65f >= var_3ef15531acadcf90 )
                {
                    player.var_9e751942d15371c3 = 0;
                    player.killstreakstarttime = undefined;
                    player setclientomnvar( "ui_cranked_timer_time", 0 );
                    br_skill_tracks::function_51220390e8a3c1f5( player, 4 );
                    continue;
                }
                
                player setclientomnvar( "ui_cranked_timer_time", int( var_3ef15531acadcf90 - var_3902573037dcb65f ) );
            }
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x1aed17db, Offset: 0x1c13
// Size: 0x170
function private function_d55213200ed88525( activeskills )
{
    if ( !isdefined( activeskills ) || activeskills.size <= 0 )
    {
        return;
    }
    
    origin = self.origin;
    vfx = undefined;
    useshockingreloadfx = 0;
    slidelevel = activeskills[ #"slide_explosions" ];
    
    if ( isdefined( slidelevel ) )
    {
        vfxkey = "slide_explosions_vfx_" + slidelevel;
        
        if ( isdefined( level._effect[ vfxkey ] ) )
        {
            vfx = level._effect[ vfxkey ];
        }
    }
    else
    {
        falllevel = activeskills[ #"fall_explosions" ];
        
        if ( isdefined( falllevel ) )
        {
            vfxkey = "fall_explosions_fx_" + falllevel;
            
            if ( isdefined( level._effect[ vfxkey ] ) )
            {
                vfx = level._effect[ vfxkey ];
            }
        }
        else if ( isdefined( activeskills[ #"shocking_reload" ] ) )
        {
            useshockingreloadfx = 1;
        }
        else
        {
            return;
        }
    }
    
    if ( isdefined( vfx ) )
    {
        playfx( vfx, origin );
    }
    
    if ( useshockingreloadfx )
    {
        utility::function_32b24db3127bff40( "shockingReloadFX", "shockingReloadFX_start" );
    }
    
    radius = getdvarint( @"hash_2872c9f13ee3d795", 500 );
    maxdamage = getdvarint( @"hash_e4bc508a7261ea41", 500 );
    mindamage = getdvarint( @"hash_320bf99813f8e7d7", 150 );
    radiusdamage( origin, radius, maxdamage, mindamage, self );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xc0faf696, Offset: 0x1d8b
// Size: 0x9d
function private function_e420416b9e859080()
{
    respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
    level.br_standard_loadout = respawnloadout[ 0 ];
    noextraammo = respawnloadout[ 1 ];
    br::givestandardtableloadout( 0, 1, noextraammo );
    
    if ( function_592c2ae621ddb43d() )
    {
        self.firstspawnpassed = 1;
        function_decd28c488eb3b4d();
        return;
    }
    
    if ( !isdefined( self.firstspawnpassed ) )
    {
        self.firstspawnpassed = 1;
        inventory_utility::_takeweapon( self function_a4f068798d87b7ea( 0 ) );
        knife = self getweaponmeleeslot();
        
        if ( !isnullweapon( knife ) )
        {
            self switchtoweaponimmediate( knife );
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x7bf49def, Offset: 0x1e30
// Size: 0x67, Type: bool
function private function_592c2ae621ddb43d()
{
    circleindex = 0;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex >= 0 )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    return circleindex >= 3;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x143a49f7, Offset: 0x1ea0
// Size: 0x99
function private function_d09bbb4a1ee9c704()
{
    circleindex = 0;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex >= 0 )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    circlenum = circleindex + 1;
    aethercount = int( min( circlenum, 3 ) );
    function_77523ddff7efb1f0( level.var_b53174d3e41fb5da, aethercount );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x7bf8a15d, Offset: 0x1f41
// Size: 0x35
function private function_decd28c488eb3b4d()
{
    function_77523ddff7efb1f0( 1, 2 );
    equipment_mp::giveequipment( "equip_super_mega_jump", "secondary" );
    equipment_mp::setequipmentammo( "equip_super_mega_jump", equipment_mp::getequipmentmaxammo( "equip_super_mega_jump" ) );
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0xdbf82af9, Offset: 0x1f7e
// Size: 0x143
function private function_77523ddff7efb1f0( armorlevel, aethercount )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    armorref = "wz_consumable_armor_upgrade_level_" + armorlevel;
    armorbundlename = common_item_database::function_a4f0a21951180013( armorref );
    
    if ( isdefined( armorbundlename ) )
    {
        var_b58ff6dadc67c9c2 = common_item::function_90c3e0c1fd55d6b6( armorbundlename );
        
        if ( isdefined( var_b58ff6dadc67c9c2 ) )
        {
            armoritem = common_item::function_77600f92048df72d( var_b58ff6dadc67c9c2 );
            
            if ( isdefined( armoritem ) )
            {
                common_item::function_bbba261e6fdc7e52( "armor_upgrade" );
                common_item::function_96119bed8ab4c5d9( armoritem, 1 );
            }
        }
    }
    
    aethercount = int( aethercount );
    
    if ( aethercount <= 0 )
    {
        return;
    }
    
    var_5c426cc3a7802efc = common_item_database::function_a4f0a21951180013( "wz_consumable_aether_upgrade" );
    
    if ( !isdefined( var_5c426cc3a7802efc ) )
    {
        return;
    }
    
    var_f32a60d91704ce68 = common_item::function_90c3e0c1fd55d6b6( var_5c426cc3a7802efc );
    
    if ( !isdefined( var_f32a60d91704ce68 ) )
    {
        return;
    }
    
    primaryweapon = item_weapon::function_e7484276ad85f220( #"primary_0" );
    
    if ( !isnullweapon( primaryweapon ) )
    {
        function_ef5e121d6c1f39d9( primaryweapon, var_f32a60d91704ce68, aethercount );
    }
    
    secondaryweapon = item_weapon::function_e7484276ad85f220( #"primary_1" );
    
    if ( !isnullweapon( secondaryweapon ) )
    {
        function_ef5e121d6c1f39d9( secondaryweapon, var_f32a60d91704ce68, aethercount );
    }
}

// Namespace br_gametype_hmh
// Params 3, eflags: 0x4
// Checksum 0x5c870608, Offset: 0x20c9
// Size: 0x243
function private function_ef5e121d6c1f39d9( weapon, var_f32a60d91704ce68, count )
{
    weapon = weapon getnoaltweapon();
    
    if ( weapon::isbackuppistol( weapon ) )
    {
        return;
    }
    
    exoticrarity = common_item::function_b297a2bfcaccc713( #"exotic" );
    var_a5530bf8ee350e8e = getdvarint( @"hash_3d61c95afeee3d5e", 1 );
    refillclip = var_f32a60d91704ce68.var_a67a1b969e8fea3;
    
    if ( weapon.var_e4de3f79b4ac164f >= exoticrarity )
    {
        return;
    }
    
    itemname = item_weapon::function_3c60845f4139b91d( weapon );
    
    if ( !isdefined( itemname ) )
    {
        return;
    }
    
    var_dec58e88721dc3db = itemname;
    
    for ( i = 0; i < count ; i++ )
    {
        var_874bcecb5b6136fb = getscriptbundlefieldvalue( var_dec58e88721dc3db, #"weaponupgradeitem" );
        
        if ( !isdefined( var_874bcecb5b6136fb ) )
        {
            break;
        }
        
        var_dec58e88721dc3db = var_874bcecb5b6136fb;
    }
    
    if ( var_dec58e88721dc3db == itemname )
    {
        return;
    }
    
    var_ab3d86fd09bad221 = common_item::function_90c3e0c1fd55d6b6( var_dec58e88721dc3db );
    
    if ( !isdefined( var_ab3d86fd09bad221 ) )
    {
        return;
    }
    
    pastteam = item_weapon::function_af299135a62729b8( weapon );
    var_1dd5fd3c089a62d8 = self isalternatemode( weapon ) && weapons::shouldweaponsavealtstate( weapon );
    removeparams = { #weapon:weapon, #dontdrop:1 };
    var_9365dd79ea80061d = item_weapon::items_weapon_removeweapon( removeparams );
    weaponitem = { #count:common_item::function_598dd39282efb544( var_9365dd79ea80061d.ammoclipright, var_9365dd79ea80061d.ammoclipleft, var_9365dd79ea80061d.ammoclipalt ) };
    
    if ( var_a5530bf8ee350e8e )
    {
        self.var_2e6e138927b1b4b7 = weapon.camo;
    }
    
    [ _item, newweapon ] = item_weapon::function_5be1bc100827adc7( var_ab3d86fd09bad221, weaponitem );
    self.var_2e6e138927b1b4b7 = undefined;
    
    if ( newweapon )
    {
        if ( pastteam )
        {
            item_weapon::function_59db11f47705f704( newweapon, pastteam );
        }
        
        if ( refillclip )
        {
            item_weapon::function_165956c3013b4abf( newweapon );
        }
        
        if ( var_1dd5fd3c089a62d8 && newweapon.hasalternate )
        {
            self setalternatemode( newweapon, 1 );
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x686e6214, Offset: 0x2314
// Size: 0xed
function private function_cbf66fd6e7daaf90( player )
{
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        return 1;
    }
    
    var_7237854e3be197ca = manager::SurvivalCurveMayConsiderBotDead( player );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( level.brgametype.issolos )
    {
        if ( level.brgametype.respawnenable || player.b_force_respawn )
        {
            if ( !isdefined( player.respawndelay ) )
            {
                player.respawndelay = 0;
            }
            
            if ( player.respawndelay <= 0 )
            {
                player.respawngranted = 1;
                return 0;
            }
        }
        
        player hiderespawntimer();
        return 1;
    }
    
    if ( level.brgametype.respawnenable || player.b_force_respawn )
    {
        player thread function_6e39f54beaf00d8e();
    }
    
    return 1;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0x5a356183, Offset: 0x240a
// Size: 0x124
function private function_6e39f54beaf00d8e()
{
    self notify( #"hash_e7304fa111a777cf" );
    self endon( #"hash_e7304fa111a777cf" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"squad_wiped" );
    
    if ( !level.brgametype.issolos )
    {
        thread function_78d49473bf5e8b86();
    }
    
    respawndelay = getdvarint( @"hash_5f556f5f371aaa46", 30 );
    
    if ( respawndelay <= 0 )
    {
        respawndelay = 1;
    }
    
    showrespawntimer( respawndelay );
    
    while ( respawndelay > 0 )
    {
        if ( !level.brgametype.respawnenable )
        {
            break;
        }
        
        br_public::updatebrscoreboardstat( "respawnInSeconds", respawndelay );
        br_gametype_resurgence::function_6f6222b4837d3c31( respawndelay );
        wait 1;
        respawndelay--;
    }
    
    hiderespawntimer();
    br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    
    if ( !isalive( self ) )
    {
        self notify( #"doingrespawn" );
        thread function_69a6f0ec858af897();
        self.var_1be091ba55db848e = "hmh_respawn";
        respawnstruct = function_aba2fcd312626ca();
        br_spawnrespawn::br_doingrespawn( undefined, respawnstruct );
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x169086bd, Offset: 0x2536
// Size: 0x70
function private function_aba2fcd312626ca()
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97( undefined, undefined, undefined );
    rs br_spawnrespawn::function_ffd4cf4c20eae881( &function_854c69c6f7fd5d2 );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( undefined, 4 );
    rs br_spawnrespawn::function_b9b32e1004a183cb( &hmhonrespawn, 4 );
    rs br_spawnrespawn::function_7275e4fc001d486a( &function_b2d5897e4a1d4b9b, "br_resurgence_redeploy_improvement", 4, level.brgametype.splashlistoverride, "resurgence_redeploy" );
    return rs;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xa0a66e6, Offset: 0x25af
// Size: 0x5b, Type: bool
function private function_854c69c6f7fd5d2( optparams )
{
    if ( !level.brgametype.issolos )
    {
        if ( self.respawningfromtoken )
        {
            return false;
        }
        
        self.respawningfromtoken = 1;
        playerlogic::addtoalivecount( "hmh_respawn", 1 );
        item_redeploy_token::function_190ce3e2e0f50a8a();
        br_utility::unmarkplayeraseliminated( self );
    }
    
    return true;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xa0c3dfd, Offset: 0x2613
// Size: 0x34
function private hmhonrespawn( optparams )
{
    if ( !level.brgametype.issolos )
    {
        item_redeploy_token::function_16ab0a48337237ef();
        return;
    }
    
    thread function_b3837c41cf462af();
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x9e89c9ce, Offset: 0x264f
// Size: 0xb0
function private function_b2d5897e4a1d4b9b( optparams )
{
    if ( level.brgametype.respawnenable )
    {
        if ( level.brgametype.issolos && !self.var_6e53a5a965c22905 )
        {
            thread hud_message::showsplash( "br_resurgence_survive_countdown_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
            self.var_6e53a5a965c22905 = 1;
        }
        
        return;
    }
    
    if ( level.brgametype.issolos )
    {
        thread hud_message::showsplash( "br_resurgence_reinforcement_closed_improvement", undefined, undefined, undefined, undefined, level.brgametype.splashlistoverride );
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xc6febd67, Offset: 0x2707
// Size: 0x96
function private function_b3837c41cf462af()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death_or_disconnect" );
    respawndelay = getdvarint( @"hash_5f556f5f371aaa46", 30 );
    self.respawndelay = respawndelay;
    showrespawntimer( respawndelay );
    
    while ( self.respawndelay > 0 )
    {
        br_gametype_resurgence::function_6f6222b4837d3c31( self.respawndelay );
        wait 1;
        self.respawndelay--;
    }
    
    hiderespawntimer();
    thread hud_message::showsplash( "br_resurgence_respawn_active_improvement" );
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0x88128ae6, Offset: 0x27a5
// Size: 0xc4
function private function_c7c3ec8d63289337( deathdata, finaldeath )
{
    player = deathdata.victim;
    
    if ( player.respawngranted )
    {
        player.respawngranted = undefined;
        player notify( #"doingrespawn" );
        player thread function_69a6f0ec858af897();
        player.var_1be091ba55db848e = "hmh_respawn";
        player.alreadyaddedtoalivecount = 1;
        respawnstruct = function_aba2fcd312626ca();
        player thread br_spawnrespawn::br_doingrespawn( undefined, respawnstruct );
        return;
    }
    
    player.respawngranted = undefined;
    
    if ( player && !player.disconnecting )
    {
        player thread br_spectate::spawnspectator( deathdata, finaldeath );
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0x5c34c9d0, Offset: 0x2871
// Size: 0x72
function private function_78d49473bf5e8b86()
{
    self notify( #"hash_2195449672d30d39" );
    self endon( #"hash_2195449672d30d39" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"doingrespawn" );
    
    while ( true )
    {
        if ( function_13af61f48b1accb5( self ) )
        {
            hiderespawntimer();
            br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
            self notify( #"squad_wiped" );
            return;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x1fff5211, Offset: 0x28eb
// Size: 0x4f, Type: bool
function private function_13af61f48b1accb5( player )
{
    var_1258ac31d654c37f = teams::getteamdata( player.team, "aliveCount" );
    var_c6bff23824195f2c = br::function_e45241986b39c3a8( player.team );
    return var_1258ac31d654c37f + var_c6bff23824195f2c == 0;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xf9a09321, Offset: 0x2943
// Size: 0xa0, Type: bool
function private function_ba6d7b0fe924389b()
{
    namespace_943a9317064e5565::onmarkplayeraseliminated_shared( self );
    
    if ( isbot( self ) && self.respawningfromtoken )
    {
        return false;
    }
    
    if ( !level.brgametype.issolos )
    {
        return true;
    }
    
    hasforcerespawn = istrue( self.b_force_respawn );
    self.b_force_respawn = undefined;
    var_1fd2519c36453ab4 = self.respawndelay > 0;
    return flags::gameflag( "prematch_fade_done" ) && ( var_1fd2519c36453ab4 || !level.brgametype.respawnenable && !hasforcerespawn );
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0x222541ae, Offset: 0x29ec
// Size: 0x1b2, Type: bool
function private playerkilledspawn( deathdata, finaldeath )
{
    if ( !level.br_prematchstarted )
    {
        return false;
    }
    
    if ( level.brgametype.issolos )
    {
        function_c7c3ec8d63289337( deathdata, finaldeath );
    }
    else
    {
        attacker = deathdata.attacker;
        spectatedata = undefined;
        
        if ( isplayer( attacker ) && attacker != deathdata.victim )
        {
            spectatedata = { #attacker:attacker };
        }
        
        if ( !function_13af61f48b1accb5( deathdata.victim ) )
        {
            if ( deathdata.victim && !deathdata.victim.disconnecting )
            {
                deathdata.victim thread br_spectate::spawnspectator( spectatedata );
            }
        }
        else
        {
            players = teams::getteamdata( self.team, "players" );
            
            foreach ( player in players )
            {
                if ( player && !player.disconnecting )
                {
                    spectatedplayer = player getspectatingplayer();
                    
                    if ( !spectatedplayer || player == self || spectatedplayer == self )
                    {
                        player thread br_spectate::spawnspectator( spectatedata );
                    }
                }
            }
        }
    }
    
    return true;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xd663e482, Offset: 0x2ba7
// Size: 0x2d
function private function_b5bc7d5d35358959()
{
    if ( !level.var_277208e783378009 )
    {
        utility::registersharedfunc( #"player", #"isPlayerWaitingResurgenceRespawn", &function_d0c3c9030b8f9014 );
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xa8b480a7, Offset: 0x2bdc
// Size: 0x46, Type: bool
function private function_d0c3c9030b8f9014()
{
    if ( level.brgametype.issolos )
    {
        return false;
    }
    
    return !isalive( self ) && level.brgametype.respawnenable && self.respawndelay > 0;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xa07f9037, Offset: 0x2c2b
// Size: 0xc4
function private onteameliminated( obj )
{
    if ( !obj || !obj.team )
    {
        return;
    }
    
    playersonteam = teams::getteamdata( obj.team, "players" );
    
    foreach ( member in playersonteam )
    {
        if ( member && isbot( member ) )
        {
            member thread bots_gametype_br_super::function_7fb069819a6ed860();
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xae9e833c, Offset: 0x2cf7
// Size: 0x24
function private showrespawntimer( timer )
{
    br_gametype_resurgence::function_12b97810099f2b4d();
    br_gametype_resurgence::function_6f6222b4837d3c31( timer );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xfeaaaec5, Offset: 0x2d23
// Size: 0x19
function private hiderespawntimer()
{
    br_gametype_resurgence::function_e9f3e6b5a7d226b0();
    br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x2e699415, Offset: 0x2d44
// Size: 0x30
function private function_69a6f0ec858af897()
{
    self endon( #"disconnect" );
    self.currentlyrespawning = 1;
    self waittill( #"spawned" );
    self.currentlyrespawning = undefined;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xc1bb2c40, Offset: 0x2d7c
// Size: 0x81
function private function_5dab87b36071db7d( params )
{
    cache = params.cacheinstance;
    
    if ( cache && cache.type == "br_loot_cache_bongo_hop_legendary" )
    {
        level.opencaches = arraycombineunique( level.opencaches, [ cache ] );
        
        if ( isdefined( cache.marker ) )
        {
            cache.marker.var_8df89ed250ace0df = 1;
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xe39b9fec, Offset: 0x2e05
// Size: 0xbf
function private function_6bf21f2e19a101a4()
{
    caches = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "body" );
    bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", "wz_loot_cache_legendary_marker" );
    
    foreach ( cache in caches )
    {
        if ( cache.type != "br_loot_cache_bongo_hop_legendary" )
        {
            continue;
        }
        
        function_a2ec86d8ebdb5741( cache, bundlexhash );
    }
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0x18537f49, Offset: 0x2ecc
// Size: 0xcd
function private function_a2ec86d8ebdb5741( cache, bundlexhash )
{
    obj_id = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( bundlexhash, 1 );
    
    if ( !isdefined( obj_id ) || obj_id == -1 )
    {
        return;
    }
    
    objidpoolmanager::update_objective_state( obj_id, "active" );
    objidpoolmanager::update_objective_position( obj_id, cache.origin );
    objidpoolmanager::objective_playermask_hidefromall( obj_id );
    marker = spawnstruct();
    marker.obj_id = obj_id;
    marker.cache = cache;
    marker.origin = cache.origin;
    cache.marker = marker;
    level.var_81350fe8269259c3[ level.var_81350fe8269259c3.size ] = marker;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xd4dd11b7, Offset: 0x2fa1
// Size: 0x51
function private function_ad651c9cff8165a4( params )
{
    cache = params.item;
    
    if ( !isdefined( cache ) )
    {
        return;
    }
    
    bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", "wz_loot_cache_legendary_marker" );
    function_a2ec86d8ebdb5741( cache, bundlexhash );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x9367793a, Offset: 0x2ffa
// Size: 0x25
function private circletimer( circleindex )
{
    br_gametype_bongo::circletimer( circleindex );
    level thread function_522b8ab836e5c726();
    level thread function_2a27225447fe7b3b();
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0x9114af8c, Offset: 0x3027
// Size: 0xda
function private function_522b8ab836e5c726()
{
    self notify( #"hash_fdea85e41f738b47" );
    self endon( #"hash_fdea85e41f738b47" );
    level endon( #"game_ended" );
    
    foreach ( cache in level.opencaches )
    {
        if ( cache )
        {
            if ( isdefined( cache.marker ) )
            {
                cache.marker.var_8df89ed250ace0df = 0;
            }
            
            cache thread closecache();
            wait 0.1;
        }
    }
    
    level.opencaches = [];
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x69e17118, Offset: 0x3109
// Size: 0xa, Type: bool
function private function_c259643cd2165569()
{
    wait 0.5;
    return true;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x8fdc9a18, Offset: 0x311c
// Size: 0xf5
function private closecache()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"closed" );
    self.var_fac9f8e0a78bc01c = 1;
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self setscriptablepartstate( "body", "fully_open_unusable_fx2" );
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self setscriptablepartstate( "body", "fully_open_unusable_fx3" );
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self.contents = undefined;
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( self.type );
    
    if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        common_cache::function_a136b84fc5c0dfab( self, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    }
    
    self.var_fac9f8e0a78bc01c = 0;
    self setscriptablepartstate( "body", "closing" );
    self notify( #"closed" );
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0xd146bd6a, Offset: 0x3219
// Size: 0x213
function private getbestspectatecandidate( victim, attacker )
{
    playertospectate = undefined;
    skipbots = br_spectate::function_eb549f5bc7846054( 1 );
    var_4684bb6938a2a4dc = br_spectate::function_f60269abe1b22d3c();
    
    if ( victim.nextplayertospectate && br_spectate::isvalidspectatetarget( victim.nextplayertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = victim.nextplayertospectate;
        victim.nextplayertospectate = undefined;
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = victim br_spawnrespawn::playergetbestrespawnteammate( undefined, undefined, 1, skipbots );
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && victim.team )
    {
        friendlies = teams::getfriendlyplayers( victim.team );
        friendlies = arrayremove( friendlies, victim );
        playertospectate = br_spectate::function_6b01b638404dd110( victim, friendlies, 0 );
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && isplayer( attacker ) )
    {
        attackerteam = attacker.team;
        victimteam = victim.team;
        
        if ( !( isdefined( attackerteam ) && isdefined( victimteam ) ) || attackerteam != victimteam )
        {
            if ( isalive( attacker ) && !attacker.gulag && !attacker.inlaststand && ( !isbot( attacker ) || !skipbots ) )
            {
                playertospectate = attacker;
            }
            else if ( attackerteam )
            {
                teammates = teams::getfriendlyplayers( attackerteam );
                playertospectate = br_spectate::function_6b01b638404dd110( victim, teammates );
            }
        }
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) && isplayer( attacker ) && attacker != victim )
    {
        playertospectate = br_spectate::getnextspectatecandidatefromchain( attacker );
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = br_spectate::function_6b01b638404dd110( victim, level.players );
    }
    
    if ( !br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        playertospectate = br_spectate::function_308b65a4f0831abb( victim );
    }
    
    if ( br_spectate::isvalidspectatetarget( playertospectate, var_4684bb6938a2a4dc ) )
    {
        return playertospectate;
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x7392d533, Offset: 0x3435
// Size: 0x90
function private function_2a27225447fe7b3b()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player )
        {
            player.hopheat = 0;
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x33efd1d0, Offset: 0x34cd
// Size: 0x25f
function private function_f080e4cf163b830()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    var_619ba6a74b81266e = [];
    
    while ( level.brgametype.hop_bundle.var_bf6dbd4a2b38526d ?? 1 )
    {
        circleindex = level.br_circle.circleindex ?? 0;
        var_ad1a97bd13427aeb = level.brgametype.hop_bundle.drop_circle_index ?? getdvarint( @"hash_3800b1dd17e32a91", 2 );
        var_db4fa5293d2ae220 = level.brgametype.hop_bundle.var_68bb3a526d2afd9b ?? getdvarint( @"hash_b17f38e8ecbd29c8", 5 );
        var_2278a09c80ddcfc1 = level.brgametype.hop_bundle.var_4b9cdec2d8034942 ?? getdvarfloat( @"hash_a5c6d2f9ce6e2653", 3 );
        var_bd67981fb9e59784 = circleindex >= var_ad1a97bd13427aeb;
        var_6c4b16eb295c43c1 = ( var_619ba6a74b81266e[ circleindex ] ?? 0 ) < var_db4fa5293d2ae220;
        
        if ( var_bd67981fb9e59784 && var_6c4b16eb295c43c1 )
        {
            circleorigin = level.br_level.br_circlecenters[ circleindex ];
            circleradius = level.br_level.br_circleradii[ circleindex ];
            randomveh = function_5ed30b6cd33d240();
            
            if ( vehicle_spawn::can_spawn_vehicle( randomveh ) )
            {
                var_726dba9213c2edd2 = br_circle::getrandompointincircle( circleorigin, circleradius );
                var_4559c412e4cd2fb1 = var_726dba9213c2edd2;
                var_726dba9213c2edd2 += ( 0, 0, 2500 );
                spawn_data = spawnstruct();
                spawn_data.origin = var_726dba9213c2edd2;
                spawned_vehicle = vehicle::spawn( randomveh, spawn_data );
                
                if ( spawned_vehicle )
                {
                    spawned_vehicle thread function_f2dadc090548ef87( var_4559c412e4cd2fb1, 3 );
                    chute = spawn( "script_model", spawn_data.origin );
                    
                    if ( chute )
                    {
                        chute thread function_666048fc8dd01f18( spawned_vehicle, 2 );
                    }
                    
                    var_619ba6a74b81266e[ circleindex ] = ( var_619ba6a74b81266e[ circleindex ] ?? 0 ) + 1;
                    
                    if ( var_2278a09c80ddcfc1 > 0 )
                    {
                        wait var_2278a09c80ddcfc1;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x719d82dd, Offset: 0x3734
// Size: 0x4c
function private function_5ed30b6cd33d240()
{
    vehicles = [ %"hash_2bc60bc155f4749f", %"hash_29ae577ada42d2ec", %"hash_571d270e5b1dcf17", %"hash_5efdddfa8f702be2" ];
    return vehicles[ randomint( vehicles.size ) ];
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0x6baaa4bb, Offset: 0x3789
// Size: 0x109
function private function_666048fc8dd01f18( vehicle, detach_time )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !self || !vehicle )
    {
        return;
    }
    
    self setmodel( "veh_t10_mil_air_parachute_carepackage_mp" );
    self linkto( vehicle, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_1db3eb09fa11fde3 = level.scr_anim[ "care_package_chute" ][ "care_package_drop" ];
    
    if ( var_1db3eb09fa11fde3 )
    {
        blend_type = animation::function_cd8b99431e720772( "care_package_chute", "care_package_drop" );
        utility::self_func( "scriptModelPlayAnim", var_1db3eb09fa11fde3, undefined, 7, blend_type );
    }
    
    utility::waittill_notify_or_timeout( "death", detach_time );
    
    if ( self )
    {
        self unlink();
        finish_position = self.origin + ( 0, 0, 5000 );
        function_f2dadc090548ef87( finish_position, 4 );
        self delete();
    }
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0xa7f0cc50, Offset: 0x389a
// Size: 0xa3
function private function_f2dadc090548ef87( finish_pos, moving_time )
{
    self endon( #"death" );
    
    if ( !isdefined( moving_time ) )
    {
        self.origin = finish_pos;
        return;
    }
    
    time_since_start = 0;
    time_progress = 0;
    origin_position = self.origin;
    
    while ( time_progress < 1 )
    {
        time_progress = clamp( time_since_start / moving_time, 0, 1 );
        new_position = vectorlerp( origin_position, finish_pos, time_progress );
        self.origin = new_position;
        time_since_start += level.framedurationseconds;
        waitframe();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x9c2965c, Offset: 0x3945
// Size: 0x13c
function private function_99692dd379330422()
{
    level endon( #"game_ended" );
    thresholdsquads = [ 10, 5, 3, 2 ];
    thresholdssolos = [ 25, 10, 5, 3, 2 ];
    thresholdindex = 0;
    thresholds = level.brgametype.issolos ? thresholdssolos : thresholdsquads;
    level waittill( #"prematch_started" );
    
    while ( thresholdindex < thresholds.size )
    {
        level utility::waittill_any( "br_player_eliminated", "players_remaining_changed" );
        squadsleft = function_d2726ffc3ad91c2();
        
        while ( thresholdindex < thresholds.size && squadsleft <= thresholds[ thresholdindex ] )
        {
            var_6a61a5c8cda5c88 = getdvarint( @"hash_2bd10bf6d780fed0", 0 );
            var_d2e823e8dea69430 = var_6a61a5c8cda5c88 ? undefined : br::function_aa0fbbd622092c4e();
            br_public::brleaderdialog( "top_" + thresholds[ thresholdindex ], 0, var_d2e823e8dea69430, 1, undefined, undefined, level.brgametype.dialogprefix );
            thresholdindex++;
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x4bf2f2bc, Offset: 0x3a89
// Size: 0x91
function private function_d2726ffc3ad91c2()
{
    count = 0;
    
    foreach ( team in level.teamnamelist )
    {
        if ( !function_c526746f780b858c( team ) )
        {
            continue;
        }
        
        count++;
    }
    
    return count;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x5a17f92, Offset: 0x3b23
// Size: 0x122, Type: bool
function private function_c526746f780b858c( team )
{
    if ( teams::getteamdata( team, "aliveCount" ) > 0 )
    {
        return true;
    }
    
    if ( level.uibotmanager && ( br::function_e45241986b39c3a8( team ) ?? 0 ) > 0 )
    {
        return true;
    }
    
    if ( level.brgametype.respawnenable )
    {
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            if ( level.var_277208e783378009 )
            {
                if ( player && player utility::callsharedfunc( #"player", #"isPlayerWaitingResurgenceRespawn" ) )
                {
                    return true;
                }
                
                continue;
            }
            
            if ( player && player function_d0c3c9030b8f9014() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0xf86df930, Offset: 0x3c4e
// Size: 0x1b3
function private setupthrusters()
{
    self notify( #"hash_4abf2ec7866126a5" );
    self endon( #"hash_4abf2ec7866126a5" );
    self endon( #"death_or_disconnect" );
    self allowthrusters( 1 );
    self function_21244a4b3abfc835( 1 );
    self.var_69b5f743a7faa6c = "idle";
    self.thrusterstate = "idle";
    self.var_2657075a5e883b6a = 0;
    
    while ( true )
    {
        self waittill( #"thrusters_notify", state );
        self.var_69b5f743a7faa6c = self.thrusterstate;
        self.thrusterstate = state;
        
        if ( self.var_69b5f743a7faa6c == "active" && self.thrusterstate != "active" )
        {
            self notify( #"hash_57d51c353d570f20" );
            
            if ( self.var_2657075a5e883b6a )
            {
                self stoploopsound( #"hash_1eba958c0459d1f6" );
                self.var_2657075a5e883b6a = 0;
            }
            
            self playsound( #"hash_e02e2deb91ee7887" );
        }
        
        if ( self.thrusterstate == "idle" )
        {
            if ( self.var_69b5f743a7faa6c == "cooldown" )
            {
                function_9b0065d6803f0742( self, &"hash_42fca265fa175c34" );
            }
            
            continue;
        }
        
        if ( self.thrusterstate == "cooldown" )
        {
            function_9b0065d6803f0742( self, &"hash_53d20dcb932e9bcf" );
            continue;
        }
        
        if ( self.thrusterstate == "active" )
        {
            if ( self.var_69b5f743a7faa6c != "active" )
            {
                self playsound( #"hash_cc268538ffbfcc62" );
                self notify( #"hash_57d51c353d570f20" );
                thread function_f880d3354b0fb753();
            }
            
            self.thrusterstarttime = gettime();
            thread function_65454be8d22fba43();
        }
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x7d3520f3, Offset: 0x3e09
// Size: 0x66
function private function_f880d3354b0fb753()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_57d51c353d570f20" );
    wait 0.05;
    
    if ( self.thrusterstate == "active" && !self.var_2657075a5e883b6a )
    {
        self playloopsound( #"hash_1eba958c0459d1f6" );
        self.var_2657075a5e883b6a = 1;
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x598ab578, Offset: 0x3e77
// Size: 0x3f
function private function_afd5d3505cfe6fc8()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "super_mega_jump", "impact", 0 );
    wait 1;
    self setscriptablepartstate( "super_mega_jump", "off", 0 );
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0xeb7625ea, Offset: 0x3ebe
// Size: 0xf8
function private function_65454be8d22fba43()
{
    self notify( #"hash_f7813d3d1afa0498" );
    self endon( #"hash_f7813d3d1afa0498" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( self isonground() )
    {
        waitframe();
    }
    
    if ( !self isonground() && !self isparachuting() && !self isskydiving() && !self isswimming() )
    {
        self.falldamageprotection = 1;
        
        while ( player::isaliveandnotinlaststand( self ) )
        {
            if ( self isonground() || self isparachuting() || self iswingsuitdeployed() || self isswimming() || self isonladder() )
            {
                waitframe();
                break;
            }
            
            waitframe();
        }
    }
    
    self.falldamageprotection = 0;
    
    if ( self isonground() )
    {
        airtime = gettime() - self.thrusterstarttime;
        
        if ( airtime > getdvarfloat( @"hash_d5600f9e9fe9b97c", 2000 ) )
        {
            thread function_afd5d3505cfe6fc8();
        }
        
        waitframe();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x553f6dd, Offset: 0x3fbe
// Size: 0x2b
function private function_3fa06d951ea60aea()
{
    self endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_c9e6c607be886920 );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xd0ab23bd, Offset: 0x3ff1
// Size: 0x1dd
function private function_7414d550371be2ff( player )
{
    function_4e5a744c01913c7( player );
    
    if ( player.skilllevel == getdvarint( @"hash_9cad95e82951deea", 5 ) )
    {
        if ( getdvarint( @"hash_34ccbc47d4f3e759", 0 ) == 1 )
        {
            thread function_4b45a2fc64830de9( player );
        }
    }
    
    if ( player.skilllevel == getdvarint( @"hash_f86d10e011989377", 5 ) )
    {
        if ( getdvarint( @"hash_cdfe6f378a44aff2", 1 ) == 1 )
        {
            thread function_60315048818ab966( player );
        }
    }
    
    switch ( player.skilllevel )
    {
        case 1:
            player playsoundtoplayer( #"hash_3e7ed9a27fa372c8", player );
            break;
        case 2:
        case 3:
        case 4:
            var_5d98160630336cd5 = getdvarint( @"hash_5ac004a4b75de3c8", 120 ) * 1000;
            
            if ( !player.var_ab05f533d631a71 || gettime() - player.var_ab05f533d631a71 > var_5d98160630336cd5 )
            {
                playvo = randomint( 100 );
                
                if ( playvo < 50 )
                {
                    player playsoundtoplayer( #"hash_dff857ef452ba367", player );
                    player.var_ab05f533d631a71 = gettime();
                }
            }
            
            break;
        case 5:
            if ( !player.var_6f3a28d74f47aee7 )
            {
                player playsoundtoplayer( #"hash_80b6870ddba5d0ec", player );
                player.var_6f3a28d74f47aee7 = 1;
            }
            
            break;
    }
    
    if ( level.var_4c1500769aa35467 && player.skilllevel >= level.var_4c1500769aa35467.skills.size )
    {
        player function_8256173efac818fc();
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x6771abd7, Offset: 0x41d6
// Size: 0xb8
function private function_c9e6c607be886920( params )
{
    if ( self.var_a239f90431e6f428 || self.var_5be71076763ff4fd )
    {
        return;
    }
    
    foreach ( player in self.playerparticipants )
    {
        if ( player && isplayer( player ) && isalive( player ) )
        {
            br_skill_tracks::function_9e97467199778d2f( player );
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xdfc9d432, Offset: 0x4296
// Size: 0xe8
function private function_4e5a744c01913c7( player )
{
    expiretime = gettime() + 15000;
    teamplayers = teams::getteamdata( player.team, "players" );
    
    foreach ( squadmember in teamplayers )
    {
        if ( !squadmember || !isalive( squadmember ) )
        {
            continue;
        }
        
        if ( squadmember.var_96cf2501d50dd6c > gettime() )
        {
            continue;
        }
        
        squadmember.var_96cf2501d50dd6c = expiretime;
        squadmember thread function_edc62717805a311e();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x402cdb0a, Offset: 0x4386
// Size: 0x6a
function private function_edc62717805a311e()
{
    self endon( #"disconnect" );
    function_b4d9f8201508f327();
    diedearly = 0;
    
    while ( gettime() < self.var_96cf2501d50dd6c )
    {
        wait 0.25;
        
        if ( !isalive( self ) )
        {
            diedearly = 1;
            break;
        }
    }
    
    if ( diedearly || gettime() >= self.var_96cf2501d50dd6c )
    {
        function_400a1708b73d2a();
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x672f8285, Offset: 0x43f8
// Size: 0x1f
function private function_b4d9f8201508f327()
{
    self.hasradar = 1;
    self.radarshowenemydirection = 1;
    thread function_3243b5f281e0e259();
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xe86a1d5f, Offset: 0x441f
// Size: 0x6c
function private function_3243b5f281e0e259()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    radius = getdvarint( @"hash_a9b1fd308d58b7c3", 4000 );
    
    while ( gettime() < self.var_96cf2501d50dd6c )
    {
        triggerportableradarpingteam( self.origin, self.team, radius, 3000 );
        wait 3;
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x23b339f, Offset: 0x4493
// Size: 0x16
function private function_400a1708b73d2a()
{
    self.hasradar = 0;
    self.radarshowenemydirection = 0;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x923c80d4, Offset: 0x44b1
// Size: 0x59
function private function_4b45a2fc64830de9( player )
{
    if ( !isalive( player ) || !level.hmhhvt )
    {
        return;
    }
    
    if ( function_bb836a254a66cc6c( player.team ) )
    {
        return;
    }
    
    if ( !function_3b75bd1701fa8db2() || !isalive( player ) )
    {
        return;
    }
    
    function_1e4e9aa88362d37e( player );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x792158b1, Offset: 0x4512
// Size: 0xa1, Type: bool
function private function_bb836a254a66cc6c( team )
{
    foreach ( instance in level.hmhhvt.var_cc0e4315eede2fec )
    {
        if ( instance && instance.team == team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x3f4e3003, Offset: 0x45bc
// Size: 0xf7
function private function_3b75bd1701fa8db2()
{
    if ( level.hmhhvt.variantregistered )
    {
        return 1;
    }
    
    if ( isdefined( level.activities.definitions[ "hmh_tier5_mostwanted" ] ) )
    {
        level.hmhhvt.variantregistered = 1;
        return 1;
    }
    
    activitydefname = level.hmhhvt.activitydefname;
    bundlename = activitydefname;
    
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = "activityDefinition:" + bundlename;
    }
    
    testbundle = getscriptbundle( bundlename );
    
    if ( !testbundle )
    {
        return 0;
    }
    
    activity_definition_utils::function_74af1ab4059e3c06( activitydefname, "hmh_tier5_mostwanted" );
    level.hmhhvt.variantregistered = isdefined( level.activities.definitions[ "hmh_tier5_mostwanted" ] );
    return level.hmhhvt.variantregistered;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xb412c0ae, Offset: 0x46bc
// Size: 0x150
function private function_1e4e9aa88362d37e( player )
{
    hvtinstance = activity_instance_common::function_9b387cb1af0d5b4b( "hmh_tier5_mostwanted" );
    
    if ( !hvtinstance )
    {
        return;
    }
    
    hvtinstance.var_a239f90431e6f428 = 1;
    hvtinstance.var_ca369031b554da2f = player;
    hvtinstance.team = player.team;
    teamplayers = teams::getteamdata( player.team, "players" );
    activity_participation::function_fb0ec90aaf6d4c61( hvtinstance, teamplayers );
    level.hmhhvt.var_cc0e4315eede2fec[ level.hmhhvt.var_cc0e4315eede2fec.size ] = hvtinstance;
    targetentnum = player getentitynumber();
    
    foreach ( squadmember in teamplayers )
    {
        if ( squadmember )
        {
            squadmember setclientomnvar( "ui_activity_description_param", targetentnum );
        }
    }
    
    hvtinstance thread function_b8fe50ded270407f( player );
    hvtinstance thread function_4857c8d4dad19b2f( player );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xffa5614d, Offset: 0x4814
// Size: 0x129
function private function_b8fe50ded270407f( player )
{
    utility::waittill_any( "activity_failed", "activity_succeeded", "activity_ended", "instance_destroyed" );
    
    if ( player )
    {
        targetentnum = player getentitynumber();
        teamplayers = teams::getteamdata( player.team, "players" );
        
        foreach ( teamplayer in teamplayers )
        {
            if ( teamplayer && teamplayer getclientomnvar( "ui_activity_description_param" ) == targetentnum )
            {
                teamplayer setclientomnvar( "ui_activity_description_param", -1 );
            }
        }
    }
    
    if ( level.hmhhvt )
    {
        level.hmhhvt.var_cc0e4315eede2fec = arrayremove( level.hmhhvt.var_cc0e4315eede2fec, self );
    }
    
    function_59fd972216991bd0();
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x920dcaa1, Offset: 0x4945
// Size: 0x6e
function private function_4857c8d4dad19b2f( player )
{
    if ( !player )
    {
        return;
    }
    
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player endon( #"disconnect" );
    player waittill( #"mostwanted_activity_started" );
    waittillframeend();
    
    if ( self.var_332f929de1894b2b )
    {
        activity_definition_utils::updatetimer( self.var_332f929de1894b2b.contracttime, self );
    }
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0xc
// Checksum 0xd47aa1d3, Offset: 0x49bb
// Size: 0xd0
function private function_b91ba360679fcc56()
{
    self notify( #"hash_77ab20c1d7f2d412" );
    self endon( #"hash_77ab20c1d7f2d412" );
    self endon( #"game_ended" );
    
    while ( true )
    {
        wait 3;
        
        if ( getdvarint( @"hash_cdfe6f378a44aff2", 1 ) != 1 )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( function_e70f20c2cb5fb6d5( player ) )
            {
                thread function_60315048818ab966( player );
            }
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x9058f5f9, Offset: 0x4a93
// Size: 0x5b, Type: bool
function private function_e70f20c2cb5fb6d5( player )
{
    if ( !player || !isalive( player ) )
    {
        return false;
    }
    
    return player.var_c1ffac14a5dafd35 || level.var_4c1500769aa35467 && player.skilllevel >= level.var_4c1500769aa35467.skills.size;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xdd5c786d, Offset: 0x4af7
// Size: 0x82, Type: bool
function private function_f6a2caaf037607bf( player )
{
    now = gettime();
    
    if ( isdefined( player.var_898e04e3c72f14aa ) && now < player.var_898e04e3c72f14aa )
    {
        return true;
    }
    
    if ( level.var_703d53e4b3785bc && isdefined( level.var_703d53e4b3785bc.var_b517ada79dc118b0 ) && now < level.var_703d53e4b3785bc.var_b517ada79dc118b0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0xf1949b8c, Offset: 0x4b82
// Size: 0x120
function private function_60315048818ab966( player )
{
    if ( !function_e70f20c2cb5fb6d5( player ) || !level.var_703d53e4b3785bc )
    {
        return;
    }
    
    if ( function_f6a2caaf037607bf( player ) )
    {
        return;
    }
    
    if ( function_8dd7b714cc189422( player ) || function_21f8a46bce138c59( player ) )
    {
        return;
    }
    
    function_fd964ab2c8c2403( player, 1 );
    
    if ( !function_eb6d44858861fcff() )
    {
        function_fd964ab2c8c2403( player, 0 );
        return;
    }
    
    if ( !function_e70f20c2cb5fb6d5( player ) || function_8dd7b714cc189422( player ) )
    {
        function_fd964ab2c8c2403( player, 0 );
        return;
    }
    
    if ( getdvarint( @"hash_dc0beb59ff877ac3", 1 ) )
    {
        targetteam = function_61dc4ba3bb696f97( player, 0, level.var_703d53e4b3785bc.var_254d4c01c9580d1d );
    }
    else
    {
        targetteam = br_assassination_quest::determinetargetteam( player, 0, undefined, level.var_703d53e4b3785bc.var_254d4c01c9580d1d );
    }
    
    if ( !isdefined( targetteam ) )
    {
        function_9b0065d6803f0742( player, &"hash_da9c7e81c4cd587" );
        function_fd964ab2c8c2403( player, 0 );
        return;
    }
    
    function_7bc9fe5a37184d1f( player, targetteam );
    function_fd964ab2c8c2403( player, 0 );
}

// Namespace br_gametype_hmh
// Params 3, eflags: 0x4
// Checksum 0x68c49b0b, Offset: 0x4caa
// Size: 0x2ac
function private function_61dc4ba3bb696f97( player, var_2caf42ecba63b0b1, searchparams = level.asnprops )
{
    hunterteam = player.team;
    excludedplayers = arraycombineunique( level.var_179b6c3280c0c8f8, teams::getteamdata( hunterteam, "players" ) );
    hunterteamsize = 0;
    var_402384e392946204 = ( 0, 0, 0 );
    
    foreach ( teammate in teams::getteamdata( hunterteam, "players" ) )
    {
        if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
        {
            hunterteamsize++;
            var_402384e392946204 += teammate.origin;
        }
    }
    
    if ( hunterteamsize == 0 )
    {
        return;
    }
    
    var_402384e392946204 /= hunterteamsize;
    searchbounds = 0;
    searchminradius = searchparams.minsearchradius ?? level.asnprops.minsearchradius;
    var_cbbb9e520c58a2a8 = searchparams.var_bb48e4be7d9b68b3 ?? level.asnprops.var_bb48e4be7d9b68b3;
    searchlimit = searchparams.searchlimit ?? level.asnprops.searchlimit;
    searchincrement = searchparams.searchincrement ?? level.asnprops.searchincrement;
    var_8cf349a832ce4853 = searchparams.var_112ae0069201f666 ?? 0;
    var_cc11c46c0f96af9f = searchparams.var_cc11c46c0f96af9f ?? level.asnprops.var_cc11c46c0f96af9f;
    
    while ( true )
    {
        searchbounds += searchincrement;
        mindist = searchbounds < var_cbbb9e520c58a2a8 ? searchminradius : undefined;
        maxdist = searchminradius + searchbounds;
        bestteam = function_eb442d4683b4fd18( player, var_2caf42ecba63b0b1, excludedplayers, hunterteamsize, var_402384e392946204, var_cc11c46c0f96af9f, maxdist, mindist, 1 );
        
        if ( isdefined( bestteam ) )
        {
            return bestteam;
        }
        
        if ( searchbounds < searchlimit )
        {
            continue;
        }
        
        if ( var_8cf349a832ce4853 )
        {
            return;
        }
        
        return function_eb442d4683b4fd18( player, var_2caf42ecba63b0b1, excludedplayers, hunterteamsize, var_402384e392946204, var_cc11c46c0f96af9f, undefined, undefined, 0 );
    }
}

// Namespace br_gametype_hmh
// Params 9, eflags: 0x4
// Checksum 0x7f1dfb1d, Offset: 0x4f5e
// Size: 0x3b9
function private function_eb442d4683b4fd18( player, var_2caf42ecba63b0b1, excludedplayers, hunterteamsize, var_402384e392946204, var_cc11c46c0f96af9f, maxdist, mindist, var_e7906642266ec003 )
{
    bestteam = undefined;
    var_ba9a7907c7fae1c0 = 0;
    var_185575d2f2c4e700 = undefined;
    gametype = game_utility::getgametype();
    var_ad5be18b8fff6d02 = undefined;
    
    if ( isdefined( maxdist ) )
    {
        var_ad5be18b8fff6d02 = maxdist * maxdist;
    }
    
    var_dcbef06523a50f78 = 0;
    
    if ( isdefined( mindist ) )
    {
        var_dcbef06523a50f78 = mindist * mindist;
    }
    
    foreach ( potentialtarget in level.players )
    {
        if ( arraycontains( excludedplayers, potentialtarget ) )
        {
            continue;
        }
        
        if ( !br_assassination_quest::function_43dca0233c4164a7( player, potentialtarget ) )
        {
            continue;
        }
        
        if ( var_2caf42ecba63b0b1 && !br_circle_util::function_554002773c2c21f7( player.origin, potentialtarget.origin ) )
        {
            continue;
        }
        
        if ( potentialtarget br_public::isplayerinorgoingtogulag() || !player::isreallyalive( potentialtarget ) )
        {
            continue;
        }
        
        if ( var_e7906642266ec003 && ( potentialtarget.hasbeentracked || potentialtarget br_assassination_quest::function_72f666fd14cbc49c() ) )
        {
            continue;
        }
        
        dist2 = distancesquared( player.origin, potentialtarget.origin );
        
        if ( isdefined( var_ad5be18b8fff6d02 ) && dist2 > var_ad5be18b8fff6d02 )
        {
            continue;
        }
        
        if ( dist2 < var_dcbef06523a50f78 )
        {
            continue;
        }
        
        targetteam = potentialtarget.team;
        var_dbfcc362a6b86751 = 0;
        var_5b42a6d35b1ec579 = ( 0, 0, 0 );
        
        foreach ( teammate in teams::getteamdata( targetteam, "players" ) )
        {
            if ( !teammate br_public::isplayerinorgoingtogulag() && player::isreallyalive( teammate ) )
            {
                var_dbfcc362a6b86751++;
                var_5b42a6d35b1ec579 += teammate.origin;
            }
        }
        
        if ( var_dbfcc362a6b86751 == 0 )
        {
            continue;
        }
        
        var_5b42a6d35b1ec579 /= var_dbfcc362a6b86751;
        
        if ( !isdefined( bestteam ) )
        {
            bestteam = targetteam;
            var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = var_5b42a6d35b1ec579;
            continue;
        }
        
        if ( gametype == "plunder" )
        {
            var_f7fd89704d030575 = br_plunder::getteamcarriedplunder( bestteam );
            var_23542beff0c4034c = br_plunder::getteamcarriedplunder( targetteam );
            
            if ( var_23542beff0c4034c > var_cc11c46c0f96af9f )
            {
                if ( var_23542beff0c4034c > var_f7fd89704d030575 )
                {
                    bestteam = targetteam;
                    var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
                    var_185575d2f2c4e700 = var_5b42a6d35b1ec579;
                    continue;
                }
            }
        }
        
        bestdifference = abs( hunterteamsize - var_ba9a7907c7fae1c0 );
        currentdifference = abs( hunterteamsize - var_dbfcc362a6b86751 );
        
        if ( currentdifference < bestdifference )
        {
            bestteam = targetteam;
            var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = var_5b42a6d35b1ec579;
            continue;
        }
        else if ( currentdifference > bestdifference )
        {
            continue;
        }
        
        if ( var_ba9a7907c7fae1c0 < var_dbfcc362a6b86751 )
        {
            bestteam = targetteam;
            var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = var_5b42a6d35b1ec579;
            continue;
        }
        else if ( var_ba9a7907c7fae1c0 > var_dbfcc362a6b86751 )
        {
            continue;
        }
        
        if ( distance2d( var_402384e392946204, var_5b42a6d35b1ec579 ) < distance2d( var_402384e392946204, var_185575d2f2c4e700 ) )
        {
            bestteam = targetteam;
            var_ba9a7907c7fae1c0 = var_dbfcc362a6b86751;
            var_185575d2f2c4e700 = var_5b42a6d35b1ec579;
        }
    }
    
    return bestteam;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xa34de1f9, Offset: 0x5320
// Size: 0xd2
function private function_b3987504614347f0()
{
    pruned = [];
    
    foreach ( instance in level.var_703d53e4b3785bc.var_cc0e4315eede2fec )
    {
        if ( instance )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                pruned[ pruned.size ] = instance;
            }
        }
    }
    
    level.var_703d53e4b3785bc.var_cc0e4315eede2fec = pruned;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0x4b891724, Offset: 0x53fa
// Size: 0x10
function private function_f09905c6b472890a()
{
    return getdvarint( @"hash_c601618fd6c30dc7", 0 );
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x2ef304ba, Offset: 0x5413
// Size: 0x36
function private function_8ef241d9c74e3d41( player )
{
    if ( function_f09905c6b472890a() == 1 )
    {
        return ( "team_" + player.team );
    }
    
    return "player_" + player getentitynumber();
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x5efcb8a4, Offset: 0x5452
// Size: 0x36
function private function_21f8a46bce138c59( player )
{
    scopekey = function_8ef241d9c74e3d41( player );
    return level.var_703d53e4b3785bc.var_e2af8b2122ee4255[ scopekey ];
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0xc0390218, Offset: 0x5491
// Size: 0x41
function private function_fd964ab2c8c2403( player, var_b17469423ef60416 )
{
    scopekey = function_8ef241d9c74e3d41( player );
    level.var_703d53e4b3785bc.var_e2af8b2122ee4255[ scopekey ] = var_b17469423ef60416;
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x681e0f55, Offset: 0x54da
// Size: 0xe3, Type: bool
function private function_8dd7b714cc189422( player )
{
    var_42372a983faa2088 = function_f09905c6b472890a() == 1;
    function_b3987504614347f0();
    
    foreach ( instance in level.var_703d53e4b3785bc.var_cc0e4315eede2fec )
    {
        if ( !instance )
        {
            continue;
        }
        
        if ( var_42372a983faa2088 )
        {
            if ( instance.team == player.team )
            {
                return true;
            }
            
            continue;
        }
        
        if ( instance.var_ca369031b554da2f == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xbeea7ac2, Offset: 0x55c6
// Size: 0x129
function private function_eb6d44858861fcff()
{
    if ( level.var_703d53e4b3785bc.variantregistered )
    {
        return 1;
    }
    
    if ( isdefined( level.activities.definitions[ "hmh_tier5_bounty" ] ) )
    {
        level.var_703d53e4b3785bc.variantregistered = 1;
        return 1;
    }
    
    activitydefname = level.var_703d53e4b3785bc.activitydefname;
    bundlename = activitydefname;
    
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = "activityDefinition:" + bundlename;
    }
    
    testbundle = getscriptbundle( bundlename );
    
    if ( !testbundle )
    {
        return 0;
    }
    
    activity_definition_utils::function_74af1ab4059e3c06( activitydefname, "hmh_tier5_bounty" );
    level.var_703d53e4b3785bc.variantregistered = isdefined( level.activities.definitions[ "hmh_tier5_bounty" ] );
    
    if ( level.var_703d53e4b3785bc.variantregistered )
    {
        level.var_703d53e4b3785bc.var_254d4c01c9580d1d = activity_definition_utils::function_9129cd8075c85c09( testbundle );
    }
    
    return level.var_703d53e4b3785bc.variantregistered;
}

// Namespace br_gametype_hmh
// Params 2, eflags: 0x4
// Checksum 0x7683b4b7, Offset: 0x56f8
// Size: 0x157
function private function_7bc9fe5a37184d1f( player, targetteam )
{
    bountyinstance = activity_instance_common::function_9b387cb1af0d5b4b( "hmh_tier5_bounty" );
    
    if ( !bountyinstance )
    {
        return;
    }
    
    bountyinstance.var_5be71076763ff4fd = 1;
    bountyinstance.var_ca369031b554da2f = player;
    bountyinstance.team = player.team;
    overridesucceeded = bountyinstance namespace_2acee5c054dc328c::function_6a015dc94c111927( player.team, targetteam, &function_4e2bfb012515b5e6, level );
    
    if ( !overridesucceeded )
    {
        activity_instance_common::endactivity( bountyinstance, 0 );
        return;
    }
    
    targetplayers = teams::getteamdata( targetteam, "players" );
    
    foreach ( targetplayer in targetplayers )
    {
        targetplayer playsoundtoplayer( #"hash_bc7fe330c0661a62", targetplayer );
    }
    
    level.var_703d53e4b3785bc.var_cc0e4315eede2fec[ level.var_703d53e4b3785bc.var_cc0e4315eede2fec.size ] = bountyinstance;
}

// Namespace br_gametype_hmh
// Params 3, eflags: 0x4
// Checksum 0xb96434ba, Offset: 0x5857
// Size: 0x108
function private function_4e2bfb012515b5e6( contract, success, endstate )
{
    rewardowner = contract.var_ca369031b554da2f;
    
    if ( success && endstate == "Win" )
    {
        br_activity_util::function_381d1d8f56715c32( contract.team, "activitiesCompleted" );
        
        if ( rewardowner && isplayer( rewardowner ) )
        {
            function_7056df226fda5505( rewardowner );
        }
    }
    
    function_a029943461d830dc( contract );
    
    if ( success && endstate == "Win" && rewardowner && isplayer( rewardowner ) )
    {
        now = gettime();
        rewardowner.var_898e04e3c72f14aa = now + getdvarint( @"hash_81f8a199674a992d", 3000 );
        
        if ( level.var_703d53e4b3785bc )
        {
            level.var_703d53e4b3785bc.var_b517ada79dc118b0 = now + getdvarint( @"hash_937858c96dae86e7", 500 );
        }
        
        thread function_b2a52554f4b8ded2( rewardowner );
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x3298e49c, Offset: 0x5967
// Size: 0x21
function private function_b2a52554f4b8ded2( player )
{
    waitframe();
    
    if ( function_e70f20c2cb5fb6d5( player ) )
    {
        function_60315048818ab966( player );
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x7523e164, Offset: 0x5990
// Size: 0x4e
function private function_a029943461d830dc( contract )
{
    if ( level.var_703d53e4b3785bc )
    {
        level.var_703d53e4b3785bc.var_cc0e4315eede2fec = arrayremove( level.var_703d53e4b3785bc.var_cc0e4315eede2fec, contract );
    }
    
    contract function_59fd972216991bd0();
}

// Namespace br_gametype_hmh
// Params 0, eflags: 0x4
// Checksum 0xd27a014c, Offset: 0x59e6
// Size: 0x79
function private function_59fd972216991bd0()
{
    if ( level.activitymanager )
    {
        level.activitymanager.var_cc0e4315eede2fec = arrayremove( level.activitymanager.var_cc0e4315eede2fec, self );
        
        if ( level.activitymanager.var_ec04bf3a584cbd90[ self.team ] == self )
        {
            level.activitymanager.var_ec04bf3a584cbd90[ self.team ] = undefined;
        }
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x459670d6, Offset: 0x5a67
// Size: 0x2a3
function private function_7056df226fda5505( player )
{
    if ( !player || !isplayer( player ) )
    {
        return;
    }
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
    
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
    forward = anglestoforward( playerangles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    droppoint = isnavmeshloaded() ? getclosestpointonnavmesh( playerorigin + offset ) : playerorigin + offset;
    crate = airdrop::dropcrate( undefined, playerteam, "legendary_supply_drop", droppoint + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), droppoint );
    crate.source = "contract_activity";
    crate.skipminimapicon = 1;
    
    if ( !isdefined( crate.crateinfo ) )
    {
        crate.crateinfo = {};
    }
    
    crate.crateinfo.var_7a140188db547e4a = "br_quest_vip_crate";
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id <= -1 )
    {
        return;
    }
    
    crate setscriptablepartstate( "objective_map", "hidden" );
    fadestart = getdvarint( @"hash_3f485fe18a08de25", 4921 );
    fadeend = getdvarint( @"hash_18160829d60f2e3c", 5906 );
    objidpoolmanager::objective_add_objective( id, "current", crate.origin, "ui_map_icon_supply_drop_yellow" );
    objective_addalltomask( id );
    objective_showtoplayersinmask( id );
    objective_setbackground( id, 1 );
    objective_onentity( id, crate );
    objective_setzoffset( id, 75 );
    objective_setdescription( id, &"mp_saw_manticore/wanted_crate_ping" );
    function_ac9886e0e2860e18( id, fadestart, fadeend );
    function_44a344c68a68f28d( id, 1 );
    crate.scriptedobjid = id;
    player calloutmarkerping::function_5d7b7302e94b97c2( crate.scriptedobjid );
    level.brgametype thread namespace_4aabd2c8a4353c13::function_220cf16950d590c7( crate );
    
    if ( !level.br_circle_disabled )
    {
        crate thread namespace_4aabd2c8a4353c13::function_65fa856fb85f5bb8( droppoint );
    }
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x460a958d, Offset: 0x5d12
// Size: 0x9f
function private onentervehicle( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_5c0e71a484a29daa ) )
    {
        player.var_5c0e71a484a29daa = 0;
    }
    
    var_8fecf3680fae0fc6 = getdvarint( @"hash_98e4d92b06dc4ae7", 120 ) * 1000;
    
    if ( gettime() - player.var_5c0e71a484a29daa < var_8fecf3680fae0fc6 )
    {
        return;
    }
    
    player playsoundtoplayer( #"hash_2ddffff5b98de782", player );
    player.var_5c0e71a484a29daa = gettime();
}

// Namespace br_gametype_hmh
// Params 1, eflags: 0x4
// Checksum 0x72850c9e, Offset: 0x5db9
// Size: 0xb7
function private ongameended( params )
{
    if ( !params.winner )
    {
        return;
    }
    
    players = teams::getteamdata( params.winner, "players" );
    
    foreach ( player in players )
    {
        player playsoundtoplayer( #"hash_c3e6e249486356d3", player );
    }
}

