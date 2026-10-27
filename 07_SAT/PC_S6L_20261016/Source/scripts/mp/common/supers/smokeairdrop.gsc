// scripts\mp\common\supers\smokeairdrop.gsc  (hash_24d8c1280283ccdb.gscc) (size: 8091 Bytes / 0x1f9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9134c88f (2436155535)
// size ...... 8091 (0x1f9b)
// includes .. 17  (offset: 0x1d3f)
// strings ... 29  (offset: 0x1dc7)
// dev strs .. 0   (offset: 0x1f4f)
// exports ... 23  (offset: 0x1127)
// cseg ...... 0x337 + 0xdf0 (0x1127)
// imports ... 73  (offset: 0x14bf)
// animtree1 . 1   (offset: 0x1f4f)
// animtree2 . 4   (offset: 0x1f5b)
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\scripted_weapons;
#using scripts\mp\superdeploy;
#using scripts\mp\supers;

#namespace smokeairdrop;

// Namespace smokeairdrop
// Params 0, eflags: 0x1
// Checksum 0x4424c08b, Offset: 0x355
// Size: 0x9
function autoexec main()
{
    smokeairdrop_init();
}

// Namespace smokeairdrop
// Params 0
// Checksum 0x690e3ded, Offset: 0x366
// Size: 0x3c
function smokeairdrop_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_smoke_airdrop", undefined, &smokeairdrop_unset, &smokeairdrop_beginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    smokeairdrop_initanims();
    level.smokeairdropdrones = [];
}

#using_animtree( "script_model" );

// Namespace smokeairdrop
// Params 0
// Checksum 0x7457a86b, Offset: 0x3aa
// Size: 0x90
function smokeairdrop_initanims()
{
    level.scr_animtree[ "super_smoke_airdrop" ] = #animtree;
    level.scr_anim[ "super_smoke_airdrop" ][ "activate_drone_1" ] = %wm_smoke_airdrop_drone_01;
    level.scr_anim[ "super_smoke_airdrop" ][ "activate_drone_2" ] = %wm_smoke_airdrop_drone_02;
    level.scr_anim[ "super_smoke_airdrop" ][ "activate_drone_3" ] = %wm_smoke_airdrop_drone_03;
    level.scr_anim[ "super_smoke_airdrop" ][ "activate_drone_4" ] = %wm_smoke_airdrop_drone_04;
}

// Namespace smokeairdrop
// Params 0
// Checksum 0xc2fd3100, Offset: 0x442
// Size: 0x16, Type: bool
function smokeairdrop_beginuse()
{
    result = function_7ee4a7d4d61b8377();
    return true;
}

// Namespace smokeairdrop
// Params 1
// Checksum 0x96922b93, Offset: 0x461
// Size: 0x20, Type: bool
function smokeairdrop_weapongiven( superinfo )
{
    mapselect::function_74e31405d43e142( 0, 1, "short_arrow", undefined, superinfo );
    return true;
}

// Namespace smokeairdrop
// Params 0
// Checksum 0x49345ae0, Offset: 0x48a
// Size: 0xe
function smokeairdrop_unset()
{
    self notify( #"cancel_all_super_deployments" );
}

// Namespace smokeairdrop
// Params 0
// Checksum 0x753999eb, Offset: 0x4a0
// Size: 0x21
function smokeairdrop_refund()
{
    while ( !supers_mp::getcurrentsuper().isinuse )
    {
        waitframe();
    }
    
    supers_mp::refundsuper();
}

// Namespace smokeairdrop
// Params 0
// Checksum 0xebcc0269, Offset: 0x4c9
// Size: 0x3b, Type: bool
function function_82445673ee32c79a()
{
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self.super.isdeploying )
    {
        return false;
    }
    
    return true;
}

// Namespace smokeairdrop
// Params 0
// Checksum 0x17781b30, Offset: 0x50d
// Size: 0xfd
function function_7ee4a7d4d61b8377()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"remove_super" );
    
    if ( !function_82445673ee32c79a() )
    {
        smokeairdrop_refund();
        return;
    }
    
    superinfo = supers_mp::getcurrentsuper();
    objwpn = scripted_weapons::get_scripted_weapon_object( #"super_remote_map" );
    deployresult = superdeploy::superdeploy_doweaponswitchdeploy( superinfo, objwpn, 1, &smokeairdrop_weapongiven );
    
    if ( !deployresult )
    {
        smokeairdrop_refund();
        return;
    }
    
    mappointinfo = mapselect::function_ec95e9f1b6d329fb( superinfo, 1, 1 );
    
    if ( !isdefined( mappointinfo ) )
    {
        smokeairdrop_refund();
        return;
    }
    
    self notify( #"super_finished_with_deploy_weapon" );
    thread function_4ec873712c0cb6d1( superinfo, mappointinfo );
    
    if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        self [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
    }
}

// Namespace smokeairdrop
// Params 2
// Checksum 0xe4859793, Offset: 0x612
// Size: 0xf0
function function_4ec873712c0cb6d1( streakinfo, mappointinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittime = getdvarfloat( @"hash_9c4a873bf6fcab41", 1.5 );
    wait waittime;
    
    foreach ( pointinfo in mappointinfo )
    {
        mappt = pointinfo.location;
        directionyaw = pointinfo.angles;
        function_5d5b6ca753fea143( mappt, directionyaw, streakinfo );
        wait 1;
    }
}

// Namespace smokeairdrop
// Params 3
// Checksum 0x20bb9e35, Offset: 0x70a
// Size: 0x394
function function_5d5b6ca753fea143( droplocation, directionyaw, streakinfo )
{
    level endon( #"game_ended" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_smoke_airdrop" );
    midpoint = droplocation;
    halfdistance = 1000;
    missileorientation = ( 0, directionyaw, 0 );
    missileforward = anglestoforward( missileorientation );
    smokeforward = anglestoright( missileorientation );
    startpoint = midpoint + missileforward * -1 * halfdistance;
    endpoint = midpoint + missileforward * halfdistance;
    currentpoint = startpoint;
    totaldistance = halfdistance * 2;
    var_857c780d0be7d990 = getdvarint( @"hash_d6117e0006347933", bundle.var_857c780d0be7d990 );
    vertdistance = getdvarint( @"hash_80d60fd8731d5fbf", 2000 );
    contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0 );
    smokepoints = [];
    smokedrones = [];
    
    for ( i = 0; i < var_857c780d0be7d990 ; i++ )
    {
        /#
            level thread debug::drawsphere( currentpoint, 10, 100, ( 1, 0, 0 ) );
        #/
        
        smokefail = 0;
        surfaceup = anglestoup( missileorientation );
        smokepoint = currentpoint;
        starttracedown = currentpoint + anglestoup( missileorientation ) * vertdistance;
        endtracedown = currentpoint + anglestoup( missileorientation ) * vertdistance * -1;
        tracedown = trace::ray_trace( starttracedown, endtracedown, undefined, contents );
        
        if ( tracedown[ "hittype" ] != "hittype_none" )
        {
            smokepoint = tracedown[ "position" ];
            
            /#
                level thread debug::drawsphere( smokepoint, 10, 100, ( 0, 1, 0 ) );
            #/
        }
        
        var_9a4364ddfc8bf344 = getdvarfloat( @"hash_fae98b333c47d007", 2000 );
        var_9a4364ddfc8bf344 *= var_9a4364ddfc8bf344;
        
        if ( distancesquared( smokepoint, currentpoint ) > var_9a4364ddfc8bf344 )
        {
            smokefail = 1;
        }
        
        if ( !smokefail )
        {
            index = smokedrones.size;
            smokedrones[ index ] = function_4fb2efe9f4a9a4c0( smokepoint, missileorientation, vertdistance, index );
            smokepoints[ index ] = smokepoint;
        }
        
        currentpoint += totaldistance / var_857c780d0be7d990 * missileforward;
    }
    
    var_bc73bcf49c44e35f = 0;
    var_8684836c1d50a00d = 100;
    var_c25b1c7a283316ca = 300;
    
    for ( j = 0; j < smokedrones.size ; j++ )
    {
        smokedrones[ j ].var_8a3c987868cf868f = 0;
        
        if ( !var_bc73bcf49c44e35f && distancesquared( smokepoints[ j ], droplocation ) < squared( var_8684836c1d50a00d ) )
        {
            smokedrones[ j ].var_8a3c987868cf868f = 1;
            var_bc73bcf49c44e35f = 1;
        }
        
        for ( p = 0; p < smokepoints.size ; p++ )
        {
            if ( distancesquared( smokepoints[ p ], smokepoints[ j ] ) < squared( var_c25b1c7a283316ca ) && smokepoints[ j ] != smokepoints[ p ] && smokedrones[ p ].playsmokesound == 1 )
            {
                smokedrones[ j ].playsmokesound = 0;
                break;
            }
        }
        
        smokedrones[ j ] childthread function_8bfa6fdf23e578a9( smokepoints[ j ], smokeforward );
    }
    
    challenges::function_a0936b0e5b4550f3( "super_smoke_airdrop", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace smokeairdrop
// Params 4
// Checksum 0xf5664002, Offset: 0xaa6
// Size: 0x153
function function_4fb2efe9f4a9a4c0( smokepoint, missileorientation, vertdistance, index )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_smoke_airdrop" );
    smokedrone = spawn( "script_model", smokepoint + anglestoup( missileorientation ) * vertdistance );
    smokedrone setmodel( bundle.var_aaffeeaa205c1478 );
    smokedrone.owner = self;
    smokedrone.angles = missileorientation;
    smokedrone.playsmokesound = 1;
    smokedrone.index = index + 1;
    smokedrone.animname = "super_smoke_airdrop";
    smokedrone animation::setanimtree();
    smokedrone setscriptablepartstate( "smokeDeploy", "deployStart", 0 );
    smokedrone haywire::function_7f69a1eb3d590f76( &function_b64b8f21ad072595 );
    smokedrone emp_debuff::set_start_emp_callback( &function_89632975862ec8f2 );
    smokedrone setentityhudoutlinedata( 3, smokedrone.owner.team );
    function_8d2befbc131859da( smokedrone );
    
    if ( getdvarint( @"hash_819d904fd33aad", bundle.var_c63d08936511f9e8 ) )
    {
        smokedrone thread damage::monitordamage( bundle.var_bf78cbd1bc77a6fd, "hitequip", &function_4570667c9acb5f7a );
    }
    
    return smokedrone;
}

// Namespace smokeairdrop
// Params 1
// Checksum 0xc6f71d28, Offset: 0xc02
// Size: 0xa0
function function_b64b8f21ad072595( data )
{
    attacker = data.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    self dodamage( self.maxhealth / 10, self.origin, attacker, data.inflictor );
    
    if ( self.damagetaken >= 100 )
    {
        if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
        {
            attacker thread points::doscoreevent( #"destroyed_equipment" );
        }
        
        function_4570667c9acb5f7a( data );
    }
}

// Namespace smokeairdrop
// Params 1
// Checksum 0x3a012ff1, Offset: 0xcaa
// Size: 0x7b
function function_89632975862ec8f2( data )
{
    attacker = data.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) || getdvarint( @"hash_58254c61de76bffe", 0 ) )
    {
        attacker thread points::doscoreevent( #"disabled_smoke_airdrop" );
    }
    
    function_4570667c9acb5f7a( data );
}

// Namespace smokeairdrop
// Params 0
// Checksum 0xfd4a1e99, Offset: 0xd2d
// Size: 0x64
function function_a8cad0179fc15a65()
{
    if ( self.index == 1 )
    {
        return 4.3;
    }
    else if ( self.index == 2 )
    {
        return 5.5;
    }
    else if ( self.index == 3 )
    {
        return 5.5;
    }
    else if ( self.index == 4 )
    {
        return 4.8;
    }
    
    return 0;
}

// Namespace smokeairdrop
// Params 1
// Checksum 0x68ab8de3, Offset: 0xd9a
// Size: 0x55
function function_6f0bb36543c93f4a( drone )
{
    level endon( #"game_ended" );
    drone endon( #"death" );
    animstring = "activate_drone_" + drone.index;
    animation::anim_single_solo( drone, animstring );
    drone thread function_86628df649c71239();
}

// Namespace smokeairdrop
// Params 2
// Checksum 0x5ad00eca, Offset: 0xdf7
// Size: 0x1b5
function function_8bfa6fdf23e578a9( point, smokeforward )
{
    self endon( #"death" );
    returnpoint = self.origin;
    mindeploytime = getdvarfloat( @"hash_96d7e827843e457", 3 );
    offset = getdvarfloat( @"hash_320be90fa91ee74b", 1.5 );
    deploytime = function_a8cad0179fc15a65();
    dronepoint = point + anglestoup( self.angles ) * 350;
    droneangles = vectortoangles( smokeforward );
    scriptnode = spawnstruct();
    scriptnode.origin = dronepoint;
    scriptnode.angles = droneangles;
    scriptnode thread function_6f0bb36543c93f4a( self );
    
    if ( self.var_8a3c987868cf868f )
    {
        self playsound( "iw9_smoke_airdrop_center_incoming" );
    }
    else
    {
        self playsound( "iw9_smoke_airdrop_travel_incoming" );
    }
    
    wait deploytime;
    self setscriptablepartstate( "smokeDeploy", "settle", 0 );
    ai::function_5b4f66c4d86eea91( point, 18, 300, 250 );
    
    if ( self.index == 1 )
    {
        self.owner thread points::doscoreevent( #"super_smoke_airdrop" );
    }
    
    self playsound( "iw9_smoke_airdrop_release" );
    
    if ( self.playsmokesound )
    {
        thread smokeAirDrop_handleSmokeSounds( 23, self.origin - ( 0, 0, 100 ) );
    }
    
    if ( self.var_8a3c987868cf868f )
    {
        self playsound( "iw9_smoke_airdrop_center_outgoing" );
        return;
    }
    
    self playsound( "iw9_smoke_airdrop_travel_outgoing" );
}

// Namespace smokeairdrop
// Params 2
// Checksum 0x879eea60, Offset: 0xfb4
// Size: 0x91
function smokeAirDrop_handleSmokeSounds( smoketime, position )
{
    soundorg = spawn( "script_origin", position );
    soundorg.targetname = "smokeAirDrop_handleSmokeSounds";
    soundorg playsound( "iw9_smoke_airdrop_smoke_start" );
    soundorg playloopsound( "iw9_smoke_airdrop_smoke_lp" );
    soundorg ent_manager::registerspawncount( 1 );
    wait smoketime - 3;
    thread utility::play_sound_in_space( "iw9_smoke_airdrop_smoke_tail", position );
    wait 0.3;
    soundorg ent_manager::deregisterspawn();
    soundorg stoploopsound();
    soundorg delete();
}

// Namespace smokeairdrop
// Params 1
// Checksum 0xc1fb7322, Offset: 0x104d
// Size: 0x61
function function_86628df649c71239( data )
{
    level endon( #"game_ended" );
    
    if ( self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self notify( #"death" );
    self setscriptablepartstate( "smokeDeploy", "deployEnd", 0 );
    wait 0.35;
    function_21079f4698118f0a( self );
    self delete();
}

// Namespace smokeairdrop
// Params 1
// Checksum 0xc7815405, Offset: 0x10b6
// Size: 0x26
function function_4570667c9acb5f7a( data )
{
    self setscriptablepartstate( "destroy", "on", 0 );
    function_86628df649c71239( data );
}

// Namespace smokeairdrop
// Params 1
// Checksum 0x1eaeaf5, Offset: 0x10e4
// Size: 0x1f
function function_8d2befbc131859da( drone )
{
    level.smokeairdropdrones[ drone getentitynumber() ] = drone;
}

// Namespace smokeairdrop
// Params 1
// Checksum 0xee7b3b49, Offset: 0x110b
// Size: 0x1c
function function_21079f4698118f0a( drone )
{
    level.smokeairdropdrones[ drone getentitynumber() ] = undefined;
}

