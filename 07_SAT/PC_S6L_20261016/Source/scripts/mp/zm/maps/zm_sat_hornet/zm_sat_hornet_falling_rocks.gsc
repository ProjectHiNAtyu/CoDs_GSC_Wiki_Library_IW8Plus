// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_falling_rocks.gsc  (hash_5bfa2892f98a403c.gscc) (size: 7970 Bytes / 0x1f22 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x969e04ee (2526938350)
// size ...... 7970 (0x1f22)
// includes .. 6   (offset: 0x1d7e)
// strings ... 19  (offset: 0x1dae)
// dev strs .. 9   (offset: 0x1eb6)
// exports ... 21  (offset: 0x11fa)
// cseg ...... 0x1ab + 0x104f (0x11fa)
// imports ... 71  (offset: 0x1542)
// animtree1 . 0   (offset: 0x1f22)
// animtree2 . 0   (offset: 0x1f22)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\shellshock_utility;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace zm_sat_hornet_falling_rocks;

// Namespace zm_sat_hornet_falling_rocks
// Params 0
// Checksum 0x21d9424a, Offset: 0x1c9
// Size: 0x38
function main()
{
    if ( !getdvarint( @"disable_falling_rocks", 0 ) && !getdvarint( @"hash_169846c664077bf", 0 ) )
    {
        init_falling_rocks();
        
        /#
            function_e08994b9921ec2f4();
        #/
    }
}

// Namespace zm_sat_hornet_falling_rocks
// Params 0
// Checksum 0x509cd1b1, Offset: 0x209
// Size: 0x6c
function init_falling_rocks()
{
    level.falling_rocks = {};
    level.falling_rocks.active = 0;
    level.falling_rocks.var_d408be170f8630a = [];
    level.falling_rocks.var_a259b15bb3a9ffd7 = [];
    level.falling_rocks.throttle = throttle::throttle_initialize( "falling_rocks", 1 );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 2
// Checksum 0x4fd353af, Offset: 0x27d
// Size: 0x37
function start_falling_rocks( n_delay, var_cd58d79e40a17dc2 )
{
    if ( level.falling_rocks.active )
    {
        return;
    }
    
    level thread function_b0f21157e3b206b5( n_delay, var_cd58d79e40a17dc2 );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 1
// Checksum 0x213459cd, Offset: 0x2bc
// Size: 0x37
function stop_falling_rocks( hardstop )
{
    if ( hardstop )
    {
        level function_13ac88c6949d4485();
        return;
    }
    
    level.falling_rocks.active = 0;
    level function_4670f2f74affdf6e();
}

// Namespace zm_sat_hornet_falling_rocks
// Params 1
// Checksum 0xefa693cd, Offset: 0x2fb
// Size: 0x3a
function function_9a22faf44c3f0c78( var_cd58d79e40a17dc2 )
{
    if ( !level.falling_rocks.active )
    {
        return;
    }
    
    level.falling_rocks.var_cd58d79e40a17dc2 = var_cd58d79e40a17dc2;
}

// Namespace zm_sat_hornet_falling_rocks
// Params 2, eflags: 0x4
// Checksum 0x83c62281, Offset: 0x33d
// Size: 0x15e
function private function_b0f21157e3b206b5( n_delay, var_cd58d79e40a17dc2 )
{
    level endon( #"game_ended" );
    level endon( #"hash_bbe3d5e1cb47f066" );
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = randomfloatrange( 3, 5 );
    }
    
    if ( n_delay > 0 )
    {
        wait n_delay;
    }
    
    earthquake( 0.35, 6, ( 33370, 42192, 16626 ), 5000 );
    activateworldevent( "we_vfx_volcano_boss_erupt_loop" );
    activateworldevent( "we_vfx_rock_fall" );
    
    if ( isdefined( level.var_852213e2b06e3f79 ) )
    {
        level.var_852213e2b06e3f79 setscriptablepartstate( "eruption", "erupt" );
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_d1c4c78b9fb7d153 )
        {
            player playrumbleonentity( "heavy_3s" );
        }
    }
    
    wait 4;
    level.falling_rocks.active = 1;
    level.falling_rocks.var_d408be170f8630a = [];
    level function_d6d2c745b4ff794e( var_cd58d79e40a17dc2 );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 1
// Checksum 0x9d346baa, Offset: 0x4a3
// Size: 0xe7
function function_d6d2c745b4ff794e( var_cd58d79e40a17dc2 )
{
    level endon( #"game_ended" );
    level endon( #"hash_bbe3d5e1cb47f066" );
    
    if ( !isdefined( var_cd58d79e40a17dc2 ) )
    {
        var_cd58d79e40a17dc2 = [ 0.3, 0.5 ];
    }
    
    level.falling_rocks.var_cd58d79e40a17dc2 = var_cd58d79e40a17dc2;
    
    while ( true )
    {
        if ( level.falling_rocks.var_d408be170f8630a.size > 80 )
        {
            wait 0.25;
            continue;
        }
        
        var_8a00b9889d850984 = utility::function_7afe366c29a77c34( ( 33370, 42192, 16626 ), 1200 );
        level thread function_2fce62b91faf2c87( var_8a00b9889d850984 );
        var_e57a953558fddc43 = randomfloatrange( level.falling_rocks.var_cd58d79e40a17dc2[ 0 ], level.falling_rocks.var_cd58d79e40a17dc2[ 1 ] );
        wait var_e57a953558fddc43;
    }
}

// Namespace zm_sat_hornet_falling_rocks
// Params 1
// Checksum 0x35ba5d5b, Offset: 0x592
// Size: 0x50f
function function_2fce62b91faf2c87( var_8a00b9889d850984 )
{
    level endon( #"game_ended" );
    level endon( #"hash_da60dec4f0ed9488" );
    rock_starting_pos = randomfloatrange( 2000, 2500 );
    starting_pos = ( var_8a00b9889d850984[ 0 ], var_8a00b9889d850984[ 1 ], var_8a00b9889d850984[ 2 ] + rock_starting_pos );
    ending_pos = utility::drop_to_ground( var_8a00b9889d850984, rock_starting_pos );
    var_92b2220f1f411421 = squared( 240 );
    
    foreach ( activetalisman in level.talisman_system.active_talismans )
    {
        if ( distancesquared( activetalisman.scriptable.origin, ending_pos ) <= var_92b2220f1f411421 )
        {
            var_1bfc42f30d2686b = activetalisman;
            ending_pos = function_cb980d18e4026380( activetalisman.scriptable.origin, starting_pos, ending_pos );
            break;
        }
    }
    
    ground_fx = spawnscriptable( %"hash_3019a6bf61324032", ending_pos );
    ground_fx utility::function_7c10ea82c1e305b8( "objective_marker", "off" );
    
    if ( !isdefined( level.falling_rocks.var_a259b15bb3a9ffd7 ) )
    {
        level.falling_rocks.var_a259b15bb3a9ffd7 = [];
    }
    
    level.falling_rocks.var_a259b15bb3a9ffd7[ level.falling_rocks.var_a259b15bb3a9ffd7.size ] = ground_fx;
    wait 1.25;
    ground_fx utility::function_7c10ea82c1e305b8( "fx", "none" );
    mover = utility::spawn_model( "tag_origin", starting_pos, ( 0, 0, 0 ) );
    rock = spawnscriptable( %"zm_sat_hornet_falling_rock", starting_pos, ( 0, 0, 0 ) );
    rock scriptablesetparententity( mover );
    mover.var_ebfff1f89798fefb = 1;
    mover.var_24cdba8441bafdad = 1;
    rock.mover = mover;
    rock.ground_fx = ground_fx;
    
    if ( !isdefined( level.falling_rocks.var_d408be170f8630a ) )
    {
        level.falling_rocks.var_d408be170f8630a = [];
    }
    
    level.falling_rocks.var_d408be170f8630a[ level.falling_rocks.var_d408be170f8630a.size ] = rock;
    mover moveto( ending_pos, 4, 0.75 );
    ground_fx thread function_827414aa49c8873( mover, ending_pos );
    mover waittill( #"movedone" );
    
    if ( var_1bfc42f30d2686b )
    {
        var_1bfc42f30d2686b.scriptable scriptabledodamage( 0, mover, mover, ending_pos, vectornormalize( ending_pos - starting_pos ) );
    }
    else
    {
        rock utility::function_7c10ea82c1e305b8( "fx", "death_fx" );
        ground_fx utility::function_7c10ea82c1e305b8( "fx", "impact" );
    }
    
    earthquake( 0.7, 1, ending_pos, 231.25 );
    playrumbleonposition( "heavy_1s", ending_pos );
    var_a06d5e80cdd7fe44 = getplayersandaiarrayinradius( ending_pos, 185 );
    
    foreach ( ent in var_a06d5e80cdd7fe44 )
    {
        if ( !isalive( ent ) )
        {
            continue;
        }
        
        throttle::throttle_wait_in_queue( level.falling_rocks.throttle, ent );
        dmg = ent function_bbfd60791c2886bb( ending_pos );
        
        if ( isplayer( ent ) && !ent.var_f468cf5c9e75db1 )
        {
            ent dodamage( dmg, ending_pos, mover, mover, "MOD_UNKNOWN", level.weaponnone, "none", undefined, 1073741824 );
            
            if ( !ent effect_slow::function_c1be3c9f2d0b92d2( "falling_rocks_slow" ) )
            {
                ent effect_slow::slow( "falling_rocks_slow", 0.5, 1, mover );
            }
            
            ent shellshock_utility::_shellshock( %"hash_3e853b61f7d7058a", #"damage", 1 );
            
            if ( dmg > 0 )
            {
                level callback::callback( "on_hornet_boss_falling_rock_damage_vo", { #player:ent } );
            }
        }
    }
    
    waitframe();
    rock freescriptable();
    mover delete();
    level.falling_rocks.var_d408be170f8630a = function_5713d46873b29625( level.falling_rocks.var_d408be170f8630a );
    ground_fx freescriptable();
    level.falling_rocks.var_a259b15bb3a9ffd7 = function_5713d46873b29625( level.falling_rocks.var_a259b15bb3a9ffd7 );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 2, eflags: 0x4
// Checksum 0x43352edd, Offset: 0xaa9
// Size: 0x67
function private function_827414aa49c8873( mover, ending_pos )
{
    mover endon( #"movedone" );
    level endon( #"game_ended" );
    level endon( #"hash_da60dec4f0ed9488" );
    
    while ( distance( mover.origin, ending_pos ) > 800 )
    {
        waitframe();
    }
    
    utility::function_7c10ea82c1e305b8( "objective_marker", "on" );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 3, eflags: 0x4
// Checksum 0x90f150ab, Offset: 0xb18
// Size: 0x69
function private function_cb980d18e4026380( var_829369411a28aeb1, var_2f06db92b22c22e, var_95e360a5329c85e1 )
{
    var_539af4ef72969b23 = distance2dsquared( var_829369411a28aeb1, var_95e360a5329c85e1 );
    var_e2b5f4024c00f8f = sqrt( squared( 240 ) - var_539af4ef72969b23 );
    var_ca07fe396ceca335 = vectornormalize( var_95e360a5329c85e1 - var_2f06db92b22c22e );
    return var_2f06db92b22c22e + var_ca07fe396ceca335 * ( distance( var_2f06db92b22c22e, var_95e360a5329c85e1 ) - var_e2b5f4024c00f8f );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 3
// Checksum 0x637c004c, Offset: 0xb8a
// Size: 0x96
function function_2f3f777c3f65c0a8( impactpoint, var_e5070b52534334ac, var_2a9889351e7486b5 )
{
    var_9dfd91b473f52bd9 = vectornormalize2( self.origin - impactpoint );
    
    if ( var_9dfd91b473f52bd9 == ( 0, 0, 0 ) )
    {
        var_9dfd91b473f52bd9 = anglestoforward( self.angles );
    }
    
    rightvec = vectorcross( var_9dfd91b473f52bd9, ( 0, 0, 1 ) );
    impactvector = rotatepointaroundvector( rightvec, var_9dfd91b473f52bd9, var_2a9889351e7486b5 );
    self knockback( impactvector, var_e5070b52534334ac, 1 );
}

// Namespace zm_sat_hornet_falling_rocks
// Params 1
// Checksum 0x7a14c4fa, Offset: 0xc28
// Size: 0x91
function function_bbfd60791c2886bb( damage_center )
{
    if ( isplayer( self ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && self issprintsliding() )
        {
            dmg = 0;
        }
        else
        {
            dmg = 95;
        }
    }
    else if ( isai( self ) && isalive( self ) )
    {
        dmg = function_f4a4f124edb16fb0( self.aicategory, self.maxhealth );
    }
    else
    {
        dmg = 95;
    }
    
    return dmg;
}

// Namespace zm_sat_hornet_falling_rocks
// Params 2
// Checksum 0x7659a6cb, Offset: 0xcc2
// Size: 0x98
function function_f4a4f124edb16fb0( aicategory, aimaxhealth )
{
    if ( !aicategory || !aimaxhealth )
    {
        return 0;
    }
    
    switch ( aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            var_3a5935d846b2c9d1 = 0.4;
            break;
        case #"hash_8c089e813083e510":
            var_3a5935d846b2c9d1 = 0.2;
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            var_3a5935d846b2c9d1 = 0.05;
            break;
        default:
            return 0;
    }
    
    return aimaxhealth * var_3a5935d846b2c9d1;
}

// Namespace zm_sat_hornet_falling_rocks
// Params 0, eflags: 0x4
// Checksum 0x10f65d1b, Offset: 0xd63
// Size: 0x198
function private function_13ac88c6949d4485()
{
    level.falling_rocks.active = 0;
    level function_4670f2f74affdf6e();
    level notify( #"hash_da60dec4f0ed9488" );
    deactivateworldevent( "we_vfx_volcano_boss_erupt_loop", 1 );
    deactivateworldevent( "we_vfx_rock_fall", 1 );
    
    foreach ( rock in level.falling_rocks.var_d408be170f8630a )
    {
        if ( isdefined( rock ) )
        {
            if ( isdefined( rock.mover ) )
            {
                rock.mover delete();
            }
            
            rock freescriptable();
        }
    }
    
    foreach ( ground_fx in level.falling_rocks.var_a259b15bb3a9ffd7 )
    {
        if ( isdefined( ground_fx ) )
        {
            ground_fx freescriptable();
        }
    }
    
    level.falling_rocks.var_d408be170f8630a = [];
    level.falling_rocks.var_a259b15bb3a9ffd7 = [];
}

// Namespace zm_sat_hornet_falling_rocks
// Params 0, eflags: 0x4
// Checksum 0x881d1604, Offset: 0xf03
// Size: 0x22
function private function_4670f2f74affdf6e()
{
    level notify( #"hash_bbe3d5e1cb47f066" );
    deactivateworldevent( "we_vfx_volcano_boss_erupt_loop" );
    deactivateworldevent( "we_vfx_rock_fall" );
}

/#

    // Namespace zm_sat_hornet_falling_rocks
    // Params 0
    // Checksum 0xa502152c, Offset: 0xf2d
    // Size: 0x60, Type: dev
    function function_e08994b9921ec2f4()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3c>", "<dev string:x56>", &function_214f9839b7b81d7, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6e>", "<dev string:x86>", &function_6077ca12de0b6614, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x91>", "<dev string:xaf>", &function_70d44a26f17db0db, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_falling_rocks
    // Params 1
    // Checksum 0x64d333b0, Offset: 0xf95
    // Size: 0x100, Type: dev
    function function_6077ca12de0b6614( params )
    {
        if ( !isdefined( level.falling_rocks.debug ) )
        {
            level.falling_rocks.debug = {};
        }
        
        if ( !isdefined( level.falling_rocks.debug.trigger_drawn ) )
        {
            level.falling_rocks.debug.trigger_drawn = 0;
        }
        
        if ( !level.falling_rocks.debug.trigger_drawn )
        {
            level.falling_rocks.debug.trigger_drawn = 1;
            level thread function_4b73eaa6c832b2ae( ( 33370, 42192, 16626 ), 1200 );
            return;
        }
        
        level.falling_rocks.debug.trigger_drawn = 0;
        level notify( #"hash_135c2afe2489bccc" );
    }

    // Namespace zm_sat_hornet_falling_rocks
    // Params 2
    // Checksum 0x9e7731d0, Offset: 0x109d
    // Size: 0x7b, Type: dev
    function function_4b73eaa6c832b2ae( origin, radius )
    {
        level endon( #"hash_135c2afe2489bccc" );
        drawframes = 20;
        color = ( randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ) );
        
        while ( true )
        {
            cylinder( origin, origin + ( 0, 0, radius ), radius, color, 0, drawframes );
            wait level.framedurationseconds * drawframes;
        }
    }

    // Namespace zm_sat_hornet_falling_rocks
    // Params 1
    // Checksum 0xb25b62ef, Offset: 0x1120
    // Size: 0x2c, Type: dev
    function function_70d44a26f17db0db( params )
    {
        level thread function_2fce62b91faf2c87( level.players[ 0 ].origin );
    }

    // Namespace zm_sat_hornet_falling_rocks
    // Params 1
    // Checksum 0x1700f503, Offset: 0x1154
    // Size: 0xa6, Type: dev
    function function_214f9839b7b81d7( params )
    {
        if ( !isdefined( level.falling_rocks.var_33148dd13745982f ) )
        {
            level.falling_rocks.var_33148dd13745982f = 0;
        }
        
        level.falling_rocks.var_33148dd13745982f = !level.falling_rocks.var_33148dd13745982f;
        
        if ( level.falling_rocks.var_33148dd13745982f )
        {
            /#
                iprintlnbold( "<dev string:xc0>" );
            #/
            
            level function_4670f2f74affdf6e();
            return;
        }
        
        /#
            iprintlnbold( "<dev string:xdb>" );
        #/
        
        level thread function_b0f21157e3b206b5( 0 );
    }

#/
