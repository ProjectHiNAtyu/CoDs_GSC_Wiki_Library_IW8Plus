// scripts\mp\maps\mp_sat_enigma\mp_sat_enigma.gsc  (hash_05ce0088b9c98ef5.gscc) (size: 2983 Bytes / 0xba7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a2fcc39 (1513081913)
// size ...... 2983 (0xba7)
// includes .. 10  (offset: 0xa7b)
// strings ... 18  (offset: 0xacb)
// dev strs .. 0   (offset: 0xba7)
// exports ... 8   (offset: 0x5fb)
// cseg ...... 0x164 + 0x497 (0x5fb)
// imports ... 29  (offset: 0x73b)
// animtree1 . 0   (offset: 0xba7)
// animtree2 . 0   (offset: 0xba7)
#using scripts\common\active_env\portals;
#using scripts\common\active_env\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_enigma\gen\mp_sat_enigma_art;
#using scripts\mp\maps\mp_sat_enigma\mp_sat_enigma_fx;
#using scripts\mp\maps\mp_sat_enigma\mp_sat_enigma_lighting;

#namespace mp_sat_enigma;

// Namespace mp_sat_enigma
// Params 0
// Checksum 0x81a89043, Offset: 0x182
// Size: 0x13e
function main()
{
    mp_sat_enigma_art::main();
    namespace_145704a8722b5d9b::main();
    mp_sat_enigma_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_1094bbb6422bd39a = 1;
    compass::setupminimap( "compass_map_mp_sat_enigma" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    namespace_491847e095ef9a1d::portals_init();
    level thread machete_anim();
    
    /#
        level thread update_dev();
    #/
    
    callback::add( #"player_death", &on_player_death );
    weaponfilter = [ #"dawg":1, #"missile_turret":1, #"remote_turret":1 ];
    utility::setup_no_deploy_zones( weaponfilter );
}

// Namespace mp_sat_enigma
// Params 0, eflags: 0x4
// Checksum 0x8e197ca2, Offset: 0x2c8
// Size: 0x75
function private update_dev()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarfloat( @"hash_38dd5ea6c6100ebd", 0 ) > 0 )
        {
            var_6a3a8db71dbfe9f4 = getdvarfloat( @"hash_38dd5ea6c6100ebd" );
            setdvar( @"hash_38dd5ea6c6100ebd", 0 );
            
            if ( level.var_c8d6604369d16df5 )
            {
                level thread machete_anim( 0, var_6a3a8db71dbfe9f4 );
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_enigma
// Params 2, eflags: 0x4
// Checksum 0xa1f4c7ba, Offset: 0x345
// Size: 0x1fd
function private machete_anim( n_set_delay = undefined, n_set_interval = undefined )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    level.var_c8d6604369d16df5 = 0;
    var_455207c226282e7a = level.prematchperiodend <= 0;
    
    if ( game_utility_mp::isfirstround() && !var_455207c226282e7a && !( level.var_339ac09e83d0d5f0 === 1 ) )
    {
        level waittill( #"match_start_real_countdown" );
        level.var_339ac09e83d0d5f0 = 1;
    }
    
    machetes = getscriptablearray( "machetefall", #targetname );
    InvalidOpCode( 0x8f, 1 );
    // Unknown operator ( 0x8f, t11, Black Ops 7 )
LOC_00000130:
    delay = isdefined( n_set_delay ) ? n_set_interval : n_set_interval;
    InvalidOpCode( 0x1a, randomint( 4 ) );
    // Unknown operator ( 0x1a, t11, Black Ops 7 )
LOC_0000014f:
    interval = n_set_interval ?? n_set_interval;
    
    foreach ( var_ca2a3c94f511feb9 in machetes )
    {
        var_ca2a3c94f511feb9 function_bc3d7c98d9c2a54( "default" );
    }
    
    wait delay;
    
    foreach ( var_ca2a3c94f511feb9 in machetes )
    {
        wait interval;
        var_ca2a3c94f511feb9 function_bc3d7c98d9c2a54( "anim" );
    }
    
    level.var_c8d6604369d16df5 = 1;
}

// Namespace mp_sat_enigma
// Params 1, eflags: 0x4
// Checksum 0x881e9306, Offset: 0x54a
// Size: 0x26
function private function_bc3d7c98d9c2a54( new_state )
{
    if ( self getscriptablepartstate( "base" ) )
    {
        self setscriptablepartstate( "base", new_state );
    }
}

// Namespace mp_sat_enigma
// Params 1, eflags: 0x4
// Checksum 0x83dc4636, Offset: 0x578
// Size: 0x13
function private on_player_death( params )
{
    thread function_beabcc9dd4496701();
}

// Namespace mp_sat_enigma
// Params 0, eflags: 0x4
// Checksum 0xb6e7bc2c, Offset: 0x593
// Size: 0x22
function private function_beabcc9dd4496701()
{
    var_8b17ee2294ae2a72 = self getcorpseentity();
    
    if ( isdefined( var_8b17ee2294ae2a72 ) )
    {
        var_8b17ee2294ae2a72 thread function_ce9350287261d087();
    }
}

// Namespace mp_sat_enigma
// Params 0, eflags: 0x4
// Checksum 0x89ce6ece, Offset: 0x5bd
// Size: 0x3e
function private function_ce9350287261d087()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 5;
        
        if ( self.origin[ 2 ] < -350 )
        {
            self delete();
        }
    }
}

