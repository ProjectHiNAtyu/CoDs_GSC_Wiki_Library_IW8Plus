// script_54da1af5927ef919  (hash_54da1af5927ef919.gscc) (size: 17469 Bytes / 0x443d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf312b29 (3207670569)
// size ...... 17469 (0x443d)
// includes .. 23  (offset: 0x39b1)
// strings ... 0   (offset: 0x3a69)
// dev strs .. 194 (offset: 0x3a69)
// exports ... 37  (offset: 0x2399)
// cseg ...... 0x58 + 0x2341 (0x2399)
// imports ... 125 (offset: 0x2961)
// animtree1 . 0   (offset: 0x443d)
// animtree2 . 0   (offset: 0x443d)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\traverse;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bite;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_liveragdoll;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\ai_lookat;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\mp_agent;

#namespace agent_zombie_devgui;

/#

    // Namespace agent_zombie_devgui
    // Params 0
    // Checksum 0x92e48768, Offset: 0x76
    // Size: 0x60f, Type: dev
    function function_c007cc2059c63bd4()
    {
        waitframe();
        utility::flag_wait( "<dev string:x24>" );
        devgui::function_9082edeb5db93280( "<dev string:x47>" );
        priority = 20;
        devgui::function_cd4e263c1f3018ae( "<dev string:x58>", "<dev string:x7d>" + priority, &set_all_zombies_movement_speed );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa2>", "<dev string:xc5>" + priority, &set_all_zombies_movement_speed );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe8>", "<dev string:x10a>" + priority, &set_all_zombies_movement_speed );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12c>", "<dev string:x151>" + priority, &set_all_zombies_movement_speed );
        devgui::function_cd4e263c1f3018ae( "<dev string:x176>", "<dev string:x1a1>" + priority, &set_all_zombies_movement_speed );
        devgui::add_devgui_func( "<dev string:x1cc>", "<dev string:x215>", &function_61f22ca2ea30fa1f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x234>", "<dev string:x263>", &function_61f22ca2ea30fa1f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x286>", "<dev string:x2b4>", &function_61f22ca2ea30fa1f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2d8>", "<dev string:x306>", &function_61f22ca2ea30fa1f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x32b>", "<dev string:x35a>", &function_61f22ca2ea30fa1f );
        devgui::add_devgui_func( "<dev string:x37e>", "<dev string:x3a6>", &function_e5e224c84d88e35c );
        devgui::add_devgui_func( "<dev string:x3c2>", "<dev string:x3ea>", &function_c774b075109601b4 );
        devgui::add_devgui_func( "<dev string:x401>", "<dev string:x421>", &function_728a1b495c14fd07 );
        devgui::add_devgui_func( "<dev string:x439>", "<dev string:x461>", &function_cbd74a8b46fef8d7 );
        zombie_emergence_spawning::setup_emergence_spawning_devgui();
        level.var_172ac5dce9304093 = agent_utils::build_subclass_to_aitype_map();
        ai_spawn_names = function_eaa088dfc8663f3();
        devgui::add_devgui_func( "<dev string:x478>", "<dev string:x495>", &function_a9cb0c09a4cccf00 );
        
        foreach ( subclass, var_4e22b1711288aef5 in ai_spawn_names )
        {
            aitype_to_spawn = subclass_to_aitype_map::function_7f9ebc41207674e9( subclass );
            
            if ( !isdefined( aitype_to_spawn ) )
            {
                continue;
            }
            
            if ( issubstr( subclass, "<dev string:x4b3>" ) )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x4ba>" + var_4e22b1711288aef5, "<dev string:x4c1>" + aitype_to_spawn, &function_46aba79b63be5b0a );
                continue;
            }
            
            devgui::function_cd4e263c1f3018ae( "<dev string:x4cb>" + var_4e22b1711288aef5, "<dev string:x4c1>" + aitype_to_spawn, &function_46aba79b63be5b0a );
        }
        
        foreach ( subclass, aitypes in level.var_172ac5dce9304093 )
        {
            if ( !ai_spawn_names[ subclass ] )
            {
                var_4e22b1711288aef5 = subclass;
                aitype_to_spawn = subclass_to_aitype_map::function_7f9ebc41207674e9( subclass );
                
                if ( !isdefined( aitype_to_spawn ) )
                {
                    continue;
                }
                
                if ( issubstr( subclass, "<dev string:x4b3>" ) )
                {
                    devgui::function_cd4e263c1f3018ae( "<dev string:x4ba>" + var_4e22b1711288aef5, "<dev string:x4c1>" + aitype_to_spawn, &function_46aba79b63be5b0a );
                    continue;
                }
                
                devgui::function_cd4e263c1f3018ae( "<dev string:x4cb>" + var_4e22b1711288aef5, "<dev string:x4c1>" + aitype_to_spawn, &function_46aba79b63be5b0a );
            }
        }
        
        devgui::add_devgui_func( "<dev string:x4db>", "<dev string:x4f0>", &toggle_ranged_attack, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x505>", "<dev string:x51a>", &stun_all_ai );
        devgui::function_cd4e263c1f3018ae( "<dev string:x524>", "<dev string:x53a>", &stun_all_ai );
        devgui::function_cd4e263c1f3018ae( "<dev string:x544>", "<dev string:x55c>", &stun_all_ai );
        devgui::add_devgui_func( "<dev string:x568>", "<dev string:x589>", &function_d2b38cbecd415709 );
        devgui::add_devgui_func( "<dev string:x5a7>", "<dev string:x5d9>", &function_5f587f197580065c );
        devgui::add_devgui_func( "<dev string:x5fe>", "<dev string:x61a>", &function_4daecf26de303902 );
        devgui::add_devgui_func( "<dev string:x636>", "<dev string:x652>", &function_1ea1a6c88d0308c );
        devgui::add_devgui_func( "<dev string:x66e>", "<dev string:x685>", &turn_closest_zombie );
        devgui::function_cd4e263c1f3018ae( "<dev string:x699>", "<dev string:x6b4>", &brainrot_closest_zombie );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6ce>", "<dev string:x6ef>", &brainrot_closest_zombie );
        devgui::add_devgui_func( "<dev string:x709>", "<dev string:x726>", &live_ragdoll_closest );
        devgui::add_devgui_func( "<dev string:x73b>", "<dev string:x74f>", &function_96c02ab962f6fa35 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x75b>", "<dev string:x777>", &function_571c0fc0dc0a3eec );
        devgui::function_cd4e263c1f3018ae( "<dev string:x797>", "<dev string:x7b4>", &function_571c0fc0dc0a3eec );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7e1>", "<dev string:x7fc>", &function_571c0fc0dc0a3eec );
        devgui::function_cd4e263c1f3018ae( "<dev string:x82b>", "<dev string:x846>", &function_571c0fc0dc0a3eec );
        devgui::add_devgui_func( "<dev string:x874>", "<dev string:x896>", &function_748e7f1c3634a6a2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8a9>", "<dev string:x8c5>", &force_target_player );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8d4>", "<dev string:x8f0>", &force_target_player );
        devgui::add_devgui_func( "<dev string:x8ff>", "<dev string:x915>", &toggle_zombie_wander_enabled );
        devgui::add_devgui_func( "<dev string:x932>", "<dev string:x946>", &toggle_zombie_pain_enabled );
        devgui::add_devgui_func( "<dev string:x961>", "<dev string:x972>", &function_42d73b9e9783ddda );
        devgui::add_devgui_func( "<dev string:x983>", "<dev string:x99a>", &force_kill_all_zombies );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9b1>", "<dev string:x9cd>", &function_4c3395d74104d69 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9de>", "<dev string:xa01>", &function_ecf30a962eecef8e );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa1a>", "<dev string:xa45>", &function_ca964db489dddadb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa5c>", "<dev string:xa8f>", &function_703a503d9b0f99ef );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac0>", "<dev string:xaf1>", &function_703a503d9b0f99ef );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb20>", "<dev string:xb52>", &function_703a503d9b0f99ef );
        devgui::add_devgui_func( "<dev string:xb82>", "<dev string:xbb5>", &function_f68538e72b990566 );
        devgui::add_devgui_func( "<dev string:xbd0>", "<dev string:xc07>", &function_e2273ff5e9be4a2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace agent_zombie_devgui
    // Params 0
    // Checksum 0xa007f3b, Offset: 0x68d
    // Size: 0x174, Type: dev
    function function_eaa088dfc8663f3()
    {
        arr = [];
        arr[ "<dev string:xc30>" ] = "<dev string:xc38>";
        arr[ "<dev string:xc40>" ] = "<dev string:xc49>";
        arr[ "<dev string:xc52>" ] = "<dev string:xc5e>";
        arr[ "<dev string:xc65>" ] = "<dev string:xc7f>";
        arr[ "<dev string:xc92>" ] = "<dev string:xcac>";
        arr[ "<dev string:xcbf>" ] = "<dev string:xcd1>";
        arr[ "<dev string:xcde>" ] = "<dev string:xcef>";
        arr[ "<dev string:xcfc>" ] = "<dev string:xd0d>";
        arr[ "<dev string:xd17>" ] = "<dev string:xd26>";
        arr[ "<dev string:xd2f>" ] = "<dev string:xd3b>";
        arr[ "<dev string:xd47>" ] = "<dev string:xd56>";
        arr[ "<dev string:xd5e>" ] = "<dev string:xd6b>";
        arr[ "<dev string:xd71>" ] = "<dev string:xd82>";
        arr[ "<dev string:xd8c>" ] = "<dev string:xd9c>";
        arr[ "<dev string:xda5>" ] = "<dev string:xdbb>";
        arr[ "<dev string:xdca>" ] = "<dev string:xdd8>";
        arr[ "<dev string:xddf>" ] = "<dev string:xdef>";
        arr[ "<dev string:xdf8>" ] = "<dev string:xe05>";
        arr[ "<dev string:xe11>" ] = "<dev string:xe22>";
        arr[ "<dev string:xe2d>" ] = "<dev string:xe3c>";
        arr[ "<dev string:xe44>" ] = "<dev string:xe54>";
        arr[ "<dev string:xe5a>" ] = "<dev string:xe67>";
        arr[ "<dev string:xe72>" ] = "<dev string:xe84>";
        arr[ "<dev string:xe8f>" ] = "<dev string:xe9c>";
        arr[ "<dev string:xea4>" ] = "<dev string:xeb1>";
        arr[ "<dev string:xeb5>" ] = "<dev string:xec1>";
        arr[ "<dev string:xec9>" ] = "<dev string:xed9>";
        return arr;
    }

    // Namespace agent_zombie_devgui
    // Params 1
    // Checksum 0x2db12a56, Offset: 0x809
    // Size: 0xdf, Type: dev
    function function_4c3395d74104d69( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            iprintlnbold( "<dev string:xee5>" );
            return;
        }
        
        var_85d429305cc9613f = params[ 0 ];
        value = params[ 1 ] ?? 1;
        value_type = params[ 2 ] ?? "<dev string:xf07>";
        
        switch ( value_type )
        {
            case #"hash_4730906c2f53f03e":
                value = int( value );
                break;
            case #"hash_3e4a6f464c850b65":
                value = float( value );
                break;
            case #"hash_2ac140ce3b5ea398":
                value = string( value );
                break;
        }
        
        closest_ai = zombie_utils::get_closest_zombie( level.players[ 0 ].origin );
        
        if ( !isdefined( closest_ai ) )
        {
            return;
        }
        
        closest_ai function_786bb6aa1b76c7ee( var_85d429305cc9613f, value );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xc114f1c8, Offset: 0x8f0
    // Size: 0x9e, Type: dev
    function private function_ecf30a962eecef8e( params )
    {
        closest_ai = zombie_utils::get_closest_zombie( level.players[ 0 ].origin );
        
        if ( !isdefined( closest_ai ) )
        {
            return;
        }
        
        closest_ai.var_ef53ce9913fe1a35 = "<dev string:xf18>";
        closest_ai.var_fa685a7668b11923 = closest_ai.origin;
        closest_ai.var_d87cab901a66356c = closest_ai.origin + anglestoforward( closest_ai.angles ) * 200;
        closest_ai asm::asm_setstate( "<dev string:xf1f>" );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xf8f4ed82, Offset: 0x996
    // Size: 0x8a, Type: dev
    function private function_ca964db489dddadb( params )
    {
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( !isdefined( level.var_1064921681ec9df7 ) )
        {
            level.var_1064921681ec9df7 = origin;
            iprintlnbold( "<dev string:xf31>" );
        }
        else
        {
            createnavlink( "<dev string:xf54>", level.var_1064921681ec9df7, origin );
            level.var_1064921681ec9df7 = undefined;
            iprintlnbold( "<dev string:xf65>" );
        }
        
        sphere( origin, 20, ( 1, 0, 0 ), 1, 10 );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0x7552e2af, Offset: 0xa28
    // Size: 0x62, Type: dev
    function private function_703a503d9b0f99ef( params )
    {
        if ( isdefined( params[ 0 ] ) )
        {
            origin = level.players[ 0 ].origin;
            setdvar( hashcat( @"ai_", params[ 0 ] ), origin );
            iprintlnbold( "<dev string:xf81>" + params[ 0 ] + "<dev string:xf8f>" );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x378fac21, Offset: 0xa92
    // Size: 0x69, Type: dev
    function private function_f68538e72b990566()
    {
        setdvar( @"hash_8e505258c06684b4", ( 0, 0, 0 ) );
        setdvar( @"hash_799306d5bf63dc60", ( 0, 0, 0 ) );
        setdvar( @"hash_964b0f7ebffe811", ( 0, 0, 0 ) );
        setdvar( @"hash_1939a82ea21070d9", "<dev string:xfa3>" );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xfc98eae4, Offset: 0xb03
    // Size: 0x118, Type: dev
    function private function_e2273ff5e9be4a2( params )
    {
        begin_pos = getdvarvector( @"hash_8e505258c06684b4" );
        end_pos = getdvarvector( @"hash_799306d5bf63dc60" );
        apex_pos = getdvarvector( @"hash_964b0f7ebffe811" );
        var_4a4bb453a6edaa91 = getdvar( @"hash_1939a82ea21070d9" );
        subclass = getdvar( @"hash_d20e6d1cea73cddf" );
        
        if ( begin_pos === end_pos )
        {
            iprintlnbold( "<dev string:xfa4>" );
            return;
        }
        
        createnavlink( "<dev string:xf54>", begin_pos, end_pos );
        aitype = function_b3988325430ce242( subclass );
        
        if ( isdefined( aitype ) )
        {
            zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, begin_pos, utility::flatten_vector( vectortoangles( end_pos - begin_pos ) ) );
            
            if ( isdefined( zombie ) )
            {
                zombie val::set( "<dev string:xfe5>", "<dev string:xff5>", 1 );
                zombie val::set( "<dev string:xfe5>", "<dev string:xfff>", 1 );
                zombie thread function_2a69f866d455a44( begin_pos, end_pos, apex_pos, var_4a4bb453a6edaa91 );
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 4, eflags: 0x4
    // Checksum 0xa30219f9, Offset: 0xc23
    // Size: 0xce, Type: dev
    function private function_2a69f866d455a44( begin_pos, end_pos, apex_pos, var_4a4bb453a6edaa91 )
    {
        self endon( #"death" );
        
        if ( apex_pos != ( 0, 0, 0 ) )
        {
            self.apex_pos = apex_pos;
        }
        
        if ( var_4a4bb453a6edaa91 != "<dev string:xfa3>" )
        {
            self.var_4a4bb453a6edaa91 = var_4a4bb453a6edaa91;
        }
        
        self.var_e682032a5bdb2813 = &function_d22edba30174260c;
        end_pos_attractor = { #origin:end_pos };
        zombie_attractor_manager::function_7eb1aaa8bc7cc15( end_pos_attractor );
        
        while ( true )
        {
            utility::waittill_any_timeout( 6, "<dev string:x1008>" );
            
            while ( ai::is_doing_traversal( self ) )
            {
                waitframe();
            }
            
            self forceteleport( begin_pos, self.angles );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x26dd79f0, Offset: 0xcf9
    // Size: 0xf6, Type: dev
    function private function_d22edba30174260c()
    {
        data = traverse::function_b4671daaf4716143();
        
        if ( isdefined( self.apex_pos ) )
        {
            data.traverse_data_calculated = 1;
            data.traverse_height = self.apex_pos[ 2 ];
            data.traverse_height_delta = self.apex_pos[ 2 ] - data.origin[ 2 ];
            data.traverse_drop_height_delta = self.apex_pos[ 2 ] - data.endpos[ 2 ];
            data.apex_delta = self.apex_pos - data.origin;
        }
        
        if ( isdefined( self.var_4a4bb453a6edaa91 ) )
        {
            data.traversetype = self.var_4a4bb453a6edaa91;
        }
        else
        {
            data.traversetype = traverse::function_47b418a27ea582b4( undefined, data );
        }
        
        return data;
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xe0997860, Offset: 0xdf7
    // Size: 0xca, Type: dev
    function private set_all_zombies_movement_speed( params )
    {
        new_speed = params[ 0 ];
        var_120c637c3a41f82b = params[ 1 ];
        priority = int( params[ 2 ] );
        zombies = getaispeciesarray( "<dev string:x1010>", "<dev string:x1015>" );
        
        foreach ( zombie in zombies )
        {
            zombie zombie_utils::function_a8ce00e0448cb6f0( new_speed, var_120c637c3a41f82b, priority );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x5583964d, Offset: 0xec9
    // Size: 0x78, Type: dev
    function private function_c774b075109601b4()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1010>", "<dev string:x1015>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        closest_player_position = var_88f817d755d2b49c getclosestreachablepointonnavmesh( player.origin );
        var_88f817d755d2b49c setbtgoalpos( 0, closest_player_position );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0x8da320cb, Offset: 0xf49
    // Size: 0x90, Type: dev
    function private function_728a1b495c14fd07( params )
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1010>", "<dev string:x1015>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        
        if ( var_88f817d755d2b49c.var_83af5d957815f4eb )
        {
            var_88f817d755d2b49c zombie_bite::function_8381b313b5dc8112( player );
            return;
        }
        
        if ( var_88f817d755d2b49c.enablemelee )
        {
            var_88f817d755d2b49c zombie_melee::function_cede8b4d4a5ae444( player );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0x155ba66c, Offset: 0xfe1
    // Size: 0x67, Type: dev
    function private function_cbd74a8b46fef8d7( params )
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        var_88f817d755d2b49c ai_lookat::enablelookatentity( player );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xef3a869, Offset: 0x1050
    // Size: 0x178, Type: dev
    function private function_46aba79b63be5b0a( params )
    {
        aitype = params[ 0 ];
        subclass = params[ 0 ];
        team = params[ 1 ];
        
        if ( isdefined( level.var_172ac5dce9304093[ subclass ] ) )
        {
            aitype = subclass_to_aitype_map::function_7f9ebc41207674e9( subclass );
        }
        
        if ( !isaitypenamevalid( aitype ) )
        {
            println( "<dev string:x1019>" + aitype + "<dev string:x1030>" );
            return;
        }
        
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( isdefined( origin ) )
        {
            player = level.players[ 0 ];
            
            if ( !isdefined( team ) )
            {
                team = "<dev string:x1061>";
            }
            
            var_c51215b779b5fe59 = player.origin - origin;
            var_c51215b779b5fe59 = ( var_c51215b779b5fe59[ 0 ], var_c51215b779b5fe59[ 1 ], 0 );
            ai = mp_agent::spawnnewagentaitype( aitype, origin, vectortoangles( var_c51215b779b5fe59 ), team );
            
            if ( ai )
            {
                ai.spawn_source = "<dev string:x1072>";
                
                if ( getdvarint( @"hash_6c38ce1320bfb98f", 0 ) )
                {
                    ai.spawn_source = "<dev string:x107e>";
                    spawn_anim_alias = getdvar( @"hash_ad84b507251e9ec8", "<dev string:x1085>" );
                    
                    if ( ai utility::function_4c656524ecb504d6( spawn_anim_alias ) )
                    {
                        origin = getgroundposition( origin, 32, 720, 100 );
                        ai thread utility::animscriptedagent( spawn_anim_alias, "<dev string:x108b>", origin, ( 0, 0, 0 ), "<dev string:x1095>" );
                    }
                }
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x203a4607, Offset: 0x11d0
    // Size: 0x24, Type: dev
    function private function_a9cb0c09a4cccf00()
    {
        iprintln( "<dev string:x10a5>" );
        devgui::function_3f8a26ec96988e80( "<dev string:x10e3>", @"hash_6c38ce1320bfb98f" );
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xe6aef668, Offset: 0x11fc
    // Size: 0xab, Type: dev
    function private stun_all_ai( params )
    {
        duration = float( params[ 0 ] );
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        
        foreach ( zombie in zombies )
        {
            zombie zombie_stun::stun_ai( duration );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x9942391c, Offset: 0x12af
    // Size: 0x67, Type: dev
    function private function_d2b38cbecd415709()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        var_88f817d755d2b49c zombie_knockdown::function_6fc167d4a3590991( player.origin );
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x36d4248b, Offset: 0x131e
    // Size: 0x6c, Type: dev
    function private function_5f587f197580065c()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        var_88f817d755d2b49c zombie_knockdown::function_6fc167d4a3590991( player.origin, 500, 30 );
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x8dec022a, Offset: 0x1392
    // Size: 0x82, Type: dev
    function private function_4daecf26de303902()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        var_88f817d755d2b49c zombie_cannonball::cannonball_ai( var_88f817d755d2b49c.origin - player.origin, 600, zombie_cannonball::adv_settings( 1, 40, 1 ) );
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x7bb84f2d, Offset: 0x141c
    // Size: 0xa7, Type: dev
    function private function_1ea1a6c88d0308c()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( player.origin, zombies )[ 0 ];
        var_88f817d755d2b49c forceteleport( var_88f817d755d2b49c.origin + ( 0, 0, 600 ), var_88f817d755d2b49c.angles );
        waitframe();
        var_88f817d755d2b49c zombie_cannonball::cannonball_ai( ( 1, 0, -4 ), 600, zombie_cannonball::adv_settings( 1, 0, 0 ), "<dev string:x1101>" );
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xec09aac7, Offset: 0x14cb
    // Size: 0xcf, Type: dev
    function private turn_closest_zombie()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_13558672f02377bb = utility::get_array_of_closest( player.origin, zombies );
        
        foreach ( zombie in var_13558672f02377bb )
        {
            if ( !zombie zombie_utils::function_dd3887f0e9e7ff79() )
            {
                zombie zombie_utils::function_c2cee1190760989c( player );
                return;
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0x99c9ac8, Offset: 0x15a2
    // Size: 0xf8, Type: dev
    function private brainrot_closest_zombie( params )
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        var_13558672f02377bb = utility::get_array_of_closest( player.origin, zombies );
        force = params[ 0 ] ? int( params[ 0 ] ) : undefined;
        
        foreach ( zombie in var_13558672f02377bb )
        {
            if ( !zombie zombie_utils::function_33a24849a0dfd13b() )
            {
                zombie zombie_utils::function_f2e381737e46096( player, undefined, undefined, force );
                return;
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x997f6c34, Offset: 0x16a2
    // Size: 0x130, Type: dev
    function private live_ragdoll_closest()
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        var_843124d51c0e1a48 = utility::get_array_of_closest( player.origin, all_ai );
        
        foreach ( ai in var_843124d51c0e1a48 )
        {
            if ( isdefined( ai ) )
            {
                var_df51ebd1af4e96af = "<dev string:x1112>";
                
                if ( ai asmhasstate( ai.asmname, var_df51ebd1af4e96af ) )
                {
                    if ( ai zombie_liveragdoll::function_6273f9e3a020d096( player.origin, getdvarfloat( @"liveragdoll_intensity", 30000 ) ) )
                    {
                        return;
                    }
                    
                    return;
                }
                
                var_df51ebd1af4e96af = "<dev string:x1125>";
                
                if ( ai asmhasstate( ai.asmname, var_df51ebd1af4e96af ) )
                {
                    ai startliveragdoll();
                    ai asm::function_7256f5ba459c840b( var_df51ebd1af4e96af );
                    return;
                }
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xa73fb342, Offset: 0x17da
    // Size: 0xee, Type: dev
    function private function_96c02ab962f6fa35( params )
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        var_843124d51c0e1a48 = utility::get_array_of_closest( player.origin, all_ai );
        
        foreach ( ai in var_843124d51c0e1a48 )
        {
            if ( isdefined( ai ) )
            {
                ai kill();
                corpse = ai getcorpseentity();
                corpse startragdollfromimpact( "<dev string:x1137>", ( 0, 0, 100 ) );
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xfeeddc2a, Offset: 0x18d0
    // Size: 0x113, Type: dev
    function private function_571c0fc0dc0a3eec( params )
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        var_843124d51c0e1a48 = utility::get_array_of_closest( player.origin, all_ai );
        hitloc = params[ 0 ];
        bone = params[ 1 ];
        
        if ( !( isdefined( hitloc ) && isdefined( bone ) ) )
        {
            return;
        }
        
        foreach ( ai in var_843124d51c0e1a48 )
        {
            if ( isalive( ai ) )
            {
                ai kill();
                body = ai getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body thread function_f1963e8b8820c99f( hitloc, bone );
                    return;
                }
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 2, eflags: 0x4
    // Checksum 0x20297035, Offset: 0x19eb
    // Size: 0x12f, Type: dev
    function private function_f1963e8b8820c99f( hitloc, bone )
    {
        self endon( #"death" );
        self startragdoll();
        waitframe();
        
        if ( !isdefined( level.var_4474c9dbf6430ac2 ) )
        {
            level.var_4474c9dbf6430ac2 = [];
        }
        
        if ( !isdefined( level.var_7c7ae7b4233cf708 ) )
        {
            level.var_7c7ae7b4233cf708 = [];
        }
        
        mover = utility::spawn_tag_origin( self.origin + ( 0, 0, 64 ), self.angles );
        constraint = spawnragdollconstraint( self, hitloc, bone, ( 0, 0, 0 ), 0 );
        constraint.origin = mover.origin;
        constraint.angles = mover.angles;
        constraint linkto( mover );
        level.var_4474c9dbf6430ac2[ level.var_4474c9dbf6430ac2.size ] = constraint;
        level.var_7c7ae7b4233cf708[ level.var_7c7ae7b4233cf708.size ] = mover;
        mover moveto( mover.origin + ( 0, 0, 16 ), 3 );
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xc05dc64a, Offset: 0x1b22
    // Size: 0x117, Type: dev
    function private function_748e7f1c3634a6a2()
    {
        if ( isdefined( level.var_7c7ae7b4233cf708 ) )
        {
            foreach ( mover in level.var_7c7ae7b4233cf708 )
            {
                if ( isdefined( mover ) )
                {
                    mover delete();
                }
            }
        }
        
        if ( isdefined( level.var_4474c9dbf6430ac2 ) )
        {
            foreach ( constraint in level.var_4474c9dbf6430ac2 )
            {
                if ( isdefined( constraint ) )
                {
                    constraint delete();
                }
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0xb70cbe80, Offset: 0x1c41
    // Size: 0xbd, Type: dev
    function private force_target_player( params )
    {
        var_6787895101874fb4 = int( params[ 0 ] );
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x1015>" );
        
        foreach ( zombie in zombies )
        {
            zombie zombie_utils::set_ai_target_priority( level.players[ var_6787895101874fb4 ], "<dev string:x1143>", 1 );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xd65ed985, Offset: 0x1d06
    // Size: 0xa9, Type: dev
    function private function_42d73b9e9783ddda()
    {
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || zombie.magic_bullet_shield )
            {
                continue;
            }
            
            zombie kill();
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x4e5435ba, Offset: 0x1db7
    // Size: 0xcd, Type: dev
    function private force_kill_all_zombies()
    {
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie.magic_bullet_shield )
            {
                zombie ai::stop_magic_bullet_shield();
            }
            
            zombie val::nuke( "<dev string:x114f>" );
            zombie val::nuke( "<dev string:x115c>" );
            zombie kill();
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x6a63e3be, Offset: 0x1e8c
    // Size: 0x16f, Type: dev
    function private toggle_zombie_wander_enabled()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x116a>", @"zombie_wander_enabled" );
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        
        foreach ( zombie in zombies )
        {
            if ( isalive( zombie ) && getdvarint( @"zombie_wander_enabled", 0 ) <= 0 )
            {
                zombie._blackboard.var_8d34ab856208146f = 0;
                zombie._blackboard.var_dd1cb4e12c4c12d2 = -1;
                zombie setbtgoalpos( 0, zombie.origin );
                continue;
            }
            
            if ( isalive( zombie ) && getdvarint( @"zombie_wander_enabled", 0 ) <= 1 )
            {
                zombie._blackboard.var_8d34ab856208146f = zombie.var_d6894f01a36b4ff3.maxwanderradius;
                zombie._blackboard.var_dd1cb4e12c4c12d2 = level.gamemodebundle.var_dd1cb4e12c4c12d2;
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xc28c08af, Offset: 0x2003
    // Size: 0xe2, Type: dev
    function private toggle_zombie_pain_enabled()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1180>", @"zombie_pain_enabled" );
        zombies = getaispeciesarray( "<dev string:x1015>", "<dev string:x4b3>" );
        
        foreach ( zombie in zombies )
        {
            if ( isalive( zombie ) && getdvarint( @"zombie_pain_enabled", 0 ) <= 0 )
            {
                zombie val::set( "<dev string:x1194>", "<dev string:x11a6>", 0 );
                continue;
            }
            
            zombie val::reset( "<dev string:x1194>", "<dev string:x11a6>" );
        }
    }

    // Namespace agent_zombie_devgui
    // Params 1, eflags: 0x4
    // Checksum 0x312f1ab6, Offset: 0x20ed
    // Size: 0x144, Type: dev
    function private function_61f22ca2ea30fa1f( params )
    {
        default_playback_rate = getdvarfloat( @"hash_6e935f28285219c9", 1 );
        var_70edf429f5fffd4d = undefined;
        
        if ( isdefined( params[ 0 ] ) )
        {
            var_70edf429f5fffd4d = script::stringtofloat( params[ 0 ] );
            default_playback_rate += var_70edf429f5fffd4d;
            setdvar( @"hash_6e935f28285219c9", default_playback_rate );
        }
        
        iprintlnbold( "<dev string:x11ab>" + default_playback_rate );
        all_ai = getaispeciesarray( "<dev string:x1015>", "<dev string:x1015>" );
        
        foreach ( ai in all_ai )
        {
            if ( isdefined( ai ) && default_playback_rate != ai.animplaybackratedefault )
            {
                if ( !isdefined( ai.animplaybackrateoriginal ) )
                {
                    ai.animplaybackrateoriginal = ai.animplaybackratedefault;
                }
                
                ai.animplaybackratedefault = default_playback_rate;
                ai restartanim( ai getnormalizedanimtime() );
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0x1fa1604d, Offset: 0x2239
    // Size: 0xe7, Type: dev
    function private function_e5e224c84d88e35c()
    {
        all_ai = getaispeciesarray( "<dev string:x1015>", "<dev string:x1015>" );
        iprintlnbold( "<dev string:x11c4>" );
        setdvar( @"hash_6e935f28285219c9", 1 );
        
        foreach ( ai in all_ai )
        {
            if ( isdefined( ai ) && isdefined( ai.animplaybackrateoriginal ) )
            {
                ai.animplaybackratedefault = ai.animplaybackrateoriginal;
                ai.animplaybackrateoriginal = undefined;
                ai restartanim( ai getnormalizedanimtime() );
            }
        }
    }

    // Namespace agent_zombie_devgui
    // Params 0, eflags: 0x4
    // Checksum 0xd763f7dd, Offset: 0x2328
    // Size: 0x71, Type: dev
    function private toggle_ranged_attack()
    {
        zombies = getaispeciesarray( "<dev string:x1010>", "<dev string:x1015>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        while ( true )
        {
            if ( !isalive( var_88f817d755d2b49c ) )
            {
                return;
            }
            
            if ( !var_88f817d755d2b49c namespace_96f746e657c877bf::is_in_ranged_attack() )
            {
                var_88f817d755d2b49c namespace_96f746e657c877bf::force_ranged_attack();
            }
            
            waitframe();
        }
    }

#/
