// script_2304453c69e996e2  (hash_2304453c69e996e2.gscc) (size: 28767 Bytes / 0x705f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a057501 (1510307073)
// size ...... 28767 (0x705f)
// includes .. 15  (offset: 0x6cef)
// strings ... 32  (offset: 0x6d67)
// dev strs .. 21  (offset: 0x6f4b)
// exports ... 78  (offset: 0x4907)
// cseg ...... 0x2d7 + 0x4630 (0x4907)
// imports ... 195 (offset: 0x5537)
// animtree1 . 0   (offset: 0x705f)
// animtree2 . 0   (offset: 0x705f)
#using script_20a226c24f1585bf;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\vehicles\damage;

#namespace namespace_28acf6540b1bc740;

// Namespace namespace_28acf6540b1bc740
// Params 5
// Checksum 0xee8675cb, Offset: 0x2f5
// Size: 0x37b
function function_49253856b6828e7e( spawn_ref, is_landed, preventrespawn, var_300037d32586873c, var_382a357bc5e77ba4 )
{
    heli = undefined;
    
    if ( !isdefined( is_landed ) )
    {
        is_landed = 0;
    }
    
    if ( !isdefined( preventrespawn ) )
    {
        preventrespawn = 1;
    }
    
    if ( !isdefined( var_300037d32586873c ) )
    {
        var_300037d32586873c = getscriptbundle( "helicoptersettings:default_helicopter_settings" );
    }
    
    if ( !isdefined( var_300037d32586873c ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = spawn_ref.origin + ( 0, 0, 128 );
    spawndata.angles = ( 0, 0, 0 );
    
    if ( isdefined( spawn_ref.angles ) )
    {
        spawndata.angles = ( 0, spawn_ref.angles[ 1 ], 0 );
    }
    
    spawndata.team = "team_hundred_ninety";
    heli_ref = var_300037d32586873c.helicopterref;
    
    switch ( heli_ref )
    {
        case #"hash_174ce9a6344b18a4":
            spawndata.model = "veh9_mil_air_heli_hind_vehphys_mp";
            break;
        case #"hash_66c8846b85d8c948":
            spawndata.model = "veh9_mil_air_heli_palfa_vehphys_mp";
            break;
        case #"hash_64b0f978ac4433ac":
            spawndata.model = "veh9_mil_air_heli_blima_mp";
            spawndata.initai = 1;
            break;
        default:
            if ( !isdefined( spawndata.model ) )
            {
                spawndata.model = "veh9_mil_air_heli_hind_vehphys_mp";
            }
            
            break;
    }
    
    if ( isdefined( var_300037d32586873c.initai ) )
    {
        spawndata.initai = var_300037d32586873c.initai;
    }
    
    heli = vehicle::spawn( heli_ref, spawndata );
    heli vehicle_spawn::prevent_respawn();
    
    if ( isdefined( var_382a357bc5e77ba4 ) )
    {
        heli.var_f44976ce3d7a444b = var_382a357bc5e77ba4;
    }
    else
    {
        heli.var_f44976ce3d7a444b = &heli_get_best_target;
    }
    
    assert( isdefined( heli ), "<dev string:x90>" );
    
    if ( getdvarint( @"hash_1a8fc884f08fce8", 0 ) == 1 )
    {
        heli function_23e279078bfd5c73();
        heli function_e8321f15d6f4b439();
        heli function_8ae160a4fd9dd21b();
        heli function_97b656b4a02e1db1();
        heli function_c9b82577c4e44bdc();
        heli function_5fcf52a0670a7f2b();
    }
    else
    {
        heli load_settings_bundle( var_300037d32586873c );
    }
    
    heli.is_landed = is_landed;
    heli function_2a29c9a4cf300465( heli_ref );
    heli function_b3828638860fe5f0();
    
    if ( heli.hasmissiles )
    {
        heli.missileweapon = makeweapon( heli.var_a0861aec2e22596f );
    }
    
    if ( heli.hasturret )
    {
        heli namespace_29dc0e7dd0232a5f::function_c096301eee95e66a( var_300037d32586873c.turretsettings, "team_hundred_ninety", [ "allies", "team_two_hundred" ], heli.var_f44976ce3d7a444b, 1 );
    }
    
    heli vehicle_damage::set_vehicle_hit_damage_data( "veh_jup_hind", 20 );
    heli.flaresreservecount = 1;
    heli.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        heli thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &heli_handlemissiledetection );
    }
    
    return heli;
}

// Namespace namespace_28acf6540b1bc740
// Params 4
// Checksum 0x9ab5b845, Offset: 0x679
// Size: 0x11d
function heli_spawn_simple( spawn_ref, heli_ref, is_landed, preventrespawn )
{
    heli = undefined;
    
    if ( !isdefined( is_landed ) )
    {
        is_landed = 0;
    }
    
    if ( !isdefined( preventrespawn ) )
    {
        preventrespawn = 1;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = spawn_ref.origin;
    spawndata.angles = ( 0, 0, 0 );
    
    if ( isdefined( spawn_ref.angles ) )
    {
        spawndata.angles = ( 0, spawn_ref.angles[ 1 ], 0 );
    }
    
    if ( !is_landed )
    {
        spawndata vehicle_spawn::set_flag( 10 );
    }
    
    spawndata.team = "team_hundred_ninety";
    heli = vehicle::spawn( heli_ref, spawndata );
    assert( isdefined( heli ), "<dev string:x90>" );
    
    if ( preventrespawn )
    {
        heli vehicle_spawn::prevent_respawn();
    }
    
    heli.is_landed = is_landed;
    heli function_2a29c9a4cf300465( heli_ref );
    heli function_b3828638860fe5f0();
    return heli;
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0x9d7812fc, Offset: 0x79f
// Size: 0x30
function function_b3828638860fe5f0()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"entitydeleted" );
    
    /#
        childthread function_a6252a223adbba4e();
    #/
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x6385feb4, Offset: 0x7d7
// Size: 0x29d
function private function_2a29c9a4cf300465( heli_ref )
{
    self.usedpositions = [];
    
    if ( !isdefined( self.speed ) )
    {
        self.speed = 40;
    }
    
    self.originalspeed = self.speed;
    self.accel = 50;
    self.lifetime = 9999;
    self.team = "team_hundred_ninety";
    
    if ( !isdefined( self.hover_min_height ) )
    {
        self.hover_min_height = 256;
    }
    
    self.heightoffset = ( 0, 0, self.hover_min_height );
    self.var_24954f14e27b448d = 1;
    self.attackers = [];
    
    if ( !isdefined( self.pathgoaldistance ) )
    {
        self.pathgoaldistance = 256;
    }
    
    if ( !isdefined( self.var_25ced6dafb5b15f0 ) )
    {
        self.var_25ced6dafb5b15f0 = 3;
    }
    
    if ( !isdefined( self.takeoffspeed ) )
    {
        self.takeoffspeed = 10;
    }
    
    if ( !isdefined( self.takeoffaccel ) )
    {
        self.takeoffaccel = 5;
    }
    
    if ( !isdefined( self.var_5de21a10a873b53b ) )
    {
        self.var_5de21a10a873b53b = 50;
    }
    
    if ( !isdefined( self.var_5f9f663db6f0dea8 ) )
    {
        self.var_5f9f663db6f0dea8 = 5;
    }
    
    if ( !isdefined( self.var_9f60eaf7ca90150b ) )
    {
        self.var_9f60eaf7ca90150b = 2.5;
    }
    
    if ( !isdefined( self.var_b31db762dfa1733a ) )
    {
        self.var_b31db762dfa1733a = 65536;
    }
    
    self setmaxpitchroll( 30, 30 );
    self vehicle_setspeed( self.speed, self.accel );
    
    if ( self.is_landed )
    {
        self sethoverparams( 0, 0, 0 );
    }
    else
    {
        self sethoverparams( self.var_5de21a10a873b53b, self.var_5f9f663db6f0dea8, self.var_9f60eaf7ca90150b );
    }
    
    self setturningability( self.var_25ced6dafb5b15f0 );
    self setyawspeed( 100, 25, 25, 0.1 );
    self setcandamage( 1 );
    self setneargoalnotifydist( self.pathgoaldistance );
    self setvehicleteam( self.team );
    self.ignorelist = [ self ];
    self.crashoffset = self.hover_min_height - 250;
    self.var_19a36b17776e8e85 = 1;
    self.damagestate = 3;
    sentientpoolmanager::registersentient( "Level_Vehicle", self.team );
    thread heli_watchdestroyed();
    damage::set_death_callback( vehicle::get_ref(), &function_9afa310cd0ae16ec );
    
    if ( self.var_929589dd4e96703 )
    {
        self.var_d62ad5bfd64ba592 = "tag_origin";
        damage::set_post_mod_damage_callback( vehicle::get_ref(), &heli_damage_callback );
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xd1f3e251, Offset: 0xa7c
// Size: 0x86
function function_ab8015f87929167( var_300037d32586873c )
{
    foreach ( turret in self.turrets )
    {
        turret namespace_29dc0e7dd0232a5f::function_23e279078bfd5c73( var_300037d32586873c );
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xacc965cd, Offset: 0xb0a
// Size: 0x39
function function_ee3f66cb01878073( var_804bd022dd245b4a )
{
    if ( !isdefined( self.deathcallbacks ) )
    {
        self.deathcallbacks = [];
    }
    
    self.deathcallbacks[ self.deathcallbacks.size ] = var_804bd022dd245b4a;
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0xdc936f0d, Offset: 0xb4b
    // Size: 0x5, Type: dev
    function function_8b3a316055cf0794()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x2d702f72, Offset: 0xb58
// Size: 0x152
function heli_get_best_target( vehicle )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"entitydeleted" );
    self endon( #"target_acquired" );
    canseetarget = 0;
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    var_847f780b10d918e5 = [ self ];
    childthread heli_target_attacker();
    targets = vehicle function_ce5b48c134b440cc( [ "team_two_hundred", "allies" ] );
    
    foreach ( target_ent in targets )
    {
        if ( !isdefined( target_ent ) )
        {
            waitframe();
            continue;
        }
        
        if ( isplayer( target_ent ) && isalive( target_ent ) )
        {
            if ( heli_can_see_player( target_ent ) )
            {
                return target_ent;
            }
            
            continue;
        }
        
        if ( isalive( target_ent ) && function_fb0e721df8b42022( target_ent ) )
        {
            return target_ent;
        }
        
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0xda603d9f, Offset: 0xcb3
// Size: 0x9d
function function_a2bb5fac9279568c()
{
    var_69ba50cc7f26c085 = 0;
    var_d40694d0f53c3c40 = undefined;
    
    foreach ( ent_num, damage in self.attackers )
    {
        if ( damage > var_69ba50cc7f26c085 )
        {
            var_69ba50cc7f26c085 = damage;
            var_d40694d0f53c3c40 = getentbynum( ent_num );
        }
    }
    
    return var_d40694d0f53c3c40;
}

// Namespace namespace_28acf6540b1bc740
// Params 2
// Checksum 0xd88dfaf0, Offset: 0xd59
// Size: 0x106
function heli_can_see_player( player, var_1f9796c825620045 )
{
    if ( player::isinlaststand( player ) || player.ignoreme || player.notarget )
    {
        return 0;
    }
    
    if ( !var_1f9796c825620045 && function_4de57a6807875242( self, player ) < self.var_359a527374fa8064 )
    {
        return 0;
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1 );
    var_847f780b10d918e5 = [ self ];
    
    if ( isdefined( player.vehicle ) )
    {
        var_847f780b10d918e5[ var_847f780b10d918e5.size ] = player.vehicle;
        linkedmodels = player.vehicle getlinkedchildren();
        
        if ( linkedmodels.size > 0 )
        {
            var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
        }
    }
    
    if ( player tagexists( "j_head" ) )
    {
        return trace::ray_trace_passed( self gettagorigin( "tag_origin" ), player gettagorigin( "j_head" ), var_847f780b10d918e5, contentsoverride );
    }
    
    return 0;
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x7d32d8d7, Offset: 0xe68
// Size: 0xc6
function function_fb0e721df8b42022( ai )
{
    if ( function_4de57a6807875242( self, ai ) < self.var_359a527374fa8064 )
    {
        return 0;
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    var_847f780b10d918e5 = [ self ];
    
    if ( isdefined( ai.vehicle ) && isdefined( ai.vehicle_position ) )
    {
        var_847f780b10d918e5[ var_847f780b10d918e5.size ] = ai.vehicle;
        linkedmodels = ai.vehicle getlinkedchildren();
        
        if ( linkedmodels.size > 0 )
        {
            var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
        }
    }
    
    return trace::ray_trace_passed( self gettagorigin( "tag_origin" ), ai geteye(), var_847f780b10d918e5, contentsoverride );
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0xf23afbaf, Offset: 0xf37
// Size: 0x69
function heli_target_attacker()
{
    self notify( #"hash_9febb889e954f706" );
    self endon( #"hash_9febb889e954f706" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker );
        
        /#
            iprintlnbold( "<dev string:xb8>" );
        #/
        
        self.current_target = eattacker;
        self notify( #"target_acquired" );
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xa76b5af1, Offset: 0xfa8
// Size: 0x54
function function_f43e4dc4bbf516f0( time )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"entitydeleted" );
    
    if ( !isdefined( time ) )
    {
        time = 20;
    }
    
    self.var_add5c69623c3a9 = 1;
    wait time;
    self.var_add5c69623c3a9 = 0;
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x2fb2cd13, Offset: 0x1004
// Size: 0xab
function function_ce5b48c134b440cc( teams )
{
    if ( !isdefined( teams ) )
    {
        return [];
    }
    
    ai_array = [];
    
    foreach ( var_acbd4516ae449911 in teams )
    {
        ai_array = arraycombine( ai_array, getaiarrayinradius( self.origin, self.var_24960c03fa7f9b9c, var_acbd4516ae449911 ) );
    }
    
    return ai_array;
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0x60af0c6c, Offset: 0x10b8
// Size: 0x1a
function function_74400b8d26d65fb4()
{
    return player_utility::script_getplayersinradius( self.origin, self.var_24960c03fa7f9b9c );
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0x5488d55c, Offset: 0x10db
    // Size: 0x5, Type: dev
    function function_6d46ead7c12232ba()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 7
// Checksum 0x92928fd2, Offset: 0x10e8
// Size: 0x120
function function_46aecd01789f50b9( start_node, forceheight, var_d2050607532bf167, var_8b67179c3b84956d, var_42a8262bdaccca7b, var_d62118dea3cf792f, missile_require_los = 0 )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"stop_patrol_behavior" );
    self endon( #"stop_all_action" );
    
    while ( true )
    {
        namespace_29dc0e7dd0232a5f::function_f8cbfe58b1b9a626( self.var_f44976ce3d7a444b );
        childthread function_9eae318628bb4e5();
        childthread action_follow_path( start_node, forceheight, var_d2050607532bf167 );
        self waittill( #"target_acquired" );
        
        if ( !isdefined( var_42a8262bdaccca7b ) || isdefined( var_42a8262bdaccca7b ) && [[ var_42a8262bdaccca7b ]]( self, self.current_target ) )
        {
            if ( isdefined( var_d62118dea3cf792f ) )
            {
                childthread function_9109f194b3ddf5ec( var_d62118dea3cf792f );
            }
            
            function_6df0a9fd10a79f2d( undefined, var_8b67179c3b84956d, missile_require_los );
        }
        
        start_node = self.next_target;
        self setturningability( self.var_25ced6dafb5b15f0 );
        self setneargoalnotifydist( self.pathgoaldistance );
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x43554f92, Offset: 0x1210
// Size: 0x7a
function private function_9eae318628bb4e5( target_callback_override )
{
    self notify( #"hash_e5bc78ebaf65fd8c" );
    self endon( #"hash_e5bc78ebaf65fd8c" );
    
    while ( true )
    {
        if ( isdefined( target_callback_override ) )
        {
            targ = [[ target_callback_override ]]( self );
        }
        else
        {
            targ = [[ self.var_f44976ce3d7a444b ]]( self );
        }
        
        if ( isdefined( targ ) )
        {
            self notify( #"target_acquired" );
            self.current_target = targ;
        }
        
        targ = undefined;
        wait 10;
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x4740239e, Offset: 0x1292
// Size: 0x3d
function private function_9109f194b3ddf5ec( callback )
{
    self waittill( #"start_combat" );
    
    while ( true )
    {
        if ( [[ callback ]]( self ) )
        {
            self clearlookatent();
            self notify( #"hash_e60ecc6ac7fedc01" );
            return;
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0x2b80b80f, Offset: 0x12d7
    // Size: 0x5, Type: dev
    function function_a0ccdefb38a14e5a()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xa332b9af, Offset: 0x12e4
// Size: 0xa0
function function_ff1ffdc836938991( target_ent )
{
    self endon( #"stop_all_action" );
    self.circlespeed = 80;
    self.hasmissiles = 0;
    self setmaxpitchroll( 20, 30 );
    thread function_f955e88a08827aa1( target_ent );
    
    if ( isdefined( target_ent ) )
    {
        self.current_target = target_ent;
    }
    
    if ( self.hasmissiles )
    {
        childthread behavior_combat_missile_handler();
    }
    
    thread function_f347f75e5fc7c455( target_ent );
    
    while ( true )
    {
        if ( isdefined( self.current_target ) )
        {
            function_123871f45b2ba0a1( self.current_target, 1, 0, 0, undefined, 2000, 1000, undefined, undefined );
        }
        
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x85be1968, Offset: 0x138c
// Size: 0x4e
function private function_f347f75e5fc7c455( target_ent )
{
    var_48ee71281f56f926 = gettime();
    
    while ( true )
    {
        if ( gettime() - var_48ee71281f56f926 > 15000 )
        {
            self notify( #"missile_attack" );
            function_5fb75177ce189204( target_ent );
            var_48ee71281f56f926 = gettime();
        }
        
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0xae58c541, Offset: 0x13e2
// Size: 0x3a
function private function_f955e88a08827aa1( target_ent )
{
    while ( true )
    {
        self notify( #"new_orders" );
        self.v_circle_pos = target_ent.origin;
        wait 1;
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 4
// Checksum 0x439786ba, Offset: 0x1424
// Size: 0x116
function heli_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            missiletarget.flaresreservecount--;
            missiletarget thread function_503ecb0c94067e45( fxtagoverride );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self.var_458d8d6ca334fa52 = 1;
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            level notify( #"flares", player );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x63786365, Offset: 0x1542
// Size: 0x4b
function function_503ecb0c94067e45( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0xd22215b5, Offset: 0x1595
    // Size: 0x5, Type: dev
    function function_31494e8ccb409974()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 4
// Checksum 0xe7727fbf, Offset: 0x15a2
// Size: 0xa6
function behavior_combat_location( target_position, var_6fddb8eb9453f721, target_callback_override, missile_require_los = 0 )
{
    self endon( #"hash_e60ecc6ac7fedc01" );
    self endon( #"stop_all_action" );
    self endon( #"crashing" );
    self endon( #"death" );
    self notify( #"start_combat" );
    
    if ( !isdefined( target_position ) )
    {
        return;
    }
    
    self.in_combat = 1;
    function_9b51c82324df2ab0( target_callback_override, missile_require_los );
    function_5c2b3bf48e5f88e1( target_position, 1, 1, 0, undefined, var_6fddb8eb9453f721, undefined, undefined, undefined );
    self.in_combat = 0;
}

// Namespace namespace_28acf6540b1bc740
// Params 3
// Checksum 0x436ce34, Offset: 0x1650
// Size: 0xc2
function function_6df0a9fd10a79f2d( target_ent, target_callback_override, missile_require_los = 0 )
{
    self endon( #"hash_e60ecc6ac7fedc01" );
    self endon( #"stop_all_action" );
    self endon( #"crashing" );
    self endon( #"death" );
    self notify( #"start_combat" );
    self.in_combat = 1;
    function_9b51c82324df2ab0( target_callback_override, missile_require_los );
    
    if ( isdefined( target_ent ) )
    {
        self.current_target = target_ent;
    }
    
    while ( true )
    {
        if ( isdefined( self.current_target ) )
        {
            function_123871f45b2ba0a1( self.current_target, 1, 1, 0, undefined, undefined, undefined, undefined, undefined );
        }
        
        waitframe();
    }
    
    self.in_combat = 0;
}

// Namespace namespace_28acf6540b1bc740
// Params 2
// Checksum 0x997050a7, Offset: 0x171a
// Size: 0x4d
function function_9b51c82324df2ab0( target_callback_override, missile_require_los = 0 )
{
    if ( isdefined( target_callback_override ) )
    {
        namespace_29dc0e7dd0232a5f::function_f8cbfe58b1b9a626( &function_857cd9daf5a97105 );
    }
    
    childthread function_9eae318628bb4e5( target_callback_override );
    
    if ( self.hasmissiles )
    {
        childthread behavior_combat_missile_handler( missile_require_los );
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x4a3cccd4, Offset: 0x176f
// Size: 0x17
function private function_857cd9daf5a97105( vehicle )
{
    return vehicle.current_target;
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x119ddbf7, Offset: 0x178f
// Size: 0x1ed
function private behavior_combat_missile_handler( require_los = 0 )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self.var_bca7b230064b0a4d = gettime();
    
    while ( true )
    {
        time_elapsed = gettime() - self.var_bca7b230064b0a4d;
        
        if ( time_elapsed > self.missileinterval )
        {
            var_6d459758e3503c2e = self.current_target;
            
            if ( require_los )
            {
                if ( isplayer( var_6d459758e3503c2e ) && !heli_can_see_player( var_6d459758e3503c2e ) )
                {
                    wait 1;
                    continue;
                }
                else if ( isai( var_6d459758e3503c2e ) && !function_fb0e721df8b42022( var_6d459758e3503c2e ) )
                {
                    wait 1;
                    continue;
                }
            }
            
            if ( isdefined( var_6d459758e3503c2e ) )
            {
                pitch = utility::getpitchtospot3d( var_6d459758e3503c2e.origin );
                
                if ( pitch > self.var_be9c0cb162230c9c )
                {
                    waitframe();
                    continue;
                }
                
                vector_to_target = vectornormalize2( var_6d459758e3503c2e.origin - self.origin );
                var_5e511bb44c6ee311 = self.origin + vector_to_target * 4000;
                obstructiontrace = heli_sphere_trace( self.origin, var_5e511bb44c6ee311, 325, self.ignorelist );
                var_2e2c6e392d6675fb = obstructiontrace[ "hittype" ] == "hittype_none";
                
                if ( !var_2e2c6e392d6675fb )
                {
                    wait 1;
                    continue;
                }
                
                self notify( #"resume_circling" );
                thread function_aa9098f4acf1fa3e( undefined, 1 );
                self waittill( #"circling_paused" );
                wait 1;
                missiles_attack_entity( var_6d459758e3503c2e );
                utility::waittill_any_ents( self, "strafe_complete", var_6d459758e3503c2e, "death" );
                self.var_bca7b230064b0a4d = gettime();
                self notify( #"resume_circling" );
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0x2602cdb5, Offset: 0x1984
    // Size: 0x5, Type: dev
    function function_6548f8d23d1fef0()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 5
// Checksum 0x93d780a, Offset: 0x1991
// Size: 0x24b
function action_follow_path( start_node, forceheight, speedoverride, isdrone, toendnode )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"new_orders" );
    self endon( #"stop_all_action" );
    
    if ( !isdefined( start_node ) )
    {
        assertmsg( "<dev string:xd1>" );
        return;
    }
    
    self.next_target = start_node;
    path_end = 0;
    self setturningability( self.var_25ced6dafb5b15f0 );
    self setneargoalnotifydist( self.pathgoaldistance );
    
    while ( !path_end )
    {
        if ( isdefined( self.next_target ) )
        {
            function_7fb408948b1225e0( self.next_target, path_end, forceheight, 1, undefined, undefined, speedoverride, undefined, undefined, isdrone, 0 );
        }
        
        if ( self.next_target.target )
        {
            if ( utility::issharedfuncdefined( #"hash_bd3211c9481a757d", #"hash_4e9284bb6b290f31" ) )
            {
                self.next_target = utility::callsharedfunc( #"hash_bd3211c9481a757d", #"hash_4e9284bb6b290f31", self, self.next_target.target );
            }
            else if ( isstruct( self.next_target ) )
            {
                self.next_target = utility::getstruct( self.next_target.target, "targetname" );
            }
            else if ( isent( self.next_target ) )
            {
                self.next_target = getent( self.next_target.target, #targetname );
            }
            else
            {
                self.next_target = getvehiclenode( self.next_target.target, #targetname );
            }
        }
        else
        {
            self.next_target = undefined;
        }
        
        if ( !isdefined( self.next_target ) || !toendnode && !isdefined( self.next_target.target ) )
        {
            path_end = 1;
        }
        
        waitframe();
    }
    
    self notify( #"follow_path_complete" );
}

// Namespace namespace_28acf6540b1bc740
// Params 4
// Checksum 0xff1efbff, Offset: 0x1be4
// Size: 0xd2
function function_e4b3e93ed1c741fc( position, var_51ef870503967f06, var_5e7126de91636ee5, isdrone )
{
    self endon( #"stop_all_action" );
    wait 0.5;
    var_241efc7b886a40e2 = 80;
    var_ae6923acd2ff2503 = 18;
    self.current_angle += 180;
    self.current_angle = angleclamp( self.current_angle );
    vector_to_target = vectornormalize2( position - self.origin );
    var_5e511bb44c6ee311 = self.origin + vector_to_target * var_5e7126de91636ee5;
    function_7fb408948b1225e0( var_5e511bb44c6ee311, undefined, var_51ef870503967f06, 0, undefined, undefined, var_241efc7b886a40e2, var_ae6923acd2ff2503, 1, isdrone );
    self notify( #"strafe_complete" );
}

// Namespace namespace_28acf6540b1bc740
// Params 5
// Checksum 0x80cc781f, Offset: 0x1cbe
// Size: 0x1fd
function action_flee( var_6506c9c43682325, flee_speed = 100, flee_distance = 15000, flee_height = 15000, var_e4df2f5352397c9c = 1 )
{
    if ( var_6506c9c43682325 )
    {
        self notify( #"stop_all_action" );
    }
    
    self endon( #"stop_all_action" );
    
    if ( var_e4df2f5352397c9c )
    {
        foreach ( turret in self.turrets )
        {
            turret namespace_29dc0e7dd0232a5f::function_c5e47f89c2e5b5c9();
        }
    }
    
    self clearlookatent();
    function_7fb408948b1225e0( self.origin + ( 0, 0, 1500 ), 0, 0, 0, undefined, undefined, flee_speed, undefined, 1 );
    result = 0;
    flee_directions = [ anglestoforward( self.angles ), anglestoleft( self.angles ), anglestoright( self.angles ), anglestoforward( self.angles ) * -1, anglestoup( self.angles ) ];
    idx = 0;
    
    while ( !result && idx < flee_directions.size )
    {
        direction = flee_directions[ idx ];
        flee_position = self.origin + direction * ( flee_distance, flee_distance, 0 ) + ( 0, 0, flee_height );
        result = function_7fb408948b1225e0( flee_position, 0, 0, 0, undefined, undefined, 70, undefined, 1 );
        idx++;
        wait 0.3;
    }
    
    self delete();
}

// Namespace namespace_28acf6540b1bc740
// Params 10
// Checksum 0x916313b4, Offset: 0x1ec3
// Size: 0x8f
function function_123871f45b2ba0a1( e_target_ent, b_face_target, var_c3a1ceb988b275d4, stop_at_goal, var_4e7d074c770492a, var_c4b0558ab653e589, var_7ffff597a6f3f40e, var_3003cb5bcb323e19, var_a312f43cba340a6a, isdrone )
{
    self.var_5bef37d3cbf96de8 = e_target_ent;
    function_e66f40034d8b45fc( e_target_ent.origin, b_face_target, var_c3a1ceb988b275d4, stop_at_goal, var_4e7d074c770492a, &function_6d9f4da4f49a6f15, var_c4b0558ab653e589, var_7ffff597a6f3f40e, var_3003cb5bcb323e19, var_a312f43cba340a6a, 1, isdrone );
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x154d85d0, Offset: 0x1f5a
// Size: 0x4e
function function_6d9f4da4f49a6f15( heli )
{
    if ( utility::is_dead_or_dying( heli.var_5bef37d3cbf96de8 ) )
    {
        heli.var_5bef37d3cbf96de8 = undefined;
        heli notify( #"stop_circling" );
        return;
    }
    
    return heli.var_5bef37d3cbf96de8.origin;
}

// Namespace namespace_28acf6540b1bc740
// Params 11
// Checksum 0x7527d658, Offset: 0x1fb1
// Size: 0x7c
function function_5c2b3bf48e5f88e1( var_ff3024f4fa399451, b_face_target, var_c3a1ceb988b275d4, stop_at_goal, var_4e7d074c770492a, var_6fddb8eb9453f721, var_c4b0558ab653e589, var_7ffff597a6f3f40e, var_3003cb5bcb323e19, var_a312f43cba340a6a, isdrone )
{
    function_e66f40034d8b45fc( var_ff3024f4fa399451, b_face_target, var_c3a1ceb988b275d4, stop_at_goal, var_4e7d074c770492a, var_6fddb8eb9453f721, var_c4b0558ab653e589, var_7ffff597a6f3f40e, var_3003cb5bcb323e19, var_a312f43cba340a6a, isdrone );
}

// Namespace namespace_28acf6540b1bc740
// Params 12, eflags: 0x4
// Checksum 0x8a695318, Offset: 0x2035
// Size: 0x76e
function private function_e66f40034d8b45fc( var_ff3024f4fa399451, b_face_target, var_c3a1ceb988b275d4, stop_at_goal, var_4e7d074c770492a, var_6fddb8eb9453f721, var_c4b0558ab653e589, var_7ffff597a6f3f40e, var_3003cb5bcb323e19, n_max_offset, var_b7fbe991efa022ac, isdrone )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"stop_circling" );
    self endon( #"stop_all_action" );
    self setneargoalnotifydist( self.circlegoaldist );
    self setturningability( self.var_c80756b7848967f9 );
    var_3a381989f1da2145 = getdvarint( @"hash_2c1d3a8768e5e585", 0 );
    self.v_circle_pos = var_ff3024f4fa399451 + ( 0, 0, self.circleheight );
    var_b7793e7b5fcec255 = undefined;
    e_circle_pos = undefined;
    
    if ( !isdefined( b_face_target ) )
    {
        b_face_target = 0;
    }
    
    if ( !isdefined( var_c3a1ceb988b275d4 ) )
    {
        var_c3a1ceb988b275d4 = 0;
    }
    
    if ( isdefined( var_7ffff597a6f3f40e ) )
    {
        self.circleheight = var_7ffff597a6f3f40e;
    }
    
    assert( isdefined( self.v_circle_pos ), "<dev string:xf6>" );
    var_4c261efd47b93c6c = distance2d( self.origin, self.v_circle_pos );
    n_circle_radius = randomintrange( self.circleradiusmin, self.circleradiusmax );
    
    if ( isdefined( var_c4b0558ab653e589 ) )
    {
        n_circle_radius = var_c4b0558ab653e589;
    }
    
    if ( var_4c261efd47b93c6c < n_circle_radius )
    {
        n_circle_radius = max( var_4c261efd47b93c6c, self.circleradiusmin );
    }
    
    var_77d7a466731c3f2 = self.var_b4626596a35ba4eb;
    
    if ( isdefined( n_max_offset ) )
    {
        var_77d7a466731c3f2 = n_max_offset * n_max_offset;
    }
    else if ( isdefined( self.var_77d7a466731c3f2 ) )
    {
        var_77d7a466731c3f2 = self.var_77d7a466731c3f2 * self.var_77d7a466731c3f2;
    }
    
    var_2e2c6e392d6675fb = 0;
    var_fb4baeea3f45de3b = 0;
    
    while ( !var_2e2c6e392d6675fb )
    {
        self.current_angle = function_2c23da24d4b3f4e( self.v_circle_pos, n_circle_radius, var_fb4baeea3f45de3b );
        var_653ed91ecc6af9bc = 32;
        var_c8b94ca090f5bb27 = 360 / var_653ed91ecc6af9bc;
        starttime = gettime();
        self.lastattackedtime = gettime();
        newgoal = self.v_circle_pos + anglestoforward( ( 0, self.current_angle, 0 ) ) * n_circle_radius;
        obstructiontrace = heli_sphere_trace( self.origin, newgoal, 325, self.ignorelist );
        var_2e2c6e392d6675fb = obstructiontrace[ "hittype" ] == "hittype_none";
        var_bb4635df3800979f = 0;
        
        /#
            if ( var_3a381989f1da2145 == 1 )
            {
                duration = 200;
                
                if ( !var_2e2c6e392d6675fb )
                {
                    sphere( obstructiontrace[ "<dev string:x116>" ], 325, ( 1, 0, 0 ), 0, duration );
                    line( self.origin, obstructiontrace[ "<dev string:x116>" ], ( 1, 0, 0 ), 1, 0, duration );
                    line( self.origin, newgoal, ( 0, 1, 0 ), 1, 0, duration );
                    sphere( newgoal, 325, ( 0, 1, 0 ), 0, duration );
                }
                else
                {
                    line( self.origin, newgoal, ( 0, 1, 0 ), 1, 0, duration );
                    sphere( newgoal, 325, ( 0, 1, 0 ), 0, duration );
                }
            }
        #/
        
        var_fb4baeea3f45de3b++;
        wait 0.25;
    }
    
    while ( var_2e2c6e392d6675fb )
    {
        if ( isdefined( var_3003cb5bcb323e19 ) )
        {
            var_8be444144e4c068e = gettime() - starttime;
            
            if ( utility::function_6f5d2e1f1ff70482( var_8be444144e4c068e ) > var_3003cb5bcb323e19 )
            {
                break;
            }
        }
        
        /#
            if ( var_3a381989f1da2145 == 1 )
            {
                thread function_f6aeb2efc441e4b8( n_circle_radius, self.v_circle_pos );
            }
        #/
        
        newgoal = self.v_circle_pos + anglestoforward( ( 0, self.current_angle, 0 ) ) * n_circle_radius;
        
        if ( !var_bb4635df3800979f )
        {
            /#
                if ( var_3a381989f1da2145 == 1 )
                {
                    duration = 200;
                    line( self.origin, newgoal, ( 0, 1, 0 ), 1, 0, duration );
                    sphere( newgoal, 325, ( 0, 1, 0 ), 0, duration );
                }
            #/
            
            obstructiontrace = heli_sphere_trace( self.origin, newgoal, 325, self.ignorelist );
            
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                /#
                    if ( var_3a381989f1da2145 == 1 )
                    {
                        duration = 200;
                        sphere( obstructiontrace[ "<dev string:x116>" ], 325, ( 1, 0, 0 ), 0, duration );
                        line( self.origin, obstructiontrace[ "<dev string:x116>" ], ( 1, 0, 0 ), 1, 0, duration );
                    }
                #/
                
                self.var_14f2fa0e268c45c = !self.var_14f2fa0e268c45c;
                self.current_angle += ( self.var_14f2fa0e268c45c ? var_c8b94ca090f5bb27 * -1 : var_c8b94ca090f5bb27 ) * 2;
                self.current_angle = angleclamp( self.current_angle );
                self.v_circle_pos = ( self.v_circle_pos[ 0 ], self.v_circle_pos[ 1 ], self.v_circle_pos[ 2 ] + 100 );
                var_bb4635df3800979f = 1;
                continue;
            }
        }
        
        self.current_angle += self.var_14f2fa0e268c45c ? var_c8b94ca090f5bb27 * -1 : var_c8b94ca090f5bb27;
        self.current_angle = angleclamp( self.current_angle );
        var_bb4635df3800979f = 0;
        
        /#
            if ( var_3a381989f1da2145 == 1 )
            {
                duration = 200;
                print3d( self.origin, string( self.current_angle ), ( 1, 1, 1 ), 1, 1, duration, 1 );
            }
        #/
        
        if ( b_face_target )
        {
            if ( isdefined( self.current_target ) )
            {
                self clearlookatent();
                waitframe();
                self setlookatent( self.current_target );
            }
        }
        
        var_b77ee1669de9b9a5 = self.circlespeed;
        
        if ( isdefined( self.var_b77ee1669de9b9a5 ) )
        {
            var_b77ee1669de9b9a5 = self.var_b77ee1669de9b9a5;
        }
        
        function_7fb408948b1225e0( newgoal, stop_at_goal, self.circleheight, 1, undefined, undefined, var_b77ee1669de9b9a5, undefined, undefined, isdrone );
        
        while ( self.var_43b5b89a43493445 )
        {
            self notify( #"circling_paused" );
            var_dd2beb1524621153 = 1;
            waitframe();
        }
        
        if ( var_c3a1ceb988b275d4 && isdefined( self.current_target ) && !var_dd2beb1524621153 )
        {
            if ( trace::ray_trace_passed( self.current_target geteye(), self.origin, [ self.current_target, self ] ) )
            {
                function_aa9098f4acf1fa3e( randomfloatrange( 0, 5 ) );
            }
        }
        else if ( var_dd2beb1524621153 )
        {
            var_dd2beb1524621153 = 0;
        }
        
        if ( isdefined( var_6fddb8eb9453f721 ) )
        {
            var_b566f4625566eb4c = [[ var_6fddb8eb9453f721 ]]( self );
            
            if ( isdefined( var_b566f4625566eb4c ) )
            {
                self.v_circle_pos = ( var_b566f4625566eb4c[ 0 ], var_b566f4625566eb4c[ 1 ], var_b566f4625566eb4c[ 2 ] + self.circleheight );
            }
        }
        
        waitframe();
    }
    
    self clearlookatent();
    self.var_c6e65a7a13e3c203 = undefined;
    self.var_4ba494da3b235c5a = undefined;
    self notify( #"stop_circling" );
}

// Namespace namespace_28acf6540b1bc740
// Params 2
// Checksum 0x2b4d4216, Offset: 0x27ab
// Size: 0xea
function function_aa9098f4acf1fa3e( pause_time, var_9f4caedfd8bb8198 )
{
    self notify( #"pause_circling" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"stop_circling" );
    self endon( #"pause_circling" );
    self.var_43b5b89a43493445 = 1;
    
    if ( var_9f4caedfd8bb8198 )
    {
        self sethoverparams( 100, 10, 5 );
        self waittill( #"resume_circling" );
        self sethoverparams( self.var_5de21a10a873b53b, self.var_5f9f663db6f0dea8, self.var_9f60eaf7ca90150b );
    }
    else if ( isdefined( pause_time ) )
    {
        self sethoverparams( 100, 10, 5 );
        wait pause_time;
        self sethoverparams( self.var_5de21a10a873b53b, self.var_5f9f663db6f0dea8, self.var_9f60eaf7ca90150b );
    }
    
    self.var_43b5b89a43493445 = 0;
}

// Namespace namespace_28acf6540b1bc740
// Params 11
// Checksum 0xd8a9c092, Offset: 0x289d
// Size: 0x4ba, Type: bool
function function_7fb408948b1225e0( target, forcestopatgoal, forceheight, ignoreblocks, goalyaw, var_e9ca5aa21db2f7d0, speedoverride, acceloverride, var_fa6ff957b3a44683, isdrone, var_c6f9f9e5e46cf569 = 1 )
{
    self notify( #"state_change" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"new_orders" );
    self endon( #"state_change" );
    self endon( #"stop_all_action" );
    newpos = undefined;
    var_86df004d2aa1e17b = undefined;
    unload = 0;
    var_e16e53b6a3b7749d = 0;
    var_5bdcdba698716361 = 0;
    
    if ( !isdefined( goalyaw ) )
    {
        goalyaw = undefined;
    }
    
    var_3a381989f1da2145 = getdvarint( @"hash_2c1d3a8768e5e585", 0 );
    testtarget = target;
    assert( isdefined( target ), "<dev string:x11f>" );
    
    if ( !isvector( target ) )
    {
        testtarget = target.origin;
        
        if ( isdefined( target.script_goalyaw ) )
        {
            goalyaw = target.script_goalyaw;
        }
        
        if ( isdefined( target.script_anglevehicle ) )
        {
            var_86df004d2aa1e17b = target.script_anglevehicle;
        }
        
        if ( isdefined( target.script_unload ) )
        {
            unload = target.script_unload;
        }
        
        var_e16e53b6a3b7749d = isdefined( target.script_flag_wait );
        var_5bdcdba698716361 = !isdefined( target.target );
    }
    
    var_bad93cf3858febd4 = forceheight ?? self.hover_min_height;
    traceradius = isdrone ? 32 : 325;
    ignorelist = self.ignorelist;
    
    while ( true )
    {
        xpos = testtarget[ 0 ];
        ypos = testtarget[ 1 ];
        zpos = testtarget[ 2 ];
        
        if ( var_c6f9f9e5e46cf569 || isdefined( forceheight ) )
        {
            ground_point = getgroundposition( testtarget, traceradius, var_bad93cf3858febd4 );
            
            if ( isdefined( ground_point ) )
            {
                zpos = ground_point[ 2 ] + var_bad93cf3858febd4;
                
                /#
                    if ( var_3a381989f1da2145 )
                    {
                        sphere( ( xpos, ypos, ground_point[ 2 ] ), traceradius, ( 1, 0, 1 ), undefined, 100 );
                    }
                #/
            }
        }
        
        currentpos = self.origin;
        initialgoalpos = ( xpos, ypos, zpos );
        obstructed = 0;
        
        if ( !ignoreblocks )
        {
            obstructiontrace = heli_sphere_trace( currentpos, initialgoalpos, traceradius, ignorelist );
            
            if ( isdefined( obstructiontrace ) )
            {
                if ( obstructiontrace[ "hittype" ] != "hittype_none" )
                {
                    if ( var_fa6ff957b3a44683 )
                    {
                        return false;
                    }
                    
                    xpos = obstructiontrace[ "position" ][ 0 ];
                    ypos = obstructiontrace[ "position" ][ 1 ];
                    obstructed = 1;
                    ground_point = getgroundposition( obstructiontrace[ "position" ], traceradius, 2500, 2000 );
                    ground_point_z = isdefined( ground_point ) ? ground_point[ 2 ] : 2000;
                    
                    /#
                        if ( var_3a381989f1da2145 )
                        {
                            sphere( obstructiontrace[ "<dev string:x116>" ], traceradius, ( 1, 0, 0 ), undefined, 100 );
                            sphere( ( xpos, ypos, ground_point_z ), traceradius, ( 1, 0, 1 ), undefined, 100 );
                        }
                    #/
                }
            }
        }
        
        if ( obstructed )
        {
            zpos = ground_point_z + var_bad93cf3858febd4;
        }
        
        zpos = clamp( zpos, 0, 8000 );
        newpos = ( xpos, ypos, zpos );
        
        /#
            if ( var_3a381989f1da2145 )
            {
                sphere( newpos, traceradius, ( 1, 1, 0 ), undefined, 100 );
            }
        #/
        
        stopatgoal = 0;
        
        if ( forcestopatgoal && !obstructed )
        {
            stopatgoal = forcestopatgoal;
        }
        
        /#
            if ( var_3a381989f1da2145 == 1 )
            {
                thread function_de283d7dd885a5b2( newpos );
                thread function_de283d7dd885a5b2( initialgoalpos, ( 0, 1, 0 ) );
            }
        #/
        
        speed = undefined;
        
        if ( isdefined( speedoverride ) )
        {
            speed = speedoverride;
        }
        else if ( !isvector( target ) && isdefined( target.script_speed ) )
        {
            speed = target.script_speed;
            
            if ( self.hack_speed_scale )
            {
                speed *= self.hack_speed_scale;
                self.var_677dfac95a9a8a5f = speed;
            }
        }
        else
        {
            speed = self.speed;
        }
        
        self vehicle_helisetai( newpos, speed, acceloverride, 50, isdefined( goalyaw ) ? 1 : undefined, var_86df004d2aa1e17b, goalyaw ?? 0, undefined, 0, stopatgoal, unload, var_e16e53b6a3b7749d, var_5bdcdba698716361 );
        msg = utility::waittill_any_return( "near_goal", "begin_evasive_maneuvers" );
        
        if ( !obstructed )
        {
            break;
        }
    }
    
    return true;
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xbe9d3065, Offset: 0x2d60
// Size: 0x151
function function_c261b0193c82f3bd( target_location )
{
    self notify( #"new_orders" );
    self endon( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( !isdefined( target_location ) )
    {
        target_location = self.origin;
    }
    
    self sethoverparams( self.var_5de21a10a873b53b, self.var_5f9f663db6f0dea8, self.var_9f60eaf7ca90150b );
    self vehicle_setspeed( self.takeoffspeed, self.takeoffaccel );
    wait 2;
    function_7fb408948b1225e0( target_location, 1 );
    self.is_landed = 0;
    
    if ( self.turrets.size > 0 )
    {
        foreach ( turret in self.turrets )
        {
            turret.turreton = 1;
        }
    }
    
    self vehicle_setspeed( self.originalspeed, self.accel );
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x6d03a3e3, Offset: 0x2eb9
// Size: 0x178
function function_b92f0b19a435f196( target_location )
{
    self notify( #"new_orders" );
    self endon( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( !isdefined( target_location ) )
    {
        target_location = self.origin;
    }
    
    function_7fb408948b1225e0( target_location, 1, undefined, 1 );
    target_origin = !isvector( target_location ) ? target_location.origin : target_location;
    
    while ( distance2dsquared( self.origin, target_origin ) > self.var_b31db762dfa1733a )
    {
        waitframe();
    }
    
    self vehicle_setspeed( self.takeoffspeed, self.takeoffaccel );
    function_7fb408948b1225e0( target_location, 1, undefined, 1, undefined, 1, undefined, undefined, undefined, undefined, 0 );
    self.is_landed = 1;
    
    if ( self.turrets.size > 0 )
    {
        foreach ( turret in self.turrets )
        {
            turret.turreton = 0;
        }
    }
    
    self sethoverparams( 0, 0, 0 );
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0x187cfce5, Offset: 0x3039
    // Size: 0x5, Type: dev
    function function_7732fddf39a39d74()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xbd7dcb0f, Offset: 0x3046
// Size: 0x86
function function_5fb75177ce189204( target_ent )
{
    self endon( #"missile_attack" );
    self setlookatent( target_ent );
    dot = 0;
    
    while ( dot < 0.98 )
    {
        vector_to_target = target_ent.origin - self.origin;
        var_e3eb0afdf490177f = anglestoforward( self.angles );
        dot = vectordot2( vector_to_target, var_e3eb0afdf490177f, 1 );
        waitframe();
    }
    
    thread missiles_aim_at_target( target_ent );
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x34f33713, Offset: 0x30d4
// Size: 0x9d
function private missiles_attack_entity( target_ent )
{
    self setlookatent( target_ent );
    target_ent endon( #"death" );
    dot = 0;
    
    while ( dot < 0.98 )
    {
        vector_to_target = target_ent.origin - self.origin;
        var_e3eb0afdf490177f = anglestoforward( self.angles );
        dot = vectordot2( vector_to_target, var_e3eb0afdf490177f, 1 );
        waitframe();
    }
    
    childthread function_e4b3e93ed1c741fc( target_ent.origin, 0, 4000 );
    childthread missiles_aim_at_target( target_ent );
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x3dd01652, Offset: 0x3179
// Size: 0x92
function private missiles_aim_at_target( target_ent )
{
    self endon( #"strafe_complete" );
    childthread function_4e4e1de5e536dc97( target_ent );
    childthread function_307735a2b81d6fc7();
    dot = 0;
    
    while ( dot < 0.98 )
    {
        vector_to_target = vectornormalize( target_ent.origin - self.origin );
        var_e3eb0afdf490177f = vectornormalize( anglestoforward( self.angles ) );
        dot = vectordot( vector_to_target, var_e3eb0afdf490177f );
        waitframe();
    }
    
    function_c81c81b0813d5a7c();
}

// Namespace namespace_28acf6540b1bc740
// Params 0, eflags: 0x4
// Checksum 0xbd853467, Offset: 0x3213
// Size: 0x22
function private function_307735a2b81d6fc7()
{
    self waittill( #"hash_d433a3dd0a54b81f" );
    function_2e5f86468baab203( self.angles[ 0 ], 0 );
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x492ad281, Offset: 0x323d
// Size: 0x2d
function private function_4e4e1de5e536dc97( target_ent )
{
    self endon( #"hash_d433a3dd0a54b81f" );
    self endon( #"strafe_complete" );
    function_59487e919b0a6b82( target_ent );
}

// Namespace namespace_28acf6540b1bc740
// Params 0, eflags: 0x4
// Checksum 0xb3723b64, Offset: 0x3272
// Size: 0x10f
function private function_c81c81b0813d5a7c()
{
    self.gunattacks = 0;
    self.team = "team_hundred_ninety";
    missiletags = [ "tag_gun_right1", "tag_gun_left1", "tag_gun_right2", "tag_gun_left2" ];
    var_cffd7743119e8726 = 4;
    wait 1;
    
    for ( i = 0; i < var_cffd7743119e8726 ; i++ )
    {
        missilestart = self gettagorigin( missiletags[ i % 4 ] ) + anglestoforward( self.angles + ( 0, 0, 0 ) ) * 200;
        missileend = self gettagorigin( missiletags[ i % 4 ] ) + anglestoforward( self.angles + ( 6, 0, 0 ) ) * 1000;
        missile = weapon_utility::_magicbullet( self.missileweapon, missilestart, missileend, self );
        wait 0.3;
    }
    
    self notify( #"hash_d433a3dd0a54b81f" );
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 0
    // Checksum 0xf3a277a6, Offset: 0x3389
    // Size: 0x5, Type: dev
    function function_a2cbb14475f593f6()
    {
        
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 7, eflags: 0x4
// Checksum 0xbef7686b, Offset: 0x3396
// Size: 0x142
function private heli_sphere_trace( start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables )
{
    /#
        dist = distance( start, end );
        println( "<dev string:x148>" + start + "<dev string:x163>" + end + "<dev string:x16a>" + radius + "<dev string:x174>" + dist );
        
        if ( getdvarint( @"hash_2c1d3a8768e5e585", 0 ) || getdvarint( @"hash_9aa835d8fcd3b58d", 0 ) )
        {
            sphere( start, radius, ( 1, 0, 0 ), undefined, 100 );
            line( start, end, ( 1, 0, 0 ), 1, undefined, 100 );
            sphere( end, radius, ( 1, 0, 0 ), undefined, 100 );
            
            if ( !isdefined( level.var_4721e7dc1cdeddc8 ) )
            {
                level.var_4721e7dc1cdeddc8 = 0;
            }
            else
            {
                level.var_4721e7dc1cdeddc8++;
            }
            
            iprintln( "<dev string:x180>" + level.var_4721e7dc1cdeddc8 + "<dev string:x174>" + dist );
        }
    #/
    
    return trace::sphere_trace( start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables );
}

// Namespace namespace_28acf6540b1bc740
// Params 3, eflags: 0x4
// Checksum 0xf7a5f23b, Offset: 0x34e1
// Size: 0x33c
function private function_2c23da24d4b3f4e( circleorigin, circleradius, interval )
{
    var_1974c128668ff48b = anglestoforward( self.angles );
    var_e031e97496849a0d = vectornormalize( var_1974c128668ff48b * ( 1, 1, 0 ) );
    var_1f7f5743bf70a83 = anglestoleft( self.angles );
    var_6bcd39a48446ec5 = vectornormalize( var_1f7f5743bf70a83 * ( 1, 1, 0 ) );
    var_6b0625dc0e52d3e1 = circleorigin - self.origin;
    var_2ec4b382d7a32ab7 = vectornormalize( var_6b0625dc0e52d3e1 * ( 1, 1, 0 ) );
    var_2e9b9b1136e2fd49 = vectordot( var_e031e97496849a0d, var_2ec4b382d7a32ab7 );
    var_fada0e714ea79291 = vectordot( var_6bcd39a48446ec5, var_2ec4b382d7a32ab7 );
    
    if ( var_2e9b9b1136e2fd49 > 0 )
    {
        self.var_14f2fa0e268c45c = var_fada0e714ea79291 > 0 ? 0 : 1;
    }
    else
    {
        self.var_14f2fa0e268c45c = var_fada0e714ea79291 > 0 ? 1 : 0;
    }
    
    rotationangle = var_fada0e714ea79291 > 0 ? ( 0, -90, 0 ) : ( 0, 90, 0 );
    var_23230fd41d82d289 = rotatevector( var_e031e97496849a0d, rotationangle );
    
    /#
        var_3a381989f1da2145 = getdvarint( @"hash_2c1d3a8768e5e585", 0 );
        
        if ( var_3a381989f1da2145 )
        {
            duration = 8000;
            var_c434259132da2463 = circleorigin + var_23230fd41d82d289 * circleradius;
            var_20b3436a8a94847b = 200;
            spherecolor = var_2e9b9b1136e2fd49 > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            line( self.origin, self.origin + var_e031e97496849a0d * var_20b3436a8a94847b, ( 1, 0, 0 ), 1, 0, duration );
            line( self.origin, self.origin + var_6bcd39a48446ec5 * var_20b3436a8a94847b, ( 0, 0, 1 ), 1, 0, duration );
            line( self.origin, self.origin + var_23230fd41d82d289 * var_20b3436a8a94847b, ( 0.01, 0.85, 1 ), 1, 0, duration );
            line( self.origin, self.origin + var_6b0625dc0e52d3e1, ( 1, 0.92, 0.16 ), 1, 0, duration );
            line( circleorigin, var_c434259132da2463, ( 0.98, 0.75, 0.79 ), 1, 0, duration );
            sphere( circleorigin, 10, spherecolor, 0, duration );
            debugtext = "<dev string:x19b>";
            debugtext = var_2e9b9b1136e2fd49 > 0 ? "<dev string:x19c>" : "<dev string:x1a2>";
            debugtext += var_fada0e714ea79291 > 0 ? "<dev string:x1a7>" : "<dev string:x1ad>";
            debugtext += self.var_14f2fa0e268c45c ? "<dev string:x1b4>" : "<dev string:x1b8>";
            print3d( circleorigin, debugtext, ( 1, 1, 1 ), 1, 1, duration, 1 );
        }
    #/
    
    resultangles = vectortoangles( var_23230fd41d82d289 );
    return resultangles[ 1 ] - 15 * interval;
}

// Namespace namespace_28acf6540b1bc740
// Params 2, eflags: 0x4
// Checksum 0x832cef13, Offset: 0x3826
// Size: 0x4f
function private function_4de57a6807875242( attacker, targ )
{
    target_direction = targ.origin - attacker.origin;
    return vectordot2( target_direction, anglestoforward( attacker.angles ), 1 );
}

/#

    // Namespace namespace_28acf6540b1bc740
    // Params 2, eflags: 0x4
    // Checksum 0x8e95e876, Offset: 0x387e
    // Size: 0xb1, Type: dev
    function private function_de283d7dd885a5b2( newpos, color )
    {
        self notify( #"hash_a2603b3c5838f989" );
        self endon( #"hash_a2603b3c5838f989" );
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self endon( #"near_goal" );
        self endon( #"begin_evasive_maneuvers" );
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        while ( true )
        {
            sphere( newpos, 32, color, 0, 1 );
            line( self.origin, newpos, color, 1, 0, 0, 1 );
            waitframe();
        }
    }

    // Namespace namespace_28acf6540b1bc740
    // Params 2, eflags: 0x4
    // Checksum 0x2cbe749, Offset: 0x3937
    // Size: 0x9a, Type: dev
    function private function_f6aeb2efc441e4b8( n_circle_radius, v_target_offset )
    {
        self notify( #"hash_3a65e27b55678b41" );
        self endon( #"hash_3a65e27b55678b41" );
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self endon( #"near_goal" );
        self endon( #"begin_evasive_maneuvers" );
        
        while ( true )
        {
            level thread utility::draw_circle( v_target_offset, n_circle_radius, ( 1, 0, 0 ), 1, 0, 10 );
            wait 0.5;
        }
    }

#/

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x7f3a5eeb, Offset: 0x39d9
// Size: 0x40
function private function_59487e919b0a6b82( target_ent )
{
    self setmaxpitchroll( self.var_f892efa18edbb8c9, 30 );
    function_2e5f86468baab203( self.angles[ 0 ], utility::getpitchtospot3d( target_ent.origin ) );
}

// Namespace namespace_28acf6540b1bc740
// Params 3, eflags: 0x4
// Checksum 0xf0dc0eac, Offset: 0x3a21
// Size: 0xe0
function private function_2e5f86468baab203( var_1ee3c44b7a43d3f3, var_bb9ab72377a23a58, var_4d4b3d78bf8ab9db = 13 )
{
    if ( var_1ee3c44b7a43d3f3 > 180 )
    {
        var_bb9ab72377a23a58 += 360;
    }
    
    var_be5c31887ed486f4 = abs( var_bb9ab72377a23a58 - self.angles[ 0 ] );
    total_time = var_be5c31887ed486f4 / var_4d4b3d78bf8ab9db;
    start_time = gettime();
    time_elapsed = 0;
    
    if ( total_time <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        time_elapsed = ( gettime() - start_time ) / 1000;
        pitch = math::lerp( var_1ee3c44b7a43d3f3, var_bb9ab72377a23a58, clamp( time_elapsed / total_time, 0, 1 ) ) % 360;
        self.angles = ( pitch, self.angles[ 1 ], self.angles[ 2 ] );
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0x13e6a9c0, Offset: 0x3b09
// Size: 0x128
function heli_watchdestroyed()
{
    level endon( #"game_ended" );
    self endon( #"choppersupport_gone" );
    owner = self.owner;
    
    while ( isdefined( self ) && self.health > 0 )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.turrets.size > 0 )
    {
        foreach ( turret in self.turrets )
        {
            turret.turreton = 0;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
    {
        if ( !utility::callsharedfunc( #"killstreak", #"iskillstreakweapon", self.killedbyweapon ) )
        {
            heli_crash( 100 );
        }
    }
    
    heli_explode();
}

// Namespace namespace_28acf6540b1bc740
// Params 0, eflags: 0x4
// Checksum 0xcb5dfea3, Offset: 0x3c39
// Size: 0x5b
function private heli_explode()
{
    self notify( #"explode" );
    self notify( #"state_change" );
    self radiusdamage( self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp" );
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.35;
    function_8a0c596232d6169d( 1 );
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xf3e626b3, Offset: 0x3c9c
// Size: 0xc0
function function_8a0c596232d6169d( wasdestroyed )
{
    if ( self.turrets.size > 0 )
    {
        foreach ( turret in self.turrets )
        {
            if ( isdefined( turret ) )
            {
                turret setentityowner( undefined );
                turret.groundtargetent delete();
                turret delete();
            }
        }
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0xed69d854, Offset: 0x3d64
// Size: 0xec
function private heli_crash( speed )
{
    self endon( #"explode" );
    self setscriptablepartstate( "crash", "on", 0 );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament unlink();
        self.killcament.origin = self.origin + ( 0, 0, 100 );
    }
    
    self clearlookatent();
    self notify( #"crashing" );
    self.iscrashing = 1;
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    var_61f902b2dd6fc262 = function_4dfe843fd5df94aa( 2000, 500, 1000 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread function_9fc5fe400e0d18a9( speed );
    self vehicle_turnengineoff();
    utility::waittill_any( "collision", "near_goal" );
}

// Namespace namespace_28acf6540b1bc740
// Params 3, eflags: 0x4
// Checksum 0x10bd4bb5, Offset: 0x3e58
// Size: 0x1d9
function private function_4dfe843fd5df94aa( crashdist, var_21829f1a765d61f3, var_21a5b51a7683da0d )
{
    crashstart = self.origin;
    crashoffset = self.crashoffset;
    crashpos = undefined;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    crashend = crashstart + jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward + jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetright - jetforward ) - ( 0, 0, crashoffset );
    crashtrace = trace::ray_trace( crashstart, crashend, self );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    return crashpos;
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x69a3650a, Offset: 0x403a
// Size: 0x52
function private function_9fc5fe400e0d18a9( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 0.5;
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x723b1058, Offset: 0x4094
// Size: 0x79
function heli_finddroplocation( starttrace )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 20000 );
    ignorelist = [ self ];
    trace = trace::ray_trace( starttrace, endtrace, ignorelist );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        droplocation = trace[ "position" ];
    }
    
    return droplocation;
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0xf2573ae3, Offset: 0x4116
// Size: 0xcc, Type: bool
function private heli_damage_callback( data )
{
    if ( isdefined( data.attacker ) )
    {
        ent_num = data.attacker getentitynumber();
        
        if ( !isdefined( self.attackers[ ent_num ] ) )
        {
            self.attackers[ ent_num ] = 0;
        }
        
        self.attackers[ ent_num ] += data.damage;
        mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int( data.damage ), data.point, 0, undefined, 0, 0 );
    }
    
    return true;
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0xcffc93bf, Offset: 0x41eb
// Size: 0x9c, Type: bool
function private function_9afa310cd0ae16ec( data )
{
    chopper_support::choppersupport_handledeathdamage( data );
    
    foreach ( deathcallback in self.deathcallbacks )
    {
        self thread [[ deathcallback ]]( self, data );
    }
    
    self notify( #"death" );
    return true;
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0xac824ce8, Offset: 0x4290
// Size: 0x1c6
function load_settings_bundle( var_300037d32586873c = getscriptbundle( "helicoptersettings:default_helicopter_settings" ) )
{
    if ( isdefined( var_300037d32586873c ) )
    {
        assert( var_300037d32586873c.bundletype == "<dev string:x1bd>", "<dev string:x1d1>" );
    }
    
    load_target_settings( var_300037d32586873c.var_a79b66fd24b67af6 );
    function_23e279078bfd5c73( var_300037d32586873c.hasturret, var_300037d32586873c.turretsettings );
    function_e8321f15d6f4b439( var_300037d32586873c.hoverradius, var_300037d32586873c.hoverspeed, var_300037d32586873c.hoveraccel, var_300037d32586873c.hoverminheight );
    function_8ae160a4fd9dd21b( var_300037d32586873c.helihealth, var_300037d32586873c.var_929589dd4e96703 );
    function_97b656b4a02e1db1( var_300037d32586873c.circlegoaldist, var_300037d32586873c.circlespeed, var_300037d32586873c.circleradiusmin, var_300037d32586873c.circleradiusmax, var_300037d32586873c.circleheight, var_300037d32586873c.var_c80756b7848967f9, var_300037d32586873c.var_b4626596a35ba4eb, var_300037d32586873c.var_fa55169cf8fdcde5, var_300037d32586873c.var_b5d6972d7d1d0ceb );
    function_c9b82577c4e44bdc( var_300037d32586873c.var_25ced6dafb5b15f0, var_300037d32586873c.pathgoaldistance, var_300037d32586873c.basespeed, var_300037d32586873c.takeoffspeed, var_300037d32586873c.takeoffaccel, var_300037d32586873c.groundoffset, var_300037d32586873c.var_b31db762dfa1733a );
    function_5fcf52a0670a7f2b( var_300037d32586873c.hasmissiles, var_300037d32586873c.missileinterval, var_300037d32586873c.missileweapon, var_300037d32586873c.var_f892efa18edbb8c9, var_300037d32586873c.var_be9c0cb162230c9c, var_300037d32586873c.var_9f21cc48de7b2e1b );
}

// Namespace namespace_28acf6540b1bc740
// Params 0
// Checksum 0xb2efabff, Offset: 0x445e
// Size: 0x95
function function_a6252a223adbba4e()
{
    while ( true )
    {
        helihealth = getdvarint( @"hash_39512dcad0dfbf5a", -1 );
        
        if ( helihealth != -1 && self.helihealth != helihealth )
        {
            self.helihealth = helihealth;
            set_heli_health( self.helihealth );
        }
        
        missileinterval = getdvarfloat( @"hash_61b0eb8825f9e210", -1 );
        
        if ( missileinterval != -1 && self.missileinterval != missileinterval )
        {
            self.missileinterval = missileinterval;
        }
        
        waitframe();
    }
}

// Namespace namespace_28acf6540b1bc740
// Params 1, eflags: 0x4
// Checksum 0x237afee8, Offset: 0x44fb
// Size: 0x24
function private load_target_settings( var_52284971217c2932 = 45 )
{
    self.var_359a527374fa8064 = cos( var_52284971217c2932 );
}

// Namespace namespace_28acf6540b1bc740
// Params 2, eflags: 0x4
// Checksum 0x6b663f28, Offset: 0x4527
// Size: 0x34
function private function_23e279078bfd5c73( hasturret = 1, turretsettings )
{
    self.hasturret = hasturret;
    self.turretsettings = turretsettings;
}

// Namespace namespace_28acf6540b1bc740
// Params 2, eflags: 0x4
// Checksum 0x5caa3e47, Offset: 0x4563
// Size: 0x3d
function private function_8ae160a4fd9dd21b( helihealth = 2000, var_929589dd4e96703 = 0 )
{
    self.helihealth = helihealth;
    self.var_929589dd4e96703 = var_929589dd4e96703;
}

// Namespace namespace_28acf6540b1bc740
// Params 4, eflags: 0x4
// Checksum 0x6b23b725, Offset: 0x45a8
// Size: 0x7b
function private function_e8321f15d6f4b439( var_5de21a10a873b53b = 50, var_5f9f663db6f0dea8 = 5, var_9f60eaf7ca90150b = 2.5, hover_min_height = 256 )
{
    self.var_5de21a10a873b53b = var_5de21a10a873b53b;
    self.var_5f9f663db6f0dea8 = var_5f9f663db6f0dea8;
    self.var_9f60eaf7ca90150b = var_9f60eaf7ca90150b;
    self.hover_min_height = hover_min_height;
}

// Namespace namespace_28acf6540b1bc740
// Params 7, eflags: 0x4
// Checksum 0x1bd0d199, Offset: 0x462b
// Size: 0xd5
function private function_c9b82577c4e44bdc( var_25ced6dafb5b15f0 = 3, pathgoaldistance = 256, basespeed = 40, takeoffspeed = 10, takeoffaccel = 5, groundoffset = 128, var_b31db762dfa1733a = 65536 )
{
    self.var_25ced6dafb5b15f0 = var_25ced6dafb5b15f0;
    self.pathgoaldistance = pathgoaldistance;
    self.speed = basespeed;
    self.takeoffspeed = takeoffspeed;
    self.takeoffaccel = takeoffaccel;
    self.groundoffset = groundoffset;
    self.var_b31db762dfa1733a = var_b31db762dfa1733a;
}

// Namespace namespace_28acf6540b1bc740
// Params 9, eflags: 0x4
// Checksum 0x28eebac3, Offset: 0x4708
// Size: 0x117
function private function_97b656b4a02e1db1( circlegoaldist = 128, circlespeed = 30, circleradiusmin = 1500, circleradiusmax = 2560, circleheight = 768, var_c80756b7848967f9 = 1, var_b4626596a35ba4eb = 4194304, var_fa55169cf8fdcde5 = 3, var_b5d6972d7d1d0ceb = 8 )
{
    self.circlegoaldist = circlegoaldist;
    self.circlespeed = circlespeed;
    self.circleradiusmin = circleradiusmin;
    self.circleradiusmax = circleradiusmax;
    self.circleheight = circleheight;
    self.var_c80756b7848967f9 = var_c80756b7848967f9;
    self.var_b4626596a35ba4eb = var_b4626596a35ba4eb;
    self.var_fa55169cf8fdcde5 = var_fa55169cf8fdcde5;
    self.var_b5d6972d7d1d0ceb = var_b5d6972d7d1d0ceb;
}

// Namespace namespace_28acf6540b1bc740
// Params 6, eflags: 0x4
// Checksum 0x93ad7e71, Offset: 0x4827
// Size: 0xb6
function private function_5fcf52a0670a7f2b( hasmissiles = 1, missileinterval = 15000, var_a0861aec2e22596f = "chopper_gunner_proj_dmz", var_f892efa18edbb8c9 = 60, var_be9c0cb162230c9c = 30, var_24960c03fa7f9b9c = 5500 )
{
    self.hasmissiles = hasmissiles;
    self.missileinterval = missileinterval;
    self.var_a0861aec2e22596f = var_a0861aec2e22596f;
    self.var_f892efa18edbb8c9 = var_f892efa18edbb8c9;
    self.var_be9c0cb162230c9c = var_be9c0cb162230c9c;
    self.var_24960c03fa7f9b9c = var_24960c03fa7f9b9c;
}

// Namespace namespace_28acf6540b1bc740
// Params 1
// Checksum 0x1a2b126d, Offset: 0x48e5
// Size: 0x22
function set_heli_health( helihealth )
{
    self.health = helihealth;
    self.maxhealth = helihealth;
}

