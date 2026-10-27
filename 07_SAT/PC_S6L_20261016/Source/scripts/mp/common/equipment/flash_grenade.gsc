// scripts\mp\common\equipment\flash_grenade.gsc  (hash_65b3f2452e7f22e0.gscc) (size: 19627 Bytes / 0x4cab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f71180 (150409600)
// size ...... 19627 (0x4cab)
// includes .. 31  (offset: 0x4863)
// strings ... 42  (offset: 0x495b)
// dev strs .. 13  (offset: 0x4c0b)
// exports ... 33  (offset: 0x3163)
// cseg ...... 0x316 + 0x2e4d (0x3163)
// imports ... 149 (offset: 0x368b)
// animtree1 . 0   (offset: 0x4cab)
// animtree2 . 0   (offset: 0x4cab)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\talking_gun;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace flash_grenade;

// Namespace flash_grenade
// Params 0, eflags: 0x1
// Checksum 0x9bfd76aa, Offset: 0x334
// Size: 0x116
function autoexec flash_init()
{
    level.var_86159946e3f74c9d = getdvarint( @"hash_5f16c29c0fdf23fa", 0 );
    
    if ( level.var_86159946e3f74c9d )
    {
        level._effect[ "flash_grenade_lens_flare" ] = loadfx( "vfx_sat_explo_hitech_lf_sml_ch_02" );
    }
    
    utility::flag_wait( "equipment_initialized" );
    perkfunctions::function_deeb2f40153920c7( "flash_grenade" );
    callback::add( #"player_laststand", &onplayerlaststand );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    callback::add( #"hash_2efd4eae7229b871", &onagentdeath );
    equipment_mp::registercallback( "equip_flash", "onFired", &onfired );
    equipment_mp::registercallback( "equip_flash", "onPlayerDamaged", &onplayerdamaged );
    weapons::function_2cd25260a11d5e40( "flash_grenade", &flashbang_pullback );
    weapons::registerusedcallback( "flash_grenade", &flashbang_used );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #equipref:"equip_flash" } );
}

// Namespace flash_grenade
// Params 3
// Checksum 0xa615ebe0, Offset: 0x452
// Size: 0x44
function onfired( equipmentref, slot, objweapon )
{
    challenges::function_3d7a169dbae062fb( "equip_flash", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace flash_grenade
// Params 1
// Checksum 0x2e5443db, Offset: 0x49e
// Size: 0x96
function flashbang_pullback( params )
{
    bundle = level.equipment.table[ "equip_flash" ].bundle;
    
    if ( bundle.var_e36b84555e7df1d3 && params.weaponobject hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        self setclientomnvar( "ui_show_9bang_submunition_count", 1 );
        self setclientomnvar( "ui_9bang_submunition_count", 0 );
        self.var_184e248a3e43ab53 = gettime();
        thread function_41a49d2491798d11( bundle );
    }
}

// Namespace flash_grenade
// Params 1
// Checksum 0xd2bd30b, Offset: 0x53c
// Size: 0xa6
function function_41a49d2491798d11( bundle )
{
    self endon( #"disconnect", #"hash_784fc581fc2d26ef" );
    childthread function_d18d2dc3cad02b68();
    submunitiondata = bundle.var_b7044fb08a562952 ?? [];
    timepassed = 0;
    
    for ( i = 0; i < submunitiondata.size ; i++ )
    {
        threshold = submunitiondata[ i ].var_4b29cf9954060056;
        var_b18172b327a1026b = threshold - timepassed;
        wait var_b18172b327a1026b;
        timepassed += var_b18172b327a1026b;
        self setclientomnvar( "ui_9bang_submunition_count", i + 1 );
    }
}

// Namespace flash_grenade
// Params 0
// Checksum 0xbc673680, Offset: 0x5ea
// Size: 0x33
function function_d18d2dc3cad02b68()
{
    self waittill( #"death" );
    self setclientomnvar( "ui_show_9bang_submunition_count", 0 );
    self setclientomnvar( "ui_9bang_submunition_count", 0 );
    self notify( #"hash_784fc581fc2d26ef" );
}

// Namespace flash_grenade
// Params 1
// Checksum 0xce291e06, Offset: 0x625
// Size: 0x1e3
function flashbang_used( grenade )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    tableinfo = weapon::getequipmenttableinfo( ref );
    bundle = tableinfo.bundle;
    
    if ( !isdefined( level.equipment.table[ "equip_flash" ].effect_duration ) )
    {
        level.equipment.table[ "equip_flash" ].effect_duration = bundle.flash_max_duration;
    }
    
    var_75efa27f660c7c41 = 0;
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        var_75efa27f660c7c41 = 1;
        grenade.scoreeventlist = [];
    }
    
    grenade.var_8cd831a3c0cc9bdc = level status_tracking::function_25399da4af77eea1();
    thread function_2bc9701b04d59fe9( grenade );
    
    if ( !isweapondetonationtimed( grenade.weapon_object ) )
    {
        fusetime = bundle.var_32ebde154664fc8a ?? ( isai( self ) ? getgrenadefusetimeai( grenade.weapon_object ) : getgrenadefusetime( grenade.weapon_object ) ) * 0.001;
        
        if ( var_75efa27f660c7c41 )
        {
            self notify( #"hash_784fc581fc2d26ef" );
            self setclientomnvar( "ui_show_9bang_submunition_count", 0 );
            self setclientomnvar( "ui_9bang_submunition_count", 0 );
            var_6caa82991ff0294b = ( gettime() - ( self.var_184e248a3e43ab53 ?? gettime() ) ) * 0.001;
            thread function_c9301db57d0755dc( grenade, bundle, var_6caa82991ff0294b, fusetime );
        }
        else
        {
            grenade thread _flash_detonate( fusetime );
        }
        
        return;
    }
    
    assert( !var_75efa27f660c7c41, "<dev string:x24>" );
}

// Namespace flash_grenade
// Params 1, eflags: 0x4
// Checksum 0xe77e3fb3, Offset: 0x810
// Size: 0x273
function private function_2bc9701b04d59fe9( grenade )
{
    grenade thread script::notifyafterframeend( "death", "end_explode" );
    grenade endon( #"end_explode" );
    grenade waittill( #"explode", position );
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    
    if ( !ref )
    {
        assertmsg( "<dev string:xa0>" + grenade.weapon_name );
        return;
    }
    
    tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !tableinfo )
    {
        assertmsg( "<dev string:xca>" + grenade.weapon_name );
        return;
    }
    
    bundle = tableinfo.bundle;
    
    if ( !bundle )
    {
        assertmsg( "<dev string:xfa>" + grenade.weapon_name );
        return;
    }
    
    if ( level.var_86159946e3f74c9d )
    {
        function_d992c9601696aa5b( grenade, bundle );
    }
    
    playerentnum = self getentitynumber();
    var_db605d207d2d18ba = bundle.var_94bb4a347dba49de ?? 0;
    entities = getentarrayinradius( undefined, undefined, position, 540 );
    
    foreach ( entity in entities )
    {
        if ( !isagent( entity ) )
        {
            continue;
        }
        
        if ( !entity.unittype )
        {
            continue;
        }
        
        if ( entity.unittype == "zombie" && !var_db605d207d2d18ba )
        {
            continue;
        }
        
        entity notify( #"flashbang", entity.origin, 1, 1, self, "axis" );
        
        if ( entity.unittype == "zombie" )
        {
            entity utility::callsharedfunc( #"zombie", #"stunZombie", 5, "stunned_on" );
        }
        
        entity function_b0605b6ede8d64c5( self, grenade, grenade.weapon_object, 5 );
        entity callback::callback( "on_ai_stunned", { #duration:5 } );
    }
}

// Namespace flash_grenade
// Params 4, eflags: 0x4
// Checksum 0xd17bd06b, Offset: 0xa8b
// Size: 0x154
function private function_c9301db57d0755dc( grenade, bundle, var_6caa82991ff0294b, var_8ca2dc3570ead67f )
{
    grenade endon( #"explode" );
    self endon( #"disconnect" );
    submunitiondata = bundle.var_b7044fb08a562952 ?? [];
    submunitionasset = bundle.var_ff7188380a06d4f8;
    assert( submunitionasset, "<dev string:x127>" );
    prevthreshold = -1;
    
    for ( i = 0; i < submunitiondata.size ; i++ )
    {
        threshold = submunitiondata[ i ].var_4b29cf9954060056;
        
        if ( threshold > prevthreshold )
        {
            if ( var_6caa82991ff0294b < threshold )
            {
                break;
            }
            
            interval = submunitiondata[ i ].pro_fireinterval ?? 0;
            
            if ( interval > 0 )
            {
                wait interval;
            }
            
            thread function_4172c12e34a8789f( grenade, 0.01, ( 0, 0, 0 ), submunitionasset );
            prevthreshold = threshold;
            continue;
        }
        
        assertmsg( "<dev string:x150>" );
    }
    
    if ( prevthreshold == -1 )
    {
        interval = var_8ca2dc3570ead67f;
    }
    else
    {
        interval = bundle.var_cdd0b2ae1f1d23e6 ?? 0;
    }
    
    grenade thread _flash_detonate( interval );
}

// Namespace flash_grenade
// Params 4, eflags: 0x4
// Checksum 0xb312abba, Offset: 0xbe7
// Size: 0x18f
function private function_4172c12e34a8789f( grenade, fusetime, launchvelocity, submunitionasset )
{
    grenade endon( #"explode" );
    self endon( #"disconnect" );
    
    if ( grenade.origin )
    {
        submunitiongrenade = magicgrenademanual( submunitionasset, grenade.origin, launchvelocity, fusetime, self );
        
        if ( submunitiongrenade )
        {
            if ( !isdefined( level.equipment.table[ "equip_flash" ].damageweaponnames ) )
            {
                level.equipment.table[ "equip_flash" ].damageweaponnames = [];
            }
            
            if ( !arraycontains( level.equipment.table[ "equip_flash" ].damageweaponnames, submunitionasset ) )
            {
                level.equipment.table[ "equip_flash" ].damageweaponnames[ level.equipment.table[ "equip_flash" ].damageweaponnames.size ] = submunitionasset;
            }
            
            submunitiongrenade.owner = self;
            submunitiongrenade setentityowner( self );
            submunitiongrenade setotherent( self );
            submunitiongrenade setmagicgrenadecollision( 0 );
            submunitiongrenade.parentgrenade = grenade;
            submunitiongrenade.var_8cd831a3c0cc9bdc = grenade.var_8cd831a3c0cc9bdc;
            submunitiongrenade.issubmunition = 1;
        }
    }
}

// Namespace flash_grenade
// Params 1, eflags: 0xc
// Checksum 0xa912bfa0, Offset: 0xd7e
// Size: 0x3d
function private _flash_detonate( fusetime )
{
    self notify( #"hash_b096942e5824fadb" );
    self endon( #"hash_b096942e5824fadb" );
    self endon( #"explode" );
    wait fusetime;
    
    if ( self )
    {
        self detonate();
    }
}

// Namespace flash_grenade
// Params 1, eflags: 0x4
// Checksum 0x85e482ca, Offset: 0xdc3
// Size: 0x8b
function private onagentdeath( data )
{
    attacker = data.eattacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = data.victim;
    
    if ( !function_d86e599fbb909ed8( attacker, victim ) )
    {
        return;
    }
    
    killcountresults = function_d028d2021c33ea2( attacker, victim );
    
    if ( !killcountresults.var_f9c0775995d43d45 )
    {
        return;
    }
    
    attacker.var_237757064cda082f = 1;
    victim function_ab418c9194cd061a();
}

// Namespace flash_grenade
// Params 1
// Checksum 0xfea6f92c, Offset: 0xe56
// Size: 0xd33
function onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return 1;
    }
    
    isfullflash = 1;
    
    if ( data.inflictor.parentgrenade )
    {
        weaponname = data.inflictor.parentgrenade.weapon_name;
    }
    else
    {
        weaponname = data.inflictor.weapon_name;
    }
    
    data.bundle = equipment_mp::getEquipmentBundleFromWeaponName( weaponname );
    
    if ( !isdefined( data.bundle ) )
    {
        weaponname = getcompleteweaponname( data.objweapon );
        data.bundle = equipment_mp::getEquipmentBundleFromWeaponName( weaponname );
    }
    
    weight = 0;
    distsqr = undefined;
    dist = undefined;
    hasresist = 0;
    var_7d42b84cfb3267ed = undefined;
    
    /#
        if ( getdvarint( @"hash_6c7fd12a611ca1e8" ) == 1 )
        {
            var_7d42b84cfb3267ed = 1;
        }
        
        if ( getdvarint( @"scr_flash_ignore", 0 ) )
        {
            return;
        }
    #/
    
    if ( isdefined( data.var_7d42b84cfb3267ed ) )
    {
        var_7d42b84cfb3267ed = data.var_7d42b84cfb3267ed;
    }
    
    if ( data.attacker == data.victim && !var_7d42b84cfb3267ed )
    {
        distsqr = distancesquared( data.victim.origin, data.point );
        
        if ( distsqr > 65536 )
        {
            return 0;
        }
        else if ( distsqr <= 0 )
        {
            dist = 0;
        }
        else
        {
            dist = sqrt( distsqr );
        }
    }
    else
    {
        dist = distance( data.victim.origin, data.point );
    }
    
    if ( !val::get( "flashed" ) )
    {
        return;
    }
    
    if ( isdefined( data.victim.perks[ "specialty_stun_resistance" ] ) && ( data.attacker != data.victim || getdvarint( @"hash_e5a558aeef05491e", 1 ) ) )
    {
        data.attacker damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
        
        if ( isdefined( data.victim.perks[ "specialty_tac_mask" ] ) )
        {
            if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
            {
                data.victim perks::function_142df1226093bce0( "specialty_tac_mask" );
            }
            else
            {
                data.victim perks::activateperk( "specialty_tac_mask" );
            }
        }
        else if ( isdefined( data.victim.perks[ "specialty_veteran" ] ) )
        {
            data.victim perks::activateperk( "specialty_veteran" );
        }
        else
        {
            data.victim perks::activateperk( "specialty_tac_resist" );
        }
        
        hasresist = 1;
    }
    
    dist = clamp( dist, 0, 540 );
    distratio = 1 - ( dist - 0 ) / 540;
    
    if ( distratio > 0.5 )
    {
        if ( !isdefined( data.inflictor.challengedata ) )
        {
            data.inflictor.challengedata = {};
        }
        
        if ( !isdefined( data.inflictor.challengedata.bitmodifiers ) )
        {
            data.inflictor.challengedata.bitmodifiers = [];
        }
        
        data.inflictor.challengedata.bitmodifiers = arraycombineunique( data.inflictor.challengedata.bitmodifiers, [ #"hash_c9c6764cf0e0431b" ] );
    }
    
    weight += floor( distratio * 65 );
    
    if ( utility::within_fov( data.victim.origin, data.victim getplayerangles(), data.point, 0.5 ) )
    {
        weight += 35;
    }
    else
    {
        if ( !isdefined( data.inflictor.challengedata ) )
        {
            data.inflictor.challengedata = {};
        }
        
        if ( !isdefined( data.inflictor.challengedata.bitmodifiers ) )
        {
            data.inflictor.challengedata.bitmodifiers = [];
        }
        
        data.inflictor.challengedata.bitmodifiers = arraycombineunique( data.inflictor.challengedata.bitmodifiers, [ #"hash_f4d42e0bb114a0d3" ] );
    }
    
    if ( !player_utility::playersareenemies( data.attacker, data.victim ) )
    {
        if ( !var_7d42b84cfb3267ed )
        {
            if ( data.attacker == data.victim )
            {
                weight += -30;
            }
            else
            {
                weight += -30;
            }
        }
    }
    
    weight = max( 0, weight );
    weightratio = weight / 100;
    minduration = data.bundle.flash_min_duration ?? 2.25;
    maxduration = data.bundle.flash_max_duration ?? 3.75;
    
    if ( hasresist )
    {
        minduration = data.bundle.var_a6f684742e639681 ?? 1.5;
        maxduration = data.bundle.var_2cb0e0e2903d19af ?? 3;
    }
    
    duration = minduration + ( maxduration - minduration ) * weightratio;
    durationindex = 0;
    
    if ( data.bundle.var_58ae2baafddbc760 )
    {
        durationindex = 0;
        durationarray = [];
        durationarray[ 0 ] = data.bundle.var_85102f9307479a7f ?? 4;
        durationarray[ 1 ] = data.bundle.var_a96c443a8f80f88c ?? 2.35;
        durationarray[ 2 ] = data.bundle.var_1573b89fd25be06d ?? 0.45;
        
        if ( data.bundle.var_c7709714d768097c && data.objweapon hasattachmenthash( data.bundle.var_c7709714d768097c ) )
        {
            durationarray[ 0 ] = data.bundle.var_2c371ae0d5613123 ?? 4;
            durationarray[ 1 ] = data.bundle.var_5f1b7ad5cfc864b0 ?? 2.35;
            durationarray[ 2 ] = data.bundle.var_59b0ed3b8177441 ?? 0.45;
        }
        
        var_48d3ebcd23adf8a0 = [];
        var_48d3ebcd23adf8a0[ 0 ] = data.bundle.var_6fe27f2a865ebbf6 ?? 3;
        var_48d3ebcd23adf8a0[ 1 ] = data.bundle.var_9d313744713d1e6f ?? 1.75;
        var_48d3ebcd23adf8a0[ 2 ] = data.bundle.var_8f80e8066125b08 ?? 0.3;
        victimeyepos = data.victim geteye();
        
        if ( distancesquared( victimeyepos, data.point ) < squared( data.bundle.var_2fb9149b4e8903df ?? 75 ) )
        {
            durationindex = 0;
        }
        else
        {
            var_f1476e0b3e1aaad6 = vectornormalize( data.point - victimeyepos );
            forward = anglestoforward( data.victim getplayerangles() );
            dot = vectordot( forward, var_f1476e0b3e1aaad6 );
            
            if ( dot >= 0.5 )
            {
                durationindex = 0;
            }
            else if ( dot >= -0.259 )
            {
                durationindex = 1;
            }
            else
            {
                durationindex = 2;
            }
        }
        
        if ( hasresist )
        {
            duration = var_48d3ebcd23adf8a0[ durationindex ];
        }
        else
        {
            duration = durationarray[ durationindex ];
        }
        
        if ( duration < data.bundle.var_2f57faaf7099f502 && !data.bundle.var_6484c3f5f68e069a )
        {
            if ( data.attacker != self )
            {
                data.attacker damagefeedback::updatedamagefeedback( "hitpartialflash", undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
            }
        }
    }
    
    if ( data.objweapon.basename == data.bundle.var_ff7188380a06d4f8 )
    {
        duration = data.bundle.var_b626ca8cbe673204 ? duration * data.bundle.var_b626ca8cbe673204 : duration;
    }
    
    /#
        dvarstr = getdvar( @"hash_d206f268f04a78a3", "<dev string:x1d6>" );
        
        if ( dvarstr != "<dev string:x1d6>" )
        {
            if ( dvarstr == "<dev string:x1d7>" )
            {
                duration = 1.5;
            }
            else if ( dvarstr == "<dev string:x1de>" )
            {
                duration = minduration;
            }
            else if ( dvarstr == "<dev string:x1e2>" )
            {
                duration = maxduration;
            }
            else
            {
                duration = script::stringtofloat( dvarstr );
                duration = clamp( duration, minduration, maxduration );
            }
        }
    #/
    
    isfullflash = hasresist ? 0 : durationindex == 0;
    data.victim thread applyflash( data.attacker, data.objweapon, duration, data.bundle, data.inflictor );
    thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #ent:data.inflictor, #equipref:"equip_flash", #victim:data.victim, #owner:data.attacker } );
    
    if ( isdefined( data.bundle.var_628ac26a5ade40e2 ) && isdefined( data.inflictor ) && player_utility::playersareenemies( data.attacker, data.victim ) && duration >= data.bundle.var_2f57faaf7099f502 )
    {
        if ( !isdefined( data.inflictor.var_b265b700044e625d ) )
        {
            data.inflictor.var_b265b700044e625d = 0;
        }
        
        data.inflictor.var_b265b700044e625d += 1;
        
        if ( data.inflictor.var_b265b700044e625d == data.bundle.var_628ac26a5ade40e2 && data.inflictor function_d7eedb47b819681( self ) )
        {
            data.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"multi_flashbang" );
        }
    }
    
    if ( isplayer( data.attacker ) )
    {
        data.attacker damage::combatrecordtacticalstat( "equip_flash" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( data.attacker ) ) )
        {
            if ( isdefined( data.attacker.leaderboarddata[ "flashbangHits" ] ) )
            {
                data.attacker.leaderboarddata[ "flashbangHits" ] = data.attacker.leaderboarddata[ "flashbangHits" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "flashbangHits" ] ) )
            {
                [[ level.leaderboardfunc[ "flashbangHits" ] ]]( data.attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1e6>" );
            
            if ( isdefined( data.attacker.pers[ "flashbangHits" ] ) )
            {
                data.attacker.pers[ "flashbangHits" ] = data.attacker.pers[ "flashbangHits" ] + 1;
            }
        }
    }
    
    return isfullflash;
}

// Namespace flash_grenade
// Params 5
// Checksum 0x4027577d, Offset: 0x1b92
// Size: 0x2ed
function applyflash( attacker, objweapon, duration, bundle, inflictor )
{
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        return;
    }
    
    if ( isdefined( self ) && isplayer( attacker ) && player_utility::isenemy( attacker ) && inflictor function_d7eedb47b819681( self ) )
    {
        function_eae4f92796e70994( attacker, objweapon, duration, bundle );
    }
    
    talking_gun::talkinggun_event( self, #"player_blinded" );
    talking_gun::talkinggun_event( attacker, #"enemy_blinded" );
    
    if ( game_utility::getgametype() == "arena" || isbrgamemode() && attacker br_public::isplayeringulag() )
    {
        duration = min( level.tacticaltimemod <= 3 ? level.tacticaltimemod + 1.5 : level.tacticaltimemod, duration );
    }
    
    function_ef7d7de37177d2f9( duration, bundle );
    
    if ( !self usingtouch() && !self.flashbanged )
    {
        utility::hidehudenable();
    }
    
    var_63397360de5d138a = max( duration, bundle.var_2191ae2086d45be4 ?? 4 );
    function_b0605b6ede8d64c5( attacker, inflictor, objweapon, duration, var_63397360de5d138a );
    
    if ( level.equipment.var_aeff9a3b25965912 )
    {
        callback::callback( #"hash_5bfa36b3dc1a524b", { #duration:duration, #ref:"flashed", #attacker:attacker, #victim:self, #equipment:"equip_flash" } );
    }
    
    if ( isdefined( bundle.var_f241fd2bd782d988 ) )
    {
        var_aeec9f8a3b02c8f4 = bundle.var_f241fd2bd782d988;
        interruptdelayms = bundle.var_f12ecc51f97d8590 * 1000;
        shellshock_utility_cpmp::_shellshock( var_aeec9f8a3b02c8f4, #"flash", duration, 1, interruptdelayms );
    }
    else
    {
        shellshock_utility_cpmp::_shellshock( %"flash_grenade_mp", #"flash", duration, 1 );
    }
    
    player::codcastersetplayerstatuseffect( "flash", duration );
    
    if ( player_utility::playersareenemies( self, attacker ) )
    {
        challenges::function_3d7a169dbae062fb( "equip_flash", attacker, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
        thread gamescore::trackdebuffassistfortime( attacker, self, "flash_grenade_mp", var_63397360de5d138a );
    }
    
    thread function_c9bd8e0a8c61894a( duration, !player::isreallyalive( self ) );
    challengeparams = { #effectref:"flashed", #duration:duration, #equipmentref:"equip_flash", #equipmentent:inflictor, #victim:self, #attacker:attacker };
    callback::callback( #"hash_10e686549630fd9f", challengeparams );
}

// Namespace flash_grenade
// Params 5, eflags: 0x4
// Checksum 0xd558157e, Offset: 0x1e87
// Size: 0x1c5
function private function_b0605b6ede8d64c5( attacker, inflictor, objweapon, duration, var_63397360de5d138a = undefined )
{
    if ( inflictor.birthtime )
    {
        flashgrenadeuid = inflictor.birthtime << 11 | attacker getentitynumber();
    }
    else
    {
        flashgrenadeuid = attacker getentitynumber();
    }
    
    if ( !isdefined( var_63397360de5d138a ) )
    {
        var_63397360de5d138a = duration;
    }
    
    level utility::function_a9cdce367aa4fef5( "flash_effect_timer_" + flashgrenadeuid, var_63397360de5d138a, undefined, &function_3e8e05566e0509be, flashgrenadeuid );
    
    if ( !isdefined( self.var_158417bd657ad71e ) )
    {
        self.var_158417bd657ad71e = objweapon;
    }
    
    self.flashbanged = 1;
    self.var_54dfc5a46377bb64 = 0;
    
    if ( !isdefined( level.var_d3d9e69fa6deb9fb[ flashgrenadeuid ] ) )
    {
        level.var_d3d9e69fa6deb9fb[ flashgrenadeuid ] = { #kills:0, #victims:[], #thrower:attacker };
    }
    
    level.var_d3d9e69fa6deb9fb[ flashgrenadeuid ].victims[ level.var_d3d9e69fa6deb9fb[ flashgrenadeuid ].victims.size ] = self;
    
    if ( !isdefined( self.var_66eaa5c0a481e7e8 ) )
    {
        self.var_66eaa5c0a481e7e8 = [];
    }
    
    self.var_66eaa5c0a481e7e8[ self.var_66eaa5c0a481e7e8.size ] = flashgrenadeuid;
    
    if ( !isagent( self ) )
    {
        statusguid = status_tracking::applystatus( self, attacker, inflictor.var_8cd831a3c0cc9bdc ?? 1, #"flash" );
        thread status_tracking::function_97d762c26d26677b( self, attacker, inflictor.var_8cd831a3c0cc9bdc ?? 1, statusguid, duration );
    }
    
    if ( !player_utility::playersareenemies( self, attacker ) )
    {
        return;
    }
    
    self.var_54dfc5a46377bb64 = 1;
}

// Namespace flash_grenade
// Params 0, eflags: 0x4
// Checksum 0xd75e61f0, Offset: 0x2054
// Size: 0xcc
function private function_ab418c9194cd061a()
{
    foreach ( flashgrenadeid in self.var_66eaa5c0a481e7e8 )
    {
        level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].victims = arrayremove( level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].victims, self );
    }
    
    self.var_66eaa5c0a481e7e8 = undefined;
    self.flashbanged = undefined;
    self.var_54dfc5a46377bb64 = undefined;
    self.var_158417bd657ad71e = undefined;
}

// Namespace flash_grenade
// Params 2
// Checksum 0x5c5257d1, Offset: 0x2128
// Size: 0x54
function function_ef7d7de37177d2f9( duration, bundle )
{
    if ( !bundle.var_eda1d3f5885223e2 )
    {
        return;
    }
    
    if ( function_4042d2fbe6237835( #"hash_baa362e6f84da9f7" ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_b302208cf5feb028", 1 ) )
    {
        return;
    }
    
    thread function_ebc2cbcc4b7c9cdf( duration, bundle );
}

// Namespace flash_grenade
// Params 2
// Checksum 0x98e2f26b, Offset: 0x2184
// Size: 0x14f
function function_ebc2cbcc4b7c9cdf( duration, bundle )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    minduration = bundle.flash_min_duration ?? 2.25;
    maxduration = bundle.flash_max_duration ?? 3.75;
    longthreshold = maxduration * 0.85;
    minthreshold = minduration * 0.85;
    durationdiff = maxduration - duration;
    screenbuffer = max( getdvarfloat( @"hash_47c31e3b89161127", 0.75 ) - durationdiff, 0 );
    durationstate = undefined;
    
    if ( duration >= longthreshold )
    {
        durationstate = "long";
    }
    else if ( duration >= minthreshold )
    {
        durationstate = "medium";
    }
    else
    {
        durationstate = "short";
    }
    
    endtime = duration;
    earlyendtime = duration - screenbuffer;
    
    while ( endtime > earlyendtime )
    {
        endtime -= level.framedurationseconds;
        waitframe();
    }
    
    self setscriptablepartstate( "flashVfx", durationstate, 0 );
    wait 0.05;
    self setscriptablepartstate( "flashVfx", "off", 0 );
}

// Namespace flash_grenade
// Params 3
// Checksum 0x58b185a8, Offset: 0x22db
// Size: 0x6e
function function_8fb1b174093323d3( attacker, victim, owner )
{
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return;
    }
    
    if ( attacker == owner )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    lootid = loot::getlootidfromref( "equip_flash" );
    owner thread points::function_f8a0deb1a12da52e( #"hash_29cb74768c4e59d", undefined, lootid );
}

// Namespace flash_grenade
// Params 2
// Checksum 0x85af2cbf, Offset: 0x2351
// Size: 0x91
function function_c9bd8e0a8c61894a( duration, fromdeath )
{
    if ( game_utility::getgametype() == "arena" )
    {
        var_5fef384b4f15e26f = max( 0, duration );
    }
    else
    {
        var_5fef384b4f15e26f = max( 0, duration - 0.5 );
    }
    
    utility::waittill_notify_or_timeout( "death", var_5fef384b4f15e26f );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !fromdeath )
    {
        if ( !self usingtouch() && isdefined( self.hidehudenabled ) && self.hidehudenabled > 0 )
        {
            utility::hidehuddisable();
        }
    }
}

// Namespace flash_grenade
// Params 3, eflags: 0x4
// Checksum 0x5214395d, Offset: 0x23ea
// Size: 0x141
function private function_60e54a0b2af49830( flashthrower, var_bbd2e83068da51ef, var_a088600d57756566 )
{
    profilestart();
    
    if ( var_a088600d57756566 || player_utility::function_51a0c300008ab56b( flashthrower, self ) || !self.flashbanged )
    {
        profilestop();
        return;
    }
    
    if ( self.attackers )
    {
        foreach ( attacker in self.attackers )
        {
            if ( isplayer( attacker ) )
            {
                function_8fb1b174093323d3( attacker, self, flashthrower );
            }
        }
    }
    
    stunweapon = self.var_158417bd657ad71e;
    
    if ( !isdefined( stunweapon ) )
    {
        profilestop();
        return;
    }
    
    assert( isdefined( stunweapon ), "<dev string:x20c>" );
    
    if ( self.lastkilledby == flashthrower )
    {
        flashthrower thread gamelogic_mp::threadedsetweaponstatbyname( stunweapon, 1, "debuff_kills" );
        flashthrower telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, flashthrower, var_bbd2e83068da51ef, stunweapon );
    }
    else
    {
        flashthrower thread gamelogic_mp::threadedsetweaponstatbyname( stunweapon, 1, "debuff_assists" );
    }
    
    profilestop();
}

// Namespace flash_grenade
// Params 1
// Checksum 0xf58b6cd3, Offset: 0x2533
// Size: 0x1d
function calculateinterruptdelay( duration )
{
    return max( 0, duration - 1.5 ) * 1000;
}

// Namespace flash_grenade
// Params 1
// Checksum 0xbe3af29d, Offset: 0x2559
// Size: 0xbd, Type: bool
function function_d7eedb47b819681( victim )
{
    grenade = self;
    victimentnum = victim getentitynumber();
    
    if ( self.issubmunition )
    {
        grenade = self.parentgrenade;
        
        if ( grenade.scoreeventlist && !grenade.scoreeventlist[ victimentnum ] )
        {
            if ( grenade )
            {
                grenade.scoreeventlist[ victimentnum ] = 1;
            }
            
            return true;
        }
    }
    else if ( grenade.scoreeventlist )
    {
        if ( !grenade.scoreeventlist[ victimentnum ] )
        {
            if ( grenade )
            {
                grenade.scoreeventlist[ victimentnum ] = 1;
            }
            
            return true;
        }
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace flash_grenade
// Params 4
// Checksum 0x216896e6, Offset: 0x261f
// Size: 0x8a
function function_eae4f92796e70994( attacker, objweapon, flashduration, bundle )
{
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    if ( bundle.var_58ae2baafddbc760 )
    {
        if ( flashduration >= bundle.var_2f57faaf7099f502 )
        {
            attacker namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "flashGrenadeHit", 0, { #objweapon:objweapon } );
        }
        else
        {
            return;
        }
        
        return;
    }
    
    attacker namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "flashGrenadeHit", 0, undefined );
}

// Namespace flash_grenade
// Params 1
// Checksum 0xb508859e, Offset: 0x26b1
// Size: 0xca
function onplayerlaststand( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !function_d86e599fbb909ed8( attacker, victim ) )
    {
        return;
    }
    
    function_a7e25c172287a9d5( victim, attacker );
    killcountresults = function_d028d2021c33ea2( attacker, victim );
    
    if ( !isdefined( data.callbackeventdata ) )
    {
        data.callbackeventdata = [];
    }
    
    data.callbackeventdata[ "flash_grenade_mp" ] = killcountresults;
    lootid = loot::getlootidfromref( "equip_flash" );
    attacker.var_237757064cda082f = 1;
    attacker thread points::function_f8a0deb1a12da52e( #"flash_finished", undefined, lootid );
}

// Namespace flash_grenade
// Params 1
// Checksum 0xd1494d14, Offset: 0x2783
// Size: 0x295
function onplayerdeath( data )
{
    attacker = data.attacker;
    victim = data.victim;
    lootid = loot::getlootidfromref( "equip_flash" );
    
    if ( victim.inlaststand )
    {
        killcountresults = victim.laststanddowneddata.callbackeventdata[ "flash_grenade_mp" ];
        
        if ( isdefined( killcountresults ) )
        {
            attacker = victim.laststanddowneddata.attacker;
            objweapon = victim.laststanddowneddata.objweapon;
            attacker events::function_1df78f8cb7d682d0( objweapon );
            
            if ( killcountresults.var_b7155b1ca0253bb )
            {
                attacker thread points::function_f8a0deb1a12da52e( #"double_flash", objweapon, lootid );
            }
            else if ( killcountresults.var_39782d32fd3fe230 )
            {
                attacker thread points::doscoreevent( #"triple_tactical_kill", objweapon );
            }
        }
    }
    else
    {
        if ( !function_d86e599fbb909ed8( attacker, victim ) )
        {
            return;
        }
        
        function_a7e25c172287a9d5( victim, attacker );
        killcountresults = function_d028d2021c33ea2( attacker, victim );
        
        if ( killcountresults.var_b7155b1ca0253bb )
        {
            attacker thread points::function_f8a0deb1a12da52e( #"double_flash", undefined, lootid );
        }
        else if ( killcountresults.var_39782d32fd3fe230 )
        {
            attacker thread points::doscoreevent( #"triple_tactical_kill" );
        }
        
        attacker events::function_1df78f8cb7d682d0( data.objweapon );
        attacker.var_237757064cda082f = 1;
        attacker thread points::function_f8a0deb1a12da52e( #"flash_finished", undefined, lootid );
    }
    
    if ( victim.var_66eaa5c0a481e7e8.size )
    {
        var_a088600d57756566 = player::isreallyalive( victim );
        var_60fc0fc6d4bbbb82 = [];
        
        foreach ( flashgrenadeid in victim.var_66eaa5c0a481e7e8 )
        {
            flashthrower = level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].thrower;
            
            if ( !arraycontains( var_60fc0fc6d4bbbb82, flashthrower ) )
            {
                victim function_60e54a0b2af49830( flashthrower, flashgrenadeid, var_a088600d57756566 );
                var_60fc0fc6d4bbbb82[ var_60fc0fc6d4bbbb82.size ] = flashthrower;
            }
        }
    }
    
    victim function_ab418c9194cd061a();
}

// Namespace flash_grenade
// Params 2, eflags: 0x4
// Checksum 0x9651b76, Offset: 0x2a20
// Size: 0x2f
function private function_d86e599fbb909ed8( attacker, victim )
{
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return 0;
    }
    
    return victim.var_54dfc5a46377bb64;
}

// Namespace flash_grenade
// Params 2, eflags: 0x4
// Checksum 0x5929067d, Offset: 0x2a58
// Size: 0x42
function private function_a7e25c172287a9d5( victim, attacker )
{
    if ( isdefined( victim.var_158417bd657ad71e ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( victim.var_158417bd657ad71e, 1, "killed_while_debuffed_by", undefined, attacker );
    }
}

// Namespace flash_grenade
// Params 2, eflags: 0x4
// Checksum 0x8dbfeefb, Offset: 0x2aa2
// Size: 0x145
function private function_d028d2021c33ea2( attacker, victim )
{
    killcountresults = {};
    
    foreach ( flashgrenadeid in victim.var_66eaa5c0a481e7e8 )
    {
        if ( level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].thrower == attacker )
        {
            level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].kills++;
        }
        
        if ( level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].kills == 2 )
        {
            killcountresults.var_b7155b1ca0253bb = 1;
        }
        else if ( level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].kills == 3 )
        {
            killcountresults.var_39782d32fd3fe230 = 1;
        }
        
        if ( !isdefined( killcountresults.var_f9c0775995d43d45 ) )
        {
            killcountresults.var_f9c0775995d43d45 = 0;
        }
        
        killcountresults.var_f9c0775995d43d45++;
    }
    
    return killcountresults;
}

// Namespace flash_grenade
// Params 1
// Checksum 0x28306f8a, Offset: 0x2bf0
// Size: 0xfa
function function_3e8e05566e0509be( flashgrenadeid )
{
    victims = level.var_d3d9e69fa6deb9fb[ flashgrenadeid ].victims;
    
    foreach ( victim in victims )
    {
        if ( !victim.var_66eaa5c0a481e7e8 || victim.var_66eaa5c0a481e7e8.size == 0 )
        {
            if ( player::isreallyalive( victim ) )
            {
                if ( !victim usingtouch() && victim.hidehudenabled > 0 )
                {
                    victim utility::hidehuddisable();
                }
            }
        }
        
        victim function_ab418c9194cd061a();
    }
    
    level.var_d3d9e69fa6deb9fb[ flashgrenadeid ] = undefined;
}

// Namespace flash_grenade
// Params 2, eflags: 0x4
// Checksum 0xe77c32e7, Offset: 0x2cf2
// Size: 0x287
function private function_d992c9601696aa5b( grenade, bundle )
{
    validplayers = [];
    
    foreach ( player in level.players )
    {
        if ( player && player player::isreallyalive() && player player::isplayerads() )
        {
            weapon = player getcurrentweapon();
            
            if ( function_19d936b3002eda6d( weapon ) )
            {
                startpos = player geteye();
                trace = trace::ray_trace( startpos, anglestoforward( player getplayerangles() ) * 10000, player );
                
                if ( math::segmentvssphere( startpos, trace[ "position" ], grenade.origin, 540 ) )
                {
                    dist = distance( player getorigin(), grenade.origin );
                    
                    if ( dist > 540 && dist < 16288 )
                    {
                        validplayers[ validplayers.size ] = player;
                    }
                }
            }
        }
    }
    
    if ( validplayers.size > 0 )
    {
        foreach ( player in validplayers )
        {
            dist = distance( player getorigin(), grenade.origin );
            perc = 1 - ( dist - 540 ) / 15748;
            minduration = getdvarfloat( @"hash_59574d8ebd343e53", 0.1 );
            maxduration = getdvarfloat( @"hash_3bbd9dca2088f5e5", 1 );
            durrange = maxduration - minduration;
            finalduration = durrange * perc + minduration;
            player thread function_f514a8c70ee04818( finalduration );
            
            /#
                targetms = 5000;
                frames = int( targetms / getframeduration() + 0.5 );
                printtoscreen2d( 220, 200, "<dev string:x26a>", undefined, 1.5, frames );
            #/
        }
    }
}

// Namespace flash_grenade
// Params 1
// Checksum 0xd05d34fd, Offset: 0x2f81
// Size: 0x8f
function function_f514a8c70ee04818( duration )
{
    forward = anglestoforward( self getplayerangles() );
    pos = self geteye() + getdvarint( @"hash_d0b44b35b804870b", 18 ) * forward;
    playfx( level._effect[ "flash_grenade_lens_flare" ], pos, undefined, undefined, self );
    wait getdvarfloat( @"hash_28365ca36703dc70", 0.5 );
    shellshock_utility_cpmp::_shellshock( %"sat_flash_grenade_scoped_wz", #"flash", duration, 1, 500 );
}

// Namespace flash_grenade
// Params 1
// Checksum 0xeada237c, Offset: 0x3018
// Size: 0x14b
function function_19d936b3002eda6d( objweapon )
{
    var_6b295309a15e23ed = objweapon.var_f6f9f66e9b50d71c;
    
    if ( !isdefined( var_6b295309a15e23ed ) )
    {
        return;
    }
    
    var_d2e2d72e15e4205f = [ #"category", #"baseref" ];
    
    foreach ( attachment in var_6b295309a15e23ed )
    {
        bundle = getscriptbundlefieldvalues( attachment, var_d2e2d72e15e4205f );
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        var_460feca106cb4463 = bundle.baseref ?? "";
        var_c1a114f6925e9d64 = isdefined( bundle.category ) ? toupper( getscriptbundlefieldvalue( bundle.category, #"ref" ) ) : undefined;
        
        if ( isdefined( var_c1a114f6925e9d64 ) )
        {
            if ( var_c1a114f6925e9d64 == "OPTIC" || issubstr( var_460feca106cb4463, "scope" ) )
            {
                return 1;
            }
        }
    }
}

