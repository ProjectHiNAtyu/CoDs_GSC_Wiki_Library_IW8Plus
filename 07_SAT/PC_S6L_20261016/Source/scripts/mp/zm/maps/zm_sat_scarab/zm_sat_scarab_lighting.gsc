// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_lighting.gsc  (hash_326b242da0110728.gscc) (size: 6592 Bytes / 0x19c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x904c4785 (2420918149)
// size ...... 6592 (0x19c0)
// includes .. 2   (offset: 0x194c)
// strings ... 7   (offset: 0x195c)
// dev strs .. 1   (offset: 0x19b4)
// exports ... 19  (offset: 0x1174)
// cseg ...... 0xdc + 0x1098 (0x1174)
// imports ... 34  (offset: 0x146c)
// animtree1 . 0   (offset: 0x19c0)
// animtree2 . 0   (offset: 0x19c0)
#using scripts\common\lighting;
#using scripts\common\lighting_pbg;

#namespace zm_sat_scarab_lighting;

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0x71c0a09, Offset: 0xfa
// Size: 0x28
function main()
{
    get_light_entities();
    level.var_4b4c66b99d98061d = function_fa1e4eeda37f43a5();
    level.var_c805de1cd2662c39 = level.var_4b4c66b99d98061d;
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xaddac935, Offset: 0x12a
// Size: 0x50
function function_2925eaea9ad5e8e5()
{
    special_sun = [ 0.901961, 1, 0.992157, 0.15 ];
    level thread lighting::function_618e594176cb809a( level.var_c805de1cd2662c39, special_sun, 2 );
    level.var_c805de1cd2662c39 = special_sun;
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0x90847006, Offset: 0x182
// Size: 0x7e
function function_9266f93608a1ec63( b_immediate = 0 )
{
    if ( b_immediate )
    {
        setsuncolorandintensity( level.var_4b4c66b99d98061d[ 0 ], level.var_4b4c66b99d98061d[ 1 ], level.var_4b4c66b99d98061d[ 2 ], level.var_4b4c66b99d98061d[ 3 ] );
    }
    else
    {
        level thread lighting::function_618e594176cb809a( level.var_c805de1cd2662c39, level.var_4b4c66b99d98061d, 2 );
    }
    
    level.var_c805de1cd2662c39 = level.var_4b4c66b99d98061d;
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0xfe6afe7d, Offset: 0x208
// Size: 0xa8
function function_99b7bfd228b00ff6( b_immediate = 0 )
{
    cleansed_sun = [ 1, 0.980392, 0.94902, 0.35 ];
    
    if ( b_immediate )
    {
        setsuncolorandintensity( cleansed_sun[ 0 ], cleansed_sun[ 1 ], cleansed_sun[ 2 ], cleansed_sun[ 3 ] );
    }
    else
    {
        level thread lighting::function_618e594176cb809a( level.var_c805de1cd2662c39, cleansed_sun, 2 );
    }
    
    level.var_c805de1cd2662c39 = cleansed_sun;
    setskyrotation( ( 180, -89, 0 ) );
    level thread lighting_pbg::function_eaa082ab7b0c93a8( 3, 0 );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xa9843f0c, Offset: 0x2b8
// Size: 0x55
function function_65f9a458248bc754()
{
    function_d3784096bf1f9304();
    boss_sun = [ 0.494118, 0.866697, 1, 0.25 ];
    level thread lighting::function_618e594176cb809a( level.var_c805de1cd2662c39, boss_sun, 2 );
    level.var_c805de1cd2662c39 = boss_sun;
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0x10d7cf9, Offset: 0x315
// Size: 0x9
function function_4ca866b3761152fd()
{
    thread function_c6baa2dec8445bdb();
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xcbb9d631, Offset: 0x326
// Size: 0x120
function function_c6baa2dec8445bdb()
{
    thread function_ae6bff1a480ab8c7();
    fade_time = 0.1;
    
    foreach ( var_eb451042a3f97621 in level.var_6259148e9d9f3656 )
    {
        var_eb451042a3f97621 thread function_5db9cbb6ea1930ef( fade_time, 0 );
    }
    
    foreach ( var_a1ad9af0e31de76 in level.var_6aeac0fc37ab44ff )
    {
        var_a1ad9af0e31de76 thread function_5db9cbb6ea1930ef( fade_time, var_a1ad9af0e31de76.og_intensity );
    }
    
    activateworldevent( "sat_we_lgt_danceoff" );
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0x88243d0b, Offset: 0x44e
// Size: 0x119
function function_f53a52ac0b42e40d()
{
    fade_time = 0.1;
    
    foreach ( var_eb451042a3f97621 in level.var_6259148e9d9f3656 )
    {
        var_eb451042a3f97621 thread function_5db9cbb6ea1930ef( fade_time, var_eb451042a3f97621.og_intensity );
    }
    
    foreach ( var_a1ad9af0e31de76 in level.var_6aeac0fc37ab44ff )
    {
        var_a1ad9af0e31de76 thread function_5db9cbb6ea1930ef( fade_time, 0 );
    }
    
    deactivateworldevent( "sat_we_lgt_danceoff" );
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xe10690d8, Offset: 0x56f
// Size: 0x37b
function get_light_entities()
{
    level.var_cb6e8b0c60b19041 = getentarray( "disco_light_01", #targetname );
    
    foreach ( var_2b231c1b4ded37c8 in level.var_cb6e8b0c60b19041 )
    {
        var_2b231c1b4ded37c8 function_b2d9b60bcb7abbe7();
    }
    
    level.var_1103ecd210484aa2 = getentarray( "disco_light_02", #targetname );
    
    foreach ( var_270705a67b3bca5 in level.var_1103ecd210484aa2 )
    {
        var_270705a67b3bca5 function_b2d9b60bcb7abbe7();
    }
    
    level.var_ec519db6ab15be5f = getentarray( "disco_light_03", #targetname );
    
    foreach ( var_6a4ac6777529df56 in level.var_ec519db6ab15be5f )
    {
        var_6a4ac6777529df56 function_b2d9b60bcb7abbe7();
    }
    
    level.var_c9ca85d545a15cc0 = getentarray( "disco_light_04", #targetname );
    
    foreach ( var_677fb4a4872bf033 in level.var_c9ca85d545a15cc0 )
    {
        var_677fb4a4872bf033 function_b2d9b60bcb7abbe7();
    }
    
    level.var_6259148e9d9f3656 = getentarray( "dls_bowling", #targetname );
    
    foreach ( var_eb451042a3f97621 in level.var_6259148e9d9f3656 )
    {
        var_eb451042a3f97621 function_b2d9b60bcb7abbe7();
    }
    
    level.var_6aeac0fc37ab44ff = getentarray( "dls_bowling_cosmic", #targetname );
    
    foreach ( var_a1ad9af0e31de76 in level.var_6aeac0fc37ab44ff )
    {
        var_a1ad9af0e31de76 function_b2d9b60bcb7abbe7();
        var_a1ad9af0e31de76 thread function_5db9cbb6ea1930ef( 0, 0 );
    }
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xe5dc058a, Offset: 0x8f2
// Size: 0x1e0
function function_ae6bff1a480ab8c7()
{
    foreach ( var_2b231c1b4ded37c8 in level.var_cb6e8b0c60b19041 )
    {
        thread function_ee9f3bbdfccf6ec9( var_2b231c1b4ded37c8 );
    }
    
    foreach ( var_270705a67b3bca5 in level.var_1103ecd210484aa2 )
    {
        thread function_ee9f38bdfccf6830( var_270705a67b3bca5 );
    }
    
    foreach ( var_6a4ac6777529df56 in level.var_ec519db6ab15be5f )
    {
        thread function_ee9f39bdfccf6a63( var_6a4ac6777529df56 );
    }
    
    foreach ( var_677fb4a4872bf033 in level.var_c9ca85d545a15cc0 )
    {
        thread function_ee9f3ebdfccf7562( var_677fb4a4872bf033 );
    }
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0xddbc80b4, Offset: 0xada
// Size: 0x50
function function_b2d9b60bcb7abbe7()
{
    self.og_intensity = self getlightintensity();
    self.og_color = self getlightcolor();
    self.og_radius = self getlightradius();
    self.og_position = self.origin;
    self.og_rotation = self.angles;
}

// Namespace zm_sat_scarab_lighting
// Params 0
// Checksum 0x3ecf44fe, Offset: 0xb32
// Size: 0x53
function function_5bf2ad3434bc1d22()
{
    self setlightintensity( self.og_intensity );
    self setlightcolor( self.og_color );
    self setlightradius( self.og_radius );
    self.origin = self.og_position;
    self.angles = self.og_rotation;
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0xb8a3b0dd, Offset: 0xb8d
// Size: 0x9f
function function_ee9f3bbdfccf6ec9( light )
{
    cooldown_time = 0.5;
    off_time = 10;
    rotate_time = randomfloatrange( 25, 40 );
    rotate_angle = 3600;
    colorg = randomfloatrange( 0.6, 1 );
    
    while ( true )
    {
        light setlightcolor( ( 0, colorg, 1 ) );
        light rotateby( ( rotate_angle, rotate_angle, 0 ), rotate_time );
        wait rotate_time;
        light function_5bf2ad3434bc1d22();
    }
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0x9266e6fd, Offset: 0xc34
// Size: 0x1c7
function function_ee9f38bdfccf6830( light )
{
    cooldown_time = 0.6;
    blink_time = 0.1;
    off_time = randomfloatrange( 7, 15 );
    delay_time = 0.2;
    rotate_time = randomfloatrange( 1, 1.5 );
    rotate_angle = 120;
    colorb = randomfloatrange( 0.5, 0.8 );
    
    while ( true )
    {
        light setlightcolor( ( 0.5, 0.2, colorb ) );
        light setlightintensity( light.og_intensity );
        light rotateby( ( rotate_angle, 8, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        light setlightintensity( 0 );
        wait delay_time;
        light.angles = light.og_rotation;
        light setlightintensity( light.og_intensity );
        light rotateby( ( rotate_angle, -2, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        light setlightintensity( 0 );
        wait delay_time;
        light.angles = light.og_rotation;
        light setlightintensity( light.og_intensity );
        light rotateby( ( rotate_angle, -10, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        
        if ( randomint( 3 ) > 1 )
        {
            wait cooldown_time;
            function_e3e56738b95bd15c( light, blink_time );
        }
        
        wait cooldown_time;
        light setlightintensity( 0 );
        wait off_time;
        light function_5bf2ad3434bc1d22();
    }
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0x3223dc00, Offset: 0xe03
// Size: 0x11b
function function_ee9f39bdfccf6a63( light )
{
    cooldown_time = 0.5;
    off_time = randomfloatrange( 0, 2 );
    rotate_time = randomfloatrange( 3, 5 );
    rotate_angle_pitch = 15;
    rotate_angle_yaw = 720;
    
    while ( true )
    {
        light setlightcolor( ( 0, 0.6, 0.7 ) );
        light rotateby( ( rotate_angle_pitch, rotate_angle_yaw, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        light setlightintensity( 0 );
        wait off_time;
        light function_5bf2ad3434bc1d22();
        rotate_time = randomfloatrange( 1.5, 5 );
        light setlightcolor( ( 0, 0.6, 1 ) );
        light rotateby( ( rotate_angle_pitch * -1, rotate_angle_yaw, 0 ), rotate_time, rotate_time * 0.2, rotate_time * 0.3 );
        wait rotate_time;
        light setlightintensity( 0 );
        wait off_time;
        light function_5bf2ad3434bc1d22();
    }
}

// Namespace zm_sat_scarab_lighting
// Params 1
// Checksum 0xe2aa78bf, Offset: 0xf26
// Size: 0x1b3
function function_ee9f3ebdfccf7562( light )
{
    cooldown_time = 0.5;
    blink_time = 0.1;
    off_time = randomfloatrange( 2, 4 );
    rotate_time = randomfloatrange( 2, 2.5 );
    rotate_angle = 90;
    
    while ( true )
    {
        light setlightcolor( ( 0, 0.8, 0.9 ) );
        light rotateby( ( 0, rotate_angle, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.3 );
        wait rotate_time;
        light rotateby( ( 10, rotate_angle * -1, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        light setlightcolor( ( 0.4, 0, 1 ) );
        light rotateby( ( -5, rotate_angle, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.6 );
        wait rotate_time;
        light rotateby( ( 10, rotate_angle * -1, 0 ), rotate_time, rotate_time * 0.2, rotate_time * 0.4 );
        wait rotate_time;
        light setlightcolor( ( 0.3, 0.1, 0.9 ) );
        light rotateby( ( -15, rotate_angle, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.3 );
        wait rotate_time;
        light rotateby( ( 0, rotate_angle * -1, 0 ), rotate_time, rotate_time * 0.3, rotate_time * 0.4 );
        wait rotate_time;
        
        if ( randomint( 3 ) > 1 )
        {
            wait cooldown_time;
            function_e3e56738b95bd15c( light, blink_time );
        }
        
        wait cooldown_time;
        light setlightintensity( 0 );
        wait off_time;
        light function_5bf2ad3434bc1d22();
    }
}

// Namespace zm_sat_scarab_lighting
// Params 2
// Checksum 0x92bf4a6b, Offset: 0x10e1
// Size: 0x65
function function_e3e56738b95bd15c( light, blink_time )
{
    blink_count = randomintrange( 3, 8 );
    
    for ( i = 0; i < blink_count ; i++ )
    {
        wait blink_time;
        light setlightintensity( 0 );
        wait blink_time;
        light setlightintensity( light.og_intensity );
    }
}

// Namespace zm_sat_scarab_lighting
// Params 2, eflags: 0x4
// Checksum 0x22feba18, Offset: 0x114e
// Size: 0x26
function private function_5db9cbb6ea1930ef( time, endintensity )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    lighting::function_a6b7ccf4c5f2d94a( time, endintensity );
}

