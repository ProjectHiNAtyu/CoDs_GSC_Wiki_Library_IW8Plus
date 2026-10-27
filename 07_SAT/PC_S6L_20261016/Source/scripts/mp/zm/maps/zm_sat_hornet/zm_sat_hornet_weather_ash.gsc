// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash.gsc  (hash_3a6bad88bb71f15d.gscc) (size: 24216 Bytes / 0x5e98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9b6ad6c (3115756908)
// size ...... 24216 (0x5e98)
// includes .. 17  (offset: 0x58e4)
// strings ... 68  (offset: 0x596c)
// dev strs .. 15  (offset: 0x5dd4)
// exports ... 72  (offset: 0x39ac)
// cseg ...... 0x536 + 0x3476 (0x39ac)
// imports ... 162 (offset: 0x44ec)
// animtree1 . 0   (offset: 0x5e98)
// animtree2 . 0   (offset: 0x5e98)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\health_overcharge;
#using scripts\mp\operator;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_sakura;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_weather_ash;

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x5
// Checksum 0xc8d8d0a9, Offset: 0x554
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"weather_ash", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0xb04212fc, Offset: 0x579
// Size: 0x3b
function private function_7cf8dacb278a2665()
{
    if ( getdvarint( @"disable_ash", 0 ) || getdvarint( @"hash_169846c664077bf", 0 ) || getdvarint( @"zombie_cheat", 0 ) == 2 )
    {
        return;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0xa526bc5c, Offset: 0x5bc
// Size: 0x425
function private postmain_init()
{
    level.ash_root = spawnstruct();
    level.ash_root.e_attacker = utility::spawn_tag_origin( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.ash_root.var_110f8886053692a9 = [];
    level.ash_root.a_zone_override = [];
    level.ash_root.wait_override = undefined;
    level.ash_root.var_9ce4eb0e965d3383 = [ "zone_west_bailey", "zone_broken_turrets", "zone_lava_tubes", "zone_third_bailey", "zone_lava_garden", "zone_second_bailey", "zone_main_bailey", "zone_main_keep" ];
    level.ash_root.var_8df87ec7768fe92 = [];
    level.ash_root.var_9458277376443720 = 0;
    level.ash_root.var_222db28c0bf0a5ff = [];
    level.ash_root.var_c6edc8acdc76dbbc = 0;
    level utility::flag_set( "ash_initialized" );
    
    foreach ( zone_name in [ "zone_west_bailey", "zone_broken_turrets", "zone_lava_tubes", "zone_third_bailey", "zone_lava_garden", "zone_second_bailey", "zone_main_bailey", "zone_main_keep" ] )
    {
        var_c507babffa8153f6 = getentitylessscriptablearray( zone_name + "_fsr", #targetname );
        
        foreach ( sbl in var_c507babffa8153f6 )
        {
            trigger = spawn( "noent_volume_trigger_rotatable_radius", sbl.origin, 0, 45, 45 );
            sbl.trigger = trigger;
        }
    }
    
    if ( getdvarint( @"disable_ash", 0 ) || getdvarint( @"hash_169846c664077bf", 0 ) || getdvarint( @"zombie_cheat", 0 ) == 2 || getxhash( level.gametype ) == #"zm_rb_survival" || getxhash( level.gametype ) == #"zm_rb_r_mod_survival" || getxhash( level.gametype ) == #"zm_rb_echo" )
    {
        return;
    }
    
    level thread function_46247889fc02e4a2();
    level thread function_76950327dedc71a2();
    level.ash_root.var_c6edc8acdc76dbbc = 1;
    level thread function_23209fdefd8f349f();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( "zm_exfil_started", &on_exfil_started );
    utility::registersharedfunc( #"hornet_ash", #"ash_paused", &ash_paused );
    utility::registersharedfunc( #"hornet_ash", #"ash_unpaused", &ash_unpaused );
    utility::registersharedfunc( #"hornet_ash", #"hash_a3b5e79a2097cdf9", &function_6f9a9c8f4f91f3a4 );
    utility::registersharedfunc( #"hornet_ash", #"hash_b1637e4daf0e7578", &function_502a6d0994562459 );
    utility::registersharedfunc( #"hornet_ash", #"hash_f6b5bb373b59aa61", &function_209997c5345ab152 );
    
    /#
        function_8f6f8570fbd3c2ab();
    #/
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xcee8009b, Offset: 0x9e9
// Size: 0x27
function private on_player_connect( params )
{
    wait 1;
    
    if ( self )
    {
        setglobalsoundcontext( "zm_hornet_ash_storm", "off", undefined, self );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xbcfc1839, Offset: 0xa18
// Size: 0x282
function function_6f9a9c8f4f91f3a4( zone_name )
{
    zone_name = function_fbb7d4c98261e273( zone_name );
    level endon( "sh_" + zone_name + "_end" );
    var_c31641ff8c12a51c = getentitylessscriptablearray( zone_name + "_fsr", #targetname );
    
    foreach ( sbl in var_c31641ff8c12a51c )
    {
        sbl setscriptablepartstate( "fx", "active" );
        sbl setscriptablepartstate( "ping", "active" );
    }
    
    level thread function_b7abeb217c303763( zone_name, var_c31641ff8c12a51c );
    
    if ( var_c31641ff8c12a51c.size )
    {
        fissure_origin = var_c31641ff8c12a51c[ 0 ].origin;
        level thread function_60aff241085c1187( fissure_origin, zone_name );
    }
    
    level thread function_303d28f6d20b3329( zone_name );
    
    foreach ( fissure in var_c31641ff8c12a51c )
    {
        fissure.trigger thread function_afd81c852e0dbb38( zone_name );
    }
    
    ash_we = function_e0ee2ac72585867c( zone_name );
    
    if ( ash_we )
    {
        activateworldevent( ash_we );
    }
    
    wait 18;
    level notify( "sh_" + zone_name + "_fissure_end" );
    level.ash_root.var_110f8886053692a9 = arraycombineunique( level.ash_root.var_110f8886053692a9, [ zone_name ] );
    
    if ( level.sakura_root.all_trees[ zone_name + "_tree" ] )
    {
        tree = level.sakura_root.all_trees[ zone_name + "_tree" ];
        tree.var_df00f5fbf4a6d195 = 1;
        zm_sat_hornet_weather_sakura::function_a50dd195493a814a( tree );
    }
    
    level callback::callback( "ash_start", { #zone_name:zone_name } );
    
    if ( level.ash_root.var_160b0b1f71aadde2 )
    {
        level thread function_17c9d94eccb26376( zone_name );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x55849c24, Offset: 0xca2
// Size: 0x256
function function_502a6d0994562459( zone_name )
{
    zone_name = function_fbb7d4c98261e273( zone_name );
    function_d670d08a3999a23b( zone_name );
    cleanup_fissure_objectives( zone_name );
    level notify( "sh_" + zone_name + "_end" );
    
    if ( isdefined( level.ash_root.var_1aa58ef0445ed42a[ zone_name ] ) )
    {
        foreach ( waypoint in level.ash_root.var_1aa58ef0445ed42a[ zone_name ] )
        {
            if ( isdefined( waypoint.sbl ) )
            {
                waypoint.sbl freescriptable();
                waypoint.sbl = undefined;
            }
        }
    }
    
    var_c31641ff8c12a51c = getentitylessscriptablearray( zone_name + "_fsr", #targetname );
    
    foreach ( sbl in var_c31641ff8c12a51c )
    {
        sbl setscriptablepartstate( "fx", "none" );
        sbl setscriptablepartstate( "ping", "none" );
    }
    
    ash_we = function_e0ee2ac72585867c( zone_name );
    
    if ( ash_we )
    {
        deactivateworldevent( ash_we );
    }
    
    level.ash_root.var_110f8886053692a9 = arrayremove( level.ash_root.var_110f8886053692a9, zone_name );
    
    if ( level.sakura_root.all_trees[ zone_name + "_tree" ] )
    {
        tree = level.sakura_root.all_trees[ zone_name + "_tree" ];
        tree.var_df00f5fbf4a6d195 = undefined;
    }
    
    level callback::callback( "ash_end", { #zone_name:zone_name } );
}

// Namespace zm_sat_hornet_weather_ash
// Params 2
// Checksum 0xee976cd1, Offset: 0xf00
// Size: 0x109
function function_d8678c685a005f29( var_cfdcb332178e0755, b_disable_damage )
{
    if ( !level.ash_root.var_c6edc8acdc76dbbc )
    {
        return;
    }
    
    foreach ( zone_name in var_cfdcb332178e0755 )
    {
        zone_name = function_fbb7d4c98261e273( zone_name );
        
        if ( b_disable_damage )
        {
            level.ash_root.var_222db28c0bf0a5ff = arraycombineunique( level.ash_root.var_222db28c0bf0a5ff, [ zone_name ] );
        }
        
        level.ash_root.var_110f8886053692a9 = arraycombineunique( level.ash_root.var_110f8886053692a9, [ zone_name ] );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x8372c67f, Offset: 0x1011
// Size: 0xf1
function function_91ad74da91af1982( var_cfdcb332178e0755 )
{
    if ( !level.ash_root.var_c6edc8acdc76dbbc )
    {
        return;
    }
    
    foreach ( zone_name in var_cfdcb332178e0755 )
    {
        zone_name = function_fbb7d4c98261e273( zone_name );
        level.ash_root.var_110f8886053692a9 = arrayremove( level.ash_root.var_110f8886053692a9, zone_name );
        level.ash_root.var_222db28c0bf0a5ff = arrayremove( level.ash_root.var_222db28c0bf0a5ff, zone_name );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0xa2c6b492, Offset: 0x110a
// Size: 0x1f, Type: bool
function function_989fd2b3918fb9da()
{
    if ( level.ash_root.var_110f8886053692a9.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0xd858ffe4, Offset: 0x1132
// Size: 0x15
function function_8928ea3a422bbcaf()
{
    return level.ash_root.var_110f8886053692a9;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x9703d0bd, Offset: 0x1150
// Size: 0x2b
function function_209997c5345ab152( zone_name )
{
    zone_name = function_fbb7d4c98261e273( zone_name );
    
    if ( zm_sat_hornet_assault_rounds::function_bb933b778292b564( zone_name ) )
    {
        return;
    }
    
    function_502a6d0994562459( zone_name );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x59a7a8c0, Offset: 0x1183
// Size: 0x4c
function function_5dde27d39fd118f8( var_87886397e909c08b )
{
    assert( isarray( var_87886397e909c08b ), "<dev string:x24>" );
    level.ash_root.a_zone_override = arraycombineunique( level.ash_root.a_zone_override, var_87886397e909c08b );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xd3b81696, Offset: 0x11d7
// Size: 0x4c
function function_47a5488a0aa46868( var_87886397e909c08b )
{
    assert( isarray( var_87886397e909c08b ), "<dev string:x56>" );
    level.ash_root.a_zone_override = arrayremove( level.ash_root.a_zone_override, var_87886397e909c08b );
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0x30bdf94a, Offset: 0x122b
// Size: 0x17
function function_e70ef2bcaeeb4818()
{
    level.ash_root.a_zone_override = [];
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xe9f56300, Offset: 0x124a
// Size: 0x22
function function_6adf58aedf42ac94( wait_override )
{
    level.ash_root.wait_override = wait_override;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0x62405d4a, Offset: 0x1274
// Size: 0x15
function function_fd4a6b44da66d985()
{
    level.ash_root.wait_override = undefined;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0xec620677, Offset: 0x1291
// Size: 0x15
function function_e707f195e72929f7()
{
    return level.ash_root.var_2245d9bc57b3af88;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xa1b33395, Offset: 0x12af
// Size: 0x37
function is_zone_in_ash( zone_name )
{
    if ( !zone_name )
    {
        return 0;
    }
    
    zone_name = function_fbb7d4c98261e273( zone_name );
    return arraycontains( level.ash_root.var_110f8886053692a9, zone_name );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xe1485c36, Offset: 0x12ef
// Size: 0x52
function function_35ed61636451860f( zone )
{
    gen_zone_name = function_fbb7d4c98261e273( zone );
    level.ash_root.var_9ce4eb0e965d3383 = arraycombineunique( level.ash_root.var_9ce4eb0e965d3383, [ gen_zone_name ] );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x560a42b2, Offset: 0x1349
// Size: 0x79
function function_a0ca938f7360747e( zone )
{
    gen_zone_name = function_fbb7d4c98261e273( zone );
    level.ash_root.var_9ce4eb0e965d3383 = arrayremove( level.ash_root.var_9ce4eb0e965d3383, gen_zone_name );
    
    if ( isdefined( gen_zone_name ) && arraycontains( level.ash_root.var_110f8886053692a9, gen_zone_name ) )
    {
        function_502a6d0994562459( gen_zone_name );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x2adbbb2a, Offset: 0x13ca
// Size: 0x2e
function set_ash_paused( b_is_paused )
{
    if ( b_is_paused )
    {
        level utility::flag_set( "pause_ambient_ash" );
        return;
    }
    
    level utility::flag_clear( "pause_ambient_ash" );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x2993cd8a, Offset: 0x1400
// Size: 0x9c
function ash_paused( params )
{
    level utility::flag_set( "pause_ambient_ash" );
    var_cfdcb332178e0755 = function_8928ea3a422bbcaf();
    
    foreach ( zone_name in var_cfdcb332178e0755 )
    {
        level function_502a6d0994562459( zone_name );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0x5a08a07e, Offset: 0x14a4
// Size: 0xa6
function ash_unpaused( params )
{
    var_cfdcb332178e0755 = zm_sat_hornet_assault_rounds::function_cd788a98271f8ae();
    
    foreach ( zone_name in var_cfdcb332178e0755 )
    {
        if ( zm_sat_hornet_assault_rounds::function_bb933b778292b564( zone_name ) )
        {
            function_6f9a9c8f4f91f3a4( zone_name );
        }
    }
    
    level utility::flag_clear( "pause_ambient_ash" );
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0xe126ab5f, Offset: 0x1552
// Size: 0x12b
function private function_46247889fc02e4a2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        random_duration = randomintrange( 10, 13 );
        level thread function_3266b3d84fd5054c();
        seconds_scalar = getdvarint( @"hash_4c7d3a34bdc1720f", 60 );
        function_b4cd6594bf96b6a6( random_duration * seconds_scalar );
        function_7db00b2776b59c87();
        zone_name = function_b2d2de925469e422();
        zone_name = function_fbb7d4c98261e273( zone_name );
        level.ash_root.var_9458277376443720 = 1;
        var_bd114e85d25ea21 = function_3eb6284f0040cc23( zone_name );
        
        if ( !var_bd114e85d25ea21 )
        {
            continue;
        }
        
        function_6f9a9c8f4f91f3a4( zone_name );
        level.ash_root.var_261a5841db6c1515 = zone_name;
        ash_duration = function_9618619ab04e15f1();
        wait ash_duration * seconds_scalar;
        function_502a6d0994562459( zone_name );
        level.ash_root.var_2245d9bc57b3af88 = level.ash_root.var_261a5841db6c1515;
        level.ash_root.var_261a5841db6c1515 = undefined;
        level notify( #"hash_d8b18c7935a7018" );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xc1f366f2, Offset: 0x1685
// Size: 0x78
function private function_b4cd6594bf96b6a6( wait_seconds )
{
    num_ticks = wait_seconds / 30;
    
    for ( i = 0; i < num_ticks ; i++ )
    {
        time_elapsed = i * 30;
        
        if ( level.ash_root.wait_override && level.ash_root.wait_override <= time_elapsed )
        {
            return;
        }
        
        wait 30;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0xc
// Checksum 0x28cf831e, Offset: 0x1705
// Size: 0x1ab
function private function_3266b3d84fd5054c()
{
    self notify( #"hash_7663d47adf91efd3" );
    self endon( #"hash_7663d47adf91efd3" );
    level endon( #"game_ended" );
    level.ash_root.a_zones_visited = [];
    level.ash_root.var_2c92dba8e5cbdbe0 = 0;
    
    while ( true )
    {
        function_7db00b2776b59c87();
        
        foreach ( player in level.players )
        {
            zone = player zone_manager::get_current_zone();
            
            if ( isdefined( zone.script_zone_name ) && isdefined( level.ash_root.a_zones_visited[ zone.script_zone_name ] ) )
            {
                level.ash_root.a_zones_visited[ zone.script_zone_name ]++;
                level.ash_root.var_2c92dba8e5cbdbe0++;
                continue;
            }
            
            if ( isdefined( zone.script_zone_name ) )
            {
                level.ash_root.a_zones_visited[ zone.script_zone_name ] = 1;
                level.ash_root.var_2c92dba8e5cbdbe0++;
            }
        }
        
        frequency = getdvarint( @"hash_efad4704e186f32a", 30 );
        wait frequency;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0xa20858e7, Offset: 0x18b8
// Size: 0x2e4
function private function_b2d2de925469e422()
{
    if ( level.ash_root.a_zone_override.size > 0 )
    {
        zone_name = utility::array_random( level.ash_root.a_zone_override );
        return zone_name;
    }
    
    total = level.ash_root.var_2c92dba8e5cbdbe0;
    
    if ( total > 0 )
    {
        foreach ( zone_name, num_visits in level.ash_root.a_zones_visited )
        {
            if ( num_visits / total > 0.5 && !function_3ced0ba772b3d4a3( zone_name ) && !function_656f09008aa80736( zone_name ) && !is_zone_in_ash( zone_name ) )
            {
                return zone_name;
            }
        }
        
        if ( level.ash_root.var_2c92dba8e5cbdbe0 > 0 )
        {
            var_ad430148a3718ad6 = randomint( level.ash_root.var_2c92dba8e5cbdbe0 );
            var_109bb2233d55aae3 = 0;
            
            foreach ( zone_name, num_visits in level.ash_root.a_zones_visited )
            {
                var_109bb2233d55aae3 += num_visits;
                
                if ( var_ad430148a3718ad6 < var_109bb2233d55aae3 )
                {
                    if ( !function_3ced0ba772b3d4a3( zone_name ) && !function_656f09008aa80736( zone_name ) && !is_zone_in_ash( zone_name ) )
                    {
                        return zone_name;
                    }
                }
            }
        }
    }
    
    var_ff5a5087b9a12730 = zone_manager::get_enabled_zones();
    zone = utility::array_random( var_ff5a5087b9a12730 );
    
    if ( function_3ced0ba772b3d4a3( zone.script_zone_name ) || is_zone_in_ash( zone.script_zone_name ) )
    {
        foreach ( alt_zone in var_ff5a5087b9a12730 )
        {
            if ( !function_3ced0ba772b3d4a3( alt_zone.script_zone_name ) && !is_zone_in_ash( alt_zone.script_zone_name ) )
            {
                return alt_zone.script_zone_name;
            }
        }
    }
    
    return zone.script_zone_name;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xbe0b621, Offset: 0x1ba5
// Size: 0x3a, Type: bool
function private function_656f09008aa80736( zone_name )
{
    if ( !level.ash_root.var_9458277376443720 )
    {
        if ( arraycontains( [ "zone_main_keep" ], zone_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x87ff0d94, Offset: 0x1be8
// Size: 0x81, Type: bool
function private function_3ced0ba772b3d4a3( zone_name )
{
    if ( !level utility::flag( "ar_active" ) || !level.ar_root.current_sector )
    {
        return false;
    }
    
    gen_zone_name = function_fbb7d4c98261e273( zone_name );
    var_e50080547879e440 = zm_sat_hornet_assault_rounds::function_7ef58899cffe2533( level.ar_root.current_sector );
    
    if ( gen_zone_name && arraycontains( var_e50080547879e440, gen_zone_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x95e76c4f, Offset: 0x1c72
// Size: 0x118
function private function_76950327dedc71a2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            zone = player zone_manager::get_current_zone();
            var_c6f009a0bd81d68d = function_daf6a34790090dfa( player, level.ash_root.var_110f8886053692a9, zone.script_zone_name );
            
            if ( var_c6f009a0bd81d68d && !player.b_in_ash )
            {
                player function_a2a66d232a119aa7( zone.script_zone_name );
                continue;
            }
            
            if ( !var_c6f009a0bd81d68d && player.b_in_ash )
            {
                player function_d824e1781fea47b8();
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xbb5881dc, Offset: 0x1d92
// Size: 0x140
function private function_303d28f6d20b3329( zone_name )
{
    level endon( #"game_ended" );
    level endon( "sh_" + zone_name + "_end" );
    level endon( "sh_" + zone_name + "_fissure_end" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            zone = player zone_manager::get_current_zone();
            var_6a1d3ff72a5518a1 = issubstr( zone.script_zone_name, zone_name );
            
            if ( var_6a1d3ff72a5518a1 && !player.var_f55d3825cd68fedd )
            {
                player.var_f55d3825cd68fedd = zone_name;
                player function_86a814df0be96c3b();
                continue;
            }
            
            if ( !var_6a1d3ff72a5518a1 && player.var_f55d3825cd68fedd == zone_name )
            {
                player.var_f55d3825cd68fedd = undefined;
                player function_d824e1781fea47b8();
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x30fecd79, Offset: 0x1eda
// Size: 0x9e
function private function_d670d08a3999a23b( zone_name )
{
    foreach ( player in level.players )
    {
        if ( player.var_f55d3825cd68fedd )
        {
            player.var_f55d3825cd68fedd = undefined;
            player function_d824e1781fea47b8();
        }
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x8a2d2d77, Offset: 0x1f80
// Size: 0x54
function private function_fbb7d4c98261e273( zone_name )
{
    var_93d84a67723d6fe6 = strtok( zone_name, "_" );
    
    if ( var_93d84a67723d6fe6.size > 3 )
    {
        generalized_zone_name = var_93d84a67723d6fe6[ 0 ] + "_" + var_93d84a67723d6fe6[ 1 ] + "_" + var_93d84a67723d6fe6[ 2 ];
        return generalized_zone_name;
    }
    
    return zone_name;
}

// Namespace zm_sat_hornet_weather_ash
// Params 3, eflags: 0x4
// Checksum 0x63349e01, Offset: 0x1fdd
// Size: 0x95, Type: bool
function private function_daf6a34790090dfa( player, var_64501d816aa4e5d9, var_77898ab40e53d0ae )
{
    foreach ( ash_zone in var_64501d816aa4e5d9 )
    {
        if ( issubstr( var_77898ab40e53d0ae, ash_zone ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x97357ef1, Offset: 0x207b
// Size: 0x24
function private function_7db00b2776b59c87()
{
    while ( level utility::flag( "pause_ambient_ash" ) )
    {
        level utility::flag_waitopen( "pause_ambient_ash" );
        wait 30;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0x2e17a2cf, Offset: 0x20a7
// Size: 0x43
function function_9618619ab04e15f1()
{
    n_round = zm_utility::get_round_number();
    
    if ( n_round >= 100 )
    {
        return 4;
    }
    else if ( n_round >= 50 )
    {
        return 3.25;
    }
    else if ( n_round >= 30 )
    {
        return 2.5;
    }
    
    return 2;
}

// Namespace zm_sat_hornet_weather_ash
// Params 2, eflags: 0x4
// Checksum 0x389a6c44, Offset: 0x20f3
// Size: 0xe1
function private function_60aff241085c1187( origin, zone_name )
{
    level endon( #"game_ended" );
    level endon( "sh_" + zone_name + "_end" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player thread function_e396e905ca6f16be( origin, zone_name );
            player function_1424d4f7ff5404c5( 0.13, 0.1, 0.06, 27, origin, 512, 1024, 2048 );
        }
        
        wait 27;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 2, eflags: 0x4
// Checksum 0x74e80026, Offset: 0x21dc
// Size: 0xa7
function private function_e396e905ca6f16be( origin, zone_name )
{
    self endon( #"death_or_disconnect" );
    poll_len = 0.5;
    counter = 0;
    middle_rad_sq = 1048576;
    
    while ( counter < 27 )
    {
        dist_to_point = distancesquared( self.origin, origin );
        
        if ( dist_to_point < middle_rad_sq )
        {
            self playrumblelooponentity( "low_highfreq" );
        }
        else
        {
            self stoprumble( "low_highfreq" );
        }
        
        counter += poll_len;
        wait poll_len;
    }
    
    self stoprumble( "low_highfreq" );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xf5a4f195, Offset: 0x228b
// Size: 0x78
function private function_afd81c852e0dbb38( zone_name )
{
    level endon( #"game_ended" );
    level endon( "sh_" + zone_name + "_end" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent ) && !self.var_496fe6f4a03bd689 )
        {
            self.var_496fe6f4a03bd689 = 1;
            thread function_e6c1d4dab51d2665( ent, zone_name );
        }
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 2, eflags: 0x4
// Checksum 0x1b940ea6, Offset: 0x230b
// Size: 0xa8
function private function_e6c1d4dab51d2665( player, zone_name )
{
    level endon( #"game_ended" );
    level endon( "sh_" + zone_name + "_end" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( zm_player::function_f37cfdf04b932a03( player ) && player istouching( self ) )
        {
            player dodamage( 15, player.origin, level.ash_root.e_attacker );
            player shellshock( %"frag_grenade_mp", 4, 0 );
            wait 2;
            continue;
        }
        
        self.var_496fe6f4a03bd689 = undefined;
        return;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x805fef9a, Offset: 0x23bb
// Size: 0xe7
function private function_a2a66d232a119aa7( zone_name )
{
    self.b_in_ash = 1;
    self.var_7663a13406e7fef1 = undefined;
    self playrumbleonentity( "damage_heavy" );
    pbgpostfxbundleend( self, %"hash_490b633fdb71bfcd" );
    pbgpostfxbundlestart( self, %"sat_zm_ash" );
    
    if ( !self.ismutantinjection && !self.isjuggernaut )
    {
        self setscriptablepartstate( "hornet_ash_vfx", "on", 0 );
    }
    
    zone_name = function_fbb7d4c98261e273( zone_name );
    
    if ( !isdefined( self.var_d850a8005d90a474 ) )
    {
        self.var_d850a8005d90a474 = arraycontains( level.ash_root.var_222db28c0bf0a5ff, zone_name );
    }
    
    setglobalsoundcontext( "zm_hornet_ash_storm", zone_name, undefined, self );
    
    if ( !self.var_d850a8005d90a474 )
    {
        musicbank_utility::function_386364349468bbb3( #"hash_28ff547165b70790" );
    }
    
    thread function_ae8a3b2f44969511();
    thread function_98b58622894448ea();
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x94888dae, Offset: 0x24aa
// Size: 0x48
function private function_86a814df0be96c3b()
{
    self playrumbleonentity( "damage_light" );
    pbgpostfxbundlestart( self, %"hash_490b633fdb71bfcd" );
    
    if ( !self.ismutantinjection && !self.isjuggernaut )
    {
        self setscriptablepartstate( "hornet_ash_vfx", "tell", 0 );
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x1666e8c, Offset: 0x24fa
// Size: 0xb7
function private function_d824e1781fea47b8()
{
    setglobalsoundcontext( "zm_hornet_ash_storm", "off", undefined, self );
    
    if ( !self.var_d850a8005d90a474 )
    {
        musicbank_utility::function_386364349468bbb3( #"zm_sat_hornet" );
    }
    
    self.var_d850a8005d90a474 = undefined;
    pbgpostfxbundleend( self, %"sat_zm_ash" );
    pbgpostfxbundleend( self, %"hash_490b633fdb71bfcd" );
    
    if ( !self.ismutantinjection && !self.isjuggernaut )
    {
        self setscriptablepartstate( "hornet_ash_vfx", "off", 0 );
        self setscriptablepartstate( "hornet_ash_vfx", "out", 0 );
    }
    
    self notify( #"ash_ended" );
    val::reset_all( "in_ash" );
    self.b_in_ash = undefined;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x54a9c5f6, Offset: 0x25b9
// Size: 0x95
function private function_ae8a3b2f44969511()
{
    self endon( #"ash_ended" );
    self endon( #"death_or_disconnect" );
    wait 4;
    
    while ( true )
    {
        wait 1;
        
        if ( !self.var_d850a8005d90a474 && !is_environmentalist_active() )
        {
            var_4e00ee8d01ee7fa3 = 3;
            
            if ( zm_utility::get_round_number() < 30 )
            {
                var_4e00ee8d01ee7fa3 = 2;
            }
            
            self dodamage( var_4e00ee8d01ee7fa3, self.origin, level.ash_root.e_attacker, undefined, "MOD_SUICIDE", "<explicitweaponnone>", "none", undefined, 2 );
        }
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x6b17574c, Offset: 0x2656
// Size: 0x16c
function private function_98b58622894448ea()
{
    self endon( #"ash_ended" );
    self endon( #"death_or_disconnect" );
    initial_wait = randomfloatrange( 2, 4 );
    wait initial_wait;
    
    while ( true )
    {
        if ( !self.var_89ff21882a827bae && !is_environmentalist_active() && !is_using_gobblegum() && !utility::ent_flag( "dark_flare_active" ) && !self isremotecontrolling() && !self.ismutantinjection && !self.isjuggernaut )
        {
            current_weapon = self getcurrentweapon();
            
            if ( current_weapon && current_weapon != level.weaponnone && !self.has_cage && !self.has_cat && current_weapon.basename != "sat_ks_compound_mp" )
            {
                self canceloffhands();
                self releaseoffhand();
                self stopanimscriptsceneevent();
                self stopgestureviewmodel();
                
                if ( self isviewmodelanimplaying() )
                {
                    self stopviewmodelanim();
                }
                
                self forceplaygestureviewmodel( "iw9_ges_gas_cough" );
                ges_started = 1;
            }
            
            function_aec9657d510f9486();
            thread kill_player_sprint( 1.6 );
            random_wait = randomfloatrange( 8, 10 );
            wait random_wait;
            
            if ( ges_started )
            {
                self stopgestureviewmodel( "iw9_ges_gas_cough" );
            }
            
            continue;
        }
        
        random_wait = randomfloatrange( 2, 4 );
        wait random_wait;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x4186c3fa, Offset: 0x27ca
// Size: 0x4b
function private kill_player_sprint( wait_duration )
{
    self endon( #"death_or_disconnect" );
    val::set( "in_ash", "sprint", 0 );
    val::set( "in_ash", "supersprint", 0 );
    wait wait_duration;
    val::reset_all( "in_ash" );
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x9574ead1, Offset: 0x281d
// Size: 0xe5
function private function_aec9657d510f9486()
{
    if ( level utility::flag( "player_banter_playing" ) || player_banter::function_4e1aff6241ebea8() )
    {
        return;
    }
    
    if ( overlord::function_5b9a94f0c7f2bb5b() || overlord::function_2a4336a2a72f769c() )
    {
        return;
    }
    
    b_played_banter = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_ash_take_damage" );
    
    if ( b_played_banter )
    {
        return;
    }
    
    if ( operator::isfemale() )
    {
        cough_amount = game[ "dialogue" ][ "allies_female_cough" ].size;
        current_cough = randomint( cough_amount );
        soundalias = game[ "dialogue" ][ "allies_female_cough" ][ current_cough ];
    }
    else
    {
        cough_amount = game[ "dialogue" ][ "allies_male_cough" ].size;
        current_cough = randomint( cough_amount );
        soundalias = game[ "dialogue" ][ "allies_male_cough" ][ current_cough ];
    }
    
    self playsoundtoplayer( "gas_player_cough", self, self );
    self playsoundtoteam( soundalias, self.team, self, self );
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x99398497, Offset: 0x290a
// Size: 0x38, Type: bool
function private is_environmentalist_active()
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && self issprintsliding() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x62ba74bb, Offset: 0x294b
// Size: 0xb
function private is_using_gobblegum()
{
    return self.var_44c8fd4fb28eb652;
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0x3b0036c2, Offset: 0x295f
// Size: 0x8, Type: bool
function private is_using_field_upgrade()
{
    return zm_quest::function_9b18c35fba5c3d31();
}

// Namespace zm_sat_hornet_weather_ash
// Params 0, eflags: 0x4
// Checksum 0xc1df53a4, Offset: 0x2970
// Size: 0x255
function private function_23209fdefd8f349f()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_sat_hornet_weather_create_script_completed" );
    a_waypoints = utility::getstructarray( "cb_waypoint" );
    var_1aa58ef0445ed42a = [];
    
    foreach ( waypoint in a_waypoints )
    {
        if ( waypoint.target && !var_1aa58ef0445ed42a[ waypoint.target ] )
        {
            var_1aa58ef0445ed42a[ waypoint.target ] = [ waypoint ];
            continue;
        }
        
        if ( var_1aa58ef0445ed42a[ waypoint.target ] )
        {
            var_1aa58ef0445ed42a[ waypoint.target ][ var_1aa58ef0445ed42a[ waypoint.target ].size ] = waypoint;
        }
    }
    
    all_zones = getarraykeys( var_1aa58ef0445ed42a );
    
    foreach ( zone in all_zones )
    {
        ordered_array = [ 0, 0, 0, 0, 0, 0, 0, 0 ];
        
        foreach ( waypoint in var_1aa58ef0445ed42a[ zone ] )
        {
            order_num = waypoint.script_noteworthy;
            ordered_array[ int( order_num ) - 1 ] = waypoint;
        }
        
        var_1aa58ef0445ed42a[ zone ] = ordered_array;
    }
    
    level.ash_root.var_1aa58ef0445ed42a = var_1aa58ef0445ed42a;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1
// Checksum 0xff13faca, Offset: 0x2bcd
// Size: 0x13d
function function_17c9d94eccb26376( zone_name )
{
    level endon( "sh_" + zone_name + "_end" );
    center_waypoint = undefined;
    var_6568991131b921b1 = undefined;
    current_waypoint = undefined;
    
    foreach ( waypoint in level.ash_root.var_1aa58ef0445ed42a[ zone_name ] )
    {
        current_waypoint = waypoint;
        spawn_waypoint( waypoint );
        var_6568991131b921b1 = function_1d1b5d39f825c4e3( waypoint.origin, 32, 64 );
        current_waypoint = undefined;
        function_cfb7404f232d93dc( waypoint );
        
        if ( var_6568991131b921b1 )
        {
            var_6568991131b921b1 playsoundtoplayer( "evt_success_stinger", var_6568991131b921b1 );
        }
        
        center_waypoint = level.ash_root.var_1aa58ef0445ed42a[ zone_name ][ level.ash_root.var_1aa58ef0445ed42a[ zone_name ].size - 2 ];
    }
    
    level thread complete_purification( zone_name, center_waypoint, var_6568991131b921b1 );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xf1ea9b9d, Offset: 0x2d12
// Size: 0x30
function private spawn_waypoint( s_waypoint )
{
    s_waypoint.sbl = spawnscriptable( %"hash_763aae4ac2105177", s_waypoint.origin );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x772632b, Offset: 0x2d4a
// Size: 0x27
function private function_cfb7404f232d93dc( s_waypoint )
{
    s_waypoint.sbl freescriptable();
    s_waypoint.sbl = undefined;
}

// Namespace zm_sat_hornet_weather_ash
// Params 3
// Checksum 0xe15f571f, Offset: 0x2d79
// Size: 0x8e
function function_1d1b5d39f825c4e3( origin, radius, height = undefined )
{
    level endon( #"game_ended" );
    prox_trigger = spawn( "noent_volume_trigger_rotatable_radius", origin, 0, radius, height );
    
    while ( true )
    {
        prox_trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent ) && ent function_a153d005cc1fc4bc() )
        {
            prox_trigger delete();
            return ent;
        }
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 0
// Checksum 0xcf695633, Offset: 0x2e0f
// Size: 0x1d, Type: bool
function function_a153d005cc1fc4bc()
{
    var_8df8a9a80fce4a3 = health_overcharge::get_player_health_overcharge( "near_skr" );
    return var_8df8a9a80fce4a3 > 0;
}

// Namespace zm_sat_hornet_weather_ash
// Params 3, eflags: 0x4
// Checksum 0x6d81389d, Offset: 0x2e35
// Size: 0xa3
function private complete_purification( zone_name, s_center_waypoint, player )
{
    function_502a6d0994562459( zone_name );
    purify_sbl = spawnscriptable( %"zm_sat_hornet_oth_trail", s_center_waypoint.origin, s_center_waypoint.angles );
    purify_sbl setscriptablepartstate( "visual", "tian" );
    purify_sbl utility::delaycall( 5, &freescriptable );
    player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    wait 2.5;
    zm_sat_hornet_weather_sakura::function_9af3e00cc4771e5( player );
    level notify( "sh_" + zone_name + "_cl" );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xa991c186, Offset: 0x2ee0
// Size: 0x177
function private on_exfil_started( sparams )
{
    level endon( #"game_ended" );
    level endon( #"exfil_failed" );
    level utility::flag_set( "pause_ambient_ash" );
    level utility::flag_wait( "exfil_active" );
    var_2c35e1f3da109a5e = level.s_zm_exfil.var_2c35e1f3da109a5e;
    
    while ( !var_2c35e1f3da109a5e )
    {
        var_2c35e1f3da109a5e = level.s_zm_exfil.var_2c35e1f3da109a5e;
        wait 0.25;
    }
    
    if ( !var_2c35e1f3da109a5e.size )
    {
        return;
    }
    
    var_c48e22b7bbfb6ac7 = [];
    
    foreach ( exfil_zone in var_2c35e1f3da109a5e )
    {
        exfil_zone = function_fbb7d4c98261e273( exfil_zone );
        
        if ( !arraycontains( level.ash_root.var_110f8886053692a9, exfil_zone ) )
        {
            continue;
        }
        
        if ( level.ash_root.var_261a5841db6c1515 == exfil_zone )
        {
            function_502a6d0994562459( exfil_zone );
            level.ash_root.var_261a5841db6c1515 = undefined;
            continue;
        }
        
        function_502a6d0994562459( exfil_zone );
        var_c48e22b7bbfb6ac7[ var_c48e22b7bbfb6ac7.size ] = exfil_zone;
    }
    
    level thread function_8ff3011620f1a902( var_c48e22b7bbfb6ac7 );
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xba2a242a, Offset: 0x305f
// Size: 0xaf
function private function_8ff3011620f1a902( var_c48e22b7bbfb6ac7 )
{
    level endon( #"game_ended" );
    level utility::flag_waitopen( "exfil_active" );
    level utility::flag_clear( "pause_ambient_ash" );
    
    foreach ( zone_name in var_c48e22b7bbfb6ac7 )
    {
        if ( function_ef793db5a9ca214d( zone_name ) )
        {
            function_6f9a9c8f4f91f3a4( zone_name );
        }
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x71fff7bb, Offset: 0x3116
// Size: 0x138, Type: bool
function private function_ef793db5a9ca214d( zone_name )
{
    if ( !level.ar_root || !level.ar_root.var_35233896c682d3ea )
    {
        return false;
    }
    
    foreach ( var_e917a56fdbc933d8 in level.ar_root.var_35233896c682d3ea )
    {
        var_717cd3d37211f99c = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
        
        foreach ( sector_zone in var_717cd3d37211f99c )
        {
            if ( function_fbb7d4c98261e273( sector_zone ) == zone_name )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x675281d5, Offset: 0x3257
// Size: 0xa4
function private function_7ef58899cffe2533( var_e917a56fdbc933d8 )
{
    switch ( var_e917a56fdbc933d8 )
    {
        case #"hash_4a3f2b24bb25e893":
            return [ "zone_west_bailey", "zone_broken_turrets" ];
        case #"hash_4a3f2c24bb25ea26":
            return [ "zone_lava_tubes", "zone_third_bailey" ];
        case #"hash_4a3f2d24bb25ebb9":
            return [ "zone_lava_garden", "zone_second_bailey" ];
        case #"hash_4a3f2e24bb25ed4c":
            return [ "zone_main_bailey", "zone_main_keep" ];
        default:
            return [];
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x4cebc7ef, Offset: 0x3303
// Size: 0x46, Type: bool
function private function_3eb6284f0040cc23( zone )
{
    gen_zone_name = function_fbb7d4c98261e273( zone );
    
    if ( gen_zone_name && arraycontains( level.ash_root.var_9ce4eb0e965d3383, gen_zone_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0xce68d53f, Offset: 0x3352
// Size: 0xce
function private function_e0ee2ac72585867c( zone_name )
{
    switch ( zone_name )
    {
        case #"hash_4650e8a67fbfcb73":
            return "we_vfx_ash_2ndbailey";
        case #"hash_a77d2285bb702858":
            return "we_vfx_ash_3rdbailey";
        case #"hash_903a5c034eb5e6b9":
            return "we_vfx_ash_brokenturrets";
        case #"hash_97ed6ef0fe9821f3":
            return "we_vfx_ash_castle";
        case #"hash_cb60019c2ae8e5e":
            return "we_vfx_ash_lavagarden";
        case #"hash_c28edce4e7606f36":
            return "we_vfx_ash_lavatubes";
        case #"hash_e8f6d9298dd0504c":
            return "we_vfx_ash_mainbailey";
        case #"hash_d5e7630614fde63a":
            return "we_vfx_ash_westbailey";
        default:
            return;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 2, eflags: 0x4
// Checksum 0xb1088181, Offset: 0x3428
// Size: 0x17a
function private function_b7abeb217c303763( zone_name, var_c31641ff8c12a51c )
{
    level endon( "sh_" + zone_name + "_end" );
    
    if ( !isdefined( level.ash_root.var_8df87ec7768fe92[ zone_name ] ) )
    {
        level.ash_root.var_8df87ec7768fe92[ zone_name ] = [];
    }
    
    foreach ( i, sbl in var_c31641ff8c12a51c )
    {
        var_3017d07087bdb6c1 = level.var_a74764204d9643c;
        level.var_a74764204d9643c = undefined;
        obj_name = "fsr_obj_" + zone_name + "_" + i;
        objid = zm_quest::function_b98d4144845ffc13( obj_name, 0, "sat_ui_icon_zm_fissure", undefined, "active", sbl.origin, 0, &"hash_187e4cb56583d013", undefined, 0, 0 );
        
        if ( isdefined( objid ) )
        {
            level.ash_root.var_8df87ec7768fe92[ zone_name ][ level.ash_root.var_8df87ec7768fe92[ zone_name ].size ] = objid;
            level thread function_7c1046f794c56dac( objid, zone_name );
        }
        
        level.var_a74764204d9643c = var_3017d07087bdb6c1;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 2, eflags: 0x4
// Checksum 0xc00f9d00, Offset: 0x35aa
// Size: 0x73
function private function_7c1046f794c56dac( objid, zone_name )
{
    level endon( "sh_" + zone_name + "_end" );
    function_6d950100aec1d712( objid, 1 );
    objective_settint( objid, 255, 0, 0 );
    
    while ( true )
    {
        function_caa27562d30d9b57( objid, 1, 0, 0.5 );
        function_caa27562d30d9b57( objid, 0, 1, 0.5 );
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 4, eflags: 0x4
// Checksum 0x6796e465, Offset: 0x3625
// Size: 0x87
function private function_caa27562d30d9b57( objid, source_alpha, target_alpha, duration_seconds )
{
    if ( duration_seconds <= 0 )
    {
        function_6d950100aec1d712( objid, target_alpha );
        return;
    }
    
    step = ( target_alpha - source_alpha ) / duration_seconds * level.framedurationseconds;
    alpha = source_alpha;
    
    while ( alpha != target_alpha )
    {
        alpha = clamp( alpha + step, 0, 1 );
        function_6d950100aec1d712( objid, alpha );
        waitframe();
    }
}

// Namespace zm_sat_hornet_weather_ash
// Params 1, eflags: 0x4
// Checksum 0x87754a02, Offset: 0x36b4
// Size: 0xc4
function private cleanup_fissure_objectives( zone_name )
{
    if ( !isdefined( level.ash_root.var_8df87ec7768fe92[ zone_name ] ) )
    {
        return;
    }
    
    foreach ( objid in level.ash_root.var_8df87ec7768fe92[ zone_name ] )
    {
        zm_quest::complete_objective_waypoints( objid );
    }
    
    level.ash_root.var_8df87ec7768fe92[ zone_name ] = undefined;
}

/#

    // Namespace zm_sat_hornet_weather_ash
    // Params 0, eflags: 0x4
    // Checksum 0x3926a909, Offset: 0x3780
    // Size: 0x60, Type: dev
    function private function_8f6f8570fbd3c2ab()
    {
        devgui::function_9082edeb5db93280( "<dev string:x8b>" );
        devgui::add_devgui_func( "<dev string:xa2>", "<dev string:xb8>", &debug_start_ash, 1 );
        devgui::add_devgui_func( "<dev string:xc1>", "<dev string:xd5>", &function_fe508e36994d4d58, 1 );
        devgui::add_devgui_func( "<dev string:xdc>", "<dev string:xec>", &function_4e4e0e2bd90b8843, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_weather_ash
    // Params 0, eflags: 0x4
    // Checksum 0xc341ed21, Offset: 0x37e8
    // Size: 0x53, Type: dev
    function private debug_start_ash()
    {
        player = level.players[ 0 ];
        zone = player zone_manager::get_current_zone();
        zone_name = function_fbb7d4c98261e273( zone.script_zone_name );
        level thread function_6f9a9c8f4f91f3a4( zone_name );
    }

    // Namespace zm_sat_hornet_weather_ash
    // Params 0, eflags: 0x4
    // Checksum 0xbbfd8e6c, Offset: 0x3843
    // Size: 0x52, Type: dev
    function private function_fe508e36994d4d58()
    {
        player = level.players[ 0 ];
        zone = player zone_manager::get_current_zone();
        zone_name = function_fbb7d4c98261e273( zone.script_zone_name );
        function_502a6d0994562459( zone_name );
    }

    // Namespace zm_sat_hornet_weather_ash
    // Params 0, eflags: 0x4
    // Checksum 0x894f7a6b, Offset: 0x389d
    // Size: 0x10f, Type: dev
    function private function_4e4e0e2bd90b8843()
    {
        var_c507babffa8153f6 = getentitylessscriptablearray( "<dev string:xf3>", "<dev string:xfb>" );
        
        if ( !isdefined( level.ash_root.var_2cf6eb896c5ca51a ) )
        {
            level.ash_root.var_2cf6eb896c5ca51a = 1;
        }
        
        foreach ( fissure in var_c507babffa8153f6 )
        {
            if ( level.ash_root.var_2cf6eb896c5ca51a )
            {
                fissure setscriptablepartstate( "<dev string:x10d>", "<dev string:x110>" );
                fissure setscriptablepartstate( "<dev string:x117>", "<dev string:x110>" );
                continue;
            }
            
            fissure setscriptablepartstate( "<dev string:x10d>", "<dev string:x11c>" );
            fissure setscriptablepartstate( "<dev string:x117>", "<dev string:x11c>" );
        }
    }

#/
