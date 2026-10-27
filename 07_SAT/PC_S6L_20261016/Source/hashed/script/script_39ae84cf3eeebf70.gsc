// script_39ae84cf3eeebf70  (hash_39ae84cf3eeebf70.gscc) (size: 7497 Bytes / 0x1d49 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa18eac8 (169405128)
// size ...... 7497 (0x1d49)
// includes .. 4   (offset: 0x1bed)
// strings ... 24  (offset: 0x1c0d)
// dev strs .. 1   (offset: 0x1d3d)
// exports ... 13  (offset: 0x1225)
// cseg ...... 0x247 + 0xfde (0x1225)
// imports ... 66  (offset: 0x142d)
// animtree1 . 0   (offset: 0x1d49)
// animtree2 . 0   (offset: 0x1d49)
#using scripts\common\trace;
#using scripts\mp\common\utility\game;
#using scripts\mp\gametypes\escort_horde_abilities;
#using scripts\mp\hud_util;

#namespace namespace_168457380d58ba54;

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x8a55da1b, Offset: 0x265
// Size: 0xa1
function function_df64aacc56a216e9()
{
    escort_horde_abilities::addpowerbutton( level.mutationgametype.zombie, "jump", [ "+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible" ], &playerzombiejump, 0, undefined, &playerzombiejumpcleanup, undefined, &"mp_zxp/charged_jump", undefined, 6, "jumpStatus", "jumpProgress" );
    escort_horde_abilities::addpowerbutton( level.mutationgametype.zombie, "jumpStop", [ "-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible" ], &playerzombiejumpstop, 0 );
}

// Namespace namespace_168457380d58ba54
// Params 2
// Checksum 0x2b7a6442, Offset: 0x30e
// Size: 0x31d
function playerzombiejump( powerstruct, powerref )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"hash_b05e9bc67fd87802" );
    var_c94e8329c2d87e2c = -1;
    self.var_48eff98c29fa8dc7 = undefined;
    var_3dee97d313b257a2 = getdvarfloat( @"hash_2fc6c2dc7f9c722a", 1 );
    var_d6176c3e286314b5 = getdvarfloat( @"hash_f3adfe2ba0c4e72e", 0.25 );
    var_2f81976b1022304c = getdvarint( @"hash_69111e35067f9d8f", var_c94e8329c2d87e2c );
    var_c1cdd62e11b7d616 = var_3dee97d313b257a2 * level.framedurationseconds;
    self.jumpfraction = 0;
    self allowmelee( 0 );
    self disableoffhandweapons();
    var_99f0d49aff00fc07 = undefined;
    progress = 0;
    
    if ( !isdefined( self.var_4026b2b0e0c125b3 ) || gettime() > self.var_4026b2b0e0c125b3 )
    {
        self.var_4026b2b0e0c125b3 = gettime() + 500;
    }
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 0 );
    }
    
    while ( !function_527862dcf2382913() )
    {
        if ( level.mutationgametype.hudserver )
        {
            self.powershud[ powerref ].barelem hud_util::updatebar( self.jumpfraction, 0 );
        }
        else
        {
            self.powershud[ powerref ].frac = self.jumpfraction;
        }
        
        prevfrac = self.jumpfraction;
        self.jumpfraction += var_c1cdd62e11b7d616;
        
        if ( self.jumpfraction >= 1 )
        {
            self.jumpfraction = 1;
            
            if ( var_2f81976b1022304c >= 0 )
            {
                if ( !isdefined( var_99f0d49aff00fc07 ) )
                {
                    var_99f0d49aff00fc07 = gettime() + var_2f81976b1022304c * 1000;
                }
                
                if ( gettime() >= var_99f0d49aff00fc07 )
                {
                    break;
                }
            }
        }
        
        if ( level.mutationgametype.hudserver && prevfrac < var_d6176c3e286314b5 && self.jumpfraction >= var_d6176c3e286314b5 )
        {
            self.powershud[ powerref ].barelem.bar.color = ( 0, 1, 0 );
        }
        
        if ( prevfrac < 1 && self.jumpfraction >= 1 )
        {
        }
        
        if ( isdefined( powerstruct.powers[ powerref ].progressupdate ) )
        {
            progress = maxint( int( self.jumpfraction * 100 ), 0 );
            escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].progressupdate, progress );
        }
        
        waitframe();
    }
    
    thread function_ec2d67cad8fca82( powerstruct, powerref );
}

// Namespace namespace_168457380d58ba54
// Params 3
// Checksum 0x431c0fab, Offset: 0x633
// Size: 0x41
function playerzombiejumpcleanup( powerstruct, powerref, docooldown )
{
    if ( docooldown )
    {
        thread escort_horde_abilities::playerpowerstartcooldown( powerstruct, powerref );
    }
    
    self.var_6b2acdf404a4c7c2 = undefined;
    self.jumpfraction = undefined;
}

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x86320391, Offset: 0x67c
// Size: 0xa8, Type: bool
function function_527862dcf2382913()
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !zombie game_utility_mp::ismutationgamemodezombie() )
    {
        return true;
    }
    
    if ( zombie meleebuttonpressed() || zombie attackbuttonpressed() )
    {
        zombie.var_6b2acdf404a4c7c2 = 1;
        return true;
    }
    
    if ( zombie getstance() == "prone" )
    {
        zombie.var_48eff98c29fa8dc7 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_PRONE";
        return true;
    }
    
    if ( zombie isswimunderwater() )
    {
        zombie.var_48eff98c29fa8dc7 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_UNDERWATER";
        return true;
    }
    
    if ( zombie ishanging() )
    {
        zombie.var_48eff98c29fa8dc7 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_HANGING";
        return true;
    }
    
    return false;
}

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x856d6acb, Offset: 0x72d
// Size: 0x10b, Type: bool
function function_a25bd3f73acabb1e()
{
    if ( level.mutationgametype.var_ce078b9803c2e17c != 0 )
    {
        end = self.origin + ( 0, 0, level.mutationgametype.var_ce078b9803c2e17c );
        result = playerphysicstrace( self.origin, end );
        
        if ( result != end )
        {
            return false;
        }
    }
    
    if ( level.mutationgametype.var_ce078e9803c2e815 != 0 )
    {
        start = self geteye();
        end = start + ( 0, 0, level.mutationgametype.var_ce078e9803c2e815 );
        radius = 10;
        height = 20;
        contents = trace::create_contents( 0, 1, 0, 1, 0, 0, 1 );
        result = trace::capsule_trace( start, end, radius, height, ( 0, 0, 0 ), self, contents );
        
        if ( result[ "fraction" ] != 1 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x1177ceb, Offset: 0x841
// Size: 0xb2
function function_e2c3d5fb10eafa33()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self allowjump( 0 );
    self setscriptablepartstate( "skydiveVfx", "enabled_zombie", 0 );
    wait 0.2;
    self enableoffhandweapons();
    self notify( #"hash_dc912c839c40e708" );
    
    while ( !function_ee4ddb054cefb82() )
    {
        waitframe();
    }
    
    self notify( #"zombie_jump_complete" );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    self playsoundtoplayer( "zxp_splat_plr", self, self );
    self playsound( "zmb_npc_breath_land_hi", self, self );
    self playsound( "zxp_splat_npc", self, self );
    wait 0.2;
    self allowmelee( 1 );
    self allowjump( 1 );
}

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x900f8e04, Offset: 0x8fb
// Size: 0x141
function function_86a4497ad6c126f7()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    var_6270bf80abebca4b = getdvarfloat( @"hash_1df491267fcc6307", 400 );
    
    if ( var_6270bf80abebca4b <= 0 )
    {
        return;
    }
    
    maxspeed = getdvarfloat( @"hash_a60f6bc28d9bc0c6", 1400 );
    wait 0.2;
    
    while ( !function_ee4ddb054cefb82() )
    {
        movementinput = self getnormalizedmovement();
        
        if ( length( movementinput ) > 0 )
        {
            worlddir = rotatevector( ( movementinput[ 0 ], -1 * movementinput[ 1 ], 0 ), self.angles );
            velocity = self getvelocity();
            speed = length( velocity );
            var_24b974ad4db020a6 = worlddir * var_6270bf80abebca4b * level.framedurationseconds;
            newvel = velocity + var_24b974ad4db020a6;
            newspeed = length( newvel );
            
            if ( newspeed <= maxspeed )
            {
                self setvelocity( newvel );
            }
            else if ( speed < maxspeed )
            {
                newvel = vectornormalize( newvel ) * maxspeed;
                self setvelocity( newvel );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_168457380d58ba54
// Params 0
// Checksum 0x90fa72ee, Offset: 0xa44
// Size: 0x22, Type: bool
function function_ee4ddb054cefb82()
{
    return self isonground() || self isonladder() || self ismantling() || self isswimming();
}

// Namespace namespace_168457380d58ba54
// Params 4
// Checksum 0xeb05095f, Offset: 0xa6f
// Size: 0x2b5
function playerapplyjumpvelocity( angledir, maxjumpvelocity, fraction, startoffset )
{
    var_bec4d8001ab9cc86 = 1;
    start_origin_offset = ( 0, 0, 20 );
    
    if ( !isdefined( startoffset ) )
    {
        startoffset = start_origin_offset;
    }
    
    player_angles = angledir;
    ground_normal = ( 0, 0, 1 );
    fwd = ( 1, 0, 0 );
    
    if ( getdvarint( @"hash_ce6d7d66848cdbcc", var_bec4d8001ab9cc86 ) )
    {
        if ( level.mutationgametype.var_47e0aeae104c21b9 )
        {
            ground_normal = get_ground_normal();
            
            if ( !isdefined( ground_normal ) )
            {
                ground_normal = ( 0, 0, 1 );
            }
        }
        
        yawangles = ( 0, player_angles[ 1 ], 0 );
        right = anglestoright( yawangles );
        fwd = vectorcross( ground_normal, right );
        fwd_angles = vectortoangles( fwd );
        ground_pitch = angleclamp180( fwd_angles[ 0 ] );
        min_pitch = -85;
        max_pitch = ground_pitch;
        player_pitch = player_angles[ 0 ];
        
        if ( player_pitch > ground_pitch )
        {
            player_pitch = ground_pitch;
        }
        
        var_d01e318b66fb6024 = getdvarfloat( @"hash_9ec479015407c245", -45 );
        var_cffb3f8b66d53736 = getdvarfloat( @"hash_9ee78301542e1ffb", 0 );
        frac = ( player_pitch - min_pitch ) / ( max_pitch - min_pitch );
        pitch_correction = var_cffb3f8b66d53736 + frac * ( var_d01e318b66fb6024 - var_cffb3f8b66d53736 );
        player_angles = ( player_pitch + pitch_correction, player_angles[ 1 ], player_angles[ 2 ] );
    }
    
    pitch_add = getdvarfloat( @"hash_cf56037c34ea141f", 0 );
    
    if ( pitch_add != 0 )
    {
        player_angles = ( player_angles[ 0 ] + pitch_add, player_angles[ 1 ], player_angles[ 2 ] );
    }
    
    dir = anglestoforward( player_angles );
    velocity = dir * fraction * maxjumpvelocity;
    velocity = ( velocity[ 0 ], velocity[ 1 ], 450 );
    startorg = self.origin + startoffset;
    self setorigin( startorg, 0 );
    self setvelocity( velocity );
    glassradiusdamage( self.origin + ( 0, 0, 30 ), 30, 50, 51 );
    fwddir = anglestoforward( self.angles );
    radorg = self.origin + ( 0, 0, 30 ) + fwddir * 15;
    radiusdamage( radorg, 100, 1, 1 );
}

// Namespace namespace_168457380d58ba54
// Params 2
// Checksum 0xa67c9920, Offset: 0xd2c
// Size: 0x290
function get_ground_normal( traceignore, debug )
{
    if ( !isdefined( traceignore ) )
    {
        ignore = self;
    }
    else
    {
        ignore = traceignore;
    }
    
    if ( !isdefined( debug ) )
    {
        debug = 0;
    }
    
    ignorelist = [ ignore ];
    tracepoints = [ self.origin ];
    i = -1;
    
    while ( i <= 1 )
    {
        j = -1;
        
        while ( j <= 1 )
        {
            corner = ignore getpointinbounds( i, j, 0 );
            corner = ( corner[ 0 ], corner[ 1 ], self.origin[ 2 ] );
            tracepoints[ tracepoints.size ] = corner;
            j += 2;
        }
        
        i += 2;
    }
    
    avgnormal = ( 0, 0, 0 );
    tracehitcount = 0;
    
    foreach ( point in tracepoints )
    {
        trace = trace::_bullet_trace( point + ( 0, 0, 4 ), point + ( 0, 0, -16 ), 0, ignorelist );
        tracehit = trace[ "fraction" ] > 0 && trace[ "fraction" ] < 1;
        
        if ( tracehit )
        {
            avgnormal += trace[ "normal" ];
            tracehitcount++;
        }
        
        /#
            if ( debug )
            {
                if ( tracehit )
                {
                    line( point, point + trace[ "<dev string:x24>" ] * 30, ( 0, 1, 0 ) );
                    continue;
                }
                
                sphere( point, 3, ( 1, 0, 0 ) );
            }
        #/
    }
    
    if ( tracehitcount > 0 )
    {
        avgnormal /= tracehitcount;
        
        /#
            if ( debug )
            {
                line( self.origin, self.origin + avgnormal * 20, ( 1, 1, 1 ) );
            }
        #/
        
        return avgnormal;
    }
    
    /#
        if ( debug )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ) );
        }
    #/
    
    return;
}

// Namespace namespace_168457380d58ba54
// Params 2
// Checksum 0x5885f186, Offset: 0xfc4
// Size: 0x58
function playerzombiejumpstop( powerstruct, powerref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waittillframeend();
    
    if ( isdefined( self.jumpfraction ) )
    {
        function_ec2d67cad8fca82( powerstruct, "jump" );
        return;
    }
    
    self notify( #"hash_b05e9bc67fd87802" );
}

// Namespace namespace_168457380d58ba54
// Params 2
// Checksum 0xe9fe26fd, Offset: 0x1024
// Size: 0x201
function function_ec2d67cad8fca82( powerstruct, powerref )
{
    self notify( #"hash_981fd44de1563927" );
    self notify( #"hash_b05e9bc67fd87802" );
    var_d6176c3e286314b5 = getdvarfloat( @"hash_f3adfe2ba0c4e72e", 0.25 );
    var_c4f2c4e3a29aab48 = getdvarint( @"hash_2a5201ccbcd3b1a1", 1 );
    var_45a7b02b25a7d1db = 1;
    
    if ( self.jumpfraction >= var_d6176c3e286314b5 && !function_527862dcf2382913() && function_a25bd3f73acabb1e() && !self ismantling() )
    {
        self playsoundtoplayer( "zxp_superjump_vo", self, self );
        self playsound( "zxp_superjump_sfx_npc", self, self );
        maxjumpvelocity = getdvarfloat( @"hash_fd6822a1c2607510", 1300 );
        player_angles = self getplayerangles();
        thread function_e2c3d5fb10eafa33();
        playerapplyjumpvelocity( player_angles, maxjumpvelocity, self.jumpfraction );
        thread function_86a4497ad6c126f7();
        self.var_4b87dfb47bc432cc = undefined;
        self.var_4026b2b0e0c125b3 = undefined;
    }
    else
    {
        if ( var_c4f2c4e3a29aab48 )
        {
            if ( level.mutationgametype.hudserver )
            {
                self.powershud[ powerref ].barelem.bar.frac = 0;
            }
            else
            {
                self.powershud[ powerref ].frac = 0;
            }
            
            escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].progressupdate, 0 );
            self enableoffhandweapons();
            self allowmelee( 1 );
            self notify( #"hash_dc912c839c40e708" );
        }
        
        escort_horde_abilities::function_22b061104142a21e();
        thread escort_horde_abilities::function_689938e798c377b5( powerstruct, powerref );
        
        if ( self.var_6b2acdf404a4c7c2 )
        {
            escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].progressupdate, 100 );
            var_45a7b02b25a7d1db = 0;
        }
    }
    
    playerzombiejumpcleanup( powerstruct, powerref, var_45a7b02b25a7d1db );
}

