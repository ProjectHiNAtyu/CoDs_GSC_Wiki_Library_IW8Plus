// scripts\mp\common\supers\med_box.gsc  (hash_4d6402099d498d9d.gscc) (size: 14401 Bytes / 0x3841 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe01c0b86 (3759934342)
// size ...... 14401 (0x3841)
// includes .. 17  (offset: 0x354d)
// strings ... 38  (offset: 0x35d5)
// dev strs .. 1   (offset: 0x3805)
// exports ... 46  (offset: 0x1fb1)
// cseg ...... 0x2e9 + 0x1cc8 (0x1fb1)
// imports ... 117 (offset: 0x26e1)
// animtree1 . 0   (offset: 0x3811)
// animtree2 . 3   (offset: 0x3811)
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\functionals_utility;
#using scripts\common\interactive;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\playerhealth;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace med_box;

// Namespace med_box
// Params 0, eflags: 0x1
// Checksum 0xc0f8cff9, Offset: 0x307
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"super_med_box", #"init", &medbox_init );
}

// Namespace med_box
// Params 0
// Checksum 0x93ae1a4a, Offset: 0x32f
// Size: 0x162
function medbox_init()
{
    setdvarifuninitialized( @"hash_f0fb5d0ed88ab0c1", 0.2 );
    setdvarifuninitialized( @"hash_8421e297e070a231", 15 );
    setdvarifuninitialized( @"hash_aab0b04330cc870b", 0 );
    setdvarifuninitialized( @"hash_8ed5cff8032a5943", 0 );
    level.var_3a033a1118284ae2 = [];
    interactive::interactive_addusedcallback( &medbox_usedcallback, "equip_medbox" );
    
    if ( utility::issharedfuncdefined( #"team_utility", #"hash_5de02d9395de8621" ) )
    {
        [[ utility::getsharedfunc( #"team_utility", #"hash_5de02d9395de8621" ) ]]( &medbox_updateheadicononjointeam );
    }
    
    level._effect[ "vfx_iw9_fieldupgrades_ammobox_timeout" ] = loadfxasset( "vfx_iw9_fieldupgrades_ammobox_timeout" );
    level._effect[ "vfx_jup_equip_medcrate_vignette" ] = loadfxasset( "vfx_jup_equip_medcrate_vignette" );
    weapons::registerusedcallback( "med_box", &medbox_used );
    utility::registersharedfunc( #"super_med_box", #"medbox_used", &medbox_used );
    utility::registersharedfunc( #"super_med_box", #"hash_215504b71852c2e7", &function_fdf8c421413d15cc );
    utility::registersharedfunc( #"super_med_box", #"hash_99bbb77633bdc9e1", &function_4d9e17f21dca6a58 );
    utility::registersharedfunc( #"super_med_box", #"hash_1012369e7583af9a", &function_3078635e613294f7 );
    level.super_med_box_initialized = 1;
}

// Namespace med_box
// Params 1
// Checksum 0x264b56df, Offset: 0x499
// Size: 0x8c
function medbox_updateheadicononjointeam( player )
{
    foreach ( medbox in level.var_3a033a1118284ae2 )
    {
        if ( isdefined( medbox ) )
        {
            medbox medbox_updateheadicon( player );
        }
    }
}

// Namespace med_box
// Params 4
// Checksum 0x4f5f5873, Offset: 0x52d
// Size: 0x3a3
function box_used_common_setup( grenade, equipmentname, superid, headicon )
{
    grenade.var_2d412ee32d4a8a86 = 0;
    grenade endon( #"death" );
    grenade.issuper = 1;
    staticsuperdata = level.superglobals.staticsuperdata[ superid ];
    grenade.superid = staticsuperdata.id;
    grenade.lifetime = staticsuperdata.bundle.lifetime;
    
    if ( grenade.lifetime > 0 )
    {
        grenade thread medbox_watchdisownedtimeout();
    }
    
    grenade thread function_7410bc998f46df51();
    grenade thread function_c94c670243b3222c( self );
    grenade waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            if ( utility::issharedfuncdefined( #"supers", #"refundsuper" ) )
            {
                self [[ utility::getsharedfunc( #"supers", #"refundsuper" ) ]]();
            }
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"equipment/plant_failed" );
            }
            
            grenade delete();
            return;
        }
    }
    
    grenade medbox_handlemovingplatforms( stuckto );
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( superid );
    
    if ( utility::issharedfuncdefined( #"weapons", #"onequipmentplanted" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"onequipmentplanted" ) ]]( grenade, equipmentname, &medbox_destroy );
    }
    
    level.var_3a033a1118284ae2[ grenade getentitynumber() ] = grenade;
    grenade emp_debuff::set_apply_emp_callback( &medbox_empapplied );
    
    if ( utility::issharedfuncdefined( #"emp", #"setemp_applied_callback" ) )
    {
        grenade [[ utility::getsharedfunc( #"emp", #"setemp_applied_callback" ) ]]( &medbox_empapplied );
    }
    
    self.medboxdeployed = grenade;
    grenade haywire::function_7f69a1eb3d590f76( &medbox_haywireapplied );
    grenade function_a4ebfb83ec0621b9( &medbox_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    if ( !grenade.madedamageable )
    {
        grenade medbox_makedamageable();
    }
    
    grenade.makedamageable = undefined;
    grenade setscriptablepartstate( "visibility", "show", 0 );
    wait 0;
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        grenade medbox_addheadicon( headicon );
    }
    
    wait 0.75;
    grenade setscriptablepartstate( "effects", "plant", 0 );
    grenade setscriptablepartstate( "anims", "open", 0 );
    wait grenade medbox_getdeployanimduration();
    grenade setscriptablepartstate( "beacon", "active", 0 );
    grenade setscriptablepartstate( "anims", "openIdle", 0 );
}

// Namespace med_box
// Params 1
// Checksum 0xb9be8833, Offset: 0x8d8
// Size: 0x13b
function function_c94c670243b3222c( player )
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    player endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_fbaf852c9cb6dff8 = -2000;
    traceend = self.origin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        groundentity = traceresults[ "entity" ];
        
        if ( isdefined( groundentity ) )
        {
            if ( utility::is_moving_platform_ent( groundentity ) )
            {
                self.origin = player.origin;
            }
        }
    }
}

// Namespace med_box
// Params 1
// Checksum 0xe1b18400, Offset: 0xa1b
// Size: 0x11d
function medbox_used( grenade )
{
    grenade endon( #"death" );
    vfxtimeout = "vfx_iw9_fieldupgrades_ammobox_timeout";
    vfxbuff = "vfx_jup_equip_medcrate_vignette";
    equipname = "equip_medbox";
    supername = "super_med_box";
    headicon = "jup_hud_icon_equipment_med_box";
    usehint = self usinggamepad() ? &"equipment_hints/med_box_hold_use" : &"equipment_hints/med_box_press_use";
    
    if ( isdefined( self.medboxdeployed ) )
    {
        self.medboxdeployed thread medbox_destroy( 0 );
    }
    
    grenade.timeoutvfxname = vfxtimeout;
    grenade.var_6df28cb7d62e41ae = vfxbuff;
    box_used_common_setup( grenade, equipname, supername, headicon );
    grenade medbox_makeusable( equipname, usehint );
    
    if ( getdvarint( @"hash_8ed5cff8032a5943" ) >= 1 )
    {
        thread medbox_usedcallback( grenade, self );
    }
    
    challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace med_box
// Params 1
// Checksum 0xf9e080e0, Offset: 0xb40
// Size: 0x75
function function_7410bc998f46df51( time )
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    hideduration = getdvarfloat( @"scr_support_box_proj_hide_duration", 0 );
    self setscriptablepartstate( "visibility", "hide", 0 );
    wait hideduration;
    self.madedamageable = 1;
    medbox_makedamageable();
    self setscriptablepartstate( "visibility", "show", 0 );
}

// Namespace med_box
// Params 0
// Checksum 0x485b040e, Offset: 0xbbd
// Size: 0xcf
function medbox_unset()
{
    if ( true )
    {
        foreach ( superequip in self.plantedsuperequip )
        {
            if ( superequip.equipmentref == "equip_medbox" )
            {
                superequip thread medbox_destroy( 1 );
                
                if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
                {
                    self [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( superequip );
                }
            }
        }
    }
}

// Namespace med_box
// Params 3
// Checksum 0x7fadae6e, Offset: 0xc94
// Size: 0x162
function medbox_destroy( immediate = !self.planted, wasdestroyed, var_4f1331fa70f48a8d )
{
    timeoutvfxname = "vfx_iw9_fieldupgrades_ammobox_timeout";
    
    if ( isdefined( self.timeoutvfxname ) )
    {
        timeoutvfxname = self.timeoutvfxname;
    }
    
    closetime = 0;
    
    if ( var_4f1331fa70f48a8d )
    {
        closetime = medbox_getcloseanimduration();
    }
    
    deletiondelay = 0;
    
    if ( !immediate )
    {
        deletiondelay = 0.1;
    }
    
    thread medbox_delete( deletiondelay, wasdestroyed );
    moving_platform = undefined;
    fxoriginoffset = undefined;
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        var_6978ba6f62479219 = self getlinkedparent();
        
        if ( isdefined( var_6978ba6f62479219 ) )
        {
            moving_platform = var_6978ba6f62479219;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        self setscriptablepartstate( "beacon", "neutral", 0 );
        self setscriptablepartstate( "hacked", "neutral", 0 );
        
        if ( var_4f1331fa70f48a8d )
        {
            self setscriptablepartstate( "anims", "close", 0 );
            wait closetime;
            self setscriptablepartstate( "anims", "closedIdle", 0 );
            wait 1;
        }
        
        if ( isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
        
        self setscriptablepartstate( "effects", "destroy", 0 );
    }
}

// Namespace med_box
// Params 2
// Checksum 0x38202e9e, Offset: 0xdfe
// Size: 0x13a
function medbox_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( isdefined( self.owner ) )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
        {
            self.owner [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( self );
        }
    }
    
    medbox_removeheadicon();
    medbox_makeunusable();
    supername = "super_med_box";
    
    if ( supername == "super_med_box" )
    {
        self.owner challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    }
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    wait deletiondelay;
    self delete();
}

// Namespace med_box
// Params 2
// Checksum 0x30dfd683, Offset: 0xf40
// Size: 0x80
function medbox_makeusable( equipmentname, hintstring )
{
    interactive::interactive_addusedcallbacktoentity( equipmentname );
    self.playersused = [];
    self.usedcount = 0;
    self makeusable();
    self setusepriority( -1 );
    self enablemissilehint( 1 );
    self setcursorhint( "HINT_NOICON" );
    self sethintstring( hintstring );
    self setuserange( 128 );
    self setuseholdduration( "duration_short" );
    self sethinttag( "tag_use" );
    thread medbox_watchallplayeruse();
}

// Namespace med_box
// Params 0
// Checksum 0xf8a70cf3, Offset: 0xfc8
// Size: 0x25
function medbox_makeunusable()
{
    self notify( #"medbox_makeunusable" );
    interactive::interactive_removeusedcallbackfromentity();
    self makeunusable();
    self.playersused = undefined;
}

// Namespace med_box
// Params 0
// Checksum 0xab0dac55, Offset: 0xff5
// Size: 0x4d
function medbox_watchallplayeruse()
{
    self endon( #"death" );
    self endon( #"medbox_makeunusable" );
    var_d94c20f799b7a19a = gettime();
    
    while ( true )
    {
        if ( gettime() >= var_d94c20f799b7a19a )
        {
            medbox_updateplayerusevisibility();
            var_d94c20f799b7a19a = gettime() + 150;
        }
        
        waitframe();
    }
}

// Namespace med_box
// Params 0
// Checksum 0x84bbbb25, Offset: 0x104a
// Size: 0xac
function medbox_updateplayerusevisibility()
{
    nearplayers = utility::playersnear( self.origin, 300 );
    
    foreach ( player in nearplayers )
    {
        if ( isdefined( player ) )
        {
            if ( !medbox_playercanuse( player ) )
            {
                self disableplayeruse( player );
                continue;
            }
            
            self enableplayeruse( player );
        }
    }
}

// Namespace med_box
// Params 0
// Checksum 0xec28f144, Offset: 0x10fe
// Size: 0xba
function medbox_updateplayersused()
{
    foreach ( player in self.playersused )
    {
        if ( isdefined( player ) )
        {
            entnum = player getentitynumber();
            
            if ( !player::isreallyalive( player ) && isdefined( self.playersused[ entnum ] ) )
            {
                self.playersused[ entnum ] = undefined;
                medbox_updateheadicon( player );
            }
        }
    }
}

// Namespace med_box
// Params 1
// Checksum 0xca0649d8, Offset: 0x11c0
// Size: 0x5b, Type: bool
function medbox_playercanuse( player )
{
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "crate_use" ) )
    {
        return false;
    }
    
    if ( isdefined( self.playersused[ player getentitynumber() ] ) )
    {
        return false;
    }
    
    if ( player_utility::playersareenemies( player, self.owner ) )
    {
        return false;
    }
    
    return true;
}

// Namespace med_box
// Params 1
// Checksum 0xa456b30e, Offset: 0x1224
// Size: 0x48
function medbox_onplayeruse( player )
{
    if ( !isdefined( self.equipmentref ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    medbox_playusesound( player );
    thread medbox_onplayeruseanim();
    self.var_e372bc89347f7dfc = 1;
    return 1;
}

// Namespace med_box
// Params 1
// Checksum 0xafd380f3, Offset: 0x1275
// Size: 0x20
function medbox_playusesound( player )
{
    if ( isdefined( player ) )
    {
        player playsoundtoplayer( "jup_med_box_use", player );
    }
}

// Namespace med_box
// Params 0
// Checksum 0xad681bc7, Offset: 0x129d
// Size: 0x59
function medbox_onplayeruseanim()
{
    self endon( #"death" );
    
    if ( self.onuseanimplaying )
    {
        return;
    }
    
    self setscriptablepartstate( "anims", "openUse", 0 );
    self.onuseanimplaying = 1;
    wait medbox_getuseanimduration();
    self setscriptablepartstate( "anims", "openIdle", 0 );
    self.onuseanimplaying = undefined;
}

// Namespace med_box
// Params 0
// Checksum 0x130705ba, Offset: 0x12fe
// Size: 0x83
function medbox_makedamageable()
{
    bundle = self.bundle;
    boxmaxhealth = 100;
    
    if ( isdefined( bundle ) )
    {
        boxmaxhealth = bundle.support_box_max_health ?? 100;
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        self thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( boxmaxhealth, "hitequip", &medbox_handlefataldamage, &functionals_utility::function_cdfa6ea614436cc );
    }
}

// Namespace med_box
// Params 1
// Checksum 0xd40e37a2, Offset: 0x1389
// Size: 0x29
function medbox_handlefataldamage( data )
{
    medbox_givepointsfordeath( data.attacker );
    thread medbox_destroy( 0, 1, 0 );
}

// Namespace med_box
// Params 0
// Checksum 0x39d6155, Offset: 0x13ba
// Size: 0x4f
function medbox_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( self.outlineid, self );
        }
    }
}

// Namespace med_box
// Params 1
// Checksum 0x8e670557, Offset: 0x1411
// Size: 0x41
function medbox_addheadicon( headicon )
{
    self.headiconbox = entityheadicons::setheadicon_singleimage( [], headicon, 20, 1, 1000, 100, undefined, 1 );
    self.headiconfaction = entityheadicons::setheadicon_equipment( self );
    medbox_updateheadiconallplayers();
}

// Namespace med_box
// Params 0
// Checksum 0x3ae38e18, Offset: 0x145a
// Size: 0x50
function medbox_removeheadicon()
{
    if ( isdefined( self.headiconbox ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconbox );
        self.headiconbox = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace med_box
// Params 2
// Checksum 0xc628843b, Offset: 0x14b2
// Size: 0xbc
function medbox_givepointsfordeath( attacker, fromemp )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"destroyed_equipment" );
            
            if ( fromemp )
            {
                var_c9f5190087459c78 = 1;
            }
            
            attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"destroyed_equipment", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_c9f5190087459c78 );
        }
    }
}

// Namespace med_box
// Params 4
// Checksum 0x9a792ed, Offset: 0x1576
// Size: 0x128
function medbox_givexpforuse( player, eventname, persstat, supername )
{
    if ( isdefined( self.owner ) && !player_utility::playersareenemies( self.owner, player ) )
    {
        if ( self.owner != player )
        {
            if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
            {
                self.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( eventname );
            }
        }
        
        if ( utility::issharedfuncdefined( #"pers", #"incpersstat" ) )
        {
            self.owner [[ utility::getsharedfunc( #"pers", #"incpersstat" ) ]]( persstat, 1 );
        }
        
        if ( utility::issharedfuncdefined( #"supers", #"hash_fc677b6b2e7fd6bf" ) )
        {
            self.owner [[ utility::getsharedfunc( #"supers", #"hash_fc677b6b2e7fd6bf" ) ]]( supername );
        }
        
        self.usedcount++;
    }
}

// Namespace med_box
// Params 1
// Checksum 0x41eec564, Offset: 0x16a6
// Size: 0x14
function medbox_onmovingplatformdeath( data )
{
    medbox_destroy( 0 );
}

// Namespace med_box
// Params 1
// Checksum 0xf62761c1, Offset: 0x16c2
// Size: 0x110
function function_e0964d1539421305( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"player", #"hash_45a211ad5df3fd3" ) )
    {
        superinfo = owner [[ utility::getsharedfunc( #"player", #"hash_45a211ad5df3fd3" ) ]]();
        
        if ( isdefined( superinfo ) && level.allowsupers )
        {
            if ( !self.var_e372bc89347f7dfc )
            {
                superinfo.wasrefunded = 1;
                
                if ( utility::issharedfuncdefined( #"supers", #"hash_79c2eee2c78b598" ) && utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) )
                {
                    owner [[ utility::getsharedfunc( #"supers", #"hash_79c2eee2c78b598" ) ]]( owner [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]() );
                }
            }
        }
    }
    
    medbox_destroy( 0 );
}

// Namespace med_box
// Params 1
// Checksum 0x59d95afa, Offset: 0x17da
// Size: 0xcc
function medbox_handlemovingplatforms( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &medbox_onmovingplatformdeath;
    data.invalidparentoverridecallback = &function_e0964d1539421305;
    data.endonstring = "death";
    data.validateaccuratetouching = 1;
    
    if ( isdefined( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
    {
        data.var_f07590e06f628942 = 1;
        self setmissileantilagged( 1 );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        self thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
}

// Namespace med_box
// Params 0
// Checksum 0x520fa2cd, Offset: 0x18ae
// Size: 0x30
function medbox_watchdisownedtimeout()
{
    self endon( #"death" );
    medbox_watchdisownedtimeoutinternal();
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread medbox_destroy( 0 );
    }
}

// Namespace med_box
// Params 0
// Checksum 0x19c6f81d, Offset: 0x18e6
// Size: 0x97
function medbox_watchdisownedtimeoutinternal()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    if ( self.lifetime > 0 )
    {
        if ( utility::issharedfuncdefined( #"hostmigration", #"waitLongDurationWithPause" ) )
        {
            [[ utility::getsharedfunc( #"hostmigration", #"waitLongDurationWithPause" ) ]]( self.lifetime );
        }
    }
}

// Namespace med_box
// Params 1
// Checksum 0x20027d84, Offset: 0x1985
// Size: 0x36
function medbox_empapplied( data )
{
    attacker = data.attacker;
    medbox_givepointsfordeath( attacker, 1 );
    thread medbox_destroy( 0 );
}

// Namespace med_box
// Params 1
// Checksum 0x6c7136a4, Offset: 0x19c3
// Size: 0x34
function medbox_haywireapplied( data )
{
    attacker = data.attacker;
    medbox_givepointsfordeath( attacker );
    thread medbox_destroy( 0 );
}

// Namespace med_box
// Params 0
// Checksum 0x4d9a30ac, Offset: 0x19ff
// Size: 0x83
function medbox_updateheadiconallplayers()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        medbox_updateheadicon( player );
    }
}

// Namespace med_box
// Params 1
// Checksum 0x389544ff, Offset: 0x1a8a
// Size: 0x102
function medbox_updateheadicon( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idbox = self.headiconbox;
    
    if ( !isdefined( idbox ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = player_utility::isfriendly( self.owner.team, player );
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    
    if ( isfriendly && !isused )
    {
        entityheadicons::setheadicon_addclienttomask( idbox, player );
        entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        entityheadicons::setheadicon_removeclientfrommask( idbox, player );
        entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( idbox, player );
    entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

#using_animtree( "scriptables" );

// Namespace med_box
// Params 0
// Checksum 0xaab6deb6, Offset: 0x1b94
// Size: 0xf
function medbox_getdeployanimduration()
{
    return getanimlength( %wm_support_box_ground_open );
}

// Namespace med_box
// Params 0
// Checksum 0xe8db09bb, Offset: 0x1bac
// Size: 0xf
function medbox_getuseanimduration()
{
    return getanimlength( %wm_support_box_ground_idle_open_use );
}

// Namespace med_box
// Params 0
// Checksum 0x6b5a8eb7, Offset: 0x1bc4
// Size: 0xf
function medbox_getcloseanimduration()
{
    return getanimlength( %wm_support_box_ground_close );
}

// Namespace med_box
// Params 2
// Checksum 0x9cfebde8, Offset: 0x1bdc
// Size: 0x169
function medbox_usedcallback( entity, player )
{
    if ( player.isjuggernaut && !isbrgamemode() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_used" );
        }
        
        return;
    }
    
    if ( entity medbox_playercanuse( player ) )
    {
        usesuccessful = 0;
        eventname = undefined;
        persstat = undefined;
        supername = undefined;
        
        if ( isdefined( entity.equipmentref ) )
        {
            eventname = #"hash_7ebcf978472ab1f4";
            persstat = "medBoxUsed";
            supername = "super_med_box";
            
            if ( getdvarint( @"hash_aab0b04330cc870b" ) >= 1 )
            {
                if ( !entity.var_2d412ee32d4a8a86 )
                {
                    thread function_4b9c663e099cee85( entity, player );
                    entity.var_2d412ee32d4a8a86 = 1;
                }
            }
            
            player.var_2fa0b0aec130a5f1 = getdvarfloat( @"hash_f0fb5d0ed88ab0c1" );
            player thread function_1387e137f6a33e62();
            usesuccessful = entity medbox_onplayeruse( player );
            
            if ( usesuccessful )
            {
                entity.playersused[ player getentitynumber() ] = player;
                entity medbox_updateheadicon( player );
                entity medbox_givexpforuse( player, eventname, persstat, supername );
            }
        }
    }
}

// Namespace med_box
// Params 1
// Checksum 0xd13ffeb4, Offset: 0x1d4d
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace med_box
// Params 0
// Checksum 0x8a5a7f38, Offset: 0x1d6c
// Size: 0x91
function function_1387e137f6a33e62()
{
    self endon( #"medboxhealed" );
    
    if ( isdefined( self.var_2fa0b0aec130a5f1 ) )
    {
        self waittill( #"death_or_disconnect" );
        self setscriptablepartstate( "medBoxVfx", "off", 0 );
        self.var_2fa0b0aec130a5f1 = undefined;
        self.var_34ef1f0b170c89ce = undefined;
        
        if ( isdefined( self.battlerageactive ) )
        {
            regendelay = getdvarfloat( @"hash_f7ec6896361f0e48" );
            playerhealth::function_fd91e6d94cab77e7( #"battlerage_beginsuper", regendelay );
        }
        
        self notify( #"medboxhealed" );
    }
}

// Namespace med_box
// Params 0
// Checksum 0x3cef6f9, Offset: 0x1e05
// Size: 0x1d
function function_3078635e613294f7()
{
    self.var_34ef1f0b170c89ce = undefined;
    self setscriptablepartstate( "medBoxVfx", "off", 0 );
}

// Namespace med_box
// Params 0
// Checksum 0x6cfd7ab, Offset: 0x1e2a
// Size: 0x4e
function function_4d9e17f21dca6a58()
{
    if ( isdefined( self.medboxhealed ) )
    {
        var_6df28cb7d62e41ae = "vfx_jup_equip_medcrate_vignette";
        
        if ( isdefined( self.var_6df28cb7d62e41ae ) )
        {
            var_6df28cb7d62e41ae = self.var_6df28cb7d62e41ae;
        }
        
        self setclientomnvar( "ui_med_box_effect_end", 0 );
        self.medboxhealed = undefined;
    }
}

// Namespace med_box
// Params 0
// Checksum 0x3b274c9, Offset: 0x1e80
// Size: 0x1e
function function_fdf8c421413d15cc()
{
    self setscriptablepartstate( "medBoxVfx", "vfx_start", 0 );
    self.var_34ef1f0b170c89ce = 1;
}

// Namespace med_box
// Params 2
// Checksum 0xf34c1324, Offset: 0x1ea6
// Size: 0x10b
function function_4b9c663e099cee85( grenade, player )
{
    teammates = player_utility::script_getplayersinradius( grenade.origin, 600, player.team, player );
    
    foreach ( teammate in teammates )
    {
        if ( isalive( teammate ) )
        {
            teammate.var_2fa0b0aec130a5f1 = getdvarfloat( @"hash_f0fb5d0ed88ab0c1" );
            teammate thread function_1387e137f6a33e62();
            usesuccessful = grenade medbox_onplayeruse( teammate );
            
            if ( usesuccessful )
            {
                grenade.playersused[ teammate getentitynumber() ] = teammate;
                grenade medbox_updateheadicon( teammate );
            }
        }
    }
}

