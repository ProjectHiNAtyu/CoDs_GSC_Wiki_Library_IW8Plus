// scripts\mp\br\gametypes\br_map_quest.gsc  (hash_3bedf5e032fdac85.gscc) (size: 7818 Bytes / 0x1e8a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7817e21e (2014831134)
// size ...... 7818 (0x1e8a)
// includes .. 6   (offset: 0x1bf2)
// strings ... 22  (offset: 0x1c22)
// dev strs .. 21  (offset: 0x1d66)
// exports ... 27  (offset: 0x1156)
// cseg ...... 0x1f8 + 0xf5e (0x1156)
// imports ... 52  (offset: 0x158e)
// animtree1 . 0   (offset: 0x1e8a)
// animtree2 . 0   (offset: 0x1e8a)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\rejoin_utility;

#namespace br_map_quest;

// Namespace br_map_quest
// Params 0, eflags: 0x5
// Checksum 0x45b60b46, Offset: 0x216
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_map_quest", undefined, &pre_main, &post_main );
}

// Namespace br_map_quest
// Params 0, eflags: 0x4
// Checksum 0x89835994, Offset: 0x23b
// Size: 0x7b
function private pre_main()
{
    if ( !isdefined( level.br_map_quest ) )
    {
        level.br_map_quest = {};
    }
    
    if ( !isdefined( level.br_map_quest.quests ) )
    {
        level.br_map_quest.quests = [];
    }
    
    level.br_map_quest.enabled = utility::function_edc4cc03e9e60b3e( @"scr_br_map_quest_enabled", 1, level.gametypebundle.var_38c6187f2a0545b7 );
}

// Namespace br_map_quest
// Params 0, eflags: 0x4
// Checksum 0x7e07a4aa, Offset: 0x2be
// Size: 0xa4
function private post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( level.br_map_quest.quests.size == 0 )
    {
        return;
    }
    
    level thread state_watcher();
    
    if ( is_system_disabled() )
    {
        return;
    }
    
    callback::add( #"game_ended", &on_game_ended );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"player_death", &on_player_death );
    rejoin_utility::function_70467cdf042579e5( &on_player_rejoin );
}

// Namespace br_map_quest
// Params 1
// Checksum 0x676ba10, Offset: 0x36a
// Size: 0x144
function register( quest )
{
    assert( isdefined( quest ) );
    
    if ( !isstring( quest.name ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x34>" );
        return;
    }
    
    if ( !isfunction( quest.on_init ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x6b>" + quest.name + "<dev string:x72>" );
        return;
    }
    
    if ( !isdefined( level.br_map_quest ) )
    {
        level.br_map_quest = {};
    }
    
    if ( !isdefined( level.br_map_quest.quests ) )
    {
        level.br_map_quest.quests = [];
    }
    
    quest.is_enabled = getdvarint( hashcat( @"hash_f7f04738de3ddc40", quest.name + "_" + "enabled" ), 1 );
    quest.is_completed = 0;
    quest.is_successful = 0;
    quest.completed_by = [];
    quest.settings = [];
    level.br_map_quest.quests[ quest.name ] = quest;
}

// Namespace br_map_quest
// Params 2
// Checksum 0xc1e0a763, Offset: 0x4b6
// Size: 0x167
function add_setting( setting, default_value )
{
    assert( isdefined( setting ) && isdefined( default_value ), "<dev string:xa1>" + "<dev string:xbb>" );
    assert( !( isdefined( self.settings[ setting ] ) && isdefined( "<dev string:xa1>" + "<dev string:xe1>" + setting + "<dev string:xeb>" ) ) );
    value = undefined;
    
    if ( isstring( default_value ) )
    {
        value = getdvar( hashcat( @"hash_f7f04738de3ddc40", self.name + "_" + setting ), default_value );
    }
    else if ( isint( default_value ) )
    {
        value = getdvarint( hashcat( @"hash_f7f04738de3ddc40", self.name + "_" + setting ), default_value );
    }
    else if ( isfloat( default_value ) )
    {
        value = getdvarfloat( hashcat( @"hash_f7f04738de3ddc40", self.name + "_" + setting ), default_value );
    }
    else if ( isvector( default_value ) )
    {
        value = getdvarvector( hashcat( @"hash_f7f04738de3ddc40", self.name + "_" + setting ), default_value );
    }
    
    if ( !isdefined( value ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:xfc>" + default_value + "<dev string:x11e>" );
        return;
    }
    
    self.settings[ setting ] = value;
}

// Namespace br_map_quest
// Params 1
// Checksum 0xcc1a78cd, Offset: 0x625
// Size: 0x4f, Type: bool
function get_setting( setting )
{
    assert( isdefined( self.settings[ setting ] ), "<dev string:x131>" + self.name + "<dev string:x146>" + setting + "<dev string:x151>" );
    return self.settings[ setting ] ?? undefined;
}

// Namespace br_map_quest
// Params 0
// Checksum 0x4e07971, Offset: 0x67d
// Size: 0x23, Type: bool
function is_system_disabled()
{
    return !level.br_map_quest.enabled || level.var_309e3d9dac389de6;
}

// Namespace br_map_quest
// Params 0, eflags: 0x4
// Checksum 0x4090016b, Offset: 0x6a9
// Size: 0x109
function private state_watcher()
{
    level endon( #"game_ended" );
    
    if ( !is_system_disabled() )
    {
        execute( "precache" );
    }
    
    utility::flag_wait( "create_script_initialized" );
    
    if ( is_system_disabled() )
    {
        utility::flag_wait( "onStartGameTypeFinished" );
        execute( "bmq_disabled" );
        level.br_map_quest = undefined;
        return;
    }
    
    execute( "init" );
    utility::flag_wait( "onStartGameTypeFinished" );
    execute( "prematch_started" );
    
    while ( true )
    {
        msg = level utility::waittill_any_return( "prematch_done", "prematch_fade_done", "infil_animatic_complete", "br_ready_to_jump" );
        
        if ( isdefined( msg ) )
        {
            if ( msg == "prematch_done" )
            {
                continue;
            }
            
            /#
                if ( level.br_infils_disabled && msg == "<dev string:x168>" )
                {
                    msg = "<dev string:x179>";
                }
            #/
            
            execute( msg );
            
            if ( msg == "infil_animatic_complete" )
            {
                br_circle::registercirclecallbacks( 18, undefined, &function_1afbf0bb0015ade8 );
                return;
            }
        }
    }
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0x26359aba, Offset: 0x7ba
// Size: 0x15b
function private execute( state )
{
    master_state = state;
    system_disabled = is_system_disabled();
    
    foreach ( key, quest in level.br_map_quest.quests )
    {
        if ( state == "init" && !quest.is_enabled )
        {
            state = "bmq_disabled";
        }
        else
        {
            state = master_state;
        }
        
        if ( state != "bmq_disabled" && !quest.is_enabled )
        {
            continue;
        }
        
        func = get_quest_func( quest, state );
        
        if ( !quest.is_completed && isfunction( func ) )
        {
            if ( state == "bmq_disabled" && !system_disabled )
            {
                quest thread function_d06781b9f8dda78f( func );
            }
            else
            {
                profilestart();
                quest [[ func ]]();
                profilestop();
            }
        }
        
        println( "<dev string:x24>" + "<dev string:x191>" + key + "<dev string:x19f>" + state );
    }
}

// Namespace br_map_quest
// Params 2, eflags: 0x4
// Checksum 0x4276ddbd, Offset: 0x91d
// Size: 0x11c
function private get_quest_func( quest, state )
{
    switch ( state )
    {
        case #"hash_658c924e81437bd3":
            return quest.on_init;
        case #"hash_7de1b0a4ac44da44":
            return quest.on_precache;
        case #"hash_6070cfe1a7230efd":
            return quest.on_start;
        case #"hash_cf939cfe79a5c027":
            return quest.on_prematch_end;
        case #"hash_7ac381ef66a87050":
            return quest.on_infil;
        case #"hash_9ce50f01b8206d24":
            return quest.on_disabled;
        case #"hash_3b247e63b885f221":
            return quest.on_player_connect;
        case #"hash_12ed06ef7e132d3":
            return quest.on_player_disconnect;
        case #"hash_8c210d1f8f0d7928":
            return quest.on_player_rejoin;
        case #"hash_3bdc47f2a9a60e34":
            return quest.on_game_ended;
        default:
            return;
    }
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0xf7b5dba9, Offset: 0xa41
// Size: 0x3d
function private function_d06781b9f8dda78f( func )
{
    utility::flag_wait( "onStartGameTypeFinished" );
    profilestart();
    self [[ func ]]();
    profilestop();
    level.br_map_quest.quests[ self.name ] = undefined;
}

// Namespace br_map_quest
// Params 1
// Checksum 0x896421af, Offset: 0xa86
// Size: 0x18
function on_game_ended( params )
{
    handle_state( "game_ended" );
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0x8dd268e, Offset: 0xaa6
// Size: 0x18
function private on_player_connect( params )
{
    handle_state( "player_connect" );
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0x507968a5, Offset: 0xac6
// Size: 0x18
function private on_player_disconnect( params )
{
    function_a1d138681434c722( "player_disconnect" );
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0x176fcc9, Offset: 0xae6
// Size: 0x31
function private on_player_death( params )
{
    player = params.victim;
    player function_a1d138681434c722( "player_death" );
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0x5d004d69, Offset: 0xb1f
// Size: 0x1a
function private on_player_rejoin( player )
{
    player function_a1d138681434c722( "player_rejoin" );
}

// Namespace br_map_quest
// Params 1
// Checksum 0xa3b52e9b, Offset: 0xb41
// Size: 0xdf
function handle_state( state )
{
    foreach ( questname, quest in level.br_map_quest.quests )
    {
        if ( !quest.is_enabled )
        {
            continue;
        }
        
        func = get_quest_func( quest, state );
        
        if ( !isfunction( func ) )
        {
            continue;
        }
        
        profilestart();
        quest [[ func ]]();
        profilestop();
        println( "<dev string:x24>" + "<dev string:x1aa>" + state + "<dev string:x1bc>" + questname );
    }
}

// Namespace br_map_quest
// Params 1
// Checksum 0x49341fa5, Offset: 0xc28
// Size: 0xdf
function function_a1d138681434c722( state )
{
    foreach ( questname, quest in level.br_map_quest.quests )
    {
        if ( !quest.is_enabled )
        {
            continue;
        }
        
        func = get_quest_func( quest, state );
        
        if ( !isfunction( func ) )
        {
            continue;
        }
        
        profilestart();
        self [[ func ]]();
        profilestop();
        println( "<dev string:x24>" + "<dev string:x1aa>" + state + "<dev string:x1bc>" + questname );
    }
}

// Namespace br_map_quest
// Params 0
// Checksum 0x39793213, Offset: 0xd0f
// Size: 0xb3
function function_1afbf0bb0015ade8()
{
    foreach ( quest in level.br_map_quest.quests )
    {
        if ( !quest.is_enabled )
        {
            continue;
        }
        
        if ( !isdefined( quest.on_circle_tick ) )
        {
            continue;
        }
        
        profilestart();
        quest [[ quest.on_circle_tick ]]();
        profilestop();
    }
}

// Namespace br_map_quest
// Params 1
// Checksum 0xb5708ad3, Offset: 0xdca
// Size: 0x131
function on_completed( params )
{
    level endon( #"game_ended" );
    quest = self;
    quest.is_completed = 1;
    quest.is_successful = params.is_successful;
    quest.completed_by = params.completed_by;
    function_d488650900a18b71( quest.name, params.is_successful );
    
    if ( params.is_successful )
    {
        foreach ( player in params.completed_by )
        {
            player thread function_b9a448679daeb22f( quest.name );
        }
    }
    
    level notify( "map_quest_completed_" + quest.name );
    quest notify( #"quest_completed" );
}

// Namespace br_map_quest
// Params 2
// Checksum 0x6d8ea5ac, Offset: 0xf03
// Size: 0x75, Type: bool
function is_registered( name, is_enabled = 0 )
{
    if ( is_enabled )
    {
        return ( isdefined( level.br_map_quest.quests[ name ] ) && level.br_map_quest.quests[ name ].is_enabled );
    }
    
    return isdefined( level.br_map_quest.quests[ name ] );
}

// Namespace br_map_quest
// Params 1
// Checksum 0xbc6ec01e, Offset: 0xf81
// Size: 0x40
function get_quest( name )
{
    assert( is_registered( name ), "<dev string:x24>" + "<dev string:x1c9>" + name );
    return level.br_map_quest.quests[ name ];
}

// Namespace br_map_quest
// Params 1, eflags: 0x4
// Checksum 0xf50e7302, Offset: 0xfca
// Size: 0x7d
function private function_b9a448679daeb22f( quest_ref )
{
    challenge = undefined;
    
    if ( utility::issharedfuncdefined( #"br_map_quest", #"get_challenge_prefix" ) )
    {
        challenge = [[ utility::getsharedfunc( #"br_map_quest", #"get_challenge_prefix" ) ]]();
    }
    else
    {
        println( "<dev string:x24>" + "<dev string:x1fd>" );
        return;
    }
    
    if ( !isdefined( challenge ) )
    {
        return;
    }
    
    challenges::function_37e945722d6497f3( self, challenge + quest_ref, 1 );
}

// Namespace br_map_quest
// Params 2, eflags: 0x4
// Checksum 0xca8172e5, Offset: 0x104f
// Size: 0x3e
function private function_d488650900a18b71( quest_ref, is_successful )
{
    dlog_recordevent( "dlog_event_br_quest_completed", [ "quest_name", quest_ref, "is_successful", is_successful ] );
}

// Namespace br_map_quest
// Params 2
// Checksum 0xd495d609, Offset: 0x1095
// Size: 0x50
function record_dlog( key, data )
{
    assert( isstring( key ) );
    assert( isarray( data ) );
    dlog_recordevent( "dlog_event_br_map_quest_" + self.name + "_" + key, data );
}

// Namespace br_map_quest
// Params 3
// Checksum 0xf10d3ec6, Offset: 0x10ed
// Size: 0x69
function function_bcff1e4dd70594f4( player, key, data )
{
    assert( isplayer( player ) );
    assert( isstring( key ) );
    assert( isarray( data ) );
    player dlog_recordplayerevent( "dlog_event_br_map_quest_" + self.name + "_" + key, data );
}

