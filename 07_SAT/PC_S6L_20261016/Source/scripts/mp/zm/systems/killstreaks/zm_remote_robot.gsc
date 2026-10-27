// scripts\mp\zm\systems\killstreaks\zm_remote_robot.gsc  (hash_7759056faa8362b6.gscc) (size: 9715 Bytes / 0x25f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x300d63e0 (806183904)
// size ...... 9715 (0x25f3)
// includes .. 17  (offset: 0x2427)
// strings ... 22  (offset: 0x24af)
// dev strs .. 0   (offset: 0x25f3)
// exports ... 19  (offset: 0x164b)
// cseg ...... 0x1ff + 0x144c (0x164b)
// imports ... 93  (offset: 0x1943)
// animtree1 . 0   (offset: 0x25f3)
// animtree2 . 0   (offset: 0x25f3)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\health_overcharge;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\zm_utility;

#namespace zm_remote_robot;

// Namespace zm_remote_robot
// Params 0, eflags: 0x5
// Checksum 0x4709043, Offset: 0x21d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_remote_robot", undefined, &__init__, undefined );
}

// Namespace zm_remote_robot
// Params 0
// Checksum 0xb6810e93, Offset: 0x23e
// Size: 0xa
function __init__()
{
    level thread init_zm_remote_robot();
}

// Namespace zm_remote_robot
// Params 0
// Checksum 0x6cf7a742, Offset: 0x250
// Size: 0x153
function init_zm_remote_robot()
{
    utility::flag_wait( "remote_robot_initialized" );
    weaponname = utility::get_scripted_weapon_name( #"remote_robot" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "remote_robot", weaponname, #"medium" );
    utility::registersharedfunc( #"remote_robot", #"remote_robot_portal_spawn", &remote_robot_spawn_portal );
    utility::registersharedfunc( #"remote_robot", #"hash_dc4fcbad159518e1", &function_fa29c99da99e3dbc );
    utility::registersharedfunc( #"remote_robot", #"hash_2e29256d840c1a5f", &function_3a8413c48dbf0c97 );
    utility::registersharedfunc( #"remote_robot", #"hash_e955882301181a5a", &function_93e7a1d78da63745 );
    utility::registersharedfunc( #"remote_robot", #"hash_faa2ffebcab9bda2", &function_5bdb5d4a11e9ea76 );
    level._effect[ "portal_spawn" ] = loadfxasset( "vfx_t10_gameplay_zm_trials_machine_spawn" );
    level.var_d91f744c9d0dc394 = level.killstreaksetups[ "remote_robot" ].triggeredfunc;
    level.killstreaksetups[ "remote_robot" ].triggeredfunc = &function_e10e96465b49057b;
    level.var_2794781b61e20ff4 = getnoentvolumearray( "disallow_rr_area", #targetname );
}

// Namespace zm_remote_robot
// Params 2
// Checksum 0xa8353c41, Offset: 0x3ab
// Size: 0xbb
function remote_robot_spawn_portal( remote_robot, start_pos )
{
    remote_robot endon( #"remote_robot_ended" );
    level endon( #"game_ended" );
    health_overcharge::function_1050a266d4743956( 1 );
    portalscriptable = spawnscriptable( "sat_zm_spawn_portal", start_pos + ( 0, 0, 50 ) );
    portalscriptable setscriptablepartstate( "portal", "on" );
    remote_robot playerhide();
    wait 0.75;
    playfx( level._effect[ "portal_spawn" ], start_pos );
    remote_robot playershow();
    wait 2;
    portalscriptable setscriptablepartstate( "portal", "off" );
    wait 4;
    portalscriptable freescriptable();
}

// Namespace zm_remote_robot
// Params 0
// Checksum 0x3f2d2a5b, Offset: 0x46e
// Size: 0x4a
function function_fa29c99da99e3dbc()
{
    self.var_b8a3eb3d2a1c3998 = 1;
    health_overcharge::function_1050a266d4743956( 0 );
    val::set( "remote_robot_ignore_me", "ignoreme", 1 );
    
    if ( isdefined( self.var_7fe167ac52a87d1f ) )
    {
        thread function_95c3dc971c26c56b();
    }
    
    thread function_e386548b0ab21fb9( 3, "remote_robot_ignore_me" );
}

// Namespace zm_remote_robot
// Params 1
// Checksum 0xf9c84eb, Offset: 0x4c0
// Size: 0x1af, Type: bool
function function_3a8413c48dbf0c97( explosiondata )
{
    damage = explosiondata.damagemax;
    damage_radius = explosiondata.radius;
    weapon = explosiondata.objweapon;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_round_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty ) ?? 100;
    zombie_start_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", 1 ) ?? 100;
    var_8d2325a3c1b80415 = damage / zombie_start_health;
    damage = int( zombie_round_health * var_8d2325a3c1b80415 );
    potentialtargets = getaiarrayinradius( self.origin, damage_radius ) ?? [];
    
    foreach ( target in potentialtargets )
    {
        if ( !isai( target ) )
        {
            continue;
        }
        
        if ( !isalive( target ) )
        {
            continue;
        }
        
        if ( target zombie_utils::function_bf1464d09f4e4b40() )
        {
            continue;
        }
        
        if ( target utility::ent_flag( "scene_ent_playing_anim" ) )
        {
            continue;
        }
        
        target dodamage( damage, self.origin, self, self, "MOD_EXPLOSIVE", weapon, undefined, undefined, 1073741824 );
        
        if ( isalive( target ) )
        {
            target zombie_stun::stun_ai( 3 );
        }
    }
    
    return true;
}

// Namespace zm_remote_robot
// Params 1, eflags: 0x4
// Checksum 0xf4d53b62, Offset: 0x678
// Size: 0x1d0
function private function_8f9f9a1061809b7a( params )
{
    if ( self.health > 0 )
    {
        damage = params.idamage >= self.health ? self.health - 1 : params.idamage;
        var_ca02bfdd611a56f4 = self.health;
        damage::preplayerdamaged( params.einflictor, params.eattacker, self, damage, params.idflags, params.smeansofdeath, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none" );
        damage::finishplayerdamagewrapper( params.einflictor, params.eattacker, damage, params.idflags, params.smeansofdeath, 0, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none", 1 );
        damage::postplayerdamaged( params.einflictor, params.eattacker, self, damage, params.idflags, params.smeansofdeath, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none", 0, 0, var_ca02bfdd611a56f4 );
        self.health = max( self.health, 1 );
    }
}

// Namespace zm_remote_robot
// Params 5
// Checksum 0x11a2d8fc, Offset: 0x850
// Size: 0xa6
function function_93e7a1d78da63745( attacker, damage, smeansofdeath, objweapon, inflictor )
{
    if ( attacker != self && isplayer( attacker ) && !player_utility::isenemy( attacker ) )
    {
        return damage;
    }
    
    if ( isdefined( attacker.aicategory ) && !isagent( attacker ) )
    {
        return damage;
    }
    
    if ( attacker.subclass == "zombie_diana" )
    {
        damage = damage > 50 ? 50 : damage;
    }
    
    if ( val::get( "ignoreme" ) )
    {
        damage = 0;
    }
    
    return damage;
}

// Namespace zm_remote_robot
// Params 2, eflags: 0x4
// Checksum 0x4aaad194, Offset: 0x8ff
// Size: 0x32
function private function_e386548b0ab21fb9( time, str_id )
{
    level endon( #"game_ended" );
    wait time;
    
    if ( isdefined( self ) )
    {
        val::reset_all( str_id );
    }
}

// Namespace zm_remote_robot
// Params 1, eflags: 0x4
// Checksum 0x3366c651, Offset: 0x939
// Size: 0x79
function private function_e48e2a16bc05706d( weapstruct )
{
    if ( !isdefined( weapstruct.var_6828becb300b1c44 ) )
    {
        return;
    }
    
    primaryweaponindex = item_weapon::function_1464d1c9177c4934( weapstruct.weaponobj );
    
    if ( !isdefined( primaryweaponindex ) || primaryweaponindex < 0 || primaryweaponindex >= self.primaryinventory.size )
    {
        return;
    }
    
    self.var_1a87a9e7cf39ff69[ primaryweaponindex ] = structcopy( weapstruct.var_6828becb300b1c44, 1 );
}

// Namespace zm_remote_robot
// Params 1, eflags: 0x4
// Checksum 0x3e9fb235, Offset: 0x9ba
// Size: 0x4a5
function private function_5bdb5d4a11e9ea76( respawnitems )
{
    if ( !isdefined( respawnitems ) )
    {
        return;
    }
    
    thread function_81c65067d1e846e3( "specialty_juggernog" );
    thread function_81c65067d1e846e3( "specialty_m_mod" );
    thread function_81c65067d1e846e3( "specialty_phd_flopper" );
    
    if ( !isdefined( self.a_saved_weapons ) )
    {
        zm_utility::function_d47920bb0d5fa327( "zmremoterobot" );
        self.var_4cd620888eb0737d = 1;
    }
    
    weapon_utility::saveweaponstates();
    weaponcontext = {};
    weaponcontext.lastweaponobj = self getcurrentweapon();
    weaponcontext.weapstructs = [];
    meleeoverrideweapon = self getweaponmeleeslot();
    weaplist = self getweaponslistprimaries();
    
    foreach ( weap in weaplist )
    {
        if ( weap.isalternate )
        {
            continue;
        }
        
        weapstruct = {};
        weapstruct.weaponobj = weap;
        weapstruct.clipammo = self getweaponammoclip( weap );
        weapstruct.stockammo = self getweaponammostock( weap );
        weapstruct.var_31b84291bf81176d = self function_8eb1b5d840aac85d( weap );
        weapstruct.ismeleeoverrideweapon = !isnullweapon( meleeoverrideweapon ) && weap == meleeoverrideweapon;
        weapstruct.var_6828becb300b1c44 = structcopy( item_weapon::function_92b8514cdacab7f9( weap ), 1 );
        altweapon = weap getaltweapon();
        
        if ( !isnullweapon( altweapon ) )
        {
            weapstruct.altclipammo = self getweaponammoclip( altweapon );
            weapstruct.altstockammo = self getweaponammostock( altweapon );
        }
        
        weaponcontext.weapstructs[ weaponcontext.weapstructs.size ] = weapstruct;
    }
    
    if ( weaponcontext.lastweaponobj.isalternate )
    {
        weaponcontext.lastweaponobj = weaponcontext.lastweaponobj getnoaltweapon();
    }
    
    self.var_7fe167ac52a87d1f = weaponcontext;
    currentweaponobj = self getcurrentweapon();
    
    if ( currentweaponobj.isalternate )
    {
        currentweaponobj = currentweaponobj getnoaltweapon();
    }
    
    cacweapons = [];
    var_61ab6f371a1722fd = self.primaryweapons;
    
    foreach ( weaponobj in var_61ab6f371a1722fd )
    {
        if ( weaponobj.isalternate )
        {
            continue;
        }
        
        if ( isdefined( self.var_cc1262e66dbb1c79 ) && issameweapon( weaponobj, self.var_cc1262e66dbb1c79, 1 ) )
        {
            continue;
        }
        
        if ( weapon::iscacprimaryorsecondary( weaponobj ) && !weapon::function_707f7162a89aa0e0( weaponobj ) && !weapon::isbackuppistol( weaponobj ) )
        {
            cacweapons[ cacweapons.size ] = weaponobj;
        }
    }
    
    primaryweaponobj = undefined;
    
    if ( isdefined( self.lastcacweaponobj ) && self hasweapon( self.lastcacweaponobj ) && ( !isdefined( self.var_cc1262e66dbb1c79 ) || self.lastcacweaponobj != self.var_cc1262e66dbb1c79 ) )
    {
        primaryweaponobj = self.lastcacweaponobj;
    }
    else if ( weapon::iscacprimaryorsecondary( currentweaponobj ) && ( !isdefined( self.var_cc1262e66dbb1c79 ) || currentweaponobj != self.var_cc1262e66dbb1c79 ) )
    {
        primaryweaponobj = currentweaponobj;
    }
    else if ( cacweapons.size > 0 )
    {
        primaryweaponobj = cacweapons[ 0 ];
    }
    
    if ( isundefinedweapon( primaryweaponobj ) )
    {
        primaryweaponobj = level.defaultfist;
    }
    
    class::respawnitems_saveweapon( primaryweaponobj, "primary", respawnitems );
    secondaryweaponobj = undefined;
    
    foreach ( weaponobj in cacweapons )
    {
        if ( !issameweapon( weaponobj, primaryweaponobj, 1 ) )
        {
            secondaryweaponobj = weaponobj;
            break;
        }
    }
    
    if ( isdefined( secondaryweaponobj ) )
    {
        class::respawnitems_saveweapon( secondaryweaponobj, "secondary", respawnitems );
    }
}

// Namespace zm_remote_robot
// Params 0, eflags: 0x4
// Checksum 0x27a50fe5, Offset: 0xe67
// Size: 0x22
function private function_60d90625d8d66bc2()
{
    if ( self.var_4cd620888eb0737d )
    {
        self.a_saved_weapons = undefined;
        self.var_4cd620888eb0737d = undefined;
    }
}

// Namespace zm_remote_robot
// Params 0, eflags: 0x4
// Checksum 0xba3abd3a, Offset: 0xe91
// Size: 0x240
function private function_95c3dc971c26c56b()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"juggernaut_removed" );
    waitframe();
    
    if ( !isalive( self ) || self.inlaststand || !isdefined( self.var_7fe167ac52a87d1f ) )
    {
        self.var_7fe167ac52a87d1f = undefined;
        function_60d90625d8d66bc2();
        return;
    }
    
    weaponcontext = self.var_7fe167ac52a87d1f;
    
    foreach ( weapstruct in weaponcontext.weapstructs )
    {
        hasweapon = self hasweapon( weapstruct.weaponobj );
        
        if ( !hasweapon )
        {
            inventory_utility::_giveweapon( weapstruct.weaponobj, undefined, undefined, 1, weapstruct.var_31b84291bf81176d );
        }
        
        self setweaponammoclip( weapstruct.weaponobj, weapstruct.clipammo );
        self setweaponammostock( weapstruct.weaponobj, weapstruct.stockammo );
        altweapon = weapstruct.weaponobj getaltweapon();
        
        if ( !isnullweapon( altweapon ) )
        {
            self setweaponammoclip( altweapon, weapstruct.altclipammo );
            self setweaponammostock( altweapon, weapstruct.altstockammo );
        }
        
        if ( weapstruct.ismeleeoverrideweapon )
        {
            self assignweaponmeleeslot( weapstruct.weaponobj );
        }
        
        weapon::fixupplayerweapons( self, weapstruct.weaponobj );
        function_e48e2a16bc05706d( weapstruct );
    }
    
    if ( isdefined( weaponcontext.lastweaponobj ) && self hasweapon( weaponcontext.lastweaponobj ) )
    {
        lastweaponobj = weapon_utility::restoreweaponstates( weaponcontext.lastweaponobj );
        inventory_utility::_switchtoweaponimmediate( lastweaponobj );
    }
    
    item_weapon::function_f9f12ddfa1766b72();
    self.var_7fe167ac52a87d1f = undefined;
    function_60d90625d8d66bc2();
}

// Namespace zm_remote_robot
// Params 1
// Checksum 0xd723653b, Offset: 0x10d9
// Size: 0x259
function function_e10e96465b49057b( streakinfo )
{
    val::set( "remote_robot_ignore_me", "ignoreme", 1 );
    self.var_a84311e2c57646de = &function_8f9f9a1061809b7a;
    self.takedamage = 0;
    thread function_f766f124a7d80ab8();
    
    if ( self.var_adc43141e2117c18 || self.var_e6e285922d86ab7f )
    {
        val::reset_all( "remote_robot_ignore_me" );
        return self [[ level.var_d91f744c9d0dc394 ]]( streakinfo );
    }
    
    start_pos = self.origin + ( 0, 0, 10 );
    end_pos = start_pos + ( 0, 0, 800 );
    trace_pos = physicstrace( start_pos, end_pos );
    
    if ( distancesquared( trace_pos, end_pos ) > 1 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_2e0b77a71f30bcc" );
        }
        
        val::reset_all( "remote_robot_ignore_me" );
        self.var_a84311e2c57646de = undefined;
        self.takedamage = 1;
        return 0;
    }
    
    if ( isdefined( level.var_2794781b61e20ff4 ) )
    {
        foreach ( trigger in level.var_2794781b61e20ff4 )
        {
            if ( self istouching( trigger ) )
            {
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
                }
                
                val::reset_all( "remote_robot_ignore_me" );
                self.var_a84311e2c57646de = undefined;
                self.takedamage = 1;
                return 0;
            }
        }
    }
    
    result = self [[ level.var_d91f744c9d0dc394 ]]( streakinfo );
    val::reset_all( "remote_robot_ignore_me" );
    
    if ( !result )
    {
        self.var_a84311e2c57646de = undefined;
        self.takedamage = 1;
    }
    
    return result;
}

// Namespace zm_remote_robot
// Params 0, eflags: 0x4
// Checksum 0x7efc71d, Offset: 0x133b
// Size: 0x33
function private function_f766f124a7d80ab8()
{
    self endon( #"remote_robot_intro_ended" );
    self endon( #"remote_robot_ended" );
    self waittill( #"death_or_disconnect" );
    self notify( #"remote_robot_ended" );
}

// Namespace zm_remote_robot
// Params 0, eflags: 0x4
// Checksum 0x69811ab2, Offset: 0x1376
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weaponname = utility::get_scripted_weapon_name( #"remote_robot" );
        
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace zm_remote_robot
// Params 4, eflags: 0x4
// Checksum 0x805f22d8, Offset: 0x13ea
// Size: 0x9f
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "remote_robot", sweapon );
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "remote_robot", victim );
    }
}

// Namespace zm_remote_robot
// Params 1
// Checksum 0xaed8bb6d, Offset: 0x1491
// Size: 0x1ba
function function_81c65067d1e846e3( str_perk )
{
    self endon( #"death_or_disconnect" );
    
    if ( !str_perk )
    {
        return;
    }
    
    if ( !zombie_perks::has_perk( str_perk ) )
    {
        return;
    }
    
    var_554891e1d9670449 = undefined;
    
    for ( i = 0; i < self.perks_active.size ; i++ )
    {
        if ( self.perks_active[ i ] == str_perk )
        {
            var_554891e1d9670449 = i;
            break;
        }
    }
    
    if ( !isdefined( var_554891e1d9670449 ) )
    {
        return;
    }
    
    var_984ebb42c4a9a697 = isdefined( self.perma_perks ) && arraycontains( self.perma_perks, str_perk );
    zombie_perks::take_perk( str_perk, 1 );
    var_737a50c9a105dbd3 = isdefined( self.perma_perks ) && arraycontains( self.perma_perks, str_perk );
    var_7b297e17d8615058 = var_984ebb42c4a9a697 && !var_737a50c9a105dbd3;
    self waittill( #"remote_robot_ended" );
    zombie_perks::give_perk( str_perk, 0, 0, var_554891e1d9670449, var_7b297e17d8615058 );
    
    if ( var_554891e1d9670449 == 0 && self.perks_active[ 0 ] != str_perk )
    {
        a_fixed = [ str_perk ];
        
        foreach ( perk in self.perks_active )
        {
            if ( perk != str_perk )
            {
                a_fixed[ a_fixed.size ] = perk;
            }
        }
        
        self.perks_active = a_fixed;
        zombie_perks::function_c11ba4bb3d0a676b();
    }
}

