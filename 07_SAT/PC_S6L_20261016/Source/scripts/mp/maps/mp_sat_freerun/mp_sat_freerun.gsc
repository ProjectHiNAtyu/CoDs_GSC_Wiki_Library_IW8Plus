// scripts\mp\maps\mp_sat_freerun\mp_sat_freerun.gsc  (hash_2d3b42759bec960f.gscc) (size: 3487 Bytes / 0xd9f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19cf7676 (433026678)
// size ...... 3487 (0xd9f)
// includes .. 8   (offset: 0xc53)
// strings ... 19  (offset: 0xc93)
// dev strs .. 0   (offset: 0xd9f)
// exports ... 6   (offset: 0x893)
// cseg ...... 0x190 + 0x703 (0x893)
// imports ... 23  (offset: 0x983)
// animtree1 . 0   (offset: 0xd9f)
// animtree2 . 0   (offset: 0xd9f)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_freerun\gen\mp_sat_freerun_art;
#using scripts\mp\maps\mp_sat_freerun\mp_sat_freerun_fx;
#using scripts\mp\maps\mp_sat_freerun\mp_sat_freerun_lighting;

#namespace mp_sat_freerun;

// Namespace mp_sat_freerun
// Params 0
// Checksum 0x98db1d16, Offset: 0x1ae
// Size: 0x7d
function main()
{
    mp_sat_freerun_art::main();
    mp_sat_freerun_fx::main();
    mp_sat_freerun_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_freerun" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread moving_platforms::moving_platforms_init();
}

// Namespace mp_sat_freerun
// Params 0
// Checksum 0x73bbd0ea, Offset: 0x233
// Size: 0x286
function setup_moving_platforms()
{
    wait 5;
    var_7a4eb683645a5cc = getentarray( "moving_platform", "script_noteworthy" );
    
    foreach ( var_6fc4896145e591cd in var_7a4eb683645a5cc )
    {
        if ( isdefined( var_6fc4896145e591cd.target ) )
        {
            utility::register_moving_platform_ent( var_6fc4896145e591cd );
            var_6fc4896145e591cd setmovingplatformdef( "movingplatform_noairtrack" );
            var_6fc4896145e591cd.destination = utility::getstruct( var_6fc4896145e591cd.target, "targetname" );
            level thread function_2db46bf6fc01f39b( var_6fc4896145e591cd );
        }
    }
    
    var_3ba80855e6482009 = getentarray( "moving_platform_rotator", "script_noteworthy" );
    
    foreach ( var_6fc4896145e591cd in var_3ba80855e6482009 )
    {
        utility::register_moving_platform_ent( var_6fc4896145e591cd );
        var_6fc4896145e591cd setmovingplatformdef( "movingplatform_noairtrack" );
        level thread move_platform_rotator( var_6fc4896145e591cd );
    }
    
    var_8dffa1456d97786a = getentarray( "animObj", "targetname" );
    
    foreach ( var_6fc4896145e591cd in var_8dffa1456d97786a )
    {
        utility::register_moving_platform_ent( var_6fc4896145e591cd );
        var_6fc4896145e591cd setmovingplatformdef( "movingplatform_noairtrack" );
    }
    
    var_5e7a865f0f9671de = getentarray( "moving_platform_trigger", "script_noteworthy" );
    
    foreach ( e_platformtrigger in var_5e7a865f0f9671de )
    {
        level trigger::makeenterexittrigger( e_platformtrigger, &moving_platform_trigger );
    }
}

// Namespace mp_sat_freerun
// Params 1
// Checksum 0xf32a740a, Offset: 0x4c1
// Size: 0x201
function function_2db46bf6fc01f39b( var_6fc4896145e591cd )
{
    level endon( #"game_ended" );
    n_startdelay = var_6fc4896145e591cd.script_delay;
    
    if ( !isdefined( n_startdelay ) )
    {
        n_startdelay = 0;
    }
    
    n_loopdelay = var_6fc4896145e591cd.script_wait;
    
    if ( !isdefined( n_loopdelay ) )
    {
        n_loopdelay = 0;
    }
    
    var_e661c6e9ff6f1059 = var_6fc4896145e591cd.script_speed;
    
    if ( !isdefined( var_e661c6e9ff6f1059 ) )
    {
        var_e661c6e9ff6f1059 = 0;
    }
    
    var_283b6edd23a960d9 = var_6fc4896145e591cd.script_timeout;
    
    if ( !isdefined( var_283b6edd23a960d9 ) )
    {
        var_283b6edd23a960d9 = 0;
    }
    
    var_4e1fa452e5a0c383 = 0;
    var_5240014eea17ad70 = 0;
    wait n_startdelay;
    
    while ( true )
    {
        var_55d6f7109a4c262b = var_283b6edd23a960d9;
        
        if ( var_55d6f7109a4c262b == 0 )
        {
            var_55d6f7109a4c262b = abs( distance( var_6fc4896145e591cd.origin, var_6fc4896145e591cd.destination.origin ) ) / var_e661c6e9ff6f1059;
        }
        
        if ( var_55d6f7109a4c262b != 0 )
        {
            var_6fc4896145e591cd moveto( var_6fc4896145e591cd.destination.origin, var_55d6f7109a4c262b, var_4e1fa452e5a0c383, var_5240014eea17ad70 );
            
            if ( var_6fc4896145e591cd.destination.script_noteworthy == "rotate" )
            {
                var_6fc4896145e591cd rotateto( vectortoangles( var_6fc4896145e591cd.destination.origin - var_6fc4896145e591cd.origin ), var_55d6f7109a4c262b / 10 );
            }
            
            wait var_55d6f7109a4c262b + n_loopdelay;
            
            if ( var_6fc4896145e591cd.destination.script_noteworthy == "teleport" )
            {
                var_6fc4896145e591cd.destination = utility::getstruct( var_6fc4896145e591cd.destination.target, "targetname" );
                var_6fc4896145e591cd.origin = var_6fc4896145e591cd.destination.origin;
            }
        }
        
        var_6fc4896145e591cd.destination = utility::getstruct( var_6fc4896145e591cd.destination.target, "targetname" );
    }
}

// Namespace mp_sat_freerun
// Params 1
// Checksum 0xe269ebb, Offset: 0x6ca
// Size: 0x74
function move_platform_rotator( var_6fc4896145e591cd )
{
    level endon( #"game_ended" );
    var_4ac5227b58bdf660 = var_6fc4896145e591cd.script_rotation_amount;
    
    if ( !isdefined( var_4ac5227b58bdf660 ) )
    {
        var_4ac5227b58bdf660 = ( 0, 360, 0 );
    }
    
    n_rotationtime = var_6fc4896145e591cd.script_speed;
    
    if ( !isdefined( n_rotationtime ) )
    {
        n_rotationtime = 0;
    }
    
    while ( true )
    {
        var_6fc4896145e591cd rotateby( var_4ac5227b58bdf660, n_rotationtime );
        wait n_rotationtime;
    }
}

// Namespace mp_sat_freerun
// Params 2, eflags: 0x4
// Checksum 0x21861d33, Offset: 0x746
// Size: 0x14d
function private moving_platform_trigger( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) && isalive( var_fd3a9f9e9a2a06c2 ) )
    {
        var_731647e2320d5afe = getentarray( trigger.target, "targetname" );
        
        foreach ( var_6fc4896145e591cd in var_731647e2320d5afe )
        {
            s_targetlocation = utility::getstruct( var_6fc4896145e591cd.target, "targetname" );
            n_startdelay = var_6fc4896145e591cd.script_delay;
            
            if ( !isdefined( n_startdelay ) )
            {
                n_startdelay = 0;
            }
            
            var_e661c6e9ff6f1059 = var_6fc4896145e591cd.script_speed;
            
            if ( !isdefined( var_e661c6e9ff6f1059 ) )
            {
                var_e661c6e9ff6f1059 = 0;
            }
            
            wait n_startdelay;
            var_55d6f7109a4c262b = abs( distance( var_6fc4896145e591cd.origin, s_targetlocation.origin ) ) / var_e661c6e9ff6f1059;
            var_6fc4896145e591cd moveto( s_targetlocation.origin, var_55d6f7109a4c262b, 0, 0 );
        }
    }
}

