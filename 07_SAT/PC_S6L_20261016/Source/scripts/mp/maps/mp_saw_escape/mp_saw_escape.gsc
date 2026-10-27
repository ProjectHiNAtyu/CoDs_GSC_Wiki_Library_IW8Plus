// scripts\mp\maps\mp_saw_escape\mp_saw_escape.gsc  (hash_0d46c06f20f04d55.gscc) (size: 4333 Bytes / 0x10ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49051057 (1225068631)
// size ...... 4333 (0x10ed)
// includes .. 10  (offset: 0xf01)
// strings ... 32  (offset: 0xf51)
// dev strs .. 0   (offset: 0x10ed)
// exports ... 9   (offset: 0x90d)
// cseg ...... 0x2cd + 0x640 (0x90d)
// imports ... 38  (offset: 0xa75)
// animtree1 . 0   (offset: 0x10ed)
// animtree2 . 0   (offset: 0x10ed)
#using script_4a7080e904a6380e;
#using script_75b994f10201e95c;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_saw_escape\mp_saw_escape_br;
#using scripts\mp\poi;

#namespace mp_saw_escape;

// Namespace mp_saw_escape
// Params 1
// Checksum 0xe12bb8ff, Offset: 0x2eb
// Size: 0x1a3
function main( compassmaterial = "compass_map_mp_saw_escape" )
{
    load::main();
    compass::setupminimap( compassmaterial );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread poi::poi_init();
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    }
    
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    game_utility::registerlargemap();
    
    if ( isbrgamemode() )
    {
        namespace_7c8dc82f895d98fe::init();
    }
    else
    {
        setgameprops( "mp_saw_escape" );
    }
    
    if ( br_public::function_73870bd0a4e2894d() )
    {
        thread gondola_movement();
    }
    
    setdvar( @"hash_27b71e290f8781e1", 800 );
    setdvar( @"hash_27db10290fafddcf", 1900 );
    activatelocation = utility::getstruct( "br_bot_activate_location", "script_noteworthy" );
    var_7dc27bc9fa62c763 = activatelocation.origin ?? ( -4547, 11372, 50 );
    var_d094491947d7985 = ( 603, 2705, 1306 );
    super_bot::function_71585fa0eb269a5f( var_7dc27bc9fa62c763, var_d094491947d7985 );
    utility::registersharedfunc( #"mood", #"onsetupmoodset", &onsetupmoodset );
    utility::registersharedfunc( #"map", #"hash_b4fafa9d5f310a7e", &function_627fb43f841ec021 );
    thread function_c598b92275ee9077();
}

// Namespace mp_saw_escape
// Params 2
// Checksum 0x3ac0c9ee, Offset: 0x496
// Size: 0x3b, Type: bool
function function_627fb43f841ec021( player, equipmentpos )
{
    if ( player.var_3a1332c58768a3b )
    {
        return true;
    }
    
    return equipmentpos && ispointinvolume( equipmentpos, level.gondola_trigger );
}

// Namespace mp_saw_escape
// Params 1
// Checksum 0xeef71c2e, Offset: 0x4da
// Size: 0x45
function onsetupmoodset( moods )
{
    if ( getdvarint( @"hash_67381dc877d1c2b1", 1 ) == 1 )
    {
        thread namespace_8cdbb6d4564d9fae::function_6db1c08954c39c65( moods[ moods.size - 1 ].state.data, undefined );
    }
}

// Namespace mp_saw_escape
// Params 0
// Checksum 0x18d3412b, Offset: 0x527
// Size: 0x256
function gondola_movement()
{
    level endon( #"game_ended" );
    waitframe();
    var_3186012184f4f256 = 13;
    gondola_idle_time = 8;
    gondola_accel_time = 3;
    gondola_decel_time = 3;
    gondola_lift = getent( "gondola_lift", #targetname );
    gondola_lift function_dc61b81ec6b63cc4( 1 );
    gondola_lift_gears = getent( "gondola_lift_gears", #targetname );
    gondola_lift_gears function_dc61b81ec6b63cc4( 1 );
    gondola_collision = getent( "gondola_collision", #targetname );
    gondola_collision function_dc61b81ec6b63cc4( 1 );
    gondola_trigger = getent( "gondola_trigger", #targetname );
    gondola_lift setmoverantilagged( 1 );
    utility::register_moving_platform_ent( gondola_lift );
    utility::register_moving_platform_ent( gondola_lift_gears );
    utility::register_moving_platform_ent( gondola_collision );
    gondola_lift_gears linkto( gondola_lift );
    gondola_collision linkto( gondola_lift );
    gondola_trigger enablelinkto();
    gondola_trigger linkto( gondola_lift );
    thread function_c6242e9bef11507a( gondola_lift );
    trigger::makeenterexittrigger( gondola_trigger, &gondola_trigger_enter, &gondola_trigger_exit );
    level.gondola_trigger = gondola_trigger;
    gondola_down = utility::getstruct( "gondola_start", "targetname" );
    gondola_up = utility::getstruct( "gondola_end", "targetname" );
    
    while ( true )
    {
        level notify( #"gondola_reset" );
        wait gondola_idle_time;
        playsoundatpos( ( 4447, 310, 627 ), "sfx_escape2_gondola_motor_start_dock" );
        playsoundatpos( ( 858, 342, 2038 ), "sfx_escape2_gondola_motor_start_prison" );
        gondola_lift_gears setscriptablepartstate( "sfx", "sfx_escape2_gondola_UP" );
        gondola_lift moveto( gondola_up.origin, var_3186012184f4f256, gondola_accel_time, gondola_decel_time );
        wait var_3186012184f4f256;
        gondola_lift setscriptablepartstate( "sfx", "sfx_escape2_gondola_arrived_UP" );
        wait gondola_idle_time;
        playsoundatpos( ( 4447, 310, 627 ), "sfx_escape2_gondola_motor_start_dock" );
        playsoundatpos( ( 858, 342, 2038 ), "sfx_escape2_gondola_motor_start_prison" );
        gondola_lift_gears setscriptablepartstate( "sfx", "sfx_escape2_gondola_DOWN" );
        gondola_lift moveto( gondola_down.origin, var_3186012184f4f256, gondola_accel_time, gondola_decel_time );
        wait var_3186012184f4f256;
        gondola_lift setscriptablepartstate( "sfx", "sfx_escape2_gondola_arrived_DOWN" );
    }
}

// Namespace mp_saw_escape
// Params 1
// Checksum 0x2c0a4460, Offset: 0x785
// Size: 0x36
function function_c6242e9bef11507a( gondola )
{
    level endon( #"game_ended" );
    level waittill( #"infils_ready" );
    gondola setscriptablepartstate( "icon", "visible" );
}

// Namespace mp_saw_escape
// Params 2
// Checksum 0xd4e3ee40, Offset: 0x7c3
// Size: 0x3d
function gondola_trigger_enter( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        ent setclienttriggeraudiozone( "escape2_ext_gondola", 0.2 );
        ent.var_3a1332c58768a3b = 1;
    }
}

// Namespace mp_saw_escape
// Params 2
// Checksum 0x47fcfdff, Offset: 0x808
// Size: 0x3f
function gondola_trigger_exit( ent, trigger )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isplayer( ent ) )
    {
        return;
    }
    
    ent clearclienttriggeraudiozone( 0.2 );
    ent.var_3a1332c58768a3b = undefined;
}

// Namespace mp_saw_escape
// Params 0, eflags: 0x4
// Checksum 0x1ad821ef, Offset: 0x84f
// Size: 0xbe
function private function_c598b92275ee9077()
{
    if ( !getdvarint( @"hash_c49dd30f361eb8f7", 0 ) )
    {
        return;
    }
    
    level waittill( #"scriptables_ready" );
    var_6e17861cfb646f99 = getentitylessscriptablearray( "codmas_set_dress", #targetname );
    
    foreach ( var_c80c57895f7af370 in var_6e17861cfb646f99 )
    {
        var_c80c57895f7af370 setscriptablepartstate( var_c80c57895f7af370.type, "visible" );
    }
}

