// scripts\mp\common\supers\capture_bot.gsc  (hash_71eded7f5a484cb5.gscc) (size: 23188 Bytes / 0x5a94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x917b27e0 (2440767456)
// size ...... 23188 (0x5a94)
// includes .. 18  (offset: 0x5694)
// strings ... 43  (offset: 0x5724)
// dev strs .. 2   (offset: 0x5a3c)
// exports ... 58  (offset: 0x3ba8)
// cseg ...... 0x5a5 + 0x3603 (0x3ba8)
// imports ... 134 (offset: 0x44b8)
// animtree1 . 0   (offset: 0x5a54)
// animtree2 . 4   (offset: 0x5a54)
#using scripts\common\ae_utility;
#using scripts\common\functionals_utility;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace capture_bot;

// Namespace capture_bot
// Params 0, eflags: 0x1
// Checksum 0x2a03033e, Offset: 0x5c3
// Size: 0x1c
function autoexec main()
{
    utility::registersharedfunc( "super_capture_bot", #"init", &capturebot_init );
}

// Namespace capture_bot
// Params 0
// Checksum 0xb42d5d83, Offset: 0x5e7
// Size: 0x118
function capturebot_init()
{
    level.var_c49c3986a3d5ca3f = [];
    
    if ( utility::issharedfuncdefined( #"team_utility", #"hash_5de02d9395de8621" ) )
    {
        [[ utility::getsharedfunc( #"team_utility", #"hash_5de02d9395de8621" ) ]]( &capturebot_updateheadicononjointeam );
    }
    
    capturebot_initdvars();
    
    if ( level.var_e733d6b1c5d24799 )
    {
        if ( !isdefined( level.var_92f18b2d64c2fd53 ) )
        {
            level.var_92f18b2d64c2fd53 = [];
        }
        
        level.var_92f18b2d64c2fd53[ "capture_bot" ] = &function_f9cb70d107a958cc;
    }
    
    utility::registersharedfunc( "super_capture_bot", #"capturebot_used", &capturebot_used );
    utility::registersharedfunc( "super_capture_bot", #"capturebot_setclaimants", &capturebot_setclaimants );
    utility::registersharedfunc( "super_capture_bot", #"capturebot_getteamindex", &capturebot_getteamindex );
    utility::registersharedfunc( "super_capture_bot", #"hash_b9b58f59fafcebed", &capturebot_getteamindex );
    utility::registersharedfunc( "super_capture_bot", #"capturebot_getallcapturebotsforteam", &capturebot_getallcapturebotsforteam );
    weapons::registerusedcallback( "capture_bot", &capturebot_used );
}

// Namespace capture_bot
// Params 0
// Checksum 0xa2aa6bdd, Offset: 0x707
// Size: 0x2c
function capturebot_initdvars()
{
    setdvarifuninitialized( @"hash_df5f30944ffffafd", 1 );
    level.var_e733d6b1c5d24799 = getdvarint( @"hash_c5dbbc4cf9126008", 0 ) == 1;
}

// Namespace capture_bot
// Params 1
// Checksum 0x6b406a1d, Offset: 0x73b
// Size: 0x8c
function capturebot_updateheadicononjointeam( player )
{
    foreach ( capturebot in level.var_c49c3986a3d5ca3f )
    {
        if ( isdefined( capturebot ) )
        {
            capturebot capturebot_updateheadicon( player );
        }
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0xe56877c5, Offset: 0x7cf
// Size: 0x2e9
function capturebot_used( grenade )
{
    grenade endon( #"death" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.var_14d2606cadb8941 = gettime();
    equipname = "equip_capture_bot";
    supername = "super_capture_bot";
    grenade.var_20fb6d9e02a1d35 = 1;
    grenade.var_b5ff937ea7459936 = &capturebot_shouldcaptureobjective;
    grenade endon( #"death" );
    grenade thread capturebot_watchdisownedtimeout();
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade thread function_90f8f55ea7bbb508( self );
    grenade waittill( #"missile_stuck", stuckto );
    grenade capturebot_handlemovingplatforms( stuckto );
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ supername ].id;
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( supername );
    
    if ( utility::issharedfuncdefined( #"weapons", #"onequipmentplanted" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"onequipmentplanted" ) ]]( grenade, equipname, &capturebot_destroy );
    }
    
    level.var_c49c3986a3d5ca3f[ grenade getentitynumber() ] = grenade;
    grenade emp_debuff::set_apply_emp_callback( &function_3b1804dd7ff5bbdf );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &capturebot_empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &capturebot_empcleared;
    }
    
    grenade haywire::function_7f69a1eb3d590f76( &capturebot_haywireapplied );
    
    if ( !grenade.madedamageable )
    {
        grenade capturebot_makedamageable();
    }
    
    grenade.makedamageable = undefined;
    grenade function_c037f8c36323872a();
    grenade.var_f51e4f29526c7a57 = 0;
    grenade.var_d2b15d607da99c9c = 0;
    grenade.isempd = 0;
    grenade.hacksremaining = getdvarint( @"hash_5aa813bbab6ce3", grenade.bundle.var_6650eb222ac96256 );
    grenade thread function_7c980443abf00d84( getdvarfloat( @"hash_553f589c514d1d1f", grenade.bundle.var_4c176e88258532c1 ) * getdvarfloat( @"hash_553f589c514d1d1f", grenade.bundle.var_4c176e88258532c1 ) );
    
    if ( function_c4b3bc9d383c4c63() )
    {
        grenade thread function_d3c3766f5c989327();
    }
    
    challenges::function_a0936b0e5b4550f3( "super_capture_bot", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    grenade.headiconid = grenade entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, undefined, 1 );
}

// Namespace capture_bot
// Params 1
// Checksum 0x97a083cf, Offset: 0xac0
// Size: 0x13b
function function_90f8f55ea7bbb508( player )
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

// Namespace capture_bot
// Params 0
// Checksum 0xf888d436, Offset: 0xc03
// Size: 0xce
function capturebot_unset()
{
    if ( false )
    {
        foreach ( superequip in self.plantedsuperequip )
        {
            if ( superequip.equipmentref == "equip_capture_bot" )
            {
                superequip thread capturebot_destroy( 1 );
                
                if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
                {
                    self [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( superequip );
                }
            }
        }
    }
}

// Namespace capture_bot
// Params 2
// Checksum 0x5b8d4c95, Offset: 0xcd9
// Size: 0x16d
function capturebot_destroy( immediate = !self.planted, wasdestroyed )
{
    closetime = 0;
    deletiondelay = 0;
    
    if ( !immediate )
    {
        closetime = capturebot_getcloseanimduration() + function_a1fe20c045d914b9();
        deletiondelay = closetime + 0.1;
    }
    else
    {
        deletiondelay = 0.1;
    }
    
    if ( isdefined( self.var_909df34646e279f6 ) )
    {
        if ( utility::issharedfuncdefined( #"robj", #"removeexistingcapturebot" ) )
        {
            self.var_909df34646e279f6 [[ utility::getsharedfunc( #"robj", #"removeexistingcapturebot" ) ]]( self );
        }
        
        self.var_909df34646e279f6 = undefined;
    }
    
    moving_platform = undefined;
    fxoriginoffset = undefined;
    thread capturebot_delete( deletiondelay, wasdestroyed );
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        fxforward = anglestoforward( self.angles );
        var_6978ba6f62479219 = self getlinkedparent();
        
        if ( isdefined( var_6978ba6f62479219 ) )
        {
            moving_platform = var_6978ba6f62479219;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        if ( !immediate )
        {
            function_aa02fb0d7e02865f();
        }
        
        self setscriptablepartstate( "destroy", "active", 0 );
        
        if ( isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
    }
}

// Namespace capture_bot
// Params 2
// Checksum 0xa4b6d753, Offset: 0xe4e
// Size: 0x154
function capturebot_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    self.var_918f5731d316cbc = 1;
    wait deletiondelay;
    self.isdestroyed = 1;
    level.var_c49c3986a3d5ca3f[ self getentitynumber() ] = undefined;
    self setcandamage( 0 );
    function_ce6a2c68079fa1db();
    
    if ( isdefined( self.owner ) )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
        {
            self.owner [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( self );
        }
    }
    
    self.exploding = 1;
    capturebot_removeheadicon();
    supername = "super_capture_bot";
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    self.owner challenges::function_a0936b0e5b4550f3( supername, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    self delete();
}

// Namespace capture_bot
// Params 1
// Checksum 0xfb4896b5, Offset: 0xfaa
// Size: 0x7a
function capturebot_getteamindex( team )
{
    assert( isdefined( team ), "<dev string:x24>" );
    teamindex = 0;
    
    if ( level.teambased )
    {
        switch ( team )
        {
            case #"hash_7c2d091e6337bf54":
                teamindex = 1;
                break;
            case #"hash_5f54b9bf7583687f":
                teamindex = 2;
                break;
            case #"hash_11f9d28d306ceab7":
                teamindex = 3;
                break;
        }
    }
    
    return teamindex;
}

// Namespace capture_bot
// Params 3
// Checksum 0x69eec1a7, Offset: 0x102d
// Size: 0x85
function capturebot_setclaimants( team, var_e515a0ae4b64c0f, objidnum )
{
    if ( function_5631d1fdc1acf45() )
    {
        var_1f050dea06a149e1 = function_d122d55c7e42c221( objidnum );
        objectiveteamcount = "ui_objective_" + var_1f050dea06a149e1 + "_capture_bot_team_count";
        omnvar_utility::function_8b206c75cb7ad548( objectiveteamcount, 0, 8, var_e515a0ae4b64c0f[ 1 ] );
        omnvar_utility::function_8b206c75cb7ad548( objectiveteamcount, 8, 8, var_e515a0ae4b64c0f[ 2 ] );
        omnvar_utility::function_8b206c75cb7ad548( objectiveteamcount, 16, 8, var_e515a0ae4b64c0f[ 3 ] );
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x62499dd, Offset: 0x10ba
// Size: 0x11, Type: bool
function function_3d12880c8d315059( capturebotindex )
{
    return capturebotindex == -1;
}

// Namespace capture_bot
// Params 1
// Checksum 0xbd6d600c, Offset: 0x10d4
// Size: 0x1ae
function function_d122d55c7e42c221( currindex )
{
    var_30d8110b518fce06 = getomnvar( "ui_objective_1_capture_bot_index" );
    var_51dfeb74e094c8 = getomnvar( "ui_objective_2_capture_bot_index" );
    var_5f13c115bb60e4d7 = getomnvar( "ui_objective_3_capture_bot_index" );
    var_b803bf92f12794f4 = getomnvar( "ui_objective_4_capture_bot_index" );
    var_3681d2edcf6965bf = getomnvar( "ui_objective_5_capture_bot_index" );
    var_d79453323fb28898 = getomnvar( "ui_objective_6_capture_bot_index" );
    
    if ( currindex == var_30d8110b518fce06 || function_3d12880c8d315059( var_30d8110b518fce06 ) )
    {
        if ( function_3d12880c8d315059( var_30d8110b518fce06 ) )
        {
            setomnvar( "ui_objective_1_capture_bot_index", currindex );
        }
        
        return 1;
    }
    
    if ( currindex == var_51dfeb74e094c8 || function_3d12880c8d315059( var_51dfeb74e094c8 ) )
    {
        if ( function_3d12880c8d315059( var_51dfeb74e094c8 ) )
        {
            setomnvar( "ui_objective_2_capture_bot_index", currindex );
        }
        
        return 2;
    }
    
    if ( currindex == var_5f13c115bb60e4d7 || function_3d12880c8d315059( var_5f13c115bb60e4d7 ) )
    {
        if ( function_3d12880c8d315059( var_5f13c115bb60e4d7 ) )
        {
            setomnvar( "ui_objective_3_capture_bot_index", currindex );
        }
        
        return 3;
    }
    
    if ( currindex == var_b803bf92f12794f4 || function_3d12880c8d315059( var_b803bf92f12794f4 ) )
    {
        if ( function_3d12880c8d315059( var_b803bf92f12794f4 ) )
        {
            setomnvar( "ui_objective_4_capture_bot_index", currindex );
        }
        
        return 4;
    }
    
    if ( currindex == var_3681d2edcf6965bf || function_3d12880c8d315059( var_3681d2edcf6965bf ) )
    {
        if ( function_3d12880c8d315059( var_3681d2edcf6965bf ) )
        {
            setomnvar( "ui_objective_5_capture_bot_index", currindex );
        }
        
        return 5;
    }
    
    if ( currindex == var_d79453323fb28898 || function_3d12880c8d315059( var_d79453323fb28898 ) )
    {
        if ( function_3d12880c8d315059( var_d79453323fb28898 ) )
        {
            setomnvar( "ui_objective_6_capture_bot_index", currindex );
        }
        
        return 6;
    }
    
    assertmsg( "<dev string:x45>" );
    return;
}

// Namespace capture_bot
// Params 1
// Checksum 0xc217fe24, Offset: 0x128a
// Size: 0x9f2
function function_7c980443abf00d84( hackingdistsqr )
{
    self endon( #"death" );
    self endon( #"disable_hack" );
    self.owner endon( #"death_or_disconnect" );
    self.var_3a8327a8ee0d42ab = [];
    
    if ( isdefined( self.bundle.var_2ce19badd1a04fc1 ) )
    {
        self.var_2ce19badd1a04fc1 = self.bundle.var_2ce19badd1a04fc1;
    }
    else
    {
        self.var_2ce19badd1a04fc1 = 0;
    }
    
    if ( isdefined( self.bundle.var_3c946c644c7e42d2 ) )
    {
        self.var_3c946c644c7e42d2 = self.bundle.var_3c946c644c7e42d2;
    }
    else
    {
        self.var_3c946c644c7e42d2 = 0;
    }
    
    if ( isdefined( self.bundle.var_9107b6642c837bf ) )
    {
        self.var_9107b6642c837bf = self.bundle.var_9107b6642c837bf;
    }
    else
    {
        self.var_9107b6642c837bf = 0;
    }
    
    if ( isdefined( self.var_d2b15d607da99c9c ) )
    {
        while ( !self.var_d2b15d607da99c9c )
        {
            equipmentarray = [[ level.getactiveequipmentarray ]]();
            killstreakarray = level.activekillstreaks;
            cameraarray = [];
            
            if ( isdefined( level.deployable_cameras[ "tacticalCameraList" ] ) )
            {
                foreach ( team in level.teamnamelist )
                {
                    if ( team != self.owner.team )
                    {
                        cameraarray = arraycombineunique( cameraarray, level.deployable_cameras[ "tacticalCameraList" ][ team ] );
                    }
                }
            }
            
            activeobjects = arraycombineunique( [], killstreakarray, equipmentarray, cameraarray );
            
            if ( activeobjects.size == 0 )
            {
                continue;
            }
            
            foreach ( capturebottarget in activeobjects )
            {
                if ( !isdefined( capturebottarget ) )
                {
                    continue;
                }
                
                if ( capturebottarget.exploding )
                {
                    continue;
                }
                
                if ( capturebottarget == self )
                {
                    continue;
                }
                
                if ( capturebot_checkignorelist( capturebottarget ) )
                {
                    continue;
                }
                
                var_a3785fe74be4b403 = capturebottarget.owner;
                var_7abb8ea921e296dc = 1;
                
                if ( var_7abb8ea921e296dc )
                {
                    if ( isdefined( var_a3785fe74be4b403 ) && !player_utility::playersareenemies( self.owner, var_a3785fe74be4b403 ) )
                    {
                        continue;
                    }
                }
                
                if ( distancesquared( capturebottarget.origin, self.origin ) > hackingdistsqr )
                {
                    continue;
                }
                
                capturebottargetname = undefined;
                
                if ( isdefined( capturebottarget.streakname ) )
                {
                    capturebottargetname = capturebottarget.streakname;
                }
                else if ( isdefined( capturebottarget.cameratype ) )
                {
                    capturebottargetname = capturebottarget.cameratype;
                }
                else
                {
                    if ( isdefined( capturebottarget.weapon_name ) )
                    {
                        capturebottargetname = capturebottarget.weapon_name;
                    }
                    
                    if ( !isdefined( capturebottargetname ) && isdefined( capturebottarget.weapon_object ) )
                    {
                        capturebottargetname = capturebottarget.weapon_object.basename;
                    }
                }
                
                if ( isdefined( capturebottargetname ) )
                {
                    switch ( capturebottargetname )
                    {
                        case #"hash_30c41b4430deef71":
                            if ( isdefined( capturebottarget.var_f51e4f29526c7a57 ) )
                            {
                                if ( capturebottarget.isempd )
                                {
                                    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                                    {
                                        self.owner [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "capture_bot_unilateral_destruction" );
                                    }
                                    
                                    capturebottarget thread capturebot_destroy( 1, 1 );
                                }
                                else if ( !capturebottarget.var_f51e4f29526c7a57 )
                                {
                                    self.var_f51e4f29526c7a57 = 1;
                                    self.var_d2b15d607da99c9c = 1;
                                    capturebottarget.var_f51e4f29526c7a57 = 1;
                                    capturebottarget.var_d2b15d607da99c9c = 1;
                                    self.var_3a8327a8ee0d42ab[ self.var_3a8327a8ee0d42ab.size ] = capturebottarget.owner;
                                    capturebottarget thread function_e95f73f17d38caba( self.owner );
                                }
                            }
                            
                            break;
                        case #"hash_14272647c44d6052":
                        case #"hash_1a5a56a6fdfa6d6b":
                        case #"hash_1e6066bc540fa0b1":
                        case #"hash_435258fc47768fa7":
                        case #"hash_4a85ee2b82965fe2":
                        case #"hash_5e3fa526a48eaaa5":
                        case #"hash_5e8f81314553dd36":
                        case #"hash_6a2e4f9c54756dc7":
                            if ( capturebottarget equipment_mp::function_15ea6ab148e09e8d( self ) )
                            {
                                equipment_mp::function_c562b7d10b04136a( self );
                                
                                if ( utility::issharedfuncdefined( #"equipment", #"hash_a31173b8db8c74c0" ) )
                                {
                                    self.hacksremaining--;
                                    capturebottarget thread [[ utility::getsharedfunc( #"equipment", #"hash_a31173b8db8c74c0" ) ]]( self );
                                    
                                    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
                                    {
                                        [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( capturebottarget, self.owner, "capture_bot", "equipment" );
                                    }
                                }
                            }
                            
                            break;
                        case #"hash_d746f684beafad9f":
                            if ( utility::issharedfuncdefined( #"super_comm_scrambler", #"commscrambler_onhacked" ) )
                            {
                                self.hacksremaining--;
                                onhackedcallback = utility::getsharedfunc( #"super_comm_scrambler", #"commscrambler_onhacked" );
                                capturebottarget functionals_utility::function_763e09170b227f3( self.owner, "super_comm_scrambler", "capture_bot", onhackedcallback );
                            }
                            
                            break;
                        case #"hash_56ee829cc162271a":
                        case #"hash_c46d19aa871781fa":
                            if ( getdvarint( @"hash_497f584b55da1305", self.var_2ce19badd1a04fc1 ) == 1 )
                            {
                                if ( capturebottarget equipment_mp::function_15ea6ab148e09e8d( self ) )
                                {
                                    equipment_mp::function_c562b7d10b04136a( self );
                                    
                                    if ( utility::issharedfuncdefined( #"equipment", #"hash_a31173b8db8c74c0" ) )
                                    {
                                        self.hacksremaining--;
                                        capturebottarget thread [[ utility::getsharedfunc( #"equipment", #"hash_a31173b8db8c74c0" ) ]]( self );
                                    }
                                }
                            }
                            
                            break;
                        case #"hash_de91d496aad63a86":
                            if ( getdvarint( @"hash_497f584b55da1305", self.var_2ce19badd1a04fc1 ) == 1 )
                            {
                                if ( utility::issharedfuncdefined( #"hash_f9222d2ba7aa2a7", #"tacticalcamera_hack" ) )
                                {
                                    self.hacksremaining--;
                                    capturebottarget thread [[ utility::getsharedfunc( #"hash_f9222d2ba7aa2a7", #"tacticalcamera_hack" ) ]]( self.owner );
                                }
                            }
                            
                            break;
                        case #"hash_b4a17c60413030e7":
                            if ( getdvarint( @"hash_36d6aab0c3496454", self.var_3c946c644c7e42d2 ) == 1 )
                            {
                                if ( capturebottarget equipment_mp::function_15ea6ab148e09e8d( self ) )
                                {
                                    equipment_mp::function_c562b7d10b04136a( self );
                                    
                                    if ( utility::issharedfuncdefined( #"equipment", #"hash_a31173b8db8c74c0" ) )
                                    {
                                        capturebottarget thread [[ utility::getsharedfunc( #"equipment", #"hash_a31173b8db8c74c0" ) ]]( self );
                                        self.hacksremaining--;
                                        
                                        if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
                                        {
                                            [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( capturebottarget, self.owner, "capture_bot", "equipment" );
                                        }
                                    }
                                }
                            }
                            
                            break;
                        case #"hash_19dd9a3a4147e09e":
                            if ( getdvarint( @"hash_97bedf9b3dc1501d", self.var_9107b6642c837bf ) == 1 )
                            {
                                if ( utility::issharedfuncdefined( #"lrad", #"lrad_hack" ) )
                                {
                                    self.hacksremaining--;
                                    capturebottarget thread [[ utility::getsharedfunc( #"lrad", #"lrad_hack" ) ]]( self.owner );
                                    
                                    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
                                    {
                                        [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( capturebottarget, self.owner, "capture_bot", "equipment" );
                                    }
                                }
                            }
                            
                            break;
                        case #"hash_b571a6187bf67f9e":
                            if ( getdvarint( @"hash_97bedf9b3dc1501d", self.var_9107b6642c837bf ) == 1 )
                            {
                                if ( utility::issharedfuncdefined( #"missile_turret", #"missile_turret_hack" ) )
                                {
                                    self.hacksremaining--;
                                    capturebottarget thread [[ utility::getsharedfunc( #"missile_turret", #"missile_turret_hack" ) ]]( self.owner, capturebottarget.owner );
                                    
                                    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
                                    {
                                        [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( capturebottarget, self.owner, "capture_bot", "equipment" );
                                    }
                                }
                            }
                            
                            break;
                    }
                    
                    if ( self.hacksremaining == 0 )
                    {
                        self.var_d2b15d607da99c9c = 1;
                    }
                }
            }
            
            if ( isdefined( self.var_d2b15d607da99c9c ) )
            {
                if ( self.var_f51e4f29526c7a57 )
                {
                    thread function_f0487c54a7e5a53c( self.var_3a8327a8ee0d42ab );
                }
                else if ( self.var_d2b15d607da99c9c )
                {
                    thread capturebot_destroy( 0 );
                }
            }
            
            wait 0.25;
        }
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0x9ba3be4d, Offset: 0x1c84
// Size: 0x33d
function function_d3c3766f5c989327()
{
    self endon( #"death" );
    
    switch ( game_utility::getbasegametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_6efb0f59a62300fb":
        case #"hash_a1313b745c17c07e":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            function_d69136dba7c866e8();
            self.var_57b273c971318b8f = 1;
            break;
        case #"hash_4d60179017f5a28a":
            if ( isdefined( level.current_objectives ) )
            {
                currobjs = level.current_objectives;
                
                foreach ( currobj in currobjs )
                {
                    if ( utility::issharedfuncdefined( #"robj", #"identifyobjtypforcapturebot" ) )
                    {
                        switch ( [[ utility::getsharedfunc( #"robj", #"identifyobjtypforcapturebot" ) ]]( currobj ) )
                        {
                            case #"hash_2daf318af0c70342":
                            case #"hash_74d906400c48adf8":
                                if ( distancesquared( self.origin, currobj.curorigin ) < 26406.2 )
                                {
                                    if ( getdvarint( @"hash_df5f30944ffffafd" ) == 0 )
                                    {
                                        castcontents = physics_createcontents( [ "physicscontents_ainosight" ] );
                                        castresults = physics_raycast( self.origin, currobj.curorigin, castcontents, [ self ], 0, "physicsquery_closest", 1 );
                                        
                                        if ( isdefined( castresults ) && castresults.size > 0 )
                                        {
                                            if ( isdefined( castresults[ 0 ][ "entity" ] ) && isdefined( castresults[ 0 ][ "entity" ].script_gameobjectname ) && castresults[ 0 ][ "entity" ].script_gameobjectname == "robj" )
                                            {
                                                function_603b96967a1a30f( currobj );
                                                self.var_909df34646e279f6 = currobj;
                                                self setscriptablepartstate( "objective", "on_objective", 0 );
                                            }
                                            else
                                            {
                                                self setscriptablepartstate( "objective", "neutral", 0 );
                                            }
                                        }
                                        else
                                        {
                                            function_603b96967a1a30f( currobj );
                                            self.var_909df34646e279f6 = currobj;
                                            self setscriptablepartstate( "objective", "on_objective", 0 );
                                        }
                                    }
                                    else
                                    {
                                        function_603b96967a1a30f( currobj );
                                        self.var_909df34646e279f6 = currobj;
                                        self setscriptablepartstate( "objective", "on_objective", 0 );
                                    }
                                }
                                else
                                {
                                    self setscriptablepartstate( "objective", "neutral", 0 );
                                    thread function_8d80ea95f03681d9();
                                }
                                
                                break;
                            case #"hash_fed0dfe3f74ac025":
                                break;
                            case #"hash_2916b409ed596650":
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
            
            self.var_57b273c971318b8f = 1;
            break;
        case #"hash_b9aaf1c4459d9a15":
            self.var_57b273c971318b8f = 1;
            break;
        default:
            break;
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x9e55109f, Offset: 0x1fc9
// Size: 0x45
function function_603b96967a1a30f( currentobjective )
{
    if ( utility::issharedfuncdefined( #"robj", #"setupnewcapturebot" ) )
    {
        currentobjective [[ utility::getsharedfunc( #"robj", #"setupnewcapturebot" ) ]]( self );
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0xbce385ac, Offset: 0x2016
// Size: 0x46
function function_281792bded1c21dc( obj )
{
    self endon( #"death" );
    wait ( level.zoneendtime - gettime() ) / 1000;
    
    while ( function_3efc5453b97b55e6( obj ) )
    {
        wait 0.2;
    }
    
    function_d69136dba7c866e8();
}

// Namespace capture_bot
// Params 0
// Checksum 0x89cc834b, Offset: 0x2064
// Size: 0x183
function function_d69136dba7c866e8()
{
    aitype = undefined;
    
    if ( level.var_e733d6b1c5d24799 )
    {
        aitype_list = agent_utils::get_aitype_by_subclass( "capture_bot" );
        
        if ( isdefined( aitype_list ) )
        {
            assert( aitype_list.size == 1 );
            
            if ( aitype_list.size == 1 )
            {
                aitype = aitype_list[ 0 ];
            }
        }
    }
    
    levelobjectives = level.objectives;
    
    if ( isdefined( levelobjectives ) )
    {
        foreach ( obj in levelobjectives )
        {
            if ( function_3efc5453b97b55e6( obj ) )
            {
                if ( game_utility::getbasegametype() == "koth" && obj.trigger getentitynumber() == level.futurezone.trigger getentitynumber() && function_639f70d28059dc72( obj ) )
                {
                    thread function_281792bded1c21dc( obj );
                }
                
                continue;
            }
            
            if ( function_639f70d28059dc72( obj ) )
            {
                function_eabbd598f631cd45( obj, aitype );
                break;
            }
            
            self.owner setclientomnvar( "ui_owned_capture_bot_capturing", 0 );
            self.owner setclientomnvar( "ui_owned_capture_bot_index", 0 );
            self setscriptablepartstate( "objective", "neutral", 0 );
        }
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x3e173f1a, Offset: 0x21ef
// Size: 0x59, Type: bool
function function_3efc5453b97b55e6( obj )
{
    if ( !isdefined( obj.trigger ) || obj.trigger.trigger_off || isdefined( obj.cancontestclaim ) && !obj.cancontestclaim )
    {
        return true;
    }
    
    return false;
}

// Namespace capture_bot
// Params 1
// Checksum 0x9ee78b83, Offset: 0x2251
// Size: 0x176
function function_639f70d28059dc72( obj )
{
    switch ( game_utility::getbasegametype() )
    {
        case #"hash_f4a9126c03d3385b":
            if ( isdefined( obj.flagmodel ) && isdefined( obj.flagmodel.origin ) )
            {
                domorigin = ( obj.trigger.origin[ 0 ], obj.trigger.origin[ 1 ], obj.flagmodel.origin[ 2 ] - 10 );
            }
            else
            {
                domorigin = obj.trigger.origin;
            }
            
            return math::pointvscylinder( self.origin, squared( obj.trigger.radius ), obj.trigger.height + 10, domorigin, anglestoup( obj.trigger.angles ) );
        case #"hash_ca6516c10db2c95":
        case #"hash_6efb0f59a62300fb":
        case #"hash_a1313b745c17c07e":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            return self istouching( obj.trigger );
        default:
            return 0;
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x16ab5a92, Offset: 0x23cf
// Size: 0x3c, Type: bool
function capturebot_shouldcaptureobjective( obj )
{
    return !self.var_918f5731d316cbc && self.var_325b10d7c325f3b4 && !function_3efc5453b97b55e6( obj ) && function_639f70d28059dc72( obj );
}

// Namespace capture_bot
// Params 2
// Checksum 0x36d6f498, Offset: 0x2414
// Size: 0x282
function function_eabbd598f631cd45( obj, aitype )
{
    self.var_325b10d7c325f3b4 = 1;
    
    if ( level.var_e733d6b1c5d24799 )
    {
        if ( utility::issharedfuncdefined( #"agents", #"hash_b0162154b29139b5" ) )
        {
            self.agent = self [[ utility::getsharedfunc( #"agents", #"hash_b0162154b29139b5" ) ]]( aitype, self.origin, self.angles, self.owner.team );
            
            if ( !isdefined( self.agent ) )
            {
                return;
            }
        }
        
        if ( utility::issharedfuncdefined( #"player", #"hash_788af7e8efa425f9" ) )
        {
            self.agent.guid = self.agent [[ utility::getsharedfunc( #"player", #"hash_788af7e8efa425f9" ) ]]();
        }
        
        self.agent.name = self.agent.guid;
        self.agent setentityowner( self.owner );
        self.agent.owner = self.owner;
        level notify( #"spawned_agent", self.agent );
    }
    else
    {
        if ( !self.var_2b687e67457307 )
        {
            self.pers = [];
            self.pers[ "team" ] = self.owner.team;
            self.touchtriggers = [];
            self.guid = "CaptureBot" + self getentitynumber();
            self.objectivescaler = 1;
            self.clientid = self.owner.clientid;
            self.var_2b687e67457307 = 1;
        }
        
        thread capturebot_processtouchent( obj );
    }
    
    if ( isdefined( obj.objectivekey ) )
    {
        self.currenttargetobjid = obj.objectivekey;
        self.owner setclientomnvar( "ui_owned_capture_bot_capturing", 1 );
        self.owner setclientomnvar( "ui_owned_capture_bot_index", obj.objidnum + 1 );
        self.owner.var_e111c8f072108f5b = obj.objidnum;
    }
    
    self setscriptablepartstate( "objective", "on_objective", 0 );
}

// Namespace capture_bot
// Params 1
// Checksum 0x71cc88ea, Offset: 0x269e
// Size: 0x75
function capturebot_processtouchent( obj )
{
    self endon( #"death" );
    self endon( #"disable_capturing" );
    
    while ( capturebot_shouldcaptureobjective( obj ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"processtouchent" ) )
        {
            obj utility::callsharedfunc( #"game", #"processtouchent", self, obj.entnum );
        }
        
        waitframe();
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0x7ed59595, Offset: 0x271b
// Size: 0x196
function function_8d80ea95f03681d9()
{
    self endon( #"death" );
    level waittill( #"hash_bfa9f71bd4fcaa4d" );
    
    if ( isdefined( level.current_objectives ) )
    {
        currobjs = level.current_objectives;
        
        foreach ( currobj in currobjs )
        {
            if ( utility::issharedfuncdefined( #"robj", #"identifyobjtypforcapturebot" ) )
            {
                switch ( [[ utility::getsharedfunc( #"robj", #"identifyobjtypforcapturebot" ) ]]( currobj ) )
                {
                    case #"hash_2daf318af0c70342":
                    case #"hash_74d906400c48adf8":
                        if ( distancesquared( self.origin, currobj.trigger.origin ) < 26406.2 )
                        {
                            function_603b96967a1a30f( currobj );
                            self.var_909df34646e279f6 = currobj;
                            self setscriptablepartstate( "objective", "on_objective", 0 );
                        }
                        else
                        {
                            thread function_8d80ea95f03681d9();
                            self setscriptablepartstate( "objective", "neutral", 0 );
                        }
                        
                        break;
                    case #"hash_fed0dfe3f74ac025":
                        break;
                    case #"hash_2916b409ed596650":
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0x1920f6d9, Offset: 0x28b9
// Size: 0x81
function function_c4b3bc9d383c4c63()
{
    switch ( game_utility::getbasegametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_4d60179017f5a28a":
        case #"hash_6efb0f59a62300fb":
        case #"hash_a1313b745c17c07e":
        case #"hash_b9aaf1c4459d9a15":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            return 1;
        default:
            return 0;
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0xe870c300, Offset: 0x2942
// Size: 0x81
function function_5631d1fdc1acf45()
{
    switch ( game_utility::getbasegametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_4d60179017f5a28a":
        case #"hash_6efb0f59a62300fb":
        case #"hash_a1313b745c17c07e":
        case #"hash_b9aaf1c4459d9a15":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            return 1;
        default:
            return 0;
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x720b759f, Offset: 0x29cb
// Size: 0x1a5, Type: bool
function capturebot_checkignorelist( capturebottarget )
{
    capturebottargetname = undefined;
    
    if ( isdefined( capturebottarget.streakname ) )
    {
        capturebottargetname = capturebottarget.streakname;
    }
    else if ( isdefined( capturebottarget.cameratype ) )
    {
        capturebottargetname = capturebottarget.cameratype;
    }
    else
    {
        if ( isdefined( capturebottarget.weapon_name ) )
        {
            capturebottargetname = capturebottarget.weapon_name;
        }
        
        if ( !isdefined( capturebottargetname ) && isdefined( capturebottarget.weapon_object ) )
        {
            capturebottargetname = capturebottarget.weapon_object.basename;
        }
    }
    
    if ( isdefined( capturebottargetname ) )
    {
        switch ( capturebottargetname )
        {
            case #"hash_b4a17c60413030e7":
                if ( getdvarint( @"hash_36d6aab0c3496454", self.var_3c946c644c7e42d2 ) == 1 )
                {
                    return false;
                }
                else
                {
                    return true;
                }
                
                break;
            case #"hash_56ee829cc162271a":
            case #"hash_c46d19aa871781fa":
                if ( getdvarint( @"hash_497f584b55da1305", self.var_2ce19badd1a04fc1 ) == 1 )
                {
                    return false;
                }
                else
                {
                    return true;
                }
                
                break;
            case #"hash_de91d496aad63a86":
                if ( getdvarint( @"hash_497f584b55da1305", self.var_2ce19badd1a04fc1 ) == 1 )
                {
                    return false;
                }
                else
                {
                    return true;
                }
                
                break;
            case #"hash_19dd9a3a4147e09e":
            case #"hash_b571a6187bf67f9e":
                if ( getdvarint( @"hash_97bedf9b3dc1501d", self.var_9107b6642c837bf ) == 1 )
                {
                    return false;
                }
                else
                {
                    return true;
                }
                
                break;
            default:
                return false;
        }
    }
    
    return true;
}

// Namespace capture_bot
// Params 0
// Checksum 0xb71dfd37, Offset: 0x2b79
// Size: 0x83
function capturebot_makedamageable()
{
    bundle = self.bundle;
    boxmaxhealth = 100;
    
    if ( isdefined( bundle ) )
    {
        boxmaxhealth = bundle.maxhealth ?? 100;
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        self thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( boxmaxhealth, "hitequip", &capturebot_handlefataldamage, &functionals_utility::function_cdfa6ea614436cc );
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0xd77cb77f, Offset: 0x2c04
// Size: 0x29
function capturebot_handlefataldamage( data )
{
    capturebot_givepointsfordeath( data.attacker );
    thread capturebot_destroy( 1, 1 );
}

// Namespace capture_bot
// Params 0
// Checksum 0x93d84a77, Offset: 0x2c35
// Size: 0x4f
function capturebot_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( self.outlineid, self );
        }
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0xfbe19e3b, Offset: 0x2c8c
// Size: 0x50
function capturebot_removeheadicon()
{
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x319a0e0, Offset: 0x2ce4
// Size: 0x70
function capturebot_givepointsfordeath( attacker )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"destroyed_equipment" );
        }
    }
}

// Namespace capture_bot
// Params 4
// Checksum 0x80ccb15a, Offset: 0x2d5c
// Size: 0x128
function capturebot_givexpforuse( player, eventname, persstat, supername )
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

// Namespace capture_bot
// Params 1
// Checksum 0x53385b6b, Offset: 0x2e8c
// Size: 0x15
function capturebot_onmovingplatformdeath( data )
{
    capturebot_destroy( 1 );
}

// Namespace capture_bot
// Params 1
// Checksum 0xb19a3f81, Offset: 0x2ea9
// Size: 0x107
function function_76f26a0bf4280181( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    superinfo = undefined;
    
    if ( utility::issharedfuncdefined( #"player", #"hash_45a211ad5df3fd3" ) )
    {
        superinfo = owner [[ utility::getsharedfunc( #"player", #"hash_45a211ad5df3fd3" ) ]]();
    }
    
    if ( isdefined( superinfo ) && level.allowsupers )
    {
        superinfo.wasrefunded = 1;
        
        if ( utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) && utility::issharedfuncdefined( #"supers", #"hash_79c2eee2c78b598" ) )
        {
            owner [[ utility::getsharedfunc( #"supers", #"hash_79c2eee2c78b598" ) ]]( owner [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]() );
        }
    }
    
    capturebot_destroy( 1 );
}

// Namespace capture_bot
// Params 1
// Checksum 0x96a66a1f, Offset: 0x2fb8
// Size: 0xcc
function capturebot_handlemovingplatforms( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &capturebot_onmovingplatformdeath;
    data.invalidparentoverridecallback = &function_76f26a0bf4280181;
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

// Namespace capture_bot
// Params 0
// Checksum 0xcb0dc1e5, Offset: 0x308c
// Size: 0x31
function capturebot_watchdisownedtimeout()
{
    self endon( #"death" );
    capturebot_watchdisownedtimeoutinternal();
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread capturebot_destroy( 1 );
    }
}

// Namespace capture_bot
// Params 0
// Checksum 0xaa341f11, Offset: 0x30c5
// Size: 0xa2
function capturebot_watchdisownedtimeoutinternal()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    if ( utility::issharedfuncdefined( #"hostmigration", #"waitLongDurationWithPause" ) )
    {
        [[ utility::getsharedfunc( #"hostmigration", #"waitLongDurationWithPause" ) ]]( getdvarfloat( @"hash_68780fdf22059a6f", supers_mp::function_5ffd3dfa9cc1e8de( "super_capture_bot" ).maxlifetime ) );
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x1d2ab65f, Offset: 0x316f
// Size: 0x6b
function function_3b1804dd7ff5bbdf( data )
{
    data.victim endon( #"death" );
    data.victim endon( #"destroyed" );
    function_ae8f95342f6a49c( data );
    wait getdvarfloat( @"hash_c98fb670dab45239", self.bundle.var_26cc3f38c9195566 );
    function_975495977932709f( data );
}

// Namespace capture_bot
// Params 1
// Checksum 0xb5765df9, Offset: 0x31e2
// Size: 0x41
function capturebot_empapplied( data )
{
    data.victim endon( #"death" );
    data.victim endon( #"destroyed" );
    function_ae8f95342f6a49c( data );
}

// Namespace capture_bot
// Params 1
// Checksum 0x8a11c6c1, Offset: 0x322b
// Size: 0x15
function capturebot_empcleared( data )
{
    function_975495977932709f( data );
}

// Namespace capture_bot
// Params 1
// Checksum 0x487ebff5, Offset: 0x3248
// Size: 0xa5
function function_ae8f95342f6a49c( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_capture_bot", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
    }
    
    self.isempd = 1;
    data.victim notify( #"disable_hack" );
    function_ce6a2c68079fa1db();
    data.victim function_aa02fb0d7e02865f();
}

// Namespace capture_bot
// Params 1
// Checksum 0x8fae2e5b, Offset: 0x32f5
// Size: 0x96
function function_975495977932709f( data )
{
    data.victim function_c037f8c36323872a();
    self.isempd = 0;
    data.victim thread function_7c980443abf00d84( getdvarfloat( @"hash_553f589c514d1d1f", self.bundle.var_4c176e88258532c1 ) * getdvarfloat( @"hash_553f589c514d1d1f", self.bundle.var_4c176e88258532c1 ) );
    
    if ( function_c4b3bc9d383c4c63() )
    {
        data.victim thread function_d3c3766f5c989327();
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x60566480, Offset: 0x3393
// Size: 0x35
function capturebot_haywireapplied( data )
{
    attacker = data.attacker;
    capturebot_givepointsfordeath( attacker );
    thread capturebot_destroy( 1 );
}

// Namespace capture_bot
// Params 0
// Checksum 0xd6b7ce06, Offset: 0x33d0
// Size: 0x65
function function_aa02fb0d7e02865f()
{
    self setscriptablepartstate( "objective", "neutral", 0 );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "active", "neutral", 0 );
    self setscriptablepartstate( "deactivate", "deactivate", 0 );
    wait capturebot_getcloseanimduration();
    self setscriptablepartstate( "inactive", "inactive", 0 );
    wait function_a1fe20c045d914b9();
}

// Namespace capture_bot
// Params 0
// Checksum 0xe3ecc8ee, Offset: 0x343d
// Size: 0x54
function function_c037f8c36323872a()
{
    self setscriptablepartstate( "deactivate", "neutral", 0 );
    self setscriptablepartstate( "inactive", "neutral", 0 );
    self setscriptablepartstate( "activate", "activate", 0 );
    wait function_9fbf769b9314499b();
    self setscriptablepartstate( "active", "active", 0 );
    wait function_39fda5abe05dcbdd();
}

// Namespace capture_bot
// Params 0
// Checksum 0xc635a1cc, Offset: 0x3499
// Size: 0x1cb
function function_ce6a2c68079fa1db()
{
    if ( level.var_e733d6b1c5d24799 && isdefined( self.agent ) )
    {
        if ( utility::issharedfuncdefined( #"agents", #"hash_3b6232706f2dde60" ) )
        {
            self.agent [[ utility::getsharedfunc( #"agents", #"hash_3b6232706f2dde60" ) ]]();
        }
        
        self.agent.nocorpse = 1;
        self.agent kill();
        self.agent = undefined;
    }
    
    self notify( #"disable_capturing" );
    
    if ( isdefined( self.var_325b10d7c325f3b4 ) )
    {
        self.var_325b10d7c325f3b4 = undefined;
    }
    
    if ( isdefined( self.currenttargetobjid ) )
    {
        self.currenttargetobjid = undefined;
    }
    
    if ( self.var_57b273c971318b8f )
    {
        self.var_57b273c971318b8f = 0;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( function_5631d1fdc1acf45() )
        {
            var_703b45cfa2c746c7 = self.owner getclientomnvar( "ui_owned_capture_bot_index" );
            
            if ( var_703b45cfa2c746c7 > 0 )
            {
                omnvarindex = function_d122d55c7e42c221( var_703b45cfa2c746c7 );
                teamindex = capturebot_getteamindex( self.owner.team );
                
                if ( teamindex > 0 )
                {
                    omnvar = "ui_objective_" + omnvarindex + "_capture_bot_team_count";
                    oldval = omnvar_utility::function_764bc2ee92370f4c( omnvar, ( omnvarindex - 1 ) * 8, 8 );
                    
                    if ( oldval > 0 )
                    {
                        omnvar_utility::function_8b206c75cb7ad548( omnvar, ( omnvarindex - 1 ) * 8, 8, oldval - 1 );
                    }
                }
            }
            
            self.owner setclientomnvar( "ui_owned_capture_bot_index", 0 );
            self.owner setclientomnvar( "ui_owned_capture_bot_capturing", 0 );
        }
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x59ee326, Offset: 0x366c
// Size: 0x51
function function_e95f73f17d38caba( attacker )
{
    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        attacker [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "capture_bot_mutual_destruction" );
    }
    
    thread capturebot_destroy( 0 );
}

// Namespace capture_bot
// Params 1
// Checksum 0x9fd1e609, Offset: 0x36c5
// Size: 0xba
function function_f0487c54a7e5a53c( attackerlist )
{
    foreach ( attacker in attackerlist )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            attacker [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "capture_bot_mutual_destruction" );
        }
    }
    
    thread capturebot_destroy( 0 );
}

// Namespace capture_bot
// Params 0
// Checksum 0x35efc881, Offset: 0x3787
// Size: 0x83
function capturebot_updateheadiconallplayers()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        capturebot_updateheadicon( player );
    }
}

// Namespace capture_bot
// Params 1
// Checksum 0x6b3bd775, Offset: 0x3812
// Size: 0xc9
function capturebot_updateheadicon( player )
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
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = player_utility::isfriendly( self.owner.team, player );
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    
    if ( isfriendly && !isused )
    {
        entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

// Namespace capture_bot
// Params 0
// Checksum 0x25d60d82, Offset: 0x38e3
// Size: 0x17e
function function_f9cb70d107a958cc()
{
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.movespeedscaler = undefined;
    
    if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    self.avoidkillstreakonspawntimer = undefined;
    self.touchtriggers = undefined;
    self.carryobject = undefined;
    self.canpickupobject = undefined;
    self.guid = undefined;
    self.name = undefined;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;
    self.agent_teamparticipant = 1;
    self.var_c6ac93c72ca9ad5e = 1;
    self.objectivescaler = 1;
    
    if ( utility::issharedfuncdefined( #"player", #"initplayergameobjects" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"initplayergameobjects" ) ]]();
    }
    
    game_utility_common::addtoparticipantsarray();
    self setsolid( 0 );
    self hide();
    self.candamage = 0;
    self.ballowexecutions = 0;
    self.ignoreme = 1;
    self.candocombat = 0;
    self.canmove = 0;
    self.cannotmelee = 1;
    self.isvisible = 0;
}

// Namespace capture_bot
// Params 2
// Checksum 0x97adb0fe, Offset: 0x3a69
// Size: 0xde
function capturebot_getallcapturebotsforteam( team, var_e3fd0d48c967aea1 )
{
    result = [];
    
    if ( isdefined( level.var_c49c3986a3d5ca3f ) )
    {
        foreach ( capturebot in level.var_c49c3986a3d5ca3f )
        {
            if ( capturebot.owner.team == team )
            {
                if ( !var_e3fd0d48c967aea1 || capturebot.var_57b273c971318b8f )
                {
                    result = arraycombineunique( result, [ capturebot ] );
                }
            }
        }
    }
    
    return result;
}

#using_animtree( "capture_bot" );

// Namespace capture_bot
// Params 0
// Checksum 0xa34ff6ed, Offset: 0x3b50
// Size: 0xf
function function_9fbf769b9314499b()
{
    return getanimlength( %wm_capturebot_ground_open );
}

// Namespace capture_bot
// Params 0
// Checksum 0x6e1d0329, Offset: 0x3b68
// Size: 0xf
function capturebot_getcloseanimduration()
{
    return getanimlength( %wm_capturebot_ground_close );
}

// Namespace capture_bot
// Params 0
// Checksum 0x830b45d4, Offset: 0x3b80
// Size: 0xf
function function_a1fe20c045d914b9()
{
    return getanimlength( %wm_capturebot_ground_idle_closed );
}

// Namespace capture_bot
// Params 0
// Checksum 0xda3e6d20, Offset: 0x3b98
// Size: 0xf
function function_39fda5abe05dcbdd()
{
    return getanimlength( %wm_capturebot_ground_idle_open );
}

