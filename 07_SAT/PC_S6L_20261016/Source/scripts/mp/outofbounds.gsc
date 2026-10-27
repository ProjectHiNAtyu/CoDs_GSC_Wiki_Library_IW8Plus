// scripts\mp\outofbounds.gsc  (hash_125e1de662c614bc.gscc) (size: 19497 Bytes / 0x4c29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8036c70a (2151073546)
// size ...... 19497 (0x4c29)
// includes .. 17  (offset: 0x48fd)
// strings ... 39  (offset: 0x4985)
// dev strs .. 5   (offset: 0x4bed)
// exports ... 66  (offset: 0x2f19)
// cseg ...... 0x354 + 0x2bc5 (0x2f19)
// imports ... 127 (offset: 0x3969)
// animtree1 . 0   (offset: 0x4c29)
// animtree2 . 0   (offset: 0x4c29)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\game_utility_mp;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;

#namespace outofbounds;

// Namespace outofbounds
// Params 2
// Checksum 0x1fcf866a, Offset: 0x372
// Size: 0x4e
function registerentforoob( ent, ref )
{
    ent.oobref = ref;
    
    /#
        ignoreoob = getdvarint( @"scr_ignore_oob", 0 );
        
        if ( ignoreoob )
        {
            enableoobimmunity( ent );
        }
    #/
}

// Namespace outofbounds
// Params 0
// Checksum 0xfcce4d70, Offset: 0x3c8
// Size: 0x1b
function function_676cf3ab5a90bec2()
{
    assert( self != level );
    self.var_99191a90df859498 = "VTOL_OutOfBounds";
}

// Namespace outofbounds
// Params 0
// Checksum 0x2a11860a, Offset: 0x3eb
// Size: 0x1b
function function_4cb3ccaabd7eedf9()
{
    assert( self != level );
    self.var_99191a90df859498 = "Drone_OutOfBounds";
}

// Namespace outofbounds
// Params 1
// Checksum 0x16a38233, Offset: 0x40e
// Size: 0x17
function deregisterentforoob( ent )
{
    ent.oobref = undefined;
}

// Namespace outofbounds
// Params 2
// Checksum 0x8ef91b77, Offset: 0x42d
// Size: 0x37
function registeroobentercallback( ref, callback )
{
    struct = getoobdata();
    struct.entercallbacks[ ref ] = callback;
}

// Namespace outofbounds
// Params 2
// Checksum 0xab7bdd8c, Offset: 0x46c
// Size: 0x37
function registeroobexitcallback( ref, callback )
{
    struct = getoobdata();
    struct.exitcallbacks[ ref ] = callback;
}

// Namespace outofbounds
// Params 2
// Checksum 0x347d097e, Offset: 0x4ab
// Size: 0x37
function registerooboutoftimecallback( ref, callback )
{
    struct = getoobdata();
    struct.outoftimecallbacks[ ref ] = callback;
}

// Namespace outofbounds
// Params 2
// Checksum 0x1b4ecda8, Offset: 0x4ea
// Size: 0x37
function registeroobclearcallback( ref, callback )
{
    struct = getoobdata();
    struct.clearcallbacks[ ref ] = callback;
}

// Namespace outofbounds
// Params 2
// Checksum 0x39b0e0d, Offset: 0x529
// Size: 0x42, Type: bool
function isoob( ent, var_68a6985a3d87d31b )
{
    if ( isoobimmune( ent ) )
    {
        return false;
    }
    
    if ( var_68a6985a3d87d31b && isoobimmune( ent ) )
    {
        return false;
    }
    
    return ent.oob > 0;
}

// Namespace outofbounds
// Params 1
// Checksum 0xaf1096f6, Offset: 0x574
// Size: 0x7c
function enableoob( ent )
{
    if ( !isdefined( ent.oob ) )
    {
        ent.oob = 0;
    }
    
    ent.oob++;
    
    if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
    {
        onenteroob( ent );
    }
    
    if ( isdefined( ent.ontouchoob ) )
    {
        [[ ent.ontouchoob ]]( ent );
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x947eb74a, Offset: 0x5f8
// Size: 0xa2
function disableoob( ent )
{
    if ( !isdefined( ent.oob ) )
    {
        return;
    }
    
    assert( isdefined( ent.oob ), "<dev string:x24>" );
    assert( ent.oob > 0, "<dev string:x5f>" );
    ent.oob--;
    
    if ( ent.oob == 0 )
    {
        ent.oob = undefined;
    }
    
    if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
    {
        onexitoob( ent, 0 );
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x8e8a5cb5, Offset: 0x6a2
// Size: 0x19, Type: bool
function isoobimmune( ent )
{
    return ent.oobimmunity > 0;
}

// Namespace outofbounds
// Params 1
// Checksum 0x10ae7406, Offset: 0x6c4
// Size: 0x5e
function enableoobimmunity( ent )
{
    if ( !isdefined( ent.oobimmunity ) )
    {
        ent.oobimmunity = 0;
    }
    
    ent.oobimmunity++;
    
    if ( ent.oobimmunity == 1 )
    {
        if ( ent.oob > 0 )
        {
            onexitoob( ent, 0 );
        }
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0xd26c4c36, Offset: 0x72a
// Size: 0x7f
function disableoobimmunity( ent )
{
    assert( isdefined( ent.oobimmunity ), "<dev string:x85>" );
    assert( ent.oobimmunity > 0, "<dev string:xcc>" );
    ent.oobimmunity--;
    
    if ( ent.oobimmunity == 0 )
    {
        ent.oobimmunity = undefined;
        
        if ( ent.oob > 0 )
        {
            onenteroob( ent );
        }
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0xad1de228, Offset: 0x7b1
// Size: 0x55
function function_9aa3ce7806e04201( ent )
{
    if ( !isdefined( ent.oobimmunity ) )
    {
        return;
    }
    
    var_8ae6212bb5e68817 = ent.oobimmunity;
    
    for ( i = 0; i < var_8ae6212bb5e68817 ; i++ )
    {
        disableoobimmunity( ent );
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x68b8ac7d, Offset: 0x80e
// Size: 0x21c
function clearoob( ent, fromdeath )
{
    ent notify( #"clear_oob" );
    
    if ( isoob( ent, 1 ) )
    {
        onexitoob( ent, fromdeath, 1 );
    }
    
    clearcallback = undefined;
    
    if ( isplayer( ent ) )
    {
        clearcallback = &playerclearcallback;
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        clearcallback = struct.clearcallbacks[ ent.oobref ];
    }
    
    if ( isdefined( clearcallback ) )
    {
        ent [[ clearcallback ]]();
    }
    
    ent.oobref = undefined;
    ent.oob = undefined;
    ent.oobimmunity = undefined;
    ent.oobtimeleft = undefined;
    ent.oobendtime = undefined;
    ent.oobtriggertype = undefined;
    ent.oobtype = undefined;
    
    if ( isdefined( ent.oobtriggers ) )
    {
        foreach ( trigger in ent.oobtriggers )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.oobtriggers = undefined;
    }
    
    if ( isdefined( ent.oobsupressiontriggers ) )
    {
        foreach ( trigger in ent.oobsupressiontriggers )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.oobsupressiontriggers = undefined;
    }
}

// Namespace outofbounds
// Params 0
// Checksum 0x2f108a7a, Offset: 0xa32
// Size: 0xce, Type: bool
function istouchingoobtrigger()
{
    if ( isdefined( level.var_a4c5ebbd12c68ae2 ) && self [[ level.var_a4c5ebbd12c68ae2 ]]() )
    {
        return true;
    }
    
    if ( self.allowedintrigger )
    {
        return false;
    }
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return false;
    }
    
    foreach ( trigger in level.outofboundstriggers )
    {
        if ( !interactswithgivenoobtrigger( trigger, self ) )
        {
            continue;
        }
        
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outofbounds
// Params 2
// Checksum 0x1d97d5e9, Offset: 0xb09
// Size: 0x55
function ispointinoutofbounds( pointtocheck, teamtocheck )
{
    if ( isdefined( level.var_c1a620f177a2ea74 ) && [[ level.var_c1a620f177a2ea74 ]]( pointtocheck, teamtocheck ) )
    {
        return 1;
    }
    
    pointinoutofbounds = function_78602d7d56db9bf( pointtocheck, teamtocheck, level.outofboundstriggers );
    return pointinoutofbounds;
}

// Namespace outofbounds
// Params 1
// Checksum 0x5485b9e2, Offset: 0xb67
// Size: 0x45
function function_ea64b5c2bd16e0f5( trigger )
{
    if ( isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
        level notify( #"oob_triggers_changed" );
        thread watchoobtrigger( trigger );
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x247625f2, Offset: 0xbb4
// Size: 0xc6
function function_73faa310ef29036a( trigger )
{
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return;
    }
    
    level.outofboundstriggers = arrayremove( level.outofboundstriggers, trigger );
    level notify( #"oob_triggers_changed" );
    trigger notify( #"oob_removed" );
    
    foreach ( player in level.players )
    {
        onexitoobtrigger( trigger, player );
    }
}

// Namespace outofbounds
// Params 0
// Checksum 0x8a51dabb, Offset: 0xc82
// Size: 0x28
function initoob()
{
    thread watchoobtriggers();
    val::group_register( "enterOOB", [ "killstreaks", "supers" ] );
}

// Namespace outofbounds
// Params 1
// Checksum 0x23fdc092, Offset: 0xcb2
// Size: 0x398
function onenteroob( ent )
{
    var_da14dcd9a519f27f = [];
    trigger = self;
    
    if ( !isdefined( trigger ) )
    {
        trigger = self;
    }
    
    triggertype = gettriggertype( ent, trigger );
    
    if ( isplayer( ent ) )
    {
        var_da14dcd9a519f27f[ var_da14dcd9a519f27f.size ] = &playerentercallback;
    }
    
    if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        var_da14dcd9a519f27f[ var_da14dcd9a519f27f.size ] = struct.entercallbacks[ ent.oobref ];
    }
    
    ent notify( #"oob_cooldown_end" );
    
    if ( isdefined( ent.oobtimeleft ) && previouslytouchedtriggertype( ent, triggertype ) && !isdefined( ent.vehicle ) )
    {
        outofboundstime = ent.oobtimeleft / 1000;
        ent.oobendtime = int( gettime() + ent.oobtimeleft );
        ent.oobtimeleft = undefined;
        thread watchooboutoftime( ent, outofboundstime );
    }
    else
    {
        outofboundstime = undefined;
        
        if ( isdefined( ent.var_2b1659fc7a1fc9cb ) )
        {
            outofboundstime = ent.var_2b1659fc7a1fc9cb;
        }
        else if ( trigger.get_out_of_bounds_time_override )
        {
            outofboundstime = trigger [[ trigger.get_out_of_bounds_time_override ]]( ent );
        }
        else
        {
            outofboundstime = getoutofboundstime( triggertype );
        }
        
        if ( isplayer( ent ) && isdefined( ent.vehicle ) && isdefined( ent.vehicle.oobendtime ) )
        {
            outofboundstime = ( ent.vehicle.oobendtime - gettime() ) / 1000;
        }
        else if ( isdefined( ent.oobtimeleft ) )
        {
            outofboundstime = min( ent.oobtimeleft / 1000, outofboundstime );
        }
        else if ( isdefined( ent.oobendtime ) )
        {
            outofboundstime = min( ( ent.oobendtime - gettime() ) / 1000, outofboundstime );
        }
        
        ent.oobtimeleft = undefined;
        ent.oobtriggertype = triggertype;
        
        /#
            if ( getdvarint( @"hash_682dbdb70d434a29", 0 ) != 0 )
            {
                outofboundstime += getdvarint( @"hash_682dbdb70d434a29", 0 );
            }
        #/
        
        ent.oobendtime = int( gettime() + outofboundstime * 1000 );
        thread watchooboutoftime( ent, outofboundstime );
    }
    
    foreach ( cb in var_da14dcd9a519f27f )
    {
        if ( isdefined( cb ) )
        {
            ent thread [[ cb ]]( "exit_oob", "clear_oob", triggertype );
        }
    }
    
    if ( ent vehicle::is_vehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = vehicle_occupancy::get_all_occupants( ent, 0 );
        
        foreach ( occupant in occupants )
        {
            onenteroobtrigger( self, occupant );
        }
    }
}

// Namespace outofbounds
// Params 3
// Checksum 0xe9cf35fe, Offset: 0x1052
// Size: 0x23b
function onexitoob( ent, fromdeath, fromclear )
{
    trigger = self;
    ent notify( #"exit_oob" );
    exitcallback = undefined;
    
    if ( !isdefined( ent.oob ) )
    {
        ent notify( #"oob_timeout_end" );
        
        if ( isplayer( ent ) )
        {
            exitcallback = &playerexitcallback;
        }
        else if ( isdefined( ent.oobref ) )
        {
            struct = getoobdata();
            exitcallback = struct.exitcallbacks[ ent.oobref ];
        }
        
        if ( !fromclear )
        {
            if ( isdefined( ent.oobendtime ) )
            {
                ent.oobtimeleft = int( max( 0, ent.oobendtime - gettime() ) );
                ent.oobendtime = undefined;
                triggertype = gettriggertype( ent, trigger );
                
                if ( trigger.var_7e83060d607ae3ce )
                {
                    cooldowntime = trigger [[ trigger.var_7e83060d607ae3ce ]]( ent, triggertype );
                }
                else
                {
                    cooldowntime = getcooldowntime( triggertype );
                }
                
                thread watchoobcooldown( ent, cooldowntime );
            }
        }
    }
    
    if ( isdefined( exitcallback ) )
    {
        ent thread [[ exitcallback ]]( fromdeath, fromclear, "clear_oob" );
    }
    
    if ( ent vehicle::is_vehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = vehicle_occupancy::get_all_occupants( ent, 0 );
        
        foreach ( occupant in occupants )
        {
            if ( isdefined( occupant ) )
            {
                onexitoobtrigger( trigger, occupant );
            }
        }
    }
    
    level callback::callback( #"on_exit_oob", { #fromclear:fromclear, #fromdeath:fromdeath, #trigger:trigger, #ent:ent } );
}

// Namespace outofbounds
// Params 1
// Checksum 0xbc214269, Offset: 0x1295
// Size: 0x113
function onooboutoftime( ent )
{
    outoftimecallback = undefined;
    
    if ( isplayer( ent ) )
    {
        var_b6885bdd4baa8ce2 = 1;
        
        if ( isbrgamemode() )
        {
            if ( level.infilcinematicactive )
            {
                var_b6885bdd4baa8ce2 = 0;
            }
            else if ( level.matchcountdowntime < 2 )
            {
                var_b6885bdd4baa8ce2 = 0;
            }
        }
        
        if ( var_b6885bdd4baa8ce2 )
        {
            if ( isdefined( level.var_d1e3e0e075671fee ) )
            {
                outoftimecallback = level.var_d1e3e0e075671fee;
            }
            else
            {
                outoftimecallback = &playeroutoftimecallback;
            }
        }
    }
    
    if ( ent vehicle::is_vehicle() )
    {
        ref = ent vehicle::get_ref();
        
        if ( utility::issharedfuncdefined( ref, #"hash_3365a912c11d2ba0" ) )
        {
            ent utility::callsharedfunc( ref, #"hash_3365a912c11d2ba0" );
            return;
        }
    }
    
    if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        outoftimecallback = struct.outoftimecallbacks[ ent.oobref ];
    }
    
    if ( isdefined( outoftimecallback ) )
    {
        ent thread [[ outoftimecallback ]]( "oob_timeout_end", "clear_oob" );
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x8d2e62ac, Offset: 0x13b0
// Size: 0x9d
function watchooboutoftime( ent, timeleft )
{
    if ( isplayer( ent ) )
    {
        ent endon( #"death_or_disconnect" );
    }
    else
    {
        ent endon( #"death" );
    }
    
    ent notify( #"oob_timeout_end" );
    ent endon( #"oob_timeout_end" );
    ent endon( #"clear_oob" );
    wait max( 0, timeleft );
    
    if ( isplayer( ent ) )
    {
        logstring( "[OOB] watchOOBOutOfTime EXPIRING: " + ent.name + " | time=" + gettime() );
    }
    
    thread onooboutoftime( ent );
}

// Namespace outofbounds
// Params 2
// Checksum 0x76689420, Offset: 0x1455
// Size: 0x7b
function watchoobcooldown( ent, timeleft )
{
    if ( isplayer( ent ) )
    {
        ent endon( #"death_or_disconnect" );
    }
    else
    {
        ent endon( #"death" );
    }
    
    ent notify( #"oob_cooldown_end" );
    ent endon( #"oob_cooldown_end" );
    ent endon( #"clear_oob" );
    wait timeleft;
    ent.oobtimeleft = undefined;
    ent.oobtriggertype = undefined;
}

// Namespace outofbounds
// Params 3
// Checksum 0x30e00c1c, Offset: 0x14d8
// Size: 0xaf
function playerentercallback( exitnotify, clearnotify, triggertype )
{
    var_6965ef9712a0fc8d = function_2af2589fd93e7c26( triggertype );
    self.oobtype = var_6965ef9712a0fc8d;
    self setclientomnvar( "ui_out_of_bounds_type", var_6965ef9712a0fc8d );
    self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    val::group_set( "enterOOB", 0 );
    
    if ( isdefined( self.offhandweapon ) && self isthrowinggrenade() && weapon::issuperweapon( self.offhandweapon ) )
    {
        self canceloffhands();
    }
    
    if ( !isdefined( self.vehicle ) )
    {
        thread function_6d47eb1641919040();
    }
}

// Namespace outofbounds
// Params 3
// Checksum 0xb82c2d66, Offset: 0x158f
// Size: 0x58
function playerexitcallback( fromdeath, fromclear, clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    val::group_reset( "enterOOB" );
    
    if ( self.var_65c6b1940f2e9d1f )
    {
        self.var_65c6b1940f2e9d1f = undefined;
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0xbc91bfa4, Offset: 0x15ef
// Size: 0xe3
function playeroutoftimecallback( timeoutendnotify, clearnotify )
{
    trigger = getlastoobtrigger( self );
    triggertype = gettriggertype( self, trigger );
    
    if ( triggertype == "minefield" )
    {
        thread playeroutoftimeminefield( timeoutendnotify, clearnotify );
        return;
    }
    
    if ( self.isjuggernaut && self.var_dc35d76e762774ed )
    {
        damagedata = spawnstruct();
        damagedata.damageflags = 2097152;
        damagedata.instantdeath = 1;
        utility::callsharedfunc( #"player", #"hash_896c9a2df0338ae3", damagedata );
        clearoob( self );
        return;
    }
    
    self.oobdeath = 1;
    damage::_suicide( undefined, 1, 2097152 );
    self.oobdeath = undefined;
}

// Namespace outofbounds
// Params 1
// Checksum 0x92e74cde, Offset: 0x16da
// Size: 0x30
function playerclearcallback( clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    val::group_reset( "enterOOB" );
}

// Namespace outofbounds
// Params 2
// Checksum 0x4f525ce6, Offset: 0x1712
// Size: 0xe6
function playeroutoftimeminefield( timeoutendnotify, clearnotify )
{
    minespawnpos = self.origin;
    minetrace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 1000 ), self );
    
    if ( isdefined( minetrace[ "hittype" ] != "hittype_none" ) && isdefined( minetrace[ "position" ] ) )
    {
        minespawnpos = minetrace[ "position" ];
    }
    
    mine = spawn( "script_model", minespawnpos );
    mine setmodel( "ks_minefield_mp" );
    mine setentityowner( self );
    mine setotherent( self );
    mine setscriptablepartstate( "warning_click", "on", 0 );
    mineexploded = playeroutoftimeminefieldinternal( mine, timeoutendnotify, clearnotify );
    
    if ( mineexploded )
    {
        wait 2;
    }
    
    mine delete();
}

// Namespace outofbounds
// Params 3
// Checksum 0xfeb96b2f, Offset: 0x1800
// Size: 0x8c, Type: bool
function playeroutoftimeminefieldinternal( mine, timeoutendnotify, clearnotify )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( timeoutendnotify ) )
    {
        self endon( timeoutendnotify );
    }
    
    if ( isdefined( clearnotify ) )
    {
        self endon( clearnotify );
    }
    
    hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    mine setscriptablepartstate( "explosion", "on", 0 );
    wait 0.05;
    self dodamage( 2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp", undefined, undefined, 2097152 );
    return true;
}

// Namespace outofbounds
// Params 0
// Checksum 0x9780eb23, Offset: 0x1895
// Size: 0x55
function function_6d47eb1641919040()
{
    self endon( #"death_or_disconnect" );
    self endon( #"exit_oob" );
    self waittill( #"vehicle_enter" );
    
    if ( isdefined( self.vehicle ) && !vehicle::function_72ad20c452340b5c( self.vehicle, 1 ) )
    {
        self.var_65c6b1940f2e9d1f = 1;
    }
}

// Namespace outofbounds
// Params 0
// Checksum 0xd0d344b0, Offset: 0x18f2
// Size: 0x89
function checkinvalidoobtriggers()
{
    foreach ( trigger in self.oobtriggers )
    {
        if ( !function_eb469d67f092a59c( self, trigger ) )
        {
            onexitoobtrigger( trigger, self );
        }
    }
}

// Namespace outofbounds
// Params 3
// Checksum 0x72821b38, Offset: 0x1983
// Size: 0x88
function killstreakentercallback( exitnotify, clearnotify, triggertype )
{
    var_6965ef9712a0fc8d = function_2af2589fd93e7c26( triggertype );
    self.oobtype = var_6965ef9712a0fc8d;
    
    if ( isdefined( self.owner ) && self.ispiloted )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", var_6965ef9712a0fc8d );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    }
}

// Namespace outofbounds
// Params 3
// Checksum 0xc7a00c50, Offset: 0x1a13
// Size: 0x60
function killstreakexitcallback( fromdeath, fromclear, clearnotify )
{
    if ( isdefined( self.owner ) && self.ispiloted )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x3b86b388, Offset: 0x1a7b
// Size: 0x4a
function killstreakoutoftimecallback( timeoutendnotify, clearnotify )
{
    clearoob( self, 1 );
    killstreak::dodamagetokillstreak( 10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE" );
}

// Namespace outofbounds
// Params 0
// Checksum 0x7efa75f1, Offset: 0x1acd
// Size: 0x44
function killstreakclearcallback()
{
    if ( isdefined( self.owner ) && self.ispiloted )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace outofbounds
// Params 0
// Checksum 0x47f62a07, Offset: 0x1b19
// Size: 0x46
function killstreakregisteroobcallbacks()
{
    registeroobentercallback( "killstreak", &killstreakentercallback );
    registeroobexitcallback( "killstreak", &killstreakexitcallback );
    registerooboutoftimecallback( "killstreak", &killstreakoutoftimecallback );
    registeroobclearcallback( "killstreak", &killstreakclearcallback );
}

// Namespace outofbounds
// Params 0
// Checksum 0xdd300cae, Offset: 0x1b67
// Size: 0x209
function watchoobtriggers()
{
    if ( game_utility_mp::lpcfeaturegated() && !game_utility_mp::function_486a77b9c5d2bd09() && !isbrgamemode() && !isdmzgamemode() )
    {
        return;
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            thread watchoobtrigger( trigger );
        }
        
        if ( isdefined( level.outofboundstriggerpatches ) )
        {
            foreach ( trigger in level.outofboundstriggerpatches )
            {
                thread watchoobsuppressiontrigger( trigger );
            }
        }
    }
    
    foreach ( trigger in level.var_750dbf45607817fd )
    {
        thread watchoobtrigger( trigger );
    }
    
    foreach ( trigger in level.var_f11fa8013d4e241c )
    {
        thread watchoobtrigger( trigger );
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x2159539f, Offset: 0x1d78
// Size: 0x3f
function watchoobtrigger( trigger )
{
    trigger.entstouching = [];
    
    if ( !isbrgamemode() )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    thread watchoobtriggerexit( trigger );
    thread watchoobtriggerenter( trigger );
}

// Namespace outofbounds
// Params 1
// Checksum 0x73285470, Offset: 0x1dbf
// Size: 0x7d
function watchoobtriggerenter( trigger )
{
    level endon( #"game_ended" );
    level endon( #"switch_oob" );
    trigger endon( #"oob_removed" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !function_eb469d67f092a59c( ent, trigger ) && !ent.var_4dcb2fffc1cc639f )
        {
            continue;
        }
        
        onenteroobtrigger( trigger, ent );
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x44fab5d7, Offset: 0x1e44
// Size: 0xc1, Type: bool
function function_eb469d67f092a59c( ent, trigger )
{
    if ( trigger.isdisabled )
    {
        return false;
    }
    
    triggertargetname = level.var_b7c2a92ffb41344 ? level.var_b7c2a92ffb41344 : "OutOfBounds";
    
    if ( trigger.targetname != triggertargetname )
    {
        if ( ent.var_99191a90df859498 )
        {
            return ( ent.var_99191a90df859498 == trigger.targetname );
        }
        
        return false;
    }
    
    if ( isplayer( ent ) && isdefined( ent.c130 ) )
    {
        return false;
    }
    
    if ( !interactswithgivenoobtrigger( trigger, ent ) )
    {
        return false;
    }
    
    if ( !interactswithoobtriggers( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace outofbounds
// Params 1
// Checksum 0x12cbf77b, Offset: 0x1f0e
// Size: 0x184
function watchoobtriggerexit( trigger )
{
    level endon( #"game_ended" );
    level endon( #"switch_oob" );
    trigger endon( #"oob_removed" );
    var_311969b342f4e437 = isent( trigger );
    
    while ( true )
    {
        if ( !isarray( trigger.entstouching ) )
        {
            return;
        }
        
        if ( trigger.entstouching.size == 0 )
        {
            waitframe();
            continue;
        }
        
        temparr = trigger.entstouching;
        
        foreach ( id, ent in temparr )
        {
            if ( !isdefined( ent ) )
            {
                trigger.entstouching[ id ] = undefined;
            }
            
            var_49d8138e771c9d0e = 0;
            
            if ( isdefined( ent.vehicle ) )
            {
                occupants = vehicle_occupancy::get_all_occupants( ent.vehicle, 0 );
                var_49d8138e771c9d0e = isarray( occupants ) && arraycontains( occupants, ent );
            }
            
            if ( isdefined( ent ) && ( ent.var_65c6b1940f2e9d1f || !trigger istouchingtrigger( ent, var_311969b342f4e437 ) && !var_49d8138e771c9d0e ) )
            {
                onexitoobtrigger( trigger, ent );
            }
        }
        
        waitframe();
    }
}

// Namespace outofbounds
// Params 2, eflags: 0x4
// Checksum 0x33f324a3, Offset: 0x209a
// Size: 0x3d, Type: bool
function private istouchingtrigger( ent, var_93bd913a023ad8d5 )
{
    return var_93bd913a023ad8d5 && self istouching( ent ) || !var_93bd913a023ad8d5 && ispointinvolume( ent.origin, self );
}

// Namespace outofbounds
// Params 3
// Checksum 0x7d009ff7, Offset: 0x20e0
// Size: 0xdd
function onenteroobtrigger( trigger, ent, forceentry )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) && !forceentry )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.oobtriggers ) )
    {
        ent.oobtriggers = [];
    }
    
    ent.oobtriggers = arraycombine( [ trigger ], ent.oobtriggers );
    trigger enableoob( ent );
    
    if ( isplayer( ent ) )
    {
        logstring( "[OOB] onEnterOOBTrigger: " + ent.name + " | oobImmunity=" + ent.oobimmunity + " | time=" + gettime() );
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x66da1da6, Offset: 0x21c5
// Size: 0x91
function onexitoobtrigger( trigger, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    trigger disableoob( ent );
    
    if ( !isdefined( ent.oobtriggers ) )
    {
        return;
    }
    
    ent.oobtriggers = arrayremove( ent.oobtriggers, trigger );
    
    if ( ent.oobtriggers.size == 0 )
    {
        ent.oobtriggers = undefined;
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x8a720e0, Offset: 0x225e
// Size: 0x37
function watchoobsuppressiontrigger( trigger )
{
    trigger.entstouching = [];
    flags::gameflagwait( "prematch_done" );
    thread watchoobsuppressiontriggerexit( trigger );
    thread watchoobsupressiontriggerenter( trigger );
}

// Namespace outofbounds
// Params 1
// Checksum 0xa58cf84a, Offset: 0x229d
// Size: 0x53
function watchoobsupressiontriggerenter( trigger )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !interactswithoobtriggers( ent ) )
        {
            continue;
        }
        
        onenteroobsuppressiontrigger( trigger, ent );
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0x484d33ee, Offset: 0x22f8
// Size: 0xd6
function watchoobsuppressiontriggerexit( trigger )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        if ( isdefined( temparr ) )
        {
            foreach ( id, ent in temparr )
            {
                if ( !isdefined( ent ) )
                {
                    trigger.entstouching[ id ] = undefined;
                }
                
                if ( isdefined( ent ) && !trigger istouching( ent ) )
                {
                    onexitoobsupressiontrigger( trigger, ent );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x2a65f7e0, Offset: 0x23d6
// Size: 0x104
function onenteroobsuppressiontrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.oobsupressiontriggers ) )
    {
        ent.oobsupressiontriggers = [];
    }
    
    temparr = [ trigger ];
    
    foreach ( oobsuppressiontrigger in ent.oobsupressiontriggers )
    {
        temparr[ temparr.size ] = oobsuppressiontrigger;
    }
    
    ent.oobsupressiontriggers = temparr;
    enableoobimmunity( ent );
}

// Namespace outofbounds
// Params 2
// Checksum 0xb5ca71bc, Offset: 0x24e2
// Size: 0x6c
function onexitoobsupressiontrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    ent.oobsupressiontriggers[ trigger getentitynumber() ] = undefined;
    
    if ( ent.oobsupressiontriggers.size == 0 )
    {
        ent.oobsupressiontriggers = undefined;
    }
    
    disableoobimmunity( ent );
}

// Namespace outofbounds
// Params 2
// Checksum 0xc9f56dd1, Offset: 0x2556
// Size: 0x259, Type: bool
function interactswithgivenoobtrigger( trigger, ent )
{
    isvehicle = ent vehicle::is_vehicle();
    
    if ( trigger.var_91ce3dd12a4d9e22 )
    {
        if ( !trigger [[ trigger.var_91ce3dd12a4d9e22 ]]( ent ) )
        {
            return false;
        }
    }
    
    if ( isdefined( trigger.script_team ) )
    {
        if ( game_utility_mp::isgroundwarcoremode() || level.ignoreteamoob )
        {
            return false;
        }
        
        relevantteam = game[ "switchedsides" ] ? team_utility::getotherteam( trigger.script_team ) : trigger.script_team;
        
        if ( isvehicle )
        {
            if ( isdefined( ent.team ) && ent.team != "neutral" && ent.team != relevantteam )
            {
                return false;
            }
            
            if ( isdefined( ent.owner ) && ent.owner.team != relevantteam )
            {
                return false;
            }
            
            if ( isdefined( ent.occupants ) )
            {
                foreach ( occupant in ent.occupants )
                {
                    if ( isdefined( occupant.team ) && occupant.team != relevantteam )
                    {
                        return false;
                    }
                }
            }
        }
        else if ( ent.team != relevantteam )
        {
            return false;
        }
    }
    
    if ( isvehicle )
    {
        ref = ent vehicle::get_ref();
        
        if ( vehicle::has_data( ref ) && vehicle::get_data( ref ).damage.ignoreoob )
        {
            return false;
        }
        
        if ( utility::issharedfuncdefined( ref, #"interactswithoobtrigger" ) )
        {
            if ( !utility::callsharedfunc( ref, #"interactswithoobtrigger", trigger, ent ) )
            {
                return false;
            }
        }
    }
    
    if ( trigger.script_noteworthy == "onlyVehOOB" )
    {
        if ( !isvehicle )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace outofbounds
// Params 1
// Checksum 0x4a211a02, Offset: 0x27b8
// Size: 0x98, Type: bool
function interactswithoobtriggers( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isplayer( ent ) )
        {
            if ( ent player::isreallyalive() && ent val::get( "interacts_with_oob_triggers" ) )
            {
                return true;
            }
        }
        
        if ( isdefined( ent.oobref ) )
        {
            if ( ent vehicle::is_vehicle() )
            {
                if ( !ent.isdestroyed )
                {
                    return true;
                }
            }
            
            if ( isdefined( ent.streakinfo ) && iskillstreakaffectedbyobb( ent.streakinfo.streakname ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace outofbounds
// Params 0
// Checksum 0x55855931, Offset: 0x2859
// Size: 0x65
function getoobdata()
{
    struct = level.oobdata;
    
    if ( !isdefined( struct ) )
    {
        struct = spawnstruct();
        struct.entercallbacks = [];
        struct.exitcallbacks = [];
        struct.outoftimecallbacks = [];
        struct.clearcallbacks = [];
        level.oobdata = struct;
    }
    
    return struct;
}

// Namespace outofbounds
// Params 1
// Checksum 0x7319a9ac, Offset: 0x28c7
// Size: 0x5c
function iskillstreakaffectedbyobb( streakname )
{
    affectedbyobb = 0;
    
    switch ( streakname )
    {
        case #"hash_8ef5b52c9e784884":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            affectedbyobb = 1;
            break;
    }
    
    return affectedbyobb;
}

// Namespace outofbounds
// Params 2
// Checksum 0x8bc64b6c, Offset: 0x292c
// Size: 0x108
function gettriggertype( ent, trigger )
{
    triggertype = "default";
    
    if ( getdvarint( @"hash_ccf33384cae119ae", 0 ) && !trigger )
    {
        return "default";
    }
    
    if ( trigger.targetname == "Drone_OutOfBounds" )
    {
        return "Drone_OutOfBounds";
    }
    
    if ( trigger.targetname == "VTOL_OutOfBounds" )
    {
        return "VTOL_OutOfBounds";
    }
    
    if ( trigger vehicle::is_vehicle() )
    {
        return "vehicle";
    }
    
    if ( isbrgamemode() )
    {
        return "br";
    }
    
    if ( isdefined( trigger ) && isdefined( trigger.script_team ) )
    {
        return "restricted";
    }
    
    if ( isdefined( ent ) && ent vehicle::is_vehicle() )
    {
        return "default";
    }
    
    if ( isdefined( ent ) && isdefined( ent.streakinfo ) )
    {
        return "default";
    }
    
    if ( isdefined( trigger ) && trigger.script_noteworthy == "MineField" )
    {
        triggertype = "minefield";
    }
    
    return triggertype;
}

// Namespace outofbounds
// Params 1, eflags: 0x4
// Checksum 0xeae73cff, Offset: 0x2a3d
// Size: 0xb5
function private function_2af2589fd93e7c26( triggertype )
{
    oobtype = 1;
    var_73f17b05ab4c76ac = 0;
    
    if ( level.var_73f17b05ab4c76ac )
    {
        var_73f17b05ab4c76ac = 1;
    }
    else if ( game_utility::islargemap() )
    {
        gametype = game_utility::getgametype();
        
        switch ( gametype )
        {
            case #"hash_ca6516c10db2c95":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
                var_73f17b05ab4c76ac = 1;
                break;
        }
        
        if ( game_utility_mp::isgroundwarcoremode() )
        {
            var_73f17b05ab4c76ac = 1;
        }
    }
    
    if ( var_73f17b05ab4c76ac )
    {
        if ( triggertype == "restricted" )
        {
            oobtype = 2;
        }
    }
    
    return oobtype;
}

// Namespace outofbounds
// Params 1
// Checksum 0xf4112b33, Offset: 0x2afb
// Size: 0x81
function getcooldowntime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_18ad1d5da2e56d4c":
        case #"hash_2bec602136ef613a":
        case #"hash_4ef2abae46004697":
        case #"hash_6b15362474c2e2b2":
        case #"hash_7038dec66d8275be":
        case #"hash_b9c0ff6cd406fe0f":
        case #"hash_fa21c4f6bd5e3815":
            return game_utility_mp::getmaxoutofboundscooldown();
    }
    
    assertmsg( "<dev string:x102>" + triggertype );
}

// Namespace outofbounds
// Params 1
// Checksum 0x5456c783, Offset: 0x2b84
// Size: 0x9b
function getoutofboundstime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_6b15362474c2e2b2":
            return game_utility_mp::getmaxoutofboundsminefieldtime();
        case #"hash_18ad1d5da2e56d4c":
            return game_utility_mp::getmaxoutofboundsrestrictedtime();
        case #"hash_fa21c4f6bd5e3815":
            return game_utility_mp::getmaxoutofboundsbrtime();
        case #"hash_7038dec66d8275be":
            return game_utility_mp::getmaxoutofboundstime();
        case #"hash_b9c0ff6cd406fe0f":
            return game_utility_mp::function_31ae7ef740af6ecd();
        case #"hash_2bec602136ef613a":
            return game_utility_mp::function_8586b28631affd97();
        case #"hash_4ef2abae46004697":
            return game_utility_mp::function_c4391c75ac50e8c4();
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0xe182c57b, Offset: 0x2c28
// Size: 0x29
function getlastoobtrigger( ent )
{
    if ( isdefined( ent.oobtriggers ) )
    {
        return ent.oobtriggers[ 0 ];
    }
}

// Namespace outofbounds
// Params 2
// Checksum 0x98586666, Offset: 0x2c5a
// Size: 0x89
function previouslytouchedtriggertype( var_8aed0568bba4554a, currenttriggertype )
{
    var_c10882fc422ac25b = 0;
    
    if ( isdefined( var_8aed0568bba4554a.oobtriggertype ) )
    {
        previoustriggertype = var_8aed0568bba4554a.oobtriggertype;
        
        if ( currenttriggertype == previoustriggertype )
        {
            var_c10882fc422ac25b = 1;
        }
        else if ( ( currenttriggertype == "default" || currenttriggertype == "minefield" ) && ( previoustriggertype == "default" || previoustriggertype == "minefield" ) )
        {
            var_c10882fc422ac25b = 1;
        }
    }
    
    return var_c10882fc422ac25b;
}

// Namespace outofbounds
// Params 6
// Checksum 0x1ca94cb4, Offset: 0x2cec
// Size: 0xb0
function function_d4abf4015480464a( triggertype, origin, angles, radius, height, drawdebug )
{
    trigger = spawn( triggertype, origin, 0, radius, height );
    trigger.angles = angles;
    level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
    level notify( #"oob_triggers_changed" );
    
    /#
        if ( drawdebug == 1 )
        {
            thread debug::drawsphere( trigger.origin, radius, 1000, ( 1, 1, 0 ) );
        }
    #/
}

// Namespace outofbounds
// Params 0
// Checksum 0xad5f350b, Offset: 0x2da4
// Size: 0xd0
function function_842f3d4bd0e4c5b3()
{
    drawdebug = 0;
    oobspawns = utility::getstructarray( "OutOfBounds", "targetname" );
    
    if ( isdefined( oobspawns ) )
    {
        foreach ( oobspawn in oobspawns )
        {
            function_d4abf4015480464a( "trigger_rotatable_radius", oobspawn.origin, oobspawn.angles, oobspawn.radius, oobspawn.height, drawdebug );
        }
    }
}

// Namespace outofbounds
// Params 1
// Checksum 0xb3b8e69, Offset: 0x2e7c
// Size: 0x9d
function function_4a73410e756cd839( triggers )
{
    foreach ( trigger in triggers )
    {
        if ( isdefined( trigger.script_team ) )
        {
            trigger.script_team = game[ trigger.script_team ];
        }
    }
}

