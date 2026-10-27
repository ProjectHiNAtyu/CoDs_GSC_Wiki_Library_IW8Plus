// scripts\mp\ob\ob_soldier_util.gsc  (hash_6d32c773f74edb3d.gscc) (size: 54974 Bytes / 0xd6be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32c282a1 (851608225)
// size ...... 54974 (0xd6be)
// includes .. 46  (offset: 0xca1a)
// strings ... 149 (offset: 0xcb8a)
// dev strs .. 8   (offset: 0xd65a)
// exports ... 92  (offset: 0x9066)
// cseg ...... 0xcdc + 0x838a (0x9066)
// imports ... 355 (offset: 0x9ec6)
// animtree1 . 0   (offset: 0xd6be)
// animtree2 . 0   (offset: 0xd6be)
#using script_16ea1b94f0f381b3;
#using script_2304453c69e996e2;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\equipment\landmine;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\targetmarkergroups;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\supers\landmine_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\damage;
#using scripts\mp\damage_numbers;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment_interact;
#using scripts\mp\hostmigration;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace ob_soldier_util;

// Namespace ob_soldier_util
// Params 0, eflags: 0x5
// Checksum 0xd7c7e577, Offset: 0xcfa
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_soldier_util", undefined, &init, undefined );
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x898b3541, Offset: 0xd1b
// Size: 0x91
function init()
{
    utility::registersharedfunc( "ob_mine", #"hack", &function_de49ecb2b2b3b608 );
    utility::registersharedfunc( "ob_ai_turret", #"hack", &function_c9b8f31373ec12e4 );
    var_f7811845d861eff = getdvarint( @"hash_fbf1f61ed9e7df9", 3 );
    level.ob_toggleable_cover_throttle = throttle::throttle_initialize( "ob_toggleable_cover", var_f7811845d861eff );
    level thread hide_watch_tower_clip();
    scriptable::scriptable_addnotifycallback( "landmine_damaged", &function_51afb37c31e8f678 );
    scriptable::scriptable_addnotifycallback( "tripwire_damaged", &function_bdc0dd167b6814f );
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0x80d54417, Offset: 0xdb4
    // Size: 0x5, Type: dev
    function function_81d41af40c224b99()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 6
// Checksum 0x827d8985, Offset: 0xdc1
// Size: 0x150
function function_2d35e1f7c116b33( aitype, position, angles, team, tier, groupname )
{
    if ( aitype == "civ" )
    {
        var_ac1107852a4a4547 = "jup_ob_civ_base";
        team = "civilian";
    }
    else
    {
        if ( isdefined( team ) == 0 )
        {
            team = "team_hundred_ninety";
        }
        
        if ( !isdefined( aitype ) )
        {
            aitype = "grunt";
        }
        
        if ( !isdefined( tier ) )
        {
            tier = 1;
        }
        
        if ( aitype == "zombie" )
        {
            var_ac1107852a4a4547 = function_b3988325430ce242( "zombie_base" );
        }
        else if ( aitype == "armored_zombie" )
        {
            var_ac1107852a4a4547 = function_b3988325430ce242( "zombie_base_armored_heavy" );
        }
        else if ( team == "allies" )
        {
            var_ac1107852a4a4547 = "jup_ob_ally_" + aitype + "_base";
        }
        else
        {
            var_ac1107852a4a4547 = "jup_ob_enemy_" + aitype;
        }
    }
    
    agent = mp_agent::spawnnewagentaitype( var_ac1107852a4a4547, position, angles, team );
    
    if ( isdefined( agent ) )
    {
        if ( isdefined( groupname ) && aitype != "civ" && aitype != "zombie" )
        {
            function_c5c27c1046c3cfaa( agent, groupname );
        }
        
        if ( isdefined( agent ) )
        {
            agent.aitype = aitype;
        }
        
        if ( !threatbiasgroupexists( team ) )
        {
            createthreatbiasgroup( team );
        }
        
        agent setthreatbiasgroup( team );
    }
    
    return agent;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x33d91d51, Offset: 0xf1a
// Size: 0x38
function function_c5c27c1046c3cfaa( agent, groupname )
{
    if ( isdefined( agent ) && isdefined( groupname ) )
    {
        agent.script_stealthgroup = groupname;
        agent thread enemy::main();
    }
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0xa17a971e, Offset: 0xf5a
    // Size: 0x5, Type: dev
    function function_9efd0a7721577694()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 2
// Checksum 0x1291c033, Offset: 0xf67
// Size: 0x110
function mortar_zombie_cleanup( center, radius )
{
    var_168d74e8204c2d47 = getaiarrayinradius( center, radius );
    var_ad63424e4995c52c = [];
    
    foreach ( ai in var_168d74e8204c2d47 )
    {
        if ( !function_98c160485389b9a0( ai, var_ad63424e4995c52c, 256 ) )
        {
            marker = spawnscriptable( "ob_zombie_cleanup_marker", ai.origin );
            marker setscriptablepartstate( "target", "on" );
            scriptable::scriptable_addnotifycallback( "detonate", &function_8d5f333cb82aff48 );
            var_ad63424e4995c52c[ var_ad63424e4995c52c.size ] = ai.origin;
            wait randomfloatrange( 0.15, 0.25 );
        }
    }
    
    wait 1;
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x22ed90a, Offset: 0x107f
// Size: 0x46
function function_8d5f333cb82aff48( instance, note, param, var_64ffacba090c91be )
{
    radiusdamage( instance.origin, 356, 1000, 800, undefined, "MOD_EXPLOSIVE" );
}

// Namespace ob_soldier_util
// Params 3
// Checksum 0xc0d34083, Offset: 0x10cd
// Size: 0xa2, Type: bool
function function_98c160485389b9a0( ai, var_ad63424e4995c52c, radius )
{
    foreach ( var_39b98d925d8c4ec9 in var_ad63424e4995c52c )
    {
        if ( utility::ispointinsidecircle( ai.origin, var_39b98d925d8c4ec9, radius ) )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0x934fb126, Offset: 0x1178
    // Size: 0x5, Type: dev
    function function_832c84c566bf7390()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 6
// Checksum 0x644103a7, Offset: 0x1185
// Size: 0xa2
function ob_mine_spawn( pos, var_8de6f80b3674ce04, owner, player_trigger_radius_override, angles, var_9c3caabdf395474 )
{
    assert( isdefined( owner ), "<dev string:x24>" );
    
    if ( level.gametype == "ob" )
    {
        assert( var_9c3caabdf395474 == 1, "<dev string:x3b>" );
    }
    
    if ( var_9c3caabdf395474 || getdvarint( @"hash_7afe2223c479d2f2", 0 ) )
    {
        return function_57f0767635eaffda( pos, angles, var_8de6f80b3674ce04, owner, player_trigger_radius_override );
    }
    
    return function_8c713ece744a2965( pos, var_8de6f80b3674ce04, owner, player_trigger_radius_override );
}

// Namespace ob_soldier_util
// Params 5
// Checksum 0x6623e756, Offset: 0x122f
// Size: 0x12a
function function_57f0767635eaffda( origin, angles, var_8de6f80b3674ce04, owner, player_trigger_radius_override )
{
    if ( !angles )
    {
        angles = ( 0, 0, 0 );
    }
    
    mine = spawnscriptable( "equip_landmine_sat_ob_entless_b", origin + ( 0, 0, 2 ), angles );
    assert( isdefined( mine ), "<dev string:x6c>" );
    
    if ( var_8de6f80b3674ce04 )
    {
        mine thread ob_mine_badplace( var_8de6f80b3674ce04 );
    }
    
    if ( owner )
    {
        mine.owner = owner;
    }
    
    mine.var_b8e92a93af2aa003 = 1;
    mine.team = "team_hundred_ninety";
    mine.player_trigger_radius = player_trigger_radius_override ? player_trigger_radius_override : 150;
    mine.radius = mine.player_trigger_radius;
    mine.attacker = mine.owner;
    mine setscriptablepartstate( "visibility", "show", 0 );
    mine thread at_mine::at_mine_watch_game_end();
    level thread ob_mine_plant( mine, undefined );
    return mine;
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x7ac1d06d, Offset: 0x1362
// Size: 0x97
function function_51afb37c31e8f678( mine, note, param, var_64ffacba090c91be )
{
    if ( !mine.exploded )
    {
        mine callback::callback( #"hash_9357451f2536bb84", { #attacker:var_64ffacba090c91be } );
        
        if ( isdefined( var_64ffacba090c91be ) && isdefined( mine.owner ) && var_64ffacba090c91be != mine.owner )
        {
            var_64ffacba090c91be thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_ae06df7368bd2eda" );
        }
        
        mine thread landmine::function_a135263868e889da( var_64ffacba090c91be );
    }
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x9ea5b047, Offset: 0x1401
// Size: 0x133
function function_8c713ece744a2965( pos, var_8de6f80b3674ce04, owner, player_trigger_radius_override )
{
    mine = magicgrenademanual( "sat_landmine_ob", pos + ( 0, 0, 15 ), ( 0, 0, 1 ) );
    mine waittill( #"missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal );
    
    if ( isdefined( var_8de6f80b3674ce04 ) )
    {
        mine thread ob_mine_badplace( var_8de6f80b3674ce04 );
    }
    
    if ( isdefined( owner ) )
    {
        mine.owner = owner;
    }
    
    mine.team = "team_hundred_ninety";
    mine.player_trigger_radius = player_trigger_radius_override ?? 150;
    mine setscriptablepartstate( "visibility", "show", 0 );
    mine setscriptablepartstate( "floats", "hide", 0 );
    mine thread at_mine::at_mine_watch_game_end();
    
    if ( isdefined( stuckto ) )
    {
        mine linkto( stuckto );
    }
    
    level thread ob_mine_plant( mine, surfacetype );
    return mine;
}

// Namespace ob_soldier_util
// Params 5
// Checksum 0x90d7571a, Offset: 0x153d
// Size: 0xf2
function function_5b25817a9f279a81( pos, var_8de6f80b3674ce04, owner, player_trigger_radius_override, angles = ( 0, 0, 1 ) )
{
    mine = spawnscriptable( "equip_claymore_ob", pos + ( 0, 0, 4 ), angles );
    mine.bundle = getscriptbundle( %"hash_6cc09ff20508d547" );
    
    if ( isdefined( var_8de6f80b3674ce04 ) )
    {
        mine thread ob_mine_badplace( var_8de6f80b3674ce04 );
    }
    
    if ( isdefined( owner ) )
    {
        mine.owner = owner;
    }
    
    mine.team = "team_hundred_ninety";
    mine.player_trigger_radius = player_trigger_radius_override ?? 150;
    mine setscriptablepartstate( "visibility", "show", 0 );
    mine thread claymore::claymore_watch_game_end();
    level thread ob_claymore_plant( mine );
    return mine;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x5187cdde, Offset: 0x1638
// Size: 0xe6
function ob_claymore_plant( grenade )
{
    grenade endon( #"mine_destroyed" );
    grenade endon( #"death" );
    grenade.equipmentref = "equip_claymore_mp";
    grenade.deletefunc = &claymore::claymore_delete;
    grenade.weapon_name = "claymore_mp";
    level.entlessmines[ grenade.index ] = grenade;
    grenade setscriptablepartstate( "plant", "active", 0 );
    grenade.planted = 1;
    grenade notify( #"mine_planted" );
    grenade emp_debuff::set_apply_emp_callback( &claymore::claymore_empapplied );
    grenade haywire::function_7f69a1eb3d590f76( &claymore::claymore_haywireapplied );
    grenade thread ob_mine_trigger();
    grenade thread claymore::claymore_watchfortrigger();
    grenade thread claymore::claymore_explodeonnotify();
    grenade.weapon_name = "claymore_mp";
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0xc823bd70, Offset: 0x1726
// Size: 0x206
function ob_mine_plant( grenade, surfacetype )
{
    grenade endon( #"mine_destroyed" );
    grenade endon( #"death" );
    grenade setscriptablepartstate( "plant", "active", 0 );
    
    if ( isent( grenade ) )
    {
        grenade missilethermal();
        grenade missileoutline();
        grenade setnodeploy( 1 );
        grenade enableplayermarks( "equipment" );
    }
    
    grenade.equipmentref = "equip_at_mine";
    grenade.deletefunc = &at_mine::at_mine_delete;
    grenade weapon::registermine();
    grenade.damage_max = getdvarint( @"hash_b6f86ed8c140d85", 125 );
    grenade.damage_min = grenade.damage_max / 2;
    grenade setscriptablepartstate( "plant", "active", 0 );
    
    if ( isent( grenade ) )
    {
        grenade enableplayermarks( #"equipment" );
    }
    
    grenade.planted = 1;
    grenade notify( #"mine_planted" );
    
    if ( isent( grenade ) )
    {
        grenade sentientpoolmanager::registersentient( "Lethal_Static", "team_hundred_ninety", 1 );
        grenade thread weapons::minedamagemonitor();
        wait 0.75;
        
        if ( grenade.touchedmovingplatform )
        {
            grenade thread landmine::function_7637c9ec1ff2fe30();
        }
        
        wait 0.75;
        grenade thread equipment_interact::remoteinteractsetup( &landmine::function_a135263868e889da, 1, 1 );
    }
    
    grenade emp_debuff::set_apply_emp_callback( &landmine_mp::landmine_emp_applied );
    grenade setscriptablepartstate( "arm", "active", 0 );
    grenade thread ob_mine_trigger();
    grenade thread landmine::function_bcb65ad5d65b57fd();
    grenade thread landmine::landmine_watch_trigger();
    grenade.weapon_name = "sat_landmine_mp";
    grenade.bundle = namespace_9d8e359c3b1041e5::getsuperbundlefromoffhandweaponnamesharedfunc( grenade.weapon_name );
    iconoffset = 2;
    grenade utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_mine" );
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x9a344461, Offset: 0x1934
// Size: 0x73
function function_de49ecb2b2b3b608( hack_effect, attacker )
{
    self.team = attacker.team;
    self.headiconid = namespace_9d8e359c3b1041e5::setheadiconfactionimagesharedfunc( 1, 2, undefined, undefined, undefined, 0.1, 1, 0, undefined, undefined, level.gamemodebundle.var_23132e4a260bbcc6 ?? "ui_hud_icon_field_upgrade", "icon_small" );
    landmine::landmine_hack( hack_effect, attacker );
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x7b2500e7, Offset: 0x19af
// Size: 0x294
function ob_mine_trigger()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    
    if ( !isdefined( level.ob_mine_trigger_throttle ) )
    {
        level.ob_mine_trigger_throttle = throttle::throttle_initialize( "ob_mine_trigger", 10, undefined, 500 );
    }
    
    if ( !isdefined( level.var_af3b1f1c1cca1a29 ) )
    {
        level.var_af3b1f1c1cca1a29 = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.ob_mine_trigger_throttle, self );
        var_2cc4f50e7fd8a02 = entity::function_cd55d7a649cb9c44( self.origin, self.player_trigger_radius );
        vehicles = vehicle_getarrayinradius( self.origin, 300 );
        
        if ( vehicles.size > 0 )
        {
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle.team ) && ( vehicle.team == self.team || vehicle.team == "neutral" ) )
                {
                    vehicles = arrayremove( vehicles, vehicle );
                }
            }
        }
        
        foreach ( guy in var_2cc4f50e7fd8a02 )
        {
            if ( guy.team == self.team )
            {
                var_2cc4f50e7fd8a02 = arrayremove( var_2cc4f50e7fd8a02, guy );
                continue;
            }
            
            canseetarget = trace::ray_trace_passed( self.origin + ( 0, 0, 10 ), guy geteye(), undefined, level.var_af3b1f1c1cca1a29 );
            
            if ( !canseetarget )
            {
                var_2cc4f50e7fd8a02 = arrayremove( var_2cc4f50e7fd8a02, guy );
                continue;
            }
            
            break;
        }
        
        ents = arraycombine( var_2cc4f50e7fd8a02, vehicles );
        
        if ( ents.size > 0 )
        {
            self notify( #"trigger_grenade", ents );
        }
        
        wait 0.1;
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x5c8cada, Offset: 0x1c4b
// Size: 0x3a
function ob_mine_badplace( var_8de6f80b3674ce04 )
{
    badplace_cylinder( var_8de6f80b3674ce04, 0, self.origin, 100, 100, "team_hundred_ninety" );
    self waittill( #"death" );
    badplace_delete( var_8de6f80b3674ce04 );
}

// Namespace ob_soldier_util
// Params 11
// Checksum 0xd2332a36, Offset: 0x1c8d
// Size: 0x89
function function_bf886d43eec9d5de( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( eattacker.classname != "worldspawn" )
    {
        instance notify( #"detonateexplosive", eattacker );
    }
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0xbb3599c2, Offset: 0x1d1e
// Size: 0x49
function function_bdc0dd167b6814f( trapdevice, note, param, var_64ffacba090c91be )
{
    trapdevice.tripwire.trigger notify( #"trigger", var_64ffacba090c91be );
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0xa50e543f, Offset: 0x1d6f
    // Size: 0x5, Type: dev
    function function_d30938a3513d733d()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 2
// Checksum 0x4eee802a, Offset: 0x1d7c
// Size: 0x86
function ob_sentry_turret_spawn( struct, using_vehicle_turret = 1 )
{
    if ( !isdefined( level.aisentryturrets ) )
    {
        ai_sentry_turret::init();
    }
    
    if ( using_vehicle_turret )
    {
        sentry = function_96a9d4af38ce5ca6( struct );
    }
    else
    {
        sentry = function_67e02d508a7ee92d( struct );
    }
    
    level.aisentryturrets.spawnedturrets[ level.aisentryturrets.spawnedturrets.size ] = sentry;
    return sentry;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0xa4c8ddce, Offset: 0x1e0b
// Size: 0xf8
function function_fc6e58e10547459b( a_structs )
{
    assert( isarray( a_structs ) );
    assert( a_structs.size == 0 || isdefined( a_structs[ 0 ].origin ) );
    activity = self;
    
    if ( !isstruct( activity ) || activity == level )
    {
        activity = {};
        activity.var_41964d9110b1cf5 = ob_resource_manager::function_33913e883ed9bb61();
    }
    
    foreach ( struct in a_structs )
    {
        struct.var_b9ac62a4e325b4be = #"killstreak";
        activity ob_activity_utility::ob_activity_spawn_turret( struct, undefined, undefined, 0, 1 );
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x2f74ec04, Offset: 0x1f0b
// Size: 0x3fd
function function_ee2d8b51c96bb64a()
{
    if ( getdvarint( @"hash_72b30f1696eedd3f", 1 ) == 1 && isdefined( level.sentrysettings[ "ai_sentry_turret" ] ) )
    {
        level.sentrysettings[ "ai_sentry_turret" ].health = getdvarint( @"hash_85190757115145bb", 99999 );
        level.sentrysettings[ "ai_sentry_turret" ].maxhealth = getdvarint( @"hash_36397d237d9e8cc4", 450 );
        level.sentrysettings[ "ai_sentry_turret" ].burstmin = getdvarint( @"hash_a46feb5e2592f0f2", 10 );
        level.sentrysettings[ "ai_sentry_turret" ].burstmax = getdvarint( @"hash_a44cf55e256cbf38", 15 );
        level.sentrysettings[ "ai_sentry_turret" ].pausemin = getdvarfloat( @"hash_e20bff747c64b106", 0.5 );
        level.sentrysettings[ "ai_sentry_turret" ].pausemax = getdvarfloat( @"hash_e22f11747c8b2054", 1 );
        level.sentrysettings[ "ai_sentry_turret" ].lockstrength = getdvarint( @"hash_ceced053aef1994e", 2 );
        level.sentrysettings[ "ai_sentry_turret" ].spinuptime = getdvarfloat( @"hash_b61a77e4372e219c", 1.3 );
        level.sentrysettings[ "ai_sentry_turret" ].overheattime = getdvarfloat( @"hash_dcf790014985321b", 8 );
        level.sentrysettings[ "ai_sentry_turret" ].cooldowntime = getdvarfloat( @"hash_fc469fa788fee5e8", 0.3 );
        level.sentrysettings[ "ai_sentry_turret" ].burstmaxtime = getdvarint( @"hash_820588da04a51de4", 4 );
        level.sentrysettings[ "ai_sentry_turret" ].var_cb2d3675356e0b50 = getdvarfloat( @"hash_72f2a62608ca10c1", 1.5 );
        level.sentrysettings[ "ai_sentry_turret" ].leftarc = getdvarint( @"hash_a3e7f06749d721bf", 95 );
        level.sentrysettings[ "ai_sentry_turret" ].rightarc = getdvarint( @"hash_736ea137340a907e", 95 );
        level.sentrysettings[ "ai_sentry_turret" ].laserrange = getdvarint( @"hash_65eca82be2c24432", 7562500 );
        level.sentrysettings[ "ai_sentry_turret" ].fxtime = getdvarfloat( @"hash_531ad70a9ffe2109", 0.3 );
        level.sentrysettings[ "ai_sentry_turret" ].targetrange = getdvarint( @"hash_8f07c50eccf99ef6", 1024 );
        level.sentrysettings[ "ai_sentry_turret" ].weaponinfo = getdvar( @"hash_179a9b0ce9e8095", "sat_sentry_turret_mp" );
        level.sentrysettings[ "ai_sentry_turret" ].modelbaseground = "streak_t10_wm_sentry_turret";
        level.sentrysettings[ "ai_sentry_turret" ].modeldestroyedground = "streak_t10_wm_sentry_turret";
        level.sentrysettings[ "ai_sentry_turret" ].fov = 0.7;
        level.sentrysettings[ "ai_sentry_turret" ].var_eab137ea962770b2 = 1;
        level.sentrysettings[ "ai_sentry_turret" ].contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
        level.sentrysettings[ "ai_sentry_turret" ].allowemp = getdvarint( @"hash_82f6ce0ef51532f7", 1 ) == 1;
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x965b13a4, Offset: 0x2310
// Size: 0x61b
function function_67e02d508a7ee92d( turretstruct )
{
    if ( getdvarint( @"scr_ai_sentry_turret", 1 ) == 0 )
    {
        return;
    }
    
    config = level.sentrysettings[ "ai_sentry_turret" ];
    
    if ( isdefined( turretstruct.weaponinfo ) )
    {
        config.weaponinfo = turretstruct.weaponinfo;
    }
    
    turret = spawnturret( "misc_turret", turretstruct.origin, config.weaponinfo );
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    turret.angles = turretstruct.angles;
    turret.health = turretstruct.health ?? 9999;
    turret.maxhealth = turretstruct.maxhealth ?? config.maxhealth;
    turret.ammocount = turretstruct.ammo ?? config.ammo;
    turret.timeout = turretstruct.timeout ?? config.timeout;
    turret.momentum = turretstruct.momentum ?? 0;
    turret.heatlevel = turretstruct.heatlevel ?? 0;
    turret.overheated = turretstruct.overheated ?? 0;
    turret.cooldownwaittime = turretstruct.cooldownwaittime ?? 0.1;
    turret.sentrytype = "ai_sentry_turret";
    turret.owningteam = turretstruct.team ?? "team_hundred_ninety";
    turret.team = turretstruct.team ?? "team_hundred_ninety";
    turret.var_3761ee502c4a6baa = turretstruct.var_3761ee502c4a6baa ?? 10;
    turret.var_b712c270b3e6cfd4 = turretstruct.var_b712c270b3e6cfd4 ?? 0;
    turret setmodel( turretstruct.modelbaseground ?? config.modelbaseground );
    turret setturretteam( turret.owningteam );
    turret setcandamage( turretstruct.candamage ?? 1 );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( turretstruct.defaultdroppitch ?? 0 );
    turret setautorotationdelay( turretstruct.autorotationdelay ?? 0.5 );
    turret maketurretinoperable();
    leftarc = float( turretstruct.leftarc ?? config.leftarc );
    turret.leftarc = leftarc;
    turret setleftarc( leftarc );
    rightarc = float( turretstruct.rightarc ?? config.rightarc );
    turret.rightarc = rightarc;
    turret setrightarc( rightarc );
    turret setbottomarc( turretstruct.bottomarc ?? 50 );
    turret settoparc( turretstruct.toparc ?? 60 );
    turret setconvergencetime( turretstruct.var_d006e449308cd90 ?? 1, "pitch" );
    turret setconvergencetime( turretstruct.var_7b4cb40f389486c5 ?? 1, "yaw" );
    turret setconvergenceheightpercent( turretstruct.convergenceheightpercent ?? 0.9 );
    turret setdefaultdroppitch( turretstruct.defaultdroppitch ?? -89 );
    turret setturretmodechangewait( turretstruct.modechangewait ?? 1 );
    turret sentientpoolmanager::registersentient( "Killstreak_Ground", turret.team );
    allowemp = turretstruct.allowemp ?? config.allowemp;
    
    if ( !allowemp )
    {
        turret emp_debuff::allow_emp( 0 );
    }
    
    if ( !turretstruct.disablelaser )
    {
        turret laseron();
    }
    
    if ( turretstruct.var_b9ac62a4e325b4be )
    {
        turret enableplayermarks( turretstruct.var_b9ac62a4e325b4be );
    }
    
    turret setscriptablepartstate( #"visibility", #"show" );
    turret utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_ai_turret" );
    turret emp_debuff::set_start_emp_callback( &aisentryturret_empstarted );
    turret emp_debuff::set_clear_emp_callback( &aisentryturret_empcleared );
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &ai_sentry_turret::turret_handledeathdamage, &ob_turret_modifydamage, 1, undefined, undefined, 0 );
    turret thread ob_sentry_turret_watchdeath();
    turret thread ob_sentry_turret_watchdamage();
    turret thread ob_sentry_turret_watchtargeting();
    turret thread ai_sentry_turret::function_a99c369d4ea722b1();
    turret thread ai_sentry_turret::function_f9a3d2f1b2cd1e4d();
    turret.turreton = 1;
    turret setmode( config.sentrymodeon );
    turret.aitypeid = function_43b5ed5a14a56573( #"aitype", %"sat_ob_sentryturret_healthbar" );
    turret.subclass_scriptbundle = getscriptbundle( %"ai_subclass:sentryturret_healthbar" );
    turret.subclass = turret.subclass_scriptbundle.name;
    turret.turrettype = "ai_sentry_turret";
    turret val::set( "turret", "show_healthbar", 1 );
    turret.var_24954f14e27b448d = 1;
    turret.var_d165d33ad4f00e17 = turret.maxhealth;
    turret thread function_a30f74f22f7cfee4();
    turret.using_fake_health = 1;
    turret.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_672ba5a81115a0c7" );
    return turret;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x33d805f, Offset: 0x2934
// Size: 0x3e2
function function_96a9d4af38ce5ca6( turretstruct )
{
    config = level.sentrysettings[ "ai_sentry_turret" ];
    
    if ( isdefined( turretstruct.weaponinfo ) )
    {
        config.weaponinfo = turretstruct.weaponinfo;
    }
    
    turretangles = turretstruct.angles ?? ( 0, 0, 0 );
    remoteturretvehicletype = "veh_guild_sentry_turret";
    spawndata = { #owner:undefined, #angles:turretangles, #targetname:remoteturretvehicletype, #vehicletype:remoteturretvehicletype, #origin:turretstruct.origin };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !vehicle::has_data( remoteturretvehicletype ) )
    {
        vehicle::generic_init( remoteturretvehicletype );
    }
    
    turret callback::add( #"vehicle_damage", &function_87b9928256edb7df );
    vehicle_tracking::register_instance( turret );
    vehicle_occupancy::register_instance( turret );
    turret.maxhealth = turretstruct.maxhealth ?? config.maxhealth;
    turret.owningteam = turretstruct.team ?? "team_hundred_ninety";
    turret.team = turretstruct.team ?? "team_hundred_ninety";
    turret.sentrytype = "ai_sentry_turret";
    turret.var_b712c270b3e6cfd4 = 1;
    turret setvehicleteam( turret.team );
    turret sentientpoolmanager::registersentient( "Killstreak_Ground", turret.team );
    allowemp = turretstruct.allowemp ?? config.allowemp;
    
    if ( !allowemp )
    {
        turret emp_debuff::allow_emp( 0 );
    }
    
    if ( !turretstruct.disablelaser )
    {
        turret laseron();
    }
    
    if ( turretstruct.var_b9ac62a4e325b4be )
    {
        turret enableplayermarks( turretstruct.var_b9ac62a4e325b4be );
    }
    
    turret setscriptablepartstate( #"visibility", #"show" );
    turret.var_92f27893e3e47b21 = 1;
    turret utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_ai_turret" );
    turret emp_debuff::set_start_emp_callback( &aisentryturret_empstarted );
    turret emp_debuff::set_clear_emp_callback( &aisentryturret_empcleared );
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &ai_sentry_turret::turret_handledeathdamage, &ob_turret_modifydamage, 1, undefined, undefined, 0 );
    turret thread ob_sentry_turret_watchdamage();
    turret thread ob_sentry_turret_watchdeath();
    turret thread ai_sentry_turret::function_a99c369d4ea722b1();
    turret.streakname = "remote_turret";
    turret.aitypeid = function_43b5ed5a14a56573( #"aitype", %"sat_ob_sentryturret_healthbar" );
    turret.subclass_scriptbundle = getscriptbundle( %"ai_subclass:sentryturret_healthbar" );
    turret.subclass = turret.subclass_scriptbundle.name;
    turret.turrettype = "ai_sentry_turret";
    turret val::set( "turret", "show_healthbar", 1 );
    turret.var_24954f14e27b448d = 1;
    turret.var_d165d33ad4f00e17 = turret.maxhealth;
    turret thread function_a30f74f22f7cfee4();
    turret.using_fake_health = 1;
    turret.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_672ba5a81115a0c7" );
    turret thread function_67269135cff268b4();
    return turret;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0xf3d06d78, Offset: 0x2d1f
// Size: 0x84
function function_87b9928256edb7df( data )
{
    if ( isplayer( data.attacker ) )
    {
        damage_numbers::display( data.attacker, data.victim, data.hitloc, data.meansofdeath, data.objweapon, data.damage, data.point, undefined, undefined, undefined, undefined, undefined, undefined, data.inflictor, undefined );
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xc5932481, Offset: 0x2dab
// Size: 0xf5
function function_67269135cff268b4()
{
    self endon( #"kill_turret" );
    level endon( #"game_ended" );
    momentum = 0;
    var_96cbbf3eaeaca85e = 0;
    updateinterval = 0.1;
    self setturretscriptcontrolled( 1, 0 );
    self setscriptablepartstate( "turret_carry_state", "turret_plant" );
    turret::function_2e0a246d12d5e047( &function_d327ab4c0ad1af1 );
    turret::function_9a0fa09f3acbc0cd();
    turret::function_9b1f535339c80a4();
    
    while ( true )
    {
        var_af21fdaa241f1b3f = turret::is_turret_firing();
        
        if ( !var_96cbbf3eaeaca85e && var_af21fdaa241f1b3f )
        {
            momentum = 0;
        }
        else if ( var_af21fdaa241f1b3f )
        {
            if ( momentum < 1 )
            {
                momentum += updateinterval;
                
                if ( momentum >= 1 )
                {
                    self setscriptablepartstate( "turret_target_found", "target_found" );
                }
            }
        }
        else if ( var_96cbbf3eaeaca85e && !var_af21fdaa241f1b3f )
        {
            self setscriptablepartstate( "turret_target_found", "off" );
        }
        
        var_96cbbf3eaeaca85e = var_af21fdaa241f1b3f;
        wait updateinterval;
    }
}

// Namespace ob_soldier_util
// Params 2, eflags: 0x4
// Checksum 0x7b5fa296, Offset: 0x2ea8
// Size: 0x1d
function private function_d327ab4c0ad1af1( target, turretindex )
{
    return ob_sentry_turret_isvalidtarget( target );
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0xbbef84eb, Offset: 0x2ece
// Size: 0x6c
function aisentryturret_empstarted( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"disabled_sentry_gun" );
        }
    }
    
    aisentryturret_empupdate();
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x49e4d94c, Offset: 0x2f42
// Size: 0x19
function aisentryturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    aisentryturret_empupdate();
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x223b81d2, Offset: 0x2f63
// Size: 0x2f
function aisentryturret_empupdate()
{
    if ( entity::isturret( self ) )
    {
        empupdate_misc_turret();
        return;
    }
    
    if ( self.classname == "script_vehicle" )
    {
        function_e982c42db0cba7df();
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x5cc07bae, Offset: 0x2f9a
// Size: 0xed
function empupdate_misc_turret()
{
    if ( emp_debuff::is_empd() )
    {
        self turretfiredisable();
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        self laseroff();
        self cleartargetentity();
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empstarted" ) ]]();
        }
        
        return;
    }
    
    if ( !self.killed )
    {
        self turretfireenable();
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
        self laseron();
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empcleared" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empcleared" ) ]]();
        }
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xab458f15, Offset: 0x308f
// Size: 0xb7
function function_e982c42db0cba7df()
{
    if ( emp_debuff::is_empd() )
    {
        self setscriptablepartstate( "empd", "on" );
        turret::function_9a0fa09f3acbc0cd();
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empstarted" ) ]]();
        }
        
        return;
    }
    
    if ( !self.killed )
    {
        self setscriptablepartstate( "empd", "off" );
        turret::function_9b1f535339c80a4();
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empcleared" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empcleared" ) ]]();
        }
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xbd725dd1, Offset: 0x314e
// Size: 0x57
function function_a30f74f22f7cfee4()
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    
    while ( true )
    {
        currenthealth = self.maxhealth - self.damagetaken;
        
        if ( currenthealth < 0 )
        {
            currenthealth = 0;
        }
        
        self.var_cce7c67ea2da8902 = currenthealth;
        waitframe();
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x1a151d4f, Offset: 0x31ad
// Size: 0xb0
function ob_turret_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    
    if ( self.var_b712c270b3e6cfd4 && isdefined( attacker.team ) && self.team == attacker.team )
    {
        return 0;
    }
    
    return damage;
}

// Namespace ob_soldier_util
// Params 0, eflags: 0x4
// Checksum 0xc9ccb3d1, Offset: 0x3266
// Size: 0xc6
function private ob_sentry_turret_watchdamage()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon, origin, angles, normal, inflictor );
        damage_utility::function_723dcec170ec23be( eattacker );
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xa7b5d0c0, Offset: 0x3334
// Size: 0x1c3
function ob_sentry_turret_watchdeath()
{
    self waittill( #"kill_turret", skipshutdown, wasdestroyed );
    is_vehicle = 0;
    
    if ( entity::isturret( self ) )
    {
        ai_sentry_turret::turret_setturretmodel( "destroyed" );
        self setturretowner( undefined );
    }
    else if ( self.classname == "script_vehicle" )
    {
        is_vehicle = !getdvarint( @"hash_b6c999fb9bb1a01d", 0 );
        vehicle_tracking::deregister_instance( self );
        vehicle_occupancy::deregister_instance( self );
    }
    
    if ( !skipshutdown )
    {
        self playsound( "sentry_explode_smoke" );
        self setscriptablepartstate( "shutdown", "on" );
        hostmigration::waitlongdurationwithpause( 2 );
        self setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    
    self playsound( "mp_equip_destroyed" );
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    wait 0.2;
    
    if ( isdefined( level.aisentryturrets.spawnedturrets ) && isdefined( level.aisentryturrets.spawnedturrets ) && arraycontains( level.aisentryturrets.spawnedturrets, self ) )
    {
        level.aisentryturrets.spawnedturrets = arrayremove( level.aisentryturrets.spawnedturrets, self );
    }
    
    if ( is_vehicle )
    {
        vehicle_tracking::delete_vehicle( self );
        return;
    }
    
    self delete();
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x5dd691c0, Offset: 0x34ff
// Size: 0x3a
function function_c9b8f31373ec12e4( hack_effect, attacker )
{
    if ( hack_effect.var_30e7de3d76d5a085 )
    {
        function_21324ceeee6b651( hack_effect, attacker );
        return;
    }
    
    thread function_cce6efa4a7ad9e03( hack_effect, attacker );
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0xd1beaa5a, Offset: 0x3541
// Size: 0x1ee
function function_21324ceeee6b651( hack_effect, attacker )
{
    turret = self;
    turret notify( #"hash_efa77378893bae83" );
    turret.empcount = turret.empcount ? turret.empcount - 1 : undefined;
    turret aisentryturret_empupdate();
    turret.owner = attacker;
    turret.team = attacker.team;
    turret.owningteam = attacker.team;
    turret utility::ent_flag_set( "turned" );
    
    if ( entity::isturret( turret ) )
    {
        turret setturretowner( attacker );
        turret setturretteam( attacker.team );
    }
    else if ( turret.classname == "script_vehicle" )
    {
        turret setotherent( turret.owner );
        turret setvehicleteam( turret.team );
        turret.spawndata.owner = turret.owner;
        turret.nullownerdamagefunc = &function_bfc7e835bd28182e;
        turret setscriptablepartstate( "pingable", "off" );
    }
    
    var_b9f71b4d5e5f67be = getdvarint( @"hash_2db14a52911af4a4", 0 );
    
    if ( var_b9f71b4d5e5f67be > 0 )
    {
        turret.damagetaken = 0;
        turret.maxhealth = var_b9f71b4d5e5f67be;
        turret.var_d165d33ad4f00e17 = var_b9f71b4d5e5f67be;
    }
    
    if ( level.teambased )
    {
        turret filteroutplayermarks( attacker.team );
    }
    else
    {
        turret filteroutplayermarks( attacker );
    }
    
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( attacker, attacker.team, 2000, turret.streakinfo.streakname );
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x1dbc5d39, Offset: 0x3737
// Size: 0x3e, Type: bool
function function_bfc7e835bd28182e( attacker )
{
    if ( self.var_b712c270b3e6cfd4 )
    {
        return ( attacker.team && self.team == attacker.team );
    }
    
    return false;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x1aff0615, Offset: 0x377e
// Size: 0x12e
function function_cce6efa4a7ad9e03( hack_effect, attacker )
{
    turret = self;
    turret endon( #"death" );
    turret endon( #"game_ended" );
    turret endon( #"hash_efa77378893bae83" );
    turret.empcount = turret.empcount ? turret.empcount + 1 : 1;
    turret aisentryturret_empupdate();
    
    if ( level.teambased )
    {
        turret filteroutplayermarks( level.teamnamelist );
    }
    else
    {
        turret filteroutplayermarks( level.players );
    }
    
    wait hack_effect.hackduration * 0.001;
    turret.empcount--;
    turret aisentryturret_empupdate();
    
    if ( level.teambased )
    {
        turret filterinplayermarks( level.teamnamelist );
        turret filteroutplayermarks( self.owner.team );
        return;
    }
    
    turret filterinplayermarks( level.players );
    turret filteroutplayermarks( self.owner );
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xd5a5f04e, Offset: 0x38b4
// Size: 0x106
function ob_sentry_turret_watchtargeting()
{
    self endon( #"death" );
    config = level.sentrysettings[ self.sentrytype ];
    
    if ( !isdefined( level.ob_sentry_turret_watch_throttle ) )
    {
        level.ob_sentry_turret_watch_throttle = throttle::throttle_initialize( "ob_sentry_turret_watch", 3 );
    }
    
    while ( true )
    {
        if ( !self.turreton || self.turretdisabled )
        {
            waitframe();
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"turret", #"hash_95ed1ed0bb6d720c" ) )
        {
            self.besttarget = utility::callsharedfunc( #"turret", #"hash_95ed1ed0bb6d720c" );
        }
        else
        {
            self.besttarget = ob_sentry_turret_getbesttarget();
        }
        
        istargetalive = 1;
        
        if ( isdefined( self.besttarget ) )
        {
            function_1cc3016dba9c121();
        }
        
        hostmigration::waitlongdurationwithpause( config.cooldowntime );
        throttle::throttle_wait_in_queue( level.ob_sentry_turret_watch_throttle, self );
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x4137d6c0, Offset: 0x39c2
// Size: 0xbf
function function_1cc3016dba9c121()
{
    config = level.sentrysettings[ self.sentrytype ];
    
    while ( self.turreton && !self.stopfiring && function_bf6e6b11dd886712( self.besttarget ) )
    {
        self settargetentity( self.besttarget );
        
        if ( isplayer( self.besttarget ) )
        {
            pauseinterval = config.var_d435b063b8c608b2;
        }
        else
        {
            pauseinterval = config.var_cb2d3675356e0b50;
        }
        
        ai_sentry_turret::function_b1685d4bdad9300f( config.burstmaxtime, self.besttarget );
        hostmigration::waitlongdurationwithpause( pauseinterval );
        self cleartargetentity();
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0xdeae59d6, Offset: 0x3a89
// Size: 0x140
function ob_sentry_turret_getbesttarget()
{
    config = level.sentrysettings[ self.sentrytype ];
    targetrange = config.targetrange;
    var_eab089682021fc7c = targetrange * targetrange;
    startpoint = self gettagorigin( config.bullettag );
    startangles = self gettagangles( config.bullettag );
    potentialplayertargets = getentitiesinradiusfrompartitiongrid( startpoint, targetrange, createentitytypemask( [ "etype_player" ] ), [ self ] );
    var_6cb9200a36f75518 = getentitiesinradiusfrompartitiongrid( startpoint, targetrange, createentitytypemask( [ "etype_ai" ] ), [ self ] );
    potentialtargetlist = arraycombine( potentialplayertargets, var_6cb9200a36f75518 );
    potentialtargetlist = sortbydistance( potentialtargetlist, startpoint );
    besttarget = undefined;
    maxtargets = int( min( potentialtargetlist.size, 10 ) );
    
    for ( i = 0; i < maxtargets ; i++ )
    {
        validtarget = ob_sentry_turret_isvalidtarget( potentialtargetlist[ i ], startpoint, startangles );
        
        if ( !validtarget )
        {
            continue;
        }
        
        besttarget = potentialtargetlist[ i ];
        break;
    }
    
    return besttarget;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x96559e81, Offset: 0x3bd2
// Size: 0x1a0
function function_6a078a9b57687dab( potentialtarget, shotorigin )
{
    config = level.sentrysettings[ self.sentrytype ];
    targetpoints = [ "tag_origin", "j_mainroot", "j_head" ];
    targetdata = spawnstruct();
    targetdata.canseetarget = 0;
    
    if ( !isdefined( shotorigin ) )
    {
        shotorigin = self gettagorigin( config.bullettag );
    }
    
    foreach ( point in targetpoints )
    {
        var_9aaf5f1fce159b00 = potentialtarget.origin;
        
        if ( point != "tag_origin" )
        {
            var_9aaf5f1fce159b00 = potentialtarget gettagorigin( point, 1 );
        }
        
        if ( var_9aaf5f1fce159b00 )
        {
            targetdata.canseetarget = trace::ray_trace_passed( shotorigin, var_9aaf5f1fce159b00, self, config.contentsoverride );
            
            if ( targetdata.canseetarget )
            {
                if ( isdefined( config ) && config.var_eab137ea962770b2 )
                {
                    targetdata.var_eb33ccdc661877da = point;
                    
                    if ( targetdata.var_eb33ccdc661877da != "tag_origin" )
                    {
                        self function_fd0a7d75c84df67c( 1 );
                    }
                    else
                    {
                        self function_fd0a7d75c84df67c( 0 );
                    }
                }
                
                break;
            }
        }
    }
    
    return targetdata;
}

// Namespace ob_soldier_util
// Params 5
// Checksum 0xb8270ef, Offset: 0x3d7b
// Size: 0xe7, Type: bool
function function_594f6f9308cc03cc( potentialtarget, shotorigin, shotangles, targettag, fov )
{
    config = level.sentrysettings[ self.sentrytype ];
    
    if ( !isdefined( shotorigin ) )
    {
        shotorigin = self gettagorigin( config.bullettag );
    }
    
    if ( !isdefined( shotangles ) )
    {
        shotangles = self gettagangles( config.bullettag );
    }
    
    var_a46a0e0fa565ecdd = potentialtarget.origin;
    
    if ( isdefined( targettag ) )
    {
        var_a46a0e0fa565ecdd = potentialtarget gettagorigin( targettag );
    }
    
    metotarget = vectornormalize( var_a46a0e0fa565ecdd - shotorigin );
    dotproduct = vectordot( anglestoforward( shotangles ), metotarget );
    
    if ( !isdefined( fov ) )
    {
        fov = config.fov ?? 0.5;
    }
    
    return dotproduct > fov;
}

// Namespace ob_soldier_util
// Params 3
// Checksum 0x966cb81b, Offset: 0x3e6b
// Size: 0x170, Type: bool
function ob_sentry_turret_isvalidtarget( potentialtarget, var_e6c7b6c78b82a868, var_a7f154db0a1f345a )
{
    if ( self.team == potentialtarget.team )
    {
        return false;
    }
    
    if ( !isalive( potentialtarget ) )
    {
        return false;
    }
    
    if ( potentialtarget.notarget )
    {
        return false;
    }
    
    if ( potentialtarget.inlaststand )
    {
        return false;
    }
    
    if ( !function_594f6f9308cc03cc( potentialtarget, var_e6c7b6c78b82a868, var_a7f154db0a1f345a, undefined, 0 ) )
    {
        return false;
    }
    
    if ( entity::isturret( self ) )
    {
        targetdata = function_6a078a9b57687dab( potentialtarget, var_e6c7b6c78b82a868 );
        
        if ( !targetdata.canseetarget )
        {
            return false;
        }
    }
    
    if ( potentialtarget supers_mp::function_60dbd7e2f1b02c22() )
    {
        return false;
    }
    
    if ( isdefined( targetdata.var_eb33ccdc661877da ) && targetdata.var_eb33ccdc661877da != "tag_origin" && !function_594f6f9308cc03cc( potentialtarget, var_e6c7b6c78b82a868, var_a7f154db0a1f345a, targetdata.var_eb33ccdc661877da ) )
    {
        return false;
    }
    
    if ( isdefined( potentialtarget.var_79af01c812a15a4c ) )
    {
        config = level.sentrysettings[ self.sentrytype ];
        targetrange = config.targetrange;
        var_588b0cfcc02f07e2 = targetrange * potentialtarget.var_79af01c812a15a4c;
        
        if ( distancesquared( self.origin, potentialtarget.origin ) > var_588b0cfcc02f07e2 * var_588b0cfcc02f07e2 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x8851c327, Offset: 0x3fe4
// Size: 0x83, Type: bool
function function_bf6e6b11dd886712( besttarget )
{
    config = level.sentrysettings[ self.sentrytype ];
    maxrangesq = config.targetrange * config.targetrange;
    
    if ( distancesquared( self gettagorigin( config.bullettag ), besttarget.origin ) > maxrangesq )
    {
        return false;
    }
    
    if ( !ob_sentry_turret_isvalidtarget( besttarget ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0x7e8290ef, Offset: 0x4070
    // Size: 0x5, Type: dev
    function function_21f0760ae6c4b749()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 2
// Checksum 0xe0f42b9d, Offset: 0x407d
// Size: 0x35
function function_f8dc64379e93d335( start_node, owner )
{
    drone = ob_recon_drone_spawn( start_node, owner );
    drone namespace_28acf6540b1bc740::load_settings_bundle();
    return drone;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0x1a3d12da, Offset: 0x40bb
// Size: 0x111
function ob_recon_drone_spawn( start_node, owner )
{
    spawndata = spawnstruct();
    spawndata.origin = start_node.origin;
    spawndata.angles = start_node.angles;
    spawndata.targetname = start_node.targetname;
    spawndata.vehicletype = "veh_jup_ai_recon_drone_mp";
    spawndata.modelname = "veh9_mil_air_cuniform_mp";
    spawndata.owner = owner;
    drone = vehicle_tracking::spawn_helicopter( undefined, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname );
    
    if ( !isdefined( level.supportdrones ) )
    {
        level.supportdrones = [];
    }
    
    level.supportdrones[ level.supportdrones.size ] = drone;
    ob_recon_drone_init( drone, owner, self );
    return drone;
}

// Namespace ob_soldier_util
// Params 3
// Checksum 0x3efa5548, Offset: 0x41d5
// Size: 0x4e3
function ob_recon_drone_init( drone, owner, activityinstance )
{
    drone.health = 150;
    drone.maxhealth = 150;
    drone.currenthealth = 150;
    drone.hitstokill = 3;
    drone.damagetaken = 0;
    drone.speed = 45;
    drone.accel = 20;
    drone.decel = 20;
    drone.team = "team_hundred_ninety";
    drone setvehicleteam( drone.team );
    drone.helperdronetype = "scrambler_drone_guard";
    drone.stunned = 0;
    drone.inactive = 0;
    drone.ispiloted = 0;
    
    if ( isdefined( owner ) )
    {
        drone.owner = owner;
        drone setotherent( owner );
    }
    
    drone enableaimassist();
    drone setnodeploy( 1 );
    drone.vehiclename = "jup_ai_recon_drone";
    drone.streakname = "jup_ai_recon_drone";
    drone.attract_strength = 10000;
    drone.attract_range = 150;
    drone.attractor = missile_createattractorent( drone, drone.attract_strength, drone.attract_range );
    drone function_3a8137b2111328ba( 1 );
    drone function_6bfd7fe9a2652f52( 1 );
    drone vehicle_setspeed( drone.speed, drone.accel, drone.decel );
    drone setyawspeedbyname( "faster" );
    drone setneargoalnotifydist( 64 );
    drone setmaxpitchroll( 25, 50 );
    drone sethoverparams( 130, 10, 5 );
    drone setturningability( 1 );
    drone setdroneturnparams( 50, 1.3, 30, 20 );
    drone.aitypeid = function_43b5ed5a14a56573( #"aitype", %"jup_ob_recondrone_healthbar" );
    drone.subclass_scriptbundle = getscriptbundle( %"ai_subclass:recon_drone_healthbar" );
    drone.subclass = drone.subclass_scriptbundle.name;
    drone sentientpoolmanager::registersentient( "Lethal_Moving", self );
    drone setcandamage( 1 );
    vehicle_damage::set_vehicle_hit_damage_data( drone.streakname, 1 );
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( "emp_grenade_mp", 1, 1, drone.streakname );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreaksetpostmoddamagecallback" ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"killstreaksetpostmoddamagecallback" ) ]]( drone.streakname, &helper_drone::helperdrone_postmodifydamage );
    }
    
    level.vehicles.damagecallbacks.deathcallbacks[ drone.streakname ] = &ob_recon_drone_handledeathdamage;
    
    if ( !isdefined( drone.damagestates ) )
    {
        drone.damagestates = [];
        drone.currentdamagestate = 0;
    }
    
    drone.damagestates[ 1 ] = spawnstruct();
    drone.damagestates[ 1 ].damageamount = drone.maxhealth * 0.75;
    drone.damagestates[ 1 ].damagestatefunc = &helper_drone::function_1a1af8effb6318e7;
    drone.damagestates[ 2 ] = spawnstruct();
    drone.damagestates[ 2 ].damageamount = drone.maxhealth * 0.5;
    drone.damagestates[ 2 ].damagestatefunc = &helper_drone::function_34219a3628f1d9b0;
    drone.damagestates[ 3 ] = spawnstruct();
    drone.damagestates[ 3 ].damageamount = drone.maxhealth * 0.25;
    drone.damagestates[ 3 ].damagestatefunc = &helper_drone::function_db443e2033acaf2e;
    helper_drone::init_helper_drone_anim();
    weapons::function_ef0cb557b1a93af9( drone );
    drone thread ob_recon_drone_destroyongameend();
    drone thread ob_recon_drone_think( activityinstance );
    drone thread function_462af03ab2d66440();
    drone setscriptablepartstate( "lights", "on", 0 );
    drone setscriptablepartstate( "glint", "on", 0 );
    drone setscriptablepartstate( "engine", "on", 0 );
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x63f8690c, Offset: 0x46c0
// Size: 0x3f
function ob_recon_drone_destroyongameend()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    level utility::waittill_any( "bro_shot_start", "game_ended" );
    ob_recon_drone_handledeathdamage();
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x7eaac932, Offset: 0x4707
// Size: 0x71
function ob_recon_drone_handledeathdamage( data )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( isdefined( data ) )
    {
        thread function_ed8981f34799cf8e( data );
    }
    else
    {
        thread ob_recon_drone_explode( 1 );
    }
    
    params = spawnstruct();
    params.player = data.attacker;
    callback::callback( "on_merc_camp_recon_destroyed", params );
    return 0;
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x30a29ac2, Offset: 0x4781
// Size: 0x207
function function_ed8981f34799cf8e( data )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self.haywiredeath = 1;
    
    if ( self.repeatuse )
    {
        self.repeatuse = 0;
    }
    
    vertdistance = 3000;
    contents = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 0, 0 );
    castend = self.origin + anglestoup( self.angles ) * vertdistance * -1 + ( randomintrange( -500, 500 ), 0, randomintrange( -500, 500 ) );
    trace = trace::ray_trace( self.origin, castend, [ self ] );
    target_origin = trace[ "position" ] + trace[ "normal" ] * 5;
    maxvelocity = getdvarfloat( @"hash_44e62153228221f", 30.2 );
    acceleration = getdvarfloat( @"hash_cdb03278c6d17e78", 13.8 );
    deceleration = getdvarfloat( @"hash_ed85baf3072c3fff", 17.2 );
    var_6705e2570d9c3664 = getdvarfloat( @"hash_3f6d20d42a18063b", 2500 );
    distance = distance( target_origin, self.origin );
    falltime = sqrt( 2 * distance / acceleration );
    falltime = min( falltime, 2 ) - 0.2;
    self vehicle_setspeed( maxvelocity, acceleration, deceleration );
    self setvehgoalpos( target_origin, 0 );
    thread helper_drone::function_cc5d71d19cd66107();
    time = 0;
    
    while ( true )
    {
        if ( distancesquared( self.origin, target_origin ) <= var_6705e2570d9c3664 || time >= falltime )
        {
            function_b9f35eef8d0af5b( data );
            break;
        }
        
        time += level.framedurationseconds;
        waitframe();
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x48a22248, Offset: 0x4990
// Size: 0x86
function function_b9f35eef8d0af5b( data )
{
    if ( isdefined( data.inflictor ) && isdefined( data.inflictor.stuckto ) )
    {
        data.inflictor notify( #"forcedeath" );
    }
    
    if ( isdefined( self.var_ad74168cb59251e1 ) )
    {
        self.owner cameraunlink();
        self.var_ad74168cb59251e1 delete();
        self.var_ad74168cb59251e1 = undefined;
    }
    
    thread ob_recon_drone_explode( 1 );
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x188f9700, Offset: 0x4a1e
// Size: 0x16d
function ob_recon_drone_explode( wasdestroyed, wasexited, wastimedout, wasdetonated )
{
    self.isdestroyed = 1;
    weapons::function_d5eafafe8f6a97bf( self );
    
    if ( isdefined( self.targetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.targetmarkergroup );
        self.targetmarkergroup = undefined;
    }
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
        self.minimapid = undefined;
    }
    
    utility::callsharedfunc( #"scrambler_drone_guard", #"endjammedeffect" );
    
    if ( utility::issharedfuncdefined( #"game", #"clearoob" ) )
    {
        [[ utility::getsharedfunc( #"game", #"clearoob" ) ]]( self, 1 );
    }
    
    if ( isent( self ) )
    {
        explodestate = "on";
        
        if ( self.inwater )
        {
            if ( self getscriptableparthasstate( "explode", "water" ) )
            {
                explodestate = "water";
            }
        }
        
        self setscriptablepartstate( "explode", explodestate, 0 );
    }
    
    self playsound( "radar_drone_explode" );
    emp_debuff::clear_emp( 1 );
    helper_drone::function_e44894e06827a3a9();
    emp_debuff::allow_emp( 0 );
    self notify( #"explode" );
    wait 0.2;
    ob_recon_drone_remove( self.helperdronetype, wasdestroyed );
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x6246bb57, Offset: 0x4b93
// Size: 0x17d
function ob_recon_drone_remove( dronetype, wasdestroyed, dronevel, dronehealth )
{
    if ( isdefined( self.radar ) )
    {
        self.radar delete();
    }
    
    self.ispiloted = undefined;
    self.repeatuse = undefined;
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    if ( isdefined( self.scrambler ) )
    {
        self.scrambler delete();
    }
    
    if ( isdefined( self.enemyobjid ) )
    {
        objidpoolmanager::returnobjectiveid( self.enemyobjid );
    }
    
    if ( isdefined( self.pulsedarts ) && self.pulsedarts.size > 0 )
    {
        foreach ( pulsedart in self.pulsedarts )
        {
            pulsedart notify( #"death" );
        }
    }
    
    level.supportdrones = arrayremove( level.supportdrones, self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x79ca2e94, Offset: 0x4d18
// Size: 0x76
function ob_recon_drone_think( activityinstance )
{
    if ( isdefined( activityinstance ) )
    {
        activityinstance endon( #"activity_ended" );
    }
    
    if ( isdefined( self.vehicle_spawner ) && isdefined( self.vehicle_spawner.target ) )
    {
        first_node = utility::getstruct( self.vehicle_spawner.target, "targetname" );
        vehicle_paths::vehicle_paths_helicopter( first_node );
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x24422ad0, Offset: 0x4d96
// Size: 0xe9
function function_ca55b3bef5c1dab0( drone )
{
    self endon( #"disconnect" );
    var_f6c9f5d37536a34f = 2547216;
    
    while ( true )
    {
        var_5685cc7b82b0c7fb = 0;
        
        if ( !isdefined( drone ) || !player::isreallyalive() )
        {
            var_5685cc7b82b0c7fb = 1;
        }
        else if ( drone.isdestroyed )
        {
            var_5685cc7b82b0c7fb = 1;
        }
        else
        {
            distancechecksq = distancesquared( drone.origin, self.origin );
            
            if ( distancechecksq > var_f6c9f5d37536a34f )
            {
                var_5685cc7b82b0c7fb = 1;
            }
            
            /#
                if ( getdvarint( @"hash_f4f53baf41c812ab", 0 ) )
                {
                    level thread debug::drawsphere( drone.origin, 1596, 0.5, ( 1, 0, 0 ) );
                }
            #/
        }
        
        if ( var_5685cc7b82b0c7fb )
        {
            emp_debuff::stop_scramble( 5, 0 );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace ob_soldier_util
// Params 0
// Checksum 0x63a52f2b, Offset: 0x4e87
// Size: 0x1ec
function function_462af03ab2d66440()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    self endon( #"hash_ee1f68bd0482b52d" );
    skipteamcheck = 1;
    self.var_54b9b80a3d6bdb93 = 1536;
    self.var_1cc33a06670dae36 = [];
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_f4f53baf41c812ab", 0 ) )
            {
                level thread debug::drawsphere( self.origin, 1536, 0.5, ( 0, 1, 0 ) );
            }
        #/
        
        var_6196e49a0c68d478 = utility::playersinsphere( self.origin, 1536 );
        
        foreach ( var_c43d879734cad63a in var_6196e49a0c68d478 )
        {
            isimmune = isdefined( var_c43d879734cad63a.perks[ "specialty_scrambler_resist" ] );
            
            if ( isdefined( var_c43d879734cad63a ) )
            {
                if ( var_c43d879734cad63a player::isreallyalive() && !isimmune )
                {
                    if ( var_c43d879734cad63a utility::isusingremote() )
                    {
                        continue;
                    }
                    
                    if ( self.isdestroyed )
                    {
                        continue;
                    }
                    
                    if ( var_c43d879734cad63a emp_debuff::function_67d03d9afb12016d( 5, 0 ) )
                    {
                        continue;
                    }
                    
                    var_c43d879734cad63a emp_debuff::play_scramble( 5, 0 );
                    var_c43d879734cad63a thread function_ca55b3bef5c1dab0( self );
                    continue;
                }
                
                if ( isdefined( var_c43d879734cad63a.scrambledby ) && var_c43d879734cad63a.scrambledby.size > 0 && arraycontains( var_c43d879734cad63a.scrambledby, self ) )
                {
                    var_c43d879734cad63a notify( "scramble_off" + self getentitynumber() );
                }
            }
        }
        
        wait 0.5;
    }
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0xb12f1c7c, Offset: 0x507b
    // Size: 0x5, Type: dev
    function function_431e4600f98c6a9e()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 4
// Checksum 0xf9c1b03d, Offset: 0x5088
// Size: 0x124
function ob_cluster_bomb( var_e942036a8c5d73e6, bomb_radius, var_77018ea10fa8dc22, bomb_clearance )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    
    if ( !isdefined( bomb_radius ) )
    {
        bomb_radius = 384;
    }
    
    if ( !isdefined( var_77018ea10fa8dc22 ) )
    {
        var_77018ea10fa8dc22 = 3;
    }
    
    if ( !isdefined( bomb_clearance ) )
    {
        bomb_clearance = 96;
    }
    
    var_190b007ac2e975df = function_6729d90b06ef5283( var_e942036a8c5d73e6 );
    var_37682a1bf0164102 = function_3337d91459593fbd( bomb_radius, var_77018ea10fa8dc22, bomb_clearance, "inner", var_190b007ac2e975df, var_e942036a8c5d73e6 );
    
    if ( var_37682a1bf0164102.size > 0 )
    {
        foreach ( var_626aaf1c6856ad8a in var_37682a1bf0164102 )
        {
            level thread function_accbd4e006622a18( var_190b007ac2e975df, var_e942036a8c5d73e6 + var_626aaf1c6856ad8a );
            wait randomfloatrange( 0.5, 1.5 );
        }
        
        return;
    }
    
    iprintln( "CLUSTER BOMB cancelled - could not find good offset points" );
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x673e1509, Offset: 0x51b4
// Size: 0xca
function function_6729d90b06ef5283( var_e942036a8c5d73e6 )
{
    var_ebb55cdd27aef600 = 0;
    var_190b007ac2e975df = undefined;
    heightent = namespace_9d8e359c3b1041e5::getkillstreakairstrikeheightentsharedfunc();
    heightoffset = 10000;
    
    if ( isdefined( heightent ) )
    {
        heightoffset = heightent.origin[ 2 ] + 4000;
    }
    
    missileoffset = var_e942036a8c5d73e6 + ( 0, 0, heightoffset );
    
    while ( var_ebb55cdd27aef600 < 360 )
    {
        forwardvector = anglestoforward( ( 0, var_ebb55cdd27aef600, 0 ) );
        var_190b007ac2e975df = missileoffset - forwardvector * 3000;
        trace = trace::ray_trace( var_190b007ac2e975df, var_e942036a8c5d73e6 );
        
        if ( trace[ "fraction" ] > 0.9 )
        {
            break;
        }
        
        var_ebb55cdd27aef600 += 45;
        wait 0.1;
    }
    
    return var_190b007ac2e975df;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0xd5dc77ab, Offset: 0x5287
// Size: 0x58
function function_accbd4e006622a18( var_190b007ac2e975df, var_9d8312763f2dcc28 )
{
    clusterbomb = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( makeweapon( "hellstorm_cluster_bomb_proj_mp" ), var_190b007ac2e975df, var_9d8312763f2dcc28 );
    clusterbomb waittill( #"death" );
    namespace_9d8e359c3b1041e5::shellshock_artilleryearthquakesharedfunc( var_9d8312763f2dcc28, 1 );
    playsoundatpos( var_9d8312763f2dcc28, "iw9_cruise_missile_exp" );
}

// Namespace ob_soldier_util
// Params 6
// Checksum 0x3629e54f, Offset: 0x52e7
// Size: 0x1ba
function function_3337d91459593fbd( n_radius, var_58e6cf0be8c815ef, n_clearance, var_56f672f6427938fc, var_2950eddd8236c31f, var_dac75f4116c98678 )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    a_v_offset = [];
    
    if ( !isdefined( var_56f672f6427938fc ) )
    {
        var_56f672f6427938fc = "random";
    }
    
    if ( !isdefined( var_2950eddd8236c31f ) )
    {
        var_2950eddd8236c31f = 0;
    }
    
    var_e088a67bc25a8ba6 = undefined;
    
    if ( isdefined( n_clearance ) )
    {
        var_e088a67bc25a8ba6 = n_clearance * n_clearance;
    }
    
    maxtime = var_58e6cf0be8c815ef * 0.5;
    starttime = gettime();
    b_force_negative_x = undefined;
    var_2e02bcb077c2f696 = undefined;
    
    while ( a_v_offset.size < var_58e6cf0be8c815ef )
    {
        elapsedtime = gettime() - starttime;
        
        if ( utility::function_6f5d2e1f1ff70482( elapsedtime ) > maxtime )
        {
            break;
        }
        
        offset_x = ob_offset_dist_calculate( n_radius, var_56f672f6427938fc, b_force_negative_x );
        offset_y = ob_offset_dist_calculate( n_radius, var_56f672f6427938fc, var_2e02bcb077c2f696 );
        
        if ( b_force_negative_x && var_2e02bcb077c2f696 )
        {
            b_force_negative_x = undefined;
            var_2e02bcb077c2f696 = undefined;
        }
        else if ( utility::cointoss() )
        {
            b_force_negative_x = 1;
        }
        else
        {
            var_2e02bcb077c2f696 = 1;
        }
        
        var_884d8fed7da84c19 = ( offset_x, offset_y, 0 );
        var_b04d4bb3040e7c23 = 1;
        
        if ( isdefined( var_e088a67bc25a8ba6 ) && a_v_offset.size > 0 )
        {
            var_b04d4bb3040e7c23 = function_fafc68edddc0c63d( var_884d8fed7da84c19, a_v_offset, var_e088a67bc25a8ba6 );
        }
        
        if ( isvector( var_2950eddd8236c31f ) )
        {
            var_53493947f16cff07 = var_2950eddd8236c31f;
            var_b04d4bb3040e7c23 = function_2c830e551367c364( var_884d8fed7da84c19 + var_dac75f4116c98678, var_53493947f16cff07 );
            waitframe();
        }
        else if ( var_2950eddd8236c31f )
        {
            var_b04d4bb3040e7c23 = function_2c830e551367c364( var_884d8fed7da84c19 + var_dac75f4116c98678 );
            waitframe();
        }
        
        if ( var_b04d4bb3040e7c23 )
        {
            a_v_offset[ a_v_offset.size ] = var_884d8fed7da84c19;
        }
        
        waitframe();
    }
    
    return a_v_offset;
}

// Namespace ob_soldier_util
// Params 3
// Checksum 0x251cea20, Offset: 0x54aa
// Size: 0xb1
function ob_offset_dist_calculate( n_radius, var_56f672f6427938fc, b_force_negative )
{
    if ( var_56f672f6427938fc == "inner" )
    {
        rand = randomfloatrange( 0, 1 );
        dist = squared( rand ) * n_radius;
    }
    else if ( var_56f672f6427938fc == "outer" )
    {
        rand = randomfloatrange( 0, 1 );
        var_95f52fcb97cf9e1c = squared( rand ) * n_radius;
        dist = n_radius - var_95f52fcb97cf9e1c;
    }
    else
    {
        dist = randomfloatrange( 0, n_radius );
    }
    
    if ( b_force_negative )
    {
        dist *= -1;
    }
    else
    {
        dist = utility::cointoss() ? dist * -1 : dist;
    }
    
    return dist;
}

// Namespace ob_soldier_util
// Params 3
// Checksum 0x51042647, Offset: 0x5564
// Size: 0x98, Type: bool
function function_fafc68edddc0c63d( var_884d8fed7da84c19, a_v_offset, var_e088a67bc25a8ba6 )
{
    foreach ( v_offset in a_v_offset )
    {
        if ( distance2dsquared( v_offset, var_884d8fed7da84c19 ) > var_e088a67bc25a8ba6 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0xbdeba94c, Offset: 0x5605
// Size: 0x55, Type: bool
function function_2c830e551367c364( var_884d8fed7da84c19, var_53493947f16cff07 = var_884d8fed7da84c19 + ( 0, 0, 6000 ) )
{
    trace = trace::ray_trace( var_53493947f16cff07, var_884d8fed7da84c19 );
    
    if ( trace[ "fraction" ] > 0.9 )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0x56aee6fb, Offset: 0x5663
    // Size: 0x5, Type: dev
    function function_89088b7284c7c5a1()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 5
// Checksum 0x9627c2cf, Offset: 0x5670
// Size: 0x1c5
function function_8a94693d3982533a( var_b913626616dfde9a, var_de835b7258198d29, var_341251d96e947a6c, var_4987b1ca3131a617, yaw )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    
    if ( !isdefined( var_de835b7258198d29 ) )
    {
        var_de835b7258198d29 = "precision_airstrike";
    }
    
    if ( !isdefined( var_4987b1ca3131a617 ) )
    {
        var_4987b1ca3131a617 = 1;
    }
    
    if ( var_de835b7258198d29 == "quest_airstrike" )
    {
        var_de835b7258198d29 = "fuel_airstrike";
    }
    else if ( var_de835b7258198d29 != "multi_airstrike" || !isdefined( var_341251d96e947a6c ) )
    {
        var_341251d96e947a6c = 2;
    }
    
    streakinfo = spawnstruct();
    streakinfo.streakname = var_de835b7258198d29;
    
    if ( !isdefined( streakinfo.shots_fired ) )
    {
        streakinfo.shots_fired = 0;
    }
    
    level.airstrikesettings[ streakinfo.streakname ].modelbase = "veh8_mil_air_alfa10_east";
    streakinfo.owner = level.players[ 0 ];
    animname = level.scr_anim[ streakinfo.streakname ][ "airstrike_flyby" ];
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_1023ac40d440ec3d" ) )
    {
        streakinfo.owner [[ utility::getsharedfunc( #"killstreak", #"hash_1023ac40d440ec3d" ) ]]( var_b913626616dfde9a, 1000, streakinfo.streakname );
    }
    
    /#
        iprintlnbold( "<dev string:x82>" );
    #/
    
    for ( i = 0; i < var_341251d96e947a6c ; i++ )
    {
        level thread ob_airstrike_callstrike( streakinfo.owner, var_b913626616dfde9a, yaw, undefined, streakinfo, animname, undefined, var_4987b1ca3131a617 );
        wait randomfloatrange( 2, 4 );
    }
}

// Namespace ob_soldier_util
// Params 8
// Checksum 0x6914a006, Offset: 0x583d
// Size: 0x1db
function ob_airstrike_callstrike( owner, coord, yaw, targetmarker, streakinfo, animname, airstrikeid, var_4987b1ca3131a617 )
{
    var_52a7c56f48361b92 = 0;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 24000;
    planeflyspeed = 6500;
    planeflyheight = 2500;
    var_52a7c56f48361b92 = 1500;
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = heightent.origin[ 2 ];
    }
    
    /#
        var_2672c681761eb965 = getdvarint( @"hash_698613e6c8c52243", 0 );
        planeflyheight += var_2672c681761eb965;
    #/
    
    var_52a7c56f48361b92 = airstrike::getexplodedistance( planeflyheight );
    direction = undefined;
    var_2df14d15022f74fc = undefined;
    
    if ( isdefined( yaw ) )
    {
        direction = ( 0, yaw, 0 );
    }
    else
    {
        direction = airstrike::callstrike_findoptimaldirection( owner, coord, planeflyheight, planehalfdistance );
        var_2df14d15022f74fc = 1;
    }
    
    flightpath = airstrike::getflightpath( coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_52a7c56f48361b92, streakinfo.streakname, var_2df14d15022f74fc );
    
    if ( streakinfo.streakname == "precision_airstrike" )
    {
        for ( i = 0; i < 2 ; i++ )
        {
            planeflyheight += randomintrange( 200, 300 );
            level thread function_2394b6f79efb3bc6( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_4987b1ca3131a617 );
            wait 3;
        }
        
        return;
    }
    
    if ( streakinfo.streakname == "multi_airstrike" )
    {
        planeflyheight += randomintrange( 200, 300 );
    }
    
    level thread function_2394b6f79efb3bc6( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_4987b1ca3131a617 );
}

// Namespace ob_soldier_util
// Params 10
// Checksum 0x64364b14, Offset: 0x5a20
// Size: 0x6ca
function function_2394b6f79efb3bc6( targetsite, var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_4987b1ca3131a617 )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    config = level.airstrikesettings[ streakinfo.streakname ];
    strikeanimlength = getanimlength( animname );
    var_4b1088f3f528603 = utility::get_notetrack_time( animname, "attack" );
    planestartpos = targetsite + ( 0, 0, planeflyheight );
    var_aa3618dd78b3981d = vectortoangles( var_4c67c7deb1a274ee - var_bbcd7c6de5c8f8b );
    planemodel = config.modelbase;
    
    if ( player_utility::getplayersuperfaction( owner ) && isdefined( config.modelbasealt ) )
    {
        planemodel = config.modelbasealt;
    }
    
    plane = spawn( "script_model", planestartpos );
    plane setmodel( planemodel );
    plane.angles = var_aa3618dd78b3981d;
    plane.flightdir = anglestoforward( var_aa3618dd78b3981d );
    plane.flightheight = planeflyheight;
    plane.owner = owner;
    var_c23b5f05a73e9de6 = level.isx1ops && level.var_eceaa6f2cd8bf1df == 6;
    plane.team = "team_hundred_ninety";
    plane.lifeid = streakinfo.lifeid;
    plane.streakinfo = streakinfo;
    plane.airstrikeid = airstrikeid;
    plane setotherent( owner );
    plane scriptmoveroutline();
    plane scriptmoverthermal();
    plane scriptmoverplane();
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        plane [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    if ( utility::issharedfuncdefined( #"br", #"challengeevaluator" ) )
    {
        paramstruct = spawnstruct();
        paramstruct.plane = plane;
        paramstruct.targetsite = targetsite;
        owner [[ utility::getsharedfunc( #"br", #"challengeevaluator" ) ]]( "br_mastery_pointBlank_airstrike", paramstruct );
    }
    
    planeicon = "icon_minimap_airstrike";
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        planeicon = "icon_minimap_fuelairstrike";
    }
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        plane.minimapid = plane [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( planeicon, plane.team, undefined, 1, 1 );
    }
    
    var_74793eabc3f75fc = var_4b1088f3f528603 - 0.75;
    var_9daf341a437915da = 0.05;
    var_9de01f1a43af76e8 = var_74793eabc3f75fc;
    var_9ac627c2a5aa0173 = 8.596;
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        var_74793eabc3f75fc = var_4b1088f3f528603 + 1;
    }
    
    var_1cc3597535367267 = config.var_a9893cd64762fe63;
    
    if ( !isdefined( var_1cc3597535367267 ) )
    {
        var_1cc3597535367267 = "ks_airstrike_mp";
    }
    
    plane thread airstrike::airstrike_delayplayscriptable( 0.05 );
    level thread airstrike::airstrike_playplaneattackfx( plane, var_74793eabc3f75fc, streakinfo );
    level thread airstrike::airstrike_playflyfx( plane, var_1cc3597535367267, var_bbcd7c6de5c8f8b, anglestoforward( var_aa3618dd78b3981d ), var_9daf341a437915da, var_9de01f1a43af76e8, var_9ac627c2a5aa0173, strikeanimlength, streakinfo );
    plane.bulletpoint = spawn( "script_model", plane.origin );
    var_556918420205e8e4 = "ks_airstrike_target_mp";
    
    if ( var_4987b1ca3131a617 )
    {
        var_556918420205e8e4 = "ks_airstrike_target_ob_ai";
    }
    
    plane.bulletpoint setmodel( var_556918420205e8e4 );
    plane.bulletpoint setentityowner( owner );
    plane.bulletpoint.weapon_name = "artillery_mp";
    plane.bulletpoint.streakinfo = streakinfo;
    plane.bulletpoint.angles = plane.angles;
    plane.bulletpoint dontinterpolate();
    plane.animname = streakinfo.streakname;
    plane animation::setanimtree();
    plane.scenenode = spawn( "script_model", planestartpos );
    plane.scenenode.angles = plane.angles;
    plane.scenenode setmodel( "tag_origin" );
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            plane thread airstrike::debugairstrikeline( var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, ( 1, 1, 1 ), 20 );
            plane thread airstrike::function_bc7388025d453a4e( planeflyheight, targetsite );
        }
    #/
    
    if ( streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "multi_airstrike" )
    {
        level thread airstrike::callstrike_precisionbulleteffect( plane, var_74793eabc3f75fc, strikeanimlength, targetsite, owner );
    }
    else if ( streakinfo.streakname == "fuel_airstrike" )
    {
        level thread function_a71f9b27299d81d2( plane, var_74793eabc3f75fc, strikeanimlength, targetsite, owner );
    }
    
    plane.scenenode animation::anim_single_solo( plane, "airstrike_flyby" );
    
    if ( isdefined( plane.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( plane.minimapid );
        }
    }
    
    plane notify( #"delete" );
    
    if ( isdefined( plane.turrettarget ) )
    {
        plane.turrettarget delete();
    }
    
    if ( isdefined( plane.bulletpoint ) )
    {
        plane.bulletpoint delete();
        
        if ( isdefined( plane.bulletpoint.killcament ) )
        {
            plane.bulletpoint.killcament delete();
        }
    }
    
    if ( isdefined( plane.scenenode ) )
    {
        plane.scenenode delete();
    }
    
    if ( isdefined( plane ) )
    {
        plane delete();
    }
}

// Namespace ob_soldier_util
// Params 5
// Checksum 0x40599675, Offset: 0x60f2
// Size: 0x4f7
function function_a71f9b27299d81d2( plane, launchtime, strikelength, damagepos, owner )
{
    plane endon( #"death" );
    planedir = plane.flightdir;
    camdamagepos = damagepos + ( 0, 0, plane.flightheight + 750 );
    killcamstartpos = camdamagepos - planedir * 15000;
    killcamendpos = camdamagepos - planedir * 1000;
    var_2c466f277f13f9b4 = camdamagepos - planedir * 500;
    var_774404a87d1a22d6 = level.isx1ops && level.var_eceaa6f2cd8bf1df == 6;
    killcament = undefined;
    
    if ( !var_774404a87d1a22d6 )
    {
        killcament = spawn( "script_model", killcamstartpos );
        killcament thread airstrike::airstrike_killcammove( launchtime - 3, killcamendpos, var_2c466f277f13f9b4 );
    }
    
    hostmigration::waitlongdurationwithpause( launchtime );
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"airstrike", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_39046aa32b2153cf", damagepos, owner.team, owner );
    }
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            sphere( damagepos, 100, ( 1, 1, 1 ), 0, 500 );
        }
    #/
    
    bombtracestart = damagepos + ( 0, 0, 2500 );
    bombtraceend = damagepos - ( 0, 0, 10000 );
    bombtrace = trace::ray_trace( bombtracestart, bombtraceend, undefined, trace::create_contents( 0, 1, 0, 1, 0, 1, 0 ) );
    var_82dbd83cc5863e44 = bombtrace[ "position" ];
    bombtracenormal = bombtrace[ "normal" ];
    bombhitpos = var_82dbd83cc5863e44 + bombtracenormal * 10;
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            line( bombtracestart, bombhitpos, ( 1, 0, 0 ), 1, 0, 1000 );
            line( bombhitpos, bombhitpos + bombtracenormal * 50, ( 0, 1, 0 ), 1, 0, 500 );
            sphere( bombhitpos, 50, ( 1, 0, 0 ), 0, 500 );
        }
    #/
    
    var_646306ff4db410f2 = bombhitpos + ( 0, 0, 800 );
    var_a42b9910c9af253c = spawn( "script_model", var_646306ff4db410f2 );
    var_a42b9910c9af253c.angles = plane.angles;
    var_a42b9910c9af253c.streakinfo = plane.streakinfo;
    var_a42b9910c9af253c setmodel( "ks_fuelstrike_mp" );
    var_a42b9910c9af253c setentityowner( owner );
    
    if ( !var_774404a87d1a22d6 )
    {
        var_a42b9910c9af253c.killcament = killcament;
    }
    
    var_31ac5feb767f50eb = spawn( "script_model", bombhitpos );
    var_31ac5feb767f50eb.angles = plane.angles;
    var_31ac5feb767f50eb.streakinfo = plane.streakinfo;
    var_31ac5feb767f50eb setmodel( "ks_fuelstrike_mp" );
    var_31ac5feb767f50eb setentityowner( owner );
    
    if ( !var_774404a87d1a22d6 )
    {
        var_31ac5feb767f50eb.killcament = killcament;
    }
    
    var_31ac5feb767f50eb setscriptablepartstate( "releaseVFX", "on", 0 );
    var_a42b9910c9af253c setscriptablepartstate( "releaseSFX", "on", 0 );
    wait 1.3;
    var_31ac5feb767f50eb setscriptablepartstate( "explode", "on", 0 );
    var_847f780b10d918e5 = [ var_a42b9910c9af253c, var_31ac5feb767f50eb ];
    var_1fb686143fa771fc = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 1, 0 );
    var_95c1a2ad31be6066 = airstrike::function_1748d90909e99da4( bombhitpos, 750, owner, var_646306ff4db410f2, var_847f780b10d918e5, var_1fb686143fa771fc );
    bombweapon = makeweapon( "fuelstrike_proj_mp" );
    bombexplodedelay = 0.8;
    plane thread airstrike::function_41722228ebb55980( var_a42b9910c9af253c, var_31ac5feb767f50eb, bombexplodedelay );
    level notify( #"airstrike_explode" );
    
    /#
        owner thread airstrike::function_86996cb4cc276740( bombexplodedelay, var_31ac5feb767f50eb );
    #/
    
    foreach ( enemy in var_95c1a2ad31be6066 )
    {
        enemy thread airstrike::function_83813bbfeb81f148( owner, bombexplodedelay, var_a42b9910c9af253c, var_31ac5feb767f50eb, bombweapon );
        enemy thread function_8db988758e28011a( 90, var_31ac5feb767f50eb.origin, owner, var_31ac5feb767f50eb, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay );
    }
    
    level thread airstrike::delaydeletefxents( var_a42b9910c9af253c, var_31ac5feb767f50eb );
}

// Namespace ob_soldier_util
// Params 7
// Checksum 0x4699b498, Offset: 0x65f1
// Size: 0x84
function function_8db988758e28011a( damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon, bombexplodedelay )
{
    self endon( #"death_or_disconnect" );
    
    if ( bombexplodedelay > 0 )
    {
        wait bombexplodedelay;
    }
    
    if ( isdefined( level.quest_airstrike ) )
    {
        self dodamage( damageamount, damageorigin, self, inflictor, meansofdeath, weapon );
        return;
    }
    
    self dodamage( damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon );
}

/#

    // Namespace ob_soldier_util
    // Params 0
    // Checksum 0xc295b8db, Offset: 0x667d
    // Size: 0x5, Type: dev
    function function_b0a99c1a6ea7c7d9()
    {
        
    }

#/

// Namespace ob_soldier_util
// Params 2
// Checksum 0x69521f77, Offset: 0x668a
// Size: 0x42
function function_a315cc5d1dee425a( var_ffa9ec4fe50962c4, var_f2e5e4db54322ef6 )
{
    var_9619e4874be30e30 = utility::getstructarray( var_ffa9ec4fe50962c4, "targetname" );
    
    if ( var_9619e4874be30e30.size == 0 )
    {
        return var_9619e4874be30e30;
    }
    
    return function_ae8fc52786f384b7( var_9619e4874be30e30, var_f2e5e4db54322ef6 );
}

// Namespace ob_soldier_util
// Params 2
// Checksum 0xf4d023a6, Offset: 0x66d5
// Size: 0x96
function function_ae8fc52786f384b7( var_9619e4874be30e30, var_f2e5e4db54322ef6 )
{
    if ( isdefined( var_f2e5e4db54322ef6 ) )
    {
        var_f2e5e4db54322ef6 = int( min( var_f2e5e4db54322ef6, var_9619e4874be30e30.size ) );
        
        if ( var_f2e5e4db54322ef6 < var_9619e4874be30e30.size )
        {
            var_9619e4874be30e30 = arrayrandomize( var_9619e4874be30e30 );
            var_9619e4874be30e30 = utility::array_slice( var_9619e4874be30e30, 0, var_f2e5e4db54322ef6 );
        }
    }
    
    for ( index = 0; index < var_9619e4874be30e30.size ; index++ )
    {
        cover = var_9619e4874be30e30[ index ];
        
        if ( isdefined( cover.target ) )
        {
            level thread function_54226cc37af388d9( cover );
        }
        
        if ( index % 3 == 0 )
        {
            waitframe();
        }
    }
    
    return var_9619e4874be30e30;
}

// Namespace ob_soldier_util
// Params 1, eflags: 0x4
// Checksum 0x95d62b3b, Offset: 0x6774
// Size: 0x1ea
function private function_54226cc37af388d9( cover )
{
    cover endon( #"cover_disabled" );
    scriptables = getentitylessscriptablearray( cover.target, #targetname, cover.origin, 256 );
    
    if ( scriptables )
    {
        cover.scriptables = scriptables;
        
        foreach ( scriptable in cover.scriptables )
        {
            /#
                var_5f1b6f35404cfe9 = getdvar( @"scr_prof_cover", "<dev string:xa3>" );
                
                if ( var_5f1b6f35404cfe9 != "<dev string:xa3>" )
                {
                    if ( scriptable.type == var_5f1b6f35404cfe9 )
                    {
                        setdvar( @"hash_920b6d74426fbff3", 1 );
                    }
                    else
                    {
                        return;
                    }
                }
            #/
            
            throttle::throttle_wait_in_queue( level.ob_toggleable_cover_throttle, { #scriptable:scriptable } );
            scriptable setscriptablepartstate( "state", "visible" );
        }
    }
    
    var_c9a0a74c82ecb52e = 1;
    
    if ( cover.script_parameters == "no_nodes" )
    {
        var_c9a0a74c82ecb52e = 0;
    }
    
    if ( var_c9a0a74c82ecb52e )
    {
        waitframe();
        cover.var_b2f8e5c576d3e25f = function_b22d6720e2975ea( cover.target, cover.origin, 256 );
        
        if ( isarray( cover.var_b2f8e5c576d3e25f ) && cover.var_b2f8e5c576d3e25f.size > 0 )
        {
            cover childthread function_447f30a1ac8c64d4();
        }
    }
    
    if ( cover.script_noteworthy == "ladder" )
    {
        function_bf3aa4e33d38db6c( cover, 1 );
    }
}

// Namespace ob_soldier_util
// Params 0, eflags: 0x4
// Checksum 0xb64950d8, Offset: 0x6966
// Size: 0xd0
function private hide_watch_tower_clip()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    brush_ent_array = getentarray( "watch_tower_clip", #script_noteworthy );
    
    foreach ( brush_ent in brush_ent_array )
    {
        brush_ent.dock_origin = brush_ent.origin;
        brush_ent.origin = brush_ent.dock_origin + ( 0, 0, -1024 );
    }
}

// Namespace ob_soldier_util
// Params 2, eflags: 0x4
// Checksum 0x4a3cbb0f, Offset: 0x6a3e
// Size: 0x4fa
function private function_bf3aa4e33d38db6c( cover_struct, enable )
{
    if ( !cover_struct.moving_platforms )
    {
        cover_struct.moving_platforms = [];
        brush_ent_array = getentarrayinradius( cover_struct.target, #targetname, cover_struct.origin, 1536 );
        
        foreach ( brush_ent in brush_ent_array )
        {
            if ( brush_ent.script_noteworthy == "watch_tower_clip" )
            {
                cover_struct.moving_platforms[ cover_struct.moving_platforms.size ] = brush_ent;
            }
        }
    }
    
    foreach ( brush_ent in cover_struct.moving_platforms )
    {
        if ( enable )
        {
            brush_ent.origin = brush_ent.dock_origin ?? brush_ent.origin;
            
            if ( !brush_ent.docked )
            {
                brush_ent dockmovingplatform();
                brush_ent.docked = 1;
            }
            
            if ( brush_ent.target )
            {
                if ( !brush_ent.traversal_nodes )
                {
                    brush_ent.traversal_nodes = [];
                    nearby_nodes = getnodesinradius( cover_struct.origin, 512, 0 );
                    
                    if ( nearby_nodes.size > 0 )
                    {
                        nodes = function_ca0b19e81ba1e683( brush_ent.target, nearby_nodes );
                        
                        for ( i = 0; i < nodes.size ; i++ )
                        {
                            node = nodes[ i ];
                            node.var_3c71ccab0e77ef30 = "link_" + brush_ent getentitynumber() + "_" + i;
                            var_c5e5e64ab6104d4d = function_ca0b19e81ba1e683( node.target, nearby_nodes );
                            assert( var_c5e5e64ab6104d4d.size <= 1, "<dev string:xa4>" + cover_struct.targetname + "<dev string:xd8>" + node.origin + "<dev string:xe3>" + var_c5e5e64ab6104d4d.size );
                            
                            if ( var_c5e5e64ab6104d4d.size )
                            {
                                node.target_node = var_c5e5e64ab6104d4d[ 0 ];
                            }
                            else
                            {
                                node.target_node = getnode( node.target, #targetname );
                            }
                            
                            if ( node.target_node )
                            {
                                var_f44494c1dfdefeb8 = 133;
                                createnavlink( node.var_3c71ccab0e77ef30, node.origin, node.target_node.origin, node, var_f44494c1dfdefeb8, 1, undefined, node.target_node );
                                brush_ent.traversal_nodes[ brush_ent.traversal_nodes.size ] = node;
                                continue;
                            }
                            
                            script::demoforcesre( "[Dynamic Watch Tower] Missing target node! cover:" + cover_struct.targetname + " location:" + node.origin + " target:" + node.target );
                        }
                    }
                }
                else
                {
                    foreach ( node in brush_ent.traversal_nodes )
                    {
                        function_30dc1efdafe7681e( node, 1 );
                    }
                }
            }
            
            continue;
        }
        
        if ( brush_ent.traversal_nodes )
        {
            foreach ( node in brush_ent.traversal_nodes )
            {
                function_30dc1efdafe7681e( node, 0 );
            }
        }
        
        if ( brush_ent.docked )
        {
            brush_ent undockmovingplatform( 0 );
            brush_ent.docked = 0;
        }
        
        if ( brush_ent.dock_origin )
        {
            brush_ent.origin = brush_ent.dock_origin + ( 0, 0, -1024 );
        }
    }
}

// Namespace ob_soldier_util
// Params 4
// Checksum 0x3d062084, Offset: 0x6f40
// Size: 0x4c
function function_b22d6720e2975ea( targetname, origin, max_radius, min_radius = 0 )
{
    nodes = getnodesinradius( origin, max_radius, min_radius );
    return function_ca0b19e81ba1e683( targetname, nodes );
}

// Namespace ob_soldier_util
// Params 2, eflags: 0x4
// Checksum 0xdeb38e93, Offset: 0x6f95
// Size: 0xa3
function private function_ca0b19e81ba1e683( targetname, nodes )
{
    result = [];
    
    foreach ( node in nodes )
    {
        if ( node.targetname == targetname )
        {
            result[ result.size ] = node;
        }
    }
    
    return result;
}

// Namespace ob_soldier_util
// Params 0, eflags: 0x4
// Checksum 0xc117570a, Offset: 0x7041
// Size: 0x7a
function private function_447f30a1ac8c64d4()
{
    waitframe();
    
    foreach ( cover_node in self.var_b2f8e5c576d3e25f )
    {
        cover_node connectnode();
    }
}

// Namespace ob_soldier_util
// Params 0, eflags: 0x4
// Checksum 0x2c6a886a, Offset: 0x70c3
// Size: 0x166
function private function_c440d151ed6da7b5()
{
    waitframe();
    self.var_b2f8e5c576d3e25f = [];
    nodes_to_spawn = [];
    
    if ( isdefined( self.script_label ) )
    {
        nodes_to_spawn = function_86233dc6785b3842( self.script_label );
    }
    else if ( isdefined( self.scriptable ) )
    {
        nodes_to_spawn = function_86233dc6785b3842( self.scriptable.model );
    }
    
    foreach ( data in nodes_to_spawn )
    {
        if ( !isdefined( self.angles ) )
        {
            self.angles = ( 0, 0, 0 );
        }
        
        var_12ef0eb32b573cf1 = coordtransform( data[ 0 ], self.origin, self.angles );
        var_bf3e21e5d4373139 = self.angles + data[ 1 ];
        var_4a1ac098d5898640 = spawncovernode( var_12ef0eb32b573cf1, var_bf3e21e5d4373139, data[ 2 ] );
        
        if ( isdefined( var_4a1ac098d5898640 ) )
        {
            var_4a1ac098d5898640 connectnode();
            self.var_b2f8e5c576d3e25f = arraycombineunique( self.var_b2f8e5c576d3e25f, [ var_4a1ac098d5898640 ] );
        }
    }
}

// Namespace ob_soldier_util
// Params 1
// Checksum 0x79c4fb6d, Offset: 0x7231
// Size: 0xb3
function function_3604220db3a0a0cf( cover )
{
    var_e95f452a1eda7f89 = [];
    
    if ( isstring( cover ) )
    {
        var_e95f452a1eda7f89 = utility::getstructarray( cover, "targetname" );
    }
    
    if ( isarray( cover ) )
    {
        var_e95f452a1eda7f89 = cover;
    }
    else
    {
        return;
    }
    
    foreach ( struct in var_e95f452a1eda7f89 )
    {
        level thread function_3bdf9eabe8d2f13c( struct );
    }
}

// Namespace ob_soldier_util
// Params 1, eflags: 0x4
// Checksum 0xcb3feadf, Offset: 0x72ec
// Size: 0x194
function private function_3bdf9eabe8d2f13c( cover_struct )
{
    cover_struct notify( #"cover_disabled" );
    
    if ( isdefined( cover_struct.scriptables ) )
    {
        foreach ( scriptable in cover_struct.scriptables )
        {
            throttle::throttle_wait_in_queue( level.ob_toggleable_cover_throttle, { #scriptable:scriptable } );
            scriptable setscriptablepartstate( "state", "hidden" );
            
            if ( scriptable getscriptablehaspart( "vfx" ) )
            {
                scriptable setscriptablepartstate( "vfx", "off" );
            }
        }
    }
    
    if ( isdefined( cover_struct.var_b2f8e5c576d3e25f ) )
    {
        foreach ( var_4a1ac098d5898640 in cover_struct.var_b2f8e5c576d3e25f )
        {
            var_4a1ac098d5898640 disconnectnode();
            
            if ( var_4a1ac098d5898640 isspawnedcovernode() )
            {
                despawncovernode( var_4a1ac098d5898640 );
            }
        }
    }
    
    if ( cover_struct.moving_platforms )
    {
        function_bf3aa4e33d38db6c( cover_struct, 0 );
    }
}

// Namespace ob_soldier_util
// Params 1, eflags: 0x4
// Checksum 0x5e1d4bd9, Offset: 0x7488
// Size: 0x1bdd
function private function_86233dc6785b3842( var_1479f07b528e4ff7 )
{
    nodes_to_spawn = [];
    
    switch ( var_1479f07b528e4ff7 )
    {
        case #"hash_c7e0aaf6e7799aea":
            nodes_to_spawn[ 0 ] = [ ( -20, 28, 16 ), ( 0, 270, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 1 ] = [ ( 20, 28, 16 ), ( 0, 270, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 2 ] = [ ( 20, -28, 16 ), ( 0, 90, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 3 ] = [ ( -20, -28, 16 ), ( 0, 90, 0 ), "Cover Crouch" ];
            break;
        case #"hash_3e533e8173a68e96":
            nodes_to_spawn[ 0 ] = [ ( -34, 0, 16 ), ( 0, 0, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 1 ] = [ ( 0, 34, 16 ), ( 0, 270, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 2 ] = [ ( 34, 0, 16 ), ( 0, 180, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 3 ] = [ ( 0, -34, 16 ), ( 0, 90, 0 ), "Cover Crouch" ];
            break;
        case #"hash_9e5db913883995d":
            nodes_to_spawn[ 0 ] = [ ( 16, 46, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( 46, 16, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -46, 16, 16 ), ( 0, 360, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( 46, -16, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 4 ] = [ ( -16, 46, 16 ), ( 0, 360, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( -46, -16, 16 ), ( 0, 360, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( 16, -46, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 7 ] = [ ( -16, -46, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            break;
        case #"hash_2051917927d8a8fe":
            nodes_to_spawn[ 0 ] = [ ( -40, 0, 16 ), ( 0, 360, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( 40, 0, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( 0, 42, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 0, -44, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            break;
        case #"hash_9f8ac821a3fbb851":
            nodes_to_spawn[ 0 ] = [ ( 16, 48, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( 48, 16, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -48, 16, 16 ), ( 0, 360, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( 48, -16, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 4 ] = [ ( -16, 48, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( -48, -16, 16 ), ( 0, 360, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( 16, -48, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 7 ] = [ ( -16, -48, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            break;
        case #"hash_385896730ddac9b":
            nodes_to_spawn[ 0 ] = [ ( -20, 82, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            nodes_to_spawn[ 1 ] = [ ( 52, 48, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -52, 8, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 20, -86, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 4 ] = [ ( 18, 82, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( -52, -52, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( 52, -52, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 7 ] = [ ( -18, -86, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 8 ] = [ ( 52, -8, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 9 ] = [ ( -52, 48, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            break;
        case #"hash_671b50e68da4e3dc":
            nodes_to_spawn[ 0 ] = [ ( 46, -54, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 1 ] = [ ( -2, -52, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( -46, -54, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( -78, -20, 16 ), ( 0, 360, 0 ), "Cover Right" ];
            nodes_to_spawn[ 4 ] = [ ( -78, 20, 16 ), ( 0, 360, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( -46, 54, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( -2, 52, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 7 ] = [ ( 46, 54, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            break;
        case #"hash_35b74b199651346c":
            nodes_to_spawn[ 0 ] = [ ( -50, 58, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( -50, -58, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            break;
        case #"hash_44f7243fb4c2f7d6":
            nodes_to_spawn[ 0 ] = [ ( 0, -22, 16 ), ( 0, 90, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 1 ] = [ ( 0, 22, 16 ), ( 0, 270, 0 ), "Cover Crouch" ];
            break;
        case #"hash_7d2b4f6c6cb085ac":
            nodes_to_spawn[ 0 ] = [ ( 50, 0, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( 0, -44, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( -50, 0, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 0, 46, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            break;
        case #"hash_df78bf717608a1dd":
            nodes_to_spawn[ 0 ] = [ ( 44, -36, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( 44, 28, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( 14, 60, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( -10, 60, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            nodes_to_spawn[ 4 ] = [ ( -40, 28, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( -40, -36, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( -10, -68, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 7 ] = [ ( 14, -68, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            break;
        case #"hash_d7c559d4de79bc25":
            nodes_to_spawn[ 0 ] = [ ( -34, 16, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( -34, -18, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( 0, -50, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 34, -18, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 34, 16, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 5 ] = [ ( 0, 48, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            break;
        case #"hash_2dbfafe10b0dc6fb":
            nodes_to_spawn[ 0 ] = [ ( -86, 18, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( -86, -16, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -54, -48, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( 10, -32, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 42, -46, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( 74, -14, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 6 ] = [ ( 72, 14, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 7 ] = [ ( 42, 46, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 8 ] = [ ( 10, 34, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 9 ] = [ ( -54, 50, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            break;
        case #"hash_72a2a68ca2987825":
            nodes_to_spawn[ 0 ] = [ ( -42, 36, 16 ), ( 0, 38, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 1 ] = [ ( -26, 2, 16 ), ( 0, 0, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 2 ] = [ ( -40, -36, 16 ), ( 0, 308, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 3 ] = [ ( -2, -66, 16 ), ( 0, 136, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 4 ] = [ ( 24, 2, 16 ), ( 0, 180, 0 ), "Cover Crouch" ];
            nodes_to_spawn[ 5 ] = [ ( 6, 62, 16 ), ( 0, 215, 0 ), "Cover Crouch" ];
            break;
        case #"hash_8db5a88b741a577e":
            nodes_to_spawn[ 0 ] = [ ( -44, 0, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( -16, -40, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 2 ] = [ ( 16, -40, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 3 ] = [ ( 44, 0, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 16, 40, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( -16, 40, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            break;
        case #"hash_abd3702bcd5c566d":
            nodes_to_spawn[ 0 ] = [ ( -32, 0, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( 0, -32, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( 32, 0, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 0, 32, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            break;
        case #"hash_1b9f4f0b9db8b629":
            nodes_to_spawn[ 0 ] = [ ( -98, 16, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( -98, -16, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -60, -50, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 52, -46, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 92, -16, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( 92, 16, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 6 ] = [ ( 50, 52, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 7 ] = [ ( -62, 48, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            break;
        case #"hash_9788f6a3e338ad4e":
            nodes_to_spawn[ 0 ] = [ ( -136, 30, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( -136, -24, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( -102, -60, 16 ), ( 0, 90, 0 ), "Cover Left" ];
            nodes_to_spawn[ 3 ] = [ ( -52, -60, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 96, -60, 16 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( 134, -24, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 6 ] = [ ( 136, 28, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 7 ] = [ ( 100, 64, 16 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 8 ] = [ ( -52, 64, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 9 ] = [ ( -102, 64, 16 ), ( 0, 270, 0 ), "Cover Right" ];
            break;
        case #"hash_7be737f2812cfd50":
            nodes_to_spawn[ 0 ] = [ ( -36, 10, 16 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( -36, -10, 16 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( 0, -40, 16 ), ( 0, 90, 0 ), "Cover Multi" ];
            nodes_to_spawn[ 3 ] = [ ( 34, -10, 16 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 4 ] = [ ( 34, 10, 16 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( 0, 40, 16 ), ( 0, 270, 0 ), "Cover Multi" ];
            break;
        case #"hash_9fc5b4fdb662e731":
            nodes_to_spawn[ 0 ] = [ ( -36, 20, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( -36, -20, 16 ), ( 0, 0, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( 0, -52, 16 ), ( 0, 90, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 34, -20, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 34, 20, 16 ), ( 0, 180, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 5 ] = [ ( 0, 54, 16 ), ( 0, 270, 0 ), "Cover Stand" ];
            break;
        case #"hash_8a7694022d577db7":
            nodes_to_spawn[ 0 ] = [ ( 103, 35, 16 ), ( 0, 269.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 1 ] = [ ( 23, 35, 16 ), ( 0, 269.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 2 ] = [ ( -88, 5, 16 ), ( 0, 290.7, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 103, -26, 16 ), ( 0, 89.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 4 ] = [ ( 19, -26, 16 ), ( 0, 89.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 5 ] = [ ( -25, -36, 16 ), ( 0, 109.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 6 ] = [ ( -89, -60, 16 ), ( 0, 109.2, 0 ), "Cover Stand" ];
            break;
        case #"hash_ad78b884bcd828d2":
            nodes_to_spawn[ 0 ] = [ ( -75, -40, 16 ), ( 0, 359.2, 0 ), "Cover Right" ];
            nodes_to_spawn[ 1 ] = [ ( -59, 32, 16 ), ( 0, 359.2, 0 ), "Cover Left" ];
            nodes_to_spawn[ 2 ] = [ ( -11, 105, 16 ), ( 0, 269.2, 0 ), "Cover Stand" ];
            nodes_to_spawn[ 3 ] = [ ( 59, 31, 16 ), ( 0, 269.2, 0 ), "Cover Right" ];
            nodes_to_spawn[ 4 ] = [ ( 75, -40, 16 ), ( 0, 179.2, 0 ), "Cover Left" ];
            nodes_to_spawn[ 5 ] = [ ( -11, -90, 16 ), ( 0, 89.2, 0 ), "Cover Stand" ];
            break;
        case #"hash_d44cb989edc40ab3":
            nodes_to_spawn[ 0 ] = [ ( 0, 0, 16 ), ( 0, 0, 0 ), "Exposed" ];
        default:
            break;
    }
    
    return nodes_to_spawn;
}

