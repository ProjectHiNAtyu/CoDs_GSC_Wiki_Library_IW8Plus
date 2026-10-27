// scripts\autotests\autotests_utility_player.gsc  (hash_043e578fec661ff6.gscc) (size: 6621 Bytes / 0x19dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30d36aac (819161772)
// size ...... 6621 (0x19dd)
// includes .. 3   (offset: 0x18c9)
// strings ... 11  (offset: 0x18e1)
// dev strs .. 9   (offset: 0x1971)
// exports ... 20  (offset: 0xf25)
// cseg ...... 0x17f + 0xda6 (0xf25)
// imports ... 54  (offset: 0x1245)
// animtree1 . 0   (offset: 0x19dd)
// animtree2 . 0   (offset: 0x19dd)
#using scripts\autotests\autotests;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace autotests_utility_player;

// Namespace autotests_utility_player/testautomation
// Params 0, eflags: 0x20
// Checksum 0x189fb0a3, Offset: 0x19d
// Size: 0x2
function event_handler[testautomation] main()
{
    
}

// Namespace autotests_utility_player
// Params 0
// Checksum 0xef2b4e7e, Offset: 0x1a7
// Size: 0x26
function get_player()
{
    player = get_player_internal();
    assert( isdefined( player ), "<dev string:x24>" );
    return player;
}

// Namespace autotests_utility_player
// Params 0
// Checksum 0xed267de7, Offset: 0x1d6
// Size: 0x107
function get_player_internal()
{
    player = level.player;
    
    if ( !isdefined( player ) && isdefined( level.players ) )
    {
        foreach ( index, level_player in level.players )
        {
            if ( isdefined( level_player ) && !level_player.isbot && !isbot( level_player ) )
            {
                println( "<dev string:xb7>" + level_player.name + "<dev string:xc6>" + index );
                player = level_player;
                break;
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        println( "<dev string:xd1>" );
        player = level.players[ 0 ];
    }
    
    return player;
}

// Namespace autotests_utility_player
// Params 3
// Checksum 0xd860815c, Offset: 0x2e6
// Size: 0x18e
function get_spawn_data( player = get_player(), spawndist = 400, collisioncheck = 0 )
{
    angles = player getplayerangles();
    angles = ( 0, angles[ 1 ], 0 );
    fwd = anglestoforward( angles );
    spawnorigin = player.origin + fwd * spawndist;
    spawnangles = ( 0, angles[ 1 ] + 185, 0 );
    
    if ( collisioncheck )
    {
        contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
        start = player.origin + ( 0, 0, 5 );
        end = start + fwd * spawndist;
        radius = 15;
        height = 70;
        trace = trace::capsule_trace( start, end, radius, height, ( 0, 0, 0 ), player, contents );
        
        if ( trace[ "hittype" ] != "hittype_none" )
        {
            dist = vectordot( trace[ "position" ] - start, fwd );
            spawnorigin = start + fwd * max( dist - radius, 0 );
        }
    }
    
    spawndata = spawnstruct();
    spawndata.origin = spawnorigin;
    spawndata.angles = spawnangles;
    return spawndata;
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0xf18ffdeb, Offset: 0x47d
// Size: 0x38, Type: bool
function function_3cb2e3fce066667a( player )
{
    if ( !player || player.sessionstate != "playing" )
    {
        println( "<dev string:x114>" );
        return false;
    }
    
    return true;
}

// Namespace autotests_utility_player
// Params 2
// Checksum 0xa5ab4e13, Offset: 0x4be
// Size: 0x71
function teleport_forward( player, distance )
{
    if ( !function_3cb2e3fce066667a( player ) )
    {
        return 0;
    }
    
    angles = player getplayerangles();
    angles = ( 0, angles[ 1 ], 0 );
    fwd = anglestoforward( angles );
    origin = player.origin + fwd * distance;
    return player set_player_position( origin );
}

// Namespace autotests_utility_player
// Params 3
// Checksum 0x53d6ae80, Offset: 0x538
// Size: 0xa7, Type: bool
function set_player_location( player_target, distance_to_target, var_e510a6024674b7dc )
{
    if ( !isdefined( player_target ) )
    {
        assert( 0, "<dev string:x15a>" );
        return false;
    }
    
    if ( !function_3cb2e3fce066667a( self ) )
    {
        return false;
    }
    
    if ( !isdefined( distance_to_target ) )
    {
        distance_to_target = 300;
    }
    
    locationdirection = undefined;
    
    if ( isdefined( var_e510a6024674b7dc ) )
    {
        self setorigin( player_target.origin + var_e510a6024674b7dc * distance_to_target );
        return true;
    }
    
    playerangles = self getplayerangles();
    locationdirection = anglestoforward( playerangles );
    self setorigin( player_target.origin - locationdirection * distance_to_target );
    return true;
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0x4958dce3, Offset: 0x5e8
// Size: 0xbc
function set_player_position( origin )
{
    if ( !function_3cb2e3fce066667a( self ) )
    {
        return 0;
    }
    
    self setvelocity( ( 0, 0, 0 ) );
    self setorigin( origin );
    starttime = gettime();
    
    while ( !self isonground() )
    {
        waitframe();
        
        if ( gettime() - starttime > 3000 )
        {
            autotests::function_d84657f448aaeef6( "Teleported player did not land on ground in 3 seconds.", 0, "scripts/autotests/autotests_utility_player.gsc", 149 );
            return;
        }
    }
    
    starttime = gettime();
    
    while ( !( length( self getvelocity() ) < 0.1 ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 2000 )
        {
            autotests::function_d84657f448aaeef6( "Teleported player did not stop moving for 2 seconds.", 0, "scripts/autotests/autotests_utility_player.gsc", 150 );
            return;
        }
    }
    
    wait 0.5;
    return 1;
}

// Namespace autotests_utility_player
// Params 3
// Checksum 0x8914cb71, Offset: 0x6ad
// Size: 0xac
function function_a29ba7836e10842e( aim_target, aim_offset, aim_bone )
{
    if ( !isdefined( aim_target ) )
    {
        assert( 0, "<dev string:x16e>" );
        return;
    }
    
    if ( !isdefined( aim_offset ) )
    {
        aim_offset = ( 0, 0, 0 );
    }
    
    targetorigin = aim_target.origin;
    
    if ( isdefined( aim_bone ) )
    {
        targetorigin = aim_target gettagorigin( aim_bone );
        assert( isdefined( targetorigin ), "<dev string:x188>" + aim_bone + "<dev string:x1ae>" );
    }
    
    targetangles = vectortoangles( targetorigin - self.origin + aim_offset );
    self setplayerangles( targetangles );
}

// Namespace autotests_utility_player
// Params 2
// Checksum 0x55b3c551, Offset: 0x761
// Size: 0x48, Type: bool
function teleport_player( wantedpos, angles = ( 0, 0, 0 ) )
{
    if ( !function_3cb2e3fce066667a( self ) )
    {
        return false;
    }
    
    self setorigin( wantedpos );
    self setplayerangles( angles );
    return true;
}

// Namespace autotests_utility_player
// Params 2
// Checksum 0xcec95a22, Offset: 0x7b2
// Size: 0x67, Type: bool
function function_30be7535f53dd7a1( testbundle, player )
{
    if ( testbundle.var_a8f94423d23cf0c0 )
    {
        testlocation = autotests::get_struct_location( testbundle.var_a8f94423d23cf0c0 );
        
        if ( testlocation )
        {
            player set_player_position( testlocation );
            player setplayerangles( ( 0, 0, 0 ) );
            return true;
        }
    }
    
    return false;
}

// Namespace autotests_utility_player
// Params 4
// Checksum 0xa13947c6, Offset: 0x822
// Size: 0x83
function function_4ebb38ff785f0ed6( weapon, range, mindamage, maxdamage )
{
    damageranges = function_cc6d8e547793427a( weapon );
    
    for ( i = 0; i < damageranges.size ; i++ )
    {
        if ( range < damageranges[ i ] )
        {
            if ( i == 0 )
            {
                return maxdamage;
            }
            
            if ( i == damageranges.size - 1 )
            {
                return mindamage;
            }
            
            return ( maxdamage / ( i + 1 ) );
        }
    }
    
    return mindamage;
}

// Namespace autotests_utility_player
// Params 4
// Checksum 0x98c92ce, Offset: 0x8ae
// Size: 0x260
function function_46f72ef9b143f2f1( killer, victim, max_bursts, use_headshot )
{
    setdvar( @"player_sustainammo", 1 );
    burstduration = 0.5;
    
    if ( !isdefined( max_bursts ) )
    {
        curweapon = killer getcurrentweapon();
        firetime = weaponfiretime( curweapon );
        
        if ( firetime <= 0 )
        {
            throw( "Fire time is 0 so gun cannot fire - " + curweapon.basename );
            return 0;
        }
        
        burstduration = max( burstduration, firetime );
        mindamage = weapongetdamagemin( curweapon );
        maxdamage = weapongetdamagemax( curweapon, 0 );
        
        if ( mindamage == 0 )
        {
            killerrange = distance( killer.origin, victim.origin );
            mindamage = function_4ebb38ff785f0ed6( curweapon, killerrange, mindamage, maxdamage );
        }
        
        burstdamage = mindamage * floor( burstduration / firetime );
        laststandhealth = victim.laststandhealth ?? level.laststandhealth;
        maxarmorhealth = victim.maxarmorhealth ? victim.maxarmorhealth : 0;
        targetdamage = victim.maxhealth + maxarmorhealth + laststandhealth;
        max_bursts = int( ceil( targetdamage / burstdamage ) ) + 1;
    }
    
    victimdied = 0;
    
    for ( i = 0; i < max_bursts ; i++ )
    {
        aimfrom = killer geteye();
        aimpos = use_headshot ? victim geteye() : victim gettagorigin( "j_spine4" );
        targetangles = vectortoangles( aimpos - aimfrom );
        killer setplayerangles( targetangles );
        killer startforcedfire();
        res = victim utility::waittill_any_timeout( burstduration, "death", "last_stand_enter" );
        killer stopforcedfire();
        
        if ( res == "death" )
        {
            victimdied = 1;
            break;
        }
        else if ( res == "last_stand_enter" )
        {
            wait 1;
        }
        
        wait 0.5;
        
        if ( !isalive( victim ) )
        {
            victimdied = 1;
            break;
        }
    }
    
    setdvar( @"player_sustainammo", 0 );
    return victimdied;
}

// Namespace autotests_utility_player
// Params 3
// Checksum 0x7e1031d0, Offset: 0xb17
// Size: 0xba
function function_988b6029b82767d5( killer, victim, finishlaststand )
{
    victimarmorhealth = victim.armorhealth && victim.armorhealth > 0 ? victim.armorhealth : 0;
    var_fae34d766362e13b = victim.health + victimarmorhealth;
    victim dodamage( var_fae34d766362e13b, victim.origin, killer, killer );
    
    if ( finishlaststand && victim.inlaststand )
    {
        wait 1;
        victim dodamage( 150, victim.origin, killer, killer );
        wait 0.5;
    }
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0x2cb3308d, Offset: 0xbd9
// Size: 0x6e
function function_9275480f08b78840( ent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    level endon( #"end_test" );
    self.starting_angles = self.angles;
    
    while ( ent )
    {
        self setplayerangles( vectortoangles( vectornormalize( ent.origin - self.origin ) ) );
        waitframe();
    }
}

// Namespace autotests_utility_player
// Params 0
// Checksum 0x93caed54, Offset: 0xc4f
// Size: 0x21
function reset_player_angles()
{
    self setplayerangles( self.starting_angles ?? ( 0, 0, 0 ) );
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0x8cd492e2, Offset: 0xc78
// Size: 0x1c2
function function_c18463940ac9de4( distance_offset = 50 )
{
    player_origin = self.origin;
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    contents = trace::create_default_contents( 1 );
    ignore = self;
    locations = [ player_origin + forward * distance_offset, player_origin - forward * distance_offset, player_origin + right * distance_offset, player_origin - right * distance_offset, player_origin + 0.707 * ( forward + right ) * distance_offset, player_origin + 0.707 * ( forward - right ) * distance_offset, player_origin + 0.707 * ( right - forward ) * distance_offset, player_origin + 0.707 * ( -1 * forward - right ) * distance_offset ];
    safe_location = undefined;
    
    foreach ( location in locations )
    {
        if ( trace::ray_trace_passed( player_origin, location, ignore, contents ) )
        {
            /#
                line( player_origin, location, ( 0, 1, 0 ), 1, 0, 300 );
                sphere( location, 10, ( 0, 1, 0 ), 0, 300 );
            #/
            
            safe_location = location;
            break;
        }
        
        waitframe();
    }
    
    return safe_location;
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0xbfa35f82, Offset: 0xe43
// Size: 0x77
function player_look_at( position )
{
    var_d0001bcf8f86189b = self geteye();
    dir = position - var_d0001bcf8f86189b;
    angles = vectortoangles( dir );
    pitch = angleclamp180( angles[ 0 ] );
    clamppitch = clamp( pitch, -85, 85 );
    self setplayerangles( ( clamppitch, angles[ 1 ], angles[ 2 ] ) );
}

// Namespace autotests_utility_player
// Params 1
// Checksum 0xa34405c7, Offset: 0xec2
// Size: 0x62
function function_d870458bee177685( dist )
{
    walkable_ground_clearance = 8;
    caststart = self.origin;
    forwardvector = vectornormalize2( anglestoforward( self getplayerangles() ) );
    castend = caststart + forwardvector * dist;
    return trace::player_trace_passed( caststart, castend, undefined, self, undefined, walkable_ground_clearance );
}

