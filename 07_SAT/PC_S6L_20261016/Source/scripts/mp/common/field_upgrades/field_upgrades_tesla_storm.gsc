// scripts\mp\common\field_upgrades\field_upgrades_tesla_storm.gsc  (hash_2283f34bea43bc0b.gscc) (size: 26884 Bytes / 0x6904 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ab4f80d (984938509)
// size ...... 26884 (0x6904)
// includes .. 18  (offset: 0x612c)
// strings ... 75  (offset: 0x61bc)
// dev strs .. 14  (offset: 0x6858)
// exports ... 39  (offset: 0x4778)
// cseg ...... 0x6fb + 0x407d (0x4778)
// imports ... 146 (offset: 0x4d90)
// animtree1 . 0   (offset: 0x6904)
// animtree2 . 0   (offset: 0x6904)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\player;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace field_upgrades_tesla_storm;

// Namespace field_upgrades_tesla_storm
// Params 0, eflags: 0x5
// Checksum 0x1b588afa, Offset: 0x719
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"tesla_storm", undefined, undefined, &init );
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0xc7f1f9b9, Offset: 0x73a
// Size: 0x209
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_tesla_storm" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_tesla_storm", &set_tesla_storm, &unset_tesla_storm, &begin_use_tesla_storm, &function_e9c27953eed7ee25, undefined, &set_tesla_storm );
    level.super_tesla_storm_throttle = throttle::throttle_initialize( "super_tesla_storm", 2 );
    level.var_c3d239c2efd63ff7 = throttle::throttle_initialize( "super_tesla_storm_fx", 2 );
    level.var_3a81d152f4877935 = [];
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4b>" );
        devgui::add_devgui_command( "<dev string:x78>", "<dev string:x8c>" );
        devgui::add_devgui_func( "<dev string:xbc>", "<dev string:xe2>", &function_ad609938665ca4ed, 1 );
        devgui::function_77df7fe7dd273e10();
    #/
    
    var_76c668e06c492e0e = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormBeamPlayerfx" );
    var_5390747646e198c7 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormBeamAIfx" );
    var_ed2eb14ffdbc906a = "vfx_t10_gameplay_zm_weapons_fld_tesla_storm_transformer";
    level._effect[ "vfx_lightning_zaps_impact" ] = loadfxasset( "vfx_iw9_gameplay_mp_lightning_zaps_impact" );
    level._effect[ "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_lrg" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_lrg" );
    level._effect[ "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_sml" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_sml" );
    level._effect[ "tesla_storm_transformer_beam_effect" ] = loadfxasset( var_76c668e06c492e0e ?? "" );
    level._effect[ "tesla_storm_beam_effect" ] = loadfxasset( var_ed2eb14ffdbc906a ?? "" );
    level._effect[ "tesla_storm_beam_ai_effect" ] = loadfxasset( var_5390747646e198c7 ?? "" );
    scene::function_85b13b837056bc8b( &function_5ce0c8311baaf4cf );
    callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x1d72a737, Offset: 0x94b
// Size: 0x8b
function function_5ce0c8311baaf4cf()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "tesla_storm_active" ) )
        {
            player function_e9c27953eed7ee25();
        }
    }
}

/#

    // Namespace field_upgrades_tesla_storm
    // Params 0
    // Checksum 0x4686bb23, Offset: 0x9de
    // Size: 0x1c0, Type: dev
    function function_ad609938665ca4ed()
    {
        var_2de1fe381d698b42 = field_upgrades::function_5f728868b18ef0c0( "<dev string:xf5>", "<dev string:x107>" );
        n_player_radius = field_upgrades::function_5f728868b18ef0c0( "<dev string:xf5>", "<dev string:x11a>" );
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( player utility::ent_flag( "<dev string:x131>" ) )
                {
                    cylinder( player.origin, player.origin + ( 0, 0, 72 ), var_2de1fe381d698b42, ( 1, 0, 0 ) );
                    continue;
                }
                
                if ( player utility::ent_flag( "<dev string:x149>" ) )
                {
                    cylinder( player.origin, player.origin + ( 0, 0, 72 ), var_2de1fe381d698b42, ( 1, 0, 0 ) );
                    cylinder( player.origin, player.origin + ( 0, 0, 72 ), n_player_radius, ( 0.5, 0, 1 ) );
                    printtoscreen2d( 325, 250, "<dev string:x15c>" + var_2de1fe381d698b42, ( 1, 0, 0 ), 2 );
                    printtoscreen2d( 325, 300, "<dev string:x16e>" + n_player_radius, ( 0.5, 0, 1 ), 2 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace field_upgrades_tesla_storm
// Params 1, eflags: 0x4
// Checksum 0x3a07e248, Offset: 0xba6
// Size: 0x13
function private on_ai_killed( params )
{
    function_897c8e24333decf2();
}

// Namespace field_upgrades_tesla_storm
// Params 1, eflags: 0x4
// Checksum 0x9330ee6b, Offset: 0xbc1
// Size: 0x12b
function private on_zombie_ai_damaged( params )
{
    var_7ff96371a5eec1d6 = utility::ent_flag( "tesla_storm_stunned" ) && isdefined( params.smeansofdeath ) && params.smeansofdeath == "MOD_ELEMENTAL_ELEC";
    b_normal_zombie = self.aicategory == "normal";
    var_c013b9fd4b229ba = isdefined( self.func_dismember_head ) && isdefined( self.var_cb7646dfc8fffd78 );
    
    if ( var_7ff96371a5eec1d6 && b_normal_zombie && var_c013b9fd4b229ba && self.health <= self.maxhealth * 0.3 && utility::percent_chance( 50 ) )
    {
        if ( !self [[ self.var_cb7646dfc8fffd78 ]]() )
        {
            var_d3a7378bba1af55d = params.idamage >= self.health;
            
            if ( self getscriptablehaspart( "shocked_tesla_storm" ) && self getscriptableparthasstate( "shocked_tesla_storm", "shocked_tesla_storm_on_headless" ) )
            {
                self [[ self.func_dismember_head ]]( var_d3a7378bba1af55d );
                utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on_headless" );
            }
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x4c752a60, Offset: 0xcf4
// Size: 0x526
function set_tesla_storm()
{
    self.tesla_storm_settings = spawnstruct();
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_shockwave" ) )
    {
        self.tesla_storm_settings.shockwave_active = 1;
        self.tesla_storm_settings.shockwave_duration = level.zombie_augments[ #"tesla_storm_shockwave" ].var_f55808b20689ceed ?? 0;
        self.tesla_storm_settings.shockwave_range = level.zombie_augments[ #"tesla_storm_shockwave" ].var_4105f7ea07a3753 ?? 0;
        self.tesla_storm_settings.shockwave_damage = level.zombie_augments[ #"tesla_storm_shockwave" ].var_3a2dd1d9c6028120 ?? 0;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_transformer" ) )
    {
        self.tesla_storm_settings.transformer_active = 1;
        self.tesla_storm_settings.transformer_damage = level.zombie_augments[ #"tesla_storm_transformer" ].var_799d30554ecc85dc ?? 0;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_static_discharge" ) )
    {
        self.tesla_storm_settings.static_discharge_active = 1;
        self.tesla_storm_settings.static_discharge_damage = level.zombie_augments[ #"tesla_storm_static_discharge" ].var_f76c81a25f2b810d ?? 0;
        self.tesla_storm_settings.static_discharge_radius = level.zombie_augments[ #"tesla_storm_static_discharge" ].var_25cd470db6e39cf2 ?? 0;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_sat_major" ) )
    {
        self.tesla_storm_settings.tesla_storm_sat_major = 1;
        self.tesla_storm_settings.tesla_storm_sat_major_rate = level.zombie_augments[ #"tesla_storm_sat_major" ].var_7312454913ba7ff4 ?? 0;
        self.tesla_storm_settings.tesla_storm_sat_major_damage = level.zombie_augments[ #"tesla_storm_sat_major" ].var_3123a11ab7115ef3 ?? 0;
        self.tesla_storm_settings.tesla_storm_sat_major_stun = level.zombie_augments[ #"tesla_storm_sat_major" ].var_2b9bd75cedc40246 ?? 0;
        self.tesla_storm_settings.tesla_storm_sat_major_radius = level.zombie_augments[ #"tesla_storm_sat_major" ].var_6adafe9729878294 ?? 0;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_lithium_charged" ) )
    {
        base_duration = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", #"hash_50e0747334dae395" );
        
        if ( !isdefined( base_duration ) )
        {
            base_duration = 8;
        }
        
        self.var_87e9b1896b9a4e5f = base_duration;
        extend_amount = level.zombie_augments[ #"tesla_storm_lithium_charged" ].var_c53f24f17d00b7ea ?? 0;
        self.super.staticdata.usetime = extend_amount;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_power_grid" ) )
    {
        self.tesla_storm_settings.var_3283cabe1196d3d7 = 1;
        self.tesla_storm_settings.var_77956ba5a7db39db = level.zombie_augments[ #"tesla_storm_power_grid" ].var_4b01a7b997199781 ?? 0;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_overclocked" ) )
    {
        self.tesla_storm_settings.overclocked_active = 1;
        self.tesla_storm_settings.overclocked_speed_boost = level.zombie_augments[ #"tesla_storm_overclocked" ].var_2c74a7faae010dd ?? 0;
        
        if ( !callback::exists( #"player_disconnect", &on_player_disconnect ) )
        {
            callback::add( #"player_disconnect", &on_player_disconnect );
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_sat_minor" ) )
    {
        self.tesla_storm_settings.tesla_storm_sat_minor = 1;
        self.tesla_storm_settings.tesla_storm_sat_minor_radius = level.zombie_augments[ #"tesla_storm_sat_minor" ].var_f4758e09f6411810 ?? 0;
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x94a0e771, Offset: 0x1222
// Size: 0x36
function unset_tesla_storm()
{
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x92dadbb7, Offset: 0x1260
// Size: 0x145, Type: bool
function begin_use_tesla_storm()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_tesla_storm" ] ) )
    {
        var_dcae78063e4d175e = level.field_upgrade_bundles[ "super_tesla_storm" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( var_dcae78063e4d175e, "super_tesla_storm" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                self setscriptablepartstate( "wand_fx", "wand_on_ts", 0 );
            }
            
            var_2de1fe381d698b42 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormAIRadius" );
            n_player_radius = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormPlayerRadius" );
            
            if ( self.tesla_storm_settings.tesla_storm_sat_minor )
            {
                var_2de1fe381d698b42 += self.tesla_storm_settings.tesla_storm_sat_minor_radius;
                n_player_radius += self.tesla_storm_settings.tesla_storm_sat_minor_radius;
            }
            
            if ( self.tesla_storm_settings.var_3283cabe1196d3d7 )
            {
                n_player_radius += self.tesla_storm_settings.var_77956ba5a7db39db;
            }
            
            self.tesla_storm_zombies = undefined;
            thread tesla_storm_active( n_player_radius, var_2de1fe381d698b42 );
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0xe44aee90, Offset: 0x13ae
// Size: 0xc6, Type: bool
function function_e9c27953eed7ee25( fromdeath, attacker )
{
    self notify( #"end_tesla_storm" );
    utility::ent_flag_clear( "field_upgrade_in_use" );
    utility::ent_flag_clear( "tesla_storm_active" );
    
    if ( self.var_206c897757c58dd5 && utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
    {
        utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_tesla_storm_success" );
    }
    
    self.var_206c897757c58dd5 = undefined;
    
    if ( isdefined( self.var_1b0400935f2ae9b9 ) )
    {
        self.var_1b0400935f2ae9b9 delete();
    }
    
    callback::callback( "field_upgrade_ended", { #ref:"super_tesla_storm" } );
    return false;
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x76937e61, Offset: 0x147d
// Size: 0x4f1
function tesla_storm_active( n_player_range, var_1c6776d551872381 )
{
    self endon( #"disconnect" );
    utility::ent_flag_init( "field_upgrade_in_use" );
    utility::ent_flag_set( "field_upgrade_in_use" );
    utility::ent_flag_init( "tesla_storm_active" );
    utility::ent_flag_set( "tesla_storm_active" );
    var_dc58879cfee40e71 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", #"hash_50e0747334dae395" );
    
    if ( !isdefined( var_dc58879cfee40e71 ) )
    {
        var_dc58879cfee40e71 = 10;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"tesla_storm_lithium_charged" ) )
    {
        extend_amount = level.zombie_augments[ #"tesla_storm_lithium_charged" ].var_c53f24f17d00b7ea ?? 0;
        var_dc58879cfee40e71 = extend_amount;
    }
    
    if ( !isdefined( self.tesla_storm_zombies ) )
    {
        self.tesla_storm_zombies = [];
    }
    
    thread apply_effects_source( var_dc58879cfee40e71 );
    function_883e691dadb72d6b( self );
    function_7c39fe1ecf7b7456();
    
    if ( self.tesla_storm_settings.shockwave_active )
    {
        shock_radius = self.tesla_storm_settings.shockwave_range;
        
        if ( self.tesla_storm_settings.tesla_storm_sat_minor )
        {
            shock_radius += self.tesla_storm_settings.tesla_storm_sat_minor_radius;
        }
        
        function_7422a784a53d4374( n_player_range, shock_radius );
    }
    
    if ( self.tesla_storm_settings.static_discharge_active )
    {
        static_discharge_radius = self.tesla_storm_settings.static_discharge_radius;
        
        if ( self.tesla_storm_settings.tesla_storm_sat_minor )
        {
            static_discharge_radius += self.tesla_storm_settings.tesla_storm_sat_minor_radius;
        }
        
        function_d1dbd3d81a25cb70( n_player_range, static_discharge_radius );
    }
    
    tesla_storm_sat_major_duration = 0;
    
    while ( function_8dcdbb255eafe874() && var_dc58879cfee40e71 > 0 )
    {
        if ( self.tesla_storm_settings.tesla_storm_sat_major )
        {
            if ( tesla_storm_sat_major_duration < 0 )
            {
                thread tesla_storm_sat_major( self.tesla_storm_settings.tesla_storm_sat_major_rate, self.tesla_storm_settings.tesla_storm_sat_major_damage, self.tesla_storm_settings.tesla_storm_sat_major_stun, self.tesla_storm_settings.tesla_storm_sat_major_radius );
                tesla_storm_sat_major_duration = self.tesla_storm_settings.tesla_storm_sat_major_rate;
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player == self || player utility::ent_flag( "tesla_storm_active" ) || player function_e01a317e6ec73518( self ) )
            {
                if ( self.tesla_storm_settings.overclocked_active )
                {
                    player weapons::function_4512b7715789e4cf( "tesla_storm_overclock" + self.name, self.tesla_storm_settings.overclocked_speed_boost );
                    player weapons::updatemovespeedscale();
                }
                
                continue;
            }
            else if ( self.tesla_storm_settings.overclocked_active )
            {
                if ( isdefined( player.var_e5996377e9a13e32[ "tesla_storm_overclock" + self.name ] ) )
                {
                    player weapons::function_986fc44dada307f4( "tesla_storm_overclock" + self.name );
                    player weapons::updatemovespeedscale();
                }
            }
            
            if ( function_a524a765688a4888( player, n_player_range ) )
            {
                thread function_20c1edd1cb24f851( player, n_player_range, var_1c6776d551872381 );
            }
        }
        
        function_ece2621ea9b3db0e( var_1c6776d551872381, n_player_range );
        var_dc58879cfee40e71 -= level.framedurationseconds;
        
        if ( self.tesla_storm_settings.tesla_storm_sat_major )
        {
            tesla_storm_sat_major_duration -= level.framedurationseconds;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        if ( self.tesla_storm_settings.overclocked_active )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player.var_e5996377e9a13e32[ "tesla_storm_overclock" + self.name ] ) )
                {
                    player weapons::function_986fc44dada307f4( "tesla_storm_overclock" + self.name );
                    player weapons::updatemovespeedscale();
                }
            }
        }
        
        function_df8ee9d2ee1061b8( self );
        thread remove_effects_source();
        function_7c39fe1ecf7b7456();
        utility::ent_flag_clear( "field_upgrade_in_use" );
        utility::ent_flag_clear( "tesla_storm_active" );
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x25b105fe, Offset: 0x1976
// Size: 0x9d
function function_7c39fe1ecf7b7456()
{
    if ( isdefined( self.stunned_enemies ) )
    {
        foreach ( enemy in self.stunned_enemies )
        {
            if ( isdefined( enemy ) )
            {
                enemy utility::ent_flag_clear( "tesla_storm_scored" );
            }
        }
    }
    
    self.stunned_enemies = [];
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x2003ad38, Offset: 0x1a1b
// Size: 0x182
function function_7422a784a53d4374( n_player_range, var_1c6776d551872381 )
{
    function_883e691dadb72d6b( self );
    
    foreach ( player in level.players )
    {
        if ( player == self || function_a524a765688a4888( player, n_player_range ) )
        {
            if ( self.tesla_storm_settings.shockwave_active )
            {
                player setscriptablepartstate( "tesla_storm_shockwave_fx", "super_fx_on", 0 );
            }
            
            var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, n_player_range );
            
            foreach ( ai in var_6f5c0bece5deb66e )
            {
                if ( function_d5c66989d9bc521b( ai, self, var_1c6776d551872381, n_player_range ) )
                {
                    if ( self.tesla_storm_settings.shockwave_active )
                    {
                        if ( isalive( ai ) )
                        {
                            ai thread tesla_storm_shockwave( player, self );
                        }
                    }
                }
            }
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 4
// Checksum 0xc0133d41, Offset: 0x1ba5
// Size: 0x5c1
function tesla_storm_sat_major( rate, damage, stun, radius )
{
    major_radius = radius;
    
    if ( self.tesla_storm_settings.tesla_storm_sat_minor )
    {
        major_radius += radius + self.tesla_storm_settings.tesla_storm_sat_minor_radius;
    }
    
    var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, major_radius );
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
    {
        var_6f5c0bece5deb66e = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_6f5c0bece5deb66e, self );
    }
    
    for ( i = 0; i < var_6f5c0bece5deb66e.size ; i++ )
    {
        target = var_6f5c0bece5deb66e[ i ];
        
        if ( !isdefined( target.maxhealth ) || target.team == self.team || !isalive( target ) || !target val::get( "damage" ) )
        {
            var_6f5c0bece5deb66e[ i ] = undefined;
        }
    }
    
    var_6f5c0bece5deb66e = function_5713d46873b29625( var_6f5c0bece5deb66e );
    
    if ( var_6f5c0bece5deb66e.size > 0 )
    {
        random_index = randomint( var_6f5c0bece5deb66e.size );
        target_zombie = var_6f5c0bece5deb66e[ random_index ];
    }
    else
    {
        return;
    }
    
    calculated_damage = target_zombie.maxhealth * damage;
    b_stun_anim = 0;
    var_772501ce9a0c24da = stun;
    
    if ( isdefined( target_zombie.aicategory ) )
    {
        switch ( target_zombie.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
            case #"hash_84fcf5e68d7230b2":
            case #"hash_8c089e813083e510":
                b_stun_anim = 1;
                break;
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                b_stun_anim = 0;
                break;
        }
    }
    
    if ( isdefined( calculated_damage ) && isalive( self ) )
    {
        if ( calculated_damage > 0 )
        {
            throttle::throttle_wait_in_queue( level.super_tesla_storm_throttle, target_zombie );
            
            if ( b_stun_anim )
            {
                target_zombie effect_stun::stun( "tesla_storm_shockwave", var_772501ce9a0c24da, self, undefined, undefined, "electrical" );
            }
        }
        
        vfx_loc = target_zombie gettagorigin( "j_spine4", 1 );
        
        if ( !isdefined( vfx_loc ) )
        {
            vfx_loc = target_zombie.origin;
        }
        
        playfx( utility::getfx( "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_lrg" ), vfx_loc );
        var_2b20041d194615d0 = target_zombie.unittype == "soldier";
        sweapon = "none";
        
        if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
            {
                sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
            }
            else
            {
                sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
            }
        }
        
        if ( var_2b20041d194615d0 )
        {
            n_tick_time = 0.2;
            firstshock = gettime() > target_zombie._blackboard.var_ba9517cfc0287af8 + utility::function_4b74c15943231980( 1 );
            target_zombie._blackboard.var_ba9517cfc0287af8 = gettime();
            
            if ( target_zombie asmhaspainstate( target_zombie.asmname ) && firstshock )
            {
                target_zombie asmevalpaintransition( target_zombie.asmname );
            }
            
            if ( isdefined( target_zombie.subclass ) && issubstr( target_zombie.subclass, "warlord" ) )
            {
                calculated_damage = target_zombie.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418;
            }
            
            calculated_damage = int( calculated_damage / 5 );
        }
        
        target_zombie notify( #"hash_caa2c33b65c6d096" );
        thread function_442656c21256a350( calculated_damage, target_zombie, sweapon, var_772501ce9a0c24da );
        params = { #sweapon:sweapon, #eattacker:self, #damage:calculated_damage };
        target_zombie callback::callback( "on_tesla_storm_stunned", params );
        
        if ( !arraycontains( self.tesla_storm_zombies, target_zombie ) )
        {
            self.tesla_storm_zombies[ self.tesla_storm_zombies.size ] = target_zombie;
            callback::callback( "field_upgrade_stats_track", { #stats:"electrocutions", #ref:"super_tesla_storm", #player:self } );
        }
        
        if ( calculated_damage > 0 )
        {
            if ( var_2b20041d194615d0 )
            {
                target_zombie utility::function_7c10ea82c1e305b8( "shockStickVfx", "vfx_start" );
                target_zombie.ishaywire = 1;
            }
            else if ( isdefined( target_zombie.var_cb7646dfc8fffd78 ) && target_zombie [[ target_zombie.var_cb7646dfc8fffd78 ]]() )
            {
                target_zombie utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on_headless" );
            }
            else
            {
                target_zombie utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on" );
            }
            
            wait var_772501ce9a0c24da;
            
            while ( status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm" ) || status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm_shockwave" ) )
            {
                waitframe();
            }
            
            if ( var_2b20041d194615d0 )
            {
                target_zombie utility::function_7c10ea82c1e305b8( "shockStickVfx", "off" );
                target_zombie.ishaywire = undefined;
                return;
            }
            
            target_zombie utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_off" );
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 4
// Checksum 0xb393db73, Offset: 0x216e
// Size: 0xe0
function function_442656c21256a350( calculated_damage, target_zombie, sweapon, duration )
{
    self endon( #"death_or_disconnect" );
    target_zombie endon( #"hash_caa2c33b65c6d096" );
    total_duration = duration;
    var_fba2acdd44267d9f = playfxontagsbetweenclients( utility::getfx( "tesla_storm_beam_ai_effect" ), self, "j_spineupper", target_zombie, target_zombie get_tesla_storm_tag() );
    
    while ( isalive( target_zombie ) && isdefined( target_zombie.maxhealth ) && duration > 0 )
    {
        target_zombie dodamage( calculated_damage / total_duration, target_zombie gettagorigin( target_zombie get_tesla_storm_tag() ), self, self, "MOD_ELEMENTAL_ELEC", sweapon, "torso_upper", undefined, 1073807360 );
        duration -= 1;
        wait 1;
        
        if ( isdefined( var_fba2acdd44267d9f ) )
        {
            var_fba2acdd44267d9f delete();
        }
        
        waitframe();
    }
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x2893f2d3, Offset: 0x2256
// Size: 0x18c
function function_d1dbd3d81a25cb70( n_player_range, var_1c6776d551872381 )
{
    function_883e691dadb72d6b( self );
    self.var_b96c1e543806339c = 0;
    
    foreach ( player in level.players )
    {
        if ( player == self || function_a524a765688a4888( player, n_player_range ) )
        {
            if ( self.tesla_storm_settings.static_discharge_active )
            {
                player setscriptablepartstate( "tesla_storm_static_discharge_fx", "super_fx_on", 0 );
            }
            
            var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, var_1c6776d551872381 );
            
            foreach ( ai in var_6f5c0bece5deb66e )
            {
                if ( function_d5c66989d9bc521b( ai, self, var_1c6776d551872381, n_player_range ) )
                {
                    if ( self.tesla_storm_settings.static_discharge_active )
                    {
                        if ( isalive( ai ) )
                        {
                            ai thread function_5e21230897cb8a59( player, self );
                        }
                    }
                }
            }
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x72f6e659, Offset: 0x23ea
// Size: 0x485
function tesla_storm_shockwave( var_bf9f263a78d8b28d, super_source )
{
    self endon( #"death" );
    
    if ( !isdefined( var_bf9f263a78d8b28d.tesla_storm_zombies ) )
    {
        var_bf9f263a78d8b28d.tesla_storm_zombies = [];
    }
    
    if ( arraycontains( var_bf9f263a78d8b28d.tesla_storm_zombies, self ) )
    {
        return;
    }
    
    var_882cdadff5226264 = self.maxhealth * super_source.tesla_storm_settings.shockwave_damage;
    b_stun_anim = 0;
    n_tick_time = super_source.tesla_storm_settings.shockwave_duration;
    
    if ( isdefined( self.aicategory ) )
    {
        switch ( self.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
            case #"hash_84fcf5e68d7230b2":
            case #"hash_8c089e813083e510":
                b_stun_anim = 1;
                break;
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                b_stun_anim = 0;
                break;
        }
    }
    
    if ( isdefined( var_882cdadff5226264 ) && isalive( var_bf9f263a78d8b28d ) )
    {
        if ( var_882cdadff5226264 > 0 )
        {
            throttle::throttle_wait_in_queue( level.super_tesla_storm_throttle, self );
            
            if ( b_stun_anim )
            {
                effect_stun::stun( "tesla_storm_shockwave", n_tick_time + 0.15, var_bf9f263a78d8b28d, undefined, undefined, "electrical" );
            }
        }
        
        var_2b20041d194615d0 = self.unittype == "soldier";
        sweapon = "none";
        
        if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
            {
                sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
            }
            else
            {
                sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
            }
        }
        
        if ( var_2b20041d194615d0 )
        {
            n_tick_time = 0.2;
            firstshock = gettime() > self._blackboard.var_ba9517cfc0287af8 + utility::function_4b74c15943231980( 1 );
            self._blackboard.var_ba9517cfc0287af8 = gettime();
            
            if ( self asmhaspainstate( self.asmname ) && firstshock )
            {
                self asmevalpaintransition( self.asmname );
            }
            
            if ( isdefined( self.subclass ) && issubstr( self.subclass, "warlord" ) )
            {
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418;
            }
            
            var_882cdadff5226264 = int( var_882cdadff5226264 / 5 );
        }
        
        self dodamage( var_882cdadff5226264, self gettagorigin( get_tesla_storm_tag() ), var_bf9f263a78d8b28d, var_bf9f263a78d8b28d, "MOD_ELEMENTAL_ELEC", sweapon, "torso_upper", undefined, 65536 );
        params = { #sweapon:sweapon, #eattacker:var_bf9f263a78d8b28d, #damage:var_882cdadff5226264 };
        callback::callback( "on_tesla_storm_stunned", params );
        
        if ( !arraycontains( var_bf9f263a78d8b28d.tesla_storm_zombies, self ) )
        {
            var_bf9f263a78d8b28d.tesla_storm_zombies[ var_bf9f263a78d8b28d.tesla_storm_zombies.size ] = self;
            var_bf9f263a78d8b28d callback::callback( "field_upgrade_stats_track", { #stats:"electrocutions", #ref:"super_tesla_storm", #player:var_bf9f263a78d8b28d } );
        }
        
        if ( var_882cdadff5226264 > 0 )
        {
            if ( var_2b20041d194615d0 )
            {
                utility::function_7c10ea82c1e305b8( "shockStickVfx", "vfx_start" );
                self.ishaywire = 1;
            }
            else if ( isdefined( self.var_cb7646dfc8fffd78 ) && self [[ self.var_cb7646dfc8fffd78 ]]() )
            {
                utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on_headless" );
            }
            else
            {
                utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on" );
            }
            
            wait n_tick_time;
            
            while ( status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm" ) || status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm_shockwave" ) )
            {
                waitframe();
            }
            
            if ( var_2b20041d194615d0 )
            {
                utility::function_7c10ea82c1e305b8( "shockStickVfx", "off" );
                self.ishaywire = undefined;
                return;
            }
            
            utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_off" );
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x4465a229, Offset: 0x2877
// Size: 0x21e
function function_5e21230897cb8a59( var_bf9f263a78d8b28d, super_source )
{
    self endon( #"death" );
    
    if ( val::get( "damageshield" ) )
    {
        return;
    }
    
    var_882cdadff5226264 = self.maxhealth * super_source.tesla_storm_settings.static_discharge_damage;
    
    if ( self.aicategory == "normal" || self.aicategory == "special" )
    {
        if ( isdefined( var_882cdadff5226264 ) && isalive( var_bf9f263a78d8b28d ) )
        {
            if ( var_882cdadff5226264 > 0 )
            {
                throttle::throttle_wait_in_queue( level.super_tesla_storm_throttle, self );
            }
            
            sweapon = "none";
            
            if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
            {
                if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
                {
                    sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                    level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
                }
                else
                {
                    sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
                }
            }
            
            vfx_loc = self gettagorigin( "j_spine4", 1 );
            
            if ( !isdefined( vfx_loc ) )
            {
                vfx_loc = self.origin;
            }
            
            if ( super_source.var_b96c1e543806339c < 10 )
            {
                playfx( utility::getfx( "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_lrg" ), vfx_loc );
            }
            else
            {
                playfx( utility::getfx( "vfx_t10_gameplay_zm_weapons_fld_tesla_discharge_sml" ), vfx_loc );
            }
            
            super_source.var_b96c1e543806339c += 1;
            
            if ( self.aicategory == "normal" )
            {
                super_source namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_875e6f1389657771" );
            }
            else if ( self.aicategory == "special" )
            {
                super_source namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_e2d7136521084f15" );
            }
            
            self kill();
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 3
// Checksum 0x1ead5ece, Offset: 0x2a9d
// Size: 0x9d
function function_20c1edd1cb24f851( player, n_player_range, var_1c6776d551872381 )
{
    player notify( #"end_tesla_storm_buff" );
    player endon( #"end_tesla_storm_buff" );
    player utility::ent_flag_set( "tesla_storm_buff_active" );
    player thread apply_effects_buff( self );
    player function_883e691dadb72d6b( self );
    
    while ( function_a524a765688a4888( player, n_player_range ) )
    {
        player function_ece2621ea9b3db0e( var_1c6776d551872381, n_player_range );
        waitframe();
    }
    
    if ( isdefined( player ) )
    {
        player function_df8ee9d2ee1061b8( self );
        player utility::ent_flag_clear( "tesla_storm_buff_active" );
        player thread remove_effects_buff( self );
    }
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0x53bcdf33, Offset: 0x2b42
// Size: 0x49
function function_883e691dadb72d6b( var_bf9f263a78d8b28d )
{
    if ( !isdefined( self.var_986e73870c3f7afc ) )
    {
        self.var_986e73870c3f7afc = [];
    }
    
    self.var_986e73870c3f7afc = function_5713d46873b29625( self.var_986e73870c3f7afc );
    arrayinsert( self.var_986e73870c3f7afc, var_bf9f263a78d8b28d, 0 );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0x950d1573, Offset: 0x2b93
// Size: 0x50
function function_df8ee9d2ee1061b8( var_bf9f263a78d8b28d )
{
    if ( !isdefined( self.var_986e73870c3f7afc ) )
    {
        self.var_986e73870c3f7afc = [];
    }
    
    self.var_986e73870c3f7afc = function_5713d46873b29625( self.var_986e73870c3f7afc );
    self.var_986e73870c3f7afc = arrayremove( self.var_986e73870c3f7afc, var_bf9f263a78d8b28d );
}

// Namespace field_upgrades_tesla_storm
// Params 1, eflags: 0x4
// Checksum 0xe9fc759c, Offset: 0x2beb
// Size: 0x47
function private function_e01a317e6ec73518( var_bf9f263a78d8b28d )
{
    if ( !isdefined( self.var_986e73870c3f7afc ) )
    {
        self.var_986e73870c3f7afc = [];
    }
    
    self.var_986e73870c3f7afc = function_5713d46873b29625( self.var_986e73870c3f7afc );
    return arraycontains( self.var_986e73870c3f7afc, var_bf9f263a78d8b28d );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0x79a3c22e, Offset: 0x2c3b
// Size: 0x5a, Type: bool
function function_8dcdbb255eafe874( b_check_tesla_storm_buff = 0 )
{
    if ( isalive( self ) && !vehicle::is_in_vehicle() && !player::isinlaststand( self ) )
    {
        if ( utility::ent_flag( "tesla_storm_active" ) || b_check_tesla_storm_buff && utility::ent_flag( "tesla_storm_buff_active" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x71b1480e, Offset: 0x2c9e
// Size: 0x1c3, Type: bool
function function_a524a765688a4888( player, n_player_range )
{
    if ( !( isdefined( player ) && isdefined( self ) ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player ) )
        {
            return false;
        }
    }
    
    var_5a829bf11dc9e419 = utility::ent_flag( "tesla_storm_active" );
    var_ea89917cf883873e = !isalive( self ) || !isalive( player );
    b_any_player_in_vehicle = vehicle::is_in_vehicle() || player vehicle::is_in_vehicle();
    b_any_player_in_laststand = player::isinlaststand( self ) || player player::isinlaststand( player );
    var_e503994557e9877c = self.team == player.team;
    can_affect = 1;
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
    {
        can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
    }
    
    if ( var_5a829bf11dc9e419 && !var_ea89917cf883873e && !b_any_player_in_vehicle && !b_any_player_in_laststand && var_e503994557e9877c && can_affect )
    {
        v_pos_1 = self gettagorigin( "j_spineupper" );
        v_pos_2 = player gettagorigin( "j_spineupper" );
        var_9c9f604f49279920 = distancesquared( v_pos_1, v_pos_2 ) < n_player_range * n_player_range;
        
        if ( var_9c9f604f49279920 )
        {
            contents = trace::create_solid_ai_contents( 1 );
            
            if ( trace::ray_trace_passed( v_pos_1, v_pos_2, player, contents ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace field_upgrades_tesla_storm
// Params 4
// Checksum 0xcecbc815, Offset: 0x2e6a
// Size: 0x359, Type: bool
function function_d5c66989d9bc521b( ai, var_bf9f263a78d8b28d, var_1c6776d551872381, n_player_range )
{
    if ( !( isdefined( self ) && isdefined( self ) ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( var_bf9f263a78d8b28d, ai ) )
        {
            return false;
        }
    }
    
    var_b380ed1431495b0f = self.team != ai.team;
    var_5a829bf11dc9e419 = ( utility::ent_flag( "tesla_storm_active" ) || utility::ent_flag( "tesla_storm_buff_active" ) ) && !ai utility::ent_flag( "tesla_storm_active" ) && !ai utility::ent_flag( "tesla_storm_buff_active" );
    var_a0ff99dded78cebc = !isalive( self ) || !isalive( ai );
    b_is_valid_ai_type = ai.type == "zombie" || ai.unittype == "soldier" || isplayer( ai );
    var_a54935072c78d91b = ai utility::ent_flag( "tesla_storm_stunned" );
    var_ef2f47f2dd543c71 = isdefined( ai.model );
    
    if ( !var_a54935072c78d91b && var_b380ed1431495b0f && var_5a829bf11dc9e419 && !var_a0ff99dded78cebc && b_is_valid_ai_type && var_ef2f47f2dd543c71 && function_8dcdbb255eafe874( 1 ) )
    {
        v_pos_1 = self gettagorigin( "j_spineupper" );
        v_pos_2 = ai gettagorigin( ai get_tesla_storm_tag() );
        var_9f170546e7280cf8 = distancesquared( v_pos_1, v_pos_2 ) <= var_1c6776d551872381 * var_1c6776d551872381;
        contents = trace::create_solid_ai_contents( 1 );
        
        if ( var_9f170546e7280cf8 && trace::ray_trace_passed( v_pos_1, v_pos_2, ai, contents ) )
        {
            return true;
        }
    }
    
    if ( var_bf9f263a78d8b28d utility::ent_flag( "tesla_storm_active" ) && !var_bf9f263a78d8b28d utility::ent_flag( "tesla_storm_buff_active" ) )
    {
        a_nearby_players = utility::get_array_of_closest( var_bf9f263a78d8b28d.origin, level.players, undefined, undefined, n_player_range );
        
        foreach ( var_e74385e0933179f9 in a_nearby_players )
        {
            if ( var_e74385e0933179f9 == var_bf9f263a78d8b28d || !var_e74385e0933179f9 utility::ent_flag( "tesla_storm_buff_active" ) )
            {
                continue;
            }
            
            if ( var_e74385e0933179f9.team != var_bf9f263a78d8b28d.team )
            {
                continue;
            }
            
            if ( isalive( ai ) && isdefined( ai.model ) && var_b380ed1431495b0f )
            {
                var_cf6eb94f01e66fd6 = var_bf9f263a78d8b28d gettagorigin( "j_spineupper" );
                var_54ab98a98b57d4a3 = var_e74385e0933179f9 gettagorigin( "j_spineupper" );
                var_d49dee97adf3cbf7 = ai gettagorigin( ai get_tesla_storm_tag() );
                
                if ( math::segmentvssphere( var_cf6eb94f01e66fd6, var_54ab98a98b57d4a3, var_d49dee97adf3cbf7, 25 ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace field_upgrades_tesla_storm
// Params 2
// Checksum 0x71efa484, Offset: 0x31cc
// Size: 0x212
function function_ece2621ea9b3db0e( var_1c6776d551872381, n_player_range )
{
    var_6f5c0bece5deb66e = getaiarrayinradius( self.origin, n_player_range );
    str_enemy_team = self.team == "allies" ? "axis" : "allies";
    var_2f0e7e6815a92743 = getplayersinradius( self.origin, var_1c6776d551872381, undefined, 1, undefined, str_enemy_team );
    var_6f5c0bece5deb66e = arraycombineunique( var_6f5c0bece5deb66e, var_2f0e7e6815a92743 );
    
    foreach ( ai in var_6f5c0bece5deb66e )
    {
        if ( function_d5c66989d9bc521b( ai, self, var_1c6776d551872381, n_player_range ) )
        {
            if ( !ai.tesla_damaged )
            {
                ai.tesla_damaged = 1;
                ai thread tesla_storm_ai_damage( self.var_986e73870c3f7afc[ 0 ] );
            }
            
            ai thread function_faaaa59af298107f( self.var_986e73870c3f7afc[ 0 ] );
            a_closest_ai = utility::get_array_of_closest( ai.origin, var_6f5c0bece5deb66e, undefined, undefined, n_player_range );
            
            foreach ( var_f47d94670350654c in a_closest_ai )
            {
                if ( ai == var_f47d94670350654c || !isalive( var_f47d94670350654c ) )
                {
                    continue;
                }
                
                if ( var_f47d94670350654c utility::ent_flag( "tesla_storm_stunned" ) )
                {
                    if ( !isdefined( ai.var_fba2acdd44267d9f ) )
                    {
                        ai function_b7b9829afdb3d47b( var_f47d94670350654c );
                        break;
                    }
                    
                    continue;
                }
                
                var_f47d94670350654c function_897c8e24333decf2();
            }
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xbcf07b39, Offset: 0x33e6
// Size: 0x42a
function function_faaaa59af298107f( var_bf9f263a78d8b28d )
{
    self endon( #"death" );
    
    if ( !isdefined( var_bf9f263a78d8b28d.tesla_storm_zombies ) )
    {
        var_bf9f263a78d8b28d.tesla_storm_zombies = [];
    }
    
    b_stun_anim = 0;
    n_tick_time = 1;
    
    if ( isdefined( self.aicategory ) )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                b_stun_anim = 1;
                break;
            case #"hash_8c089e813083e510":
                b_stun_anim = 1;
                break;
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                b_stun_anim = 0;
                break;
        }
    }
    
    if ( isalive( var_bf9f263a78d8b28d ) )
    {
        utility::ent_flag_set( "tesla_storm_stunned" );
        self.tesla_storm_stunned = 1;
        throttle::throttle_wait_in_queue( level.super_tesla_storm_throttle, self );
        
        if ( !self.var_997844c38a251c4c && b_stun_anim && !status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm_shockwave" ) )
        {
            if ( !utility::ent_flag( "tesla_storm_scored" ) )
            {
                utility::ent_flag_set( "tesla_storm_scored" );
                
                if ( !isdefined( var_bf9f263a78d8b28d.stunned_enemies ) )
                {
                    var_bf9f263a78d8b28d.stunned_enemies = [];
                }
                
                var_bf9f263a78d8b28d.stunned_enemies[ var_bf9f263a78d8b28d.stunned_enemies.size ] = self;
                effect_stun::stun( "tesla_storm", n_tick_time + 0.15, var_bf9f263a78d8b28d, undefined, undefined, "electrical" );
            }
            else
            {
                effect_stun::stun( "tesla_storm", n_tick_time + 0.15, var_bf9f263a78d8b28d, undefined, undefined, "electrical", 1 );
            }
        }
        
        var_2b20041d194615d0 = self.unittype == "soldier";
        sweapon = "none";
        
        if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
            {
                sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
            }
            else
            {
                sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
            }
        }
        
        params = { #sweapon:sweapon, #eattacker:var_bf9f263a78d8b28d, #damage:0 };
        callback::callback( "on_tesla_storm_stunned", params );
        
        if ( !arraycontains( var_bf9f263a78d8b28d.tesla_storm_zombies, self ) )
        {
            var_bf9f263a78d8b28d.tesla_storm_zombies[ var_bf9f263a78d8b28d.tesla_storm_zombies.size ] = self;
            var_bf9f263a78d8b28d callback::callback( "field_upgrade_stats_track", { #stats:"electrocutions", #ref:"super_tesla_storm", #player:var_bf9f263a78d8b28d } );
        }
        
        if ( self.var_997844c38a251c4c )
        {
            n_tick_time = var_bf9f263a78d8b28d.var_1b0400935f2ae9b9.tableinfo.bundle.var_860545b754d7ecc0 ?? 4.5;
        }
        else if ( var_2b20041d194615d0 )
        {
            utility::function_7c10ea82c1e305b8( "shockStickVfx", "vfx_start" );
            self.ishaywire = 1;
        }
        else if ( isdefined( self.var_cb7646dfc8fffd78 ) && self [[ self.var_cb7646dfc8fffd78 ]]() )
        {
            utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on_headless" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_on" );
        }
        
        wait n_tick_time;
        
        while ( status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm" ) || status_effects::function_fa35fc2723e956eb( "stun", "tesla_storm_shockwave" ) )
        {
            waitframe();
        }
        
        if ( var_2b20041d194615d0 )
        {
            utility::function_7c10ea82c1e305b8( "shockStickVfx", "off" );
            self.ishaywire = undefined;
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "shocked_tesla_storm", "shocked_tesla_storm_off" );
        }
    }
    
    utility::ent_flag_clear( "tesla_storm_stunned" );
    self.tesla_storm_stunned = 0;
    function_897c8e24333decf2();
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0x11019798, Offset: 0x3818
// Size: 0x804
function tesla_storm_ai_damage( var_bf9f263a78d8b28d )
{
    self endon( #"death" );
    
    if ( !isdefined( var_bf9f263a78d8b28d.tesla_storm_zombies ) )
    {
        var_bf9f263a78d8b28d.tesla_storm_zombies = [];
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_4ec21a5add563d6e ) )
    {
        level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_4ec21a5add563d6e = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormDamagePctNormal" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_b0b12f2affd1d1f4 ) )
    {
        level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_b0b12f2affd1d1f4 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormDamagePctSpecial" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418 ) )
    {
        level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormDamagePctElite" ) ?? 0;
    }
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_77cebb05189d4b30 ) )
    {
        level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_77cebb05189d4b30 = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormDamagePctBoss" ) ?? 0;
    }
    
    var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_4ec21a5add563d6e;
    n_tick_time = 1;
    var_3f1faef0f22b0bb = field_upgrades::function_5f728868b18ef0c0( "super_tesla_storm", "teslaStormMinDamage" ) ?? 0;
    
    if ( isdefined( self.aicategory ) )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_4ec21a5add563d6e;
                break;
            case #"hash_8c089e813083e510":
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_b0b12f2affd1d1f4;
                break;
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418;
                break;
            case #"hash_7e8a002ed096276c":
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_77cebb05189d4b30;
                break;
        }
    }
    
    if ( var_bf9f263a78d8b28d.tesla_storm_settings.transformer_active )
    {
        linked_players = 0;
        
        foreach ( player in level.players )
        {
            if ( player != var_bf9f263a78d8b28d )
            {
                if ( player.var_986e73870c3f7afc[ 0 ] == var_bf9f263a78d8b28d )
                {
                    linked_players++;
                }
            }
        }
        
        var_8476e20814696703 = var_bf9f263a78d8b28d.tesla_storm_settings.transformer_damage * linked_players;
        var_882cdadff5226264 += var_882cdadff5226264 * var_8476e20814696703;
    }
    
    if ( isdefined( var_882cdadff5226264 ) && isalive( var_bf9f263a78d8b28d ) )
    {
        var_2b20041d194615d0 = self.unittype == "soldier";
        sweapon = "none";
        
        if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
            {
                sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
            }
            else
            {
                sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
            }
        }
        
        if ( var_2b20041d194615d0 )
        {
            n_tick_time = 0.2;
            firstshock = gettime() > self._blackboard.var_ba9517cfc0287af8 + utility::function_4b74c15943231980( 1 );
            self._blackboard.var_ba9517cfc0287af8 = gettime();
            
            if ( self asmhaspainstate( self.asmname ) && firstshock )
            {
                self asmevalpaintransition( self.asmname );
            }
            
            if ( isdefined( self.subclass ) && issubstr( self.subclass, "warlord" ) )
            {
                var_882cdadff5226264 = self.maxhealth * level.superglobals.staticsuperdata[ "super_tesla_storm" ].var_a48ec689214c0418;
            }
            
            var_882cdadff5226264 = int( var_882cdadff5226264 / 5 );
        }
        
        if ( var_882cdadff5226264 < var_3f1faef0f22b0bb )
        {
            var_882cdadff5226264 = var_3f1faef0f22b0bb;
        }
        
        self dodamage( var_882cdadff5226264, self gettagorigin( get_tesla_storm_tag() ), var_bf9f263a78d8b28d, var_bf9f263a78d8b28d, "MOD_ELEMENTAL_ELEC", sweapon, "torso_upper", undefined, 65536 );
        params = { #sweapon:sweapon, #eattacker:var_bf9f263a78d8b28d, #damage:var_882cdadff5226264 };
        callback::callback( "on_tesla_storm_stunned", params );
        
        if ( isplayer( self ) )
        {
            if ( !isdefined( var_bf9f263a78d8b28d.var_1b0400935f2ae9b9 ) )
            {
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9 = utility::spawn_tag_origin( var_bf9f263a78d8b28d getcentroid(), var_bf9f263a78d8b28d.angles );
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9 linkto( var_bf9f263a78d8b28d );
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9.owner = var_bf9f263a78d8b28d;
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9.team = var_bf9f263a78d8b28d.team;
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9.tableinfo = weapon::getequipmenttableinfo( "equip_shockstick" );
            }
            
            if ( utility::callsharedfunc( #"shockstick", #"shockstick_canbehaywire", var_bf9f263a78d8b28d.var_1b0400935f2ae9b9 ) )
            {
                var_bf9f263a78d8b28d.var_1b0400935f2ae9b9 thread utility::callsharedfunc( #"shockstick", #"shockstick_applyhaywire", self, sweapon );
                self.var_997844c38a251c4c = 1;
            }
        }
        
        if ( !arraycontains( var_bf9f263a78d8b28d.tesla_storm_zombies, self ) )
        {
            var_bf9f263a78d8b28d.tesla_storm_zombies[ var_bf9f263a78d8b28d.tesla_storm_zombies.size ] = self;
            var_bf9f263a78d8b28d callback::callback( "field_upgrade_stats_track", { #stats:"electrocutions", #ref:"super_tesla_storm", #player:var_bf9f263a78d8b28d } );
        }
    }
    
    if ( self.var_997844c38a251c4c )
    {
        haywireduration = var_bf9f263a78d8b28d.var_1b0400935f2ae9b9.tableinfo.bundle.var_860545b754d7ecc0;
        wait haywireduration;
    }
    else
    {
        wait 1;
    }
    
    self.tesla_damaged = undefined;
    
    if ( self.var_997844c38a251c4c )
    {
        self notify( #"shockstick_interrupt" );
        self.var_997844c38a251c4c = undefined;
        self.haywiretimestamp = undefined;
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x5fa487bc, Offset: 0x4024
// Size: 0x40
function get_tesla_storm_tag()
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

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xd9d81e4b, Offset: 0x406d
// Size: 0x84
function apply_effects_source( var_dc58879cfee40e71 )
{
    self endon( #"death_or_disconnect" );
    thread tesla_storm_fov_change( var_dc58879cfee40e71 );
    
    if ( isdefined( self.tesla_storm_settings.transformer_active ) )
    {
        utility::function_7c10ea82c1e305b8( "tesla_storm_transformer_fx", "super_fx_on" );
    }
    
    if ( self.tesla_storm_settings.tesla_storm_sat_minor )
    {
        self setscriptablepartstate( "tesla_storm_source_fx", "super_fx_on_big", 0 );
        return;
    }
    
    self setscriptablepartstate( "tesla_storm_source_fx", "super_fx_on", 0 );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0x9fe33bb, Offset: 0x40f9
// Size: 0x5e
function apply_effects_buff( var_bf9f263a78d8b28d )
{
    self endon( #"death_or_disconnect" );
    
    if ( var_bf9f263a78d8b28d.tesla_storm_settings.tesla_storm_sat_minor )
    {
        self setscriptablepartstate( "tesla_storm_teammate_fx", "super_fx_on_big", 0 );
    }
    else
    {
        self setscriptablepartstate( "tesla_storm_teammate_fx", "super_fx_on", 0 );
    }
    
    function_b7b9829afdb3d47b( var_bf9f263a78d8b28d );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xf1a992d7, Offset: 0x415f
// Size: 0x5c
function tesla_storm_fov_change( var_dc58879cfee40e71 )
{
    if ( !isdefined( var_dc58879cfee40e71 ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6905fb37f08f5a8e" );
    self endon( #"hash_6905fb37f08f5a8e" );
    self lerpfovbypreset( "zombiedefault" );
    utility::waittill_any_timeout_no_endon_death( var_dc58879cfee40e71, "super_use_finished" );
    self lerpfovbypreset( "default_2seconds" );
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x7506dc91, Offset: 0x41c3
// Size: 0x52
function remove_effects_source()
{
    self endon( #"disconnect" );
    utility::function_7c10ea82c1e305b8( "tesla_storm_transformer_fx", "super_fx_off" );
    self setscriptablepartstate( "tesla_storm_static_discharge_fx", "super_fx_off", 0 );
    self setscriptablepartstate( "tesla_storm_shockwave_fx", "super_fx_off", 0 );
    self setscriptablepartstate( "tesla_storm_source_fx", "super_fx_deactivate", 0 );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xf1941ce8, Offset: 0x421d
// Size: 0x52
function remove_effects_buff( var_bf9f263a78d8b28d )
{
    self endon( #"disconnect" );
    function_897c8e24333decf2();
    self setscriptablepartstate( "tesla_storm_static_discharge_fx", "super_fx_off", 0 );
    self setscriptablepartstate( "tesla_storm_shockwave_fx", "super_fx_off", 0 );
    self setscriptablepartstate( "tesla_storm_teammate_fx", "super_fx_deactivate", 0 );
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xc094b7c5, Offset: 0x4277
// Size: 0x11c
function function_b7b9829afdb3d47b( var_5ddea964f429e3cf )
{
    if ( !isdefined( self.var_fba2acdd44267d9f ) )
    {
        if ( isplayer( self ) )
        {
            if ( isplayer( var_5ddea964f429e3cf ) && !var_5ddea964f429e3cf.tesla_storm_settings.transformer_active )
            {
                self.var_fba2acdd44267d9f = playfxontagsbetweenclients( utility::getfx( "tesla_storm_beam_effect" ), self, "j_spineupper", var_5ddea964f429e3cf, "j_spineupper" );
            }
            else
            {
                utility::function_7c10ea82c1e305b8( "tesla_storm_transformer_fx", "super_fx_on" );
                self.var_fba2acdd44267d9f = playfxontagsbetweenclients( utility::getfx( "tesla_storm_transformer_beam_effect" ), self, "j_spine4", var_5ddea964f429e3cf, "j_spine4" );
            }
            
            return;
        }
        
        if ( isai( self ) && level.var_3a81d152f4877935.size < 8 )
        {
            self.var_fba2acdd44267d9f = playfxontagsbetweenclients( utility::getfx( "tesla_storm_beam_ai_effect" ), self, get_tesla_storm_tag(), var_5ddea964f429e3cf, var_5ddea964f429e3cf get_tesla_storm_tag() );
            level.var_3a81d152f4877935 = function_5713d46873b29625( level.var_3a81d152f4877935 );
            level.var_3a81d152f4877935[ level.var_3a81d152f4877935.size ] = self.var_fba2acdd44267d9f;
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 0
// Checksum 0x86327f9c, Offset: 0x439b
// Size: 0x55
function function_897c8e24333decf2()
{
    if ( isdefined( self.var_fba2acdd44267d9f ) )
    {
        if ( isai( self ) )
        {
            level.var_3a81d152f4877935 = arrayremove( level.var_3a81d152f4877935, self.var_fba2acdd44267d9f );
        }
        
        utility::function_7c10ea82c1e305b8( "tesla_storm_transformer_fx", "super_fx_off" );
        self.var_fba2acdd44267d9f delete();
    }
}

// Namespace field_upgrades_tesla_storm
// Params 1, eflags: 0x4
// Checksum 0x7fbd9fc8, Offset: 0x43f8
// Size: 0x2a6
function private on_killed_medal( params )
{
    if ( params.victim effect_stun::function_715dc69554c2d9ed( params.attacker, "tesla_storm" ) || params.victim effect_stun::function_715dc69554c2d9ed( params.attacker, "tesla_storm_shockwave" ) || params.sweapon.basename == "tesla_storm" )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            params.attacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "tesla_storm" );
        }
        
        if ( isdefined( level.weaponmetadata[ %"tesla_storm" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"tesla_storm" ].weaponobj ) )
            {
                sweapon = makeweapon( level.weaponmetadata[ %"tesla_storm" ].weapon );
                level.weaponmetadata[ %"tesla_storm" ].weaponobj = sweapon;
            }
            else
            {
                sweapon = level.weaponmetadata[ %"tesla_storm" ].weaponobj;
            }
            
            if ( sweapon == params.sweapon )
            {
                params.victim.is_lethal_or_super_kill = 1;
            }
        }
        
        if ( isdefined( params.attacker.rapidkill_data ) )
        {
            if ( isdefined( params.attacker.rapidkill_data[ "tesla_storm" ] ) && params.attacker.rapidkill_data[ "tesla_storm" ].rapidkill_count == 10 )
            {
                params.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_chainlightning" );
                params.attacker.var_206c897757c58dd5 = 1;
            }
        }
        
        if ( isdefined( params.attacker ) )
        {
            sparams = { #stats:"kills_while_active", #ref:"super_tesla_storm", #field_upgrade:"tesla_storm", #victim:params.victim, #player:params.attacker };
            params.attacker callback::callback( "on_field_upgrade_kill_track", sparams );
        }
    }
}

// Namespace field_upgrades_tesla_storm
// Params 1
// Checksum 0xdebc2acc, Offset: 0x46a6
// Size: 0xd2
function on_player_disconnect( params )
{
    foreach ( player in level.players )
    {
        if ( self.tesla_storm_settings.overclocked_active )
        {
            if ( isdefined( player.var_e5996377e9a13e32[ "tesla_storm_overclock" + self.name ] ) )
            {
                player weapons::function_986fc44dada307f4( "tesla_storm_overclock" + self.name );
                player weapons::updatemovespeedscale();
            }
        }
    }
}

