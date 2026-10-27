// scripts\mp\zm\spawners\procedural_spawner.gsc  (hash_71010e0b84f354de.gscc) (size: 1710 Bytes / 0x6ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a88a6fc (2592646908)
// size ...... 1710 (0x6ae)
// includes .. 4   (offset: 0x63a)
// strings ... 2   (offset: 0x65a)
// dev strs .. 5   (offset: 0x672)
// exports ... 5   (offset: 0x356)
// cseg ...... 0x75 + 0x2e1 (0x356)
// imports ... 19  (offset: 0x41e)
// animtree1 . 0   (offset: 0x6ae)
// animtree2 . 0   (offset: 0x6ae)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\systems\agent_manager;

#namespace procedural_spawner;

// Namespace procedural_spawner
// Params 0
// Checksum 0x4db639d3, Offset: 0x93
// Size: 0x1d
function init_procedural_spawner()
{
    agent_spawner::register_spawner( "procedural", &spawn_agent );
    
    /#
        function_2527aae404cb1e5f();
    #/
}

// Namespace procedural_spawner
// Params 2
// Checksum 0x984c5c03, Offset: 0xb8
// Size: 0x156
function spawn_agent( aitype, params )
{
    var_95b86e61b2c6a7 = utility::array_random( utility::get_alive_players() );
    
    if ( isdefined( var_95b86e61b2c6a7 ) )
    {
        var_29c712a3c9b9188c = getclosestpointonnavmesh( var_95b86e61b2c6a7.origin );
        spawn_positions = getrandomnavpoints( var_29c712a3c9b9188c, 500, 32 );
        
        if ( isdefined( spawn_positions ) )
        {
            valid_spawn_positions = [];
            
            foreach ( pos in spawn_positions )
            {
                if ( distance2dsquared( var_29c712a3c9b9188c, pos ) < 62500 )
                {
                    continue;
                }
                
                valid_spawn_positions[ valid_spawn_positions.size ] = pos;
            }
            
            spawn_pos = utility::array_random( valid_spawn_positions );
            
            if ( !isdefined( spawn_pos ) )
            {
                return;
            }
            
            agent = agent_manager::spawn_agent( aitype, spawn_pos );
            
            if ( isdefined( agent ) )
            {
                agent.spawn_loc = spawnstruct();
                agent.origin = spawn_pos;
                agent.spawn_source = "dev_spawned";
            }
            
            return agent;
        }
    }
}

/#

    // Namespace procedural_spawner
    // Params 0
    // Checksum 0xcfd9aa78, Offset: 0x217
    // Size: 0x3c, Type: dev
    function function_2527aae404cb1e5f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x30>" + "<dev string:x3b>" );
        devgui::add_devgui_func( "<dev string:x3d>", "<dev string:x54>", &draw_spawn_area, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace procedural_spawner
    // Params 0, eflags: 0x4
    // Checksum 0xab2c41df, Offset: 0x25b
    // Size: 0xfb, Type: dev
    function private draw_spawn_area()
    {
        while ( true )
        {
            if ( isdefined( level.players ) )
            {
                foreach ( player in level.players )
                {
                    var_29c712a3c9b9188c = getclosestpointonnavmesh( player.origin );
                    sphere( var_29c712a3c9b9188c, 2, ( 0, 0, 1 ), 1, 1 );
                    utility::draw_circle( var_29c712a3c9b9188c, 250, ( 0, 0, 1 ), 1, 1, 1 );
                    utility::draw_circle( var_29c712a3c9b9188c, 500, ( 0, 0, 1 ), 1, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
