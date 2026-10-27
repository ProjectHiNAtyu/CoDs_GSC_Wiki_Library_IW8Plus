// scripts\common\ai\aitypes\shared\zombie\zombie_vox.gsc  (hash_380194b81c38cd1a.gscc) (size: 3171 Bytes / 0xc63 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37f861d1 (939024849)
// size ...... 3171 (0xc63)
// includes .. 1   (offset: 0xbb7)
// strings ... 9   (offset: 0xbbf)
// dev strs .. 3   (offset: 0xc3f)
// exports ... 13  (offset: 0x77f)
// cseg ...... 0xc4 + 0x6bb (0x77f)
// imports ... 19  (offset: 0x987)
// animtree1 . 0   (offset: 0xc63)
// animtree2 . 0   (offset: 0xc63)
#using scripts\common\utility;

#namespace zombie_vox;

// Namespace zombie_vox
// Params 0
// Checksum 0xa0038eaa, Offset: 0xe2
// Size: 0x10
function init_zombie_vox()
{
    self.var_b2ad1e9d78432fca = &function_8af3dcaafbf8f895;
}

// Namespace zombie_vox
// Params 5
// Checksum 0xd8746ccf, Offset: 0xfa
// Size: 0x241
function function_e7828eef0e4316d6( ai, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    ai endon( #"death" );
    
    /#
        if ( getdvarint( @"scr_disable_ai_vo", 0 ) != 0 )
        {
            return;
        }
    #/
    
    if ( !isdefined( ai ) )
    {
        return;
    }
    
    if ( ai.var_99ae508ac039ff18 )
    {
        return;
    }
    
    if ( isdefined( priority ) && isdefined( ai.var_a479d0a33d0f561c[ priority ] ) )
    {
        if ( gettime() < ai.var_a479d0a33d0f561c[ priority ] )
        {
            return;
        }
    }
    
    if ( ai utility::ent_flag( "playing_vo" ) && isdefined( ai.var_f72fc6bc696c30fc ) && isdefined( priority ) )
    {
        if ( priority < ai.var_f72fc6bc696c30fc || priority == 1 )
        {
            return;
        }
        
        ai notify( #"hash_5ecce2eb6bdf4968" );
        
        if ( ai isscriptable() )
        {
            ai utility::function_7c10ea82c1e305b8( "sound_vo", "off" );
        }
        
        if ( priority > ai.var_f72fc6bc696c30fc && !level.var_73cb209b69f024e2 )
        {
            var_41fd1f667b65256d = ai function_60b4e7f5dcc09735();
            ai stopsoundchannel( var_41fd1f667b65256d );
            level thread function_1380856042b5a072();
        }
        
        waitframe();
    }
    
    if ( soundexists( alias ) || isdefined( scriptable_state ) )
    {
        ai.var_f72fc6bc696c30fc = priority;
        ai utility::ent_flag_set( "playing_vo" );
        
        if ( !isdefined( var_9a3bc44f9b1e1618 ) )
        {
            var_9a3bc44f9b1e1618 = 1000;
        }
        
        time = var_9a3bc44f9b1e1618;
        
        if ( isdefined( scriptable_state ) )
        {
            if ( !ai isscriptable() )
            {
                assert( 0, "<dev string:x24>" + ai.agent_type + "<dev string:x42>" );
            }
            else
            {
                ai utility::function_7c10ea82c1e305b8( "sound_vo", scriptable_state );
            }
        }
        else if ( isdefined( soundexists( alias ) ) )
        {
            ai playsoundonmovingent( alias );
        }
        
        ai endon( #"hash_5ecce2eb6bdf4968" );
        ai utility::ent_flag_clear_delayed( "playing_vo", utility::function_6f5d2e1f1ff70482( time ) );
        
        if ( ai isscriptable() )
        {
            ai utility::function_7c10ea82c1e305b8( "sound_vo", "off" );
        }
        
        ai.var_f72fc6bc696c30fc = 0;
        return;
    }
    
    println( "<dev string:x55>" + alias );
}

// Namespace zombie_vox
// Params 0
// Checksum 0xa4d710bf, Offset: 0x343
// Size: 0x18
function function_1380856042b5a072()
{
    level.var_73cb209b69f024e2 = 1;
    waitframe();
    level.var_73cb209b69f024e2 = 0;
}

// Namespace zombie_vox
// Params 0
// Checksum 0x33044d12, Offset: 0x363
// Size: 0x58
function function_60b4e7f5dcc09735()
{
    if ( self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" || self.aicategory == "boss" )
    {
        return "voice_zmb_elite_3d";
    }
    
    return "voice_zmb_1_3d";
}

// Namespace zombie_vox
// Params 2
// Checksum 0xa8d1d4c0, Offset: 0x3c4
// Size: 0x3f
function function_bb5be6a2c88bc5f4( time_ms, priority )
{
    if ( !isdefined( self.var_a479d0a33d0f561c ) )
    {
        self.var_a479d0a33d0f561c = [];
    }
    
    self.var_a479d0a33d0f561c[ priority ] = gettime() + time_ms;
}

// Namespace zombie_vox
// Params 0
// Checksum 0x1d683ac6, Offset: 0x40b
// Size: 0x23
function function_2373b7dab1283d18()
{
    if ( !isdefined( self.var_99ae508ac039ff18 ) )
    {
        self.var_99ae508ac039ff18 = 0;
    }
    
    self.var_99ae508ac039ff18 = 1;
}

// Namespace zombie_vox
// Params 0
// Checksum 0xa9c37ee, Offset: 0x436
// Size: 0x22
function function_21120aecc1ba904b()
{
    if ( !isdefined( self.var_99ae508ac039ff18 ) )
    {
        self.var_99ae508ac039ff18 = 0;
    }
    
    self.var_99ae508ac039ff18 = 0;
}

// Namespace zombie_vox
// Params 5
// Checksum 0xf6377bd6, Offset: 0x460
// Size: 0xd1
function register_vox_state( notify_string, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    if ( !isdefined( level.ai_vox_states ) )
    {
        level.ai_vox_states = [];
    }
    
    if ( !isdefined( level.ai_vox_states[ self.basearchetype ] ) )
    {
        level.ai_vox_states[ self.basearchetype ] = [];
    }
    
    state = spawnstruct();
    state.scriptable_state = scriptable_state;
    state.priority = priority;
    state.alias = alias;
    state.var_9a3bc44f9b1e1618 = var_9a3bc44f9b1e1618;
    level.ai_vox_states[ self.basearchetype ][ notify_string ] = state;
}

// Namespace zombie_vox
// Params 6
// Checksum 0xc54d51f0, Offset: 0x539
// Size: 0xdc
function function_3e1f4a0d10aabdeb( var_7d70e93d05da03c, notify_string, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    if ( !isdefined( level.ai_vox_states ) )
    {
        level.ai_vox_states = [];
    }
    
    if ( !isdefined( level.ai_vox_states[ self.basearchetype ] ) )
    {
        level.ai_vox_states[ self.basearchetype ] = [];
    }
    
    state = spawnstruct();
    state.scriptable_state = scriptable_state;
    state.priority = priority;
    state.alias = alias;
    state.var_9a3bc44f9b1e1618 = var_9a3bc44f9b1e1618;
    level.ai_vox_states[ self.basearchetype ][ notify_string + var_7d70e93d05da03c ] = state;
}

// Namespace zombie_vox
// Params 1, eflags: 0x4
// Checksum 0x7ef8ac15, Offset: 0x61d
// Size: 0x15
function private function_8af3dcaafbf8f895( state )
{
    function_5ac4bed4a907abf5( state );
}

// Namespace zombie_vox
// Params 1
// Checksum 0x1d30b37e, Offset: 0x63a
// Size: 0x126
function function_5ac4bed4a907abf5( event )
{
    if ( !isdefined( self.basearchetype ) )
    {
        return;
    }
    
    if ( !isdefined( level.ai_vox_states[ self.basearchetype ] ) )
    {
        return;
    }
    
    if ( isdefined( self.subclass ) && isdefined( level.ai_vox_states[ self.basearchetype ][ event + self.subclass ] ) )
    {
        event += self.subclass;
    }
    
    var_ef1f0d3ceff86400 = level.ai_vox_states[ self.basearchetype ][ event ];
    
    if ( !isdefined( var_ef1f0d3ceff86400 ) )
    {
        return;
    }
    
    scriptable_state = var_ef1f0d3ceff86400.scriptable_state;
    alias = var_ef1f0d3ceff86400.alias;
    priority = var_ef1f0d3ceff86400.priority;
    var_9a3bc44f9b1e1618 = var_ef1f0d3ceff86400.var_9a3bc44f9b1e1618;
    
    if ( isdefined( self.play_vox_fn ) )
    {
        level thread [[ self.play_vox_fn ]]( event, self, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
        return;
    }
    
    level thread function_e7828eef0e4316d6( self, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_vox
// Params 1
// Checksum 0x7aef740a, Offset: 0x768
// Size: 0x17
function register_play_vox_fn( play_vox_fn )
{
    self.play_vox_fn = play_vox_fn;
}

