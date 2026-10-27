// scripts\mp\zm\gametypes\zm_rb_echo.gsc  (hash_2bdf8eafdb703418.gscc) (size: 142701 Bytes / 0x22d6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf37295d (3476498781)
// size ...... 142701 (0x22d6d)
// includes .. 45  (offset: 0x1ff15)
// strings ... 503 (offset: 0x2007d)
// dev strs .. 254 (offset: 0x21ed9)
// exports ... 212 (offset: 0x19881)
// cseg ...... 0x3096 + 0x167eb (0x19881)
// imports ... 513 (offset: 0x1b9a1)
// animtree1 . 0   (offset: 0x22d6d)
// animtree2 . 0   (offset: 0x22d6d)
#using script_4ceb91afc83c5e1;
#using script_c9364426f358755;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\doorbuy;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerachievements;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_curse_inducer;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_rb_echo;

// Namespace zm_rb_echo
// Params 0, eflags: 0x5
// Checksum 0x1d41a9ee, Offset: 0x30b4
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_rb_echo", #"hash_57d064258c711271", &pre_main, &post_main );
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0x2245fcd2, Offset: 0x30e1
// Size: 0x2d
function main()
{
    if ( !function_71f346cd7ddd0613() )
    {
        return;
    }
    
    zm_rb::main();
    level thread intro_sequence();
    utility::add_fx( "vfx_essence_sign", "vfx_jup_ob_gameplay_zm_essence_container_sm" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x479034be, Offset: 0x3116
// Size: 0x129
function private pre_main()
{
    if ( !function_71f346cd7ddd0613() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    [[ level.var_2add2332a4635bbb.create_script_func ]]();
    level.livingworld_disabled = 1;
    level.disable_zm_exfil = 1;
    level.var_8a98c33a6b47db4a = 1;
    level.var_4be693528db27813 = &function_9bd4aa58f8aee070;
    function_7be039dfb809a6e3();
    setdvarifuninitialized( @"hash_1a200a5b437d0133", 1 );
    
    foreach ( str_flag in level.var_2add2332a4635bbb.var_7a3684a13718a7 ?? [] )
    {
        function_5facde78949e303f( str_flag );
    }
    
    level.var_6b28f0a43ed09cc = &function_50fe2b88556cf38a;
    callback::add( "on_player_hotjoin_spectate", &function_9707356b9da2a1d7 );
    level utility::flag_set( "zm_rb_echo_pre_main_complete" );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xddca6e54, Offset: 0x3247
// Size: 0x70
function private function_5facde78949e303f( str_flag )
{
    switch ( str_flag )
    {
        case #"hash_8bbc720ec066d53e":
            level.disable_firefly_plant_ee = 1;
            break;
        case #"hash_72f3cd567bd48410":
            level.disable_firefly_bullseye_ee = 1;
            break;
        default:
            assert( 0, "<dev string:x39>" + str_flag + "<dev string:x64>" );
            break;
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xa22e5640, Offset: 0x32bf
// Size: 0x104
function private function_7be039dfb809a6e3()
{
    level.var_81a2e10a67d09162 = undefined;
    level utility::registersharedfunc( #"zm_rb_echo_event", #"register_provider", &function_4336a44932fbf4c6 );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"build_reward", &function_1a2d26e16b6aebcf );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"select_reward", &function_eae81e972be31ab5 );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"hash_ab3bff0597479fbb", &function_1efb7e2d21257d7f );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"build_pap_upgrade", &function_dd46dff1f32f74d2 );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"grant_reward", &function_ede012a042a1e475 );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"grant_permanent_perk", &function_88e35cca694c6fcd );
    level utility::registersharedfunc( #"zm_rb_echo_event", #"grant_augments", &function_2aff2760352e7afe );
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0x376f8623, Offset: 0x33cb
// Size: 0x17
function function_4336a44932fbf4c6( s_provider )
{
    level.var_81a2e10a67d09162 = s_provider;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xd2d0d3a3, Offset: 0x33ea
// Size: 0xdf
function private function_7d3e45d7e3420e44()
{
    assert( isdefined( level.var_2add2332a4635bbb ), "<dev string:x66>" );
    assert( isdefined( level.var_2add2332a4635bbb.create_script_func ), "<dev string:xbd>" );
    assert( isdefined( level.var_2add2332a4635bbb.var_bcf87c357a7634ec ), "<dev string:xf1>" );
    assert( isdefined( level.var_2add2332a4635bbb.var_8074703df595efae ), "<dev string:x125>" );
    assert( isdefined( level.var_2add2332a4635bbb.var_4aa676077979d1dd ), "<dev string:x15b>" );
    assert( isdefined( level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c ), "<dev string:x190>" );
    assert( isdefined( level.var_2add2332a4635bbb.var_8eac6e744e8c5bf1 ), "<dev string:x1cc>" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xed5ac9d, Offset: 0x34d1
// Size: 0x21e
function private post_main()
{
    if ( !function_71f346cd7ddd0613() )
    {
        return;
    }
    
    function_7d3e45d7e3420e44();
    init_echo_portal_data();
    level._effect[ "echo_portal_teleport_3p" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    function_85de097d9835fbfd();
    init_echo_reward_config();
    level thread function_6e4066f97409fbef();
    function_cf84442771fceb67();
    function_aa7484b026c94c2b();
    function_24ecb66295f8f2e5();
    function_2c9ca6bc8da0b125();
    level.echo_portals = [];
    level.var_2099a31bd7242769 = [];
    level.var_426524a88a587a04 = [];
    level.var_8f9e5e6c5e6959a3 = "";
    level.var_b71496deb2f6852e = 1;
    function_1743d8e97e350646();
    function_4dd7b85873427fd();
    function_163f1c895105f646();
    level.var_ec48a8802bc5bec1 = &echo_round_wait;
    level thread utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_mystery_box" );
    level thread utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_ammo_cache" );
    level callback::add( #"player_spawned", &function_92bcaa1f58045f02 );
    level callback::add( #"player_connect", &function_302abc17beca67c2 );
    level callback::add( #"hash_22fdd0c3eb081084", &function_3b20acf2a09b6561 );
    
    /#
        iprintlnbold( "<dev string:x1fe>" + level.var_ad0c50e3383a3d97.size + "<dev string:x21e>" );
    #/
    
    level thread temp_open_map();
    level thread function_84e945a31804e3ad();
    level thread zm_round_spawning::function_c134fd55f45903e6( level.var_ff633893b6fa75c3.str_round_spawning, 1 );
    level.var_545d992d40a9d7de = &zm_rb_echo_delay;
    level.var_6781718da4f78d1c.spawndelay = 0.5;
    level callback::add( "on_zombie_ai_spawned", &mod_zombie_speed );
    level callback::add( "on_zombie_ai_spawned", &function_ababdb4db38b0d7b );
    init_echo_difficulty();
    level callback::add( "on_powerup_nuke_pickup", &function_aeb4a44969920364 );
    level thread namespace_1fd313b1d0d63e6b::function_1682ed43380d6452();
    level thread function_6b3b838e36a620ae();
    
    /#
        level thread function_aac14197b12f159f();
        level thread function_8e780e0a9a12304d();
        level thread namespace_1fd313b1d0d63e6b::function_d3a5a539b3bb20e1();
        init_echo_devgui();
    #/
    
    function_2a5128c332a620ea();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x74cf27a, Offset: 0x36f7
// Size: 0x162
function private function_2a5128c332a620ea()
{
    if ( !getdvarint( @"enable_curse_inducer", 0 ) )
    {
        return;
    }
    
    if ( !( level.var_2add2332a4635bbb.var_d23b400600effd18 ?? 0 ) )
    {
        return;
    }
    
    var_c509fbbab288a520 = utility::getstructarray( "curse_inducer", "targetname" );
    
    if ( !var_c509fbbab288a520.size )
    {
        /#
            iprintlnbold( "<dev string:x230>" );
        #/
        
        return;
    }
    
    level.var_f3262792261367c6 = [];
    
    foreach ( var_16af6624858ffa21 in var_c509fbbab288a520 )
    {
        str_arena = var_16af6624858ffa21.script_noteworthy;
        
        if ( isdefined( str_arena ) )
        {
            level.var_f3262792261367c6[ str_arena ] = var_16af6624858ffa21;
        }
    }
    
    initial_pos = utility::registersharedfunc( #"curse_inducer", #"override_curse_inducer", &function_f1b9d6589b42dcc3 );
    var_cd3fdf9590d7ee1d = level.var_2add2332a4635bbb.var_1ea74a4676fa9871;
    zm_curse_inducer::init_curse_inducer( var_cd3fdf9590d7ee1d, initial_pos );
    
    if ( isdefined( level.s_curse_inducer ) )
    {
        level.var_eab836491208ed9f = 1;
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xbbdb68d1, Offset: 0x3861
// Size: 0x1f
function private function_f1b9d6589b42dcc3()
{
    return level.var_f3262792261367c6[ level.var_2add2332a4635bbb.var_8074703df595efae ];
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0x93e79cf3, Offset: 0x3889
// Size: 0x29
function function_6b3b838e36a620ae()
{
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    wait 0.1;
    level._custom_perks[ "specialty_z_mod" ] = undefined;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2947b930, Offset: 0x38ba
// Size: 0x40
function private intro_sequence()
{
    level utility::flag_wait( "begin_round_logic" );
    func = utility::getsharedfunc( #"zm_rb_echo", #"intro_sequence" );
    
    if ( isdefined( func ) )
    {
        level thread [[ func ]]();
        return;
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb40c2d37, Offset: 0x3902
// Size: 0x34b
function private temp_open_map()
{
    level utility::flag_wait( "begin_round_logic" );
    
    if ( level.var_2add2332a4635bbb.var_fa13ef47a8925257 ?? 0 )
    {
        doorbuy::open_all_doorbuys();
    }
    else
    {
        foreach ( s_doorbuy in level.a_s_doorbuys )
        {
            if ( s_doorbuy isscriptable() || !isent( s_doorbuy ) && s_doorbuy isscriptableinstance() )
            {
                if ( s_doorbuy getscriptablehaspart( "icon" ) && self getscriptableparthasstate( "icon", "hide" ) )
                {
                    s_doorbuy utility::ent_flag_wait( "minimap_floor_setup_complete" );
                    s_doorbuy calloutmarkerping::function_608710c894185549();
                    s_doorbuy setscriptablepartstate( "icon", "hide" );
                }
            }
            
            foreach ( door in s_doorbuy.doors )
            {
                if ( isdefined( door.minimap_scriptable ) )
                {
                    door.minimap_scriptable calloutmarkerping::function_608710c894185549();
                    door.minimap_scriptable freescriptable();
                }
            }
            
            if ( s_doorbuy.interact )
            {
                s_doorbuy.interact delete();
            }
            
            if ( isdefined( s_doorbuy.minimap_scriptable ) )
            {
                s_doorbuy.minimap_scriptable calloutmarkerping::function_608710c894185549();
                s_doorbuy.minimap_scriptable freescriptable();
            }
        }
    }
    
    if ( isdefined( level.var_2add2332a4635bbb.str_boss_zone ) )
    {
        zone_manager::set_zone_enabled( level.var_2add2332a4635bbb.str_boss_zone, 1 );
    }
    
    if ( level.var_2add2332a4635bbb.var_f2ca359ba559c822 ?? 0 )
    {
        foreach ( var_cfdcb332178e0755 in level.var_2add2332a4635bbb.var_8eac6e744e8c5bf1 )
        {
            foreach ( var_4cdafb4532dd9de4 in var_cfdcb332178e0755 )
            {
                zone_manager::set_zone_enabled( var_4cdafb4532dd9de4, 1 );
            }
        }
    }
    
    function_45e3d1f9c4799e62( level.var_2add2332a4635bbb.var_8074703df595efae );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xad547c37, Offset: 0x3c55
// Size: 0xe, Type: bool
function private function_71f346cd7ddd0613()
{
    return game_utility::getgametype() == "zm_rb_echo";
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x31006f56, Offset: 0x3c6c
// Size: 0x2ef
function private function_85de097d9835fbfd()
{
    var_23d56965a546c812 = getdvarint( @"zm_echo_boss_variant", 0 );
    
    switch ( var_23d56965a546c812 )
    {
        case 1:
            level.var_ff633893b6fa75c3 = { #str_round_spawning:level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c, #var_e6cc809893320971:[ &function_4b2985c54da15df0 ], #var_272915a5526bc115:[ 20 ], #str_boss_subclass:"zombie_ghoul_hvt_echo", #var_23d56965a546c812:1 };
            break;
        case 2:
            level.var_ff633893b6fa75c3 = { #str_round_spawning:level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c, #var_e6cc809893320971:[ &function_a859b8fe6bb38a40 ], #var_272915a5526bc115:[ 20 ], #str_boss_subclass:"zombie_amalgam_hvt_echo", #var_23d56965a546c812:2 };
            break;
        case 3:
            level.var_ff633893b6fa75c3 = { #str_round_spawning:level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c, #var_e6cc809893320971:[ &function_4e56b1c0b59df2fb ], #var_272915a5526bc115:[ 20 ], #str_boss_subclass:"zombie_abom_hvt_echo", #var_23d56965a546c812:3 };
            break;
        case 4:
            var_13b1c2430cd7c947 = arrayrandomize( [ &function_4b2985c54da15df0, &function_4e56b1c0b59df2fb, &function_a859b8fe6bb38a40 ] );
            level.var_ff633893b6fa75c3 = { #str_round_spawning:level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c, #var_e6cc809893320971:var_13b1c2430cd7c947, #var_272915a5526bc115:[ 20, 30, 40 ], #str_boss_subclass:"zombie_amalgam", #var_23d56965a546c812:4 };
            break;
        default:
            level.var_ff633893b6fa75c3 = { #str_round_spawning:level.var_2add2332a4635bbb.var_ecaa27f35aef5b3c, #var_e6cc809893320971:[], #var_272915a5526bc115:[], #str_boss_subclass:undefined, #var_23d56965a546c812:0 };
            break;
    }
    
    /#
        iprintlnbold( "<dev string:x280>" + var_23d56965a546c812 );
    #/
    
    if ( level.var_ff633893b6fa75c3.var_272915a5526bc115.size )
    {
        level.var_cf5927ac4c367a67 = 1;
        level.var_592e0ef82d974fe7 = 0;
        level.var_bcdcacffcfacfe95 = level.var_ff633893b6fa75c3.var_272915a5526bc115.size;
        return;
    }
    
    level.var_cf5927ac4c367a67 = 0;
    level.var_592e0ef82d974fe7 = 0;
    level.var_bcdcacffcfacfe95 = 0;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x7a1f3637, Offset: 0x3f63
// Size: 0x310f
function private init_echo_reward_config()
{
    level.var_f6902967d180948a = [ { #max_round:undefined, #min_round:undefined, #weight:80, #type:"rarity_upgrade" }, { #max_round:15, #min_round:undefined, #weight:30, #type:"pap1" }, { #max_round:25, #min_round:10, #weight:50, #type:"pap2" }, { #max_round:undefined, #min_round:20, #weight:25, #type:"pap3" }, { #max_round:undefined, #min_round:20, #weight:15, #type:"pap4" }, { #max_round:undefined, #min_round:undefined, #weight:1520, #type:"ammo_mod" }, { #max_round:undefined, #min_round:undefined, #weight:30, #type:"wonder_weapon" }, { #max_round:undefined, #min_round:undefined, #weight:1520, #type:"perk" }, { #max_round:undefined, #min_round:undefined, #weight:100, #type:"essence" }, { #max_round:undefined, #min_round:undefined, #weight:80, #type:"field_upgrade" }, { #max_round:undefined, #min_round:undefined, #weight:300, #type:"loadout_refill" }, { #max_round:undefined, #min_round:undefined, #weight:80, #type:"armor_upgrade" }, { #max_round:undefined, #min_round:undefined, #weight:40, #type:"golden_armor" }, { #max_round:undefined, #min_round:undefined, #weight:500, #type:"augment" }, { #max_round:undefined, #min_round:undefined, #weight:1500, #type:"weapon" } ];
    level.var_1bc7a9eda89a078d = level.zm_relic_tier ?? 0;
    level.var_81ce411cb6528e21 = [ { #weight:500, #type:"weapon_ar", #class:"ar" }, { #weight:500, #type:"weapon_smg", #class:"smg" }, { #weight:500, #type:"weapon_lmg", #class:"lmg" }, { #weight:500, #type:"weapon_sh", #class:"sh" }, { #weight:500, #type:"weapon_sn", #class:"sn" }, { #weight:500, #type:"weapon_dm", #class:"dm" }, { #weight:500, #type:"weapon_pi", #class:"pi" }, { #weight:500, #type:"weapon_melee", #class:"me" } ];
    level.var_b1f66e209d5b5c60 = [ 200, 700, 100 ];
    level.var_e1277df6c7b0d16e = [ { #weight:800, #perk:"specialty_juggernog" }, { #weight:800, #perk:"specialty_quickrevive" }, { #weight:800, #perk:"specialty_speedcola" }, { #weight:600, #perk:"specialty_staminup" }, { #weight:400, #perk:"specialty_deadshot" }, { #weight:400, #perk:"specialty_death_perception" }, { #weight:800, #perk:"specialty_elemental_pop" }, { #weight:300, #perk:"specialty_phd_flopper" }, { #weight:300, #perk:"specialty_vulture_aid" }, { #weight:400, #perk:"specialty_m_mod" }, { #weight:400, #perk:"specialty_d_mod" }, { #weight:800, #perk:"specialty_w_mod" }, { #weight:800, #perk:"specialty_y_mod" } ];
    level.var_5e4906d509cd618f = [ { #var_afdcadb44a80e6a2:"zm_t10_ammomod_brainrot", #weight:500, #ammo_mod:"brainrot" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_cryofreeze", #weight:500, #ammo_mod:"cryofreeze" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_deadwire", #weight:500, #ammo_mod:"deadwire" }, { #var_afdcadb44a80e6a2:"fw_ammomod_sat", #weight:500, #ammo_mod:"fw_ammomod" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_napalmburst", #weight:500, #ammo_mod:"napalmburst" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_lightray", #weight:500, #ammo_mod:"lightray" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_shadowvortex", #weight:500, #ammo_mod:"shadowvortex" }, { #var_afdcadb44a80e6a2:"zm_t10_ammomod_shatterblast", #weight:500, #ammo_mod:"shatterblast" } ];
    level.var_108676f50d3d5999 = [ { #weight:500, #field_upgrade:"super_aether_shroud" }, { #weight:500, #field_upgrade:"super_energy_mine" }, { #weight:500, #field_upgrade:"super_frenzied_guard" }, { #weight:500, #field_upgrade:"super_frost_blast" }, { #weight:500, #field_upgrade:"super_healing_aura" }, { #weight:500, #field_upgrade:"super_tesla_storm" }, { #weight:500, #field_upgrade:"super_dark_flare" }, { #weight:500, #field_upgrade:"super_mary_paris" }, { #weight:500, #field_upgrade:"super_toxic_growth" }, { #weight:500, #field_upgrade:"super_wiley_fox" } ];
    level.var_98451248a70b7bb3 = [];
    level.var_98451248a70b7bb3[ "specialty_juggernog" ] = [ #"juggernog_well_constructed", #"juggernog_juggernaut", #"juggernog_turtle_shell", #"juggernog_reactive_armor", #"juggernog_thicker_plates", #"juggernog_retaliation", #"juggernog_iron_core", #"juggernog_perfect_counter" ];
    level.var_98451248a70b7bb3[ "specialty_quickrevive" ] = [ #"quick_revive_die_hard", #"quick_revive_escape_plan", #"quick_revive_last_chance", #"quick_revive_dying_wish", #"quick_revive_adrenaline_rush" ];
    level.var_98451248a70b7bb3[ "specialty_speedcola" ] = [ #"speedcola_faster_field_upgrade", #"speedcola_phantom_reload", #"speedcola_classic_formula", #"speedcola_faster_equipment", #"speedcola_faster_switch", #"speedcola_sprint_reload" ];
    level.var_98451248a70b7bb3[ "specialty_staminup" ] = [ #"staminup_endurance", #"staminup_multitask", #"staminup_speed_boost", #"staminup_slippery_target", #"staminup_stalker", #"staminup_light_footed", #"staminup_guns_up", #"staminup_footwork" ];
    level.var_98451248a70b7bb3[ "specialty_deadshot" ] = [ #"deadshot_first_strike", #"deadshot_piercing_rounds", #"deadshot_critical_efficiency", #"deadshot_fmj", #"deadshot_gunslinger", #"deadshot_dead_heat", #"deadshot_dead_to_rights" ];
    level.var_98451248a70b7bb3[ "specialty_death_perception" ] = [ #"deathperception_birds_eye_view", #"deathperception_critical_eye", #"deathperception_death_stare", #"deathperception_extra_change", #"deathperception_further_insight", #"deathperception_hidden_gems", #"deathperception_sixth_sense" ];
    level.var_98451248a70b7bb3[ "specialty_elemental_pop" ] = [ #"elemental_pop_advantage", #"elemental_pop_elemental_protection", #"elemental_pop_tuned_frequency", #"elemental_pop_electric_cherry", #"elemental_pop_elemental_equipment", #"elemental_pop_more_pop", #"elemental_pop_refresh_mint", #"elemental_pop_rainbow_pop" ];
    level.var_98451248a70b7bb3[ "specialty_phd_flopper" ] = [ #"phdflopper_slider", #"phdflopper_explosive_fall", #"phdflopper_hair_trigger", #"phdflopper_safe_slide", #"phdflopper_shove", #"phdflopper_slide_boost", #"phdflopper_double_whammy", #"phdflopper_wall_flopper" ];
    level.var_98451248a70b7bb3[ "specialty_vulture_aid" ] = [ #"vulture_aid_camouflage", #"vulture_aid_condors_reach", #"vulture_aid_fetidupgraid", #"vulture_aid_picky_eater", #"vulture_aid_extra_serving", #"vulture_aid_replate" ];
    level.var_98451248a70b7bb3[ "specialty_m_mod" ] = [ #"m_mod_hidden_impact", #"m_mod_overwhelming_force", #"m_mod_pressure_points", #"m_mod_backpedal", #"m_mod_vampirism", #"m_mod_faster_melee", #"m_mod_panic_knife", #"m_mod_closing_argument" ];
    level.var_98451248a70b7bb3[ "specialty_d_mod" ] = [ #"d_mod_double_jeopardy", #"d_mod_double_or_nothing", #"d_mod_double_play", #"d_mod_double_standard", #"d_mod_double_time", #"d_mod_double_impact", #"d_mod_double_dealer", #"d_mod_low_ammo" ];
    level.var_98451248a70b7bb3[ "specialty_w_mod" ] = [ #"w_mod_extension", #"w_mod_haste", #"w_mod_demon_mask", #"w_mod_savior", #"w_mod_will_o_wisp", #"w_mod_lure", #"w_mod_pretty_mask", #"w_mod_fetcher" ];
    level.var_98451248a70b7bb3[ "specialty_y_mod" ] = [ #"y_mod_web_spinner", #"y_mod_widows_bite", #"y_mod_hatchling", #"y_mod_tangled_web", #"y_mod_haste", #"y_mod_extension", #"y_mod_wide_web", #"y_mod_lethal_equipment" ];
    level.var_6c3426d7b2e5e264 = [];
    level.var_6c3426d7b2e5e264[ "cryofreeze" ] = [ #"cryofreeze_big_game", #"cryofreeze_ice_cloud", #"cryofreeze_full_frost", #"cryofreeze_damage_boost", #"cryofreeze_focus", #"cryofreeze_extension", #"cryofreeze_aoe_proc", #"cryofreeze_post_freeze_damage" ];
    level.var_6c3426d7b2e5e264[ "brainrot" ] = [ #"brainrot_big_game", #"brainrot_extension", #"brainrot_haste", #"brainrot_explosive", #"brainrot_bloat", #"brainrot_plague", #"brainrot_irradiated", #"brainrot_more_damage" ];
    level.var_6c3426d7b2e5e264[ "deadwire" ] = [ #"deadwire_big_game", #"deadwire_extension", #"deadwire_damage_boost", #"deadwire_haste", #"deadwire_chain_lightning", #"deadwire_lightning_strike", #"deadwire_aftershock", #"deadwire_ball_lightning" ];
    level.var_6c3426d7b2e5e264[ "napalmburst" ] = [ #"napalmburst_big_game", #"napalmburst_contact_burn", #"napalmburst_damage_boost", #"napalmburst_extension", #"napalmburst_incendiary", #"napalmburst_pyro", #"napalmburst_backdraft", #"napalmburst_petrol" ];
    level.var_6c3426d7b2e5e264[ "shatterblast" ] = [ #"shatterblast_big_game", #"shatterblast_blast_boost", #"shatterblast_blast_chain", #"shatterblast_blast_repair", #"shatterblast_blast_wave", #"shatterblast_blast_zone", #"shatterblast_blast_off", #"shatterblast_blast_shield" ];
    level.var_6c3426d7b2e5e264[ "shadowvortex" ] = [ #"shadowvortex_big_game", #"shadowvortex_explosive_rain", #"shadowvortex_topple_danger", #"shadowvortex_supermassive", #"shadowvortex_targeted", #"shadowvortex_haste", #"shadowvortex_blackhole", #"shadowvortex_reload" ];
    level.var_6c3426d7b2e5e264[ "lightray" ] = [ #"lightray_antibiotic", #"lightray_big_game", #"lightray_dual_action", #"lightray_express_remedy", #"lightray_extra_strength", #"lightray_longer_life", #"lightray_booster_shot", #"lightray_mitosis" ];
    level.var_6c3426d7b2e5e264[ "fw_ammomod" ] = [ #"fw_big_game", #"fw_condensed_yield", #"fw_starlight", #"fw_farfalle", #"fw_weeping_willow", #"fw_big_bang", #"fw_fire_wheel", #"fw_haste" ];
    level.var_151effd1b9580cae = [];
    level.var_151effd1b9580cae[ "super_aether_shroud" ] = [ #"aether_shroud_aether_dash", #"aether_shroud_shadow_blade", #"aether_shroud_group_shroud", #"aether_shroud_otherworldly_reload", #"aether_shroud_high_capacity", #"aether_shroud_extension", #"aether_shroud_afterimage", #"aether_shroud_taken" ];
    level.var_151effd1b9580cae[ "super_energy_mine" ] = [ #"energy_mine_carousel", #"energy_mine_high_capacity", #"energy_mine_scatter_mine", #"energy_mine_spire", #"energy_mine_frequency_boost", #"energy_mine_siren", #"energy_mine_recycle", #"energy_mine_smart_mine" ];
    level.var_151effd1b9580cae[ "super_frenzied_guard" ] = [ #"frenzied_guard_frenzy_fire", #"frenzied_guard_phalanx", #"frenzied_guard_retribution", #"frenzied_guard_extension", #"frenzied_guard_rally", #"frenzied_guard_repair_boost", #"frenzied_guard_fists_of_frenzy", #"frenzied_guard_high_defense" ];
    level.var_151effd1b9580cae[ "super_frost_blast" ] = [ #"frost_blast_cast", #"frost_blast_flash_freeze", #"frost_blast_slick", #"frost_blast_extension", #"frost_blast_high_capacity", #"frost_blast_frostbite", #"frost_blast_stone_cold_stronghold", #"frost_blast_slow_extend" ];
    level.var_151effd1b9580cae[ "super_healing_aura" ] = [ #"healingaura_inner_strength", #"healingaura_pillar_of_light", #"healingaura_protection", #"healingaura_stoic_presence", #"healingaura_resilience", #"healingaura_keep_perks", #"healingaura_necromancer", #"healingaura_bountiful_harvest" ];
    level.var_151effd1b9580cae[ "super_tesla_storm" ] = [ #"tesla_storm_lithium_charged", #"tesla_storm_overclocked", #"tesla_storm_power_grid", #"tesla_storm_shockwave", #"tesla_storm_static_discharge", #"tesla_storm_transformer", #"tesla_storm_sat_minor", #"tesla_storm_sat_major" ];
    level.var_151effd1b9580cae[ "super_dark_flare" ] = [ #"dark_flare_big_beam", #"dark_flare_dark_pact", #"dark_flare_extension", #"dark_flare_high_capacity", #"dark_flare_shadow_ball", #"dark_flare_slowdown", #"dark_flare_phantasmal", #"dark_flare_shadow_burn" ];
    level.var_151effd1b9580cae[ "super_mary_paris" ] = [ #"mary_paris_social_butterfly", #"mary_paris_party_animal", #"mary_paris_apex_hunter", #"mary_paris_arcane_fury", #"mary_paris_dance_party", #"mary_paris_peek_health" ];
    level.var_151effd1b9580cae[ "super_toxic_growth" ] = [ #"toxic_growth_ankle_shredder", #"toxic_growth_cordyception", #"toxic_growth_crescent", #"toxic_growth_extra_charge", #"toxic_growth_green_thumb", #"toxic_growth_pollination", #"toxic_growth_zoochory", #"toxic_growth_plant_food" ];
    level.var_9726014da3c8d6c1 = [];
    level.var_9726014da3c8d6c1[ #"juggernog_iron_core" ] = "juggernog_iron_core_sat";
    level.var_9726014da3c8d6c1[ #"juggernog_juggernaut" ] = "juggernog_juggernaut_cer";
    level.var_9726014da3c8d6c1[ #"juggernog_perfect_counter" ] = "juggernog_perfect_counter_sat";
    level.var_9726014da3c8d6c1[ #"juggernog_reactive_armor" ] = "juggernog_reactive_armor_cer";
    level.var_9726014da3c8d6c1[ #"juggernog_retaliation" ] = "juggernog_retaliation_cer";
    level.var_9726014da3c8d6c1[ #"juggernog_thicker_plates" ] = "juggernog_thicker_plates_cer";
    level.var_9726014da3c8d6c1[ #"juggernog_turtle_shell" ] = "juggernog_turtle_shell_cer";
    level.var_9726014da3c8d6c1[ #"juggernog_well_constructed" ] = "juggernog_well_constructed_cer";
    level.var_9726014da3c8d6c1[ #"quick_revive_adrenaline_rush" ] = "quick_revive_adrenaline_rush_sat";
    level.var_9726014da3c8d6c1[ #"quick_revive_die_hard" ] = "quick_revive_die_hard_cer";
    level.var_9726014da3c8d6c1[ #"quick_revive_dying_wish" ] = "quick_revive_dying_wish_cer";
    level.var_9726014da3c8d6c1[ #"quick_revive_escape_plan" ] = "quick_revive_escape_plan_cer";
    level.var_9726014da3c8d6c1[ #"quick_revive_last_chance" ] = "quick_revive_last_chance_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_classic_formula" ] = "speedcola_classic_formula_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_faster_equipment" ] = "speedcola_faster_equipment_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_faster_field_upgrade" ] = "speedcola_faster_field_upgrade_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_faster_switch" ] = "speedcola_faster_switch_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_phantom_reload" ] = "speedcola_phantom_reload_cer";
    level.var_9726014da3c8d6c1[ #"speedcola_sprint_reload" ] = "speedcola_sprint_reload_sat";
    level.var_9726014da3c8d6c1[ #"staminup_endurance" ] = "staminup_endurance_cer";
    level.var_9726014da3c8d6c1[ #"staminup_footwork" ] = "staminup_footwork_sat";
    level.var_9726014da3c8d6c1[ #"staminup_guns_up" ] = "staminup_guns_up_sat";
    level.var_9726014da3c8d6c1[ #"staminup_light_footed" ] = "staminup_light_footed_cer";
    level.var_9726014da3c8d6c1[ #"staminup_multitask" ] = "staminup_multitask_cer";
    level.var_9726014da3c8d6c1[ #"staminup_slippery_target" ] = "staminup_slippery_target_cer";
    level.var_9726014da3c8d6c1[ #"staminup_speed_boost" ] = "staminup_speed_boost_cer";
    level.var_9726014da3c8d6c1[ #"staminup_stalker" ] = "staminup_stalker_cer";
    level.var_9726014da3c8d6c1[ #"deadshot_critical_efficiency" ] = "deadshot_critical_efficiency_cer";
    level.var_9726014da3c8d6c1[ #"deadshot_dead_heat" ] = "deadshot_dead_heat_sat";
    level.var_9726014da3c8d6c1[ #"deadshot_dead_to_rights" ] = "deadshot_dead_to_rights_sat";
    level.var_9726014da3c8d6c1[ #"deadshot_first_strike" ] = "deadshot_first_strike_cer";
    level.var_9726014da3c8d6c1[ #"deadshot_fmj" ] = "deadshot_fmj_cer";
    level.var_9726014da3c8d6c1[ #"deadshot_gunslinger" ] = "deadshot_gunslinger_cer";
    level.var_9726014da3c8d6c1[ #"deadshot_piercing_rounds" ] = "deadshot_piercing_rounds_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_birds_eye_view" ] = "deathperception_birds_eye_view_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_critical_eye" ] = "deathperception_critical_eye_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_death_stare" ] = "deathperception_death_stare_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_extra_change" ] = "deathperception_extra_change_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_further_insight" ] = "deathperception_further_insight_cer";
    level.var_9726014da3c8d6c1[ #"deathperception_hidden_gems" ] = "deathperception_hidden_gems_sat";
    level.var_9726014da3c8d6c1[ #"deathperception_sixth_sense" ] = "deathperception_sixth_sense_sat";
    level.var_9726014da3c8d6c1[ #"elemental_pop_advantage" ] = "elemental_pop_advantage_cer";
    level.var_9726014da3c8d6c1[ #"elemental_pop_electric_cherry" ] = "elemental_pop_electric_cherry_cer";
    level.var_9726014da3c8d6c1[ #"elemental_pop_elemental_equipment" ] = "elemental_pop_elemental_equipment_cer";
    level.var_9726014da3c8d6c1[ #"elemental_pop_elemental_protection" ] = "elemental_pop_elemental_protection_cer";
    level.var_9726014da3c8d6c1[ #"elemental_pop_more_pop" ] = "elemental_pop_more_pop_cer";
    level.var_9726014da3c8d6c1[ #"elemental_pop_rainbow_pop" ] = "elemental_pop_rainbow_pop_sat";
    level.var_9726014da3c8d6c1[ #"elemental_pop_refresh_mint" ] = "elemental_pop_refresh_mint_sat";
    level.var_9726014da3c8d6c1[ #"elemental_pop_tuned_frequency" ] = "elemental_pop_tuned_frequency_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_double_whammy" ] = "phdflopper_double_whammy_sat";
    level.var_9726014da3c8d6c1[ #"phdflopper_explosive_fall" ] = "phdflopper_explosive_fall_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_hair_trigger" ] = "phdflopper_hair_trigger_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_safe_slide" ] = "phdflopper_safe_slide_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_shove" ] = "phdflopper_shove_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_slide_boost" ] = "phdflopper_slide_boost_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_slider" ] = "phdflopper_slider_cer";
    level.var_9726014da3c8d6c1[ #"phdflopper_wall_flopper" ] = "phdflopper_wall_flopper_sat";
    level.var_9726014da3c8d6c1[ #"vulture_aid_camouflage" ] = "vulture_aid_camouflage_cer";
    level.var_9726014da3c8d6c1[ #"vulture_aid_condors_reach" ] = "vulture_aid_condors_reach_cer";
    level.var_9726014da3c8d6c1[ #"vulture_aid_extra_serving" ] = "vulture_aid_extra_serving_sat";
    level.var_9726014da3c8d6c1[ #"vulture_aid_fetidupgraid" ] = "vulture_aid_fetidupgraid_cer";
    level.var_9726014da3c8d6c1[ #"vulture_aid_picky_eater" ] = "vulture_aid_picky_eater_cer";
    level.var_9726014da3c8d6c1[ #"vulture_aid_replate" ] = "vulture_aid_replate_sat";
    level.var_9726014da3c8d6c1[ #"m_mod_backpedal" ] = "m_mod_backpedal_cer";
    level.var_9726014da3c8d6c1[ #"m_mod_closing_argument" ] = "m_mod_closing_argument_sat";
    level.var_9726014da3c8d6c1[ #"m_mod_faster_melee" ] = "m_mod_faster_melee_cer";
    level.var_9726014da3c8d6c1[ #"m_mod_hidden_impact" ] = "m_mod_hidden_impact_cer";
    level.var_9726014da3c8d6c1[ #"m_mod_overwhelming_force" ] = "m_mod_overwhelming_force_cer";
    level.var_9726014da3c8d6c1[ #"m_mod_panic_knife" ] = "m_mod_panic_knife_sat";
    level.var_9726014da3c8d6c1[ #"m_mod_pressure_points" ] = "m_mod_pressure_points_cer";
    level.var_9726014da3c8d6c1[ #"m_mod_vampirism" ] = "m_mod_vampirism_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_dealer" ] = "d_mod_double_dealer_sat";
    level.var_9726014da3c8d6c1[ #"d_mod_double_impact" ] = "d_mod_double_impact_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_jeopardy" ] = "d_mod_double_jeopardy_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_or_nothing" ] = "d_mod_double_or_nothing_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_play" ] = "d_mod_double_play_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_standard" ] = "d_mod_double_standard_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_double_time" ] = "d_mod_double_time_cer";
    level.var_9726014da3c8d6c1[ #"d_mod_low_ammo" ] = "d_mod_low_ammo_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_demon_mask" ] = "w_mod_demon_mask_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_extension" ] = "w_mod_extension_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_fetcher" ] = "w_mod_fetcher_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_haste" ] = "w_mod_haste_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_lure" ] = "w_mod_lure_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_pretty_mask" ] = "w_mod_pretty_mask_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_savior" ] = "w_mod_savior_sat";
    level.var_9726014da3c8d6c1[ #"w_mod_will_o_wisp" ] = "w_mod_will_o_wisp_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_web_spinner" ] = "y_mod_web_spinner_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_widows_bite" ] = "y_mod_widows_bite_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_hatchling" ] = "y_mod_hatchling_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_tangled_web" ] = "y_mod_tangled_web_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_haste" ] = "y_mod_haste_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_extension" ] = "y_mod_extension_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_wide_web" ] = "y_mod_wide_web_sat";
    level.var_9726014da3c8d6c1[ #"y_mod_lethal_equipment" ] = "y_mod_lethal_equipment_sat";
    level.var_9726014da3c8d6c1[ #"cryofreeze_aoe_proc" ] = "cryofreeze_aoe_proc_sat";
    level.var_9726014da3c8d6c1[ #"cryofreeze_big_game" ] = "cryofreeze_big_game_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_damage_boost" ] = "cryofreeze_damage_boost_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_extension" ] = "cryofreeze_extension_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_focus" ] = "cryofreeze_focus_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_full_frost" ] = "cryofreeze_full_frost_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_ice_cloud" ] = "cryofreeze_ice_cloud_cer";
    level.var_9726014da3c8d6c1[ #"cryofreeze_post_freeze_damage" ] = "cryofreeze_post_freeze_damage_sat";
    level.var_9726014da3c8d6c1[ #"brainrot_big_game" ] = "brainrot_big_game_cer";
    level.var_9726014da3c8d6c1[ #"brainrot_bloat" ] = "brainrot_bloat_cer";
    level.var_9726014da3c8d6c1[ #"brainrot_explosive" ] = "brainrot_explosive_cer";
    level.var_9726014da3c8d6c1[ #"brainrot_extension" ] = "brainrot_extension_cer";
    level.var_9726014da3c8d6c1[ #"brainrot_haste" ] = "brainrot_haste_cer";
    level.var_9726014da3c8d6c1[ #"brainrot_irradiated" ] = "brainrot_irradiated_sat";
    level.var_9726014da3c8d6c1[ #"brainrot_more_damage" ] = "brainrot_more_damage_sat";
    level.var_9726014da3c8d6c1[ #"brainrot_plague" ] = "brainrot_plague_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_aftershock" ] = "deadwire_aftershock_sat";
    level.var_9726014da3c8d6c1[ #"deadwire_ball_lightning" ] = "deadwire_ball_lightning_sat";
    level.var_9726014da3c8d6c1[ #"deadwire_big_game" ] = "deadwire_big_game_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_chain_lightning" ] = "deadwire_chain_lightning_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_damage_boost" ] = "deadwire_damage_boost_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_extension" ] = "deadwire_extension_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_haste" ] = "deadwire_haste_cer";
    level.var_9726014da3c8d6c1[ #"deadwire_lightning_strike" ] = "deadwire_lightning_strike_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_backdraft" ] = "napalmburst_backdraft_sat";
    level.var_9726014da3c8d6c1[ #"napalmburst_big_game" ] = "napalmburst_big_game_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_contact_burn" ] = "napalmburst_contact_burn_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_damage_boost" ] = "napalmburst_damage_boost_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_extension" ] = "napalmburst_extension_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_incendiary" ] = "napalmburst_incendiary_cer";
    level.var_9726014da3c8d6c1[ #"napalmburst_petrol" ] = "napalmburst_petrol_sat";
    level.var_9726014da3c8d6c1[ #"napalmburst_pyro" ] = "napalmburst_pyro_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_big_game" ] = "shatterblast_big_game_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_boost" ] = "shatterblast_blast_boost_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_chain" ] = "shatterblast_blast_chain_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_off" ] = "shatterblast_blast_off_sat";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_repair" ] = "shatterblast_blast_repair_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_shield" ] = "shatterblast_blast_shield_sat";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_wave" ] = "shatterblast_blast_wave_cer";
    level.var_9726014da3c8d6c1[ #"shatterblast_blast_zone" ] = "shatterblast_blast_zone_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_big_game" ] = "shadowvortex_big_game_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_blackhole" ] = "shadowvortex_blackhole_sat";
    level.var_9726014da3c8d6c1[ #"shadowvortex_explosive_rain" ] = "shadowvortex_explosive_rain_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_haste" ] = "shadowvortex_haste_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_reload" ] = "shadowvortex_reload_sat";
    level.var_9726014da3c8d6c1[ #"shadowvortex_supermassive" ] = "shadowvortex_supermassive_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_targeted" ] = "shadowvortex_targeted_cer";
    level.var_9726014da3c8d6c1[ #"shadowvortex_topple_danger" ] = "shadowvortex_topple_danger_cer";
    level.var_9726014da3c8d6c1[ #"lightray_antibiotic" ] = "lightray_antibiotic_cer";
    level.var_9726014da3c8d6c1[ #"lightray_big_game" ] = "lightray_big_game_cer";
    level.var_9726014da3c8d6c1[ #"lightray_booster_shot" ] = "lightray_booster_shot_sat";
    level.var_9726014da3c8d6c1[ #"lightray_dual_action" ] = "lightray_dual_action_cer";
    level.var_9726014da3c8d6c1[ #"lightray_express_remedy" ] = "lightray_express_remedy_cer";
    level.var_9726014da3c8d6c1[ #"lightray_extra_strength" ] = "lightray_extra_strength_cer";
    level.var_9726014da3c8d6c1[ #"lightray_longer_life" ] = "lightray_longer_life_cer";
    level.var_9726014da3c8d6c1[ #"lightray_mitosis" ] = "lightray_mitosis_sat";
    level.var_9726014da3c8d6c1[ #"fw_big_bang" ] = "fw_big_bang";
    level.var_9726014da3c8d6c1[ #"fw_big_game" ] = "fw_big_game";
    level.var_9726014da3c8d6c1[ #"fw_condensed_yield" ] = "fw_condensed_yield";
    level.var_9726014da3c8d6c1[ #"fw_farfalle" ] = "fw_farfalle";
    level.var_9726014da3c8d6c1[ #"fw_fire_wheel" ] = "fw_fire_wheel";
    level.var_9726014da3c8d6c1[ #"fw_haste" ] = "fw_haste";
    level.var_9726014da3c8d6c1[ #"fw_starlight" ] = "fw_starlight";
    level.var_9726014da3c8d6c1[ #"fw_weeping_willow" ] = "fw_weeping_willow";
    level.var_9726014da3c8d6c1[ #"aether_shroud_aether_dash" ] = "aether_shroud_aether_dash_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_afterimage" ] = "aether_shroud_afterimage_sat";
    level.var_9726014da3c8d6c1[ #"aether_shroud_extension" ] = "aether_shroud_extension_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_group_shroud" ] = "aether_shroud_group_shroud_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_high_capacity" ] = "aether_shroud_high_capacity_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_otherworldly_reload" ] = "aether_shroud_otherworldly_reload_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_shadow_blade" ] = "aether_shroud_shadow_blade_cer";
    level.var_9726014da3c8d6c1[ #"aether_shroud_taken" ] = "aether_shroud_taken_sat";
    level.var_9726014da3c8d6c1[ #"energy_mine_carousel" ] = "energy_mine_carousel_cer";
    level.var_9726014da3c8d6c1[ #"energy_mine_frequency_boost" ] = "energy_mine_frequency_boost_cer";
    level.var_9726014da3c8d6c1[ #"energy_mine_high_capacity" ] = "energy_mine_high_capacity_cer";
    level.var_9726014da3c8d6c1[ #"energy_mine_recycle" ] = "energy_mine_recycle_sat";
    level.var_9726014da3c8d6c1[ #"energy_mine_scatter_mine" ] = "energy_mine_scatter_mine_cer";
    level.var_9726014da3c8d6c1[ #"energy_mine_siren" ] = "energy_mine_siren_cer";
    level.var_9726014da3c8d6c1[ #"energy_mine_smart_mine" ] = "energy_mine_smart_mine_sat";
    level.var_9726014da3c8d6c1[ #"energy_mine_spire" ] = "energy_mine_spire_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_extension" ] = "frenzied_guard_extension_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_fists_of_frenzy" ] = "frenzied_guard_fists_of_frenzy_sat";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_frenzy_fire" ] = "frenzied_guard_frenzy_fire_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_high_defense" ] = "frenzied_guard_high_defense_sat";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_phalanx" ] = "frenzied_guard_phalanx_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_rally" ] = "frenzied_guard_rally_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_repair_boost" ] = "frenzied_guard_repair_boost_cer";
    level.var_9726014da3c8d6c1[ #"frenzied_guard_retribution" ] = "frenzied_guard_retribution_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_cast" ] = "frost_blast_cast_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_extension" ] = "frost_blast_extension_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_flash_freeze" ] = "frost_blast_flash_freeze_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_frostbite" ] = "frost_blast_frostbite_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_high_capacity" ] = "frost_blast_high_capacity_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_slick" ] = "frost_blast_slick_cer";
    level.var_9726014da3c8d6c1[ #"frost_blast_slow_extend" ] = "frost_blast_slow_extend_sat";
    level.var_9726014da3c8d6c1[ #"frost_blast_stone_cold_stronghold" ] = "frost_blast_stone_cold_stronghold_sat";
    level.var_9726014da3c8d6c1[ #"healingaura_bountiful_harvest" ] = "healingaura_bountiful_harvest_sat";
    level.var_9726014da3c8d6c1[ #"healingaura_inner_strength" ] = "healingaura_inner_strength_cer";
    level.var_9726014da3c8d6c1[ #"healingaura_keep_perks" ] = "healingaura_keep_perks_cer";
    level.var_9726014da3c8d6c1[ #"healingaura_necromancer" ] = "healingaura_necromancer_sat";
    level.var_9726014da3c8d6c1[ #"healingaura_pillar_of_light" ] = "healingaura_pillar_of_light_cer";
    level.var_9726014da3c8d6c1[ #"healingaura_protection" ] = "healingaura_protection_cer";
    level.var_9726014da3c8d6c1[ #"healingaura_resilience" ] = "healingaura_resilience_cer";
    level.var_9726014da3c8d6c1[ #"healingaura_stoic_presence" ] = "healingaura_stoic_presence_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_lithium_charged" ] = "tesla_storm_lithium_charged_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_overclocked" ] = "tesla_storm_overclocked_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_power_grid" ] = "tesla_storm_power_grid_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_sat_major" ] = "tesla_storm_sat_major_sat";
    level.var_9726014da3c8d6c1[ #"tesla_storm_sat_minor" ] = "tesla_storm_sat_minor_sat";
    level.var_9726014da3c8d6c1[ #"tesla_storm_shockwave" ] = "tesla_storm_shockwave_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_static_discharge" ] = "tesla_storm_static_discharge_cer";
    level.var_9726014da3c8d6c1[ #"tesla_storm_transformer" ] = "tesla_storm_transformer_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_big_beam" ] = "dark_flare_big_beam_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_dark_pact" ] = "dark_flare_dark_pact_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_extension" ] = "dark_flare_extension_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_high_capacity" ] = "dark_flare_high_capacity_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_phantasmal" ] = "dark_flare_phantasmal_sat";
    level.var_9726014da3c8d6c1[ #"dark_flare_shadow_ball" ] = "dark_flare_shadow_ball_cer";
    level.var_9726014da3c8d6c1[ #"dark_flare_shadow_burn" ] = "dark_flare_shadow_burn_sat";
    level.var_9726014da3c8d6c1[ #"dark_flare_slowdown" ] = "dark_flare_slowdown_cer";
    level.var_9726014da3c8d6c1[ #"mary_paris_apex_hunter" ] = "mary_paris_apex_hunter_cer";
    level.var_9726014da3c8d6c1[ #"mary_paris_arcane_fury" ] = "mary_paris_arcane_fury_cer";
    level.var_9726014da3c8d6c1[ #"mary_paris_dance_party" ] = "mary_paris_dance_party_cer";
    level.var_9726014da3c8d6c1[ #"mary_paris_party_animal" ] = "mary_paris_party_animal_cer";
    level.var_9726014da3c8d6c1[ #"mary_paris_peek_health" ] = "mary_paris_peek_health_sat";
    level.var_9726014da3c8d6c1[ #"mary_paris_social_butterfly" ] = "mary_paris_social_butterfly_cer";
    level.var_9726014da3c8d6c1[ #"toxic_growth_ankle_shredder" ] = "toxic_growth_ankle_shredder_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_cordyception" ] = "toxic_growth_cordyception_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_crescent" ] = "toxic_growth_crescent_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_extra_charge" ] = "toxic_growth_extra_charge_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_green_thumb" ] = "toxic_growth_green_thumb_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_plant_food" ] = "toxic_growth_plant_food_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_pollination" ] = "toxic_growth_pollination_sat";
    level.var_9726014da3c8d6c1[ #"toxic_growth_zoochory" ] = "toxic_growth_zoochory_sat";
    level.var_3355343961c11683 = [];
    level.var_3355343961c11683[ "brainrot" ] = "zm_t10_ammomod_brainrot";
    level.var_3355343961c11683[ "cryofreeze" ] = "zm_t10_ammomod_cryofreeze";
    level.var_3355343961c11683[ "deadwire" ] = "zm_t10_ammomod_deadwire";
    level.var_3355343961c11683[ "napalmburst" ] = "zm_t10_ammomod_napalmburst";
    level.var_3355343961c11683[ "shatterblast" ] = "zm_t10_ammomod_shatterblast";
    level.var_3355343961c11683[ "shadowvortex" ] = "zm_t10_ammomod_shadowvortex";
    level.var_3355343961c11683[ "lightray" ] = "zm_t10_ammomod_lightray";
    level.var_3355343961c11683[ "fw_ammomod" ] = "fw_ammomod_sat";
    
    /#
        iprintlnbold( "<dev string:x2af>" + level.var_f6902967d180948a.size + "<dev string:x2c8>" );
        n_missing = 0;
        
        foreach ( str_perk, a_augments in level.var_98451248a70b7bb3 )
        {
            foreach ( augment_ref in a_augments )
            {
                if ( !isdefined( level.zombie_augments[ augment_ref ] ) )
                {
                    println( "<dev string:x2d8>" + str_perk + "<dev string:x2f1>" + augment_ref + "<dev string:x2f7>" );
                    n_missing++;
                }
            }
        }
        
        foreach ( var_4c506782108851c7, a_augments in level.var_6c3426d7b2e5e264 )
        {
            foreach ( augment_ref in a_augments )
            {
                if ( !isdefined( level.zombie_augments[ augment_ref ] ) )
                {
                    println( "<dev string:x30f>" + var_4c506782108851c7 + "<dev string:x2f1>" + augment_ref + "<dev string:x2f7>" );
                    n_missing++;
                }
            }
        }
        
        foreach ( str_super, a_augments in level.var_151effd1b9580cae )
        {
            foreach ( augment_ref in a_augments )
            {
                if ( !isdefined( level.zombie_augments[ augment_ref ] ) )
                {
                    println( "<dev string:x32c>" + str_super + "<dev string:x2f1>" + augment_ref + "<dev string:x2f7>" );
                    n_missing++;
                }
            }
        }
        
        if ( n_missing == 0 )
        {
            println( "<dev string:x34e>" );
            return;
        }
        
        println( "<dev string:x392>" + n_missing + "<dev string:x3a3>" );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x71676737, Offset: 0x707a
// Size: 0x12e
function private function_cf84442771fceb67()
{
    level.var_e8b652abd3805da2 = [];
    level.var_e8b652abd3805da2[ 0 ] = [ "loadout_refill", "field_upgrade", "rarity_upgrade", "wonder_weapon", "armor_upgrade", "golden_armor", "pap1", "pap2", "pap3", "pap4" ];
    level.var_e8b652abd3805da2[ 1 ] = [ "perk", "ammo_mod", "weapon" ];
    level.var_e8b652abd3805da2[ 2 ] = [ "perk", "ammo_mod", "weapon" ];
    level.var_e8b652abd3805da2[ 3 ] = [ "augment" ];
    level.var_e8b652abd3805da2[ 4 ] = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        level.var_e8b652abd3805da2[ 4 ] = arraycombine( level.var_e8b652abd3805da2[ 4 ], level.var_e8b652abd3805da2[ i ] );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x700bd050, Offset: 0x71b0
// Size: 0x61b
function private function_aa7484b026c94c2b()
{
    level.var_feed53d8447f7479 = [];
    level.var_feed53d8447f7479[ "ar" ] = [];
    level.var_feed53d8447f7479[ "ar" ][ 0 ] = %"hash_5f63ffb6b66abcdf";
    level.var_feed53d8447f7479[ "ar" ][ 1 ] = %"hash_641b7c1636894e5";
    level.var_feed53d8447f7479[ "ar" ][ 2 ] = %"hash_3d65c6b6eb4d0eb2";
    level.var_feed53d8447f7479[ "ar" ][ 3 ] = %"hash_1f0fb55b1dc72278";
    level.var_feed53d8447f7479[ "ar" ][ 4 ] = %"hash_2a0f81b1a28ad54c";
    level.var_feed53d8447f7479[ "ar" ][ 5 ] = level.var_feed53d8447f7479[ "ar" ][ 4 ];
    level.var_feed53d8447f7479[ "smg" ] = [];
    level.var_feed53d8447f7479[ "smg" ][ 0 ] = %"hash_1d60db8e7ae0aada";
    level.var_feed53d8447f7479[ "smg" ][ 1 ] = %"hash_288480d8679ceb6e";
    level.var_feed53d8447f7479[ "smg" ][ 2 ] = %"hash_3f6ce48e460a44d3";
    level.var_feed53d8447f7479[ "smg" ][ 3 ] = %"hash_59697ff372b40ddd";
    level.var_feed53d8447f7479[ "smg" ][ 4 ] = %"hash_2d0636b1572bef1d";
    level.var_feed53d8447f7479[ "smg" ][ 5 ] = level.var_feed53d8447f7479[ "smg" ][ 4 ];
    level.var_feed53d8447f7479[ "lmg" ] = [];
    level.var_feed53d8447f7479[ "lmg" ][ 0 ] = %"hash_fbd71b8c64a41eb";
    level.var_feed53d8447f7479[ "lmg" ][ 1 ] = %"hash_45541b9ad543c9f1";
    level.var_feed53d8447f7479[ "lmg" ][ 2 ] = %"hash_1fa960b886f487fe";
    level.var_feed53d8447f7479[ "lmg" ][ 3 ] = %"hash_756d3595b507754";
    level.var_feed53d8447f7479[ "lmg" ][ 4 ] = %"hash_3d8c31d0132cb080";
    level.var_feed53d8447f7479[ "lmg" ][ 5 ] = level.var_feed53d8447f7479[ "lmg" ][ 4 ];
    level.var_feed53d8447f7479[ "sh" ] = [];
    level.var_feed53d8447f7479[ "sh" ][ 0 ] = %"hash_3f9a2a7a3a572baf";
    level.var_feed53d8447f7479[ "sh" ][ 1 ] = %"hash_5a2c90f2d92a1cd5";
    level.var_feed53d8447f7479[ "sh" ][ 2 ] = %"hash_1d9cf17a6f3b3082";
    level.var_feed53d8447f7479[ "sh" ][ 3 ] = %"hash_51e93a08c13648a8";
    level.var_feed53d8447f7479[ "sh" ][ 4 ] = %"hash_2cdc0bcb9ad4e1c";
    level.var_feed53d8447f7479[ "sh" ][ 5 ] = level.var_feed53d8447f7479[ "sh" ][ 4 ];
    level.var_feed53d8447f7479[ "sn" ] = [];
    level.var_feed53d8447f7479[ "sn" ][ 0 ] = %"hash_32aa7fc2723e1ee5";
    level.var_feed53d8447f7479[ "sn" ][ 1 ] = %"hash_764b58cd8e758bd3";
    level.var_feed53d8447f7479[ "sn" ][ 2 ] = %"hash_4c2d16c2808eff3c";
    level.var_feed53d8447f7479[ "sn" ][ 3 ] = %"hash_4abc90ff8e83b80a";
    level.var_feed53d8447f7479[ "sn" ][ 4 ] = %"hash_2626d273ff76fa0a";
    level.var_feed53d8447f7479[ "sn" ][ 5 ] = level.var_feed53d8447f7479[ "sn" ][ 4 ];
    level.var_feed53d8447f7479[ "dm" ] = [];
    level.var_feed53d8447f7479[ "dm" ][ 0 ] = %"hash_edf3f989d1d6583";
    level.var_feed53d8447f7479[ "dm" ][ 1 ] = %"hash_38b5f4a760caea9";
    level.var_feed53d8447f7479[ "dm" ][ 2 ] = %"hash_2b829e98ae158fe6";
    level.var_feed53d8447f7479[ "dm" ][ 3 ] = %"hash_15a51a989dd85f9c";
    level.var_feed53d8447f7479[ "dm" ][ 4 ] = %"hash_7b951e608792ec18";
    level.var_feed53d8447f7479[ "dm" ][ 5 ] = level.var_feed53d8447f7479[ "dm" ][ 4 ];
    level.var_feed53d8447f7479[ "pi" ] = [];
    level.var_feed53d8447f7479[ "pi" ][ 0 ] = %"hash_321407fe80c9d383";
    level.var_feed53d8447f7479[ "pi" ][ 1 ] = %"hash_2a9e46c540b98a9";
    level.var_feed53d8447f7479[ "pi" ][ 2 ] = %"hash_4eb766fe91c1fde6";
    level.var_feed53d8447f7479[ "pi" ][ 3 ] = %"hash_156b5324d5fffd9c";
    level.var_feed53d8447f7479[ "pi" ][ 4 ] = %"hash_7b5b56ecbfba8a18";
    level.var_feed53d8447f7479[ "pi" ][ 5 ] = level.var_feed53d8447f7479[ "pi" ][ 4 ];
    level.var_feed53d8447f7479[ "me" ] = [];
    level.var_feed53d8447f7479[ "me" ][ 0 ] = %"hash_107c6c10b5c615f0";
    level.var_feed53d8447f7479[ "me" ][ 1 ] = %"hash_f2bd0bd4573914";
    level.var_feed53d8447f7479[ "me" ][ 2 ] = %"hash_2f14ad107e00a8b5";
    level.var_feed53d8447f7479[ "me" ][ 3 ] = %"hash_29e392366aeeefe7";
    level.var_feed53d8447f7479[ "me" ][ 4 ] = %"hash_19b0e25e0d91d003";
    level.var_feed53d8447f7479[ "me" ][ 5 ] = level.var_feed53d8447f7479[ "me" ][ 4 ];
    function_54e29d0ee4382f42();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x234d0c17, Offset: 0x77d3
// Size: 0x544
function private function_54e29d0ee4382f42()
{
    level.var_1488e4d2a4ace466 = [];
    level.var_1488e4d2a4ace466[ "ar_" + 0 ] = &"hash_70edadd305e5f27e";
    level.var_1488e4d2a4ace466[ "ar_" + 1 ] = &"hash_79ac4c02b131b664";
    level.var_1488e4d2a4ace466[ "ar_" + 2 ] = &"hash_b6318067edfdfa5";
    level.var_1488e4d2a4ace466[ "ar_" + 3 ] = &"hash_7dd3ee51284617b7";
    level.var_1488e4d2a4ace466[ "ar_" + 4 ] = &"hash_18e34c7053ab55b3";
    level.var_1488e4d2a4ace466[ "ar_" + 5 ] = &"hash_1a34840d436c5cb4";
    level.var_1488e4d2a4ace466[ "smg_" + 0 ] = &"hash_5252d369f1fd06ba";
    level.var_1488e4d2a4ace466[ "smg_" + 1 ] = &"hash_21d6b892ad413aa8";
    level.var_1488e4d2a4ace466[ "smg_" + 2 ] = &"hash_658d7c179660d2e9";
    level.var_1488e4d2a4ace466[ "smg_" + 3 ] = &"hash_39deb1892eb111ab";
    level.var_1488e4d2a4ace466[ "smg_" + 4 ] = &"hash_20bb9ebb8f6daeff";
    level.var_1488e4d2a4ace466[ "smg_" + 5 ] = &"hash_7ac81342db220c58";
    level.var_1488e4d2a4ace466[ "lmg_" + 0 ] = &"hash_617f2b7f5b28524f";
    level.var_1488e4d2a4ace466[ "lmg_" + 1 ] = &"hash_1655ffb041ea89a5";
    level.var_1488e4d2a4ace466[ "lmg_" + 2 ] = &"hash_51ce326de7b31972";
    level.var_1488e4d2a4ace466[ "lmg_" + 3 ] = &"hash_1ee427ede3f9cf38";
    level.var_1488e4d2a4ace466[ "lmg_" + 4 ] = &"hash_27f5fc9aa15d3c0c";
    level.var_1488e4d2a4ace466[ "lmg_" + 5 ] = &"hash_4cb021e7401bcdd1";
    level.var_1488e4d2a4ace466[ "sh_" + 0 ] = &"hash_38ce2c45c592600a";
    level.var_1488e4d2a4ace466[ "sh_" + 1 ] = &"hash_76b731870ed18918";
    level.var_1488e4d2a4ace466[ "sh_" + 2 ] = &"hash_6073c4a4c8ccb0b9";
    level.var_1488e4d2a4ace466[ "sh_" + 3 ] = &"hash_39d05f290bfb291b";
    level.var_1488e4d2a4ace466[ "sh_" + 4 ] = &"hash_14ccd602405bb2cf";
    level.var_1488e4d2a4ace466[ "sh_" + 5 ] = &"hash_6adcaf6a98d1f308";
    level.var_1488e4d2a4ace466[ "sn_" + 0 ] = &"hash_364f7c29e4431804";
    level.var_1488e4d2a4ace466[ "sn_" + 1 ] = &"hash_5c8e1ced5bbba90a";
    level.var_1488e4d2a4ace466[ "sn_" + 2 ] = &"hash_649e59a737f896f";
    level.var_1488e4d2a4ace466[ "sn_" + 3 ] = &"hash_517ac6d7a11b47d9";
    level.var_1488e4d2a4ace466[ "sn_" + 4 ] = &"hash_40e6317821344e71";
    level.var_1488e4d2a4ace466[ "sn_" + 5 ] = &"hash_411479a8fbae5d1a";
    level.var_1488e4d2a4ace466[ "dm_" + 0 ] = &"hash_18c9753574edcbea";
    level.var_1488e4d2a4ace466[ "dm_" + 1 ] = &"hash_2d377a71d62e49f8";
    level.var_1488e4d2a4ace466[ "dm_" + 2 ] = &"hash_4a75fa9605de0919";
    level.var_1488e4d2a4ace466[ "dm_" + 3 ] = &"hash_29d26e70016f077b";
    level.var_1488e4d2a4ace466[ "dm_" + 4 ] = &"hash_834e54938b2ba2f";
    level.var_1488e4d2a4ace466[ "dm_" + 5 ] = &"hash_16a5959294d8fce8";
    level.var_1488e4d2a4ace466[ "pi_" + 0 ] = &"hash_5697222e6c97f592";
    level.var_1488e4d2a4ace466[ "pi_" + 1 ] = &"hash_2084c5dfdaa0d190";
    level.var_1488e4d2a4ace466[ "pi_" + 2 ] = &"hash_785d167053a8a121";
    level.var_1488e4d2a4ace466[ "pi_" + 3 ] = &"hash_7af5ca0abf1d6ec3";
    level.var_1488e4d2a4ace466[ "pi_" + 4 ] = &"hash_341c54505a5c727";
    level.var_1488e4d2a4ace466[ "pi_" + 5 ] = &"hash_67b650106ca6e050";
    level.var_1488e4d2a4ace466[ "me_" + 0 ] = &"hash_94611183501b817";
    level.var_1488e4d2a4ace466[ "me_" + 1 ] = &"hash_5c934b1ac764187d";
    level.var_1488e4d2a4ace466[ "me_" + 2 ] = &"hash_706885290579969a";
    level.var_1488e4d2a4ace466[ "me_" + 3 ] = &"hash_4796829781a4c9a0";
    level.var_1488e4d2a4ace466[ "me_" + 4 ] = &"hash_3f50dcacc08df024";
    level.var_1488e4d2a4ace466[ "me_" + 5 ] = &"hash_5153df0514368479";
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x297752b5, Offset: 0x7d1f
// Size: 0x476
function private function_24ecb66295f8f2e5()
{
    level.var_a94675d7f0f10828 = [];
    level.var_a94675d7f0f10828[ "specialty_juggernog" ] = &"zombie_perks/juggernog";
    level.var_a94675d7f0f10828[ "specialty_quickrevive" ] = &"zombie_perks/quick_revive";
    level.var_a94675d7f0f10828[ "specialty_speedcola" ] = &"zombie_perks/speedcola";
    level.var_a94675d7f0f10828[ "specialty_staminup" ] = &"zombie_perks/staminup";
    level.var_a94675d7f0f10828[ "specialty_deadshot" ] = &"zombie_perks/deadshot";
    level.var_a94675d7f0f10828[ "specialty_death_perception" ] = &"zombie_perks/deathperception";
    level.var_a94675d7f0f10828[ "specialty_elemental_pop" ] = &"zombie_perks/elemental_pop";
    level.var_a94675d7f0f10828[ "specialty_phd_flopper" ] = &"zombie_perks/phd_flopper";
    level.var_a94675d7f0f10828[ "specialty_vulture_aid" ] = &"ZOMBIE_PERKS/VULTURE_AID";
    level.var_a94675d7f0f10828[ "specialty_m_mod" ] = &"ZOMBIE_PERKS/MMOD";
    level.var_a94675d7f0f10828[ "specialty_d_mod" ] = &"ZOMBIE_PERKS/D_MOD";
    level.var_a94675d7f0f10828[ "specialty_w_mod" ] = &"zombie_perks/w_mod";
    level.var_a94675d7f0f10828[ "specialty_y_mod" ] = &"hash_681d273f7de6b535";
    level.var_4ad95315c22d9719 = [];
    level.var_4ad95315c22d9719[ "specialty_juggernog" ] = &"zombie_perks/juggernog_desc";
    level.var_4ad95315c22d9719[ "specialty_quickrevive" ] = &"zombie_perks/quick_revive_desc";
    level.var_4ad95315c22d9719[ "specialty_speedcola" ] = &"zombie_perks/speedcola_desc";
    level.var_4ad95315c22d9719[ "specialty_staminup" ] = &"zombie_perks/staminup_desc";
    level.var_4ad95315c22d9719[ "specialty_deadshot" ] = &"zombie_perks/deadshot_desc";
    level.var_4ad95315c22d9719[ "specialty_death_perception" ] = &"zombie_perks/deathperception_desc";
    level.var_4ad95315c22d9719[ "specialty_elemental_pop" ] = &"zombie_perks/elemental_pop_desc";
    level.var_4ad95315c22d9719[ "specialty_phd_flopper" ] = &"zombie_perks/phd_flopper_desc";
    level.var_4ad95315c22d9719[ "specialty_vulture_aid" ] = &"ZOMBIE_PERKS/VULTURE_AID_DESC";
    level.var_4ad95315c22d9719[ "specialty_m_mod" ] = &"ZOMBIE_PERKS/MMOD_DESC";
    level.var_4ad95315c22d9719[ "specialty_d_mod" ] = &"ZOMBIE_PERKS/D_MOD_DESC";
    level.var_4ad95315c22d9719[ "specialty_w_mod" ] = &"zombie_perks/w_mod_desc";
    level.var_4ad95315c22d9719[ "specialty_y_mod" ] = &"hash_435860d8458e801f";
    level.var_3f3e6e7f86bf475a = [];
    level.var_3f3e6e7f86bf475a[ "brainrot" ] = &"hash_166dfc62901bd9e";
    level.var_3f3e6e7f86bf475a[ "cryofreeze" ] = &"hash_7fec4638e4567821";
    level.var_3f3e6e7f86bf475a[ "deadwire" ] = &"hash_dfe067428f980ec";
    level.var_3f3e6e7f86bf475a[ "fw_ammomod" ] = &"hash_6765795524b92dc4";
    level.var_3f3e6e7f86bf475a[ "napalmburst" ] = &"hash_1c206371a02a2974";
    level.var_3f3e6e7f86bf475a[ "lightray" ] = &"hash_18560e3893fdceeb";
    level.var_3f3e6e7f86bf475a[ "shadowvortex" ] = &"hash_cb69d6d434761e7";
    level.var_3f3e6e7f86bf475a[ "shatterblast" ] = &"hash_3798d7ac001f27b6";
    level.var_cb67e4cb2ce9c0f8 = [];
    level.var_cb67e4cb2ce9c0f8[ "super_aether_shroud" ] = &"hash_55b30dd0958f2b1e";
    level.var_cb67e4cb2ce9c0f8[ "super_energy_mine" ] = &"hash_3c473ed2721616ff";
    level.var_cb67e4cb2ce9c0f8[ "super_frenzied_guard" ] = &"hash_410b2530cfaf928e";
    level.var_cb67e4cb2ce9c0f8[ "super_frost_blast" ] = &"hash_63664ebf8175e5e";
    level.var_cb67e4cb2ce9c0f8[ "super_healing_aura" ] = &"hash_33dab32d9eb269bf";
    level.var_cb67e4cb2ce9c0f8[ "super_tesla_storm" ] = &"hash_2398afc32e14730c";
    level.var_cb67e4cb2ce9c0f8[ "super_dark_flare" ] = &"hash_7ed700cf4371f4dc";
    level.var_cb67e4cb2ce9c0f8[ "super_mary_paris" ] = &"hash_291ffc8fe066af34";
    level.var_cb67e4cb2ce9c0f8[ "super_toxic_growth" ] = &"hash_588c28d88c912e90";
    level.var_cb67e4cb2ce9c0f8[ "super_wiley_fox" ] = &"hash_11750c5de85bf669";
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xad568810, Offset: 0x819d
// Size: 0x2ab
function private function_2c9ca6bc8da0b125()
{
    level.var_9bcc792067acc484 = [];
    level.var_9bcc792067acc484[ "specialty_juggernog" ] = "ui_icon_perks_zm_juggernaut";
    level.var_9bcc792067acc484[ "specialty_quickrevive" ] = "ui_icon_perks_zm_quickrevive";
    level.var_9bcc792067acc484[ "specialty_speedcola" ] = "ui_icon_perks_zm_speedloader";
    level.var_9bcc792067acc484[ "specialty_staminup" ] = "ui_icon_perks_zm_staminup";
    level.var_9bcc792067acc484[ "specialty_deadshot" ] = "ui_icon_perks_zm_deadshot";
    level.var_9bcc792067acc484[ "specialty_death_perception" ] = "ui_icon_perks_zm_deathperception";
    level.var_9bcc792067acc484[ "specialty_elemental_pop" ] = "ui_icon_perks_zm_elemental_pop";
    level.var_9bcc792067acc484[ "specialty_phd_flopper" ] = "ui_icon_perks_zm_phdslider";
    level.var_9bcc792067acc484[ "specialty_vulture_aid" ] = "ui_icon_perks_vulture_aid";
    level.var_9bcc792067acc484[ "specialty_m_mod" ] = "ui_icon_perks_melee_macchiato";
    level.var_9bcc792067acc484[ "specialty_d_mod" ] = "ui_icon_perks_double_tap";
    level.var_9bcc792067acc484[ "specialty_w_mod" ] = "ui_icon_perks_wisp_tea";
    level.var_9bcc792067acc484[ "specialty_y_mod" ] = "ui_icon_perks_widows_wine";
    level.var_9797eca6334f344a = [];
    level.var_9797eca6334f344a[ "brainrot" ] = "ui_icons_elementaldamage_toxic";
    level.var_9797eca6334f344a[ "cryofreeze" ] = "ui_icons_elementaldamage_cold";
    level.var_9797eca6334f344a[ "deadwire" ] = "ui_icons_elementaldamage_electrical";
    level.var_9797eca6334f344a[ "fw_ammomod" ] = "ui_icon_zombie_purchasemenu_ammomod_fireworks";
    level.var_9797eca6334f344a[ "napalmburst" ] = "ui_icons_elementaldamage_fire";
    level.var_9797eca6334f344a[ "lightray" ] = "ui_icons_elementaldamage_light";
    level.var_9797eca6334f344a[ "shadowvortex" ] = "ui_icons_elementaldamage_dark";
    level.var_9797eca6334f344a[ "shatterblast" ] = "ui_icons_elementaldamage_explosive";
    level.var_d1f37df33bd2604f = [];
    level.var_d1f37df33bd2604f[ "super_aether_shroud" ] = "ui_icon_fieldupgrade_zm_aether_shroud";
    level.var_d1f37df33bd2604f[ "super_energy_mine" ] = "ui_icon_fieldupgrade_zm_energy_mine";
    level.var_d1f37df33bd2604f[ "super_frenzied_guard" ] = "ui_icon_fieldupgrade_zm_frenzied_guard";
    level.var_d1f37df33bd2604f[ "super_frost_blast" ] = "ui_icon_fieldupgrade_zm_frost_blast";
    level.var_d1f37df33bd2604f[ "super_healing_aura" ] = "ui_icon_fieldupgrade_zm_healing_aura";
    level.var_d1f37df33bd2604f[ "super_tesla_storm" ] = "ui_icon_fieldupgrade_zm_lightning_links";
    level.var_d1f37df33bd2604f[ "super_dark_flare" ] = "ui_icon_fieldupgrade_zm_dark_flare";
    level.var_d1f37df33bd2604f[ "super_mary_paris" ] = "ui_icon_fieldupgrade_zm_bunny";
    level.var_d1f37df33bd2604f[ "super_toxic_growth" ] = "ui_icon_fieldupgrade_zm_toxic_growth";
    level.var_d1f37df33bd2604f[ "super_wiley_fox" ] = "sat_ui_icon_zm_fieldupgrade_wildfire";
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x99187fed, Offset: 0x8450
// Size: 0x48e
function private init_echo_portal_data()
{
    level.var_d8e750fbdcbb10bd = [];
    level.var_d8e750fbdcbb10bd[ 0 ] = { #challenge_key:undefined, #var_d55fb892d0366341:0, #pool_index:0 };
    level.var_d8e750fbdcbb10bd[ 1 ] = { #challenge_key:undefined, #var_d55fb892d0366341:0, #pool_index:1 };
    level.var_d8e750fbdcbb10bd[ 2 ] = { #challenge_key:undefined, #var_d55fb892d0366341:0, #pool_index:2 };
    level.var_d8e750fbdcbb10bd[ 3 ] = { #challenge_key:"extra_portal", #var_d55fb892d0366341:1, #pool_index:3 };
    level.var_d8e750fbdcbb10bd[ 4 ] = { #challenge_key:"extra_portal_2", #var_d55fb892d0366341:1, #pool_index:4 };
    level.var_7b14f8737692b012 = [];
    a_set_names = level.var_2add2332a4635bbb.var_bcf87c357a7634ec;
    var_a2e5bbda4afb747 = level.var_2add2332a4635bbb.var_faa951df3f188328 ?? [];
    a_set_names = arraycombine( a_set_names, var_a2e5bbda4afb747 );
    
    foreach ( str_set_name in a_set_names )
    {
        a_structs = utility::getstructarray( str_set_name, "script_noteworthy" );
        var_54e612115e4be87a = [];
        
        foreach ( var_16af6624858ffa21 in a_structs )
        {
            if ( !isdefined( var_16af6624858ffa21.script_index ) )
            {
                /#
                    iprintlnbold( "<dev string:x3cf>" + str_set_name + "<dev string:x3ed>" + var_16af6624858ffa21.origin + "<dev string:x3f3>" );
                #/
                
                continue;
            }
            
            n_index = int( var_16af6624858ffa21.script_index );
            
            if ( !isdefined( level.var_d8e750fbdcbb10bd[ n_index ] ) )
            {
                /#
                    iprintlnbold( "<dev string:x3cf>" + str_set_name + "<dev string:x3ed>" + var_16af6624858ffa21.origin + "<dev string:x413>" + n_index + "<dev string:x42e>" );
                #/
                
                continue;
            }
            
            var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( var_16af6624858ffa21.origin );
            var_4cdafb4532dd9de4 = isdefined( var_8c4fe62d01999d1e ) ? var_8c4fe62d01999d1e.script_zone_name : undefined;
            
            if ( !isdefined( var_4cdafb4532dd9de4 ) )
            {
                /#
                    iprintlnbold( "<dev string:x3cf>" + str_set_name + "<dev string:x3ed>" + var_16af6624858ffa21.origin + "<dev string:x43a>" );
                #/
                
                continue;
            }
            
            var_1344b6c6ccd6e526 = level.var_d8e750fbdcbb10bd[ n_index ];
            var_54e612115e4be87a[ n_index ] = { #challenge_key:var_1344b6c6ccd6e526.challenge_key, #var_d55fb892d0366341:var_1344b6c6ccd6e526.var_d55fb892d0366341, #pool_index:var_1344b6c6ccd6e526.pool_index, #noteworthy:n_index, #var_4cdafb4532dd9de4:var_4cdafb4532dd9de4, #angles:var_16af6624858ffa21.angles ?? ( 0, 0, 0 ), #origin:var_16af6624858ffa21.origin };
        }
        
        assert( var_54e612115e4be87a.size >= 5, "<dev string:x44f>" + str_set_name + "<dev string:x468>" + var_54e612115e4be87a.size + "<dev string:x46f>" + 5 );
        var_54e612115e4be87a[ 0 ].str_set_name = str_set_name;
        level.var_7b14f8737692b012[ level.var_7b14f8737692b012.size ] = var_54e612115e4be87a;
        
        if ( str_set_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
        {
            level.var_4c9111b731176f = var_54e612115e4be87a;
        }
    }
    
    assert( level.var_7b14f8737692b012.size > 0, "<dev string:x47f>" );
    
    /#
        iprintlnbold( "<dev string:x4e1>" + level.var_7b14f8737692b012.size + "<dev string:x4f5>" );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x96158bab, Offset: 0x88e6
// Size: 0x46f
function private function_59a26b1bd7f03317()
{
    var_226ce6d57a347343 = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        var_8c4fe62d01999d1e = player zone_manager::get_current_zone();
        
        if ( isdefined( var_8c4fe62d01999d1e ) )
        {
            var_226ce6d57a347343 = arraycombineunique( var_226ce6d57a347343, [ var_8c4fe62d01999d1e.script_zone_name ] );
        }
    }
    
    a_valid_sets = [];
    
    foreach ( var_54e612115e4be87a in level.var_7b14f8737692b012 )
    {
        if ( level.var_cf5927ac4c367a67 && var_54e612115e4be87a[ 0 ].str_set_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
        {
            continue;
        }
        
        var_6469c1e4d3ac4060 = var_54e612115e4be87a[ 0 ];
        
        if ( !isdefined( var_6469c1e4d3ac4060 ) || !zone_manager::is_zone_enabled( var_6469c1e4d3ac4060.var_4cdafb4532dd9de4 ) )
        {
            continue;
        }
        
        str_set_name = var_6469c1e4d3ac4060.str_set_name;
        var_a96ce8e20d104671 = level.var_2add2332a4635bbb.var_8eac6e744e8c5bf1[ str_set_name ];
        var_cb4ad280dae1e101 = 0;
        
        if ( isdefined( var_a96ce8e20d104671 ) )
        {
            foreach ( var_2762308bdbfb9e78 in var_a96ce8e20d104671 )
            {
                if ( arraycontains( var_226ce6d57a347343, var_2762308bdbfb9e78 ) )
                {
                    var_cb4ad280dae1e101 = 1;
                    break;
                }
            }
        }
        
        if ( var_cb4ad280dae1e101 )
        {
            a_valid_sets[ a_valid_sets.size ] = var_54e612115e4be87a;
        }
    }
    
    if ( !a_valid_sets.size )
    {
        if ( level.var_cf5927ac4c367a67 )
        {
            a_valid_sets = [];
            
            foreach ( var_54e612115e4be87a in level.var_7b14f8737692b012 )
            {
                if ( var_54e612115e4be87a[ 0 ].str_set_name != level.var_2add2332a4635bbb.var_4aa676077979d1dd )
                {
                    a_valid_sets[ a_valid_sets.size ] = var_54e612115e4be87a;
                }
            }
        }
        else
        {
            a_valid_sets = level.var_7b14f8737692b012;
        }
    }
    
    var_4947d42b2ba36493 = a_valid_sets[ 0 ];
    n_best_dist = 999999;
    
    foreach ( var_54e612115e4be87a in a_valid_sets )
    {
        var_6469c1e4d3ac4060 = var_54e612115e4be87a[ 0 ];
        
        if ( !isdefined( var_6469c1e4d3ac4060 ) )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            var_b6081b1b6ba5e8b5 = distance( var_6469c1e4d3ac4060.origin, player.origin );
            
            if ( var_b6081b1b6ba5e8b5 < n_best_dist )
            {
                n_best_dist = var_b6081b1b6ba5e8b5;
                var_4947d42b2ba36493 = var_54e612115e4be87a;
            }
        }
    }
    
    level.var_ad0c50e3383a3d97 = var_4947d42b2ba36493;
    
    /#
        iprintlnbold( "<dev string:x504>" + var_4947d42b2ba36493[ 0 ].origin + "<dev string:x52e>" );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x43923109, Offset: 0x8d5d
// Size: 0x150
function private function_a64ebab41f0b1956()
{
    var_62638af37653ded7 = level.var_2add2332a4635bbb.var_bcf87c357a7634ec;
    a_eligible = [];
    
    foreach ( str_name in var_62638af37653ded7 )
    {
        if ( str_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
        {
            if ( level.var_cf5927ac4c367a67 )
            {
                continue;
            }
        }
        
        if ( str_name == level.var_2add2332a4635bbb.var_8074703df595efae && level.var_b71496deb2f6852e )
        {
            continue;
        }
        
        a_eligible[ a_eligible.size ] = str_name;
    }
    
    level.var_b71496deb2f6852e = 0;
    a_eligible = arrayrandomize( a_eligible );
    
    if ( a_eligible.size > 1 && a_eligible[ 0 ] == level.var_8f9e5e6c5e6959a3 )
    {
        n_swap = randomintrange( 1, a_eligible.size );
        str_temp = a_eligible[ 0 ];
        a_eligible[ 0 ] = a_eligible[ n_swap ];
        a_eligible[ n_swap ] = str_temp;
    }
    
    level.var_426524a88a587a04 = a_eligible;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xe115959, Offset: 0x8eb5
// Size: 0x1ef
function private function_d93966b836170afd()
{
    var_926826280888e3a7 = ( level.round_number ?? 0 ) + 1;
    
    if ( is_boss_round( var_926826280888e3a7 ) && isdefined( level.var_4c9111b731176f ) )
    {
        s_dest = level.var_4c9111b731176f[ 0 ];
        return { #str_set_name:level.var_2add2332a4635bbb.var_4aa676077979d1dd, #angles:s_dest.angles, #origin:s_dest.origin };
    }
    
    if ( !level.var_426524a88a587a04.size )
    {
        function_a64ebab41f0b1956();
    }
    
    str_next = level.var_426524a88a587a04[ 0 ];
    level.var_426524a88a587a04 = arrayremove( level.var_426524a88a587a04, str_next );
    level.var_8f9e5e6c5e6959a3 = str_next;
    
    foreach ( var_54e612115e4be87a in level.var_7b14f8737692b012 )
    {
        if ( var_54e612115e4be87a[ 0 ].str_set_name == str_next )
        {
            s_dest = var_54e612115e4be87a[ 0 ];
            return { #str_set_name:s_dest.str_set_name, #angles:s_dest.angles, #origin:s_dest.origin };
        }
    }
    
    s_dest = level.var_7b14f8737692b012[ 0 ][ 0 ];
    return { #str_set_name:s_dest.str_set_name, #angles:s_dest.angles, #origin:s_dest.origin };
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xb7698e2a, Offset: 0x90ad
// Size: 0x1f
function private function_9707356b9da2a1d7( params )
{
    waitframe();
    
    if ( isplayer( self ) )
    {
        self.var_74acee1c62f38269 = undefined;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xdd9dba64, Offset: 0x90d4
// Size: 0x50
function private function_50fe2b88556cf38a( params )
{
    if ( !self.var_74acee1c62f38269 )
    {
        waitframe();
        
        if ( isplayer( self ) )
        {
            self.var_74acee1c62f38269 = 1;
            armor::givestartingarmor();
            namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( 1 );
        }
        
        return;
    }
    
    waitframe();
    
    if ( isplayer( self ) )
    {
        armor::givestartingarmor();
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xe69bd6d7, Offset: 0x912c
// Size: 0x179
function private function_92bcaa1f58045f02( params )
{
    self endon( #"death_or_disconnect" );
    thread function_924f107baf9162a8();
    thread function_dbb1be22310e4a82();
    
    if ( self.var_cff5c6b8e3a3aec4 && self.var_1b3b90bb5ee87f51 )
    {
        self.var_cff5c6b8e3a3aec4 = undefined;
        
        if ( isdefined( self.a_saved_weapons ) )
        {
            if ( !self.var_553655096f6ba26 )
            {
                self.a_saved_weapons[ "super" ][ "ref" ] = undefined;
                perkpackage::perkpackage_giveimmediate( "none" );
                perkpackage::perkpackage_reset();
            }
            
            zm_utility::function_663d59490abc834f();
        }
        else
        {
            function_b546ad1adb3d7895();
        }
        
        thread function_182f9140a9e02219();
        level.var_7ec0fa784f8d9bef--;
        
        if ( level.var_7ec0fa784f8d9bef <= 0 )
        {
            level notify( #"echo_dead_respawns_done" );
        }
        
        return;
    }
    
    self.a_saved_weapons = undefined;
    self.var_553655096f6ba26 = 0;
    thread function_63338426a835291();
    self.var_4d71b356f97bb810 = 0;
    
    if ( !callback::exists( #"reload", &function_22f60716c327f499 ) )
    {
        callback::add( #"reload", &function_22f60716c327f499 );
    }
    
    if ( !callback::exists( "phantom_augment_reload_completed", &function_22f60716c327f499 ) )
    {
        callback::add( "phantom_augment_reload_completed", &function_22f60716c327f499 );
    }
    
    level utility::flag_wait( "begin_round_logic" );
    function_b546ad1adb3d7895();
    
    /#
        thread function_d113bbec975d1d13();
    #/
    
    /#
        thread function_20a81b7dbd347e3f();
    #/
    
    zombie_augments::function_aac93cc049fd5090();
    self.var_1b3b90bb5ee87f51 = 1;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb538e1f4, Offset: 0x92ad
// Size: 0x25
function private function_488b2d4006c47afd()
{
    if ( function_ca8ffa3d9e0d16c9( "start_pistol_rare" ) )
    {
        return 2;
    }
    
    if ( function_ca8ffa3d9e0d16c9( "start_pistol_uncommon" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xd9259d57, Offset: 0x92db
// Size: 0xd5
function private function_ccfdc1c153aef79()
{
    if ( !self.var_282313ba8fafa8c6 )
    {
        return;
    }
    
    if ( !self.var_1b3b90bb5ee87f51 )
    {
        return;
    }
    
    var_efe133da0fd52cb4 = function_488b2d4006c47afd();
    
    if ( var_efe133da0fd52cb4 <= 0 )
    {
        return;
    }
    
    weapon = get_player_primary_weapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        return;
    }
    
    if ( weapon::isfistweapon( weapon ) || weapon.ismeleeweapon || weapon::function_6b74ecd475e99b4( weapon ) || weapon::iswonderweapon( weapon ) || weapon::iskillstreakweapon( weapon ) )
    {
        return;
    }
    
    n_current_rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
    
    if ( n_current_rarity >= var_efe133da0fd52cb4 )
    {
        return;
    }
    
    item_weapon::function_40e1cbd0e1f47d1a( weapon, var_efe133da0fd52cb4, 1 );
    
    /#
        iprintlnbold( "<dev string:x530>" + var_efe133da0fd52cb4 );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x1b76f91, Offset: 0x93b8
// Size: 0xa9
function private function_b546ad1adb3d7895()
{
    self takeallweapons();
    equipment_mp::takeequipment( "primary" );
    equipment_mp::takeequipment( "secondary" );
    perkpackage::perkpackage_giveimmediate( "none" );
    perkpackage::perkpackage_reset();
    val::set( "forever", "super_switching", 0 );
    val::set( "forever", "weapon_first_raise_anims", 0 );
    var_5889c126ebd7f93c = function_488b2d4006c47afd();
    s_data = { #rarity:var_5889c126ebd7f93c, #class:"pi" };
    grant_weapon_class( { #data:s_data }, 1 );
    function_50fe2b88556cf38a();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x320d6e8c, Offset: 0x9469
// Size: 0x2a
function private function_924f107baf9162a8()
{
    self endon( #"death_or_disconnect" );
    
    for ( ;; )
    {
        self waittill( #"last_stand_enter" );
        zm_utility::function_d47920bb0d5fa327( "rbecho_laststand" );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x8738a25d, Offset: 0x949b
// Size: 0xb8
function private function_22f60716c327f499( params )
{
    weapon = self getcurrentweapon();
    
    if ( weapon::iswonderweapon( weapon ) || weapon.ismeleeweapon )
    {
        return;
    }
    
    if ( weapon.basename == "t10_ks_m202" )
    {
        return;
    }
    
    if ( weapon.isalternate )
    {
        if ( weapon.classname == "grenade" && weapon.basename != "sat_pi_alcor_mp" )
        {
            return;
        }
        
        if ( weapon.classname == "spread" && weapon.basename == "sat_sn_caspian_mp" )
        {
            return;
        }
    }
    
    thread function_d9896feb71747e4c( weapon );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0xc
// Checksum 0xe1f8fc6c, Offset: 0x955b
// Size: 0xab
function private function_d9896feb71747e4c( weapon )
{
    self notify( #"hash_498323ecd1d6f2c7" );
    self endon( #"hash_498323ecd1d6f2c7" );
    self endon( #"death_or_disconnect" );
    self endon( #"weapon_change" );
    n_max_stock = weaponmaxammo( weapon );
    n_current_stock = self getweaponammostock( weapon );
    
    if ( n_current_stock >= n_max_stock )
    {
        return;
    }
    
    var_6d5430a0fa352bcb = int( max( ( n_max_stock - n_current_stock ) / 20, 1 ) );
    
    while ( n_current_stock < n_max_stock )
    {
        wait 0.1;
        n_current_stock = min( n_current_stock + var_6d5430a0fa352bcb, n_max_stock );
        self setweaponammostock( weapon, int( n_current_stock ) );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0xc
// Checksum 0xd8cecd27, Offset: 0x960e
// Size: 0x11e
function private function_dbb1be22310e4a82()
{
    self notify( #"hash_8762af186d962442" );
    self endon( #"hash_8762af186d962442" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1;
        var_45346ba0b8b44a4a = self hasperk( "specialty_ammodrainsfromstockfirst" );
        var_3df86f0b126863ab = self getweaponslistprimaries();
        
        foreach ( weapon in var_3df86f0b126863ab )
        {
            if ( weapon::iswonderweapon( weapon ) || weapon.ismeleeweapon || weapon.isalternate )
            {
                continue;
            }
            
            if ( function_f5481110088f9c56( weapon ) )
            {
                self setweaponammoclip( weapon, weaponclipsize( weapon ) );
                continue;
            }
            
            if ( var_45346ba0b8b44a4a )
            {
                self givemaxammo( weapon );
            }
        }
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xda995dbe, Offset: 0x9734
// Size: 0x44, Type: bool
function private function_f5481110088f9c56( weapon )
{
    if ( function_fbb6adbc1a89658a( weapon ) )
    {
        return true;
    }
    
    if ( issubstr( weapon.magazine, "beltfed" ) )
    {
        return true;
    }
    
    if ( weapon.reloaddisabled )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xfde04fce, Offset: 0x9781
// Size: 0x159
function private function_9bd4aa58f8aee070( nround, var_ac07512145efb190 )
{
    roundspawnstruct = zm_round_spawning::function_4ed4fdc352e66c9( nround );
    
    switch ( var_ac07512145efb190 )
    {
        case 1:
            max_count = roundspawnstruct.roundcount;
            break;
        case 2:
            max_count = roundspawnstruct.var_a42625720c9305fb;
            break;
        case 3:
            max_count = roundspawnstruct.var_a4221f720c8f02f2;
            break;
        default:
            max_count = roundspawnstruct.var_a42f31720c9d3f0d;
            break;
    }
    
    if ( roundspawnstruct.roundnumber != nround )
    {
        if ( var_ac07512145efb190 == 1 )
        {
            n_scaler = level.var_a009ab14ee0d3223.linearscalarsolo;
        }
        else
        {
            n_scaler = level.var_a009ab14ee0d3223.linearscalarcoop;
        }
        
        multiplier = ( nround - roundspawnstruct.roundnumber ) * n_scaler;
        max_count += int( max_count * multiplier );
    }
    
    upper_limit = 200 + max( 0, var_ac07512145efb190 - 1 ) * 100;
    max_count = clamp( max_count, zm_round_spawning::function_4ed4fdc352e66c9( 1 ).roundcount, upper_limit );
    return max_count;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xd27275c0, Offset: 0x98e3
// Size: 0xc9
function private function_163f1c895105f646()
{
    level.var_8bf06892f4be21c = level.var_2add2332a4635bbb.var_82ea5be5455d5401 ?? [ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper_hvt", "zombie_callisto_hvt", "zombie_abom_hvt" ];
    level.var_eab60c4a1e53dcdb = [];
    var_272915a5526bc115 = level.var_ff633893b6fa75c3.var_272915a5526bc115;
    var_e6cc809893320971 = level.var_ff633893b6fa75c3.var_e6cc809893320971;
    
    for ( i = 0; i < var_272915a5526bc115.size ; i++ )
    {
        if ( isdefined( var_e6cc809893320971[ i ] ) )
        {
            level.var_eab60c4a1e53dcdb[ var_272915a5526bc115[ i ] ] = var_e6cc809893320971[ i ];
        }
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x1fb6c4e6, Offset: 0x99b4
// Size: 0x8d
function private mod_zombie_speed( params )
{
    self endon( #"death" );
    
    if ( zm_round_logic::get_rb_round_number() < 10 )
    {
        if ( issubstr( self.subclass, "zombie_base" ) && utility::cointoss() )
        {
            if ( zm_round_logic::get_rb_round_number() < 6 )
            {
                thread zombie_utils::function_a8ce00e0448cb6f0( "run", "rampage_inducer", 31 );
            }
            else
            {
                thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "rampage_inducer", 31 );
            }
        }
        
        return;
    }
    
    level callback::remove( "on_zombie_ai_spawned", &mod_zombie_speed );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x87ab6a26, Offset: 0x9a49
// Size: 0x1d9
function private function_ababdb4db38b0d7b( params )
{
    if ( !issubstr( self.subclass, "zombie_base" ) )
    {
        return;
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    
    switch ( round_number )
    {
        case 1:
            ai::set_ai_max_health( 50 );
            break;
        case 2:
            ai::set_ai_max_health( 80 );
            break;
        case 3:
            ai::set_ai_max_health( 110 );
            break;
        case 4:
            ai::set_ai_max_health( 140 );
            break;
        case 5:
            ai::set_ai_max_health( 170 );
            break;
        case 6:
            ai::set_ai_max_health( 225 );
            break;
        case 7:
            ai::set_ai_max_health( 280 );
            break;
        case 8:
            ai::set_ai_max_health( 335 );
            break;
        case 9:
            ai::set_ai_max_health( 390 );
            break;
        case 10:
            ai::set_ai_max_health( 445 );
            break;
        case 11:
            ai::set_ai_max_health( 500 );
            break;
        case 12:
            ai::set_ai_max_health( 615 );
            break;
        case 13:
            ai::set_ai_max_health( 730 );
            break;
        case 14:
            ai::set_ai_max_health( 845 );
            break;
        case 15:
            ai::set_ai_max_health( 960 );
            break;
        default:
            break;
    }
    
    if ( round_number > 15 )
    {
        level callback::remove( "on_zombie_ai_spawned", &function_ababdb4db38b0d7b );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xfdc62e5, Offset: 0x9c2a
// Size: 0xd9
function private init_echo_difficulty()
{
    var_33a8fe8c60ffc725 = getdvarint( @"scr_zm_rb_echo_difficulty", 1 );
    str_move_speed = undefined;
    
    if ( var_33a8fe8c60ffc725 == 2 )
    {
        str_move_speed = getdvar( @"hash_b0eeae1e599f6669", "run" );
    }
    else if ( var_33a8fe8c60ffc725 == 3 )
    {
        str_move_speed = getdvar( @"hash_b0eead1e599f6436", "sprint" );
    }
    
    level.var_7c12c81c2ca8f8d7 = { #var_3515b1dcce563e49:str_move_speed, #var_ba07e2be6da3e238:1, #special_melee_damage_multiplier:1, #var_aa12b9c391f93859:1, #var_33a8fe8c60ffc725:var_33a8fe8c60ffc725 };
    
    if ( var_33a8fe8c60ffc725 > 1 )
    {
        level callback::add( "on_round_start", &function_27ac210bbc2def37 );
    }
    
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned_difficulty );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x9bc50ed4, Offset: 0x9d0b
// Size: 0x4b7
function private function_27ac210bbc2def37( params )
{
    round_number = params.roundnumber;
    var_33a8fe8c60ffc725 = level.var_7c12c81c2ca8f8d7.var_33a8fe8c60ffc725;
    
    if ( var_33a8fe8c60ffc725 == 2 )
    {
        if ( round_number < 10 )
        {
            level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_c000cf96af4fbc5c", 1.25 );
        }
        else if ( round_number < 16 )
        {
            level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_c000d296af4fc2f5", 1.5 );
        }
        else if ( round_number < 21 )
        {
            level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_c000d196af4fc0c2", 2 );
        }
        else
        {
            level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_c000cc96af4fb5c3", 2.5 );
        }
    }
    else if ( round_number < 10 )
    {
        level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_ccc28896b8052237", 1.5 );
    }
    else if ( round_number < 16 )
    {
        level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_ccc28996b805246a", 2 );
    }
    else if ( round_number < 21 )
    {
        level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_ccc28a96b805269d", 3 );
    }
    else
    {
        level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 = getdvarfloat( @"hash_ccc28396b8051738", 4 );
    }
    
    if ( var_33a8fe8c60ffc725 == 2 )
    {
        if ( round_number < 10 )
        {
            level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_ae0058ee9dbf488d", 1.25 );
        }
        else if ( round_number < 16 )
        {
            level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_ae0055ee9dbf41f4", 1.5 );
        }
        else if ( round_number < 21 )
        {
            level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_ae0056ee9dbf4427", 2 );
        }
        else
        {
            level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_ae0053ee9dbf3d8e", 2.5 );
        }
    }
    else if ( round_number < 10 )
    {
        level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_a13e1fee9508c932", 1.5 );
    }
    else if ( round_number < 16 )
    {
        level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_a13e1eee9508c6ff", 2 );
    }
    else if ( round_number < 21 )
    {
        level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_a13e1dee9508c4cc", 3 );
    }
    else
    {
        level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier = getdvarfloat( @"hash_a13e1cee9508c299", 4 );
    }
    
    if ( var_33a8fe8c60ffc725 == 2 )
    {
        if ( round_number < 10 )
        {
            level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_ad2323ef1c69c6d", 1.25 );
        }
        else if ( round_number < 16 )
        {
            level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_ad22f3ef1c695d4", 1.5 );
        }
        else if ( round_number < 21 )
        {
            level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_ad2303ef1c69807", 2 );
        }
        else
        {
            level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_ad22d3ef1c6916e", 2.5 );
        }
        
        return;
    }
    
    if ( round_number < 10 )
    {
        level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_f9aa793ee43b0d92", 1.5 );
        return;
    }
    
    if ( round_number < 16 )
    {
        level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_f9aa783ee43b0b5f", 2 );
        return;
    }
    
    if ( round_number < 21 )
    {
        level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_f9aa773ee43b092c", 3 );
        return;
    }
    
    level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 = getdvarfloat( @"hash_f9aa763ee43b06f9", 4 );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x547797fe, Offset: 0xa1ca
// Size: 0x143
function private on_zombie_ai_spawned_difficulty( params )
{
    if ( isdefined( self.melee_damage_base ) )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            self.var_6c41e8e873b7594e = int( self.melee_damage_base * ( level.var_7c12c81c2ca8f8d7.var_aa12b9c391f93859 ?? 1 ) );
        }
        else if ( self.aicategory == "special" )
        {
            self.var_6c41e8e873b7594e = int( self.melee_damage_base * ( level.var_7c12c81c2ca8f8d7.special_melee_damage_multiplier ?? 1 ) );
        }
        else if ( self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            self.var_6c41e8e873b7594e = int( self.melee_damage_base * ( level.var_7c12c81c2ca8f8d7.var_ba07e2be6da3e238 ?? 1 ) );
        }
    }
    
    str_move_speed = level.var_7c12c81c2ca8f8d7.var_3515b1dcce563e49;
    
    if ( isdefined( str_move_speed ) && issubstr( self.subclass, "zombie_base" ) )
    {
        thread zombie_utils::function_a8ce00e0448cb6f0( str_move_speed, "rampage_inducer", 31 );
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x8a18b5e2, Offset: 0xa315
// Size: 0xde
function private function_1ce67f3b4ca4e165( a_used_indices, var_3078ba5f7bb828ec )
{
    var_6d3d003dd1a8d270 = level.var_e8b652abd3805da2[ var_3078ba5f7bb828ec ];
    var_838c31c163be5a72 = [];
    
    while ( true )
    {
        var_3309d0eaa7261604 = arraycombine( a_used_indices ?? [], var_838c31c163be5a72 );
        var_a05268f65a66e130 = function_831ae0f272db49b7( var_3309d0eaa7261604, var_6d3d003dd1a8d270 );
        
        if ( !isdefined( var_a05268f65a66e130 ) )
        {
            return { #config_index:undefined, #data:function_2284026ad380271c(), #type:"essence" };
        }
        
        var_1344b6c6ccd6e526 = level.var_f6902967d180948a[ var_a05268f65a66e130 ];
        var_c56b6ee6272e1ddf = function_28e6b54a7fe6513f( var_1344b6c6ccd6e526 );
        
        if ( isdefined( var_c56b6ee6272e1ddf ) )
        {
            var_c56b6ee6272e1ddf.config_index = var_a05268f65a66e130;
            return var_c56b6ee6272e1ddf;
        }
        
        var_838c31c163be5a72[ var_838c31c163be5a72.size ] = var_a05268f65a66e130;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x1e1e46c2, Offset: 0xa3fb
// Size: 0xc5
function private function_4476990f31d891a1( str_type )
{
    switch ( str_type )
    {
        case #"hash_c7320b84b20ec6ae":
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            return !function_ca8ffa3d9e0d16c9( "unlock_pap_crystals" );
        case #"hash_4e20f52fe10f267d":
            return !function_ca8ffa3d9e0d16c9( "unlock_aether_tools" );
        case #"hash_617c0facb611c9cb":
            return !function_ca8ffa3d9e0d16c9( "unlock_armor_upgrade" );
        case #"hash_ac7114576080f3cf":
            return !function_ca8ffa3d9e0d16c9( "unlock_wonder_weapons" );
        case #"hash_47611497d0263858":
            return !function_ca8ffa3d9e0d16c9( "extra_portal" );
        default:
            return 0;
    }
}

// Namespace zm_rb_echo
// Params 3, eflags: 0x4
// Checksum 0x321a89d1, Offset: 0xa4c8
// Size: 0x205
function private function_831ae0f272db49b7( var_8b05c0691aa5983a, var_6d3d003dd1a8d270, var_345404e18beb9da2 = 0 )
{
    var_49f7091014d2c59 = level.round_number ?? 1;
    var_ee2b6c8c0fff3ad = [];
    var_c7b118e568b0c229 = [];
    n_total_weight = 0;
    var_59ddc617b847765a = undefined;
    
    if ( var_345404e18beb9da2 && isdefined( level.var_81a2e10a67d09162 ) && isdefined( level.var_81a2e10a67d09162.var_a3bc3d09d69c9c6b ) )
    {
        var_59ddc617b847765a = [[ level.var_81a2e10a67d09162.var_a3bc3d09d69c9c6b ]]();
    }
    
    for ( i = 0; i < level.var_f6902967d180948a.size ; i++ )
    {
        if ( isdefined( var_8b05c0691aa5983a ) && arraycontains( var_8b05c0691aa5983a, i ) )
        {
            continue;
        }
        
        var_1344b6c6ccd6e526 = level.var_f6902967d180948a[ i ];
        
        if ( isdefined( var_6d3d003dd1a8d270 ) && !arraycontains( var_6d3d003dd1a8d270, var_1344b6c6ccd6e526.type ) )
        {
            continue;
        }
        
        if ( !function_f50c3a3bfda3f267( var_1344b6c6ccd6e526, var_49f7091014d2c59 ) )
        {
            continue;
        }
        
        if ( !function_56c22f196c66c161( var_1344b6c6ccd6e526.type ) )
        {
            continue;
        }
        
        if ( !var_345404e18beb9da2 && function_4476990f31d891a1( var_1344b6c6ccd6e526.type ) )
        {
            continue;
        }
        
        var_a58b9f66285b1c55 = var_1344b6c6ccd6e526.weight;
        
        if ( isdefined( var_59ddc617b847765a ) && isdefined( var_59ddc617b847765a[ var_1344b6c6ccd6e526.type ] ) )
        {
            var_a58b9f66285b1c55 = var_59ddc617b847765a[ var_1344b6c6ccd6e526.type ];
        }
        
        if ( var_a58b9f66285b1c55 <= 0 )
        {
            continue;
        }
        
        var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
        var_c7b118e568b0c229[ var_c7b118e568b0c229.size ] = var_a58b9f66285b1c55;
        n_total_weight += var_a58b9f66285b1c55;
    }
    
    if ( !var_ee2b6c8c0fff3ad.size || n_total_weight <= 0 )
    {
        return;
    }
    
    n_roll = randomint( n_total_weight );
    
    for ( i = 0; i < var_ee2b6c8c0fff3ad.size ; i++ )
    {
        n_roll -= var_c7b118e568b0c229[ i ];
        
        if ( n_roll < 0 )
        {
            return var_ee2b6c8c0fff3ad[ i ];
        }
    }
    
    return var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size - 1 ];
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x21e1867e, Offset: 0xa6d6
// Size: 0x3d, Type: bool
function private function_f50c3a3bfda3f267( var_1344b6c6ccd6e526, n_round )
{
    if ( n_round < var_1344b6c6ccd6e526.min_round )
    {
        return false;
    }
    
    if ( n_round > var_1344b6c6ccd6e526.max_round )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x9f796545, Offset: 0xa71c
// Size: 0x233
function private get_reward_display_name( var_c56b6ee6272e1ddf )
{
    if ( function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf ) )
    {
        return function_35d43d80df260198( var_c56b6ee6272e1ddf );
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            return "Rarity Upgrade";
        case #"hash_c7321084b20ece8d":
            return "Pack-a-Punch I";
        case #"hash_c7320d84b20ec9d4":
            return "Pack-a-Punch II";
        case #"hash_c7320e84b20ecb67":
            return "Pack-a-Punch III";
        case #"hash_c7320b84b20ec6ae":
            return "Pack-a-Punch IV";
        case #"hash_be4e031e7acb7b74":
            return "Ammo Mod";
        case #"hash_ac7114576080f3cf":
            return "Wonder Weapon";
        case #"hash_ab671284a3fc4e3d":
            return "Perk";
        case #"hash_17cd1fd5f990f7dd":
            return ( "" + var_c56b6ee6272e1ddf.data + " Essence" );
        case #"hash_b60679835e82a584":
            return "Field Upgrade";
        case #"hash_fdefe402d20f8998":
            return "Loadout Refill";
        case #"hash_617c0facb611c9cb":
            return "Armor Upgrade";
        case #"hash_622103c8ad3b11c8":
            return "Golden Armor";
        case #"hash_47611497d0263858":
            return "Augment";
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            var_8d849ae74095c740 = var_c56b6ee6272e1ddf.data.class + " [R" + var_c56b6ee6272e1ddf.data.rarity + "]";
            
            if ( var_c56b6ee6272e1ddf.data.pap_level > 0 )
            {
                var_8d849ae74095c740 += " PAP" + var_c56b6ee6272e1ddf.data.pap_level;
            }
            
            return var_8d849ae74095c740;
        default:
            return "Unknown Reward";
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xae1f068d, Offset: 0xa957
// Size: 0x19a
function private function_56c22f196c66c161( str_type )
{
    switch ( str_type )
    {
        case #"hash_4e20f52fe10f267d":
            return function_470c12b5b33a33ef();
        case #"hash_c7321084b20ece8d":
            return function_f1243ac0dfad8595( 1 );
        case #"hash_c7320d84b20ec9d4":
            return function_f1243ac0dfad8595( 2 );
        case #"hash_c7320e84b20ecb67":
            return function_f1243ac0dfad8595( 3 );
        case #"hash_c7320b84b20ec6ae":
            return function_f1243ac0dfad8595( 4 );
        case #"hash_be4e031e7acb7b74":
            return function_3840701bf6752996();
        case #"hash_ac7114576080f3cf":
            return function_aa7ed21954902831();
        case #"hash_ab671284a3fc4e3d":
            return function_bb17445816468f93();
        case #"hash_b60679835e82a584":
            return function_a4b8e8475fcf2d2e();
        case #"hash_fdefe402d20f8998":
            return 1;
        case #"hash_617c0facb611c9cb":
            return function_b930a0aa46ef283d();
        case #"hash_622103c8ad3b11c8":
            return function_698262e196f8aad2();
        case #"hash_47611497d0263858":
            return function_6c4071607fa7a402();
        case #"hash_bef5ec0b3e197ae":
        case #"hash_17cd1fd5f990f7dd":
        case #"hash_27124c6c97ccffa1":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            return 1;
        default:
            return 0;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x78f00d66, Offset: 0xaaf9
// Size: 0x96, Type: bool
function private function_d072bbe5cb36b391( var_c56b6ee6272e1ddf )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) || !isdefined( var_c56b6ee6272e1ddf.data ) )
    {
        return false;
    }
    
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone || !pack_a_punch::can_pap( weapon ) )
    {
        return false;
    }
    
    n_target_level = var_c56b6ee6272e1ddf.data;
    var_b68b19d9aed8b14e = function_f4bc24729fcdafca();
    
    if ( n_target_level > var_b68b19d9aed8b14e )
    {
        return false;
    }
    
    return n_target_level > pack_a_punch::get_pap_level( weapon );
}

// Namespace zm_rb_echo
// Params 3, eflags: 0x4
// Checksum 0xfaea0c1f, Offset: 0xab98
// Size: 0x36a
function private function_28e6b54a7fe6513f( var_1344b6c6ccd6e526, var_e2560635af8a29db = 0, var_31c77814d3f874c3 = [] )
{
    var_c56b6ee6272e1ddf = { #type:var_1344b6c6ccd6e526.type };
    
    switch ( var_1344b6c6ccd6e526.type )
    {
        case #"hash_4e20f52fe10f267d":
            break;
        case #"hash_c7321084b20ece8d":
            var_c56b6ee6272e1ddf.data = 1;
            break;
        case #"hash_c7320d84b20ec9d4":
            var_c56b6ee6272e1ddf.data = 2;
            break;
        case #"hash_c7320e84b20ecb67":
            var_c56b6ee6272e1ddf.data = 3;
            break;
        case #"hash_c7320b84b20ec6ae":
            var_c56b6ee6272e1ddf.data = 4;
            break;
        case #"hash_be4e031e7acb7b74":
            var_c56b6ee6272e1ddf.data = function_e3b82f2ce2813ff6( var_e2560635af8a29db );
            
            if ( !isdefined( var_c56b6ee6272e1ddf.data ) )
            {
                return;
            }
            
            foreach ( var_49a8cba96c1f4bac in level.var_5e4906d509cd618f )
            {
                if ( var_49a8cba96c1f4bac.ammo_mod == var_c56b6ee6272e1ddf.data )
                {
                    var_c56b6ee6272e1ddf.var_afdcadb44a80e6a2 = var_49a8cba96c1f4bac.var_afdcadb44a80e6a2;
                    break;
                }
            }
            
            break;
        case #"hash_ac7114576080f3cf":
            var_c56b6ee6272e1ddf.data = utility::array_random( [ "sat_ww_raygun_mp", "sat_ww_raygunmark2_mp" ] );
            break;
        case #"hash_ab671284a3fc4e3d":
            var_c56b6ee6272e1ddf.data = function_4f1934a9fb7b72b3( var_31c77814d3f874c3 );
            
            if ( !isdefined( var_c56b6ee6272e1ddf.data ) )
            {
                return;
            }
            
            break;
        case #"hash_17cd1fd5f990f7dd":
            var_c56b6ee6272e1ddf.data = function_2284026ad380271c();
            break;
        case #"hash_b60679835e82a584":
            var_c56b6ee6272e1ddf.data = function_8434d0987195c0e();
            break;
        case #"hash_fdefe402d20f8998":
            break;
        case #"hash_617c0facb611c9cb":
            break;
        case #"hash_622103c8ad3b11c8":
            break;
        case #"hash_47611497d0263858":
            var_9e9cac9f003de860 = function_a877932ca0ed606d( var_31c77814d3f874c3 );
            
            if ( var_9e9cac9f003de860.size )
            {
                var_c56b6ee6272e1ddf.data = var_9e9cac9f003de860[ randomint( var_9e9cac9f003de860.size ) ];
            }
            
            break;
        case #"hash_27124c6c97ccffa1":
            s_class = select_weapon_class();
            var_5be33a172f0b3d3c = function_7892867ba10e3a9( s_class.class );
            var_c56b6ee6272e1ddf.type = s_class.type;
            var_c56b6ee6272e1ddf.data = { #pap_level:var_5be33a172f0b3d3c.pap_level, #rarity:var_5be33a172f0b3d3c.rarity, #class:s_class.class };
            break;
    }
    
    return var_c56b6ee6272e1ddf;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xd25377fd, Offset: 0xaf0b
// Size: 0x438
function private grant_reward( var_c56b6ee6272e1ddf )
{
    if ( function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf ) )
    {
        function_7361be97a6acf949( self, var_c56b6ee6272e1ddf );
        return;
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            grant_rarity_upgrade( var_c56b6ee6272e1ddf );
            break;
        case #"hash_c7320b84b20ec6ae":
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            grant_pap_upgrade( var_c56b6ee6272e1ddf );
            break;
        case #"hash_be4e031e7acb7b74":
            grant_ammo_mod( var_c56b6ee6272e1ddf );
            break;
        case #"hash_ac7114576080f3cf":
            grant_wonder_weapon( var_c56b6ee6272e1ddf );
            break;
        case #"hash_ab671284a3fc4e3d":
            str_perk = var_c56b6ee6272e1ddf.data;
            
            if ( !isdefined( str_perk ) )
            {
                /#
                    if ( !false )
                    {
                        if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                        {
                            assert( 0, "<dev string:x566>" + "<dev string:x574>" );
                        }
                        else
                        {
                            println( "<dev string:x5a6>" + "<dev string:x574>" );
                        }
                    }
                #/
                
                break;
            }
            
            if ( zombie_perks::has_perk( str_perk ) )
            {
                grant_perk( var_c56b6ee6272e1ddf, 1 );
            }
            else
            {
                grant_perk( var_c56b6ee6272e1ddf, 0 );
            }
            
            break;
        case #"hash_17cd1fd5f990f7dd":
            grant_essence( var_c56b6ee6272e1ddf );
            break;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_ab10f9c080fe4faf":
            grant_weapon_class( var_c56b6ee6272e1ddf );
            break;
        case #"hash_86b11ac21f992552":
            grant_weapon_melee( var_c56b6ee6272e1ddf );
            break;
        case #"hash_b60679835e82a584":
            grant_field_upgrade( var_c56b6ee6272e1ddf );
            break;
        case #"hash_fdefe402d20f8998":
            grant_loadout_refill( var_c56b6ee6272e1ddf );
            break;
        case #"hash_617c0facb611c9cb":
            grant_armor_upgrade( var_c56b6ee6272e1ddf );
            break;
        case #"hash_622103c8ad3b11c8":
            grant_golden_armor( var_c56b6ee6272e1ddf );
            break;
        case #"hash_47611497d0263858":
            grant_augment( var_c56b6ee6272e1ddf );
            break;
    }
    
    switch ( var_c56b6ee6272e1ddf.rarity )
    {
        case #"hash_1393412d7401c646":
            str_splash = #"hash_59747012fdb85ad1";
            break;
        case #"hash_883ff07272b4f9c":
            str_splash = #"hash_2e0558dd7f383a7a";
            break;
        case #"hash_778bb52ecd08072d":
            str_splash = #"hash_1528f00e3793c0e8";
            break;
        case #"hash_598a30e44f53045f":
            str_splash = #"hash_e0caee9dd3834ee5";
            break;
        case #"hash_35bb3bd014c77f4b":
        case #"hash_97430f6c58e61cbc":
            str_splash = #"hash_f63238ad7dbd2c15";
            break;
        default:
            str_splash = #"hash_f67e057c98ad4947";
            break;
    }
    
    if ( var_c56b6ee6272e1ddf.loot_id )
    {
        self setclientomnvar( "ui_zm_echo_portal_splash_reward_lootid", var_c56b6ee6272e1ddf.loot_id );
        thread hud_message::showsplash( str_splash );
        return;
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_17cd1fd5f990f7dd":
            thread hud_message::showsplash( #"hash_c816265364b76a9a" );
            break;
        case #"hash_fdefe402d20f8998":
            thread hud_message::showsplash( #"hash_84747f59362b0814" );
            break;
        case #"hash_617c0facb611c9cb":
            thread hud_message::showsplash( #"hash_721bffaaad501d47" );
            break;
        case #"hash_622103c8ad3b11c8":
            thread hud_message::showsplash( #"hash_3f1230d0a52e8c3e" );
            break;
        case #"hash_c7320b84b20ec6ae":
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            thread hud_message::showsplash( #"hash_1da6dbc4da52d349" );
            break;
        case #"hash_4e20f52fe10f267d":
            thread hud_message::showsplash( #"hash_6ebdc42f2dacb38b" );
            break;
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x6d7a8e3d, Offset: 0xb34b
// Size: 0xd8
function private get_echo_damage_multiplier( n_rarity = 0, var_354f0bfb29010e0c )
{
    var_98aa86cdce0ce7bc = [ 1, 1.5, 2, 3, 4, 5 ];
    a_pap_mult = [ 1, 2, 4, 8, 16 ];
    var_103f05ff093d438d = isdefined( var_354f0bfb29010e0c ) ? var_354f0bfb29010e0c + 1 : 0;
    var_103f05ff093d438d = clamp( var_103f05ff093d438d, 0, a_pap_mult.size - 1 );
    n_rarity = clamp( n_rarity, 0, var_98aa86cdce0ce7bc.size - 1 );
    return var_98aa86cdce0ce7bc[ n_rarity ] * a_pap_mult[ var_103f05ff093d438d ];
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x9e3c10d4, Offset: 0xb42c
// Size: 0xcd, Type: bool
function private function_470c12b5b33a33ef()
{
    var_bc04d89890b0d04d = function_e86e9a96bffedef9();
    var_3df86f0b126863ab = self getweaponslistprimaries();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) )
        {
            continue;
        }
        
        rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
        
        if ( rarity < var_bc04d89890b0d04d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x234525bd, Offset: 0xb502
// Size: 0x4, Type: bool
function private function_a4b8e8475fcf2d2e()
{
    return true;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x451d0f79, Offset: 0xb50f
// Size: 0xb, Type: bool
function private function_6c4071607fa7a402()
{
    return function_a877932ca0ed606d().size > 0;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x2ac9ba40, Offset: 0xb523
// Size: 0xc9, Type: bool
function private function_f1243ac0dfad8595( n_target_level )
{
    var_b68b19d9aed8b14e = function_f4bc24729fcdafca();
    
    if ( n_target_level > var_b68b19d9aed8b14e )
    {
        return false;
    }
    
    var_3df86f0b126863ab = self getweaponslistprimaries();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( !pack_a_punch::can_pap( weapon ) )
        {
            continue;
        }
        
        var_951c89546ec50477 = pack_a_punch::get_pap_level( weapon );
        
        if ( var_951c89546ec50477 < n_target_level )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xf8106611, Offset: 0xb5f5
// Size: 0x11
function private get_player_primary_weapon()
{
    return item_weapon::function_e7484276ad85f220( #"primary_0" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x9728856b, Offset: 0xb60f
// Size: 0x1e, Type: bool
function private function_b0e0765ed2d41a30()
{
    return isdefined( self.var_cc1262e66dbb1c79 ) && self hasweapon( self.var_cc1262e66dbb1c79 );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb88de563, Offset: 0xb636
// Size: 0x25
function private function_3840701bf6752996()
{
    primary = get_player_primary_weapon();
    
    if ( !isdefined( primary ) )
    {
        return 0;
    }
    
    return ammo_mod::function_7bbc1db07694f31d( primary );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xf9b5acad, Offset: 0xb664
// Size: 0x96, Type: bool
function private player_has_ammo_mod( var_4c506782108851c7 )
{
    var_3df86f0b126863ab = self getweaponslistprimaries();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( ammo_mod::get_ammo_mod_name( weapon ) == var_4c506782108851c7 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xc7716f09, Offset: 0xb703
// Size: 0x4, Type: bool
function private function_aa7ed21954902831()
{
    return true;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xaf02815c, Offset: 0xb710
// Size: 0x34
function private is_holding_wonder_weapon()
{
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        return 0;
    }
    
    return weapon::iswonderweapon( weapon );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xc08d27ed, Offset: 0xb74d
// Size: 0x1c, Type: bool
function private function_44dddd0482cce54( str_perk )
{
    return isdefined( str_perk ) && !zombie_perks::has_permanent_perk( str_perk );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb5246b6b, Offset: 0xb772
// Size: 0xee, Type: bool
function private function_bb17445816468f93()
{
    foreach ( perk in [ "specialty_juggernog", "specialty_quickrevive", "specialty_speedcola", "specialty_staminup", "specialty_deadshot", "specialty_death_perception", "specialty_elemental_pop", "specialty_phd_flopper", "specialty_vulture_aid", "specialty_m_mod", "specialty_d_mod", "specialty_w_mod", "specialty_y_mod" ] )
    {
        if ( function_44dddd0482cce54( perk ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x381b1fa0, Offset: 0xb869
// Size: 0x7c, Type: bool
function private function_b930a0aa46ef283d()
{
    relic_bundle = level.zm_relics[ %"hash_2a3c31ac35b565e6" ];
    
    if ( isdefined( relic_bundle ) && utility::issharedfuncdefined( #"relics", #"hash_9264c89cf44e24ee" ) )
    {
        if ( utility::callsharedfunc( #"relics", #"hash_9264c89cf44e24ee", relic_bundle.modifiertype ) )
        {
            return false;
        }
    }
    
    return ( self.platecarrierlevel ?? 1 ) < 3;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x5853bcdb, Offset: 0xb8ee
// Size: 0x1e, Type: bool
function private function_698262e196f8aad2()
{
    if ( !function_2651dec385c4959( 1 ) )
    {
        return false;
    }
    
    return !( self.var_a1faa64d8c07872e ?? 0 );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x3838a09, Offset: 0xb915
// Size: 0x13c
function private select_weapon_class()
{
    n_total_weight = 0;
    
    foreach ( var_49a8cba96c1f4bac in level.var_81ce411cb6528e21 )
    {
        n_total_weight += var_49a8cba96c1f4bac.weight;
    }
    
    if ( n_total_weight <= 0 )
    {
        return;
    }
    
    n_roll = randomint( n_total_weight );
    
    foreach ( var_49a8cba96c1f4bac in level.var_81ce411cb6528e21 )
    {
        n_roll -= var_49a8cba96c1f4bac.weight;
        
        if ( n_roll < 0 )
        {
            return var_49a8cba96c1f4bac;
        }
    }
    
    return level.var_81ce411cb6528e21[ level.var_81ce411cb6528e21.size - 1 ];
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x335933ad, Offset: 0xba5a
// Size: 0x80f
function private function_7892867ba10e3a9( str_weapon_class )
{
    var_98aa86cdce0ce7bc = [ 1, 1.5, 2, 3, 4, 5 ];
    a_pap_mult = [ 1, 2, 4, 8, 16 ];
    var_bc04d89890b0d04d = function_e86e9a96bffedef9();
    var_b68b19d9aed8b14e = function_f4bc24729fcdafca();
    a_pap_levels = [ -1, 0, 1, 2 ];
    
    if ( var_b68b19d9aed8b14e >= 4 )
    {
        a_pap_levels[ a_pap_levels.size ] = 3;
    }
    
    a_tiers = [];
    
    foreach ( var_c1aa3a77526d77c5 in a_pap_levels )
    {
        var_103f05ff093d438d = var_c1aa3a77526d77c5 >= 0 ? var_c1aa3a77526d77c5 + 1 : 0;
        
        for ( n_rarity = 0; n_rarity <= var_bc04d89890b0d04d ; n_rarity++ )
        {
            var_c8c607c014acbbeb = var_98aa86cdce0ce7bc[ n_rarity ] * a_pap_mult[ var_103f05ff093d438d ];
            var_2f3a78b4d90aa879 = var_c1aa3a77526d77c5 >= 0 ? var_c1aa3a77526d77c5 : undefined;
            var_5be33a172f0b3d3c = { #var_5061852a2493cce8:var_c8c607c014acbbeb, #pap_level:var_2f3a78b4d90aa879, #rarity:n_rarity };
            a_tiers[ a_tiers.size ] = var_5be33a172f0b3d3c;
        }
    }
    
    n_current_mult = 1;
    
    if ( str_weapon_class == "me" )
    {
        weapon = self.var_cc1262e66dbb1c79;
    }
    else
    {
        weapon = item_weapon::function_e7484276ad85f220( #"primary_0" );
        
        if ( isdefined( self.micontext ) && isdefined( self.micontext.weapstructs ) && !isdefined( weapon ) && self.ismutantinjection == 1 )
        {
            foreach ( var_9527ca5a2006f9d1 in self.micontext.weapstructs )
            {
                if ( !var_9527ca5a2006f9d1.ismeleeoverrideweapon && !weapon::iswonderweapon( var_9527ca5a2006f9d1.weaponobj ) )
                {
                    weapon = var_9527ca5a2006f9d1.weaponobj;
                    break;
                }
            }
        }
    }
    
    if ( isdefined( weapon ) && ( self hasweapon( weapon ) || self.ismutantinjection == 1 ) )
    {
        if ( self.ismutantinjection == 1 && isdefined( self.var_863bc696d31749ec ) )
        {
            n_current_rarity = 0;
            
            foreach ( cacheddata in self.var_863bc696d31749ec )
            {
                if ( cacheddata.baseweapon == weapon.basename )
                {
                    n_current_rarity = cacheddata.weapondata.rarity ?? 0;
                    break;
                }
            }
        }
        else
        {
            n_current_rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
        }
        
        n_current_pap = pack_a_punch::get_pap_level( weapon );
        var_2fc9c515847ba4d7 = n_current_pap > 0 ? n_current_pap - 1 : undefined;
        n_current_mult = get_echo_damage_multiplier( n_current_rarity, var_2fc9c515847ba4d7 );
    }
    
    var_23676db26464c6b5 = [];
    
    foreach ( var_5be33a172f0b3d3c in a_tiers )
    {
        if ( var_5be33a172f0b3d3c.var_5061852a2493cce8 < n_current_mult )
        {
            continue;
        }
        
        if ( var_5be33a172f0b3d3c.var_5061852a2493cce8 == n_current_mult )
        {
            if ( !isdefined( var_23676db26464c6b5[ 0 ] ) )
            {
                var_23676db26464c6b5[ 0 ] = [];
            }
            
            var_23676db26464c6b5[ 0 ][ var_23676db26464c6b5[ 0 ].size ] = var_5be33a172f0b3d3c;
            continue;
        }
        
        n_tier_distance = 0;
        var_ad1e4605c71bf624 = n_current_mult;
        
        foreach ( var_678dae76d95010b0 in a_tiers )
        {
            if ( var_678dae76d95010b0.var_5061852a2493cce8 > var_ad1e4605c71bf624 && var_678dae76d95010b0.var_5061852a2493cce8 <= var_5be33a172f0b3d3c.var_5061852a2493cce8 )
            {
                n_tier_distance++;
                var_ad1e4605c71bf624 = var_678dae76d95010b0.var_5061852a2493cce8;
            }
        }
        
        if ( !isdefined( var_23676db26464c6b5[ n_tier_distance ] ) )
        {
            var_23676db26464c6b5[ n_tier_distance ] = [];
        }
        
        var_23676db26464c6b5[ n_tier_distance ][ var_23676db26464c6b5[ n_tier_distance ].size ] = var_5be33a172f0b3d3c;
    }
    
    var_5ffed69610bd3e20 = level.var_b1f66e209d5b5c60;
    n_total_weight = 0;
    a_valid_dists = [];
    a_valid_weights = [];
    
    foreach ( var_b6081b1b6ba5e8b5, a_combos in var_23676db26464c6b5 )
    {
        var_d4a0bbf011e4ca66 = var_b6081b1b6ba5e8b5;
        
        if ( var_d4a0bbf011e4ca66 >= var_5ffed69610bd3e20.size )
        {
            continue;
        }
        
        var_a58b9f66285b1c55 = var_5ffed69610bd3e20[ var_d4a0bbf011e4ca66 ];
        a_valid_dists[ a_valid_dists.size ] = var_b6081b1b6ba5e8b5;
        a_valid_weights[ a_valid_weights.size ] = var_a58b9f66285b1c55;
        n_total_weight += var_a58b9f66285b1c55;
    }
    
    if ( !a_valid_dists.size || n_total_weight <= 0 )
    {
        s_top = a_tiers[ a_tiers.size - 1 ];
        return { #pap_level:s_top.pap_level, #rarity:s_top.rarity };
    }
    
    n_roll = randomint( n_total_weight );
    var_2ae0213e0ac01e8 = a_valid_dists[ a_valid_dists.size - 1 ];
    
    for ( i = 0; i < a_valid_dists.size ; i++ )
    {
        n_roll -= a_valid_weights[ i ];
        
        if ( n_roll < 0 )
        {
            var_2ae0213e0ac01e8 = a_valid_dists[ i ];
            break;
        }
    }
    
    a_combos = var_23676db26464c6b5[ var_2ae0213e0ac01e8 ];
    var_e73d24757f27e192 = a_combos[ 0 ];
    
    foreach ( s_candidate in a_combos )
    {
        if ( !isdefined( s_candidate.pap_level ) )
        {
            var_e73d24757f27e192 = s_candidate;
            break;
        }
        
        if ( !isdefined( var_e73d24757f27e192.pap_level ) )
        {
            continue;
        }
        
        if ( s_candidate.pap_level < var_e73d24757f27e192.pap_level )
        {
            var_e73d24757f27e192 = s_candidate;
        }
    }
    
    return { #pap_level:var_e73d24757f27e192.pap_level, #rarity:var_e73d24757f27e192.rarity };
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x2a4374d6, Offset: 0xc272
// Size: 0x19e
function private function_4f1934a9fb7b72b3( var_31c77814d3f874c3 = [] )
{
    var_ee2b6c8c0fff3ad = [];
    n_total_weight = 0;
    
    for ( i = 0; i < level.var_e1277df6c7b0d16e.size ; i++ )
    {
        var_49a8cba96c1f4bac = level.var_e1277df6c7b0d16e[ i ];
        
        if ( !function_44dddd0482cce54( var_49a8cba96c1f4bac.perk ) )
        {
            continue;
        }
        
        if ( function_e60f07f125bb1a2c( { #data:var_49a8cba96c1f4bac.perk, #type:"perk" }, var_31c77814d3f874c3 ) )
        {
            continue;
        }
        
        var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
        n_total_weight += var_49a8cba96c1f4bac.weight;
    }
    
    if ( !var_ee2b6c8c0fff3ad.size || n_total_weight <= 0 )
    {
        return;
    }
    
    n_roll = randomint( n_total_weight );
    
    foreach ( n_index in var_ee2b6c8c0fff3ad )
    {
        n_roll -= level.var_e1277df6c7b0d16e[ n_index ].weight;
        
        if ( n_roll < 0 )
        {
            return level.var_e1277df6c7b0d16e[ n_index ].perk;
        }
    }
    
    return level.var_e1277df6c7b0d16e[ var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size - 1 ] ].perk;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x38b72b17, Offset: 0xc419
// Size: 0x214
function private function_e3b82f2ce2813ff6( var_e2560635af8a29db = 0 )
{
    primary = get_player_primary_weapon();
    var_f01a1ccf161a3b48 = isdefined( primary ) ? ammo_mod::get_ammo_mod_name( primary ) : undefined;
    var_ee2b6c8c0fff3ad = [];
    n_total_weight = 0;
    
    for ( i = 0; i < level.var_5e4906d509cd618f.size ; i++ )
    {
        if ( var_e2560635af8a29db && player_has_ammo_mod( level.var_5e4906d509cd618f[ i ].ammo_mod ) )
        {
            continue;
        }
        
        if ( !var_e2560635af8a29db && var_f01a1ccf161a3b48 && level.var_5e4906d509cd618f[ i ].ammo_mod == var_f01a1ccf161a3b48 )
        {
            continue;
        }
        
        var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
        n_total_weight += level.var_5e4906d509cd618f[ i ].weight;
    }
    
    if ( !var_e2560635af8a29db && !var_ee2b6c8c0fff3ad.size )
    {
        n_total_weight = 0;
        
        for ( i = 0; i < level.var_5e4906d509cd618f.size ; i++ )
        {
            var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
            n_total_weight += level.var_5e4906d509cd618f[ i ].weight;
        }
    }
    
    if ( !var_ee2b6c8c0fff3ad.size || n_total_weight <= 0 )
    {
        return;
    }
    
    n_roll = randomint( n_total_weight );
    
    foreach ( n_index in var_ee2b6c8c0fff3ad )
    {
        n_roll -= level.var_5e4906d509cd618f[ n_index ].weight;
        
        if ( n_roll < 0 )
        {
            return level.var_5e4906d509cd618f[ n_index ].ammo_mod;
        }
    }
    
    return level.var_5e4906d509cd618f[ var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size - 1 ] ].ammo_mod;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x7735716f, Offset: 0xc636
// Size: 0x197
function private function_8434d0987195c0e()
{
    var_ee2b6c8c0fff3ad = [];
    n_total_weight = 0;
    
    for ( i = 0; i < level.var_108676f50d3d5999.size ; i++ )
    {
        var_49a8cba96c1f4bac = level.var_108676f50d3d5999[ i ];
        
        if ( supers_mp::getcurrentsuperref() == var_49a8cba96c1f4bac.field_upgrade )
        {
            continue;
        }
        
        var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
        n_total_weight += var_49a8cba96c1f4bac.weight;
    }
    
    if ( !var_ee2b6c8c0fff3ad.size || n_total_weight <= 0 )
    {
        n_total_weight = 0;
        
        for ( i = 0; i < level.var_108676f50d3d5999.size ; i++ )
        {
            var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size ] = i;
            n_total_weight += level.var_108676f50d3d5999[ i ].weight;
        }
    }
    
    n_roll = randomint( n_total_weight );
    
    foreach ( n_index in var_ee2b6c8c0fff3ad )
    {
        n_roll -= level.var_108676f50d3d5999[ n_index ].weight;
        
        if ( n_roll < 0 )
        {
            return level.var_108676f50d3d5999[ n_index ].field_upgrade;
        }
    }
    
    return level.var_108676f50d3d5999[ var_ee2b6c8c0fff3ad[ var_ee2b6c8c0fff3ad.size - 1 ] ].field_upgrade;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x26d37620, Offset: 0xc7d6
// Size: 0x244
function private function_a877932ca0ed606d( var_31c77814d3f874c3 = [] )
{
    a_eligible = [];
    
    foreach ( str_perk, a_augments in level.var_98451248a70b7bb3 )
    {
        if ( zombie_perks::has_perk( str_perk ) || zombie_perks::has_permanent_perk( str_perk ) )
        {
            a_eligible = arraycombine( a_eligible, a_augments );
        }
    }
    
    foreach ( var_4c506782108851c7, a_augments in level.var_6c3426d7b2e5e264 )
    {
        if ( player_has_ammo_mod( var_4c506782108851c7 ) )
        {
            a_eligible = arraycombine( a_eligible, a_augments );
        }
    }
    
    str_super = supers_mp::getcurrentsuperref();
    
    if ( isdefined( str_super ) && isdefined( level.var_151effd1b9580cae[ str_super ] ) )
    {
        a_eligible = arraycombine( a_eligible, level.var_151effd1b9580cae[ str_super ] );
    }
    
    var_e8cf774436ac245e = function_b0e0765ed2d41a30();
    var_f0697635a778e6f = [];
    
    foreach ( augment_ref in a_eligible )
    {
        if ( zombie_augments::player_has_augment( augment_ref ) )
        {
            continue;
        }
        else if ( augment_ref == #"m_mod_panic_knife" && !var_e8cf774436ac245e )
        {
            continue;
        }
        else if ( function_e60f07f125bb1a2c( { #data:augment_ref, #type:"augment" }, var_31c77814d3f874c3 ) )
        {
            continue;
        }
        
        var_f0697635a778e6f[ var_f0697635a778e6f.size ] = augment_ref;
    }
    
    return var_f0697635a778e6f;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x8cb76ecc, Offset: 0xca23
// Size: 0x5
function private function_2284026ad380271c()
{
    return 5000;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xc700fd17, Offset: 0xca31
// Size: 0x15d
function private grant_rarity_upgrade( var_c56b6ee6272e1ddf )
{
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x5c7>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x5c7>" );
            }
        #/
        
        return;
    }
    
    if ( weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x5f8>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x5f8>" );
            }
        #/
        
        return;
    }
    
    rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
    var_bc04d89890b0d04d = function_e86e9a96bffedef9();
    
    if ( isdefined( var_c56b6ee6272e1ddf.target_rarity ) )
    {
        var_7c0d29caa7b948c6 = int( clamp( var_c56b6ee6272e1ddf.target_rarity, rarity + 1, var_bc04d89890b0d04d ) );
    }
    else
    {
        var_7c0d29caa7b948c6 = int( clamp( rarity + 1, 1, var_bc04d89890b0d04d ) );
    }
    
    item_weapon::function_40e1cbd0e1f47d1a( weapon, var_7c0d29caa7b948c6 );
    
    /#
        iprintlnbold( "<dev string:x633>" + var_7c0d29caa7b948c6 );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x60d860e, Offset: 0xcb96
// Size: 0x1ca
function private grant_pap_upgrade( var_c56b6ee6272e1ddf )
{
    n_target_level = var_c56b6ee6272e1ddf.data;
    var_b68b19d9aed8b14e = function_f4bc24729fcdafca();
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x647>" + n_target_level );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x647>" + n_target_level );
            }
        #/
        
        return;
    }
    
    if ( !pack_a_punch::can_pap( weapon ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x67d>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x67d>" );
            }
        #/
        
        return;
    }
    
    n_current_level = pack_a_punch::get_pap_level( weapon );
    
    if ( n_current_level >= n_target_level )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x6b0>" + n_current_level + "<dev string:x6da>" + n_target_level );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x6b0>" + n_current_level + "<dev string:x6da>" + n_target_level );
            }
        #/
        
        return;
    }
    
    if ( n_target_level > var_b68b19d9aed8b14e )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x6ed>" + n_target_level + "<dev string:x704>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x6ed>" + n_target_level + "<dev string:x704>" );
            }
        #/
        
        return;
    }
    
    pack_a_punch::pap_weapon( weapon, n_current_level, undefined, undefined, undefined, undefined, undefined, n_target_level );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x16ca34ba, Offset: 0xcd68
// Size: 0x10f
function private grant_ammo_mod( var_c56b6ee6272e1ddf )
{
    var_4c506782108851c7 = var_c56b6ee6272e1ddf.data;
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x726>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x726>" );
            }
        #/
        
        return;
    }
    
    if ( !ammo_mod::function_7bbc1db07694f31d( weapon ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x751>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x751>" );
            }
        #/
        
        return;
    }
    
    ammo_mod::add_ammo_mod_to_weapon( weapon, var_4c506782108851c7 );
    var_c56b6ee6272e1ddf.loot_id = loot::getlootidfromref( level.var_3355343961c11683[ var_4c506782108851c7 ] );
    
    /#
        iprintlnbold( "<dev string:x780>" + var_4c506782108851c7 );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xae987fe9, Offset: 0xce7f
// Size: 0x20a
function private grant_wonder_weapon( var_c56b6ee6272e1ddf )
{
    var_2e08e94c9cb1747c = var_c56b6ee6272e1ddf.data;
    weapon = weapon_utility::function_d2c8356dc369d9ce( var_2e08e94c9cb1747c );
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x791>" + var_2e08e94c9cb1747c );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x791>" + var_2e08e94c9cb1747c );
            }
        #/
        
        return;
    }
    
    var_5bb482f8fce9e283 = 0;
    var_77f211b45c8727a1 = self getweaponslistprimaries();
    
    foreach ( held_weapon in var_77f211b45c8727a1 )
    {
        if ( weapon::iswonderweapon( held_weapon ) )
        {
            var_5bb482f8fce9e283 = max( var_5bb482f8fce9e283, pack_a_punch::get_pap_level( held_weapon ) );
            self takeweapon( held_weapon );
        }
    }
    
    fakeitem = spawnstruct();
    fakeitem.weaponobj = weapon;
    clipammo = weaponclipsize( weapon );
    fakeitem.count = common_item::function_598dd39282efb544( clipammo );
    item_bundle = common_item::function_b202b16941992cca( challenges::getweaponlootid( weapon, weapon.basename ) );
    var_839d6ed0cef544c2 = common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
    weapon = var_839d6ed0cef544c2[ 1 ];
    
    if ( var_5bb482f8fce9e283 > 0 )
    {
        weapon = pack_a_punch::pap_weapon( weapon, 0, undefined, undefined, undefined, undefined, undefined, var_5bb482f8fce9e283 );
    }
    
    self givemaxammo( weapon );
    thread function_be3ccd58e8322f2b();
    var_c56b6ee6272e1ddf.loot_id = challenges::getweaponlootid( weapon, weapon.basename );
    
    /#
        iprintlnbold( "<dev string:x7c0>" + var_2e08e94c9cb1747c );
    #/
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x35cf2b7f, Offset: 0xd091
// Size: 0x18c
function private grant_perk( var_c56b6ee6272e1ddf, var_96bf6a2826dd7dd5 )
{
    str_perk = var_c56b6ee6272e1ddf.data;
    
    if ( !isdefined( str_perk ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x7d8>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x7d8>" );
            }
        #/
        
        return;
    }
    
    if ( zombie_perks::has_perk( str_perk ) && !var_96bf6a2826dd7dd5 || zombie_perks::has_permanent_perk( str_perk ) && var_96bf6a2826dd7dd5 )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x7fb>" + str_perk + ( var_96bf6a2826dd7dd5 ? "<dev string:x820>" : "<dev string:x82d>" ) );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x7fb>" + str_perk + ( var_96bf6a2826dd7dd5 ? "<dev string:x820>" : "<dev string:x82d>" ) );
            }
        #/
        
        return;
    }
    
    if ( var_96bf6a2826dd7dd5 )
    {
        gesture = level._custom_perks[ str_perk ].perk_bottle_weapon ?? "cer_zm_vm_ges_001";
        thread zombie_perks::function_13cc8b1c31dda8c4( gesture );
        zombie_perks::function_3c5c75cec72d90aa( str_perk );
    }
    else
    {
        zombie_perks::grab_and_use_perk( str_perk, 1, undefined, var_96bf6a2826dd7dd5 );
    }
    
    var_c56b6ee6272e1ddf.loot_id = loot::getlootidfromref( str_perk );
    
    /#
        iprintlnbold( "<dev string:x82e>" + str_perk + ( var_96bf6a2826dd7dd5 ? "<dev string:x820>" : "<dev string:x82d>" ) );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x2e82f16e, Offset: 0xd225
// Size: 0x45
function private grant_essence( var_c56b6ee6272e1ddf )
{
    var_679667f78224332d = var_c56b6ee6272e1ddf.data;
    currency::add_currency_amount( #"essence", var_679667f78224332d );
    
    /#
        iprintlnbold( "<dev string:x83d>" + var_679667f78224332d );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xac971e31, Offset: 0xd272
// Size: 0xf2
function private grant_field_upgrade( var_c56b6ee6272e1ddf )
{
    str_super_ref = var_c56b6ee6272e1ddf.data;
    
    if ( !isdefined( str_super_ref ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x84f>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x84f>" );
            }
        #/
        
        return;
    }
    
    perkpackage::perkpackage_giveimmediate( str_super_ref, undefined, undefined, undefined, 0 );
    perkpackage::perkpackage_reset();
    self.var_553655096f6ba26 = 1;
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    
    if ( isdefined( var_c0c4324d255baab3 ) )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, 1 );
        var_c56b6ee6272e1ddf.loot_id = challenges::getweaponlootid( var_c0c4324d255baab3.weaponobj, var_c0c4324d255baab3.weaponobj.basename );
    }
    
    /#
        iprintlnbold( "<dev string:x87f>" + str_super_ref );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xde54ffa6, Offset: 0xd36c
// Size: 0x11f
function private grant_augment( var_c56b6ee6272e1ddf )
{
    augment_ref = var_c56b6ee6272e1ddf.data;
    
    if ( !isdefined( augment_ref ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x897>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x897>" );
            }
        #/
        
        return;
    }
    
    a_eligible = function_a877932ca0ed606d();
    
    if ( !a_eligible.size )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x8bb>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x8bb>" );
            }
        #/
        
        return;
    }
    
    if ( !arraycontains( a_eligible, augment_ref ) )
    {
        augment_ref = a_eligible[ randomint( a_eligible.size ) ];
    }
    
    zombie_augments::function_a049aaca693a5205( augment_ref );
    function_2f25da4ec76a951a( augment_ref );
    loot_id = function_ab83a25610815a07( augment_ref );
    var_c56b6ee6272e1ddf.loot_id = loot_id ?? 0;
    
    /#
        iprintlnbold( "<dev string:x90c>" + augment_ref );
    #/
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0x588cc8fc, Offset: 0xd493
// Size: 0x50
function function_1a2d26e16b6aebcf( str_type )
{
    if ( !function_56c22f196c66c161( str_type ) )
    {
        return;
    }
    
    var_1344b6c6ccd6e526 = { #max_round:999, #min_round:1, #type:str_type };
    return function_28e6b54a7fe6513f( var_1344b6c6ccd6e526 );
}

// Namespace zm_rb_echo
// Params 2
// Checksum 0x5996ce03, Offset: 0xd4ec
// Size: 0x25d
function function_eae81e972be31ab5( var_8b05c0691aa5983a, var_31c77814d3f874c3 = [] )
{
    var_9824f4f7d5730ff0 = [];
    
    foreach ( var_525d68f6005d678b in level.var_e8b652abd3805da2 )
    {
        foreach ( str_type in var_525d68f6005d678b )
        {
            if ( str_type == "loadout_refill" || str_type == "weapon" || str_type == "essence" )
            {
                continue;
            }
            
            if ( !arraycontains( var_9824f4f7d5730ff0, str_type ) )
            {
                var_9824f4f7d5730ff0[ var_9824f4f7d5730ff0.size ] = str_type;
            }
        }
    }
    
    var_838c31c163be5a72 = [];
    var_bab2f0324c3fa22b = [];
    
    while ( true )
    {
        var_3309d0eaa7261604 = arraycombine( var_8b05c0691aa5983a ?? [], var_838c31c163be5a72 );
        var_1ac62513a1e7fe07 = arraycombine( var_31c77814d3f874c3 ?? [], var_bab2f0324c3fa22b );
        var_a05268f65a66e130 = function_831ae0f272db49b7( var_3309d0eaa7261604, var_9824f4f7d5730ff0, 1 );
        
        if ( !isdefined( var_a05268f65a66e130 ) )
        {
            return;
        }
        
        var_1344b6c6ccd6e526 = level.var_f6902967d180948a[ var_a05268f65a66e130 ];
        var_c56b6ee6272e1ddf = function_28e6b54a7fe6513f( var_1344b6c6ccd6e526, 1, var_1ac62513a1e7fe07 );
        
        if ( isdefined( var_c56b6ee6272e1ddf ) && !function_e60f07f125bb1a2c( var_c56b6ee6272e1ddf, var_1ac62513a1e7fe07 ) && function_1efb7e2d21257d7f( var_c56b6ee6272e1ddf ) )
        {
            var_c56b6ee6272e1ddf.config_index = var_a05268f65a66e130;
            return var_c56b6ee6272e1ddf;
        }
        
        if ( isdefined( var_c56b6ee6272e1ddf ) && function_11abdf7a1ef79552( var_c56b6ee6272e1ddf.type ) && isdefined( var_c56b6ee6272e1ddf.data ) )
        {
            var_bab2f0324c3fa22b[ var_bab2f0324c3fa22b.size ] = { #data:var_c56b6ee6272e1ddf.data, #type:var_c56b6ee6272e1ddf.type };
            continue;
        }
        
        var_838c31c163be5a72[ var_838c31c163be5a72.size ] = var_a05268f65a66e130;
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xb3fb2412, Offset: 0xd751
// Size: 0xbb, Type: bool
function private function_e60f07f125bb1a2c( var_c56b6ee6272e1ddf, var_31c77814d3f874c3 )
{
    foreach ( var_702f1727c2bd4ea0 in var_31c77814d3f874c3 ?? [] )
    {
        if ( var_702f1727c2bd4ea0.type == var_c56b6ee6272e1ddf.type && var_702f1727c2bd4ea0.data == var_c56b6ee6272e1ddf.data )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xb5edd638, Offset: 0xd815
// Size: 0x20, Type: bool
function private function_11abdf7a1ef79552( str_type )
{
    return str_type == "perk" || str_type == "augment";
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0x213cc57d, Offset: 0xd83e
// Size: 0x1e4
function function_1efb7e2d21257d7f( var_c56b6ee6272e1ddf )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) || !function_56c22f196c66c161( var_c56b6ee6272e1ddf.type ) )
    {
        return 0;
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_be4e031e7acb7b74":
            weapon = self getcurrentweapon();
            return ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( weapon ) && weapon != level.weaponnone && ammo_mod::function_7bbc1db07694f31d( weapon ) && !player_has_ammo_mod( var_c56b6ee6272e1ddf.data ) );
        case #"hash_ac7114576080f3cf":
            return isdefined( var_c56b6ee6272e1ddf.data );
        case #"hash_c7320b84b20ec6ae":
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            return function_d072bbe5cb36b391( var_c56b6ee6272e1ddf );
        case #"hash_ab671284a3fc4e3d":
            return function_44dddd0482cce54( var_c56b6ee6272e1ddf.data );
        case #"hash_b60679835e82a584":
            return isdefined( var_c56b6ee6272e1ddf.data );
        case #"hash_47611497d0263858":
            var_9e9cac9f003de860 = function_a877932ca0ed606d();
            return ( isdefined( var_c56b6ee6272e1ddf.data ) && arraycontains( var_9e9cac9f003de860, var_c56b6ee6272e1ddf.data ) );
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            return isdefined( var_c56b6ee6272e1ddf.data );
        default:
            return 1;
    }
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0xdf421909, Offset: 0xda2a
// Size: 0x93
function function_dd46dff1f32f74d2()
{
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone || !pack_a_punch::can_pap( weapon ) )
    {
        return;
    }
    
    var_b68b19d9aed8b14e = function_f4bc24729fcdafca();
    n_target_level = int( clamp( pack_a_punch::get_pap_level( weapon ) + 1, 1, var_b68b19d9aed8b14e ) );
    
    if ( !function_f1243ac0dfad8595( n_target_level ) )
    {
        return;
    }
    
    return { #data:n_target_level, #type:"pap" + n_target_level };
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0x47def98c, Offset: 0xdac6
// Size: 0x1e
function function_ede012a042a1e475( var_c56b6ee6272e1ddf )
{
    function_99c679ed8d8117ea( var_c56b6ee6272e1ddf );
    grant_reward( var_c56b6ee6272e1ddf );
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0xd6e4e43f, Offset: 0xdaec
// Size: 0x15a, Type: bool
function function_88e35cca694c6fcd( b_check_only = 0 )
{
    var_e9eea6904ed4db95 = [];
    
    foreach ( str_perk in [ "specialty_juggernog", "specialty_quickrevive", "specialty_speedcola", "specialty_staminup", "specialty_deadshot", "specialty_death_perception", "specialty_elemental_pop", "specialty_phd_flopper", "specialty_vulture_aid", "specialty_m_mod", "specialty_d_mod", "specialty_w_mod", "specialty_y_mod" ] )
    {
        if ( !zombie_perks::has_permanent_perk( str_perk ) )
        {
            var_e9eea6904ed4db95[ var_e9eea6904ed4db95.size ] = str_perk;
        }
    }
    
    if ( b_check_only )
    {
        return ( var_e9eea6904ed4db95.size > 0 );
    }
    
    if ( !var_e9eea6904ed4db95.size )
    {
        return false;
    }
    
    var_c56b6ee6272e1ddf = { #data:utility::array_random( var_e9eea6904ed4db95 ), #type:"perk" };
    grant_perk( var_c56b6ee6272e1ddf, 1 );
    return true;
}

// Namespace zm_rb_echo
// Params 2
// Checksum 0x145d9c63, Offset: 0xdc4f
// Size: 0x93
function function_2aff2760352e7afe( n_count, b_check_only = 0 )
{
    if ( b_check_only )
    {
        return ( function_a877932ca0ed606d().size >= n_count );
    }
    
    for ( i = 0; i < n_count ; i++ )
    {
        if ( !function_6c4071607fa7a402() )
        {
            break;
        }
        
        var_c56b6ee6272e1ddf = function_28e6b54a7fe6513f( { #max_round:999, #min_round:1, #type:"augment" } );
        grant_augment( var_c56b6ee6272e1ddf );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x97a0575f, Offset: 0xdcea
// Size: 0x2f
function private function_9bc1a1ca30592294()
{
    if ( isdefined( level.var_81a2e10a67d09162.on_round_ended ) )
    {
        [[ level.var_81a2e10a67d09162.on_round_ended ]]();
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x41804fe9, Offset: 0xdd21
// Size: 0x3b
function private function_913dfa5d96a49920( var_e988b54247727114 )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_375848ddb8abe1df ) )
    {
        [[ level.var_81a2e10a67d09162.var_375848ddb8abe1df ]]( var_e988b54247727114 );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x297bf96e, Offset: 0xdd64
// Size: 0x3c
function private function_50a1f2c9e3033a00( n_index )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_c6fba96d642a7b92 ) )
    {
        return [[ level.var_81a2e10a67d09162.var_c6fba96d642a7b92 ]]( n_index );
    }
    
    return 0;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xec185b63, Offset: 0xdda9
// Size: 0x30
function private function_ec07079d2ddad4f2()
{
    if ( isdefined( level.var_81a2e10a67d09162.var_c79c923e01fbe78c ) )
    {
        return [[ level.var_81a2e10a67d09162.var_c79c923e01fbe78c ]]();
    }
    
    return 0;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x83920126, Offset: 0xdde2
// Size: 0x3b
function private function_f83947c2133aee9b( player )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_f481b13005658611 ) )
    {
        return [[ level.var_81a2e10a67d09162.var_f481b13005658611 ]]( player );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x1575e45d, Offset: 0xde25
// Size: 0x45
function private function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) || !isdefined( level.var_81a2e10a67d09162.is_event_reward ) )
    {
        return 0;
    }
    
    return [[ level.var_81a2e10a67d09162.is_event_reward ]]( var_c56b6ee6272e1ddf );
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x8dd7eadb, Offset: 0xde73
// Size: 0x45
function private function_6373aa10b19ac19c( e_scriptable, var_c56b6ee6272e1ddf )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_9ed3cff4a938b546 ) )
    {
        [[ level.var_81a2e10a67d09162.var_9ed3cff4a938b546 ]]( e_scriptable, var_c56b6ee6272e1ddf );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x58fdf7d9, Offset: 0xdec0
// Size: 0x2f
function private function_367fe1cb552a24f4()
{
    if ( isdefined( level.var_81a2e10a67d09162.get_sign_config ) )
    {
        return [[ level.var_81a2e10a67d09162.get_sign_config ]]();
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x4a65ee66, Offset: 0xdef7
// Size: 0x3b
function private function_dc19656d2fcd8e29( var_c56b6ee6272e1ddf )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_f3a5e6cbc419005e ) )
    {
        return [[ level.var_81a2e10a67d09162.var_f3a5e6cbc419005e ]]( var_c56b6ee6272e1ddf );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xf35167c1, Offset: 0xdf3a
// Size: 0x40
function private function_35d43d80df260198( var_c56b6ee6272e1ddf )
{
    if ( isdefined( level.var_81a2e10a67d09162.get_display_name ) )
    {
        return [[ level.var_81a2e10a67d09162.get_display_name ]]( var_c56b6ee6272e1ddf );
    }
    
    return "Event Reward";
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb36b7b56, Offset: 0xdf83
// Size: 0x30
function private function_a90c5330e4b4abdc()
{
    if ( isdefined( level.var_81a2e10a67d09162.get_debug_rewards ) )
    {
        return [[ level.var_81a2e10a67d09162.get_debug_rewards ]]( self );
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xfadd0e5e, Offset: 0xdfbb
// Size: 0x45
function private function_7361be97a6acf949( player, var_c56b6ee6272e1ddf )
{
    if ( isdefined( level.var_81a2e10a67d09162.var_1ada6fc7442ee783 ) )
    {
        [[ level.var_81a2e10a67d09162.var_1ada6fc7442ee783 ]]( player, var_c56b6ee6272e1ddf );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x960e7fb0, Offset: 0xe008
// Size: 0x25c
function private function_2f25da4ec76a951a( augment_ref )
{
    self endon( #"death_or_disconnect" );
    str_perk = undefined;
    
    foreach ( str_candidate, a_augments in level.var_98451248a70b7bb3 )
    {
        if ( arraycontains( a_augments, augment_ref ) )
        {
            str_perk = str_candidate;
            break;
        }
    }
    
    if ( !str_perk )
    {
        return;
    }
    
    if ( !zombie_perks::has_perk( str_perk ) )
    {
        return;
    }
    
    var_554891e1d9670449 = undefined;
    
    for ( i = 0; i < self.perks_active.size ; i++ )
    {
        if ( self.perks_active[ i ] == str_perk )
        {
            var_554891e1d9670449 = i;
            break;
        }
    }
    
    if ( !isdefined( var_554891e1d9670449 ) )
    {
        return;
    }
    
    var_984ebb42c4a9a697 = isdefined( self.perma_perks ) && arraycontains( self.perma_perks, str_perk );
    var_f5b73cb40aba92fc = isdefined( self.perkspurchased ) && self.perkspurchased[ str_perk ];
    zombie_perks::take_perk( str_perk, 1 );
    var_737a50c9a105dbd3 = isdefined( self.perma_perks ) && arraycontains( self.perma_perks, str_perk );
    var_7b297e17d8615058 = var_984ebb42c4a9a697 && !var_737a50c9a105dbd3;
    waitframe();
    zombie_perks::give_perk( str_perk, var_f5b73cb40aba92fc, 0, var_554891e1d9670449, var_7b297e17d8615058 );
    
    if ( var_554891e1d9670449 == 0 && self.perks_active[ 0 ] != str_perk )
    {
        a_fixed = [ str_perk ];
        
        foreach ( perk in self.perks_active )
        {
            if ( perk != str_perk )
            {
                a_fixed[ a_fixed.size ] = perk;
            }
        }
        
        self.perks_active = a_fixed;
        zombie_perks::function_c11ba4bb3d0a676b();
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xf22cabf6, Offset: 0xe26c
// Size: 0x219
function private grant_loadout_refill( var_c56b6ee6272e1ddf )
{
    weapons = self getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapon::iskillstreakweapon( weapon ) )
        {
            continue;
        }
        
        var_83e55048826dcd05 = self getweaponammoclip( weapon );
        var_b11feea92c35d08e = weaponclipsize( weapon );
        
        if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
        {
            self setweaponammoclip( weapon, var_b11feea92c35d08e );
        }
        
        self givemaxammo( weapon );
        
        if ( weapon.hasalternate && !weapon::function_33e74163843b348e( weapon ) )
        {
            weaponaltobj = weapon getaltweapon();
            max_ammo_alt = utility::get_max_stock_ammo( weaponaltobj, 0 );
            self setweaponammostock( weaponaltobj, max_ammo_alt );
            n_clip_current_alt = self getweaponammoclip( weaponaltobj );
            n_clip_max_alt = weaponclipsize( weaponaltobj );
            
            if ( n_clip_current_alt < n_clip_max_alt )
            {
                self setweaponammoclip( weaponaltobj, n_clip_max_alt );
            }
        }
    }
    
    primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
    var_382c92ced2f61c35 = equipment_mp::getequipmentmaxammo( primary_equip_ref );
    equipment_mp::setequipmentammo( primary_equip_ref, var_382c92ced2f61c35 );
    secondary_equip_ref = equipment_mp::getcurrentequipment( "secondary" );
    var_f9720a7bbc3dc8a5 = equipment_mp::getequipmentmaxammo( secondary_equip_ref );
    equipment_mp::setequipmentammo( secondary_equip_ref, var_f9720a7bbc3dc8a5 );
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    
    if ( isdefined( var_c0c4324d255baab3 ) && !var_c0c4324d255baab3.isinuse )
    {
        target_points = supers_mp::getsuperpointsneeded();
        current_points = supers_mp::getcurrentsuperpoints();
        var_d532e397ecea6843 = target_points - current_points;
        
        if ( var_d532e397ecea6843 > 0 )
        {
            supers_mp::givesuperpoints( var_d532e397ecea6843, undefined, 1 );
        }
    }
    
    /#
        iprintlnbold( "<dev string:x91e>" );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x196f91dc, Offset: 0xe48d
// Size: 0x63
function private grant_armor_upgrade( var_c56b6ee6272e1ddf )
{
    n_current_level = self.platecarrierlevel ?? 1;
    var_779deb3bbfb339c4 = int( clamp( n_current_level + 1, 1, 3 ) );
    namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( var_779deb3bbfb339c4 );
    
    /#
        iprintlnbold( "<dev string:x935>" + n_current_level + "<dev string:x946>" + var_779deb3bbfb339c4 );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xe8ac4664, Offset: 0xe4f8
// Size: 0xfe
function private grant_golden_armor( var_c56b6ee6272e1ddf )
{
    b_no_armor = isdefined( level.zm_mode_modifiers ) && level.zm_mode_modifiers.var_2dc492758425fa76;
    utility::callsharedfunc( #"zombie", #"set_golden_armor" );
    self.platecarrierlevel = 3;
    var_3dc0c4e27d22d986 = level.var_1e9e024bcfca2274.var_c02aad60bddb8f16 ?? 501;
    self.maxarmorhealth = var_3dc0c4e27d22d986;
    armor::setarmorhealth( var_3dc0c4e27d22d986 );
    self setclientomnvar( "ui_armor_current_level", self.platecarrierlevel );
    
    if ( b_no_armor )
    {
        self setclientomnvar( "ui_show_armor_global", 1 );
        params = spawnstruct();
        params.player = self;
        params.activate = 1;
        callback::callback( "toggle_squad_armor", params );
    }
    
    /#
        iprintlnbold( "<dev string:x94b>" );
    #/
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x50aea5bd, Offset: 0xe5fe
// Size: 0x3e5
function private grant_weapon_class( var_c56b6ee6272e1ddf, b_skip_inspect = 0 )
{
    s_data = var_c56b6ee6272e1ddf.data;
    str_class = s_data.class;
    n_rarity = s_data.rarity;
    itemspawnlist = level.var_feed53d8447f7479[ str_class ][ n_rarity ];
    
    if ( !isdefined( itemspawnlist ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x972>" + str_class + "<dev string:x9a8>" + n_rarity );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x972>" + str_class + "<dev string:x9a8>" + n_rarity );
            }
        #/
        
        return;
    }
    
    a_bundles = common_item::items_selectfromlist( itemspawnlist, 1 );
    
    if ( !a_bundles.size )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x9b1>" + str_class );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x9b1>" + str_class );
            }
        #/
        
        return;
    }
    
    item_bundle_name = a_bundles[ 0 ];
    item_bundle = getscriptbundle( item_bundle_name );
    
    if ( !isdefined( item_bundle ) || !isdefined( item_bundle.baseweapon ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x9e6>" + item_bundle_name );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x9e6>" + item_bundle_name );
            }
        #/
        
        return;
    }
    
    weapon = item_weapon::function_477bf1207c6672a5( item_bundle, {} );
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:xa1b>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:xa1b>" );
            }
        #/
        
        return;
    }
    
    favoriteweapon = weaponmetadata::function_c68204eff69ed046( item_bundle.baseweapon );
    
    if ( isdefined( favoriteweapon ) )
    {
        weapon = favoriteweapon;
    }
    
    var_dc6239c3be0e0d0c = undefined;
    var_77f211b45c8727a1 = self getweaponslistprimaries();
    
    foreach ( held_weapon in var_77f211b45c8727a1 )
    {
        if ( !weapon::iswonderweapon( held_weapon ) && !weapon::iscurrenttertiaryweapon( self, held_weapon ) )
        {
            if ( !isdefined( var_dc6239c3be0e0d0c ) )
            {
                var_4c506782108851c7 = ammo_mod::get_ammo_mod_name( held_weapon );
                
                if ( var_4c506782108851c7 )
                {
                    var_dc6239c3be0e0d0c = var_4c506782108851c7;
                }
            }
            
            self takeweapon( held_weapon );
        }
    }
    
    self giveweapon( weapon );
    self givemaxammo( weapon );
    self switchtoweapon( weapon );
    item_weapon::function_40e1cbd0e1f47d1a( weapon, n_rarity );
    
    if ( isdefined( s_data.pap_level ) )
    {
        weapon = pack_a_punch::pap_weapon( weapon, s_data.pap_level );
    }
    
    if ( isdefined( var_dc6239c3be0e0d0c ) && ammo_mod::function_7bbc1db07694f31d( weapon ) )
    {
        weapon = ammo_mod::add_ammo_mod_to_weapon( weapon, var_dc6239c3be0e0d0c );
    }
    
    if ( !b_skip_inspect )
    {
        thread function_be3ccd58e8322f2b();
    }
    
    var_c56b6ee6272e1ddf.loot_id = challenges::getweaponlootid( weapon, weapon.basename );
    
    /#
        var_fe5ee3c04516d794 = "<dev string:x82d>";
        
        if ( isdefined( s_data.pap_level ) )
        {
            var_fe5ee3c04516d794 = "<dev string:xa52>" + s_data.pap_level;
        }
        
        iprintlnbold( "<dev string:xa57>" + str_class + "<dev string:x9a8>" + n_rarity + var_fe5ee3c04516d794 );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x31eccf48, Offset: 0xe9eb
// Size: 0x382
function private grant_weapon_melee( var_c56b6ee6272e1ddf )
{
    s_data = var_c56b6ee6272e1ddf.data;
    str_class = s_data.class;
    n_rarity = s_data.rarity;
    itemspawnlist = level.var_feed53d8447f7479[ str_class ][ n_rarity ];
    
    if ( !isdefined( itemspawnlist ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:xa7b>" + str_class + "<dev string:x9a8>" + n_rarity );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:xa7b>" + str_class + "<dev string:x9a8>" + n_rarity );
            }
        #/
        
        return;
    }
    
    a_bundles = common_item::items_selectfromlist( itemspawnlist, 1 );
    
    if ( !a_bundles.size )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:xab1>" + str_class );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:xab1>" + str_class );
            }
        #/
        
        return;
    }
    
    item_bundle_name = a_bundles[ 0 ];
    item_bundle = getscriptbundle( item_bundle_name );
    
    if ( !isdefined( item_bundle ) || !isdefined( item_bundle.baseweapon ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:xae6>" + item_bundle_name );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:xae6>" + item_bundle_name );
            }
        #/
        
        return;
    }
    
    weapon = item_weapon::function_477bf1207c6672a5( item_bundle, {} );
    
    if ( !isdefined( weapon ) || weapon == level.weaponnone )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:xb1b>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:xb1b>" );
            }
        #/
        
        return;
    }
    
    favoriteweapon = weaponmetadata::function_c68204eff69ed046( item_bundle.baseweapon );
    
    if ( isdefined( favoriteweapon ) )
    {
        weapon = favoriteweapon;
    }
    
    var_dc6239c3be0e0d0c = undefined;
    
    if ( isdefined( self.var_cc1262e66dbb1c79 ) && self hasweapon( self.var_cc1262e66dbb1c79 ) )
    {
        var_4c506782108851c7 = ammo_mod::get_ammo_mod_name( self.var_cc1262e66dbb1c79 );
        
        if ( var_4c506782108851c7 )
        {
            var_dc6239c3be0e0d0c = var_4c506782108851c7;
        }
        
        self takeweapon( self.var_cc1262e66dbb1c79 );
        self.var_cc1262e66dbb1c79 = undefined;
    }
    
    self giveweapon( weapon );
    self assignweaponmeleeslot( weapon );
    self switchtoweapon( weapon );
    self.var_cc1262e66dbb1c79 = weapon;
    item_weapon::function_40e1cbd0e1f47d1a( weapon, n_rarity );
    
    if ( isdefined( s_data.pap_level ) )
    {
        weapon = pack_a_punch::pap_weapon( weapon, s_data.pap_level );
    }
    
    if ( isdefined( var_dc6239c3be0e0d0c ) && ammo_mod::function_7bbc1db07694f31d( weapon ) )
    {
        weapon = ammo_mod::add_ammo_mod_to_weapon( weapon, var_dc6239c3be0e0d0c );
        weapon::function_b4c9549dee5d0fc5( weapon );
    }
    
    thread function_be3ccd58e8322f2b();
    var_c56b6ee6272e1ddf.loot_id = challenges::getweaponlootid( weapon, weapon.basename );
    
    /#
        var_fe5ee3c04516d794 = "<dev string:x82d>";
        
        if ( isdefined( s_data.pap_level ) )
        {
            var_fe5ee3c04516d794 = "<dev string:xa52>" + s_data.pap_level;
        }
        
        iprintlnbold( "<dev string:xb52>" + str_class + "<dev string:x9a8>" + n_rarity + var_fe5ee3c04516d794 );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xad8870a7, Offset: 0xed75
// Size: 0x8c
function private function_be3ccd58e8322f2b()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self forceweaponinspect();
    waitframe();
    
    while ( self function_985124b0e1e74f2e() )
    {
        if ( self usebuttonpressed() || self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            break;
        }
        
        waitframe();
    }
    
    val::set( "echo_force_inspect", "weapon_inspect", 0 );
    waitframe();
    val::reset( "echo_force_inspect", "weapon_inspect" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x8c9f7d8e, Offset: 0xee09
// Size: 0x1c
function private function_1743d8e97e350646()
{
    level utility::flag_init( "echo_challenge_active" );
    level utility::flag_init( "echo_challenge_complete" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x4a3774ad, Offset: 0xee2d
// Size: 0x1f4
function private function_4dd7b85873427fd()
{
    level.var_d0ac5374bbc2b3a0 = [ { #reward:"extra_portal", #progress_name:"progress", #achievement_id:71012, #key:"extra_portal" }, { #reward:"extra_portal_2", #progress_name:"progress", #achievement_id:71007, #key:"extra_portal_2" }, { #reward:"start_pistol_uncommon", #progress_name:"progress", #achievement_id:71018, #key:"start_pistol_uncommon" }, { #reward:"start_pistol_rare", #progress_name:"progress", #achievement_id:71020, #key:"start_pistol_rare" }, { #reward:"unlock_pap_crystals", #progress_name:"progress", #achievement_id:71011, #key:"unlock_pap_crystals" }, { #reward:"unlock_aether_tools", #progress_name:"progress", #achievement_id:71004, #key:"unlock_aether_tools" }, { #reward:"unlock_armor_upgrade", #progress_name:"progress", #achievement_id:71019, #key:"unlock_armor_upgrade" }, { #reward:"unlock_wonder_weapons", #progress_name:"progress", #achievement_id:71003, #key:"unlock_wonder_weapons" } ];
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xdbb0ee60, Offset: 0xf029
// Size: 0xef
function private function_302abc17beca67c2( params )
{
    self.var_10553c552a4c4f22 = [];
    self.var_2d3554bb80c816e2 = 0;
    
    foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
    {
        if ( var_5dc3a271f3cb3d31.achievement_id > 0 )
        {
            if ( !arraycontains( self.var_10553c552a4c4f22, var_5dc3a271f3cb3d31.achievement_id ) )
            {
                self.var_10553c552a4c4f22[ self.var_10553c552a4c4f22.size ] = var_5dc3a271f3cb3d31.achievement_id;
            }
            
            playerachievements::getstate( self, var_5dc3a271f3cb3d31.achievement_id );
        }
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x285f906a, Offset: 0xf120
// Size: 0x1b8
function private function_3b20acf2a09b6561( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_e0b80cc615b06c35 ) )
    {
        self.var_e0b80cc615b06c35 = [];
    }
    
    var_5c631378cd122aa7 = 0;
    
    foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
    {
        if ( params.achievementid != var_5dc3a271f3cb3d31.achievement_id )
        {
            continue;
        }
        
        var_5c631378cd122aa7 = 1;
        var_3471316e3ec32d4a = playerachievements::function_ce48098d17912e1f( self, var_5dc3a271f3cb3d31.achievement_id, var_5dc3a271f3cb3d31.progress_name, 0 );
        self.var_e0b80cc615b06c35[ var_5dc3a271f3cb3d31.key ] = var_3471316e3ec32d4a > 0;
        
        /#
            if ( var_3471316e3ec32d4a > 0 )
            {
                iprintlnbold( "<dev string:xb76>" + self.name + "<dev string:xb8a>" + var_5dc3a271f3cb3d31.key + "<dev string:x64>" );
            }
        #/
        
        break;
    }
    
    if ( !var_5c631378cd122aa7 )
    {
        return;
    }
    
    var_6ac431935948a266 = arraycontains( self.var_10553c552a4c4f22, params.achievementid );
    
    if ( var_6ac431935948a266 )
    {
        self.var_10553c552a4c4f22 = arrayremove( self.var_10553c552a4c4f22, params.achievementid );
    }
    
    if ( var_6ac431935948a266 && !self.var_10553c552a4c4f22.size )
    {
        self.var_2d3554bb80c816e2 = 1;
        function_ccfdc1c153aef79();
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x75b16563, Offset: 0xf2e0
// Size: 0x30
function private function_63338426a835291()
{
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_2d3554bb80c816e2 )
    {
        return;
    }
    
    wait 3;
    self.var_2d3554bb80c816e2 = 0;
    function_99aaa70d7f22bb69();
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xb5bff462, Offset: 0xf318
// Size: 0x21
function private function_9d160b85ae107fc3( player )
{
    player thread hud_message::showsplash( "zm_rb_echo_perm_unlock_all", -1, player, undefined, 1 );
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x482b55dc, Offset: 0xf341
// Size: 0x29
function private function_5495d51c70af0e5c( player, achievement_id )
{
    player thread hud_message::showsplash( "zm_rb_echo_perm_unlock_single", achievement_id, player, undefined, 1 );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xa8defeec, Offset: 0xf372
// Size: 0x1f4
function private function_99aaa70d7f22bb69( var_3a098b1687206f5a = undefined )
{
    n_total_challenges = level.var_d0ac5374bbc2b3a0.size;
    n_completed = 0;
    var_2982dbdde5536337 = [];
    
    foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
    {
        if ( self.var_e0b80cc615b06c35[ var_5dc3a271f3cb3d31.key ] == 1 )
        {
            n_completed++;
            var_2982dbdde5536337[ var_2982dbdde5536337.size ] = var_5dc3a271f3cb3d31;
        }
    }
    
    if ( n_completed <= 0 || n_total_challenges <= 0 )
    {
        return;
    }
    
    if ( n_completed == n_total_challenges )
    {
        function_9d160b85ae107fc3( self );
        return;
    }
    
    var_99b74c3a86ff5853 = var_2982dbdde5536337;
    
    if ( isdefined( var_3a098b1687206f5a ) )
    {
        var_99b74c3a86ff5853 = [];
        
        foreach ( var_5dc3a271f3cb3d31 in var_2982dbdde5536337 )
        {
            if ( arraycontains( var_3a098b1687206f5a, var_5dc3a271f3cb3d31.key ) )
            {
                var_99b74c3a86ff5853[ var_99b74c3a86ff5853.size ] = var_5dc3a271f3cb3d31;
            }
        }
    }
    
    foreach ( var_5dc3a271f3cb3d31 in var_99b74c3a86ff5853 )
    {
        function_5495d51c70af0e5c( self, var_5dc3a271f3cb3d31.achievement_id );
    }
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0xb9f82ce3, Offset: 0xf56e
// Size: 0x37, Type: bool
function function_ca8ffa3d9e0d16c9( str_key )
{
    if ( function_ba307b8ec163444b() )
    {
        return true;
    }
    
    if ( !isdefined( self.var_e0b80cc615b06c35 ) )
    {
        return false;
    }
    
    return self.var_e0b80cc615b06c35[ str_key ] == 1;
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0x354c5d9f, Offset: 0xf5ae
// Size: 0x2c, Type: bool
function function_ba307b8ec163444b()
{
    /#
        if ( isplayer( self ) && getdvarint( @"hash_26059b36e3d000a4", 0 ) && self ishost() )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0x235b69c7, Offset: 0xf5e3
// Size: 0x35, Type: bool
function function_2651dec385c4959( n_required_tier )
{
    if ( function_ba307b8ec163444b() )
    {
        return true;
    }
    
    n_relic_tier = level.zm_relic_tier ?? 0;
    return n_relic_tier >= n_required_tier;
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0x21c5ea0a, Offset: 0xf621
// Size: 0x12
function function_e86e9a96bffedef9()
{
    if ( function_2651dec385c4959( 2 ) )
    {
        return 5;
    }
    
    return 4;
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0xb4a66dc7, Offset: 0xf63c
// Size: 0x12
function function_f4bc24729fcdafca()
{
    if ( function_2651dec385c4959( 3 ) )
    {
        return 4;
    }
    
    return 3;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xa6ff8aad, Offset: 0xf657
// Size: 0xfc
function private function_b3f172e87980986( var_33a8fe8c60ffc725 )
{
    switch ( var_33a8fe8c60ffc725 )
    {
        case 1:
            str_splash = #"hash_311daa619f31ebda";
            break;
        case 2:
            str_splash = #"hash_bfb53fe0bfcb8ec2";
            break;
        case 3:
            str_splash = #"hash_f88b3d2ef10dd8b5";
            break;
        default:
            return;
    }
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player thread hud_message::showsplash( str_splash );
        }
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0xc
// Checksum 0x52bfd4f8, Offset: 0xf75b
// Size: 0x43
function private function_6e4066f97409fbef()
{
    self notify( #"hash_fb58190d97406c41" );
    self endon( #"hash_fb58190d97406c41" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_e9e3249a0ac480ad" );
        level thread function_e999a847057399af();
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0xc
// Checksum 0x429fe734, Offset: 0xf7a6
// Size: 0x9b
function private function_e999a847057399af()
{
    self notify( #"hash_a510ce4f2e622b74" );
    self endon( #"hash_a510ce4f2e622b74" );
    level endon( #"game_ended" );
    n_relic_tier = level.zm_relic_tier ?? 0;
    var_ed98aaf1356a7ab = level.var_1bc7a9eda89a078d ?? 0;
    
    if ( n_relic_tier <= var_ed98aaf1356a7ab )
    {
        return;
    }
    
    for ( var_33a8fe8c60ffc725 = var_ed98aaf1356a7ab + 1; var_33a8fe8c60ffc725 <= n_relic_tier ; var_33a8fe8c60ffc725++ )
    {
        function_b3f172e87980986( var_33a8fe8c60ffc725 );
        
        if ( var_33a8fe8c60ffc725 < n_relic_tier )
        {
            wait 0.5;
        }
    }
    
    level.var_1bc7a9eda89a078d = n_relic_tier;
}

// Namespace zm_rb_echo
// Params 1
// Checksum 0xc7f7e008, Offset: 0xf849
// Size: 0x10e
function function_d4c6517cd433db41( str_key )
{
    if ( !isdefined( self.var_e0b80cc615b06c35 ) )
    {
        self.var_e0b80cc615b06c35 = [];
    }
    
    if ( self.var_e0b80cc615b06c35[ str_key ] == 1 )
    {
        return;
    }
    
    self.var_e0b80cc615b06c35[ str_key ] = 1;
    function_99aaa70d7f22bb69( [ str_key ] );
    
    foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
    {
        if ( var_5dc3a271f3cb3d31.key == str_key )
        {
            function_6068a7bd5b1b3cee( var_5dc3a271f3cb3d31.reward );
            break;
        }
    }
    
    /#
        iprintlnbold( "<dev string:xb76>" + self.name + "<dev string:xb8a>" + str_key + "<dev string:x64>" );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x8e06032, Offset: 0xf95f
// Size: 0x19b
function private function_6068a7bd5b1b3cee( str_reward_type )
{
    switch ( str_reward_type )
    {
        case #"hash_e01b8310a704ce38":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xbae>" );
            #/
            
            break;
        case #"hash_2fb83b766823a835":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xbdf>" );
            #/
            
            break;
        case #"hash_4a5a390dce3cd9ba":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xc17>" );
            #/
            
            break;
        case #"hash_dafb2d4bd3cd8928":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xc51>" );
            #/
            
            break;
        case #"hash_8a6906b76942f927":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xc87>" );
            #/
            
            break;
        case #"hash_f3d69017f07ea357":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xcbf>" );
            #/
            
            break;
        case #"hash_50ba50863a6587f6":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xcf7>" );
            #/
            
            break;
        case #"hash_c40477ad8ea68c3b":
            /#
                iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:xd30>" );
            #/
            
            break;
        default:
            /#
                iprintlnbold( "<dev string:xd6a>" + str_reward_type + "<dev string:x64>" );
            #/
            
            break;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xc69b2497, Offset: 0xfb02
// Size: 0x2a, Type: bool
function private is_challenge_round( n_round = level.round_number )
{
    if ( n_round % 5 == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x47970249, Offset: 0xfb35
// Size: 0x19, Type: bool
function private is_next_round_challenge()
{
    return is_challenge_round( ( level.round_number ?? 1 ) + 1 );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xa4d9c9ea, Offset: 0xfb57
// Size: 0x35
function private is_boss_round( n_round = level.round_number )
{
    return arraycontains( level.var_ff633893b6fa75c3.var_272915a5526bc115, n_round );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x9f5696f9, Offset: 0xfb95
// Size: 0x20
function private function_f6dcea1f3c112eed( params )
{
    namespace_1fd313b1d0d63e6b::function_d690ddb7282b79d6();
    level utility::flag_set( "echo_challenge_complete" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x8cbe5e41, Offset: 0xfbbd
// Size: 0x9
function private function_4b2985c54da15df0()
{
    namespace_1fd313b1d0d63e6b::function_4af0d452f670d77b();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2f43f6a3, Offset: 0xfbce
// Size: 0x9
function private function_4e56b1c0b59df2fb()
{
    namespace_1fd313b1d0d63e6b::boss_fight_abom();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2a65f4c7, Offset: 0xfbdf
// Size: 0x9
function private function_a859b8fe6bb38a40()
{
    namespace_1fd313b1d0d63e6b::boss_fight_amalgam();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xc37b259c, Offset: 0xfbf0
// Size: 0x144
function private function_cca1baadf44f49dc()
{
    level utility::flag_set( "echo_challenge_active" );
    level utility::flag_clear( "echo_challenge_complete" );
    
    /#
        if ( is_boss_round( level.round_number + 1 ) )
        {
            iprintlnbold( "<dev string:xd96>" + level.round_number + "<dev string:xdae>" + level.var_ff633893b6fa75c3.var_23d56965a546c812 + "<dev string:x52e>" );
        }
        else
        {
            iprintlnbold( "<dev string:xdc2>" + level.round_number + "<dev string:xddf>" );
        }
    #/
    
    n_challenge_round = zm_round_logic::get_rb_round_number() + 1;
    b_boss = is_boss_round( n_challenge_round );
    level utility::flag_set( "powerup_disable_nuke" );
    
    if ( b_boss && isdefined( level.var_eab60c4a1e53dcdb[ n_challenge_round ] ) )
    {
        level thread [[ level.var_eab60c4a1e53dcdb[ n_challenge_round ] ]]();
    }
    else if ( b_boss )
    {
        level thread namespace_1fd313b1d0d63e6b::spawn_hvt( undefined, &function_f6dcea1f3c112eed );
    }
    else
    {
        level thread namespace_1fd313b1d0d63e6b::spawn_hvt();
    }
    
    level utility::flag_wait( "echo_challenge_complete" );
    level utility::flag_clear( "echo_challenge_active" );
    level utility::flag_clear( "powerup_disable_nuke" );
    
    /#
        iprintlnbold( "<dev string:xdc2>" + level.round_number + "<dev string:xde9>" );
    #/
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xb580f50e, Offset: 0xfd3c
// Size: 0xa6
function private function_aeb4a44969920364( params )
{
    if ( is_boss_round() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread function_b48b27cf80b32416();
        }
    }
    
    zm_utility::util_kill_all_zombies();
    zm_round_logic::function_895fdc21ab019efe();
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x1fea552e, Offset: 0xfdea
// Size: 0x99
function private function_943267039d5c721a( a_dead_players )
{
    level.var_7ec0fa784f8d9bef = a_dead_players.size;
    
    foreach ( player in a_dead_players )
    {
        player thread function_541dfdb83a2c6b80();
    }
    
    level utility::waittill_any_timeout( 5, "echo_dead_respawns_done" );
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xb4d2f6b8, Offset: 0xfe8b
// Size: 0x5e
function private function_541dfdb83a2c6b80()
{
    self endon( #"disconnect" );
    waitframe();
    self.var_cff5c6b8e3a3aec4 = 1;
    self.var_14955bc056bab547 = 1;
    self.var_5c81ab2cabcc273f = 0;
    
    if ( !class::isvalidclass( self.class ) )
    {
        self.class = "default6";
    }
    
    visibility_mode::visibilitymode_unpackvalue();
    thread playerlogic::spawnclient();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x731600e0, Offset: 0xfef1
// Size: 0x20a
function private function_182f9140a9e02219()
{
    self endon( #"death_or_disconnect" );
    inverted_flash = self.pers[ "sharedGamerProfiles" ][ "invertedFlashEnabled" ];
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        
        if ( inverted_flash )
        {
            self.white_screen_overlay setshader( "black", 640, 480 );
        }
        else
        {
            self.white_screen_overlay setshader( "white", 640, 480 );
        }
        
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
        self.white_screen_overlay.scramblerdisabled = 1;
    }
    
    self.white_screen_overlay.alpha = 1;
    zm_utility::set_player_frozen_vars( 1, "white_reward_flash", 0 );
    wait 1;
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        return;
    }
    
    self.white_screen_overlay fadeovertime( 1 );
    self.white_screen_overlay.alpha = 0;
    wait 0.9;
    zm_utility::set_player_frozen_vars( 0, "white_reward_flash" );
    wait 0.1;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
        self.white_screen_overlay = undefined;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x368a4bcd, Offset: 0x10103
// Size: 0x39
function private function_74774640cf9afce4( str_set_name )
{
    var_e1d246124da6bf1d = level.var_2add2332a4635bbb.var_8eac6e744e8c5bf1;
    
    if ( isdefined( var_e1d246124da6bf1d[ str_set_name ] ) )
    {
        return var_e1d246124da6bf1d[ str_set_name ];
    }
    
    return [];
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x17bd0468, Offset: 0x10145
// Size: 0xe9
function private function_45e3d1f9c4799e62( str_set_name )
{
    if ( isdefined( level.var_4286d29be577f0b4 ) )
    {
        namespace_ed38d631807ab6b0::function_b6e1bfb4a3c023ef( level.var_4286d29be577f0b4 );
    }
    
    a_allowed = function_74774640cf9afce4( str_set_name );
    a_ignore = [];
    
    foreach ( str_name, var_8c4fe62d01999d1e in zone_manager::get_all_zones() )
    {
        if ( !arraycontains( a_allowed, str_name ) )
        {
            a_ignore[ a_ignore.size ] = str_name;
        }
    }
    
    if ( a_ignore.size )
    {
        level.var_55bc6f15db372852 = undefined;
        namespace_ed38d631807ab6b0::function_8b6ed56c2aa29c10( a_ignore );
    }
    
    level.var_4286d29be577f0b4 = a_ignore;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x1b025d77, Offset: 0x10236
// Size: 0xd3
function private function_537d16a12d9565a3()
{
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        zombie kill();
        waitframe();
    }
    
    function_f6e6a6f146e199ef();
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2cba36a6, Offset: 0x10311
// Size: 0x17c
function private function_f6e6a6f146e199ef()
{
    if ( !isdefined( level.var_bdaf1d69422ab15b ) || !utility::issharedfuncdefined( #"mimic_prop", #"hash_fcfe4302fe1691b6" ) )
    {
        return;
    }
    
    var_2e916c957246dafc = [];
    
    foreach ( prop in level.var_bdaf1d69422ab15b )
    {
        if ( prop.var_46b1f5d89aec84a9 )
        {
            var_2e916c957246dafc[ var_2e916c957246dafc.size ] = prop;
        }
    }
    
    foreach ( prop in var_2e916c957246dafc )
    {
        if ( !isdefined( prop ) || prop.var_3a5e1847367d6fc3 )
        {
            continue;
        }
        
        prop.var_3a5e1847367d6fc3 = 1;
        level.var_7376e4ac664af8e0 = maxint( 0, level.var_7376e4ac664af8e0 - 1 );
        level thread utility::callsharedfunc( #"mimic_prop", #"hash_fcfe4302fe1691b6", prop, 1 );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xec59d6d1, Offset: 0x10495
// Size: 0x946
function private echo_round_wait( params )
{
    if ( level.var_f55a0f728c0b515f || level.b_zm_game_over )
    {
        return;
    }
    
    function_9bc1a1ca30592294();
    
    /#
        iprintlnbold( "<dev string:xdf4>" );
        function_385f92351045b5e4();
    #/
    
    if ( is_challenge_round() )
    {
        level utility::flag_waitopen( "echo_challenge_active" );
    }
    
    if ( isdefined( level.echo_destination ) && level.echo_destination.str_set_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
    {
        foreach ( player in level.players )
        {
            player function_d88e8eab88c50c13( 0 );
        }
    }
    
    zm_round_spawning::pause_round_spawning( 1, "echo_portals" );
    level.var_eeb6ebe322e71cd1 = 1;
    level thread function_537d16a12d9565a3();
    level.var_2099a31bd7242769 = [];
    level.var_21e761b6576c714d = [];
    function_59a26b1bd7f03317();
    level.echo_destination = function_d93966b836170afd();
    a_alive_players = get_alive_players();
    zm_laststand::function_3b2825685e8bfee8();
    a_dead_players = get_dead_players();
    
    if ( a_dead_players.size )
    {
        function_943267039d5c721a( a_dead_players );
        
        foreach ( player in a_dead_players )
        {
            a_alive_players[ a_alive_players.size ] = player;
        }
    }
    
    wait 0.1;
    
    foreach ( player in a_alive_players )
    {
        player thread function_b48b27cf80b32416();
    }
    
    wait 0.3;
    function_249fb51c5d69b8fa();
    var_8d8b235b1cc7731b = function_267130a6796df5f7( a_alive_players );
    
    foreach ( s_portal_data in level.var_ad0c50e3383a3d97 )
    {
        if ( s_portal_data.var_d55fb892d0366341 )
        {
            function_925460999cffb2f6( s_portal_data, a_alive_players, var_8d8b235b1cc7731b );
        }
    }
    
    function_be64f0037e762e52( a_alive_players );
    wait 2.2;
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( #"zm_rb_echo_portal" );
    }
    
    /#
        iprintlnbold( "<dev string:xe21>" + level.echo_portals.size + "<dev string:xe36>" );
    #/
    
    if ( level.players.size == 1 )
    {
        var_c15656dcd5c866bb = 60;
    }
    else
    {
        var_c15656dcd5c866bb = 30;
    }
    
    /#
        if ( getdvarint( @"hash_870522f179f53d2a", 0 ) )
        {
            var_c15656dcd5c866bb = 10;
        }
    #/
    
    var_dd40cf6520d59892 = gettime() + var_c15656dcd5c866bb * 1000;
    level.var_9df5a7fab79cbd5e = 1;
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_echo_portal_time", var_dd40cf6520d59892 );
        player setclientomnvar( "ui_zm_echo_portal_timer_vis", 1 );
    }
    
    while ( !function_f33a503af3b09058() && gettime() < var_dd40cf6520d59892 )
    {
        wait 0.5;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( arraycontains( level.var_2099a31bd7242769, player ) )
        {
            continue;
        }
        
        level.var_2099a31bd7242769[ level.var_2099a31bd7242769.size ] = player;
        var_b21381d2422a875e = player getentitynumber();
        var_873f3be04b627cd2 = player is_holding_wonder_weapon();
        a_valid_portals = [];
        
        foreach ( s_portal in level.echo_portals )
        {
            var_c56b6ee6272e1ddf = s_portal.var_bb0ff47788a6c592[ var_b21381d2422a875e ];
            
            if ( !isdefined( var_c56b6ee6272e1ddf ) )
            {
                continue;
            }
            
            if ( var_873f3be04b627cd2 && ( var_c56b6ee6272e1ddf.type == "ammo_mod" || var_c56b6ee6272e1ddf.type == "rarity_upgrade" ) )
            {
                continue;
            }
            
            if ( var_c56b6ee6272e1ddf.type == "rarity_upgrade" )
            {
                weapon = player getcurrentweapon();
                var_bc04d89890b0d04d = player function_e86e9a96bffedef9();
                rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
                
                if ( rarity >= var_bc04d89890b0d04d )
                {
                    continue;
                }
            }
            
            if ( var_c56b6ee6272e1ddf.type == "golden_armor" && !player function_698262e196f8aad2() )
            {
                continue;
            }
            
            a_valid_portals[ a_valid_portals.size ] = s_portal;
        }
        
        if ( a_valid_portals.size )
        {
            var_f259e9e04c82c86 = a_valid_portals[ randomint( a_valid_portals.size ) ];
            var_9f12c0a56c8cc4c9 = var_f259e9e04c82c86.var_bb0ff47788a6c592[ var_b21381d2422a875e ];
            player thread function_3e7d12b2211c0759( var_9f12c0a56c8cc4c9 );
            continue;
        }
        
        if ( level.echo_portals.size )
        {
            var_d94342e0eee60744 = player function_1ce67f3b4ca4e165( [], 0 );
            function_99c679ed8d8117ea( var_d94342e0eee60744 );
            player thread function_3e7d12b2211c0759( var_d94342e0eee60744 );
            continue;
        }
        
        player thread function_2a46d382a4123572();
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_echo_portal_timer_vis", 0 );
        player setclientomnvar( "ui_zm_echo_portal_time", 0 );
    }
    
    level.var_9df5a7fab79cbd5e = 0;
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_zm_echo_chose_portal_reward", 0 );
    }
    
    cleanup_echo_portals();
    wait 7;
    function_45e3d1f9c4799e62( level.echo_destination.str_set_name );
    
    if ( level.var_eab836491208ed9f && !level.var_1fc058405b53460d )
    {
        var_203b3c623fc5036e = level.var_f3262792261367c6[ level.echo_destination.str_set_name ];
        
        if ( isdefined( var_203b3c623fc5036e ) )
        {
            zm_curse_inducer::move_curse_inducer( var_203b3c623fc5036e );
        }
    }
    
    if ( is_next_round_challenge() )
    {
        level thread function_cca1baadf44f49dc();
    }
    
    zm_round_spawning::pause_round_spawning( 0, "echo_portals" );
    level.var_eeb6ebe322e71cd1 = undefined;
    
    foreach ( player in level.players )
    {
        player.electric_field_immune = undefined;
    }
    
    /#
        iprintlnbold( "<dev string:xe65>" );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x4cf61f10, Offset: 0x10de3
// Size: 0x8f
function private get_alive_players()
{
    a_alive = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            a_alive[ a_alive.size ] = player;
        }
    }
    
    return a_alive;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2c4a9ec9, Offset: 0x10e7b
// Size: 0xa5
function private get_dead_players()
{
    a_dead = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            a_dead[ a_dead.size ] = player;
        }
    }
    
    return a_dead;
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x68be9dbb, Offset: 0x10f29
// Size: 0x101
function private function_249fb51c5d69b8fa()
{
    foreach ( s_portal_data in level.var_ad0c50e3383a3d97 )
    {
        var_f0110ccab3f4a8a6 = getlootscriptablearrayinradius( undefined, undefined, s_portal_data.origin, 128 );
        
        foreach ( item in var_f0110ccab3f4a8a6 )
        {
            common_item::function_869d7676e359a627( item, 1 );
        }
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xde28b3db, Offset: 0x11032
// Size: 0x219
function private function_267130a6796df5f7( a_alive_players )
{
    a_standard = [];
    
    foreach ( s_portal_data in level.var_ad0c50e3383a3d97 )
    {
        if ( !s_portal_data.var_d55fb892d0366341 )
        {
            a_standard[ a_standard.size ] = s_portal_data;
        }
    }
    
    function_913dfa5d96a49920( a_standard.size );
    var_c8e6c41c95ba54b7 = [];
    
    for ( i = 0; i < a_standard.size ; i++ )
    {
        var_c8e6c41c95ba54b7[ i ] = [];
    }
    
    var_8d8b235b1cc7731b = [];
    
    foreach ( player in a_alive_players )
    {
        a_used = [];
        
        for ( i = 0; i < a_standard.size ; i++ )
        {
            if ( function_50a1f2c9e3033a00( i ) )
            {
                var_c56b6ee6272e1ddf = function_f83947c2133aee9b( player );
            }
            else
            {
                var_c56b6ee6272e1ddf = player function_1ce67f3b4ca4e165( a_used, a_standard[ i ].pool_index );
            }
            
            if ( isdefined( var_c56b6ee6272e1ddf.config_index ) )
            {
                a_used[ a_used.size ] = var_c56b6ee6272e1ddf.config_index;
            }
            
            var_c8e6c41c95ba54b7[ i ][ player getentitynumber() ] = var_c56b6ee6272e1ddf;
        }
        
        var_8d8b235b1cc7731b[ player getentitynumber() ] = a_used;
    }
    
    for ( i = 0; i < a_standard.size ; i++ )
    {
        spawn_echo_portal( a_standard[ i ].origin, a_standard[ i ].angles, a_standard[ i ].noteworthy, var_c8e6c41c95ba54b7[ i ] );
    }
    
    return var_8d8b235b1cc7731b;
}

// Namespace zm_rb_echo
// Params 3, eflags: 0x4
// Checksum 0xbd26176c, Offset: 0x11254
// Size: 0x1b4
function private function_925460999cffb2f6( s_portal_data, a_alive_players, var_8d8b235b1cc7731b )
{
    a_eligible = [];
    
    foreach ( player in a_alive_players )
    {
        if ( player function_ca8ffa3d9e0d16c9( s_portal_data.challenge_key ) )
        {
            a_eligible[ a_eligible.size ] = player;
        }
    }
    
    if ( !a_eligible.size )
    {
        return;
    }
    
    a_rewards = [];
    var_1ad5cd06c5e0f43b = function_ec07079d2ddad4f2();
    
    foreach ( player in a_eligible )
    {
        var_b21381d2422a875e = player getentitynumber();
        
        if ( var_1ad5cd06c5e0f43b )
        {
            var_c56b6ee6272e1ddf = function_f83947c2133aee9b( player );
        }
        else
        {
            a_excluded = var_8d8b235b1cc7731b[ var_b21381d2422a875e ] ?? [];
            var_c56b6ee6272e1ddf = player function_1ce67f3b4ca4e165( a_excluded, s_portal_data.pool_index );
        }
        
        a_rewards[ var_b21381d2422a875e ] = var_c56b6ee6272e1ddf;
    }
    
    function_b09f2561dba13046( s_portal_data.origin, s_portal_data.angles, s_portal_data.noteworthy, a_rewards, a_eligible );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x23bd35ea, Offset: 0x11410
// Size: 0x262
function private function_be64f0037e762e52( a_alive_players )
{
    if ( !level.echo_portals.size || !a_alive_players.size )
    {
        return;
    }
    
    level notify( #"cancel_all_electric_fields" );
    
    foreach ( player in level.players )
    {
        player.electric_field_immune = 1;
    }
    
    str_set_name = level.var_ad0c50e3383a3d97[ 0 ].str_set_name;
    player_spawn_locations = function_126347a9a48eab91( str_set_name );
    s_stage_portal = level.echo_portals[ 0 ];
    v_forward = anglestoforward( s_stage_portal.angles );
    v_right = anglestoright( s_stage_portal.angles );
    var_1264ec0f1e7016c1 = s_stage_portal.var_a6b623c58a0eb12c + v_forward * 256;
    var_d4618bae38561cb8 = s_stage_portal.angles[ 1 ] + 180;
    var_16bfd01cf29c3299 = ( 0, var_d4618bae38561cb8, 0 );
    n_half = ( a_alive_players.size - 1 ) * 0.5;
    
    foreach ( i, player in a_alive_players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        var_c4dbda4969a702ac = player getentitynumber();
        
        if ( isdefined( player_spawn_locations ) )
        {
            var_46ef66f9ee751863 = player_spawn_locations[ var_c4dbda4969a702ac ].origin;
            var_16bfd01cf29c3299 = player_spawn_locations[ var_c4dbda4969a702ac ].angles;
        }
        else
        {
            v_pos = var_1264ec0f1e7016c1 + v_right * ( i - n_half ) * 48;
            var_46ef66f9ee751863 = getclosestpointonnavmesh( v_pos, 128 );
            
            if ( !isdefined( var_46ef66f9ee751863 ) )
            {
                var_46ef66f9ee751863 = v_pos;
            }
        }
        
        player thread function_5287eb22e064817b( var_46ef66f9ee751863, var_16bfd01cf29c3299 );
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x16370c35, Offset: 0x1167a
// Size: 0xcb
function private function_126347a9a48eab91( str_set_name )
{
    portal_spawn_groups = utility::getstructarray( "player_echo_reward_point", "targetname" );
    
    foreach ( spawn_group in portal_spawn_groups )
    {
        if ( spawn_group.script_noteworthy != str_set_name || !isdefined( spawn_group.target ) )
        {
            continue;
        }
        
        return utility::getstructarray( spawn_group.target, "targetname" );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xc0a397f2, Offset: 0x1174e
// Size: 0x46
function private function_6ab2d29fcf633acd()
{
    self endon( #"death_or_disconnect" );
    
    while ( self ismantling() || self isonascender() || self isonladder() || self.is_petting || self.petting_dawg )
    {
        waitframe();
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xf47c732, Offset: 0x1179c
// Size: 0x38
function private function_5287eb22e064817b( v_origin, v_angles )
{
    self endon( #"death_or_disconnect" );
    function_6ab2d29fcf633acd();
    self setorigin( v_origin );
    self setplayerangles( v_angles );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xbee4bd19, Offset: 0x117dc
// Size: 0x39
function private function_6614c8e915ea13c6( v_origin )
{
    var_a46d031b029111f8 = spawn( "script_model", v_origin );
    
    if ( !isdefined( var_a46d031b029111f8 ) )
    {
        return;
    }
    
    var_a46d031b029111f8 setmodel( "player32x32x256" );
    return var_a46d031b029111f8;
}

// Namespace zm_rb_echo
// Params 4, eflags: 0x4
// Checksum 0xe1a91264, Offset: 0x1181e
// Size: 0x401
function private spawn_echo_portal( v_origin, v_angles, n_index, a_player_rewards )
{
    var_f16446b13af8d27d = v_origin;
    
    if ( !isdefined( var_f16446b13af8d27d ) )
    {
        var_f16446b13af8d27d = v_origin;
    }
    
    v_spawn_origin = var_f16446b13af8d27d + ( 0, 0, 0 );
    v_interact_origin = var_f16446b13af8d27d + ( 0, 0, 24 );
    s_portal = { #e_collision_blocker:undefined, #var_ea6ac752e9068235:[], #a_player_scriptables:[], #var_3caab10004e1d159:[], #var_1a5d876d83f4dd2c:[], #var_bb0ff47788a6c592:a_player_rewards, #var_a6b623c58a0eb12c:var_f16446b13af8d27d, #echo_portal_index:n_index, #angles:v_angles, #origin:v_spawn_origin };
    s_portal.e_collision_blocker = function_6614c8e915ea13c6( var_f16446b13af8d27d );
    
    foreach ( player in level.players )
    {
        var_b21381d2422a875e = player getentitynumber();
        
        if ( !isdefined( a_player_rewards[ var_b21381d2422a875e ] ) )
        {
            continue;
        }
        
        var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
        e_scriptable = spawnscriptable( "teleport_chest_zm_rb_echo_standard", v_spawn_origin, v_angles, undefined, var_7c170ceae0649b57 );
        
        if ( !isdefined( e_scriptable ) )
        {
            /#
                if ( !false )
                {
                    if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                    {
                        assert( 0, "<dev string:x566>" + "<dev string:xea3>" + var_b21381d2422a875e );
                    }
                    else
                    {
                        println( "<dev string:x5a6>" + "<dev string:xea3>" + var_b21381d2422a875e );
                    }
                }
            #/
            
            continue;
        }
        
        waitframe();
        s_portal.a_player_scriptables[ var_b21381d2422a875e ] = e_scriptable;
    }
    
    waitframe();
    
    foreach ( var_b21381d2422a875e, e_scriptable in s_portal.a_player_scriptables )
    {
        e_scriptable setscriptablepartstate( "base", "outdoor" );
        str_glow = function_99c679ed8d8117ea( a_player_rewards[ var_b21381d2422a875e ] );
        e_scriptable setscriptablepartstate( "glow", str_glow );
        function_6373aa10b19ac19c( e_scriptable, a_player_rewards[ var_b21381d2422a875e ] );
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", e_scriptable, "icon" );
    }
    
    s_portal.echo_interact = interaction::register_interact( v_interact_origin, 72, &on_portal_used, &get_portal_hint );
    
    if ( isdefined( s_portal.echo_interact ) )
    {
        s_portal.echo_interact.echo_portal = s_portal;
        s_portal.echo_interact sethintonobstruction( "show" );
    }
    
    level.echo_portals[ level.echo_portals.size ] = s_portal;
    
    foreach ( player in level.players )
    {
        var_b21381d2422a875e = player getentitynumber();
        
        if ( isdefined( a_player_rewards[ var_b21381d2422a875e ] ) )
        {
            function_691830097f91298a( s_portal, a_player_rewards[ var_b21381d2422a875e ], player );
        }
    }
    
    /#
        iprintlnbold( "<dev string:xee4>" + n_index + "<dev string:xef9>" + s_portal.a_player_scriptables.size + "<dev string:xf21>" );
    #/
}

// Namespace zm_rb_echo
// Params 5, eflags: 0x4
// Checksum 0x342323d0, Offset: 0x11c27
// Size: 0x480
function private function_b09f2561dba13046( v_origin, v_angles, n_index, a_player_rewards, var_9fbb424cdc30af12 )
{
    var_f16446b13af8d27d = getclosestpointonnavmesh( v_origin, 128 );
    v_interact_origin = v_origin + ( 0, 0, 24 );
    s_portal = { #e_collision_blocker:undefined, #var_d7131cd77791a040:var_9fbb424cdc30af12, #var_cca27ca21b2f6053:1, #var_ea6ac752e9068235:[], #a_player_scriptables:[], #var_3caab10004e1d159:[], #var_1a5d876d83f4dd2c:[], #var_bb0ff47788a6c592:a_player_rewards, #var_a6b623c58a0eb12c:var_f16446b13af8d27d, #echo_portal_index:n_index, #angles:v_angles, #origin:v_origin };
    s_portal.e_collision_blocker = function_6614c8e915ea13c6( var_f16446b13af8d27d );
    
    if ( isdefined( s_portal.e_collision_blocker ) )
    {
        foreach ( player in level.players )
        {
            if ( !arraycontains( var_9fbb424cdc30af12, player ) )
            {
                s_portal.e_collision_blocker hidefromplayer( player, 1 );
            }
        }
    }
    
    foreach ( player in var_9fbb424cdc30af12 )
    {
        var_b21381d2422a875e = player getentitynumber();
        
        if ( !isdefined( a_player_rewards[ var_b21381d2422a875e ] ) )
        {
            continue;
        }
        
        var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
        e_scriptable = spawnscriptable( "teleport_chest_zm_rb_echo_standard", v_origin, v_angles, undefined, var_7c170ceae0649b57 );
        
        if ( !isdefined( e_scriptable ) )
        {
            /#
                if ( !false )
                {
                    if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                    {
                        assert( 0, "<dev string:x566>" + "<dev string:xf2d>" + var_b21381d2422a875e );
                    }
                    else
                    {
                        println( "<dev string:x5a6>" + "<dev string:xf2d>" + var_b21381d2422a875e );
                    }
                }
            #/
            
            continue;
        }
        
        waitframe();
        s_portal.a_player_scriptables[ var_b21381d2422a875e ] = e_scriptable;
    }
    
    waitframe();
    
    foreach ( var_b21381d2422a875e, e_scriptable in s_portal.a_player_scriptables )
    {
        e_scriptable setscriptablepartstate( "base", "outdoor" );
        str_glow = function_99c679ed8d8117ea( a_player_rewards[ var_b21381d2422a875e ] );
        e_scriptable setscriptablepartstate( "glow", str_glow );
        function_6373aa10b19ac19c( e_scriptable, a_player_rewards[ var_b21381d2422a875e ] );
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", e_scriptable, "icon" );
    }
    
    s_portal.echo_interact = interaction::register_interact( v_interact_origin, 72, &on_portal_used, &get_portal_hint );
    
    if ( isdefined( s_portal.echo_interact ) )
    {
        s_portal.echo_interact.echo_portal = s_portal;
        s_portal.echo_interact sethintonobstruction( "show" );
    }
    
    level.echo_portals[ level.echo_portals.size ] = s_portal;
    
    foreach ( player in var_9fbb424cdc30af12 )
    {
        var_b21381d2422a875e = player getentitynumber();
        
        if ( isdefined( a_player_rewards[ var_b21381d2422a875e ] ) )
        {
            function_691830097f91298a( s_portal, a_player_rewards[ var_b21381d2422a875e ], player );
        }
    }
    
    /#
        iprintlnbold( "<dev string:xf6d>" + n_index + "<dev string:xf88>" + var_9fbb424cdc30af12.size + "<dev string:xf97>" );
    #/
}

// Namespace zm_rb_echo
// Params 0, eflags: 0xc
// Checksum 0xeff0ba71, Offset: 0x120af
// Size: 0x297
function private function_b48b27cf80b32416()
{
    self notify( #"hash_81d751ac438a69e0" );
    self endon( #"hash_81d751ac438a69e0" );
    self endon( #"death_or_disconnect" );
    inverted_flash = self.pers[ "sharedGamerProfiles" ][ "invertedFlashEnabled" ];
    
    if ( !isdefined( self.var_8b1e3b7871c312e4 ) )
    {
        self.var_8b1e3b7871c312e4 = newclienthudelem( self );
        self.var_8b1e3b7871c312e4.x = 0;
        self.var_8b1e3b7871c312e4.y = 0;
        
        if ( inverted_flash )
        {
            self.var_8b1e3b7871c312e4 setshader( "black", 640, 480 );
        }
        else
        {
            self.var_8b1e3b7871c312e4 setshader( "white", 640, 480 );
        }
        
        self.var_8b1e3b7871c312e4.alignx = "left";
        self.var_8b1e3b7871c312e4.aligny = "top";
        self.var_8b1e3b7871c312e4.sort = 1;
        self.var_8b1e3b7871c312e4.horzalign = "fullscreen";
        self.var_8b1e3b7871c312e4.vertalign = "fullscreen";
        self.var_8b1e3b7871c312e4.alpha = 0;
        self.var_8b1e3b7871c312e4.foreground = 1;
        self.var_8b1e3b7871c312e4.archived = 0;
        self.var_8b1e3b7871c312e4.scramblerdisabled = 1;
        self playsoundevent( %"sndevent_powerup_nuke" );
        self setclientomnvar( "ui_hide_hud", 1 );
    }
    
    self.var_8b1e3b7871c312e4 fadeovertime( 0.3 );
    self.var_8b1e3b7871c312e4.alpha = 1;
    wait 0.3;
    
    if ( !isdefined( self.var_8b1e3b7871c312e4 ) )
    {
        return;
    }
    
    zm_utility::set_player_frozen_vars( 1, "white_reward_flash", 0 );
    wait 1;
    
    if ( !isdefined( self.var_8b1e3b7871c312e4 ) )
    {
        zm_utility::set_player_frozen_vars( 0, "white_reward_flash" );
        return;
    }
    
    self.var_8b1e3b7871c312e4 fadeovertime( 1 );
    self.var_8b1e3b7871c312e4.alpha = 0;
    self setclientomnvar( "ui_hide_hud", 0 );
    wait 0.9;
    zm_utility::set_player_frozen_vars( 0, "white_reward_flash" );
    wait 0.1;
    
    if ( isdefined( self.var_8b1e3b7871c312e4 ) )
    {
        self.var_8b1e3b7871c312e4 destroy();
        self.var_8b1e3b7871c312e4 = undefined;
    }
}

// Namespace zm_rb_echo
// Params 3, eflags: 0x4
// Checksum 0x1ceed9b3, Offset: 0x1234e
// Size: 0x19c
function private function_691830097f91298a( var_1ee5c708ea46e6ec, var_c56b6ee6272e1ddf, player )
{
    var_d700d2d96a675afc = get_portal_reward_sign( var_c56b6ee6272e1ddf );
    
    if ( !isdefined( var_d700d2d96a675afc ) )
    {
        return;
    }
    
    v_forward = anglestoforward( var_1ee5c708ea46e6ec.angles );
    v_right = anglestoright( var_1ee5c708ea46e6ec.angles );
    v_offset = var_d700d2d96a675afc.v_offset;
    var_9fec04c1fcf09a99 = var_1ee5c708ea46e6ec.origin + v_forward * v_offset[ 0 ] + v_right * v_offset[ 1 ] + ( 0, 0, v_offset[ 2 ] );
    var_79a77fc29c962e43 = var_1ee5c708ea46e6ec.angles + var_d700d2d96a675afc.var_e45619251daac78e;
    
    if ( !isdefined( var_d700d2d96a675afc.roulette_func ) )
    {
        e_sign = utility::spawn_model( var_d700d2d96a675afc.model, var_9fec04c1fcf09a99, var_79a77fc29c962e43, undefined, var_d700d2d96a675afc.var_2023057124245de3 );
        e_sign hide();
        e_sign showtoplayer( player );
        var_1ee5c708ea46e6ec.var_1a5d876d83f4dd2c[ player getentitynumber() ] = e_sign;
        
        if ( isdefined( var_d700d2d96a675afc.vfx_loop ) )
        {
            playfxontagforclients( utility::getfx( var_d700d2d96a675afc.vfx_loop ), e_sign, "tag_origin", player );
        }
        
        return;
    }
    
    var_1ee5c708ea46e6ec thread [[ var_d700d2d96a675afc.roulette_func ]]( var_c56b6ee6272e1ddf.data.class, var_d700d2d96a675afc.rarity, var_d700d2d96a675afc.pap_level, var_9fec04c1fcf09a99, var_79a77fc29c962e43, player );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x1bbb2e35, Offset: 0x124f2
// Size: 0x71a
function private get_portal_reward_sign( var_c56b6ee6272e1ddf )
{
    if ( function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf ) )
    {
        return function_367fe1cb552a24f4();
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 58 ), #model:%"jup_zm_wrench_epic" };
        case #"hash_c7321084b20ece8d":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_crystal_rarity_small_rare" };
        case #"hash_c7320d84b20ec9d4":
            return { #var_2023057124245de3:0.8, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 50 ), #model:%"jup_zm_crystal_rarity_small_epic" };
        case #"hash_c7320e84b20ecb67":
            return { #var_2023057124245de3:0.9, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 50 ), #model:%"jup_zm_crystal_rarity_small_legendary" };
        case #"hash_c7320b84b20ec6ae":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 50 ), #model:%"jup_zm_crystal_rarity_small_legendary" };
        case #"hash_be4e031e7acb7b74":
            return function_9d20e64136b620a5( var_c56b6ee6272e1ddf.data );
        case #"hash_ac7114576080f3cf":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, -3, 52 ), #model:%"prop_wpn_sat_vm_ww_raygun" };
        case #"hash_ab671284a3fc4e3d":
            return function_8cb85018135b2934( var_c56b6ee6272e1ddf.data );
        case #"hash_17cd1fd5f990f7dd":
            return { #vfx_loop:"vfx_essence_sign", #var_2023057124245de3:1.8, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 52 ), #model:%"jup_zm_tube_essence_01" };
        case #"hash_b60679835e82a584":
            return function_898caad47c8fc1f5( var_c56b6ee6272e1ddf.data );
        case #"hash_fdefe402d20f8998":
            return { #var_2023057124245de3:0.3, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 42 ), #model:%"sat_zm_large_ammo_crate" };
        case #"hash_617c0facb611c9cb":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"vest_prototype_nophys" };
        case #"hash_622103c8ad3b11c8":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"vest_prototype_nophys_gold" };
        case #"hash_47611497d0263858":
            return function_e5b2dee6c6cdaed1( var_c56b6ee6272e1ddf.data );
        case #"hash_5ce3bd22c7f44be9":
            return { #pap_level:var_c56b6ee6272e1ddf.data.pap_level, #rarity:var_c56b6ee6272e1ddf.data.rarity, #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, -3, 50 ), #roulette_func:&function_337c31dcb574c8ef };
        case #"hash_ab10f9c080fe4faf":
            return { #pap_level:var_c56b6ee6272e1ddf.data.pap_level, #rarity:var_c56b6ee6272e1ddf.data.rarity, #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, -4, 50 ), #roulette_func:&function_337c31dcb574c8ef };
        case #"hash_5caede22c7cb31d5":
            return { #pap_level:var_c56b6ee6272e1ddf.data.pap_level, #rarity:var_c56b6ee6272e1ddf.data.rarity, #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, -7, 50 ), #roulette_func:&function_337c31dcb574c8ef };
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5cedda22c7fcc855":
            return { #pap_level:var_c56b6ee6272e1ddf.data.pap_level, #rarity:var_c56b6ee6272e1ddf.data.rarity, #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #roulette_func:&function_337c31dcb574c8ef };
        case #"hash_86b11ac21f992552":
            return { #pap_level:var_c56b6ee6272e1ddf.data.pap_level, #rarity:var_c56b6ee6272e1ddf.data.rarity, #var_2023057124245de3:undefined, #var_e45619251daac78e:( 90, 90, 0 ), #v_offset:( 0, 0, 46 ), #roulette_func:&function_337c31dcb574c8ef };
        default:
            return;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xfe318989, Offset: 0x12c14
// Size: 0x30a
function private function_99c679ed8d8117ea( var_c56b6ee6272e1ddf )
{
    if ( function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf ) )
    {
        return var_c56b6ee6272e1ddf.rarity;
    }
    
    a_glow = [ "white", "green", "blue", "purple", "orange", "red" ];
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            var_c56b6ee6272e1ddf.rarity = "blue";
            break;
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            var_c56b6ee6272e1ddf.rarity = "orange";
            break;
        case #"hash_c7320b84b20ec6ae":
            var_c56b6ee6272e1ddf.rarity = "red";
            break;
        case #"hash_be4e031e7acb7b74":
            var_c56b6ee6272e1ddf.rarity = "green";
            break;
        case #"hash_ac7114576080f3cf":
            var_c56b6ee6272e1ddf.rarity = "orange";
            break;
        case #"hash_ab671284a3fc4e3d":
            var_c56b6ee6272e1ddf.rarity = "blue";
            break;
        case #"hash_17cd1fd5f990f7dd":
            var_c56b6ee6272e1ddf.rarity = "white";
            break;
        case #"hash_b60679835e82a584":
            var_c56b6ee6272e1ddf.rarity = "purple";
            break;
        case #"hash_fdefe402d20f8998":
            var_c56b6ee6272e1ddf.rarity = "white";
            break;
        case #"hash_617c0facb611c9cb":
            var_c56b6ee6272e1ddf.rarity = "purple";
            break;
        case #"hash_622103c8ad3b11c8":
            var_c56b6ee6272e1ddf.rarity = "red";
            break;
        case #"hash_47611497d0263858":
            var_c56b6ee6272e1ddf.rarity = "purple";
            break;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            n_rarity = var_c56b6ee6272e1ddf.data.rarity ?? 0;
            
            if ( n_rarity >= 5 || var_c56b6ee6272e1ddf.data.pap_level == 3 )
            {
                var_c56b6ee6272e1ddf.rarity = "red";
                break;
            }
            
            var_c56b6ee6272e1ddf.rarity = a_glow[ n_rarity ];
            break;
        default:
            var_c56b6ee6272e1ddf.rarity = "white";
            break;
    }
    
    return var_c56b6ee6272e1ddf.rarity;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x3917b90b, Offset: 0x12f27
// Size: 0x4f5
function private function_8cb85018135b2934( str_perk )
{
    switch ( str_perk )
    {
        case #"hash_4485ea5afc8ef4ec":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_juggernog_can" };
        case #"hash_47874f94af82bbae":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_quick_revive_can" };
        case #"hash_5b88c6956390309e":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_speed_cola_can" };
        case #"hash_8ce81fd37af3e66b":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_stamina_up_can" };
        case #"hash_8f7f900f28dfcf96":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_deadshot_can" };
        case #"hash_f8756efed2ffb6f4":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_death_perception_can" };
        case #"hash_d5e621d55a8082dd":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_elemental_can" };
        case #"hash_474f00cba8142b0b":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_phd_flopper_can" };
        case #"hash_8b9ba3dfc17ec0a4":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_vulture_aid_can" };
        case #"hash_ad7ceb3a37ee891c":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_melee_macchiato_can" };
        case #"hash_a05b09269a304697":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_t10_wm_zmb_perk_double_tap_can" };
        case #"hash_911728a3d7e223b2":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_sat_wm_zmb_perk_w_mod_can" };
        case #"hash_e5e3d5b102e77800":
            return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_58c934176745e6af" };
    }
    
    return { #var_2023057124245de3:1.6, #var_e45619251daac78e:( 0, 180, 0 ), #v_offset:( 0, 0, 40 ), #model:%"offhand_sat_wm_zmb_perk_mystery_can" };
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xf2935945, Offset: 0x13425
// Size: 0x30f
function private function_9d20e64136b620a5( var_4c506782108851c7 )
{
    switch ( var_4c506782108851c7 )
    {
        case #"hash_853faa00a9ff1020":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_brainrot" };
        case #"hash_fe0fd5228eda0f07":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_cryofreeze" };
        case #"hash_afaaf053b2461f8a":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_deadwire" };
        case #"hash_181a8e483a8ecc93":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"sat_zm_ammo_mod_fireworks" };
        case #"hash_4f5cd54aaf7f106":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_napalmburst" };
        case #"hash_646d6f8aee3339b1":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_lightmend" };
        case #"hash_ac0effad69e31045":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_shadowrift" };
        case #"hash_41d942d30dd3f804":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"jup_zm_ammo_mod_shatterblast" };
    }
    
    return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 42 ), #model:%"sat_zm_ammo_mod_fireworks" };
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x18430c48, Offset: 0x1373d
// Size: 0x3bb
function private function_898caad47c8fc1f5( str_super )
{
    switch ( str_super )
    {
        case #"hash_d508880fd30faf68":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_aether_shroud" };
        case #"hash_25d6c8e468976601":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_energy_mine" };
        case #"hash_aa20722d2fc8768c":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_frenzied_guard" };
        case #"hash_95aa0913ab7d91a0":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_frost_blast" };
        case #"hash_96f27034a876b211":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_healing_aura" };
        case #"hash_62554bb1c5b6193e":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_tesla_storm" };
        case #"hash_ad69ce526df0cbf2":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_dog_fox" };
        case #"hash_47e1c1c639fcf136":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_mary_paris" };
        case #"hash_62c5f25842f5d90e":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_t10_vm_zmb_wand_toxic_growth" };
        case #"hash_1a1cd157ef5ae29f":
            return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_sat_vm_zmb_wand_wiley_fox" };
    }
    
    return { #var_2023057124245de3:undefined, #var_e45619251daac78e:( 0, 90, 0 ), #v_offset:( 0, 0, 46 ), #model:%"offhand_sat_vm_zmb_wand" };
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xf2ddd77, Offset: 0x13b01
// Size: 0xc63
function private function_e5b2dee6c6cdaed1( augment_ref )
{
    if ( isdefined( augment_ref ) )
    {
        foreach ( str_perk, a_augments in level.var_98451248a70b7bb3 )
        {
            if ( arraycontains( a_augments, augment_ref ) )
            {
                switch ( str_perk )
                {
                    case #"hash_4485ea5afc8ef4ec":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_juggernog" };
                    case #"hash_47874f94af82bbae":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_quickrevive" };
                    case #"hash_5b88c6956390309e":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_speedcola" };
                    case #"hash_8ce81fd37af3e66b":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_staminup" };
                    case #"hash_8f7f900f28dfcf96":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_deadshot" };
                    case #"hash_f8756efed2ffb6f4":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_death_perception" };
                    case #"hash_d5e621d55a8082dd":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_elemental_pop" };
                    case #"hash_474f00cba8142b0b":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_phd_flopper" };
                    case #"hash_8b9ba3dfc17ec0a4":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_28d12751e8882332" };
                    case #"hash_ad7ceb3a37ee891c":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_502fcf0a10a6f06e" };
                    case #"hash_a05b09269a304697":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_d_mod" };
                    case #"hash_911728a3d7e223b2":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_perk_w_mod" };
                    case #"hash_e5e3d5b102e77800":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_3ca53e9c3e6eea2a" };
                }
            }
        }
        
        foreach ( var_4c506782108851c7, a_augments in level.var_6c3426d7b2e5e264 )
        {
            if ( arraycontains( a_augments, augment_ref ) )
            {
                switch ( var_4c506782108851c7 )
                {
                    case #"hash_853faa00a9ff1020":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_brainrot" };
                    case #"hash_fe0fd5228eda0f07":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_cryofreeze" };
                    case #"hash_afaaf053b2461f8a":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_deadwire" };
                    case #"hash_4f5cd54aaf7f106":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_napalmburst" };
                    case #"hash_41d942d30dd3f804":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_shatterblast" };
                    case #"hash_ac0effad69e31045":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_shadowvortex" };
                    case #"hash_646d6f8aee3339b1":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_32bad78ce22f222a" };
                    case #"hash_181a8e483a8ecc93":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_ammomod_fireworks" };
                }
            }
        }
        
        foreach ( str_super, a_augments in level.var_151effd1b9580cae )
        {
            if ( arraycontains( a_augments, augment_ref ) )
            {
                switch ( str_super )
                {
                    case #"hash_d508880fd30faf68":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_aether_shroud" };
                    case #"hash_25d6c8e468976601":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_energy_mine" };
                    case #"hash_aa20722d2fc8768c":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_frenzied_guard" };
                    case #"hash_95aa0913ab7d91a0":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_frost_blast" };
                    case #"hash_96f27034a876b211":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_healing_aura" };
                    case #"hash_62554bb1c5b6193e":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_tesla_storm" };
                    case #"hash_ad69ce526df0cbf2":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_dark_flare" };
                    case #"hash_47e1c1c639fcf136":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"hash_1fc01069f9c42e1b" };
                    case #"hash_62c5f25842f5d90e":
                        return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"sat_zm_vials_flask_super_toxic_growth" };
                }
            }
        }
    }
    
    return { #var_2023057124245de3:1.5, #var_e45619251daac78e:( 0, 0, 0 ), #v_offset:( 0, 0, 40 ), #model:%"t10_zm_vials_flask_ammomod_brainrot" };
}

// Namespace zm_rb_echo
// Params 6, eflags: 0x4
// Checksum 0xd19c1848, Offset: 0x1476d
// Size: 0x31e
function private function_337c31dcb574c8ef( weapon_class, n_rarity, var_951c89546ec50477, v_position, v_angles, player )
{
    level endon( #"echo_portal_cleanup" );
    player endon( #"disconnect" );
    itemlist = level.var_feed53d8447f7479[ weapon_class ][ n_rarity ];
    var_3192e5ad18b59399 = [];
    function_a2cc1b40cfe26156( itemlist, var_3192e5ad18b59399 );
    var_1e9615d50e6f0fec = [];
    
    foreach ( var_2e08e94c9cb1747c in var_3192e5ad18b59399 )
    {
        if ( isdefined( var_951c89546ec50477 ) )
        {
            var_619aa3791b99968c = weapon::buildweapon( level.weaponmetadata[ var_2e08e94c9cb1747c ].weapon );
            paped_weap = pack_a_punch::function_e190a315803e2870( var_619aa3791b99968c, var_951c89546ec50477 + 1 );
            var_1e9615d50e6f0fec[ var_2e08e94c9cb1747c ] = paped_weap;
            var_619aa3791b99968c = undefined;
            continue;
        }
        
        var_1e9615d50e6f0fec[ var_2e08e94c9cb1747c ] = level.weaponmetadata[ var_2e08e94c9cb1747c ].weapon;
    }
    
    if ( !isdefined( self.var_ea6ac752e9068235 ) )
    {
        self.var_ea6ac752e9068235 = [];
    }
    
    foreach ( var_2e08e94c9cb1747c, weapon_obj in var_1e9615d50e6f0fec )
    {
        var_9677eeff5f600462 = v_angles + function_9d1d476f76579591( var_2e08e94c9cb1747c );
        mdl_weapon_streaming = function_2535619d314c1099( weapon_obj, self.origin - ( 0, 0, 100 ), var_9677eeff5f600462 );
        self.var_ea6ac752e9068235[ self.var_ea6ac752e9068235.size ] = mdl_weapon_streaming;
        mdl_weapon_streaming val::set( "echo_reward", "hide", 2 );
    }
    
    wait 1;
    var_b21381d2422a875e = player getentitynumber();
    thread function_b287d7a9deb05636( var_b21381d2422a875e, player );
    
    while ( true )
    {
        foreach ( var_2e08e94c9cb1747c, weapon_obj in var_1e9615d50e6f0fec )
        {
            var_9677eeff5f600462 = v_angles + function_9d1d476f76579591( var_2e08e94c9cb1747c );
            self.var_3caab10004e1d159[ var_b21381d2422a875e ] = function_2535619d314c1099( weapon_obj, v_position, var_9677eeff5f600462 );
            self.var_3caab10004e1d159[ var_b21381d2422a875e ] hide();
            
            if ( isplayer( player ) )
            {
                self.var_3caab10004e1d159[ var_b21381d2422a875e ] showtoplayer( player );
            }
            
            wait 0.3;
            self.var_3caab10004e1d159[ var_b21381d2422a875e ] delete();
        }
        
        waitframe();
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xc3de9eb2, Offset: 0x14a93
// Size: 0x50
function private function_b287d7a9deb05636( var_b21381d2422a875e, player )
{
    level endon( #"echo_portal_cleanup" );
    player waittill( #"disconnect" );
    
    if ( isdefined( self.var_3caab10004e1d159[ var_b21381d2422a875e ] ) )
    {
        self.var_3caab10004e1d159[ var_b21381d2422a875e ] delete();
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x3cce9b95, Offset: 0x14aeb
// Size: 0x36
function private function_9d1d476f76579591( var_2e08e94c9cb1747c )
{
    if ( isdefined( level.var_b7f752f4c5a71657[ var_2e08e94c9cb1747c ] ) )
    {
        return level.var_b7f752f4c5a71657[ var_2e08e94c9cb1747c ];
    }
    
    return ( 0, 0, 0 );
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x27dd8c38, Offset: 0x14b2a
// Size: 0x238
function private function_a2cc1b40cfe26156( str_item_spawn_list, var_f0110ccab3f4a8a6 )
{
    if ( !isdefined( str_item_spawn_list ) )
    {
        return;
    }
    
    s_bundle = getscriptbundle( str_item_spawn_list );
    
    if ( !isdefined( s_bundle ) && isstring( str_item_spawn_list ) )
    {
        s_bundle = getscriptbundle( hashcat( %"itemspawnlist:", str_item_spawn_list ) );
    }
    
    if ( isarray( s_bundle.itementries ) )
    {
        foreach ( s_itementry in s_bundle.itementries )
        {
            if ( !isdefined( s_itementry.itemspawnentry ) )
            {
                println( "<dev string:xfab>" + str_item_spawn_list + "<dev string:xfcf>" );
                continue;
            }
            
            if ( !isdefined( s_itementry.weight ) || s_itementry.weight == 0 )
            {
                continue;
            }
            
            sb_itementry = getscriptbundle( s_itementry.itemspawnentry );
            
            if ( !isdefined( sb_itementry.ref ) )
            {
                continue;
            }
            
            item_name = getxhashasset( sb_itementry.ref );
            var_f0110ccab3f4a8a6[ item_name ] = item_name;
        }
    }
    
    if ( isarray( s_bundle.itemlistentries ) )
    {
        foreach ( var_8fe1c40c3cabe229 in s_bundle.itemlistentries )
        {
            if ( !isdefined( var_8fe1c40c3cabe229.weight ) || var_8fe1c40c3cabe229.weight == 0 )
            {
                continue;
            }
            
            if ( isdefined( var_8fe1c40c3cabe229.itemspawnlist ) )
            {
                function_a2cc1b40cfe26156( var_8fe1c40c3cabe229.itemspawnlist, var_f0110ccab3f4a8a6 );
            }
        }
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x4ad0b1fa, Offset: 0x14d6a
// Size: 0x109
function private function_c06e46bcbdb058e3( interact, player )
{
    var_1ee5c708ea46e6ec = interact.echo_portal;
    var_c56b6ee6272e1ddf = var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ];
    temp_title = function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player );
    temp_description = get_reward_hint_string( var_c56b6ee6272e1ddf, player );
    hint = { #icon:function_231bf14e109835e3( var_c56b6ee6272e1ddf ), #description:temp_description, #title:temp_title, #string:&"hash_7dc114b459c8ebcf", #type:"HINT_BUTTON" };
    s_warning = function_ccb9acb26f2228a0( var_c56b6ee6272e1ddf, player );
    
    if ( isdefined( s_warning ) )
    {
        hint.var_609f30dc7ba9270 = s_warning.var_609f30dc7ba9270;
        hint.loot_id = s_warning.loot_id;
    }
    
    return hint;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xdf3a027e, Offset: 0x14e7c
// Size: 0x81
function private function_ab83a25610815a07( augment_ref )
{
    if ( !isdefined( augment_ref ) || !isdefined( level.var_9726014da3c8d6c1[ augment_ref ] ) )
    {
        return;
    }
    
    var_afdcadb44a80e6a2 = level.var_9726014da3c8d6c1[ augment_ref ];
    loot_id = loot::getlootidfromref( var_afdcadb44a80e6a2 );
    
    if ( !isdefined( loot_id ) || loot_id <= 0 )
    {
        loot_id = loot::getlootidfromref( "sat_" + var_afdcadb44a80e6a2 );
    }
    
    if ( !isdefined( loot_id ) || loot_id <= 0 )
    {
        return;
    }
    
    return loot_id;
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x4d656c4c, Offset: 0x14f06
// Size: 0xe8
function private function_68832fa860a36e7c( player, augment_ref )
{
    if ( !isdefined( player ) || !isdefined( augment_ref ) || !isdefined( level.zombie_augments[ augment_ref ] ) )
    {
        return;
    }
    
    augment_bundle = level.zombie_augments[ augment_ref ];
    augment_type = augment_bundle.augmenttype;
    is_major = augment_bundle.ismajor;
    
    if ( !player zombie_augments::function_b0d3026dadf39ee5( augment_type, is_major ) )
    {
        return;
    }
    
    if ( is_major )
    {
        current_augment = player.zombie_augments[ augment_type ].majorname;
    }
    else
    {
        current_augment = player.zombie_augments[ augment_type ].minorname;
    }
    
    if ( !isdefined( current_augment ) || current_augment == "none" )
    {
        return;
    }
    
    return function_ab83a25610815a07( current_augment );
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xf7a0e4e8, Offset: 0x14ff7
// Size: 0x3df
function private function_ccb9acb26f2228a0( var_c56b6ee6272e1ddf, player )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) || !isdefined( player ) )
    {
        return;
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_be4e031e7acb7b74":
            weapon = player getcurrentweapon();
            
            if ( isdefined( weapon ) && weapon != level.weaponnone )
            {
                str_current_mod = player ammo_mod::get_ammo_mod_name( weapon );
                
                if ( isdefined( str_current_mod ) && str_current_mod != "" && isdefined( level.var_3355343961c11683[ str_current_mod ] ) )
                {
                    return { #loot_id:loot::getlootidfromref( level.var_3355343961c11683[ str_current_mod ] ), #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
                }
            }
            
            return;
        case #"hash_b60679835e82a584":
            var_c0c4324d255baab3 = player supers_mp::getcurrentsuper();
            
            if ( isdefined( var_c0c4324d255baab3 ) && isdefined( var_c0c4324d255baab3.weaponobj ) )
            {
                return { #loot_id:challenges::getweaponlootid( var_c0c4324d255baab3.weaponobj, var_c0c4324d255baab3.weaponobj.basename ), #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
            }
            
            return;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_ab10f9c080fe4faf":
            var_3df86f0b126863ab = player getweaponslistprimaries();
            
            foreach ( held_weapon in var_3df86f0b126863ab )
            {
                if ( !weapon::iswonderweapon( held_weapon ) && !weapon::iscurrenttertiaryweapon( player, held_weapon ) )
                {
                    return { #loot_id:challenges::getweaponlootid( held_weapon, held_weapon.basename ), #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
                }
            }
            
            return;
        case #"hash_86b11ac21f992552":
            if ( isdefined( player.var_cc1262e66dbb1c79 ) && player hasweapon( player.var_cc1262e66dbb1c79 ) )
            {
                return { #loot_id:challenges::getweaponlootid( player.var_cc1262e66dbb1c79, player.var_cc1262e66dbb1c79.basename ), #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
            }
            
            return;
        case #"hash_ac7114576080f3cf":
            var_3df86f0b126863ab = player getweaponslistprimaries();
            
            foreach ( held_weapon in var_3df86f0b126863ab )
            {
                if ( weapon::iswonderweapon( held_weapon ) )
                {
                    return { #loot_id:challenges::getweaponlootid( held_weapon, held_weapon.basename ), #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
                }
            }
            
            return;
        case #"hash_47611497d0263858":
            loot_id = function_68832fa860a36e7c( player, var_c56b6ee6272e1ddf.data );
            
            if ( isdefined( loot_id ) )
            {
                return { #loot_id:loot_id, #var_609f30dc7ba9270:&"hash_226e046ededcb1e3" };
            }
            
            return;
        default:
            return;
    }
}

// Namespace zm_rb_echo
// Params 3, eflags: 0x4
// Checksum 0x96b2a49b, Offset: 0x153de
// Size: 0x42b
function private get_portal_hint( interact, player, var_2f385dafed4699c8 = 0 )
{
    var_1ee5c708ea46e6ec = interact.echo_portal;
    
    if ( isdefined( var_1ee5c708ea46e6ec ) && !isdefined( var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ] ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !var_2f385dafed4699c8 )
    {
        if ( isdefined( player ) && arraycontains( level.var_2099a31bd7242769, player ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        if ( !isdefined( player ) || !player val::get( "interactions" ) )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    var_c56b6ee6272e1ddf = var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ];
    
    if ( isdefined( var_c56b6ee6272e1ddf ) )
    {
        if ( function_c2ddf4f1f3a51c53( var_c56b6ee6272e1ddf ) )
        {
            return function_dc19656d2fcd8e29( var_c56b6ee6272e1ddf );
        }
        
        weapon = player getcurrentweapon();
        
        if ( var_c56b6ee6272e1ddf.type == "ammo_mod" )
        {
            if ( !isdefined( weapon ) || weapon == level.weaponnone || !ammo_mod::function_7bbc1db07694f31d( weapon ) )
            {
                return { #icon:function_231bf14e109835e3( var_c56b6ee6272e1ddf ), #description:&"hash_5bf197d1c525ad32", #title:function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player ), #string:&"hash_5bf197d1c525ad32", #type:"HINT_NOBUTTON" };
            }
        }
        
        if ( var_c56b6ee6272e1ddf.type == "rarity_upgrade" )
        {
            if ( !isdefined( weapon ) || weapon == level.weaponnone || weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) )
            {
                return { #icon:function_231bf14e109835e3( var_c56b6ee6272e1ddf ), #description:&"hash_588587c082f9b388", #title:function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player ), #string:&"hash_588587c082f9b388", #type:"HINT_NOBUTTON" };
            }
            
            rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
            var_bc04d89890b0d04d = player function_e86e9a96bffedef9();
            
            if ( rarity >= var_bc04d89890b0d04d )
            {
                return { #icon:function_231bf14e109835e3( var_c56b6ee6272e1ddf ), #description:&"hash_588587c082f9b388", #title:function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player ), #string:&"hash_588587c082f9b388", #type:"HINT_NOBUTTON" };
            }
        }
        
        if ( var_c56b6ee6272e1ddf.type == "pap1" || var_c56b6ee6272e1ddf.type == "pap2" || var_c56b6ee6272e1ddf.type == "pap3" || var_c56b6ee6272e1ddf.type == "pap4" )
        {
            if ( !isdefined( weapon ) || weapon == level.weaponnone || !player pack_a_punch::can_pap( weapon ) || var_c56b6ee6272e1ddf.data <= player pack_a_punch::get_pap_level( weapon ) )
            {
                return { #icon:function_231bf14e109835e3( var_c56b6ee6272e1ddf ), #description:&"hash_6b790e3be0d3246", #title:function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player ), #string:&"hash_6b790e3be0d3246", #type:"HINT_NOBUTTON" };
            }
        }
        
        if ( var_c56b6ee6272e1ddf.type == "golden_armor" && !player function_698262e196f8aad2() )
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
    }
    
    return function_c06e46bcbdb058e3( interact, player );
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0xc40b98a0, Offset: 0x15812
// Size: 0x28d
function private function_e9e829ce507370b2( var_c56b6ee6272e1ddf, player )
{
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            return &"hash_5aefe2b8b63b871b";
        case #"hash_c7321084b20ece8d":
            return &"shared_hintstrings/aether_crystal";
        case #"hash_c7320d84b20ec9d4":
            return &"shared_hintstrings/aether_crystal_2";
        case #"hash_c7320e84b20ecb67":
            return &"shared_hintstrings/aether_crystal_3";
        case #"hash_c7320b84b20ec6ae":
            return &"hash_408280debfd41ac5";
        case #"hash_be4e031e7acb7b74":
            return &"hash_4426344e3783338a";
        case #"hash_ac7114576080f3cf":
            return &"hash_14fc7ef3aee3f085";
        case #"hash_ab671284a3fc4e3d":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( player ) && player zombie_perks::has_perk( var_c56b6ee6272e1ddf.data ) )
            {
                return &"hash_30c6f5e37b01841c";
            }
            
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.var_a94675d7f0f10828[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.var_a94675d7f0f10828[ var_c56b6ee6272e1ddf.data ];
            }
            
            return &"hash_50aa2bb100357da7";
        case #"hash_17cd1fd5f990f7dd":
            return &"hash_4673ee1a80f1d28b";
        case #"hash_b60679835e82a584":
            return &"hash_410ebd06058237a";
        case #"hash_fdefe402d20f8998":
            return &"hash_6ea4b0007844127e";
        case #"hash_617c0facb611c9cb":
            return &"hash_54f141614c636589";
        case #"hash_622103c8ad3b11c8":
            return &"hash_7b755e12e58440b6";
        case #"hash_47611497d0263858":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.zombie_augments[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.zombie_augments[ var_c56b6ee6272e1ddf.data ].displayname;
            }
            
            return &"hash_7a408164a817e0d6";
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            return function_6c99d3df7f7b87eb( var_c56b6ee6272e1ddf );
    }
    
    return &"hash_32ab8af054278552";
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xaec4f8f4, Offset: 0x15aa8
// Size: 0x268
function private function_231bf14e109835e3( var_c56b6ee6272e1ddf )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) )
    {
        return;
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            return "jup_hud_icon_item_aethertool_legendary";
        case #"hash_c7320b84b20ec6ae":
        case #"hash_c7320d84b20ec9d4":
        case #"hash_c7320e84b20ecb67":
        case #"hash_c7321084b20ece8d":
            return "v_ui_icon_pap_white";
        case #"hash_be4e031e7acb7b74":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.var_9797eca6334f344a[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.var_9797eca6334f344a[ var_c56b6ee6272e1ddf.data ];
            }
            
            return;
        case #"hash_ac7114576080f3cf":
            return "ui_icon_weapon_zm_ww_raygun";
        case #"hash_ab671284a3fc4e3d":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.var_9bcc792067acc484[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.var_9bcc792067acc484[ var_c56b6ee6272e1ddf.data ];
            }
            
            return;
        case #"hash_17cd1fd5f990f7dd":
            return "sat_ui_icon_zm_large_essence_vial";
        case #"hash_b60679835e82a584":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.var_d1f37df33bd2604f[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.var_d1f37df33bd2604f[ var_c56b6ee6272e1ddf.data ];
            }
            
            return;
        case #"hash_fdefe402d20f8998":
            return "sat_ui_icon_zm_ammo_cache";
        case #"hash_617c0facb611c9cb":
            return "sat_ui_icon_zm_armor";
        case #"hash_622103c8ad3b11c8":
            return "sat_ui_icon_zm_armor";
        case #"hash_47611497d0263858":
            return function_4d720a46bf323cdd( var_c56b6ee6272e1ddf.data );
        case #"hash_5ce3bd22c7f44be9":
            return "sat_icon_weapon_seasonal_event_ar_category";
        case #"hash_ab10f9c080fe4faf":
            return "sat_icon_weapon_seasonal_event_sm_category";
        case #"hash_bef5ec0b3e197ae":
            return "sat_icon_weapon_seasonal_event_lm_category";
        case #"hash_5cabb722c7c8b5d9":
            return "sat_icon_weapon_seasonal_event_sh_category";
        case #"hash_5cabb922c7c8b8ff":
            return "sat_icon_weapon_seasonal_event_sn_category";
        case #"hash_5cedda22c7fcc855":
            return "sat_icon_weapon_seasonal_event_dm_category";
        case #"hash_5caede22c7cb31d5":
            return "sat_icon_weapon_seasonal_event_pi_category";
        case #"hash_86b11ac21f992552":
            return "sat_icon_weapon_seasonal_event_me_category";
        default:
            return;
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x883f27f3, Offset: 0x15d18
// Size: 0x1c8
function private function_4d720a46bf323cdd( augment_ref )
{
    if ( !isdefined( augment_ref ) )
    {
        return;
    }
    
    foreach ( str_perk, a_augments in level.var_98451248a70b7bb3 )
    {
        if ( arraycontains( a_augments, augment_ref ) && isdefined( level.var_9bcc792067acc484[ str_perk ] ) )
        {
            return level.var_9bcc792067acc484[ str_perk ];
        }
    }
    
    foreach ( var_4c506782108851c7, a_augments in level.var_6c3426d7b2e5e264 )
    {
        if ( arraycontains( a_augments, augment_ref ) && isdefined( level.var_9797eca6334f344a[ var_4c506782108851c7 ] ) )
        {
            return level.var_9797eca6334f344a[ var_4c506782108851c7 ];
        }
    }
    
    foreach ( str_super, a_augments in level.var_151effd1b9580cae )
    {
        if ( arraycontains( a_augments, augment_ref ) && isdefined( level.var_d1f37df33bd2604f[ str_super ] ) )
        {
            return level.var_d1f37df33bd2604f[ str_super ];
        }
    }
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x2f562705, Offset: 0x15ee9
// Size: 0xab
function private function_6c99d3df7f7b87eb( var_c56b6ee6272e1ddf )
{
    if ( isdefined( var_c56b6ee6272e1ddf.data.pap_level ) )
    {
        switch ( var_c56b6ee6272e1ddf.data.pap_level )
        {
            case 0:
                return &"hash_719675b1125e64df";
            case 1:
                return &"hash_719676b1125e6692";
            case 2:
                return &"hash_719677b1125e6845";
            case 3:
                return &"hash_719670b1125e5c60";
        }
    }
    
    return get_weapon_class_title( var_c56b6ee6272e1ddf.type );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x2c146889, Offset: 0x15f9d
// Size: 0xdc
function private get_weapon_class_title( str_type )
{
    switch ( str_type )
    {
        case #"hash_5ce3bd22c7f44be9":
            return &"hash_6693b4bc25c04e6b";
        case #"hash_ab10f9c080fe4faf":
            return &"hash_12b4f9b3dff6d4c9";
        case #"hash_bef5ec0b3e197ae":
            return &"hash_62134ab40d52216c";
        case #"hash_5cabb722c7c8b5d9":
            return &"hash_6663babc259734db";
        case #"hash_5cabb922c7c8b8ff":
            return &"hash_6663c0bc25973f0d";
        case #"hash_5cedda22c7fcc855":
            return &"hash_669dbdbc25c8b23b";
        case #"hash_5caede22c7cb31d5":
            return &"hash_6659b9bc258edea3";
        case #"hash_86b11ac21f992552":
            return &"hash_6685a9bc25b3fe5e";
        default:
            return &"hash_32ab8af054278552";
    }
}

// Namespace zm_rb_echo
// Params 2, eflags: 0x4
// Checksum 0x117e06b6, Offset: 0x16081
// Size: 0x384
function private get_reward_hint_string( var_c56b6ee6272e1ddf, player = undefined )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) )
    {
        return &"hash_5e582de3a5810baf";
    }
    
    switch ( var_c56b6ee6272e1ddf.type )
    {
        case #"hash_4e20f52fe10f267d":
            return &"hash_29260fefa6f4576b";
        case #"hash_c7321084b20ece8d":
            return &"shared_hintstrings/aether_crystal_desc";
        case #"hash_c7320d84b20ec9d4":
            return &"shared_hintstrings/aether_crystal_2_desc";
        case #"hash_c7320e84b20ecb67":
            return &"shared_hintstrings/aether_crystal_3_desc";
        case #"hash_c7320b84b20ec6ae":
            return &"hash_588ee5316645c98f";
        case #"hash_be4e031e7acb7b74":
            var_5a74003d195f2cde = var_c56b6ee6272e1ddf.data;
            
            if ( isdefined( var_5a74003d195f2cde ) && isdefined( level.var_3f3e6e7f86bf475a[ var_5a74003d195f2cde ] ) )
            {
                return level.var_3f3e6e7f86bf475a[ var_5a74003d195f2cde ];
            }
            
            return &"hash_16fb88ffffb2357a";
        case #"hash_ac7114576080f3cf":
            return &"hash_3c5f2d57a85c9c15";
        case #"hash_ab671284a3fc4e3d":
            str_perk = var_c56b6ee6272e1ddf.data;
            
            if ( isdefined( player ) && isdefined( str_perk ) )
            {
                if ( player zombie_perks::has_permanent_perk( str_perk ) )
                {
                    return &"hash_2bbb07d2258043b9";
                }
                
                if ( player zombie_perks::has_perk( str_perk ) )
                {
                    return &"hash_42d575fdf0ee8037";
                }
            }
            
            if ( isdefined( str_perk ) && isdefined( level.var_4ad95315c22d9719[ str_perk ] ) )
            {
                return level.var_4ad95315c22d9719[ str_perk ];
            }
            
            return &"hash_e36be551b6b9477";
        case #"hash_17cd1fd5f990f7dd":
            return &"hash_6b3659a90cccd2fb";
        case #"hash_b60679835e82a584":
            str_super = var_c56b6ee6272e1ddf.data;
            
            if ( isdefined( str_super ) && isdefined( level.var_cb67e4cb2ce9c0f8[ str_super ] ) )
            {
                return level.var_cb67e4cb2ce9c0f8[ str_super ];
            }
            
            return &"hash_7951c51a0048f12a";
        case #"hash_fdefe402d20f8998":
            return &"hash_a0b4a5178652ce";
        case #"hash_617c0facb611c9cb":
            return &"hash_6ef24eec91cec1f9";
        case #"hash_622103c8ad3b11c8":
            return &"hash_7bc05913e0911ce6";
        case #"hash_47611497d0263858":
            if ( isdefined( var_c56b6ee6272e1ddf.data ) && isdefined( level.zombie_augments[ var_c56b6ee6272e1ddf.data ] ) )
            {
                return level.zombie_augments[ var_c56b6ee6272e1ddf.data ].description;
            }
            
            return &"hash_30e62bcc302ccd86";
        case #"hash_bef5ec0b3e197ae":
        case #"hash_5cabb722c7c8b5d9":
        case #"hash_5cabb922c7c8b8ff":
        case #"hash_5caede22c7cb31d5":
        case #"hash_5ce3bd22c7f44be9":
        case #"hash_5cedda22c7fcc855":
        case #"hash_86b11ac21f992552":
        case #"hash_ab10f9c080fe4faf":
            str_hint_key = var_c56b6ee6272e1ddf.data.class + "_" + var_c56b6ee6272e1ddf.data.rarity;
            
            if ( isdefined( level.var_1488e4d2a4ace466[ str_hint_key ] ) )
            {
                return level.var_1488e4d2a4ace466[ str_hint_key ];
            }
            
            return get_weapon_class_title( var_c56b6ee6272e1ddf.type );
        default:
            return &"hash_5e582de3a5810baf";
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0xd22b5834, Offset: 0x1640d
// Size: 0xa5, Type: bool
function private function_f33a503af3b09058()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !function_50049dbed5208dcc( player ) )
        {
            continue;
        }
        
        if ( !arraycontains( level.var_2099a31bd7242769, player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x40382c44, Offset: 0x164bb
// Size: 0xa2, Type: bool
function private function_50049dbed5208dcc( player )
{
    var_b21381d2422a875e = player getentitynumber();
    
    foreach ( s_portal in level.echo_portals )
    {
        if ( isdefined( s_portal.var_bb0ff47788a6c592[ var_b21381d2422a875e ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0x4fb7d967, Offset: 0x16566
// Size: 0x2c3
function private on_portal_used( player )
{
    if ( arraycontains( level.var_2099a31bd7242769, player ) && !getdvarint( @"hash_eb4fedb357252325", 0 ) )
    {
        return;
    }
    
    var_1ee5c708ea46e6ec = self.echo_portal;
    
    if ( !isdefined( var_1ee5c708ea46e6ec ) )
    {
        /#
            if ( !false )
            {
                if ( getdvarint( @"hash_446b797b170dee3e", 0 ) )
                {
                    assert( 0, "<dev string:x566>" + "<dev string:x1019>" );
                    return;
                }
                
                println( "<dev string:x5a6>" + "<dev string:x1019>" );
            }
        #/
        
        return;
    }
    
    if ( var_1ee5c708ea46e6ec.var_cca27ca21b2f6053 == 1 && !arraycontains( var_1ee5c708ea46e6ec.var_d7131cd77791a040, player ) )
    {
        return;
    }
    
    var_9f12c0a56c8cc4c9 = var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ];
    weapon = player getcurrentweapon();
    
    if ( isdefined( var_9f12c0a56c8cc4c9 ) && ( player is_holding_wonder_weapon() || !ammo_mod::function_7bbc1db07694f31d( weapon ) ) )
    {
        if ( var_9f12c0a56c8cc4c9.type == "ammo_mod" || var_9f12c0a56c8cc4c9.type == "rarity_upgrade" )
        {
            return;
        }
    }
    
    if ( isdefined( var_9f12c0a56c8cc4c9 ) && var_9f12c0a56c8cc4c9.type == "rarity_upgrade" )
    {
        var_bc04d89890b0d04d = player function_e86e9a96bffedef9();
        rarity = player item_weapon::function_fb81bd2fe070faa6( weapon );
        
        if ( rarity >= var_bc04d89890b0d04d )
        {
            return;
        }
    }
    
    if ( isdefined( var_9f12c0a56c8cc4c9 ) && ( var_9f12c0a56c8cc4c9.type == "pap1" || var_9f12c0a56c8cc4c9.type == "pap2" || var_9f12c0a56c8cc4c9.type == "pap3" || var_9f12c0a56c8cc4c9.type == "pap4" ) )
    {
        if ( !isdefined( weapon ) || weapon == level.weaponnone || !player pack_a_punch::can_pap( weapon ) || var_9f12c0a56c8cc4c9.data <= player pack_a_punch::get_pap_level( weapon ) )
        {
            return;
        }
    }
    
    if ( isdefined( var_9f12c0a56c8cc4c9 ) && var_9f12c0a56c8cc4c9.type == "golden_armor" && !player function_698262e196f8aad2() )
    {
        return;
    }
    
    level.var_2099a31bd7242769[ level.var_2099a31bd7242769.size ] = player;
    
    /#
        iprintlnbold( "<dev string:xb76>" + player.name + "<dev string:x1057>" + var_1ee5c708ea46e6ec.echo_portal_index + "<dev string:x1065>" + level.var_2099a31bd7242769.size + "<dev string:x1068>" );
    #/
    
    player setclientomnvar( "ui_zm_echo_chose_portal_reward", 1 );
    var_9f12c0a56c8cc4c9 = var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ];
    
    if ( !isdefined( var_9f12c0a56c8cc4c9 ) )
    {
        return;
    }
    
    player thread function_3e7d12b2211c0759( var_9f12c0a56c8cc4c9 );
}

// Namespace zm_rb_echo
// Params 1, eflags: 0x4
// Checksum 0xcd111053, Offset: 0x16831
// Size: 0x3a5
function private function_3e7d12b2211c0759( var_c56b6ee6272e1ddf )
{
    self endon( #"disconnect" );
    a_spawns = function_74774640cf9afce4( level.echo_destination.str_set_name );
    randomized_zones = arrayrandomize( a_spawns );
    
    foreach ( goal_zone in randomized_zones )
    {
        var_3bdd455166e4e8ee = zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, [ goal_zone ] );
        
        if ( isdefined( var_3bdd455166e4e8ee ) )
        {
            break;
        }
    }
    
    if ( isdefined( var_3bdd455166e4e8ee ) )
    {
        v_teleport_dest = var_3bdd455166e4e8ee.origin;
        var_b5d94448829ca237 = var_3bdd455166e4e8ee.angles ?? ( 0, 0, 0 );
    }
    else
    {
        v_destination = level.echo_destination.origin;
        n_offset = self getentitynumber() * 48;
        v_right = anglestoright( level.echo_destination.angles ?? ( 0, 0, 0 ) );
        v_offset_dest = v_destination + v_right * n_offset;
        v_teleport_dest = getclosestpointonnavmesh( v_offset_dest, 128 );
        
        if ( !isdefined( v_teleport_dest ) )
        {
            v_teleport_dest = getclosestpointonnavmesh( v_destination, 128 );
        }
        
        if ( !isdefined( v_teleport_dest ) )
        {
            v_teleport_dest = v_destination;
        }
        
        var_b5d94448829ca237 = level.echo_destination.angles ?? ( 0, 0, 0 );
    }
    
    if ( self isonladder() )
    {
        val::set( #"hash_d8530a1b1d84c15b", "ladder", 0 );
        var_12574d85e5170df = 1;
        waitframe();
    }
    
    function_6ab2d29fcf633acd();
    playfx( level._effect[ "echo_portal_teleport_3p" ], self.origin );
    thread zm_fasttravel::function_60628df0e15b562b();
    thread zm_utility::teleport_player( v_teleport_dest, var_b5d94448829ca237, "echo_portal_teleport", 0, 1, -1, -1 );
    self setclientomnvar( "ui_hide_hud", 1 );
    wait 5;
    
    if ( level.echo_destination.str_set_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
    {
        self function_d88e8eab88c50c13( 1 );
    }
    
    self setclientomnvar( "ui_hide_hud", 0 );
    
    if ( var_12574d85e5170df )
    {
        val::set( #"hash_d8530a1b1d84c15b", "ladder", 1 );
    }
    
    self setclientomnvar( "ui_zm_echo_portal_timer_vis", 0 );
    wait 0.5;
    
    if ( isdefined( var_c56b6ee6272e1ddf ) )
    {
        grant_reward( var_c56b6ee6272e1ddf );
        
        /#
            iprintlnbold( "<dev string:xba1>" + self.name + "<dev string:x1071>" + get_reward_display_name( var_c56b6ee6272e1ddf ) );
        #/
        
        wait 4;
        
        if ( level.var_9df5a7fab79cbd5e )
        {
            self setclientomnvar( "ui_zm_echo_portal_timer_vis", 1 );
        }
    }
    
    var_3df86f0b126863ab = self getweaponslistprimaries();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( !weapon.ismeleeweapon )
        {
            self setweaponammoclip( weapon, weapon.clipsize );
        }
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x3870aa04, Offset: 0x16bde
// Size: 0x1d5
function private function_2a46d382a4123572()
{
    self endon( #"disconnect" );
    thread function_b48b27cf80b32416();
    wait 0.3;
    a_spawns = function_74774640cf9afce4( level.echo_destination.str_set_name );
    str_random_spawn = utility::array_random( a_spawns );
    var_3bdd455166e4e8ee = zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, [ str_random_spawn ] );
    
    if ( isdefined( var_3bdd455166e4e8ee ) )
    {
        v_teleport_dest = var_3bdd455166e4e8ee.origin;
        var_b5d94448829ca237 = var_3bdd455166e4e8ee.angles ?? ( 0, 0, 0 );
    }
    else
    {
        v_destination = level.echo_destination.origin;
        n_offset = self getentitynumber() * 48;
        v_right = anglestoright( level.echo_destination.angles ?? ( 0, 0, 0 ) );
        v_offset_dest = v_destination + v_right * n_offset;
        v_teleport_dest = getclosestpointonnavmesh( v_offset_dest, 128 );
        
        if ( !isdefined( v_teleport_dest ) )
        {
            v_teleport_dest = getclosestpointonnavmesh( v_destination, 128 );
        }
        
        if ( !isdefined( v_teleport_dest ) )
        {
            v_teleport_dest = v_destination;
        }
        
        var_b5d94448829ca237 = level.echo_destination.angles ?? ( 0, 0, 0 );
    }
    
    playfx( level._effect[ "echo_portal_teleport_3p" ], self.origin );
    thread zm_fasttravel::function_60628df0e15b562b();
    thread zm_utility::teleport_player( v_teleport_dest, var_b5d94448829ca237, "echo_portal_teleport", 0, 1, -1, -1 );
    wait 5;
    
    if ( level.echo_destination.str_set_name == level.var_2add2332a4635bbb.var_4aa676077979d1dd )
    {
        self function_d88e8eab88c50c13( 1 );
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x2d542b05, Offset: 0x16dbb
// Size: 0x2f1
function private cleanup_echo_portals()
{
    level notify( #"echo_portal_cleanup" );
    
    foreach ( s_portal in level.echo_portals )
    {
        if ( !isdefined( s_portal ) )
        {
            continue;
        }
        
        if ( isdefined( s_portal.e_collision_blocker ) )
        {
            s_portal.e_collision_blocker delete();
        }
        
        if ( s_portal.var_ea6ac752e9068235 )
        {
            foreach ( mdl in s_portal.var_ea6ac752e9068235 )
            {
                mdl delete();
            }
        }
        
        if ( isdefined( s_portal.var_1a5d876d83f4dd2c ) )
        {
            foreach ( var_b21381d2422a875e, e_sign in s_portal.var_1a5d876d83f4dd2c )
            {
                if ( isdefined( e_sign ) )
                {
                    e_sign delete();
                }
            }
        }
        
        if ( isdefined( s_portal.var_3caab10004e1d159 ) )
        {
            foreach ( var_b21381d2422a875e, e_sign in s_portal.var_3caab10004e1d159 )
            {
                if ( isdefined( e_sign ) )
                {
                    e_sign delete();
                }
            }
        }
        
        if ( isdefined( s_portal.echo_interact ) )
        {
            s_portal.echo_interact makeunusable();
            s_portal.echo_interact delete();
        }
        
        if ( isdefined( s_portal.a_player_scriptables ) )
        {
            foreach ( var_b21381d2422a875e, e_scriptable in s_portal.a_player_scriptables )
            {
                if ( isdefined( e_scriptable ) )
                {
                    e_scriptable freescriptable();
                }
            }
        }
    }
    
    level.echo_portals = [];
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x6b1a28be, Offset: 0x170b4
// Size: 0x4, Type: bool
function private zm_rb_echo_delay()
{
    return true;
}

/#

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x4f678aa6, Offset: 0x170c1
    // Size: 0x121, Type: dev
    function private function_3624618e424812c4()
    {
        iprintlnbold( "<dev string:x107c>" );
        
        for ( i = 0; i < level.var_f6902967d180948a.size ; i++ )
        {
            var_1344b6c6ccd6e526 = level.var_f6902967d180948a[ i ];
            var_f88478ff8ed3fc7 = "<dev string:x1097>";
            
            if ( isdefined( var_1344b6c6ccd6e526.max_round ) )
            {
                var_f88478ff8ed3fc7 = "<dev string:x82d>" + var_1344b6c6ccd6e526.max_round;
            }
            
            var_d732afcaccef6bc9 = "<dev string:x1097>";
            
            if ( isdefined( var_1344b6c6ccd6e526.min_round ) )
            {
                var_d732afcaccef6bc9 = "<dev string:x82d>" + var_1344b6c6ccd6e526.min_round;
            }
            
            str_extra = "<dev string:x82d>";
            
            if ( isdefined( var_1344b6c6ccd6e526.pap_level ) )
            {
                str_extra = "<dev string:x109c>" + var_1344b6c6ccd6e526.pap_level;
            }
            
            iprintlnbold( "<dev string:x10a5>" + i + "<dev string:x10a7>" + var_1344b6c6ccd6e526.type + "<dev string:x10aa>" + var_1344b6c6ccd6e526.weight + "<dev string:x10b6>" + var_d732afcaccef6bc9 + "<dev string:x10c2>" + var_f88478ff8ed3fc7 + str_extra );
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x9f9e0588, Offset: 0x171ea
    // Size: 0x112, Type: dev
    function private function_de92d726f0a2c888()
    {
        n_round = level.round_number ?? 1;
        player = level.players[ 0 ];
        n_total_weight = 0;
        iprintlnbold( "<dev string:x10c4>" + n_round + "<dev string:x10e1>" );
        
        for ( i = 0; i < level.var_f6902967d180948a.size ; i++ )
        {
            var_1344b6c6ccd6e526 = level.var_f6902967d180948a[ i ];
            b_round_ok = function_f50c3a3bfda3f267( var_1344b6c6ccd6e526, n_round );
            var_2aab14866ad0e147 = player function_56c22f196c66c161( var_1344b6c6ccd6e526.type );
            
            if ( b_round_ok && var_2aab14866ad0e147 )
            {
                n_total_weight += var_1344b6c6ccd6e526.weight;
                iprintlnbold( "<dev string:x10a5>" + i + "<dev string:x10a7>" + var_1344b6c6ccd6e526.type + "<dev string:x10aa>" + var_1344b6c6ccd6e526.weight );
            }
        }
        
        iprintlnbold( "<dev string:x10e7>" + n_total_weight );
    }

    // Namespace zm_rb_echo
    // Params 2, eflags: 0x4
    // Checksum 0x3ec8e788, Offset: 0x17304
    // Size: 0xab, Type: dev
    function private function_5a131d883710cae1( n_index, var_a58b9f66285b1c55 )
    {
        if ( n_index < 0 || n_index >= level.var_f6902967d180948a.size )
        {
            iprintlnbold( "<dev string:x10f6>" + n_index );
            return;
        }
        
        old_weight = level.var_f6902967d180948a[ n_index ].weight;
        level.var_f6902967d180948a[ n_index ].weight = var_a58b9f66285b1c55;
        iprintlnbold( "<dev string:x1108>" + level.var_f6902967d180948a[ n_index ].type + "<dev string:x110d>" + old_weight + "<dev string:x946>" + var_a58b9f66285b1c55 );
    }

    // Namespace zm_rb_echo
    // Params 2, eflags: 0x4
    // Checksum 0xa9c7d349, Offset: 0x173b7
    // Size: 0xa1, Type: dev
    function private function_70e6a27634d75ada( n_index, n_max_round )
    {
        if ( n_index < 0 || n_index >= level.var_f6902967d180948a.size )
        {
            iprintlnbold( "<dev string:x10f6>" + n_index );
            return;
        }
        
        level.var_f6902967d180948a[ n_index ].max_round = n_max_round;
        str_max = "<dev string:x1097>";
        
        if ( isdefined( n_max_round ) )
        {
            str_max = "<dev string:x82d>" + n_max_round;
        }
        
        iprintlnbold( "<dev string:x1108>" + level.var_f6902967d180948a[ n_index ].type + "<dev string:x1117>" + str_max );
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x2ca2d326, Offset: 0x17460
    // Size: 0x149, Type: dev
    function private function_20a81b7dbd347e3f()
    {
        self endon( #"disconnect" );
        self endon( #"death" );
        
        for ( ;; )
        {
            while ( !getdvarint( @"hash_599f1420bddece94", 0 ) )
            {
                wait 0.5;
            }
            
            setdvar( @"hash_599f1420bddece94", 0 );
            weapon = get_player_primary_weapon();
            
            if ( !isdefined( weapon ) || weapon == level.weaponnone )
            {
                iprintlnbold( "<dev string:x1124>" );
                continue;
            }
            
            item_weapon::function_40e1cbd0e1f47d1a( weapon, 0, 1 );
            n_before = item_weapon::function_fb81bd2fe070faa6( weapon );
            
            if ( !isdefined( self.var_e0b80cc615b06c35 ) )
            {
                self.var_e0b80cc615b06c35 = [];
            }
            
            var_328e37b531357293 = self.var_e0b80cc615b06c35[ "<dev string:x116a>" ];
            self.var_e0b80cc615b06c35[ "<dev string:x116a>" ] = 1;
            prev_is_hotjoin = self.var_282313ba8fafa8c6;
            self.var_282313ba8fafa8c6 = 1;
            function_ccfdc1c153aef79();
            self.var_282313ba8fafa8c6 = prev_is_hotjoin;
            self.var_e0b80cc615b06c35[ "<dev string:x116a>" ] = var_328e37b531357293;
            n_after = item_weapon::function_fb81bd2fe070faa6( weapon );
            iprintlnbold( "<dev string:x117c>" + n_before + "<dev string:x946>" + n_after );
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x1e46e5cf, Offset: 0x175b1
    // Size: 0xbc0, Type: dev
    function private function_d113bbec975d1d13()
    {
        self endon( #"disconnect" );
        self endon( #"death" );
        level utility::flag_wait( "<dev string:x11b7>" );
        
        while ( !getdvarint( @"hash_eb4fedb357252325", 0 ) )
        {
            wait 1;
        }
        
        zm_round_spawning::pause_round_spawning( 1, "<dev string:x11c9>" );
        
        if ( isdefined( level.var_4c9111b731176f ) )
        {
            var_e6addf73de340819 = level.var_4c9111b731176f[ 0 ];
            var_3e2f7dfa7bb86372 = getclosestpointonnavmesh( var_e6addf73de340819.origin, 128 );
            
            if ( !isdefined( var_3e2f7dfa7bb86372 ) )
            {
                var_3e2f7dfa7bb86372 = var_e6addf73de340819.origin;
            }
            
            self setorigin( var_3e2f7dfa7bb86372 );
            self setplayerangles( var_e6addf73de340819.angles );
            wait 0.5;
            iprintlnbold( "<dev string:x11d6>" );
        }
        else
        {
            iprintlnbold( "<dev string:x1203>" );
        }
        
        v_origin = self.origin;
        v_forward = anglestoforward( self.angles );
        v_right = anglestoright( self.angles );
        v_angles = self.angles;
        level.var_cdd40897b4d30c96 = v_origin;
        level.var_e1caac2208c2b34c = v_angles;
        var_f9fe83157fb8e5ef = [ { #type:"<dev string:x1254>" }, { #data:1, #type:"<dev string:x1263>" }, { #data:2, #type:"<dev string:x1268>" }, { #data:3, #type:"<dev string:x126d>" }, { #data:4, #type:"<dev string:x1272>" }, { #data:"<dev string:x1285>", #type:"<dev string:x1277>" }, { #data:5000, #type:"<dev string:x1296>" }, { #type:"<dev string:x129e>" }, { #type:"<dev string:x12ad>" }, { #type:"<dev string:x12bb>" } ];
        var_f9fe82157fb8e3bc = [ { #data:{ #pap_level:0, #rarity:5, #class:"<dev string:x12d2>" }, #type:"<dev string:x12c8>" }, { #data:{ #pap_level:0, #rarity:5, #class:"<dev string:x12e0>" }, #type:"<dev string:x12d5>" }, { #data:{ #pap_level:1, #rarity:5, #class:"<dev string:x12ef>" }, #type:"<dev string:x12e4>" }, { #data:{ #pap_level:1, #rarity:5, #class:"<dev string:x12fd>" }, #type:"<dev string:x12f3>" }, { #data:{ #pap_level:2, #rarity:5, #class:"<dev string:x130a>" }, #type:"<dev string:x1300>" }, { #data:{ #pap_level:2, #rarity:5, #class:"<dev string:x1317>" }, #type:"<dev string:x130d>" }, { #data:{ #pap_level:3, #rarity:5, #class:"<dev string:x1324>" }, #type:"<dev string:x131a>" }, { #data:{ #pap_level:3, #rarity:5, #class:"<dev string:x1334>" }, #type:"<dev string:x1327>" } ];
        var_f9fe85157fb8ea55 = [ { #data:"<dev string:x133c>", #type:"<dev string:x1337>" }, { #data:"<dev string:x1350>", #type:"<dev string:x1337>" }, { #data:"<dev string:x1366>", #type:"<dev string:x1337>" }, { #data:"<dev string:x137a>", #type:"<dev string:x1337>" }, { #data:"<dev string:x138d>", #type:"<dev string:x1337>" }, { #data:"<dev string:x13a0>", #type:"<dev string:x1337>" }, { #data:"<dev string:x13bb>", #type:"<dev string:x1337>" }, { #data:"<dev string:x13d3>", #type:"<dev string:x1337>" }, { #data:"<dev string:x13e9>", #type:"<dev string:x1337>" }, { #data:"<dev string:x13ff>", #type:"<dev string:x1337>" }, { #data:"<dev string:x140f>", #type:"<dev string:x1337>" }, { #data:"<dev string:x141f>", #type:"<dev string:x1337>" }, { #data:"<dev string:x142f>", #type:"<dev string:x1337>" } ];
        var_f9fe80157fb8df56 = [ { #data:"<dev string:x1448>", #type:"<dev string:x143f>" }, { #data:"<dev string:x1451>", #type:"<dev string:x143f>" }, { #data:"<dev string:x145c>", #type:"<dev string:x143f>" }, { #data:"<dev string:x1465>", #type:"<dev string:x143f>" }, { #data:"<dev string:x1470>", #type:"<dev string:x143f>" }, { #data:"<dev string:x147c>", #type:"<dev string:x143f>" }, { #data:"<dev string:x1485>", #type:"<dev string:x143f>" }, { #data:"<dev string:x1492>", #type:"<dev string:x143f>" } ];
        var_f9fe81157fb8e189 = [ { #data:"<dev string:x14ad>", #type:"<dev string:x149f>" }, { #data:"<dev string:x14c1>", #type:"<dev string:x149f>" }, { #data:"<dev string:x14d3>", #type:"<dev string:x149f>" }, { #data:"<dev string:x14e8>", #type:"<dev string:x149f>" }, { #data:"<dev string:x14fa>", #type:"<dev string:x149f>" }, { #data:"<dev string:x150d>", #type:"<dev string:x149f>" }, { #data:"<dev string:x151f>", #type:"<dev string:x149f>" }, { #data:"<dev string:x1530>", #type:"<dev string:x149f>" }, { #data:"<dev string:x1541>", #type:"<dev string:x149f>" }, { #data:"<dev string:x1554>", #type:"<dev string:x149f>" } ];
        var_f9fe7e157fb8daf0 = [];
        
        foreach ( augment_ref in level.var_98451248a70b7bb3[ "<dev string:x133c>" ] )
        {
            var_f9fe7e157fb8daf0[ var_f9fe7e157fb8daf0.size ] = { #data:augment_ref, #type:"<dev string:x1564>" };
        }
        
        foreach ( augment_ref in level.var_98451248a70b7bb3[ "<dev string:x137a>" ] )
        {
            var_f9fe7e157fb8daf0[ var_f9fe7e157fb8daf0.size ] = { #data:augment_ref, #type:"<dev string:x1564>" };
        }
        
        foreach ( augment_ref in level.var_6c3426d7b2e5e264[ "<dev string:x1465>" ] )
        {
            var_f9fe7e157fb8daf0[ var_f9fe7e157fb8daf0.size ] = { #data:augment_ref, #type:"<dev string:x1564>" };
        }
        
        var_f9fe7f157fb8dd23 = [];
        
        foreach ( augment_ref in level.var_98451248a70b7bb3[ "<dev string:x142f>" ] )
        {
            var_f9fe7f157fb8dd23[ var_f9fe7f157fb8dd23.size ] = { #data:augment_ref, #type:"<dev string:x1564>" };
        }
        
        var_f9fe8c157fb8f9ba = function_a90c5330e4b4abdc();
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 200, var_f9fe85157fb8ea55 );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 400, var_f9fe82157fb8e3bc );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 600, var_f9fe83157fb8e5ef );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 800, var_f9fe80157fb8df56 );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 1000, var_f9fe81157fb8e189 );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 1200, var_f9fe7e157fb8daf0 );
        function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 1400, var_f9fe7f157fb8dd23 );
        
        if ( isdefined( var_f9fe8c157fb8f9ba ) && var_f9fe8c157fb8f9ba.size )
        {
            function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, 1600, var_f9fe8c157fb8f9ba );
        }
        
        n_event_reward_count = 0;
        
        if ( isdefined( var_f9fe8c157fb8f9ba ) )
        {
            n_event_reward_count = var_f9fe8c157fb8f9ba.size;
        }
        
        iprintlnbold( "<dev string:x156c>" + var_f9fe85157fb8ea55.size + var_f9fe82157fb8e3bc.size + var_f9fe83157fb8e5ef.size + var_f9fe80157fb8df56.size + var_f9fe81157fb8e189.size + var_f9fe7e157fb8daf0.size + var_f9fe7f157fb8dd23.size + n_event_reward_count + "<dev string:x1589>" );
    }

    // Namespace zm_rb_echo
    // Params 6, eflags: 0x4
    // Checksum 0x5878221c, Offset: 0x18179
    // Size: 0xd4, Type: dev
    function private function_bde527fb9fad60c5( v_origin, v_forward, v_right, v_angles, n_forward_dist, a_rewards )
    {
        n_half = ( a_rewards.size - 1 ) * 0.5;
        var_1264ec0f1e7016c1 = v_origin + v_forward * n_forward_dist;
        
        for ( i = 0; i < a_rewards.size ; i++ )
        {
            v_pos = var_1264ec0f1e7016c1 + v_right * ( i - n_half ) * 150;
            v_nav = getclosestpointonnavmesh( v_pos, 128 );
            
            if ( !isdefined( v_nav ) )
            {
                v_nav = utility::drop_to_ground( v_pos );
                
                if ( !isdefined( v_nav ) )
                {
                    v_nav = v_pos;
                }
            }
            
            level thread function_cbcaac06867ffaff( v_nav, v_angles, a_rewards[ i ] );
            wait 0.05;
        }
    }

    // Namespace zm_rb_echo
    // Params 3, eflags: 0x4
    // Checksum 0x8e91b9ba, Offset: 0x18255
    // Size: 0x299, Type: dev
    function private function_cbcaac06867ffaff( v_origin, v_angles, var_c56b6ee6272e1ddf )
    {
        v_spawn_origin = v_origin + ( 0, 0, 0 );
        v_interact_origin = v_origin + ( 0, 0, 24 );
        var_7c170ceae0649b57 = [ #"teamselect", level.players[ 0 ] getentitynumber() ];
        var_1ee5c708ea46e6ec = spawnscriptable( "<dev string:x15cb>", v_spawn_origin, v_angles, undefined, var_7c170ceae0649b57 );
        
        if ( !isdefined( var_1ee5c708ea46e6ec ) )
        {
            iprintlnbold( "<dev string:x15ee>" + var_c56b6ee6272e1ddf.type );
            return;
        }
        
        waitframe();
        var_1ee5c708ea46e6ec setscriptablepartstate( "<dev string:x1632>", "<dev string:x1637>" );
        str_glow = function_99c679ed8d8117ea( var_c56b6ee6272e1ddf );
        var_1ee5c708ea46e6ec setscriptablepartstate( "<dev string:x163f>", str_glow );
        function_6373aa10b19ac19c( var_1ee5c708ea46e6ec, var_c56b6ee6272e1ddf );
        var_1ee5c708ea46e6ec.var_bb0ff47788a6c592 = [];
        var_1ee5c708ea46e6ec.var_1a5d876d83f4dd2c = [];
        var_1ee5c708ea46e6ec.var_3caab10004e1d159 = [];
        
        foreach ( player in level.players )
        {
            var_1ee5c708ea46e6ec.var_bb0ff47788a6c592[ player getentitynumber() ] = var_c56b6ee6272e1ddf;
        }
        
        var_1ee5c708ea46e6ec.echo_interact = interaction::register_interact( v_interact_origin, 72, &debug_on_portal_used, &function_b702886416f76ab7 );
        
        if ( isdefined( var_1ee5c708ea46e6ec.echo_interact ) )
        {
            var_1ee5c708ea46e6ec.echo_interact.echo_portal = var_1ee5c708ea46e6ec;
            var_1ee5c708ea46e6ec.echo_interact sethintonobstruction( "<dev string:x1644>" );
        }
        
        if ( !isdefined( level.var_b32f6e083bef2dbb ) )
        {
            level.var_b32f6e083bef2dbb = [];
        }
        
        level.var_b32f6e083bef2dbb[ level.var_b32f6e083bef2dbb.size ] = var_1ee5c708ea46e6ec;
        
        foreach ( player in level.players )
        {
            function_691830097f91298a( var_1ee5c708ea46e6ec, var_c56b6ee6272e1ddf, player );
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0xa2c405ef, Offset: 0x184f6
    // Size: 0x27d, Type: dev
    function private function_385f92351045b5e4()
    {
        if ( !isdefined( level.var_b32f6e083bef2dbb ) || !level.var_b32f6e083bef2dbb.size )
        {
            return;
        }
        
        level notify( #"echo_portal_cleanup" );
        
        foreach ( var_1ee5c708ea46e6ec in level.var_b32f6e083bef2dbb )
        {
            if ( !isdefined( var_1ee5c708ea46e6ec ) )
            {
                continue;
            }
            
            if ( isdefined( var_1ee5c708ea46e6ec.var_ea6ac752e9068235 ) )
            {
                foreach ( mdl in var_1ee5c708ea46e6ec.var_ea6ac752e9068235 )
                {
                    if ( isdefined( mdl ) )
                    {
                        mdl delete();
                    }
                }
            }
            
            if ( isdefined( var_1ee5c708ea46e6ec.var_1a5d876d83f4dd2c ) )
            {
                foreach ( var_b21381d2422a875e, e_sign in var_1ee5c708ea46e6ec.var_1a5d876d83f4dd2c )
                {
                    if ( isdefined( e_sign ) )
                    {
                        e_sign delete();
                    }
                }
            }
            
            if ( isdefined( var_1ee5c708ea46e6ec.var_3caab10004e1d159 ) )
            {
                foreach ( var_b21381d2422a875e, e_sign in var_1ee5c708ea46e6ec.var_3caab10004e1d159 )
                {
                    if ( isdefined( e_sign ) )
                    {
                        e_sign delete();
                    }
                }
            }
            
            if ( isdefined( var_1ee5c708ea46e6ec.echo_interact ) )
            {
                var_1ee5c708ea46e6ec.echo_interact makeunusable();
                var_1ee5c708ea46e6ec.echo_interact delete();
            }
            
            var_1ee5c708ea46e6ec freescriptable();
        }
        
        level.var_b32f6e083bef2dbb = [];
    }

    // Namespace zm_rb_echo
    // Params 1, eflags: 0x4
    // Checksum 0xa8370229, Offset: 0x1877b
    // Size: 0x71, Type: dev
    function private debug_on_portal_used( player )
    {
        if ( !isdefined( level.var_cdd40897b4d30c96 ) )
        {
            return;
        }
        
        level.echo_destination = { #str_set_name:level.var_2add2332a4635bbb.var_4aa676077979d1dd, #angles:level.var_e1caac2208c2b34c, #origin:level.var_cdd40897b4d30c96 };
        on_portal_used( player );
    }

    // Namespace zm_rb_echo
    // Params 2, eflags: 0x4
    // Checksum 0x66084d78, Offset: 0x187f4
    // Size: 0x24, Type: dev
    function private function_b702886416f76ab7( interact, player )
    {
        return get_portal_hint( interact, player, 1 );
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x67a408c1, Offset: 0x18820
    // Size: 0x86, Type: dev
    function private function_aac14197b12f159f()
    {
        level endon( #"game_ended" );
        var_847eaff419cc4848 = 0;
        
        while ( true )
        {
            n_dvar_val = getdvarint( @"hash_5543e76325a0516d", 0 );
            
            if ( n_dvar_val == 1 && !var_847eaff419cc4848 )
            {
                var_847eaff419cc4848 = 1;
                iprintlnbold( "<dev string:x1649>" );
                echo_round_wait( undefined );
            }
            else if ( n_dvar_val == 0 && var_847eaff419cc4848 )
            {
                var_847eaff419cc4848 = 0;
                iprintlnbold( "<dev string:x1682>" );
            }
            
            wait 0.1;
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0xe987626a, Offset: 0x188ae
    // Size: 0x8b, Type: dev
    function private function_8e780e0a9a12304d()
    {
        level endon( #"game_ended" );
        level utility::flag_wait( "<dev string:x11b7>" );
        
        while ( true )
        {
            level waittill( #"on_round_start" );
            
            if ( !getdvarint( @"hash_870522f179f53d2a", 0 ) )
            {
                continue;
            }
            
            iprintlnbold( "<dev string:x16ae>" + 5 + "<dev string:x16da>" );
            wait 5;
            
            if ( !getdvarint( @"hash_870522f179f53d2a", 0 ) )
            {
                continue;
            }
            
            iprintlnbold( "<dev string:x16df>" );
            zm_round_logic::function_895fdc21ab019efe();
            zm_utility::util_kill_all_zombies();
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0xda6b9291, Offset: 0x18941
    // Size: 0x10b, Type: dev
    function private init_echo_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1711>" );
        devgui::add_devgui_func( "<dev string:x171a>", "<dev string:x172c>", &function_1bcf6538fbafa870 );
        devgui::add_devgui_func( "<dev string:x1743>", "<dev string:x175e>", &function_9f364e7e5d164d2e );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x177e>" );
        devgui::add_devgui_func( "<dev string:x178a>", "<dev string:x17a3>", &function_96fb8429321b1aa3 );
        
        foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x17bc>" + var_5dc3a271f3cb3d31.key, "<dev string:x17d2>" + var_5dc3a271f3cb3d31.key, &function_8700275375ca8abc );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x97c017f3, Offset: 0x18a54
    // Size: 0x31, Type: dev
    function private function_96fb8429321b1aa3()
    {
        if ( !isplayer( level.player ) )
        {
            iprintlnbold( "<dev string:x17e6>" );
            return;
        }
        
        function_9d160b85ae107fc3( level.player );
    }

    // Namespace zm_rb_echo
    // Params 1, eflags: 0x4
    // Checksum 0xc55814a3, Offset: 0x18a8d
    // Size: 0x102, Type: dev
    function private function_8700275375ca8abc( params )
    {
        if ( !isplayer( level.player ) )
        {
            iprintlnbold( "<dev string:x17e6>" );
            return;
        }
        
        if ( !isdefined( params ) || !params.size )
        {
            iprintlnbold( "<dev string:x1819>" );
            return;
        }
        
        var_9dd3a6b01b6e901b = params[ 0 ];
        
        foreach ( var_5dc3a271f3cb3d31 in level.var_d0ac5374bbc2b3a0 )
        {
            if ( var_5dc3a271f3cb3d31.key == var_9dd3a6b01b6e901b )
            {
                function_5495d51c70af0e5c( level.player, var_5dc3a271f3cb3d31.achievement_id );
                return;
            }
        }
        
        iprintlnbold( "<dev string:x1858>" + var_9dd3a6b01b6e901b + "<dev string:x64>" );
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x155a5c65, Offset: 0x18b97
    // Size: 0x2ed, Type: dev
    function private function_c7309dfde1183ed5()
    {
        level endon( #"game_ended" );
        
        if ( level.players.size != 1 || !isplayer( level.player ) )
        {
            iprintlnbold( "<dev string:x1893>" );
            return;
        }
        
        player = level.player;
        iprintlnbold( "<dev string:x18ea>" );
        
        foreach ( portal_set in level.var_7b14f8737692b012 )
        {
            str_set_name = portal_set[ 0 ].str_set_name;
            player_spawn_locations = function_126347a9a48eab91( str_set_name );
            assert( isdefined( player_spawn_locations ), "<dev string:x44f>" + str_set_name + "<dev string:x1930>" );
            assert( player_spawn_locations.size == 4, "<dev string:x44f>" + str_set_name + "<dev string:x468>" + player_spawn_locations.size + "<dev string:x1956>" + 4 );
            
            foreach ( n_spawn_index, s_spawn in player_spawn_locations )
            {
                assert( isdefined( s_spawn.origin ) && isdefined( s_spawn.angles ), "<dev string:x44f>" + str_set_name + "<dev string:x1976>" + n_spawn_index );
            }
            
            iprintlnbold( "<dev string:x19a4>" + str_set_name + "<dev string:x19ce>" );
            
            foreach ( n_spawn_index, s_spawn in player_spawn_locations )
            {
                if ( !isalive( player ) )
                {
                    iprintlnbold( "<dev string:x19f5>" );
                    return;
                }
                
                iprintlnbold( "<dev string:x1a4e>" + str_set_name + "<dev string:x1a75>" + n_spawn_index + "<dev string:x1a7f>" + s_spawn.origin + "<dev string:x1a84>" );
                player thread function_b48b27cf80b32416();
                wait 0.3;
                player thread function_5287eb22e064817b( s_spawn.origin, s_spawn.angles );
                iprintlnbold( "<dev string:x1a9a>" + n_spawn_index + "<dev string:x1ad0>" );
                level thread function_c6c481ea6df57566();
                level utility::waittill_any_timeout( 20, "<dev string:x1ae9>" );
                level notify( #"hash_e95d9d35e89721a0" );
            }
        }
        
        iprintlnbold( "<dev string:x1b02>" );
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x5c8eba27, Offset: 0x18e8c
    // Size: 0xca, Type: dev
    function private function_c6c481ea6df57566()
    {
        level endon( #"game_ended" );
        level endon( #"hash_e95d9d35e89721a0" );
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( isalive( player ) && ( player usebuttonpressed() || player attackbuttonpressed() ) )
                {
                    iprintlnbold( "<dev string:x1b60>" );
                    level notify( #"hash_587e7b6c30276edf" );
                    return;
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x6a063d7d, Offset: 0x18f5e
    // Size: 0xd, Type: dev
    function private function_9f364e7e5d164d2e()
    {
        level thread function_c7309dfde1183ed5();
    }

    // Namespace zm_rb_echo
    // Params 0, eflags: 0x4
    // Checksum 0x1960d09f, Offset: 0x18f73
    // Size: 0xc7, Type: dev
    function private function_1bcf6538fbafa870()
    {
        level endon( #"game_ended" );
        var_272915a5526bc115 = level.var_ff633893b6fa75c3.var_272915a5526bc115;
        
        if ( !var_272915a5526bc115.size )
        {
            iprintlnbold( "<dev string:x1b95>" );
            return;
        }
        
        n_boss_round = var_272915a5526bc115[ 0 ];
        var_a1d3d44e0fc6f1a9 = n_boss_round - 1;
        iprintlnbold( "<dev string:x1bd2>" + var_a1d3d44e0fc6f1a9 + "<dev string:x1bf4>" + n_boss_round + "<dev string:x1bff>" );
        zm_round_logic::function_68bdb49c82c0f892( var_a1d3d44e0fc6f1a9 );
        level waittill( #"on_round_start" );
        iprintlnbold( "<dev string:x1c04>" + var_a1d3d44e0fc6f1a9 + "<dev string:x1c1a>" );
        wait 1;
        zm_round_logic::function_895fdc21ab019efe();
        zm_utility::util_kill_all_zombies();
        iprintlnbold( "<dev string:x1c36>" + n_boss_round + "<dev string:x1c61>" );
    }

#/

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x89b1ec1c, Offset: 0x19042
// Size: 0x432
function private function_84e945a31804e3ad()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "content_manager_initialized" );
    level utility::flag_wait( "arsenal_ready" );
    var_fd76c2153d0b8db1 = content_manager::get_features_of_type( "arsenal" );
    
    if ( isdefined( var_fd76c2153d0b8db1 ) && var_fd76c2153d0b8db1.size > 0 )
    {
        foreach ( s_feature in var_fd76c2153d0b8db1 )
        {
            if ( isdefined( s_feature.mdl_arsenal ) )
            {
                s_feature.mdl_arsenal utility::ent_flag_wait( "minimap_floor_setup_complete" );
                s_feature.mdl_arsenal thread function_dae72b8886a70018();
            }
        }
    }
    
    level thread utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_arsenal" );
    a_crafting = content_manager::get_features_of_type( "crafting_table" );
    var_1a531c3f3baa1c2 = [];
    
    foreach ( crafting_table in a_crafting )
    {
        if ( crafting_table.script_gameobjectname && !issubstr( level.gametype, crafting_table.script_gameobjectname ) )
        {
            var_1a531c3f3baa1c2[ var_1a531c3f3baa1c2.size ] = crafting_table;
        }
    }
    
    a_crafting = arrayremove( a_crafting, var_1a531c3f3baa1c2 );
    
    if ( isdefined( a_crafting ) && a_crafting.size > 0 )
    {
        content_manager::disable_features( a_crafting, "crafting_table" );
        
        foreach ( s_feature in a_crafting )
        {
            if ( isdefined( s_feature.var_7fac639c5e7fd54 ) )
            {
                s_feature.var_7fac639c5e7fd54 utility::ent_flag_wait( "minimap_floor_setup_complete" );
                s_feature.var_7fac639c5e7fd54 thread function_dae72b8886a70018();
            }
        }
    }
    
    var_298fe7dcdb17fe4f = content_manager::get_features_of_type( "perk_machine" );
    
    if ( isdefined( var_298fe7dcdb17fe4f ) && var_298fe7dcdb17fe4f.size > 0 )
    {
        content_manager::disable_features( var_298fe7dcdb17fe4f, "perk_machine" );
        
        foreach ( s_feature in var_298fe7dcdb17fe4f )
        {
            if ( isdefined( s_feature.mdl_perk_machine ) )
            {
                s_feature.mdl_perk_machine thread function_dae72b8886a70018();
            }
        }
    }
    
    if ( isdefined( level.electric_power_switches ) )
    {
        foreach ( var_c0a89f990cafaa0c in level.electric_power_switches )
        {
            if ( isdefined( var_c0a89f990cafaa0c.interact ) )
            {
                var_c0a89f990cafaa0c.interact makeunusable();
            }
        }
    }
    
    function_afcd3bffccd8de44();
    function_8936108ec9dfe4f9();
    var_843356cf4044d5 = level.var_2add2332a4635bbb.var_83677ce04289f250;
    
    if ( isdefined( var_843356cf4044d5 ) )
    {
        level utility::flag_wait( var_843356cf4044d5 );
    }
    
    if ( isdefined( level.var_2add2332a4635bbb.var_b6f7856c65e288f9 ) )
    {
        level thread [[ level.var_2add2332a4635bbb.var_b6f7856c65e288f9 ]]();
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x24644adf, Offset: 0x1947c
// Size: 0x219
function private function_8936108ec9dfe4f9()
{
    if ( !isdefined( level.var_f301c0b95ea728e2 ) )
    {
        return;
    }
    
    foreach ( s_trap_root in level.var_f301c0b95ea728e2 )
    {
        if ( !isdefined( s_trap_root.power_on_flag ) )
        {
            continue;
        }
        
        s_trap_root.power_on_flag = undefined;
        
        if ( isdefined( s_trap_root.a_switch_pos ) )
        {
            foreach ( switch_pos in s_trap_root.a_switch_pos )
            {
                if ( isdefined( switch_pos.interact ) )
                {
                    switch_pos.interact.state = "buyable";
                }
                
                if ( isdefined( switch_pos.switch_scriptable ) )
                {
                    switch_pos.switch_scriptable setscriptablepartstate( "base", "ready" );
                }
            }
        }
        
        if ( isdefined( s_trap_root.trap_positions ) )
        {
            foreach ( trap_pos in s_trap_root.trap_positions )
            {
                if ( isdefined( trap_pos.trap_scriptable ) )
                {
                    trap_pos.trap_scriptable setscriptablepartstate( "base", "ready" );
                }
            }
        }
    }
}

// Namespace zm_rb_echo
// Params 0, eflags: 0x4
// Checksum 0x91dd74a, Offset: 0x1969d
// Size: 0x19b
function private function_afcd3bffccd8de44()
{
    if ( !isdefined( level.a_jumppads ) )
    {
        return;
    }
    
    level.var_96d4f8dc0c3cfea3 = 1;
    
    foreach ( jumppad in level.a_jumppads )
    {
        if ( isdefined( jumppad.scriptable ) )
        {
            jumppad.scriptable setscriptablepartstate( "light", "offline" );
            jumppad.scriptable setscriptablepartstate( "left_monitor", "offline" );
            jumppad.scriptable setscriptablepartstate( "right_monitor", "offline" );
            jumppad.scriptable setscriptablepartstate( "ping", "off" );
            jumppad.scriptable thread function_dae72b8886a70018();
        }
        
        if ( isdefined( jumppad.mdl_arrow_scriptable ) )
        {
            jumppad.mdl_arrow_scriptable setscriptablepartstate( "left_arrow", "offline" );
            jumppad.mdl_arrow_scriptable setscriptablepartstate( "right_arrow", "offline" );
        }
        
        if ( isdefined( jumppad.landingpad ) )
        {
            jumppad.landingpad setscriptablepartstate( "light", "no_power" );
            jumppad.landingpad setscriptablepartstate( "ping", "off" );
        }
    }
}

// Namespace zm_rb_echo
// Params 0
// Checksum 0xc3d682aa, Offset: 0x19840
// Size: 0x41
function function_dae72b8886a70018()
{
    if ( !self isscriptable() && !self isscriptableinstance() )
    {
        return;
    }
    
    if ( !self getscriptablehaspart( "icon" ) )
    {
        return;
    }
    
    utility::ent_flag_wait( "minimap_floor_setup_complete" );
    self setscriptablepartstate( "icon", "idle" );
}

