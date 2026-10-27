// scripts\mp\battlechatter_mp.gsc  (hash_09002e3f894f958f.gscc) (size: 41802 Bytes / 0xa34a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8467121 (2823188769)
// size ...... 41802 (0xa34a)
// includes .. 23  (offset: 0x97a2)
// strings ... 144 (offset: 0x985a)
// dev strs .. 40  (offset: 0xa0fe)
// exports ... 103 (offset: 0x6a92)
// cseg ...... 0xb56 + 0x5f3c (0x6a92)
// imports ... 225 (offset: 0x7aaa)
// animtree1 . 0   (offset: 0xa34a)
// animtree2 . 0   (offset: 0xa34a)
#using scripts\common\bcs_location_trigs;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\math;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_trigs;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace battlechatter_mp;

// Namespace battlechatter_mp
// Params 0
// Checksum 0x7f560f11, Offset: 0xb74
// Size: 0x47d
function init()
{
    level.battlechatterenabled = getdvarint( @"hash_7bdf6d033065ef17", 1 ) == 1;
    friendlydist = getdvarint( @"hash_fc4b1a7d66dbeb32", 1800 );
    level.var_295625aa04d53bea = friendlydist * friendlydist;
    level.speakers = [];
    level.bcinfo = [];
    level.bcinfo[ "max_wait_time" ] = 1000;
    level.bcinfo[ "soundEventHistory" ] = [];
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    level.var_8a9f018daa280c03 = physics_createcontents( content );
    level.var_49ae01328aba605 = getdvarint( @"hash_18ff5cf36b4045bd", 1 ) && isbrgamemode();
    
    foreach ( teamname in level.teamnamelist )
    {
        level.isteamspeaking[ teamname ] = 0;
        level.speakers[ teamname ] = [];
        level.bcinfo[ "queued" ][ teamname ] = "none";
    }
    
    setupselfvo();
    registerbcsoundtype( #"callout_location", %"callout_location", 1, 1, 10, 10, 0 );
    scriptbundlename = undefined;
    
    if ( isdefined( level.gametypebundle.battlechatterlist ) )
    {
        scriptbundlename = level.gametypebundle.battlechatterlist;
    }
    else if ( isdefined( level.gamemodebundle.battlechatterlist ) )
    {
        scriptbundlename = level.gamemodebundle.battlechatterlist;
    }
    
    if ( !isdefined( game[ #"hash_ef73d373f5eb868e" ] ) )
    {
        if ( isdefined( scriptbundlename ) )
        {
            bundle = getscriptbundle( hashcat( %"hash_1ea8b4cc1ebd1ff5", scriptbundlename ) );
            
            if ( isdefined( bundle ) )
            {
                foreach ( event in bundle.battlechatterevents )
                {
                    function_28c0b45728c50f98( event );
                }
                
                foreach ( event in bundle.pingevents )
                {
                    function_28c0b45728c50f98( event );
                }
                
                game[ #"hash_ef73d373f5eb868e" ] = level.bcinfo;
            }
        }
    }
    else
    {
        level.bcinfo = game[ #"hash_ef73d373f5eb868e" ];
    }
    
    level.func_bcs_location_trigs = &battlechatter_trigs::extra_location_trigger_mapping;
    bcs_location_trigs::bcs_location_trigs_init();
    
    /#
        setdevdvarifuninitialized( @"debug_bcprint", "<dev string:x24>" );
        setdevdvarifuninitialized( @"debug_bcprintdump", "<dev string:x24>" );
        setdevdvarifuninitialized( @"debug_bcprintdumptype", "<dev string:x28>" );
        level thread function_9ab0d0f670002f43();
    #/
    
    if ( isdefined( level.register_battlechatter_custom_func ) )
    {
        [[ level.register_battlechatter_custom_func ]]();
    }
    
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"hash_fa7263897b3164e", &onscoreevent );
    
    if ( !game_utility_mp::runleanthreadmode() || level.var_49ae01328aba605 )
    {
        callback::add( #"reload_start", &reloadcallback );
    }
    
    if ( !level.gametypebundle.var_3bd3d220c74c8b15 )
    {
        callback::add( #"hash_3f03a307b9f6e227", &function_f5bb4562244ff1e5 );
    }
}

/#

    // Namespace battlechatter_mp
    // Params 0, eflags: 0xc
    // Checksum 0xcd75494b, Offset: 0xff9
    // Size: 0x56, Type: dev
    function private function_9ab0d0f670002f43()
    {
        self notify( #"hash_cadae73e2a91484b" );
        self endon( #"hash_cadae73e2a91484b" );
        
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        while ( true )
        {
            level.var_a272e6911c72572d = battlechatter_canprint() || battlechatter_canprintdump();
            wait 1;
        }
    }

#/

// Namespace battlechatter_mp
// Params 1
// Checksum 0xb6d479bf, Offset: 0x1057
// Size: 0xc7
function function_28c0b45728c50f98( event )
{
    if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
    {
        if ( !isdefined( event.conversation ) )
        {
            return;
        }
    }
    else if ( !isdefined( event.soundevent ) )
    {
        return;
    }
    
    eventname = event.eventname;
    event.eventname = undefined;
    
    if ( isdefined( event.timeoutpos ) )
    {
        event.timeoutpos *= 1000;
    }
    
    if ( isdefined( event.timeoutspeaker ) )
    {
        event.timeoutspeaker *= 1000;
    }
    
    level.bcinfo[ eventname ] = event;
}

// Namespace battlechatter_mp
// Params 7
// Checksum 0xda8f030f, Offset: 0x1126
// Size: 0x187
function registerbcsoundtype( soundtype, var_8091abf05e31fb11, priority, chance, timeoutpos, timeoutspeaker, var_82af015320b0af0a )
{
    if ( !isdefined( soundtype ) )
    {
        assertmsg( "<dev string:x2c>" );
        return;
    }
    
    if ( !isdefined( priority ) || priority == 1 )
    {
        priority = undefined;
    }
    
    if ( !isdefined( chance ) || chance == 1 )
    {
        chance = undefined;
    }
    
    if ( !isdefined( timeoutpos ) || timeoutpos == 1 )
    {
        timeoutpos = undefined;
    }
    
    if ( !isdefined( timeoutspeaker ) || timeoutspeaker == 1 )
    {
        timeoutspeaker = undefined;
    }
    
    if ( !isdefined( var_82af015320b0af0a ) || var_82af015320b0af0a == 1 )
    {
        var_82af015320b0af0a = undefined;
    }
    
    if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
    {
        event = { #var_82af015320b0af0a:var_82af015320b0af0a, #timeoutspeaker:timeoutspeaker, #timeoutpos:timeoutpos, #chance:chance, #priority:priority, #conversation:var_8091abf05e31fb11, #eventname:soundtype };
    }
    else
    {
        event = { #var_82af015320b0af0a:var_82af015320b0af0a, #timeoutspeaker:timeoutspeaker, #timeoutpos:timeoutpos, #chance:chance, #priority:priority, #soundevent:var_8091abf05e31fb11, #eventname:soundtype };
    }
    
    function_28c0b45728c50f98( event );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x2edddc9, Offset: 0x12b5
// Size: 0xc8
function onplayerspawned( params )
{
    self.bcinfoqueued = "none";
    self.var_62959c1836eca399 = 0;
    self.recentattackers = [];
    self.bcinfolastsaytimes = [];
    
    if ( level.splitscreen )
    {
        return;
    }
    
    if ( function_7de5f4e57743c8a9() )
    {
        self.bcdisabled = 1;
        return;
    }
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread threatcallouttracking();
        thread onsixfriendlytracking();
        
        if ( self.wassquadspawned && function_fb3633bb3479f698( #"bc_status_inform_on_your_six" ) )
        {
            level thread trysaylocalsound( self, #"bc_status_inform_on_your_six" );
        }
        
        return;
    }
    
    if ( !level.gamemodebundle.var_d51d4d8df4604f76 )
    {
        self.bcdisabled = 1;
    }
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0xd4539c2e, Offset: 0x1385
// Size: 0x30, Type: bool
function function_7de5f4e57743c8a9()
{
    return !level.teambased || level.gametypebundle.disablebattlechatter || level.disablebattlechatter;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x3f4b6f44, Offset: 0x13be
// Size: 0x201
function onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( isdmzgamemode() )
    {
        thread function_b50b1c692cfcc369();
    }
    else if ( level.gamemodebundle.var_994ec3c607ce8beb )
    {
        thread playdeathalias();
    }
    
    if ( !isplayer( attacker ) || player_utility::isfriendly( attacker.team, victim ) )
    {
        return;
    }
    
    if ( params.deathtype != "deathType_normal" || attacker utility::isusingremote() )
    {
        return;
    }
    
    if ( !damage::function_7e3cc32b22322954( params.meansofdeath, params.objweapon ) )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ victim.var_f1883f6e151e0ab.streakname ];
    
    if ( bundle.var_3f2df5bd90ef98a4 == #"hash_d923bce470a00246" )
    {
        if ( !attacker function_2fd0ad6a1fcd1cd2( bundle ) )
        {
            level thread trysaylocalsound( attacker, bundle.var_ac07d1d7714b2770, undefined, undefined, undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( victim.var_a601bb1dab2a2dc8 )
    {
        level thread trysaylocalsound( attacker, #"bc_combat_sleeper_kill", 0.75 );
        return;
    }
    
    wassniper = params.var_d9ca660ba1f38dd0;
    
    if ( level.gamemodebundle.var_32fe8ae978574f3d )
    {
        wassniper = ( gettime() - victim.whizby.var_4cd804d5a20f5070 ) * 0.001 < ( level.gamemodebundle.var_79cbfc54aa1c894c ?? 10 );
    }
    
    if ( wassniper )
    {
        level thread trysaylocalsound( attacker, #"bc_combat_killfirm_sniper", 0.75 );
        return;
    }
    
    level thread trysaylocalsound( attacker, #"bc_combat_killfirm_infantry", 0.75 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x957df498, Offset: 0x15c7
// Size: 0x51, Type: bool
function function_2fd0ad6a1fcd1cd2( bundle )
{
    if ( bundle.var_b6449cb24a404fd5 && randomfloatrange( 0, 1 ) <= function_c11e66db3108e2f7() )
    {
        level thread trysaylocalsound( self, bundle.var_b6449cb24a404fd5, undefined, undefined, undefined, undefined, 1 );
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x91139ef7, Offset: 0x1621
// Size: 0x41
function onscoreevent( params )
{
    battlechatterevent = rank::function_85635a05a8614b8f( params.event );
    
    if ( !isdefined( battlechatterevent ) )
    {
        return;
    }
    
    level thread trysaylocalsound( self, battlechatterevent, 1 );
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0xd768feb5, Offset: 0x166a
// Size: 0x3e
function hurtbadlywait()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"bc_damage_taken" );
    wait 1.5;
    level thread trysaylocalsound( self, #"bc_status_player_low_health" );
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0xc1b4ea50, Offset: 0x16b0
// Size: 0xc7
function validaterecentattackers()
{
    if ( !isdefined( self.recentattackers ) )
    {
        self.recentattackers = [];
        return;
    }
    
    validattackers = [];
    currenttime = gettime();
    
    foreach ( event in self.recentattackers )
    {
        if ( currenttime < event.ignoreaftertime )
        {
            validattackers[ validattackers.size ] = event;
        }
    }
    
    self.recentattackers = validattackers;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x7022230e, Offset: 0x177f
// Size: 0x143
function addrecentattacker( attacker )
{
    if ( !isdefined( self.recentattackers ) )
    {
        self.recentattackers = [];
    }
    
    attackerexists = 0;
    
    foreach ( event in self.recentattackers )
    {
        if ( event.attacker == attacker )
        {
            attackerexists = 1;
            event.time = gettime();
            event.ignoreaftertime = event.time + 2000;
            break;
        }
    }
    
    if ( !attackerexists )
    {
        event = spawnstruct();
        event.time = gettime();
        event.attacker = attacker;
        event.ignoreaftertime = event.time + 2000;
        self.recentattackers[ self.recentattackers.size ] = event;
    }
    
    validaterecentattackers();
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x34b15b11, Offset: 0x18ca
// Size: 0xfe
function launcherfired( missile )
{
    missile endon( #"death" );
    
    while ( true )
    {
        nearplayers = utility::playersinsphere( missile.origin, 500 );
        
        foreach ( player in nearplayers )
        {
            if ( !isdefined( player ) || !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( isdefined( missile.owner ) && !missile.owner player_utility::isenemy( player ) )
            {
                continue;
            }
            
            level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg" );
            return;
        }
        
        waitframe();
    }
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xdc5dcdc1, Offset: 0x19d0
// Size: 0x8d
function javelinfired( team, target )
{
    if ( !level.teambased || !isdefined( target ) )
    {
        return;
    }
    
    enemyteams = team_utility::getenemyteams( team );
    var_8b1d738307ccd310 = getplayersinradius( target, 2000, undefined, undefined, undefined, enemyteams );
    
    if ( var_8b1d738307ccd310.size == 0 )
    {
        return;
    }
    
    player = utility::array_random( var_8b1d738307ccd310 );
    level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg", 0.5 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x89327f89, Offset: 0x1a65
// Size: 0x4e
function onequipmentuse( grenade )
{
    if ( !isdefined( grenade.weapon_name ) )
    {
        return;
    }
    
    equipmentbundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    level thread trysaylocalsound( self, equipmentbundle.var_cf29f1d5de231a0f );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x30f6223c, Offset: 0x1abb
// Size: 0x58
function function_72f2f594b3fdfcc2( grenade )
{
    if ( !isdefined( grenade.weapon_name ) || !isplayer( self ) )
    {
        return;
    }
    
    equipmentbundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    level thread trysaylocalsound( self, equipmentbundle.var_88d7e09fdee979bc );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xf99436bd, Offset: 0x1b1b
// Size: 0x4e
function equipmentdestroyed( grenade )
{
    if ( !isdefined( grenade.weapon_name ) )
    {
        return;
    }
    
    equipmentbundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    level thread trysaylocalsound( self, equipmentbundle.var_ac07d1d7714b2770 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x5146f5af, Offset: 0x1b71
// Size: 0x50
function function_f3ffc3fa6aa3a992( slot )
{
    superinfo = supers_mp::getcurrentsuper( slot );
    bundle = superinfo.staticdata.bundle;
    
    if ( isalive( self ) )
    {
        thread function_39e9aa189ee64f45( bundle );
    }
}

// Namespace battlechatter_mp
// Params 1, eflags: 0x4
// Checksum 0xf9531212, Offset: 0x1bc9
// Size: 0x11b
function private function_39e9aa189ee64f45( bundle )
{
    isplaying = trysaylocalsound( self, bundle.var_cf29f1d5de231a0f );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_ef1529b5003b94fe = isplaying;
    
    if ( isdefined( bundle.var_e7a069e0ce9175f3 ) )
    {
        nearbyplayers = utility::playersnear( self.origin, 960 );
        
        foreach ( player in nearbyplayers )
        {
            if ( !isdefined( player ) || player player::isreallyalive() == 0 || player_utility::isenemy( player ) == 0 )
            {
                continue;
            }
            
            isplaying = level trysaylocalsound( player, bundle.var_e7a069e0ce9175f3, 1 );
            
            if ( !isdefined( isplaying ) )
            {
                break;
            }
        }
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xc1751028, Offset: 0x1cec
// Size: 0xc7
function onfieldupgradedestroy( data )
{
    if ( data.victim.owner && player_utility::isfriendly( self.team, data.victim.owner ) )
    {
        return;
    }
    
    if ( !data.victim.weapon_name )
    {
        return;
    }
    
    if ( damage::function_7e3cc32b22322954( data.meansofdeath, data.objweapon ) )
    {
        superbundle = supers_mp::function_5ffd3dfa9cc1e8de( supers_mp::getsuperrefforsuperweapon( data.victim.weapon_name ) );
        level thread trysaylocalsound( self, superbundle.var_ac07d1d7714b2770 );
    }
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xb94d80f3, Offset: 0x1dbb
// Size: 0x5a
function playkillstreakdeploydialog( streakname, delay )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    streakbundle = level.streakglobals.streakbundles[ streakname ];
    level thread trysaylocalsound( self, streakbundle.var_cf29f1d5de231a0f, delay, undefined, undefined, undefined, 1 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x8aa05ca3, Offset: 0x1e1d
// Size: 0x5c
function killstreakdestroyed( streakname )
{
    if ( !isdefined( streakname ) )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !function_2fd0ad6a1fcd1cd2( bundle ) )
    {
        level thread trysaylocalsound( self, bundle.var_ac07d1d7714b2770, undefined, undefined, undefined, undefined, 1 );
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x742f9ecf, Offset: 0x1e81
// Size: 0x40
function function_2656e162f620ce7( skillref )
{
    if ( !isdefined( skillref ) )
    {
        return;
    }
    
    skillbundle = level.perkbundles[ skillref ];
    level thread trysaylocalsound( self, skillbundle.var_af249bd219625694 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x8eabc96c, Offset: 0x1ec9
// Size: 0x44, Type: bool
function function_3cf752be42e29fe2( grenade )
{
    if ( weaponclass( grenade.weapon_name ) == "rocketlauncher" )
    {
        return true;
    }
    
    if ( isdefined( grenade.bundle.var_e7a069e0ce9175f3 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x9262ed02, Offset: 0x1f16
// Size: 0x264
function grenadeproximitytracking()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( level.gametypebundle.var_16856eed340fe7e6 )
    {
        return;
    }
    
    if ( !function_3cf752be42e29fe2( self ) )
    {
        return;
    }
    
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        owner = getmissileowner( self );
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    querylocation = self.origin;
    nearbyplayers = utility::playersnear( querylocation, 960 );
    self endon( #"death" );
    
    while ( isdefined( self.origin ) )
    {
        if ( distancesquared( querylocation, self.origin ) > 589824 )
        {
            querylocation = self.origin;
            nearbyplayers = utility::playersnear( querylocation, 960 );
        }
        
        foreach ( player in nearbyplayers )
        {
            if ( !isdefined( player ) || player player::isreallyalive() == 0 || isalive( self.owner ) && self.owner player_utility::isenemy( player ) == 0 )
            {
                continue;
            }
            
            grenadedistancesquared = distancesquared( self.origin, player.origin );
            
            if ( grenadedistancesquared < 147456 )
            {
                if ( !sighttracepassed( player geteye(), self.origin, 0, player, self ) )
                {
                    continue;
                }
                
                if ( self.bundle.var_e7a069e0ce9175f3 )
                {
                    level thread trysaylocalsound( player, self.bundle.var_e7a069e0ce9175f3, undefined, undefined, undefined, self );
                }
                else
                {
                    tableinfo = equipment_mp::getequipmenttableinfo( self.equipmentref );
                    level thread trysaylocalsound( player, tableinfo.bundle.var_e7a069e0ce9175f3, undefined, undefined, undefined, self );
                }
                
                if ( weaponclass( self.weapon_name ) == "rocketlauncher" )
                {
                    level thread trysaylocalsound( player, #"bc_equipment_incoming_rpg", undefined, undefined, undefined, self );
                }
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x5645bb2d, Offset: 0x2182
// Size: 0x451
function reloadcallback( params )
{
    var_b7123b594cbfab97 = !level.gametypebundle.var_109234832f6ee977 && talking_gun::function_49e15c53304cb2ca( self ) && utility::cointoss();
    
    if ( var_b7123b594cbfab97 )
    {
        talking_gun::function_2cb0112543a9536a();
        
        if ( level.gametypebundle.var_b2e590f3a0d8330b )
        {
            return;
        }
    }
    
    if ( level.gametypebundle.var_cd42007a9bd5f648 )
    {
        return;
    }
    
    objweapon = self getcurrentweapon();
    
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    hasakimbo = weapon::isakimbo( objweapon );
    
    if ( hasakimbo )
    {
        remainingammo = self getweaponammoclip( objweapon, "right" ) + self getweaponammoclip( objweapon, "left" ) + self getweaponammostock( objweapon );
    }
    else
    {
        remainingammo = self getweaponammoclip( objweapon ) + self getweaponammostock( objweapon );
    }
    
    isunderbarrel = objweapon.isalternate && ( weaponclass( objweapon ) == "grenade" || weaponclass( objweapon ) == "spread" );
    hasmagazines = weapon::function_4476e03c10ef82b9( objweapon ) && !isunderbarrel;
    
    if ( remainingammo <= weaponclipsize( objweapon ) || hasakimbo && remainingammo <= weaponclipsize( objweapon ) * 2 )
    {
        weapongroup = weapon::getweapongroup( objweapon );
        var_1cc91f9806e1169c = 0;
        
        switch ( weapon::getweaponrootname( objweapon ) )
        {
            case #"hash_607145e68712971c":
            case #"hash_8d9ae5e5dd390b4b":
            case #"hash_d2d2f2854b7d8b7d":
            case #"hash_ec99e7d11ddb9eea":
                var_1cc91f9806e1169c = 1;
                break;
        }
        
        ignorelastmag = var_1cc91f9806e1169c || isunderbarrel;
        
        if ( !ignorelastmag )
        {
            if ( level.gamemodebundle.var_c77ac3d0d7b9c30a )
            {
                switch ( weapongroup )
                {
                    case #"hash_34340d457a63e7f1":
                    case #"hash_ab10f9c080fe4faf":
                    case #"hash_cd7f87dc1cdeaa54":
                        level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_smallcal" );
                        break;
                    case #"hash_8af0086b038622b5":
                    case #"hash_dd616da0b395a0b0":
                        level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_midcal" );
                        break;
                    case #"hash_bef5ec0b3e197ae":
                    case #"hash_47368bc0d2ef1565":
                    case #"hash_c095d67337b1f5a1":
                        level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_highcal" );
                        break;
                    case #"hash_16cf6289ab06bd30":
                        level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_shells" );
                        break;
                    case #"hash_9d18adab1b65a661":
                        level thread trysaylocalsound( self, #"bc_combat_action_last_mag_concat_launcher" );
                        break;
                }
            }
            else if ( level.var_49ae01328aba605 )
            {
                if ( hasmagazines )
                {
                    if ( function_5858eff036132466( self, #"bc_combat_action_last_mag" ) )
                    {
                        level notify( "kill_queued_bc_sound_" + self.name );
                        thread saylocalsound( 0, #"bc_combat_action_last_mag", 0, undefined, undefined, undefined, 1 );
                    }
                }
                else if ( function_5858eff036132466( self, #"bc_combat_action_lowammo" ) )
                {
                    level notify( "kill_queued_bc_sound_" + self.name );
                    thread saylocalsound( 0, #"bc_combat_action_lowammo", 0, undefined, undefined, undefined, 1 );
                }
            }
            else if ( hasmagazines )
            {
                level thread trysaylocalsound( self, #"bc_combat_action_last_mag" );
            }
            else
            {
                level thread trysaylocalsound( self, #"bc_combat_action_lowammo" );
            }
        }
        
        return;
    }
    
    if ( level.var_49ae01328aba605 )
    {
        if ( hasmagazines )
        {
            if ( function_5858eff036132466( self, #"bc_combat_action_reloading" ) )
            {
                level notify( "kill_queued_bc_sound_" + self.name );
                thread saylocalsound( 0, #"bc_combat_action_reloading", 0, undefined, undefined, undefined, 1 );
            }
        }
        else if ( function_5858eff036132466( self, #"bc_combat_action_reloadnomag" ) )
        {
            level notify( "kill_queued_bc_sound_" + self.name );
            thread saylocalsound( 0, #"bc_combat_action_reloadnomag", 0, undefined, undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( hasmagazines )
    {
        level thread trysaylocalsound( self, #"bc_combat_action_reloading" );
        return;
    }
    
    level thread trysaylocalsound( self, #"bc_combat_action_reloadnomag" );
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x8e502183, Offset: 0x25db
// Size: 0x3ae
function threatcallouttracking()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    
    if ( level.gametypebundle.var_3bd3d220c74c8b15 )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"enemy_sighted" );
        
        if ( getomnvar( "ui_prematch_period" ) )
        {
            level waittill( #"prematch_over" );
            continue;
        }
        
        if ( saidtoorecently( #"bc_combat_inform_contact_generic" ) || saidtoorecently( #"bc_combat_inform_contact" ) || saidtoorecently( #"bc_combat_inform_contact_multiple" ) )
        {
            continue;
        }
        
        enemies = self getsightedplayers();
        
        if ( !isdefined( enemies ) )
        {
            continue;
        }
        
        enemycount = 0;
        dist = 4000000;
        fov = 0.939692;
        isads = self playerads() > 0.7;
        
        if ( isads )
        {
            dist = 9000000;
            fov = 0.984808;
        }
        else if ( level.projectbundle.var_9de1cec10bb7cb1a )
        {
            continue;
        }
        
        var_b36168c0d81f4764 = get_last_callout_time( self.team );
        cancalloutlocation = !isdefined( var_b36168c0d81f4764 ) || var_b36168c0d81f4764 + function_cc0bf34a8efedc3e( #"callout_location" ) < gettime();
        forward = anglestoforward( self.angles );
        
        foreach ( enemy in enemies )
        {
            if ( isdefined( enemy.perks[ "specialty_hidden_from_location_callouts" ] ) )
            {
                continue;
            }
            
            toenemy = vectornormalize( enemy.origin - self.origin );
            
            if ( player::isreallyalive( enemy ) && !isdefined( enemy.perks[ "specialty_coldblooded" ] ) && distancesquared( self.origin, enemy.origin ) < dist && vectordot( forward, toenemy ) > fov )
            {
                enemycount++;
                location = enemy getvalidlocation( self );
                
                if ( isdefined( location ) && cancalloutlocation )
                {
                    alias = getloccalloutalias( location.locationaliases[ 0 ] );
                    location_add_last_callout_time( location.locationaliases[ 0 ], self.team );
                    
                    if ( soundexists( alias ) )
                    {
                        self playsoundtoteam( alias, self.team );
                    }
                    
                    break;
                }
            }
        }
        
        if ( enemycount > 0 )
        {
            event = undefined;
            
            if ( !saidtoorecently( #"bc_combat_inform_contact_generic" ) )
            {
                event = #"bc_combat_inform_contact_generic";
            }
            
            if ( !saidtoorecently( #"bc_combat_inform_contact" ) )
            {
                if ( isdefined( event ) )
                {
                    if ( utility::cointoss() )
                    {
                        event = #"bc_combat_inform_contact";
                    }
                }
                else
                {
                    event = #"bc_combat_inform_contact";
                }
            }
            
            if ( enemycount > 1 && !saidtoorecently( #"bc_combat_inform_contact_multiple" ) )
            {
                if ( isdefined( event ) )
                {
                    if ( utility::cointoss() )
                    {
                        event = #"bc_combat_inform_contact_multiple";
                    }
                }
                else
                {
                    event = #"bc_combat_inform_contact_multiple";
                }
            }
            
            level thread trysaylocalsound( self, event );
        }
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x1648c33b, Offset: 0x2991
// Size: 0x19a
function function_f5bb4562244ff1e5( params )
{
    if ( !isdefined( level.activekillstreaks ) )
    {
        return;
    }
    
    foreach ( killstreak in level.activekillstreaks )
    {
        killstreakowner = isplayer( killstreak ) ? killstreak : killstreak.owner;
        
        if ( !isplayer( killstreak ) && !( isdefined( killstreak ) && isdefined( killstreakowner ) ) )
        {
            waitframe();
            continue;
        }
        
        streakbundle = level.streakglobals.streakbundles[ killstreak.streakname ];
        
        if ( !( isdefined( streakbundle ) && isdefined( streakbundle.var_30341cf01d51741a ) ) )
        {
            waitframe();
            continue;
        }
        
        if ( !player_utility::playersareenemies( self, killstreakowner ) )
        {
            waitframe();
            continue;
        }
        
        if ( !math::point_in_fov( killstreak.origin, 0.965926, 1 ) )
        {
            waitframe();
            continue;
        }
        
        traceresult = trace::_bullet_trace( self geteye(), killstreak.origin, 1, self );
        
        if ( isdefined( traceresult ) )
        {
            if ( traceresult[ "fraction" ] >= 1 || traceresult[ "entity" ] === killstreak )
            {
                thread trysaylocalsound( self, streakbundle.var_30341cf01d51741a );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace battlechatter_mp
// Params 4
// Checksum 0x53cd864b, Offset: 0x2b33
// Size: 0x292, Type: bool
function dosound( soundtype, targetent, location, var_5cf2151f61187a01 )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isdefined( soundtype ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return false;
    }
    
    logprint( "battlechatter_mp::doSound - PlaySoundEvent()" );
    logprint( "self         = " + self.name );
    logprint( "sessionstate = " + self.sessionstate );
    logprint( "targetEnt    = " + isdefined( targetent ) );
    
    if ( isdefined( targetent ) )
    {
        logprint( "tEntclassname = " + targetent.classname );
        logprint( "tEntOrigin    = " + targetent.origin );
        
        if ( isplayer( targetent ) )
        {
            logprint( "tEntSessionstate = " + targetent.sessionstate );
        }
    }
    
    /#
        logprint( "<dev string:x57>" + getxhashsourcename( soundtype ) );
    #/
    
    soundevent = function_694f04feb7ef7c08( soundtype );
    
    if ( !isdefined( soundevent ) )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                battlechatter_debugprint( "<dev string:x67>" + getxhashsourcename( soundtype ), "<dev string:x7e>" );
            }
        #/
        
        return false;
    }
    
    if ( isent( targetent ) )
    {
        if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
        {
            conversationstart( soundevent, [ self, targetent ] );
        }
        else
        {
            self playsoundevent( soundevent, targetent );
        }
    }
    else if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
    {
        conversationstart( soundevent, [ self ] );
    }
    else
    {
        self playsoundevent( soundevent );
    }
    
    if ( !var_5cf2151f61187a01 && ( !isbot( self ) || getdvarint( @"hash_3f7dbd03a63a2aa", 0 ) == 1 ) )
    {
        telemetry_utils::function_af2d366f9522f76f( "callback_operator_vo", { #target:targetent, #speaker:self, #sound_event:soundevent, #sound_type:soundtype, #script_func_name:"doSound" } );
    }
    
    if ( isdefined( location ) )
    {
        location_add_last_callout_time( location, self.team );
    }
    
    priority = function_d99728ce8f7cdefd( soundtype );
    duration = 1.5;
    speakerteam = self.team;
    level addspeaker( self, speakerteam, soundtype, priority, duration );
    updatechatter( soundtype );
    thread timehack( getxhashhexname( soundtype ), duration );
    utility::waittill_any( getxhashhexname( soundtype ), "death_or_disconnect" );
    level removespeaker( self, speakerteam );
    return true;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xda24f525, Offset: 0x2dce
// Size: 0x29
function timehack( soundalias, duration )
{
    self endon( #"death_or_disconnect" );
    wait duration;
    self notify( soundalias );
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xa77bd8a3, Offset: 0x2dff
// Size: 0xe6, Type: bool
function isspeakerinrange( player, max_dist = 1000 )
{
    distsq = max_dist * max_dist;
    
    if ( isdefined( player ) && isdefined( player.team ) && player.team != "spectator" )
    {
        for ( index = 0; index < level.speakers[ player.team ].size ; index++ )
        {
            teammate = level.speakers[ player.team ][ index ][ "player" ];
            
            if ( teammate == player )
            {
                return true;
            }
            
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( distancesquared( teammate.origin, player.origin ) < distsq )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 5
// Checksum 0x69db73a7, Offset: 0x2eee
// Size: 0xce
function addspeaker( player, team, soundtype, priority, duration )
{
    index = level.speakers[ team ].size;
    level.speakers[ team ][ index ] = [];
    level.speakers[ team ][ index ][ "player" ] = player;
    level.speakers[ team ][ index ][ "sound_alias" ] = soundtype;
    level.speakers[ team ][ index ][ "sound_type" ] = soundtype;
    level.speakers[ team ][ index ][ "priority" ] = priority;
    level thread function_88aa6bfc15df582c( level.speakers[ team ][ index ], team, duration );
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x24fb53c4, Offset: 0x2fc4
// Size: 0x84
function removespeaker( player, team )
{
    newspeakers = [];
    
    for ( index = 0; index < level.speakers[ team ].size ; index++ )
    {
        if ( level.speakers[ team ][ index ][ "player" ] == player )
        {
            continue;
        }
        
        newspeakers[ newspeakers.size ] = level.speakers[ team ][ index ];
    }
    
    level.speakers[ team ] = newspeakers;
}

// Namespace battlechatter_mp
// Params 3
// Checksum 0x4cb89152, Offset: 0x3050
// Size: 0x51
function function_88aa6bfc15df582c( speaker, team, duration )
{
    level endon( #"game_ended" );
    wait duration;
    removespeaker( speaker[ "player" ], team );
    speaker[ "player" ] notify( getxhashhexname( speaker[ "sound_type" ] ) );
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xd15c0ee7, Offset: 0x30a9
// Size: 0x3c
function disablebattlechatter( player, var_a183ae4d20dc9def )
{
    if ( isdefined( var_a183ae4d20dc9def ) )
    {
        player val::set( var_a183ae4d20dc9def, "allow_battlechatter_vo", 0 );
        return;
    }
    
    player.bcdisabled = 1;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xee205e6c, Offset: 0x30ed
// Size: 0x38
function enablebattlechatter( player, var_a183ae4d20dc9def )
{
    if ( isdefined( var_a183ae4d20dc9def ) )
    {
        player val::reset( var_a183ae4d20dc9def, "allow_battlechatter_vo" );
        return;
    }
    
    player.bcdisabled = undefined;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x60b1f9af, Offset: 0x312d
// Size: 0xb6
function updatechatter( soundtype )
{
    if ( !isdefined( level.bcinfo[ "soundEventHistory" ][ soundtype ] ) )
    {
        level.bcinfo[ "soundEventHistory" ][ soundtype ] = [];
    }
    
    time = gettime();
    cleanuplastsaytimes( soundtype, time );
    self.bcinfolastsaytimes[ soundtype ] = time;
    data = spawnstruct();
    data.origin = self.origin;
    data.time = time;
    level.bcinfo[ "soundEventHistory" ][ soundtype ][ level.bcinfo[ "soundEventHistory" ][ soundtype ].size ] = data;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x2416b4b0, Offset: 0x31eb
// Size: 0x16c
function cleanuplastsaytimes( soundtype, time )
{
    temparray = [];
    
    foreach ( playersoundtype, timestamp in self.bcinfolastsaytimes )
    {
        timeout = function_c8ccf346ee7145c9( playersoundtype ) + timestamp;
        
        if ( time < timeout )
        {
            temparray[ playersoundtype ] = timestamp;
        }
    }
    
    self.bcinfolastsaytimes = temparray;
    temparray = [];
    
    foreach ( event in level.bcinfo[ "soundEventHistory" ][ soundtype ] )
    {
        if ( time < event.time + function_cc0bf34a8efedc3e( soundtype ) )
        {
            temparray[ temparray.size ] = event;
        }
    }
    
    level.bcinfo[ "soundEventHistory" ][ soundtype ] = temparray;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xacba1815, Offset: 0x335f
// Size: 0x143
function getvalidlocation( speaker )
{
    if ( anim.bcs_locations.size == 0 )
    {
        return;
    }
    
    mylocations = get_all_my_locations( anim.bcs_locations );
    
    if ( mylocations.size )
    {
        mylocations = arrayrandomize( mylocations );
        
        foreach ( location in mylocations )
        {
            if ( !location_called_out_ever( location ) && speaker cancalloutlocation( location ) )
            {
                return location;
            }
        }
        
        foreach ( location in mylocations )
        {
            if ( !location_called_out_recently( location ) && speaker cancalloutlocation( location ) )
            {
                return location;
            }
        }
    }
}

// Namespace battlechatter_mp
// Params 1, eflags: 0x4
// Checksum 0x66ebbe6, Offset: 0x34ab
// Size: 0xa9
function private get_all_my_locations( alllocations )
{
    touchinglocations = self getistouchingentities( alllocations );
    mylocations = [];
    
    foreach ( location in touchinglocations )
    {
        if ( isdefined( location.locationaliases ) )
        {
            mylocations[ mylocations.size ] = location;
        }
    }
    
    return mylocations;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xac518cd6, Offset: 0x355d
// Size: 0x36, Type: bool
function location_called_out_ever( location )
{
    lastcallouttime = location_get_last_callout_time( location.locationaliases[ 0 ] );
    
    if ( !isdefined( lastcallouttime ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xd86a33e5, Offset: 0x359c
// Size: 0x52, Type: bool
function location_called_out_recently( location )
{
    lastcallouttime = location_get_last_callout_time( location.locationaliases[ 0 ] );
    
    if ( !isdefined( lastcallouttime ) )
    {
        return false;
    }
    
    var_47735ecdd07ef138 = lastcallouttime + 25000;
    
    if ( gettime() < var_47735ecdd07ef138 )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xc7f6fea7, Offset: 0x35f7
// Size: 0x57
function location_add_last_callout_time( location, team )
{
    currenttime = gettime();
    anim.locationlastcallouttimes[ location ] = currenttime;
    
    if ( !isdefined( level.lastlocationcallouttime ) )
    {
        level.lastlocationcallouttime = [];
    }
    
    level.lastlocationcallouttime[ team ] = currenttime;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xa2a3dc39, Offset: 0x3656
// Size: 0x29
function location_get_last_callout_time( location )
{
    if ( isdefined( anim.locationlastcallouttimes[ location ] ) )
    {
        return anim.locationlastcallouttimes[ location ];
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xbb2869f5, Offset: 0x3688
// Size: 0x29
function get_last_callout_time( team )
{
    if ( isdefined( level.lastlocationcallouttime[ team ] ) )
    {
        return level.lastlocationcallouttime[ team ];
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xe61b424d, Offset: 0x36ba
// Size: 0xa9
function cancalloutlocation( location )
{
    foreach ( alias in location.locationaliases )
    {
        aliasnormal = getloccalloutalias( alias );
        valid = soundexists( aliasnormal );
        
        if ( valid )
        {
            return valid;
        }
    }
    
    return 0;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xfb7867b7, Offset: 0x376c
// Size: 0x9a, Type: bool
function canconcat( location )
{
    aliases = location.locationaliases;
    
    foreach ( alias in aliases )
    {
        if ( iscallouttypeconcat( alias, self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xafe81432, Offset: 0x380f
// Size: 0xc6
function getcannedresponse( speaker )
{
    var_304c1a57aca087f8 = undefined;
    aliases = self.locationaliases;
    
    foreach ( alias in aliases )
    {
        if ( iscallouttypeqa( alias, speaker ) && !isdefined( self.qafinished ) )
        {
            var_304c1a57aca087f8 = alias;
            break;
        }
        
        if ( iscallouttypereport( alias ) )
        {
            var_304c1a57aca087f8 = alias;
        }
    }
    
    return var_304c1a57aca087f8;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xa02467dd, Offset: 0x38de
// Size: 0x17
function iscallouttypereport( alias )
{
    return issubstr( alias, "_report" );
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xf7fc9e0e, Offset: 0x38fe
// Size: 0x3e, Type: bool
function iscallouttypeconcat( alias, speaker )
{
    tryqa = speaker getloccalloutalias( "concat_loc_" + alias );
    
    if ( soundexists( tryqa ) )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x73848550, Offset: 0x3945
// Size: 0x53, Type: bool
function iscallouttypeqa( alias, speaker )
{
    if ( issubstr( alias, "_qa" ) && soundexists( alias ) )
    {
        return true;
    }
    
    tryqa = speaker getqacalloutalias( alias, 0 );
    
    if ( soundexists( tryqa ) )
    {
        return true;
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x5021bcd1, Offset: 0x39a1
// Size: 0x19a
function playdeathalias()
{
    if ( !game_utility_mp::islifelimited() )
    {
        return;
    }
    
    victimteam = self.team;
    var_a203168df4e14fd7 = getdvarint( @"hash_dfd8480d3b3afa08", 0 );
    
    if ( var_a203168df4e14fd7 > 0 && teams::function_d301e967593ece1b( victimteam ) > var_a203168df4e14fd7 )
    {
        return;
    }
    
    level notify( "PlayDeathAlias_" + victimteam );
    level endon( "PlayDeathAlias_" + victimteam );
    wait 1.5;
    
    if ( !isdefined( level.var_39ea93286105e2a4 ) )
    {
        level.var_39ea93286105e2a4 = [];
        
        foreach ( team in level.teamnamelist )
        {
            level.var_39ea93286105e2a4[ team ] = 0;
        }
    }
    
    if ( !isdmzgamemode() && gettime() < level.var_39ea93286105e2a4[ victimteam ] + 5000 )
    {
        return;
    }
    
    speakername = victimteam == "allies" ? "suop" : "kuop";
    alias = "dx_mp_mprg_plyr_deth_" + speakername;
    alivecount = teams::getteamdata( victimteam, "aliveCount" );
    
    if ( soundexists( alias ) && alivecount > 0 )
    {
        self playsoundtoteam( alias, victimteam, self );
        level.var_39ea93286105e2a4[ victimteam ] = gettime();
    }
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x25eddc9e, Offset: 0x3b43
// Size: 0x121
function function_b50b1c692cfcc369()
{
    victimteam = self.team;
    wait 1.5;
    
    if ( !isdefined( level.var_39ea93286105e2a4 ) )
    {
        level.var_39ea93286105e2a4 = [];
        
        foreach ( team in level.teamnamelist )
        {
            level.var_39ea93286105e2a4[ team ] = 0;
        }
    }
    
    if ( gettime() < level.var_39ea93286105e2a4[ victimteam ] + 1000 )
    {
        return;
    }
    
    alias = "dx_mp_mprg_plyr_deth_suop";
    alivecount = teams::getteamdata( victimteam, "aliveCount" );
    
    if ( self && soundexists( alias ) && alivecount > 0 )
    {
        self playsoundtoteam( alias, victimteam, self );
        level.var_39ea93286105e2a4[ victimteam ] = gettime();
    }
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x1c3889d3, Offset: 0x3c6c
// Size: 0xfb
function getloccalloutalias( locationname )
{
    if ( level.gamemodebundle.var_994ec3c607ce8beb )
    {
        mapname = tablelookup( level.gamemodebundle.var_994ec3c607ce8beb, 1, level.mapname, 2 );
        speakername = self.team == "allies" ? "suop" : "kuop";
        var_1fcbe788ab7b35c6 = tablelookup( level.gamemodebundle.var_994ec3c607ce8beb, 1, locationname, 2 );
        return ( "dx_mp_" + mapname + "_lctn_" + var_1fcbe788ab7b35c6 + "_" + speakername );
    }
    
    alias = "dx_mpo_" + ( self.team == "allies" ? "usop" : "ruop" ) + "_loc_enemy_" + locationname;
    return alias;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x88d9fc3a, Offset: 0x3d6f
// Size: 0x38
function getqacalloutalias( basealias, lineindex )
{
    alias = getloccalloutalias( basealias );
    alias += "_qa" + lineindex;
    return alias;
}

/#

    // Namespace battlechatter_mp
    // Params 0
    // Checksum 0x6f35810d, Offset: 0x3db0
    // Size: 0x45, Type: dev
    function battlechatter_canprint()
    {
        if ( getdvar( @"debug_bcprint", "<dev string:x82>" ) == self.team || getdvar( @"debug_bcprint", "<dev string:x82>" ) == "<dev string:x83>" )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace battlechatter_mp
    // Params 0
    // Checksum 0xcdc37475, Offset: 0x3dfd
    // Size: 0x45, Type: dev
    function battlechatter_canprintdump()
    {
        if ( getdvar( @"debug_bcprintdump", "<dev string:x82>" ) == self.team || getdvar( @"debug_bcprintdump", "<dev string:x82>" ) == "<dev string:x83>" )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace battlechatter_mp
    // Params 2
    // Checksum 0x281207e1, Offset: 0x3e4a
    // Size: 0xd1, Type: dev
    function battlechatter_print( alias, color )
    {
        if ( !battlechatter_canprint() )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = "<dev string:x87>";
        }
        
        colorkey = "<dev string:x87>";
        
        switch ( color )
        {
            case #"hash_97430f6c58e61cbc":
                colorkey = "<dev string:x8d>";
                break;
            case #"hash_2ac407c1cd5943a9":
                colorkey = "<dev string:x97>";
                break;
            case #"hash_6686d129776d649a":
                colorkey = "<dev string:x9f>";
                break;
        }
        
        debugstring = colorkey + "<dev string:xa2>" + self.origin + "<dev string:xab>" + self.name + "<dev string:xae>" + alias;
        println( debugstring );
        debug::function_9d6fee9cf5908ddc( debugstring );
    }

    // Namespace battlechatter_mp
    // Params 1
    // Checksum 0x288168b, Offset: 0x3f23
    // Size: 0x229, Type: dev
    function battlechatter_printdump( alias )
    {
        if ( !battlechatter_canprintdump() )
        {
            return;
        }
        
        dumptype = getdvar( @"debug_bcprintdumptype", "<dev string:x28>" );
        
        if ( dumptype != "<dev string:x28>" && dumptype != "<dev string:xb3>" )
        {
            return;
        }
        
        var_8741cc0c336c78a0 = -1;
        
        if ( isdefined( level.var_66f4410fa44c341 ) )
        {
            var_8741cc0c336c78a0 = ( gettime() - level.var_66f4410fa44c341 ) * 0.001;
        }
        
        level.var_66f4410fa44c341 = gettime();
        
        if ( dumptype == "<dev string:x28>" )
        {
            if ( !utility::flag_exist( "<dev string:xb7>" ) )
            {
                utility::flag_init( "<dev string:xb7>" );
            }
            
            if ( !isdefined( level.var_a5b74b32d1fe356a ) )
            {
                filepath = "<dev string:xcf>" + level.script + "<dev string:xf0>";
                level.var_a5b74b32d1fe356a = openfile( filepath, "<dev string:xf5>" );
            }
            
            aliastype = getaliastypefromsoundalias( alias );
            suffix = getintensitysuffix( self );
            factionprefix = teams::getteamvoiceinfix( self.team ) + "<dev string:xfb>";
            factionprefix = getsubstr( factionprefix, 0, factionprefix.size - 1 );
            dumpstring = level.script + "<dev string:xfe>" + factionprefix + "<dev string:xfe>" + self.operatorcustomization.voice + "<dev string:xfe>" + aliastype;
            battlechatter_printdumpline( level.var_a5b74b32d1fe356a, dumpstring, "<dev string:xb7>" );
            return;
        }
        
        if ( dumptype == "<dev string:xb3>" )
        {
            if ( !utility::flag_exist( "<dev string:x100>" ) )
            {
                utility::flag_init( "<dev string:x100>" );
            }
            
            if ( !isdefined( level.var_81dcfda6de38eb66 ) )
            {
                filepath = "<dev string:xcf>" + level.script + "<dev string:x118>";
                level.var_81dcfda6de38eb66 = openfile( filepath, "<dev string:xf5>" );
            }
            
            dumpstring = "<dev string:x11d>" + var_8741cc0c336c78a0 + "<dev string:x11f>";
            dumpstring += alias;
            battlechatter_printdumpline( level.var_81dcfda6de38eb66, dumpstring, "<dev string:x100>" );
        }
    }

    // Namespace battlechatter_mp
    // Params 2
    // Checksum 0xbaeee62d, Offset: 0x4154
    // Size: 0x2b, Type: dev
    function battlechatter_debugprint( alias, color )
    {
        battlechatter_print( alias, color );
        thread battlechatter_printdump( alias );
    }

    // Namespace battlechatter_mp
    // Params 1
    // Checksum 0xb4b7c01b, Offset: 0x4187
    // Size: 0x4d, Type: dev
    function getaliastypefromsoundalias( alias )
    {
        prefix = "<dev string:x127>" + self.operatorcustomization.voice;
        aliastype = getsubstr( alias, prefix.size, alias.size );
        return aliastype;
    }

    // Namespace battlechatter_mp
    // Params 3
    // Checksum 0xe5b86353, Offset: 0x41dc
    // Size: 0x4f, Type: dev
    function battlechatter_printdumpline( file, str, controlflag )
    {
        if ( utility::flag( controlflag ) )
        {
            utility::flag_wait( controlflag );
        }
        
        utility::flag_set( controlflag );
        fprintln( file, str );
        utility::flag_clear( controlflag );
    }

#/

// Namespace battlechatter_mp
// Params 1
// Checksum 0xdf11628c, Offset: 0x4233
// Size: 0xc6, Type: bool
function friendly_nearby( max_dist = 262144 )
{
    players = teams::getfriendlyplayers( self.team, 1 );
    
    foreach ( player in players )
    {
        if ( player != self && distancesquared( player.origin, self.origin ) <= max_dist )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x8befdd37, Offset: 0x4302
// Size: 0xd2
function function_6616b20c4b7f2923( origin, max_dist_sq )
{
    players = teams::getfriendlyplayers( self.team, 1 );
    
    foreach ( player in players )
    {
        if ( player != self && distancesquared( player.origin, self.origin ) <= max_dist_sq )
        {
            if ( player trace::can_see_origin( origin, 0, undefined, undefined, 0 ) )
            {
                return player;
            }
        }
    }
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x45a5a111, Offset: 0x43dd
// Size: 0x604
function setupselfvo()
{
    level.selfvomap = [];
    level.selfvomap[ "plr_killfirm_c6" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_ftl" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_ghost" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_merc" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_stryker" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_warfighter" ] = "kill_rig";
    level.selfvomap[ "plr_killfirm_generic" ] = "kill_gen";
    level.selfvomap[ "plr_killfirm_amf" ] = "kill_amf";
    level.selfvomap[ "plr_killfirm_headshot" ] = "kill_headshot";
    level.selfvomap[ "plr_killfirm_grenade" ] = "kill_grenade";
    level.selfvomap[ "plr_killfirm_rival" ] = "kill_rival";
    level.selfvomap[ "plr_killfirm_semtex" ] = "kill_semtex";
    level.selfvomap[ "plr_killfirm_sticky_grenade" ] = "kill_semtex";
    level.selfvomap[ "plr_killfirm_multi" ] = "kill_multi";
    level.selfvomap[ "plr_killfirm_twofer" ] = "kill_twofer";
    level.selfvomap[ "plr_killfirm_threefer" ] = "kill_threefer";
    level.selfvomap[ "plr_killfirm_killstreak" ] = "kill_ss";
    level.selfvomap[ "plr_killstreak_destroy" ] = "kill_other_ss";
    level.selfvomap[ "plr_killstreak_target" ] = "targeted_by_ss";
    level.selfvomap[ "plr_hit_back" ] = "dmg_back";
    level.selfvomap[ "plr_damaged_light" ] = "dmg_light";
    level.selfvomap[ "plr_damaged_heavy" ] = "dmg_heavy";
    level.selfvomap[ "plr_damaged_emp" ] = "dmg_emp";
    level.selfvomap[ "plr_healing" ] = "healing";
    level.selfvomap[ "plr_kd_high" ] = "kd_high";
    level.selfvomap[ "plr_firefight" ] = "firefight";
    level.selfvomap[ "plr_target_generic" ] = "enemy_sighted";
    level.selfvomap[ "plr_perk_super" ] = "super_activate";
    level.selfvomap[ "plr_perk_trophy" ] = "super_activate";
    level.selfvomap[ "plr_perk_turret" ] = "super_activate";
    level.selfvomap[ "plr_perk_amplify" ] = "super_activate";
    level.selfvomap[ "plr_perk_overdrive" ] = "super_activate";
    level.selfvomap[ "plr_perk_ftl" ] = "super_activate";
    level.selfvomap[ "plr_perk_pulse" ] = "super_activate";
    level.selfvomap[ "plr_perk_rewind" ] = "super_activate";
    level.selfvomap[ "plr_perk_super_kill" ] = "super_kill";
    level.selfvomap[ "plr_perk_trophy_block" ] = "super_kill";
    level.selfvomap[ "plr_perk_turret_kill" ] = "super_kill";
    level.selfvomap[ "plr_killfirm_shift" ] = "super_kill";
    level.selfvomap[ "plr_perk_railgun" ] = "super_kill";
    level.selfvomap[ "plr_perk_stealth" ] = "super_kill";
    level.selfvomap[ "plr_perk_armor" ] = "super_kill";
    level.selfvomap[ "plr_perk_charge" ] = "super_kill";
    level.selfvomap[ "plr_perk_dragon" ] = "super_kill";
    level.selfvomap[ "plr_perk_pound" ] = "super_kill";
    level.selfvomap[ "plr_perk_reaper" ] = "super_kill";
    level.selfvoinfo = [];
    setselfvoinfo( "kill_rig", 15, 0.3, 0.25 );
    setselfvoinfo( "kill_gen", 30, 0.1, 0.25 );
    setselfvoinfo( "kill_amf", 15, 0.5, 0.5 );
    setselfvoinfo( "kill_headshot", 15, 0.7, 0.25 );
    setselfvoinfo( "kill_grenade", 15, 0.5, 0.25 );
    setselfvoinfo( "kill_rival", 15, 0.7, 0.25 );
    setselfvoinfo( "kill_semtex", 15, 0.5, 0.25 );
    setselfvoinfo( "kill_sticky_grenade", 15, 0.5, 0.25 );
    setselfvoinfo( "kill_multi", 20, 0.6, 0.25 );
    setselfvoinfo( "kill_twofer", 10, 0.7, 0.75 );
    setselfvoinfo( "kill_threefer", 10, 0.8, 0.75 );
    setselfvoinfo( "kill_ss", 10, 0.5, 0.2 );
    setselfvoinfo( "kill_other_ss", 10, 0.7, 0.75 );
    setselfvoinfo( "targeted_by_ss", 10, 0.4, 0.33 );
    setselfvoinfo( "dmg_back", 20, 0.5, 0.5 );
    setselfvoinfo( "dmg_light", 20, 0.4, 0.1 );
    setselfvoinfo( "dmg_heavy", 20, 0.5, 0.2 );
    setselfvoinfo( "healing", 10, 0.3, 0.1 );
    setselfvoinfo( "kd_high", 20, 0.7, 0.8 );
    setselfvoinfo( "enemy_sighted", 20, 0.2, 0.25 );
    setselfvoinfo( "firefight", 10, 0.4, 0.33 );
    setselfvoinfo( "super_activate", 10, 1, 1 );
    setselfvoinfo( "super_kill", 10, 0.9, 0.66 );
}

// Namespace battlechatter_mp
// Params 4
// Checksum 0x955f053c, Offset: 0x49e9
// Size: 0x66
function setselfvoinfo( var_51e83609a25e78f3, timeout, priority, chance )
{
    level.selfvoinfo[ var_51e83609a25e78f3 ][ "timeout_pos" ] = timeout;
    level.selfvoinfo[ var_51e83609a25e78f3 ][ "priority" ] = priority;
    level.selfvoinfo[ var_51e83609a25e78f3 ][ "chance" ] = chance;
}

// Namespace battlechatter_mp
// Params 4
// Checksum 0x20552735, Offset: 0x4a57
// Size: 0x1c7
function saytoself( player, aliasname, fallbackname, delay )
{
    if ( true )
    {
        return;
    }
    
    if ( isagent( player ) || !isplayer( player ) )
    {
        return;
    }
    
    if ( player.bcdisabled )
    {
        return;
    }
    
    suffix = getintensitysuffix( player );
    fullname = "";
    
    if ( isdefined( player.operatorcustomization.voice ) && isdefined( aliasname ) )
    {
        fullname = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;
    }
    
    if ( !isdefined( aliasname ) || !soundexists( fullname ) )
    {
        if ( !isdefined( fallbackname ) )
        {
            return;
        }
        
        aliasname = fallbackname;
        fullname = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;
        
        if ( !soundexists( fullname ) )
        {
            return;
        }
    }
    
    if ( !isdefined( player.selfvohistory ) )
    {
        player.selfvohistory = [];
        player.playingselfvo = 0;
        player.queuedvo = "none";
    }
    
    if ( player.selfvohistory[ level.selfvomap[ aliasname ] ] > 0 )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "selfVOBonusChance" ] ) )
    {
        player thread updateselfvobonuschance();
    }
    
    if ( randomfloat( 1 ) > level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "chance" ] + player.pers[ "selfVOBonusChance" ] )
    {
        return;
    }
    
    player thread trysetqueuedselfvo( aliasname, delay );
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x5e80d195, Offset: 0x4c26
// Size: 0x96
function updateselfvobonuschance()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.pers[ "selfVOBonusChance" ] = 0;
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        while ( true )
        {
            self.pers[ "selfVOBonusChance" ] = self.pers[ "selfVOBonusChance" ] + 0.1;
            wait 3;
        }
        
        return;
    }
    
    self.pers[ "selfVOBonusChance" ] = level.gamemodebundle.var_89e1cc52762a3f6 ?? 0;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x29be3dd6, Offset: 0x4cc4
// Size: 0x18d
function trysetqueuedselfvo( aliasname, delay )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.queuedvo == aliasname )
    {
        return;
    }
    
    if ( self.queuedvo == "none" || level.selfvoinfo[ level.selfvomap[ self.queuedvo ] ][ "priority" ] < level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] || level.selfvoinfo[ level.selfvomap[ self.queuedvo ] ][ "priority" ] == level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] && utility::cointoss() )
    {
        self.queuedvo = aliasname;
    }
    else
    {
        return;
    }
    
    self notify( #"hash_7d300b8771dca883" );
    self endon( #"hash_7d300b8771dca883" );
    self.selfvodelaycomplete = 1;
    
    if ( isdefined( delay ) )
    {
        thread selfvodelay( delay );
    }
    
    waittime = getprioritywaittime( aliasname );
    initialtime = gettime();
    
    while ( self.playingselfvo || !self.selfvodelaycomplete || waittime > gettime() )
    {
        if ( gettime() > initialtime + 2000 )
        {
            self.queuedvo = "none";
            return;
        }
        
        wait 0.05;
    }
    
    waitframe();
    thread playselfvo( aliasname );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xc3f5734a, Offset: 0x4e59
// Size: 0x56
function getprioritywaittime( aliasname )
{
    if ( !isdefined( self.lastselfvotime ) )
    {
        self.lastselfvotime = 0;
    }
    
    return self.lastselfvotime + 2000 + 10000 * ( 1 - level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "priority" ] );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x27b0caf, Offset: 0x4eb8
// Size: 0x3c
function selfvodelay( delay )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7d300b8771dca883" );
    self.selfvodelaycomplete = 0;
    wait delay;
    self.selfvodelaycomplete = 1;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x7e76f782, Offset: 0x4efc
// Size: 0xb4
function playselfvo( aliasname )
{
    self endon( #"death_or_disconnect" );
    suffix = getintensitysuffix( self );
    fullname = "dx_mpb_" + self.operatorcustomization.voice + "_" + aliasname;
    self.pers[ "selfVOBonusChance" ] = 0;
    self.queuedvo = "none";
    duration = lookupsoundlength( fullname ) * 0.001;
    self.lastselfvotime = gettime();
    thread playingselfvotracking( duration );
    thread updateselfvohistory( aliasname );
    self playsoundtoplayer( fullname, self );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xf14d8cdd, Offset: 0x4fb8
// Size: 0x30
function playingselfvotracking( duration )
{
    self endon( #"disconnect" );
    self.playingselfvo = 1;
    wait duration;
    self.playingselfvo = 0;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xf09afd93, Offset: 0x4ff0
// Size: 0x68
function updateselfvohistory( aliasname )
{
    self endon( #"disconnect" );
    self.selfvohistory[ level.selfvomap[ aliasname ] ] = gettime();
    wait level.selfvoinfo[ level.selfvomap[ aliasname ] ][ "timeout_pos" ];
    self.selfvohistory[ level.selfvomap[ aliasname ] ] = 0;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xc2e6d203, Offset: 0x5060
// Size: 0xa7
function getintensitysuffix( player )
{
    /#
        bc_intensity = getdvar( @"scr_debug_bc_intensity", "<dev string:x12f>" );
        
        if ( bc_intensity != "<dev string:x12f>" )
        {
            if ( bc_intensity == "<dev string:x134>" )
            {
                return "<dev string:x134>";
            }
            
            if ( bc_intensity == "<dev string:x138>" )
            {
                return "<dev string:x138>";
            }
        }
    #/
    
    roundpercent = game_utility_mp::gettimepassedpercentage();
    intensity = player getbcintensity();
    
    if ( intensity > 5000 || roundpercent >= 80 || game_utility_mp::inovertime() )
    {
        return "high";
    }
    
    return "mid";
}

// Namespace battlechatter_mp
// Params 3
// Checksum 0x8bd507b7, Offset: 0x510f
// Size: 0x97
function addtointensitybuffer( type, intensity, ignoreaftertime )
{
    if ( !isdefined( self.battlechatterintensitybuffer ) )
    {
        self.battlechatterintensitybuffer = [];
    }
    
    event = spawnstruct();
    event.time = gettime();
    event.value = intensity;
    event.ignoreaftertime = event.time + ignoreaftertime * 1000;
    self.battlechatterintensitybuffer[ self.battlechatterintensitybuffer.size ] = event;
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x1fd5b426, Offset: 0x51ae
// Size: 0xe6
function getbcintensity()
{
    if ( !isdefined( self.battlechatterintensitybuffer ) )
    {
        return 0;
    }
    
    validevents = [];
    intensity = 0;
    currenttime = gettime();
    
    foreach ( event in self.battlechatterintensitybuffer )
    {
        if ( currenttime < event.ignoreaftertime )
        {
            intensity += event.value;
            validevents[ validevents.size ] = event;
        }
    }
    
    self.battlechatterintensitybuffer = validevents;
    self.intensity = intensity;
    return intensity;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xc1d76346, Offset: 0x529d
// Size: 0x2e1
function testweaponfiredtolisteners( attacker, objweapon )
{
    listeningplayers = utility::playersnear( attacker.origin, 4000 );
    
    foreach ( player in listeningplayers )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        distsq = max( distance2dsquared( attacker.origin, player.origin ), 1 );
        
        if ( weapon::iscacprimaryweapon( objweapon.basename ) || weapon::iscacsecondaryweapon( objweapon.basename ) )
        {
            intensity = 0;
            weapongroup = weapon::getweapongroup( objweapon.basename );
            
            switch ( weapongroup )
            {
                case #"hash_ab10f9c080fe4faf":
                    intensity = 50;
                    break;
                case #"hash_8af0086b038622b5":
                    intensity = 60;
                    break;
                case #"hash_dd616da0b395a0b0":
                    intensity = 60;
                    break;
                case #"hash_c095d67337b1f5a1":
                    intensity = 90;
                    break;
                case #"hash_47368bc0d2ef1565":
                    intensity = 70;
                    break;
                case #"hash_bef5ec0b3e197ae":
                    intensity = 80;
                    break;
                case #"hash_16cf6289ab06bd30":
                    intensity = 80;
                    break;
                case #"hash_9d18adab1b65a661":
                    intensity = 70;
                    break;
                case #"hash_34340d457a63e7f1":
                    intensity = 40;
                    break;
                case #"hash_6f796b5c69cec63":
                    intensity = 50;
                    break;
                case #"hash_cd7f87dc1cdeaa54":
                    intensity = 50;
                    break;
                default:
                    break;
            }
            
            if ( intensity == 0 )
            {
                continue;
            }
            
            if ( objweapon issilenced() )
            {
                intensity *= 0.25;
            }
            
            if ( distsq < 10000 )
            {
                distscalar = 5;
            }
            else if ( distsq < 250000 )
            {
                distscalar = 3;
            }
            else if ( distsq < 1000000 )
            {
                distscalar = 2;
            }
            else if ( distsq < 4000000 )
            {
                distscalar = 0.5;
            }
            else if ( distsq < 9000000 )
            {
                distscalar = 0.25;
            }
            else
            {
                distscalar = 0.1;
            }
            
            distfrac = 1 - distsq / 16000000;
            distscalar *= distfrac;
            intensity *= distscalar;
            player addtointensitybuffer( "weaponFired", int( intensity ), 3 );
        }
    }
}

// Namespace battlechatter_mp
// Params 4
// Checksum 0x7b39ac93, Offset: 0x5586
// Size: 0xd8
function adddamagetaken( attacker, objweapon, idamage, weapongroup )
{
    if ( level.gametypebundle.var_db86d50e4e418523 )
    {
        return;
    }
    
    var_55aa1b54d804cfa0 = 0;
    
    if ( isdefined( objweapon ) && isdefined( attacker ) )
    {
        if ( !isdefined( weapongroup ) )
        {
            weapongroup = weapon::getweapongroup( objweapon );
        }
        
        if ( weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr" )
        {
            if ( distance2dsquared( self.origin, attacker.origin ) > 2250000 )
            {
                var_55aa1b54d804cfa0 = 1;
            }
        }
    }
    
    if ( var_55aa1b54d804cfa0 )
    {
        level thread trysaylocalsound( self, #"bc_combat_inform_taking_fire_long", 0.75 );
        return;
    }
    
    level thread trysaylocalsound( self, #"bc_combat_inform_taking_fire", 0.75 );
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x555c59bb, Offset: 0x5666
// Size: 0x285
function onsixfriendlytracking()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( game_utility_mp::lpcfeaturegated() )
    {
        return;
    }
    
    minplayers = getdvarint( @"party_minplayers", 8 );
    playercountlimit = getdvarint( @"hash_39051a5345da2c81", 0 );
    
    if ( playercountlimit > 0 && minplayers > playercountlimit )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    wait 5;
    var_f96cfcb82495f3ba = 0;
    
    if ( isdefined( level.squaddata ) && level.gamemodebundle.usesquadbattlechatter )
    {
        var_f96cfcb82495f3ba = 1;
    }
    
    if ( !isdefined( level.on_six_friendly_tracking ) )
    {
        level.on_six_friendly_tracking = throttle::throttle_initialize( "on_six_friendly_tracking", 2, undefined, 50 );
    }
    
    var_821c0de57a9b7352 = level.gamemodebundle.var_6dc67502c3e998c2 ?? 0.15;
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.on_six_friendly_tracking, self );
        
        if ( player::isreallyalive( self ) && !saidtoorecently( #"bc_status_inform_on_your_six" ) && length2dsquared( self getvelocity() ) > 22500 )
        {
            possible_listeners = [];
            
            if ( var_f96cfcb82495f3ba )
            {
                if ( isdefined( self.sessionsquadid ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
                {
                    possible_listeners = level.squaddata[ self.team ][ self.sessionsquadid ].players;
                }
            }
            else
            {
                possible_listeners = teams::function_44f7118a75adcad8( self.team, self.origin, 800 );
            }
            
            foreach ( listener in possible_listeners )
            {
                if ( listener == self )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( listener ) )
                {
                    continue;
                }
                
                if ( validatelistener( self, listener ) && function_fb3633bb3479f698( #"bc_status_inform_on_your_six" ) )
                {
                    level thread trysaylocalsound( self, #"bc_status_inform_on_your_six" );
                    break;
                }
            }
        }
        else
        {
            wait randomfloatrange( 1, 4 );
        }
        
        wait var_821c0de57a9b7352;
    }
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x396eb90b, Offset: 0x58f3
// Size: 0xcb, Type: bool
function validatelistener( speaker, listener )
{
    listenerorg = listener geteye();
    speakerorg = speaker geteye();
    
    if ( distancesquared( listenerorg, speakerorg ) > 90000 )
    {
        return false;
    }
    
    listenerdir = anglestoforward( listener getplayerangles() );
    tolistener = vectornormalize( listenerorg - speakerorg );
    dot = vectordot( listenerdir, tolistener );
    
    if ( dot > 0.05 )
    {
        trace = trace::ray_trace( speakerorg, listenerorg, speaker, level.var_8a9f018daa280c03 );
        
        if ( isplayer( trace[ "entity" ] ) || trace[ "fraction" ] > 0.8 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x566fc386, Offset: 0x59c7
// Size: 0xb
function getlistenerdirection()
{
    return anglestoforward( self getplayerangles() );
}

// Namespace battlechatter_mp
// Params 4
// Checksum 0xe10551f9, Offset: 0x59db
// Size: 0x149, Type: bool
function function_5858eff036132466( player, soundtype, var_eeb6a639148e00e7, var_1d06fce04f2eaed9 )
{
    if ( !level.battlechatterenabled )
    {
        return false;
    }
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( issimulationplayer( player ) )
    {
        return false;
    }
    
    if ( !isdefined( soundtype ) )
    {
        return false;
    }
    
    if ( player.bcdisabled && soundtype != "flavor_execution" )
    {
        return false;
    }
    
    if ( !var_1d06fce04f2eaed9 && !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( player.team == "spectator" )
    {
        return false;
    }
    
    if ( player.team == "codcaster" )
    {
        return false;
    }
    
    if ( !isdefined( player.bcinfolastsaytimes ) )
    {
        return false;
    }
    
    if ( player.isspeakingbc )
    {
        return false;
    }
    
    if ( !var_eeb6a639148e00e7 && player utility::isusingremote() )
    {
        return false;
    }
    
    if ( isdefined( player.perks[ "specialty_no_battle_chatter" ] ) )
    {
        return false;
    }
    
    if ( player.swim.underwater )
    {
        return false;
    }
    
    if ( isdefined( level.var_c549dc94926fcc57 ) && !player [[ level.var_c549dc94926fcc57 ]]( soundtype ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xe8fdb0e5, Offset: 0x5b2d
// Size: 0x72, Type: bool
function function_4a48202831f79c92( player, soundtype )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( issimulationplayer( player ) )
    {
        return false;
    }
    
    if ( !isdefined( soundtype ) )
    {
        return false;
    }
    
    if ( player.team == "spectator" )
    {
        return false;
    }
    
    if ( player.team == "codcaster" )
    {
        return false;
    }
    
    if ( !isdefined( player.bcinfolastsaytimes ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter_mp
// Params 9
// Checksum 0xca3ef7e7, Offset: 0x5ba8
// Size: 0x30e
function trysaylocalsound( player, soundtype, delay = 0, targetent, location, triggerent, var_eeb6a639148e00e7, var_1d06fce04f2eaed9, chanceoverride )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( !function_5858eff036132466( player, soundtype, var_eeb6a639148e00e7, var_1d06fce04f2eaed9 ) )
    {
        return 0;
    }
    
    /#
        if ( !isdefined( level.bcfrequency ) )
        {
            level.bcfrequency = [];
        }
        
        if ( !isdefined( level.bcfrequency[ soundtype ] ) )
        {
            level.bcfrequency[ soundtype ] = 0;
        }
        
        level.bcfrequency[ soundtype ]++;
    #/
    
    if ( function_e4a727aabb965579( soundtype ) && !player friendly_nearby( level.var_295625aa04d53bea ) )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                player battlechatter_debugprint( "<dev string:x13d>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        return 0;
    }
    
    play_chance = randomfloat( 1 );
    sound_chance = function_71b328647fac9cb5( soundtype );
    
    if ( isdefined( chanceoverride ) )
    {
        sound_chance = chanceoverride;
    }
    
    if ( play_chance > sound_chance )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                player battlechatter_debugprint( "<dev string:x154>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        return 0;
    }
    
    waittime = player getbcwaittime( soundtype, delay );
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                player battlechatter_debugprint( "<dev string:x169>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        return 0;
    }
    
    if ( gettime() > player.var_62959c1836eca399 + level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        player.bcinfoqueued = "none";
        player.var_62959c1836eca399 = 0;
    }
    
    if ( comparesoundpriorities( soundtype, player.bcinfoqueued ) )
    {
        player.bcinfoqueued = soundtype;
        player.var_62959c1836eca399 = gettime();
    }
    else
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                player battlechatter_debugprint( "<dev string:x17d>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        return 0;
    }
    
    level notify( "kill_queued_bc_sound_" + player.name );
    player callback::callback( #"hash_e23b3890b0905641", { #soundtype:soundtype } );
    var_db75d3de862ce072 = player saylocalsound( waittime, soundtype, delay, targetent, location, triggerent );
    player callback::callback( #"hash_e90d235499f4f420", { #var_db75d3de862ce072:var_db75d3de862ce072, #soundtype:soundtype } );
    
    /#
        if ( level.var_a272e6911c72572d )
        {
            player battlechatter_debugprint( "<dev string:x195>" + getxhashsourcename( soundtype ), "<dev string:x87>" );
        }
    #/
    
    return var_db75d3de862ce072;
}

// Namespace battlechatter_mp
// Params 7
// Checksum 0xac210fbb, Offset: 0x5ebf
// Size: 0x250
function saylocalsound( waittime, soundtype, delay, targetent, location, triggerent, var_5cf2151f61187a01 )
{
    level endon( "kill_queued_bc_sound_" + self.name );
    self endon( #"death_or_disconnect" );
    wait waittime * 0.001;
    
    while ( waittime <= level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        speakerinfo = getspeakerinfo( self, function_d99728ce8f7cdefd( soundtype ) );
        
        if ( isdefined( speakerinfo[ "higher" ] ) )
        {
            time = gettime();
            speakerinfo[ "higher" ][ "player" ] utility::waittill_any( getxhashhexname( speakerinfo[ "higher" ][ "sound_alias" ] ), "death", "disconnect" );
            waitframe();
            waittime += gettime() - time;
            continue;
        }
        
        break;
    }
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                battlechatter_debugprint( "<dev string:x19e>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        self.bcinfoqueued = "none";
        return 0;
    }
    
    entid = undefined;
    
    if ( !isdefined( self.var_257dbe03b8251ff3 ) )
    {
        self.var_257dbe03b8251ff3 = [];
    }
    
    if ( isdefined( triggerent ) )
    {
        entid = triggerent getentitynumber();
    }
    
    if ( saidtoorecently( soundtype ) )
    {
        /#
            if ( level.var_a272e6911c72572d )
            {
                battlechatter_debugprint( "<dev string:x1b5>" + getxhashsourcename( soundtype ), "<dev string:x90>" );
            }
        #/
        
        return 0;
    }
    else if ( isdefined( entid ) && isdefined( self.var_257dbe03b8251ff3[ entid ] ) )
    {
        return 0;
    }
    else if ( isdefined( entid ) )
    {
        self.var_257dbe03b8251ff3[ entid ] = gettime();
        thread function_eabe5c96b91c6a58( entid );
    }
    
    self.bcinfoqueued = "none";
    self.bcinfolastsaytimes[ soundtype ] = gettime();
    
    if ( isdefined( self.var_653219bf610c4f99 ) )
    {
        var_ecf9cae4872adeec = self [[ self.var_653219bf610c4f99 ]]( soundtype, waittime );
    }
    
    if ( istrue( var_ecf9cae4872adeec ) )
    {
        return 1;
    }
    
    return dosound( soundtype, targetent, location, var_5cf2151f61187a01 );
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x438aea59, Offset: 0x6117
// Size: 0x3e
function function_eabe5c96b91c6a58( entid )
{
    self endon( #"disconnect" );
    assert( isdefined( entid ) );
    wait 5;
    self.var_257dbe03b8251ff3 = arrayremove( self.var_257dbe03b8251ff3, entid );
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x429ffcfb, Offset: 0x615d
// Size: 0xf5
function function_ebba0c0adeab8f39( soundtype, distsq )
{
    timeoutteamtime = 0;
    
    foreach ( event in level.bcinfo[ "soundEventHistory" ][ soundtype ] )
    {
        if ( !isdefined( event.origin ) )
        {
            continue;
        }
        
        if ( distancesquared( event.origin, self.origin ) < distsq )
        {
            var_ee974c8cfcdeb26f = event.time + function_cc0bf34a8efedc3e( soundtype );
            
            if ( var_ee974c8cfcdeb26f > timeoutteamtime )
            {
                timeoutteamtime = var_ee974c8cfcdeb26f;
            }
        }
    }
    
    return timeoutteamtime;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x854ee464, Offset: 0x625b
// Size: 0x165
function function_b941c6b0a7c1b46d( soundtype )
{
    timeoutteamtime = 0;
    
    if ( isdefined( level.bcinfo[ "soundEventHistory" ][ soundtype ] ) )
    {
        if ( soundtype == #"bc_combat_inform_contact_generic" || soundtype == #"bc_combat_inform_contact" || soundtype == #"bc_combat_inform_contact_multiple" )
        {
            var_a0eb7fe48b468d99 = [];
            var_a0eb7fe48b468d99[ var_a0eb7fe48b468d99.size ] = #"bc_combat_inform_contact_generic";
            var_a0eb7fe48b468d99[ var_a0eb7fe48b468d99.size ] = #"bc_combat_inform_contact";
            var_a0eb7fe48b468d99[ var_a0eb7fe48b468d99.size ] = #"bc_combat_inform_contact_multiple";
            
            foreach ( entry in var_a0eb7fe48b468d99 )
            {
                if ( !isdefined( level.bcinfo[ "soundEventHistory" ][ entry ] ) )
                {
                    continue;
                }
                
                timeoutteamtime = function_ebba0c0adeab8f39( entry, 4000000 );
                
                if ( timeoutteamtime > 0 )
                {
                    break;
                }
            }
        }
        else if ( soundtype == #"bc_status_inform_on_your_six" )
        {
            timeoutteamtime = function_ebba0c0adeab8f39( soundtype, 2250000 );
        }
        else
        {
            timeoutteamtime = function_ebba0c0adeab8f39( soundtype, 1048576 );
        }
    }
    
    return timeoutteamtime;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xeb98d8dd, Offset: 0x63c9
// Size: 0xac
function getbcwaittime( soundtype, delay = 0 )
{
    if ( !isdefined( self.bcinfolastsaytimes[ soundtype ] ) )
    {
        self.bcinfolastsaytimes[ soundtype ] = 0;
    }
    
    var_20f77c4d4be7e025 = self.bcinfolastsaytimes[ soundtype ] + function_c8ccf346ee7145c9( soundtype );
    timeoutteamtime = function_b941c6b0a7c1b46d( soundtype );
    timeoutdelaytime = gettime() + delay * 1000;
    timeouttime = max( var_20f77c4d4be7e025, max( timeoutteamtime, timeoutdelaytime ) );
    waittime = timeouttime - gettime();
    return waittime;
}

// Namespace battlechatter_mp
// Params 3
// Checksum 0x194d8a30, Offset: 0x647e
// Size: 0x155
function getspeakerinfo( player, priority, range = 1000 )
{
    distsq = range * range;
    var_405adfb35f2d9829 = [];
    var_405adfb35f2d9829[ "lower" ] = [];
    
    if ( isdefined( player ) && isdefined( player.team ) && player.team != "spectator" )
    {
        for ( index = 0; index < level.speakers[ player.team ].size ; index++ )
        {
            speakerinfo = level.speakers[ player.team ][ index ];
            teammate = speakerinfo[ "player" ];
            speakerpriority = speakerinfo[ "priority" ];
            
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( distancesquared( teammate.origin, player.origin ) < distsq )
            {
                if ( isdefined( speakerpriority ) )
                {
                    if ( speakerpriority > priority || speakerpriority == priority && utility::cointoss() )
                    {
                        var_405adfb35f2d9829[ "higher" ] = speakerinfo;
                        return var_405adfb35f2d9829;
                    }
                    
                    var_405adfb35f2d9829[ "lower" ][ var_405adfb35f2d9829[ "lower" ].size ] = speakerinfo;
                }
            }
        }
    }
    
    return var_405adfb35f2d9829;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0x9f6a0bf3, Offset: 0x65dc
// Size: 0x82
function comparesoundpriorities( s1, s2 )
{
    none = s2 == "none";
    
    if ( none )
    {
        return none;
    }
    
    if ( s1 == s2 )
    {
        return 0;
    }
    
    higherpriority = function_d99728ce8f7cdefd( s2 ) < function_d99728ce8f7cdefd( s1 );
    var_6ed7bb2f8298bd43 = function_d99728ce8f7cdefd( s2 ) == function_d99728ce8f7cdefd( s1 ) && utility::cointoss();
    return higherpriority || var_6ed7bb2f8298bd43;
}

// Namespace battlechatter_mp
// Params 2
// Checksum 0xbb547057, Offset: 0x6667
// Size: 0x73
function saidtoorecently( soundtype, delay = 0 )
{
    if ( !isdefined( self ) || !team_utility::isgameplayteam( self.team ) )
    {
        return 1;
    }
    
    waittime = getbcwaittime( soundtype, delay );
    
    if ( waittime > level.bcinfo[ "max_wait_time" ] + delay * 1000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x345c91ce, Offset: 0x66e2
// Size: 0x5a
function function_d99728ce8f7cdefd( soundtype )
{
    value = level.bcinfo[ soundtype ].priority ?? 1;
    
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            value = getdvarfloat( @"hash_2fd0201afdc6ebb7", value );
        }
    #/
    
    return value;
}

// Namespace battlechatter_mp
// Params 0
// Checksum 0x5d2537bf, Offset: 0x6745
// Size: 0x2e
function function_c11e66db3108e2f7()
{
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            return getdvarfloat( @"hash_aedefef119495db3", 0.05 );
        }
    #/
    
    return 0.05;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xb24bc44a, Offset: 0x677c
// Size: 0x5d
function function_71b328647fac9cb5( soundtype )
{
    value = level.bcinfo[ soundtype ].chance ?? 1;
    
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            value = getdvarfloat( @"hash_aedefef119495db3", value );
        }
    #/
    
    return value;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x1b939b83, Offset: 0x67e2
// Size: 0x79
function function_cc0bf34a8efedc3e( soundtype )
{
    value = level.bcinfo[ soundtype ].timeoutpos ?? 1000;
    
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            dvar = getdvarint( @"hash_62c704ead5f57bbd", -1 ) * 1000;
            value = dvar < 0 ? value : dvar;
        }
    #/
    
    return value;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x54bd38ff, Offset: 0x6864
// Size: 0x79
function function_c8ccf346ee7145c9( soundtype )
{
    value = level.bcinfo[ soundtype ].timeoutspeaker ?? 1000;
    
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            dvar = getdvarint( @"hash_9748010473ada804", -1 ) * 1000;
            value = dvar < 0 ? value : dvar;
        }
    #/
    
    return value;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x50eff11c, Offset: 0x68e6
// Size: 0x5a
function function_e4a727aabb965579( soundtype )
{
    value = level.bcinfo[ soundtype ].var_82af015320b0af0a ?? 1;
    
    /#
        if ( getdvarint( @"hash_79ddcdfeb089c288", 0 ) )
        {
            value = getdvarint( @"hash_4a6b25f970546c12", value );
        }
    #/
    
    return value;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0xcc80f3a8, Offset: 0x6949
// Size: 0x17
function function_1faea47bf380fcff( soundevent )
{
    self.var_4a15440ba6393db8 = soundevent;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x2c0f9e7a, Offset: 0x6968
// Size: 0xc5
function function_694f04feb7ef7c08( soundtype )
{
    if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
    {
        /#
            if ( !isdefined( level.bcinfo[ soundtype ].conversation ) )
            {
                println( "<dev string:x1c7>" + getxhashsourcename( soundtype ) );
            }
        #/
        
        return ( self.var_4a15440ba6393db8 ?? level.bcinfo[ soundtype ].conversation );
    }
    
    /#
        if ( !isdefined( level.bcinfo[ soundtype ].soundevent ) )
        {
            println( "<dev string:x202>" + getxhashsourcename( soundtype ) );
        }
    #/
    
    return self.var_4a15440ba6393db8 ?? level.bcinfo[ soundtype ].soundevent;
}

// Namespace battlechatter_mp
// Params 1
// Checksum 0x314d3027, Offset: 0x6a35
// Size: 0x5c, Type: bool
function function_fb3633bb3479f698( soundtype )
{
    if ( getdvarint( @"hash_75f7e9a6e0f0d3a6", 1 ) )
    {
        if ( isdefined( level.bcinfo[ soundtype ].conversation ) )
        {
            return true;
        }
    }
    else if ( isdefined( level.bcinfo[ soundtype ].soundevent ) )
    {
        return true;
    }
    
    return false;
}

