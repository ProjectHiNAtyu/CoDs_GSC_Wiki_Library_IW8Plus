// script_4be4569c1b7f442c  (hash_4be4569c1b7f442c.gscc) (size: 47577 Bytes / 0xb9d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f170795 (1595344789)
// size ...... 47577 (0xb9d9)
// includes .. 40  (offset: 0xa9bd)
// strings ... 196 (offset: 0xaafd)
// dev strs .. 56  (offset: 0xb715)
// exports ... 111 (offset: 0x6e09)
// cseg ...... 0x10ff + 0x5d0a (0x6e09)
// imports ... 340 (offset: 0x7f61)
// animtree1 . 0   (offset: 0xb9d9)
// animtree2 . 0   (offset: 0xb9d9)
#using script_16ea1b94f0f381b3;
#using script_43c750266ef75ab1;
#using script_5ad920020447a9f3;
#using script_71cef547a69e4a26;
#using scripts\anim\utility;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weapons;

#namespace namespace_7438d085a93b4787;

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x1
// Checksum 0x961eafeb, Offset: 0x111d
// Size: 0x1a4
function autoexec pre_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level.floating_island = spawnstruct();
    function_ae26d7da7391bd91();
    level thread function_f1b130bc22efd675();
    
    if ( getdvarint( @"hash_5dc136476678285c", 0 ) )
    {
        return;
    }
    
    level.var_24950bfd23e063a1 = &_precalcsafecirclecenters;
    
    /#
        level.var_9164c036b47a3ce8 = 0;
    #/
    
    level.var_256941f347945772 = [ br_circle::createinvalidcirclearea( ( 1802, 3385, 4800 ), 2500 ) ];
    level.brenableagents = 1;
    level.supportsai = 1;
    utility::registersharedfunc( #"gametype", #"hash_6c05b3acbd2dd56b", &function_243b287b5c7d8f0b );
    utility::registersharedfunc( #"respawn", #"nuke_all_values", &function_3111cbbac3f6c0f3 );
    utility::registersharedfunc( #"gametype", #"hash_7176c1a02c5f7181", &function_c5cd07d3aaa3f434 );
    utility::registersharedfunc( #"gametype", #"ongiveselectedclass", &function_ef09289df39952bb );
    utility::add_fx( "floating_island_cranked_portal_enter", "vfx_sat_levels_mp_saw_manticore_ee_eldritch_portal_player_cam_in" );
    utility::add_fx( "floating_island_cranked_portal_exit", "vfx_sat_levels_mp_saw_manticore_ee_eldritch_portal_player_cam_out" );
    game[ "dialog" ][ "respawn_as_zombie" ] = "dx_br_msmt_giin_haan_reaz";
    utility::registersharedfunc( #"zombie_damage", #"hash_35082172ddd8a685", &zombie_damage::handle_status_effects );
    callback::add( "smokeGrenade_playerGiveBlindeye", &function_d916bae096e090d5 );
    callback::add( "smokeGrenade_playerRemoveBlindeye", &function_4d1e80e942b6cc06 );
    weapons::deregisterusedcallback( "decoy_grenade" );
    weapons::registerusedcallback( "decoy_grenade", &function_12d3e6293a73c2b );
    level thread main();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xaafc6429, Offset: 0x12c9
// Size: 0x38b
function private main()
{
    utility::flag_wait( "load_main_completed" );
    
    /#
        level thread debug_init();
    #/
    
    level thread function_6ff293d64c33db84();
    function_ac4f9e5c3b5e3de3();
    init_infected_loadout();
    level.var_c998633bab11f3f8 = 1;
    level callback::add( #"player_death", &on_player_killed );
    level callback::add( "on_agent_spawned", &on_agent_spawned );
    level callback::add( #"on_ai_killed", &on_zombie_killed );
    level thread init_ai_director();
    level.floating_island.spawn_fx = spawn( "script_model", ( 1802, 3385, 4800 ) );
    level.floating_island.spawn_fx.angles = ( 0, 90, 0 );
    level.floating_island.spawn_fx setmodel( "mp_saw_manticore_s6_floating_island_spawn_fx" );
    level.floating_island.relic_sword_spawn_locations = utility::getstructarray( "relic_sword_spawn", "targetname" );
    level.floating_island.var_209dc77d85ab7a8e = utility::getstructarray( "relic_sword_spawn_random", "targetname" );
    level.floating_island.research_center_keypad_location = utility::getstruct( "floating_island_locked_door_research_center_keypad", "targetname" );
    level.floating_island.research_center_zombie_hand_locations = utility::getstructarray( "floating_island_locked_door_research_center_zombie_hand", "targetname" );
    level.floating_island.prelude_time = getdvarint( @"hash_6ac9b9f79f44c2bc", 25 );
    level.floating_island.prelude_duration = getdvarint( @"hash_68439cf7bbf4bb95", 25 );
    level.floating_island.var_1d22621caf0061be = getdvarfloat( @"hash_75b3b41924db8011", 0.125 );
    level.floating_island.var_1cff741caeda419c = getdvarfloat( @"hash_75d6c6192501ef5f", 0.5 );
    level.floating_island.var_2e8ee0248c5ec25e = getdvarint( @"hash_407dde9485db8dd8", 5000 );
    level.floating_island.var_24f5ffb955f4ff81 = getdvarint( @"hash_ff035c24f978578c", 225 );
    level.floating_island.powerup_locations = [];
    powerup_structs = utility::getstructarray( "powerup_spawn" );
    
    foreach ( powerup_struct in powerup_structs )
    {
        level.floating_island.powerup_locations[ int( powerup_struct.script_noteworthy ) ] = powerup_struct;
    }
    
    level.floating_island.powerups = [ "double_points", "full_ammo", "full_armor", "loot_master", "zombie_legs", "zombie_vision" ];
    level thread function_65489faa7324df0d();
    level thread function_e418395beec333f4();
    level thread runes_init();
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level thread portal_quest();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x45db22c2, Offset: 0x165c
// Size: 0x52
function private function_ac4f9e5c3b5e3de3()
{
    if ( !threatbiasgroupexists( "ai_zombies" ) )
    {
        createthreatbiasgroup( "ai_zombies" );
    }
    
    if ( !threatbiasgroupexists( "cranked_zombies" ) )
    {
        createthreatbiasgroup( "cranked_zombies" );
    }
    
    setignoremegroup( "cranked_zombies", "ai_zombies" );
    level.var_3d90777bfb7fc504 = [ "team_two_hundred" ];
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x12b77010, Offset: 0x16b6
// Size: 0x110
function private init_infected_loadout()
{
    loadouts = [];
    loadout_table = getscriptbundle( %"hash_35a1153733d0573" );
    
    foreach ( loadout_entry in loadout_table.classlist )
    {
        var_178ac71b8d3da156 = getscriptbundle( hashcat( %"classtableentry:", loadout_entry.entry ) );
        var_b662f7daaabd57ef = class::function_79947c7814a64d0e( var_178ac71b8d3da156 );
        loadouts[ loadout_entry.entry ] = var_b662f7daaabd57ef;
    }
    
    level.floating_island.infectedloadouts = loadouts;
    level.floating_island.infectedloadout = utility::array_random( loadouts );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x829e8e36, Offset: 0x17ce
// Size: 0x3f
function private function_243b287b5c7d8f0b( player )
{
    result = { #quickloadout:1, #noextraammo:0, #respawnloadout:build_loadout() };
    return result;
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x5a8b5d47, Offset: 0x1816
// Size: 0x27
function private function_3111cbbac3f6c0f3( player )
{
    if ( player.var_1b2a8a6efbdd4faa )
    {
        return;
    }
    
    player val::nuke_all();
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xf1a4aa6a, Offset: 0x1845
// Size: 0x28, Type: bool
function private function_c5cd07d3aaa3f434( deathdata )
{
    if ( deathdata.victim.iszombie )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x74a600ca, Offset: 0x1876
// Size: 0x9
function private function_ef09289df39952bb()
{
    function_7481a0611a8e4d9b();
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x4de7dd5e, Offset: 0x1887
// Size: 0x2b
function build_loadout()
{
    if ( self.iszombie )
    {
        return level.floating_island.infectedloadout;
    }
    
    return level.br_standard_loadout;
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0xbadf00b9, Offset: 0x18bb
// Size: 0x15c
function on_player_killed( params )
{
    if ( !isdefined( params.victim ) )
    {
        return;
    }
    
    params.victim.plotarmor = 0;
    
    if ( params.victim.iszombie )
    {
        function_571d12506f97730( params.victim );
        params.victim br_spawnrespawn::br_doingrespawn( 1 );
        params.victim.respawningbr = 0;
        params.victim notify( #"cranked_end" );
    }
    else
    {
        params.victim function_7481a0611a8e4d9b();
    }
    
    if ( !isdefined( params.attacker ) )
    {
        return;
    }
    
    if ( params.attacker.iszombie && params.attacker != params.victim )
    {
        params.attacker.cranked_time = min( params.attacker.cranked_time + getdvarint( @"hash_ec6aa91fa7ef03f7", 30000 ), getdvarint( @"hash_fb17ef6ad6b52e8f", 80000 ) );
    }
    
    spawn_wisp( params.victim );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x3f857460, Offset: 0x1a1f
// Size: 0x21
function private function_f1b130bc22efd675()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    function_9261f1829ad40fa1();
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xaea9a705, Offset: 0x1a48
// Size: 0x38
function private on_agent_spawned( params )
{
    agent = params.agent;
    agent set_default_tunings();
    agent setthreatbiasgroup( "ai_zombies" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x88001bdf, Offset: 0x1a88
// Size: 0x63
function private set_default_tunings()
{
    agent = self;
    agent.dontdroploot = 1;
    var_81a5a78b4d1c8ec = utility::array_random( [ "walk", "run", "sprint", "super_sprint" ] );
    agent zombie_utils::function_a8ce00e0448cb6f0( var_81a5a78b4d1c8ec, "zombie_movement_type", 1 );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x69ff3448, Offset: 0x1af3
// Size: 0x15
function private init_ai_director()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    ai_spawn_director::process_create_script();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x8e4e6395, Offset: 0x1b10
// Size: 0x1a
function private function_e418395beec333f4()
{
    level thread relic_sword_locked_room_bank();
    level thread relic_sword_locked_room_mansion();
    level thread relic_sword_locked_room_research_center();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xaf060bfb, Offset: 0x1b32
// Size: 0x268
function private relic_sword_locked_room_bank()
{
    if ( getdvarint( @"hash_746617b773d10edf" ) )
    {
        return;
    }
    
    level thread function_bb63d9c1a42c2281();
    level waittill( #"prematch_fade_done" );
    door = getent( "relic_sword_locked_door_bank", "targetname" );
    disc = getent( "relic_sword_locked_door_bank_lock_disc", "targetname" );
    clip = getent( "relic_sword_locked_door_bank_clip", "targetname" );
    housing = getent( "relic_sword_locked_door_bank_lock_housing", "targetname" );
    wheel_large = getent( "relic_sword_locked_door_bank_wheel_large", "targetname" );
    wheel_small = getent( "relic_sword_locked_door_bank_wheel_small", "targetname" );
    disc.interact = interaction::register_interact( disc.origin + anglestoforward( disc.angles ) * 10, 64, &function_d2845cc9074464f3 );
    disc.interact.angles = disc.angles;
    disc.interact interaction::set_interact_hint_callback( &function_70235c0a5611d6a7 );
    disc.interact.var_e763e623b92b45f = 0;
    level.floating_island.var_1fc3198c61440d45 = disc;
    level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c = 0;
    level.floating_island.var_ecbbeaf094072b73 = disc.interact;
    level waittill( #"hash_d95ce983e34bb4e9" );
    var_1d1d8330fc1e9201 = spawnscriptable( "mp_saw_manticore_s6_bank_wheels", wheel_large.origin );
    n_rotate_time = 6;
    wheel_large rotateroll( 1800, n_rotate_time, n_rotate_time / 4, n_rotate_time / 4 );
    wheel_small rotateroll( -1080, n_rotate_time, n_rotate_time / 4, n_rotate_time / 4 );
    wait n_rotate_time;
    var_1d1d8330fc1e9201 freescriptable();
    disc linkto( door, "tag_origin" );
    clip linkto( door, "tag_origin" );
    housing linkto( door, "tag_origin" );
    wheel_large linkto( door, "tag_origin" );
    wheel_small linkto( door, "tag_origin" );
    door rotateto( door.angles + ( 0, 100, 0 ), 4, 1, 1 );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x40c63c65, Offset: 0x1da2
// Size: 0x3e6
function private function_bb63d9c1a42c2281()
{
    n_code_0 = randomintrange( 0, 60 );
    n_code_1 = randomintrange( 0, 60 );
    n_code_2 = randomintrange( 0, 60 );
    
    /#
        level.n_code_0 = n_code_0;
        level.n_code_1 = n_code_1;
        level.n_code_2 = n_code_2;
    #/
    
    if ( isdefined( n_code_0 ) && isdefined( n_code_1 ) && isdefined( n_code_2 ) )
    {
        level.n_code_result = n_code_0 * 10000 + n_code_1 * 100 + n_code_2;
        var_e9e7d45068433fec = [ %"t10_zm_hand_drawn_digit_00", %"t10_zm_hand_drawn_digit_01", %"t10_zm_hand_drawn_digit_02", %"t10_zm_hand_drawn_digit_03", %"t10_zm_hand_drawn_digit_04", %"t10_zm_hand_drawn_digit_05", %"t10_zm_hand_drawn_digit_06", %"t10_zm_hand_drawn_digit_07", %"t10_zm_hand_drawn_digit_08", %"t10_zm_hand_drawn_digit_09" ];
        sticky_1 = utility::getstruct( "t10_zm_sticky_note_01", "targetname" );
        var_8b348a6feca1246d = int( n_code_0 / 10 );
        var_85b70ada7a314ceb = utility::getstruct( "sq_bank_vault_code_number_0_1_loc", "script_noteworthy" );
        var_8b34876feca11dd4 = n_code_0 % 10;
        var_549b32512bf7f6d6 = utility::getstruct( "sq_bank_vault_code_number_0_2_loc", "script_noteworthy" );
        
        /#
            level.floating_island.var_96ba7de8ae7f07fa = sticky_1;
        #/
        
        sticky_2 = utility::getstruct( "t10_zm_sticky_note_02", "targetname" );
        var_6752a9f3b3e0378a = int( n_code_1 / 10 );
        var_835ba283065eb090 = utility::getstruct( "sq_bank_vault_code_number_1_1_loc", "script_noteworthy" );
        var_6752a8f3b3e03557 = n_code_1 % 10;
        var_fd88063948709a81 = utility::getstruct( "sq_bank_vault_code_number_1_2_loc", "script_noteworthy" );
        
        /#
            level.floating_island.var_96ba7ce8ae7f05c7 = sticky_2;
        #/
        
        sticky_3 = utility::getstruct( "t10_zm_sticky_note_03", "targetname" );
        var_ea68381f08be4687 = int( n_code_2 / 10 );
        var_e604100244d5afad = utility::getstruct( "sq_bank_vault_code_number_2_1_loc", "script_noteworthy" );
        var_ea68391f08be48ba = n_code_2 % 10;
        var_edc6ac56a526d1dc = utility::getstruct( "sq_bank_vault_code_number_2_2_loc", "script_noteworthy" );
        
        /#
            level.floating_island.var_96ba7be8ae7f0394 = sticky_3;
        #/
        
        level waittill( #"prematch_fade_done" );
        utility::spawn_model( "t10_zm_sticky_note_01", sticky_1.origin, sticky_1.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_8b348a6feca1246d ], var_85b70ada7a314ceb.origin, var_85b70ada7a314ceb.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_8b34876feca11dd4 ], var_549b32512bf7f6d6.origin, var_549b32512bf7f6d6.angles );
        utility::spawn_model( "t10_zm_sticky_note_02", sticky_2.origin, sticky_2.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_6752a9f3b3e0378a ], var_835ba283065eb090.origin, var_835ba283065eb090.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_6752a8f3b3e03557 ], var_fd88063948709a81.origin, var_fd88063948709a81.angles );
        utility::spawn_model( "t10_zm_sticky_note_03", sticky_3.origin, sticky_3.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_ea68381f08be4687 ], var_e604100244d5afad.origin, var_e604100244d5afad.angles );
        utility::spawn_model( var_e9e7d45068433fec[ var_ea68391f08be48ba ], var_edc6ac56a526d1dc.origin, var_edc6ac56a526d1dc.angles );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xb781e6f6, Offset: 0x2190
// Size: 0x25b
function private function_d2845cc9074464f3( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( self.var_e763e623b92b45f || isdefined( level.var_720ac4c9a80008bc ) )
    {
        return;
    }
    
    level.var_720ac4c9a80008bc = player;
    self.var_e763e623b92b45f = 1;
    level notify( #"hash_48b3cdcb7d456ea3" );
    player callback::add( #"player_death", &function_34fede81b92459ab, self );
    utility::flag_set( "sq_bank_vault_lock_in_use" );
    player function_d6ba6881c16e8553();
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "allow_movement", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "crouch", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "prone", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "melee", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "offhand_primary_weapons", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "offhand_secondary_weapons", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "killstreaks", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "show_hud", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "freezecontrols", 1 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "ads", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "weapon_switch", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "action_slot_weapon", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "armor", 0 );
    player val::set( "relic_sword_locked_room_bank_unlock_mode", "supers", 0 );
    player setclientomnvar( "ui_safe_combination", level.n_code_result );
    player thread function_4436030c29a28efc();
    player thread function_effabe6bbbe43b05();
    player thread function_44b96ca1c1aafe96( self );
    player thread function_662236034e837363( self );
    player thread function_afb89efa4bbc3dad( self );
    player notifyonplayercommand( "lock_combo", "+movedown" );
    player notifyonplayercommand( "lock_combo", "+stance" );
    player notifyonplayercommand( "rotate_left", "+smoke" );
    player notifyonplayercommand( "rotate_left_done", "-smoke" );
    player notifyonplayercommand( "rotate_right", "+frag" );
    player notifyonplayercommand( "rotate_right_done", "-frag" );
    self.var_e763e623b92b45f = 1;
}

// Namespace namespace_7438d085a93b4787
// Params 2, eflags: 0x4
// Checksum 0xa29c4ac7, Offset: 0x23f3
// Size: 0x68
function private function_34fede81b92459ab( params, vault_interact )
{
    self setclientomnvar( "ui_safe_combination", -1 );
    vault_interact.var_e763e623b92b45f = 0;
    level.var_720ac4c9a80008bc = undefined;
    utility::flag_clear( "sq_bank_vault_lock_in_use" );
    callback::remove( #"player_death", &function_34fede81b92459ab, vault_interact );
    level notify( #"hash_b28eddaa277914a1" );
}

// Namespace namespace_7438d085a93b4787
// Params 2, eflags: 0x4
// Checksum 0xebe8f33c, Offset: 0x2463
// Size: 0xf8
function private function_70235c0a5611d6a7( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.var_e763e623b92b45f == 1 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( player.b_in_use_cooldown )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_t10_garnet/sq_bank_vault_unlock_vault", #type:"HINT_BUTTON" };
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x1d3714a0, Offset: 0x2564
// Size: 0x5e
function private function_d6ba6881c16e8553()
{
    if ( !self hasweapon( level.defaultfist ) )
    {
        inventory_utility::_giveweapon( level.defaultfist );
        self.var_968706b3bb83e564 = 1;
    }
    
    self.var_2778e8ec9bff3d71 = self getcurrentweapon();
    
    if ( self getcurrentweapon() != level.defaultfist )
    {
        self switchtoweapon( level.defaultfist );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x6cb06f78, Offset: 0x25ca
// Size: 0x123
function private function_4436030c29a28efc()
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    
    if ( self != level.var_720ac4c9a80008bc )
    {
        return;
    }
    
    origin = level.floating_island.var_ecbbeaf094072b73.origin;
    origin += anglestoforward( level.floating_island.var_ecbbeaf094072b73.angles ) * 30;
    origin = ( origin[ 0 ], origin[ 1 ], self.origin[ 2 ] );
    angles = -1 * anglestoforward( level.floating_island.var_ecbbeaf094072b73.angles );
    var_39ba2d0e5e19e1da = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self playerlinktodelta( var_39ba2d0e5e19e1da, "tag_origin", 0, 0, 0, 0, 0 );
    self.var_6e0e447abb442d13 = var_39ba2d0e5e19e1da;
    var_39ba2d0e5e19e1da rotateto( angles, 0.1 );
    wait 0.1;
    var_39ba2d0e5e19e1da moveto( origin, 0.1 );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x74f22da2, Offset: 0x26f5
// Size: 0x9b
function private function_effabe6bbbe43b05()
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ui_safe_dial_rotate" )
        {
            if ( value == 1 )
            {
                var_2fa2cc5f097dbff6 = 1;
                function_b5375441bbb4ac50( var_2fa2cc5f097dbff6 );
                continue;
            }
            
            if ( value == 0 )
            {
                var_2fa2cc5f097dbff6 = 0;
                function_b5375441bbb4ac50( var_2fa2cc5f097dbff6 );
            }
        }
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x19a0c511, Offset: 0x2798
// Size: 0x15e
function private function_b5375441bbb4ac50( var_3bebcac616237e4a )
{
    if ( var_3bebcac616237e4a )
    {
        level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c++;
        
        if ( level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c > 59 )
        {
            level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c = 0;
        }
        
        level.floating_island.var_1fc3198c61440d45 rotateroll( 6, 0.01, 0, 0 );
        utility::play_sound_in_space( "evt_zm_safe_dial_turn", level.mdl_dial.origin );
        return;
    }
    
    level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c--;
    
    if ( level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c < 0 )
    {
        level.floating_island.var_1fc3198c61440d45.var_8cb721201d46b96c = 59;
    }
    
    level.floating_island.var_1fc3198c61440d45 rotateroll( -6, 0.01, 0, 0 );
    utility::play_sound_in_space( "evt_zm_safe_dial_turn", level.floating_island.var_1fc3198c61440d45.origin );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x66b99fc3, Offset: 0x28fe
// Size: 0x13a
function private function_44b96ca1c1aafe96( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    self endon( #"death" );
    self endon( #"disconnect" );
    interact endon( #"deleted" );
    interact endon( #"death" );
    
    if ( self != level.var_720ac4c9a80008bc )
    {
        return;
    }
    
    self setclientomnvar( "ui_safe_combination", level.n_code_result );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ui_safe_combination_input" )
        {
            if ( value == 0 )
            {
                level notify( #"hash_d95ce983e34bb4e9" );
                interact thread function_58b439573979bcb();
            }
            else if ( value == 1 )
            {
                if ( isdefined( level.var_8a991ae9e18947c ) )
                {
                    level.var_8a991ae9e18947c setscriptablepartstate( "base", "sfx_combo_fail" );
                }
            }
            else if ( value == 2 )
            {
                if ( isdefined( level.var_8a991ae9e18947c ) )
                {
                    level.var_8a991ae9e18947c setscriptablepartstate( "base", "sfx_combo_fail" );
                }
            }
            
            if ( isdefined( self ) )
            {
                interact function_1cfd7a0976038307( self );
            }
        }
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xd5ecdf35, Offset: 0x2a40
// Size: 0x1a
function private function_58b439573979bcb()
{
    level endon( #"game_ended" );
    wait 0.2;
    self delete();
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xdc01c312, Offset: 0x2a62
// Size: 0x299
function private function_1cfd7a0976038307( player )
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    
    if ( isdefined( player ) )
    {
        player endon( #"death" );
        player endon( #"disconnect" );
    }
    
    self endon( #"deleted" );
    self endon( #"death" );
    
    if ( isdefined( player ) )
    {
        level thread function_632aa548584d0312( player );
    }
    
    level.var_720ac4c9a80008bc = undefined;
    
    if ( isdefined( self ) )
    {
        self.var_e763e623b92b45f = 0;
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_safe_combination", -1 );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "allow_movement" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "crouch" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "prone" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "melee" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "offhand_primary_weapons" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "offhand_secondary_weapons" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "show_hud" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "freezecontrols" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "ads" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "weapon_switch" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "action_slot_weapon" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "armor" );
        player val::reset( "relic_sword_locked_room_bank_unlock_mode", "supers" );
        player function_6f89d7ac27b9fabc();
        
        if ( isdefined( player.var_fe00a2404ce26ba ) )
        {
            player.var_fe00a2404ce26ba delete();
        }
        
        if ( isdefined( player.var_f84f64efdacb6ad3 ) )
        {
            player.var_f84f64efdacb6ad3 destroy();
        }
        
        if ( isdefined( player.var_795151d34683e1e5 ) )
        {
            player.var_795151d34683e1e5 destroy();
        }
        
        if ( isdefined( player.var_79514dd34683d919 ) )
        {
            player.var_79514dd34683d919 destroy();
        }
        
        player unlink();
        
        if ( isdefined( player.var_6e0e447abb442d13 ) )
        {
            player.var_6e0e447abb442d13 delete();
        }
        
        player setstance( "stand" );
        player notifyonplayercommandremove( "lock_combo", "+movedown" );
        player notifyonplayercommandremove( "lock_combo", "+stance" );
        player callback::remove( #"player_death", &function_34fede81b92459ab, self );
    }
    
    utility::flag_clear( "sq_bank_vault_lock_in_use" );
    level notify( #"hash_b28eddaa277914a1" );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x92636e00, Offset: 0x2d03
// Size: 0x2e
function private function_632aa548584d0312( player )
{
    level endon( #"game_ended" );
    wait 1;
    player val::reset( "relic_sword_locked_room_bank_unlock_mode", "killstreaks" );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x4a7db88c, Offset: 0x2d39
// Size: 0x71
function private function_662236034e837363( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    self endon( #"death" );
    self endon( #"disconnect" );
    interact endon( #"deleted" );
    interact endon( #"death" );
    
    while ( !self.inlaststand )
    {
        waitframe();
    }
    
    interact function_1cfd7a0976038307( self );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x644ebec8, Offset: 0x2db2
// Size: 0x3a
function private function_afb89efa4bbc3dad( interact )
{
    level endon( #"game_ended" );
    level endon( #"hash_b28eddaa277914a1" );
    self waittill( #"disconnect" );
    interact function_1cfd7a0976038307();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x7820f473, Offset: 0x2df4
// Size: 0x8e
function private function_6f89d7ac27b9fabc()
{
    if ( self.var_968706b3bb83e564 )
    {
        inventory_utility::_takeweapon( level.defaultfist );
    }
    
    self.var_968706b3bb83e564 = undefined;
    
    if ( isdefined( self.var_2778e8ec9bff3d71 ) && self hasweapon( self.var_2778e8ec9bff3d71 ) )
    {
        if ( self.var_2778e8ec9bff3d71 != level.defaultfist )
        {
            self switchtoweapon( self.var_2778e8ec9bff3d71 );
        }
    }
    else if ( val::get( "weapon" ) )
    {
        inventory_utility::forcevalidweapon();
    }
    
    self.var_2778e8ec9bff3d71 = undefined;
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x93f7d827, Offset: 0x2e8a
// Size: 0x1c
function private relic_sword_locked_room_mansion()
{
    level waittill( #"prematch_fade_done" );
    level waittill( #"hash_7e728dc7428edd18" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xf5991375, Offset: 0x2eae
// Size: 0x1fc
function private relic_sword_locked_room_research_center()
{
    if ( getdvarint( @"hash_9e8a085f7e935a94" ) )
    {
        return;
    }
    
    door = getentitylessscriptablearray( "relic_sword_locked_door_research_center", "targetname" )[ 0 ];
    door scriptabledoorfreeze();
    keypad = spawnscriptable( "mp_saw_manticore_s6_hand_scanner", level.floating_island.research_center_keypad_location.origin );
    keypad.angles = level.floating_island.research_center_keypad_location.angles;
    scriptable::scriptable_addusedcallbackbypart( "usable", &function_498a884c42c9d9af );
    level waittill( #"prematch_fade_done" );
    keypad setscriptablepartstate( "usable", "enabled" );
    zombie_hand_loc = utility::array_random( level.floating_island.research_center_zombie_hand_locations );
    spawn_options = common_item::function_bc5ff2958b71a708( zombie_hand_loc.origin, zombie_hand_loc.angles );
    spawn_options.critical = 1;
    spawn_options.var_17415ad785d0eab6 = "brloot_zombie_hand";
    zombie_hand = common_item::items_spawnitemfromscriptable( "brloot_zombie_hand", undefined, spawn_options );
    zombie_hand setscriptablepartstate( "brloot_zombie_hand", "visible_original_position_no_outline" );
    
    if ( isdefined( level.ghost_train.zombie_hand_tag ) )
    {
        zombie_hand scriptablesetparententity( level.ghost_train.zombie_hand_tag, ( 0, 0, 0 ), ( 0, -90, -45 ) );
        zombie_hand setscriptablepartstate( "brloot_zombie_hand", "hidden" );
    }
    
    level.floating_island.relic_sword_locked_door_research_center_zombie_hand = zombie_hand;
    level waittill( #"hash_e91a2d450128486" );
    door scriptabledoorunlock();
    door scriptabledooropen( "away", door.origin + anglestoforward( door.angles ) );
}

// Namespace namespace_7438d085a93b4787
// Params 6
// Checksum 0xae616bcb, Offset: 0x30b2
// Size: 0x1b3
function function_498a884c42c9d9af( instance, part, state, player, bautouse, usestring )
{
    if ( instance.type != "mp_saw_manticore_s6_hand_scanner" )
    {
        return;
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_zombie_hand" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_zombie_hand" );
        instance setscriptablepartstate( "usable", "off" );
        keypad_hand = utility::spawn_model( %"c_t10_zmb_amalgam_arm_top_le_gib_spawn", instance.origin + anglestoforward( instance.angles ) * 1 + anglestoright( instance.angles ) * 1 + ( 0, 0, -3 ), instance.angles + ( 0, 45, 90 ) );
        instance setscriptablepartstate( "sfx", "approve" );
        waitframe();
        instance setscriptablepartstate( "sfx", "off" );
        instance setscriptablepartstate( "body", "valid_hidden" );
        keypad_hand movez( -5, 1, 1 );
        keypad_hand waittill( #"movedone" );
        keypad_hand movez( -34, 0.35, 0.35 );
        keypad_hand rotateby( ( 20, 45, -90 ), 0.35 );
        level notify( #"hash_e91a2d450128486" );
        return;
    }
    
    instance setscriptablepartstate( "sfx", "deny" );
    waitframe();
    instance setscriptablepartstate( "sfx", "off" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xa05c981d, Offset: 0x326d
// Size: 0x1f
function private portal_quest()
{
    level thread relic_sword_spawns();
    function_3b4ec879a0f69929();
    function_12f14361539e240();
    function_444a2dbe059f2307();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xddec6d98, Offset: 0x3294
// Size: 0x35
function private function_3b4ec879a0f69929()
{
    wait 120 - level.floating_island.prelude_time;
    level thread function_c562d44d59a77866();
    wait level.floating_island.prelude_time;
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x611ac3b3, Offset: 0x32d1
// Size: 0x1a3
function private relic_sword_spawns()
{
    /#
        level.var_1e7542636a2f2e44 = [];
    #/
    
    random_loc = utility::array_random( level.floating_island.var_209dc77d85ab7a8e );
    level.floating_island.relic_sword_spawn_locations[ level.floating_island.relic_sword_spawn_locations.size ] = random_loc;
    
    foreach ( spawn_loc in level.floating_island.relic_sword_spawn_locations )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( spawn_loc.origin, spawn_loc.angles );
        spawn_options.critical = 1;
        spawn_options.var_17415ad785d0eab6 = "brloot_weapon_me_swhiskey_blood_moon";
        sword = common_item::items_spawnitemfromscriptable( "brloot_weapon_me_swhiskey_blood_moon", undefined, spawn_options );
        sword setscriptablepartstate( "brloot_weapon_me_swhiskey_unco", "visible_original_position" );
        
        if ( spawn_loc.script_noteworthy == "relic_sword_spawn_random_spin" )
        {
            level thread function_f4ec9fc6d2f5c390( sword );
        }
        
        /#
            level.var_1e7542636a2f2e44[ level.var_1e7542636a2f2e44.size ] = sword;
        #/
    }
    
    scriptable::function_9a667ada3074523a( &on_sword_pickup );
    
    /#
        if ( getdvarint( @"hash_5bed30c8277861df" ) )
        {
            function_93fd1892e12c55a9();
        }
    #/
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x81e30f0c, Offset: 0x347c
// Size: 0x84
function private function_f4ec9fc6d2f5c390( sword )
{
    level endon( #"game_ended" );
    mover = spawn( "script_model", sword.origin );
    sword scriptablesetparententity( mover, ( 0, 0, 0 ), sword.angles );
    
    while ( isdefined( sword ) )
    {
        mover rotateyaw( 1, level.framedurationseconds );
        wait level.framedurationseconds;
    }
    
    mover delete();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x2ab8843c, Offset: 0x3508
// Size: 0x10a
function private function_444a2dbe059f2307()
{
    /#
        if ( level.var_8ffa383f18744657 )
        {
            return;
        }
    #/
    
    level.relic_pedestal = spawnscriptable( "mp_saw_manticore_s6_pedestal", ( 1802, 3385, 5180 ) );
    level.relic_pedestal.angles = ( 0, 90, 0 );
    level.var_148e32faf33770ca = spawnscriptable( "mp_saw_manticore_s6_sword", ( 1802, 3385, 5230 ) );
    level.var_148e32faf33770ca.angles = ( 180, 0, 0 );
    level.var_148e32faf33770ca setscriptablepartstate( "model", "hidden" );
    var_cbf2696af3924e4b = level.relic_pedestal.origin + ( 0, 0, 40 );
    interact = interaction::register_interact( var_cbf2696af3924e4b, 60, &pedestal_used );
    interact interaction::set_interact_hint_callback( &pedestal_hint_callback );
    function_a25acb62ddab20e2( "manticore_s6_floating_island_enabled", 1 );
}

// Namespace namespace_7438d085a93b4787
// Params 6, eflags: 0x4
// Checksum 0x62258c8f, Offset: 0x361a
// Size: 0x91
function private on_sword_pickup( instance, part, state, player, bautouse, usestring )
{
    if ( isplayer( player ) && part == "brloot_weapon_me_swhiskey_unco" )
    {
        player function_7481a0611a8e4d9b();
        player.var_84226d9e12c3deef = player.var_cc1262e66dbb1c79;
        player.var_2584bf6454cbc727 = level.defaultfist;
        player.has_sword = 1;
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xeb2a9e51, Offset: 0x36b3
// Size: 0x15
function private function_7481a0611a8e4d9b()
{
    if ( self.has_sword )
    {
        function_d7e5de258a68e053();
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x31b27086, Offset: 0x36d0
// Size: 0x9e
function private function_d7e5de258a68e053()
{
    spawn_options = common_item::function_bc5ff2958b71a708( self.origin + ( 0, 0, 20 ), self.angles + ( 180, 0, 0 ) );
    spawn_options.critical = 1;
    spawn_options.var_17415ad785d0eab6 = "brloot_weapon_me_swhiskey_blood_moon";
    sword = common_item::items_spawnitemfromscriptable( "brloot_weapon_me_swhiskey_blood_moon", undefined, spawn_options );
    sword setscriptablepartstate( "brloot_weapon_me_swhiskey_unco", "visible_original_position" );
    self.var_2584bf6454cbc727 = undefined;
    self.has_sword = 0;
}

// Namespace namespace_7438d085a93b4787
// Params 2, eflags: 0x4
// Checksum 0xa4b242e3, Offset: 0x3776
// Size: 0x76
function private pedestal_hint_callback( interact, player )
{
    if ( player.currentweapon.basename == "jup_jp23_me_swhiskey_mp" )
    {
        return { #string:&"hash_60db48899b5e94c4", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xcda1c96d, Offset: 0x37f5
// Size: 0x111
function private pedestal_used( player )
{
    if ( player.currentweapon.basename != "jup_jp23_me_swhiskey_mp" )
    {
        return;
    }
    
    level notify( #"portal_start" );
    player inventory_utility::_takeweapon( player.currentweapon );
    player inventory_utility::forcevalidweapon();
    player inventory_utility::_giveweapon( player.var_84226d9e12c3deef );
    player weapon::function_b4c9549dee5d0fc5( player.var_84226d9e12c3deef );
    player item_weapon::function_92b8514cdacab7f9( player.var_84226d9e12c3deef );
    level.var_148e32faf33770ca setscriptablepartstate( "model", "visible" );
    level.relic_pedestal setscriptablepartstate( "interact", "unusable" );
    level.floating_island.active_team = player.team;
    player thread points::doscoreevent( #"hash_5dabe4ca75178a74" );
    player.var_2584bf6454cbc727 = undefined;
    player.has_sword = 0;
    level thread portal_start();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x3e0ae5f4, Offset: 0x390e
// Size: 0x1db
function private function_12f14361539e240()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.floating_island.spawn_fx ) )
    {
        level.floating_island.spawn_fx setscriptablepartstate( "fx", "on" );
    }
    
    setareaswaphint( "mp_saw_manticore_s6_island_areaswap", "floating_island_on" );
    wait 17.7;
    setareaswapstate( "mp_saw_manticore_s6_island_areaswap", "floating_island_on" );
    kill_range_sq = squared( 2000 );
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, ( 1802, 3385, 4800 ) + ( 0, 0, -500 ) ) < kill_range_sq )
        {
            player kill();
        }
    }
    
    if ( isdefined( level.floating_island.spawn_fx ) )
    {
        level.floating_island.spawn_fx setscriptablepartstate( "fx", "off" );
        level.floating_island.spawn_fx setscriptablepartstate( "icon", "on" );
    }
    
    earthquake( 0.65, 1.25, level.floating_island.spawn_fx.origin, 15000 );
    
    /#
        level.var_9164c036b47a3ce8 = 1;
    #/
    
    function_c57632b2e839e43a();
    level notify( #"jumppads_activate" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xa8cce74e, Offset: 0x3af1
// Size: 0x213
function private function_c562d44d59a77866()
{
    level endon( #"game_ended" );
    start_time = gettime();
    end_position = ( 1802, 3385, 5180 ) + ( 0, 0, -900 );
    i = 0;
    
    while ( i < level.floating_island.prelude_duration )
    {
        time = gettime();
        frac = ( time - start_time ) / level.floating_island.prelude_duration * 1000;
        interval = level.floating_island.var_1d22621caf0061be + ( 1 - frac ) * ( level.floating_island.var_1cff741caeda419c - level.floating_island.var_1d22621caf0061be );
        yaw = randomfloat( 360 );
        fwd = anglestoforward( ( 0, yaw, 0 ) );
        dist = randomfloat( 1 );
        dist = cos( dist ) * level.floating_island.var_2e8ee0248c5ec25e;
        start_position = ( 1802, 3385, 5180 ) + fwd * dist;
        start_position = physicstrace( start_position, start_position - ( 0, 0, 10000 ) );
        var_649b6ac53daadf1 = { #var_5ad6ed4b26dff15:1000, #var_5d158d4b296496b:600, #var_ee127104bc9c6f55:3, #var_ee355b04bcc286ab:1, #var_fedea4d74a277f7d:1.1, #var_e214531aba33043c:175 + 175 * frac, #var_e237411aba59245e:125 + 125 * frac, #speed_variance:0.3, #var_27f9b843b4cbcd9:300, #var_25c8d843b265657:200 };
        level thread function_e202f5a7f8d0e89f( start_position, end_position, var_649b6ac53daadf1 );
        wait interval;
        i += interval;
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x75328f18, Offset: 0x3d0c
// Size: 0x97
function private function_ae26d7da7391bd91()
{
    if ( isdefined( level.floating_island.spawn_fx ) )
    {
        level.floating_island.spawn_fx setscriptablepartstate( "fx", "off" );
    }
    
    setareaswapstate( "mp_saw_manticore_s6_island_areaswap", "floating_island_off" );
    
    if ( isdefined( level.floating_island.spawn_fx ) )
    {
        level.floating_island.spawn_fx setscriptablepartstate( "icon", "off" );
    }
    
    /#
        level.var_9164c036b47a3ce8 = 0;
    #/
    
    function_9261f1829ad40fa1();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x108f2193, Offset: 0x3dab
// Size: 0x170
function private portal_start()
{
    level notify( #"hash_34842d437efb8ba0" );
    level.floating_island.offering_circle = spawnscriptable( "quest_saw_floating_island_offering_circle", ( 1802, 3385, 5180 ), ( 0, 90, 0 ) );
    level.floating_island.offering_circle setscriptablepartstate( "quest_saw_floating_island_offering_circle", "on_inert" );
    level.floating_island.offering_active = 1;
    level.floating_island.var_96eb78ba5e9f3386 = 0;
    level.floating_island.souls_required = getdvarint( @"hash_ca92c4cfe505bb64", 50 );
    level.floating_island.var_1471d4de11223fd5 = level.floating_island.souls_required / 5;
    level.floating_island.var_d8eae5219c37a016 = 0;
    level.floating_island.var_c36a64fd02ee912d = 0;
    level.floating_island.offering_circle setscriptablepartstate( "quest_saw_floating_island_offering_circle", "on_activate" );
    runes_show();
    
    if ( !level callback::exists( #"respawns_disabled", &on_respawns_disabled ) )
    {
        level callback::add( #"respawns_disabled", &on_respawns_disabled );
    }
    
    wait 1;
    function_a25acb62ddab20e2( "manticore_s6_floating_island_holdout_enabled", 1 );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x75c2fe6b, Offset: 0x3f23
// Size: 0xa9
function private on_zombie_killed( params )
{
    params.eattacker thread points::doscoreevent( #"hash_a1d90917332e81f9" );
    f_roll = randomfloat( 1 );
    
    if ( f_roll < getdvarfloat( @"hash_37016c7c0f5a662e", 0.15 ) )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        common_item::function_38cde6a6acb68ea6( %"hash_161d50632b6b7864", getdvarint( @"hash_6f6325b27cae6725", 1 ), spawn_options );
    }
    
    spawn_wisp( params.victim );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x62e66b86, Offset: 0x3fd4
// Size: 0x88
function private spawn_wisp( victim )
{
    if ( !level.floating_island.offering_active )
    {
        return;
    }
    
    dist = distancesquared( victim.origin, ( 1802, 3385, 5180 ) );
    within_range = dist < 1000000;
    
    if ( within_range )
    {
        level thread function_e202f5a7f8d0e89f( victim, ( 1802, 3385, 5230 ) + ( 0, 0, 30 ) );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x4cbd651e, Offset: 0x4064
// Size: 0x26
function private on_respawns_disabled( params )
{
    if ( !getdvarint( @"hash_5505db8520106639", 0 ) )
    {
        return;
    }
    
    disable_portal();
}

// Namespace namespace_7438d085a93b4787
// Params 3, eflags: 0x4
// Checksum 0x57cfad33, Offset: 0x4092
// Size: 0x46b
function private function_e202f5a7f8d0e89f( start_position, end_position, var_649b6ac53daadf1 )
{
    level endon( #"game_ended" );
    var_25c8d843b265657 = var_649b6ac53daadf1.var_25c8d843b265657 ?? 40;
    var_27f9b843b4cbcd9 = var_649b6ac53daadf1.var_27f9b843b4cbcd9 ?? 60;
    speed_variance = var_649b6ac53daadf1.speed_variance ?? 0.2;
    var_e237411aba59245e = var_649b6ac53daadf1.var_e237411aba59245e ?? 250;
    var_e214531aba33043c = var_649b6ac53daadf1.var_e214531aba33043c ?? 350;
    var_fedea4d74a277f7d = var_649b6ac53daadf1.var_fedea4d74a277f7d ?? 1.1;
    var_ee355b04bcc286ab = var_649b6ac53daadf1.var_ee355b04bcc286ab ?? 1;
    var_ee127104bc9c6f55 = var_649b6ac53daadf1.var_ee127104bc9c6f55 ?? 3;
    var_5d158d4b296496b = var_649b6ac53daadf1.var_5d158d4b296496b ?? 30;
    var_5ad6ed4b26dff15 = var_649b6ac53daadf1.var_5ad6ed4b26dff15 ?? 50;
    
    if ( !isdefined( level.floating_island.var_c2f02e38c8454a9a ) )
    {
        level.floating_island.var_c2f02e38c8454a9a = [];
    }
    
    if ( !isvector( start_position ) )
    {
        start_position = start_position.origin + ( 0, 0, 50 );
    }
    
    vfx_root = utility::spawn_model( "quest_saw_floating_island_soul_wisp", start_position );
    vfx_root forcenetfieldhighlod( 1 );
    level.floating_island.var_c2f02e38c8454a9a[ level.floating_island.var_c2f02e38c8454a9a.size ] = vfx_root;
    start_position += ( 0, 0, 50 );
    vfx_root setscriptablepartstate( "quest_saw_floating_island_soul_wisp", "created" );
    vfx_root moveto( start_position, 1.5 );
    wait 1.5;
    vfx_root.angles = vectortoangles( end_position - start_position );
    var_4f58ae3108177d2c = distance( start_position, end_position );
    var_36340753cb0e64d5 = var_4f58ae3108177d2c / 10;
    speed = ( var_e214531aba33043c - var_e237411aba59245e ) * var_36340753cb0e64d5 + var_e237411aba59245e;
    speed += randomfloatrange( -1 * speed * speed_variance / 2, speed * speed_variance / 2 );
    
    if ( speed < var_e237411aba59245e )
    {
        speed = var_e237411aba59245e;
    }
    
    if ( speed > var_e214531aba33043c )
    {
        speed = var_e214531aba33043c;
    }
    
    duration = var_4f58ae3108177d2c / speed;
    start_timestamp = gettime();
    current_timestamp = start_timestamp;
    spiral_seed = randomint( 360 );
    spiral_frequency = randomfloatrange( var_ee355b04bcc286ab, var_ee127104bc9c6f55 );
    spiral_magnitude = randomintrange( var_5d158d4b296496b, var_5ad6ed4b26dff15 );
    var_37b66bef2ccb4209 = start_position[ 2 ] - end_position[ 2 ];
    
    if ( var_37b66bef2ccb4209 < var_27f9b843b4cbcd9 )
    {
        target_z_offset = randomintrange( var_25c8d843b265657, var_27f9b843b4cbcd9 ) + var_37b66bef2ccb4209 / 2;
    }
    else if ( var_37b66bef2ccb4209 < var_27f9b843b4cbcd9 * 2 )
    {
        target_z_offset = randomintrange( 0, var_25c8d843b265657 ) + var_37b66bef2ccb4209 / 2;
    }
    else
    {
        target_z_offset = randomintrange( -1 * var_25c8d843b265657, 0 ) + var_37b66bef2ccb4209 / 2;
    }
    
    lerp_value = 0;
    
    while ( lerp_value < 1 )
    {
        current_timestamp = gettime();
        spiral_angle = spiral_seed + spiral_frequency * lerp_value * 180;
        lerp_spiral_magnitude = sin( lerp_value * 180 ) * spiral_magnitude;
        var_83b5f6ccc840848e = rotatepointaroundvector( anglestoforward( vfx_root.angles ), lerp_spiral_magnitude * anglestoright( vfx_root.angles ), spiral_angle );
        target_position = vectorlerp( start_position, end_position, lerp_value ) + var_83b5f6ccc840848e;
        vfx_root.origin = target_position;
        lerp_value = pow( ( current_timestamp - start_timestamp ) / 1000 / duration, var_fedea4d74a277f7d );
        waitframe();
    }
    
    if ( level.floating_island.offering_active && !level.floating_island.var_c36a64fd02ee912d )
    {
        level thread function_78d2143ce22fdf75();
    }
    
    vfx_root setscriptablepartstate( "quest_saw_floating_island_soul_wisp", "off" );
    wait 2;
    level.floating_island.var_c2f02e38c8454a9a = arrayremove( level.floating_island.var_c2f02e38c8454a9a, vfx_root );
    vfx_root delete();
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x1f0df35e, Offset: 0x4505
// Size: 0x133
function private function_78d2143ce22fdf75()
{
    level.floating_island.var_96eb78ba5e9f3386++;
    
    if ( level.floating_island.var_96eb78ba5e9f3386 == level.floating_island.var_1471d4de11223fd5 )
    {
        level.floating_island.var_d8eae5219c37a016++;
        level.floating_island.offering_circle setscriptablepartstate( "quest_saw_floating_island_offering_circle", "on_progress_0" + level.floating_island.var_d8eae5219c37a016 );
        runes_activate( level.floating_island.var_d8eae5219c37a016 );
        level.floating_island.var_96eb78ba5e9f3386 = 0;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + level.floating_island.var_d8eae5219c37a016 );
    #/
    
    if ( level.floating_island.var_d8eae5219c37a016 >= 5 )
    {
        level.floating_island.offering_active = 0;
        level.floating_island.var_c36a64fd02ee912d = 1;
        level thread portal_open();
        
        /#
            iprintlnbold( "<dev string:x51>" );
        #/
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x7b6e7eed, Offset: 0x4640
// Size: 0xac
function private function_9261f1829ad40fa1()
{
    if ( !level.floating_island.caches.size )
    {
        function_90a7d10ce7ebbd56();
    }
    
    foreach ( cache in level.floating_island.caches )
    {
        cache setscriptablepartstate( "body", "hidden" );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x2ca65159, Offset: 0x46f4
// Size: 0xac
function private function_c57632b2e839e43a()
{
    if ( !level.floating_island.caches.size )
    {
        function_90a7d10ce7ebbd56();
    }
    
    foreach ( cache in level.floating_island.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xc02d66b0, Offset: 0x47a8
// Size: 0xe6
function private function_90a7d10ce7ebbd56()
{
    level.floating_island.caches = [];
    level.floating_island.caches = arraycombine( level.floating_island.caches, getlootscriptablearrayinradius( "br_loot_cache", undefined, ( 1802, 3385, 4800 ), 2500 ) );
    level.floating_island.caches = arraycombine( level.floating_island.caches, getlootscriptablearrayinradius( "br_loot_cache_lege", undefined, ( 1802, 3385, 4800 ), 2500 ) );
    level.floating_island.caches = arraycombine( level.floating_island.caches, getlootscriptablearrayinradius( "br_reusable_loot_cache", undefined, ( 1802, 3385, 4800 ), 2500 ) );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x83826b7c, Offset: 0x4896
// Size: 0x25a
function private portal_open()
{
    level endon( #"game_ended" );
    level endon( #"portal_close" );
    function_a25acb62ddab20e2( "manticore_s6_floating_island_holdout_enabled", 0 );
    level.floating_island.offering_circle setscriptablepartstate( "quest_saw_floating_island_offering_circle", "portal_open" );
    level.relic_pedestal setscriptablepartstate( "model", "hidden" );
    level.var_148e32faf33770ca setscriptablepartstate( "model", "hidden" );
    
    foreach ( player in teams::getteamdata( level.floating_island.active_team, "players" ) )
    {
        player thread points::doscoreevent( #"hash_62a7e5bfe4e43a18" );
        challenges::function_37e945722d6497f3( player, "manticore_sq_eldritch_gateway", 1 );
    }
    
    teamindex = function_f02c63b99c9614c9( level.allteamnamelist, level.floating_island.active_team );
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "quest_floating_island_portal_opened_splash", teamindex, undefined, undefined, undefined, "splash_list_saw_map_mp_saw_manticore_s6" );
    }
    
    wait 1;
    level.floating_island.portal_trigger = spawn( "noent_volume_trigger_box", ( 1802, 3385, 5230 ), 0, ( 30, 30, 30 ), ( 30, 30, 30 ) );
    level.floating_island.portal_trigger thread function_174f45d6fec5507b();
    level thread spawn_powerups();
    function_f99944dd37afce6();
    wait getdvarint( @"hash_170183562cbbcab3", 60 );
    reset_portal();
    level notify( #"portal_close" );
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x625638b3, Offset: 0x4af9
// Size: 0x149
function function_65489faa7324df0d()
{
    level endon( #"game_ended" );
    
    while ( !level.var_1bbb5557537e2c0c.size )
    {
        waitframe();
    }
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( magicbox.targetname ) && magicbox.targetname == "ghost_train_magicbox" )
        {
            continue;
        }
        
        magicbox.var_f14b2b4820b635e7 = 1;
        magicbox.var_dc41a51effa51e7f = ( 0, 90, 0 );
        magicbox.round_number_override = 2;
        magicbox.script_cost = 0;
        model = magicbox.mdl_magicbox;
        model setscriptablepartstate( "icon", "active" );
        model.interact setusableenabled( 1 );
        model hide();
        model setscriptablepartstate( "model_and_collision", "hide" );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x17cf5b48, Offset: 0x4c4a
// Size: 0x105
function function_f99944dd37afce6()
{
    if ( getdvarint( @"hash_536fb3fb4a15121" ) )
    {
        return;
    }
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( magicbox.targetname ) && magicbox.targetname == "ghost_train_magicbox" )
        {
            continue;
        }
        
        magicbox = magicbox.mdl_magicbox;
        
        if ( br_circle_util::function_3199bf5530fd0bc2( magicbox.origin ) )
        {
            magicbox show();
            magicbox setscriptablepartstate( "base", "closed" );
            magicbox setscriptablepartstate( "beam", "on" );
            magicbox setscriptablepartstate( "model_and_collision", "default" );
        }
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xdcf01857, Offset: 0x4d57
// Size: 0xb3
function function_6547cdc80ac4e9c3()
{
    if ( getdvarint( @"hash_536fb3fb4a15121" ) )
    {
        return;
    }
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( magicbox.targetname ) && magicbox.targetname == "ghost_train_magicbox" )
        {
            continue;
        }
        
        magicbox thread magicbox_hide();
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xf6b3bacd, Offset: 0x4e12
// Size: 0x55
function magicbox_hide()
{
    level endon( #"game_ended" );
    magicbox = self.mdl_magicbox;
    magicbox function_a4c865b88770031f();
    magicbox hide();
    magicbox setscriptablepartstate( "beam", "off" );
    magicbox setscriptablepartstate( "model_and_collision", "hide" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xef8654af, Offset: 0x4e6f
// Size: 0x25
function private function_a4c865b88770031f()
{
    level endon( #"game_ended" );
    
    while ( self getscriptablepartstate( "base" ) != "closed" )
    {
        waitframe();
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xfc1746b6, Offset: 0x4e9c
// Size: 0xce
function function_174f45d6fec5507b()
{
    level endon( #"game_ended" );
    level endon( #"portal_close" );
    level.floating_island.var_f70a8d72cc3ec113 = [];
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isdefined( ent.micontext ) && !ent.mutantinjectiontransformed )
        {
            continue;
        }
        
        ent_id = ent getentitynumber();
        
        if ( isdefined( level.floating_island.var_f70a8d72cc3ec113[ ent_id ] ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        level.floating_island.var_f70a8d72cc3ec113[ ent_id ] = ent;
        ent thread function_19399442296e3dc1( self );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0x492132, Offset: 0x4f72
// Size: 0x14d
function function_19399442296e3dc1( trigger )
{
    level endon( #"game_ended" );
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    self.plotarmor = 1;
    self setthreatbiasgroup( "cranked_zombies" );
    playfxontagforclients( utility::getfx( "floating_island_cranked_portal_enter" ), self, "j_head", self );
    wait 0.5;
    self playsoundevent( "sndevent_offering_circle_portal_enter_plr" );
    var_947bb4706c5ccfaa = hud_util::function_cd054751d2d5b5c5( "black" );
    var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( self, 0.3, 1, 1, 1 );
    
    if ( mutant_injection::function_d6b9b1acf8eafa70( self ) )
    {
        mutant_injection::function_bb20ab4f940b2b90( self );
        thread utility::callsharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", 1 );
        utility::waittill_any_timeout( 1, "returned_to_human" );
    }
    
    self.var_b23f28e56ad49c18 = { #revive:common_item::function_c4c43ebb7aa636dc( "revive" ), #plates:armor::function_22290101992e4874(), #armor:self.armorhealth };
    br::function_d8d054ee4230fa94();
    wait 1;
    self setscriptablepartstate( "haunting_portal_teleport", "on" );
    
    if ( player::isinlaststand( self ) )
    {
        thread laststand::exit( "last_stand_self_revive" );
    }
    
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    cranked_respawn();
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x6ef9775b, Offset: 0x50c7
// Size: 0x48
function cranked_respawn()
{
    self.iszombie = 1;
    self.var_55a095bcd9f557f6 = 1;
    self.respawningbr = 1;
    respawnstruct = init_respawn_struct( self.team );
    br_spawnrespawn::br_doingrespawn( 0, respawnstruct );
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0xd7d1a221, Offset: 0x5117
// Size: 0x7e
function init_respawn_struct( target_team )
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97();
    rs br_spawnrespawn::function_ffd4cf4c20eae881( &function_954fa763f6107263 );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( &function_247dffe548b468c1 );
    rs br_spawnrespawn::function_b9b32e1004a183cb( &zombie_on_respawn );
    rs.optparams.target_team = target_team;
    rs.skipbattlechatter = 1;
    rs.skipparachute = 1;
    return rs;
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0xa9eebe0d, Offset: 0x519e
// Size: 0x18f
function zombie_on_respawn( optparams )
{
    br_player_zombie::setup( 1 );
    val::set( #"br_player_zombie", "crate_use", 0 );
    val::set( #"br_player_zombie", "interactions", 0 );
    val::set( #"br_player_zombie", "item_pickup", 0 );
    val::set( #"br_player_zombie", "usability", 0 );
    val::set( #"br_player_zombie", "powerup_pickup", 0 );
    level thread br::updateplayerandteamcountui();
    self setthreatbiasgroup( "cranked_zombies" );
    self.plotarmor = 0;
    self.var_1b2a8a6efbdd4faa = 1;
    self.disabledropondeath = 1;
    ability_manager::assign_ability( "guts_throw", "tactical" );
    ability_manager::assign_ability( "emp_blast", "lethal" );
    ability_manager::assign_ability( "power_jump", "ads" );
    br_player_zombie::set_movespeed( 1.2 );
    perk::giveperk( "specialty_walljump_buffed" );
    self.maxhealth += level.floating_island.var_24f5ffb955f4ff81;
    self.health = self.maxhealth;
    thread br_player_zombie::set_radar();
    thread br_player_zombie::set_heatmap_radar();
    br_public::brleaderdialog( "respawn_as_zombie", 0, [ self ], 1, 1, undefined, "" );
    thread function_d99e773fa8ac14de();
    self setclientomnvar( "ui_cranked_meter_is_shown", 1 );
    playfxontagforclients( utility::getfx( "floating_island_cranked_portal_exit" ), self, "j_head", self );
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0x62007b47, Offset: 0x5335
// Size: 0x15, Type: bool
function function_954fa763f6107263( optparams )
{
    ability_manager::function_5e3b7fab0d6d1449();
    return true;
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0xe2b8a89, Offset: 0x5353
// Size: 0xc
function function_247dffe548b468c1( optparams )
{
    
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xb9bb5043, Offset: 0x5367
// Size: 0x10a
function function_d99e773fa8ac14de()
{
    level endon( #"game_ended" );
    self endon( #"cranked_end" );
    thread function_6bf08eaa9924391a();
    self setclientomnvar( "ui_cranked_timer_time_max", getdvarint( @"hash_31e43ba3489c1282", 80000 ) );
    self.cranked_time = getdvarint( @"hash_31e43ba3489c1282", 80000 );
    
    while ( self.cranked_time > 0 )
    {
        if ( !self.iszombie )
        {
            return;
        }
        
        self.cranked_time -= 100;
        self setclientomnvar( "ui_cranked_timer_time", self.cranked_time );
        self setclientomnvar( "ui_cranked_timer_time_max", getdvarint( @"hash_31e43ba3489c1282", 80000 ) );
        wait 0.1;
    }
    
    if ( !self.iszombie )
    {
        return;
    }
    
    function_571d12506f97730( self );
    val::set( "zombie", "weapon_pickup", 0 );
    br_spawnrespawn::br_doingrespawn( 0 );
    self.respawningbr = 0;
    self notify( #"cranked_end" );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x1206e39a, Offset: 0x5479
// Size: 0x9d
function private function_571d12506f97730( player )
{
    player br_player_zombie::reset_visuals();
    player.var_55a095bcd9f557f6 = 0;
    player br_player_zombie::setup( 0 );
    player setthreatbiasgroup();
    player val::reset( #"br_player_zombie", "crate_use" );
    player ability_manager::function_38de268b81340e01( "emp_blast" );
    player ability_manager::function_38de268b81340e01( "guts_throw" );
    player ability_manager::function_38de268b81340e01( "power_jump" );
    player br_player_zombie::set_movespeed( 1 );
    player perk::removeperk( "specialty_walljump_buffed" );
    player setclientomnvar( "ui_cranked_meter_is_shown", 0 );
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xc472ab46, Offset: 0x551e
// Size: 0xf3
function function_6bf08eaa9924391a()
{
    level endon( #"game_ended" );
    self waittill( #"naked_spawn" );
    val::nuke_all();
    perk::removeperk( "specialty_falldamage" );
    br::playerloadoutrestore();
    self.var_1b2a8a6efbdd4faa = 0;
    self waittill( #"hash_88b506e95217aeab" );
    armor::setarmorhealth( self.var_b23f28e56ad49c18.armor );
    armor::function_b359444c252374fc( self.var_b23f28e56ad49c18.plates );
    
    if ( self.var_b23f28e56ad49c18.revive )
    {
        bundle = getscriptbundle( self.var_b23f28e56ad49c18.revive.name );
        common_item::function_360e96e0447f17f9( bundle, self.var_b23f28e56ad49c18.revive.count );
    }
    
    self.var_b23f28e56ad49c18 = undefined;
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xcae1f1, Offset: 0x5619
// Size: 0x9c
function reset_portal()
{
    level.var_148e32faf33770ca setscriptablepartstate( "model", "hidden" );
    level.floating_island.offering_circle setscriptablepartstate( "quest_saw_floating_island_offering_circle", "portal_close" );
    level.relic_pedestal setscriptablepartstate( "model", "visible" );
    level.floating_island.offering_circle setscriptablepartstate( "circle_only", "off" );
    level.floating_island.portal_trigger delete();
    function_6547cdc80ac4e9c3();
    runes_deactivate();
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0xb0bdc490, Offset: 0x56bd
// Size: 0xb0
function disable_portal()
{
    level.floating_island.offering_active = 0;
    level callback::remove( #"respawns_disabled", &on_respawns_disabled );
    level.relic_pedestal setscriptablepartstate( "interact", "unusable" );
    level.floating_island.offering_circle setscriptablepartstate( "circle_only", "off" );
    
    if ( isdefined( level.floating_island.portal_trigger ) )
    {
        level.floating_island.portal_trigger delete();
    }
    
    function_6547cdc80ac4e9c3();
    runes_deactivate();
    level notify( #"portal_close" );
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x27777411, Offset: 0x5775
// Size: 0xd1
function spawn_powerups()
{
    level endon( #"game_ended" );
    level endon( #"portal_close" );
    level.floating_island.powerups = arrayrandomize( level.floating_island.powerups );
    
    for ( i = 0; i < level.floating_island.powerups.size ; i++ )
    {
        var_83e95f40e7d31ce8 = level.floating_island.powerup_locations[ i ];
        
        if ( !isdefined( var_83e95f40e7d31ce8 ) )
        {
            return;
        }
        
        powerup = level.floating_island.powerups[ i ];
        namespace_9d8e359c3b1041e5::droppowerupsharedfunc( powerup, var_83e95f40e7d31ce8.origin );
        wait 5;
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x681d2578, Offset: 0x584e
// Size: 0x5bb
function _precalcsafecirclecenters()
{
    corrected_center = ( -1111, 3333, 0 );
    
    /#
        if ( getdvarint( @"hash_208c8b3c89e6b2c1" ) )
        {
            debug::cylinder( ( 1802, 3385, 4800 ), ( 1802, 3385, 4800 ) + ( 0, 0, 1 ), 2500, "<dev string:x67>" );
            debug::sphere( ( -4000, 4500, 0 ) );
            debug::sphere( ( 7000, 3900, 0 ) );
            debug::sphere( ( 5700, -1900, 0 ) );
            debug::cylinder( ( -4000, 4500, 0 ), ( -4000, 4500, 0 ) + ( 0, 0, 1 ), 8000 );
            debug::cylinder( ( 7000, 3900, 0 ), ( 7000, 3900, 0 ) + ( 0, 0, 1 ), 5000 );
            debug::cylinder( ( 5700, -1900, 0 ), ( 5700, -1900, 0 ) + ( 0, 0, 1 ), 4000 );
        }
    #/
    
    weight_a = 3.0615 * squared( 8000 );
    weight_b = 2.9045 * squared( 5000 );
    weight_c = 2.8731 * squared( 4000 );
    weight_total = weight_a + weight_b + weight_c;
    var_c9034d7b102d7293 = undefined;
    roll = randomfloat( weight_total );
    
    if ( roll < weight_a )
    {
        var_c9034d7b102d7293 = { #radius:8000, #origin:( -4000, 4500, 0 ) };
    }
    else
    {
        roll -= weight_a;
        
        if ( roll < weight_b )
        {
            var_c9034d7b102d7293 = { #radius:5000, #origin:( 7000, 3900, 0 ) };
        }
        else
        {
            var_c9034d7b102d7293 = { #radius:4000, #origin:( 5700, -1900, 0 ) };
        }
    }
    
    level.br_circle.br_finalcircleoverride = var_c9034d7b102d7293.origin + anglestoforward( ( 0, randomfloat( 360 ), 0 ) ) * cos( randomfloat( 360 ) ) * var_c9034d7b102d7293.radius;
    level.br_level.br_circlecenters = [];
    level.br_level.br_circlecenters[ 0 ] = corrected_center;
    level.var_fbd5de3a03b0c767 = level.br_level.br_circlecenters[ 0 ];
    var_f5661efe10a6d8d5 = getdvarint( @"hash_67a8c844bad5a45b", 0 );
    
    if ( !var_f5661efe10a6d8d5 && br_gametypes::isfeatureenabled( #"circlesnaptonavmesh" ) )
    {
        var_f5661efe10a6d8d5 = 1;
    }
    
    lastcircleindex = level.br_level.br_circleradii.size - level.br_level.br_movingcirclecount + 1;
    centerx = level.br_circle.br_finalcircleoverride[ 0 ];
    centery = level.br_circle.br_finalcircleoverride[ 1 ];
    level.br_level.br_circlecenters[ lastcircleindex ] = br_public::droptogroundmultitrace( ( centerx, centery, 4000 ) );
    level.br_level.br_circlecenters[ 1 ] = corrected_center + anglestoforward( ( 0, randomfloat( 360 ), 0 ) ) * randomfloat( 3000 );
    level.br_level.br_circlecenters[ 2 ] = ( level.br_level.br_circlecenters[ 1 ] + ( 1802, 3385, 4800 ) ) / 2 + anglestoforward( ( 0, randomfloat( 360 ), 0 ) * 2000 );
    level.br_level.br_circlecenters[ 3 ] = ( 1802, 3385, 4800 ) + vectornormalize( level.br_circle.br_finalcircleoverride - ( 1802, 3385, 4800 ) ) * abs( level.br_level.br_circleradii[ 3 ] - 2500 );
    
    for ( i = 4; i <= lastcircleindex ; i++ )
    {
        level.br_level.br_circlecenters[ i ] = level.br_level.br_circlecenters[ i - 1 ] + ( level.br_circle.br_finalcircleoverride - level.br_level.br_circlecenters[ i - 1 ] ) / 2;
        var_becd52aec83a4887 = anglestoright( vectortoangles( level.br_level.br_circlecenters[ i ] - level.br_level.br_circlecenters[ i - 1 ] ) );
        var_becd52aec83a4887 *= randomfloatrange( -1 * level.br_level.br_circleradii[ i ] / 3, level.br_level.br_circleradii[ i ] / 3 );
        level.br_level.br_circlecenters[ i ] += var_becd52aec83a4887;
    }
    
    level notify( #"calc_circle_centers" );
    utility::flag_set( "calc_circle_centers" );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x980b733e, Offset: 0x5e11
// Size: 0x22c
function private runes_init()
{
    level.floating_island.var_3f4c022573e134b = [];
    a_s_runes = utility::getstructarray( "floating_island_portal_rune" );
    
    foreach ( s in a_s_runes )
    {
        if ( !isdefined( level.floating_island.var_3f4c022573e134b[ s.script_noteworthy ] ) )
        {
            level.floating_island.var_3f4c022573e134b[ s.script_noteworthy ] = [];
        }
        
        scriptable = spawnscriptable( "mp_saw_manticore_s6_floating_island_rune", s.origin );
        scriptable.angles = s.angles;
        level.floating_island.var_3f4c022573e134b[ s.script_noteworthy ][ level.floating_island.var_3f4c022573e134b[ s.script_noteworthy ].size ] = scriptable;
    }
    
    level.floating_island.var_3f4c022573e134b[ "rune_north" ] = arrayrandomize( level.floating_island.var_3f4c022573e134b[ "rune_north" ] );
    level.floating_island.var_3f4c022573e134b[ "rune_east" ] = arrayrandomize( level.floating_island.var_3f4c022573e134b[ "rune_east" ] );
    level.floating_island.var_3f4c022573e134b[ "rune_south" ] = arrayrandomize( level.floating_island.var_3f4c022573e134b[ "rune_south" ] );
    level.floating_island.var_3f4c022573e134b[ "rune_west" ] = arrayrandomize( level.floating_island.var_3f4c022573e134b[ "rune_west" ] );
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x2b204050, Offset: 0x6045
// Size: 0xe6
function private runes_show()
{
    foreach ( array in level.floating_island.var_3f4c022573e134b )
    {
        var_3f4c022573e134b = arrayrandomize( [ 1, 2, 3, 4, 5 ] );
        
        for ( i = 0; i < 5 ; i++ )
        {
            state = var_3f4c022573e134b[ i ] + "_inactive";
            array[ i ] setscriptablepartstate( "rune", state );
        }
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x4a25527e, Offset: 0x6133
// Size: 0x99
function private runes_activate( progress_state )
{
    foreach ( array in level.floating_island.var_3f4c022573e134b )
    {
        array[ progress_state - 1 ] rune_set_state( "active" );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xc7458569, Offset: 0x61d4
// Size: 0x119
function private runes_deactivate()
{
    foreach ( array in level.floating_island.var_3f4c022573e134b )
    {
        foreach ( rune in array )
        {
            if ( issubstr( rune getscriptablepartstate( "rune" ), "inactive" ) )
            {
                rune rune_set_state( "inactive_despawn" );
                continue;
            }
            
            rune rune_set_state( "active_despawn" );
        }
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x714e9e56, Offset: 0x62f5
// Size: 0x3e
function private rune_set_state( state )
{
    index = self getscriptablepartstate( "rune" )[ 0 ];
    state = index + "_" + state;
    self setscriptablepartstate( "rune", state );
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x1b1c6cda, Offset: 0x633b
// Size: 0x79
function private function_d916bae096e090d5( params )
{
    if ( params.time_left > 0 )
    {
        smoke_end_time = gettime() + utility::function_4b74c15943231980( params.time_left );
        
        if ( !isdefined( self.smoke_end_time ) )
        {
            self.smoke_end_time = smoke_end_time;
            thread function_a8cb0626ab4cd31c();
            return;
        }
        
        self.smoke_end_time = max( self.smoke_end_time, smoke_end_time );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0x712f38df, Offset: 0x63bc
// Size: 0x93
function private function_a8cb0626ab4cd31c()
{
    self endon( #"disconnect" );
    
    while ( isalive( self ) && gettime() < self.smoke_end_time )
    {
        zombiearray = getaiarrayinradius( self.origin, 60, "team_two_hundred" );
        noenemynearby = zombiearray.size == 0;
        val::set( "smokegrenade", "ignoreme", noenemynearby );
        wait 0.5;
    }
    
    self.smoke_kills = 0;
    val::reset_all( "smokegrenade" );
    self.smoke_end_time = undefined;
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0xa6676f, Offset: 0x6457
// Size: 0x2a
function private function_4d1e80e942b6cc06( params )
{
    if ( !isdefined( self.perks[ "specialty_blindeye" ] ) )
    {
        self.smoke_end_time = undefined;
    }
}

// Namespace namespace_7438d085a93b4787
// Params 1, eflags: 0x4
// Checksum 0x70f0f301, Offset: 0x6489
// Size: 0x13b
function private function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, undefined, &function_a92d75a1117625fc, 0, self.team, 1 );
    grenade thread function_7de4ee6d3709aa7f();
    var_4bc2dcb755f719f6 = getaiarrayinradius( grenade.origin, grenade.tableinfo.bundle.var_ca694ff612181976 );
    
    foreach ( ai in var_4bc2dcb755f719f6 )
    {
        ai aieventlistenerevent( "decoy_grenade", grenade, grenade.origin );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 0, eflags: 0x4
// Checksum 0xc8dc42a6, Offset: 0x65cc
// Size: 0x2c
function private function_7de4ee6d3709aa7f()
{
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
}

// Namespace namespace_7438d085a93b4787
// Params 2, eflags: 0x4
// Checksum 0x8a6f1ba1, Offset: 0x6600
// Size: 0x26, Type: bool
function private function_a92d75a1117625fc( attractor, ai )
{
    return ai.aicategory == "normal";
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x3550c856, Offset: 0x662f
// Size: 0x17
function function_6ff293d64c33db84()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_2a269ce71bf81088", &function_674c2e42a744d171 );
}

// Namespace namespace_7438d085a93b4787
// Params 1
// Checksum 0xb0aed512, Offset: 0x664e
// Size: 0x14
function function_674c2e42a744d171( params )
{
    level thread function_23a3d550c3b0484e();
}

// Namespace namespace_7438d085a93b4787
// Params 0
// Checksum 0x7d514698, Offset: 0x666a
// Size: 0x27
function function_23a3d550c3b0484e()
{
    if ( !flags::gameflag( "prematch_fade_done" ) )
    {
        iprintlnbold( "Cannot start holdout event during prematch." );
    }
    
    level notify( #"portal_start" );
}

/#

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x625df509, Offset: 0x6699
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xe9a91776, Offset: 0x66a6
    // Size: 0x1a, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xc763f682, Offset: 0x66c8
    // Size: 0x1ba, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6d>" );
        devgui::add_devgui_func( "<dev string:x8b>", "<dev string:x9e>", &function_674c2e42a744d171 );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xed>", &function_9e646b114b4d2a30 );
        devgui::add_devgui_func( "<dev string:x124>", "<dev string:x141>", &function_498f83e24de6bc73 );
        devgui::add_devgui_func( "<dev string:x17b>", "<dev string:x1a3>", &function_91773d3e9e83964d );
        devgui::add_devgui_func( "<dev string:x1e8>", "<dev string:x1f4>", &function_2ccd125e4fc60bb7 );
        devgui::add_devgui_func( "<dev string:x21d>", "<dev string:x22c>", &function_b7e1955e19b32222 );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x26f>", &function_dc8dcb0e08f51a08 );
        devgui::add_devgui_func( "<dev string:x2a3>", "<dev string:x2bc>", &function_9faadb84defa01f );
        devgui::add_devgui_func( "<dev string:x2f2>", "<dev string:x309>", &function_d1765b5b30aa8c21 );
        devgui::add_devgui_func( "<dev string:x33d>", "<dev string:x35e>", &function_eaf5b2f2392c03fb );
        devgui::add_devgui_func( "<dev string:x39c>", "<dev string:x3b7>", &function_8a31244855ff9571 );
        devgui::add_devgui_func( "<dev string:x3ef>", "<dev string:x3fc>", &function_4c26f141ae7d6f66 );
        devgui::add_devgui_func( "<dev string:x427>", "<dev string:x433>", &function_e5f366c89e6cb2c7 );
        devgui::add_devgui_func( "<dev string:x45c>", "<dev string:x469>", &function_39754f808ff6e28a );
        devgui::add_devgui_func( "<dev string:x493>", "<dev string:x4a0>", &function_22f8b0328e7b0322 );
        devgui::add_devgui_func( "<dev string:x4ca>", "<dev string:x4db>", &function_a08fe2b0a4dda8b4 );
        devgui::add_devgui_func( "<dev string:x509>", "<dev string:x519>", &function_f99944dd37afce6 );
        devgui::add_devgui_func( "<dev string:x546>", "<dev string:x556>", &function_6547cdc80ac4e9c3 );
        devgui::add_devgui_func( "<dev string:x583>", "<dev string:x596>", &function_c562d44d59a77866 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x379b910b, Offset: 0x688a
    // Size: 0x10b, Type: dev
    function function_9e646b114b4d2a30()
    {
        if ( !level.var_9e646b114b4d2a30 )
        {
            debug::sphere( level.floating_island.var_96ba7de8ae7f07fa, 50, ( 1, 1, 0.5 ), undefined, "<dev string:x5c6>", "<dev string:x5ea>" );
            debug::sphere( level.floating_island.var_96ba7ce8ae7f05c7, 50, ( 1, 1, 0.5 ), undefined, "<dev string:x5c6>", "<dev string:x5ea>" );
            debug::sphere( level.floating_island.var_96ba7be8ae7f0394, 50, ( 1, 1, 0.5 ), undefined, "<dev string:x5c6>", "<dev string:x5ea>" );
            return;
        }
        
        level.floating_island.var_96ba7de8ae7f07fa notify( #"hash_493659d9b842bb53" );
        level.floating_island.var_96ba7ce8ae7f05c7 notify( #"hash_493659d9b842bb53" );
        level.floating_island.var_96ba7be8ae7f0394 notify( #"hash_493659d9b842bb53" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x8c4e14b5, Offset: 0x699d
    // Size: 0x9f, Type: dev
    function function_498f83e24de6bc73()
    {
        if ( !level.var_498f83e24de6bc73 )
        {
            level.var_498f83e24de6bc73 = 1;
            debug::print3d( level.floating_island.var_1fc3198c61440d45, level.n_code_0 + "<dev string:x630>" + level.n_code_1 + "<dev string:x630>" + level.n_code_2, undefined, undefined, "<dev string:x5c6>", "<dev string:x632>", undefined, 0.25, 5 );
            return;
        }
        
        level.var_498f83e24de6bc73 = undefined;
        level.floating_island.var_1fc3198c61440d45 notify( #"hash_4aab9ca108d38640" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x87de9df4, Offset: 0x6a44
    // Size: 0x65, Type: dev
    function function_91773d3e9e83964d()
    {
        if ( !level.var_91773d3e9e83964d )
        {
            level.var_91773d3e9e83964d = 1;
            debug::sphere( level.floating_island.relic_sword_locked_door_research_center_zombie_hand, 50, ( 0, 0.5, 0 ), undefined, "<dev string:x676>" );
            return;
        }
        
        level.var_91773d3e9e83964d = undefined;
        level notify( #"hash_84d5b5974f4e46e" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xd53b56f2, Offset: 0x6ab1
    // Size: 0x11, Type: dev
    function function_2ccd125e4fc60bb7()
    {
        level notify( #"hash_d95ce983e34bb4e9" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x3002f7bf, Offset: 0x6aca
    // Size: 0x11, Type: dev
    function function_b7e1955e19b32222()
    {
        level notify( #"hash_7e728dc7428edd18" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x95fb76c1, Offset: 0x6ae3
    // Size: 0x11, Type: dev
    function function_dc8dcb0e08f51a08()
    {
        level notify( #"hash_e91a2d450128486" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xc9267009, Offset: 0x6afc
    // Size: 0x5a, Type: dev
    function function_9faadb84defa01f()
    {
        if ( !getdvarint( @"hash_5bed30c8277861df" ) )
        {
            setdvar( @"hash_5bed30c8277861df", 1 );
            iprintlnbold( "<dev string:x6c1>" );
            function_93fd1892e12c55a9();
            return;
        }
        
        setdvar( @"hash_5bed30c8277861df", 0 );
        iprintlnbold( "<dev string:x700>" );
        function_a215ca0534a6dac5();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xd5366cc0, Offset: 0x6b5e
    // Size: 0xa1, Type: dev
    function function_93fd1892e12c55a9()
    {
        level.var_1e7542636a2f2e44 = function_5713d46873b29625( level.var_1e7542636a2f2e44 );
        
        foreach ( scriptable in level.var_1e7542636a2f2e44 )
        {
            debug::sphere( scriptable, 100, "<dev string:x740>", undefined, "<dev string:x700>" );
        }
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xefccc322, Offset: 0x6c07
    // Size: 0x11, Type: dev
    function function_a215ca0534a6dac5()
    {
        level notify( #"hash_db00071e89811bb8" );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x98670912, Offset: 0x6c20
    // Size: 0x37, Type: dev
    function function_d1765b5b30aa8c21()
    {
        if ( !level.var_9164c036b47a3ce8 )
        {
            iprintlnbold( "<dev string:x744>" );
            function_12f14361539e240();
            return;
        }
        
        iprintlnbold( "<dev string:x759>" );
        function_ae26d7da7391bd91();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xa44a5f9b, Offset: 0x6c5f
    // Size: 0x8a, Type: dev
    function function_eaf5b2f2392c03fb()
    {
        if ( !level.var_9164c036b47a3ce8 )
        {
            level.var_9164c036b47a3ce8 = 1;
            iprintlnbold( "<dev string:x744>" );
            setareaswapstate( "<dev string:x76e>", "<dev string:x792>" );
            
            if ( isdefined( level.floating_island.spawn_fx ) )
            {
                level.floating_island.spawn_fx setscriptablepartstate( "<dev string:x7a5>", "<dev string:x7aa>" );
            }
            
            function_c57632b2e839e43a();
            return;
        }
        
        iprintlnbold( "<dev string:x759>" );
        function_ae26d7da7391bd91();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xd33340b, Offset: 0x6cf1
    // Size: 0x17, Type: dev
    function function_8a31244855ff9571()
    {
        function_444a2dbe059f2307();
        level.var_8ffa383f18744657 = 1;
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x5816d168, Offset: 0x6d10
    // Size: 0x15, Type: dev
    function function_4c26f141ae7d6f66()
    {
        pedestal_used( level.player );
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x4998f294, Offset: 0x6d2d
    // Size: 0xd, Type: dev
    function function_e5f366c89e6cb2c7()
    {
        level thread portal_open();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x59dab87b, Offset: 0x6d42
    // Size: 0xd, Type: dev
    function function_39754f808ff6e28a()
    {
        level thread reset_portal();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0x7dcdc781, Offset: 0x6d57
    // Size: 0x15, Type: dev
    function function_22f8b0328e7b0322()
    {
        level.player thread function_19399442296e3dc1();
    }

    // Namespace namespace_7438d085a93b4787
    // Params 0
    // Checksum 0xf1d8781b, Offset: 0x6d74
    // Size: 0x95, Type: dev
    function function_a08fe2b0a4dda8b4()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) && !player br_public::playeriszombie() )
            {
                player thread function_19399442296e3dc1();
                return;
            }
        }
    }

#/
