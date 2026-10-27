// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab.gsc  (hash_6ca41465354bcc51.gscc) (size: 18735 Bytes / 0x492f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ee3991c (1323538716)
// size ...... 18735 (0x492f)
// includes .. 23  (offset: 0x42ab)
// strings ... 114 (offset: 0x4363)
// dev strs .. 0   (offset: 0x492f)
// exports ... 33  (offset: 0x2f8f)
// cseg ...... 0x9c3 + 0x25cc (0x2f8f)
// imports ... 111 (offset: 0x34b7)
// animtree1 . 0   (offset: 0x492f)
// animtree2 . 0   (offset: 0x492f)
#using script_16ea1b94f0f381b3;
#using script_1dcff6bbe8de311c;
#using script_2b352aad1f80b92;
#using script_5cd64c17cc1b885e;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\doorbuy;
#using scripts\mp\load;
#using scripts\mp\outofbounds;
#using scripts\mp\perk_machines;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_audio;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_fx;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_lighting;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab;

// Namespace zm_sat_scarab
// Params 0
// Checksum 0xbc75a41d, Offset: 0x9e1
// Size: 0x41c
function main()
{
    zm_sat_scarab_art::main();
    zm_sat_scarab_audio::main();
    zm_sat_scarab_fx::main();
    zm_sat_scarab_lighting::main();
    load::main();
    compass::setupminimap( "compass_map_zm_sat_scarab" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.ttlos_suppressasserts = 1;
    level.var_1d3d915cc555bf38[ "specialty_quickrevive" ] = 1;
    level thread zm_sat_scarab_rb::init();
    
    if ( getdvarint( @"hash_dc3f816c71d724e4" ) != 1 )
    {
        level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_68de84f921eed684", 1 );
    }
    else
    {
        level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_6893b01e710ce40", 1 );
    }
    
    perk_machines::function_1dd836bc3f4db1e6( "specialty_deadshot" );
    level.var_7a5a3a48204781da = &function_1c130341719e29f8;
    level callback::add( "zone_changed", &on_zone_changed );
    level.var_82a2ecb4e88e12b = 1;
    level.var_e04fc4037b04adbd = 1;
    
    if ( !isdefined( level.kill_border_triggers ) )
    {
        level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    }
    
    level.var_c8456aef09c0fa08 = 400;
    level.var_4798e0076da78416 = [ "hellstorm_missile", "chopper_door_gunner", "toma_strike", "dawg" ];
    level.var_82608d37301e46de = [ "zone_boss_arena_oubliette_1", "zone_boss_arena_oubliette_2", "zone_boss_arena_oubliette_3", "zone_boss_arena_oubliette_4", "zone_boss_arena_ff", "zone_nexus_interior_core", "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard", "zone_ne_temple_westwing_exterior", "zone_ne_temple_eastwing_exterior", "zone_ne_temple_mainhall", "zone_ne_temple_finalroom", "zone_ne_temple_westwing", "zone_ne_temple_eastwing", "zone_ne_temple_sideroom", "zone_nw_temple_entrance", "zone_nw_temple_finalroom", "zone_nw_temple_mainhall", "zone_safehouse_interior_upper", "zone_safehouse_interior_upper_bedroom_1", "zone_safehouse_interior_upper_bedroom_2", "zone_safehouse_interior_lower", "zone_se_temple_entrance", "zone_se_temple_finalroom", "zone_se_temple_mainhall_north", "zone_se_temple_mainhall_south", "zone_blackroom", "zone_sw_temple_finalroom", "zone_sw_temple_secret_space", "zone_sw_temple_sideroom", "zone_sw_temple_sideroom_landing", "zone_sw_temple_sideroom_upper" ];
    utility::registersharedfunc( #"ncfd", #"hash_81eb587ae514df01", &function_5a94f8cb8437b7e6 );
    utility::registersharedfunc( #"zombie_loom", #"hash_46c84f4e79aa1b36", &function_2b8e74824a88e80f );
    level thread setup_scarab_doorbuys();
    level thread function_ab6bd42293063986();
    level thread zm_round_accelerant::init_round_accelerant();
    level thread function_2b5bf82c690c1e27();
    level function_a9981dab922ea2ef();
    level function_a85bd760c2869d9d();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"open_map", &function_24e70619111c7c13 );
    
    foreach ( subclass in level.spawner_subclass_map[ "hvt_large" ] )
    {
        zone_spawner::function_3d210dfed7f384df( subclass, "zone_ne_temple_courtyard_balcony_east" );
    }
    
    level.var_997e716c3f61f90 = 1;
    function_2b6d4c9fbff47215();
    level thread function_d09a9cc575b27e10();
    level thread function_e15850c45bf9bc74();
    level thread function_18d7a0868d0f3dc0();
    
    if ( !getdvarint( @"hash_133ef07dad4cf03b", 0 ) )
    {
        level thread setup_platforms();
    }
    
    scene::function_85b13b837056bc8b( &function_192948c6b590c2a3 );
    level thread function_271531e778715fe3();
    createnavbadplacebybounds( ( -4711.52, 207.79, 1781.31 ), ( 128, 128, 64 ), ( 0, 0, 0 ) );
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0xba1d6e03, Offset: 0xe05
// Size: 0x122
function private function_271531e778715fe3()
{
    utility::flag_wait( "doorbuy_init_complete" );
    
    foreach ( s_doorbuy in level.a_s_doorbuys )
    {
        foreach ( door in s_doorbuy.doors )
        {
            if ( door.classname == "script_brushmodel" && isdefined( door.minimap_scriptable ) )
            {
                door.minimap_scriptable freescriptable();
            }
        }
    }
}

// Namespace zm_sat_scarab
// Params 0
// Checksum 0xcd4b03de, Offset: 0xf2f
// Size: 0x95
function function_192948c6b590c2a3()
{
    players = scene::function_5fe163f439457bd0();
    
    foreach ( player in players )
    {
        player function_5c764e554642cf04();
        player utility::function_7c10ea82c1e305b8( "grappling_hook_speed_cam", "off" );
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x7dd7cb27, Offset: 0xfcc
// Size: 0x8e
function private function_2b5bf82c690c1e27()
{
    a_tiles = getentarray( "bf_lift_tile", #targetname );
    
    foreach ( tile in a_tiles )
    {
        tile hide();
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0xf9df5f7e, Offset: 0x1062
// Size: 0xe5
function private function_2b6d4c9fbff47215()
{
    level.var_e3780a9cdac7c563 = getentarray( "trigger_multiple_fire", #classname );
    
    foreach ( fire_trigger in level.var_e3780a9cdac7c563 )
    {
        if ( !isdefined( fire_trigger ) )
        {
            continue;
        }
        
        fire_trigger.var_deeec81603b3df0 = 3;
        
        if ( isdefined( fire_trigger.script_damage ) )
        {
            fire_trigger.var_deeec81603b3df0 = fire_trigger.script_damage;
        }
        
        trigger::makeenterexittrigger( fire_trigger, &function_f445ee64d94ada75, &function_50076a70efad500d, undefined, undefined, &function_ef78df1287ec9847 );
    }
}

// Namespace zm_sat_scarab
// Params 3
// Checksum 0x112f6432, Offset: 0x114f
// Size: 0x78
function function_14c2f6686d9e89d6( origin, radius, height )
{
    fire_trigger = spawn( "trigger_radius", origin, 0, radius, height );
    fire_trigger.var_deeec81603b3df0 = 3;
    trigger::makeenterexittrigger( fire_trigger, &function_f445ee64d94ada75, &function_50076a70efad500d, undefined, undefined, &function_ef78df1287ec9847 );
    level.var_e3780a9cdac7c563[ level.var_e3780a9cdac7c563.size ] = fire_trigger;
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0x2219cd8a, Offset: 0x11cf
// Size: 0x43, Type: bool
function private function_ef78df1287ec9847( entering_ent, fire_trigger )
{
    if ( fire_trigger.targetname == "nyxara_uncorrupted" && !utility::flag( "nyxara_uncorrupted_fire_enabled" ) )
    {
        return true;
    }
    
    return !isplayer( entering_ent );
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0x6c4fc371, Offset: 0x121b
// Size: 0xc0
function private function_f445ee64d94ada75( player, fire_trigger )
{
    trigger_id = fire_trigger getentitynumber();
    
    if ( !isdefined( player.var_f51c96694e9b207c ) )
    {
        player.var_f51c96694e9b207c = [];
    }
    
    if ( !isdefined( player.var_955ed084973dad50 ) )
    {
        player.var_955ed084973dad50 = [];
    }
    
    player.var_f51c96694e9b207c[ trigger_id ] = fire_trigger.var_deeec81603b3df0;
    player.var_955ed084973dad50[ trigger_id ] = gettime() + 500;
    
    if ( !isdefined( player.var_960924ae2ec5f66f ) )
    {
        player.var_960924ae2ec5f66f = 0;
    }
    
    player.var_960924ae2ec5f66f++;
    player thread function_5d1f2b48e3f9875c();
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0xffc2fdc7, Offset: 0x12e3
// Size: 0x71
function private function_50076a70efad500d( player, fire_trigger )
{
    trigger_id = fire_trigger getentitynumber();
    
    if ( isdefined( player.var_f51c96694e9b207c[ trigger_id ] ) )
    {
        player.var_f51c96694e9b207c[ trigger_id ] = undefined;
        player.var_955ed084973dad50[ trigger_id ] = undefined;
        
        if ( player.var_960924ae2ec5f66f > 0 )
        {
            player.var_960924ae2ec5f66f--;
        }
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0xc
// Checksum 0x5f05019, Offset: 0x135c
// Size: 0x130
function private function_5d1f2b48e3f9875c()
{
    self notify( #"hash_ec2b274a78d7e72" );
    self endon( #"hash_ec2b274a78d7e72" );
    self endon( #"death", #"disconnect" );
    
    while ( self.var_960924ae2ec5f66f > 0 )
    {
        wait 0.25;
        
        if ( !isalive( self ) )
        {
            return;
        }
        
        total_damage = 0;
        now_time_ms = gettime();
        
        foreach ( trigger_id, damage in self.var_f51c96694e9b207c )
        {
            if ( !isdefined( damage ) )
            {
                continue;
            }
            
            if ( isdefined( self.var_955ed084973dad50[ trigger_id ] ) && now_time_ms < self.var_955ed084973dad50[ trigger_id ] )
            {
                continue;
            }
            
            total_damage += damage;
        }
        
        if ( total_damage <= 0 )
        {
            continue;
        }
        
        self dodamage( total_damage, self.origin, self, self, "MOD_FIRE" );
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x224a530b, Offset: 0x1494
// Size: 0xd3
function private function_ab6bd42293063986()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_e7edefffc3e9dfde = getentarray( "ground_drone_unit", #targetname );
        
        foreach ( var_e1df2f98e05dadca in var_e7edefffc3e9dfde )
        {
            if ( !isdefined( var_e1df2f98e05dadca ) )
            {
                continue;
            }
            
            if ( var_e1df2f98e05dadca.var_1588d2d74ee71a65 )
            {
                continue;
            }
            
            var_e1df2f98e05dadca.var_1588d2d74ee71a65 = 1;
            var_e1df2f98e05dadca thread function_fea0345e814d8d2();
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x9000d2d5, Offset: 0x156f
// Size: 0xa3
function private function_fea0345e814d8d2()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_abc3d3d0bde3c822 = 0;
    
    while ( true )
    {
        if ( outofbounds::istouchingoobtrigger() )
        {
            self dodamage( self.health, self.origin );
            return;
        }
        
        if ( self vehicle_isonground() && !ispointonnavmesh( self.origin, self ) )
        {
            var_abc3d3d0bde3c822 += 0.1;
            
            if ( var_abc3d3d0bde3c822 >= 3 )
            {
                self dodamage( self.health, self.origin );
                return;
            }
        }
        else
        {
            var_abc3d3d0bde3c822 = 0;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab
// Params 0
// Checksum 0xafb7ebe1, Offset: 0x161a
// Size: 0x15, Type: bool
function function_5a94f8cb8437b7e6()
{
    if ( level utility::flag( "power_on" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab
// Params 1, eflags: 0x4
// Checksum 0xd5e9fec7, Offset: 0x1638
// Size: 0x72
function private function_2b8e74824a88e80f( dmgstruct )
{
    if ( !isdefined( dmgstruct ) )
    {
        return;
    }
    
    if ( !utility::callsharedfunc( #"weap_scarabww", #"hash_6630991317bcc3af", dmgstruct ) )
    {
        return;
    }
    
    dmgstruct.var_11e45b42fe0bdb00 = 1;
    dmgstruct.idamage = ( self.var_2b5852f808241817 ?? dmgstruct.idamage ) + 1;
    return dmgstruct.idamage;
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x20be12ef, Offset: 0x16b3
// Size: 0x15d
function private setup_scarab_doorbuys()
{
    utility::flag_wait( "doorbuy_init_complete" );
    level.var_22c88164c67477ae = [];
    
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        doorbuy.var_870561c2bbbdb6b7 = 1;
        doorbuy.script_delete = 0;
        
        foreach ( doorbuy_brush in doorbuy.doors )
        {
            if ( doorbuy_brush.script_noteworthy == "teleport_back_ent_trigger" )
            {
                doorbuy_brush.var_29b8bf859c59528f = 1;
                continue;
            }
            
            if ( doorbuy_brush.doorbuy_size )
            {
                level.var_22c88164c67477ae[ level.var_22c88164c67477ae.size ] = doorbuy_brush;
            }
        }
    }
}

// Namespace zm_sat_scarab
// Params 1, eflags: 0x4
// Checksum 0xba78f212, Offset: 0x1818
// Size: 0x107
function private function_24e70619111c7c13( params )
{
    zm_utility::open_sesame();
    
    if ( level.scarab_ww_quest )
    {
        foreach ( step in level.scarab_ww_quest.steps )
        {
            if ( !step.completed )
            {
                level zm_quest::function_e65609834444650c( step, 0 );
            }
        }
    }
    else
    {
        level function_f5254734e22cd6cc();
    }
    
    str_room = params[ 0 ];
    
    if ( str_room == "v" )
    {
        level thread namespace_9972523f9872e5a4::function_596128becdf13eca();
        return;
    }
    
    if ( str_room == "c" )
    {
        level thread namespace_9972523f9872e5a4::function_15c042a972d1bd3c();
        return;
    }
    
    level thread namespace_9972523f9872e5a4::function_596128becdf13eca();
    level thread namespace_9972523f9872e5a4::function_15c042a972d1bd3c();
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x4fb1ad61, Offset: 0x1927
// Size: 0x453
function private function_f5254734e22cd6cc()
{
    var_41604c028f54cbea = getentarray( "doorbuy_door_nyxara_sideroom_1", #targetname );
    
    foreach ( door in var_41604c028f54cbea )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    var_41604c028f54cbea = getentarray( "doorbuy_door_19", #targetname );
    
    foreach ( door in var_41604c028f54cbea )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    var_41604c028f54cbea = getentarray( "doorbuy_door_17", #targetname );
    
    foreach ( door in var_41604c028f54cbea )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    a_pillars = getentarray( "me_pillar", #targetname );
    
    foreach ( p in a_pillars )
    {
        if ( int( p.script_noteworthy ) == 5 )
        {
            pillar = p;
            break;
        }
    }
    
    platform_clip = getent( "qo_pillar_platform_clip", #targetname );
    a_cylinders = getentarray( "ri_pillar_cylinder", #targetname );
    pillar_platform = getent( "sv_pillar_platform", #targetname );
    pillar.e_mover = utility::spawn_model( "tag_origin", pillar_platform.origin, pillar_platform.angles );
    pillar_platform linkto( pillar.e_mover, "tag_origin" );
    origin_offset = pillar.origin - pillar_platform.origin;
    angles_offset = pillar.angles - pillar_platform.angles;
    pillar linkto( pillar.e_mover, "tag_origin", origin_offset, angles_offset );
    
    foreach ( cylinder in a_cylinders )
    {
        origin_offset = cylinder.origin - pillar_platform.origin;
        angles_offset = cylinder.angles - pillar_platform.angles;
        cylinder linkto( pillar.e_mover, "tag_origin", origin_offset, angles_offset );
    }
    
    var_8b0c1d8a8ff1a6a0 = pillar.origin + ( 0, 0, -242 );
    pillar.e_mover.origin = var_8b0c1d8a8ff1a6a0;
    waitframe();
    
    if ( pillar.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( pillar.var_12aadf5d8bbfdafd );
    }
    
    platform_clip delete();
    pillar.e_mover delete();
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x75ca14b9, Offset: 0x1d82
// Size: 0x2a
function private function_d09a9cc575b27e10()
{
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        level utility::flag_wait( "scriptables_ready" );
        level function_356e590c649b5f4a();
        return;
    }
}

// Namespace zm_sat_scarab
// Params 0
// Checksum 0x90615a28, Offset: 0x1db4
// Size: 0x2fc
function setup_platforms()
{
    level.zm_moving_platforms_rh = [];
    level.zm_moving_platforms_rh = getentarray( "zm_movplat_rh", #targetname );
    
    if ( level.zm_moving_platforms_rh.size == 0 )
    {
        return;
    }
    
    var_91bed5636f5f050d = getentarray( "m_pltfm_vlm_rh", "targetname" );
    var_bc45d2d32752059 = getentarray( "movplat_rh_clip", "targetname" );
    var_850a68fff4bebd40 = getent( "movplat_rh_slipclip", "targetname" );
    
    foreach ( v in var_91bed5636f5f050d )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms_rh, v.origin, 9999 );
        v enablelinkto();
        v linkto( owner );
        v.my_owner = owner;
        owner.my_volume = v;
        owner.v_highest = owner.origin + ( 0, 0, 10 );
        owner.v_lowest = owner.origin - ( 0, 0, 10 );
    }
    
    foreach ( clip in var_bc45d2d32752059 )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms_rh, clip.origin, 9999 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_59f931d3a85c740f = clip;
        clip notsolid();
    }
    
    owner = function_b21056d585c710d( level.zm_moving_platforms_rh, var_850a68fff4bebd40.origin, 9999 );
    var_850a68fff4bebd40 enablelinkto();
    var_850a68fff4bebd40 linkto( owner );
    var_850a68fff4bebd40.my_owner = owner;
    owner.var_954e28ef2b10ad82 = var_850a68fff4bebd40;
    var_850a68fff4bebd40 notsolid();
    
    foreach ( platform in level.zm_moving_platforms_rh )
    {
        platform hide();
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0xf8ead06, Offset: 0x20b8
// Size: 0x569
function private function_356e590c649b5f4a()
{
    level thread function_3c45f4b4587cda39();
    var_8c3647c076945ee = utility::getstruct( "za_c", "targetname" );
    
    if ( !var_8c3647c076945ee )
    {
        return;
    }
    
    spawnscriptable( %"hash_7913bfcaf7cfe5e6", var_8c3647c076945ee.origin, var_8c3647c076945ee.angles );
    s_prism = utility::getstruct( "nm_p", "targetname" );
    level function_164546ffa7406fb0( "nm_p" );
    
    while ( s_prism.target )
    {
        if ( s_prism.target != "l_p_1" )
        {
            level function_164546ffa7406fb0( s_prism.target );
        }
        
        s_prism = utility::getstruct( s_prism.target, "targetname" );
    }
    
    level function_164546ffa7406fb0( "l_p_1", 1 );
    level function_164546ffa7406fb0( "l_p_2", 1 );
    level function_164546ffa7406fb0( "l_p_3", 1 );
    var_d7f1307ff21b944d = utility::getstructarray( "n_v_s_d", "targetname" );
    
    foreach ( s_vine in var_d7f1307ff21b944d )
    {
        vine = spawnscriptable( %"hash_7092b5a45e034813", s_vine.origin, s_vine.angles );
        vine setscriptablepartstate( "body", s_vine.script_noteworthy );
    }
    
    s_center_vine = utility::getstruct( "n_c_v", "targetname" );
    center_vine = spawnscriptable( %"hash_1533a771a453d6bb", s_center_vine.origin, s_center_vine.angles );
    center_vine.var_12aadf5d8bbfdafd = createnavobstaclebybounds( s_center_vine.origin, ( 25, 25, 100 ), s_center_vine.angles );
    var_29c017a8d2bb94d4 = utility::getstructarray( "vn_r_s", "targetname" );
    
    foreach ( s_sconce in var_29c017a8d2bb94d4 )
    {
        spawnscriptable( %"hash_4e5646fa83248a1a", s_sconce.origin, s_sconce.angles );
        handle = spawnscriptable( %"hash_bb577fe849ca21a", s_sconce.origin, s_sconce.angles );
        handle setscriptablepartstate( "body", "retract" );
    }
    
    s_anvil = utility::getstruct( "bx_d_a", "targetname" );
    anvil = spawnscriptable( %"hash_7337169b493df71f", s_anvil.origin, s_anvil.angles );
    anvil.var_12aadf5d8bbfdafd = createnavobstaclebybounds( anvil.origin, ( 20, 35, 75 ), anvil.angles );
    activateworldevent( "we_lgt_ww_d_a" );
    s_floor_board = utility::getstruct( "kr_a_p_f_b", "targetname" );
    spawnscriptable( %"hash_3ddda2b979eeff2e", s_floor_board.origin, s_floor_board.angles );
    a_s_corpses = utility::getstructarray( "a_p_c", "targetname" );
    
    foreach ( s_corpse in a_s_corpses )
    {
        corpse = spawnscriptable( %"hash_5b9daca962addae6", s_corpse.origin, s_corpse.angles );
        corpse setscriptablepartstate( "body", s_corpse.script_noteworthy );
    }
    
    a_pillars = getentarray( "me_pillar", #targetname );
    
    foreach ( pillar in a_pillars )
    {
        if ( int( pillar.script_noteworthy ) == 5 )
        {
            pillar.var_12aadf5d8bbfdafd = createnavobstaclebybounds( pillar.origin, ( 40, 40, 120 ), pillar.angles );
        }
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x3ff0aa86, Offset: 0x2629
// Size: 0xef
function private function_3c45f4b4587cda39()
{
    level utility::flag_wait( "ammo_caches_initialized" );
    level utility::flag_wait( "zone_setup_finished" );
    
    foreach ( s_ammo_cache in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        ammo_cache = s_ammo_cache.ammocache_trigger.var_a3338cc37b82b7b3;
        
        if ( zone_manager::function_427ae6b3bc10b5ac( ammo_cache.origin, "zone_ne_temple_sideroom" ) )
        {
            ammo_cache utility::ent_flag_wait( "minimap_floor_setup_complete" );
            ammo_cache utility::function_7c10ea82c1e305b8( "icon", "disable" );
        }
    }
}

// Namespace zm_sat_scarab
// Params 1, eflags: 0x4
// Checksum 0xaa432dd3, Offset: 0x2720
// Size: 0x6a
function private function_2713edefc4104cfe( n_symbol_index )
{
    switch ( n_symbol_index )
    {
        case 1:
            return 3.5;
        case 2:
            return 4;
        case 3:
            return 4;
        case 4:
            return 2.8;
        default:
            return 3.5;
    }
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0x228255b7, Offset: 0x2792
// Size: 0x2b2
function private function_164546ffa7406fb0( targetname, var_704371ed09ad14dc = 0 )
{
    s_prism = utility::getstruct( targetname, "targetname" );
    var_aae9ba29786e9ca7 = spawnscriptable( %"hash_1afbc4eea83ff1e1", s_prism.origin, s_prism.angles );
    var_aae9ba29786e9ca7.var_68e1ed47045d49b4 = utility::spawn_model( %"hash_1c5bcc5b65c82ced", s_prism.origin, s_prism.angles );
    var_aae9ba29786e9ca7.var_68e1ed47045d49b4.var_aae9ba29786e9ca7 = var_aae9ba29786e9ca7;
    base = spawnscriptable( %"hash_5a8be7c27edb65ca", s_prism.origin, s_prism.angles );
    base.var_aae9ba29786e9ca7 = var_aae9ba29786e9ca7;
    var_aae9ba29786e9ca7.base = base;
    var_aae9ba29786e9ca7.var_b0c37265004d7765 = var_aae9ba29786e9ca7.base.origin + anglestoforward( var_aae9ba29786e9ca7.base.angles ) * 17;
    var_aae9ba29786e9ca7.var_15f69f103ace73b8 = 0;
    var_aae9ba29786e9ca7.a_spawn_angles = s_prism.angles;
    
    if ( s_prism.target2 )
    {
        var_aae9ba29786e9ca7.var_ae1ce70a6b469c3d = utility::getstruct( s_prism.target2, "targetname" ).origin;
    }
    
    if ( s_prism.script_noteworthy )
    {
        var_aae9ba29786e9ca7.n_angle_override = int( s_prism.script_noteworthy );
    }
    
    tag_origin = var_aae9ba29786e9ca7.var_68e1ed47045d49b4 gettagorigin( "j_paw" );
    tag_angles = var_aae9ba29786e9ca7.var_68e1ed47045d49b4 gettagangles( "j_paw" );
    local_origin = rotatevectorinverted( tag_origin - var_aae9ba29786e9ca7.var_68e1ed47045d49b4.origin, var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles );
    local_angles = combineanglesinverted( var_aae9ba29786e9ca7.var_68e1ed47045d49b4.angles, tag_angles );
    var_aae9ba29786e9ca7 utility::scriptable_setparententity( var_aae9ba29786e9ca7.var_68e1ed47045d49b4, local_origin, local_angles );
    
    if ( var_704371ed09ad14dc )
    {
        var_aae9ba29786e9ca7 setscriptablepartstate( "body", "hide" );
        var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_open" );
    }
    else
    {
        var_aae9ba29786e9ca7.var_68e1ed47045d49b4 scriptmodelplayanim( "sat_fxanim_zm_prism_closed" );
    }
    
    return var_aae9ba29786e9ca7;
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0x9c6c0ae8, Offset: 0x2a4d
// Size: 0x9a
function private function_1c130341719e29f8( streakitem, slotnumber )
{
    if ( isdefined( self.var_b43d27527f482c08 ) && arraycontains( level.var_4798e0076da78416, streakitem.streakname ) )
    {
        return 0;
    }
    
    if ( isdefined( self.var_163ee79762bc0a64 ) && arraycontains( level.var_14f114e0c14850f8, streakitem.streakname ) )
    {
        return 0;
    }
    
    if ( streakitem.streakname == "remote_turret" && self.b_on_platform )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zm_sat_scarab
// Params 1, eflags: 0x4
// Checksum 0xe74c1549, Offset: 0x2aef
// Size: 0x58
function private on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) )
    {
        if ( arraycontains( level.var_82608d37301e46de, params.zone_struct.script_zone_name ) )
        {
            self.var_b43d27527f482c08 = 1;
            return;
        }
        
        self.var_b43d27527f482c08 = undefined;
    }
}

// Namespace zm_sat_scarab
// Params 0
// Checksum 0x73e95c39, Offset: 0x2b4f
// Size: 0x5e
function function_e15850c45bf9bc74()
{
    var_deb694e00c116016 = getent( "song_ee_clip", "script_noteworthy" );
    
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        if ( var_deb694e00c116016 )
        {
            var_deb694e00c116016 notsolid();
            var_deb694e00c116016 connectpaths();
            var_deb694e00c116016 delete();
        }
        
        return;
    }
    
    if ( var_deb694e00c116016 )
    {
        var_deb694e00c116016 solid();
        var_deb694e00c116016 disconnectpaths();
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x2fa516e0, Offset: 0x2bb5
// Size: 0x7b
function private function_18d7a0868d0f3dc0()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", #targetname );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
    level utility::flag_set( "rh_col_set" );
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0xfcb7d2a7, Offset: 0x2c38
// Size: 0x21e
function private function_a9981dab922ea2ef()
{
    var_6b72a20e2c1ba745 = [];
    trigger_origin = ( -2209, -3995, 2380 );
    trigger_angles = ( 0, 79, 0 );
    trigger_half_size = ( 32, 348, 242 );
    trig = spawn( "trigger_box", trigger_origin, 16, trigger_half_size, trigger_half_size + ( 1, 1, 1 ) );
    trig.angles = trigger_angles;
    var_6b72a20e2c1ba745[ var_6b72a20e2c1ba745.size ] = trig;
    trig = spawn( "noent_volume_trigger_radius", ( 907, -3566, 825 ), 16, 800, 600 );
    trig.targetname = "teleport_back_noent_trigger";
    trigger_origin = ( 28688, 30408, 1984 );
    trigger_angles = ( 0, 35.0003, 0 );
    size_min = ( 1178, 406, 732 );
    size_max = ( 272, 476, 296 );
    trig = spawn( "noent_volume_trigger_box", trigger_origin, 16, size_min, size_max );
    trig.targetname = "teleport_back_noent_trigger";
    trig.angles = trigger_angles;
    trigger_origin = ( 655, -4034, 2143 );
    trigger_angles = ( 0, 8, 0 );
    size_min = ( 64, 314, 80 );
    size_max = ( 114, 364, 262 );
    trig = spawn( "noent_volume_trigger_box", trigger_origin, 16, size_min, size_max );
    trig.targetname = "teleport_back_noent_trigger";
    trig.angles = trigger_angles;
    
    foreach ( volume in var_6b72a20e2c1ba745 )
    {
        level thread namespace_c23a90831c0cb043::watch_trigger_volume( volume );
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0xd25aa5b7, Offset: 0x2e5e
// Size: 0x43
function private function_a85bd760c2869d9d()
{
    trigger = spawn( "noent_volume_trigger_radius", ( 2656, -850, 1420 ), 0, 180, 96 );
    trigger::makeenterexittrigger( trigger, &function_dafa9ea9c3545b68, &function_dafa9ea9c3545b68, undefined, undefined, &function_1b50233535c98047 );
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0x9c91eb56, Offset: 0x2ea9
// Size: 0x26, Type: bool
function private function_1b50233535c98047( entering_ent, trigger )
{
    return !( isscriptedagent( entering_ent ) && isalive( entering_ent ) );
}

// Namespace zm_sat_scarab
// Params 2, eflags: 0x4
// Checksum 0xd0a8ea34, Offset: 0x2ed8
// Size: 0x4f
function private function_dafa9ea9c3545b68( ai, trigger )
{
    if ( !level.var_af9abd1653f555dd && !ai function_71b6cd2658d98377( ( 2578, -1109, 1451 ), ( 2559, -1203, 1451 ) ) )
    {
        level thread function_af9abd1653f555dd();
    }
}

// Namespace zm_sat_scarab
// Params 0, eflags: 0x4
// Checksum 0x79d8af03, Offset: 0x2f2f
// Size: 0x60
function private function_af9abd1653f555dd()
{
    level endon( #"game_ended" );
    level.var_af9abd1653f555dd = createnavbadplacebybounds( ( 2580, -1145, 1451 ), ( 50, 50, 32 ), ( 0, 0, 0 ) );
    wait 0.25;
    destroynavobstacle( level.var_af9abd1653f555dd );
    level.var_af9abd1653f555dd = undefined;
}

