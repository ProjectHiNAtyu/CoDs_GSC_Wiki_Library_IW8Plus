// scripts\mp\common\killstreaks\uav.gsc  (hash_2ca476d6cde2b048.gscc) (size: 46227 Bytes / 0xb493 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8544e22 (3897839138)
// size ...... 46227 (0xb493)
// includes .. 22  (offset: 0xad7b)
// strings ... 74  (offset: 0xae2b)
// dev strs .. 16  (offset: 0xb3bf)
// exports ... 89  (offset: 0x80b3)
// cseg ...... 0x529 + 0x7b8a (0x80b3)
// imports ... 242 (offset: 0x8e9b)
// animtree1 . 0   (offset: 0xb493)
// animtree2 . 0   (offset: 0xb493)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\math;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\interaction;
#using scripts\mp\objidpoolmanager;

#namespace uav;

// Namespace uav
// Params 0
// Checksum 0xcb47a529, Offset: 0x547
// Size: 0xaf
function init()
{
    utility::callsharedfunc( #"uav", #"init" );
    level function_544c01e308e9a5d1();
    level function_5153a7e5056effeb();
    level thread onplayerconnect();
    level thread tracker();
    utility::registersharedfunc( #"uav", #"hack", &hack );
    utility::registersharedfunc( #"cuav", #"hack", &hack );
    
    /#
        setdevdvarifuninitialized( @"scr_uav_timeout", level.radarviewtime );
        setdevdvarifuninitialized( @"hash_ac7f6a636682c52f", 0 );
        setdevdvarifuninitialized( @"scr_uav_height_offset", 0 );
    #/
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xcee43210, Offset: 0x5fe
// Size: 0x25d
function private function_544c01e308e9a5d1()
{
    level.uavworstid = getuavstrengthmin();
    level.uavbestid = getuavstrengthmax();
    level.uavdirectionalid = getuavstrengthlevelshowenemydirectional();
    level.uavnoneid = getuavstrengthlevelneutral();
    level.uavfastsweepid = getuavstrengthlevelshowenemyfastsweep();
    level.var_75ae6e7989da9fb7 = getdvarint( @"hash_61964e46cab20802", 1 );
    level.var_81a26fda60d43a9a = getdvarint( @"scr_game_forceuav", 0 );
    
    if ( !isdefined( level.var_f3d1cde89907a07a ) && utility::issharedfuncdefined( #"game", #"hash_7eab975bf2761f59" ) )
    {
        level.var_f3d1cde89907a07a = level [[ utility::getsharedfunc( #"game", #"hash_7eab975bf2761f59" ) ]]() && getdvarint( @"hash_3204b9e97cfacc5f", 1 );
    }
    
    if ( level.teambased && !level.var_f3d1cde89907a07a )
    {
        for ( i = 0; i < level.teamnamelist.size ; i++ )
        {
            level.radarmode[ level.teamnamelist[ i ] ] = "normal_radar";
            level.activeuavs[ level.teamnamelist[ i ] ] = 0;
            level.activecounteruavs[ level.teamnamelist[ i ] ] = 0;
            level.activeadvanceduavs[ level.teamnamelist[ i ] ] = 0;
            level.var_fb07bbf8c8d257ab[ level.teamnamelist[ i ] ] = 0;
            level.uavmodels[ level.teamnamelist[ i ] ] = [];
            
            if ( isbrgamemode() )
            {
                level.var_d3e0b46ab1c070f8[ level.teamnamelist[ i ] ] = 0;
                level.var_9f462aa58e87d9c9[ level.teamnamelist[ i ] ] = [];
            }
        }
    }
    else
    {
        level.radarmode = [];
        level.activeuavs = [];
        level.activecounteruavs = [];
        level.activeadvanceduavs = [];
        level.var_fb07bbf8c8d257ab = [];
        level.uavmodels = [];
        
        if ( isbrgamemode() )
        {
            level.var_d3e0b46ab1c070f8 = [];
            level.var_9f462aa58e87d9c9 = [];
        }
    }
    
    level.uavrigs = [];
    level.totalactiveuavs = 0;
    level.totalactivecounteruavs = 0;
    level.activeadvanceduavcount = 0;
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x1d0b5814, Offset: 0x863
// Size: 0x28
function private function_5153a7e5056effeb()
{
    game[ "dialog" ][ "uav_use_friendly_br" ] = "frns_wzan_uav1";
    game[ "dialog" ][ "uav_use_enemy_br" ] = "nmys_wzan_uav1";
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x1e481772, Offset: 0x893
// Size: 0xe1
function private onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( level.teambased )
        {
            if ( level.var_f3d1cde89907a07a )
            {
                player thread function_69759a1014e3606b();
            }
            
            continue;
        }
        
        level.activeuavs[ player.guid ] = 0;
        level.activeuavs[ player.guid + "_radarStrength" ] = level.uavnoneid;
        level.activecounteruavs[ player.guid ] = 0;
        level.var_fb07bbf8c8d257ab[ player.guid ] = 0;
        level.radarmode[ player.guid ] = "normal_radar";
        player.radarstrength = level.uavnoneid;
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xf4b82d51, Offset: 0x97c
// Size: 0x145
function private function_69759a1014e3606b()
{
    self endon( #"disconnect" );
    
    while ( !( isdefined( self.team ) && isdefined( self.sessionsquadid ) ) || self.sessionsquadid == -1 )
    {
        waitframe();
    }
    
    index = self.sessionsquadid;
    
    if ( !isdefined( level.radarmode[ index ] ) )
    {
        level.radarmode[ index ] = "normal_radar";
    }
    
    if ( !isdefined( level.activeuavs[ index ] ) )
    {
        level.activeuavs[ index ] = 0;
    }
    
    if ( !isdefined( level.activecounteruavs[ index ] ) )
    {
        level.activecounteruavs[ index ] = 0;
    }
    
    if ( !isdefined( level.activeadvanceduavs[ index ] ) )
    {
        level.activeadvanceduavs[ index ] = 0;
    }
    
    if ( !isdefined( level.var_fb07bbf8c8d257ab[ index ] ) )
    {
        level.var_fb07bbf8c8d257ab[ index ] = 0;
    }
    
    if ( !isdefined( level.uavmodels[ index ] ) )
    {
        level.uavmodels[ index ] = [];
    }
    
    if ( isbrgamemode() )
    {
        if ( !isdefined( level.var_d3e0b46ab1c070f8[ index ] ) )
        {
            level.var_d3e0b46ab1c070f8[ index ] = 0;
        }
        
        if ( !isdefined( level.var_9f462aa58e87d9c9[ index ] ) )
        {
            level.var_9f462aa58e87d9c9[ index ] = [];
        }
    }
}

// Namespace uav
// Params 1
// Checksum 0xb65f1019, Offset: 0xac9
// Size: 0x18
function onplayerspawned( params )
{
    level notify( #"uav_update" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xc8207bc6, Offset: 0xae9
// Size: 0x75
function private function_c02c9841aed89b44()
{
    /#
        level.uavworstid = getuavstrengthmin();
        level.uavbestid = getuavstrengthmax();
        level.uavdirectionalid = getuavstrengthlevelshowenemydirectional();
        level.uavnoneid = getuavstrengthlevelneutral();
        level.uavfastsweepid = getuavstrengthlevelshowenemyfastsweep();
    #/
    
    level.var_75ae6e7989da9fb7 = getdvarint( @"hash_61964e46cab20802", 1 );
    level.var_81a26fda60d43a9a = getdvarint( @"scr_game_forceuav", 0 );
}

// Namespace uav
// Params 1
// Checksum 0xd3b7ba2a, Offset: 0xb66
// Size: 0x29
function tryuseuav( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return tryuseuavfromstruct( streakinfo );
}

// Namespace uav
// Params 1
// Checksum 0xd5b86e9b, Offset: 0xb98
// Size: 0x272
function tryuseuavfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = streakinfo.bundle;
    
    if ( streakinfo.streakname == "uav" && utility::function_edc4cc03e9e60b3e( @"scr_uav_bigmap_enabled", 0, level.gametypebundle.var_e876c69bd1505313 ) )
    {
        result = uav_bigmap::function_752a6b34640a086b( streakinfo );
        
        if ( result )
        {
            duration = function_6ec42e0a7284a0fa( streakinfo.streakname, bundle, self );
            level.var_ae09cd9b35c30f63[ self.team ] = gettime() + duration;
        }
        
        return result;
    }
    
    if ( level.killstreaktriggeredfunc )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    id = function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb );
    self setclientomnvar( o"uav_radar_ping", id );
    deploymentweapon = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    var_16f8d415b9d7937 = streakinfo.var_16f8d415b9d7937 ?? 1;
    
    if ( var_16f8d415b9d7937 )
    {
        deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deploymentweapon ) );
        
        if ( !deployresult )
        {
            return 0;
        }
    }
    
    streakinfo.streakduration = level.uavsettings[ streakinfo.streakname ].timeout;
    
    if ( level.killstreakbeginusefunc )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    useresult = uav_use( streakinfo.streakname, streakinfo );
    
    if ( useresult )
    {
        duration = function_6ec42e0a7284a0fa( streakinfo.streakname, bundle, self );
        
        if ( streakinfo.streakname == "directional_uav" )
        {
            if ( isbrgamemode() )
            {
                uav_bigmap::function_398f10fa41a95950( self.team );
            }
            
            level.var_6b5444dcdd38ca18[ self.team ] = gettime() + duration;
        }
        
        if ( streakinfo.streakname == "uav" )
        {
            level.var_ae09cd9b35c30f63[ self.team ] = gettime() + duration;
        }
    }
    
    return useresult;
}

// Namespace uav
// Params 3
// Checksum 0x6196a75, Offset: 0xe13
// Size: 0xc2
function function_6ec42e0a7284a0fa( uavname, uavbundle, player )
{
    duration = level.uavsettings[ uavname ].timeout * 1000;
    
    if ( player && isdefined( player.perks[ "specialty_uav_buff" ] ) )
    {
        duration *= level.var_1099f076e66a8a09 ?? 1;
    }
    
    if ( uavbundle.var_997ca52751c048c7 )
    {
        duration += ( uavbundle.var_997ca52751c048c7 ?? 3 ) * 1000;
    }
    
    if ( uavbundle.var_9a2095ba5c21eb2a )
    {
        duration += ( uavbundle.var_9a2095ba5c21eb2a ?? 4 ) * 1000;
    }
    
    return duration;
}

// Namespace uav
// Params 2
// Checksum 0x8afba2d8, Offset: 0xede
// Size: 0x3d6, Type: bool
function uav_use( uavtype, streakinfo )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( uavtype, self.origin );
    }
    
    team = self.pers[ "team" ];
    squadindex = self.sessionsquadid;
    entitylessuav = 0;
    
    if ( isbrgamemode() )
    {
        entitylessuav = 1;
    }
    
    launchresult = uav_launch( self, uavtype, streakinfo, entitylessuav );
    
    if ( !launchresult )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        return false;
    }
    
    uaveventname = "uavUsed";
    bundle = killstreak_utility::function_f943c0602acdc2af( uavtype );
    var_1f658c85c8b24427 = istrue( bundle.var_7eeb66411e36b0f );
    self.var_3c21e51299c5503b = var_1f658c85c8b24427;
    
    switch ( uavtype )
    {
        case #"hash_e171e5b86ef0a4cc":
            self.radarshowenemydirection = 1;
            
            if ( level.teambased )
            {
                foreach ( player in level.players )
                {
                    if ( player.pers[ "team" ] == team )
                    {
                        if ( level.var_f3d1cde89907a07a && player.sessionsquadid != squadindex )
                        {
                            continue;
                        }
                        
                        player.radarshowenemydirection = 1;
                    }
                }
            }
            
            uaveventname = "directionalUavUsed";
            break;
        case #"hash_10e585c25e7e9f60":
            uaveventname = "counterUavUsed";
        default:
            break;
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, uaveventname );
    }
    
    if ( uavtype == "counter_uav" && level.teambased )
    {
        enemyteams = team_utility::getenemyteams( team );
        
        foreach ( enemyteam in enemyteams )
        {
            if ( level.var_f3d1cde89907a07a )
            {
                if ( level.squaddata )
                {
                    foreach ( squadindex in level.squaddata[ enemyteam ] )
                    {
                        if ( killstreak_utility::function_479014a0a76bf3f7( enemyteam, squadindex ) )
                        {
                            thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"cuav_blackout" );
                            break;
                        }
                    }
                }
                
                continue;
            }
            
            if ( killstreak_utility::function_479014a0a76bf3f7( enemyteam ) )
            {
                thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"cuav_blackout" );
                break;
            }
        }
    }
    
    return true;
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x8ca9e32c, Offset: 0x12bd
// Size: 0xcc, Type: bool
function private function_dd2fd3d16d132212( uavtype )
{
    if ( !isbrgamemode() )
    {
        return false;
    }
    
    if ( uavtype != "uav" )
    {
        return false;
    }
    
    index = undefined;
    
    if ( level.teambased )
    {
        index = self.team;
        
        if ( level.var_f3d1cde89907a07a )
        {
            index = self.sessionsquadid;
        }
    }
    else
    {
        index = self.guid;
    }
    
    assert( isdefined( index ) );
    var_ea3ad8324a0705f6 = level.activeadvanceduavs[ index ];
    
    if ( var_ea3ad8324a0705f6 > 0 )
    {
        return false;
    }
    
    curactiveuavs = level.activeuavs[ index ];
    var_c54d39545e18c859 = function_e8e56ccc019a1af3( curactiveuavs, 0, 0 );
    return var_c54d39545e18c859 >= level.uavdirectionalid;
}

// Namespace uav
// Params 4, eflags: 0x4
// Checksum 0x405291f8, Offset: 0x1392
// Size: 0xe1, Type: bool
function private uav_launch( owner, uavtype, streakinfo, entitylessuav )
{
    launchorigin = killstreak_utility::killstreak_getmapcenter( owner );
    uavmodel = uav_create( launchorigin, owner, uavtype, streakinfo, entitylessuav, streakinfo.overridetime );
    
    if ( !uavmodel )
    {
        return false;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        if ( level.var_36218e71baa7e689 )
        {
            uavmodel.var_c5ccf9dff3b5e393 = &function_6431ee758747da9b;
        }
    }
    
    if ( level.killstreak_emp_initialized )
    {
        uavmodel.ksempapplycallback = &empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        uavmodel.ksempclearcallback = &empcleared;
    }
    
    uavmodel emp_debuff::function_6e0986f750cd4259( &function_5b83b1c37138834a );
    uavmodel thread handleflight();
    return true;
}

// Namespace uav
// Params 6
// Checksum 0x886f791b, Offset: 0x147c
// Size: 0x994
function uav_create( launchorigin, owner, uavtype, streakinfo, entitylessuav, lifetimeOverride )
{
    uavmodel = undefined;
    var_8796fa0c5bd9c792 = undefined;
    
    if ( entitylessuav )
    {
        uavmodel = { #damagetaken:0 };
    }
    else
    {
        uavmodel = spawn( "script_model", launchorigin + ( 0, 0, 5000 ) );
        uavmodel.streakinfo = streakinfo;
        var_8796fa0c5bd9c792 = uavmodel function_cfa7457e008e0496( uavtype, launchorigin );
        
        if ( !var_8796fa0c5bd9c792 )
        {
            uavmodel delete();
            return;
        }
    }
    
    /#
        if ( getdvarint( @"scr_debuguav" ) )
        {
            uavmodel thread debugbreadcrumbs();
            uavmodel thread debuglocation();
            uavmodel thread debugtrace();
        }
    #/
    
    model = level.uavsettings[ uavtype ].modelbase;
    
    if ( player_utility::getplayersuperfaction( owner ) && level.uavsettings[ uavtype ].modelbasealt )
    {
        model = level.uavsettings[ uavtype ].modelbasealt;
    }
    
    maxhealth = streakinfo.bundle.maxhealth ?? level.uavsettings[ uavtype ].maxhealth;
    calloutsplash = level.uavsettings[ uavtype ].teamsplash;
    
    if ( isent( uavmodel ) )
    {
        uavmodel setmodel( model );
    }
    
    uavmodel.team = owner.team;
    uavmodel.owner = owner;
    uavmodel.timetoadd = 0;
    uavmodel.uavtype = uavtype;
    uavmodel.health = level.uavsettings[ uavtype ].health;
    uavmodel.maxhealth = maxhealth;
    uavmodel.currenthealth = maxhealth;
    uavmodel.streakinfo = streakinfo;
    uavmodel.bundle = streakinfo.bundle;
    uavmodel.var_bdc51be80cbeef82 = uavmodel.bundle.var_bdc51be80cbeef82;
    uavmodel.var_8cd831a3c0cc9bdc = level status_tracking::function_25399da4af77eea1();
    uavmodel thread monitorowner();
    uavmodel thread function_9a2fe49d16fc401();
    uavmodel thread watchgameend();
    uavmodel thread watchlifetime( uavtype, lifetimeOverride, owner );
    
    if ( isent( uavmodel ) )
    {
        uavmodel setotherent( owner );
        uavmodel scriptmoveroutline();
        uavmodel scriptmoverthermal();
        
        if ( utility::issharedfuncdefined( #"uav", #"attachxrays" ) )
        {
            uavmodel = [[ utility::getsharedfunc( #"uav", #"attachxrays" ) ]]( uavmodel );
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
        {
            uavmodel [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( uavtype, "Killstreak_Air", owner );
        }
        
        uavmodel thread watchdamage();
        uavmodel thread function_21b79fd56a33f95e();
        
        if ( streakinfo.bundle.var_448f7392e3ad68a == #"autoflares" )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                uavmodel [[ var_32dbca3143d9c4a5 ]]( 1, 0, 5, 1, 1 );
            }
        }
        
        bundle = streakinfo.bundle;
        uavmodel thread killstreak_utility::killstreak_registerminimapinfo( bundle, getxhash( uavmodel.uavtype ) );
        uavmodel setscriptablepartstate( "lights", "on", 0 );
        
        if ( uavmodel.uavtype == "uav" || uavmodel.uavtype == "directional_uav" )
        {
            if ( uavmodel getscriptablehaspart( "flying" ) )
            {
                uavmodel setscriptablepartstate( "flying", "on", 0 );
            }
        }
        
        if ( uavmodel.uavtype == "counter_uav" )
        {
            uavmodel setscriptablepartstate( "rotors", "on", 0 );
        }
        
        var_ee7e9bda4e4a8d3 = 0;
        var_f0affbda50b20ed = 1000;
        var_be7b68c27eb5a9ea = 6000;
        var_be9e72c27edc07a0 = 6500;
        
        switch ( uavtype )
        {
            case #"hash_10e585c25e7e9f60":
                var_ee7e9bda4e4a8d3 = 300;
                var_f0affbda50b20ed = 550;
                var_be7b68c27eb5a9ea = 2000;
                var_be9e72c27edc07a0 = 2500;
                break;
            case #"hash_e171e5b86ef0a4cc":
                var_ee7e9bda4e4a8d3 = 20000;
                var_f0affbda50b20ed = 22000;
                var_be7b68c27eb5a9ea = 30000;
                var_be9e72c27edc07a0 = 31000;
                break;
        }
        
        circleradiusdefault = bundle.var_f021d408e69991c8 ?? 4000;
        circleradiusmin = bundle.var_c0afd5f2306eb519 ?? var_ee7e9bda4e4a8d3;
        circleradiusmax = bundle.var_c08ce7f2304894f7 ?? var_f0affbda50b20ed;
        baseradiusoffset = randomintrange( circleradiusmin, circleradiusmax );
        flightheightmin = bundle.var_b6e13ca020e39cc9 ?? var_be7b68c27eb5a9ea;
        flightheightmax = bundle.var_b6be2ea020bd3647 ?? var_be9e72c27edc07a0;
        zoffset = randomintrange( flightheightmin, flightheightmax );
        
        if ( issubstr( level.mapname, "mp_catedral" ) )
        {
            zoffset += 5000;
        }
        
        /#
            var_e8c1f67101225500 = getdvarint( @"scr_uav_height_offset", 0 );
            zoffset += var_e8c1f67101225500;
        #/
        
        radiusoffset = baseradiusoffset + circleradiusdefault;
        uavmodel.radiusoffset = radiusoffset;
        angle = randomint( 360 );
        xoffset = cos( angle ) * radiusoffset;
        yoffset = sin( angle ) * radiusoffset;
        anglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
        anglevector *= zoffset;
        
        if ( isbrgamemode() )
        {
            additional_height_offset = ( 0, 0, 3000 );
            anglevector += additional_height_offset;
        }
        
        var_56cd1f8896a8f45c = bundle.flyclockwise ? 90 : -90;
        var_dc92475e014ffb9a = bundle.var_f756aaa561aaef71 ?? 0;
        uavmodel linkto( var_8796fa0c5bd9c792, "tag_origin", anglevector, ( 0, angle + var_56cd1f8896a8f45c, var_dc92475e014ffb9a ) );
        uavmodel thread function_88a0a8df21588a84();
        uavmodel killstreak_utility::function_b555369eba6b0252( 1, uavmodel.maxhealth * 0.75, &function_2b92632daaa6b4c0 );
        uavmodel killstreak_utility::function_b555369eba6b0252( 2, uavmodel.maxhealth * 0.5, &function_12540d67807e8391 );
        uavmodel killstreak_utility::function_b555369eba6b0252( 3, uavmodel.maxhealth * 0.25, &heavydamagestate );
    }
    
    uavmodel [[ level.uavsettings[ uavtype ].addfunc ]]();
    
    if ( uavtype == "uav" || uavtype == "directional_uav" )
    {
        uavmodel function_4196eb1034a20774( 1 );
        uavmodel thread function_72fa1998c7269e35();
    }
    
    index = uavmodel.team;
    
    if ( level.var_f3d1cde89907a07a )
    {
        index = owner.sessionsquadid;
    }
    
    if ( level.activeuavs[ index ] > 0 )
    {
        if ( isent( uavmodel ) )
        {
            foreach ( uav in level.uavmodels[ index ] )
            {
                if ( uav == uavmodel )
                {
                    continue;
                }
                
                if ( isdefined( uav.timetoadd ) )
                {
                    uav.timetoadd += 5;
                }
            }
        }
        else
        {
            uavmodel.timetoadd = 5 * ( level.activeuavs[ index ] - 1 );
        }
    }
    
    vostreakname = streakinfo.streakname;
    
    if ( owner function_dd2fd3d16d132212( uavtype ) )
    {
        vostreakname = "directional_uav";
        challenges::function_37e945722d6497f3( owner, "br_three_uav", 1 );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        owner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( vostreakname );
        var_65934120c2efeb81 = 2;
    }
    
    isbr = isbrgamemode();
    
    if ( isbr )
    {
        killstreak_utility::killstreak_dangernotifyplayersinrange( owner, uavmodel.team, 15000, vostreakname );
    }
    else
    {
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, vostreakname + "_use", #"use", 1, var_65934120c2efeb81 );
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, var_65934120c2efeb81 );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( calloutsplash, owner );
    }
    
    level notify( #"uav_update" );
    level notify( #"uav_started", owner, uavtype );
    return uavmodel;
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0xa40a8741, Offset: 0x1e19
// Size: 0x198
function private function_cfa7457e008e0496( uavtype, launchorigin )
{
    uavrig = undefined;
    
    if ( !game_utility::islargemap() )
    {
        foreach ( rig in level.uavrigs )
        {
            if ( uavtype == rig.uavtype )
            {
                uavrig = rig;
                break;
            }
        }
    }
    else if ( level.uavrigs.size >= 30 )
    {
        return;
    }
    
    if ( !uavrig )
    {
        uavrig = spawn( "script_model", launchorigin );
        uavrig setmodel( "tag_origin" );
        uavrig.angles = ( 0, 115, 0 );
        uavrig.uavtype = uavtype;
        uavrig hide();
        bundle = self.streakinfo.bundle;
        rotatetime = bundle.var_79175bd6bc5797c7 ?? 70;
        level.uavrigs[ level.uavrigs.size ] = uavrig;
        uavrig thread function_6b3f5c495f61451d( rotatetime, istrue( bundle.flyclockwise ) );
        
        if ( game_utility::islargemap() )
        {
            uavrig thread function_edadfa9e4163fd51( self );
        }
        else
        {
            uavrig thread function_c9d578fd190af200();
        }
    }
    
    return uavrig;
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x9fa5c385, Offset: 0x1fba
// Size: 0x4f
function private function_6b3f5c495f61451d( rotatetime, flyclockwise )
{
    self endon( #"death" );
    yawangle = flyclockwise ? 360 : -360;
    
    while ( true )
    {
        self rotateyaw( yawangle, rotatetime );
        wait rotatetime;
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x20c6b195, Offset: 0x2011
// Size: 0x4d
function private function_edadfa9e4163fd51( ent )
{
    self endon( #"death" );
    ent utility::waittill_any( "leaving", "explode", "death" );
    level.uavrigs = arrayremove( level.uavrigs, self );
    self delete();
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x41ffeb4c, Offset: 0x2066
// Size: 0x38
function private function_c9d578fd190af200()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    level.uavrigs = arrayremove( level.uavrigs, self );
    self delete();
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xccd834a4, Offset: 0x20a6
// Size: 0x130
function private function_88a0a8df21588a84()
{
    self endon( #"death" );
    self endon( #"explode" );
    
    while ( true )
    {
        level utility::waittill_any( "joined_team", "uav_update" );
        
        /#
            if ( getdvarint( @"hash_ac7f6a636682c52f", 0 ) == 1 )
            {
                self show();
                continue;
            }
        #/
        
        self hide();
        
        foreach ( player in level.players )
        {
            if ( level.teambased )
            {
                if ( isdefined( player.team ) && isdefined( self.team ) && player.team != self.team )
                {
                    self showtoplayer( player );
                }
                
                continue;
            }
            
            if ( player === self.owner )
            {
                continue;
            }
            
            self showtoplayer( player );
        }
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x241696f2, Offset: 0x21de
// Size: 0x70f
function private handleflight( worldspawned )
{
    level endon( #"game_ended" );
    uavtype = self.uavtype;
    uavowner = self.owner;
    uavteam = self.team;
    
    if ( uavtype == "uav" || uavtype == "directional_uav" || uavtype == "counter_uav" )
    {
        foreach ( player in level.players )
        {
            player function_e617acf4bd6dbeff( self );
        }
    }
    
    result = utility::waittill_any_return( "explode", "timeout" );
    bundle = self.streakinfo.bundle;
    
    if ( result == "timeout" )
    {
        if ( isent( self ) )
        {
            self unlink();
            exitdistance = bundle.var_c02173d3ce6defcf ?? 50000;
            self.destpoint = self.origin + anglestoforward( self.angles ) * exitdistance;
            var_3151517a0043b64a = bundle.var_c591d6bde14f2b8e ?? exitdistance / 50;
            var_40bcf4be3b3ff = exitdistance / var_3151517a0043b64a;
            var_d4b4e1a7a819c908 = bundle.var_607a1b997d818c8c ?? 0;
            
            if ( var_d4b4e1a7a819c908 > 0 )
            {
                thread exit_accel_lerp( self.destpoint, exitdistance, var_3151517a0043b64a, var_40bcf4be3b3ff, var_d4b4e1a7a819c908 );
            }
            else
            {
                self moveto( self.destpoint, var_40bcf4be3b3ff );
            }
            
            thread exit_angle_lerp( self.angles, var_40bcf4be3b3ff );
            
            if ( uavtype == "uav" )
            {
                if ( self getscriptablehaspart( "leaving" ) )
                {
                    self setscriptablepartstate( "leaving", "on", 0 );
                }
            }
        }
        
        if ( uavowner && !level.gameended )
        {
            uavowner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.uavtype + "_leave", #"leave", 1 );
        }
        
        exitdelay = bundle.var_997ca52751c048c7 ?? 3;
        hostmigration::waittillnotifyortimeoutpause( "death", exitdelay );
        
        if ( self.damagetaken < self.maxhealth )
        {
            self notify( #"leaving" );
            self.isleaving = 1;
            
            if ( isent( self ) )
            {
                self.var_b8aae568e66b4bc7 = 1;
                var_c2a2f95a5a11649c = distance2d( self.destpoint, self.origin );
                var_cd0399f47f88b6b5 = bundle.var_126be63486893f19 ?? var_c2a2f95a5a11649c / 15;
                var_1c257a9b8a6ba28e = var_c2a2f95a5a11649c / var_cd0399f47f88b6b5;
                var_78ac94cfa4f2d407 = bundle.var_bfcfea72c709cf7b ?? 0;
                
                if ( var_78ac94cfa4f2d407 > 0 )
                {
                    thread exit_accel_lerp( self.destpoint, var_c2a2f95a5a11649c, var_cd0399f47f88b6b5, var_1c257a9b8a6ba28e, var_78ac94cfa4f2d407, var_3151517a0043b64a );
                }
                else
                {
                    self moveto( self.destpoint, var_1c257a9b8a6ba28e );
                }
                
                if ( uavtype == "uav" )
                {
                    if ( self getscriptablehaspart( "exit" ) )
                    {
                        self setscriptablepartstate( "exit", "on", 0 );
                    }
                }
            }
            
            var_1139dc5fa1f5611c = bundle.var_9a2095ba5c21eb2a ?? 4;
            hostmigration::waittillnotifyortimeoutpause( "death", var_1139dc5fa1f5611c + self.timetoadd );
            
            if ( self.damagetaken < self.maxhealth )
            {
                self.leftplayspace = 1;
            }
        }
    }
    
    if ( self )
    {
        if ( uavowner )
        {
            uavowner notify( #"uav_finished" );
            
            if ( uavtype == "directional_uav" )
            {
                level.var_6b5444dcdd38ca18[ uavowner.team ] = gettime();
            }
            
            if ( uavtype == "uav" )
            {
                level.var_ae09cd9b35c30f63[ uavowner.team ] = gettime();
            }
        }
        
        if ( uavtype == "uav" || uavtype == "directional_uav" )
        {
            function_4196eb1034a20774( level.minimaponbydefault );
        }
        
        if ( uavtype != "counter_uav" || !self.var_dae55d5fb890ae03 )
        {
            self [[ level.uavsettings[ uavtype ].removefunc ]]();
        }
        
        if ( !worldspawned )
        {
            level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
        }
        
        if ( isdefined( self.enemyobjid ) )
        {
            if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
            {
                [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.enemyobjid );
            }
            
            self notify( #"uav_deleteobjective" );
        }
        
        self.streakinfo.expiredbydeath = !self.leftplayspace;
        
        if ( uavowner )
        {
            uavowner killstreak_utility::recordkillstreakendstats( self.streakinfo );
        }
        
        if ( isent( self ) )
        {
            thread delaydelete();
        }
        else
        {
            self notify( #"death" );
        }
    }
    
    if ( uavtype == "directional_uav" )
    {
        if ( uavowner && !( isdefined( uavowner.perks[ "specialty_overwatch" ] ) || isdefined( uavowner.perks[ "specialty_pc_comms" ] ) ) )
        {
            uavowner.radarshowenemydirection = 0;
        }
        
        if ( level.teambased )
        {
            foreach ( player in level.players )
            {
                if ( player.pers[ "team" ] === uavteam && !( isdefined( player.perks[ "specialty_overwatch" ] ) || isdefined( player.perks[ "specialty_pc_comms" ] ) ) )
                {
                    if ( level.var_f3d1cde89907a07a && player.sessionsquadid != uavowner.sessionsquadid )
                    {
                        continue;
                    }
                    
                    player.radarshowenemydirection = 0;
                }
            }
        }
    }
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>" + uavtype, uavowner );
        }
    #/
    
    level notify( #"uav_update" );
    
    if ( isbrgamemode() )
    {
        level notify( #"uav_finished", uavowner );
    }
}

// Namespace uav
// Params 6, eflags: 0x4
// Checksum 0x2308e973, Offset: 0x28f5
// Size: 0x16e
function private exit_accel_lerp( position, exitdistance, speed, movetime, acceltime, initialspeed )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    bundle = self.streakinfo.bundle;
    starttime = gettime();
    totaltime = ( movetime >= acceltime ? acceltime : movetime ) * 1000;
    
    if ( !initialspeed )
    {
        launchorigin = killstreak_utility::killstreak_getmapcenter( self.owner );
        radius = distance( self.origin, launchorigin );
        var_b435e0f9978a8d35 = 6.28318 * radius;
        initialspeed = var_b435e0f9978a8d35 / bundle.var_79175bd6bc5797c7;
    }
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        assert( totaltime > 0 );
        fraction = min( timepassed / totaltime, 1 );
        newspeed = math::lerp( initialspeed, speed, fraction );
        newmovetime = exitdistance / newspeed;
        self moveto( position, newmovetime );
        
        if ( fraction >= 1 )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x9fbe8c7b, Offset: 0x2a6b
// Size: 0xd5
function private exit_angle_lerp( startingangle, movetime )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    
    if ( startingangle[ 2 ] == 0 )
    {
        return;
    }
    
    starttime = gettime();
    totaltime = ( movetime >= 1.5 ? 1.5 : movetime ) * 1000;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        assert( totaltime > 0 );
        fraction = min( timepassed / totaltime, 1 );
        self.angles = math::angle_lerp( startingangle, ( startingangle[ 0 ], startingangle[ 1 ], 0 ), fraction );
        
        if ( fraction >= 1 )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x27408824, Offset: 0x2b48
// Size: 0x13a
function private watchgameend()
{
    self endon( #"death", #"explode" );
    self.owner endon( #"uav_finished" );
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player isscriptable() )
        {
            if ( player getscriptablehaspart( #"cuav_scramble_sfx" ) )
            {
                player setscriptablepartstate( #"cuav_scramble_sfx", #"off", 0 );
            }
        }
    }
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
}

// Namespace uav
// Params 3, eflags: 0x4
// Checksum 0x4ab4d077, Offset: 0x2c8a
// Size: 0x134
function private watchlifetime( uavtype, lifetimeOverride, owner )
{
    duration = level.uavsettings[ uavtype ].timeout;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            duration = 9999;
        }
    #/
    
    duration = lifetimeOverride ?? duration;
    
    if ( !isdefined( lifetimeOverride ) && owner && isdefined( owner.perks[ "specialty_uav_buff" ] ) )
    {
        duration *= level.var_1099f076e66a8a09 ?? 1;
    }
    
    self.lifetimeendtime = int( duration * 1000 + gettime() );
    self endon( #"death" );
    self endon( #"explode" );
    halfduration = duration / 2;
    wait halfduration;
    
    if ( owner && !level.gameended )
    {
        owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.uavtype + "_halfway", #"halfway", 1 );
    }
    
    wait halfduration;
    self notify( #"timeout" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x41e12a0a, Offset: 0x2dc6
// Size: 0xeb
function private function_21b79fd56a33f95e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    
    while ( true )
    {
        level waittill( #"stinger_fired", player, missile, locktarget );
        
        if ( locktarget != self )
        {
            continue;
        }
        
        if ( self.streakinfo.bundle.var_448f7392e3ad68a == #"autoflares" )
        {
            if ( utility::issharedfuncdefined( #"flare_system", #"hash_1101719e6ff74ce" ) )
            {
                if ( self [[ utility::getsharedfunc( #"flare_system", #"hash_1101719e6ff74ce" ) ]]() )
                {
                    self setscriptablepartstate( #"flares", #"deploy" );
                }
            }
        }
        
        missile thread function_ff1de857ca2610ff( locktarget, player );
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xf5086f88, Offset: 0x2eb9
// Size: 0xa2
function private monitorowner()
{
    self endon( #"death" );
    self endon( #"explode" );
    
    if ( isbrgamemode() && self.uavtype != "directional_uav" )
    {
        self.owner utility::waittill_any( "death_or_disconnect", "joined_team" );
    }
    else
    {
        self.owner utility::waittill_any( "disconnect", "joined_team" );
    }
    
    if ( isent( self ) )
    {
        self setscriptablepartstate( "explode", "on", 0 );
        self.damagetaken = self.maxhealth;
    }
    
    self notify( #"explode" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xff349012, Offset: 0x2f63
// Size: 0x15d
function private function_9a2fe49d16fc401()
{
    self endon( #"death" );
    self endon( #"explode" );
    
    while ( true )
    {
        level waittill( #"host_migration_end" );
        
        if ( level.teambased )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( level.var_f3d1cde89907a07a )
                {
                    foreach ( squadindex in level.squaddata[ team ] )
                    {
                        currentradar = function_c797d43622f72e29( team, squadindex );
                        function_e2ed0dc39a0d8d25( team, squadindex, currentradar );
                    }
                    
                    continue;
                }
                
                currentradar = function_c6b46bde3b7bc0a1( team );
                uav_setteamradarstrength( team, currentradar );
            }
        }
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xf40a5beb, Offset: 0x30c8
// Size: 0x1b
function private delaydelete()
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( self )
    {
        self delete();
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x2b2d4cef, Offset: 0x30eb
// Size: 0x825
function private watchdamage()
{
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    bundle = self.streakinfo.bundle;
    var_958b37df1da839b5 = istrue( bundle.var_958b37df1da839b5 );
    self setcandamage( 1 );
    self.damagetaken = 0;
    radar_drop = getdvarint( @"hash_5cca715067c056a", bundle.var_dce161dc52749ac3 ?? 0 );
    
    /#
        setdvarifuninitialized( @"hash_5cca715067c056a", radar_drop );
    #/
    
    if ( radar_drop )
    {
        thread function_c9f638a9e3186372( bundle, self.owner );
    }
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        debugdamage = undefined;
        
        /#
            debugdamage = istrue( self.debugdamage );
        #/
        
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( !isplayer( attacker ) && objweapon.basename != "missile_turret_proj_jup_mp" )
        {
            if ( !self )
            {
                return;
            }
            
            continue;
        }
        
        if ( var_958b37df1da839b5 && ( meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" ) )
        {
            continue;
        }
        
        if ( isdefined( idflags ) && idflags & 8 )
        {
            self.wasdamagedfrombulletpenetration = 1;
        }
        
        if ( isdefined( idflags ) && idflags & 256 )
        {
            self.wasdamagedfrombulletricochet = 1;
        }
        
        self.wasdamaged = 1;
        modifieddamage = damage;
        divisorlrg = 1;
        divisormed = 1;
        divisorlow = 1;
        divisormelee = 0;
        divisortick = 3;
        
        if ( self.uavtype == "counter_uav" )
        {
            divisorlrg = 1;
            divisormed = 2;
            divisorlow = 3;
            divisormelee = 0;
            divisortick = 0;
        }
        else if ( self.uavtype == "directional_uav" )
        {
            divisorlrg = 5;
            divisormed = 6;
            divisorlow = 7;
            divisormelee = 0;
            divisortick = 0;
        }
        
        if ( objweapon )
        {
            if ( debugdamage )
            {
                modifieddamage = damage;
            }
            else if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
            {
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:inflictor } );
            }
            else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
            {
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick );
            }
            
            data = { #objweapon:objweapon, #idflags:idflags, #partname:partname, #tagname:tagname, #modelname:modelname, #inflictor:inflictor, #meansofdeath:meansofdeath, #point:point, #direction_vec:direction_vec, #attacker:attacker, #damage:damage, #victim:self };
            
            if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
            {
                [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, meansofdeath, modifieddamage, data );
            }
        }
        
        self.damagetaken += modifieddamage;
        
        /#
            if ( self && getdvarint( @"g_debugdamage" ) )
            {
                println( "<dev string:x38>" + self getentitynumber() + "<dev string:x3d>" + self.health - self.damagetaken + "<dev string:x46>" + attacker.clientid + "<dev string:x51>" + isplayer( attacker ) + "<dev string:x67>" + modifieddamage + "<dev string:x70>" + distance( attacker.origin, self.origin ) );
            }
        #/
        
        self.currenthealth -= modifieddamage;
        killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
        destroyed = self.damagetaken >= self.maxhealth;
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                icontype = "hitequip";
                
                if ( self.var_bdc51be80cbeef82 )
                {
                    icontype = "hitextrahealth";
                }
                
                var_7731d58f6f82f082 = { #mod:meansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
                
                if ( damagefeedback::isusingstackablehitmarker() )
                {
                    hitmarkercategory = undefined;
                    
                    if ( utility::isbulletdamage( meansofdeath ) )
                    {
                        hitmarkercategory = 3;
                    }
                    else
                    {
                        hitmarkercategory = 2;
                    }
                    
                    var_795e8a31194a39ac = { #victimentity:self };
                    attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( icontype, destroyed, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac, var_7731d58f6f82f082, undefined, hitmarkercategory );
                }
                else
                {
                    attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( icontype, destroyed, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_7731d58f6f82f082 );
                }
            }
        }
        
        if ( destroyed )
        {
            if ( objweapon.var_25b0062cbe4d9c99 == #"black_hat_sat_mp" && self.owner )
            {
                self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
            }
            
            if ( isplayer( attacker ) && attacker != self.owner )
            {
                var_de5a14e77c43df42 = level.uavsettings[ self.uavtype ].calloutdestroyed;
                
                if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
                {
                    additionalparams = { #inflictor:inflictor };
                    self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( self.uavtype, attacker, objweapon, meansofdeath, damage, "destroyed_" + self.uavtype, undefined, var_de5a14e77c43df42, 1, additionalparams );
                }
                
                if ( self.uavremotemarkedby && self.uavremotemarkedby != attacker )
                {
                    if ( utility::issharedfuncdefined( #"uav", #"hash_9506ae4b51f5cbf0" ) )
                    {
                        self.uavremotemarkedby thread [[ utility::getsharedfunc( #"uav", #"hash_9506ae4b51f5cbf0" ) ]]();
                    }
                }
                
                if ( bundle.var_1a3234554d03c0d3 )
                {
                    thread feedbackloop( attacker );
                }
            }
            
            self setscriptablepartstate( "explode", "on", 0 );
            self notify( #"explode", attacker );
            return;
        }
        
        if ( objweapon.var_25b0062cbe4d9c99 == #"black_hat_sat_mp" && self.owner )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
        }
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x4306eb14, Offset: 0x3918
// Size: 0x9b
function private function_1ae89561e939df04()
{
    if ( self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    
    if ( self.uavtype == "uav" || self.uavtype == "counter_uav" )
    {
        if ( self.owner )
        {
            self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.uavtype + "_destroyed", #"destroyed", 1 );
        }
    }
    
    self setscriptablepartstate( "explode", "on", 0 );
    self notify( #"explode" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xb92d8dd5, Offset: 0x39bb
// Size: 0x1f
function private function_2b92632daaa6b4c0()
{
    if ( self getscriptablehaspart( "body_damage_light" ) )
    {
        self setscriptablepartstate( "body_damage_light", "on" );
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x7556fbba, Offset: 0x39e2
// Size: 0x1f
function private function_12540d67807e8391()
{
    if ( self getscriptablehaspart( "body_damage_medium" ) )
    {
        self setscriptablepartstate( "body_damage_medium", "on" );
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x658884, Offset: 0x3a09
// Size: 0x1f
function private heavydamagestate()
{
    if ( self getscriptablehaspart( "body_damage_heavy" ) )
    {
        self setscriptablepartstate( "body_damage_heavy", "on" );
    }
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x4e586d71, Offset: 0x3a30
// Size: 0x10c
function private function_ff1de857ca2610ff( target, player )
{
    self endon( #"death" );
    prevtargetlocation = target getpointinbounds( 0, 0, 0 );
    var_65f403bd0dfc82ed = distancesquared( self.origin, prevtargetlocation );
    
    while ( true )
    {
        if ( target )
        {
            curtargetlocation = target getpointinbounds( 0, 0, 0 );
        }
        else
        {
            curtargetlocation = prevtargetlocation;
        }
        
        prevtargetlocation = curtargetlocation;
        var_2bffe4cd095fe7a8 = distancesquared( self.origin, curtargetlocation );
        var_c583f4f1a64116e3 = var_2bffe4cd095fe7a8 < var_65f403bd0dfc82ed;
        
        if ( var_c583f4f1a64116e3 )
        {
            var_65f403bd0dfc82ed = var_2bffe4cd095fe7a8;
        }
        
        var_873cb2d60ef1b806 = var_2bffe4cd095fe7a8 > var_65f403bd0dfc82ed;
        
        if ( var_873cb2d60ef1b806 )
        {
            if ( var_2bffe4cd095fe7a8 > 2359296 )
            {
                return;
            }
            
            waitframe();
            self radiusdamage( self.origin, 1536, 600, 600, player, "MOD_EXPLOSIVE", self.weapon_name );
            self hide();
            self notify( #"deleted" );
            waitframe();
            self delete();
        }
        
        waitframe();
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0xc130896f, Offset: 0x3b44
// Size: 0x128
function private function_9f6a4f52b5b46d1a( duration )
{
    if ( self.var_dae55d5fb890ae03 )
    {
        return;
    }
    
    self.var_dae55d5fb890ae03 = 1;
    
    if ( self.uavtype == "uav" )
    {
        self.owner blockradar( self.owner.team );
        self setscriptablepartstate( #"hacked", #"hacked", 0 );
        wait duration / 1000;
        
        if ( self )
        {
            self setscriptablepartstate( #"hacked", #"off", 0 );
            self.owner function_5122edb52319dece( self.owner.team );
        }
    }
    else
    {
        uav_removeactivecounteruav();
        self setscriptablepartstate( #"hacked", #"hacked", 0 );
        wait duration / 1000;
        
        if ( self.currenthealth >= 1 )
        {
            self setscriptablepartstate( #"hacked", #"off", 0 );
            uav_addactivecounteruav();
            level notify( #"uav_update" );
        }
    }
    
    self.var_dae55d5fb890ae03 = undefined;
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x66b27abf, Offset: 0x3c74
// Size: 0x36
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        thread function_9f6a4f52b5b46d1a( hackeffect.hackduration );
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x9639bca6, Offset: 0x3cb2
// Size: 0x166
function private function_6431ee758747da9b( data )
{
    level endon( #"game_ended" );
    self endon( #"death", #"explode" );
    destroydelay = 1.5;
    var_dbd43a8b925f566f = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
    
    if ( var_dbd43a8b925f566f )
    {
        uavtype = getxhash( data.victim.uavtype ?? "" );
        
        switch ( uavtype )
        {
            case #"uav":
                destroyedscoreevent = #"kill_ss_uav";
                destroydelay = 0.1;
                break;
            case #"counter_uav":
                destroyedscoreevent = #"kill_ss_counter_uav";
                destroydelay = 0.2;
                break;
            case #"directional_uav":
                destroyedscoreevent = #"kill_ss_directional_uav";
                destroydelay = 0.3;
                break;
        }
        
        if ( destroyedscoreevent )
        {
            wait destroydelay;
            alreadywaited = 1;
            
            if ( data.attacker )
            {
                data.attacker thread [[ var_dbd43a8b925f566f ]]( destroyedscoreevent, data.objweapon, undefined, undefined, data.victim );
            }
        }
    }
    
    if ( !alreadywaited )
    {
        wait destroydelay;
    }
    
    thread function_1ae89561e939df04();
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x49c2f3f9, Offset: 0x3e20
// Size: 0x13
function private empapplied( data )
{
    thread function_1ae89561e939df04();
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x98d3a098, Offset: 0x3e3b
// Size: 0x61
function private function_5b83b1c37138834a( data )
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"uav_finished" );
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    function_6431ee758747da9b( data );
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x4324bc32, Offset: 0x3ea4
// Size: 0xc
function private empcleared( data )
{
    
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0xef0c8275, Offset: 0x3eb8
// Size: 0x27c
function private function_c9f638a9e3186372( bundle, owner )
{
    level endon( #"game_ended" );
    self waittill( #"explode", attacker );
    var_ed8bab9657750de2 = self getorigin();
    wait 1;
    pickup = spawnscriptable( bundle.var_f006fc13c8981c1b, var_ed8bab9657750de2 );
    pickup.var_ed8bab9657750de2 = var_ed8bab9657750de2;
    pickup.parent = spawn( "script_model", pickup.origin );
    pickup.owner = owner;
    pickup.attacker = attacker;
    pickup.bundle = bundle;
    pickup.timeout = getdvarfloat( @"hash_31a0ac44c86552e2", bundle.var_2ceec56e5c90e4ef ?? 10 );
    pickup endon( #"death" );
    pickup.parent endon( #"death" );
    pickup childthread function_c63bb61e22f5143b( pickup.timeout );
    pickup function_60396915b6edf21a();
    
    if ( !pickup.target_pos )
    {
        if ( isent( pickup ) )
        {
            pickup delete();
        }
        
        return;
    }
    
    pickup scriptablesetparententity( pickup.parent );
    pickup setscriptablepartstate( #"pickup", #"transition" );
    pickup.parent moveto( pickup.target_pos, pickup.bundle.var_de13377602439a94, pickup.bundle.var_de13377602439a94 * 0.25 );
    wait pickup.bundle.var_de13377602439a94;
    pickup.parent.angles = ( -90, 0, 0 );
    pickup setscriptablepartstate( #"pickup", #"on" );
    interaction::register_scriptable_interact( pickup, &function_3a44dc22047fbe5e );
    pickup.parent moveto( pickup.target_pos + ( 0, 0, 32 ), 0.25 );
    wait 0.25;
    pickup.parent function_616378d7e5b22efb( ( -1, 0, 0 ), 2.5, 2.5 );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x89cbd286, Offset: 0x413c
// Size: 0x1a7
function private function_60396915b6edf21a()
{
    max_attempt = getdvarint( @"hash_bd61e00cacd63fa6", self.bundle.var_17aabddb50921785 ?? 10 );
    cur_attempt = 0;
    self.target_candidates = [];
    self.target_ignore_ents = [ self.owner, self.attacker ];
    
    /#
        childthread function_fc1c9dd8aeba89ad();
    #/
    
    while ( cur_attempt < max_attempt )
    {
        self.target_center = getclosestpointonnavmesh( self.var_ed8bab9657750de2 );
        self.target_radius = self.bundle.var_b590dafafec18944 ?? 256;
        self.target_candidate = getrandomnavpoint( self.target_center, self.target_radius );
        self.target_ignore_ents = function_5713d46873b29625( self.target_ignore_ents );
        var_d38d244f01558df8 = trace::ray_trace( self.var_ed8bab9657750de2, self.target_candidate, self.target_ignore_ents, undefined, 0, 0, 1 );
        
        if ( var_d38d244f01558df8[ "hittype" ] == "hittype_none" )
        {
            self.target_pos = self.target_candidate;
            self.target_candidates = arraycombineunique( self.target_candidates, [ { #pass:1, #var_d38d244f01558df8:var_d38d244f01558df8 } ] );
            return;
        }
        
        self.target_candidates = arraycombineunique( self.target_candidates, [ { #pass:0, #var_d38d244f01558df8:var_d38d244f01558df8 } ] );
        cur_attempt++;
        waitframe();
    }
}

/#

    // Namespace uav
    // Params 0, eflags: 0x4
    // Checksum 0x14f33d1, Offset: 0x42eb
    // Size: 0xfc, Type: dev
    function private function_fc1c9dd8aeba89ad()
    {
        while ( self )
        {
            if ( self.target_center )
            {
                circle( self.target_center, self.target_radius, ( 0, 0, 1 ) );
            }
            
            setdvar( @"scr_trace_debug_data", 1 );
            
            foreach ( candidate in self.target_candidates )
            {
                trace::draw_trace( candidate.var_d38d244f01558df8, candidate.pass ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x983a3335, Offset: 0x43ef
// Size: 0x24f
function private function_3a44dc22047fbe5e( player )
{
    self setscriptablepartstate( #"pickup", #"off" );
    self.streak_info = { #usedbefore:0, #bundle:self.bundle, #owner:player, #streakname:"uav" };
    deploy_weapon = makeweapon( self.bundle.var_66fefd46744d440c ?? "ks_remote_map_mp" );
    player killstreakdeploy::streakdeploy_doweaponswitchdeploy( self.streak_info, deploy_weapon, 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        player [[ var_32dbca3143d9c4a5 ]]( "used_" + self.streak_info.streakname, player );
    }
    
    sweep_amount = getdvarint( @"hash_9cdf56324f954d0e", self.bundle.var_c516e8f51c214315 ?? 1 );
    sweep_radius = self.bundle.var_8b8c3c26badd8227 ?? 128;
    var_8cac3e368d80309e = int( ( self.bundle.var_7ad86fdcf0fb76d0 ?? 1 ) * 1000 );
    sweep_fade = int( ( self.bundle.var_c2d4d589a9a655bf ?? 0.5 ) * 1000 );
    
    for ( sweep_current = 0; sweep_current < sweep_amount ; sweep_current++ )
    {
        if ( self.bundle.var_781f759922465ce0 )
        {
            player playlocalsound( self.bundle.var_781f759922465ce0, undefined, 1 );
        }
        
        if ( level.teambased )
        {
            triggerportableradarpingteam( player getorigin(), player.team, sweep_radius, var_8cac3e368d80309e, -1, sweep_fade );
        }
        else
        {
            triggerportableradarping( player getorigin(), player, sweep_radius, var_8cac3e368d80309e, undefined, sweep_fade );
        }
        
        if ( sweep_current < sweep_amount - 1 )
        {
            wait self.bundle.var_6222bca35007b4fc ?? 1;
        }
    }
    
    function_c63bb61e22f5143b();
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x142498e1, Offset: 0x4646
// Size: 0x30
function private function_c63bb61e22f5143b( delay )
{
    if ( delay )
    {
        wait delay;
    }
    
    if ( self )
    {
        self function_7653c765b6c7b815();
        self freescriptable();
        self notify( #"death" );
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x604da1e8, Offset: 0x467e
// Size: 0xd5
function private function_67c0138b8b484efa()
{
    foreach ( player in level.players )
    {
        if ( self.streakname == "directional_uav" || self.streakname == "counter_uav" )
        {
            return;
        }
        
        if ( !isdefined( player.perks[ "specialty_expanded_minimap" ] ) )
        {
            continue;
        }
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        thread function_b4b1727e42761e9c( player );
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x9d40efff, Offset: 0x475b
// Size: 0x40
function private function_b4b1727e42761e9c( enemyaffected )
{
    level endon( #"game_ended" );
    enemyaffected endon( #"disconnect" );
    triggeroneoffradarsweep( enemyaffected );
    self waittill( #"death" );
    triggeroneoffradarsweep( enemyaffected );
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0xfd32bc2a, Offset: 0x47a3
// Size: 0x102
function private feedbackloop( attacker )
{
    bundle = self.streakinfo.bundle;
    duration = bundle.var_9c2b948487edb1ba;
    feedbacksource = spawn( "script_model", self.origin );
    feedbacksource.nonvehicle = 1;
    feedbacksource.owner = attacker;
    feedbacksource.team = attacker.team;
    feedbacksource.timeout = duration;
    
    /#
        if ( getdvarint( @"hash_c69cc437d8666a35", 0 ) )
        {
            feedbacksource.owner = self.owner;
            feedbacksource.team = self.team;
        }
    #/
    
    feedbacksource thread function_a77b6eadd912adbf();
    feedbacksource thread function_d20e6d80823057d3();
    feedbacksource uav_addactivecounteruav();
    level notify( #"uav_update" );
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x8d08646c, Offset: 0x48ad
// Size: 0xfc
function private function_d581016f1187f16( data )
{
    duration = data.cuav_duration ?? 0;
    feedbacksource = spawn( "script_model", self.origin );
    feedbacksource.nonvehicle = 1;
    feedbacksource.owner = data.attacker;
    feedbacksource.team = data.attacker.team;
    feedbacksource.timeout = duration;
    
    /#
        if ( getdvarint( @"hash_c69cc437d8666a35", 0 ) )
        {
            feedbacksource.owner = self.owner;
            feedbacksource.team = self.team;
        }
    #/
    
    feedbacksource thread function_a77b6eadd912adbf();
    feedbacksource thread function_d20e6d80823057d3();
    feedbacksource uav_addactivecounteruav();
    level notify( #"uav_update" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xc7260de6, Offset: 0x49b1
// Size: 0x59
function private function_a77b6eadd912adbf()
{
    level endon( #"game_ended" );
    self endon( #"hash_abd2b7216bf1a80d" );
    
    if ( !isdefined( self.timeout ) )
    {
        return;
    }
    
    if ( self.timeout > 0 )
    {
        level utility::waittill_any_timeout( self.timeout, "bro_shot_start", "game_ended" );
    }
    
    thread function_c3b39a550e112ff();
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x345318ac, Offset: 0x4a12
// Size: 0x2c
function private function_d20e6d80823057d3()
{
    self endon( #"hash_abd2b7216bf1a80d" );
    level utility::waittill_any( "start_game_ended", "game_ended", "prematch_cleanup" );
    thread function_c3b39a550e112ff();
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x2ebd1af7, Offset: 0x4a46
// Size: 0x1c
function private function_c3b39a550e112ff()
{
    uav_removeactivecounteruav();
    self notify( #"hash_abd2b7216bf1a80d" );
    waitframe();
    self delete();
}

// Namespace uav
// Params 0
// Checksum 0xfff177a1, Offset: 0x4a6a
// Size: 0x3bc
function uav_addactiveuav()
{
    if ( level.totalactiveuavs == 0 )
    {
        level callback::add( #"hash_c0e3f7df1c23e95f", &function_51b3cfc745407c17 );
        level callback::add( #"hash_d74170bd7751a308", &function_f4db8d988bed2860 );
        
        if ( level.totalactivecounteruavs == 0 )
        {
            level callback::add( #"player_spawned", &function_2647ff449e2c45bf );
        }
    }
    
    level.totalactiveuavs++;
    bundle = self.owner killstreak::function_85b2d8e857ab4898( "uav" );
    
    if ( level.teambased )
    {
        uavowner = self.owner;
        index = level.var_f3d1cde89907a07a ? uavowner.sessionsquadid : self.team;
        level.activeuavs[ index ]++;
        
        if ( function_80e1bd8fc03312fd() )
        {
            level.var_d3e0b46ab1c070f8[ index ]++;
            level.var_9f462aa58e87d9c9[ index ][ level.var_9f462aa58e87d9c9[ index ].size ] = self;
            self.var_ef1ac9a3e788655 = 1;
        }
        
        if ( self.uavtype == "directional_uav" )
        {
            level.activeadvanceduavs[ index ]++;
            level.activeadvanceduavcount++;
            
            if ( isbrgamemode() )
            {
                level.var_9f462aa58e87d9c9[ index ][ level.var_9f462aa58e87d9c9[ index ].size ] = self;
            }
        }
        else if ( bundle.var_3d42fe1edbccc0d6 )
        {
            level.var_fb07bbf8c8d257ab[ index ]++;
        }
        
        return;
    }
    
    level.activeuavs[ self.owner.guid ]++;
    level.activeuavs[ self.owner.guid + "_radarStrength" ]++;
    
    if ( function_80e1bd8fc03312fd() )
    {
        if ( !isdefined( level.var_d3e0b46ab1c070f8[ self.owner.guid ] ) )
        {
            level.var_d3e0b46ab1c070f8[ self.owner.guid ] = 1;
        }
        
        level.var_9f462aa58e87d9c9[ self.owner.guid ][ level.var_9f462aa58e87d9c9[ self.owner.guid ].size ] = self;
        self.var_ef1ac9a3e788655 = 1;
    }
    
    if ( self.uavtype == "directional_uav" )
    {
        level.activeuavs[ self.owner.guid + "_radarStrength" ] = level.activeuavs[ self.owner.guid + "_radarStrength" ] + 2;
        
        if ( !isdefined( level.activeadvanceduavs[ self.owner.guid ] ) )
        {
            level.activeadvanceduavs[ self.owner.guid ] = 0;
        }
        
        level.activeadvanceduavs[ self.owner.guid ]++;
        level.activeadvanceduavcount++;
        
        if ( isbrgamemode() )
        {
            level.var_9f462aa58e87d9c9[ self.owner.guid ][ level.var_9f462aa58e87d9c9[ self.owner.guid ].size ] = self;
        }
        
        return;
    }
    
    if ( bundle.var_3d42fe1edbccc0d6 )
    {
        level.var_fb07bbf8c8d257ab[ self.owner.guid ]++;
        level.activeuavs[ self.owner.guid + "_radarStrength" ]++;
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x8cf008e, Offset: 0x4e2e
// Size: 0x3b, Type: bool
function private function_80e1bd8fc03312fd()
{
    if ( isbrgamemode() && isplayer( self.owner ) )
    {
        if ( isdefined( self.owner.perks[ "specialty_overwatch" ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace uav
// Params 0
// Checksum 0x16d5113b, Offset: 0x4e72
// Size: 0x117
function uav_addactivecounteruav()
{
    if ( level.totalactiveuavs == 0 && level.totalactivecounteruavs == 0 )
    {
        level callback::add( #"player_spawned", &function_2647ff449e2c45bf );
    }
    
    if ( level.teambased )
    {
        uavowner = self.owner;
        index = level.var_f3d1cde89907a07a ? uavowner.sessionsquadid : self.team;
        
        if ( !isdefined( level.activecounteruavs[ index ] ) )
        {
            level.activecounteruavs[ index ] = 0;
        }
        
        level.activecounteruavs[ index ]++;
    }
    else
    {
        if ( !isdefined( level.activecounteruavs[ self.owner.guid ] ) )
        {
            level.activecounteruavs[ self.owner.guid ] = 0;
        }
        
        level.activecounteruavs[ self.owner.guid ]++;
    }
    
    level.totalactivecounteruavs++;
}

// Namespace uav
// Params 0
// Checksum 0x47ef2094, Offset: 0x4f91
// Size: 0xbd
function function_a76938e065ff08fb()
{
    if ( !isdefined( level.activecounteruavs ) )
    {
        level.activecounteruavs = [];
    }
    
    if ( level.teambased )
    {
        index = level.var_f3d1cde89907a07a ? self.sessionsquadid : self.team;
        
        if ( !isdefined( level.activecounteruavs[ index ] ) )
        {
            level.activecounteruavs[ index ] = 0;
        }
        
        return level.activecounteruavs[ index ];
    }
    
    if ( !isdefined( level.activecounteruavs[ self.guid ] ) )
    {
        level.activecounteruavs[ self.guid ] = 0;
    }
    
    return level.activecounteruavs[ self.guid ];
}

// Namespace uav
// Params 0
// Checksum 0x2a5e5e78, Offset: 0x5056
// Size: 0x48b
function uav_removeactiveuav()
{
    bundle = self.owner killstreak::function_85b2d8e857ab4898( "uav" );
    
    if ( level.teambased )
    {
        uavowner = self.owner;
        index = level.var_f3d1cde89907a07a ? uavowner.sessionsquadid : self.team;
        level.activeuavs[ index ]--;
        level.totalactiveuavs--;
        
        if ( self.var_ef1ac9a3e788655 )
        {
            level.var_d3e0b46ab1c070f8[ index ]--;
            
            for ( i = 0; i < level.var_9f462aa58e87d9c9[ index ].size ; i++ )
            {
                if ( level.var_9f462aa58e87d9c9[ index ][ i ] == self )
                {
                    level.var_9f462aa58e87d9c9[ index ] = arrayremove( level.var_9f462aa58e87d9c9[ index ], self );
                }
            }
        }
        
        if ( self.uavtype == "directional_uav" )
        {
            level.activeadvanceduavs[ index ]--;
            
            for ( i = 0; i < level.var_9f462aa58e87d9c9[ index ].size ; i++ )
            {
                if ( level.var_9f462aa58e87d9c9[ index ][ i ] == self )
                {
                    level.var_9f462aa58e87d9c9[ index ] = arrayremove( level.var_9f462aa58e87d9c9[ index ], self );
                }
            }
            
            level.activeadvanceduavcount--;
        }
        else if ( bundle.var_3d42fe1edbccc0d6 )
        {
            level.var_fb07bbf8c8d257ab[ index ]--;
        }
    }
    else if ( self.owner )
    {
        level.activeuavs[ self.owner.guid ]--;
        level.totalactiveuavs--;
        level.activeuavs[ self.owner.guid + "_radarStrength" ]--;
        
        if ( self.var_ef1ac9a3e788655 )
        {
            level.var_d3e0b46ab1c070f8[ self.owner.guid ]--;
            
            for ( i = 0; i < level.var_9f462aa58e87d9c9[ self.owner.guid ].size ; i++ )
            {
                if ( level.var_9f462aa58e87d9c9[ self.owner.guid ][ i ] == self )
                {
                    level.var_9f462aa58e87d9c9[ self.owner.guid ] = arrayremove( level.var_9f462aa58e87d9c9[ self.owner.guid ], self );
                }
            }
        }
        
        if ( self.uavtype == "directional_uav" )
        {
            level.activeuavs[ self.owner.guid + "_radarStrength" ] = level.activeuavs[ self.owner.guid + "_radarStrength" ] - 2;
            level.activeadvanceduavs[ self.owner.guid ]--;
            
            for ( i = 0; i < level.var_9f462aa58e87d9c9[ self.owner.guid ].size ; i++ )
            {
                if ( level.var_9f462aa58e87d9c9[ self.owner.guid ][ i ] == self )
                {
                    level.var_9f462aa58e87d9c9[ self.owner.guid ] = arrayremove( level.var_9f462aa58e87d9c9[ self.owner.guid ], self );
                }
            }
            
            level.activeadvanceduavcount--;
        }
        else if ( bundle.var_3d42fe1edbccc0d6 )
        {
            level.var_fb07bbf8c8d257ab[ self.owner.guid ]--;
            level.activeuavs[ self.owner.guid + "_radarStrength" ]--;
        }
    }
    
    status_tracking::function_1195d97831be7b57( self.owner, self.var_8cd831a3c0cc9bdc );
    
    if ( level.totalactiveuavs == 0 )
    {
        level callback::remove( #"hash_c0e3f7df1c23e95f", &function_51b3cfc745407c17 );
        level callback::remove( #"hash_d74170bd7751a308", &function_f4db8d988bed2860 );
    }
    
    if ( level.totalactiveuavs == 0 && level.totalactivecounteruavs == 0 )
    {
        level callback::remove( #"player_spawned", &function_2647ff449e2c45bf );
    }
}

// Namespace uav
// Params 0
// Checksum 0x3721bcb1, Offset: 0x54e9
// Size: 0x10c
function uav_removeactivecounteruav()
{
    if ( self.owner && ( self.var_8cd831a3c0cc9bdc ?? -1 ) >= 0 )
    {
        status_tracking::function_1195d97831be7b57( self.owner, self.var_8cd831a3c0cc9bdc );
    }
    
    if ( level.teambased )
    {
        uavowner = self.owner;
        index = level.var_f3d1cde89907a07a ? uavowner.sessionsquadid : self.team;
        level.activecounteruavs[ index ]--;
    }
    else if ( self.owner )
    {
        level.activecounteruavs[ self.owner.guid ]--;
    }
    
    level.totalactivecounteruavs--;
    
    if ( level.totalactiveuavs == 0 && level.totalactivecounteruavs == 0 )
    {
        level callback::remove( #"player_spawned", &function_2647ff449e2c45bf );
    }
    
    level notify( #"uav_update" );
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0xe4e6a859, Offset: 0x55fd
// Size: 0x41
function private tracker()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"uav_update" );
        
        if ( level.teambased )
        {
            level thread function_134d144dd839db66();
            continue;
        }
        
        function_694d4355ee180f9d();
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x9290d09a, Offset: 0x5646
// Size: 0x217
function private function_134d144dd839db66()
{
    level endon( #"uav_update" );
    function_c02c9841aed89b44();
    var_16127f01df45d98e = getdvarfloat( @"hash_6f6baff42f9ff3eb", 0.4 );
    var_8bd503e01e034767 = max( int( ceil( var_16127f01df45d98e / level.framedurationseconds ) ), 1 );
    var_b3be564d71cf9d9f = level.var_f610813555ee6af6 ?? 5000;
    var_d4ed8bdceb1fa5bd = var_b3be564d71cf9d9f / var_8bd503e01e034767;
    var_4665a8c5e299d1ab = 0;
    framesused = 1;
    var_59846ff71c742424 = getsystemtimeinmicroseconds();
    var_b5b53be81069fab9 = 0;
    var_c60ad076e137a864 = 0;
    
    foreach ( team in level.teamnamelist )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            if ( level.squaddata )
            {
                foreach ( squadindex, squadarray in level.squaddata[ team ] )
                {
                    function_e2ed0dc39a0d8d25( team, squadindex );
                }
            }
        }
        else
        {
            uav_setteamradarstrength( team );
        }
        
        var_b5b53be81069fab9++;
        var_c60ad076e137a864 = getsystemtimeinmicroseconds() - var_59846ff71c742424;
        
        if ( var_b5b53be81069fab9 >= 20 || var_b5b53be81069fab9 >= 2 && var_c60ad076e137a864 >= var_d4ed8bdceb1fa5bd && framesused < var_8bd503e01e034767 )
        {
            waitframe();
            var_59846ff71c742424 = getsystemtimeinmicroseconds();
            framesused++;
            var_b5b53be81069fab9 = 0;
            var_4665a8c5e299d1ab += var_c60ad076e137a864;
        }
    }
    
    var_4665a8c5e299d1ab += var_c60ad076e137a864;
    level.var_f610813555ee6af6 = var_4665a8c5e299d1ab;
}

// Namespace uav
// Params 1
// Checksum 0xbd956d1e, Offset: 0x5865
// Size: 0xaf
function function_c6b46bde3b7bc0a1( team )
{
    if ( level.var_81a26fda60d43a9a )
    {
        return level.var_81a26fda60d43a9a;
    }
    
    activeuavs = level.activeuavs[ team ] ?? 0;
    var_bfd80b9411782d = level.activeadvanceduavs[ team ] ?? 0;
    activecounteruavs = int( max( 0, ( level.totalactivecounteruavs ?? 0 ) - ( level.activecounteruavs[ team ] ?? 0 ) ) );
    var_fb07bbf8c8d257ab = level.var_fb07bbf8c8d257ab[ team ] ?? 0;
    return function_e8e56ccc019a1af3( activeuavs, var_bfd80b9411782d, activecounteruavs, var_fb07bbf8c8d257ab );
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x4c4e85b6, Offset: 0x591d
// Size: 0xc4
function private function_c797d43622f72e29( team, squadindex )
{
    if ( level.var_81a26fda60d43a9a )
    {
        return level.var_81a26fda60d43a9a;
    }
    
    index = squadindex;
    activeuavs = level.activeuavs[ index ] ?? 0;
    var_bfd80b9411782d = level.activeadvanceduavs[ index ] ?? 0;
    activecounteruavs = int( max( 0, ( level.totalactivecounteruavs ?? 0 ) - ( level.activecounteruavs[ index ] ?? 0 ) ) );
    var_fb07bbf8c8d257ab = level.var_fb07bbf8c8d257ab[ index ] ?? 0;
    return function_e8e56ccc019a1af3( activeuavs, var_bfd80b9411782d, activecounteruavs, var_fb07bbf8c8d257ab );
}

// Namespace uav
// Params 4, eflags: 0x4
// Checksum 0x602a21d8, Offset: 0x59ea
// Size: 0x1eb
function private function_e8e56ccc019a1af3( activeuavs, var_bfd80b9411782d, activecounteruavs, var_fb07bbf8c8d257ab )
{
    /#
        uavowner = undefined;
        
        foreach ( player in level.players )
        {
            if ( player )
            {
                uavowner = player;
                break;
            }
        }
        
        if ( uavowner.var_640ea62fa70ae194 )
        {
            activecounteruavs = 1;
        }
    #/
    
    if ( var_bfd80b9411782d )
    {
        activeuavs = level.uavbestid - level.uavnoneid;
    }
    
    if ( isbrgamemode() )
    {
        radarstrength = int( clamp( activeuavs + level.uavnoneid, level.uavnoneid, level.uavdirectionalid ) );
    }
    else if ( activecounteruavs > 0 )
    {
        radarstrength = level.uavworstid;
    }
    else if ( var_bfd80b9411782d > 0 )
    {
        radarstrength = level.uavbestid;
    }
    else
    {
        radarstrength = int( clamp( activeuavs + level.uavnoneid, level.uavnoneid, level.uavfastsweepid ) );
        
        if ( var_fb07bbf8c8d257ab > 0 )
        {
            radarstrength = level.uavfastsweepid;
        }
        
        bundle = level killstreak::function_85b2d8e857ab4898( "uav" );
        
        if ( bundle.var_820403b8301aab34 )
        {
            var_f03a5695f96c1c9c = bundle.var_afc1623f542dc4f6 ?? 3;
            
            if ( activeuavs >= var_f03a5695f96c1c9c )
            {
                radarstrength = level.uavbestid;
            }
        }
    }
    
    radarstrength = int( clamp( radarstrength, level.uavworstid, level.uavbestid ) );
    return radarstrength;
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x8bd1bd51, Offset: 0x5bde
// Size: 0x12d
function private function_500c5d4157b4639e( radarstrength, var_a3e3acd7517ccc35 )
{
    isradarblocked = radarstrength == level.uavworstid;
    hasradar = !isradarblocked;
    radarshowenemydirection = radarstrength >= level.uavdirectionalid;
    showconstant = radarstrength >= level.uavbestid || radarshowenemydirection || radarstrength == 1;
    
    if ( radarstrength == level.uavnoneid )
    {
        radarmode = "normal_radar";
        hasradar = 0;
    }
    else if ( showconstant )
    {
        radarmode = "constant_radar";
    }
    else if ( radarstrength == level.uavfastsweepid || var_a3e3acd7517ccc35 && level.var_75ae6e7989da9fb7 == 1 )
    {
        radarmode = "fast_radar";
    }
    else
    {
        radarmode = "normal_radar";
    }
    
    radardata = { #var_a3e3acd7517ccc35:var_a3e3acd7517ccc35, #radarmode:radarmode, #radarshowenemydirection:radarshowenemydirection, #hasradar:hasradar, #isradarblocked:isradarblocked, #radarstrength:radarstrength };
    return radardata;
}

// Namespace uav
// Params 3, eflags: 0x4
// Checksum 0x6adeeec5, Offset: 0x5d14
// Size: 0x6b
function private function_206dfd7d11f25b50( team, squadindex, override )
{
    radarstrength = override ?? function_c797d43622f72e29( team, squadindex );
    var_a3e3acd7517ccc35 = isbrgamemode() && level.var_d3e0b46ab1c070f8[ squadindex ];
    radardata = function_500c5d4157b4639e( radarstrength, var_a3e3acd7517ccc35 );
    return radardata;
}

// Namespace uav
// Params 2
// Checksum 0x62fd5c90, Offset: 0x5d88
// Size: 0x61
function function_ce7678b7924e8588( team, override )
{
    radarstrength = override ?? function_c6b46bde3b7bc0a1( team );
    var_a3e3acd7517ccc35 = isbrgamemode() && level.var_d3e0b46ab1c070f8[ team ];
    radardata = function_500c5d4157b4639e( radarstrength, var_a3e3acd7517ccc35 );
    return radardata;
}

// Namespace uav
// Params 2
// Checksum 0x4b980ab6, Offset: 0x5df2
// Size: 0x21
function uav_setteamradarstrength( team, var_721dd47f5c82b12f )
{
    function_893158361a8307c0( team, undefined, var_721dd47f5c82b12f );
}

// Namespace uav
// Params 3, eflags: 0x4
// Checksum 0xcd06d315, Offset: 0x5e1b
// Size: 0x29
function private function_e2ed0dc39a0d8d25( team, squadindex, var_721dd47f5c82b12f )
{
    function_893158361a8307c0( team, squadindex, var_721dd47f5c82b12f );
}

// Namespace uav
// Params 3, eflags: 0x4
// Checksum 0x7e6d2926, Offset: 0x5e4c
// Size: 0x159
function private function_893158361a8307c0( team, squadindex, var_721dd47f5c82b12f )
{
    players = isdefined( squadindex ) ? level.squaddata[ team ][ squadindex ].players : teams::getteamdata( team, "players" );
    var_c7e6a670aa68257f = isdefined( squadindex ) ? function_206dfd7d11f25b50( team, squadindex, var_721dd47f5c82b12f ) : function_ce7678b7924e8588( team, var_721dd47f5c82b12f );
    var_9274980250d60c27 = level.sharedfuncs[ #"jamming_system" ][ #"hash_23b4b2c8dfb75cde" ];
    
    foreach ( player in players )
    {
        if ( player.insidecuavbunker )
        {
            continue;
        }
        
        if ( player.skipuavupdate )
        {
            continue;
        }
        
        if ( var_9274980250d60c27 && player [[ var_9274980250d60c27 ]]() )
        {
            continue;
        }
        
        playerradar = structcopy( var_c7e6a670aa68257f );
        function_1d490f49c4dc99a9( player, playerradar );
    }
}

// Namespace uav
// Params 2
// Checksum 0x42ddc2b5, Offset: 0x5fad
// Size: 0x2f3
function function_1d490f49c4dc99a9( player, radardata )
{
    if ( player.var_7d3a7700e8272b44 )
    {
        radardata.radarstrength = level.uavworstid;
        radardata.isradarblocked = 1;
        radardata.hasradar = 0;
    }
    
    if ( isdefined( player.perks[ "specialty_perceptive" ] ) )
    {
        var_4c49d70cb8b07d56 = level.uavnoneid;
        
        if ( radardata.radarstrength < var_4c49d70cb8b07d56 )
        {
            index = player.guid;
            
            if ( level.teambased )
            {
                index = level.var_f3d1cde89907a07a ? player.sessionsquadid : player.pers[ "team" ];
            }
            
            var_cd1fd7efa3ccd9a6 = var_4c49d70cb8b07d56;
            
            if ( level.activeadvanceduavs[ index ] > 0 )
            {
                var_cd1fd7efa3ccd9a6 = level.uavdirectionalid;
            }
            else if ( level.var_fb07bbf8c8d257ab[ index ] > 0 )
            {
                var_cd1fd7efa3ccd9a6 = level.uavfastsweepid;
            }
            else if ( level.activeuavs[ index ] > 0 )
            {
                var_cd1fd7efa3ccd9a6 = var_4c49d70cb8b07d56 + 1;
            }
            
            radardata = function_500c5d4157b4639e( var_cd1fd7efa3ccd9a6, radardata.var_a3e3acd7517ccc35 );
        }
    }
    
    player.radarstrength = radardata.radarstrength;
    player.isradarblocked = radardata.isradarblocked;
    player.hasradar = radardata.hasradar;
    player.radarshowenemydirection = radardata.radarshowenemydirection;
    player.radarmode = radardata.radarmode;
    
    if ( player isscriptable() )
    {
        if ( player.radarstrength < level.uavnoneid )
        {
            if ( player getscriptablehaspart( #"cuav_scramble_sfx" ) )
            {
                player setscriptablepartstate( #"cuav_scramble_sfx", #"on", 0 );
            }
        }
        else if ( player getscriptablehaspart( #"cuav_scramble_sfx" ) )
        {
            player setscriptablepartstate( #"cuav_scramble_sfx", #"off", 0 );
        }
    }
    
    player setclientomnvar( o"ui_radar_blocked", !player.hasradar );
    
    if ( isbrgamemode() )
    {
        if ( radardata.var_a3e3acd7517ccc35 || isdefined( player.perks[ "specialty_pc_comms" ] ) )
        {
            player.radarshowenemydirection = 1;
        }
    }
    
    if ( isdefined( player.perks[ "specialty_overwatch" ] ) )
    {
        player.radarshowenemydirection = 1;
    }
    
    var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
    
    if ( var_ec86cf09b79859c3 )
    {
        level [[ var_ec86cf09b79859c3 ]]( [ player ] );
    }
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0xa109842b, Offset: 0x62a8
// Size: 0xe5
function private blockradar( team, override )
{
    if ( level.var_f3d1cde89907a07a )
    {
        teamplayers = level.squaddata[ team ][ self.sessionsquadid ].players;
    }
    else
    {
        teamplayers = teams::getteamdata( team, "players" );
    }
    
    foreach ( player in teamplayers )
    {
        player.hasradar = 0;
        player setclientomnvar( o"ui_radar_blocked", 1 );
    }
}

// Namespace uav
// Params 2, eflags: 0x4
// Checksum 0x70083185, Offset: 0x6395
// Size: 0xe5
function private function_5122edb52319dece( team, override )
{
    if ( level.var_f3d1cde89907a07a )
    {
        teamplayers = level.squaddata[ team ][ self.sessionsquadid ].players;
    }
    else
    {
        teamplayers = teams::getteamdata( team, "players" );
    }
    
    foreach ( player in teamplayers )
    {
        player.hasradar = 1;
        player setclientomnvar( o"ui_radar_blocked", 0 );
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x2fdabe07, Offset: 0x6482
// Size: 0x33b
function private function_694d4355ee180f9d()
{
    foreach ( player in level.players )
    {
        if ( player.insidecuavbunker )
        {
            continue;
        }
        
        radarstrength = level.activeuavs[ player.guid + "_radarStrength" ] ?? level.uavnoneid;
        activecounteruavs = player function_a76938e065ff08fb();
        var_c6c5b3e536c9b66b = ( level.totalactivecounteruavs ?? 0 ) - activecounteruavs;
        
        /#
            if ( player.var_640ea62fa70ae194 )
            {
                var_c6c5b3e536c9b66b = 1;
            }
        #/
        
        if ( var_c6c5b3e536c9b66b > 0 && !isdefined( player.perks[ "specialty_perceptive" ] ) )
        {
            radarstrength = level.uavworstid;
        }
        
        radarstrength = int( max( min( radarstrength, level.uavbestid ), level.uavworstid ) );
        player.radarstrength = radarstrength;
        var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
        
        if ( var_ec86cf09b79859c3 )
        {
            level [[ var_ec86cf09b79859c3 ]]( [ player ] );
        }
        
        teamhidden = player.team == "spectator" || player.team == "codcaster" || player.team == "free";
        
        if ( radarstrength <= level.uavnoneid || teamhidden )
        {
            player.hasradar = 0;
            player.radarshowenemydirection = 0;
            player setclientomnvar( o"ui_radar_blocked", !player.hasradar );
            
            if ( player.radarmode == "constant_radar" && player.radarstrength != 1 )
            {
                player.radarmode = "normal_radar";
            }
            
            continue;
        }
        
        if ( radarstrength >= level.uavfastsweepid )
        {
            player.radarmode = "fast_radar";
        }
        else if ( radarstrength == 1 )
        {
            player.radarmode = "constant_radar";
        }
        else
        {
            player.radarmode = "normal_radar";
        }
        
        player.radarshowenemydirection = radarstrength >= level.uavdirectionalid;
        
        if ( player.radarshowenemydirection )
        {
            player.radarmode = "constant_radar";
        }
        
        player.hasradar = 1;
        player setclientomnvar( o"ui_radar_blocked", !player.hasradar );
        
        if ( isdefined( player.perks[ "specialty_overwatch" ] ) || isdefined( player.perks[ "specialty_pc_comms" ] ) )
        {
            player.radarshowenemydirection = 1;
        }
    }
}

// Namespace uav
// Params 3
// Checksum 0xc5b12841, Offset: 0x67c5
// Size: 0x36a
function function_76ded778d105259d( player, waittime, var_9cb4fde69f96149e )
{
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    forceradarstrength = var_9cb4fde69f96149e ?? getmatchrulesdata( "commonOption", "radarAlwaysOn" );
    radartype = "normal_radar";
    activeuav = 1;
    activeadvanceduavs = 0;
    
    switch ( forceradarstrength )
    {
        case 1:
            radartype = "constant_radar";
            break;
        case 3:
            radartype = "normal_radar";
            break;
        case 5:
            radartype = "fast_radar";
            activeuav = 2;
            break;
        case 6:
            radartype = "constant_radar";
            activeadvanceduavs = 1;
            break;
        default:
            break;
    }
    
    if ( level.teambased )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            var_84c2a35e4892ee85 = 0;
            
            foreach ( team in level.teamnamelist )
            {
                foreach ( squadindex in level.squaddata[ team ] )
                {
                    index = squadindex;
                    level.radarmode[ index ] = radartype;
                    level.activeuavs[ index ] = activeuav;
                    level.activeadvanceduavs[ index ] = activeadvanceduavs;
                    var_84c2a35e4892ee85++;
                    function_e2ed0dc39a0d8d25( squadindex, forceradarstrength );
                }
            }
            
            level.activeadvanceduavcount = var_84c2a35e4892ee85;
        }
        else
        {
            foreach ( entry in level.teamnamelist )
            {
                level.radarmode[ entry ] = radartype;
                level.activeuavs[ entry ] = activeuav;
                level.activeadvanceduavs[ entry ] = activeadvanceduavs;
                level.activeadvanceduavcount = level.teamnamelist.size;
                uav_setteamradarstrength( entry, forceradarstrength );
            }
        }
        
        return;
    }
    
    activeuav = forceradarstrength;
    level.radarmode[ player.guid ] = radartype;
    player.radarstrength = activeuav;
    level.activeuavs[ player.guid + "_radarStrength" ] = activeuav;
    level.activeadvanceduavs[ player.guid ] = activeadvanceduavs;
    level.activeadvanceduavcount = level.teamnamelist.size;
    function_694d4355ee180f9d();
}

// Namespace uav
// Params 1
// Checksum 0xe6821208, Offset: 0x6b37
// Size: 0xa6
function function_bb7953c7f773188e( sweeptime )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.players )
        {
            foreach ( player in level.players )
            {
                triggeroneoffradarsweep( player );
            }
        }
        
        wait sweeptime;
    }
}

// Namespace uav
// Params 0
// Checksum 0x24fb219, Offset: 0x6be5
// Size: 0xd6
function function_2701d7fa650db090()
{
    if ( function_c6b46bde3b7bc0a1( self.team ) > level.uavworstid )
    {
        self.skipuavupdate = 1;
        self.radarstrength = level.uavnoneid + 1;
        self.isradarblocked = 0;
        self.hasradar = 1;
        self.radarshowenemydirection = 1;
        self.radarmode = "constant_radar";
        var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
        
        if ( var_ec86cf09b79859c3 )
        {
            level [[ var_ec86cf09b79859c3 ]]( [ self ] );
        }
        
        return;
    }
    
    self.skipuavupdate = 0;
    radardata = function_ce7678b7924e8588( self.team );
    function_1d490f49c4dc99a9( self, radardata );
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x3a4ac5ed, Offset: 0x6cc3
// Size: 0x194
function private function_e617acf4bd6dbeff( uav )
{
    if ( !player_utility::playersareenemies( uav.owner, self ) )
    {
        return;
    }
    
    if ( !player::isreallyalive() )
    {
        return;
    }
    
    if ( uav.uavtype == "uav" && isdefined( self.var_2bee526696230275[ #"ghost_active" ] ) )
    {
        return;
    }
    
    if ( uav.uavtype == "directional_uav" && isdefined( self.var_2bee526696230275[ #"hash_869fbc9948ce756a" ] ) )
    {
        return;
    }
    
    if ( uav.uavtype == "counter_uav" && isdefined( self.perks[ "specialty_perceptive" ] ) )
    {
        return;
    }
    
    if ( isdefined( level.var_38f84e6d5f274bb.statustracker[ self.guid ][ uav.owner.guid ][ uav.var_8cd831a3c0cc9bdc ] ) )
    {
        return;
    }
    
    statustype = #"uav_detected";
    
    if ( uav.uavtype == "directional_uav" )
    {
        statustype = #"harp_detected";
    }
    else if ( uav.uavtype == "counter_uav" )
    {
        statustype = #"cuav_scrambled";
    }
    
    status_tracking::applystatus( self, uav.owner, uav.var_8cd831a3c0cc9bdc, statustype, { #supportscoreevent:uav.streakinfo.bundle.supportscoreevent } );
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0xede91f0e, Offset: 0x6e5f
// Size: 0x232
function private function_2647ff449e2c45bf( params )
{
    player = params.player;
    
    if ( !player )
    {
        return;
    }
    
    if ( level.teambased )
    {
        foreach ( var_dabf6b6b6cfccf85 in level.uavmodels )
        {
            foreach ( uav in var_dabf6b6b6cfccf85 )
            {
                if ( ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" || uav.uavtype == "counter_uav" ) && player_utility::playersareenemies( uav.owner, player ) )
                {
                    player function_e617acf4bd6dbeff( uav );
                }
            }
        }
        
        return;
    }
    
    foreach ( uav in level.uavmodels )
    {
        if ( ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" || uav.uavtype == "counter_uav" ) && player_utility::playersareenemies( uav.owner, player ) )
        {
            player function_e617acf4bd6dbeff( uav );
        }
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0xc144f1c6, Offset: 0x7099
// Size: 0x2ae
function private function_51b3cfc745407c17( params )
{
    player = params.player;
    
    if ( !player )
    {
        return;
    }
    
    if ( level.teambased )
    {
        foreach ( var_dabf6b6b6cfccf85 in level.uavmodels )
        {
            foreach ( uav in var_dabf6b6b6cfccf85 )
            {
                if ( !player_utility::playersareenemies( uav.owner, player ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "uav" )
                {
                    status_tracking::function_758095091e5512be( player, uav.owner, uav.var_8cd831a3c0cc9bdc );
                    continue;
                }
                
                if ( uav.uavtype == "directional_uav" && isdefined( player.var_2bee526696230275[ #"hash_869fbc9948ce756a" ] ) )
                {
                    status_tracking::function_758095091e5512be( player, uav.owner, uav.var_8cd831a3c0cc9bdc );
                }
            }
        }
        
        return;
    }
    
    foreach ( uav in level.uavmodels )
    {
        if ( !player_utility::playersareenemies( uav.owner, player ) )
        {
            continue;
        }
        
        if ( uav.uavtype == "uav" )
        {
            status_tracking::function_758095091e5512be( player, uav.owner, uav.var_8cd831a3c0cc9bdc );
            continue;
        }
        
        if ( uav.uavtype == "directional_uav" && isdefined( player.var_2bee526696230275[ #"hash_869fbc9948ce756a" ] ) )
        {
            status_tracking::function_758095091e5512be( player, uav.owner, uav.var_8cd831a3c0cc9bdc );
        }
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x3da38039, Offset: 0x734f
// Size: 0x25c
function private function_f4db8d988bed2860( params )
{
    player = params.player;
    
    if ( !player )
    {
        return;
    }
    
    if ( level.teambased )
    {
        foreach ( var_dabf6b6b6cfccf85 in level.uavmodels )
        {
            foreach ( uav in var_dabf6b6b6cfccf85 )
            {
                if ( !player_utility::playersareenemies( uav.owner, player ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "uav" )
                {
                    player function_e617acf4bd6dbeff( uav );
                    continue;
                }
                
                if ( uav.uavtype == "directional_uav" && !isdefined( player.var_2bee526696230275[ #"hash_869fbc9948ce756a" ] ) )
                {
                    player function_e617acf4bd6dbeff( uav );
                }
            }
        }
        
        return;
    }
    
    foreach ( uav in level.uavmodels )
    {
        if ( !player_utility::playersareenemies( uav.owner, player ) )
        {
            continue;
        }
        
        if ( uav.uavtype == "uav" )
        {
            player function_e617acf4bd6dbeff( uav );
            continue;
        }
        
        if ( uav.uavtype == "directional_uav" && !isdefined( player.var_2bee526696230275[ #"hash_869fbc9948ce756a" ] ) )
        {
            player function_e617acf4bd6dbeff( uav );
        }
    }
}

// Namespace uav
// Params 1
// Checksum 0x285890a0, Offset: 0x75b3
// Size: 0x204
function function_48f6c3c47f835e04( victim )
{
    detectioninfo = {};
    var_aaf1b8592d03e0cc = victim isplayerghost();
    var_d82536d629927485 = 0;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_f3a152be2dbc14b9" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_d82536d629927485 = victim [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        var_d82536d629927485 = 0;
    }
    
    var_518800c9f09fd200 = var_aaf1b8592d03e0cc || var_d82536d629927485;
    var_c565d05564198d0d = isdefined( victim.perks[ "specialty_perceptive" ] );
    
    if ( level.teambased )
    {
        foreach ( var_dabf6b6b6cfccf85 in level.uavmodels )
        {
            foreach ( uav in var_dabf6b6b6cfccf85 )
            {
                function_18669e88337384cb( uav, victim, var_518800c9f09fd200, var_c565d05564198d0d, detectioninfo );
            }
        }
    }
    else
    {
        foreach ( uav in level.uavmodels )
        {
            function_18669e88337384cb( uav, victim, var_518800c9f09fd200, var_c565d05564198d0d, detectioninfo );
        }
    }
    
    return detectioninfo;
}

// Namespace uav
// Params 5, eflags: 0x4
// Checksum 0xd171231f, Offset: 0x77c0
// Size: 0x163
function private function_18669e88337384cb( uav, victim, var_518800c9f09fd200, var_c565d05564198d0d, var_930e7079088e284e = {} )
{
    if ( !uav.owner )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( uav.owner, victim ) )
    {
        return;
    }
    
    if ( !var_518800c9f09fd200 )
    {
        if ( uav.uavtype == "uav" )
        {
            var_930e7079088e284e.var_2346079f5ac9d337 = 1;
            
            if ( !isdefined( var_930e7079088e284e.var_1bdaf6fcb3cd5db5 ) )
            {
                var_930e7079088e284e.var_1bdaf6fcb3cd5db5 = uav.streakinfo.streakname;
            }
        }
        else if ( uav.uavtype == "directional_uav" )
        {
            var_930e7079088e284e.var_12767a1b38aa5cfd = 1;
            
            if ( !isdefined( var_930e7079088e284e.var_93d3341a759026a5 ) )
            {
                var_930e7079088e284e.var_93d3341a759026a5 = uav.streakinfo.streakname;
            }
        }
    }
    
    if ( !var_c565d05564198d0d && uav.uavtype == "counter_uav" )
    {
        var_930e7079088e284e.var_46e10151815ffaaa = 1;
        
        if ( !isdefined( var_930e7079088e284e.var_a6a18268a321061b ) )
        {
            var_930e7079088e284e.var_a6a18268a321061b = uav.streakinfo.streakname;
        }
    }
}

// Namespace uav
// Params 1, eflags: 0x4
// Checksum 0x6032fe8c, Offset: 0x792b
// Size: 0x136
function private function_4196eb1034a20774( reveal )
{
    assert( isdefined( reveal ), "<dev string:x78>" );
    players = [ self.owner ];
    
    if ( level.teambased )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            players = level.squaddata[ self.team ][ self.owner.sessionsquadid ].players;
        }
        else
        {
            players = teams::getteamdata( self.team, "players" );
        }
    }
    
    foreach ( player in players )
    {
        if ( isai( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( reveal )
        {
            player player::showminimap();
            continue;
        }
        
        player player::hideminimap();
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x4bc3b0be, Offset: 0x7a69
// Size: 0x10c
function private function_72fa1998c7269e35()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    
    if ( level.istacops )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( isai( player ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( level.var_f3d1cde89907a07a )
            {
                if ( self.owner.sessionsquadid != player.sessionsquadid )
                {
                    continue;
                }
            }
            else if ( self.team != player.pers[ "team" ] )
            {
                continue;
            }
        }
        
        if ( !level.teambased && self.owner != player )
        {
            continue;
        }
        
        player player::showminimap();
        player.showuavminimaponspawn = 1;
    }
}

// Namespace uav
// Params 0, eflags: 0x4
// Checksum 0x53609455, Offset: 0x7b7d
// Size: 0x1b9
function private perkengineermanageminimap()
{
    self.owner endon( #"disconnect" );
    self endon( #"uav_deleteobjective" );
    self endon( #"death" );
    
    switch ( self.uavtype )
    {
        case #"hash_634b246c3da5c56f":
            enemyicon = "hud_icon_minimap_killstreak_uav";
            break;
        case #"hash_10e585c25e7e9f60":
            enemyicon = "hud_icon_minimap_killstreak_cuav";
            break;
        case #"hash_e171e5b86ef0a4cc":
            enemyicon = "hud_icon_minimap_killstreak_auav";
            break;
        default:
            enemyicon = "hud_icon_minimap_killstreak_uav";
            break;
    }
    
    createfunc = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjectiveengineer" ) )
    {
        createfunc = utility::getsharedfunc( #"game", #"createobjectiveengineer" );
    }
    
    if ( createfunc )
    {
        self.enemyobjid = self [[ createfunc ]]( enemyicon, 1, 1 );
    }
    
    var_53491393a2eed683 = 0;
    
    while ( true )
    {
        for ( i = 0; i < 10 ; i++ )
        {
            if ( var_53491393a2eed683 >= level.players.size )
            {
                var_53491393a2eed683 = 0;
            }
            
            player = level.players[ var_53491393a2eed683 ];
            var_53491393a2eed683++;
            
            if ( !player )
            {
                continue;
            }
            
            if ( self.enemyobjid != -1 )
            {
                if ( isdefined( player.perks[ "specialty_engineer" ] ) && player_utility::playersareenemies( player, self.owner ) )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( self.enemyobjid, player );
                    continue;
                }
                
                objidpoolmanager::objective_playermask_hidefrom( self.enemyobjid, player );
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace uav
    // Params 0, eflags: 0x4
    // Checksum 0x16b0c5c, Offset: 0x7d3e
    // Size: 0x80, Type: dev
    function private debugbreadcrumbs()
    {
        self endon( #"death" );
        wait 1;
        prevorigin = self.origin;
        
        while ( true )
        {
            sphere( self.origin, 100, ( 1, 0, 0 ), 0, 1 );
            line( self.origin, prevorigin, ( 1, 0, 0 ), 1, 0, 500 );
            prevorigin = self.origin;
            waitframe();
        }
    }

    // Namespace uav
    // Params 0, eflags: 0x4
    // Checksum 0xe6128cb9, Offset: 0x7dc6
    // Size: 0x278, Type: dev
    function private debuglocation()
    {
        self endon( #"death" );
        
        while ( true )
        {
            foreach ( rig in level.uavrigs )
            {
                print3d( self.origin, "<dev string:xb0>", ( 1, 0, 0 ) );
                print3d( self.origin, "<dev string:xb4>" + self.origin[ 0 ] + "<dev string:xc1>" + self.origin[ 1 ] + "<dev string:xc1>" + self.origin[ 2 ], ( 1, 0, 0 ) );
                print3d( rig.origin, "<dev string:xc4>", ( 1, 0, 0 ) );
                print3d( rig.origin, "<dev string:xcc>" + rig.origin[ 0 ] + "<dev string:xc1>" + rig.origin[ 1 ] + "<dev string:xc1>" + rig.origin[ 2 ], ( 1, 0, 0 ) );
                print3d( rig.origin - ( 0, 0, 50 ), "<dev string:xdd>" + distance( rig.origin, self.origin ), ( 1, 0, 0 ) );
                line( rig.origin, self.origin, ( 0, 0, 1 ) );
                anglesforward = anglestoforward( level.players[ 0 ].angles );
                scalar = ( anglesforward[ 0 ] * 200, anglesforward[ 1 ] * 200, anglesforward[ 2 ] );
                print3d( level.players[ 0 ].origin + scalar, "<dev string:xdd>" + distance( level.players[ 0 ].origin, self.origin ), ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace uav
    // Params 0, eflags: 0x4
    // Checksum 0xf9deace7, Offset: 0x8046
    // Size: 0x6d, Type: dev
    function private debugtrace()
    {
        self endon( #"death" );
        
        while ( true )
        {
            result = trace::_bullet_trace( level.players[ 0 ].origin, self.origin, 0, undefined );
            
            if ( result[ "<dev string:xe8>" ] )
            {
                println( "<dev string:xf4>" + result[ "<dev string:xe8>" ] );
            }
            
            wait 1;
        }
    }

#/
