// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_pluto_upgrade.gsc  (hash_0c649d2d9a8aa7eb.gscc) (size: 21043 Bytes / 0x5233 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8aae075d (2326660957)
// size ...... 21043 (0x5233)
// includes .. 17  (offset: 0x4baf)
// strings ... 53  (offset: 0x4c37)
// dev strs .. 52  (offset: 0x4fbb)
// exports ... 56  (offset: 0x2d77)
// cseg ...... 0x5b4 + 0x27c3 (0x2d77)
// imports ... 173 (offset: 0x3637)
// animtree1 . 0   (offset: 0x5233)
// animtree2 . 0   (offset: 0x5233)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ww_quest;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_firefly_script_pluto_upgrade;

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x5
// Checksum 0x6140acc1, Offset: 0x5d2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_pluto_upgrade", undefined, undefined, &init );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x8b219f8d, Offset: 0x5f3
// Size: 0x161
function private init()
{
    if ( !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_script_pluto_upgrade_cs_completed" );
    level.pluto_upgrade_quest = zm_quest::get_quest( #"firefly_pluto_upgrade" );
    level.pluto_upgrade_quest.key = #"firefly_pluto_upgrade";
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"reach_diner", &function_88f7b7a803898fa4, &function_c88a44f8fde4c6bb );
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"get_freezer_key", &function_88f7baa80389963d, &function_c88a45f8fde4c8ee );
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"pickup_abom_carcass", &function_88f7b9a80389940a, &function_c88a46f8fde4cb21 );
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"hash_173b92792d6221e1", &function_88f7b4a80389890b, &function_c88a47f8fde4cd54 );
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"pickup_mg_part", &function_88f7b3a8038986d8, &function_c88a48f8fde4cf87 );
    zm_quest::register_quest_step( #"firefly_pluto_upgrade", #"hash_173b93792d622394", &function_88f7b6a803898d71, &function_c88a49f8fde4d1ba );
    level callback::add( "quest_item_used", &function_134b765317c2aed6 );
    level thread pluto_upgrade_setup();
    
    /#
        thread function_d25da2a0f1e1a4e5();
        setup_devgui();
    #/
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x309e9d78, Offset: 0x75c
// Size: 0x52
function private pluto_upgrade_setup()
{
    level endon( #"game_ended" );
    level.pluto_upgrade = spawnstruct();
    level init_pluto_upgrade_assets();
    level zm_save::function_1f44a48caae2acbf();
    
    if ( namespace_af04127f48a0797a::function_24006873400b7a8() )
    {
        level utility::flag_wait( "europa_first_activation_finished" );
    }
    
    level thread zm_quest::start_quest( #"firefly_pluto_upgrade" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x97b4b58d, Offset: 0x7b6
// Size: 0xca
function private init_pluto_upgrade_assets()
{
    var_eb1cbe6d31019e91 = getent( "freezer_door_l", #targetname );
    var_eb1cc86d3101b48f = getent( "freezer_door_r", #targetname );
    clip_l = getent( "clip_freezer_door_l", #script_noteworthy );
    clip_r = getent( "clip_freezer_door_r", #script_noteworthy );
    
    if ( clip_l && var_eb1cbe6d31019e91 )
    {
        clip_l linkto( var_eb1cbe6d31019e91 );
        clip_l notsolid();
    }
    
    if ( clip_r && var_eb1cc86d3101b48f )
    {
        clip_r linkto( var_eb1cc86d3101b48f );
        clip_r notsolid();
    }
    
    level.pluto_upgrade.lock = getent( "pluto_upgrade_lock", "script_noteworthy" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xd732fbf2, Offset: 0x888
// Size: 0x4e
function private function_88f7b7a803898fa4( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    
    if ( b_save_restored )
    {
        return;
    }
    
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    level utility::flag_wait( "zone_exit115_diner_active" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xe319661a, Offset: 0x8de
// Size: 0x41
function private function_c88a44f8fde4c6bb( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped && !b_save_restored && level.wonder_veh )
        {
            level.wonder_veh zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
        }
    #/
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x29470f78, Offset: 0x927
// Size: 0x19f
function private function_88f7baa80389963d( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    level.var_40d4e79a4348918c = getdvarint( @"hash_122b428ec538d4d7", 0 );
    level.var_da6fc76b2f0d0594 = getdvarint( @"hash_e8f26a743f1b7a6a", 0 );
    
    if ( !level callback::exists( #"on_ai_killed", &zombie_kill_counter ) )
    {
        level callback::add( #"on_ai_killed", &zombie_kill_counter );
    }
    
    level callback::add( "on_round_start", &function_a7e0e1022cbc022c );
    common_item::function_13398f0f1186a3f8( "zmloot_quest_firefly_pluto_freezer_key", &function_b190a58d96c55ce6 );
    s_loc = utility::getstruct( "pluto_freezer_interact", "script_noteworthy" );
    
    if ( level namespace_af04127f48a0797a::function_24006873400b7a8() )
    {
        level.pluto_upgrade.var_151380b90be54a1c = zm_quest::function_91f9590e98d57ff6( s_loc.origin, &use_freezer_key, &function_57b79c71805bb1cb, "small" );
    }
    else
    {
        level.pluto_upgrade.var_151380b90be54a1c = zm_quest::function_91f9590e98d57ff6( s_loc.origin, &use_freezer_key, &function_57b79c71805bb1cb, "extrasmallnohint" );
    }
    
    if ( b_save_restored )
    {
        return;
    }
    
    b_get_key = zm_quest::function_73720cdf21c3cfd7( #"firefly_pluto_upgrade", #"get_freezer_key" );
    
    if ( b_get_key )
    {
        function_f9bde6174d271557( 3 );
        level utility::flag_set( "pickup_freezer_key" );
    }
    
    level utility::flag_wait( "pickup_freezer_key" );
    
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    level utility::flag_wait( "freezer_open" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xd8352b37, Offset: 0xace
// Size: 0x7c
function private function_c88a45f8fde4c8ee( b_skipped, b_save_restored )
{
    level callback::remove( "on_round_start", &function_a7e0e1022cbc022c );
    level callback::remove( #"on_ai_killed", &zombie_kill_counter );
    common_item::function_134b9624f3886a06( getxhashasset( "zmloot_quest_firefly_pluto_freezer_key" ), &function_b190a58d96c55ce6 );
    
    if ( b_skipped || b_save_restored )
    {
        function_f9bde6174d271557( 3 );
        level utility::flag_set( "pickup_freezer_key" );
        function_d87ff6b26179862f( 1 );
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1
// Checksum 0x701f08ea, Offset: 0xb52
// Size: 0x3e
function zombie_kill_counter( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( !isdefined( level.var_f9a8aeb32ab2105f ) )
        {
            level.var_f9a8aeb32ab2105f = 0;
        }
        
        level.var_f9a8aeb32ab2105f++;
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1
// Checksum 0x870c05fe, Offset: 0xb98
// Size: 0x59
function function_b190a58d96c55ce6( params )
{
    if ( level.pluto_upgrade.freezer_key )
    {
        level.pluto_upgrade.freezer_key freescriptable();
    }
    
    level.pluto_upgrade.freezer_key = params.item;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x538c92d1, Offset: 0xbf9
// Size: 0x26, Type: bool
function private should_drop_freezer_key()
{
    if ( level utility::flag( "drop_freezer_key" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "pickup_freezer_key" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1, eflags: 0x4
// Checksum 0xa3c4adae, Offset: 0xc28
// Size: 0x2f5
function private function_a7e0e1022cbc022c( params )
{
    level endon( #"game_ended" );
    level endon( #"on_round_end" );
    level endon( #"drop_freezer_key" );
    level endon( #"freezer_open" );
    
    if ( !level.pap_quest.completed )
    {
        return;
    }
    
    if ( !should_drop_freezer_key() )
    {
        return;
    }
    
    utility::flag_clear( "kill_the_zomibe" );
    
    if ( !level.var_40d4e79a4348918c )
    {
        while ( true )
        {
            if ( !( isdefined( level.var_f9a8aeb32ab2105f ) && isdefined( level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 ) ) )
            {
                wait 1;
                continue;
            }
            
            if ( level.var_f9a8aeb32ab2105f >= level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 / 2 )
            {
                break;
            }
            
            wait 1;
        }
    }
    
    percent = randomintrange( 1, 100 );
    
    if ( !level.var_da6fc76b2f0d0594 )
    {
        percent = 0;
    }
    
    utility::flag_wait( "zone_exit115_diner_active" );
    
    if ( percent <= 60 )
    {
        s_spawn_loc = utility::getstruct( "freezer_key_zombie_spawner", "script_noteworthy" );
        aitype = "sat_spawner_zombie_base_zm_firefly_cook";
        zombie = mp_agent::spawnnewagentaitype( aitype, s_spawn_loc.origin, s_spawn_loc.angles, "team_two_hundred" );
        
        if ( isdefined( zombie ) )
        {
            zombie.no_powerups = 1;
            zombie val::set( "firefly_pluto", "ignore_cleanup", 1 );
            zombie.ignore_enemy_count = 1;
            zombie.b_cleanup_no_respawn = 1;
            zombie.var_825b17c932865df = 1;
            zombie.b_ignore_cleanup = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.var_7ee152b43c7188e1 = 1;
            zombie.disable_brain_rot = 1;
            zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "zm_quest", 6 );
            zombie thread zone_spawner::function_ce10e453e7f7bb8e( s_spawn_loc );
            zombie thread zone_spawner::function_f9d3af30e993a949();
            zombie thread freezer_key_drop_check();
            level.pluto_upgrade.diner_zombie = zombie;
            utility::flag_set( "kill_the_zomibe" );
            level thread function_51f12524c830dd09();
        }
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1
// Checksum 0x7b59a50c, Offset: 0xf25
// Size: 0x14
function use_freezer_key( player )
{
    function_d87ff6b26179862f( 0 );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1
// Checksum 0x9e53fc71, Offset: 0xf41
// Size: 0xdc
function function_d87ff6b26179862f( b_save_restored )
{
    if ( !level utility::flag( "pickup_freezer_key" ) )
    {
        return;
    }
    
    level utility::flag_set( "freezer_open" );
    s_loc = utility::getstruct( "abom_carcass_itemspawn", "script_noteworthy" );
    level.pluto_upgrade.abom_carcass = zm_quest::spawn_quest_item( s_loc.origin, s_loc.angles, %"hash_7130b9e2c7db5079" );
    level.pluto_upgrade.abom_carcass.disable_dragged = 1;
    level thread open_freezer( 1, b_save_restored );
    
    if ( isdefined( level.pluto_upgrade.var_151380b90be54a1c ) )
    {
        level.pluto_upgrade.var_151380b90be54a1c zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2
// Checksum 0x767a5530, Offset: 0x1025
// Size: 0x108
function function_57b79c71805bb1cb( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "freezer_open" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "pickup_freezer_key" ) )
    {
        if ( level namespace_af04127f48a0797a::function_24006873400b7a8() )
        {
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_firefly_post/pluto_upgrade_step_4_hint", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2
// Checksum 0x20e429ef, Offset: 0x1136
// Size: 0x1cc
function open_freezer( duration, b_save_restored )
{
    var_eb1cbe6d31019e91 = getent( "freezer_door_l", #targetname );
    var_eb1cc86d3101b48f = getent( "freezer_door_r", #targetname );
    clip_l = getent( "clip_freezer_door_l", #script_noteworthy );
    clip_r = getent( "clip_freezer_door_r", #script_noteworthy );
    
    if ( level.pluto_upgrade.lock )
    {
        s_drop_loc = utility::getstruct( level.pluto_upgrade.lock.target );
        
        if ( b_save_restored )
        {
            level.pluto_upgrade.lock.origin = s_drop_loc.origin;
        }
        else
        {
            level.pluto_upgrade.lock zm_quest::fake_physicslaunch( s_drop_loc.origin, 120 );
        }
    }
    
    if ( !b_save_restored )
    {
        wait 0.5;
    }
    
    if ( var_eb1cbe6d31019e91 )
    {
        var_7319bc9fc568fd94 = ( var_eb1cbe6d31019e91.angles[ 0 ], 187, var_eb1cbe6d31019e91.angles[ 2 ] );
        
        if ( b_save_restored || duration <= 0 )
        {
            var_eb1cbe6d31019e91.angles = var_7319bc9fc568fd94;
        }
        else
        {
            var_eb1cbe6d31019e91 rotateto( var_7319bc9fc568fd94, duration );
        }
    }
    
    if ( !b_save_restored )
    {
        playsoundatpos( var_eb1cbe6d31019e91.origin + ( -5, -5, 10 ), "evt_zm_freezer_open" );
    }
    
    if ( !b_save_restored )
    {
        wait duration;
    }
    
    if ( clip_l )
    {
        clip_l solid();
    }
    
    if ( clip_r )
    {
        clip_r solid();
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0
// Checksum 0x2cbf19f0, Offset: 0x130a
// Size: 0x192
function freezer_key_drop_check()
{
    level endon( #"game_ended" );
    level endon( #"drop_freezer_key" );
    self waittill( #"death", attacker );
    
    if ( !should_drop_freezer_key() )
    {
        return;
    }
    
    v_drop = self.origin + ( 0, 0, 48 );
    droppoint = undefined;
    trigger = getent( "trigger_freezer_key_drop_check", "targetname" );
    
    if ( self.b_in_spawn_closet || trigger && self istouching( trigger ) )
    {
        s_loc = utility::getstruct( "freezer_key_default_drop" );
        droppoint = getclosestpointonnavmesh( s_loc.origin ) + ( 0, 0, 4 );
    }
    else
    {
        pos = self.origin + anglestoforward( self.angles ) * 10;
        droppoint = getclosestpointonnavmesh( pos ) + ( 0, 0, 4 );
    }
    
    if ( isplayer( attacker ) || isplayer( attacker.owner ) || isplayer( attacker.var_bd22ba6c600a23a3 ) || isplayer( attacker.europa.owner ) )
    {
        if ( zone_manager::function_ac62281be3d43322( droppoint, self ) )
        {
            level thread drop_freezer_key( v_drop, droppoint );
            playsoundatpos( v_drop, "uin_zm_common_drop_item_key" );
        }
    }
    
    level.pluto_upgrade.diner_zombie = undefined;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2
// Checksum 0xe3c5e3c6, Offset: 0x14a4
// Size: 0x65
function drop_freezer_key( position, droppoint )
{
    key = common_item::function_47324f290423b2d1( %"hash_12b4042050eae0dc", position, droppoint, 1, 1 );
    
    if ( !key )
    {
        return;
    }
    
    level utility::flag_set( "drop_freezer_key" );
    key thread function_1008e97d6b2bac68();
    key thread function_8ddb52991374fe39();
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1
// Checksum 0x7778a4cf, Offset: 0x1511
// Size: 0x82
function function_31e2ecdc9225e953( player )
{
    if ( player )
    {
        player playsoundtoplayer( "uin_zm_common_pickup_item_important", player );
    }
    
    if ( level utility::flag( "pickup_freezer_key" ) )
    {
        return;
    }
    
    function_f9bde6174d271557( 3 );
    
    if ( player )
    {
        zm_quest::show_splash_item_picked_up( #"pluto_upgrade", #"stage", 3, player );
    }
    
    level utility::flag_set( "pickup_freezer_key" );
    zm_quest::function_4eefe6de31f5ddab( #"firefly_pluto_upgrade", #"get_freezer_key", 1 );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x7f540a95, Offset: 0x159b
// Size: 0x42
function private function_8ddb52991374fe39()
{
    freezer_key = self;
    freezer_key endon( #"entitydeleted" );
    wait getdvarint( @"hash_7e4a47961c8f94ec", 300 );
    level notify( #"hash_c02e085edbd2452e" );
    common_item::function_869d7676e359a627( freezer_key );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa0f57c4e, Offset: 0x15e5
// Size: 0x37
function private function_1008e97d6b2bac68()
{
    level waittill( #"hash_c02e085edbd2452e" );
    level utility::flag_clear( "drop_freezer_key" );
    level.pluto_upgrade.freezer_key = undefined;
    level thread function_51f12524c830dd09();
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xb523defc, Offset: 0x1624
// Size: 0x54
function private function_88f7b9a80389940a( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    utility::registersharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb", &function_ae66dee91b378330 );
    
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "pickup_abom_carcass" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x916d682a, Offset: 0x1680
// Size: 0x83
function private function_c88a46f8fde4cb21( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped && !b_save_restored && level.wonder_veh )
        {
            level.wonder_veh zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
        }
    #/
    
    if ( b_skipped || b_save_restored )
    {
        if ( level.pluto_upgrade.abom_carcass )
        {
            thread common_item::function_869d7676e359a627( level.pluto_upgrade.abom_carcass );
        }
        
        function_b6a64d2755f80e2c();
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1, eflags: 0x4
// Checksum 0xd654cfdd, Offset: 0x170b
// Size: 0x5b
function private function_b6a64d2755f80e2c( player )
{
    function_f9bde6174d271557( 4 );
    
    if ( isdefined( player ) )
    {
        zm_quest::show_splash_item_picked_up( #"pluto_upgrade", #"stage", 4, player );
        player playsoundtoplayer( "fly_zm_item_pickup_generic", player );
    }
    
    level zm_sat_firefly_script_garage::function_51dc48d237696103();
    level utility::flag_set( "pickup_abom_carcass" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x400ea919, Offset: 0x176e
// Size: 0x14
function private function_ae66dee91b378330()
{
    if ( utility::flag( "pickup_abom_carcass" ) )
    {
        return 3;
    }
    
    return 0;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xda150081, Offset: 0x178b
// Size: 0xa8
function private function_88f7b4a80389890b( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread function_51f12524c830dd09();
    }
    
    level utility::flag_set( "pause_tessie_task_wvq_1" );
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) && ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" || level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" ) )
    {
        level val::set( "task_wvq", "task_logic_activate", 0 );
    }
    
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "upgraded_pluto_to_stage_" + 3 );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x47fc2d86, Offset: 0x183b
// Size: 0xef
function private function_c88a47f8fde4cd54( b_skipped, b_save_restored )
{
    utility::clearsharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb" );
    level utility::flag_clear( "pause_tessie_task_wvq_1" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_wvq", "task_logic_activate" );
    }
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "upgraded_pluto_to_stage_" + 3 );
        level.wonder_veh.stagerequested = 3;
        level zm_sat_firefly_script_garage::function_e3c9a4bcb7b0a8c2();
        
        if ( level utility::flag( "pause_tessie_task_wvq_1" ) )
        {
            level utility::flag_clear( "pause_tessie_task_wvq_1" );
            
            if ( !level val::get( "task_logic_activate" ) )
            {
                level val::set( "task_wvq", "task_logic_activate" );
            }
        }
    }
    
    level thread zm_quest::update_round_cap( 10 );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        function_d8a66fd0a435c488();
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0xe480aece, Offset: 0x1932
// Size: 0x198
function private function_d8a66fd0a435c488()
{
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"reach_diner" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_616dc070e68244c1" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_9bc4afb03d05d168" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"get_freezer_key" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"open_freezer" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"pickup_abom_carcass" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_173b92792d6221e1" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"reach_diner" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_616dc070e68244c1" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_9bc4afb03d05d168" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"get_freezer_key" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"open_freezer" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"pickup_abom_carcass" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"firefly_pluto_upgrade_guide", #"hash_173b92792d6221e1" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x29d8edfc, Offset: 0x1ad2
// Size: 0x46
function private function_88f7b3a8038986d8( b_skipped, b_save_restored )
{
    utility::registersharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb", &function_a6bd52ff5426ce61 );
    
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "mg_part_picked_up" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xe4b71226, Offset: 0x1b20
// Size: 0x2a
function private function_c88a48f8fde4cf87( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        function_62e5ff7e85e126a4( undefined, 1 );
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0xebe9fff9, Offset: 0x1b52
// Size: 0x185
function private function_62e5ff7e85e126a4( player, b_save_restored )
{
    function_f9bde6174d271557( 5 );
    level utility::flag_set( "mg_part_picked_up" );
    
    if ( !b_save_restored )
    {
        if ( isdefined( player ) )
        {
            zm_quest::show_splash_item_picked_up( #"pluto_upgrade", #"stage", 5, player );
            player playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", player );
        }
        
        overlord::playevent( #"hash_5d88defed742c38a", level.players );
        wait 1;
        
        if ( player )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"turret_barrel_response", #"bc_flavor_player_positive" );
        }
    }
    
    if ( level.firefly_main_quest.var_249df699cacaa6d3 )
    {
        destroynavobstacle( level.firefly_main_quest.var_249df699cacaa6d3 );
    }
    
    if ( !b_save_restored )
    {
        foreach ( other_player in level.players )
        {
            other_player thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_firefly_artifact_3" );
        }
        
        zm_quest::function_4eefe6de31f5ddab( #"firefly_pluto_upgrade", #"picked_up_mg_part", 1 );
    }
    
    level zm_sat_firefly_script_garage::function_8ec246c4c83d94a0();
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0xc098749, Offset: 0x1cdf
// Size: 0x14
function private function_a6bd52ff5426ce61()
{
    if ( utility::flag( "mg_part_picked_up" ) )
    {
        return 4;
    }
    
    return 0;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x948d8872, Offset: 0x1cfc
// Size: 0x9a
function private function_88f7b6a803898d71( b_skipped, b_save_restored )
{
    level utility::flag_set( "pause_tessie_task_wvq_2" );
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) && ( level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"ol_tessie_race" || level.var_8cff5e93e7f5e8.var_c2afe1a671205584 == #"hash_118650abf6b05f4f" ) )
    {
        level val::set( "task_wvq", "task_logic_activate", 0 );
    }
    
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "upgraded_pluto_to_stage_" + 4 );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 2, eflags: 0x4
// Checksum 0x5bb5aea9, Offset: 0x1d9e
// Size: 0xe1
function private function_c88a49f8fde4d1ba( b_skipped, b_save_restored )
{
    utility::clearsharedfunc( #"veh_pluto", #"hash_65c3903a874d7bdb" );
    level utility::flag_clear( "pause_tessie_task_wvq_2" );
    
    if ( !level val::get( "task_logic_activate" ) )
    {
        level val::set( "task_wvq", "task_logic_activate" );
    }
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "upgraded_pluto_to_stage_" + 4 );
        level.wonder_veh.stagerequested = 4;
        level zm_sat_firefly_script_garage::function_715b7b9d85eaa0b7();
        
        if ( level utility::flag( "pause_tessie_task_wvq_2" ) )
        {
            level utility::flag_clear( "pause_tessie_task_wvq_2" );
            
            if ( !level val::get( "task_logic_activate" ) )
            {
                level val::set( "task_wvq", "task_logic_activate" );
            }
        }
    }
    
    level utility::flag_set( "pluto_upgrade_finished" );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc7cee470, Offset: 0x1e87
// Size: 0x8d
function private function_134b765317c2aed6( params )
{
    itembundle = params.bundle;
    
    switch ( itembundle.ref )
    {
        case #"hash_7cd2afde7bd70cb":
            level function_31e2ecdc9225e953( self );
            break;
        case #"hash_ce630d7b3b29d61b":
            level function_b6a64d2755f80e2c( self );
            break;
        case #"hash_45b54c85d0730fc9":
            level function_62e5ff7e85e126a4( self );
            break;
        default:
            break;
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0
// Checksum 0xc9d8ac45, Offset: 0x1f1c
// Size: 0x441
function function_51f12524c830dd09()
{
    self notify( #"hash_c940db527c46200" );
    self endon( #"hash_c940db527c46200" );
    level endon( #"game_ended" );
    var_dd7c19dbdfeef2f2 = level.pluto_upgrade_quest.steps[ level.pluto_upgrade_quest.steps.size - 1 ];
    
    if ( var_dd7c19dbdfeef2f2.completed )
    {
        return;
    }
    
    while ( !level.firefly_ww_quest.started )
    {
        waitframe();
    }
    
    var_fa2fcbad5cf5ed09 = zm_quest::get_quest_step( level.pluto_upgrade_quest.ref, #"hash_173b92792d6221e1" );
    var_fa2fcbad5cf5ed09 endon( #"hash_2c4eefaf7e2b24b6" );
    level.pluto_upgrade_quest utility::ent_flag_waitopen_any( "block_update_guidance" );
    var_55523848b5db4b9e = level zm_quest::get_quest( #"europa_unlock_quest" );
    var_55523848b5db4b9e utility::ent_flag_wait( "zm_quest_completed" );
    quest_step = level.pluto_upgrade_quest.steps[ level.pluto_upgrade_quest.var_7be076c9078045aa ];
    ref = zm_quest::get_quest_relaxed( #"firefly_pluto_upgrade_guide" );
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    if ( level namespace_af04127f48a0797a::function_24006873400b7a8() )
    {
        if ( quest_step.ref == #"reach_diner" )
        {
            s_loc = utility::getstruct( "pluto_upgrade_abom_step1" );
            zm_quest::update_guidance( [ [ s_loc.origin, 150, s_loc.radius ] ], #"firefly_pluto_upgrade_guide", #"reach_diner" );
            return;
        }
        
        if ( quest_step.ref == #"get_freezer_key" )
        {
            if ( !utility::flag( "kill_the_zomibe" ) )
            {
                s_loc = utility::getstruct( "pluto_upgrade_abom_step2" );
                zm_quest::update_guidance( [ [ s_loc.origin, 0, s_loc.radius ], [ s_loc.origin, 100 ] ], #"firefly_pluto_upgrade_guide", #"hash_616dc070e68244c1", 1 );
            }
            else if ( utility::flag( "kill_the_zomibe" ) && !utility::flag( "drop_freezer_key" ) )
            {
                s_loc = utility::getstruct( "pluto_upgrade_abom_step2" );
                zm_quest::update_guidance( [ [ s_loc.origin, 0, s_loc.radius ], [ level.pluto_upgrade.diner_zombie, 70 ] ], #"firefly_pluto_upgrade_guide", #"hash_9bc4afb03d05d168", 1 );
            }
            else if ( !level utility::flag( "pickup_freezer_key" ) )
            {
                utility::delaythread( 1.5, &function_4671f74873a0bc1a );
            }
            else
            {
                zm_quest::update_guidance( [ [ level.pluto_upgrade.var_151380b90be54a1c, 0 ] ], #"firefly_pluto_upgrade_guide", #"open_freezer", 1 );
            }
            
            return;
        }
        
        if ( quest_step.ref == #"pickup_abom_carcass" )
        {
            hud_data = function_288fb21b76dbbe94( level.pluto_upgrade.abom_carcass, 0, undefined, level.pluto_upgrade.abom_carcass );
            zm_quest::update_guidance( hud_data, #"firefly_pluto_upgrade_guide", #"open_freezer" );
            return;
        }
        
        if ( quest_step.ref == #"hash_173b92792d6221e1" )
        {
            if ( zm_quest::function_625cc874b6861487( #"firefly_pluto_upgrade_guide", #"hash_173b92792d6221e1" ) )
            {
                return;
            }
            
            zm_quest::update_guidance( [ [ level.var_1b7735821fd80ddd.upgrade_station_sbl.interaction, 55 ] ], #"firefly_pluto_upgrade_guide", #"hash_173b92792d6221e1" );
        }
    }
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0x80921e0d, Offset: 0x2365
// Size: 0x72
function private function_4671f74873a0bc1a()
{
    if ( !level.pluto_upgrade.freezer_key )
    {
        return;
    }
    
    hud_data = function_288fb21b76dbbe94( level.pluto_upgrade.freezer_key, 2, undefined, level.pluto_upgrade.freezer_key );
    zm_quest::update_guidance( hud_data, #"firefly_pluto_upgrade_guide", #"get_freezer_key", 1 );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 0, eflags: 0x4
// Checksum 0xece5bb91, Offset: 0x23df
// Size: 0x1d, Type: bool
function private function_a54c943c42f71a87()
{
    if ( !level namespace_af04127f48a0797a::function_24006873400b7a8() )
    {
        return false;
    }
    
    if ( !zm_sat_firefly_ww_quest::is_ww_quest_complete() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 1, eflags: 0x4
// Checksum 0x43fcb532, Offset: 0x2405
// Size: 0x28
function private function_f9bde6174d271557( stage )
{
    zm_quest::function_b57dfe9625966b0b( #"pluto_upgrade", 0, #"stage", stage );
}

// Namespace zm_sat_firefly_script_pluto_upgrade
// Params 6, eflags: 0x4
// Checksum 0x92e5a411, Offset: 0x2435
// Size: 0x9a
function private function_288fb21b76dbbe94( var_8d3073d69d0ee3d1, offset = undefined, radius = undefined, var_895bdd0db4c4515 = undefined, str_label = undefined, var_7658622ac37ea4e5 = undefined )
{
    assert( var_8d3073d69d0ee3d1, "<dev string:x24>" );
    return [ [ var_8d3073d69d0ee3d1, offset, radius, str_label, var_7658622ac37ea4e5, var_895bdd0db4c4515 ] ];
}

/#

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x80075c16, Offset: 0x24d8
    // Size: 0xa3, Type: dev
    function private function_d25da2a0f1e1a4e5()
    {
        if ( level.pluto_upgrade.lock )
        {
            s_drop_loc = utility::getstruct( level.pluto_upgrade.lock.target );
            
            while ( true )
            {
                sphere( level.pluto_upgrade.lock.origin, 10, ( 1, 0, 0 ) );
                sphere( s_drop_loc.origin, 10, ( 0, 1, 1 ) );
                waitframe();
            }
        }
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x7f186076, Offset: 0x2583
    // Size: 0x146, Type: dev
    function private setup_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"firefly_pluto_upgrade" );
        devgui::add_devgui_func( "<dev string:x43>", "<dev string:x4e>", &function_3431b4fa2b5442f4 );
        devgui::add_devgui_func( "<dev string:x5d>", "<dev string:x7a>", &devgui_complete_pap );
        devgui::add_devgui_func( "<dev string:x8d>", "<dev string:xa7>", &function_a8104bad831767bf );
        devgui::add_devgui_func( "<dev string:xc7>", "<dev string:xda>", &function_5a603e3aeb3fd044 );
        devgui::add_devgui_func( "<dev string:xf3>", "<dev string:x105>", &function_22817b49a22b55b6 );
        devgui::add_devgui_func( "<dev string:x11d>", "<dev string:x132>", &function_7ee1910e9bdd9cfc );
        devgui::add_devgui_func( "<dev string:x14d>", "<dev string:x167>", &function_2ddfab42c88b7529 );
        devgui::add_devgui_func( "<dev string:x186>", "<dev string:x19e>", &function_a55822bb485ad859 );
        devgui::add_devgui_func( "<dev string:x1bc>", "<dev string:x1d0>", &function_da9d499ffa7af359 );
        devgui::add_devgui_func( "<dev string:x1ea>", "<dev string:x203>", &function_65cc2e37fbc078de );
        devgui::add_devgui_func( "<dev string:x222>", "<dev string:x203>", &function_36dfbe41b4bf88b8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x234>", "<dev string:x24b>" + "<dev string:x267>", &function_a8ea77390d3ddd6d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26b>", "<dev string:x283>" + "<dev string:x2a0>", &function_a8ea77390d3ddd6d );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0xc
    // Checksum 0xd1ea4c13, Offset: 0x26d1
    // Size: 0x166, Type: dev
    function private function_3431b4fa2b5442f4()
    {
        self notify( #"hash_eed281131ee1d3b0" );
        self endon( #"hash_eed281131ee1d3b0" );
        
        if ( level.var_9ac2ccd4800217b5 )
        {
            level notify( #"hash_1855e527140b3173" );
            level.var_9ac2ccd4800217b5 = undefined;
            return;
        }
        
        level.var_9ac2ccd4800217b5 = 1;
        level utility::flag_set( "<dev string:x2a5>" );
        iprintlnbold( "<dev string:x2bf>" );
        waitframe();
        devgui_complete_pap();
        iprintlnbold( "<dev string:x2df>" );
        level.var_40d4e79a4348918c = getdvarint( @"hash_122b428ec538d4d7", 0 );
        level.var_da6fc76b2f0d0594 = getdvarint( @"hash_e8f26a743f1b7a6a", 0 );
        function_a7e0e1022cbc022c();
        waitframe();
        function_a8104bad831767bf();
        level utility::flag_wait( "<dev string:x2ff>" );
        iprintlnbold( "<dev string:x30f>" );
        function_2ddfab42c88b7529();
        level utility::flag_wait( "<dev string:x32a>" );
        waitframe();
        function_a55822bb485ad859();
        level utility::flag_wait( "<dev string:x33b>" );
        iprintlnbold( "<dev string:x34e>" );
        function_da9d499ffa7af359();
        level utility::flag_wait( "<dev string:x369>" );
        waitframe();
        level notify( #"hash_3d67d894f2ef19e7" );
        iprintlnbold( "<dev string:x376>" );
        function_65cc2e37fbc078de();
        level utility::flag_wait( "<dev string:x38e>" );
        wait 2;
        iprintlnbold( "<dev string:x3a2>" );
        waitframe();
        function_22817b49a22b55b6();
        waitframe();
        function_7ee1910e9bdd9cfc();
        function_36dfbe41b4bf88b8();
        waitframe();
        function_5a603e3aeb3fd044();
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0xc
    // Checksum 0xe4fe2c4c, Offset: 0x283f
    // Size: 0xcd, Type: dev
    function private devgui_complete_pap()
    {
        self notify( #"hash_bc97dd2810dfd5f0" );
        self endon( #"hash_bc97dd2810dfd5f0" );
        
        while ( !level.pap_quest )
        {
            iprintlnbold( "<dev string:x3bc>" );
            waitframe();
        }
        
        if ( level.pap_quest.completed )
        {
            return;
        }
        
        iprintlnbold( "<dev string:x3d1>" );
        zm_quest::start_quest( #"firefly_pap_quest" );
        i = 0;
        
        while ( i < level.pap_quest.steps.size )
        {
            zm_quest::function_e65609834444650c( level.pap_quest.steps[ i ], 0 );
            i += 1;
        }
        
        level.pap_quest utility::ent_flag_wait( "<dev string:x3ee>" );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x92e76d26, Offset: 0x2914
    // Size: 0x44, Type: dev
    function private function_a8104bad831767bf()
    {
        player = level.players[ 0 ];
        player setorigin( ( -12161, 3532, 548 ) );
        player setplayerangles( ( 0, 131, 0 ) );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x8e8e0dd9, Offset: 0x2960
    // Size: 0x44, Type: dev
    function private function_5a603e3aeb3fd044()
    {
        player = level.players[ 0 ];
        player setorigin( ( 3977, -996, -270 ) );
        player setplayerangles( ( 0, 94, 0 ) );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x10f3d41b, Offset: 0x29ac
    // Size: 0xd, Type: dev
    function private function_22817b49a22b55b6()
    {
        level thread zm_sat_firefly_script_garage::function_4aaca8864b49d3b7();
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x38a4a42e, Offset: 0x29c1
    // Size: 0x21, Type: dev
    function private function_7ee1910e9bdd9cfc()
    {
        if ( level.wonder_veh )
        {
            level.wonder_veh thread zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
        }
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x8107cd7e, Offset: 0x29ea
    // Size: 0x3d, Type: dev
    function private function_2ddfab42c88b7529()
    {
        player = level.players[ 0 ];
        player thread function_4641de835d2d7cb( level.pluto_upgrade.diner_zombie, "<dev string:x401>" );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x36ab9bed, Offset: 0x2a2f
    // Size: 0x53, Type: dev
    function private function_a55822bb485ad859()
    {
        if ( level.pluto_upgrade.freezer_key )
        {
            player = level.players[ 0 ];
            player thread function_4641de835d2d7cb( level.pluto_upgrade.freezer_key, "<dev string:x267>" );
        }
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x211723b3, Offset: 0x2a8a
    // Size: 0x45, Type: dev
    function private function_da9d499ffa7af359()
    {
        player = level.players[ 0 ];
        var_69a65ef3de46fc95 = utility::getstruct( "<dev string:x414>", "<dev string:x42b>" );
        player thread function_4641de835d2d7cb( var_69a65ef3de46fc95, "<dev string:x43d>" );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0x8107cd7e, Offset: 0x2ad7
    // Size: 0x3d, Type: dev
    function private function_65cc2e37fbc078de()
    {
        player = level.players[ 0 ];
        player thread function_4641de835d2d7cb( level.pluto_upgrade.abom_carcass, "<dev string:x44b>" );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 0, eflags: 0x4
    // Checksum 0xd9015f7e, Offset: 0x2b1c
    // Size: 0x33, Type: dev
    function private function_36dfbe41b4bf88b8()
    {
        player = level.players[ 0 ];
        player thread function_4641de835d2d7cb( level.wonder_veh, "<dev string:x45e>" );
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 4, eflags: 0x4
    // Checksum 0xa0207485, Offset: 0x2b57
    // Size: 0x10c, Type: dev
    function private function_4641de835d2d7cb( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x464>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 10;
        }
        
        if ( !target )
        {
            return;
        }
        
        target endon( #"death_or_disconnect" );
        level endon( #"hash_1855e527140b3173" );
        level endon( #"hash_3d67d894f2ef19e7" );
        
        while ( true )
        {
            if ( !target || !target.origin || !self )
            {
                return;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, sphere_radius, color );
            print3d( target.origin, print_text + "<dev string:x465>" + length( target.origin - self.origin ) + "<dev string:x468>", color );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_pluto_upgrade
    // Params 1, eflags: 0x4
    // Checksum 0x2e233627, Offset: 0x2c6b
    // Size: 0x10c, Type: dev
    function private function_a8ea77390d3ddd6d( params )
    {
        var_b603a7fc89cd1871 = params[ 0 ];
        player = level.players[ 0 ];
        origin = player.origin + anglestoforward( player.angles ) * 30;
        
        switch ( var_b603a7fc89cd1871 )
        {
            case #"hash_4ece991e4b3621f6":
                origin = player.origin + anglestoforward( player.angles ) * 30;
                zm_quest::spawn_quest_item( origin, player.angles, %"hash_7130b9e2c7db5079" );
                break;
            case #"hash_55425b6c36803a4c":
                origin = player.origin + anglestoforward( player.angles ) * 30;
                zm_quest::spawn_quest_item( origin, player.angles, %"hash_12b4042050eae0dc" );
                break;
            default:
                break;
        }
    }

#/
