// script_572da4be40f40273  (hash_572da4be40f40273.gscc) (size: 8546 Bytes / 0x2162 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x916fd56d (2440025453)
// size ...... 8546 (0x2162)
// includes .. 9   (offset: 0x1f7e)
// strings ... 9   (offset: 0x1fc6)
// dev strs .. 23  (offset: 0x204a)
// exports ... 31  (offset: 0x12aa)
// cseg ...... 0x122 + 0x1188 (0x12aa)
// imports ... 66  (offset: 0x1782)
// animtree1 . 0   (offset: 0x2162)
// animtree2 . 0   (offset: 0x2162)
#using script_16ea1b94f0f381b3;
#using script_497ff7fb3c0b15e4;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\ai\aitypes\juggernaut\sat_juggernaut;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\mp\bots\bots;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\loot\common_item;

#namespace namespace_6677ae6d9a73bda;

// Namespace namespace_6677ae6d9a73bda
// Params 0
// Checksum 0xa9cf0fed, Offset: 0x140
// Size: 0xbb
function init()
{
    if ( level.var_c313573d79a3a610 )
    {
        return;
    }
    
    key_manager = spawnstruct();
    level.var_c313573d79a3a610 = key_manager;
    var_6be487d5d348ad9 = activity_definition_utils::function_9129cd8075c85c09( getscriptbundle( %"hash_118f126c18ff8ab" ) );
    key_manager.key_drop_chance = var_6be487d5d348ad9.var_35a58968766b0208;
    key_manager.var_166d9f4a161dad93 = 0;
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    level callback::add( #"player_item_pickup", &on_item_picked_up );
    level callback::add( "scripted_item_can_autouse", &function_5a9ba9828fe134e6 );
    level callback::add( "scripted_item_can_use", &function_5a9ba9828fe134e6 );
}

// Namespace namespace_6677ae6d9a73bda
// Params 0
// Checksum 0x6814f439, Offset: 0x203
// Size: 0xd6
function function_5cb7ead85aa146c0()
{
    if ( !level.var_c313573d79a3a610 )
    {
        return;
    }
    
    level.var_c313573d79a3a610 notify( #"hash_39f887c8a8d50fbd" );
    
    if ( level callback::exists( #"player_item_pickup", &on_item_picked_up ) )
    {
        level callback::remove( #"player_item_pickup", &on_item_picked_up );
    }
    
    if ( level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
    {
        level callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    }
    
    if ( level callback::exists( "scripted_item_can_autouse", &function_5a9ba9828fe134e6 ) )
    {
        level callback::remove( "scripted_item_can_autouse", &function_5a9ba9828fe134e6 );
    }
    
    if ( level callback::exists( "scripted_item_can_use", &function_5a9ba9828fe134e6 ) )
    {
        level callback::remove( "scripted_item_can_use", &function_5a9ba9828fe134e6 );
    }
    
    level.var_c313573d79a3a610 = undefined;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0
// Checksum 0x500e282f, Offset: 0x2e1
// Size: 0x2f
function function_20336f89f16f7bb8()
{
    agent = self;
    struct = agent function_16460929d9fdf1db();
    struct.disable_drop_key = 1;
}

// Namespace namespace_6677ae6d9a73bda
// Params 1
// Checksum 0xbbc154e6, Offset: 0x318
// Size: 0x11f
function free_a_key( key_owner )
{
    level.var_c313573d79a3a610.var_166d9f4a161dad93--;
    assert( level.var_c313573d79a3a610.var_166d9f4a161dad93 >= 0, "<dev string:x24>" );
    level.var_c313573d79a3a610.var_166d9f4a161dad93 = maxint( level.var_c313573d79a3a610.var_166d9f4a161dad93, 0 );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] free a key" + ", dropped " + level.var_c313573d79a3a610.var_166d9f4a161dad93 + ", remain " + getdvarint( @"hash_d5211ffe2b9a59f5", 8 ) - level.var_c313573d79a3a610.var_166d9f4a161dad93 );
    }
    
    if ( key_owner )
    {
        struct = key_owner function_145fa8565a19143e();
        
        if ( !struct.keys_count )
        {
            return;
        }
        
        struct.keys_count--;
        level callback::callback( #"hash_57e9466dae6341a5", { #player:key_owner } );
    }
}

// Namespace namespace_6677ae6d9a73bda
// Params 1
// Checksum 0x2a86ea8e, Offset: 0x43f
// Size: 0x3c, Type: bool
function function_c55a70928f89278e( player )
{
    struct = player function_145fa8565a19143e();
    return struct.keys_count && struct.keys_count > 0;
}

// Namespace namespace_6677ae6d9a73bda
// Params 1, eflags: 0x4
// Checksum 0x51e14a2e, Offset: 0x484
// Size: 0x113
function private function_8c5e06ee1e60aeb7( params )
{
    agent = params.victim;
    
    if ( !is_target_ai( agent ) )
    {
        return;
    }
    
    player_attacker = undefined;
    attacker = params.eattacker;
    
    if ( isplayer( attacker ) )
    {
        player_attacker = attacker;
    }
    else if ( attacker.owner && isplayer( attacker.owner ) )
    {
        player_attacker = attacker.owner;
    }
    
    if ( !player_attacker )
    {
        return;
    }
    
    if ( !isenemyteam( agent.team, player_attacker.team ) )
    {
        return;
    }
    
    if ( player_attacker function_580806b7b5fa374a() )
    {
        return;
    }
    
    if ( agent function_7969d9cb0ef0f179() )
    {
        return;
    }
    
    if ( !function_e5ded61b865fbc29() )
    {
        return;
    }
    
    var_dcef9be67174ef20 = get_key_drop_chance();
    
    if ( randomint( 100 ) >= var_dcef9be67174ef20 )
    {
        return;
    }
    
    function_61722270145056c3( agent.origin, agent.angles, player_attacker );
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0x8c670778, Offset: 0x59f
// Size: 0x55, Type: bool
function private function_580806b7b5fa374a()
{
    player = self;
    
    /#
        if ( getdvarint( @"hash_b20e0e03ec9ed47c", 0 ) )
        {
            return false;
        }
    #/
    
    struct = player function_145fa8565a19143e();
    var_e43eb40cd21326e7 = struct.keys_count ?? 0;
    return var_e43eb40cd21326e7 >= 1;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0xb3650b0, Offset: 0x5fd
// Size: 0x5b
function private function_7969d9cb0ef0f179()
{
    agent = self;
    
    if ( is_agent_dawg( agent ) && agent.owner.var_6b368a0a50a424c5 )
    {
        return 1;
    }
    
    struct = agent function_4782908eb8d4f300();
    
    if ( !struct )
    {
        return 0;
    }
    
    return struct.disable_drop_key;
}

// Namespace namespace_6677ae6d9a73bda
// Params 1, eflags: 0x4
// Checksum 0x70eb6a71, Offset: 0x661
// Size: 0x95
function private is_target_ai( agent )
{
    /#
        if ( getdvarint( @"hash_d23bb86d699f3ef1", 0 ) )
        {
            return 1;
        }
    #/
    
    if ( !isagent( agent ) )
    {
        return 0;
    }
    
    if ( !function_8aec64975cff8ba0( agent.difficulty, "difficulty_darkaether" ) )
    {
        return 0;
    }
    
    is_dawg = is_agent_dawg( agent );
    
    if ( is_dawg )
    {
        return 1;
    }
    
    is_rhino = juggerbot::is_agent_juggerbot( agent );
    
    if ( is_rhino )
    {
        return 1;
    }
    
    is_titan = sat_juggernaut::is_agent_juggernaut( agent );
    return is_titan;
}

// Namespace namespace_6677ae6d9a73bda
// Params 1, eflags: 0x4
// Checksum 0x61ec7bf9, Offset: 0x6ff
// Size: 0x21, Type: bool
function private is_agent_dawg( agent )
{
    return agent.subclass == #"dawg";
}

// Namespace namespace_6677ae6d9a73bda
// Params 2, eflags: 0x4
// Checksum 0x8710ab42, Offset: 0x729
// Size: 0x85, Type: bool
function private function_8aec64975cff8ba0( difficulty, target_difficulty )
{
    i_difficulty = level.region_difficulty_manager.region_difficulty_to_int[ difficulty ];
    i_target_difficulty = level.region_difficulty_manager.region_difficulty_to_int[ target_difficulty ];
    
    if ( !isdefined( i_difficulty ) || !isdefined( i_target_difficulty ) )
    {
        assertmsg( "<dev string:x4f>" + difficulty + "<dev string:xaa>" + target_difficulty );
        return false;
    }
    
    return i_difficulty >= i_target_difficulty;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0x251c9ea4, Offset: 0x7b7
// Size: 0x33, Type: bool
function private function_e5ded61b865fbc29()
{
    max_keys = getdvarint( @"hash_d5211ffe2b9a59f5", 8 );
    return level.var_c313573d79a3a610.var_166d9f4a161dad93 < max_keys;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0xc3ddf3b5, Offset: 0x7f3
// Size: 0x52
function private get_key_drop_chance()
{
    level.var_c313573d79a3a610.key_drop_chance = getdvarint( hashcat( @"hash_6caf05e0a6fa6d7e", "key_drop_chance" ), level.var_c313573d79a3a610.key_drop_chance );
    return level.var_c313573d79a3a610.key_drop_chance;
}

// Namespace namespace_6677ae6d9a73bda
// Params 3, eflags: 0x4
// Checksum 0x421eec37, Offset: 0x84e
// Size: 0x52
function private spawn_key( origin, angles, owner )
{
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( origin, angles );
    key_item = common_item::function_61c2c0251e742ffd( %"hash_78d9fe9b532d13ff", 1, spawn_options );
    return key_item;
}

// Namespace namespace_6677ae6d9a73bda
// Params 3, eflags: 0x4
// Checksum 0xd758c88c, Offset: 0x8a9
// Size: 0xb1
function private function_61722270145056c3( origin, angles, owner )
{
    key_item = spawn_key( origin, angles, owner );
    
    if ( !key_item )
    {
        return;
    }
    
    key_item thread function_4a1ee20b56d8188a();
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] key dropped, owner " + owner.name + ", dropped " + level.var_c313573d79a3a610.var_166d9f4a161dad93 + ", remain " + getdvarint( @"hash_d5211ffe2b9a59f5", 8 ) - level.var_c313573d79a3a610.var_166d9f4a161dad93 );
    }
    
    return key_item;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0xc
// Checksum 0xef5a052d, Offset: 0x963
// Size: 0x7d
function private function_4a1ee20b56d8188a()
{
    self notify( #"hash_2018556b999c303a" );
    self endon( #"hash_2018556b999c303a" );
    self endon( #"locked_in_key_picked_up" );
    level.var_c313573d79a3a610 endon( #"hash_39f887c8a8d50fbd" );
    level.var_c313573d79a3a610.var_166d9f4a161dad93++;
    self waittill( #"death" );
    
    if ( getdvarint( @"hash_8582636667fe715d", 0 ) )
    {
        logstring( "[LIKM] one key deleted" );
    }
    
    free_a_key();
}

// Namespace namespace_6677ae6d9a73bda
// Params 1, eflags: 0x4
// Checksum 0x458b9983, Offset: 0x9e8
// Size: 0x82, Type: bool
function private function_5a9ba9828fe134e6( params )
{
    if ( params.bundle.ref != #"hash_c1e8c7c582913136" )
    {
        return true;
    }
    
    player = params.player;
    
    if ( !player )
    {
        return false;
    }
    
    if ( player function_580806b7b5fa374a() )
    {
        if ( level.showerrormessagefunc )
        {
            player [[ level.showerrormessagefunc ]]( %"hash_250e3cf610c8f962" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace namespace_6677ae6d9a73bda
// Params 2, eflags: 0x4
// Checksum 0xbf2969dd, Offset: 0xa73
// Size: 0xa3
function private on_item_picked_up( params, activity_instance )
{
    if ( params.itembundlename != %"hash_78d9fe9b532d13ff" )
    {
        return;
    }
    
    if ( !params.player )
    {
        return;
    }
    
    if ( !params.item )
    {
        return;
    }
    
    player = params.player;
    function_b6bf37ebb3936a0d( player );
    params.item notify( #"locked_in_key_picked_up", player );
    level callback::callback( #"ob_locked_in_key_pickup", { #player:player } );
}

// Namespace namespace_6677ae6d9a73bda
// Params 1, eflags: 0x4
// Checksum 0xa74983f6, Offset: 0xb1e
// Size: 0x2c
function private function_b6bf37ebb3936a0d( player )
{
    key_struct = player function_54c0b4d5aa9b581f();
    key_struct.keys_count++;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0x8c4dc1e4, Offset: 0xb52
// Size: 0x40
function private function_54c0b4d5aa9b581f()
{
    if ( !self.var_a58f505f9938b5a8 )
    {
        struct = spawnstruct();
        struct.keys_count = 0;
        self.var_a58f505f9938b5a8 = struct;
    }
    
    return self.var_a58f505f9938b5a8;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0x28d1a3ac, Offset: 0xb9b
// Size: 0xb
function private function_145fa8565a19143e()
{
    return self.var_a58f505f9938b5a8;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0xef804a69, Offset: 0xbaf
// Size: 0x40
function private function_16460929d9fdf1db()
{
    if ( !self.var_a58f505f9938b5a8 )
    {
        struct = spawnstruct();
        struct.disable_drop_key = 0;
        self.var_a58f505f9938b5a8 = struct;
    }
    
    return self.var_a58f505f9938b5a8;
}

// Namespace namespace_6677ae6d9a73bda
// Params 0, eflags: 0x4
// Checksum 0x451335dd, Offset: 0xbf8
// Size: 0xb
function private function_4782908eb8d4f300()
{
    return self.var_a58f505f9938b5a8;
}

/#

    // Namespace namespace_6677ae6d9a73bda
    // Params 1
    // Checksum 0xadd27d63, Offset: 0xc0c
    // Size: 0x8d, Type: dev
    function devgui_init( root_path )
    {
        devgui::function_9082edeb5db93280( root_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc0>", "<dev string:xd0>", &dev_drop_key );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe5>", "<dev string:xfd>", &dev_drop_key );
        devgui::function_cd4e263c1f3018ae( "<dev string:x112>", "<dev string:x12d>", &dev_drop_key );
        devgui::function_cd4e263c1f3018ae( "<dev string:x142>", "<dev string:x151>", &dev_spawn_ai );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16a>", "<dev string:x178>", &dev_spawn_ai );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 1, eflags: 0x4
    // Checksum 0x2bf4b865, Offset: 0xca1
    // Size: 0x14c, Type: dev
    function private dev_drop_key( params )
    {
        level endon( #"game_ended" );
        key_type = int( params[ 0 ] );
        me = level.players[ 0 ];
        my_f = anglestoforward( me.angles );
        drop_pos = me.origin + my_f * 100;
        owner = undefined;
        
        if ( key_type == 0 )
        {
            owner = me;
        }
        else
        {
            var_ad886221177e49d9 = key_type == 1;
            owner = get_another_player( me, var_ad886221177e49d9 );
            
            if ( !owner )
            {
                waitting_bot = 0;
                
                while ( !owner )
                {
                    waitframe();
                    owner = get_another_player( me, var_ad886221177e49d9 );
                    
                    if ( !owner && !waitting_bot )
                    {
                        waitting_bot = 1;
                        
                        if ( var_ad886221177e49d9 )
                        {
                            bots::spawn_bots( 1, me.team );
                            continue;
                        }
                        
                        bots::spawn_bots( 4, me.team );
                    }
                }
            }
        }
        
        key_item = function_61722270145056c3( drop_pos, me.angles, owner );
        me childthread debug_line_to_target( key_item, "<dev string:x190>", ( 0, 1, 0 ) );
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 2, eflags: 0x4
    // Checksum 0xb9fe906, Offset: 0xdf5
    // Size: 0x126, Type: dev
    function private get_another_player( me, var_ad886221177e49d9 )
    {
        var_538c0694c880e740 = me squad_utility::getsquadmembers();
        
        if ( var_ad886221177e49d9 )
        {
            foreach ( player in var_538c0694c880e740 )
            {
                if ( player == me )
                {
                    continue;
                }
                
                return player;
            }
            
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( player == me || arraycontains( var_538c0694c880e740, player ) )
            {
                continue;
            }
            
            return player;
        }
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 1, eflags: 0x4
    // Checksum 0x4e87d28e, Offset: 0xf23
    // Size: 0x1f7, Type: dev
    function private dev_spawn_ai( params )
    {
        me = level.players[ 0 ];
        subclass_list = undefined;
        
        if ( params[ 0 ] == "<dev string:x194>" )
        {
            subclass_list = [ "<dev string:x19a>" ];
        }
        else if ( params[ 0 ] == "<dev string:x1ac>" )
        {
            subclass_list = [ "<dev string:x1b1>", "<dev string:x1bb>" ];
        }
        else
        {
            me iprintlnbold( "<dev string:x1c9>" + params[ 0 ] );
            return;
        }
        
        spawn_pos = me.origin + anglestoforward( me.angles ) * 150;
        right = anglestoright( me.angles );
        
        foreach ( subclass in subclass_list )
        {
            var_1b1e063b9b82d31a = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( subclass );
            
            foreach ( index, ai_type in var_1b1e063b9b82d31a )
            {
                spawn_pos += right * 80 * index;
                spawn_pos = getclosestpointonnavmesh( spawn_pos );
                ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( ai_type, spawn_pos, ( 0, 0, 0 ), "<dev string:x1e5>" );
                ai.difficulty = "<dev string:x1f6>";
                ai thread draw_ai_info( ai_type, subclass );
            }
        }
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 2, eflags: 0xc
    // Checksum 0xebb45fc7, Offset: 0x1122
    // Size: 0x9c, Type: dev
    function private draw_ai_info( ai_type, subclass )
    {
        self notify( #"hash_c2f0055938aa51c" );
        self endon( #"hash_c2f0055938aa51c" );
        self endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !self )
            {
                break;
            }
            
            origin = self.origin;
            print3d( origin, ai_type + "<dev string:x20c>" + subclass + "<dev string:x20c>" + self.unittype, ( 1, 1, 1 ), 1, 0.3, 1, 1 );
        }
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 4, eflags: 0x4
    // Checksum 0xe34aab15, Offset: 0x11c6
    // Size: 0xc4, Type: dev
    function private debug_line_to_target( target, text, color, radius )
    {
        if ( !isdefined( radius ) )
        {
            radius = 20;
        }
        
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        target endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !self || !target )
            {
                break;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, radius, color );
            print3d( target.origin, text, color );
        }
    }

    // Namespace namespace_6677ae6d9a73bda
    // Params 1
    // Checksum 0x5d0b9df, Offset: 0x1292
    // Size: 0x18, Type: dev
    function function_1840dacbac83750d( player )
    {
        function_b6bf37ebb3936a0d( player );
    }

#/
