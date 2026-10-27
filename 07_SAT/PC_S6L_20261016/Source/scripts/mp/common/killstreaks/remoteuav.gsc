// scripts\mp\common\killstreaks\remoteuav.gsc  (hash_7cfc6b68c1e1dbb6.gscc) (size: 27999 Bytes / 0x6d5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8337f565 (2201482597)
// size ...... 27999 (0x6d5f)
// includes .. 22  (offset: 0x647b)
// strings ... 128 (offset: 0x652b)
// dev strs .. 2   (offset: 0x6d47)
// exports ... 59  (offset: 0x435f)
// cseg ...... 0x9aa + 0x39b5 (0x435f)
// imports ... 193 (offset: 0x4c97)
// animtree1 . 0   (offset: 0x6d5f)
// animtree2 . 0   (offset: 0x6d5f)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;

#namespace remoteuav;

// Namespace remoteuav
// Params 0
// Checksum 0x38505424, Offset: 0x9c8
// Size: 0x2be
function init()
{
    level.remoteuav_fx[ "explode" ] = loadfxasset( "vfx_core_explo_bouncing_betty" );
    level.remoteuav_fx[ "missile_explode" ] = loadfxasset( "vfx_iw8_mp_strk_apache_explo" );
    level.remoteuav_dialog[ "launch" ][ 0 ] = "ac130_plt_yeahcleared";
    level.remoteuav_dialog[ "launch" ][ 1 ] = "ac130_plt_rollinin";
    level.remoteuav_dialog[ "launch" ][ 2 ] = "ac130_plt_scanrange";
    level.remoteuav_dialog[ "out_of_range" ][ 0 ] = "ac130_plt_cleanup";
    level.remoteuav_dialog[ "out_of_range" ][ 1 ] = "ac130_plt_targetreset";
    level.remoteuav_dialog[ "track" ][ 0 ] = "ac130_fco_moreenemy";
    level.remoteuav_dialog[ "track" ][ 1 ] = "ac130_fco_getthatguy";
    level.remoteuav_dialog[ "track" ][ 2 ] = "ac130_fco_guymovin";
    level.remoteuav_dialog[ "track" ][ 3 ] = "ac130_fco_getperson";
    level.remoteuav_dialog[ "track" ][ 4 ] = "ac130_fco_guyrunnin";
    level.remoteuav_dialog[ "track" ][ 5 ] = "ac130_fco_gotarunner";
    level.remoteuav_dialog[ "track" ][ 6 ] = "ac130_fco_backonthose";
    level.remoteuav_dialog[ "track" ][ 7 ] = "ac130_fco_gonnagethim";
    level.remoteuav_dialog[ "track" ][ 8 ] = "ac130_fco_personnelthere";
    level.remoteuav_dialog[ "track" ][ 9 ] = "ac130_fco_rightthere";
    level.remoteuav_dialog[ "track" ][ 10 ] = "ac130_fco_tracking";
    level.remoteuav_dialog[ "tag" ][ 0 ] = "ac130_fco_nice";
    level.remoteuav_dialog[ "tag" ][ 1 ] = "ac130_fco_yougothim";
    level.remoteuav_dialog[ "tag" ][ 2 ] = "ac130_fco_yougothim2";
    level.remoteuav_dialog[ "tag" ][ 3 ] = "ac130_fco_okyougothim";
    level.remoteuav_dialog[ "assist" ][ 0 ] = "ac130_fco_goodkill";
    level.remoteuav_dialog[ "assist" ][ 1 ] = "ac130_fco_thatsahit";
    level.remoteuav_dialog[ "assist" ][ 2 ] = "ac130_fco_directhit";
    level.remoteuav_dialog[ "assist" ][ 3 ] = "ac130_fco_rightontarget";
    level.remoteuav_lastdialogtime = 0;
    level.remoteuav_nodeployzones = getentarray( "no_vehicles", #targetname );
    assertmsg( "<dev string:x24>" );
    level.remote_uav = [];
    
    /#
        setdevdvarifuninitialized( @"hash_da7c6c2551fb9f41", 60 );
    #/
}

// Namespace remoteuav
// Params 2
// Checksum 0x7ed9f3c1, Offset: 0xc8e
// Size: 0x22
function useremoteuav( lifeid, streakname )
{
    return tryuseremoteuav( lifeid, "remote_uav" );
}

// Namespace remoteuav
// Params 1
// Checksum 0x75544f82, Offset: 0xcb9
// Size: 0x65
function exceededmaxremoteuavs( team )
{
    if ( game_utility::getgametype() == "dm" )
    {
        if ( isdefined( level.remote_uav[ team ] ) || isdefined( level.remote_uav[ team_utility::getotherteam( team ) ] ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    if ( isdefined( level.remote_uav[ team ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace remoteuav
// Params 2
// Checksum 0x4126b052, Offset: 0xd26
// Size: 0x173
function tryuseremoteuav( lifeid, streakname )
{
    val::set( "remote_uav", "usability", 0 );
    
    if ( utility::isusingremote() || self isusingturret() || isdefined( level.nukeinfo.incoming ) )
    {
        val::reset_all( "remote_uav" );
        return 0;
    }
    
    var_766d9694d6cd52f7 = 1;
    
    if ( exceededmaxremoteuavs( self.team ) || level.littlebirds.size >= 4 )
    {
        self iprintlnbold( &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        val::reset_all( "remote_uav" );
        return 0;
    }
    else if ( killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_766d9694d6cd52f7 >= killstreak::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        val::reset_all( "remote_uav" );
        return 0;
    }
    
    self setplayerdata( "reconDroneState", "staticAlpha", 0 );
    self setplayerdata( "reconDroneState", "incomingMissile", 0 );
    killstreak::incrementfauxvehiclecount();
    result = givecarryremoteuav( lifeid, streakname );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakname, self.origin );
        thread hud_util::teamplayercardsplash( "used_remote_uav", self );
    }
    else
    {
        killstreak::decrementfauxvehiclecount();
    }
    
    self.iscarrying = 0;
    return result;
}

// Namespace remoteuav
// Params 2
// Checksum 0xb5f6c244, Offset: 0xea2
// Size: 0xe3
function givecarryremoteuav( lifeid, streakname )
{
    carryremoteuav = createcarryremoteuav( streakname, self );
    inventory_utility::_takeweapon( "killstreak_uav_mp" );
    inventory_utility::_giveweapon( "killstreak_remote_uav_mp" );
    inventory_utility::_switchtoweaponimmediate( "killstreak_remote_uav_mp" );
    setcarryingremoteuav( carryremoteuav );
    
    if ( isalive( self ) && isdefined( carryremoteuav ) )
    {
        origin = carryremoteuav.origin;
        angles = self.angles;
        carryremoteuav.soundent delete();
        carryremoteuav delete();
        result = startremoteuav( lifeid, streakname, origin, angles );
    }
    else
    {
        result = 0;
        
        if ( isalive( self ) )
        {
            inventory_utility::_takeweapon( "killstreak_remote_uav_mp" );
            inventory_utility::_giveweapon( "killstreak_uav_mp" );
        }
    }
    
    return result;
}

// Namespace remoteuav
// Params 2
// Checksum 0x349bcca, Offset: 0xf8e
// Size: 0x224
function createcarryremoteuav( streakname, owner )
{
    pos = owner.origin + anglestoforward( owner.angles ) * 4 + anglestoup( owner.angles ) * 50;
    carryremoteuav = spawnturret( "misc_turret", pos, "sentry_minigun_mp" );
    carryremoteuav.origin = pos;
    carryremoteuav.angles = owner.angles;
    carryremoteuav.sentrytype = "sentry_minigun";
    carryremoteuav.canbeplaced = 1;
    carryremoteuav setturretmodechangewait( 1 );
    carryremoteuav setmode( "sentry_offline" );
    carryremoteuav makeunusable();
    carryremoteuav maketurretinoperable();
    carryremoteuav.owner = owner;
    carryremoteuav setsentryowner( carryremoteuav.owner );
    carryremoteuav.scale = 3;
    carryremoteuav.inheliproximity = 0;
    carryremoteuav thread carryremoteuav_handleexistence();
    carryremoteuav.rangetrigger = getent( "remote_uav_range", #targetname );
    
    if ( !isdefined( carryremoteuav.rangetrigger ) )
    {
        heightent = killstreak_utility::getkillstreakairstrikeheightent();
        carryremoteuav.maxheight = heightent.origin[ 2 ];
        carryremoteuav.maxdistance = 3600;
    }
    
    carryremoteuav.soundent = spawn( "script_origin", carryremoteuav.origin );
    carryremoteuav.soundent.targetname = "createCarryRemoteUAV";
    carryremoteuav.soundent.angles = carryremoteuav.angles;
    carryremoteuav.soundent.origin = carryremoteuav.origin;
    carryremoteuav.soundent linkto( carryremoteuav );
    carryremoteuav.soundent playloopsound( "recondrone_idle_high" );
    return carryremoteuav;
}

// Namespace remoteuav
// Params 1
// Checksum 0xe4cf3e99, Offset: 0x11bb
// Size: 0x180
function setcarryingremoteuav( carryremoteuav )
{
    carryremoteuav thread carryremoteuav_setcarried( self );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack" );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 4" );
    
    if ( !self isconsoleplayer() )
    {
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 5" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 6" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 7" );
    }
    
    for ( ;; )
    {
        result = utility::waittill_any_return( "place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect" );
        self forceusehintoff();
        
        if ( result != "place_carryRemoteUAV" )
        {
            carryremoteuav_delete( carryremoteuav );
            break;
        }
        
        if ( !carryremoteuav.canbeplaced )
        {
            if ( self.team != "spectator" )
            {
                self forceusehinton( &"killstreaks_remote_uav_cannot_place" );
            }
            
            continue;
        }
        
        if ( exceededmaxremoteuavs( self.team ) || killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= killstreak::maxvehiclesallowed() )
        {
            self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
            carryremoteuav_delete( carryremoteuav );
            break;
        }
        
        self.iscarrying = 0;
        carryremoteuav.carriedby = undefined;
        carryremoteuav playsound( "sentry_gun_plant" );
        carryremoteuav notify( #"placed" );
        break;
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0xe3a611b9, Offset: 0x1343
// Size: 0x50
function carryremoteuav_setcarried( carrier )
{
    self setcandamage( 0 );
    self setsentrycarrier( carrier );
    self notsolid();
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    carrier thread updatecarryremoteuavplacement( self );
    self notify( #"carried" );
}

// Namespace remoteuav
// Params 1
// Checksum 0x1552d1c7, Offset: 0x139b
// Size: 0x42
function carryremoteuav_delete( carryremoteuav )
{
    self.iscarrying = 0;
    
    if ( isdefined( carryremoteuav ) )
    {
        if ( isdefined( carryremoteuav.soundent ) )
        {
            carryremoteuav.soundent delete();
        }
        
        carryremoteuav delete();
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x8102e22f, Offset: 0x13e5
// Size: 0x9b, Type: bool
function isinremotenodeploy()
{
    if ( isdefined( level.remoteuav_nodeployzones ) && level.remoteuav_nodeployzones.size )
    {
        foreach ( zone in level.remoteuav_nodeployzones )
        {
            if ( self istouching( zone ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace remoteuav
// Params 1
// Checksum 0x717b12b6, Offset: 0x1489
// Size: 0x1c6
function updatecarryremoteuavplacement( carryremoteuav )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    carryremoteuav endon( #"placed" );
    carryremoteuav endon( #"death" );
    carryremoteuav.canbeplaced = 1;
    var_aecb8eda95a09d20 = -1;
    val::reset_all( "remote_uav" );
    
    for ( ;; )
    {
        heightoffset = 18;
        
        switch ( self getstance() )
        {
            case #"hash_c6775c88e38f7803":
                heightoffset = 40;
                break;
            case #"hash_3fed0cbd303639eb":
                heightoffset = 25;
                break;
            case #"hash_d91940431ed7c605":
                heightoffset = 10;
                break;
        }
        
        placement = self canplayerplacetank( 22, 22, 50, heightoffset, 0, 0 );
        carryremoteuav.origin = placement[ "origin" ] + anglestoup( self.angles ) * 27;
        carryremoteuav.angles = placement[ "angles" ];
        carryremoteuav.canbeplaced = self isonground() && placement[ "result" ] && carryremoteuav remoteuav_in_range() && !carryremoteuav isinremotenodeploy();
        
        if ( carryremoteuav.canbeplaced != var_aecb8eda95a09d20 )
        {
            if ( carryremoteuav.canbeplaced )
            {
                if ( self.team != "spectator" )
                {
                    self forceusehinton( &"killstreaks_remote_uav_place" );
                }
                
                if ( self attackbuttonpressed() )
                {
                    self notify( #"place_carryRemoteUAV" );
                }
            }
            else if ( self.team != "spectator" )
            {
                self forceusehinton( &"killstreaks_remote_uav_cannot_place" );
            }
        }
        
        var_aecb8eda95a09d20 = carryremoteuav.canbeplaced;
        waitframe();
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x48d87e09, Offset: 0x1657
// Size: 0x7b
function carryremoteuav_handleexistence()
{
    level endon( #"game_ended" );
    self.owner endon( #"place_carryRemoteUAV" );
    self.owner endon( #"cancel_carryRemoteUAV" );
    self.owner utility::waittill_any( "death_or_disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.soundent ) )
        {
            self.soundent delete();
        }
        
        self delete();
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0xaa4cde54, Offset: 0x16da
// Size: 0x20
function removeremoteweapon()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 0.7;
}

// Namespace remoteuav
// Params 4
// Checksum 0xe920a117, Offset: 0x1702
// Size: 0x17e
function startremoteuav( lifeid, streakname, origin, angles )
{
    lockplayerforremoteuavlaunch();
    player::setusingremote( streakname );
    inventory_utility::_giveweapon( "uav_remote_mp" );
    inventory_utility::_switchtoweaponimmediate( "uav_remote_mp" );
    self visionsetnakedforplayer( "black_bw", 0 );
    result = killstreaks::initridekillstreak( "remote_uav" );
    
    if ( result != "success" )
    {
        if ( result != "disconnect" )
        {
            self notify( #"remoteuav_unlock" );
            inventory_utility::_takeweapon( "uav_remote_mp" );
            player::clearusingremote();
        }
        
        val::reset_all( "ride_killstreak" );
        return 0;
    }
    
    if ( exceededmaxremoteuavs( self.team ) || killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= killstreak::maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        self notify( #"remoteuav_unlock" );
        inventory_utility::_takeweapon( "uav_remote_mp" );
        player::clearusingremote();
        return 0;
    }
    
    self notify( #"remoteuav_unlock" );
    remoteuav = createremoteuav( lifeid, self, streakname, origin, angles );
    
    if ( isdefined( remoteuav ) )
    {
        thread remoteuav_ride( lifeid, remoteuav, streakname );
        return 1;
    }
    
    self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
    inventory_utility::_takeweapon( "uav_remote_mp" );
    player::clearusingremote();
    return 0;
}

// Namespace remoteuav
// Params 0
// Checksum 0xa495953a, Offset: 0x1888
// Size: 0x49
function lockplayerforremoteuavlaunch()
{
    lockspot = spawn( "script_origin", self.origin );
    lockspot.targetname = "lockPlayerForRemoteUAVLaunch";
    lockspot hide();
    self playerlinkto( lockspot );
    thread clearplayerlockfromremoteuavlaunch( lockspot );
}

// Namespace remoteuav
// Params 1
// Checksum 0xf9970278, Offset: 0x18d9
// Size: 0x4c
function clearplayerlockfromremoteuavlaunch( lockspot )
{
    level endon( #"game_ended" );
    msg = utility::waittill_any_return( "death_or_disconnect", "remoteuav_unlock" );
    
    if ( msg != "disconnect" )
    {
        self unlink();
    }
    
    lockspot delete();
}

// Namespace remoteuav
// Params 5
// Checksum 0xdd0f21d2, Offset: 0x192d
// Size: 0x246
function createremoteuav( lifeid, owner, streakname, origin, angles )
{
    if ( owner isconsoleplayer() )
    {
        remoteuav = spawnhelicopter( owner, origin, angles, "remote_uav_mp", "vehicle_remote_uav" );
    }
    else
    {
        remoteuav = spawnhelicopter( owner, origin, angles, "remote_uav_mp_pc", "vehicle_remote_uav" );
    }
    
    if ( !isdefined( remoteuav ) )
    {
        return;
    }
    
    assertmsg( "<dev string:x80>" );
    remoteuav makevehiclesolidcapsule( 18, -9, 18 );
    remoteuav.lifeid = lifeid;
    remoteuav.team = owner.team;
    remoteuav.pers[ "team" ] = owner.team;
    remoteuav.owner = owner;
    remoteuav setotherent( owner );
    remoteuav sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    remoteuav.maxhealth = 250;
    remoteuav.scrambler = spawn( "script_model", origin );
    remoteuav.scrambler linkto( remoteuav, "tag_origin", ( 0, 0, -160 ), ( 0, 0, 0 ) );
    remoteuav.scrambler makescrambler( owner );
    remoteuav.smoking = 0;
    remoteuav.inheliproximity = 0;
    remoteuav.helitype = "remote_uav";
    remoteuav.markedplayers = [];
    remoteuav thread remoteuav_light_fx();
    remoteuav thread remoteuav_explode_on_disconnect();
    remoteuav thread remoteuav_explode_on_changeteams();
    remoteuav thread remoteuav_explode_on_death();
    remoteuav thread remoteuav_clear_marked_on_gameended();
    remoteuav thread remoteuav_leave_on_timeout();
    remoteuav thread remoteuav_watch_distance();
    remoteuav thread remoteuav_watchheliproximity();
    remoteuav thread remoteuav_handledamage();
    remoteuav.numflares = 2;
    remoteuav.hasincoming = 0;
    remoteuav.incomingmissiles = [];
    remoteuav thread remoteuav_clearincomingwarning();
    remoteuav thread remoteuav_handleincomingstinger();
    remoteuav thread remoteuav_handleincomingsam();
    level.remote_uav[ remoteuav.team ] = remoteuav;
    return remoteuav;
}

// Namespace remoteuav
// Params 3
// Checksum 0x3e8801fb, Offset: 0x1b7c
// Size: 0xba
function remoteuav_ride( lifeid, remoteuav, streakname )
{
    remoteuav.playerlinked = 1;
    self.restoreangles = self.angles;
    
    if ( level.forcethirdperson )
    {
        player::setthirdpersondof( 0 );
    }
    
    self cameralinkto( remoteuav, "tag_origin" );
    self remotecontrolvehicle( remoteuav );
    thread remoteuav_playerexit( remoteuav );
    thread remoteuav_track( remoteuav );
    thread remoteuav_fire( remoteuav );
    self.remote_uav_ridelifeid = lifeid;
    self.remoteuav = remoteuav;
    thread remoteuav_delaylaunchdialog( remoteuav );
    self visionsetnakedforplayer( "black_bw", 0 );
    player::restorebasevisionset( 1 );
}

// Namespace remoteuav
// Params 1
// Checksum 0x7e279eef, Offset: 0x1c3e
// Size: 0x5a
function remoteuav_delaylaunchdialog( remoteuav )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    remoteuav endon( #"end_remote" );
    remoteuav endon( #"end_launch_dialog" );
    wait 3;
    remoteuav_dialog( "launch" );
}

// Namespace remoteuav
// Params 1
// Checksum 0x72cbf061, Offset: 0x1ca0
// Size: 0xb4
function remoteuav_endride( remoteuav )
{
    if ( isdefined( remoteuav ) )
    {
        remoteuav.playerlinked = 0;
        remoteuav notify( #"end_remote" );
        player::clearusingremote();
        
        if ( level.forcethirdperson )
        {
            player::setthirdpersondof( 1 );
        }
        
        self cameraunlink();
        self remotecontrolvehicleoff();
        self thermalvisionoff();
        self setplayerangles( self.restoreangles );
        objlastweapon = inventory::getlastweapon();
        
        if ( !self hasweapon( objlastweapon ) )
        {
            objlastweapon = inventory::getfirstprimaryweapon();
        }
        
        inventory_utility::_switchtoweapon( objlastweapon );
        inventory_utility::_takeweapon( "uav_remote_mp" );
        thread remoteuav_freezebuffer();
    }
    
    self.remoteuav = undefined;
}

// Namespace remoteuav
// Params 0
// Checksum 0x3519c831, Offset: 0x1d5c
// Size: 0x3d
function remoteuav_freezebuffer()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::_freezecontrols( 1, undefined, "remoteuav" );
    wait 0.5;
    player::_freezecontrols( 0, undefined, "remoteuav" );
}

// Namespace remoteuav
// Params 1
// Checksum 0x569962e3, Offset: 0x1da1
// Size: 0x93
function remoteuav_playerexit( remoteuav )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    remoteuav endon( #"end_remote" );
    wait 2;
    updaterate = level.framedurationseconds;
    
    while ( true )
    {
        timeused = 0;
        
        while ( self usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.75 )
            {
                remoteuav thread remoteuav_leave();
                return;
            }
            
            wait updaterate;
        }
        
        waitframe();
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0x5cda69e, Offset: 0x1e3c
// Size: 0x489
function remoteuav_track( remoteuav )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    remoteuav endon( #"end_remote" );
    remoteuav.lasttrackingdialogtime = 0;
    self.lockedtarget = undefined;
    self weaponlockfree();
    wait 1;
    
    while ( true )
    {
        pos = remoteuav gettagorigin( "tag_turret" );
        forward = anglestoforward( self getplayerangles() );
        endpos = pos + forward * 1024;
        trace = trace::_bullet_trace( pos, endpos, 1, remoteuav );
        
        if ( isdefined( trace[ "position" ] ) )
        {
            targetpos = trace[ "position" ];
        }
        else
        {
            targetpos = endpos;
            trace[ "endpos" ] = endpos;
        }
        
        remoteuav.trace = trace;
        lockedplayer = remoteuav_trackentities( remoteuav, level.players, targetpos );
        lockedturret = remoteuav_trackentities( remoteuav, level.turrets, targetpos );
        lockeduav = undefined;
        
        if ( level.teambased )
        {
            entitylist = [];
            enemyteams = team_utility::getenemyteams( self.team );
            
            if ( level.var_f3d1cde89907a07a )
            {
                foreach ( team in level.teamnamelist )
                {
                    foreach ( squadindex, squadarray in level.squaddata[ team ] )
                    {
                        index = squadindex;
                        
                        foreach ( model in level.uavmodels[ index ] )
                        {
                            entitylist[ entitylist.size ] = model;
                        }
                    }
                }
            }
            else
            {
                foreach ( entry in level.teamnamelist )
                {
                    foreach ( model in level.uavmodels[ entry ] )
                    {
                        entitylist[ entitylist.size ] = model;
                    }
                }
            }
            
            lockeduav = remoteuav_trackentities( remoteuav, entitylist, targetpos );
        }
        else
        {
            lockeduav = remoteuav_trackentities( remoteuav, level.uavmodels, targetpos );
        }
        
        lockedtarget = undefined;
        
        if ( isdefined( lockedplayer ) )
        {
            lockedtarget = lockedplayer;
        }
        else if ( isdefined( lockedturret ) )
        {
            lockedtarget = lockedturret;
        }
        else if ( isdefined( lockeduav ) )
        {
            lockedtarget = lockeduav;
        }
        
        if ( isdefined( lockedtarget ) )
        {
            if ( !isdefined( self.lockedtarget ) || isdefined( self.lockedtarget ) && self.lockedtarget != lockedtarget )
            {
                self weaponlockfinalize( lockedtarget );
                self.lockedtarget = lockedtarget;
                
                if ( isdefined( lockedplayer ) )
                {
                    remoteuav notify( #"end_launch_dialog" );
                    remoteuav_dialog( "track" );
                }
            }
        }
        else
        {
            self weaponlockfree();
            self.lockedtarget = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 3
// Checksum 0x994bfc58, Offset: 0x22cd
// Size: 0x563
function remoteuav_trackentities( remoteuav, entities, targetpos )
{
    level endon( #"game_ended" );
    lockedtarget = undefined;
    
    foreach ( entity in entities )
    {
        if ( level.teambased && ( !isdefined( entity.team ) || entity.team == self.team ) )
        {
            continue;
        }
        
        if ( isplayer( entity ) )
        {
            if ( !player::isreallyalive( entity ) )
            {
                continue;
            }
            
            if ( entity == self )
            {
                continue;
            }
            
            id = entity.guid;
        }
        else
        {
            id = entity.birthtime;
        }
        
        if ( isdefined( entity.sentrytype ) || isdefined( entity.turrettype ) )
        {
            offset = 32;
            unmarkedshader = "hud_fofbox_hostile_vehicle";
        }
        else if ( isdefined( entity.uavtype ) )
        {
            offset = -52;
            unmarkedshader = "hud_fofbox_hostile_vehicle";
        }
        else
        {
            offset = 26;
            unmarkedshader = "veh_hud_target_unmarked";
        }
        
        if ( isdefined( entity.uavremotemarkedby ) )
        {
            if ( !isdefined( remoteuav.markedplayers[ id ] ) )
            {
                remoteuav.markedplayers[ id ] = [];
                remoteuav.markedplayers[ id ][ "player" ] = entity;
                remoteuav.markedplayers[ id ][ "icon" ] = entity entityheadicons::setheadicon_singleimage( self, "veh_hud_target_marked", offset );
                remoteuav.markedplayers[ id ][ "icon" ].shader = "veh_hud_target_marked";
                
                if ( !( isdefined( entity.sentrytype ) && isdefined( entity.turrettype ) ) )
                {
                    remoteuav.markedplayers[ id ][ "icon" ] settargetent( entity );
                }
            }
            else if ( isdefined( remoteuav.markedplayers[ id ][ "icon" ] ) && isdefined( remoteuav.markedplayers[ id ][ "icon" ].shader ) && remoteuav.markedplayers[ id ][ "icon" ].shader != "veh_hud_target_marked" )
            {
                remoteuav.markedplayers[ id ][ "icon" ].shader = "veh_hud_target_marked";
                remoteuav.markedplayers[ id ][ "icon" ] setshader( "veh_hud_target_marked", 10, 10 );
                remoteuav.markedplayers[ id ][ "icon" ] setwaypoint( 0, 0, 0, 0 );
            }
            
            continue;
        }
        
        if ( isplayer( entity ) )
        {
            spawnprotected = isdefined( entity.spawntime ) && ( gettime() - entity.spawntime ) / 1000 <= 5;
            var_e25796d790639a64 = isdefined( entity.perks[ "specialty_blindeye" ] );
            carried = 0;
            leaving = 0;
        }
        else
        {
            spawnprotected = 0;
            var_e25796d790639a64 = 0;
            carried = isdefined( entity.carriedby );
            leaving = entity.isleaving == 1;
        }
        
        if ( !isdefined( remoteuav.markedplayers[ id ] ) && !spawnprotected && !var_e25796d790639a64 && !carried && !leaving )
        {
            remoteuav.markedplayers[ id ] = [];
            remoteuav.markedplayers[ id ][ "player" ] = entity;
            remoteuav.markedplayers[ id ][ "icon" ] = entity entityheadicons::setheadicon_singleimage( self, unmarkedshader, offset );
            remoteuav.markedplayers[ id ][ "icon" ].shader = unmarkedshader;
            
            if ( !( isdefined( entity.sentrytype ) && isdefined( entity.turrettype ) ) )
            {
                remoteuav.markedplayers[ id ][ "icon" ] settargetent( entity );
            }
        }
        
        if ( lockedtarget != entity && remoteuav.trace[ "entity" ] == entity && !carried && !leaving || distance( entity.origin, targetpos ) < 200 * remoteuav.trace[ "fraction" ] && !spawnprotected && !carried && !leaving || !leaving && remoteuav_cantargetuav( remoteuav, entity ) )
        {
            trace = trace::_bullet_trace( remoteuav.origin, entity.origin + ( 0, 0, 32 ), 1, remoteuav );
            
            if ( trace[ "entity" ] == entity || trace[ "fraction" ] == 1 )
            {
                self playlocalsound( "recondrone_lockon" );
                lockedtarget = entity;
            }
        }
    }
    
    return lockedtarget;
}

// Namespace remoteuav
// Params 2
// Checksum 0x4c28f45d, Offset: 0x2839
// Size: 0x7e, Type: bool
function remoteuav_cantargetuav( remoteuav, uav )
{
    if ( isdefined( uav.uavtype ) )
    {
        forward = anglestoforward( self getplayerangles() );
        touav = vectornormalize( uav.origin - remoteuav gettagorigin( "tag_turret" ) );
        dot = vectordot( forward, touav );
        
        if ( dot > 0.985 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace remoteuav
// Params 1
// Checksum 0xf1547839, Offset: 0x28c0
// Size: 0xbf
function remoteuav_fire( remoteuav )
{
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    level endon( #"game_ended" );
    remoteuav endon( #"end_remote" );
    wait 1;
    self notifyonplayercommand( "remoteUAV_tag", "+attack" );
    self notifyonplayercommand( "remoteUAV_tag", "+attack_akimbo_accessible" );
    
    while ( true )
    {
        self waittill( #"remoteUAV_tag" );
        
        if ( isdefined( self.lockedtarget ) )
        {
            self playlocalsound( "recondrone_tag" );
            damagefeedback::updatedamagefeedback( "" );
            thread remoteuav_markplayer( self.lockedtarget );
            thread remoteuav_rumble( remoteuav, 3 );
            wait 0.25;
            continue;
        }
        
        waitframe();
    }
}

// Namespace remoteuav
// Params 2
// Checksum 0x4c0987e7, Offset: 0x2987
// Size: 0x8c
function remoteuav_rumble( remoteuav, amount )
{
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    level endon( #"game_ended" );
    remoteuav endon( #"end_remote" );
    remoteuav notify( #"end_rumble" );
    remoteuav endon( #"end_rumble" );
    
    for ( i = 0; i < amount ; i++ )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0x29c40e24, Offset: 0x2a1b
// Size: 0x2a9
function remoteuav_markplayer( targetplayer )
{
    level endon( #"game_ended" );
    targetplayer.uavremotemarkedby = self;
    
    if ( isplayer( targetplayer ) && !targetplayer utility::isusingremote() )
    {
    }
    else if ( isdefined( targetplayer.uavtype ) )
    {
        targetplayer.birth_time = targetplayer.birthtime;
    }
    else if ( isalive( targetplayer.owner ) )
    {
        targetplayer.owner thread rank::scoreeventpopup( #"hash_508e80998122a1a4" );
    }
    
    remoteuav_dialog( "tag" );
    
    if ( game_utility::getgametype() != "dm" )
    {
        if ( isplayer( targetplayer ) )
        {
            thread points::doscoreevent( #"kill" );
        }
    }
    
    if ( isplayer( targetplayer ) )
    {
        targetplayer setperk( "specialty_radarblip", 1 );
    }
    else
    {
        if ( isdefined( targetplayer.uavtype ) )
        {
            shadername = "compassping_enemy_uav";
        }
        else
        {
            shadername = "compassping_sentry_enemy";
        }
        
        if ( level.teambased )
        {
            curobjid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                objidpoolmanager::update_objective_state( curobjid, "active" );
                objidpoolmanager::objective_teammask_single( curobjid, self.team );
                objidpoolmanager::update_objective_icon( curobjid, shadername );
                objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid01 = curobjid;
        }
        else
        {
            curobjid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                objidpoolmanager::update_objective_state( curobjid, "active" );
                objidpoolmanager::objective_teammask_single( curobjid, team_utility::getotherteam( self.team ) );
                objidpoolmanager::update_objective_icon( curobjid, shadername );
                objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid02 = curobjid;
            curobjid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                objidpoolmanager::update_objective_state( curobjid, "active" );
                objidpoolmanager::objective_teammask_single( curobjid, self.team );
                objidpoolmanager::update_objective_icon( curobjid, shadername );
                objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid03 = curobjid;
        }
    }
    
    targetplayer thread remoteuav_unmarkremovedplayer( self.remoteuav );
}

// Namespace remoteuav
// Params 1
// Checksum 0x4ec14736, Offset: 0x2ccc
// Size: 0x54
function remoteuav_processtaggedassist( victim )
{
    remoteuav_dialog( "assist" );
    
    if ( game_utility::getgametype() != "dm" )
    {
        self.taggedassist = 1;
        
        if ( isdefined( victim ) )
        {
            thread gamescore::processassist( victim );
            return;
        }
        
        thread points::doscoreevent( #"assist" );
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0xfd7945be, Offset: 0x2d28
// Size: 0x1b3
function remoteuav_unmarkremovedplayer( remoteuav )
{
    level endon( #"game_ended" );
    msg = utility::waittill_any_return( "death_or_disconnect", "carried", "leaving" );
    
    if ( msg == "leaving" || !isdefined( self.uavtype ) )
    {
        self.uavremotemarkedby = undefined;
    }
    
    if ( isdefined( remoteuav ) )
    {
        if ( isplayer( self ) )
        {
            id = self.guid;
        }
        else if ( isdefined( self.birthtime ) )
        {
            id = self.birthtime;
        }
        else
        {
            id = self.birth_time;
        }
        
        if ( msg == "carried" || msg == "leaving" )
        {
            if ( isdefined( remoteuav.markedplayers[ id ][ "icon" ] ) )
            {
                remoteuav.markedplayers[ id ][ "icon" ] destroy();
                remoteuav.markedplayers[ id ][ "icon" ] = undefined;
            }
        }
        
        if ( isdefined( id ) && isdefined( remoteuav.markedplayers[ id ] ) )
        {
            remoteuav.markedplayers[ id ] = undefined;
            remoteuav.markedplayers = function_5713d46873b29625( remoteuav.markedplayers );
        }
    }
    
    if ( isplayer( self ) )
    {
        self unsetperk( "specialty_radarblip", 1 );
        return;
    }
    
    if ( isdefined( self.remoteuavmarkedobjid01 ) )
    {
        objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid01 );
    }
    
    if ( isdefined( self.remoteuavmarkedobjid02 ) )
    {
        objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid02 );
    }
    
    if ( isdefined( self.remoteuavmarkedobjid03 ) )
    {
        objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid03 );
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x556d7554, Offset: 0x2ee3
// Size: 0x9b
function remoteuav_clearmarkedforowner()
{
    foreach ( markedplayer in self.markedplayers )
    {
        if ( isdefined( markedplayer[ "icon" ] ) )
        {
            markedplayer[ "icon" ] destroy();
            markedplayer[ "icon" ] = undefined;
        }
    }
    
    self.markedplayers = undefined;
}

// Namespace remoteuav
// Params 1
// Checksum 0x6bf01ec1, Offset: 0x2f86
// Size: 0x57
function remoteuav_operationrumble( remoteuav )
{
    self endon( #"disconnect" );
    remoteuav endon( #"death" );
    level endon( #"game_ended" );
    remoteuav endon( #"end_remote" );
    
    while ( true )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.5;
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0xa2b028cd, Offset: 0x2fe5
// Size: 0x1b2
function remoteuav_watch_distance()
{
    self endon( #"death" );
    self.rangetrigger = getent( "remote_uav_range", #targetname );
    
    if ( !isdefined( self.rangetrigger ) )
    {
        heightent = killstreak_utility::getkillstreakairstrikeheightent();
        self.maxheight = heightent.origin[ 2 ];
        self.maxdistance = 12800;
    }
    
    self.centerref = spawn( "script_model", level.mapcenter );
    inrangepos = self.origin;
    self.rangecountdownactive = 0;
    
    while ( true )
    {
        if ( !remoteuav_in_range() )
        {
            staticalpha = 0;
            
            while ( !remoteuav_in_range() )
            {
                self.owner remoteuav_dialog( "out_of_range" );
                
                if ( !self.rangecountdownactive )
                {
                    self.rangecountdownactive = 1;
                    thread remoteuav_rangecountdown();
                }
                
                if ( isdefined( self.heliinproximity ) )
                {
                    dist = distance( self.origin, self.heliinproximity.origin );
                    staticalpha = 1 - ( dist - 150 ) / 150;
                }
                else
                {
                    dist = distance( self.origin, inrangepos );
                    staticalpha = min( 1, dist / 200 );
                }
                
                self.owner setplayerdata( "reconDroneState", "staticAlpha", staticalpha );
                wait 0.05;
            }
            
            self notify( #"in_range" );
            self.rangecountdownactive = 0;
            thread remoteuav_staticfade( staticalpha );
        }
        
        inrangepos = self.origin;
        waitframe();
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x2e2870e6, Offset: 0x319f
// Size: 0x84, Type: bool
function remoteuav_in_range()
{
    if ( isdefined( self.rangetrigger ) )
    {
        if ( !self istouching( self.rangetrigger ) && !self.inheliproximity )
        {
            return true;
        }
    }
    else if ( distance2d( self.origin, level.mapcenter ) < self.maxdistance && self.origin[ 2 ] < self.maxheight && !self.inheliproximity )
    {
        return true;
    }
    
    return false;
}

// Namespace remoteuav
// Params 1
// Checksum 0x75494590, Offset: 0x322c
// Size: 0x71
function remoteuav_staticfade( staticalpha )
{
    self endon( #"death" );
    
    while ( remoteuav_in_range() )
    {
        staticalpha -= 0.05;
        
        if ( staticalpha < 0 )
        {
            self.owner setplayerdata( "reconDroneState", "staticAlpha", 0 );
            break;
        }
        
        self.owner setplayerdata( "reconDroneState", "staticAlpha", staticalpha );
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x97a530a7, Offset: 0x32a5
// Size: 0x51
function remoteuav_rangecountdown()
{
    self endon( #"death" );
    self endon( #"in_range" );
    
    if ( isdefined( self.heliinproximity ) )
    {
        countdown = 3;
    }
    else
    {
        countdown = 6;
    }
    
    hostmigration::waitlongdurationwithhostmigrationpause( countdown );
    self notify( #"death" );
}

// Namespace remoteuav
// Params 0
// Checksum 0x2458d75a, Offset: 0x32fe
// Size: 0x2f
function remoteuav_explode_on_disconnect()
{
    self endon( #"death" );
    self.owner waittill( #"disconnect" );
    self notify( #"death" );
}

// Namespace remoteuav
// Params 0
// Checksum 0xa93aa9f, Offset: 0x3335
// Size: 0x34
function remoteuav_explode_on_changeteams()
{
    self endon( #"death" );
    self.owner utility::waittill_any( "joined_team", "joined_spectators" );
    self notify( #"death" );
}

// Namespace remoteuav
// Params 0
// Checksum 0xffd6ef6e, Offset: 0x3371
// Size: 0x22
function remoteuav_clear_marked_on_gameended()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    remoteuav_clearmarkedforowner();
}

// Namespace remoteuav
// Params 0
// Checksum 0x5b045b8b, Offset: 0x339b
// Size: 0x43
function remoteuav_leave_on_timeout()
{
    self endon( #"death" );
    flytime = 60;
    
    /#
        flytime = getdvarint( @"hash_da7c6c2551fb9f41", flytime );
    #/
    
    hostmigration::waitlongdurationwithhostmigrationpause( flytime );
    thread remoteuav_leave();
}

// Namespace remoteuav
// Params 0
// Checksum 0xab4aef7f, Offset: 0x33e6
// Size: 0x43
function remoteuav_leave()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"leaving" );
    self.owner remoteuav_endride( self );
    self notify( #"death" );
}

// Namespace remoteuav
// Params 0
// Checksum 0x9ea4fbae, Offset: 0x3431
// Size: 0x4a
function remoteuav_explode_on_death()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    self playsound( "recondrone_destroyed" );
    playfx( level.remoteuav_fx[ "explode" ], self.origin );
    remoteuav_cleanup();
}

// Namespace remoteuav
// Params 0
// Checksum 0xd5d5bdf1, Offset: 0x3483
// Size: 0xa7
function remoteuav_cleanup()
{
    if ( self.playerlinked == 1 && isdefined( self.owner ) )
    {
        self.owner remoteuav_endride( self );
    }
    
    if ( isdefined( self.scrambler ) )
    {
        self.scrambler delete();
    }
    
    if ( isdefined( self.centerref ) )
    {
        self.centerref delete();
    }
    
    remoteuav_clearmarkedforowner();
    stopfxontag( level.remoteuav_fx[ "smoke" ], self, "tag_origin" );
    level.remote_uav[ self.team ] = undefined;
    killstreak::decrementfauxvehiclecount();
    self delete();
}

// Namespace remoteuav
// Params 0
// Checksum 0x62badbdf, Offset: 0x3532
// Size: 0x48
function remoteuav_light_fx()
{
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail1" );
}

// Namespace remoteuav
// Params 1
// Checksum 0x64b316b2, Offset: 0x3582
// Size: 0xad
function remoteuav_dialog( dialoggroup )
{
    if ( dialoggroup == "tag" )
    {
        waittime = 1000;
    }
    else
    {
        waittime = 5000;
    }
    
    if ( gettime() - level.remoteuav_lastdialogtime < waittime )
    {
        return;
    }
    
    level.remoteuav_lastdialogtime = gettime();
    randomindex = randomint( level.remoteuav_dialog[ dialoggroup ].size );
    soundalias = level.remoteuav_dialog[ dialoggroup ][ randomindex ];
    fullsoundalias = teams::getteamvoiceinfix( self.team ) + "tl" + soundalias;
    self playlocalsound( fullsoundalias );
}

// Namespace remoteuav
// Params 0
// Checksum 0xb2eeee4, Offset: 0x3637
// Size: 0xda
function remoteuav_handleincomingstinger()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_remote" );
    
    while ( true )
    {
        level waittill( #"stinger_fired", player, missile, locktarget );
        
        if ( !( isdefined( missile ) && isdefined( locktarget ) ) || locktarget != self )
        {
            continue;
        }
        
        self.owner playlocalsound( "javelin_clu_lock" );
        self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
        self.hasincoming = 1;
        self.incomingmissiles[ self.incomingmissiles.size ] = missile;
        missile.owner = player;
        missile thread watchstingerproximity( locktarget );
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0xc41e0a02, Offset: 0x3719
// Size: 0x155
function remoteuav_handleincomingsam()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_remote" );
    
    while ( true )
    {
        level waittill( #"sam_fired", player, missilegroup, locktarget );
        
        if ( !isdefined( locktarget ) || locktarget != self )
        {
            continue;
        }
        
        var_b2b63e63c6e22be7 = 0;
        
        foreach ( missile in missilegroup )
        {
            if ( isdefined( missile ) )
            {
                self.incomingmissiles[ self.incomingmissiles.size ] = missile;
                missile.owner = player;
                var_b2b63e63c6e22be7++;
            }
        }
        
        if ( var_b2b63e63c6e22be7 )
        {
            self.owner playlocalsound( "javelin_clu_lock" );
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
            self.hasincoming = 1;
            level thread watchsamproximity( locktarget, missilegroup );
        }
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0x44266f67, Offset: 0x3876
// Size: 0x190
function watchstingerproximity( missiletarget )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self missile_settargetent( missiletarget );
    lastvectotarget = vectornormalize( missiletarget.origin - self.origin );
    
    while ( isdefined( missiletarget ) )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( missiletarget.numflares > 0 && curdist < 4000 )
        {
            newtarget = missiletarget deployflares();
            self missile_settargetent( newtarget );
            return;
        }
        else
        {
            curvectotarget = vectornormalize( missiletarget.origin - self.origin );
            
            if ( vectordot( curvectotarget, lastvectotarget ) < 0 )
            {
                self playsound( "exp_stinger_armor_destroy" );
                playfx( level.remoteuav_fx[ "missile_explode" ], self.origin );
                
                if ( isdefined( self.owner ) )
                {
                    radiusdamage( self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                }
                else
                {
                    radiusdamage( self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );
                }
                
                self hide();
                wait 0.05;
                self delete();
            }
            else
            {
                lastvectotarget = curvectotarget;
            }
        }
        
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 2
// Checksum 0x564bc7ce, Offset: 0x3a0e
// Size: 0x327
function watchsamproximity( missiletarget, missilegroup )
{
    level endon( #"game_ended" );
    missiletarget endon( #"death" );
    
    foreach ( missile in missilegroup )
    {
        if ( isdefined( missile ) )
        {
            missile missile_settargetent( missiletarget );
            missile.lastvectotarget = vectornormalize( missiletarget.origin - missile.origin );
        }
    }
    
    while ( missilegroup.size && isdefined( missiletarget ) )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        
        foreach ( missile in missilegroup )
        {
            if ( isdefined( missile ) )
            {
                if ( isdefined( self.markfordetete ) )
                {
                    self delete();
                    continue;
                }
                
                if ( missiletarget.numflares > 0 )
                {
                    disttotarget = distance( missile.origin, center );
                    
                    if ( disttotarget < 4000 )
                    {
                        newtarget = missiletarget deployflares();
                        
                        foreach ( var_a093648f84b8e763 in missilegroup )
                        {
                            if ( isdefined( var_a093648f84b8e763 ) )
                            {
                                var_a093648f84b8e763 missile_settargetent( newtarget );
                            }
                        }
                        
                        return;
                    }
                    
                    continue;
                }
                
                curvectotarget = vectornormalize( missiletarget.origin - missile.origin );
                
                if ( vectordot( curvectotarget, missile.lastvectotarget ) < 0 )
                {
                    missile playsound( "exp_stinger_armor_destroy" );
                    playfx( level.remoteuav_fx[ "missile_explode" ], missile.origin );
                    
                    if ( isdefined( missile.owner ) )
                    {
                        radiusdamage( missile.origin, 400, 1000, 1000, missile.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                    }
                    else
                    {
                        radiusdamage( missile.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );
                    }
                    
                    missile hide();
                    missile.markfordetete = 1;
                    continue;
                }
                
                missile.lastvectotarget = curvectotarget;
            }
        }
        
        missilegroup = function_5713d46873b29625( missilegroup );
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0xdc3368ea, Offset: 0x3d3d
// Size: 0xb8
function deployflares()
{
    self.numflares--;
    self.owner thread remoteuav_rumble( self, 6 );
    self playsound( "WEAP_SHOTGUNATTACH_FIRE_NPC" );
    thread playflarefx();
    spawnpos = self.origin + ( 0, 0, -100 );
    flareobject = spawn( "script_origin", spawnpos );
    flareobject.targetname = "deployFlares";
    flareobject.angles = self.angles;
    flareobject movegravity( ( 0, 0, -1 ), 5 );
    flareobject thread deleteaftertime( 5 );
    return flareobject;
}

// Namespace remoteuav
// Params 0
// Checksum 0x707c403, Offset: 0x3dfe
// Size: 0x44
function playflarefx()
{
    for ( i = 0; i < 5 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        playfxontag( level._effect[ "vehicle_flares" ], self, "TAG_FLARE" );
        wait 0.15;
    }
}

// Namespace remoteuav
// Params 1
// Checksum 0x9c02b616, Offset: 0x3e4a
// Size: 0x15
function deleteaftertime( delay )
{
    wait delay;
    self delete();
}

// Namespace remoteuav
// Params 0
// Checksum 0xd03d1664, Offset: 0x3e67
// Size: 0xd8
function remoteuav_clearincomingwarning()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_remote" );
    
    while ( true )
    {
        numincoming = 0;
        
        for ( i = 0; i < self.incomingmissiles.size ; i++ )
        {
            if ( isdefined( self.incomingmissiles[ i ] ) && missile_isincoming( self.incomingmissiles[ i ], self ) )
            {
                numincoming++;
            }
        }
        
        if ( self.hasincoming && !numincoming )
        {
            self.hasincoming = 0;
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 0 );
        }
        
        self.incomingmissiles = function_5713d46873b29625( self.incomingmissiles );
        wait 0.05;
    }
}

// Namespace remoteuav
// Params 2
// Checksum 0x51668260, Offset: 0x3f47
// Size: 0x5e, Type: bool
function missile_isincoming( missile, remoteuav )
{
    vectoremote = vectornormalize( remoteuav.origin - missile.origin );
    var_8eca39d2d43b4043 = anglestoforward( missile.angles );
    return vectordot( vectoremote, var_8eca39d2d43b4043 ) > 0;
}

// Namespace remoteuav
// Params 0
// Checksum 0xec585da5, Offset: 0x3fae
// Size: 0x1d9
function remoteuav_watchheliproximity()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"end_remote" );
    
    while ( true )
    {
        inheliproximity = 0;
        
        foreach ( heli in level.helis )
        {
            if ( distance( heli.origin, self.origin ) < 300 )
            {
                inheliproximity = 1;
                self.heliinproximity = heli;
            }
        }
        
        foreach ( littlebird in level.littlebirds )
        {
            if ( littlebird != self && littlebird.helitype != "remote_uav" && distance( littlebird.origin, self.origin ) < 300 )
            {
                inheliproximity = 1;
                self.heliinproximity = littlebird;
            }
        }
        
        if ( !self.inheliproximity && inheliproximity )
        {
            self.inheliproximity = 1;
        }
        else if ( self.inheliproximity && !inheliproximity )
        {
            self.inheliproximity = 0;
            self.heliinproximity = undefined;
        }
        
        waitframe();
    }
}

// Namespace remoteuav
// Params 0
// Checksum 0x8dc9e864, Offset: 0x418f
// Size: 0x2f
function remoteuav_handledamage()
{
    self endon( #"end_remote" );
    damage::monitordamage( self.maxhealth, "remote_uav", &handledeathdamage, &modifydamage, 1 );
}

// Namespace remoteuav
// Params 1
// Checksum 0x5e1fdede, Offset: 0x41c6
// Size: 0x111
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = damage::handleempdamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    playfxontagforclients( level.remoteuav_fx[ "hit" ], self, "tag_origin", self.owner );
    self playsound( "recondrone_damaged" );
    
    if ( self.smoking == 0 && self.damagetaken >= self.maxhealth / 2 )
    {
        self.smoking = 1;
        playfxontag( level.remoteuav_fx[ "smoke" ], self, "tag_origin" );
    }
    
    return modifieddamage;
}

// Namespace remoteuav
// Params 1
// Checksum 0x969ae495, Offset: 0x42e0
// Size: 0x7f
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    damage::onkillstreakkilled( "remote_uav", attacker, objweapon, type, damage, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav" );
}

