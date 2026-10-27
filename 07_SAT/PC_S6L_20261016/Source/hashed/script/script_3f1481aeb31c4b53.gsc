// script_3f1481aeb31c4b53  (hash_3f1481aeb31c4b53.gscc) (size: 4051 Bytes / 0xfd3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96bb1fb2 (2528845746)
// size ...... 4051 (0xfd3)
// includes .. 8   (offset: 0xeaf)
// strings ... 17  (offset: 0xeef)
// dev strs .. 0   (offset: 0xfd3)
// exports ... 11  (offset: 0x7ef)
// cseg ...... 0x147 + 0x6a8 (0x7ef)
// imports ... 45  (offset: 0x9a7)
// animtree1 . 0   (offset: 0xfd3)
// animtree2 . 0   (offset: 0xfd3)
#using script_7574fdd29cd7dec6;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;

#namespace ztron_hazard_specter;

// Namespace ztron_hazard_specter
// Params 0, eflags: 0x5
// Checksum 0x65afe8a7, Offset: 0x165
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_specter", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_specter
// Params 0
// Checksum 0x36dc5119, Offset: 0x18e
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"specter", #"create", &create_specter );
    ztron_hazard::function_6f661fac5fd31f1( #"specter", #"arenaspawn", &init_hazard_specter );
}

// Namespace ztron_hazard_specter
// Params 0
// Checksum 0x49f2b847, Offset: 0x1d4
// Size: 0x9c
function init_hazard_specter()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "specter" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        create_specter( var_4d080f710fb8349e );
    }
}

// Namespace ztron_hazard_specter
// Params 2
// Checksum 0xdd7a4e49, Offset: 0x278
// Size: 0x27
function create_specter( specter_struct, paged )
{
    ztron_hazard_lawn_mower::function_748a05ca5065be6( specter_struct );
    thread function_960e89041016978d( specter_struct );
}

// Namespace ztron_hazard_specter
// Params 1, eflags: 0x4
// Checksum 0xf607fb65, Offset: 0x2a7
// Size: 0x25e
function private function_960e89041016978d( specter_struct )
{
    if ( isdefined( specter_struct.var_433b0194464a5e86 ) )
    {
        return;
    }
    
    speed = 70;
    scriptable_name = "ztron_specter";
    trigger_radius = 30;
    trigger_height = 65;
    
    if ( isdefined( specter_struct.script_parameters ) )
    {
        args = strtok( specter_struct.script_parameters, ";" );
        
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
    
    specter_path = specter_struct;
    angles = vectortoangles( specter_path.var_88163dd40ed18fac.origin - specter_path.origin );
    scriptable = spawnscriptable( scriptable_name, specter_struct.origin, angles );
    
    if ( isdefined( scriptable ) )
    {
        mover = spawn( "script_model", specter_struct.origin );
        mover.angles = angles;
        mover setmodel( "tag_origin" );
        mover.script_noteworthy = "ztron_hazard_specter";
        waitframe();
        scriptable scriptablesetparententity( mover );
        trigger = spawn( "trigger_radius", ( 0, 0, 0 ), 0, trigger_radius, trigger_height );
        
        if ( !isdefined( trigger ) )
        {
            scriptable freescriptable();
            return;
        }
        
        trigger enablelinkto();
        trigger.angles = angles;
        trigger.origin = specter_struct.origin;
        trigger.owner = mover;
        trigger.isoneshot = 1;
        specter_struct.trigger = trigger;
        scriptable.trigger = trigger;
        trigger linkto( mover, "tag_origin" );
        scriptable.mover = mover;
        mover ztron_hazard_lawn_mower::function_6ae004ca2f6fdaca();
        mover thread function_87b1b49f2c6d2a4a( scriptable );
        trigger thread function_fb444350125677ff();
        mover thread ztron_hazard_lawn_mower::function_3d2cb55c078cae40( specter_path, speed, trigger, 1.5 );
        scriptable thread function_9b80cfe651e2324a();
    }
}

// Namespace ztron_hazard_specter
// Params 1, eflags: 0x4
// Checksum 0x1f2c4d8, Offset: 0x50d
// Size: 0xae
function private function_87b1b49f2c6d2a4a( scriptable )
{
    self endon( #"death" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "start_mowing", "stop_mowing", "rotatedone" );
        
        if ( msg == "start_mowing" || msg == "rotatedone" )
        {
            scriptable setscriptablepartstate( "visual", "activated" );
            objidpoolmanager::objective_playermask_showtoallplayers( self.objective );
            continue;
        }
        
        if ( msg == "stop_mowing" )
        {
            scriptable setscriptablepartstate( "visual", "hidden" );
            objidpoolmanager::objective_playermask_hidefromallplayers( self.objective );
            continue;
        }
    }
}

// Namespace ztron_hazard_specter
// Params 0, eflags: 0x4
// Checksum 0x79796834, Offset: 0x5c3
// Size: 0xbc
function private function_fb444350125677ff()
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
        
        if ( isplayer( ent ) )
        {
            ent dodamage( abs( ent.health ) + 100, ent.origin, self );
            ent playrumbleonentity( "damage_light" );
            continue;
        }
        
        if ( ent ztron_enemy_ai::iszombie() )
        {
            stun_duration = randomfloatrange( 2, 3 );
            ent zombie_stun::stun_ai( stun_duration );
            ent thread function_b9e4e193b90b5777( stun_duration );
        }
    }
}

// Namespace ztron_hazard_specter
// Params 1, eflags: 0x4
// Checksum 0xb3b2119e, Offset: 0x687
// Size: 0x37
function private function_b9e4e193b90b5777( duration )
{
    utility::function_32b24db3127bff40( "stunned", "stunned_on" );
    wait duration + 0.25;
    utility::function_32b24db3127bff40( "stunned", "stunned_off" );
}

// Namespace ztron_hazard_specter
// Params 0
// Checksum 0x7c0717fd, Offset: 0x6c6
// Size: 0xd6
function function_9b80cfe651e2324a()
{
    self notify( #"hash_6bd02279b242b6e4" );
    self endon( #"hash_6bd02279b242b6e4" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    thread roundendwatcher();
    self waittill( #"destroy_hazard" );
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
        self.mover delete();
        self.mover = undefined;
    }
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

// Namespace ztron_hazard_specter
// Params 0
// Checksum 0x768f1e63, Offset: 0x7a4
// Size: 0x4b
function roundendwatcher()
{
    self notify( #"hash_5a8944053cbfff80" );
    self endon( #"hash_5a8944053cbfff80" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    level waittill( #"round_over" );
    self notify( #"destroy_hazard" );
}

