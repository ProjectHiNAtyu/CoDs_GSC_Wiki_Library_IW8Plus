// scripts\mp\br\gametypes\br_respawn.gsc  (hash_07529da83adc531e.gscc) (size: 22567 Bytes / 0x5827 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85872aff (2240228095)
// size ...... 22567 (0x5827)
// includes .. 10  (offset: 0x54ab)
// strings ... 43  (offset: 0x54fb)
// dev strs .. 10  (offset: 0x579f)
// exports ... 68  (offset: 0x3323)
// cseg ...... 0x3df + 0x2f44 (0x3323)
// imports ... 194 (offset: 0x3dc3)
// animtree1 . 0   (offset: 0x5827)
// animtree2 . 0   (offset: 0x5827)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\class;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;

#namespace br_respawn;

// Namespace br_respawn
// Params 0
// Checksum 0x64c44c26, Offset: 0x3fd
// Size: 0x81
function init()
{
    setdvarifuninitialized( @"scr_br_respawn", 0 );
    level.br_respawn_enabled = getdvarint( @"scr_br_respawn", 0 ) != 0;
    
    if ( !level.br_respawn_enabled )
    {
        removeambulances();
        return;
    }
    
    level._effect[ "ambulance_light" ] = loadfxasset( "vfx_iw8_level_stpetersburg_stpburg_police_lights" );
    level.br_respawnambulances = [];
    br_circle::registercirclecallbacks( 6, &dangercircletick );
    thread setuphud();
    
    /#
        thread debugrespawn();
    #/
}

// Namespace br_respawn
// Params 0
// Checksum 0x204346de, Offset: 0x486
// Size: 0x69
function removeambulances()
{
    ambulancestructs = utility::getstructarray( "br_respawn_station", "targetname" );
    
    for ( i = 0; i < ambulancestructs.size ; i++ )
    {
        collision = getent( ambulancestructs[ i ].target, #targetname );
        
        if ( isdefined( collision ) )
        {
            collision delete();
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x3e5b481b, Offset: 0x4f7
// Size: 0xc2
function spawnambulance( struct )
{
    if ( !level.br_respawn_enabled )
    {
        return;
    }
    
    ambulance = spawn( "script_model", struct.origin );
    
    if ( isdefined( struct.angles ) )
    {
        ambulance.angles = struct.angles;
    }
    else
    {
        ambulance.angles = ( 0, 0, 0 );
    }
    
    ambulance setmodel( "veh8_civ_lnd_palfa_ambulance_ukraine" );
    ambulance.struct = struct;
    ambulance ambulancesetup( struct );
    ambulance thread ambulancethink();
    level.br_respawnambulances[ level.br_respawnambulances.size ] = ambulance;
    return ambulance;
}

// Namespace br_respawn
// Params 1
// Checksum 0x172ddbd9, Offset: 0x5c2
// Size: 0x175
function ambulancesetup( struct )
{
    thread ambulancelights();
    def_struct = utility::getstruct( struct.target, "targetname" );
    
    if ( !isdefined( self.defibrillator ) )
    {
        defibrillator = spawn( "script_model", def_struct.origin );
        
        if ( isdefined( def_struct.angles ) )
        {
            defibrillator.angles = def_struct.angles;
        }
        
        defibrillator setmodel( "medical_defibrillator_wall_01" );
        defibrillator makeusable();
        defibrillator setcursorhint( "HINT_NOICON" );
        defibrillator setuseholdduration( "duration_medium" );
        defibrillator sethintdisplayfov( 120 );
        defibrillator setusefov( 120 );
        defibrillator setuserange( 80 );
        defibrillator sethintstring( &"mp/br_respawn_take" );
        defibrillator hudoutlineenable( "outline_depth_red" );
        defibrillator setusepriority( -1 );
        defibrillator setasgametypeobjective();
        self.defibrillator = defibrillator;
    }
    
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    self.objectiveiconid = objectiveiconid;
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "invisible", ( 0, 0, 0 ) );
        objidpoolmanager::update_objective_onentity( objectiveiconid, self );
        objidpoolmanager::update_objective_state( objectiveiconid, "active" );
        objidpoolmanager::update_objective_icon( objectiveiconid, "hud_icon_respawn" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0x8ae363c6, Offset: 0x73f
// Size: 0x6a
function ambulancelights()
{
    wait 1;
    dir = anglestoforward( self.angles );
    self.fx = spawnfx( utility::getfx( "ambulance_light" ), self.origin + ( 0, 0, 75 ), dir, ( 0, 0, 1 ) );
    triggerfx( self.fx );
}

// Namespace br_respawn
// Params 0
// Checksum 0x1e9a0bc3, Offset: 0x7b1
// Size: 0x40
function ambulancethink()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.defibrillator waittill( #"trigger", player );
        ambulancedefibrillator( player );
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0x8ba23f4a, Offset: 0x7f9
// Size: 0xc
function setuphud()
{
    level.br_deadcountdownhud = [];
}

// Namespace br_respawn
// Params 0
// Checksum 0x8c164d18, Offset: 0x80d
// Size: 0x20
function initplayer()
{
    if ( !level.br_respawn_enabled )
    {
        return;
    }
    
    hideallambulancesforplayer( self );
    disableallambulancesforplayer( self );
}

// Namespace br_respawn
// Params 2
// Checksum 0x5ebf7864, Offset: 0x835
// Size: 0xbd
function hideallambulancesforteam( team, var_4ff48faaaeb3d3b0 )
{
    if ( var_4ff48faaaeb3d3b0 )
    {
        respawnableplayers = getrespawnableplayers( team );
        
        if ( respawnableplayers.size > 0 )
        {
            return;
        }
    }
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) )
        {
            hideallambulancesforplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x1cf0a6ef, Offset: 0x8fa
// Size: 0x65
function hideallambulancesforplayer( player )
{
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( isdefined( ambulance ) && !ambulance.disabled )
        {
            ambulance ambulancehidefromplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x92d8795c, Offset: 0x967
// Size: 0x3b
function ambulancehidefromplayer( player )
{
    if ( isdefined( self.defibrillator ) )
    {
        self.defibrillator hudoutlinedisableforclient( player );
    }
    
    objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
}

// Namespace br_respawn
// Params 1
// Checksum 0xc60001cb, Offset: 0x9aa
// Size: 0x65
function disableallambulancesforplayer( player )
{
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( isdefined( ambulance ) && !ambulance.disabled )
        {
            ambulance ambulancemakeunusabletoplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xfcf4decf, Offset: 0xa17
// Size: 0x29
function ambulancemakeunusabletoplayer( player )
{
    if ( isdefined( self.defibrillator ) )
    {
        self.defibrillator disableplayeruse( player );
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xabd1143c, Offset: 0xa48
// Size: 0x94
function showallambulancesforteam( team )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) )
        {
            showallambulancesforplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x9104fb8c, Offset: 0xae4
// Size: 0x65
function showallambulancesforplayer( player )
{
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( isdefined( ambulance ) && !ambulance.disabled )
        {
            ambulance ambulanceshowtoplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xb0daec6e, Offset: 0xb51
// Size: 0x33
function ambulanceshowtoplayer( player )
{
    self.defibrillator hudoutlineenableforclient( player, "outline_depth_red" );
    objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
}

// Namespace br_respawn
// Params 1
// Checksum 0x2a919866, Offset: 0xb8c
// Size: 0x94
function ambulanceenabletoteam( team )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) )
        {
            ambulancemakeusabletoplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xf018c6d7, Offset: 0xc28
// Size: 0x94
function ambulancedisabletoteam( team )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) )
        {
            ambulancemakeunusabletoplayer( player );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x7c629d08, Offset: 0xcc4
// Size: 0x1c
function ambulancemakeusabletoplayer( player )
{
    self.defibrillator enableplayeruse( player );
}

// Namespace br_respawn
// Params 0
// Checksum 0x33a99473, Offset: 0xce8
// Size: 0x70
function ambulancedisable()
{
    self notify( #"disabled" );
    self.disabled = 1;
    self.defibrillator makeunusable();
    self.defibrillator hudoutlinedisable();
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    
    if ( isdefined( self.fx ) )
    {
        self.fx delete();
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0x426284ee, Offset: 0xd60
// Size: 0x2c
function ambulancemakeunsabletoall()
{
    self.defibrillator sethintstring( &"mp/br_respawn_charging" );
    self.defibrillator setuseholdduration( "duration_none" );
}

// Namespace br_respawn
// Params 0
// Checksum 0xda0d52f7, Offset: 0xd94
// Size: 0xc2
function ambulancemakeusable()
{
    self.defibrillator sethintstring( &"mp/br_respawn_take" );
    self.defibrillator setuseholdduration( "duration_medium" );
    players = getallrespawnableplayers();
    
    foreach ( player in players )
    {
        player.respawnent useentsetupcloseambulance( player.team );
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0x7ab11e3b, Offset: 0xe5e
// Size: 0x55, Type: bool
function anyambulancesavailable()
{
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( isdefined( ambulance ) && !ambulance.disabled )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_respawn
// Params 3
// Checksum 0xdd0416e8, Offset: 0xebc
// Size: 0xb5
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    
    if ( !level.br_respawn_enabled )
    {
        return;
    }
    
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( isdefined( ambulance ) && !ambulance.disabled && distance2dsquared( dangercircleorigin, ambulance.origin ) > var_1bdc861911b3625e * var_1bdc861911b3625e )
        {
            ambulance ambulancedisable();
            disablerespawnscenarios( ambulance );
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x8110dc83, Offset: 0xf79
// Size: 0x100
function disablerespawnscenarios( ambulance )
{
    disableall = !anyambulancesavailable();
    
    if ( !disableall && !isdefined( ambulance ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.respawnent ) && disableall )
        {
            player.respawnent notify( #"respawnComplete", 0 );
            continue;
        }
        
        if ( player.usedambulance == ambulance )
        {
            player notify( #"defibrillator_done" );
            player notify( #"portable_defibrillator_done" );
        }
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0xdf17e191, Offset: 0x1081
// Size: 0x30, Type: bool
function playershoulddofauxdeath()
{
    return level.br_respawn_enabled && anyambulancesavailable() && ( self.brwasinlaststand || isdefined( self.respawnent ) );
}

// Namespace br_respawn
// Params 0
// Checksum 0xb5f00e66, Offset: 0x10ba
// Size: 0x16
function playersetinlaststand()
{
    self.brwasinlaststand = 1;
    br_public::setplayerdownedextrainfo( 1 );
}

// Namespace br_respawn
// Params 2
// Checksum 0xfe3f7906, Offset: 0x10d8
// Size: 0x24e
function playerdied( attacker, objweapon )
{
    if ( !level.br_respawn_enabled )
    {
        return;
    }
    
    if ( !anyambulancesavailable() )
    {
        if ( self.fauxdead )
        {
            thread playerlogic::spawnspectator( self.origin, self.angles );
        }
        
        return;
    }
    
    self.brwasinlaststand = undefined;
    team = self.team;
    
    /#
        if ( getdvarint( @"scr_br_respawn_solo", 0 ) != 0 )
        {
            host = gamelogic_mp::gethostplayer();
            team = host.team;
        }
    #/
    
    if ( level.teamdata[ team ][ "alivePlayers" ].size == 0 )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isdefined( player.respawnent ) )
            {
                player.respawnent notify( #"respawnComplete", 0 );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.body ) )
    {
        self.body delete();
    }
    else
    {
        self.nocorpse = 1;
    }
    
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "br_respawn::playerDied()" );
    self.health = 1;
    thread playerkeeploadingstreamedassets();
    useent = createpickupuseent( self.origin, team );
    useent.timerhud = createplayerdeadcountdownhud( team, 180 );
    updatecountdownhudlist( useent.timerhud );
    useent.drophud = createdropplayerhud( team );
    useent thread useentrespawntimeout( 180, self, team );
    useent thread useentrespawncomplete( self, team );
    useent thread useentpickupbody( self, team );
    useent useentsetupcloseambulance( team );
    self.respawnent = useent;
    playerfakespectate( 1 );
}

// Namespace br_respawn
// Params 1
// Checksum 0xc2f5212a, Offset: 0x132e
// Size: 0x133
function updatecountdownhudlist( timerhud )
{
    var_8ddb0f187442f5da = -50;
    var_8ddb10187442f80d = -100;
    var_960025d42da40dd1 = -15;
    
    if ( isdefined( timerhud ) )
    {
        level.br_deadcountdownhud[ level.br_deadcountdownhud.size ] = timerhud;
    }
    
    for ( i = 1; i < level.br_deadcountdownhud.size ; i++ )
    {
        huditem = level.br_deadcountdownhud[ i ];
        
        for ( j = i - 1; j >= 0 && getsoonerhud( huditem, level.br_deadcountdownhud[ j ] ) == huditem ; j-- )
        {
            level.br_deadcountdownhud[ j + 1 ] = level.br_deadcountdownhud[ j ];
        }
        
        level.br_deadcountdownhud[ j + 1 ] = huditem;
    }
    
    for ( i = 0; i < level.br_deadcountdownhud.size ; i++ )
    {
        huditem = level.br_deadcountdownhud[ i ];
        
        if ( isdefined( huditem ) )
        {
            huditem hud_util::setpoint( "BOTTOM RIGHT", "BOTTOM RIGHT", var_8ddb0f187442f5da, var_8ddb10187442f80d + var_960025d42da40dd1 * i );
        }
    }
}

// Namespace br_respawn
// Params 2
// Checksum 0x9cd8987e, Offset: 0x1469
// Size: 0x4c
function getsoonerhud( huda, hudb )
{
    if ( !isdefined( hudb ) )
    {
        return huda;
    }
    
    if ( !isdefined( huda ) )
    {
        return hudb;
    }
    
    if ( huda.starttime <= hudb.starttime )
    {
        return huda;
    }
    
    return hudb;
}

// Namespace br_respawn
// Params 1
// Checksum 0xffb2cff1, Offset: 0x14bd
// Size: 0xa8
function playerfakespectate( enabled )
{
    allowactions = !enabled;
    self allowmelee( allowactions );
    self allowads( allowactions );
    self allowfire( allowactions );
    self allowcrouch( allowactions );
    self allowprone( allowactions );
    self allowreload( allowactions );
    self setcandamage( allowactions );
    
    if ( allowactions )
    {
        self enableusability();
        self enableoffhandweapons();
        self unlink();
        self setcamerathirdperson( 0 );
        self notify( #"hash_34c88168a3bf7b73" );
        self setclientomnvar( "ui_show_spectateHud", -1 );
        return;
    }
    
    self disableusability();
    self disableoffhandweapons();
    thread playerfakespectatecontrols();
    self setcamerathirdperson( 1 );
}

// Namespace br_respawn
// Params 0
// Checksum 0x89ed37c2, Offset: 0x156d
// Size: 0x109
function playerfakespectatecontrols()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_34c88168a3bf7b73" );
    var_b610d2c9716d3022 = undefined;
    
    while ( true )
    {
        next = self fragbuttonpressed();
        prev = self secondaryoffhandbuttonpressed();
        
        if ( next || prev || !isalive( var_b610d2c9716d3022 ) || isdefined( var_b610d2c9716d3022.respawnent ) || var_b610d2c9716d3022.fauxdead )
        {
            var_6b2110e6873b34fb = getplayertospectate( self.team, var_b610d2c9716d3022, next || !isdefined( var_b610d2c9716d3022 ) );
            
            if ( var_b610d2c9716d3022 != var_6b2110e6873b34fb )
            {
                var_b610d2c9716d3022 = var_6b2110e6873b34fb;
                self playerlinktodelta( var_b610d2c9716d3022, "tag_eye" );
                self setclientomnvar( "ui_show_spectateHud", var_b610d2c9716d3022 getentitynumber() );
                player_utility::function_dbe5a52a6654a982();
                player_utility::function_9d378d725bb4831e( "br_respawn::playerFakeSpectateControls()" );
            }
            
            if ( next )
            {
                while ( self fragbuttonpressed() )
                {
                    waitframe();
                }
            }
            else if ( prev )
            {
                while ( self secondaryoffhandbuttonpressed() )
                {
                    waitframe();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_respawn
// Params 3
// Checksum 0x148346a3, Offset: 0x167e
// Size: 0xe2
function getplayertospectate( team, current, getnext )
{
    curindex = 0;
    
    if ( isdefined( current ) )
    {
        for ( i = 0; i < level.teamdata[ team ][ "alivePlayers" ].size ; i++ )
        {
            player = level.teamdata[ team ][ "alivePlayers" ][ i ];
            
            if ( player == current )
            {
                curindex = i;
                break;
            }
        }
    }
    
    if ( getnext )
    {
        curindex = ( curindex + 1 ) % level.teamdata[ team ][ "alivePlayers" ].size;
    }
    else
    {
        curindex--;
        
        if ( curindex < 0 )
        {
            curindex = level.teamdata[ team ][ "alivePlayers" ].size - 1;
        }
    }
    
    return level.teamdata[ team ][ "alivePlayers" ][ curindex ];
}

// Namespace br_respawn
// Params 0
// Checksum 0xf82a1b4b, Offset: 0x1769
// Size: 0x87
function playerkeeploadingstreamedassets()
{
    self endon( #"disconnect" );
    self waittill( #"spawned" );
    self endon( #"spawned" );
    
    while ( true )
    {
        loadoutstruct = class::preloadandqueueclass( self.class, 1 );
        playerassets = playerlogic::getplayerassets( loadoutstruct );
        
        while ( !playerlogic::allplayershaveassetsloaded( playerassets ) )
        {
            wait 0.1;
        }
        
        while ( playerlogic::allplayershaveassetsloaded( playerassets ) )
        {
            wait 1;
        }
    }
}

// Namespace br_respawn
// Params 3
// Checksum 0x4d936677, Offset: 0x17f8
// Size: 0x138
function useentrespawntimeout( countdowntime, deadplayer, team )
{
    self endon( #"respawnComplete" );
    deadplayer utility::waittill_any_timeout_no_endon_death( countdowntime, "disconnect" );
    self notify( #"timeout" );
    waittillframeend();
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) && player.usedambulance == self.ambulance )
        {
            player notify( #"defibrillator_done" );
        }
    }
    
    if ( isdefined( deadplayer ) )
    {
        deadplayer playerfakespectate( 0 );
        deadplayer thread playerlogic::spawnspectator( deadplayer.respawnent.origin, deadplayer.respawnent.angles );
    }
    
    cleanupbodydrop( self, team );
}

// Namespace br_respawn
// Params 2
// Checksum 0x5004796d, Offset: 0x1938
// Size: 0xd7
function useentrespawncomplete( deadplayer, team )
{
    self endon( #"timeout" );
    deadplayer endon( #"disconnect" );
    self waittill( #"respawnComplete", result );
    
    if ( result )
    {
        if ( isdefined( deadplayer.body ) )
        {
            deadplayer.body delete();
        }
        
        deadplayer playerrespawn( self.origin, self.angles );
    }
    else if ( isdefined( deadplayer ) )
    {
        deadplayer playerfakespectate( 0 );
        deadplayer thread playerlogic::spawnspectator( deadplayer.respawnent.origin, deadplayer.respawnent.angles );
    }
    
    waittillframeend();
    cleanupbodydrop( self, team );
}

// Namespace br_respawn
// Params 2
// Checksum 0xe0d3cea5, Offset: 0x1a17
// Size: 0x52
function playerrespawn( origin, angles )
{
    playerfakespectate( 0 );
    self.forcespawnorigin = origin;
    self.forcespawnangles = angles;
    self.isrespawn = 1;
    self.alreadyaddedtoalivecount = 1;
    playerlogic::spawnplayer( 0, 0 );
}

// Namespace br_respawn
// Params 2
// Checksum 0x959e27db, Offset: 0x1a71
// Size: 0xac
function useentpickupbody( deadplayer, team )
{
    self endon( #"respawnComplete" );
    self endon( #"timeout" );
    deadplayer endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isdefined( deadplayer.body ) )
        {
            deadplayer.body delete();
        }
        
        if ( player.team != team )
        {
            continue;
        }
        
        useenthide( team );
        player playerpickupbody( self, team );
        useentshow( team );
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x49c1d588, Offset: 0x1b25
// Size: 0x22
function useenthide( team )
{
    self makeunusable();
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
}

// Namespace br_respawn
// Params 1
// Checksum 0xee988f68, Offset: 0x1b4f
// Size: 0x33
function useentshow( team )
{
    self makeusable();
    objidpoolmanager::objective_teammask_single( self.objectiveiconid, team );
    objective_setplayintro( self.objectiveiconid, 0 );
}

// Namespace br_respawn
// Params 2
// Checksum 0x3f4413d4, Offset: 0x1b8a
// Size: 0x1e2
function playerpickupbody( useent, team )
{
    self endon( #"droppedbody" );
    holdingbodyhud = hud_util::createfontstring( "default", 1.5 );
    holdingbodyhud hud_util::setpoint( "CENTER", "CENTER", 0, 120 );
    holdingbodyhud.label = &"mp/br_respawn_body";
    self.holdingbodyhud = holdingbodyhud;
    
    if ( isdefined( useent.ambulance ) )
    {
        useent.ambulance ambulancedisabletoteam( team );
        useent.ambulance = undefined;
    }
    
    useent scriptmodelplayanim( "sdr_cp_hostage_walk_hostage" );
    useent linkto( self, "j_clavicle_le", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    useent thread useentdropbodyonplayerdone( self, holdingbodyhud, team );
    useent thread useentdropbodywhencomplete( self, holdingbodyhud, team );
    useent thread useentmonitorambulances( team );
    self allowads( 0 );
    self allowcrouch( 0 );
    self allowprone( 0 );
    self allowjump( 0 );
    playersetcarryteammates( 1 );
    showallambulancesforteam( team );
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( isdefined( player ) )
        {
            player notify( #"defibrillator_done" );
            player thread hud_message::showsplash( "br_respawn_start" );
        }
    }
    
    while ( !self stancebuttonpressed() || !self isonground() )
    {
        waitframe();
    }
    
    dropbody( useent, self, holdingbodyhud, team );
}

// Namespace br_respawn
// Params 1
// Checksum 0x445f818e, Offset: 0x1d74
// Size: 0xfe
function playersetcarryteammates( carrying )
{
    self.carrying = carrying;
    teammates = level.teamdata[ self.team ][ "players" ];
    
    /#
        if ( getdvarint( @"scr_br_respawn_solo", 0 ) != 0 )
        {
            teammates = level.players;
        }
    #/
    
    foreach ( player in teammates )
    {
        if ( isdefined( player.respawnent ) )
        {
            if ( !carrying )
            {
                player.respawnent enableplayeruse( self );
                continue;
            }
            
            player.respawnent disableplayeruse( self );
        }
    }
}

// Namespace br_respawn
// Params 3
// Checksum 0xc0a94891, Offset: 0x1e7a
// Size: 0x4e
function useentdropbodyonplayerdone( playerholding, holdingbodyhud, team )
{
    self endon( #"droppedbody" );
    playerholding utility::waittill_any( "disconnect", "death", "last_stand_enter" );
    dropbody( self, playerholding, holdingbodyhud, team );
}

// Namespace br_respawn
// Params 3
// Checksum 0xba5c03d8, Offset: 0x1ed0
// Size: 0x47
function useentdropbodywhencomplete( playerholding, holdingbodyhud, team )
{
    self endon( #"droppedbody" );
    utility::waittill_any( "timeout", "respawnComplete" );
    dropbody( self, playerholding, holdingbodyhud, team );
}

// Namespace br_respawn
// Params 4
// Checksum 0xe1d80829, Offset: 0x1f1f
// Size: 0x15a
function dropbody( useent, playerholding, holdingbodyhud, team )
{
    if ( isdefined( playerholding ) )
    {
        playerholding allowads( 1 );
        playerholding allowcrouch( 1 );
        playerholding allowprone( 1 );
        playerholding allowjump( 1 );
        playerholding playersetcarryteammates( 0 );
    }
    
    if ( isdefined( holdingbodyhud ) )
    {
        holdingbodyhud destroy();
    }
    
    if ( useent islinked() )
    {
        useent unlink();
    }
    
    origin = undefined;
    
    if ( isdefined( playerholding ) )
    {
        useent.angles = playerholding.angles;
        origin = playerholding.origin;
        useent.origin = origin + ( 0, 0, 40 );
    }
    else
    {
        origin = useent.origin;
        useent.origin = origin + ( 0, 0, 40 );
    }
    
    useent.drophud.alpha = 0;
    useent useentsetupcloseambulance( team );
    useent scriptmodelplayanim( "sdr_cp_hostage_dropoff_ground_idle_pilot" );
    useent scriptmodelpauseanim( 1 );
    useent.origin = origin + ( 0, 0, 1 );
    useent notify( #"droppedbody" );
}

// Namespace br_respawn
// Params 1
// Checksum 0x142622b0, Offset: 0x2081
// Size: 0x42
function useentsetupcloseambulance( team )
{
    ambulance = getcloseambulance( self.origin );
    
    if ( isdefined( ambulance ) )
    {
        self.ambulance = ambulance;
        ambulance ambulanceenabletoteam( team );
    }
}

// Namespace br_respawn
// Params 2
// Checksum 0xeb537de5, Offset: 0x20cb
// Size: 0x1f2
function createpickupuseent( origin, team )
{
    useent = spawn( "script_model", origin + ( 0, 0, 1 ) );
    useent setmodel( "fullbody_usmc_ar_scriptmover" );
    useent scriptmodelplayanim( "sdr_cp_hostage_dropoff_ground_idle_pilot" );
    useent scriptmodelpauseanim( 1 );
    useent makeusable();
    useent setcursorhint( "HINT_NOICON" );
    useent setuseholdduration( "duration_medium" );
    useent setuserange( 120 );
    useent sethintstring( &"mp/br_pickup_player" );
    useent setusepriority( 0 );
    useent hudoutlineenable( "outlinefill_nodepth_red" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            useent hudoutlineenableforclient( player, "outlinefill_nodepth_red" );
            
            if ( !player.carrying )
            {
                useent enableplayeruse( player );
            }
            
            continue;
        }
        
        useent disableplayeruse( player );
        useent hudoutlinedisableforclient( player );
    }
    
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    useent.objectiveiconid = objectiveiconid;
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "invisible", ( 0, 0, 0 ) );
        objidpoolmanager::update_objective_onentity( objectiveiconid, useent );
        objidpoolmanager::update_objective_setzoffset( objectiveiconid, 40 );
        objidpoolmanager::update_objective_state( objectiveiconid, "current" );
        objidpoolmanager::update_objective_icon( objectiveiconid, "passive_icon_health_on_kill" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_teammask_single( objectiveiconid, team );
    }
    
    return useent;
}

// Namespace br_respawn
// Params 2
// Checksum 0x8cc10e2, Offset: 0x22c6
// Size: 0x6b
function createplayerdeadcountdownhud( team, countdowntime )
{
    timerhud = hud_util::createservertimer( "objective", 1.4, team );
    timerhud.label = &"mp/br_respawn_death_countdown";
    timerhud settimer( countdowntime );
    timerhud.starttime = gettime();
    thread countdownhudpulse( timerhud );
    return timerhud;
}

// Namespace br_respawn
// Params 1
// Checksum 0x7d7d9e86, Offset: 0x233a
// Size: 0x73
function countdownhudpulse( timerhud )
{
    var_f97916dc25067a9 = 0.5;
    var_9b2390f9f47109f2 = 2;
    originalscale = timerhud.fontscale;
    timerhud changefontscaleovertime( var_f97916dc25067a9 );
    timerhud.fontscale = var_9b2390f9f47109f2;
    wait var_f97916dc25067a9;
    
    if ( isdefined( timerhud ) )
    {
        timerhud changefontscaleovertime( var_f97916dc25067a9 );
        timerhud.fontscale = originalscale;
    }
}

// Namespace br_respawn
// Params 2
// Checksum 0x1d9ca1a, Offset: 0x23b5
// Size: 0xba
function cleanupbodydrop( useent, team )
{
    if ( isdefined( useent.timerhud ) )
    {
        useent.timerhud destroy();
    }
    
    updatecountdownhudlist();
    
    if ( isdefined( useent.drophud ) )
    {
        useent.drophud destroy();
    }
    
    if ( isdefined( useent.ambulance ) )
    {
        useent.ambulance ambulancedisabletoteam( team );
        useent.ambulance = undefined;
    }
    
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    useent delete();
    hideallambulancesforteam( team, 1 );
}

// Namespace br_respawn
// Params 1
// Checksum 0x8d5208ab, Offset: 0x2477
// Size: 0x1aa
function useentmonitorambulances( team )
{
    self endon( #"droppedbody" );
    var_f9b9ea4bf32f95c3 = 0;
    
    while ( true )
    {
        anyoneclose = 0;
        
        for ( i = 0; i < level.br_respawnambulances.size ; i++ )
        {
            ambulance = level.br_respawnambulances[ i ];
            
            if ( !isdefined( ambulance ) || ambulance.disabled )
            {
                continue;
            }
            
            org = ambulance.origin;
            
            foreach ( player in level.teamdata[ team ][ "players" ] )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                distsq = distancesquared( org, player.origin );
                
                if ( distsq < 65536 )
                {
                    anyoneclose = 1;
                    break;
                }
            }
            
            if ( anyoneclose )
            {
                break;
            }
        }
        
        if ( !var_f9b9ea4bf32f95c3 && anyoneclose )
        {
            self.drophud.alpha = 1;
        }
        else if ( var_f9b9ea4bf32f95c3 && !anyoneclose )
        {
            self.drophud.alpha = 0;
        }
        
        var_f9b9ea4bf32f95c3 = anyoneclose;
        wait 0.1;
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xc6cfd828, Offset: 0x2629
// Size: 0x12e
function createdropplayerhud( team )
{
    fontscale = 1.3;
    fontelem = newteamhudelem( team );
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.alpha = 0;
    fontelem hud_util::setpoint( "CENTER", "CENTER", 0, 100 );
    fontelem.label = &"mp/br_respawn_drop_body";
    return fontelem;
}

// Namespace br_respawn
// Params 1
// Checksum 0xf4d584a1, Offset: 0x2760
// Size: 0xd5
function getrespawnableplayers( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    /#
        if ( getdvarint( @"scr_br_respawn_solo", 0 ) != 0 )
        {
            teammates = level.players;
        }
    #/
    
    respawnableplayers = [];
    
    foreach ( player in teammates )
    {
        if ( isdefined( player.respawnent ) )
        {
            respawnableplayers[ respawnableplayers.size ] = player;
        }
    }
    
    return respawnableplayers;
}

// Namespace br_respawn
// Params 0
// Checksum 0x5ce88c0f, Offset: 0x283e
// Size: 0x95
function getallrespawnableplayers()
{
    respawnableplayers = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.respawnent ) )
        {
            respawnableplayers[ respawnableplayers.size ] = player;
        }
    }
    
    return respawnableplayers;
}

// Namespace br_respawn
// Params 1
// Checksum 0xcaa86569, Offset: 0x28dc
// Size: 0x87
function getcloseambulance( point )
{
    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
    {
        ambulance = level.br_respawnambulances[ i ];
        
        if ( !isdefined( ambulance ) || ambulance.disabled )
        {
            continue;
        }
        
        distsq = distancesquared( ambulance.origin, point );
        
        if ( distsq < 65536 )
        {
            return ambulance;
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xf22ceb8d, Offset: 0x296b
// Size: 0xaf
function ambulancedefibrillator( player )
{
    if ( player hasweapon( "iw8_defibrillator_mp" ) )
    {
        player switchtoweapon( "iw8_defibrillator_mp" );
        return;
    }
    
    thread ambulancedosiren();
    player.usedambulance = self;
    self.defibrillator hide();
    teammaterevived = player playergivedefibrillator( self );
    
    if ( isdefined( player ) )
    {
        player notify( #"defibrillator_done" );
        player.usedambulance = undefined;
    }
    
    self.defibrillator show();
    
    if ( isdefined( teammaterevived ) )
    {
        teammaterevived.respawnent notify( #"respawnComplete", 1 );
        ambulancedelayreuse();
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0x2b2522de, Offset: 0x2a22
// Size: 0x1f
function ambulancedelayreuse()
{
    self endon( #"disabled" );
    ambulancemakeunsabletoall();
    wait 30;
    ambulancemakeusable();
}

// Namespace br_respawn
// Params 0
// Checksum 0xef79bd58, Offset: 0x2a49
// Size: 0x2e
function ambulancedosiren()
{
    self notify( #"hash_26f1c0221626c0c9" );
    self endon( #"hash_26f1c0221626c0c9" );
    self playloopsound( "siren_ambulance_lp" );
    wait 30;
    self stoploopsound();
}

// Namespace br_respawn
// Params 1
// Checksum 0x612bbc4e, Offset: 0x2a7f
// Size: 0xbf
function playergivedefibrillator( ambulance )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"defibrillator_done" );
    deadteammates = getrespawnableplayers( self.team );
    
    if ( deadteammates.size == 0 )
    {
        self iprintlnbold( "No dead teammates" );
        return;
    }
    
    self.lastweaponrespawn = self getcurrentprimaryweapon();
    defibrillatorweap = makeweapon( "iw8_defibrillator_mp" );
    self giveweapon( defibrillatorweap );
    self switchtoweapon( defibrillatorweap );
    thread playermonitorweaponchange( defibrillatorweap );
    thread playertakeawaydefibrillator( defibrillatorweap );
    thread playermonitordistancefromambulance( ambulance );
    return playerdodefibrillator( 1 );
}

// Namespace br_respawn
// Params 1
// Checksum 0xc73828c, Offset: 0x2b47
// Size: 0x17b
function playerdodefibrillator( var_51b7120c943d35c7 )
{
    while ( true )
    {
        self waittill( #"melee_fired", objweapon );
        
        if ( objweapon.basename != "iw8_defibrillator_mp" )
        {
            if ( !self hasweapon( "iw8_defibrillator_mp" ) )
            {
                return;
            }
            
            continue;
        }
        
        eye = self geteye();
        dirfacing = anglestoforward( self getplayerangles() );
        deadteammates = getrespawnableplayers( self.team );
        var_a4bfccadea72fb3 = 0;
        
        for ( i = 0; i < deadteammates.size ; i++ )
        {
            teammate = deadteammates[ i ];
            
            if ( !( isdefined( teammate ) && isdefined( teammate.respawnent ) ) )
            {
                continue;
            }
            
            var_a4bfccadea72fb3 = 1;
            origin = teammate.respawnent.origin + ( 0, 0, 40 );
            var_2aecc0964d3d7b48 = vectornormalize( origin - eye );
            dot = vectordot( var_2aecc0964d3d7b48, dirfacing );
            
            if ( dot < 0.5 )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, origin );
            
            if ( distsq > 10000 )
            {
                continue;
            }
            
            return teammate;
        }
        
        if ( !var_a4bfccadea72fb3 && var_51b7120c943d35c7 )
        {
            self iprintlnbold( "No teammates to revive" );
            return;
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x419986e6, Offset: 0x2cca
// Size: 0x75
function playermonitorweaponchange( defibrillatorweap )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"defibrillator_done" );
    
    while ( true )
    {
        self waittill( #"weapon_change", newweapon );
        
        if ( !issameweapon( defibrillatorweap, newweapon ) )
        {
            self notify( #"defibrillator_done" );
            return;
        }
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xe43846ef, Offset: 0x2d47
// Size: 0x4e
function playertakeawaydefibrillator( defibrillatorweap )
{
    utility::waittill_any( "death", "disconnect", "last_stand_enter", "defibrillator_done" );
    
    if ( isdefined( self ) && self hasweapon( defibrillatorweap ) )
    {
        self takeweapon( defibrillatorweap );
        self switchtoweapon( self.lastweaponrespawn );
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0x4506693a, Offset: 0x2d9d
// Size: 0x86
function playermonitordistancefromambulance( ambulance )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"defibrillator_done" );
    
    while ( true )
    {
        distsq = distancesquared( ambulance.origin, self.origin );
        
        if ( distsq > 65536 )
        {
            self notify( #"defibrillator_done" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace br_respawn
// Params 1
// Checksum 0xbb03570e, Offset: 0x2e2b
// Size: 0x8d
function giveweaponpickup( weaponname )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !level.br_respawn_enabled )
    {
        return;
    }
    
    if ( weaponname != "iw8_defibrillator_mp" )
    {
        return;
    }
    
    teammate = playerdoportabledefibrillator();
    
    if ( isdefined( teammate ) )
    {
        if ( isdefined( teammate.body ) )
        {
            teammate.body delete();
        }
        
        teammate.respawnent notify( #"respawnComplete", 1 );
    }
}

// Namespace br_respawn
// Params 0
// Checksum 0xcf605072, Offset: 0x2ec0
// Size: 0x14
function playerdoportabledefibrillator()
{
    self endon( #"portable_defibrillator_done" );
    return playerdodefibrillator();
}

/#

    // Namespace br_respawn
    // Params 0
    // Checksum 0x657c878a, Offset: 0x2edd
    // Size: 0x326, Type: dev
    function debugrespawn()
    {
        setdvarifuninitialized( @"scr_br_respawn_solo", 0 );
        setdvarifuninitialized( @"scr_br_respawn_cmd", "<dev string:x24>" );
        
        while ( true )
        {
            cmd = getdvar( @"scr_br_respawn_cmd", "<dev string:x24>" );
            
            if ( cmd != "<dev string:x24>" )
            {
                setdvar( @"scr_br_respawn_cmd", "<dev string:x24>" );
                
                if ( cmd == "<dev string:x25>" )
                {
                    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
                    {
                        ambulance = level.br_respawnambulances[ i ];
                        
                        if ( isdefined( ambulance ) && !ambulance.disabled )
                        {
                            ambulance ambulancedisable();
                            disablerespawnscenarios( ambulance );
                        }
                    }
                }
                else if ( cmd == "<dev string:x38>" )
                {
                    for ( i = 0; i < level.br_respawnambulances.size ; i++ )
                    {
                        ambulance = level.br_respawnambulances[ i ];
                        
                        if ( isdefined( ambulance ) && ambulance.disabled )
                        {
                            ambulance.disabled = undefined;
                            ambulance ambulancesetup( ambulance.struct );
                        }
                    }
                }
                else if ( cmd == "<dev string:x4a>" )
                {
                    host = gamelogic_mp::gethostplayer();
                    bot = getbot( host );
                    
                    if ( isdefined( bot ) && isdefined( host.respawnent ) )
                    {
                        host.respawnent notify( #"trigger", bot );
                    }
                }
                else if ( cmd == "<dev string:x51>" )
                {
                    host = gamelogic_mp::gethostplayer();
                    
                    if ( isdefined( host.respawnent ) )
                    {
                        host.respawnent notify( #"respawnComplete", 1 );
                    }
                }
                else if ( cmd == "<dev string:x59>" )
                {
                    host = gamelogic_mp::gethostplayer();
                    bot = getbot( host );
                    
                    if ( isdefined( host.respawnent ) && bot.carrying )
                    {
                        thread dropbody( host.respawnent, bot, bot.holdingbodyhud, host.team );
                    }
                }
                else if ( cmd == "<dev string:x5e>" )
                {
                    host = gamelogic_mp::gethostplayer();
                    botfriend = getbot( host, 0, 1 );
                    botenemy = getbot( host, 1 );
                    botfriend.donotmodifydamage = 1;
                    botfriend dodamage( 150, botenemy.origin, botenemy, botenemy, "<dev string:x63>" );
                    botfriend.donotmodifydamage = undefined;
                }
                else if ( cmd == "<dev string:x6d>" )
                {
                    host = gamelogic_mp::gethostplayer();
                    botenemy = getbot( host, 1 );
                    defibrillatorweap = makeweapon( "<dev string:x76>" );
                    host.donotmodifydamage = 1;
                    host dodamage( 150, host.origin, botenemy, botenemy, "<dev string:x63>", defibrillatorweap );
                    host.donotmodifydamage = undefined;
                }
            }
            
            wait 0.1;
        }
    }

    // Namespace br_respawn
    // Params 3
    // Checksum 0x117b0d74, Offset: 0x320b
    // Size: 0x118, Type: dev
    function getbot( host, oppositeteam, alive )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || alive && ( isdefined( player.respawnent ) || player.fauxdead ) )
            {
                continue;
            }
            
            if ( isbot( player ) || istestclient( player ) )
            {
                if ( !oppositeteam && player.team == host.team || oppositeteam && player.team != host.team )
                {
                    return player;
                }
            }
        }
    }

#/
