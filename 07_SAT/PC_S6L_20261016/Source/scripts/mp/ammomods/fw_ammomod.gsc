// scripts\mp\ammomods\fw_ammomod.gsc  (hash_23db6f5c71b1807a.gscc) (size: 20097 Bytes / 0x4e81 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f83445c (2139309148)
// size ...... 20097 (0x4e81)
// includes .. 12  (offset: 0x4955)
// strings ... 70  (offset: 0x49b5)
// dev strs .. 5   (offset: 0x4e45)
// exports ... 29  (offset: 0x3681)
// cseg ...... 0x7a3 + 0x2ede (0x3681)
// imports ... 104 (offset: 0x3b09)
// animtree1 . 0   (offset: 0x4e81)
// animtree2 . 0   (offset: 0x4e81)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\content_manager;

#namespace fw_ammomod;

// Namespace fw_ammomod
// Params 0, eflags: 0x5
// Checksum 0xe8ef03cc, Offset: 0x7c1
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "fw_ammomod", undefined, &__init__, undefined );
}

// Namespace fw_ammomod
// Params 0
// Checksum 0x9948765b, Offset: 0x7de
// Size: 0xa
function __init__()
{
    level thread init_fw();
}

// Namespace fw_ammomod
// Params 0
// Checksum 0x18c6ea7c, Offset: 0x7f0
// Size: 0x423
function init_fw()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    fwbundle = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ];
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "fw_ready" );
    procpercent = fwbundle.procpercent ?? 0.15;
    var_a3e31d9c9d0c8ca6 = fwbundle.var_9225566c1a61c6ca ?? 0.03;
    cooldownentity = fwbundle.cooldownentity ?? 0;
    cooldownattacker = fwbundle.cooldownattacker ?? 40;
    cooldownglobal = fwbundle.cooldownglobal ?? 1;
    var_92c00cb857963986 = fwbundle.occursondeath ?? 1;
    var_2d38a15555828531 = fwbundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = fwbundle.var_1c73b60ea00808df ?? "";
    element = fwbundle.element ?? "dark";
    level.ammomod_fw_throttle = throttle::throttle_initialize( "fw_ammomod", 2 );
    level._effect[ "temp_beam" ] = loadfxasset( "vfx_jup_ob_summon_beam" );
    level._effect[ "fx_trail" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_trail_zmb" );
    level._effect[ "fx_burst" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_burst_ch" );
    level._effect[ "fx_small" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_small" );
    level._effect[ "fx_middle" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_middle" );
    level._effect[ "fx_large" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_large" );
    level._effect[ "fx_weeping_willow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_weeping_willow_purple_01" );
    level._effect[ "fx_fire_wheel" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_fire_wheel_purple" );
    level._effect[ "fx_trail_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_trail_zmb_yellow" );
    level._effect[ "fx_burst_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_burst_ch_yellow" );
    level._effect[ "fx_small_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_small_yellow" );
    level._effect[ "fx_middle_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_middle_yellow" );
    level._effect[ "fx_large_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_large_yellow" );
    level._effect[ "fx_weeping_willow_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_weeping_willow_yellow_01" );
    level._effect[ "fx_fire_wheel_yellow" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_fire_wheel_yellow" );
    level._effect[ "fx_trail_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_trail_zmb_green" );
    level._effect[ "fx_burst_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_burst_ch_green" );
    level._effect[ "fx_small_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_small_green" );
    level._effect[ "fx_middle_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_middle_green" );
    level._effect[ "fx_large_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_zmb_impact_large_green" );
    level._effect[ "fx_weeping_willow_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_weeping_willow_green_01" );
    level._effect[ "fx_fire_wheel_green" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_fire_wheel_green" );
    level._effect[ "firework_vfx" ] = loadfxasset( "vfx_sat_zm_weapons_fireworks_ground" );
    level.var_a514debfcdaa0643 = [];
    level.var_b217707e7d9798a5 = [];
    level.var_825bf66413ecba43 = 0;
    ammo_mod::register_ammo_mod( "fw_ammomod", fwbundle.id ?? 8, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_80f2e0db26abd781, var_2d38a15555828531, var_1c73b60ea00808df, &function_e9931a59fd74bcbb, element );
    callback::add( #"on_ai_killed", &function_9b0055fdba809108 );
    utility::flag_set( "fw_ready" );
    
    /#
        level thread setup_fw_devgui();
    #/
}

// Namespace fw_ammomod
// Params 1
// Checksum 0x2c024b79, Offset: 0xc1b
// Size: 0x3a
function check_scoreevent( damage )
{
    var_508b8e476f4ac9a9 = self.health - damage < 1;
    
    if ( var_508b8e476f4ac9a9 )
    {
        self.var_e797f68de73ece4e = "_fworks";
    }
}

// Namespace fw_ammomod
// Params 0
// Checksum 0x8e1cd226, Offset: 0xc5d
// Size: 0x74
function get_random_color()
{
    color_int = randomintrange( 1, 4 );
    
    switch ( color_int )
    {
        case 1:
            return "";
        case 2:
            return "_yellow";
        case 3:
            return "_green";
        default:
            return "";
    }
}

// Namespace fw_ammomod
// Params 1
// Checksum 0x653efb51, Offset: 0xcd9
// Size: 0x23
function register_fw_result_func( func )
{
    level.var_a514debfcdaa0643[ level.var_a514debfcdaa0643.size ] = func;
}

// Namespace fw_ammomod
// Params 1
// Checksum 0xdb133f5e, Offset: 0xd04
// Size: 0x23
function register_fw_validation_func( func )
{
    level.var_b217707e7d9798a5[ level.var_b217707e7d9798a5.size ] = func;
}

// Namespace fw_ammomod
// Params 0
// Checksum 0x57738e4c, Offset: 0xd2f
// Size: 0xd0, Type: bool
function function_e9931a59fd74bcbb()
{
    if ( level.ammo_mods[ "fw_ammomod" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( isdefined( self.var_2d15dfafdf82acc7 ) )
    {
        failfireworks = [[ self.var_2d15dfafdf82acc7 ]]();
        
        if ( !failfireworks )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_b217707e7d9798a5 )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace fw_ammomod
// Params 1
// Checksum 0x5816b91, Offset: 0xe08
// Size: 0x15b
function function_80f2e0db26abd781( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    var_b121bc46582c97be = result_params.var_b121bc46582c97be;
    
    if ( level.var_a514debfcdaa0643.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_a514debfcdaa0643 )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    thread function_5429750f788a9e59( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, undefined, undefined, undefined, undefined, var_b121bc46582c97be );
}

// Namespace fw_ammomod
// Params 12
// Checksum 0x381e080b, Offset: 0xf6b
// Size: 0x5b3
function function_5429750f788a9e59( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_b121bc46582c97be )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    big_game_active = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_big_game" );
    farfalle_active = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_farfalle" );
    var_bc697ed20567b32 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_big_bang" );
    var_a468199485ca842f = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_weeping_willow" );
    var_11f8a7de0ef3eb81 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_fire_wheel" );
    starlight_active = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_starlight" );
    var_1d7359f489e35164 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_condensed_yield" );
    var_1d821a845ac20b8f = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"hash_33045a30e554b4b9" );
    ai_tier = ai_utility::get_ai_tier();
    fw_center = content_manager::spawn_script_model( self, "tag_fw_center", 0, 1 );
    fw_center.origin = self gettagorigin( get_beam_tag() );
    
    if ( big_game_active )
    {
        if ( ai_tier == 3 )
        {
            var_9f3f2a4b4ff74794 = level.zombie_augments[ #"fw_big_game" ].var_5c9f8d3e4285a6f1 ?? 4;
            var_a78ed65624d13ab0 = level.zombie_augments[ #"fw_big_game" ].var_896ab5a3ddf6c08f ?? 3;
            var_335c0276c05ca7bf = level.zombie_augments[ #"fw_big_game" ].var_16b6439fde2126ad ?? 2;
            
            for ( i = 0; i < var_9f3f2a4b4ff74794 ; i++ )
            {
                if ( isalive( self ) )
                {
                    fw_center.origin = self gettagorigin( get_beam_tag() );
                    thread function_2b2e4497e6ffdd0c( attacker, sweapon );
                }
                
                var_c3acb2f3955ba187 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_c3acb2f3955ba187 ?? 100;
                var_2c7cb514b6c7f524 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_2c7cb514b6c7f524 ?? 5;
                upvec = vectornormalize( anglestoup( fw_center.angles ) );
                fwpos = fw_center.origin + upvec * var_c3acb2f3955ba187;
                fw_center launch_fw( fwpos, var_a78ed65624d13ab0, big_game_active, starlight_active, var_1d7359f489e35164, var_1d821a845ac20b8f, fw_center, attacker, 0 );
                wait var_335c0276c05ca7bf;
            }
            
            if ( isdefined( fw_center ) )
            {
                fw_center delete();
            }
        }
        else
        {
            var_c3acb2f3955ba187 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_c3acb2f3955ba187 ?? 100;
            var_2c7cb514b6c7f524 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_2c7cb514b6c7f524 ?? 5;
            upvec = vectornormalize( anglestoup( fw_center.angles ) );
            fwpos = fw_center.origin + upvec * var_c3acb2f3955ba187;
            fw_center thread launch_fw( fwpos, var_2c7cb514b6c7f524, big_game_active, starlight_active, var_1d7359f489e35164, var_1d821a845ac20b8f, fw_center, attacker );
            thread function_2b2e4497e6ffdd0c( attacker, sweapon );
        }
    }
    else if ( var_11f8a7de0ef3eb81 )
    {
        fw_center thread launch_fw_fire_wheel( fw_center.origin, fw_center, attacker, var_bc697ed20567b32, starlight_active, var_1d7359f489e35164, sweapon );
    }
    else if ( ai_tier == 1 || ai_tier == 2 )
    {
        if ( farfalle_active )
        {
            var_2c7cb514b6c7f524 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_2c7cb514b6c7f524 ?? 5;
            fw_center thread launch_fw_farfalle( var_2c7cb514b6c7f524, starlight_active, var_1d7359f489e35164, fw_center, attacker, sweapon );
        }
        else if ( var_a468199485ca842f )
        {
            var_2c7cb514b6c7f524 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_2c7cb514b6c7f524 ?? 5;
            fw_center thread launch_fw_weeping_willow( var_2c7cb514b6c7f524, starlight_active, var_1d7359f489e35164, fw_center, attacker, sweapon );
        }
        else
        {
            var_c3acb2f3955ba187 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_c3acb2f3955ba187 ?? 100;
            var_2c7cb514b6c7f524 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_2c7cb514b6c7f524 ?? 5;
            upvec = vectornormalize( anglestoup( fw_center.angles ) );
            fwpos = fw_center.origin + upvec * var_c3acb2f3955ba187;
            fw_center thread launch_fw( fwpos, var_2c7cb514b6c7f524, big_game_active, starlight_active, var_1d7359f489e35164, var_1d821a845ac20b8f, fw_center, attacker, undefined, sweapon, var_b121bc46582c97be );
        }
    }
    
    if ( !big_game_active )
    {
        thread function_2b2e4497e6ffdd0c( attacker, sweapon );
    }
}

// Namespace fw_ammomod
// Params 2
// Checksum 0x220e0757, Offset: 0x1526
// Size: 0x106
function function_2b2e4497e6ffdd0c( attacker, sweapon )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.aicategory == "elite" )
    {
        var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"fw_big_game" ].var_28d12277bd509a2a ?? 1.5;
    }
    else
    {
        var_2b5d1dc7ccc7c88 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_35bf0db939ed38fb ?? 2;
    }
    
    waitframe();
    
    if ( isalive( self ) )
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        check_scoreevent( base_zombie_maxhealth * var_2b5d1dc7ccc7c88 );
        do_damage_set_flag( base_zombie_maxhealth * var_2b5d1dc7ccc7c88, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
    }
}

// Namespace fw_ammomod
// Params 0
// Checksum 0x950b298c, Offset: 0x1634
// Size: 0x40
function get_beam_tag()
{
    str_tag = "tag_origin";
    
    if ( self tagexists( "j_spineupper" ) )
    {
        str_tag = "j_spineupper";
    }
    else if ( self tagexists( "j_spine4" ) )
    {
        str_tag = "j_spine4";
    }
    
    return str_tag;
}

// Namespace fw_ammomod
// Params 7
// Checksum 0x18eedc13, Offset: 0x167d
// Size: 0x3a9
function function_3430515fe314df28( potential_enemies, fw_center, radius, var_3b88955ecb0e18cc, loopcount, attacker, sweapon )
{
    contents = trace::create_character_contents();
    
    if ( !isdefined( potential_enemies ) )
    {
        potential_enemies = [];
    }
    
    ignore_list = update_ignore_list( potential_enemies, [] );
    var_9b2ba4c48afd9aeb = 360 / var_3b88955ecb0e18cc;
    current_angle = 0;
    var_9bc3f0bfa712053a = level.zombie_augments[ #"fw_farfalle" ].var_3e89cf80636063b6 ?? 0.5;
    var_a86a699e221b3d61 = level.zombie_augments[ #"fw_farfalle" ].var_3bc7036d157551d ?? 75;
    
    while ( current_angle < 360 * loopcount )
    {
        potential_enemies = [];
        new_angle = anglestoforward( ( 0, fw_center.angles[ 1 ] + current_angle, 0 ) );
        end_point = fw_center.origin + new_angle * radius;
        var_4850f74fd4f47aef = physics_raycast( fw_center.origin, end_point, contents, ignore_list, 0, "physicsquery_all", 0, 1 );
        ignore_list = update_ignore_list( var_4850f74fd4f47aef, ignore_list );
        potential_enemies = arraycombine( potential_enemies, var_4850f74fd4f47aef );
        
        /#
            if ( getdvarint( @"hash_d783e7a13e686fd8", 0 ) )
            {
                var_d4618b70ea2e3eee = int( 3 / level.framedurationseconds );
                line( fw_center.origin, end_point, var_4850f74fd4f47aef.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, var_d4618b70ea2e3eee );
            }
        #/
        
        projectile_center = content_manager::spawn_script_model( self, "tag_fw_center", 0, 1 );
        projectile_center.origin = fw_center.origin;
        color = get_random_color();
        playfx( utility::getfx( "fx_burst" + color ), projectile_center.origin );
        playfxontag( utility::getfx( "fx_trail" + color ), projectile_center, "tag_origin" );
        projectile_center playsound( #"hash_bb0f5959b16c6e90" );
        projectile_center moveto( end_point, 0.75 );
        projectile_center thread function_bbd1a8c25ede3db1( 0.75, color );
        current_angle += var_9b2ba4c48afd9aeb;
        
        if ( !isdefined( projectile_center.origin ) || !isdefined( var_a86a699e221b3d61 ) || !isdefined( contents ) || !isdefined( ignore_list ) )
        {
            continue;
        }
        
        spherecasts = physics_querypoint( projectile_center.origin, var_a86a699e221b3d61, contents, ignore_list, "physicsquery_all" );
        potential_enemies = arraycombine( potential_enemies, spherecasts );
        color = get_random_color();
        playfx( utility::getfx( "fx_large" + color ), projectile_center.origin );
        
        foreach ( zombie in potential_enemies )
        {
            if ( isai( zombie[ "entity" ] ) && isalive( zombie[ "entity" ] ) && !zombie[ "entity" ] zombie_utils::function_bf1464d09f4e4b40() )
            {
                zombie[ "entity" ] thread function_a886ab23b7d2f151( attacker, sweapon );
            }
        }
        
        wait var_9bc3f0bfa712053a;
    }
}

// Namespace fw_ammomod
// Params 2
// Checksum 0x1a634162, Offset: 0x1a2e
// Size: 0x56
function function_bbd1a8c25ede3db1( time, color )
{
    wait time;
    
    if ( isdefined( self ) )
    {
        playfx( utility::getfx( "fx_burst" + color ), self.origin );
        playsoundatpos( self.origin, #"hash_a5c0495e78d77572" );
        self delete();
    }
}

// Namespace fw_ammomod
// Params 2
// Checksum 0x8fdd6f40, Offset: 0x1a8c
// Size: 0x9c
function update_ignore_list( traced_enemies, ignore_list )
{
    foreach ( result in traced_enemies )
    {
        if ( !isdefined( result[ "entity" ] ) )
        {
            continue;
        }
        
        ignore_list[ ignore_list.size ] = result[ "entity" ];
    }
    
    return ignore_list;
}

// Namespace fw_ammomod
// Params 6
// Checksum 0x55af87b1, Offset: 0x1b31
// Size: 0x342
function launch_fw_weeping_willow( var_114c8bd089ea949d, starlight_active, var_1d7359f489e35164, fw_center, attacker, sweapon )
{
    attacker endon( #"disconnect" );
    level endon( #"game_ended" );
    totalstars = var_114c8bd089ea949d;
    
    if ( starlight_active )
    {
        totalstars = var_114c8bd089ea949d + 2;
    }
    
    scriptable = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_376a9551acf0e492 ?? "ammomod_proc_fw";
    fw_center.fw_launch = spawnscriptable( scriptable, fw_center.origin );
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "fire" );
    }
    
    wait 1;
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "idle" );
        fw_center.fw_launch freescriptable();
    }
    
    var_dd75b96fa2381048 = level.zombie_augments[ #"fw_weeping_willow" ].var_47f40a8518d24850 ?? 500;
    duration = level.zombie_augments[ #"fw_weeping_willow" ].var_58ffc733ad2007de ?? 10;
    
    if ( var_1d7359f489e35164 )
    {
        var_8f53734bf423dd5f = level.zombie_augments[ #"fw_condensed_yield" ].var_2aa8e1eac74b0711 ?? 0.35;
        var_dd75b96fa2381048 *= 1 + var_8f53734bf423dd5f;
    }
    
    var_803ea8d304e3f41e = level.zombie_augments[ #"fw_weeping_willow" ].var_2ec208777cf59ced ?? 500;
    
    for ( i = 0; i < totalstars ; i++ )
    {
        rand_dist = randomfloatrange( 0, var_dd75b96fa2381048 );
        rand_dir = anglestoforward( ( 0, randomint( 360 ), 0 ) );
        point_picked = fw_center.origin + rand_dir * rand_dist;
        var_bc38bf8ebfecbcb = getclosestpointonnavmesh( point_picked );
        
        if ( isdefined( var_bc38bf8ebfecbcb ) )
        {
            upvec = vectornormalize( anglestoup( fw_center.angles ) );
            fwpos = fw_center.origin + upvec * 100;
            var_46e46e7e7783a5e4 = vectornormalize( fwpos - var_bc38bf8ebfecbcb );
            scalar = rand_dist / var_803ea8d304e3f41e * 0.001;
            var_46e46e7e7783a5e4 = var_46e46e7e7783a5e4 * scalar / 2;
            projectile_center = magicgrenademanual( "fw_ammomod_missile", fwpos, var_46e46e7e7783a5e4, 99999 );
            projectile_center playsound( #"hash_bb0f5959b16c6e90" );
            
            if ( isdefined( projectile_center ) )
            {
                new_color = get_random_color();
                playfxontag( utility::getfx( "fx_trail" + new_color ), projectile_center, "tag_origin" );
                wait randomintrange( 200, 800 ) * 0.001;
                projectile_center thread function_7257b0b3c78b0e86( attacker, var_bc38bf8ebfecbcb, duration, var_803ea8d304e3f41e, projectile_center, new_color, sweapon );
            }
        }
    }
}

// Namespace fw_ammomod
// Params 6
// Checksum 0xac5ed464, Offset: 0x1e7b
// Size: 0x1c9
function launch_fw_farfalle( var_114c8bd089ea949d, starlight_active, var_1d7359f489e35164, fw_center, attacker, sweapon )
{
    totalstars = var_114c8bd089ea949d;
    
    if ( starlight_active )
    {
        totalstars = var_114c8bd089ea949d + 2;
    }
    
    scriptable = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_376a9551acf0e492 ?? "ammomod_proc_fw";
    fw_center.fw_launch = spawnscriptable( scriptable, fw_center.origin );
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "fire" );
    }
    
    wait 1;
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "idle" );
        fw_center.fw_launch freescriptable();
    }
    
    var_dd75b96fa2381048 = level.zombie_augments[ #"fw_farfalle" ].var_85015e0213188388 ?? 500;
    
    if ( var_1d7359f489e35164 )
    {
        var_8f53734bf423dd5f = level.zombie_augments[ #"fw_condensed_yield" ].var_2aa8e1eac74b0711 ?? 0.35;
        var_dd75b96fa2381048 *= 1 + var_8f53734bf423dd5f;
    }
    
    var_2663409424874d7b = level.zombie_augments[ #"fw_farfalle" ].var_a7d1b6941bdf626a ?? 1;
    var_3e5df7c437647749 = [];
    function_3430515fe314df28( var_3e5df7c437647749, fw_center, var_dd75b96fa2381048, totalstars, var_2663409424874d7b, attacker, sweapon );
    self delete();
}

// Namespace fw_ammomod
// Params 7
// Checksum 0x6bc909dd, Offset: 0x204c
// Size: 0x229
function launch_fw_fire_wheel( position, fw_center, attacker, var_bc697ed20567b32, starlight_active, var_1d7359f489e35164, sweapon )
{
    var_d01d41646eb91b26 = level.zombie_augments[ #"fw_fire_wheel" ].var_f350bcb744d635c2 ?? 75;
    var_24af5809fd29fc7b = level.zombie_augments[ #"fw_fire_wheel" ].var_806e5c2bdd2c327 ?? 75;
    var_a9b958233852d5f1 = level.zombie_augments[ #"fw_fire_wheel" ].var_4ef362b43139e17d ?? 1;
    var_dc683137557d27ab = level.zombie_augments[ #"fw_fire_wheel" ].var_81492b47117fe3f7 ?? 360;
    
    if ( var_1d7359f489e35164 )
    {
        var_8f53734bf423dd5f = level.zombie_augments[ #"fw_condensed_yield" ].var_2aa8e1eac74b0711 ?? 0.35;
        var_d01d41646eb91b26 *= 1 + var_8f53734bf423dd5f;
    }
    
    scriptable = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_376a9551acf0e492 ?? "ammomod_proc_fw";
    fw_center.fw_launch = spawnscriptable( scriptable, fw_center.origin );
    var_9b2ba4c48afd9aeb = 180;
    
    if ( starlight_active )
    {
        var_9b2ba4c48afd9aeb = 120;
    }
    
    current_angle = 0;
    
    while ( current_angle < 360 )
    {
        new_angle = anglestoforward( ( 0, fw_center.angles[ 1 ] + current_angle, 0 ) );
        end_point = fw_center.origin + new_angle * var_24af5809fd29fc7b;
        fw_center thread function_bdaf400e763c3ca7( fw_center, end_point, var_d01d41646eb91b26, var_a9b958233852d5f1, var_dc683137557d27ab, attacker, var_bc697ed20567b32, sweapon );
        current_angle += var_9b2ba4c48afd9aeb;
        waitframe();
    }
    
    fw_center.fw_launch freescriptable();
    self delete();
}

// Namespace fw_ammomod
// Params 8
// Checksum 0xb8f7c100, Offset: 0x227d
// Size: 0x10d
function function_bdaf400e763c3ca7( fw_center, origin, var_d01d41646eb91b26, var_a9b958233852d5f1, var_dc683137557d27ab, attacker, var_bc697ed20567b32, sweapon )
{
    start_time = gettime();
    current_time = 0;
    wheel_center = content_manager::spawn_script_model( fw_center, "tag_fw_center", 0, 1 );
    wheel_center.origin = origin;
    wheel_center playsound( #"hash_fc2673ceef7f7afc" );
    color = get_random_color();
    playfxontag( utility::getfx( "fx_fire_wheel" + color ), wheel_center, "tag_origin" );
    
    /#
        iprintlnbold( color );
    #/
    
    thread function_a60243e252eeb48e( wheel_center, var_d01d41646eb91b26, var_a9b958233852d5f1, attacker, color, var_bc697ed20567b32, sweapon );
    
    while ( current_time < 500 )
    {
        current_time += utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        waitframe();
    }
    
    wheel_center delete();
}

// Namespace fw_ammomod
// Params 7
// Checksum 0x69a2d9b9, Offset: 0x2392
// Size: 0x28c
function function_a60243e252eeb48e( center, radius, damage, attacker, color, var_bc697ed20567b32, sweapon )
{
    while ( isdefined( center ) )
    {
        var_6f5c0bece5deb66e = getaiarrayinradius( center.origin, radius );
        
        foreach ( ai in var_6f5c0bece5deb66e )
        {
            if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, ai ) )
                {
                    continue;
                }
            }
            
            if ( isalive( ai ) && isdefined( ai.maxhealth ) && !ai zombie_utils::function_bf1464d09f4e4b40() )
            {
                ai_tier = ai ai_utility::get_ai_tier();
                round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( ai.origin );
                base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                
                if ( var_bc697ed20567b32 && ( ai_tier == 2 || ai_tier == 3 ) )
                {
                    var_b148295f865d019 = level.zombie_augments[ #"fw_big_bang" ].var_e8b0492496ff6ce6 ?? 1.5;
                    ai check_scoreevent( base_zombie_maxhealth * var_b148295f865d019 );
                    ai do_damage_set_flag( base_zombie_maxhealth * var_b148295f865d019, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
                    
                    if ( isdefined( level.ammomod_fw_throttle ) )
                    {
                        throttle::throttle_wait_in_queue( level.ammomod_fw_throttle, ai );
                    }
                    
                    continue;
                }
                
                ai check_scoreevent( base_zombie_maxhealth * damage );
                ai do_damage_set_flag( base_zombie_maxhealth * damage, center.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
                
                if ( isdefined( level.ammomod_fw_throttle ) )
                {
                    throttle::throttle_wait_in_queue( level.ammomod_fw_throttle, ai );
                }
            }
        }
        
        if ( isdefined( center ) )
        {
            center playsound( #"hash_4493ce1494ecc83d" );
        }
        
        wait 0.5;
    }
}

// Namespace fw_ammomod
// Params 11
// Checksum 0xf0847163, Offset: 0x2626
// Size: 0x4f2
function launch_fw( position, var_114c8bd089ea949d, big_game_active, starlight_active, var_1d7359f489e35164, var_1d821a845ac20b8f, fw_center, attacker, var_d12a9c0b221f1223 = 1, sweapon, var_b121bc46582c97be )
{
    totalstars = var_114c8bd089ea949d;
    
    if ( starlight_active )
    {
        totalstars = var_114c8bd089ea949d + 2;
    }
    
    scriptable = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_376a9551acf0e492 ?? "ammomod_proc_fw";
    fw_center.fw_launch = spawnscriptable( scriptable, fw_center.origin );
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "fire" );
    }
    
    wait 1;
    
    if ( isdefined( fw_center.fw_launch ) )
    {
        fw_center.fw_launch setscriptablepartstate( "fw", "idle" );
        fw_center.fw_launch freescriptable();
    }
    
    var_dd75b96fa2381048 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_dd75b96fa2381048 ?? 500;
    
    if ( var_1d7359f489e35164 )
    {
        var_8f53734bf423dd5f = level.zombie_augments[ #"fw_condensed_yield" ].var_2aa8e1eac74b0711 ?? 0.35;
        var_dd75b96fa2381048 *= 1 + var_8f53734bf423dd5f;
    }
    
    if ( var_b121bc46582c97be )
    {
        nearby_players = getplayersinradius( position, var_dd75b96fa2381048, undefined, undefined, undefined, team_utility::getotherteam( attacker.team ) );
    }
    
    var_3e5df7c437647749 = getaiarrayinradius( position, var_dd75b96fa2381048 );
    
    if ( isplayer( attacker ) )
    {
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            var_3e5df7c437647749 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_3e5df7c437647749, attacker );
        }
    }
    
    normal_array = [];
    special_array = [];
    elite_array = [];
    target_enemies = [];
    
    if ( big_game_active )
    {
        foreach ( zombie in var_3e5df7c437647749 )
        {
            if ( zombie.kfe_ignore )
            {
                continue;
            }
            
            ai_tier = zombie ai_utility::get_ai_tier();
            
            switch ( ai_tier )
            {
                case 1:
                    normal_array[ normal_array.size ] = zombie;
                    break;
                case 2:
                    special_array[ special_array.size ] = zombie;
                    break;
                case 3:
                    elite_array[ elite_array.size ] = zombie;
                    break;
                default:
                    break;
            }
        }
        
        normal_array = arrayrandomize( normal_array );
        special_array = arrayrandomize( special_array );
        elite_array = arrayrandomize( elite_array );
        var_3e5df7c437647749 = [];
        var_3e5df7c437647749 = arraycombine( var_3e5df7c437647749, elite_array );
        var_3e5df7c437647749 = arraycombine( var_3e5df7c437647749, special_array );
        var_3e5df7c437647749 = arraycombine( var_3e5df7c437647749, normal_array );
        target_enemies = utility::array_slice( var_3e5df7c437647749, 0, minint( totalstars, var_3e5df7c437647749.size ) );
    }
    else
    {
        foreach ( zombie in var_3e5df7c437647749 )
        {
            if ( zombie.kfe_ignore )
            {
                var_3e5df7c437647749 = arrayremove( var_3e5df7c437647749, zombie );
            }
        }
        
        target_enemies = var_3e5df7c437647749;
        
        if ( nearby_players.size > 0 )
        {
            target_enemies = arraycombine( target_enemies, nearby_players );
        }
        
        if ( totalstars < target_enemies.size )
        {
            target_enemies = utility::array_random_slice( target_enemies, minint( totalstars, target_enemies.size ) );
        }
    }
    
    fire_count_max = totalstars;
    var_9a2a8d1c672c7efa = 0;
    fire_target = 0;
    
    while ( var_9a2a8d1c672c7efa < fire_count_max )
    {
        if ( fire_target >= target_enemies.size )
        {
            fire_target = 0;
        }
        
        enemy = target_enemies[ fire_target ];
        
        if ( isalive( enemy ) && !enemy zombie_utils::function_bf1464d09f4e4b40() && enemy.team != attacker.team && !enemy.var_be5ccf6d16f6b59e )
        {
            enemy shoot_star( position, attacker, sweapon );
        }
        
        fire_target += 1;
        var_9a2a8d1c672c7efa += 1;
        waitframe();
    }
    
    if ( isdefined( self ) && var_d12a9c0b221f1223 )
    {
        self delete();
    }
}

// Namespace fw_ammomod
// Params 3
// Checksum 0xf2e209c8, Offset: 0x2b20
// Size: 0x3d4
function shoot_star( position, attacker, sweapon )
{
    var_bc697ed20567b32 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_big_bang" );
    projectile_center = content_manager::spawn_script_model( self, "tag_fw_center", 0, 1 );
    range = 25;
    x = randomfloatrange( position[ 0 ] - 25, position[ 0 ] + 25 );
    y = randomfloatrange( position[ 1 ] - 25, position[ 1 ] + 25 );
    z = randomfloatrange( position[ 2 ] - 25, position[ 2 ] + 25 );
    projectile_center.origin = ( x, y, z );
    color = get_random_color();
    playfx( utility::getfx( "fx_burst" + color ), projectile_center.origin );
    playfxontag( utility::getfx( "fx_trail" + color ), projectile_center, "tag_origin" );
    projectile_center playsound( #"hash_c58d0e9856257ce4" );
    
    /#
        iprintlnbold( color );
    #/
    
    if ( !isalive( self ) )
    {
        projectile_center delete();
        return;
    }
    
    delay = randomfloatrange( 0.25, 0.5 );
    projectile_center moveto( self gettagorigin( get_beam_tag() ), delay );
    wait delay;
    playsoundatpos( projectile_center.origin, #"hash_a5c0495e78d77572" );
    projectile_center delete();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    
    switch ( ai_tier )
    {
        case 1:
            playfxontag( utility::getfx( "fx_small" + color ), self, get_beam_tag() );
            break;
        case 2:
            playfxontag( utility::getfx( "fx_middle" + color ), self, get_beam_tag() );
            break;
        case 3:
            playfxontag( utility::getfx( "fx_large" + color ), self, get_beam_tag() );
            break;
        default:
            playfxontag( utility::getfx( "fx_small" + color ), self, get_beam_tag() );
            break;
    }
    
    var_c440588fd2fd2422 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_c440588fd2fd2422 ?? 1;
    
    if ( isalive( self ) && isdefined( self.maxhealth ) )
    {
        throttle::throttle_wait_in_queue( level.ammomod_fw_throttle, self );
        var_640e9b432132445f = 0;
        
        if ( ai_tier == 1 )
        {
            var_640e9b432132445f = 1;
            self.forceannihilate = 1;
        }
        
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( var_bc697ed20567b32 && ( ai_tier == 2 || ai_tier == 3 ) )
        {
            var_b148295f865d019 = level.zombie_augments[ #"fw_big_bang" ].var_e8b0492496ff6ce6 ?? 1.5;
            check_scoreevent( base_zombie_maxhealth * var_b148295f865d019 );
            do_damage_set_flag( base_zombie_maxhealth * var_b148295f865d019, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
        }
        else
        {
            check_scoreevent( base_zombie_maxhealth * var_c440588fd2fd2422 );
            do_damage_set_flag( base_zombie_maxhealth * var_c440588fd2fd2422, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
        }
        
        if ( isalive( self ) && var_640e9b432132445f )
        {
            self.forceannihilate = 0;
        }
    }
    
    wait 0.1;
}

// Namespace fw_ammomod
// Params 2
// Checksum 0xee2a1588, Offset: 0x2efc
// Size: 0x196
function function_a886ab23b7d2f151( attacker, sweapon )
{
    var_bc697ed20567b32 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_big_bang" );
    var_c440588fd2fd2422 = level.var_b7d9d7926154819d.ammomodbundles[ "fw_ammomod" ].var_c440588fd2fd2422 ?? 1;
    
    if ( !isalive( self ) || !isdefined( self.maxhealth ) )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.ammomod_fw_throttle, self );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( var_bc697ed20567b32 && ( ai_tier == 2 || ai_tier == 3 ) )
    {
        var_b148295f865d019 = level.zombie_augments[ #"fw_big_bang" ].var_e8b0492496ff6ce6 ?? 1.5;
        check_scoreevent( base_zombie_maxhealth * var_b148295f865d019 );
        do_damage_set_flag( base_zombie_maxhealth * var_b148295f865d019, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
        return;
    }
    
    check_scoreevent( base_zombie_maxhealth * var_c440588fd2fd2422 );
    do_damage_set_flag( base_zombie_maxhealth * var_c440588fd2fd2422, self.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
}

// Namespace fw_ammomod
// Params 7
// Checksum 0xad0dd8bd, Offset: 0x309a
// Size: 0x36e
function function_7257b0b3c78b0e86( attacker, var_bc38bf8ebfecbcb, duration, var_803ea8d304e3f41e, projectile_center, new_color, sweapon )
{
    attacker endon( #"disconnect" );
    level endon( #"game_ended" );
    var_c6debc020d389b3 = level.zombie_augments[ #"fw_weeping_willow" ].var_8095c61a054aa273 ?? 64;
    var_c0a05e25e481d580 = level.zombie_augments[ #"fw_weeping_willow" ].var_dec35977043a2ad7 ?? 0.2;
    var_bc697ed20567b32 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"fw_big_bang" );
    start_time = gettime();
    current_time = 0;
    
    if ( !projectile_center )
    {
        return;
    }
    
    playfxontag( utility::getfx( "fx_weeping_willow" + new_color ), projectile_center, "tag_origin" );
    projectile_center playloopsound( #"hash_419ed84aaea9f3a2" );
    
    while ( current_time < duration )
    {
        if ( !projectile_center )
        {
            return;
        }
        
        var_6f5c0bece5deb66e = getaiarrayinradius( projectile_center.origin, var_c6debc020d389b3 );
        
        foreach ( ai in var_6f5c0bece5deb66e )
        {
            if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, ai ) )
                {
                    continue;
                }
            }
            
            if ( isalive( ai ) && isdefined( ai.maxhealth ) && !ai zombie_utils::function_bf1464d09f4e4b40() )
            {
                ai_tier = ai ai_utility::get_ai_tier();
                round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( ai.origin );
                base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                
                if ( var_bc697ed20567b32 && ( ai_tier == 2 || ai_tier == 3 ) )
                {
                    var_b148295f865d019 = level.zombie_augments[ #"fw_big_bang" ].var_eb734ac0334b359d ?? 0.5;
                    ai check_scoreevent( base_zombie_maxhealth * var_b148295f865d019 );
                    ai do_damage_set_flag( base_zombie_maxhealth * var_b148295f865d019, projectile_center.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
                }
                else
                {
                    ai check_scoreevent( base_zombie_maxhealth * var_c0a05e25e481d580 );
                    ai do_damage_set_flag( base_zombie_maxhealth * var_c0a05e25e481d580, projectile_center.origin, attacker, attacker, "MOD_UNKNOWN", sweapon, undefined, undefined, 1610678272 );
                }
                
                if ( isdefined( level.ammomod_fw_throttle ) )
                {
                    throttle::throttle_wait_in_queue( level.ammomod_fw_throttle, ai );
                }
            }
        }
        
        current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        wait var_803ea8d304e3f41e * 0.001;
    }
    
    if ( projectile_center )
    {
        projectile_center delete();
    }
}

// Namespace fw_ammomod
// Params 9, eflags: 0x4
// Checksum 0x884df986, Offset: 0x3410
// Size: 0x90
function private do_damage_set_flag( damage, position, attacker, inflictor, var_9eed6a3309bc05d4, weapon, hitloc, distance, dflags )
{
    utility::ent_flag_set( "fw_damage" );
    
    if ( isdefined( position ) )
    {
        self dodamage( damage, position, attacker, inflictor, var_9eed6a3309bc05d4, weapon, "torso_upper", distance, dflags );
    }
    
    if ( isalive( self ) )
    {
        utility::ent_flag_clear( "fw_damage" );
    }
}

// Namespace fw_ammomod
// Params 1, eflags: 0x4
// Checksum 0x580407d6, Offset: 0x34a8
// Size: 0xfa
function private function_9b0055fdba809108( params )
{
    if ( isagent( self ) && isplayer( params.eattacker ) && utility::ent_flag( "fw_damage" ) )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            params.eattacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "fw_ammomod" );
        }
        
        if ( isdefined( params.eattacker.rapidkill_data ) )
        {
            if ( isdefined( params.eattacker.rapidkill_data[ "fw_ammomod" ] ) && params.eattacker.rapidkill_data[ "fw_ammomod" ].rapidkill_count === 5 )
            {
                params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_poppingoff" );
            }
        }
    }
}

/#

    // Namespace fw_ammomod
    // Params 0
    // Checksum 0x973a1d70, Offset: 0x35aa
    // Size: 0xa0, Type: dev
    function function_8f110e32779c195b()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x2f>" );
        }
    }

    // Namespace fw_ammomod
    // Params 0
    // Checksum 0x1a0c7e34, Offset: 0x3652
    // Size: 0x2f, Type: dev
    function setup_fw_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x40>" );
        devgui::add_devgui_func( "<dev string:x51>", "<dev string:x59>", &function_8f110e32779c195b, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
