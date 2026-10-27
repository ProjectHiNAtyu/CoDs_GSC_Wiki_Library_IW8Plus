// scripts\mp\common\utility\killstreak_utility.gsc  (hash_56e2519a4d33f9a2.gscc) (size: 69163 Bytes / 0x10e2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a326422 (707945506)
// size ...... 69163 (0x10e2b)
// includes .. 39  (offset: 0x102f7)
// strings ... 154 (offset: 0x1042f)
// dev strs .. 25  (offset: 0x10cfb)
// exports ... 214 (offset: 0xb26b)
// cseg ...... 0xe73 + 0xa3f8 (0xb26b)
// imports ... 377 (offset: 0xd3db)
// animtree1 . 0   (offset: 0x10e2b)
// animtree2 . 0   (offset: 0x10e2b)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\elevator;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;

#namespace killstreak_utility;

// Namespace killstreak_utility
// Params 2
// Checksum 0x71bb27a5, Offset: 0xe91
// Size: 0x1ae
function createstreakinfo( streakname, owner )
{
    streakinfo = { #destructions:0, #debuffassists:0, #debuffkills:0, #RESTOCKS:0, #grenadekills:0, #kills:0, #damage:0, #hits:0, #shots_fired:0, #score:0, #owner:owner, #streakname:streakname };
    
    if ( isdefined( owner ) )
    {
        streakinfo.id = getuniquekillstreakid( owner );
        streakinfo.lifeid = owner getcurrentplayerlifeidforkillstreak();
        streakinfo.team = owner.team;
        streakinfo.bundle = owner killstreak::function_85b2d8e857ab4898( streakname );
    }
    else
    {
        streakinfo.id = 0;
        streakinfo.lifeid = 0;
        streakinfo.bundle = level killstreak::function_85b2d8e857ab4898( streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"createcustomstreakdata" ) )
    {
        streakinfo = [[ utility::getsharedfunc( #"killstreak", #"createcustomstreakdata" ) ]]( streakinfo, streakname );
    }
    
    if ( isdefined( streakname ) && isdefined( level.streakglobals ) )
    {
        streakinfo.streakindex = level.streakglobals.var_9e0ca257f60b78aa[ streakname ] ?? -1;
    }
    else
    {
        streakinfo.streakindex = 0;
    }
    
    return streakinfo;
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x2e64ab7e, Offset: 0x1048
// Size: 0xa2
function function_b555369eba6b0252( damagestate, damageamount, damagestatefunc )
{
    if ( !isdefined( self.damagestates ) )
    {
        self.damagestates = [];
        self.currentdamagestate = 0;
    }
    
    if ( isdefined( self.damagestates[ damagestate ] ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    self.damagestates[ damagestate ] = spawnstruct();
    self.damagestates[ damagestate ].damageamount = damageamount;
    self.damagestates[ damagestate ].damagestatefunc = damagestatefunc;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x2757dd58, Offset: 0x10f2
// Size: 0x197
function killstreak_updatedamagestate( currenthealth, playdialog )
{
    damagestate = undefined;
    states = self.damagestates;
    damagedialog = undefined;
    
    if ( isdefined( states ) )
    {
        if ( currenthealth <= states[ 3 ].damageamount )
        {
            if ( self.currentdamagestate != 3 )
            {
                damagestate = 3;
                damagedialog = #"damage_heavy";
            }
        }
        else if ( currenthealth <= states[ 2 ].damageamount )
        {
            if ( self.currentdamagestate != 2 )
            {
                damagestate = 2;
                damagedialog = #"damage_medium";
            }
        }
        else if ( currenthealth <= states[ 1 ].damageamount )
        {
            if ( self.currentdamagestate != 1 )
            {
                damagestate = 1;
                damagedialog = #"damage_light";
            }
        }
    }
    
    if ( isdefined( damagestate ) )
    {
        if ( isdefined( self.owner ) && self.ispiloted )
        {
            self.owner setclientomnvar( "ui_killstreak_damage_state", damagestate );
        }
        
        self [[ states[ damagestate ].damagestatefunc ]]();
        self.currentdamagestate = damagestate;
    }
    
    if ( isdefined( damagedialog ) && playdialog )
    {
        self.owner playkillstreaktacomdialog( self.streakinfo, undefined, damagedialog, 1 );
    }
    
    if ( isdefined( self.owner ) && self.ispiloted )
    {
        self.owner setclientomnvar( "ui_killstreak_health", currenthealth / self.maxhealth );
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x24f651f1, Offset: 0x1291
// Size: 0x64
function getuniquekillstreakid( player )
{
    if ( !isdefined( player.pers[ "nextKillstreakID" ] ) )
    {
        player.pers[ "nextKillstreakID" ] = 0;
    }
    
    uniqueid = player.pers[ "nextKillstreakID" ];
    player.pers[ "nextKillstreakID" ]++;
    return uniqueid;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x263ea2f5, Offset: 0x12fe
// Size: 0x27
function getcurrentplayerlifeidforkillstreak()
{
    if ( !isdefined( self.pers[ "deaths" ] ) )
    {
        return 0;
    }
    
    return self.pers[ "deaths" ];
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x8f4c56e2, Offset: 0x132e
// Size: 0x88
function killstreak_setmainvision( visionsetname )
{
    if ( visionsetname == "" )
    {
        self visionsetthermalforplayer( "" );
        self visionsetkillstreakforplayer( "" );
        return;
    }
    
    visionsetinfo = killstreak_shared::function_dfddef6ddb119ee9( visionsetname );
    
    if ( !isdefined( visionsetinfo ) )
    {
        return;
    }
    
    fadeintime = visionsetinfo.fadeintime;
    
    if ( visionsetinfo.type == "thermal" )
    {
        self visionsetthermalforplayer( visionsetname );
        return;
    }
    
    self visionsetkillstreakforplayer( visionsetname );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xde1c1cc1, Offset: 0x13be
// Size: 0xc1
function killstreak_setsubvision( visionsetinfo )
{
    self endon( #"disconnect" );
    self notify( #"hash_e67f1b5b3c4ffe29" );
    self endon( #"hash_e67f1b5b3c4ffe29" );
    visionsetname = visionsetinfo.name;
    fadeintime = visionsetinfo.fadeintime;
    fadewait = visionsetinfo.fadewait;
    fadeouttime = visionsetinfo.fadeouttime;
    self visionsetfadetoblackforplayer( visionsetname, fadeintime );
    result = utility::waittill_any_timeout( fadewait, "returning_killstreak_player" );
    
    if ( result != "timeout" )
    {
        fadeouttime = 0;
    }
    
    self visionsetfadetoblackforplayer( "", fadeouttime );
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x11f0b636, Offset: 0x1487
// Size: 0x183
function registervisibilityomnvarforkillstreak( streakname, omnvarid, omnvarvalue )
{
    if ( !isdefined( level.killstreak_visbilityomnvarlist ) )
    {
        level.killstreak_visbilityomnvarlist = [];
    }
    
    assert( isdefined( omnvarid ) && omnvarid != "<dev string:x7e>", "<dev string:x82>" );
    
    if ( isdefined( level.killstreak_visbilityomnvarlist[ streakname ][ omnvarid ] ) )
    {
        assertmsg( "<dev string:xe1>" );
        return;
    }
    
    omnvarvalueexists = 0;
    
    foreach ( var_100cd131e6adbf53 in level.killstreak_visbilityomnvarlist )
    {
        foreach ( existingvalue in var_100cd131e6adbf53 )
        {
            if ( omnvarvalue == existingvalue )
            {
                omnvarvalueexists = 1;
                break;
            }
        }
        
        if ( omnvarvalueexists )
        {
            assertmsg( "<dev string:x134>" );
            return;
        }
    }
    
    level.killstreak_visbilityomnvarlist[ streakname ][ omnvarid ] = omnvarvalue;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xfe374301, Offset: 0x1612
// Size: 0x78
function function_d546aaa588f088c3( streakname, omnvarstate )
{
    omnvarvalue = undefined;
    
    if ( omnvarstate == "off" )
    {
        omnvarvalue = 0;
    }
    else
    {
        assert( isdefined( level.killstreak_visbilityomnvarlist[ streakname ][ omnvarstate ] ), "<dev string:x1d3>" );
        omnvarvalue = level.killstreak_visbilityomnvarlist[ streakname ][ omnvarstate ];
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( o"ui_killstreak_controls", omnvarvalue );
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x527af512, Offset: 0x1692
// Size: 0x43, Type: bool
function killstreakcanbeusedatroundstart( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    return istrue( bundle.var_fcb2e564a772857d );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x4a189a6a, Offset: 0x16de
// Size: 0x41
function function_d734101502c23572( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    return bundle.minimapicon;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x41e98af4, Offset: 0x1728
// Size: 0x1d, Type: bool
function function_7f760f39556df2e2()
{
    return level.gamemodebundle.var_b6c4a130ec9cef72 ?? "ks_use_crate_mp";
}

// Namespace killstreak_utility
// Params 5
// Checksum 0x76c024b, Offset: 0x174e
// Size: 0x115
function function_99456b220fc6798e( streakname, fallbackicon, bundle, iconsize, var_97753f9fa027d9e2 )
{
    icon = function_d734101502c23572( streakname ) ?? fallbackicon;
    
    if ( !icon )
    {
        assertmsg( "<dev string:x236>" );
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"game" ][ #"createobjective" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        minimapid = self [[ var_32dbca3143d9c4a5 ]]( icon, self.team, 0, 1, var_97753f9fa027d9e2, iconsize );
    }
    else
    {
        minimapid = undefined;
    }
    
    if ( !isdefined( minimapid ) )
    {
        assertmsg( "<dev string:x29a>" );
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"game" ][ #"objectivesetiszone" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( minimapid, 0 );
    }
    
    function_38c992e07c477802( minimapid, 1 );
    
    if ( bundle.var_e68b27347b49f603 )
    {
        function_a7ef321168907608( minimapid, 1 );
    }
    
    return minimapid;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7eff0463, Offset: 0x186c
// Size: 0x17, Type: bool
function isvalidkillstreak( streakname )
{
    return getkillstreakindex( streakname ) != -1;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xebaaf44e, Offset: 0x188c
// Size: 0x27, Type: bool
function getkillstreakindex( streakname )
{
    return level.streakglobals.var_9e0ca257f60b78aa[ streakname ] ?? -1;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xc5cad970, Offset: 0x18bc
// Size: 0x2f, Type: bool
function isridekillstreak( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    return bundle.var_a9780531cf636956 ?? 0;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x31954af2, Offset: 0x18f4
// Size: 0x2f, Type: bool
function ismapselectkillstreak( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    return bundle.ismapselect ?? 0;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xbeb99f68, Offset: 0x192c
// Size: 0x2f, Type: bool
function function_f30fd40c050e5557( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    return bundle.var_b5be2429ba1e1955 ?? 0;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x982ff1c7, Offset: 0x1964
// Size: 0x2f, Type: bool
function function_c29a6186f91aaa2c( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    return bundle.deployableinair ?? 0;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5cd4be94, Offset: 0x199c
// Size: 0x1e
function function_f9d9723c7169ec39( streakname )
{
    return killstreak::function_85b2d8e857ab4898( streakname ).usetime;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7e309e5e, Offset: 0x19c3
// Size: 0x57, Type: bool
function function_8bec29aceea719c3( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return weapobj.killstreakdeploycategory == #"remotedevice" && weapobj.killstreakdeploysubcategory == #"tablet";
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x68dd8c57, Offset: 0x1a23
// Size: 0x57, Type: bool
function function_ca1af65b4230eb71( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return weapobj.killstreakdeploycategory == #"hash_c81ab47217a89b29" && weapobj.killstreakdeploysubcategory == #"tablet";
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5e227215, Offset: 0x1a83
// Size: 0x57, Type: bool
function function_2910a801443e6b84( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return weapobj.killstreakdeploycategory == #"gesture" && weapobj.killstreakdeploysubcategory == #"phone";
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xd95458ef, Offset: 0x1ae3
// Size: 0x57, Type: bool
function function_603ce692d8e119af( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return false;
    }
    
    return weapobj.killstreakdeploycategory == #"gesture" && weapobj.killstreakdeploysubcategory == #"radio";
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x47cfacb6, Offset: 0x1b43
// Size: 0x42
function function_f45c61b25dd7ae02( streakname )
{
    streakindex = level.streakglobals.var_9e0ca257f60b78aa[ streakname ];
    self setclientomnvar( "ui_remote_control_sequence", streakindex );
    thread function_f95f0252b1552cea();
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x783887cc, Offset: 0x1b8d
// Size: 0x3d
function function_f95f0252b1552cea()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    animlength = 1;
    utility::waittill_any_timeout( animlength, "death" );
    function_9e544e095762719a();
}

// Namespace killstreak_utility
// Params 0
// Checksum 0xabd274db, Offset: 0x1bd2
// Size: 0xf
function function_9e544e095762719a()
{
    self setclientomnvar( "ui_remote_control_sequence", -1 );
}

// Namespace killstreak_utility
// Params 10
// Checksum 0x980fedf6, Offset: 0x1be9
// Size: 0x204
function killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    var_9d16794c5cd5960b = 1;
    vehicleref = killstreakvehicle vehicle::get_ref();
    setupname = vehicleref ?? streakname;
    
    if ( bundle.var_156a03d2f4ec6ea2 )
    {
        var_9d16794c5cd5960b = 0;
    }
    
    if ( isdefined( var_c96bcef6709d6df1 ) )
    {
        [[ var_c96bcef6709d6df1 ]]( streakname );
    }
    
    if ( isdefined( var_d188942a41771ea1 ) )
    {
        [[ var_d188942a41771ea1 ]]( streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreakmakevehicle" ) )
    {
        killstreakvehicle [[ utility::getsharedfunc( #"killstreak", #"killstreakmakevehicle" ) ]]( setupname, scorepopup, vodestroyed, destroyedsplash );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreaksetpremoddamagecallback" ) )
    {
        killstreakvehicle [[ utility::getsharedfunc( #"killstreak", #"killstreaksetpremoddamagecallback" ) ]]( setupname, premoddamagecallback );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreaksetpostmoddamagecallback" ) )
    {
        killstreakvehicle [[ utility::getsharedfunc( #"killstreak", #"killstreaksetpostmoddamagecallback" ) ]]( setupname, postmoddamagecallback );
    }
    
    if ( var_9d16794c5cd5960b )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_133cc9c3bfd2aa66" ) )
        {
            killstreakvehicle [[ utility::getsharedfunc( #"killstreak", #"hash_133cc9c3bfd2aa66" ) ]]( setupname, deathcallback );
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_eb373f8102edadec" ) )
    {
        killstreakvehicle [[ utility::getsharedfunc( #"killstreak", #"hash_eb373f8102edadec" ) ]]( setupname, deathcallback );
    }
}

// Namespace killstreak_utility
// Params 0
// Checksum 0xb68811ba, Offset: 0x1df5
// Size: 0x3d
function function_82efbf260da9f6f()
{
    var_1599cf1155ab06dc = self.owner;
    
    if ( self.oob )
    {
        var_1599cf1155ab06dc setclientomnvar( "ui_out_of_bounds_type", 0 );
        var_1599cf1155ab06dc setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x669ac34a, Offset: 0x1e3a
// Size: 0xad
function function_6824a8404514032c()
{
    var_c9af3e7a99aeba2e = self.owner;
    oobtype = undefined;
    oobtimeleft = undefined;
    
    if ( isdefined( self.oob ) && isdefined( self.oobendtime ) && isdefined( self.oobtype ) )
    {
        oobtype = self.oobtype;
        oobtimeleft = int( max( 0, self.oobendtime - gettime() ) );
        oobtimeleft = int( gettime() + oobtimeleft );
    }
    
    if ( oobtype && isdefined( oobtimeleft ) )
    {
        var_c9af3e7a99aeba2e setclientomnvar( "ui_out_of_bounds_type", oobtype );
        var_c9af3e7a99aeba2e setclientomnvar( "ui_out_of_bounds_countdown", oobtimeleft );
    }
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x515a588c, Offset: 0x1eef
// Size: 0x6d
function function_2c6a2b2cb28d923a()
{
    thermalvisionset = "killstreak_thermal";
    
    if ( isdefined( level.killstreakthermalvisionset ) )
    {
        thermalvisionset = level.killstreakthermalvisionset;
    }
    
    if ( isdefined( level.mapname ) && ( issubstr( level.mapname, "_shipment" ) || issubstr( level.mapname, "mp_skerries" ) ) )
    {
        thermalvisionset = "killstreak_thermal_fog";
    }
    
    return thermalvisionset;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xd3f49b58, Offset: 0x1f65
// Size: 0x6b
function function_9fa8f0ebfc2c137d( ent )
{
    teamtocheck = ent.pers[ "team" ];
    
    if ( isbrgamemode() )
    {
        if ( utility::issharedfuncdefined( #"game", #"hash_2000857173f60896" ) )
        {
            teamtocheck = [[ utility::getsharedfunc( #"game", #"hash_2000857173f60896" ) ]]( ent );
        }
    }
    
    return teamtocheck;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xed5aeb5e, Offset: 0x1fd9
// Size: 0x2c, Type: bool
function function_1dd205ebd00d2b41( ent )
{
    return ent.operatorcustomization.dialogset ?? function_9fa8f0ebfc2c137d( ent );
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xbfe796ac, Offset: 0x200e
// Size: 0x144
function function_daa9374e3f6779a5( streakname, charactersuffix )
{
    if ( function_3d2c08e068bcdf08() )
    {
        return;
    }
    
    ent = self;
    
    if ( isdefined( self.owner ) )
    {
        ent = self.owner;
    }
    
    if ( !isdefined( streakname ) )
    {
        streakname = "chopper_gunner";
    }
    
    if ( isplayer( ent ) )
    {
        teamtocheck = function_9fa8f0ebfc2c137d( ent );
        moderef = "mp";
        mapref = "mp_killstreak";
        sceneref = streakname;
        dialog = streakname + "_static_crash";
        eventref = game[ "dialog" ][ getxhash( dialog ) ];
        
        if ( !isdefined( eventref ) )
        {
            eventref = "killstreak_remote_operator_static";
        }
        
        charactertype = streakname;
        
        if ( isdefined( charactersuffix ) )
        {
            charactertype = streakname + "_" + charactersuffix;
        }
        
        characterref = function_4dfddef901e095ef( charactertype, teamtocheck );
        
        if ( !isdefined( characterref ) )
        {
            /#
                iprintln( "<dev string:x2e0>" );
            #/
            
            return;
        }
        
        dialogalias = dialog_utility::createdialogalias( moderef, mapref, sceneref, characterref, eventref );
        
        if ( isdefined( dialogalias ) )
        {
            ent queuedialogforplayer( #"queue2", dialogalias, dialog, 1 );
        }
    }
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xa7b5e9a5, Offset: 0x215a
// Size: 0x4a
function function_6f7e20373992cbeb( streakname, dialog, teamtocheck, charactersuffix )
{
    if ( !dialog_utility::dialogueexists( dialog ) )
    {
        /#
            iprintln( "<dev string:x317>" + dialog + "<dev string:x33a>" );
        #/
        
        return;
    }
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x7ed7753f, Offset: 0x21ac
// Size: 0x2a
function killstreak_getowner()
{
    if ( isplayer( self ) )
    {
        return self;
    }
    
    var_7237854e3be197ca = self.owner;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x2ec323fc, Offset: 0x21de
// Size: 0x38, Type: bool
function function_bcb0879012eb108e( owner, bypasscooldown )
{
    if ( function_3d2c08e068bcdf08( owner ) )
    {
        return false;
    }
    
    if ( !isdefined( owner.currentkillstreakopvo ) )
    {
        return true;
    }
    
    return istrue( bypasscooldown );
}

// Namespace killstreak_utility
// Params 9
// Checksum 0x27c5bf0a, Offset: 0x221f
// Size: 0x146, Type: bool
function playkillstreaktacomdialog( streakinfo, legacydialog, dialog, bypasscooldown, delaytime, charactersuffix, group, groupoverride, killstreakowner )
{
    assert( isstruct( streakinfo ) );
    streakname = streakinfo.streakname;
    voiceindex = streakinfo.id ?? 0;
    
    if ( !isdefined( killstreakowner ) )
    {
        killstreakowner = killstreak_getowner();
    }
    
    if ( !killstreakowner )
    {
        return false;
    }
    
    if ( delaytime > 0 )
    {
        killstreakowner endon( #"disconnect" );
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    if ( !function_bcb0879012eb108e( killstreakowner, bypasscooldown ) )
    {
        return false;
    }
    
    teamtocheck = function_9fa8f0ebfc2c137d( killstreakowner );
    dialogueentry = function_95548c33a4ab45f8( dialog, teamtocheck, streakname, #"pilots" );
    
    if ( !isstruct( dialogueentry ) )
    {
        return false;
    }
    
    voiceindex = function_7a79f62377065cf4( dialogueentry, voiceindex );
    killstreakowner dialog_utility::dialogonplayer( dialog, dialogueentry, teamtocheck, group, groupoverride, undefined, voiceindex );
    killstreakowner.currentkillstreakopvo = dialog;
    killstreakowner thread function_dd5b4d4c4181332e( 5 );
    return true;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xba74e29e, Offset: 0x236e
// Size: 0x65
function private function_1d659903f3aad5a6( team )
{
    validteam = isdefined( team ) && arraycontains( level.teamnamelist, team );
    
    if ( !validteam )
    {
        /#
            iprintln( "<dev string:x364>" );
        #/
        
        return;
    }
    
    teamoperator = "SpecGru";
    
    if ( team == "axis" )
    {
        teamoperator = "KorTac";
    }
    
    return teamoperator;
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x612885fc, Offset: 0x23dc
// Size: 0x23a
function private function_4dfddef901e095ef( charactertype, teamtocheck )
{
    teamref = function_1d659903f3aad5a6( teamtocheck );
    
    if ( !isdefined( teamref ) )
    {
        return;
    }
    
    characterstring = undefined;
    
    switch ( charactertype )
    {
        case #"hash_10e585c25e7e9f60":
        case #"hash_27002778019fb447":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e51f2e3d5cdd8ed8":
            characterstring = "UAV Operator";
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_2289ec11d77bce8f":
        case #"hash_28d0236400e33fd0":
        case #"hash_4ad475e6e15635bd":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
        case #"hash_de3d319cd367bcba":
            characterstring = "Helo Pilot";
            break;
        case #"hash_7a687f6a4d685110":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_a1031216158c7882":
        case #"hash_cf0ef5bef19a311b":
            characterstring = "Drone Pilot";
            break;
        case #"hash_4220be38a5f150b8":
        case #"hash_8c766d6477287bb6":
        case #"hash_b161e185f1b8e117":
            characterstring = "Airstrike Pilot";
            break;
        case #"hash_5735de454adee67b":
            characterstring = "Chopper Pilot";
            break;
        case #"hash_349713b5ad494dda":
        case #"hash_c45eaeb429cf1944":
            characterstring = "Chopper Gunner";
            break;
        case #"hash_659acc60bd11cb8e":
            characterstring = "Gunship Pilot";
            break;
        case #"hash_4a2b7af7e8ddbb45":
            characterstring = "Gunship Nav";
            break;
        case #"hash_413c38e72fe8b5bf":
            characterstring = "Gunship Sensor";
            break;
        case #"hash_b4ac3581c343a029":
            characterstring = "Mortar Gunner";
            break;
        case #"hash_49b9f9219b968090":
        case #"hash_ed469a6bfff6b265":
            characterstring = "EMP Plane Pilot";
            break;
        case #"hash_6362d6aae3e5a62e":
            characterstring = "Drone Swarm Operator";
            break;
    }
    
    characteroperator = undefined;
    
    if ( isdefined( characterstring ) )
    {
        characteroperator = teamref + " " + characterstring;
    }
    
    return characteroperator;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x1d3cd9d3, Offset: 0x261f
// Size: 0x24
function function_7a79f62377065cf4( dialogueentry, voiceindex )
{
    return voiceindex % dialogueentry.aliases.size;
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xeec50100, Offset: 0x264c
// Size: 0x96
function watchforblockedreset( streakinfo, slotindex, omnvarname, blockedtype )
{
    if ( !isdefined( omnvarname ) )
    {
        return;
    }
    
    self setclientomnvar( omnvarname, blockedtype );
    slotnotify = "watchForBlockedReset_" + ( isnumber( slotindex ) ? slotindex : getxhashhexname( slotindex ) );
    self notify( slotnotify );
    self endon( slotnotify );
    utility::function_f755811828e739dd( getdvarfloat( @"hash_2c20dac7438222f8", 2.5 ), level, "game_ended" );
    
    if ( self )
    {
        omnvar_utility::function_8734497daff87527( omnvarname, -1 );
    }
}

// Namespace killstreak_utility
// Params 3
// Checksum 0xa068bc49, Offset: 0x26ea
// Size: 0x3f
function function_8b88dd572355be1f( streakinfo, slotindex, blockedtype )
{
    thread watchforblockedreset( streakinfo, slotindex, level.streakglobals.blockedomnvars[ slotindex ], blockedtype );
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xe3557528, Offset: 0x2731
// Size: 0x80
function function_9ab9f18ea24992f3( slotindex, delay )
{
    var_dd8b1627be9af04d = level.streakglobals.blockedomnvars[ slotindex ];
    
    if ( !var_dd8b1627be9af04d )
    {
        return;
    }
    
    if ( self getclientomnvar( var_dd8b1627be9af04d ) == -1 )
    {
        return;
    }
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( self )
    {
        self notify( "watchForBlockedReset_" + ( isnumber( slotindex ) ? slotindex : getxhashhexname( slotindex ) ) );
        omnvar_utility::function_8734497daff87527( var_dd8b1627be9af04d, -1 );
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xe65211fb, Offset: 0x27b9
// Size: 0x88, Type: bool
function function_3d2c08e068bcdf08( listenplayer )
{
    if ( level.disableannouncer )
    {
        return true;
    }
    
    if ( level.showingfinalkillcam )
    {
        return true;
    }
    
    if ( isdefined( listenplayer ) )
    {
        if ( listenplayer.var_a367d2c471f89d37 )
        {
            return true;
        }
        
        if ( level.gulag.var_e4c82af12e81450 && ( listenplayer.jailed || listenplayer.gulagarena || listenplayer.gulag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x5957803c, Offset: 0x284a
// Size: 0x36
function function_bf1e678d7e03a550()
{
    listenplayer = self;
    
    if ( !isplayer( self ) )
    {
        if ( isdefined( self.owner ) )
        {
            listenplayer = self.owner;
        }
        else
        {
            return;
        }
    }
    
    return listenplayer;
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x1ef62bfd, Offset: 0x2889
// Size: 0x7a
function playkillstreakoperatordialog( streakname, dialog, dialogset )
{
    listenplayer = function_bf1e678d7e03a550();
    
    if ( !isdefined( listenplayer ) )
    {
        return;
    }
    
    if ( function_3d2c08e068bcdf08( listenplayer ) )
    {
        return;
    }
    
    dialogueentry = function_95548c33a4ab45f8( dialog, dialogset, streakname );
    
    if ( isdefined( dialogueentry ) )
    {
        listenplayer dialog_utility::dialogonplayer( dialog, dialogueentry, listenplayer.pers[ "team" ] );
    }
}

// Namespace killstreak_utility
// Params 5
// Checksum 0x3e457efd, Offset: 0x290b
// Size: 0x165
function function_2102f7ae8505ebc6( streakinfo, team, ownerplayer, dialogkey, excludeowner )
{
    if ( function_3d2c08e068bcdf08() )
    {
        return;
    }
    
    listenplayers = level.gametypebundle.var_fa876d7281ea44dc ? ownerplayer squad_utility::getsquadmembers( team, 0 ) : teams::getteamdata( team, "players" );
    excludelist = excludeowner ? [ ownerplayer ] : [];
    othersplitscreenplayer = ownerplayer getothersplitscreenplayer();
    
    if ( isdefined( othersplitscreenplayer ) )
    {
        excludelist[ excludelist.size ] = othersplitscreenplayer;
    }
    
    if ( isstruct( streakinfo ) )
    {
        streakname = streakinfo.streakname;
    }
    else
    {
        streakname = streakinfo;
    }
    
    dialogset = function_1dd205ebd00d2b41( ownerplayer );
    
    foreach ( player in listenplayers )
    {
        if ( arraycontains( excludelist, player ) )
        {
            continue;
        }
        
        player playkillstreakoperatordialog( streakname, dialogkey, dialogset );
    }
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xd9008e2c, Offset: 0x2a78
// Size: 0x107
function playkillstreakteamleaderdialog( streakinfo, legacydialog, dialog = legacydialog, multidialog )
{
    if ( function_3d2c08e068bcdf08( self ) )
    {
        return;
    }
    
    if ( isstruct( streakinfo ) )
    {
        streakname = streakinfo.streakname;
    }
    else
    {
        streakname = streakinfo;
    }
    
    listenplayer = function_bf1e678d7e03a550();
    
    if ( !isdefined( listenplayer ) )
    {
        return;
    }
    
    if ( listenplayer.var_a367d2c471f89d37 )
    {
        return;
    }
    
    teamtocheck = function_9fa8f0ebfc2c137d( listenplayer );
    dialogueentry = function_95548c33a4ab45f8( dialog, teamtocheck, streakname );
    
    if ( !isstruct( dialogueentry ) )
    {
        listenplayer function_9feea55a058467d5( streakname, legacydialog, teamtocheck );
        return;
    }
    
    if ( isdefined( multidialog ) )
    {
        multientry = function_95548c33a4ab45f8( multidialog, teamtocheck, streakname );
        
        if ( isstruct( multientry ) )
        {
            if ( listenplayer dialog_utility::function_ab67da8d856d4d0e( dialog, multientry, teamtocheck ) )
            {
                return;
            }
        }
    }
    
    listenplayer dialog_utility::dialogonplayer( dialog, dialogueentry, teamtocheck );
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x1708a085, Offset: 0x2b87
// Size: 0x25b
function function_9feea55a058467d5( streakname, dialog, teamtocheck )
{
    var_ea92011b0b2d0bd3 = isdefined( game[ "dialog" ][ teamtocheck ] ) && isdefined( game[ "dialog" ][ teamtocheck ][ dialog ] );
    
    if ( !isdefined( game[ "dialog" ][ dialog ] ) && !var_ea92011b0b2d0bd3 )
    {
        /#
            iprintln( "<dev string:x38e>" + dialog + "<dev string:x33a>" );
        #/
        
        return;
    }
    
    if ( var_ea92011b0b2d0bd3 && isdefined( game[ "dialog" ][ teamtocheck ][ dialog ] ) && !isarray( game[ "dialog" ][ teamtocheck ][ dialog ] ) )
    {
        dialogalias = game[ "dialog" ][ teamtocheck ][ dialog ];
    }
    else
    {
        moderef = "mp";
        mapref = function_93dd3cc4e297d2e9( streakname );
        sceneref = streakname;
        eventref = game[ "dialog" ][ dialog ];
        characterref = dialog_utility::function_8f16d04b74c7bcd1( teamtocheck );
        
        if ( !isdefined( characterref ) || !dialog_utility::function_57c828aa1fdae86f( characterref ) )
        {
            /#
                iprintln( "<dev string:x3b6>" );
            #/
            
            return;
        }
        
        if ( streakname == "remote_turret" )
        {
            sceneref = "sentry_gun";
        }
        else if ( streakname == "missile_drone" )
        {
            sceneref = "attack_drone";
        }
        
        dialogalias = dialog_utility::createdialogalias( moderef, mapref, sceneref, characterref, eventref );
        
        if ( !isdefined( dialogalias ) )
        {
            return;
        }
        
        dialogalias = tolower( dialogalias );
        
        if ( streakname == "emp" )
        {
            character = tolower( dialog_utility::function_b857dac241739eeb( "Character", characterref ) );
            
            if ( eventref == "killstreak_team_leader_earned" )
            {
                dialogalias = "dx_mp_core_anno_" + character + "_cere";
            }
            else if ( dialog == "emp_teamleader_enemy_inbound" )
            {
                dialogalias = "dx_mp_core_anno_" + character + "_ceho";
            }
        }
        else if ( streakname == "drone_swarm" && dialog == "drone_swarm_teamleader_enemy_inbound" )
        {
            character = tolower( dialog_utility::function_b857dac241739eeb( "Character", characterref ) );
            dialogalias = "dx_mp_core_anno_" + character + "_cdre";
            
            if ( character == "spet" )
            {
                dialogalias += "_01";
            }
        }
    }
    
    group = undefined;
    
    if ( isxhash( dialog ) )
    {
        group = "killstreak_earned";
        dialog = getxhashhexname( dialog );
    }
    
    self queuedialogforplayer( #"queue1", dialogalias, dialog, 2, group );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x5e048e0c, Offset: 0x2dea
// Size: 0x31
function private function_93dd3cc4e297d2e9( streakname )
{
    mapref = "mp_killstreak";
    
    if ( streakname == "radar_drone_recon" )
    {
        mapref = "mp_fieldupgrade";
    }
    
    return mapref;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x7a3d66a1, Offset: 0x2e24
// Size: 0x4a
function private function_dd5b4d4c4181332e( delaytime )
{
    self endon( #"disconnect" );
    self notify( #"hash_ce544cef131519d" );
    self endon( #"hash_ce544cef131519d" );
    wait delaytime;
    
    if ( isdefined( self.currentkillstreakopvo ) )
    {
        self.currentkillstreakopvo = undefined;
    }
}

// Namespace killstreak_utility
// Params 8
// Checksum 0x63e09ee0, Offset: 0x2e76
// Size: 0xf1
function function_a324263efbaae5dc( streakinfo, team, excludelist, dialogkey, legacykey, multikey, distancecheck, var_5b415c263e1d902 )
{
    listenplayers = [];
    
    if ( utility::issharedfuncdefined( #"game", #"hash_5efb2e5bbff12fc6" ) )
    {
        killstreakowner = undefined;
        
        if ( isplayer( self ) )
        {
            killstreakowner = self;
        }
        else if ( isdefined( self.owner ) )
        {
            killstreakowner = self.owner;
        }
        
        listenplayers = [[ utility::getsharedfunc( #"game", #"hash_5efb2e5bbff12fc6" ) ]]( team, killstreakowner.sessionsquadid );
    }
    else
    {
        listenplayers = teams::getteamdata( team, "players" );
    }
    
    function_97d917e5f3c1e519( streakinfo, listenplayers, excludelist, dialogkey, legacykey, multikey, distancecheck, var_5b415c263e1d902 );
}

// Namespace killstreak_utility
// Params 8
// Checksum 0xffa1cfd0, Offset: 0x2f6f
// Size: 0xfd
function function_97d917e5f3c1e519( streakinfo, listenplayers, excludelist, dialogkey, legacykey, multikey, distancecheck, var_5b415c263e1d902 )
{
    distancechecksq = distancecheck * distancecheck;
    
    foreach ( player in listenplayers )
    {
        if ( arraycontains( excludelist, player ) )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, var_5b415c263e1d902.origin ) <= distancechecksq )
        {
            player playkillstreakteamleaderdialog( streakinfo, legacykey, dialogkey, multikey );
        }
    }
}

// Namespace killstreak_utility
// Params 6
// Checksum 0x4a47b326, Offset: 0x3074
// Size: 0xc5
function function_27ff5d18674ca253( streakinfo, listenplayers, excludelist = [], dialogkey, legacykey, multikey )
{
    foreach ( player in listenplayers )
    {
        if ( arraycontains( excludelist, player ) )
        {
            continue;
        }
        
        player playkillstreakteamleaderdialog( streakinfo, legacykey, dialogkey, multikey );
    }
}

// Namespace killstreak_utility
// Params 6
// Checksum 0x2c1f902d, Offset: 0x3141
// Size: 0xdc
function function_313bd3ef50ebe16a( streakinfo, team, excludelist, dialogkey, legacykey, multikey )
{
    listenplayers = [];
    
    if ( utility::issharedfuncdefined( #"game", #"hash_5efb2e5bbff12fc6" ) )
    {
        killstreakowner = undefined;
        
        if ( isplayer( self ) )
        {
            killstreakowner = self;
        }
        else if ( isdefined( self.owner ) )
        {
            killstreakowner = self.owner;
        }
        
        listenplayers = [[ utility::getsharedfunc( #"game", #"hash_5efb2e5bbff12fc6" ) ]]( team, killstreakowner.sessionsquadid );
    }
    else
    {
        listenplayers = teams::getteamdata( team, "players" );
    }
    
    function_27ff5d18674ca253( streakinfo, listenplayers, excludelist, dialogkey, legacykey, multikey );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7f51adf0, Offset: 0x3225
// Size: 0x390
function playkillstreakusedialog( streakinfo )
{
    if ( function_3d2c08e068bcdf08() )
    {
        return;
    }
    
    if ( isstruct( streakinfo ) )
    {
        streakname = streakinfo.streakname;
    }
    else
    {
        streakname = streakinfo;
    }
    
    killstreakowner = undefined;
    
    if ( isplayer( self ) )
    {
        killstreakowner = self;
    }
    else if ( isdefined( self.owner ) )
    {
        killstreakowner = self.owner;
    }
    
    dialogteam = killstreakowner.pers[ "team" ];
    idx = dialogteam;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_7eab975bf2761f59" ) && [[ utility::getsharedfunc( #"game", #"hash_7eab975bf2761f59" ) ]]() )
    {
        idx = killstreakowner.sessionsquadid;
    }
    
    if ( level.teambased )
    {
        if ( !isdefined( level.killstreakactivatedtime[ streakname ] ) )
        {
            level.killstreakactivatedtime[ streakname ] = [];
        }
        
        if ( isdefined( level.killstreakactivatedtime[ streakname ][ idx ] ) )
        {
            if ( gettime() < level.killstreakactivatedtime[ streakname ][ idx ] )
            {
                return;
            }
        }
        
        level.killstreakactivatedtime[ streakname ][ idx ] = gettime() + 10000;
    }
    
    excludelist = [ killstreakowner ];
    
    if ( level.teambased )
    {
        othersplitscreenplayer = killstreakowner getothersplitscreenplayer();
        
        if ( isdefined( othersplitscreenplayer ) )
        {
            excludelist[ excludelist.size ] = othersplitscreenplayer;
        }
        
        var_3319fcb3a81761ab = canplaykillstreakdialog( streakname, 1 );
        var_de83af633bad4fc = canplaykillstreakdialog( streakname );
        
        if ( var_3319fcb3a81761ab )
        {
            if ( level.gamemodebundle.var_38c5f40cfbab8ec1 )
            {
                function_2102f7ae8505ebc6( streakinfo, dialogteam, killstreakowner, #"inbound_friendly", 1 );
            }
            else
            {
                function_313bd3ef50ebe16a( streakinfo, dialogteam, excludelist, #"inbound_friendly", streakname + "_teamleader_friendly_inbound" );
            }
        }
        
        if ( var_de83af633bad4fc )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( team == dialogteam )
                {
                    continue;
                }
                
                bundle = level.streakglobals.streakbundles[ streakname ];
                
                if ( bundle.var_d30c96521f865aa2 > 0 )
                {
                    function_a324263efbaae5dc( streakinfo, team, excludelist, #"inbound_enemy", streakname + "_teamleader_enemy_inbound", #"inbound_enemy_multi", bundle.var_d30c96521f865aa2, self );
                    continue;
                }
                
                function_313bd3ef50ebe16a( streakinfo, team, excludelist, #"inbound_enemy", streakname + "_teamleader_enemy_inbound", #"inbound_enemy_multi" );
            }
        }
        
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( bundle.var_d30c96521f865aa2 > 0 )
    {
        function_97d917e5f3c1e519( streakinfo, level.players, excludelist, #"inbound_enemy", streakname + "_teamleader_enemy_inbound", #"inbound_enemy_multi", bundle.var_d30c96521f865aa2, self );
        return;
    }
    
    function_27ff5d18674ca253( streakinfo, level.players, excludelist, #"inbound_enemy", streakname + "_teamleader_enemy_inbound", #"inbound_enemy_multi" );
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x4a201d8f, Offset: 0x35bd
// Size: 0x86, Type: bool
function canplaykillstreakdialog( streakname, friendly )
{
    bundle = function_f943c0602acdc2af( streakname );
    spam_reduction = isbrgamemode() || game_utility::function_8d8af1d3e14d5c3b();
    
    if ( spam_reduction )
    {
        if ( friendly )
        {
            if ( bundle.var_ae30053dfb9622a )
            {
                return false;
            }
        }
        else if ( bundle.var_21c2a6999c3f6157 )
        {
            return false;
        }
    }
    
    if ( !friendly )
    {
        if ( bundle.var_200b4d848a5c2dc9 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x81efb4bd, Offset: 0x364c
// Size: 0x4
function getkillstreakdialogcooldown()
{
    return 10;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5e367ffc, Offset: 0x3659
// Size: 0x43, Type: bool
function function_582d52b10a1972e5( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    return istrue( bundle.var_9b243c28b41fb79f );
}

// Namespace killstreak_utility
// Params 8
// Checksum 0x5e1078d6, Offset: 0x36a5
// Size: 0x38c
function killstreak_dangernotifyplayersinrange( owner, ownerteam, range, streakname, location, overrideheight, var_5c7a807a516538d2, approachangles )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    var_34e0e5c5257b6432 = function_1dfaaaee60477937( streakname );
    
    if ( !var_34e0e5c5257b6432 )
    {
        return;
    }
    
    notifylocation = location ?? owner.origin;
    bundle = function_f943c0602acdc2af( streakname );
    var_c54fe264895d5914 = bundle.var_1d652cf96b21772c;
    var_8ae86d6397f74f5b = bundle.var_9ee55b3440903fda ?? 0;
    var_fdf5d39dd3b2401a = bundle.var_a4e67ab84e29a87d ?? 0;
    playersinrange = [];
    
    if ( var_5c7a807a516538d2 )
    {
        var_febd844e3d0fa655 = isdefined( approachangles ) ? approachangles : owner.angles[ 1 ];
        fwd = anglestoforward( ( 0, var_febd844e3d0fa655, 0 ) );
        offset = int( range * 0.5 );
        checklocations = [ notifylocation - fwd * offset, notifylocation, notifylocation + fwd * offset ];
        
        /#
            if ( getdvarint( @"hash_d218c959e1a09e1d", 0 ) )
            {
                foreach ( checklocation in checklocations )
                {
                    start = checklocation + ( 0, 0, 1000 );
                    end = checklocation + ( 0, 0, -1000 );
                    cylinder( start, end, range, ( 1, 0.5, 0 ), 1, 500 );
                }
            }
        #/
        
        foreach ( checklocation in checklocations )
        {
            var_1b15aa3e9427f6d4 = function_690d867c00549791( owner, ownerteam, checklocation, range, var_c54fe264895d5914, streakname, overrideheight, var_8ae86d6397f74f5b );
            playersinrange = arraycombineunique( playersinrange, var_1b15aa3e9427f6d4 );
        }
    }
    else
    {
        /#
            if ( getdvarint( @"hash_d218c959e1a09e1d", 0 ) )
            {
                start = notifylocation + ( 0, 0, 1000 );
                end = notifylocation + ( 0, 0, -1000 );
                cylinder( start, end, range, ( 0, 1, 0 ), 1, 500 );
            }
        #/
        
        playersinrange = function_690d867c00549791( owner, ownerteam, notifylocation, range, var_c54fe264895d5914, streakname, overrideheight, var_8ae86d6397f74f5b );
    }
    
    foreach ( player in playersinrange )
    {
        killstreak_dangernotifyplayer( player, streakname, owner, var_fdf5d39dd3b2401a );
    }
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x80b2bca0, Offset: 0x3a39
// Size: 0x60
function function_1e1ca079700e042( owner, player, streakname )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    var_34e0e5c5257b6432 = function_1dfaaaee60477937( streakname );
    
    if ( !var_34e0e5c5257b6432 )
    {
        return;
    }
    
    if ( owner == player && !function_291e9b4df4c2e98f( streakname ) )
    {
        return;
    }
    
    killstreak_dangernotifyplayer( player, streakname );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x3e369e07, Offset: 0x3aa1
// Size: 0x56, Type: bool
function private function_1dfaaaee60477937( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    spam_reduction = isbrgamemode() || game_utility::function_8d8af1d3e14d5c3b();
    
    if ( spam_reduction )
    {
        if ( bundle.var_183a1fee9e7241e4 )
        {
            return true;
        }
    }
    
    return function_582d52b10a1972e5( streakname );
}

// Namespace killstreak_utility
// Params 4, eflags: 0x4
// Checksum 0x4a3764c6, Offset: 0x3b00
// Size: 0xb0
function private killstreak_dangernotifyplayer( player, streakname, owner, var_ca59a063cc5d262d )
{
    if ( isagent( player ) )
    {
        player thread function_fc271c29304a99bd( owner, var_ca59a063cc5d262d );
        return;
    }
    
    if ( level.var_91d0747280f9e90c && function_582d52b10a1972e5( streakname ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"dangernotifyplayer" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"dangernotifyplayer" ) ]]( player, streakname, undefined, undefined, owner );
        }
        else
        {
            dangernotifyplayer( player, streakname, undefined, undefined, owner );
        }
        
        return;
    }
    
    function_19118c649ca7f73e( player, streakname, owner );
}

// Namespace killstreak_utility
// Params 5
// Checksum 0x896ed3b4, Offset: 0x3bb8
// Size: 0x1fa
function dangernotifyplayer( player, notifytype, timeoutoverride, isfriendlyplayer, owner )
{
    notifynumber = 0;
    
    switch ( notifytype )
    {
        case #"hash_b4ac3581c343a029":
            notifynumber = 1;
            break;
        case #"hash_8c766d6477287bb6":
            notifynumber = 2;
            break;
        case #"hash_256bff2a9cc092c8":
            notifynumber = 3;
            break;
        case #"hash_6f819beef2080ba9":
            notifynumber = 4;
            break;
        case #"hash_13b68af513c903e8":
            notifynumber = 5;
            break;
        case #"hash_80c5f88142053bf4":
            notifynumber = 6;
            break;
        case #"hash_72237571b4515421":
        case #"hash_b3b9048fbdb1c48f":
            notifynumber = 7;
            break;
        case #"hash_6cf2279b8aabef9f":
            notifynumber = 8;
            break;
        case #"hash_e71cf650b470aa20":
            notifynumber = 9;
            break;
        case #"hash_422614db7b615a5b":
            notifynumber = 10;
            break;
        case #"hash_eaa69e667c221114":
            notifynumber = 11;
            break;
        case #"hash_e5ede0f09328ea53":
            notifynumber = 12;
            break;
        case #"hash_ca1da21e366e13f":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
            notifynumber = 13;
            break;
        case #"hash_42fd64e842a4c3d7":
            notifynumber = 14;
            break;
        case #"hash_577495088db80465":
            notifynumber = 16;
            break;
        case #"hash_9956fc544449f64":
            notifynumber = 17;
            break;
        case #"hash_2cb2b7f44f2f6237":
            notifynumber = 18;
            break;
        case #"hash_568092dc521d2e1d":
            notifynumber = 19;
            break;
        default:
            break;
    }
    
    function_19118c649ca7f73e( player, notifytype, owner );
    
    if ( notifynumber > 0 )
    {
        player setclientomnvar( "ui_br_danger_warning", notifynumber );
        dangernotifyresetforplayer( player, timeoutoverride );
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x300d5c98, Offset: 0x3dba
// Size: 0x4d
function function_fc271c29304a99bd( owner, delay )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait delay;
    
    if ( isalive( self ) )
    {
        stealtheventbroadcastsimple( "cover_blown", owner, self.origin );
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x47d1add2, Offset: 0x3e0f
// Size: 0x59
function dangernotifyresetforplayer( player, timeoutoverride )
{
    playerid = player getxuid();
    
    if ( !isdefined( timeoutoverride ) )
    {
        timeoutoverride = 4;
    }
    
    level notify( "danger_notify_start_" + playerid );
    level thread watchdangerresetaction( player, playerid, "death_or_disconnect" );
    level thread watchdangerresetaction( player, playerid, undefined, timeoutoverride );
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xc4c0da32, Offset: 0x3e70
// Size: 0x7f
function watchdangerresetaction( player, playerid, action, timeout )
{
    level endon( "danger_notify_start_" + playerid );
    level endon( "danger_notify_finished_" + playerid );
    level endon( #"game_ended" );
    
    if ( isdefined( action ) )
    {
        player waittill( action );
    }
    else if ( isdefined( timeout ) )
    {
        wait timeout;
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_br_danger_warning", 0 );
    }
    
    level notify( "danger_notify_finished_" + playerid );
}

// Namespace killstreak_utility
// Params 3
// Checksum 0xb3633859, Offset: 0x3ef7
// Size: 0xef
function function_19118c649ca7f73e( player, notifytype, owner )
{
    var_4e745cd12bb09ca9 = 1;
    
    if ( isdefined( level.var_9010a3d9d2f1c4ad ) && isdefined( level.var_c65d360ae9b3f43a ) )
    {
        if ( isdefined( level.var_c65d360ae9b3f43a[ notifytype ] ) && gettime() < level.var_c65d360ae9b3f43a[ notifytype ][ player.guid ] )
        {
            var_4e745cd12bb09ca9 = 0;
        }
        else
        {
            level.var_c65d360ae9b3f43a[ notifytype ][ player.guid ] = gettime() + level.var_9010a3d9d2f1c4ad * 1000;
        }
    }
    
    if ( var_4e745cd12bb09ca9 && isvalidkillstreak( notifytype ) && player.team != owner.team )
    {
        player playkillstreakteamleaderdialog( notifytype, notifytype + "_teamleader_enemy_inbound", #"inbound_enemy" );
    }
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0xa73a5aab, Offset: 0x3fee
// Size: 0x68, Type: bool
function private function_291e9b4df4c2e98f( streakname, var_c54fe264895d5914 )
{
    if ( !isdefined( streakname ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_abfa95c246ced9c3 ) && !level.var_abfa95c246ced9c3 && !var_c54fe264895d5914 )
    {
        return false;
    }
    
    bundle = function_f943c0602acdc2af( streakname );
    
    if ( bundle.var_ab752d62f06a9b91 )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 8, eflags: 0x4
// Checksum 0x54660daf, Offset: 0x405f
// Size: 0x1fc
function private function_690d867c00549791( owner, ownerteam, location, range, var_c54fe264895d5914, streakname, overrideheight, var_8ae86d6397f74f5b )
{
    var_282106689455dd16 = [];
    var_1f39d5da859f3177 = [];
    
    if ( !function_291e9b4df4c2e98f( streakname, var_c54fe264895d5914 ) )
    {
        var_1f39d5da859f3177 = [ owner ];
    }
    
    if ( level.teambased )
    {
        if ( utility::issharedfuncdefined( #"gamemode", #"hash_8d3beab1cbd2cada" ) )
        {
            var_1f39d5da859f3177 = utility::callsharedfunc( #"gamemode", #"hash_8d3beab1cbd2cada", owner, ownerteam );
        }
        else if ( utility::issharedfuncdefined( #"game", #"hash_5efb2e5bbff12fc6" ) )
        {
            var_1f39d5da859f3177 = utility::callsharedfunc( #"game", #"hash_5efb2e5bbff12fc6", ownerteam, owner.sessionsquadid );
        }
        else
        {
            var_1f39d5da859f3177 = level.teamdata[ ownerteam ][ "players" ];
        }
        
        if ( function_291e9b4df4c2e98f( streakname ) && isdefined( var_1f39d5da859f3177 ) )
        {
            var_1f39d5da859f3177 = arrayremove( var_1f39d5da859f3177, owner );
        }
    }
    
    if ( !isdefined( location ) )
    {
        location = owner.origin;
    }
    
    if ( !isdefined( range ) )
    {
        range = 5000;
    }
    
    if ( var_c54fe264895d5914 )
    {
        foreach ( player in var_1f39d5da859f3177 )
        {
            var_a9e11e209cb587aa = function_1f4d8fce0c748142( player.origin, range, var_1f39d5da859f3177, var_282106689455dd16, overrideheight, var_8ae86d6397f74f5b );
            var_282106689455dd16 = arraycombine( var_282106689455dd16, var_a9e11e209cb587aa );
        }
    }
    else
    {
        var_282106689455dd16 = function_1f4d8fce0c748142( location, range, var_1f39d5da859f3177, undefined, overrideheight, var_8ae86d6397f74f5b );
    }
    
    return var_282106689455dd16;
}

// Namespace killstreak_utility
// Params 6
// Checksum 0xc4753a22, Offset: 0x4264
// Size: 0x140
function function_1f4d8fce0c748142( location, range, var_1f39d5da859f3177, var_aace098c32466a9c, overrideheight, var_8ae86d6397f74f5b )
{
    enemiesinrange = [];
    
    if ( var_8ae86d6397f74f5b )
    {
        enemyplayersinrange = utility::function_f754506ecfae9afb( location, range, var_1f39d5da859f3177, overrideheight );
    }
    else
    {
        enemyplayersinrange = utility::playersincylinder( location, range, var_1f39d5da859f3177, overrideheight );
    }
    
    foreach ( enemyplayer in enemyplayersinrange )
    {
        if ( !isdefined( enemyplayer ) || isbot( enemyplayer ) || !enemyplayer player::isreallyalive() || enemyplayer player::isreallyalive() && enemyplayer.gulag )
        {
            continue;
        }
        
        if ( isagent( enemyplayer ) && !var_8ae86d6397f74f5b )
        {
            continue;
        }
        
        if ( function_e85c7b4e201d4ced( enemyplayer, var_aace098c32466a9c ) )
        {
            continue;
        }
        
        enemiesinrange[ enemiesinrange.size ] = enemyplayer;
    }
    
    return enemiesinrange;
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x4da69a6a, Offset: 0x43ad
// Size: 0xab
function private function_e85c7b4e201d4ced( enemyplayer, var_aace098c32466a9c )
{
    if ( !isdefined( var_aace098c32466a9c ) || var_aace098c32466a9c.size == 0 )
    {
        return 0;
    }
    
    var_8a0d8abacb0af5a2 = 0;
    
    foreach ( storedenemy in var_aace098c32466a9c )
    {
        if ( storedenemy == enemyplayer )
        {
            var_8a0d8abacb0af5a2 = 1;
            break;
        }
    }
    
    return var_8a0d8abacb0af5a2;
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xfd0efad4, Offset: 0x4461
// Size: 0x7e
function function_e6fc48237c0a5166( influencerkey, location, team, owner )
{
    if ( game_utility_mp::lpcfeaturegated() )
    {
        return;
    }
    
    function_43ef8750f44fafce();
    
    if ( !utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        return;
    }
    
    self.dangerzoneid = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( influencerkey, location, team, owner );
}

// Namespace killstreak_utility
// Params 4
// Checksum 0x83b6db17, Offset: 0x44e7
// Size: 0x99
function function_56141a75b0286674( influencerkey, owner, team, overrideorigin )
{
    origin = overrideorigin ?? self.origin;
    
    if ( game_utility_mp::lpcfeaturegated() )
    {
        return;
    }
    
    function_43ef8750f44fafce();
    
    if ( !utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        return;
    }
    
    self.dangerzoneid = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( influencerkey, origin, team, owner, self );
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x5e8a28e1, Offset: 0x4588
// Size: 0x49
function private function_ad95b605cfc96f9b()
{
    level endon( #"game_ended" );
    utility::waittill_any( "deleted", "death", "danger_zone_removed" );
    
    if ( isdefined( self.var_a9673f63c24533f1 ) )
    {
        self.var_a9673f63c24533f1 delete();
        self.var_a9673f63c24533f1 = undefined;
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x37ccce85, Offset: 0x45d9
// Size: 0xc6
function function_43ef8750f44fafce( dangerzoneid )
{
    if ( !isdefined( dangerzoneid ) && !isdefined( self.dangerzoneid ) )
    {
        return;
    }
    
    if ( !utility::issharedfuncdefined( #"spawn", #"isspawninfluenceractive" ) || !utility::issharedfuncdefined( #"spawn", #"removeSpawnInfluencer" ) )
    {
        return;
    }
    
    if ( !isdefined( dangerzoneid ) )
    {
        dangerzoneid = self.dangerzoneid;
    }
    
    if ( isdefined( dangerzoneid ) && [[ utility::getsharedfunc( #"spawn", #"isspawninfluenceractive" ) ]]( dangerzoneid ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"removeSpawnInfluencer" ) ]]( dangerzoneid );
    }
    
    self.dangerzoneid = undefined;
    self notify( #"danger_zone_removed" );
}

// Namespace killstreak_utility
// Params 6
// Checksum 0x246de01, Offset: 0x46a7
// Size: 0x131
function function_6356b61ad86581cc( targetlocation, iconname, owner, zoffset, lifetime, scriptablename )
{
    dangermarker = spawn( "script_model", targetlocation );
    dangermarker.icon = iconname;
    dangermarker.owner = owner;
    
    if ( !isdefined( zoffset ) )
    {
        zoffset = 50;
    }
    
    dangermarker.zoffset = zoffset;
    
    if ( !isdefined( lifetime ) )
    {
        lifetime = 5;
    }
    
    dangermarker.lifetime = lifetime;
    modelname = "tag_origin";
    
    if ( isdefined( scriptablename ) )
    {
        modelname = scriptablename;
        dangermarker.scriptable = scriptablename;
    }
    
    dangermarker setmodel( modelname );
    dangermarker setotherent( owner );
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        dangermarker.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
    }
    
    dangermarker function_50838faf7b2ef5ad( dangermarker.objidnum );
    dangermarker thread function_18590747d58927b9();
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x2ca5a703, Offset: 0x47e0
// Size: 0xbc
function private function_50838faf7b2ef5ad( objid )
{
    icon = self.icon;
    owner = self.owner;
    zoffset = self.zoffset;
    objective_icon( objid, icon );
    objective_showtoplayersinmask( objid );
    objective_addclienttomask( objid, owner );
    objective_onentity( objid, self );
    objective_setzoffset( objid, zoffset );
    objective_setplayintro( objid, 0 );
    objective_setplayoutro( objid, 0 );
    objective_setbackground( objid, 1 );
    
    if ( level.teambased )
    {
        objective_setownerteam( objid, owner.team );
    }
    else
    {
        objective_setownerclient( objid, owner );
    }
    
    objective_state( objid, "current" );
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x33ae1f46, Offset: 0x48a4
// Size: 0x94
function private function_18590747d58927b9()
{
    self endon( #"death" );
    lifetime = self.lifetime;
    
    if ( isdefined( self.scriptable ) )
    {
        self setscriptablepartstate( "target", "on", 0 );
    }
    
    hostmigration::waitlongdurationwithpause( lifetime );
    
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x7c558a4d, Offset: 0x4940
// Size: 0x59
function streakcanseetarget( startpos, endpos, ignorelist )
{
    icansee = 0;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( trace::ray_trace_passed( startpos, endpos, ignorelist, contents ) )
    {
        icansee = 1;
    }
    
    return icansee;
}

// Namespace killstreak_utility
// Params 5
// Checksum 0xdbc33bba, Offset: 0x49a2
// Size: 0x386
function function_9c51f918f2c46115( startingpos, startingangles, var_b73036c14b59d133, flightdistance, ignorelist )
{
    setdvarifuninitialized( @"hash_313823a110b35022", 0 );
    flightangles = ( 0, startingangles[ 1 ], 0 );
    entforward = anglestoforward( flightangles );
    entright = anglestoright( flightangles );
    contents = trace::create_default_contents( 1 );
    
    if ( !isdefined( flightdistance ) )
    {
        flightdistance = 15000;
    }
    
    var_4159891f0b5bc03 = [ startingpos - entforward * flightdistance, startingpos + entforward * flightdistance, startingpos + entright * flightdistance, startingpos - entright * flightdistance, startingpos + ( entforward + entright ) * flightdistance, startingpos + ( entforward - entright ) * flightdistance, startingpos + ( entright - entforward ) * flightdistance, startingpos + ( -1 * entforward - entright ) * flightdistance ];
    
    if ( !isdefined( var_b73036c14b59d133 ) )
    {
        var_b73036c14b59d133 = 512;
    }
    
    flightpath = spawnstruct();
    flightpath.start = startingpos;
    flightpath.end = undefined;
    flightpath.angles = undefined;
    
    /#
        debugdrawpath = getdvarint( @"hash_313823a110b35022", 0 );
    #/
    
    foreach ( dirpos in var_4159891f0b5bc03 )
    {
        var_8ba4b8834e7ce583 = vectornormalize( dirpos - startingpos );
        endingpos = startingpos + var_8ba4b8834e7ce583 * flightdistance;
        traceresult = trace::sphere_trace( startingpos, endingpos, var_b73036c14b59d133, ignorelist, contents );
        
        if ( isdefined( traceresult[ "hittype" ] ) && traceresult[ "hittype" ] != "hittype_none" )
        {
            positionhit = traceresult[ "position" ];
            mindistthreshold = flightdistance * 0.75;
            mindistthresholdsq = mindistthreshold * mindistthreshold;
            
            if ( distance2dsquared( startingpos, positionhit ) >= mindistthresholdsq )
            {
                flightangles = vectortoangles( dirpos - startingpos );
                forwarddir = anglestoforward( flightangles );
                distdiff = distance2d( dirpos, positionhit );
                flightpath.end = dirpos - forwarddir * distdiff;
                flightpath.angles = flightangles;
                
                /#
                    if ( debugdrawpath )
                    {
                        level thread debug_utility::drawline( startingpos, dirpos, 30, ( 1, 1, 0 ) );
                        level thread debug_utility::drawsphere( positionhit, 50, 30, ( 1, 1, 0 ) );
                        level thread debug_utility::drawsphere( flightpath.end, 50, 30, ( 0, 1, 0 ) );
                    }
                #/
                
                break;
            }
            
            /#
                if ( debugdrawpath )
                {
                    level thread debug_utility::drawline( startingpos, dirpos, 30, ( 1, 0, 0 ) );
                    level thread debug_utility::drawsphere( positionhit, 50, 30, ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        else
        {
            /#
                if ( debugdrawpath )
                {
                    level thread debug_utility::drawline( startingpos, dirpos, 30, ( 0, 1, 0 ) );
                }
            #/
        }
        
        flightpath.end = dirpos;
        flightpath.angles = vectortoangles( dirpos - startingpos );
        break;
    }
    
    return flightpath;
}

// Namespace killstreak_utility
// Params 8
// Checksum 0x5d66e750, Offset: 0x4d31
// Size: 0x20e
function function_92b58f17af03198f( streakname, streakowner, hintstring, useobjid, juggcanuse, hinticon, var_51ce1369e6f222cc, var_7e9dc92529ec1ac3 )
{
    if ( !isdefined( streakowner ) )
    {
        /#
            iprintln( "<dev string:x3f2>" );
        #/
        
        return;
    }
    
    if ( !isdefined( streakowner.var_f71cd0657bc26adf ) )
    {
        streakowner.var_f71cd0657bc26adf = [];
        level thread function_2aa564a23946109b( streakowner );
    }
    
    if ( !isdefined( function_66160ad6f52dcbf5( streakname, streakowner, useobjid ) ) )
    {
        if ( !isdefined( streakowner.var_f71cd0657bc26adf[ streakname ] ) )
        {
            streakowner.var_f71cd0657bc26adf[ streakname ] = [];
        }
        
        useobj = spawn( "script_model", self.origin );
        useobj setmodel( "tag_origin" );
        useobj linkto( self, function_e6297e9c110a410b( streakname ), ( 0, 0, 0 ), ( 0, 0, 0 ) );
        useobj.owner = streakowner;
        useobj.streakname = streakname;
        useobj.activeuseobject = 0;
        useobj.parentent = self;
        useobj.useobjsuspended = 0;
        useobj.juggusable = istrue( juggcanuse );
        
        if ( utility::issharedfuncdefined( #"killstreak", #"setkillstreakcontrolpriority" ) )
        {
            useobj [[ utility::getsharedfunc( #"killstreak", #"setkillstreakcontrolpriority" ) ]]( streakowner, hintstring, 360, 360, 65535, 65535, 1, 1 );
        }
        
        if ( isdefined( var_51ce1369e6f222cc ) )
        {
            useobj setuseholdduration( var_51ce1369e6f222cc );
        }
        
        streakowner.var_f71cd0657bc26adf[ streakname ][ useobjid ] = useobj;
        
        if ( streakname == "hover_jet" )
        {
            if ( !streakowner.remoteturretactive )
            {
                function_966fa988728dbfbf( useobj );
            }
        }
        else
        {
            function_966fa988728dbfbf( useobj );
        }
        
        level thread function_f297e0bb7db277c5( useobj );
        level thread function_8fd6d96c3946a806( useobj, var_7e9dc92529ec1ac3 );
        return useobj;
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x2196221, Offset: 0x4f47
// Size: 0x1e0
function private function_2aa564a23946109b( owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    /#
        setdevdvarifuninitialized( @"hash_c2417142804c1c76", 0 );
    #/
    
    focususe = getdvarint( @"hash_c2417142804c1c76", 0 );
    
    if ( !focususe )
    {
        return;
    }
    
    while ( true )
    {
        var_b2c46d4ec59fbecc = owner.var_f71cd0657bc26adf;
        var_51dcc320b1484073 = undefined;
        bestdistance = undefined;
        
        foreach ( var_701a6e8f2c95a76b in var_b2c46d4ec59fbecc )
        {
            foreach ( useobj in var_701a6e8f2c95a76b )
            {
                if ( isdefined( useobj ) )
                {
                    if ( function_b1ac3315d378db26( useobj ) )
                    {
                        if ( !isdefined( bestdistance ) )
                        {
                            bestdistance = distance2dsquared( useobj.origin, owner getvieworigin() );
                            var_51dcc320b1484073 = useobj;
                            continue;
                        }
                        
                        newdistance = distance2dsquared( useobj.origin, owner getvieworigin() );
                        
                        if ( newdistance < bestdistance )
                        {
                            bestdistance = newdistance;
                            var_51dcc320b1484073 = useobj;
                        }
                    }
                }
            }
        }
        
        if ( isdefined( var_51dcc320b1484073 ) )
        {
            if ( !function_6d9bd39f4b42df95( var_51dcc320b1484073 ) )
            {
                function_966fa988728dbfbf( var_51dcc320b1484073, 1 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xffdfa3d6, Offset: 0x512f
// Size: 0xcc
function function_966fa988728dbfbf( useobj, highlight )
{
    if ( isdefined( useobj ) )
    {
        owner = useobj.owner;
        
        if ( isdefined( owner ) )
        {
            function_9d7137eb1e7848f2( owner );
            suspendeduseobj = function_acd01e9515a3b842( owner );
            
            if ( isdefined( suspendeduseobj ) )
            {
                suspendeduseobj.useobjsuspended = 0;
                suspendeduseobj notify( #"hash_35ea742f5dccf4fa" );
            }
            
            if ( owner namespace_9d8e359c3b1041e5::isjuggernautsharedfunc() )
            {
                if ( !useobj.juggusable )
                {
                    function_bea4bda17e40ffb0( owner, useobj );
                }
                else
                {
                    function_78bf21874602e770( useobj, highlight );
                }
                
                return;
            }
            
            if ( owner.inlaststand )
            {
                function_bea4bda17e40ffb0( owner, useobj );
                return;
            }
            
            function_78bf21874602e770( useobj, highlight );
        }
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x7b80ae3d, Offset: 0x5203
// Size: 0x2f
function private function_9d7137eb1e7848f2( owner )
{
    activestreakobj = function_e90788a3eb76165b( owner );
    
    if ( isdefined( activestreakobj ) )
    {
        function_376bd9cf8daa8b21( activestreakobj );
    }
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x267f381b, Offset: 0x523a
// Size: 0x5f
function private function_78bf21874602e770( useobj, highlight )
{
    useobj enableplayeruse( useobj.owner );
    useobj.activeuseobject = 1;
    
    if ( highlight )
    {
        useobj notify( #"useObj_start_highlight" );
    }
    
    useobj.parentent.useobj = useobj;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xb5420bb9, Offset: 0x52a1
// Size: 0x2b
function private function_376bd9cf8daa8b21( useobj )
{
    useobj disableplayeruse( useobj.owner );
    useobj.activeuseobject = 0;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x7b01c035, Offset: 0x52d4
// Size: 0x38
function function_bea4bda17e40ffb0( owner, useobjoverride )
{
    if ( !isplayer( owner ) )
    {
        /#
            iprintln( "<dev string:x447>" );
        #/
        
        return;
    }
    
    level thread function_5b758fa3902a0bf8( owner, useobjoverride );
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x4c5bfc56, Offset: 0x5314
// Size: 0xcf
function private function_5b758fa3902a0bf8( owner, useobjoverride )
{
    level endon( #"game_ended" );
    activestreakobj = function_e90788a3eb76165b( owner );
    
    if ( isdefined( useobjoverride ) )
    {
        activestreakobj = useobjoverride;
    }
    
    if ( isdefined( activestreakobj ) )
    {
        if ( activestreakobj.juggusable && owner namespace_9d8e359c3b1041e5::isjuggernautsharedfunc() )
        {
            return;
        }
        
        owner endon( #"disconnect" );
        activestreakobj notify( #"hash_298330c0418e8851" );
        activestreakobj endon( #"hash_298330c0418e8851" );
        activestreakobj endon( #"hash_35ea742f5dccf4fa" );
        activestreakobj endon( #"death" );
        activestreakobj.useobjsuspended = 1;
        function_376bd9cf8daa8b21( activestreakobj );
        activestreakobj waittill( #"hash_7269af65208e3f69" );
        function_78bf21874602e770( activestreakobj );
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x30156f9c, Offset: 0x53eb
// Size: 0x40
function function_c463ddccb4054cc2( owner )
{
    var_ee1c2107c51265f2 = function_acd01e9515a3b842( owner );
    
    if ( isdefined( var_ee1c2107c51265f2 ) )
    {
        var_ee1c2107c51265f2.useobjsuspended = 0;
        var_ee1c2107c51265f2 notify( #"hash_7269af65208e3f69" );
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xab212c71, Offset: 0x5433
// Size: 0xa5
function function_79acee879fb17c4a( owner, streakname )
{
    if ( !isdefined( owner.var_f71cd0657bc26adf ) )
    {
        return;
    }
    
    foreach ( var_1200d30f73065e57 in owner.var_f71cd0657bc26adf[ streakname ] )
    {
        function_78c6d27f0cc66c06( var_1200d30f73065e57, 0 );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x13508b4d, Offset: 0x54e0
// Size: 0xd3
function private function_f297e0bb7db277c5( useobj )
{
    useobj endon( #"death" );
    focususe = getdvarint( @"hash_c2417142804c1c76", 0 );
    
    if ( !focususe )
    {
        return;
    }
    
    var_fd8c4ce7eca1e005 = "outline_nodepth_useobj_";
    function_aecb3e39b0ad4475( useobj, var_fd8c4ce7eca1e005 + "default" );
    
    while ( true )
    {
        result = useobj utility::waittill_any_return( "useObj_start_highlight", "useObj_stop_highlight" );
        
        if ( result == "useObj_start_highlight" )
        {
            useobj.highlighted = 1;
            function_aecb3e39b0ad4475( useobj, var_fd8c4ce7eca1e005 + "highlight" );
            level childthread function_129dde8a1a0c467( useobj );
            continue;
        }
        
        useobj.highlighted = 0;
        function_aecb3e39b0ad4475( useobj, var_fd8c4ce7eca1e005 + "default" );
    }
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x3c536d82, Offset: 0x55bb
// Size: 0x7c
function private function_aecb3e39b0ad4475( useobj, outlineasset )
{
    function_91c9efd5244cc54a( useobj );
    
    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
    {
        useobj.outlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( useobj.parentent, useobj.owner, outlineasset, "killstreak" );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x416e527e, Offset: 0x563f
// Size: 0x67
function private function_91c9efd5244cc54a( useobj )
{
    if ( isdefined( useobj.outlineid ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( useobj.outlineid, useobj.parentent );
        }
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x181d849c, Offset: 0x56ae
// Size: 0x28
function private function_129dde8a1a0c467( useobj )
{
    while ( function_b1ac3315d378db26( useobj ) )
    {
        waitframe();
    }
    
    useobj notify( #"useObj_stop_highlight" );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xbedc8471, Offset: 0x56de
// Size: 0x2a
function private function_b1ac3315d378db26( useobj )
{
    return useobj.owner worldpointinreticle_circle( useobj.origin, 80, 200 );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xb7bbec20, Offset: 0x5711
// Size: 0x18, Type: bool
function private function_6d9bd39f4b42df95( useobj )
{
    return istrue( useobj.highlighted );
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x5939b5fd, Offset: 0x5732
// Size: 0x8b
function private function_8fd6d96c3946a806( useobj, var_7e9dc92529ec1ac3 )
{
    level endon( #"game_ended" );
    notifylist = [ "death", "explode", "leaving", "crashing", "hacked" ];
    
    if ( isdefined( var_7e9dc92529ec1ac3 ) )
    {
        notifylist = var_7e9dc92529ec1ac3;
    }
    
    result = useobj.parentent utility::waittill_any_in_array_return( notifylist );
    function_78c6d27f0cc66c06( useobj );
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x289b9be9, Offset: 0x57c5
// Size: 0x53
function function_66160ad6f52dcbf5( streakname, owner, useobjid )
{
    useobject = undefined;
    
    if ( isdefined( owner.var_f71cd0657bc26adf[ streakname ][ useobjid ] ) )
    {
        useobject = owner.var_f71cd0657bc26adf[ streakname ][ useobjid ];
    }
    
    return useobject;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7891fe9f, Offset: 0x5821
// Size: 0x11e
function function_e90788a3eb76165b( owner )
{
    if ( !( isdefined( owner ) && isdefined( owner.var_f71cd0657bc26adf ) ) )
    {
        return;
    }
    
    activeuseobj = undefined;
    
    foreach ( var_701a6e8f2c95a76b in owner.var_f71cd0657bc26adf )
    {
        foreach ( useobj in var_701a6e8f2c95a76b )
        {
            if ( useobj.activeuseobject )
            {
                activeuseobj = useobj;
                break;
            }
        }
    }
    
    return activeuseobj;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xcdb9db7e, Offset: 0x5948
// Size: 0x11e
function private function_acd01e9515a3b842( owner )
{
    if ( !( isdefined( owner ) && isdefined( owner.var_f71cd0657bc26adf ) ) )
    {
        return;
    }
    
    suspendeduseobj = undefined;
    
    foreach ( var_701a6e8f2c95a76b in owner.var_f71cd0657bc26adf )
    {
        foreach ( useobj in var_701a6e8f2c95a76b )
        {
            if ( useobj.useobjsuspended )
            {
                suspendeduseobj = useobj;
                break;
            }
        }
    }
    
    return suspendeduseobj;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x50b944f9, Offset: 0x5a6f
// Size: 0x18, Type: bool
function private function_b4d4294dd3f9b65d( useobj )
{
    return istrue( useobj.activeuseobject );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x5ac15d50, Offset: 0x5a90
// Size: 0x40
function private function_e6297e9c110a410b( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    
    if ( isdefined( bundle.linktotag ) )
    {
        return bundle.linktotag;
    }
    
    return "tag_origin";
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x2865a6ff, Offset: 0x5ad9
// Size: 0x235
function private function_78c6d27f0cc66c06( useobj, var_d1498f2ef36609b1 )
{
    if ( isdefined( useobj ) )
    {
        if ( !isdefined( var_d1498f2ef36609b1 ) )
        {
            var_d1498f2ef36609b1 = 1;
        }
        
        function_91c9efd5244cc54a( useobj );
        owner = useobj.owner;
        streakname = useobj.streakname;
        
        if ( isdefined( owner ) )
        {
            foreach ( objid, var_1200d30f73065e57 in owner.var_f71cd0657bc26adf[ streakname ] )
            {
                if ( var_1200d30f73065e57 == useobj )
                {
                    owner.var_f71cd0657bc26adf[ streakname ][ objid ] = undefined;
                }
            }
            
            if ( var_d1498f2ef36609b1 )
            {
                function_376bd9cf8daa8b21( useobj );
                activeobjects = useobj.owner.var_f71cd0657bc26adf;
                
                if ( activeobjects.size > 0 )
                {
                    newuseobj = undefined;
                    
                    foreach ( var_701a6e8f2c95a76b in activeobjects )
                    {
                        foreach ( activeobj in var_701a6e8f2c95a76b )
                        {
                            if ( isdefined( activeobj ) && activeobj.parentent != useobj.parentent )
                            {
                                newuseobj = activeobj;
                                break;
                            }
                        }
                    }
                    
                    if ( isdefined( newuseobj ) )
                    {
                        function_966fa988728dbfbf( newuseobj );
                    }
                }
            }
        }
        
        useobj delete();
    }
}

/#

    // Namespace killstreak_utility
    // Params 0, eflags: 0x4
    // Checksum 0x747e2ba9, Offset: 0x5d16
    // Size: 0x44, Type: dev
    function private function_9792e41d13b5978a()
    {
        self endon( #"death" );
        
        while ( true )
        {
            level thread debug_utility::drawsphere( self.origin, 10, 0.05, ( 0, 1, 0 ) );
            wait 0.05;
        }
    }

#/

// Namespace killstreak_utility
// Params 1
// Checksum 0x6db0df31, Offset: 0x5d62
// Size: 0x22
function function_3244fa2d2d2dac67( streakname )
{
    return level.streakglobals.var_9e0ca257f60b78aa[ streakname ];
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xf63aac79, Offset: 0x5d8d
// Size: 0x47
function function_785239235d790099( var_387ef6d4839d0489, var_516be9c5949b966f )
{
    self endon( #"disconnect" );
    
    if ( var_516be9c5949b966f )
    {
        thread function_bc61c67673a39086();
        wait 0.05;
    }
    
    if ( !isdefined( var_387ef6d4839d0489 ) )
    {
        var_387ef6d4839d0489 = "80_instant_noscale";
    }
    
    self lerpfovbypreset( var_387ef6d4839d0489 );
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x8ed10f09, Offset: 0x5ddc
// Size: 0x4a
function private function_bc61c67673a39086()
{
    self endon( #"disconnect" );
    self notify( #"hash_7a9ec5cbfb906624" );
    self endon( #"hash_7a9ec5cbfb906624" );
    self lerpfovscalefactor( 0, 0 );
    level waittill( #"start_game_ended" );
    function_f1c03b279632ba1e();
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x5b9bf4b0, Offset: 0x5e2e
// Size: 0x2a
function function_f1c03b279632ba1e()
{
    self notify( #"hash_7a9ec5cbfb906624" );
    thread function_785239235d790099( "default" );
    self lerpfovscalefactor( 1, 0 );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xcf24f34d, Offset: 0x5e60
// Size: 0x14
function function_f943c0602acdc2af( streakname )
{
    return killstreak::function_85b2d8e857ab4898( streakname );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xe4777bfc, Offset: 0x5e7d
// Size: 0x2c
function function_87741a4d2a352cec( streakname )
{
    return level.streakglobals.streakbundles[ streakname ].var_d80db24c90d421fb;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xfe5caed3, Offset: 0x5eb2
// Size: 0x3c
function function_b6b11f0a43228153( weaponobj )
{
    var_fe5c2d510475007e = killstreak::getkillstreaknamefromweapon( weaponobj );
    
    if ( !isdefined( var_fe5c2d510475007e ) )
    {
        return;
    }
    
    bundle = function_f943c0602acdc2af( var_fe5c2d510475007e );
    return bundle;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7581477d, Offset: 0x5ef7
// Size: 0x37
function function_9ce4d95fd9ec1228( weaponobj )
{
    bundle = function_b6b11f0a43228153( weaponobj );
    bundlehash = bundle.var_d80db24c90d421fb;
    return bundlehash;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x2a26d777, Offset: 0x5f37
// Size: 0x6d
function function_e88d91359aa0273()
{
    if ( level.nukecost )
    {
        return level.nukecost;
    }
    
    nukeref = level.gamemodebundle.nukeref ?? "nuke";
    nukebundle = function_f943c0602acdc2af( nukeref );
    nukecost = nukebundle.kills ?? 30;
    return nukecost;
}

// Namespace killstreak_utility
// Params 5
// Checksum 0xcce64ab9, Offset: 0x5fad
// Size: 0x186
function function_6348c97b79ee8a08( vehicle, owner, cleanupfunc, teleportvehicle, var_bbebaab60c4232ef )
{
    if ( !isdefined( vehicle ) )
    {
        /#
            iprintln( "<dev string:x4a2>" );
        #/
        
        return;
    }
    
    vehicle function_9b17524926263186( 0 );
    
    if ( var_bbebaab60c4232ef )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        owner endon( #"disconnect" );
    }
    
    vehicle endon( #"death" );
    vehicle endon( #"explode" );
    level endon( #"game_ended" );
    
    if ( !isdefined( cleanupfunc ) )
    {
        /#
            iprintln( "<dev string:x506>" );
        #/
        
        return;
    }
    
    /#
        debugteleport = getdvarint( @"hash_5fbef6e1f0b6624c", 0 );
        
        if ( debugteleport )
        {
            teleportvehicle = 1;
        }
    #/
    
    var_1ed880df52e3f6df = spawnstruct();
    var_1ed880df52e3f6df.cleanupfunc = cleanupfunc;
    var_1ed880df52e3f6df.failurefunc = &function_b2e790ef833c55d;
    var_1ed880df52e3f6df.tryteleport = istrue( teleportvehicle );
    vehicle.var_1ed880df52e3f6df = var_1ed880df52e3f6df;
    
    /#
        while ( true )
        {
            var_74cee9fb24b4e9a0 = getdvarint( @"hash_873b7ff40bb2a37e", 0 );
            
            if ( var_74cee9fb24b4e9a0 > 0 )
            {
                unstablevehiclelist = [ vehicle ];
                level notify( #"vehicle_integrity_failure", unstablevehiclelist );
                
                if ( var_74cee9fb24b4e9a0 == 1 )
                {
                    setdvar( @"hash_873b7ff40bb2a37e", 0 );
                    wait 1;
                }
                else
                {
                    wait 5;
                }
                
                vehicle.var_fd6626d450940184 = undefined;
            }
            
            waitframe();
        }
    #/
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x385ce9f1, Offset: 0x613b
// Size: 0xce
function private function_b2e790ef833c55d( reason )
{
    self endon( #"death" );
    self endon( #"explode" );
    level endon( #"game_ended" );
    
    if ( self.var_fd6626d450940184 )
    {
        return;
    }
    
    self.var_fd6626d450940184 = 1;
    killstreakintegrity = self.var_1ed880df52e3f6df;
    
    if ( self.iscrashing || self.isleaving )
    {
        self thread [[ killstreakintegrity.cleanupfunc ]]();
        return;
    }
    
    if ( !killstreakintegrity.tryteleport )
    {
        return;
    }
    
    result = function_1d2842e51535da95( self, 500 );
    
    if ( !result )
    {
        /#
            iprintln( "<dev string:x555>" );
        #/
        
        self thread [[ killstreakintegrity.cleanupfunc ]]();
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x805782dc, Offset: 0x6211
// Size: 0xda
function function_cb23708aacf1bcc9( vehicle, var_2b1659fc7a1fc9cb )
{
    if ( game_utility::islargemap() )
    {
        return;
    }
    
    if ( isdefined( vehicle.owner ) )
    {
        vehicle.owner endon( #"disconnect" );
    }
    
    vehicle endon( #"death" );
    vehicle endon( #"explode" );
    level endon( #"game_ended" );
    outofbounds::registerentforoob( vehicle, "killstreak" );
    
    if ( isdefined( var_2b1659fc7a1fc9cb ) )
    {
        vehicle.var_2b1659fc7a1fc9cb = var_2b1659fc7a1fc9cb;
    }
    
    airstrikeheight = getkillstreakairstrikeheightent();
    var_79e4024dba760173 = 3000;
    var_a2177e7c02c96665 = level.mapcenter ?? ( 0, 0, 0 );
    level childthread function_6f0c3bb423882c9d( vehicle, var_79e4024dba760173, var_a2177e7c02c96665 );
}

// Namespace killstreak_utility
// Params 3, eflags: 0x4
// Checksum 0xeed3ed03, Offset: 0x62f3
// Size: 0x130
function private function_6f0c3bb423882c9d( vehicle, var_79e4024dba760173, var_a2177e7c02c96665 )
{
    vehicle endon( #"death" );
    vehicle endon( #"crashing" );
    var_310eb32985bd2183 = var_79e4024dba760173 * var_79e4024dba760173;
    
    /#
        setdvarifuninitialized( @"hash_567cc0058f47dbf", var_79e4024dba760173 );
    #/
    
    oobtrigger = level.outofboundstriggers[ 0 ];
    
    if ( !isdefined( oobtrigger ) )
    {
        /#
            iprintlnbold( "<dev string:x5aa>" );
        #/
        
        return;
    }
    
    while ( true )
    {
        /#
            override = getdvarint( @"hash_567cc0058f47dbf", var_79e4024dba760173 );
            
            if ( override != var_79e4024dba760173 )
            {
                var_310eb32985bd2183 = override * override;
            }
        #/
        
        var_57a2c5156d9e151f = distance2dsquared( vehicle.origin, var_a2177e7c02c96665 );
        
        if ( var_57a2c5156d9e151f >= var_310eb32985bd2183 )
        {
            if ( !vehicle.var_4dcb2fffc1cc639f )
            {
                vehicle.var_65c6b1940f2e9d1f = undefined;
                vehicle.var_4dcb2fffc1cc639f = 1;
            }
        }
        else if ( vehicle.var_4dcb2fffc1cc639f )
        {
            vehicle.var_65c6b1940f2e9d1f = 1;
            vehicle.var_4dcb2fffc1cc639f = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xcbe77239, Offset: 0x642b
// Size: 0x24e
function function_1d2842e51535da95( vehicle, distanceoffset )
{
    vehicle endon( #"death" );
    vehicle endon( #"explode" );
    vehicle endon( #"leaving" );
    vehicle endon( #"crashing" );
    level endon( #"game_ended" );
    vehicleorigin = vehicle.origin;
    forward = anglestoforward( vehicle.angles );
    right = anglestoright( vehicle.angles );
    up = anglestoup( vehicle.angles );
    contents = trace::create_default_contents( 1 );
    ignore = vehicle;
    locationchecks = [ vehicleorigin + forward * distanceoffset, vehicleorigin - forward * distanceoffset, vehicleorigin + right * distanceoffset, vehicleorigin - right * distanceoffset, vehicleorigin + up * distanceoffset, vehicleorigin - up * distanceoffset, vehicleorigin + 0.707 * ( forward + right ) * distanceoffset, vehicleorigin + 0.707 * ( forward - right ) * distanceoffset, vehicleorigin + 0.707 * ( right - forward ) * distanceoffset, vehicleorigin + 0.707 * ( -1 * forward - right ) * distanceoffset ];
    var_81ddafb4f0b7e910 = 0;
    
    foreach ( potentiallocation in locationchecks )
    {
        if ( trace::sphere_trace_passed( vehicleorigin, potentiallocation, 300, ignore, contents ) )
        {
            /#
                level thread debug_utility::drawline( vehicleorigin, potentiallocation, 30, ( 0, 1, 0 ) );
                level thread debug_utility::drawsphere( potentiallocation, 25, 30, ( 0, 1, 0 ) );
            #/
            
            vehicle vehicle_teleport( potentiallocation, vehicle.angles );
            var_81ddafb4f0b7e910 = 1;
            break;
        }
        
        wait 0.05;
    }
    
    return var_81ddafb4f0b7e910;
}

// Namespace killstreak_utility
// Params 9
// Checksum 0x1bf55bc8, Offset: 0x6682
// Size: 0x496
function killstreak_vehicle_create( owner, streakinfo, spawnloc, spawnangles, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, removefunc, spawndata )
{
    streakname = streakinfo.streakname;
    bundle = function_f943c0602acdc2af( streakname );
    
    if ( isdefined( bundle ) && isdefined( streakinfo ) && isdefined( streakinfo.mpstreaksysteminfo ) && isdefined( streakinfo.mpstreaksysteminfo.blueprintindex ) )
    {
        bundle = function_9e9b7aee0666a23f( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    }
    
    if ( !isdefined( spawndata ) )
    {
        spawndata = spawnstruct();
    }
    
    spawndata.origin = spawnloc;
    spawndata.angles = spawnangles ?? owner.angles;
    spawndata.team = owner.team;
    spawndata.modelname = bundle.modelbase;
    spawndata vehicle_spawn::prevent_respawn();
    vehicle = undefined;
    
    if ( bundle.commonvehiclespawn )
    {
        if ( vehicle::has_data( getxhashasset( bundle.deployedvehicle ) ) )
        {
            data = vehicle::get_data( getxhashasset( bundle.deployedvehicle ) );
            
            if ( data.damage.ignoreoob )
            {
                spawndata vehicle_spawn::set_flag( 11 );
            }
        }
        
        vehicle = vehicle::spawn( getxhashasset( bundle.deployedvehicle ), spawndata );
    }
    else if ( isdefined( bundle.deployedvehiclebundle ) )
    {
        if ( bundle.deployedvehiclebundle.damage.ignoreoob )
        {
            spawndata vehicle_spawn::set_flag( 11 );
        }
        
        vehicle = vehicle::spawn( function_9f067a51fb15854( bundle.deployedvehiclebundle ), spawndata );
    }
    else
    {
        spawndata.targetname = streakname;
        spawndata.vehicletype = bundle.deployedvehicle;
        faildata = spawnstruct();
        vehicle = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    if ( isdefined( bundle.maxhealth ) )
    {
        vehicle.maxhealth = bundle.maxhealth;
        vehicle.health = bundle.maxhealth;
    }
    
    if ( !isdefined( vehicle.owner ) )
    {
        vehicle.owner = owner;
    }
    
    if ( !isdefined( vehicle.team ) )
    {
        vehicle.team = owner.team;
    }
    
    if ( !isdefined( vehicle.vehiclename ) )
    {
        vehicle.vehiclename = function_9f067a51fb15854( spawndata.vehicletype );
    }
    
    vehicle.streakinfo = streakinfo;
    vehicle.tanktype = streakname;
    vehicle.lifetime = bundle.lifetime;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            vehicle.lifetime = 9999;
        }
    #/
    
    vehicle_damage::function_f22ce6c0cf2d903b( vehicle );
    level thread function_6348c97b79ee8a08( vehicle, vehicle.owner, deathfunc );
    vehicle = function_f2dcf053ee32cbbe( vehicle );
    weapon_utility::setlockedoncallback( vehicle, &function_2ac36ce174f455a8 );
    weapon_utility::setlockedonremovedcallback( vehicle, &function_abd7943686667b46 );
    vehicle sentientpoolmanager::registersentient( "Killstreak_Ground", vehicle.owner );
    spawnlogic::addspawnviewer( vehicle );
    
    if ( bundle.isground )
    {
        vehicle.maxspeedforward = vehicle vehicle_gettopspeedforward();
        vehicle.maxspeedreverse = vehicle vehicle_gettopspeedreverse();
        data = spawnstruct();
        data.deathoverridecallback = &function_b1d001969b8b03dd;
        vehicle thread movers::handle_moving_platforms( data );
    }
    
    vehicle.childoutlineents = [ vehicle ];
    function_e35e972766437006( vehicle, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, removefunc );
    
    if ( bundle.var_c56b0231474b9c98 )
    {
        outofbounds::registerentforoob( vehicle, "killstreak" );
    }
    
    function_2e83aa2265513a59( vehicle );
    function_2e83aa2265513a59( vehicle, 1 );
    function_f470ce74ddcc91b9( vehicle );
    function_6930484c5bb41ed4( vehicle );
    return vehicle;
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x47289a8a, Offset: 0x6b21
// Size: 0xf4
function private function_9e9b7aee0666a23f( bundle, blueprintindex )
{
    genericblueprintname = undefined;
    
    if ( bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0 )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
    }
    else if ( isdefined( bundle.genericblueprintlist.blueprint_default ) )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprint_default;
    }
    
    deployedmodel = bundle.var_e0230db751877a59 ?? bundle.var_b10905350747afcc;
    
    if ( isdefined( genericblueprintname ) )
    {
        deployedmodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"xcompositemodel" );
    }
    
    bundle.modelbase = deployedmodel;
    return bundle;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xeb4eed23, Offset: 0x6c1e
// Size: 0xbf
function private function_9f067a51fb15854( var_f518fe9aba9af002 )
{
    var_822ee5de03b7b5e = undefined;
    vehicletok = strtok( var_f518fe9aba9af002, "_" );
    
    foreach ( token in vehicletok )
    {
        if ( token == "mp" )
        {
            break;
        }
        
        if ( isdefined( var_822ee5de03b7b5e ) )
        {
            var_822ee5de03b7b5e = var_822ee5de03b7b5e + "_" + token;
            continue;
        }
        
        var_822ee5de03b7b5e = token;
    }
    
    return var_822ee5de03b7b5e;
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0xc7fe717c, Offset: 0x6ce6
// Size: 0x38
function private function_2ac36ce174f455a8()
{
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( var_deb596d315f498c8 )
    {
        return;
    }
    
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0xc48ad32e, Offset: 0x6d26
// Size: 0x38
function private function_abd7943686667b46()
{
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( var_deb596d315f498c8 )
    {
        return;
    }
    
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace killstreak_utility
// Params 5, eflags: 0x4
// Checksum 0xd0482bf7, Offset: 0x6d66
// Size: 0x1b3
function private function_e35e972766437006( vehicle, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, removefunc )
{
    streakname = vehicle.streakinfo.streakname;
    bundle = function_f943c0602acdc2af( streakname );
    vehicleref = streakname;
    
    if ( bundle.commonvehiclespawn )
    {
        vehicleref = getxhashasset( bundle.deployedvehicle );
    }
    else if ( isdefined( bundle.deployedvehiclebundle ) )
    {
        vehicleref = function_9f067a51fb15854( bundle.deployedvehiclebundle );
        
        if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
        {
            if ( level.projectbundle.var_53c4124af039142e )
            {
                if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
                {
                    vehicleref = vehicle::get_data( vehicleref ).vehicle;
                }
            }
            else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).bundlename;
            }
        }
    }
    
    function_534056f647761135( vehicle, vehicleref, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, removefunc );
    vehicle function_b555369eba6b0252( 1, int( vehicle.health * 0.75 ), &function_3b845e11f35506b6 );
    vehicle function_b555369eba6b0252( 2, int( vehicle.health * 0.5 ), &function_7596666d132298b3 );
    vehicle function_b555369eba6b0252( 3, int( vehicle.health * 0.25 ), &function_f96369ec86baca83 );
}

// Namespace killstreak_utility
// Params 6, eflags: 0x4
// Checksum 0x68c61e5a, Offset: 0x6f21
// Size: 0x8f
function private function_534056f647761135( vehicle, vehicleref, var_a213b0eb2076a1e7, var_65354c0b7473812, deathfunc, removefunc )
{
    var_a213b0eb2076a1e7 = var_a213b0eb2076a1e7 ?? &function_eb06ce1c34e659a;
    var_65354c0b7473812 = var_65354c0b7473812 ?? &function_1dc97336abb7f983;
    deathfunc = deathfunc ?? &killstreak_vehicle_death;
    vehicle_damage::set_pre_mod_damage_callback( vehicleref, var_a213b0eb2076a1e7 );
    vehicle_damage::set_post_mod_damage_callback( vehicleref, var_65354c0b7473812 );
    vehicle_damage::set_death_callback( vehicleref, deathfunc );
    
    if ( isdefined( removefunc ) )
    {
        vehicle.killstreak_remove_callback = removefunc;
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xa66004e6, Offset: 0x6fb8
// Size: 0x3a, Type: bool
function private function_eb06ce1c34e659a( data )
{
    damage = data.damage;
    attacker = data.attacker;
    return true;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x17b15733, Offset: 0x6ffb
// Size: 0xa2, Type: bool
function private function_1dc97336abb7f983( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    newhealth = self.health - damage;
    
    if ( newhealth <= 0 )
    {
        newhealth = 0;
    }
    
    killstreak_updatedamagestate( newhealth );
    return true;
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0xed57bea7, Offset: 0x70a6
// Size: 0x40
function private function_3b845e11f35506b6()
{
    if ( self getscriptablehaspart( "body_damage_light" ) )
    {
        self setscriptablepartstate( "body_damage_light", "on" );
        return;
    }
    
    if ( self getscriptablehaspart( "damageLight" ) )
    {
        self setscriptablepartstate( "damageLight", "lowSpeed", 0 );
    }
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0x6cf86dbf, Offset: 0x70ee
// Size: 0x51
function private function_7596666d132298b3()
{
    if ( self getscriptablehaspart( "body_damage_medium" ) )
    {
        self setscriptablepartstate( "body_damage_medium", "on" );
        return;
    }
    
    if ( self getscriptablehaspart( "damageMedium" ) )
    {
        self setscriptablepartstate( "damageLight", "off", 0 );
        self setscriptablepartstate( "damageMedium", "lowSpeed", 0 );
    }
}

// Namespace killstreak_utility
// Params 0, eflags: 0x4
// Checksum 0xa99005e9, Offset: 0x7147
// Size: 0x51
function private function_f96369ec86baca83()
{
    if ( self getscriptablehaspart( "body_damage_heavy" ) )
    {
        self setscriptablepartstate( "body_damage_heavy", "on" );
        return;
    }
    
    if ( self getscriptablehaspart( "damageHeavy" ) )
    {
        self setscriptablepartstate( "damageMedium", "off", 0 );
        self setscriptablepartstate( "damageHeavy", "lowSpeed", 0 );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xf17027ac, Offset: 0x71a0
// Size: 0xbf
function private killstreak_vehicle_death( data )
{
    if ( !isdefined( scorepopup ) )
    {
        scorepopup = "destroyed_" + self.streakname;
    }
    
    if ( !isdefined( vodestroyed ) )
    {
        vodestroyed = "destroyed_" + self.streakname;
    }
    
    if ( !isdefined( destroyedsplash ) )
    {
        destroyedsplash = "callout_destroyed_" + self.streakname;
    }
    
    skipdeathnotify = 1;
    damage::onkillstreakkilled( self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, scorepopup, vodestroyed, destroyedsplash, skipdeathnotify );
    thread killstreak_vehicle_destroy( data );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xa72afdb6, Offset: 0x7267
// Size: 0x29
function private killstreak_vehicle_destroy( data )
{
    if ( self.isdying )
    {
        return;
    }
    
    killstreak_vehicle_explode( self );
    killstreak_vehicle_remove( self );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xb53e59f6, Offset: 0x7298
// Size: 0x34
function private killstreak_vehicle_explode( vehicle )
{
    vehicle notify( #"explode" );
    vehicle.isdying = 1;
    vehicle stoploopsound();
    wait 0.25;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x67a51a54, Offset: 0x72d4
// Size: 0xa6
function private killstreak_vehicle_remove( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        assertmsg( "<dev string:x600>" );
        return;
    }
    
    if ( isdefined( vehicle.killstreak_remove_callback ) )
    {
        [[ vehicle.killstreak_remove_callback ]]( vehicle );
    }
    
    bundle = function_f943c0602acdc2af( vehicle.streakinfo.streakname );
    
    if ( bundle.commonvehiclespawn || isdefined( bundle.deployedvehiclebundle ) )
    {
        vehicle::death( vehicle );
        return;
    }
    
    vehicle_tracking::deregister_instance( vehicle );
    vehicle_tracking::delete_vehicle( vehicle );
}

// Namespace killstreak_utility
// Params 4, eflags: 0x4
// Checksum 0x5721eace, Offset: 0x7382
// Size: 0xa7
function private function_2e83aa2265513a59( vehicle, var_9b55f122c8a2773a, empstartedfunc, empclearedfunc )
{
    if ( var_9b55f122c8a2773a )
    {
        empstartedfunc = empstartedfunc ?? &function_f6048e02b636cb29;
        empclearedfunc = empclearedfunc ?? &function_b1a7349b0cfb6870;
        
        if ( level.killstreak_emp_initialized )
        {
            vehicle.ksempapplycallback = empstartedfunc;
        }
        
        if ( level.killstreak_emp_initialized )
        {
            vehicle.ksempclearcallback = empclearedfunc;
        }
        
        return;
    }
    
    empstartedfunc = empstartedfunc ?? &function_a5fb01db9d8bcb7b;
    empclearedfunc = empclearedfunc ?? &function_56db887ad49dba;
    vehicle emp_debuff::set_start_emp_callback( empstartedfunc );
    vehicle emp_debuff::set_clear_emp_callback( empclearedfunc );
}

// Namespace killstreak_utility
// Params 3, eflags: 0x4
// Checksum 0x9763cd87, Offset: 0x7431
// Size: 0x4a
function private function_f470ce74ddcc91b9( vehicle, var_c7162a234b4bdf, var_231d00ef6afb7e42 )
{
    var_c7162a234b4bdf = var_c7162a234b4bdf ?? &function_d96ed94df9a6001b;
    var_231d00ef6afb7e42 = var_231d00ef6afb7e42 ?? &function_7ae19c59351a925a;
    vehicle chaff_debuff::function_4118b0299dc40ea( var_c7162a234b4bdf );
    vehicle chaff_debuff::function_324dd42a2703bc25( var_231d00ef6afb7e42 );
}

// Namespace killstreak_utility
// Params 3, eflags: 0x4
// Checksum 0xd28f38d6, Offset: 0x7483
// Size: 0x4a
function private function_6930484c5bb41ed4( vehicle, haywirestartfunc, var_38f7e81e0feb0e09 )
{
    haywirestartfunc = haywirestartfunc ?? &function_9718c8dc1d5c023c;
    var_38f7e81e0feb0e09 = var_38f7e81e0feb0e09 ?? &function_bfb55add1ef9758d;
    vehicle haywire::function_7f69a1eb3d590f76( haywirestartfunc );
    vehicle haywire::function_d7496c23fe4085d4( var_38f7e81e0feb0e09 );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xa0f5bc81, Offset: 0x74d5
// Size: 0x2a
function private function_a5fb01db9d8bcb7b( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    function_3cd56be406a3386c( 1 );
    self vehicle_turnengineoff();
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x4e10be39, Offset: 0x7507
// Size: 0x15
function private function_f6048e02b636cb29( data )
{
    function_a5fb01db9d8bcb7b( data );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x9c26158a, Offset: 0x7524
// Size: 0x41
function private function_56db887ad49dba( isdeath )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    
    if ( !isdeath )
    {
        function_3cd56be406a3386c( 0 );
    }
    
    self.owner thread emp_debuff::stop_emp_scramble( 5 );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xe3e34d43, Offset: 0x756d
// Size: 0x13
function private function_b1a7349b0cfb6870( data )
{
    function_56db887ad49dba();
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xb5e048a9, Offset: 0x7588
// Size: 0x4c
function private function_d96ed94df9a6001b( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    function_3cd56be406a3386c( 1 );
    self vehicle_turnengineoff();
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread chaff_debuff::function_f966e23bd8f1adb5( 5 );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x6d918aa5, Offset: 0x75dc
// Size: 0x41
function private function_7ae19c59351a925a( isdeath )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    
    if ( !isdeath )
    {
        function_3cd56be406a3386c( 0 );
    }
    
    self.owner thread chaff_debuff::function_c1fa63136ba5a433( 5 );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xbb091420, Offset: 0x7625
// Size: 0x8a
function private function_9718c8dc1d5c023c( data )
{
    remotetank = data.victim;
    
    if ( !isdefined( remotetank.owner ) || remotetank.ishaywire )
    {
        return;
    }
    
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        vehicle_omnvar::show_warning( "shockStickAttached", remotetank.owner, remotetank vehicle::get_ref() );
    }
    
    remotetank.ishaywire = 1;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x22844356, Offset: 0x76b7
// Size: 0x7a
function private function_bfb55add1ef9758d( data )
{
    remotetank = data.victim;
    
    if ( !isdefined( remotetank.owner ) )
    {
        return;
    }
    
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        vehicle_omnvar::hide_warning( "shockStickAttached", remotetank.owner, remotetank vehicle::get_ref() );
    }
    
    remotetank.ishaywire = 0;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x74a313, Offset: 0x7739
// Size: 0x56
function private function_3cd56be406a3386c( isenabled )
{
    var_deb596d315f498c8 = self hascomponent( "p2p" );
    
    if ( !var_deb596d315f498c8 )
    {
        self.owner player_utility::_freezelookcontrols( isenabled );
        self.owner player_utility::_freezecontrols( isenabled );
    }
    
    function_f9d66a45e0548609( isenabled, var_deb596d315f498c8 );
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0xb83c3f21, Offset: 0x7797
// Size: 0xa1
function private function_f9d66a45e0548609( isenabled, var_deb596d315f498c8 )
{
    if ( !isenabled )
    {
        if ( var_deb596d315f498c8 )
        {
            self setconfigvalue( "p2p", "pause", 1 );
        }
        else
        {
            vehicle_omnvar::show_warning( "movementDisabled", self.owner, vehicle::get_ref() );
            self function_92e333ef50ff2c83( 1 );
            self.veh_throttle = 0;
        }
        
        return;
    }
    
    if ( var_deb596d315f498c8 )
    {
        self setconfigvalue( "p2p", "resume", 1 );
        return;
    }
    
    vehicle_omnvar::hide_warning( "movementDisabled", self.owner, vehicle::get_ref() );
    self function_92e333ef50ff2c83( 0 );
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0x37dc2eb8, Offset: 0x7840
// Size: 0x27
function private function_b1d001969b8b03dd( data )
{
    if ( isdefined( self.deathfunc ) )
    {
        [[ self.deathfunc ]]( data );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xb26409e7, Offset: 0x786f
// Size: 0x22
function private function_f2dcf053ee32cbbe( vehicle )
{
    vehicle setentityhudoutlinedata( 3, vehicle.team );
    return vehicle;
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x1e7f3c4e, Offset: 0x789a
// Size: 0x170, Type: bool
function function_b80f6b1fd6002e2d( attacker, target, ignorelist )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( isarray( ignorelist ) && arraycontains( ignorelist, target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        if ( !target player::isreallyalive() || target.sessionstate != "playing" )
        {
            return false;
        }
        
        if ( target.notarget )
        {
            return false;
        }
        
        if ( target == attacker.owner )
        {
            return false;
        }
        
        if ( !isdefined( target.pers[ "team" ] ) )
        {
            return false;
        }
        
        if ( target.pers[ "team" ] == "spectator" )
        {
            return false;
        }
        
        if ( level.teambased )
        {
            if ( target.pers[ "team" ] == attacker.team )
            {
                return false;
            }
        }
        
        if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
        {
            return false;
        }
    }
    else if ( isagent( target ) )
    {
        if ( !isalive( target ) )
        {
            return false;
        }
        
        if ( isdefined( target.agent_type ) && issubstr( target.agent_type, "civilian" ) )
        {
            return false;
        }
        
        if ( level.teambased )
        {
            if ( target.team == attacker.team )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x282b933d, Offset: 0x7a13
// Size: 0x25f, Type: bool
function function_aff5860402b132d7( friendlyteam )
{
    foreach ( team in level.teamnamelist )
    {
        if ( team == friendlyteam )
        {
            continue;
        }
        
        if ( level.var_f3d1cde89907a07a )
        {
            foreach ( squadindex, squad in level.squaddata[ team ] )
            {
                index = squadindex;
                
                if ( level.uavmodels[ index ].size > 0 )
                {
                    foreach ( uav in level.uavmodels[ index ] )
                    {
                        if ( isdefined( uav.uavtype ) && uav.uavtype != "counter_uav" )
                        {
                            return true;
                        }
                    }
                }
            }
            
            continue;
        }
        
        if ( level.uavmodels[ team ].size > 0 )
        {
            foreach ( uav in level.uavmodels[ team ] )
            {
                if ( isdefined( uav.uavtype ) && uav.uavtype != "counter_uav" )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x1f1d2e98, Offset: 0x7c7b
// Size: 0x52
function function_42e821f8603be9e6( enemy )
{
    if ( uav_bigmap::function_cdd5542320f92744() )
    {
        return ( ( teamhasuav_ignorecuav( self.team ) || uav_bigmap::function_45375faf54fa8ecc( self, enemy ) ) && !enemy helper_drone::function_11513d6fb722aba8() );
    }
    
    return teamhasuav( self.team );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xbfa796ff, Offset: 0x7cd5
// Size: 0x50a, Type: bool
function teamhasuav( team )
{
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == team )
        {
            continue;
        }
        
        if ( isdefined( level.uavmodels ) )
        {
            if ( level.var_f3d1cde89907a07a )
            {
                foreach ( squadindex, squadarray in level.squaddata[ entry ] )
                {
                    index = squadindex;
                    
                    if ( level.uavmodels[ index ].size > 0 )
                    {
                        foreach ( uav in level.uavmodels[ index ] )
                        {
                            if ( !isdefined( uav ) )
                            {
                                continue;
                            }
                            
                            if ( uav.uavtype == "counter_uav" )
                            {
                                return false;
                            }
                        }
                    }
                }
                
                continue;
            }
            
            if ( level.uavmodels[ entry ].size > 0 )
            {
                foreach ( uav in level.uavmodels[ entry ] )
                {
                    if ( !isdefined( uav ) )
                    {
                        continue;
                    }
                    
                    if ( uav.uavtype == "counter_uav" )
                    {
                        return false;
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.uavmodels ) )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            foreach ( squadindex, squadarray in level.squaddata[ team ] )
            {
                index = squadindex;
                
                if ( level.uavmodels[ index ].size > 0 )
                {
                    foreach ( uav in level.uavmodels[ index ] )
                    {
                        if ( !isdefined( uav ) )
                        {
                            continue;
                        }
                        
                        if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                        {
                            return true;
                        }
                    }
                }
            }
        }
        else if ( level.uavmodels[ team ].size > 0 )
        {
            foreach ( uav in level.uavmodels[ team ] )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                {
                    return true;
                }
            }
        }
    }
    
    if ( level.var_d0e77ff44ad01536.size > 0 )
    {
        foreach ( falseflag in level.var_d0e77ff44ad01536 )
        {
            if ( !isdefined( falseflag.owner ) || !isdefined( falseflag.owner.team ) )
            {
                continue;
            }
            
            if ( falseflag.owner.team == team )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x60bc4fd4, Offset: 0x81e8
// Size: 0x3f5, Type: bool
function teamhasuav_ignorecuav( team )
{
    if ( isdefined( level.uavmodels ) )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            foreach ( squadindex, squadarray in level.squaddata[ team ] )
            {
                index = squadindex;
                
                if ( level.uavmodels[ index ].size > 0 )
                {
                    foreach ( uav in level.uavmodels[ index ] )
                    {
                        if ( !isdefined( uav ) )
                        {
                            continue;
                        }
                        
                        if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                        {
                            return true;
                        }
                    }
                }
            }
        }
        else if ( level.uavmodels[ team ].size > 0 )
        {
            foreach ( uav in level.uavmodels[ team ] )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                {
                    return true;
                }
            }
        }
    }
    
    if ( isdefined( level.var_9f462aa58e87d9c9 ) )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            foreach ( squadindex, squadarray in level.squaddata[ team ] )
            {
                index = squadindex;
                
                if ( level.var_9f462aa58e87d9c9[ index ].size > 0 )
                {
                    foreach ( uav in level.var_9f462aa58e87d9c9[ index ] )
                    {
                        if ( !isdefined( uav ) )
                        {
                            continue;
                        }
                        
                        if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                        {
                            return true;
                        }
                    }
                }
            }
        }
        else if ( level.var_9f462aa58e87d9c9[ team ].size > 0 )
        {
            foreach ( uav in level.var_9f462aa58e87d9c9[ team ] )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x38a1390, Offset: 0x85e6
// Size: 0xc4, Type: bool
function enemyhascuav( team )
{
    if ( level.supportdrones.size > 0 )
    {
        foreach ( drone in level.supportdrones )
        {
            if ( level.teambased && drone.team == team )
            {
                continue;
            }
            
            if ( drone.helperdronetype == "scrambler_drone_guard" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xe782b351, Offset: 0x86b3
// Size: 0x4a, Type: bool
function isuavactiveforteam( team, squadindex )
{
    index = squadindex ?? team;
    
    if ( !isdefined( level.uavmodels[ index ] ) )
    {
        return false;
    }
    
    return level.uavmodels[ index ].size > 0;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xc38e8154, Offset: 0x8706
// Size: 0xe3, Type: bool
function function_479014a0a76bf3f7( team, squadindex )
{
    index = squadindex ?? team;
    
    if ( !isdefined( level.uavmodels[ index ] ) )
    {
        return false;
    }
    
    foreach ( uav in level.uavmodels[ index ] )
    {
        if ( !isdefined( uav ) )
        {
            continue;
        }
        
        if ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x47b640c3, Offset: 0x87f2
// Size: 0x227
function getkillstreakdeployweapon( streakname )
{
    deployweapon = undefined;
    
    switch ( streakname )
    {
        case #"hash_2289ec11d77bce8f":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
            deployweapon = "deploy_airdrop_mp";
            break;
        case #"hash_4ad475e6e15635bd":
        case #"hash_e65b15f734e5ab84":
            deployweapon = "deploy_juggernaut_mp";
            break;
        case #"hash_9e36e3bd3a9dd00d":
            deployweapon = "ks_assault_drone_mp";
            break;
        case #"hash_691f39dddd9116b8":
        case #"hash_c03ed6f6f4fe9dad":
        case #"hash_e1c89484d98f3ec7":
        case #"hash_e477c24ee18bb2f6":
        case #"hash_f64c697bfb4c6b54":
            deployweapon = "ks_gesture_generic_mp";
            break;
        case #"hash_27002778019fb447":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
            deployweapon = "ks_gesture_phone_mp";
            break;
        case #"hash_b4ac3581c343a029":
            deployweapon = "iw9_laser_large_ir_mp";
            break;
        case #"hash_8c766d6477287bb6":
            deployweapon = "iw9_spotter_scope_mp";
            break;
        case #"hash_28d0236400e33fd0":
        case #"hash_349713b5ad494dda":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_6362d6aae3e5a62e":
        case #"hash_c45eaeb429cf1944":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_ed469a6bfff6b265":
            deployweapon = "ks_remote_device_mp";
            break;
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_4220be38a5f150b8":
        case #"hash_a1031216158c7882":
        case #"hash_b161e185f1b8e117":
        case #"hash_e6bea339d3cbd3e8":
            deployweapon = "ks_remote_map_mp";
            break;
        case #"hash_52d9b7ed584bec3e":
            deployweapon = "deploy_manual_turret_mp";
            break;
        case #"hash_4d5aa76e8707f47b":
            deployweapon = "deploy_sentry_mp";
            break;
        case #"hash_ab5712e297cd430e":
            deployweapon = "deploy_remote_turret_mp";
            break;
        case #"hash_195360490caa3220":
            deployweapon = "ks_remote_nuke_mp";
            break;
    }
    
    return deployweapon;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x982a4498, Offset: 0x8a22
// Size: 0x130
function iskillstreakdeployweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x66c>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon::getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    var_e3d49e7eab9776e9 = 0;
    
    switch ( weaponname )
    {
        case #"hash_14ab8140c657b518":
        case #"hash_1898ea54a0bc6404":
        case #"hash_33c7f389fa9d6dd5":
        case #"hash_348d48446d91aedd":
        case #"hash_405f9521b5ee8402":
        case #"hash_448b7248104bfa9c":
        case #"hash_45e409945333f912":
        case #"hash_7c4413e7cf0adce3":
        case #"hash_807ae3204119bd41":
        case #"hash_879b8ea58093f02c":
        case #"hash_aacdf3a6d5b91585":
        case #"hash_b43c2e4c05fafc4b":
        case #"hash_c280a34cde90f5eb":
        case #"hash_d9266153a899a37c":
        case #"hash_f194befae42e3476":
            var_e3d49e7eab9776e9 = 1;
            break;
    }
    
    return var_e3d49e7eab9776e9;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x2a54865f, Offset: 0x8b5b
// Size: 0x5a
function function_d84b70a08674a174( weaponobj )
{
    var_8086c3a12b7ee8f6 = 0;
    
    if ( !( isdefined( weaponobj ) && isdefined( weaponobj.basename ) ) )
    {
        return var_8086c3a12b7ee8f6;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_b43c2e4c05fafc4b":
            var_8086c3a12b7ee8f6 = 1;
            break;
    }
    
    return var_8086c3a12b7ee8f6;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x11f8ca66, Offset: 0x8bbe
// Size: 0x5a
function function_1b357b025e90e8cc( weaponobj )
{
    var_610e51869032dbf2 = 0;
    
    if ( !( isdefined( weaponobj ) && isdefined( weaponobj.basename ) ) )
    {
        return var_610e51869032dbf2;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_33c7f389fa9d6dd5":
            var_610e51869032dbf2 = 1;
            break;
    }
    
    return var_610e51869032dbf2;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x7e7415a4, Offset: 0x8c21
// Size: 0x66
function function_75333d343673ab1c( weaponobj )
{
    var_3d7c38623597a046 = 0;
    
    if ( !( isdefined( weaponobj ) && isdefined( weaponobj.basename ) ) )
    {
        return var_3d7c38623597a046;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_5f2ad7140f378ee1":
        case #"hash_f194befae42e3476":
            var_3d7c38623597a046 = 1;
            break;
    }
    
    return var_3d7c38623597a046;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xdf220184, Offset: 0x8c90
// Size: 0x66
function iskillstreakgestureweapon( weaponobj )
{
    isgestureweapon = 0;
    
    if ( !( isdefined( weaponobj ) && isdefined( weaponobj.basename ) ) )
    {
        return isgestureweapon;
    }
    
    switch ( weaponobj.basename )
    {
        case #"hash_c280a34cde90f5eb":
        case #"hash_d9266153a899a37c":
            isgestureweapon = 1;
            break;
    }
    
    return isgestureweapon;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xe4316d27, Offset: 0x8cff
// Size: 0x111
function getkillstreakgameweapons( streakname )
{
    ingameweapons = [];
    
    switch ( streakname )
    {
        case #"hash_4ad475e6e15635bd":
            juggbundle = level.streakglobals.streakbundles[ streakname ];
            var_52603d9eb229bc67 = getscriptbundle( juggbundle.juggernautconfig );
            
            if ( var_52603d9eb229bc67 )
            {
                if ( var_52603d9eb229bc67.primaryweapon )
                {
                    ingameweapons[ ingameweapons.size ] = var_52603d9eb229bc67.primaryweapon;
                }
                
                if ( var_52603d9eb229bc67.secondaryweapon )
                {
                    ingameweapons[ ingameweapons.size ] = var_52603d9eb229bc67.secondaryweapon;
                }
            }
            else
            {
                assertmsg( "<dev string:x6a0>" );
            }
            
            break;
        case #"hash_52d9b7ed584bec3e":
            ingameweapons = [ "manual_turret_mp" ];
            break;
        case #"hash_4d5aa76e8707f47b":
            ingameweapons = [ "sentry_turret_mp" ];
            break;
        case #"hash_ab5712e297cd430e":
            ingameweapons = [ "remote_turret_mp" ];
            break;
    }
    
    return ingameweapons;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xa51a51fb, Offset: 0x8e19
// Size: 0xbc
function function_d1858fae8aa00c9( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    highpriorityweapons = [];
    
    foreach ( entry in bundle.var_1d56092e31a23c6b )
    {
        highpriorityweapons[ highpriorityweapons.size ] = entry.weapon;
    }
    
    return highpriorityweapons;
}

// Namespace killstreak_utility
// Params 3
// Checksum 0xbfded027, Offset: 0x8ede
// Size: 0xf8
function getnumactivekillstreakperteam( team, trackinglist, squadindex )
{
    var_e16f9311130733d4 = team;
    numactive = 0;
    
    if ( isdefined( squadindex ) && utility::issharedfuncdefined( #"game", #"hash_7eab975bf2761f59" ) && [[ utility::getsharedfunc( #"game", #"hash_7eab975bf2761f59" ) ]]() )
    {
        var_e16f9311130733d4 = squadindex;
    }
    
    foreach ( killstreakent in trackinglist )
    {
        if ( killstreakent.team == var_e16f9311130733d4 )
        {
            numactive++;
        }
    }
    
    return numactive;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0xa113f639, Offset: 0x8fdf
// Size: 0xdc
function getkillstreakairstrikeheightent()
{
    airstrikeent = undefined;
    dvarheightoverride = getdvarint( @"hash_f9fb0f40bb53d30d", 0 );
    
    if ( isdefined( game_utility::getlocaleid() ) )
    {
        airstrikeent = game_utility::getlocaleent( "airstrikeheight" );
        
        if ( dvarheightoverride != 0 )
        {
            airstrikeent.origin = ( airstrikeent.origin[ 0 ], airstrikeent.origin[ 1 ], dvarheightoverride );
        }
        
        return airstrikeent;
    }
    
    airstrikeheights = getentarray( "airstrikeheight", #targetname );
    
    if ( airstrikeheights.size > 1 )
    {
        /#
            iprintlnbold( "<dev string:x706>" );
        #/
    }
    
    airstrikeent = airstrikeheights[ 0 ];
    
    if ( dvarheightoverride != 0 )
    {
        airstrikeent.origin = ( airstrikeent.origin[ 0 ], airstrikeent.origin[ 1 ], dvarheightoverride );
    }
    
    return airstrikeent;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xe1278986, Offset: 0x90c4
// Size: 0xc7
function getkillstreakmovespeedscale( weaponobject )
{
    speedscale = 1;
    
    if ( isdefined( weaponobject ) )
    {
        switch ( weaponobject.basename )
        {
            case #"hash_1898ea54a0bc6404":
            case #"hash_879b8ea58093f02c":
                speedscale = 0.78;
                break;
            case #"hash_f4d2562ef860c1c0":
                speedscale = 0.87;
                break;
            case #"hash_448b7248104bfa9c":
                speedscale = 0.91;
                break;
            default:
                baseweaponname = weapon::function_170e300815e9c1a2( weaponobject );
                speedscale = level.weaponmapdata[ baseweaponname ].speed ?? 1;
                break;
        }
    }
    
    return speedscale;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x944503d8, Offset: 0x9194
// Size: 0xb1
function restorekillstreakplayerangles( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !player player::isreallyalive() )
    {
        return;
    }
    
    restorepitch = 0;
    restoreroll = 0;
    wait 0.05;
    var_2f9e1349ec2a4b90 = player getplayerangles();
    restoreyaw = var_2f9e1349ec2a4b90[ 1 ];
    
    if ( isdefined( player.restoreangles ) && !player_utility::function_c0192d3e90f65e0e( player ) )
    {
        restoreyaw = player.restoreangles[ 1 ];
    }
    
    player setplayerangles( ( restorepitch, restoreyaw, restoreroll ) );
    player.restoreangles = undefined;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5ff61a19, Offset: 0x924d
// Size: 0x4a
function recordkillstreakendstats( streakinfo )
{
    if ( !isdefined( streakinfo ) )
    {
        return;
    }
    
    if ( !streakinfo.var_9d9eb4c709bffed9 )
    {
        return;
    }
    
    if ( streakinfo.var_c0a2080fc59d32d4 )
    {
        return;
    }
    
    streakinfo.var_c0a2080fc59d32d4 = 1;
    thread function_58562d9c78c16ac1( streakinfo );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x660fff5c, Offset: 0x929f
// Size: 0x31b
function function_58562d9c78c16ac1( streakinfo )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( streakinfo.mpstreaksysteminfo ) )
    {
        return;
    }
    
    if ( isdefined( streakinfo.var_66b36a56400a5730 ) )
    {
        assertmsg( "<dev string:x7bb>" );
        return;
    }
    else
    {
        streakinfo.var_66b36a56400a5730 = 1;
    }
    
    streakinfo.mpstreaksysteminfo.matchtime = gettime();
    streakinfo.mpstreaksysteminfo.playerpos = self.origin;
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"challenges", #"onkillstreakend" ) )
    {
        streakitem = streakinfo.mpstreaksysteminfo;
        
        if ( isdefined( streakitem ) )
        {
            name = streakitem.streakname;
            totalkills = streakinfo.kills;
            loot_source = streakitem.source;
            [[ utility::getsharedfunc( #"challenges", #"onkillstreakend" ) ]]( self, name, totalkills, loot_source );
        }
    }
    
    if ( !utility::issharedfuncdefined( #"dlog", #"killstreakexpired" ) )
    {
        return;
    }
    
    streakitem = streakinfo.mpstreaksysteminfo;
    
    if ( !isdefined( streakitem ) )
    {
        return;
    }
    
    params = { #var_f088013d20169bf3:streakinfo.bundle.var_f088013d20169bf3 ?? #"none", #source:streakitem.source, #score:streakinfo.score, #destructions:streakinfo.destructions, #debuffassists:streakinfo.debuffassists, #debuffkills:streakinfo.debuffkills, #RESTOCKS:streakinfo.RESTOCKS, #grenadekills:streakinfo.grenadekills, #kills:streakinfo.kills, #hits:streakinfo.hits, #shotsfired:streakinfo.shots_fired, #expiredbydeath:istrue( streakinfo.expiredbydeath ), #playerpos:streakitem.playerpos, #matchtime:streakitem.matchtime, #pickedup:streakitem.isgimme, #streakname:streakitem.streakname, #streakmatchlifeid:streakitem.streakmatchlifeid, #owner:streakitem.owner };
    [[ utility::getsharedfunc( #"dlog", #"killstreakexpired" ) ]]( params );
    callback::callback( "killstreak_end", params );
}

// Namespace killstreak_utility
// Params 0
// Checksum 0xf9117d62, Offset: 0x95c2
// Size: 0x64
function playerkillstreakgetownerlookatignoreents()
{
    ignoreents = undefined;
    
    if ( isdefined( self.vehicle ) )
    {
        ignoreents = [ self.vehicle ];
    }
    else
    {
        groundent = self getgroundentity();
        
        if ( isdefined( groundent ) && groundent.classname == "script_vehicle" )
        {
            ignoreents = [ groundent ];
        }
    }
    
    return ignoreents;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5b5726b2, Offset: 0x962f
// Size: 0x61
function movingplatform_playerlink( player )
{
    if ( getdvarint( @"hash_82ce3832ac5efa6d", 0 ) == 0 )
    {
        return;
    }
    
    movingplatform = player getmovingplatformparent();
    
    if ( isdefined( movingplatform ) && function_1b5a5947da36bea( movingplatform ) )
    {
        player playerlinkto( movingplatform );
        player playerlinkedoffsetenable();
        player.movingplatforment = movingplatform;
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xcef149a, Offset: 0x9698
// Size: 0xb4, Type: bool
function function_1b5a5947da36bea( movingplatform )
{
    if ( utility::is_moving_platform_ent( movingplatform ) )
    {
        return true;
    }
    
    if ( elevator::is_moving_platform_elevator( movingplatform ) )
    {
        return true;
    }
    
    if ( isarray( level.var_707cd2d86c3d9168 ) )
    {
        foreach ( callback in level.var_707cd2d86c3d9168 )
        {
            if ( [[ callback ]]( movingplatform ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x9484455c, Offset: 0x9755
// Size: 0xa6, Type: bool
function function_947e7b15331fd6e3( movingplatform )
{
    if ( utility::is_moving_platform_ent( movingplatform ) )
    {
        return true;
    }
    
    if ( isarray( level.var_7dd6b31a25e077eb ) )
    {
        foreach ( callback in level.var_7dd6b31a25e077eb )
        {
            if ( [[ callback ]]( movingplatform ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x528d70bc, Offset: 0x9804
// Size: 0x2d
function movingplatform_playerunlink( player )
{
    if ( isdefined( player.movingplatforment ) )
    {
        player.movingplatforment = undefined;
        player unlink();
    }
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x72803b7, Offset: 0x9839
// Size: 0x3e
function function_44cbe91072276a84( callback )
{
    if ( !isarray( level.var_707cd2d86c3d9168 ) )
    {
        level.var_707cd2d86c3d9168 = [];
    }
    
    level.var_707cd2d86c3d9168[ level.var_707cd2d86c3d9168.size ] = callback;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x793fe8db, Offset: 0x987f
// Size: 0x3e
function function_dcf4549703176a17( callback )
{
    if ( !isarray( level.var_7dd6b31a25e077eb ) )
    {
        level.var_7dd6b31a25e077eb = [];
    }
    
    level.var_7dd6b31a25e077eb[ level.var_7dd6b31a25e077eb.size ] = callback;
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x95394584, Offset: 0x98c5
// Size: 0x5f
function function_40efaac4d5b5a5b8( slotnumber, failedmessage )
{
    self notify( #"hash_f1308c11d090da70" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_f1308c11d090da70" );
    self setclientomnvar( "ui_killstreak_cannot_be_used", slotnumber );
    waitframe();
    self setclientomnvar( "ui_killstreak_cannot_be_used", 0 );
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xcdc8278d, Offset: 0x992c
// Size: 0xe0
function killstreak_registerminimapinfo( bundle, killstreak_unused, enableping, var_13ecbe20ea1c02d7 )
{
    if ( isdefined( bundle ) && isdefined( bundle.minimapicon ) )
    {
        createfunc = undefined;
        enemyobjid = undefined;
        
        if ( utility::issharedfuncdefined( #"game", #"createobjectiveengineer" ) )
        {
            createfunc = utility::getsharedfunc( #"game", #"createobjectiveengineer" );
        }
        
        if ( isdefined( createfunc ) )
        {
            enemyobjid = self [[ createfunc ]]( bundle.minimapicon, 1, 1, "icon_regular" );
        }
        
        if ( isdefined( enemyobjid ) )
        {
            objidpoolmanager::function_e4d6a71507372662( enemyobjid, 0 );
            
            if ( enableping )
            {
                objective_setpings( enemyobjid, 1 );
                
                if ( var_13ecbe20ea1c02d7 )
                {
                    function_461834c350793158( enemyobjid, 0 );
                }
            }
            
            function_e48b79edd0844c46( enemyobjid );
        }
    }
    
    return enemyobjid;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xce0467da, Offset: 0x9a15
// Size: 0xc7
function function_e48b79edd0844c46( killstreakobjid )
{
    if ( !isdefined( level.var_2a5b98496d5d09a1 ) )
    {
        level.var_2a5b98496d5d09a1 = [];
    }
    
    level.var_2a5b98496d5d09a1[ killstreakobjid ] = self;
    
    foreach ( player in level.var_9b088d39aebb092d )
    {
        if ( player_utility::playersareenemies( player, self.owner ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( killstreakobjid, player );
        }
    }
    
    thread function_a465585550852de9( killstreakobjid );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xcf05d0a0, Offset: 0x9ae4
// Size: 0x22
function function_a465585550852de9( killstreakobjid )
{
    self waittill( #"death" );
    function_42bca17144b9b543( killstreakobjid );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xa6ba6705, Offset: 0x9b0e
// Size: 0x92
function function_42bca17144b9b543( killstreakobjid )
{
    foreach ( player in level.var_9b088d39aebb092d )
    {
        objidpoolmanager::objective_playermask_hidefrom( killstreakobjid, player );
    }
    
    level.var_2a5b98496d5d09a1[ killstreakobjid ] = undefined;
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x80a2e647, Offset: 0x9ba8
// Size: 0x2d
function function_3b33dde6cf9d04b7( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace killstreak_utility
// Params 8
// Checksum 0xcbfd91c9, Offset: 0x9bdd
// Size: 0x103
function function_8ac1515799ff58a5( streakinfo, deployweapon, ignorecancel, var_ab90edc40c0a980b, equipdelaytime, deployanimtime, var_825ad58d5c4b9461, var_834e1ea1f94aef8a )
{
    wait equipdelaytime;
    marker = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"gettargetmarker" ) )
    {
        marker = [[ utility::getsharedfunc( #"killstreak", #"gettargetmarker" ) ]]( streakinfo, ignorecancel, var_825ad58d5c4b9461 );
    }
    
    if ( !isdefined( self ) || !player::isreallyalive() )
    {
        return;
    }
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        killstreak_switchbacklastweapon( deployweapon, undefined, undefined, var_834e1ea1f94aef8a );
        return;
    }
    
    if ( var_ab90edc40c0a980b )
    {
        self freezecontrols( 1 );
    }
    
    if ( self hasweapon( deployweapon ) )
    {
        thread killstreak_switchbacklastweapon( deployweapon, 1, 1, var_834e1ea1f94aef8a );
    }
    
    wait deployanimtime;
    
    if ( var_ab90edc40c0a980b )
    {
        self freezecontrols( 0 );
    }
    
    return marker;
}

// Namespace killstreak_utility
// Params 4
// Checksum 0xb31a7d, Offset: 0x9ce9
// Size: 0xe5
function killstreak_switchbacklastweapon( deployweapon, immediateswitch, optionaltimedelay, var_834e1ea1f94aef8a )
{
    if ( optionaltimedelay > 0 )
    {
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        hostmigration::waittillnotifyortimeoutpause( "equip_deploy_cancel", optionaltimedelay );
    }
    
    if ( !isdefined( var_834e1ea1f94aef8a ) )
    {
        var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
    }
    
    lastweaponobj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, var_834e1ea1f94aef8a );
    
    if ( !isdefined( lastweaponobj ) || !self hasweapon( lastweaponobj ) )
    {
        if ( isdefined( self.lastnormalweaponobj ) )
        {
            lastweaponobj = self.lastnormalweaponobj;
        }
        else
        {
            lastweaponobj = makeweapon( "iw9_fists_mp" );
        }
    }
    
    if ( immediateswitch )
    {
        inventory_utility::_switchtoweaponimmediate( lastweaponobj );
    }
    else
    {
        inventory_utility::_switchtoweapon( lastweaponobj );
    }
    
    inventory_utility::_takeweapon( deployweapon );
}

// Namespace killstreak_utility
// Params 3
// Checksum 0x94e58d00, Offset: 0x9dd6
// Size: 0x177
function function_7aef34478569525d( owner, hinttag, hinttextkey )
{
    hintpos = self gettagorigin( hinttag );
    
    if ( !isdefined( self.useownerobj ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"createhintobject" ) )
        {
            self.useownerobj = [[ utility::getsharedfunc( #"game", #"createhintobject" ) ]]( hintpos, "HINT_BUTTON", undefined, hinttextkey, undefined, undefined, "show" );
        }
    }
    else
    {
        hintpos = self gettagorigin( hinttag );
        self.useownerobj setusableenabled( 1 );
        self.useownerobj dontinterpolate();
        self.useownerobj.origin = hintpos;
    }
    
    foreach ( player in level.players )
    {
        if ( player != owner )
        {
            self.useownerobj disableplayeruse( player );
            continue;
        }
        
        self.useownerobj enableplayeruse( player );
    }
    
    self.useownerobj linkto( self, hinttag );
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x4eeca444, Offset: 0x9f55
// Size: 0x95
function killstreak_watchpickup( streakinfo, onpickupcallback )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.useownerobj waittill( #"trigger", player );
        
        if ( isdefined( player ) && !self.owner killstreak_canpickup( player ) )
        {
            continue;
        }
        
        self.useownerobj setusableenabled( 0 );
        self.owner [[ onpickupcallback ]]( self, streakinfo );
    }
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xc47ddd8b, Offset: 0x9ff2
// Size: 0x68, Type: bool
function private killstreak_canpickup( player )
{
    if ( player != self )
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

// Namespace killstreak_utility
// Params 1
// Checksum 0xcb4e784e, Offset: 0xa063
// Size: 0x72, Type: bool
function is_using_killstreak( b_check_deploy = 0 )
{
    b_active_deploy = 0;
    
    if ( b_check_deploy )
    {
        weapon = self getcurrentweapon();
        
        if ( isdefined( weapon.basename ) )
        {
            b_active_deploy = killstreakdeploy::function_9670f0716ada309b( weapon.basename );
        }
    }
    
    var_ede75c4102fa5c52 = get_using_killstreaks();
    return var_ede75c4102fa5c52.size > 0 || b_active_deploy;
}

// Namespace killstreak_utility
// Params 0
// Checksum 0x757c88ff, Offset: 0xa0de
// Size: 0x14b
function get_using_killstreaks()
{
    var_ede75c4102fa5c52 = [];
    weaponbasename = getweaponbasename( self getcurrentweapon() );
    
    if ( level.killstreakweaponmap[ weaponbasename ] )
    {
        var_ede75c4102fa5c52[ var_ede75c4102fa5c52.size ] = level.killstreakweaponmap[ weaponbasename ];
    }
    
    if ( !isplayer( self ) || !isdefined( level.activekillstreaks ) )
    {
        return var_ede75c4102fa5c52;
    }
    
    if ( isdefined( self.triggeringstreak ) )
    {
        var_ede75c4102fa5c52[ var_ede75c4102fa5c52.size ] = self.triggeringstreak;
    }
    
    if ( !isdefined( level.activekillstreaks ) || level.activekillstreaks.size < 1 )
    {
        return var_ede75c4102fa5c52;
    }
    
    foreach ( killstreak in level.activekillstreaks )
    {
        if ( killstreak.owner != self )
        {
            continue;
        }
        
        if ( !killstreak::isremotekillstreak( killstreak.streakname ) )
        {
            var_ede75c4102fa5c52[ var_ede75c4102fa5c52.size ] = killstreak;
        }
        
        if ( utility::isusingremote() )
        {
            var_ede75c4102fa5c52[ var_ede75c4102fa5c52.size ] = killstreak;
        }
    }
    
    return var_ede75c4102fa5c52;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5ded2ad9, Offset: 0xa232
// Size: 0x1be
function function_e4f54128963e182( var_bda53394c108f2e )
{
    if ( !isdefined( var_bda53394c108f2e ) )
    {
        return;
    }
    
    myteam = self.team;
    enemyplayers = teams::getenemyplayers( myteam, 1 );
    
    if ( !isdefined( self.var_d531dfce96022f1b ) )
    {
        self.var_d531dfce96022f1b = [];
    }
    
    if ( isdefined( self.var_d531dfce96022f1b[ var_bda53394c108f2e ] ) && isdefined( self.var_d531dfce96022f1b[ var_bda53394c108f2e ].secondaryweapons ) )
    {
        foreach ( weaponstring in self.var_d531dfce96022f1b[ var_bda53394c108f2e ].secondaryweapons )
        {
            self.var_d531dfce96022f1b[ weaponstring ] = undefined;
        }
    }
    
    self.var_d531dfce96022f1b[ var_bda53394c108f2e ] = { #secondaryweapons:[], #enemies:[], #isprimaryweapon:1 };
    
    if ( isdefined( enemyplayers ) )
    {
        foreach ( enemy in enemyplayers )
        {
            self.var_d531dfce96022f1b[ var_bda53394c108f2e ].enemies[ enemy getentitynumber() ] = 1;
        }
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0xe6056139, Offset: 0xa3f8
// Size: 0x88
function function_3fcc14f5507d62f4( primaryweaponstring, var_3379e10fc74caea )
{
    if ( !( isdefined( primaryweaponstring ) && isdefined( var_3379e10fc74caea ) ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_d531dfce96022f1b[ primaryweaponstring ] ) )
    {
        return;
    }
    
    self.var_d531dfce96022f1b[ var_3379e10fc74caea ] = { #primaryweaponstring:primaryweaponstring, #isprimaryweapon:0 };
    self.var_d531dfce96022f1b[ primaryweaponstring ].secondaryweapons[ self.var_d531dfce96022f1b[ primaryweaponstring ].secondaryweapons.size ] = var_3379e10fc74caea;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x652d6526, Offset: 0xa488
// Size: 0x43, Type: bool
function getkillstreakwatchforlaststand( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    return istrue( bundle.watchforlaststand );
}

// Namespace killstreak_utility
// Params 4
// Checksum 0x5838e208, Offset: 0xa4d4
// Size: 0x93
function function_95548c33a4ab45f8( dialogref, dialogset, streakname, var_7de9d1e850f0ac6e = #"events" )
{
    streakname = isstring( streakname ) ? getxhash( streakname ) : streakname;
    dialogueentry = dialog_utility::function_51c8a1c4bba55ed2( dialogref, dialogset, streakname, var_7de9d1e850f0ac6e );
    
    if ( !isdefined( dialogueentry ) && #"events" != var_7de9d1e850f0ac6e )
    {
        dialogueentry = dialog_utility::function_51c8a1c4bba55ed2( dialogref, dialogset, streakname, #"events" );
    }
    
    return dialogueentry;
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xb4cd4f5c, Offset: 0xa570
// Size: 0xe3
function function_b5d94c2d60f51b9d( streakname )
{
    bundle = function_f943c0602acdc2af( streakname );
    weaponentries = [];
    
    if ( isdefined( bundle.killstreakweaponentries ) )
    {
        foreach ( weaponentry in bundle.killstreakweaponentries )
        {
            if ( isdefined( weaponentry ) )
            {
                if ( isdefined( weaponentry.var_e2bc8b2314f1db1a ) )
                {
                    weaponentry.var_e2bc8b2314f1db1a = getxhash( weaponentry.var_e2bc8b2314f1db1a );
                }
                
                weaponentries[ weaponentries.size ] = weaponentry;
            }
        }
    }
    
    return weaponentries;
}

// Namespace killstreak_utility
// Params 1, eflags: 0x4
// Checksum 0xa6671033, Offset: 0xa65c
// Size: 0x9d
function private function_66716662e7f512c( array )
{
    var_90521cb0e3b2a40b = "ui_show_killstreak_targeted_warning";
    
    foreach ( e in array )
    {
        if ( e )
        {
            self setclientomnvar( var_90521cb0e3b2a40b, 1 );
            return;
        }
    }
    
    self setclientomnvar( var_90521cb0e3b2a40b, 0 );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x92fca14b, Offset: 0xa701
// Size: 0x49
function function_3e94cbbe710e9a77( streakname )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    self.var_a0063f4a3cefd663 = self.var_a0063f4a3cefd663 ?? [];
    self.var_a0063f4a3cefd663[ streakname ] = 1;
    function_66716662e7f512c( self.var_a0063f4a3cefd663 );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0xba8e8b03, Offset: 0xa752
// Size: 0x48
function function_b3c5f355ab785704( streakname )
{
    if ( !isdefined( self ) || !isdefined( streakname ) || !isdefined( self.var_a0063f4a3cefd663 ) )
    {
        return;
    }
    
    self.var_a0063f4a3cefd663[ streakname ] = 0;
    function_66716662e7f512c( self.var_a0063f4a3cefd663 );
}

// Namespace killstreak_utility
// Params 0
// Checksum 0xca74d240, Offset: 0xa7a2
// Size: 0x52
function killstreak_cancel()
{
    assert( isplayer( self ) );
    assert( level.gametypebundle.var_711e33239e4c9925 );
    self notify( #"killstreak_cancel" );
    self notify( #"equip_deploy_cancel" );
    thread callback::callback( #"killstreak_cancel" );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x66559a26, Offset: 0xa7fc
// Size: 0x4c
function function_7ab4bfe11ada17a( bundle )
{
    profilestart();
    
    if ( bundle.var_8b43cd747014ec7e )
    {
        self preloadcinematicforplayer( bundle.var_8b43cd747014ec7e );
    }
    
    if ( bundle.var_d30c20664d0c31fd )
    {
        self preloadcinematicforplayer( bundle.var_d30c20664d0c31fd );
    }
    
    profilestop();
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x739a9832, Offset: 0xa850
// Size: 0x34
function function_d0d9fe7a213e3bd3( bundle )
{
    function_a482418ca03fc95c( bundle.var_8b43cd747014ec7e, bundle.var_d09f98defa2e28d1, bundle.var_da39d780d31dca03 );
}

// Namespace killstreak_utility
// Params 1
// Checksum 0x5f407792, Offset: 0xa88c
// Size: 0x34
function function_7018f59706013760( bundle )
{
    function_a482418ca03fc95c( bundle.var_d30c20664d0c31fd, bundle.var_d8ddf669bf22ef2a, bundle.var_d914f0a479f09d7c );
}

// Namespace killstreak_utility
// Params 3, eflags: 0x4
// Checksum 0xb59ab367, Offset: 0xa8c8
// Size: 0x89
function private function_a482418ca03fc95c( cinematic, sfx, transitionduration )
{
    if ( !namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        return;
    }
    
    if ( cinematic )
    {
        self playcinematicforplayer( cinematic );
    }
    
    if ( sfx )
    {
        self playlocalsound( sfx );
        transitiontimesec = transitionduration ?? 1.25;
        result = utility::waittill_any_timeout( transitiontimesec, "death" );
        
        if ( isdefined( self ) && result == "death" )
        {
            self stoplocalsound( sfx );
        }
    }
}

// Namespace killstreak_utility
// Params 7, eflags: 0x40 variadic
// Checksum 0xa52624fc, Offset: 0xa959
// Size: 0x1a9
function killstreak_watchlifetime( killstreakent, timeoutduration, var_d5d1f70b7c01c307, var_69fb75ce43100ed0, var_19706c9246084284, ... )
{
    level endon( #"game_ended" );
    killstreakent endon( #"death" );
    killstreakent.owner endon( #"disconnect" );
    killstreakent.owner endon( #"joined_team" );
    
    if ( !isdefined( var_d5d1f70b7c01c307 ) )
    {
        var_d5d1f70b7c01c307 = 0;
    }
    
    if ( isdefined( var_69fb75ce43100ed0 ) )
    {
        foreach ( endonnotify, lifetimeent in var_69fb75ce43100ed0 )
        {
            if ( !isdefined( lifetimeent ) || !isstring( endonnotify ) )
            {
                continue;
            }
            
            lifetimeent endon( endonnotify );
        }
    }
    
    if ( !isdefined( timeoutduration ) )
    {
        timeoutduration = killstreakent.lifetime;
    }
    
    timeelapsed = 0;
    
    while ( timeelapsed < timeoutduration )
    {
        if ( var_d5d1f70b7c01c307 )
        {
            timepercent = ( timeoutduration - timeelapsed ) / timeoutduration;
            timepercent = int( ceil( clamp( timepercent, 0, 1 ) * 100 ) );
            killstreakent.owner setclientomnvar( "ui_killstreak_countdown_percent", timepercent );
        }
        
        timeelapsed += level.framedurationseconds;
        waitframe();
    }
    
    if ( var_19706c9246084284 )
    {
        if ( varargcount != vararg.size )
        {
            return;
        }
        
        level thread [[ var_19706c9246084284 ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace killstreak_utility
// Params 2
// Checksum 0x14083e6, Offset: 0xab0a
// Size: 0xee
function killstreak_getmapcenter( owner, var_92ae03076d511fc2 )
{
    mapcenter = level.mapcenter ?? ( 0, 0, 0 );
    ownerorigin = owner.origin ?? mapcenter;
    
    if ( var_92ae03076d511fc2 )
    {
        return ownerorigin;
    }
    
    if ( game_utility::islargemap() )
    {
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm" )
        {
            if ( level.hqmidpoint )
            {
                mapcenter = level.hqmidpoint;
            }
        }
        else if ( level.gametype == "frontal" )
        {
            return mapcenter;
        }
        else
        {
            mapcenter = ownerorigin;
        }
    }
    else if ( level.gametype == "dd" )
    {
        mapcenter = ownerorigin;
    }
    
    return mapcenter;
}

// Namespace killstreak_utility
// Params 8
// Checksum 0xf5ef7fb9, Offset: 0xac01
// Size: 0xf1
function function_cf8a306884be6cf9( owner, streakinfo, killperiod = 5, weaponnamearray = [], var_5a597655aa69f56e, var_86d4201d6f4635fc, playdialog = 1, var_bf58dc8263382e27 = 0 )
{
    owner endon( #"disconnect" );
    
    if ( !streakinfo || weaponnamearray.size == 0 )
    {
        return;
    }
    
    owner notify( "startKillWatch_" + streakinfo.streakname );
    owner endon( "startKillWatch_" + streakinfo.streakname );
    killcount = owner killstreak_watchkillscount( streakinfo, killperiod, weaponnamearray, var_5a597655aa69f56e );
    
    if ( isdefined( var_86d4201d6f4635fc ) )
    {
        [[ var_86d4201d6f4635fc ]]( owner, streakinfo, killcount, playdialog, var_bf58dc8263382e27 );
    }
    else
    {
        function_d38cad12209f6799( owner, streakinfo, killcount, playdialog, var_bf58dc8263382e27 );
    }
    
    return killcount;
}

// Namespace killstreak_utility
// Params 4, eflags: 0x4
// Checksum 0x40a8748b, Offset: 0xacfb
// Size: 0x179
function private killstreak_watchkillscount( streakinfo, killperiod, var_456dd191c25b4db9, var_5a597655aa69f56e )
{
    self endon( #"disconnect" );
    self endon( "startKillWatch_" + streakinfo.streakname );
    level endon( #"game_ended" );
    var_3bf34db4dd19b205 = [];
    
    foreach ( weapon in var_456dd191c25b4db9 )
    {
        weaponname = weapon;
        
        if ( !isstring( weapon ) )
        {
            if ( isweapon( weapon ) )
            {
                weaponname = getweaponbasename( weapon );
            }
            else if ( isstruct( weapon ) )
            {
                weaponname = weapon.weaponname;
            }
        }
        
        var_3bf34db4dd19b205[ var_3bf34db4dd19b205.size ] = weaponname;
    }
    
    childthread function_c83797d72bff1c57( streakinfo, var_3bf34db4dd19b205 );
    
    if ( var_5a597655aa69f56e )
    {
        utility::waittill_any_timeout_no_endon_death( killperiod, var_5a597655aa69f56e );
    }
    else
    {
        wait killperiod;
    }
    
    self notify( "endKillWatch_" + streakinfo.streakname );
    killcounttotal = self.killstreakkills[ streakinfo.streakname ];
    self.killstreakkills[ streakinfo.streakname ] = 0;
    return killcounttotal;
}

// Namespace killstreak_utility
// Params 2, eflags: 0x4
// Checksum 0x7bdbb61f, Offset: 0xae7d
// Size: 0x11b
function private function_c83797d72bff1c57( streakinfo, var_456dd191c25b4db9 )
{
    self endon( "endKillWatch_" + streakinfo.streakname );
    
    if ( !isdefined( self.killstreakkills[ streakinfo.streakname ] ) )
    {
        self.killstreakkills[ streakinfo.streakname ] = 0;
    }
    
    while ( true )
    {
        results = utility::waittill_any_return_params( "update_rapid_kill_buffered", "update_rapid_agent_kill_buffered" );
        var_95795539e2a8343 = results[ 1 ];
        
        if ( !isstring( var_95795539e2a8343 ) )
        {
            continue;
        }
        
        foreach ( weapon in var_456dd191c25b4db9 )
        {
            if ( var_95795539e2a8343 == weapon )
            {
                self.killstreakkills[ streakinfo.streakname ]++;
            }
        }
    }
}

// Namespace killstreak_utility
// Params 5, eflags: 0x4
// Checksum 0x144bd0a7, Offset: 0xafa0
// Size: 0xdb
function private function_d38cad12209f6799( owner, streakinfo, killcount, playdialog, var_bf58dc8263382e27 )
{
    if ( playdialog )
    {
        var_3e98d14c4a20efe = #"miss";
        
        if ( killcount )
        {
            var_3e98d14c4a20efe = killcount > 1 ? #"hit_multi" : #"hit";
        }
        
        if ( !owner.var_203e3041fb5ac684[ streakinfo.streakname ] || owner.var_203e3041fb5ac684[ streakinfo.streakname ] + var_bf58dc8263382e27 * 1000 <= gettime() )
        {
            owner playkillstreaktacomdialog( streakinfo, undefined, var_3e98d14c4a20efe, 1 );
            owner.var_203e3041fb5ac684[ streakinfo.streakname ] = gettime();
        }
    }
}

// Namespace killstreak_utility
// Params 4
// Checksum 0x4d8781f6, Offset: 0xb083
// Size: 0x1e8
function function_13c253845c82599( killstreakent, spotradius = 300, spotinterval = 10, var_524de72ebd6fd5d3 )
{
    killstreakent endon( #"death" );
    killstreakent endon( #"leaving" );
    killstreakent endon( #"crashing" );
    owner = killstreakent.owner;
    owner endon( #"disconnect" );
    
    if ( var_524de72ebd6fd5d3 )
    {
        owner endon( var_524de72ebd6fd5d3 );
    }
    
    while ( true )
    {
        visibletargets = [];
        ownerlookatpos = player_utility::getplayerlookatpos( owner );
        
        if ( ownerlookatpos )
        {
            nearbyplayers = utility::playersinsphere( ownerlookatpos, spotradius );
            
            foreach ( player in nearbyplayers )
            {
                if ( !function_b80f6b1fd6002e2d( killstreakent, player ) )
                {
                    continue;
                }
                
                visibletargets[ visibletargets.size ] = player;
            }
            
            if ( !owner attackbuttonpressed() && !owner adsbuttonpressed() && visibletargets.size && ( !killstreakent.var_673e28eb116c1ca || killstreakent.var_673e28eb116c1ca + spotinterval * 1000 <= gettime() ) )
            {
                var_ada774aa7804d542 = visibletargets.size > 1 ? #"spotted_multi" : #"spotted_single";
                killstreakent playkillstreaktacomdialog( killstreakent.streakinfo, undefined, var_ada774aa7804d542, 1 );
                killstreakent.var_673e28eb116c1ca = gettime();
            }
        }
        
        wait 0.5;
    }
}

