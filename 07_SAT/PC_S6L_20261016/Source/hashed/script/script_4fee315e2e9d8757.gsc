// script_4fee315e2e9d8757  (hash_4fee315e2e9d8757.gscc) (size: 16539 Bytes / 0x409b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49e7e57d (1239934333)
// size ...... 16539 (0x409b)
// includes .. 12  (offset: 0x3e0f)
// strings ... 37  (offset: 0x3e6f)
// dev strs .. 0   (offset: 0x409b)
// exports ... 35  (offset: 0x2cb7)
// cseg ...... 0x2e1 + 0x29d6 (0x2cb7)
// imports ... 92  (offset: 0x322f)
// animtree1 . 0   (offset: 0x409b)
// animtree2 . 0   (offset: 0x409b)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_tracking;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\killstreaks\remotetank;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\turret_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\sentientpoolmanager;

#namespace dmz_ai_vehicle;

// Namespace dmz_ai_vehicle
// Params 7
// Checksum 0x4816f3d2, Offset: 0x2ff
// Size: 0x375
function function_84d0737b8592e0ac( pos, patrolstruct, vehicle, model, patrolradius, name, owneroverride )
{
    spawndata = spawnstruct();
    spawndata.origin = pos;
    spawndata.angles = ( 0, 0, 0 );
    spawndata.spawntype = "veh_pac_sentry_amphibious_mp_biolab";
    spawndata.owner = undefined;
    spawndata.team = "team_hundred_ninety_four";
    spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_mp";
    spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_biolab";
    spawndata.targetname = "remote_tank";
    spawndata.cancapture = 0;
    spawndata.cancaptureimmediately = 0;
    spawndata.activateimmediately = 1;
    remotetank = vehicle_tracking::spawn_vehicle( spawndata );
    
    if ( isdefined( owneroverride ) )
    {
        remotetank.owner = owneroverride;
        remotetank setentityowner( owneroverride );
    }
    else
    {
        fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
        remotetank.owner = fakeowner;
        remotetank sentientpoolmanager::registersentient( "Killstreak_Ground", spawndata.team );
    }
    
    remotetank.team = "team_hundred_ninety_four";
    remotetank.tanktype = "pac_sentry";
    remotetank.maxhealth = 6000;
    remotetank.health = 6000;
    remotetank.currenthealth = 6000;
    remotetank.pathstruct = patrolstruct;
    remotetank.patrolstruct = patrolstruct;
    remotetank.vehiclename = "pac_sentry";
    remotetank.spinuptime = 1;
    remotetank laseron();
    remotetank addcomponent( "p2p" );
    remotetank setconfigvalue( "p2p", "reverseGasNormal", 1.5 );
    remotetank setconfigvalue( "p2p", "steeringMultiplier", 15 );
    remotetank setconfigvalue( "p2p", "manualSpeed", 10 );
    remotetank setconfigvalue( "p2p", "reverseForBehindGoal", 1 );
    remotetank setconfigvalue( "p2p", "stuckTime", 4 );
    remotetank setconfigvalue( "p2p", "goalThreshold", 10 );
    remotetank emp_debuff::set_start_emp_callback( &empstarted );
    remotetank emp_debuff::set_clear_emp_callback( &empcleared );
    remotetank.var_c65210324564022c = 10000;
    remotetank remotetank::function_51d427f6f87f1b46( remotetank vehicle::get_ref(), 10 );
    function_92a241b7055daf27( remotetank vehicle::get_ref() );
    playfxontag( utility::getfx( "vfx_dmz_Wheelson_flashlight" ), remotetank, "tag_flash" );
    remotetank.currentstate = "patrol";
    remotetank vehicleshowonminimap( 0 );
    remotetank.damagecallback = &vehicle_damagecallback;
    remotetank thread vehicle_patrol( patrolstruct );
    remotetank thread function_d5418b3b0ca3a085();
    remotetank thread function_1227aaa45677d3f();
    remotetank.damagestate = 0;
    remotetank.ignoredteams = [];
    vehicle_tracking::register_instance( remotetank, remotetank.owner, remotetank.owner.team );
    return remotetank;
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xea7abae, Offset: 0x67d
// Size: 0x232
function function_92a241b7055daf27( streakname )
{
    weaponname = "thermite_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 18;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 25;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 7;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 8;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "c4_mp";
    weaponhitsperattack = 5;
    var_ffcfe5819a7a67f1 = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "at_mine_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 4;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 50;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace dmz_ai_vehicle
// Params 3
// Checksum 0x6a008ddc, Offset: 0x8b7
// Size: 0x1b3
function function_2ecd3792264b0024( startnode, primarynode, secondarynode )
{
    pathstruct = spawnstruct();
    pathstruct.path = [ startnode ];
    pathstruct.secondarynodes = [];
    pathstruct.speed = 10;
    pathstruct.direction = 1;
    pathstruct.index = 0;
    curnode = startnode;
    
    while ( isdefined( curnode.target ) )
    {
        curindex = pathstruct.path.size - 1;
        pathstruct.secondarynodes[ curindex ] = [];
        subnodes = utility::getstructarray( curnode.target, "targetname" );
        
        foreach ( node in subnodes )
        {
            if ( node.script_noteworthy == primarynode )
            {
                curnode = node;
                pathstruct.path[ pathstruct.path.size ] = node;
                continue;
            }
            
            if ( node.script_noteworthy == secondarynode )
            {
                pathstruct.secondarynodes[ curindex ][ pathstruct.secondarynodes[ curindex ].size ] = function_2a8b576f90cc10d6( node, secondarynode );
            }
        }
    }
    
    return pathstruct;
}

// Namespace dmz_ai_vehicle
// Params 2, eflags: 0x4
// Checksum 0xe4881668, Offset: 0xa73
// Size: 0xb6
function private function_2a8b576f90cc10d6( startnode, nodenames )
{
    pathstruct = spawnstruct();
    pathstruct.path = [ startnode ];
    pathstruct.speed = 10;
    pathstruct.direction = 1;
    pathstruct.index = 0;
    curnode = startnode;
    
    while ( isdefined( curnode.target ) )
    {
        curnode = utility::getstructarray( curnode.target, "targetname" )[ 0 ];
        pathstruct.path[ pathstruct.path.size ] = curnode;
    }
    
    return pathstruct;
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x757d9fc4, Offset: 0xb32
// Size: 0x41
function vehicle_patrol( pathstruct )
{
    if ( pathstruct.path.size > 0 )
    {
        self.var_1ff00ec76f9f0c1b = undefined;
        thread vehicle_ai::follow_path_struct( pathstruct, pathstruct.speed, undefined, "soldier" );
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x1d192322, Offset: 0xb7b
// Size: 0x8a
function function_cbb5b66f9c25d0e6()
{
    if ( isdefined( self.var_1ff00ec76f9f0c1b ) )
    {
        subpath = function_23118dd503430443( 0, self.var_b1e3416b5ccf2c13, self.var_1ff00ec76f9f0c1b );
        vehicle_ai::go_to_path( subpath, 10, 1, 1 );
        self.var_a13bc2fd92782fbf = undefined;
        self.var_1ff00ec76f9f0c1b = undefined;
        self.var_b1e3416b5ccf2c13 = undefined;
    }
    
    thread vehicle_ai::follow_path_struct( self.patrolstruct, self.patrolstruct.speed, undefined, "soldier" );
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x10f8700d, Offset: 0xc0d
// Size: 0x368
function function_d5418b3b0ca3a085()
{
    self endon( #"death" );
    thread function_b709586c30f25ca3();
    childthread function_49366b126029de12();
    
    while ( true )
    {
        while ( self.emp || self.ishaywire )
        {
            wait 0.2;
        }
        
        closesttarget = undefined;
        closestdistsq = undefined;
        var_bd0c73bc205cd4ee = utility::playersinsphere( self.origin, 2048 );
        
        foreach ( target in var_bd0c73bc205cd4ee )
        {
            if ( !vehicle_isvalidtarget( target ) )
            {
                continue;
            }
            
            totarget = target.origin - self.origin;
            angleto = vectordot( anglestoforward( self gettagangles( "tag_flash" ) ), totarget );
            
            if ( angleto < 90 )
            {
                continue;
            }
            
            distsq = distancesquared( target.origin, self.origin );
            
            if ( !isdefined( closesttarget ) || distsq < closestdistsq )
            {
                closesttarget = target;
                closestdistsq = distsq;
            }
        }
        
        if ( isdefined( self.lastplayerattacker ) )
        {
            closesttarget = self.lastplayerattacker;
        }
        
        if ( isdefined( closesttarget ) )
        {
            vehicle_entercombatstate();
            vehicle_attacktarget( closesttarget );
            thread function_b709586c30f25ca3();
            self.lastplayerattacker = undefined;
        }
        else
        {
            agentsinrange = getaiarrayinradius( self.origin, 500 );
            validtargets = [];
            
            foreach ( agent in agentsinrange )
            {
                if ( isenemyteam( self.team, agent.team ) && vehicle_isvalidtarget( agent ) )
                {
                    validtargets[ validtargets.size ] = agent;
                }
            }
            
            closesttarget = undefined;
            closestdistsq = undefined;
            
            foreach ( agent in validtargets )
            {
                totarget = agent.origin - self.origin;
                angleto = vectordot( anglestoforward( self gettagangles( "tag_flash" ) ), totarget );
                
                if ( angleto < 90 )
                {
                    continue;
                }
                
                distsq = distancesquared( agent.origin, self.origin );
                
                if ( !isdefined( closesttarget ) || distsq < closestdistsq )
                {
                    closesttarget = agent;
                    closestdistsq = distsq;
                }
                
                if ( isdefined( closesttarget ) )
                {
                    vehicle_entercombatstate();
                    vehicle_attacktarget( closesttarget );
                    thread function_b709586c30f25ca3();
                    self.var_d60900a636f6f4c1 = undefined;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0xee920b25, Offset: 0xf7d
// Size: 0x197
function function_49366b126029de12()
{
    while ( true )
    {
        while ( self.emp || self.ishaywire )
        {
            wait 0.2;
        }
        
        if ( isagent( self.var_d60900a636f6f4c1 ) )
        {
            closesttarget = undefined;
            closestdistsq = undefined;
            var_bd0c73bc205cd4ee = utility::playersinsphere( self.origin, 2048 );
            
            foreach ( target in var_bd0c73bc205cd4ee )
            {
                if ( !vehicle_isvalidtarget( target ) )
                {
                    continue;
                }
                
                totarget = target.origin - self.origin;
                angleto = vectordot( anglestoforward( self gettagangles( "tag_flash" ) ), totarget );
                
                if ( angleto < 90 )
                {
                    continue;
                }
                
                distsq = distancesquared( target.origin, self.origin );
                
                if ( !isdefined( closesttarget ) || distsq < closestdistsq )
                {
                    closesttarget = target;
                    closestdistsq = distsq;
                }
            }
            
            if ( isdefined( self.lastplayerattacker ) )
            {
                closesttarget = self.lastplayerattacker;
            }
            
            if ( isdefined( closesttarget ) )
            {
                self notify( #"hash_261901a44421d4b" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0xfc1f7899, Offset: 0x111c
// Size: 0x139
function function_b709586c30f25ca3()
{
    self endon( #"death" );
    self endon( #"dmz_ai_vehicle_entercombatstate" );
    self.currentstate = "patrol";
    scanangle = 0;
    direction = 1;
    
    while ( true )
    {
        if ( self.emp )
        {
            turretdir = anglestoforward( self gettagangles( "tag_flash" ) );
            self setturrettargetvec( turretdir * 500 + ( 0, -800, 0 ) );
        }
        
        while ( self.emp || self.ishaywire )
        {
            wait 0.2;
        }
        
        scanangle += 90 * direction;
        
        if ( scanangle >= 360 || scanangle <= 0 )
        {
            direction *= -1;
        }
        
        targetangles = ( 0, scanangle, 0 );
        targetvec = anglestoforward( targetangles );
        start = self.origin + ( 0, 0, 16 );
        end = start + 6000 * targetvec;
        self setturrettargetvec( end );
        utility::waittill_any_timeout( 2, "turret_on_target" );
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x1142f92, Offset: 0x125d
// Size: 0x2c
function vehicle_entercombatstate()
{
    self.var_f792aef1ff038127 = self.origin;
    self notify( #"hash_ff603c86bbe07fdb" );
    self notify( #"dmz_ai_vehicle_entercombatstate" );
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xe0e08cf7, Offset: 0x1291
// Size: 0x1ee
function vehicle_attacktarget( target )
{
    self endon( #"death" );
    self endon( #"enter_patrol" );
    self endon( #"hash_261901a44421d4b" );
    self.var_d60900a636f6f4c1 = target;
    childthread function_e79972f224ac5da8();
    tankconfig = remotetank::function_bc0ca08e83bd890( self );
    
    while ( true )
    {
        if ( !isalive( target ) )
        {
            break;
        }
        
        riottarget = undefined;
        
        if ( target.hasriotshieldequipped )
        {
            riottarget = target;
        }
        
        if ( !vehicle_isvalidtarget( target ) || target.hasriotshieldequipped || isdefined( self.lastplayerattacker ) && self.lastplayerattacker != target )
        {
            if ( isdefined( self.lastplayerattacker ) && self.lastplayerattacker != target )
            {
                target = self.lastplayerattacker;
            }
            else
            {
                var_bd0c73bc205cd4ee = utility::playersinsphere( self.origin, 2048 );
                var_bd0c73bc205cd4ee = sortbydistance( var_bd0c73bc205cd4ee, self.origin );
                
                foreach ( nearbytarget in var_bd0c73bc205cd4ee )
                {
                    if ( !vehicle_isvalidtarget( nearbytarget ) )
                    {
                        continue;
                    }
                    
                    if ( nearbytarget.hasriotshieldequipped && !isdefined( riottarget ) )
                    {
                        riottarget = nearbytarget;
                        continue;
                    }
                    
                    target = nearbytarget;
                    break;
                }
            }
            
            if ( !vehicle_isvalidtarget( target ) && isdefined( riottarget ) )
            {
                target = riottarget;
            }
        }
        
        self.currentstate = "attack";
        vehicle_fireweapon( target, tankconfig );
        function_5bc796a0467c0aa5();
        wait 0.2;
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x6d885100, Offset: 0x1487
// Size: 0x65
function function_5ae7345beac4c964( tankconfig )
{
    self endon( #"death" );
    spinuptime = self.spinuptime;
    self playsound( "kls_sentry_alert_target" );
    self setvehweaponspinning( 1 );
    self.turretspinning = 1;
    
    while ( spinuptime > 0 )
    {
        spinuptime -= 0.05;
        wait 0.05;
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0xed556881, Offset: 0x14f4
// Size: 0x4e
function function_5bc796a0467c0aa5()
{
    if ( self.turretspinning )
    {
        spinuptime = self.spinuptime;
        self setvehweaponspinning( 0 );
        self.turretspinning = undefined;
        
        while ( spinuptime > 0 )
        {
            spinuptime -= 0.05;
            wait 0.05;
        }
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x9d76f7f4, Offset: 0x154a
// Size: 0xbd
function function_e79972f224ac5da8()
{
    targetfails = 0;
    maxfails = 4;
    
    if ( isdefined( self.var_fa0fa09df7fe774f ) )
    {
        maxfails = self.var_fa0fa09df7fe774f;
    }
    
    while ( true )
    {
        if ( !function_75a907766ae1570a( self.var_d60900a636f6f4c1 ) )
        {
            thread function_cbb5b66f9c25d0e6();
            self notify( #"hash_261901a44421d4b" );
            waitframe();
        }
        
        if ( function_f41e649f44578370( self.var_d60900a636f6f4c1 ) )
        {
            targetfails = 0;
            wait 0.5;
            continue;
        }
        
        if ( function_ea16f2d1191d94c6( self.var_d60900a636f6f4c1 ) )
        {
            targetfails = 0;
            waitframe();
            continue;
        }
        
        targetfails += 1;
        
        if ( targetfails > maxfails )
        {
            thread function_cbb5b66f9c25d0e6();
            self notify( #"hash_261901a44421d4b" );
        }
        
        wait 1;
    }
}

// Namespace dmz_ai_vehicle
// Params 1, eflags: 0x4
// Checksum 0x6405c40e, Offset: 0x160f
// Size: 0xc4, Type: bool
function private function_75a907766ae1570a( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        if ( isdefined( self.ignoredteams ) && arraycontains( self.ignoredteams, target.team ) )
        {
            return false;
        }
        
        if ( !target player::isreallyalive() || target.sessionstate != "playing" )
        {
            return false;
        }
        
        if ( player::isinlaststand( target ) )
        {
            return false;
        }
        
        if ( target.notarget )
        {
            return false;
        }
        
        if ( target == self.owner )
        {
            return false;
        }
    }
    else if ( isagent( target ) )
    {
        if ( !isalive( target ) )
        {
            return false;
        }
        
        if ( target.ignoreme )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dmz_ai_vehicle
// Params 1, eflags: 0x4
// Checksum 0x156b70df, Offset: 0x16dc
// Size: 0x4e
function private function_f41e649f44578370( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    if ( isplayer( target ) )
    {
        return self vehicle_canturrettargetpoint( target gettagorigin( "j_mainroot" ), 1, self );
    }
    else if ( isagent( target ) )
    {
        return self vehicle_canturrettargetpoint( target getcentroid(), 1, self );
    }
    
    return 0;
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xf9450420, Offset: 0x1733
// Size: 0x22
function vehicle_isvalidtarget( target )
{
    if ( !function_75a907766ae1570a( target ) )
    {
        return 0;
    }
    
    return function_f41e649f44578370( target );
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xf23f0cf4, Offset: 0x175e
// Size: 0x3c
function function_17eec4d2baea6422( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    if ( isplayer( target ) )
    {
        return target gettagorigin( "j_mainroot" );
    }
    
    if ( isagent( target ) )
    {
        return target getcentroid();
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x1f14bb49, Offset: 0x17a3
// Size: 0x5b0, Type: bool
function function_ea16f2d1191d94c6( target )
{
    newpath = undefined;
    curnode = self.patrolstruct.path[ self.patrolstruct.index ];
    
    for ( i = 0; i < 4 ; i++ )
    {
        forwardindex = self.patrolstruct.index + i;
        forwardindex = forwardindex >= self.patrolstruct.path.size ? forwardindex - self.patrolstruct.path.size : forwardindex;
        
        if ( function_8ca1ae2bc83efa53( self.patrolstruct.path[ forwardindex ], target ) )
        {
            newpath = function_e21ba26e2e031229( forwardindex, 1 );
            self.var_a13bc2fd92782fbf = undefined;
            self.var_1ff00ec76f9f0c1b = undefined;
            self.var_b1e3416b5ccf2c13 = undefined;
            self.patrolstruct.index = forwardindex;
            
            /#
                vehicle_drawpath( newpath.path );
            #/
            
            vehicle_ai::go_to_path( newpath.path, newpath.speed, 1, 1 );
            return true;
        }
        
        if ( self.patrolstruct.secondarynodes[ forwardindex ].size > 0 )
        {
            foreach ( parentindex, parentnode in self.patrolstruct.secondarynodes[ forwardindex ] )
            {
                foreach ( index, node in parentnode.path )
                {
                    if ( function_8ca1ae2bc83efa53( node, target ) )
                    {
                        if ( i != 0 )
                        {
                            newpath = function_e21ba26e2e031229( forwardindex, 1, index, parentindex );
                            self.var_a13bc2fd92782fbf = index;
                            self.var_1ff00ec76f9f0c1b = parentindex;
                            self.var_b1e3416b5ccf2c13 = forwardindex;
                            self.patrolstruct.index = forwardindex;
                            
                            /#
                                vehicle_drawpath( newpath.path );
                            #/
                            
                            vehicle_ai::go_to_path( newpath.path, newpath.speed, 1, 1 );
                        }
                        else
                        {
                            subpath = function_23118dd503430443( index, forwardindex, parentindex );
                            self.var_a13bc2fd92782fbf = index;
                            self.var_1ff00ec76f9f0c1b = parentindex;
                            self.var_b1e3416b5ccf2c13 = forwardindex;
                            self.patrolstruct.index = forwardindex;
                            
                            /#
                                vehicle_drawpath( subpath );
                            #/
                            
                            vehicle_ai::go_to_path( subpath, 10, 1, 1 );
                        }
                        
                        return true;
                    }
                }
            }
        }
        
        if ( i == 0 )
        {
            continue;
        }
        
        backwardsindex = self.patrolstruct.index - i;
        backwardsindex = backwardsindex < 0 ? backwardsindex + self.patrolstruct.path.size : backwardsindex;
        
        if ( function_8ca1ae2bc83efa53( self.patrolstruct.path[ backwardsindex ], target ) )
        {
            newpath = function_e21ba26e2e031229( backwardsindex, 0 );
            self.var_a13bc2fd92782fbf = undefined;
            self.var_1ff00ec76f9f0c1b = undefined;
            self.var_b1e3416b5ccf2c13 = undefined;
            self.patrolstruct.index = backwardsindex;
            
            /#
                vehicle_drawpath( newpath.path );
            #/
            
            vehicle_ai::go_to_path( newpath.path, newpath.speed, 1, 1 );
            return true;
        }
        
        if ( self.patrolstruct.secondarynodes[ backwardsindex ].size > 0 )
        {
            foreach ( parentindex, parentnode in self.patrolstruct.secondarynodes[ backwardsindex ] )
            {
                foreach ( index, node in parentnode.path )
                {
                    if ( function_8ca1ae2bc83efa53( node, target ) )
                    {
                        newpath = function_e21ba26e2e031229( backwardsindex, 1, index, parentindex );
                        self.var_a13bc2fd92782fbf = index;
                        self.var_1ff00ec76f9f0c1b = parentindex;
                        self.var_b1e3416b5ccf2c13 = backwardsindex;
                        self.patrolstruct.index = backwardsindex;
                        
                        /#
                            vehicle_drawpath( newpath.path );
                        #/
                        
                        vehicle_ai::go_to_path( newpath.path, newpath.speed, 1, 1 );
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xcf247598, Offset: 0x1d5c
// Size: 0x7c
function vehicle_drawpath( newpath )
{
    for ( i = 0; i <= newpath.size - 1 ; i++ )
    {
        if ( i == newpath.size - 1 )
        {
            utility::draw_arrow_time( self.origin, newpath[ i ], ( 255, 0, 0 ), 10 );
            continue;
        }
        
        utility::draw_arrow_time( newpath[ i ], newpath[ i + 1 ], ( 255, 0, 0 ), 10 );
    }
}

// Namespace dmz_ai_vehicle
// Params 4
// Checksum 0x2a978ea0, Offset: 0x1de0
// Size: 0x19e
function function_e21ba26e2e031229( index, forward, subindex, var_195b0ae1c5734830 )
{
    pathstruct = spawnstruct();
    pathstruct.path = function_23118dd503430443( 0, self.var_b1e3416b5ccf2c13, self.var_1ff00ec76f9f0c1b );
    pathstruct.speed = 10;
    pathstruct.index = 0;
    curindex = self.patrolstruct.index;
    
    if ( forward )
    {
        while ( index >= curindex )
        {
            pathstruct.path[ pathstruct.path.size ] = self.patrolstruct.path[ curindex ].origin;
            curindex += 1;
        }
    }
    else
    {
        curindex -= 1;
        
        while ( curindex >= index )
        {
            pathstruct.path[ pathstruct.path.size ] = self.patrolstruct.path[ curindex ].origin;
            curindex -= 1;
        }
    }
    
    if ( isdefined( var_195b0ae1c5734830 ) )
    {
        for ( i = 0; i < subindex ; i++ )
        {
            pathstruct.path[ pathstruct.path.size ] = self.patrolstruct.secondarynodes[ index ][ var_195b0ae1c5734830 ].path[ i ].origin;
        }
    }
    
    return pathstruct;
}

// Namespace dmz_ai_vehicle
// Params 3
// Checksum 0x4a5f40fd, Offset: 0x1f87
// Size: 0x1d8
function function_23118dd503430443( index, parentindex, var_195b0ae1c5734830 )
{
    newpath = [];
    
    if ( isdefined( self.var_1ff00ec76f9f0c1b ) )
    {
        if ( var_195b0ae1c5734830 == self.var_1ff00ec76f9f0c1b )
        {
            direction = self.var_a13bc2fd92782fbf > index ? -1 : 1;
            i = self.var_a13bc2fd92782fbf;
            
            while ( i != index + direction )
            {
                newpath[ newpath.size ] = self.patrolstruct.secondarynodes[ parentindex ][ var_195b0ae1c5734830 ].path[ i ].origin;
                i += direction;
            }
        }
        else
        {
            for ( i = self.var_a13bc2fd92782fbf; i >= 0 ; i-- )
            {
                newpath[ newpath.size ] = self.patrolstruct.secondarynodes[ parentindex ][ self.var_1ff00ec76f9f0c1b ].path[ i ].origin;
            }
            
            newpath[ newpath.size ] = self.patrolstruct.path[ self.patrolstruct.index ].origin;
            
            for ( i = 0; i < index ; i++ )
            {
                newpath[ newpath.size ] = self.patrolstruct.secondarynodes[ parentindex ][ var_195b0ae1c5734830 ].path[ i ].origin;
            }
        }
    }
    else if ( isdefined( parentindex ) && isdefined( var_195b0ae1c5734830 ) )
    {
        newpath[ newpath.size ] = self.patrolstruct.secondarynodes[ parentindex ][ var_195b0ae1c5734830 ].path[ 0 ].origin;
    }
    
    return newpath;
}

// Namespace dmz_ai_vehicle
// Params 2
// Checksum 0x10c43ad9, Offset: 0x2168
// Size: 0x131
function function_8ca1ae2bc83efa53( node, target )
{
    if ( isdefined( self.var_c65210324564022c ) )
    {
        var_c65210324564022c = self.var_c65210324564022c;
    }
    
    if ( distancesquared( self.origin, node.origin ) < var_c65210324564022c )
    {
        return 0;
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1 );
    canseetarget = trace::ray_trace_passed( target.origin, node.origin + ( 0, 0, 50 ), [ self ], contentsoverride );
    
    /#
        if ( canseetarget )
        {
            utility::draw_arrow_time( node.origin + ( 0, 0, 50 ), target.origin, ( 0, 255, 0 ), 2 );
        }
        else
        {
            utility::draw_arrow_time( node.origin + ( 0, 0, 50 ), target.origin, ( 255, 0, 0 ), 2 );
        }
    #/
    
    return canseetarget;
}

// Namespace dmz_ai_vehicle
// Params 2
// Checksum 0x22e80956, Offset: 0x22a2
// Size: 0x1db
function vehicle_fireweapon( target, cfg )
{
    self endon( #"death" );
    self endon( #"enter_patrol" );
    self endon( #"hash_261901a44421d4b" );
    firetime = weaponfiretime( cfg.weaponinfo );
    minshots = 50;
    maxshots = 65;
    minpause = cfg.pausemin;
    maxpause = cfg.pausemax;
    numshots = randomintrange( minshots, maxshots + 1 );
    
    if ( !vehicle_isvalidtarget( target ) )
    {
        return;
    }
    
    self setturrettargetent( target, function_17eec4d2baea6422( target ) - target.origin );
    
    if ( !self.turretspinning )
    {
        function_5ae7345beac4c964();
    }
    
    while ( vehicle_isvalidtarget( target ) && !turret::function_460c373aa20e69b2( self, target, "j_mainroot", 5 ) )
    {
        waitframe();
    }
    
    shootingfails = 0;
    
    while ( numshots > 0 )
    {
        if ( !( isdefined( target ) && isdefined( target.origin ) ) )
        {
            return;
        }
        
        if ( isdefined( self.lastvalidloc ) && vehicle_isvalidtarget( target ) )
        {
            shootingfails = 0;
            self.lastvalidloc = undefined;
            self setturrettargetent( target, function_17eec4d2baea6422( target ) - target.origin );
        }
        else if ( !isdefined( self.lastvalidloc ) && !vehicle_isvalidtarget( target ) )
        {
            shootingfails += 1;
            self.lastvalidloc = function_17eec4d2baea6422( target );
            self setturrettargetvec( self.lastvalidloc );
            
            if ( shootingfails > self.var_7322bd4d06c78eaa )
            {
                return;
            }
        }
        
        self fireweapon();
        numshots--;
        wait firetime;
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x8fdcb42e, Offset: 0x2485
// Size: 0x4d
function empstarted( data )
{
    remotetank::function_e36d934d3670a1f2( 1 );
    function_5bc796a0467c0aa5();
    self.emp = 1;
    self notify( #"hash_261901a44421d4b" );
    
    if ( isdefined( self.onemphit ) )
    {
        self [[ self.onemphit ]]();
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x4faa2e04, Offset: 0x24da
// Size: 0x3f
function empcleared( isdeath )
{
    remotetank::function_e36d934d3670a1f2( 0 );
    self.emp = 0;
    function_cbb5b66f9c25d0e6();
    
    if ( isdefined( self.onempend ) )
    {
        self [[ self.onempend ]]();
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x739e4457, Offset: 0x2521
// Size: 0x80
function function_999b5af0894948f1( data )
{
    wheelson = data.victim;
    
    if ( !isdefined( wheelson ) )
    {
        return;
    }
    
    if ( wheelson.ishaywire )
    {
        return;
    }
    
    wheelson.ishaywire = 1;
    wheelson thread function_6607ad137fdc9b8c();
    wheelson setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( wheelson.pathstruct.speed / 3 ) );
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xc118ffbd, Offset: 0x25a9
// Size: 0x64
function function_7b1ef386eda86258( data )
{
    wheelson = data.victim;
    
    if ( !isdefined( wheelson ) )
    {
        return;
    }
    
    wheelson setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( wheelson.pathstruct.speed ) );
    wheelson.ishaywire = 0;
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x49c6913a, Offset: 0x2615
// Size: 0x88
function function_6607ad137fdc9b8c()
{
    level endon( #"game_ended" );
    firetime = randomfloatrange( 0.2, 0.4 );
    childthread function_bbb5daa5216ff574( firetime );
    self.var_6cbcc0e9ac3a8528 = 1;
    
    if ( !isdefined( self.driver ) )
    {
        self.var_d60900a636f6f4c1 = undefined;
        self clearturrettarget();
        self.currentenemy = undefined;
    }
    
    msg = utility::waittill_any_return( "death", "haywire_cleared" );
    self.var_6cbcc0e9ac3a8528 = undefined;
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0x1fa74a43, Offset: 0x26a5
// Size: 0x35
function function_bbb5daa5216ff574( firetime )
{
    self endon( #"death" );
    self endon( #"haywire_cleared" );
    
    while ( true )
    {
        self fireweapon();
        wait firetime;
    }
}

// Namespace dmz_ai_vehicle
// Params 1
// Checksum 0xd69c9bc3, Offset: 0x26e2
// Size: 0xc8
function vehicle_checkstuck( targetloc )
{
    self endon( #"death" );
    self notify( #"hash_4e7c341d14e55604" );
    self endon( #"hash_4e7c341d14e55604" );
    prevloc = self.origin;
    fails = 0;
    
    while ( true )
    {
        wait 1;
        
        if ( self.isemped || self.ishaywire || isdefined( self.var_d60900a636f6f4c1 ) )
        {
            wait 0.25;
            continue;
        }
        
        currentloc = self.origin;
        
        if ( distancesquared( currentloc, prevloc ) < 100 )
        {
            fails += 1;
            
            if ( fails > 3 )
            {
                fails = 0;
                function_cbb5b66f9c25d0e6();
            }
        }
        
        prevloc = currentloc;
    }
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x6c464ded, Offset: 0x27b2
// Size: 0x2ab
function function_441c23149f775d09()
{
    self notify( #"hash_261901a44421d4b" );
    vehicle_ai::go_to_path( [ self.lastvalidorigin ], 10, 1, 1 );
    mindist = 100000000;
    subnode = undefined;
    var_e3f4b4a026c9ad1a = undefined;
    pathindex = undefined;
    
    foreach ( index, node in self.patrolstruct.path )
    {
        dist = distancesquared( node.origin, self.origin );
        
        if ( dist < mindist )
        {
            mindist = dist;
            pathindex = index;
        }
    }
    
    foreach ( index, var_4e1e861c57758380 in self.patrolstruct.secondarynodes )
    {
        foreach ( subindex, var_e1d4e77154be7bf6 in var_4e1e861c57758380 )
        {
            foreach ( var_70ef62f252b56d32, node in var_e1d4e77154be7bf6.path )
            {
                dist = distancesquared( node.origin, self.origin );
                
                if ( dist < mindist )
                {
                    mindist = dist;
                    subnode = subindex;
                    var_e3f4b4a026c9ad1a = var_70ef62f252b56d32;
                    pathindex = index;
                }
            }
        }
    }
    
    self.var_a13bc2fd92782fbf = var_e3f4b4a026c9ad1a;
    self.var_1ff00ec76f9f0c1b = subnode;
    self.var_b1e3416b5ccf2c13 = pathindex;
    self.patrolstruct.index = pathindex;
}

// Namespace dmz_ai_vehicle
// Params 0
// Checksum 0x812f1314, Offset: 0x2a65
// Size: 0x4b
function function_1227aaa45677d3f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"near_goal" );
        self.lastvalidorigin = self.origin;
        wait 0.1;
        thread vehicle_checkstuck( self.goalpoint );
    }
}

// Namespace dmz_ai_vehicle
// Params 14
// Checksum 0xb475cf4a, Offset: 0x2ab8
// Size: 0x1ff
function vehicle_damagecallback( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( isagent( attacker ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) )
    {
        self.lastplayerattacker = attacker;
    }
    
    if ( isdefined( level.vehicles ) && isdefined( level.vehicles.damagecallback ) )
    {
        self [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
    }
    else
    {
        self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname );
    }
    
    if ( self.damagestate == 0 && self.health / self.maxhealth < 0.6 )
    {
        self setscriptablepartstate( "body_damage_light", "on", 0 );
        
        if ( isdefined( self.interact ) )
        {
            self.interact setscriptablepartstate( "body_damage_light", "on", 0 );
        }
        
        self.damagestate = 1;
        return;
    }
    
    if ( self.damagestate == 1 && self.health / self.maxhealth < 0.3 )
    {
        self setscriptablepartstate( "body_damage_medium", "on", 0 );
        
        if ( isdefined( self.interact ) )
        {
            self.interact setscriptablepartstate( "body_damage_light", "off", 0 );
            self.interact setscriptablepartstate( "body_damage_medium", "on", 0 );
        }
        
        self.damagestate = 2;
    }
}

