// scripts\mp\gametypes\ballmode.gsc  (hash_29dde8ec1c1caec0.gscc) (size: 32234 Bytes / 0x7dea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8fd1af0 (3372030704)
// size ...... 32234 (0x7dea)
// includes .. 32  (offset: 0x714a)
// strings ... 195 (offset: 0x724a)
// dev strs .. 4   (offset: 0x7dae)
// exports ... 52  (offset: 0x4ede)
// cseg ...... 0xf21 + 0x3fbd (0x4ede)
// imports ... 207 (offset: 0x56fe)
// animtree1 . 0   (offset: 0x7dea)
// animtree2 . 0   (offset: 0x7dea)
#using script_3cb3908b3094b567;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\spawnlogic;

#namespace ballmode;

// Namespace ballmode
// Params 0
// Checksum 0x4cb4634a, Offset: 0xf3f
// Size: 0x276
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    setspecialloadout();
    updategametypedvars();
    level.teambased = 1;
    level.vehiclegod = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.ontimelimit = &ontimelimit;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.nosuspensemusic = 1;
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = getdvarint( @"ballmode_requiredplayercount", 3 );
    level.requiredplayercount[ "axis" ] = getdvarint( @"ballmode_requiredplayercount", 3 );
    game[ "dialog" ][ "offense_obj" ] = "iw9_gmst_anno_uktl_gsoa";
    game[ "dialog" ][ "defense_obj" ] = "iw9_gmst_anno_uktl_gsoa";
    level.var_79251768cd5e678c = getdvarint( @"hash_f4485e63f712eee1", 0 );
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    level.var_3a28db61277e7016 = 1;
    level.var_35e0d585b6abb321 = %"hash_32c407acbf70e84c";
    utility::registersharedfunc( level.var_35e0d585b6abb321, #"flippedEnd", &function_e888762df39f0ccb );
    callback::add( #"player_spawned", &onplayerspawned );
    utility::add_fx( "ball_contact", "vfx_iw9_level_mp_futbol_soccerball_contact" );
    utility::add_fx( "ball_contact_pulse", "vfx_iw9_level_mp_futbol_soccerball_contact_pulse" );
    utility::add_fx( "grenade_contact", "vfx_iw9_level_mp_futbol_pickup_grenade_active" );
    utility::add_fx( "player_rammed", "vfx_iw9_level_mp_futbol_atv_ram_explo" );
    utility::add_fx( "player_respawn", "vfx_iw9_level_mp_futbol_atv_ram_respawn" );
    utility::add_fx( "grenade_launch", "vfx_iw9_level_mp_futbol_atv_grenade_launch" );
    thread gamemodestates();
    thread function_167d3b846e6d9a60();
    thread function_bc5228036fb232ec();
    function_8460dff2161de409();
    setdvar( @"cg_vehiclecameraoverridepolarclamping", 1 );
}

// Namespace ballmode
// Params 0, eflags: 0x4
// Checksum 0x2aa97347, Offset: 0x11bd
// Size: 0x49
function private function_bc5228036fb232ec()
{
    level endon( #"game_ended" );
    delayseconds = getdvarint( @"hash_72df5f8fcefc0bad", 30 );
    wait delayseconds;
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace ballmode
// Params 1, eflags: 0x4
// Checksum 0x6eb2ebab, Offset: 0x120e
// Size: 0xa5
function private function_7064a7de612377c1( entity )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid == -1 )
    {
        return;
    }
    
    offsetheight = 100;
    objective_setlabel( objid, "" );
    objective_setplayintro( objid, 0 );
    objective_setpings( objid, 1 );
    objective_setzoffset( objid, offsetheight );
    objective_icon( objid, "icon_waypoint_enemy_goal" );
    objective_setbackground( objid, 1 );
    objective_state( objid, "current" );
    objective_position( objid, entity.origin + ( 0, 0, offsetheight ) );
    objective_setshowdistance( objid, 0 );
    objidpoolmanager::objective_mask_showtoplayerteam( objid, entity );
}

// Namespace ballmode
// Params 0, eflags: 0x4
// Checksum 0xd6773cb1, Offset: 0x12bb
// Size: 0x92
function private function_8d9389f757d7aadf()
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid == -1 )
    {
        return;
    }
    
    offsetheight = 100;
    objective_setlabel( objid, "" );
    objective_setplayintro( objid, 0 );
    objective_setpings( objid, 1 );
    objective_setzoffset( objid, offsetheight );
    objective_icon( objid, "icon_waypoint_soccer_ball" );
    objective_setbackground( objid, 1 );
    objective_state( objid, "current" );
    objective_onentity( objid, level.ball );
    objective_setshowdistance( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
}

// Namespace ballmode
// Params 1
// Checksum 0xc821c024, Offset: 0x1355
// Size: 0x96
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    spawndata.vehicleoverride = self.team == "axis" ? "veh9_mil_lnd_atv_physics_mp_boostball_al" : "veh9_mil_lnd_atv_physics_mp_boostball_las";
    return spawndata;
}

// Namespace ballmode
// Params 0
// Checksum 0x1295685b, Offset: 0x13f4
// Size: 0xe1
function function_c573966a840bf8fb()
{
    self notify( #"respawn" );
    self.var_9b6d5e24d8eed7c4 = 1;
    position = spawnstruct();
    position.origin = self.origin;
    position.angles = self.angles;
    spawndata = vehiclespawn_getspawndata( position );
    vehicle = vehicle::spawn( level.var_35e0d585b6abb321, spawndata );
    vehicle.dontspawnhusk = 1;
    vehicle.godmode = 1;
    vehicle vehicle_spawn::prevent_respawn();
    vehicle.lastpushtime = -1;
    vehicle.rider = self;
    
    if ( level.forceretryonvehicleoccupancyfailed )
    {
        thread entervehicle( vehicle );
        return;
    }
    
    entervehicle( vehicle );
}

// Namespace ballmode
// Params 1
// Checksum 0x62326e37, Offset: 0x14dd
// Size: 0x310
function entervehicle( vehicle )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    enterdata = spawnstruct();
    
    if ( level.forceretryonvehicleoccupancyfailed )
    {
        while ( !enterdata.success )
        {
            waitframe();
            vehicle_occupancy::enter( vehicle, "driver", self, enterdata, 1 );
        }
    }
    else
    {
        vehicle_occupancy::enter( vehicle, "driver", self, enterdata, 1 );
    }
    
    if ( getdvarint( @"hash_f5e40a9aa678afcd", 0 ) )
    {
        vehicle.mtx = "v004";
        vehicle function_ab60c6b563088b74( "v004" );
    }
    else if ( !isdefined( vehicle.mtx ) )
    {
        if ( self.team == "axis" )
        {
            vehicle.mtx = "v008";
            vehicle function_ab60c6b563088b74( "v008" );
        }
        else
        {
            vehicle.mtx = "v009";
            vehicle function_ab60c6b563088b74( "v009" );
        }
    }
    
    usepulse = getdvarint( @"ballmode_pulse", 0 );
    
    if ( self.team == "axis" )
    {
        self.vehicle setscriptablepartstate( "tail_lights", "green", 1 );
    }
    else
    {
        self.vehicle setscriptablepartstate( "tail_lights", "yellow", 1 );
    }
    
    if ( usepulse )
    {
        thread function_717ab26f25f5fdad();
        thread function_d8d6a4cb6296f20d();
        thread function_123cb4f587732f8d();
    }
    
    thread function_8455583d1902ce67();
    
    if ( !level.disableplayeroutlines )
    {
        if ( level.useredandblueplayeroutlines )
        {
            friendlyteam = "outline_nodepth_blue";
            enemyteam = "outline_nodepth_red";
            outline::outlineenableforteam( self, self.team, friendlyteam, "level_script", [ self ] );
            outline::outlineenableforteam( self.vehicle, self.team, friendlyteam, "level_script", [ self ] );
            outline::outlineenableforteam( self, enemyteam( self.team ), enemyteam, "level_script" );
            outline::outlineenableforteam( self.vehicle, enemyteam( self.team ), enemyteam, "level_script" );
        }
        else
        {
            teamcolor = self.team == "allies" ? "outline_nodepth_yellow" : "outline_nodepth_green";
            outline::outlineenableforteam( self, self.team, teamcolor, "level_script", [ self ] );
            outline::outlineenableforteam( self.vehicle, self.team, teamcolor, "level_script", [ self ] );
            outline::outlineenableforteam( self, enemyteam( self.team ), teamcolor, "level_script" );
            outline::outlineenableforteam( self.vehicle, enemyteam( self.team ), teamcolor, "level_script" );
        }
    }
    
    thread deleteondisconnect();
    thread listenforvehicleexit( self );
}

// Namespace ballmode
// Params 0, eflags: 0x4
// Checksum 0x2875ccec, Offset: 0x17f5
// Size: 0x7a
function private function_8455583d1902ce67()
{
    while ( !isdefined( level.ball ) )
    {
        waitframe();
    }
    
    if ( self.pers[ "lookingAtBall" ] )
    {
        self function_2c809dbea97c1579( level.ball );
        self setclientomnvar( "ballmode_cameramode", 1 );
        self.pers[ "lookingAtBall" ] = 1;
        return;
    }
    
    self function_2c809dbea97c1579();
    self setclientomnvar( "ballmode_cameramode", 0 );
    self.pers[ "lookingAtBall" ] = 0;
}

// Namespace ballmode
// Params 2, eflags: 0x4
// Checksum 0xf81a05e7, Offset: 0x1877
// Size: 0x6a
function private function_e888762df39f0ccb( vehicle, timedout )
{
    if ( isdefined( vehicle ) && timedout )
    {
        position = vehicle.origin + ( 0, 0, 100 );
        angles = ( 0, vehicle.angles[ 1 ], 0 );
        vehicle vehicle_teleport( position, angles );
    }
}

// Namespace ballmode
// Params 0
// Checksum 0x5789162f, Offset: 0x18e9
// Size: 0x98
function function_7190771e34048095()
{
    if ( !( isdefined( self.pers[ "lookingAtBall" ] ) && isdefined( level.ball ) && isdefined( self.vehicle ) ) )
    {
        return;
    }
    
    if ( !self.pers[ "lookingAtBall" ] )
    {
        self function_2c809dbea97c1579( level.ball );
        self setclientomnvar( "ballmode_cameramode", 1 );
        self.pers[ "lookingAtBall" ] = 1;
        return;
    }
    
    self function_2c809dbea97c1579();
    self setclientomnvar( "ballmode_cameramode", 0 );
    self.pers[ "lookingAtBall" ] = 0;
}

// Namespace ballmode
// Params 0
// Checksum 0x398e5b96, Offset: 0x1989
// Size: 0x40
function function_40733cf1af8e9ee8()
{
    self endon( #"disconnect" );
    self notifyonplayercommand( "toggleLookAt", "+melee_zoom" );
    
    while ( true )
    {
        self waittill( #"toggleLookAt" );
        function_7190771e34048095();
        wait 0.5;
    }
}

// Namespace ballmode
// Params 1
// Checksum 0xfed56de0, Offset: 0x19d1
// Size: 0x166
function onplayerspawned( params )
{
    self.plotarmor = 1;
    
    if ( level.var_79251768cd5e678c > 0 )
    {
        level.var_79251768cd5e678c -= 1;
        return;
    }
    
    battlechatter_mp::disablebattlechatter( self );
    function_c573966a840bf8fb();
    self clearsoundsubmix( "iw9_mp_soccer_goal", 1 );
    damage_effects::function_e8cba6f10a4635e9();
    self clearsoundsubmix( "iw9_mp_killcam", 2 );
    self clearclienttriggeraudiozone( 2 );
    thread function_5de74ae3bb261624();
    thread function_135523372fa9542a();
    thread time();
    thread function_40733cf1af8e9ee8();
    thread function_cd74a13c2450719a();
    respawnfx = spawnfx( utility::getfx( "player_respawn" ), self.origin );
    triggerfx( respawnfx );
    skin = operator::function_cc5d60d5178c5007();
    
    if ( skin == "neymar_eastern" || skin == "messi_western" || skin == "pogba_western" )
    {
        self.var_c165c2ecea9ef0f6 = 1;
    }
    
    if ( self.var_c165c2ecea9ef0f6 && getdvarint( @"hash_17a42017d84df7ec", 0 ) )
    {
        self playsound( "equip_codball_shockstick_pickup" );
        self.hasgrenade = 1;
        self setclientomnvar( "ballmode_grenade", self.hasgrenade );
    }
    
    stats::setextrascore0( self.pers[ "goals" ] ?? 0, "goals" );
}

// Namespace ballmode
// Params 0
// Checksum 0xf8d06eb7, Offset: 0x1b3f
// Size: 0x49
function time()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.codballtime = 0;
    
    while ( true )
    {
        waitframe();
        self.codballtime += level.framedurationseconds;
    }
}

// Namespace ballmode
// Params 0
// Checksum 0x8cffecd, Offset: 0x1b90
// Size: 0xd5
function function_dfde7768fadc8450()
{
    self endon( #"disconnect" );
    self.isstunned = 1;
    self allowmovement( 0 );
    self.vehicle setscriptablepartstate( "stunned", "stunned", 1 );
    self earthquakeforplayer( 0.3, 0.6, self.origin, 5000 );
    self.vehicle vehicle_settopspeedforward( self.normalspeed * getdvarfloat( @"hash_1576e2ea08aa2848", 0.8 ) );
    hud_message::showsplash( "ballmode_stunned_by_player" );
    wait 1;
    self.vehicle vehicle_settopspeedforward( self.normalspeed );
    self.vehicle setscriptablepartstate( "stunned", "not_stunned", 1 );
    self allowmovement( 1 );
    self.isstunned = 0;
}

// Namespace ballmode
// Params 1
// Checksum 0xf705f85a, Offset: 0x1c6d
// Size: 0x1a
function function_e104bcaccf2e2215( var_e104bcaccf2e2215 )
{
    if ( var_e104bcaccf2e2215 )
    {
        return;
    }
    
    self function_233ec2986626c702();
}

// Namespace ballmode
// Params 0
// Checksum 0x420920e1, Offset: 0x1c8f
// Size: 0x344
function function_cd74a13c2450719a()
{
    self endon( #"disconnect" );
    slot = equipment_mp::getdefaultslot( "equip_shockstick_ballmode" );
    equipment_mp::giveequipment( "equip_shockstick_ballmode", slot );
    self notifyonplayercommand( "ballmode_preview_grenade", "+attack" );
    self notifyonplayercommand( "ballmode_throw_grenade", "-attack" );
    
    while ( true )
    {
        self waittill( #"ballmode_preview_grenade" );
        
        if ( !self.isstunned && self.hasgrenade && isalive( self ) )
        {
            function_e104bcaccf2e2215( 1 );
        }
        
        self waittill( #"ballmode_throw_grenade" );
        function_e104bcaccf2e2215( 0 );
        
        if ( self.isstunned )
        {
            waitframe();
            continue;
        }
        
        if ( !self.hasgrenade )
        {
            waitframe();
            continue;
        }
        
        if ( !isalive( self ) )
        {
            waitframe();
            continue;
        }
        
        var_8f65710283ad63fd = getdvarfloat( @"hash_2e6a0a6ee3b2cd6", 40 );
        var_b6c57a754e4445f7 = getdvarvector( @"hash_73b69837141ae856", ( 0, 0, 40 ) );
        var_ccf04c98fbe77783 = getdvarfloat( @"hash_90221071ebbf785e", 1500 );
        var_70fc72acb9f446f2 = getdvarvector( @"hash_3ea5f4b035285d67", ( 0, 0, 150 ) );
        self.hasgrenade = 0;
        self setclientomnvar( "ballmode_grenade", self.hasgrenade );
        playerangles = anglestoforward( self getplayercameraangles() );
        vehicleangles = anglestoforward( self.angles );
        grenadethrowposition = self.vehicle.origin + vehicleangles * var_8f65710283ad63fd + var_b6c57a754e4445f7;
        
        if ( vectordot( playerangles, vehicleangles ) < 0 )
        {
            grenadethrowposition = self.vehicle.origin - vehicleangles * var_8f65710283ad63fd + var_b6c57a754e4445f7;
        }
        
        grenade = weapon::_launchgrenade( "shock_stick_mp_ballmode", grenadethrowposition, playerangles * var_ccf04c98fbe77783 + var_70fc72acb9f446f2, 1, undefined, undefined );
        self playsound( "weap_codball_shockstick_fire" );
        triggerfx( spawnfx( utility::getfx( "grenade_launch" ), grenadethrowposition ) );
        grenade utility::waittill_any_timeout( 5, "missile_stuck" );
        position = grenade.origin;
        playfx( utility::getfx( "grenade_contact" ), position );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player earthquakeforplayer( 0.3, 0.2, position, 1000 );
            
            if ( player.team == self.team )
            {
                continue;
            }
            
            if ( length( player.origin - position ) < 150 )
            {
                player thread function_dfde7768fadc8450();
                points::doscoreevent( #"ballmode_enemy_stunned" );
            }
        }
        
        waitframe();
        grenade delete();
    }
}

// Namespace ballmode
// Params 1
// Checksum 0xfa17097c, Offset: 0x1fdb
// Size: 0x1a5
function function_948226773dbd1662( pickuplocation )
{
    level endon( #"game_ended" );
    pickup = spawnscriptable( "ballmode_grenade_pickup", pickuplocation.origin + ( 0, 0, 30 ) );
    pickup setscriptablepartstate( "grenade_pickup", "ready", 1 );
    
    while ( true )
    {
        playerref = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.hasgrenade )
            {
                continue;
            }
            
            if ( lengthsquared( player.origin - pickup.origin ) < 3600 )
            {
                playerref = player;
                break;
            }
        }
        
        if ( !isdefined( playerref ) )
        {
            waitframe();
            continue;
        }
        
        pickup setscriptablepartstate( "grenade_pickup", "inactive", 1 );
        playerref playsound( "equip_codball_shockstick_pickup" );
        playerref.hasgrenade = 1;
        playerref setclientomnvar( "ballmode_grenade", playerref.hasgrenade );
        wait getdvarint( @"ballmode_grenade_respawn", 20 );
        pickup setscriptablepartstate( "grenade_pickup", "ready", 1 );
        playsoundatpos( pickuplocation.origin, "equip_codball_shockstick_spawn" );
    }
}

// Namespace ballmode
// Params 0
// Checksum 0xce00ab37, Offset: 0x2188
// Size: 0x286
function function_8460dff2161de409()
{
    level.var_cf433c073b4c4e22[ 0 ] = getent( "score_axis_0", #targetname );
    level.var_cf433c073b4c4e22[ 1 ] = getent( "score_axis_1", #targetname );
    level.var_cf433c073b4c4e22[ 2 ] = getent( "score_axis_2", #targetname );
    level.var_cf433c073b4c4e22[ 3 ] = getent( "score_axis_3", #targetname );
    level.var_cf433c073b4c4e22[ 4 ] = getent( "score_axis_4", #targetname );
    level.var_cf433c073b4c4e22[ 5 ] = getent( "score_axis_5", #targetname );
    level.var_cf433c073b4c4e22[ 6 ] = getent( "score_axis_6", #targetname );
    level.var_cf433c073b4c4e22[ 7 ] = getent( "score_axis_7", #targetname );
    level.var_cf433c073b4c4e22[ 8 ] = getent( "score_axis_8", #targetname );
    level.var_cf433c073b4c4e22[ 9 ] = getent( "score_axis_9", #targetname );
    level.var_e13dc0c9bd167705[ 0 ] = getent( "score_allies_0", #targetname );
    level.var_e13dc0c9bd167705[ 1 ] = getent( "score_allies_1", #targetname );
    level.var_e13dc0c9bd167705[ 2 ] = getent( "score_allies_2", #targetname );
    level.var_e13dc0c9bd167705[ 3 ] = getent( "score_allies_3", #targetname );
    level.var_e13dc0c9bd167705[ 4 ] = getent( "score_allies_4", #targetname );
    level.var_e13dc0c9bd167705[ 5 ] = getent( "score_allies_5", #targetname );
    level.var_e13dc0c9bd167705[ 6 ] = getent( "score_allies_6", #targetname );
    level.var_e13dc0c9bd167705[ 7 ] = getent( "score_allies_7", #targetname );
    level.var_e13dc0c9bd167705[ 8 ] = getent( "score_allies_8", #targetname );
    level.var_e13dc0c9bd167705[ 9 ] = getent( "score_allies_9", #targetname );
    setscore( "allies", 0 );
    setscore( "axis", 0 );
}

// Namespace ballmode
// Params 2
// Checksum 0xc78f7bcd, Offset: 0x2416
// Size: 0x134
function setscore( teamscore, scorevalue )
{
    if ( teamscore == "axis" )
    {
        foreach ( card in level.var_e13dc0c9bd167705 )
        {
            card hide();
        }
        
        level.var_e13dc0c9bd167705[ scorevalue ] show();
        return;
    }
    
    if ( teamscore == "allies" )
    {
        foreach ( card in level.var_cf433c073b4c4e22 )
        {
            card hide();
        }
        
        level.var_cf433c073b4c4e22[ scorevalue ] show();
    }
}

// Namespace ballmode
// Params 0
// Checksum 0xdd9469b1, Offset: 0x2552
// Size: 0x69e
function gamemodestates()
{
    level endon( #"game_ended" );
    waitframe();
    level.goalaxis = getent( "goal_axis", #targetname );
    level.goalaxis.team = "axis";
    level.goalallies = getent( "goal_allies", #targetname );
    level.goalallies.team = "allies";
    level.ballresetpos = utility::getstruct( "ball_respawn", "targetname" );
    setscore( level.goalaxis.team, gamescore::getteamscore( level.goalaxis.team ) );
    setscore( level.goalallies.team, gamescore::getteamscore( level.goalallies.team ) );
    pickuplocations = utility::getstructarray( "ballmode_pickup", "targetname" );
    level thread function_948226773dbd1662( pickuplocations[ 0 ] );
    level thread function_948226773dbd1662( pickuplocations[ 1 ] );
    level thread function_948226773dbd1662( pickuplocations[ 2 ] );
    level thread function_948226773dbd1662( pickuplocations[ 3 ] );
    wait 5;
    level.ball = spawn( "script_model", level.ballresetpos.origin );
    level.ball setmodel( "art_stadium_ball" );
    level.ball.targetname = "ball";
    level.ball physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.ball thread function_5db3694013dcf900();
    function_7064a7de612377c1( level.goalaxis );
    function_7064a7de612377c1( level.goalallies );
    function_8d9389f757d7aadf();
    
    if ( isdefined( game[ "ballmodeTimePassed" ] ) )
    {
        level.starttime = gettime();
        level.timelimit = game[ "ballmodeTimePassed" ] / 1000;
    }
    
    scoringteam = undefined;
    
    while ( true )
    {
        if ( level.goalaxis istouching( level.ball ) )
        {
            scoringteam = level.goalaxis.team;
            break;
        }
        
        if ( level.goalallies istouching( level.ball ) )
        {
            scoringteam = level.goalallies.team;
            break;
        }
        
        waitframe();
    }
    
    level notify( #"ballmode_goal_scored" );
    function_12a6d4c690fbd03( scoringteam );
    
    foreach ( player in level.players )
    {
        player.canram = 0;
        player earthquakeforplayer( 0.4, 2.5, level.ball.origin, 5000 );
        function_a18f6bdaae2f6775( player, scoringteam );
        
        if ( player.team == scoringteam )
        {
            if ( isdefined( level.ball.var_8f9b56802143d5ae ) && player == level.ball.var_8f9b56802143d5ae.player )
            {
                level.ball.var_8f9b56802143d5ae.player points::doscoreevent( #"ballmode_goal_score" );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "goals" ] ) )
                    {
                        player.leaderboarddata[ "goals" ] = player.leaderboarddata[ "goals" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "goals" ] ) )
                    {
                        [[ level.leaderboardfunc[ "goals" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( player.pers[ "goals" ] ) )
                    {
                        player.pers[ "goals" ] = player.pers[ "goals" ] + 1;
                    }
                }
                
                player stats::setextrascore0( player.pers[ "goals" ] );
                
                if ( level.ball.var_8f9b56802143d5ae.var_a012024b84804990 )
                {
                    level.ball.var_8f9b56802143d5ae.player points::doscoreevent( #"ballmode_goal_score_reverse" );
                }
                
                player.pers[ "hasDoneAnyCombat" ] = 1;
                continue;
            }
            
            if ( isdefined( level.ball.recentlytouched ) && isdefined( level.ball.recentlytouched[ player.guid ] ) )
            {
                player points::doscoreevent( #"ballmode_goal_assist" );
                player.pers[ "hasDoneAnyCombat" ] = 1;
                player.pers[ "assists" ] = player.pers[ "assists" ] + 1;
            }
            
            player points::doscoreevent( #"ballmode_goal_score_teammate" );
        }
    }
    
    gamelogic_mp::pausetimer();
    game[ "ballmodeTimePassed" ] = gamelogic_mp::gettimeremaining();
    level.var_26871b995fade719 = 1;
    wait 3;
    gamescore::giveteamscoreforobjective( scoringteam, 1, 1, undefined, 1 );
    setscore( level.goalaxis.team, gamescore::getteamscore( level.goalaxis.team ) );
    setscore( level.goalallies.team, gamescore::getteamscore( level.goalallies.team ) );
    
    if ( game[ "status" ] == "overtime" )
    {
        level thread gamelogic_mp::endgame( scoringteam, game[ "end_reason" ][ "score_limit_reached" ] );
        return;
    }
    
    gamelogic_mp::pausetimer();
    game[ "ballmodeTimePassed" ] = gamelogic_mp::gettimeremaining();
}

// Namespace ballmode
// Params 1
// Checksum 0xb6bec428, Offset: 0x2bf8
// Size: 0x7d
function function_12a6d4c690fbd03( goalteam )
{
    if ( goalteam == "axis" )
    {
        utility::exploder( "goal_2" );
    }
    else
    {
        utility::exploder( "goal_1" );
    }
    
    setmusicstate( "goal_scored" );
    playsoundatpos( level.ball.origin, "mp_codball_goal_whistle" );
    playsoundatpos( level.ball.origin, "mp_codball_goal_cheer" );
    thread function_1b8da36911930de2();
}

// Namespace ballmode
// Params 0
// Checksum 0x410f75ed, Offset: 0x2c7d
// Size: 0x19
function function_1b8da36911930de2()
{
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "iw9_mp_soccer_goal", 2 );
}

// Namespace ballmode
// Params 0
// Checksum 0xd92b4d73, Offset: 0x2c9e
// Size: 0x66, Type: bool
function function_77fbf16cb6eaf1a8()
{
    if ( self.lastpulse == 0 )
    {
        return false;
    }
    
    usingpulse = getdvarint( @"ballmode_pulse", 0 );
    return usingpulse && self.codballtime >= self.lastpulse && self.codballtime <= self.lastpulse + self.var_27758cc61e8bb023;
}

// Namespace ballmode
// Params 5
// Checksum 0xb8d0f2d3, Offset: 0x2d0d
// Size: 0x28f
function pushball( vehicle, ball, normal, var_9652a85e33d5e4a9, contactposition )
{
    if ( isdefined( vehicle.lastpushtime ) && vehicle.rider.codballtime < vehicle.lastpushtime + 0.2 )
    {
        return;
    }
    
    if ( isdefined( vehicle.lastpushtime ) )
    {
    }
    
    vehicle.lastpushtime = vehicle.rider.codballtime;
    var_77fbf16cb6eaf1a8 = function_77fbf16cb6eaf1a8();
    var_4d553c25ecd45c5c = 1;
    var_d48a00012794f1fa = 1;
    
    if ( var_77fbf16cb6eaf1a8 )
    {
        var_4d553c25ecd45c5c = getdvarint( @"hash_eb8ae893bdadfa96", 3 );
        var_d48a00012794f1fa = var_4d553c25ecd45c5c / 2;
    }
    
    vehiclevelocity = vehicle vehicle_getvelocity();
    ballvelocity = ball.velocity;
    velocitydifference = vehiclevelocity - ballvelocity;
    vehiclespeedramp = math::remap( clamp( length( velocitydifference ), 0, 1000 ), 0, 1000, 0, 1 );
    var_15d33889baf61a7 = math::remap( vehiclespeedramp, 0, 1, 20, 60 );
    upwardimpulse = var_15d33889baf61a7 * var_d48a00012794f1fa;
    
    if ( ball.velocity[ 2 ] > 40 )
    {
        upwardimpulse /= 3;
    }
    
    ball physics_applyimpulse( ball.origin, ( 0, 0, upwardimpulse ) );
    normal = vectornormalize( ( normal[ 0 ], normal[ 1 ], normal[ 2 ] * 0.8 ) );
    var_69c79f027b1c7095 = math::remap( vehiclespeedramp, 0, 1, 100, 600 );
    var_aae9e36aee35f609 = normal * var_69c79f027b1c7095;
    ball physics_applyimpulse( ball.origin, var_aae9e36aee35f609 * var_9652a85e33d5e4a9 * var_4d553c25ecd45c5c );
    
    if ( var_77fbf16cb6eaf1a8 )
    {
        playfx( utility::getfx( "ball_contact_pulse" ), contactposition );
        function_527b00c562e307db( ball, var_69c79f027b1c7095, 0, 1 );
    }
    else
    {
        playfx( utility::getfx( "ball_contact" ), contactposition );
        function_527b00c562e307db( ball, var_69c79f027b1c7095, 0, 0 );
    }
    
    if ( var_77fbf16cb6eaf1a8 )
    {
        vehicle.rider earthquakeforplayer( 0.3, 0.6, ball.origin, 5000 );
        return;
    }
    
    vehicle.rider earthquakeforplayer( 0.15, 0.3, ball.origin, 5000 );
}

// Namespace ballmode
// Params 4
// Checksum 0x76b392d4, Offset: 0x2fa4
// Size: 0x123
function function_527b00c562e307db( ball, ballspeed, hitsurface, pulse )
{
    soundprefix = "mp_codball_ball_impact";
    surfacetype = "_grass";
    soundintensity = "_light";
    soundalias = "mp_codball_ball_impact_grass_light";
    mediumspeed = 200;
    heavyspeed = 500;
    
    if ( hitsurface > 2 || hitsurface < 0 )
    {
        return;
    }
    
    switch ( hitsurface )
    {
        case 0:
            surfacetype = "_atv";
            
            if ( pulse )
            {
                surfacetype = "_atv_pulse";
            }
            
            break;
        case 1:
            surfacetype = "_grass";
            break;
        case 2:
            surfacetype = "_wall";
            break;
    }
    
    if ( ballspeed >= heavyspeed )
    {
        soundintensity = "_heavy";
    }
    else if ( ballspeed >= mediumspeed )
    {
        soundintensity = "_medium";
    }
    
    soundalias = soundprefix + surfacetype + soundintensity;
    
    if ( isdefined( soundalias ) && isdefined( ball ) )
    {
        ball playsound( soundalias );
    }
}

// Namespace ballmode
// Params 0
// Checksum 0xb4a6a840, Offset: 0x30cf
// Size: 0x355
function function_5de74ae3bb261624()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( !isdefined( self.vehicle ) )
        {
            waitframe();
            continue;
        }
        
        self.vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        
        if ( !( isdefined( ent ) && isdefined( ent.owner ) ) )
        {
            continue;
        }
        
        if ( ent.targetname == "ball" )
        {
            pushball( self.vehicle, ent, normal, 1, position );
            continue;
        }
        
        isentityvehicle = isdefined( ent ) && ent.classname == "script_vehicle";
        var_e7efae76b65fadb = isdefined( ent.owner ) && ent.owner.team == self.team;
        
        if ( isentityvehicle && !var_e7efae76b65fadb && self.canram )
        {
            collisiondirection = vectornormalize( position - self.vehicle.origin );
            var_2fe09a9db68ccd3a = vectornormalize( anglestoforward( self.vehicle.angles ) );
            dotproduct = vectordot( collisiondirection, var_2fe09a9db68ccd3a );
            collisionangle = acos( dotproduct );
            
            if ( collisionangle < 60 )
            {
                if ( !isdefined( self.var_ccc8868e32ce49d9[ "ballmode_rammed_player" ] ) || gettime() - self.var_ccc8868e32ce49d9[ "ballmode_rammed_player" ] > 100 )
                {
                    points::doscoreevent( #"ballmode_rammed_player" );
                    self.var_ccc8868e32ce49d9[ "ballmode_rammed_player" ] = gettime();
                }
                
                self.pers[ "hasDoneAnyCombat" ] = 1;
                self.pers[ "lastRamTime" ] = mp_afk::function_a10af3f5e26c28da();
                ent.owner function_e104bcaccf2e2215( 0 );
                ent.owner.plotarmor = 0;
                ent.owner dodamage( ent.owner.maxhealth, ent.owner.origin, self, self.vehicle, "MOD_EXPLOSIVE", self.vehicle.objweapon, "torso_upper" );
                ent.owner hud_message::showsplash( "ballmode_rammed_by_player" );
                explosionfx = spawnfx( utility::getfx( "player_rammed" ), ent.origin );
                playsoundatpos( ent.origin, "veh9_dmg_mil_lnd_atv_codball_explode" );
                triggerfx( explosionfx );
                playrumbleonposition( "grenade_rumble", ent.origin );
                earthquake( 0.5, 1, ent.origin, 500 );
            }
        }
    }
}

// Namespace ballmode
// Params 0
// Checksum 0xfb0f1fb8, Offset: 0x342c
// Size: 0x179
function function_5db3694013dcf900()
{
    level endon( #"game_ended" );
    var_3f99da44a2e80ca3 = 0.1;
    var_6c3849c87feca70e = 1;
    var_762737efda02907e = 3;
    var_7c4f3623c2e0c6b9 = 0;
    var_add91596132cd5e3 = 0;
    var_311044492a69c742 = 200;
    var_d5ec9940d77da1c = 500;
    hitsurfacetype = 1;
    grasssurfacetype = 1;
    wallsurfacetype = 2;
    self physics_registerforcollisioncallback();
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        surface = physics_getsurfacetypefromflags( flag1 );
        surfacetype = getsubstr( surface[ "name" ], 9 );
        
        if ( normalspeed > var_3f99da44a2e80ca3 && surfacetype != "metal_car" )
        {
            if ( normalspeed > var_762737efda02907e )
            {
                var_7c4f3623c2e0c6b9 = var_d5ec9940d77da1c;
            }
            else if ( normalspeed > var_6c3849c87feca70e )
            {
                var_7c4f3623c2e0c6b9 = var_311044492a69c742;
            }
            else
            {
                var_7c4f3623c2e0c6b9 = var_add91596132cd5e3;
            }
            
            hitsurfacetype = grasssurfacetype;
            
            if ( surfacetype != "grass" )
            {
                hitsurfacetype = wallsurfacetype;
            }
            
            function_527b00c562e307db( self, var_7c4f3623c2e0c6b9, hitsurfacetype, 0 );
            waitframe();
        }
    }
}

// Namespace ballmode
// Params 2
// Checksum 0xa19f08bd, Offset: 0x35ad
// Size: 0x24
function vectorproject( v, onto )
{
    return vectordot( v, onto ) / vectordot( onto, onto );
}

// Namespace ballmode
// Params 0
// Checksum 0x43419e62, Offset: 0x35da
// Size: 0x453
function function_135523372fa9542a()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( !isdefined( level.ball ) )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( self.vehicle ) )
        {
            waitframe();
            continue;
        }
        
        toball = level.ball.origin - self.vehicle.origin;
        normal = vectornormalize( toball );
        forward = anglestoforward( self.vehicle.angles );
        left = anglestoleft( self.vehicle.angles );
        up = anglestoup( self.vehicle.angles );
        forwarddot = vectorproject( toball, forward * 90 );
        leftdot = vectorproject( toball, left * 60 );
        updot = vectorproject( toball, up * 85 );
        var_c56e200b6c73f819 = sqrt( forwarddot * forwarddot + leftdot * leftdot + updot * updot );
        
        if ( var_c56e200b6c73f819 < 1 )
        {
            if ( !isdefined( level.ball.recentlytouched ) )
            {
                level.ball.recentlytouched = [];
            }
            
            if ( !isdefined( level.ball.recentlytouched[ self.guid ] ) )
            {
                points::doscoreevent( #"ballmode_touched_ball" );
                level.ball.recentlytouched[ self.guid ] = self;
            }
            
            if ( self.canram )
            {
                if ( !isdefined( self.var_ccc8868e32ce49d9[ "ballmode_rammed_ball" ] ) || gettime() - self.var_ccc8868e32ce49d9[ "ballmode_rammed_ball" ] > 100 )
                {
                    points::doscoreevent( #"ballmode_rammed_ball" );
                    self.var_ccc8868e32ce49d9[ "ballmode_rammed_ball" ] = gettime();
                }
            }
            
            self.pers[ "hasDoneAnyCombat" ] = 1;
            self.pers[ "lastTouchTime" ] = mp_afk::function_a10af3f5e26c28da();
            goalent = undefined;
            
            if ( self.team == "allies" )
            {
                goalent = level.goalaxis;
            }
            else
            {
                goalent = level.goalallies;
            }
            
            if ( isdefined( goalent ) && level.ball.var_8f9b56802143d5ae != self )
            {
                var_58f425d712e4a839 = goalent.origin - level.ball.origin;
                var_1818035777caed01 = length( var_58f425d712e4a839 );
                var_60f1317838263aa3 = vectordot( level.ball.velocity, var_58f425d712e4a839 );
                
                if ( var_1818035777caed01 <= 500 && var_60f1317838263aa3 > 0 )
                {
                    velocitynormalized = vectornormalize( level.ball.velocity );
                    traceto = level.ball.origin + velocitynormalized * var_1818035777caed01;
                    trace = trace::sphere_trace( level.ball.origin, traceto, 28, [ self, self.vehicle, level.ball ] );
                    
                    if ( trace[ "fraction" ] > 0.99 )
                    {
                        thread function_3bc89f22927bb2c5();
                    }
                }
            }
            
            var_8f9b56802143d5ae = spawnstruct();
            var_8f9b56802143d5ae.player = self;
            
            if ( forwarddot < 0 )
            {
                velocity = self.vehicle vehicle_getvelocity();
                
                if ( vectordot( velocity, forward ) < 0 )
                {
                    var_8f9b56802143d5ae.var_a012024b84804990 = 1;
                }
            }
            
            level.ball.var_8f9b56802143d5ae = var_8f9b56802143d5ae;
            thread function_726b8d1680df7adf();
            pushball( self.vehicle, level.ball, normal, 1, level.ball.origin );
        }
        
        waitframe();
    }
}

// Namespace ballmode
// Params 0, eflags: 0x4
// Checksum 0xf34b920a, Offset: 0x3a35
// Size: 0x59
function private function_726b8d1680df7adf()
{
    self notify( #"hash_1e402f0cb4849f3b" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_1e402f0cb4849f3b" );
    wait level.assisttouchtime;
    level.ball.recentlytouched[ self.guid ] = undefined;
}

// Namespace ballmode
// Params 0, eflags: 0x4
// Checksum 0x91feb28c, Offset: 0x3a96
// Size: 0x63
function private function_3bc89f22927bb2c5()
{
    self notify( #"hash_dda8ce492dfdfb89" );
    level endon( #"game_ended" );
    level endon( #"ballmode_goal_scored" );
    self endon( #"disconnect" );
    self endon( #"hash_dda8ce492dfdfb89" );
    wait 1;
    points::doscoreevent( #"ballmode_save" );
    self.pers[ "hasDoneAnyCombat" ] = 1;
}

// Namespace ballmode
// Params 0
// Checksum 0xdb3808bc, Offset: 0x3b01
// Size: 0x396
function function_717ab26f25f5fdad()
{
    self endon( #"disconnect" );
    self endon( #"respawn" );
    level endon( #"game_ended" );
    self.lastpulse = 0;
    self.nitro = 100;
    self.var_27758cc61e8bb023 = getdvarint( @"hash_8839756ee5e73455", 1 );
    self.normalspeed = getdvarint( @"hash_b41aec456a71399a", 35 );
    fastspeed = getdvarint( @"hash_b8ee638db3d40fa6", 50 );
    var_cadcd2012c423d7d = getdvarfloat( @"hash_b7615c14184146dd", 8 );
    
    if ( self.var_c165c2ecea9ef0f6 && getdvarint( @"hash_bea2f654590e1855", 0 ) )
    {
        var_cadcd2012c423d7d = getdvarint( @"hash_bea2f654590e1855", 0 );
    }
    
    if ( self.var_c165c2ecea9ef0f6 && getdvarint( @"hash_21590fe81942ff74", 0 ) )
    {
        self.normalspeed = getdvarint( @"hash_21590fe81942ff74", 0 );
    }
    
    self.vehicle setscriptablepartstate( "pulse", "default", 1 );
    vfxready = 0;
    self.vehicle vehicle_settopspeedforward( self.normalspeed );
    
    while ( true )
    {
        if ( !isdefined( self.vehicle ) )
        {
            waitframe();
            continue;
        }
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.isstunned )
        {
            waitframe();
            continue;
        }
        
        self.nitro += var_cadcd2012c423d7d * level.framedurationseconds;
        
        if ( self.nitro > 100 )
        {
            self.nitro = 100;
        }
        
        self setclientomnvar( "ballmode_pulse_recharge", self.nitro / 100 );
        
        if ( self.nitro >= 100 )
        {
            if ( !vfxready )
            {
                self.vehicle setscriptablepartstate( "pulse", "pulse_ready", 1 );
                self playlocalsound( "mp_codball_pulse_ready_plr" );
                self playsound( "mp_codball_pulse_ready_npc", self, self );
                vfxready = 1;
            }
            
            if ( self jumpbuttonpressed() )
            {
                self.nitro = 0;
                self setclientomnvar( "ballmode_pulse_recharge", self.nitro / 100 );
                self.lastpulse = self.codballtime;
                self.var_e7e6e9d2aa3aa08d = self.atmaxspeed;
                vfxready = 0;
                self.vehicle vehicle_settopspeedforward( fastspeed );
                self.vehicle setscriptablepartstate( "pulse", "pulsing", 1 );
                self playlocalsound( "mp_codball_pulse_plr" );
                self playsound( "mp_codball_pulse_npc", self, self );
                self earthquakeforplayer( 0.15, 0.5, self.origin, 5000 );
                points::doscoreevent( #"ballmode_pulse" );
                self.pers[ "hasDoneAnyCombat" ] = 1;
                
                for ( x = 0; x < 5 ; x++ )
                {
                    self.vehicle vehphys_impulse( anglestoforward( self.vehicle.angles ), 55, 0 );
                    wait 0.1;
                    
                    if ( !isdefined( self.vehicle ) )
                    {
                        break;
                    }
                }
                
                wait 0.5;
                
                if ( !isdefined( self.vehicle ) )
                {
                    break;
                }
                
                self.vehicle vehicle_settopspeedforward( self.normalspeed );
                self.vehicle setscriptablepartstate( "pulse", "default", 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace ballmode
// Params 0
// Checksum 0x10b8264b, Offset: 0x3e9f
// Size: 0x18d
function function_d8d6a4cb6296f20d()
{
    self endon( #"disconnect" );
    self endon( #"respawn" );
    self.vehicle setscriptablepartstate( "max_speed", "default", 1 );
    playingmaxspeed = 0;
    self.atmaxspeed = 0;
    maxspeedtime = 0;
    
    while ( true )
    {
        if ( !isdefined( self.vehicle ) )
        {
            waitframe();
            continue;
        }
        
        velocity = self.vehicle vehicle_getvelocity();
        
        if ( length( velocity ) > 530 && vectordot( anglestoforward( self.vehicle.angles ), velocity ) > 0 )
        {
            self.atmaxspeed = 1;
            
            if ( !playingmaxspeed )
            {
                playingmaxspeed = 1;
                
                if ( getdvarint( @"hash_3d45b5bad11c6ff1", 1 ) )
                {
                    self.vehicle setscriptablepartstate( "max_speed", "max_speed", 1 );
                }
            }
        }
        
        if ( length( velocity ) < 100 )
        {
            if ( playingmaxspeed )
            {
                playingmaxspeed = 0;
                self.vehicle setscriptablepartstate( "max_speed", "default", 1 );
                self.atmaxspeed = 0;
            }
        }
        
        waitframe();
        maxspeedtime += level.framedurationseconds;
        
        if ( maxspeedtime >= 0.25 )
        {
            maxspeedtime -= 0.25;
            
            if ( !self.atmaxspeed )
            {
                if ( playingmaxspeed )
                {
                    playingmaxspeed = 0;
                    self.vehicle setscriptablepartstate( "max_speed", "default", 1 );
                }
            }
            
            self.atmaxspeed = 0;
        }
    }
}

// Namespace ballmode
// Params 0
// Checksum 0xf2535d88, Offset: 0x4034
// Size: 0xe1
function function_123cb4f587732f8d()
{
    self endon( #"disconnect" );
    self endon( #"respawn" );
    self.canram = 0;
    self.vehicle setscriptablepartstate( "ramming", "default", 1 );
    
    while ( true )
    {
        if ( !isdefined( self.vehicle ) )
        {
            waitframe();
            continue;
        }
        
        var_77fbf16cb6eaf1a8 = function_77fbf16cb6eaf1a8();
        
        if ( !var_77fbf16cb6eaf1a8 )
        {
            waitframe();
            continue;
        }
        
        if ( self.var_e7e6e9d2aa3aa08d )
        {
            self.vehicle setscriptablepartstate( "ramming", "ramming", 1 );
            
            if ( !level.var_26871b995fade719 )
            {
                self.canram = 1;
            }
        }
        
        wait self.var_27758cc61e8bb023;
        self.vehicle setscriptablepartstate( "ramming", "default", 1 );
        self.canram = 0;
        waitframe();
    }
}

// Namespace ballmode
// Params 1, eflags: 0x4
// Checksum 0xc169a23a, Offset: 0x411d
// Size: 0x8a
function private listenforvehicleexit( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !level.listenforvehicleexit )
    {
        return;
    }
    
    while ( isdefined( player.vehicle ) && !player.vehicle.isdestroyed )
    {
        waitframe();
    }
    
    player.plotarmor = 0;
    player dodamage( player.maxhealth, player.origin );
}

// Namespace ballmode
// Params 0
// Checksum 0xc6185abd, Offset: 0x41af
// Size: 0x54
function deleteondisconnect()
{
    level endon( #"game_ended" );
    self endon( #"respawn" );
    previousvehicle = self.vehicle;
    self waittill( #"death_or_disconnect" );
    vehicle_occupancy::exit( previousvehicle, "driver", self );
    vehicle::death( previousvehicle );
}

// Namespace ballmode
// Params 1
// Checksum 0x99dbca36, Offset: 0x420b
// Size: 0xe2
function function_167d3b846e6d9a60( ball )
{
    while ( true )
    {
        if ( isdefined( level.ball ) && isdefined( level.ball.origin ) )
        {
            if ( !isdefined( level.ball.oldorigin ) )
            {
                level.ball.oldorigin = level.ball.origin;
            }
            
            level.ball.velocity = ( level.ball.origin - level.ball.oldorigin ) / level.framedurationseconds;
            level.ball.oldorigin = level.ball.origin;
        }
        
        waitframe();
    }
}

// Namespace ballmode
// Params 0
// Checksum 0x2b54a471, Offset: 0x42f5
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace ballmode
// Params 0
// Checksum 0x1c002bb5, Offset: 0x4315
// Size: 0x177
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    level.scorelimitoverride = 1;
    level.roundenddelay = 3;
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    bradley_spawner::inittankspawns();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace ballmode
// Params 0
// Checksum 0xbe7fe61e, Offset: 0x4494
// Size: 0xce
function updategametypedvars()
{
    level.postgoalcooldown = dvars::dvarintvalue( "postGoalCooldown", 8, 0, 10 );
    level.assisttouchtime = dvars::dvarintvalue( "assistTouchTime", 10, 0, 30 );
    level.disableplayeroutlines = dvars::dvarintvalue( "disablePlayerOutlines", 0, 0, 1 );
    level.useredandblueplayeroutlines = dvars::dvarintvalue( "useRedAndBluePlayerOutlines", 0, 0, 1 );
    level.useredandbluegoalscoresplashes = dvars::dvarintvalue( "useRedAndBlueGoalScoreSplashes", 1, 0, 1 );
    level.useteamnamesongoalscoresplashes = dvars::dvarintvalue( "useTeamNamesOnGoalScoreSplashes", 0, 0, 1 );
    level.forceretryonvehicleoccupancyfailed = dvars::dvarintvalue( "forceRetryOnVehicleOccupancyFailed", 1, 0, 1 );
    level.listenforvehicleexit = dvars::dvarintvalue( "listenForVehicleExit", 1, 0, 1 );
    common::updatecommongametypedvars();
}

// Namespace ballmode
// Params 0
// Checksum 0xda261286, Offset: 0x456a
// Size: 0x148
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace ballmode
// Params 0
// Checksum 0xe4ce41b8, Offset: 0x46ba
// Size: 0x88
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    
    if ( spawnteam == game[ "attackers" ] )
    {
        spawnlogic::activatespawnset( #"start_attackers", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
    }
    else
    {
        spawnlogic::activatespawnset( #"start_defenders", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
    }
    
    return spawnpoint;
}

// Namespace ballmode
// Params 1
// Checksum 0x6dda0ae, Offset: 0x474b
// Size: 0x1c
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace ballmode
// Params 6
// Checksum 0x22d72179, Offset: 0x476f
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace ballmode
// Params 0
// Checksum 0xbbd6d218, Offset: 0x47bf
// Size: 0x10f
function ontimelimit()
{
    winner = gamescore::gethighestscoringteam();
    
    if ( game[ "status" ] == "overtime" )
    {
        level thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    if ( winner == "tie" )
    {
        foreach ( player in level.players )
        {
            player hud_message::showsplash( "ballmode_overtime_banner" );
        }
        
        game[ "status" ] = "overtime";
        level.starttime = gettime();
        level.timelimit = getdvarint( @"overtimelimit" );
        return;
    }
    
    level thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

/#

    // Namespace ballmode
    // Params 0
    // Checksum 0xd34c19e8, Offset: 0x48d6
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x4a>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x55>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x4a>", "<dev string:x68>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x55>", "<dev string:x68>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace ballmode
// Params 1
// Checksum 0xfd0f49e3, Offset: 0x4b60
// Size: 0x26
function enemyteam( friendlyteam )
{
    if ( friendlyteam == "allies" )
    {
        return "axis";
    }
    
    return "allies";
}

// Namespace ballmode
// Params 0
// Checksum 0xe88bb038, Offset: 0x4b8e
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

// Namespace ballmode
// Params 1
// Checksum 0xc16cb66, Offset: 0x4be4
// Size: 0x52
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.ballmodeloadout;
    player allowspectateallteams( 0 );
    player.var_ccc8868e32ce49d9 = [];
    player.var_c165c2ecea9ef0f6 = 0;
}

// Namespace ballmode
// Params 0
// Checksum 0x89591878, Offset: 0x4c3e
// Size: 0x19a
function setspecialloadout()
{
    level.ballmodeloadout[ "loadoutPrimary" ] = "iw9_me_fists";
    level.ballmodeloadout[ "loadoutPrimaryAttachment" ] = "none";
    level.ballmodeloadout[ "loadoutPrimaryAttachment2" ] = "none";
    level.ballmodeloadout[ "loadoutPrimaryCamo" ] = "none";
    level.ballmodeloadout[ "loadoutPrimaryReticle" ] = "none";
    level.ballmodeloadout[ "loadoutPrimaryVariantID" ] = 0;
    level.ballmodeloadout[ "loadoutSecondary" ] = "none";
    level.ballmodeloadout[ "loadoutSecondaryAttachment" ] = "none";
    level.ballmodeloadout[ "loadoutSecondaryAttachment2" ] = "none";
    level.ballmodeloadout[ "loadoutSecondaryCamo" ] = "none";
    level.ballmodeloadout[ "loadoutSecondaryReticle" ] = "none";
    level.ballmodeloadout[ "loadoutSecondaryVariantID" ] = 0;
    level.ballmodeloadout[ "loadoutEquipment" ] = "specialty_null";
    level.ballmodeloadout[ "loadoutOffhand" ] = "none";
    level.ballmodeloadout[ "loadoutStreakType" ] = "assault";
    level.ballmodeloadout[ "loadoutKillstreak1" ] = "none";
    level.ballmodeloadout[ "loadoutKillstreak2" ] = "none";
    level.ballmodeloadout[ "loadoutKillstreak3" ] = "none";
    level.ballmodeloadout[ "loadoutPerks" ] = [];
    level.ballmodeloadout[ "loadoutGesture" ] = "playerData";
}

// Namespace ballmode
// Params 2, eflags: 0x4
// Checksum 0x2a9a7b6a, Offset: 0x4de0
// Size: 0xfe
function private function_a18f6bdaae2f6775( player, scoringteam )
{
    if ( !( isdefined( player ) && isdefined( player.team ) && isdefined( scoringteam ) ) )
    {
        return;
    }
    
    teamname = undefined;
    teamcolor = undefined;
    
    if ( level.useteamnamesongoalscoresplashes )
    {
        teamname = scoringteam;
    }
    else if ( player.team == scoringteam )
    {
        teamname = "friendly";
    }
    else
    {
        teamname = "enemy";
    }
    
    if ( !level.useredandbluegoalscoresplashes )
    {
        teamcolor = scoringteam == "allies" ? "yellow" : "green";
    }
    else if ( player.team == scoringteam )
    {
        teamcolor = "blue";
    }
    else
    {
        teamcolor = "red";
    }
    
    splashname = function_5d044133536d0766( "_", [ "ballmode_goal_score", teamname, teamcolor ] );
    player hud_message::showsplash( splashname );
}

