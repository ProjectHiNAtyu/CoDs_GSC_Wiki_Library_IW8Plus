// script_5b069bf5ef5a57ed  (hash_5b069bf5ef5a57ed.gscc) (size: 6468 Bytes / 0x1944 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7193a420 (1905501216)
// size ...... 6468 (0x1944)
// includes .. 11  (offset: 0x184c)
// strings ... 12  (offset: 0x18a4)
// dev strs .. 0   (offset: 0x1944)
// exports ... 16  (offset: 0xeb8)
// cseg ...... 0x13d + 0xd7b (0xeb8)
// imports ... 60  (offset: 0x1138)
// animtree1 . 0   (offset: 0x1944)
// animtree2 . 0   (offset: 0x1944)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\player;
#using scripts\mp\execution;
#using scripts\mp\talking_gun;

#namespace specialty_sixth_sense;

// Namespace specialty_sixth_sense
// Params 0, eflags: 0x1
// Checksum 0xaa32faf, Offset: 0x15b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_2313f2d26bf850f1 );
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0xbcaa7f8e, Offset: 0x17b
// Size: 0x6c
function initsixthsense()
{
    level.var_19041562949e65b = level.perkbundles[ "specialty_sixth_sense" ].var_bada2e88da795e7d ?? 0;
    level thread sixthsense_think();
    utility::registersharedfunc( #"specialty_sixth_sense", #"hash_5356ca60e52666a0", &sixthsense_inotherplayertargetcone );
    utility::registersharedfunc( #"specialty_sixth_sense", #"hash_9cd138eb6044845a", &getsixthsensedirection );
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0xd71c3bbe, Offset: 0x1ef
// Size: 0x3f
function function_2313f2d26bf850f1( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_sixth_sense", &setsixthsense, &unsetsixthsense, [], &initsixthsense );
    }
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0x89635818, Offset: 0x236
// Size: 0x52
function setsixthsense()
{
    if ( getdvarint( @"hash_a013b18d3ee5cc85", 0 ) == 1 )
    {
        return;
    }
    
    self.sixthsenselastactivetime = 0;
    self.sixthsensestate = 0;
    updatesixthsensevfx( 0 );
    playernum = self getentitynumber();
    level.sixth_sense_players[ playernum ] = self;
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0xb687ee34, Offset: 0x290
// Size: 0x9
function unsetsixthsense()
{
    thread clearsixthsense();
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0xa76dbbd5, Offset: 0x2a1
// Size: 0xed, Type: bool
function function_7ccae03d57281c7c( otherplayer )
{
    if ( !isdefined( otherplayer ) )
    {
        return false;
    }
    
    if ( !otherplayer player::isreallyalive() )
    {
        return false;
    }
    
    if ( isdefined( otherplayer.perks[ "specialty_sixth_sense_immune" ] ) )
    {
        return false;
    }
    
    if ( !otherplayer val::get( "fire" ) )
    {
        return false;
    }
    
    if ( isbrgamemode() && !getdvarint( @"hash_ea5fc7f3d17eec06", 0 ) && player::isinlaststand( otherplayer ) )
    {
        return false;
    }
    
    if ( otherplayer utility::isusingremote() )
    {
        if ( level.var_19041562949e65b )
        {
            return false;
        }
        
        remotename = otherplayer player::getremotename();
        
        if ( remotename == "gunship" || remotename == "radar_drone_recon" || remotename == "chopper_gunner" || remotename == "cruise_predator" || remotename == "assault_drone" || remotename == "turret_drone" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0x7b559429, Offset: 0x397
// Size: 0x96, Type: bool
function sixthsense_shouldwarnaboutotherplayer( otherplayer )
{
    if ( otherplayer.team == self.team )
    {
        return false;
    }
    
    if ( distancesquared( otherplayer.origin, self.origin ) > 16000000 )
    {
        return false;
    }
    
    if ( isdefined( self.perks[ "specialty_operative" ] ) )
    {
        bundle = level.perkbundles[ "specialty_operative" ];
        
        if ( bundle.var_31797e618679c2fa && !otherplayer player::isplayerads() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace specialty_sixth_sense
// Params 5
// Checksum 0x3770e88, Offset: 0x436
// Size: 0xc3, Type: bool
function sixthsense_inotherplayertargetcone( otherplayer, playerpos, otherplayerpos, otherplayeraim, var_f3a13bac61fbd521 )
{
    fromotherplayer = playerpos - otherplayerpos;
    dot = vectordot( fromotherplayer, otherplayeraim );
    
    if ( dot <= 0 )
    {
        return false;
    }
    
    var_3c9c3b8a993e0c31 = length( fromotherplayer );
    var_667d2a328d71f2d9 = var_f3a13bac61fbd521 ?? 12;
    var_667d2a328d71f2d9 += -0.15 * sqrt( var_3c9c3b8a993e0c31 );
    var_90ca182e9394998e = math::degrees_to_radians( var_667d2a328d71f2d9 );
    var_c31b64911d358ba7 = 1 - 0.5 * var_90ca182e9394998e * var_90ca182e9394998e;
    
    if ( dot < var_c31b64911d358ba7 * var_3c9c3b8a993e0c31 )
    {
        return false;
    }
    
    return true;
}

// Namespace specialty_sixth_sense
// Params 3
// Checksum 0x2023e7d2, Offset: 0x502
// Size: 0x53, Type: bool
function sixthsense_playerseesotherplayer( playeraim, playerpos, otherplayerpos )
{
    tootherplayer = otherplayerpos - playerpos;
    dot = vectordot( playeraim, vectornormalize( tootherplayer ) );
    
    if ( dot < 0.382683 )
    {
        return true;
    }
    
    return false;
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0x3227e0c3, Offset: 0x55e
// Size: 0x65c
function sixthsense_think_internal()
{
    tracecontents = trace::create_default_contents( 1 );
    sixthsensedebug = 0;
    
    /#
        sixthsensedebug = getdvarint( @"hash_3a87475a75de0350" ) == 1;
    #/
    
    var_abfc3bef694f2a83 = getdvarint( @"scr_sixth_sense_use_eyes_on" ) == 1;
    process = 0;
    tootherplayer = undefined;
    var_61c380320ed6ab0 = undefined;
    
    foreach ( player in level.players )
    {
        player.var_f2d6803cfa56c194 = function_7ccae03d57281c7c( player );
    }
    
    foreach ( num, player in level.sixth_sense_players )
    {
        if ( !isdefined( player ) )
        {
            level.sixth_sense_players[ num ] = undefined;
            break;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        sightmask = 0;
        playeraim = anglestoforward( player getplayerangles() );
        
        if ( var_abfc3bef694f2a83 && !isbot( player ) )
        {
            var_f103cd961c74f5cf = player utility::function_68061c3d21a6d57a();
            sighting_players = player getplayerssightingme();
            
            foreach ( otherplayer in sighting_players )
            {
                if ( process >= 25 )
                {
                    process = 0;
                    waitframe();
                }
                
                if ( !otherplayer.var_f2d6803cfa56c194 )
                {
                    continue;
                }
                
                if ( !isdefined( player ) )
                {
                    level.sixth_sense_players[ num ] = undefined;
                    break;
                }
                
                if ( !player sixthsense_shouldwarnaboutotherplayer( otherplayer ) )
                {
                    continue;
                }
                
                process++;
                otherplayerpos = otherplayer getvieworigin();
                
                if ( player sixthsense_inotherplayertargetcone( player, otherplayerpos, var_f103cd961c74f5cf, playeraim, 45 ) )
                {
                    continue;
                }
                
                process++;
                otherplayeraim = anglestoforward( otherplayer getplayerangles() );
                
                if ( !player sixthsense_inotherplayertargetcone( otherplayer, var_f103cd961c74f5cf, otherplayerpos, otherplayeraim, 12 ) )
                {
                    continue;
                }
                
                player.var_1eac61f0e82441d[ otherplayer.entnum ?? utility::get_entity_number( otherplayer ) ] = gettime();
                sightmask |= player getsixthsensedirection( otherplayer );
            }
        }
        else
        {
            var_f103cd961c74f5cf = player utility::function_68061c3d21a6d57a();
            var_1654a8397a08dcb1 = player geteye();
            
            foreach ( otherplayer in level.players )
            {
                if ( process >= 25 )
                {
                    process = 0;
                    waitframe();
                }
                
                if ( !otherplayer.var_f2d6803cfa56c194 )
                {
                    continue;
                }
                
                if ( !isdefined( player ) )
                {
                    level.sixth_sense_players[ num ] = undefined;
                    break;
                }
                
                if ( !isdefined( otherplayer ) )
                {
                    continue;
                }
                
                if ( !player sixthsense_shouldwarnaboutotherplayer( otherplayer ) )
                {
                    continue;
                }
                
                process++;
                otherplayerpos = otherplayer getvieworigin();
                otherplayeraim = anglestoforward( otherplayer getplayerangles() );
                
                if ( !player sixthsense_inotherplayertargetcone( otherplayer, var_f103cd961c74f5cf, otherplayerpos, otherplayeraim, 12 ) )
                {
                    continue;
                }
                
                if ( sixthsense_playerseesotherplayer( playeraim, var_f103cd961c74f5cf, otherplayerpos ) )
                {
                    process += 2;
                    ignoreents = [ player ];
                    vehicle = otherplayer vehicle::get_vehicle();
                    
                    if ( isdefined( vehicle ) )
                    {
                        outlineents = perkfunctions::getchildoutlineents( vehicle );
                        
                        foreach ( ent in outlineents )
                        {
                            ignoreents[ ignoreents.size ] = ent;
                        }
                    }
                    
                    turret = otherplayer.currentturret;
                    
                    if ( isdefined( turret ) )
                    {
                        ignoreents[ ignoreents.size ] = turret;
                    }
                    
                    if ( trace::ray_trace_detail_passed( otherplayerpos, var_1654a8397a08dcb1, ignoreents, tracecontents ) )
                    {
                        /#
                            if ( sixthsensedebug )
                            {
                                thread utility::draw_line_for_time( otherplayerpos, var_1654a8397a08dcb1, 0, 0, 1, 0.2 );
                            }
                        #/
                        
                        sightmask = 255;
                        break;
                    }
                }
                
                /#
                    if ( sixthsensedebug )
                    {
                        thread utility::draw_line_for_time( otherplayerpos, var_1654a8397a08dcb1, 1, 0, 0, 0.2 );
                    }
                #/
            }
        }
        
        if ( !isdefined( player ) )
        {
            level.sixth_sense_players[ num ] = undefined;
            break;
        }
        
        player updatesixthsensevfx( sightmask );
        
        if ( sightmask != 0 )
        {
            if ( talking_gun::function_49e15c53304cb2ca() )
            {
                if ( sightmask | 0 )
                {
                    talkinggunevent = #"highalert_spotted_left";
                }
                else if ( sightmask | 0 )
                {
                    talkinggunevent = #"highalert_spotted_right";
                }
                else
                {
                    talkinggunevent = #"highalert_spotted";
                }
                
                talking_gun::talkinggun_event( player, talkinggunevent );
            }
            
            if ( getdvarint( @"hash_9d4361be8e1b02ee", 1 ) )
            {
                if ( ( !isdefined( player.var_5d500bef88c41a81 ) || gettime() > player.var_5d500bef88c41a81 ) && isdefined( player.executionref ) && execution::function_fc73d92eb94859e4( player.executionref ) )
                {
                    player.var_5d500bef88c41a81 = gettime() + getdvarint( @"hash_505f54e32e56d815", 3000 ) + randomint( 1000 );
                    
                    if ( getdvarint( @"hash_87e6b1e56b17932a", 0 ) )
                    {
                        player playlocalsound( #"hash_39196d24c1481cf8" );
                        continue;
                    }
                    
                    player playsoundonmovingent( #"hash_39196d24c1481cf8" );
                }
            }
        }
    }
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0xce1a99b0, Offset: 0xbc2
// Size: 0x56
function sixthsense_think()
{
    self notify( #"hash_ae3df85305b4cb90" );
    self endon( #"hash_ae3df85305b4cb90" );
    level endon( #"game_ended" );
    level.sixth_sense_players = [];
    
    while ( true )
    {
        if ( level.sixth_sense_players.size )
        {
            waitframe();
            sixthsense_think_internal();
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace specialty_sixth_sense
// Params 0
// Checksum 0xbea9b115, Offset: 0xc20
// Size: 0x63
function clearsixthsense()
{
    self endon( #"disconnect" );
    self.sixthsenselastactivetime = undefined;
    self.sixthsensestate = undefined;
    self.sixthsensesource = undefined;
    self notify( #"removesixthsense" );
    playernum = self getentitynumber();
    level.sixth_sense_players[ playernum ] = undefined;
    waitframe();
    
    if ( isdefined( self ) )
    {
        updatesixthsensevfx( 0 );
    }
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0x716978e, Offset: 0xc8b
// Size: 0x5d
function updatesixthsensevfx( sightmask )
{
    if ( isdefined( self.perks[ "specialty_operative" ] ) )
    {
        bundle = level.perkbundles[ "specialty_operative" ];
        perks::setperkbuffactive( bundle, %"hash_31735a8f602d9c32", sightmask != 0 );
    }
    
    self setclientomnvar( "ui_edge_glow", sightmask );
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0x106325e7, Offset: 0xcf0
// Size: 0x140
function getsixthsensedirection( enemy )
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
        return ( utility::isleft2d( self.origin, forward2d, enemy.origin ) ? 4 : 1 );
    }
    
    if ( dot >= 0.5 )
    {
        return ( utility::isleft2d( self.origin, forward2d, enemy.origin ) ? 128 : 64 );
    }
    
    if ( dot >= -0.707107 )
    {
        return ( utility::isleft2d( self.origin, forward2d, enemy.origin ) ? 32 : 8 );
    }
    
    return 16;
}

// Namespace specialty_sixth_sense
// Params 1
// Checksum 0x84c3e564, Offset: 0xe38
// Size: 0x80
function markassixthsensesource( otherplayer )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_baf4a682ff4a03e7" );
    self endon( #"hash_baf4a682ff4a03e7" );
    idx = otherplayer getentitynumber();
    self.sixthsensesource[ idx ] = 1;
    otherplayer utility::waittill_any_in_array_or_timeout( [ "death" ], 10 );
    self.sixthsensesource[ idx ] = 0;
}

