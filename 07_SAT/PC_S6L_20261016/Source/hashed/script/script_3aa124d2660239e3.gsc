// script_3aa124d2660239e3  (hash_3aa124d2660239e3.gscc) (size: 23261 Bytes / 0x5add / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa35c7e6 (2855651302)
// size ...... 23261 (0x5add)
// includes .. 21  (offset: 0x5765)
// strings ... 32  (offset: 0x580d)
// dev strs .. 11  (offset: 0x59f5)
// exports ... 41  (offset: 0x3c0d)
// cseg ...... 0x366 + 0x38a7 (0x3c0d)
// imports ... 167 (offset: 0x4275)
// animtree1 . 1   (offset: 0x5a79)
// animtree2 . 5   (offset: 0x5a89)
#using script_14d95c611b71b01;
#using script_16ea1b94f0f381b3;
#using script_4714f11e284c32a4;
#using script_53600bb9c82cbdf2;
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\field_upgrades\field_upgrades_dark_flare;
#using scripts\mp\common\powerups\insta_kill;
#using scripts\mp\common\utility\damage;
#using scripts\mp\damage;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;

#namespace zombie_boss_virgil_totem_attack;

#using_animtree( "script_model" );

// Namespace zombie_boss_virgil_totem_attack
// Params 0, eflags: 0x1
// Checksum 0x627cd665, Offset: 0x384
// Size: 0xb5
function autoexec init_anims()
{
    level.scr_animtree[ "virgil_totem" ] = #animtree;
    level.scr_anim[ "virgil_totem" ][ "idle_anim" ][ 0 ] = %ai_sat_locust_boss_totem_idle;
    level.scr_anim[ "virgil_totem" ][ "death_anim" ] = %ai_sat_locust_boss_totem_death;
    level.scr_anim[ "virgil_totem" ][ "survived_anim" ] = %ai_sat_locust_boss_totem_survived;
    level.scr_anim[ "virgil_totem" ][ "vulnerable_anim" ][ 0 ] = %ai_sat_locust_boss_totem_vulnerable;
    level.scr_anim[ "virgil_totem" ][ "attack_anim" ][ 0 ] = %ai_sat_locust_boss_totem_attack;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 0
// Checksum 0x90ad3b2f, Offset: 0x441
// Size: 0x57e
function init()
{
    level.var_75e5276e4a1f8b11 = { #totem_mouth_scale:getdvarfloat( @"hash_81d101da5824ecaf", 1.32 ), #var_7242ed3fe62a0bdf:getdvarfloat( @"hash_9f8080e8ee968e8", 0.25 ), #var_6262c9cb60865814:getdvarfloat( @"hash_d88b1338df9fe75b", 2 ), #var_1d18afcb9c418ef:getdvarint( @"hash_2581c11361b8d342", 725 ), #var_5c846b9af90757b5:getdvarint( @"hash_b5fe472857c284d6", 40 ), #var_5ca7559af92d6f0b:getdvarint( @"hash_b5db5928579c64b4", 20 ), #var_16bd8fedc9b59f9d:getdvarfloat( @"hash_111adc4cdfae63c6", 4 ), #var_757cb3098b2a5df:getdvarfloat( @"hash_c5b940b5660516da", 16 ), #var_2dd4de6be4389c86:getdvarfloat( @"hash_67776556260f81e4", 1 ), #var_7f012f2bf3e0d457:getdvarint( @"hash_5c91fc6f626b549f", 20 ), #var_9918d54d06ba0381:getdvarint( @"hash_299d840acfbf78e3", 10 ), #var_6fdab8f884d29e48:[], #var_ce8ef4db4edfa997:getdvarint( @"hash_a9da3c4ea869a49a", 650 ), #var_e8459dba1502ee07:getdvarint( @"hash_747a4300152d4c5a", 25 ), #var_6f18f3448e0dfc6a:getdvarfloat( @"hash_35a6bd486273c8ef", 0.25 ), #var_9097b1a7194c3fbc:getdvarint( @"hash_bb9fb672c65263b7", 7 ), #var_5b0e847774790aca:getdvarfloat( @"hash_fc5328f6a4161b2d", 0.2 ), #var_d11e6920d8b4caf8:getdvarint( @"hash_3a59d6f185ca0599", 50 ), #var_b16c02c22bfe88c0:getdvarint( @"hash_203f7917f26e3eef", 7200 ), #projectile_spread:getdvarfloat( @"hash_4940bef03130465e", 0.7 ), #var_1c763439b7d315c0:getdvarint( @"hash_853e74165ec0150b", 50 ), #attack_delay_sec:getdvarfloat( @"hash_d7ae596041445629", 1 ), #var_c0583c1dc7dafd4a:getdvarfloat( @"hash_e0cab20e9196a919", 8 ), #var_bd77f82a3b414985:getdvarfloat( @"hash_e055ddd28df2cf48", 0.2 ), #var_a8321ef5c8e9afbf:getdvarint( @"hash_89505b93daf78708", 800 ), #var_4510b2bdf4c27aeb:getdvarint( @"hash_a39358cfccc28450", 3 ), #var_cdaa4ec20c2f50b9:getdvarfloat( @"hash_c7a4473f2536045e", 2 ), #var_ec6788fe79287ded:getdvarfloat( @"hash_183f187d01b72eda", 1 ), #var_834dea8c9b87bd5a:getdvarfloat( @"hash_433af5c7520abc91", 5 ), #var_53c3797ee4ee8a96:getdvarfloat( @"hash_b957a84710378761", 30 ), #var_f9293ad7dc46d0d6:getdvarfloat( @"hash_7dc8ff150ca7725", 0.5 ), #totem_knockback_magnitude:getdvarint( @"scr_virgil_totem_knockback_magnitude", 600 ), #var_6babdcec0565b9a1:getdvarint( @"hash_bf938375ed184e2e", 20 ), #var_61348c2179989c2b:getdvarint( @"hash_f04523cc855b17fa", 50 ), #var_fe03d68e7bc930b6:getdvarfloat( @"hash_63bb859575e5480f", 0.65 ), #var_39b7cffbe2c75833:getdvarfloat( @"hash_a25eb63982df3fbe", 0.87 ), #var_4fc96a187500c041:getdvarfloat( @"hash_efb2f28ab53ca8fa", 0.8 ), #var_8d3fc913cc53a7ff:getdvarfloat( @"hash_29784fd74ab54e4c", 4 ), #var_b90963cfc1fc678f:getdvarfloat( @"hash_7c9318c43a450eac", 1.75 ), #var_515df4984d8d2ea7:getdvarfloat( @"hash_2d9686b5ce84e846", 0.44 ), #var_b84f1583db1995b4:getdvarfloat( @"hash_b80e0b5c56115e59", 2 ), #var_85af1c5c08d7d77b:getdvarfloat( @"hash_466da2be6c8a91f6", 0.7 ), #var_d88a837a90276739:getdvarfloat( @"hash_f4b9471159e95c30", 1.4 ), #var_9be65b5fa362b286:getdvarfloat( @"hash_5387e79c5be71d2b", 0 ), #var_ef775f69d1802043:getdvarint( @"hash_e39d42c297e65cc6", 100 ), #var_26c30ad8feba0f40:getdvarint( @"hash_a8bd886f6417cab5", 0 ), #var_ab6ea7048fa91057:getdvarint( @"hash_d1fffb30e45ebf8a", 200 ), #var_bba1031fe757f20f:getdvarint( @"hash_17b656ad7861265e", 3 ), #var_19385bc8b7341373:getdvarfloat( @"hash_3042235f33cd2236", 0.98 ), #var_1ef53774075c6625:getdvarfloat( @"hash_35ad3a40b1f347fe", 0.8 ), #var_6504ba95a766934e:getdvarfloat( @"hash_6cc37cd6b349872f", -25 ), #var_16aed486b51de962:getdvarfloat( @"hash_391ea7de00981303", 0.4 ), #death_loot_list:"zm_sat_virgil_totem_drop_list", #var_f86d826c2d71c567:1, #active_totems:[], #var_ff3d96238a23d82a:undefined, #var_4371ad3108375f65:[], #virgil_ent:self };
    utility::registersharedfunc( #"zombie_ai_virgil", #"hash_63d6664e178c2fb8", &get_ice_wall_goal_position );
    
    /#
        level thread attack_debug();
    #/
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1
// Checksum 0xa237f54b, Offset: 0x9c7
// Size: 0x359
function setup_arena_properties( totem_spawn_loc )
{
    var_7fc98722abe8b25c = utility::getstructarray( totem_spawn_loc.target, "targetname" );
    
    foreach ( var_399a0f97e8cb8e0b in var_7fc98722abe8b25c )
    {
        spawn_info_struct = { #can_ripple:0, #var_f70ad6bd851af416:int( var_399a0f97e8cb8e0b.var_f70ad6bd851af416 ), #recovery_origin:var_399a0f97e8cb8e0b.origin + ( 0, 0, level.var_75e5276e4a1f8b11.var_6504ba95a766934e ), #attack_origin:var_399a0f97e8cb8e0b.origin + ( 0, 0, level.var_75e5276e4a1f8b11.var_ef775f69d1802043 ), #id:int( var_399a0f97e8cb8e0b.script_noteworthy ), #angles:var_399a0f97e8cb8e0b.angles, #origin:var_399a0f97e8cb8e0b.origin };
        spawn_info_struct.ice_wall_clumps = namespace_dba99780c141b678::function_7d4b00914399a657( spawn_info_struct.id );
        var_5be7894b325b76fb = "totem_close_proximity_trigger_" + var_399a0f97e8cb8e0b.script_noteworthy;
        var_231c839c3fbb8a08 = "totem_far_proximity_trigger_" + var_399a0f97e8cb8e0b.script_noteworthy;
        [ spawn_info_struct.var_3ee7b21562594553 ] = getnoentvolumearray( var_5be7894b325b76fb, #targetname );
        [ spawn_info_struct.var_c218cae00ebbcbe2 ] = getnoentvolumearray( var_231c839c3fbb8a08, #targetname );
        
        if ( spawn_info_struct.id == 2 )
        {
            level.var_75e5276e4a1f8b11.var_ff3d96238a23d82a = spawn_info_struct;
        }
        
        spawn_info_struct.var_9a43692b92416fcc = structcopy( namespace_dba99780c141b678::function_c3c3e337d84f7dd6() );
        spawn_info_struct.var_9a43692b92416fcc.source_origin = var_399a0f97e8cb8e0b.origin;
        spawn_info_struct.var_9a43692b92416fcc.var_70bbf852ea79c4ba = 4;
        spawn_info_struct.var_5bcb0dbf42a77a2f = structcopy( namespace_dba99780c141b678::function_c3c3e337d84f7dd6() );
        spawn_info_struct.var_5bcb0dbf42a77a2f.source_origin = var_399a0f97e8cb8e0b.origin;
        spawn_info_struct.var_223560e58b2f604b = structcopy( namespace_dba99780c141b678::function_60dcd9cbe1cf2d4a() );
        spawn_info_struct.var_223560e58b2f604b.source_origin = var_399a0f97e8cb8e0b.origin;
        spawn_info_struct.var_223560e58b2f604b.var_70bbf852ea79c4ba = 3;
        spawn_info_struct.var_bae00710b0d53b55 = structcopy( namespace_dba99780c141b678::function_60dcd9cbe1cf2d4a() );
        spawn_info_struct.var_bae00710b0d53b55.source_origin = var_399a0f97e8cb8e0b.origin;
        level.var_75e5276e4a1f8b11.var_4371ad3108375f65[ level.var_75e5276e4a1f8b11.var_4371ad3108375f65.size ] = spawn_info_struct;
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1
// Checksum 0xa5b4940, Offset: 0xd28
// Size: 0x22
function function_304a04c4fbfbf30a( var_d88a837a90276739 )
{
    level.var_75e5276e4a1f8b11.var_d88a837a90276739 = var_d88a837a90276739;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 0
// Checksum 0xe043c8f8, Offset: 0xd52
// Size: 0x17
function function_34e357f3732346da()
{
    level.var_75e5276e4a1f8b11.var_f86d826c2d71c567 = 0;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 0
// Checksum 0xc6a21a60, Offset: 0xd71
// Size: 0x18
function function_247941e51939c08d()
{
    level.var_75e5276e4a1f8b11.var_f86d826c2d71c567 = 1;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1
// Checksum 0x29acdf09, Offset: 0xd91
// Size: 0x22
function set_death_loot_list( var_5be21b6c6772bacc )
{
    level.var_75e5276e4a1f8b11.death_loot_list = var_5be21b6c6772bacc;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1
// Checksum 0x411e24fc, Offset: 0xdbb
// Size: 0x306
function initiate_totem_attack( var_acbfdd783fdb6007 = 0 )
{
    spawn_info_struct = function_874e3394297dfec9( var_acbfdd783fdb6007 );
    
    if ( !spawn_info_struct )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    totem_ent = function_dc420a02edf575a5( spawn_info_struct );
    
    if ( !level callback::exists( "on_zombie_ai_killed", &function_2d7437304efd638 ) )
    {
        level callback::add( "on_zombie_ai_killed", &function_2d7437304efd638 );
    }
    
    level.var_75e5276e4a1f8b11.active_totems[ level.var_75e5276e4a1f8b11.active_totems.size ] = totem_ent;
    var_af412aa9eabc1d3a = utility::spawn_model( "tag_origin", totem_ent.origin, totem_ent.angles );
    totem_ent linkto( var_af412aa9eabc1d3a, "tag_origin" );
    totem_ent.var_af412aa9eabc1d3a = var_af412aa9eabc1d3a;
    level thread rotate_totem( totem_ent );
    earthquake( 0.2, 5, totem_ent.spawn_info_struct.origin, 1000 );
    level thread namespace_dba99780c141b678::function_e4a55a8bbcdb46d2( totem_ent.var_6f190c31d961897e );
    
    foreach ( ice_wall_clump in totem_ent.ice_wall_clumps )
    {
        level thread namespace_dba99780c141b678::function_efe887b9ff2ba515( ice_wall_clump, totem_ent.spawn_info_struct.var_9a43692b92416fcc );
    }
    
    wait 4;
    totem_ent setcandamage( 1 );
    totem_ent.mouth_ent setcandamage( 1 );
    totem_ent thread damage::monitordamage( totem_ent.health, "hithealth", &totem_watch_death, &function_20cb798d997c185a, undefined, undefined );
    totem_ent.mouth_ent thread damage::monitordamage( totem_ent.health, "hithealth", &totem_mouth_watch_death, &function_b5101da94ae4797e, undefined, undefined, 1 );
    field_upgrades_dark_flare::add_manual_target( totem_ent );
    field_upgrades_dark_flare::add_manual_target( totem_ent.mouth_ent );
    totem_ent setscriptablepartstate( #"body", #"arrival" );
    wait 0.25;
    totem_ent setscriptablepartstate( #"model", #"show" );
    
    if ( true )
    {
        totem_ent.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_529caa534628ad12" );
        totem_ent.var_24954f14e27b448d = 1;
        totem_ent.using_fake_health = 1;
        totem_ent val::set( "show_healthbar", 1 );
        zombie_health_bar::function_fe8a1246b153d8d9( totem_ent );
    }
    
    earthquake( 0.8, 1, totem_ent.spawn_info_struct.origin, 1500 );
    level thread function_999a1d585e26eb1a( totem_ent );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x8dc9cf1b, Offset: 0x10c9
// Size: 0x140
function private rotate_totem( totem_ent )
{
    totem_ent endon( #"totem_destroyed", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    current_angle = 0;
    previous_time_ms = gettime();
    current_time_ms = gettime();
    
    while ( true )
    {
        current_time_ms = gettime();
        elapsed_time_sec = ( current_time_ms - previous_time_ms ) * 0.001;
        previous_time_ms = gettime();
        current_angle = math::wrap( 0, 360, current_angle + elapsed_time_sec * totem_ent.current_rotation_speed );
        x = cos( current_angle ) + totem_ent.origin[ 0 ];
        y = sin( current_angle ) + totem_ent.origin[ 1 ];
        vector = ( x, y, 0 ) - ( totem_ent.origin[ 0 ], totem_ent.origin[ 1 ], 0 );
        new_angles = vectortoangles( vector );
        totem_ent.var_af412aa9eabc1d3a.angles = new_angles;
        waitframe();
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 3, eflags: 0x4
// Checksum 0x22c9038b, Offset: 0x1211
// Size: 0x110
function private set_rotation_speed( totem_ent, new_speed, immediate = 0 )
{
    totem_ent endon( #"totem_destroyed", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    
    if ( immediate )
    {
        totem_ent.current_rotation_speed = new_speed;
        return;
    }
    
    current_fraction = 0;
    var_a5cf3d3c65f1eb42 = totem_ent.current_rotation_speed;
    previous_time_ms = gettime();
    current_time_ms = gettime();
    
    while ( current_fraction < 1 )
    {
        current_time_ms = gettime();
        elapsed_time_sec = ( current_time_ms - previous_time_ms ) * 0.001;
        previous_time_ms = gettime();
        current_fraction = clamp( current_fraction + level.var_75e5276e4a1f8b11.var_bba1031fe757f20f * elapsed_time_sec, 0, 1 );
        totem_ent.current_rotation_speed = math::lerp( var_a5cf3d3c65f1eb42, new_speed, current_fraction );
        waitframe();
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 3, eflags: 0x4
// Checksum 0xf2999675, Offset: 0x1329
// Size: 0x4c
function private set_bobbing( totem_ent, amplitude, period_time_sec )
{
    down_vector = anglestoup( totem_ent.angles ) * -1;
    totem_ent function_616378d7e5b22efb( down_vector, amplitude, period_time_sec, 0 );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 2, eflags: 0x4
// Checksum 0x7c2abcbb, Offset: 0x137d
// Size: 0x1c1
function private function_999a1d585e26eb1a( totem_ent, from_recovery = 1 )
{
    totem_ent endon( #"totem_destroyed", #"totem_vulnerable", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    make_resistant( totem_ent );
    totem_ent.var_79827ec4f1b6d75b = 1;
    totem_ent setscriptablepartstate( #"body", #"rising" );
    move_delay_sec = level.var_75e5276e4a1f8b11.var_ec6788fe79287ded;
    
    if ( from_recovery )
    {
        anim_length_sec = getanimlength( %ai_sat_locust_boss_totem_survived );
        totem_ent thread animation::anim_single_solo( totem_ent, "survived_anim" );
        move_delay_sec = anim_length_sec;
    }
    
    totem_ent setscriptablepartstate( #"mouth", #"active" );
    totem_ent.var_af412aa9eabc1d3a moveto( totem_ent.spawn_info_struct.attack_origin, level.var_75e5276e4a1f8b11.var_ec6788fe79287ded );
    wait move_delay_sec;
    totem_ent setscriptablepartstate( #"body", #"shielded" );
    
    if ( totem_ent.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( totem_ent.var_12aadf5d8bbfdafd );
    }
    
    totem_ent.var_a3d101d849023b5e = 1;
    level thread set_rotation_speed( totem_ent, level.var_75e5276e4a1f8b11.var_ab6ea7048fa91057 );
    totem_ent thread animation::anim_loop_solo( totem_ent, "idle_anim", "totem_end_looping_anim" );
    wait level.var_75e5276e4a1f8b11.var_cdaa4ec20c2f50b9;
    level thread function_b3754c3e2aa8f7ff( totem_ent );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xe3c82a02, Offset: 0x1546
// Size: 0x18a
function private function_b3754c3e2aa8f7ff( totem_ent )
{
    totem_ent endon( #"totem_destroyed", #"totem_vulnerable", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    totem_ent.var_79827ec4f1b6d75b = 0;
    current_time = gettime();
    var_c41461b44d896a9 = current_time;
    
    while ( true )
    {
        if ( current_time >= var_c41461b44d896a9 )
        {
            targets_struct = totem_ent find_targets();
            
            if ( isdefined( targets_struct ) && ( targets_struct.close_targets.size > 0 || targets_struct.far_targets.size > 0 ) )
            {
                totem_ent.current_rotation_speed = 0;
                totem_ent notify( #"totem_end_looping_anim" );
                totem_ent thread animation::anim_loop_solo( totem_ent, "attack_anim", "totem_end_looping_anim" );
                totem_ent setscriptablepartstate( #"body", #"attacking" );
                function_c33af715ad711d93( totem_ent, targets_struct );
                totem_ent setscriptablepartstate( #"body", #"shielded" );
                totem_ent notify( #"totem_end_looping_anim" );
                totem_ent thread animation::anim_loop_solo( totem_ent, "idle_anim", "totem_end_looping_anim" );
                var_c41461b44d896a9 = gettime() + level.var_75e5276e4a1f8b11.attack_delay_sec * 1000;
                level thread set_rotation_speed( totem_ent, level.var_75e5276e4a1f8b11.var_ab6ea7048fa91057 );
            }
        }
        
        waitframe();
        current_time = gettime();
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xe6d6a4cb, Offset: 0x16d8
// Size: 0x35a
function private function_d87005c9dc77df4a( totem_ent )
{
    totem_ent endon( #"totem_destroyed", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    totem_ent.var_79827ec4f1b6d75b = 3;
    totem_ent setscriptablepartstate( #"body", #"damaged" );
    totem_ent setscriptablepartstate( #"mouth", #"damaged" );
    totem_ent.var_a3d101d849023b5e = 0;
    level thread namespace_dba99780c141b678::function_1cb2768d13bba36c( totem_ent.var_6f190c31d961897e );
    level thread namespace_dba99780c141b678::function_83106865d7d82433( totem_ent.var_6f190c31d961897e );
    
    if ( !totem_ent.var_12aadf5d8bbfdafd )
    {
        var_1ee22348ced85e75 = utility::drop_to_ground( totem_ent.spawn_info_struct.recovery_origin );
        var_8416c4f108867070 = getclosestpointonnavmesh( var_1ee22348ced85e75 );
        
        if ( isdefined( var_8416c4f108867070 ) )
        {
            totem_ent.var_12aadf5d8bbfdafd = createnavobstaclebybounds( var_8416c4f108867070, ( level.var_75e5276e4a1f8b11.var_61348c2179989c2b, level.var_75e5276e4a1f8b11.var_61348c2179989c2b, level.var_75e5276e4a1f8b11.var_61348c2179989c2b ), ( 0, 0, 0 ) );
        }
    }
    
    level thread set_rotation_speed( totem_ent, level.var_75e5276e4a1f8b11.var_26c30ad8feba0f40 );
    utility::delaythread( 0.5, &remove_resistance, totem_ent );
    totem_ent animation::anim_single_solo( totem_ent, "death_anim" );
    totem_ent setscriptablepartstate( #"body", #"falling" );
    var_4ec03c59fe015016 = getplayersinradius( totem_ent.spawn_info_struct.recovery_origin, 125 );
    
    foreach ( player in var_4ec03c59fe015016 )
    {
        knockback_dir = vectornormalize2( player.origin - totem_ent.spawn_info_struct.recovery_origin );
        player knockback( knockback_dir, 300, 1 );
    }
    
    totem_ent.var_af412aa9eabc1d3a moveto( totem_ent.spawn_info_struct.recovery_origin, level.var_75e5276e4a1f8b11.var_bd77f82a3b414985, level.var_75e5276e4a1f8b11.var_bd77f82a3b414985, 0 );
    wait level.var_75e5276e4a1f8b11.var_bd77f82a3b414985;
    earthquakeadvanced( 0.6, 0.4, 0.2, 1, totem_ent.spawn_info_struct.recovery_origin, 150, 250, 800 );
    totem_ent setscriptablepartstate( #"body", #"vulnerable" );
    totem_ent setscriptablepartstate( #"mouth", #"inactive" );
    totem_ent thread animation::anim_loop_solo( totem_ent, "vulnerable_anim", "totem_end_looping_anim" );
    level thread recover_mode( totem_ent );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xf3ee1179, Offset: 0x1a3a
// Size: 0x1ee
function private recover_mode( totem_ent )
{
    totem_ent endon( #"totem_destroyed", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    totem_ent.var_79827ec4f1b6d75b = 2;
    end_time_ms = gettime() + level.var_75e5276e4a1f8b11.var_c0583c1dc7dafd4a * 1000;
    var_bf1316595b384341 = totem_ent.var_cce7c67ea2da8902;
    var_ab8007f32d8a3abe = totem_ent.var_cce7c67ea2da8902;
    max_health = totem_ent.var_d165d33ad4f00e17;
    
    for ( health_lost = 0; gettime() < end_time_ms && health_lost < 35 ; health_lost = ( var_bf1316595b384341 - var_ab8007f32d8a3abe ) / max_health * 100 )
    {
        waitframe();
        var_ab8007f32d8a3abe = totem_ent.var_cce7c67ea2da8902;
    }
    
    earthquake( 0.2, 5, totem_ent.spawn_info_struct.origin, 1000 );
    level thread namespace_dba99780c141b678::function_e4a55a8bbcdb46d2( totem_ent.var_6f190c31d961897e );
    
    foreach ( ice_wall_clump in totem_ent.ice_wall_clumps )
    {
        level namespace_dba99780c141b678::function_efe887b9ff2ba515( ice_wall_clump, totem_ent.spawn_info_struct.var_5bcb0dbf42a77a2f );
    }
    
    wait level.var_75e5276e4a1f8b11.var_6262c9cb60865814;
    totem_ent notify( #"totem_recovered" );
    totem_ent notify( #"totem_end_looping_anim" );
    level thread function_999a1d585e26eb1a( totem_ent );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 2, eflags: 0x4
// Checksum 0xe5d3fc65, Offset: 0x1c30
// Size: 0x26e
function private function_c33af715ad711d93( totem_ent, targets_struct )
{
    totem_ent endon( #"totem_destroyed", #"totem_vulnerable", #"death" );
    level.var_75e5276e4a1f8b11.virgil_ent endon( #"death" );
    totem_ent.var_31854a9e29e8d2d = 1;
    
    if ( targets_struct.close_targets.size > 0 && totem_ent.spawn_info_struct.can_ripple )
    {
        forward = anglestoforward( totem_ent.angles );
        ideal_dot = undefined;
        var_12836d875b26b7d0 = undefined;
        
        foreach ( ice_wall_clump in totem_ent.ice_wall_clumps )
        {
            dir = vectornormalize2( ice_wall_clump.median_position - totem_ent.origin );
            dot = vectordot( forward, dir );
            
            if ( !isdefined( ideal_dot ) || dot > ideal_dot )
            {
                ideal_dot = dot;
                var_12836d875b26b7d0 = ice_wall_clump;
            }
        }
        
        level namespace_dba99780c141b678::function_26253d69242f4e39( var_12836d875b26b7d0, totem_ent.spawn_info_struct.var_223560e58b2f604b );
    }
    else
    {
        foreach ( target in targets_struct.far_targets )
        {
            if ( isalive( target ) )
            {
                level thread namespace_dba99780c141b678::function_69abb74070b91d7d( totem_ent.origin, target.origin, 180, undefined, totem_ent.spawn_info_struct.var_bae00710b0d53b55, totem_ent.spawn_info_struct.var_f70ad6bd851af416 );
            }
        }
    }
    
    wait 1;
    totem_ent.var_31854a9e29e8d2d = 0;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x6982bc46, Offset: 0x1ea6
// Size: 0x2d
function private function_3f4621c62e11e4cf( projectile )
{
    level endon( #"game_ended" );
    wait 0.5;
    
    if ( isdefined( projectile ) )
    {
        projectile setmagicgrenadecollision( 1 );
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xdc17ebd8, Offset: 0x1edb
// Size: 0xc
function private totem_mouth_watch_death( damage_data )
{
    
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x24da1e78, Offset: 0x1ef0
// Size: 0x24f
function private function_f2d271c052291830( damage_data )
{
    if ( isdefined( function_f02c63b99c9614c9( [ %"sat_pi_alcor_mp", %"sat_sl_crossbow_mp" ], damage_data.objweapon.basenamehash ) ) )
    {
        return 0;
    }
    
    if ( damage::isprojectiledamage( damage_data.meansofdeath ) && damage_data.objweapon.basenamehash == %"sat_ww_locust_fireball" )
    {
        return level.var_75e5276e4a1f8b11.var_9918d54d06ba0381;
    }
    
    if ( damage_data.objweapon.basenamehash == %"sat_monkey_bomb_zm" )
    {
        return level.var_75e5276e4a1f8b11.var_7f012f2bf3e0d457;
    }
    
    if ( damage_data.objweapon.classname == "rocketlauncher" )
    {
        return level.var_75e5276e4a1f8b11.var_7f012f2bf3e0d457;
    }
    
    if ( damage_data.objweapon.basenamehash == %"sat_ks_warmachine" )
    {
        return level.var_75e5276e4a1f8b11.var_7f012f2bf3e0d457;
    }
    
    if ( damage_data.meansofdeath == "MOD_IMPACT" && ( damage_data.objweapon.basenamehash == %"sat_molotov_zm" || damage_data.objweapon.basenamehash == %"sat_thermobaric_grenade_zm" ) )
    {
        return level.var_75e5276e4a1f8b11.var_9918d54d06ba0381;
    }
    
    if ( damage_data.objweapon.classname == "grenade" && damage_data.objweapon.damagemodcategory == #"lethal" )
    {
        return level.var_75e5276e4a1f8b11.var_9918d54d06ba0381;
    }
    
    if ( damage_data.objweapon.classname == "grenade" && ( damage_data.meansofdeath == "MOD_RIFLE_BULLET" || damage_data.meansofdeath == "MOD_GRENADE" ) )
    {
        return level.var_75e5276e4a1f8b11.var_9918d54d06ba0381;
    }
    
    return 0;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xf7fa0cbf, Offset: 0x2148
// Size: 0x122, Type: bool
function private function_b5101da94ae4797e( damage_data )
{
    totem_damage = function_f2d271c052291830( damage_data );
    totem_ent = self getlinkedparent();
    
    if ( totem_damage > 0 )
    {
        if ( isent( totem_ent ) )
        {
            if ( totem_ent.is_resistant && totem_ent.var_a3d101d849023b5e )
            {
                level thread function_3e76c43fcaa708b5( totem_ent );
                
                if ( isplayer( damage_data.attacker ) )
                {
                    level utility::delaythread( 1.5, &zombie_boss_virgil::function_9c386609d0280bef, #"totem_mouth_first", damage_data.attacker );
                }
                
                if ( isent( damage_data.inflictor ) && damage_data.objweapon.classname == "grenade" )
                {
                    damage_data.inflictor delete();
                }
                
                damage = totem_ent.var_d165d33ad4f00e17 * 0;
                totem_ent dodamage( damage, damage_data.point, damage_data.attacker, self, "MOD_EXPLOSIVE", undefined, "torso_upper", undefined );
            }
        }
    }
    
    return false;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x3fa7a8b6, Offset: 0x2273
// Size: 0x15
function private totem_watch_death( damage_data )
{
    level thread totem_cleanup( self );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xeb010b5f, Offset: 0x2290
// Size: 0x6f0
function private function_20cb798d997c185a( damage_data )
{
    var_4346ca48d4b756d8 = damage_data.damage;
    is_critical = !self.is_resistant;
    
    if ( self.is_resistant && damage_data.inflictor != self.mouth_ent )
    {
        var_4346ca48d4b756d8 = 0;
    }
    else
    {
        dmg_struct = zombie_damage::build_damage_struct( damage_data.inflictor, damage_data.attacker, var_4346ca48d4b756d8, damage_data.idflags, damage_data.meansofdeath, damage_data.objweapon, damage_data.point, damage_data.direction_vec, undefined, undefined, undefined, damage_data.partname, damage_data.objweapon );
        dmg_struct.biscritical = is_critical;
        dmg_struct.idamage = zombie_damage::function_cef159ba09a96f98( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_40c3998760e0b954( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_e01c2c6191f04821( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_5fc0f527cde63905( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_b9821f08dcbdc9d0( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_881dfa87252ee0ea( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_579261f41dfd0572( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_e20f670a9518dbc0( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_e06f2d26a28d8093( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_fe961b174c288da0( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_6da586fdebc81509( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_87aebf397086e82f( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_920710da910e04e8( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_eb7d5e5b35444c8b( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_a5d75273b1b77ffb( dmg_struct );
        dmg_struct.idamage = zombie_damage::function_23f0f83c55de1ad( dmg_struct );
        dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_d88a837a90276739;
        
        if ( isplayer( damage_data.attacker ) && damage_data.attacker insta_kill::is_insta_kill_damage() )
        {
            dmg_struct.idamage *= powerups::get_powerup_info( "insta_kill" ).var_a32268be2724adb6;
        }
        
        if ( weapon::iswonderweapon( damage_data.objweapon ) )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_85af1c5c08d7d77b;
        }
        
        if ( damage_data.objweapon.basenamehash == %"dark_flare_zm" )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_b84f1583db1995b4;
        }
        else if ( isdefined( function_f02c63b99c9614c9( [ %"sat_pi_timir_mp", %"sat_dm_kara_mp", %"sat_sl_crossbow_explosive_bolt_pap", %"sat_sh_shepherd_mp" ], damage_data.objweapon.basenamehash ) ) )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_515df4984d8d2ea7;
        }
        else if ( damage_data.objweapon.basenamehash == %"sat_ww_locust_fireball" )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_8d3fc913cc53a7ff;
        }
        else if ( damage_data.objweapon.basenamehash == %"sat_ww_raygunmark2_mp" )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_4fc96a187500c041;
        }
        else if ( damage_data.objweapon.basenamehash == %"sat_ar_heron_mp" )
        {
            dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_39b7cffbe2c75833;
        }
        
        var_55410e3e708e7b86 = damage_data.objweapon function_c865f1d40dba73a3();
        weaponname = weapon::getweaponrootname( damage_data.objweapon );
        weapongroup = weapon::weapongroupmap( weaponname );
        
        switch ( var_55410e3e708e7b86 )
        {
            case 1:
                if ( weapongroup == "weapon_shotgun" )
                {
                    dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_b90963cfc1fc678f;
                }
                
                break;
            case 5:
                dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_b90963cfc1fc678f;
                break;
        }
        
        if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( dmg_struct.objweapon ) && isplayer( dmg_struct.eattacker ) )
        {
            paplevel = dmg_struct.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( dmg_struct.objweapon );
            
            if ( paplevel >= 4 )
            {
                dmg_struct.idamage *= level.var_75e5276e4a1f8b11.var_fe03d68e7bc930b6;
            }
        }
        
        var_4346ca48d4b756d8 = dmg_struct.idamage;
    }
    
    mouth_damage = function_f2d271c052291830( damage_data );
    
    if ( self.is_resistant && mouth_damage > 0 )
    {
        var_75e4272f9fbf46c6 = 1;
    }
    
    if ( !var_75e4272f9fbf46c6 && gettime() - self.var_4c43473c600fd24 > level.var_75e5276e4a1f8b11.var_2dd4de6be4389c86 * 1000 && damage_data.inflictor != self.mouth_ent )
    {
        mp_agent_damage::function_eb8ba16055d6da7c( damage_data.attacker, self, "none", damage_data.meansofdeath, damage_data.objweapon, var_4346ca48d4b756d8, damage_data.point, self.is_resistant, undefined, is_critical, 0 );
    }
    
    self.var_cce7c67ea2da8902 -= var_4346ca48d4b756d8;
    return var_4346ca48d4b756d8;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 3, eflags: 0x4
// Checksum 0x1b36cc1f, Offset: 0x2989
// Size: 0x20, Type: bool
function private totem_insta_kill( eattacker, smeansofdeath, shitloc )
{
    return true;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1
// Checksum 0xb79cc87, Offset: 0x29b2
// Size: 0x90
function kill_all_totems( params )
{
    foreach ( totem_ent in level.var_75e5276e4a1f8b11.active_totems )
    {
        level thread totem_cleanup( totem_ent );
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x3360addb, Offset: 0x2a4a
// Size: 0x21b
function private totem_cleanup( totem_ent )
{
    level endon( #"game_ended" );
    totem_ent endon( #"death" );
    totem_ent notify( #"totem_destroyed" );
    level.var_75e5276e4a1f8b11.var_4371ad3108375f65[ level.var_75e5276e4a1f8b11.var_4371ad3108375f65.size ] = totem_ent.spawn_info_struct;
    level thread namespace_dba99780c141b678::function_1cb2768d13bba36c( totem_ent.var_6f190c31d961897e );
    level thread namespace_dba99780c141b678::function_e4a55a8bbcdb46d2( totem_ent.var_6f190c31d961897e );
    field_upgrades_dark_flare::remove_manual_target( totem_ent );
    
    if ( totem_ent.mouth_ent )
    {
        field_upgrades_dark_flare::remove_manual_target( totem_ent.mouth_ent );
        totem_ent.mouth_ent delete();
    }
    
    if ( totem_ent.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( totem_ent.var_12aadf5d8bbfdafd );
    }
    
    if ( true )
    {
        zombie_health_bar::function_4e46258837da5995( totem_ent );
    }
    
    totem_ent thread animation::anim_single_solo( totem_ent, "death_anim" );
    wait level.var_75e5276e4a1f8b11.var_7242ed3fe62a0bdf;
    totem_ent setscriptablepartstate( #"body", #"death" );
    totem_death_scriptable = spawnscriptable( %"sat_zombie_virgil_totem_death", totem_ent.origin );
    utility::delaythread( 2, &function_8fe09b3b7376ad2f, totem_death_scriptable );
    player_count = level.players.size;
    squad_size_frac = math::lerp_fraction( 1, 4, player_count );
    var_15190186ad7ea77 = roundint( math::lerp( 5, 9, squad_size_frac ) );
    
    if ( level.var_75e5276e4a1f8b11.var_f86d826c2d71c567 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( totem_ent.origin );
        spawnoptions.var_8d4f327170228364 = 0;
        spawnoptions.dropradiusscale = 1.15;
        level thread common_item::function_38cde6a6acb68ea6( level.var_75e5276e4a1f8b11.death_loot_list, var_15190186ad7ea77, spawnoptions );
    }
    
    function_38f37d7bd00b3e41( totem_ent );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xfc95fd34, Offset: 0x2c6d
// Size: 0x13
function private function_8fe09b3b7376ad2f( totem_death_scriptable )
{
    totem_death_scriptable freescriptable();
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x8fe2d57b, Offset: 0x2c88
// Size: 0xc1
function private function_38f37d7bd00b3e41( totem_ent )
{
    level thread callback::callback( #"hash_d734f5978951ec2a", { #remaining_totems:level.var_75e5276e4a1f8b11.active_totems.size - 1, #totem_ent:totem_ent } );
    
    if ( isdefined( totem_ent ) )
    {
        totem_ent delete();
    }
    
    level.var_75e5276e4a1f8b11.active_totems = function_5713d46873b29625( level.var_75e5276e4a1f8b11.active_totems );
    
    if ( level.var_75e5276e4a1f8b11.active_totems.size == 0 && level callback::exists( "on_zombie_ai_killed", &function_2d7437304efd638 ) )
    {
        level callback::remove( "on_zombie_ai_killed", &function_2d7437304efd638 );
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x759a1de5, Offset: 0x2d51
// Size: 0x3d1
function private function_dc420a02edf575a5( spawn_info_struct )
{
    totem_ent = spawn( "script_model", spawn_info_struct.attack_origin );
    totem_ent setmodel( "sat_zm_virgil_totem_head_01_anim" );
    totem_ent.spawn_info_struct = spawn_info_struct;
    totem_ent.angles = spawn_info_struct.angles;
    totem_ent.id = spawn_info_struct.id;
    totem_ent.var_3ee7b21562594553 = spawn_info_struct.var_3ee7b21562594553;
    totem_ent.var_c218cae00ebbcbe2 = spawn_info_struct.var_c218cae00ebbcbe2;
    totem_ent.ice_wall_clumps = spawn_info_struct.ice_wall_clumps;
    totem_ent.targeted_player = undefined;
    totem_ent.var_4c43473c600fd24 = gettime();
    totem_ent.current_rotation_speed = 0;
    totem_ent forcenetfieldhighlod( 1 );
    totem_ent.var_79827ec4f1b6d75b = undefined;
    totem_ent setcandamage( 0 );
    totem_ent solid();
    totem_ent.var_31854a9e29e8d2d = 0;
    totem_ent.aicategory = "hvt";
    totem_ent.var_6f190c31d961897e = { #radius:level.var_75e5276e4a1f8b11.var_a8321ef5c8e9afbf, #origin:totem_ent.spawn_info_struct.recovery_origin };
    totem_ent.var_a3d101d849023b5e = 0;
    totem_ent useanimtree( #animtree );
    totem_ent.animname = "virgil_totem";
    totem_ent.armor_health_damage_multiplier = 6;
    totem_ent.var_be089c77e1eaac30 = &totem_insta_kill;
    totem_ent.spawn_info_struct.var_9a43692b92416fcc.owner_ent = totem_ent;
    totem_ent.spawn_info_struct.var_5bcb0dbf42a77a2f.owner_ent = totem_ent;
    totem_ent.spawn_info_struct.var_223560e58b2f604b.owner_ent = totem_ent;
    totem_ent.spawn_info_struct.var_bae00710b0d53b55.owner_ent = totem_ent;
    mouth_position = totem_ent gettagorigin( "tag_mouth" );
    totem_ent.mouth_ent = utility::spawn_model( "tag_origin", mouth_position, undefined, undefined, level.var_75e5276e4a1f8b11.totem_mouth_scale );
    totem_ent.mouth_ent setcandamage( 0 );
    totem_ent.mouth_ent solid();
    totem_ent.mouth_ent setmoverantilagged( 1 );
    totem_ent.mouth_ent setmodel( "sat_zombie_virgil_totem_mouth" );
    totem_ent.mouth_ent linkto( totem_ent, "tag_mouth" );
    totem_ent.mouth_ent linkto( totem_ent, "tag_mouth", ( 0, -32, -15 ), ( 0, 0, 0 ) );
    totem_ent.mouth_ent.totem_mouth = 1;
    round_number = level.var_75e5276e4a1f8b11.virgil_ent zombie_utils::get_zombie_round_difficulty();
    scaled_health = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( "health_zombie_boss_virgil_totem", round_number );
    totem_ent.health = int( scaled_health );
    totem_ent.maxhealth = totem_ent.health;
    totem_ent.var_cce7c67ea2da8902 = totem_ent.health;
    totem_ent.var_d165d33ad4f00e17 = totem_ent.maxhealth;
    callback::callback( #"hash_293bd578dad314b7", { #totem_ent:totem_ent } );
    return totem_ent;
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x25405b36, Offset: 0x312b
// Size: 0xf3
function private function_874e3394297dfec9( var_acbfdd783fdb6007 = 0 )
{
    if ( level.var_75e5276e4a1f8b11.var_4371ad3108375f65.size > 0 )
    {
        if ( !var_acbfdd783fdb6007 && isdefined( level.var_75e5276e4a1f8b11.var_ff3d96238a23d82a ) && isdefined( function_f02c63b99c9614c9( level.var_75e5276e4a1f8b11.var_4371ad3108375f65, level.var_75e5276e4a1f8b11.var_ff3d96238a23d82a ) ) )
        {
            spawn_info_struct = level.var_75e5276e4a1f8b11.var_ff3d96238a23d82a;
        }
        else
        {
            spawn_info_struct = utility::array_random( level.var_75e5276e4a1f8b11.var_4371ad3108375f65 );
        }
        
        level.var_75e5276e4a1f8b11.var_4371ad3108375f65 = arrayremove( level.var_75e5276e4a1f8b11.var_4371ad3108375f65, spawn_info_struct );
        return spawn_info_struct;
    }
    
    assertmsg( "<dev string:x63>" );
}

// Namespace zombie_boss_virgil_totem_attack
// Params 0, eflags: 0x4
// Checksum 0xfb3d35f7, Offset: 0x3227
// Size: 0x19e
function private find_targets()
{
    close_targets = [];
    far_targets = [];
    alive_players = utility::get_alive_players( 0 );
    
    if ( alive_players.size > 0 )
    {
        foreach ( player in alive_players )
        {
            if ( player bgb::is_enabled( "idle_eyes" ) )
            {
                continue;
            }
            
            if ( player zombie_boss_virgil::function_3ab1eacb268ed911() )
            {
                continue;
            }
            
            totem_forward = anglestoforward( self.angles );
            var_4210be4b325a03a9 = vectornormalize2( player.origin - self.origin );
            dot_product = vectordot( totem_forward, var_4210be4b325a03a9 );
            
            if ( ispointinvolume( player.origin, self.var_3ee7b21562594553 ) && dot_product >= level.var_75e5276e4a1f8b11.var_19385bc8b7341373 )
            {
                close_targets[ close_targets.size ] = player;
            }
            
            if ( far_targets.size == 0 && ispointinvolume( player.origin, self.var_c218cae00ebbcbe2 ) && dot_product >= level.var_75e5276e4a1f8b11.var_19385bc8b7341373 )
            {
                far_targets[ far_targets.size ] = player;
            }
        }
    }
    
    return { #far_targets:far_targets, #close_targets:close_targets };
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xdecbab46, Offset: 0x33ce
// Size: 0x3c
function private make_resistant( totem_ent )
{
    totem_ent.is_resistant = 1;
    totem_ent.mouth_ent setcandamage( 1 );
    totem_ent.mouth_ent solid();
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xa36d484f, Offset: 0x3412
// Size: 0x3a
function private remove_resistance( totem_ent )
{
    totem_ent.is_resistant = 0;
    totem_ent.mouth_ent setcandamage( 0 );
    totem_ent.mouth_ent notsolid();
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x777594b5, Offset: 0x3454
// Size: 0xe0
function private get_ice_wall_goal_position( params )
{
    if ( isarray( level.var_75e5276e4a1f8b11.active_totems ) && level.var_75e5276e4a1f8b11.active_totems.size > 0 )
    {
        visible_totems = [];
        
        foreach ( totem in level.var_75e5276e4a1f8b11.active_totems )
        {
            visible_totems[ visible_totems.size ] = totem;
        }
        
        if ( visible_totems.size > 0 )
        {
            return utility::function_54fdde0a73217354( visible_totems, 0, 1 );
        }
    }
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0x60499487, Offset: 0x353d
// Size: 0xc
function private function_2d7437304efd638( params )
{
    
}

// Namespace zombie_boss_virgil_totem_attack
// Params 1, eflags: 0x4
// Checksum 0xbfc2774c, Offset: 0x3551
// Size: 0x30
function private function_3e76c43fcaa708b5( totem_ent )
{
    totem_ent notify( #"totem_vulnerable" );
    totem_ent notify( #"totem_end_looping_anim" );
    level thread function_d87005c9dc77df4a( totem_ent );
}

/#

    // Namespace zombie_boss_virgil_totem_attack
    // Params 0, eflags: 0x4
    // Checksum 0x708dfdfe, Offset: 0x3589
    // Size: 0x78, Type: dev
    function private attack_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8b>" );
        devgui::add_devgui_func( "<dev string:xc3>", "<dev string:xcf>", &initiate_totem_attack );
        devgui::add_devgui_func( "<dev string:xe5>", "<dev string:xfa>", &function_fc8e3b8b4f0324c9 );
        devgui::add_devgui_func( "<dev string:x10f>", "<dev string:x11f>", &kill_all_totems );
        devgui::add_devgui_func( "<dev string:x12f>", "<dev string:x142>", &function_166eeb4b4dc68345 );
        devgui::function_77df7fe7dd273e10();
        level thread update_dvars_loop();
    }

    // Namespace zombie_boss_virgil_totem_attack
    // Params 0, eflags: 0x4
    // Checksum 0x2835aaee, Offset: 0x3609
    // Size: 0xdd, Type: dev
    function private function_c66b6438ef4c7426()
    {
        nearest_totem = undefined;
        nearest_distance = undefined;
        
        foreach ( totem in level.var_75e5276e4a1f8b11.active_totems )
        {
            current_distance = distance( totem.origin, level.players[ 0 ].origin );
            
            if ( !isdefined( nearest_distance ) || nearest_distance > current_distance )
            {
                nearest_distance = current_distance;
                nearest_totem = totem;
            }
        }
        
        return nearest_totem;
    }

    // Namespace zombie_boss_virgil_totem_attack
    // Params 0, eflags: 0x4
    // Checksum 0x794d0e2f, Offset: 0x36ee
    // Size: 0x21, Type: dev
    function private function_fc8e3b8b4f0324c9()
    {
        nearest_totem = function_c66b6438ef4c7426();
        level thread function_3e76c43fcaa708b5( nearest_totem );
    }

    // Namespace zombie_boss_virgil_totem_attack
    // Params 0, eflags: 0x4
    // Checksum 0xfdede7cb, Offset: 0x3717
    // Size: 0x21, Type: dev
    function private function_166eeb4b4dc68345()
    {
        nearest_totem = function_c66b6438ef4c7426();
        level thread totem_cleanup( nearest_totem );
    }

    // Namespace zombie_boss_virgil_totem_attack
    // Params 0, eflags: 0xc
    // Checksum 0x7e205f88, Offset: 0x3740
    // Size: 0x4cd, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_9f82d67ed20281f1" );
        self endon( #"hash_9f82d67ed20281f1" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            level.var_75e5276e4a1f8b11.var_16aed486b51de962 = getdvarfloat( @"hash_391ea7de00981303", 0.4 );
            level.var_75e5276e4a1f8b11.var_6504ba95a766934e = getdvarfloat( @"hash_6cc37cd6b349872f", -25 );
            level.var_75e5276e4a1f8b11.var_1ef53774075c6625 = getdvarfloat( @"hash_35ad3a40b1f347fe", 0.8 );
            level.var_75e5276e4a1f8b11.var_bba1031fe757f20f = getdvarint( @"hash_17b656ad7861265e", 3 );
            level.var_75e5276e4a1f8b11.var_ab6ea7048fa91057 = getdvarint( @"hash_d1fffb30e45ebf8a", 200 );
            level.var_75e5276e4a1f8b11.var_26c30ad8feba0f40 = getdvarint( @"hash_a8bd886f6417cab5", 0 );
            level.var_75e5276e4a1f8b11.var_ef775f69d1802043 = getdvarint( @"hash_e39d42c297e65cc6", 100 );
            level.var_75e5276e4a1f8b11.var_9be65b5fa362b286 = getdvarfloat( @"hash_5387e79c5be71d2b", 0 );
            level.var_75e5276e4a1f8b11.var_61348c2179989c2b = getdvarint( @"hash_f04523cc855b17fa", 50 );
            level.var_75e5276e4a1f8b11.var_6babdcec0565b9a1 = getdvarint( @"hash_bf938375ed184e2e", 20 );
            level.var_75e5276e4a1f8b11.totem_knockback_magnitude = getdvarint( @"scr_virgil_totem_knockback_magnitude", 600 );
            level.var_75e5276e4a1f8b11.var_f9293ad7dc46d0d6 = getdvarfloat( @"hash_7dc8ff150ca7725", 0.5 );
            level.var_75e5276e4a1f8b11.var_53c3797ee4ee8a96 = getdvarfloat( @"hash_b957a84710378761", 30 );
            level.var_75e5276e4a1f8b11.var_834dea8c9b87bd5a = getdvarfloat( @"hash_433af5c7520abc91", 5 );
            level.var_75e5276e4a1f8b11.var_ec6788fe79287ded = getdvarfloat( @"hash_183f187d01b72eda", 1 );
            level.var_75e5276e4a1f8b11.var_cdaa4ec20c2f50b9 = getdvarfloat( @"hash_c7a4473f2536045e", 2 );
            level.var_75e5276e4a1f8b11.var_4510b2bdf4c27aeb = getdvarint( @"hash_a39358cfccc28450", 3 );
            level.var_75e5276e4a1f8b11.var_a8321ef5c8e9afbf = getdvarint( @"hash_89505b93daf78708", 800 );
            level.var_75e5276e4a1f8b11.var_bd77f82a3b414985 = getdvarfloat( @"hash_e055ddd28df2cf48", 0.2 );
            level.var_75e5276e4a1f8b11.var_c0583c1dc7dafd4a = getdvarfloat( @"hash_e0cab20e9196a919", 8 );
            level.var_75e5276e4a1f8b11.attack_delay_sec = getdvarfloat( @"hash_d7ae596041445629", 1 );
            level.var_75e5276e4a1f8b11.var_1c763439b7d315c0 = getdvarint( @"hash_853e74165ec0150b", 50 );
            level.var_75e5276e4a1f8b11.var_d11e6920d8b4caf8 = getdvarint( @"hash_3a59d6f185ca0599", 50 );
            level.var_75e5276e4a1f8b11.var_5b0e847774790aca = getdvarfloat( @"hash_fc5328f6a4161b2d", 0.2 );
            level.var_75e5276e4a1f8b11.var_9097b1a7194c3fbc = getdvarint( @"hash_bb9fb672c65263b7", 7 );
            level.var_75e5276e4a1f8b11.var_6f18f3448e0dfc6a = getdvarfloat( @"hash_35a6bd486273c8ef", 0.25 );
            level.var_75e5276e4a1f8b11.var_e8459dba1502ee07 = getdvarint( @"hash_747a4300152d4c5a", 25 );
            level.var_75e5276e4a1f8b11.var_ce8ef4db4edfa997 = getdvarint( @"hash_a9da3c4ea869a49a", 650 );
            level.var_75e5276e4a1f8b11.var_9918d54d06ba0381 = getdvarint( @"hash_299d840acfbf78e3", 10 );
            level.var_75e5276e4a1f8b11.var_7f012f2bf3e0d457 = getdvarint( @"hash_5c91fc6f626b549f", 20 );
            level.var_75e5276e4a1f8b11.var_2dd4de6be4389c86 = getdvarfloat( @"hash_67776556260f81e4", 1 );
            level.var_75e5276e4a1f8b11.var_757cb3098b2a5df = getdvarfloat( @"hash_c5b940b5660516da", 16 );
            level.var_75e5276e4a1f8b11.var_16bd8fedc9b59f9d = getdvarfloat( @"hash_111adc4cdfae63c6", 4 );
            wait 0.5;
        }
    }

#/
