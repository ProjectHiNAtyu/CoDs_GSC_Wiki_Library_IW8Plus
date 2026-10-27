// scripts\common\vortex.gsc  (hash_589f0911592e5f7a.gscc) (size: 5252 Bytes / 0x1484 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2cbedac (2999709100)
// size ...... 5252 (0x1484)
// includes .. 6   (offset: 0x1374)
// strings ... 14  (offset: 0x13a4)
// dev strs .. 3   (offset: 0x1460)
// exports ... 18  (offset: 0xc6c)
// cseg ...... 0x181 + 0xaeb (0xc6c)
// imports ... 36  (offset: 0xf3c)
// animtree1 . 0   (offset: 0x1484)
// animtree2 . 0   (offset: 0x1484)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace vortex;

// Namespace vortex
// Params 0, eflags: 0x1
// Checksum 0x7c63cd8d, Offset: 0x19f
// Size: 0x98
function autoexec init()
{
    utility::registersharedfunc( #"vortex", #"registerpriority", &register_vortex_priority );
    utility::registersharedfunc( #"vortex", #"hash_fd3f2ff8b376e106", &function_ac7cff526e5defc2 );
    utility::registersharedfunc( #"vortex", #"hash_36a1e7016033f741", &function_2688a4aecf0e6679 );
    utility::registersharedfunc( #"vortex", #"setstate", &set_vortex_state );
    utility::registersharedfunc( #"vortex", #"clearstate", &clear_vortex_state );
}

// Namespace vortex
// Params 2
// Checksum 0x514ea426, Offset: 0x23f
// Size: 0x3e
function register_vortex_priority( vortex_mode, priority )
{
    if ( !isdefined( level.vortex_priority ) )
    {
        level.vortex_priority = [];
    }
    
    level.vortex_priority[ vortex_mode ] = int( priority );
}

// Namespace vortex
// Params 0
// Checksum 0x66ab2f4d, Offset: 0x285
// Size: 0x16, Type: bool
function is_pulled()
{
    return istrue( self._blackboard.var_ee84e81f355af2ec );
}

// Namespace vortex
// Params 1
// Checksum 0x965c4b99, Offset: 0x2a4
// Size: 0x71, Type: bool
function is_pulled_by( vortex_id )
{
    assert( vortex_id, "<dev string:x24>" );
    
    if ( !is_pulled() )
    {
        return false;
    }
    
    assert( isarray( self.vortex_state ) && self.vortex_state.size > 0 );
    
    if ( vortex_id && self.vortex_state[ 0 ].id != vortex_id )
    {
        return false;
    }
    
    return true;
}

// Namespace vortex
// Params 2
// Checksum 0xbab9ffd0, Offset: 0x31e
// Size: 0x8f, Type: bool
function function_9fe39de8aadab2b9( vortex_mode, source )
{
    if ( self.magic_bullet_shield || self.damageshield )
    {
        return false;
    }
    
    if ( self.vortex_state.size > 0 )
    {
        active_vortex = self.vortex_state[ 0 ];
        
        if ( active_vortex.mode == vortex_mode && active_vortex.source === source )
        {
            return istrue( self._blackboard.var_431d45d5a00efc3d );
        }
    }
    
    return false;
}

// Namespace vortex
// Params 2, eflags: 0x4
// Checksum 0xf8e375d7, Offset: 0x3b6
// Size: 0x119
function private set_pull_state( vortex_state, is_new )
{
    if ( !is_pulled() )
    {
        val::set( "vortex_pull", "ignore_ai_collision" );
        val::set( "vortex_pull", "script_pushable_by_ai", 0 );
        val::set( "vortex_pull", "disallow_knockdown" );
        val::set( "vortex_pull", "disallow_stun" );
    }
    
    self._blackboard.vortexpullorigin = vortex_state.pull_origin;
    self._blackboard.var_d337e1535bd773b5 = vortex_state.death_range;
    self._blackboard.vortexmode = vortex_state.mode;
    self._blackboard.var_ee84e81f355af2ec = 1;
    
    if ( is_new )
    {
        self notify( #"hash_e691753f5e81b8e8" );
        callback::callback( "on_vortex_pull_changed", vortex_state.callback_payload );
        return;
    }
    
    callback::callback( "on_vortex_pull_updated", vortex_state.callback_payload );
}

// Namespace vortex
// Params 1, eflags: 0x4
// Checksum 0xe70bec66, Offset: 0x4d7
// Size: 0x95
function private function_95c9f29aeb98f0b5( has_transition )
{
    val::reset_all( "vortex_pull" );
    was_pulled = is_pulled();
    self._blackboard.var_ee84e81f355af2ec = 0;
    
    if ( was_pulled && has_transition && isdefined( archetypegetaliases( self.animsetname, "vortex_pull_outro" ) ) )
    {
        self function_786bb6aa1b76c7ee( "vortex_transition", 1 );
    }
    else
    {
        self._blackboard.vortexmode = undefined;
    }
    
    if ( was_pulled )
    {
        callback::callback( "on_vortex_pull_ended" );
    }
}

// Namespace vortex
// Params 1
// Checksum 0x259c1b15, Offset: 0x574
// Size: 0xaa
function function_7e9f78caee66e33d( vortex_mode )
{
    vortex_count = 0;
    
    if ( isdefined( self.vortex_state ) )
    {
        foreach ( vortex_state in self.vortex_state )
        {
            if ( vortex_state.mode == vortex_mode )
            {
                vortex_count++;
            }
        }
    }
    
    return vortex_count;
}

// Namespace vortex
// Params 2
// Checksum 0x1e64d950, Offset: 0x627
// Size: 0x3e
function function_ac7cff526e5defc2( source, priority_threshold )
{
    blocker_priority = int( priority_threshold ) - 0.5;
    set_vortex_state_internal( "vortex_blocker", source, blocker_priority, 1 );
}

// Namespace vortex
// Params 1
// Checksum 0x14fb22ae, Offset: 0x66d
// Size: 0x1b
function function_2688a4aecf0e6679( source )
{
    clear_vortex_state( "vortex_blocker", source, 0 );
}

// Namespace vortex
// Params 6
// Checksum 0x5497e794, Offset: 0x690
// Size: 0x76
function set_vortex_state( vortex_mode, source, vortex_origin, vortex_death_range, callback_payload, id )
{
    assert( vortex_mode != "<dev string:x64>" );
    vortex_priority = level.vortex_priority[ vortex_mode ] ?? 0;
    return set_vortex_state_internal( vortex_mode, source, vortex_priority, 0, vortex_origin, vortex_death_range, callback_payload, id );
}

// Namespace vortex
// Params 8, eflags: 0x4
// Checksum 0x5fe035bc, Offset: 0x70f
// Size: 0x25e
function private set_vortex_state_internal( vortex_mode, source, vortex_priority, is_blocker, vortex_origin, vortex_death_range, callback_payload, id )
{
    if ( !isdefined( self.vortex_state ) )
    {
        self.vortex_state = [];
    }
    
    assert( !isent( source ), "<dev string:x73>" );
    
    if ( !isdefined( is_blocker ) )
    {
        is_blocker = 0;
    }
    
    if ( !isdefined( vortex_death_range ) )
    {
        vortex_death_range = 0;
    }
    
    new_vortex = 1;
    
    for ( vortex_index = 0; vortex_index < self.vortex_state.size ; vortex_index++ )
    {
        vortex_state = self.vortex_state[ vortex_index ];
        
        if ( vortex_state.mode == vortex_mode && vortex_state.source === source )
        {
            assert( vortex_state.priority == vortex_priority );
            assert( vortex_state.is_blocker == is_blocker );
            
            if ( !vortex_state.is_blocker )
            {
                vortex_state.pull_origin = vortex_origin;
                vortex_state.death_range = vortex_death_range;
                vortex_state.callback_payload = callback_payload;
            }
            
            new_vortex = 0;
            break;
        }
        
        if ( vortex_priority > vortex_state.priority )
        {
            for ( i = self.vortex_state.size; i > vortex_index ; i-- )
            {
                self.vortex_state[ i ] = self.vortex_state[ i - 1 ];
            }
            
            break;
        }
    }
    
    if ( new_vortex )
    {
        vortex_state = { #id:id, #is_blocker:is_blocker, #priority:vortex_priority, #source:source, #mode:vortex_mode };
        
        if ( !vortex_state.is_blocker )
        {
            vortex_state.pull_origin = vortex_origin;
            vortex_state.death_range = vortex_death_range;
            vortex_state.callback_payload = callback_payload;
        }
        
        self.vortex_state[ vortex_index ] = vortex_state;
    }
    
    if ( vortex_index == 0 )
    {
        if ( vortex_state.is_blocker )
        {
            function_95c9f29aeb98f0b5( 0 );
        }
        else
        {
            set_pull_state( vortex_state, new_vortex );
        }
    }
    
    return new_vortex;
}

// Namespace vortex
// Params 3
// Checksum 0xb6685ca5, Offset: 0x976
// Size: 0x149, Type: bool
function clear_vortex_state( vortex_mode, source, has_transition )
{
    if ( isdefined( self.vortex_state ) )
    {
        for ( vortex_index = 0; vortex_index < self.vortex_state.size ; vortex_index++ )
        {
            vortex_state = self.vortex_state[ vortex_index ];
            
            if ( vortex_state.mode == vortex_mode && vortex_state.source === source )
            {
                for ( i = vortex_index; i < self.vortex_state.size - 1 ; i++ )
                {
                    self.vortex_state[ i ] = self.vortex_state[ i + 1 ];
                }
                
                self.vortex_state[ self.vortex_state.size - 1 ] = undefined;
                
                if ( vortex_index == 0 )
                {
                    if ( self.vortex_state.size > 0 )
                    {
                        active_vortex = self.vortex_state[ 0 ];
                        
                        if ( active_vortex.is_blocker )
                        {
                            function_95c9f29aeb98f0b5( has_transition );
                        }
                        else
                        {
                            set_pull_state( active_vortex, 1 );
                        }
                    }
                    else
                    {
                        function_95c9f29aeb98f0b5( has_transition );
                        self.vortex_state = undefined;
                    }
                }
                
                return true;
            }
        }
    }
    
    return false;
}

// Namespace vortex
// Params 0
// Checksum 0x932eab14, Offset: 0xac8
// Size: 0x13
function clear_all_vortex_state()
{
    function_95c9f29aeb98f0b5();
    self.vortex_state = undefined;
}

// Namespace vortex
// Params 0
// Checksum 0xf3a44efe, Offset: 0xae3
// Size: 0x9
function function_cd569249e4f9ac94()
{
    thread function_8b14d8cadaddddb8();
}

// Namespace vortex
// Params 0, eflags: 0x4
// Checksum 0x57238298, Offset: 0xaf4
// Size: 0x9
function private is_traversing()
{
    return ai::is_doing_traversal( self );
}

// Namespace vortex
// Params 0, eflags: 0xc
// Checksum 0x4fe49066, Offset: 0xb06
// Size: 0x166
function private function_8b14d8cadaddddb8()
{
    self notify( #"hash_fb74475c715bc28e" );
    self endon( #"hash_fb74475c715bc28e" );
    self endon( #"death" );
    
    while ( is_pulled() )
    {
        is_wall_traversing = is_traversing() && self._blackboard.var_397bfb4ed7256a7a;
        var_a20501ec681f3d6f = istrue( self.var_507d3f5433b78f74 );
        
        if ( is_wall_traversing || var_a20501ec681f3d6f )
        {
            pull_origin = self._blackboard.vortexpullorigin + 5 * ( 0, 0, 1 );
            pull_trace = physics_raycast( self.origin, pull_origin, trace::create_world_contents(), [ self ], 0, "physicsquery_closest" );
            
            if ( !isdefined( pull_trace[ 0 ][ "hittype" ] ) )
            {
                forward_vec = vectornormalize( pull_origin - self.origin );
                right_vec = vectorcross( forward_vec, ( 0, 0, 1 ) );
                up_vec = vectorcross( right_vec, forward_vec );
                pull_angles = axistoangles( forward_vec, right_vec, up_vec );
                self.vortex_pull_angles = pull_angles;
                
                if ( is_wall_traversing )
                {
                    asm::asm_fireevent( self.asmname, "wall_crawl_interrupt" );
                }
            }
        }
        
        wait 0.25;
    }
}

