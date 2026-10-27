// scripts\common\trigger_group.gsc  (hash_1913994125f6c868.gscc) (size: 6093 Bytes / 0x17cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea351b6 (245584310)
// size ...... 6093 (0x17cd)
// includes .. 3   (offset: 0x16a5)
// strings ... 3   (offset: 0x16bd)
// dev strs .. 13  (offset: 0x16e9)
// exports ... 18  (offset: 0xf7d)
// cseg ...... 0x8d + 0xef0 (0xf7d)
// imports ... 36  (offset: 0x124d)
// animtree1 . 0   (offset: 0x17cd)
// animtree2 . 0   (offset: 0x17cd)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;

#namespace trigger_group;

// Namespace trigger_group
// Params 0, eflags: 0x5
// Checksum 0xee06c0d3, Offset: 0xab
// Size: 0x19
function private autoexec __autoexec__()
{
    system::register( #"trigger_group", undefined, undefined, &function_7772abdca2d7c70b );
}

// Namespace trigger_group
// Params 0, eflags: 0x4
// Checksum 0x270b2a0e, Offset: 0xcc
// Size: 0x13f
function private function_7772abdca2d7c70b()
{
    println( "<dev string:x24>" + "<dev string:x37>" );
    structs = utility::getstructarray( "trigger_group", "targetname" );
    structs = arraycombine( structs, getentarray( "trigger_group", #targetname ) );
    println( "<dev string:x24>" + structs.size + "<dev string:x53>" );
    
    foreach ( struct in structs )
    {
        triggers = utility::getstructarray( struct.trigger_group, "targetname" );
        triggers = arraycombine( triggers, getentarray( struct.trigger_group, #targetname ) );
        create( struct.name, triggers, struct.origin, struct.angles );
    }
    
    utility::flag_set( "trigger_group_init" );
}

// Namespace trigger_group
// Params 4
// Checksum 0xdff68250, Offset: 0x213
// Size: 0x1a0
function create( ref, triggers, origin, angles )
{
    xhash_id = !isxhash( ref ) ? getxhash( ref ) : ref;
    
    if ( triggers.size < 2 )
    {
        println( "<dev string:x24>" + "<dev string:x69>" + xhash_id + "<dev string:xa7>" );
        return;
    }
    
    if ( isdefined( level.trigger_groups[ xhash_id ] ) )
    {
        println( "<dev string:x24>" + "<dev string:xa9>" + xhash_id + "<dev string:xa7>" );
        return;
    }
    
    trigger_group = {};
    trigger_group.origin = origin;
    trigger_group.angles = angles;
    trigger_group.xhash_id = xhash_id;
    trigger_group.triggers = triggers;
    
    foreach ( trigger in triggers )
    {
        trigger.trigger_group = trigger_group;
    }
    
    if ( !isdefined( level.trigger_groups ) )
    {
        level.trigger_groups = [];
    }
    
    level.trigger_groups[ xhash_id ] = trigger_group;
    
    /#
        level thread function_39873110dbaf0e30();
    #/
    
    println( "<dev string:x24>" + "<dev string:xc8>" + xhash_id + "<dev string:xa7>" );
    return trigger_group;
}

// Namespace trigger_group
// Params 1
// Checksum 0x75222ed4, Offset: 0x3bc
// Size: 0x39
function get( ref )
{
    xhash_id = !isxhash( ref ) ? getxhash( ref ) : ref;
    return level.trigger_groups[ xhash_id ];
}

// Namespace trigger_group
// Params 1
// Checksum 0x2a67ebec, Offset: 0x3fe
// Size: 0x17
function get_triggers( trigger_group )
{
    return trigger_group.triggers;
}

// Namespace trigger_group
// Params 1
// Checksum 0x2f4d22f0, Offset: 0x41e
// Size: 0x2d, Type: bool
function is_trigger_group( object )
{
    return isdefined( object.xhash_id ) && isdefined( get( object.xhash_id ) );
}

// Namespace trigger_group
// Params 2
// Checksum 0x73add05c, Offset: 0x454
// Size: 0x95, Type: bool
function is_touching( trigger_group, ent )
{
    foreach ( trigger in trigger_group.triggers )
    {
        if ( ent istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace trigger_group
// Params 2
// Checksum 0xd3f8984, Offset: 0x4f2
// Size: 0x95, Type: bool
function is_point_inside( trigger_group, point )
{
    foreach ( trigger in trigger_group.triggers )
    {
        if ( ispointinvolume( point, trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace trigger_group
// Params 1
// Checksum 0x8ff01a7c, Offset: 0x590
// Size: 0xac
function enable( trigger_group )
{
    foreach ( trigger in trigger_group.triggers )
    {
        trigger utility::trigger_on();
    }
    
    println( "<dev string:x24>" + "<dev string:xe0>" + trigger_group.xhash_id + "<dev string:xa7>" );
}

// Namespace trigger_group
// Params 1
// Checksum 0xf5c092bc, Offset: 0x644
// Size: 0xac
function disable( trigger_group )
{
    foreach ( trigger in trigger_group.triggers )
    {
        trigger utility::trigger_off();
    }
    
    println( "<dev string:x24>" + "<dev string:xf8>" + trigger_group.xhash_id + "<dev string:xa7>" );
}

// Namespace trigger_group
// Params 2
// Checksum 0xf67328e, Offset: 0x6f8
// Size: 0xc6
function update_origin( trigger_group, origin )
{
    foreach ( trigger in trigger_group.triggers )
    {
        local_origin = trigger.origin - trigger_group.origin;
        trigger.origin = origin + local_origin;
    }
    
    trigger_group.origin = origin;
}

// Namespace trigger_group
// Params 2
// Checksum 0x7ce76499, Offset: 0x7c6
// Size: 0x11b
function function_37f390027536269c( trigger_group, angles )
{
    foreach ( trigger in trigger_group.triggers )
    {
        local_angles = combineanglesinverted( trigger_group.angles, trigger.angles );
        trigger.angles = combineangles( angles, local_angles );
        local_origin = rotatevectorinverted( trigger.origin - trigger_group.origin, trigger_group.angles );
        trigger.origin = trigger_group.origin + rotatevector( local_origin, angles );
    }
    
    trigger_group.angles = angles;
}

// Namespace trigger_group
// Params 6
// Checksum 0x2d412e91, Offset: 0x8e9
// Size: 0x13c
function function_b130b2b8d424652d( trigger_group, on_enter_func, on_exit_func, filter_func, payload, var_333384ff46564ab3 )
{
    if ( isdefined( trigger_group.enter_exit ) )
    {
        println( "<dev string:x24>" + "<dev string:x111>" + trigger_group.xhash_id + "<dev string:xa7>" );
        return;
    }
    
    foreach ( trigger in trigger_group.triggers )
    {
        trigger trigger::makeenterexittrigger( trigger, &function_c6949dbf9e6ef50d, &on_exit_trigger, undefined, undefined, filter_func, payload, var_333384ff46564ab3 );
    }
    
    enter_exit = {};
    enter_exit.on_enter_func = on_enter_func;
    enter_exit.on_exit_func = on_exit_func;
    enter_exit.ents = [];
    trigger_group.enter_exit = enter_exit;
}

// Namespace trigger_group
// Params 1
// Checksum 0xa6b5f22d, Offset: 0xa2d
// Size: 0xf6
function cleanup_enter_exit_trigger( trigger_group )
{
    if ( isdefined( trigger_group.enter_exit ) )
    {
        println( "<dev string:x24>" + "<dev string:x14d>" + trigger_group.xhash_id + "<dev string:xa7>" );
        return;
    }
    
    foreach ( trigger in trigger_group.triggers )
    {
        trigger thread trigger::cleanup_enter_exit_trigger( trigger, 1 );
    }
    
    while ( trigger_group.enter_exit.ents.size > 0 )
    {
        trigger_group waittill( #"trigger_group_exit" );
    }
    
    trigger_group.enter_exit = undefined;
}

// Namespace trigger_group
// Params 3, eflags: 0x4
// Checksum 0xc83ad1d6, Offset: 0xb2b
// Size: 0xe1
function private function_c6949dbf9e6ef50d( ent, trigger, payload )
{
    trigger_group = trigger.trigger_group;
    enter_exit = trigger_group.enter_exit;
    entid = ent getentitynumber();
    
    if ( enter_exit.ents[ entid ] )
    {
        enter_exit.ents[ entid ]++;
        return;
    }
    
    println( "<dev string:x24>" + "<dev string:x185>" + trigger_group.xhash_id + "<dev string:xa7>" );
    enter_exit.ents[ entid ] = 1;
    
    if ( isdefined( enter_exit.on_enter_func ) )
    {
        profilestart();
        [[ enter_exit.on_enter_func ]]( ent, trigger, payload );
        profilestop();
    }
    
    trigger_group notify( #"trigger_group_enter" );
}

// Namespace trigger_group
// Params 3, eflags: 0x4
// Checksum 0xe4d2d6cb, Offset: 0xc14
// Size: 0xe0
function private on_exit_trigger( ent, trigger, payload )
{
    trigger_group = trigger.trigger_group;
    enter_exit = trigger_group.enter_exit;
    entid = ent getentitynumber();
    enter_exit.ents[ entid ]--;
    
    if ( enter_exit.ents[ entid ] > 0 )
    {
        return;
    }
    
    println( "<dev string:x24>" + "<dev string:x19d>" + trigger_group.xhash_id + "<dev string:xa7>" );
    enter_exit.ents[ entid ] = undefined;
    
    if ( isdefined( enter_exit.on_exit_func ) )
    {
        profilestart();
        [[ enter_exit.on_exit_func ]]( ent, trigger, payload );
        profilestop();
    }
    
    trigger_group notify( #"trigger_group_exit" );
}

/#

    // Namespace trigger_group
    // Params 0, eflags: 0xc
    // Checksum 0xb3869811, Offset: 0xcfc
    // Size: 0x281, Type: dev
    function private function_39873110dbaf0e30()
    {
        self notify( #"hash_40027d5bd58c7721" );
        self endon( #"hash_40027d5bd58c7721" );
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_f45033f07d01a9ef", 0 );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_f45033f07d01a9ef", 0 ) == 0 )
            {
                continue;
            }
            
            foreach ( trigger_group in level.trigger_groups )
            {
                print3d( trigger_group.origin, trigger_group.xhash_id, ( 0.3, 0.3, 0.8 ), 1, 1, 1, 1 );
                
                foreach ( trigger in trigger_group.triggers )
                {
                    if ( isent( trigger ) )
                    {
                        drawentitybounds( trigger, ( 0.6, 0.6, 0.8 ), 0, 1 );
                    }
                    else if ( isdefined( trigger.radius ) )
                    {
                        up = anglestoup( trigger.angles );
                        end = trigger.origin + up * trigger.height;
                        cylinder( trigger.origin, end, trigger.radius, ( 0.6, 0.6, 0.8 ), 0, 1 );
                    }
                    else
                    {
                        dimensions = trigger.size_min + trigger.size_max;
                        orientedbox( trigger.origin, dimensions, trigger.angles, ( 0.6, 0.6, 0.8 ), 0, 1 );
                    }
                    
                    line( trigger_group.origin, trigger.origin, ( 0.3, 0.3, 0.8 ), 1, 0, 1 );
                }
            }
        }
    }

#/
