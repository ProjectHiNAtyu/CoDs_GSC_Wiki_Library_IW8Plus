// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_training_course.gsc  (hash_348c82d9ed961912.gscc) (size: 8714 Bytes / 0x220a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9cc2c0a (3922471946)
// size ...... 8714 (0x220a)
// includes .. 15  (offset: 0x1eea)
// strings ... 50  (offset: 0x1f62)
// dev strs .. 1   (offset: 0x21fe)
// exports ... 26  (offset: 0x118e)
// cseg ...... 0x58f + 0xbff (0x118e)
// imports ... 77  (offset: 0x159e)
// animtree1 . 0   (offset: 0x220a)
// animtree2 . 0   (offset: 0x220a)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\bots\bots;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common_training_course;
#using scripts\mp\interaction;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pack_a_punch;
#using scripts\mp\perk_machines;
#using scripts\mp\zm\gametypes\training_course;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_firefly_training_course;

// Namespace zm_sat_firefly_training_course
// Params 0, eflags: 0x5
// Checksum 0xd8ae7260, Offset: 0x5ad
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_training_course", undefined, undefined, &post_init );
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x5ac738d3, Offset: 0x5ce
// Size: 0x9
function post_init()
{
    init_training_course();
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x8408e13f, Offset: 0x5df
// Size: 0x487
function init_training_course()
{
    if ( level.gametype != "zm_training_course" )
    {
        m_mod_slick = getent( "training_course_m_mod_clip", #targetname );
        
        if ( isdefined( m_mod_slick ) )
        {
            m_mod_slick delete();
        }
        
        return;
    }
    
    utility::registersharedfunc( #"zm_training_course", #"hash_16bbb95c1445ab30", &function_cfd549d3b517d5d7 );
    utility::registersharedfunc( #"zm_training_course", #"hash_4b007afd0ee58bf5", &function_8891f0045d953656 );
    utility::registersharedfunc( #"zm_training_course", #"hash_6960518184a79f8a", &function_8529c738ae472da7 );
    utility::registersharedfunc( #"zm_training_course", #"hash_391416dc7af79661", &function_6349ef9a6d9b8dc1 );
    utility::registersharedfunc( #"zm_training_course", #"hash_6ffb1cc9fe4e2a2c", &function_3f34684009adab33 );
    utility::registersharedfunc( #"zm_training_course", #"hash_b3c16b6a92965d26", &function_2e194f7a24e2a167 );
    utility::registersharedfunc( #"zm_training_course", #"hash_8775d7c2b0206b4f", &function_fb1010871dfb8930 );
    utility::registersharedfunc( #"zm_training_course", #"hash_bb09f555d7eb17d8", &function_55048cea52309e6f );
    utility::registersharedfunc( #"zm_training_course", #"hash_ef0442be4157154", &function_489160069d773bc1 );
    utility::registersharedfunc( #"zm_training_course", #"hash_d90d9dc519b1dcdb", &function_5360bf714f709210 );
    utility::registersharedfunc( #"perk_machine", #"hash_dce0d2ce4dd5c816", &function_cb9879effffb73b5 );
    utility::registersharedfunc( #"zm_training_course", #"hash_b96b1e6732a96908", &function_c458239334898ff );
    utility::registersharedfunc( #"zm_training_course", #"hash_1bd21ef18846d762", &function_c7850f5200526983 );
    utility::registersharedfunc( #"zm_training_course", #"hash_195f203d03088d84", &function_24772f3926b2aa71 );
    utility::registersharedfunc( #"zm_training_course", #"hash_70c5a48db480e546", &function_1412df7f7334b60f );
    utility::registersharedfunc( #"zm_training_course", #"hash_b02a2a8452300ba8", &function_9bc3e1de4d552b05 );
    utility::registersharedfunc( #"zm_training_course", #"hash_c4d85b5fed40904a", &function_4cb96402dbce8b25 );
    utility::registersharedfunc( #"zm_training_course", #"hash_25ee19c5f56e5431", &function_a3caab6ab9ce1a0a );
    utility::registersharedfunc( #"zm_training_course", #"hash_edeba11d47bd605e", &function_86af15e18a6a5ca );
    utility::registersharedfunc( #"zm_sat_exfil", #"hash_47c6e605071f9f2a", &function_c49560448cdc2375 );
    utility::registersharedfunc( #"zm_training_course", #"hash_929930c8609230f3", &function_9f01e92bc745daa4 );
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_set( "power_on2" );
    zone_manager::set_zone_enabled( "zone_farm", 1 );
    zone_manager::set_zone_enabled( "zone_farm_close_to_tower", 1 );
    level.challengesallowed = 0;
    var_ef5c80f53fe457fc = utility::getstruct( "survival_pap_set_zone_farm", "targetname" );
    
    if ( !isdefined( level.var_db52bcfd04d45a7a ) )
    {
        level.var_db52bcfd04d45a7a = [];
    }
    
    level.var_db52bcfd04d45a7a[ level.var_db52bcfd04d45a7a.size ] = var_ef5c80f53fe457fc;
    var_ef5c80f53fe457fc thread pack_a_punch::init_pap_machine();
    training_course::open_door( "farm_barn_db" );
    s_m_mod = utility::getstruct( "melee_macchiato_for_training_course", "target" );
    
    if ( isdefined( s_m_mod ) )
    {
        instance = spawnstruct();
        instance.script_currency = #"essence";
        s_m_mod namespace_34fc1661493f2405::function_9a3e81eb8357ad32( instance );
    }
    
    override_perk_model = utility::getstruct( "override_perk_model", "targetname" );
    utility::spawn_model( override_perk_model.script_noteworthy, override_perk_model.origin, override_perk_model.angles );
    sam_clips = getentarray( "task_col", #targetname );
    
    foreach ( clip in sam_clips )
    {
        clip connectpaths();
        clip delete();
    }
    
    level.var_96d4f8dc0c3cfea3 = 1;
    activateworldevent( "we_t10_zm_machine_m_mod_training" );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0xf37bba89, Offset: 0xa6e
// Size: 0xe8
function function_9f01e92bc745daa4( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_2dee1c96fa1e744d = player getweaponslistprimaries();
    
    foreach ( primary_weapon in var_2dee1c96fa1e744d )
    {
        if ( isnullweapon( primary_weapon ) )
        {
            continue;
        }
        
        player takeweapon( primary_weapon );
    }
    
    new_weapon = weapon::buildweapon( "sat_pi_timir_mp" );
    
    if ( isdefined( new_weapon ) )
    {
        player giveweapon( new_weapon );
        max_ammo = utility::get_max_stock_ammo( new_weapon, 0 );
        player setweaponammostock( new_weapon, max_ammo );
        player switchtoweapon( new_weapon );
    }
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x1f14c310, Offset: 0xb5e
// Size: 0x31
function function_86af15e18a6a5ca()
{
    open_flags = training_course::function_78c8f97212bb7409( "farm_garage_db" );
    
    if ( !training_course::function_288d30ef0b434b1( open_flags ) )
    {
        training_course::open_door( "farm_garage_db" );
    }
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x92c8ba, Offset: 0xb97
// Size: 0x1c
function function_c7850f5200526983( player )
{
    player thread training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcgglsnst", 1 );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x93e82aaa, Offset: 0xbbb
// Size: 0x1c
function function_24772f3926b2aa71( player )
{
    player training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcggstwth", 1 );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x3bc9cf95, Offset: 0xbdf
// Size: 0x1c
function function_1412df7f7334b60f( player )
{
    player thread training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcggusd", 1 );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x50508304, Offset: 0xc03
// Size: 0x1c
function function_9bc3e1de4d552b05( player )
{
    player thread training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcgganthr", 1 );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x59c4d78f, Offset: 0xc27
// Size: 0x1c
function function_4cb96402dbce8b25( player )
{
    player thread training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcggltdtm", 1 );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x6ee30928, Offset: 0xc4b
// Size: 0x1b
function function_a3caab6ab9ce1a0a( player )
{
    player training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcgglsncmp", 0 );
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x333c9b7d, Offset: 0xc6e
// Size: 0x42
function function_cfd549d3b517d5d7()
{
    level.players[ 0 ] zombie_augments::function_eae5368ab01aaa9f();
    level.players[ 0 ] perkpackage::perkpackage_giveimmediate( "super_dark_flare", undefined, undefined, undefined, 1 );
    level.players[ 0 ] perkpackage::perkpackage_reset();
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x3ace7f35, Offset: 0xcb8
// Size: 0x2d
function function_fb1010871dfb8930( player )
{
    return sortbydistance( utility::getstructarray( "sat_sm_orca_mp", "script_noteworthy" ), player.origin )[ 0 ];
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x95ef73c9, Offset: 0xcee
// Size: 0x1a
function function_6349ef9a6d9b8dc1()
{
    level.var_a28a6b70b096f4e5 = "zm_sat_item_weapon_ar_hawk";
    activateworldevent( "we_lgt_power_on_farm" );
}

// Namespace zm_sat_firefly_training_course
// Params 1
// Checksum 0x57573bd4, Offset: 0xd10
// Size: 0x22, Type: bool
function function_cb9879effffb73b5( instance )
{
    if ( self.target == "melee_macchiato_for_training_course" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xe7f3c678, Offset: 0xd3b
// Size: 0x31
function function_8529c738ae472da7()
{
    open_flags = training_course::function_78c8f97212bb7409( "farm_garage_db" );
    
    if ( !training_course::function_288d30ef0b434b1( open_flags ) )
    {
        training_course::open_door( "farm_garage_db" );
    }
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xd3ab22dd, Offset: 0xd74
// Size: 0x48
function function_8891f0045d953656()
{
    params = spawnstruct();
    params.doorbuy_targetname = "farm_house_db";
    script_flags = training_course::function_78c8f97212bb7409( "farm_house_db" );
    params.open_flags = script_flags;
    return params;
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x49616dd, Offset: 0xdc5
// Size: 0x7
function function_3f34684009adab33()
{
    return "sat_sm_orca_mp";
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x1316a7c, Offset: 0xdd5
// Size: 0x7
function function_2e194f7a24e2a167()
{
    return "sat_sm_orca_mp";
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0x225477ed, Offset: 0xde5
// Size: 0x27
function function_55048cea52309e6f()
{
    return [ "zm_sat_item_weapon_sn_drake", "zm_sat_item_weapon_sh_corso", "zm_sat_item_weapon_sm_zebra", "zm_sat_item_weapon_sn_baltic" ];
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xb42b91fe, Offset: 0xe15
// Size: 0x7
function function_c458239334898ff()
{
    return "zm_sat_item_weapon_pi_raygun";
}

// Namespace zm_sat_firefly_training_course
// Params 2
// Checksum 0x381cbae7, Offset: 0xe25
// Size: 0x2bc
function function_489160069d773bc1( player, tutorial )
{
    common_training_course::function_a6e8c085165e0898( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_1", 3 );
    player training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcexfrndcdntutln01", 1 );
    common_training_course::function_5e3e773127f754db( player );
    wait 1;
    common_training_course::function_a6e8c085165e0898( player, &"zm_training_course/zombie_station_7_step_2_sat", 3 );
    current_s_exfil = zm_exfil_sat::function_67ea1c632232000e( "available", player.origin );
    wait 3;
    player thread training_course::function_a647d2d93bf91cc5( "dx_zm_satc_zmtc_asgt_ztcexfrndcdntutln02", 1 );
    player val::set( "training_course", "interactions", 1 );
    
    if ( isdefined( current_s_exfil.interact ) )
    {
        current_s_exfil.interact interaction::function_e4a4753e6eac02d7();
    }
    
    level utility::flag_wait( "exfil_kill_hvt_start" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    if ( isdefined( current_s_exfil.var_c6883f07ae9a466 ) )
    {
        current_s_exfil utility::ent_flag_clear( "exfil_phone_booth_active" );
        objidpoolmanager::returnobjectiveid( current_s_exfil.var_c6883f07ae9a466 );
        current_s_exfil.var_c6883f07ae9a466 = undefined;
    }
    
    player.var_20a46fc07cec1dd5 = 1;
    player val::set( "training_course", "allow_scripted_bgb_use", 1 );
    common_training_course::function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread training_course::function_a06f3edcbf68bb0e( 5, "dx_zm_satc_zmtc_asgt_ztcclchpcg" );
    wait 1;
    player val::reset( "training_course", "ignoreme" );
    common_training_course::function_a6e8c085165e0898( player, &"zm_training_course/zombie_station_7_step_3_sat", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"zm_training_course/zombie_station_7_step_3_hint_sat" );
    level thread function_6c29373dec801f5b();
    level utility::flag_wait( "exfil_escape_step_start" );
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    player thread training_course::function_a06f3edcbf68bb0e( 1, "dx_zm_satc_zmtc_asgt_ztcexfcmpcg" );
    player val::set( "training_course", "ignoreme", 1 );
    wait 1;
    player val::reset( "training_course", "ignoreme" );
    common_training_course::function_a6e8c085165e0898( player, &"zm_training_course/zombie_station_7_step_4_sat", 3 );
    common_training_course::function_ac53a17fd5b74658( player, &"ZM_TRAINING_COURSE/ZOMBIE_STATION_7_STEP_4_HINT" );
    player utility::ent_flag_wait( "sat_exfil_completed" );
    player training_course::function_9268caa7bcfa85c2( [ "dx_zm_aitc_zmtc_asgt_adsexfcmpcg", "dx_zm_aitc_zmtc_asgt_adscrscmpcg" ] );
    level utility::flag_set( "exfil_completed_vo_finished" );
    
    if ( level.players.size > 1 )
    {
        bots::drop_bots( 1, player.team );
    }
    
    common_training_course::function_5e3e773127f754db( player );
    common_training_course::function_55099ffa73b4eff1( player );
    player playsound( "uin_t10_training_course_objective_success" );
    thread common_training_course::completetutorial( player, tutorial );
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xe18e0b9b, Offset: 0x10e9
// Size: 0x21
function function_c49560448cdc2375()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "exfil_completed_vo_finished" );
    wait 1;
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xc1938632, Offset: 0x1112
// Size: 0x71
function function_6c29373dec801f5b()
{
    level endon( #"game_ended" );
    level endon( #"exfil_escape_step_start" );
    var_ff3661001b5d5276 = level.s_zm_exfil.kill_hvt_time_limit - 15;
    wait var_ff3661001b5d5276;
    
    if ( isalive( level.s_zm_exfil.alive_hvt ) )
    {
        level.s_zm_exfil.alive_hvt kill();
    }
}

// Namespace zm_sat_firefly_training_course
// Params 0
// Checksum 0xbc16c4b4, Offset: 0x118b
// Size: 0x2
function function_5360bf714f709210()
{
    
}

