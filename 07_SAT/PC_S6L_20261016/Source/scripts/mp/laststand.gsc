// scripts\mp\laststand.gsc  (hash_08c8e132af264960.gscc) (size: 89039 Bytes / 0x15bcf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90b43585 (2427729285)
// size ...... 89039 (0x15bcf)
// includes .. 60  (offset: 0x1478f)
// strings ... 262 (offset: 0x1496f)
// dev strs .. 38  (offset: 0x15977)
// exports ... 167 (offset: 0xe21b)
// cseg ...... 0x17b2 + 0xca69 (0xe21b)
// imports ... 570 (offset: 0xfc33)
// animtree1 . 0   (offset: 0x15bcf)
// animtree2 . 0   (offset: 0x15bcf)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\ai_behavior;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots_util;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\health_chunks;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\quickprompt;
#using scripts\mp\rank;
#using scripts\mp\stealth\utility;
#using scripts\mp\supers;
#using scripts\mp\swim_cp_mp;
#using scripts\mp\teamrevive;
#using scripts\mp\weapons;

#namespace laststand;

// Namespace laststand
// Params 0
// Checksum 0xd329c0d8, Offset: 0x17d0
// Size: 0x88
function init()
{
    initvalues();
    setdvarifuninitialized( @"scr_interrogation_use_time", 3 );
    setdvarifuninitialized( @"scr_interrogation_use_range", 100 );
    
    /#
        setdevdvarifuninitialized( @"hash_f1bef8e461ed63f", 0 );
        level thread function_890862c8bafd8718();
    #/
    
    level.interrogationcount = 0;
    
    if ( !isdefined( level.removeselfrevivetoken ) )
    {
        level.removeselfrevivetoken = &function_7a1a4fa42d3ac8e3;
    }
    
    if ( level.gamemodebundle.var_3313c68489eb451b )
    {
        level.var_894cf9c132c87505 = 1;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1be4731e, Offset: 0x1860
// Size: 0xad4
function private initvalues()
{
    level.laststandreviveents = [];
    laststandallows = [ "usability", "weapon_switch", "supers", "gesture", "killstreaks", "offhand_primary_weapons", "offhand_secondary_weapons", "melee" ];
    laststanddisallows = [];
    var_e8f6e6b36d9bc2c5 = [ "allow_movement", "usability", "reload", "fire", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "killstreaks", "supers", "gesture", "allow_jump", "sprint", "melee" ];
    var_b36c2ecefe20b782 = [ "allow_movement" ];
    var_d6520d0773789096 = [];
    level.laststandhealth = int( getmatchrulesdata( "commonOption", "lastStandHealth" ) );
    level.laststandrevivehealth = int( getmatchrulesdata( "commonOption", "lastStandReviveHealth" ) );
    level.laststandinvulntime = getmatchrulesdata( "commonOption", "lastStandInvulnTime" );
    level.laststandrevivetimer = getmatchrulesdata( "commonOption", "lastStandReviveTimer" );
    level.lastStandTourniquetReviveTimer = getmatchrulesdata( "commonOption", "lastStandTourniquetReviveTimer" );
    level.laststandtimer = getmatchrulesdata( "commonOption", "lastStandTimer" );
    level.laststandsuicidetimer = getmatchrulesdata( "commonOption", "lastStandSuicideTimer" );
    level.laststandoutlineenabled = getmatchrulesdata( "commonOption", "lastStandOutlineEnabled" );
    level.laststandselfreviveanim = getmatchrulesdata( "commonOption", "lastStandSelfReviveAnim" );
    level.var_9c52ff443b88448b = getmatchrulesdata( "commonOption", "aiDisperseWhenPlayerDowned" );
    level.lastStandDamageTakenScalar = getmatchrulesdata( "commonOption", "lastStandDamageTakenScalar" );
    
    /#
        level.laststandrevivetimer = getdvarfloat( @"hash_6dccd7aa96ecca06", level.laststandrevivetimer );
    #/
    
    if ( level.gametypebundle.var_f7284509ebf06d6 )
    {
        level.gametypebundle.var_f7284509ebf06d6 = makeweapon( level.gametypebundle.var_f7284509ebf06d6 );
    }
    
    if ( level.gametypebundle.selfreviveweapon )
    {
        level.gametypebundle.selfreviveweapon = makeweapon( level.gametypebundle.selfreviveweapon );
    }
    
    if ( level.gametypebundle.var_2fd140faf0ba7b8f )
    {
        level.gametypebundle.var_2fd140faf0ba7b8f = makeweapon( level.gametypebundle.var_2fd140faf0ba7b8f );
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        level.var_6a8e88d5a8429194.var_ccafe692270ab7cd = int( level.laststandrevivetimer * 1000 );
    }
    
    if ( level.var_9c52ff443b88448b )
    {
        level.var_d5f7e5f1356e78e4 = getmatchrulesdata( "commonOption", "aiDisperseInitialRange" );
        level.var_b23f2dff710a71ce = getmatchrulesdata( "commonOption", "aiDisperseRange" );
        level.var_85106271d80e943c = getmatchrulesdata( "commonOption", "aiDisperseTimeout" );
    }
    
    if ( isdefined( level.gametypebundle ) )
    {
        level.laststandrevivedecayscale = level.gametypebundle.laststandrevivedecayscale;
        level.laststandweapon = level.gametypebundle.laststandweapon;
        level.var_e81084285fb4b6c9 = level.gametypebundle.var_e81084285fb4b6c9;
        level.var_28e3415171f7169b = level.gametypebundle.var_28e3415171f7169b;
        level.var_7b86745abab35c1b = level.gametypebundle.var_fe359ff30f671d52;
        level.var_5f302c2ba0dcf24f = level.gametypebundle.var_5f302c2ba0dcf24f;
        level.var_60f16545279443d6 = level.gametypebundle.var_60f16545279443d6;
        
        if ( isdefined( level.gametypebundle.laststandallows ) && level.gametypebundle.laststandallows.size > 0 )
        {
            laststandallows = [];
            
            foreach ( allow in level.gametypebundle.laststandallows )
            {
                laststandallows[ laststandallows.size ] = allow.value;
            }
        }
        
        if ( level.gametypebundle.laststanddisallows && level.gametypebundle.laststanddisallows.size > 0 )
        {
            laststanddisallows = [];
            
            foreach ( allow in level.gametypebundle.laststanddisallows )
            {
                laststanddisallows[ laststanddisallows.size ] = allow.value;
            }
        }
        
        if ( isdefined( level.gametypebundle.var_e8f6e6b36d9bc2c5 ) && level.gametypebundle.var_e8f6e6b36d9bc2c5.size > 0 )
        {
            var_e8f6e6b36d9bc2c5 = [];
            
            foreach ( allow in level.gametypebundle.var_e8f6e6b36d9bc2c5 )
            {
                var_e8f6e6b36d9bc2c5[ var_e8f6e6b36d9bc2c5.size ] = allow.value;
            }
        }
        
        if ( isdefined( level.gametypebundle.var_b36c2ecefe20b782 ) && level.gametypebundle.var_b36c2ecefe20b782.size > 0 )
        {
            var_b36c2ecefe20b782 = [];
            
            foreach ( allow in level.gametypebundle.var_b36c2ecefe20b782 )
            {
                var_b36c2ecefe20b782[ var_b36c2ecefe20b782.size ] = allow.value;
            }
        }
        
        if ( isdefined( level.gametypebundle.var_d6520d0773789096 ) && level.gametypebundle.var_d6520d0773789096.size > 0 )
        {
            var_d6520d0773789096 = [];
            
            foreach ( allow in level.gametypebundle.var_d6520d0773789096 )
            {
                var_d6520d0773789096[ var_d6520d0773789096.size ] = allow.value;
            }
        }
    }
    
    if ( isdefined( level.gamemodebundle ) )
    {
        level.var_4815c4eaafd6d12c = level.gamemodebundle.var_4815c4eaafd6d12c;
    }
    
    if ( !isdefined( level.laststandrevivedecayscale ) )
    {
        level.laststandrevivedecayscale = 0.5;
    }
    
    if ( !isdefined( level.var_28e3415171f7169b ) )
    {
        level.var_28e3415171f7169b = 0;
    }
    
    if ( !isdefined( level.var_7b86745abab35c1b ) )
    {
        level.var_7b86745abab35c1b = 0.5;
    }
    
    if ( !isdefined( level.var_4815c4eaafd6d12c ) )
    {
        level.var_4815c4eaafd6d12c = 1.7;
    }
    
    if ( !isdefined( level.var_60f16545279443d6 ) )
    {
        level.var_60f16545279443d6 = 0;
    }
    
    if ( !isdefined( level.var_55e4db63d87c12c1 ) )
    {
        level.var_55e4db63d87c12c1 = 0;
    }
    
    if ( !isdefined( level.var_92b9a0cbf749d8c6 ) )
    {
        level.var_92b9a0cbf749d8c6 = 200;
    }
    
    if ( !isdefined( level.var_3c7a3634fcc7331b ) )
    {
        level.var_3c7a3634fcc7331b = 128;
    }
    
    if ( !isdefined( level.var_8a6748b072b9c6c4 ) )
    {
        level.var_8a6748b072b9c6c4 = 1;
    }
    
    level.var_99884af80074e803 = level.gametypebundle.var_99884af80074e803 ?? "teammate_revive_stim_mp";
    
    if ( !getdvarint( @"hash_794a59acd7c0c68f", 1 ) )
    {
        level.laststandhealth = int( min( level.laststandhealth, getmatchrulesdata( "commonOption", "maxHealth" ) ) );
        level.laststandrevivehealth = int( min( level.laststandrevivehealth, getmatchrulesdata( "commonOption", "maxHealth" ) ) );
    }
    
    val::group_register( "laststand", laststandallows );
    val::group_register( "laststand_disallows", laststanddisallows );
    val::group_register( "laststand_revive", var_e8f6e6b36d9bc2c5 );
    val::group_register( "laststand_being_revived", var_b36c2ecefe20b782 );
    val::group_register( "laststand_being_revived_disallows", var_d6520d0773789096 );
    level.var_3e5605730504d2c = "laststand_revive";
    level thread laststandmonitor();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"down_player", &function_c14202a5cdad535f );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"revive_player", &devgui_revive_player );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_self_revive", &function_1c3b24c5be40760f );
    
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        scriptable::scriptable_addusedcallbackbypart( "laststand", &function_a3617bdebbe3ea9f );
        level.var_34882926662de79c = level.gametypebundle.var_34882926662de79c && getdvarint( @"hash_401608892a93634e", 1 ) == 1;
        
        if ( level.var_34882926662de79c )
        {
            scriptable::scriptable_addusedcallbackbypart( "drag_enemy", &function_6aa666d855e5c1a9 );
        }
    }
    
    if ( level.gametypebundle.var_fc0ae8074178e65a )
    {
        callback::add( #"player_damaged", &onplayerdamaged );
    }
    
    /#
        callback::add( #"player_spawned", &function_3c0e58d5c6da29d7 );
    #/
    
    /#
        level thread function_eb11297dab3c50b8();
        level thread function_cd6ad26967e91ea3();
        level thread function_28aaad601277e9e3();
        level thread setup_laststand_devgui();
    #/
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x28e2f6f0, Offset: 0x233c
// Size: 0xa4
function private get_last_stand_timer()
{
    /#
        devlaststandtimer = getdvarint( @"hash_9ff69b2a319da87b", 0 );
        
        if ( devlaststandtimer > 0 )
        {
            return devlaststandtimer;
        }
    #/
    
    if ( self.var_5629b291aa700093 )
    {
        return ( level.perkbundles[ "specialty_rally_point" ].rally_point_laststandtimer ?? 3 );
    }
    
    bleedouttimer = self.var_57e1d1441440e957 ?? level.laststandtimer;
    
    if ( isdefined( self.perks[ "specialty_longer_bleedout" ] ) && isdefined( self.var_18f4ebec6ae0c1db ) )
    {
        bleedouttimer *= self.var_18f4ebec6ae0c1db;
    }
    
    return bleedouttimer;
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xd903d28c, Offset: 0x23e9
// Size: 0x62
function private shoulddodamageinlaststand()
{
    if ( !isdefined( level.var_bb98e423798b037d ) )
    {
        level.var_bb98e423798b037d = isdefined( level.gametypebundle ) && level.gametypebundle.bleedoutinlaststand;
        level.var_bb98e423798b037d = getdvarint( @"hash_1711fa4ed632433a", level.var_bb98e423798b037d );
    }
    
    return level.var_bb98e423798b037d;
}

// Namespace laststand
// Params 1
// Checksum 0x56ecfb9d, Offset: 0x2454
// Size: 0xbcb
function enter( params )
{
    self endon( #"disconnect" );
    self endon( #"last_stand_exit" );
    self.var_cc09887c7db65ab5 = 0;
    self.inlaststand = 1;
    self.playergoingintols = undefined;
    self.hasshownlaststandicon = 0;
    self.laststandstarttime = gettime();
    self.var_2acdae9aaa7c06db = { #attackerorigin:params.attacker.origin, #victimorigin:self.origin };
    function_c26a7c4bf9ba9d98( self, "Enter" );
    self notify( #"last_stand_enter" );
    self setclientomnvar( "ui_is_laststand", 1 );
    self setclientomnvar( "ui_perk_fast_reviver_25", 0 );
    
    if ( self isonladder() )
    {
        self clearladderstate();
    }
    
    if ( self ishanging() )
    {
        self clearhanging();
    }
    
    if ( !level.var_27d1beb8576f49c4 )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_last_stand", 0.25, undefined, undefined, undefined, undefined, 1 );
    }
    
    if ( utility::issharedfuncdefined( #"hash_a4d82011a2a333b3", #"selfreviveready" ) )
    {
        var_a9c57737c2b9710d = self [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"selfreviveready" ) ]]();
        self.var_5f87feddcabb8ed = var_a9c57737c2b9710d && !self.hasselfrevivetoken;
    }
    
    if ( isdefined( self.perks[ "specialty_survivor" ] ) )
    {
        self.var_300ce019f5fb0cb0 = 1;
    }
    
    if ( isdefined( self.perks[ "specialty_ping_attacker_on_laststand" ] ) && self.var_2acdae9aaa7c06db.attackerorigin )
    {
        var_6675b0888e2dbc2 = function_1bf3a084cfe14025( 4 );
        pingindex = calloutmarkerping::function_a3f0d6526c09f579( var_6675b0888e2dbc2, self.var_2acdae9aaa7c06db.attackerorigin + ( 0, 0, 50 ) );
        thread calloutmarkerping::predicted_timeout( pingindex );
    }
    
    healthvalue = level.laststandhealth;
    
    if ( isdefined( self.laststandhealth ) )
    {
        healthvalue = self.laststandhealth;
    }
    
    if ( isdefined( self.laststandmaxhealth ) )
    {
        if ( getdvarint( @"hash_794a59acd7c0c68f", 1 ) && !isdefined( self.defaultmaxhealth ) && self.laststandmaxhealth < self.maxhealth )
        {
            self.defaultmaxhealth = self.maxhealth;
        }
        
        self.maxhealth = self.laststandmaxhealth;
    }
    
    thread last_stand_postfx();
    thread last_stand_sfx();
    var_5489eeafe1e4a59f = player::function_73fe5f51164eb3ca( self );
    
    if ( var_5489eeafe1e4a59f )
    {
        healthvalue = level.laststand_syringe_params.laststandhealth;
    }
    
    if ( self.var_c9d64d44c487df08 )
    {
        healthvalue += self.var_c9d64d44c487df08;
    }
    
    if ( healthvalue > self.maxhealth )
    {
        if ( getdvarint( @"hash_794a59acd7c0c68f", 1 ) && !isdefined( self.defaultmaxhealth ) )
        {
            self.defaultmaxhealth = self.maxhealth;
        }
        
        self.maxhealth = healthvalue;
    }
    
    function_c26a7c4bf9ba9d98( self, "Enter Health State -- lastStandMaxHealth: " + ( self.laststandmaxhealth ?? "undefined" ) + ", defaultMaxHealth: " + ( self.defaultmaxhealth ?? "undefined" ) + ", maxHealth: " + self.maxhealth + ", healthValue: " + healthvalue + ", syringe: " + var_5489eeafe1e4a59f );
    self.health = healthvalue;
    killstreak_utility::function_bea4bda17e40ffb0( self );
    var_d0d106ec8d7a3b2a = level.laststandinvulntime;
    
    if ( var_5489eeafe1e4a59f )
    {
        var_d0d106ec8d7a3b2a = utility::callsharedfunc( #"super_laststand_syringe", #"hash_21904dd7b76e4e86" );
    }
    
    thread makelaststandinvuln( var_d0d106ec8d7a3b2a );
    perk::giveperk( "specialty_block_health_regen" );
    
    if ( !level.gametypebundle.var_e079856e0e676726 )
    {
        perk::giveperk( "specialty_blindeye" );
        self.var_749da53869a2455a = 1;
    }
    
    self.ignoreafkcheck = 1;
    
    if ( self.var_6798be769a21cff4 )
    {
        thread utility::callsharedfunc( #"perks", #"dropsmoke" );
    }
    
    if ( isbrgamemode() && !self.hasselfrevivetoken && !self.var_5f87feddcabb8ed )
    {
        if ( isdefined( level.checkforlaststandfinish ) )
        {
            [[ level.checkforlaststandfinish ]]();
        }
    }
    
    if ( level.var_9c52ff443b88448b )
    {
        range = level.var_d5f7e5f1356e78e4 ?? 1200;
        squadindices = [];
        nearbyenemies = getaiarrayinradius( self.origin, range, "team_hundred_ninety_four" );
        
        foreach ( enemy in nearbyenemies )
        {
            squadindex = function_8398629a6c526ce3( enemy );
            squadindices = arraycombineunique( squadindices, [ squadindex ] );
        }
        
        foreach ( squad in squadindices )
        {
            leader = function_252fa45066454603( squad );
            
            if ( !leader )
            {
                [ leader ] = aigetsquadmembers( squad );
            }
            
            if ( leader )
            {
                leader thread ai_behavior::function_3ac31cb42020b04b( self, squad );
            }
        }
    }
    
    self.var_43e908b7c0cde1b1 = 0;
    
    if ( utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) )
    {
        self.timeuntilbleedout = get_last_stand_timer();
        lower_message::setlowermessageomnvar( "survivor_revive", int( gettime() + self.timeuntilbleedout * 1000 ) );
    }
    
    if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_die_hard" ) )
    {
        extratime = level.zombie_augments[ #"quick_revive_die_hard" ].var_8e4c8379db0d055c ?? 0;
        self.var_57e1d1441440e957 = level.laststandtimer + extratime;
    }
    
    last_stand_fighter_duration = self.var_6548468bdfcab076.bundle.var_dd06a65897fbddd3 ?? self.var_2dafacf75779fa44;
    
    if ( last_stand_fighter_duration )
    {
        self.var_57e1d1441440e957 = last_stand_fighter_duration;
    }
    
    self.laststandoldweaponobj = inventory::getlastweapon();
    
    if ( self.laststandoldweaponobj == level.var_f8ac15ada97a702a )
    {
        self.laststandoldweaponobj = inventory::getfirstprimaryweapon();
    }
    
    if ( getdvarint( @"g_laststandgrenadecancel", 0 ) != 0 )
    {
        self canceloffhands();
    }
    else if ( getdvarint( @"g_laststandgrenaderelease", 0 ) != 0 )
    {
        self releaseoffhand();
    }
    
    laststandweapon = level.laststandweapon;
    
    if ( var_5489eeafe1e4a59f )
    {
        laststandweapon = self [[ level.laststand_syringe_params.laststandweaponcallback ]]();
    }
    else if ( isdefined( level.var_449c32a0f392eed7 ) )
    {
        laststandweapon = self [[ level.var_449c32a0f392eed7 ]]();
    }
    else if ( isdefined( level.laststandweaponcallback ) && getdvarint( @"hash_ddd02929770fcc8c", 0 ) )
    {
        laststandweapon = self [[ level.laststandweaponcallback ]]();
    }
    
    if ( !isweapon( laststandweapon ) )
    {
        laststandweapon = weapon_utility::function_d2c8356dc369d9ce( laststandweapon );
    }
    
    self.laststandweaponobj = laststandweapon;
    
    if ( !self.usingascender )
    {
        self stopanimscriptsceneevent();
    }
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
    
    if ( isdefined( level.modeonlaststandfunc ) )
    {
        self [[ level.modeonlaststandfunc ]]();
    }
    
    if ( vehicle::is_in_vehicle() )
    {
        vehicle = vehicle::get_vehicle();
        vehicle_seat = vehicle_occupancy::get_occupant_seat( vehicle, self );
        waittillframeend();
        
        if ( !isdefined( self ) || !isalive( self ) )
        {
            thread exit( "death_or_disconnect" );
            return;
        }
        
        assert( !vehicle::is_in_vehicle(), "<dev string:x24>" );
    }
    
    val::group_set( "laststand", 0 );
    val::group_set( "laststand_disallows", 1 );
    callback::callback( #"hash_9741c7ee14b21924", params );
    thread handlelaststandweapongivepipeline( laststandweapon );
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_10b665eb486248a0 )
    {
        addoverheadicon( var_5489eeafe1e4a59f );
    }
    
    function_d26c92ad0232d340();
    var_26236525b4c44696 = level.laststandsuicidetimer;
    shellshock_utility_cpmp::_shellshock( %"last_stand_mp", #"damage", var_26236525b4c44696, 0 );
    thread function_6c04467360c60454();
    thread function_e85a9db170dab695();
    thread function_f2a02b3b33e52ebb();
    thread function_15b441f84b01abfb();
    self.fastcrouchspeedmod = getdvarfloat( @"hash_1a0de898609317b4", 0 );
    
    if ( isdefined( self.laststandattacker ) && isdefined( self.laststandattacker.perks[ "specialty_reduce_regen_delay_on_kill" ] ) )
    {
        self.laststandattacker utility::callsharedfunc( #"specialty_reduce_regen_delay_on_kill", #"reduceregendelayonkill" );
    }
    
    if ( !self.var_1b44e655388ae22f )
    {
        if ( !shoulddodamageinlaststand() )
        {
            childthread stucktime( var_26236525b4c44696 );
        }
        else
        {
            if ( isdefined( self.sessionuimemberindex ) && level.laststandoutlineenabled )
            {
                outlinename = "outline_nodepth_brplayer" + self.sessionuimemberindex + 1;
                self.laststandoutlineid = outline::outlineenableforteam( self, self.team, outlinename, "laststand" );
            }
            
            childthread dodamagewhiledown();
        }
        
        setplayerdownedextrainfo( 1 );
    }
    
    function_4cc4db36852a8494();
    challenges::function_5d58465654e002f2( self );
    thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #self_notify:"last_stand_exit", #timeout:90, #amount:3, #name:"laststand" } );
    callback::callback( #"player_laststand", params );
    
    if ( params.attacker )
    {
        params.attacker callback::callback( #"hash_d878d6ba342dc1b", params );
        
        if ( isplayer( params.attacker ) && params.attacker != self )
        {
            if ( isdefined( vehicle ) && isdefined( vehicle_seat ) && vehicle_occupancy::is_driver_seat( vehicle, vehicle_seat ) )
            {
                params.var_48fa51f4669ad6c7 = 1;
            }
            
            params.attacker events::function_a2d92a4b5cb17d36( self, params.objweapon, params.weapongroup, params.meansofdeath, params.inflictor, params );
            self.laststandattackermodifiers = params.attacker.modifiers;
        }
    }
}

// Namespace laststand
// Params 3
// Checksum 0xa763d8ce, Offset: 0x3027
// Size: 0x36
function function_d6eb0953f405b9a5( vehicle, vehicle_seat, data )
{
    waittillframeend();
    
    if ( self && vehicle )
    {
        vehicle_occupancy::exit( vehicle, vehicle_seat, self, data );
    }
}

// Namespace laststand
// Params 2
// Checksum 0xcd70526d, Offset: 0x3065
// Size: 0xccb
function exit( reason, reviver )
{
    if ( isdefined( self ) && getdvarint( @"hash_355efad440af5d80", 1 ) )
    {
        self selfrevivingdoneanimevent();
    }
    
    if ( !player::isinlaststand( self ) )
    {
        return;
    }
    
    function_c26a7c4bf9ba9d98( self, "Exit " + ( reason ?? "unknown" ) );
    revived = 0;
    
    switch ( reason )
    {
        case #"hash_70efd3e705769a7":
        case #"hash_a7951892dd77e7b":
        case #"hash_dccb21d8e667c89":
        case #"hash_43be764b02f25029":
        case #"hash_509b89c1ae7a9f0c":
        case #"hash_78e2c6651e575b62":
        case #"hash_79af97a8e2e98459":
        case #"hash_b243780976de8aa7":
        case #"hash_d95fe2980633f282":
        case #"hash_e2044478fd7c558e":
            revived = 1;
            break;
        default:
            if ( isdefined( level.var_eab5686cd39afa9b ) )
            {
                foreach ( s_validation in level.var_eab5686cd39afa9b )
                {
                    if ( reason === s_validation.reason )
                    {
                        revived = 1;
                    }
                }
            }
            
            break;
    }
    
    params = { #reason:reason, #revived:revived };
    callback::callback( #"player_laststand_exit", params );
    
    if ( isdefined( self.laststandreviveent ) )
    {
        function_c33e886a836f5aea( self.laststandreviveent, self );
        self.laststandreviveent selfrevivebuttonpresscleanup( reason == "health_chunk_revive" );
        self.laststandreviveent useholdthinkcleanup( "last_stand_exit" );
        
        if ( level.gametypebundle.var_beecd443c84bb043 )
        {
            self.laststandreviveent freescriptable();
        }
        else
        {
            self.laststandreviveent delete();
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( function_71ad4ea4ebadba11( reason ) )
    {
        reviver = self;
    }
    
    self.isselfreviving = 0;
    player::setbeingrevivedinternal( 0 );
    
    if ( function_71ad4ea4ebadba11( reason ) )
    {
        self selfrevivingdoneanimevent();
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        setplayerbeingrevivedextrainfo( 0 );
        setplayerselfrevivingextrainfo( 0 );
    }
    
    val::group_reset( "laststand" );
    val::group_reset( "laststand_disallows" );
    setplayerdownedextrainfo( 0 );
    
    if ( revived )
    {
        if ( !level.gameended )
        {
            events::revivedplayer( reviver, self );
            challenges::function_ecd6ed381762a4eb( reviver, self );
            
            if ( reviver != self )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( reviver ) ) )
                {
                    if ( isdefined( reviver.leaderboarddata[ "rescues" ] ) )
                    {
                        reviver.leaderboarddata[ "rescues" ] = reviver.leaderboarddata[ "rescues" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "rescues" ] ) )
                    {
                        [[ level.leaderboardfunc[ "rescues" ] ]]( reviver, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x53>" );
                    
                    if ( isdefined( reviver.pers[ "rescues" ] ) )
                    {
                        reviver.pers[ "rescues" ] = reviver.pers[ "rescues" ] + 1;
                    }
                }
                
                reviver codcasterclientmatchdata::function_8ecc753b54a5740f( 17, 1 );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "rescued" ] ) )
                    {
                        self.leaderboarddata[ "rescued" ] = self.leaderboarddata[ "rescued" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "rescued" ] ) )
                    {
                        [[ level.leaderboardfunc[ "rescued" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x53>" );
                    
                    if ( isdefined( self.pers[ "rescued" ] ) )
                    {
                        self.pers[ "rescued" ] = self.pers[ "rescued" ] + 1;
                    }
                }
            }
        }
        
        var_d0481c7a6236aee = 0;
        
        if ( reviver.var_4a593d6aa991b3e2 && reviver != self )
        {
            var_d0481c7a6236aee = reviver.var_4a593d6aa991b3e2.isoverride;
            
            if ( reviver.var_4a593d6aa991b3e2.alias && soundexists( reviver.var_4a593d6aa991b3e2.alias ) )
            {
                playsoundatpos( self.origin, reviver.var_4a593d6aa991b3e2.alias );
            }
        }
        
        if ( !var_d0481c7a6236aee && level.gamemodebundle.var_73831f7a8d88a6ed && soundexists( level.gamemodebundle.var_73831f7a8d88a6ed ) )
        {
            var_daf98418d6bb68b3 = level.gamemodebundle.var_8a0f9a2dc82bdcb3 ?? "";
            
            switch ( var_daf98418d6bb68b3 )
            {
                case #"hash_f7617d2fbcadfb4c":
                    self playsoundtoteam( level.gamemodebundle.var_73831f7a8d88a6ed, self.team, undefined, self );
                    break;
                default:
                    playsoundatpos( self.origin, level.gamemodebundle.var_73831f7a8d88a6ed );
                    break;
            }
        }
        
        if ( reviver != self )
        {
            if ( isdefined( level.gamemodebundle.var_7047696edb2f2de7 ) && soundexists( level.gamemodebundle.var_7047696edb2f2de7 ) )
            {
                reviver playlocalsound( level.gamemodebundle.var_7047696edb2f2de7 );
            }
            
            if ( self.team == reviver.team )
            {
                if ( quickprompt::quickpromptisenabled() && quickprompt::function_b9b3aad14238043d() )
                {
                    thread quickprompt::quickpromptshow( 2 );
                }
                
                if ( !level.var_27d1beb8576f49c4 )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_revived" );
                }
            }
            else if ( !level.var_27d1beb8576f49c4 )
            {
                level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_revived_hostile" );
            }
        }
        else
        {
            level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_selfrevived" );
        }
        
        self.var_bb32c697bfd2450d = reviver;
    }
    
    takelaststandtransitionweapon();
    thread function_6f62cb98d5e9b776();
    thread function_7ee2bc98c2a16455();
    
    switch ( reason )
    {
        case #"hash_70efd3e705769a7":
        case #"hash_a7951892dd77e7b":
        case #"hash_dccb21d8e667c89":
        case #"hash_43be764b02f25029":
        case #"hash_509b89c1ae7a9f0c":
        case #"hash_78e2c6651e575b62":
        case #"hash_79af97a8e2e98459":
        case #"hash_7a3f5c1586f73c31":
        case #"hash_b243780976de8aa7":
        case #"hash_d95fe2980633f282":
        case #"hash_e2044478fd7c558e":
            onrevive( reason == "last_stand_self_revive", 0, reason );
            break;
        case #"hash_3bdc47f2a9a60e34":
        case #"hash_cbbbbafae54d0dd6":
            ondeath();
            break;
        default:
            if ( isdefined( level.var_eab5686cd39afa9b ) )
            {
                foreach ( s_validation in level.var_eab5686cd39afa9b )
                {
                    if ( reason === s_validation.reason )
                    {
                        onrevive( s_validation.wasselfrevive, s_validation.var_b2b5c6713127c937, reason );
                    }
                }
            }
            
            break;
    }
    
    self.defaultmaxhealth = undefined;
    self.var_c3ca6e1ab237a810 = undefined;
    killstreak_utility::function_c463ddccb4054cc2( self );
    thread clearlaststandinvuln();
    self.fastcrouchspeedmod = 0;
    weapons::updatemovespeedscale();
    
    if ( isdefined( self.perks[ "specialty_block_health_regen" ] ) )
    {
        perk::removeperk( "specialty_block_health_regen" );
    }
    
    if ( self.var_749da53869a2455a )
    {
        if ( isdefined( self.perks[ "specialty_blindeye" ] ) )
        {
            perk::removeperk( "specialty_blindeye" );
        }
        
        self.var_749da53869a2455a = undefined;
    }
    
    if ( revived )
    {
        if ( self.health / self.maxhealth >= ( level.var_b487d47112fa93d ?? 0.7 ) )
        {
            damage_effects::onexitdeathsdoor( 1 );
        }
        else
        {
            playerhealth::updatedeathsdoor();
            playerhealth::function_422b3e88b85c7745();
        }
    }
    
    laststandweapon = isweapon( self.laststandweaponobj ) ? self.laststandweaponobj : weapon_utility::function_d2c8356dc369d9ce( level.laststandweapon );
    
    if ( !self.var_348359045a2cf8e1 && ( !isdefined( self.laststand_syringe_status.var_450c442291e5ba1d ) || self.laststand_syringe_status.var_450c442291e5ba1d == 0 ) )
    {
        if ( !inventory_utility::iscurrentweapon( laststandweapon ) )
        {
            self notify( #"hash_74efa09e6ddc75c1" );
            inventory_utility::abortmonitoredweaponswitch( laststandweapon );
        }
        else
        {
            inventory_utility::_takeweapon( laststandweapon );
        }
    }
    
    foreach ( weapon in [ level.gametypebundle.var_f7284509ebf06d6, level.gametypebundle.selfreviveweapon, level.gametypebundle.var_2fd140faf0ba7b8f ] )
    {
        if ( weapon && self hasweapon( weapon ) )
        {
            inventory_utility::_takeweapon( weapon );
        }
    }
    
    last_stand_exit_postfx();
    last_stand_exit_sfx();
    self notify( #"last_stand_exit" );
    
    if ( game_utility::getgametype() == "dmz" )
    {
        if ( getdvarint( @"hash_ddb64d51c29ea5d7", 0 ) )
        {
            nearbyai = getaiarrayinradius( self.origin, 1200 );
            
            if ( nearbyai.size > 0 )
            {
                foreach ( ai in nearbyai )
                {
                    ai notify( #"hash_dae76b320a1fb12f" );
                }
            }
        }
    }
    
    if ( player::getbeingrevivedinternal() )
    {
        player::setbeingrevivedinternal( 0 );
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        updatesquadmemberlaststandreviveprogress( self, self, 0, 1 );
        setplayerbeingrevivedextrainfo( 0 );
        self.brdownedbyairstriketime = undefined;
    }
    
    self setclientomnvar( "ui_is_laststand", 0 );
    setstateomnvar( 0 );
    function_14c751583f500b19();
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    
    if ( isdefined( level.modeonexitlaststandfunc ) )
    {
        self [[ level.modeonexitlaststandfunc ]]( revived );
    }
    
    self.laststandattacker = undefined;
    self.laststandinflictor = undefined;
    self.var_24c4c756a0d798dd = undefined;
    self.laststandmeansofdeath = undefined;
    self.laststandweaponobj = undefined;
    self.var_3242e03bf1b09197 = undefined;
    self.var_8f849ee66df5a544 = undefined;
    self.laststandattackermodifiers = undefined;
    self.laststandoldweapon = undefined;
    self.var_5f87feddcabb8ed = undefined;
    self.var_db30b7b119be2144 = undefined;
    self.var_2acdae9aaa7c06db = undefined;
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_49304bdaae61fc63 = undefined;
    self.inlaststand = 0;
    self.ignoreafkcheck = 0;
    self notify( #"afk_tracking_resume" );
    val::reset( "_group_laststand", "fire" );
    callback::remove( #"player_weapon_change", &on_player_weapon_change );
    self notify( #"last_stand_finished" );
}

// Namespace laststand
// Params 3
// Checksum 0x53522e9e, Offset: 0x3d38
// Size: 0x9b
function register_revive_reason( str_reason, wasselfrevive = 0, var_b2b5c6713127c937 = 0 )
{
    if ( !isdefined( level.var_eab5686cd39afa9b ) )
    {
        level.var_eab5686cd39afa9b = [];
    }
    
    s_revive = spawnstruct();
    s_revive.reason = str_reason;
    s_revive.wasselfrevive = wasselfrevive;
    s_revive.var_b2b5c6713127c937 = var_b2b5c6713127c937;
    level.var_eab5686cd39afa9b = arraycombineunique( level.var_eab5686cd39afa9b, [ s_revive ] );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xbffeebf7, Offset: 0x3ddb
// Size: 0x27
function private function_6c04467360c60454()
{
    self endon( #"last_stand_exit" );
    self waittill( #"death_or_disconnect" );
    thread exit( "death_or_disconnect" );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x3f1d1d8e, Offset: 0x3e0a
// Size: 0x27
function private function_e85a9db170dab695()
{
    self endon( #"last_stand_exit" );
    self waittill( #"hash_399f64172b697b17" );
    thread exit( "last_stand_meatshield" );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x6a714d98, Offset: 0x3e39
// Size: 0x27
function private function_f2a02b3b33e52ebb()
{
    self endon( #"last_stand_exit" );
    level waittill( #"game_ended" );
    thread exit( "game_ended" );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x6ea9fb4e, Offset: 0x3e68
// Size: 0x22
function private function_15b441f84b01abfb()
{
    self endon( #"last_stand_exit" );
    level waittill( #"last_stand_map_restart" );
    thread last_stand_exit_sfx();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xae99a85a, Offset: 0x3e92
// Size: 0xb5
function private last_stand_postfx()
{
    if ( isarray( level.gametypebundle.var_74449a611af9eda2 ) )
    {
        foreach ( fx in level.gametypebundle.var_74449a611af9eda2 )
        {
            if ( fx.laststandpbgpostfxbundle )
            {
                pbgpostfxbundlestart( self, fx.laststandpbgpostfxbundle );
            }
        }
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x44a7dc68, Offset: 0x3f4f
// Size: 0x173
function private last_stand_sfx()
{
    if ( isbrgamemode() )
    {
        if ( !self.deathsdoorsfx && !self.var_38620c16757519d1 )
        {
            self.deathsdoorsfx = 1;
            
            if ( isdefined( level.gamemodebundle.var_9d44880cfd22ca3c ) && soundexists( level.gamemodebundle.var_9d44880cfd22ca3c ) )
            {
                self playlocalsound( level.gamemodebundle.var_9d44880cfd22ca3c );
            }
            
            if ( isdefined( level.gamemodebundle.var_ba8ee46a4a66aee2 ) && soundexists( level.gamemodebundle.var_ba8ee46a4a66aee2 ) )
            {
                self stoplocalsound( level.gamemodebundle.var_ba8ee46a4a66aee2 );
            }
            
            damage_effects::function_1c301d9880ec1528();
            self enableplayerbreathsystem( 0 );
            thread damage_effects::playerbreathingpainsound();
        }
        
        return;
    }
    
    if ( isdefined( level.gamemodebundle.var_5e0ecbebf776a69f ) && soundexists( level.gamemodebundle.var_5e0ecbebf776a69f ) )
    {
        self playlocalsound( level.gamemodebundle.var_5e0ecbebf776a69f );
    }
    
    if ( isdefined( level.gamemodebundle.var_2280d17362853516 ) && soundexists( level.gamemodebundle.var_2280d17362853516 ) )
    {
        self playsound( level.gamemodebundle.var_2280d17362853516 );
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x3f94cc8c, Offset: 0x40ca
// Size: 0x1bb
function private function_a7deacb1af775bc4()
{
    self endon( #"last_stand_exit" );
    self endon( #"last_stand_sfx_exit" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.timeuntilbleedout )
    {
        return;
    }
    
    var_e3602800b7eed14a = isdefined( level.gamemodebundle.var_e6ac64d21bc1f6de );
    var_ed133ac187bf238f = isdefined( level.gamemodebundle.var_1b4e173a4071de0b );
    var_b9a6d5975f048e16 = isdefined( level.gamemodebundle.var_96ca464cbef7c61 );
    n_max_time = self.timeuntilbleedout;
    n_max_counter = 20;
    
    if ( isdefined( level.gamemodebundle.var_47f87eb74262ef76 ) )
    {
        n_max_counter = int( level.gamemodebundle.var_47f87eb74262ef76 / 0.1 );
    }
    
    counter = 0;
    var_c716571e4e03be3d = 0;
    
    if ( var_b9a6d5975f048e16 )
    {
        self setsoundsubmix( level.gamemodebundle.var_96ca464cbef7c61 );
    }
    
    while ( true )
    {
        if ( counter <= 0 )
        {
            counter = n_max_counter;
            self playlocalsound( level.gamemodebundle.var_52784ae849efc80f );
        }
        
        var_d36a3fd08cc40da9 = abs( 1 - self.timeuntilbleedout / n_max_time );
        
        if ( var_c716571e4e03be3d <= 0 )
        {
            var_c716571e4e03be3d = 5;
            
            if ( var_e3602800b7eed14a )
            {
                self function_70576dbab4f88e19( level.gamemodebundle.var_e6ac64d21bc1f6de, var_d36a3fd08cc40da9 );
            }
            
            if ( var_ed133ac187bf238f )
            {
                self setsoundsubmix( level.gamemodebundle.var_1b4e173a4071de0b, -1, var_d36a3fd08cc40da9 );
            }
        }
        
        wait 0.1;
        counter--;
        var_c716571e4e03be3d--;
    }
}

// Namespace laststand
// Params 1
// Checksum 0x5c7ac070, Offset: 0x428d
// Size: 0x89
function function_30a352a0f8de3f3d( enableoutline )
{
    var_abf1566d547bcbfa = isdefined( self.laststandoutlineid );
    
    if ( var_abf1566d547bcbfa == enableoutline )
    {
        return;
    }
    
    if ( enableoutline )
    {
        outlinename = "outline_nodepth_brplayer" + self.sessionuimemberindex + 1;
        self.laststandoutlineid = outline::outlineenableforteam( self, self.team, outlinename, "laststand" );
        return;
    }
    
    outline::outlinedisable( self.laststandoutlineid, self );
    self.laststandoutlineid = undefined;
}

// Namespace laststand
// Params 0
// Checksum 0xdc12cf32, Offset: 0x431e
// Size: 0xb5
function last_stand_exit_postfx()
{
    if ( isarray( level.gametypebundle.var_74449a611af9eda2 ) )
    {
        foreach ( fx in level.gametypebundle.var_74449a611af9eda2 )
        {
            if ( fx.laststandpbgpostfxbundle )
            {
                pbgpostfxbundlekill( self, fx.laststandpbgpostfxbundle );
            }
        }
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xf9934e68, Offset: 0x43db
// Size: 0x1d1
function private last_stand_exit_sfx()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"last_stand_sfx_exit" );
    
    if ( isdefined( level.gamemodebundle.var_5e0ecbebf776a69f ) && soundexists( level.gamemodebundle.var_5e0ecbebf776a69f ) )
    {
        self stoplocalsound( level.gamemodebundle.var_5e0ecbebf776a69f );
    }
    
    if ( isdefined( level.gamemodebundle.var_52530e2e838a636d ) && soundexists( level.gamemodebundle.var_52530e2e838a636d ) )
    {
        self stoplocalsound( level.gamemodebundle.var_52530e2e838a636d );
    }
    
    if ( isdefined( level.gamemodebundle.var_87d8541321f8aa72 ) && soundexists( level.gamemodebundle.var_87d8541321f8aa72 ) )
    {
        self stoplocalsound( level.gamemodebundle.var_87d8541321f8aa72 );
    }
    
    if ( isdefined( level.gamemodebundle.var_52784ae849efc80f ) && soundexists( level.gamemodebundle.var_52784ae849efc80f ) )
    {
        self stoplocalsound( level.gamemodebundle.var_5e0ecbebf776a69f );
    }
    
    if ( isdefined( level.gamemodebundle.var_1b4e173a4071de0b ) )
    {
        self clearsoundsubmix( level.gamemodebundle.var_1b4e173a4071de0b );
    }
    
    if ( isdefined( level.gamemodebundle.var_96ca464cbef7c61 ) )
    {
        self clearsoundsubmix( level.gamemodebundle.var_96ca464cbef7c61 );
    }
    
    if ( isdefined( level.gamemodebundle.var_e6ac64d21bc1f6de ) )
    {
        self function_70576dbab4f88e19( level.gamemodebundle.var_e6ac64d21bc1f6de );
    }
}

// Namespace laststand
// Params 2
// Checksum 0x4df54f8e, Offset: 0x45b4
// Size: 0x50
function function_c26a7c4bf9ba9d98( player, str )
{
    if ( getdvarint( @"scr_laststand_flow_log", isbrgamemode() ) )
    {
        logstring( "[LASTSTAND_FLOW] " + ( player.name ?? "Unknown" ) + ": " + str );
    }
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0xd6e925ea, Offset: 0x460c
// Size: 0x11f
function private function_c33e886a836f5aea( reviveent, player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( reviveent ) )
    {
        function_c26a7c4bf9ba9d98( player, "Revive Setup -- Revive Ent was undefined" );
        return;
    }
    
    if ( isdefined( reviveent.origin ) && isdefined( player.origin ) )
    {
        function_c26a7c4bf9ba9d98( player, "Revive Setup -- Entity Origin: " + reviveent.origin + ", Player Origin: " + player.origin );
    }
    
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        linkedparent = player getlinkedparent();
        isusable = reviveent getscriptablepartstate( "laststand" ) == "usable";
    }
    else
    {
        linkedparent = reviveent getlinkedparent();
        isusable = reviveent isusable();
    }
    
    if ( isdefined( linkedparent ) )
    {
        function_c26a7c4bf9ba9d98( player, "Revive Setup -- Revive Ent Parent Entity: " + ( linkedparent.name ?? "undefined" ) );
    }
    
    if ( isusable )
    {
        function_c26a7c4bf9ba9d98( player, "Revive Setup -- Revive Ent is Usable" );
        return;
    }
    
    function_c26a7c4bf9ba9d98( player, "Revive Setup -- Revive Ent is NOT Usable" );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x221ebb34, Offset: 0x4733
// Size: 0x68, Type: bool
function private function_1f848c9267c2fd3c()
{
    if ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && ( self.currentweapon.basename == "iw9_armor_plate_deploy_mp" || self.currentweapon.basename == level.var_99884af80074e803 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xff484b05, Offset: 0x47a4
// Size: 0x249
function private handlelaststandweapongivepipeline( laststandweapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    
    if ( !isweapon( self.currentweapon ) || !isweapon( laststandweapon ) || self.currentweapon.basename != laststandweapon.basename )
    {
        val::set( "_group_laststand", "fire", 0 );
        callback::add( #"player_weapon_change", &on_player_weapon_change );
    }
    
    var_a90a3f7a06a6fdca = gettime();
    
    if ( getdvarint( @"hash_310a17c347a78780", 0 ) )
    {
        var_a90a3f7a06a6fdca = undefined;
    }
    
    while ( !function_1f848c9267c2fd3c() )
    {
        if ( var_a90a3f7a06a6fdca && gettime() - var_a90a3f7a06a6fdca > 8000 )
        {
            if ( getdvarint( @"hash_cc0dce678e5bb10d", 0 ) == 1 )
            {
                throw( "handleLastStandWeaponGivePipeline() looping forever for player " + self.name + " with weapon " + self.currentweapon.basename );
            }
            else
            {
                function_c26a7c4bf9ba9d98( self, "handleLastStandWeaponGivePipeline() looping forever with weapon " + self.currentweapon.basename );
                
                if ( inventory_utility::isanymonitoredweaponswitchinprogress() )
                {
                    weapon = inventory_utility::getcurrentmonitoredweaponswitchweapon();
                    function_c26a7c4bf9ba9d98( self, "handleLastStandWeaponGivePipeline() potentially blocked due a stuck weapon switch with weapon " + ( weapon ?? "undefined" ) );
                }
                
                break;
            }
            
            var_a90a3f7a06a6fdca = undefined;
        }
        
        waitframe();
    }
    
    waitframe();
    var_bf9cf0944929e506 = makeweapon( "iw8_gunless_last_stand_enter" );
    inventory_utility::_giveweapon( var_bf9cf0944929e506, undefined, undefined, 0 );
    thread inventory_utility::_switchtoweaponimmediate( var_bf9cf0944929e506 );
    function_c26a7c4bf9ba9d98( self, "Transition weapon" );
    wait level.var_4815c4eaafd6d12c;
    revivesetup();
    callback::callback( #"player_laststand_give_weapon" );
    inventory_utility::_takeweapon( var_bf9cf0944929e506 );
    laststandweapondelay = 0;
    
    if ( !isweapon( laststandweapon ) && ( laststandweapon == "none" || laststandweapon == level.laststandweapon ) )
    {
        laststandweapon = givedefaultlaststandweapon();
    }
    else
    {
        laststandweapon = givelaststandweapon( laststandweapon );
    }
    
    callback::callback( #"player_laststand_weapon_given", { #weapon:laststandweapon } );
    wait laststandweapondelay;
    self.var_cc09887c7db65ab5 = 1;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xf57b4b0f, Offset: 0x49f5
// Size: 0x32
function private on_player_weapon_change( params )
{
    val::reset( "_group_laststand", "fire" );
    callback::remove( #"player_weapon_change", &on_player_weapon_change );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xa378ba0c, Offset: 0x4a2f
// Size: 0x36
function private takelaststandtransitionweapon()
{
    player = self;
    var_bf9cf0944929e506 = makeweapon( "iw8_gunless_last_stand_enter" );
    
    if ( player hasweapon( var_bf9cf0944929e506 ) )
    {
        player inventory_utility::_takeweapon( var_bf9cf0944929e506 );
    }
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x8fc46a7e, Offset: 0x4a6d
// Size: 0x77
function private handlelaststandweapongivedelay( laststandweapondelay, laststandweapon )
{
    self endon( #"death" );
    self endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    defaultlaststandweapon = givedefaultlaststandweapon();
    
    if ( issameweapon( defaultlaststandweapon, laststandweapon ) )
    {
        return;
    }
    
    wait laststandweapondelay;
    self notify( #"hash_74efa09e6ddc75c1" );
    inventory_utility::_takeweapon( defaultlaststandweapon );
    givelaststandweapon( laststandweapon );
}

// Namespace laststand
// Params 0
// Checksum 0x1929069a, Offset: 0x4aec
// Size: 0xe9
function givedefaultlaststandweapon()
{
    defaultlaststandweapon = makeweapon( level.laststandweapon );
    
    if ( isdefined( level.var_e81084285fb4b6c9 ) && defaultlaststandweapon canuseattachment( level.var_e81084285fb4b6c9 ) && !defaultlaststandweapon hasattachment( level.var_e81084285fb4b6c9 ) )
    {
        defaultlaststandweapon = defaultlaststandweapon withattachment( level.var_e81084285fb4b6c9 );
    }
    
    if ( !getdvarint( @"hash_4326092f73174099", 1 ) )
    {
        if ( utility::issharedfuncdefined( #"damage_upgrade", #"hash_b39175d78cf5b360" ) )
        {
            attachment = self [[ utility::getsharedfunc( #"damage_upgrade", #"hash_63169c0f05e29c6a" ) ]]( defaultlaststandweapon );
            
            if ( attachment && !defaultlaststandweapon hasattachment( attachment ) )
            {
                defaultlaststandweapon = defaultlaststandweapon withattachment( attachment );
            }
        }
    }
    
    inventory_utility::_giveweapon( defaultlaststandweapon, undefined, undefined, 1, 1 );
    thread inventory_utility::_switchtoweaponimmediate( defaultlaststandweapon );
    return defaultlaststandweapon;
}

// Namespace laststand
// Params 1
// Checksum 0x6e425dd7, Offset: 0x4bde
// Size: 0x123
function givelaststandweapon( laststandweapon )
{
    if ( !isweapon( laststandweapon ) )
    {
        laststandweapon = weapon::buildweapon( laststandweapon );
    }
    
    oldweaponobj = laststandweapon;
    var_97fa7d941f11b82b = self hasweapon( laststandweapon );
    
    if ( var_97fa7d941f11b82b )
    {
        var_26c49c9a1acb1813 = self function_8eb1b5d840aac85d( laststandweapon );
    }
    
    if ( !getdvarint( @"hash_4326092f73174099", 1 ) )
    {
        if ( utility::issharedfuncdefined( #"damage_upgrade", #"hash_b39175d78cf5b360" ) )
        {
            attachment = self [[ utility::getsharedfunc( #"damage_upgrade", #"hash_b39175d78cf5b360" ) ]]( laststandweapon );
            
            if ( attachment && !laststandweapon hasattachment( attachment ) )
            {
                laststandweapon = laststandweapon withattachment( attachment );
            }
        }
    }
    
    fullname = getcompleteweaponname( laststandweapon );
    
    if ( !self hasweapon( fullname ) )
    {
        if ( var_97fa7d941f11b82b )
        {
            inventory_utility::_takeweapon( oldweaponobj );
        }
        
        var_84bf3b404e028597 = var_26c49c9a1acb1813 ?? 1;
        inventory_utility::_giveweapon( laststandweapon, undefined, undefined, 1, var_84bf3b404e028597 );
        self.laststandweaponobj = laststandweapon;
    }
    
    thread inventory_utility::_switchtoweaponimmediate( fullname );
    return laststandweapon;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x45a93e44, Offset: 0x4d0a
// Size: 0x44
function private disableweaponsovertime( t )
{
    level endon( #"game_ended" );
    val::set( "disable_weapons_for_time", "weapon", 0 );
    utility::waittill_any_timeout( t, "death_or_disconnect" );
    val::reset_all( "disable_weapons_for_time" );
}

// Namespace laststand
// Params 1
// Checksum 0xc148f697, Offset: 0x4d56
// Size: 0x37
function switchtofists( laststandweapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_74efa09e6ddc75c1" );
    
    while ( inventory_utility::domonitoredweaponswitch( laststandweapon, 1 ) == 0 )
    {
        waitframe();
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1536110e, Offset: 0x4d95
// Size: 0x231
function private dodamagewhiledown()
{
    self endon( #"laststand_revived" );
    self endon( #"disconnect" );
    self endon( #"hash_d8c496481d44b038" );
    basehealth = level.laststandhealth;
    bleedouttime = get_last_stand_timer();
    
    if ( player::function_73fe5f51164eb3ca( self ) )
    {
        bleedouttime = level.laststand_syringe_params.var_9521f626fcc1a680;
    }
    
    if ( bleedouttime <= 0 )
    {
        bleedout();
        return;
    }
    
    damagepertick = float( basehealth ) / float( bleedouttime );
    damagepertick /= max( level.lastStandDamageTakenScalar, 0.01 );
    wait 1;
    
    if ( !level.var_93f23aa79405966 )
    {
        thread suicidesetup();
    }
    
    cboutput = { #preventdamage:0 };
    damagedealt = 0;
    
    while ( self.health > 0 )
    {
        /#
            if ( getdvarint( @"scr_interrogation_debug", 0 ) != 0 )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( self isinexecutionvictim() || self ismeatshieldvictim() )
        {
            wait 1;
            continue;
        }
        
        cboutput.preventdamage = 0;
        level callback::callback( #"hash_e03b7ef9f05c63b6", cboutput );
        
        if ( cboutput.preventdamage )
        {
            wait 1;
            continue;
        }
        
        if ( !player::getbeingrevivedinternal() )
        {
            var_222f61153ccd51d7 = int( damagedealt + damagepertick ) - int( damagedealt );
            damagedealt += damagepertick;
            self.islaststandbleedoutdmg = 1;
            self dodamage( var_222f61153ccd51d7, self.origin, self, undefined, "MOD_TRIGGER_HURT", level.laststandweapon, "none", undefined, 8589934592 );
            self playlocalsound( "mvmt_heartbeat_plr_laststand" );
            self.islaststandbleedoutdmg = undefined;
            
            if ( level.gamemodebundle.var_9fca605755fb380a == #"hash_6b808ce6a5a4ce47" )
            {
                childthread function_750e53852ab24bb1();
            }
        }
        
        if ( self.health <= 0 || self.liveragdoll )
        {
            bleedout();
            break;
        }
        
        wait 1;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xca1246b3, Offset: 0x4fce
// Size: 0x83
function private function_750e53852ab24bb1()
{
    if ( self.health <= 7 && self.health > 1 )
    {
        self playlocalsound( "deaths_door_heartrate_beep_04" );
        return;
    }
    
    if ( self.health <= 10 )
    {
        self playlocalsound( "deaths_door_heartrate_beep_03" );
        return;
    }
    
    if ( self.health <= 13 )
    {
        self playlocalsound( "deaths_door_heartrate_beep_02" );
        return;
    }
    
    if ( self.health <= 16 )
    {
        self playlocalsound( "deaths_door_heartrate_beep_01" );
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x1aedf5b9, Offset: 0x5059
// Size: 0x159
function private stucktime( var_26236525b4c44696 )
{
    if ( level.var_bf82e408b7a0e3c3 )
    {
        bleedout();
    }
    
    self setclientomnvar( "ui_laststand_bleedout_progress", 1 );
    self.stuckinlaststand = 1;
    wait var_26236525b4c44696;
    self.stuckinlaststand = 0;
    timeleft = get_last_stand_timer();
    
    /#
        if ( getdvarint( @"scr_interrogation_debug", 0 ) != 0 || getdvarfloat( @"scr_player_laststandtimer", 10 ) == -1 )
        {
            return;
        }
    #/
    
    if ( player::function_73fe5f51164eb3ca( self ) )
    {
        timeleft = level.laststand_syringe_params.var_9521f626fcc1a680;
    }
    
    if ( isbrgamemode() )
    {
        assert( timeleft > 0, "<dev string:x79>" );
    }
    
    if ( !isbrgamemode() && timeleft != 0 )
    {
        timeleft = max( timeleft - level.laststandsuicidetimer, 1 );
    }
    else
    {
        timeleft = 0;
    }
    
    self.timeuntilbleedout = timeleft;
    
    if ( isdefined( level.gamemodebundle.var_52784ae849efc80f ) && soundexists( level.gamemodebundle.var_52784ae849efc80f ) )
    {
        thread function_a7deacb1af775bc4();
    }
    
    if ( isdefined( level.laststand_bleedout_think ) )
    {
        self thread [[ level.laststand_bleedout_think ]]();
        return;
    }
    
    thread bleedoutthink();
    thread suicidesetup();
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x34a1334a, Offset: 0x51ba
// Size: 0xb1
function private selfrevivebuttonpressed( downedplayer )
{
    if ( level.var_bf82e408b7a0e3c3 )
    {
        return 0;
    }
    
    /#
        if ( isbot( downedplayer ) && downedplayer.var_d58dcecf776f41ff )
        {
            return 1;
        }
        
        if ( getdvarint( @"hash_51d681fbc88502b9", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( downedplayer.b_force_gameobject_use || downedplayer.var_26d9e22abfa6be43 )
    {
        return 1;
    }
    
    if ( downedplayer usinggamepad() )
    {
        if ( level.var_5a32b792b8e156b0 )
        {
            return downedplayer usebuttonpressed();
        }
        else
        {
            return downedplayer weaponswitchbuttonpressed();
        }
        
        return;
    }
    
    return downedplayer activatekeypressed() || downedplayer.toggleuse;
}

// Namespace laststand
// Params 1
// Checksum 0x98e5c95f, Offset: 0x5273
// Size: 0x1f1
function selfrevivethink( var_6779a2f075a575a3 = 0 )
{
    triggerent = self;
    downedplayer = triggerent.owner;
    level endon( #"game_ended" );
    triggerent endon( #"death" );
    downedplayer endon( #"death_or_disconnect" );
    downedplayer endon( #"last_stand_exit" );
    
    if ( !var_6779a2f075a575a3 )
    {
        wait 0.3;
    }
    
    function_b6fc039c81a23fce( triggerent, 0, function_21539f7d3fd7080a( triggerent, 0 ) );
    
    while ( true )
    {
        if ( selfrevivebuttonpressed( downedplayer ) && !downedplayer.isselfreviving && !downedplayer.beingrevived && !downedplayer ismeleeing() && ( downedplayer isonground() || downedplayer isswimming() ) )
        {
            triggerent notify( #"hash_be49f7d04abd5152" );
            triggerent.lastvaliduser = undefined;
            
            if ( level.laststandselfreviveanim )
            {
                downedplayer setlaststandselfreviving( 1, istrue( downedplayer.var_5f87feddcabb8ed ) );
            }
            
            downedplayer callback::callback( #"player_laststand_self_revive_start", { #reviver:downedplayer } );
            
            if ( level.var_894cf9c132c87505 )
            {
                downedplayer setplayerselfrevivingextrainfo( 1 );
            }
            
            triggerent selfrevivemonitorrevivebuttonpressed();
            
            while ( isdefined( downedplayer ) )
            {
                var_f431a990a7fe62ca = 0;
                var_d68a19794203298 = downedplayer getgestureviewmodel();
                
                if ( arraycontains( var_d68a19794203298, %"ges_equip_stim_self_revive" ) )
                {
                    var_f431a990a7fe62ca = 1;
                }
                
                if ( arraycontains( var_d68a19794203298, %"iw9_vm_ges_stimpistol_self_revive" ) )
                {
                    var_f431a990a7fe62ca = 1;
                }
                
                if ( isdefined( level.gametypebundle.var_ec6116c438de4090 ) && arraycontains( var_d68a19794203298, level.gametypebundle.var_ec6116c438de4090 ) )
                {
                    var_f431a990a7fe62ca = 1;
                }
                
                if ( downedplayer isswitchingweapon() )
                {
                    var_f431a990a7fe62ca = 1;
                }
                
                if ( !var_f431a990a7fe62ca )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x42f5f647, Offset: 0x546c
// Size: 0xad
function private function_aac05c45b8c6a3d( downedplayer, var_e6560ea297b06638 = 0 )
{
    usetime = ( var_e6560ea297b06638 ? level.lastStandTourniquetReviveTimer : level.laststandrevivetimer ) * 1000;
    usetime *= downedplayer function_ef7bc47aca6f1c51( 0, 1, downedplayer );
    
    if ( isdefined( downedplayer.var_3e398b71be70e3c6 ) )
    {
        usetime *= downedplayer.var_3e398b71be70e3c6;
    }
    
    if ( isdefined( downedplayer.var_ee80ad773b7fac32.var_81cdaf2a2b747524 ) )
    {
        usetime *= downedplayer.var_ee80ad773b7fac32.var_81cdaf2a2b747524;
    }
    
    return usetime;
}

// Namespace laststand
// Params 0
// Checksum 0x49bb6c6d, Offset: 0x5522
// Size: 0x74, Type: bool
function function_aab0a23ef041d1f9()
{
    assert( self.inlaststand );
    iseligible = function_7072b516e6cffb7c() > 0 || hasselfrevivetoken() || self.var_5f87feddcabb8ed || utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) || health_chunks::function_4ff6cb509967e92() || level.var_2acb9af1663be697;
    return istrue( iseligible );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xbcd78000, Offset: 0x559f
// Size: 0x71
function private onplayerdamaged( params )
{
    if ( player::isinlaststand( params.victim ) && params.smeansofdeath == "MOD_MELEE" )
    {
        params.victim.var_5272648cec878438 = 1;
        waitframe();
        
        if ( params.victim )
        {
            params.victim.var_5272648cec878438 = undefined;
        }
    }
}

// Namespace laststand
// Params 0
// Checksum 0x59703f2b, Offset: 0x5618
// Size: 0xa9, Type: bool
function function_f2bf1b505a78c70b()
{
    downedplayer = self;
    
    if ( downedplayer isinexecutionvictim() )
    {
        return true;
    }
    
    if ( downedplayer ismeatshieldvictim() )
    {
        return true;
    }
    
    if ( downedplayer.ishaywire )
    {
        return true;
    }
    
    if ( level.gametypebundle.var_fc0ae8074178e65a && downedplayer.var_5272648cec878438 )
    {
        return true;
    }
    
    if ( downedplayer.pauseselfrevive || downedplayer.var_378691f0603feecf )
    {
        return true;
    }
    
    if ( downedplayer.beingrevived )
    {
        return true;
    }
    
    if ( !( downedplayer isonground() || downedplayer isswimming() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace laststand
// Params 1
// Checksum 0xfc8432c4, Offset: 0x56ca
// Size: 0x71
function function_39844c1e879cc048( self_revive_count )
{
    self_revive_count = int( max( self_revive_count, 0 ) );
    self.n_self_revives = self_revive_count;
    
    if ( self function_5c766d1d0140b86( "ui_self_revive_count" ) )
    {
        self setclientomnvar( "ui_self_revive_count", int( min( self.n_self_revives, 10 ) ) );
    }
    
    if ( self.n_self_revives > 0 )
    {
        allowselfrevive( 1 );
        return;
    }
    
    allowselfrevive( 0 );
}

// Namespace laststand
// Params 0
// Checksum 0xabcf5399, Offset: 0x5743
// Size: 0x23
function function_a40d280a3420d81()
{
    n_max_self_revives = level.gametypebundle.var_a6e51b07b899b200;
    return n_max_self_revives;
}

// Namespace laststand
// Params 0
// Checksum 0x1bcb361b, Offset: 0x576f
// Size: 0xf, Type: bool
function function_7072b516e6cffb7c()
{
    return self.n_self_revives ?? 0;
}

// Namespace laststand
// Params 0
// Checksum 0x88cbcf26, Offset: 0x5787
// Size: 0x7
function function_16a34021e980083d()
{
    return "last_stand_self_revive";
}

// Namespace laststand
// Params 1
// Checksum 0xe0bbfa22, Offset: 0x5797
// Size: 0x20, Type: bool
function function_71ad4ea4ebadba11( reason )
{
    return reason == "last_stand_self_revive" || reason == "health_chunk_revive";
}

// Namespace laststand
// Params 2
// Checksum 0x7eeb4e6f, Offset: 0x57c0
// Size: 0x74
function function_a2e03a85015b1897( n_count = 1, var_21f1f7b27ae8c4d8 = 1 )
{
    if ( var_21f1f7b27ae8c4d8 && isdefined( self.var_4877be4da79014b0 ) )
    {
        self.var_4877be4da79014b0 += n_count;
        self.var_63cd4b355dddbeba += n_count;
    }
    
    function_39844c1e879cc048( function_7072b516e6cffb7c() + n_count );
}

// Namespace laststand
// Params 2
// Checksum 0x49baa339, Offset: 0x583c
// Size: 0x5b
function function_7a1a4fa42d3ac8e3( n_count = 1, b_revived = 0 )
{
    if ( b_revived )
    {
        if ( !isdefined( self.var_aecc486f34e4dd66 ) )
        {
            self.var_aecc486f34e4dd66 = 0;
        }
        
        self.var_aecc486f34e4dd66++;
    }
    
    function_39844c1e879cc048( function_7072b516e6cffb7c() - n_count );
}

// Namespace laststand
// Params 0
// Checksum 0x89250aee, Offset: 0x589f
// Size: 0x24, Type: bool
function function_ed4da7e5751eed47()
{
    n_max_self_revives = function_a40d280a3420d81();
    
    if ( function_7072b516e6cffb7c() < n_max_self_revives )
    {
        return true;
    }
    
    return false;
}

// Namespace laststand
// Params 1
// Checksum 0xfb465f87, Offset: 0x58cc
// Size: 0x2d
function allowselfrevive( allow )
{
    self.allowselfrevive = allow;
    self setclientomnvar( "ui_self_revive", allow );
    sethasselfrevivetokenextrainfo( allow );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x4e4d988a, Offset: 0x5901
// Size: 0x66
function private function_8889d5fcc0ae296()
{
    if ( !function_478231ebea935bee() )
    {
        var_1479f07b528e4ff7 = level.gametypebundle.var_31ae6219b998e40d ?? "offhand_1h_wm_stim_v0";
        utility::player_prestream_assets( "laststand", "model", [ var_1479f07b528e4ff7 ], undefined, 3 );
        self attach( var_1479f07b528e4ff7, "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = var_1479f07b528e4ff7;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xf5ffe3bc, Offset: 0x596f
// Size: 0x2a
function private function_6885379789fd02bc()
{
    if ( !function_478231ebea935bee() )
    {
        self attach( "misc_wm_stim_pistol_v0", "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = "misc_wm_stim_pistol_v0";
    }
}

// Namespace laststand
// Params 0
// Checksum 0x11df288b, Offset: 0x59a1
// Size: 0x29
function function_c502142c8e38766d()
{
    if ( function_478231ebea935bee() )
    {
        self detach( self.var_cc53b164d9ca6852, "tag_accessory_left" );
        self.var_cc53b164d9ca6852 = undefined;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xd4bc14e9, Offset: 0x59d2
// Size: 0xc, Type: bool
function private function_478231ebea935bee()
{
    return isdefined( self.var_cc53b164d9ca6852 );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x6e5891ed, Offset: 0x59e7
// Size: 0xc, Type: bool
function private function_c18a27c77dca2a00()
{
    return istrue( level.var_60f16545279443d6 );
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x82ae8bd3, Offset: 0x59fc
// Size: 0x55, Type: bool
function private function_21539f7d3fd7080a( reviveent, progresstrack )
{
    if ( !function_c18a27c77dca2a00() )
    {
        return ( reviveent.curprogress ?? 0 );
    }
    
    if ( progresstrack == 0 )
    {
        return ( reviveent.var_141c02ff1ae5bf52 ?? 0 );
    }
    
    return reviveent.var_ae2e7361a3e60114 ?? 0;
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0xa602e4da, Offset: 0x5a5a
// Size: 0x64
function private function_b6fc039c81a23fce( reviveent, progresstrack, progress )
{
    progress = max( progress, 0 );
    
    if ( function_c18a27c77dca2a00() )
    {
        if ( progresstrack == 0 )
        {
            reviveent.var_141c02ff1ae5bf52 = progress;
        }
        else
        {
            reviveent.var_ae2e7361a3e60114 = progress;
        }
    }
    
    reviveent.curprogress = progress;
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xa3701bf7, Offset: 0x5ac6
// Size: 0x856
function private selfrevivemonitorrevivebuttonpressed()
{
    downedplayer = self.owner;
    triggerent = self;
    level endon( #"game_ended" );
    downedplayer endon( #"death_or_disconnect" );
    downedplayer endon( #"last_stand_exit" );
    triggerent.waitingforteammaterevive = 0;
    var_e6560ea297b06638 = downedplayer health_chunks::function_4ff6cb509967e92();
    overridereason = undefined;
    
    if ( var_e6560ea297b06638 )
    {
        overridereason = "health_chunk_revive";
    }
    
    triggerent.usetime = function_aac05c45b8c6a3d( downedplayer, var_e6560ea297b06638 );
    function_b6fc039c81a23fce( triggerent, 0, function_21539f7d3fd7080a( triggerent, 0 ) );
    
    if ( !level.var_27d1beb8576f49c4 )
    {
        level thread battlechatter_mp::trysaylocalsound( downedplayer, #"bc_status_action_selfrevive" );
    }
    
    if ( downedplayer.self_revive_item )
    {
        downedplayer utility::callsharedfunc( downedplayer.self_revive_item.ref, #"self_revive_start_use" );
    }
    
    stoppedanim = 0;
    downedplayer.toggleuse = 0;
    downedplayer.usepressed = 0;
    
    while ( player::isreallyalive( downedplayer ) && ( selfrevivebuttonpressed( downedplayer ) || downedplayer function_96e527529c5dcd37() ) && triggerent.curprogress < triggerent.usetime )
    {
        downedplayer playerlogic::function_3765e79e200dd60f();
        
        while ( !( downedplayer isonground() || downedplayer isswimming() ) && selfrevivebuttonpressed( downedplayer ) && !downedplayer.isselfreviving )
        {
            waitframe();
        }
        
        if ( !selfrevivebuttonpressed( downedplayer ) && !downedplayer function_96e527529c5dcd37() )
        {
            break;
        }
        
        if ( downedplayer isinexecutionvictim() )
        {
            break;
        }
        
        if ( downedplayer ismeatshieldvictim() )
        {
            break;
        }
        
        if ( downedplayer.ishaywire )
        {
            break;
        }
        
        if ( level.gametypebundle.var_fc0ae8074178e65a && downedplayer.var_5272648cec878438 )
        {
            break;
        }
        
        if ( downedplayer.pauseselfrevive || downedplayer.var_378691f0603feecf )
        {
            downedplayer player::setbeingrevivedinternal( 0 );
            downedplayer function_cc275a9fba9bf672();
            downedplayer resetomnvars();
            break;
        }
        
        if ( downedplayer.beingrevived )
        {
            break;
        }
        
        if ( !downedplayer.isselfreviving )
        {
            downedplayer val::group_reset( "laststand" );
            downedplayer val::group_reset( "laststand_disallows" );
            downedplayer val::set( "_group_laststand", "weapon_pickup", 0 );
            downedplayer val::set( "_group_laststand", "usability", 0 );
            downedplayer val::set( "_group_laststand", "weapon_switch", 0 );
            downedplayer val::set( "_group_laststand", "melee", 0 );
            downedplayer val::set( "_group_laststand", "ignoreme", 1 );
            downedplayer notify( #"self_revive_start" );
            useweapon = undefined;
            
            if ( downedplayer.var_5f87feddcabb8ed )
            {
                if ( level.gametypebundle.var_2fd140faf0ba7b8f )
                {
                    useweapon = level.gametypebundle.var_2fd140faf0ba7b8f;
                }
                else
                {
                    downedplayer function_6885379789fd02bc();
                    downedplayer thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_self_revive_stim_pistol", 10 );
                }
                
                downedplayer.var_c3ca6e1ab237a810 = 1;
                triggerent.inuse = 1;
            }
            else if ( var_e6560ea297b06638 )
            {
                useweapon = level.gametypebundle.var_f7284509ebf06d6;
            }
            else if ( level.gametypebundle.selfreviveweapon )
            {
                useweapon = level.gametypebundle.selfreviveweapon;
            }
            else
            {
                downedplayer function_8889d5fcc0ae296();
                
                if ( level.laststandselfreviveanim )
                {
                    var_c1b519cd1c6832a0 = level.gametypebundle.var_ec6116c438de4090 ?? "iw8_ges_plyr_self_revive";
                    downedplayer thread pickups::playerplaygestureweaponanim( var_c1b519cd1c6832a0, 10 );
                }
            }
            
            if ( useweapon )
            {
                if ( !downedplayer hasweapon( useweapon ) )
                {
                    downedplayer inventory_utility::_giveweapon( useweapon, undefined, undefined, 0 );
                }
                
                downedplayer switchtoweapon( useweapon );
            }
            
            downedplayer.isselfreviving = 1;
            downedplayer allowmovement( 0 );
            
            if ( level.laststandselfreviveanim )
            {
                downedplayer allowfire( 0 );
            }
            else
            {
                downedplayer allowfire( 1 );
            }
        }
        
        if ( !( downedplayer isonground() || downedplayer isswimming() ) )
        {
            break;
        }
        
        if ( !isdefined( triggerent.userate ) )
        {
            triggerent.userate = 0;
        }
        
        function_b6fc039c81a23fce( triggerent, 0, triggerent.curprogress + level.frameduration * triggerent.userate );
        triggerent.userate = 1;
        percentcomplete = triggerent.curprogress / triggerent.usetime;
        downedplayer function_2a6fde9dfe8639bc( undefined, percentcomplete, var_e6560ea297b06638 );
        
        foreach ( var_6a6d04449b311186 in [ [ level.gametypebundle.var_f7284509ebf06d6, 567 ], [ level.gametypebundle.var_2fd140faf0ba7b8f, 1100 ], [ level.gametypebundle.selfreviveweapon, 567 ] ] )
        {
            if ( !stoppedanim && var_6a6d04449b311186[ 0 ] && downedplayer hasweapon( var_6a6d04449b311186[ 0 ] ) && triggerent.curprogress + var_6a6d04449b311186[ 1 ] >= triggerent.usetime )
            {
                stoppedanim = 1;
                downedplayer takeweapon( var_6a6d04449b311186[ 0 ] );
                downedplayer giveandfireoffhand( var_6a6d04449b311186[ 0 ] );
            }
        }
        
        if ( triggerent.curprogress >= triggerent.usetime )
        {
            current_gestures = downedplayer getgestureviewmodel();
            
            if ( arraycontains( current_gestures, %"ges_equip_stim_self_revive" ) )
            {
                downedplayer stopgestureviewmodel( %"ges_equip_stim_self_revive" );
            }
            
            if ( arraycontains( current_gestures, %"iw9_vm_ges_stimpistol_self_revive" ) )
            {
                downedplayer stopgestureviewmodel( %"iw9_vm_ges_stimpistol_self_revive" );
            }
            
            if ( isdefined( level.gametypebundle.var_ec6116c438de4090 ) )
            {
                downedplayer stopgestureviewmodel( level.gametypebundle.var_ec6116c438de4090 );
            }
            
            if ( !var_e6560ea297b06638 )
            {
                if ( downedplayer.var_5f87feddcabb8ed )
                {
                    downedplayer thread [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"onTake" ) ]]();
                }
                else if ( isdefined( level.removeselfrevivetoken ) )
                {
                    downedplayer [[ level.removeselfrevivetoken ]]( 1, 1 );
                }
            }
            
            downedplayer utility::function_a9cdce367aa4fef5( #"hash_29a97a3a45b445e4", 2, #"death_or_disconnect" );
            
            if ( isdefined( level.gamemodebundle.var_c7b4ab329d482458 ) && soundexists( level.gamemodebundle.var_c7b4ab329d482458 ) )
            {
                downedplayer playlocalsound( level.gamemodebundle.var_c7b4ab329d482458 );
            }
            
            reasonrevive = overridereason ?? "last_stand_self_revive";
            downedplayer callback::callback( #"hash_1d25b1f60ee0c1b5", { #reason:reasonrevive } );
            
            if ( downedplayer.self_revive_item )
            {
                downedplayer utility::callsharedfunc( downedplayer.self_revive_item.ref, #"hash_7af14c40ee3152a3", 1 );
            }
            
            downedplayer thread exit( reasonrevive );
            return;
        }
        
        waitframe();
    }
    
    if ( downedplayer.self_revive_item )
    {
        downedplayer utility::callsharedfunc( downedplayer.self_revive_item.ref, #"hash_7af14c40ee3152a3", 0 );
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        updatesquadmemberlaststandreviveprogress( downedplayer, downedplayer, triggerent.curprogress, 1 );
    }
    
    triggerent thread decayreviveprogress( 0 );
    selfrevivebuttonpresscleanup( var_e6560ea297b06638 );
}

// Namespace laststand
// Params 1
// Checksum 0x4d5f982f, Offset: 0x6324
// Size: 0x48, Type: bool
function selfrevivepause( duration )
{
    self notify( #"hash_415515cdc7931dc3" );
    self endon( #"hash_415515cdc7931dc3" );
    self.pauseselfrevive = 1;
    
    if ( isdefined( duration ) )
    {
        wait duration;
    }
    else
    {
        waitframe();
    }
    
    self.pauseselfrevive = 0;
    return true;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xa8e32a90, Offset: 0x6375
// Size: 0x40
function private function_1d7c35bc34983a15( reviver )
{
    if ( isdefined( reviver ) )
    {
        function_25a2e710b8054c1c( reviver );
        function_4809061347e8d7de( reviver );
        return;
    }
    
    self setclientomnvar( "ui_reviver_id", self getentitynumber() );
    setstateomnvar( 16 );
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0x5598399e, Offset: 0x63bd
// Size: 0x84
function private function_2a6fde9dfe8639bc( reviver, progress, var_edfe1b367c049945 )
{
    progress = clamp( progress, 0.01, 1 );
    function_ca049c55ceacf84f( reviver ?? self, progress );
    
    if ( isdefined( reviver ) )
    {
        function_ca048955ceacce86( reviver, progress );
    }
    else if ( var_edfe1b367c049945 )
    {
        setstateomnvar( 30 );
    }
    else
    {
        setstateomnvar( 16 );
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        updatesquadmemberlaststandreviveprogress( self, reviver ?? self, progress, 0 );
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x3e834a0, Offset: 0x6449
// Size: 0x17
function private resetomnvars()
{
    self setclientomnvar( "ui_reviver_id", -1 );
    setstateomnvar( 0 );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x243df142, Offset: 0x6468
// Size: 0x26
function private function_25a2e710b8054c1c( primaryreviver )
{
    self setclientomnvar( "ui_reviver_id", primaryreviver getentitynumber() );
    setstateomnvar( 6 );
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0xbed2792e, Offset: 0x6496
// Size: 0x54
function private function_ca049c55ceacf84f( primaryreviver, progress )
{
    progress = clamp( progress, 0.01, 1 );
    setprogressomnvar( progress );
    callback::callback( #"player_laststand_set_revive_progress", { #progress:progress, #reviver:primaryreviver } );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xfcd83203, Offset: 0x64f2
// Size: 0x20
function private function_4809061347e8d7de( reviver )
{
    if ( isplayer( reviver ) )
    {
        reviver setstateomnvar( 5 );
    }
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0xf9444593, Offset: 0x651a
// Size: 0x28
function private function_ca048955ceacce86( reviver, progress )
{
    if ( isplayer( reviver ) )
    {
        reviver setprogressomnvar( progress );
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x71ba2138, Offset: 0x654a
// Size: 0x1e
function private function_648891499d2e47a3( reviver )
{
    if ( isplayer( reviver ) )
    {
        reviver resetomnvars();
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xd07d8e28, Offset: 0x6570
// Size: 0xc, Type: bool
function private function_96e527529c5dcd37()
{
    return istrue( self.var_c3ca6e1ab237a810 );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xcbbd0af8, Offset: 0x6585
// Size: 0x17
function private function_cc275a9fba9bf672()
{
    self.var_c3ca6e1ab237a810 = 0;
    self stopgestureviewmodel( "iw9_vm_ges_stimpistol_self_revive" );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x98035045, Offset: 0x65a4
// Size: 0x218
function private selfrevivebuttonpresscleanup( var_6161757f102a5fe3 )
{
    downedplayer = self.owner;
    
    if ( !isdefined( downedplayer ) )
    {
        return;
    }
    
    if ( !downedplayer.isselfreviving )
    {
        return;
    }
    
    if ( !downedplayer.beingrevived )
    {
        downedplayer resetomnvars();
        downedplayer allowmovement( 1 );
        downedplayer val::group_reset( "laststand" );
        downedplayer val::group_set( "laststand", 0 );
        downedplayer val::group_reset( "laststand_disallows" );
        downedplayer val::group_set( "laststand_disallows", 1 );
    }
    
    downedplayer allowfire( 1 );
    downedplayer function_c502142c8e38766d();
    
    if ( isdefined( level.gametypebundle.var_ec6116c438de4090 ) )
    {
        downedplayer stopgestureviewmodel( level.gametypebundle.var_ec6116c438de4090 );
    }
    
    current_gestures = downedplayer getgestureviewmodel();
    
    if ( arraycontains( current_gestures, %"ges_equip_stim_self_revive" ) )
    {
        downedplayer stopgestureviewmodel( %"ges_equip_stim_self_revive" );
    }
    
    foreach ( weapon in [ level.gametypebundle.var_f7284509ebf06d6, level.gametypebundle.selfreviveweapon, level.gametypebundle.var_2fd140faf0ba7b8f ] )
    {
        if ( weapon && downedplayer hasweapon( weapon ) )
        {
            downedplayer canceloffhands();
            downedplayer switchtoweapon( downedplayer.laststandweaponobj );
            break;
        }
    }
    
    if ( level.laststandselfreviveanim )
    {
        downedplayer setlaststandselfreviving( 0 );
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        downedplayer setplayerselfrevivingextrainfo( 0 );
    }
    
    downedplayer.isselfreviving = 0;
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0xf0898b8d, Offset: 0x67c4
// Size: 0x4f9
function private onrevive( wasselfrevive, var_b2b5c6713127c937, reason = "none" )
{
    oldweaponobj = self.laststandoldweaponobj;
    var_8178b69fc70f6131 = self.maxhealth;
    self laststandrevive();
    self playsoundtoteam( "npc_breath_revive", self.team, self, self );
    self playlocalsound( "plr_breath_revive" );
    self stoplocalsound( "mvmt_heartbeat_plr_laststand" );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self.fastcrouchspeedmod = 0;
    weapons::updatemovespeedscale();
    
    if ( !level.gameended )
    {
        setplayerdownedextrainfo( 0 );
        
        if ( reason != "health_chunk_revive" )
        {
            damage_effects::onexitdeathsdoor( 1 );
        }
    }
    
    if ( isdefined( self.laststandoutlineid ) )
    {
        outline::outlinedisable( self.laststandoutlineid, self );
        self.laststandoutlineid = undefined;
    }
    
    self notify( #"laststand_revived" );
    self.var_49304bdaae61fc63 = 1;
    laststandweapon = level.laststandweapon;
    
    if ( laststandweapon != "none" )
    {
        thread inventory_utility::domonitoredweaponswitch( oldweaponobj, 1 );
    }
    
    thread function_cff5610aef553b5e();
    function_c26a7c4bf9ba9d98( self, "Revive Resync Attempt -- reason: " + reason + ", downedMax: " + var_8178b69fc70f6131 + ", defaultMaxHealth: " + ( self.defaultmaxhealth ?? "undefined" ) + ", gscCurrentMaxBeforeResync: " + self.maxhealth + ", autoAdjustMaxHealth: " + getdvarint( @"hash_794a59acd7c0c68f", 1 ) );
    self.maxhealth = self.maxhealth;
    
    if ( getdvarint( @"hash_794a59acd7c0c68f", 1 ) )
    {
        if ( isdefined( self.defaultmaxhealth ) )
        {
            self.maxhealth = self.defaultmaxhealth;
        }
    }
    
    function_c26a7c4bf9ba9d98( self, "Revive Resync Result -- reason: " + reason + ", downedMax: " + var_8178b69fc70f6131 + ", defaultMaxHealth: " + ( self.defaultmaxhealth ?? "undefined" ) + ", gscCurrentMaxAfterResync: " + self.maxhealth );
    
    if ( player::function_73fe5f51164eb3ca( self ) )
    {
        laststandrevivehealth = level.laststand_syringe_params.laststandrevivehealth;
        
        if ( self.maxhealth < laststandrevivehealth )
        {
            self.maxhealth = laststandrevivehealth;
        }
        
        safehealth = laststandrevivehealth;
        
        if ( safehealth > var_8178b69fc70f6131 )
        {
            safehealth = var_8178b69fc70f6131;
        }
        
        function_c26a7c4bf9ba9d98( self, "Syringe Revive State -- reason: " + reason + ", downedMax: " + var_8178b69fc70f6131 + ", defaultMaxHealth: " + ( self.defaultmaxhealth ?? "undefined" ) + ", currentMaxHealth: " + self.maxhealth + ", reviveHealth: " + laststandrevivehealth + ", safeHealth: " + safehealth );
        self.health = safehealth;
    }
    else if ( !var_b2b5c6713127c937 )
    {
        healthvalue = level.laststandrevivehealth;
        
        if ( isdefined( self.laststandrevivehealth ) )
        {
            healthvalue = self.laststandrevivehealth;
        }
        
        if ( isdefined( self.var_b541f8c69a34639d ) )
        {
            self.maxhealth = self.var_b541f8c69a34639d;
        }
        
        if ( self.var_bb32c697bfd2450d.var_134bb5de38598223 )
        {
            healthvalue = min( healthvalue + self.var_bb32c697bfd2450d.var_134bb5de38598223, self.maxhealth );
        }
        
        if ( !getdvarint( @"scr_player_laststandreviveretainhealth" ) || self.health < healthvalue )
        {
            self.health = healthvalue;
            naturalheal = getdvarint( @"hash_5f6b9bbbb7545119", 1 );
            playerhealth::forcehealthregen( self, naturalheal, undefined, { #nobattlechatter:1 } );
        }
    }
    else
    {
        self.health = self.maxhealth;
    }
    
    if ( game_utility_mp::getgamestate( self ) == "postgame" )
    {
        assert( !level.intermission );
        gamelogic_mp::freezeplayerforroundend();
    }
    
    player::setbeingrevivedinternal( 0 );
    shellshock_utility_cpmp::_stopshellshock();
    
    if ( wasselfrevive && level.allowselfrevive )
    {
        allowselfrevive( 0 );
    }
    
    self.defaultmaxhealth = undefined;
    challenges::function_f8bdac4d6cc2664f( self, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ), "specialty_survivor", undefined );
    params = { #superrevive:var_b2b5c6713127c937, #selfrevive:wasselfrevive, #reason:reason, #reviver:self.var_bb32c697bfd2450d, #victim:self };
    callback::callback( #"player_laststand_revived", params );
    self.var_bb32c697bfd2450d = undefined;
    self.laststanddowneddata = undefined;
    self.var_e988ab84618d4592 = undefined;
    self.var_9cf07436884eef22 = undefined;
    
    if ( wasselfrevive )
    {
        points::doscoreevent( #"field_last_stand_revive" );
    }
    
    if ( self.var_5629b291aa700093 )
    {
        self.rallypointrevived = 1;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x32dea7a0, Offset: 0x6cc5
// Size: 0x16c
function private bleedout()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.laststandattacker ) )
    {
        self.laststandattacker thread rank::scoreeventpopup( #"kill_confirmed" );
    }
    
    if ( !isdefined( deathdata ) )
    {
        deathdata = {};
    }
    
    deathdata.downedby = self.laststanddowneddata.attacker;
    deathdata.lastattacker = self.lastattacker;
    deathdata.victim = self;
    callback::callback( #"player_laststand_bleedout", deathdata );
    
    if ( self.var_b2b283c015cf3bd4 )
    {
        self.var_b2b283c015cf3bd4 = undefined;
        return;
    }
    
    inflictor = undefined;
    
    if ( isdefined( self.laststandattacker ) )
    {
        inflictor = self.laststandattacker;
    }
    else if ( isdefined( self.laststanddowneddata ) && isdefined( self.laststanddowneddata.attacker ) )
    {
        inflictor = self.laststanddowneddata.attacker;
    }
    else
    {
        inflictor = self;
    }
    
    if ( level.var_62b49c3b2ec4111a )
    {
        damage::_suicide();
    }
    else
    {
        self dodamage( self.health + 1000, self.origin, self, inflictor, "MOD_TRIGGER_HURT", makeweapon( level.laststandweapon ), "none" );
    }
    
    survivorondeath( self.laststandattacker );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xa013112e, Offset: 0x6e39
// Size: 0xf9
function private ondeath( deathdata )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_30a352a0f8de3f3d( 0 );
    
    if ( isdefined( self.laststandattacker ) && isdefined( self.perks[ "specialty_survivor" ] ) )
    {
        survivorondeath( self.laststandattacker );
    }
    
    if ( !isdefined( deathdata ) )
    {
        deathdata = {};
    }
    
    deathdata.downedby = self.laststanddowneddata.attacker;
    deathdata.lastattacker = self.lastattacker;
    deathdata.victim = self;
    callback::callback( #"player_laststand_death", deathdata );
    
    if ( isdefined( level.gamemodebundle.var_51d4698eef52d713 ) && soundexists( level.gamemodebundle.var_51d4698eef52d713 ) )
    {
        self playlocalsound( level.gamemodebundle.var_51d4698eef52d713 );
    }
    
    dropcarryobject();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x8a7a0b67, Offset: 0x6f3a
// Size: 0x1f
function private dropcarryobject()
{
    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread gameobjects::setdropped();
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1c42149e, Offset: 0x6f61
// Size: 0x396
function private revivesetup()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        reviveent = spawnscriptable( level.gametypebundle.var_beecd443c84bb043, self.origin );
        reviveent utility::scriptable_setparententity( self );
    }
    else
    {
        reviveent = spawn( "script_model", self.origin );
        reviveent setmodel( "tag_origin" );
    }
    
    self.var_8bec82459b31fc31 = reviveent;
    team = self.team;
    
    if ( !level.gametypebundle.var_beecd443c84bb043 )
    {
        reviveent.origin = self.origin + ( 0, 0, 20 );
        reviveent linkto( self );
    }
    
    reviveent.owner = self;
    reviveent.inuse = 0;
    reviveent.id = "laststand_reviver";
    reviveent.trigger = spawnstruct();
    reviveent.trigger.owner = self;
    reviveent.trigger.id = "laststand_reviver";
    reviveent.trigger.targetname = "revive_trigger";
    
    if ( level.teambased && !level.var_55e4db63d87c12c1 )
    {
        if ( level.gametypebundle.var_beecd443c84bb043 )
        {
            reviveent setscriptablepartstate( "laststand", "usable" );
            
            if ( level.var_34882926662de79c )
            {
                reviveent setscriptablepartstate( "drag_enemy", "usable" );
            }
        }
        else
        {
            reviveent makeusable();
            function_31682488e2e93c93( reviveent );
        }
    }
    
    function_c33e886a836f5aea( reviveent, self );
    
    if ( level.var_55e4db63d87c12c1 )
    {
        reviveent.var_fa12d870598205f2 = spawn( "trigger_radius", self.origin, 0, level.var_92b9a0cbf749d8c6, level.var_3c7a3634fcc7331b );
        reviveent.var_fa12d870598205f2 enablelinkto();
        reviveent.var_fa12d870598205f2 linkto( self );
        reviveent thread proximityrevivethink( team );
        reviveent thread function_c0d40067fd405f4a();
    }
    else
    {
        reviveent thread function_e6ca3b885527ace();
        reviveent thread revivetriggerthink( team );
    }
    
    if ( getdvarint( @"hash_7a493092f8a1c04c", 0 ) && getdvarint( @"hash_ddd02929770fcc8c", 0 ) || player::function_73fe5f51164eb3ca( self ) )
    {
        thread secondwindthink();
    }
    
    self.laststandreviveent = reviveent;
    
    if ( level.var_efa66bf4df7d06c3 )
    {
        if ( level.gametypebundle.var_beecd443c84bb043 )
        {
            self.laststandreviveent setscriptablepartstate( "laststand", "off" );
            
            if ( level.var_34882926662de79c )
            {
                self.laststandreviveent setscriptablepartstate( "drag_enemy", "off" );
            }
        }
        else
        {
            self.laststandreviveent setusableenabled( 0 );
        }
    }
    
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        entnum = reviveent.index;
    }
    else
    {
        entnum = reviveent getentitynumber();
    }
    
    level.laststandreviveents[ entnum ] = reviveent;
    reviveent thread function_cbd040befb7733af();
    thread function_f192de563464139c();
    
    if ( function_aab0a23ef041d1f9() )
    {
        reviveent thread selfrevivethink();
    }
    
    function_c26a7c4bf9ba9d98( self, "Revive Setup" );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xd0b9b6f8, Offset: 0x72ff
// Size: 0x119
function private function_31682488e2e93c93( reviveent )
{
    assert( isdefined( reviveent ) );
    reviveent setcursorhint( "HINT_NOICON" );
    reviveent setusehideprogressbar( 1 );
    reviveent setuseholdduration( "duration_none" );
    reviveent sethintstring( &"mp/laststand_revive_use" );
    reviveent setusepriority( -3 );
    reviveent sethintdisplayfov( 90 );
    reviveent setusefov( 90 );
    
    if ( utility::callsharedfunc( #"interrogate", #"hash_6808d0b902e1f13d" ) && !isdefined( reviveent.headiconon ) && !isdefined( reviveent.headiconoff ) )
    {
        reviveent.headiconon = entityheadicons::setheadicon_singleimage( [], "hud_icon_interrogation", 16, 0, 800, 100, undefined, 1, 1 );
        reviveent.headiconoff = entityheadicons::setheadicon_singleimage( [], "hud_icon_interrogation_active", 16, 0, 800, 100, undefined, 1, 1 );
        setheadiconteam( reviveent.headiconon, reviveent.trigger.owner.team );
    }
}

// Namespace laststand
// Params 0
// Checksum 0x7aa5d004, Offset: 0x7420
// Size: 0x8e
function function_cff5610aef553b5e()
{
    self notify( #"hash_9d2d22b7d61d9a4b" );
    self endon( #"hash_9d2d22b7d61d9a4b" );
    
    if ( !utility::level_supports_ai() || !isdefined( level.var_5f302c2ba0dcf24f ) || level.var_5f302c2ba0dcf24f <= 0 )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    utility::function_6f8a0dfa37023879( 0 );
    val::set( "laststand_ignore", "dontmeleeme", 1 );
    wait level.var_5f302c2ba0dcf24f;
    utility::function_6f8a0dfa37023879( 1 );
    val::reset( "laststand_ignore", "dontmeleeme" );
}

// Namespace laststand
// Params 1
// Checksum 0x86570f9, Offset: 0x74b6
// Size: 0x110
function function_da2b8eafac133316( deathdata )
{
    victim = deathdata.victim;
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e && isdefined( victim.attackers ) )
    {
        foreach ( attacker in victim.attackers )
        {
            if ( attacker.inlaststand )
            {
                attacker thread onlaststandkillenemy( deathdata );
            }
        }
        
        return;
    }
    
    if ( isdefined( deathdata.attacker ) && deathdata.attacker.inlaststand )
    {
        deathdata.attacker thread onlaststandkillenemy( deathdata );
    }
}

// Namespace laststand
// Params 0
// Checksum 0x76dc030f, Offset: 0x75ce
// Size: 0x2d3
function secondwindthink()
{
    downedplayer = self;
    downedplayer endon( #"death_or_disconnect" );
    downedplayer endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    starttimems = gettime();
    
    while ( true )
    {
        downedplayer waittill( #"killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide );
        
        if ( player::function_73fe5f51164eb3ca( downedplayer ) )
        {
            laststandweapon = self [[ level.laststand_syringe_params.laststandweaponcallback ]]();
            
            if ( laststandweapon === objweapon )
            {
                break;
            }
            
            continue;
        }
        
        if ( !attackermismatch )
        {
            break;
        }
    }
    
    assert( downedplayer.inlaststand );
    var_27d4a3941580b2e4 = evictim.laststandattacker;
    
    if ( !isdefined( var_27d4a3941580b2e4 ) )
    {
        var_27d4a3941580b2e4 = evictim;
    }
    
    var_8bdbcd3d7da5ab82 = isdefined( var_27d4a3941580b2e4 ) && var_27d4a3941580b2e4 != downedplayer;
    var_52b8bcac39b24683 = attackermismatch;
    bbledout = bsuicide || isdefined( einflictor ) && einflictor getentitynumber() == worldentnumber();
    var_70cec376cef55e66 = gettime() - starttimems;
    var_b717015fd4296ea6 = float( var_70cec376cef55e66 / 1000 );
    params = { #var_b717015fd4296ea6:var_b717015fd4296ea6, #bbledout:bbledout, #var_52b8bcac39b24683:var_52b8bcac39b24683, #var_8bdbcd3d7da5ab82:var_8bdbcd3d7da5ab82, #laststandweaponname:laststandweaponname, #laststandmeansofdeath:laststandmeansofdeath, #weaponname:weaponname, #meansofdeath:meansofdeath, #var_27d4a3941580b2e4:var_27d4a3941580b2e4, #evictim:evictim };
    downedplayer callback::callback( #"hash_d4e35c0ab858b283", params );
    playersonteam = teams::getteamdata( downedplayer.team, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( player != downedplayer && isalive( player ) )
        {
            player thread hud_message::showsplash( "br_teammate_second_wind", undefined, downedplayer );
        }
    }
    
    downedplayer thread exit( "last_stand_self_revive" );
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0x6a41c696, Offset: 0x78a9
// Size: 0xe7
function private onlaststandkillenemy( deathdata, laststandmeansofdeath, laststandweaponobj )
{
    evictim = deathdata.victim;
    einflictor = deathdata.inflictor;
    objweapon = deathdata.objweapon;
    meansofdeath = deathdata.meansofdeath;
    weaponname = deathdata.weaponfullstring;
    attackermismatch = deathdata.attacker != self;
    bsuicide = istrue( deathdata.assistedsuicide );
    laststandweaponname = undefined;
    
    if ( isdefined( laststandweaponobj ) )
    {
        laststandweaponname = getcompleteweaponname( laststandweaponobj );
    }
    
    self notify( #"killed_enemy_in_last_stand", evictim, einflictor, objweapon, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, attackermismatch, bsuicide );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x33844d8f, Offset: 0x7998
// Size: 0x69
function private function_cbd040befb7733af()
{
    level endon( #"game_ended" );
    
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        entnum = self.index;
    }
    else
    {
        entnum = self getentitynumber();
    }
    
    self.owner utility::waittill_any( "death_or_disconnect", "laststand_revived" );
    level.laststandreviveents[ entnum ] = undefined;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xc072a0b5, Offset: 0x7a09
// Size: 0xce
function private updateusablebyteam( team )
{
    function_4d99c68b969d3ec0();
    
    foreach ( player in level.players )
    {
        if ( player_utility::isfriendly( team, player ) && player != self.owner )
        {
            function_868823d2f6a204d2( self, player );
            continue;
        }
        
        function_9199954e53abe5f( self, player );
    }
    
    function_c26a7c4bf9ba9d98( self.owner, "Updated team usability for team " + team );
}

// Namespace laststand
// Params 0, eflags: 0xc
// Checksum 0x3ead1a3c, Offset: 0x7adf
// Size: 0x7d
function private function_e6ca3b885527ace()
{
    self notify( #"hash_69691c61d7d193e1" );
    self endon( #"hash_69691c61d7d193e1" );
    self endon( #"death" );
    self.owner endon( #"last_stand_exit" );
    
    while ( true )
    {
        updateusablebyteam( self.owner.team );
        function_b2d952f604f64ec8();
        self.owner utility::waittill_any( "joined_team", "refresh_revives" );
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x151b9eeb, Offset: 0x7b64
// Size: 0x38
function private function_b2d952f604f64ec8()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gametype" ][ #"hash_d0478e891f1b7f12" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( self );
    }
}

// Namespace laststand
// Params 2
// Checksum 0x56ffc86a, Offset: 0x7ba4
// Size: 0x81
function function_868823d2f6a204d2( reviveentity, player )
{
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        reviveentity enablescriptablepartplayeruse( "laststand", player );
        
        if ( level.var_34882926662de79c )
        {
            reviveentity disablescriptablepartplayeruse( "drag_enemy", player );
        }
    }
    else
    {
        reviveentity enableplayeruse( player );
    }
    
    function_c26a7c4bf9ba9d98( reviveentity.owner, "Enabling revive entity use for player " + player.name );
}

// Namespace laststand
// Params 2
// Checksum 0x7708a8f7, Offset: 0x7c2d
// Size: 0x5e
function function_9199954e53abe5f( reviveentity, player )
{
    if ( level.gametypebundle.var_beecd443c84bb043 )
    {
        reviveentity disablescriptablepartplayeruse( "laststand", player );
        
        if ( level.var_34882926662de79c )
        {
            reviveentity enablescriptablepartplayeruse( "drag_enemy", player );
        }
        
        return;
    }
    
    reviveentity disableplayeruse( player );
}

// Namespace laststand
// Params 0
// Checksum 0x7b808890, Offset: 0x7c93
// Size: 0x2b, Type: bool
function function_ab17e316019897ca()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( self isdiving() )
    {
        return false;
    }
    
    return true;
}

// Namespace laststand
// Params 1
// Checksum 0xa7d38467, Offset: 0x7cc7
// Size: 0x69, Type: bool
function function_22cc237617ddda56( revivee )
{
    if ( !isdefined( revivee ) )
    {
        return false;
    }
    
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    return self usebuttonpressed() || self.var_73fc3c02a3004c94 || revivee.var_885f2644ce3eb19e || self.b_force_gameobject_use || revivee.var_85e846fdb8674638 || revivee.var_26d9e22abfa6be43;
}

// Namespace laststand
// Params 6, eflags: 0x4
// Checksum 0x2d941142, Offset: 0x7d39
// Size: 0x4a
function private function_6aa666d855e5c1a9( instance, part, state, player, bautouse, usestring )
{
    instance notify( #"trigger", player, 1 );
}

// Namespace laststand
// Params 6, eflags: 0x4
// Checksum 0x37bf3574, Offset: 0x7d8b
// Size: 0x48
function private function_a3617bdebbe3ea9f( instance, part, state, player, bautouse, usestring )
{
    instance notify( #"trigger", player );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x74133b18, Offset: 0x7ddb
// Size: 0x6de
function private revivetriggerthink( team )
{
    self.owner endon( #"last_stand_exit" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", reviver, dragonly );
        
        if ( !level.var_34882926662de79c )
        {
            dragonly = 0;
        }
        
        function_c26a7c4bf9ba9d98( self.owner, "Revive Entity Triggered" );
        
        /#
            reviver notify( #"hash_e1ca0418f57dd9e3" );
        #/
        
        if ( self.owner.var_c3ca6e1ab237a810 )
        {
            continue;
        }
        
        if ( reviver.team != self.owner.team && !self.skipteamchecks && !dragonly )
        {
            continue;
        }
        
        if ( !reviver val::get( "allow_revive_teammate" ) )
        {
            function_c26a7c4bf9ba9d98( self.owner, "Cancelled revive because VAL_ALLOW_REVIVE_TEAMMATE is false" );
            continue;
        }
        
        if ( self.owner.var_378691f0603feecf || reviver.var_a4b2552b9d71144f )
        {
            function_c26a7c4bf9ba9d98( self.owner, "Cancelled revive because the user is being interrogated" );
            continue;
        }
        
        if ( isactor( reviver ) || isplayer( reviver ) )
        {
            revivermover = reviver getmovingplatformparent();
        }
        
        if ( isactor( self.owner ) || isplayer( self.owner ) )
        {
            reviveemover = self.owner getmovingplatformparent();
        }
        
        onmover = isdefined( revivermover ) || isdefined( reviveemover );
        
        if ( onmover && !trace::ray_trace_detail_passed( reviver geteye(), self.origin + ( 0, 0, 20 ), [ reviver, self.owner ], trace::create_contents( 1, 0, 0, 0, 0, 1 ) ) )
        {
            if ( isplayer( reviver ) )
            {
                reviver hud_message::showerrormessage( %"mp/revive_blocked" );
            }
            
            continue;
        }
        
        if ( isdefined( self.var_fc2c12f6a236b9db ) )
        {
            var_fc2c12f6a236b9db = self.var_fc2c12f6a236b9db;
        }
        
        while ( reviver function_22cc237617ddda56( self.owner ) && !reviver function_ab17e316019897ca() )
        {
            waitframe();
        }
        
        var_28fd2832030be6ac = 0;
        
        if ( utility::issharedfuncdefined( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) )
        {
            var_28fd2832030be6ac = self.owner [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) ]]();
        }
        
        if ( reviver.insertingarmorplate && !var_28fd2832030be6ac )
        {
            reviver notify( #"try_armor_cancel", "last_stand_reviver_start" );
            
            while ( reviver.insertingarmorplate && reviver function_22cc237617ddda56( self.owner ) )
            {
                waitframe();
            }
        }
        
        var_f044f2f1e4f710f = isdefined( reviver ) && reviver getcurrentweapon().basenamehash == level.var_19a48e23e837ab98;
        
        if ( var_f044f2f1e4f710f && reviver isswitchingweapon() )
        {
            while ( var_f044f2f1e4f710f && isdefined( reviver ) && reviver isswitchingweapon() && reviver function_22cc237617ddda56( self.owner ) )
            {
                waitframe();
                var_f044f2f1e4f710f = isdefined( reviver ) && reviver getcurrentweapon().basenamehash == level.var_19a48e23e837ab98;
            }
        }
        
        if ( !reviver function_22cc237617ddda56( self.owner ) )
        {
            function_c26a7c4bf9ba9d98( self.owner, "Cancelled revive because the use button state is invalid" );
            continue;
        }
        
        if ( var_f044f2f1e4f710f )
        {
            if ( !reviver utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"forceuse", self.owner ) )
            {
                continue;
            }
            
            self.owner thread exit( "last_stand_revived", reviver );
            continue;
        }
        
        if ( !isdefined( reviver.var_4d17c5af032d909a ) )
        {
            reviver.var_4d17c5af032d909a = 0;
        }
        
        var_268854c98735f699 = function_b5502c5e2119ad7f( reviver, var_28fd2832030be6ac );
        
        if ( var_268854c98735f699 )
        {
            crouchapplied = reviver setstance( "crouch", 0, 0 );
            
            if ( !crouchapplied )
            {
                reviver.var_4d17c5af032d909a = 1;
                var_268854c98735f699 = 0;
                
                if ( dragonly )
                {
                    continue;
                }
            }
        }
        
        self.owner player::setbeingrevivedinternal( 1 );
        self.owner callback::callback( #"player_laststand_revive_start", { #reviver:reviver } );
        reviver callback::callback( #"hash_4cd04b297f3576a", { #revivee:self.owner } );
        function_c26a7c4bf9ba9d98( self.owner, "Revive Start" );
        
        if ( isdefined( level.gamemodebundle.var_87d8541321f8aa72 ) && soundexists( level.gamemodebundle.var_87d8541321f8aa72 ) )
        {
            self.owner playlocalsound( level.gamemodebundle.var_87d8541321f8aa72 );
        }
        
        if ( !var_28fd2832030be6ac && !var_268854c98735f699 )
        {
            reviver thread teamrevive::function_9aa67ac84cd92dc7( self.owner.origin );
        }
        
        self.owner function_a972f0e70d85b369();
        
        if ( level.gametypebundle.var_beecd443c84bb043 )
        {
            self setscriptablepartstate( "laststand", "off" );
            
            if ( level.var_34882926662de79c )
            {
                self setscriptablepartstate( "drag_enemy", "off" );
            }
        }
        else
        {
            self makeunusable();
        }
        
        if ( isplayer( reviver ) && reviver usingtouch() )
        {
            reviver function_6fde12b889a1f3f8( &"mp/laststand_revive_use" );
        }
        
        if ( isplayer( reviver ) )
        {
            reviver setlaststandreviving( 1, var_28fd2832030be6ac );
        }
        
        reviver function_337aa8851af4f236( self.owner );
        
        if ( isdefined( self.owner.perks[ "specialty_survivor" ] ) )
        {
            self.owner namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_survivor" );
        }
        
        reviver utility::callsharedfunc( #"playerdrag", #"hash_688f5b29fcf2efb2", self.owner, &function_90d749febff3150 );
        
        if ( reviver && !var_28fd2832030be6ac && !reviver.usingremoterevive && !self.owner.var_885f2644ce3eb19e )
        {
            reviver thread switchtoteammatereviveweapon( self.owner, undefined, dragonly, var_268854c98735f699 );
        }
        
        if ( level.var_894cf9c132c87505 )
        {
            self.owner setplayerbeingrevivedextrainfo( 1 );
        }
        
        useholdthink( reviver, var_fc2c12f6a236b9db, dragonly );
        waittillframeend();
    }
}

// Namespace laststand
// Params 1
// Checksum 0x81cb9a6, Offset: 0x84c1
// Size: 0x51a
function proximityrevivethink( team )
{
    self notify( #"hash_1a53bdb71818b481" );
    self endon( #"hash_1a53bdb71818b481" );
    revivee = self.owner;
    revivee endon( #"last_stand_exit" );
    revivee endon( #"disconnect" );
    level endon( #"game_ended" );
    function_b6fc039c81a23fce( self, 1, function_21539f7d3fd7080a( self, 1 ) );
    self.usetime = level.laststandrevivetimer * 1000;
    self.usetime *= revivee function_ef7bc47aca6f1c51( 1, 0 );
    var_162f3511e2fcd791 = 0;
    var_26dacdf8ae5f50a1 = [];
    primaryreviver = undefined;
    friendlies = teams::getteamdata( team, "players" );
    
    while ( true )
    {
        revivers = [];
        
        foreach ( player in friendlies )
        {
            if ( player == revivee )
            {
                continue;
            }
            
            if ( !isalive( player ) || player.team != team || player.inlaststand )
            {
                continue;
            }
            
            if ( player istouching( self.var_fa12d870598205f2 ) )
            {
                revivers[ revivers.size ] = player;
            }
        }
        
        if ( revivers.size > 0 )
        {
            if ( !isalive( primaryreviver ) || !arraycontains( revivers, primaryreviver ) )
            {
                primaryreviver = revivers[ 0 ];
            }
            
            foreach ( prev in var_26dacdf8ae5f50a1 )
            {
                if ( !arraycontains( revivers, prev ) )
                {
                    function_648891499d2e47a3( prev );
                }
            }
            
            if ( !var_162f3511e2fcd791 )
            {
                revivee player::setbeingrevivedinternal( 1 );
                revivee function_25a2e710b8054c1c( primaryreviver );
                
                foreach ( reviver in revivers )
                {
                    revivee function_4809061347e8d7de( reviver );
                }
                
                revivee function_a972f0e70d85b369();
                var_162f3511e2fcd791 = 1;
            }
            else
            {
                foreach ( reviver in revivers )
                {
                    if ( !arraycontains( var_26dacdf8ae5f50a1, reviver ) )
                    {
                        revivee function_4809061347e8d7de( reviver );
                    }
                }
            }
            
            progressscalar = level.var_8a6748b072b9c6c4;
            
            if ( progressscalar > 0 && revivers.size > 1 )
            {
                progressscalar *= revivers.size;
            }
            
            function_b6fc039c81a23fce( self, 1, self.curprogress + level.frameduration * progressscalar );
            var_95637ef67d14b8a8 = self.curprogress / self.usetime;
            revivee function_25a2e710b8054c1c( primaryreviver );
            revivee function_ca049c55ceacf84f( primaryreviver, var_95637ef67d14b8a8 );
            
            foreach ( reviver in revivers )
            {
                revivee function_ca048955ceacce86( reviver, var_95637ef67d14b8a8 );
            }
            
            if ( self.curprogress >= self.usetime )
            {
                revivee function_2dc568e2b533cb5d( revivee, primaryreviver, revivers );
                return;
            }
            
            var_26dacdf8ae5f50a1 = revivers;
        }
        else if ( var_162f3511e2fcd791 )
        {
            foreach ( prev in var_26dacdf8ae5f50a1 )
            {
                function_648891499d2e47a3( prev );
            }
            
            var_26dacdf8ae5f50a1 = [];
            primaryreviver = undefined;
            revivee player::setbeingrevivedinternal( 0 );
            revivee resetomnvars();
            revivee val::group_reset( "laststand_being_revived" );
            revivee val::group_reset( "laststand_being_revived_disallows" );
            revivee.var_3ded14e19d81ef7e = undefined;
            var_162f3511e2fcd791 = 0;
        }
        
        waitframe();
    }
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0x23adc755, Offset: 0x89e3
// Size: 0x1b2
function private function_2dc568e2b533cb5d( revivee, primaryreviver, revivers )
{
    foreach ( reviver in revivers )
    {
        function_648891499d2e47a3( reviver );
    }
    
    if ( primaryreviver gameplay_telemetry_utils::function_944c6d9098e40dfb( revivee ) )
    {
        primaryreviver thread gameplay_telemetry::function_383cde919fd850c4( "teamRevive", 2 );
    }
    
    primaryreviver callback::callback( #"hash_399a5fbd0e29ab64", { #revivee:revivee } );
    
    if ( primaryreviver.team == revivee.team )
    {
        primaryreviver thread points::doscoreevent( #"reviver" );
    }
    
    if ( revivee.team == primaryreviver.team )
    {
        revivee thread rank::scoreeventpopup( #"revived" );
    }
    
    revivee player::setbeingrevivedinternal( 0 );
    revivee resetomnvars();
    revivee val::group_reset( "laststand_being_revived" );
    revivee val::group_reset( "laststand_being_revived_disallows" );
    revivee.var_3ded14e19d81ef7e = undefined;
    params = { #result:"proximity_think_success", #reviver:primaryreviver };
    revivee callback::callback( #"hash_bca297ef8a461ca2", params );
    revivee.var_cc6476ac60a4ec2f = revivers;
    revivee thread exit( "last_stand_revived", primaryreviver );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xfed21477, Offset: 0x8b9d
// Size: 0x41
function private function_c0d40067fd405f4a()
{
    self.owner utility::waittill_any( "last_stand_exit", "death_or_disconnect" );
    
    if ( isdefined( self.var_fa12d870598205f2 ) )
    {
        self.var_fa12d870598205f2 delete();
        self.var_fa12d870598205f2 = undefined;
    }
}

// Namespace laststand
// Params 4
// Checksum 0x455bcba0, Offset: 0x8be6
// Size: 0x17a
function switchtoteammatereviveweapon( revivee, interrogation = 0, dragonly = 0, var_268854c98735f699 = 0 )
{
    reviver = self;
    reviver endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( dragonly )
    {
        reviver endon( #"hash_1878f568325c9cf7" );
        
        while ( reviver isgestureplaying() )
        {
            waitframe();
        }
        
        reviver forceplaygestureviewmodel( "vm_ges_loot_container" );
        return;
    }
    else if ( var_268854c98735f699 )
    {
        weaponobj = makeweapon( "rex_me_teammate_drag_revive_shot_mp" );
    }
    else if ( interrogation )
    {
        weaponobj = makeweapon( "interrogation_tools_mp" );
    }
    else if ( isdefined( self.perks[ "specialty_rally_point" ] ) )
    {
        weaponobj = makeweapon( level.perkbundles[ "specialty_rally_point" ].var_7ff470aa9ed5af31 );
    }
    else
    {
        weaponobj = makeweapon( level.var_99884af80074e803 );
    }
    
    reviver.var_7f69e029a144815e = weaponobj;
    reviver loadweaponsforplayer( [ weaponobj ], 1 );
    
    if ( !reviver.var_1419a84d4c35f5d5 )
    {
        reviver inventory_utility::_giveweapon( weaponobj, 0, 0, 0 );
    }
    
    if ( !reviver.var_1419a84d4c35f5d5 )
    {
        inventory_utility::domonitoredweaponswitch( weaponobj, isbot( reviver ), 1 );
    }
    
    if ( isdefined( reviver.var_1419a84d4c35f5d5 ) )
    {
        reviver.var_1419a84d4c35f5d5 = undefined;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1bbc08e3, Offset: 0x8d68
// Size: 0x75
function private function_3ebb0a7a067d94c4()
{
    currentweapon = self.lastdroppableweaponobj;
    
    if ( self.super )
    {
        superinfo = supers_mp::getcurrentsuper( self.super.slot );
        
        if ( superinfo.staticdata.var_99afe05c38b6392c )
        {
            currentweapon = self.super.var_7ef7600ff6978d76;
        }
    }
    
    return currentweapon;
}

// Namespace laststand
// Params 2
// Checksum 0x50f576cf, Offset: 0x8de6
// Size: 0x179
function function_359bd937925a2e1d( weaponobj, restorelastweapon )
{
    reviver = self;
    reviver endon( #"disconnect" );
    level endon( #"game_ended" );
    reviver notify( #"hash_1878f568325c9cf7" );
    
    if ( level.var_34882926662de79c && reviver isgestureplaying( "vm_ges_loot_container" ) )
    {
        reviver stopgestureviewmodel( "vm_ges_loot_container", 0.3 );
        return;
    }
    
    if ( level.var_8cf3d608117ef48e )
    {
        reviver [[ level.var_8cf3d608117ef48e ]]( weaponobj, restorelastweapon );
        return;
    }
    
    if ( level.gametypebundle.var_7847b88904f87324 )
    {
        if ( reviver hasweapon( weaponobj ) && reviver gethighpriorityweapon() == weaponobj )
        {
            reviver clearhighpriorityweapon( weaponobj );
        }
    }
    else if ( self hasweapon( weaponobj ) )
    {
        if ( reviver inventory_utility::isswitchingtoweaponwithmonitoring( weaponobj ) )
        {
            reviver inventory_utility::abortmonitoredweaponswitch( weaponobj );
        }
        else
        {
            reviver inventory_utility::_takeweapon( weaponobj );
        }
    }
    
    if ( restorelastweapon )
    {
        weapontoswitch = reviver function_3ebb0a7a067d94c4();
        reviver inventory_utility::domonitoredweaponswitch( weapontoswitch, isbot( reviver ) );
        currentweapon = reviver getcurrentweapon();
        
        if ( currentweapon.basename == "none" )
        {
            reviver inventory_utility::forcevalidweapon();
        }
    }
    
    if ( level.gametypebundle.var_7847b88904f87324 )
    {
        while ( reviver getcurrentweapon() == weaponobj )
        {
            waitframe();
        }
        
        reviver takeweapon( weaponobj );
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x37fc3899, Offset: 0x8f67
// Size: 0x16e
function private function_f192de563464139c()
{
    revivee = self;
    
    if ( !isplayer( revivee ) )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    var_481e489ce1afebac = getdvarint( @"hash_fa3a2702c11c396c", 0 ) == 1;
    
    if ( !var_481e489ce1afebac )
    {
        return;
    }
    
    revivee endon( #"death_or_disconnect" );
    revivee endon( #"last_stand_exit" );
    
    if ( !isai( revivee ) )
    {
        revivee notifyonplayercommand( "stanceChangePressed", "+stancedown" );
        revivee notifyonplayercommand( "stanceChangePressed", "+movedown" );
        revivee notifyonplayercommand( "stanceChangePressed", "+prone" );
        revivee notifyonplayercommand( "stanceChangePressed", "+stance" );
        revivee notifyonplayercommand( "stanceChangePressed", "+togglecrouch" );
        revivee notifyonplayercommand( "stanceChangeReleased", "-stancedown" );
        revivee notifyonplayercommand( "stanceChangeReleased", "-movedown" );
        revivee notifyonplayercommand( "stanceChangeReleased", "-prone" );
        revivee notifyonplayercommand( "stanceChangeReleased", "-stance" );
        revivee notifyonplayercommand( "stanceChangeReleased", "-togglecrouch" );
    }
    
    for ( ;; )
    {
        revivee waittill( #"stanceChangePressed" );
        timestarted = gettime();
        revivee waittill( #"stanceChangeReleased" );
        durationheld = gettime() - timestarted;
        tap_threshold = 350;
        
        if ( durationheld < tap_threshold )
        {
            function_e1a759d2125d835a( revivee );
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x6fc0704, Offset: 0x90dd
// Size: 0x6a
function private function_e1a759d2125d835a( revivee )
{
    revivee.var_37064d2e7bfab77c = !revivee.var_37064d2e7bfab77c;
    willprone = istrue( revivee.var_37064d2e7bfab77c );
    stancetext = willprone ? %"mp_br_ingame/will_revive_into_prone" : %"mp_br_ingame/will_revive_into_crouch";
    revivee hud_message::showerrormessage( stancetext );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xc81302d1, Offset: 0x914f
// Size: 0x60
function private function_6f62cb98d5e9b776()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    val::set( "laststand", "offhand_secondary_weapons", 0 );
    
    while ( self isthrowingbackgrenade() )
    {
        self.var_7f11590a9240bfb5 = 1;
        self giveandfireoffhand( "rock_mp" );
        wait 1;
    }
    
    val::set( "laststand", "offhand_secondary_weapons", 1 );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1cd13ffb, Offset: 0x91b7
// Size: 0x16
function private function_7ee2bc98c2a16455()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    function_4cc4db36852a8494();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x1335479d, Offset: 0x91d5
// Size: 0xce
function private function_4cc4db36852a8494()
{
    if ( !isdefined( level.gamemodebundle ) )
    {
        self setstance( "stand" );
        return;
    }
    
    var_a4f7e55cfe3459e2 = level.gamemodebundle.var_48ba75867c5a20d2 ?? "NONE";
    
    /#
        var_157e62fabf276296 = getdvar( @"hash_6362ce5499b7fb6f" );
        
        if ( isdefined( var_157e62fabf276296 ) )
        {
            var_a4f7e55cfe3459e2 = var_157e62fabf276296;
        }
    #/
    
    switch ( var_a4f7e55cfe3459e2 )
    {
        case #"hash_b5d4f2ac1b263b63":
            self setstance( "stand" );
            break;
        case #"hash_a8f9e4a698fa0eeb":
            self setstance( "crouch" );
            break;
        case #"hash_e85597ec7477d565":
            self setstance( "prone" );
            break;
        default:
            break;
    }
}

// Namespace laststand
// Params 1
// Checksum 0xe5d5850f, Offset: 0x92ab
// Size: 0x132
function decayreviveprogress( progresstrack = 1 )
{
    self.owner endon( #"last_stand_exit" );
    self.owner endon( #"disconnect" );
    self endon( #"hash_be49f7d04abd5152" );
    self endon( #"death" );
    level endon( #"game_ended" );
    decayscale = level.laststandrevivedecayscale;
    function_b6fc039c81a23fce( self, progresstrack, function_21539f7d3fd7080a( self, progresstrack ) );
    
    if ( decayscale <= 0 )
    {
        return;
    }
    
    if ( isdefined( self.lastvaliduser ) && self.lastvaliduser function_22cc237617ddda56( self.owner ) )
    {
        return;
    }
    
    function_b6fc039c81a23fce( self, progresstrack, max( 0, self.curprogress - ( level.gametypebundle.var_641dd8c66b2ebede ?? 0 ) * 1000 ) );
    
    while ( true )
    {
        function_b6fc039c81a23fce( self, progresstrack, self.curprogress - level.frameduration * decayscale );
        
        if ( self.curprogress <= 0 )
        {
            function_b6fc039c81a23fce( self, progresstrack, 0 );
            return;
        }
        
        waitframe();
    }
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0xe653cda9, Offset: 0x93e5
// Size: 0x1cc
function private function_ef7bc47aca6f1c51( var_1fbcda1929575474, var_e52f502c898fe6eb, reviver )
{
    revivee = self;
    timefactors = [];
    timefactors[ timefactors.size ] = 1;
    
    if ( var_1fbcda1929575474 && !level.var_538711d192c11c84 )
    {
        if ( isdefined( revivee.perks[ "specialty_medic" ] ) )
        {
            timefactors[ timefactors.size ] = 0.5;
        }
        
        if ( isdefined( revivee.perks[ "specialty_25_percent_faster_revive" ] ) )
        {
            timefactors[ timefactors.size ] = 0.75;
        }
        
        if ( revivee utility::ent_flag( "dark_flare_active" ) && isdefined( revivee.var_16a6377471fb6976 ) )
        {
            timefactors[ timefactors.size ] = revivee.var_16a6377471fb6976;
        }
        
        if ( isdefined( revivee.var_a12ec60b3cfebf6b ) )
        {
            timefactors[ timefactors.size ] = revivee.var_a12ec60b3cfebf6b;
        }
    }
    
    if ( var_e52f502c898fe6eb )
    {
        if ( isplayer( reviver ) && isdefined( reviver.perks[ "specialty_fast_reviver_25" ] ) )
        {
            timefactors[ timefactors.size ] = 0.75;
            reviver setclientomnvar( "ui_perk_fast_reviver_25", 1 );
            revivee setclientomnvar( "ui_perk_fast_reviver_25", 1 );
        }
        
        if ( isdefined( reviver.perks[ "specialty_medic" ] ) )
        {
            timefactors[ timefactors.size ] = 0.5;
        }
        
        if ( isdefined( reviver.perks[ "specialty_25_percent_faster_revive" ] ) )
        {
            timefactors[ timefactors.size ] = 0.75;
        }
        
        if ( reviver utility::ent_flag( "dark_flare_active" ) && isdefined( reviver.var_16a6377471fb6976 ) )
        {
            timefactors[ timefactors.size ] = reviver.var_16a6377471fb6976;
        }
        
        if ( isdefined( reviver.var_a12ec60b3cfebf6b ) )
        {
            timefactors[ timefactors.size ] = reviver.var_a12ec60b3cfebf6b;
        }
    }
    
    timefactors = arraysort( timefactors );
    return timefactors[ 0 ];
}

// Namespace laststand
// Params 3, eflags: 0x4
// Checksum 0x8695ee9b, Offset: 0x95ba
// Size: 0x4aa
function private useholdthink( reviver, var_fc2c12f6a236b9db, dragonly = 0 )
{
    revivee = self.owner;
    level endon( #"game_ended" );
    revivee endon( #"death_or_disconnect" );
    revivee endon( #"last_stand_exit" );
    self.lastvaliduser = reviver;
    var_28fd2832030be6ac = 0;
    
    if ( utility::issharedfuncdefined( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) )
    {
        var_28fd2832030be6ac = self.owner [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) ]]();
    }
    
    self.var_c23990f67f45ae58 = function_10f71e4322c49a0f( reviver, var_28fd2832030be6ac );
    
    if ( !var_28fd2832030be6ac && !reviver.usingremoterevive && !self.owner.var_885f2644ce3eb19e )
    {
        reviver val::group_set( self.var_c23990f67f45ae58, 0 );
    }
    
    revivee val::group_set( "laststand_being_revived", 0 );
    revivee val::group_set( "laststand_being_revived_disallows", 1 );
    self notify( #"hash_be49f7d04abd5152" );
    revivee notify( #"revive_start" );
    
    if ( !var_28fd2832030be6ac )
    {
    }
    
    function_b6fc039c81a23fce( self, 1, function_21539f7d3fd7080a( self, 1 ) );
    self.inuse = 1;
    self.userate = 0;
    self.usetime = level.laststandrevivetimer * 1000;
    
    if ( isdefined( revivee.var_400070c824a25410 ) )
    {
        self.usetime = revivee.var_400070c824a25410 * 1000;
    }
    
    if ( game_utility::function_3f43b9ae1e48e83f() )
    {
        self.usetime = getdvarint( @"hash_fc87421e7a34d740", 2000 );
    }
    
    if ( isdefined( reviver.perks[ "specialty_combat_medic" ] ) )
    {
        bundle = level.perkbundles[ "specialty_combat_medic" ];
        revivefactor = bundle.var_6189f9d557ce572e;
        self.usetime *= revivefactor;
    }
    
    if ( isdefined( reviver.var_3e398b71be70e3c6 ) )
    {
        self.usetime *= reviver.var_3e398b71be70e3c6;
    }
    
    if ( isdefined( reviver.var_ee80ad773b7fac32.var_996add39bd6ff1a5 ) )
    {
        self.usetime *= reviver.var_ee80ad773b7fac32.var_996add39bd6ff1a5;
    }
    
    self.usetime *= revivee function_ef7bc47aca6f1c51( 1, 1, reviver );
    
    if ( isdefined( reviver.var_4cd26d897a2b876a ) )
    {
        self.usetime = reviver.var_4cd26d897a2b876a;
    }
    
    var_a3a6911663b461e8 = max( 500, self.usetime - 500 );
    function_b6fc039c81a23fce( self, 1, min( self.curprogress, var_a3a6911663b461e8 ) );
    
    if ( !level.var_27d1beb8576f49c4 )
    {
        if ( revivee.team == reviver.team )
        {
            level thread battlechatter_mp::trysaylocalsound( reviver, #"bc_status_action_reviving" );
        }
        else
        {
            level thread battlechatter_mp::trysaylocalsound( reviver, #"bc_status_action_reviving_hostile" );
        }
    }
    
    shouldstay = getdvarint( @"hash_a23e8f787d85f762", 0 );
    mintime = getdvarfloat( @"hash_15e9b25b07a2bbb6", 0.5 ) * 1000 + gettime();
    
    if ( !dragonly )
    {
        revivee function_1d7c35bc34983a15( reviver );
    }
    
    reviver.usepressed = 0;
    reviver.toggleuse = 0;
    
    while ( useholdthinkisvalid( reviver, revivee, mintime, shouldstay ) )
    {
        reviver playerlogic::function_3765e79e200dd60f();
        
        if ( !dragonly )
        {
            function_b6fc039c81a23fce( self, 1, self.curprogress + level.frameduration * self.userate );
            self.userate = 1;
            revivee function_2a6fde9dfe8639bc( reviver, self.curprogress / self.usetime );
            
            if ( self.curprogress >= self.usetime )
            {
                if ( reviver gameplay_telemetry_utils::function_944c6d9098e40dfb( revivee ) )
                {
                    reviver thread gameplay_telemetry::function_383cde919fd850c4( "teamRevive", 2 );
                }
                
                reviver callback::callback( #"hash_399a5fbd0e29ab64", { #revivee:self.owner } );
                useholdthinkcleanup( "use_hold_think_success", var_fc2c12f6a236b9db );
                return;
            }
        }
        
        waitframe();
    }
    
    useholdthinkcleanup( "use_hold_think_fail" );
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x81b006ae, Offset: 0x9a6c
// Size: 0x423
function private useholdthinkcleanup( result, var_fc2c12f6a236b9db )
{
    if ( !self.inuse )
    {
        return;
    }
    
    reviver = self.lastvaliduser;
    revivee = self.owner;
    
    if ( reviver )
    {
        vehicleplatform = reviver vehicle_occupancy::function_bfb3bb62a0e41e66();
        
        if ( vehicleplatform )
        {
            level thread vehicle_collision::function_e3bc60c772acd609( vehicleplatform, reviver );
        }
    }
    
    self.inuse = 0;
    
    if ( reviver )
    {
        reviver teamrevive::function_578cb5a940497b93();
        
        if ( isplayer( reviver ) )
        {
            reviver buddyrevivingdoneanimevent();
            reviver setlaststandreviving( 0 );
            reviver resetomnvars();
            
            if ( reviver usingtouch() )
            {
                reviver forceusehintoff();
            }
        }
        
        reviver function_cced0113fddd8e8d( revivee );
        reviver notify( #"sfx_revive_done" );
    }
    
    if ( revivee )
    {
        revivee resetomnvars();
        revivee val::group_reset( "laststand_being_revived" );
        revivee val::group_reset( "laststand_being_revived_disallows" );
        revivee.var_3ded14e19d81ef7e = undefined;
        revivee player::setbeingrevivedinternal( 0 );
        
        if ( level.var_894cf9c132c87505 )
        {
            revivee setplayerbeingrevivedextrainfo( 0 );
        }
    }
    
    if ( reviver && revivee && utility::issharedfuncdefined( #"playerdrag", #"hash_baf67d7c3c63a5e7" ) )
    {
        reviver utility::callsharedfunc( #"playerdrag", #"hash_baf67d7c3c63a5e7", revivee );
    }
    
    if ( reviver )
    {
        reviver.var_4d17c5af032d909a = undefined;
    }
    
    if ( reviver && player::isreallyalive( reviver ) )
    {
        reviver val::group_reset( self.var_c23990f67f45ae58 ?? level.var_3e5605730504d2c );
    }
    
    self.var_c23990f67f45ae58 = undefined;
    
    if ( result == "use_hold_think_success" )
    {
        if ( reviver.team == self.owner.team )
        {
            reviver thread points::doscoreevent( #"reviver" );
        }
        
        if ( level.allowselfrevive )
        {
            reviver allowselfrevive( 1 );
        }
        
        if ( revivee.team == reviver.team )
        {
            revivee thread rank::scoreeventpopup( #"revived" );
        }
    }
    else if ( result == "use_hold_think_fail" && revivee )
    {
        revivee function_a972f0e70d85b369();
    }
    
    if ( reviver )
    {
        reviver.var_3ded14e19d81ef7e = undefined;
        
        if ( isplayer( reviver ) && reviver usingtouch() )
        {
            reviver forceusehintoff();
        }
        
        restorelastweapon = reviver player::isreallyalive() && !player::isinlaststand( reviver );
        var_58445c6c78ac9ddf = isdefined( reviver.var_7f69e029a144815e ) ? reviver.var_7f69e029a144815e : makeweapon( level.var_99884af80074e803 );
        reviver thread function_359bd937925a2e1d( var_58445c6c78ac9ddf, restorelastweapon );
        reviver.var_7f69e029a144815e = undefined;
    }
    
    if ( result == "use_hold_think_success" )
    {
        if ( isdefined( var_fc2c12f6a236b9db ) )
        {
            revivee thread exit( var_fc2c12f6a236b9db, reviver );
        }
        else
        {
            revivee thread exit( "last_stand_revived", reviver );
        }
    }
    else if ( result == "use_hold_think_fail" )
    {
        thread decayreviveprogress( 1 );
        
        if ( level.gametypebundle.var_beecd443c84bb043 )
        {
            self setscriptablepartstate( "laststand", "usable" );
            
            if ( level.var_34882926662de79c )
            {
                self setscriptablepartstate( "drag_enemy", "usable" );
            }
        }
        else
        {
            self makeusable();
            function_31682488e2e93c93( self );
        }
        
        if ( isdefined( revivee ) )
        {
            revivee setplayerdownedextrainfo( 1 );
        }
        
        updateusablebyteam( revivee.team );
        
        if ( isdefined( level.gamemodebundle.var_87d8541321f8aa72 ) && soundexists( level.gamemodebundle.var_87d8541321f8aa72 ) )
        {
            revivee stoplocalsound( level.gamemodebundle.var_87d8541321f8aa72 );
        }
    }
    
    params = { #result:result, #reviver:reviver };
    revivee callback::callback( #"hash_bca297ef8a461ca2", params );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xfcdca627, Offset: 0x9e97
// Size: 0xc1
function private sfx_revive_lp()
{
    soundorg = spawn( "script_origin", self.origin );
    soundorg.targetname = "sfx_revive_lp";
    soundorg linkto( self );
    soundorg playloopsound( "eqp_revive_use_lp" );
    
    if ( isdefined( self.perks[ "specialty_pc_medic" ] ) && isdefined( self.origin ) )
    {
        thread function_f02c525b629d4a55( soundorg );
    }
    
    utility::waittill_any( "sfx_revive_done", "disconnect" );
    
    if ( isdefined( self.origin ) )
    {
        soundorg stoploopsound( "eqp_revive_br_medic_vest" );
        waitframe();
        
        if ( isdefined( self.origin ) )
        {
            playsoundatpos( self.origin, "eqp_revive_use_end" );
        }
    }
    
    soundorg delete();
}

// Namespace laststand
// Params 1
// Checksum 0x6e779c44, Offset: 0x9f60
// Size: 0x24
function function_f02c525b629d4a55( soundorg )
{
    wait 0.7;
    
    if ( isdefined( soundorg ) )
    {
        soundorg playloopsound( "eqp_revive_br_medic_vest" );
    }
}

// Namespace laststand
// Params 4
// Checksum 0x8b385a0e, Offset: 0x9f8c
// Size: 0x1b9, Type: bool
function useholdthinkisvalid( reviver, revivee, mintime, shouldstay )
{
    if ( !player::isreallyalive( reviver ) )
    {
        return false;
    }
    
    if ( reviver.inlaststand && !reviver.var_847214b1ff739bfc && !reviver.usingremoterevive && !revivee.var_885f2644ce3eb19e )
    {
        return false;
    }
    
    if ( reviver.extracted || revivee.extracted )
    {
        return false;
    }
    
    if ( !reviver function_22cc237617ddda56( revivee ) && !reviver.toggleuse && !shouldstay && !( gettime() < mintime ) )
    {
        return false;
    }
    
    var_28fd2832030be6ac = 0;
    
    if ( utility::issharedfuncdefined( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) )
    {
        var_28fd2832030be6ac = revivee [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5" ) ]]();
    }
    
    if ( distancesquared( reviver.origin, self.origin ) > ( level.var_514a7139f92200 ?? 65536 ) && !var_28fd2832030be6ac && !reviver.usingremoterevive && !revivee.var_885f2644ce3eb19e && !revivee.usingremoterevive )
    {
        return false;
    }
    
    if ( reviver.ishaywire )
    {
        return false;
    }
    
    if ( reviver isinexecutionvictim() )
    {
        return false;
    }
    
    if ( reviver ismeatshieldvictim() )
    {
        return false;
    }
    
    if ( reviver.var_3ded14e19d81ef7e || revivee.var_3ded14e19d81ef7e )
    {
        return false;
    }
    
    return true;
}

// Namespace laststand
// Params 0
// Checksum 0xebf0c5a7, Offset: 0xa14e
// Size: 0x328
function suicidesetup()
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    
    if ( level.gametypebundle.var_bf649e205a23431f )
    {
        return;
    }
    
    if ( !level.var_894cf9c132c87505 )
    {
        thread showsuicidehintstring();
    }
    
    var_26b53d0edfbca519 = getdvarint( @"hash_45dbdc45bdf8f5ff", 0 );
    var_aeaa27af02d7c397 = getdvarfloat( @"hash_f36ad71f9fadec59", 300 );
    
    /#
        level.var_13b0620070ce02a9 = getdvarfloat( @"hash_9f647aa84d08a764", 3 );
    #/
    
    if ( !isbot( self ) && getdvarint( @"hash_c38a4336be9a7080", 0 ) == 1 )
    {
        thread suicidemonitorcrouchbuttonpress();
    }
    
    holdtime = 0;
    use_hold_time = level.var_7b86745abab35c1b;
    
    if ( utility::callsharedfunc( #"interrogate", #"hash_6808d0b902e1f13d" ) )
    {
        use_hold_time = level.var_13b0620070ce02a9;
    }
    
    while ( true )
    {
        waitframe();
        
        if ( self stancebuttonpressed() && self isinexecutionvictim() == 0 && self ismeatshieldvictim() == 0 && !player::getbeingrevivedinternal() && !selfrevivebuttonpressed( self ) && !function_96e527529c5dcd37() && !self.var_daa8e6704828e14f )
        {
            if ( utility::callsharedfunc( #"interrogate", #"hash_6808d0b902e1f13d" ) )
            {
                if ( isdefined( self.laststandreviveent ) )
                {
                    if ( self.laststandreviveent.var_9a9b244e39de18b6 )
                    {
                        holdtime = 0;
                        setstateomnvar( 0 );
                        setprogressomnvar( 0 );
                        hud_message::showerrormessage( %"mp_br_ingame/interrogation_in_progress" );
                        wait 0.5;
                        continue;
                    }
                }
                
                if ( var_26b53d0edfbca519 )
                {
                    players = getplayersinradius( self.origin, var_aeaa27af02d7c397 );
                    
                    foreach ( player in players )
                    {
                        if ( player.team != self.team )
                        {
                            self iprintlnbold( "There are enemies near by..." );
                            holdtime = 0;
                            
                            if ( !selfrevivebuttonpressed( self ) && !function_96e527529c5dcd37() )
                            {
                                setstateomnvar( 0 );
                                setprogressomnvar( 0 );
                            }
                            
                            wait 0.5;
                            break;
                        }
                    }
                }
            }
            
            setstateomnvar( 20 );
            
            if ( holdtime >= use_hold_time )
            {
                setstateomnvar( 0 );
                setprogressomnvar( 0 );
                break;
            }
            
            progress_ratio = holdtime / use_hold_time;
            setprogressomnvar( progress_ratio );
            holdtime += level.framedurationseconds;
            continue;
        }
        
        holdtime = 0;
        
        if ( !selfrevivebuttonpressed( self ) && !self.beingrevived && !function_96e527529c5dcd37() )
        {
            setstateomnvar( 0 );
        }
    }
    
    bleedout();
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xf0950630, Offset: 0xa47e
// Size: 0xb2
function private giveupprogressbar( var_5cf248ca0b0d576c )
{
    self endon( #"death_or_disconnect" );
    self endon( #"stance_pressed_up" );
    self endon( #"hash_874ea76c6bbb1666" );
    self endon( #"self_revive_start" );
    self endon( #"revive_start" );
    level endon( #"game_ended" );
    setstateomnvar( 20 );
    progress = 0;
    
    while ( true )
    {
        if ( progress >= var_5cf248ca0b0d576c )
        {
            break;
        }
        
        progress_ratio = progress / var_5cf248ca0b0d576c;
        setprogressomnvar( progress_ratio );
        progress += level.frameduration;
        waitframe();
    }
    
    setstateomnvar( 0 );
    setprogressomnvar( 0 );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xeaf2b494, Offset: 0xa538
// Size: 0x2bb
function private suicidemonitorcrouchbuttonpress()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notifyonplayercommand( "stance_pressed_down", "+give_up" );
    self notifyonplayercommand( "stance_pressed_up", "-give_up" );
    holdtime = gettime();
    giveup = 0;
    starttimer = 0;
    
    if ( utility::callsharedfunc( #"interrogate", #"hash_6808d0b902e1f13d" ) )
    {
        use_hold_time = level.var_13b0620070ce02a9;
    }
    else
    {
        use_hold_time = level.var_7b86745abab35c1b;
    }
    
    var_5cf248ca0b0d576c = use_hold_time * 1000;
    endloop = 0;
    
    while ( !endloop && !giveup )
    {
        giveup = 0;
        
        if ( !starttimer )
        {
            holdtime = gettime();
        }
        
        ret = utility::waittill_any_timeout( use_hold_time, "stance_pressed_down", "stance_pressed_up", "last_stand_exit", "self_revive_start", "revive_start" );
        
        switch ( ret )
        {
            case #"hash_9b3673b33c822e31":
                if ( !selfrevivebuttonpressed( self ) && !player::getbeingrevivedinternal() )
                {
                    holdtime = gettime();
                    starttimer = 1;
                    self notify( #"hash_ed1cea6a90c6e3c9" );
                    thread giveupprogressbar( var_5cf248ca0b0d576c );
                    
                    if ( isdefined( level.gamemodebundle.var_52530e2e838a636d ) && soundexists( level.gamemodebundle.var_52530e2e838a636d ) )
                    {
                        self playlocalsound( level.gamemodebundle.var_52530e2e838a636d );
                    }
                }
                
                break;
            case #"hash_f0a7edb65e311d04":
                self notify( #"hash_2e5c664dc104a548" );
                starttimer = 0;
                
                if ( isdefined( level.gamemodebundle.var_52530e2e838a636d ) && soundexists( level.gamemodebundle.var_52530e2e838a636d ) )
                {
                    self stoplocalsound( level.gamemodebundle.var_52530e2e838a636d );
                }
            case #"hash_d4dde12b38318c68":
                if ( starttimer && gettime() - holdtime >= var_5cf248ca0b0d576c )
                {
                    self notify( #"hash_874ea76c6bbb1666" );
                    giveup = 1;
                }
                
                break;
            default:
                endloop = 1;
                break;
        }
        
        waitframe();
    }
    
    if ( giveup )
    {
        if ( self.allowselfrevive && !level.var_da5320efd1fd6732 )
        {
            thread exit( "last_stand_self_revive" );
        }
        else
        {
            bleedout();
        }
    }
    
    self notifyonplayercommandremove( "stance_pressed_down", "+movedown" );
    self notifyonplayercommandremove( "stance_pressed_up", "-movedown" );
    self notifyonplayercommandremove( "stance_pressed_down", "+stancedown" );
    self notifyonplayercommandremove( "stance_pressed_up", "-stancedown" );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xaff69967, Offset: 0xa7fb
// Size: 0xc1
function private function_1f2e20f2b5e2849c( isshow )
{
    if ( isshow )
    {
        if ( !isdefined( level.var_c80d33d05cd707c1 ) )
        {
            elem = hud_util::createfontstring( "default", 0.7 );
            elem hud_util::setpoint( "CENTER", "CENTER", 0, 77 );
            elem.label = &"mp/heroes_return";
            elem.archived = 0;
            elem.sort = 10;
            elem.showinkillcam = 0;
            level.var_c80d33d05cd707c1 = elem;
        }
        
        return;
    }
    
    if ( isdefined( level.var_c80d33d05cd707c1 ) )
    {
        level.var_c80d33d05cd707c1 destroy();
        level.var_c80d33d05cd707c1 = undefined;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xf3bd505a, Offset: 0xa8c4
// Size: 0x52
function private showsuicidehintstring()
{
    if ( self.allowselfrevive )
    {
        function_1f2e20f2b5e2849c( 1 );
    }
    
    function_a972f0e70d85b369();
    utility::waittill_any_ents( self, "death_or_disconnect", self, "last_stand_exit", level, "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    function_1f2e20f2b5e2849c( 0 );
}

// Namespace laststand
// Params 0
// Checksum 0xd2fd699e, Offset: 0xa91e
// Size: 0x209
function function_a972f0e70d85b369()
{
    if ( isbrgamemode() || isdmzgamemode() || level.projectbundle.var_bade1c40afa81c92 )
    {
        return;
    }
    
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    
    if ( player::getbeingrevivedinternal() )
    {
        lower_message::setlowermessageomnvar( "being_revived" );
        return;
    }
    
    if ( self.laststandhealisactive )
    {
        lower_message::setlowermessageomnvar( "reviving_self" );
        return;
    }
    
    if ( self.timeuntilbleedout )
    {
        if ( game_utility::getgametype() != "dm" )
        {
            if ( self.pers[ "lives" ] == 0 && game_utility_mp::isteamreviveenabled() )
            {
                lower_message::setlowermessageomnvar( "spawn_revive_wait", int( gettime() + self.timeuntilbleedout * 1000 ) );
            }
            else if ( utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) )
            {
                lower_message::setlowermessageomnvar( "survivor_revive", int( gettime() + self.timeuntilbleedout * 1000 ) );
            }
            else
            {
                lower_message::setlowermessageomnvar( "revive_or_respawn", int( gettime() + self.timeuntilbleedout * 1000 ) );
            }
        }
        else if ( utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) )
        {
            lower_message::setlowermessageomnvar( "survivor_revive", int( gettime() + self.timeuntilbleedout * 1000 ) );
        }
        else
        {
            lower_message::setlowermessageomnvar( "ffa_down_give_up", int( gettime() + self.timeuntilbleedout * 1000 ) );
        }
        
        return;
    }
    
    if ( self.pers[ "lives" ] == 0 && game_utility_mp::isteamreviveenabled() )
    {
        lower_message::setlowermessageomnvar( "spawn_revive_wait_notimer" );
        return;
    }
    
    if ( utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) )
    {
        lower_message::setlowermessageomnvar( "survivor_revive", int( gettime() + self.timeuntilbleedout * 1000 ) );
        return;
    }
    
    lower_message::setlowermessageomnvar( "revive_or_respawn" );
}

// Namespace laststand
// Params 0
// Checksum 0x7a1c1ee1, Offset: 0xab2f
// Size: 0x1f7
function bleedoutthink()
{
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_exit" );
    level endon( #"game_ended" );
    timeleft = self.timeuntilbleedout;
    n_total_bleedout_time = self.timeuntilbleedout;
    var_d19fb06ec006002a = 0;
    totaltimeleft = timeleft;
    var_9b23aeb337ae82f7 = getdvarfloat( @"hash_a7ebc1cac694850e", 5 );
    var_c231190b222941b1 = 0;
    
    if ( timeleft != 0 )
    {
        while ( true )
        {
            waitframe();
            
            if ( self isinexecutionvictim() )
            {
                continue;
            }
            
            if ( self ismeatshieldvictim() )
            {
                continue;
            }
            
            if ( level.var_daa8e6704828e14f )
            {
                continue;
            }
            
            if ( self.var_daa8e6704828e14f )
            {
                continue;
            }
            
            bleedout_speed_scale = self.bleedout_speed_scale ?? 1;
            
            if ( !player::getbeingrevivedinternal() )
            {
                if ( var_d19fb06ec006002a > 0 )
                {
                    timeleft -= var_d19fb06ec006002a;
                    var_d19fb06ec006002a = 0;
                }
                else
                {
                    timeleft -= level.framedurationseconds * bleedout_speed_scale;
                }
            }
            else
            {
                var_d19fb06ec006002a += level.framedurationseconds * bleedout_speed_scale;
            }
            
            params = { #progress:timeleft / n_total_bleedout_time };
            callback::callback( #"hash_34d8a133c38aed30", params );
            self setclientomnvar( "ui_laststand_bleedout_progress", timeleft / totaltimeleft );
            
            if ( self.var_bf82e408b7a0e3c3 || timeleft <= level.framedurationseconds || level.var_bf82e408b7a0e3c3 )
            {
                self.var_bf82e408b7a0e3c3 = undefined;
                
                if ( level.zm_mode_modifiers.var_43c8defc5fca8698 )
                {
                    self.var_3ded14e19d81ef7e = 1;
                }
                
                bleedout();
                break;
            }
            
            if ( !var_c231190b222941b1 && timeleft < var_9b23aeb337ae82f7 )
            {
                level thread battlechatter_mp::trysaylocalsound( self, #"hash_1fd535762a94a767", undefined, undefined, undefined, undefined, undefined, 1 );
                var_c231190b222941b1 = 1;
            }
            
            self.timeuntilbleedout = timeleft;
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xa127fb51, Offset: 0xad2e
// Size: 0x10b
function private addoverheadicon( var_5489eeafe1e4a59f )
{
    showto = self.team;
    image = "hud_realism_head_revive";
    offset = 25;
    drawthroughgeo = 1;
    maxdrawdist = self.var_5629b291aa700093 ? 0 : 1280;
    naturaldist = 250;
    delaytime = undefined;
    var_c6bd58f878e4420a = undefined;
    var_6275850de36415ea = self.var_5629b291aa700093;
    overrideorigin = undefined;
    showonminimap = 0;
    
    if ( var_5489eeafe1e4a59f && utility::issharedfuncdefined( #"super_laststand_syringe", #"hash_c3a450a375ef24ea" ) )
    {
        image = utility::callsharedfunc( #"super_laststand_syringe", #"hash_c3a450a375ef24ea" );
    }
    
    image = entityheadicons::setheadicon_singleimage( showto, image, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, var_6275850de36415ea, overrideorigin, showonminimap );
    thread cleanupoverheadicon( image );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x7e4adcbc, Offset: 0xae41
// Size: 0x26
function private cleanupoverheadicon( image )
{
    utility::waittill_any( "death_or_disconnect", "last_stand_exit" );
    entityheadicons::setheadicon_deleteicon( image );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xcfc14cca, Offset: 0xae6f
// Size: 0x17
function private function_d26c92ad0232d340()
{
    self.statusicon = "hud_status_revive_wh";
    thread function_979244b22cf7018();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xf14f2a89, Offset: 0xae8e
// Size: 0x1d
function private function_14c751583f500b19()
{
    if ( isdefined( self.statusicon ) )
    {
        self.statusicon = "";
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x14ad1e20, Offset: 0xaeb3
// Size: 0x1a
function private function_979244b22cf7018()
{
    utility::waittill_any( "death_or_disconnect", "last_stand_finished" );
    function_14c751583f500b19();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x3bf363bf, Offset: 0xaed5
// Size: 0xa2
function private showwaverespawnmessage()
{
    wavebased = getmatchrulesdata( "commonOption", "waveRespawnDelay" ) > 0;
    
    if ( !wavebased )
    {
        return;
    }
    
    self endon( #"last_stand_exit" );
    
    while ( true )
    {
        self.respawntimerstarttime = gettime();
        wavebased = getmatchrulesdata( "commonOption", "waveRespawnDelay" ) > 0;
        
        if ( wavebased )
        {
            timeuntilspawn = playerlogic::timeuntilwavespawn( 0 );
            lower_message::setlowermessageomnvar( "next_team_spawn", int( gettime() + timeuntilspawn * 1000 ) );
            wait timeuntilspawn;
            lower_message::setlowermessageomnvar( "clear_lower_msg" );
        }
        
        wait 2;
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0x8353ba16, Offset: 0xaf7f
// Size: 0x53
function private laststandmonitor()
{
    level endon( #"game_ended" );
    
    if ( !level.gametypebundle.var_11ae6843139d3a29 )
    {
        return;
    }
    
    while ( true )
    {
        waitframe();
        
        if ( game_utility_mp::getgametypenumlives() == 0 && !level.disablespawning )
        {
            continue;
        }
        
        level thread laststandkillteamifdown();
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xccc37474, Offset: 0xafda
// Size: 0x1c0
function private laststandkillteamifdown()
{
    foreach ( entry in level.teamnamelist )
    {
        playersonteam = teams::getfriendlyplayers( entry, 1 );
        playersinlaststand = [];
        
        foreach ( player in playersonteam )
        {
            if ( player.inlaststand && !player::function_73fe5f51164eb3ca( player ) && !isdefined( player.perks[ "specialty_survivor" ] ) )
            {
                playersinlaststand[ playersinlaststand.size ] = player;
            }
        }
        
        if ( playersinlaststand.size > 0 && playersonteam.size <= playersinlaststand.size )
        {
            level.laststandrequiresmelee = 0;
            
            foreach ( player in playersinlaststand )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player bleedout();
            }
        }
    }
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xabb3ec24, Offset: 0xb1a2
// Size: 0xae
function private getclassiclaststandpistol()
{
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weapon in weaponlist )
    {
        if ( weaponclass( weapon ) == "pistol" )
        {
            return weapon;
        }
    }
    
    weapon = weapon::buildweapon( weapon::getweaponrootname( "iw8_pi_golf21_mp" ), [], "camo_none", "none", -1 );
    return weapon;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x1b6985c9, Offset: 0xb259
// Size: 0x53
function private makelaststandinvuln( duration )
{
    clearlaststandinvuln();
    self endon( #"disconnect" );
    self endon( #"clear_last_stand_invuln" );
    damage_utility::adddamagemodifier( "last_stand_invuln", 0, 0, &laststandinvulnignorefunc );
    utility::waittill_notify_or_timeout( "death", duration );
    thread clearlaststandinvuln();
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xac7044a8, Offset: 0xb2b4
// Size: 0x1b
function private clearlaststandinvuln()
{
    self notify( #"clear_last_stand_invuln" );
    damage_utility::removedamagemodifier( "last_stand_invuln", 0 );
}

// Namespace laststand
// Params 0, eflags: 0x4
// Checksum 0xcbd2179c, Offset: 0xb2d7
// Size: 0x42
function private function_897cee7071d1daa1()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    
    if ( !isbot( self ) )
    {
        utility::callsharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0" );
    }
}

// Namespace laststand
// Params 7, eflags: 0x4
// Checksum 0xbbd82bc8, Offset: 0xb321
// Size: 0x51, Type: bool
function private laststandinvulnignorefunc( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( meansofdeath == "MOD_TRIGGER_HURT" )
    {
        return true;
    }
    
    return false;
}

// Namespace laststand
// Params 0
// Checksum 0x22aebdb3, Offset: 0xb37b
// Size: 0x4
function getdefaultlaststandrevivetimervalue()
{
    return 5;
}

// Namespace laststand
// Params 1
// Checksum 0xc0d6e816, Offset: 0xb388
// Size: 0x12
function getshellshockinterruptdelayms( duration )
{
    return duration * 1000;
}

// Namespace laststand
// Params 2
// Checksum 0x25dd17, Offset: 0xb3a3
// Size: 0x57
function function_858fb821b35c2efa( player, reason )
{
    if ( isdefined( player ) && getdvarint( @"hash_6d80c8821451e612", isbrgamemode() ) )
    {
        logstring( "[lastStandFailureReason] player: " + ( player.name ?? "" ) + ", reason: " + reason );
    }
}

// Namespace laststand
// Params 1
// Checksum 0x6767d10f, Offset: 0xb402
// Size: 0x20
function skipLastStandDuration( seconds )
{
    self.var_c97b46ebf6b163e0 = gettime() + seconds * 1000;
}

// Namespace laststand
// Params 9
// Checksum 0xaa91423c, Offset: 0xb42a
// Size: 0x6c4, Type: bool
function function_902b5a239dd4a73a( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    forcelaststand = damage::isforcedlaststand( self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc );
    
    if ( !forcelaststand )
    {
        if ( isdefined( self.var_c97b46ebf6b163e0 ) )
        {
            var_ae2806bbf61a8216 = gettime() <= self.var_c97b46ebf6b163e0;
            self.var_c97b46ebf6b163e0 = undefined;
            
            if ( var_ae2806bbf61a8216 )
            {
                function_858fb821b35c2efa( self, "skipLastStandDuration" );
                return false;
            }
        }
        
        if ( self.inlaststand || self.playergoingintols )
        {
            function_858fb821b35c2efa( self, "in_last_stand" );
            return false;
        }
        
        if ( swim_cp_mp::function_1e1adfdb14b5e1d1( objweapon ) )
        {
            function_858fb821b35c2efa( self, "drown_weapon" );
            return false;
        }
        
        if ( !isbrgamemode() && !level.var_28e3415171f7169b && utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) && self.var_300ce019f5fb0cb0 )
        {
            return false;
        }
        
        if ( !isbrgamemode() && !game_utility_mp::ismutationgamemode() && !level.var_28e3415171f7169b && smeansofdeath == "MOD_MELEE" && !weapon::isfistweapon( objweapon ) )
        {
            if ( !( player::function_73fe5f51164eb3ca( self ) && player::function_77ae038c7dbd566( "melee" ) ) )
            {
                function_858fb821b35c2efa( self, "melee" );
                return false;
            }
        }
        
        if ( game_utility_mp::ismutationgamemode() && game_utility_mp::ismutationgamemodezombie() )
        {
            return false;
        }
        
        if ( !isbrgamemode() && !level.var_28e3415171f7169b && smeansofdeath == "MOD_FIRE" )
        {
            if ( !( player::function_73fe5f51164eb3ca( self ) && player::function_77ae038c7dbd566( "fire" ) ) )
            {
                function_858fb821b35c2efa( self, "execution" );
                return false;
            }
        }
        
        if ( smeansofdeath == "MOD_EXECUTION" && !level.gametypebundle.var_d3bc9974d6de8fa0 )
        {
            function_858fb821b35c2efa( self, "execution" );
            return false;
        }
        
        if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" && !level.gametypebundle.var_feb018a94b8fd3d1 )
        {
            function_858fb821b35c2efa( self, "melee_takedown" );
            return false;
        }
        
        if ( smeansofdeath == "MOD_MEATSHIELD" )
        {
            function_858fb821b35c2efa( self, "meat_shield" );
            return false;
        }
        
        if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) && !level.var_28e3415171f7169b && !isdefined( self.perks[ "specialty_survivor" ] ) )
        {
            if ( player::function_73fe5f51164eb3ca( self ) && !player::function_77ae038c7dbd566( "headshot" ) )
            {
                function_858fb821b35c2efa( self, "headshot" );
                return false;
            }
            else if ( level.gametypebundle.var_fe1498dd05e2e795 )
            {
                function_858fb821b35c2efa( self, "headshot" );
                return false;
            }
        }
        
        if ( !isbrgamemode() && isexplosivedamagemod( smeansofdeath ) && !level.var_28e3415171f7169b )
        {
            if ( !( player::function_73fe5f51164eb3ca( self ) && player::function_77ae038c7dbd566( "explosive" ) ) && !( game_utility::getgametype() == "xfire" ) )
            {
                function_858fb821b35c2efa( self, "explosive" );
                return false;
            }
        }
        
        if ( self.gulagarena )
        {
            if ( getdvarint( @"hash_8d6a8990465b92fc", 0 ) )
            {
                if ( isdefined( self.name ) )
                {
                    playername = self.name;
                }
                else
                {
                    playername = "";
                }
                
                if ( isdefined( self.gulagarena ) )
                {
                    var_80a3610a0bfa8650 = self.gulagarena;
                }
                else
                {
                    var_80a3610a0bfa8650 = "";
                }
                
                if ( isdefined( self.gulag ) )
                {
                    playergulag = self.gulag;
                }
                else
                {
                    playergulag = "";
                }
                
                stringtoprint = "[gulag_getPlayerStateWait] Player " + playername + " has .gulagArena : " + var_80a3610a0bfa8650 + " and .gulag : " + playergulag;
                logstring( stringtoprint );
            }
            
            function_858fb821b35c2efa( self, "gulag" );
            return false;
        }
        
        if ( isdefined( attacker ) && isdefined( attacker.classname ) && ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" ) )
        {
            if ( !( player::function_73fe5f51164eb3ca( self ) && player::function_77ae038c7dbd566( "world" ) ) && !level.var_e24f88c6a48b65 )
            {
                function_858fb821b35c2efa( self, "world" );
                return false;
            }
        }
        
        if ( attacker == self && !isbrgamemode() && !level.var_28e3415171f7169b )
        {
            function_858fb821b35c2efa( self, "suicide" );
            return false;
        }
        
        if ( isbrgamemode() && killstreak::isjuggernaut() )
        {
            function_858fb821b35c2efa( self, "juggernaut" );
            return false;
        }
        
        if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
        {
            function_858fb821b35c2efa( self, "br_prematch" );
            return false;
        }
        
        if ( isdefined( objweapon ) && getweaponbasename( objweapon ) == "nuke_mp" )
        {
            function_858fb821b35c2efa( self, "nuke" );
            return false;
        }
        
        if ( isdefined( objweapon ) && getweaponbasename( objweapon ) == "dna_nuke_mp" )
        {
            function_858fb821b35c2efa( self, "dna_nuke" );
            return false;
        }
        
        if ( isdefined( level.modelaststandallowed ) && !self [[ level.modelaststandallowed ]]( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration ) )
        {
            function_858fb821b35c2efa( self, "mode_allow" );
            return false;
        }
        
        if ( level.disablelaststand || self.disablelaststand )
        {
            return false;
        }
        
        var_9bece9424256f6dd = ( utility::callsharedfunc( #"specialty_survivor", #"hasselfrevive" ) || isdefined( self.perks[ "specialty_pistoldeath" ] ) ) && !self.var_300ce019f5fb0cb0 || game_utility_mp::islaststandenabled() || self.var_5629b291aa700093 && !self.rallypointrevived;
        
        if ( !isbrgamemode() && !level.var_28e3415171f7169b && !var_9bece9424256f6dd )
        {
            function_858fb821b35c2efa( self, "available" );
            return false;
        }
        
        if ( level.laststand == 2 && !var_9bece9424256f6dd )
        {
            function_858fb821b35c2efa( self, "laststand_2_available" );
            return false;
        }
        
        if ( attacker.smartguntargets.size && attacker.smartguntargets[ self.entnum ?? utility::get_entity_number( self ) ] )
        {
            return false;
        }
        
        /#
            if ( self.var_989cbec7b65bfb44 )
            {
                function_858fb821b35c2efa( self, "<dev string:xaa>" );
                return false;
            }
        #/
    }
    
    return true;
}

// Namespace laststand
// Params 1
// Checksum 0x32fd9c4, Offset: 0xbaf7
// Size: 0x6d
function function_337aa8851af4f236( revivee )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_45962d8f5a7ce2d6 ) )
    {
        self.var_45962d8f5a7ce2d6 = [];
    }
    
    self.var_45962d8f5a7ce2d6 = arraycombineunique( self.var_45962d8f5a7ce2d6, [ revivee ] );
    
    if ( self.var_45962d8f5a7ce2d6.size > 0 )
    {
        revivee.reviver = self;
        self.revivingteammate = 1;
    }
}

// Namespace laststand
// Params 1
// Checksum 0xa7e230d, Offset: 0xbb6c
// Size: 0x57
function function_cced0113fddd8e8d( revivee )
{
    if ( !isdefined( self.var_45962d8f5a7ce2d6 ) )
    {
        return;
    }
    
    self.var_45962d8f5a7ce2d6 = arrayremove( self.var_45962d8f5a7ce2d6, revivee );
    
    if ( self.var_45962d8f5a7ce2d6.size <= 0 )
    {
        self.revivingteammate = 0;
        revivee.reviver = undefined;
    }
}

// Namespace laststand
// Params 0
// Checksum 0x60d1e169, Offset: 0xbbcb
// Size: 0x20
function function_a21869b9fae62ee()
{
    if ( !isdefined( self.var_45962d8f5a7ce2d6 ) )
    {
        return;
    }
    
    return utility::array_get_first_item( self.var_45962d8f5a7ce2d6 );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xc08db7a8, Offset: 0xbbf4
// Size: 0x3a
function private survivorondeath( attacker )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    callback::callback( #"hash_71281d183072c5e8", { #attacker:attacker, #victim:self } );
}

// Namespace laststand
// Params 1
// Checksum 0xee45d92d, Offset: 0xbc36
// Size: 0x8f
function laststand_isreviveweapon( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return 0;
    }
    
    if ( weapobj.basename == level.var_99884af80074e803 )
    {
        return 1;
    }
    
    currentweapon = 0;
    
    switch ( weapobj.basenamehash )
    {
        case %"iw8_ges_plyr_self_revive_stim_pistol":
        case %"iw8_ges_plyr_self_revive":
        case %"t10_ges_offhand_1h_stim_self_revive":
            currentweapon = 1;
            break;
    }
    
    return currentweapon;
}

// Namespace laststand
// Params 0
// Checksum 0xb8711ad3, Offset: 0xbcce
// Size: 0x9a
function function_4d99c68b969d3ec0()
{
    if ( !isdefined( self.var_cbe52f440b3c911c ) )
    {
        self.var_cbe52f440b3c911c = 1;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_4736d3b0046a7e4f( player );
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x249bc3af, Offset: 0xbd70
// Size: 0x1d0
function private function_4736d3b0046a7e4f( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_e45a398cbab92003 = self.headiconon;
    
    if ( !isdefined( var_e45a398cbab92003 ) )
    {
        return;
    }
    
    var_a3e2862dd217c28c = self.headiconoff;
    
    if ( !isdefined( var_a3e2862dd217c28c ) )
    {
        return;
    }
    
    isteammate = player_utility::isfriendly( self.owner.team, player );
    var_e2e2ecaf1911e119 = getdvarint( @"hash_d0cbc658324b1dae", 0 ) != 0;
    
    if ( isdefined( self.owner.laststandattacker ) && !var_e2e2ecaf1911e119 )
    {
        var_e2e2ecaf1911e119 = player_utility::isfriendly( self.owner.laststandattacker.team, player );
    }
    else
    {
        var_e2e2ecaf1911e119 = 1;
    }
    
    if ( isteammate || !var_e2e2ecaf1911e119 )
    {
        entityheadicons::setheadicon_removeclientfrommask( var_e45a398cbab92003, player );
        entityheadicons::setheadicon_removeclientfrommask( var_a3e2862dd217c28c, player );
        return;
    }
    
    if ( !isdefined( self.var_cbe52f440b3c911c ) )
    {
        return;
    }
    
    switch ( self.var_cbe52f440b3c911c )
    {
        case 1:
            entityheadicons::setheadicon_addclienttomask( var_e45a398cbab92003, player );
            entityheadicons::setheadicon_removeclientfrommask( var_a3e2862dd217c28c, player );
            setheadicondrawthroughgeo( var_e45a398cbab92003, 0 );
            break;
        case 2:
            entityheadicons::setheadicon_removeclientfrommask( var_e45a398cbab92003, player );
            entityheadicons::setheadicon_addclienttomask( var_a3e2862dd217c28c, player );
            setheadicondrawthroughgeo( var_e45a398cbab92003, 0 );
            break;
        case 4:
            entityheadicons::setheadicon_addclienttomask( var_e45a398cbab92003, player );
            entityheadicons::setheadicon_removeclientfrommask( var_a3e2862dd217c28c, player );
            setheadicondrawthroughgeo( var_e45a398cbab92003, 1 );
            break;
        case 3:
        default:
            entityheadicons::setheadicon_removeclientfrommask( var_e45a398cbab92003, player );
            entityheadicons::setheadicon_removeclientfrommask( var_a3e2862dd217c28c, player );
            break;
    }
}

// Namespace laststand
// Params 1
// Checksum 0x145ba203, Offset: 0xbf48
// Size: 0xdd
function function_cef3b2d070289d07( attacker )
{
    self endon( #"entitydeleted" );
    self notify( #"hash_7f5db7c729bbf894" );
    self endon( #"hash_7f5db7c729bbf894" );
    cancelrange = level.gametypebundle.var_914d072e1a9c4702 ?? 185;
    self.trigger = spawn( "trigger_radius", self.origin, 0, cancelrange, cancelrange );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", var_1b3b8bdbca74e9c4 );
        
        if ( var_1b3b8bdbca74e9c4.classname == "script_vehicle" )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( var_1b3b8bdbca74e9c4 );
            
            if ( isdefined( occupants ) && occupants.size > 0 )
            {
                attacker.var_3ded14e19d81ef7e = 1;
            }
        }
    }
}

// Namespace laststand
// Params 1
// Checksum 0x18f7783c, Offset: 0xc02d
// Size: 0x41
function setplayerbeingrevivedextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 512;
        return;
    }
    
    self.game_extrainfo &= ~512;
}

// Namespace laststand
// Params 1
// Checksum 0x647b70ec, Offset: 0xc076
// Size: 0x41
function setplayerselfrevivingextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 1024;
        return;
    }
    
    self.game_extrainfo &= ~1024;
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xc2586b3, Offset: 0xc0bf
// Size: 0x57
function private setplayerdownedextrainfo( value )
{
    function_c26a7c4bf9ba9d98( self, "Downed icon set to " + value + " in laststand.gsc" );
    
    if ( value )
    {
        self.game_extrainfo |= 256;
        return;
    }
    
    self.game_extrainfo &= ~256;
}

// Namespace laststand
// Params 4
// Checksum 0x778f62e7, Offset: 0xc11e
// Size: 0x216
function updatesquadmemberlaststandreviveprogress( revivee, reviver, progress, var_37bc0bdc16c2e345 )
{
    assert( isdefined( revivee ) && isdefined( reviver ) );
    
    if ( squad_utility::shouldmodesetsquads() )
    {
        if ( !isdefined( level.var_4778934b0be4e0e5 ) )
        {
            level.var_4778934b0be4e0e5 = [];
        }
        
        var_56be85e59b1f5f55 = utility::get_int_or_0( level.var_4778934b0be4e0e5[ revivee.team ] );
        
        if ( !isalive( revivee ) )
        {
            var_37bc0bdc16c2e345 = 1;
            progress = 0;
        }
        
        isselfrevive = revivee == reviver;
        squadmemberindex = revivee.sessionuimemberindex;
        var_1b7451124b8b39da = int( ceil( clamp( progress, 0, 1 ) * 127 ) );
        progresspayload = var_1b7451124b8b39da;
        
        if ( var_37bc0bdc16c2e345 )
        {
            revivee setplayerselfrevivingextrainfo( 0 );
        }
        else if ( isselfrevive )
        {
            revivee setplayerselfrevivingextrainfo( 1 );
        }
        
        if ( squadmemberindex == -1 )
        {
            return;
        }
        
        bitoffset = squadmemberindex * 8;
        shiftedpayload = ( progresspayload & 255 ) << bitoffset;
        invertedmask = ~( 255 << bitoffset );
        cleanedbase = var_56be85e59b1f5f55 & invertedmask;
        statuspayload = cleanedbase + shiftedpayload;
        level.var_4778934b0be4e0e5[ revivee.team ] = statuspayload;
        teammates = teams::function_d032b36d01bbbab3( revivee.team, revivee.sessionsquadid );
        
        if ( isdefined( teammates ) && teammates.size > 0 )
        {
            foreach ( teammate in teammates )
            {
                teammate setclientomnvar( "ui_br_squad_revive_status", statuspayload );
            }
        }
    }
}

/#

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0x9ff1a38e, Offset: 0xc33c
    // Size: 0x10a, Type: dev
    function private function_5b34ed9b51832b79()
    {
        uselookat = getdvarint( @"hash_59092ebf13c1420b", 0 );
        
        if ( uselookat == 0 )
        {
            return -1;
        }
        
        hostplayerentnum = int( getdvar( @"hash_13d8008e8edc58d5" ) );
        
        if ( hostplayerentnum == -1 )
        {
            return -1;
        }
        
        player = utility::function_3bc2c606a1c39e2f( hostplayerentnum );
        startpos = player geteye();
        viewangles = player getplayerangles();
        fwd = anglestoforward( viewangles );
        endpos = startpos + fwd * 10000;
        playercontent = [ "<dev string:xb3>" ];
        var_e1c801cb433b89d0 = physics_createcontents( playercontent );
        playertrace = trace::sphere_trace( startpos, endpos, 5, player, var_e1c801cb433b89d0, 0 );
        traceent = playertrace[ "<dev string:xd2>" ];
        
        if ( isplayer( traceent ) )
        {
            return traceent getentitynumber();
        }
        
        return -1;
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0xb6983ea4, Offset: 0xc44e
    // Size: 0x56, Type: dev
    function private function_be4ec480ce2acc32()
    {
        laststandentity = function_5b34ed9b51832b79();
        
        if ( laststandentity != -1 )
        {
            return laststandentity;
        }
        
        var_f0584ba3e8b9f59d = getdvarint( @"hash_6a128609f81058c2", -1 );
        
        if ( var_f0584ba3e8b9f59d != -1 )
        {
            return var_f0584ba3e8b9f59d;
        }
        
        return getdvarint( @"hash_13d8008e8edc58d5", -1 );
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0xd81faff, Offset: 0xc4ac
    // Size: 0x1fc, Type: dev
    function private function_eb11297dab3c50b8()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_9564fda23c9d6dbd", 0 );
        setdevdvarifuninitialized( @"hash_6a128609f81058c2", -1 );
        setdevdvarifuninitialized( @"hash_59092ebf13c1420b", 0 );
        setdevdvarifuninitialized( @"hash_a28e203d53e8292d", 0 );
        
        while ( true )
        {
            autolaststand = getdvarint( @"hash_9564fda23c9d6dbd", 0 );
            autorevive = getdvarint( @"hash_a28e203d53e8292d", 0 );
            
            if ( !autolaststand && !autorevive )
            {
                waitframe();
                continue;
            }
            
            laststandentity = function_be4ec480ce2acc32();
            
            if ( laststandentity != -1 )
            {
                player = utility::function_3bc2c606a1c39e2f( laststandentity );
                
                if ( isdefined( player ) )
                {
                    if ( player player::isreallyalive() )
                    {
                        if ( !player.inlaststand )
                        {
                            if ( autolaststand )
                            {
                                player forcelaststand();
                            }
                        }
                        else if ( autorevive )
                        {
                            player exit( "<dev string:xd9>" );
                        }
                    }
                }
            }
            else
            {
                foreach ( player in level.players )
                {
                    if ( !player player::isreallyalive() )
                    {
                        continue;
                    }
                    
                    if ( isagent( player ) )
                    {
                        continue;
                    }
                    
                    if ( isbot( player ) )
                    {
                        continue;
                    }
                    
                    if ( !player.inlaststand )
                    {
                        if ( autolaststand )
                        {
                            player forcelaststand();
                        }
                        
                        continue;
                    }
                    
                    if ( autorevive )
                    {
                        player exit( "<dev string:xd9>" );
                    }
                }
            }
            
            setdvar( @"hash_9564fda23c9d6dbd", 0 );
            setdvar( @"hash_a28e203d53e8292d", 0 );
            setdvar( @"hash_13d8008e8edc58d5", "<dev string:xf0>" );
            waitframe();
        }
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0xf10ef8f0, Offset: 0xc6b0
    // Size: 0x47, Type: dev
    function private forcelaststand()
    {
        if ( !isdefined( self.perks[ "<dev string:xf3>" ] ) )
        {
            perk::giveperk( "<dev string:xf3>" );
        }
        
        self dodamage( self.maxhealth * 2, self.origin, self, undefined, "<dev string:x109>" );
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0xcf97718a, Offset: 0xc6ff
    // Size: 0x446, Type: dev
    function private function_cd6ad26967e91ea3()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"scr_secondwind_test", 0 );
        
        while ( true )
        {
            testval = getdvarint( @"scr_secondwind_test", 0 );
            
            if ( !testval )
            {
                wait 0.5;
                continue;
            }
            
            setdvar( @"scr_secondwind_test", 0 );
            eplayer = level.players[ 0 ];
            var_bac0ba390669f6f2 = level.players[ 1 ];
            var_eb04aa539c0c2206 = level.players[ 2 ];
            assert( isplayer( eplayer ) );
            
            switch ( testval )
            {
                case 1:
                    if ( !isdefined( var_bac0ba390669f6f2 ) )
                    {
                        iprintlnbold( "<dev string:x11a>" );
                        break;
                    }
                    
                    pistolobj = eplayer player::function_bb5faf1c22bd8139();
                    
                    if ( !isdefined( pistolobj ) )
                    {
                        iprintlnbold( "<dev string:x127>" );
                        break;
                    }
                    
                    eplayer dodamage( eplayer.health + 200, var_bac0ba390669f6f2.origin, var_bac0ba390669f6f2, var_bac0ba390669f6f2, "<dev string:x13e>", var_bac0ba390669f6f2.primaryweaponobj, "<dev string:x14f>" );
                    var_bac0ba390669f6f2 hudoutlineenable( "<dev string:x15b>" );
                    iprintlnbold( "<dev string:x16f>" );
                    break;
                case 2:
                    if ( !( isdefined( var_bac0ba390669f6f2 ) && isdefined( var_eb04aa539c0c2206 ) ) )
                    {
                        iprintlnbold( "<dev string:x179>" );
                        break;
                    }
                    
                    pistolobj = eplayer player::function_bb5faf1c22bd8139();
                    
                    if ( !isdefined( pistolobj ) )
                    {
                        iprintlnbold( "<dev string:x127>" );
                        break;
                    }
                    
                    eplayer dodamage( eplayer.health + 200, var_bac0ba390669f6f2.origin, var_bac0ba390669f6f2, var_bac0ba390669f6f2, "<dev string:x13e>", var_bac0ba390669f6f2.primaryweaponobj, "<dev string:x14f>" );
                    wait 1;
                    var_bac0ba390669f6f2 dodamage( var_bac0ba390669f6f2.health + 200, var_eb04aa539c0c2206.origin, var_eb04aa539c0c2206, var_eb04aa539c0c2206, "<dev string:x13e>", var_eb04aa539c0c2206.primaryweaponobj, "<dev string:x14f>" );
                    var_bac0ba390669f6f2 hudoutlineenable( "<dev string:x15b>" );
                    iprintlnbold( "<dev string:x16f>" );
                    break;
                case 3:
                    if ( !( isdefined( var_bac0ba390669f6f2 ) && isdefined( var_eb04aa539c0c2206 ) ) )
                    {
                        iprintlnbold( "<dev string:x179>" );
                        break;
                    }
                    
                    var_bac0ba390669f6f2 dodamage( var_bac0ba390669f6f2.health + 200, eplayer.origin, eplayer, eplayer, "<dev string:x13e>", eplayer.primaryweaponobj, "<dev string:x14f>" );
                    wait 1;
                    eplayer dodamage( eplayer.health + 200, var_eb04aa539c0c2206.origin, var_eb04aa539c0c2206, var_eb04aa539c0c2206, "<dev string:x13e>", var_eb04aa539c0c2206.primaryweaponobj, "<dev string:x14f>" );
                    iprintlnbold( "<dev string:x190>" );
                    break;
                case 4:
                    if ( !( isdefined( var_bac0ba390669f6f2 ) && isdefined( var_eb04aa539c0c2206 ) ) )
                    {
                        iprintlnbold( "<dev string:x179>" );
                        break;
                    }
                    
                    pistolobj = eplayer player::function_bb5faf1c22bd8139();
                    
                    if ( !isdefined( pistolobj ) )
                    {
                        iprintlnbold( "<dev string:x127>" );
                        break;
                    }
                    
                    eplayer dodamage( eplayer.health + 200, var_bac0ba390669f6f2.origin, var_bac0ba390669f6f2, var_bac0ba390669f6f2, "<dev string:x13e>", var_bac0ba390669f6f2.primaryweaponobj, "<dev string:x14f>" );
                    var_bac0ba390669f6f2 hudoutlineenable( "<dev string:x15b>" );
                    iprintlnbold( "<dev string:x16f>" );
                    var_bac0ba390669f6f2 waittill( #"last_stand_enter" );
                    wait 1;
                    var_bac0ba390669f6f2 dodamage( var_bac0ba390669f6f2.health + 200, var_eb04aa539c0c2206.origin, var_eb04aa539c0c2206, var_eb04aa539c0c2206, "<dev string:x13e>", var_eb04aa539c0c2206.primaryweaponobj, "<dev string:x14f>" );
                    break;
                case 5:
                    if ( !( isdefined( var_bac0ba390669f6f2 ) && isdefined( var_eb04aa539c0c2206 ) ) )
                    {
                        iprintlnbold( "<dev string:x179>" );
                        break;
                    }
                    
                    var_eb04aa539c0c2206 dodamage( var_eb04aa539c0c2206.health + 200, var_bac0ba390669f6f2.origin, var_bac0ba390669f6f2, var_bac0ba390669f6f2, "<dev string:x13e>", var_bac0ba390669f6f2.primaryweaponobj, "<dev string:x14f>" );
                    var_bac0ba390669f6f2 hudoutlineenable( "<dev string:x15b>" );
                    iprintlnbold( "<dev string:x16f>" );
                    var_bac0ba390669f6f2 waittill( #"last_stand_enter" );
                    var_bac0ba390669f6f2 hudoutlinedisable();
                    wait 1;
                    bleedout();
                    break;
            }
        }
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0x47b90f75, Offset: 0xcb4d
    // Size: 0x6ae, Type: dev
    function private function_28aaad601277e9e3()
    {
        while ( true )
        {
            host = undefined;
            
            if ( getdvarint( @"hash_d475fd19488b5a6d", 0 ) == 1 )
            {
                wait 1;
                
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        host = player;
                        break;
                    }
                }
                
                if ( player::isinlaststand( host ) || host.liveragdoll )
                {
                    foreach ( player in level.players )
                    {
                        if ( player.team == host.team && isbot( player ) && isalive( player ) )
                        {
                            player setorigin( host.origin + ( 0, 0, 18 ) );
                            host.reviver = player;
                            wait 0.5;
                            break;
                        }
                    }
                    
                    if ( isdefined( host.reviver ) )
                    {
                        presstime = level.laststandrevivetimer + 1;
                        host.reviver botpressbutton( "<dev string:x1ad>", presstime );
                        wait presstime + 0.5;
                        
                        if ( player::isinlaststand( host ) || host.liveragdoll )
                        {
                            host.reviver botpressbutton( "<dev string:x1ad>", presstime );
                        }
                    }
                }
                else
                {
                    iprintlnbold( "<dev string:x1b1>" );
                }
                
                setdevdvar( @"hash_d475fd19488b5a6d", 0 );
            }
            else if ( getdvarint( @"hash_b5de345e9da778b5", 0 ) == 1 )
            {
                wait 1;
                
                while ( true )
                {
                    victim = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( player::isinlaststand( player ) )
                        {
                            victim = player;
                            break;
                        }
                    }
                    
                    if ( !isdefined( victim ) )
                    {
                        iprintlnbold( "<dev string:x21d>" );
                        break;
                    }
                    
                    foreach ( player in level.players )
                    {
                        if ( isbot( player ) && isalive( player ) && player.team == victim.team )
                        {
                            player setorigin( victim.origin + ( 0, 0, 18 ) );
                            victim.reviver = player;
                            wait 0.5;
                            break;
                        }
                    }
                    
                    if ( isdefined( victim.reviver ) )
                    {
                        presstime = level.laststandrevivetimer + 1;
                        victim.reviver botpressbutton( "<dev string:x1ad>", presstime );
                        wait presstime + 0.5;
                        
                        if ( player::isinlaststand( victim ) )
                        {
                            victim.reviver botpressbutton( "<dev string:x1ad>", presstime );
                        }
                        
                        break;
                    }
                    
                    setdevdvar( @"hash_b5de345e9da778b5", 0 );
                }
            }
            else if ( getdvarint( @"hash_d475fd19488b5a6d", 0 ) == 2 )
            {
                foreach ( player in level.players )
                {
                    if ( player ishost() && player::isinlaststand( player ) )
                    {
                        player thread exit( "<dev string:xd9>" );
                        break;
                    }
                }
                
                setdevdvar( @"hash_d475fd19488b5a6d", 0 );
            }
            else if ( getdvarint( @"hash_d475fd19488b5a6d", 0 ) == 3 )
            {
                wait 1;
                
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        host = player;
                        break;
                    }
                }
                
                foreach ( player in level.players )
                {
                    if ( player.team == host.team && isbot( player ) && isalive( player ) )
                    {
                        player setorigin( host.origin + ( 0, 0, 18 ) );
                        host.reviver = player;
                        wait 0.5;
                        break;
                    }
                }
                
                if ( isdefined( host.reviver ) )
                {
                    host function_715e8b27564eeece( 0 );
                    host stopliveragdoll();
                    
                    if ( isdefined( host.var_306b244cebdf23e6 ) )
                    {
                        host.var_306b244cebdf23e6 setdevtext( "<dev string:x24f>" );
                        host.var_306b244cebdf23e6.color = ( 1, 1, 1 );
                    }
                    else
                    {
                        host iprintlnbold( "<dev string:x24f>" );
                    }
                }
                
                setdevdvar( @"hash_d475fd19488b5a6d", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0x570b5f3d, Offset: 0xd203
    // Size: 0x36e, Type: dev
    function private function_890862c8bafd8718()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_eb12fbdb604176fb", 0 ) != 0 )
            {
                setdvar( @"hash_eb12fbdb604176fb", 0 );
                localplayer = level.players[ 0 ];
                
                foreach ( bot in level.players )
                {
                    if ( bot != localplayer && isbot( bot ) && localplayer.team == bot.team )
                    {
                        function_625edf05d21d1ab9( bot, localplayer );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"hash_12b095ece3375ee2", 0 ) != 0 )
            {
                setdvar( @"hash_12b095ece3375ee2", 0 );
                localplayer = level.players[ 0 ];
                
                if ( !player::isinlaststand( localplayer ) )
                {
                    foreach ( bot in level.players )
                    {
                        if ( player::isinlaststand( bot ) )
                        {
                            localplayer = bot;
                            break;
                        }
                    }
                }
                
                foreach ( bot in level.players )
                {
                    if ( bot != localplayer && isbot( bot ) && localplayer.team != bot.team )
                    {
                        function_625edf05d21d1ab9( bot, localplayer );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"hash_b81bebd8a028bd0a", 0 ) != 0 )
            {
                setdvar( @"hash_b81bebd8a028bd0a", 0 );
                localplayer = level.players[ 0 ];
                
                foreach ( bot in level.players )
                {
                    if ( bot != localplayer && isbot( bot ) && player::isaliveandnotinlaststand( bot ) && bot.team == localplayer.team )
                    {
                        if ( !bot.hasselfrevivetoken )
                        {
                            bot namespace_9d8e359c3b1041e5::addrespawntokensharedfunc();
                        }
                        
                        bot forcelaststand();
                        wait 1;
                        bot.var_d58dcecf776f41ff = 1;
                        bot utility::waittill_any_timeout( 10, "<dev string:x273>" );
                        bot.var_d58dcecf776f41ff = undefined;
                        break;
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace laststand
    // Params 3, eflags: 0x4
    // Checksum 0x2bf8a1e7, Offset: 0xd579
    // Size: 0xab, Type: dev
    function private function_625edf05d21d1ab9( bot, downedplayer, directionvector )
    {
        assert( isdefined( bot ) );
        assert( isdefined( downedplayer ) );
        
        if ( !player::isinlaststand( downedplayer ) )
        {
            return;
        }
        
        if ( !isdefined( directionvector ) )
        {
            directionvector = ( 1, 0, 0 );
        }
        
        var_a9af1f4803673565 = downedplayer.origin + vectornormalize2( directionvector ) * 50;
        bot setorigin( var_a9af1f4803673565, 1 );
        bot bots_util_mp::function_cdc8a7497ee4f596( downedplayer.origin );
        wait 0.5;
        bot botpressbutton( "<dev string:x1ad>", 8 );
    }

    // Namespace laststand
    // Params 1, eflags: 0x4
    // Checksum 0x5666bae5, Offset: 0xd62c
    // Size: 0x13b, Type: dev
    function private function_3c0e58d5c6da29d7( params )
    {
        if ( level.laststand )
        {
            self endon( #"death" );
            var_cb94c21bfbbeb6f = 16;
            
            if ( level.laststand && !self.var_18fc04db96df577e )
            {
                if ( !isdefined( level.var_187783ff070d52c9 ) )
                {
                    level.var_187783ff070d52c9 = 0;
                }
                
                if ( level.var_187783ff070d52c9 < var_cb94c21bfbbeb6f )
                {
                    self.var_18fc04db96df577e = 1;
                    str_player_name = self.name;
                    devgui::function_9082edeb5db93280( "<dev string:x286>" );
                    devgui::function_cd4e263c1f3018ae( str_player_name, "<dev string:x29c>" + str_player_name + "<dev string:x2a9>" + self getentitynumber(), &function_c14202a5cdad535f );
                    devgui::function_77df7fe7dd273e10();
                    devgui::function_9082edeb5db93280( "<dev string:x2ab>" );
                    devgui::function_cd4e263c1f3018ae( str_player_name, "<dev string:x2c3>" + str_player_name + "<dev string:x2a9>" + self getentitynumber(), &devgui_revive_player );
                    devgui::function_77df7fe7dd273e10();
                    devgui::function_9082edeb5db93280( "<dev string:x2d2>" );
                    devgui::function_cd4e263c1f3018ae( str_player_name, "<dev string:x2f4>" + str_player_name + "<dev string:x2a9>" + self getentitynumber(), &function_1c3b24c5be40760f );
                    devgui::function_77df7fe7dd273e10();
                    level.var_187783ff070d52c9++;
                }
            }
        }
    }

    // Namespace laststand
    // Params 0, eflags: 0x4
    // Checksum 0x95a8a1d4, Offset: 0xd76f
    // Size: 0x42, Type: dev
    function private setup_laststand_devgui()
    {
        if ( level.laststand )
        {
            wait 0.5;
            devgui::function_9082edeb5db93280( "<dev string:x30d>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x31e>", "<dev string:x334>", &debug_laststand, 1 );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace laststand
    // Params 1, eflags: 0x4
    // Checksum 0xe35d1f0, Offset: 0xd7b9
    // Size: 0x1a8, Type: dev
    function private debug_laststand( params )
    {
        var_36da1c526f24a2 = 5;
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player.laststandreviveent ) )
                {
                    print3d( player.laststandreviveent.origin, "<dev string:x34a>", ( 1, 1, 1 ), 1, 0.25 );
                    print3d( player.laststandreviveent.origin - ( 0, 0, var_36da1c526f24a2 ), "<dev string:x35a>" + ( player.laststandreviveent.curprogress ?? 0 ) / 1000 + "<dev string:x365>" + ( player.laststandreviveent.usetime ?? 0 ) / 1000 + "<dev string:x367>", ( 1, 1, 1 ), 1, 0.25 );
                    print3d( player.laststandreviveent.origin - ( 0, 0, var_36da1c526f24a2 * 2 ), "<dev string:x370>" + ( player.timeuntilbleedout ?? get_last_stand_timer() ), ( 1, 1, 1 ), 1, 0.25 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x2cecef44, Offset: 0xd969
// Size: 0x10c
function private function_c14202a5cdad535f( params )
{
    str_player_name = params[ 0 ];
    n_ent_num = params[ 1 ];
    
    if ( isdefined( n_ent_num ) )
    {
        n_ent_num = int( n_ent_num );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( str_player_name ) && player.name == str_player_name || player getentitynumber() == n_ent_num )
        {
            if ( player::isinlaststand( player ) )
            {
                player.var_bf82e408b7a0e3c3 = 1;
            }
            else
            {
                player dodamage( player.health + 666, player.origin, player );
            }
            
            break;
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xd4499be2, Offset: 0xda7d
// Size: 0x379
function private devgui_revive_player( params )
{
    str_player_name = params[ 0 ];
    
    if ( str_player_name == "player:me" )
    {
        str_player_name = getdvar( @"cheat_player" );
        setdvar( @"cheat_player", "" );
    }
    
    n_ent_num = isdefined( params[ 1 ] ) ? int( params[ 1 ] ) : -1;
    var_ba4ff82a8b4ce781 = params[ 2 ];
    
    foreach ( player in level.players )
    {
        if ( isdefined( str_player_name ) && player.name == str_player_name || n_ent_num != -1 && player getentitynumber() == n_ent_num )
        {
            reviver = undefined;
            
            foreach ( other_player in level.players )
            {
                if ( isalive( other_player ) && player != other_player && player.team == other_player.team )
                {
                    reviver = other_player;
                    break;
                }
            }
            
            if ( !isdefined( reviver ) )
            {
                reviver = player;
            }
            
            if ( player::isinlaststand( player ) )
            {
                if ( var_ba4ff82a8b4ce781 )
                {
                    player thread exit( "last_stand_self_revive" );
                }
                else if ( isdefined( player.laststandreviveent ) )
                {
                    reviver.b_force_gameobject_use = 1;
                    
                    if ( reviver == player )
                    {
                        reviver.var_847214b1ff739bfc = 1;
                    }
                    
                    player.var_85e846fdb8674638 = 1;
                    player.laststandreviveent notify( #"trigger", reviver );
                    player utility::waittill_any_return_no_endon_death( "death_or_disconnect", "last_stand_exit" );
                    reviver.b_force_gameobject_use = undefined;
                    reviver.var_847214b1ff739bfc = undefined;
                }
            }
            else if ( isdefined( player.var_9219230342b14e47 ) )
            {
                player.var_9219230342b14e47 notify( #"trigger", player );
            }
            else if ( isdefined( level.revivetriggers ) && isdefined( level.revivetriggers[ player.guid ] ) )
            {
                if ( var_ba4ff82a8b4ce781 )
                {
                    can_revive_player = player.team ? player squad_utility::getsquadmembers( player.team, 1 ).size > 0 : 0;
                    
                    if ( can_revive_player )
                    {
                        player teamrevive::respawn();
                    }
                }
                else
                {
                    icon = level.revivetriggers[ player.guid ];
                    icon.reviver = reviver;
                    reviver.b_force_gameobject_use = 1;
                    level teamrevive::function_6036ecefbef406f8( icon, "cyber_revive_icon", "usable", reviver, 1, "cyber_revive_icon" );
                    icon waittill( #"finished_use" );
                    reviver.b_force_gameobject_use = undefined;
                }
            }
            
            break;
        }
    }
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0xd4b93839, Offset: 0xddfe
// Size: 0xe1
function private function_1c3b24c5be40760f( params )
{
    str_player_name = params[ 0 ];
    n_ent_num = params[ 1 ];
    
    if ( isdefined( n_ent_num ) )
    {
        n_ent_num = int( n_ent_num );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( str_player_name ) && player.name == str_player_name || player getentitynumber() == n_ent_num )
        {
            if ( player function_ed4da7e5751eed47() )
            {
                player function_a2e03a85015b1897();
            }
            
            break;
        }
    }
}

// Namespace laststand
// Params 0
// Checksum 0xe4b7afa6, Offset: 0xdee7
// Size: 0x24, Type: bool
function hasselfrevivetoken()
{
    player = self;
    
    if ( common_item::items_isenabled() )
    {
        return ( player function_7072b516e6cffb7c() > 0 );
    }
    
    return false;
}

// Namespace laststand
// Params 1
// Checksum 0x8f516f9d, Offset: 0xdf14
// Size: 0x41
function sethasselfrevivetokenextrainfo( value )
{
    if ( value )
    {
        self.game_extrainfo |= 2048;
        return;
    }
    
    self.game_extrainfo &= ~2048;
}

// Namespace laststand
// Params 2
// Checksum 0xcf399405, Offset: 0xdf5d
// Size: 0x12b
function function_75e6bc3d39e1f2bb( reviver, str_exit_reason )
{
    self notify( #"hash_87cb633ab3fb7586" );
    self endon( #"hash_87cb633ab3fb7586" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !player::isinlaststand( self ) )
    {
        return;
    }
    
    self.var_5a6f47ef38f87fcd = 1;
    n_timeout = 8;
    
    while ( player::isinlaststand( self ) && !self.var_cc09887c7db65ab5 )
    {
        if ( n_timeout <= 0 )
        {
            break;
        }
        
        waitframe();
        n_timeout -= level.framedurationseconds;
    }
    
    if ( self.beingrevived )
    {
        player::setbeingrevivedinternal( 0 );
        originalreviver = reviver;
        
        if ( !isdefined( reviver ) )
        {
            reviver = self;
        }
        
        if ( isdefined( self.reviver ) )
        {
            reviver = self.reviver;
        }
        
        exit( str_exit_reason, originalreviver );
    }
    else
    {
        exit( str_exit_reason, reviver );
    }
    
    if ( level.var_894cf9c132c87505 )
    {
        setplayerbeingrevivedextrainfo( 0 );
    }
    
    setstateomnvar( 0 );
    setprogressomnvar( 0 );
    self.health = self.maxhealth;
}

// Namespace laststand
// Params 0
// Checksum 0xc0437496, Offset: 0xe090
// Size: 0x15
function function_32c932b93ae81fa2()
{
    return level.gametypebundle.var_2b3257587fa3130f;
}

// Namespace laststand
// Params 1
// Checksum 0x63bfbe4d, Offset: 0xe0ae
// Size: 0x37
function setstateomnvar( state )
{
    omnvarname = function_32c932b93ae81fa2() ? "ui_reviving" : "ui_securing";
    self setclientomnvar( omnvarname, state );
}

// Namespace laststand
// Params 1
// Checksum 0x89f212e7, Offset: 0xe0ed
// Size: 0x37
function setprogressomnvar( value )
{
    omnvarname = function_32c932b93ae81fa2() ? "ui_reviving_progress" : "ui_securing_progress";
    self setclientomnvar( omnvarname, value );
}

// Namespace laststand
// Params 1, eflags: 0x4
// Checksum 0x7ae9ed7f, Offset: 0xe12c
// Size: 0x28
function private function_90d749febff3150( revivee )
{
    if ( revivee.beingrevived )
    {
        revivee.var_3ded14e19d81ef7e = 1;
    }
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x6392a140, Offset: 0xe15c
// Size: 0x30
function private function_10f71e4322c49a0f( reviver, var_28fd2832030be6ac )
{
    if ( function_b5502c5e2119ad7f( reviver, var_28fd2832030be6ac ) )
    {
        return "player_drag_revive";
    }
    
    return level.var_3e5605730504d2c;
}

// Namespace laststand
// Params 2, eflags: 0x4
// Checksum 0x97940951, Offset: 0xe195
// Size: 0x85, Type: bool
function private function_b5502c5e2119ad7f( reviver, var_28fd2832030be6ac )
{
    if ( var_28fd2832030be6ac )
    {
        return false;
    }
    
    if ( !utility::issharedfuncdefined( #"playerdrag", #"hash_688f5b29fcf2efb2" ) )
    {
        return false;
    }
    
    if ( reviver.var_4d17c5af032d909a )
    {
        return false;
    }
    
    var_1275c6b9df04085e = getdvarint( @"hash_9b3da8e8f843c25b", 0 ) > 0;
    var_29dee66c3334d4d3 = reviver val::get( "crouch" );
    return var_1275c6b9df04085e && var_29dee66c3334d4d3;
}

