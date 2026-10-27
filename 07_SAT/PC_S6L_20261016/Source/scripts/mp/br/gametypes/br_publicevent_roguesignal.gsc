// scripts\mp\br\gametypes\br_publicevent_roguesignal.gsc  (hash_3b4563ac2ef89520.gscc) (size: 24126 Bytes / 0x5e3e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7260ef8e (1918955406)
// size ...... 24126 (0x5e3e)
// includes .. 26  (offset: 0x55b6)
// strings ... 89  (offset: 0x5686)
// dev strs .. 46  (offset: 0x5bfa)
// exports ... 48  (offset: 0x3a96)
// cseg ...... 0x83a + 0x325c (0x3a96)
// imports ... 156 (offset: 0x4216)
// animtree1 . 0   (offset: 0x5e3e)
// animtree2 . 0   (offset: 0x5e3e)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace br_publicevent_roguesignal;

// Namespace br_publicevent_roguesignal
// Params 0, eflags: 0x1
// Checksum 0xa8fcc369, Offset: 0x858
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"roguesignal", &init );
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xf587b0f8, Offset: 0x877
// Size: 0x3a3
function init( event_info )
{
    if ( !getdvarint( @"hash_89b60b73bfd9d3d0", 1 ) )
    {
        return;
    }
    
    event_info.waitfunc = &event_wait;
    event_info.activatefunc = &event_activate;
    event_info.postinitfunc = &event_post_init;
    event_info.deactivatefunc = &event_deactivate;
    
    if ( !isdefined( level.roguesignalinfo ) )
    {
        level.roguesignalinfo = spawnstruct();
    }
    
    level.roguesignalinfo.currenteventtype = 0;
    level.roguesignalinfo.scoreboard = [];
    level.roguesignalinfo.eventlength = int( getdvarint( @"hash_e21294ff91f57b89", 90 ) * getmatchrulesdata( "brData", "circleTimeScale" ) );
    level.roguesignalinfo.eventtypes = [ 1, 2, 3, 4 ];
    level.roguesignalinfo.overrideeventtype = getdvarint( @"hash_c6da18effb6c4994", 0 );
    level.roguesignalinfo.var_c21beddc31c1000d = getdvar( @"hash_861d51c9341fe8f9", "" );
    
    if ( getdvarint( @"scr_br_powerups_enabled", 0 ) )
    {
        level.roguesignalinfo.eventtypes[ level.roguesignalinfo.eventtypes.size ] = 5;
    }
    
    if ( level.roguesignalinfo.var_c21beddc31c1000d.size > 0 )
    {
        types = strtok( level.roguesignalinfo.var_c21beddc31c1000d, " " );
        
        foreach ( type in types )
        {
            level.roguesignalinfo.eventtypes = arrayremove( level.roguesignalinfo.eventtypes, int( type ) );
        }
    }
    
    level.roguesignalinfo.reward_cache = getdvar( @"hash_876e11a369398181", "br_loot_cache_roguesignal" );
    level.roguesignalinfo.var_6422b98a4e22e1d2 = getdvarint( @"hash_f88e4c4cbda6bc29", 30 );
    level.roguesignalinfo.var_90478ae18206c270 = getdvarint( @"hash_f32e42c626fbdc2b", 1 );
    level.roguesignalinfo.var_20b0b11854b50073 = getdvarint( @"hash_50a6b11ae660d67a", 125 );
    level.roguesignalinfo.use_quest_circle = getdvarint( @"hash_ff3f8dd3d8aa4cec", 0 );
    level.roguesignalinfo.start_buffer = getdvarfloat( @"scr_br_pe_roguesignal_start_buffer", 4.5 );
    level.roguesignalinfo.var_d704d3a7b1e60666 = getdvarint( @"hash_6c52f2d632e0f977", 1 );
    level.roguesignalinfo.var_d704d3a7b1e60666 = getdvarint( @"hash_64e3c0caa0d0a267", 0 );
    
    if ( !isdefined( level.var_d4e1d6e51b37f60b ) )
    {
        level.var_d4e1d6e51b37f60b = [];
    }
    
    /#
        initdebug();
    #/
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x5b14ef98, Offset: 0xc22
// Size: 0xa
function event_post_init()
{
    level thread _init_cache_spawn_data();
}

// Namespace br_publicevent_roguesignal
// Params 0, eflags: 0x4
// Checksum 0x5d3b9a25, Offset: 0xc34
// Size: 0xb8
function private _init_cache_spawn_data()
{
    utility::flag_wait( "items_database_init" );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_publicevent_roguesignal" );
    rewardspawnlist = var_f67995529827f79.spawnlistname ?? "wz_br_spawn_list_publicevent_roguesignal";
    rewardcount = var_f67995529827f79.spawncount ?? 8;
    level.roguesignalinfo.reward_spawn_list = getdvar( @"hash_770d1c5e79a1715", rewardspawnlist );
    level.roguesignalinfo.reward_count = getdvarint( @"hash_efdfaac9a0448588", rewardcount );
    level.roguesignalinfo.var_119af86901a589eb = 1;
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0xd9614221, Offset: 0xcf4
// Size: 0x2
function event_wait()
{
    
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x299f0ffb, Offset: 0xcfe
// Size: 0x180
function event_activate()
{
    if ( !level.roguesignalinfo.var_119af86901a589eb )
    {
        script::demoforcesre( "Rogue Signal public event was activated before it finished setup. This is not allowed. Is the Battle Royale circle enabled?" );
        return;
    }
    
    event = utility::array_random( level.roguesignalinfo.eventtypes );
    
    if ( level.roguesignalinfo.overrideeventtype > 0 )
    {
        event = level.roguesignalinfo.overrideeventtype;
    }
    
    dialog = undefined;
    
    switch ( event )
    {
        case 1:
            dialog = "rogue_signal_" + "event_type_cash";
            break;
        case 3:
            dialog = "rogue_signal_" + "event_type_damage";
            break;
        case 2:
            dialog = "rogue_signal_" + "event_type_kills";
            break;
        case 4:
            dialog = "rogue_signal_" + "event_type_caches";
            break;
        case 5:
            dialog = "rogue_signal_" + "event_type_powerups";
            break;
    }
    
    if ( isdefined( dialog ) )
    {
        br_public::brleaderdialog( dialog, 1, undefined, undefined, level.roguesignalinfo.start_buffer, undefined, "dx_br_smis_" );
    }
    
    br_public::brleaderdialog( "rogue_signal_" + "event_starting", 1, undefined, undefined, 0.5, undefined, "dx_br_smis_" );
    startevent( event );
    level thread br_publicevents::function_a1af4e372c2ecc3( %"roguesignal" );
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x285f3815, Offset: 0xe86
// Size: 0x340
function startevent( eventtype )
{
    level endon( #"event_deactivated" );
    level endon( #"game_ended" );
    event_ref = "";
    
    switch ( eventtype )
    {
        case 1:
            event_ref = "plunder";
            level callback::add( "currency_add", &on_plunder_pickup );
            break;
        case 3:
            event_ref = "damage";
            level callback::add( #"player_damaged", &on_player_damaged );
            break;
        case 2:
            event_ref = "kills";
            level callback::add( #"player_death", &on_player_killed );
            break;
        case 4:
            event_ref = "loot";
            level callback::add( "lootcache_looted", &on_cache_opened );
            break;
        case 5:
            event_ref = "powerups";
            level callback::add( #"player_powerup", &on_player_powerup );
            break;
    }
    
    level callback::add( "on_squad_eliminated", &on_squad_eliminated );
    
    if ( level.usegulag )
    {
        level callback::add( #"hash_c15c682d6a5dcae0", &on_player_enter_gulag );
        level callback::add( #"br_player_respawn", &on_player_respawn );
    }
    
    level.roguesignalinfo.scoreboard = [];
    level.roguesignalinfo.currenteventtype = eventtype;
    
    foreach ( team in level.teamnamelist )
    {
        if ( teams::getteamcount( team ) == 0 )
        {
            continue;
        }
        
        function_7ceebb35c0da1c20( team, 0 );
    }
    
    function_f00cc42bdb2fe085();
    setomnvarforallclients( "ui_br_roguesignal_active", eventtype );
    br_publicevents::showsplashtoall( "br_pe_roguesignal_start_" + event_ref, "splash_list_br_pe_roguesignal" );
    timer = gettime() + level.roguesignalinfo.eventlength * 1000;
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 14 );
    setomnvar( "ui_publicevent_timer", timer );
    
    if ( eventtype == 3 || eventtype == 1 )
    {
        level thread function_d30a4f37efe934eb();
    }
    
    if ( ftue_progress::ftue_enabled() )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player thread ftue_play( eventtype );
            }
        }
    }
    
    level thread function_6959120a2cbf0b80();
    wait level.roguesignalinfo.eventlength;
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x9a547983, Offset: 0x11ce
// Size: 0x9
function event_deactivate()
{
    function_31c4c5162449ac0a();
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x7e493e5b, Offset: 0x11df
// Size: 0x4e7
function function_31c4c5162449ac0a()
{
    level notify( #"hash_c92b3d8dc539800a" );
    
    switch ( level.roguesignalinfo.currenteventtype )
    {
        case 1:
            level callback::remove( "currency_add", &on_plunder_pickup );
            break;
        case 3:
            level callback::remove( #"player_damaged", &on_player_damaged );
            break;
        case 2:
            level callback::remove( #"player_death", &on_player_killed );
            break;
        case 4:
            level callback::remove( "lootcache_looted", &on_cache_opened );
            break;
        case 5:
            level callback::remove( #"player_powerup", &on_player_powerup );
            break;
    }
    
    level callback::remove( "on_squad_eliminated", &on_squad_eliminated );
    level.roguesignalinfo.currenteventtype = 0;
    level.roguesignalinfo.scoreboard = arraysort( level.roguesignalinfo.scoreboard, undefined, &sortbyscore );
    winners = [];
    
    for ( i = 0; i < level.roguesignalinfo.scoreboard.size ; i++ )
    {
        if ( !( isdefined( level.roguesignalinfo.scoreboard[ i ] ) && isdefined( level.roguesignalinfo.scoreboard[ i ].teamid ) ) || level.roguesignalinfo.scoreboard[ i ].score <= 0 )
        {
            continue;
        }
        
        winners[ winners.size ] = level.roguesignalinfo.scoreboard[ i ].teamid;
        
        if ( winners.size == 3 )
        {
            break;
        }
    }
    
    foreach ( index, team in winners )
    {
        dialog = index == 0 ? "event_completion_top_squad" : "event_completion_top_three";
        br_public::brleaderdialogteam( "rogue_signal_" + dialog, team, 1, 0.5, undefined, "dx_br_smis_" );
    }
    
    if ( winners.size > 0 )
    {
        level spawn_reward_cache( winners, 1 );
    }
    
    foreach ( player in level.players )
    {
        iswinner = arraycontains( winners, player.team );
        
        if ( !iswinner && !level.roguesignalinfo.var_d704d3a7b1e60666 )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        splashname = iswinner ? "br_pe_roguesignal_success" : "br_pe_roguesignal_fail";
        player hud_message::showsplash( splashname, undefined, undefined, undefined, undefined, "splash_list_br_pe_roguesignal" );
    }
    
    foreach ( idx, team in winners )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            player points::doscoreevent( #"br_pe_roguesignal_success" );
            player br_plunder::playerplunderpickup( level.roguesignalinfo.var_20b0b11854b50073 * ( 3 - idx ), undefined, undefined, 1 );
            challenges::function_37e945722d6497f3( player, "br_decay_rogue_signal_top_3", 1 );
        }
    }
    
    setomnvarforallclients( "ui_br_roguesignal_active", 0 );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    analytics_on_complete();
    level notify( #"event_deactivated" );
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0xcff95f60, Offset: 0x16ce
// Size: 0x2cb
function spawn_reward_cache( team_list, is_locked = 0 )
{
    caches = getunusedlootcachepoints( br_circle::getnextsafecircleorigin(), br_circle::getnextsafecircleradius(), 0, 1 );
    
    if ( caches.size == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    location = utility::array_random( caches );
    cache = spawnscriptable( level.roguesignalinfo.reward_cache, location.origin, location.angles );
    common_cache::fillcontentsfromlist( cache, level.roguesignalinfo.reward_spawn_list, level.roguesignalinfo.reward_count );
    
    if ( is_locked && level.roguesignalinfo.var_6422b98a4e22e1d2 > 0 )
    {
        cache.is_unlocked = 0;
        cache thread function_aabdabbe873bfef3( team_list, level.roguesignalinfo.var_6422b98a4e22e1d2, 5 );
    }
    else
    {
        cache setscriptablepartstate( "body", "closed_usable" );
        cache.is_unlocked = 1;
    }
    
    cache thread function_e67a7708feca21aa();
    cache.var_6e39895e14c70e34 = &function_432710eed283053e;
    cache.team_list = team_list;
    cache.is_for_all = level.roguesignalinfo.var_90478ae18206c270;
    cache.is_roguesignal = 1;
    cache.spawn_time = gettime();
    
    if ( level.roguesignalinfo.use_quest_circle )
    {
        cache game_utility::questcircle_create( "RogueSignal_Br", cache.origin, 512 );
        
        foreach ( team in team_list )
        {
            foreach ( player in teams::getteamdata( team, "players" ) )
            {
                cache game_utility::questcircle_showtoplayer( player );
            }
        }
    }
    
    level.roguesignalinfo.cache = cache;
    return cache;
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0x21f3f980, Offset: 0x19a2
// Size: 0x178
function reward_cache_create_objective( team_list, progress )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    self.objidnum = objid;
    objidpoolmanager::objective_add_objective( objid, "current", self.origin + ( 0, 0, 64 ), "hud_icon_objective_roguesignal", "icon_regular" );
    objidpoolmanager::function_586b631e7bbb592a( objid, 0 );
    objidpoolmanager::objective_set_play_intro( objid, 1 );
    objidpoolmanager::update_objective_setbackground( objid, 12 );
    objidpoolmanager::update_objective_description( objid, &"mp_br_ingame/loot_cache_roguesignal" );
    
    foreach ( team in team_list )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( objid, player );
        }
    }
}

// Namespace br_publicevent_roguesignal
// Params 3
// Checksum 0x3571a7b2, Offset: 0x1b22
// Size: 0x2a2
function function_aabdabbe873bfef3( team_list, time, buffer = level.framedurationseconds )
{
    level endon( #"game_ended" );
    interact = interaction::register_interact( self.origin + ( 0, 0, 24 ), 64, &function_5790d1aa26931c4f );
    interact.cache = self;
    interact setusableenabled( 1 );
    interact interaction::set_interact_hint_callback( &function_d4e5f5726090f0ad );
    reward_cache_create_objective( team_list, 1 );
    wait buffer;
    
    foreach ( team in team_list )
    {
        foreach ( player in teams::getteamdata( team, "alivePlayers" ) )
        {
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            player calloutmarkerping::function_5d7b7302e94b97c2( self.objidnum, self.origin );
            break;
        }
    }
    
    thread function_609493addea9b588( time );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    start_time = gettime();
    completion_rate = 0;
    cacheid = self.objidnum;
    
    while ( completion_rate < 1 && isdefined( self ) )
    {
        elapsed_time = ( gettime() - start_time ) / 1000;
        completion_rate = clamp( elapsed_time / time, 0, 1 );
        self.completion_rate = completion_rate;
        
        if ( isdefined( self.objidnum ) )
        {
            objidpoolmanager::objective_set_progress( self.objidnum, completion_rate );
        }
        
        wait 0.1;
    }
    
    interact delete();
    
    if ( !isdefined( self ) )
    {
        function_b4a3df7120dfdadf( cacheid );
        return;
    }
    
    if ( isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    reward_cache_enable();
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x2b37f963, Offset: 0x1dcc
// Size: 0x39
function function_609493addea9b588( time )
{
    level endon( #"game_ended" );
    
    if ( time > 30 )
    {
        wait time - 30;
    }
    
    playsoundatpos( self.origin, "dx_br_smis_rspe_rfcv_rsln" );
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x9a41b92c, Offset: 0x1e0d
// Size: 0x73
function function_e67a7708feca21aa()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( #"opened" );
    danger_time = br_circle_util::gettimetilldangerforpoint( self.origin ) + 15;
    wait danger_time;
    self setscriptablepartstate( "body", "fully_open_unusable" );
    function_b4a3df7120dfdadf();
    function_138bfe45c5a41bbb( "gas" );
    wait 5;
    self freescriptable();
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0x619877de, Offset: 0x1e88
// Size: 0xdd
function function_d4e5f5726090f0ad( interact, player )
{
    cache = interact.cache;
    
    if ( !cache.is_unlocked )
    {
        time_in_s = int( ceil( level.roguesignalinfo.var_6422b98a4e22e1d2 * ( 1 - ( cache.completion_rate ?? 0 ) ) ) );
        
        if ( time_in_s > 0 )
        {
            return { #params:[ &"mp_br_ingame/loot_cache_roguesignal", time_in_s ], #string:&"mp_br_ingame/cache_unlocked_in_x", #type:"HINT_BUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x919a609e, Offset: 0x1f6e
// Size: 0x43
function reward_cache_enable()
{
    playsoundatpos( self.origin, "br_loot_cache_chest_recharge_beep_full" );
    playsoundatpos( self.origin, "dx_br_smis_rspe_rfcv_rscu" );
    self.is_unlocked = 1;
    self setscriptablepartstate( "body", "closed_usable" );
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0xcd4cf36c, Offset: 0x1fb9
// Size: 0xb4
function function_5ab3d18c87ca0e31( items, instance )
{
    if ( instance.is_roguesignal )
    {
        if ( utility::issharedfuncdefined( #"roguesignal", #"cache_reward" ) )
        {
            items = instance utility::callsharedfunc( #"roguesignal", #"cache_reward", items );
            assert( isarray( items ) && items.size > 0, "<dev string:x78>" + "<dev string:xae>" );
        }
        else
        {
            weapon_str = "jup_pi_raygun_mp";
            add_items = [ weapon_utility::function_d2c8356dc369d9ce( weapon_str ) ];
            items = arraycombine( items, add_items );
        }
    }
    
    return items;
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x163930fd, Offset: 0x2076
// Size: 0x80
function function_b4a3df7120dfdadf( id = self.objidnum )
{
    if ( level.roguesignalinfo.use_quest_circle && isdefined( self ) )
    {
        game_utility::questcircle_delete();
    }
    
    objidpoolmanager::returnobjectiveid( id );
    
    if ( level.usegulag )
    {
        level callback::remove( #"hash_c15c682d6a5dcae0", &on_player_enter_gulag );
        level callback::remove( #"br_player_respawn", &on_player_respawn );
    }
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0x36a8407f, Offset: 0x20fe
// Size: 0x105
function function_432710eed283053e( instance, player )
{
    if ( !instance.is_for_all && !arraycontains( instance.team_list, player.team ) )
    {
        playsoundatpos( instance.origin, "dx_br_smis_rspe_rfcv_rsct" );
        player hud_message::showerrormessage( "MP_BR_INGAME/UNAUTHORIZED_ACCESS" );
        return 0;
    }
    
    if ( !instance.is_unlocked )
    {
        playsoundatpos( instance.origin, "dx_br_smis_rspe_rfcv_rsct" );
        player hud_message::showerrormessage( "MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR" );
        return 0;
    }
    
    instance notify( #"opened" );
    instance function_b4a3df7120dfdadf();
    analytics_params = { #opened_by_winner:arraycontains( instance.team_list, player.team ), #time_since_spawn_ms:gettime() - instance.spawn_time };
    level thread function_a9894de62e025690( analytics_params );
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xff12ef02, Offset: 0x220b
// Size: 0x63
function function_5790d1aa26931c4f( player )
{
    if ( self.var_b316186fa10f3e2f > gettime() )
    {
        return;
    }
    
    self.var_b316186fa10f3e2f = gettime() + 3000;
    player hud_message::showerrormessage( "MP_BR_INGAME/UNAUTHORIZED_ACCESS" );
    
    if ( self.completion_rate >= 0.85 )
    {
        return;
    }
    
    playsoundatpos( self.origin, "dx_br_smis_rspe_rfcv_rsct" );
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0xfb48d3ca, Offset: 0x2276
// Size: 0x38
function function_d30a4f37efe934eb()
{
    level endon( #"event_deactivated" );
    level endon( #"hash_c92b3d8dc539800a" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 2;
        function_f00cc42bdb2fe085();
    }
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0xa8bcd731, Offset: 0x22b6
// Size: 0x2dc
function function_f00cc42bdb2fe085()
{
    level.roguesignalinfo.scoreboard = arraysort( level.roguesignalinfo.scoreboard, undefined, &sortbyscore );
    
    for ( i = 0; i < level.roguesignalinfo.scoreboard.size ; i++ )
    {
        foreach ( player in teams::getteamdata( level.roguesignalinfo.scoreboard[ i ].teamid, "players" ) )
        {
            player setclientomnvar( "ui_br_roguesignal_progress", level.roguesignalinfo.scoreboard[ i ].score );
            player setclientomnvar( "ui_br_roguesignal_position", i );
            
            if ( level.roguesignalinfo.scoreboard.size == 1 )
            {
                continue;
            }
            else if ( level.roguesignalinfo.scoreboard.size == 2 )
            {
                player setclientomnvar( "ui_br_roguesignal_progress_enemy1", level.roguesignalinfo.scoreboard[ i == 0 ? 1 : 0 ].score );
                continue;
            }
            
            if ( i == 0 )
            {
                player setclientomnvar( "ui_br_roguesignal_progress_enemy1", level.roguesignalinfo.scoreboard[ 1 ].score );
                player setclientomnvar( "ui_br_roguesignal_progress_enemy2", level.roguesignalinfo.scoreboard[ 2 ].score );
                continue;
            }
            
            if ( i == level.roguesignalinfo.scoreboard.size - 1 )
            {
                player setclientomnvar( "ui_br_roguesignal_progress_enemy1", level.roguesignalinfo.scoreboard[ i - 2 ].score );
                player setclientomnvar( "ui_br_roguesignal_progress_enemy2", level.roguesignalinfo.scoreboard[ i - 1 ].score );
                continue;
            }
            
            player setclientomnvar( "ui_br_roguesignal_progress_enemy1", level.roguesignalinfo.scoreboard[ i - 1 ].score );
            player setclientomnvar( "ui_br_roguesignal_progress_enemy2", level.roguesignalinfo.scoreboard[ i + 1 ].score );
        }
    }
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0xab63f4e2, Offset: 0x259a
// Size: 0x2c, Type: bool
function sortbyscore( lhs, rhs )
{
    return lhs.score >= rhs.score;
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x5f9feb0d, Offset: 0x25cf
// Size: 0x55
function on_plunder_pickup( params )
{
    if ( self.team == params.spawningteam )
    {
        return;
    }
    
    amount = ( params.amount ?? 0 ) * 10;
    function_7ceebb35c0da1c20( self.team, amount );
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x2bf73e85, Offset: 0x262c
// Size: 0x3c
function on_player_killed( deathdata )
{
    if ( function_a195c1defda4238( deathdata ) )
    {
        function_7ceebb35c0da1c20( deathdata.attacker.team, 1 );
        function_f00cc42bdb2fe085();
    }
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xa0479bba, Offset: 0x2670
// Size: 0xbf
function on_player_damaged( damagedata )
{
    if ( function_a195c1defda4238( damagedata ) )
    {
        total_damage = damagedata.idamage + damagedata.lightarmordamage;
        
        if ( isdefined( damagedata.smeansofdeath ) && ( damagedata.smeansofdeath == "MOD_EXECUTION" || damagedata.smeansofdeath == "MOD_MELEE_TAKEDOWN" ) )
        {
            victim = damagedata.victim;
            total_damage = victim.maxarmorhealth + victim.maxhealth;
        }
        
        function_7ceebb35c0da1c20( damagedata.eattacker.team, total_damage );
    }
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xa0c0ae82, Offset: 0x2737
// Size: 0xc7
function on_cache_opened( cachedata )
{
    score = 1;
    
    switch ( cachedata.cacheinstance.type )
    {
        case #"hash_417c605750c7baa5":
            score = 1;
            break;
        case #"hash_4ca1dc2e1b0de0d3":
            score = 2;
            break;
        case #"hash_19ba8d41970911ad":
            score = 3;
            break;
        default:
            /#
                iprintln( "<dev string:xe5>" + cachedata.instance.type );
            #/
            
            break;
    }
    
    function_7ceebb35c0da1c20( cachedata.player.team, score );
    function_f00cc42bdb2fe085();
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x823ebf0f, Offset: 0x2806
// Size: 0x31
function on_player_powerup( params )
{
    function_7ceebb35c0da1c20( params.player.team, 1 );
    function_f00cc42bdb2fe085();
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xad1ef1, Offset: 0x283f
// Size: 0x39
function on_squad_eliminated( params )
{
    function_7ceebb35c0da1c20( params.team, function_9aca9e879e4b5881( params.team ) * -1 );
    function_f00cc42bdb2fe085();
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x62a2eee, Offset: 0x2880
// Size: 0x8a
function on_player_enter_gulag( params )
{
    if ( !isdefined( level.roguesignalinfo.cache ) )
    {
        return;
    }
    
    player = params.player;
    cache = level.roguesignalinfo.cache;
    
    if ( arraycontains( cache.team_list, player.team ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( cache.objidnum, player );
    }
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x81e1dde2, Offset: 0x2912
// Size: 0x8a
function on_player_respawn( params )
{
    if ( !isdefined( level.roguesignalinfo.cache ) )
    {
        return;
    }
    
    player = params.player;
    cache = level.roguesignalinfo.cache;
    
    if ( arraycontains( cache.team_list, player.team ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( cache.objidnum, player );
    }
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0xdf0a16, Offset: 0x29a4
// Size: 0x110
function function_7ceebb35c0da1c20( teamid, delta )
{
    foreach ( entry in level.roguesignalinfo.scoreboard )
    {
        if ( entry.teamid == teamid )
        {
            entry.score += delta;
            return;
        }
    }
    
    newteamentry = spawnstruct();
    newteamentry.teamid = teamid;
    newteamentry.score = delta;
    level.roguesignalinfo.scoreboard[ level.roguesignalinfo.scoreboard.size ] = newteamentry;
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x5adc52c2, Offset: 0x2abc
// Size: 0xa4
function function_9aca9e879e4b5881( teamid )
{
    foreach ( entry in level.roguesignalinfo.scoreboard )
    {
        if ( entry.teamid == teamid )
        {
            return entry.score;
        }
    }
    
    return 0;
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0xd715e078, Offset: 0x2b69
// Size: 0x24a, Type: bool
function function_a195c1defda4238( data )
{
    attacker = undefined;
    
    if ( isdefined( data.attacker ) )
    {
        attacker = data.attacker;
    }
    else if ( isdefined( data.eattacker ) )
    {
        attacker = data.eattacker;
    }
    
    if ( !( isdefined( attacker ) && isdefined( data.victim ) ) )
    {
        return false;
    }
    
    victim = data.victim;
    
    if ( attacker vehicle::is_vehicle() )
    {
        driver = vehicle_occupancy::get_driver( attacker );
        
        if ( isplayer( driver ) )
        {
            attacker = driver;
        }
        else if ( attacker.owners > 0 )
        {
            owners = function_5713d46873b29625( attacker.owners );
            
            if ( owners.size > 0 )
            {
                attacker = owners[ 0 ];
            }
        }
        
        if ( attacker vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::get_all_occupants( attacker, 0 );
            
            if ( isarray( occupants ) && occupants.size > 0 )
            {
                attacker = occupants[ getarraykeys( occupants )[ 0 ] ];
            }
        }
        
        if ( isdefined( data.attacker ) )
        {
            data.attacker = attacker;
        }
        else if ( isdefined( data.eattacker ) )
        {
            data.eattacker = attacker;
        }
        
        if ( level.roguesignalinfo.currenteventtype == 3 )
        {
            data.idamage = int( min( data.idamage, victim.maxhealth ) );
        }
    }
    
    if ( level.roguesignalinfo.currenteventtype == 3 && data.idamage + data.lightarmordamage == 0 )
    {
        return false;
    }
    
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return false;
    }
    
    if ( attacker == victim )
    {
        return false;
    }
    
    if ( attacker.team == victim.team )
    {
        return false;
    }
    
    if ( level.roguesignalinfo.currenteventtype == 3 && player::isinlaststand( victim ) && !player::function_1e7ee0fc7e70248( victim ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_roguesignal
// Params 1, eflags: 0x4
// Checksum 0x7bd6d19c, Offset: 0x2dbc
// Size: 0x112
function private ftue_play( index )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    switch ( index )
    {
        case 1:
            tip = #"roguesignal_plunder";
            break;
        case 3:
            tip = #"roguesignal_damage";
            break;
        case 2:
            tip = #"roguesignal_kills";
            break;
        case 4:
            tip = #"roguesignal_looting";
            break;
        case 5:
            tip = #"roguesignal_powerups";
            break;
        default:
            assertmsg( "<dev string:x101>" + index );
            return;
    }
    
    ftue_tip::function_c9cca7ed21647155( tip );
    wait 10;
    params = { #duration:10 };
    ftue_tip::function_84dafc5c5a3f97ff( tip, 1, params );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace br_publicevent_roguesignal
// Params 1
// Checksum 0x47b629d7, Offset: 0x2ed6
// Size: 0x51
function function_a9894de62e025690( params )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "time_since_spawn_ms";
    eventparams[ eventparams.size ] = params.time_since_spawn_ms;
    eventparams[ eventparams.size ] = "opened_by_winner";
    eventparams[ eventparams.size ] = params.opened_by_winner;
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x9111e5aa, Offset: 0x2f2f
// Size: 0xac
function analytics_on_complete()
{
    top_scores = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        if ( isdefined( level.roguesignalinfo.scoreboard[ i ] ) )
        {
            top_scores[ top_scores.size ] = level.roguesignalinfo.scoreboard[ i ].score;
            continue;
        }
        
        top_scores[ top_scores.size ] = 0;
    }
    
    eventparams = [ "event_type", level.roguesignalinfo.currenteventtype, "top_scores", top_scores ];
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0x75bdd6fd, Offset: 0x2fe3
// Size: 0x189
function register_dialog()
{
    assert( isdefined( game[ "<dev string:x11f>" ] ) );
    game[ "dialog" ][ "rogue_signal_" + "event_starting" ] = "rspe_wzan_rses";
    game[ "dialog" ][ "rogue_signal_" + "event_type_kills" ] = "rspe_wzan_rsek";
    game[ "dialog" ][ "rogue_signal_" + "event_type_damage" ] = "rspe_wzan_rsed";
    game[ "dialog" ][ "rogue_signal_" + "event_type_caches" ] = "rspe_wzan_rset";
    game[ "dialog" ][ "rogue_signal_" + "event_type_powerups" ] = "rspe_wzan_rsep";
    game[ "dialog" ][ "rogue_signal_" + "event_type_cash" ] = "rspe_wzan_rsec";
    game[ "dialog" ][ "rogue_signal_" + "event_completion_top_squad" ] = "rspe_wzan_sect";
    game[ "dialog" ][ "rogue_signal_" + "event_completion_top_three" ] = "rspe_wzan_resq";
    game[ "dialog" ][ "rogue_signal_" + "event_failure" ] = "rspe_wzan_rsef";
    game[ "dialog" ][ "rogue_signal_" + "timer_nag_lead" ] = "rspe_wzan_rstn";
    game[ "dialog" ][ "rogue_signal_" + "timer_nag_top" ] = "rspe_wzan_rstg";
    game[ "dialog" ][ "rogue_signal_" + "performance_nag" ] = "rspe_wzan_rspn";
    game[ "dialog" ][ "rogue_signal_" + "crate_claim_friendly" ] = "rspe_wzan_rscs";
    game[ "dialog" ][ "rogue_signal_" + "crate_claim_enemy" ] = "rspe_wzan_rsce";
    game[ "dialog" ][ "rogue_signal_" + "crate_claim_gas" ] = "rspe_wzan_rscg";
}

// Namespace br_publicevent_roguesignal
// Params 0
// Checksum 0xc8670b2b, Offset: 0x3174
// Size: 0x120
function function_6959120a2cbf0b80()
{
    level endon( #"event_deactivated" );
    level endon( #"game_ended" );
    
    if ( level.roguesignalinfo.eventlength > 45 )
    {
        timer_reminder = level.roguesignalinfo.eventlength - 45;
        wait timer_reminder;
        
        for ( i = 0; i < level.roguesignalinfo.scoreboard.size ; i++ )
        {
            entry = level.roguesignalinfo.scoreboard[ i ];
            team = entry.teamid;
            score = entry.score;
            dialog = "performance_nag";
            
            if ( i < 3 && score > 0 )
            {
                dialog = i == 0 ? "timer_nag_lead" : "timer_nag_top";
            }
            
            br_public::brleaderdialogteam( "rogue_signal_" + dialog, team, 1, 0.5, undefined, "dx_br_smis_" );
        }
    }
}

// Namespace br_publicevent_roguesignal
// Params 2
// Checksum 0x5f6eb038, Offset: 0x329c
// Size: 0x1a3
function function_138bfe45c5a41bbb( type, player )
{
    if ( isdefined( player ) && type == "opened" )
    {
        if ( arraycontains( self.team_list, player.team ) )
        {
            br_public::brleaderdialogteam( "rogue_signal_" + "crate_claim_friendly", player.team, 1, 0.5, undefined, "dx_br_smis_" );
        }
        
        foreach ( team in self.team_list )
        {
            if ( team != player.team )
            {
                br_public::brleaderdialogteam( "rogue_signal_" + "crate_claim_enemy", team, 1, 0.5, undefined, "dx_br_smis_" );
            }
        }
        
        return;
    }
    
    if ( type == "gas" )
    {
        foreach ( team in self.team_list )
        {
            br_public::brleaderdialogteam( "rogue_signal_" + "crate_claim_gas", team, 1, 0.5, undefined, "dx_br_smis_" );
        }
    }
}

/#

    // Namespace br_publicevent_roguesignal
    // Params 0
    // Checksum 0xbdd4508b, Offset: 0x3447
    // Size: 0xd, Type: dev
    function initdebug()
    {
        level thread setup_devgui();
    }

    // Namespace br_publicevent_roguesignal
    // Params 0
    // Checksum 0x98f6b033, Offset: 0x345c
    // Size: 0x178, Type: dev
    function setup_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x126>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x145>", "<dev string:x158>", &function_a3b1a92a836b9dba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x163>", "<dev string:x177>", &function_a3b1a92a836b9dba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x182>", "<dev string:x197>", &function_a3b1a92a836b9dba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a2>", "<dev string:x1b7>", &function_a3b1a92a836b9dba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1c2>", "<dev string:x1d9>", &function_a3b1a92a836b9dba );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e4>", "<dev string:x1ee>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f7>", "<dev string:x209>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x212>", "<dev string:x228>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x231>", "<dev string:x24b>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x254>", "<dev string:x26c>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x275>", "<dev string:x291>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x29a>", "<dev string:x2b9>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2c2>", "<dev string:x2d9>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e2>", "<dev string:x2f5>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fe>", "<dev string:x314>", &function_f40711239a29adb9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x31d>", "<dev string:x32f>", &function_f40711239a29adb9 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_roguesignal
    // Params 1
    // Checksum 0xe992ffef, Offset: 0x35dc
    // Size: 0x3b, Type: dev
    function function_a3b1a92a836b9dba( params )
    {
        level.roguesignalinfo.overrideeventtype = int( params[ 0 ] );
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"roguesignal" );
    }

    // Namespace br_publicevent_roguesignal
    // Params 1
    // Checksum 0x22031d83, Offset: 0x361f
    // Size: 0x277, Type: dev
    function function_f40711239a29adb9( params )
    {
        player = level.player;
        
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                level thread br_publicevents::function_a1af4e372c2ecc3( %"roguesignal" );
                break;
            case 1:
                function_e1d2c1827615e8f1( player );
                break;
            case 2:
                tracestart = player geteye();
                forward = anglestoforward( player getplayerangles() );
                traceend = tracestart + forward * 5000;
                traceresults = trace::ray_trace( tracestart, traceend, player );
                
                if ( isdefined( traceresults[ "<dev string:x339>" ] ) && isplayer( traceresults[ "<dev string:x339>" ] ) && isbot( traceresults[ "<dev string:x339>" ] ) )
                {
                    player = traceresults[ "<dev string:x339>" ];
                    function_e1d2c1827615e8f1( player );
                }
                
                break;
            case 3:
                function_7ceebb35c0da1c20( player.team, 100000 );
                level thread br_publicevents::function_a1af4e372c2ecc3( %"roguesignal" );
                break;
            case 4:
                function_7ceebb35c0da1c20( "<dev string:x340>", 100000 );
                level thread br_publicevents::function_a1af4e372c2ecc3( %"roguesignal" );
                break;
            case 5:
                cache = spawn_reward_cache( [ player.team ], 0 );
                player setorigin( cache.origin + ( 0, 0, 24 ) );
                break;
            case 6:
                cache = spawn_reward_cache( [ "<dev string:x340>" ], 1 );
                player setorigin( cache.origin + ( 0, 0, 24 ) );
                break;
            case 7:
                level thread function_2adad0c7b7b5d055();
                break;
            case 8:
                player hud_message::showsplash( "<dev string:x345>", undefined, undefined, undefined, undefined, "<dev string:x35c>" );
                break;
            case 9:
                player hud_message::showsplash( "<dev string:x37a>", undefined, undefined, undefined, undefined, "<dev string:x35c>" );
                break;
            case 10:
                player function_3ba6355088da38dc();
                break;
        }
    }

    // Namespace br_publicevent_roguesignal
    // Params 1
    // Checksum 0xcb68d6b4, Offset: 0x389e
    // Size: 0xc1, Type: dev
    function function_e1d2c1827615e8f1( player )
    {
        switch ( level.roguesignalinfo.currenteventtype )
        {
            case 1:
                function_7ceebb35c0da1c20( player.team, 750 );
                function_f00cc42bdb2fe085();
                break;
            case 3:
                function_7ceebb35c0da1c20( player.team, 150 );
                function_f00cc42bdb2fe085();
                break;
            case 2:
            case 4:
            case 5:
                function_7ceebb35c0da1c20( player.team, 1 );
                function_f00cc42bdb2fe085();
                break;
        }
    }

    // Namespace br_publicevent_roguesignal
    // Params 0
    // Checksum 0x1f33a4d0, Offset: 0x3967
    // Size: 0xe4, Type: dev
    function function_2adad0c7b7b5d055()
    {
        level notify( "<dev string:x394>" );
        level endon( "<dev string:x394>" );
        caches = getunusedlootcachepoints( br_circle::getnextsafecircleorigin(), br_circle::getnextsafecircleradius(), 0, 1 );
        
        if ( !isdefined( caches ) )
        {
            return;
        }
        
        foreach ( cache in caches )
        {
            debug::line( cache.origin, cache.origin + ( 0, 0, 4096 ), ( 0, 1, 1 ), 30, "<dev string:x394>", undefined, undefined );
        }
    }

    // Namespace br_publicevent_roguesignal
    // Params 0
    // Checksum 0xf574b8f0, Offset: 0x3a53
    // Size: 0x43, Type: dev
    function function_3ba6355088da38dc()
    {
        angles = self getplayerangles();
        forward = anglestoforward( angles );
        common_cache::function_9bc018c1b8aad720( "<dev string:x3d6>", self.origin + forward * 100, angles );
    }

#/
