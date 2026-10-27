// scripts\mp\callbacksetup.gsc  (hash_22fc1806b758e28c.gscc) (size: 6942 Bytes / 0x1b1e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11d0ca3c (298895932)
// size ...... 6942 (0x1b1e)
// includes .. 5   (offset: 0x1a32)
// strings ... 7   (offset: 0x1a5a)
// dev strs .. 9   (offset: 0x1ab2)
// exports ... 34  (offset: 0x1222)
// cseg ...... 0xe3 + 0x113f (0x1222)
// imports ... 21  (offset: 0x1772)
// animtree1 . 0   (offset: 0x1b1e)
// animtree2 . 0   (offset: 0x1b1e)
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace callbacksetup;

// Namespace callbacksetup/start_gametype
// Params 0, eflags: 0x20
// Checksum 0x9ca400e4, Offset: 0x101
// Size: 0x46
function event_handler[start_gametype] codecallback_startgametype()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        level waittill( #"eternity" );
    }
    
    if ( !level.gametypestarted )
    {
        [[ level.callbackstartgametype ]]();
        level.gametypestarted = 1;
    }
}

// Namespace callbacksetup/player_active
// Params 1, eflags: 0x20
// Checksum 0x71893677, Offset: 0x14f
// Size: 0x51
function event_handler[player_active] player_active( data )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        level waittill( #"eternity" );
    }
    
    self endon( #"disconnect" );
    
    if ( isdefined( level.callbackplayeractive ) )
    {
        [[ level.callbackplayeractive ]]();
    }
}

// Namespace callbacksetup/player_connect
// Params 1, eflags: 0x20
// Checksum 0x5b2846aa, Offset: 0x1a8
// Size: 0x62
function event_handler[player_connect] player_connect( data )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        level waittill( #"eternity" );
    }
    
    self endon( #"disconnect" );
    function_9d9ee863596cdc91();
    [[ level.callbackplayerconnect ]]();
    callback::callback( #"player_connect" );
    function_b71f4e11fde6c146();
}

// Namespace callbacksetup
// Params 0, eflags: 0x4
// Checksum 0x83d5d570, Offset: 0x212
// Size: 0xf6
function private function_9d9ee863596cdc91()
{
    /#
        var_30060f0d9bbf3770 = level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] ?? #"just_connecting";
        
        switch ( var_30060f0d9bbf3770 )
        {
            case #"just_connecting":
            case #"disconnected":
                break;
            case #"connecting":
                assertmsg( "<dev string:x24>" );
                break;
            case #"connected":
                assertmsg( "<dev string:x54>" );
                break;
            case #"disconnecting":
                assertmsg( "<dev string:x9d>" );
                break;
            default:
                assertmsg( "<dev string:xd9>" );
                break;
        }
        
        level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] = #"connecting";
    #/
}

// Namespace callbacksetup
// Params 0, eflags: 0x4
// Checksum 0x7913468f, Offset: 0x310
// Size: 0x2c
function private function_b71f4e11fde6c146()
{
    /#
        level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] = #"connected";
    #/
}

// Namespace callbacksetup/player_disconnect
// Params 1, eflags: 0x20
// Checksum 0x6de86ed5, Offset: 0x344
// Size: 0x10c
function event_handler[player_disconnect] player_disconnect( data )
{
    reason = data.reason;
    self notify( #"disconnect" );
    self notify( #"death_or_disconnect" );
    self.isdisconnecting = 1;
    function_f51414240894150d();
    var_46d8c510a04d7126 = self function_c9980b59cc6aa434();
    
    if ( var_46d8c510a04d7126 )
    {
        isplayerreloading = self isreloading();
        
        if ( isplayerreloading )
        {
            telemetrydata = spawnstruct();
            telemetrydata.player = self;
            telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
            telemetrydata.cancelreason = "DISCONNECT";
            telemetry_utils::function_af2d366f9522f76f( "callback_on_reload_cancel", telemetrydata );
        }
    }
    
    callback::callback( #"hash_28245a6d2061f779", { #reason:reason } );
    [[ level.callbackplayerdisconnect ]]( reason );
    callback::callback( #"player_disconnect", { #reason:reason } );
    function_ac6878cfb1e39cb0();
}

// Namespace callbacksetup
// Params 0, eflags: 0x4
// Checksum 0x14a8f61a, Offset: 0x458
// Size: 0xfd
function private function_f51414240894150d()
{
    /#
        var_30060f0d9bbf3770 = level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] ?? #"unknown";
        
        switch ( var_30060f0d9bbf3770 )
        {
            case #"connecting":
                break;
            case #"connected":
                break;
            case #"disconnecting":
                assertmsg( "<dev string:x10c>" );
                break;
            case #"disconnected":
                assertmsg( "<dev string:x148>" );
                break;
            case #"unknown":
            default:
                if ( self )
                {
                    assertmsg( "<dev string:x183>" );
                }
                else
                {
                    assertmsg( "<dev string:x1bb>" );
                }
                
                break;
        }
        
        level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] = #"disconnecting";
    #/
}

// Namespace callbacksetup
// Params 0, eflags: 0x4
// Checksum 0x3d734198, Offset: 0x55d
// Size: 0x2c
function private function_ac6878cfb1e39cb0()
{
    /#
        level.var_e50620d524b12629[ self.entnum ?? utility::get_entity_number( self ) ] = #"disconnected";
    #/
}

// Namespace callbacksetup/player_offhand_pullback
// Params 1, eflags: 0x20
// Checksum 0x9eb90f93, Offset: 0x591
// Size: 0x30
function event_handler[player_offhand_pullback] player_offhand_pullback( data )
{
    self endon( #"disconnect" );
    self [[ level.var_c6a23d27f33a948c ]]( data.weapon );
}

// Namespace callbacksetup/player_damage
// Params 1, eflags: 0x20
// Checksum 0x645145f3, Offset: 0x5c9
// Size: 0x121
function event_handler[player_damage] player_damage( data )
{
    self endon( #"disconnect" );
    objweapon = data.objweapon;
    profilestart();
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, data.einflictor );
    }
    
    [[ level.callbackplayerdamage ]]( data.einflictor, data.eattacker, data.idamage, data.idflags, data.smeansofdeath, data.fdistance, objweapon, data.vpoint, data.vdir, data.shitloc, data.timeoffset, data.modelindex, data.partname, data.var_2300d396e46c0fe7, data.var_cdd29ad5d1362c2, data.poisedamage, data.willknockdown, data.additionalparams );
    profilestop();
}

// Namespace callbacksetup
// Params 12
// Checksum 0xa5f56e41, Offset: 0x6f2
// Size: 0x96
function codecallback_playerdamagescore( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage )
{
    self endon( #"disconnect" );
    return [[ level.callbackplayerdamagescore ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage );
}

// Namespace callbacksetup/player_damage_effects
// Params 1, eflags: 0x20
// Checksum 0x7c53f705, Offset: 0x791
// Size: 0x7d
function event_handler[player_damage_effects] player_damage_effects( data )
{
    self endon( #"disconnect" );
    [[ level.callbackplayerdamageeffects ]]( data.idamage, undefined, data.eattacker, data.evictim, data.smeansofdeath, data.vpoint, data.lightarmordamage, data.objweapon, data.shitloc );
}

// Namespace callbacksetup/event_1e73235e5ccb5b99
// Params 1, eflags: 0x20
// Checksum 0x533e1f2f, Offset: 0x816
// Size: 0x9f
function event_handler[event_1e73235e5ccb5b99] function_1e73235e5ccb5b99( data )
{
    self endon( #"disconnect" );
    objoldweapon = data.oldweapon;
    objnewweapon = data.newweapon;
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( objoldweapon );
        [[ level.weaponmapfunc ]]( objnewweapon );
    }
    
    if ( isdefined( level.callbackfinishweaponchange ) )
    {
        [[ level.callbackfinishweaponchange ]]( objnewweapon, objoldweapon, objnewweapon.isalternate, objoldweapon.isalternate );
    }
}

// Namespace callbacksetup/player_impaled
// Params 1, eflags: 0x20
// Checksum 0xdd4a63c0, Offset: 0x8bd
// Size: 0xb6
function event_handler[player_impaled] player_impaled( data )
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( data.weapon );
    }
    
    [[ level.callbackplayerimpaled ]]( data.eattacker, data.weapon, data.vpointclient, data.vpoint, data.vdir, data.shitloc, data.spartname, data.var_56243ba4fafee4a5, data.var_ea333e2537a8fa73, data.var_2e6727b4a3db5100 );
}

// Namespace callbacksetup/player_launched
// Params 1, eflags: 0x20
// Checksum 0x4418c798, Offset: 0x97b
// Size: 0x80
function event_handler[player_launched] player_launched( data )
{
    self endon( #"disconnect" );
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        [[ level.weaponmapfunc ]]( data.weapon );
    }
    
    [[ level.var_8f62eac141f8bdb6 ]]( data.eattacker, data.weapon, data.vdir, data.magnitude, data.shitloc, 0 );
}

// Namespace callbacksetup/player_killed
// Params 1, eflags: 0x20
// Checksum 0x862287af, Offset: 0xa03
// Size: 0xc7
function event_handler[player_killed] player_killed( data )
{
    self endon( #"disconnect" );
    objweapon = data.objweapon;
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, data.einflictor );
    }
    
    [[ level.callbackplayerkilled ]]( data.einflictor, data.eattacker, data.idamage, data.idflags, data.smeansofdeath, objweapon, data.vdir, data.shitloc, data.timeoffset, data.deathanimduration );
}

// Namespace callbacksetup/vehicle_damage
// Params 1, eflags: 0x20
// Checksum 0xc74616bb, Offset: 0xad2
// Size: 0x278
function event_handler[vehicle_damage] vehicle_damage( data )
{
    partname = vehicle::function_d88b357b027cbaed( data.partname );
    attachtagname = vehicle::function_d88b357b027cbaed( data.attachtagname );
    inflictor = data.inflictor;
    attacker = data.attacker;
    damage = data.damage;
    dflags = data.dflags;
    meansofdeath = data.meansofdeath;
    objweapon = data.objweapon;
    point = data.point;
    dir = data.dir;
    hitloc = data.hitloc;
    timeoffset = data.timeoffset;
    modelindex = data.modelindex;
    eventid = data.eventid;
    
    if ( isdefined( self.nullownerdamagefunc ) )
    {
        nulldamage = [[ self.nullownerdamagefunc ]]( attacker );
        
        if ( nulldamage )
        {
            return;
        }
    }
    
    if ( isdefined( level.weaponmapfunc ) )
    {
        objweapon = [[ level.weaponmapfunc ]]( objweapon, inflictor );
    }
    
    if ( isdefined( self.var_20cb8f4e47f3353e ) )
    {
        damage = damage_tuning::getmodifieddamageusingdamagetuning( attacker, objweapon, meansofdeath, damage, self.maxhealth, self.var_20cb8f4e47f3353e, { #iskillstreak:self.iskillstreak, #inflictor:inflictor } );
    }
    
    if ( isdefined( self.damagecallback ) )
    {
        self [[ self.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
        return;
    }
    
    if ( isdefined( level.vehicles ) && isdefined( level.vehicles.damagecallback ) && isdefined( self.vehiclename ) )
    {
        self [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
        return;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname );
}

// Namespace callbacksetup
// Params 10
// Checksum 0xdce37822, Offset: 0xd52
// Size: 0x115
function codecallback_playerlaststand( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, idflags )
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.perks[ "specialty_pistoldeath" ] ) || isdefined( self.perks[ "specialty_survivor" ] ) || level.var_28e3415171f7169b || self.var_bce8e0615c3c4ecf )
    {
        if ( isdefined( level.weaponmapfunc ) )
        {
            [[ level.weaponmapfunc ]]( objweapon, einflictor );
        }
        
        return [[ level.callbackplayerlaststand ]]( einflictor, eattacker, idamage, idflags ?? 0, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration );
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.team ) )
    {
        level notify( "down_enemy_laststand_" + eattacker.team, eattacker, self );
    }
    
    return 0;
}

// Namespace callbacksetup/spawn_points_precalc
// Params 1, eflags: 0x20
// Checksum 0x39fbfa56, Offset: 0xe6f
// Size: 0x30
function event_handler[spawn_points_precalc] spawn_points_precalc( data )
{
    if ( isdefined( level.callbackspawnpointprecalc ) )
    {
        [[ level.callbackspawnpointprecalc ]]( data.team );
    }
}

// Namespace callbacksetup
// Params 3
// Checksum 0x4270565d, Offset: 0xea7
// Size: 0x40
function codecallback_spawnpointscore( player, spawnpoint, team )
{
    if ( isdefined( level.callbackspawnpointscore ) )
    {
        return player [[ level.callbackspawnpointscore ]]( spawnpoint, team );
    }
    
    return 0;
}

// Namespace callbacksetup
// Params 3
// Checksum 0xa51b0b95, Offset: 0xef0
// Size: 0x77
function codecallback_spawnpointcritscore( player, spawnpoint, team )
{
    result = "primary";
    
    if ( isdefined( level.callbackspawnpointcritscore ) )
    {
        result = player [[ level.callbackspawnpointcritscore ]]( spawnpoint, team );
    }
    
    if ( result == "primary" )
    {
        return 100;
    }
    else if ( result == "secondary" )
    {
        return 50;
    }
    
    return 0;
}

// Namespace callbacksetup/player_migrated
// Params 1, eflags: 0x20
// Checksum 0xf3a890c0, Offset: 0xf70
// Size: 0x24
function event_handler[player_migrated] player_migrated( data )
{
    self endon( #"disconnect" );
    [[ level.callbackplayermigrated ]]();
}

// Namespace callbacksetup/host_migration
// Params 1, eflags: 0x20
// Checksum 0xc7462abf, Offset: 0xf9c
// Size: 0x18
function event_handler[host_migration] host_migration( data )
{
    [[ level.callbackhostmigration ]]();
}

// Namespace callbacksetup/player_connect_rejoin
// Params 1, eflags: 0x20
// Checksum 0x68714c50, Offset: 0xfbc
// Size: 0x44
function event_handler[player_connect_rejoin] player_connect_rejoin( data )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        level waittill( #"eternity" );
    }
    
    self endon( #"disconnect" );
    [[ level.var_4524771918fe585f ]]();
}

// Namespace callbacksetup/event_e3c92c691d06984c
// Params 1, eflags: 0x20
// Checksum 0x26ae470a, Offset: 0x1008
// Size: 0x2f
function event_handler[event_e3c92c691d06984c] function_e3c92c691d06984c( data )
{
    self notify( #"hash_fdaaf8222e36fe9d" );
    [[ level.var_880cfcfec57ca836 ]]( data.reason );
}

// Namespace callbacksetup/ugc_task_complete
// Params 2, eflags: 0x20
// Checksum 0x87078d5, Offset: 0x103f
// Size: 0x25
function event_handler[ugc_task_complete] ugc_task_complete( tasktype, success )
{
    self [[ level.var_8260bd7eb144d78 ]]( tasktype, success );
}

// Namespace callbacksetup/event_72a02e80ec2737db
// Params 2, eflags: 0x20
// Checksum 0xe4281fa1, Offset: 0x106c
// Size: 0x25
function event_handler[event_72a02e80ec2737db] function_72a02e80ec2737db( achievementid, progressdata )
{
    self [[ level.var_16eab40d8f2ae445 ]]( achievementid, progressdata );
}

// Namespace callbacksetup
// Params 0
// Checksum 0x992e56fb, Offset: 0x1099
// Size: 0x43
function function_42c350929ba6a5e6()
{
    if ( !isdefined( level.autopilot ) )
    {
        return 0;
    }
    
    assert( isdefined( level.autopilot.var_c4f4308cd814658d ) );
    return [[ level.autopilot.var_c4f4308cd814658d ]]();
}

// Namespace callbacksetup/player_enter_autopilot
// Params 1, eflags: 0x20
// Checksum 0x119f522f, Offset: 0x10e5
// Size: 0x22
function event_handler[player_enter_autopilot] player_enter_autopilot( data )
{
    [[ level.autopilot.var_3564d4561f8e39f6 ]]();
}

// Namespace callbacksetup/player_exit_autopilot
// Params 1, eflags: 0x20
// Checksum 0x6b945b7d, Offset: 0x110f
// Size: 0x22
function event_handler[player_exit_autopilot] player_exit_autopilot( data )
{
    [[ level.autopilot.var_94abf03bbaf9fe40 ]]();
}

// Namespace callbacksetup
// Params 0
// Checksum 0x42a29c26, Offset: 0x1139
// Size: 0xd5
function abortlevel()
{
    println( "<dev string:x1e5>" );
    level.callbackstartgametype = &callbackvoid;
    level.callbackplayeractive = &callbackvoid;
    level.callbackplayerconnect = &callbackvoid;
    level.callbackplayerdisconnect = &callbackvoid;
    level.callbackplayerdamage = &callbackvoid;
    level.callbackplayerimpaled = &callbackvoid;
    level.var_8f62eac141f8bdb6 = &callbackvoid;
    level.callbackplayerkilled = &callbackvoid;
    level.callbackplayerlaststand = &callbackvoid;
    level.callbackplayermigrated = &callbackvoid;
    level.callbackhostmigration = &callbackvoid;
    level.var_4524771918fe585f = &callbackvoid;
    level.var_880cfcfec57ca836 = &callbackvoid;
    level.gametype = undefined;
    exitlevel( 0 );
}

// Namespace callbacksetup
// Params 0
// Checksum 0x655330b0, Offset: 0x1216
// Size: 0x2
function callbackvoid()
{
    
}

// Namespace callbacksetup
// Params 0
// Checksum 0xa35b98bb, Offset: 0x1220
// Size: 0x2
function function_62798d1a2c45f983()
{
    
}

