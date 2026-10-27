// script_3b0670880a9f4b4f  (hash_3b0670880a9f4b4f.gscc) (size: 14757 Bytes / 0x39a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70c859c2 (1892178370)
// size ...... 14757 (0x39a5)
// includes .. 14  (offset: 0x36e5)
// strings ... 41  (offset: 0x3755)
// dev strs .. 1   (offset: 0x3999)
// exports ... 35  (offset: 0x22fd)
// cseg ...... 0x331 + 0x1fcc (0x22fd)
// imports ... 121 (offset: 0x2875)
// animtree1 . 0   (offset: 0x39a5)
// animtree2 . 0   (offset: 0x39a5)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\killstreaks\chopper_gunner;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\dmz\gametypes\dmz_samsites;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#using scripts\vehicle\vehicle_common;

#namespace namespace_abdf64fc596be565;

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0xb0cbc6ca, Offset: 0x34f
// Size: 0x47
function function_7d86b1d8eb835027()
{
    data = spawnstruct();
    data.spawnheli = &function_e7dd6d957aa2dff2;
    data.var_b1b3897987cfbae3 = &function_4d763cfe5c7cb1ae;
    data.flyaway = &function_a5f1508c99a6ae40;
    return data;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x6213e8da, Offset: 0x39f
// Size: 0xaf
function function_e7dd6d957aa2dff2( guardvehicle )
{
    heli = function_972372eb03a5fbd8();
    heli.guardvehicle = guardvehicle;
    heli.task = self;
    heli thread function_30aa5843e39c3893( guardvehicle );
    heli thread dmztask_shootturret();
    weapons::function_ef0cb557b1a93af9( heli );
    heli.flaresreservecount = 1;
    heli.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        heli thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_1e7a2f9bf41a3894 );
    }
    
    return heli;
}

// Namespace namespace_abdf64fc596be565
// Params 0, eflags: 0x4
// Checksum 0xa2e6d198, Offset: 0x457
// Size: 0x1e4
function private function_972372eb03a5fbd8()
{
    node = function_47c86977a18df38b( level.var_209035fc1e63a988, ( self.vehicle.origin + self.end.origin ) * 0.5 );
    spawnnode = spawnstruct();
    spawnnode.origin = node.origin;
    spawnnode.angles = node.angles;
    spawnnode.vehicletype = "veh_apache_mp_phys";
    spawnnode.modelname = "veh9_mil_air_heli_ahotel64_mp";
    spawnnode.targetname = "boatdrive_apache";
    faildata = spawnstruct();
    heli = vehicle_tracking::spawn_vehicle( spawnnode, faildata );
    heli.vehiclename = "veh_apache_mp_phys";
    heli.maxhealth = getdvarint( @"hash_3e5661644a24771e", 10000 );
    heli.health = heli.maxhealth;
    heli.team = "team_hundred_ninety_four";
    heli setvehicleteam( "team_hundred_ninety_four" );
    vehicle_tracking::register_instance( heli, undefined, heli.team );
    heli vehicle_damage::set_can_damage( 1 );
    heli.var_300686ebe3a78e39 = 1;
    heli damage::set_pre_mod_damage_callback( "veh_apache_mp_phys", &function_cf98706112b8b65f );
    heli damage::set_post_mod_damage_callback( "veh_apache_mp_phys", &function_9cf96da3151d7eb8 );
    heli damage::set_death_callback( "veh_apache_mp_phys", &function_69522a4aa6ce70ce );
    heli function_d2b8ee2e1275daaf( 1 );
    heli.exitnode = node;
    heli vehicle_damage::set_vehicle_hit_damage_data( "veh_apache_mp_phys", 20 );
    
    if ( getdvarint( @"hash_3061dc07aba9108", 1 ) )
    {
        heli thread dmz_samsites::function_ba338a496a75408e();
    }
    
    return heli;
}

// Namespace namespace_abdf64fc596be565
// Params 2, eflags: 0x4
// Checksum 0x7e8dcfb2, Offset: 0x644
// Size: 0x152
function private function_32be208fa62a1a01( heli, startingpos )
{
    origin = level.var_cbe4d28d28ae892a ?? heli.origin;
    aitype = ai_mp_controller::function_f7aef6871cda828( "ar" );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, heli.angles, "absolute", "mission", "vehicleDriveHeliDriver", undefined, undefined, undefined, self.node.script_poi, 1, undefined, 0 );
    
    if ( !isdefined( agent ) )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    availablepositionsstruct = heli vehicle_aianim::get_availablepositions();
    agent.script_startingposition = startingpos;
    pos = heli vehicle_aianim::choose_vehicle_position( agent, availablepositionsstruct, 0 );
    agent vehicle_common::entervehicle( heli, 1, pos, vehicle_aianim::anim_pos( heli, pos.vehicle_position ) );
    agent.vehicle_position = pos.vehicle_position;
    agent.goalradius = 10000;
    agent.maxsightdistsqrd = squared( 10000 );
    agent function_2ef9eb3349906d00( 10000 );
    agent.ignoreall = 1;
    return agent;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x97b3dc4d, Offset: 0x79f
// Size: 0x25
function function_b4861eac027b2ea7( heli )
{
    heli waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x84090fb0, Offset: 0x7cc
// Size: 0x133
function dmztask_spawnturret()
{
    turret = spawnturret( "misc_turret", self gettagorigin( "tag_turret" ), "chopper_gunner_turret_ballistics_dmz" );
    turret setmodel( "veh9_mil_air_heli_ahotel64_turret" );
    turret show();
    turret.angles = self.angles;
    turret.disabled = 0;
    turret.targetstate = undefined;
    turret linkto( self, "tag_turret" );
    turret setturretmodechangewait( 0 );
    turret setmode( "manual" );
    turret setdefaultdroppitch( 45 );
    turret.team = self.team;
    turret.owner = self;
    turret setturretteam( self.team );
    turret setentityowner( self );
    turret.targetent = spawn( "script_origin", turret.origin );
    turret settargetentity( turret.targetent );
    self.turret = turret;
    turret.heli = self;
    turret thread function_b4861eac027b2ea7( self );
    turret.targetent thread function_b4861eac027b2ea7( self );
    return turret;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0xa00f37d9, Offset: 0x908
// Size: 0x7b
function function_67bf9a82b9f0fe70( tag )
{
    missilepod = spawn( "script_model", self gettagorigin( tag ) );
    missilepod setmodel( "ks_chopper_gunner_turret_mp" );
    missilepod show();
    missilepod.angles = self.angles;
    missilepod linkto( self, tag );
    missilepod setotherent( self );
    missilepod.heli = self;
    missilepod thread function_b4861eac027b2ea7( self );
    return missilepod;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0xc0b33787, Offset: 0x98c
// Size: 0x83, Type: bool
function function_4aa8b8bb38d55a84( origin )
{
    forwarddot = vectordot( vectornormalize( origin - self.origin ), anglestoforward( self.angles ) );
    downdot = vectordot( vectornormalize( origin - self.origin ), -1 * anglestoup( self.angles ) );
    return forwarddot > 0.258819 && downdot > 0 || downdot > 0.95;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0xbb1fda3d, Offset: 0xa18
// Size: 0x6f, Type: bool
function function_eb6792abd521992a( origin )
{
    forwarddot = vectordot( vectornormalize( origin - self.origin ), anglestoforward( self.angles ) );
    downdot = vectordot( vectornormalize( origin - self.origin ), -1 * anglestoup( self.angles ) );
    return forwarddot > 0.4;
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x89e9d21a, Offset: 0xa90
// Size: 0x34, Type: bool
function function_609cb1d62c1a7201()
{
    dist = distance( self.guardvehicle.origin, self.origin );
    return dist < 10000;
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0xad6e6c65, Offset: 0xacd
// Size: 0x954
function dmztask_shootturret()
{
    self endon( #"death" );
    self endon( #"flyaway" );
    dmztask_spawnturret();
    self.var_795c9a23417e649c = function_67bf9a82b9f0fe70( "tag_gun_l" );
    self.var_bf973a4d1cadadc9 = function_67bf9a82b9f0fe70( "tag_gun_r" );
    firerate = 0.125;
    accumulatedtime = 0;
    totaltime = 0;
    var_8d8a136092f7362d = 40;
    currentmissile = self.var_795c9a23417e649c;
    trackingspeed = getdvarfloat( @"hash_7301b4fb9b20523d", 375 );
    predictiontime = getdvarfloat( @"hash_1e5806e5fc11f967", 1.33 );
    
    while ( self.health > 0 )
    {
        if ( !isdefined( self.guardvehicle ) )
        {
            return;
        }
        
        results = trace::ray_trace( self.origin, self.guardvehicle.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
        
        if ( distance( results[ "position" ], self.guardvehicle.origin ) < 500 )
        {
            self setlookatent( self.guardvehicle );
            var_e770ebd1b1330297 = function_4aa8b8bb38d55a84( self.guardvehicle.origin );
            var_beba067035d30e03 = function_eb6792abd521992a( self.guardvehicle.origin );
            
            if ( !var_e770ebd1b1330297 && !var_beba067035d30e03 )
            {
                waitframe();
                continue;
            }
            
            shootturret = undefined;
            
            if ( var_e770ebd1b1330297 && !var_beba067035d30e03 )
            {
                shootturret = 1;
            }
            else if ( !var_e770ebd1b1330297 && var_beba067035d30e03 )
            {
                shootturret = 0;
            }
            else
            {
                shootturret = randomfloat( 1 ) > 0.25;
            }
            
            if ( shootturret )
            {
                shots = 0;
                accumulatedtime = 0;
                totaltime = 0;
                self.turret.targetent.origin = self.guardvehicle.origin;
                velocity = self.guardvehicle vehicle_getvelocity();
                predictedorigin = self.guardvehicle.origin + velocity * 1.75;
                
                while ( shots < var_8d8a136092f7362d )
                {
                    if ( !isdefined( self.guardvehicle ) )
                    {
                        return;
                    }
                    
                    if ( totaltime > 5 )
                    {
                        break;
                    }
                    
                    if ( function_4aa8b8bb38d55a84( self.guardvehicle.origin ) )
                    {
                        results = trace::ray_trace( self.origin, self.guardvehicle.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
                        
                        if ( distance( results[ "position" ], self.guardvehicle.origin ) < 800 )
                        {
                            if ( totaltime < predictiontime )
                            {
                                self.turret.targetent.origin = predictedorigin;
                            }
                            else
                            {
                                len = min( distance( self.turret.targetent.origin, self.guardvehicle.origin ), trackingspeed * level.framedurationseconds );
                                diff = vectornormalize( self.guardvehicle.origin - self.turret.targetent.origin ) * len;
                                self.turret.targetent.origin += diff;
                            }
                            
                            if ( self.turret turretcantarget( self.turret.targetent.origin ) )
                            {
                                self.turret snaptotargetentity( self.turret.targetent );
                            }
                            
                            accumulatedtime += level.framedurationseconds;
                            
                            while ( accumulatedtime > 0 )
                            {
                                accumulatedtime -= firerate;
                                self.turret shootturret();
                                shots++;
                            }
                        }
                    }
                    
                    totaltime += level.framedurationseconds;
                    waitframe();
                }
                
                wait 3;
            }
            else
            {
                missilepod = self.var_795c9a23417e649c;
                
                if ( currentmissile == self.var_795c9a23417e649c )
                {
                    self.missilefireside = "left";
                    self.var_795c9a23417e649c thread chopper_gunner::choppergunner_firemissilefx( 1 );
                    missilepod = self.var_795c9a23417e649c;
                    currentmissile = self.var_bf973a4d1cadadc9;
                }
                else
                {
                    self.missilefireside = "right";
                    self.var_bf973a4d1cadadc9 thread chopper_gunner::choppergunner_firemissilefx( 2 );
                    missilepod = self.var_bf973a4d1cadadc9;
                    currentmissile = self.var_795c9a23417e649c;
                }
                
                turretviewpos = self.turret gettagorigin( "tag_pivot" );
                targetpos = self.guardvehicle.origin - self.guardvehicle vehicle_getvelocity() * 0.45;
                var_4cad6d273c18f7d6 = vectornormalize( targetpos - turretviewpos );
                missileorigin = missilepod.origin * ( 1, 1, 0 ) + ( 0, 0, turretviewpos[ 2 ] );
                missilestart = missileorigin + var_4cad6d273c18f7d6 * 100;
                missileend = missileorigin + var_4cad6d273c18f7d6 * 1000;
                missile_ref = "chopper_gunner_proj_dmz";
                missile = weapon_utility::_magicbullet( makeweapon( missile_ref ), missilestart, missileend );
                missile.owner = self;
                wait 0.25;
                
                if ( isdefined( missile ) )
                {
                    missile missile_settargetpos( targetpos );
                }
                
                wait 3;
            }
            
            continue;
        }
        
        teammates = teams::getteamdata( self.task.teams[ 0 ], "players" );
        
        foreach ( player in teammates )
        {
            if ( player::isaliveandnotinlaststand( player ) )
            {
                results = trace::ray_trace( self.origin, player.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
                
                if ( distance( results[ "position" ], player.origin ) < 100 )
                {
                    if ( function_4aa8b8bb38d55a84( player.origin ) )
                    {
                        shots = 0;
                        accumulatedtime = 0;
                        totaltime = 0;
                        self.turret.targetent.origin = player.origin;
                        
                        while ( shots < var_8d8a136092f7362d && player::isaliveandnotinlaststand( player ) )
                        {
                            if ( totaltime > 5 )
                            {
                                break;
                            }
                            
                            if ( self.health <= 0 )
                            {
                                return;
                            }
                            
                            self setlookatent( player );
                            
                            if ( function_4aa8b8bb38d55a84( player.origin ) )
                            {
                                results = trace::ray_trace( self.origin, player.origin, [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9, self.guardvehicle ] );
                                
                                if ( distance( results[ "position" ], player.origin ) < 100 )
                                {
                                    self.turret.targetent.origin = player.origin;
                                    
                                    if ( self.turret turretcantarget( self.turret.targetent.origin ) )
                                    {
                                        self.turret snaptotargetentity( self.turret.targetent );
                                    }
                                    
                                    accumulatedtime += level.framedurationseconds;
                                    
                                    while ( accumulatedtime > 0 )
                                    {
                                        accumulatedtime -= firerate;
                                        self.turret shootturret();
                                        shots++;
                                    }
                                }
                            }
                            
                            totaltime += level.framedurationseconds;
                            waitframe();
                        }
                        
                        wait 3;
                    }
                }
                
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x1009678f, Offset: 0x1429
// Size: 0xd4
function function_30aa5843e39c3893( vehicle )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self setmaxpitchroll( 20, 20 );
    self setneargoalnotifydist( 150 );
    updaterate = 0.5;
    
    while ( true )
    {
        wait updaterate;
        
        if ( !isdefined( vehicle ) )
        {
            thread function_a5f1508c99a6ae40();
            return;
        }
        
        veh_speed = vehicle vehicle_getspeed();
        currdist = distance2dsquared( self.origin, vehicle.var_66abea5e2c913ea4 );
        self vehicle_setspeed( 120, 30, 60 );
        thread function_dd9fe9f8ca1400b4( vehicle.previousposition + ( 0, 0, 1000 ), 1, vehicle );
        
        if ( function_2935ab622159fd55() )
        {
            thread function_a5f1508c99a6ae40();
            return;
        }
    }
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x78ffec4f, Offset: 0x1505
// Size: 0x222
function function_4d763cfe5c7cb1ae()
{
    self.vehicle endon( #"death" );
    self endon( #"task_ended" );
    self.vehicle.oldpositions = [ self.vehicle.origin, self.vehicle.origin, self.vehicle.origin, self.vehicle.origin ];
    maxindex = 3;
    var_610e761bc99e7e93 = 17.6;
    self.vehicle.currindex = 0;
    
    while ( true )
    {
        speed = self.vehicle vehicle_getspeed();
        forward = vectornormalize( self.vehicle.origin - self.vehicle.oldpositions[ self.vehicle.currindex ] );
        self.vehicle.previousposition = self.vehicle.oldpositions[ self.vehicle.currindex ];
        self.vehicle.var_66abea5e2c913ea4 = self.vehicle.origin + forward * speed * var_610e761bc99e7e93 * 6;
        self.vehicle.oldpositions[ self.vehicle.currindex ] = self.vehicle.origin;
        self.vehicle.currindex = self.vehicle.currindex < maxindex ? self.vehicle.currindex + 1 : 0;
        wait 1;
    }
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x2bd32254, Offset: 0x172f
// Size: 0x66, Type: bool
function function_cf98706112b8b65f( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && isdefined( self.turret ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            if ( attacker.owner == self )
            {
                return false;
            }
        }
        
        return ( attacker != self.turret );
    }
    
    return true;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x1a0f26b7, Offset: 0x179e
// Size: 0x2a, Type: bool
function function_9cf96da3151d7eb8( data )
{
    function_8ad53abf84929357( self.health - data.damage );
    return true;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x9f107d72, Offset: 0x17d1
// Size: 0x17, Type: bool
function function_69522a4aa6ce70ce( data )
{
    thread function_caae542150b139fa( data );
    return true;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x4e87d63b, Offset: 0x17f1
// Size: 0x27
function function_caae542150b139fa( data )
{
    function_76554059de2ad00( 150, data.objweapon );
    thread function_a23908d94789afee();
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x6dcb2626, Offset: 0x1820
// Size: 0x48
function function_8ad53abf84929357( health )
{
    if ( health < self.maxhealth )
    {
        if ( health < 300 )
        {
            function_b1a68b0dbdf5c192();
            return;
        }
        
        if ( health > 600 )
        {
            function_c31361a2df689694();
            return;
        }
        
        function_6458a588dfb87d13();
    }
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x94d769ec, Offset: 0x1870
// Size: 0x12
function function_6458a588dfb87d13()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0xceb60d24, Offset: 0x188a
// Size: 0x12
function function_c31361a2df689694()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x3cb44a15, Offset: 0x18a4
// Size: 0x12
function function_b1a68b0dbdf5c192()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace namespace_abdf64fc596be565
// Params 2
// Checksum 0x6d25b737, Offset: 0x18be
// Size: 0xc7
function function_76554059de2ad00( speed, weaponkilledby )
{
    self endon( #"explode" );
    self clearlookatent();
    self notify( #"crashing" );
    self setscriptablepartstate( "engine_explosion", "on", 0 );
    self setmaxpitchroll( 10, 50 );
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    glassdamagestate = "missile_damage";
    
    if ( isdefined( weaponkilledby ) && weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        glassdamagestate = "bullet_damage";
    }
    
    self setscriptablepartstate( "glass", glassdamagestate, 0 );
    var_61f902b2dd6fc262 = chopper_gunner::choppergunner_findcrashposition( 1250 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread chopper_gunner::choppergunner_spinout( speed );
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0x853d7551, Offset: 0x198d
// Size: 0x73
function function_a23908d94789afee()
{
    self notify( #"explode" );
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_mp" );
    }
    
    self setscriptablepartstate( "explode", "on", 0 );
    self setscriptablepartstate( "explode_smoke", "on", 0 );
    wait 0.35;
    function_45429e738ae4b802();
}

// Namespace namespace_abdf64fc596be565
// Params 4
// Checksum 0x34e6ac1, Offset: 0x1a08
// Size: 0x116
function function_1e7a2f9bf41a3894( player, missileteam, missiletarget, fxtagoverride )
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
            missiletarget thread function_694cc677dd17f97f( fxtagoverride );
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

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0xbbbb36d9, Offset: 0x1b26
// Size: 0x4b
function function_694cc677dd17f97f( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0xda91ac5b, Offset: 0x1b79
// Size: 0x6d
function function_a5f1508c99a6ae40()
{
    self endon( #"death" );
    
    if ( self.flyingaway )
    {
        return;
    }
    
    self notify( #"flyaway" );
    self.flyingaway = 1;
    self vehicle_setspeed( 80, 25, 25 );
    self setvehgoalpos( self.exitnode.origin, 1 );
    self waittill( #"near_goal" );
    function_45429e738ae4b802();
}

// Namespace namespace_abdf64fc596be565
// Params 0
// Checksum 0xce07bd30, Offset: 0x1bee
// Size: 0xbf
function function_45429e738ae4b802()
{
    if ( isdefined( self.turret ) )
    {
        self.turret setentityowner( undefined );
        self.turret delete();
        
        if ( isdefined( self.turret.firetarget ) )
        {
            self.turret.firetarget delete();
        }
    }
    
    if ( isdefined( self.var_795c9a23417e649c ) )
    {
        self.var_795c9a23417e649c setentityowner( undefined );
        self.var_795c9a23417e649c delete();
    }
    
    if ( isdefined( self.var_bf973a4d1cadadc9 ) )
    {
        self.var_bf973a4d1cadadc9 setentityowner( undefined );
        self.var_bf973a4d1cadadc9 delete();
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_abdf64fc596be565
// Params 0, eflags: 0x4
// Checksum 0xee55bc8f, Offset: 0x1cb5
// Size: 0x3, Type: bool
function private function_2935ab622159fd55()
{
    return false;
}

// Namespace namespace_abdf64fc596be565
// Params 3, eflags: 0x4
// Checksum 0x3d8c58e0, Offset: 0x1cc1
// Size: 0x127
function private function_e1b22914d59fb6d0( point, numpositions, pathradius )
{
    var_f2c7f3bde90b912c = 360 / numpositions;
    positions = [];
    fwd = ( 1, 0, 0 );
    i = 0;
    
    while ( i < 360 )
    {
        altforward = fwd * pathradius;
        rotatedfwd = ( cos( i ) * altforward[ 0 ] - sin( i ) * altforward[ 1 ], sin( i ) * altforward[ 0 ] + cos( i ) * altforward[ 1 ], altforward[ 2 ] );
        pos = point + rotatedfwd;
        position = spawnstruct();
        position.origin = pos;
        z = position function_c506d29e15f48af8();
        position.origin = ( position.origin[ 0 ], position.origin[ 1 ], z );
        positions[ positions.size ] = position;
        i += var_f2c7f3bde90b912c;
    }
    
    return positions;
}

// Namespace namespace_abdf64fc596be565
// Params 0, eflags: 0x4
// Checksum 0xe5c86d04, Offset: 0x1df1
// Size: 0x35
function private function_c506d29e15f48af8()
{
    heliheight = getgroundposition( self.origin, 128, 10000, 2000 ) + ( 0, 0, 1000 );
    return heliheight[ 2 ];
}

// Namespace namespace_abdf64fc596be565
// Params 3, eflags: 0x4
// Checksum 0xdfd5c073, Offset: 0x1e2f
// Size: 0x160
function private function_dd9fe9f8ca1400b4( goal_pos, stopatgoal, vehicle )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self endon( #"circle" );
    self notify( #"hash_4fb7549081cc9f4c" );
    self endon( #"hash_4fb7549081cc9f4c" );
    path = function_f40b7aa48209d200( goal_pos, vehicle );
    
    foreach ( index, node in path )
    {
        if ( !( isdefined( node ) && isdefined( vehicle ) ) )
        {
            return;
        }
        
        if ( index == path.size - 1 )
        {
            self setvehgoalpos( node, stopatgoal );
        }
        else
        {
            self setvehgoalpos( node );
        }
        
        angle = ( self.angles[ 0 ], vectortoangles( vehicle.origin - node )[ 1 ], self.angles[ 2 ] );
        self function_90dd560e86fb2f45( angle, 0, 2, 0.5, 0.2, 2, 1 );
        self waittill( #"near_goal" );
    }
}

// Namespace namespace_abdf64fc596be565
// Params 2, eflags: 0x4
// Checksum 0xf8468f, Offset: 0x1f97
// Size: 0x22c
function private function_f40b7aa48209d200( goal_pos, vehicle )
{
    path = [];
    dir = vectortoangles( goal_pos - self.origin );
    fwd = anglestoforward( dir );
    dist = length( self.origin - goal_pos );
    currpos = self.origin;
    steps = max( dist / 250, 1 );
    
    for ( i = 0; i < steps ; i++ )
    {
        if ( i > 3 )
        {
            break;
        }
        
        fwddist = 250;
        newpos = currpos + fwd * fwddist;
        ignore = [ self, self.turret, self.var_795c9a23417e649c, self.var_bf973a4d1cadadc9 ];
        
        for ( heightstep = 0; heightstep < 5 ; heightstep++ )
        {
            trace = trace::sphere_get_closest_point( newpos, 400, 0, ignore );
            
            if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
            {
                newpos += ( 0, 0, 125 );
                continue;
            }
            
            break;
        }
        
        heliorigin = currpos;
        
        for ( heightstep = 0; heightstep < 5 ; heightstep++ )
        {
            trace = trace::sphere_get_closest_point( heliorigin, 400, 0, ignore );
            
            if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
            {
                heliorigin += ( 0, 0, 125 ) + fwd * -50;
                continue;
            }
            
            break;
        }
        
        trace = trace::ray_trace( heliorigin, newpos, ignore, undefined, undefined, 1, 1 );
        
        if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
        {
            path[ path.size ] = heliorigin;
        }
        else
        {
            path[ path.size ] = heliorigin;
            path[ path.size ] = newpos;
        }
        
        currpos = path[ path.size - 1 ];
    }
    
    path = function_1d15306bcf7166c2( path );
    return path;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0x9247b7d9, Offset: 0x21cc
// Size: 0xc3
function function_1d15306bcf7166c2( path )
{
    thresh = 100;
    
    foreach ( index, node in path )
    {
        if ( index == path.size - 1 )
        {
            break;
        }
        
        diff = path[ index + 1 ][ 2 ] - node[ 2 ];
        
        if ( diff > thresh )
        {
            node += ( 0, 0, node[ 2 ] + diff / 2 );
        }
    }
    
    return path;
}

// Namespace namespace_abdf64fc596be565
// Params 1
// Checksum 0xf5743416, Offset: 0x2298
// Size: 0x64
function function_f10eacb2599dbcb( pos )
{
    if ( !isdefined( level.var_ac7279cacc94501 ) )
    {
        return;
    }
    
    closest = function_47c86977a18df38b( level.var_ac7279cacc94501, pos );
    
    if ( isdefined( closest ) && distancesquared( closest.origin, pos ) <= squared( closest.radius ) )
    {
        return closest;
    }
}

