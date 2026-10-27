// scripts\common\ai\stealth\utility.gsc  (hash_260830c4068c44eb.gscc) (size: 11203 Bytes / 0x2bc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x903bae3c (2419830332)
// size ...... 11203 (0x2bc3)
// includes .. 8   (offset: 0x2947)
// strings ... 20  (offset: 0x2987)
// dev strs .. 8   (offset: 0x2b57)
// exports ... 52  (offset: 0x1a03)
// cseg ...... 0x163 + 0x18a0 (0x1a03)
// imports ... 57  (offset: 0x2223)
// animtree1 . 0   (offset: 0x2bc3)
// animtree2 . 0   (offset: 0x2bc3)
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\friendly;
#using scripts\common\ai\stealth\init;
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\neutral;
#using scripts\common\utility;

#namespace utility;

// Namespace utility
// Params 1
// Checksum 0x636998b1, Offset: 0x181
// Size: 0x5c
function get_group( name )
{
    if ( !isdefined( level.stealth.groupdata.groups[ name ] ) )
    {
        return;
    }
    
    return level.stealth.groupdata.groups[ name ].members;
}

// Namespace utility
// Params 2
// Checksum 0xa852bc2d, Offset: 0x1e6
// Size: 0x52
function get_group_flagname( f, group )
{
    if ( !isdefined( group ) )
    {
        assert( issentient( self ), "<dev string:x24>" );
        group = self.script_stealthgroup;
    }
    
    name = f + "-Group:" + group;
    return name;
}

// Namespace utility
// Params 1
// Checksum 0xf7511e07, Offset: 0x241
// Size: 0x29
function group_flag_wait( f )
{
    name = get_group_flagname( f );
    flag_wait( name );
}

// Namespace utility
// Params 1
// Checksum 0x680b8ca4, Offset: 0x272
// Size: 0x29
function group_flag_waitopen( f )
{
    name = get_group_flagname( f );
    flag_waitopen( name );
}

// Namespace utility
// Params 1
// Checksum 0x2bea39ab, Offset: 0x2a3
// Size: 0x14e
function group_flag_init( f )
{
    assert( issentient( self ), "<dev string:x24>" );
    
    if ( isdefined( self.script_stealthgroup ) )
    {
        self.script_stealthgroup = string( self.script_stealthgroup );
    }
    else
    {
        self.script_stealthgroup = "default";
    }
    
    if ( !ismp() && self.team == "allies" )
    {
        self.script_stealthgroup += "allies";
    }
    
    if ( !flag_exist( f ) )
    {
        flag_init( f );
    }
    
    name = get_group_flagname( f );
    
    if ( !flag_exist( name ) )
    {
        flag_init( name );
        
        if ( !isdefined( level.stealth.group.flags[ f ] ) )
        {
            level.stealth.group.flags[ f ] = [];
        }
        
        level.stealth.group.flags[ f ][ level.stealth.group.flags[ f ].size ] = name;
    }
}

// Namespace utility
// Params 2
// Checksum 0xf0a530fa, Offset: 0x3f9
// Size: 0x6a
function group_setcombatgoalradius( group, goalradius )
{
    assert( isdefined( level.stealth ) );
    
    if ( !isdefined( level.stealth.combat_goalradius ) )
    {
        level.stealth.combat_goalradius = [];
    }
    
    level.stealth.combat_goalradius[ group ] = goalradius;
}

// Namespace utility
// Params 0
// Checksum 0xcdea0831, Offset: 0x46b
// Size: 0xd9
function group_add()
{
    assert( issentient( self ), "<dev string:x24>" );
    
    if ( !isdefined( level.stealth.group.groups[ self.script_stealthgroup ] ) )
    {
        level.stealth.group.groups[ self.script_stealthgroup ] = [];
        level.stealth.group notify( self.script_stealthgroup );
    }
    
    level.stealth.group.groups[ self.script_stealthgroup ][ level.stealth.group.groups[ self.script_stealthgroup ].size ] = self;
}

// Namespace utility
// Params 0
// Checksum 0xc8adc73f, Offset: 0x54c
// Size: 0x47
function group_spotted_flag()
{
    if ( !ismp() )
    {
        assert( self.team != "<dev string:x42>", "<dev string:x47>" );
    }
    
    name = get_group_flagname( "stealth_spotted" );
    return flag( name );
}

// Namespace utility
// Params 0
// Checksum 0xc58912e, Offset: 0x59c
// Size: 0x17
function any_groups_in_combat()
{
    if ( !flag( "stealth_enabled" ) )
    {
        return 0;
    }
    
    return stealthgetanyaiincombat();
}

/#

    // Namespace utility
    // Params 0
    // Checksum 0x2a247f8b, Offset: 0x5bc
    // Size: 0x23, Type: dev
    function check_stealth()
    {
        assert( isdefined( self.stealth ), "<dev string:x76>" + self.origin );
    }

#/

// Namespace utility
// Params 2
// Checksum 0x41842666, Offset: 0x5e7
// Size: 0x3b
function set_detect_ranges( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xa6>" );
    }
    
    stealth_manager::set_detect_ranges_internal( hidden, spotted );
}

// Namespace utility
// Params 2
// Checksum 0x10638e5b, Offset: 0x62a
// Size: 0xc1
function set_min_detect_range_darkness( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xc8>" );
    }
    
    if ( isdefined( hidden ) )
    {
        setstealthminrangedarkness( "hidden", "prone", hidden[ "prone" ] );
        setstealthminrangedarkness( "hidden", "crouch", hidden[ "crouch" ] );
        setstealthminrangedarkness( "hidden", "stand", hidden[ "stand" ] );
    }
    
    if ( isdefined( spotted ) )
    {
        setstealthminrangedarkness( "spotted", "prone", spotted[ "prone" ] );
        setstealthminrangedarkness( "spotted", "crouch", spotted[ "crouch" ] );
        setstealthminrangedarkness( "spotted", "stand", spotted[ "stand" ] );
    }
}

// Namespace utility
// Params 2
// Checksum 0xace35027, Offset: 0x6f3
// Size: 0xc1
function set_min_detect_range_shadow( hidden, spotted )
{
    if ( !isdefined( hidden ) && !isdefined( spotted ) )
    {
        assertmsg( "<dev string:xc8>" );
    }
    
    if ( isdefined( hidden ) )
    {
        setstealthminrangeshadow( "hidden", "prone", hidden[ "prone" ] );
        setstealthminrangeshadow( "hidden", "crouch", hidden[ "crouch" ] );
        setstealthminrangeshadow( "hidden", "stand", hidden[ "stand" ] );
    }
    
    if ( isdefined( spotted ) )
    {
        setstealthminrangeshadow( "spotted", "prone", spotted[ "prone" ] );
        setstealthminrangeshadow( "spotted", "crouch", spotted[ "crouch" ] );
        setstealthminrangeshadow( "spotted", "stand", spotted[ "stand" ] );
    }
}

// Namespace utility
// Params 0
// Checksum 0x6c883e6e, Offset: 0x7bc
// Size: 0x76
function do_stealth()
{
    if ( !isdefined( level.player.stealth ) )
    {
        init::set_stealth_mode( 1 );
    }
    
    switch ( self.team )
    {
        case #"hash_5f54b9bf7583687f":
            thread friendly::main();
            break;
        case #"hash_a571cacc018623b8":
            thread neutral::main();
            break;
        default:
            thread enemy::main();
            break;
    }
}

// Namespace utility
// Params 0
// Checksum 0xdd818e52, Offset: 0x83a
// Size: 0x110
function save_last_goal()
{
    if ( isdefined( self.stealth.last_goal ) )
    {
        return;
    }
    
    self.saved_script_forcegoal = self.script_forcegoal;
    
    if ( isdefined( self.patharray ) )
    {
        if ( self.patharrayindex == self.patharray.size - 1 )
        {
            index = self.patharrayindex;
        }
        else
        {
            index = self.patharrayindex + 1;
        }
        
        self.stealth.last_goal = self.patharray[ index ];
        self.stealth.last_start_node = self.patharraystartnode;
        return;
    }
    
    if ( isdefined( self.last_set_goalnode ) )
    {
        self.stealth.last_goal = self.last_set_goalnode;
        return;
    }
    
    if ( isdefined( self.last_set_goalent ) )
    {
        self.stealth.last_goal = self.last_set_goalent;
    }
}

/#

    // Namespace utility
    // Params 1
    // Checksum 0xece3e845, Offset: 0x952
    // Size: 0x19, Type: dev
    function set_patrol_move_loop_anim( animoverride )
    {
        assertmsg( "<dev string:xea>" );
    }

#/

// Namespace utility
// Params 4
// Checksum 0xcbd57b9d, Offset: 0x973
// Size: 0x57
function set_patrol_style( style, allowreact, reactposition, magnitude )
{
    switch ( style )
    {
        case #"hash_186d745a92c317d9":
            self.var_7a84781005a5b751 = 1;
            break;
    }
    
    self setpatrolstyle( style, allowreact, reactposition, magnitude );
}

// Namespace utility
// Params 0
// Checksum 0x8efe9372, Offset: 0x9d2
// Size: 0x1a
function get_patrol_style()
{
    assert( isdefined( self.stealth ) );
    return asm::asm_getdemeanor();
}

// Namespace utility
// Params 2
// Checksum 0x6b819f4b, Offset: 0x9f5
// Size: 0x1e
function set_patrol_react( position, magnitude )
{
    self setpatrolreact( position, magnitude );
}

// Namespace utility
// Params 0
// Checksum 0x9cafe7dd, Offset: 0xa1b
// Size: 0xae, Type: bool
function resume_previous_goal()
{
    if ( isdefined( self.fnstealthgotonode ) && isdefined( self.stealth.last_goal ) )
    {
        if ( isdefined( self.saved_script_forcegoal ) )
        {
            self.script_forcegoal = self.saved_script_forcegoal;
        }
        
        self thread [[ self.fnstealthgotonode ]]( self.stealth.last_goal, undefined, undefined, self.stealth.last_start_node );
        self.saved_script_forcegoal = undefined;
        self.stealth.last_goal = undefined;
        self.stealth.last_start_node = undefined;
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0xa976ae6, Offset: 0xad2
// Size: 0x9e
function is_visible( other )
{
    if ( isplayer( self ) )
    {
        if ( within_fov( self.origin, self.angles, other.origin, 0.766 ) )
        {
            if ( isdefined( other.tagging_visible ) || tagging_shield() )
            {
                return 1;
            }
            
            if ( utility_common::player_can_see_ai( self, other, 250 ) )
            {
                return 1;
            }
        }
    }
    else if ( self.team == other.team )
    {
        return self cansee( other, 300 );
    }
    else
    {
        return self cansee( other );
    }
    
    return 0;
}

// Namespace utility
// Params 0
// Checksum 0xf66015ae, Offset: 0xb79
// Size: 0x23, Type: bool
function tagging_shield()
{
    return isdefined( self.offhandshield ) && self.offhandshield.active;
}

// Namespace utility
// Params 1
// Checksum 0x7a695937, Offset: 0xba5
// Size: 0x48
function setbattlechatter( state )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnsetbattlechatter ) )
    {
        return [[ level.stealth.fnsetbattlechatter ]]( state );
    }
}

// Namespace utility
// Params 6
// Checksum 0xcdb66777, Offset: 0xbf5
// Size: 0x7b
function addeventplaybcs( eventaction, eventtype, modifier, delay, eventstruct, force )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnaddeventplaybcs ) )
    {
        return [[ level.stealth.fnaddeventplaybcs ]]( eventaction, eventtype, modifier, delay, eventstruct, force );
    }
}

// Namespace utility
// Params 6
// Checksum 0x44a8dd0c, Offset: 0xc78
// Size: 0x7b
function animgenericcustomanimmode( guy, custom_animmode, anime, tag, thread_func, skip_start_pos )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnanimgenericcustomanimmode ) )
    {
        return [[ level.stealth.fnanimgenericcustomanimmode ]]( guy, custom_animmode, anime, tag, thread_func, skip_start_pos );
    }
}

// Namespace utility
// Params 2
// Checksum 0x8d1c9fe3, Offset: 0xcfb
// Size: 0x170
function stealth_music( musichidden, musicspotted )
{
    self notify( #"stealth_music" );
    self endon( #"stealth_music" );
    thread stealth_music_pause_monitor();
    
    while ( true )
    {
        flag_wait( "stealth_enabled" );
        flag_waitopen( "stealth_spotted" );
        flag_waitopen( "stealth_music_pause" );
        function_d5f9ab800a1a548d();
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musichidden );
        }
        
        flag_wait( "stealth_spotted" );
        flag_waitopen( "stealth_music_pause" );
        function_7edd90d21374b690();
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musicspotted );
        }
    }
}

// Namespace utility
// Params 0
// Checksum 0xdb0865ff, Offset: 0xe73
// Size: 0x3b
function function_7edd90d21374b690()
{
    if ( isdefined( level.var_e2995d76ab488bc7 ) )
    {
        wait level.var_e2995d76ab488bc7;
    }
    
    if ( getdvarint( @"hash_5cf56ca298c06c21", 0 ) != 0 )
    {
        wait getdvarint( @"hash_5cf56ca298c06c21", 0 );
    }
}

// Namespace utility
// Params 0
// Checksum 0xb2b85e33, Offset: 0xeb6
// Size: 0x3b
function function_d5f9ab800a1a548d()
{
    if ( isdefined( level.var_32c18ad622cb0062 ) )
    {
        wait level.var_32c18ad622cb0062;
    }
    
    if ( getdvarint( @"hash_9a92f5b582657d72", 0 ) != 0 )
    {
        wait getdvarint( @"hash_9a92f5b582657d72", 0 );
    }
}

// Namespace utility
// Params 0
// Checksum 0x866d0c29, Offset: 0xef9
// Size: 0x94
function stealth_music_stop()
{
    self notify( #"stealth_music" );
    self notify( #"stealth_music_pause_monitor" );
    
    foreach ( player in level.players )
    {
        player thread stealth_music_transition( undefined );
    }
}

// Namespace utility
// Params 2
// Checksum 0x47ce4c5f, Offset: 0xf95
// Size: 0x1b8
function stealth_music_pause_monitor( musichidden, musicspotted )
{
    self notify( #"stealth_music_pause_monitor" );
    self endon( #"stealth_music_pause_monitor" );
    
    while ( true )
    {
        flag_wait( "stealth_music_pause" );
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( undefined );
        }
        
        flag_waitopen( "stealth_music_pause" );
        
        if ( flag( "stealth_spotted" ) )
        {
            foreach ( player in level.players )
            {
                player thread stealth_music_transition( musicspotted );
            }
            
            continue;
        }
        
        foreach ( player in level.players )
        {
            player thread stealth_music_transition( musichidden );
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x74d565d9, Offset: 0x1155
// Size: 0x27
function stealth_music_transition( aliasto )
{
    if ( isdefined( self.fnstealthmusictransition ) )
    {
        return [[ self.fnstealthmusictransition ]]( aliasto );
    }
}

// Namespace utility
// Params 0
// Checksum 0xd7636df9, Offset: 0x1184
// Size: 0x1b
function update_light_meter()
{
    if ( isdefined( self.fnupdatelightmeter ) )
    {
        return [[ self.fnupdatelightmeter ]]();
    }
}

// Namespace utility
// Params 1
// Checksum 0x1a879d76, Offset: 0x11a7
// Size: 0x128
function enable_stealth_for_ai( enabled )
{
    if ( !enabled )
    {
        self.maxvisibledist = 8192;
        
        if ( ent_flag_exist( "stealth_enabled" ) && ent_flag( "stealth_enabled" ) && self.team == "axis" )
        {
            dummyevent = spawnstruct();
            dummyevent.origin = level.player.origin;
            dummyevent.investigate_point = level.player.origin;
            dummyevent.investigate_pos = level.player.origin;
            dummyevent.type = "combat";
            dummyevent.typeorig = "attack";
            self.dontevershoot = 0;
            self.dontattackme = 0;
            enemy::bt_event_combat( dummyevent );
        }
    }
    
    if ( ent_flag_exist( "stealth_enabled" ) )
    {
        if ( enabled )
        {
            ent_flag_set( "stealth_enabled" );
            return;
        }
        
        ent_flag_clear( "stealth_enabled" );
    }
}

// Namespace utility
// Params 1
// Checksum 0x8293614, Offset: 0x12d7
// Size: 0x68
function custom_state_functions( array )
{
    assert( !isdefined( self.stealth ), "<dev string:x10c>" );
    
    if ( isdefined( array[ "spotted" ] ) )
    {
        self.stealth_state_func[ "spotted" ] = array[ "spotted" ];
    }
    
    if ( isdefined( array[ "hidden" ] ) )
    {
        self.stealth_state_func[ "hidden" ] = array[ "hidden" ];
    }
}

// Namespace utility
// Params 2
// Checksum 0xd16cb2f6, Offset: 0x1347
// Size: 0x3e
function set_stealth_func( type, func )
{
    self.stealth.funcs[ type ] = func;
    
    if ( isai( self ) )
    {
        self setstealthfunction( type, func );
    }
}

// Namespace utility
// Params 2
// Checksum 0x12b207ca, Offset: 0x138d
// Size: 0x78
function function_64b04fdefb6e65b5( eventtype, funcoverride )
{
    if ( isdefined( eventtype ) && isdefined( self.stealth ) && isdefined( self.stealth.funcs ) )
    {
        self.stealth.funcs[ "should_ignore_" + eventtype ] = funcoverride;
        
        if ( isai( self ) )
        {
            function_9acf7a20a30174b9( eventtype, self );
            return;
        }
        
        function_9acf7a20a30174b9( eventtype );
    }
}

// Namespace utility
// Params 2
// Checksum 0xc4670eec, Offset: 0x140d
// Size: 0x5e
function function_687d8d65c40a5f86( eventtype, funcfinish )
{
    if ( isdefined( eventtype ) && isdefined( self.stealth ) && isdefined( self.stealth.funcs ) )
    {
        self.stealth.funcs[ "finish_" + eventtype ] = funcfinish;
    }
}

// Namespace utility
// Params 0
// Checksum 0x8749232d, Offset: 0x1473
// Size: 0x40, Type: bool
function bcisincombat()
{
    self endon( #"death" );
    
    if ( isdefined( self.fnisinstealthcombat ) && self [[ self.fnisinstealthcombat ]]() )
    {
        return true;
    }
    
    if ( !isdefined( self.stealth ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0xbde0c407, Offset: 0x14bc
// Size: 0x4, Type: bool
function _autosave_stealthcheck()
{
    return true;
}

// Namespace utility
// Params 0
// Checksum 0xde58281d, Offset: 0x14c9
// Size: 0x30
function get_player_drone()
{
    if ( isdefined( level.stealth.fngetplayerdrone ) )
    {
        return [[ level.stealth.fngetplayerdrone ]]( self );
    }
}

// Namespace utility
// Params 2
// Checksum 0x150b3bf, Offset: 0x1501
// Size: 0x107, Type: bool
function function_fd44d9723f2344f9( ai_array, state )
{
    foreach ( ai in ai_array )
    {
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        switch ( state )
        {
            case 0:
                if ( ai is_idling() )
                {
                    return true;
                }
                
                break;
            case 1:
                if ( ai is_investigating() )
                {
                    return true;
                }
                
                break;
            case 2:
                if ( ai is_hunting() )
                {
                    return true;
                }
                
                break;
            case 3:
                if ( ai function_4d40994d0dcca395() )
                {
                    return true;
                }
                
                break;
        }
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0x7361e8ca, Offset: 0x1611
// Size: 0x1e
function is_idling()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthidle ]]();
}

// Namespace utility
// Params 0
// Checksum 0x8e7b8909, Offset: 0x1638
// Size: 0x1e
function is_investigating()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthinvestigate ]]();
}

// Namespace utility
// Params 0
// Checksum 0xf734d6e1, Offset: 0x165f
// Size: 0x1e
function is_hunting()
{
    if ( !isdefined( self.stealth ) )
    {
        return 0;
    }
    
    return self [[ self.fnisinstealthhunt ]]();
}

// Namespace utility
// Params 0
// Checksum 0x5a2598cc, Offset: 0x1686
// Size: 0x1f
function function_4d40994d0dcca395()
{
    if ( !isdefined( self.stealth ) )
    {
        return 1;
    }
    
    return self [[ self.fnisinstealthcombat ]]();
}

// Namespace utility
// Params 2
// Checksum 0xa238d475, Offset: 0x16ae
// Size: 0x34
function function_227c1c2c6c7ebd6a( state, event )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    self [[ self.fnsetstealthstate ]]( state, event );
}

// Namespace utility
// Params 2
// Checksum 0xc2ffb369, Offset: 0x16ea
// Size: 0xe7
function function_a5691d86c41d07b6( filter_func, severity )
{
    all_states = 0;
    
    if ( !isdefined( severity ) )
    {
        severity = [ "all" ];
        all_states = 1;
    }
    
    if ( !isarray( severity ) )
    {
        severity = [ severity ];
    }
    
    if ( !all_states )
    {
        all_states = arraycontains( severity, "all" );
    }
    
    if ( all_states || arraycontains( severity, "investigate" ) )
    {
        function_64b04fdefb6e65b5( "investigate", filter_func );
    }
    
    if ( all_states || arraycontains( severity, "cover_blown" ) )
    {
        function_64b04fdefb6e65b5( "cover_blown", filter_func );
    }
    
    if ( all_states || arraycontains( severity, "combat" ) )
    {
        function_64b04fdefb6e65b5( "combat", filter_func );
    }
    
    if ( all_states || arraycontains( severity, "curious" ) )
    {
        function_64b04fdefb6e65b5( "curious", filter_func );
    }
}

// Namespace utility
// Params 0
// Checksum 0x86597493, Offset: 0x17d9
// Size: 0x87
function get_broadcast_damage_auto_range()
{
    range = level.stealth.damage_auto_range;
    
    if ( isdefined( self.stealth.override_damage_auto_range ) )
    {
        range = self.stealth.override_damage_auto_range;
    }
    else if ( isdefined( level.stealth.override_damage_auto_range ) )
    {
        range = level.stealth.override_damage_auto_range;
    }
    
    if ( !isdefined( range ) )
    {
        range = 240;
    }
    
    return range;
}

// Namespace utility
// Params 0
// Checksum 0x3f6c82ea, Offset: 0x1869
// Size: 0x88
function get_broadcast_damage_sight_range()
{
    range = level.stealth.damage_sight_range;
    
    if ( isdefined( self.stealth.override_damage_sight_range ) )
    {
        range = self.stealth.override_damage_sight_range;
    }
    else if ( isdefined( level.stealth.override_damage_sight_range ) )
    {
        range = level.stealth.override_damage_sight_range;
    }
    
    if ( !isdefined( range ) )
    {
        range = 750;
    }
    
    return range;
}

// Namespace utility
// Params 0
// Checksum 0x2695cf62, Offset: 0x18fa
// Size: 0x88
function function_ac3486ad5117f239()
{
    range = level.stealth.var_4819c1af33f93f1e;
    
    if ( isdefined( self.stealth.var_cb5942db012d8899 ) )
    {
        range = self.stealth.var_cb5942db012d8899;
    }
    else if ( isdefined( level.stealth.var_cb5942db012d8899 ) )
    {
        range = level.stealth.var_cb5942db012d8899;
    }
    
    if ( !isdefined( range ) )
    {
        range = 1200;
    }
    
    return range;
}

// Namespace utility
// Params 4
// Checksum 0x8713f3e3, Offset: 0x198b
// Size: 0x78
function function_29f489d90abd76e4( eventtype, other, type, isperipheral )
{
    if ( !( isdefined( self ) && isdefined( self.stealth ) ) )
    {
        return;
    }
    
    rangeauto = get_broadcast_damage_auto_range();
    rangesight = get_broadcast_damage_sight_range();
    
    if ( isperipheral )
    {
        rangesight = function_ac3486ad5117f239();
    }
    
    stealtheventbroadcast( eventtype, self, other, rangeauto, rangesight, type );
}

