// scripts\mp\maps\mp_sat_rm_raid\mp_sat_rm_raid.gsc  (hash_19a4c8a22bcfb7a1.gscc) (size: 4050 Bytes / 0xfd2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf97fc698 (4185900696)
// size ...... 4050 (0xfd2)
// includes .. 11  (offset: 0xe0a)
// strings ... 29  (offset: 0xe62)
// dev strs .. 1   (offset: 0xfc6)
// exports ... 8   (offset: 0x88a)
// cseg ...... 0x213 + 0x677 (0x88a)
// imports ... 36  (offset: 0x9ca)
// animtree1 . 0   (offset: 0xfd2)
// animtree2 . 0   (offset: 0xfd2)
#using script_7787612c171213e1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\active_env\glass_fence;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_raid\gen\mp_sat_rm_raid_art;
#using scripts\mp\maps\mp_sat_rm_raid\mp_sat_rm_raid_fx;
#using scripts\mp\maps\mp_sat_rm_raid\mp_sat_rm_raid_lighting;

#namespace mp_sat_rm_raid;

// Namespace mp_sat_rm_raid
// Params 0
// Checksum 0xd92f254f, Offset: 0x231
// Size: 0x175
function main()
{
    mp_sat_rm_raid_art::main();
    mp_sat_rm_raid_fx::main();
    mp_sat_rm_raid_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_raid" );
    setdvar( @"mount_enable", 1 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvar( @"hash_fbb8d521a6914269", 25 );
    setdvar( @"hash_592417bef799b135", 25 );
    setdvar( @"hash_3bdc2896f05e40ac", 0.5 );
    setdvar( @"hash_37f05b20e6e2b254", 100 );
    setdvar( @"hash_44a9f0f91a98f576", 100 );
    callback::add( #"player_spawn_init", &on_spawn_init );
    level thread glass_fence::init_glass_fence( "sprint" );
    level thread init_spawning_cover();
    level thread init_basketball_game();
    
    if ( game_utility::getgametype() == "benchmark" )
    {
        namespace_5e1a0b922665681b::start();
    }
}

// Namespace mp_sat_rm_raid
// Params 1
// Checksum 0xabefce34, Offset: 0x3ae
// Size: 0xc
function on_spawn_init( params )
{
    
}

// Namespace mp_sat_rm_raid
// Params 0
// Checksum 0x81d9fb0, Offset: 0x3c2
// Size: 0x1d0
function init_spawning_cover()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_3ec3bb552a1449d0 = getxhash( game_utility::getgametype() );
    var_7ee167132265229f = arraycontains( [ #"dom", #"sd", #"dd" ], var_3ec3bb552a1449d0 );
    
    if ( !var_7ee167132265229f )
    {
        return;
    }
    
    var_2e4a9fbba89295cf = getscriptablearray( "spawning_cover", #script_noteworthy );
    var_b05211bb3dba5edc = getentarray( "spawning_cover", #script_noteworthy );
    
    foreach ( scr_spawning_cover in var_2e4a9fbba89295cf )
    {
        scr_spawning_cover setscriptablepartstate( "visibility", "hide", 1 );
        scr_spawning_cover setscriptablepartstate( "rootModelManager", "removed", 1 );
        scr_spawning_cover setcandamage( 0 );
        scr_spawning_cover setscriptablepartstate( "body", "inert", 1 );
    }
    
    foreach ( e_spawning_cover in var_b05211bb3dba5edc )
    {
        if ( e_spawning_cover isscriptable() )
        {
            continue;
        }
        
        e_spawning_cover connectpaths();
        e_spawning_cover delete();
    }
}

// Namespace mp_sat_rm_raid
// Params 0, eflags: 0x4
// Checksum 0x782ba25a, Offset: 0x59a
// Size: 0xf4
function private init_basketball_game()
{
    level endon( #"game_over" );
    utility::flag_wait( "scriptables_ready" );
    var_f33d5783ec686d46 = getentarray( "basketball", #script_noteworthy );
    t_basketball_hoop = getent( "basketball_hoop", #script_noteworthy );
    t_basketball_hoop thread function_2755c9bb83ebc3dd( var_f33d5783ec686d46 );
    
    /#
        if ( getdvar( @"hash_f45012d93444feff", 0 ) )
        {
            t_basketball_hoop thread function_f8a405d0978b21ac();
        }
    #/
    
    foreach ( e_basketball in var_f33d5783ec686d46 )
    {
        e_basketball setcandamage( 1 );
        e_basketball thread function_53b01da71a301bd7();
    }
}

// Namespace mp_sat_rm_raid
// Params 0, eflags: 0x4
// Checksum 0x7dee12c6, Offset: 0x696
// Size: 0x13f
function private function_53b01da71a301bd7()
{
    level endon( #"game_over" );
    
    for ( var_75dead72d84e5a9a = 0; true ; var_75dead72d84e5a9a = 1 )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath );
        
        if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" )
        {
            if ( !var_75dead72d84e5a9a )
            {
                if ( self.targetname == "on_table" )
                {
                    v_forward_direction = ( direction_vec[ 0 ], direction_vec[ 1 ], 0 );
                    v_forward_magnitude = 47.5;
                    var_5f704de2f802c8b4 = ( 0, 0, 1 );
                    var_945c9ced43698297 = 40;
                    v_launch_force = v_forward_direction * v_forward_magnitude + var_5f704de2f802c8b4 * var_945c9ced43698297;
                    self physicslaunchserver( point, v_launch_force );
                }
                else
                {
                    self physicslaunchserver( point, direction_vec * 100 );
                }
            }
            else
            {
                level thread debug_utility::drawline( point, point + direction_vec, 5, ( 0, 1, 0 ) );
                self physicslaunchserver( point, direction_vec * 100 );
            }
            
            continue;
        }
        
        self physicslaunchserver( point, direction_vec );
    }
}

// Namespace mp_sat_rm_raid
// Params 1, eflags: 0x4
// Checksum 0x74c644e8, Offset: 0x7dd
// Size: 0x81
function private function_2755c9bb83ebc3dd( var_f33d5783ec686d46 )
{
    level endon( #"game_over" );
    
    while ( true )
    {
        for ( i = 0; i < var_f33d5783ec686d46.size ; i++ )
        {
            if ( distancesquared( self.origin, var_f33d5783ec686d46[ i ].origin ) < 100 )
            {
                if ( self istouching( var_f33d5783ec686d46[ i ] ) )
                {
                    /#
                        iprintlnbold( "<dev string:x24>" );
                    #/
                    
                    self playsound( "evt_bball_cheer" );
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace mp_sat_rm_raid
    // Params 0, eflags: 0x4
    // Checksum 0xf74fa06c, Offset: 0x866
    // Size: 0x24, Type: dev
    function private function_f8a405d0978b21ac()
    {
        level endon( #"game_over" );
        
        while ( true )
        {
            drawtrigger( self, undefined, undefined, 1 );
            waitframe();
        }
    }

#/
