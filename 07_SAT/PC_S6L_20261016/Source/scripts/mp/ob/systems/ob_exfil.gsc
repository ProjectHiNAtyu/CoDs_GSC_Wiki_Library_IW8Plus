// scripts\mp\ob\systems\ob_exfil.gsc  (hash_5b124833ce74c747.gscc) (size: 21241 Bytes / 0x52f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc8bb163 (3700142435)
// size ...... 21241 (0x52f9)
// includes .. 43  (offset: 0x4ca5)
// strings ... 84  (offset: 0x4dfd)
// dev strs .. 6   (offset: 0x52b1)
// exports ... 35  (offset: 0x334d)
// cseg ...... 0x67f + 0x2cce (0x334d)
// imports ... 163 (offset: 0x38c5)
// animtree1 . 0   (offset: 0x52f9)
// animtree2 . 0   (offset: 0x52f9)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\gasmask;
#using scripts\common\hud_util;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\ob_spectate;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objectives\exfil;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\scoreboard;
#using scripts\mp\squads;

#namespace ob_exfil;

// Namespace ob_exfil
// Params 0
// Checksum 0xd1ebf419, Offset: 0x69d
// Size: 0x168
function init_ob_exfil()
{
    level.var_cdacce741094543b = &"shared_hintstrings/exfil_start_use_ob";
    level.var_1ba181e75a0b8dbc = &utility::empty_init_func;
    level.var_a347479bbc614700 = "EXFIL_OB";
    level.var_5d57c0ef0a0a2e4f = "exfil_activity_ob_definition";
    exfil::function_c9d4f32197ee2e57();
    level.var_9b826d9aa08bb857 = &get_exfil_aitype;
    level.var_9f0a7ee32653dd0a = &function_7945ba0143ab037d;
    level.var_d1c505330bef7d45 = &function_2d39b258c075b58e;
    level.var_e3788ed969087ff7 = &function_568b269c748ba2b6;
    level.func_exfil_opt_in = &ob_exfil_opt_in;
    level.var_557007fc804faab8 = &function_db3261dc07872e31;
    level.var_6694eca554285e63 = &function_4133eceb2c4aa058;
    level.ob_exfil_throttle = throttle::throttle_initialize( "ob_exfil_player", 1, level.framedurationseconds * 3 );
    level.var_a4fc99047bac7beb = 1;
    callback::add( "on_exfil_player_joined", &ob_exfil_player_joined );
    callback::add( "on_exfil_player_failure", &ob_exfil_player_failure );
    callback::add( "on_exfil_player_available", &ob_exfil_player_available );
    callback::add( "on_exfil_ai_spawned", &on_exfil_ai_spawned );
    callback::add( "on_exfil_vehicle_spawned", &on_exfil_vehicle_spawned );
    utility::registersharedfunc( #"instanceInventory", #"ismaptomapexfil", &function_391b310b880fab80 );
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &function_f335edf02e6fb9ee, "REV_OB_EXFIL" );
    
    /#
        level thread ob_exfil_devgui();
    #/
}

/#

    // Namespace ob_exfil
    // Params 0
    // Checksum 0x6f45db9, Offset: 0x80d
    // Size: 0x3a, Type: dev
    function ob_exfil_devgui()
    {
        utility::flag_wait( "<dev string:x24>" );
        devgui::function_9082edeb5db93280( "<dev string:x37>" );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x6c>", &function_af7242616e8d77e7 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_exfil
    // Params 1
    // Checksum 0xda105aef, Offset: 0x84f
    // Size: 0x3a, Type: dev
    function function_af7242616e8d77e7( params )
    {
        var_4330daa3578f7ce9 = getdvarint( @"hash_bc321023e9100f4", 0 );
        setdvar( @"hash_bc321023e9100f4", !var_4330daa3578f7ce9 );
    }

#/

// Namespace ob_exfil
// Params 0
// Checksum 0x9092a330, Offset: 0x891
// Size: 0x11
function function_4133eceb2c4aa058()
{
    return getdvarint( @"ob_exfil_wait_time", 1 );
}

// Namespace ob_exfil
// Params 2
// Checksum 0x9b09a44f, Offset: 0x8ab
// Size: 0x1fb
function ob_exfil_opt_in( s_exfil, var_5a5626a7d4b2feb )
{
    a_squad_members = var_5a5626a7d4b2feb squad_utility::getsquadmembers( undefined, 1 );
    s_exfil.a_potential_players = [ var_5a5626a7d4b2feb ];
    
    foreach ( var_8a958389218cbbb3 in a_squad_members )
    {
        if ( isdefined( var_8a958389218cbbb3.s_exfil ) && isdefined( var_8a958389218cbbb3.s_exfil.s_activity_instance ) )
        {
            if ( var_8a958389218cbbb3 == var_5a5626a7d4b2feb )
            {
                var_5a5626a7d4b2feb exfil::function_c628843257429820();
                s_exfil.a_potential_players = arraycombineunique( s_exfil.a_potential_players, [ var_5a5626a7d4b2feb ] );
            }
            
            continue;
        }
        
        s_exfil.a_potential_players = arraycombineunique( s_exfil.a_potential_players, [ var_8a958389218cbbb3 ] );
    }
    
    s_exfil.a_exfil_players = s_exfil.a_potential_players;
    
    foreach ( player in s_exfil.a_exfil_players )
    {
        activity_participation::function_bc67362dace4370c( s_exfil.s_activity_instance, player );
        player.s_exfil = s_exfil;
    }
    
    callback::callback( "on_exfil_player_available", s_exfil );
    utility::array_thread( s_exfil.a_exfil_players, &hud_message::showsplash, "cp_mp_exfil_inbound" );
    wait 2;
}

// Namespace ob_exfil
// Params 1
// Checksum 0x7954b78b, Offset: 0xaae
// Size: 0x21c
function function_db3261dc07872e31( var_3e017e77298439f1 )
{
    if ( getdvarint( @"aether_storm_enabled", 1 ) == 0 )
    {
        return [[ level.var_37ee95c5464d47be ]]( "exfil", var_3e017e77298439f1 );
    }
    
    utility::flag_wait( "aether_storm_initialized" );
    
    if ( level.aether_storm.final_exfil_disabled )
    {
        return [[ level.var_37ee95c5464d47be ]]( "exfil", var_3e017e77298439f1 );
    }
    
    s_final_exfil = utility::callsharedfunc( #"exfil", #"hash_5e7a1f9e07bb1d56" );
    var_adade63cdf72d5f6 = ( level.aether_storm.var_2b144efe1cc8dee2 - level.aether_storm.var_ddadcc992aaf985 ) / level.aether_storm.var_daf65605507e6f78;
    var_6e24caece90847f4 = level.aether_storm.expansion_duration_seconds;
    var_6e24caece90847f4 -= level.aether_storm.final_exfil_duration;
    var_6e24caece90847f4 -= getdvarint( @"hash_eb873c5e99093d11", 50 );
    var_6e24caece90847f4 -= getdvarint( @"hash_346baccb7a031727", 7 );
    var_9111c62f7782c925 = [];
    
    foreach ( s_exfil in var_3e017e77298439f1 )
    {
        if ( s_exfil == s_final_exfil )
        {
            continue;
        }
        
        var_9bdd35a2204b7a7c = distance2d( s_exfil.origin, level.aether_storm.starting_origin );
        var_2f6e21b8fa700fd9 = ( var_9bdd35a2204b7a7c - level.aether_storm.var_ddadcc992aaf985 ) / var_adade63cdf72d5f6;
        
        if ( var_2f6e21b8fa700fd9 >= var_6e24caece90847f4 )
        {
            continue;
        }
        
        var_9111c62f7782c925[ var_9111c62f7782c925.size ] = s_exfil;
    }
    
    return [[ level.var_37ee95c5464d47be ]]( "exfil", var_9111c62f7782c925 );
}

// Namespace ob_exfil
// Params 1
// Checksum 0xd0a06dc1, Offset: 0xcd3
// Size: 0x100, Type: bool
function function_2d39b258c075b58e( player )
{
    if ( isdefined( self.s_exfil ) && self.s_exfil.var_df00f5fbf4a6d195 )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_bc321023e9100f4", 0 ) || exfil::function_9aa9df8577941cb0() )
    {
        return true;
    }
    
    if ( !activity_player_common::function_762fb7fa3dbba07a( player ) )
    {
        return false;
    }
    
    var_8bf625e85bb744c3 = activity_player_common::function_f2a52859f0878e78( player );
    var_951ceeca3c015eb1 = 0;
    
    foreach ( var_50f46c15a3ec2837 in var_8bf625e85bb744c3 )
    {
        if ( var_50f46c15a3ec2837.success )
        {
            var_951ceeca3c015eb1++;
        }
    }
    
    if ( var_951ceeca3c015eb1 > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_exfil
// Params 2
// Checksum 0x3a2e117a, Offset: 0xddc
// Size: 0x19c
function function_568b269c748ba2b6( s_exfil, var_a05c06150704bdef )
{
    if ( getdvarint( @"hash_37e686acc7d62c47", 0 ) )
    {
        return;
    }
    
    var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( s_exfil.var_42ada65a735fd2f3.origin );
    s_exfil_activity_bundle = exfil::function_3e68f7962cd82ad3( s_exfil );
    
    if ( var_a05c06150704bdef )
    {
        switch ( var_8de44035c62f2f4f )
        {
            case #"hash_7bb2cd766703d463":
            case #"hash_a1e09f51896088fb":
            default:
                return ( "ai_encounter:" + s_exfil_activity_bundle.var_27280423a99c490e );
            case #"hash_af83e47edfa8900a":
                return ( "ai_encounter:" + s_exfil_activity_bundle.var_875686cec8de4e93 );
            case #"hash_5343b465e56ec9a4":
                return ( "ai_encounter:" + s_exfil_activity_bundle.var_e7c64b9c87a7c3d );
            case #"hash_651f76c0ad6741ec":
                return ( "ai_encounter:" + s_exfil_activity_bundle.var_dd36743d5dc93a9e );
        }
        
        return;
    }
    
    switch ( var_8de44035c62f2f4f )
    {
        case #"hash_7bb2cd766703d463":
        case #"hash_a1e09f51896088fb":
        default:
            return ( "ai_encounter:" + s_exfil_activity_bundle.var_4f1af6a1c9aabb85 );
        case #"hash_af83e47edfa8900a":
            return ( "ai_encounter:" + s_exfil_activity_bundle.var_15ffd4100ea6e872 );
        case #"hash_5343b465e56ec9a4":
            return ( "ai_encounter:" + s_exfil_activity_bundle.var_e120b455215d99ec );
        case #"hash_651f76c0ad6741ec":
            return ( "ai_encounter:" + s_exfil_activity_bundle.var_53e9db8c805ec5b1 );
    }
}

// Namespace ob_exfil
// Params 0
// Checksum 0x2d7fa101, Offset: 0xf80
// Size: 0x20
function get_exfil_aitype()
{
    if ( utility::percent_chance( 10 ) )
    {
        return function_b3988325430ce242( "zombie_base_armored_heavy" );
    }
    
    return function_b3988325430ce242( "zombie_base" );
}

// Namespace ob_exfil
// Params 1
// Checksum 0x1b2d8d47, Offset: 0xfa9
// Size: 0x159
function on_exfil_ai_spawned( params )
{
    new_health = getdvarint( @"hash_30b03a2625dd852c", -1 );
    
    if ( new_health > 0 )
    {
        self.health = new_health;
    }
    
    if ( self.basearchetype == "zombie_base" )
    {
        var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( self.origin );
        var_be10289044c6269d = "run";
        
        switch ( var_8de44035c62f2f4f )
        {
            case #"hash_7bb2cd766703d463":
            default:
                if ( utility::percent_chance( 5 ) )
                {
                    var_be10289044c6269d = "sprint";
                }
                
                break;
            case #"hash_af83e47edfa8900a":
                if ( utility::percent_chance( 33 ) )
                {
                    var_be10289044c6269d = "sprint";
                }
                
                break;
            case #"hash_5343b465e56ec9a4":
            case #"hash_651f76c0ad6741ec":
                var_be10289044c6269d = "sprint";
                break;
        }
        
        zombie_utils::function_a8ce00e0448cb6f0( var_be10289044c6269d, "exfil", 24 );
        
        if ( isplayer( self.var_d67b0672ab8c1f3a ) && isalive( self.var_d67b0672ab8c1f3a ) && !player::isinlaststand( self.var_d67b0672ab8c1f3a ) )
        {
            self aieventlistenerevent( "combat", self.var_d67b0672ab8c1f3a, self.var_d67b0672ab8c1f3a.origin );
        }
    }
}

// Namespace ob_exfil
// Params 1
// Checksum 0x21ab067d, Offset: 0x110a
// Size: 0x2b
function on_exfil_vehicle_spawned( params )
{
    if ( getdvarint( @"hash_37aa7620b893be20", 1 ) != 0 )
    {
        self.var_eb66888cf4bb4822 = 1;
    }
}

// Namespace ob_exfil
// Params 2
// Checksum 0x81c858ed, Offset: 0x113d
// Size: 0x31e
function function_7945ba0143ab037d( player, exfil_type = #"none" )
{
    player endon( #"disconnect" );
    assert( !isdefined( player.exfilpos ), "<dev string:x81>" );
    s_exfil = player.s_exfil;
    vh_exfil = player.s_exfil.vh_exfil;
    player val::set( "exfil", "damage", 0 );
    player.var_4c1251d28c2b0dde = 1;
    
    if ( !player.var_bdeeca1e699ddbdb )
    {
        wait 2.5;
        
        if ( exfil::function_6c954b552067189f() && isdefined( vh_exfil ) )
        {
            wait getdvarfloat( @"hash_1862302145751eaf", 13 );
        }
    }
    
    if ( player.isjuggernaut )
    {
        player juggernaut::jugg_removejuggernaut( { #instantdeath:1 } );
        wait 1;
    }
    
    if ( isdefined( s_exfil ) )
    {
        s_exfil notify( #"exfil_vehicle_gone" );
    }
    
    player.var_4c1251d28c2b0dde = undefined;
    
    if ( isdefined( vh_exfil ) && !player.var_22bd8935826c4bc5 )
    {
        player.b_completed_exfil = undefined;
        player.var_1f12c6803897a86d = undefined;
        player.var_bdeeca1e699ddbdb = undefined;
        player val::reset( "exfil", "damage" );
        player setplayermusicstate( "" );
        return;
    }
    
    player function_ee9a0881801e609f();
    
    if ( utility::issharedfuncdefined( #"overlord", #"hash_5041a8f1a1c8b981" ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_5041a8f1a1c8b981", [ player ] );
    }
    
    var_500989f5b9957c2f = 1;
    
    foreach ( other_player in level.players )
    {
        if ( other_player == player )
        {
            continue;
        }
        
        if ( !other_player.b_completed_exfil && ob_laststand::function_5461d55290ca1ab6( other_player ) )
        {
            var_500989f5b9957c2f = 0;
            break;
        }
    }
    
    s_exfil.door = self;
    var_b34148127d620c14 = "none";
    
    switch ( exfil_type )
    {
        case #"hash_8387230f6a9afb9c":
            var_b34148127d620c14 = "rift_run";
            break;
        default:
            break;
    }
    
    if ( isdefined( s_exfil.instance ) && isdefined( s_exfil.instance.script_noteworthy ) )
    {
        var_b34148127d620c14 = s_exfil.instance.script_noteworthy;
    }
    
    function_e94f75fb46982689( player, var_b34148127d620c14 );
    
    if ( utility::callsharedfunc( #"ob_quest_exfil", #"attempt_quest_exfil", player, s_exfil, var_500989f5b9957c2f ) )
    {
        return;
    }
    
    thread function_b6621a660c647f03( player, s_exfil, var_500989f5b9957c2f, exfil_type );
}

// Namespace ob_exfil
// Params 4
// Checksum 0x60385839, Offset: 0x1463
// Size: 0x587
function function_b6621a660c647f03( player, s_exfil, var_500989f5b9957c2f, exfil_type = #"none" )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    level thread game_utility::fadetoblackforplayer( player, 1, 0.25 );
    player.exfilpos = player.origin;
    wait 0.25;
    throttle::throttle_wait_in_queue( level.ob_exfil_throttle, player );
    
    if ( isdefined( level.var_1e0643fea933c8d2 ) )
    {
        player.exfilpos = player [[ level.var_1e0643fea933c8d2 ]]();
    }
    
    player val::set( "exfil", "crouch", 0 );
    player val::set( "exfil", "gesture", 0 );
    player val::set( "exfil", "allow_jump", 0 );
    player val::set( "exfil", "killstreaks", 0 );
    player val::set( "exfil", "melee", 0 );
    player val::set( "exfil", "offhand_weapons", 0 );
    player val::set( "exfil", "prone", 0 );
    player val::set( "exfil", "sprint", 0 );
    player val::set( "exfil", "supers", 0 );
    player val::set( "exfil", "usability", 0 );
    player val::set( "exfil", "weapon", 0 );
    player val::set( "exfil", "allow_movement", 0 );
    player val::set( "exfil", "fire", 0 );
    player val::set( "exfil", "weapon_switch", 0 );
    player val::set( "exfil", "ignoreme", 1 );
    player val::set( "exfil", "allow_skill_select", 0 );
    player val::set( "exfil", "allow_reward_select", 0 );
    player notify( #"skills_tut_hint_complete" );
    player freezecontrols( 1 );
    player playerhide();
    fullyextracted = 1;
    a_squad_members = player squad_utility::getsquadmembers();
    
    foreach ( var_8a958389218cbbb3 in a_squad_members )
    {
        if ( !var_8a958389218cbbb3.b_completed_exfil )
        {
            fullyextracted = 0;
            break;
        }
    }
    
    if ( level.onlinegame )
    {
        a_party_members = player getfireteammembers();
        
        foreach ( var_fdbca7eaf92508dd in a_party_members )
        {
            if ( !var_fdbca7eaf92508dd.b_completed_exfil )
            {
                fullyextracted = 0;
                break;
            }
        }
    }
    
    if ( fullyextracted )
    {
        player setclientomnvar( "ui_dmz_extract_successful", 2 );
    }
    else
    {
        player setclientomnvar( "ui_dmz_extract_successful", 1 );
    }
    
    player ob_finalize_exfil( s_exfil, exfil_type );
    level.skipplaybodycountsound = 1;
    player playerlogic::removefromalivecount( 1 );
    teams::validatealivecount( "extract", player.team, player );
    
    if ( fullyextracted )
    {
        if ( isdefined( player.exfilpos ) && isdefined( player.angles ) )
        {
            player playerlogic::spawnintermission( { #angles:player.angles, #origin:player.exfilpos }, undefined, 0 );
        }
        else if ( isdefined( player.origin ) && isdefined( player.angles ) )
        {
            player playerlogic::spawnintermission( { #angles:player.angles, #origin:player.origin }, undefined, 0 );
        }
        else
        {
            player playerlogic::spawnintermission( undefined, undefined, 0 );
        }
    }
    else
    {
        ob_spectate::spawn_spectator( player, undefined );
    }
    
    a_squad_members = player squad_utility::getsquadmembers();
    var_41ae879e3b77457 = player squad_utility::getsquadmembers( undefined, 1 );
    
    if ( !isdefined( var_41ae879e3b77457 ) || var_41ae879e3b77457.size == 0 )
    {
        thread [[ level.onsquadeliminated ]]( a_squad_members, !var_500989f5b9957c2f );
    }
    
    level thread game_utility::fadetoblackforplayer( player, 0, 1 );
    player setclientomnvar( "ui_play_again_disabled", 1 );
    player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
    player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "objective_completed" ] );
    
    if ( getdvarint( @"hash_c68e810840841e3a", 0 ) )
    {
        player thread function_e585df665b627129();
    }
    
    player.b_exfil_fully_completed = 1;
    player notify( #"exfil_fully_completed" );
    self notify( #"exfil_fully_completed" );
    wait 5.5;
    level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    wait 0.5;
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
}

// Namespace ob_exfil
// Params 0, eflags: 0x4
// Checksum 0xd7c7b97, Offset: 0x19f2
// Size: 0xa8
function private function_ee9a0881801e609f()
{
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( instanceid, activityinfostruct in var_ccc91d79bfa22c3a )
    {
        activityinstance = level.activities.instances[ instanceid ];
        activity_participation::function_61aa2b2879f2c0a2( activityinstance, self, 1 );
    }
}

// Namespace ob_exfil
// Params 2
// Checksum 0x89001445, Offset: 0x1aa2
// Size: 0x19b
function ob_finalize_exfil( s_exfil, exfil_type = #"none" )
{
    assert( isplayer( self ) );
    player = self;
    player function_c5c0e1efe37f8b1b();
    function_d1f3eea4316ea439( player );
    player setplayerdata( level.var_6f9b00680ed002d8, "hasPlayedAvalonFreeroam", 1 );
    waitframe();
    
    if ( common_instance_inventory::isenabled() )
    {
        player common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
        
        if ( !player.inventoryfinalized )
        {
            player common_instance_inventory::function_8fd84f733b81e456();
        }
    }
    else
    {
        player function_58014c16460ffa28();
        player common_inventory::function_1202b827227d4ad2();
    }
    
    waitframe();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
    
    if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
    {
        gamelogic_mp::function_a7f2ba55c82bfa95( player );
    }
    
    player ob::function_8ad966643eb205e0( 1 );
    player callback::callback( #"exfil_success" );
    player callback::callback( #"ob_exfil_success", { #exfiltype:exfil_type, #exfil:s_exfil } );
    ob::function_82226ec4c6925388( player, 1 );
    gamelogic_mp::processlobbydataforclient( player );
    scoreboard::processcommonplayerdataforplayer( player );
    processlobbydata();
    
    if ( isdefined( player.matchbonus ) )
    {
        player setclientomnvar( "ui_round_end_match_bonus", player.matchbonus, 1 );
    }
    
    player setclientdvar( @"ui_opensummary", 1 );
    player utility::ent_flag_set( "ob_exfil_finalized" );
}

// Namespace ob_exfil
// Params 0
// Checksum 0x80838df4, Offset: 0x1c45
// Size: 0x2a
function function_e585df665b627129()
{
    self endon( #"disconnect" );
    wait 2;
    squads::leavesquad( self.team, self.sessionsquadid );
}

// Namespace ob_exfil
// Params 1
// Checksum 0xe6d300e6, Offset: 0x1c77
// Size: 0xc
function ob_exfil_player_joined( s_exfil )
{
    
}

// Namespace ob_exfil
// Params 1
// Checksum 0x31498b6d, Offset: 0x1c8b
// Size: 0xc
function ob_exfil_player_failure( s_exfil )
{
    
}

// Namespace ob_exfil
// Params 1
// Checksum 0x1facd9a, Offset: 0x1c9f
// Size: 0xc
function ob_exfil_player_available( s_exfil )
{
    
}

// Namespace ob_exfil
// Params 1
// Checksum 0x1f5edb7d, Offset: 0x1cb3
// Size: 0xfa
function function_e7342b2976589225( var_9ac2a9920107bedc )
{
    level endon( #"game_ended" );
    var_9ac2a9920107bedc = getdvarint( @"hash_3f1b45f1b20047ff", var_9ac2a9920107bedc ?? 120 );
    end_time = gettime() + var_9ac2a9920107bedc * 1000;
    
    while ( gettime() < end_time )
    {
        var_5419f30929711491 = 0;
        
        foreach ( player in level.players )
        {
            if ( player.b_completed_exfil && !player.b_exfil_fully_completed )
            {
                var_5419f30929711491 = 1;
                break;
            }
        }
        
        if ( !var_5419f30929711491 )
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace ob_exfil
// Params 0
// Checksum 0x5bd08f34, Offset: 0x1db5
// Size: 0x47
function processlobbydata()
{
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        if ( game_utility_mp::matchmakinggame() && !game_utility_mp::privatematch() )
        {
            setclientmatchdata( "isPublicMatch", 1 );
        }
        else
        {
            setclientmatchdata( "isPublicMatch", 0 );
        }
        
        sendclientmatchdata();
    }
}

// Namespace ob_exfil
// Params 0
// Checksum 0xb28fe235, Offset: 0x1e04
// Size: 0x185
function function_c5c0e1efe37f8b1b()
{
    backpacksize = common_inventory::function_9cd65c8312048802();
    backpackweapon = common_inventory::function_7bf60ff8870e96b4();
    weaponslist = self getweaponslistprimaries();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( i );
        params = spawnstruct();
        params.lootid = lootid;
        callback::callback( "item_exfiled", params );
    }
    
    foreach ( weapon in weaponslist )
    {
        variantid = weapon.variantid;
        
        if ( !isdefined( weapon.variantid ) )
        {
            variantid = 0;
        }
        
        rootname = weapon::getweaponrootname( weapon );
        ref = rootname;
        
        if ( variantid )
        {
            ref = rootname + "_v" + variantid;
        }
        
        lootid = common_item::items_getlootidfromref( ref );
        
        if ( lootid )
        {
            params = spawnstruct();
            params.weapon = weapon;
            params.lootid = lootid;
            callback::callback( "weapon_exfiled", params );
        }
    }
}

// Namespace ob_exfil
// Params 0
// Checksum 0x5bfb320f, Offset: 0x1f91
// Size: 0x257
function function_58014c16460ffa28()
{
    if ( !isdefined( level.acquisition_data ) )
    {
        function_95784bef27db072d();
    }
    
    backpacksize = common_inventory::function_9cd65c8312048802();
    backpackweapon = common_inventory::function_7bf60ff8870e96b4();
    
    if ( isdefined( backpackweapon ) )
    {
        itemname = item_weapon::function_3c60845f4139b91d( backpackweapon );
        
        if ( isdefined( itemname ) )
        {
            function_c1d0b38d58baa20d( common_item::function_b01955b20c77371d( itemname ) );
        }
    }
    
    weaponslist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponslist )
    {
        variantid = weapon.variantid;
        
        if ( !isdefined( weapon.variantid ) )
        {
            variantid = 0;
        }
        
        rootname = weapon::getweaponrootname( weapon );
        ref = rootname;
        
        if ( variantid )
        {
            ref = rootname + "_v" + variantid;
        }
        
        lootid = common_item::items_getlootidfromref( ref );
        function_c1d0b38d58baa20d( lootid );
    }
    
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "tactical" );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
    {
        lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        function_c1d0b38d58baa20d( lootid );
    }
    
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "lethal" );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
    {
        lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        function_c1d0b38d58baa20d( lootid );
    }
    
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "super" );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
    {
        lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        function_c1d0b38d58baa20d( lootid );
    }
    
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "killstreak" );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
    {
        lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        function_c1d0b38d58baa20d( lootid );
    }
}

// Namespace ob_exfil
// Params 0
// Checksum 0x3dbde7cd, Offset: 0x21f0
// Size: 0x14f
function function_95784bef27db072d()
{
    acquisitionlist = getscriptbundle( "acquisitionlist:acquisition_list_jup_ob" );
    
    if ( !isdefined( acquisitionlist ) )
    {
        return;
    }
    
    level.acquisition_data = [];
    level.schematic_data = [];
    
    foreach ( schematicentry in acquisitionlist.acquisitionlist )
    {
        if ( !isdefined( schematicentry.itembundle ) )
        {
            continue;
        }
        
        schematicbundle = getscriptbundle( schematicentry.itembundle );
        schematiclootid = common_item::function_779887309ec71dfe( schematicbundle );
        
        if ( !isdefined( schematiclootid ) )
        {
            continue;
        }
        
        level.schematic_data[ schematiclootid ] = schematicbundle;
        
        if ( !isdefined( schematicbundle.unlockedacquisition ) )
        {
            continue;
        }
        
        acquisitionbundle = getscriptbundle( schematicbundle.unlockedacquisition );
        acquisitionlootid = common_item::function_779887309ec71dfe( acquisitionbundle );
        
        if ( !isdefined( acquisitionlootid ) )
        {
            continue;
        }
        
        level.acquisition_data[ acquisitionlootid ] = acquisitionbundle;
    }
}

// Namespace ob_exfil
// Params 1
// Checksum 0x38611b13, Offset: 0x2347
// Size: 0xa5
function function_c1d0b38d58baa20d( lootid )
{
    if ( !isdefined( lootid ) || lootid < 1 )
    {
        return;
    }
    
    if ( !isdefined( level.schematic_data[ lootid ] ) )
    {
        return;
    }
    
    for ( i = 0; i < 10 ; i++ )
    {
        var_4554df64183a32a = self getplayerdata( level.outbreakdata, "squadMembers", "ownedAcquisitionSetup", i, "lootID" );
        
        if ( !isdefined( var_4554df64183a32a ) || var_4554df64183a32a == 0 )
        {
            self setplayerdata( level.outbreakdata, "squadMembers", "ownedAcquisitionSetup", i, "lootID", lootid );
            return;
        }
    }
}

// Namespace ob_exfil
// Params 1
// Checksum 0x6107cdec, Offset: 0x23f4
// Size: 0x19
function function_f335edf02e6fb9ee( relevant_info_struct )
{
    activity = self;
}

// Namespace ob_exfil
// Params 0
// Checksum 0x3af1c93b, Offset: 0x2415
// Size: 0xed
function get_backpack_items()
{
    if ( !isdefined( level.acquisition_data ) )
    {
        function_95784bef27db072d();
    }
    
    var_3bd74208532ff4af = [];
    var_91335465cea304c0 = [];
    var_42cf513a77bb356 = [];
    
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
        var_3bd74208532ff4af[ var_3bd74208532ff4af.size ] = lootid;
        
        if ( isdefined( lootid ) && lootid != 0 )
        {
            itembundle = common_item::function_b202b16941992cca( lootid );
            
            if ( isdefined( itembundle ) && itembundle.var_de7f3047419a5c39 )
            {
                if ( itembundle.subtype == "schematic" )
                {
                    var_42cf513a77bb356[ var_42cf513a77bb356.size ] = lootid;
                    continue;
                }
                
                if ( isdefined( level.acquisition_data[ lootid ] ) )
                {
                    var_91335465cea304c0[ var_91335465cea304c0.size ] = lootid;
                }
            }
        }
    }
    
    return [ var_3bd74208532ff4af, var_91335465cea304c0, var_42cf513a77bb356 ];
}

// Namespace ob_exfil
// Params 1
// Checksum 0x621ad978, Offset: 0x250b
// Size: 0x29b
function function_96b13be3ded29bab( var_80332670868723c3 )
{
    weapons = self getweaponslistall();
    
    foreach ( weapon in weapons )
    {
        rootname = weapon::getweaponrootname( weapon );
        variantid = weapon.variantid;
        
        if ( !isdefined( weapon.variantid ) )
        {
            variantid = 0;
        }
        
        ref = rootname;
        
        if ( variantid )
        {
            ref = rootname + "_v" + variantid;
        }
        
        lootid = common_item::items_getlootidfromref( ref );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    ref = equipment_mp::getcurrentequipment( "primary" );
    
    if ( isdefined( ref ) )
    {
        equipmentammo = equipment_mp::getequipmentslotammo( "primary" );
        lootid = loot::getlootidfromref( ref );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    ref = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( isdefined( ref ) )
    {
        equipmentammo = equipment_mp::getequipmentslotammo( "secondary" );
        lootid = loot::getlootidfromref( ref );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    ref = killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( ref ) )
    {
        lootid = loot::getlootidfromref( ref.streakname );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    if ( self.hasplatepouch )
    {
        lootid = loot::getlootidfromref( "armor_satchel" );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    if ( gasmask::hasgasmask( self ) )
    {
        lootid = loot::getlootidfromref( "gas_mask" );
        var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
    }
    
    itemname = self.equipment[ "health" ];
    itemcount = equipment_mp::getequipmentslotammo( "health" );
    
    if ( isdefined( itemname ) && isdefined( itemcount ) && itemcount > 0 )
    {
        for ( i = 0; i < itemcount ; i++ )
        {
            lootid = loot::getlootidfromref( level.armorref ?? "equip_armorplate" );
            var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
        }
    }
    
    if ( self.platecarrierlevel > 1 )
    {
        if ( self.platecarrierlevel == 2 )
        {
            lootid = loot::getlootidfromref( "brloot_plate_carrier_2" );
            var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
        }
        else if ( self.platecarrierlevel == 3 )
        {
            lootid = loot::getlootidfromref( "brloot_plate_carrier_3" );
            var_80332670868723c3[ var_80332670868723c3.size ] = lootid;
        }
    }
    
    return var_80332670868723c3;
}

// Namespace ob_exfil
// Params 2
// Checksum 0xa4da696d, Offset: 0x27af
// Size: 0x235
function function_e94f75fb46982689( player, exfiltype )
{
    current_team = "unset";
    
    if ( isdefined( player.sessionteam ) )
    {
        current_team = player.sessionteam;
    }
    
    if ( isdefined( player.team ) )
    {
        current_team = player.team;
    }
    
    [ var_3bd74208532ff4af, var_91335465cea304c0, var_42cf513a77bb356 ] = player get_backpack_items();
    var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( player.origin );
    var_80332670868723c3 = [];
    var_80332670868723c3 = player function_96b13be3ded29bab( var_80332670868723c3 );
    data = spawnstruct();
    data.player = player;
    data.current_team = current_team;
    data.x = player.origin[ 0 ];
    data.y = player.origin[ 1 ];
    data.z = player.origin[ 2 ];
    data.xrot = player.angles[ 0 ];
    data.yrot = player.angles[ 1 ];
    data.zrot = player.angles[ 2 ];
    data.matchtimeelapsed = int( game_utility_mp::getsecondspassed() );
    data.extractiontype = "0";
    data.var_8338cacd5176ae75 = player currency::get_currency_amount( #"essence" );
    data.backpackitems = var_3bd74208532ff4af;
    data.var_5a0720e8de1bf2c7 = var_91335465cea304c0;
    data.var_c1633cfffad9086d = var_42cf513a77bb356;
    data.loadoutitems = var_80332670868723c3;
    data.difficulty = var_8de44035c62f2f4f;
    data.exfiltype = exfiltype;
    telemetry_utils::function_af2d366f9522f76f( "callback_ob_on_exfil", data );
}

// Namespace ob_exfil
// Params 1
// Checksum 0xdcc6e4b8, Offset: 0x29ec
// Size: 0x5d2
function function_d1f3eea4316ea439( player )
{
    var_aa39aa89e16428af = currency::function_87fbe1244fd5eddd();
    
    if ( !( isdefined( var_aa39aa89e16428af ) && isdefined( isdefined( var_aa39aa89e16428af.var_6c5745cb9a2e94 ) ) ) )
    {
        player points::doscoreevent( #"dmz_extraction_bonus", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
        return;
    }
    
    var_322e5c49284238c1 = undefined;
    
    foreach ( var_45b18c4db2fd169e in var_aa39aa89e16428af.var_6c5745cb9a2e94 )
    {
        if ( var_45b18c4db2fd169e.currency == %"currency:jup_ob_essence" )
        {
            var_322e5c49284238c1 = var_45b18c4db2fd169e;
            break;
        }
    }
    
    assert( isdefined( var_322e5c49284238c1 ), "<dev string:xa2>" );
    schematiccount = 0;
    var_179c5ec24cf75338 = player armor::function_22290101992e4874();
    var_f75a49fb81d80fd = player currency::get_currency_amount( #"essence" );
    backpackindex = 0;
    
    while ( backpackindex < player common_inventory::function_9cd65c8312048802() )
    {
        lootid = player common_inventory::inventory_getlootidatbackpackindex( backpackindex );
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
        }
        else
        {
            quantity = player common_inventory::inventory_getquantityatbackpackindex( backpackindex );
            
            if ( !isdefined( quantity ) || quantity == 0 )
            {
            }
            else
            {
                bundle = common_item::function_b202b16941992cca( lootid );
                
                if ( !( isdefined( bundle ) && isdefined( bundle.ref ) ) )
                {
                }
                else
                {
                    var_f536224d4a72a0f = currency::function_9f81e184afb4d72b( bundle.ref );
                    
                    if ( isdefined( var_f536224d4a72a0f ) && isdefined( var_f536224d4a72a0f.value ) )
                    {
                        var_f75a49fb81d80fd += quantity * var_f536224d4a72a0f.value;
                    }
                    else if ( bundle.subtype == "schematic" )
                    {
                        schematiccount += 1;
                    }
                    else if ( !bundle.var_de7f3047419a5c39 )
                    {
                        var_179c5ec24cf75338 += bundle.var_2b0a27d4be7d298b ? 1 : quantity;
                    }
                }
            }
        }
        
        backpackindex += 1;
    }
    
    var_17aab47292667d7c = 0;
    ammomodcount = 0;
    var_b88a60109c9dae9d = 0;
    var_e30d90005029722c = 0;
    primaryweaponobj = player item_weapon::function_e7484276ad85f220( #"primary_0" );
    
    if ( isdefined( primaryweaponobj ) )
    {
        if ( weapon::iswonderweapon( primaryweaponobj ) )
        {
            var_e30d90005029722c += 1;
        }
        else
        {
            var_17aab47292667d7c += player item_weapon::function_fb81bd2fe070faa6( primaryweaponobj );
            var_b88a60109c9dae9d += player pack_a_punch::get_pap_level( primaryweaponobj );
            
            if ( player ammo_mod::has_ammo_mod( primaryweaponobj ) )
            {
                ammomodcount += 1;
            }
        }
    }
    
    secondaryweaponobj = player item_weapon::function_e7484276ad85f220( #"primary_1" );
    
    if ( isdefined( secondaryweaponobj ) )
    {
        if ( weapon::iswonderweapon( secondaryweaponobj ) )
        {
            var_e30d90005029722c += 1;
        }
        else
        {
            var_17aab47292667d7c += player item_weapon::function_fb81bd2fe070faa6( secondaryweaponobj );
            var_b88a60109c9dae9d += player pack_a_punch::get_pap_level( secondaryweaponobj );
            
            if ( player ammo_mod::has_ammo_mod( secondaryweaponobj ) )
            {
                ammomodcount += 1;
            }
        }
    }
    
    var_2f493ccccbf55051 = player zombie_perks::get_active_perks_str_array();
    var_afadeb717b493b6b = var_2f493ccccbf55051.size;
    extractionxp = player rank::getscoreinfoxp( #"dmz_extraction_bonus" ) ?? 0;
    var_12766f90b31fcdbb = schematiccount * ( var_aa39aa89e16428af.schematicsxp ?? 0 );
    var_3070e867622c2171 = var_179c5ec24cf75338 * ( var_aa39aa89e16428af.miscXp ?? 0 );
    rarityxp = var_17aab47292667d7c * ( var_aa39aa89e16428af.rarityxp ?? 0 );
    ammomodxp = ammomodcount * ( var_aa39aa89e16428af.ammomodxp ?? 0 );
    packapunchxp = var_b88a60109c9dae9d * ( var_aa39aa89e16428af.packapunchxp ?? 0 );
    wonderweaponxp = var_e30d90005029722c * ( var_aa39aa89e16428af.wonderweaponxp ?? 0 );
    var_2fbc80e2133aa33c = var_afadeb717b493b6b * ( var_aa39aa89e16428af.var_2fbc80e2133aa33c ?? 0 );
    var_9387e26b512d4608 = var_f75a49fb81d80fd * ( var_322e5c49284238c1.ratio ?? 0 );
    
    if ( isdefined( var_322e5c49284238c1.max ) && var_322e5c49284238c1.max != 0 )
    {
        var_9387e26b512d4608 = int( min( var_9387e26b512d4608, var_322e5c49284238c1.max ) );
    }
    
    player.var_f08336591b471edf = rarityxp + ammomodxp + packapunchxp;
    player points::doscoreevent( #"dmz_extraction_bonus", undefined, undefined, extractionxp + var_12766f90b31fcdbb + var_3070e867622c2171 + player.var_f08336591b471edf + wonderweaponxp + var_2fbc80e2133aa33c + var_9387e26b512d4608, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
    player.var_eb64e02eb122d6e2 = int( var_f75a49fb81d80fd * getdvarfloat( @"hash_eb99be1539a07c71", 0.1 ) );
    
    if ( common_instance_inventory::isenabled() )
    {
        i = 0;
        
        while ( i < 3 )
        {
            player common_instance_inventory::function_414fe7abd6cb9cdc( 5, i, player.var_eb64e02eb122d6e2 );
            i += 1;
        }
        
        i = 0;
        
        while ( i < 3 )
        {
            player common_instance_inventory::function_414fe7abd6cb9cdc( 6, i, player.var_eb64e02eb122d6e2 );
            i += 1;
        }
        
        if ( getdvarint( @"hash_b0b8d806784726d0", 1 ) )
        {
            i = 0;
            
            while ( i < 25 )
            {
                player common_instance_inventory::function_414fe7abd6cb9cdc( 11, i, player.var_eb64e02eb122d6e2 );
                i += 1;
            }
        }
    }
}

// Namespace ob_exfil
// Params 1
// Checksum 0x6982cc74, Offset: 0x2fc6
// Size: 0x2f, Type: bool
function function_e2a674af714aea99( overrideplaylist )
{
    if ( ( overrideplaylist ?? 0 ) > 0 )
    {
        return true;
    }
    
    if ( getdvarint( @"ob_map_transition_playlist", 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_exfil
// Params 6
// Checksum 0x7949b2dc, Offset: 0x2ffe
// Size: 0x1b6
function map_to_map_start( players, playlistid, var_205c545a5e2d10b3, binkcinematic, objective = 0, playagain = 0 )
{
    if ( function_e2a674af714aea99( playlistid ) )
    {
        if ( !isdefined( binkcinematic ) )
        {
            binkcinematic = getdvar( @"hash_ca08f59b64628422", "" );
        }
        
        if ( binkcinematic == "" )
        {
            binkcinematic = undefined;
        }
        
        map_to_map_cinematic( players, binkcinematic );
        
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player callback::callback( #"hash_8f04f402f9d538d4" );
            player.var_4b1f798ecbed7345 = !playagain;
            player.var_773876ee6a382571 = spawnstruct();
            
            if ( common_instance_inventory::isenabled() && !playagain )
            {
                player common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
                
                if ( !player.inventoryfinalized )
                {
                    player common_instance_inventory::function_8fd84f733b81e456();
                }
            }
            
            ob::function_82226ec4c6925388( player, 1 );
            logstring( "quest exfil MapToMapMatchmaking called for player " + player.name + " entnum " + player getentitynumber() + " playlistID: " + playlistid );
            player setplayerdata( level.var_6f9b00680ed002d8, "activeAvalonObjectiveIndex", objective );
        }
        
        function_ad739d35f90477ab( players, playlistid, undefined, var_205c545a5e2d10b3, objective );
    }
}

// Namespace ob_exfil
// Params 2, eflags: 0x4
// Checksum 0xefc6fed5, Offset: 0x31bc
// Size: 0x153
function private map_to_map_cinematic( players, binkcinematic )
{
    if ( !isdefined( binkcinematic ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player val::set( "map_to_map_cinematic", "world_fade", 1 );
        player val::set( "map_to_map_cinematic", "show_hud", 0 );
        player thread hud_util::fade_out( 0, level.var_8899b54bb25b4c92 ?? "black" );
        var_f9950c2c42c0c44c = binkcinematic;
        cineflags = 1107296256;
        
        if ( !level.var_d2cd3259bd5f8dcf && level.gamemodebundle.var_f5ac7b0c2eec9eb3 && getdvarint( @"hash_fad480b7b3734a97", 1 ) )
        {
            var_f9950c2c42c0c44c = level.gamemodebundle.var_f5ac7b0c2eec9eb3;
            cineflags |= 2;
        }
        
        player playcinematicforplayer( var_f9950c2c42c0c44c, 1, 0, cineflags );
    }
    
    waitframe();
}

// Namespace ob_exfil
// Params 1
// Checksum 0xe3a5b88c, Offset: 0x3317
// Size: 0x35, Type: bool
function function_391b310b880fab80( player )
{
    if ( player.var_4b1f798ecbed7345 )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"hash_f68809e89102fb57", 0 ) )
        {
            return true;
        }
    #/
    
    return false;
}

