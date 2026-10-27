// scripts\mp\maps\mp_sat_sm_blackheart\mp_sat_sm_blackheart.gsc  (hash_521d03fc877a39d5.gscc) (size: 3642 Bytes / 0xe3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa89975f5 (2828629493)
// size ...... 3642 (0xe3a)
// includes .. 9   (offset: 0xca2)
// strings ... 25  (offset: 0xcea)
// dev strs .. 0   (offset: 0xe3a)
// exports ... 8   (offset: 0x812)
// cseg ...... 0x1dd + 0x635 (0x812)
// imports ... 27  (offset: 0x952)
// animtree1 . 0   (offset: 0xe3a)
// animtree2 . 0   (offset: 0xe3a)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\utility;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_blackheart\gen\mp_sat_sm_blackheart_art;
#using scripts\mp\maps\mp_sat_sm_blackheart\mp_sat_sm_blackheart_fx;
#using scripts\mp\maps\mp_sat_sm_blackheart\mp_sat_sm_blackheart_lighting;

#namespace mp_sat_sm_blackheart;

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0xb97314d5, Offset: 0x1fb
// Size: 0x114
function main()
{
    mp_sat_sm_blackheart_art::main();
    mp_sat_sm_blackheart_fx::main();
    mp_sat_sm_blackheart_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_blackheart" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread animation_suite::animationsuite();
    level thread moving_platforms::moving_platforms_init();
    level thread drill_logic();
    level thread crane_movement();
    level thread sub_movement();
    weaponfilter = [ #"drone_launcher":1 ];
    utility::setup_no_deploy_zones( weaponfilter );
}

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0xe4e8f64f, Offset: 0x317
// Size: 0x114
function drill_logic()
{
    drill_controllers = getentarray( "drill_org", "targetname" );
    
    foreach ( controller in drill_controllers )
    {
        controller thread controller_logic();
    }
    
    drill_vac = getentarray( "drill_vac", "targetname" );
    
    foreach ( drill in drill_vac )
    {
        drill thread drill_vac_logic();
    }
}

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0x61de97bd, Offset: 0x433
// Size: 0x5c
function controller_logic()
{
    rotate_angle = 18;
    rotate_time = 1.4;
    parts = getentarray( self.target, "targetname" );
    utility::array_call( parts, &linkto, self );
    
    while ( true )
    {
        self rotateroll( rotate_angle, rotate_time );
        wait rotate_time;
    }
}

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0x8eacbf12, Offset: 0x497
// Size: 0x3d
function drill_vac_logic()
{
    rotate_angle = 18;
    rotate_time = 1.4;
    
    while ( true )
    {
        self rotatepitch( rotate_angle, rotate_time );
        self waittill( #"rotatedone" );
    }
}

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0x7d32892, Offset: 0x4dc
// Size: 0xe5
function crane_movement()
{
    var_9259692e2b4b537b = getent( "crane_part", "targetname" );
    crane_decals = getent( "crane_decals", "targetname" );
    pivot = getent( "crane_part_pivot", "targetname" );
    
    if ( isdefined( var_9259692e2b4b537b ) && isdefined( crane_decals ) && isdefined( pivot ) )
    {
        crane_decals linkto( var_9259692e2b4b537b );
        var_9259692e2b4b537b linkto( pivot );
        pivot rotateby( ( 0, 0, 1.5 ), 1.5, 0.25, 0.25 );
        wait 1.5;
        
        while ( true )
        {
            pivot rotateby( ( 0, 0, -3 ), 3, 0.25, 0.25 );
            wait 3;
            pivot rotateby( ( 0, 0, 3 ), 3, 0.25, 0.25 );
            wait 3;
        }
    }
}

// Namespace mp_sat_sm_blackheart
// Params 0
// Checksum 0x4f050b68, Offset: 0x5c9
// Size: 0x1d1
function sub_movement()
{
    sub_body = getent( "sub_body", "targetname" );
    pivot = getent( "sub_crane_pivot", "targetname" );
    sub_parts = getentarray( "sub_parts", "targetname" );
    var_273a75f31028ba0f = utility::getstructarray( "sub_water_fx", "targetname" );
    
    foreach ( loc in var_273a75f31028ba0f )
    {
        loc thread submarine_fx( pivot );
    }
    
    if ( isdefined( sub_body ) && isdefined( sub_parts ) && isdefined( pivot ) )
    {
        foreach ( part in sub_parts )
        {
            part linkto( sub_body );
        }
        
        sub_body linkto( pivot );
        pivot rotateby( ( 0.25, 0, 0 ), 1, 0.1, 0.1 );
        wait 1;
        
        while ( true )
        {
            pivot rotateby( ( -0.5, 0, 0 ), 2, 0.25, 0.25 );
            wait 2;
            pivot rotateby( ( 0.5, 0, 0 ), 2, 0.25, 0.25 );
            wait 2;
        }
    }
}

// Namespace mp_sat_sm_blackheart
// Params 1
// Checksum 0xb0df4891, Offset: 0x7a2
// Size: 0x70
function submarine_fx( sub_body )
{
    water_vfx = level._effect[ "water_vfx" ];
    fx_tag = "tag_origin";
    var_c5e4c225d83e9ffa = utility::spawn_tag_origin( self.origin, self.angles );
    var_c5e4c225d83e9ffa show();
    var_c5e4c225d83e9ffa linkto( sub_body );
    playfxontag( water_vfx, var_c5e4c225d83e9ffa, fx_tag );
}

