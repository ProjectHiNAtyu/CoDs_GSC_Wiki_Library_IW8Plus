// scripts\mp\common\weapons\weap_plasmagun.gsc  (hash_436886a63de79372.gscc) (size: 13020 Bytes / 0x32dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd3fc3ce (3175072718)
// size ...... 13020 (0x32dc)
// includes .. 9   (offset: 0x2ed8)
// strings ... 53  (offset: 0x2f20)
// dev strs .. 3   (offset: 0x32b8)
// exports ... 33  (offset: 0x1ddc)
// cseg ...... 0x4bc + 0x1920 (0x1ddc)
// imports ... 95  (offset: 0x2304)
// animtree1 . 0   (offset: 0x32dc)
// animtree2 . 0   (offset: 0x32dc)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace ww_plasmagun;

// Namespace ww_plasmagun
// Params 0, eflags: 0x5
// Checksum 0x8201ce2f, Offset: 0x4da
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"weap_plasmagun", undefined, undefined, &init );
}

// Namespace ww_plasmagun
// Params 0
// Checksum 0xb9db96f6, Offset: 0x4fb
// Size: 0x119
function init()
{
    level callback::add( #"player_weapon_change", &function_f0665845595f415b );
    level._effect[ "plasmagun_trail" ] = [];
    level._effect[ "plasmagun_trail_pap" ] = [];
    
    for ( i = 0; i < 6 ; i++ )
    {
        level._effect[ "plasmagun_trail" ][ i ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_zmb_dark_aether_plasma_hit_lvl" + i );
        level._effect[ "plasmagun_trail_pap" ][ i ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_zmb_dark_aether_plasma_hit_pap_lvl" + i );
    }
    
    level._effect[ "plasmagun_air_launch_explosion" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_weapons_zmb_dark_aether_plasma_fiy_loop_camera_1p" );
    level callback::add( "on_zombie_ai_killed", &function_174f9ecb70db7898 );
    plasmagun_weapon = makeweapon( "jup_la_plasmagun_mp" );
    assert( isdefined( plasmagun_weapon.weaponcustomsettings ), "<dev string:x24>" );
    level.var_be039f8328019989 = plasmagun_weapon.weaponcustomsettings;
    level.plasmagun_damage_throttle = throttle::throttle_initialize( "plasmagun_damage", 5, 0.05 );
}

// Namespace ww_plasmagun
// Params 1
// Checksum 0x56c57032, Offset: 0x61c
// Size: 0x10c
function function_f0665845595f415b( params )
{
    if ( !isdefined( params.weapon ) || isbot( self ) )
    {
        return;
    }
    
    if ( params.weapon.basename == "jup_la_plasmagun_mp" )
    {
        thread function_88a0612caea789f4();
        thread function_3106333c385f0699();
        thread function_ec92016700deafa2( params.weapon );
        thread function_90ab03c268d0f833();
        thread plasmagun_ammo_regen( params.weapon );
    }
    else
    {
        self notify( #"stop_plasmagun_watch_enter_charge" );
        self notify( #"stop_plasmagun_watch_fire_notify" );
        self notify( #"stop_monitor_plasmagun_vfx_state" );
        self notify( #"stop_plasmagun_watch_charge_overtime" );
        utility::function_7c10ea82c1e305b8( "PlasmaLauncherAmbientVFX", "off" );
        self.var_e6a1d692cc44e815 = 0;
    }
    
    if ( hasomnvar( "ui_plasma_launcher_charge_time" ) )
    {
        var_dd6388d314818e53 = plasmagun_get_pap_level();
        charge_time = var_dd6388d314818e53 ? 2 : 3;
        self setclientomnvar( "ui_plasma_launcher_charge_time", charge_time );
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x9919df43, Offset: 0x730
// Size: 0xa2
function private function_88a0612caea789f4()
{
    self endon( #"death" );
    self notify( #"stop_plasmagun_watch_enter_charge" );
    self endon( #"stop_plasmagun_watch_enter_charge" );
    
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", param );
        
        switch ( param )
        {
            case 0:
                function_b2c83d2091cfe711();
                break;
            case 1:
                function_f6d1932414e98f6c();
                break;
            case 2:
                function_dbc1e4519f00dc1();
                break;
            default:
                break;
        }
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0xcb22fab8, Offset: 0x7da
// Size: 0xb6
function private function_3106333c385f0699()
{
    self endon( #"death" );
    self notify( #"stop_plasmagun_watch_fire_notify" );
    self endon( #"stop_plasmagun_watch_fire_notify" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( isdefined( objweapon ) && objweapon.basename == "jup_la_plasmagun_mp" )
        {
            if ( self.var_307cf94605682d86 && isdefined( self.var_745ad09a6cb6ee01 ) )
            {
                thread plasmagun_fire( objweapon );
            }
            else if ( self.var_6b7516b1b93ba687 && isdefined( self.var_c43ce0bcf98b9936 ) )
            {
                plasmagun_launch( objweapon );
            }
            
            self.var_9351bccb7fe0e1b3 = 1;
        }
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x867ae950, Offset: 0x898
// Size: 0x100
function private function_b2c83d2091cfe711()
{
    val::set( "plasma_charge", "mantle", 0 );
    val::set( "plasma_charge", "sprint", 0 );
    val::set( "plasma_charge", "equipment_primary", 0 );
    val::set( "plasma_charge", "equipment_secondary", 0 );
    val::set( "plasma_charge", "gesture", 0 );
    paped = 0;
    state_name = "fire_charge";
    
    if ( plasmagun_get_pap_level() > 0 )
    {
        paped = 1;
        state_name = "fire_charge_pap";
    }
    
    thread function_5e8584c85bdb696f( state_name, paped );
    
    if ( hasomnvar( "ui_plasma_launcher_light_color" ) )
    {
        self setclientomnvar( "ui_plasma_launcher_light_color", 0 );
    }
    
    utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", state_name );
    self.var_745ad09a6cb6ee01 = gettime();
    self.var_307cf94605682d86 = 1;
    self.var_c43ce0bcf98b9936 = undefined;
    self.var_6b7516b1b93ba687 = 0;
    self.var_9351bccb7fe0e1b3 = 0;
    self notify( #"hash_a6991f682f9f5cf9" );
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x992c401d, Offset: 0x9a0
// Size: 0x101
function private function_f6d1932414e98f6c()
{
    val::set( "plasma_charge", "mantle", 0 );
    val::set( "plasma_charge", "sprint", 0 );
    val::set( "plasma_charge", "equipment_primary", 0 );
    val::set( "plasma_charge", "equipment_secondary", 0 );
    val::set( "plasma_charge", "gesture", 0 );
    paped = 0;
    state_name = "launch_charge";
    
    if ( plasmagun_get_pap_level() > 0 )
    {
        paped = 1;
        state_name = "launch_charge_pap";
    }
    
    thread function_5e8584c85bdb696f( state_name, paped );
    
    if ( hasomnvar( "ui_plasma_launcher_light_color" ) )
    {
        self setclientomnvar( "ui_plasma_launcher_light_color", 1 );
    }
    
    utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", state_name );
    self.var_745ad09a6cb6ee01 = undefined;
    self.var_307cf94605682d86 = 0;
    self.var_c43ce0bcf98b9936 = gettime();
    self.var_6b7516b1b93ba687 = 1;
    self.var_9351bccb7fe0e1b3 = 0;
    self notify( #"hash_a6991f682f9f5cf9" );
}

// Namespace ww_plasmagun
// Params 2, eflags: 0x4
// Checksum 0x7ca9ec4a, Offset: 0xaa9
// Size: 0xac
function private function_5e8584c85bdb696f( state_name, paped )
{
    self endon( #"death" );
    self notify( #"stop_plasmagun_watch_charge_overtime" );
    self endon( #"stop_plasmagun_watch_charge_overtime" );
    wait_time = 3;
    
    if ( paped )
    {
        wait_time = 2;
    }
    
    msg = utility::waittill_any_timeout( wait_time + 0.1, "skydive_deployparachute" );
    
    if ( msg == "skydive_deployparachute" )
    {
        function_dbc1e4519f00dc1();
    }
    
    if ( utility::function_9f2c41c1dcc8c94( "PlasmaLauncherStates", state_name ) )
    {
        utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "off" );
        thread plasmagun_ammo_regen( self getcurrentweapon() );
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0xc97e5753, Offset: 0xb5d
// Size: 0xcb
function private function_dbc1e4519f00dc1()
{
    val::set( "plasma_charge", "mantle", 1 );
    val::set( "plasma_charge", "sprint", 1 );
    val::set( "plasma_charge", "equipment_primary", 1 );
    val::set( "plasma_charge", "equipment_secondary", 1 );
    val::set( "plasma_charge", "gesture", 1 );
    
    if ( self.var_9351bccb7fe0e1b3 )
    {
        return;
    }
    
    if ( hasomnvar( "ui_plasma_launcher_light_color" ) )
    {
        self setclientomnvar( "ui_plasma_launcher_light_color", 0 );
    }
    
    utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "off" );
    self.var_745ad09a6cb6ee01 = undefined;
    self.var_307cf94605682d86 = 0;
    self.var_c43ce0bcf98b9936 = undefined;
    self.var_6b7516b1b93ba687 = 0;
    thread plasmagun_ammo_regen( self getcurrentweapon() );
}

// Namespace ww_plasmagun
// Params 2, eflags: 0x4
// Checksum 0x1a6ba19c, Offset: 0xc30
// Size: 0x84
function private function_c6c6e2dcc957f1a1( var_9d057753e642107c, is_fullcharge )
{
    if ( var_9d057753e642107c )
    {
        if ( is_fullcharge )
        {
            utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "weapon_launch_fired_full" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "weapon_launch_fired" );
        }
    }
    else if ( is_fullcharge )
    {
        utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "weapon_fired_full" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "weapon_fired" );
    }
    
    thread function_9c6c5eaa9653213a();
    thread plasmagun_ammo_regen( self getcurrentweapon() );
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x24215566, Offset: 0xcbc
// Size: 0x20
function private function_9c6c5eaa9653213a()
{
    self endon( #"death" );
    waitframe();
    utility::function_7c10ea82c1e305b8( "PlasmaLauncherStates", "off" );
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0xebe9de8e, Offset: 0xce4
// Size: 0x86
function private function_90ab03c268d0f833()
{
    self endon( #"death" );
    self endon( #"stop_monitor_plasmagun_vfx_state" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "weapon_switch_started", "skydive_deployparachute", "weapon_switch_canceled", "offhand_end", "skydive_end" );
        
        if ( !isdefined( result ) )
        {
            continue;
        }
        
        if ( result == "weapon_switch_started" || result == "skydive_deployparachute" )
        {
            self.var_e6a1d692cc44e815 = 1;
            continue;
        }
        
        self.var_e6a1d692cc44e815 = 0;
    }
}

// Namespace ww_plasmagun
// Params 1, eflags: 0x4
// Checksum 0x68938572, Offset: 0xd72
// Size: 0xc1
function private function_ec92016700deafa2( current_weapon )
{
    self endon( #"death" );
    self notify( #"stop_monitor_plasmagun_vfx_state" );
    self endon( #"stop_monitor_plasmagun_vfx_state" );
    last_fx_state = "off";
    
    if ( !self.owned_plasmagun )
    {
        wait 1;
        self.owned_plasmagun = 1;
    }
    
    while ( true )
    {
        if ( self.var_e6a1d692cc44e815 )
        {
            fx_state = "off";
        }
        else
        {
            fx_state = "on";
        }
        
        if ( fx_state != last_fx_state )
        {
            if ( fx_state == "on" && plasmagun_get_pap_level() > 0 )
            {
                fx_state = "on_pap";
            }
            
            utility::function_7c10ea82c1e305b8( "PlasmaLauncherAmbientVFX", fx_state );
            last_fx_state = fx_state;
        }
        
        waitframe();
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x31171c8f, Offset: 0xe3b
// Size: 0x4e
function private plasmagun_get_pap_level()
{
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) )
    {
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon.basename != "jup_la_plasmagun_mp" )
        {
            return 0;
        }
        
        return namespace_9d8e359c3b1041e5::function_1d4087075103b248( current_weapon );
    }
    
    return 0;
}

// Namespace ww_plasmagun
// Params 3, eflags: 0x4
// Checksum 0x77db9314, Offset: 0xe92
// Size: 0xa3
function private function_1c133666017faf5f( is_paped, charge_time, var_f02dcbbb028482e0 )
{
    plasmagun_charge_level = 0;
    var_f16242e2bbeeee40 = is_paped ? 2 : 3;
    
    if ( hasomnvar( "ui_plasma_launcher_charge_time" ) )
    {
        self setclientomnvar( "ui_plasma_launcher_charge_time", var_f16242e2bbeeee40 );
    }
    
    if ( charge_time >= var_f16242e2bbeeee40 )
    {
        plasmagun_charge_level = 5;
    }
    else
    {
        plasmagun_charge_level = int( charge_time / var_f16242e2bbeeee40 * 5 );
    }
    
    plasmagun_charge_level = max( plasmagun_charge_level, 1 );
    current_ammo = self getweaponammoclip( var_f02dcbbb028482e0 );
    plasmagun_charge_level = int( min( plasmagun_charge_level, current_ammo + 1 ) );
    return plasmagun_charge_level;
}

// Namespace ww_plasmagun
// Params 3, eflags: 0x4
// Checksum 0x7473b9db, Offset: 0xf3e
// Size: 0x5d
function private function_eccaaa5f62d0d940( var_5454f57201136c19, ai_target, pap_level )
{
    if ( isdefined( ai_target ) && ai_target vehicle::is_vehicle() )
    {
        var_5454f57201136c19 = 100;
    }
    
    var_299c4d5ce04470ab = 1;
    
    if ( pap_level > 0 )
    {
        var_299c4d5ce04470ab = 2 + 0.5 * ( pap_level - 1 );
    }
    
    return var_5454f57201136c19 * var_299c4d5ce04470ab;
}

// Namespace ww_plasmagun
// Params 1, eflags: 0x4
// Checksum 0xab2cd259, Offset: 0xfa4
// Size: 0x37a
function private plasmagun_fire( objweapon )
{
    self endon( #"death" );
    is_paped = 0;
    plasmagun_pap_level = plasmagun_get_pap_level();
    
    if ( plasmagun_pap_level > 0 )
    {
        is_paped = 1;
    }
    
    time_now = gettime();
    var_6fcdacea48315f1c = utility::function_6f5d2e1f1ff70482( time_now - self.var_745ad09a6cb6ee01 );
    is_fullcharge = 0;
    var_c98c890d58d17ee5 = function_1c133666017faf5f( is_paped, var_6fcdacea48315f1c, objweapon );
    function_8203fdeb5d1005ec( objweapon, var_c98c890d58d17ee5 );
    
    if ( var_c98c890d58d17ee5 == 5 )
    {
        is_fullcharge = 1;
    }
    
    function_c6c6e2dcc957f1a1( 0, is_fullcharge );
    self.var_745ad09a6cb6ee01 = undefined;
    
    /#
        plasmagun_debug_print( "<dev string:x54>" + var_c98c890d58d17ee5 );
    #/
    
    var_150a7f0b79ade8b5 = level.var_be039f8328019989.var_e6b5e8f262e35ca8 + level.var_be039f8328019989.var_fc66915816e331ab * var_c98c890d58d17ee5;
    plasma_diameter = level.var_be039f8328019989.var_9e663c93d9a5f8e7 + level.var_be039f8328019989.var_f69b0bac0d645ef4 * var_c98c890d58d17ee5;
    var_3f679de523f08e73 = plasma_diameter / 2;
    start_point = self getvieworigin();
    player_angles = self getplayerangles();
    var_aa89fb2d0a564d2a = vectornormalize( anglestoforward( player_angles ) );
    var_89914d45229544be = self gettagorigin( "tag_flash" );
    end_point = start_point + var_aa89fb2d0a564d2a * var_150a7f0b79ade8b5;
    mid_point = ( start_point + end_point ) / 2;
    beam_start_point = function_a0b47157701061ca( start_point, player_angles );
    var_6dec1a3b58f9fea6 = level.var_be039f8328019989.var_396030c91ac2c0e5 + level.var_be039f8328019989.var_176e6a3135a662d2 * var_c98c890d58d17ee5;
    contentoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0 );
    ignoreents = [ self ];
    trace = trace::ray_trace( start_point, end_point, ignoreents, contentoverride );
    end_point = trace[ "position" ];
    plasma_vfx_ent = utility::spawn_tag_origin( beam_start_point, vectortoangles( vectornormalize( end_point - beam_start_point ) ) );
    plasma_vfx_ent show();
    plasma_vfx_ent function_5eba01d3b844fcaf( trace[ "position" ], var_c98c890d58d17ee5, 0.3, plasmagun_pap_level );
    var_25f086ddb9573780 = utility::spawn_tag_origin( beam_start_point, vectortoangles( vectornormalize( end_point - beam_start_point ) ) );
    var_25f086ddb9573780 thread function_7ff2eaeb0137682b( var_c98c890d58d17ee5, var_6dec1a3b58f9fea6 );
    
    /#
        function_7e2e6ec5418720a1( start_point, end_point, var_3f679de523f08e73, ( 0, 1, 0 ), 0, 240 );
    #/
    
    ai_targets = function_ee25087f64986e9e( start_point, end_point, mid_point, var_150a7f0b79ade8b5, var_3f679de523f08e73, var_aa89fb2d0a564d2a );
    
    foreach ( ai_target in ai_targets )
    {
        ai_target function_fdbcb9086029bbb( is_paped );
        ai_target thread function_2e21a141cc88c345( function_eccaaa5f62d0d940( level.var_be039f8328019989.plasmaimpactdamage, ai_target, plasmagun_pap_level ), self, objweapon );
    }
    
    thread function_e2f48fdfccbf1a2c( objweapon, var_6dec1a3b58f9fea6, plasmagun_pap_level, start_point, end_point, mid_point, var_150a7f0b79ade8b5, var_3f679de523f08e73, var_aa89fb2d0a564d2a );
}

// Namespace ww_plasmagun
// Params 9
// Checksum 0xa17ff1f9, Offset: 0x1326
// Size: 0x12e
function function_e2f48fdfccbf1a2c( objweapon, var_6dec1a3b58f9fea6, plasmagun_pap_level, start_point, end_point, mid_point, var_150a7f0b79ade8b5, var_3f679de523f08e73, var_aa89fb2d0a564d2a )
{
    self endon( #"death" );
    var_ecb7db0d6f9fd0c9 = 0;
    
    while ( var_ecb7db0d6f9fd0c9 < var_6dec1a3b58f9fea6 )
    {
        wait 0.5;
        ai_targets = function_ee25087f64986e9e( start_point, end_point, mid_point, var_150a7f0b79ade8b5, var_3f679de523f08e73, var_aa89fb2d0a564d2a );
        
        foreach ( ai_target in ai_targets )
        {
            ai_target thread function_2e21a141cc88c345( function_eccaaa5f62d0d940( level.var_be039f8328019989.var_c88d6be3a8122c21, ai_target, plasmagun_pap_level ), self, objweapon );
        }
        
        var_ecb7db0d6f9fd0c9 += 0.5;
    }
}

// Namespace ww_plasmagun
// Params 3
// Checksum 0x35641ea, Offset: 0x145c
// Size: 0x5d
function function_2e21a141cc88c345( var_e8ac27af5d079440, player, objweapon )
{
    self endon( #"death" );
    throttle::throttle_wait_in_queue( level.plasmagun_damage_throttle, self );
    self dodamage( var_e8ac27af5d079440, player.origin, player, undefined, "MOD_UNKNOWN", objweapon, "upper_torso" );
}

// Namespace ww_plasmagun
// Params 1
// Checksum 0x3eaf8184, Offset: 0x14c1
// Size: 0x63
function function_fdbcb9086029bbb( is_paped )
{
    var_121ffc335c173108 = "plasma_hit_vfx";
    
    if ( is_paped )
    {
        var_121ffc335c173108 += "_pap";
    }
    
    if ( self.aicategory == "normal" && randomint( 10 ) < 5 )
    {
        var_121ffc335c173108 += "a";
    }
    
    utility::function_7c10ea82c1e305b8( "plasma_hit", var_121ffc335c173108 );
}

// Namespace ww_plasmagun
// Params 2
// Checksum 0xfabd9e9e, Offset: 0x152c
// Size: 0x7b
function function_a0b47157701061ca( var_c085dbb8ff070c53, player_angles )
{
    offset_foward = getdvarint( @"hash_cb8683d34d92d83", 100 );
    var_5daf71431dd688bf = getdvarint( @"scr_plasma_offset_left", -2 );
    offset_up = getdvarint( @"scr_plasma_offset_up", -3 );
    target_position = rotatevector( ( offset_foward, var_5daf71431dd688bf, offset_up ), player_angles );
    return var_c085dbb8ff070c53 + target_position;
}

// Namespace ww_plasmagun
// Params 4
// Checksum 0x5489045f, Offset: 0x15b0
// Size: 0xc0
function function_5eba01d3b844fcaf( end_point, var_aacfab76370f55b3, var_d524330523e6df2d, pap_level )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( pap_level > 0 )
    {
        playfxontag( level._effect[ "plasmagun_trail_pap" ][ var_aacfab76370f55b3 ], self, "tag_origin" );
    }
    else
    {
        playfxontag( level._effect[ "plasmagun_trail" ][ var_aacfab76370f55b3 ], self, "tag_origin" );
    }
    
    thread utility::play_loop_sound_on_entity( "proj_plasmagun_lp" );
    self moveto( end_point, var_d524330523e6df2d );
    wait var_d524330523e6df2d;
    utility::stop_loop_sound_on_entity( "proj_plasmagun_lp" );
    playsoundatpos( self.origin, "proj_plasmagun_lp_end" );
    self delete();
}

// Namespace ww_plasmagun
// Params 2
// Checksum 0xc5b0ff4e, Offset: 0x1678
// Size: 0x61
function function_7ff2eaeb0137682b( var_aacfab76370f55b3, var_92cbbb61b386ebb0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    thread utility::play_loop_sound_on_entity( "proj_plasmagun_lp" );
    wait var_92cbbb61b386ebb0;
    utility::stop_loop_sound_on_entity( "proj_plasmagun_lp" );
    playsoundatpos( self.origin, "proj_plasmagun_lp_end" );
    self delete();
}

// Namespace ww_plasmagun
// Params 6
// Checksum 0x53891e35, Offset: 0x16e1
// Size: 0x1e7
function function_ee25087f64986e9e( start_point, end_point, mid_point, var_150a7f0b79ade8b5, var_3f679de523f08e73, var_aa89fb2d0a564d2a )
{
    plasma_radius_squared = var_3f679de523f08e73 * var_3f679de523f08e73;
    var_f3c16aa9bfd121ad = ( var_3f679de523f08e73 + 30 ) * ( var_3f679de523f08e73 + 30 );
    potential_ai_targets = getaiarrayinradius( mid_point, var_150a7f0b79ade8b5 / 2 );
    ai_targets = [];
    
    foreach ( potential_ai_target in potential_ai_targets )
    {
        trace_pos = potential_ai_target getcentroid();
        
        /#
            plasmagun_debug_sphere( trace_pos, 20, ( 1, 0, 0 ), 0, 240 );
        #/
        
        if ( math::pointvscylinder( trace_pos, plasma_radius_squared, var_150a7f0b79ade8b5, start_point, var_aa89fb2d0a564d2a ) )
        {
            ai_targets = arraycombineunique( ai_targets, [ potential_ai_target ] );
        }
    }
    
    var_798ed7937cd81225 = getentarrayinradius( "script_vehicle", "classname", mid_point, var_150a7f0b79ade8b5 / 2 + 30 );
    
    foreach ( var_8de261906770b234 in var_798ed7937cd81225 )
    {
        trace_pos = var_8de261906770b234 getcentroid();
        
        if ( math::pointvscylinder( trace_pos, var_f3c16aa9bfd121ad, var_150a7f0b79ade8b5 + 30, start_point, var_aa89fb2d0a564d2a ) )
        {
            ai_targets = arraycombineunique( ai_targets, [ var_8de261906770b234 ] );
        }
    }
    
    return ai_targets;
}

// Namespace ww_plasmagun
// Params 1, eflags: 0x4
// Checksum 0xf2874c23, Offset: 0x18d1
// Size: 0x1d3
function private plasmagun_launch( objweapon )
{
    is_paped = 0;
    plasmagun_pap_level = plasmagun_get_pap_level();
    time_now = gettime();
    var_549211284a490d9b = utility::function_6f5d2e1f1ff70482( time_now - self.var_c43ce0bcf98b9936 );
    
    if ( plasmagun_pap_level > 0 )
    {
        is_paped = 1;
    }
    
    is_fullcharge = 0;
    var_717765cf4b84b198 = function_1c133666017faf5f( is_paped, var_549211284a490d9b, objweapon );
    function_8203fdeb5d1005ec( objweapon, var_717765cf4b84b198 );
    
    if ( var_717765cf4b84b198 == 5 )
    {
        is_fullcharge = 1;
    }
    
    function_c6c6e2dcc957f1a1( 1, is_fullcharge );
    self.var_c43ce0bcf98b9936 = undefined;
    
    /#
        plasmagun_debug_print( "<dev string:x66>" + var_717765cf4b84b198 );
    #/
    
    if ( var_717765cf4b84b198 > 0 )
    {
        self radiusdamage( self.origin, level.var_be039f8328019989.var_59f582cab1f5c02c, level.var_be039f8328019989.var_1c8fcfe38a390af6 * var_717765cf4b84b198, level.var_be039f8328019989.var_1c8fcfe38a390af6 * var_717765cf4b84b198, self, "MOD_EXPLOSIVE", "jup_la_plasmagun_mp" );
        explosion_vfx_ent = utility::spawn_tag_origin( self.origin, ( 0, 0, 0 ) );
        explosion_vfx_ent show();
        playfxontag( level._effect[ "plasmagun_air_launch_explosion" ], explosion_vfx_ent, "tag_origin" );
        explosion_vfx_ent utility::delaycall( 2, &delete );
        
        if ( function_d909b2915484b0f7() )
        {
            neworigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 20 );
            self setorigin( neworigin );
            self setvelocity( ( 1, 1, level.var_be039f8328019989.var_1e65ff5d1a797d25 * var_717765cf4b84b198 ) );
        }
    }
}

// Namespace ww_plasmagun
// Params 0, eflags: 0x4
// Checksum 0x7071a29d, Offset: 0x1aac
// Size: 0x73, Type: bool
function private function_d909b2915484b0f7()
{
    contentoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0 );
    ignoreents = [ self ];
    trace = trace::ray_trace( self.origin, self.origin + ( 0, 0, 80 ), ignoreents, contentoverride );
    
    if ( trace[ "fraction" ] < 0.99 )
    {
        return false;
    }
    
    return true;
}

// Namespace ww_plasmagun
// Params 1, eflags: 0x4
// Checksum 0xc49be35, Offset: 0x1b28
// Size: 0xb2
function private function_174f9ecb70db7898( params )
{
    if ( isdefined( params.objweapon ) && params.objweapon.basename == "jup_la_plasmagun_mp" )
    {
        var_951c89546ec50477 = 0;
        
        if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.eattacker ) )
        {
            var_951c89546ec50477 = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.objweapon );
        }
        
        if ( var_951c89546ec50477 > 0 )
        {
            utility::ent_flag_set( "plasma_death_pap" );
            return;
        }
        
        utility::ent_flag_set( "dissolve_purple" );
    }
}

// Namespace ww_plasmagun
// Params 1, eflags: 0x4
// Checksum 0x5fc5c616, Offset: 0x1be2
// Size: 0xb5
function private plasmagun_ammo_regen( plasmagun_weapon )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_a6991f682f9f5cf9" );
    self endon( #"hash_a6991f682f9f5cf9" );
    
    if ( !isdefined( plasmagun_weapon ) || plasmagun_weapon.basename != "jup_la_plasmagun_mp" )
    {
        return;
    }
    
    if ( !isdefined( plasmagun_weapon ) || plasmagun_weapon.basename != "jup_la_plasmagun_mp" )
    {
        return;
    }
    
    wait 2;
    clip_size = weaponclipsize( plasmagun_weapon );
    
    while ( true )
    {
        wait 0.6;
        current_ammo = self getweaponammoclip( plasmagun_weapon );
        
        if ( current_ammo >= clip_size )
        {
            break;
        }
        
        self setweaponammoclip( plasmagun_weapon, current_ammo + 1 );
    }
}

// Namespace ww_plasmagun
// Params 2, eflags: 0x4
// Checksum 0x2e7b6576, Offset: 0x1c9f
// Size: 0x4b
function private function_8203fdeb5d1005ec( plasmagun_weapon, var_aacfab76370f55b3 )
{
    current_ammo = self getweaponammoclip( plasmagun_weapon );
    new_ammo = int( max( 0, current_ammo - var_aacfab76370f55b3 + 1 ) );
    self setweaponammoclip( plasmagun_weapon, new_ammo );
}

/#

    // Namespace ww_plasmagun
    // Params 1, eflags: 0x4
    // Checksum 0xcadfa8ff, Offset: 0x1cf2
    // Size: 0x2a, Type: dev
    function private plasmagun_debug_print( string )
    {
        if ( getdvarint( @"scr_plasmagun_debug", 0 ) == 0 )
        {
            return;
        }
        
        iprintlnbold( string );
    }

    // Namespace ww_plasmagun
    // Params 6, eflags: 0x4
    // Checksum 0xbe2078c5, Offset: 0x1d24
    // Size: 0x5d, Type: dev
    function private function_7e2e6ec5418720a1( start, end, radius, color, depthtest, duration )
    {
        if ( getdvarint( @"scr_plasmagun_debug", 0 ) == 0 )
        {
            return;
        }
        
        cylinder( start, end, radius, color, depthtest, duration );
    }

    // Namespace ww_plasmagun
    // Params 5, eflags: 0x4
    // Checksum 0xd89fb779, Offset: 0x1d89
    // Size: 0x53, Type: dev
    function private plasmagun_debug_sphere( origin, radius, color, depthtest, duration )
    {
        if ( getdvarint( @"scr_plasmagun_debug", 0 ) == 0 )
        {
            return;
        }
        
        sphere( origin, radius, color, depthtest, duration );
    }

#/
