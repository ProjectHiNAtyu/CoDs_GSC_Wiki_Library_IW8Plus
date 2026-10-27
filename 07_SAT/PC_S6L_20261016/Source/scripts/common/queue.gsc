// scripts\common\queue.gsc  (hash_208cdd0d907792fb.gscc) (size: 3426 Bytes / 0xd62 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x884bcf6a (2286669674)
// size ...... 3426 (0xd62)
// includes .. 1   (offset: 0xc9e)
// strings ... 6   (offset: 0xca6)
// dev strs .. 3   (offset: 0xd3e)
// exports ... 9   (offset: 0x96a)
// cseg ...... 0x9d + 0x8cd (0x96a)
// imports ... 16  (offset: 0xad2)
// animtree1 . 0   (offset: 0xd62)
// animtree2 . 0   (offset: 0xd62)
#using scripts\common\utility;

#namespace queue;

// Namespace queue
// Params 10
// Checksum 0x9a60624e, Offset: 0xbb
// Size: 0x101
function function_a7a36bf76c580ef6( queue, ref, init_func, break_func, interrupt_func, finish_func, func_params, priority, duration, break_notify )
{
    item = spawnstruct();
    item.ref = ref ?? "default";
    item.init_func = init_func;
    item.break_func = break_func;
    item.interrupt_func = interrupt_func;
    item.finish_func = finish_func;
    item.func_params = func_params;
    item.priority = priority ?? 0;
    item.duration = duration;
    item.break_notify = break_notify;
    function_8b2f4edf07bdea0c( queue, item );
}

// Namespace queue
// Params 2
// Checksum 0xf0f8c8c5, Offset: 0x1c4
// Size: 0x29e
function function_8b2f4edf07bdea0c( queue, item )
{
    if ( !isdefined( self.priority_queues ) )
    {
        self.priority_queues = [];
    }
    
    if ( !isdefined( self.priority_queues[ queue ] ) )
    {
        self.priority_queues[ queue ] = spawnstruct();
    }
    
    if ( !isdefined( item.ref ) )
    {
        item.ref = "default";
    }
    
    if ( !isdefined( item.priority ) )
    {
        item.priority = 0;
    }
    
    if ( !isdefined( self.priority_queues[ queue ].items ) || self.priority_queues[ queue ].items.size == 0 )
    {
        self.priority_queues[ queue ].items = [];
        self.priority_queues[ queue ].items[ 0 ] = item;
        thread function_afb8b8f6b62576b4( queue );
        return;
    }
    
    index = self.priority_queues[ queue ].items.size;
    ref_updated = 0;
    
    foreach ( idx, data in self.priority_queues[ queue ].items )
    {
        if ( item.ref != "default" && item.ref == data.ref )
        {
            if ( idx == 0 )
            {
                assert( "<dev string:x24>" + item.ref + "<dev string:x2e>" + queue + "<dev string:x39>" );
                return;
            }
            
            self.priority_queues[ queue ].items[ idx ] = item;
            ref_updated = 1;
            break;
        }
        
        if ( !isdefined( index ) && item.priority > data.priority )
        {
            index = idx;
        }
    }
    
    if ( !ref_updated && isdefined( index ) )
    {
        arrayinsert( self.priority_queues[ queue ].items, item, index );
        
        if ( index == 0 )
        {
            thread function_abbb397c1b064cae( queue, self.priority_queues[ queue ].items[ 1 ] );
        }
    }
}

// Namespace queue
// Params 2
// Checksum 0x83fbdfd8, Offset: 0x46a
// Size: 0xce
function function_90225ac6019fa99f( queue, ref )
{
    if ( isdefined( self.priority_queues[ queue ] ) )
    {
        for ( i = self.priority_queues[ queue ].items.size - 1; i >= 0 ; i-- )
        {
            if ( self.priority_queues[ queue ].items[ i ].ref == ref )
            {
                self.priority_queues[ queue ].items[ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( self.priority_queues[ queue ].items );
                }
                
                if ( i == 0 )
                {
                    self notify( queue + "_removed" );
                }
            }
        }
    }
}

// Namespace queue
// Params 1
// Checksum 0x45376cae, Offset: 0x540
// Size: 0x4f
function priority_queue_clear( queue )
{
    if ( isdefined( self.priority_queues[ queue ] ) )
    {
        if ( self.priority_queues[ queue ].items.size > 0 )
        {
            self notify( queue + "_removed" );
        }
        
        self.priority_queues[ queue ] = undefined;
    }
}

// Namespace queue
// Params 1, eflags: 0x4
// Checksum 0x1affdb49, Offset: 0x597
// Size: 0x273
function private function_afb8b8f6b62576b4( queue )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    
    while ( isdefined( self.priority_queues[ queue ] ) && self.priority_queues[ queue ].items.size > 0 )
    {
        item = self.priority_queues[ queue ].items[ 0 ];
        item.start_time = gettime();
        
        if ( isdefined( item.break_func ) && self [[ item.break_func ]]( item.func_params, item.start_time, 1 ) )
        {
            self.priority_queues[ queue ].items[ 0 ] = undefined;
            function_cdc669dbc8ea2101( self.priority_queues[ queue ].items );
            continue;
        }
        
        if ( isdefined( item.init_func ) )
        {
            self thread [[ item.init_func ]]( item.func_params, item.start_time, [ queue + "_removed", queue + "_interrupted", queue + "_done" ] );
        }
        
        if ( isdefined( item.break_func ) )
        {
            childthread function_44d29a4d81c29198( queue, item );
        }
        
        ret = undefined;
        
        if ( isdefined( item.duration ) )
        {
            if ( isdefined( item.break_notify ) )
            {
                ret = utility::waittill_any_timeout( item.duration, item.break_notify, queue + "_break", queue + "_removed", queue + "_interrupted" );
            }
            else
            {
                ret = utility::waittill_any_timeout( item.duration, queue + "_break", queue + "_removed", queue + "_interrupted" );
            }
        }
        else
        {
            ret = utility::waittill_any_return( queue + "_break", queue + "_removed", queue + "_interrupted", item.break_notify );
        }
        
        if ( ret == "timeout" || ret == queue + "_break" || ret == item.break_notify )
        {
            function_e9a1eb347bcd781c( queue, item );
            continue;
        }
        
        if ( ret == queue + "_removed" )
        {
            function_abbb397c1b064cae( queue, item );
        }
    }
}

// Namespace queue
// Params 2, eflags: 0x4
// Checksum 0xd0744feb, Offset: 0x812
// Size: 0x6d
function private function_44d29a4d81c29198( queue, item )
{
    self endon( queue + "_done" );
    self endon( queue + "_removed" );
    self endon( queue + "_interrupted" );
    
    while ( !self [[ item.break_func ]]( item.func_params, item.start_time ) )
    {
        waitframe();
    }
    
    self notify( queue + "_break" );
}

// Namespace queue
// Params 2, eflags: 0x4
// Checksum 0x4e1489e9, Offset: 0x887
// Size: 0x54
function private function_abbb397c1b064cae( queue, item )
{
    if ( isdefined( item.interrupt_func ) )
    {
        self thread [[ item.interrupt_func ]]( item.func_params, item.start_time );
    }
    
    self notify( queue + "_interrupted" );
}

// Namespace queue
// Params 2, eflags: 0x4
// Checksum 0xe4b49704, Offset: 0x8e3
// Size: 0x87
function private function_e9a1eb347bcd781c( queue, item )
{
    if ( isdefined( item.finish_func ) )
    {
        self thread [[ item.finish_func ]]( item.func_params, item.start_time );
    }
    
    self notify( queue + "_done" );
    self.priority_queues[ queue ].items[ 0 ] = undefined;
    function_cdc669dbc8ea2101( self.priority_queues[ queue ].items );
}

