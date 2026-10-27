// scripts\mp\br\gametypes\br_mobile_armory.gsc  (hash_2265830f17faa59b.gscc) (size: 7028 Bytes / 0x1b74 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb25309db (2991786459)
// size ...... 7028 (0x1b74)
// includes .. 9   (offset: 0x19c8)
// strings ... 23  (offset: 0x1a10)
// dev strs .. 1   (offset: 0x1b68)
// exports ... 15  (offset: 0xee4)
// cseg ...... 0x273 + 0xc71 (0xee4)
// imports ... 73  (offset: 0x113c)
// animtree1 . 0   (offset: 0x1b74)
// animtree2 . 0   (offset: 0x1b74)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_functional_poi;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\class;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;

#namespace br_mobile_armory;

// Namespace br_mobile_armory
// Params 0
// Checksum 0x566de2c1, Offset: 0x291
// Size: 0xe8
function init()
{
    level.br_mobile_armory_enabled = getdvarint( @"scr_br_mobile_armory", 0 ) != 0;
    
    if ( !level.br_mobile_armory_enabled )
    {
        return;
    }
    
    level._effect[ "poi_mobile_armory_available" ] = loadfxasset( "vfx_iw8_br_gameplay_poi_armory_white" );
    level._effect[ "poi_mobile_armory_charging" ] = loadfxasset( "vfx_iw8_br_gameplay_poi_armory_red" );
    level.br_mobilearmories = [];
    level.mobilearmoryplundercost = getdvarint( @"hash_9c45dd1e0492ab50", 1 );
    br_functional_poi::initstatemachineforpoitype( "mobile_armory" );
    br_functional_poi::registerstatecallbacksforpoitype( "mobile_armory", 0, &_onenterdefaultstate, undefined, &_onexitdefaultstate );
    br_functional_poi::registerstatecallbacksforpoitype( "mobile_armory", 1, &_onenterchargingstate, undefined, &_onexitchargingstate );
    br_functional_poi::registerstatecallbacksforpoitype( "mobile_armory", 2, &_onenteractivestate, undefined, &_onexitactivestate );
    br_functional_poi::registerstatecallbacksforpoitype( "mobile_armory", 3, &_onentercooldownstate, undefined, undefined );
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xb92a1c6f, Offset: 0x381
// Size: 0x1e8
function spawnmobilearmory( struct )
{
    if ( !level.br_mobile_armory_enabled )
    {
        return;
    }
    
    mainmodel = spawn( "script_model", struct.origin );
    
    if ( isdefined( struct.angles ) )
    {
        mainmodel.angles = struct.angles;
    }
    
    mainmodel setmodel( "veh8_mil_lnd_stango_static" );
    var_cbd114c317dbbcdf = utility::getstruct( struct.target, "targetname" );
    
    if ( !isdefined( mainmodel.interactiveelement ) )
    {
        var_620ef367170fe734 = ( 0, 0, 3 );
        interactiveelement = spawn( "script_model", var_cbd114c317dbbcdf.origin + var_620ef367170fe734 );
        
        if ( isdefined( var_cbd114c317dbbcdf.angles ) )
        {
            interactiveelement.angles = var_cbd114c317dbbcdf.angles;
        }
        
        interactiveelement setmodel( "military_crate_large_stackable_01" );
        interactiveelement setcursorhint( "HINT_NOICON" );
        interactiveelement setuseholdduration( "duration_medium" );
        interactiveelement sethintdisplayfov( 120 );
        interactiveelement setusefov( 120 );
        interactiveelement setuserange( 80 );
        interactiveelement setusepriority( -1 );
        mainmodel.interactiveelement = interactiveelement;
    }
    
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "active", ( 0, 0, 0 ), "hud_icon_br_mobile_armory" );
        objidpoolmanager::update_objective_onentity( objectiveiconid, mainmodel );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
        mainmodel.objectiveiconid = objectiveiconid;
        mainmodel thread _mobilearmorymanageminimapicon();
    }
    else
    {
        println( "<dev string:x24>" );
    }
    
    level.br_mobilearmories[ level.br_mobilearmories.size ] = mainmodel;
    return mainmodel;
}

// Namespace br_mobile_armory
// Params 0
// Checksum 0xc995b236, Offset: 0x572
// Size: 0x185
function _mobilearmorymanageminimapicon()
{
    mobilearmory = self;
    mobilearmory endon( #"death" );
    updateinterval = 1;
    visibleradius = 5000;
    mobilearmory.playersinrange = [];
    
    while ( true )
    {
        wait updateinterval;
        
        if ( !level.br_prematchstarted )
        {
            continue;
        }
        
        foreach ( player in mobilearmory.playersinrange )
        {
            if ( isdefined( player ) )
            {
                objidpoolmanager::objective_playermask_hidefrom( mobilearmory.objectiveiconid, player );
            }
        }
        
        mobilearmory.playersinrange = player_utility::script_getplayersinradius( mobilearmory.origin, visibleradius );
        
        foreach ( player in mobilearmory.playersinrange )
        {
            objidpoolmanager::objective_playermask_addshowplayer( mobilearmory.objectiveiconid, player );
        }
    }
}

// Namespace br_mobile_armory
// Params 0
// Checksum 0x137647b, Offset: 0x6ff
// Size: 0x81
function onprematchdone()
{
    foreach ( mobilearmory in level.br_mobilearmories )
    {
        mobilearmory br_functional_poi::gotopoistate( "mobile_armory", 0 );
    }
}

// Namespace br_mobile_armory
// Params 0
// Checksum 0xe34db66d, Offset: 0x788
// Size: 0x1c
function _mobilearmoryendusethink()
{
    mobilearmory = self;
    mobilearmory notify( #"hash_899faf43f0f112e9" );
}

// Namespace br_mobile_armory
// Params 0
// Checksum 0xc39b4d4, Offset: 0x7ac
// Size: 0x1cb
function _mobilearmoryusethink()
{
    mobilearmory = self;
    mobilearmory endon( #"death" );
    mobilearmory _mobilearmoryendusethink();
    mobilearmory endon( #"hash_899faf43f0f112e9" );
    originalstate = mobilearmory br_functional_poi::getcurrentpoistate();
    mobilearmory.recordedusers = [];
    
    while ( true )
    {
        mobilearmory.interactiveelement waittill( #"trigger", player );
        
        if ( mobilearmory br_functional_poi::getcurrentpoistate() != originalstate )
        {
            return;
        }
        
        if ( mobilearmory br_functional_poi::getcurrentpoistate() == 0 )
        {
            if ( player.plundercount < level.mobilearmoryplundercost )
            {
                player hud_message::showerrormessage( %"mp_br_ingame/not_enough_plunder_activate" );
                continue;
            }
            else
            {
                player br_plunder::playersetplundercount( player.plundercount - level.mobilearmoryplundercost );
            }
        }
        
        if ( originalstate == 0 )
        {
            mobilearmory.ownerteam = player.team;
            mobilearmory thread br_functional_poi::gotopoistate( "mobile_armory", 1 );
            return;
        }
        
        if ( originalstate == 2 )
        {
            var_8d96a11703150e9e = 0;
            
            foreach ( user in mobilearmory.recordedusers )
            {
                if ( user == player )
                {
                    var_8d96a11703150e9e = 1;
                    break;
                }
            }
            
            if ( var_8d96a11703150e9e )
            {
                player hud_message::showerrormessage( %"mp/br_mobile_armory_already_used" );
                continue;
            }
            
            player thread _mobilearmorychooseclass( mobilearmory );
        }
    }
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xc43be76c, Offset: 0x97f
// Size: 0x222
function _mobilearmorychooseclass( mobilearmory )
{
    player = self;
    player endon( #"death" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isai( player ) )
    {
        return;
    }
    
    if ( player isswitchingweapon() || player isreloading() || player ismantling() || player isthrowinggrenade() || player israisingweapon() || player ismeleeing() )
    {
        player hud_message::showerrormessage( %"mp_br_ingame/mobile_armory_action_error" );
        return;
    }
    
    player setclientomnvar( "ui_open_menu_from_script", 2 );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", channel, newclass );
        
        if ( channel != "class_select" )
        {
            continue;
        }
        
        newclasschoice = menus::getclasschoice( newclass );
        player.pers[ "class" ] = newclasschoice;
        player.class = newclasschoice;
        player class::preloadandqueueclass( newclasschoice );
        player class::swaploadout();
        player.gearchangedfromloadout = 0;
        mobilearmory.recordedusers[ mobilearmory.recordedusers.size ] = player;
        var_b1b079462f55d233 = 50;
        currentprimaries = player getweaponslistprimaries();
        
        foreach ( weaponobj in currentprimaries )
        {
            weaponname = getcompleteweaponname( weaponobj );
            
            if ( getsubstr( weaponname, 0, 4 ) == "alt_" )
            {
                continue;
            }
            
            clipsize = weaponclipsize( weaponobj );
            var_dd4dc1c18c7fcfda = int( min( var_b1b079462f55d233, clipsize ) );
            player setweaponammoclip( weaponobj, var_dd4dc1c18c7fcfda );
        }
    }
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xb44208a, Offset: 0xba9
// Size: 0x84
function _onenterdefaultstate( mobilearmory )
{
    outlineasset = br_functional_poi::getinteractiveoutlineasset();
    mobilearmory.interactiveelement hudoutlineenable( outlineasset );
    mobilearmory.interactiveelement makeusable();
    mobilearmory.interactiveelement sethintstring( &"mp/br_activate_mobile_armory" );
    mobilearmory thread _mobilearmoryusethink();
    var_e88935e795659227 = utility::getfx( "poi_mobile_armory_available" );
    playfxontag( var_e88935e795659227, mobilearmory, "tag_origin" );
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0x9bb80c16, Offset: 0xc35
// Size: 0x59
function _onexitdefaultstate( mobilearmory )
{
    mobilearmory.interactiveelement hudoutlinedisable();
    mobilearmory _mobilearmoryendusethink();
    mobilearmory.interactiveelement makeunusable();
    var_e88935e795659227 = utility::getfx( "poi_mobile_armory_available" );
    stopfxontag( var_e88935e795659227, mobilearmory, "tag_origin" );
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0x5c75ac85, Offset: 0xc96
// Size: 0x8d
function _onenterchargingstate( mobilearmory )
{
    var_27460bcbd1bfe134 = getdvarfloat( @"scr_br_mobile_armory_charge_time", 10 );
    mobilearmory thread br_functional_poi::gotopoistateontimer( "mobile_armory", 2, var_27460bcbd1bfe134 );
    br_functional_poi::showmiscmessagetoteam( mobilearmory.ownerteam, "br_mobile_armory_charging", var_27460bcbd1bfe134, int( var_27460bcbd1bfe134 * 1000 ) );
    var_3aeae3482258f1f3 = utility::getfx( "poi_mobile_armory_charging" );
    playfxontag( var_3aeae3482258f1f3, mobilearmory, "tag_origin" );
    mobilearmory playloopsound( "truck_reversebeep_lp" );
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xacf4e0f4, Offset: 0xd2b
// Size: 0x37
function _onexitchargingstate( mobilearmory )
{
    var_3aeae3482258f1f3 = utility::getfx( "poi_mobile_armory_charging" );
    stopfxontag( var_3aeae3482258f1f3, mobilearmory, "tag_origin" );
    mobilearmory stoploopsound();
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0x2722a3b2, Offset: 0xd6a
// Size: 0xd6
function _onenteractivestate( mobilearmory )
{
    outlineasset = br_functional_poi::getinteractiveoutlineasset();
    mobilearmory.interactiveelement hudoutlineenable( outlineasset );
    level thread br::teamsplashbr( "br_mobile_armory_activate", mobilearmory.player, mobilearmory.ownerteam );
    mobilearmory.interactiveelement makeusable();
    mobilearmory.interactiveelement sethintstring( &"mp/br_use_mobile_armory" );
    mobilearmory thread _mobilearmoryusethink();
    activetimeseconds = getdvarfloat( @"scr_br_mobile_armory_active_time", 15 );
    mobilearmory thread br_functional_poi::gotopoistateontimer( "mobile_armory", 3, activetimeseconds );
    br_functional_poi::showmiscmessagetoteam( mobilearmory.ownerteam, "br_mobile_armory_active", activetimeseconds, int( activetimeseconds * 1000 ) );
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xbc7b1f7d, Offset: 0xe48
// Size: 0x59
function _onexitactivestate( mobilearmory )
{
    mobilearmory.interactiveelement hudoutlinedisable();
    mobilearmory _mobilearmoryendusethink();
    mobilearmory.interactiveelement makeunusable();
    br_functional_poi::showmiscmessagetoteam( mobilearmory.ownerteam, "br_mobile_armory_cooldown", 3 );
    mobilearmory.ownerteam = undefined;
}

// Namespace br_mobile_armory
// Params 1
// Checksum 0xb692b7f7, Offset: 0xea9
// Size: 0x3b
function _onentercooldownstate( mobilearmory )
{
    cooldowntimeseconds = getdvarfloat( @"scr_br_mobile_armory_cooldown_time", 120 );
    mobilearmory thread br_functional_poi::gotopoistateontimer( "mobile_armory", 0, cooldowntimeseconds );
}

