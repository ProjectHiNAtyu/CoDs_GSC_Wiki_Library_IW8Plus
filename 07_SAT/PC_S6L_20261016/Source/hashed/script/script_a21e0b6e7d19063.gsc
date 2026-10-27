// script_a21e0b6e7d19063  (hash_0a21e0b6e7d19063.gscc) (size: 9220 Bytes / 0x2404 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2c6ea6e9 (745449193)
// size ...... 9220 (0x2404)
// includes .. 4   (offset: 0x2178)
// strings ... 23  (offset: 0x2198)
// dev strs .. 0   (offset: 0x2368)
// exports ... 22  (offset: 0x177c)
// cseg ...... 0x33b + 0x1441 (0x177c)
// imports ... 55  (offset: 0x1aec)
// animtree1 . 1   (offset: 0x2368)
// animtree2 . 9   (offset: 0x2374)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;

#namespace br_extraction_heli;

// Namespace br_extraction_heli
// Params 0
// Checksum 0x191faa3d, Offset: 0x359
// Size: 0x1a
function init()
{
    level.var_35601369dcb3d272 = {};
    function_85a6e0142f629bf6();
    function_e89d3cb5d42275aa();
}

// Namespace br_extraction_heli
// Params 1
// Checksum 0x6ea63aa6, Offset: 0x37b
// Size: 0x360
function set_heli_config( config )
{
    if ( !isdefined( config ) )
    {
        return;
    }
    
    var_ae90396137ebe2fc = level.var_35601369dcb3d272;
    
    if ( config.vehicle_name )
    {
        var_ae90396137ebe2fc.vehicle_name = config.vehicle_name;
    }
    
    if ( config.heli_model )
    {
        var_ae90396137ebe2fc.heli_model = config.heli_model;
    }
    
    if ( config.rope_model )
    {
        var_ae90396137ebe2fc.rope_model = config.rope_model;
    }
    
    if ( config.bag_model )
    {
        var_ae90396137ebe2fc.bag_model = config.bag_model;
    }
    
    if ( config.descend_height )
    {
        var_ae90396137ebe2fc.descend_height = config.descend_height;
    }
    
    if ( config.spawn_height )
    {
        var_ae90396137ebe2fc.spawn_height = config.spawn_height;
    }
    
    if ( config.hover_height )
    {
        var_ae90396137ebe2fc.hover_height = config.hover_height;
    }
    
    if ( config.approach_distance )
    {
        var_ae90396137ebe2fc.approach_distance = config.approach_distance;
    }
    
    if ( config.speed )
    {
        var_ae90396137ebe2fc.speed = config.speed;
    }
    
    if ( isdefined( config.accel ) )
    {
        var_ae90396137ebe2fc.accel = config.accel;
    }
    
    if ( isdefined( config.max_pitch ) )
    {
        var_ae90396137ebe2fc.max_pitch = config.max_pitch;
    }
    
    if ( isdefined( config.max_roll ) )
    {
        var_ae90396137ebe2fc.max_roll = config.max_roll;
    }
    
    if ( config.turning_ability )
    {
        var_ae90396137ebe2fc.turning_ability = config.turning_ability;
    }
    
    if ( config.yaw_speed )
    {
        var_ae90396137ebe2fc.yaw_speed = config.yaw_speed;
    }
    
    if ( isdefined( config.yaw_accel ) )
    {
        var_ae90396137ebe2fc.yaw_accel = config.yaw_accel;
    }
    
    if ( config.yaw_decel )
    {
        var_ae90396137ebe2fc.yaw_decel = config.yaw_decel;
    }
    
    if ( isdefined( config.yaw_friction ) )
    {
        var_ae90396137ebe2fc.yaw_friction = config.yaw_friction;
    }
    
    if ( config.health )
    {
        var_ae90396137ebe2fc.health = config.health;
    }
    
    if ( isdefined( config.var_cdd74e6c6c15198 ) )
    {
        var_ae90396137ebe2fc.var_cdd74e6c6c15198 = config.var_cdd74e6c6c15198;
    }
    
    if ( isdefined( config.var_ef64fba483440788 ) )
    {
        var_ae90396137ebe2fc.var_ef64fba483440788 = config.var_ef64fba483440788;
    }
    
    if ( isdefined( config.extraction_timeout ) )
    {
        var_ae90396137ebe2fc.extraction_timeout = config.extraction_timeout;
    }
    
    if ( isdefined( config.pad_reset_delay ) )
    {
        var_ae90396137ebe2fc.pad_reset_delay = config.pad_reset_delay;
    }
}

// Namespace br_extraction_heli
// Params 2
// Checksum 0x2b00190c, Offset: 0x6e3
// Size: 0xfb
function function_e5e8ddf0aca9ebe0( site, var_b93327d6e72ffb79 = undefined )
{
    groundorg = getgroundposition( site.origin, 1 ) + ( 0, 0, -9 );
    heli = function_6e5ba89d06c3ef5d( groundorg, site );
    
    if ( getdvarint( @"hash_b9ee44cbdb5cbd6e", 1 ) == 1 && var_b93327d6e72ffb79 > 0 )
    {
        heli vehicleshowonminimap( 0 );
        heli function_d2b8ee2e1275daaf( 1 );
        heli vehicle_teleport( ( 0, 0, -1000 ), heli.angles );
        wait 1;
        heli hide();
    }
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    heli.site = site;
    site.heli = heli;
    site.team = self.team;
    heli thread function_e274a56e4c8ad871( site, var_b93327d6e72ffb79 );
    return heli;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace br_extraction_heli
// Params 0, eflags: 0x4
// Checksum 0x20ca0b75, Offset: 0x7e7
// Size: 0x5f
function private function_85a6e0142f629bf6()
{
    level.scr_anim[ "plunder_extract_heli" ][ "heli_in" ] = %iw8_br_plunder_heli_in;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_loop" ] = %iw8_br_plunder_heli_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_out" ] = %iw8_br_plunder_heli_out;
}

#using_animtree( "script_model" );

// Namespace br_extraction_heli
// Params 0, eflags: 0x4
// Checksum 0x834e2863, Offset: 0x84e
// Size: 0xce
function private function_e89d3cb5d42275aa()
{
    level.scr_animtree[ "plunder_extract_heli" ] = #animtree;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_in" ] = %iw8_br_plunder_heli_rope_in;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_loop" ] = %iw8_br_plunder_heli_rope_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_out" ] = %iw8_br_plunder_heli_rope_out;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_in" ] = %iw8_br_plunder_heli_bag_in;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_loop" ] = %iw8_br_plunder_heli_bag_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_out" ] = %iw8_br_plunder_heli_bag_out;
}

// Namespace br_extraction_heli
// Params 3, eflags: 0x4
// Checksum 0x1c9bb7c9, Offset: 0x924
// Size: 0x117
function private function_3339cbd1cfaa93e5( site, var_9bfc3973acf74366, var_db18f8c567bc3349 )
{
    if ( isdefined( site ) && isdefined( site.flightyaw ) )
    {
        return site.flightyaw;
    }
    
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    var_18397e93d9334888 = 0;
    yaw = 0;
    
    while ( yaw < 360 )
    {
        var_18397e93d9334888 += yaw;
        testangles = ( 0, var_18397e93d9334888, 0 );
        approachstartpos = var_9bfc3973acf74366 - anglestoforward( testangles ) * 20000;
        approachendpos = var_db18f8c567bc3349;
        approachtrace = trace::sphere_trace( approachstartpos, approachendpos, 100, undefined, contents, 1 );
        
        if ( approachtrace[ "fraction" ] == 1 )
        {
            if ( isdefined( site ) )
            {
                site.flightyaw = var_18397e93d9334888;
            }
            
            return var_18397e93d9334888;
        }
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
    
    return var_18397e93d9334888;
}

// Namespace br_extraction_heli
// Params 2, eflags: 0x4
// Checksum 0xbf8c7fc6, Offset: 0xa44
// Size: 0x114
function private function_6e5ba89d06c3ef5d( position, site )
{
    config = level.var_35601369dcb3d272;
    extractgroundpos = position;
    var_9370b5c935fd8b21 = extractgroundpos + ( 0, 0, config.descend_height ?? 2000 );
    spawnposoffset = extractgroundpos + ( 0, 0, config.spawn_height ?? 8000 );
    var_ce1eb256270347b7 = extractgroundpos + ( 0, 0, config.hover_height ?? 800 );
    flightyaw = 0;
    flightangles = ( 0, 0, 0 );
    flightyaw = function_3339cbd1cfaa93e5( site, spawnposoffset, var_9370b5c935fd8b21 );
    flightangles = ( 0, flightyaw, 0 );
    enterposition = spawnposoffset - anglestoforward( flightangles ) * ( config.approach_distance ?? 20000 );
    heli = function_2f131dfaeed72d8e( self.team, enterposition, var_9370b5c935fd8b21, var_ce1eb256270347b7, extractgroundpos );
    return heli;
}

// Namespace br_extraction_heli
// Params 0, eflags: 0x4
// Checksum 0x9b5e7672, Offset: 0xb61
// Size: 0x2e
function private function_79015fa3e25a9593()
{
    self endon( #"death" );
    self endon( #"hash_8c8d8512d8835926" );
    level waittill( #"game_ended" );
    thread heli_leave();
}

// Namespace br_extraction_heli
// Params 2, eflags: 0x4
// Checksum 0x5680de3e, Offset: 0xb97
// Size: 0xf4
function private function_e274a56e4c8ad871( extraction_platform, var_b93327d6e72ffb79 )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.flytime = 25;
    thread function_79015fa3e25a9593();
    self.preventleave = 1;
    
    if ( var_b93327d6e72ffb79 > 0 )
    {
        wait var_b93327d6e72ffb79;
        
        if ( getdvarint( @"hash_b9ee44cbdb5cbd6e", 1 ) == 1 )
        {
            self vehicleshowonminimap( 1 );
            self function_d2b8ee2e1275daaf( 0 );
            self show();
        }
    }
    
    heli_descend();
    self makeusable();
    
    if ( extraction_platform.var_c2528ae64573b7a4 )
    {
        extraction_platform [[ extraction_platform.var_c2528ae64573b7a4 ]]( extraction_platform.type, extraction_platform.var_7f332a185f67270d );
    }
    
    utility::waittill_any_timeout( level.var_35601369dcb3d272.extraction_timeout ?? 60, "item_extraction_successful" );
    self.preventleave = undefined;
    thread heli_leave();
}

// Namespace br_extraction_heli
// Params 0, eflags: 0x4
// Checksum 0xd67a3355, Offset: 0xc93
// Size: 0x1a8
function private heli_leave()
{
    if ( self.tryingtoleave || self.leaving )
    {
        return;
    }
    
    self endon( #"death" );
    self notify( #"hash_8c8d8512d8835926" );
    self.tryingtoleave = 1;
    extraction_platform = self.site;
    
    if ( isdefined( extraction_platform ) )
    {
        if ( extraction_platform.heli == self )
        {
            extraction_platform.heli = undefined;
            extraction_platform.team = undefined;
            extraction_platform notify( #"hash_9c0cd27aba1401bb" );
        }
        
        extraction_platform thread function_4fa4257f14fe2811( self.site.type, self.site.var_7f332a185f67270d );
        self.site = undefined;
    }
    
    self.readytoleave = 1;
    self waittill( #"hash_8182ff35fd9e24b8" );
    self notify( #"leaving" );
    self.leaving = 1;
    self.tryingtoleave = undefined;
    animtime_out = getanimlength( level.scr_anim[ self.animname ][ "heli_out" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_out" );
    self.ropenode thread animation::anim_single_solo( self.rope, "rope_out", "tag_origin" );
    self.ropenode thread animation::anim_single_solo( self.crate, "bag_out", "tag_origin" );
    thread heli_blima_sfx( self, 2 );
    wait animtime_out;
    self stoploopsound();
    self notify( #"heli_gone" );
    heli_delete();
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0x7e8b09f3, Offset: 0xe43
// Size: 0x11
function heli_delete()
{
    function_8a0c596232d6169d();
    vehicle_tracking::delete_vehicle( self );
}

// Namespace br_extraction_heli
// Params 1
// Checksum 0xe2a0fbe, Offset: 0xe5c
// Size: 0x2a
function function_403c50a1735db98c( heli )
{
    self hide();
    
    if ( isdefined( heli ) )
    {
        heli.crate = undefined;
    }
    
    waitframe();
    self delete();
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0xb4761529, Offset: 0xe8e
// Size: 0x71
function function_8a0c596232d6169d()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate thread function_403c50a1735db98c( self );
    }
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
    
    if ( isdefined( self.ropenode ) )
    {
        self.ropenode delete();
    }
}

// Namespace br_extraction_heli
// Params 2
// Checksum 0xd2bdc165, Offset: 0xf07
// Size: 0x7f
function heli_blima_sfx( vehicle, sequence )
{
    switch ( sequence )
    {
        case 0:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_in" );
            break;
        case 1:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_loop" );
            break;
        case 2:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_out" );
            break;
    }
}

// Namespace br_extraction_heli
// Params 2
// Checksum 0x6e417d8a, Offset: 0xf8e
// Size: 0x66
function function_4fa4257f14fe2811( type, var_7f332a185f67270d )
{
    if ( self.callback_heli_left )
    {
        self [[ self.callback_heli_left ]]( type, var_7f332a185f67270d );
    }
    
    wait level.var_35601369dcb3d272.pad_reset_delay ?? 6;
    
    if ( self.var_106bc96555268bdf )
    {
        self [[ self.var_106bc96555268bdf ]]( type, var_7f332a185f67270d );
    }
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0x6216418b, Offset: 0xffc
// Size: 0xb4
function heli_descend()
{
    self endon( #"death" );
    thread heli_blima_sfx( self, 0 );
    animtime_in = getanimlength( level.scr_anim[ self.animname ][ "heli_in" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_in" );
    self.ropenode thread animation::anim_single_solo( self.rope, "rope_in", "tag_origin" );
    self.ropenode thread animation::anim_single_solo( self.crate, "bag_in", "tag_origin" );
    wait animtime_in;
    thread function_215c4a6859106c30();
    thread function_e60cdf0672d9e42f();
    thread function_1fb18f3439cf92d0();
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0xed464e50, Offset: 0x10b8
// Size: 0x95
function function_215c4a6859106c30()
{
    self endon( #"death" );
    self.scenenode endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "heli_loop" ] );
    
    while ( true )
    {
        self.scenenode thread animation::anim_single_solo( self, "heli_loop" );
        wait animtime;
        
        if ( self.readytoleave && !self.preventleave )
        {
            self notify( #"hash_8182ff35fd9e24b8" );
            break;
        }
    }
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0x17aab2a, Offset: 0x1155
// Size: 0x74
function function_e60cdf0672d9e42f()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "rope_loop" ] );
    
    while ( true )
    {
        self.ropenode thread animation::anim_single_solo( self.rope, "rope_loop", "tag_origin" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace br_extraction_heli
// Params 0
// Checksum 0x3a4267be, Offset: 0x11d1
// Size: 0x74
function function_1fb18f3439cf92d0()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "bag_loop" ] );
    
    while ( true )
    {
        self.ropenode thread animation::anim_single_solo( self.crate, "bag_loop", "tag_origin" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace br_extraction_heli
// Params 5, eflags: 0x4
// Checksum 0x6bfae8d9, Offset: 0x124d
// Size: 0x392
function private function_2f131dfaeed72d8e( team, enterpos, descendpos, hoverpos, extractgroundpos )
{
    config = level.var_35601369dcb3d272;
    owner = undefined;
    flightangle = vectortoangles( descendpos * ( 1, 1, 0 ) - enterpos * ( 1, 1, 0 ) );
    modelname = config.heli_model ?? "xcomp_veh_t10_mil_us_heli_medium_trans_mp_extraction_plunder";
    vehiclename = config.vehicle_name ?? "veh_cer_mil_heli_little_bird";
    groundposoffset = ( 126, 0, -20 );
    groundposoffset = rotatevector( groundposoffset, flightangle );
    heli = vehicle_tracking::spawn_helicopter( owner, enterpos, flightangle, vehiclename, modelname );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    heli.speed = config.speed ?? 100;
    heli.accel = config.accel ?? 125;
    heli.health = config.health ?? 1000;
    heli.maxhealth = heli.health;
    heli.team = team;
    heli.owner = owner;
    heli.lifeid = 0;
    heli.flaresreservecount = config.var_cdd74e6c6c15198 ?? 1;
    heli.enterpos = enterpos;
    heli.descendpos = descendpos;
    heli.hoverpos = hoverpos;
    heli.extractgroundpos = extractgroundpos;
    heli.sceneangles = flightangle;
    heli.vehiclename = vehiclename;
    heli.animname = "plunder_extract_heli";
    heli setcandamage( config.var_ef64fba483440788 ?? 0 );
    heli setmaxpitchroll( config.max_pitch ?? 10, config.max_roll ?? 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 1, 1, 1 );
    heli setturningability( config.turning_ability ?? 0.05 );
    heli setyawspeed( config.yaw_speed ?? 45, config.yaw_accel ?? 25, config.yaw_decel ?? 25, config.yaw_friction ?? 0.5 );
    heli setotherent( owner );
    heli setvehicleteam( heli.team );
    heli setscriptablepartstate( "engine", "on" );
    heli setscriptablepartstate( "infil_lights", "on" );
    heli.scenenode = spawn( "script_model", heli.extractgroundpos + groundposoffset );
    heli.scenenode.angles = heli.sceneangles;
    heli.scenenode setmodel( "tag_origin" );
    heli.scenenode animation::anim_first_frame_solo( heli, "heli_in" );
    function_a9d72ad5fd20ff11( heli );
    return heli;
}

// Namespace br_extraction_heli
// Params 1, eflags: 0x4
// Checksum 0x6224a7db, Offset: 0x15e8
// Size: 0x194
function private function_a9d72ad5fd20ff11( heli )
{
    config = level.var_35601369dcb3d272;
    ropenode = spawn( "script_model", ( 0, 0, 0 ) );
    ropenode setmodel( "tag_origin" );
    ropenode linkto( heli, "origin_animate_jnt", ( -142.719, 0, 22.931 ), ( 0, 0, 0 ) );
    rope = spawn( "script_model", ( 0, 0, 0 ) );
    rope setmodel( config.rope_model ?? "misc_rapelling_rope_01_fiber_br" );
    rope linkto( ropenode, "tag_origin" );
    rope.animname = heli.animname;
    rope animation::setanimtree();
    ropenode animation::anim_first_frame_solo( rope, "rope_in", "tag_origin" );
    crate = spawn( "script_model", ( 0, 0, 0 ) );
    crate setmodel( config.bag_model ?? "br_plunder2_extraction_delivery_bag" );
    crate linkto( ropenode, "tag_origin" );
    crate.animname = heli.animname;
    crate animation::setanimtree();
    ropenode animation::anim_first_frame_solo( crate, "bag_in", "tag_origin" );
    heli.rope = rope;
    heli.crate = crate;
    heli.ropenode = ropenode;
}

