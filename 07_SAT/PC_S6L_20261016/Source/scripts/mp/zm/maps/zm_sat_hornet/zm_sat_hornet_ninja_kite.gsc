// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ninja_kite.gsc  (hash_2772e54ee9ef5c0e.gscc) (size: 21165 Bytes / 0x52ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x279a33e3 (664417251)
// size ...... 21165 (0x52ad)
// includes .. 19  (offset: 0x4bfd)
// strings ... 90  (offset: 0x4c95)
// dev strs .. 19  (offset: 0x51c9)
// exports ... 47  (offset: 0x3015)
// cseg ...... 0x76e + 0x28a7 (0x3015)
// imports ... 168 (offset: 0x376d)
// animtree1 . 0   (offset: 0x52ad)
// animtree2 . 0   (offset: 0x52ad)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ninja_kite_create_script;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_hornet_ninja_kite;

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x5
// Checksum 0x316ca903, Offset: 0x78c
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"ninja_kite", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x888fd310, Offset: 0x7b1
// Size: 0xa
function private function_7cf8dacb278a2665()
{
    level thread streamer_col_on();
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x2bdc4254, Offset: 0x7c3
// Size: 0x159
function private postmain_init()
{
    if ( level.gametype == "zm_rb_survival" || level.gametype == "zm_rb_r_mod_survival" || level.gametype == "zm_rb_startroom" || level.gametype == "zm_rb_echo" )
    {
        return;
    }
    
    create_script_utility::register_cs_offsets( "zm_sat_hornet_ninja_kite_create_script", ( 0, -24576, 0 ), ( 0, 0, 0 ) );
    zm_sat_hornet_ninja_kite_create_script::main();
    level._effect[ "ninja_kite_trail" ] = loadfxasset( "vfx_sat_levels_zm_hornet_ninja_kite_trail01" );
    level._effect[ "ninja_kite_1p_trail" ] = loadfxasset( "vfx_sat_levels_zm_hornet_ninja_air_trail_1p" );
    level._effect[ "ninja_kite_spawn" ] = loadfxasset( "vfx_sat_levels_zm_hornet_ninja_kite_spawn" );
    level.ninja_kite_root = spawnstruct();
    function_30a3347798cc0c5();
    function_63066943e5004e60();
    level.ninja_kite_vials = [];
    create_breadcrumbs();
    
    if ( !level callback::exists( "disable_ninja_kite_vials", &function_b2417d5ff4e88f68 ) )
    {
        level callback::add( "disable_ninja_kite_vials", &function_b2417d5ff4e88f68 );
    }
    
    if ( !level callback::exists( "enable_ninja_kite_vials", &function_ccd59a7d05eb6cc0 ) )
    {
        level callback::add( "enable_ninja_kite_vials", &function_ccd59a7d05eb6cc0 );
    }
    
    level thread function_8c73b3699af5d45e();
    function_3b500c010031e699();
    
    /#
        function_bf5e58a1601a8929();
    #/
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xf78e461d, Offset: 0x924
// Size: 0xe6
function private function_3b500c010031e699()
{
    var_7877726dd10c7946 = [];
    var_7877726dd10c7946[ var_7877726dd10c7946.size ] = utility::getstruct( "koinobori_high_model", "targetname" );
    var_7877726dd10c7946[ var_7877726dd10c7946.size ] = utility::getstruct( "koinobori_low_model", "targetname" );
    
    foreach ( s in var_7877726dd10c7946 )
    {
        if ( !isdefined( s ) )
        {
            continue;
        }
        
        src_koinobori = spawnscriptable( "sat_zm_carp_streamer_fxsim", s.origin, s.angles );
        src_koinobori setscriptablepartstate( "icon", "active" );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x48a90b, Offset: 0xa12
// Size: 0x2c3
function private function_30a3347798cc0c5()
{
    common_path_high = utility::getstructarray( "ft_high_path_common", "script_noteworthy" );
    common_path_high = get_sorted_path_points( common_path_high );
    var_e0f98fb9715f7c18 = utility::getstruct( "ft_high_path_common_end", "targetname" );
    path_a = utility::getstructarray( "ft_high_path_a", "script_noteworthy" );
    path_a = get_sorted_path_points( path_a, var_e0f98fb9715f7c18 );
    path_b = utility::getstructarray( "ft_high_path_b", "script_noteworthy" );
    path_b = get_sorted_path_points( path_b, var_e0f98fb9715f7c18 );
    path_c = utility::getstructarray( "ft_high_path_c", "script_noteworthy" );
    path_c = get_sorted_path_points( path_c, var_e0f98fb9715f7c18 );
    common_path_low = utility::getstructarray( "ft_low_path_common", "script_noteworthy" );
    common_path_low = get_sorted_path_points( common_path_low );
    var_69032170f070ead6 = utility::getstruct( "ft_low_path_common_end", "targetname" );
    path_d = utility::getstructarray( "ft_low_path_d", "script_noteworthy" );
    path_d = get_sorted_path_points( path_d, var_69032170f070ead6 );
    level.ninja_kite_root.common_path_high = common_path_high;
    level.ninja_kite_root.common_path_low = common_path_low;
    level.ninja_kite_root.path_a = path_a;
    level.ninja_kite_root.path_b = path_b;
    level.ninja_kite_root.path_c = path_c;
    level.ninja_kite_root.path_d = path_d;
    level.ninja_kite_root.var_4ecda724581bd1b9 = utility::function_30dbabe3200518b( "ft_ground_impact_a", "targetname" );
    level.ninja_kite_root.var_47b0c4ba4e959a6a = utility::function_30dbabe3200518b( "ft_ground_impact_b", "targetname" );
    level.ninja_kite_root.var_b9754a638a4e97eb = utility::function_30dbabe3200518b( "ft_ground_impact_c", "targetname" );
    level.ninja_kite_root.var_199499acda873074 = utility::function_30dbabe3200518b( "ft_ground_impact_d", "targetname" );
    level.ninja_kite_root.var_f830a7fcff88ef9b = utility::getstruct( "ft_interact_high", "targetname" );
    level.ninja_kite_root.var_5af255538baf5fc5 = utility::getstruct( "ft_interact_low", "targetname" );
    level.ninja_kite_root.var_fc7080a3cd79f98f = utility::function_30dbabe3200518b( "skr_big_amb", "targetname" );
    level waittill( #"scriptables_ready" );
    level.ninja_kite_root.var_fc7080a3cd79f98f setscriptablepartstate( "fx", "active" );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 2, eflags: 0x4
// Checksum 0x6695b36a, Offset: 0xcdd
// Size: 0xd7
function private get_sorted_path_points( a_s_path_structs, var_20c69431e5986c79 )
{
    path_sorted = arraycopy( a_s_path_structs );
    
    foreach ( struct in a_s_path_structs )
    {
        index = int( struct.script_label );
        path_sorted[ index ] = struct.origin;
    }
    
    if ( isdefined( var_20c69431e5986c79 ) )
    {
        path_sorted = arraycombine( [ var_20c69431e5986c79.origin ], path_sorted );
    }
    
    return path_sorted;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x3770a751, Offset: 0xdbd
// Size: 0xc3
function private streamer_col_on()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    e_cols = getentarray( "streamer_col", #targetname );
    
    if ( !isdefined( e_cols ) )
    {
        return;
    }
    
    foreach ( col in e_cols )
    {
        col disconnectpaths();
        col solid();
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x823cd7a9, Offset: 0xe88
// Size: 0xbe
function private function_8c73b3699af5d45e()
{
    level.var_6f6001f767666a7e = [];
    level.ninja_kite_root.var_ec46abe87d2ff1e3 = [];
    level.ninja_kite_root.var_54c5be97b8f358d8 = 0;
    a_fx_path = [ 1, 2, 3 ];
    
    for ( i = 0; i < a_fx_path.size ; i++ )
    {
        path_number = a_fx_path[ i ];
        a_path_nodes = utility::getstructarray( "s_path_fx_" + path_number, "targetname" );
        a_path_nodes = arraysort( a_path_nodes, undefined, &function_bdb8effb5902f6d9 );
        level.var_6f6001f767666a7e[ level.var_6f6001f767666a7e.size ] = a_path_nodes;
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 2, eflags: 0x4
// Checksum 0x154f7f5, Offset: 0xf4e
// Size: 0x34, Type: bool
function private function_bdb8effb5902f6d9( item1, item2 )
{
    return int( item1.script_noteworthy ) < int( item2.script_noteworthy );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x375011c7, Offset: 0xf8b
// Size: 0x4a
function private function_edce8d80c8ca1f5f()
{
    level.ninja_kite_root.var_54c5be97b8f358d8--;
    
    if ( level.ninja_kite_root.var_54c5be97b8f358d8 <= 0 )
    {
        level.ninja_kite_root.var_54c5be97b8f358d8 = 0;
        function_2c831537eadd85cb();
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x1cb19406, Offset: 0xfdd
// Size: 0xde
function private function_2c831537eadd85cb()
{
    level notify( #"blossom_stop" );
    
    foreach ( fx_mover in level.ninja_kite_root.var_ec46abe87d2ff1e3 )
    {
        if ( isdefined( fx_mover ) )
        {
            fx_mover.var_e8b59e256b73afcf setscriptablepartstate( "fx", "none" );
            fx_mover.var_e8b59e256b73afcf utility::delaycall( 0.25, &freescriptable );
            fx_mover delete();
        }
    }
    
    level.ninja_kite_root.var_ec46abe87d2ff1e3 = [];
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0x812513f4, Offset: 0x10c3
// Size: 0x86
function private function_4eef0bdd8c09cbd3( player )
{
    foreach ( var_feebe39fcb53b08 in level.var_6f6001f767666a7e )
    {
        var_feebe39fcb53b08 thread move_blossom( player );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0xc5bb3bcd, Offset: 0x1151
// Size: 0x38
function private move_blossom( player )
{
    level endon( #"game_ended" );
    level endon( #"blossom_stop" );
    
    while ( true )
    {
        thread blossom_vfx( player );
        wait 1;
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0xb0a37aec, Offset: 0x1191
// Size: 0x1e6
function private blossom_vfx( player )
{
    level endon( #"game_ended" );
    level endon( #"blossom_stop" );
    fx_mover = utility::spawn_model( "tag_origin_ptl_path", self[ 0 ].origin );
    var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
    fx_mover.var_e8b59e256b73afcf = spawnscriptable( %"hash_6af381ceb3e00830", fx_mover.origin, fx_mover.angles, undefined, var_7c170ceae0649b57 );
    fx_mover.var_e8b59e256b73afcf utility::scriptable_setparententity( fx_mover );
    level.ninja_kite_root.var_ec46abe87d2ff1e3[ level.ninja_kite_root.var_ec46abe87d2ff1e3.size ] = fx_mover;
    fx_mover.var_e8b59e256b73afcf setscriptablepartstate( "fx", "path_2" );
    
    foreach ( wire in self )
    {
        fx_mover moveto( wire.origin, 0.05 );
        wait 0.05;
    }
    
    level.ninja_kite_root.var_ec46abe87d2ff1e3 = arrayremove( level.ninja_kite_root.var_ec46abe87d2ff1e3, fx_mover );
    
    if ( isdefined( fx_mover ) )
    {
        fx_mover.var_e8b59e256b73afcf setscriptablepartstate( "fx", "none" );
        fx_mover.var_e8b59e256b73afcf utility::delaycall( 0.25, &freescriptable );
        fx_mover delete();
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xe8f32acd, Offset: 0x137f
// Size: 0x2df
function private create_breadcrumbs()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_quest_initialized" );
    zm_save::function_1f44a48caae2acbf();
    var_e3bdda1f3fb0a6a7 = utility::getstructarray( "nk_v_loc" );
    
    foreach ( struct in var_e3bdda1f3fb0a6a7 )
    {
        if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) ) && zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) == 3 )
        {
            level utility::flag_set( "kite_left_path_taken" );
            level utility::flag_set( "kite_right_path_taken" );
            continue;
        }
        else if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) ) && zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) == 1 && struct.script_noteworthy == "left" )
        {
            level utility::flag_set( "kite_left_path_taken" );
            continue;
        }
        else if ( isdefined( zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) ) && zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a" ) == 2 && struct.script_noteworthy == "right" )
        {
            level utility::flag_set( "kite_right_path_taken" );
            continue;
        }
        
        spawn_options = common_item::function_bc5ff2958b71a708( struct.origin, struct.angles );
        spawn_options.critical = 1;
        spawn_options.var_fd47e835523b473f = 1;
        essence = common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_essence_large", 500, spawn_options );
        essence.mover = utility::spawn_model( "tag_origin", essence.origin, essence.angles );
        essence utility::scriptable_setparententity( essence.mover );
        essence.mover thread bob_essence();
        
        if ( struct.script_noteworthy == "left" )
        {
            essence.loc = "breadcrumb_left";
        }
        else if ( struct.script_noteworthy == "right" )
        {
            essence.loc = "breadcrumb_right";
        }
        
        essence thread auto_pickup_breadcrumb();
        level.ninja_kite_vials[ level.ninja_kite_vials.size ] = essence;
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x10c485f8, Offset: 0x1666
// Size: 0xa4
function private bob_essence()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"picked_up" );
    bob_height = randomfloatrange( 18, 25 );
    bob_speed = randomfloatrange( 1, 1.5 );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            self moveto( self.origin + ( 0, 0, bob_height ), bob_speed );
            self waittill( #"movedone" );
            self moveto( self.origin - ( 0, 0, bob_height ), bob_speed );
            self waittill( #"movedone" );
        }
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x503c0fae, Offset: 0x1712
// Size: 0x198
function private auto_pickup_breadcrumb()
{
    level endon( #"game_ended" );
    level endon( #"hash_4035548c958e42d6" );
    trigger_radius = 128;
    trigger_height = 512;
    prox_trigger = spawn( "noent_volume_trigger_rotatable_radius", self.origin, 0, trigger_radius, trigger_height );
    prox_trigger endon( #"death" );
    
    while ( true )
    {
        prox_trigger waittill( #"trigger", ent );
        
        if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( ent ) )
        {
            if ( ent common_item::function_96119bed8ab4c5d9( self, 1, 0, 0 ) )
            {
                if ( self.loc == "breadcrumb_left" )
                {
                    if ( !level utility::flag( "kite_left_path_taken" ) )
                    {
                        zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a", 1 );
                        level utility::flag_set( "kite_left_path_taken" );
                    }
                }
                else if ( self.loc == "breadcrumb_right" )
                {
                    if ( !level utility::flag( "kite_right_path_taken" ) )
                    {
                        zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a", 2 );
                        level utility::flag_set( "kite_right_path_taken" );
                    }
                }
                
                if ( level utility::flag( "kite_left_path_taken" ) && level utility::flag( "kite_right_path_taken" ) )
                {
                    zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_854339d41c281d4a", 3 );
                }
                
                self.mover notify( #"picked_up" );
                self.mover delete();
                prox_trigger delete();
                return;
            }
        }
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1
// Checksum 0xf11e5ccd, Offset: 0x18b2
// Size: 0xc8
function function_b2417d5ff4e88f68( params )
{
    level notify( #"hash_4035548c958e42d6" );
    
    foreach ( vial in level.ninja_kite_vials )
    {
        if ( isdefined( vial ) )
        {
            vial freescriptable();
            
            if ( isdefined( vial.mover ) )
            {
                vial.mover delete();
            }
        }
    }
    
    level.ninja_kite_vials = undefined;
    level.ninja_kite_vials = [];
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1
// Checksum 0x181b04a7, Offset: 0x1982
// Size: 0x3b
function function_ccd59a7d05eb6cc0( params )
{
    level thread create_breadcrumbs();
    
    if ( !level callback::exists( "enable_ninja_kite_vials", &function_ccd59a7d05eb6cc0 ) )
    {
        level callback::remove( "enable_ninja_kite_vials", &function_ccd59a7d05eb6cc0 );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xdbd38068, Offset: 0x19c5
// Size: 0xe6
function private function_63066943e5004e60()
{
    offset = ( 0, 0, 48 );
    level.ninja_kite_root.high_interact = interaction::register_interact( level.ninja_kite_root.var_f830a7fcff88ef9b.origin + offset, 64, &function_487c3545f13cbcb9, &function_e1ec6b5d7f12e812 );
    level.ninja_kite_root.high_interact.b_high = 1;
    level.ninja_kite_root.low_interact = interaction::register_interact( level.ninja_kite_root.var_5af255538baf5fc5.origin + offset, 64, &function_ad95cabc4d2f3dd7, &function_e1ec6b5d7f12e812 );
    level.ninja_kite_root.low_interact.b_high = 0;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0xb45e4fd8, Offset: 0x1ab3
// Size: 0x100
function private function_487c3545f13cbcb9( player )
{
    var_929a3ff666a99dac = function_8fff8e593ec49870( player );
    
    if ( var_929a3ff666a99dac )
    {
        player.b_on_high_path = 1;
        level.ninja_kite_root.var_54c5be97b8f358d8++;
        
        if ( level.ninja_kite_root.var_54c5be97b8f358d8 == 1 )
        {
            function_4eef0bdd8c09cbd3( player );
        }
        
        var_3b45147e7f19934e = { #var_bce93d4f2ae719c0:1 };
        player thread function_bfcbb2ea1cdfec0b( undefined, var_3b45147e7f19934e );
        player callback::callback( #"hash_285de7f1c47ba90d", var_3b45147e7f19934e );
    }
    
    if ( isdefined( level.ninja_kite_root.var_fc7080a3cd79f98f ) )
    {
        level.ninja_kite_root.var_fc7080a3cd79f98f setscriptablepartstate( "fx", "active" );
        wait 5;
        level.ninja_kite_root.var_fc7080a3cd79f98f setscriptablepartstate( "fx", "none" );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0x8b3c6f70, Offset: 0x1bbb
// Size: 0x6c
function private function_ad95cabc4d2f3dd7( player )
{
    var_929a3ff666a99dac = function_8fff8e593ec49870( player );
    
    if ( var_929a3ff666a99dac )
    {
        var_3b45147e7f19934e = { #var_bce93d4f2ae719c0:0 };
        player thread function_bfcbb2ea1cdfec0b( level.ninja_kite_root.path_d, var_3b45147e7f19934e );
        player callback::callback( #"hash_285de7f1c47ba90d", var_3b45147e7f19934e );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0x169a488f, Offset: 0x1c2f
// Size: 0x6f, Type: bool
function private function_8fff8e593ec49870( player )
{
    if ( player.interactions_disabled || player.var_c51fe993f3dc78d9 || level.disable_fasttravel || player.var_d1c4c78b9fb7d153 )
    {
        return false;
    }
    
    if ( !player currency::attempt_purchase( #"essence", 500, 1, 0, #"fast_travel" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 2, eflags: 0x4
// Checksum 0xdb78707c, Offset: 0x1ca7
// Size: 0x176
function private function_e1ec6b5d7f12e812( usable, player )
{
    if ( player.interactions_disabled || player.var_c51fe993f3dc78d9 || level.disable_fasttravel || player.var_d1c4c78b9fb7d153 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    var_973a47b954904876 = usable.b_high ? &"hash_4d71538056a4d96f" : &"hash_4f862df971a0a106";
    hint = { #interactable:1, #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #icon_text_value:500, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"ui_icon_zm_ping_all_other_fast_travel", #description:var_973a47b954904876, #title:&"hash_37638fc03d424ad3", #string:&"SHARED_HINTSTRINGS/FASTTRAVEL_FREE", #type:"HINT_BUTTON" };
    
    if ( !player currency::can_afford( #"essence", 500 ) )
    {
        hint.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hint.interactable = 0;
    }
    
    return hint;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 2
// Checksum 0xc5a37abb, Offset: 0x1e26
// Size: 0x5a8
function function_bfcbb2ea1cdfec0b( path_override, var_3b45147e7f19934e )
{
    self notify( #"hash_85220c4ba315da44" );
    self endon( #"hash_85220c4ba315da44" );
    self endon( #"death_or_disconnect" );
    self notify( #"fasttravel_start" );
    self.var_d1c4c78b9fb7d153 = 1;
    stop_scorestreaks();
    
    if ( isdefined( self ) && isdefined( self.fasttravel_mover ) )
    {
        cleanup_link();
    }
    
    if ( isdefined( self ) && isdefined( self.ninja_kite ) )
    {
        cleanup_kite();
    }
    
    var_bce93d4f2ae719c0 = var_3b45147e7f19934e.var_bce93d4f2ae719c0;
    b_skip_common_path = var_3b45147e7f19934e.b_skip_common_path;
    path_time_override = var_3b45147e7f19934e.path_time_override;
    val::set( "ninja_kite", "hide_stowed_weapon", 1 );
    
    if ( self getcamerathirdperson() )
    {
        self.force_third_person = 0;
    }
    else
    {
        self.force_third_person = 1;
        self setcamerathirdperson( 1 );
    }
    
    player_forward_vec = anglestoforward( self getplayerangles() );
    
    if ( var_bce93d4f2ae719c0 )
    {
        high_dir = utility::getstruct( "takeoff_high", "targetname" );
        mover = utility::spawn_tag_origin( high_dir.origin, high_dir.angles );
        camera_tag = utility::spawn_model( "tag_origin", high_dir.origin + ( 10, 90, 130 ), high_dir.angles + ( 10, 0, 0 ) );
    }
    else if ( var_bce93d4f2ae719c0 == 0 )
    {
        low_dir = utility::getstruct( "takeoff_low", "targetname" );
        mover = utility::spawn_tag_origin( low_dir.origin, low_dir.angles );
        camera_tag = utility::spawn_model( "tag_origin", low_dir.origin + ( -32, -140, 70 ), low_dir.angles + ( 15, 0, 0 ) );
    }
    else
    {
        spawn_loc = spawnstruct();
        spawn_loc.origin = path_override[ 0 ];
        spawn_loc.angles = ( 45, 0, 0 );
        mover = utility::spawn_tag_origin( spawn_loc.origin, spawn_loc.angles );
        camera_tag = utility::spawn_model( "tag_origin", spawn_loc.origin + ( -90, 0, 200 ), spawn_loc.angles );
    }
    
    self.fasttravel_mover = mover;
    self playerlinktodelta( mover, "tag_origin", 1, 0, 0, 0, 0, 1, 1 );
    self startcameratween( 0.3, 0 );
    self cameralinkto( camera_tag, "tag_origin", 1, 1 );
    waitframe();
    camera_tag linkto( self.fasttravel_mover );
    thread monitor_player_death_or_disconnect();
    self playsoundonmovingent( "evt_zm_ninja_kite_open_plr" );
    utility::delaythread( 0, &function_4624129b43ed0bf4 );
    thread function_8c73919bdab67be3();
    
    if ( var_bce93d4f2ae719c0 && zm_quest::function_b0a5181ebe7bb905() && ( !self.var_477ccddc619b5fe || utility::ent_flag( "hornet_mq_guided_taking_high_path" ) ) )
    {
        val::reset( "fasttravel", "show_hud" );
        self.var_477ccddc619b5fe = 1;
        thread ww_shared::show_hud_tutorial_message( &"hash_72d1f4ca91031210", 3.75 );
        utility::delaythread( 4, &val::set, "fasttravel", "show_hud", 0 );
    }
    
    if ( !b_skip_common_path )
    {
        common_path = level.ninja_kite_root.common_path_low;
        common_path_duration = 2;
        
        if ( var_bce93d4f2ae719c0 )
        {
            common_path = level.ninja_kite_root.common_path_high;
            common_path_duration = 4;
            mover utility::function_2159dd4196ff4b81( level.ninja_kite_root.common_path_high, 4, 1, 1, 1, 1, 1, 1 );
        }
        else
        {
            mover utility::function_2159dd4196ff4b81( level.ninja_kite_root.common_path_low, 2, 1, 1, 1, 1, 1, 1 );
        }
    }
    
    path = path_override ?? function_4a6dbec0d5125f38();
    path_duration = path_time_override ?? common_path_duration;
    thread function_2263f6c21370774f( path, path_duration );
    full_path = path;
    path_duration = !b_skip_common_path ? 6 + common_path_duration : path_duration;
    mover utility::function_2159dd4196ff4b81( full_path, path_duration, 1, 1, 1, 1, 1, 1 );
    self notify( #"fasttravel_over" );
    self.var_d1c4c78b9fb7d153 = undefined;
    
    if ( self.b_on_high_path )
    {
        self.b_on_high_path = undefined;
        function_edce8d80c8ca1f5f();
    }
    
    end_player_animations();
    end_player_effects();
    function_b175b13a35b94d74( path );
    val::set( "ninja_kite", "hide_stowed_weapon", 0 );
    current_player_origin = self getcamerathirdpersonorigin();
    current_player_angles = self getplayerangles();
    camera_tag moveto( current_player_origin, 0.2, 0.2, 0 );
    camera_tag rotateto( current_player_angles, 0.2, 0.2, 0 );
    wait 0.2;
    self cameraunlink();
    camera_tag delete();
    
    if ( self.force_third_person )
    {
        self setcamerathirdperson( 0 );
        self.force_third_person = undefined;
    }
    
    wait 1;
    utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_1" );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x2f061ced, Offset: 0x23d6
// Size: 0x98
function private function_4a6dbec0d5125f38()
{
    y_input = self getnormalizedmovement()[ 1 ];
    path_a_unlocked = is_zone_enabled( "zone_west_bailey_a" );
    path_b_unlocked = is_zone_enabled( "zone_lava_garden_a" );
    
    if ( path_a_unlocked && y_input > 0 )
    {
        return level.ninja_kite_root.path_a;
    }
    else if ( path_b_unlocked && y_input < 0 )
    {
        return level.ninja_kite_root.path_c;
    }
    
    return level.ninja_kite_root.path_b;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0x3fd3dcf2, Offset: 0x2477
// Size: 0x2b
function private is_zone_enabled( zone_name )
{
    var_8c4fe62d01999d1e = zone_manager::get_zone_struct( zone_name );
    return var_8c4fe62d01999d1e.is_enabled;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 2, eflags: 0x4
// Checksum 0xdef4a9ee, Offset: 0x24ab
// Size: 0x74
function private function_2263f6c21370774f( path, common_path_duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( arraycompare( path, level.ninja_kite_root.path_a ) )
    {
        roll_player_direction( "right" );
        return;
    }
    
    if ( arraycompare( path, level.ninja_kite_root.path_c ) )
    {
        roll_player_direction( "left" );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0x92a5be31, Offset: 0x2527
// Size: 0xb5
function private get_path_impact( path )
{
    if ( arraycompare( path, level.ninja_kite_root.path_a ) )
    {
        return level.ninja_kite_root.var_4ecda724581bd1b9;
    }
    else if ( arraycompare( path, level.ninja_kite_root.path_b ) )
    {
        return level.ninja_kite_root.var_47b0c4ba4e959a6a;
    }
    else if ( arraycompare( path, level.ninja_kite_root.path_c ) )
    {
        return level.ninja_kite_root.var_b9754a638a4e97eb;
    }
    
    return level.ninja_kite_root.var_199499acda873074;
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1, eflags: 0x4
// Checksum 0xb68a0b9, Offset: 0x25e5
// Size: 0xc0
function private function_b175b13a35b94d74( path )
{
    impact_sbl = get_path_impact( path );
    prev_node_idx = path.size - 2;
    
    if ( prev_node_idx >= 0 )
    {
        prev_pos = path[ prev_node_idx ];
        self function_ec230bd50bdba27c( 1 );
        v_dir = self.origin - prev_pos;
        v_dir = vectornormalize( v_dir );
        v_dir = ( v_dir[ 0 ], v_dir[ 1 ], -1 );
        self knockback( v_dir, 700 );
    }
    
    self playrumbleonentity( "ground_pound_land" );
    self earthquakeforplayer( 0.35, 1.5, self.origin, 64 );
    impact_sbl setscriptablepartstate( "body", "impact_ground" );
    function_874f6853e1b01ebe();
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x9e3359df, Offset: 0x26ad
// Size: 0x106
function private function_874f6853e1b01ebe()
{
    a_knockdown_ai = getaiarrayinradius( self.origin, 175 );
    var_771534fa286377ce = getaiarrayinradius( self.origin, 50 );
    
    foreach ( ent in a_knockdown_ai )
    {
        if ( ent.team == "team_two_hundred" )
        {
            if ( arraycontains( var_771534fa286377ce, ent ) && ent.aicategory == "normal" )
            {
                ent.forceannihilate = 1;
                ent kill();
                continue;
            }
            
            if ( !ent zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                ent zombie_knockdown::function_6fc167d4a3590991( self.origin );
            }
        }
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0
// Checksum 0xc162ffc2, Offset: 0x27bb
// Size: 0x77
function stop_scorestreaks()
{
    if ( self.isjuggernaut )
    {
        damagedata = spawnstruct();
        damagedata.attacker = self;
        damagedata.instantdeath = 1;
        juggernaut::jugg_removejuggernaut( damagedata );
    }
    
    if ( self.mutantinjectiontransformed )
    {
        thread utility::callsharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", 1 );
    }
    
    waitframe();
    self notify( #"cancel_all_killstreak_deployments" );
    waitframe();
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xca9f23de, Offset: 0x283a
// Size: 0x6d
function private function_4624129b43ed0bf4()
{
    self endon( #"death_or_disconnect" );
    struct = spawnstruct();
    struct.origin = self.origin;
    self.fasttravel_mover thread scene::play( self, [ "wing_in", "wing_loop" ], "zm_sat_hornet_fasttravel_anims" );
    utility::delaythread( 0.25, &function_ce8667e5caf44b19 );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xb9aaf256, Offset: 0x28af
// Size: 0x2b
function private end_player_animations()
{
    self.fasttravel_mover scene::stop();
    self playsoundonmovingent( "evt_zm_ninja_kite_close_plr" );
    cleanup_link();
    cleanup_kite();
}

// Namespace zm_sat_hornet_ninja_kite
// Params 1
// Checksum 0xfa966e84, Offset: 0x28e2
// Size: 0x60
function roll_player_direction( direction )
{
    if ( isdefined( self.fasttravel_mover ) )
    {
        self.fasttravel_mover scene::stop();
        self.fasttravel_mover thread scene::play( self, [ "wing_" + direction, "wing_loop" ], "zm_sat_hornet_fasttravel_anims" );
        self playsoundonmovingent( "evt_zm_ninja_kite_flip" );
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xdbc72bf, Offset: 0x294a
// Size: 0x52
function private monitor_player_death_or_disconnect()
{
    self endon( #"game_ended" );
    self endon( #"fasttravel_over" );
    self waittill( #"death_or_disconnect" );
    
    if ( self.b_on_high_path )
    {
        self.b_on_high_path = undefined;
        function_edce8d80c8ca1f5f();
    }
    
    cleanup_link();
    cleanup_kite();
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0x112f1fd7, Offset: 0x29a4
// Size: 0x29
function private cleanup_link()
{
    if ( isdefined( self ) && isdefined( self.fasttravel_mover ) )
    {
        self unlink();
        self.fasttravel_mover delete();
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xbb132e3c, Offset: 0x29d5
// Size: 0x156
function private function_ce8667e5caf44b19()
{
    kite = utility::spawn_model( %"hash_60813f1660f85305", self.origin, self.angles, undefined, 1 );
    kite utility::function_7c10ea82c1e305b8( "model", "on" );
    offset_x = getdvarfloat( @"nk_x", -36 );
    offset_y = getdvarfloat( @"nk_y", 10 );
    offset_z = getdvarfloat( @"nk_z", 0 );
    offset_xa = getdvarfloat( @"nk_xa", 180 );
    offset_ya = getdvarfloat( @"nk_ya", 90 );
    offset_za = getdvarfloat( @"nk_za", 90 );
    kite linkto( self, "j_spinelower", ( offset_x, offset_y, offset_z ), ( offset_xa, offset_ya, offset_za ) );
    self.ninja_kite = kite;
    playfxontag( utility::getfx( "ninja_kite_spawn" ), self.ninja_kite, "tag_origin" );
    playfxontag( utility::getfx( "ninja_kite_trail" ), self.ninja_kite, "tag_fx_up_ri" );
    playfxontag( utility::getfx( "ninja_kite_trail" ), self.ninja_kite, "tag_fx_up_le" );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xb2815a1f, Offset: 0x2b33
// Size: 0x54
function private cleanup_kite()
{
    if ( isdefined( self.ninja_kite ) )
    {
        self.ninja_kite unlink();
        self.ninja_kite delete();
    }
    
    if ( isdefined( self.var_b6adadd83a7c8f94 ) )
    {
        self.var_b6adadd83a7c8f94 unlink();
        self.var_b6adadd83a7c8f94 delete();
    }
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xc02f5779, Offset: 0x2b8f
// Size: 0x46
function private function_8c73919bdab67be3()
{
    self setscriptablepartstate( "wingsuit_fx", "deployed" );
    pbgpostfxbundlestart( self, "cer_zm_speed_blur" );
    self setshowcontrail( 1 );
    self playrumblelooponentity( "low_highfreq" );
    zm_fasttravel::set_player_vars( 1 );
    self setclientomnvar( "ui_show_quest_ui_nohud", 1 );
}

// Namespace zm_sat_hornet_ninja_kite
// Params 0, eflags: 0x4
// Checksum 0xd54b6360, Offset: 0x2bdd
// Size: 0x41
function private end_player_effects()
{
    pbgpostfxbundleend( self, "cer_zm_speed_blur" );
    self setshowcontrail( 0 );
    self stoprumble( "low_highfreq" );
    utility::delaythread( 0.75, &zm_fasttravel::set_player_vars, 0 );
    self setscriptablepartstate( "wingsuit_fx", "off" );
}

/#

    // Namespace zm_sat_hornet_ninja_kite
    // Params 0, eflags: 0x4
    // Checksum 0x1b3b4c5d, Offset: 0x2c26
    // Size: 0xd8, Type: dev
    function private function_bf5e58a1601a8929()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x42>", "<dev string:x51>", &function_c30cc04295a9b3c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f>", "<dev string:x6a>", &function_c30cc04295a9b3c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x74>", "<dev string:x7f>", &function_c30cc04295a9b3c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x89>", "<dev string:x94>", &function_c30cc04295a9b3c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9e>", "<dev string:xa9>", &function_c30cc04295a9b3c5, 1 );
        devgui::add_devgui_func( "<dev string:xb3>", "<dev string:xc5>", &function_f80490136c160434, 1 );
        devgui::add_devgui_func( "<dev string:xcf>", "<dev string:xe9>", &function_c9a45c11a9cf53d0, 1 );
        devgui::add_devgui_func( "<dev string:xf4>", "<dev string:x10b>", &debug_show_streamer, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_ninja_kite
    // Params 1, eflags: 0x4
    // Checksum 0x4a900e6d, Offset: 0x2d06
    // Size: 0x1bf, Type: dev
    function private function_c30cc04295a9b3c5( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        player = level.players[ 0 ];
        path = undefined;
        var_bce93d4f2ae719c0 = 1;
        
        switch ( params[ 0 ] )
        {
            case #"hash_31103cbc01bd7f53":
                path = level.ninja_kite_root.path_d;
                var_bce93d4f2ae719c0 = 0;
                break;
            case #"hash_311041bc01bd8732":
                path = level.ninja_kite_root.path_c;
                break;
            case #"hash_311042bc01bd88c5":
                path = level.ninja_kite_root.path_b;
                break;
            case #"hash_31103fbc01bd840c":
                path = level.ninja_kite_root.path_a;
                break;
            case #"hash_de2753955b23505b":
            default:
                break;
        }
        
        player dontinterpolate();
        
        if ( var_bce93d4f2ae719c0 )
        {
            player setorigin( level.ninja_kite_root.var_f830a7fcff88ef9b.origin );
            player setplayerangles( level.ninja_kite_root.var_f830a7fcff88ef9b.angles );
        }
        else
        {
            player setorigin( level.ninja_kite_root.var_5af255538baf5fc5.origin );
            player setplayerangles( level.ninja_kite_root.var_5af255538baf5fc5.angles );
        }
        
        var_3b45147e7f19934e = { #var_bce93d4f2ae719c0:1 };
        player thread function_bfcbb2ea1cdfec0b( path, var_3b45147e7f19934e );
    }

    // Namespace zm_sat_hornet_ninja_kite
    // Params 0, eflags: 0x4
    // Checksum 0x1c37e5bd, Offset: 0x2ecd
    // Size: 0x41, Type: dev
    function private function_f80490136c160434()
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player.ninja_kite ) )
        {
            player function_ce8667e5caf44b19();
            return;
        }
        
        player cleanup_kite();
    }

    // Namespace zm_sat_hornet_ninja_kite
    // Params 0, eflags: 0x4
    // Checksum 0xb34b2788, Offset: 0x2f16
    // Size: 0x61, Type: dev
    function private function_c9a45c11a9cf53d0()
    {
        if ( !level.ninja_kite_root.var_7ed69d813f40bc9 )
        {
            function_4eef0bdd8c09cbd3( level.players[ 0 ] );
            level.ninja_kite_root.var_7ed69d813f40bc9 = 1;
            return;
        }
        
        function_2c831537eadd85cb();
        level.ninja_kite_root.var_7ed69d813f40bc9 = undefined;
    }

    // Namespace zm_sat_hornet_ninja_kite
    // Params 0, eflags: 0x4
    // Checksum 0xad66c62e, Offset: 0x2f7f
    // Size: 0x96, Type: dev
    function private debug_show_streamer()
    {
        a_koinobori = getentitylessscriptablearray( %"zm_sat_hornet_koinobori" );
        
        foreach ( var_498515148774b3f9 in a_koinobori )
        {
            var_498515148774b3f9 setscriptablepartstate( "<dev string:x121>", "<dev string:x127>" );
        }
    }

#/
