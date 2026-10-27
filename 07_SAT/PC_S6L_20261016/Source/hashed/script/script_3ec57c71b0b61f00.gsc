// script_3ec57c71b0b61f00  (hash_3ec57c71b0b61f00.gscc) (size: 19687 Bytes / 0x4ce7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaa5c19e9 (2858162665)
// size ...... 19687 (0x4ce7)
// includes .. 14  (offset: 0x4b03)
// strings ... 24  (offset: 0x4b73)
// dev strs .. 1   (offset: 0x4cdb)
// exports ... 46  (offset: 0x337f)
// cseg ...... 0x1d2 + 0x31ad (0x337f)
// imports ... 136 (offset: 0x3aaf)
// animtree1 . 0   (offset: 0x4ce7)
// animtree2 . 0   (offset: 0x4ce7)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\player;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\vehicles\damage;

#namespace namespace_7161222aac9ca916;

// Namespace namespace_7161222aac9ca916
// Params 9
// Checksum 0x55041052, Offset: 0x1f0
// Size: 0x4ad
function function_99bd6dec05f43457( pos, vehicle, model, var_ae630d36801c220a, name, var_ec517b09275f391, var_330cc8c49ebc685a, speed, accel )
{
    if ( !self.var_8c78435105a9f582 )
    {
        startingposition = pos;
        startingposition = chopper_support::getpathstart( pos );
        startingposition = utility::drop_to_ground( startingposition );
        startingposition += ( 0, 0, function_8910c2ed5165b312() );
        startingposition = function_be4318402c9c1594( startingposition );
    }
    
    if ( !isdefined( startingposition ) )
    {
        startingposition = pos;
    }
    
    startingangles = vectortoangles( var_ae630d36801c220a.origin - startingposition );
    startingposition += anglestoforward( startingangles ) * 10;
    chopper = spawnvehicle( model, "dmz_ai_chopper", vehicle, startingposition, startingangles );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    chopper.speed = speed ?? 60;
    chopper.originalspeed = chopper.speed;
    chopper.accel = accel ?? 50;
    chopper.originalaccel = chopper.accel;
    chopper.lifetime = 9999;
    chopper.team = "team_hundred_ninety";
    chopper.angles = startingangles;
    chopper.flaresreservecount = 2;
    chopper.pathstart = startingposition;
    chopper.pathgoal = var_ae630d36801c220a.origin;
    chopper.currentaction = "patrol";
    chopper.currenttarget = undefined;
    chopper.heightoffset = ( 0, 0, 1500 );
    chopper.ignoreengagedist = getdvarint( @"hash_db1f71003929b40e", 1 ) == 1;
    chopper.fpatrol = 1;
    chopper.handleeventcallback = &function_f0595c5a54f75fd4;
    chopper setmaxpitchroll( 15, 15 );
    chopper vehicle_setspeed( chopper.speed, chopper.accel );
    chopper sethoverparams( 50, 5, 2.5 );
    chopper setturningability( 0.5 );
    chopper setyawspeed( 100, 25, 25, 0.1 );
    chopper setcandamage( 1 );
    chopper setneargoalnotifydist( 768 );
    chopper setvehicleteam( chopper.team );
    chopper.ignorelist = [ chopper ];
    chopper.stage3accradius = undefined;
    chopper.crashoffset = chopper.heightoffset[ 2 ] - 250;
    chopper.currenthealth = getdvarint( @"scr_vtol_boss_health", level.var_adaaa86b7b5a18b6 );
    chopper.health = getdvarint( @"scr_vtol_boss_health", level.var_adaaa86b7b5a18b6 );
    chopper.maxhealth = getdvarint( @"scr_vtol_boss_health", level.var_adaaa86b7b5a18b6 );
    chopper.damagestate = 0;
    chopper sentientpoolmanager::registersentient( "Level_Vehicle", chopper.team );
    chopper.threatlist = [];
    chopper.patrolwaittime = 0;
    chopper.var_6fee42a3380d1319 = 6;
    chopper.currentstate = "patrol";
    chopper.patrolstartnode = var_ae630d36801c220a;
    chopper.funcs[ "patrol" ] = &chopper_patrol;
    chopper.funcs[ "idle" ] = &chopper_idle;
    chopper.funcs[ "attack" ] = &chopper_attack;
    
    if ( var_ec517b09275f391 )
    {
        chopper.funcs[ "patrol" ] = var_ec517b09275f391;
    }
    
    chopper thread chopper_think();
    
    if ( var_330cc8c49ebc685a )
    {
        chopper thread [[ var_330cc8c49ebc685a ]]();
    }
    else
    {
        chopper thread chopper_updatethreat();
    }
    
    chopper thread function_9106137eab34ff48();
    chopper vehicleshowonminimap( 0 );
    chopper.vehiclename = name;
    damage::set_post_mod_damage_callback( chopper vehicle::get_ref(), &chopper_postmodifydamage );
    damage::set_death_callback( chopper vehicle::get_ref(), &chopper_handledeathdamage );
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        chopper thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &chopper_support::choppersupport_handlemissiledetection );
    }
    
    /#
        chopper thread function_bec3ea3b8a70e2c1();
    #/
    
    return chopper;
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0xa0b42c7f, Offset: 0x6a6
// Size: 0x52
function function_f0595c5a54f75fd4( vehicle )
{
    driver = vehicle_occupancy::get_driver( vehicle );
    
    if ( isdefined( driver ) )
    {
        function_c585f17cc1fba955( driver, 500, 1 );
        
        if ( self.currentstate != "attack" )
        {
            function_5593697f8fdd7ac6( "idle" );
        }
    }
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0xb8f6ae66, Offset: 0x700
// Size: 0x17
function function_bfaacd2d206fbda3( value )
{
    self.is_immune = value;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x13392d9e, Offset: 0x71f
// Size: 0xb
function function_bcc82514dd1dd6ff()
{
    return self.is_immune;
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x4b119fb5, Offset: 0x733
// Size: 0x164, Type: bool
function chopper_postmodifydamage( data )
{
    immune = function_bcc82514dd1dd6ff();
    
    if ( immune )
    {
        data.damage = 0;
    }
    
    if ( isdefined( self.postmodifydamage ) )
    {
        self thread [[ self.postmodifydamage ]]( data );
    }
    
    if ( isplayer( data.attacker ) )
    {
        function_c585f17cc1fba955( data.attacker, data.damage, 1 );
        
        if ( self.currentstate != "attack" && !self.var_9bd743060e96497e )
        {
            function_5593697f8fdd7ac6( "idle" );
        }
    }
    
    if ( data.attacker && isplayer( data.attacker ) )
    {
        if ( immune )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, "tag_origin", undefined, undefined, 0, data.point, 1, undefined, undefined, undefined, undefined );
        }
        else if ( function_95411c97fcf77b79() )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int( data.damage ), data.point, 0, undefined, 0, 0 );
        }
    }
    
    chopper_support::choppersupport_postmodifydamage( data );
    return true;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xd8ec952e, Offset: 0x8a0
// Size: 0x77
function chopper_think()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    
    /#
        if ( getdvarint( @"hash_9bff76a6ceff93d3", 0 ) )
        {
            thread function_860a6983b648afb5();
        }
    #/
    
    while ( true )
    {
        if ( isdefined( self.funcs[ self.currentstate ] ) )
        {
            [[ self.funcs[ self.currentstate ] ]]();
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_7161222aac9ca916
    // Params 0, eflags: 0x4
    // Checksum 0xa2adbb4c, Offset: 0x91f
    // Size: 0x84, Type: dev
    function private function_860a6983b648afb5()
    {
        self endon( #"death" );
        self endon( #"explode" );
        self endon( #"leaving" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( self.currentstate )
            {
                print3d( self.origin + ( 0, 0, 10 ), self.currentstate, ( 1, 1, 1 ), 1, 20, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x2565039a, Offset: 0x9ab
// Size: 0x23, Type: bool
function chopper_handledeathdamage( data )
{
    chopper_support::choppersupport_handledeathdamage( data );
    self notify( #"death" );
    return true;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xb63b433b, Offset: 0x9d7
// Size: 0xa9
function chopper_updatethreat()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    while ( true )
    {
        players = function_553324034f30c65b();
        
        foreach ( player in players )
        {
            function_c585f17cc1fba955( player, 10 );
        }
        
        wait 10;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x29239ebe, Offset: 0xa88
// Size: 0x10a
function chopper_patrol()
{
    self endon( #"death" );
    self endon( #"state_change" );
    self clearlookatent();
    self setneargoalnotifydist( 300 );
    
    if ( !self.fpatrol )
    {
        self vehicle_setspeed( 20, 20 );
    }
    
    self.fpatrol = 0;
    
    if ( !isdefined( self.next_target ) )
    {
        self.next_target = self.patrolstartnode;
    }
    
    chopper_movetolocation( self.next_target, self.patrolwaittime > 0, ( 0, 0, 0 ) );
    
    if ( self.next_target.target )
    {
        self.next_target = utility::getstruct( self.next_target.target, "targetname" );
    }
    else
    {
        self.next_target = undefined;
    }
    
    wait self.patrolwaittime;
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    self.currentstate = "idle";
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x9fb2651b, Offset: 0xb9a
// Size: 0x3b
function function_5593697f8fdd7ac6( state )
{
    self.currentstate = state;
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    self notify( #"state_change" );
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xe1cafea2, Offset: 0xbdd
// Size: 0x69
function chopper_idle()
{
    self endon( #"death" );
    self endon( #"state_change" );
    
    if ( self.stayidle )
    {
        return;
    }
    
    target = function_a9d1a5abfbc6a6fa();
    
    if ( isdefined( target ) )
    {
        self.currenttarget = target;
        self.currentstate = "attack";
        return;
    }
    
    self.currentstate = "patrol";
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xbaf199f, Offset: 0xc4e
// Size: 0xa3
function chopper_attack()
{
    self endon( #"death" );
    self endon( #"state_change" );
    self.fpatrol = 1;
    
    if ( !function_46e55b7fc7a1f265() )
    {
        function_5593697f8fdd7ac6( "patrol" );
        return;
    }
    
    if ( !self.var_e3dbb0a02ec8a8fe )
    {
        self.var_e3dbb0a02ec8a8fe = 1;
        thread function_d84fd72f33c51981();
    }
    
    if ( isdefined( self.attackfunc ) )
    {
        self [[ self.attackfunc ]]( self.threatlist[ self.currenttarget ].player );
        return;
    }
    
    self.currentstate = "patrol";
}

// Namespace namespace_7161222aac9ca916
// Params 3
// Checksum 0x47254f64, Offset: 0xcf9
// Size: 0x4c3
function function_c585f17cc1fba955( player, value, ignoredist )
{
    if ( !( isdefined( player ) && isdefined( player.guid ) ) )
    {
        return;
    }
    
    if ( !isdefined( self.threatlist[ player.guid ] ) )
    {
        self.threatlist[ player.guid ] = spawnstruct();
        self.threatlist[ player.guid ].player = player;
        self.threatlist[ player.guid ].threat = 0;
        self.threatlist[ player.guid ].ignoredist = 0;
    }
    
    if ( ignoredist )
    {
        self.threatlist[ player.guid ].ignoredist = ignoredist;
    }
    
    if ( !( isdefined( self.var_914f224900f864e8 ) && isdefined( self.var_dffce5f0eeb96ff0 ) ) )
    {
        self.var_914f224900f864e8 = player.guid;
        self.var_dffce5f0eeb96ff0 = player.guid;
    }
    else if ( !isdefined( self.threatlist[ player.guid ].up ) && !isdefined( self.threatlist[ player.guid ].down ) && self.var_dffce5f0eeb96ff0 != player.guid )
    {
        self.threatlist[ self.var_914f224900f864e8 ].down = player.guid;
        self.threatlist[ player.guid ].up = self.var_914f224900f864e8;
        self.var_914f224900f864e8 = player.guid;
    }
    
    self.threatlist[ player.guid ].threat += value;
    
    if ( value > 0 )
    {
        if ( self.var_dffce5f0eeb96ff0 == player.guid )
        {
            return;
        }
        
        checkid = self.threatlist[ player.guid ].up;
        checkedids = [];
        
        while ( self.threatlist[ checkid ].threat < self.threatlist[ player.guid ].threat )
        {
            if ( arraycontains( checkedids, checkid ) )
            {
                self.threatlist = [];
                self.var_dffce5f0eeb96ff0 = undefined;
                self.var_914f224900f864e8 = undefined;
                return;
            }
            
            checkedids[ checkedids.size ] = checkid;
            checkid = self.threatlist[ checkid ].up;
        }
        
        if ( checkid != self.threatlist[ player.guid ].up )
        {
            function_b461f760b09b955b( player.guid );
            function_af845f9b5f99770a( player.guid, checkid );
        }
        
        return;
    }
    
    if ( self.threatlist[ player.guid ].threat <= 0 )
    {
        function_b461f760b09b955b( player.guid );
        return;
    }
    
    if ( self.var_914f224900f864e8 == player.guid )
    {
        return;
    }
    
    checkid = self.threatlist[ player.guid ].down;
    checkedids = [];
    
    while ( self.threatlist[ checkid ].threat > self.threatlist[ player.guid ].threat )
    {
        if ( arraycontains( checkedids, checkid ) )
        {
            self.threatlist = [];
            self.var_dffce5f0eeb96ff0 = undefined;
            self.var_914f224900f864e8 = undefined;
            return;
        }
        
        checkedids[ checkedids.size ] = checkid;
        checkid = self.threatlist[ checkid ].down;
    }
    
    if ( checkid != self.threatlist[ player.guid ].down )
    {
        function_b461f760b09b955b( player.guid );
        function_af845f9b5f99770a( player.guid, self.threatlist[ checkid ].up );
    }
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x33a7ef1c, Offset: 0x11c4
// Size: 0x40
function function_d3d7a122e05f263a( player )
{
    function_b461f760b09b955b( player.guid );
    
    if ( self.currenttarget == player.guid )
    {
        self.currenttarget = undefined;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0xcc9b612e, Offset: 0x120c
// Size: 0x16a
function function_b461f760b09b955b( guid )
{
    if ( self.var_dffce5f0eeb96ff0 == guid && self.var_914f224900f864e8 == guid )
    {
        self.var_dffce5f0eeb96ff0 = undefined;
        self.var_914f224900f864e8 = undefined;
        return;
    }
    
    if ( isdefined( self.threatlist[ guid ].down ) )
    {
        if ( !isdefined( self.threatlist[ guid ].up ) )
        {
            self.var_dffce5f0eeb96ff0 = self.threatlist[ guid ].down;
        }
        
        self.threatlist[ self.threatlist[ guid ].down ].up = self.threatlist[ guid ].up;
    }
    
    if ( isdefined( self.threatlist[ guid ].up ) )
    {
        if ( !isdefined( self.threatlist[ guid ].down ) )
        {
            self.var_914f224900f864e8 = self.threatlist[ guid ].up;
        }
        
        self.threatlist[ self.threatlist[ guid ].up ].down = self.threatlist[ guid ].down;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 2
// Checksum 0x54bc6839, Offset: 0x137e
// Size: 0x149
function function_af845f9b5f99770a( guid, guidbefore )
{
    if ( !isdefined( guidbefore ) )
    {
        self.threatlist[ self.var_dffce5f0eeb96ff0 ].up = guid;
        self.threatlist[ guid ].down = self.var_dffce5f0eeb96ff0;
        self.threatlist[ guid ].up = undefined;
        self.var_dffce5f0eeb96ff0 = guid;
        return;
    }
    
    if ( isdefined( self.threatlist[ guidbefore ].down ) )
    {
        self.threatlist[ self.threatlist[ guidbefore ].down ].up = guid;
    }
    
    self.threatlist[ guid ].down = self.threatlist[ guidbefore ].down;
    self.threatlist[ guidbefore ].down = guid;
    self.threatlist[ guid ].up = guidbefore;
    
    if ( !isdefined( self.threatlist[ guid ].down ) )
    {
        self.var_914f224900f864e8 = guid;
    }
}

/#

    // Namespace namespace_7161222aac9ca916
    // Params 0
    // Checksum 0x6d27fa92, Offset: 0x14cf
    // Size: 0xae, Type: dev
    function function_1a3a98ddf3586916()
    {
        while ( true )
        {
            foreach ( agent in level.agentarray )
            {
                if ( !isdefined( agent.guid ) )
                {
                    continue;
                }
                
                if ( utility::percent_chance( 50 ) )
                {
                    function_c585f17cc1fba955( agent, randomint( 400 ) );
                }
            }
            
            wait 1;
        }
    }

    // Namespace namespace_7161222aac9ca916
    // Params 0
    // Checksum 0xa26280c8, Offset: 0x1585
    // Size: 0x5d, Type: dev
    function function_bec3ea3b8a70e2c1()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_9fea139a8dd1eaae", 0 ) == 1 )
            {
                self notify( #"death" );
                choppersupport_crash( 100, level.players[ 0 ].origin );
                setdvar( @"hash_9fea139a8dd1eaae", 0 );
            }
            
            wait 1;
        }
    }

#/

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x7629a8fe, Offset: 0x15ea
// Size: 0xc7
function function_a9d1a5abfbc6a6fa()
{
    checkedids = [];
    
    for ( checktargetid = self.var_dffce5f0eeb96ff0; isdefined( checktargetid ) && isdefined( self.threatlist[ checktargetid ] ) ; checktargetid = self.threatlist[ checktargetid ].down )
    {
        if ( arraycontains( checkedids, checktargetid ) )
        {
            self.threatlist = [];
            self.var_dffce5f0eeb96ff0 = undefined;
            self.var_914f224900f864e8 = undefined;
            return;
        }
        
        checkedids[ checkedids.size ] = checktargetid;
        threatinfo = self.threatlist[ checktargetid ];
        
        if ( function_9f1d8b27372c42f5( threatinfo ) )
        {
            canseetarget = chopper_canseetarget( threatinfo.player );
            
            if ( canseetarget )
            {
                return checktargetid;
            }
        }
    }
}

// Namespace namespace_7161222aac9ca916
// Params 4
// Checksum 0x618a303e, Offset: 0x16ba
// Size: 0x232, Type: bool
function chopper_canseetarget( targetplayer, overridetestpoint, var_66ede5a42be94f53, var_f43c352f1d3b500 )
{
    if ( self.var_4dd1731c54a1396b )
    {
        return true;
    }
    
    if ( !targetplayer )
    {
        return false;
    }
    
    threatinfo = self.threatlist[ targetplayer.guid ];
    
    if ( targetplayer.notarget )
    {
        return false;
    }
    
    if ( var_66ede5a42be94f53 )
    {
        if ( threatinfo && threatinfo.lastseentime )
        {
            if ( !isdefined( var_f43c352f1d3b500 ) )
            {
                var_f43c352f1d3b500 = 4000;
            }
            
            if ( gettime() - threatinfo.lastseentime <= var_f43c352f1d3b500 )
            {
                return true;
            }
        }
    }
    
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 0 );
    ignorelist = [ self ];
    
    if ( isdefined( targetplayer.externalvehicle ) )
    {
        ignorelist[ ignorelist.size ] = targetplayer.externalvehicle;
        
        if ( isdefined( targetplayer.externalvehicle.turrets ) )
        {
            ignorelist = arraycombine( ignorelist, targetplayer.externalvehicle.turrets );
        }
    }
    
    linkedchildren = self getlinkedchildren();
    
    if ( isdefined( linkedchildren ) )
    {
        foreach ( child in linkedchildren )
        {
            ignorelist[ ignorelist.size ] = child;
        }
    }
    
    if ( isdefined( targetplayer.vehicle ) )
    {
        ignorelist[ ignorelist.size ] = targetplayer.vehicle;
    }
    
    endpoint = targetplayer tagexists( "j_head" ) ? targetplayer gettagorigin( "j_head" ) : targetplayer.origin;
    
    if ( trace::ray_trace_passed( overridetestpoint ?? self.origin, endpoint, ignorelist, contentsoverride ) )
    {
        threatinfo.lastseentime = gettime();
        return true;
    }
    
    return false;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xbc054c99, Offset: 0x18f5
// Size: 0x27e
function function_d84fd72f33c51981()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    level endon( #"game_ended" );
    var_66a17286852a78c8 = 9999;
    recenttargets = [];
    
    while ( true )
    {
        wait 1;
        var_66a17286852a78c8 += 1;
        
        if ( self.strafing )
        {
            continue;
        }
        
        if ( !isdefined( self.currenttarget ) || !isdefined( self.threatlist[ self.currenttarget ] ) )
        {
            continue;
        }
        
        if ( var_66a17286852a78c8 < 6 || var_66a17286852a78c8 < 8 )
        {
            continue;
        }
        
        var_7cbcc610f8cc3ea7 = [];
        checked = [];
        
        for ( guid = self.var_dffce5f0eeb96ff0; isdefined( guid ) && isdefined( self.threatlist[ guid ] ) ; guid = self.threatlist[ guid ].down )
        {
            if ( arraycontains( checked, guid ) )
            {
                break;
            }
            
            checked[ checked.size ] = guid;
            var_7cbcc610f8cc3ea7[ var_7cbcc610f8cc3ea7.size ] = guid;
        }
        
        if ( var_7cbcc610f8cc3ea7.size <= 1 )
        {
            continue;
        }
        
        candidates = [];
        
        foreach ( candidate in var_7cbcc610f8cc3ea7 )
        {
            if ( candidate == self.currenttarget )
            {
                continue;
            }
            
            info = self.threatlist[ candidate ];
            
            if ( !function_9f1d8b27372c42f5( info ) )
            {
                continue;
            }
            
            if ( arraycontains( recenttargets, candidate ) )
            {
                info.threat *= 0.6;
            }
            
            if ( chopper_canseetarget( info.player, undefined, 1, undefined ) )
            {
                candidates[ candidates.size ] = candidate;
            }
        }
        
        if ( candidates.size <= 0 )
        {
            continue;
        }
        
        newguid = function_69dd9fd0e76128af( candidates );
        oldguid = self.currenttarget;
        self.currenttarget = newguid;
        recenttargets[ recenttargets.size ] = oldguid;
        
        if ( recenttargets.size > 2 )
        {
            recenttargets = arrayremove( recenttargets, recenttargets[ 0 ] );
        }
        
        var_66a17286852a78c8 = 0;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x4eb48589, Offset: 0x1b7b
// Size: 0x14e
function function_69dd9fd0e76128af( candidates )
{
    total = 0;
    
    foreach ( guid in candidates )
    {
        total += max( 1, self.threatlist[ guid ].threat );
    }
    
    roll = randomfloatrange( 1, total + 1 );
    accum = 0;
    
    foreach ( guid in candidates )
    {
        accum += max( 1, self.threatlist[ guid ].threat );
        
        if ( roll <= accum )
        {
            return guid;
        }
    }
    
    return candidates[ 0 ];
}

// Namespace namespace_7161222aac9ca916
// Params 2
// Checksum 0x881853cc, Offset: 0x1cd2
// Size: 0x187
function tracegroundpoint( x, y )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 120;
    minz = level.averagealliesz;
    ignorelist = self.ignorelist ?? [ self ];
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    traceradius = 120;
    contentsoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0 );
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), traceradius, ignorelist, contentsoverride, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace namespace_7161222aac9ca916
// Params 3
// Checksum 0xeecaa03c, Offset: 0x1e62
// Size: 0x64
function getcorrectheight( x, y, rand )
{
    offgroundheight = self.heightoffset[ 2 ];
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace namespace_7161222aac9ca916
// Params 4
// Checksum 0xe2c97c96, Offset: 0x1ecf
// Size: 0x134, Type: bool
function function_d8d365ee7036c02d( target, dist, checks, startrot )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( !isdefined( startrot ) )
    {
        startrot = 0;
    }
    
    toheli = self.origin - target.origin;
    toheli = vectornormalize( ( toheli[ 0 ], toheli[ 1 ], 0 ) ) * dist;
    rot = startrot;
    
    while ( rot < startrot + 360 )
    {
        testpos = rotatevector( toheli, ( 0, rot, 0 ) );
        testpos += target.origin + self.heightoffset;
        
        if ( outofbounds::ispointinoutofbounds( testpos ) )
        {
        }
        else
        {
            contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1 );
            canseetarget = chopper_canseetarget( target, testpos );
            
            if ( canseetarget )
            {
                self setlookatent( target );
                chopper_movetolocation( testpos, 1 );
                return true;
            }
        }
        
        rot += 360 / checks;
    }
    
    return false;
}

// Namespace namespace_7161222aac9ca916
// Params 7
// Checksum 0xd93e8534, Offset: 0x200c
// Size: 0x2fe, Type: bool
function function_b7c8e62904e632c( target, dist, checks, startrot, overrideheight, var_86477c055566a85, var_2156f7dfa224de7f )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( function_15ef53278f060bfe( target ) )
    {
        return false;
    }
    
    toheli = self.origin - target.origin;
    toheli = vectornormalize( ( toheli[ 0 ], toheli[ 1 ], 0 ) ) * dist;
    
    if ( !isdefined( var_86477c055566a85 ) )
    {
        var_86477c055566a85 = 2;
    }
    
    if ( !isdefined( startrot ) )
    {
        startrot = 0;
    }
    
    rot = startrot;
    
    while ( rot < startrot + 360 )
    {
        testdir = rotatevector( toheli, ( 0, rot, 0 ) );
        testpos = testdir + target.origin + ( isdefined( overrideheight ) ? ( 0, 0, overrideheight ) : self.heightoffset );
        contentsoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
        canseetarget = chopper_canseetarget( target );
        canpathforward = self.alwaysstrafe || trace::ray_trace_passed( testpos, testpos - testdir * var_86477c055566a85, self.ignorelist, contentsoverride );
        
        if ( canseetarget && canpathforward )
        {
            startpos = testpos;
            endpos = startpos - testdir * var_86477c055566a85;
            
            /#
                if ( getdvarint( @"hash_9bff76a6ceff93d3", 0 ) )
                {
                    sphere( startpos, 50, ( 1, 1, 1 ), 1, 200 );
                    sphere( endpos, 50, ( 0, 1, 0 ), 1, 200 );
                    line( startpos, endpos, ( 1, 1, 1 ), 1, 1, 200 );
                }
            #/
            
            self notify( #"strafe_init" );
            self.strafing = 1;
            chopper_movetolocation( startpos, 1, ( 0, 0, 0 ), 1 );
            self vehicle_setspeed( self.originalspeed * 2, self.accel );
            wait 1.5;
            self clearlookatent();
            self notify( #"strafe_start" );
            
            if ( self.strafefunc )
            {
                self thread [[ self.strafefunc ]]( target );
            }
            
            chopper_movetolocation( endpos, !isdefined( var_2156f7dfa224de7f ), undefined, 1 );
            self notify( #"strafe_end" );
            self vehicle_setspeed( self.originalspeed, self.accel );
            self.strafing = 0;
            return true;
        }
        else
        {
            /#
                if ( getdvarint( @"hash_9bff76a6ceff93d3", 0 ) )
                {
                    sphere( testpos, 50, ( 1, 0, 0 ), 1, 200 );
                }
            #/
        }
        
        rot += 360 / checks;
    }
    
    return false;
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x49ea60d6, Offset: 0x2313
// Size: 0x38, Type: bool
function function_15ef53278f060bfe( target )
{
    return !isdefined( target ) || !player::isreallyalive( target ) || target supers_mp::function_60dbd7e2f1b02c22() || target.notarget;
}

// Namespace namespace_7161222aac9ca916
// Params 5
// Checksum 0xc55f2a04, Offset: 0x2354
// Size: 0x463
function chopper_movetolocation( target, forcestopatgoal, forceheight, obstructioncheck, desiredyaw )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    newpos = undefined;
    var_86df004d2aa1e17b = undefined;
    unload = 0;
    var_e16e53b6a3b7749d = 0;
    var_5bdcdba698716361 = 0;
    goalyaw = desiredyaw;
    yaw = 0;
    testtarget = target;
    
    if ( !isvector( target ) )
    {
        testtarget = target.origin;
        goalyaw = target.script_goalyaw;
        var_86df004d2aa1e17b = target.script_anglevehicle;
        var_e16e53b6a3b7749d = isdefined( target.script_flag_wait );
        var_5bdcdba698716361 = isdefined( target.target );
        
        if ( target.script_unload )
        {
            unload = target.script_unload;
        }
        
        if ( isdefined( target.script_yaw ) )
        {
            yaw = target.script_yaw;
        }
    }
    
    ignorelist = arraycopy( self.ignorelist );
    linkedchildren = self getlinkedchildren();
    
    if ( isdefined( linkedchildren ) )
    {
        foreach ( child in linkedchildren )
        {
            ignorelist[ ignorelist.size ] = child;
        }
    }
    
    if ( self.tetherfunc )
    {
        testtarget = [[ self.tetherfunc ]]( testtarget );
    }
    else
    {
        testtarget = function_8148f8acfcef5b01( testtarget );
    }
    
    currentpos = self.origin;
    initialgoalpos = testtarget * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
    obstructed = 0;
    xpos = testtarget[ 0 ];
    ypos = testtarget[ 1 ];
    
    if ( obstructioncheck )
    {
        var_4dc9a98b0aa99ec3 = 512;
        contentsoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
        obstructiontrace = trace::sphere_trace( currentpos, initialgoalpos, var_4dc9a98b0aa99ec3, ignorelist, contentsoverride );
        
        if ( isdefined( obstructiontrace ) )
        {
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                xpos = obstructiontrace[ "shape_position" ][ 0 ];
                ypos = obstructiontrace[ "shape_position" ][ 1 ];
                obstructed = 1;
                
                /#
                    if ( getdvarint( @"hash_9bff76a6ceff93d3", 0 ) )
                    {
                        sphere( obstructiontrace[ "<dev string:x24>" ], var_4dc9a98b0aa99ec3, ( 1, 0, 0 ), 1, 200 );
                    }
                #/
            }
        }
        
        /#
            if ( getdvarint( @"hash_9bff76a6ceff93d3", 0 ) )
            {
                sphere( currentpos, var_4dc9a98b0aa99ec3, ( 1, 1, 1 ), 1, 200 );
                sphere( initialgoalpos, var_4dc9a98b0aa99ec3, ( 0, 0, 1 ), 1, 200 );
                line( currentpos, initialgoalpos, ( 1, 1, 1 ), 1, 1, 200 );
            }
        #/
    }
    
    if ( isdefined( forceheight ) )
    {
        newpos = testtarget + forceheight;
    }
    else if ( self.evasivemaneuvers )
    {
        newx = xpos + randomintrange( -500, 500 );
        newy = ypos + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        properz = getcorrectheight( xpos, ypos, 20 );
        newpos = ( xpos, ypos, properz );
    }
    
    stopatgoal = 0;
    
    if ( forcestopatgoal && !obstructed )
    {
        stopatgoal = forcestopatgoal;
    }
    
    speed = undefined;
    
    if ( !isvector( target ) && target.speed )
    {
        speed = target.speed;
    }
    
    self vehicle_helisetai( newpos, speed, undefined, undefined, goalyaw, var_86df004d2aa1e17b, yaw, undefined, 0, stopatgoal, unload, var_e16e53b6a3b7749d, var_5bdcdba698716361 );
    utility::waittill_any( "near_goal", "begin_evasive_maneuvers" );
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0xfb389d83, Offset: 0x27bf
// Size: 0xe2, Type: bool
function function_9f1d8b27372c42f5( targetinfo )
{
    if ( !isplayer( targetinfo.player ) )
    {
        return false;
    }
    
    extracheck = !isdefined( self.var_197abd6744fcd8bf ) || self [[ self.var_197abd6744fcd8bf ]]( targetinfo.player );
    extracheck &= targetinfo.ignoredist || player::isreallyalive( targetinfo.player ) && function_e26d3a902c1fc7e3( targetinfo.player );
    extracheck &= !targetinfo.player supers_mp::function_60dbd7e2f1b02c22();
    targetinfo.ignoredist = 0;
    return !targetinfo.player.notarget && player::isreallyalive( targetinfo.player ) && extracheck;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xb8bd15e0, Offset: 0x28aa
// Size: 0xae
function function_9106137eab34ff48()
{
    level endon( #"game_ended" );
    self endon( #"choppersupport_gone" );
    self endon( #"flyaway" );
    owner = self.owner;
    self waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) && self.killedbyweapon )
    {
        if ( ![[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( self.killedbyweapon ) )
        {
            choppersupport_crash( 100 );
        }
    }
    
    chopper_explode();
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x3053c249, Offset: 0x2960
// Size: 0x8d
function chopper_explode()
{
    self notify( #"explode" );
    self notify( #"state_change" );
    self radiusdamage( self.origin, 1000, 200, 200, self, "MOD_EXPLOSIVE", "chopper_support_turret_mp" );
    self setscriptablepartstate( "explode", "on", 0 );
    
    if ( isdefined( self.lootfunc ) )
    {
        self [[ self.lootfunc ]]( self.activityinstance.activitye, "activity_gunship_commmander" );
    }
    
    wait 0.35;
    chopper_cleanup( 1 );
}

// Namespace namespace_7161222aac9ca916
// Params 2
// Checksum 0xc9d91bb2, Offset: 0x29f5
// Size: 0x101
function choppersupport_crash( speed, var_865f8f844b0c099 )
{
    self endon( #"explode" );
    self setscriptablepartstate( "crash", "on", 0 );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament unlink();
        self.killcament.origin = self.origin + ( 0, 0, 100 );
    }
    
    self clearlookatent();
    self notify( #"crashing" );
    self.iscrashing = 1;
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    var_61f902b2dd6fc262 = chopper_findcrashposition( 3500, 500, 1000 );
    
    if ( isdefined( var_865f8f844b0c099 ) )
    {
        var_61f902b2dd6fc262 = var_865f8f844b0c099;
    }
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread chopper_spinout( speed );
    self vehicle_turnengineoff();
    utility::waittill_any_timeout( 5, "collision", "near_goal" );
}

// Namespace namespace_7161222aac9ca916
// Params 3
// Checksum 0x7de05e21, Offset: 0x2afe
// Size: 0x241
function chopper_findcrashposition( crashdist, var_21829f1a765d61f3, var_21a5b51a7683da0d )
{
    crashstart = self.origin;
    crashoffset = self.crashoffset;
    crashpos = undefined;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    crashend = crashstart + jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward + jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetright - jetforward ) - ( 0, 0, crashoffset );
    crashtrace = trace::ray_trace( crashstart, crashend, self );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) && !outofbounds::ispointinoutofbounds( crashend ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    return crashpos;
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0xa0537bd3, Offset: 0x2d48
// Size: 0x52
function chopper_spinout( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 0.5;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 2
// Checksum 0xd99d2a71, Offset: 0x2da2
// Size: 0xfd
function chopper_splash( bossorigin, poiname )
{
    if ( level.var_1c413c0f520b77a1 < 0 )
    {
        return;
    }
    
    if ( level.var_1c413c0f520b77a1 > 0 )
    {
        playerlist = [];
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, bossorigin ) < level.var_1c413c0f520b77a1 )
            {
                playerlist[ playerlist.size ] = player;
            }
        }
    }
    else
    {
        playerlist = level.players;
    }
    
    br_gametype_dmz::showdmzsplash( "dmz_boss_chopper_inbound", playerlist, poiname );
    overlord::playevent( "boss_near", playerlist );
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x49258940, Offset: 0x2ea7
// Size: 0xa0
function chopper_cleanup( wasdestroyed )
{
    if ( isdefined( self.frontturret ) )
    {
        self.frontturret setentityowner( undefined );
        self.frontturret.groundtargetent delete();
        self.frontturret delete();
    }
    
    if ( isdefined( self.rearturret ) )
    {
        self.rearturret setentityowner( undefined );
        self.rearturret.groundtargetent delete();
        self.rearturret delete();
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x24f07194, Offset: 0x2f4f
// Size: 0x8a
function chopper_flyaway()
{
    self endon( #"death" );
    
    if ( self.flyingaway )
    {
        return;
    }
    
    self.flyingaway = 1;
    function_5593697f8fdd7ac6( "idle" );
    self notify( #"leaving" );
    waitframe();
    self clearturrettarget();
    self clearlookatent();
    self vehicle_setspeed( 80, 25, 25 );
    self setvehgoalpos( self.pathstart, 1 );
    self waittill( #"near_goal" );
    self notify( #"flyaway" );
    waitframe();
    chopper_cleanup( 0 );
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x98e8ac0, Offset: 0x2fe1
// Size: 0xe1
function function_8148f8acfcef5b01( var_34601fa29adc0f65 )
{
    if ( !self.var_3574b7a060d661f5 )
    {
        return var_34601fa29adc0f65;
    }
    
    chopperinstance = self.activityinstance;
    
    if ( !chopperinstance || !chopperinstance.var_3574b7a060d661f5 || !chopperinstance.customsettings.var_35b35d059b17b988 )
    {
        return var_34601fa29adc0f65;
    }
    
    var_2ce8baa3c076d66c = chopperinstance.var_2ce8baa3c076d66c;
    
    if ( distance2dsquared( chopperinstance.spawnloc, var_34601fa29adc0f65 ) < var_2ce8baa3c076d66c )
    {
        return var_34601fa29adc0f65;
    }
    
    var_ec0430ac7f32cbf = var_34601fa29adc0f65 - chopperinstance.spawnloc;
    var_8c018271cdf7e08a = vectornormalize( var_ec0430ac7f32cbf );
    newposition = chopperinstance.spawnloc + var_8c018271cdf7e08a * chopperinstance.tetherradius;
    return newposition;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xa34eedd5, Offset: 0x30cb
// Size: 0x47
function function_5834da79eb51fa88()
{
    if ( self && self.var_3574b7a060d661f5 && self.customsettings.var_ef819189ba3c6250 )
    {
        return self.customsettings.var_ef819189ba3c6250;
    }
    
    return level.var_ef819189ba3c6250;
}

// Namespace namespace_7161222aac9ca916
// Params 1
// Checksum 0x2800d30d, Offset: 0x311b
// Size: 0xbc, Type: bool
function function_e26d3a902c1fc7e3( player )
{
    if ( !player.origin )
    {
        return false;
    }
    
    if ( self.var_3574b7a060d661f5 )
    {
        chopperinstance = self.activityinstance;
        
        if ( chopperinstance && chopperinstance.var_3574b7a060d661f5 && chopperinstance.customsettings.var_35b35d059b17b988 )
        {
            if ( distance2dsquared( chopperinstance.spawnloc, player.origin ) < chopperinstance.var_2ce8baa3c076d66c )
            {
                return true;
            }
        }
    }
    
    if ( distance2dsquared( self.origin, player.origin ) < 36000000 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x5192f114, Offset: 0x31e0
// Size: 0x88
function function_553324034f30c65b()
{
    if ( self.var_3574b7a060d661f5 )
    {
        chopperinstance = self.activityinstance;
        
        if ( chopperinstance && chopperinstance.var_3574b7a060d661f5 && chopperinstance.customsettings.var_35b35d059b17b988 )
        {
            warningradius = function_5834da79eb51fa88();
            return getplayersinradius( chopperinstance.spawnloc, warningradius );
        }
    }
    
    return getplayersinradius( self.origin, level.var_ef819189ba3c6250 );
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xd17d157e, Offset: 0x3271
// Size: 0x77
function function_46e55b7fc7a1f265()
{
    if ( self.var_270d17ea2e935e32 )
    {
        return [[ self.var_270d17ea2e935e32 ]]();
    }
    
    if ( !self.currenttarget )
    {
        self.currenttarget = function_a9d1a5abfbc6a6fa();
    }
    
    if ( self.currenttarget && self.threatlist[ self.currenttarget ] )
    {
        return self.threatlist[ self.currenttarget ].player;
    }
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0xebab13a8, Offset: 0x32f1
// Size: 0x42
function function_8910c2ed5165b312()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.spawnheight )
    {
        return self.customsettings.spawnheight;
    }
    
    return level.var_be17f6f2696e1d1a;
}

// Namespace namespace_7161222aac9ca916
// Params 0
// Checksum 0x78ed658d, Offset: 0x333c
// Size: 0x42
function function_95411c97fcf77b79()
{
    if ( self.var_3574b7a060d661f5 && self.customsettings.var_99cc0ae0a9c90f54 )
    {
        return self.customsettings.var_99cc0ae0a9c90f54;
    }
    
    return level.var_99cc0ae0a9c90f54;
}

