// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_galileo.gsc  (hash_261cfdf8b9b007ab.gscc) (size: 15920 Bytes / 0x3e30 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcec96633 (3469305395)
// size ...... 15920 (0x3e30)
// includes .. 18  (offset: 0x39f4)
// strings ... 45  (offset: 0x3a84)
// dev strs .. 9   (offset: 0x3dc4)
// exports ... 35  (offset: 0x2428)
// cseg ...... 0x4fa + 0x1f2e (0x2428)
// imports ... 122 (offset: 0x29a0)
// animtree1 . 0   (offset: 0x3e30)
// animtree2 . 0   (offset: 0x3e30)
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_mq;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_ruby_galileo;

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0x5
// Checksum 0xa523cdd9, Offset: 0x518
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_galileo", undefined, undefined, &post_main );
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0x9dcb6382, Offset: 0x539
// Size: 0xa
function post_main()
{
    level thread init_galileo();
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0x16e1c8de, Offset: 0x54b
// Size: 0x393
function init_galileo()
{
    level endon( #"game_ended" );
    
    if ( utility::flag( "disable_galileo_spawn" ) )
    {
        return;
    }
    
    galileo_patrol_start_point_struct = utility::getstruct( "galileo_patrol_start_point", "script_noteworthy" );
    
    if ( isdefined( galileo_patrol_start_point_struct ) )
    {
        start_point_struct = galileo_patrol_start_point_struct;
        start_point = spawnstruct();
        start_point.origin = start_point_struct.origin;
        start_point.isstartpoint = 1;
        level.galileo_patrol_start_point = start_point;
        next_point_struct = start_point_struct;
        temp_point = start_point;
        final_point = undefined;
        
        while ( isdefined( next_point_struct.target ) )
        {
            next_point_struct = utility::getstruct( next_point_struct.target );
            
            if ( isvector( next_point_struct.origin ) )
            {
                next_point = spawnstruct();
                next_point.origin = next_point_struct.origin;
                next_point.prev = temp_point;
                temp_point.next = next_point;
                temp_point = next_point;
                final_point = temp_point;
                continue;
            }
            
            assertmsg( "<dev string:x24>" + temp_point );
        }
        
        level.galileo_patrol_start_point.prev = final_point;
        final_point.next = level.galileo_patrol_start_point;
    }
    
    utility::registersharedfunc( #"zombie_galileo", #"hash_3e9d23e9e22b6d6d", &function_7a4767b8a0311bc2 );
    level callback::add( "on_galileo_drone_killed", &function_da2d5773efbd7a15 );
    
    /#
        init_galileo_devgui();
    #/
    
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "ruby_papq_complete" );
    level callback::add( "on_round_start", &function_def1423c2f1eb0d7 );
    galileo_spawned = 0;
    
    for ( i = level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b.size - 1; i >= 0 ; i-- )
    {
        var_d0c6b7fe2f128d03 = level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b[ i ];
        
        if ( var_d0c6b7fe2f128d03.aitype == "zombie_galileo" )
        {
            spawn_galileo( level.galileo_patrol_start_point, var_d0c6b7fe2f128d03 );
            galileo_spawned = 1;
            level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b );
            }
        }
    }
    
    if ( !galileo_spawned )
    {
        wait 7;
        level.var_be5dd4426af70bdb = zm_quest::function_73720cdf21c3cfd7( #"ruby_wwq", #"galileo_respawn" ) ?? 0;
        
        if ( level.var_be5dd4426af70bdb <= 0 )
        {
            spawn_galileo( level.galileo_patrol_start_point );
        }
        else
        {
            level callback::add( "on_round_start", &function_ab308d0c726769cb );
        }
    }
    
    utility::registersharedfunc( #"zombie_galileo", #"spawn_galileo", &spawn_galileo );
    utility::registersharedfunc( #"zombie_galileo", #"hash_688117f2993e46d5", &function_9ef61d02f0ae16dc );
    utility::registersharedfunc( #"zombie_galileo", #"hash_7f2f95200b82d9e4", &function_84919f8f8db67077 );
    utility::registersharedfunc( #"zombie_galileo", #"hash_84d9b1d8224b6870", &function_ab308d0c726769cb );
    utility::registersharedfunc( #"zombie_galileo", #"hash_830823cb567739ec", &function_32198e882f4aae0d );
    level callback::add( "galileo_check_origin_is_valid", &check_origin_is_valid );
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0x8ed835fe, Offset: 0x8e6
// Size: 0x1d
function respawn_galileo()
{
    patrol_point = function_9ef61d02f0ae16dc();
    spawn_galileo( patrol_point );
}

// Namespace zm_sat_ruby_galileo
// Params 2
// Checksum 0xb9087cea, Offset: 0x90b
// Size: 0x1a8
function spawn_galileo( patrol_point, galileo_respawn_info )
{
    origin = patrol_point.origin;
    galileo = agent_manager::spawn_agent( "zombie_galileo", origin );
    
    if ( galileo_respawn_info )
    {
        galileo zm_cleanup_manager::function_5a0d7d59f7c4fafd( galileo_respawn_info );
    }
    
    if ( isdefined( galileo ) )
    {
        galileo.var_825b17c932865df = 1;
        galileo.var_15598d8e493afe88 = 1;
        galileo.ignore_enemy_count = 1;
        galileo.b_disable_annihilate = 1;
        galileo zombie_galileo::set_run_speed_fraction( 0.35 );
        galileo val::set( "galileo", "ignore_cleanup", 1 );
        galileo val::set( "galileo", "allow_dismember", 0 );
        galileo callback::add( "on_zombie_ai_killed", &function_60126efbf44e5b4c );
        galileo callback::add( "on_galileo_power_on", &on_galileo_power_on );
        galileo callback::add( "on_galileo_power_off", &on_galileo_power_off );
        galileo function_32198e882f4aae0d();
        galileo zombie_galileo::deploy( patrol_point );
        galileo thread function_ce8228aa57e81805();
        
        if ( !isdefined( level.var_e8893f9b0f558ccf ) )
        {
            level.var_e8893f9b0f558ccf = [];
        }
        
        level.var_e8893f9b0f558ccf[ level.var_e8893f9b0f558ccf.size ] = galileo;
    }
    
    level callback::remove( "on_round_start", &function_ab308d0c726769cb );
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return galileo;
    }
    else
    {
        level thread function_c0fc9c469720e185();
        level thread function_b61fd371f8175760( galileo );
        level.var_37401c80961cea2b = 1;
        level.ruby_mq.galileo = galileo;
    }
    
    return galileo;
}

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0x4
// Checksum 0x21f89967, Offset: 0xabc
// Size: 0x47
function private function_ce8228aa57e81805()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( self isscriptable() )
    {
        utility::function_7c10ea82c1e305b8( #"teleport", #"out" );
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0xfd825be, Offset: 0xb0b
// Size: 0x8e
function private function_def1423c2f1eb0d7( params )
{
    foreach ( galileo in level.var_e8893f9b0f558ccf )
    {
        galileo zombie_galileo::function_1b18ce7f09f20116();
        galileo function_32198e882f4aae0d();
    }
}

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0x4
// Checksum 0xb84b6b61, Offset: 0xba1
// Size: 0x4e
function private function_32198e882f4aae0d()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( roundnumber >= 51 && !zombie_galileo::is_in_enraged() )
    {
        self.var_d8be4c909dc9fbb9 = 1;
        zombie_galileo::toggle_enraged( 1 );
        zombie_galileo::set_run_speed_fraction( 0.001 );
        thread function_78ccce338f84dc5c();
    }
}

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0xc
// Checksum 0x8a270042, Offset: 0xbf7
// Size: 0x1a4
function private function_78ccce338f84dc5c()
{
    self notify( #"hash_598860b9e74f4669" );
    self endon( #"hash_598860b9e74f4669" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( self.teleporting )
        {
            continue;
        }
        
        var_f43eb6e734c44585 = [];
        var_47cfa19454838a7a = 0;
        
        foreach ( player in level.players )
        {
            if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player, 1 ) )
            {
                if ( distancesquared( player.origin, self.origin ) < 4000000 )
                {
                    var_47cfa19454838a7a = 1;
                }
                
                var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
            }
        }
        
        if ( var_f43eb6e734c44585.size == 0 || var_47cfa19454838a7a )
        {
            continue;
        }
        
        target_player = utility::array_random( var_f43eb6e734c44585 );
        
        if ( is_on_mars() == target_player is_on_mars() )
        {
            continue;
        }
        
        var_c8958b5f22742811 = function_ab2fa359b9cc3c20( target_player.origin, 1500 );
        
        if ( var_c8958b5f22742811.size > 0 )
        {
            var_5fb4fe43f49ba675 = getclosestpointonnavmesh( utility::array_random( var_c8958b5f22742811 ).origin );
        }
        else
        {
            var_5fb4fe43f49ba675 = utility::function_7afe366c29a77c34( target_player.origin, 1500 );
        }
        
        if ( var_5fb4fe43f49ba675 )
        {
            thread zombie_galileo::function_84919f8f8db67077( var_5fb4fe43f49ba675 );
        }
    }
}

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0x4
// Checksum 0x1e88fb35, Offset: 0xda3
// Size: 0x38
function private is_on_mars()
{
    var_8c4fe62d01999d1e = zone_manager::get_current_zone();
    
    if ( var_8c4fe62d01999d1e.zone_name )
    {
        return issubstr( var_8c4fe62d01999d1e.zone_name, "zone_temple" );
    }
    
    return 0;
}

// Namespace zm_sat_ruby_galileo
// Params 2, eflags: 0x4
// Checksum 0x78d7323e, Offset: 0xde4
// Size: 0x9f
function private function_ab2fa359b9cc3c20( v_pos, n_radius )
{
    a_points = [];
    var_7ae605d773736268 = squared( n_radius );
    patrolpoint = level.galileo_patrol_start_point;
    
    while ( isdefined( patrolpoint ) )
    {
        if ( isvector( patrolpoint.origin ) && distancesquared( v_pos, patrolpoint.origin ) < var_7ae605d773736268 )
        {
            a_points[ a_points.size ] = patrolpoint;
        }
        
        patrolpoint = patrolpoint.next;
        
        if ( patrolpoint.isstartpoint )
        {
            break;
        }
    }
    
    return a_points;
}

// Namespace zm_sat_ruby_galileo
// Params 0, eflags: 0x4
// Checksum 0xbc582de9, Offset: 0xe8c
// Size: 0xb1
function private function_7a4767b8a0311bc2()
{
    patrolpoint = level.galileo_patrol_start_point;
    target_patrol_point = undefined;
    nearest_distance = 99999999;
    
    while ( isdefined( patrolpoint ) )
    {
        if ( isvector( patrolpoint.origin ) && self isposreachable( patrolpoint.origin ) )
        {
            dist_sq = distancesquared( self.origin, patrolpoint.origin );
            
            if ( dist_sq < nearest_distance )
            {
                nearest_distance = dist_sq;
                target_patrol_point = patrolpoint;
            }
        }
        
        patrolpoint = patrolpoint.next;
        
        if ( patrolpoint.isstartpoint )
        {
            break;
        }
    }
    
    return target_patrol_point;
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0x67d0a4fb, Offset: 0xf46
// Size: 0x6e
function function_ab308d0c726769cb( params )
{
    if ( level.var_be5dd4426af70bdb <= 0 || level.var_1d953479281b9661 <= 0 )
    {
        level callback::remove( "on_zombie_ai_killed", &function_7b7eac4dbaa2994 );
        respawn_galileo();
    }
    
    level.var_be5dd4426af70bdb--;
    zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"galileo_respawn", level.var_be5dd4426af70bdb );
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0xe9414f91, Offset: 0xfbc
// Size: 0x204
function private function_60126efbf44e5b4c( params )
{
    if ( !utility::flag( "galileo_first_kill_vo_played" ) && !isdefined( level.ruby_wwq.var_42965453ccff4b8 ) )
    {
        params.eattacker thread function_d2fd823add90168b();
    }
    
    level.var_be5dd4426af70bdb = self.var_b2712afddb13f3a4 ?? 1;
    zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"galileo_respawn", level.var_be5dd4426af70bdb );
    
    if ( level.var_be5dd4426af70bdb > 1 )
    {
        level.var_1d953479281b9661 = level.var_be5dd4426af70bdb * 38 * ( level.players.size ?? 1 );
        
        if ( !level callback::exists( "on_zombie_ai_killed", &function_7b7eac4dbaa2994 ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_7b7eac4dbaa2994 );
        }
    }
    
    callback::remove( "on_zombie_ai_killed", &function_60126efbf44e5b4c );
    callback::remove( "on_galileo_power_on", &on_galileo_power_on );
    callback::remove( "on_galileo_power_off", &on_galileo_power_off );
    
    if ( !callback::exists( "on_round_start", &function_ab308d0c726769cb ) )
    {
        level callback::add( "on_round_start", &function_ab308d0c726769cb );
    }
    
    level.var_e8893f9b0f558ccf = arrayremove( level.var_e8893f9b0f558ccf, self );
    
    if ( isdefined( level.ruby_wwq ) )
    {
        level.ruby_wwq.oscar = undefined;
    }
    
    if ( isdefined( level.ruby_mq.galileo ) )
    {
        level.ruby_mq.galileo = undefined;
    }
    
    if ( utility::flag( "ruby_wwq_complete" ) && !utility::flag( "mq_directed_platform_clue_heard" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"oscar_return" );
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    itembundle = getscriptbundle( %"hash_5b85de4a6165089f" );
    common_item::function_61c2c0251e742ffd( itembundle, 350, spawnoptions );
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0xe3dbae44, Offset: 0x11c8
// Size: 0x4c
function function_d2fd823add90168b()
{
    self endon( #"disconnect" );
    level utility::flag_set( "galileo_first_kill_vo_played" );
    wait 2;
    var_db75d3de862ce072 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"galileo_first_kill_vo" );
    
    if ( !var_db75d3de862ce072 )
    {
        level utility::flag_clear( "galileo_first_kill_vo_played" );
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0x65e4db9c, Offset: 0x121c
// Size: 0x19
function function_b7fa26641ae94e30( params )
{
    if ( self )
    {
        thread zombie_galileo::power_off( params );
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0xc5d25a49, Offset: 0x123d
// Size: 0x30
function private on_galileo_power_on( params )
{
    if ( self.interact )
    {
        self.interact delete();
        self.interact = undefined;
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0x265b2d55, Offset: 0x1275
// Size: 0x95
function private on_galileo_power_off( params )
{
    if ( params.on_interact_galileo )
    {
        if ( self.interact )
        {
            self.interact delete();
            self.interact = undefined;
        }
        
        self.interact = spawn( "script_origin", self gettagorigin( "j_spine4" ) );
        self.interact.owner = self;
        interaction::register_interact( self.interact, params.radius, params.on_interact_galileo );
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0x63e42f49, Offset: 0x1312
// Size: 0x36
function private function_7b7eac4dbaa2994( params )
{
    if ( !self.ignore_enemy_count && isplayer( params.eattacker ) )
    {
        level.var_1d953479281b9661--;
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0xc
// Checksum 0xc0bdf31, Offset: 0x1350
// Size: 0x111
function private function_b61fd371f8175760( galileo )
{
    self notify( #"hash_9cdc0113bbfa4190" );
    self endon( #"hash_9cdc0113bbfa4190" );
    level endon( #"game_ended" );
    level endon( #"hash_4dcd6056cdafdec3" );
    level utility::flag_wait( "ruby_mq_platform_value_set" );
    wait 1;
    
    if ( !utility::flag( "ruby_mq_key_picked" ) )
    {
        zm_sat_ruby_quest_mq::function_4ef47d3c5c627fb6();
    }
    
    while ( true )
    {
        if ( isalive( galileo ) && !utility::flag( "zm_vote_active" ) && !utility::flag( "exfil_active" ) )
        {
            roundnumber = zm_round_logic::get_rb_round_number();
            
            if ( galileo.ispatrolling && roundnumber >= 10 && roundnumber <= 50 )
            {
                function_a6115a9f063da938( galileo );
            }
            else if ( roundnumber >= 51 )
            {
                function_a694ffa6517cd091( galileo );
            }
        }
        
        if ( !isalive( galileo ) )
        {
            return;
        }
        
        wait randomintrange( 15, 20 );
        
        if ( utility::flag( "ruby_mq_platform_moved" ) )
        {
            level notify( #"hash_4dcd6056cdafdec3" );
            return;
        }
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0x1c3d6da0, Offset: 0x1469
// Size: 0x5a4
function function_a6115a9f063da938( galileo )
{
    firstcode = level.ruby_mq.var_483e904399b9c1eb[ 0 ];
    secondcode = level.ruby_mq.var_483e904399b9c1eb[ 1 ];
    thirdcode = level.ruby_mq.var_483e904399b9c1eb[ 2 ];
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isalive( galileo ) && galileo.ispatrolling && roundnumber >= 10 )
    {
        wait 8;
        
        if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        if ( !level utility::flag( "mq_galileo_vo_kill" ) )
        {
            level utility::flag_set( "mq_galileo_vo_kill" );
            level thread function_1afde4997168936d( galileo );
        }
        
        var_f10f8d2f56ee53e4 = function_b10814adb5fd8fa3( firstcode );
        var_f10f902f56ee5a7d = function_b10814adb5fd8fa3( secondcode );
        var_f10f8f2f56ee584a = function_b10814adb5fd8fa3( thirdcode );
        
        if ( !utility::flag( "mq_galileo_clue_audio_1" ) )
        {
            level utility::flag_set( "mq_galileo_clue_audio_1" );
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra1ln1" );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra1ln2", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gav1_rm1vra1ln3", undefined, undefined, undefined, 1 );
            wait 15;
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
        }
        
        if ( !utility::flag( "mq_galileo_clue_audio_2" ) )
        {
            level utility::flag_set( "mq_galileo_clue_audio_2" );
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra2ln1", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra2ln2", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gav2_rm1vra2ln3", undefined, undefined, undefined, 1 );
            wait 15;
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
        }
        
        if ( !utility::flag( "mq_galileo_clue_audio_3" ) )
        {
            level utility::flag_set( "mq_galileo_clue_audio_3" );
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra3ln1", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra3ln2", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gav3_rm1vra3ln3", undefined, undefined, undefined, 1 );
            wait 15;
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                return;
            }
        }
        
        if ( !utility::flag( "mq_galileo_clue_audio_4" ) )
        {
            level utility::flag_set( "mq_galileo_clue_audio_4" );
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra4ln1", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                function_c0fc9c469720e185();
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra4ln2", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                function_c0fc9c469720e185();
                return;
            }
            
            galileo dialogue::say( "dx_zm_rumn_1ftc_thur_rm1vra4ln3", undefined, undefined, undefined, 1 );
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                function_c0fc9c469720e185();
                return;
            }
            
            galileo thread dialogue::say( var_f10f8d2f56ee53e4 );
            wait 1;
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                function_c0fc9c469720e185();
                return;
            }
            
            galileo thread dialogue::say( var_f10f902f56ee5a7d );
            wait 1;
            
            if ( !isalive( galileo ) || !galileo.ispatrolling || utility::flag( "exfil_active" ) )
            {
                function_c0fc9c469720e185();
                return;
            }
            
            galileo thread dialogue::say( var_f10f8f2f56ee584a );
            
            if ( isdefined( galileo ) )
            {
                a_nearby_players = getplayersinradius( galileo.origin, 1200 );
                
                if ( a_nearby_players.size >= 1 && !utility::flag( "mq_directed_platform_clue_heard" ) )
                {
                    level utility::flag_set( "mq_directed_platform_clue_heard" );
                    zm_sat_ruby_quest_mq::function_4ef47d3c5c627fb6();
                }
            }
            
            function_c0fc9c469720e185();
            wait 1;
        }
        
        return;
    }
    
    if ( isdefined( galileo ) && galileo.ispatrolling == 0 && roundnumber >= 10 )
    {
        galileo thread dialogue::stop_dialogue();
        return;
    }
    
    galileo thread dialogue::stop_dialogue();
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0x771b56b3, Offset: 0x1a15
// Size: 0x36
function function_c0fc9c469720e185()
{
    level utility::flag_clear( "mq_galileo_clue_audio_1" );
    level utility::flag_clear( "mq_galileo_clue_audio_2" );
    level utility::flag_clear( "mq_galileo_clue_audio_3" );
    level utility::flag_clear( "mq_galileo_clue_audio_4" );
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0x838a769a, Offset: 0x1a53
// Size: 0x411
function function_a694ffa6517cd091( galileo )
{
    firstcode = level.ruby_mq.var_483e904399b9c1eb[ 0 ];
    secondcode = level.ruby_mq.var_483e904399b9c1eb[ 1 ];
    thirdcode = level.ruby_mq.var_483e904399b9c1eb[ 2 ];
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isalive( galileo ) && roundnumber >= 51 )
    {
        wait 8;
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        if ( !level utility::flag( "mq_galileo_vo_kill" ) )
        {
            level utility::flag_set( "mq_galileo_vo_kill" );
            level thread function_1afde4997168936d( galileo );
        }
        
        var_f10f8d2f56ee53e4 = function_b10814adb5fd8fa3( firstcode );
        var_f10f902f56ee5a7d = function_b10814adb5fd8fa3( secondcode );
        var_f10f8f2f56ee584a = function_b10814adb5fd8fa3( thirdcode );
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra1ln1" );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra1ln2", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gav1_rm1vra1ln3", undefined, undefined, undefined, 1 );
        wait 25;
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra2ln1", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra2ln2", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gav2_rm1vra2ln3", undefined, undefined, undefined, 1 );
        wait 25;
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra3ln1", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra3ln2", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gav3_rm1vra3ln3", undefined, undefined, undefined, 1 );
        wait 25;
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra4ln1", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_gali_rm1vra4ln2", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        galileo dialogue::say( "dx_zm_rumn_1ftc_thur_rm1vra4ln3", undefined, undefined, undefined, 1 );
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        firstcode = level.ruby_mq.var_483e904399b9c1eb[ 0 ];
        var_f10f8d2f56ee53e4 = function_b10814adb5fd8fa3( firstcode );
        
        if ( isdefined( var_f10f8d2f56ee53e4 ) )
        {
            galileo thread dialogue::say( var_f10f8d2f56ee53e4 );
            wait 1;
        }
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        secondcode = level.ruby_mq.var_483e904399b9c1eb[ 1 ];
        var_f10f902f56ee5a7d = function_b10814adb5fd8fa3( secondcode );
        
        if ( isdefined( var_f10f902f56ee5a7d ) )
        {
            galileo thread dialogue::say( var_f10f902f56ee5a7d );
            wait 1;
        }
        
        if ( !isalive( galileo ) || utility::flag( "exfil_active" ) )
        {
            return;
        }
        
        thirdcode = level.ruby_mq.var_483e904399b9c1eb[ 2 ];
        var_f10f8f2f56ee584a = function_b10814adb5fd8fa3( thirdcode );
        
        if ( isdefined( var_f10f8f2f56ee584a ) )
        {
            galileo thread dialogue::say( var_f10f8f2f56ee584a );
            wait 1;
        }
        
        return;
    }
    
    if ( !isalive( galileo ) )
    {
        galileo thread dialogue::stop_dialogue();
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0xc
// Checksum 0x3f3f8cfd, Offset: 0x1e6c
// Size: 0x73
function private function_1afde4997168936d( galileo )
{
    self notify( #"hash_dc8665250da3f051" );
    self endon( #"hash_dc8665250da3f051" );
    level endon( #"game_ended" );
    level endon( #"hash_4dcd6056cdafdec3" );
    
    while ( true )
    {
        if ( isdefined( galileo ) && galileo.ispatrolling == 0 )
        {
            galileo thread dialogue::stop_dialogue();
            level utility::flag_clear( "mq_galileo_vo_kill" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0x2167994e, Offset: 0x1ee7
// Size: 0xcc
function function_b10814adb5fd8fa3( clue )
{
    if ( isdefined( clue ) )
    {
        switch ( clue )
        {
            case 1:
                return #"hash_3d0a96eda419cba9";
            case 2:
                return #"hash_3d0a93eda419c690";
            case 3:
                return #"hash_3d0a94eda419c843";
            case 4:
                return #"hash_3d0a99eda419d0c2";
            case 5:
                return #"hash_3d0a97eda419cd5c";
            case 6:
                return #"hash_3d0a9aeda419d275";
            case 7:
                return #"hash_3d0a98eda419cf0f";
            case 8:
                return #"hash_3d0a9deda419d78e";
        }
    }
}

// Namespace zm_sat_ruby_galileo
// Params 2
// Checksum 0xc3bbc2f9, Offset: 0x1fbb
// Size: 0x37
function function_84919f8f8db67077( location, var_783f480cd479fcb8 = 1 )
{
    if ( var_783f480cd479fcb8 || !zombie_galileo::is_in_combat() )
    {
        thread zombie_galileo::function_84919f8f8db67077( location );
    }
}

// Namespace zm_sat_ruby_galileo
// Params 1
// Checksum 0xb34e721c, Offset: 0x1ffa
// Size: 0x36
function check_origin_is_valid( origin )
{
    if ( isvector( origin ) )
    {
        zone_struct = zone_manager::function_90e5c3e2272b0130( origin );
        return zone_struct.is_enabled;
    }
    
    return 0;
}

// Namespace zm_sat_ruby_galileo
// Params 0
// Checksum 0x831c1884, Offset: 0x2039
// Size: 0x1cb
function function_9ef61d02f0ae16dc()
{
    assert( isdefined( level.galileo_patrol_start_point ) );
    patrol_point = level.galileo_patrol_start_point;
    var_5a01409ad9f316ac = [];
    points_out_of_sight = [];
    
    while ( isdefined( patrol_point ) )
    {
        var_8fd4780101261e9a = 1;
        is_point_out_of_sight = 1;
        
        if ( isvector( patrol_point.origin ) )
        {
            zone_struct = zone_manager::function_90e5c3e2272b0130( patrol_point.origin );
            is_zone_enabled = zone_struct.is_enabled;
            
            if ( is_zone_enabled )
            {
                foreach ( player in level.players )
                {
                    if ( var_8fd4780101261e9a && distance2dsquared( player.origin, patrol_point.origin ) < 6250000 )
                    {
                        var_8fd4780101261e9a = 0;
                        continue;
                    }
                    
                    if ( is_point_out_of_sight && sighttracepassed( player geteye(), patrol_point.origin, 0, undefined ) )
                    {
                        is_point_out_of_sight = 0;
                    }
                }
                
                if ( var_8fd4780101261e9a )
                {
                    var_5a01409ad9f316ac[ var_5a01409ad9f316ac.size ] = patrol_point;
                }
                
                if ( is_point_out_of_sight )
                {
                    points_out_of_sight[ points_out_of_sight.size ] = patrol_point;
                }
            }
        }
        
        patrol_point = patrol_point.next;
        
        if ( patrol_point.isstartpoint )
        {
            break;
        }
    }
    
    if ( var_5a01409ad9f316ac.size > 0 )
    {
        return utility::array_random( var_5a01409ad9f316ac );
    }
    else if ( points_out_of_sight.size > 0 )
    {
        return utility::array_random( points_out_of_sight );
    }
    
    return level.galileo_patrol_start_point;
}

// Namespace zm_sat_ruby_galileo
// Params 1, eflags: 0x4
// Checksum 0xf4b59f24, Offset: 0x220d
// Size: 0x9d
function private function_da2d5773efbd7a15( params )
{
    level endon( #"game_ended" );
    
    if ( !utility::flag( "galileo_drone_first_kill_vo_played" ) && isplayer( params.eattacker ) )
    {
        level utility::flag_set( "galileo_drone_first_kill_vo_played" );
        var_db75d3de862ce072 = params.eattacker namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"galileo_drone_first_kill_vo", #"bc_flavor_player_positive" );
        
        if ( var_db75d3de862ce072 )
        {
            level callback::remove( "on_galileo_drone_killed", &function_da2d5773efbd7a15 );
            return;
        }
        
        level utility::flag_clear( "galileo_drone_first_kill_vo_played" );
    }
}

/#

    // Namespace zm_sat_ruby_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xffbb8b09, Offset: 0x22b2
    // Size: 0x5a, Type: dev
    function private init_galileo_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x54>" );
        devgui::add_devgui_func( "<dev string:x5e>", "<dev string:x6c>", &debug_spawn_galileo );
        devgui::add_devgui_func( "<dev string:x80>", "<dev string:x95>", &function_e47be501e3a280d7 );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xd2>", &function_b13aafbdec986856 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_ruby_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x9d74f616, Offset: 0x2314
    // Size: 0x15, Type: dev
    function private debug_spawn_galileo()
    {
        spawn_galileo( level.galileo_patrol_start_point );
    }

    // Namespace zm_sat_ruby_galileo
    // Params 0, eflags: 0x4
    // Checksum 0xa59dec92, Offset: 0x2331
    // Size: 0xc, Type: dev
    function private function_e47be501e3a280d7()
    {
        respawn_galileo();
    }

    // Namespace zm_sat_ruby_galileo
    // Params 0, eflags: 0x4
    // Checksum 0x7e1c3703, Offset: 0x2345
    // Size: 0x52, Type: dev
    function private function_b13aafbdec986856()
    {
        if ( level.dev_galileo )
        {
            params = spawnstruct();
            params.on_interact_galileo = &function_fd7676d344336f48;
            params.radius = 64;
            level.dev_galileo function_b7fa26641ae94e30( params );
        }
    }

    // Namespace zm_sat_ruby_galileo
    // Params 1, eflags: 0x4
    // Checksum 0xb904b5e1, Offset: 0x239f
    // Size: 0x89, Type: dev
    function private function_fd7676d344336f48( player )
    {
        galileo = self.owner;
        s_weapon_spawn = getscriptbundle( "<dev string:xfe>" );
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( galileo.origin, galileo.origin + ( 0, 0, 70 ) );
        spawnoptions.var_fd47e835523b473f = 1;
        item_weapon::function_b960bc85ea91de14( s_weapon_spawn, spawnoptions );
        self delete();
    }

#/
