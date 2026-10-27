// scripts\mp\common\weapons\roulette_gun.gsc  (hash_39b491a8d5642c71.gscc) (size: 10874 Bytes / 0x2a7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x761006b8 (1980761784)
// size ...... 10874 (0x2a7a)
// includes .. 11  (offset: 0x28ba)
// strings ... 24  (offset: 0x2912)
// dev strs .. 1   (offset: 0x2a6e)
// exports ... 30  (offset: 0x162e)
// cseg ...... 0x1e1 + 0x144d (0x162e)
// imports ... 120 (offset: 0x1ade)
// animtree1 . 0   (offset: 0x2a7a)
// animtree2 . 0   (offset: 0x2a7a)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\objidpoolmanager;

#namespace roulette_gun;

// Namespace roulette_gun
// Params 0, eflags: 0x1
// Checksum 0xd3a03ef2, Offset: 0x1ff
// Size: 0x155
function autoexec main()
{
    utility::registersharedfunc( #"roulette_weapon", #"hash_9a3351232269a6cc", &function_c6f6696c68eab82 );
    utility::registersharedfunc( #"roulette_weapon", #"hash_48afd1eee6912521", &function_d1bc7d7fbc8705ab );
    utility::registersharedfunc( #"roulette_weapon", #"spawn_roulette_weapon", &function_674f912326619f8d );
    utility::registersharedfunc( #"roulette_weapon", #"hash_313858dca0b4e4b8", &function_6167f4c89e47a751 );
    level callback::add( #"hash_35e8c753e3a178cc", &function_e927db442d59ccb );
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"hash_5e4c0033a7bbd7f", &function_239a5e71567f97c8 );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    level._effect[ "roulette_fail_fx" ] = loadfxasset( "vfx_core_equip_at_mine_explo" );
    level.var_f3d13b4345302e52 = 0;
    level.var_f8fa53377f8ff7d4 = 1;
    level.var_63cff0250881ce7b = 1;
    rouletteoverride = getdvar( @"roulette_gun_override", "t10_pi_roulette" );
    function_1ad10376332e09dc( rouletteoverride );
    level.var_fdea99ebcf94c020 = "ui_hud_stingray_waypoint_handgun";
    level.var_ec59c08f9b7f0a3b = "outlinefill_golden_gun";
    thread function_573c293f70f078b2();
}

// Namespace roulette_gun
// Params 1
// Checksum 0xa8b43494, Offset: 0x35c
// Size: 0x1f
function function_1ad10376332e09dc( gunref )
{
    level.var_ed31c99a6e54a5fe = gunref ?? "t10_pi_roulette";
}

// Namespace roulette_gun
// Params 1
// Checksum 0xee8ecf8a, Offset: 0x383
// Size: 0x1f
function function_6580bb94b88148c9( iconref )
{
    level.var_fdea99ebcf94c020 = iconref ?? "ui_hud_stingray_waypoint_handgun";
}

// Namespace roulette_gun
// Params 1
// Checksum 0xb06c3414, Offset: 0x3aa
// Size: 0x1f
function function_5836a9aa45a9688f( outlineref )
{
    level.var_ec59c08f9b7f0a3b = outlineref ?? "outlinefill_golden_gun";
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0xba4d2e29, Offset: 0x3d1
// Size: 0x5e
function private function_573c293f70f078b2()
{
    level endon( #"game_ended" );
    level waittill( #"start_mode_setup" );
    
    if ( getdvarint( @"hash_49ef9aa60cf97381", 0 ) )
    {
        roulettegun = function_d1bc7d7fbc8705ab( 3 );
        return;
    }
    
    if ( getdvarint( @"hash_fd7fc9268d1ddeac", 0 ) )
    {
        roulettegun = function_c6f6696c68eab82( 3 );
    }
}

// Namespace roulette_gun
// Params 1
// Checksum 0xc4521d00, Offset: 0x437
// Size: 0x58
function function_c6f6696c68eab82( spawndelay )
{
    if ( isdefined( level.var_654ffd608d133350 ) )
    {
        spawnorigin = level.var_654ffd608d133350 + 60 * vectornormalize( anglestoforward( ( 0, randomint( 360 ), 0 ) ) );
        return function_674f912326619f8d( getclosestpointonnavmesh( spawnorigin ) ?? spawnorigin, spawndelay );
    }
}

// Namespace roulette_gun
// Params 1
// Checksum 0x610995dd, Offset: 0x497
// Size: 0x63
function function_d1bc7d7fbc8705ab( spawndelay )
{
    if ( isdefined( level.mapcenter ) )
    {
        spawnorigin = level.mapcenter;
        spawnorigin += 60 * vectornormalize( anglestoforward( ( 0, randomint( 360 ), 0 ) ) );
        return function_674f912326619f8d( getclosestpointonnavmesh( spawnorigin ) ?? level.mapcenter, spawndelay );
    }
}

// Namespace roulette_gun
// Params 2
// Checksum 0x173d9ca7, Offset: 0x502
// Size: 0xf5
function function_674f912326619f8d( origin, spawndelay )
{
    if ( isdefined( spawndelay ) )
    {
        wait spawndelay;
    }
    
    if ( !isdefined( level.var_a20f61201152cf5b ) )
    {
        level.var_a20f61201152cf5b = weapon_utility::function_d2c8356dc369d9ce( level.var_ed31c99a6e54a5fe );
    }
    
    origin += ( 0, 0, 28 );
    spawnflags = 1;
    var_deabf9bebea90612 = utility::function_a0b2f814bf08507f( level.var_ed31c99a6e54a5fe, origin, [], ( 45, 45, 45 ), spawnflags );
    var_deabf9bebea90612 makeunusable();
    var_deabf9bebea90612 hudoutlineenable( level.var_ec59c08f9b7f0a3b );
    
    if ( getdvarint( @"hash_de9911ea15d90179", 1 ) )
    {
        var_deabf9bebea90612 function_85f84d8ca500f399( "ui_hud_stingray_waypoint_handgun" );
    }
    
    var_deabf9bebea90612.var_9c4a7e8612b26ec6 = var_deabf9bebea90612 function_d4c4d5a2ca5f077a( level.var_fdea99ebcf94c020 );
    var_deabf9bebea90612 function_421d176a9a98e084();
    thread function_ee974036c53edd5d( var_deabf9bebea90612 );
    return var_deabf9bebea90612;
}

// Namespace roulette_gun
// Params 0
// Checksum 0xd856c493, Offset: 0x600
// Size: 0x79
function function_421d176a9a98e084()
{
    movingplatforminfo = utility::function_7c45b71b8e0d3cff( self );
    
    if ( isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) )
    {
        if ( movingplatforminfo.groundent.classname == "grenade" )
        {
            return;
        }
        
        self linkto( movingplatforminfo.groundent );
        thread function_40228c29217e9e4d();
    }
}

// Namespace roulette_gun
// Params 0
// Checksum 0xc8773fc9, Offset: 0x681
// Size: 0x69
function function_40228c29217e9e4d()
{
    level endon( #"game_ended" );
    self endon( #"roulette_gun_finished" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !self.var_9c4a7e8612b26ec6 || !self.origin )
        {
            return;
        }
        
        objidpoolmanager::update_objective_position( self.var_9c4a7e8612b26ec6, self.origin );
        wait 0.5;
    }
}

// Namespace roulette_gun
// Params 0
// Checksum 0x298e4a9, Offset: 0x6f2
// Size: 0xb
function function_e77f7f5d21804ff1()
{
    return self.var_9f4e6cad7530382;
}

// Namespace roulette_gun
// Params 1
// Checksum 0x48b79dc6, Offset: 0x706
// Size: 0x2b, Type: bool
function function_6167f4c89e47a751( objweapon )
{
    return function_e77f7f5d21804ff1() && objweapon.basename == level.var_ed31c99a6e54a5fe;
}

// Namespace roulette_gun
// Params 1
// Checksum 0x831c1269, Offset: 0x73a
// Size: 0xbd
function function_239a5e71567f97c8( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( victim damage::issuicide( params.inflictor, attacker, params.meansofdeath, params.objweapon ) || victim damage::isteamkill( params.inflictor, attacker ) )
    {
        return;
    }
    
    if ( isdefined( attacker ) && attacker function_6167f4c89e47a751( params.objweapon ) )
    {
        attacker thread points::doscoreevent( #"roulette_kill" );
        params.var_eacecf0a1e48bf74 = 1;
    }
}

// Namespace roulette_gun
// Params 1
// Checksum 0x67efa1c0, Offset: 0x7ff
// Size: 0xc9
function onplayerdeath( params )
{
    victim = params.victim;
    
    if ( victim function_e77f7f5d21804ff1() )
    {
        victim.var_9f4e6cad7530382 = undefined;
        victim.var_9aa66d67d4bbc976 = undefined;
        victim.var_100b03d0c0656947 = undefined;
        victim.skipuavupdate = undefined;
        victim.var_de644405bc8fb343 = undefined;
        victim.var_45358537ea3e05c3 = undefined;
        victim function_9784ea68bd261ea5();
        
        if ( level.var_63cff0250881ce7b )
        {
            var_deabf9bebea90612 = victim function_674f912326619f8d( getclosestpointonnavmesh( victim.origin ) ?? victim.origin );
        }
        
        victim val::set( "roulette_weapon", "weapon_pickup", 1 );
    }
}

// Namespace roulette_gun
// Params 1
// Checksum 0x7b1e5384, Offset: 0x8d0
// Size: 0xbc
function function_e927db442d59ccb( params )
{
    var_b720e108ea382ac0 = getentarray( "flag_primary", #targetname );
    
    foreach ( flag in var_b720e108ea382ac0 )
    {
        if ( flag.script_label == "_b" )
        {
            level.var_654ffd608d133350 = flag.origin;
            break;
        }
    }
}

// Namespace roulette_gun
// Params 0
// Checksum 0x6c4bb749, Offset: 0x994
// Size: 0x1df
function function_2a6e8233e2103ee3()
{
    if ( !function_e77f7f5d21804ff1() )
    {
        return;
    }
    
    self notify( #"roulette_gun_finished" );
    var_b827c5f2ccf6b65b = self getcurrentprimaryweapon() == level.var_a20f61201152cf5b;
    
    if ( self hasweapon( level.var_a20f61201152cf5b ) )
    {
        self takeweapon( level.var_a20f61201152cf5b );
    }
    
    fallbackprimary = undefined;
    
    if ( isdefined( self.var_45358537ea3e05c3 ) )
    {
        foreach ( weapon in self.var_45358537ea3e05c3 )
        {
            if ( !self hasweapon( weapon ) )
            {
                self giveweapon( weapon );
                
                if ( level.tertiaryweaponslotenabled && weapon.ismelee && weapon != level.defaultfist )
                {
                    self assignweaponmeleeslot( weapon );
                }
            }
            
            if ( !isdefined( fallbackprimary ) && weapon.type == "bullet" )
            {
                fallbackprimary = weapon;
            }
        }
        
        self.var_45358537ea3e05c3 = undefined;
    }
    
    if ( !isdefined( self.var_de644405bc8fb343 ) )
    {
        self.var_de644405bc8fb343 = fallbackprimary;
    }
    
    if ( var_b827c5f2ccf6b65b )
    {
        self switchtoweapon( self.var_de644405bc8fb343 );
    }
    
    self.var_de644405bc8fb343 = undefined;
    self.var_9f4e6cad7530382 = undefined;
    self.var_9aa66d67d4bbc976 = undefined;
    self.skipuavupdate = 0;
    val::set( "roulette_weapon", "weapon_pickup", 1 );
    radardata = uav::function_ce7678b7924e8588( self.team );
    uav::function_1d490f49c4dc99a9( self, radardata );
    level notify( #"uav_update" );
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0x485a190c, Offset: 0xb7b
// Size: 0xa8
function private function_53efa522b08cf42a()
{
    function_7831a18113775660();
    val::set( "roulette_weapon", "weapon_pickup", 0 );
    self giveweapon( level.var_a20f61201152cf5b );
    self switchtoweapon( level.var_a20f61201152cf5b );
    self.var_9f4e6cad7530382 = 1;
    
    if ( !level.var_a8d1c7a1f8d31114 )
    {
        self notifyonplayercommand( "removeRoulette", "+weapnext" );
        self notifyonplayercommand( "removeRoulette", "+weapprev" );
        thread function_7ba67d22c8cc23a3();
    }
    
    pickupdata = spawnstruct();
    pickupdata.player = self;
    level callback::callback( #"roulette_gun_pickup", pickupdata );
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0x2afd7c07, Offset: 0xc2b
// Size: 0xe1
function private function_7ba67d22c8cc23a3()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"roulette_gun_finished" );
    
    while ( true )
    {
        self waittill( #"removeRoulette" );
        self notifyonplayercommandremove( "removeRoulette", "+weapnext" );
        self notifyonplayercommandremove( "removeRoulette", "+weapprev" );
        
        if ( !function_e77f7f5d21804ff1() )
        {
            return;
        }
        
        function_9784ea68bd261ea5();
        callback::callback( #"roulette_gun_drop" );
        
        if ( level.var_63cff0250881ce7b )
        {
            var_deabf9bebea90612 = function_674f912326619f8d( getclosestpointonnavmesh( self.origin ) ?? self.origin );
        }
        else if ( isdefined( level.var_b8c14453f58b44df ) )
        {
            [[ level.var_b8c14453f58b44df ]]( self.origin );
        }
        
        thread function_2a6e8233e2103ee3();
        return;
    }
}

// Namespace roulette_gun
// Params 1, eflags: 0x4
// Checksum 0xf6721fa2, Offset: 0xd14
// Size: 0x162
function private function_ee974036c53edd5d( var_deabf9bebea90612 )
{
    level endon( #"game_ended" );
    var_deabf9bebea90612 endon( #"roulette_gun_finished" );
    
    if ( !isdefined( var_deabf9bebea90612 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    useobject = spawn( "script_model", var_deabf9bebea90612.origin );
    useobject setmodel( "tag_origin" );
    useobject linkto( var_deabf9bebea90612 );
    useobject makeusable();
    useobject setuserange( 100 );
    useobject setuseholdduration( "duration_none" );
    useobject setcursorhint( "HINT_NOICON" );
    useobject sethintdisplayrange( 100 );
    useobject sethintstring( &"mp_ingame_only/roulette_gun_pick_up" );
    var_deabf9bebea90612.useobject = useobject;
    
    while ( true )
    {
        useobject waittill( #"trigger", player );
        
        if ( !( player function_e77f7f5d21804ff1() || player utility::isusingremote() ) && player::isreallyalive( player ) )
        {
            player.var_9c4a7e8612b26ec6 = var_deabf9bebea90612.var_9c4a7e8612b26ec6;
            player thread function_b76f6cd2d37f5e47();
            function_29afc30fe43353f1( var_deabf9bebea90612, useobject );
            player function_53efa522b08cf42a();
            
            if ( level.var_f3d13b4345302e52 )
            {
                player thread function_487b01162a4fd808();
            }
            
            if ( level.var_f8fa53377f8ff7d4 )
            {
                player thread function_1cfc1ce9b3fb7581();
            }
            
            return;
        }
    }
}

// Namespace roulette_gun
// Params 1
// Checksum 0xe9565d60, Offset: 0xe7e
// Size: 0x89
function onplayerdisconnect( params )
{
    if ( function_e77f7f5d21804ff1() )
    {
        function_9784ea68bd261ea5();
        respawnpos = self.origin ? self.origin : level.var_654ffd608d133350;
        respawnpos = getclosestpointonnavmesh( respawnpos ) ?? respawnpos;
        
        if ( level.var_63cff0250881ce7b )
        {
            function_674f912326619f8d( respawnpos );
            return;
        }
        
        if ( isdefined( level.var_b8c14453f58b44df ) )
        {
            [[ level.var_b8c14453f58b44df ]]( respawnpos );
        }
    }
}

// Namespace roulette_gun
// Params 2
// Checksum 0x9da34199, Offset: 0xf0f
// Size: 0x33
function function_29afc30fe43353f1( var_deabf9bebea90612, useobject )
{
    useobject makeunusable();
    useobject delete();
    var_deabf9bebea90612 function_a0c0c8a1395fa240();
    var_deabf9bebea90612 delete();
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0x1d221390, Offset: 0xf4a
// Size: 0xf6
function private function_1cfc1ce9b3fb7581()
{
    self endon( #"death_or_disconnect" );
    self endon( #"roulette_gun_finished" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_100b03d0c0656947 ) )
    {
        self.var_100b03d0c0656947 = 0;
    }
    
    while ( true )
    {
        self.var_9aa66d67d4bbc976 = self.var_100b03d0c0656947 && randomfloatrange( 0, 1 ) < 0.18;
        self waittill( #"weapon_fired", objweapon );
        
        if ( function_6167f4c89e47a751( objweapon ) )
        {
            if ( self.var_9aa66d67d4bbc976 )
            {
                if ( utility::fxexists( "roulette_fail_fx" ) )
                {
                    playfx( utility::getfx( "roulette_fail_fx" ), self gettagorigin( "j_gun" ) ?? self.origin );
                }
                
                self kill( self.origin, self, objweapon, "MOD_EXPLOSIVE", objweapon );
            }
            
            self.var_100b03d0c0656947 = 1;
        }
    }
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0xe281fc50, Offset: 0x1048
// Size: 0x113
function private function_487b01162a4fd808()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"roulette_gun_finished" );
    
    if ( self.ishvt )
    {
        return;
    }
    
    while ( true )
    {
        if ( uav::function_c6b46bde3b7bc0a1( self.team ) > getuavstrengthmin() )
        {
            self.skipuavupdate = 1;
            self.radarstrength = getuavstrengthlevelneutral() + 1;
            self.isradarblocked = 0;
            self.hasradar = 1;
            self.radarshowenemydirection = 1;
            self.radarmode = "normal_radar";
            var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
            
            if ( isdefined( var_ec86cf09b79859c3 ) )
            {
                level [[ var_ec86cf09b79859c3 ]]( [ self ] );
            }
        }
        else
        {
            self.skipuavupdate = 0;
            radardata = uav::function_ce7678b7924e8588( self.team );
            uav::function_1d490f49c4dc99a9( self, radardata );
        }
        
        level waittill( #"uav_update" );
    }
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0xadc08e74, Offset: 0x1163
// Size: 0xd1
function private function_7831a18113775660()
{
    self.var_de644405bc8fb343 = self getcurrentprimaryweapon();
    weapons = self getweaponslistall();
    weaponstaken = [];
    
    foreach ( weapon in weapons )
    {
        if ( weapon.inventorytype == "primary" && weapon != level.var_f8ac15ada97a702a )
        {
            weaponstaken[ weaponstaken.size ] = weapon;
            self takeweapon( weapon );
        }
    }
    
    self.var_45358537ea3e05c3 = weaponstaken;
}

// Namespace roulette_gun
// Params 1, eflags: 0x4
// Checksum 0x38fd6cd0, Offset: 0x123c
// Size: 0xa4
function private function_d4c4d5a2ca5f077a( icon )
{
    objid = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        objid = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]();
    }
    else
    {
        return;
    }
    
    objective_icon( objid, icon );
    objective_position( objid, self.origin );
    objective_setzoffset( objid, 28 );
    objective_setplayintro( objid, 0 );
    objective_setplayoutro( objid, 0 );
    objective_setbackground( objid, 0 );
    function_2b8e3d3ae2a6414a( objid, 1 );
    objective_state( objid, "current" );
    return objid;
}

// Namespace roulette_gun
// Params 0, eflags: 0xc
// Checksum 0x948d7480, Offset: 0x12e9
// Size: 0x26c
function private function_b76f6cd2d37f5e47()
{
    self notify( #"hash_eda57e3c99ff5927" );
    self endon( #"hash_eda57e3c99ff5927" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"roulette_gun_finished" );
    var_82bb5d9e3a1bdcee = 1500;
    previousupdatetime = gettime();
    
    if ( !level.teambased )
    {
        function_fd9ed552c76d6299( self.var_9c4a7e8612b26ec6 );
        objective_removeclientfrommask( self.var_9c4a7e8612b26ec6, self );
        objective_showtoplayersinmask( self.var_9c4a7e8612b26ec6 );
    }
    else
    {
        self.var_f10e5edab731237d = function_d4c4d5a2ca5f077a( level.var_fdea99ebcf94c020 );
        objective_setownerteam( self.var_f10e5edab731237d, self.team );
        objective_removeallfrommask( self.var_f10e5edab731237d );
        
        foreach ( p in teams::getteamdata( self.team, "players" ) )
        {
            if ( p != self )
            {
                objective_addclienttomask( self.var_f10e5edab731237d, p );
            }
        }
        
        objective_showtoplayersinmask( self.var_f10e5edab731237d );
        objidpoolmanager::objective_teammask_single( self.var_9c4a7e8612b26ec6, team_utility::getotherteam( self.team ) );
        objective_setownerteam( self.var_9c4a7e8612b26ec6, self.team );
    }
    
    while ( isdefined( self.var_9c4a7e8612b26ec6 ) )
    {
        if ( !utility::isusingremote() )
        {
            if ( isdefined( self.var_f10e5edab731237d ) )
            {
                objpos = self geteye() + ( 0, 0, 28 );
                objidpoolmanager::update_objective_position( self.var_f10e5edab731237d, objpos );
                objective_ping( self.var_f10e5edab731237d );
            }
            
            currtime = gettime();
            
            if ( currtime - previousupdatetime >= var_82bb5d9e3a1bdcee )
            {
                objpos = objpos ? objpos : self geteye() + ( 0, 0, 28 );
                objidpoolmanager::update_objective_position( self.var_9c4a7e8612b26ec6, objpos );
                objective_ping( self.var_9c4a7e8612b26ec6 );
                previousupdatetime = currtime;
                objpos = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace roulette_gun
// Params 0
// Checksum 0xddb94f85, Offset: 0x155d
// Size: 0x50
function function_9784ea68bd261ea5()
{
    if ( isdefined( self.var_9c4a7e8612b26ec6 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_9c4a7e8612b26ec6 );
        self.var_9c4a7e8612b26ec6 = undefined;
    }
    
    if ( isdefined( self.var_f10e5edab731237d ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_f10e5edab731237d );
        self.var_f10e5edab731237d = undefined;
    }
}

// Namespace roulette_gun
// Params 1, eflags: 0x4
// Checksum 0x461e52bb, Offset: 0x15b5
// Size: 0x23
function private function_85f84d8ca500f399( icon )
{
    self.minimapid = objidpoolmanager::createobjective( icon, undefined, 0, 1, 1 );
}

// Namespace roulette_gun
// Params 0, eflags: 0x4
// Checksum 0x4375529f, Offset: 0x15e0
// Size: 0x4e
function private function_a0c0c8a1395fa240()
{
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
    }
}

