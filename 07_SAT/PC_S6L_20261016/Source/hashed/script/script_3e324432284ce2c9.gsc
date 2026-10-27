// script_3e324432284ce2c9  (hash_3e324432284ce2c9.gscc) (size: 3883 Bytes / 0xf2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8a3bfa3 (3903045539)
// size ...... 3883 (0xf2b)
// includes .. 3   (offset: 0xdf3)
// strings ... 2   (offset: 0xe0b)
// dev strs .. 20  (offset: 0xe2f)
// exports ... 9   (offset: 0x7cf)
// cseg ...... 0x6f + 0x760 (0x7cf)
// imports ... 40  (offset: 0x937)
// animtree1 . 0   (offset: 0xf2b)
// animtree2 . 0   (offset: 0xf2b)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\mp_agent;

#namespace namespace_abe3c6a0d1969d3c;

// Namespace namespace_abe3c6a0d1969d3c
// Params 0
// Checksum 0x7a77dbf7, Offset: 0x8d
// Size: 0x28
function function_cd44eebeae7412f5()
{
    /#
        function_4a1c8c5acb9060c0();
    #/
    
    if ( getdvarint( @"hash_3def865b1007aa0a", 0 ) <= 0 )
    {
        return;
    }
    
    level thread function_29e8ec99b1a0e758();
}

// Namespace namespace_abe3c6a0d1969d3c
// Params 0, eflags: 0x4
// Checksum 0xb216da50, Offset: 0xbd
// Size: 0x33d
function private function_29e8ec99b1a0e758()
{
    level endon( #"game_ended" );
    ai_spawned = [];
    ai_spawn_counter = 0;
    setdvarifuninitialized( @"hash_644b3f4397fa5d18", 10 );
    setdvarifuninitialized( @"hash_d01329968e8441bf", 500 );
    
    while ( true )
    {
        if ( getdvarint( @"hash_3def865b1007aa0a", 0 ) <= 0 )
        {
            foreach ( ai in ai_spawned )
            {
                if ( isalive( ai ) )
                {
                    ai kill();
                }
            }
            
            return;
        }
        
        target_ai_count = getdvarint( @"hash_644b3f4397fa5d18" );
        target_ai_count = int( clamp( target_ai_count, 0, 1000 ) );
        setdvar( @"hash_644b3f4397fa5d18", target_ai_count );
        radius = getdvarint( @"hash_d01329968e8441bf" );
        radius = int( clamp( radius, 100, 1000 ) );
        setdvar( @"hash_d01329968e8441bf", radius );
        alive_ai = [];
        
        foreach ( ai in ai_spawned )
        {
            if ( isalive( ai ) )
            {
                alive_ai[ alive_ai.size ] = ai;
            }
        }
        
        ai_spawned = alive_ai;
        
        if ( ai_spawned.size > target_ai_count && ai_spawned.size > 0 )
        {
            for ( ai_index = target_ai_count; ai_index < ai_spawned.size ; ai_index++ )
            {
                if ( isalive( ai_spawned[ ai_index ] ) )
                {
                    ai_spawned[ ai_index ] kill();
                }
            }
        }
        else if ( ai_spawned.size < target_ai_count )
        {
            ai_spawn_counter++;
            
            if ( level.players.size > 0 )
            {
                target_player = level.players[ ai_spawn_counter % level.players.size ];
                
                if ( isalive( target_player ) )
                {
                    radius = getdvarint( @"hash_d01329968e8441bf" );
                    spawn_point = getrandomnavpoint( target_player.origin, radius );
                    
                    if ( isdefined( spawn_point ) )
                    {
                        spawn_point = getgroundposition( spawn_point, 8 );
                    }
                    
                    if ( isdefined( spawn_point ) )
                    {
                        aitype = getdvar( @"hash_7c41690a3ff1013", "none" );
                        
                        if ( aitype != "none" )
                        {
                            team = utility::get_enemy_team( target_player.team );
                            team_override = getdvar( @"hash_fa5440523090320", "none" );
                            
                            if ( team_override != "none" )
                            {
                                team = team_override;
                            }
                            
                            agent = mp_agent::spawnnewagentaitype( aitype, spawn_point, ( 0, 0, 0 ), team );
                            
                            if ( isdefined( agent ) )
                            {
                                agent.spawn_source = "dev_spawned";
                                ai_spawned[ ai_spawned.size ] = agent;
                            }
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 0, eflags: 0x4
    // Checksum 0x48b717af, Offset: 0x402
    // Size: 0x57, Type: dev
    function private function_4a1c8c5acb9060c0()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x49>", &function_175f6c764a47cb3f );
        devgui::add_devgui_dvar( "<dev string:x5c>", "<dev string:x65>" );
        devgui::add_devgui_dvar( "<dev string:x7d>", "<dev string:x8a>" );
        function_48fbfa25432a428a();
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 0, eflags: 0x4
    // Checksum 0x9fe697c, Offset: 0x461
    // Size: 0x57, Type: dev
    function private function_175f6c764a47cb3f()
    {
        iprintlnbold( "<dev string:xa3>" + !getdvarint( @"hash_3def865b1007aa0a", 0 ) );
        setdvar( @"hash_3def865b1007aa0a", !getdvarint( @"hash_3def865b1007aa0a", 0 ) );
        
        if ( getdvarint( @"hash_3def865b1007aa0a", 0 ) > 0 )
        {
            level thread function_29e8ec99b1a0e758();
        }
    }

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 1
    // Checksum 0x5c38ff54, Offset: 0x4c0
    // Size: 0x86, Type: dev
    function function_c3a83dd24de3fe0b( aitype )
    {
        if ( !isdefined( level.var_1e26ddd83e046dab ) )
        {
            level.var_1e26ddd83e046dab = [];
        }
        
        if ( isdefined( level.var_1e26ddd83e046dab[ aitype ] ) )
        {
            return;
        }
        
        level.var_1e26ddd83e046dab[ level.var_1e26ddd83e046dab.size ] = aitype;
        devgui::function_9082edeb5db93280( "<dev string:xbf>" );
        devgui::function_cd4e263c1f3018ae( aitype, "<dev string:xe3>" + aitype, &function_d16e4bb39ed144dd );
        devgui::function_77df7fe7dd273e10();
        setdvarifuninitialized( @"hash_7c41690a3ff1013", aitype );
    }

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 1, eflags: 0x4
    // Checksum 0xb75e649c, Offset: 0x54e
    // Size: 0x2e, Type: dev
    function private function_d16e4bb39ed144dd( param )
    {
        aitype = param[ 0 ];
        setdvar( @"hash_7c41690a3ff1013", aitype );
    }

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 0, eflags: 0x4
    // Checksum 0x3abe6504, Offset: 0x584
    // Size: 0x160, Type: dev
    function private function_48fbfa25432a428a()
    {
        var_c289eb3d88bbddb7 = getaitypenames();
        
        foreach ( aitype_to_spawn in var_c289eb3d88bbddb7 )
        {
            aitypescriptbundle = getaitypescriptbundle( aitype_to_spawn );
            character_names = [];
            
            for ( i = 0; i < aitypescriptbundle.charactertypes.size ; i++ )
            {
                var_fb4a0ee0ff160759 = aitypescriptbundle.charactertypes[ i ].character;
                
                if ( var_fb4a0ee0ff160759 != "<dev string:x101>" )
                {
                    character_names[ character_names.size ] = var_fb4a0ee0ff160759;
                }
            }
            
            if ( character_names.size == 1 )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x102>" + aitype_to_spawn, "<dev string:x115>" + aitype_to_spawn + "<dev string:x123>" + i, &function_26adc60c062db44f );
                continue;
            }
            
            for ( i = 0; i < character_names.size ; i++ )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x102>" + aitype_to_spawn + "<dev string:x125>" + character_names[ i ], "<dev string:x115>" + aitype_to_spawn + "<dev string:x123>" + i, &function_26adc60c062db44f );
            }
        }
    }

    // Namespace namespace_abe3c6a0d1969d3c
    // Params 1, eflags: 0x4
    // Checksum 0xbee5b7ca, Offset: 0x6ec
    // Size: 0xe3, Type: dev
    function private function_26adc60c062db44f( params )
    {
        aitype = params[ 0 ];
        characterindex = int( params[ 1 ] );
        
        if ( !isaitypenamevalid( aitype ) )
        {
            println( "<dev string:x127>" + aitype + "<dev string:x13e>" );
            return;
        }
        
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( isdefined( origin ) )
        {
            team = issubstr( aitype, "<dev string:x16f>" ) ? "<dev string:x176>" : undefined;
            agent = mp_agent::spawnnewagentaitype( aitype, origin, ( 0, 0, 0 ), team, undefined, undefined, characterindex );
            
            if ( agent )
            {
                agent.spawn_source = "<dev string:x187>";
                agent setgoalpos( agent.origin, getdvarint( @"hash_7605218c522f333d", 500 ) );
            }
        }
    }

#/
