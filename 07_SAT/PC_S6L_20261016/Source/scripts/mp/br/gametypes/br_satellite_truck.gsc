// scripts\mp\br\gametypes\br_satellite_truck.gsc  (hash_56335f8ce2313a13.gscc) (size: 6886 Bytes / 0x1ae6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d229bf2 (488807410)
// size ...... 6886 (0x1ae6)
// includes .. 7   (offset: 0x1936)
// strings ... 23  (offset: 0x196e)
// dev strs .. 2   (offset: 0x1ace)
// exports ... 18  (offset: 0xf02)
// cseg ...... 0x2c6 + 0xc3c (0xf02)
// imports ... 62  (offset: 0x11d2)
// animtree1 . 0   (offset: 0x1ae6)
// animtree2 . 0   (offset: 0x1ae6)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_functional_poi;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace br_satellite_truck;

// Namespace br_satellite_truck
// Params 0
// Checksum 0xcbfc1025, Offset: 0x2e4
// Size: 0x119
function init()
{
    level.br_satellite_truck_enabled = getdvarint( @"scr_br_satellite_truck", 0 ) != 0;
    
    if ( !level.br_satellite_truck_enabled )
    {
        return;
    }
    
    level._effect[ "poi_sat_truck_available" ] = loadfxasset( "vfx_iw8_br_gameplay_poi_satnav_white" );
    level._effect[ "poi_sat_truck_charging" ] = loadfxasset( "vfx_iw8_br_gameplay_poi_satnav_red" );
    level.br_satellitetruck = [];
    level.satellitetruckactivetimeseconds = getdvarfloat( @"scr_br_satellite_truck_active_time", 15 );
    level.satellitetruckplundercost = getdvarint( @"hash_e361609d81154a08", 1 );
    br_functional_poi::initstatemachineforpoitype( "satellite_truck" );
    br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 0, &_onenterdefaultstate, undefined, &_onexitdefaultstate );
    br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 1, &_onenterchargingstate, undefined, &_onexitchargingstate );
    br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 2, &_onenteractivestate, undefined, &_onexitactivestate );
    br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 3, &_onenterscanningstate, undefined, &_onexitscanningstate );
    br_functional_poi::registerstatecallbacksforpoitype( "satellite_truck", 4, &_onentercooldownstate, undefined, undefined );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0xdb75a4f, Offset: 0x405
// Size: 0x1ce
function spawnsatellitetruck( struct )
{
    if ( !level.br_satellite_truck_enabled )
    {
        return;
    }
    
    satellitetruckmodel = spawn( "script_model", struct.origin );
    
    if ( isdefined( struct.angles ) )
    {
        satellitetruckmodel.angles = struct.angles;
    }
    
    satellitetruckmodel setmodel( "veh8_mil_lnd_mkilo23_skud_static2" );
    var_bb2a1fb53206a0d3 = utility::getstruct( struct.target, "targetname" );
    
    if ( !isdefined( satellitetruckmodel.satellitekeyboard ) )
    {
        satellitekeyboard = spawn( "script_model", var_bb2a1fb53206a0d3.origin );
        
        if ( isdefined( var_bb2a1fb53206a0d3.angles ) )
        {
            satellitekeyboard.angles = var_bb2a1fb53206a0d3.angles;
        }
        
        satellitekeyboard setmodel( "electrical_elevator_access_keypad_01" );
        satellitekeyboard setcursorhint( "HINT_NOICON" );
        satellitekeyboard setuseholdduration( "duration_medium" );
        satellitekeyboard sethintdisplayfov( 120 );
        satellitekeyboard setusefov( 120 );
        satellitekeyboard setuserange( 80 );
        satellitekeyboard setusepriority( -1 );
        satellitetruckmodel.satellitekeyboard = satellitekeyboard;
    }
    
    satelliteiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( satelliteiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( satelliteiconid, "active", ( 0, 0, 0 ), "hud_icon_br_satellite_truck" );
        objidpoolmanager::update_objective_onentity( satelliteiconid, satellitetruckmodel );
        objidpoolmanager::update_objective_setbackground( satelliteiconid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( satelliteiconid );
        satellitetruckmodel.satelliteiconid = satelliteiconid;
        satellitetruckmodel thread _satellitetruckmanageminimapicon();
    }
    else
    {
        println( "<dev string:x24>" );
    }
    
    level.br_satellitetruck[ level.br_satellitetruck.size ] = satellitetruckmodel;
    return satellitetruckmodel;
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0xff36afc1, Offset: 0x5dc
// Size: 0x81
function onprematchdone()
{
    foreach ( satellitetruck in level.br_satellitetruck )
    {
        satellitetruck br_functional_poi::gotopoistate( "satellite_truck", 0 );
    }
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0xced89f1e, Offset: 0x665
// Size: 0x1b4
function _satellitetruckmanageminimapicon()
{
    satellitetruck = self;
    satellitetruck endon( #"death" );
    updateinterval = 1;
    visibleradius = 5000;
    satellitetruck.playersinrange = [];
    
    while ( true )
    {
        wait updateinterval;
        
        if ( !level.br_prematchstarted )
        {
            continue;
        }
        
        foreach ( player in satellitetruck.playersinrange )
        {
            if ( isdefined( player ) )
            {
                objidpoolmanager::objective_playermask_hidefrom( satellitetruck.satelliteiconid, player );
            }
        }
        
        satellitetruck.playersinrange = player_utility::script_getplayersinradius( satellitetruck.origin, visibleradius );
        
        foreach ( player in satellitetruck.playersinrange )
        {
            if ( player.team == satellitetruck.playerteam && satellitetruck.currentstate == 3 )
            {
                continue;
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( satellitetruck.satelliteiconid, player );
        }
    }
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0x85e7dfef, Offset: 0x821
// Size: 0x1a7
function _satellitetruckstartsound()
{
    satellitetruck = self;
    engine_snd_ent = satellitetruck;
    dish_snd_ent = satellitetruck.satellitekeyboard;
    assert( isdefined( dish_snd_ent ), "<dev string:x4f>" );
    
    while ( true )
    {
        satellitetruck waittill( #"poi_state_change" );
        state = satellitetruck.currentstate;
        
        if ( !isdefined( satellitetruck.audiostate ) )
        {
            satellitetruck.audiostate = state;
        }
        else if ( satellitetruck.audiostate == state )
        {
            continue;
        }
        
        satellitetruck.audiostate = state;
        
        switch ( state )
        {
            default:
                break;
            case 0:
                break;
            case 1:
                engine_snd_ent playsound( "truck_sattruck_initialstartup_os" );
                wait 7.5;
                engine_snd_ent playloopsound( "truck_sattruck_idling_lp" );
                break;
            case 2:
                break;
            case 3:
                satellitetruck.isscanning = 1;
                dish_snd_ent playsound( "truck_sattruck_initdeploy_os" );
                wait 4;
                dish_snd_ent playloopsound( "truck_sattruck_scanning_lp" );
                break;
            case 4:
                engine_snd_ent playsound( "truck_sattruck_engineoff" );
                
                if ( satellitetruck.isscanning )
                {
                    dish_snd_ent playsound( "truck_sattruck_scanning_off" );
                    satellitetruck.isscanning = undefined;
                    wait 0.05;
                    dish_snd_ent stoploopsound();
                }
                
                wait 0.45;
                engine_snd_ent stoploopsound();
                break;
        }
    }
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0x7d9b02c4, Offset: 0x9d0
// Size: 0x1c
function _satellitetruckendusethink()
{
    satellitetruck = self;
    satellitetruck notify( #"hash_7e106f890bc9dbf9" );
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0x27f68e85, Offset: 0x9f4
// Size: 0x141
function _satellitetruckusethink()
{
    satellitetruck = self;
    satellitetruck endon( #"death" );
    satellitetruck _satellitetruckendusethink();
    satellitetruck endon( #"hash_7e106f890bc9dbf9" );
    satellitetruck thread _satellitetruckstartsound();
    originalstate = satellitetruck br_functional_poi::getcurrentpoistate();
    
    while ( true )
    {
        satellitetruck.satellitekeyboard waittill( #"trigger", player );
        
        if ( satellitetruck br_functional_poi::getcurrentpoistate() != originalstate )
        {
            return;
        }
        
        if ( satellitetruck br_functional_poi::getcurrentpoistate() == 0 )
        {
            if ( player.plundercount < level.satellitetruckplundercost )
            {
                player hud_message::showerrormessage( %"mp_br_ingame/not_enough_plunder_activate" );
                continue;
            }
            else
            {
                player br_plunder::playersetplundercount( player.plundercount - level.satellitetruckplundercost );
            }
        }
        
        if ( originalstate == 0 )
        {
            satellitetruck.playerteam = player.team;
            satellitetruck thread br_functional_poi::gotopoistate( "satellite_truck", 1 );
            return;
        }
        
        if ( originalstate == 2 )
        {
            satellitetruck.playerteam = player.team;
            satellitetruck thread br_functional_poi::gotopoistate( "satellite_truck", 3 );
        }
    }
}

// Namespace br_satellite_truck
// Params 0
// Checksum 0x783fc279, Offset: 0xb3d
// Size: 0xf7
function _satellitetruckactivate()
{
    satellitetruck = self;
    satellitetruck endon( #"death" );
    level thread br::teamsplashbr( "br_satellite_truck_active", satellitetruck.player, satellitetruck.playerteam );
    sweepcount = 0;
    sweepspeed = getdvarint( @"hash_53e16ec28b970932", 500 );
    sweepfrequency = getdvarint( @"hash_d1658ac67eb8d4a8", 2 );
    
    while ( sweepcount * sweepfrequency <= level.satellitetruckactivetimeseconds )
    {
        triggerportableradarpingteam( self.origin, satellitetruck.playerteam, 5000, sweepspeed );
        sweepcount++;
        wait sweepfrequency;
    }
    
    var_3a2bb369c59948da = getdvarfloat( @"scr_br_satellite_truck_cooldown_msg", 3 );
    br_functional_poi::showmiscmessagetoteam( satellitetruck.playerteam, "br_satellite_truck_cooldown", var_3a2bb369c59948da );
    satellitetruck thread br_functional_poi::gotopoistate( "satellite_truck", 4 );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x9c66a3b2, Offset: 0xc3c
// Size: 0x84
function _onenterdefaultstate( satellitetruck )
{
    outlineasset = br_functional_poi::getinteractiveoutlineasset();
    satellitetruck.satellitekeyboard hudoutlineenable( outlineasset );
    satellitetruck.satellitekeyboard makeusable();
    satellitetruck.satellitekeyboard sethintstring( &"mp/br_activate_satellite_truck" );
    satellitetruck thread _satellitetruckusethink();
    var_e88935e795659227 = utility::getfx( "poi_sat_truck_available" );
    playfxontag( var_e88935e795659227, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x6d85ea91, Offset: 0xcc8
// Size: 0x59
function _onexitdefaultstate( satellitetruck )
{
    satellitetruck.satellitekeyboard hudoutlinedisable();
    satellitetruck _satellitetruckendusethink();
    satellitetruck.satellitekeyboard makeunusable();
    var_e88935e795659227 = utility::getfx( "poi_sat_truck_available" );
    stopfxontag( var_e88935e795659227, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0xa269515a, Offset: 0xd29
// Size: 0x7e
function _onenterchargingstate( satellitetruck )
{
    var_27460bcbd1bfe134 = getdvarfloat( @"scr_br_satellite_truck_charge_time", 10 );
    satellitetruck thread br_functional_poi::gotopoistateontimer( "satellite_truck", 2, var_27460bcbd1bfe134 );
    br_functional_poi::showmiscmessagetoteam( satellitetruck.playerteam, "br_satellite_truck_charging", var_27460bcbd1bfe134, int( var_27460bcbd1bfe134 * 1000 ) );
    var_3aeae3482258f1f3 = utility::getfx( "poi_sat_truck_charging" );
    playfxontag( var_3aeae3482258f1f3, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x18ab3701, Offset: 0xdaf
// Size: 0x30
function _onexitchargingstate( satellitetruck )
{
    var_3aeae3482258f1f3 = utility::getfx( "poi_sat_truck_charging" );
    stopfxontag( var_3aeae3482258f1f3, satellitetruck, "tag_origin" );
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0xfadb178, Offset: 0xde7
// Size: 0x62
function _onenteractivestate( satellitetruck )
{
    outlineasset = br_functional_poi::getinteractiveoutlineasset();
    satellitetruck.satellitekeyboard hudoutlineenable( outlineasset );
    satellitetruck.satellitekeyboard makeusable();
    satellitetruck.satellitekeyboard sethintstring( &"mp/br_use_satellite_truck" );
    satellitetruck thread _satellitetruckusethink();
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x5ab92dd3, Offset: 0xe51
// Size: 0x35
function _onexitactivestate( satellitetruck )
{
    satellitetruck.satellitekeyboard hudoutlinedisable();
    satellitetruck _satellitetruckendusethink();
    satellitetruck.satellitekeyboard makeunusable();
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x1351d6ab, Offset: 0xe8e
// Size: 0x15
function _onenterscanningstate( satellitetruck )
{
    satellitetruck thread _satellitetruckactivate();
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0x2947f0d, Offset: 0xeab
// Size: 0x17
function _onexitscanningstate( satellitetruck )
{
    satellitetruck.playerteam = undefined;
}

// Namespace br_satellite_truck
// Params 1
// Checksum 0xddfc6926, Offset: 0xeca
// Size: 0x38
function _onentercooldownstate( satellitetruck )
{
    cooldowntimeseconds = getdvarfloat( @"scr_br_satellite_truck_cooldown_time", 15 );
    satellitetruck thread br_functional_poi::gotopoistateontimer( "satellite_truck", 0, cooldowntimeseconds );
}

