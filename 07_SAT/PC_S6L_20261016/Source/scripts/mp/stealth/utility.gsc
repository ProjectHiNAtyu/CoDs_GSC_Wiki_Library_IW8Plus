// scripts\mp\stealth\utility.gsc  (hash_00c81008889f9230.gscc) (size: 5793 Bytes / 0x16a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a78fe94 (2054749844)
// size ...... 5793 (0x16a1)
// includes .. 4   (offset: 0x15a5)
// strings ... 16  (offset: 0x15c5)
// dev strs .. 1   (offset: 0x1695)
// exports ... 16  (offset: 0xe09)
// cseg ...... 0x1e5 + 0xc24 (0xe09)
// imports ... 43  (offset: 0x1089)
// animtree1 . 0   (offset: 0x16a1)
// animtree2 . 0   (offset: 0x16a1)
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;

#namespace utility;

/#

    // Namespace utility
    // Params 1
    // Checksum 0x83e0e427, Offset: 0x203
    // Size: 0x21, Type: dev
    function function_3fb3fc187440a507( debug_string )
    {
        if ( !stealth_debug_enabled() )
        {
            return;
        }
        
        iprintln( debug_string );
    }

    // Namespace utility
    // Params 0
    // Checksum 0x7cce0b20, Offset: 0x22c
    // Size: 0x16, Type: dev
    function stealth_debug_enabled()
    {
        return getdvarint( @"enable_stealth_debug", 0 ) != 0;
    }

#/

// Namespace utility
// Params 1
// Checksum 0xff3d7ebb, Offset: 0x24a
// Size: 0x2b
function setattackeraccuracy( val )
{
    if ( isplayer( self ) )
    {
        function_6f8a0dfa37023879( val );
        return;
    }
    
    self.attackeraccuracy = val;
}

// Namespace utility
// Params 1
// Checksum 0x973e0880, Offset: 0x27d
// Size: 0x4e
function function_6f8a0dfa37023879( val )
{
    self.scriptedattackeraccuracy = val;
    
    if ( issharedfuncdefined( #"gameskill", #"updateplayerattackeraccuracy" ) )
    {
        self [[ getsharedfunc( #"gameskill", #"updateplayerattackeraccuracy" ) ]]();
    }
}

// Namespace utility
// Params 0
// Checksum 0xb4ccb476, Offset: 0x2d3
// Size: 0x7
function function_554676ed08afdaaa()
{
    return "bad_guys";
}

// Namespace utility
// Params 0
// Checksum 0x57e29073, Offset: 0x2e3
// Size: 0x538
function function_f7fc636d9968f25f()
{
    var_4e984481f1c48433 = 1;
    
    if ( getdvarint( @"hash_4096753656b86302", 0 ) )
    {
        var_4e984481f1c48433 = 0;
    }
    
    if ( flag( "stealth_spotted" ) && var_4e984481f1c48433 )
    {
        foreach ( guy in level.players )
        {
            guy setclientomnvar( "ui_ai_stealth_edge_glow", 0 );
        }
        
        return;
    }
    
    /#
        sixthsensedebug = getdvarint( @"hash_3a87475a75de0350" ) == 1;
    #/
    
    tootherplayer = undefined;
    
    foreach ( num, player in level.var_c01850191d497017 )
    {
        if ( !isdefined( player ) )
        {
            level.var_c01850191d497017[ num ] = undefined;
            break;
        }
        
        if ( player.ignoreme || player.notarget )
        {
            continue;
        }
        
        player.process = 0;
        sightmask = 0;
        spottedmask = 0;
        playerpos = player geteye();
        playerteam = player.team;
        playeraim = anglestoforward( player getplayerangles() );
        
        foreach ( otherplayer in getaiarray( function_554676ed08afdaaa() ) )
        {
            if ( player.process >= 25 )
            {
                player.process = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                level.var_c01850191d497017[ num ] = undefined;
                break;
            }
            
            if ( !isdefined( player.perks[ "specialty_sixth_sense" ] ) && !isdefined( player.perks[ "specialty_ai_stealth_sixth_sense" ] ) )
            {
                continue;
            }
            
            if ( player.ignoreme || player.notarget )
            {
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( !isdefined( otherplayer ) )
            {
                continue;
            }
            
            if ( !isdefined( otherplayer.stealth ) )
            {
                continue;
            }
            
            if ( !otherplayer player::isreallyalive() )
            {
                continue;
            }
            
            if ( otherplayer.ignoreall )
            {
                continue;
            }
            
            if ( otherplayer.team == playerteam )
            {
                continue;
            }
            
            if ( distancesquared( otherplayer.origin, playerpos ) > 16000000 )
            {
                continue;
            }
            
            if ( !otherplayer function_16600b0c0a09e263( player ) )
            {
                continue;
            }
            
            player.process++;
            
            if ( !otherplayer cansee( player ) )
            {
                continue;
            }
            
            otherplayerpos = otherplayer geteye();
            fromotherplayer = playerpos - otherplayerpos;
            tootherplayer = otherplayerpos - playerpos;
            player.process += 2;
            sightmask |= player function_74b245f6bb518407( otherplayer );
            
            if ( otherplayer function_4d40994d0dcca395() && !isdefined( otherplayer.forcesixthsense ) )
            {
                spottedmask |= player function_74b245f6bb518407( otherplayer );
                
                if ( spottedmask > 0 )
                {
                    if ( !isdefined( player.var_b34bc39c76afb8d1 ) )
                    {
                        player.var_b34bc39c76afb8d1 = gettime();
                    }
                    
                    if ( gettime() >= player.var_b34bc39c76afb8d1 )
                    {
                        player.var_b34bc39c76afb8d1 = gettime() + 5000;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( level.var_d9d6499446fa3c56 ) )
            {
                dirs = [ "left", "right", "lower", "upper" ];
                
                foreach ( dir in dirs )
                {
                    active = function_931d96930c6dabc6( dir, sightmask );
                    spotted = function_931d96930c6dabc6( dir, spottedmask );
                    player function_d6a2b60ad3613a93( dir, active, spotted, sightmask, spottedmask );
                    player thread [[ level.var_d9d6499446fa3c56 ]]( dir, active, spotted );
                }
            }
            
            break;
        }
        
        if ( var_4e984481f1c48433 )
        {
            player function_4f4818b82208e469( sightmask );
        }
    }
}

// Namespace utility
// Params 5
// Checksum 0x9794b083, Offset: 0x823
// Size: 0xe8
function function_d6a2b60ad3613a93( dir, active, spotted, sightmask, spottedmask )
{
    if ( sightmask > 0 )
    {
        if ( spottedmask == 0 && getstealthdetectstate() != "spotted" )
        {
            if ( !isdefined( self.var_cdacaff016f9459f ) )
            {
                self.var_cdacaff016f9459f = gettime();
            }
            
            if ( gettime() >= self.var_cdacaff016f9459f )
            {
                self.var_cdacaff016f9459f = gettime() + 5000;
                self playlocalsound( "ui_stealth_threat_hud_periph_vision" );
            }
        }
    }
    
    if ( spottedmask > 0 || spotted || getstealthdetectstate() == "spotted" )
    {
        if ( !isdefined( self.var_b34bc39c76afb8d1 ) )
        {
            self.var_b34bc39c76afb8d1 = gettime();
        }
        
        if ( gettime() >= self.var_b34bc39c76afb8d1 )
        {
            self.var_b34bc39c76afb8d1 = gettime() + 5000;
        }
    }
}

// Namespace utility
// Params 2
// Checksum 0x440fed3c, Offset: 0x913
// Size: 0x135, Type: bool
function function_931d96930c6dabc6( dir, mask )
{
    consts = [];
    
    switch ( dir )
    {
        case #"hash_c9b3133a17a3b2d0":
            consts = [ 128, 32 ];
            break;
        case #"hash_96815ce4f2a3dbc5":
            consts = [ 64, 8 ];
            break;
        case #"hash_1e6b44ab584b8527":
            consts = [ 4, 2, 1 ];
            break;
        case #"hash_c325f7340a63499a":
            consts = [ 16 ];
            break;
        default:
            assertmsg( "<dev string:x24>" + dir );
            break;
    }
    
    foreach ( constvalue in consts )
    {
        if ( mask & constvalue )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x9812e49a, Offset: 0xa51
// Size: 0x97
function _getweapongroup( weapon )
{
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        return "other";
    }
    
    if ( isstring( weapon ) && ( weapon == "none" || weapon == "alt_none" ) )
    {
        return "other";
    }
    
    rootname = weapon::getweaponrootname( weapon );
    group = weapon::weapongroupmap( rootname );
    
    if ( !isdefined( group ) )
    {
        if ( weapon::iskillstreakweapon( weapon ) )
        {
            group = "killstreak";
        }
        else
        {
            group = "other";
        }
    }
    
    return group;
}

// Namespace utility
// Params 1
// Checksum 0xb5686012, Offset: 0xaf1
// Size: 0xec, Type: bool
function function_16600b0c0a09e263( player )
{
    if ( self.juggernaut )
    {
        return true;
    }
    
    if ( self.unittype == "suicidebomber" )
    {
        return true;
    }
    
    objweapon = self.weapon;
    weapongroup = _getweapongroup( objweapon );
    
    switch ( weapongroup )
    {
        case #"hash_bef5ec0b3e197ae":
        case #"hash_47368bc0d2ef1565":
        case #"hash_8af0086b038622b5":
        case #"hash_9d18adab1b65a661":
        case #"hash_ab10f9c080fe4faf":
        case #"hash_c095d67337b1f5a1":
        case #"hash_dd616da0b395a0b0":
            return true;
        case #"hash_16cf6289ab06bd30":
            if ( distancesquared( self.origin, player.origin ) > 160000 )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace utility
// Params 0
// Checksum 0xeac58cbf, Offset: 0xbe6
// Size: 0x1c
function function_717a96a623c01779()
{
    level.var_c01850191d497017 = [];
    
    while ( true )
    {
        waitframe();
        function_f7fc636d9968f25f();
    }
}

// Namespace utility
// Params 0
// Checksum 0xbee398a2, Offset: 0xc0a
// Size: 0x3d
function function_eb7bf654aceb23c5()
{
    self.var_d68d3b6a45e6c4d2 = 0;
    self.var_4b5da9b8b957b936 = 0;
    function_4f4818b82208e469( 0 );
    playernum = self getentitynumber();
    level.var_c01850191d497017[ playernum ] = self;
}

// Namespace utility
// Params 0
// Checksum 0xdac51a6a, Offset: 0xc4f
// Size: 0x51
function function_f63fbae3ac4450a0()
{
    function_4f4818b82208e469( 0 );
    self.var_d68d3b6a45e6c4d2 = undefined;
    self.var_4b5da9b8b957b936 = undefined;
    self.var_c02da463ef0a0358 = undefined;
    self notify( #"removesixthsense" );
    playernum = self getentitynumber();
    level.var_c01850191d497017[ playernum ] = undefined;
}

// Namespace utility
// Params 1
// Checksum 0x3afcb7c4, Offset: 0xca8
// Size: 0x19
function function_4f4818b82208e469( sightmask )
{
    self setclientomnvar( "ui_ai_stealth_edge_glow", sightmask );
}

// Namespace utility
// Params 1
// Checksum 0xbc725717, Offset: 0xcc9
// Size: 0x140
function function_74b245f6bb518407( enemy )
{
    forward = anglestoforward( self getplayerangles() );
    forward2d = ( forward[ 0 ], forward[ 1 ], forward[ 2 ] );
    forward2d = vectornormalize( forward2d );
    toenemy = enemy.origin - self.origin;
    toenemy2d = ( toenemy[ 0 ], toenemy[ 1 ], toenemy[ 2 ] );
    toenemy2d = vectornormalize( toenemy2d );
    dot = vectordot( forward2d, toenemy2d );
    
    if ( dot >= 0.92388 )
    {
        return 2;
    }
    
    if ( dot >= 0.5 )
    {
        return ( isleft2d( self.origin, forward2d, enemy.origin ) ? 4 : 1 );
    }
    
    if ( dot >= 0.5 )
    {
        return ( isleft2d( self.origin, forward2d, enemy.origin ) ? 128 : 64 );
    }
    
    if ( dot >= -0.707107 )
    {
        return ( isleft2d( self.origin, forward2d, enemy.origin ) ? 32 : 8 );
    }
    
    return 16;
}

