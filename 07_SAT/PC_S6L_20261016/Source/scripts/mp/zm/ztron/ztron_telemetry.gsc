// scripts\mp\zm\ztron\ztron_telemetry.gsc  (hash_547ba35b29c2bc7f.gscc) (size: 11589 Bytes / 0x2d45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7511f0a6 (1964109990)
// size ...... 11589 (0x2d45)
// includes .. 10  (offset: 0x28f5)
// strings ... 64  (offset: 0x2945)
// dev strs .. 0   (offset: 0x2d45)
// exports ... 27  (offset: 0x1dad)
// cseg ...... 0x522 + 0x188b (0x1dad)
// imports ... 57  (offset: 0x21e5)
// animtree1 . 0   (offset: 0x2d45)
// animtree2 . 0   (offset: 0x2d45)
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\challenges\zombie_challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\matchdata;
#using scripts\mp\playerstats_interface;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_telemetry;

// Namespace ztron_telemetry
// Params 0
// Checksum 0xf9f245d7, Offset: 0x540
// Size: 0x4c
function init()
{
    if ( level.ztron.cabinetmode )
    {
        return;
    }
    
    level thread watchround();
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_spawned", &function_f774062afd4d4906 );
    level callback::add( "player_match_end", &function_ec69210ff289630e );
    level thread telemetry_post_init();
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0xf3906bb7, Offset: 0x594
// Size: 0xe5
function telemetry_post_init()
{
    level endon( #"ztron_game_is_over" );
    
    while ( !level utility::flag( "zm_challenges_initialized" ) )
    {
        wait 0.5;
    }
    
    callback::remove( #"on_ai_killed", &namespace_b645faa035c740a7::function_4dbc0f4c240c401e );
    callback::remove( #"player_item_pickup", &namespace_b645faa035c740a7::report_on_item_pickup );
    callback::remove( "on_zombie_ai_spawned", &namespace_b645faa035c740a7::on_zombie_ai_spawned );
    callback::remove( "on_rapid_kill_counted", &namespace_b645faa035c740a7::function_c67ef634ef9b96d3 );
    callback::remove( "on_soldier_ai_damaged", &namespace_b645faa035c740a7::function_b5178a27f638123b );
    callback::remove( "on_zombie_ai_damaged", &namespace_b645faa035c740a7::function_b5178a27f638123b );
    callback::remove( #"player_damaged", &namespace_b645faa035c740a7::on_player_damaged );
    callback::remove( #"player_laststand", &namespace_b645faa035c740a7::function_3a1defe7d6d76819 );
    callback::remove( #"player_connect", &namespace_b645faa035c740a7::on_player_connect );
    callback::remove( "on_player_augment_given", &namespace_b645faa035c740a7::on_player_augment_given );
}

// Namespace ztron_telemetry
// Params 0, eflags: 0xc
// Checksum 0x4460449e, Offset: 0x681
// Size: 0x14c
function private watchround()
{
    self notify( #"hash_b1302f84aafbefaf" );
    self endon( #"hash_b1302f84aafbefaf" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        result = level utility::waittill_any_return( "ztron_round_over", "round_begin", "bonus_room_ready", "deactivate_bonus_room", "slayer_arena_activated", "slayer_round_finished" );
        
        foreach ( player in level.players )
        {
            if ( player ztron_player_utility::function_9abc64ef2cb9cbd() )
            {
                if ( result == "round_begin" || result == "bonus_room_ready" || result == "slayer_arena_activated" )
                {
                    player function_a5ce47a61cb47463();
                    continue;
                }
                
                if ( result == "ztron_round_over" || result == "deactivate_bonus_room" || result == "slayer_round_finished" )
                {
                    if ( result == "ztron_round_over" )
                    {
                        player callback::callback( "gobble_gum_on_round_end" );
                    }
                    
                    player function_eae07ebe937b2aa4();
                }
            }
        }
    }
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x3d804d8a, Offset: 0x7d5
// Size: 0xac
function private inittelemetry()
{
    if ( !isdefined( self.pers[ "telemetry" ] ) )
    {
        self.pers[ "telemetry" ] = {};
    }
    
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.roundcompleted ) )
    {
        telemetry.roundcompleted = 0;
    }
    
    if ( !isdefined( telemetry.gems_earned ) )
    {
        telemetry.gems_earned = 0;
    }
    
    if ( !isdefined( telemetry.coins_earned ) )
    {
        telemetry.coins_earned = 0;
    }
    
    if ( !isdefined( telemetry.silverback_eliminations ) )
    {
        telemetry.silverback_eliminations = 0;
    }
}

// Namespace ztron_telemetry
// Params 1, eflags: 0x4
// Checksum 0xd6b79b0e, Offset: 0x889
// Size: 0x3c
function private function_f774062afd4d4906( player )
{
    player endon( #"disconnect" );
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    level utility::flag_wait( "begin_ztron_logic" );
    player inittelemetry();
}

// Namespace ztron_telemetry
// Params 1
// Checksum 0xe097f581, Offset: 0x8cd
// Size: 0x65
function pickupgem( gems = 1 )
{
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.gems_earned ) )
    {
        telemetry.gems_earned = 0;
    }
    
    telemetry.gems_earned += gems;
}

// Namespace ztron_telemetry
// Params 1
// Checksum 0xa151187e, Offset: 0x93a
// Size: 0x65
function pickupcoin( coins = 1 )
{
    telemetry = self.pers[ "telemetry" ];
    
    if ( !isdefined( telemetry.coins_earned ) )
    {
        telemetry.coins_earned = 0;
    }
    
    telemetry.coins_earned += coins;
}

// Namespace ztron_telemetry
// Params 1
// Checksum 0xbc8f596e, Offset: 0x9a7
// Size: 0x175
function itempickedup( player )
{
    if ( player ztron_player_utility::function_9abc64ef2cb9cbd() )
    {
        itemdata = level.ztron.itemdef.itemdata[ self.var_8593f17418a81b6e ];
        
        if ( isdefined( itemdata.category ) && itemdata.category != "treasure" )
        {
            commonstats = player function_8cdffbbc7e34dff4();
            item_ref = itemdata.ref;
            item_category = itemdata.category;
            zone_name = function_a89782c1926824ba();
            params = [ "zone_name", zone_name, "item_ref", item_ref, "item_category", item_category ];
            
            foreach ( k, v in commonstats )
            {
                params[ params.size ] = k;
                params[ params.size ] = v;
            }
            
            player dlog_recordplayerevent( "dlog_event_ztron_player_item_pickup", params );
        }
    }
}

// Namespace ztron_telemetry
// Params 2
// Checksum 0x605db8ce, Offset: 0xb24
// Size: 0x160
function itempurchase( item, cost )
{
    if ( ztron_player_utility::function_9abc64ef2cb9cbd() )
    {
        if ( item.itemref )
        {
            commonstats = function_8cdffbbc7e34dff4();
            item_ref = item.itemref;
            item_category = item.category;
            zone_name = function_a89782c1926824ba();
            cash = ztron_player_utility::function_da0857c472c9dc5e();
            params = [ "zone_name", zone_name, "item_ref", item_ref, "item_category", item_category, "cash", cash, "cost", cost ];
            
            foreach ( k, v in commonstats )
            {
                params[ params.size ] = k;
                params[ params.size ] = v;
            }
            
            self dlog_recordplayerevent( "dlog_event_ztron_player_purchase", params );
        }
    }
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x2e2912e8, Offset: 0xc8c
// Size: 0x83
function private function_36ba7d4c593d252b()
{
    if ( level.ztron.blitzmode )
    {
        return 5;
    }
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        if ( getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 )
        {
            return 4;
        }
        
        return 3;
    }
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return 2;
    }
    
    if ( getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x3e04d7c, Offset: 0xd17
// Size: 0x65
function private function_a6aea2432416eb30()
{
    var_26f130d59db084d7 = ztron_main::function_4da200e9b8d58a3c();
    
    if ( var_26f130d59db084d7 == 5 )
    {
        return "slayer";
    }
    
    if ( var_26f130d59db084d7 == 3 )
    {
        return "bonus_room";
    }
    
    if ( level.ztron.activechallenge )
    {
        return ( "challenge_" + level.ztron.activechallenge );
    }
    
    return "arena";
}

// Namespace ztron_telemetry
// Params 1
// Checksum 0xc8e72113, Offset: 0xd85
// Size: 0xa7
function function_7458ce8ed1b1205c( var_5113c2cc9cba8b82 )
{
    if ( !isdefined( self.pers[ "telemetry" ] ) )
    {
        self.pers[ "telemetry" ] = {};
    }
    
    telemetry = self.pers[ "telemetry" ];
    telemetry.saveddata = var_5113c2cc9cba8b82.telemetry;
    
    if ( !isdefined( telemetry.var_efd960f3c3cf6f19 ) )
    {
        telemetry.var_efd960f3c3cf6f19 = {};
    }
    
    telemetry.var_efd960f3c3cf6f19.prev_time_played = telemetry.saveddata.timeplayed;
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0x71d2a1be, Offset: 0xe34
// Size: 0x93
function function_46543842b0ef2739()
{
    commonstats = function_8cdffbbc7e34dff4();
    playerstats = function_357d643daa9d1ba0();
    saveddata = spawnstruct();
    saveddata.timeplayed = playerstats[ "time_played" ];
    saveddata.gemsEarned = playerstats[ "gems_earned" ];
    saveddata.coinsEarned = playerstats[ "coins_earned" ];
    saveddata.silverbackEliminations = playerstats[ "silverback_eliminations" ];
    saveddata.var_f745ee6944b463f2 = commonstats[ "initial_match_id" ];
    return saveddata;
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x1480ff19, Offset: 0xed0
// Size: 0x27, Type: bool
function private function_9aa52cc0f736ef79()
{
    return level.ztron.active_arena.name ?? "unknown";
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x2273f10b, Offset: 0xf00
// Size: 0xbf
function private function_a89782c1926824ba()
{
    zonename = "arena_" + function_9aa52cc0f736ef79();
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369.name ) )
    {
        zonename = "event_" + level.ztron.var_8a9067aa4cd65369.name;
    }
    else if ( isdefined( level.ztron.slayer.active_arena.name ) )
    {
        zonename = "slayer_" + level.ztron.slayer.active_arena.name;
    }
    
    return zonename;
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x5c532b89, Offset: 0xfc8
// Size: 0x18c
function private function_8cdffbbc7e34dff4()
{
    if ( !isdefined( self.pers[ "telemetry" ] ) )
    {
        self.pers[ "telemetry" ] = {};
    }
    
    telemetry = self.pers[ "telemetry" ];
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    ztron_type = function_36ba7d4c593d252b();
    reload_flag = isdefined( telemetry.saveddata );
    round_number = level.ztron.roundnumber;
    var_b3bfbfee5a13278 = level.ztron.var_b3bfbfee5a13278 ?? level.players.size;
    is_solo_match = ztron_util::function_5ba0edd1761596a2() || var_b3bfbfee5a13278 == 1;
    initial_match_id = getonlinematchid();
    
    if ( reload_flag )
    {
        saveddata = telemetry.saveddata;
        initial_match_id = saveddata.var_f745ee6944b463f2 ?? initial_match_id;
    }
    
    commonstats = [];
    commonstats[ "playlist_id" ] = playlist_id;
    commonstats[ "playlist_name" ] = playlist_name;
    commonstats[ "ztron_type" ] = ztron_type;
    commonstats[ "reload_flag" ] = reload_flag;
    commonstats[ "round_number" ] = round_number;
    commonstats[ "is_solo_match" ] = is_solo_match;
    commonstats[ "initial_match_id" ] = initial_match_id;
    commonstats[ "locked_team_size" ] = var_b3bfbfee5a13278;
    return commonstats;
}

// Namespace ztron_telemetry
// Params 0, eflags: 0x4
// Checksum 0x38986e6, Offset: 0x115d
// Size: 0x2cf
function private function_357d643daa9d1ba0()
{
    if ( !isdefined( self.pers[ "telemetry" ] ) )
    {
        self.pers[ "telemetry" ] = {};
    }
    
    telemetry = self.pers[ "telemetry" ];
    time_played = matchdata::gettimefrommatchstart( gettime() );
    time_played = int( clamp( time_played, 0, 2147483647 ) / 1000 );
    eliminations = self.ztron.score.kills ?? 0;
    gems_earned = telemetry.gems_earned ?? 0;
    coins_earned = telemetry.coins_earned ?? 0;
    score = int( max( self.ztron.score.points ?? 0, self.ztron.score.desired_points ?? 0 ) );
    silverback_eliminations = telemetry.silverback_eliminations ?? 0;
    deaths = self.pers[ "deaths" ] ?? 0;
    reload_flag = isdefined( telemetry.saveddata );
    
    if ( reload_flag )
    {
        saveddata = telemetry.saveddata;
        time_played += saveddata.timeplayed;
        gems_earned += saveddata.gemsEarned;
        coins_earned += saveddata.coinsEarned;
        silverback_eliminations += saveddata.silverbackEliminations;
    }
    
    playerstats = [];
    playerstats[ "time_played" ] = time_played;
    playerstats[ "eliminations" ] = eliminations;
    playerstats[ "gems_earned" ] = gems_earned;
    playerstats[ "coins_earned" ] = coins_earned;
    playerstats[ "score" ] = score;
    playerstats[ "silverback_eliminations" ] = silverback_eliminations;
    playerstats[ "deaths" ] = deaths;
    
    if ( level.ztron.blitzmode )
    {
        var_157e208e8005c0a4 = 0;
        
        if ( isdefined( self.ztron.blitzmode ) && isdefined( self.ztron.blitzmode.breakdown ) )
        {
            var_157e208e8005c0a4 = self.ztron.blitzmode.breakdown.var_30e0e22993cf04e7;
        }
        
        playerstats[ "blitz_final_time_ms" ] = var_157e208e8005c0a4;
        playerstats[ "blitz_mode_success" ] = self.ztron.blitzmode.breakdown.success;
    }
    
    return playerstats;
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0xee3cc8a1, Offset: 0x1435
// Size: 0x1a6
function function_a5ce47a61cb47463()
{
    if ( !telemetry_utils::is_valid_client( self ) )
    {
        return;
    }
    
    commonstats = function_8cdffbbc7e34dff4();
    var_3352915a415800e1 = function_357d643daa9d1ba0();
    telemetry = self.pers[ "telemetry" ];
    telemetry.roundcompleted = level.ztron.roundnumber;
    telemetry.var_3352915a415800e1 = var_3352915a415800e1;
    zone_name = function_a89782c1926824ba();
    challenge_name = function_a6aea2432416eb30();
    params = [ "zone_name", zone_name, "challenge_name", challenge_name ];
    
    foreach ( k, v in commonstats )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    foreach ( k, v in var_3352915a415800e1 )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    self dlog_recordplayerevent( "dlog_event_ztron_player_round_start", params );
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0x49ae02d3, Offset: 0x15e3
// Size: 0x213
function function_eae07ebe937b2aa4()
{
    if ( !telemetry_utils::is_valid_client( self ) )
    {
        return;
    }
    
    commonstats = function_8cdffbbc7e34dff4();
    roundendstats = function_357d643daa9d1ba0();
    telemetry = self.pers[ "telemetry" ];
    telemetry.roundcompleted = level.ztron.roundnumber;
    var_5f5b05fc8128e8e0 = [];
    
    foreach ( k, v in roundendstats )
    {
        var_5f5b05fc8128e8e0[ k ] = v - ( telemetry.var_3352915a415800e1[ k ] ?? 0 );
    }
    
    zone_name = function_a89782c1926824ba();
    challenge_name = function_a6aea2432416eb30();
    params = [ "zone_name", zone_name, "challenge_name", challenge_name ];
    
    foreach ( k, v in commonstats )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    foreach ( k, v in var_5f5b05fc8128e8e0 )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    self dlog_recordplayerevent( "dlog_event_ztron_player_round_end", params );
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0x62c7d972, Offset: 0x17fe
// Size: 0x1a0
function function_9442ee0d8c2c551c()
{
    if ( !telemetry_utils::is_valid_client( self ) )
    {
        return;
    }
    
    commonstats = function_8cdffbbc7e34dff4();
    playerstats = function_357d643daa9d1ba0();
    telemetry = self.pers[ "telemetry" ];
    
    if ( isdefined( telemetry.var_a754d9fa0b54559a ) )
    {
        return;
    }
    
    reached_match_end = telemetry.reached_match_end ?? 0;
    zone_name = function_a89782c1926824ba();
    params = [ "reached_match_end", reached_match_end, "zone_name", zone_name ];
    
    foreach ( k, v in commonstats )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    foreach ( k, v in playerstats )
    {
        params[ params.size ] = k;
        params[ params.size ] = v;
    }
    
    self dlog_recordplayerevent( "dlog_event_ztron_player_match_end", params );
    telemetry.var_a754d9fa0b54559a = 1;
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0x23090710, Offset: 0x19a6
// Size: 0x6f
function function_3af7980e4d4914d5()
{
    var_6ffcb5b60fe56a5c = playerstats_interface::getplayerstat( "ztronPlayerStats", "highestCurrencyEarned", undefined, undefined, undefined, "zm" );
    
    if ( ( self.ztron.var_71483ab64fc14eb4 ?? 0 ) > var_6ffcb5b60fe56a5c )
    {
        playerstats_interface::setplayerstat( self.ztron.var_71483ab64fc14eb4, "ztronPlayerStats", "highestCurrencyEarned", undefined, undefined, undefined, "zm" );
    }
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0xb0da0842, Offset: 0x1a1d
// Size: 0x83
function function_52edb271c9650b89()
{
    old_highestscore = playerstats_interface::getplayerstat( "ztronPlayerStats", "highestScore", undefined, undefined, undefined, "zm" );
    
    if ( ( self.ztron.score.desired_points ?? 0 ) > old_highestscore )
    {
        playerstats_interface::setplayerstat( self.ztron.score.desired_points, "ztronPlayerStats", "highestScore", undefined, undefined, undefined, "zm" );
    }
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0x2d60d751, Offset: 0x1aa8
// Size: 0x130
function updatestats()
{
    old_highestround = playerstats_interface::getplayerstat( "ztronPlayerStats", "highestRound", undefined, undefined, undefined, "zm" );
    
    if ( level.ztron.roundnumber > old_highestround )
    {
        playerstats_interface::setplayerstat( level.ztron.roundnumber, "ztronPlayerStats", "highestRound", undefined, undefined, undefined, "zm" );
    }
    
    var_8b53ebc6ca15ade9 = !level.ztron.var_95d8c7a469393957 && !level.ztron.var_371903e5801e0e08;
    
    if ( var_8b53ebc6ca15ade9 )
    {
        old_highestround = playerstats_interface::getplayerstat( "ztronPlayerStats", "standModeHighestRound", undefined, undefined, undefined, "zm" );
        
        if ( level.ztron.roundnumber > old_highestround )
        {
            playerstats_interface::setplayerstat( level.ztron.roundnumber, "ztronPlayerStats", "standModeHighestRound", undefined, undefined, undefined, "zm" );
        }
    }
    
    function_3af7980e4d4914d5();
    function_52edb271c9650b89();
    
    if ( level.ztron.blitzmode )
    {
        function_ae729132259b12d();
    }
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0xd8ba5604, Offset: 0x1be0
// Size: 0x72
function function_4d149c1493a48f12()
{
    old_highestround = playerstats_interface::getplayerstat( "ztronPlayerStats", "advancedSoloHighestRound", undefined, undefined, undefined, "zm" );
    
    if ( level.ztron.roundnumber > old_highestround )
    {
        playerstats_interface::setplayerstat( level.ztron.roundnumber, "ztronPlayerStats", "advancedSoloHighestRound", undefined, undefined, undefined, "zm" );
    }
    
    function_3af7980e4d4914d5();
}

// Namespace ztron_telemetry
// Params 0
// Checksum 0xc464dff5, Offset: 0x1c5a
// Size: 0xe9
function function_ae729132259b12d()
{
    if ( !isdefined( self.ztron.blitzmode ) || !isdefined( self.ztron.blitzmode.breakdown ) || !self.ztron.blitzmode.breakdown.success )
    {
        return;
    }
    
    var_30e0e22993cf04e7 = self.ztron.blitzmode.breakdown.var_30e0e22993cf04e7;
    old_besttime = playerstats_interface::getplayerstat( "ztronPlayerStats", "blitzBestTime", undefined, undefined, undefined, "zm" );
    
    if ( old_besttime == 0 || var_30e0e22993cf04e7 < old_besttime )
    {
        playerstats_interface::setplayerstat( var_30e0e22993cf04e7, "ztronPlayerStats", "blitzBestTime", undefined, undefined, undefined, "zm" );
    }
}

// Namespace ztron_telemetry
// Params 1
// Checksum 0xa7079151, Offset: 0x1d4b
// Size: 0x62
function function_ec69210ff289630e( data )
{
    player = data.player;
    
    if ( player ztron_player_utility::function_9abc64ef2cb9cbd() )
    {
        player function_9442ee0d8c2c551c();
        player updatestats();
        return;
    }
    
    if ( level.ztron.advancedStart )
    {
        player function_4d149c1493a48f12();
    }
}

