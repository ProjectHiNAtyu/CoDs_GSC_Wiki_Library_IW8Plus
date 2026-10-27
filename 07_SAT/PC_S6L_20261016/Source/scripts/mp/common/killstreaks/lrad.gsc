// scripts\mp\common\killstreaks\lrad.gsc  (hash_1850aaaae93cc88d.gscc) (size: 23996 Bytes / 0x5dbc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6519da0 (3595672992)
// size ...... 23996 (0x5dbc)
// includes .. 21  (offset: 0x5804)
// strings ... 82  (offset: 0x58ac)
// dev strs .. 8   (offset: 0x5d5c)
// exports ... 53  (offset: 0x3900)
// cseg ...... 0x57e + 0x3382 (0x3900)
// imports ... 183 (offset: 0x4148)
// animtree1 . 0   (offset: 0x5dbc)
// animtree2 . 0   (offset: 0x5dbc)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace lrad;

// Namespace lrad
// Params 0, eflags: 0x1
// Checksum 0x2581323f, Offset: 0x59c
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "lrad" ), &init );
}

// Namespace lrad
// Params 0, eflags: 0x4
// Checksum 0x95debbdd, Offset: 0x5bb
// Size: 0x11d
function private init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "lrad", &tryuselrad );
    }
    
    utility::registersharedfunc( #"lrad", #"tryusekillstreak", &tryuselrad );
    utility::registersharedfunc( #"lrad", #"lrad_hack", &lrad_hack );
    bundle = level.streakglobals.streakbundles[ "lrad" ];
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "lrad", bundle.deployweapon, #"donotregister" );
    lrad_initdvars();
    function_7d7c0ca4e6d19aa1();
    level.var_df7c1bc57349f4a7 = 0;
    level.var_1e48c6c1077f3921 = [];
    level.lrads = [];
    
    /#
        if ( isbrgamemode() )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            devgui::add_devgui_command( "<dev string:x3c>", "<dev string:x45>" );
            devgui::function_77df7fe7dd273e10();
        }
    #/
}

// Namespace lrad
// Params 0
// Checksum 0x1991add3, Offset: 0x6e0
// Size: 0x164
function lrad_initdvars()
{
    bundle = level.streakglobals.streakbundles[ "lrad" ];
    
    /#
        setdvarifuninitialized( @"scr_lrad_debug", 0 );
        setdvarifuninitialized( @"hash_5f9bf6b2e15e5727", 0 );
        setdvarifuninitialized( @"scr_lrad_debug_duration", 1000 );
    #/
    
    setdvarifuninitialized( @"scr_lrad_lifetime", bundle.lradlifetime );
    setdvarifuninitialized( @"scr_lrad_max_health", bundle.maxhealth );
    setdvarifuninitialized( @"hash_d7fd0b0d5f62285c", 0.85 );
    setdvarifuninitialized( @"hash_6aa2e155bf9747", 16 );
    setdvarifuninitialized( @"hash_b4d9a80ce75c617", bundle.var_e06cc2a7fba018bf );
    setdvarifuninitialized( @"hash_b27192e0593d2245", bundle.lradtriggerradius );
    setdvarifuninitialized( @"hash_791416d97b1899ba", 35 );
    setdvarifuninitialized( @"hash_1676fc44b285c55a", bundle.var_d9dfd0eb9d4d80ef );
    setdvarifuninitialized( @"hash_2ef1444b14cdcc27", bundle.var_5a287474adbd9e5c );
    setdvarifuninitialized( @"hash_4469252783a3ea7d", bundle.var_45f9a1113d6aabdf );
    setdvarifuninitialized( @"hash_dd550cefcbd1712", bundle.maxhealth );
    setdvarifuninitialized( @"hash_abec145fdf5e6352", 1 );
}

// Namespace lrad
// Params 0
// Checksum 0xfd7d897e, Offset: 0x84c
// Size: 0x87
function function_7d7c0ca4e6d19aa1()
{
    game[ "dialog" ][ "lrad_ause" ] = "ause";
    game[ "dialog" ][ "lrad_euse" ] = "euse";
    game[ "dialog" ][ "lrad_lcra" ] = "lcra";
    game[ "dialog" ][ "lrad_ltim" ] = "ltim";
    game[ "dialog" ][ "lrad_earn" ] = "earn";
    game[ "dialog" ][ "lrad_friendly_online" ] = "grdn_grav_kllc";
    game[ "dialog" ][ "lrad_friendly_timeout" ] = "grdn_grav_ktlt";
}

// Namespace lrad
// Params 1
// Checksum 0xa5a4d153, Offset: 0x8db
// Size: 0x335, Type: bool
function tryuselrad( streakinfo = killstreak_utility::createstreakinfo( "lrad", self ) )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    streakinfo.bundle = level.streakglobals.streakbundles[ "lrad" ];
    streakinfo.weaponname = streakinfo.bundle.deployweapon;
    
    if ( !function_f535df4a64b45890() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/lrad_count_over_limit" );
        }
        
        return false;
    }
    
    thread function_b288d60b65552366();
    lradgrenade = lrad_deploy( streakinfo );
    
    if ( !isdefined( lradgrenade ) )
    {
        return false;
    }
    
    lradgrenade.streakinfo = streakinfo;
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( streakinfo.bundle, lradgrenade.streakinfo.mpstreaksysteminfo.blueprintindex );
    lradgrenade setgenericblueprint( genericblueprintname );
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    maxhealth = getdvarfloat( @"scr_lrad_max_health" );
    functionals_utility::function_581632a552d7d7d6( "lrad", "destroyed_lrad", "destroyed_lrad", "callout_destroyed_lrad" );
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        lradgrenade thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( maxhealth, "hitequip", &functionals_utility::functionals_handlefataldamage, &lrad_handledamage, 0 );
    }
    
    lradgrenade function_2c5edeffbbef8d0e();
    lradgrenade function_d2f9e7b2e1f3c1d();
    lradgrenade haywire::function_7f69a1eb3d590f76( &lrad_haywireapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        lradgrenade.ksempapplycallback = &lrad_empapplied;
    }
    
    lradgrenade emp_debuff::set_start_emp_callback( &lrad_empapplied );
    lradgrenade haywire::function_d7496c23fe4085d4( &function_c517b58462058bc7 );
    
    if ( level.killstreak_emp_initialized )
    {
        lradgrenade.ksempclearcallback = &lrad_empcleared;
    }
    
    lradgrenade emp_debuff::set_clear_emp_callback( &lrad_empcleared );
    thread lrad_watchpickup( lradgrenade, streakinfo );
    thread lrad_disableplayeruseonconnect( lradgrenade, lradgrenade.useownerobj );
    maxlifetime = getdvarfloat( @"scr_lrad_lifetime" );
    lradgrenade thread functionals_utility::functionals_timeout( maxlifetime, @"scr_lrad_debug", &lrad_timeout );
    lradgrenade thread function_ac053a0f2eb20310();
    
    /#
        lradgrenade thread function_333dd57938d79414( @"scr_lrad_debug" );
    #/
    
    lradgrenade functionals_utility::function_f9c3bc385df6f245( streakinfo, &function_7a90f422ff4ca9b7, &lrad_destroy );
    self notify( #"munitions_used", "lrad" );
    self notify( #"lrad_placed" );
    level.lrads[ level.lrads.size ] = lradgrenade;
    
    if ( isdefined( level.var_58b2390d08c7fe29 ) )
    {
        level thread [[ level.var_58b2390d08c7fe29 ]]( self );
    }
    
    return true;
}

// Namespace lrad
// Params 0
// Checksum 0x9b267909, Offset: 0xc19
// Size: 0x5f
function function_ac053a0f2eb20310()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"iscarried" );
    self.owner waittill( #"joined_team" );
    callback::callback( #"on_functional_death" );
}

// Namespace lrad
// Params 1
// Checksum 0xf665c2c5, Offset: 0xc80
// Size: 0x86
function function_b288d60b65552366( lradgrenade )
{
    self endon( #"lrad_placed" );
    self endon( #"lrad_put_away" );
    ownerteam = self.team;
    
    while ( true )
    {
        if ( !player::isreallyalive( self ) )
        {
            level.var_df7c1bc57349f4a7--;
            
            if ( isdefined( level.var_1e48c6c1077f3921[ ownerteam ] ) )
            {
                level.var_1e48c6c1077f3921[ ownerteam ]--;
            }
            
            if ( isdefined( lradgrenade ) )
            {
                lradgrenade lrad_destroy();
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace lrad
// Params 0
// Checksum 0xe1426167, Offset: 0xd0e
// Size: 0x1ce, Type: bool
function function_f535df4a64b45890()
{
    bundle = level.streakglobals.streakbundles[ "lrad" ];
    
    if ( level.lrads.size >= bundle.var_ed2c8584a324c128 || level.lrads.size + level.var_df7c1bc57349f4a7 > bundle.var_ed2c8584a324c128 )
    {
        return false;
    }
    
    var_8279493d168f2355 = 0;
    var_30379d17eadd2aa4 = 0;
    var_f348463fcf9064e1 = 0;
    
    foreach ( lrad in level.lrads )
    {
        if ( distance2d( lrad.origin, self.origin ) <= bundle.var_728205a8cffe3d02 )
        {
            var_f348463fcf9064e1++;
        }
        
        if ( lrad.owner == self )
        {
            var_30379d17eadd2aa4++;
            var_8279493d168f2355++;
            continue;
        }
        
        if ( lrad.team == self.team )
        {
            var_8279493d168f2355++;
        }
    }
    
    if ( var_f348463fcf9064e1 >= bundle.var_c4197a3819d400b4 )
    {
        return false;
    }
    
    if ( isdefined( level.var_1e48c6c1077f3921[ self.team ] ) )
    {
        if ( var_8279493d168f2355 >= bundle.var_2e7e4b1535b5b94b || var_8279493d168f2355 + level.var_1e48c6c1077f3921[ self.team ] > bundle.var_2e7e4b1535b5b94b )
        {
            return false;
        }
    }
    
    if ( var_30379d17eadd2aa4 >= bundle.var_140e55f221202c83 )
    {
        return false;
    }
    
    return true;
}

// Namespace lrad
// Params 1
// Checksum 0xbba67d13, Offset: 0xee5
// Size: 0x12f
function lrad_deploy( streakinfo )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    endonnotify = "sentry_placement_failed";
    weaponobj = makeweapon( streakinfo.bundle.deployweapon );
    
    if ( utility::issharedfuncdefined( #"weapons", #"watchforplacementfirestate" ) )
    {
        self thread [[ utility::getsharedfunc( #"weapons", #"watchforplacementfirestate" ) ]]( streakinfo, endonnotify, weaponobj );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, 1, undefined, undefined, &function_62fe5db98028dc3a );
    
    if ( !deployresult )
    {
        self notify( endonnotify );
        return;
    }
    
    function_9f2e1bd80d8b933( 1 );
    level.var_df7c1bc57349f4a7++;
    
    if ( !isdefined( level.var_1e48c6c1077f3921[ self.team ] ) )
    {
        level.var_1e48c6c1077f3921[ self.team ] = 1;
    }
    else
    {
        level.var_1e48c6c1077f3921[ self.team ]++;
    }
    
    lradgrenade = lrad_place( streakinfo );
    function_9f2e1bd80d8b933( 0 );
    return lradgrenade;
}

// Namespace lrad
// Params 1
// Checksum 0x67ec3808, Offset: 0x101d
// Size: 0x296
function lrad_place( streakinfo )
{
    marker = lrad_watchplacement( streakinfo, 0, 0.25 );
    lradgrenade = undefined;
    
    if ( isdefined( marker ) )
    {
        lradgrenade = function_46d9be0d689d101( marker );
        
        if ( isdefined( marker.moving_platform ) )
        {
            lradgrenade.moving_platform = marker.moving_platform;
            lradgrenade.moving_platform_offset = marker.moving_platform_offset;
            lradgrenade.moving_platform_angles_offset = marker.moving_platform_angles_offset;
            lradgrenade linkto( marker.moving_platform, "", marker.moving_platform_offset, marker.moving_platform_angles_offset );
        }
        
        lradgrenade.colmodel show();
        lradgrenade.colmodel.angles = lradgrenade.angles;
        lradgrenade.colmodel.origin = lradgrenade.origin;
        lradgrenade.colmodel linkto( lradgrenade );
        lradgrenade setscriptablepartstate( "beam", "active", 0 );
        lradgrenade thread function_ad2d27df604541cf();
        lradgrenade.vodestroyed = "lrad_teamleader_destroyed";
        lradgrenade.streakinfo = streakinfo;
        
        if ( isbrgamemode() )
        {
            if ( utility::issharedfuncdefined( #"audio", #"hash_671f2d06615c8a65" ) )
            {
                level thread [[ utility::getsharedfunc( #"audio", #"hash_671f2d06615c8a65" ) ]]( "lrad_friendly_online", lradgrenade.owner.team, 1, undefined, undefined, "dx_br_jpbm_" );
            }
        }
        else if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( lradgrenade.owner, "lrad" );
        }
        
        if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
        {
            data = spawnstruct();
            data.deathoverridecallback = &function_494d4d9f42d70e8b;
            
            if ( isdefined( lradgrenade.moving_platform ) && utility::is_moving_platform_ent( lradgrenade.moving_platform ) )
            {
                data.var_f07590e06f628942 = 1;
            }
            
            lradgrenade thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
        }
    }
    
    return lradgrenade;
}

// Namespace lrad
// Params 0
// Checksum 0x724bb56a, Offset: 0x12bc
// Size: 0x28
function function_d2f9e7b2e1f3c1d()
{
    self setscriptablepartstate( "beam", "active", 0 );
    thread function_ad2d27df604541cf();
    thread function_8abf6378cbc8668f();
    thread function_d79a3546673123ab();
}

// Namespace lrad
// Params 0
// Checksum 0xce103a09, Offset: 0x12ec
// Size: 0x2a
function function_d1bef508358df27d()
{
    self setscriptablepartstate( "beam", "idle", 0 );
    self stoploopsound( "jup_kls_lrad_beam_outside" );
    self notify( #"beamstop" );
}

// Namespace lrad
// Params 0
// Checksum 0xf697eca7, Offset: 0x131e
// Size: 0x4d
function function_ad2d27df604541cf()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"iscarried" );
    
    if ( !self.ishaywire )
    {
        wait 0.6;
    }
}

// Namespace lrad
// Params 2
// Checksum 0xd3b93b61, Offset: 0x1373
// Size: 0x2b8
function function_46d9be0d689d101( marker, lradgrenade )
{
    bundle = level.streakglobals.streakbundles[ "lrad" ];
    verticalspawnoffset = getdvarint( @"hash_6aa2e155bf9747" );
    
    if ( !isdefined( lradgrenade ) )
    {
        lradgrenade = self launchgrenade( bundle.spawnweapon, marker.location + ( 0, 0, verticalspawnoffset ), ( 0, 0, 0 ) );
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "lrad", self );
        }
    }
    else
    {
        lradgrenade.origin = marker.location + ( 0, 0, verticalspawnoffset );
    }
    
    lradgrenade.angles = self.angles;
    lradgrenade.team = self.team;
    lradgrenade.owner = self;
    lradgrenade setentityhudoutlinedata( 3, lradgrenade.team );
    lradgrenade show();
    lradgrenade.colmodel = spawn( "script_model", lradgrenade.origin );
    lradgrenade.colmodel.team = lradgrenade.team;
    lradgrenade.colmodel.owner = lradgrenade.owner;
    lradgrenade.colmodel setmodel( "vm_jup_2h_lrad_00_invis_base" );
    lradgrenade.colmodel dontinterpolate();
    lradgrenade.colmodel hide();
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        lradgrenade [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( "lrad", "Killstreak_Ground", self, 0, 1, 55, "isCarried" );
    }
    
    function_f2fdb0f9326a7094( lradgrenade );
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        lradgrenade.minimapid = lradgrenade [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, lradgrenade.team, 1, 1, 1 );
        objidpoolmanager::update_objective_description( lradgrenade.minimapid, &"killstreaks/lrad" );
    }
    
    lradgrenade setscriptablepartstate( "spawned", "deploy", 0 );
    return lradgrenade;
}

// Namespace lrad
// Params 1
// Checksum 0x790e7f1a, Offset: 0x1634
// Size: 0x18c
function function_f2fdb0f9326a7094( lradgrenade )
{
    hinttag = "j_mount";
    hintpos = lradgrenade gettagorigin( hinttag );
    
    if ( !isdefined( lradgrenade.useownerobj ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"createhintobject" ) )
        {
            lradgrenade.useownerobj = [[ utility::getsharedfunc( #"game", #"createhintobject" ) ]]( hintpos, "HINT_BUTTON", undefined, &"killstreaks_hints/lrad_use", undefined, undefined, "show" );
        }
    }
    else
    {
        hintpos = lradgrenade gettagorigin( hinttag );
        lradgrenade.useownerobj setusableenabled( 1 );
        lradgrenade.useownerobj dontinterpolate();
        lradgrenade.useownerobj.origin = hintpos;
    }
    
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            lradgrenade.useownerobj disableplayeruse( player );
            continue;
        }
        
        lradgrenade.useownerobj enableplayeruse( player );
    }
    
    lradgrenade.useownerobj linkto( lradgrenade, hinttag );
}

// Namespace lrad
// Params 3
// Checksum 0xd6578b3b, Offset: 0x17c8
// Size: 0x129
function lrad_watchplacement( streakinfo, ignorecancel, delaytime )
{
    thread lrad_delayplacementinstructions( delaytime );
    marker = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"gettargetmarker" ) )
    {
        marker = [[ utility::getsharedfunc( #"killstreak", #"gettargetmarker" ) ]]( streakinfo, ignorecancel );
    }
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        if ( player::isreallyalive() )
        {
            lrad_switchbacklastweapon( streakinfo.bundle.deployweapon, undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( isdefined( self ) && player::isreallyalive() )
    {
        self freezecontrols( 1 );
    }
    else
    {
        return;
    }
    
    if ( self hasweapon( streakinfo.bundle.deployweapon ) )
    {
        thread lrad_switchbacklastweapon( streakinfo.bundle.deployweapon, 1, 1 );
    }
    
    delayspawntime = getdvarfloat( @"hash_d7fd0b0d5f62285c" );
    wait delayspawntime;
    self freezecontrols( 0 );
    return marker;
}

// Namespace lrad
// Params 1
// Checksum 0xa639c49b, Offset: 0x18fa
// Size: 0x76
function lrad_delayplacementinstructions( delaytime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"lrad_placed" );
    self endon( #"lrad_put_away" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    self setclientomnvar( "ui_turret_placement", 1 );
    thread manual_turret::manualturret_clearplacementinstructions( "death" );
    thread manual_turret::manualturret_clearplacementinstructions( "lrad_placed" );
    thread manual_turret::manualturret_clearplacementinstructions( "lrad_put_away" );
}

// Namespace lrad
// Params 1
// Checksum 0x65df7e28, Offset: 0x1978
// Size: 0xcf
function function_7a90f422ff4ca9b7( callbackparams )
{
    meansofdeath = callbackparams.meansofdeath;
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj setusableenabled( 0 );
    }
    
    if ( isdefined( meansofdeath ) && ( meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE_SPLASH" ) )
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    else
    {
        self playsound( "sentry_explode_smoke" );
        self setscriptablepartstate( "explode", "regular" );
    }
    
    wait 0.2;
    self setscriptablepartstate( "visibility", "hide" );
    self setscriptablepartstate( "beam", "idle" );
    self hide();
}

// Namespace lrad
// Params 1
// Checksum 0xb51722f3, Offset: 0x1a4f
// Size: 0x151
function lrad_destroy( delaytime )
{
    if ( isdefined( delaytime ) )
    {
        wait delaytime;
    }
    
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj delete();
    }
    
    if ( isdefined( self.colmodel ) )
    {
        self.colmodel delete();
    }
    
    if ( isdefined( self.stuntrigger ) )
    {
        foreach ( player in self.stuntrigger.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            self.stuntrigger.playersintrigger[ player getentitynumber() ] = undefined;
            
            if ( isalive( player ) )
            {
                player function_18e1dc10a25cb472();
            }
        }
        
        self.stuntrigger delete();
    }
    
    level.lrads = arrayremove( level.lrads, self );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace lrad
// Params 1
// Checksum 0xec8a7526, Offset: 0x1ba8
// Size: 0x34
function function_494d4d9f42d70e8b( data )
{
    data.meansofdeath = "MOD_CRUSH";
    function_7a90f422ff4ca9b7( data );
    lrad_destroy();
    functionals_utility::clearminimapid();
}

// Namespace lrad
// Params 1
// Checksum 0x81fa0a08, Offset: 0x1be4
// Size: 0x95
function lrad_timeout( params )
{
    if ( isbrgamemode() )
    {
        if ( utility::issharedfuncdefined( #"audio", #"hash_671f2d06615c8a65" ) )
        {
            level thread [[ utility::getsharedfunc( #"audio", #"hash_671f2d06615c8a65" ) ]]( "lrad_friendly_timeout", self.owner.team, 1, undefined, undefined, "dx_br_jpbm_" );
        }
        
        return;
    }
    
    self.owner killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, "lrad_teamleader_timeout", #"leave" );
}

// Namespace lrad
// Params 4
// Checksum 0xdd6f1e2e, Offset: 0x1c81
// Size: 0xd3
function lrad_switchbacklastweapon( deployweapon, immediateswitch, optionaltimedelay, var_77ff9108c0211191 )
{
    if ( optionaltimedelay > 0 )
    {
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        wait optionaltimedelay;
    }
    
    var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
    lastweaponobj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, var_834e1ea1f94aef8a );
    level.var_df7c1bc57349f4a7--;
    level.var_1e48c6c1077f3921[ self.team ]--;
    
    if ( immediateswitch )
    {
        inventory_utility::_switchtoweaponimmediate( lastweaponobj );
    }
    else
    {
        inventory_utility::_switchtoweapon( lastweaponobj );
    }
    
    inventory_utility::_takeweapon( deployweapon );
    
    if ( var_77ff9108c0211191 )
    {
        self notify( #"lrad_put_away" );
    }
}

// Namespace lrad
// Params 3
// Checksum 0x4888d2ba, Offset: 0x1d5c
// Size: 0x2d
function function_62fe5db98028dc3a( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace lrad
// Params 1
// Checksum 0xdecbc11f, Offset: 0x1d91
// Size: 0xb9
function function_9f2e1bd80d8b933( disableactions )
{
    if ( player::isreallyalive() )
    {
        if ( disableactions )
        {
            val::set( "lrad_placement", "sprint", 0 );
            val::set( "lrad_placement", "weapon_switch", 0 );
            val::set( "lrad_placement", "offhand_weapons", 0 );
            val::set( "lrad_placement", "melee", 0 );
            val::set( "lrad_placement", "execution_attack", 0 );
            val::set( "lrad_placement", "ladder_placement", 0 );
            val::set( "lrad_placement", "mantle", 0 );
            val::set( "lrad_placement", "armor", 0 );
            return;
        }
        
        val::reset_all( "lrad_placement" );
    }
}

// Namespace lrad
// Params 2
// Checksum 0xa03b30eb, Offset: 0x1e52
// Size: 0x82
function lrad_disableplayeruseonconnect( lradgrenade, useobj )
{
    if ( isdefined( lradgrenade ) )
    {
        lradgrenade endon( #"death" );
        lradgrenade endon( #"lrad_dying" );
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"lrad_hacked" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        useobj disableplayeruse( player );
    }
}

// Namespace lrad
// Params 2
// Checksum 0xfc89303, Offset: 0x1edc
// Size: 0xc7
function lrad_watchpickup( lradgrenade, streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"lrad_hacked" );
    lradgrenade endon( #"lrad_dying" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        lradgrenade.useownerobj waittill( #"trigger", player );
        
        if ( isdefined( player ) && !lrad_canpickup( player ) )
        {
            continue;
        }
        
        lradgrenade.useownerobj setusableenabled( 0 );
        level.var_df7c1bc57349f4a7++;
        level.var_1e48c6c1077f3921[ self.team ]++;
        thread lrad_setcarried( lradgrenade, streakinfo );
        thread function_674f453de9b2e865();
    }
}

// Namespace lrad
// Params 0
// Checksum 0xf9be93ef, Offset: 0x1fab
// Size: 0x98
function function_674f453de9b2e865()
{
    var_ef2b455e9254c686 = self.var_9faea70b0ee9cf4a;
    
    if ( !isdefined( var_ef2b455e9254c686 ) )
    {
        return;
    }
    
    foreach ( ent in var_ef2b455e9254c686 )
    {
        if ( isalive( ent ) )
        {
            ent thread function_18e1dc10a25cb472();
        }
    }
}

// Namespace lrad
// Params 1
// Checksum 0x8c38ce0a, Offset: 0x204b
// Size: 0x78, Type: bool
function lrad_canpickup( player )
{
    if ( player != self )
    {
        return false;
    }
    
    if ( player.insertingarmorplate )
    {
        return false;
    }
    
    if ( player.isjuggernaut )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_picked_up" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace lrad
// Params 2
// Checksum 0xf0603074, Offset: 0x20cc
// Size: 0x187
function lrad_setcarried( lradgrenade, streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    function_553a4d1c5a61b338( lradgrenade );
    function_dad46a0322997aa7( lradgrenade );
    lradgrenade functionals_utility::clearminimapid();
    function_7786954b718a9b09( lradgrenade );
    lradgrenade function_91f325beb5f864d7();
    self playsound( "jup_kls_lrad_pickup" );
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    
    if ( utility::issharedfuncdefined( #"weapons", #"watchforplacementfirestate" ) )
    {
        self thread [[ utility::getsharedfunc( #"weapons", #"watchforplacementfirestate" ) ]]( streakinfo, endonnotify );
    }
    
    inventory_utility::_giveweapon( streakinfo.bundle.deployweapon );
    switchsuccess = inventory_utility::domonitoredweaponswitch( streakinfo.bundle.deployweapon, 1 );
    
    if ( !switchsuccess )
    {
        return 0;
    }
    
    function_9f2e1bd80d8b933( 1 );
    thread function_b288d60b65552366( lradgrenade );
    marker = lrad_watchplacement( streakinfo, 1, 0.25 );
    function_9f2e1bd80d8b933( 0 );
    
    if ( !isdefined( marker ) )
    {
        return 0;
    }
    
    function_7853c0863f602b55( marker, lradgrenade );
    maxlifetime = getdvarfloat( @"scr_lrad_lifetime" );
    lradgrenade thread functionals_utility::functionals_timeout( maxlifetime, @"scr_lrad_debug" );
    
    /#
        lradgrenade thread function_333dd57938d79414( @"scr_lrad_debug" );
    #/
}

// Namespace lrad
// Params 1
// Checksum 0xea0eb6d7, Offset: 0x225b
// Size: 0xa4
function function_dad46a0322997aa7( lradgrenade )
{
    linkedchildren = lradgrenade getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( isdefined( child ) && child != lradgrenade.stuntrigger )
        {
            child unlink();
        }
    }
}

// Namespace lrad
// Params 1
// Checksum 0x8f536c97, Offset: 0x2307
// Size: 0x68
function function_7786954b718a9b09( lradgrenade )
{
    lradgrenade hide();
    lradgrenade.colmodel unlink();
    lradgrenade.colmodel hide();
    lradgrenade.stuntrigger hide();
    lradgrenade.iscarried = 1;
    lradgrenade notify( #"iscarried" );
    lradgrenade emp_debuff::allow_emp( 0 );
}

// Namespace lrad
// Params 2
// Checksum 0xa23b962e, Offset: 0x2377
// Size: 0xc0
function function_7853c0863f602b55( marker, lradgrenade )
{
    function_46d9be0d689d101( marker, lradgrenade );
    lradgrenade.colmodel show();
    lradgrenade.colmodel.angles = lradgrenade.angles;
    lradgrenade.colmodel.origin = lradgrenade.origin;
    lradgrenade.colmodel linkto( lradgrenade );
    lradgrenade.stuntrigger show();
    lradgrenade.iscarried = 0;
    lradgrenade emp_debuff::allow_emp( 1 );
    lradgrenade function_aed862dfa64239c7();
    self notify( #"lrad_placed" );
}

// Namespace lrad
// Params 1
// Checksum 0x8e60c696, Offset: 0x243f
// Size: 0x49
function function_553a4d1c5a61b338( lradgrenade )
{
    if ( isdefined( lradgrenade ) )
    {
        if ( isdefined( lradgrenade.moving_platform ) )
        {
            lradgrenade.moving_platform = undefined;
            lradgrenade.moving_platform_offset = undefined;
            lradgrenade.moving_platform_angles_offset = undefined;
        }
        
        lradgrenade unlink();
    }
}

// Namespace lrad
// Params 1
// Checksum 0x1371eb55, Offset: 0x2490
// Size: 0x51, Type: bool
function function_ab0a0cdbe0eb8dd( weaponref )
{
    bundle = level.streakglobals.streakbundles[ "lrad" ];
    return weaponref == bundle.spawnweapon || weaponref == bundle.deployweapon;
}

// Namespace lrad
// Params 1
// Checksum 0xfb75cf6d, Offset: 0x24ea
// Size: 0x67
function lrad_haywireapplied( data )
{
    attacker = data.attacker;
    
    if ( !self.ishaywire )
    {
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            self.ishaywire = 1;
            thread function_f307e378ec188404();
        }
    }
    
    self setscriptablepartstate( "haywire", "active", 0 );
}

// Namespace lrad
// Params 1
// Checksum 0x34ef21ea, Offset: 0x2559
// Size: 0x67
function lrad_empapplied( data )
{
    attacker = data.attacker;
    
    if ( !self.ishaywire )
    {
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            self.ishaywire = 1;
            function_d1bef508358df27d();
        }
    }
    
    self setscriptablepartstate( "haywire", "active", 0 );
}

// Namespace lrad
// Params 1
// Checksum 0x523d9fbe, Offset: 0x25c8
// Size: 0x27
function function_c517b58462058bc7( data )
{
    self.ishaywire = 0;
    self setscriptablepartstate( "haywire", "neutral", 0 );
}

// Namespace lrad
// Params 1
// Checksum 0xa6880f00, Offset: 0x25f7
// Size: 0x2e
function lrad_empcleared( data )
{
    self.ishaywire = 0;
    function_d2f9e7b2e1f3c1d();
    self setscriptablepartstate( "haywire", "neutral", 0 );
}

// Namespace lrad
// Params 0
// Checksum 0x19e20e69, Offset: 0x262d
// Size: 0x9f
function function_f307e378ec188404()
{
    self endon( #"death" );
    self.var_be4259ca586337ce = 1;
    
    while ( self.ishaywire )
    {
        if ( self.var_be4259ca586337ce )
        {
            self.var_be4259ca586337ce = 0;
            function_d1bef508358df27d();
            waittime = randomfloatrange( 0.75, 1.75 );
            wait waittime;
        }
        else
        {
            self.var_be4259ca586337ce = 1;
            function_d2f9e7b2e1f3c1d();
            waittime = randomfloatrange( 0.15, 0.35 );
            wait waittime;
        }
        
        waitframe();
    }
    
    if ( !self.var_be4259ca586337ce )
    {
        function_d2f9e7b2e1f3c1d();
    }
}

// Namespace lrad
// Params 0
// Checksum 0x32645b01, Offset: 0x26d4
// Size: 0xef
function function_2c5edeffbbef8d0e()
{
    trigger_length = getdvarint( @"hash_b4d9a80ce75c617" );
    trigger_radius = getdvarint( @"hash_b27192e0593d2245" );
    height_offset = getdvarint( @"hash_791416d97b1899ba" );
    self.stuntrigger = spawn( "trigger_rotatable_radius", self.origin, 0, trigger_radius, trigger_length );
    function_aed862dfa64239c7();
    self.stuntrigger.angles = self.angles + ( 90, 0, 0 );
    self.stuntrigger.origin = self.origin + ( 0, 0, height_offset );
    self.stuntrigger.playersintrigger = [];
    self.stuntrigger enablelinkto();
    self.stuntrigger linkto( self );
}

// Namespace lrad
// Params 0
// Checksum 0xedd6bec8, Offset: 0x27cb
// Size: 0x1df
function function_aed862dfa64239c7()
{
    if ( utility::issharedfuncdefined( #"spawn", #"hash_88754f310dcca99e" ) )
    {
        forward = anglestoforward( self.angles );
        trigger_length = getdvarint( @"hash_b4d9a80ce75c617" );
        lradend = self.origin + forward * trigger_length;
        contents = physics_createcontents( [ "physicscontents_ainoshoot", "physicscontents_ainosight", "physicscontents_explosionclip", "physicscontents_vehicle" ] );
        castresult = physics_raycast( self.origin, lradend, contents, undefined, 0, "physicsquery_closest" );
        
        if ( isdefined( castresult ) && castresult.size > 0 )
        {
            castend = castresult[ 0 ][ "position" ];
            lraddistance = distance( self.origin, castend );
        }
        else
        {
            lraddistance = trigger_length;
        }
        
        bundle = level.streakglobals.streakbundles[ "lrad" ];
        var_e977ed937427c224 = getdvarint( @"hash_c6ad55369ab9a6c8", bundle.var_34f33864824bb07f );
        var_1b4cd2f79f5c3766 = ceil( lraddistance / var_e977ed937427c224 );
        self.dangerzones = [];
        currentorigin = self.origin + var_e977ed937427c224 / 2 * forward;
        lifetime = getdvarfloat( @"scr_lrad_lifetime" );
        
        for ( i = 0; i < var_1b4cd2f79f5c3766 ; i++ )
        {
            self.dangerzones[ i ] = killstreak_utility::function_e6fc48237c0a5166( #"hash_eafb9a6b88def4ca", currentorigin, self.team, self.owner );
            currentorigin += var_e977ed937427c224 * forward;
        }
    }
}

// Namespace lrad
// Params 0
// Checksum 0xec11bf49, Offset: 0x29b2
// Size: 0x8a
function function_91f325beb5f864d7()
{
    if ( !isdefined( self.dangerzones ) )
    {
        return;
    }
    
    foreach ( dangerzone in self.dangerzones )
    {
        killstreak_utility::function_43ef8750f44fafce( dangerzone );
    }
}

// Namespace lrad
// Params 0
// Checksum 0x92a286d8, Offset: 0x2a44
// Size: 0x223
function function_8abf6378cbc8668f()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"beamstop" );
    
    while ( true )
    {
        self.stuntrigger waittill( #"trigger" );
        entities_players = level.players;
        entities_ai = getaiarray();
        allentities = arraycombineunique( entities_players, entities_ai );
        var_8ad0f64e430211ee = self.stuntrigger getistouchingentities( allentities );
        self.owner.var_9faea70b0ee9cf4a = var_8ad0f64e430211ee;
        
        foreach ( ent in var_8ad0f64e430211ee )
        {
            var_314203ae49cb3ab3 = 0;
            
            /#
                debugactive = getdvarint( @"scr_lrad_debug" );
                
                if ( debugactive > 0 )
                {
                    iprintlnbold( ent.name + "<dev string:x7f>" );
                    var_314203ae49cb3ab3 = getdvarint( @"hash_5f9bf6b2e15e5727" );
                }
            #/
            
            if ( function_2bbd9db06de0e20c( ent, var_314203ae49cb3ab3 ) )
            {
                raycastresults = function_898c36ca19d19e1c( ent );
                
                if ( raycastresults.size == 0 )
                {
                    stuntime = getdvarfloat( @"hash_2ef1444b14cdcc27" );
                    ent function_13cbc814c6e791a2( stuntime, self );
                    self.stuntrigger.playersintrigger[ ent getentitynumber() ] = ent;
                }
                else if ( function_1a4e15cb9ac000e1( raycastresults ) )
                {
                    stuntime = getdvarfloat( @"hash_4469252783a3ea7d" );
                    ent function_13cbc814c6e791a2( stuntime, self );
                    self.stuntrigger.playersintrigger[ ent getentitynumber() ] = ent;
                }
            }
            
            waitframe();
        }
        
        var_bc3a26d801f367b2 = getdvarfloat( @"hash_1676fc44b285c55a" );
        wait var_bc3a26d801f367b2;
    }
}

// Namespace lrad
// Params 0
// Checksum 0x940004c8, Offset: 0x2c6f
// Size: 0x11a
function function_d79a3546673123ab()
{
    self endon( #"death" );
    self endon( #"beamstop" );
    
    while ( true )
    {
        foreach ( id, player in self.stuntrigger.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.stuntrigger.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                self.stuntrigger.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( player istouching( self.stuntrigger ) )
            {
                continue;
            }
            
            self.stuntrigger.playersintrigger[ player getentitynumber() ] = undefined;
            player function_18e1dc10a25cb472();
        }
        
        waitframe();
    }
}

// Namespace lrad
// Params 2
// Checksum 0xb29240d4, Offset: 0x2d91
// Size: 0x8a, Type: bool
function function_2bbd9db06de0e20c( ent, var_314203ae49cb3ab3 )
{
    playercheck = 0;
    
    if ( isplayer( ent ) || isai( ent ) )
    {
        playercheck = 1;
    }
    
    return playercheck && isalive( ent ) && ( var_314203ae49cb3ab3 || ent.team != self.owner.team ) && !self.iscarried && !self.issmoking;
}

// Namespace lrad
// Params 1
// Checksum 0xb9196721, Offset: 0x2e24
// Size: 0x170
function function_898c36ca19d19e1c( target )
{
    raycastcontents = physics_createcontents( [ "physicscontents_ainoshoot", "physicscontents_ainosight", "physicscontents_explosionclip", "physicscontents_vehicle" ] );
    raycaststart = self.origin + ( 0, 0, 50 );
    raycastend = target geteye();
    raycastresults = physics_raycast( raycaststart, raycastend, raycastcontents, undefined, 0, "physicsquery_all" );
    
    /#
        debugactive = getdvarint( @"scr_lrad_debug" );
        
        if ( debugactive > 0 )
        {
            duration = getdvarint( @"scr_lrad_debug_duration" );
            line( raycaststart, raycastend, ( 0, 0, 100 ), 1, 0, duration );
            drawcolor = ( 0, 255, 0 );
            
            foreach ( result in raycastresults )
            {
                sphere( result[ "<dev string:x90>" ], 5, drawcolor, 0, duration );
            }
        }
    #/
    
    return raycastresults;
}

// Namespace lrad
// Params 1
// Checksum 0xdd5f716b, Offset: 0x2f9d
// Size: 0xaa
function function_1a4e15cb9ac000e1( raycastresults )
{
    var_f0277225ac03fcf2 = 1;
    
    foreach ( result in raycastresults )
    {
        if ( !( isdefined( result[ "entity" ] ) && isdefined( result[ "entity" ].vehiclemodel ) ) )
        {
            var_f0277225ac03fcf2 = 0;
            break;
        }
    }
    
    return var_f0277225ac03fcf2;
}

// Namespace lrad
// Params 2
// Checksum 0x22ebc627, Offset: 0x3050
// Size: 0x329
function function_13cbc814c6e791a2( stuntime, lradent )
{
    if ( !isdefined( self.perks[ "specialty_stun_resistance" ] ) )
    {
        self.lradstunned = 1;
        
        if ( isai( self ) )
        {
            if ( !isdefined( self.subclass ) )
            {
                utility::setplayerstunned();
            }
            else if ( self.subclass == "zombie_base" )
            {
                if ( utility::issharedfuncdefined( #"zombie", #"stunZombie" ) )
                {
                    self [[ utility::getsharedfunc( #"zombie", #"stunZombie" ) ]]( 10000 );
                }
            }
            else
            {
                self notify( #"flashbang", self.origin, 1, undefined, lradent.owner, lradent.owner.team, undefined );
            }
        }
        else
        {
            utility::setplayerstunned();
        }
        
        if ( utility::issharedfuncdefined( #"damage", #"hash_1eaa1157dee6abdc" ) )
        {
            self thread [[ utility::getsharedfunc( #"damage", #"hash_1eaa1157dee6abdc" ) ]]( self, lradent.owner );
        }
        
        shellshock_utility_cpmp::_shellshock( %"lrad_mp", #"gas", stuntime, 1 );
        
        if ( utility::issharedfuncdefined( #"sound", #"hash_ebec9891877bda7d" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"hash_ebec9891877bda7d" ) ]]( "stun", stuntime );
        }
        
        if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
        {
            lradent.owner [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitsoundveil" );
        }
        
        if ( getdvarint( @"hash_abec145fdf5e6352" ) == 1 )
        {
            if ( !isai( self ) )
            {
                if ( isplayer( self ) )
                {
                    utility::hidehudenable();
                }
            }
        }
    }
    else if ( isdefined( self.perks[ "specialty_stun_resistance" ] ) )
    {
        attackerowner = lradent.owner ?? lradent;
        victimowner = self.owner ?? self;
        currenttime = gettime();
        
        if ( !isdefined( lradent.var_66dc935a08aa97d1 ) || currenttime > lradent.var_66dc935a08aa97d1 + 2000 )
        {
            if ( isplayer( attackerowner ) && attackerowner != self )
            {
                attackerowner damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
            }
            
            lradent.var_66dc935a08aa97d1 = currenttime;
        }
        
        if ( player_utility::playersareenemies( attackerowner, victimowner ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_tac_resist" );
        }
    }
    
    /#
        debugactive = getdvarint( @"scr_lrad_debug" );
        
        if ( debugactive > 0 )
        {
            fullstuntime = getdvarfloat( @"hash_2ef1444b14cdcc27" );
            
            if ( stuntime == fullstuntime )
            {
                iprintlnbold( self.name + "<dev string:x99>" );
                return;
            }
            
            iprintlnbold( self.name + "<dev string:xb0>" );
        }
    #/
}

// Namespace lrad
// Params 0
// Checksum 0xd6b7b559, Offset: 0x3381
// Size: 0xc4
function function_18e1dc10a25cb472()
{
    if ( self.lradstunned )
    {
        self.lradstunned = undefined;
        
        if ( getdvarint( @"hash_abec145fdf5e6352" ) == 1 )
        {
            if ( !isai( self ) )
            {
                if ( isplayer( self ) )
                {
                    if ( self.hidehudenabled > 0 )
                    {
                        utility::hidehuddisable();
                    }
                }
            }
        }
        
        if ( isai( self ) )
        {
            if ( !isdefined( self.subclass ) )
            {
                utility::setplayerstunned();
            }
            else if ( self.subclass == "zombie_base" )
            {
                if ( utility::issharedfuncdefined( #"zombie", #"clearstunzombie" ) )
                {
                    self [[ utility::getsharedfunc( #"zombie", #"clearstunzombie" ) ]]();
                }
            }
            
            return;
        }
        
        utility::setplayerstunned();
    }
}

// Namespace lrad
// Params 1
// Checksum 0x4d22ae47, Offset: 0x344d
// Size: 0x153
function lrad_hack( newowner )
{
    self notify( #"lrad_hacked" );
    self.owner = newowner;
    self.team = newowner.team;
    self.ownerid = newowner getxuid();
    self setentityowner( newowner );
    self setotherent( newowner );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( newowner.team );
    }
    else
    {
        self filteroutplayermarks( newowner );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"givescoreforhack" ) )
    {
        newowner [[ utility::getsharedfunc( #"killstreak", #"givescoreforhack" ) ]]();
    }
    
    self.owner function_f2fdb0f9326a7094( self );
    self.owner thread lrad_watchpickup( self, self.streakinfo );
    functionals_utility::clearminimapid();
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        self.minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( self.streakinfo.bundle.minimapicon, self.team, 1, 1, 1 );
    }
}

// Namespace lrad
// Params 1
// Checksum 0xa7033935, Offset: 0x35a8
// Size: 0x1d0
function lrad_handledamage( data )
{
    if ( !isdefined( self.totaldamagetaken ) )
    {
        self.totaldamagetaken = 0;
    }
    
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "lrad" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 3, 4, 400 );
    }
    
    self.totaldamagetaken += modifieddamage;
    
    if ( self.totaldamagetaken >= self.maxhealth * 0.5 )
    {
        self setscriptablepartstate( "damage", "on" );
        self notify( #"lrad_dying" );
        self.useownerobj setusableenabled( 0 );
    }
    
    return modifieddamage;
}

/#

    // Namespace lrad
    // Params 1
    // Checksum 0xcc6563c5, Offset: 0x3781
    // Size: 0x17f, Type: dev
    function function_333dd57938d79414( debugactivedvar )
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self endon( #"iscarried" );
        debugactive = getdvarint( debugactivedvar );
        
        while ( true )
        {
            if ( debugactive > 0 )
            {
                healthremaining = self.maxhealth - self.damagetaken;
                print3d( self.origin + ( 0, 0, 20 ), "<dev string:xca>" + healthremaining, ( 0, 1, 0 ), 1, 0.5, 1 );
                trigger_length = getdvarint( @"hash_b4d9a80ce75c617" );
                trigger_radius = getdvarint( @"hash_b27192e0593d2245" );
                lifetime = getdvarint( @"scr_lrad_lifetime" );
                duration = 100;
                startpoint = self.stuntrigger.origin;
                endpoint = self.stuntrigger.origin + anglestoup( self.stuntrigger.angles ) * trigger_length;
                cylinder( startpoint, endpoint, trigger_radius, ( 0, 1, 0 ), 0, duration );
            }
            
            waitframe();
        }
    }

#/
