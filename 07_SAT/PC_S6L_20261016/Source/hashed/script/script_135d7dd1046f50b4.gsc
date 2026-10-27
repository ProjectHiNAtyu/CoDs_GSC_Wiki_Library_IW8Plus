// script_135d7dd1046f50b4  (hash_135d7dd1046f50b4.gscc) (size: 3047 Bytes / 0xbe7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b0937be (990459838)
// size ...... 3047 (0xbe7)
// includes .. 5   (offset: 0xb0b)
// strings ... 13  (offset: 0xb33)
// dev strs .. 0   (offset: 0xbe7)
// exports ... 8   (offset: 0x653)
// cseg ...... 0x10f + 0x544 (0x653)
// imports ... 31  (offset: 0x793)
// animtree1 . 0   (offset: 0xbe7)
// animtree2 . 0   (offset: 0xbe7)
#using script_7574fdd29cd7dec6;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;

#namespace namespace_e884d12a81114c3c;

// Namespace namespace_e884d12a81114c3c
// Params 0, eflags: 0x5
// Checksum 0x221a4e90, Offset: 0x12d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_fa393f5532630815", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_e884d12a81114c3c
// Params 0
// Checksum 0x7b5d8717, Offset: 0x156
// Size: 0x20
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"rats_horde", #"create", &create_rats_horde );
}

// Namespace namespace_e884d12a81114c3c
// Params 2
// Checksum 0x9a6476cb, Offset: 0x17e
// Size: 0x27
function create_rats_horde( hazard_struct, paged )
{
    ztron_hazard_lawn_mower::function_748a05ca5065be6( hazard_struct );
    thread function_d7d5c6da944dee0a( hazard_struct );
}

// Namespace namespace_e884d12a81114c3c
// Params 1, eflags: 0x4
// Checksum 0xdca0178f, Offset: 0x1ad
// Size: 0x27c
function private function_d7d5c6da944dee0a( hazard_struct )
{
    speed = hazard_struct.speed ?? 150;
    scriptable_name = hazard_struct.scriptable_name ?? "ztron_rats_horde";
    trigger_radius = hazard_struct.trigger_radius ?? 30;
    trigger_height = hazard_struct.trigger_height ?? 30;
    
    if ( isdefined( hazard_struct.script_parameters ) )
    {
        args = strtok( hazard_struct.script_parameters, ";" );
        
        if ( args.size >= 1 )
        {
            speed = float( args[ 0 ] );
        }
        
        if ( args.size >= 2 )
        {
            scriptable_name = args[ 1 ];
        }
        
        if ( args.size >= 3 )
        {
            trigger_radius = float( args[ 2 ] );
        }
        
        if ( args.size >= 4 )
        {
            trigger_height = float( args[ 3 ] );
        }
    }
    
    hazard_path = hazard_struct;
    angles = vectortoangles( hazard_path.var_88163dd40ed18fac.origin - hazard_path.origin );
    scriptable = spawnscriptable( scriptable_name, hazard_struct.origin, angles );
    hazard_struct.scriptable = scriptable;
    mover = spawn( "script_model", hazard_struct.origin );
    mover.angles = angles;
    mover setmodel( "tag_origin" );
    hazard_struct.mover = mover;
    mover.script_noteworthy = "hazard_rat";
    waitframe();
    scriptable scriptablesetparententity( mover );
    trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, trigger_radius, trigger_height );
    trigger.owner = mover;
    trigger enablelinkto();
    trigger.angles = angles;
    trigger.origin = hazard_path.origin;
    trigger linkto( mover, "tag_origin" );
    hazard_struct.trigger = trigger;
    hazard_struct thread function_dedf2c0e06a84c21();
    trigger thread function_7dab09eef0930ebe();
    var_4e8d6a50d83d5156 = hazard_struct.var_4e8d6a50d83d5156 ?? 1.5;
    mover thread ztron_hazard_lawn_mower::run_to_target( hazard_path.var_88163dd40ed18fac, speed, trigger, var_4e8d6a50d83d5156 );
    hazard_struct thread function_65b907ef2d061d81();
}

// Namespace namespace_e884d12a81114c3c
// Params 0, eflags: 0x4
// Checksum 0xa0b6ac, Offset: 0x431
// Size: 0x8c
function private function_7dab09eef0930ebe()
{
    self endon( #"death" );
    
    /#
        thread ztron_hazard_lawn_mower::function_7e0838d6457f971e( self );
    #/
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ztron_hazard_lawn_mower::filter_trigger_func( ent ) )
        {
            continue;
        }
        
        if ( isplayer( ent ) && isdefined( ent.ztron.vehicle ) )
        {
            continue;
        }
        
        if ( isagent( ent ) || isplayer( ent ) )
        {
            ent thread ztron_enemy_ai::function_bc65bed6aed12009( 3 );
        }
    }
}

// Namespace namespace_e884d12a81114c3c
// Params 0, eflags: 0x4
// Checksum 0xf111e96b, Offset: 0x4c5
// Size: 0xad
function private function_dedf2c0e06a84c21()
{
    mover = self.mover;
    scriptable = self.scriptable;
    mover endon( #"death" );
    
    while ( true )
    {
        msg = mover utility::waittill_any_return( "start_mowing", "stop_mowing", "rotatedone" );
        
        if ( msg == "start_mowing" || msg == "rotatedone" )
        {
            scriptable setscriptablepartstate( "visual", "activated" );
            continue;
        }
        
        if ( msg == "stop_mowing" )
        {
            scriptable setscriptablepartstate( "visual", "hidden" );
            continue;
        }
    }
}

// Namespace namespace_e884d12a81114c3c
// Params 0
// Checksum 0x927de229, Offset: 0x57a
// Size: 0xd9
function function_65b907ef2d061d81()
{
    self notify( #"hash_1bd70aa69965fa75" );
    self endon( #"hash_1bd70aa69965fa75" );
    self.mover thread ztron_hazard::function_4d643b159a80c647( 1 );
    self.mover utility::waittill_any( "destroy_hazard", "stop_mowing" );
    wait 0.5;
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
        self.scriptable = undefined;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.mover ) )
    {
        self.mover delete();
        self.mover = undefined;
    }
    
    self.trigger_radius = undefined;
    self.trigger_height = undefined;
    self.speed = undefined;
}

