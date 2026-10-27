// script_38839cc29075d9db  (hash_38839cc29075d9db.gscc) (size: 79331 Bytes / 0x135e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfe9ada3 (3756633507)
// size ...... 79331 (0x135e3)
// includes .. 36  (offset: 0x1213b)
// strings ... 269 (offset: 0x1225b)
// dev strs .. 32  (offset: 0x13457)
// exports ... 149 (offset: 0xcc0f)
// cseg ...... 0x1698 + 0xb577 (0xcc0f)
// imports ... 437 (offset: 0xe357)
// animtree1 . 0   (offset: 0x135e3)
// animtree2 . 0   (offset: 0x135e3)
#using script_16ea1b94f0f381b3;
#using script_2b352aad1f80b92;
#using script_38234c6dc0321d2a;
#using script_5cda26b07ee216bf;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\lighting_pbg;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\weapons\weap_scarabww;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_mq;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_pap_quest;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_usurped_power;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_7d52c88182a8ee9b;

// Namespace namespace_7d52c88182a8ee9b
// Params 1
// Checksum 0x9b30ec, Offset: 0x16b6
// Size: 0x2c2
function register_temple_quests( str_shadowsmith )
{
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"prepare_temple", &setup_remove_curse );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"remove_curse" );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"destroy_totem", &setup_destroy_totem, &cleanup_destroy_totem );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"break_shackle", &setup_break_shackle, &cleanup_break_shackle );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"mana_focus", &setup_mana_focus );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"uncover_focus", &function_33a3d1acc30ad33d, &function_220d96c2fa7d99e8 );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"activate_focus", &setup_activate_focus, &cleanup_activate_focus );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"reveal_corruption", &setup_reveal_corruption, &cleanup_reveal_corruption );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"destroy_visage", &setup_destroy_visage, &cleanup_destroy_visage );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"astral_eye", &setup_astral_eye, &cleanup_astral_eye );
    zm_quest::register_quest_step( hashcat( #"hash_5267022c69306b07", str_shadowsmith ), #"cleansing_strike", &function_12b23b42ec2ce079, &function_9f5cb77e21d0a47a );
    level._effect[ #"hash_197687547c2a23c2" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_beam" );
    level._effect[ #"hash_16fd5bb034134aa6" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_aperture_beam" );
    level._effect[ #"hash_1702d11c344e3e2e" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_beam_end" );
    level._effect[ #"mana_focus_soul" ] = loadfxasset( "vfx_t10_gameplay_zm_zombie_souls_trail" );
    level._effect[ #"mana_focus_capture" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_soul_capture" );
    level._effect[ #"mana_focus_charge" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_soul_launched" );
    level._effect[ #"mana_focus_impact" ] = loadfxasset( "vfx_sat_levels_zm_scarab_mq_mana_focus_soul_launched_impact" );
    level._effect[ #"hash_735a18e2b6980a12" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_weyward_shield_imp" );
    level utility::registersharedfunc( #"quest", #"hash_4c11e178cb3a3c7f", &function_349aeefecfdc687f );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x3ec320d2, Offset: 0x1980
// Size: 0x30
function private setup_remove_curse( b_skipped, b_restored )
{
    level thread function_9e24f072eac737dd( self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xf9aa6e86, Offset: 0x19b8
// Size: 0xea
function private function_337311abb8925844()
{
    level._effect[ #"temple_ambient_caltheris_cleaned_camera" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_caltheris_cleaned_camera" );
    level._effect[ #"hash_5827cc4925cb461e" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_caltheris_sand_camera" );
    level._effect[ #"temple_ambient_dravakar_cleaned_camera" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_dravakar_cleaned_camera" );
    level._effect[ #"hash_bd093f831b40d2f1" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_dravakar_ice_camera" );
    level._effect[ #"temple_ambient_nyxara_cleaned_camera" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_nyxara_cleaned_camera" );
    level._effect[ #"hash_f59535ba688de16a" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_nyxara_lava_camera" );
    level._effect[ #"temple_ambient_veytharion_cleaned_camera" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_veytharion_cleaned_camera" );
    level._effect[ #"hash_359dc62ece307af2" ] = loadfxasset( "vfx_sat_scarab_temple_ambient_veytharion_blood_camera" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xca2060d6, Offset: 0x1aaa
// Size: 0x85
function private function_9e24f072eac737dd( var_8af4bb0185feb88 )
{
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
    
    if ( zm_quest::function_73720cdf21c3cfd7( str_quest_ref, #"hash_9e8ab98e1b6a808c" ) )
    {
        zm_quest::function_e65609834444650c( zm_quest::get_quest_step( str_quest_ref, #"destroy_totem" ) );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( str_quest_ref, #"hash_5434f02943e452c7" ) )
    {
        zm_quest::function_e65609834444650c( zm_quest::get_quest_step( str_quest_ref, #"break_shackle" ) );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xd291ec51, Offset: 0x1b37
// Size: 0x30
function private setup_mana_focus( b_skipped, b_restored )
{
    level thread function_e029557484851226( self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x2c322d84, Offset: 0x1b6f
// Size: 0x85
function private function_e029557484851226( var_8af4bb0185feb88 )
{
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
    
    if ( zm_quest::function_73720cdf21c3cfd7( str_quest_ref, #"hash_d520b08207825109" ) )
    {
        zm_quest::function_e65609834444650c( zm_quest::get_quest_step( str_quest_ref, #"uncover_focus" ) );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( str_quest_ref, #"hash_15605240accc5920" ) )
    {
        zm_quest::function_e65609834444650c( zm_quest::get_quest_step( str_quest_ref, #"activate_focus" ) );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x4d3d5d20, Offset: 0x1bfc
// Size: 0xd9
function private function_9daa7d17f73edd0c()
{
    level utility::flag_wait( "scriptables_ready" );
    
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 <= 4 ; var_8af4bb0185feb88++ )
    {
        e_tile = getent( "tmp_ground_" + var_8af4bb0185feb88, #targetname );
        e_tile.var_8af4bb0185feb88 = var_8af4bb0185feb88;
        interact = zm_quest::function_91f9590e98d57ff6( e_tile.origin + ( 0, 0, 32 ), &function_a2617a87b3de8e5d, undefined, "hidden" );
        interact.var_8af4bb0185feb88 = var_8af4bb0185feb88;
        str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
        quest = zm_quest::get_quest( str_quest_ref );
        quest.var_3599b5b78bd2cfd3 = interact;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xac6a5985, Offset: 0x1cdd
// Size: 0x7c
function private function_a2617a87b3de8e5d( player )
{
    if ( self.b_playing_vo )
    {
        return;
    }
    
    self.b_playing_vo = 1;
    var_80ce893c79d1d533 = "temple_interact" + self.var_8af4bb0185feb88;
    b_success = zm_sat_scarab_mq::function_7038fcc5de4df138( var_80ce893c79d1d533, "tmp_tl_vo" + self.var_8af4bb0185feb88 );
    
    if ( self )
    {
        if ( b_success )
        {
            self freescriptable();
            return;
        }
        
        self.b_playing_vo = undefined;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0
// Checksum 0xee4d3d28, Offset: 0x1d61
// Size: 0xcf
function function_2fa9a01d86a5d30()
{
    level namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"drop_totem", &function_347997091efd0405 );
    function_337311abb8925844();
    setup_nyxara_uncorrupted_triggers();
    level thread function_ff64d9d09513e689();
    level thread namespace_9972523f9872e5a4::setup_veytharion_puzzle();
    level thread namespace_9972523f9872e5a4::setup_caltheris_puzzle();
    
    /#
        level thread function_bb64bf73f3a5a4a5();
    #/
    
    level callback::add( #"hash_aaf65c4358cf66a2", &function_295e89e0763ad8fb, { #quest:zm_quest::get_quest( #"hash_f6b10d1f1c4575a" ) } );
    level callback::add( "shadowvortex_zombiedropped", &function_95da2abdd2491f97, { #quest:zm_quest::get_quest( #"hash_2d753cdc71ad3528" ) } );
    level callback::add( #"hash_fdb7c9b3f46244da", &function_7541b6d6e5191107 );
    level callback::add( #"player_connect", &function_9ab79a7823c716e6 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc56be3a8, Offset: 0x1e38
// Size: 0x85
function private function_9ab79a7823c716e6( params )
{
    thread function_8aa1d841aeda908a();
    
    if ( level utility::flag( "totes_check_check" + 1 ) || level utility::flag( "totes_check_check" + 2 ) || level utility::flag( "totes_check_check" + 3 ) || level utility::flag( "totes_check_check" + 4 ) )
    {
        level zm_quest::function_98432f89334662d5( #"totems", 1, self );
        level zm_quest::function_a57d1f0655542b50( #"totems", 0, self );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x114a832f, Offset: 0x1ec5
// Size: 0xf
function private setup_nyxara_uncorrupted_triggers()
{
    level utility::flag_clear( "nyxara_uncorrupted_fire_enabled" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xbf86b873, Offset: 0x1edc
// Size: 0x1f
function private function_ff64d9d09513e689()
{
    level utility::flag_wait( "sst_made_nice" + 1 );
    level utility::flag_set( "nyxara_uncorrupted_fire_enabled" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0
// Checksum 0x7a3331a9, Offset: 0x1f03
// Size: 0xfc
function function_db234cd93079c3c1()
{
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        level utility::flag_wait( "initial_player_spawned" );
        function_203f7db1858bda56( 1 );
        function_203f7db1858bda56( 2 );
        function_203f7db1858bda56( 3 );
        function_203f7db1858bda56( 4 );
    }
    
    n_motes = zm_quest::function_73720cdf21c3cfd7( #"hash_f6b10d1f1c4575a", #"astral_motes" );
    
    if ( isdefined( n_motes ) )
    {
        caltheris_q = zm_quest::get_quest( #"hash_f6b10d1f1c4575a" );
        caltheris_q.n_motes_looted = n_motes;
    }
    
    var_ce318cb2d931ad92 = zm_quest::function_73720cdf21c3cfd7( #"hash_2d753cdc71ad3528", #"astral_kills" );
    
    if ( isdefined( var_ce318cb2d931ad92 ) )
    {
        nyxara_q = zm_quest::get_quest( #"hash_2d753cdc71ad3528" );
        nyxara_q.var_e7f54d9d0f760cbc = var_ce318cb2d931ad92;
    }
    
    level thread function_9daa7d17f73edd0c();
    level thread setup_totem_braziers();
    level thread function_63826785a58597e0();
    level thread function_342f15003e07e275();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xe5d528aa, Offset: 0x2007
// Size: 0x9c
function private function_203f7db1858bda56( var_8af4bb0185feb88 )
{
    var_2a6606506a261960 = get_shadowsmith_str( var_8af4bb0185feb88 );
    str_quest_ref = hashcat( #"hash_5267022c69306b07", var_2a6606506a261960 );
    var_1764324234cd7401 = level zm_quest::function_73720cdf21c3cfd7( str_quest_ref, #"totem" );
    
    if ( var_1764324234cd7401 == 1 )
    {
        function_bc440f92df37953c( var_8af4bb0185feb88 );
    }
    else if ( var_1764324234cd7401 == 2 )
    {
        function_781dc15f92dd556a( var_8af4bb0185feb88 );
    }
    else if ( var_1764324234cd7401 == 0 && var_8af4bb0185feb88 == 3 )
    {
        function_fe6826988996a124();
    }
    
    level zm_quest::function_44fe3dcaa8005357();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x8598aa02, Offset: 0x20ab
// Size: 0x54
function private function_bc440f92df37953c( var_8af4bb0185feb88 )
{
    level utility::flag_set( "totes_check_check" + var_8af4bb0185feb88 );
    level zm_quest::function_98432f89334662d5( #"totems", 1 );
    level zm_quest::function_b57dfe9625966b0b( #"totems", 0, hashcat( #"hash_34d854f633dfd81b", var_8af4bb0185feb88 ), 1, 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x256dada2, Offset: 0x2107
// Size: 0x109
function private function_781dc15f92dd556a( var_8af4bb0185feb88 )
{
    interact = get_totem_interact( var_8af4bb0185feb88 );
    interact.item = function_51727b165ef51ccd( var_8af4bb0185feb88 );
    interact.item.info = { #interact:interact, #flag:"totes_check_check" + var_8af4bb0185feb88, #var_8af4bb0185feb88:var_8af4bb0185feb88, #item:interact.item };
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
    quest = zm_quest::get_quest( str_quest_ref );
    quest.mq_totem = interact.item;
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, interact.item.info );
    level utility::flag_set( "totes_plop_hop" + var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x3e9ee03c, Offset: 0x2218
// Size: 0xbe
function private get_totem_interact( var_8af4bb0185feb88 )
{
    level utility::flag_wait( "power_on" );
    
    foreach ( scr_brazier in level.scarab_pap_quest.var_f0218d7a43516520 )
    {
        if ( scr_brazier.s_brazier.script_noteworthy == string( var_8af4bb0185feb88 ) )
        {
            return scr_brazier.interact;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x7104a5c7, Offset: 0x22de
// Size: 0xe8
function private function_fe6826988996a124()
{
    var_7d26e81185cb8603 = level zm_quest::function_73720cdf21c3cfd7( #"hash_a9ed33fe4d2ef275", #"totem_spawn_id" );
    a_bricks = getentitylessscriptablearray( "scriptable_zm_sat_scarab_temple_brick", #classname );
    
    foreach ( brick in a_bricks )
    {
        if ( var_7d26e81185cb8603 == int( brick.script_noteworthy ) )
        {
            var_c5fb7b9c0ca383b7 = utility::getstruct( brick.target );
            level thread function_a350eb6d416006fe( brick, var_c5fb7b9c0ca383b7 );
            break;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xbf1978b, Offset: 0x23ce
// Size: 0x2ef
function private function_63826785a58597e0()
{
    level utility::flag_wait( "power_on" );
    a_bricks = getentitylessscriptablearray( "scriptable_zm_sat_scarab_temple_brick", #classname );
    var_7d26e81185cb8603 = level zm_quest::function_73720cdf21c3cfd7( #"hash_a9ed33fe4d2ef275", #"totem_spawn_id" );
    n_drop_id = level zm_quest::function_73720cdf21c3cfd7( #"hash_a9ed33fe4d2ef275", #"drop_shield" );
    
    foreach ( brick in a_bricks )
    {
        var_72cc29b27afaffae = brick.script_noteworthy;
        
        if ( n_drop_id && n_drop_id == int( var_72cc29b27afaffae ) )
        {
            brick setscriptablepartstate( "base", "off" + var_72cc29b27afaffae );
        }
        else
        {
            brick setscriptablepartstate( "base", "on" + var_72cc29b27afaffae );
        }
        
        if ( isdefined( var_7d26e81185cb8603 ) && int( var_72cc29b27afaffae ) == var_7d26e81185cb8603 )
        {
            level.zm_scarab_mq.brick_prime = brick;
        }
    }
    
    if ( !isdefined( level.zm_scarab_mq.brick_prime ) )
    {
        level.zm_scarab_mq.brick_prime = utility::array_random( a_bricks );
    }
    
    level.zm_scarab_mq.brick_prime.var_b590d0da09e22a56 = 1;
    level thread zm_quest::start_quest( #"hash_a9ed33fe4d2ef275" );
    
    if ( level.zm_scarab_mq.brick_prime.script_noteworthy )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hash_a9ed33fe4d2ef275", #"totem_spawn_id", int( level.zm_scarab_mq.brick_prime.script_noteworthy ) );
    }
    
    level.zm_scarab_mq.var_b7ecbe1c2d61dce3 = [ %"hash_428e5b0816d1da5f", %"hash_3bfa0943ea32e6f8", %"hash_4842906b8eabe740" ];
    level callback::add( "shatterblast_explosion", &function_4b9e25867fd1ae5a );
    level.zm_scarab_mq.var_1fe8741dcf8d8f33 = getentitylessscriptablearray( level.zm_scarab_mq.brick_prime.target, #targetname, level.zm_scarab_mq.brick_prime.origin, 64 )[ 0 ];
    level.zm_scarab_mq.var_1fe8741dcf8d8f33 setscriptablepartstate( "base", "on" );
    level utility::flag_set( "dr_scr_hm_hn_set" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x4131a62d, Offset: 0x26c5
// Size: 0x21d
function private function_4b9e25867fd1ae5a( params )
{
    a_bricks = getentitylessscriptablearray( "scriptable_zm_sat_scarab_temple_brick", #classname, params.origin, params.radius );
    
    foreach ( brick in a_bricks )
    {
        str_state = brick getscriptablepartstate( "base" );
        
        if ( issubstr( str_state, "off" ) )
        {
            continue;
        }
        
        var_c5fb7b9c0ca383b7 = utility::getstruct( brick.target );
        
        if ( brick.var_b590d0da09e22a56 )
        {
            function_a350eb6d416006fe( brick, var_c5fb7b9c0ca383b7 );
        }
        else
        {
            v_spawn = brick.origin + anglestoforward( brick.angles ) * -14 + anglestoup( brick.angles ) * -15;
            str_loot = utility::array_random( level.zm_scarab_mq.var_b7ecbe1c2d61dce3 );
            
            if ( str_loot )
            {
                if ( str_loot == %"hash_428e5b0816d1da5f" )
                {
                    n_offset = 4;
                }
                
                v_spawn += ( 0, 0, n_offset ?? 0 );
                spawnoptions = common_item::function_bc5ff2958b71a708( v_spawn, brick.angles );
                spawnoptions.dropradiusscale = 0;
                spawnoptions.var_fd47e835523b473f = 1;
                level.zm_scarab_mq.var_b7ecbe1c2d61dce3 = arrayremove( level.zm_scarab_mq.var_b7ecbe1c2d61dce3, str_loot );
                common_item::function_61c2c0251e742ffd( str_loot, 1, spawnoptions );
            }
        }
        
        brick setscriptablepartstate( "base", "off" + brick.script_noteworthy );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x5ea39c68, Offset: 0x28ea
// Size: 0x1b2
function private function_a350eb6d416006fe( brick, var_c5fb7b9c0ca383b7 )
{
    brick.var_b590d0da09e22a56 = undefined;
    spawnoptions = common_item::function_bc5ff2958b71a708( var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_1c79de031eae8055", 1, spawnoptions );
    item.info = { #flag:"totes_check_check" + 3, #var_8af4bb0185feb88:3, #item:item };
    quest = zm_quest::get_quest( #"hash_a9ed33fe4d2ef275" );
    quest.mq_totem = item;
    level utility::flag_set( "totes_totes_dropped" + 3 );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_a9ed33fe4d2ef275", #"totem", 0 );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_a9ed33fe4d2ef275", #"drop_shield", int( brick.script_noteworthy ) );
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == 3 )
    {
        level thread function_6c8683f5decc16a5( quest, 3 );
    }
    
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
    level utility::flag_wait( "dr_scr_hm_hn_set" );
    level.zm_scarab_mq.var_1fe8741dcf8d8f33 setscriptablepartstate( "base", "off" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x14c18655, Offset: 0x2aa4
// Size: 0x1ac
function private function_295e89e0763ad8fb( params, info )
{
    if ( level utility::flag( "totes_check_check" + 4 ) || level utility::flag( "totes_totes_dropped" + 4 ) )
    {
        return;
    }
    
    if ( !info.quest )
    {
        return;
    }
    
    if ( !isdefined( info.quest.n_motes_looted ) )
    {
        info.quest.n_motes_looted = 0;
    }
    
    info.quest.n_motes_looted++;
    var_2d796f3828b3ab7e = zm_quest::function_b0a5181ebe7bb905() ? 8 : 16;
    
    if ( info.quest.n_motes_looted >= var_2d796f3828b3ab7e )
    {
        info.quest.n_motes_looted = 0;
        level thread function_f02b9b7025089121( params.mote.origin, info.quest );
    }
    else if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == 4 )
    {
        info.quest.var_eeb9ebc1ddc515ce = params.mote;
        level thread function_6c8683f5decc16a5( info.quest, 4, info.quest.n_motes_looted );
    }
    
    level thread zm_quest::start_quest( #"hash_f6b10d1f1c4575a" );
    zm_quest::function_4eefe6de31f5ddab( #"hash_f6b10d1f1c4575a", #"astral_motes", info.quest.n_motes_looted );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xcfcdf5f4, Offset: 0x2c58
// Size: 0x16f
function private function_f02b9b7025089121( v_spawn, quest )
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_spawn );
    spawnoptions.critical = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_1c79d7031eae7470", 1, spawnoptions );
    item.info = { #flag:"totes_check_check" + 4, #var_8af4bb0185feb88:4, #item:item };
    quest.mq_totem = item;
    level utility::flag_set( "totes_totes_dropped" + 4 );
    level thread zm_quest::start_quest( #"hash_f6b10d1f1c4575a" );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_f6b10d1f1c4575a", #"totem", 0 );
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == 4 )
    {
        level thread function_6c8683f5decc16a5( quest, 4 );
    }
    
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
    item waittill( #"death" );
    waitframe();
    
    if ( !level utility::flag( "totes_check_check" + 4 ) )
    {
        quest.n_motes_looted = 7;
        level utility::flag_clear( "totes_totes_dropped" + 4 );
        level thread function_6c8683f5decc16a5( quest, 4, quest.n_motes_looted );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x221ef2df, Offset: 0x2dcf
// Size: 0x1f1
function private function_95da2abdd2491f97( params, info )
{
    if ( level utility::flag( "totes_check_check" + 1 ) )
    {
        return;
    }
    
    if ( level utility::flag( "sst_deto_check" + 1 ) )
    {
        level callback::remove( "shadowvortex_zombiedropped", &function_95da2abdd2491f97, info );
        return;
    }
    
    if ( !info.quest )
    {
        return;
    }
    
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    if ( params.var_cbfa9122d492f18f )
    {
        if ( !isdefined( info.quest.var_e7f54d9d0f760cbc ) )
        {
            info.quest.var_e7f54d9d0f760cbc = 0;
        }
        
        info.quest.var_e7f54d9d0f760cbc++;
        
        if ( !isdefined( info.quest.mq_totem ) && ( info.quest.var_e7f54d9d0f760cbc >= 8 || ( level utility::flag( "ny_first_t_drop" ) || zm_quest::function_b0a5181ebe7bb905() ) && info.quest.var_e7f54d9d0f760cbc >= 4 ) )
        {
            info.quest.var_e7f54d9d0f760cbc = 0;
            level thread function_d2ba58f06bab01f5( params.agent, params.player, info.quest );
        }
        else if ( !level utility::flag( "totes_totes_dropped" + 1 ) )
        {
            level thread function_6c8683f5decc16a5( info.quest, 1, info.quest.var_e7f54d9d0f760cbc );
        }
        
        level thread zm_quest::start_quest( #"hash_2d753cdc71ad3528" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2d753cdc71ad3528", #"astral_kills", info.quest.var_e7f54d9d0f760cbc );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0x4
// Checksum 0x5f14dd99, Offset: 0x2fc8
// Size: 0x17a
function private function_d2ba58f06bab01f5( ent, player, quest )
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( ent );
    spawnoptions.critical = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_1c79dc031eae7cef", 1, spawnoptions );
    item.info = { #flag:"totes_check_check" + 1, #var_8af4bb0185feb88:1, #item:item };
    quest.mq_totem = item;
    level utility::flag_set( "ny_first_t_drop" );
    level utility::flag_set( "totes_totes_dropped" + 1 );
    level thread zm_quest::start_quest( #"hash_2d753cdc71ad3528" );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_2d753cdc71ad3528", #"totem", 0 );
    player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == 1 )
    {
        level thread function_6c8683f5decc16a5( quest, 1 );
    }
    
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
    item waittill( #"death" );
    waitframe();
    
    if ( !level utility::flag( "totes_check_check" + 1 ) )
    {
        level utility::flag_clear( "totes_totes_dropped" + 1 );
        level thread function_6c8683f5decc16a5( quest, 1 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x90c057f3, Offset: 0x314a
// Size: 0x375
function private function_7541b6d6e5191107( params )
{
    if ( level utility::flag( "totes_check_check" + 2 ) )
    {
        return;
    }
    
    if ( level utility::flag( "totes_totes_dropped" + 2 ) )
    {
        return;
    }
    
    a_spawns = utility::getstructarray( "zm_sat_scarab_isl_rain_drip_fx" );
    n_spawn_id = level zm_quest::function_73720cdf21c3cfd7( #"hash_8f67bf8336da87a4", #"totem_spawn_id" );
    
    if ( isdefined( n_spawn_id ) )
    {
        foreach ( spawn in a_spawns )
        {
            if ( int( spawn.script_noteworthy ) == n_spawn_id )
            {
                s_spawn = spawn;
                break;
            }
        }
    }
    
    if ( !isdefined( s_spawn ) )
    {
        s_spawn = utility::array_random( a_spawns );
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( s_spawn.origin, s_spawn.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        str_bundle = %"hash_1c79dd031eae7ea2";
    }
    else
    {
        str_bundle = %"hash_3fc3ad2b4a9d1782";
    }
    
    item = common_item::function_61c2c0251e742ffd( str_bundle, 1, spawnoptions );
    item.info = { #flag:"totes_check_check" + 2, #var_8af4bb0185feb88:2, #item:item };
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        item setscriptablepartstate( "zmloot_quest_scarab_mq_totem_2", "visible" );
    }
    else
    {
        item setscriptablepartstate( "zmloot_quest_scarab_mq_totem_2_no_loot_card", "visible_no_outline" );
    }
    
    quest = zm_quest::get_quest( #"hash_8f67bf8336da87a4" );
    quest.mq_totem = item;
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
    level utility::flag_set( "totes_totes_dropped" + 2 );
    level thread zm_quest::start_quest( #"hash_8f67bf8336da87a4" );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_8f67bf8336da87a4", #"totem", 0 );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_8f67bf8336da87a4", #"totem_spawn_id", int( s_spawn.script_noteworthy ) );
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == 2 )
    {
        level thread function_6c8683f5decc16a5( quest, 2 );
    }
    
    do
    {
        level waittill( #"on_round_end" );
    }
    while ( level utility::flag( "call_the_rain" ) );
    
    if ( item )
    {
        level callback::remove( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
        item freescriptable();
        level utility::flag_clear( "totes_totes_dropped" + 2 );
        level zm_quest::function_6265be8d0549e1b1( #"hash_8f67bf8336da87a4", #"totem_spawn_id" );
        
        if ( !level utility::flag( "totes_check_check" + 2 ) && !level utility::flag( "totes_plop_hop" + 2 ) )
        {
            level thread function_6c8683f5decc16a5( quest, 2 );
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xc5fedc91, Offset: 0x34c7
// Size: 0x343
function private function_9a8e22688a7c3c11( params, info )
{
    if ( params.item == info.item || info == params.item.info )
    {
        level utility::flag_set( info.flag );
        level callback::remove( #"player_item_pickup", &function_9a8e22688a7c3c11, info );
        
        if ( info.interact )
        {
            info.interact setscriptablepartstate( "usable", "usable" );
            level utility::flag_clear( "totes_plop_hop" + info.var_8af4bb0185feb88 );
        }
        
        var_8af4bb0185feb88 = int( info.var_8af4bb0185feb88 );
        
        if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == var_8af4bb0185feb88 )
        {
            level thread function_6c8683f5decc16a5( undefined, var_8af4bb0185feb88 );
        }
        
        if ( params.itembundle.scriptable == %"zmloot_quest_scarab_mq_totem_2" || params.itembundle.scriptable == %"zmloot_quest_scarab_mq_totem_2_no_loot_card" )
        {
            level utility::flag_clear( "totes_totes_dropped" + 2 );
        }
        
        if ( !level utility::flag( "mq_item_pickup_music" + info.var_8af4bb0185feb88 ) )
        {
            level utility::flag_set( "mq_item_pickup_music" + info.var_8af4bb0185feb88 );
            
            if ( var_8af4bb0185feb88 == 1 )
            {
                level musicbank_utility::function_5aca66c390aa347d( self, hashcat( #"hash_d7926c71308f79e5", get_shadowsmith_str( var_8af4bb0185feb88 ) ) );
            }
            else if ( var_8af4bb0185feb88 == 3 )
            {
                level zm_music::function_446e6e39d7feeb7c( [ "zone_ne_temple_sideroom" ], hashcat( #"hash_d7926c71308f79e5", get_shadowsmith_str( var_8af4bb0185feb88 ) ) );
            }
            else
            {
                level zm_music::function_446e6e39d7feeb7c( get_temple_zones( var_8af4bb0185feb88 ), hashcat( #"hash_d7926c71308f79e5", get_shadowsmith_str( var_8af4bb0185feb88 ) ) );
            }
        }
        
        str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( info.var_8af4bb0185feb88 ) );
        level thread zm_quest::start_quest( str_quest_ref );
        level zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"totem", 1 );
        level zm_quest::function_98432f89334662d5( #"totems", 1 );
        level zm_quest::show_splash_item_picked_up( #"totems", hashcat( #"hash_34d854f633dfd81b", info.var_8af4bb0185feb88 ), 1, self );
        level zm_quest::function_b57dfe9625966b0b( #"totems", 0, hashcat( #"hash_34d854f633dfd81b", info.var_8af4bb0185feb88 ), 1, 1 );
        level zm_quest::function_44fe3dcaa8005357();
        b_success = zm_sat_scarab_mq::function_7038fcc5de4df138( hashcat( #"pickup_totem", info.var_8af4bb0185feb88 ), "pup_tot_vo" + info.var_8af4bb0185feb88, [ self ], 0.5, 0 );
        
        if ( b_success && isalive( self ) )
        {
            var_892e986fee0a054c = self getplayerclientnum();
            level thread zm_sat_scarab_mq::play_banter_once( #"pickup_totem", "pup_tot_bant" + var_892e986fee0a054c, [ self ], undefined, 0.5 );
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xf7c20af6, Offset: 0x3812
// Size: 0xe7
function private setup_totem_braziers()
{
    level utility::flag_wait( "power_on" );
    
    foreach ( scr_brazier in level.scarab_pap_quest.var_f0218d7a43516520 )
    {
        level.zm_scarab_mq.var_6ed70c4165a62837[ int( scr_brazier.s_brazier.script_noteworthy ) ] = scr_brazier.origin + ( 0, 0, 48 );
        level thread function_fe73b751389c0e96( scr_brazier );
    }
    
    level utility::flag_set( "totem_braziers_set" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x7e1cdd5d, Offset: 0x3901
// Size: 0x36
function private setup_destroy_totem( b_skipped, b_restored )
{
    level utility::flag_wait( "sst_deto_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xaf33af66, Offset: 0x393f
// Size: 0xcc
function private function_fe73b751389c0e96( scr_brazier )
{
    var_8af4bb0185feb88 = scr_brazier.s_brazier.script_noteworthy;
    scr_brazier.var_436fc13baa7377d8 = 1;
    scr_brazier.var_18d4007b123c953a = 1;
    scr_brazier setscriptablepartstate( "health", "damage_detect" );
    scr_brazier zm_damage::register_scriptable_damage_callback( &brazier_damage_callback, 1 );
    level utility::flag_wait( "totes_check_check" + var_8af4bb0185feb88 );
    scr_brazier.interact setscriptablepartstate( "usable", "usable" );
    scr_brazier.interact utility::ent_flag_set( "enabled_for_totem" );
    level utility::registersharedfunc( #"quest", #"hash_cd5baec2a82d6549", &function_837967d38327e76c, 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x4d3b3ddf, Offset: 0x3a13
// Size: 0x1a4, Type: bool
function private function_837967d38327e76c( player, interact )
{
    var_8af4bb0185feb88 = interact.var_8af4bb0185feb88;
    
    if ( !level utility::flag( "totes_check_check" + var_8af4bb0185feb88 ) )
    {
        return false;
    }
    
    if ( level utility::flag( "totes_plop_hop" + var_8af4bb0185feb88 ) )
    {
        return false;
    }
    
    if ( interact.item )
    {
        return false;
    }
    
    if ( interact.var_87f8c6598b0699af utility::ent_flag( "is_lit" ) )
    {
        return false;
    }
    
    level utility::flag_clear( "totes_check_check" + var_8af4bb0185feb88 );
    level zm_quest::function_b57dfe9625966b0b( #"totems", 0, hashcat( #"hash_34d854f633dfd81b", var_8af4bb0185feb88 ), 0, 1 );
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
    level thread zm_quest::start_quest( str_quest_ref );
    level zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"totem", 2 );
    interact.item = function_51727b165ef51ccd( var_8af4bb0185feb88 );
    interact.item.info = { #interact:interact, #flag:"totes_check_check" + var_8af4bb0185feb88, #var_8af4bb0185feb88:var_8af4bb0185feb88, #item:interact.item };
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, interact.item.info );
    level utility::flag_set( "totes_plop_hop" + var_8af4bb0185feb88 );
    level thread function_6c8683f5decc16a5( undefined, int( var_8af4bb0185feb88 ) );
    return true;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xe0f6e1a0, Offset: 0x3bc0
// Size: 0xa8
function private function_51727b165ef51ccd( var_8af4bb0185feb88 )
{
    s_spawn = utility::getstruct( "brazier_tot_drop" + var_8af4bb0185feb88 );
    spawnoptions = common_item::function_bc5ff2958b71a708( s_spawn.origin, s_spawn.angles );
    spawnoptions.critical = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.var_9161cf0784b6951d = 1;
    var_b603a7fc89cd1871 = hashcat( %"hash_22f46ea7bb3721e4", var_8af4bb0185feb88 );
    return common_item::function_61c2c0251e742ffd( var_b603a7fc89cd1871, 1, spawnoptions );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xae425cec, Offset: 0x3c71
// Size: 0x204
function private brazier_damage_callback( params )
{
    if ( !self.interact.item )
    {
        return -1;
    }
    
    if ( utility::ent_flag( "is_lit" ) )
    {
        return -1;
    }
    
    if ( self.interact.item && isplayer( params.eattacker ) && params.einflictor.equipinfo.fireballs )
    {
        if ( !level utility::flag( "temple_channeling_" + self.interact.var_8af4bb0185feb88 ) || !params.einflictor.equipinfo.var_997d4b6005a845d1 )
        {
            level thread zm_sat_scarab_mq::function_7038fcc5de4df138( "twins_fail" + randomintrange( 1, 4 ), "tw_to_dest_nop_vo", [ params.eattacker ], 1 );
        }
    }
    
    if ( !level utility::flag( "temple_channeling_" + self.interact.var_8af4bb0185feb88 ) )
    {
        return -1;
    }
    
    if ( isplayer( params.eattacker ) && params.einflictor.equipinfo.fireballs )
    {
        params.einflictor.equipinfo.b_skip_molotov = 1;
        
        if ( params.einflictor.equipinfo.var_997d4b6005a845d1 )
        {
            utility::ent_flag_set( "has_cosmic_power" );
            
            if ( self.interact.item )
            {
                thread function_b8a696d716d162ed();
            }
            
            thread function_983330d5416ead8c( self.interact.var_8af4bb0185feb88 );
        }
        
        level utility::delaythread( 0.05, &function_24b3d440708b288, params.einflictor.equipinfo );
    }
    
    return -1;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xbbc9ce7, Offset: 0x3e7e
// Size: 0x1e
function private function_24b3d440708b288( equipinfo )
{
    if ( equipinfo )
    {
        equipinfo.b_skip_molotov = 0;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0xc
// Checksum 0x30520fbb, Offset: 0x3ea4
// Size: 0x83
function private function_983330d5416ead8c( var_8af4bb0185feb88 )
{
    self notify( #"hash_e59b730fd1c65ffb" );
    self endon( #"hash_e59b730fd1c65ffb" );
    zm_sat_scarab_pap_quest::function_760e6888e3e99e1d( 1 );
    utility::function_7c10ea82c1e305b8( "usable", "usable" );
    level utility::flag_waitopen( "temple_channeling_" + var_8af4bb0185feb88 );
    thread zm_sat_scarab_pap_quest::function_760e6888e3e99e1d( 0 );
    level utility::flag_wait( "sst_deto_check" + var_8af4bb0185feb88 );
    utility::ent_flag_waitopen_any( "is_lit" );
    utility::function_7c10ea82c1e305b8( "usable", "off" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xb9dbad6c, Offset: 0x3f2f
// Size: 0x18e
function private function_b8a696d716d162ed()
{
    self.interact.item function_7653c765b6c7b815();
    wait 3.5;
    playsoundatpos( self.origin + ( 0, 0, 30 ), "evt_scarab_mq_important_item_cleansed" );
    level zm_music::function_446e6e39d7feeb7c( get_temple_zones( int( self.interact.var_8af4bb0185feb88 ) ), hashcat( #"hash_b477f49864b6996b", get_shadowsmith_str( int( self.interact.var_8af4bb0185feb88 ) ) ) );
    level utility::flag_set( "sst_deto_check" + self.interact.var_8af4bb0185feb88 );
    level callback::remove( #"player_item_pickup", &function_9a8e22688a7c3c11, self.interact.item.info );
    self.interact.item freescriptable();
    self.interact utility::ent_flag_clear( "enabled_for_totem" );
    level zm_quest::function_b57dfe9625966b0b( #"totems", 0, hashcat( #"hash_34d854f633dfd81b", self.interact.var_8af4bb0185feb88 ), 1, 0 );
    level thread zm_sat_scarab_mq::function_7038fcc5de4df138( hashcat( #"destroy_totem", self.interact.var_8af4bb0185feb88 ), "des_tot_vo" + self.interact.var_8af4bb0185feb88, undefined, 0.5, 0 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x90a7047f, Offset: 0x40c5
// Size: 0x68
function private function_b62cc1f3fac55f47()
{
    level waittill( #"on_round_end" );
    level.zm_scarab_mq.brick_prime.var_b590d0da09e22a56 = 1;
    function_4b9e25867fd1ae5a( { #radius:8, #origin:level.zm_scarab_mq.brick_prime.origin } );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x535802f8, Offset: 0x4135
// Size: 0xd1
function private cleanup_destroy_totem( b_skipped, b_restored )
{
    level utility::flag_set( "sst_deto_check" + self.quest.var_8af4bb0185feb88 );
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( self.quest.var_8af4bb0185feb88 ) );
    level zm_quest::function_6265be8d0549e1b1( str_quest_ref, #"totem" );
    zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"hash_9e8ab98e1b6a808c", 1 );
    level thread function_ba826c5ce59b4896( level.zm_scarab_mq.var_6ed70c4165a62837[ self.quest.var_8af4bb0185feb88 ], self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x45cfa4e4, Offset: 0x420e
// Size: 0x36
function private setup_break_shackle( b_skipped, b_restored )
{
    level utility::flag_wait( "sst_brch_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x51d9c8ee, Offset: 0x424c
// Size: 0x3ec
function private function_ba826c5ce59b4896( v_origin, n_curse_id )
{
    level utility::flag_wait( "totem_braziers_set" );
    
    if ( !isdefined( v_origin ) )
    {
        v_origin = level.zm_scarab_mq.var_6ed70c4165a62837[ n_curse_id ];
    }
    
    e_fx = function_329e33697847fc8b( v_origin, n_curse_id );
    e_fx function_616378d7e5b22efb( ( 1, 0, 0 ), 3, 2 );
    wait 0.5;
    
    if ( level utility::flag( "sst_brch_check" + n_curse_id ) )
    {
        cleanup_curse_fx( e_fx );
        level thread function_6c8683f5decc16a5( undefined, n_curse_id );
        return;
    }
    
    n_searches = 0;
    var_6ee19b04cf94c0bf = 0;
    n_search_radius = 200;
    
    do
    {
        a_ai = getaiarrayinradius( v_origin, n_search_radius, level.var_ece703e3d116381c );
        a_ai = utility::get_array_of_closest( v_origin, a_ai );
        
        foreach ( ai in a_ai )
        {
            if ( !ai.var_26c0e7ecbfd56e77 && !ai.var_51fd73c7ce409d74 && !ai.var_65de3f7c461c1611 && ( ai.is_living_world_ai ? ai.var_9686e1897a9ce028 : 1 ) && !ai.b_in_spawn_closet && isalive( ai ) && issubstr( ai.subclass, "zombie_base" ) && ai getscriptablehaspart( "scarab_curse" ) )
            {
                if ( sighttracepassed( v_origin, ai getcentroid(), 0, ai ) )
                {
                    var_4765e06f51aa609 = ai;
                    var_4765e06f51aa609.var_51fd73c7ce409d74 = 1;
                    break;
                }
            }
        }
        
        if ( !var_4765e06f51aa609 || !isalive( var_4765e06f51aa609 ) )
        {
            wait 1;
            n_searches++;
            
            if ( n_searches > 10 )
            {
                if ( var_6ee19b04cf94c0bf < 4 )
                {
                    n_search_radius *= 1.25;
                    n_searches = 0;
                    var_6ee19b04cf94c0bf++;
                }
                else
                {
                    /#
                        iprintln( "<dev string:x24>" );
                    #/
                    
                    cleanup_curse_fx( e_fx );
                    level thread function_ba826c5ce59b4896( level.zm_scarab_mq.var_6ed70c4165a62837[ n_curse_id ], n_curse_id );
                    return;
                }
            }
            
            continue;
        }
        
        n_searches = 0;
        
        do
        {
            v_move = var_4765e06f51aa609 getcentroid();
            n_time = max( 0.11, distance( v_move, e_fx.origin ) / 256 );
            e_fx moveto( v_move, n_time, 0.1 );
            wait n_time * 0.5;
        }
        while ( isalive( var_4765e06f51aa609 ) && distancesquared( v_move, e_fx.origin ) > 1024 );
    }
    while ( !var_4765e06f51aa609 || !isalive( var_4765e06f51aa609 ) || !var_4765e06f51aa609 getscriptablehaspart( "scarab_curse" ) );
    
    assert( isalive( var_4765e06f51aa609 ) );
    var_4765e06f51aa609.var_26c0e7ecbfd56e77 = n_curse_id;
    var_4765e06f51aa609.b_cleanup_no_respawn = 1;
    var_4765e06f51aa609.ignore_enemy_count = 1;
    var_4765e06f51aa609.var_15598d8e493afe88 = 1;
    var_4765e06f51aa609.var_825b17c932865df = 1;
    var_4765e06f51aa609 val::set( "scarab_curse", "ignore_cleanup", 1 );
    var_4765e06f51aa609 utility::callsharedfunc( #"w_mod", #"wisp_ignore", "cursed_ai" );
    var_4765e06f51aa609 callback::add( "on_zombie_ai_killed", &function_560e63759bce741c );
    var_4765e06f51aa609 setscriptablepartstate( "scarab_curse", "curse" + n_curse_id );
    level.zm_scarab_mq.a_curses[ n_curse_id ] = var_4765e06f51aa609;
    level thread function_6c8683f5decc16a5( undefined, n_curse_id );
    cleanup_curse_fx( e_fx );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xf859053e, Offset: 0x4640
// Size: 0xd1
function private function_329e33697847fc8b( v_origin, n_curse_id )
{
    e_fx = utility::spawn_model( "tag_origin", v_origin, ( -90, 0, 0 ) );
    e_fx.scriptable_curse = spawnscriptable( %"hash_3af02d20e7f2b8b0", v_origin, ( 0, 0, 0 ) );
    e_fx.scriptable_curse setscriptablepartstate( "vfx", "curse" + n_curse_id );
    e_fx.scriptable_curse scriptablesetparententity( e_fx, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.zm_scarab_mq.a_curses[ n_curse_id ] = e_fx;
    level thread function_6c8683f5decc16a5( undefined, n_curse_id );
    return e_fx;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xaf206402, Offset: 0x471a
// Size: 0x59
function private cleanup_curse_fx( e_fx )
{
    e_fx.scriptable_curse setscriptablepartstate( "vfx", "off" );
    playworldsound( e_fx.origin, #"hash_6940b3cc0ae0017e" );
    wait 1;
    e_fx.scriptable_curse freescriptable();
    e_fx delete();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x8c39f464, Offset: 0x477b
// Size: 0xaf
function private function_560e63759bce741c( params )
{
    self setscriptablepartstate( "scarab_curse", "off" );
    playworldsound( self.origin + ( 0, 0, 50 ), #"hash_6940b3cc0ae0017e" );
    n_curse = self.var_26c0e7ecbfd56e77;
    
    if ( params.einflictor.var_e7c57daaf2fdcd74 && self.var_9387a792d7b6e180 )
    {
        if ( function_349aeefecfdc687f( self.var_9387a792d7b6e180, n_curse ) )
        {
            level utility::flag_set( "sst_brch_check" + n_curse );
            return;
        }
    }
    
    level thread function_ba826c5ce59b4896( self getcentroid(), n_curse );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xc6a276a0, Offset: 0x4832
// Size: 0x80, Type: bool
function private function_349aeefecfdc687f( var_9387a792d7b6e180, n_curse )
{
    if ( !var_9387a792d7b6e180 )
    {
        return false;
    }
    
    if ( issubstr( var_9387a792d7b6e180, "right_a" ) && n_curse == 1 || issubstr( var_9387a792d7b6e180, "left_a" ) && n_curse == 2 || issubstr( var_9387a792d7b6e180, "right_b" ) && n_curse == 3 || issubstr( var_9387a792d7b6e180, "left_b" ) && n_curse == 4 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x784e0b7e, Offset: 0x48bb
// Size: 0x79
function private function_dff04d37af350ef5( var_8af4bb0185feb88 )
{
    switch ( var_8af4bb0185feb88 )
    {
        case 1:
            return "right_a";
        case 2:
            return "left_a";
        case 3:
            return "right_b";
        case 4:
            return "left_b";
        default:
            break;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x984cdf4b, Offset: 0x493c
// Size: 0x1fe
function private function_213c0ae839d2280b( var_8af4bb0185feb88 )
{
    if ( isdefined( level.var_c9baedcff921facc ) )
    {
        foreach ( var_f5d93163bb80f7b in level.var_c9baedcff921facc )
        {
            if ( var_8af4bb0185feb88 == 4 && var_f5d93163bb80f7b.script_label == "_b" )
            {
                var_f5d93163bb80f7b.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "shackle_dissolve_4", "dissolve" );
                var_f5d93163bb80f7b.a_switch_pos[ 0 ].interact notify( #"run_out_of_duration" );
                continue;
            }
            
            if ( var_8af4bb0185feb88 == 3 && var_f5d93163bb80f7b.script_label == "_b" )
            {
                var_f5d93163bb80f7b.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "shackle_dissolve_3", "dissolve" );
                var_f5d93163bb80f7b.a_switch_pos[ 0 ].interact notify( #"run_out_of_duration" );
                continue;
            }
            
            if ( var_8af4bb0185feb88 == 2 && var_f5d93163bb80f7b.script_label == "_a" )
            {
                var_f5d93163bb80f7b.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "shackle_dissolve_2", "dissolve" );
                var_f5d93163bb80f7b.a_switch_pos[ 0 ].interact notify( #"run_out_of_duration" );
                continue;
            }
            
            if ( var_8af4bb0185feb88 == 1 && var_f5d93163bb80f7b.script_label == "_a" )
            {
                var_f5d93163bb80f7b.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "shackle_dissolve_1", "dissolve" );
                var_f5d93163bb80f7b.a_switch_pos[ 0 ].interact notify( #"run_out_of_duration" );
            }
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0
// Checksum 0x5d77a782, Offset: 0x4b42
// Size: 0xcd
function function_c6ae78e247cbfeca()
{
    b_success = zm_sat_scarab_mq::function_7038fcc5de4df138( hashcat( #"titan_free", self.quest.var_8af4bb0185feb88 ), "tit_fre_vo" + self.quest.var_8af4bb0185feb88, undefined, 1.5, 0 );
    var_466a89b1300a34c9 = utility::flag( "sst_brch_check" + 2 ) && utility::flag( "sst_brch_check" + 3 ) && utility::flag( "sst_brch_check" + 4 ) && utility::flag( "sst_brch_check" + 1 );
    
    if ( b_success && var_466a89b1300a34c9 )
    {
        zm_quest::function_d5ef98341fd6a057( [ #"hash_4fbec6a13133e73c" ] );
        level.var_7315ae0dd159a3d6 = 1;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xf3d84f7e, Offset: 0x4c17
// Size: 0xc8
function private cleanup_break_shackle( b_skipped, b_restored )
{
    level utility::flag_set( "sst_brch_check" + self.quest.var_8af4bb0185feb88 );
    level thread function_213c0ae839d2280b( self.quest.var_8af4bb0185feb88 );
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    
    if ( !b_restored )
    {
        thread function_c6ae78e247cbfeca();
    }
    
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( self.quest.var_8af4bb0185feb88 ) );
    zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"hash_5434f02943e452c7", 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x5c258c5b, Offset: 0x4ce7
// Size: 0x5a
function private setup_reveal_corruption( b_skipped, b_restored )
{
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_reco_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x9a51dec6, Offset: 0x4d49
// Size: 0x203
function private setup_uncorrupted_visage( var_af2c5380593e3cfa )
{
    s_visage = utility::getstruct( "tmp_base_" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    scr_visage = spawnscriptable( %"zm_sat_scarab_visage", s_visage.origin, s_visage.angles );
    scr_visage setscriptablepartstate( "model", "on_" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    scr_visage setscriptablepartstate( "ping", "on_" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    var_b3cc6827bf1dc84c = 20000 + 5000 * level.players.size;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_b3cc6827bf1dc84c *= 0.666;
    }
    
    scr_visage.var_8af4bb0185feb88 = var_af2c5380593e3cfa.var_8af4bb0185feb88;
    scr_visage.health = var_b3cc6827bf1dc84c;
    scr_visage.maxhealth = var_b3cc6827bf1dc84c;
    scr_visage.shadow_soul_enabled = 1;
    scr_visage.shadow_soul_phase = 1;
    scr_visage.shadow_souls = [];
    scr_visage.shadow_soul_fly_speed = 200;
    scr_visage.var_52d1141310b97f2 = 2;
    scr_visage.shadow_soul_teleport_range = 10000;
    scr_visage.var_92d7a886edd44579 = 0.25;
    scr_visage.var_b132e4221924c798 = 0.95;
    var_709229aacf05d8ee = getscriptbundlefieldvalue( %"hash_3d414eac19598759", #"hash_b6722c0f2d54c23f" );
    utility::add_fx( "weyward_shadow_soul_beam", var_709229aacf05d8ee );
    scr_visage zm_damage::register_scriptable_damage_callback( &function_c590c627f45072e5, 1 );
    var_af2c5380593e3cfa.scr_visage = scr_visage;
    s_visage.scr_visage = scr_visage;
    scr_visage.e_beam_target = utility::spawn_model( "tag_origin", scr_visage.origin + ( 0, 0, 64 ), scr_visage.angles );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xa6658636, Offset: 0x4f54
// Size: 0x235
function private do_wall_reveal( var_af2c5380593e3cfa, b_restored )
{
    setup_uncorrupted_visage( var_af2c5380593e3cfa );
    zm_save::function_1f44a48caae2acbf();
    
    if ( level utility::flag( "sst_made_nice" + var_af2c5380593e3cfa.var_8af4bb0185feb88 ) )
    {
        return;
    }
    
    wait 0.2;
    scr_wall = getentitylessscriptablearray( "tmp_wall_dest" + var_af2c5380593e3cfa.var_8af4bb0185feb88, #script_noteworthy )[ 0 ];
    scr_wall setscriptablepartstate( "vfx", "destroy" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    earthquake( 0.4, 2, scr_wall.origin, 3000 );
    playrumbleonposition( "zm_scarab_ruins_channel", scr_wall.origin );
    e_wall = getent( "tmp_wall_" + var_af2c5380593e3cfa.var_8af4bb0185feb88, #targetname );
    e_wall hide();
    activateworldevent( "we_lgt_tmp_rvl_" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    
    if ( b_restored )
    {
        return;
    }
    
    wait 0.5;
    b_success = zm_sat_scarab_mq::function_7038fcc5de4df138( hashcat( #"visage_reveal", var_af2c5380593e3cfa.var_8af4bb0185feb88 ), "tmp_vrv_vo" + var_af2c5380593e3cfa.var_8af4bb0185feb88 );
    
    if ( b_success )
    {
        var_560c3317f21f37f5 = function_4d7f96fec6a2218c( var_af2c5380593e3cfa.var_8af4bb0185feb88 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player function_1fc3084d1cec7d38( var_560c3317f21f37f5 ) )
            {
                b_banter = zm_sat_scarab_mq::play_banter_once( hashcat( #"visage_response", var_af2c5380593e3cfa.var_8af4bb0185feb88 ), "tmp_vrs_vo" + var_af2c5380593e3cfa.var_8af4bb0185feb88, [ player ] );
                
                if ( b_banter )
                {
                    break;
                }
            }
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x5b0c786f, Offset: 0x5191
// Size: 0x29
function private function_36fa69e313f34341()
{
    level utility::flag_wait( "mana_focus_out" + self.var_8af4bb0185feb88 );
    self.mana_focus thread drop_mana_focus();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xb23f5c16, Offset: 0x51c2
// Size: 0x59
function private cleanup_reveal_corruption( b_skipped, b_restored )
{
    level utility::flag_set( "sst_reco_check" + self.quest.var_8af4bb0185feb88 );
    level thread do_wall_reveal( self.quest, b_restored );
    self.quest thread function_36fa69e313f34341();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xefb35afd, Offset: 0x5223
// Size: 0x51
function private function_33a3d1acc30ad33d( b_skipped, b_restored )
{
    level thread function_288af2dc25f695a1( self.quest.var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_unfo_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x5510baf6, Offset: 0x527c
// Size: 0x345
function private function_288af2dc25f695a1( var_8af4bb0185feb88 )
{
    level utility::flag_wait( "begin_round_logic" );
    
    switch ( var_8af4bb0185feb88 )
    {
        case 1:
            var_1e345f52938fe1f4 = 30;
            var_b246ad36d58567a8 = 10;
            var_ec8616effcfb8acd = &function_ef2e3738dc67ca59;
            break;
        case 2:
            var_1e345f52938fe1f4 = 15;
            var_b246ad36d58567a8 = 5;
            var_ec8616effcfb8acd = &function_14fc1cb15d9f8555;
            break;
        case 3:
            level thread function_421df0fe8e9a439c( var_8af4bb0185feb88 );
            return;
        case 4:
            var_1e345f52938fe1f4 = 30;
            var_b246ad36d58567a8 = 10;
            var_ec8616effcfb8acd = &function_24a4bf23c1098a7;
            break;
    }
    
    var_1e345f52938fe1f4 += ( level.players.size - 1 ) * var_b246ad36d58567a8;
    var_1e345f52938fe1f4 *= 10;
    var_560c3317f21f37f5 = function_4d7f96fec6a2218c( var_8af4bb0185feb88 );
    
    while ( !level utility::flag( "sst_unfo_check" + var_8af4bb0185feb88 ) )
    {
        if ( !level utility::flag( "temple_channeling_" + var_8af4bb0185feb88 ) )
        {
            level utility::flag_wait( "temple_channeling_" + var_8af4bb0185feb88 );
        }
        
        var_db6699ad7aafe9aa = 0;
        
        while ( level utility::flag( "temple_channeling_" + var_8af4bb0185feb88 ) )
        {
            var_c07b8739b65f2423 = 0;
            
            foreach ( player in level.players )
            {
                if ( player.n_progress_to_add || player function_1fc3084d1cec7d38( var_560c3317f21f37f5 ) )
                {
                    var_c07b8739b65f2423 = 1;
                    break;
                }
            }
            
            if ( !var_c07b8739b65f2423 )
            {
                wait 1;
                continue;
            }
            
            var_3471316e3ec32d4a = 0;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player [[ var_ec8616effcfb8acd ]]() )
                {
                    var_3471316e3ec32d4a++;
                    continue;
                }
                
                if ( player.n_progress_to_add )
                {
                    var_3471316e3ec32d4a += player.n_progress_to_add * 10;
                    player.n_progress_to_add = undefined;
                }
            }
            
            if ( !var_3471316e3ec32d4a )
            {
                wait 0.1;
                continue;
            }
            
            var_db6699ad7aafe9aa += var_3471316e3ec32d4a;
            var_22940d247257fa31 = int( var_db6699ad7aafe9aa / var_1e345f52938fe1f4 * 100 );
            str_shadowsmith = get_shadowsmith_str( var_8af4bb0185feb88 );
            quest = zm_quest::get_quest( hashcat( #"hash_5267022c69306b07", str_shadowsmith ) );
            quest.var_2bb17d5d51b95136 = var_22940d247257fa31;
            
            /#
                iprintln( "<dev string:x38>" + var_22940d247257fa31 + "<dev string:x43>" );
            #/
            
            function_257a1aeca8660904( var_8af4bb0185feb88, var_22940d247257fa31 );
            level thread function_6c8683f5decc16a5( undefined, var_8af4bb0185feb88, var_22940d247257fa31 );
            
            if ( var_22940d247257fa31 > 99 )
            {
                level utility::flag_set( "sst_unfo_check" + var_8af4bb0185feb88 );
                return;
            }
            
            wait 0.1;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xac8d2950, Offset: 0x55c9
// Size: 0x2b0
function private function_421df0fe8e9a439c( var_8af4bb0185feb88 )
{
    var_1e345f52938fe1f4 = 3 + level.players.size - 1;
    level.zm_scarab_mq.var_2a5a3c9f5980624f = 0;
    level.zm_scarab_mq.var_f32ebe20904595f = { #var_8af4bb0185feb88:var_8af4bb0185feb88 };
    
    while ( !level utility::flag( "sst_unfo_check" + var_8af4bb0185feb88 ) )
    {
        if ( !level utility::flag( "temple_channeling_" + var_8af4bb0185feb88 ) )
        {
            level utility::flag_wait( "temple_channeling_" + var_8af4bb0185feb88 );
        }
        
        foreach ( player in level.players )
        {
            if ( !player callback::exists( #"hash_42a07c459e05796d", &function_f2d22baa322e97f4, level.zm_scarab_mq.var_f32ebe20904595f ) )
            {
                player callback::add( #"hash_42a07c459e05796d", &function_f2d22baa322e97f4, level.zm_scarab_mq.var_f32ebe20904595f );
            }
        }
        
        level waittill( #"hash_c4a3e6e68a82acdf" );
        var_22940d247257fa31 = int( level.zm_scarab_mq.var_2a5a3c9f5980624f / var_1e345f52938fe1f4 * 100 );
        
        /#
            iprintln( "<dev string:x38>" + var_22940d247257fa31 + "<dev string:x43>" );
        #/
        
        function_257a1aeca8660904( var_8af4bb0185feb88, var_22940d247257fa31 );
        level thread function_6c8683f5decc16a5( undefined, var_8af4bb0185feb88, var_22940d247257fa31 );
        
        if ( var_22940d247257fa31 > 99 )
        {
            level utility::flag_set( "sst_unfo_check" + var_8af4bb0185feb88 );
            activateworldevent( "we_sat_zm_scarab_temple" + var_8af4bb0185feb88 + "_fog1" );
            activateworldevent( "we_sat_zm_scarab_temple" + var_8af4bb0185feb88 + "_fog2" );
            activateworldevent( "we_sat_zm_scarab_temple" + var_8af4bb0185feb88 + "_fog3" );
            activateworldevent( "we_sat_zm_scarab_temple" + var_8af4bb0185feb88 + "_fog4" );
            
            foreach ( player in level.players )
            {
                player callback::remove( #"hash_42a07c459e05796d", &function_f2d22baa322e97f4, level.zm_scarab_mq.var_f32ebe20904595f );
            }
            
            return;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x3650f43d, Offset: 0x5881
// Size: 0x7e
function private function_f2d22baa322e97f4( params, info )
{
    if ( !level utility::flag( "temple_channeling_" + info.var_8af4bb0185feb88 ) )
    {
        return;
    }
    
    if ( !is_on_tile( info.var_8af4bb0185feb88 ) )
    {
        return;
    }
    
    level.zm_scarab_mq.var_2a5a3c9f5980624f += 1;
    level notify( #"hash_c4a3e6e68a82acdf" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x968bd3d3, Offset: 0x5907
// Size: 0x73
function private function_257a1aeca8660904( var_8af4bb0185feb88, var_22940d247257fa31 )
{
    if ( var_22940d247257fa31 > 85 )
    {
        var_6694135a711872c9 = 1;
    }
    else if ( var_22940d247257fa31 > 66 )
    {
        var_6694135a711872c9 = 2;
    }
    else if ( var_22940d247257fa31 > 33 )
    {
        var_6694135a711872c9 = 3;
    }
    else if ( var_22940d247257fa31 > 10 )
    {
        var_6694135a711872c9 = 4;
    }
    
    if ( var_6694135a711872c9 )
    {
        activateworldevent( "we_sat_zm_scarab_temple" + var_8af4bb0185feb88 + "_fog" + var_6694135a711872c9 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x895b6a3c, Offset: 0x5982
// Size: 0x25, Type: bool
function private function_14fc1cb15d9f8555()
{
    if ( !self.var_6ec27154624f478b && is_on_tile( 2 ) )
    {
        thread function_fcf8db1cb2c6493b();
        return false;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x87a9996d, Offset: 0x59b0
// Size: 0xb1
function private function_fcf8db1cb2c6493b()
{
    self endon( #"death" );
    level endon( "sst_unfo_check" + 2 );
    self.var_6ec27154624f478b = 1;
    
    while ( ( self isonground() || !self isjumping() ) && is_on_tile( 2 ) )
    {
        waitframe();
    }
    
    if ( !self isonground() || self isjumping() )
    {
        n_air_start = gettime();
        
        while ( !self isonground() || self isjumping() )
        {
            waitframe();
        }
        
        if ( is_on_tile( 2 ) )
        {
            self.n_progress_to_add = utility::function_6f5d2e1f1ff70482( gettime() - n_air_start );
            thread function_fcf8db1cb2c6493b();
            return;
        }
    }
    
    self.var_6ec27154624f478b = undefined;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xfabe2236, Offset: 0x5a69
// Size: 0x20, Type: bool
function private function_ef2e3738dc67ca59()
{
    if ( self getstance() == "prone" && is_on_tile( 1 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x746d99ed, Offset: 0x5a92
// Size: 0x1d, Type: bool
function private function_24a4bf23c1098a7()
{
    if ( self playerads() == 1 && is_on_tile( 4 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x9647e97c, Offset: 0x5ab8
// Size: 0x58, Type: bool
function private is_on_tile( var_8af4bb0185feb88 )
{
    e_tile = getent( "tmp_ground_vol_" + var_8af4bb0185feb88, #targetname );
    
    if ( !e_tile )
    {
        e_tile = getent( "tmp_ground_" + var_8af4bb0185feb88, #targetname );
    }
    
    if ( self istouching( e_tile ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x8bc8f561, Offset: 0x5b19
// Size: 0x32d
function private move_cover( var_8af4bb0185feb88 )
{
    if ( self.mana_focus )
    {
        return;
    }
    
    e_cover = getent( "tmp_ground_" + var_8af4bb0185feb88, #targetname );
    playworldsound( e_cover.origin + ( 0, 0, 15 ), "evt_scarab_mq_tile_success_stinger" );
    wait 1.5;
    playworldsound( e_cover.origin + ( 0, 0, 15 ), "evt_scarab_mq_tile_move" );
    s_focus = utility::getstruct( "mana_focus_" + var_8af4bb0185feb88 );
    s_linker = utility::getstruct( "mana_linker_" + var_8af4bb0185feb88 );
    e_mover = utility::spawn_model( "tag_origin", s_linker.origin, s_linker.angles );
    self.mana_focus = spawnscriptable( %"hash_7510cf6229adc6ca", s_focus.origin, s_focus.angles );
    self.mana_focus scriptablesetparententity( e_mover, ( 0, 0, 0 ), e_mover.angles - self.mana_focus.angles );
    self.mana_focus setscriptablepartstate( "ping", "on" );
    self.mana_focus.e_mover = e_mover;
    self.mana_focus.var_8af4bb0185feb88 = self.var_8af4bb0185feb88;
    self.mana_focus.var_a47d6e5a55aa75e6 = zm_quest::function_73720cdf21c3cfd7( hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) ), #"souls_captured" ) ?? 0;
    self.mana_focus.var_436fc13baa7377d8 = 1;
    self.mana_focus.var_18d4007b123c953a = 1;
    playrumblelooponposition( "low_highfreq", e_cover.origin );
    earthquake( 0.15, 4.5, e_cover.origin, 2500 );
    e_cover moveto( e_cover.origin + ( 0, 0, 6 ), 1 );
    e_cover waittill( #"movedone" );
    var_b5df4fecfe221d5 = utility::getstruct( "tmp_ground_facing_" + var_8af4bb0185feb88 );
    e_cover moveto( var_b5df4fecfe221d5.origin, 3.5 );
    e_cover rotateto( var_b5df4fecfe221d5.angles, 4 );
    e_cover waittill( #"movedone" );
    stopallrumbles();
    level utility::flag_set( "mana_focus_ready" + var_8af4bb0185feb88 );
    self.mana_focus zm_damage::register_scriptable_damage_callback( &function_4ca71bd1028b8878, 1 );
    
    while ( self.mana_focus )
    {
        level utility::flag_wait( "nexus_platforms_moving" );
        
        if ( level utility::flag( "sst_rafo_check" + self.var_8af4bb0185feb88 ) )
        {
            self.mana_focus thread drop_mana_focus();
        }
        
        level utility::flag_waitopen( "nexus_platforms_moving" );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xeda16e07, Offset: 0x5e4e
// Size: 0x174
function private function_220d96c2fa7d99e8( b_skipped, b_restored )
{
    level utility::flag_set( "sst_unfo_check" + self.quest.var_8af4bb0185feb88 );
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( self.quest.var_8af4bb0185feb88 ) );
    zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"hash_d520b08207825109", 1 );
    self.quest thread move_cover( self.quest.var_8af4bb0185feb88 );
    
    if ( self.quest.var_3599b5b78bd2cfd3 )
    {
        self.quest.var_3599b5b78bd2cfd3 freescriptable();
    }
    
    if ( b_skipped || b_restored )
    {
        activateworldevent( "we_sat_zm_scarab_temple" + self.quest.var_8af4bb0185feb88 + "_fog" + 1 );
        activateworldevent( "we_sat_zm_scarab_temple" + self.quest.var_8af4bb0185feb88 + "_fog" + 2 );
        activateworldevent( "we_sat_zm_scarab_temple" + self.quest.var_8af4bb0185feb88 + "_fog" + 3 );
        activateworldevent( "we_sat_zm_scarab_temple" + self.quest.var_8af4bb0185feb88 + "_fog" + 4 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xf2f2355c, Offset: 0x5fca
// Size: 0x5a
function private setup_activate_focus( b_skipped, b_restored )
{
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_rafo_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xa9002baf, Offset: 0x602c
// Size: 0x57
function private function_4ca71bd1028b8878( params )
{
    if ( weap_scarabww::function_3a1514a781375202( params ) || getdvarint( @"hash_3f250537cd05c93e", 0 ) > 1 )
    {
        level utility::flag_set( "sst_rafo_check" + self.var_8af4bb0185feb88 );
        thread launch_mana_focus( params.eattacker );
    }
    
    return -1;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xf4ee620, Offset: 0x608c
// Size: 0x188
function private launch_mana_focus( player )
{
    self endon( #"focus_drop" );
    zm_damage::function_c31f9d79d5ceb7ec( &function_4ca71bd1028b8878, 0 );
    self setscriptablepartstate( "vfx", "launch" );
    s_launch = utility::getstruct( "mana_focus_up_" + self.var_8af4bb0185feb88 );
    self.e_mover moveto( s_launch.origin, 1.5, 0.2, 1 );
    self.e_mover rotateto( s_launch.angles, 1.5, 1, 0.2 );
    wait 0.5;
    level utility::flag_set( "mana_focus_out" + self.var_8af4bb0185feb88 );
    
    if ( level utility::flag( "temple_channeling_" + self.var_8af4bb0185feb88 ) )
    {
        self.e_mover utility::delaycallendon( 1, "focus_drop", &function_616378d7e5b22efb, ( 0, 0, 1 ), 5, 9 );
        thread function_9a9ff9ffd3e47ef0();
        wait 0.5;
        b_special = zm_sat_scarab_mq::play_banter_once( hashcat( #"hash_14153b86c95e0ca7", self.var_8af4bb0185feb88 ), "fc_act_sp" + self.var_8af4bb0185feb88, [ player ] );
        
        if ( !b_special )
        {
            zm_sat_scarab_mq::play_banter_once( #"focus_activated", "fc_act_nrm", [ player ], #"bc_flavor_player_positive" );
        }
        
        return;
    }
    
    wait 0.75;
    thread drop_mana_focus();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xde399ba1, Offset: 0x621c
// Size: 0x167
function private drop_mana_focus()
{
    utility::ent_flag_set( "focus_drop" );
    level utility::flag_clear( "sst_rafo_check" + self.var_8af4bb0185feb88 );
    wait 0.1;
    zm_damage::function_c31f9d79d5ceb7ec( &mana_focus_damage_callback, 0 );
    self setscriptablepartstate( "vfx", "off" );
    playworldsound( self.origin, #"hash_8ae35cc7187a44f0" );
    
    if ( !self.e_mover )
    {
        utility::ent_flag_clear( "focus_drop" );
        return;
    }
    
    var_a9b7feac10578ed = utility::getstruct( "mana_linker_" + self.var_8af4bb0185feb88 );
    self.e_mover rotateto( var_a9b7feac10578ed.angles, 0.9, 0.8 );
    self.e_mover moveto( var_a9b7feac10578ed.origin, 0.9, 0.4, 0.1 );
    self.e_mover waittill( #"movedone" );
    self.e_mover function_616378d7e5b22efb( ( 0, 0, 0 ), 0, 1 );
    playworldsound( self.origin, #"hash_aec574d2bc1a0476" );
    level utility::flag_clear( "mana_focus_out" + self.var_8af4bb0185feb88 );
    wait 1;
    
    if ( self )
    {
        zm_damage::register_scriptable_damage_callback( &function_4ca71bd1028b8878, 1 );
        utility::ent_flag_clear( "focus_drop" );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x82df4f9e, Offset: 0x638b
// Size: 0x6e
function private function_22e045dcf206b790()
{
    level utility::flag_wait( "tmp_align_id_ready" );
    
    if ( level.zm_scarab_mq.var_d262521be8963583 != self.var_8af4bb0185feb88 )
    {
        return;
    }
    
    level utility::flag_wait( "temple_channeling_" + self.var_8af4bb0185feb88 );
    level utility::flag_wait( "mana_focus_ready" + self.var_8af4bb0185feb88 );
    self.mana_focus thread launch_mana_focus();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x2d1400ab, Offset: 0x6401
// Size: 0x8b
function private mana_focus_damage_callback( params )
{
    if ( params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath == "MOD_GRENADE_SPLASH" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return params.idamage;
    }
    
    if ( isplayer( params.eattacker ) && utility::ent_flag( "focus_beam_on" ) )
    {
        thread function_45e3dd143170f204( params );
    }
    
    return params.idamage;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0xc
// Checksum 0xd43a9cf2, Offset: 0x6495
// Size: 0x2d0
function private function_45e3dd143170f204( params )
{
    self notify( #"hash_6461dd399eac6883" );
    self endon( #"hash_6461dd399eac6883" );
    self.b_focus_spinning = 1;
    self notify( #"focus_spinning" );
    self setscriptablepartstate( "damage_audio", "on" );
    
    foreach ( e_fx in self.a_e_souls )
    {
        e_fx delete();
    }
    
    self.a_e_souls = undefined;
    var_dac75f4116c98678 = self.e_mover.origin + anglestoforward( self.e_mover.angles ) * 9;
    n_length = length( var_dac75f4116c98678 - params.vpoint );
    
    if ( n_length > 24 )
    {
        n_max_length = 30;
        n_max_spin = 20;
        var_d8ff2dc6fc8f9684 = 0.25;
    }
    else if ( n_length < 11 )
    {
        n_max_length = 11;
        n_max_spin = 2;
        var_d8ff2dc6fc8f9684 = -0.5;
    }
    else
    {
        n_max_length = 24;
        n_max_spin = 7;
        var_d8ff2dc6fc8f9684 = 0;
    }
    
    f_frac = n_length / n_max_length;
    var_e2621754b4d5328c = n_max_spin * f_frac * function_ffd57d8e903cfdbb( self.e_mover, params.vpoint, params.eattacker );
    a_axes = anglestoaxis( self.e_mover.angles );
    v_lever = self.e_mover.origin - params.vpoint;
    v_new_up = function_54fa819174727e00( a_axes[ "up" ], var_e2621754b4d5328c, v_lever );
    v_new_right = function_54fa819174727e00( a_axes[ "right" ], var_e2621754b4d5328c, v_lever );
    v_new_forward = function_54fa819174727e00( a_axes[ "forward" ], var_e2621754b4d5328c, v_lever );
    
    if ( !( isdefined( v_new_up ) && isdefined( v_new_right ) && isdefined( v_new_forward ) ) )
    {
        self.b_focus_spinning = undefined;
        return;
    }
    
    v_dest = axistoangles( v_new_forward, v_new_right, v_new_up );
    var_f0dbb570c9aa150a = 1.25 + var_d8ff2dc6fc8f9684;
    self.e_mover rotateto( v_dest, var_f0dbb570c9aa150a, 0.1, var_f0dbb570c9aa150a - 0.25 );
    self.e_mover waittill( #"rotatedone" );
    self.b_focus_spinning = undefined;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0x4
// Checksum 0xb051230a, Offset: 0x676d
// Size: 0x3d
function private function_54fa819174727e00( vector, pitch, up_vector )
{
    if ( int( length( vectorcross( vector, up_vector ) ) ) == 0 )
    {
        return;
    }
    
    return math::function_235fe1fdb403e4b2( vector, pitch, up_vector );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0x4
// Checksum 0xdd6f2dc6, Offset: 0x67b3
// Size: 0xac
function private function_ffd57d8e903cfdbb( e_focus, var_6c269b1b35003e9e, player )
{
    v_forward = anglestoforward( e_focus.angles );
    v_to_hit = vectornormalize( var_6c269b1b35003e9e - e_focus.origin + v_forward * 9 );
    var_503192e8cdf95142 = vectordot( v_to_hit, v_forward );
    
    if ( var_503192e8cdf95142 > 0 )
    {
        return -1;
    }
    
    if ( player && withinfov( e_focus.origin, e_focus.angles, player utility::get_player_camera_origin(), cos( 90 ) ) )
    {
        return -1;
    }
    
    return 1;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xbd2dd220, Offset: 0x6868
// Size: 0x1db
function private function_2c8824d469521f3a()
{
    self endon( #"focus_drop", #"death" );
    self.e_mover utility::waittill_notify_or_timeout( "rotatedone", 1.5 );
    
    if ( !self.player_trigger )
    {
        self.player_trigger = spawn( "trigger_radius", self.origin - ( 0, 0, 35 ), 0, 30, 70 );
    }
    
    while ( self.player_trigger )
    {
        self.player_trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            self.b_focus_spinning = 1;
            self notify( #"focus_spinning" );
            
            foreach ( e_fx in self.a_e_souls )
            {
                e_fx delete();
            }
            
            self.a_e_souls = undefined;
            v_rotate = ent getvelocity();
            v_rotate += ( randomintrange( 5, 10 ), randomintrange( 5, 10 ), randomintrange( 5, 10 ) );
            
            while ( length( v_rotate ) > 0 && length( v_rotate ) < 50 )
            {
                v_rotate *= 1.25;
            }
            
            ent thread function_67fe6fed4f6372cb( self, v_rotate * -1 );
            self.e_mover rotatevelocity( v_rotate, 2.75, 0.1, 0.5 );
            self.e_mover waittill( #"rotatedone" );
            self.b_focus_spinning = undefined;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xe5b8976e, Offset: 0x6a4b
// Size: 0xc1
function private function_67fe6fed4f6372cb( scr_focus, v_knockback )
{
    if ( self.b_on_mana_focus )
    {
        return;
    }
    
    scr_focus endon( #"focus_drop" );
    self endon( #"death" );
    self.b_on_mana_focus = 1;
    var_bc1b5189ed4316b8 = 50;
    
    do
    {
        scr_focus notify( #"focus_spinning" );
        
        /#
            iprintlnbold( "<dev string:x48>" );
        #/
        
        self knockback( v_knockback, var_bc1b5189ed4316b8, 1 );
        wait 0.5;
        v_knockback = vectornormalize( self.origin - scr_focus.origin );
        var_bc1b5189ed4316b8 *= 1.25;
    }
    while ( self istouching( scr_focus.player_trigger ) );
    
    self.b_on_mana_focus = undefined;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xd38a8e90, Offset: 0x6b14
// Size: 0x543
function private function_9a9ff9ffd3e47ef0()
{
    utility::ent_flag_set( "focus_beam_on" );
    
    if ( !level utility::flag( "mana_focus_on_music" + self.var_8af4bb0185feb88 ) )
    {
        level utility::flag_set( "mana_focus_on_music" + self.var_8af4bb0185feb88 );
        level zm_music::function_446e6e39d7feeb7c( get_temple_zones( self.var_8af4bb0185feb88 ), hashcat( #"hash_dcb6828d1193f611", get_shadowsmith_str( self.var_8af4bb0185feb88 ) ) );
    }
    
    thread function_2c8824d469521f3a();
    thread function_ae20ae17613b2454();
    self waittill( #"beam_ready" );
    zm_damage::register_scriptable_damage_callback( &mana_focus_damage_callback, 1 );
    
    if ( !self.var_36a423cad43fe7bd )
    {
        s_info = { #scriptable:self };
        level callback::add( "on_zombie_ai_killed", &function_e8640775c152f68, s_info );
        self.var_36a423cad43fe7bd = 1;
    }
    
    var_70443eb0c5220d9e = getent( "tmp_wall_" + self.var_8af4bb0185feb88, #targetname );
    v_wall_center = var_70443eb0c5220d9e.origin + anglestoup( var_70443eb0c5220d9e.angles ) * 75 + anglestoright( var_70443eb0c5220d9e.angles ) * 75;
    var_70443eb0c5220d9e.v_wall_center = v_wall_center;
    s_trace_contents = trace::create_default_contents();
    
    while ( self.e_beam_end )
    {
        str_notify = utility::waittill_any_return( "focus_spinning", "focus_drop", "death" );
        
        if ( str_notify != "focus_spinning" )
        {
            break;
        }
        
        var_d6c6297634753e2a = self.var_a98b32c9a9122957;
        var_4f9e7fcfaff7f3ea = undefined;
        
        while ( !utility::ent_flag( "focus_drop" ) )
        {
            v_forward = anglestoforward( self.e_mover.angles );
            v_start = self.origin + v_forward * 32;
            v_end = self.origin + v_forward * 3200;
            results = trace::sphere_trace( v_start, v_end, 2, self.e_mover, s_trace_contents );
            self.e_beam_end.origin = results[ "position" ] ?? v_end;
            self.e_beam_end.angles = self.e_mover.angles;
            var_92b21ca8efb6aef2 = undefined;
            e_hit_ent = results[ "entity" ];
            
            if ( e_hit_ent == var_70443eb0c5220d9e )
            {
                var_92b21ca8efb6aef2 = distancesquared( v_wall_center, self.e_beam_end.origin );
                
                /#
                    debugstar( v_wall_center );
                #/
            }
            
            if ( var_92b21ca8efb6aef2 < 2304 )
            {
                self.var_a98b32c9a9122957 = 1;
                
                if ( self.b_bobbing )
                {
                    self.e_mover function_616378d7e5b22efb( ( 0, 0, 0 ), 0, 1 );
                    self.b_bobbing = 0;
                }
                
                /#
                    iprintlnbold( "<dev string:x6b>" );
                #/
            }
            else
            {
                self.var_a98b32c9a9122957 = 0;
                
                if ( !self.b_bobbing )
                {
                    v_up = anglestoup( self.e_mover.angles );
                    self.e_mover function_616378d7e5b22efb( v_up, 5, 9 );
                    self.b_bobbing = 1;
                }
                
                if ( var_4f9e7fcfaff7f3ea && e_hit_ent != var_4f9e7fcfaff7f3ea )
                {
                    var_4f9e7fcfaff7f3ea.var_9a9e40aacec7fbaa = undefined;
                }
                
                if ( isalive( e_hit_ent ) && e_hit_ent.subclass == "zombie_wither_shadow" )
                {
                    n_damage = int( e_hit_ent.maxhealth * 0.01 );
                    e_hit_ent dodamage( n_damage, self.e_beam_end.origin, self.e_beam_end );
                }
                else if ( !e_hit_ent.var_9e25acc0255a03ed && isai( e_hit_ent ) && ( issubstr( e_hit_ent.subclass, "zombie_base" ) || e_hit_ent.subclass == "zombie_loom_minion" ) )
                {
                    if ( !e_hit_ent.var_9a9e40aacec7fbaa )
                    {
                        e_hit_ent.var_9a9e40aacec7fbaa = gettime();
                        var_4f9e7fcfaff7f3ea = e_hit_ent;
                    }
                    else if ( gettime() > e_hit_ent.var_9a9e40aacec7fbaa + 250 )
                    {
                        e_hit_ent.var_9e25acc0255a03ed = 1;
                        e_hit_ent thread function_1c1ca848ededb6f6( v_forward, self.e_beam_end.origin );
                    }
                }
            }
            
            if ( !var_d6c6297634753e2a && self.var_a98b32c9a9122957 || var_d6c6297634753e2a && !self.var_a98b32c9a9122957 )
            {
                var_d6c6297634753e2a = !var_d6c6297634753e2a;
                level thread function_6c8683f5decc16a5( undefined, self.var_8af4bb0185feb88 );
            }
            
            waitframe();
        }
        
        utility::ent_flag_clear( "focus_beam_on" );
    }
    
    if ( self.e_mover )
    {
        self.e_mover function_616378d7e5b22efb( ( 0, 0, 0 ), 0, 1 );
    }
    
    utility::ent_flag_clear( "focus_beam_on" );
    self.var_36a423cad43fe7bd = undefined;
    level callback::remove( "on_zombie_ai_killed", &function_e8640775c152f68, s_info );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x7c43556c, Offset: 0x705f
// Size: 0x72
function private function_1c1ca848ededb6f6( v_knockback, var_7fb813c2ac295924 )
{
    self endon( #"death" );
    self.var_a13bed1ac47e1b2c = 1;
    self.no_powerups = 1;
    
    if ( self.subclass == "zombie_loom_minion" )
    {
    }
    else
    {
        utility::ent_flag_set( "dissolve_blue_burn" );
    }
    
    zombie_knockdown::function_6fc167d4a3590991( v_knockback, 69 );
    zm_cleanup_manager::function_dd62e2042418b7e5();
    self kill( var_7fb813c2ac295924 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xa5a6b97, Offset: 0x70d9
// Size: 0x275
function private function_ae20ae17613b2454( v_beam_end )
{
    s_aperture = utility::getstruct( "tmp_door_topper" + self.var_8af4bb0185feb88 );
    
    if ( !self.var_af45b7c010ff766c )
    {
        self.var_af45b7c010ff766c = utility::spawn_model( "tag_origin", s_aperture.origin, s_aperture.angles );
        waitframe();
    }
    
    playworldsound( self.e_mover.origin, #"hash_af0040757b04d2b" );
    var_17956c10084f53ce = playfxontagsbetweenclients( level._effect[ #"hash_16fd5bb034134aa6" ], self.var_af45b7c010ff766c, "tag_origin", self.e_mover, "tag_origin" );
    wait 1;
    self setscriptablepartstate( "vfx", "connect" );
    wait 0.5;
    v_forward = anglestoforward( self.e_mover.angles );
    v_start = self.origin + v_forward * 32;
    v_end = self.origin + v_forward * 3200;
    results = trace::sphere_trace( v_start, v_end, 8, self.e_mover, trace::create_default_contents( 1 ) );
    v_beam_end = results[ "position" ] ?? v_end;
    
    if ( !self.e_beam_end )
    {
        self.e_beam_end = utility::spawn_model( "tag_origin", v_beam_end, self.e_mover.angles );
        waitframe();
    }
    
    self.e_beam_end show();
    self.e_beam_end.origin = v_beam_end;
    var_a186c776b52bc4e = playfxontagsbetweenclients( level._effect[ #"hash_197687547c2a23c2" ], self.e_mover, "tag_origin", self.e_beam_end, "tag_origin" );
    waitframe();
    playfxontag( level._effect[ #"hash_1702d11c344e3e2e" ], self.e_beam_end, "tag_origin" );
    self notify( #"beam_ready" );
    utility::ent_flag_waitopen_any( "focus_beam_on" );
    var_a186c776b52bc4e delete();
    stopfxontag( level._effect[ #"hash_1702d11c344e3e2e" ], self.e_beam_end, "tag_origin" );
    wait 0.2;
    var_17956c10084f53ce delete();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xcc557e19, Offset: 0x7356
// Size: 0x6b
function private function_e8640775c152f68( params, info )
{
    if ( isplayer( params.eattacker ) && distance2dsquared( self.origin, info.scriptable.origin ) < 262144 )
    {
        level thread function_2c357ab1b0dbf22c( self getcentroid(), info.scriptable );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xa74bb21, Offset: 0x73c9
// Size: 0x3d3
function private function_2c357ab1b0dbf22c( v_start, scriptable )
{
    e_fx = utility::spawn_model( "tag_origin", v_start );
    e_fx endon( #"death" );
    
    if ( !isdefined( scriptable.a_e_souls ) )
    {
        scriptable.a_e_souls = [];
    }
    
    scriptable.a_e_souls[ scriptable.a_e_souls.size ] = e_fx;
    playfxontag( level._effect[ #"mana_focus_soul" ], e_fx, "tag_origin" );
    e_fx playsoundonmovingent( #"evt_scarab_mq_soul_spawn" );
    e_fx playloopsound( "evt_scarab_mq_soul_lp" );
    v_focus = scriptable.origin;
    n_time = distance( v_start, v_focus ) / 222;
    e_fx utility::function_8001268940441423( v_start, v_focus, v_start + ( 0, 0, 32 ), n_time, 0, 1 );
    
    if ( !scriptable.var_36a423cad43fe7bd )
    {
        scriptable.a_e_souls = arrayremove( scriptable.a_e_souls, e_fx );
        e_fx delete();
        return;
    }
    
    playfx( level._effect[ #"mana_focus_capture" ], scriptable.origin );
    playfxontag( level._effect[ #"mana_focus_charge" ], e_fx, "tag_origin" );
    var_b6081b1b6ba5e8b5 = distance( scriptable.e_beam_end.origin, v_focus );
    n_time = var_b6081b1b6ba5e8b5 / 666;
    e_fx moveto( scriptable.e_beam_end.origin, n_time );
    e_fx waittill( #"movedone" );
    playsoundatpos( scriptable.e_beam_end.origin, "evt_scarab_mq_soul_imp" );
    playfx( level._effect[ #"mana_focus_impact" ], scriptable.e_beam_end.origin );
    
    if ( scriptable.var_a98b32c9a9122957 )
    {
        var_70443eb0c5220d9e = getent( "tmp_wall_" + scriptable.var_8af4bb0185feb88, #targetname );
        
        if ( !level utility::flag( "sst_brch_check" + scriptable.var_8af4bb0185feb88 ) )
        {
            var_70443eb0c5220d9e setscriptablepartstate( "rune", "on_" + scriptable.var_8af4bb0185feb88 );
        }
        else
        {
            scriptable.var_a47d6e5a55aa75e6++;
            zm_quest::function_4eefe6de31f5ddab( hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( scriptable.var_8af4bb0185feb88 ) ), #"souls_captured", scriptable.var_a47d6e5a55aa75e6 );
            
            if ( scriptable.var_a47d6e5a55aa75e6 >= 10 && !level utility::flag( "sst_reco_check" + scriptable.var_8af4bb0185feb88 ) )
            {
                var_70443eb0c5220d9e setscriptablepartstate( "damage", "100p" );
                wait 1;
                level utility::flag_set( "sst_reco_check" + scriptable.var_8af4bb0185feb88 );
            }
            else
            {
                var_22754e38a04d6172 = scriptable.var_a47d6e5a55aa75e6 * 10;
                
                if ( var_22754e38a04d6172 < 100 && var_70443eb0c5220d9e getscriptablepartstate( "damage" ) != var_22754e38a04d6172 + "p" )
                {
                    var_70443eb0c5220d9e setscriptablepartstate( "damage", var_22754e38a04d6172 + "p" );
                }
            }
            
            level thread function_6c8683f5decc16a5( undefined, scriptable.var_8af4bb0185feb88, scriptable.var_a47d6e5a55aa75e6 );
            
            /#
                iprintlnbold( string( scriptable.var_a47d6e5a55aa75e6 + "<dev string:x7a>" + 10 ) );
            #/
        }
    }
    
    scriptable.a_e_souls = arrayremove( scriptable.a_e_souls, e_fx );
    e_fx delete();
}

/#

    // Namespace namespace_7d52c88182a8ee9b
    // Params 0, eflags: 0x4
    // Checksum 0x22f94c80, Offset: 0x77a4
    // Size: 0x2b, Type: dev
    function private debug_mana_focus()
    {
        while ( self )
        {
            debugaxis( self.origin, self.angles, 32, 1, 0, 1 );
            waitframe();
        }
    }

#/

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xe974496f, Offset: 0x77d7
// Size: 0x97
function private cleanup_activate_focus( b_skipped, b_restored )
{
    level utility::flag_set( "sst_rafo_check" + self.quest.var_8af4bb0185feb88 );
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( self.quest.var_8af4bb0185feb88 ) );
    zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"hash_15605240accc5920", 1 );
    
    if ( b_skipped || b_restored )
    {
        self.quest thread function_22e045dcf206b790();
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x6e3c8790, Offset: 0x7876
// Size: 0x78
function private setup_destroy_visage( b_skipped, b_restored )
{
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    
    if ( !b_skipped && !b_restored )
    {
        level thread function_52a42c32c084e199( self.quest );
    }
    
    level utility::flag_wait( "sst_devi_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc8b4f427, Offset: 0x78f6
// Size: 0x193
function private function_c590c627f45072e5( params )
{
    if ( !level utility::flag( "sst_brch_check" + self.var_8af4bb0185feb88 ) )
    {
        return 0;
    }
    
    level utility::flag_set( "sst_devi_lodo" + self.var_8af4bb0185feb88 );
    var_58d611c7dfff0836 = zombie_weyward_shadow_soul::get_shadow_soul_damage_reduction();
    
    if ( self.shadow_soul_immune || var_58d611c7dfff0836 != 1 )
    {
        playfx( level._effect[ #"hash_735a18e2b6980a12" ], params.vpoint );
        return 0;
    }
    
    damage = function_cb5150c538d12c12( params ) * var_58d611c7dfff0836;
    n_damage_cap = int( self.maxhealth * 0.0222 );
    
    if ( damage > n_damage_cap )
    {
        damage = n_damage_cap;
    }
    
    if ( self.health - damage < 1 )
    {
        level thread utility::flag_set_delayed( "sst_devi_check" + self.var_8af4bb0185feb88, 1.5 );
        self setscriptablepartstate( "vfx", "100p" );
        utility::delaythread( 1, &zm_damage::function_c31f9d79d5ceb7ec, &function_c590c627f45072e5, 0 );
    }
    else
    {
        var_4168e1b0a662402e = ( self.health - damage ) / self.maxhealth * 100;
        var_22754e38a04d6172 = int( 100 - round( var_4168e1b0a662402e, 10 ) );
        
        if ( var_22754e38a04d6172 < 100 && self getscriptablepartstate( "vfx" ) != var_22754e38a04d6172 + "p" )
        {
            self setscriptablepartstate( "vfx", var_22754e38a04d6172 + "p" );
        }
    }
    
    return max( damage, 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xe3a887b6, Offset: 0x7a92
// Size: 0x3a8
function private function_10e3a6493641dc2a( var_8af4bb0185feb88 )
{
    scr_visage = utility::getstruct( "tmp_base_" + var_8af4bb0185feb88 ).scr_visage;
    scr_visage.team = zm_utility::get_zombie_team();
    scr_visage.var_de4da4507fea9751 = "ssoul_pos_tmp" + var_8af4bb0185feb88;
    scr_visage.var_924151b61b0c320a = [];
    var_edbac01b53df1189 = utility::getstructarray( "tmp_base_ss" + var_8af4bb0185feb88 );
    
    foreach ( struct in var_edbac01b53df1189 )
    {
        scr_visage.var_924151b61b0c320a[ scr_visage.var_924151b61b0c320a.size ] = struct.origin;
    }
    
    scr_visage setscriptablepartstate( "model", "on_shielded_" + var_8af4bb0185feb88 );
    scr_visage thread zombie_weyward_shadow_soul::begin_shadow_soul_summon( 4, 1 );
    scr_visage utility::waittill_any_timeout( 10, "all_souls_arrived" );
    scr_visage.var_f3c7c2e122328c51 = 1;
    scr_visage.shadow_soul_shield_active = 1;
    
    foreach ( var_76ff015046c9aa1 in scr_visage.shadow_souls )
    {
        var_76ff015046c9aa1 val::set( "visage_shadow_soul", "ignoreme", 1 );
        var_76ff015046c9aa1 val::set( "visage_shadow_soul", "ignoreall", 1 );
        var_76ff015046c9aa1.no_powerups = 1;
        var_76ff015046c9aa1.var_a13bed1ac47e1b2c = 1;
        var_76ff015046c9aa1.health = int( var_76ff015046c9aa1.maxhealth * ( zm_quest::function_b0a5181ebe7bb905() ? 0.666 : 1 ) );
        var_76ff015046c9aa1.maxhealth = var_76ff015046c9aa1.health;
        var_76ff015046c9aa1 zombie_utils::function_dfae6a5bd222c586( &function_7fcc4860586ddd1e );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread function_9ebfdff54a9d88cf( var_76ff015046c9aa1, scr_visage, var_8af4bb0185feb88 );
        }
    }
    
    level notify( #"soul_setup_complete", var_8af4bb0185feb88 );
    scr_visage utility::waittill_any_timeout( 10, "shadow_soul_summon_complete" );
    level thread function_6c8683f5decc16a5( undefined, var_8af4bb0185feb88 );
    utility::array_wait( scr_visage.shadow_souls, "death" );
    scr_visage utility::ent_flag_set( "souls_all_dead" );
    playworldsound( scr_visage.origin, #"hash_25b99078365c6624" );
    scr_visage setscriptablepartstate( "model", "on_" + var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_devi_check" + var_8af4bb0185feb88 );
    playrumbleonposition( "zm_scarab_ruins_ring", scr_visage.origin );
    
    if ( scr_visage.e_beam_target )
    {
        scr_visage.e_beam_target delete();
    }
    
    foreach ( var_76ff015046c9aa1 in scr_visage.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) )
        {
            var_76ff015046c9aa1 kill();
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0x4
// Checksum 0x4aa17179, Offset: 0x7e42
// Size: 0x62
function private function_9ebfdff54a9d88cf( var_76ff015046c9aa1, scr_visage, var_8af4bb0185feb88 )
{
    var_76ff015046c9aa1 waittill( #"death" );
    
    if ( scr_visage.shadow_souls )
    {
        scr_visage.shadow_souls = arrayremove( scr_visage.shadow_souls, var_76ff015046c9aa1 );
    }
    
    level thread function_6c8683f5decc16a5( undefined, var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x76dea9ce, Offset: 0x7eac
// Size: 0xe6
function private function_7fcc4860586ddd1e( params )
{
    if ( self.var_70e2cd76631d2140 && ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee ) )
    {
        return params.idamage;
    }
    
    damage = params.idamage;
    n_damage_cap = int( self.maxhealth * 0.015 );
    
    if ( params.biscritical )
    {
        n_damage_cap *= 1.25;
    }
    
    if ( params.sweapon.basename == level.scarabww_basename )
    {
        n_damage_cap *= 3;
    }
    
    if ( damage > n_damage_cap )
    {
        damage = n_damage_cap;
    }
    
    params.var_d3006097a8584457 = 1;
    return int( damage );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x67c2125f, Offset: 0x7f9b
// Size: 0x108
function private function_cb5150c538d12c12( params )
{
    damage = params.idamage;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        damage_reduction = paplevel * 0.15;
        damage -= damage * damage_reduction;
        is_wonder = weapon::iswonderweapon( params.sweapon );
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( is_wonder )
        {
            damage *= 1.75;
        }
        else if ( rarity >= 4 )
        {
            damage *= 0.75;
        }
    }
    
    return damage;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x99182908, Offset: 0x80ac
// Size: 0x2b4
function private function_52a42c32c084e199( quest )
{
    var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    level utility::flag_wait( "sst_devi_lodo" + var_8af4bb0185feb88 );
    level utility::flag_set( "temple_lockdown_active" );
    level val::set( "temple_lockdown_active", "task_logic_activate", 0 );
    level thread function_a37c42c64291f58e();
    level thread zm_sat_scarab_rb::function_dba55b5c7bdfb0ed( var_8af4bb0185feb88, &function_3a6b727f068cacf2, "sst_devi_check" + var_8af4bb0185feb88, 1 );
    level thread function_c69c8f5d085d9c61( var_8af4bb0185feb88 );
    level thread function_10e3a6493641dc2a( var_8af4bb0185feb88 );
    var_560c3317f21f37f5 = function_4d7f96fec6a2218c( var_8af4bb0185feb88 );
    level zm_music::start_zone_music_watcher( "shadow_defend_" + var_8af4bb0185feb88, var_560c3317f21f37f5, #"shadow_defend" );
    level thread function_fd4ff69b038a229d( var_8af4bb0185feb88, var_560c3317f21f37f5 );
    function_8f029de48694ef73( quest, var_560c3317f21f37f5 );
    level zm_music::function_446e6e39d7feeb7c( var_560c3317f21f37f5, hashcat( #"hash_84934ff330ce54c5", var_8af4bb0185feb88 ) );
    level zm_music::function_e9fd14ede793ef0d( "shadow_defend_" + var_8af4bb0185feb88 );
    
    foreach ( player in level.players )
    {
        if ( player function_1fc3084d1cec7d38( var_560c3317f21f37f5 ) )
        {
            player thread zm_utility::white_screen_flash( 3, undefined, undefined, undefined, 1 );
            player playsoundevent( %"sndevent_powerup_nuke" );
            player playrumbleonentity( "artillery_rumble_heavy" );
            player val::set( "post_ld_zone_spawns_off" + var_8af4bb0185feb88, "round_spawning_ignore_player", 1 );
        }
    }
    
    level thread zm_quest::cleanup_zombies_manually( 1, var_560c3317f21f37f5, undefined, undefined, 0, 1 );
    
    if ( level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ].size )
    {
        level thread nuke::function_6c5906115e825d8f( quest.scr_visage.origin, level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ], "nuke", 1 );
    }
    
    level utility::flag_clear( "temple_lockdown_active" );
    wait 15;
    level val::reset( "temple_lockdown_active", "task_logic_activate" );
    
    foreach ( player in level.players )
    {
        player val::reset( "post_ld_zone_spawns_off" + var_8af4bb0185feb88, "round_spawning_ignore_player" );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xab39824b, Offset: 0x8368
// Size: 0x25
function private function_a37c42c64291f58e()
{
    wait 1;
    zm_quest::function_8934bb2a9028bdc5();
    overlord::playevent( #"hash_3849d464d347be8c", level.players );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x97231b71, Offset: 0x8395
// Size: 0x152
function private function_fd4ff69b038a229d( var_8af4bb0185feb88, var_560c3317f21f37f5 )
{
    var_e791328b0068d4fe = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player function_1fc3084d1cec7d38( var_560c3317f21f37f5 ) )
        {
            player playrumblelooponentity( "low_highfreq" );
            var_e791328b0068d4fe[ var_e791328b0068d4fe.size ] = player;
        }
    }
    
    while ( true )
    {
        level waittill( #"soul_setup_complete", value );
        
        if ( var_8af4bb0185feb88 == value )
        {
            break;
        }
    }
    
    foreach ( player in var_e791328b0068d4fe )
    {
        if ( player )
        {
            player stoprumble( "low_highfreq" );
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xe549f58f, Offset: 0x84ef
// Size: 0x30c
function private function_8f029de48694ef73( quest, var_560c3317f21f37f5 )
{
    var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    level endon( "sst_devi_check" + var_8af4bb0185feb88 );
    level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] = [];
    quest.var_947196b5557e04b4 = undefined;
    var_cbf02137e05980c9 = zm_quest::function_b0a5181ebe7bb905() ? 5 : 0;
    n_wave_delay = 25 + var_cbf02137e05980c9;
    var_59c47b196649a776 = 10 + var_cbf02137e05980c9;
    b_ending = undefined;
    wait 5;
    n_start_time = gettime();
    var_a65a556e144e8c0b = zone_spawner::function_20c574a6ba7cc5c6( var_560c3317f21f37f5, "zombie_base" );
    
    while ( !utility::time_has_passed( n_start_time, 600 ) )
    {
        n_base_ai_count = 16 + level.players.size * 2;
        zm_utility::function_922d522db5f1ceda( n_base_ai_count, [ "normal" ], level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] );
        function_5312bda0f8c4e053( var_a65a556e144e8c0b, "zombie_base", n_base_ai_count, quest );
        
        if ( !isalive( quest.var_947196b5557e04b4 ) )
        {
            quest.scr_visage utility::waittill_notify_or_timeout_return( "souls_all_dead", var_59c47b196649a776 );
            function_11066435e1670ddd( quest, var_560c3317f21f37f5 );
        }
        
        n_wait_min_time = gettime() + utility::function_4b74c15943231980( 5 );
        result = quest.scr_visage utility::waittill_notify_or_timeout_return( "souls_all_dead", n_wave_delay );
        
        if ( result == "souls_all_dead" )
        {
            if ( gettime() < n_wait_min_time )
            {
                wait utility::function_6f5d2e1f1ff70482( n_wait_min_time - gettime() );
            }
        }
        
        level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] = function_5713d46873b29625( level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] );
        level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] = function_46f9072493651dc9( level.zm_scarab_mq.var_a560c3ead022903c[ var_8af4bb0185feb88 ] );
        
        if ( !b_ending && quest.scr_visage utility::ent_flag( "souls_all_dead" ) )
        {
            n_wave_delay *= 0.65;
            var_59c47b196649a776 *= 0.65;
            b_ending = 1;
        }
    }
    
    if ( !quest.scr_visage utility::ent_flag( "souls_all_dead" ) )
    {
        foreach ( var_76ff015046c9aa1 in quest.scr_visage.shadow_souls )
        {
            if ( isalive( var_76ff015046c9aa1 ) )
            {
                var_76ff015046c9aa1 thread ai_utility::delete_ai();
            }
        }
    }
    
    level utility::flag_set( "sst_devi_check" + var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 5, eflags: 0x4
// Checksum 0x7aff7d1b, Offset: 0x8803
// Size: 0x92
function private function_5312bda0f8c4e053( var_a65a556e144e8c0b, var_ff75798b22968d50, n_count, quest, var_87886397e909c08b )
{
    assert( var_a65a556e144e8c0b.size );
    var_a65a556e144e8c0b = arrayrandomize( var_a65a556e144e8c0b );
    
    for ( i = 0; i < n_count ; i++ )
    {
        spawner = var_a65a556e144e8c0b[ i ];
        
        if ( !spawner )
        {
            spawner = utility::array_random( var_a65a556e144e8c0b );
        }
        
        level thread function_29adc18dc46fa1a8( spawner, var_ff75798b22968d50, quest, var_87886397e909c08b );
        wait 0.1;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 4, eflags: 0x4
// Checksum 0x518cd23c, Offset: 0x889d
// Size: 0x163
function private function_29adc18dc46fa1a8( spawner, var_ff75798b22968d50, quest, var_87886397e909c08b )
{
    if ( var_ff75798b22968d50 == "zombie_hellhound" )
    {
        ai = zone_spawner::spawn_single_dog( var_ff75798b22968d50, undefined, var_87886397e909c08b );
    }
    else
    {
        ai = agent_manager::spawn_agent( var_ff75798b22968d50, spawner.origin, spawner.angles );
    }
    
    if ( !ai )
    {
        return;
    }
    
    level.zm_scarab_mq.var_a560c3ead022903c[ quest.var_8af4bb0185feb88 ][ level.zm_scarab_mq.var_a560c3ead022903c[ quest.var_8af4bb0185feb88 ].size ] = ai;
    
    if ( var_ff75798b22968d50 == "zombie_base" )
    {
        n_roll = randomint( 100 );
        
        if ( n_roll < 67 )
        {
            if ( n_roll < 15 )
            {
                str_move_speed = "super_sprint";
            }
            else
            {
                str_move_speed = "sprint";
            }
        }
    }
    else if ( var_ff75798b22968d50 == "zombie_loom" || var_ff75798b22968d50 == "zombie_abom" )
    {
        quest.var_947196b5557e04b4 = ai;
        ai thread function_b1e29d1a1fa77ef( quest );
    }
    
    ai zm_utility::setup_quest_ai( { #var_50c96a5c56dab386:&function_1ecf242ac203a63a, #b_ignore_cleanup:0, #str_move_speed:str_move_speed } );
    ai agent_spawner::function_ce10e453e7f7bb8e( spawner );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x5d42c5f8, Offset: 0x8a08
// Size: 0x58
function private function_1ecf242ac203a63a()
{
    if ( self.aicategory == "normal" )
    {
        droplist = "zm_sat_scarab_lockdown_loot_base";
    }
    else
    {
        droplist = "zm_sat_scarab_lockdown_loot_elite";
    }
    
    return { #droppos:self.origin, #dropquantity:1, #droplist:droplist };
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x19883f69, Offset: 0x8a69
// Size: 0xc3
function private function_11066435e1670ddd( quest, var_560c3317f21f37f5 )
{
    switch ( quest.var_8af4bb0185feb88 )
    {
        case 4:
            var_ff75798b22968d50 = "zombie_loom";
            n_wave_count = 1;
            break;
        case 3:
            var_ff75798b22968d50 = "zombie_base_armored_heavy";
            n_wave_count = 8;
            break;
        case 1:
            var_ff75798b22968d50 = "zombie_hellhound";
            n_wave_count = 8;
            break;
        case 2:
            var_ff75798b22968d50 = "zombie_abom";
            n_wave_count = 1;
            break;
    }
    
    var_a65a556e144e8c0b = zone_spawner::function_20c574a6ba7cc5c6( var_560c3317f21f37f5, var_ff75798b22968d50 );
    function_5312bda0f8c4e053( var_a65a556e144e8c0b, var_ff75798b22968d50, n_wave_count, quest, var_560c3317f21f37f5 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xceee79f8, Offset: 0x8b34
// Size: 0x31
function private function_b1e29d1a1fa77ef( quest )
{
    self waittill( #"death" );
    quest.var_947196b5557e04b4 = undefined;
    
    /#
        level.var_2b87424e547068df = undefined;
    #/
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x17177478, Offset: 0x8b6d
// Size: 0x114
function private get_temple_zones( var_8af4bb0185feb88 )
{
    switch ( var_8af4bb0185feb88 )
    {
        case 4:
            return [ "zone_se_temple_entrance", "zone_se_temple_finalroom", "zone_se_temple_mainhall_north", "zone_se_temple_mainhall_south" ];
        case 3:
            return [ "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard", "zone_ne_temple_westwing_exterior", "zone_ne_temple_eastwing_exterior", "zone_ne_temple_westwing", "zone_ne_temple_mainhall", "zone_ne_temple_finalroom", "zone_ne_temple_eastwing" ];
        case 1:
            return [ "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing", "zone_sw_temple_finalroom", "zone_sw_temple_sideroom_upper", "zone_sw_temple_sideroom", "zone_sw_temple_secret_space" ];
        case 2:
            return [ "zone_nw_temple_entrance", "zone_nw_temple_mainhall", "zone_nw_temple_finalroom" ];
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc30f212b, Offset: 0x8c89
// Size: 0x9e
function private function_4d7f96fec6a2218c( var_8af4bb0185feb88 )
{
    return [ undefined, [ "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing" ], [ "zone_nw_temple_entrance", "zone_nw_temple_interior_steps" ], [ "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard", "zone_ne_temple_westwing_exterior", "zone_ne_temple_eastwing_exterior" ], [ "zone_se_temple_entrance", "zone_se_temple_finalroom", "zone_se_temple_mainhall_north", "zone_se_temple_mainhall_south" ] ][ var_8af4bb0185feb88 ];
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x354a62d8, Offset: 0x8d30
// Size: 0xd2
function private function_8aa1d841aeda908a()
{
    level endon( #"game_ended" );
    self notify( #"hash_287bad0e94de99cf" );
    self endon( #"disconnect", #"hash_287bad0e94de99cf" );
    
    while ( true )
    {
        if ( !isalive( self ) || self.sessionstate != "playing" )
        {
            function_161a1c2d13946eac();
            wait 0.25;
            continue;
        }
        
        var_8af4bb0185feb88 = function_117dd4b404297672();
        
        if ( !var_8af4bb0185feb88 )
        {
            function_161a1c2d13946eac();
            wait 0.25;
            continue;
        }
        
        fx = function_ca2b55da44992da8( var_8af4bb0185feb88 );
        
        if ( self.var_ca1ba12ca2b6ebe6 != fx )
        {
            function_161a1c2d13946eac();
            playfxontagforclients( fx, self, "j_head", self );
            self.var_ca1ba12ca2b6ebe6 = fx;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xb7736d87, Offset: 0x8e0a
// Size: 0x2d
function private function_161a1c2d13946eac()
{
    if ( self.var_ca1ba12ca2b6ebe6 )
    {
        stopfxontagforclients( self.var_ca1ba12ca2b6ebe6, self, "j_head", self );
        self.var_ca1ba12ca2b6ebe6 = undefined;
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x4794817a, Offset: 0x8e3f
// Size: 0x32
function private function_117dd4b404297672()
{
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 <= 4 ; var_8af4bb0185feb88++ )
    {
        if ( function_1fc3084d1cec7d38( get_temple_zones( var_8af4bb0185feb88 ) ) )
        {
            return var_8af4bb0185feb88;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x5d371a69, Offset: 0x8e79
// Size: 0x11d
function private function_ca2b55da44992da8( var_8af4bb0185feb88 )
{
    b_cleaned = level utility::flag( "sst_made_nice" + var_8af4bb0185feb88 );
    
    switch ( var_8af4bb0185feb88 )
    {
        case 4:
            return ( b_cleaned ? level._effect[ #"temple_ambient_caltheris_cleaned_camera" ] : level._effect[ #"hash_5827cc4925cb461e" ] );
        case 3:
            return ( b_cleaned ? level._effect[ #"temple_ambient_dravakar_cleaned_camera" ] : level._effect[ #"hash_bd093f831b40d2f1" ] );
        case 1:
            return ( b_cleaned ? level._effect[ #"temple_ambient_nyxara_cleaned_camera" ] : level._effect[ #"hash_f59535ba688de16a" ] );
        case 2:
            return ( b_cleaned ? level._effect[ #"temple_ambient_veytharion_cleaned_camera" ] : level._effect[ #"hash_359dc62ece307af2" ] );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xb4b7cd18, Offset: 0x8f9e
// Size: 0x1c, Type: bool
function private function_3a6b727f068cacf2( var_8af4bb0185feb88 )
{
    return !level utility::flag( "sst_devi_check" + var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc0d9640a, Offset: 0x8fc3
// Size: 0x51
function private function_c69c8f5d085d9c61( var_8af4bb0185feb88 )
{
    level utility::flag_wait( "sst_devi_check" + var_8af4bb0185feb88 );
    deactivateworldevent( "we_sat_scarab_temple_blocker" + var_8af4bb0185feb88 );
    doors = getent( "tmp_ld_barrier_" + var_8af4bb0185feb88, #targetname );
    doors delete();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc1d4176b, Offset: 0x901c
// Size: 0x84, Type: bool
function private function_1fc3084d1cec7d38( var_cfdcb332178e0755 )
{
    foreach ( var_4cdafb4532dd9de4 in var_cfdcb332178e0755 )
    {
        if ( zone_manager::is_touching_zone( var_4cdafb4532dd9de4 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x89dc7fd4, Offset: 0x90a9
// Size: 0x118
function private function_f136da417c4eb39a( var_8af4bb0185feb88 )
{
    wait 4.5;
    b_success = level overlord::playevent( hashcat( #"visage_powered", var_8af4bb0185feb88 ), level.players );
    
    if ( b_success )
    {
        var_560c3317f21f37f5 = function_4d7f96fec6a2218c( var_8af4bb0185feb88 );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player function_1fc3084d1cec7d38( var_560c3317f21f37f5 ) )
            {
                n_player_num = player getplayerclientnum();
                b_response = zm_sat_scarab_mq::play_banter_once( #"empower_response", "pow_res_vo" + n_player_num, [ player ] );
                
                if ( b_response )
                {
                    break;
                }
            }
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xc7f0df46, Offset: 0x91c9
// Size: 0x11b
function private function_f1b22571465ab9b9( var_8af4bb0185feb88, f_value )
{
    if ( !level.zm_scarab_mq.var_acbb8ce3bcde67f6 )
    {
        level.zm_scarab_mq.var_acbb8ce3bcde67f6 = level.lighting_pbg.color_bank_weights;
    }
    
    level.zm_scarab_mq.var_acbb8ce3bcde67f6[ 0 ] = level.lighting_pbg.color_bank_weights[ 0 ];
    level.zm_scarab_mq.var_acbb8ce3bcde67f6[ 1 ] = level.lighting_pbg.color_bank_weights[ 1 ];
    level.zm_scarab_mq.var_acbb8ce3bcde67f6[ 2 ] = level.lighting_pbg.color_bank_weights[ 2 ];
    
    if ( !isdefined( f_value ) )
    {
        f_value = 1;
    }
    
    level.zm_scarab_mq.var_acbb8ce3bcde67f6[ var_8af4bb0185feb88 + 2 ] = f_value;
    lighting_pbg::set_pbg_bank( 4, level.zm_scarab_mq.var_acbb8ce3bcde67f6 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x2951fc3, Offset: 0x92ec
// Size: 0x51
function private function_442b806e90dc24c4( quest )
{
    zm_save::function_1f44a48caae2acbf();
    
    if ( quest.scr_visage )
    {
        quest.scr_visage setscriptablepartstate( "vfx", "100p" );
    }
    
    activateworldevent( "we_lgt_tmp_visage_" + quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x4618c8b9, Offset: 0x9345
// Size: 0xf2
function private cleanup_destroy_visage( b_skipped, b_restored )
{
    level utility::flag_set( "sst_devi_check" + self.quest.var_8af4bb0185feb88 );
    level thread function_442b806e90dc24c4( self.quest );
    level thread function_f1b22571465ab9b9( self.quest.var_8af4bb0185feb88 );
    
    if ( self.quest.mana_focus )
    {
    }
    
    if ( !b_restored )
    {
        level thread function_f136da417c4eb39a( self.quest.var_8af4bb0185feb88 );
    }
    
    level callback::add( #"hash_3cc6ad69f4fc9bca", &function_aa7edab10fd240ff, self.quest );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( #"hash_aea7afa2ef607bca", &function_dc87954d200081b8, self.quest );
    }
    
    level thread function_25f8a0f2428e72ef( self.quest );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x3875d04d, Offset: 0x943f
// Size: 0x5a
function private setup_astral_eye( b_skipped, b_restored )
{
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_asey_check" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x6c720b13, Offset: 0x94a1
// Size: 0xc8
function private function_25f8a0f2428e72ef( var_af2c5380593e3cfa )
{
    trigger = getnoentvolumearray( "sst_head_t" + var_af2c5380593e3cfa.var_8af4bb0185feb88, #targetname )[ 0 ];
    
    foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
    {
        if ( function_bae1e93de3475d00( mote, trigger ) )
        {
            level thread function_3ab0be95fa1add6f( mote, var_af2c5380593e3cfa );
            return;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xdae9b94d, Offset: 0x9571
// Size: 0xa0
function private function_aa7edab10fd240ff( params, quest )
{
    var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    mote = params.mote;
    mote endon( #"hash_773759a7b2a12f60" );
    level endon( "sst_asey_check" + var_8af4bb0185feb88 );
    trigger = getnoentvolumearray( "sst_head_t" + var_8af4bb0185feb88, #targetname )[ 0 ];
    
    while ( mote )
    {
        wait 0.25;
        
        if ( function_bae1e93de3475d00( mote, trigger ) )
        {
            level thread function_3ab0be95fa1add6f( mote, quest );
            return;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x4a9e88fb, Offset: 0x9619
// Size: 0x9f, Type: bool
function private function_bae1e93de3475d00( mote, trigger )
{
    if ( !mote )
    {
        return false;
    }
    
    if ( mote.var_648eef0ab0822c74 )
    {
        return false;
    }
    
    v_half_height = trigger.height / 2;
    
    if ( abs( trigger.origin[ 2 ] + v_half_height - mote.origin[ 2 ] ) < v_half_height && distance2d( mote.origin, trigger.origin ) < trigger.radius )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xd3acdaf8, Offset: 0x96c1
// Size: 0x78
function private function_dc87954d200081b8( params, quest )
{
    s_loc = utility::getstruct( "smtg_drop" + quest.var_8af4bb0185feb88 );
    
    if ( distancesquared( params.mote.origin, s_loc.origin ) < 16384 )
    {
        level thread function_6c8683f5decc16a5( quest, quest.var_8af4bb0185feb88 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xc78b3bcb, Offset: 0x9741
// Size: 0x387
function private function_3ab0be95fa1add6f( mote, quest )
{
    mote endon( #"death" );
    mote.e_mover endon( #"death" );
    mote.e_mover notify( #"hash_2da5abc0d9cf41ac" );
    level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = arrayremove( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, mote );
    mote utility::ent_flag_set( "no_grapple" );
    mote utility::ent_flag_set( "mote_in_use" );
    mote utility::ent_flag_clear( "mote_moving" );
    mote.var_648eef0ab0822c74 = 1;
    mote.var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    s_eye = utility::getstruct( "sst_head_center" + quest.var_8af4bb0185feb88 );
    mote.e_mover moveto( mote.e_mover.origin, level.framedurationseconds );
    mote.e_mover waittill( #"movedone" );
    midpoint = ( mote.e_mover.origin + s_eye.origin ) / 2;
    var_4e9814222418cb9c = anglestoforward( s_eye.angles );
    midpoint += var_4e9814222418cb9c * 500;
    
    if ( quest.var_8af4bb0185feb88 == 1 )
    {
        v_to_eye = vectornormalize( s_eye.origin - mote.e_mover.origin );
        v_eye_left = anglestoleft( s_eye.angles );
        var_503192e8cdf95142 = vectordot( v_to_eye, v_eye_left );
        b_rotate_right = var_503192e8cdf95142 < 0;
        
        if ( b_rotate_right )
        {
            midpoint += v_eye_left * 250;
        }
        else
        {
            midpoint += v_eye_left * -250;
        }
    }
    
    playworldsound( s_eye.origin, #"hash_d2992f2770b7cbc4" );
    mote.e_mover utility::function_8001268940441423( mote.e_mover.origin, s_eye.origin, midpoint, 2 );
    level utility::flag_set( "sst_asey_check" + quest.var_8af4bb0185feb88 );
    quest.astral_mote = mote;
    playworldsound( s_eye.origin, #"hash_54bd976c5788ec5a" );
    earthquake( 0.3, 1.75, s_eye.origin, 3000 );
    playrumbleonposition( "zm_scarab_ruins_channel", s_eye.origin );
    
    if ( isalive( mote.eattacker ) && isplayer( mote.eattacker ) )
    {
        var_892e986fee0a054c = mote.eattacker getplayerclientnum();
        level thread zm_sat_scarab_mq::play_banter_once( #"astral_eye", "ast_aye_ban" + var_892e986fee0a054c, [ mote.eattacker ], #"bc_flavor_player_positive", 0.5 );
        mote.eattacker playrumbleonentity( "artillery_rumble" );
    }
    
    mote utility::scriptable_clearparententity();
    
    if ( mote.e_mover )
    {
        mote.e_mover delete();
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x655d3485, Offset: 0x9ad0
// Size: 0x135
function private function_f456ca0067c51668( quest )
{
    zm_save::function_1f44a48caae2acbf();
    
    if ( level utility::flag( "sst_made_nice" + quest.var_8af4bb0185feb88 ) )
    {
        return;
    }
    
    s_eye = utility::getstruct( "sst_head_center" + quest.var_8af4bb0185feb88 );
    var_55fd2217798353af = astral_motes::function_9ff53054c89e44ed( s_eye );
    var_55fd2217798353af.var_648eef0ab0822c74 = 1;
    var_55fd2217798353af.var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = arrayremove( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, var_55fd2217798353af );
    var_55fd2217798353af utility::ent_flag_set( "no_grapple" );
    var_55fd2217798353af utility::ent_flag_set( "mote_in_use" );
    var_55fd2217798353af.e_mover function_616378d7e5b22efb( ( 0, 0, 0 ), 1, 1 );
    quest.astral_mote = var_55fd2217798353af;
    var_55fd2217798353af endon( #"death" );
    level utility::flag_wait( "clean_a_i" + quest.var_8af4bb0185feb88 );
    
    if ( var_55fd2217798353af )
    {
        var_55fd2217798353af thread astral_motes::clean_up_mote();
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x31ce5511, Offset: 0x9c0d
// Size: 0x13b
function private cleanup_astral_eye( b_skipped, b_restored )
{
    level utility::flag_set( "sst_asey_check" + self.quest.var_8af4bb0185feb88 );
    
    if ( b_skipped || b_restored )
    {
        level thread function_f456ca0067c51668( self.quest );
    }
    
    level callback::remove( #"hash_3cc6ad69f4fc9bca", &function_aa7edab10fd240ff, self.quest );
    level callback::remove( #"hash_aea7afa2ef607bca", &function_dc87954d200081b8, self.quest );
    level callback::add( #"hash_f66882b6a668fd78", &function_6baf1f5d77bf6133, self.quest );
    var_c810c698cea03d98 = getent( "sat_zm_temple_head_0" + self.quest.var_8af4bb0185feb88, #targetname );
    var_c810c698cea03d98 setscriptablepartstate( "vfx", "on" );
    var_c810c698cea03d98 setscriptablepartstate( "anim", "open" );
    str_shadowsmith = get_shadowsmith_str( self.quest.var_8af4bb0185feb88 );
    setareaswaphint( "areaswap_" + str_shadowsmith, str_shadowsmith + "_un_corrupted" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x98842f34, Offset: 0x9d50
// Size: 0x5a
function private function_12b23b42ec2ce079( b_skipped, b_restored )
{
    level thread function_6c8683f5decc16a5( self.quest, self.quest.var_8af4bb0185feb88 );
    level utility::flag_wait( "sst_made_nice" + self.quest.var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x6d290a15, Offset: 0x9db2
// Size: 0x104
function private function_6baf1f5d77bf6133( params, quest )
{
    if ( params.mote.var_648eef0ab0822c74 && params.mote.var_8af4bb0185feb88 == quest.var_8af4bb0185feb88 && !level utility::flag( "sst_made_nice" + quest.var_8af4bb0185feb88 ) )
    {
        level utility::flag_set( "sst_made_nice" + quest.var_8af4bb0185feb88 );
        player = params.attacker;
        
        if ( isalive( player ) && isplayer( player ) )
        {
            var_892e986fee0a054c = player getplayerclientnum();
            level thread function_8322da3519668c52( var_892e986fee0a054c, player );
        }
        else
        {
            level utility::flag_set( "sst_made_nice_all_vo_done" );
        }
        
        params.mote.var_648eef0ab0822c74 = undefined;
        params.mote thread astral_motes::clean_up_mote();
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2
// Checksum 0xc98b1c1e, Offset: 0x9ebe
// Size: 0x9c
function function_8322da3519668c52( var_892e986fee0a054c, player )
{
    wait 5;
    
    if ( isalive( player ) )
    {
        zm_sat_scarab_mq::play_banter_once( #"cleansing_strike", "cln_str_ban" + var_892e986fee0a054c, [ player ], #"bc_flavor_player_positive", 2.75 );
    }
    
    if ( level utility::flag( "sst_made_nice_all" ) )
    {
        level utility::flag_set( "scarab_mq_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_95d77540e977b77" ] );
        level utility::flag_clear( "scarab_mq_vo_playing" );
        level utility::flag_set( "sst_made_nice_all_vo_done" );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xf889bd5a, Offset: 0x9f62
// Size: 0x469
function private function_16f58e3401634be1( quest, b_restored )
{
    var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    activateworldevent( "we_sat_scarab_temple_head" + var_8af4bb0185feb88 );
    var_c810c698cea03d98 = getent( "sat_zm_temple_head_0" + var_8af4bb0185feb88, #targetname );
    playworldsound( var_c810c698cea03d98.origin, #"hash_1cdbf8a8d3835adc" );
    
    if ( !b_restored )
    {
        wait 0.25;
        
        foreach ( player in level.players )
        {
            player playrumblelooponentity( "damage_heavy" );
            player earthquakeforplayer( 0.4, 1, player.origin, 1024 );
            player playlocalsound( #"hash_c8fa384ebfb97dde" );
        }
    }
    
    var_c810c698cea03d98 setscriptablepartstate( "vfx", "off" );
    
    if ( !b_restored )
    {
        wait 2;
        
        foreach ( player in level.players )
        {
            player thread zm_utility::white_screen_flash( 3.5, 0.5, undefined, 1, 1 );
        }
    }
    
    var_c810c698cea03d98 thread function_d18c3c787791f97d();
    
    if ( !b_restored )
    {
        level thread zm_quest::function_943d56a5fe5194de( 1, undefined, 1 );
        wait 0.5;
    }
    
    if ( level utility::flag( "temple_channeling_" + var_8af4bb0185feb88 ) )
    {
        zm_sat_scarab_mq::function_ae4e63665a224e18( var_8af4bb0185feb88 );
        level thread zm_sat_scarab_mq::reset_gimbals();
    }
    
    str_shadowsmith = get_shadowsmith_str( var_8af4bb0185feb88 );
    setareaswapstate( "areaswap_" + str_shadowsmith, str_shadowsmith + "_un_corrupted" );
    setglobalsoundcontext( "zm_scarab_corruption", str_shadowsmith + "_un_corrupted" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, hashcat( #"hash_4bb41050af6aa99e", str_shadowsmith ) );
    function_f1b22571465ab9b9( var_8af4bb0185feb88, 0 );
    e_wall = getent( "tmp_wall_" + var_8af4bb0185feb88, #targetname );
    e_wall show();
    e_wall setscriptablepartstate( "damage", "0p" );
    scr_wall = getentitylessscriptablearray( "tmp_wall_dest" + var_8af4bb0185feb88, #script_noteworthy )[ 0 ];
    scr_wall setscriptablepartstate( "vfx", "off" );
    
    if ( quest.scr_visage )
    {
        quest.scr_visage freescriptable();
    }
    
    if ( var_8af4bb0185feb88 == 3 )
    {
        level function_29ebbd8a53ed898b();
        trig_origin = ( 3081.5, 1738.25, 1645.75 );
        var_c6933f6c8afc036b = 5;
        trig_height = 12;
        level zm_sat_scarab::function_14c2f6686d9e89d6( trig_origin, var_c6933f6c8afc036b, trig_height );
    }
    
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player stoprumble( "damage_heavy" );
    }
    
    if ( quest.astral_mote )
    {
        quest.astral_mote.var_648eef0ab0822c74 = undefined;
        quest.astral_mote thread astral_motes::clean_up_mote();
    }
    
    /#
        iprintlnbold( "<dev string:x7c>" + var_8af4bb0185feb88 + "<dev string:x84>" );
    #/
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 < 4 )
    {
        if ( !b_restored )
        {
            level thread zm_quest::clear_all_guidance();
            level.zm_scarab_mq.var_a1b2e808da2bc982++;
            level thread function_6c8683f5decc16a5( undefined, level.zm_scarab_mq.var_a1b2e808da2bc982 );
        }
        
        return;
    }
    
    level.zm_scarab_mq.var_a1b2e808da2bc982 = undefined;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x2dae959, Offset: 0xa3d3
// Size: 0xa1
function private function_d18c3c787791f97d()
{
    wait 0.5;
    a_e_fires = getentarrayinradius( "grenade", "classname", self.origin, 800 );
    
    foreach ( fire in a_e_fires )
    {
        level thread molotov::molotov_cleanup_pool( fire, 1 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0xa1502fdd, Offset: 0xa47c
// Size: 0x20a
function private function_29ebbd8a53ed898b()
{
    profilestart();
    dravakar_wall = getent( "dravakar_temple_wall", #targetname );
    dravakar_wall setmodel( %"hash_631df7401c9a2081" );
    riddle_pillars = getentarray( "me_pillar", #targetname );
    
    foreach ( var_7e7ca0a63d1d515e in riddle_pillars )
    {
        if ( !var_7e7ca0a63d1d515e.script_parameters )
        {
            continue;
        }
        
        switch ( int( var_7e7ca0a63d1d515e.script_parameters ) )
        {
            case 1:
                var_7e7ca0a63d1d515e setmodel( %"hash_684fffff37f4c268" );
                break;
            case 2:
                var_7e7ca0a63d1d515e setmodel( %"hash_687a01b23eba5775" );
                break;
            case 3:
                var_7e7ca0a63d1d515e setmodel( %"hash_7b6f29dc023bff8e" );
                break;
            case 4:
                var_7e7ca0a63d1d515e setmodel( %"hash_6fa4328ec6cd6feb" );
                break;
            default:
                var_7e7ca0a63d1d515e setmodel( %"hash_706e14db073563df" );
                break;
        }
        
        pillar_side = getent( var_7e7ca0a63d1d515e.target, #targetname );
        
        if ( pillar_side )
        {
            pillar_side setmodel( %"hash_39bd529c1a911049" );
        }
    }
    
    pillar_platform_top = getent( "sv_pillar_platform", #targetname );
    pillar_platform_top setmodel( %"hash_57bc69cdd7e68bad" );
    
    if ( level.scarab_ww_quest.riddle_inscription )
    {
        level.scarab_ww_quest.riddle_inscription freescriptable();
    }
    
    profilestop();
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xa6356f8f, Offset: 0xa68e
// Size: 0x75
function private function_9f5cb77e21d0a47a( b_skipped, b_restored )
{
    level utility::flag_set( "sst_made_nice" + self.quest.var_8af4bb0185feb88 );
    level thread function_16f58e3401634be1( self.quest, b_restored );
    
    if ( b_skipped || b_restored )
    {
        level utility::flag_set( "clean_a_i" + self.quest.var_8af4bb0185feb88 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x5522cf67, Offset: 0xa70b
// Size: 0x90
function private function_342f15003e07e275()
{
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "mq_tmp_guidance_go" );
    waitframe();
    level thread function_1e9930ea76bbb507();
    level thread zm_quest::clear_all_guidance();
    level thread zm_quest::start_quest( #"hash_2d753cdc71ad3528" );
    level.zm_scarab_mq.var_a1b2e808da2bc982 = 1;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level thread function_e4c19033abe09b4();
    }
    else
    {
        level thread function_6c8683f5decc16a5( undefined, 1 );
    }
    
    level utility::flag_wait( "nexus_platforms_aligned" );
    level thread zm_quest::update_round_cap( 15 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x9512355e, Offset: 0xa7a3
// Size: 0x21
function private function_e4c19033abe09b4()
{
    wait 6;
    level thread function_6c8683f5decc16a5( undefined, level.zm_scarab_mq.var_a1b2e808da2bc982 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0x4
// Checksum 0x28f3c341, Offset: 0xa7cc
// Size: 0x39
function private function_6c8683f5decc16a5( quest, var_8af4bb0185feb88, var_3471316e3ec32d4a )
{
    if ( level utility::flag( "directed_ring_sequence_in_progress" ) )
    {
        return;
    }
    
    function_5351a16854ff2f62( quest, var_8af4bb0185feb88, var_3471316e3ec32d4a );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0xc
// Checksum 0xd322ba74, Offset: 0xa80d
// Size: 0x1090
function private function_5351a16854ff2f62( quest, var_8af4bb0185feb88, var_3471316e3ec32d4a )
{
    self notify( #"hash_6f0f630d645feae3" );
    self endon( #"hash_6f0f630d645feae3" );
    zm_save::function_1f44a48caae2acbf();
    
    if ( !level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( !level.scarab_ww_quest.completed )
    {
        return;
    }
    
    if ( level.zm_scarab_mq.completed )
    {
        return;
    }
    
    if ( !level.zm_scarab_mq.var_a1b2e808da2bc982 )
    {
        return;
    }
    
    if ( var_8af4bb0185feb88 > 4 )
    {
        return;
    }
    
    level utility::flag_wait( "mq_tmp_guidance_go" );
    
    if ( !quest )
    {
        str_shadowsmith = get_shadowsmith_str( var_8af4bb0185feb88 );
        quest = zm_quest::get_quest( hashcat( #"hash_5267022c69306b07", str_shadowsmith ) );
    }
    
    if ( !isdefined( var_8af4bb0185feb88 ) )
    {
        var_8af4bb0185feb88 = quest.var_8af4bb0185feb88;
    }
    
    if ( zm_save::function_fcccc3d2a616b1c7() && quest.completed && var_8af4bb0185feb88 == level.zm_scarab_mq.var_a1b2e808da2bc982 )
    {
        level.zm_scarab_mq.var_a1b2e808da2bc982++;
        level thread function_6c8683f5decc16a5( undefined, level.zm_scarab_mq.var_a1b2e808da2bc982 );
        return;
    }
    
    /#
        if ( getdvarint( @"hash_3f250537cd05c93e", 0 ) == 3 )
        {
            level.zm_scarab_mq.var_a1b2e808da2bc982 = var_8af4bb0185feb88;
        }
    #/
    
    if ( var_8af4bb0185feb88 != level.zm_scarab_mq.var_a1b2e808da2bc982 )
    {
        return;
    }
    
    level.zm_scarab_mq.n_enabled_ring = 0;
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        level utility::flag_wait( "tmp_align_id_ready" );
        
        if ( level.zm_scarab_mq.var_d262521be8963583 )
        {
            level utility::flag_wait( "temple_channeling_id_flag_set" );
        }
    }
    
    if ( quest.var_7be076c9078045aa == -1 )
    {
        level thread zm_quest::start_quest( hashcat( #"hash_5267022c69306b07", str_shadowsmith ?? get_shadowsmith_str( var_8af4bb0185feb88 ) ) );
        waitframe();
        level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
        return;
    }
    
    quest_step = quest.steps[ quest.var_7be076c9078045aa ];
    
    if ( quest_step.ref == #"prepare_temple" )
    {
        if ( !level utility::flag( "temple_channeling_" + var_8af4bb0185feb88 ) )
        {
            if ( level utility::flag( "nexus_platforms_moving" ) )
            {
                level thread zm_quest::update_guidance( [ [] ], #"hash_f7e08be41d80e326", #"hash_48cced3e02723650", 1 );
                level utility::flag_waitopen( "nexus_platforms_moving" );
                level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
            }
            else
            {
                level utility::flag_set( "directed_ring_sequence_in_progress" );
                
                if ( var_8af4bb0185feb88 == 1 )
                {
                    a_sequence = [ 2, 3, 3 ];
                }
                else if ( var_8af4bb0185feb88 == 3 )
                {
                    a_sequence = [ 1, 1, 2, 2, 3, 3 ];
                }
                else
                {
                    a_sequence = [ 1, 2, 3 ];
                }
                
                foreach ( var_8ff12f2d202531c5 in a_sequence )
                {
                    level.zm_scarab_mq.n_enabled_ring = var_8ff12f2d202531c5;
                    scr_lever = function_f511714cf373169e( var_8ff12f2d202531c5 );
                    scr_lever.interact_hint_callback = &zm_sat_scarab_mq::function_62f7d623ba1c37ad;
                    marker = function_6f838df31b957c7d( var_8ff12f2d202531c5 );
                    hud_data = [ [ marker, 10 ] ];
                    level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"align_forge", 1 );
                    level utility::flag_wait( "forge_lever_" + var_8ff12f2d202531c5 );
                    scr_lever.interact_hint_callback = undefined;
                    level.zm_scarab_mq.n_enabled_ring = 0;
                    level thread zm_quest::update_guidance( [ [] ], #"hash_f7e08be41d80e326", #"hash_48cced3e02723650", 1 );
                    level utility::flag_waitopen( "forge_lever_" + var_8ff12f2d202531c5 );
                }
                
                level.zm_scarab_mq.n_enabled_ring = 0;
                level utility::flag_wait( "temple_channeling_" + var_8af4bb0185feb88 );
                level utility::flag_clear( "directed_ring_sequence_in_progress" );
                level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
            }
        }
        else if ( !level utility::flag( "sst_deto_check" + var_8af4bb0185feb88 ) )
        {
            if ( !level utility::flag( "totes_totes_dropped" + var_8af4bb0185feb88 ) && !level utility::flag( "totes_check_check" + var_8af4bb0185feb88 ) && !level utility::flag( "totes_plop_hop" + var_8af4bb0185feb88 ) )
            {
                if ( var_8af4bb0185feb88 == 1 )
                {
                    level childthread function_dd6ac16d2127e7e3( quest, var_3471316e3ec32d4a );
                    return;
                }
                
                hud_data = function_47bcdaba1e9f702b( var_8af4bb0185feb88, quest );
                
                if ( var_8af4bb0185feb88 == 4 && !hud_data.size )
                {
                    level thread zm_quest::update_guidance( undefined, #"hash_e01621c22e6f07ca", #"hash_4a672453c726a415", 1 );
                    level utility::flag_set( "guidance_waiting_on_motes" );
                    return;
                }
                
                var_3fb65a129e9cbad8 = hashcat( #"hash_c2a607000c19d82e", var_8af4bb0185feb88 );
                level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", var_3fb65a129e9cbad8, 1 );
                
                if ( var_8af4bb0185feb88 == 4 )
                {
                    var_3471316e3ec32d4a = quest.n_motes_looted ?? 0;
                }
                
                if ( var_3471316e3ec32d4a )
                {
                    level thread zm_quest::function_9f49b2a045ece8ae( var_3471316e3ec32d4a, 1, #"hash_f7e08be41d80e326", var_3fb65a129e9cbad8 );
                }
            }
            else if ( !level utility::flag( "totes_check_check" + var_8af4bb0185feb88 ) && !level utility::flag( "totes_plop_hop" + var_8af4bb0185feb88 ) )
            {
                if ( var_8af4bb0185feb88 == 1 )
                {
                    level childthread function_dd6ac16d2127e7e3( quest, var_3471316e3ec32d4a );
                    return;
                }
                
                wait 1;
                
                if ( level utility::flag( "totes_check_check" + var_8af4bb0185feb88 ) )
                {
                    level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
                }
                else
                {
                    hud_data = [ [ quest.mq_totem, 16 ] ];
                    level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_e6b8a1d8fd7d182", 1 );
                }
            }
            else if ( var_8af4bb0185feb88 == 1 && level utility::flag( "WW_A_P_IN_USE" ) )
            {
                level childthread function_dd6ac16d2127e7e3( quest, var_3471316e3ec32d4a );
                return;
            }
            else
            {
                if ( var_8af4bb0185feb88 == 1 )
                {
                    foreach ( player in level.players )
                    {
                        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
                        player zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
                    }
                }
                
                function_22b574a3954c779( var_8af4bb0185feb88 );
            }
        }
        else if ( !level utility::flag( "sst_brch_check" + var_8af4bb0185feb88 ) )
        {
            while ( !level.zm_scarab_mq.a_curses[ var_8af4bb0185feb88 ] )
            {
                waitframe();
            }
            
            if ( !isai( level.zm_scarab_mq.a_curses[ var_8af4bb0185feb88 ] ) )
            {
                hud_data = [ [ level.zm_scarab_mq.a_curses[ var_8af4bb0185feb88 ], 32 ] ];
                level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_fd655eb5c4e645ac", 1 );
                return;
            }
            
            s_titan = get_titan_switch( var_8af4bb0185feb88 );
            hud_data = [ [ level.zm_scarab_mq.a_curses[ var_8af4bb0185feb88 ], 75 ], [ s_titan, 64 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"smash_cursed_ai", 1 );
        }
        else if ( !level utility::flag( "sst_unfo_check" + var_8af4bb0185feb88 ) )
        {
            str_quest_step = hashcat( #"hash_808f59896af3298e", var_8af4bb0185feb88 );
            zm_quest::function_9f49b2a045ece8ae( quest.var_2bb17d5d51b95136 ?? var_3471316e3ec32d4a, 1, #"hash_f7e08be41d80e326", str_quest_step );
            s_focus = utility::getstruct( "mana_focus_" + var_8af4bb0185feb88 );
            hud_data = [ [ s_focus, 32 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", str_quest_step, 1 );
        }
        else if ( !level utility::flag( "sst_rafo_check" + var_8af4bb0185feb88 ) )
        {
            s_focus = utility::getstruct( "mana_focus_" + var_8af4bb0185feb88 );
            hud_data = [ [ s_focus ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_11dc5fff52517279", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"reveal_corruption" )
    {
        s_focus = utility::getstruct( "mana_focus_" + var_8af4bb0185feb88 );
        
        if ( !quest.mana_focus.var_a98b32c9a9122957 )
        {
            var_70443eb0c5220d9e = getent( "tmp_wall_" + var_8af4bb0185feb88, #targetname );
            
            if ( !var_70443eb0c5220d9e.v_wall_center )
            {
                var_70443eb0c5220d9e.v_wall_center = var_70443eb0c5220d9e.origin + anglestoup( var_70443eb0c5220d9e.angles ) * 75 + anglestoright( var_70443eb0c5220d9e.angles ) * 75;
            }
            
            hud_data = [ [ var_70443eb0c5220d9e.v_wall_center ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_e10288ae18df8a60", 1 );
        }
        else
        {
            level zm_quest::function_9f49b2a045ece8ae( quest.mana_focus.var_a47d6e5a55aa75e6 ?? var_3471316e3ec32d4a, 1, #"hash_f7e08be41d80e326", #"hash_6497daec63732ada" );
            hud_data = [ [ s_focus, 0, sqrt( 262144 ) ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_6497daec63732ada", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"destroy_visage" )
    {
        if ( level utility::flag( "sst_devi_lodo" + var_8af4bb0185feb88 ) && !quest.scr_visage utility::ent_flag( "souls_all_dead" ) )
        {
            hud_data = build_hud_data_array( quest.scr_visage.shadow_souls, 64 );
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_aeb76ee64b814b0d", 1 );
        }
        else
        {
            hud_data = [ [ quest.scr_visage, 100 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_32474768eee72e3a", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"astral_eye" )
    {
        s_loc = utility::getstruct( "smtg_drop" + var_8af4bb0185feb88 );
        var_5cc9cd0089f13b5f = get_valid_motes();
        a_motes = utility::get_array_of_closest( s_loc.origin, var_5cc9cd0089f13b5f, undefined, 1, 128 );
        
        if ( !a_motes.size )
        {
            if ( var_5cc9cd0089f13b5f.size < 1 )
            {
                level thread zm_quest::update_guidance( undefined, #"hash_e01621c22e6f07ca", #"hash_4a672453c726a415", 1 );
                level utility::flag_set( "guidance_waiting_on_motes" );
                return;
            }
            
            mote = utility::get_array_of_closest( s_loc.origin, var_5cc9cd0089f13b5f, undefined, 1 )[ 0 ];
            hud_data = [ [ s_loc, 0, 128 ], [ mote.e_mover, 32 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_e03da320f7987c18", 1 );
            mote utility::waittill_any( "mote_in_forge", "mote_in_dig_pile", "clean_up_mote", "death" );
            level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
        }
        else
        {
            foreach ( mote in a_motes )
            {
                if ( !mote utility::ent_flag( "no_grapple" ) && !mote utility::ent_flag( "mote_in_use" ) && !mote.var_648eef0ab0822c74 )
                {
                    guidance_mote = mote;
                    break;
                }
            }
            
            if ( !guidance_mote )
            {
                foreach ( mote in a_motes )
                {
                    mote thread astral_motes::clean_up_mote();
                }
                
                level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
                return;
            }
            
            guidance_mote utility::ent_flag_set( "no_grapple" );
            guidance_mote setscriptablepartstate( "usable", "off" );
            guidance_mote notify( #"clean_up_mote" );
            hud_data = [ [ guidance_mote, 32 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_d2bc2a3235901a69", 1 );
        }
        
        return;
    }
    
    if ( quest_step.ref == #"cleansing_strike" )
    {
        if ( !level utility::flag( "its_raining" ) )
        {
            level utility::flag_set( "call_the_rains" );
            level thread zm_quest::update_guidance( undefined, #"hash_f7e08be41d80e326", #"hash_e717e9ef4d229ab3", 1 );
            level thread function_e3a1b4c2556d15ee( quest, var_8af4bb0185feb88, 0 );
            return;
        }
        
        level thread function_e3a1b4c2556d15ee( quest, var_8af4bb0185feb88, 1 );
        
        if ( !level zm_sat_scarab_usurped_power::function_fa42c671f89f2b5() && !level zm_sat_scarab_usurped_power::function_635a6a03916a35f0() )
        {
            var_e1441f8f025073e9 = [];
            var_2fbc96d32f8ab341 = 0;
            
            foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
            {
                if ( brazier utility::ent_flag( "is_lit" ) )
                {
                    var_2fbc96d32f8ab341 = 1;
                    var_e1441f8f025073e9[ var_e1441f8f025073e9.size ] = brazier;
                }
            }
            
            if ( !var_2fbc96d32f8ab341 )
            {
                hud_data = [ [ level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3, 64 ] ];
                level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"activate_power_surge", 1 );
                
                while ( !level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ] utility::ent_flag( "is_lit" ) && !level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 1 ] utility::ent_flag( "is_lit" ) )
                {
                    utility::array_any_wait( level.scarab_pap_quest.var_c6b9e23aac03b4d0, "is_lit" );
                }
                
                level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
            }
            else
            {
                hud_data = build_hud_data_array( var_e1441f8f025073e9, 48 );
                level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_c34c8d55737239ce", 1 );
                level utility::waittill_any( "cosmic_usurped_power_deployed", "usurped_power_deployed" );
                level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
            }
            
            return;
        }
        
        s_loc = utility::getstruct( "sst_head_center" + var_8af4bb0185feb88 );
        hud_data = [ [ s_loc, 32 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_eaec7a552da9d1ea", 1 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x305436d4, Offset: 0xb8a5
// Size: 0x64
function private function_1e9930ea76bbb507()
{
    level endon( #"sst_made_nice_all" );
    
    while ( !level utility::flag( "sst_made_nice_all" ) )
    {
        level utility::flag_wait( "guidance_waiting_on_motes" );
        level waittill( #"hash_6d92532e6d7f196d" );
        level utility::flag_clear( "guidance_waiting_on_motes" );
        level thread function_6c8683f5decc16a5( undefined, level.zm_scarab_mq.var_a1b2e808da2bc982 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x1c522cc7, Offset: 0xb911
// Size: 0xd3
function private get_titan_switch( var_8af4bb0185feb88 )
{
    if ( var_8af4bb0185feb88 == 1 || var_8af4bb0185feb88 == 2 )
    {
        str_id = "_a";
    }
    else
    {
        str_id = "_b";
    }
    
    var_2747e0528b1f176 = utility::getstructarray( "stone_titan_trap" );
    
    foreach ( var_6469c1e4d3ac4060 in var_2747e0528b1f176 )
    {
        if ( str_id == var_6469c1e4d3ac4060.script_label )
        {
            return var_6469c1e4d3ac4060.a_switch_pos[ 0 ];
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 3, eflags: 0xc
// Checksum 0x7a35f2ac, Offset: 0xb9ec
// Size: 0x6e
function private function_e3a1b4c2556d15ee( quest, var_8af4bb0185feb88, b_waitopen )
{
    self notify( #"hash_e95c4a0e7297121f" );
    self endon( #"hash_e95c4a0e7297121f" );
    level endon( "sst_made_nice" + var_8af4bb0185feb88 );
    
    if ( b_waitopen )
    {
        level utility::flag_waitopen( "its_raining" );
    }
    else
    {
        level utility::flag_wait( "its_raining" );
    }
    
    level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0x4
// Checksum 0x5d5909a9, Offset: 0xba62
// Size: 0xd5
function private get_valid_motes()
{
    var_5cc9cd0089f13b5f = [];
    
    foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
    {
        if ( !mote utility::ent_flag( "mote_in_use" ) && !mote.var_648eef0ab0822c74 && !mote utility::ent_flag( "mote_in_forge" ) && !mote utility::ent_flag( "mote_in_dig_pile" ) )
        {
            var_5cc9cd0089f13b5f[ var_5cc9cd0089f13b5f.size ] = mote;
        }
    }
    
    return var_5cc9cd0089f13b5f;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x34e0a028, Offset: 0xbb40
// Size: 0x149
function private function_47bcdaba1e9f702b( var_8af4bb0185feb88, quest )
{
    if ( var_8af4bb0185feb88 == 4 )
    {
        s_forge = utility::getstruct( "main_forge_interact" );
        a_motes = utility::get_array_of_closest( s_forge.origin, get_valid_motes(), undefined, 5 );
        var_2dd7f51f0fb61b5c = [];
        
        foreach ( mote in a_motes )
        {
            if ( mote == quest.var_eeb9ebc1ddc515ce )
            {
                continue;
            }
            
            var_2dd7f51f0fb61b5c[ var_2dd7f51f0fb61b5c.size ] = mote.e_mover;
        }
        
        return build_hud_data_array( var_2dd7f51f0fb61b5c, 32 );
    }
    else if ( var_8af4bb0185feb88 == 3 )
    {
        info = [ level.zm_scarab_mq.brick_prime ];
    }
    else if ( var_8af4bb0185feb88 == 2 )
    {
        level utility::flag_set( "call_the_rains" );
        info = [];
    }
    
    return [ info ];
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc75eb9d3, Offset: 0xbc92
// Size: 0x406
function private function_22b574a3954c779( var_8af4bb0185feb88 )
{
    foreach ( scr_brazier in level.scarab_pap_quest.var_f0218d7a43516520 )
    {
        if ( int( scr_brazier.s_brazier.script_noteworthy ) == var_8af4bb0185feb88 )
        {
            var_5990ce3727e634d1 = scr_brazier.s_brazier;
            break;
        }
    }
    
    if ( !level utility::flag( "totes_plop_hop" + var_8af4bb0185feb88 ) )
    {
        hud_data = [ [ var_5990ce3727e634d1, 48 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_104d076f72742ba1", 1 );
        return;
    }
    
    if ( !level zm_sat_scarab_usurped_power::function_fa42c671f89f2b5() )
    {
        if ( !level zm_sat_scarab_usurped_power::function_c9d7a7dadf1c7b4e() )
        {
            if ( !level utility::flag( "astral_mote_in_forge_area" ) )
            {
                var_5cc9cd0089f13b5f = get_valid_motes();
                
                if ( var_5cc9cd0089f13b5f.size < 1 )
                {
                    level thread zm_quest::update_guidance( undefined, #"hash_e01621c22e6f07ca", #"hash_4a672453c726a415", 1 );
                    level utility::flag_set( "guidance_waiting_on_motes" );
                    return;
                }
                
                mote = utility::get_array_of_closest( level.scarab_pap_quest.var_9d15330b141fe52f.origin, var_5cc9cd0089f13b5f, undefined, 1 )[ 0 ];
                hud_data = [ [ level.scarab_pap_quest.var_9d15330b141fe52f, 0, 256 ], [ mote.e_mover, 32 ] ];
                level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_1671e417066b0f5", 1 );
                level utility::flag_wait( "astral_mote_in_forge_area" );
            }
            
            hud_data = [ [ level.scarab_pap_quest.var_9d15330b141fe52f, 48 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"activate_power_surge", 1 );
            
            while ( !level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ] utility::ent_flag( "has_cosmic_power" ) && !level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 1 ] utility::ent_flag( "has_cosmic_power" ) )
            {
                utility::array_any_wait( level.scarab_pap_quest.var_c6b9e23aac03b4d0, "has_cosmic_power" );
            }
        }
        
        hud_data = [];
        
        foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
        {
            if ( brazier utility::ent_flag( "is_lit" ) && brazier utility::ent_flag( "has_cosmic_power" ) )
            {
                data = [ brazier, 35, undefined, undefined, undefined, brazier ];
                hud_data[ hud_data.size ] = data;
            }
        }
        
        level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_edd785fe4106a894", 1 );
        level waittill( #"cosmic_usurped_power_deployed" );
    }
    
    level utility::flag_wait_or_timeout( "temple_channeling_" + var_8af4bb0185feb88, 5 );
    hud_data = [ [ var_5990ce3727e634d1, 32 ] ];
    level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_fcbc4005ed2f822", 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xa858f737, Offset: 0xc0a0
// Size: 0x2d6
function private function_dd6ac16d2127e7e3( quest, var_3471316e3ec32d4a )
{
    if ( !level utility::flag( "WW_A_P_IN_USE" ) )
    {
        foreach ( player in level.players )
        {
            player zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
        }
        
        if ( !level.scarab_ww_quest.cosmic_fruit )
        {
            hud_data = [ [ utility::getstruct( "ww_f" ), 10 ] ];
            level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_2b136cdf563b5591", 1 );
            level waittill( #"cf_spawned" );
        }
        
        level utility::flag_set( "show_hud_for_t1" );
        hud_data = [ [ level.scarab_ww_quest.cosmic_fruit, 10 ] ];
        level thread zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", #"hash_d9f604148fea3cad", 1 );
        level waittill( #"cf_consumed", player );
        
        if ( player )
        {
            player utility::ent_flag_wait( "WW_PLAYER_IN_A_P_SPACE" );
        }
        
        level thread function_6c8683f5decc16a5( undefined, 1 );
        return;
    }
    
    if ( level utility::flag( "totes_check_check" + 1 ) )
    {
        hud_data = [ [ level.scarab_ww_quest.var_7ba53ebdc38a4c73, 64 ] ];
        function_99d5717226fa4f01( hud_data, #"hash_f931ff63ca0252a0" );
        return;
    }
    
    if ( level utility::flag( "totes_totes_dropped" + 1 ) )
    {
        wait 1;
        
        if ( level utility::flag( "totes_check_check" + 1 ) )
        {
            level thread function_6c8683f5decc16a5( quest, 1 );
        }
        else
        {
            hud_data = [ [ quest.mq_totem, 16 ] ];
            function_99d5717226fa4f01( hud_data, #"hash_e6b8a1d8fd7d182" );
        }
        
        return;
    }
    
    level thread zm_quest::function_9f49b2a045ece8ae( quest.var_e7f54d9d0f760cbc ?? 0, 1, #"hash_f7e08be41d80e326", #"hash_d9f604148fea3cad" );
    s_astral = utility::getstruct( "loc_ash_ap_guide" );
    hud_data = [ [ s_astral, 0, 1600 ] ];
    function_99d5717226fa4f01( hud_data, #"hash_d9f604148fea3cad" );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0x427e57f3, Offset: 0xc37e
// Size: 0x124
function private function_99d5717226fa4f01( hud_data, step_ref )
{
    level zm_quest::update_guidance( hud_data, #"hash_f7e08be41d80e326", step_ref, 1 );
    
    foreach ( player in level.players )
    {
        if ( !player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            level zm_quest::function_38cacc34ddb8431c( player );
            player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
            player zm_quest::function_fb3af5600f6a9441( 2, 0, #"hash_f7e08be41d80e326", #"hash_43046bb19a792b16" );
            continue;
        }
        
        player setclientomnvar( "ui_show_quest_ui_nohud", 1 );
        level utility::flag_set( "show_hud_for_t1" );
        level zm_quest::function_1a1a1e0bd84ac45e( player );
        player thread function_b96e9c997f847e9c();
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 0, eflags: 0xc
// Checksum 0x70dd693f, Offset: 0xc4aa
// Size: 0x4d
function private function_b96e9c997f847e9c()
{
    self notify( #"hash_7973e00968c13d73" );
    self endon( #"hash_7973e00968c13d73" );
    utility::waittill_any( "exit_astral_projection", "finished_exit_astral_projection", "death", "disconnect" );
    level utility::flag_waitopen( "WW_A_P_IN_USE" );
    level thread function_6c8683f5decc16a5( undefined, 1 );
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xc43e656f, Offset: 0xc4ff
// Size: 0x9e
function private function_6f838df31b957c7d( var_8ff12f2d202531c5 )
{
    foreach ( var_d535990f388a9844 in level.zm_scarab_mq.var_bd0720171f444fbe )
    {
        if ( int( var_d535990f388a9844.var_8ff12f2d202531c5 ) == var_8ff12f2d202531c5 )
        {
            return var_d535990f388a9844;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x513f3d3f, Offset: 0xc5a5
// Size: 0x9e
function private function_f511714cf373169e( var_8ff12f2d202531c5 )
{
    foreach ( scr_lever in level.zm_scarab_mq.var_d38c1e11055bbed4 )
    {
        if ( int( scr_lever.var_8ff12f2d202531c5 ) == var_8ff12f2d202531c5 )
        {
            return scr_lever;
        }
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xccd5982f, Offset: 0xc64b
// Size: 0x65
function private build_hud_data_array( array, offset )
{
    hud_data = [];
    
    if ( !isdefined( offset ) )
    {
        offset = 0;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        marker = [ array[ i ], offset ];
        hud_data[ hud_data.size ] = marker;
    }
    
    return hud_data;
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0xff80dc7b, Offset: 0xc6b9
// Size: 0x62
function private get_shadowsmith_str( var_8af4bb0185feb88 )
{
    switch ( int( var_8af4bb0185feb88 ) )
    {
        case 4:
            return "caltheris";
        case 3:
            return "dravakar";
        case 1:
            return "nyxara";
        case 2:
            return "veytharion";
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 1, eflags: 0x4
// Checksum 0x62f08a27, Offset: 0xc723
// Size: 0xc8
function private function_347997091efd0405( params )
{
    str_smith = params[ 0 ];
    
    if ( str_smith == "c" || str_smith == "caltheris" )
    {
        dev_spawn_totem( %"hash_1c79d7031eae7470", 4 );
        return;
    }
    
    if ( str_smith == "d" || str_smith == "dravakar" )
    {
        dev_spawn_totem( %"hash_1c79de031eae8055", 3 );
        return;
    }
    
    if ( str_smith == "v" || str_smith == "veytharion" )
    {
        dev_spawn_totem( %"hash_1c79dd031eae7ea2", 2 );
        return;
    }
    
    if ( str_smith == "n" || str_smith == "nyxara" )
    {
        dev_spawn_totem( %"hash_1c79dc031eae7cef", 1 );
    }
}

// Namespace namespace_7d52c88182a8ee9b
// Params 2, eflags: 0x4
// Checksum 0xdaf9d36a, Offset: 0xc7f3
// Size: 0x188
function private dev_spawn_totem( str_bundle, var_8af4bb0185feb88 )
{
    if ( level utility::flag( "totes_totes_dropped" + var_8af4bb0185feb88 ) )
    {
        iprintlnbold( "Totem for Temple " + var_8af4bb0185feb88 + " already dropped!" );
        return;
    }
    
    if ( level utility::flag( "totes_check_check" + var_8af4bb0185feb88 ) )
    {
        iprintlnbold( "Totem for Temple " + var_8af4bb0185feb88 + " already owned!" );
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
    spawnoptions.critical = 1;
    item = common_item::function_61c2c0251e742ffd( str_bundle, 1, spawnoptions );
    item.info = { #flag:"totes_check_check" + var_8af4bb0185feb88, #var_8af4bb0185feb88:var_8af4bb0185feb88, #item:item };
    str_quest_ref = hashcat( #"hash_5267022c69306b07", get_shadowsmith_str( var_8af4bb0185feb88 ) );
    quest = zm_quest::get_quest( str_quest_ref );
    quest.mq_totem = item;
    level utility::flag_set( "totes_totes_dropped" + var_8af4bb0185feb88 );
    level thread zm_quest::start_quest( str_quest_ref );
    level zm_quest::function_4eefe6de31f5ddab( str_quest_ref, #"totem", 0 );
    
    if ( level.zm_scarab_mq.var_a1b2e808da2bc982 == var_8af4bb0185feb88 )
    {
        level thread function_6c8683f5decc16a5( quest, var_8af4bb0185feb88 );
    }
    
    level callback::add( #"player_item_pickup", &function_9a8e22688a7c3c11, item.info );
}

/#

    // Namespace namespace_7d52c88182a8ee9b
    // Params 0
    // Checksum 0x6399d6ca, Offset: 0xc983
    // Size: 0xc5, Type: dev
    function function_bb64bf73f3a5a4a5()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8e>" );
        devgui::add_devgui_func( "<dev string:xa8>", "<dev string:xc3>", &namespace_9972523f9872e5a4::function_15c042a972d1bd3c );
        devgui::add_devgui_func( "<dev string:xcd>", "<dev string:xe9>", &namespace_9972523f9872e5a4::function_596128becdf13eca );
        devgui::add_devgui_func( "<dev string:xf4>", "<dev string:xf4>", &function_93341e663217a2d8 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x10a>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x127>", "<dev string:x139>", &function_758c34a25f5d7e42 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15e>", "<dev string:x16f>", &function_758c34a25f5d7e42 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x193>", "<dev string:x1a3>", &function_758c34a25f5d7e42 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1c6>", "<dev string:x1d4>", &function_758c34a25f5d7e42 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_7d52c88182a8ee9b
    // Params 1, eflags: 0x4
    // Checksum 0x64b8f3e6, Offset: 0xca50
    // Size: 0xb7, Type: dev
    function private function_758c34a25f5d7e42( params )
    {
        str_shadowsmith = params[ 0 ];
        
        if ( !isdefined( level.var_9690495c3bccdbc7 ) )
        {
            level.var_9690495c3bccdbc7 = [];
        }
        
        var_e5a762be17622596 = level.var_9690495c3bccdbc7[ str_shadowsmith ] ?? 0;
        var_e5a762be17622596 = !var_e5a762be17622596;
        level.var_9690495c3bccdbc7[ str_shadowsmith ] = var_e5a762be17622596;
        new_state = var_e5a762be17622596 ? str_shadowsmith + "<dev string:x1f5>" : str_shadowsmith + "<dev string:x200>";
        setareaswapstate( "<dev string:x20e>" + str_shadowsmith, new_state );
        setglobalsoundcontext( "<dev string:x218>", new_state );
        
        /#
            iprintlnbold( "<dev string:x22d>" + str_shadowsmith + "<dev string:x235>" + new_state );
        #/
    }

    // Namespace namespace_7d52c88182a8ee9b
    // Params 0, eflags: 0x4
    // Checksum 0x92cdc063, Offset: 0xcb0f
    // Size: 0x100, Type: dev
    function private function_93341e663217a2d8()
    {
        a_spawns = utility::getstructarray( "<dev string:x23a>" );
        
        foreach ( s_spawn in a_spawns )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( s_spawn.origin, s_spawn.angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.dropradiusscale = 0;
            spawnoptions.critical = 1;
            item = common_item::function_61c2c0251e742ffd( %"hash_3fc3ad2b4a9d1782", 1, spawnoptions );
            item setscriptablepartstate( "<dev string:x259>", "<dev string:x285>" );
        }
    }

#/
