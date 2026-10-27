// script_7574fdd29cd7dec6  (hash_7574fdd29cd7dec6.gscc) (size: 6661 Bytes / 0x1a05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde7f597d (3732887933)
// size ...... 6661 (0x1a05)
// includes .. 10  (offset: 0x187d)
// strings ... 22  (offset: 0x18cd)
// dev strs .. 0   (offset: 0x1a05)
// exports ... 17  (offset: 0xe9d)
// cseg ...... 0x250 + 0xc4d (0xe9d)
// imports ... 63  (offset: 0x1145)
// animtree1 . 0   (offset: 0x1a05)
// animtree2 . 0   (offset: 0x1a05)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_lawn_mower;

// Namespace ztron_hazard_lawn_mower
// Params 0, eflags: 0x5
// Checksum 0xa1837e17, Offset: 0x26e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_lawn_mower", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_lawn_mower
// Params 0
// Checksum 0xd979cf5, Offset: 0x297
// Size: 0x84
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"lawn_mower", #"create", &create_lawn_mower );
    ztron_hazard::function_6f661fac5fd31f1( #"lawn_mower", #"arenaspawn", &init_hazard_lawn_mower );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_lawn_mower_lp", "evt_ztron_traps_lawnmower_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_lawn_mower_on", "evt_ztron_traps_lawnmower_start" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_lawn_mower_off", "evt_ztron_traps_lawnmower_stop" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_lawn_mower_rotate", "evt_ztron_traps_lawnmower_rotate" );
}

// Namespace ztron_hazard_lawn_mower
// Params 0
// Checksum 0x1a897e36, Offset: 0x323
// Size: 0x9c
function init_hazard_lawn_mower()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "lawn_mower" );
    
    foreach ( hazard in hazards )
    {
        create_lawn_mower( hazard );
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 1
// Checksum 0x575fe9e1, Offset: 0x3c7
// Size: 0x7c
function function_748a05ca5065be6( mower_struct )
{
    for ( var_e996efa7b58c55d6 = mower_struct; !isdefined( var_e996efa7b58c55d6.var_88163dd40ed18fac ) ; var_e996efa7b58c55d6 = next_node )
    {
        if ( !isdefined( var_e996efa7b58c55d6.target ) )
        {
            break;
        }
        
        next_node = utility::getstruct( var_e996efa7b58c55d6.target, "targetname" );
        
        if ( !isdefined( next_node ) )
        {
            break;
        }
        
        var_e996efa7b58c55d6.var_88163dd40ed18fac = next_node;
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 2
// Checksum 0xddf81061, Offset: 0x44b
// Size: 0x27
function create_lawn_mower( trap, page )
{
    function_748a05ca5065be6( trap );
    function_6c1605fd939afaa8( trap );
}

// Namespace ztron_hazard_lawn_mower
// Params 1, eflags: 0x4
// Checksum 0x883b4fd9, Offset: 0x47a
// Size: 0x313
function private function_6c1605fd939afaa8( mower_struct )
{
    if ( isdefined( mower_struct.var_433b0194464a5e86 ) )
    {
        return;
    }
    
    speed = 80;
    model_name = "equipment_lawnmower_01";
    model_angles_offset = ( 0, 90, 0 );
    trigger_size = ( 41, 25, 30 );
    
    if ( isdefined( mower_struct.script_parameters ) )
    {
        args = strtok( mower_struct.script_parameters, ";" );
        
        if ( args.size >= 1 )
        {
            speed = float( args[ 0 ] );
        }
        
        if ( args.size >= 2 )
        {
            model_name = args[ 1 ];
        }
        
        if ( args.size >= 3 )
        {
            trigger_size = function_906b71901ebbd19( args[ 2 ] );
        }
        
        if ( args.size >= 4 )
        {
            model_angles_offset = function_906b71901ebbd19( args[ 3 ] );
        }
    }
    
    mower_path = mower_struct;
    mower_angles = vectortoangles( mower_path.var_88163dd40ed18fac.origin - mower_path.origin );
    mower_struct.var_433b0194464a5e86 = utility::spawn_model( model_name, mower_struct.origin, mower_angles );
    
    if ( isdefined( mower_struct.var_433b0194464a5e86 ) )
    {
        mover = spawn( "script_model", mower_struct.origin );
        mover.angles = mower_angles;
        mover.script_noteworthy = "hazard_mower";
        mover setmodel( "tag_origin" );
        mower_struct.var_433b0194464a5e86 linkto( mover, "tag_origin", ( 0, 0, 0 ), model_angles_offset );
        trigger = spawn( "trigger_box", ( 0, 0, 0 ), 0, trigger_size, trigger_size + ( 1, 1, 1 ) );
        
        if ( !isdefined( trigger ) )
        {
            mower_struct.var_433b0194464a5e86 delete();
            return;
        }
        
        trigger.owner = mover;
        trigger enablelinkto();
        trigger.angles = mower_angles;
        trigger.origin = mower_struct.origin;
        trigger.owner = mower_struct.var_433b0194464a5e86;
        mower_struct.trigger = trigger;
        mower_struct.var_433b0194464a5e86.trigger = trigger;
        trigger linkto( mover, "tag_origin" );
        mower_struct.var_433b0194464a5e86.mover = mover;
        trigger thread function_d8c405106e331887();
        mower_struct.var_433b0194464a5e86.mover function_6ae004ca2f6fdaca();
        mower_struct.var_433b0194464a5e86.mover thread function_3d2cb55c078cae40( mower_path, speed, trigger );
        mower_struct.var_433b0194464a5e86.mover thread function_983b9d28ad5fab80();
        mower_struct.var_433b0194464a5e86 thread function_8c8adbd1b4b7578b();
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 0, eflags: 0x4
// Checksum 0x9757fc01, Offset: 0x795
// Size: 0xaa
function private function_d8c405106e331887()
{
    self endon( #"death" );
    
    /#
        thread function_7e0838d6457f971e( self );
    #/
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( filter_trigger_func( ent ) )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            ent dodamage( abs( ent.health ) + 100, ent.origin, self, self );
            ent playrumbleonentity( "damage_light" );
            continue;
        }
        
        if ( ent ztron_enemy_ai::iszombie() )
        {
            ent thread ztron_util::function_afa1f6a404783c8a( ( 0, 0, 220 ), 18000 );
        }
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 1
// Checksum 0x86913058, Offset: 0x847
// Size: 0xbc, Type: bool
function filter_trigger_func( ent )
{
    if ( !self.var_d12598e91b6083d )
    {
        return true;
    }
    
    if ( !isdefined( ent ) )
    {
        return true;
    }
    
    if ( ent.no_hazards || ent.ztron.boss || player::isinlaststand( ent ) )
    {
        return true;
    }
    
    if ( !isalive( ent ) )
    {
        return true;
    }
    
    if ( !isdefined( ent.var_aa63d0150ee15274 ) )
    {
        ent.var_aa63d0150ee15274 = 0;
    }
    
    time = gettime();
    
    if ( ent.var_aa63d0150ee15274 > gettime() )
    {
        return true;
    }
    
    ent.var_aa63d0150ee15274 = time + 250;
    return false;
}

// Namespace ztron_hazard_lawn_mower
// Params 0
// Checksum 0x538b3b1f, Offset: 0x90c
// Size: 0x33
function function_6ae004ca2f6fdaca()
{
    self.objective = objidpoolmanager::createobjective( "hud_icon_minimap_player_enemy_ai", zm_utility::get_zombie_team(), undefined, 1, 1 );
    objidpoolmanager::function_9d4895ed38151e46( self.objective, 1 );
}

// Namespace ztron_hazard_lawn_mower
// Params 4
// Checksum 0xa52826bc, Offset: 0x947
// Size: 0x13d
function run_to_target( target, speed, trigger, var_4e8d6a50d83d5156 )
{
    self endon( #"death" );
    dist = distance2d( self.origin, target.origin );
    new_angles = vectortoangles( target.origin - self.origin );
    rotate_time = absangleclamp180( new_angles[ 1 ] - self.angles[ 1 ] ) / 400;
    
    if ( rotate_time > 0 )
    {
        ztron_sound::ztron_playsound( "ztron_hazard_lawn_mower_rotate", undefined, self );
        self rotateto( new_angles, rotate_time );
        self waittill( #"rotatedone" );
    }
    
    move_time = dist / speed;
    trigger.var_d12598e91b6083d = 1;
    self notify( #"start_mowing" );
    
    if ( var_4e8d6a50d83d5156 > 0 )
    {
        wait var_4e8d6a50d83d5156;
    }
    
    self moveto( target.origin, move_time, 0.5, 0.5 );
    self waittill( #"movedone" );
    trigger.var_d12598e91b6083d = 0;
    self notify( #"stop_mowing" );
}

// Namespace ztron_hazard_lawn_mower
// Params 4
// Checksum 0x5d62923a, Offset: 0xa8c
// Size: 0xd4
function function_3d2cb55c078cae40( mower_path, speed, trigger, var_4e8d6a50d83d5156 = 0 )
{
    self endon( #"death" );
    
    /#
        thread function_6a263aa153f0e590( mower_path );
    #/
    
    target = undefined;
    
    while ( true )
    {
        laps = randomint( 10 );
        
        while ( laps )
        {
            if ( !isdefined( target ) )
            {
                target = mower_path;
            }
            
            dist = distance2d( self.origin, target.origin );
            
            if ( dist >= 50 )
            {
                run_to_target( target, speed, trigger, var_4e8d6a50d83d5156 );
                wait 1;
                laps--;
            }
            else
            {
                waitframe();
            }
            
            target = target.var_88163dd40ed18fac;
        }
        
        wait randomintrange( 3, 5 );
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 0, eflags: 0x4
// Checksum 0x8c49ad6a, Offset: 0xb68
// Size: 0xac
function private function_983b9d28ad5fab80()
{
    self endon( #"death" );
    debris_fx = utility::getfx( "ztron_hazard_lawn_mower_debris" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "start_mowing", "stop_mowing" );
        
        if ( msg == "stop_mowing" )
        {
            stopfxontag( debris_fx, self, "tag_origin" );
            ztron_sound::ztron_stopsound( self );
            ztron_sound::ztron_playsound( "ztron_hazard_lawn_mower_off", undefined, self );
            continue;
        }
        
        if ( msg == "start_mowing" )
        {
            playfxontag( debris_fx, self, "tag_origin" );
            ztron_sound::ztron_playsound( "ztron_hazard_lawn_mower_on", undefined, self );
            ztron_sound::ztron_playsound( "ztron_hazard_lawn_mower_lp", undefined, self );
        }
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 0
// Checksum 0x6d957554, Offset: 0xc1c
// Size: 0xf5
function function_8c8adbd1b4b7578b()
{
    self notify( #"hash_e10ee191537ab52e" );
    self endon( #"hash_e10ee191537ab52e" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    stopfxontag( utility::getfx( "ztron_hazard_lawn_mower_debris" ), self, "tag_origin" );
    wait 0.5;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.mover.objective ) )
    {
        objidpoolmanager::returnobjectiveid( self.mover.objective );
        self.mover.objective = undefined;
    }
    
    if ( isdefined( self.mover ) )
    {
        ztron_sound::ztron_stopsound( self.mover );
        self.mover delete();
        self.mover = undefined;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ztron_hazard_lawn_mower
// Params 1, eflags: 0x4
// Checksum 0xe7811b5b, Offset: 0xd19
// Size: 0x53
function private function_906b71901ebbd19( str )
{
    output = undefined;
    values = strtok( str, "," );
    
    if ( values.size == 3 )
    {
        output = ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
    }
    
    return output;
}

/#

    // Namespace ztron_hazard_lawn_mower
    // Params 1
    // Checksum 0xd3d09f49, Offset: 0xd75
    // Size: 0xbc, Type: dev
    function function_6a263aa153f0e590( path )
    {
        self endon( #"death" );
        path_start = path;
        
        while ( true )
        {
            is_enabled = getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1;
            
            if ( is_enabled )
            {
                current_path_node = path_start;
                
                while ( true )
                {
                    next_path_node = current_path_node.var_88163dd40ed18fac;
                    
                    if ( !isdefined( next_path_node ) )
                    {
                        next_path_node = path_start;
                    }
                    
                    line( current_path_node.origin, next_path_node.origin, ( 0, 1, 0 ), 1 );
                    current_path_node = next_path_node;
                    
                    if ( current_path_node == path_start )
                    {
                        break;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ztron_hazard_lawn_mower
    // Params 1
    // Checksum 0xa025ec88, Offset: 0xe39
    // Size: 0x64, Type: dev
    function function_7e0838d6457f971e( trigger )
    {
        trigger endon( #"death" );
        
        while ( true )
        {
            if ( !isdefined( trigger ) )
            {
                return;
            }
            
            is_enabled = getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1;
            
            if ( is_enabled )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0 );
            }
            
            waitframe();
        }
    }

#/
