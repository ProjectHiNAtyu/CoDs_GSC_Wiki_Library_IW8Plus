// scripts\mp\maps\mp_sat_the_forge\mp_sat_the_forge.gsc  (hash_36a623c67b6aff6f.gscc) (size: 5025 Bytes / 0x13a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c308cc4 (472943812)
// size ...... 5025 (0x13a1)
// includes .. 11  (offset: 0x1191)
// strings ... 33  (offset: 0x11e9)
// dev strs .. 0   (offset: 0x13a1)
// exports ... 7   (offset: 0xbdd)
// cseg ...... 0x2b3 + 0x92a (0xbdd)
// imports ... 39  (offset: 0xcf5)
// animtree1 . 0   (offset: 0x13a1)
// animtree2 . 0   (offset: 0x13a1)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_the_forge\gen\mp_sat_the_forge_art;
#using scripts\mp\maps\mp_sat_the_forge\mp_sat_the_forge_fx;
#using scripts\mp\maps\mp_sat_the_forge\mp_sat_the_forge_lighting;
#using scripts\mp\spawnlogic;

#namespace mp_sat_the_forge;

// Namespace mp_sat_the_forge
// Params 0
// Checksum 0xc184f3d4, Offset: 0x2d1
// Size: 0x1f8
function main()
{
    mp_sat_the_forge_art::main();
    mp_sat_the_forge_fx::main();
    mp_sat_the_forge_lighting::main();
    load::main();
    level thread function_1e70383823f11863();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_the_forge" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvar( @"hash_191598960157d74a", 12 );
    callback::add( #"player_spawn_init", &on_spawn_init );
    level thread animation_suite::animationsuite();
    thread setup_vista_driving_boats();
    var_b250ef84088fe28b = getdvarint( @"hash_1b7f2ce48d2244b", 0 );
    var_a5a197d74832ca87 = getdvarint( @"hash_8c481a97e362da67", 0 );
    level thread moving_platforms::moving_platforms_init( var_a5a197d74832ca87 );
    
    if ( !var_b250ef84088fe28b )
    {
        level thread forge_turret_controller();
    }
    
    origin = ( 0, 0, 200 );
    radius = 450;
    height = 150;
    trigger = spawn( "trigger_radius", origin, 0, radius, height );
    trigger.radius = radius;
    trigger.height = height;
    trigger.type = #"hash_d2c03b65714a93e1";
    level.var_54c2f5dfe418e393 = [ trigger ];
    setdvar( @"hash_1673bfd92c93a024", 376 );
    level.var_37d1bac25fa1646 = 200;
}

// Namespace mp_sat_the_forge
// Params 1
// Checksum 0x2186f57d, Offset: 0x4d1
// Size: 0x20
function on_spawn_init( params )
{
    spawnlogic::function_e9b594d3d6d08748( ( 1816.64, 340.575, 186.268 ) );
}

// Namespace mp_sat_the_forge
// Params 0
// Checksum 0x660e4f71, Offset: 0x4f9
// Size: 0x8e
function function_1e70383823f11863()
{
    models = getentarray( "model_bake_only", #targetname );
    
    foreach ( model in models )
    {
        model hide();
    }
}

// Namespace mp_sat_the_forge
// Params 0
// Checksum 0x21c69662, Offset: 0x58f
// Size: 0x35d
function setup_vista_driving_boats()
{
    wait 10;
    boats = getentarray( "boat_vista", #targetname );
    boatspeed = 0.004;
    wait 2;
    
    foreach ( boat in boats )
    {
        boat.boatfx = utility::spawn_tag_origin();
        boat.boatfx forcenetfieldhighlod( 1 );
        boat.boatfx.origin = boat.origin;
        boat.boatfx.angles = boat.angles;
        boat.boatfx.targetname = "boatFX";
        boat.boatfx show();
        
        if ( boat.model == "jup_periph_yacht_princess_01" )
        {
            boatspeed = 1 / ( 400 + randomfloatrange( -1, 1 ) * 25 );
            playfxontag( level._effect[ "vfx_the_forge_boat_wake_04" ], boat.boatfx, "tag_origin" );
        }
        else if ( boat.model == "jup_decor_yacht_vista_modern_01" )
        {
            boat.boatfx.origin += ( 0, 0, 20 );
            boat.boatfx.angles += ( 3, 0, 0 );
            boatspeed = 1 / ( 400 + randomfloatrange( -1, 1 ) * 25 );
            playfxontag( level._effect[ "vfx_the_forge_boat_wake_02" ], boat.boatfx, "tag_origin" );
        }
        else if ( boat.model == "uk_cargo_ship_02" )
        {
            boat.boatfx.angles += ( 0, -90, 0 );
            boatspeed = 1 / ( 125 + randomfloatrange( -1, 1 ) * 25 );
            playfxontag( level._effect[ "vfx_the_forge_boat_wake_03" ], boat.boatfx, "tag_origin" );
        }
        else
        {
            boatspeed = 1 / ( 175 + randomfloatrange( -1, 1 ) * 25 );
            playfxontag( level._effect[ "vfx_the_forge_boat_wake_01" ], boat.boatfx, "tag_origin" );
        }
        
        boat.boatfx linkto( boat );
        wait 0.1;
        thread vista_boat_drive( boat, boatspeed );
    }
}

// Namespace mp_sat_the_forge
// Params 2
// Checksum 0xd36665ae, Offset: 0x8f4
// Size: 0xf7
function vista_boat_drive( boat, boatspeed )
{
    currentdest = utility::getstruct( boat.target, "targetname" );
    
    while ( 1 && isdefined( currentdest ) )
    {
        boatmovetime = abs( distance( boat.origin, currentdest.origin ) * boatspeed );
        boat moveto( currentdest.origin, boatmovetime, 0, 0 );
        
        if ( isdefined( currentdest.angles ) )
        {
            boat rotateto( currentdest.angles, boatmovetime, 0, 0 );
        }
        else
        {
            boat rotateto( ( 0, 0, 0 ), boatmovetime, 0, 0 );
        }
        
        if ( isdefined( currentdest.target ) )
        {
            currentdest = utility::getstruct( currentdest.target, "targetname" );
        }
        else
        {
            break;
        }
        
        wait boatmovetime;
    }
}

// Namespace mp_sat_the_forge
// Params 0
// Checksum 0x9c697ddc, Offset: 0x9f3
// Size: 0x1ea
function forge_turret_controller()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_d837ba3329221216 = getscriptablearray( "forge_turret", #script_noteworthy );
    
    if ( var_d837ba3329221216.size == 0 )
    {
        return;
    }
    
    scr_forge_turret = var_d837ba3329221216[ 0 ];
    scr_forge_turret setnonstick( 1 );
    
    if ( level.prematchperiod > 0 )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    var_99f989d038e733ce = getdvarint( @"hash_6236eb04e2eccec1", 1 );
    var_d0e6552c7b13f061 = getdvarint( @"hash_af0f3fcf095ec0af", 3 );
    var_99f989d038e733ce = max( 1, var_99f989d038e733ce );
    scr_forge_turret setscriptablepartstate( "base", "idle" );
    
    for ( var_19369eb17170a50 = 0; var_19369eb17170a50 < var_99f989d038e733ce ; var_19369eb17170a50++ )
    {
        scr_forge_turret setscriptablepartstate( "base", "idle" );
        scr_forge_turret waittillmatch( #"scriptablenotification", #"idle_anim_done" );
    }
    
    var_2432570798c9c9ba = 3;
    
    while ( true )
    {
        for ( var_be94830f0dd722f9 = 1; var_be94830f0dd722f9 <= var_2432570798c9c9ba ; var_be94830f0dd722f9++ )
        {
            var_5f7608ab47aa9761 = "targeting_0" + string( var_be94830f0dd722f9 );
            scr_forge_turret setscriptablepartstate( "base", var_5f7608ab47aa9761 );
            scr_forge_turret waittillmatch( #"scriptablenotification", var_5f7608ab47aa9761 + "_anim_done" );
            var_d15d65510fdcdbb8 = randomint( 2 );
            
            if ( var_d15d65510fdcdbb8 )
            {
                scr_forge_turret setscriptablepartstate( "base", "idle" );
                scr_forge_turret waittillmatch( #"scriptablenotification", #"idle_anim_done" );
            }
        }
        
        for ( var_76d62af70c63f01d = 0; var_76d62af70c63f01d < var_d0e6552c7b13f061 ; var_76d62af70c63f01d++ )
        {
            scr_forge_turret setscriptablepartstate( "base", "idle" );
            scr_forge_turret waittillmatch( #"scriptablenotification", #"idle_anim_done" );
        }
    }
}

