// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_blizzard.gsc  (hash_02cfff77311f25e2.gscc) (size: 26505 Bytes / 0x6789 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa60f22b (2858480171)
// size ...... 26505 (0x6789)
// includes .. 17  (offset: 0x620d)
// strings ... 57  (offset: 0x6295)
// dev strs .. 39  (offset: 0x65a1)
// exports ... 64  (offset: 0x4285)
// cseg ...... 0x5ae + 0x3cd7 (0x4285)
// imports ... 173 (offset: 0x4c85)
// animtree1 . 0   (offset: 0x6789)
// animtree2 . 0   (offset: 0x6789)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_frost;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\mp\common\field_upgrades\field_upgrades_dark_flare;
#using scripts\mp\common\field_upgrades\field_upgrades_wiley_fox;
#using scripts\mp\content_manager;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_blizzard;

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x5
// Checksum 0xab27f818, Offset: 0x5cc
// Size: 0x1bb
function private autoexec init()
{
    level callback::add( "special_round_start", &function_39c330fe4210d14e );
    utility::registersharedfunc( #"zm_blizzard", #"add_zone", &function_f5d56c71c57dc9b );
    utility::registersharedfunc( #"zm_blizzard", #"remove_zone", &function_c190990973087ae8 );
    utility::registersharedfunc( #"zm_blizzard", #"freeze_player", &freeze_player );
    utility::registersharedfunc( #"zm_blizzard", #"hash_6bb3b928d432c637", &function_9832a7fb908e4fe );
    utility::registersharedfunc( #"zm_blizzard", #"hash_f95768c13efc10ab", &function_7aa7c5776ec76360 );
    utility::registersharedfunc( #"zm_blizzard", #"set_freeze_movespeed", &set_freeze_movespeed );
    utility::registersharedfunc( #"zm_blizzard", #"freeze_world", &function_7d4f65bb9faac025 );
    utility::registersharedfunc( #"zm_blizzard", #"unfreeze_world", &function_2c8f99c347b1e4e9 );
    utility::registersharedfunc( #"zm_blizzard", #"freeze_feature", &function_b1bd1edee49ff376 );
    utility::registersharedfunc( #"zm_blizzard", #"unfreeze_feature", &function_24495b723936c85 );
    utility::registersharedfunc( #"zm_blizzard", #"is_exposed", &function_5b5fb74cc380d3dc );
    init_blizzard_data();
    level callback::add( #"player_connect", &zm_sat_locust_blizzard_on_player_connect );
    
    if ( getdvarint( @"hash_8802468c392734e", 1 ) )
    {
        level callback::add( "on_ascender_attach", &on_ascender_attached );
        level callback::add( "on_ascender_detach", &on_ascender_detached );
    }
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0xdaa56c18, Offset: 0x78f
// Size: 0x1c6
function private init_blizzard_data()
{
    level.blizzard_data = {};
    utility::flag_wait( "zm_round_spawning_init_data_done" );
    level._effect[ "scrnfx_special_round" ] = loadfxasset( "vfx_sat_gameplay_zm_camera_special_round_white" );
    level._effect[ "special_round_cam_vfx" ] = loadfxasset( "vfx_sat_special_round_transition_white_camera" );
    volume_zones = getnoentvolumearray( "blizzard_volume_zone", #targetname );
    forced_zones = [ "zone_start_middle":1, "zone_shipyard_warehouse_2":0, "zone_shipyard_warehouse":0, "zone_shipyard_shore":1, "zone_robot_shoulder":1, "zone_robot_head":0, "zone_lighthouse_int_puzzle_3":1, "zone_lighthouse_int_puzzle":1, "zone_foundry_factory_control_room":0, "zone_foundry_factory":0, "zone_bridge_2":1, "zone_bridge":1 ];
    values = [ #"hash_cb8015cc7cc37466":getdvarfloat( @"hash_c3c5c24031b1a6d5", 0.2 ), #"hash_d134198c691e465c":getdvarfloat( @"hash_542e8b4f28e0da4b", 2 ), #"hash_d460406e7f624f9":getdvarfloat( @"hash_ecf4a000f428f852", 0.03 ), #"hash_84b3bdcd6d969fbd":getdvarfloat( @"hash_86cce3aefad5221a", 0.75 ), #"hash_5ebcef68a1aead71":getdvarint( @"hash_6419325db5e21ba7", 0 ) ];
    level.blizzard_data.volume_zones = volume_zones;
    level.blizzard_data.forced_zones = forced_zones;
    level.blizzard_data.values = values;
    level.blizzard_data.freeze_count = 0;
    init_core_features();
    init_banters();
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x36c4aed1, Offset: 0x95d
// Size: 0x102
function private init_core_features()
{
    function_83eb5fd6191c8c0e( "ammo_cache", [ 2, 3, 5 ], &function_22851968e771debf );
    function_83eb5fd6191c8c0e( "arsenal", [ 1 ], &function_7e590a38f4b10486 );
    function_83eb5fd6191c8c0e( "crafting_table", [ 1, 1, 2 ], &function_8e4bb64a4c4856ad );
    function_83eb5fd6191c8c0e( "magicbox", [ 1 ], &function_2032980fc601670c );
    function_83eb5fd6191c8c0e( "pack_a_punch", [ 1 ], &function_d6051ca0c67d57de );
    function_83eb5fd6191c8c0e( "perk_machine", [ 2, 3, 5 ], &function_3084024691a6e082 );
    function_83eb5fd6191c8c0e( "perk_machine_choice", [ 1 ], &function_8356d02f91930684 );
    
    if ( level.blizzard_data.values[ #"hash_5ebcef68a1aead71" ] > 0 )
    {
        level callback::add( "on_round_end", &function_8df385fb029de938 );
    }
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x2afc177c, Offset: 0xa67
// Size: 0x1d
function private init_banters()
{
    register_banter( #"freeze_effort", #"hash_f2bd36f485ab1cbd", 60 );
}

// Namespace zm_sat_locust_blizzard
// Params 3, eflags: 0x4
// Checksum 0x4e5a70d5, Offset: 0xa8c
// Size: 0xc0
function private register_banter( key, var_d9a98ad3b14f016a, cooldown )
{
    data = { #var_2cda4fec82ac854c:0, #cooldown:cooldown, #var_d9a98ad3b14f016a:var_d9a98ad3b14f016a, #key:key };
    
    if ( !isdefined( level.blizzard_data.var_fedd688ef0bf69fb ) )
    {
        level.blizzard_data.var_fedd688ef0bf69fb = [];
    }
    
    assert( !level.blizzard_data.var_fedd688ef0bf69fb[ key ], "<dev string:x24>" + key );
    level.blizzard_data.var_fedd688ef0bf69fb[ key ] = data;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xac681e41, Offset: 0xb54
// Size: 0x16
function private zm_sat_locust_blizzard_on_player_connect( sparams )
{
    self.was_frozen = 0;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x1ee56789, Offset: 0xb72
// Size: 0xd2
function private function_39c330fe4210d14e( sparams )
{
    if ( getdvarint( @"hash_5699596ff3c0e8c1", 0 ) )
    {
        return;
    }
    
    var_35341ea5d550fb12 = getdvarint( @"hash_5f73ed646f0e1ce2", 0 );
    
    if ( var_35341ea5d550fb12 > sparams.roundnumber )
    {
        return;
    }
    
    logstring( "[BLIZZARD ROUND] STARTING Time: " + gettime() + " | Round: " + sparams.roundnumber + " | Zombie Count: " + zm_round_spawning::function_ad358cbb8158789e( sparams.roundnumber ) + " | Player Count: " + level.players.size );
    level callback::add( "on_round_end", &function_e2fa2e6724f28816 );
    function_7d4f65bb9faac025();
    
    if ( level.var_a009ab14ee0d3223.var_90e1d244c1410109[ "frost_zombie_special_round" ] > 0 )
    {
        core_features_freeze();
    }
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x8ac33f0d, Offset: 0xc4c
// Size: 0x6f
function private function_e2fa2e6724f28816( sparams )
{
    level callback::remove( "on_round_end", &function_e2fa2e6724f28816 );
    logstring( "[BLIZZARD ROUND] ENDING Time: " + gettime() + " | Round: " + sparams.roundnumber + " | Zombie Count: " + zm_round_spawning::function_ad358cbb8158789e( sparams.roundnumber ) + " | Player Count: " + level.players.size );
    function_2c8f99c347b1e4e9();
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x3bc54f77, Offset: 0xcc3
// Size: 0xb2
function private function_9bb8d69a37513b3e()
{
    level endon( #"end_game" );
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        self waittill( #"spawned_player" );
    }
    
    if ( !isdefined( self.struct_snow ) )
    {
        self.struct_snow = spawnstruct();
    }
    
    self.struct_snow.var_3dea366373c34bee = 0;
    self.struct_snow.var_88f2dce2a5d30478 = 0;
    self.struct_snow.var_c27513c8e6407695 = 0;
    utility::function_32b24db3127bff40( #"snow_fx", #"off" );
    function_7aa7c5776ec76360( 1, 1 );
}

// Namespace zm_sat_locust_blizzard
// Params 1
// Checksum 0x941ef924, Offset: 0xd7d
// Size: 0x88
function function_7d4f65bb9faac025( set_context = 1 )
{
    level.blizzard_data.freeze_count++;
    
    if ( set_context )
    {
        setglobalsoundcontext( "zm_locust_special_round", "active" );
    }
    
    if ( utility::flag( "freeze_on" ) )
    {
        return;
    }
    
    level callback::add( #"player_spawned", &on_player_spawned );
    utility::flag_set( "freeze_on" );
    utility::array_thread( level.players, &function_c519edb0cfab417c, 2.5 );
}

// Namespace zm_sat_locust_blizzard
// Params 2
// Checksum 0xed8c665a, Offset: 0xe0d
// Size: 0xd8
function function_2c8f99c347b1e4e9( set_context = 1, delay = 1 )
{
    if ( level.blizzard_data.freeze_count == 0 )
    {
        return;
    }
    
    level.blizzard_data.freeze_count--;
    
    if ( level.blizzard_data.freeze_count == 0 )
    {
        level callback::remove( #"player_spawned", &on_player_spawned );
        level notify( #"hash_b3ec603b1609e51d" );
        utility::flag_clear( "freeze_on" );
        
        if ( delay >= level.framedurationseconds )
        {
            wait delay;
        }
        
        utility::array_thread( level.players, &function_9bb8d69a37513b3e );
    }
    
    if ( set_context )
    {
        setglobalsoundcontext( "zm_locust_special_round", "defazult" );
    }
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x6799727a, Offset: 0xeed
// Size: 0x2d
function private on_player_spawned( params )
{
    if ( level.var_6781718da4f78d1c.state != 2 )
    {
        return;
    }
    
    thread function_c519edb0cfab417c();
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0xc
// Checksum 0xa5befc74, Offset: 0xf22
// Size: 0xe8
function private function_c519edb0cfab417c( delay )
{
    self notify( #"hash_2dc26276fe3791b9" );
    self endon( #"hash_2dc26276fe3791b9" );
    level endon( #"end_game" );
    level endon( #"hash_b3ec603b1609e51d" );
    self endon( #"death_or_disconnect" );
    
    if ( delay >= level.framedurationseconds )
    {
        wait delay;
    }
    
    if ( !isalive( self ) )
    {
        self waittill( #"spawned_player" );
    }
    
    while ( utility::flag( "freeze_on" ) )
    {
        if ( function_5b5fb74cc380d3dc() )
        {
            if ( self.struct_snow.var_88f2dce2a5d30478 / 1000 >= level.blizzard_data.values[ #"hash_d134198c691e465c" ] )
            {
                freeze_player();
            }
        }
        else
        {
            function_9832a7fb908e4fe();
            
            if ( self usebuttonpressed() )
            {
                function_5b5fb74cc380d3dc();
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_locust_blizzard
// Params 0
// Checksum 0xbfd49d00, Offset: 0x1012
// Size: 0xb9
function freeze_player()
{
    self notify( #"hash_3304a09353281f2" );
    self endon( #"hash_3304a09353281f2" );
    self.was_frozen = 1;
    
    if ( !status_effects::function_fa35fc2723e956eb( "frost", "snow_player_freeze" ) )
    {
        play_player_banter( #"freeze_effort", self );
    }
    
    set_freeze_movespeed( level.blizzard_data.values[ #"hash_d460406e7f624f9" ], level.blizzard_data.values[ #"hash_84b3bdcd6d969fbd" ] );
    
    /#
        if ( getdvarint( @"hash_ab586629fb0936fa", 0 ) )
        {
            return;
        }
    #/
    
    utility::function_32b24db3127bff40( #"snow_fx", #"on" );
}

// Namespace zm_sat_locust_blizzard
// Params 0
// Checksum 0xf83477f2, Offset: 0x10d3
// Size: 0x65
function function_9832a7fb908e4fe()
{
    self notify( #"hash_5e41075aa9ce6551" );
    self endon( #"hash_5e41075aa9ce6551" );
    function_7aa7c5776ec76360( level.blizzard_data.values[ #"hash_cb8015cc7cc37466" ], 1 );
    
    if ( effect_frost::is_frosted() )
    {
        utility::function_32b24db3127bff40( #"snow_fx", #"off" );
    }
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x9e3d4988, Offset: 0x1140
// Size: 0x557
function private function_5b5fb74cc380d3dc()
{
    is_player = isplayer( self );
    is_ent = isent( self );
    
    if ( !isdefined( self.struct_snow ) )
    {
        self.struct_snow = spawnstruct();
        self.struct_snow.var_3dea366373c34bee = 0;
        self.struct_snow.var_88f2dce2a5d30478 = 0;
        self.struct_snow.var_5aae62573bee1948 = 0;
        
        if ( !is_player )
        {
            self.struct_snow.zone = undefined;
        }
    }
    
    var_3856332840049750 = undefined;
    
    if ( !isdefined( var_3856332840049750 ) && is_player && utility::callsharedfunc( #"locust_ww", #"hash_5f2e6769ea79096e" ) )
    {
        var_3856332840049750 = 0;
    }
    
    if ( !isdefined( var_3856332840049750 ) && is_player )
    {
        if ( utility::ent_flag( "blizzard_immune" ) )
        {
            var_3856332840049750 = 0;
        }
    }
    
    if ( !isdefined( var_3856332840049750 ) && is_player )
    {
        if ( utility::ent_flag( "wiley_fox_active" ) )
        {
            var_3856332840049750 = 0;
        }
    }
    
    if ( !isdefined( var_3856332840049750 ) && is_ent && isdefined( level.blizzard_data.volume_zones ) )
    {
        foreach ( zone in level.blizzard_data.volume_zones )
        {
            if ( self istouching( zone ) )
            {
                var_3856332840049750 = zone.struct.script_int ?? zone.script_int;
                break;
            }
        }
    }
    
    if ( !isdefined( var_3856332840049750 ) && is_player && self isonzipline() )
    {
        var_3856332840049750 = 1;
    }
    
    if ( !isdefined( var_3856332840049750 ) )
    {
        if ( is_ent )
        {
            zone = zone_manager::get_current_zone( 0, 1 );
        }
        else
        {
            zone = zone_manager::function_90e5c3e2272b0130( self.origin );
        }
        
        if ( !isdefined( zone ) )
        {
            offset = 75;
            origin = self.origin + anglestoleft( self.angles ) * offset;
            zone = zone_manager::function_90e5c3e2272b0130( origin );
            
            if ( !isdefined( zone ) )
            {
                origin = self.origin + anglestoforward( self.angles ) * offset;
                zone = zone_manager::function_90e5c3e2272b0130( origin );
            }
            
            if ( !isdefined( zone ) )
            {
                origin = self.origin + anglestoright( self.angles ) * offset;
                zone = zone_manager::function_90e5c3e2272b0130( origin );
            }
        }
        
        if ( isdefined( level.blizzard_data.forced_zones[ zone.zone_name ] ) )
        {
            var_3856332840049750 = level.blizzard_data.forced_zones[ zone.zone_name ];
        }
        
        if ( !is_player )
        {
            assert( isdefined( zone ) );
            self.struct_snow.zone = zone;
        }
    }
    
    if ( !isdefined( var_3856332840049750 ) )
    {
        var_bf9861cb508aca6a = function_7801d05a86b06144( self.origin, 80, 0, 512, 8 );
        startroomindex = var_bf9861cb508aca6a[ 0 ].roomindex;
        
        foreach ( tacpoint in var_bf9861cb508aca6a )
        {
            if ( startroomindex && startroomindex != tacpoint.roomindex )
            {
                continue;
            }
            
            if ( tacpoint.var_6f9c4e415e80942f && tacpointexposedtosky( tacpoint, 0 ) )
            {
                var_3856332840049750 = 1;
                break;
            }
        }
    }
    
    if ( !isdefined( var_3856332840049750 ) )
    {
        if ( !ispointindoors( self.origin ) )
        {
            var_3856332840049750 = 1;
        }
    }
    
    /#
        if ( is_player && ( self isnoclip() || self isufo() ) )
        {
            var_3856332840049750 = self.struct_snow.var_3dea366373c34bee;
        }
    #/
    
    if ( !isdefined( var_3856332840049750 ) && is_player && var_bf9861cb508aca6a.size == 0 && self.struct_snow.var_3dea366373c34bee )
    {
        var_3856332840049750 = 1;
    }
    
    if ( var_3856332840049750 )
    {
        if ( !self.struct_snow.var_3dea366373c34bee )
        {
            self.struct_snow.var_3dea366373c34bee = 1;
            self.struct_snow.var_5aae62573bee1948 = gettime();
        }
        
        self.struct_snow.var_88f2dce2a5d30478 = gettime() - self.struct_snow.var_5aae62573bee1948;
        return 1;
    }
    else if ( self.struct_snow.var_3dea366373c34bee )
    {
        self.struct_snow.var_3dea366373c34bee = 0;
        self.var_49dceb0d3a42a66a = 0;
        self.struct_snow.var_5aae62573bee1948 = 0;
        return 0;
    }
    
    return self.struct_snow.var_3dea366373c34bee;
}

// Namespace zm_sat_locust_blizzard
// Params 2
// Checksum 0xc026a20c, Offset: 0x16a0
// Size: 0xcf
function set_freeze_movespeed( step_change = level.blizzard_data.values[ #"hash_d460406e7f624f9" ], min_movespeed = level.blizzard_data.values[ #"hash_84b3bdcd6d969fbd" ] )
{
    if ( !isdefined( self.var_e5996377e9a13e32[ "snow_player_freeze" ] ) )
    {
        new_scalar = 1 - step_change;
    }
    else
    {
        new_scalar = self.var_e5996377e9a13e32[ "snow_player_freeze" ] - step_change;
    }
    
    if ( new_scalar < min_movespeed )
    {
        new_scalar = min_movespeed;
    }
    
    if ( isalive( self ) )
    {
        /#
            if ( getdvarint( @"hash_d5629f422fb42d0b", 0 ) )
            {
                return;
            }
        #/
        
        effect_frost::frost( "snow_player_freeze", new_scalar );
    }
}

// Namespace zm_sat_locust_blizzard
// Params 3
// Checksum 0x86733a1a, Offset: 0x1777
// Size: 0xd3
function function_7aa7c5776ec76360( step_change = level.blizzard_data.values[ #"hash_cb8015cc7cc37466" ], max_movespeed = 1, var_8d338e57bff1de14 = 0 )
{
    if ( !isdefined( self.var_e5996377e9a13e32[ "snow_player_freeze" ] ) )
    {
        return;
    }
    else
    {
        new_scalar = self.var_e5996377e9a13e32[ "snow_player_freeze" ] + step_change;
    }
    
    if ( new_scalar > max_movespeed )
    {
        new_scalar = max_movespeed;
    }
    
    if ( new_scalar >= max_movespeed && !var_8d338e57bff1de14 )
    {
        effect_frost::stop_frost( "snow_player_freeze" );
        return;
    }
    
    if ( isalive( self ) )
    {
        new_scalar = min( new_scalar, max_movespeed );
        effect_frost::frost( "snow_player_freeze", new_scalar );
    }
}

// Namespace zm_sat_locust_blizzard
// Params 1
// Checksum 0xfd4614b4, Offset: 0x1852
// Size: 0x64
function function_f5d56c71c57dc9b( zone )
{
    assert( isdefined( zone ) );
    assert( !arraycontains( level.blizzard_data.volume_zones, zone ) );
    level.blizzard_data.volume_zones[ level.blizzard_data.volume_zones.size ] = zone;
}

// Namespace zm_sat_locust_blizzard
// Params 1
// Checksum 0x719e3c5, Offset: 0x18be
// Size: 0x65
function function_c190990973087ae8( zone )
{
    assert( isdefined( zone ) );
    assert( arraycontains( level.blizzard_data.volume_zones, zone ) );
    level.blizzard_data.volume_zones = arrayremove( level.blizzard_data.volume_zones, zone );
}

// Namespace zm_sat_locust_blizzard
// Params 5, eflags: 0x4
// Checksum 0xc8570864, Offset: 0x192b
// Size: 0x149
function private function_83eb5fd6191c8c0e( type, counts, on_validate, on_freeze, on_unfreeze )
{
    if ( !isdefined( level.blizzard_data.core_features ) )
    {
        level.blizzard_data.core_features = {};
    }
    
    if ( !isdefined( level.blizzard_data.core_features.freeze_type ) )
    {
        level.blizzard_data.core_features.freeze_type = [];
    }
    
    if ( !isdefined( level.blizzard_data.core_features.frozen ) )
    {
        level.blizzard_data.core_features.frozen = [];
    }
    
    level.blizzard_data.core_features.frozen[ type ] = [];
    level.blizzard_data.core_features.freeze_type[ type ] = { #counts:counts, #on_unfreeze:on_unfreeze, #on_freeze:on_freeze, #on_validate:on_validate };
}

// Namespace zm_sat_locust_blizzard
// Params 2
// Checksum 0x789d10ee, Offset: 0x1a7c
// Size: 0x3a
function function_552908a89853a9b0( feature, type )
{
    return arraycontains( level.blizzard_data.core_features.frozen[ type ], feature );
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x5e52bff4, Offset: 0x1abf
// Size: 0x9a
function private function_6dd48b8aeadb285c()
{
    count = 0;
    
    foreach ( arr in level.blizzard_data.core_features.frozen )
    {
        count += arr.size;
    }
    
    return count;
}

// Namespace zm_sat_locust_blizzard
// Params 0, eflags: 0x4
// Checksum 0x1d18a7cb, Offset: 0x1b62
// Size: 0x9c
function private core_features_freeze()
{
    profilestart();
    
    foreach ( type, data in level.blizzard_data.core_features.freeze_type )
    {
        function_6e0869914c401b2d( type, data.counts );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_blizzard
// Params 3, eflags: 0x4
// Checksum 0x97b4c3e2, Offset: 0x1c06
// Size: 0x3de
function private function_6e0869914c401b2d( type, counts, position )
{
    valid_features = [];
    features = function_fd842def0a3fa624( type );
    
    foreach ( feature in features )
    {
        if ( [[ level.blizzard_data.core_features.freeze_type[ type ].on_validate ]]( feature ) )
        {
            valid_features[ valid_features.size ] = feature;
        }
    }
    
    /#
        debug_enabled = getdvarint( @"hash_69e6f131ff1fd48e", 0 );
        
        if ( debug_enabled )
        {
            excluded_features = arrayremove( features, valid_features );
            
            foreach ( feature in excluded_features )
            {
                debug::sphere( feature, 32, ( 1, 0, 0 ), 60, "<dev string:x3f>" );
            }
        }
    #/
    
    if ( valid_features.size == 0 )
    {
        return;
    }
    
    var_ba1e50a3fe722430 = function_6733ec537a6e870d( counts );
    
    /#
        frozen_features = [];
    #/
    
    if ( position )
    {
        valid_features = function_628bac9faa9d1e86( valid_features, position );
    }
    else
    {
        valid_features = arrayrandomize( valid_features );
    }
    
    foreach ( feature in valid_features )
    {
        if ( !level.blizzard_data.core_features.frozen[ type ] || level.blizzard_data.core_features.frozen[ type ].size < var_ba1e50a3fe722430 )
        {
            function_b1bd1edee49ff376( feature, type );
            
            /#
                frozen_features[ frozen_features.size ] = feature;
            #/
        }
    }
    
    /#
        if ( debug_enabled )
        {
            var_cd92863d86217bbb = arrayremove( valid_features, frozen_features );
            
            foreach ( feature in var_cd92863d86217bbb )
            {
                debug::sphere( feature, 32, ( 1, 1, 0 ), 60, "<dev string:x3f>" );
            }
            
            foreach ( feature in frozen_features )
            {
                debug::sphere( feature, 32, ( 0, 1, 0 ), 60, "<dev string:x3f>" );
            }
            
            println( "<dev string:x52>" + type + "<dev string:x5a>" + var_ba1e50a3fe722430 + "<dev string:x69>" + frozen_features.size + "<dev string:x75>" + var_cd92863d86217bbb.size + "<dev string:x8d>" + valid_features.size + "<dev string:xa0>" + features.size );
        }
    #/
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0x811a9d00, Offset: 0x1fec
// Size: 0x54, Type: bool
function private function_36bf91b09b833cfd( feature, type )
{
    if ( ![[ level.blizzard_data.core_features.freeze_type[ type ].on_validate ]]( feature ) )
    {
        return false;
    }
    
    function_b1bd1edee49ff376( feature, type );
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0x17fe6c66, Offset: 0x2049
// Size: 0x11d, Type: bool
function private function_2d6d59027ecb07f3( type, position )
{
    profilestart();
    features = function_fd842def0a3fa624( type );
    
    if ( position )
    {
        features = function_628bac9faa9d1e86( level.blizzard_data.core_features.feature_type[ type ], position );
    }
    
    foreach ( feature in features )
    {
        if ( !level.blizzard_data.core_features.frozen[ type ] || !arraycontains( level.blizzard_data.core_features.frozen[ type ], feature ) )
        {
            if ( function_36bf91b09b833cfd( feature, type ) )
            {
                profilestop();
                return true;
            }
        }
    }
    
    profilestop();
    return false;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x1874d6b2, Offset: 0x2170
// Size: 0xe1, Type: bool
function private function_22851968e771debf( feature )
{
    if ( !isdefined( feature.ammocache_trigger ) )
    {
        return false;
    }
    
    ammocache = feature.ammocache_trigger;
    
    if ( !isdefined( ammocache.struct_snow ) )
    {
        ammocache function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( ammocache.var_d8e3b07237845727 ) && ammocache.var_d8e3b07237845727.size > 0 );
    
    if ( ammocache.var_94d1ab5da995e573 || !ammocache.struct_snow.var_3dea366373c34bee || !ammocache.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xd7cb95a6, Offset: 0x225a
// Size: 0xf8, Type: bool
function private function_7e590a38f4b10486( feature )
{
    if ( !isdefined( feature.mdl_arsenal ) )
    {
        return false;
    }
    
    sbl_arsenal = feature.mdl_arsenal.interact;
    s_arsenal = feature;
    
    if ( !isdefined( s_arsenal.struct_snow ) )
    {
        s_arsenal function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( sbl_arsenal.var_d8e3b07237845727 ) && sbl_arsenal.var_d8e3b07237845727.size > 0 );
    
    if ( !s_arsenal.var_5929513b9515fde7 || !s_arsenal.struct_snow.var_3dea366373c34bee || !s_arsenal.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x2f58e6c4, Offset: 0x235b
// Size: 0x104, Type: bool
function private function_8e4bb64a4c4856ad( feature )
{
    if ( !isdefined( feature.var_7fac639c5e7fd54 ) )
    {
        return false;
    }
    
    crafting_table = feature.var_7fac639c5e7fd54;
    
    if ( !isdefined( crafting_table.struct_snow ) )
    {
        crafting_table function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( crafting_table.interact.var_d8e3b07237845727 ) && crafting_table.interact.var_d8e3b07237845727.size > 0 );
    
    if ( crafting_table.interact getscriptablepartstate( "usable" ) == "off" || !crafting_table.struct_snow.var_3dea366373c34bee || !crafting_table.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x7b3c0d7e, Offset: 0x2468
// Size: 0x11f, Type: bool
function private function_2032980fc601670c( feature )
{
    if ( !isdefined( feature.mdl_magicbox ) )
    {
        return false;
    }
    
    mdl_magicbox = feature.mdl_magicbox;
    
    if ( !isdefined( mdl_magicbox.struct_snow ) )
    {
        mdl_magicbox function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( mdl_magicbox.interact.var_d8e3b07237845727 ) && mdl_magicbox.interact.var_d8e3b07237845727.size > 0 );
    
    if ( !feature.var_f14b2b4820b635e7 || !feature.var_9870f882980ab31b || !mdl_magicbox.struct_snow.var_3dea366373c34bee || mdl_magicbox.struct_snow.zone && !mdl_magicbox.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xcbd82e04, Offset: 0x2590
// Size: 0xee, Type: bool
function private function_d6051ca0c67d57de( feature )
{
    if ( !isdefined( feature.var_370acb837a3a86c3 ) )
    {
        return false;
    }
    
    s_pap = feature;
    var_370acb837a3a86c3 = feature.var_370acb837a3a86c3;
    
    if ( !isdefined( var_370acb837a3a86c3.struct_snow ) )
    {
        var_370acb837a3a86c3 function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( var_370acb837a3a86c3.var_d8e3b07237845727 ) && var_370acb837a3a86c3.var_d8e3b07237845727.size > 0 );
    
    if ( !s_pap.var_1c9754ecd2f9d888 || !var_370acb837a3a86c3.struct_snow.var_3dea366373c34bee || !var_370acb837a3a86c3.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x7d095841, Offset: 0x2687
// Size: 0xe7, Type: bool
function private function_3084024691a6e082( feature )
{
    if ( !isdefined( feature.mdl_perk_machine ) )
    {
        return false;
    }
    
    perk_machine = feature.mdl_perk_machine;
    
    if ( !isdefined( perk_machine.struct_snow ) )
    {
        perk_machine function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( perk_machine.var_d8e3b07237845727 ) && perk_machine.var_d8e3b07237845727.size > 0 );
    
    if ( perk_machine getscriptablepartstate( "base" ) == "power_off" || !perk_machine.struct_snow.var_3dea366373c34bee || !perk_machine.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x90328fb0, Offset: 0x2777
// Size: 0xfa, Type: bool
function private function_8356d02f91930684( feature )
{
    assert( feature.is_wunderfizz );
    
    if ( !isdefined( feature.mdl_perk_machine ) )
    {
        return false;
    }
    
    perk_machine = feature.mdl_perk_machine;
    
    if ( !isdefined( perk_machine.struct_snow ) )
    {
        perk_machine function_5b5fb74cc380d3dc();
    }
    
    if ( feature.freeze_protect )
    {
        feature.freeze_protect = 0;
        return false;
    }
    
    assert( isdefined( perk_machine.var_d8e3b07237845727 ) && perk_machine.var_d8e3b07237845727.size > 0 );
    
    if ( perk_machine getscriptablepartstate( "base" ) == "power_off" || !perk_machine.struct_snow.var_3dea366373c34bee || !perk_machine.struct_snow.zone.is_enabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xaeb5d160, Offset: 0x287a
// Size: 0x210
function private function_fd842def0a3fa624( type )
{
    if ( level.var_1bc31921d079dc44[ type ] )
    {
        features = [];
        
        foreach ( feature in level.var_f301c0b95ea728e2 )
        {
            if ( feature.targetname == type )
            {
                features[ features.size ] = feature;
            }
        }
    }
    else if ( type == "exfil" )
    {
        features = level.s_zm_exfil.var_c7cfc464905e7bcd;
    }
    else
    {
        assert( isdefined( level.contentmanager.spawnedinstances[ type ] ) && isdefined( "<dev string:xb3>" + type ) );
        instances = level.contentmanager.spawnedinstances[ type ];
        assert( instances.size == 1, "<dev string:xdb>" + type + "<dev string:x109>" + instances.size );
        instance = instances[ 0 ];
        var_dcd011e2d015ea36 = getarraykeys( instance.var_1d6cddfc47031bff );
        assert( var_dcd011e2d015ea36.size == 1, "<dev string:x110>" + var_dcd011e2d015ea36.size + "<dev string:x13b>" + type );
        group_key = var_dcd011e2d015ea36[ 0 ];
        features = content_manager::get_content_struct_array( instance, group_key );
    }
    
    level.blizzard_data.core_features.feature_type[ type ] = features;
    assert( level.blizzard_data.core_features.feature_type[ type ] && level.blizzard_data.core_features.feature_type[ type ].size > 0 );
    return features;
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0xe6e80234, Offset: 0x2a93
// Size: 0x139
function private function_b1bd1edee49ff376( feature, type )
{
    profilestart();
    content_manager::disable_feature( feature, type );
    
    if ( !isdefined( level.blizzard_data.core_features.frozen[ type ] ) )
    {
        level.blizzard_data.core_features.frozen[ type ] = [];
    }
    
    level.blizzard_data.core_features.frozen[ type ][ level.blizzard_data.core_features.frozen[ type ].size ] = feature;
    
    switch ( type )
    {
        case #"hash_afb7a15b602d9304":
            origin = feature.var_7fac639c5e7fd54.origin;
            angles = feature.var_7fac639c5e7fd54.angles;
            break;
        default:
            origin = feature.origin;
            angles = feature.angles;
            break;
    }
    
    feature thread function_9a3d31a8aa61be4c( origin, angles, type );
    profilestop();
}

// Namespace zm_sat_locust_blizzard
// Params 3, eflags: 0x4
// Checksum 0xeb3365be, Offset: 0x2bd4
// Size: 0x538
function private function_9a3d31a8aa61be4c( origin, angles, type )
{
    if ( type == "perk_machine" )
    {
        if ( self.script_noteworthy == "specialty_quickrevive" )
        {
            origin += anglestoforward( angles ) * 15;
        }
        
        if ( self.script_noteworthy == "specialty_d_mod" )
        {
            origin = origin + anglestoforward( angles ) * 13 + anglestoleft( angles ) * 7;
        }
        
        if ( self.script_noteworthy == "specialty_juggernog" )
        {
            origin += anglestoleft( angles ) * 5;
        }
    }
    else if ( type == "pack_a_punch" )
    {
        origin = origin - ( 0, 0, 3 ) + anglestoforward( angles ) * 15 + anglestoleft( angles ) * 4;
    }
    else if ( type == "perk_machine_choice" )
    {
        origin += anglestoforward( angles ) * 30;
    }
    else if ( type == "magicbox" )
    {
        origin -= ( 0, 0, 6 );
    }
    else if ( type == "ammo_cache" )
    {
        origin = origin - ( 0, 0, 8 ) + anglestoforward( angles ) * 3;
    }
    
    self.block = spawnscriptable( %"sat_zm_blocker_ice", ( round( origin[ 0 ] ), round( origin[ 1 ] ), round( origin[ 2 ] ) ), angleclamp180( angles ) );
    
    switch ( type )
    {
        case #"hash_931085bca905939f":
            state = function_d3f506778d83c0ac( self.script_noteworthy );
            self.block setscriptablepartstate( #"model", state );
            break;
        case #"hash_1336cb49eeae215b":
        case #"hash_e2bb00c8d8784ca1":
            self.block setscriptablepartstate( #"model", #"block_01" );
            break;
        case #"hash_5891c5d26e07968a":
            self.block setscriptablepartstate( #"model", #"block_03" );
            break;
        case #"hash_8d04d2dfe9bb6085":
            self.block setscriptablepartstate( #"model", #"block_04" );
            break;
        case #"hash_7c31479cf04292f":
        case #"hash_afb7a15b602d9304":
            self.block setscriptablepartstate( #"model", #"block_05" );
            break;
        case #"hash_9d0a476e90f0e5d7":
            if ( !isdefined( self.var_370acb837a3a86c3.var_e9bf98a002472909 ) )
            {
                self.var_370acb837a3a86c3.var_e9bf98a002472909 = 1.5;
            }
            
            self.block setscriptablepartstate( #"model", #"block_05" );
            break;
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    
    /#
        debug_round_number = getdvarint( @"hash_3b4a4ecb5ae10157", 0 );
        
        if ( debug_round_number > 0 )
        {
            debug_round_number = round_number;
        }
    #/
    
    self.block.health = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( "health_zombie_boss_virgil_ice_wall", round_number, 1 );
    self.block.maxhealth = self.block.health;
    self.block.var_af70f02bb9462edd = 1;
    self.block.var_436fc13baa7377d8 = 0;
    self.block.var_18d4007b123c953a = 0;
    self.block.ihittype = 3;
    field_upgrades_wiley_fox::add_manual_target( self.block );
    field_upgrades_dark_flare::add_manual_target( self.block );
    
    /#
        self.block thread function_dec84ce6ad017cbd();
    #/
    
    self.block.basearchetype = "none";
    self.block.elementalweakness = [ "fire":1 ];
    self.block.optional_params = { #min_damage_pct:getdvarfloat( @"hash_5b145f52334f3633", 0.45 ), #check_explosive:1 };
    self.block zm_damage::register_scriptable_damage_callback( &zm_sat_locust_util::function_2220168ba514a45f );
    self.block callback::add( #"hash_11e40a4909e138f7", &function_b324343d117c97b4 );
    self.block.feature = self;
    self.block.feature_type = type;
    self.block.round_data = { #startround:round_number };
    
    if ( level.blizzard_data.values[ #"hash_5ebcef68a1aead71" ] > 0 )
    {
        self.block.round_data.var_e38bbccf301df4fd = round_number + level.blizzard_data.values[ #"hash_5ebcef68a1aead71" ];
    }
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xf89843e2, Offset: 0x3114
// Size: 0xc0
function private function_d3f506778d83c0ac( type )
{
    switch ( type )
    {
        case #"hash_a05b09269a304697":
            return #"block_05";
        case #"hash_5b88c6956390309e":
        case #"hash_8ce81fd37af3e66b":
        case #"hash_903fa971f2027571":
        case #"hash_ad7ceb3a37ee891c":
            return #"block_01";
        case #"hash_4485ea5afc8ef4ec":
            return #"block_05";
        case #"hash_474f00cba8142b0b":
        case #"hash_8f7f900f28dfcf96":
            return #"block_02";
        case #"hash_47874f94af82bbae":
        case #"hash_8b9ba3dfc17ec0a4":
            return #"block_05";
    }
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xdcc051e8, Offset: 0x31dc
// Size: 0x255
function private function_b324343d117c97b4( params )
{
    profilestart();
    feature = self.feature;
    skip_salvage = callback::response( 1, #"hash_3e2eb4cb47f0d7b3", params );
    
    if ( !skip_salvage )
    {
        player_radius = 512;
        var_827e6c420604dd2 = %"itemspawnentry:zm_t10_item_salvage_green";
        itembundle = getscriptbundle( var_827e6c420604dd2 );
        
        if ( isplayer( params.eattacker ) || isplayer( params.einflictor ) )
        {
            angles = feature.angles;
            
            if ( self.feature_type != "magicbox" )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( feature );
            }
            else
            {
                angles += ( 0, 90, 0 );
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( feature.origin, angles );
            }
            
            spawnoptions.var_90cdc5dbcd319e5d = 1;
            spawnoptions.var_23d3495c57d61bdf = 1;
            nearbyplayers = getplayersinradius( feature.origin, player_radius );
            
            foreach ( player in nearbyplayers )
            {
                level thread utility::callsharedfunc( #"zombie", #"hash_26befc250486510c", feature.origin, angles, player );
            }
            
            itemcount = 1;
            
            for ( i = 0; i < itemcount ; i++ )
            {
                common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
            }
            
            if ( self.round_data.startround == zm_round_logic::get_rb_round_number() && !( params.damagetype == 0 || params.damagetype == 3 ) )
            {
                feature.freeze_protect = 1;
            }
        }
    }
    
    function_24495b723936c85( feature, self.feature_type );
    profilestop();
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x1e8725d5, Offset: 0x3439
// Size: 0x151
function private function_8df385fb029de938( params )
{
    profilestart();
    
    foreach ( type, data in level.blizzard_data.core_features.freeze_type )
    {
        foreach ( feature in level.blizzard_data.core_features.frozen[ type ] )
        {
            if ( params.roundnumber + params.var_e7c2c09903c13bf7 >= feature.var_7a82f7e6dfebeceb.var_e38bbccf301df4fd )
            {
                function_24495b723936c85( feature, type );
            }
        }
    }
    
    profilestop();
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x1118bc42, Offset: 0x3592
// Size: 0x75
function private function_6733ec537a6e870d( counts )
{
    if ( counts.size == 1 )
    {
        return counts[ 0 ];
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    
    /#
        override_round = getdvarint( @"hash_108fbcaeb3199642", 0 );
        
        if ( override_round > 0 )
        {
            return counts[ override_round - 1 ];
        }
    #/
    
    if ( round_number <= 15 )
    {
        return counts[ 0 ];
    }
    else if ( round_number <= 30 )
    {
        return counts[ 1 ];
    }
    
    return counts[ 2 ];
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0x11249262, Offset: 0x3610
// Size: 0x3e, Type: bool
function private function_9756134621149fa0( type, position )
{
    feature = function_d1927495c09577f9( type, position );
    
    if ( !feature )
    {
        return false;
    }
    
    function_24495b723936c85( feature, type );
    return true;
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0xda75c26f, Offset: 0x3657
// Size: 0x62
function private function_d1927495c09577f9( type, position )
{
    if ( position )
    {
        return function_b21056d585c710d( level.blizzard_data.core_features.frozen[ type ], position );
    }
    
    return level.blizzard_data.core_features.frozen[ type ][ 0 ];
}

// Namespace zm_sat_locust_blizzard
// Params 2, eflags: 0x4
// Checksum 0x9cf02dc, Offset: 0x36c2
// Size: 0xf4
function private function_24495b723936c85( feature, type )
{
    profilestart();
    content_manager::enable_feature( feature, type );
    assert( arraycontains( level.blizzard_data.core_features.frozen[ type ], feature ), "<dev string:x147>" );
    level.blizzard_data.core_features.frozen[ type ] = arrayremove( level.blizzard_data.core_features.frozen[ type ], feature );
    
    if ( feature.block )
    {
        feature.block setscriptablepartstate( #"effects", #"destroy" );
        feature.block utility::delaycall( level.framedurationseconds, &freescriptable );
    }
    
    feature notify( #"hash_cb34b0a726af3eac" );
    profilestop();
}

// Namespace zm_sat_locust_blizzard
// Params 3, eflags: 0x4
// Checksum 0xd14c6ec7, Offset: 0x37be
// Size: 0xef
function private play_player_banter( key, player, forced )
{
    if ( !isxhash( key ) )
    {
        key = getxhash( key );
    }
    
    data = level.blizzard_data.var_fedd688ef0bf69fb[ key ];
    assert( data, "<dev string:x170>" + key );
    
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    cooldown = data.cooldown;
    
    if ( utility::flag( "solo_game" ) )
    {
        cooldown *= 2;
    }
    
    if ( !forced )
    {
        if ( !utility::time_has_passed( data.var_2cda4fec82ac854c, cooldown ) )
        {
            return;
        }
    }
    
    data.var_2cda4fec82ac854c = gettime();
    
    if ( !player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( data.var_d9a98ad3b14f016a );
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0xf9310653, Offset: 0x38b5
// Size: 0x7a
function private on_ascender_attached( params )
{
    if ( level.blizzard_data.freeze_count == 0 )
    {
        return;
    }
    
    zone = zone_manager::get_current_zone();
    
    if ( zone.zone_name == "zone_foundry_north" || zone.zone_name == "zone_foundry_tower" )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( #"zipline_camera", #"camera_on_zm_sat_locust" );
}

// Namespace zm_sat_locust_blizzard
// Params 1, eflags: 0x4
// Checksum 0x60843f47, Offset: 0x3937
// Size: 0x25
function private on_ascender_detached( params )
{
    utility::function_32b24db3127bff40( #"zipline_camera", #"hash_2ea3f38b20cdbf80" );
}

/#

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0xe3ac02aa, Offset: 0x3964
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0xcbfe92b1, Offset: 0x3978
    // Size: 0x21, Type: dev
    function private devgui_init()
    {
        function_6e42f15e70425dd7();
        function_5bfc1e85e3bfc58f();
        function_5f2af39dfc983aac();
        function_643a518e1e651942();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0x404fe164, Offset: 0x39a1
    // Size: 0x14d, Type: dev
    function private function_6e42f15e70425dd7()
    {
        devgui::function_9082edeb5db93280( "<dev string:x18e>" );
        
        foreach ( type, data in level.blizzard_data.core_features.freeze_type )
        {
            devgui::function_cd4e263c1f3018ae( type, "<dev string:x1b0>" + type, &function_2aa10b4a6ee84cb7 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x1c3>" );
        
        foreach ( type, data in level.blizzard_data.core_features.freeze_type )
        {
            devgui::function_cd4e263c1f3018ae( type, "<dev string:x1e7>" + type, &function_ad632afdfed250e2 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0xf3b73ed5, Offset: 0x3af6
    // Size: 0x14d, Type: dev
    function private function_5bfc1e85e3bfc58f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1fc>" );
        
        foreach ( type, data in level.blizzard_data.core_features.freeze_type )
        {
            devgui::function_cd4e263c1f3018ae( type, "<dev string:x226>" + type, &function_448069d8c8b8de2f );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x241>" );
        
        foreach ( type, data in level.blizzard_data.core_features.freeze_type )
        {
            devgui::function_cd4e263c1f3018ae( type, "<dev string:x26d>" + type, &function_316f3275dbf2f5b2 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0x6bade183, Offset: 0x3c4b
    // Size: 0x7c, Type: dev
    function private function_5f2af39dfc983aac()
    {
        setdevdvarifuninitialized( @"hash_69e6f131ff1fd48e", 0, 0, 1 );
        setdevdvarifuninitialized( @"hash_108fbcaeb3199642", 0, 0, 4 );
        devgui::function_9082edeb5db93280( "<dev string:x28a>" );
        
        for ( i = 0; i < 4 ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( i == 0 ? "<dev string:x2a9>" : i, "<dev string:x2af>" + i, &function_8a588c294a5a1ced );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 1, eflags: 0x4
    // Checksum 0x407696a8, Offset: 0x3ccf
    // Size: 0x19, Type: dev
    function private function_2aa10b4a6ee84cb7( args )
    {
        function_da0dfd000b11ad52( args[ 0 ] );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 1, eflags: 0x4
    // Checksum 0x3de7f867, Offset: 0x3cf0
    // Size: 0x19, Type: dev
    function private function_ad632afdfed250e2( args )
    {
        function_992eb1ac8a362bb( args[ 0 ] );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 1, eflags: 0x4
    // Checksum 0x3163132f, Offset: 0x3d11
    // Size: 0x2e, Type: dev
    function private function_448069d8c8b8de2f( args )
    {
        function_da0dfd000b11ad52( args[ 0 ], level.players[ 0 ].origin );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 1, eflags: 0x4
    // Checksum 0x9060b1f0, Offset: 0x3d47
    // Size: 0x2e, Type: dev
    function private function_316f3275dbf2f5b2( args )
    {
        function_992eb1ac8a362bb( args[ 0 ], level.players[ 0 ].origin );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 2, eflags: 0x4
    // Checksum 0xf7739db3, Offset: 0x3d7d
    // Size: 0x66, Type: dev
    function private function_da0dfd000b11ad52( type, position )
    {
        result = function_2d6d59027ecb07f3( type, position );
        count = function_6dd48b8aeadb285c();
        iprintln( ( result ? "<dev string:x2c2>" : "<dev string:x2c8>" ) + "<dev string:x2d2>" + type + "<dev string:x2f9>" + count );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 2, eflags: 0x4
    // Checksum 0x12bb49f2, Offset: 0x3deb
    // Size: 0x66, Type: dev
    function private function_992eb1ac8a362bb( type, position )
    {
        result = function_9756134621149fa0( type, position );
        count = function_6dd48b8aeadb285c();
        iprintln( ( result ? "<dev string:x2c2>" : "<dev string:x2c8>" ) + "<dev string:x30c>" + type + "<dev string:x2f9>" + count );
    }

    // Namespace zm_sat_locust_blizzard
    // Params 1, eflags: 0x4
    // Checksum 0xdb2a0e8a, Offset: 0x3e59
    // Size: 0x1c7, Type: dev
    function private function_8a588c294a5a1ced( args )
    {
        val = int( args[ 0 ] );
        setdvar( @"hash_108fbcaeb3199642", val );
        level notify( #"hash_5f1c9ab6f2b0c5b7" );
        
        if ( val == 0 )
        {
            foreach ( type, features in level.blizzard_data.core_features.frozen )
            {
                foreach ( feature in features )
                {
                    function_24495b723936c85( feature, type );
                }
            }
            
            return;
        }
        
        foreach ( type, data in level.blizzard_data.core_features.freeze_type )
        {
            function_6e0869914c401b2d( type, data.counts );
        }
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0x20c08dd0, Offset: 0x4028
    // Size: 0x6e, Type: dev
    function private function_dec84ce6ad017cbd()
    {
        self endon( #"death" );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_69e6f131ff1fd48e", 0 ) )
            {
                debug::print3d( self, self.health + "<dev string:x335>" + self.maxhealth, ( 1, 1, 1 ), level.framedurationseconds, undefined, "<dev string:x337>", 1, 1, undefined );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0x2dc99086, Offset: 0x409e
    // Size: 0x68, Type: dev
    function private function_643a518e1e651942()
    {
        setdevdvarifuninitialized( @"hash_ab586629fb0936fa", 0, 0, 1 );
        setdevdvarifuninitialized( @"hash_d5629f422fb42d0b", 0, 0, 1 );
        devgui::function_9082edeb5db93280( "<dev string:x33d>" );
        devgui::add_devgui_func( "<dev string:x35c>", "<dev string:x36c>", &function_ff5c23262169352 );
        devgui::add_devgui_func( "<dev string:x385>", "<dev string:x396>", &function_8bf04211ecbc8443 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0x5107fc36, Offset: 0x410e
    // Size: 0xbe, Type: dev
    function private function_ff5c23262169352()
    {
        n_new = !getdvarint( @"hash_ab586629fb0936fa", 0 );
        setdvar( @"hash_ab586629fb0936fa", n_new );
        
        if ( n_new )
        {
            foreach ( player in level.players )
            {
                player utility::function_32b24db3127bff40( #"snow_fx", #"off" );
            }
        }
    }

    // Namespace zm_sat_locust_blizzard
    // Params 0, eflags: 0x4
    // Checksum 0xfd30ba9c, Offset: 0x41d4
    // Size: 0xb1, Type: dev
    function private function_8bf04211ecbc8443()
    {
        n_new = !getdvarint( @"hash_d5629f422fb42d0b", 0 );
        setdvar( @"hash_d5629f422fb42d0b", n_new );
        
        if ( n_new )
        {
            foreach ( player in level.players )
            {
                player effect_frost::stop_frost( "<dev string:x3b0>" );
            }
        }
    }

#/
