// scripts\mp\common\killstreaks\flares.gsc  (hash_319c90e90d9e6ecb.gscc) (size: 6091 Bytes / 0x17cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2feffb41 (804256577)
// size ...... 6091 (0x17cb)
// includes .. 1   (offset: 0x173b)
// strings ... 9   (offset: 0x1743)
// dev strs .. 2   (offset: 0x17b3)
// exports ... 22  (offset: 0xe5f)
// cseg ...... 0x104 + 0xd5b (0xe5f)
// imports ... 45  (offset: 0x11cf)
// animtree1 . 0   (offset: 0x17cb)
// animtree2 . 0   (offset: 0x17cb)
#using scripts\mp\common\utility\weapon_utility;

#namespace flares;

// Namespace flares
// Params 1
// Checksum 0x13b83946, Offset: 0x122
// Size: 0x28
function flares_monitor( flarecount )
{
    self.flaresreservecount = flarecount;
    self.flareslive = [];
    thread ks_laserguidedmissile_handleincoming();
}

// Namespace flares
// Params 3
// Checksum 0xb9370cce, Offset: 0x152
// Size: 0x73
function flares_playfx( fxoverride, fxtagoverride, sfxoverride )
{
    flarestag = "tag_origin";
    
    if ( !isdefined( fxoverride ) )
    {
        fxoverride = "vehicle_flares";
    }
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    if ( !isdefined( sfxoverride ) )
    {
        sfxoverride = "ks_apache_flares";
    }
    
    playsoundatpos( self gettagorigin( flarestag ), sfxoverride );
    playfxontag( level._effect[ fxoverride ], self, flarestag );
}

// Namespace flares
// Params 0
// Checksum 0x76c0ab43, Offset: 0x1cd
// Size: 0x9a
function flares_deploy()
{
    flare = spawn( "script_origin", self.origin + ( 0, 0, -256 ) );
    flare.targetname = "flares_deploy";
    flare.angles = self.angles;
    flare movegravity( ( 0, 0, -1 ), 5 );
    self.flareslive[ self.flareslive.size ] = flare;
    flare thread flares_deleteaftertime( 5, 2, self );
    return flare;
}

// Namespace flares
// Params 3
// Checksum 0x6bf95e5, Offset: 0x270
// Size: 0x77
function flares_deleteaftertime( delaydelete, var_5c673c6f213e79d0, vehicle )
{
    assert( !isdefined( var_5c673c6f213e79d0 ) || var_5c673c6f213e79d0 < delaydelete, "<dev string:x24>" );
    
    if ( isdefined( var_5c673c6f213e79d0 ) && isdefined( vehicle ) )
    {
        delaydelete -= var_5c673c6f213e79d0;
        wait var_5c673c6f213e79d0;
        
        if ( isdefined( vehicle ) )
        {
            vehicle.flareslive = arrayremove( vehicle.flareslive, self );
        }
    }
    
    wait delaydelete;
    self delete();
}

// Namespace flares
// Params 1
// Checksum 0x9b92156e, Offset: 0x2ef
// Size: 0x17
function flares_getnumleft( vehicle )
{
    return vehicle.flaresreservecount;
}

// Namespace flares
// Params 1
// Checksum 0xaa4b459a, Offset: 0x30f
// Size: 0x34, Type: bool
function flares_areavailable( vehicle )
{
    flares_cleanflareslivearray( vehicle );
    return vehicle.flaresreservecount > 0 || vehicle.flareslive.size > 0;
}

// Namespace flares
// Params 1
// Checksum 0xdb8a2ad4, Offset: 0x34c
// Size: 0x4e
function flares_getflarereserve( vehicle )
{
    assert( vehicle.flaresreservecount > 0, "<dev string:x79>" );
    flares_reducereserves( vehicle );
    vehicle thread flares_playfx();
    flare = vehicle flares_deploy();
    return flare;
}

// Namespace flares
// Params 1
// Checksum 0x64848a47, Offset: 0x3a3
// Size: 0x27
function flares_cleanflareslivearray( vehicle )
{
    vehicle.flareslive = function_5713d46873b29625( vehicle.flareslive );
}

// Namespace flares
// Params 1
// Checksum 0x1c9d1cf3, Offset: 0x3d2
// Size: 0x52
function flares_getflarelive( vehicle )
{
    flares_cleanflareslivearray( vehicle );
    flare = undefined;
    
    if ( vehicle.flareslive.size > 0 )
    {
        flare = vehicle.flareslive[ vehicle.flareslive.size - 1 ];
    }
    
    return flare;
}

// Namespace flares
// Params 0
// Checksum 0xae412c50, Offset: 0x42d
// Size: 0x11d
function ks_laserguidedmissile_handleincoming()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"helicopter_done" );
    
    while ( flares_areavailable( self ) )
    {
        level waittill( #"hash_2b53bb53f231341a", player, missiles, target );
        
        if ( target != self )
        {
            continue;
        }
        
        if ( !isarray( missiles ) )
        {
            missiles = [ missiles ];
        }
        
        foreach ( missile in missiles )
        {
            if ( isvalidmissile( missile ) )
            {
                level thread ks_laserguidedmissile_monitorproximity( missile, player, player.team, target );
            }
        }
    }
}

// Namespace flares
// Params 4
// Checksum 0x93c960b5, Offset: 0x552
// Size: 0xe3
function ks_laserguidedmissile_monitorproximity( missile, player, team, target )
{
    target endon( #"death" );
    missile endon( #"death" );
    missile endon( #"missile_targetchanged" );
    
    while ( flares_areavailable( target ) )
    {
        if ( !isdefined( target ) || !isvalidmissile( missile ) )
        {
            break;
        }
        
        center = target getpointinbounds( 0, 0, 0 );
        
        if ( distancesquared( missile.origin, center ) < 4000000 )
        {
            flare = flares_getflarelive( target );
            
            if ( !isdefined( flare ) )
            {
                flare = flares_getflarereserve( target );
            }
            
            weapon_utility::clearprojectilelockedon( missile );
            missile missile_settargetent( flare );
            missile notify( #"missile_pairedwithflare" );
            break;
        }
        
        waitframe();
    }
}

// Namespace flares
// Params 1
// Checksum 0x496c56cd, Offset: 0x63d
// Size: 0xb9
function flares_handleincomingsam( functionoverride )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"helicopter_done" );
    
    for ( ;; )
    {
        level waittill( #"sam_fired", player, missilegroup, locktarget );
        
        if ( locktarget != self )
        {
            continue;
        }
        
        if ( isdefined( functionoverride ) )
        {
            level thread [[ functionoverride ]]( player, player.team, locktarget, missilegroup );
            continue;
        }
        
        level thread flares_watchsamproximity( player, player.team, locktarget, missilegroup );
    }
}

// Namespace flares
// Params 4
// Checksum 0xc6d3c92, Offset: 0x6fe
// Size: 0x141
function flares_watchsamproximity( player, missileteam, missiletarget, missilegroup )
{
    level endon( #"game_ended" );
    missiletarget endon( #"death" );
    
    while ( true )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = [];
        
        for ( i = 0; i < missilegroup.size ; i++ )
        {
            if ( isdefined( missilegroup[ i ] ) )
            {
                curdist[ i ] = distance( missilegroup[ i ].origin, center );
            }
        }
        
        for ( i = 0; i < curdist.size ; i++ )
        {
            if ( isdefined( curdist[ i ] ) )
            {
                if ( curdist[ i ] < 4000 && missiletarget.flaresreservecount > 0 )
                {
                    flares_reducereserves( missiletarget );
                    missiletarget thread flares_playfx();
                    newtarget = missiletarget flares_deploy();
                    
                    for ( j = 0; j < missilegroup.size ; j++ )
                    {
                        if ( isdefined( missilegroup[ j ] ) )
                        {
                            weapon_utility::clearprojectilelockedon( missilegroup[ j ] );
                            missilegroup[ j ] missile_settargetent( newtarget );
                            missilegroup[ j ] notify( #"missile_pairedwithflare" );
                        }
                    }
                    
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace flares
// Params 2
// Checksum 0xf00c3e55, Offset: 0x847
// Size: 0xd7
function flares_handleincomingstinger( functionoverride, fxlocoverride )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"helicopter_done" );
    
    if ( !isdefined( self.flareslive ) )
    {
        self.flareslive = [];
    }
    
    for ( ;; )
    {
        level waittill( #"stinger_fired", player, missile, locktarget );
        
        if ( locktarget != self )
        {
            continue;
        }
        
        if ( isdefined( functionoverride ) )
        {
            missile thread [[ functionoverride ]]( player, player.team, locktarget, fxlocoverride );
            continue;
        }
        
        missile thread flares_watchstingerproximity( player, player.team, locktarget, fxlocoverride );
    }
}

// Namespace flares
// Params 4
// Checksum 0xa7d2c6e4, Offset: 0x926
// Size: 0xd2
function flares_watchstingerproximity( player, missileteam, missiletarget, fxtagoverride )
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
            flares_reducereserves( missiletarget );
            missiletarget thread flares_playfx( undefined, fxtagoverride );
            newtarget = missiletarget flares_deploy();
            weapon_utility::clearprojectilelockedon( self );
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace flares
// Params 1
// Checksum 0xbae72de, Offset: 0xa00
// Size: 0x4a
function flares_reducereserves( flaresholder )
{
    flaresholder.flaresreservecount--;
    
    if ( isplayer( flaresholder.owner ) )
    {
        flaresholder.owner setclientomnvar( "ui_killstreak_flares", flaresholder.flaresreservecount );
    }
}

// Namespace flares
// Params 4
// Checksum 0xc08ea2c6, Offset: 0xa52
// Size: 0x66
function ks_setup_manual_flares( num_flares, button_action, flares_omnvar_name, incoming_omnvar_name )
{
    self.flaresreservecount = num_flares;
    self.flareslive = [];
    
    if ( isdefined( flares_omnvar_name ) )
    {
        self.owner setclientomnvar( flares_omnvar_name, num_flares );
    }
    
    thread ks_manualflares_watchuse( button_action, flares_omnvar_name );
    thread ks_manualflares_handleincoming( incoming_omnvar_name );
}

// Namespace flares
// Params 2
// Checksum 0x7020fa09, Offset: 0xac0
// Size: 0x101
function ks_manualflares_watchuse( button_action, omnvar_name )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"helicopter_done" );
    
    if ( !isai( self.owner ) )
    {
        self.owner notifyonplayercommand( "manual_flare_popped", button_action );
    }
    
    while ( flares_getnumleft( self ) )
    {
        self.owner waittill( #"manual_flare_popped" );
        flare = flares_getflarereserve( self );
        
        if ( isdefined( flare ) && isdefined( self.owner ) && !isai( self.owner ) )
        {
            self.owner playlocalsound( "ks_ac130_flares" );
            
            if ( isdefined( omnvar_name ) )
            {
                self.owner setclientomnvar( omnvar_name, flares_getnumleft( self ) );
            }
        }
    }
}

// Namespace flares
// Params 1
// Checksum 0x2bf4b0ac, Offset: 0xbc9
// Size: 0x194
function ks_manualflares_handleincoming( omnvar_name )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"helicopter_done" );
    
    while ( flares_areavailable( self ) )
    {
        self waittill( #"hash_f25d2c528d26cba3", missiles );
        
        if ( !isdefined( missiles ) )
        {
            continue;
        }
        
        self.owner thread ks_watch_death_stop_sound( self, "missile_incoming" );
        
        if ( isdefined( omnvar_name ) )
        {
            vec_to_target = vectornormalize( missiles[ 0 ].origin - self.origin );
            vec_to_right = vectornormalize( anglestoright( self.angles ) );
            vec_dot = vectordot( vec_to_target, vec_to_right );
            dir_index = 1;
            
            if ( vec_dot > 0 )
            {
                dir_index = 2;
            }
            else if ( vec_dot < 0 )
            {
                dir_index = 3;
            }
            
            self.owner setclientomnvar( omnvar_name, dir_index );
        }
        
        foreach ( missile in missiles )
        {
            if ( isvalidmissile( missile ) )
            {
                thread ks_manualflares_monitorproximity( missile );
            }
        }
    }
}

// Namespace flares
// Params 1
// Checksum 0x62790c36, Offset: 0xd65
// Size: 0xbb
function ks_manualflares_monitorproximity( missile )
{
    self endon( #"death" );
    missile endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self ) || !isvalidmissile( missile ) )
        {
            break;
        }
        
        center = self getpointinbounds( 0, 0, 0 );
        
        if ( distancesquared( missile.origin, center ) < 4000000 )
        {
            flare = flares_getflarelive( self );
            
            if ( isdefined( flare ) )
            {
                weapon_utility::clearprojectilelockedon( missile );
                missile missile_settargetent( flare );
                missile notify( #"missile_pairedwithflare" );
                self.owner stoplocalsound( "missile_incoming" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace flares
// Params 2
// Checksum 0xd9851d98, Offset: 0xe28
// Size: 0x37
function ks_watch_death_stop_sound( vehicle, sound )
{
    self endon( #"disconnect" );
    vehicle waittill( #"death" );
    self stoplocalsound( sound );
}

