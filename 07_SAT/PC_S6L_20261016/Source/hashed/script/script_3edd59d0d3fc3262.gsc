// script_3edd59d0d3fc3262  (hash_3edd59d0d3fc3262.gscc) (size: 23794 Bytes / 0x5cf2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3dfb179 (3286217081)
// size ...... 23794 (0x5cf2)
// includes .. 20  (offset: 0x5792)
// strings ... 57  (offset: 0x5832)
// dev strs .. 26  (offset: 0x5b7a)
// exports ... 48  (offset: 0x3e7a)
// cseg ...... 0x6f9 + 0x3781 (0x3e7a)
// imports ... 138 (offset: 0x45fa)
// animtree1 . 0   (offset: 0x5cf2)
// animtree2 . 0   (offset: 0x5cf2)
#using script_16ea1b94f0f381b3;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\systems\ob_analytics;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\outofbounds;

#namespace story_contract_util;

// Namespace story_contract_util
// Params 0, eflags: 0x5
// Checksum 0xd8134ee3, Offset: 0x717
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_4891e11600f66bca", undefined, &pre_main_init, undefined );
}

// Namespace story_contract_util
// Params 2
// Checksum 0x1db0df55, Offset: 0x738
// Size: 0x77, Type: bool
function is_active( player, key )
{
    if ( level.var_b47d8c82aca9768f == #"hash_fb9c944f270b2e6d" )
    {
        return true;
    }
    
    index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
        return false;
    }
    
    return index == player.var_f8d7f497f4294257;
}

// Namespace story_contract_util
// Params 2
// Checksum 0x7d40e9af, Offset: 0x7b8
// Size: 0xb3
function waittill_active( player, key )
{
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "ob_story_progression_initialized" );
    mission_index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( mission_index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
        return;
    }
    
    if ( mission_index == player.var_f8d7f497f4294257 )
    {
        return;
    }
    
    while ( true )
    {
        player waittill( #"hash_aaddcb9b5adcf263" );
        
        if ( mission_index == player.var_f8d7f497f4294257 )
        {
            level notify( #"hash_5989b28086833c90", player, key );
            return;
        }
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0x2351efc7, Offset: 0x873
// Size: 0xa4
function waittill_not_active( player, key )
{
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "ob_story_progression_initialized" );
    mission_index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( mission_index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
        return;
    }
    
    if ( mission_index != player.var_f8d7f497f4294257 )
    {
        return;
    }
    
    while ( true )
    {
        player waittill( #"hash_aaddcb9b5adcf263" );
        
        if ( mission_index != player.var_f8d7f497f4294257 )
        {
            return;
        }
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0xc94db5e2, Offset: 0x91f
// Size: 0x10e
function function_800aae15896dfec6( players, key )
{
    mission_index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( mission_index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
        return;
    }
    
    foreach ( player in players )
    {
        if ( mission_index == player.var_f8d7f497f4294257 )
        {
            return;
        }
        
        childthread waittill_active( player, key );
    }
    
    while ( true )
    {
        level waittill( #"hash_5989b28086833c90", end_player, end_key );
        
        if ( end_key == key && arraycontains( players, end_player ) )
        {
            return;
        }
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0x716c3f51, Offset: 0xa35
// Size: 0x106
function mark_complete( players, key )
{
    if ( ob::nightmare() )
    {
        return;
    }
    
    foreach ( player in players )
    {
        ob_analytics::function_e543b14a44184994( player, level.var_28c4907db51eb251[ key ] );
    }
    
    foreach ( player in players )
    {
        thread complete_activity( player, key );
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0xa32e915a, Offset: 0xb43
// Size: 0x2d
function is_activity_completed( player, key )
{
    return player.var_4940624b8a6df73f[ level.var_28c4907db51eb251[ key ] ];
}

// Namespace story_contract_util
// Params 3
// Checksum 0x40d17d2b, Offset: 0xb79
// Size: 0x157
function achievement_activities( players, var_b321eb6cdb8168ba, activities )
{
    assert( isarray( players ) );
    assert( isstring( var_b321eb6cdb8168ba ) );
    assert( isarray( activities ) );
    assert( isxhash( activities[ 0 ] ) );
    
    foreach ( player in players )
    {
        anymissing = 0;
        
        foreach ( activity in activities )
        {
            if ( !is_activity_completed( player, activity ) )
            {
                anymissing = 1;
                break;
            }
        }
        
        if ( !anymissing )
        {
            player coop::achievement_simple( var_b321eb6cdb8168ba, 0 );
        }
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0x56d087e, Offset: 0xcd8
// Size: 0x150
function set_squad_respawn( var_51f85234a247fac6, percentcomplete )
{
    assert( !isdefined( percentcomplete ) || isfloat( percentcomplete ) && percentcomplete >= 0 && percentcomplete <= 1, "<dev string:x6a>" );
    
    if ( isstruct( self ) && isarray( self.players ) && level != self )
    {
        squad = self;
    }
    else if ( isplayer( self ) )
    {
        squad = teams::function_72b89edf6b47c40a( self );
    }
    
    assert( isdefined( squad.players ) );
    
    if ( isdefined( percentcomplete ) )
    {
        squad.percentcomplete = percentcomplete;
        
        foreach ( player in squad.players )
        {
            player setclientomnvar( "ui_ob_mission_complete_percentage", percentcomplete );
        }
    }
    
    if ( !isarray( var_51f85234a247fac6 ) )
    {
        var_51f85234a247fac6 = [ var_51f85234a247fac6 ];
    }
    
    squad.respawnlocations = var_51f85234a247fac6;
}

// Namespace story_contract_util
// Params 1
// Checksum 0xc8acf123, Offset: 0xe30
// Size: 0x43
function get_story_mission_index( key )
{
    index = level.var_28c4907db51eb251[ key ];
    assert( isdefined( index ), "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
    return index;
}

// Namespace story_contract_util
// Params 1
// Checksum 0xd1cda534, Offset: 0xe7c
// Size: 0x52
function get_story_mission( key )
{
    index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( key ) + "<dev string:x2f>" );
        return;
    }
    
    return level.var_a964e9285c1f8206[ index ];
}

// Namespace story_contract_util
// Params 1
// Checksum 0x783c975, Offset: 0xed7
// Size: 0x2b
function function_bee4742f2b373549( player )
{
    return level.var_a964e9285c1f8206[ player.var_f8d7f497f4294257 ].story_index;
}

// Namespace story_contract_util
// Params 1
// Checksum 0x7db776ce, Offset: 0xf0b
// Size: 0xd0
function function_d4e03884b38da3d8( player )
{
    var_950c5eed6692bff6 = function_35a4b91d1599df3e( player );
    
    if ( !var_950c5eed6692bff6.story_index )
    {
        return #"default";
    }
    
    switch ( var_950c5eed6692bff6.story_index )
    {
        case 1:
            return #"pisces";
        case 3:
            return #"sag";
        case 5:
            return #"aqua";
        case 7:
            return #"cancer";
        case 9:
            return #"taurus";
        default:
            return #"default";
    }
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0x33158e49, Offset: 0xfe3
// Size: 0x6c
function private function_7ed7b1f238c6cef5( player )
{
    if ( isplayer( player ) )
    {
        mission = function_35a4b91d1599df3e( player );
        
        if ( mission.var_49b170a15e7c980c )
        {
            return mission.var_49b170a15e7c980c;
        }
    }
    
    return level.mapinfobundle.var_3b3d5e9c999d96ec ?? level.mapinfobundle.var_27ceb9081ce7fe53;
}

// Namespace story_contract_util
// Params 1
// Checksum 0x35abd6d6, Offset: 0x1058
// Size: 0x32
function function_35a4b91d1599df3e( player )
{
    if ( !isdefined( player.var_f8d7f497f4294257 ) )
    {
        return;
    }
    
    return level.var_a964e9285c1f8206[ player.var_f8d7f497f4294257 ];
}

// Namespace story_contract_util
// Params 1
// Checksum 0xb1dd0cfa, Offset: 0x1093
// Size: 0x185
function function_79e2c58782bdf5b0( activity_instance )
{
    if ( activity_instance.origin )
    {
        return activity_instance.origin;
    }
    
    index = level.var_28c4907db51eb251[ activity_instance.key ];
    
    if ( !isdefined( index ) )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( activity_instance.key ) + "<dev string:x2f>" );
        return;
    }
    
    mission_info = level.var_a964e9285c1f8206[ index ];
    
    if ( mission_info.origin )
    {
        return mission_info.origin;
    }
    
    foreach ( instance in level.activities.instances )
    {
        if ( instance.type == activity_instance.type )
        {
            level.var_a964e9285c1f8206[ index ].origin = instance.activity_starter_scriptable.origin ?? instance.var_441d26d05f86b224;
            return level.var_a964e9285c1f8206[ index ].origin;
        }
    }
}

// Namespace story_contract_util
// Params 0, eflags: 0x4
// Checksum 0x320e8b15, Offset: 0x1221
// Size: 0x4d0
function private pre_main_init()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( !getdvarint( @"scr_ob_story_progression", 1 ) )
    {
        return;
    }
    
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( !var_bb86f77304f193c4.var_aab22481530ff9ff )
    {
        return;
    }
    
    gamemodebundle = getgamemodescriptbundle();
    
    if ( !isdefined( gamemodebundle.var_d45aa868ba2a098f ) )
    {
        throw( "Undefined story mission bundle list in the gamemodebundle." );
        return;
    }
    
    level.var_bc2eec43725b75d6 = &function_42d1f6223635e166;
    level.var_28c4907db51eb251 = [];
    level.var_a964e9285c1f8206 = [];
    story_mission_list = getscriptbundle( gamemodebundle.var_d45aa868ba2a098f );
    
    for ( i = 0; i < story_mission_list.missions.size ; i++ )
    {
        var_88b7196a457055a4 = getscriptbundlefieldvalues( story_mission_list.missions[ i ].bundle, [ #"storymissionindex", #"hash_2230bcc9c08122fc", #"hash_c1fc108450330ed3", #"hash_f2c824081115d1c9", #"hash_1d20eee01065301b", #"hash_b4c7cf39137753ab", #"hash_d22b08f577d15a0c", #"hash_a258b406147b6a15", #"hash_f63df655f856a851", #"difficulty", #"hash_fda6b2ce72c28dfe", #"consoleactivity", #"hash_51c13fd8177a23a9", #"hash_e4d815d2602c20b3", #"hash_341970b53742f783" ] );
        level.var_28c4907db51eb251[ var_88b7196a457055a4.var_a64305ba9e4c9692 ] = i;
        level.var_a964e9285c1f8206[ i ] = { #var_49b170a15e7c980c:var_88b7196a457055a4.var_49b170a15e7c980c, #consoleactivity:var_88b7196a457055a4.consoleactivity, #var_74c7ea22e06b62bd:var_88b7196a457055a4.var_74c7ea22e06b62bd, #difficulty:var_88b7196a457055a4.difficulty, #var_e9c5e4620b383360:var_88b7196a457055a4.var_e9c5e4620b383360, #startpoint:var_88b7196a457055a4.var_3b68476bfa6876c, #var_2561d23b3724c56c:var_88b7196a457055a4.var_c467f3a2ab2582d3, #frontend_playlist_id:var_88b7196a457055a4.var_9e6bd39b715948b4, #omnvar:var_88b7196a457055a4.var_8deebf6aed789fbc, #ddl_bit:var_88b7196a457055a4.var_37b63cc026bcd3a0, #key:var_88b7196a457055a4.var_a64305ba9e4c9692, #is_mission_start:var_88b7196a457055a4.var_e7e7a3d46948fbb6, #disabled:var_88b7196a457055a4.var_69b6319bf0fd5abb, #story_index:var_88b7196a457055a4.storymissionindex ?? 0 };
        
        if ( ( var_88b7196a457055a4.var_74c7ea22e06b62bd ?? "" ) == level.mapname && isdefined( var_88b7196a457055a4.consoleactivity ) )
        {
            level.var_8ff57499f0d46359 = var_88b7196a457055a4.consoleactivity;
        }
        
        if ( isdefined( var_88b7196a457055a4.var_5dac40fe5deb996c ) )
        {
            level.var_a964e9285c1f8206[ i ].ae_bit = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", var_88b7196a457055a4.var_5dac40fe5deb996c ) );
        }
    }
    
    level.var_d2aa03d29860d55a = ae_utility::function_8645a430dc4bffb9( #"wc_story_mission_complete" );
    level.var_d57f9997c6de5d73 = ae_utility::function_70b8bc68f3d8031e( #"wc_story_mission_complete", #"wc_story_mission_bitfield" );
    level.var_24e17a978b1a5055 = [];
    level.var_24e17a978b1a5055 = ae_utility::function_a05c01f371158a1b( level.var_24e17a978b1a5055, #"wc_story_mission_complete", #"version", 1 );
    level.var_24e17a978b1a5055 = ae_utility::function_a05c01f371158a1b( level.var_24e17a978b1a5055, #"wc_story_mission_complete", #"gamemode", challenges::getchallengegamemode() );
    level.var_d1e3e0e075671fee = &ob::ob_teleport_player_in_bounds;
    callback::add( #"hash_cc06eb1d45f33a0c", &function_c871dbbe5173d823 );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"hash_b8a09fa57f8824cf", &function_18723e2d41251a58 );
    utility::registersharedfunc( #"ob_story", #"get_active_mission_index", &function_bee4742f2b373549 );
    utility::registersharedfunc( #"ob_story", #"hash_fd82c3a7d29b9af2", &function_4fc53165dd87d362 );
    utility::registersharedfunc( #"coop", #"hash_4aaedbb78cff8174", &function_7ed7b1f238c6cef5 );
    thread debug_init();
}

// Namespace story_contract_util
// Params 2
// Checksum 0xd8ac67c, Offset: 0x16f9
// Size: 0x255
function function_cddb50034003950e( var_64bb57aa2d6e8b35, volumes = [] )
{
    if ( getdvarint( @"hash_42e5430894e3f3a8", 0 ) )
    {
        return;
    }
    
    level.ob_mission_oob_throttle = throttle::throttle_initialize( "ob_mission_oob", 1, level.framedurationseconds );
    
    while ( var_64bb57aa2d6e8b35.players.size > 0 )
    {
        throttle::throttle_wait_in_queue( level.ob_mission_oob_throttle, var_64bb57aa2d6e8b35 );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player.var_753b31fc1dd0e162 = 1;
            player.var_b9fa4a99c37080bb = volumes;
            
            if ( !isalive( player ) || player.sessionstate != "playing" || player.oob )
            {
                continue;
            }
            
            var_4b304bf3fada5b9b = player.var_546e4eb5269dbafa != player.assigned_difficulty;
            
            if ( !var_4b304bf3fada5b9b && volumes.size > 0 )
            {
                var_4b304bf3fada5b9b = 1;
                
                foreach ( volume in volumes )
                {
                    if ( ispointinvolume( player.origin, volume ) )
                    {
                        var_4b304bf3fada5b9b = 0;
                        break;
                    }
                }
            }
            
            if ( var_4b304bf3fada5b9b )
            {
                outofbounds::enableoob( player );
                childthread function_a7a8fa1253d86d0f( player, volumes );
                continue;
            }
            
            player.var_27fd0d2a449557bf = player.origin;
            player.var_755ed09478df002 = player getvelocity();
            
            if ( player.vehicle )
            {
                player.var_420a3b8802c6905e = player.vehicle vehicle_getvelocity();
            }
        }
    }
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0xaebf325c, Offset: 0x1956
// Size: 0x111
function private function_a7a8fa1253d86d0f( player, volumes )
{
    player endon( #"death_or_disconnect" );
    
    while ( isalive( player ) )
    {
        waitframe();
        
        if ( player.var_546e4eb5269dbafa != player.assigned_difficulty )
        {
            continue;
        }
        
        if ( volumes.size == 0 )
        {
            outofbounds::disableoob( player );
            player.oobtimeleft = undefined;
            player.oobendtime = undefined;
            return;
        }
        
        foreach ( volume in volumes )
        {
            if ( ispointinvolume( player.origin, volume ) )
            {
                outofbounds::disableoob( player );
                player.oobtimeleft = undefined;
                player.oobendtime = undefined;
                return;
            }
        }
    }
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0xd3a2e8b2, Offset: 0x1a6f
// Size: 0xb8
function private function_4fc53165dd87d362( point, player )
{
    if ( player.var_b9fa4a99c37080bb.size > 0 )
    {
        oob = 1;
        
        foreach ( volume in player.var_b9fa4a99c37080bb )
        {
            if ( ispointinvolume( point, volume ) )
            {
                oob = 0;
                break;
            }
        }
        
        return oob;
    }
    
    return 0;
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0x86670baf, Offset: 0x1b30
// Size: 0x49
function private get_console_activity_name( consoleactivity )
{
    if ( isdefined( level.var_8ff57499f0d46359 ) )
    {
        return level.var_8ff57499f0d46359;
    }
    else if ( !isstring( consoleactivity ) )
    {
        return level.var_a964e9285c1f8206[ consoleactivity ].consoleactivity;
    }
    
    return consoleactivity;
}

// Namespace story_contract_util
// Params 3, eflags: 0x4
// Checksum 0x523c9992, Offset: 0x1b82
// Size: 0xa3
function private function_8055a084ca7c0b5a( event, consoleactivity, result )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( player.var_2c41dfa30e790bd3 ) )
    {
        player.var_2c41dfa30e790bd3 = [];
    }
    
    eventdata = { #result:result, #consoleactivity:consoleactivity, #event:event };
    player.var_2c41dfa30e790bd3[ player.var_2c41dfa30e790bd3.size ] = eventdata;
    player thread function_8af684f4ef5ee8ef();
}

// Namespace story_contract_util
// Params 0, eflags: 0xc
// Checksum 0x467853f4, Offset: 0x1c2d
// Size: 0x172
function private function_8af684f4ef5ee8ef()
{
    self notify( #"hash_5aaf566b29b042a" );
    self endon( #"hash_5aaf566b29b042a" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( ob::nightmare() )
    {
        return;
    }
    
    player = self;
    player endon( #"disconnect" );
    waittillframeend();
    
    while ( isplayer( player ) && player.var_2c41dfa30e790bd3 && player.var_2c41dfa30e790bd3.size > 0 )
    {
        eventdata = player.var_2c41dfa30e790bd3[ 0 ];
        assert( isdefined( eventdata.event ) && isdefined( eventdata.consoleactivity ) );
        
        switch ( eventdata.event )
        {
            case #"hash_c6514c88e37149bf":
                startactivity( eventdata.consoleactivity, player );
                break;
            case #"hash_23d3b48a2fabf145":
                stopactivity( eventdata.consoleactivity, eventdata.result ?? "completed", player );
                break;
            default:
                assertmsg( "<dev string:xab>" + eventdata.event );
                break;
        }
        
        player.var_2c41dfa30e790bd3[ 0 ] = undefined;
        function_cdc669dbc8ea2101( player.var_2c41dfa30e790bd3 );
        waitframe();
    }
    
    if ( isplayer( player ) )
    {
        player.var_2c41dfa30e790bd3 = undefined;
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0x7ad812c6, Offset: 0x1da7
// Size: 0x88
function function_8b11db0fe2323bee( consoleactivity )
{
    assert( isplayer( self ) );
    player = self;
    consoleactivity = get_console_activity_name( consoleactivity );
    
    if ( isdefined( consoleactivity ) )
    {
        if ( player.consoleactivity && player.consoleactivity != consoleactivity )
        {
            player function_55a89609490d06a0( player.consoleactivity );
        }
        
        player.consoleactivity = consoleactivity;
        player function_8055a084ca7c0b5a( "start", consoleactivity );
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0x7529d4ba, Offset: 0x1e37
// Size: 0x87
function function_55a89609490d06a0( consoleactivity )
{
    assert( isplayer( self ) );
    player = self;
    consoleactivity = get_console_activity_name( consoleactivity );
    
    if ( isdefined( consoleactivity ) )
    {
        player function_8055a084ca7c0b5a( "stop", consoleactivity, "completed" );
        player.var_337ed0b3f96c123d[ consoleactivity ] = 1;
        
        if ( player.consoleactivity && player.consoleactivity == consoleactivity )
        {
            player.consoleactivity = undefined;
        }
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0x1fb9fb6d, Offset: 0x1ec6
// Size: 0x6e
function function_f253e939765d2e39( consoleactivity )
{
    assert( isplayer( self ) );
    player = self;
    consoleactivity = get_console_activity_name( consoleactivity );
    
    if ( isdefined( consoleactivity ) && !player.var_337ed0b3f96c123d[ consoleactivity ] && !player.var_773876ee6a382571 )
    {
        player function_8055a084ca7c0b5a( "stop", consoleactivity, "abandoned" );
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0x788932b4, Offset: 0x1f3c
// Size: 0x56
function function_18723e2d41251a58( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isstruct( params ) )
    {
        function_8b11db0fe2323bee( params.var_5b161a120d78723f );
    }
    
    relevantinfostruct = { #playerlist:[ self ] };
    activity_participation::function_14f790ff7844b38f( relevantinfostruct );
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0x2c269dd5, Offset: 0x1f9a
// Size: 0x2b
function private function_6f9ebd88300a7f15( player )
{
    wait 5;
    
    if ( player )
    {
        kick( player getentitynumber(), &"exe/playerkicked" );
    }
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0xa5acf749, Offset: 0x1fcd
// Size: 0x4e
function private function_adff3a8d58e8a337( objectiveindex )
{
    for ( i = 0; i < level.var_a964e9285c1f8206.size ; i++ )
    {
        if ( objectiveindex == level.var_a964e9285c1f8206[ i ].story_index )
        {
            return i;
        }
    }
    
    return 0;
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0xcb925549, Offset: 0x2024
// Size: 0x41, Type: bool
function private function_a17b5766135f22c2( activityindex )
{
    activity = level.var_a964e9285c1f8206[ activityindex ];
    return activity.is_mission_start && activity.frontend_playlist_id == 255;
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0x6da240f1, Offset: 0x206e
// Size: 0x726
function private function_c871dbbe5173d823( params )
{
    if ( self iscodcaster() || isai( self ) )
    {
        return;
    }
    
    self.var_f8d7f497f4294257 = 0;
    activeAvalonObjectiveIndex = self getplayerdata( level.var_6f9b00680ed002d8, "activeAvalonObjectiveIndex" );
    logstring( "[OB_STORY_PROGRESSION] Avalon Objective Index is [" + activeAvalonObjectiveIndex + "] for player [" + self.name + "]" );
    self.var_f8d7f497f4294257 = function_adff3a8d58e8a337( activeAvalonObjectiveIndex );
    logstring( "[OB_STORY_PROGRESSION] Initial active index at [" + self.var_f8d7f497f4294257 + "] for player [" + self.name + "]" );
    squad_leader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
    squad = params.squad;
    var_62171b31659924ac = 0;
    
    if ( isdefined( squad_leader.var_f8d7f497f4294257 ) && squad_leader != self && squad_leader.var_f8d7f497f4294257 != self.var_f8d7f497f4294257 )
    {
        self.var_f8d7f497f4294257 = squad_leader.var_f8d7f497f4294257;
        var_62171b31659924ac = 1;
        logstring( "[OB_STORY_PROGRESSION] Updated active index to [" + self.var_f8d7f497f4294257 + "] for player [" + self.name + "] since they did not match the squad leader." );
    }
    
    if ( !var_62171b31659924ac )
    {
        if ( !isdefined( squad.percentcomplete ) )
        {
            squad.percentcomplete = 0;
        }
        
        var_bb86f77304f193c4 = ob::get_ob_settings();
        
        if ( var_bb86f77304f193c4.var_49178f6e5c220274 && activeAvalonObjectiveIndex % 2 == 0 )
        {
            if ( getdvarint( @"hash_2c4c736ad43b6350", 1 ) )
            {
                self.var_f8d7f497f4294257 = self getplayerdata( level.var_6f9b00680ed002d8, "storyMissionActiveIndex" ) ?? 0;
                logstring( "[OB_STORY_PROGRESSION] activeAvalonObjectiveIndex was invalid for player [" + self.name + "] when joining avalon; attempting to use storyMissionActiveIndex [" + self.var_f8d7f497f4294257 + "]." );
                activityisvalid = function_a17b5766135f22c2( self.var_f8d7f497f4294257 );
                
                if ( !activityisvalid )
                {
                    logstring( "[OB_STORY_PROGRESSION] storyMissionActiveIndex was invalid [" + self.var_f8d7f497f4294257 + "] for player [" + self.name + "] when joining avalon." );
                    
                    if ( getdvarint( @"hash_ad9ed313290db25", 1 ) )
                    {
                        var_a5e7e9367561527b = isdedicatedserver() ? self function_57a5369ec687db6d() : "";
                        
                        if ( var_a5e7e9367561527b != "" )
                        {
                            var_1a6c4c70d6f7d60 = int( var_a5e7e9367561527b );
                            logstring( "[OB_STORY_PROGRESSION] Avalon Objective Index from MM is [" + var_1a6c4c70d6f7d60 + "] for player [" + self.name + "]" );
                            
                            if ( var_1a6c4c70d6f7d60 != 0 )
                            {
                                self.var_f8d7f497f4294257 = function_adff3a8d58e8a337( var_1a6c4c70d6f7d60 );
                                logstring( "[OB_STORY_PROGRESSION] activeAvalonObjectiveIndex was invalid for player [" + self.name + "] when joining avalon; attempting to use storyMissionActiveIndex [" + self.var_f8d7f497f4294257 + "] from matchmaker." );
                                activityisvalid = function_a17b5766135f22c2( self.var_f8d7f497f4294257 );
                            }
                            else
                            {
                                script::demoforcesre( "activeAvalonObjectiveIndexFromMM was invalid for an avalon mission" );
                            }
                        }
                        else if ( isdedicatedserver() )
                        {
                            script::demoforcesre( "activeAvalonObjectiveIndexFromMM was invalid for an avalon mission" );
                        }
                    }
                    else
                    {
                        script::demoforcesre( "storyMissionActiveIndex was invalid for an avalon mission" );
                    }
                }
                
                if ( !activityisvalid && getdvarint( @"hash_a697517b4b72aafa", 0 ) )
                {
                    script::demoforcesre( "No data source was able to provide a valid avalon mission" );
                    thread function_6f9ebd88300a7f15( self );
                    return;
                }
            }
            else
            {
                script::demoforcesre( "activeAvalonObjectiveIndex was invalid for an avalon mission" );
            }
        }
    }
    
    ob_analytics::function_83b221bbc39fca8( self, self.var_f8d7f497f4294257 );
    
    foreach ( index, info in level.var_a964e9285c1f8206 )
    {
        self.var_4940624b8a6df73f[ index ] = self getplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", info.ddl_bit );
        
        if ( is_active( self, info.key ) )
        {
            if ( info.var_e9c5e4620b383360 )
            {
                self.var_8c5067d0870248c8 = info.var_e9c5e4620b383360;
            }
            
            if ( isdefined( info.omnvar ) )
            {
                self setclientomnvar( info.omnvar, 1 );
            }
            
            self.assigned_difficulty = region_difficulty_manager::function_dc53171229eb2097( info.difficulty );
        }
    }
    
    utility::ent_flag_set( "ob_story_progression_initialized" );
    function_bd43e7421d15ad98( "Initial" );
    
    if ( level.var_b47d8c82aca9768f == #"hash_fb9c944f270b2e6d" )
    {
        foreach ( index, info in level.var_a964e9285c1f8206 )
        {
            if ( isdefined( info.omnvar ) )
            {
                self setclientomnvar( info.omnvar, 1 );
                self.assigned_difficulty = region_difficulty_manager::function_dc53171229eb2097( info.difficulty );
            }
        }
    }
    else if ( isdefined( level.var_b47d8c82aca9768f ) )
    {
        function_85445fa008951fd8( [ level.var_b47d8c82aca9768f, [ self ] ] );
        
        foreach ( index, info in level.var_a964e9285c1f8206 )
        {
            self.var_4940624b8a6df73f[ index ] = self getplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", info.ddl_bit );
            
            if ( isdefined( info.omnvar ) && is_active( self, info.key ) )
            {
                if ( info.var_e9c5e4620b383360 )
                {
                    self.var_8c5067d0870248c8 = info.var_e9c5e4620b383360;
                }
                
                self setclientomnvar( info.omnvar, 1 );
                self.assigned_difficulty = region_difficulty_manager::function_dc53171229eb2097( info.difficulty );
            }
        }
        
        function_bd43e7421d15ad98( "Override" );
    }
    else
    {
        callback::callback( #"hash_b8a09fa57f8824cf", { #var_5b161a120d78723f:self.var_f8d7f497f4294257, #old_index:undefined } );
        level notify( #"hash_b8a09fa57f8824cf", self );
        self notify( #"hash_aaddcb9b5adcf263" );
    }
    
    if ( self.var_8c5067d0870248c8 )
    {
        ob_story_mission_utils::function_9d7c461c00f2f588( self.var_8c5067d0870248c8, 1 );
    }
    
    if ( isdefined( squad.percentcomplete ) )
    {
        self setclientomnvar( "ui_ob_mission_complete_percentage", squad.percentcomplete );
    }
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0x5589cef8, Offset: 0x279c
// Size: 0x10d
function private function_bd43e7421d15ad98( stage, recalc = 1 )
{
    if ( getbuildversion() == "SHIP" )
    {
        return;
    }
    
    if ( recalc )
    {
        self.var_a3351dcec5085739 = "";
        
        for ( i = 0; i < level.var_a964e9285c1f8206.size ; i++ )
        {
            info = level.var_a964e9285c1f8206[ i ];
            
            if ( info.ddl_bit )
            {
                if ( self getplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", info.ddl_bit ) )
                {
                    self.var_a3351dcec5085739 += "1";
                    continue;
                }
                
                self.var_a3351dcec5085739 += "0";
            }
        }
    }
    
    logstring( "[OB_STORY_PROGRESSION] " + stage + " progression at [" + self.var_a3351dcec5085739 + "] for player [" + self.name + "]" );
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0xbd36aa2c, Offset: 0x28b1
// Size: 0x19
function private on_player_disconnect( params )
{
    function_bd43e7421d15ad98( "Final", 0 );
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0x1358b7ae, Offset: 0x28d2
// Size: 0x20, Type: bool
function private function_42d1f6223635e166( player, params )
{
    return is_active( player, params[ 0 ] );
}

// Namespace story_contract_util
// Params 3, eflags: 0x4
// Checksum 0xfaf686f3, Offset: 0x28fb
// Size: 0x21a
function private function_9e7b41fe021a293a( player, new_index, solo = 0 )
{
    squad_leader = squad_utility::getsquadleader( player.team, player.sessionsquadid ) ?? player;
    
    if ( !solo && player != squad_leader )
    {
        return;
    }
    
    var_538c0694c880e740 = solo ? [ player ] : player squad_utility::getsquadmembers( player.team, 0 );
    
    foreach ( var_8a958389218cbbb3 in var_538c0694c880e740 )
    {
        old_index = var_8a958389218cbbb3.var_f8d7f497f4294257;
        var_8a958389218cbbb3.var_f8d7f497f4294257 = new_index;
        var_8a958389218cbbb3 setplayerdata( level.var_6f9b00680ed002d8, "storyMissionActiveIndex", new_index );
        logstring( "[OB_STORY_PROGRESSION] Active index updated to [" + new_index + "] for player [" + var_8a958389218cbbb3.name + "]" );
        ob_analytics::function_83b221bbc39fca8( var_8a958389218cbbb3, var_8a958389218cbbb3.var_f8d7f497f4294257 );
        
        if ( isdefined( old_index ) )
        {
            omnvar = level.var_a964e9285c1f8206[ old_index ].omnvar;
            
            if ( isdefined( omnvar ) )
            {
                var_8a958389218cbbb3 setclientomnvar( omnvar, 0 );
            }
        }
        
        if ( new_index < level.var_a964e9285c1f8206.size )
        {
            omnvar = level.var_a964e9285c1f8206[ new_index ].omnvar;
            
            if ( isdefined( omnvar ) )
            {
                var_8a958389218cbbb3 setclientomnvar( omnvar, 1 );
            }
        }
        
        var_8a958389218cbbb3 callback::callback( #"hash_b8a09fa57f8824cf", { #var_5b161a120d78723f:new_index, #old_index:old_index } );
        level notify( #"hash_b8a09fa57f8824cf", var_8a958389218cbbb3 );
        var_8a958389218cbbb3 notify( #"hash_aaddcb9b5adcf263" );
    }
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0x62dddb22, Offset: 0x2b1d
// Size: 0x1af
function private complete_activity( player, key )
{
    player endon( #"disconnect" );
    index = level.var_28c4907db51eb251[ key ];
    
    if ( !isdefined( index ) )
    {
        assertmsg( "<dev string:x24>" + key + "<dev string:x2f>" );
        return 0;
    }
    
    activity_info = level.var_a964e9285c1f8206[ index ];
    
    if ( isdefined( activity_info.ae_bit ) )
    {
        var_a278d330d6ab2117 = arraycopy( level.var_24e17a978b1a5055, 1 );
        var_a278d330d6ab2117[ level.var_d57f9997c6de5d73 ] = activity_info.ae_bit;
        player function_2e45314624fdfdb8( level.var_d2aa03d29860d55a, var_a278d330d6ab2117 );
    }
    
    player.var_4940624b8a6df73f[ index ] = 1;
    
    for ( i = index + 1; i < level.var_a964e9285c1f8206.size ; i++ )
    {
        if ( level.var_a964e9285c1f8206[ i ].disabled )
        {
            player.var_4940624b8a6df73f[ i ] = 1;
            continue;
        }
        
        break;
    }
    
    function_9e7b41fe021a293a( player, index + 1 );
    
    if ( activity_info.ddl_bit )
    {
        logstring( "[OB_STORY_PROGRESSION] Saving completion progression of [" + activity_info.ddl_bit + "] for player [" + player.name + "]" );
        player setplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", activity_info.ddl_bit, 1 );
        waitframe();
        
        if ( player )
        {
            player function_432458e83a394206( 3 );
            player function_bd43e7421d15ad98( "Activity" );
        }
    }
}

// Namespace story_contract_util
// Params 2
// Checksum 0x7c756310, Offset: 0x2cd4
// Size: 0xb4
function spawn_bots_folded( var_bf05c3168959c2db, var_41efea2100d3418a )
{
    spawned_bots = [];
    
    foreach ( scene_struct in var_bf05c3168959c2db )
    {
        bot = function_8fe3b4d3a23f0b6( scene_struct );
        
        if ( bot )
        {
            bot thread activate_bot_folded( bot, var_41efea2100d3418a );
        }
        
        spawned_bots[ spawned_bots.size ] = bot;
    }
    
    return spawned_bots;
}

// Namespace story_contract_util
// Params 1, eflags: 0x4
// Checksum 0x28513019, Offset: 0x2d91
// Size: 0x98
function private function_8fe3b4d3a23f0b6( scene_struct )
{
    if ( !scene_struct )
    {
        return;
    }
    
    scene_struct scene::init();
    bot = scene_struct scene::get_entity( 0 );
    
    if ( !bot )
    {
        return;
    }
    
    scene_struct thread scene::play( undefined, "idle" );
    bot.team = "team_hundred_ninety";
    bot.spawn_struct = scene_struct;
    bot.var_24954f14e27b448d = 0;
    bot.ignoreme = 1;
    bot.ignoreall = 1;
    bot disableaimassist();
    return bot;
}

// Namespace story_contract_util
// Params 2, eflags: 0x4
// Checksum 0x2116532d, Offset: 0x2e32
// Size: 0xf8
function private activate_bot_folded( bot, var_41efea2100d3418a )
{
    bot waittill( var_41efea2100d3418a );
    var_d2dea1eb5c269d79 = randomfloatrange( 0.1, 0.9 );
    wait var_d2dea1eb5c269d79;
    var_a0a354b856fd69e = bot.spawn_struct.script_noteworthy == "wall_spawn" ? [ "exit_01", "exit_02" ] : [ "exit_01", "exit_02", "exit_03", "exit_04" ];
    spawn_exit = var_a0a354b856fd69e[ randomint( var_a0a354b856fd69e.size ) ];
    bot.spawn_struct thread scene::play( undefined, spawn_exit );
    wait 0.5;
    bot.ignoreme = 0;
    bot.ignoreall = 0;
    bot.var_24954f14e27b448d = 1;
    bot enableaimassist();
}

// Namespace story_contract_util
// Params 3
// Checksum 0xdcbb94df, Offset: 0x2f32
// Size: 0x268
function function_e6799e9a19df2365( targetname, var_e9564cd22ae43276 = %"hash_2b9705ca7545e18e", num_items = 4 )
{
    var_1a00a5a2ba836d4d = utility::getstructarray( targetname, "targetname" );
    
    foreach ( struct in var_1a00a5a2ba836d4d )
    {
        aligned_origin = ( int( struct.origin[ 0 ] ), int( struct.origin[ 1 ] ), int( struct.origin[ 2 ] ) );
        cache = common_cache::spawncache( %"hash_678525efe1c116c5", aligned_origin, struct.angles );
        
        /#
            if ( struct.origin != aligned_origin )
            {
                logstring( "<dev string:xc4>" + struct.origin + "<dev string:x1b6>" + aligned_origin );
            }
        #/
        
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "ob_sat_item_select_" ) )
        {
            var_33e1f9622e337b17 = hashcat( %"itemspawnentry:", struct.script_noteworthy );
            var_6a21abb6c002bb54 = %"itemspawnentry:ob_sat_item_ammo";
            common_cache::function_a09e7cf5bad99b64( cache, [ var_33e1f9622e337b17, var_6a21abb6c002bb54, var_6a21abb6c002bb54 ], 1 );
            continue;
        }
        
        if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "ob_sat_items_" ) )
        {
            current_item_list = hashcat( %"itemspawnlist:", struct.script_noteworthy ) ?? var_e9564cd22ae43276;
            current_num_items = struct.script_parameters ?? num_items;
            common_cache::function_a136b84fc5c0dfab( cache, current_item_list, current_num_items, 1 );
            continue;
        }
        
        current_item_list = var_e9564cd22ae43276;
        current_num_items = struct.script_parameters ?? num_items;
        common_cache::function_a136b84fc5c0dfab( cache, current_item_list, current_num_items, 1 );
    }
}

// Namespace story_contract_util
// Params 0, eflags: 0x4
// Checksum 0xb814cbab, Offset: 0x31a2
// Size: 0x279
function private debug_init()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_story_progression_ignore", &function_44bae980b7e731e4 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_story_progression_reset", &function_75999b5f1f828a61 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_story_progression_complete", &function_816f0a4e9ae934d5 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_story_progression_skipto", &function_85445fa008951fd8 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_story_progression_active", &function_4be2d88978819f75 );
    
    /#
        devgui::add_devgui_func( "<dev string:x1c9>", "<dev string:x1ec>", &debug_draw_progression, 1, 0 );
    #/
    
    level.var_b47d8c82aca9768f = getdvar( @"scr_ob_story_progression_override" );
    level.var_b47d8c82aca9768f = level.var_b47d8c82aca9768f == "" ? undefined : getxhash( level.var_b47d8c82aca9768f );
    
    /#
        if ( isdefined( level.var_b47d8c82aca9768f ) && level.var_b47d8c82aca9768f != #"hash_fb9c944f270b2e6d" )
        {
            var_7af398661f91675f = [];
            
            foreach ( info in level.var_a964e9285c1f8206 )
            {
                if ( info.key == level.var_b47d8c82aca9768f )
                {
                    var_80776ea7817f2577 = 1;
                    break;
                }
                
                var_7af398661f91675f[ var_7af398661f91675f.size ] = getxhashsourcename( info.key );
            }
            
            if ( !var_80776ea7817f2577 )
            {
                invalidvalue = level.var_b47d8c82aca9768f;
                level.var_b47d8c82aca9768f = undefined;
                println( "<dev string:x206>" );
                println( "<dev string:x24d>" );
                println( "<dev string:x292>" );
                
                foreach ( line in var_7af398661f91675f )
                {
                    println( line );
                }
                
                println( "<dev string:x206>" );
                assertmsg( "<dev string:x2f8>" + invalidvalue + "<dev string:x33c>" );
            }
        }
    #/
}

// Namespace story_contract_util
// Params 1
// Checksum 0x9cbe48ee, Offset: 0x3423
// Size: 0x154
function function_44bae980b7e731e4( params )
{
    level.var_b47d8c82aca9768f = #"hash_fb9c944f270b2e6d";
    
    foreach ( player in level.players )
    {
        foreach ( info in level.var_a964e9285c1f8206 )
        {
            if ( isdefined( info.omnvar ) )
            {
                player setclientomnvar( info.omnvar, 1 );
                self.assigned_difficulty = region_difficulty_manager::function_dc53171229eb2097( info.difficulty );
            }
        }
        
        level notify( #"hash_b8a09fa57f8824cf", player );
        player notify( #"hash_aaddcb9b5adcf263" );
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0xbf5b33c4, Offset: 0x357f
// Size: 0x164
function function_75999b5f1f828a61( params )
{
    players = params[ 0 ] ?? level.players;
    
    foreach ( player in players )
    {
        logstring( "[OB_STORY_PROGRESSION] Resetting progression for player [" + player.name + "]" );
        
        for ( index = 0; index < level.var_a964e9285c1f8206.size ; index++ )
        {
            player.var_4940624b8a6df73f[ index ] = 0;
            
            if ( isdefined( level.var_a964e9285c1f8206[ index ].ddl_bit ) )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", level.var_a964e9285c1f8206[ index ].ddl_bit, 0 );
            }
        }
        
        function_9e7b41fe021a293a( player, 0, 1 );
        waitframe();
        
        if ( player )
        {
            player function_432458e83a394206( 3 );
            player function_bd43e7421d15ad98( "Debug Reset" );
            player notify( #"hash_1b6b9613636daa6a" );
        }
    }
    
    println( "<dev string:x357>" );
}

// Namespace story_contract_util
// Params 1
// Checksum 0xb59e51fe, Offset: 0x36eb
// Size: 0x181
function function_816f0a4e9ae934d5( params )
{
    key = getxhash( params[ 0 ] );
    players = params[ 1 ] ?? level.players;
    target_index = level.var_28c4907db51eb251[ key ];
    
    foreach ( player in players )
    {
        player.var_4940624b8a6df73f[ target_index ] = 1;
        
        if ( isdefined( level.var_a964e9285c1f8206[ target_index ].ddl_bit ) )
        {
            logstring( "[OB_STORY_PROGRESSION] Debug completing progression of [" + level.var_a964e9285c1f8206[ target_index ].ddl_bit + "] for player [" + player.name + "]" );
            player setplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", level.var_a964e9285c1f8206[ target_index ].ddl_bit, 1 );
        }
        
        function_9e7b41fe021a293a( player, target_index + 1, 1 );
        waitframe();
        
        if ( player )
        {
            player function_432458e83a394206( 3 );
            player function_bd43e7421d15ad98( "Debug Complete" );
            player notify( #"hash_1b6b9613636daa6a" );
        }
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0x3ee1b6b9, Offset: 0x3874
// Size: 0x21d
function function_85445fa008951fd8( params )
{
    key = getxhash( params[ 0 ] );
    players = params[ 1 ] ?? level.players;
    function_75999b5f1f828a61( [ players ] );
    target_index = level.var_28c4907db51eb251[ key ];
    
    foreach ( player in players )
    {
        if ( isdefined( level.var_a964e9285c1f8206[ target_index ].ddl_bit ) )
        {
            logstring( "[OB_STORY_PROGRESSION] Debug skipping progression to [" + level.var_a964e9285c1f8206[ target_index ].ddl_bit + "] for player [" + player.name + "]" );
        }
        
        function_9e7b41fe021a293a( player, target_index + 1, 1 );
        
        for ( index = 0; index < level.var_a964e9285c1f8206.size ; index++ )
        {
            if ( index <= target_index )
            {
                player.var_4940624b8a6df73f[ index ] = 1;
                
                if ( isdefined( level.var_a964e9285c1f8206[ index ].ddl_bit ) )
                {
                    player setplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", level.var_a964e9285c1f8206[ index ].ddl_bit, 1 );
                }
                
                continue;
            }
            
            player.var_4940624b8a6df73f[ index ] = 0;
            
            if ( isdefined( level.var_a964e9285c1f8206[ index ].ddl_bit ) )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "storyMissionComplete", level.var_a964e9285c1f8206[ index ].ddl_bit, 0 );
            }
        }
        
        waitframe();
        
        if ( player )
        {
            player function_432458e83a394206( 3 );
            player function_bd43e7421d15ad98( "Debug Skip" );
        }
    }
}

// Namespace story_contract_util
// Params 1
// Checksum 0xf4d9019f, Offset: 0x3a99
// Size: 0xcf
function function_4be2d88978819f75( params )
{
    key = getxhash( params[ 0 ] );
    players = params[ 1 ] ?? level.players;
    target_index = level.var_28c4907db51eb251[ key ];
    
    foreach ( player in players )
    {
        function_9e7b41fe021a293a( player, target_index, 1 );
        player notify( #"hash_1b6b9613636daa6a" );
    }
}

/#

    // Namespace story_contract_util
    // Params 0, eflags: 0x4
    // Checksum 0xeca7b42c, Offset: 0x3b70
    // Size: 0x30a, Type: dev
    function private debug_draw_progression()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players ) || level.players.size == 0 )
        {
            waitframe();
        }
        
        player = level.players[ 0 ];
        player endon( #"disconnect" );
        spacing = 20;
        scale = 1.4;
        duration = int( ceil( 5 / level.framedurationseconds ) );
        
        while ( true )
        {
            x = 900;
            y = 50;
            printtoscreen2d( x, y, "<dev string:x38e>", ( 1, 1, 1 ), scale, duration );
            y += spacing;
            printtoscreen2d( x, y, "<dev string:x3ae>" + player getentitynumber() + "<dev string:x3b7>" + ( player.name ?? "<dev string:x3b9>" ), ( 1, 1, 1 ), scale, duration );
            y += spacing;
            
            if ( isdefined( player.var_f8d7f497f4294257 ) )
            {
                printtoscreen2d( x, y, "<dev string:x3ba>" + getxhashsourcename( level.var_a964e9285c1f8206[ player.var_f8d7f497f4294257 ].key ), ( 1, 1, 1 ), scale, duration );
            }
            else
            {
                printtoscreen2d( x, y, "<dev string:x3c3>", ( 1, 1, 1 ), scale, duration );
            }
            
            y += spacing;
            
            if ( level.var_b47d8c82aca9768f == #"hash_fb9c944f270b2e6d" )
            {
                printtoscreen2d( x, y, "<dev string:x3d8>", ( 1, 1, 1 ), scale, duration );
            }
            else if ( !isdefined( level.var_b47d8c82aca9768f ) )
            {
                printtoscreen2d( x, y, "<dev string:x3f6>", ( 1, 1, 1 ), scale, duration );
            }
            else
            {
                printtoscreen2d( x, y, "<dev string:x404>" + getxhashsourcename( level.var_b47d8c82aca9768f ), ( 1, 1, 1 ), scale, duration );
            }
            
            y += spacing;
            
            for ( index = 0; index < level.var_a964e9285c1f8206.size ; index++ )
            {
                if ( player.var_4940624b8a6df73f[ index ] )
                {
                    disabled_text = level.var_a964e9285c1f8206[ index ].disabled ? "<dev string:x40f>" : "<dev string:x3b9>";
                    printtoscreen2d( x, y, "<dev string:x41c>" + getxhashsourcename( level.var_a964e9285c1f8206[ index ].key ) + disabled_text, ( 1, 1, 1 ), scale, duration );
                }
                else
                {
                    printtoscreen2d( x, y, "<dev string:x421>" + getxhashsourcename( level.var_a964e9285c1f8206[ index ].key ), ( 1, 1, 1 ), scale, duration );
                }
                
                y += spacing;
            }
            
            wait 5;
        }
    }

#/
