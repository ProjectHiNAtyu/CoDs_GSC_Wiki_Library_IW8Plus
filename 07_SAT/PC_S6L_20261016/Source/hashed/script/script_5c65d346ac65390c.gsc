// script_5c65d346ac65390c  (hash_5c65d346ac65390c.gscc) (size: 13844 Bytes / 0x3614 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x531cbb9c (1394391964)
// size ...... 13844 (0x3614)
// includes .. 14  (offset: 0x326c)
// strings ... 44  (offset: 0x32dc)
// dev strs .. 1   (offset: 0x3608)
// exports ... 24  (offset: 0x2494)
// cseg ...... 0x349 + 0x214b (0x2494)
// imports ... 79  (offset: 0x2854)
// animtree1 . 0   (offset: 0x3614)
// animtree2 . 0   (offset: 0x3614)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_paths;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\outofbounds;
#using scripts\mp\talking_gun;

#namespace namespace_258bbdad74becc8;

// Namespace namespace_258bbdad74becc8
// Params 8
// Checksum 0xcfea1c2c, Offset: 0x367
// Size: 0x137
function chopperexfilinit( timetoarrive, heliheight, waittime, minwaittime, var_2df81429f9b7082f, exitheight, var_1ed40e51b334e0c4, helihealth )
{
    if ( !isdefined( level.chopperexfil ) )
    {
        level.chopperexfil = spawnstruct();
    }
    
    level.chopperexfil.timetoarrive = timetoarrive;
    level.chopperexfil.heliheight = heliheight;
    level.chopperexfil.heliwaittime = waittime;
    level.chopperexfil.heliminwaittime = minwaittime;
    level.chopperexfil.var_2df81429f9b7082f = var_2df81429f9b7082f;
    level.chopperexfil.exitheight = exitheight;
    level.chopperexfil.var_1ed40e51b334e0c4 = var_1ed40e51b334e0c4;
    level.chopperexfil.helihealth = helihealth;
    level.chopperexfil.hoverradius = getdvarfloat( @"scr_chopper_exfil_hover_radius", 2 );
}

// Namespace namespace_258bbdad74becc8
// Params 2
// Checksum 0xf68869d6, Offset: 0x4a6
// Size: 0x41
function function_4f59fb1b4a31f9a1( callbackkey, func )
{
    if ( isdefined( level.chopperexfil ) )
    {
        utility::registersharedfunc( "chopper_exfil", callbackkey, func );
        return;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace namespace_258bbdad74becc8
// Params 2
// Checksum 0x936be49f, Offset: 0x4ef
// Size: 0x48e
function function_649b43835fd02e64( ent, endpos )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isdefined( level.chopperexfil.exfilpaths ) )
    {
        level.chopperexfil.exfilpaths = [];
    }
    
    if ( isent( ent ) && isdefined( level.chopperexfil.exfilpaths[ ent getentitynumber() ] ) )
    {
        return level.chopperexfil.exfilpaths[ ent getentitynumber() ];
    }
    
    targetloc = function_e0e80faabff9107( ent, level.chopperexfil.heliheight, 1 );
    exitvec = targetloc - ent.origin;
    exitvec = vectornormalize( ( exitvec[ 0 ], exitvec[ 1 ], 0 ) );
    exitangles = vectortoangles( exitvec * -1 );
    startstruct = spawnstruct();
    startstruct.angles = ent.angles;
    
    if ( isdefined( ent.info.helitargetorigin ) )
    {
        endpos = ent.info.helitargetorigin;
        startstruct.angles = ent.info.helitargetangles;
    }
    
    startstruct.origin = endpos + ( 0, 0, level.chopperexfil.exitheight );
    startstruct.radius = 500;
    startstruct.speed = 10;
    
    if ( isent( ent ) )
    {
        startstruct.targetname = "exfil" + ent getentitynumber();
    }
    
    startstruct.script_anglevehicle = "1";
    
    if ( ent.info.land )
    {
        startstruct.script_land = "1";
    }
    
    struct1 = function_4638d5ff82689480( startstruct.origin + exitvec * 100 + ( 0, 0, level.chopperexfil.heliheight ), startstruct, startstruct.targetname, 10, 1, ent.angles );
    struct2 = function_4638d5ff82689480( struct1.origin + exitvec * 5000, struct1, startstruct.targetname, 20, 2, exitangles );
    struct3 = function_4638d5ff82689480( struct1.origin + exitvec * 10000, struct2, startstruct.targetname, 85, 3, exitangles );
    
    /#
        if ( getdvarint( @"hash_57fea5b439641c39", 0 ) == 1 )
        {
            level thread debug::drawsphere( startstruct.origin, 64, 25, ( 0, 0, 60 ) );
            level thread debug::drawline( startstruct.origin, anglestoforward( startstruct.angles ) * 100 + startstruct.origin, 25, ( 0, 0, 60 ) );
            level thread debug::drawsphere( struct1.origin, 64, 25, ( 0, 0, 60 ) );
            level thread debug::drawline( struct1.origin, anglestoforward( struct1.angles ) * 100 + struct1.origin, 25, ( 0, 0, 60 ) );
            level thread debug::drawsphere( struct2.origin, 64, 25, ( 0, 0, 60 ) );
            level thread debug::drawline( struct2.origin, anglestoforward( struct2.angles ) * 100 + struct2.origin, 25, ( 0, 0, 60 ) );
            level thread debug::drawsphere( struct3.origin, 64, 25, ( 0, 0, 60 ) );
            level thread debug::drawline( struct3.origin, anglestoforward( struct3.angles ) * 100 + struct3.origin, 25, ( 0, 0, 60 ) );
        }
    #/
    
    if ( isent( ent ) )
    {
        level.chopperexfil.exfilpaths[ ent getentitynumber() ] = struct3;
    }
    
    return struct3;
}

// Namespace namespace_258bbdad74becc8
// Params 5
// Checksum 0xba2d12ff, Offset: 0x986
// Size: 0x258
function function_e49a3b32812fb5f4( ent, endpos, var_a96e3e3be6870be9, angleoverride, overridestartangles )
{
    if ( angleoverride )
    {
        toorigin = ent.origin - level.radiation.origin;
        toangles = vectortoangles( toorigin );
        targetloc = function_e0e80faabff9107( ent, var_a96e3e3be6870be9, 0, toangles[ 1 ] );
    }
    else
    {
        targetloc = function_e0e80faabff9107( ent, var_a96e3e3be6870be9, 0 );
    }
    
    exitvec = targetloc - endpos;
    exitvec = vectornormalize( ( exitvec[ 0 ], exitvec[ 1 ], 0 ) );
    exitangles = vectortoangles( exitvec );
    startstruct = spawnstruct();
    startstruct.origin = targetloc;
    startstruct.angles = ent.angles;
    startstruct.radius = 500;
    startstruct.speed = 80;
    
    if ( isent( ent ) )
    {
        startstruct.targetname = "exfilExit" + ent getentitynumber();
    }
    
    s3pos = endpos + ( 0, 0, 900 );
    s2pos = s3pos + ( 0, 0, var_a96e3e3be6870be9 );
    startangles = overridestartangles ?? ent.angles;
    struct0 = function_4638d5ff82689480( s2pos + exitvec * 9000 + ( 0, 0, 9000 ), startstruct, startstruct.targetname, 40, 1, exitangles );
    struct1 = function_4638d5ff82689480( s2pos + exitvec * 5000, struct0, startstruct.targetname, 20, 2, exitangles );
    struct2 = function_4638d5ff82689480( s2pos, struct1, startstruct.targetname, 40, 3, exitangles );
    struct3 = function_4638d5ff82689480( s2pos - ( 0, 0, 300 ), struct2, startstruct.targetname, 10, 4, startangles );
    struct4 = function_4638d5ff82689480( s3pos, struct3, startstruct.targetname, 10, 5, startangles );
    return struct4;
}

// Namespace namespace_258bbdad74becc8
// Params 4
// Checksum 0xc860e5ea, Offset: 0xbe7
// Size: 0x17d
function function_e0e80faabff9107( startnode, heliheight, reverse = 0, angleoverride )
{
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    startpos = startnode.origin + ( 0, 0, heliheight + 600 );
    yaw = angleoverride ?? startnode.angles[ 1 ];
    var_18397e93d9334888 = reverse ? yaw + 180 : yaw;
    ignoreents = undefined;
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.instances ) )
    {
        ignoreents = level.vehicle.instances[ "little_bird" ];
    }
    
    yaw = 0;
    
    while ( yaw < 360 )
    {
        var_18397e93d9334888 += yaw;
        testangles = ( 0, var_18397e93d9334888, 0 );
        approachstartpos = startpos;
        approachendpos = startpos + anglestoforward( testangles ) * 18000;
        approachtrace = trace::sphere_trace( approachstartpos, approachendpos, 100, ignoreents, contents, 1 );
        
        if ( approachtrace[ "fraction" ] == 1 )
        {
            return approachendpos;
        }
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
}

// Namespace namespace_258bbdad74becc8
// Params 6, eflags: 0x4
// Checksum 0xe821b2b7, Offset: 0xd6d
// Size: 0xb1
function private function_4638d5ff82689480( pos, prevstruct, triggername, speed, num, angleoverride )
{
    struct = spawnstruct();
    struct.speed = speed;
    struct.origin = pos;
    struct.angles = angleoverride ?? prevstruct.angles;
    struct.radius = 500;
    struct.target = prevstruct;
    struct.script_anglevehicle = "1";
    return struct;
}

// Namespace namespace_258bbdad74becc8
// Params 6
// Checksum 0xf65d2803, Offset: 0xe27
// Size: 0x287
function function_f99c7d4de23543cb( owner, pos, angles, var_1504349960891da7 = 1, var_da4f9c50ac9d819e = 0, skinoverride )
{
    spawndata = spawnstruct();
    spawndata.origin = pos;
    spawndata.angles = angles;
    spawndata.spawntype = "GAME_MODE";
    
    if ( isdefined( skinoverride ) )
    {
        spawndata.var_305ce2bb6ec0993d = skinoverride;
    }
    else if ( !var_1504349960891da7 )
    {
        spawndata.var_305ce2bb6ec0993d = "dmzwhite";
    }
    
    if ( level.var_fe81e50a55227f3b )
    {
        spawndata.team = "axis";
        spawndata.var_4ae4f42e05dc7b41 = "v013";
    }
    
    heli = undefined;
    
    while ( !isdefined( heli ) )
    {
        heli = vehicle::spawn( "veh9_palfa", spawndata );
        
        if ( !isdefined( heli ) )
        {
            wait 1;
        }
    }
    
    vehicle_interact::allow_use( heli, 0 );
    heli.var_c82fdb1998fb5a8e = 1;
    heli.health = level.chopperexfil.helihealth ?? 1000;
    heli.maxhealth = heli.health;
    heli.var_77f46a6090b89414 = [];
    heli.var_80c58b306173b9c3 = level.chopperexfil.heliwaittime + level.chopperexfil.heliminwaittime;
    
    if ( var_1504349960891da7 )
    {
        heli.callingteam = owner.team;
    }
    
    heli.playersinside = [];
    heli.onStartRiding = &function_b7cb36b773322731;
    heli.onEndRiding = &function_8e7c9988bc8fa48b;
    heli.var_c5fccc442ca4af5 = 1;
    heli.unload_land_offset = 255;
    heli.script_disconnectpaths = 1;
    heli.var_b1e7f946abc78a83 = 10000;
    heli.handleeventcallback = &function_cef0207ffe5d3699;
    heli.exfilhelicopter = 1;
    heli function_7b10c9a50eb9dcb();
    heli function_d2b8ee2e1275daaf( 1 );
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "setup_gas_masks" ) )
    {
        [[ utility::getsharedfunc( "chopper_exfil", "setup_gas_masks" ) ]]( heli );
    }
    
    return heli;
}

// Namespace namespace_258bbdad74becc8
// Params 0, eflags: 0x4
// Checksum 0x3b0b1235, Offset: 0x10b7
// Size: 0xbf
function private function_7b10c9a50eb9dcb()
{
    drivermodels = [ "body_sp_ally_pilot_western_vm_fullbody", "body_sp_ally_pilot_western_vm_fullbody" ];
    driveranims = [ "iw9_mp_heli_palfa_seat_0_idle", "iw9_heli_palfa_seat_1_idle" ];
    drivertags = [ "tag_seat_0", "tag_seat_1" ];
    pilot_num = 2;
    self.pilots = [];
    
    for ( i = 0; i < pilot_num ; i++ )
    {
        fake_guy = function_4144ee35258626af( i, drivertags[ i ], driveranims[ i ], drivermodels[ i ], undefined );
        self.pilots[ self.pilots.size ] = fake_guy;
    }
}

// Namespace namespace_258bbdad74becc8
// Params 5, eflags: 0x4
// Checksum 0xaa43a88a, Offset: 0x117e
// Size: 0x125
function private function_4144ee35258626af( posindex, tag, animname, model, headmodel )
{
    spawnorg = self gettagorigin( tag );
    spawnang = self gettagangles( tag );
    spawned = spawn( "script_model", spawnorg );
    spawned.angles = spawnang;
    spawned setmodel( model );
    spawnorg = spawned gettagorigin( "j_spine4" );
    spawnang = spawned gettagangles( "j_spine4" );
    spawned.linkedents = [];
    
    if ( isdefined( headmodel ) )
    {
        head = spawn( "script_model", spawnorg );
        head.angles = spawnang;
        head setmodel( headmodel );
        head linkto( spawned, "j_spine4" );
        spawned.linkedents[ spawned.linkedents.size ] = head;
        spawned.head = head;
    }
    
    spawned linkto( self );
    
    if ( isdefined( animname ) )
    {
        spawned scriptmodelplayanim( animname );
    }
    
    return spawned;
}

// Namespace namespace_258bbdad74becc8
// Params 0
// Checksum 0xdbf796ea, Offset: 0x12ac
// Size: 0x18
function function_a8c95d76ce77978a()
{
    if ( self.var_865e05e9fa3040f9 )
    {
        self.var_865e05e9fa3040f9 = undefined;
    }
}

// Namespace namespace_258bbdad74becc8
// Params 1
// Checksum 0x9db47a2d, Offset: 0x12cc
// Size: 0x30e
function function_b7cb36b773322731( player )
{
    if ( !isdefined( self.playersinside[ player.guid ] ) )
    {
        self.playersinside[ player.guid ] = player;
        outofbounds::enableoobimmunity( player );
        
        if ( !self.timerstarted || self.var_80c58b306173b9c3 < 1 )
        {
            return;
        }
        
        if ( !isdefined( player.var_865e05e9fa3040f9 ) )
        {
            self.var_77f46a6090b89414[ self.var_77f46a6090b89414.size ] = player;
            player.var_865e05e9fa3040f9 = 1;
            displaytime = self.var_80c58b306173b9c3 + level.chopperexfil.heliminwaittime;
            
            if ( self.minwaittimer < level.chopperexfil.heliminwaittime )
            {
                displaytime = self.minwaittimer;
            }
            
            if ( utility::issharedfuncdefined( "chopper_exfil", "player_exfil_timer" ) )
            {
                player thread [[ utility::getsharedfunc( "chopper_exfil", "player_exfil_timer" ) ]]( self, displaytime, 2000 );
            }
        }
        
        talking_gun::talkinggun_event( player, #"enter_exfil_heli" );
    }
    
    if ( player.team == self.callingteam )
    {
        if ( self.minwaittimer < level.chopperexfil.heliminwaittime )
        {
            return;
        }
        
        players = teams::getteamdata( self.callingteam, "players" );
        
        foreach ( teammember in players )
        {
            if ( player::isreallyalive( teammember ) && !isdefined( self.playersinside[ teammember.guid ] ) && !teammember.extracted )
            {
                return;
            }
        }
        
        foreach ( player in self.var_77f46a6090b89414 )
        {
            if ( player.var_865e05e9fa3040f9 )
            {
                if ( utility::issharedfuncdefined( "chopper_exfil", "player_exfil_timer" ) )
                {
                    player thread [[ utility::getsharedfunc( "chopper_exfil", "player_exfil_timer" ) ]]( self, level.chopperexfil.heliminwaittime, 2000 );
                }
            }
        }
    }
    else
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "dialog_shortcut" ) )
    {
        player thread [[ utility::getsharedfunc( "chopper_exfil", "dialog_shortcut" ) ]]();
    }
    
    self notify( #"hash_cddafeb76ce64679" );
}

// Namespace namespace_258bbdad74becc8
// Params 1
// Checksum 0x95cf5d4e, Offset: 0x15e2
// Size: 0x6b
function function_8e7c9988bc8fa48b( player )
{
    self.playersinside[ player.guid ] = undefined;
    player notify( #"exited_chopper" );
    player.var_df24ac934fd98227 = undefined;
    
    if ( isdefined( player ) && isint( player.oobimmunity ) && !player.extracted )
    {
        outofbounds::disableoobimmunity( player );
    }
}

// Namespace namespace_258bbdad74becc8
// Params 3
// Checksum 0x63b49356, Offset: 0x1655
// Size: 0x10c
function function_4601be2c290ec75d( heli, endpoint, ent )
{
    heli endon( #"death" );
    
    if ( isdefined( ent ) )
    {
        ent endon( #"disable" );
    }
    
    while ( distance( heli.origin, endpoint ) > 2500 )
    {
        wait 0.1;
    }
    
    heli setscriptablepartstate( "dmz_exfil_dust_sounds", "landing" );
    
    while ( distance( heli.origin, endpoint ) > 1500 )
    {
        wait 0.1;
    }
    
    if ( isdefined( ent ) )
    {
        ent setscriptablepartstate( "dmz_exfil_smoke", "dissipate" );
    }
    
    heli function_d2b8ee2e1275daaf( 0 );
    
    while ( distance( heli.origin, endpoint ) > 800 )
    {
        wait 0.1;
    }
    
    heli setscriptablepartstate( "dmz_exfil_turbine_sounds", "landing" );
    
    while ( distance( heli.origin, endpoint ) < 1500 )
    {
        wait 0.1;
    }
    
    heli function_d2b8ee2e1275daaf( 1 );
}

// Namespace namespace_258bbdad74becc8
// Params 2
// Checksum 0xe05bfe5b, Offset: 0x1769
// Size: 0x60
function function_498203f6a468b68a( heli, endpoint )
{
    heli endon( #"death" );
    
    while ( distance2d( heli.origin, endpoint ) > 500 )
    {
        wait 0.1;
    }
    
    if ( isdefined( self ) )
    {
        calloutmarkerping::function_9bd4bf4f8fe74b16( self, heli, undefined, ( 0, 0, 72 ) );
    }
}

// Namespace namespace_258bbdad74becc8
// Params 1
// Checksum 0xaa45b69f, Offset: 0x17d1
// Size: 0x212
function function_1dc7f533bf07d9e3( waittime )
{
    self endon( #"hash_cddafeb76ce64679" );
    self.timerstarted = 1;
    exfiltimer = int( waittime );
    players = level.players;
    
    if ( isdefined( self.callingteam ) )
    {
        players = teams::getteamdata( self.callingteam, "players" );
    }
    
    if ( self.playersinside.size > 0 )
    {
        players = arraycombine( players, self.playersinside );
    }
    
    foreach ( member in players )
    {
        if ( !isdefined( member.var_865e05e9fa3040f9 ) && player::isreallyalive( member ) )
        {
            self.var_77f46a6090b89414[ self.var_77f46a6090b89414.size ] = member;
            member.var_865e05e9fa3040f9 = 1;
            
            if ( utility::issharedfuncdefined( "chopper_exfil", "player_exfil_timer" ) )
            {
                member thread [[ utility::getsharedfunc( "chopper_exfil", "player_exfil_timer" ) ]]( self, exfiltimer + level.chopperexfil.heliminwaittime, undefined );
            }
        }
    }
    
    self.var_80c58b306173b9c3 = exfiltimer;
    self.minwaittimer = level.chopperexfil.heliminwaittime;
    
    while ( self.var_80c58b306173b9c3 > 0 )
    {
        self.var_80c58b306173b9c3--;
        
        if ( !isdefined( self.callingteam ) && self.var_80c58b306173b9c3 == 60 - level.chopperexfil.heliminwaittime )
        {
            if ( utility::issharedfuncdefined( "chopper_exfil", "dialog_final_warning" ) )
            {
                [[ utility::getsharedfunc( "chopper_exfil", "dialog_final_warning" ) ]]( players );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_258bbdad74becc8
// Params 1
// Checksum 0x272774b0, Offset: 0x19eb
// Size: 0x6d
function function_ade4ac55a191b81a( heli )
{
    heli setscriptablepartstate( "dmz_exfil_dust_sounds", "landing" );
    
    if ( !isdefined( heli.minwaittimer ) )
    {
        heli.minwaittimer = level.chopperexfil.heliminwaittime;
    }
    
    heli function_511a32c92d5c38a();
    heli function_af69758cc1957e97();
    heli setscriptablepartstate( "dmz_exfil_dust_sounds", "liftoff" );
}

// Namespace namespace_258bbdad74becc8
// Params 0
// Checksum 0xd7389334, Offset: 0x1a60
// Size: 0x22
function function_511a32c92d5c38a()
{
    wait self.minwaittimer * 0.75;
    self setscriptablepartstate( "dmz_exfil_turbine_sounds", "liftoff" );
}

// Namespace namespace_258bbdad74becc8
// Params 0
// Checksum 0x1c8c9f04, Offset: 0x1a8a
// Size: 0x20
function function_af69758cc1957e97()
{
    while ( self.minwaittimer > 0 )
    {
        self.minwaittimer--;
        wait 1;
    }
}

// Namespace namespace_258bbdad74becc8
// Params 0
// Checksum 0x524bf1f, Offset: 0x1ab2
// Size: 0x105
function function_a9fcff0fe86e7ff0()
{
    if ( isdefined( self.pilots ) )
    {
        foreach ( pilot in self.pilots )
        {
            foreach ( ent in pilot.linkedents )
            {
                ent delete();
            }
            
            pilot delete();
        }
    }
    
    vehicle::death( self );
}

// Namespace namespace_258bbdad74becc8
// Params 8
// Checksum 0xdfd9dda5, Offset: 0x1bbf
// Size: 0x7c4
function chopperexfilactivated( ent, part, state, player, waittime, var_1504349960891da7 = 1, finalexfil, skinoverride )
{
    if ( !isdefined( ent ) || ent.disabled )
    {
        return;
    }
    
    if ( isdefined( ent.heli ) )
    {
        if ( utility::issharedfuncdefined( "chopper_exfil", "airspace_too_crowded" ) )
        {
            [[ utility::getsharedfunc( "chopper_exfil", "airspace_too_crowded" ) ]]( player );
            return;
        }
    }
    
    playersleft = 0;
    groundorg = getgroundposition( ent.origin, 1 ) + ( 0, 0, 2 );
    ent.inuse = 1;
    players = level.players;
    team = undefined;
    
    if ( !finalexfil )
    {
        team = player.team;
        players = teams::getteamdata( player.team, "players" );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"match_exfil_inbound", players );
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "initial_splash" ) )
    {
        [[ utility::getsharedfunc( "chopper_exfil", "initial_splash" ) ]]( players, ent.info.script_poi, istrue( finalexfil ) );
    }
    
    br_contract_manager::utilflare_shootflare( ent.origin, "dmz_exfil" );
    wait 3.75;
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "music_start" ) )
    {
        [[ utility::getsharedfunc( "chopper_exfil", "music_start" ) ]]( players, finalexfil );
    }
    
    wait 1.25;
    waittimer = level.chopperexfil.timetoarrive;
    
    if ( isdefined( player ) && !finalexfil )
    {
        upgradecount = utility::callsharedfunc( #"instanceInventory", #"getupgradecount", player, 27 ) ?? 0;
        waittimer -= upgradecount * getdvarfloat( @"hash_32085370522fbf3f", 30 );
        waittimer = max( 0, waittimer );
    }
    
    if ( !isdefined( waittimer ) )
    {
        waittimer = 60;
    }
    
    if ( game_utility::getgametype() == "dmz" && isdefined( level.var_9e5d1779e30d44c1 ) && finalexfil )
    {
        remainingtime = ( level.var_9e5d1779e30d44c1 - gettime() ) / 1000;
        
        if ( remainingtime > waittimer * 2 )
        {
            thread utility::callsharedfunc( "chopper_exfil", "dialog_start_exfil", players, team, finalexfil, ent, waittimer );
            wait waittimer;
        }
    }
    else
    {
        if ( utility::issharedfuncdefined( "chopper_exfil", "dialog_start_exfil" ) )
        {
            thread [[ utility::getsharedfunc( "chopper_exfil", "dialog_start_exfil" ) ]]( players, team, finalexfil, ent, waittimer );
        }
        
        wait waittimer;
    }
    
    path = function_649b43835fd02e64( ent, groundorg );
    
    if ( !isdefined( path ) )
    {
        return;
    }
    
    ownerplayer = player;
    
    for ( i = 0; i < players.size && !isdefined( ownerplayer ) ; i++ )
    {
        ownerplayer = players[ i ];
    }
    
    if ( !isdefined( ownerplayer ) )
    {
        return;
    }
    
    heli = function_f99c7d4de23543cb( ownerplayer, path.origin, ent.angles, var_1504349960891da7, finalexfil, skinoverride );
    heli.finalexfil = finalexfil;
    thread function_4601be2c290ec75d( heli, groundorg, ent );
    ent thread function_498203f6a468b68a( heli, groundorg );
    heli vehicle_paths::vehicle_paths_helicopter( path );
    
    if ( !ent.info.land )
    {
        heli sethoverparams( level.chopperexfil.hoverradius ?? 2, 1, 1 );
    }
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "dialog_handle_touchdown" ) )
    {
        thread [[ utility::getsharedfunc( "chopper_exfil", "dialog_handle_touchdown" ) ]]( players, heli );
    }
    
    if ( !var_1504349960891da7 && isdefined( level.chopperexfil.var_2df81429f9b7082f ) )
    {
        waittime = ( level.chopperexfil.var_2df81429f9b7082f - gettime() ) / 1000 - level.chopperexfil.minwaittimer - level.chopperexfil.var_1ed40e51b334e0c4;
    }
    
    if ( game_utility::getgametype() == "dmz" && isdefined( level.var_9e5d1779e30d44c1 ) && finalexfil )
    {
        remainingtime = ( level.var_9e5d1779e30d44c1 - gettime() ) / 1000;
        waittime = remainingtime - level.chopperexfil.heliminwaittime - 1;
        var_6c34539e9cd7b812 = round( remainingtime % 1, level.framedurationseconds );
        
        if ( var_6c34539e9cd7b812 >= level.framedurationseconds )
        {
            waittime -= var_6c34539e9cd7b812;
            wait var_6c34539e9cd7b812;
        }
    }
    
    heli function_1dc7f533bf07d9e3( waittime ?? level.chopperexfil.heliwaittime );
    function_ade4ac55a191b81a( heli );
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "music_stop" ) )
    {
        thread [[ utility::getsharedfunc( "chopper_exfil", "music_stop" ) ]]( heli.playersinside, finalexfil );
    }
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "dialog_final_leaving" ) )
    {
        thread [[ utility::getsharedfunc( "chopper_exfil", "dialog_final_leaving" ) ]]( players, finalexfil );
    }
    
    heli.exfilpathstarted = 1;
    path = function_e49a3b32812fb5f4( ent, groundorg, level.chopperexfil.heliheight, !var_1504349960891da7 );
    heli thread vehicle_paths::vehicle_paths_helicopter( path );
    wait 10;
    calloutmarkerping::function_ab4e5514677fba94( ent );
    wait 1.5;
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "music_exfil_end" ) )
    {
        thread [[ utility::getsharedfunc( "chopper_exfil", "music_exfil_end" ) ]]( heli.playersinside );
    }
    
    wait 6.5;
    heli.playersexfil = [];
    
    foreach ( player in heli.playersinside )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isbrgamemode() )
        {
            player br_public::function_4b66f0c3d7997b1a( 1 );
        }
        
        heli.playersexfil[ heli.playersexfil.size ] = player;
        playersleft = 1;
    }
    
    info = function_2656673ab5dbdb77( heli.playersexfil, finalexfil, 0, istrue( ent.info.personal ), 0 );
    info.exfilseq = ent.exfilseq;
    utility::callsharedfunc( "chopper_exfil", "exfil_players", heli.playersexfil, info );
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "music_reset" ) )
    {
        [[ utility::getsharedfunc( "chopper_exfil", "music_reset" ) ]]( players );
    }
    
    wait 15;
    heli function_a9fcff0fe86e7ff0();
    
    if ( utility::issharedfuncdefined( "chopper_exfil", "remove_exfil" ) )
    {
        ent thread [[ utility::getsharedfunc( "chopper_exfil", "remove_exfil" ) ]]( ent, playersleft );
    }
    
    if ( isdefined( ent ) && isdefined( team ) && !ent.disabled )
    {
        ent.inuse = 0;
        
        if ( utility::issharedfuncdefined( "chopper_exfil", "reset_exfil" ) )
        {
            ent thread [[ utility::getsharedfunc( "chopper_exfil", "reset_exfil" ) ]]( team );
        }
    }
}

// Namespace namespace_258bbdad74becc8
// Params 5
// Checksum 0x643fc338, Offset: 0x238b
// Size: 0x88
function function_2656673ab5dbdb77( players, finalexfil, hostageexfil, personalexfil, drivableexfil )
{
    info = spawnstruct();
    info.players = players;
    info.finalexfil = finalexfil;
    info.hostageexfil = hostageexfil;
    info.personalexfil = personalexfil;
    info.drivableexfil = drivableexfil;
    return info;
}

// Namespace namespace_258bbdad74becc8
// Params 0
// Checksum 0x10383682, Offset: 0x241c
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace namespace_258bbdad74becc8
// Params 1, eflags: 0x4
// Checksum 0x8728a203, Offset: 0x2449
// Size: 0x4b
function private function_cef0207ffe5d3699( vehicle )
{
    if ( self vehicle_getspeed() == 0 )
    {
        return;
    }
    
    if ( vehicle.chopperexfilhit )
    {
        return;
    }
    
    vehicle.chopperexfilhit = 1;
    vehicle.dontspawnhusk = 1;
    vehicle thread vehicle::explode();
}

