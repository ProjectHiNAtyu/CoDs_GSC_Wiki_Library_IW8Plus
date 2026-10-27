// scripts\mp\zm\fasttravel\zm_fasttravel_jumppad.gsc  (hash_592a106b17510a5d.gscc) (size: 31549 Bytes / 0x7b3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf004746f (4026823791)
// size ...... 31549 (0x7b3d)
// includes .. 22  (offset: 0x704d)
// strings ... 115 (offset: 0x70fd)
// dev strs .. 27  (offset: 0x79cd)
// exports ... 48  (offset: 0x4f49)
// cseg ...... 0x815 + 0x4734 (0x4f49)
// imports ... 197 (offset: 0x56c9)
// animtree1 . 0   (offset: 0x7b3d)
// animtree2 . 0   (offset: 0x7b3d)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_fasttravel_jumppad;

// Namespace zm_fasttravel_jumppad
// Params 0, eflags: 0x5
// Checksum 0x4b2d1517, Offset: 0x833
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ft_jp", undefined, undefined, &init_jumppads );
}

// Namespace zm_fasttravel_jumppad
// Params 0, eflags: 0x4
// Checksum 0xf0d0a7ac, Offset: 0x854
// Size: 0x4e6
function private init_jumppads()
{
    level utility::flag_wait_all( "zm_sat_firefly_script_fasttravel_jumppads_create_script_completed", "scriptables_ready" );
    
    if ( level.gametypebundle.var_809dd58f8a112f22 )
    {
        level val::group_register( "player_ft_jp_jumping", [ "usability", "weapon_pickup", "supers", "allow_scripted_bgb_use", "gesture", "killstreaks", "allow_movement", "allow_jump", "crouch", "prone", "slide_boost", "show_hud", "equipment_primary", "equipment_secondary", "damage" ] );
        level.var_fb4ce2ccb8add9ab = getentitylessscriptablearray( "jumppad_path_end", #script_noteworthy );
    }
    
    level.a_jumppads = getentitylessscriptablearray( "zm_jumppad", #targetname );
    
    for ( i = 0; i < level.a_jumppads.size ; i++ )
    {
        jumppad = level.a_jumppads[ i ];
        
        if ( !isdefined( jumppad.script_noteworthy ) )
        {
            assertmsg( "<dev string:x24>" + jumppad.origin + "<dev string:x50>" );
            continue;
        }
        
        if ( jumppad utility::function_de1f80d93273abf5() )
        {
            jumppad.scriptable = jumppad;
        }
        else
        {
            jumppad.scriptable = spawnscriptable( %"sat_zm_fasttravel_jumppad", jumppad.origin, jumppad.angles );
        }
        
        if ( !level.gametypebundle.var_809dd58f8a112f22 )
        {
            jumppad.scriptable utility::function_32b24db3127bff40( "ping", "off" );
            continue;
        }
        
        if ( isent( jumppad.scriptable ) )
        {
            jumppad.scriptable setnodeploy( 1 );
        }
        
        foreach ( landingpad in level.var_fb4ce2ccb8add9ab )
        {
            if ( landingpad.script_parameters != jumppad.script_noteworthy )
            {
                continue;
            }
            
            jumppad.landingpad = landingpad;
            break;
        }
        
        if ( !isdefined( jumppad.script_cost ) )
        {
            jumppad.script_cost = 500;
        }
        
        jumppad.power_on_flag = jumppad get_fasttravel_jumppad_power_flag( jumppad.script_noteworthy );
        jumppad.cool_down_time = jumppad.script_timeout ?? 10;
        jumppad.var_f0e4330fc19232d3 = "ft_jp_offline_" + i;
        jumppad.var_f23e8f1f1a679229 = &"SHARED_HINTSTRINGS/HINT_ACTIVATE";
        level utility::flag_clear( jumppad.var_f0e4330fc19232d3 );
        mark_spawn_org = jumppad.scriptable.origin + ( 0, 0, 1 );
        jumppad.mdl_arrow_scriptable = spawnscriptable( %"sat_zm_fasttravel_jumppad_mark", mark_spawn_org, jumppad.scriptable.angles );
        jumppad sort_jumppad_paths( jumppad.target );
        jumppad.jumppad_index = jumppad get_fasttravel_jumppad_index( jumppad.script_noteworthy );
        jumppad.scriptable utility::function_32b24db3127bff40( "left_location", "default" );
        jumppad.scriptable utility::function_32b24db3127bff40( "right_location", "default" );
        
        if ( is_jumppads_enabled() )
        {
            jumppad thread function_26d2c1ed70a8c950();
        }
        
        jumppad.event_banter[ #"hash_f63f3fe263f9e1c2" ][ "banterName" ] = #"hash_f63f3fe263f9e1c2";
        jumppad.event_banter[ #"hash_f63f3fe263f9e1c2" ][ "battleChatterName" ] = #"hash_1d22470fe3f6c458";
        jumppad.event_banter[ #"hash_1ee3af3143bafea" ][ "banterName" ] = #"hash_1ee3af3143bafea";
        jumppad utility::ent_flag_set( "done_init" );
    }
    
    if ( !level.gametypebundle.var_809dd58f8a112f22 )
    {
        return;
    }
    
    level utility::flag_set( "jps_inited" );
    callback::add( #"hash_9325330e77aef2ad", &function_4f9ffedb29cd4a7e );
    callback::add( #"firesale_end", &firesale_end );
    
    /#
        level thread init_fasttravel_jumppad_debug();
    #/
}

// Namespace zm_fasttravel_jumppad
// Params 0
// Checksum 0xb5188013, Offset: 0xd42
// Size: 0x51, Type: bool
function is_jumppads_enabled()
{
    if ( getdvarint( @"fasttravel_disable", 0 ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_c19f48f68b7f6802", 0 ) )
    {
        return false;
    }
    
    if ( !level.gametypebundle.var_809dd58f8a112f22 )
    {
        return false;
    }
    
    if ( level.var_96d4f8dc0c3cfea3 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x60a322eb, Offset: 0xd9c
// Size: 0x27
function private get_fasttravel_jumppad_power_flag( pad_name )
{
    if ( isdefined( level.var_e19bd13057298f1e ) )
    {
        return [[ level.var_e19bd13057298f1e ]]( pad_name );
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x51d018da, Offset: 0xdcc
// Size: 0x27
function private get_fasttravel_jumppad_index( pad_name )
{
    if ( isdefined( level.var_5eadbec443282eb6 ) )
    {
        return [[ level.var_5eadbec443282eb6 ]]( pad_name );
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x7d44d7b4, Offset: 0xdfc
// Size: 0x30
function private function_e70c9567a16f753d( path_name )
{
    if ( isdefined( level.var_f1588a2f34367fab ) )
    {
        return [[ level.var_f1588a2f34367fab ]]( path_name );
    }
    
    return &"";
}

// Namespace zm_fasttravel_jumppad
// Params 3
// Checksum 0xcde74ce7, Offset: 0xe35
// Size: 0x1e1
function play_vo_banter( var_5e1c75975eb34ec4, var_7c2c820e274abf1c = 0, player )
{
    if ( overlord::function_dce0a14273dfa0a8() || level utility::flag( "overlord_paused" ) )
    {
        return;
    }
    
    banterPlayedPlayers = self.event_banter[ var_5e1c75975eb34ec4 ][ "banterPlayedPlayers" ];
    
    if ( level utility::flag( "player_banter_playing" ) || self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] || !isalive( player ) || banterPlayedPlayers && arraycontains( banterPlayedPlayers, player ) )
    {
        return;
    }
    
    var_8984c1f1eeea88ec = self.event_banter[ var_5e1c75975eb34ec4 ][ "banterName" ];
    
    if ( !var_8984c1f1eeea88ec )
    {
        return;
    }
    
    level overlord::function_724ca7b94bf1fb66( 1 );
    
    if ( var_7c2c820e274abf1c == -1 )
    {
        self.event_banter[ var_5e1c75975eb34ec4 ][ "banterName" ] = undefined;
    }
    
    var_db75d3de862ce072 = level player_banter::play_banter_vo( var_8984c1f1eeea88ec, [ player ] );
    
    if ( var_db75d3de862ce072 )
    {
        if ( !isdefined( self.event_banter[ var_5e1c75975eb34ec4 ][ "banterPlayedPlayers" ] ) )
        {
            self.event_banter[ var_5e1c75975eb34ec4 ][ "banterPlayedPlayers" ] = [];
        }
        
        self.event_banter[ var_5e1c75975eb34ec4 ][ "banterPlayedPlayers" ][ self.event_banter[ var_5e1c75975eb34ec4 ][ "banterPlayedPlayers" ].size ] = player;
    }
    else if ( !player player_banter::function_4e1aff6241ebea8() && self.event_banter[ var_5e1c75975eb34ec4 ][ "battleChatterName" ] )
    {
        player namespace_c0b4f2882c9d100f::say_battlechatter( self.event_banter[ var_5e1c75975eb34ec4 ][ "battleChatterName" ] );
    }
    
    level utility::delaythread( 1, &overlord::function_724ca7b94bf1fb66, 0 );
    
    if ( var_db75d3de862ce072 && var_7c2c820e274abf1c > 0 )
    {
        self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] = 1;
        wait var_7c2c820e274abf1c;
        self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] = 0;
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0xb5517b3, Offset: 0x101e
// Size: 0x77f
function private sort_jumppad_paths( jumppad_paths )
{
    self.interact = interaction::register_scriptable_interact( self.scriptable, &fasttravel_jumppad_interact_used );
    self.interact interaction::set_interact_hint_callback( &fasttravel_interact_hint_callback );
    self.interact.fasttravel_icon = "ui_icon_zm_ping_all_other_fast_travel";
    self.interact.fasttravel_title = &"shared_hintstrings/fasttravel_title_jumppad";
    self.interact.var_7899dd4d8ac31d1a = self;
    self.interact.myparent = self;
    self.interact.var_2efb9165f56da06d = 1;
    a_s_path_structs = utility::getstructarray( "fasttravel_jumppad_paths", "target" );
    jumppad_paths = strtok( jumppad_paths, "," );
    
    if ( jumppad_paths.size > 2 )
    {
        assertmsg( "<dev string:x8f>" );
    }
    
    var_696d09173a237b79 = [];
    
    foreach ( var_91924ab1040d73db in a_s_path_structs )
    {
        a_path_names = strtok( var_91924ab1040d73db.targetname, "," );
        
        foreach ( path_name in a_path_names )
        {
            var_1f42fb5079240912 = undefined;
            
            for ( i = 0; i < jumppad_paths.size ; i++ )
            {
                var_10f12c7f2b0d3d34 = jumppad_paths[ i ];
                
                if ( var_10f12c7f2b0d3d34 == path_name )
                {
                    var_1f42fb5079240912 = i;
                }
            }
            
            if ( !isdefined( var_1f42fb5079240912 ) )
            {
                continue;
            }
            
            if ( !isdefined( var_91924ab1040d73db.script_noteworthy ) )
            {
                assertmsg( "<dev string:x24>" + var_91924ab1040d73db.origin + "<dev string:xe0>" );
                continue;
            }
            
            if ( !isdefined( var_696d09173a237b79[ var_1f42fb5079240912 ] ) )
            {
                var_696d09173a237b79[ var_1f42fb5079240912 ] = [];
            }
            
            var_696d09173a237b79[ var_1f42fb5079240912 ][ "name" ] = path_name;
            var_696d09173a237b79[ var_1f42fb5079240912 ][ "myParent" ] = self;
            
            if ( var_91924ab1040d73db.script_noteworthy == "jumppad_path_handle" )
            {
                if ( !isdefined( var_91924ab1040d73db.script_parameters ) )
                {
                    assertmsg( "<dev string:x24>" + var_91924ab1040d73db.origin + "<dev string:x128>" );
                    continue;
                }
                
                var_c1f4f10cbaecec14 = strtok( var_91924ab1040d73db.script_parameters, "," );
                
                if ( arraycontains( var_c1f4f10cbaecec14, self.script_noteworthy ) )
                {
                    var_696d09173a237b79[ var_1f42fb5079240912 ][ "handle" ] = var_91924ab1040d73db.origin;
                    var_696d09173a237b79[ var_1f42fb5079240912 ][ "handle_struct" ] = var_91924ab1040d73db;
                }
                
                continue;
            }
            
            if ( var_91924ab1040d73db.script_noteworthy == "jumppad_path_end" )
            {
                scriptable = spawnscriptable( "sat_zm_fasttravel_landingpad", var_91924ab1040d73db.origin, var_91924ab1040d73db.angles );
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "end" ] = scriptable.origin;
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "end_scriptable" ] = scriptable;
                continue;
            }
            
            assertmsg( "<dev string:x24>" + var_91924ab1040d73db.origin + "<dev string:x171>" );
        }
    }
    
    var_83292dfa34d734e8 = getentitylessscriptablearray( "fasttravel_jumppad_paths", #target );
    
    foreach ( sbl_path_end in var_83292dfa34d734e8 )
    {
        a_path_names = strtok( sbl_path_end.targetname, "," );
        
        foreach ( path_name in a_path_names )
        {
            var_1f42fb5079240912 = undefined;
            
            for ( i = 0; i < jumppad_paths.size ; i++ )
            {
                var_10f12c7f2b0d3d34 = jumppad_paths[ i ];
                
                if ( var_10f12c7f2b0d3d34 == path_name )
                {
                    var_1f42fb5079240912 = i;
                }
            }
            
            if ( !isdefined( var_1f42fb5079240912 ) )
            {
                continue;
            }
            
            if ( !isdefined( sbl_path_end.script_noteworthy ) )
            {
                assertmsg( "<dev string:x24>" + sbl_path_end.origin + "<dev string:xe0>" );
                continue;
            }
            
            if ( !isdefined( var_696d09173a237b79[ var_1f42fb5079240912 ] ) )
            {
                var_696d09173a237b79[ var_1f42fb5079240912 ] = [];
            }
            
            if ( !isdefined( var_696d09173a237b79[ var_1f42fb5079240912 ][ "name" ] ) )
            {
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "name" ] = path_name;
            }
            
            if ( !isdefined( var_696d09173a237b79[ var_1f42fb5079240912 ][ "myParent" ] ) )
            {
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "myParent" ] = self;
            }
            
            if ( sbl_path_end.script_noteworthy == "jumppad_path_end" )
            {
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "end" ] = sbl_path_end.origin;
                var_696d09173a237b79[ var_1f42fb5079240912 ][ "end_scriptable" ] = sbl_path_end;
                continue;
            }
            
            assertmsg( "<dev string:x24>" + sbl_path_end.origin + "<dev string:x1bb>" );
        }
    }
    
    self.paths = arraysort( var_696d09173a237b79, undefined, &function_b2a78e2ee069be42 );
    
    for ( i = 0; i < self.paths.size ; i++ )
    {
        if ( !isdefined( self.paths[ i ][ "start" ] ) )
        {
            self.paths[ i ][ "start" ] = self.scriptable.origin + ( 0, 0, 16 );
        }
        
        if ( !isdefined( self.paths[ i ][ "handle" ] ) )
        {
            midpoint_pos = ( self.paths[ i ][ "start" ] + self.paths[ i ][ "end" ] ) / 2;
            dist_midpoint = distance( self.paths[ i ][ "start" ], midpoint_pos );
            var_9ff7b1b7dd1448a1 = ( midpoint_pos[ 0 ], midpoint_pos[ 1 ], dist_midpoint );
            self.paths[ i ][ "handle" ] = var_9ff7b1b7dd1448a1;
        }
        
        temp_model = utility::spawn_model( %"sat_zm_jumppads_machine_main_fxanim", self.scriptable.origin, self.scriptable.angles );
        waitframe();
        directional_tag = i == 0 ? "J_screen_right_off" : "J_screen_left_off";
        var_21d8fb87478950ff = temp_model gettagorigin( directional_tag );
        temp_model delete();
        waitframe();
        self.paths[ i ][ "monitor_org" ] = var_21d8fb87478950ff + ( 0, 0, -48 );
        self.paths[ i ][ "is_monitor_enable" ] = 1;
    }
    
    b_first_spawned = is_jumppads_enabled() ? !isdefined( self.power_on_flag ) : 0;
    thread set_jumppad_path( undefined, b_first_spawned );
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0x11146e97, Offset: 0x17a5
// Size: 0xe4, Type: bool
function private function_b2a78e2ee069be42( first_path, second_path )
{
    s_start = first_path[ "myParent" ];
    var_a84a3372eb33ff01 = anglestoleft( s_start.angles );
    var_5bb75871f7d24a5f = s_start.angles + ( 0, 180, 0 );
    var_868aa72e81bc44e3 = first_path[ "end" ];
    var_228b4db92b7b9222 = vectornormalize( var_868aa72e81bc44e3 - s_start.origin );
    var_272da0cf43cdfa30 = vectordot( var_228b4db92b7b9222, var_a84a3372eb33ff01 );
    var_fbb3f0293fddf3cf = second_path[ "end" ];
    var_58053bd372376558 = vectornormalize( var_fbb3f0293fddf3cf - s_start.origin );
    var_26d35bba9c139602 = vectordot( var_58053bd372376558, var_a84a3372eb33ff01 );
    return var_272da0cf43cdfa30 > var_26d35bba9c139602;
}

// Namespace zm_fasttravel_jumppad
// Params 0, eflags: 0x4
// Checksum 0xe8fd12f4, Offset: 0x1892
// Size: 0xea
function private function_26d2c1ed70a8c950()
{
    level endon( #"game_ended" );
    power_flags = [];
    
    if ( isdefined( self.power_on_flag ) )
    {
        power_flags[ power_flags.size ] = self.power_on_flag;
    }
    
    var_96ec02a507107180 = power_flags;
    var_96ec02a507107180 = arraycombineunique( var_96ec02a507107180, [ "open_sesame" ] );
    
    if ( ( self.jumppad_index == 5 || self.jumppad_index == 6 ) && getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        return;
    }
    
    while ( true )
    {
        level utility::flag_wait_any_array( var_96ec02a507107180 );
        set_jumppad_path( undefined, 1 );
        
        if ( power_flags.size < 1 )
        {
            break;
        }
        
        level utility::flag_waitopen_all_array( power_flags );
        utility::ent_flag_waitopen_any( "ft_jp_activated" );
        level utility::flag_clear( self.var_f0e4330fc19232d3 );
        thread set_jumppad_path( undefined, !isdefined( self.power_on_flag ) );
        waitframe();
    }
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xad41bd55, Offset: 0x1984
// Size: 0x2ce
function private set_jumppad_path( var_1f42fb5079240912, b_first_spawned = 0 )
{
    self.current_path_name = undefined;
    self.current_path_index = undefined;
    self.v_start = undefined;
    self.v_handle = undefined;
    self.s_handle = undefined;
    self.v_end = undefined;
    self.sbl_end = undefined;
    self.s_monitor_org = undefined;
    
    if ( isdefined( var_1f42fb5079240912 ) )
    {
        self.current_path_name = self.paths[ var_1f42fb5079240912 ][ "name" ];
        self.current_path_index = var_1f42fb5079240912;
        self.v_start = self.paths[ var_1f42fb5079240912 ][ "start" ];
        self.v_end = self.paths[ var_1f42fb5079240912 ][ "end" ];
        self.sbl_end = self.paths[ var_1f42fb5079240912 ][ "end_scriptable" ];
        self.v_handle = self.paths[ var_1f42fb5079240912 ][ "handle" ];
        self.s_handle = self.paths[ var_1f42fb5079240912 ][ "handle_struct" ];
        self.s_monitor_org = self.paths[ var_1f42fb5079240912 ][ "monitor_org" ];
    }
    
    utility::ent_flag_wait( "done_init" );
    
    if ( !level utility::flag( self.var_f0e4330fc19232d3 ) )
    {
        if ( b_first_spawned )
        {
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "model", "can_use" );
            level utility::flag_set( self.var_f0e4330fc19232d3 );
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", "ready" );
            self.mdl_arrow_scriptable.b_showing = 1;
        }
        else
        {
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "model", "can_use_off" );
            self.scriptable utility::function_32b24db3127bff40( "left_monitor", "no_power" );
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "left_arrow", "no_power" );
            self.scriptable utility::function_32b24db3127bff40( "right_monitor", "no_power" );
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "right_arrow", "no_power" );
            self.scriptable utility::function_32b24db3127bff40( "light", "no_power" );
            self.landingpad utility::function_32b24db3127bff40( "light", "no_power" );
            
            if ( isdefined( self.mdl_arrow_scriptable ) )
            {
                self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", "no_power" );
                self.mdl_arrow_scriptable.b_showing = 0;
            }
        }
    }
    
    self.var_2efb9165f56da06d = 0;
    thread set_fasttravel_jumppad_arrow( b_first_spawned );
    self.var_2efb9165f56da06d = 1;
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x3d958785, Offset: 0x1c5a
// Size: 0x44
function private function_ace337cfacc18611( sbl_end )
{
    var_164fc97cb73e22c1 = get_end_fasttravel_jumppad( sbl_end );
    
    if ( !isdefined( var_164fc97cb73e22c1.var_f0e4330fc19232d3 ) )
    {
        return 0;
    }
    
    return level utility::flag( var_164fc97cb73e22c1.var_f0e4330fc19232d3 );
}

// Namespace zm_fasttravel_jumppad
// Params 1
// Checksum 0xf057fdca, Offset: 0x1ca7
// Size: 0xad
function get_end_fasttravel_jumppad( sbl_end )
{
    var_164fc97cb73e22c1 = undefined;
    
    foreach ( jumppad in level.a_jumppads )
    {
        if ( jumppad.script_noteworthy != sbl_end.script_parameters )
        {
            continue;
        }
        
        var_164fc97cb73e22c1 = jumppad;
        break;
    }
    
    return var_164fc97cb73e22c1;
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0xf2bc5671, Offset: 0x1d5d
// Size: 0x24a
function private set_fasttravel_jumppad_arrow( b_first_spawned )
{
    if ( !( isdefined( self.mdl_arrow_scriptable ) && isdefined( self.scriptable ) ) || !self.mdl_arrow_scriptable.b_showing )
    {
        return;
    }
    
    var_6a558d17bc40667b = 1;
    var_fa8eacad71d8dd50 = 0;
    var_917565ec8de9b531 = undefined;
    
    for ( i = 0; i < 2 ; i++ )
    {
        monitor_path_end = self.paths[ i ][ "end_scriptable" ];
        var_2efb9165f56da06d = self.paths[ i ][ "is_monitor_enable" ];
        is_online = function_ace337cfacc18611( monitor_path_end );
        can_be_used = is_online && !utility::ent_flag( "ft_jp_cooldown" );
        var_9dfeef2d1cf5839a = undefined;
        
        if ( utility::ent_flag( "ft_jp_activated" ) )
        {
            var_9dfeef2d1cf5839a = var_2efb9165f56da06d ? "offline" : "active";
        }
        
        if ( !isdefined( var_9dfeef2d1cf5839a ) )
        {
            var_9dfeef2d1cf5839a = can_be_used ? "ready" : "offline";
        }
        
        var_2d840917563c9f70 = i == 0 ? "right_monitor" : "left_monitor";
        var_627c97aded6f15d = i == 0 ? "right_arrow" : "left_arrow";
        self.scriptable utility::function_32b24db3127bff40( var_2d840917563c9f70, var_9dfeef2d1cf5839a );
        self.mdl_arrow_scriptable utility::function_32b24db3127bff40( var_627c97aded6f15d, var_9dfeef2d1cf5839a );
        
        if ( !can_be_used )
        {
            var_fa8eacad71d8dd50++;
        }
    }
    
    if ( utility::ent_flag( "ft_jp_cooldown" ) || var_fa8eacad71d8dd50 >= 2 )
    {
        var_6a558d17bc40667b = 0;
    }
    
    self.landingpad utility::function_7c10ea82c1e305b8( "light", "ready" );
    str_state = utility::ent_flag( "ft_jp_activated" ) ? "active" : undefined;
    
    if ( !isdefined( str_state ) )
    {
        str_state = var_6a558d17bc40667b ? "ready" : "offline";
    }
    
    self.scriptable utility::function_7c10ea82c1e305b8( "light", str_state );
    self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", str_state );
    
    for ( i = 0; i < 2 ; i++ )
    {
        thread function_bc7123b00a0306d0( i );
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x5c929453, Offset: 0x1faf
// Size: 0xbc
function private function_bc7123b00a0306d0( var_1f42fb5079240912 )
{
    level endon( #"game_ended" );
    jumppad = self;
    monitor_path_end = jumppad.paths[ var_1f42fb5079240912 ][ "end_scriptable" ];
    is_online = jumppad function_ace337cfacc18611( monitor_path_end );
    can_be_used = is_online && !jumppad utility::ent_flag( "ft_jp_cooldown" );
    
    if ( can_be_used )
    {
        return;
    }
    
    while ( !is_online || jumppad utility::ent_flag( "ft_jp_cooldown" ) || jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        wait 1;
        is_online = jumppad function_ace337cfacc18611( monitor_path_end );
    }
    
    jumppad set_jumppad_path();
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0x5b2a091a, Offset: 0x2073
// Size: 0x1e4
function private function_c50b15aa808ef6ab( var_6f140d1fbbdc7ed0 = 0, player )
{
    level endon( #"game_ended" );
    
    if ( !is_jumppads_enabled() )
    {
        return;
    }
    
    jumppad = self.myparent;
    monitor_path_index = jumppad function_eb155cd88a9a0252( player );
    
    if ( isdefined( monitor_path_index ) )
    {
        var_1f42fb5079240912 = monitor_path_index;
    }
    else
    {
        return;
    }
    
    if ( isdefined( jumppad.power_on_flag ) && !level utility::flag( jumppad.power_on_flag ) && !level utility::flag( "open_sesame" ) )
    {
        return;
    }
    
    if ( jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        return;
    }
    
    if ( jumppad utility::ent_flag( "ft_jp_cooldown" ) )
    {
        return;
    }
    
    monitor_path_end = jumppad.paths[ var_1f42fb5079240912 ][ "end_scriptable" ];
    is_online = jumppad function_ace337cfacc18611( monitor_path_end );
    
    if ( !var_6f140d1fbbdc7ed0 && !is_online )
    {
        return;
    }
    
    var_3bfa2559e816889b = getplayersinradius( jumppad.origin, 85 );
    
    foreach ( player in var_3bfa2559e816889b )
    {
        if ( !isalive( player ) || !isplayer( player ) )
        {
            continue;
        }
        
        if ( player::isinlaststand( player ) )
        {
            return;
        }
    }
    
    if ( isdefined( player ) && player isemoteactive() )
    {
        return;
    }
    
    if ( isdefined( level._fasttravel[ "override_player_can_use_fasttravel" ] ) )
    {
        return [[ level._fasttravel[ "override_player_can_use_fasttravel" ] ]]( self, player );
    }
    
    return var_1f42fb5079240912;
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0x4d47706e, Offset: 0x2260
// Size: 0x491
function private fasttravel_interact_hint_callback( interact, player )
{
    jumppad = interact.myparent;
    fasttravel_title = interact.fasttravel_title;
    fasttravel_icon = interact.fasttravel_icon;
    var_1f42fb5079240912 = jumppad function_eb155cd88a9a0252( player );
    monitor_path_end = jumppad.paths[ var_1f42fb5079240912 ][ "end_scriptable" ];
    is_online = jumppad function_ace337cfacc18611( monitor_path_end );
    
    if ( isdefined( var_1f42fb5079240912 ) )
    {
        if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) && !is_online )
        {
            jumppad.scriptable utility::function_32b24db3127bff40( "left_location", "default" );
            jumppad.scriptable utility::function_32b24db3127bff40( "right_location", "default" );
        }
        else if ( !isdefined( jumppad.power_on_flag ) || level utility::flag( jumppad.power_on_flag ) )
        {
            left_location_state = var_1f42fb5079240912 == 0 ? "default" : "jumppad_" + jumppad.jumppad_index;
            right_location_state = var_1f42fb5079240912 == 0 ? "jumppad_" + jumppad.jumppad_index : "default";
            jumppad.scriptable utility::function_32b24db3127bff40( "left_location", left_location_state );
            jumppad.scriptable utility::function_32b24db3127bff40( "right_location", right_location_state );
            jumppad thread function_a2630cd13e187c2();
        }
    }
    else
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    var_fe1c538f0ecad56c = jumppad.paths[ var_1f42fb5079240912 ][ "name" ];
    jumppad.var_3f77d5fa92c1edbb = jumppad function_e70c9567a16f753d( var_fe1c538f0ecad56c );
    jumppad.var_cf8291d7325504a5 = jumppad.var_3f77d5fa92c1edbb;
    
    if ( !is_jumppads_enabled() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !is_online && ( !isdefined( jumppad.power_on_flag ) || level utility::flag( jumppad.power_on_flag ) ) && !jumppad utility::ent_flag( "ft_jp_cooldown" ) )
    {
        return { #interactable:0, #aux_text:&"zm_sat_firefly/jumppad_desc_offline", #buttoncallout:jumppad.var_f23e8f1f1a679229, #icon:fasttravel_icon, #description:fasttravel_title, #title:jumppad.var_3f77d5fa92c1edbb, #string:&"zm_sat_firefly/jumppad_desc_offline", #type:"HINT_BUTTON" };
    }
    
    hint_callback = zm_fasttravel::setup_fasttravel_hintstring( interact, player );
    
    if ( isdefined( jumppad.power_on_flag ) && !level utility::flag( jumppad.power_on_flag ) )
    {
        hint_callback.var_776a268784e089af = undefined;
        hint_callback.icon_text_value = undefined;
    }
    
    if ( jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        hint_callback.var_776a268784e089af = undefined;
        hint_callback.icon_text_value = undefined;
        hint_callback.buttoncallout = undefined;
        hint_callback.interactable = 0;
        
        if ( jumppad.monitor_index == var_1f42fb5079240912 )
        {
            hint_callback.string = &"shared_hintstrings/fasttravel_desc_active";
            hint_callback.aux_text = &"shared_hintstrings/fasttravel_desc_active";
        }
    }
    
    return { #interactable:hint_callback.interactable, #aux_text:hint_callback.aux_text, #buttoncallout:hint_callback.buttoncallout, #params:hint_callback.params, #icon_text_value:hint_callback.icon_text_value, #var_776a268784e089af:hint_callback.var_776a268784e089af, #icon:fasttravel_icon, #description:fasttravel_title, #title:hint_callback.description, #string:hint_callback.string, #type:hint_callback.type };
}

// Namespace zm_fasttravel_jumppad
// Params 0, eflags: 0xc
// Checksum 0x40532dc6, Offset: 0x26fa
// Size: 0x54
function private function_a2630cd13e187c2()
{
    self notify( #"hash_5e7b38dcc519e674" );
    self endon( #"hash_5e7b38dcc519e674" );
    wait 0.75;
    self.scriptable utility::function_32b24db3127bff40( "left_location", "default" );
    self.scriptable utility::function_32b24db3127bff40( "right_location", "default" );
}

// Namespace zm_fasttravel_jumppad
// Params 1
// Checksum 0x1a082a23, Offset: 0x2756
// Size: 0x23b
function function_eb155cd88a9a0252( player )
{
    jumppad = self;
    
    for ( i = 0; i < 2 ; i++ )
    {
        fwd_base_angles = anglestoforward( jumppad.scriptable.origin );
        
        if ( i == 0 )
        {
            right_monitor_org = jumppad.paths[ i ][ "monitor_org" ];
            var_d9bc126cd178e30f = fwd_base_angles * -24 + right_monitor_org + ( 0, 0, 48 );
        }
        else
        {
            left_monitor_org = jumppad.paths[ i ][ "monitor_org" ];
            var_7f330ec49fa52084 = fwd_base_angles * -24 + left_monitor_org + ( 0, 0, 48 );
        }
        
        org = i == 0 ? right_monitor_org : left_monitor_org;
        close_org = i == 0 ? var_d9bc126cd178e30f : var_7f330ec49fa52084;
    }
    
    var_30736d696a032221 = cos( 41.5 );
    var_d638c536362e6cb9 = cos( 60 );
    
    if ( isplayer( player ) && player getcamerathirdperson() )
    {
        tracestart = player getcamerathirdpersonorigin();
        var_30736d696a032221 = cos( 80 );
    }
    
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    var_f23ba2a621d685da = vectordot( playerlookdir, vectornormalize( right_monitor_org - player.origin ) );
    var_f6e3f12e2d4d627b = vectordot( playerlookdir, vectornormalize( left_monitor_org - player.origin ) );
    tracestart = player geteye();
    var_4c4481566768ddf4 = distance2dsquared( tracestart, var_d9bc126cd178e30f );
    var_8b9dd8cb18073c7d = distance2dsquared( tracestart, var_7f330ec49fa52084 );
    
    if ( var_f23ba2a621d685da > var_30736d696a032221 && var_f23ba2a621d685da > var_f6e3f12e2d4d627b || var_4c4481566768ddf4 < squared( 33 ) && var_f23ba2a621d685da > var_d638c536362e6cb9 && var_f23ba2a621d685da > var_f6e3f12e2d4d627b )
    {
        return 0;
    }
    
    if ( var_f6e3f12e2d4d627b > var_30736d696a032221 || var_8b9dd8cb18073c7d < squared( 33 ) && var_f6e3f12e2d4d627b > var_d638c536362e6cb9 )
    {
        return 1;
    }
    
    return;
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x69dbe5b8, Offset: 0x2999
// Size: 0xab
function private fasttravel_jumppad_interact_used( activator )
{
    level endon( #"game_ended" );
    jumppad = self.myparent;
    
    if ( jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        return;
    }
    
    monitor_index = function_c50b15aa808ef6ab( undefined, activator );
    
    if ( !isdefined( monitor_index ) )
    {
        return;
    }
    
    if ( !activator currency::attempt_purchase( #"essence", jumppad.script_cost, 1, 0, #"fast_travel" ) )
    {
        return;
    }
    
    jumppad utility::ent_flag_set( "ft_jp_activated" );
    jumppad.monitor_index = monitor_index;
    thread fasttravel_jumppad_activated( activator );
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x79b555df, Offset: 0x2a4c
// Size: 0x1df
function private fasttravel_jumppad_activated( activator )
{
    level endon( #"game_ended" );
    jumppad = self.myparent;
    self.activator = activator;
    jumppad.time_activated = gettime();
    activator function_660b6423290aca9a( jumppad, "ft_jp_activated", "on_ft_jp_activated" );
    
    if ( !isdefined( jumppad.var_f3810dac112a83b9 ) )
    {
        jumppad.var_f3810dac112a83b9 = 0;
    }
    
    if ( !isdefined( jumppad.var_d9741d7275189f0a ) )
    {
        jumppad.var_d9741d7275189f0a = 0;
    }
    
    jumppad.paths[ jumppad.monitor_index ][ "is_monitor_enable" ] = 0;
    self.var_2efb9165f56da06d = jumppad.paths[ jumppad.monitor_index ][ "is_monitor_enable" ];
    jumppad set_jumppad_path( jumppad.monitor_index );
    fasttravel_jumppad_watchenter( jumppad, activator );
    
    if ( jumppad.attractor )
    {
        if ( jumppad.attractor_ent )
        {
            jumppad.attractor_ent delete();
        }
        
        level zombie_attractor_manager::remove_attractor( jumppad.attractor );
        jumppad.attractor = undefined;
        
        /#
            iprintlnbold( "<dev string:x1f3>" + self.script_noteworthy + "<dev string:x1fd>" + 0 );
        #/
    }
    
    jumppad utility::ent_flag_clear( "ft_jp_activated" );
    jumppad.paths[ jumppad.monitor_index ][ "is_monitor_enable" ] = 1;
    self.var_2efb9165f56da06d = jumppad.paths[ jumppad.monitor_index ][ "is_monitor_enable" ];
    
    if ( jumppad.power_on_flag && !level utility::flag( jumppad.power_on_flag ) )
    {
        return;
    }
    
    fasttravel_jumppad_cooldown();
}

// Namespace zm_fasttravel_jumppad
// Params 0, eflags: 0x4
// Checksum 0xf0e5270f, Offset: 0x2c33
// Size: 0x3c6
function private fasttravel_jumppad_cooldown()
{
    level endon( #"game_ended" );
    jumppad = self.var_7899dd4d8ac31d1a;
    var_82e30c4150fe2cf4 = self.myparent;
    
    if ( isdefined( level.override_trap_duration ) )
    {
        wait_dur = level.override_trap_duration;
    }
    else
    {
        wait_dur = 20;
    }
    
    /#
        if ( getdvarint( @"hash_a2a811a005c27ce7", 0 ) )
        {
            wait_dur = level.var_d6ac96657b3d40e7;
        }
    #/
    
    foreach ( player in level.players )
    {
        info = { #current_cooldown_time:wait_dur, #player:player };
        
        if ( !isdefined( jumppad.interact.var_b8b1708ca1ae7d42 ) )
        {
            jumppad.interact.var_b8b1708ca1ae7d42 = [];
        }
        
        jumppad.interact.var_b8b1708ca1ae7d42[ jumppad.interact.var_b8b1708ca1ae7d42.size ] = info;
    }
    
    jumppad utility::ent_flag_set( "ft_jp_cooldown" );
    level function_660b6423290aca9a( jumppad, "ft_jp_cooldown", "on_ft_jp_cooldown" );
    jumppad.scriptable utility::function_7c10ea82c1e305b8( "light", "cooldown" );
    jumppad.scriptable utility::function_32b24db3127bff40( "left_monitor", "cooldown" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "left_arrow", "cooldown" );
    jumppad.scriptable utility::function_32b24db3127bff40( "right_monitor", "cooldown" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "right_arrow", "cooldown" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", "cooldown" );
    jumppad.sbl_end utility::function_7c10ea82c1e305b8( "light", "ready" );
    
    while ( wait_dur > 0 )
    {
        wait 1;
        wait_dur--;
        
        foreach ( info in jumppad.interact.var_b8b1708ca1ae7d42 )
        {
            info.current_cooldown_time = wait_dur;
        }
        
        if ( wait_dur < 1 )
        {
            jumppad thread set_jumppad_path( undefined );
        }
    }
    
    jumppad.scriptable utility::function_7c10ea82c1e305b8( "light", "ready" );
    jumppad.scriptable utility::function_32b24db3127bff40( "left_monitor", "ready" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "left_arrow", "ready" );
    jumppad.scriptable utility::function_32b24db3127bff40( "right_monitor", "ready" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "right_arrow", "ready" );
    jumppad.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", "ready" );
    jumppad.interact.var_b8b1708ca1ae7d42 = undefined;
    jumppad utility::ent_flag_clear( "ft_jp_cooldown" );
    jumppad set_jumppad_path( undefined );
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xd0d06373, Offset: 0x3001
// Size: 0x533
function private fasttravel_jumppad_watchenter( jumppad, activator )
{
    level endon( #"game_ended" );
    jumppad = self.myparent;
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    result = undefined;
    
    while ( true )
    {
        var_cb0209b713fe3e13 = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        
        if ( var_cb0209b713fe3e13 > 20 )
        {
            break;
        }
        else if ( result.var_94d1ab5da995e573 || jumppad.power_on_flag && !level utility::flag( jumppad.power_on_flag ) )
        {
            break;
        }
        
        if ( var_cb0209b713fe3e13 / 20 < 0.5 )
        {
            jumppad thread function_46b561dda2210a1c( "active" );
        }
        else
        {
            jumppad thread function_46b561dda2210a1c( "active_warning" );
        }
        
        var_9764a587d92077ea = getentarrayinradius( undefined, undefined, jumppad.origin + ( 0, 0, 40 ), 50 );
        
        foreach ( ent in var_9764a587d92077ea )
        {
            if ( isdefined( level._fasttravel[ "override_jumppad_watchEnter" ] ) )
            {
                result = [[ level._fasttravel[ "override_jumppad_watchEnter" ] ]]( jumppad, ent );
                
                if ( result.var_94d1ab5da995e573 )
                {
                    break;
                }
            }
            
            if ( !isalive( ent ) )
            {
                continue;
            }
            
            if ( isplayer( ent ) )
            {
                if ( ent bgb::is_active( "anywhere_but_here" ) )
                {
                    continue;
                }
                
                if ( ent utility::ent_flag( "player_ft_jp_jumping" ) )
                {
                    continue;
                }
                
                if ( ent.ismutantinjection || ent.mutantinjectiontransformed )
                {
                    continue;
                }
                
                if ( ent killstreak_utility::is_using_killstreak() )
                {
                    var_359cad62d73f79e5 = ent killstreak_utility::get_using_killstreaks();
                    var_f485422f78ea700e = 0;
                    var_915fe9724b881bf1 = 0;
                    
                    foreach ( killstreak in var_359cad62d73f79e5 )
                    {
                        if ( !killstreak )
                        {
                            continue;
                        }
                        
                        var_2cc9ca3e902aff51 = isstring( killstreak ) ? killstreak : killstreak.streakname;
                        
                        if ( !var_2cc9ca3e902aff51 || !isstring( var_2cc9ca3e902aff51 ) )
                        {
                            continue;
                        }
                        
                        if ( var_2cc9ca3e902aff51 == "sentry_gun" )
                        {
                            var_f485422f78ea700e = 1;
                            break;
                        }
                        
                        if ( var_2cc9ca3e902aff51 == "dawg" )
                        {
                            var_915fe9724b881bf1 = 1;
                            break;
                        }
                    }
                    
                    if ( !var_f485422f78ea700e && !var_915fe9724b881bf1 )
                    {
                        continue;
                    }
                }
            }
            else
            {
                if ( !( isdefined( ent.aicategory ) && isdefined( ent.health ) && isdefined( ent.maxhealth ) ) || ent.type != "zombie" || !zm_utility::is_active_zombie( ent ) )
                {
                    continue;
                }
                
                if ( ent utility::function_9f2c41c1dcc8c94( "brainrot", "brainrot_on" ) )
                {
                    continue;
                }
                
                if ( ai::is_doing_traversal( ent ) )
                {
                    continue;
                }
                
                if ( ent.var_8b8cea407e5fee86 )
                {
                    continue;
                }
                
                if ( ent.aicategory != "normal" )
                {
                    current_time = utility::function_6f5d2e1f1ff70482( gettime() );
                    
                    if ( !isdefined( ent.var_a462751bcfbb8f32 ) || current_time - ent.var_f0fa83bb73a3d56 > 5 )
                    {
                        ent.var_f0fa83bb73a3d56 = utility::function_6f5d2e1f1ff70482( gettime() );
                        ent zombie_stun::stun_ai( 0.25 );
                    }
                    
                    if ( !isdefined( ent.var_a462751bcfbb8f32 ) || current_time - ent.var_a462751bcfbb8f32 > 2 )
                    {
                        damage_perc = ent.aicategory == "special" ? 25 : 18;
                        damage_num = damage_perc * 0.01 * ent.maxhealth;
                        
                        if ( ent.health - damage_num > 0 )
                        {
                            ent.var_a462751bcfbb8f32 = utility::function_6f5d2e1f1ff70482( gettime() );
                            ent dodamage( damage_num, ent.origin, activator, activator, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 536936448 );
                            continue;
                        }
                    }
                    else
                    {
                        continue;
                    }
                }
            }
            
            if ( ent.var_d1c4c78b9fb7d153 )
            {
                continue;
            }
            
            ent.var_d1c4c78b9fb7d153 = 1;
            
            if ( isplayer( ent ) )
            {
                ent playrumblelooponentity( "low_highfreq" );
                ent thread fasttravel_jumppad_player_enter( jumppad );
            }
            else
            {
                ent thread function_232232fd1e1f4c44( jumppad, activator );
            }
            
            if ( var_9764a587d92077ea.size > 0 )
            {
                wait 1;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x1cdc4de8, Offset: 0x353c
// Size: 0x18c
function private function_46b561dda2210a1c( var_cf861766ba2efd44 )
{
    if ( self.var_cf861766ba2efd44 == var_cf861766ba2efd44 )
    {
        return;
    }
    
    level endon( #"ft_jp_cooldown" );
    self.var_cf861766ba2efd44 = var_cf861766ba2efd44;
    
    switch ( var_cf861766ba2efd44 )
    {
        case #"hash_bee8aefcdf5a9a8f":
            self.scriptable utility::function_7c10ea82c1e305b8( "light", "active" );
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( "light", "active" );
            var_d2e5c1af6192bf34 = self.monitor_index == 0 ? "right_monitor" : "left_monitor";
            var_27df7ec234583129 = self.monitor_index == 0 ? "right_arrow" : "left_arrow";
            self.scriptable utility::function_32b24db3127bff40( var_d2e5c1af6192bf34, "active" );
            self.mdl_arrow_scriptable utility::function_32b24db3127bff40( var_27df7ec234583129, "active" );
            self.sbl_end utility::function_7c10ea82c1e305b8( "light", "active" );
            break;
        case #"hash_f2fc9daf75707f7c":
            self.scriptable utility::function_7c10ea82c1e305b8( "light", "active_warning" );
            var_b659106f96277915 = 0.5;
            var_ae5b0bc5cbc75184 = 20 * var_b659106f96277915 / 2;
            thread function_d1d0cc42eec0d177( var_ae5b0bc5cbc75184, "slow_blink" );
            wait var_ae5b0bc5cbc75184;
            thread function_d1d0cc42eec0d177( var_ae5b0bc5cbc75184, "fast_blink" );
            break;
        default:
            break;
    }
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xfc70c378, Offset: 0x36d0
// Size: 0x11c
function private function_d1d0cc42eec0d177( time, var_68c4832a66a5bd58 )
{
    level endon( #"ft_jp_cooldown" );
    var_e273a3c3affc79c0 = var_68c4832a66a5bd58 == "slow_blink" ? 0.5 : 0.2;
    var_427b3d2c2f8fb546 = utility::function_6f5d2e1f1ff70482( gettime() );
    starting_time_blink = utility::function_6f5d2e1f1ff70482( gettime() );
    
    while ( utility::ent_flag( "ft_jp_activated" ) )
    {
        var_cb0209b713fe3e13 = utility::function_6f5d2e1f1ff70482( gettime() ) - var_427b3d2c2f8fb546;
        
        if ( var_cb0209b713fe3e13 > time )
        {
            break;
        }
        
        var_accd314243f33286 = utility::function_6f5d2e1f1ff70482( gettime() ) - starting_time_blink;
        
        if ( var_accd314243f33286 == 0 || var_accd314243f33286 > var_e273a3c3affc79c0 )
        {
            var_7f5aa577c714d7c5 = self.scriptable utility::function_9f2c41c1dcc8c94( "light", "active" ) ? "active_warning" : "active";
            self.scriptable utility::function_7c10ea82c1e305b8( "light", var_7f5aa577c714d7c5 );
            starting_time_blink = utility::function_6f5d2e1f1ff70482( gettime() );
        }
        
        waitframe();
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1
// Checksum 0xfac1aa88, Offset: 0x37f4
// Size: 0xd0
function function_4f9ffedb29cd4a7e( params )
{
    level endon( #"end_firesale_start" );
    
    foreach ( jumppad in level.a_jumppads )
    {
        if ( !isdefined( jumppad.model ) )
        {
            continue;
        }
        
        if ( !isdefined( jumppad.n_original_cost ) )
        {
            jumppad.n_original_cost = jumppad.script_cost;
            jumppad.script_cost = 10;
        }
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x200bb733, Offset: 0x38cc
// Size: 0xad
function private firesale_end( params )
{
    foreach ( jumppad in level.a_jumppads )
    {
        if ( isdefined( jumppad.n_original_cost ) )
        {
            jumppad.script_cost = jumppad.n_original_cost;
            jumppad.n_original_cost = undefined;
        }
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x73255020, Offset: 0x3981
// Size: 0x134
function private fasttravel_jumppad_player_enter( jumppad )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::ent_flag_set( "player_ft_jp_jumping" );
    var_650afee77554228c = { #jp_end:jumppad.sbl_end, #jumppad:jumppad };
    callback::remove( #"player_death", &function_ec784a6ec6152322, var_650afee77554228c );
    callback::remove( #"player_disconnect", &function_ec784a6ec6152322, var_650afee77554228c );
    callback::remove( #"player_laststand", &function_ec784a6ec6152322, var_650afee77554228c );
    callback::add( #"player_death", &function_ec784a6ec6152322, var_650afee77554228c );
    callback::add( #"player_disconnect", &function_ec784a6ec6152322, var_650afee77554228c );
    callback::add( #"player_laststand", &function_ec784a6ec6152322, var_650afee77554228c );
    jumppad.player = self;
    jumppad.var_f3810dac112a83b9++;
    jumppad thread launch_nearby_zombies( self );
    thread function_517ee20ade4a94a0( jumppad );
    jumppad utility::ent_flag_set( "ft_jp_occupied" );
    wait 1;
    jumppad utility::ent_flag_clear( "ft_jp_occupied" );
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xb94c1540, Offset: 0x3abd
// Size: 0x135
function private function_ec784a6ec6152322( sparams, var_650afee77554228c )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    jumppad = var_650afee77554228c.jumppad;
    jp_end = var_650afee77554228c.jp_end;
    jumppad.var_f3810dac112a83b9--;
    
    if ( jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        str_state = jumppad.var_f3810dac112a83b9 > 0 ? "active_warning" : "active";
    }
    else
    {
        str_state = "ready";
    }
    
    jp_end utility::function_7c10ea82c1e305b8( "light", str_state );
    jp_end utility::function_7c10ea82c1e305b8( "base", "launch_impact" );
    jp_end utility::function_7c10ea82c1e305b8( "audio", "launch_impact" );
    
    if ( self.var_33681be528280814 )
    {
        self.var_33681be528280814 delete();
    }
    
    if ( self )
    {
        utility::function_7c10ea82c1e305b8( "fasttravel_jumppad", "default" );
        level utility::flag_wait( "zm_game_over" );
        pbgpostfxbundleend( self, "sat_zm_speed_blur_jumppad" );
        self notify( #"hash_4e3a3286f4001d78" );
        self unlink();
    }
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0xc
// Checksum 0x1319cec2, Offset: 0x3bfa
// Size: 0x182
function private launch_nearby_zombies( player )
{
    self notify( #"hash_65fd39a4374019d2" );
    self endon( #"hash_65fd39a4374019d2" );
    
    if ( !self.attractor )
    {
        self.attractor_ent = utility::spawn_model( "tag_origin", self.scriptable.origin, self.scriptable.angles );
        self.attractor = zombie_attractor_manager::add_attractor( self.attractor_ent, 0, 250, 0, undefined, &function_d77f501bc4974a9 );
        
        /#
            iprintlnbold( "<dev string:x1f3>" + self.script_noteworthy + "<dev string:x1fd>" + 1 );
        #/
    }
    
    self.var_84a416d87f32ced1 = self.var_d9741d7275189f0a + 9;
    var_8011a8ea1ab5c2f0 = gettime() + 6000;
    
    while ( var_8011a8ea1ab5c2f0 > gettime() && self.var_d9741d7275189f0a < self.var_84a416d87f32ced1 && utility::ent_flag( "ft_jp_activated" ) && isalive( player ) )
    {
        wait randomfloatrange( 0.4, 0.7 );
    }
    
    if ( self.attractor )
    {
        if ( self.attractor_ent )
        {
            self.attractor_ent delete();
        }
        
        level zombie_attractor_manager::remove_attractor( self.attractor );
        self.attractor = undefined;
        
        /#
            iprintlnbold( "<dev string:x1f3>" + self.script_noteworthy + "<dev string:x1fd>" + 0 );
        #/
    }
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0x3c59e279, Offset: 0x3d84
// Size: 0xad, Type: bool
function private function_d77f501bc4974a9( attractor, zombie )
{
    if ( !isdefined( zombie.aicategory ) || zombie.type != "zombie" || !zm_utility::is_active_zombie( zombie ) )
    {
        return false;
    }
    
    if ( self.var_d9741d7275189f0a >= self.var_84a416d87f32ced1 )
    {
        return false;
    }
    
    if ( zombie.b_ignore_fasttravel_jumppad )
    {
        return false;
    }
    
    if ( zombie utility::function_9f2c41c1dcc8c94( "base", "base_purple_eyes" ) || zombie utility::function_9f2c41c1dcc8c94( "brainrot", "brainrot_on" ) )
    {
        return false;
    }
    
    if ( ai::is_doing_traversal( zombie ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x730260cc, Offset: 0x3e3a
// Size: 0x5da
function private function_517ee20ade4a94a0( jumppad )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    v_end = jumppad.v_end;
    v_start = jumppad.v_start;
    v_handle = jumppad.v_handle;
    jp_end = jumppad.sbl_end;
    jumppad utility::delaythread( 1, &play_vo_banter, #"hash_f63f3fe263f9e1c2", 180, self );
    self canceloffhands();
    self releaseoffhand();
    killstreakdeploy::streakdeploy_cancelalldeployments();
    self notify( #"equip_deploy_cancel" );
    self stopgestureviewmodel();
    self stopanimscriptsceneevent();
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
    
    function_660b6423290aca9a( jumppad, "player_ft_jp_entered", "on_player_ft_jp_entered" );
    thread function_841de8eff1f819a5( &function_21640a7b128edf3f, "player_ft_jp_exited", 10 );
    self.var_33681be528280814 = utility::spawn_tag_origin( self.origin, self.angles );
    self playerlinktodelta( self.var_33681be528280814, "tag_origin", 1, 180, 180, 180, 45, 1 );
    self earthquakeforplayer( 0.18, 0.5, jumppad.origin, 250 );
    thread function_b7430fcf9bcd3b74( self.var_33681be528280814, 0.15, "low_highfreq" );
    jumppad.scriptable utility::function_7c10ea82c1e305b8( "base", "launch" );
    jumppad.scriptable utility::function_7c10ea82c1e305b8( "audio", "launch" );
    self playlocalsound( #"hash_1c55e302b7a3ba67" );
    utility::function_7c10ea82c1e305b8( "fasttravel_jumppad", "launch" );
    pbgpostfxbundlestart( self, "sat_zm_speed_blur_jumppad" );
    var_d351bfdc03bee94a = distance( v_start, v_end );
    min_dist_travel_time = jumppad.s_handle.script_wait_01_min ?? 3;
    max_dist_travel_time = jumppad.s_handle.script_wait_01_max ?? 5;
    time = math::remap( var_d351bfdc03bee94a, 0, 2500, min_dist_travel_time, max_dist_travel_time );
    time = clamp( time, min_dist_travel_time, max_dist_travel_time );
    
    if ( player::isinlaststand( self ) )
    {
        level callback::add( #"hash_e03b7ef9f05c63b6", &function_2253c7d485ddaa04 );
    }
    
    jp_end utility::function_7c10ea82c1e305b8( "light", "active_warning" );
    var_64cf32a0e253f53f = jumppad.paths[ jumppad.current_path_index ][ "path_percent_override" ];
    self.var_33681be528280814 utility::function_8001268940441423( v_start, v_end, v_handle, time, jumppad.s_debug.var_c522f719aa2099c7, 1, var_64cf32a0e253f53f );
    self unlink();
    self.var_33681be528280814 delete();
    
    if ( !level.jumppad_ee_quest.rift_jumppad.var_94327e40bc639663 )
    {
        jumppad utility::delaythread( 2, &play_vo_banter, #"hash_1ee3af3143bafea", 180, self );
    }
    
    function_660b6423290aca9a( jumppad, "player_ft_jp_exited", "on_player_ft_jp_exited" );
    
    while ( var_64cf32a0e253f53f <= 1 && !self isonground() && !self isswimming() )
    {
        waitframe();
    }
    
    function_660b6423290aca9a( jumppad, "player_ft_jp_landed", "on_player_ft_jp_landed" );
    callback::remove( #"player_death", &function_ec784a6ec6152322, jumppad );
    callback::remove( #"player_disconnect", &function_ec784a6ec6152322, jumppad );
    callback::remove( #"player_laststand", &function_ec784a6ec6152322, jumppad );
    utility::ent_flag_clear( "player_ft_jp_jumping" );
    utility::function_7c10ea82c1e305b8( "fasttravel_jumppad", "default" );
    pbgpostfxbundleend( self, "sat_zm_speed_blur_jumppad" );
    earthquake( 0.75, 1, v_end, 512 );
    playrumbleonposition( "heavy_1s", v_end );
    self playrumbleonentity( "low_highfreq" );
    utility::delaycallendon( 1, "death_or_disconnect", &stoprumble, "low_highfreq" );
    
    if ( player::isinlaststand( self ) )
    {
        level callback::remove( #"hash_e03b7ef9f05c63b6", &function_2253c7d485ddaa04 );
    }
    
    var_a06d5e80cdd7fe44 = getplayersandaiarrayinradius( v_end, 512 );
    
    foreach ( ent in var_a06d5e80cdd7fe44 )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) )
        {
            if ( zm_utility::is_active_zombie( ent ) )
            {
                ent thread zombie_knockdown::function_6fc167d4a3590991( ent.origin );
            }
            
            continue;
        }
        else if ( ent == self )
        {
            continue;
        }
        
        vdir = vectornormalize( ent.origin - v_end + ( 0, 0, 10 ) );
        ent utility::delaycall( 0, &knockback, vdir, 500 );
    }
    
    if ( jumppad utility::ent_flag( "ft_jp_activated" ) )
    {
        str_state = jumppad.var_f3810dac112a83b9 > 0 ? "active_warning" : "active";
    }
    else
    {
        str_state = "ready";
    }
    
    if ( isdefined( jp_end ) )
    {
        jp_end utility::function_7c10ea82c1e305b8( "light", str_state );
        jp_end utility::function_7c10ea82c1e305b8( "base", "launch_impact" );
        jp_end utility::function_7c10ea82c1e305b8( "audio", "launch_impact" );
    }
    
    jumppad.var_f3810dac112a83b9--;
    wait 2;
    self.var_d1c4c78b9fb7d153 = 0;
    val::reset( "player_ft_jp_jumping", "ignoreme" );
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0xcb7b7145, Offset: 0x441c
// Size: 0x1a
function private function_2253c7d485ddaa04( cboutput )
{
    cboutput.preventdamage = 1;
}

// Namespace zm_fasttravel_jumppad
// Params 3, eflags: 0x4
// Checksum 0x8364f108, Offset: 0x443e
// Size: 0x74
function private function_660b6423290aca9a( jumppad, str_notify, var_531b7acf112cb1d )
{
    params = spawnstruct();
    params.jumppad = jumppad;
    params.interact = jumppad.interact;
    params.player = self;
    level notify( str_notify );
    self notify( str_notify );
    callback::callback( var_531b7acf112cb1d, params );
}

// Namespace zm_fasttravel_jumppad
// Params 3, eflags: 0x4
// Checksum 0x363c663, Offset: 0x44ba
// Size: 0x91
function private function_841de8eff1f819a5( var_c5ebf0318d8ed1f4, str_notify, var_b0e7036baf2a1364 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self [[ var_c5ebf0318d8ed1f4 ]]( 1 );
    result = utility::waittill_notify_or_timeout_return( str_notify, var_b0e7036baf2a1364 );
    
    if ( result == "timeout" )
    {
        self.var_d1c4c78b9fb7d153 = 0;
        val::reset( "player_ft_jp_jumping", "ignoreme" );
        val::reset( "player_ft_jp_jumping", "ignore_playable_area_check" );
    }
    
    self [[ var_c5ebf0318d8ed1f4 ]]( 0 );
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x253fde80, Offset: 0x4553
// Size: 0xb7
function private function_21640a7b128edf3f( b_true = 1 )
{
    if ( b_true )
    {
        val::group_set( "player_ft_jp_jumping", 0 );
        zm_fasttravel::function_12b11b69ea8587b8( 1 );
        val::set( "player_ft_jp_jumping", "ignore_playable_area_check", 1 );
        val::set( "player_ft_jp_jumping", "allow_toggle_third_person", 0 );
        val::set( "player_ft_jp_jumping", "ignoreme", 1 );
        self capturnrate( 90, 135 );
        return;
    }
    
    val::group_reset( "player_ft_jp_jumping" );
    val::reset( "player_ft_jp_jumping", "ignore_playable_area_check" );
    val::reset( "player_ft_jp_jumping", "allow_toggle_third_person" );
    zm_fasttravel::function_12b11b69ea8587b8( 0 );
    self capturnrate( 999, 999 );
}

// Namespace zm_fasttravel_jumppad
// Params 3
// Checksum 0xdcfa1362, Offset: 0x4612
// Size: 0xba
function function_b7430fcf9bcd3b74( curve_link, n_scale, var_2c9997925f5b83e7 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    curve_link endon( #"death" );
    self endon( #"hash_4e3a3286f4001d78" );
    curve_link waittill( #"on_bezier_curve" );
    self setshowcontrail( 1 );
    
    while ( utility::ent_flag( "player_ft_jp_jumping" ) )
    {
        self earthquakeforplayer( n_scale, 0.1, self.origin, 64 );
        self playrumbleonentity( var_2c9997925f5b83e7 );
        wait 0.1;
    }
    
    self notify( #"hash_9cd906c92066876" );
    self setshowcontrail( 0 );
    self stoprumble( "low_highfreq" );
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xa25eb363, Offset: 0x46d4
// Size: 0x7f
function private function_232232fd1e1f4c44( jumppad, activator )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.b_ignore_fasttravel_jumppad )
    {
        return;
    }
    
    jumppad.zombie = self;
    jumppad.var_d9741d7275189f0a++;
    thread function_dd50d6a3e6deafc5( jumppad, activator );
    jumppad utility::ent_flag_set( "ft_jp_occupied" );
    wait 1;
    jumppad utility::ent_flag_clear( "ft_jp_occupied" );
}

// Namespace zm_fasttravel_jumppad
// Params 2, eflags: 0x4
// Checksum 0xdbe40e1d, Offset: 0x475b
// Size: 0x268
function private function_dd50d6a3e6deafc5( jumppad, activator )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.kiastring = #"zombie_kia_mission_kill";
    self.var_5d3022108c155ed4 = #"zombie_kia_mission_kill";
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.b_ignore_cleanup = 1;
    self motionwarpcancel();
    var_51e535e1ed3212a3 = jumppad.origin;
    
    if ( isdefined( jumppad.var_9e04c26d8d00b22 ) )
    {
        result = [[ jumppad.var_9e04c26d8d00b22 ]]( self, activator );
    }
    else if ( self.aicategory == "normal" )
    {
        start = jumppad.origin;
        end = jumppad.v_handle;
        var_a2edc5cf45eced9e = vectornormalize( end - start );
        self.ragdollimpactvector = var_a2edc5cf45eced9e * 15000;
        self.ragdollhitloc = "torso_lower";
        self.do_immediate_ragdoll = 1;
        callback::add( "killed_body_cloned", &function_4760c0b52f43fa4c );
    }
    else
    {
        self.forceannihilate = 1;
        curve_link = utility::spawn_tag_origin( self.origin, self.angles );
        self linkto( curve_link );
        var_d351bfdc03bee94a = distance( jumppad.v_start, jumppad.v_end );
        time = math::remap( var_d351bfdc03bee94a, 0, 2500, 3, 5 );
        time = clamp( time, 3, 5 );
        
        if ( !self.var_16347ea3a61cc834 )
        {
            path_percent = 0.15;
            time *= 2;
        }
        
        function_4e5a9d7a27d5931b( jumppad, curve_link, time, path_percent );
        var_51e535e1ed3212a3 = self.origin;
    }
    
    params = spawnstruct();
    params.scoreevent = #"zombie_kia_mission_kill";
    activator callback::callback( "zombie_score_event", params );
    utility::ent_flag_set( "ft_jp_kill" );
    self dodamage( self.health, var_51e535e1ed3212a3, activator, jumppad.scriptable, "MOD_UNKNOWN", undefined, undefined, undefined, 536936448 );
}

// Namespace zm_fasttravel_jumppad
// Params 1, eflags: 0x4
// Checksum 0x64e8e775, Offset: 0x49cb
// Size: 0x50
function private function_4760c0b52f43fa4c( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( self ) && isdefined( body ) )
    {
        body.origin += ( 0, 0, 25 );
    }
}

// Namespace zm_fasttravel_jumppad
// Params 4
// Checksum 0xa8f78b84, Offset: 0x4a23
// Size: 0x19c
function function_4e5a9d7a27d5931b( s_jumppad, curve_link, time, path_percent )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    curve_link utility::function_8001268940441423( s_jumppad.v_start, s_jumppad.v_end, s_jumppad.v_handle, time, s_jumppad.s_debug.var_c522f719aa2099c7, 0, path_percent );
    self unlink();
    
    if ( path_percent < 1 )
    {
        self.origin = curve_link.origin;
        curve_link delete();
        return;
    }
    
    self.origin = getclosestpointonnavmesh( s_jumppad.v_end );
    curve_link delete();
    
    do
    {
        waitframe();
    }
    while ( !self isonground() && !self isswimming() );
    
    nearby_ai = getaiarrayinradius( s_jumppad.v_end, 512 );
    
    foreach ( ai in nearby_ai )
    {
        if ( !zm_utility::is_active_zombie( ai ) || ai == self || ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            continue;
        }
        
        ai thread zombie_knockdown::function_6fc167d4a3590991( ai.origin );
    }
}

/#

    // Namespace zm_fasttravel_jumppad
    // Params 0, eflags: 0x4
    // Checksum 0xae230f77, Offset: 0x4bc7
    // Size: 0x11d, Type: dev
    function private init_fasttravel_jumppad_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x20a>" );
        devgui::add_devgui_func( "<dev string:x223>", "<dev string:x237>", &function_e0a5c5a06e0fb596 );
        devgui::add_devgui_func( "<dev string:x24c>", "<dev string:x26a>", &function_37699a881aa6d31b );
        devgui::add_devgui_func( "<dev string:x282>", "<dev string:x2a1>", &function_5b52b209f47fc626 );
        devgui::function_77df7fe7dd273e10();
        
        for ( i = 0; i < level.a_jumppads.size ; i++ )
        {
            s_jumppad = level.a_jumppads[ i ];
            s_jumppad.s_debug = spawnstruct();
            s_jumppad.s_debug.var_c522f719aa2099c7 = 0;
            devgui::function_9082edeb5db93280( "<dev string:x20a>" + s_jumppad.script_noteworthy );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2c5>", "<dev string:x2d5>" + s_jumppad.jumppad_index, &function_4e577742fdd2745 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2e5>", "<dev string:x300>" + s_jumppad.jumppad_index, &function_40feb13a6b1c574b );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace zm_fasttravel_jumppad
    // Params 0, eflags: 0x4
    // Checksum 0xa7240ae1, Offset: 0x4cec
    // Size: 0x49, Type: dev
    function private function_e0a5c5a06e0fb596()
    {
        for ( i = 0; i < level.a_jumppads.size ; i++ )
        {
            params = [];
            params[ params.size ] = i;
            function_4e577742fdd2745( params );
            wait 0.5;
        }
    }

    // Namespace zm_fasttravel_jumppad
    // Params 1, eflags: 0x4
    // Checksum 0x4ab8b3e6, Offset: 0x4d3d
    // Size: 0xd2, Type: dev
    function private function_4e577742fdd2745( params )
    {
        jumppad_index = int( params[ 0 ] );
        s_jumppad = level.a_jumppads[ jumppad_index ];
        
        if ( isdefined( s_jumppad.power_on_flag ) && !level utility::flag( s_jumppad.power_on_flag ) )
        {
            /#
                iprintlnbold( "<dev string:x313>" + s_jumppad.script_noteworthy + "<dev string:x33c>" );
            #/
            
            return;
        }
        
        if ( level utility::flag( s_jumppad.var_f0e4330fc19232d3 ) )
        {
            /#
                iprintlnbold( s_jumppad.script_noteworthy + "<dev string:x33e>" );
            #/
            
            return;
        }
        
        /#
            iprintlnbold( s_jumppad.script_noteworthy + "<dev string:x354>" );
        #/
        
        s_jumppad set_jumppad_path( undefined, 1 );
    }

    // Namespace zm_fasttravel_jumppad
    // Params 0, eflags: 0x4
    // Checksum 0x681128c9, Offset: 0x4e17
    // Size: 0x49, Type: dev
    function private function_37699a881aa6d31b()
    {
        for ( i = 0; i < level.a_jumppads.size ; i++ )
        {
            params = [];
            params[ params.size ] = i;
            function_40feb13a6b1c574b( params );
            wait 0.5;
        }
    }

    // Namespace zm_fasttravel_jumppad
    // Params 1, eflags: 0x4
    // Checksum 0xb4ebddf, Offset: 0x4e68
    // Size: 0x99, Type: dev
    function private function_40feb13a6b1c574b( params )
    {
        jumppad_index = int( params[ 0 ] );
        s_jumppad = level.a_jumppads[ jumppad_index ];
        s_jumppad.s_debug.var_c522f719aa2099c7 = !s_jumppad.s_debug.var_c522f719aa2099c7;
        
        /#
            iprintlnbold( "<dev string:x362>" + s_jumppad.script_noteworthy + "<dev string:x379>" + s_jumppad.s_debug.var_c522f719aa2099c7 );
        #/
    }

    // Namespace zm_fasttravel_jumppad
    // Params 0, eflags: 0x4
    // Checksum 0x4d1787d0, Offset: 0x4f09
    // Size: 0x40, Type: dev
    function private function_5b52b209f47fc626()
    {
        var_d8730b135fad8877 = !getdvarint( @"hash_a2a811a005c27ce7", 0 );
        setdvar( @"hash_a2a811a005c27ce7", var_d8730b135fad8877 );
        
        /#
            iprintlnbold( "<dev string:x37c>" + var_d8730b135fad8877 );
        #/
    }

#/
