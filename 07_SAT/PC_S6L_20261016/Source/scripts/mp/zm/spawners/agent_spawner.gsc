// scripts\mp\zm\spawners\agent_spawner.gsc  (hash_791c08c42f9bc356.gscc) (size: 5206 Bytes / 0x1456 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f2f37e5 (791623653)
// size ...... 5206 (0x1456)
// includes .. 6   (offset: 0x128a)
// strings ... 11  (offset: 0x12ba)
// dev strs .. 20  (offset: 0x135e)
// exports ... 16  (offset: 0xa72)
// cseg ...... 0x129 + 0x949 (0xa72)
// imports ... 49  (offset: 0xcf2)
// animtree1 . 0   (offset: 0x1456)
// animtree2 . 0   (offset: 0x1456)
#using scripts\asm\shared\mp\utility;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\zm_utility;

#namespace agent_spawner;

// Namespace agent_spawner
// Params 0
// Checksum 0xe6d9e1b, Offset: 0x147
// Size: 0x22
function init_agent_spawner()
{
    if ( !isdefined( level.agent_spawners ) )
    {
        level.agent_spawners = [];
    }
    
    /#
        setup_agent_spawner_devgui();
    #/
}

// Namespace agent_spawner
// Params 2
// Checksum 0x5e68f5e7, Offset: 0x171
// Size: 0x5b
function register_spawner( var_3e6257afaa75758, spawn_func )
{
    spawner = spawnstruct();
    spawner.name = var_3e6257afaa75758;
    spawner.spawn_func = spawn_func;
    level.agent_spawners[ var_3e6257afaa75758 ] = spawner;
    
    /#
        function_3409a396a2a0749( var_3e6257afaa75758 );
    #/
}

// Namespace agent_spawner
// Params 1
// Checksum 0xcafbf0a5, Offset: 0x1d4
// Size: 0x44
function function_da6c989ec2c8c5fa( var_3e6257afaa75758 )
{
    assert( isdefined( level.agent_spawners[ var_3e6257afaa75758 ] ), "<dev string:x24>" + var_3e6257afaa75758 + "<dev string:x37>" );
    level.agent_spawner_current = level.agent_spawners[ var_3e6257afaa75758 ];
}

// Namespace agent_spawner
// Params 2
// Checksum 0x4a409513, Offset: 0x220
// Size: 0x6f
function spawn_agent( var_bc661ad67960c4e3, var_56b78e42f7e7024e )
{
    assert( isdefined( level.agent_spawner_current ), "<dev string:x63>" );
    var_bc661ad67960c4e3 = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
    sparams = spawnstruct();
    sparams.var_56b78e42f7e7024e = var_56b78e42f7e7024e;
    return [[ level.agent_spawner_current.spawn_func ]]( var_bc661ad67960c4e3, sparams );
}

// Namespace agent_spawner
// Params 3
// Checksum 0xdc7e59bb, Offset: 0x298
// Size: 0x56
function spawn_agent_custom( var_bc661ad67960c4e3, var_548e49d894d691e, params )
{
    assert( isdefined( var_bc661ad67960c4e3 ) && isdefined( var_548e49d894d691e ) );
    var_bc661ad67960c4e3 = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
    return [[ level.agent_spawners[ var_548e49d894d691e ].spawn_func ]]( var_bc661ad67960c4e3, params );
}

// Namespace agent_spawner
// Params 2
// Checksum 0x21603178, Offset: 0x2f7
// Size: 0x143
function spawn_agent_for_players( var_bc661ad67960c4e3, player_array )
{
    foreach ( player in level.players )
    {
        if ( arraycontains( player_array, player ) )
        {
            player val::set( "spawn_agent_for_players", "round_spawning_ignore_player", 0 );
            continue;
        }
        
        player val::set( "spawn_agent_for_players", "round_spawning_ignore_player", 1 );
    }
    
    agent = spawn_agent( var_bc661ad67960c4e3 );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "spawn_agent_for_players" );
    }
    
    return agent;
}

// Namespace agent_spawner
// Params 3
// Checksum 0xe3b87fa, Offset: 0x443
// Size: 0x1b4
function function_ce10e453e7f7bb8e( spawn_loc, override_spawn_pos, var_6e0ecff0004c363e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( spawn_loc.disable_spawn_vfx && !var_6e0ecff0004c363e )
    {
        self.disable_spawn_vfx = 1;
    }
    
    if ( isdefined( spawn_loc.script_animation ) || isdefined( self.default_spawn_animation ) && self.default_spawn_animation != "" )
    {
        spawn_anim_alias = spawn_loc.script_animation ?? self.default_spawn_animation;
        
        if ( utility::function_4c656524ecb504d6( spawn_anim_alias ) )
        {
            if ( isdefined( override_spawn_pos ) )
            {
                animscripted_origin = override_spawn_pos;
            }
            else
            {
                animscripted_origin = spawn_loc.origin;
            }
            
            animscripted_angles = spawn_loc.angles ?? ( 0, 0, 0 );
            var_adf5e39c149b95a1 = 16;
            
            if ( isdefined( spawn_loc.script_aianimset ) )
            {
                self setoverridearchetype( "animscript", spawn_loc.script_aianimset, 1 );
            }
            
            if ( abs( utility::function_80505911b6822d3( spawn_anim_alias )[ 2 ] ) > var_adf5e39c149b95a1 )
            {
                animscripted_origin = spawn_loc.origin;
            }
            
            thread function_101e26fb91863ebe();
            val::set_array( "animate_spawning", [ "disallow_knockdown", "disallow_stun" ], 1 );
            utility::animscriptedagent( spawn_anim_alias, "spawn_end", animscripted_origin, animscripted_angles, "spawn_animating" );
            val::reset_all( "animate_spawning" );
            
            if ( isdefined( spawn_loc.script_aianimset ) )
            {
                self clearoverridearchetype( "animscript" );
            }
        }
    }
}

// Namespace agent_spawner
// Params 0, eflags: 0x4
// Checksum 0x6ebf59d1, Offset: 0x5ff
// Size: 0x55
function private function_101e26fb91863ebe()
{
    self endon( #"death" );
    result = utility::waittill_any_return( "disable_collision", "spawn_end" );
    
    if ( result == "disable_collision" )
    {
        self function_7f8988ce63c1623d( 0 );
        utility::waittill_any( "enable_collision", "spawn_end" );
        self function_7f8988ce63c1623d( 1 );
    }
}

/#

    // Namespace agent_spawner
    // Params 0, eflags: 0x4
    // Checksum 0xd7968cdd, Offset: 0x65c
    // Size: 0xa6, Type: dev
    function private setup_agent_spawner_devgui()
    {
        setdevdvarifuninitialized( @"zm_spawner_auto", 0 );
        setdevdvarifuninitialized( @"hash_eb28e23f4b249363", 10 );
        setdevdvarifuninitialized( @"hash_afa1523bb47e7941", "<dev string:x9d>" );
        setdevdvarifuninitialized( @"hash_275d56f74d5b1594", 8 );
        devgui::function_9082edeb5db93280( "<dev string:xa9>" );
        devgui::add_devgui_func( "<dev string:xb5>", "<dev string:xc1>", &draw_spawner_info, 1 );
        devgui::add_devgui_func( "<dev string:xe1>", "<dev string:xf6>", &function_5e8a153c057099f8 );
        devgui::add_devgui_func( "<dev string:x112>", "<dev string:x128>", &function_685159ae792927d7 );
        devgui::function_77df7fe7dd273e10();
        level thread function_7e17ffed6f80d826();
    }

    // Namespace agent_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x5f81e03a, Offset: 0x70a
    // Size: 0x1ee, Type: dev
    function private draw_spawner_info()
    {
        while ( true )
        {
            level debug::function_298a6c4895b8935d( ( 400, 300, 0 ) );
            var_7ecbac9048cb1363 = getdvarint( @"zm_spawner_auto" ) ? "<dev string:x14b>" : "<dev string:x15b>";
            level debug::function_ce323c1a383e915( "<dev string:x15c>" + var_7ecbac9048cb1363, ( 1, 1, 0 ) );
            var_78d6606d597fb76e = 0;
            
            foreach ( spawner in level.agent_spawners )
            {
                var_78d6606d597fb76e = int( max( var_78d6606d597fb76e, spawner.name.size ) );
            }
            
            foreach ( spawner in level.agent_spawners )
            {
                text = spawner.name;
                
                for ( i = 0; i < var_78d6606d597fb76e - spawner.name.size ; i++ )
                {
                    text += "<dev string:x167>";
                }
                
                text += "<dev string:x169>";
                text += level.agent_spawner_current == spawner ? "<dev string:x16d>" : "<dev string:x175>";
                level debug::function_ce323c1a383e915( text, ( 1, 1, 0 ) );
            }
            
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

    // Namespace agent_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x645cb0d3, Offset: 0x900
    // Size: 0x37, Type: dev
    function private function_5e8a153c057099f8()
    {
        auto_spawning = getdvarint( @"zm_spawner_auto" ) ? 0 : 1;
        setdevdvar( @"zm_spawner_auto", auto_spawning );
    }

    // Namespace agent_spawner
    // Params 0, eflags: 0x4
    // Checksum 0x660ee011, Offset: 0x93f
    // Size: 0x96, Type: dev
    function private function_7e17ffed6f80d826()
    {
        while ( true )
        {
            wait_s = 0.1;
            
            if ( getdvarint( @"zm_spawner_auto" ) && isdefined( level.agent_spawner_current ) )
            {
                num_max_zombies = getdvarint( @"hash_eb28e23f4b249363" );
                
                if ( getaiarray( zm_utility::get_zombie_team() ).size < num_max_zombies )
                {
                    subclass = getdvar( @"hash_afa1523bb47e7941" );
                    spawn_agent( subclass );
                }
                
                wait_s = getdvarfloat( @"hash_275d56f74d5b1594" );
            }
            
            wait wait_s;
        }
    }

    // Namespace agent_spawner
    // Params 1, eflags: 0x4
    // Checksum 0xe0652b4f, Offset: 0x9dd
    // Size: 0x33, Type: dev
    function private function_3409a396a2a0749( var_3e6257afaa75758 )
    {
        devgui::function_cd4e263c1f3018ae( "<dev string:xa9>" + var_3e6257afaa75758 + "<dev string:x17d>", "<dev string:x185>" + var_3e6257afaa75758, &devgui_enable_spawner, 0, 0 );
    }

    // Namespace agent_spawner
    // Params 1, eflags: 0x4
    // Checksum 0xa5544100, Offset: 0xa18
    // Size: 0x27, Type: dev
    function private devgui_enable_spawner( params )
    {
        var_3e6257afaa75758 = params[ 0 ];
        function_da6c989ec2c8c5fa( var_3e6257afaa75758 );
    }

    // Namespace agent_spawner
    // Params 1, eflags: 0x4
    // Checksum 0xe62a899d, Offset: 0xa47
    // Size: 0x2b, Type: dev
    function private function_685159ae792927d7( params )
    {
        spawn_agent_for_players( "<dev string:x9d>", [ level.players[ 0 ] ] );
    }

#/
