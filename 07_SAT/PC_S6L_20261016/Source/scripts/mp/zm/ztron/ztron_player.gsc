// scripts\mp\zm\ztron\ztron_player.gsc  (hash_404639602411b94b.gscc) (size: 30387 Bytes / 0x76b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x185d7f05 (408780549)
// size ...... 30387 (0x76b3)
// includes .. 35  (offset: 0x6d0f)
// strings ... 138 (offset: 0x6e27)
// dev strs .. 15  (offset: 0x75fb)
// exports ... 62  (offset: 0x48ef)
// cseg ...... 0xb39 + 0x3db6 (0x48ef)
// imports ... 219 (offset: 0x529f)
// animtree1 . 0   (offset: 0x76b3)
// animtree2 . 0   (offset: 0x76b3)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\damage;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\matchdata;
#using scripts\mp\playerstats_interface;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_health_bar;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weapon;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_player;

// Namespace ztron_player
// Params 0
// Checksum 0x866638ae, Offset: 0xb57
// Size: 0x3b7
function init()
{
    level callback::add( #"player_connect", &onplayerconnect );
    level callback::add( #"player_spawned", &onplayerspawned );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    level callback::add( #"player_laststand", &onplayerlaststand );
    level callback::add( "onEnterVehicle", &onplayerentervehicle );
    level callback::add( "onExitVehicle", &function_97288f7c45162af2 );
    level callback::add( #"stance_changed_post", &function_1c41da54dd8820c0 );
    level callback::add( #"player_death", &onplayerdeath );
    ui::lui_registercallback( "versus_done", &function_cf19e94b24424278 );
    ui::lui_registercallback( "ztron_enable_crab_tutorial_update", &function_563416d80c6ff24c );
    ui::lui_registercallback( "ztron_enable_pickup_dialogue", &function_fb2c163041df7e1 );
    ui::lui_registercallback( "ztron_enable_text_bubble", &function_b151c4988a72eee );
    ui::lui_registercallback( "ztron_enable_alternative_field_upgrade_mapping", &function_5cce32fbd37324a9 );
    ui::lui_registercallback( "end_game", &function_f462e5f9238d0f94 );
    utility::registersharedfunc( #"damage", #"hash_b78ec0f2ad4cfbe1", &function_4fb500e9e444152a );
    utility::registersharedfunc( #"player", #"hash_9bc79685259c8dd2", &function_abb0ee7d4cad2339 );
    level.var_c998633bab11f3f8 = 1;
    
    if ( isdefined( level.ztron.playerdamagecb ) )
    {
        level.callbackplayerdamage = level.ztron.playerdamagecb;
    }
    
    level.var_a44ba6c01eac941 = &function_bea9caf67da14a3e;
    ztron_sound::function_4ac735395b173fe( "ztron_player_shield_start", "evt_ztron_player_shield_start" );
    ztron_sound::function_4ac735395b173fe( "ztron_player_shield_full", "evt_ztron_player_shield_full" );
    ztron_sound::function_4ac735395b173fe( "ztron_player_shield_half", "evt_ztron_player_shield_half" );
    ztron_sound::function_4ac735395b173fe( "ztron_player_shield_stop", "evt_ztron_player_shield_stop" );
    ztron_sound::function_4ac735395b173fe( "ztron_ragdoll_launched", "zmb_ragdoll_launched" );
    ztron_sound::function_4ac735395b173fe( "ztron_playerNovaPoisonedOS", "zmb_ragdoll_launched" );
    ztron_sound::function_4ac735395b173fe( "ztron_playerSpeedFeetOS", "zmb_ragdoll_launched" );
    ztron_sound::function_4ac735395b173fe( "ztron_player_death", "evt_ztron_player_death" );
    ztron_sound::function_4ac735395b173fe( "ztron_player_respawn", "evt_ztron_player_spawn" );
    ztron_sound::function_4ac735395b173fe( "ztron_shield_break_OS", "evt_ztron_player_armor_break" );
    ztron_sound::function_4ac735395b173fe( "hallelujah", "collinfixme" );
    disconnect_event_aggregator::function_11efe509aba577f7( &function_293f29891405519c );
    level.ztron.var_82559eefe1a83993 = [ "super_tesla_storm", "super_mary_paris", "super_energy_mine", "super_dark_flare", "super_aether_shroud", "super_frost_blast" ];
    level.ztron.superids = function_ec1db69b5bd19b83( level.ztron.var_82559eefe1a83993 );
    level.ztron.var_6c96caea03d7b13c = [];
    
    foreach ( super in level.ztron.superids )
    {
        level.ztron.var_6c96caea03d7b13c[ getxhash( super ) ] = super;
    }
    
    level.ztron.var_909f9ee392414e7 = [];
    level thread function_413ebd5b86bf447f();
    level.var_64b7737168df26be = createentitytypemask( [ "etype_ai" ] );
}

// Namespace ztron_player
// Params 1
// Checksum 0x9de0fbba, Offset: 0xf16
// Size: 0xa1
function function_ec1db69b5bd19b83( var_46e262622714cf85 )
{
    validarray = [];
    
    foreach ( superid in var_46e262622714cf85 )
    {
        superbundle = field_upgrades::function_1fcc83f10e7752e5( superid );
        
        if ( isdefined( superbundle ) )
        {
            validarray[ validarray.size ] = superid;
        }
    }
    
    return validarray;
}

// Namespace ztron_player
// Params 0
// Checksum 0x11b36e9f, Offset: 0xfc0
// Size: 0x244
function main()
{
    self notify( #"hash_c9f28906aab5cf02" );
    self endon( #"hash_c9f28906aab5cf02" );
    level endon( #"ztron_game_is_over" );
    level endon( #"ztron_game_reset" );
    level.var_14cf8f3dc7322363 = 0;
    level utility::flag_wait_all( "ztron_system_start" );
    
    while ( true )
    {
        waitframe();
        var_588a7d80c65d45f8 = gettime();
        aliveplayers = 0;
        
        foreach ( player in level.players )
        {
            player ztron_score::updatepoints();
            player ztron_weapon::function_bdc5e458b6cbf2bb();
            
            if ( player.birthtime + 500 > var_588a7d80c65d45f8 )
            {
                continue;
            }
            
            if ( ( !player.inlaststand || player.ztron.score.lives > 0 || player.ztron.var_c29d80b2517669ba || player.ztron.var_1978e4bc3fd889e7 ) && !player.ztron.dead )
            {
                aliveplayers++;
            }
            
            if ( !player.inlaststand )
            {
                player updateinput();
                player ztron_item::function_56cfc1fd654af986();
                player ztron_item::function_4ccc2a210994178c();
            }
        }
        
        docheck = 0;
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            docheck = 1;
        }
        else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
        {
            docheck = 0;
        }
        else if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
        {
            if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) && level.ztron.var_8a9067aa4cd65369.deathallowed )
            {
                docheck = 1;
            }
        }
        
        if ( aliveplayers == 0 && docheck )
        {
            level utility::flag_set( "ztron_all_players_dead" );
        }
    }
}

// Namespace ztron_player
// Params 0
// Checksum 0x28da82fa, Offset: 0x120c
// Size: 0x27
function function_413ebd5b86bf447f()
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"ztron_game_reset_completed" );
    rejoin_utility::function_70467cdf042579e5( &function_dd1fa62b48800adb );
}

// Namespace ztron_player
// Params 0
// Checksum 0x1fc90516, Offset: 0x123b
// Size: 0x1b
function function_4fb500e9e444152a()
{
    return ztron_camera::function_4963ef31446ec8d9( self.ztron.var_a46fa357ac82e4a );
}

// Namespace ztron_player
// Params 0
// Checksum 0xdec5704c, Offset: 0x125f
// Size: 0x158
function function_abb0ee7d4cad2339()
{
    currentpos = self.origin;
    
    if ( isdefined( self.ztron.vehicle ) )
    {
        currentpos = self.ztron.vehicle.origin;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 && isdefined( level.ztron.active_arena ) )
    {
        currentarena = level.ztron.arenas[ level.ztron.currentarena ];
        spot = currentarena ztron_arena::function_8c2aa5e7037af31c( currentpos );
        currentpos = spot.origin;
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 && isdefined( level.ztron.slayer.active_arena ) )
    {
        spot = level.ztron.slayer.active_arena.safespots[ randomint( level.ztron.slayer.active_arena.safespots.size ) ];
        currentpos = spot.origin;
    }
    
    return currentpos;
}

// Namespace ztron_player
// Params 1
// Checksum 0x93b481d7, Offset: 0x13c0
// Size: 0x4d
function function_eca1101cf19ba4d1( startorigin )
{
    self endon( #"disconnect" );
    
    while ( isalive( self ) )
    {
        if ( distance2d( startorigin, self.origin ) > 16 )
        {
            break;
        }
        
        wait 1;
    }
    
    self notify( #"player_moved_after_hot_join" );
}

// Namespace ztron_player
// Params 0
// Checksum 0x48edc492, Offset: 0x1415
// Size: 0x17, Type: bool
function function_791dcf0ce4bf51e7()
{
    if ( isbot( self ) )
    {
        return true;
    }
    
    return istrue( self.versusdone );
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x36a6ae29, Offset: 0x1435
// Size: 0x68
function private function_92dd64e788a3774e( time )
{
    self endon( #"disconnect" );
    timerms = time * 1000;
    start_time = gettime();
    
    while ( true )
    {
        if ( function_791dcf0ce4bf51e7() || gettime() >= start_time + timerms )
        {
            utility::ent_flag_set( "loading_screen_over" );
            break;
        }
        
        wait 1;
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x5d15eef1, Offset: 0x14a5
// Size: 0x4e
function private onplayerdisconnect( params )
{
    ztron_score::awardxp( self );
    
    if ( ztron_player_utility::function_baf22e7b5779b533( self ) )
    {
        level.ztron.var_909f9ee392414e7 = arrayremove( level.ztron.var_909f9ee392414e7, self getentitynumber() );
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0xb83c036b, Offset: 0x14fb
// Size: 0x2ea
function private onplayerconnect( params )
{
    self.var_3ed25ea600729b93 = 1;
    
    if ( !level.ztron.game_running && !level.var_40ae21600d471de7 )
    {
        level.var_40ae21600d471de7 = 1;
        
        if ( !isdefined( level.ztron.skipNextTeleportOnRoundStart ) )
        {
            level.ztron.skipNextTeleportOnRoundStart = 1;
        }
        
        self waittill( #"spawned_player" );
        val::set( "ztron_player", "freezecontrols", 1 );
        thread function_d2486f8c87b4c42c();
        thread function_92dd64e788a3774e( getdvarint( @"hash_57a4ee29a59a7d8b", 120 ) );
        utility::ent_flag_wait_or_timeout( "loading_screen_over", getdvarint( @"hash_57a4ee29a59a7d8b", 120 ) );
        
        if ( isdefined( self ) )
        {
            val::reset( "ztron_player", "freezecontrols" );
        }
        
        if ( isdefined( self ) && self issplitscreenplayer() )
        {
            var_1f0d6d55fe7c62ec = self getothersplitscreenplayer();
            
            if ( isdefined( var_1f0d6d55fe7c62ec ) )
            {
                var_1f0d6d55fe7c62ec val::reset( "ztron_player", "ignoreme" );
            }
        }
        
        level zm_save::function_1f44a48caae2acbf();
        utility::flag_set( "begin_ztron_logic" );
    }
    else
    {
        self waittill( #"spawned_player" );
        thread function_d2486f8c87b4c42c();
        thread function_eca1101cf19ba4d1( self.origin );
        thread function_92dd64e788a3774e( getdvarint( @"hash_57a4ee29a59a7d8b", 120 ) );
        val::set( "ztron_player", "ignoreme", 1 );
        waitarray = [ "melee_swipe_start", "weapon_fired", "offhand_fired", "special_weapon_fired", "jump", "player_moved_after_hot_join", "loading_screen_over" ];
        utility::waittill_any_in_array_or_timeout( waitarray, 180 );
        
        if ( isdefined( self ) )
        {
            val::reset( "ztron_player", "ignoreme" );
        }
    }
    
    if ( !level.ztron.game_running && level.players.size > 1 )
    {
        loadedplayer = 0;
        
        foreach ( player in level.players )
        {
            if ( player function_791dcf0ce4bf51e7() )
            {
                loadedplayer++;
            }
        }
        
        if ( loadedplayer >= level.players.size )
        {
            return;
        }
        
        ztron_ui::function_37aad40e39a9fdfe( "join_waiting" );
        level.ztron.var_173a38989c2cb25f = 1;
        ztron_util::fade_in( 1, 1, 3 );
        val::set( "ztron_loading", "show_hud", 1 );
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0x5974f9b8, Offset: 0x17ed
// Size: 0x70
function private function_d2486f8c87b4c42c()
{
    self notify( #"hash_b7af7bec159d24d" );
    self endon( #"hash_b7af7bec159d24d" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death_or_disconnect" );
    ztron_util::fade_out( 1, 1 );
    
    if ( level utility::flag( "ztron_screen_faded" ) )
    {
        level utility::flag_waitopen( "ztron_screen_faded" );
        ztron_util::fade_in( 1, 1 );
        return;
    }
    
    ztron_util::fade_in( 1, 1 );
}

// Namespace ztron_player
// Params 0
// Checksum 0x235ac7f3, Offset: 0x1865
// Size: 0x74
function function_711470d3d1399644()
{
    if ( level utility::flag( "ztron_game_is_over" ) )
    {
        return;
    }
    
    if ( self.ztron.dead )
    {
        return;
    }
    
    if ( !self.ztron.var_771d2734cee765da )
    {
        return;
    }
    
    if ( self.ztron.var_a4c2f70bbc713f98 )
    {
        return;
    }
    
    if ( self.ztron.vehicle )
    {
        return;
    }
    
    return "ztron_player_indicator";
}

// Namespace ztron_player
// Params 0
// Checksum 0xaf07f706, Offset: 0x18e2
// Size: 0x66
function function_ea6afe1c8551fed8()
{
    if ( !self.ztron.var_f2e745eaefae4418 )
    {
        return;
    }
    
    if ( self getscriptablehaspart( self.ztron.var_f2e745eaefae4418 ) )
    {
        self setscriptablepartstate( self.ztron.var_f2e745eaefae4418, "off" );
    }
    
    self.ztron.var_f2e745eaefae4418 = undefined;
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x88c1bd46, Offset: 0x1950
// Size: 0x66
function private function_60d74279aa5c31bd()
{
    fx = function_711470d3d1399644();
    
    if ( !fx )
    {
        function_ea6afe1c8551fed8();
        return;
    }
    
    if ( self.ztron.var_f2e745eaefae4418 )
    {
        return;
    }
    
    if ( self getscriptablehaspart( fx ) )
    {
        self setscriptablepartstate( fx, "on" );
        self.ztron.var_f2e745eaefae4418 = fx;
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0xdfe83a09, Offset: 0x19be
// Size: 0xb2
function private function_f6db71bae46d1e49()
{
    self notify( #"hash_45b386336013a970" );
    self endon( #"hash_45b386336013a970" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.ztron.var_771d2734cee765da ) )
    {
        self.ztron.var_771d2734cee765da = 1;
    }
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( !isdefined( message ) )
        {
            continue;
        }
        
        if ( message == "ztron_weapon_indicator_enabled" )
        {
            self.ztron.var_771d2734cee765da = value == 1;
            function_60d74279aa5c31bd();
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0xd7c92cf0, Offset: 0x1a78
// Size: 0xa5
function private function_8cf68a360b7aa26()
{
    self notify( #"hash_dcf3c31615f46917" );
    self endon( #"hash_dcf3c31615f46917" );
    self endon( #"disconnect" );
    childthread function_f6db71bae46d1e49();
    
    if ( !level.ztron.game_running )
    {
        waitframe();
    }
    
    function_60d74279aa5c31bd();
    
    while ( true )
    {
        msg = utility::waittill_any_return( "topdown_camera_changed", "ztron_weapon_change_finish", "vehicle_enter", "vehicle_exit", "death", "ztron_game_is_over" );
        function_60d74279aa5c31bd();
        
        if ( msg == "death" || msg == "ztron_game_is_over" )
        {
            break;
        }
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x14c20902, Offset: 0x1b25
// Size: 0x217
function private onplayerspawned( params )
{
    ztron_player_utility::playercreate();
    
    if ( isdefined( level.ztron.var_ed3d142da5d88117 ) )
    {
        self thread [[ level.ztron.var_ed3d142da5d88117 ]]();
    }
    
    if ( isdefined( level.ztron.var_e0684383d714e65b ) )
    {
        self thread [[ level.ztron.var_e0684383d714e65b ]]();
    }
    
    self.ztron.var_54a4aec01fb5111a = gettime();
    
    if ( !isbot( self ) )
    {
        thread function_9855be5084f7f6c3();
        thread function_62470c5faf9288ea();
        thread function_a84cc50a4f098b04();
        thread function_6c7010d74540b1c1();
    }
    
    thread function_428442c6a62cf307();
    thread function_a7601f6b3e989c50();
    thread function_1208aaa17961a8c3();
    
    if ( getdvarint( @"scr_ztron_player_indicator_enabled", 1 ) == 1 )
    {
        thread function_8cf68a360b7aa26();
    }
    
    self setclientomnvar( "ui_show_objectives_title_inrange_force_show", 1 );
    self setclientomnvar( "ui_omnvar_use_alternative_fx", 1 );
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        ztron_player_utility::update_papaback_defeated( 0 );
    }
    
    self setclientomnvar( "ui_ztron_is_highest_score", 0 );
    
    if ( !level.ztron.var_ae731d68b2dededc )
    {
        self.ztron.highestscore = playerstats_interface::getplayerstat( "ztronPlayerStats", "highestScore", undefined, undefined, undefined, "zm" );
    }
    
    if ( !level.ztron.game_running )
    {
        val::set( "ztron_loading", "show_hud", 0 );
    }
    
    self setclientomnvar( "ui_ztron_disable_scoreboard", 1 );
    ztron_ui::function_d3d5fb2ecccb6e13();
    val::set( "ztron_player", "prone", 0 );
    
    if ( getdvarint( @"hash_84b84037c8997c2a", 0 ) == 1 )
    {
        clientnum = self getplayerclientnum();
        entitynum = self getentitynumber();
        
        /#
            logstring( "<dev string:x24>" + self.name + "<dev string:x50>" + clientnum + "<dev string:x5c>" + entitynum );
        #/
    }
    
    thread function_7d06fc830e0ee9a7();
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0x4bfbf919, Offset: 0x1d44
// Size: 0xd8
function private function_7d06fc830e0ee9a7()
{
    self notify( #"hash_c5dc74c554132953" );
    self endon( #"hash_c5dc74c554132953" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        time_played = matchdata::gettimefrommatchstart( gettime() );
        time_played = int( clamp( time_played, 0, 2147483647 ) / 1000 );
        reload_flag = isdefined( self.pers[ "telemetry" ].saveddata );
        
        if ( reload_flag )
        {
            time_played += self.pers[ "telemetry" ].saveddata.timeplayed;
        }
        
        time_played = clampint( time_played, 0, 360000 );
        self setclientomnvar( "ui_ztron_time_played", time_played );
        wait 0.5;
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x2e15bd3c, Offset: 0x1e24
// Size: 0x228
function private onplayerlaststand( params )
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 4 )
    {
        return;
    }
    
    if ( !self.ztron.var_8487be91b45f17c5 )
    {
        self notify( #"kill_shield" );
    }
    
    ztron_score::function_5c25e66ab18c5162();
    ztron_weapon::giveweaponpack( self.ztron.default_weapon_bundle );
    ztron_sound::ztron_playsound( "ztron_player_death", undefined, self );
    
    if ( self.ztron.score.lives <= 0 )
    {
        orgfx = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 20 ), self.angles );
        
        if ( isdefined( orgfx ) )
        {
            orgfx linkto( self );
            playfxontag( utility::getfx( "attackerhighlightSentient" ), orgfx, "tag_origin" );
            orgfx thread ztron_util::function_1544885c712921f8( self );
            orgfx thread ztron_util::deletemedelay( 4 );
        }
        
        level.ztron.downedplayers[ level.ztron.downedplayers.size ] = self;
        
        if ( !level.ztron.var_95d8c7a469393957 )
        {
            foreach ( player in level.players )
            {
                if ( player == self )
                {
                    continue;
                }
                
                if ( !player function_38143fa3db3815be() )
                {
                    continue;
                }
                
                player ztron_ui::function_787d89891b886acf( "LIFEDONATE_HINT", 8, 1 );
            }
        }
    }
    
    function_356003f95be5bad5( params.attacker );
    ztron_dialog::function_927bb94feca983e8( getxhash( "player_last_stand_group" ), 0, 0 );
    ztron_debug::debugmsg( "Player Died to " + ( params.attacker.classname ?? "unknown" ), 1 );
}

// Namespace ztron_player
// Params 1
// Checksum 0x693a20a6, Offset: 0x2054
// Size: 0x7b, Type: bool
function function_38143fa3db3815be( var_700d480463f4e196 )
{
    if ( self.inlaststand )
    {
        return false;
    }
    
    if ( self.ztron.score.lives < 2 )
    {
        return false;
    }
    
    time = gettime();
    
    if ( time < self.ztron.lifedonatecooldown )
    {
        return false;
    }
    
    if ( isdefined( var_700d480463f4e196 ) )
    {
        if ( time < var_700d480463f4e196 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0xa1328cc6, Offset: 0x20d8
// Size: 0x199
function private function_356003f95be5bad5( attacker )
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 && isdefined( level.ztron.playerrespawnoverride ) )
    {
        return;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        return;
    }
    
    if ( self.pers[ "deaths" ] >= 999 )
    {
        return;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "deaths" ] ) )
        {
            self.leaderboarddata[ "deaths" ] = self.leaderboarddata[ "deaths" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "deaths" ] ) )
        {
            [[ level.leaderboardfunc[ "deaths" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x68>" );
        
        if ( isdefined( self.pers[ "deaths" ] ) )
        {
            self.pers[ "deaths" ] = self.pers[ "deaths" ] + 1;
        }
    }
    
    if ( isagent( attacker ) )
    {
        if ( !isdefined( self.pers[ "telemetry" ].var_e3103b223b34ee91 ) )
        {
            self.pers[ "telemetry" ].var_e3103b223b34ee91 = 0;
        }
        
        self.pers[ "telemetry" ].var_e3103b223b34ee91++;
    }
    
    self.deaths = self.pers[ "deaths" ];
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x8c92d9f2, Offset: 0x2279
// Size: 0x57
function private onplayerentervehicle( params )
{
    if ( isplayer( params.player ) )
    {
        params.player ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_vehicle_group" ), 0, 0 );
        params.player utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", "off" );
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x7b17bd1c, Offset: 0x22d8
// Size: 0x54
function private function_97288f7c45162af2( params )
{
    if ( isplayer( params.player ) )
    {
        params.player utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", params.player.ztron.color );
    }
}

// Namespace ztron_player
// Params 0
// Checksum 0x5eae52e0, Offset: 0x2334
// Size: 0x22
function function_b3f2e7a97bd8b613()
{
    self notify( #"hash_e3f1007ca68e5f0c" );
    self setclientomnvar( "ui_ztron_show_player_position", 1 );
    thread function_a0e046bfc272ece9();
}

// Namespace ztron_player
// Params 0
// Checksum 0xb0babbe, Offset: 0x235e
// Size: 0x29
function function_a0e046bfc272ece9()
{
    self endon( #"disconnect" );
    self endon( #"hash_e3f1007ca68e5f0c" );
    wait 5;
    self setclientomnvar( "ui_ztron_show_player_position", 0 );
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x7111c0c6, Offset: 0x238f
// Size: 0x48
function private updateinput()
{
    profilestart();
    
    if ( self.ztron.var_d7d14e7f8296da4d )
    {
        profilestop();
        return;
    }
    
    if ( !self.ztron.var_40578ab5a6caa4dd )
    {
        function_6685c0d7e7f9ef24();
        function_aae4b26d790b4935();
    }
    
    function_c14550dfd040395d();
    profilestop();
}

// Namespace ztron_player
// Params 1
// Checksum 0xbd30c138, Offset: 0x23df
// Size: 0xba
function function_5cce32fbd37324a9( value )
{
    if ( getdvarint( @"hash_6e0ecda872e1958e" ) > 0 )
    {
        if ( value == 1 )
        {
            self.ztron.var_40578ab5a6caa4dd = 1;
            self notifyonplayercommand( "ztron_nuke", "+frag" );
            self notifyonplayercommand( "ztron_boost", "+smoke" );
            thread function_428442c6a62cf307();
            thread function_6c7010d74540b1c1();
            self notify( #"ztron_enable_alternative_field_upgrade_mapping" );
            return;
        }
        
        self.ztron.var_40578ab5a6caa4dd = 0;
        self notifyonplayercommandremove( "ztron_nuke", "+frag" );
        self notifyonplayercommandremove( "ztron_boost", "+smoke" );
        self notify( #"hash_5f84cee0453da33c" );
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0xb15e9e58, Offset: 0x24a1
// Size: 0xb8
function private function_6c7010d74540b1c1()
{
    self notify( #"hash_ae7eb2458c167848" );
    self endon( #"hash_ae7eb2458c167848" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self endon( #"hash_5f84cee0453da33c" );
    
    while ( true )
    {
        self waittill( #"ztron_nuke" );
        
        if ( getdvarint( @"hash_24e31ef141864d3f", 1 ) == 1 )
        {
            if ( self.ztron.var_557a2e6d2ffa015c || self.ztron.var_d7d14e7f8296da4d )
            {
                continue;
            }
        }
        
        nukecount = namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6();
        
        if ( nukecount > 0 )
        {
            thread namespace_a6a7fe92789f4ad9::function_35260497c4cb7b2c();
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0xfeda164, Offset: 0x2561
// Size: 0x103
function private function_428442c6a62cf307()
{
    self notify( #"hash_14d49a9489cf6b8d" );
    self endon( #"hash_14d49a9489cf6b8d" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self endon( #"hash_5f84cee0453da33c" );
    
    while ( true )
    {
        self waittill( #"ztron_boost" );
        
        if ( getdvarint( @"hash_16aeebd4114c7bf7", 1 ) == 1 )
        {
            if ( level.ztron.disable_boosting || self.ztron.var_d7d14e7f8296da4d || self.ztron.blockboost )
            {
                continue;
            }
        }
        
        if ( self.ztron.isboosting || isdefined( self.ztron.vehicle ) )
        {
            continue;
        }
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( namespace_33e886a9a5b55137::function_a4ca73e22464e330() > 0 )
        {
            namespace_33e886a9a5b55137::deploybooster();
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0x7964f6dc, Offset: 0x266c
// Size: 0x71
function private function_a7601f6b3e989c50()
{
    self notify( #"hash_5877c92f7e06d683" );
    self endon( #"hash_5877c92f7e06d683" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"topdown_camera_changed", var_4e63d1b535a5c79 );
        
        if ( var_4e63d1b535a5c79 )
        {
            thread damage_effects::onexitdeathsdoor( 1 );
            thread laststand::last_stand_exit_postfx();
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0xbaa742bc, Offset: 0x26e5
// Size: 0x95
function private function_62470c5faf9288ea()
{
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    self notifyonplayercommand( "flipTopdownCamera", "killstreak1" );
    self notifyonplayercommand( "flipTopdownCamera", "+actionslot 2" );
    
    while ( true )
    {
        self waittill( #"flipTopdownCamera" );
        
        if ( !isdefined( self.ztron ) )
        {
            continue;
        }
        
        if ( !level.ztron.var_a700dfcc9277d4e9 )
        {
            continue;
        }
        
        ztron_camera::flipTopdownCamera( !self.ztron.var_13805a047e18bac9 );
    }
}

// Namespace ztron_player
// Params 2
// Checksum 0x7f9bc8e3, Offset: 0x2782
// Size: 0x54, Type: bool
function function_8792ad3e4c833631( a, b )
{
    return a.ztron.score.lives > b.ztron.score.lives;
}

// Namespace ztron_player
// Params 0
// Checksum 0x6d1569b, Offset: 0x27df
// Size: 0x2ad
function function_e35fe57c35e0fad4()
{
    self notify( #"hash_5b9793cd064cc362" );
    self endon( #"hash_5b9793cd064cc362" );
    level endon( #"ztron_game_is_over" );
    
    while ( !level.ztron.var_95d8c7a469393957 )
    {
        wait 1.5;
        var_12e53f8f2f5693a1 = [];
        
        if ( level.ztron.downedplayers.size )
        {
            if ( level.ztron.game_laps > 0 && level utility::flag( "ztron_round_spawning" ) )
            {
                possibles = [];
                aliveplayers = ztron_player_utility::function_f39a4b7692450805();
                
                foreach ( player in aliveplayers )
                {
                    if ( player function_38143fa3db3815be( player.ztron.var_a2dfad0f9eaffed3 ) )
                    {
                        possibles[ possibles.size ] = player;
                    }
                }
                
                var_12e53f8f2f5693a1 = arraysort( possibles, undefined, &function_8792ad3e4c833631 );
            }
        }
        
        if ( level.ztron.downedplayers.size && var_12e53f8f2f5693a1.size )
        {
            time = gettime();
            var_852d7a569cae188d = var_12e53f8f2f5693a1[ 0 ];
            candidates = sortbydistance( level.ztron.downedplayers, var_852d7a569cae188d.origin );
            
            foreach ( player in candidates )
            {
                if ( var_852d7a569cae188d === player )
                {
                    continue;
                }
                
                if ( player.ztron.var_1978e4bc3fd889e7 )
                {
                    continue;
                }
                
                if ( player.ztron.respawnduration - player.ztron.respawnprogress < 2500 )
                {
                    continue;
                }
                
                var_852d7a569cae188d.ztron.var_a2dfad0f9eaffed3 = time + 120;
                var_852d7a569cae188d.ztron.lifedonatecooldown = time + 2000;
                var_852d7a569cae188d thread function_f0e9a4bc2c9a5fa4( player, 1 );
                break;
            }
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x38fef4e8, Offset: 0x2a94
// Size: 0x1c8
function private function_a84cc50a4f098b04()
{
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return;
    }
    
    self notifyonplayercommand( "donateLife", "+toggleweapalt" );
    self notifyonplayercommand( "donateLife", "+actionslot 1" );
    
    while ( true )
    {
        self waittill( #"donateLife" );
        time = gettime();
        
        if ( !isdefined( self.ztron ) || time < self.ztron.lifedonatecooldown )
        {
            continue;
        }
        
        if ( self.ztron.score.lives >= 1 && !self.inlaststand )
        {
            players = sortbydistance( level.ztron.downedplayers, self.origin );
            
            foreach ( player in players )
            {
                if ( self === player )
                {
                    continue;
                }
                
                if ( player.ztron.var_1978e4bc3fd889e7 )
                {
                    continue;
                }
                
                self.ztron.var_a2dfad0f9eaffed3 = time + 120;
                self.ztron.lifedonatecooldown = time + 2000;
                thread function_f0e9a4bc2c9a5fa4( player, 0 );
                break;
            }
        }
    }
}

// Namespace ztron_player
// Params 2, eflags: 0x4
// Checksum 0x537fdc68, Offset: 0x2c64
// Size: 0x23b
function private function_f0e9a4bc2c9a5fa4( target, forced = 0 )
{
    if ( self.ztron.score.lives > 0 )
    {
        if ( isdefined( target ) )
        {
            target.ztron.var_1978e4bc3fd889e7 = 1;
        }
        
        ztron_score::function_928d324dea557052( self.ztron.score.lives - 1 );
        ztron_sound::ztron_playsound( "hallelujah", undefined, self );
        thread ztron_player_utility::function_985a085be4ea0ba4();
        model = utility::spawn_model( "sat_zm_ztron_props_extra_life", self.origin, self.angles );
        
        if ( isdefined( model ) )
        {
            playertrail = utility::getfx( "ztron_player_trail_" + self.ztron.color );
            playfxontag( playertrail, model, "tag_origin" );
            glowvfx = utility::getfx( "glow_" + self.ztron.color );
            playfxontag( glowvfx, model, "tag_origin" );
            distsq = distancesquared( target.origin, self.origin );
            time = mapfloat( 0, squared( 1000 ), 0.25, 1, distsq );
            model moveto( target.origin, time );
            wait time;
            model delete();
        }
        
        if ( isdefined( target ) )
        {
            target.ztron.var_1978e4bc3fd889e7 = undefined;
            target.ztron.score.lives++;
            target ztron_player_utility::playerrespawnnow();
            
            if ( isdefined( self ) )
            {
                thread function_cb45a28aa581fd7e( forced ? 100 : 120 );
                
                if ( ztron_fate::hasfate( 6 ) && !forced )
                {
                    target thread function_cb45a28aa581fd7e( 50 );
                }
            }
            
            return;
        }
        
        if ( isdefined( self ) )
        {
            ztron_score::function_928d324dea557052( self.ztron.score.lives + 1 );
        }
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x6245974b, Offset: 0x2ea7
// Size: 0x19a
function private function_cb45a28aa581fd7e( range = 100 )
{
    self endon( #"disconnect" );
    roll = randomint( range );
    
    if ( roll == range - 1 && self.ztron.score.lives < ztron_score::getmaxlives() )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_extra_life" );
        wait 0.5;
    }
    
    if ( roll > 94 && self.ztron.score.bombs < ztron_score::function_b986c55261cc358e() )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_nuke" );
        wait 0.5;
    }
    
    if ( roll > 88 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_boxing_glove" );
        wait 0.5;
    }
    
    if ( roll > 75 && self.ztron.score.var_59f1f1595961cbe < ztron_score::getmaxboosts() )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_boost" );
        wait 0.5;
    }
    
    if ( roll > 50 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_chicken" );
        wait 0.5;
        ztron_item::function_d2dd7af394ebdbdd( "ztron_chicken" );
        wait 0.5;
    }
    
    if ( roll > 35 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_sawblade" );
        wait 0.5;
    }
    
    if ( roll > 15 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_magnet" );
        wait 0.5;
    }
    
    ztron_item::function_d2dd7af394ebdbdd( "ztron_chicken" );
    wait 0.5;
    
    if ( roll == 0 )
    {
        ztron_item::function_d2dd7af394ebdbdd( "ztron_extra_life" );
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x29336902, Offset: 0x3049
// Size: 0x64
function private function_1208aaa17961a8c3()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    childthread function_127a97e2c7abcff1();
    
    while ( true )
    {
        wait 0.1;
        
        if ( self.var_410881f05b3bf752 )
        {
            continue;
        }
        
        if ( utility::ent_flag( "in_toxic_gas" ) )
        {
            thread ztron_enemy_ai::function_bc65bed6aed12009( 5 );
            wait 5;
            utility::ent_flag_clear( "in_toxic_gas" );
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x67cc451e, Offset: 0x30b5
// Size: 0x86
function private function_127a97e2c7abcff1()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"damage", dmg, attacker, dir, point, meansofdeath );
        
        if ( attacker.var_6820d1249495110a && meansofdeath == "MOD_GRENADE" )
        {
            thread ztron_enemy_ai::function_bc65bed6aed12009( 5 );
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0x2c80eabe, Offset: 0x3143
// Size: 0x209
function private function_9855be5084f7f6c3()
{
    self notify( #"hash_b1bab0ab0cf21020" );
    self endon( #"hash_b1bab0ab0cf21020" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    self notifyonplayercommand( "topdownCameraNext", "+weapnext" );
    self notifyonplayercommand( "topdownCameraPrev", "+weapprev" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "topdownCameraNext", "topdownCameraPrev" );
        nextcamera = msg == "topdownCameraNext";
        
        if ( level.var_823f78c605f46c5c )
        {
            continue;
        }
        
        if ( self.birthtime + 500 > gettime() )
        {
            continue;
        }
        
        if ( !isdefined( self.ztron ) || self.ztron.var_8a46e28ad02229a8 || self.ztron.var_d7d14e7f8296da4d || self.inlaststand )
        {
            continue;
        }
        
        nowtime = gettime();
        
        if ( self.ztron.var_a2ffbb8c10b1bfe0 && nowtime - self.ztron.var_a2ffbb8c10b1bfe0 < 500 )
        {
            continue;
        }
        
        self.ztron.var_a2ffbb8c10b1bfe0 = nowtime;
        
        if ( !self.ztron.var_a4c2f70bbc713f98 )
        {
            targetcameramode = nextcamera ? ztron_camera::function_9e0e667097229f7b( self.ztron.var_a46fa357ac82e4a ) : ztron_camera::function_be3daddd800c42b3( self.ztron.var_a46fa357ac82e4a );
            ztron_camera::function_79d64be315aa51c9( targetcameramode );
            
            if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
            {
                ztron_camera::function_e907a99451bc212c( self.ztron.var_a46fa357ac82e4a );
            }
            else
            {
                ztron_camera::function_55ff170984e4b286( self.ztron.var_a46fa357ac82e4a );
            }
        }
        
        self notify( #"ztron_camera_changed" );
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0x5ede546c, Offset: 0x3354
// Size: 0x80
function private function_6685c0d7e7f9ef24()
{
    if ( self.ztron.var_557a2e6d2ffa015c )
    {
        return;
    }
    
    if ( self fragbuttonpressed() && !self.ztron.nukelatch )
    {
        self.ztron.nukelatch = 1;
        
        if ( namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6() > 0 )
        {
            thread namespace_a6a7fe92789f4ad9::function_35260497c4cb7b2c();
        }
    }
    
    if ( self fragbuttonpressed() == 0 )
    {
        self.ztron.nukelatch = 0;
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0xa4d7d8c5, Offset: 0x33dc
// Size: 0x1f8
function private function_aae4b26d790b4935()
{
    if ( level.ztron.disable_boosting )
    {
        return;
    }
    
    if ( isdefined( self.ztron.vehicle ) )
    {
        return;
    }
    
    if ( self.ztron.blockboost )
    {
        return;
    }
    
    if ( self.ztron.isboosting )
    {
        time = gettime();
        
        if ( time < self.ztron.boostendtime )
        {
            self setvelocity( self.ztron.boostvector );
            ztron_debug::debugmsg( "Player(" + self.ztron.color + ") BOOSTING active" );
            
            if ( self.ztron.var_9b2b1b27f628ceb1 < time )
            {
                level notify( #"boostlane", { #origin:self.origin } );
                self.ztron.var_9b2b1b27f628ceb1 = time + 250;
            }
            
            return;
        }
        
        self.ztron.isboosting = 0;
        thread ztron_player_utility::function_985a085be4ea0ba4();
        
        if ( isdefined( self.ztron.var_f566a419af3206df ) )
        {
            self.ztron.var_f566a419af3206df delete();
        }
        
        self notify( #"boosting_done" );
        ztron_debug::debugmsg( "Player(" + self.ztron.color + ") BOOSTING deactivating" );
    }
    
    if ( self.ztron.var_d30947b2f4baa2d5 )
    {
        if ( self secondaryoffhandbuttonpressed() )
        {
            return;
        }
        
        self.ztron.var_d30947b2f4baa2d5 = undefined;
    }
    
    if ( self secondaryoffhandbuttonpressed() || self.ztron.forceboost )
    {
        if ( namespace_33e886a9a5b55137::function_a4ca73e22464e330() > 0 )
        {
            namespace_33e886a9a5b55137::deploybooster();
        }
    }
}

// Namespace ztron_player
// Params 0, eflags: 0x4
// Checksum 0xf7d39650, Offset: 0x35dc
// Size: 0x171
function private function_c14550dfd040395d()
{
    if ( level.var_ba362d5be96483cb )
    {
        return;
    }
    
    if ( self isuseinprogress() || self isuseavailable() || self isonascender() )
    {
        return;
    }
    
    if ( self usebuttonpressed() )
    {
        self.ztron.var_723a1c076ec63480 = 1;
        return;
    }
    
    if ( self.ztron.var_723a1c076ec63480 )
    {
        if ( self.ztron.var_d270d1f08a5e0f8c )
        {
            self.ztron.var_723a1c076ec63480 = undefined;
            self.ztron.var_d270d1f08a5e0f8c = undefined;
            return;
        }
        
        if ( isdefined( self.ztron.vehicle ) )
        {
            if ( val::get( "vehicle_exit" ) )
            {
                self notify( #"ztron_player_dump_vehicle" );
            }
        }
        else if ( self.ismutantinjection && isdefined( self.ztron.var_607326a01e81ad4f ) )
        {
            self thread [[ self.ztron.var_607326a01e81ad4f ]]();
        }
        else if ( self.isjuggernaut )
        {
            self notify( #"remote_robot_manual_exit" );
        }
        else if ( self.ztron.var_c5c31e76e1c42198 != self.ztron.default_weapon_bundle )
        {
            ztron_weapon::takeweaponpack( 1, 1 );
        }
        
        self.ztron.var_723a1c076ec63480 = undefined;
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x496ff73, Offset: 0x3755
// Size: 0x5c
function private function_cf19e94b24424278( param )
{
    self.versusdone = 1;
    
    if ( self issplitscreenplayer() )
    {
        otherplayer = self getothersplitscreenplayer();
        
        if ( otherplayer )
        {
            otherplayer.versusdone = 1;
            otherplayer setclientomnvar( "ui_ztron_disable_scoreboard", 0 );
        }
    }
    
    self setclientomnvar( "ui_ztron_disable_scoreboard", 0 );
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x76fcbf3, Offset: 0x37b9
// Size: 0x71
function private function_563416d80c6ff24c( value )
{
    self.ztron.var_8a4455464a940cd9 = value == 1;
    
    if ( !self.ztron.var_8a4455464a940cd9 && level.ztron.var_98b3d7b76e30093b )
    {
        level.ztron.var_98b3d7b76e30093b dialogue::stop_dialogue( 1, 1 );
    }
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x4a0a4c89, Offset: 0x3832
// Size: 0x25
function private function_fb2c163041df7e1( value )
{
    self.ztron.var_2360e803c32a15a7 = value == 1;
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0x85e0812c, Offset: 0x385f
// Size: 0x3e
function private function_b151c4988a72eee( value )
{
    if ( !isdefined( self.ztron ) )
    {
        self.ztron = spawnstruct();
    }
    
    self.ztron.enabletextbubble = value == 1;
}

// Namespace ztron_player
// Params 18
// Checksum 0x275d4a69, Offset: 0x38a5
// Size: 0x90f
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    if ( isdefined( level.var_a44ba6c01eac941 ) && [[ level.var_a44ba6c01eac941 ]]( einflictor, eattacker, self, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2 ) )
    {
        return;
    }
    
    if ( ztron_player_utility::function_afac1199d03801b2() )
    {
        return;
    }
    
    if ( level.ztron.blitzmode && utility::flag( "ztron_round_paused" ) )
    {
        return;
    }
    
    if ( self.ztron.isboosting )
    {
        return;
    }
    
    time = gettime();
    
    if ( smeansofdeath == "MOD_MELEE" && self.var_b55310a2bb584f36 == eattacker && isdefined( self.var_65163f070ca46a02 ) )
    {
        deltatime = time - self.var_65163f070ca46a02;
        
        if ( deltatime < 100 )
        {
            return;
        }
    }
    
    if ( !isbot( self ) && self iscontrolsfrozen() )
    {
        if ( eattacker.var_8cb3c9f5176399ed != self )
        {
            return;
        }
    }
    
    if ( time < self.ztron.dmggrace )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_CRUSH" )
    {
        if ( isdefined( eattacker ) && eattacker.no_mod_crush )
        {
            return;
        }
    }
    
    if ( isdefined( objweapon ) && objweapon.basenamehash == %"sat_molotov_zm_hellhound" )
    {
        smeansofdeath = "MOD_FIRE";
    }
    
    if ( isdefined( eattacker ) && eattacker.team == self.team )
    {
        if ( smeansofdeath != "MOD_FIRE" )
        {
            return;
        }
    }
    
    if ( isdefined( einflictor ) && ( einflictor.team == self.team || isdefined( einflictor.owner ) && einflictor.owner.team == self.team ) )
    {
        if ( smeansofdeath != "MOD_FIRE" )
        {
            return;
        }
    }
    
    selement = "none";
    
    if ( objweapon.basenamehash == %"sat_snowball_ztron" )
    {
        if ( self.no_hazards )
        {
            return;
        }
        
        smeansofdeath = "MOD_ELEMENTAL_COLD";
    }
    
    if ( objweapon.basenamehash == %"sat_la_ztron_fireball" || objweapon.basenamehash == %"sat_ztron_lava_grenade" )
    {
        if ( self.no_hazards )
        {
            return;
        }
        
        smeansofdeath = "MOD_FIRE";
    }
    
    if ( smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_ELEMENTAL_FIRE" )
    {
        selement = "fire";
        
        if ( self.ztron.upgradeMask & 16 )
        {
            idamage = int( idamage * 0.5 );
        }
    }
    else if ( smeansofdeath == "MOD_ELEMENTAL_ELEC" )
    {
        selement = "electrical";
    }
    else if ( smeansofdeath == "MOD_ELEMENTAL_COLD" )
    {
        selement = "cold";
    }
    else if ( smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
    {
        selement = "toxic";
    }
    
    if ( smeansofdeath == "MOD_FALLING" && isdefined( level.ztron.var_d77b8b935a461811 ) )
    {
        idamage = [[ level.ztron.var_d77b8b935a461811 ]]( idamage );
        
        if ( idamage <= 0 )
        {
            return;
        }
    }
    
    if ( smeansofdeath == "MOD_TRIGGER_HURT" && self.no_hazards )
    {
        return;
    }
    
    if ( !einflictor.var_cef5832c47f5e009 )
    {
        self.ztron.dmggrace = time + ( self.ztron.var_a4c2f70bbc713f98 ? 2000 : 1000 );
        self.var_65163f070ca46a02 = time;
        self.var_b55310a2bb584f36 = eattacker;
        self.var_5812f44cd938ce65 = time + 3000;
        
        if ( self.ztron.var_6fe8ea86c8758aec > 0 && !level.ztron.var_4f9d49030e8ee54 && !self.ztron.var_c516f6d55a2165b4 )
        {
            ztron_util::function_eb8ba16055d6da7c( self, self, "none", smeansofdeath, undefined, idamage, vpoint, undefined, selement, 1, 1 );
            self.ztron.var_6fe8ea86c8758aec--;
            ztron_ui::function_38a72e402dc87ace();
            
            if ( self.ztron.var_6fe8ea86c8758aec == 0 )
            {
                playfxontag( utility::getfx( "ztron_shield_break" ), self, "J_Spine4" );
                ztron_sound::ztron_playsound( "ztron_shield_break_OS", self.origin );
            }
            
            self playrumbleonentity( "damage_heavy" );
            return;
        }
    }
    
    idamage = int( idamage );
    originaldamage = idamage;
    
    if ( !isdefined( nooneshot ) )
    {
        nooneshot = eattacker.nooneshot;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        idamage = self.maxhealth;
        
        if ( !shouldoneshot( eattacker, nooneshot, self.ztron.var_a4c2f70bbc713f98 ) )
        {
            if ( !self.ztron.var_a4c2f70bbc713f98 )
            {
                idamage = int( self.maxhealth * 0.65 );
            }
            else
            {
                idamage = int( self.maxhealth * 0.45 );
            }
        }
        
        if ( function_c90d4d92a605aebd( smeansofdeath ) )
        {
            idamage = originaldamage;
        }
        
        if ( level.ztron.blitzmode && !shouldoneshot( eattacker, nooneshot, self.ztron.var_a4c2f70bbc713f98 ) )
        {
            idamage = int( clamp( idamage, 0, 125 ) );
        }
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        if ( level.players.size == 1 )
        {
            maxdamage = int( self.maxhealth * 0.4 );
        }
        else
        {
            maxdamage = int( self.maxhealth * 0.7 );
        }
        
        if ( idamage > maxdamage )
        {
            idamage = maxdamage;
        }
    }
    
    showplayerdamage = 1;
    showplayerdamage |= selement != "none";
    showplayerdamage |= smeansofdeath != "MOD_MELEE";
    showplayerdamage |= istrue( eattacker.nooneshot );
    
    if ( self.isjuggernaut )
    {
        if ( idamage > 60 )
        {
            idamage = 60;
        }
        
        if ( idamage >= self.health && self.var_e4dae87a649544c3 )
        {
            self.var_e4dae87a649544c3 = 0;
            damagedata = { #hitloc:shitloc, #isfauxdeath:0, #objweapon:objweapon, #meansofdeath:smeansofdeath, #inflictor:einflictor, #victim:self, #attacker:eattacker };
            thread juggernaut::jugg_removejuggernaut( damagedata );
            idamage = 0;
        }
    }
    
    if ( showplayerdamage )
    {
        ztron_util::function_eb8ba16055d6da7c( self, self, "none", smeansofdeath, undefined, idamage, vpoint, undefined, selement, 1, 0, 16, level.var_de79f65048631206[ selement ] );
    }
    
    if ( idamage >= self.health && self != eattacker )
    {
        thread ztron_player_utility::highlightkiller( eattacker );
    }
    
    /#
        ztron_debug::debugmsg( "<dev string:x8e>" );
        ztron_debug::debugmsg( "<dev string:xf7>" );
        ztron_debug::debugmsg( "<dev string:x160>" + self.name, 1 );
        ztron_debug::debugmsg( "<dev string:x171>" + idamage + "<dev string:x17b>" + smeansofdeath + "<dev string:x18d>" + fdistance + "<dev string:x19a>" + vpoint, 1 );
        ztron_debug::debugmsg( "<dev string:x1a4>" + function_9828937e4768fc1f( einflictor ), 1 );
        ztron_debug::debugmsg( "<dev string:x1b1>" + function_9828937e4768fc1f( eattacker ), 1 );
        ztron_debug::debugmsg( "<dev string:x1bd>" + ( isdefined( objweapon ) ? objweapon.basename : "<dev string:x1c9>" ), 1 );
        ztron_debug::debugmsg( "<dev string:x8e>" );
    #/
    
    self playrumbleonentity( "damage_heavy" );
    damage::finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
    iskillstreakweapon = isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon );
    damage::handledamagefeedback( einflictor, eattacker, self, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, partname, willknockdown );
    damage_effects::playerdamageeffects( idamage, einflictor, eattacker, self, smeansofdeath, vpoint, 0, objweapon, shitloc, vdir );
    
    if ( !self function_acbf60ca18b9864b() )
    {
        healthratio = self.health / self.maxhealth;
        
        if ( healthratio <= self.var_b487d47112fa93d && !self.deathsdoor )
        {
            thread damage_effects::onenterdeathsdoor();
        }
    }
}

// Namespace ztron_player
// Params 1
// Checksum 0xc1add84c, Offset: 0x41bc
// Size: 0x15c
function function_9828937e4768fc1f( ent )
{
    if ( !isdefined( ent ) )
    {
        return "unknown";
    }
    
    if ( isdefined( ent.basearchetype ) )
    {
        return ent.basearchetype;
    }
    
    if ( isdefined( ent.targetname ) )
    {
        return ent.targetname;
    }
    
    if ( isdefined( ent.weapon_name ) )
    {
        return ent.weapon_name;
    }
    
    if ( isdefined( ent.owner ) )
    {
        return function_9828937e4768fc1f( ent.owner );
    }
    
    if ( isdefined( ent.script_noteworthy ) )
    {
        return ent.script_noteworthy;
    }
    
    if ( isdefined( ent.classname ) )
    {
        return ent.classname;
    }
    
    if ( isdefined( ent.asmname ) )
    {
        return ent.asmname;
    }
    
    if ( isdefined( ent.model ) && ent.model != "" )
    {
        return ent.model;
    }
    
    if ( isdefined( ent.script_model ) && ent.script_model.model != "" )
    {
        return ent.script_model.model;
    }
    
    return "ENT ID: " + ent getentitynumber();
}

// Namespace ztron_player
// Params 3, eflags: 0x4
// Checksum 0x900456be, Offset: 0x4321
// Size: 0x85, Type: bool
function private shouldoneshot( eattacker, nooneshot, var_a4c2f70bbc713f98 )
{
    if ( eattacker.isoneshot || eattacker.ztron.boss )
    {
        return true;
    }
    
    if ( level.ztron.var_371903e5801e0e08 || level.ztron.blitzmode || nooneshot || var_a4c2f70bbc713f98 )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0xf679facf, Offset: 0x43af
// Size: 0x7a
function private function_c90d4d92a605aebd( smeansofdeath )
{
    var_9411fab913ef707e = [ "MOD_ELEMENTAL_COLD", "MOD_TRIGGER_HURT", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_FALLING", "MOD_FIRE", "MOD_ELEMENTAL_FIRE", "MOD_GRENADE", "MOD_ELEMENTAL_TOXIC" ];
    return arraycontains( var_9411fab913ef707e, smeansofdeath );
}

// Namespace ztron_player
// Params 16
// Checksum 0x6e64323c, Offset: 0x4432
// Size: 0xb7, Type: bool
function function_bea9caf67da14a3e( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2 )
{
    if ( smeansofdeath == "MOD_FALLING" && level.var_8972cc8b6869f399 )
    {
        return true;
    }
    
    return !victim ztron_player_utility::function_b22546586c836fe9();
}

// Namespace ztron_player
// Params 1
// Checksum 0xc28cd972, Offset: 0x44f2
// Size: 0xec
function function_293f29891405519c( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.versusdone = 0;
    level.ztron.var_909f9ee392414e7 = arraycombineunique( level.ztron.var_909f9ee392414e7, [ player getentitynumber() ] );
    
    foreach ( var_d1b9a1ee24a15dc1 in level.players )
    {
        if ( !ztron_player_utility::function_baf22e7b5779b533( var_d1b9a1ee24a15dc1 ) )
        {
            playfxontagforclients( utility::getfx( "ztron_explosive_warning_light" ), player, "tag_origin", var_d1b9a1ee24a15dc1 );
        }
    }
}

// Namespace ztron_player
// Params 1
// Checksum 0x141dd1a7, Offset: 0x45e6
// Size: 0x130
function function_dd1fa62b48800adb( player )
{
    if ( ztron_player_utility::function_baf22e7b5779b533( player ) )
    {
        level.ztron.var_909f9ee392414e7 = arrayremove( level.ztron.var_909f9ee392414e7, player getentitynumber() );
    }
    
    player ztron_weather::function_71715e0f568a17c();
    player ztron_health_bar::function_381204d14efffd6f();
    
    foreach ( var_d1b9a1ee24a15dc1 in level.players )
    {
        stopfxontagforclients( utility::getfx( "ztron_explosive_warning_light" ), player, "tag_origin", var_d1b9a1ee24a15dc1 );
    }
    
    if ( utility::issharedfuncdefined( #"player", #"onrejoin" ) )
    {
        utility::callsharedfunc( #"player", #"onrejoin", player );
    }
    
    level notify( #"hash_2bc51110a02eb3c3", player );
    player thread function_d0241d6be14a068c();
}

// Namespace ztron_player
// Params 0, eflags: 0xc
// Checksum 0x9993e907, Offset: 0x471e
// Size: 0x75
function private function_d0241d6be14a068c()
{
    self notify( #"hash_69b5c774cb4fa647" );
    self endon( #"hash_69b5c774cb4fa647" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( function_791dcf0ce4bf51e7() )
        {
            break;
        }
        
        waitframe();
    }
    
    active_event = self.musicbankparams[ "activeEvent" ];
    
    if ( active_event )
    {
        self.musicbankparams[ "activeEvent" ] = undefined;
        level thread musicbank_utility::function_5aca66c390aa347d( self, active_event );
    }
}

// Namespace ztron_player
// Params 0
// Checksum 0x182b8c1c, Offset: 0x479b
// Size: 0x34
function function_9886753b3100ebd0()
{
    self endon( #"disconnect" );
    waitframe();
    val::reset_all( "ztron_vehicle_block" );
    wait 0.5;
    self.ztron.vehicleblocked = undefined;
}

// Namespace ztron_player
// Params 0
// Checksum 0xa8f8d275, Offset: 0x47d7
// Size: 0xe
function function_37facbabb748eff2()
{
    self playerhide();
    self function_16332a7775f10aa9();
}

// Namespace ztron_player
// Params 0
// Checksum 0x1abe6273, Offset: 0x47ed
// Size: 0x55
function function_ca94aec68892d78f()
{
    self playershow();
    
    if ( isdefined( self.operatorcustomization.reactiveoperator ) && self.operatorcustomization.reactiveoperator != "" )
    {
        self function_184d7ec010cfaa92( self.operatorcustomization.reactiveoperator );
    }
}

// Namespace ztron_player
// Params 1
// Checksum 0x65cdc401, Offset: 0x484a
// Size: 0x40
function function_1c41da54dd8820c0( params )
{
    stance = self getstance();
    
    if ( !params.isalive || stance == "prone" )
    {
        return;
    }
    
    ztron_player_utility::updateplayerspeed();
}

// Namespace ztron_player
// Params 1, eflags: 0x4
// Checksum 0xbef0117, Offset: 0x4892
// Size: 0x1d
function private onplayerdeath( params )
{
    utility::function_7c10ea82c1e305b8( "JetGunVFX", "off" );
}

// Namespace ztron_player
// Params 1
// Checksum 0xdc40177e, Offset: 0x48b7
// Size: 0x38
function function_f462e5f9238d0f94( params )
{
    if ( level.players.size <= 1 && level utility::flag( "ztron_game_is_over" ) )
    {
        level notify( #"request_end_game_again" );
    }
}

