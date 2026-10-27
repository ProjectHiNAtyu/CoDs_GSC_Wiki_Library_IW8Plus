// script_6386400ab764805e  (hash_6386400ab764805e.gscc) (size: 2972 Bytes / 0xb9c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd30ad01 (3710954753)
// size ...... 2972 (0xb9c)
// includes .. 5   (offset: 0xb34)
// strings ... 5   (offset: 0xb5c)
// dev strs .. 0   (offset: 0xb9c)
// exports ... 9   (offset: 0x6b0)
// cseg ...... 0xc4 + 0x5ec (0x6b0)
// imports ... 27  (offset: 0x818)
// animtree1 . 0   (offset: 0xb9c)
// animtree2 . 0   (offset: 0xb9c)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_conveyor_belt;

// Namespace ztron_hazard_conveyor_belt
// Params 0, eflags: 0x5
// Checksum 0xaf4fa7ac, Offset: 0xe2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_conveyor_belt", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_conveyor_belt
// Params 0
// Checksum 0x373c91b4, Offset: 0x10b
// Size: 0x51
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"conveyor_belt", #"create", &function_a20f047ce129dc07 );
    ztron_hazard::function_6f661fac5fd31f1( #"conveyor_belt", #"arenaspawn", &function_4a94df93a5d17d9d );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_conveyor_belt_lp", "amb_ztron_conveyor_belt_lp", 1 );
}

// Namespace ztron_hazard_conveyor_belt
// Params 2
// Checksum 0x88a15223, Offset: 0x164
// Size: 0xae
function function_a20f047ce129dc07( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_a736e6b117a099c9[ level.ztron.var_a736e6b117a099c9.size ] = trap;
        return;
    }
    
    target = utility::getstruct( trap.target, "targetname" );
    trap.target_point = target.origin;
    trap.moving_speed = float( trap.script_parameters );
    function_a514f11da84ae618( trap, page );
}

// Namespace ztron_hazard_conveyor_belt
// Params 0
// Checksum 0xae731083, Offset: 0x21a
// Size: 0xb1
function function_4a94df93a5d17d9d()
{
    level.ztron.var_a736e6b117a099c9 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "conveyor_belt" );
    
    foreach ( trap in traps )
    {
        function_a20f047ce129dc07( trap );
    }
}

// Namespace ztron_hazard_conveyor_belt
// Params 2
// Checksum 0xf3cdd574, Offset: 0x2d3
// Size: 0x1df
function function_a514f11da84ae618( trap, paged = 0 )
{
    var_4d080f710fb8349e = spawnstruct();
    var_4d080f710fb8349e.start_point = trap.origin;
    var_4d080f710fb8349e.end_point = trap.target_point;
    dir = vectornormalize( var_4d080f710fb8349e.end_point - var_4d080f710fb8349e.start_point );
    var_4d080f710fb8349e.angles = vectortoangles( dir );
    var_4d080f710fb8349e.moving_time = length( var_4d080f710fb8349e.end_point - var_4d080f710fb8349e.start_point ) / trap.moving_speed;
    var_4d080f710fb8349e.interval = 128 / length( var_4d080f710fb8349e.end_point - var_4d080f710fb8349e.start_point ) * var_4d080f710fb8349e.moving_time;
    var_4d080f710fb8349e.moving_models = [];
    count = floor( length( var_4d080f710fb8349e.end_point - var_4d080f710fb8349e.start_point ) / 128 );
    
    for ( i = 0; i <= count ; i++ )
    {
        spawn_point = trap.origin + 128 * i * dir;
        var_4d080f710fb8349e thread function_a9dfaab8de20f2a5( spawn_point );
    }
    
    trap thread function_2b9b6e25729a49b5( var_4d080f710fb8349e );
    trap.script_model = var_4d080f710fb8349e;
    trap.tag_origin = utility::spawn_model( "tag_origin", trap.origin, trap.angles );
    ztron_sound::ztron_playsound( "ztron_hazard_conveyor_belt_lp", undefined, trap.tag_origin );
    trap.paged = paged;
}

// Namespace ztron_hazard_conveyor_belt
// Params 1
// Checksum 0xe51b4406, Offset: 0x4ba
// Size: 0xc5
function function_a9dfaab8de20f2a5( spawnpoint )
{
    self endon( #"destroy_hazard" );
    moving_time = length( self.end_point - spawnpoint ) / length( self.end_point - self.start_point ) * self.moving_time;
    model = utility::spawn_model( %"decor_dock_platform_64x128_ztron", spawnpoint, self.angles );
    self.moving_models[ self.moving_models.size ] = model;
    model moveto( self.end_point, moving_time );
    wait moving_time;
    self.moving_models = arrayremove( self.moving_models, model );
    model delete();
}

// Namespace ztron_hazard_conveyor_belt
// Params 1
// Checksum 0x77990fe8, Offset: 0x587
// Size: 0xd6
function function_820c09fa705342de( trap )
{
    self endon( #"death" );
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    ztron_sound::ztron_stopsound( trap.tag_origin );
    wait 0.5;
    
    foreach ( model in self.moving_models )
    {
        model delete();
    }
    
    trap.script_model = undefined;
    trap.tag_origin delete();
}

// Namespace ztron_hazard_conveyor_belt
// Params 1
// Checksum 0x6de87294, Offset: 0x665
// Size: 0x4b
function function_2b9b6e25729a49b5( var_4d080f710fb8349e )
{
    var_4d080f710fb8349e endon( #"destroy_hazard" );
    var_4d080f710fb8349e thread function_820c09fa705342de( self );
    
    while ( true )
    {
        wait var_4d080f710fb8349e.interval;
        var_4d080f710fb8349e thread function_a9dfaab8de20f2a5( var_4d080f710fb8349e.start_point );
    }
}

