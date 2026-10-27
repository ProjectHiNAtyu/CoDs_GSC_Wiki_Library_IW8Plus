// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_pew.gsc  (hash_7d7eba89751f6149.gscc) (size: 9107 Bytes / 0x2393 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d6aa641 (2104141377)
// size ...... 9107 (0x2393)
// includes .. 15  (offset: 0x2167)
// strings ... 31  (offset: 0x21df)
// dev strs .. 0   (offset: 0x2393)
// exports ... 23  (offset: 0x1547)
// cseg ...... 0x244 + 0x1303 (0x1547)
// imports ... 71  (offset: 0x18df)
// animtree1 . 0   (offset: 0x2393)
// animtree2 . 0   (offset: 0x2393)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\field_upgrades\field_upgrades_aether_shroud;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\damagefeedback;
#using scripts\mp\overlord;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_pew_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ee_pew;

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x5
// Checksum 0x80fb3eff, Offset: 0x262
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_pew", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xd47cddc6, Offset: 0x28f
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0x7fef165f, Offset: 0x299
// Size: 0x91
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_d32cc63eab23f4a6", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_pew_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_archery = zm_quest::get_quest( #"hornet_ee_pew" );
    zm_quest::register_quest_step( #"hornet_ee_pew", #"unlock_pew", &setup_unlock_step, &cleanup_unlock_step );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_pew" );
}

// Namespace zm_sat_hornet_ee_pew
// Params 2, eflags: 0x4
// Checksum 0xd55c391e, Offset: 0x332
// Size: 0x15a
function private setup_unlock_step( b_skipped, b_save_restored )
{
    find_target_neighbors();
    level.ee_archery.var_cf81944069002076 = 0;
    level.ee_archery.current_level = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"pew_level" ) ?? 1;
    level.ee_archery.var_30bf16d33559fc7c = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"hash_b08ecaa2d6e6c85c" ) ?? -3;
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"pew_mask_demon" ) )
    {
        level utility::flag_set( "red_ug_mh" );
    }
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"pew_mask_woman" ) )
    {
        level utility::flag_set( "green_ug_mh" );
    }
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"pew_mask_monkey" ) )
    {
        level utility::flag_set( "yellow_ug_mh" );
    }
    
    if ( level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_pew", #"pew_mask_fox" ) )
    {
        level utility::flag_set( "white_ug_mh" );
    }
    
    if ( b_save_restored || b_skipped )
    {
        return;
    }
    
    level thread function_80af129f26e82cb();
    level waittill( #"hash_241208e03fc0e66f" );
}

// Namespace zm_sat_hornet_ee_pew
// Params 2, eflags: 0x4
// Checksum 0xb80fe91a, Offset: 0x494
// Size: 0x49
function private cleanup_unlock_step( b_skipped, b_save_restored )
{
    level utility::flag_set( "red_ug_mh" );
    level utility::flag_set( "green_ug_mh" );
    level utility::flag_set( "yellow_ug_mh" );
    level utility::flag_set( "white_ug_mh" );
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xb2cba26e, Offset: 0x4e5
// Size: 0x2ab
function private function_80af129f26e82cb()
{
    level.ee_archery endon( #"zm_quest_quit" );
    level endon( #"hash_241208e03fc0e66f" );
    level utility::flag_wait( "scriptables_ready" );
    var_2fe9ace9588585d1 = utility::getstruct( "mh_root_4", "script_noteworthy" );
    var_3fe78358d7a1b87a = getnoentvolumearray( "pew_tgtvis", #targetname )[ 0 ];
    level.ee_archery.trap_root = var_2fe9ace9588585d1;
    level.ee_archery.var_4a5ba87b5bd542ec = utility::getstruct( "pew_fir", "targetname" );
    
    while ( true )
    {
        var_2fe9ace9588585d1 waittill( #"trap_activated" );
        var_49f7091014d2c59 = level zm_utility::get_round_number();
        
        if ( var_49f7091014d2c59 - level.ee_archery.var_30bf16d33559fc7c < 3 )
        {
            var_2fe9ace9588585d1 waittill( #"trap_duration_ended" );
            continue;
        }
        
        if ( level utility::flag( "upg_rou_ac" ) )
        {
            continue;
        }
        
        level.ee_archery.hidden_target = spawnscriptable( %"zm_sat_hornet_tgt", level.ee_archery.var_4a5ba87b5bd542ec.origin, level.ee_archery.var_4a5ba87b5bd542ec.angles );
        level.ee_archery.hidden_target utility::function_32b24db3127bff40( "model", "variable" );
        var_3fe78358d7a1b87a thread monitor_player_in_trigger();
        level.ee_archery.b_trap_active = 1;
        level scriptable::scriptable_adddamagedcallback( &on_hidden_target_damaged );
        var_2fe9ace9588585d1 waittill( #"trap_duration_ended" );
        level.ee_archery.b_trap_active = undefined;
        level scriptable::function_dc174fecebb79952( &on_hidden_target_damaged );
        
        foreach ( player in level.players )
        {
            player setclientomnvar( "tgt_vis", 0 );
            player.var_47105b9b0385c5b = 0;
        }
        
        if ( level.ee_archery.hidden_target )
        {
            level.ee_archery.hidden_target freescriptable();
            level.ee_archery.hidden_target = undefined;
        }
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0x52f1de28, Offset: 0x798
// Size: 0x84
function private monitor_player_in_trigger()
{
    level.ee_archery.trap_root endon( #"trap_duration_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            ent setclientomnvar( "tgt_vis", 1 );
            
            if ( !ent.var_47105b9b0385c5b )
            {
                ent.var_47105b9b0385c5b = 1;
                thread function_b9b4aa27a0bf2c8( ent );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 1, eflags: 0x4
// Checksum 0x64a62bfa, Offset: 0x824
// Size: 0x5d
function private function_b9b4aa27a0bf2c8( player )
{
    player endon( #"death_or_disconnect" );
    
    while ( level.ee_archery.b_trap_active && player istouching( self ) )
    {
        wait 0.1;
    }
    
    player.var_47105b9b0385c5b = 0;
    player setclientomnvar( "tgt_vis", 0 );
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xb24552a3, Offset: 0x889
// Size: 0xd1
function private find_target_neighbors()
{
    a_targets = utility::getstructarray( "pew_tg" );
    var_d32626cdeb758b9f = [];
    
    foreach ( struct in a_targets )
    {
        struct.neighbors = get_valid_neighbors( struct, a_targets );
        
        if ( struct.script_noteworthy == "tg_star" )
        {
            var_d32626cdeb758b9f[ var_d32626cdeb758b9f.size ] = struct;
        }
    }
    
    level.ee_archery.var_d32626cdeb758b9f = var_d32626cdeb758b9f;
}

// Namespace zm_sat_hornet_ee_pew
// Params 2, eflags: 0x4
// Checksum 0x4e0cbc03, Offset: 0x962
// Size: 0x100
function private get_valid_neighbors( var_ed92d3edd3eded9, a_all_structs )
{
    valid_neighbors = [];
    
    foreach ( struct in a_all_structs )
    {
        if ( struct == var_ed92d3edd3eded9 )
        {
            continue;
        }
        
        dist_sq = distancesquared( var_ed92d3edd3eded9.origin, struct.origin );
        angle_diff = abs( angleclamp180( var_ed92d3edd3eded9.angles - struct.angles )[ 1 ] );
        
        if ( dist_sq < 360000 && angle_diff < 60 )
        {
            valid_neighbors[ valid_neighbors.size ] = struct;
        }
    }
    
    return valid_neighbors;
}

// Namespace zm_sat_hornet_ee_pew
// Params 1, eflags: 0x4
// Checksum 0x1a98abef, Offset: 0xa6b
// Size: 0x2e6
function private function_a6194ae41511a3be( var_6694135a711872c9 )
{
    level.ee_archery.var_cf81944069002076 = 1;
    level thread function_485f044c8cc67ae4();
    wait_len = function_8d9a5115b3bbdd10( var_6694135a711872c9 );
    total_targets = function_d4f9615448d035d0( var_6694135a711872c9 );
    level scriptable::scriptable_adddamagedcallback( &on_target_damaged );
    var_5990ce3727e634d1 = utility::array_random( level.ee_archery.var_d32626cdeb758b9f );
    var_3cb1e3384c338fbf = undefined;
    
    for ( target_counter = 0; target_counter < total_targets ; target_counter++ )
    {
        target = spawnscriptable( %"zm_sat_hornet_tgt", var_5990ce3727e634d1.origin, var_5990ce3727e634d1.angles );
        target setscriptablepartstate( "model", "withFX" );
        target.var_5990ce3727e634d1 = var_5990ce3727e634d1;
        target.health = 1;
        level.ee_archery.current_target = target;
        playsoundatpos( var_5990ce3727e634d1.origin, "evt_orb_spawn" );
        var_5b4eff275b24247d = target utility::waittill_any_timeout( wait_len, "hit" );
        
        if ( var_5b4eff275b24247d == "timeout" )
        {
            if ( level.ee_archery.ee_player )
            {
                level.ee_archery.ee_player playsoundtoplayer( "evt_ee_fail_stinger", level.ee_archery.ee_player );
            }
            
            level thread overlord::playevent( #"hash_6d152129188fc299", level.players );
            level.ee_archery.var_30bf16d33559fc7c = zm_utility::get_round_number() - 2;
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"hash_b08ecaa2d6e6c85c", level.ee_archery.var_30bf16d33559fc7c );
            level notify( #"pew_complete" );
            return;
        }
        
        var_3cb1e3384c338fbf = var_5990ce3727e634d1;
        var_5990ce3727e634d1 = pick_next_target( var_5990ce3727e634d1.neighbors, var_3cb1e3384c338fbf );
    }
    
    player = level.ee_archery.ee_player;
    
    if ( player )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", level.ee_archery.ee_player );
        player function_4de9979ac9498447();
    }
    
    level thread overlord::playevent( #"hash_691d063111d0f434", level.players );
    level notify( #"pew_complete" );
    zm_sat_hornet_murder_holes::function_58f46e59c7861579( level.ee_archery.trap_root );
    level thread function_f8853bc20c4a913();
    
    if ( player )
    {
        player endon( #"disconnect" );
        level waittill( #"hash_a95f820df4cd73d1" );
        wait 2;
        player thread zm_vo::function_8c1a12974bd11f01( "hornet_archery_upgrade", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0x23f5f636, Offset: 0xd59
// Size: 0x121
function private function_f8853bc20c4a913()
{
    level waittill( #"hash_a95f820df4cd73d1" );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"pew_level", level.ee_archery.current_level );
    
    if ( level utility::flag( "red_ug_mh" ) )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"pew_mask_demon", 1 );
    }
    
    if ( level utility::flag( "green_ug_mh" ) )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"pew_mask_woman", 1 );
    }
    
    if ( level utility::flag( "yellow_ug_mh" ) )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"pew_mask_monkey", 1 );
    }
    
    if ( level utility::flag( "white_ug_mh" ) )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"pew_mask_fox", 1 );
    }
    
    level.ee_archery.current_level++;
    
    if ( level.ee_archery.current_level >= 5 )
    {
        level notify( #"hash_241208e03fc0e66f" );
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xc05c74b8, Offset: 0xe82
// Size: 0x73
function private function_485f044c8cc67ae4()
{
    level.ee_archery endon( #"zm_quest_quit" );
    level waittill( #"pew_complete" );
    level scriptable::function_dc174fecebb79952( &on_target_damaged );
    
    if ( level.ee_archery.current_target )
    {
        level.ee_archery.current_target freescriptable();
    }
    
    level.ee_archery.var_cf81944069002076 = 0;
}

// Namespace zm_sat_hornet_ee_pew
// Params 11, eflags: 0x4
// Checksum 0x3ec36eb3, Offset: 0xefd
// Size: 0x147
function private on_target_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance.type ) || getxhashasset( instance.type ) != %"zm_sat_hornet_tgt" || instance.b_destroyed )
    {
        return;
    }
    
    if ( objweapon.basename != "sat_ks_compound_mp" )
    {
        return;
    }
    
    instance notify( #"hit" );
    
    if ( !instance.health )
    {
        return;
    }
    
    instance.health -= idamage;
    eattacker damagefeedback::updatehitmarker( "standard", instance.health <= 0, 0, 0, undefined );
    instance.b_destroyed = 1;
    playsoundatpos( vpoint, "evt_orb_disappear" );
    instance setscriptablepartstate( "model", "dest" );
    wait 1;
    
    if ( instance )
    {
        instance freescriptable();
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 11, eflags: 0x4
// Checksum 0xe63a120a, Offset: 0x104c
// Size: 0x161
function private on_hidden_target_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance != level.ee_archery.hidden_target )
    {
        return;
    }
    
    if ( eattacker getclientomnvar( "tgt_vis" ) != 1 )
    {
        return;
    }
    
    if ( objweapon.basename != "sat_ks_compound_mp" )
    {
        return;
    }
    
    if ( level.ee_archery.var_cf81944069002076 )
    {
        return;
    }
    
    var_49f7091014d2c59 = zm_utility::get_round_number();
    
    if ( var_49f7091014d2c59 - level.ee_archery.var_30bf16d33559fc7c < 3 )
    {
        return;
    }
    
    level.ee_archery.var_30bf16d33559fc7c = var_49f7091014d2c59;
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_pew", #"hash_b08ecaa2d6e6c85c", var_49f7091014d2c59 );
    level.ee_archery thread apply_aether_shroud( eattacker );
    level.ee_archery.ee_player = eattacker;
    function_a6194ae41511a3be( level.ee_archery.current_level );
}

// Namespace zm_sat_hornet_ee_pew
// Params 1, eflags: 0x4
// Checksum 0x7a4f0a7, Offset: 0x11b5
// Size: 0x64
function private function_8d9a5115b3bbdd10( var_6694135a711872c9 )
{
    switch ( var_6694135a711872c9 )
    {
        case 4:
            return 5.5;
        case 3:
            return 6.75;
        case 2:
            return 8;
        case 1:
        default:
            return 10;
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 1, eflags: 0x4
// Checksum 0x6eccefd8, Offset: 0x1221
// Size: 0x5e
function private function_d4f9615448d035d0( var_6694135a711872c9 )
{
    switch ( var_6694135a711872c9 )
    {
        case 4:
            return 11;
        case 3:
            return 9;
        case 2:
            return 7;
        case 1:
        default:
            return 5;
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 1, eflags: 0x4
// Checksum 0xafe46fc4, Offset: 0x1287
// Size: 0x146
function private apply_aether_shroud( player )
{
    self endon( #"zm_quest_quit" );
    player endon( #"disconnect" );
    var_5a43faeaf9d6e9c7 = player supers_mp::getcurrentsuper();
    saved_ref = var_5a43faeaf9d6e9c7.staticdata.ref ?? "";
    saved_points = player supers_mp::getcurrentsuperpoints();
    player.var_f20215e1fa71682a = undefined;
    player perkpackage::perkpackage_giveimmediate( "super_aether_shroud", undefined, undefined, undefined, 1 );
    player perkpackage::perkpackage_reset();
    player callback::callback( "field_upgrade_edit_notify" );
    player supers_mp::givesuperpoints( player supers_mp::getsuperpointsneeded(), undefined, 0 );
    player field_upgrades_aether_shroud::begin_use_aether_shroud();
    thread function_36ef3a3d80614dc2();
    self waittill( #"hash_720c35cde726e7db" );
    
    if ( player.aether_shroud_active )
    {
        player field_upgrades_aether_shroud::function_63c791098b816b7();
        waitframe();
    }
    
    player.var_f20215e1fa71682a = undefined;
    player perkpackage::perkpackage_giveimmediate( saved_ref, undefined, undefined, undefined, 1 );
    player perkpackage::perkpackage_reset();
    player callback::callback( "field_upgrade_edit_notify" );
    
    if ( saved_points > 0 )
    {
        player supers_mp::givesuperpoints( saved_points, undefined, 0 );
    }
    
    level.ee_archery.ee_player = undefined;
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0x71df7207, Offset: 0x13d5
// Size: 0x27
function private function_36ef3a3d80614dc2()
{
    self endon( #"hash_720c35cde726e7db" );
    level waittill( #"pew_complete" );
    self notify( #"hash_720c35cde726e7db" );
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xbaa8e75b, Offset: 0x1404
// Size: 0x39
function private function_8d702130eed2466a()
{
    self endon( #"hash_720c35cde726e7db" );
    level.ee_archery.trap_root waittill( #"trap_duration_ended" );
    self notify( #"hash_720c35cde726e7db" );
}

// Namespace zm_sat_hornet_ee_pew
// Params 0, eflags: 0x4
// Checksum 0xfe528abf, Offset: 0x1445
// Size: 0x2f
function private function_4de9979ac9498447()
{
    weapon = self getcurrentweapon();
    
    if ( weapon.basename == "sat_ks_compound_mp" )
    {
        self givemaxammo( weapon );
    }
}

// Namespace zm_sat_hornet_ee_pew
// Params 2, eflags: 0x4
// Checksum 0xc370d5, Offset: 0x147c
// Size: 0xca
function private pick_next_target( a_neighbors, var_3cb1e3384c338fbf )
{
    if ( !isdefined( var_3cb1e3384c338fbf ) || a_neighbors.size <= 1 )
    {
        return utility::array_random( a_neighbors );
    }
    
    a_filtered = [];
    
    foreach ( neighbor in a_neighbors )
    {
        if ( neighbor != var_3cb1e3384c338fbf )
        {
            a_filtered[ a_filtered.size ] = neighbor;
        }
    }
    
    if ( a_filtered.size > 0 )
    {
        return utility::array_random( a_filtered );
    }
    
    return utility::array_random( a_neighbors );
}

