// scripts\mp\armor.gsc  (hash_1f6b7243f8d72fef.gscc) (size: 51649 Bytes / 0xc9c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50078bd3 (1342671827)
// size ...... 51649 (0xc9c1)
// includes .. 38  (offset: 0xbdb1)
// strings ... 167 (offset: 0xbee1)
// dev strs .. 16  (offset: 0xc901)
// exports ... 148 (offset: 0x7c69)
// cseg ...... 0x10cf + 0x6b9a (0x7c69)
// imports ... 328 (offset: 0x9389)
// animtree1 . 0   (offset: 0xc9c1)
// animtree2 . 0   (offset: 0xc9c1)
#using script_16ea1b94f0f381b3;
#using script_45dbfb1869cdd1bd;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\throwstar;
#using scripts\mp\common\killstreaks\assault_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_armor;
#using scripts\mp\playerhealth;
#using scripts\mp\quickprompt;
#using scripts\mp\squads;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace armor;

// Namespace armor
// Params 0, eflags: 0x5
// Checksum 0xbe3eb267, Offset: 0x10ed
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"armor", undefined, &init, undefined );
}

// Namespace armor
// Params 0
// Checksum 0x4e36cd2d, Offset: 0x110e
// Size: 0x478
function init()
{
    if ( level.armorinited )
    {
        return;
    }
    
    level.allowarmor = getmatchrulesdata( "commonOption", "allowArmor" ) == 1;
    
    if ( !isdefined( level.var_31552d716cc03400 ) )
    {
        level.var_31552d716cc03400 = getdvarint( @"hash_cce2d04880fe5113", 0 );
    }
    
    level.var_1bfbe247e8d32b1b = getdvarint( @"scr_armor_plate_amount", 50 );
    
    if ( !getdvarint( @"hash_ca89406fb9548d3d", 0 ) )
    {
        level.var_22a02f4a2b8f0faa = getmatchrulesdata( "commonOption", "plateCarrierEnabled" );
    }
    
    level.platecarrierstartlevel = getdvarint( @"hash_1f47448f4556f3ba", getmatchrulesdata( "commonOption", "plateCarrierStartLevel" ) );
    level.spawnarmor = getmatchrulesdata( "commonOption", "spawnArmor" );
    level.spawnarmorplates = getmatchrulesdata( "commonOption", "spawnArmorPlates" );
    level.var_2d63618f49cb3b63 = getdvarint( @"scr_armor_helmet_pop", 1 ) == 1;
    level.droparmorondeath = getmatchrulesdata( "commonOption", "dropArmorOnDeath" );
    level.armordropamount = getmatchrulesdata( "commonOption", "armorDropAmount" );
    level.var_1bd712f9520609c8 = getdvarint( @"hash_957847f02f2781a8", 0 );
    level.var_19e654be23bff1c8 = getdvarint( @"hash_2bcfbe19dac56dd7", 3 );
    level.var_69efd410f18748f7 = getdvarint( @"hash_be3a8d807c217559", 1 );
    level.var_7de0db416e5d903b = getmatchrulesdata( "commonOption", "shouldOhkProtect" );
    level.var_ca972ed4d58fdd30 = getdvarint( @"hash_d2591f329d2ec7d4", 1 ) > 0;
    
    /#
        level function_d22da41c9f96b841();
    #/
    
    utility::callsharedfunc( #"bodysize", #"hash_dc361dc19396662b" );
    
    if ( !level.allowarmor )
    {
        return;
    }
    
    if ( !level.var_55bbdddfcf3fe14c )
    {
        callback::add( #"player_connect", &function_828cf456967b29a0 );
        callback::add( #"player_spawned", &function_91f24341939b251d );
        callback::add( #"hash_cc06eb1d45f33a0c", &joinsquadcallback );
    }
    
    level lui_game_event_aggregator::registeronluieventcallback( &function_6228482afe1de9bf );
    level.onhelmetsniped = &onhelmetsniped;
    callback::add( #"player_laststand", &on_last_stand_enter );
    callback::add( #"player_spawned", &on_player_spawn );
    
    foreach ( entry in level.gametypebundle.var_ac27ce470ffebbb8 )
    {
        if ( !isdefined( level.var_35e19e0af705d62e ) )
        {
            level.var_35e19e0af705d62e = [];
        }
        
        level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = entry.weapon;
    }
    
    var_2d09c7245b352f32 = utility::function_1e6de0f4874e10be( level.gamemodebundle.var_aec4d9d2020f1849 ) ? "iw9_armor_plate_deploy_mp" : level.gamemodebundle.var_aec4d9d2020f1849;
    level.var_780fa2e8e71a20b2 = function_2e65f2dc03880e80( 1400, 1300, 1000, 900, var_2d09c7245b352f32 );
    level.var_a79fea38ed90447b = function_2e65f2dc03880e80( 700, 650, 500, 450, "iw9_armor_plate_speed_up_deploy_mp" );
    level.var_aeecf235d5b047d9 = function_2e65f2dc03880e80( 980, 910, 700, 630, "sat_armor_plate_speed_up_specialty_deploy_mp" );
    level.armorinited = 1;
    utility::registersharedfunc( #"armor", #"hash_75e364874abb092f", &givestartingarmor );
    thread function_aa2df64cf3ec6dbc();
    thread function_78b9ebfac12cfa6d();
    
    if ( level.droparmorondeath && !common_item::items_isenabled() )
    {
        collectibles::initialize();
        
        if ( collectibles::is_initialized() )
        {
            level.canusecollectible = &canusecollectible;
            callback::add( #"hash_64d5ef3aec7665f8", &function_4d48f2e0bbd97a7d );
            callback::add( #"hash_163ce3e6ccfcab8d", &function_4d48f2e0bbd97a7d );
        }
    }
    
    /#
        level thread dev::devcommandwatcher( @"armor_debug", &debugarmor );
    #/
}

// Namespace armor
// Params 0
// Checksum 0x5c0f1d55, Offset: 0x158e
// Size: 0x3a
function function_aa2df64cf3ec6dbc()
{
    utility::flag_wait( "equipment_initialized" );
    equipment_mp::registercallback( "equip_armor_onehanded", "onFired", &function_1d7e3fe7dfb610bb );
    equipment_mp::registercallback( "equip_armor_onehanded", "onTake", &function_174882d3c7ae6c6b );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xde1b62a8, Offset: 0x15d0
// Size: 0x31
function private function_78b9ebfac12cfa6d()
{
    if ( !bots_util::function_deef484b5b3a3977() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level waittill( #"player_spawned" );
    function_7ece8000db0801fc( function_d411207104391502() );
}

// Namespace armor
// Params 0
// Checksum 0x7e550927, Offset: 0x1609
// Size: 0xdb
function function_d22da41c9f96b841()
{
    allowarmor = getdvarint( @"scr_player_allowarmoroverride", -1 );
    spawnarmorplates = getdvarint( @"hash_d7b4016f72a67d64", -1 );
    spawnarmor = getdvarint( @"scr_player_spawnarmoroverride", -1 );
    droparmorondeath = getdvarint( @"hash_839ead624493a662", -1 );
    armordropamount = getdvarint( @"hash_b8b95d553dfaa5a7", -1 );
    
    if ( allowarmor >= 0 )
    {
        level.allowarmor = allowarmor;
    }
    
    if ( spawnarmorplates >= 0 )
    {
        level.spawnarmorplates = spawnarmorplates;
    }
    
    if ( spawnarmor >= 0 )
    {
        level.spawnarmor = spawnarmor;
    }
    
    if ( droparmorondeath >= 0 )
    {
        level.droparmorondeath = droparmorondeath;
    }
    
    if ( armordropamount >= 0 )
    {
        level.armordropamount = armordropamount;
    }
}

// Namespace armor
// Params 2
// Checksum 0x17a085f, Offset: 0x16ec
// Size: 0x85
function function_6228482afe1de9bf( notification, slotindex )
{
    if ( notification == "try_use_heal_slot" )
    {
        var_515a75453c258532 = slotindex;
        var_e3b8949ec75aa42b = 1;
        self.var_56de0ac6e8aaf432 = undefined;
        
        if ( var_515a75453c258532 == 1 )
        {
            var_e3b8949ec75aa42b = function_22290101992e4874();
            self.var_56de0ac6e8aaf432 = 1;
        }
        else if ( self.armorqueued > 0 && var_515a75453c258532 == 2 )
        {
            var_e3b8949ec75aa42b = 0;
        }
        
        thread tryusearmor( var_e3b8949ec75aa42b );
    }
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x5bb01f54, Offset: 0x1779
// Size: 0x14
function private function_828cf456967b29a0( var_8582cc5f29b6732c )
{
    initarmor( 0 );
}

// Namespace armor
// Params 1
// Checksum 0x29bf03b6, Offset: 0x1795
// Size: 0x26e
function initarmor( var_889aa98230e4f054 )
{
    if ( !level.allowarmor || self.armorinitialized )
    {
        return;
    }
    
    self.armorinitialized = 1;
    defaultmaxarmor = 150;
    
    if ( level.gametype == "dungeons" )
    {
        if ( isdefined( self.perks[ "specialty_extra_armor" ] ) )
        {
            var_476da819766fbb9b = 3;
        }
        else if ( level.var_22a02f4a2b8f0faa )
        {
            if ( isdefined( level.var_89173a04bb110bf3 ) )
            {
                [ self.spawnarmor ] = [[ level.var_89173a04bb110bf3 ]]();
                var_476da819766fbb9b = int( self.spawnarmor / 135 );
            }
            else
            {
                var_476da819766fbb9b = level.platecarrierstartlevel;
            }
        }
        else
        {
            var_476da819766fbb9b = 3;
        }
        
        defaultmaxarmor = 135 * var_476da819766fbb9b;
        self.platecarrierlevel = var_476da819766fbb9b;
        
        if ( isdefined( self.perks[ "specialty_increased_armor_health" ] ) || self.increased_armor_health )
        {
            defaultmaxarmor = 540;
        }
        
        self.maxarmorhealth = defaultmaxarmor;
        
        if ( var_889aa98230e4f054 )
        {
            currentcount = function_22290101992e4874();
            function_d3aacadddd06ad10( currentcount );
            return;
        }
        
        function_b072d0355af6e535( 0 );
        setarmorhealth( 0 );
        return;
    }
    
    if ( level.var_22a02f4a2b8f0faa )
    {
        var_476da819766fbb9b = level.platecarrierstartlevel;
        
        if ( isbrgamemode() )
        {
            if ( level.var_dd8633765c6a1db9 )
            {
                if ( isbot( self ) )
                {
                    var_476da819766fbb9b = getdvarint( @"scr_br_plate_carrier_br_start_level", 2 );
                }
                else
                {
                    var_476da819766fbb9b = self getplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel" );
                }
                
                var_c310d46470d97010 = getdvarint( @"hash_8f2b4d22dcdc9934", -1 );
                
                if ( var_c310d46470d97010 != -1 )
                {
                    var_476da819766fbb9b = var_c310d46470d97010;
                }
            }
            else
            {
                function_d3aacadddd06ad10( var_476da819766fbb9b );
            }
            
            if ( function_52bd24d06ec049d7() && !isdefined( self.platecarriertype ) && var_476da819766fbb9b > 1 )
            {
                self.platecarriertype = "brloot_plate_carrier_" + var_476da819766fbb9b;
            }
        }
        
        self.platecarrierlevel = var_476da819766fbb9b;
        
        if ( level.var_f65356c6fd0d4607 && isdefined( level.var_1bfbe247e8d32b1b ) )
        {
            defaultmaxarmor = var_476da819766fbb9b * level.var_1bfbe247e8d32b1b;
            self.spawnarmor = defaultmaxarmor;
        }
    }
    
    self.maxarmorhealth = getdvarint( @"scr_player_armor_max_health", defaultmaxarmor );
    function_b072d0355af6e535( 0 );
    setarmorhealth( 0, 1 );
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0xd1d1b049, Offset: 0x1a0b
// Size: 0x13
function private joinsquadcallback( params )
{
    function_afb0bdfecc551b93();
}

// Namespace armor
// Params 0
// Checksum 0x12577f63, Offset: 0x1a26
// Size: 0x103
function function_afb0bdfecc551b93()
{
    if ( isdefined( self.team ) )
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            if ( self != player )
            {
                if ( player.armorinitialized )
                {
                    player setarmoromnvars();
                }
            }
        }
    }
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x88cd7243, Offset: 0x1b31
// Size: 0x35
function private function_91f24341939b251d( params )
{
    if ( !self.var_1960cbb706040e66 || gamelogic_mp::function_8f165bf1d7e138c4( params.revivespawn ) )
    {
        givestartingarmor();
    }
}

// Namespace armor
// Params 2
// Checksum 0x21dd923, Offset: 0x1b6e
// Size: 0x1bd
function givestartingarmor( armorvalue, numplates )
{
    if ( !level.allowarmor || self.var_483b0008231510f )
    {
        return;
    }
    
    if ( level.var_31552d716cc03400 || !function_389e3b45d147d61f() )
    {
        function_f63c7d587db4fca7();
        return;
    }
    
    initarmor( 0 );
    
    if ( level.var_89173a04bb110bf3 )
    {
        [ armorvalue, numplates ] = [[ level.var_89173a04bb110bf3 ]]( self );
    }
    
    if ( !isdefined( armorvalue ) )
    {
        armorvalue = self.spawnarmor ?? level.spawnarmor;
    }
    
    if ( !isdefined( numplates ) )
    {
        numplates = level.spawnarmorplates;
    }
    
    if ( utility::issharedfuncdefined( #"bodysize", #"hash_c979cda5a5fce15a" ) )
    {
        armorvalue = utility::callsharedfunc( #"bodysize", #"hash_c979cda5a5fce15a", armorvalue );
    }
    
    setarmorhealth( armorvalue, 1 );
    self.var_640934ba73e304d6 = undefined;
    
    if ( isbrgamemode() && !level.var_dd8633765c6a1db9 )
    {
        self.platecarrierlevel = level.platecarrierstartlevel;
        
        if ( utility::callsharedfunc( #"gulag", #"hash_dc636254c56e696a" ) )
        {
            numplates = 0;
        }
    }
    
    numplates += self.pers[ "armor_buy_plates" ] ?? 0;
    
    if ( isdefined( self.var_8f4684cdf987fd02 ) )
    {
        numplates += self.var_8f4684cdf987fd02;
        self.var_8f4684cdf987fd02 = undefined;
    }
    
    self giveweapon( function_d411207104391502() );
    self setclientomnvar( "ui_equipment_id_health", 27 );
    self.var_1960cbb706040e66 = 1;
    
    if ( numplates < 0 )
    {
        function_f63c7d587db4fca7();
        return;
    }
    
    function_d3aacadddd06ad10( numplates );
}

// Namespace armor
// Params 0
// Checksum 0x46f7fe53, Offset: 0x1d33
// Size: 0x17
function function_f63c7d587db4fca7()
{
    self setclientomnvar( "ui_equipment_id_health", 27 );
    function_d3aacadddd06ad10( 0 );
}

// Namespace armor
// Params 0
// Checksum 0x81354627, Offset: 0x1d52
// Size: 0x82
function function_d411207104391502()
{
    if ( isdefined( level.equipment.table[ level.armorref ?? "equip_armorplate" ] ) )
    {
        return level.equipment.table[ level.armorref ?? "equip_armorplate" ].objweapon;
    }
    
    if ( !isdefined( level.armorobjweapon ) )
    {
        level.armorobjweapon = makeweapon( "armorplate" );
    }
    
    return level.armorobjweapon;
}

// Namespace armor
// Params 0
// Checksum 0x11fe01fb, Offset: 0x1ddd
// Size: 0xd, Type: bool
function hasarmor()
{
    return self.armorhealth > 0;
}

// Namespace armor
// Params 0
// Checksum 0xc49b1b7c, Offset: 0x1df3
// Size: 0x53
function function_70d2a998e632c76()
{
    if ( !( isdefined( self.armorhealth ) && isdefined( self.maxarmorhealth ) ) )
    {
        return 0;
    }
    
    if ( level.var_22a02f4a2b8f0faa )
    {
        return ( int( ( self.armorhealth + 5 ) / level.var_1bfbe247e8d32b1b ) >= 3 );
    }
    
    return has_full_armor();
}

// Namespace armor
// Params 0
// Checksum 0xd39d969b, Offset: 0x1e4e
// Size: 0x25
function getarmorhealth()
{
    if ( !level.allowarmor )
    {
        return 0;
    }
    
    if ( hasarmor() )
    {
        return self.armorhealth;
    }
    
    return 0;
}

// Namespace armor
// Params 0
// Checksum 0x5cd12ed8, Offset: 0x1e7c
// Size: 0x43, Type: bool
function function_4514dcf3d65e7af0()
{
    armorhealth = int( getarmorhealth() );
    armorPlateCount = int( function_cb22658f54166b6b() );
    
    if ( armorhealth > 0 && armorPlateCount > 0 )
    {
        return ( armorhealth % armorPlateCount == 0 );
    }
    
    return false;
}

// Namespace armor
// Params 1
// Checksum 0xc37ce566, Offset: 0x1ec8
// Size: 0x39
function refreshmaxarmorhealth( newarmorhealth = self.armorhealth )
{
    self.maxarmorhealth = 50 * function_3988e68b87d5acc0();
    setarmorhealth( newarmorhealth, 1 );
}

// Namespace armor
// Params 1
// Checksum 0xf273207b, Offset: 0x1f09
// Size: 0x69
function function_e06e75f881ba4db6( value )
{
    if ( !isdefined( self.var_638eb8a47c8ee352 ) )
    {
        return 0;
    }
    
    var_b383d46f0fbe700 = self.var_b383d46f0fbe700 ?? 150;
    var_aa609e8fd7b83128 = int( clamp( value, 0, var_b383d46f0fbe700 ) );
    
    if ( var_aa609e8fd7b83128 == self.var_638eb8a47c8ee352 )
    {
        return 0;
    }
    
    self.var_638eb8a47c8ee352 = var_aa609e8fd7b83128;
}

// Namespace armor
// Params 3
// Checksum 0xf05f2380, Offset: 0x1f7a
// Size: 0x106, Type: bool
function setarmorhealth( value, var_393307302cd34140, forcesethealth )
{
    if ( !isent( self ) || !level.allowarmor )
    {
        return false;
    }
    
    /#
        assert( isdefined( value ), "<dev string:x24>" );
        assert( isdefined( self.maxarmorhealth ), "<dev string:x4f>" );
    #/
    
    newarmorhealth = int( clamp( value, 0, self.maxarmorhealth ) );
    
    if ( newarmorhealth == self.armorhealth && !forcesethealth )
    {
        return false;
    }
    
    self.var_2dc2a207d323487a = self.armorhealth;
    self.armorhealth = newarmorhealth;
    
    if ( self.armorhealth >= self.maxarmorhealth )
    {
        callback::callback( #"armor_health_full" );
    }
    
    function_92490792e5aee06e( var_393307302cd34140 );
    function_21291da247b3eea6();
    callback::callback( "on_armor_health_changed" );
    self notify( #"armor_health_update" );
    return true;
}

// Namespace armor
// Params 1
// Checksum 0xe93f60fe, Offset: 0x2089
// Size: 0x6b
function function_92490792e5aee06e( var_393307302cd34140 )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_d572027bc1993a06" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"hash_d572027bc1993a06" ) ]]( var_393307302cd34140 );
    }
    else
    {
        setarmoromnvars( var_393307302cd34140 );
    }
    
    utility::callsharedfunc( #"helmet", #"hash_d62d9d829b13dfb0", self );
}

// Namespace armor
// Params 0
// Checksum 0xc1178dc0, Offset: 0x20fc
// Size: 0x28
function function_22290101992e4874()
{
    /#
        if ( getdvarint( @"scr_infinite_armor", 0 ) )
        {
            return function_db9ebf086f67fe92();
        }
    #/
    
    return self getammocount( function_d411207104391502() );
}

// Namespace armor
// Params 1
// Checksum 0xffd0073a, Offset: 0x212d
// Size: 0x46
function function_88bd3cd8729867e4( armorhealth )
{
    if ( level.var_1bfbe247e8d32b1b > 0 )
    {
        platecount = float( armorhealth ) / float( level.var_1bfbe247e8d32b1b );
        return int( ceil( platecount ) );
    }
    
    return 0;
}

// Namespace armor
// Params 2
// Checksum 0xaace887, Offset: 0x217c
// Size: 0x64
function function_164c824617d7e8d7( var_a020da1150a5423e = 1, commonitemremove )
{
    current = function_22290101992e4874();
    function_d3aacadddd06ad10( current + var_a020da1150a5423e, commonitemremove );
    callback::callback( #"give_armor_plates", { #var_a020da1150a5423e:var_a020da1150a5423e } );
    self notify( #"give_armor_plates" );
}

// Namespace armor
// Params 0
// Checksum 0xcf8aa0bb, Offset: 0x21e8
// Size: 0x91
function function_db9ebf086f67fe92()
{
    maxplates = 6;
    
    if ( isdefined( level.var_40d8cae54a6dee6a ) && level.var_22a02f4a2b8f0faa )
    {
        maxplates = [[ level.var_40d8cae54a6dee6a ]]();
        return maxplates;
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_2f741b96164e5e2c > 0 )
    {
        maxplates = level.gametypebundle.var_2f741b96164e5e2c;
    }
    
    if ( self.hasplatepouch )
    {
        maxplates += level.var_19e654be23bff1c8;
    }
    
    return maxplates;
}

// Namespace armor
// Params 0
// Checksum 0x51462f26, Offset: 0x2282
// Size: 0x4
function function_dc29a08dd2814b7f()
{
    return 50;
}

// Namespace armor
// Params 0
// Checksum 0x194fd8a6, Offset: 0x228f
// Size: 0x28, Type: bool
function function_917d57b2f6b9d879()
{
    current = function_22290101992e4874();
    maxplates = function_db9ebf086f67fe92();
    return current >= maxplates;
}

// Namespace armor
// Params 8
// Checksum 0xa2daeb0e, Offset: 0x22c0
// Size: 0x3c5
function damagearmor( damage, var_a2ad5bdc422fb9ad, attacker, smeansofdeath, var_393307302cd34140, calculateonly, inflictor, objweapon )
{
    if ( !hasarmor() )
    {
        return damage;
    }
    
    if ( !isdefined( damage ) )
    {
        damage = 0;
    }
    
    if ( isdefined( level.var_6f8b7a2e996178a8 ) )
    {
        damageabsorbed = self [[ level.var_6f8b7a2e996178a8 ]]( damage, attacker, inflictor, smeansofdeath );
    }
    else
    {
        damageabsorbed = int( min( self.armorhealth, damage ) );
    }
    
    damagepassed = damage - ( damageabsorbed ?? 0 );
    
    if ( isdefined( level.var_21038aca0aba3c4a ) )
    {
        damageabsorbed = self [[ level.var_21038aca0aba3c4a ]]( damageabsorbed, attacker, smeansofdeath );
    }
    
    if ( self.var_638eb8a47c8ee352 > 0 )
    {
        function_e06e75f881ba4db6( self.var_638eb8a47c8ee352 - damageabsorbed );
    }
    else if ( !calculateonly )
    {
        setarmorhealth( self.armorhealth - damageabsorbed, var_393307302cd34140 );
        params = { #attacker:attacker, #damageabsorbed:damageabsorbed, #armormaxhealth:self.maxarmorhealth, #armorhealth:self.armorhealth };
        callback::callback( #"hash_5447fe6feab51288", params );
        self notify( #"damage_armor", damageabsorbed, attacker );
        
        if ( isdefined( attacker ) )
        {
            attacker notify( #"victim_armor_damaged", self, attacker, damage, inflictor );
        }
        
        if ( self.armorhealth == 0 && damageabsorbed > 0 )
        {
            if ( !var_a2ad5bdc422fb9ad )
            {
                thread function_12eeca6c445bb784( attacker );
            }
            
            params = { #objweapon:objweapon, #smeansofdeath:smeansofdeath, #attacker:attacker, #damageabsorbed:damageabsorbed, #armormaxhealth:self.maxarmorhealth, #armorhealth:self.armorhealth };
            callback::callback( "on_armor_break", params );
        }
        
        if ( self.armorhealth == 0 && isdefined( self.armorbreakfunc ) )
        {
            [[ self.armorbreakfunc ]]( self, attacker );
        }
        
        if ( isplayer( attacker ) && self.armorhealth == 0 && damageabsorbed > 0 )
        {
            attacker thread talking_gun::function_387fb62cdc8a529d( self );
        }
        
        var_bffa485d3075679c = level.var_1bfbe247e8d32b1b;
        prevhealth = self.armorhealth + damageabsorbed;
        prevplates = int( floor( prevhealth / var_bffa485d3075679c ) );
        currplates = int( floor( self.armorhealth / var_bffa485d3075679c ) );
        
        if ( currplates < prevplates || self.armorhealth == 0 )
        {
            maxplates = self.maxarmorhealth / var_bffa485d3075679c;
            params = { #smeansofdeath:smeansofdeath, #attacker:attacker, #totalplates:maxplates, #currplates:currplates, #brokenplate:prevplates, #armorhealth:self.armorhealth };
            callback::callback( #"hash_a359ccbee608ee6f", params );
        }
        
        if ( self.armorhealth == 0 )
        {
            params = spawnstruct();
            params.damage = damage;
            params.attacker = attacker;
            params.smeansofdeath = smeansofdeath;
            callback::callback( #"hash_aa7c0dbef3e86ee4", params );
        }
    }
    
    if ( utility::ent_flag( "frenzied_guard_active" ) && self.armorhealth > 0 )
    {
        damagepassed = 0;
    }
    
    return damagepassed;
}

// Namespace armor
// Params 1
// Checksum 0xe65afc6c, Offset: 0x268e
// Size: 0x11d
function function_12eeca6c445bb784( attacker )
{
    if ( level.gamemodebundle.var_c16d873db03a5115 )
    {
        wait level.gamemodebundle.var_c16d873db03a5115;
    }
    
    if ( isalive( self ) )
    {
        if ( isplayer( self ) )
        {
            if ( isdefined( level.gamemodebundle.var_b8f236e7432f6fdc ) && soundexists( level.gamemodebundle.var_b8f236e7432f6fdc ) )
            {
                self playsoundtoplayer( level.gamemodebundle.var_b8f236e7432f6fdc, self );
            }
            
            if ( level.gamemodebundle.var_121064a273c6516f )
            {
                self setscriptablepartstate( "armor_break", "armor_break", 0 );
            }
            
            return;
        }
        
        if ( isplayer( attacker ) && isalive( attacker ) )
        {
            if ( isdefined( level.gamemodebundle.var_b8f71ce743355f85 ) && soundexists( level.gamemodebundle.var_b8f71ce743355f85 ) )
            {
                self playsoundtoplayer( level.gamemodebundle.var_b8f71ce743355f85, attacker, self );
            }
        }
    }
}

// Namespace armor
// Params 0
// Checksum 0x3c59fa99, Offset: 0x27b3
// Size: 0x14
function breakarmor()
{
    damagearmor( self.armorhealth, 1 );
}

// Namespace armor
// Params 0
// Checksum 0x69dea178, Offset: 0x27cf
// Size: 0x5d
function function_85df73d61996f00b()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !level.allowarmor )
    {
        return;
    }
    
    while ( !isdefined( self.maxarmorhealth ) )
    {
        waitframe();
    }
    
    if ( self.maxarmorhealth == 0 )
    {
        return 0;
    }
    
    return self.armorhealth / self.maxarmorhealth;
}

// Namespace armor
// Params 1
// Checksum 0x464a1fb4, Offset: 0x2835
// Size: 0x80
function function_a6a1f132cb2b2bee( var_c1868bdcf24963f8 )
{
    var_97747361dc57e81 = [ 0.67, 0.34, 0 ];
    var_d2964d6c97277973 = self getclientomnvar( "ui_armor_percent" );
    var_f4796f632c05c4f2 = 0;
    
    for ( i = 0; i < var_97747361dc57e81.size ; i++ )
    {
        if ( var_d2964d6c97277973 > var_97747361dc57e81[ i ] && var_c1868bdcf24963f8 <= var_97747361dc57e81[ i ] )
        {
            var_f4796f632c05c4f2++;
        }
    }
    
    return var_f4796f632c05c4f2;
}

// Namespace armor
// Params 1
// Checksum 0x71284f2a, Offset: 0x28be
// Size: 0x237
function setarmoromnvars( var_393307302cd34140 )
{
    if ( !isplayer( self ) || !level.allowarmor )
    {
        return;
    }
    
    armorpercent = function_85df73d61996f00b();
    
    if ( !var_393307302cd34140 )
    {
        if ( isdefined( self.pers[ "telemetry" ].armor_destroyed ) )
        {
            var_f4796f632c05c4f2 = function_a6a1f132cb2b2bee( armorpercent );
            
            if ( var_f4796f632c05c4f2 > 0 )
            {
                self.pers[ "telemetry" ].armor_destroyed = self.pers[ "telemetry" ].armor_destroyed + var_f4796f632c05c4f2;
            }
        }
    }
    
    if ( isdefined( level.var_deed8ad09d3bee37 ) && level.var_22a02f4a2b8f0faa )
    {
        maxarmor = self [[ level.var_deed8ad09d3bee37 ]]();
        armorpercent = maxarmor != 0 ? self.armorhealth / maxarmor : 0;
    }
    
    self setclientomnvar( "ui_armor_percent", armorpercent );
    self setclientomnvar( "ui_equipment_id_health", 27 );
    
    if ( hasomnvar( "ui_plate_carrier_id" ) )
    {
        lootid = item_armor::function_94b1ce9c97119a3a();
        self setclientomnvar( "ui_plate_carrier_id", lootid ?? 0 );
    }
    
    if ( level.gametype === "hvt" || level.var_6ee986c6c0f5d22c )
    {
        mask = 255;
        bitoffset = 14;
        armorshifted = ( int( self.armorhealth ) & mask ) << bitoffset;
        invertedmask = ~( mask << bitoffset );
        prevvalue = self.game_extrainfo;
        cleanedbase = prevvalue & invertedmask;
        repackedvalue = cleanedbase + armorshifted;
        self.game_extrainfo = repackedvalue;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) || squadmemberindex == -1 )
    {
        return;
    }
    
    if ( game_utility::function_a43ada404e8c591f() )
    {
        squadmemberindex = 0;
        self setclientomnvar( "ui_armor_squad_index_" + squadmemberindex, int( self.armorhealth ) );
        return;
    }
    
    function_8e4cfaf45bd8d7ed();
}

// Namespace armor
// Params 0
// Checksum 0x4f7211f2, Offset: 0x2afd
// Size: 0x12, Type: bool
function haslowarmor()
{
    return self.armorhealth <= lowarmorthreshold();
}

// Namespace armor
// Params 0
// Checksum 0x2ac32c42, Offset: 0x2b18
// Size: 0x11
function lowarmorthreshold()
{
    return self.maxarmorhealth * 0.28;
}

// Namespace armor
// Params 1
// Checksum 0x19fd1b2, Offset: 0x2b32
// Size: 0x109
function function_c1b66363ae5617f9( team )
{
    if ( !team )
    {
        return;
    }
    
    squadmates = level.teamdata[ team ][ "players" ];
    
    if ( isdefined( level.squaddata[ team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ team ][ self.sessionsquadid ].players;
    }
    
    if ( !isdefined( squadmates ) )
    {
        squadmates = level.players;
    }
    
    if ( !squadmates )
    {
        return;
    }
    
    foreach ( player in squadmates )
    {
        if ( isdefined( player ) && player.armorinitialized )
        {
            player function_92490792e5aee06e();
        }
    }
}

// Namespace armor
// Params 0
// Checksum 0xe1b674f5, Offset: 0x2c43
// Size: 0x311
function function_8e4cfaf45bd8d7ed()
{
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    if ( !isdefined( squadmates ) )
    {
        squadmates = level.players;
    }
    
    armorhealth = int( self.armorhealth );
    maxarmor = self.maxarmorhealth;
    
    if ( !( level.gametype == "dungeons" ) )
    {
        var_70fef5e2119328fa = 0;
        var_4deca59c42126fe8 = 150;
    }
    else
    {
        var_70fef5e2119328fa = 0;
        var_4deca59c42126fe8 = maxarmor;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( squadmemberindex == -1 )
    {
        return;
    }
    
    if ( squads::function_bbd7c5f24d46f0c4() != 0 )
    {
        if ( squadmemberindex >= squads::function_bbd7c5f24d46f0c4() )
        {
            squadmemberindex = 0;
            self.sessionuimemberindex = 0;
        }
    }
    
    if ( isdefined( level.var_deed8ad09d3bee37 ) && level.var_22a02f4a2b8f0faa )
    {
        maxarmor = [[ level.var_deed8ad09d3bee37 ]]();
        var_70fef5e2119328fa = 512;
        var_4deca59c42126fe8 = 524287;
    }
    else if ( level.var_22a02f4a2b8f0faa )
    {
        maxarmor = 150;
        var_70fef5e2119328fa = 512;
        var_4deca59c42126fe8 = 524287;
    }
    
    omnvarval = maxarmor != 0 ? int( armorhealth * maxarmor / maxarmor ) : 0;
    
    if ( level.var_22a02f4a2b8f0faa )
    {
        var_972f048d7b72cd53 = function_3988e68b87d5acc0() << 10;
        omnvarval += var_972f048d7b72cd53;
        typebits = function_d8063ec237cd944b( self );
        var_7f6eb3f4bd31fb86 = typebits << 13;
        omnvarval += var_7f6eb3f4bd31fb86;
        effectval = 0;
        
        if ( self.var_8c594113e8ed3d60 )
        {
            effectval = 2;
        }
        else if ( self.var_a1faa64d8c07872e )
        {
            effectval = 1;
        }
        
        if ( effectval > 0 )
        {
            omnvarval += effectval << 16;
        }
    }
    
    if ( !isdefined( omnvarval ) )
    {
        omnvarval = var_70fef5e2119328fa;
    }
    else
    {
        omnvarval = int( clamp( omnvarval, var_70fef5e2119328fa, var_4deca59c42126fe8 ) );
    }
    
    if ( self.var_cb082b28bfcfde57 )
    {
        omnvarval += 262144;
    }
    
    if ( game_utility::getgametype() == "armorup" )
    {
        self setclientomnvar( "ui_armor_squad_index_" + squadmemberindex, omnvarval );
        return;
    }
    
    if ( isdefined( level.var_4c0febb86a7c172e ) )
    {
        self [[ level.var_4c0febb86a7c172e ]]( "ui_armor_squad_index_", squadmemberindex, omnvarval );
        return;
    }
    
    foreach ( player in squadmates )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_armor_squad_index_" + squadmemberindex, omnvarval );
        }
    }
}

// Namespace armor
// Params 0
// Checksum 0x686f9276, Offset: 0x2f5c
// Size: 0x17
function function_bc6363e19ce42a9a()
{
    return 3 + ( level.pe_heavyarmor_active ? 1 : 0 );
}

// Namespace armor
// Params 0
// Checksum 0xef4b4641, Offset: 0x2f7c
// Size: 0x7c
function function_3988e68b87d5acc0()
{
    if ( isdefined( self.perks[ "specialty_trait_larger_plate_carrier" ] ) )
    {
        var_50137072cbdcbc36 = level.perkbundles[ "specialty_trait_larger_plate_carrier" ].extraplates ?? 1;
        return int( min( self.platecarrierlevel + var_50137072cbdcbc36, function_bc6363e19ce42a9a() ) );
    }
    
    if ( level.pe_heavyarmor_active )
    {
        return ( self.platecarrierlevel + 1 );
    }
    
    return self.platecarrierlevel;
}

// Namespace armor
// Params 1
// Checksum 0xe8762d7f, Offset: 0x3001
// Size: 0x15
function function_b359444c252374fc( numplates )
{
    function_d3aacadddd06ad10( numplates );
}

// Namespace armor
// Params 2, eflags: 0x4
// Checksum 0xf66abeca, Offset: 0x301e
// Size: 0x345
function private function_d3aacadddd06ad10( numplates, commonitemremove )
{
    if ( numplates < 0 )
    {
        numplates = 0;
    }
    
    backpackenabled = undefined;
    
    if ( utility::issharedfuncdefined( #"inventory", #"isbackpackinventoryenabled" ) )
    {
        backpackenabled = [[ utility::getsharedfunc( #"inventory", #"isbackpackinventoryenabled" ) ]]();
    }
    
    maxplates = function_db9ebf086f67fe92();
    
    if ( !backpackenabled )
    {
        numplates = int( clamp( numplates, 0, maxplates ) );
    }
    
    resultplates = numplates;
    
    if ( backpackenabled )
    {
        changeamount = maxplates - numplates;
        
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            leftoveramount = 0;
            
            if ( changeamount > 0 && utility::issharedfuncdefined( #"backpack", #"removesmallestitemstackbackpack" ) )
            {
                leftoveramount = [[ utility::getsharedfunc( #"backpack", #"removesmallestitemstackbackpack" ) ]]( "brloot_armor_plate", changeamount );
            }
            else if ( changeamount < 0 && utility::issharedfuncdefined( #"backpack", #"addItemToBackpack" ) )
            {
                [[ utility::getsharedfunc( #"backpack", #"additemtobackpackbyref" ) ]]( "brloot_armor_plate", "consumable", changeamount * -1 );
            }
            
            resultplates = int( min( maxplates, maxplates - leftoveramount ) );
            
            if ( isdefined( self.equipment ) )
            {
                self.equipment[ "health" ] = level.armorref ?? "equip_armorplate";
            }
        }
        else if ( !commonitemremove )
        {
            resultplates = numplates;
            lootid = common_item::items_getlootidfromref( level.armorref ?? "equip_armorplate" );
            
            if ( lootid && changeamount > 0 )
            {
                resultplates += common_inventory::function_3cd473ff8c027855( lootid, changeamount );
            }
        }
        
        armorobj = function_d411207104391502();
        
        if ( !self hasweapon( armorobj ) )
        {
            self giveweapon( armorobj );
        }
        
        if ( isbrgamemode() && utility::issharedfuncdefined( #"br", #"hash_ccc082092db526b8" ) )
        {
            var_22a509995e00c122 = function_d3aa416001bf116c();
            self [[ utility::getsharedfunc( #"br", #"hash_ccc082092db526b8" ) ]]( "armorPlateCount", resultplates + var_22a509995e00c122 );
        }
    }
    else if ( level.gametype == "dungeons" || level.droparmorondeath || getdvarint( @"hash_5afa341109e3a9f4", 0 ) )
    {
        if ( isdefined( self.equipment ) )
        {
            self.equipment[ "health" ] = level.armorref ?? "equip_armorplate";
        }
    }
    
    maxplates = function_db9ebf086f67fe92();
    resultplates = int( clamp( resultplates, 0, maxplates ) );
    self setweaponammoclip( function_d411207104391502(), resultplates );
    self setclientomnvar( "ui_equipment_id_health_numCharges", resultplates );
    
    if ( resultplates > 0 )
    {
        if ( level.gamemodebundle.var_d645f673eecc5fdf && quickprompt::quickpromptisenabled() && quickprompt::function_7b73a63596c6effb( level.gamemodebundle.var_d645f673eecc5fdf ) )
        {
            quickprompt::quickpromptcancel();
        }
    }
}

// Namespace armor
// Params 0
// Checksum 0x580658a2, Offset: 0x336b
// Size: 0xf
function function_d844468b44333411()
{
    function_d3aacadddd06ad10( function_22290101992e4874() );
}

// Namespace armor
// Params 1
// Checksum 0x2efed215, Offset: 0x3382
// Size: 0x78
function function_df9c3f3288ff004f( count )
{
    if ( self function_d4623c519f8b97f5() )
    {
        if ( !self function_15c9f696b302cb13() || !self.var_4f8bc414b5378af )
        {
            waitframe();
            amount = 1;
            
            if ( isdefined( count ) )
            {
                amount = count;
            }
            
            if ( self function_ced0cb60f8a65db4() )
            {
                amount = function_22290101992e4874();
            }
            
            if ( amount )
            {
                self.var_8501c5a495b7413d = 1;
                tryusearmor( amount );
                self.var_4f8bc414b5378af = 1;
            }
        }
    }
}

// Namespace armor
// Params 1
// Checksum 0x9b85df0, Offset: 0x3402
// Size: 0x226
function tryusearmor( var_e3b8949ec75aa42b )
{
    if ( !level.allowarmor )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"try_use_heal_slot" );
    
    if ( !caninsertarmor() )
    {
        if ( quickprompt::quickpromptisenabled() )
        {
            platecount = function_22290101992e4874();
            
            if ( level.var_22a02f4a2b8f0faa && !self.platecarrierlevel && level.gamemodebundle.var_17c9780e3b9eeafa )
            {
                thread quickprompt::function_661f2ac4b89488a1( level.gamemodebundle.var_17c9780e3b9eeafa );
                return;
            }
            else if ( platecount <= 0 && level.gamemodebundle.var_d645f673eecc5fdf )
            {
                thread quickprompt::function_661f2ac4b89488a1( level.gamemodebundle.var_d645f673eecc5fdf );
                return;
            }
            else if ( self.armorhealth >= self.maxarmorhealth && level.gamemodebundle.var_23b5d3804a076205 )
            {
                thread quickprompt::function_661f2ac4b89488a1( level.gamemodebundle.var_23b5d3804a076205 );
                return;
            }
        }
        
        if ( level.gamemodebundle.var_4470d5ad2986a697 )
        {
            platecount = function_22290101992e4874();
            
            if ( platecount <= 0 )
            {
                if ( level.gamemodebundle.var_d645f673eecc5fdf && quickprompt::quickpromptisenabled() )
                {
                    prompttype = quickprompt::function_34974cec7d4d14eb( level.gamemodebundle.var_d645f673eecc5fdf );
                    
                    if ( !prompttype )
                    {
                        thread function_e50775fc1ea081d9();
                    }
                    else
                    {
                        thread quickprompt::function_661f2ac4b89488a1( level.gamemodebundle.var_d645f673eecc5fdf );
                    }
                    
                    return;
                }
                
                thread function_e50775fc1ea081d9();
            }
        }
        
        return;
    }
    
    if ( !isdefined( var_e3b8949ec75aa42b ) )
    {
        var_e3b8949ec75aa42b = 1;
    }
    
    if ( self.insertingarmorplate )
    {
        if ( canqueuearmorbydefault() )
        {
            function_b072d0355af6e535( self.armorqueued + var_e3b8949ec75aa42b );
        }
    }
    else
    {
        function_b072d0355af6e535( var_e3b8949ec75aa42b );
        self.armorapplied = 0;
    }
    
    talking_gun::talkinggun_event( self, #"use_armor" );
    thread function_8e85f8532513e13a();
}

// Namespace armor
// Params 0
// Checksum 0x58e8ea2e, Offset: 0x3630
// Size: 0x8a
function function_e50775fc1ea081d9()
{
    var_a838c9c2bd720a41 = hud_util::createfontstring( "default", 1.5 );
    var_a838c9c2bd720a41 hud_util::setpoint( "CENTER", "CENTER", -15, 50 );
    var_a838c9c2bd720a41 settext( &"MP/NO_ARMOR" );
    var_a838c9c2bd720a41.color = ( 1, 0, 0 );
    wait 0.75;
    var_a838c9c2bd720a41 fadeovertime( 0.5 );
    var_a838c9c2bd720a41.alpha = 0;
    wait 0.5;
    var_a838c9c2bd720a41 destroy();
}

// Namespace armor
// Params 1
// Checksum 0xa571aa84, Offset: 0x36c2
// Size: 0x15a
function function_b072d0355af6e535( var_35248d915041b7a7 )
{
    var_efc1ca3d21d2e502 = int( self.armorhealth / level.var_1bfbe247e8d32b1b );
    var_a42df3c85d1e667c = self.maxarmorhealth / level.var_1bfbe247e8d32b1b;
    var_945faadd8ec64624 = var_a42df3c85d1e667c - var_efc1ca3d21d2e502;
    
    if ( !isbrgamemode() )
    {
        var_f4c2d929ef28c51c = int( ( self.armorhealth + 5 ) / level.var_1bfbe247e8d32b1b );
        var_80e35b46fac7c19 = self.maxarmorhealth - self.armorhealth > level.var_1bfbe247e8d32b1b;
        
        if ( var_80e35b46fac7c19 && var_f4c2d929ef28c51c > var_efc1ca3d21d2e502 )
        {
            var_945faadd8ec64624 = var_a42df3c85d1e667c - var_f4c2d929ef28c51c;
        }
    }
    
    var_241c592d24c576e5 = function_22290101992e4874();
    var_5532f6fcfa6d81ea = min( var_945faadd8ec64624, var_241c592d24c576e5 );
    assert( var_5532f6fcfa6d81ea >= 0, "<dev string:x87>" + self.armorhealth + "<dev string:xe2>" + self.maxarmorhealth + "<dev string:xf7>" + var_241c592d24c576e5 + "<dev string:x113>" );
    var_5532f6fcfa6d81ea = max( 0, var_5532f6fcfa6d81ea );
    
    if ( var_5532f6fcfa6d81ea > 8 )
    {
        var_5532f6fcfa6d81ea = 8;
    }
    
    var_35248d915041b7a7 = clamp( var_35248d915041b7a7, 0, var_5532f6fcfa6d81ea );
    self.armorqueued = var_35248d915041b7a7;
    self setclientomnvar( "ui_armor_queued_count", int( var_35248d915041b7a7 ) );
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x28fc0520, Offset: 0x3824
// Size: 0x56
function private function_af8a975b1beeec62( waittime )
{
    self setclientomnvar( "ui_inserting_armor_plate", 0 );
    armorweapon = function_2bc09e274cd103f9();
    
    if ( isdefined( armorweapon ) )
    {
        inventory_utility::_takeweapon( armorweapon );
    }
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    self.insertingarmorplate = 0;
    self.var_780d3560017175cb = 0;
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x5bdcdd5d, Offset: 0x3882
// Size: 0x1a
function private on_player_spawn( sparams )
{
    function_af8a975b1beeec62();
    function_92490792e5aee06e();
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x7ddead76, Offset: 0x38a4
// Size: 0x13
function private on_last_stand_enter( sparams )
{
    function_af8a975b1beeec62();
}

// Namespace armor
// Params 0
// Checksum 0x1415d6d0, Offset: 0x38bf
// Size: 0x9c
function function_e298190a0b8dbc09()
{
    self notify( #"hash_c38d14a7f8a8b28" );
    self endon( #"hash_c38d14a7f8a8b28" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"insertArmorComplete" );
    utility::waittill_any_return( "mantle_start", "scr_change_swim_state", "special_weapon_fired", "melee_swipe_start", "reload_start", "try_armor_cancel", "skydive_deployparachute" );
    self notify( #"end_one_hand_armor_insert" );
    armordata = function_5608dfe209578e25();
    function_af8a975b1beeec62( armordata.posttime ?? 0 );
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0xdb7a625b, Offset: 0x3963
// Size: 0x2d, Type: bool
function private function_f0ddbdab1cd1cf6b( armorname )
{
    return isdefined( level.equipment.table[ armorname ].objweapon );
}

// Namespace armor
// Params 4, eflags: 0x4
// Checksum 0x80cdf216, Offset: 0x3999
// Size: 0xad
function private function_d51f851859b23502( var_7bb96d4e478f6f0d, armorname, waittime, posttime )
{
    if ( !function_f0ddbdab1cd1cf6b( armorname ) )
    {
        assertmsg( "<dev string:x115>" + armorname + "<dev string:x11d>" );
        return var_7bb96d4e478f6f0d;
    }
    
    if ( !isdefined( posttime ) )
    {
        posttime = 0.5;
    }
    
    armordata = { #posttime:posttime, #waittime:waittime, #armorweapon:level.equipment.table[ armorname ].objweapon };
    var_7bb96d4e478f6f0d[ var_7bb96d4e478f6f0d.size ] = armordata;
    return var_7bb96d4e478f6f0d;
}

// Namespace armor
// Params 2, eflags: 0x4
// Checksum 0x92640cd0, Offset: 0x3a4f
// Size: 0x2c, Type: bool
function private function_fc208a33bdb28281( var_1ab82651bdbd106a, var_ea4986e11fa7e767 )
{
    return var_1ab82651bdbd106a.waittime < var_ea4986e11fa7e767.waittime;
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x70d64ab9, Offset: 0x3a84
// Size: 0x102
function private function_5608dfe209578e25()
{
    var_7bb96d4e478f6f0d = [];
    var_7bb96d4e478f6f0d = function_d51f851859b23502( var_7bb96d4e478f6f0d, "equip_armor_onehanded", 1.1 );
    
    if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) )
    {
        if ( self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) ]]( "specialty_speedcola" ) )
        {
            var_7bb96d4e478f6f0d = function_d51f851859b23502( var_7bb96d4e478f6f0d, "equip_armor_onehanded_quick", 0.5 );
        }
    }
    
    if ( isdefined( self.var_3a179564ddf30dd8 ) )
    {
        bundle = self.var_3a179564ddf30dd8.bundle;
        var_7bb96d4e478f6f0d = function_d51f851859b23502( var_7bb96d4e478f6f0d, bundle.var_2971918bccb78795, bundle.var_512377cf3cc9871, bundle.var_be984451d5c647a );
    }
    
    if ( isdefined( self.perks[ "specialty_faster_plating" ] ) )
    {
        var_7bb96d4e478f6f0d = function_d51f851859b23502( var_7bb96d4e478f6f0d, "equip_armor_onehanded_quick_30", 0.7 );
    }
    
    var_7bb96d4e478f6f0d = arraysort( var_7bb96d4e478f6f0d, undefined, &function_fc208a33bdb28281 );
    return var_7bb96d4e478f6f0d[ 0 ];
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xa2b92a41, Offset: 0x3b8f
// Size: 0x59f
function private function_8e85f8532513e13a()
{
    self endon( #"disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"end_one_hand_armor_insert" );
    
    if ( self.insertingarmorplate || self isswitchingweapon() )
    {
        return;
    }
    
    if ( level.gametypebundle.var_18a69809a89144d9 || getdvarint( @"hash_d48a0404793bfcfe", 0 ) == 1 || isdefined( self.perks[ "specialty_onehanded_plating" ] ) && isbrgamemode() )
    {
        if ( !isnullweapon( self getheldoffhand() ) )
        {
            superref = supers_mp::getsuperrefforsuperoffhand( self getheldoffhand() );
            
            if ( isdefined( superref ) )
            {
                return;
            }
            
            thread function_93461bcd5805cfa6();
        }
        
        if ( !caninsertarmor() || self.var_780d3560017175cb )
        {
            return;
        }
        
        isplayerreloading = self isreloading();
        
        if ( isplayerreloading )
        {
            telemetrydata = spawnstruct();
            telemetrydata.player = self;
            telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
            telemetrydata.cancelreason = "EQUIP_ARMOR";
            telemetry_utils::function_af2d366f9522f76f( "callback_on_reload_cancel", telemetrydata );
        }
        
        if ( isdefined( level.equipment.table[ "equip_armor_onehanded" ] ) && isdefined( level.equipment.table[ "equip_armor_onehanded" ].objweapon ) )
        {
            armordata = function_5608dfe209578e25();
            
            if ( !isnullweapon( self getheldoffhand() ) )
            {
                return;
            }
            
            self.insertingarmorplate = 1;
            self setclientomnvar( "ui_inserting_armor_plate", 1 );
            thread function_e298190a0b8dbc09();
            
            if ( !getdvarint( @"hash_ccf2148fe8dfd6da", 0 ) )
            {
                childthread function_47471ef3973b2d50();
                thread function_2c9d11e1e5fb64da();
            }
            
            while ( isplayer( self ) && isalive( self ) && function_6ed236a9c4953f1a() )
            {
                if ( self hasweapon( armordata.armorweapon ) )
                {
                    wait armordata.waittime ?? 0;
                    continue;
                }
                
                self giveandfireoffhand( armordata.armorweapon );
                wait armordata.waittime ?? 0;
                
                if ( !isalive( self ) )
                {
                    break;
                }
                
                if ( self.armorhealth < self.maxarmorhealth )
                {
                    usearmorplate();
                }
                
                if ( self hasweapon( armordata.armorweapon ) )
                {
                    inventory_utility::_takeweapon( armordata.armorweapon );
                }
                
                self.var_780d3560017175cb = 1;
                wait armordata.posttime ?? 0;
                self.var_780d3560017175cb = 0;
            }
            
            function_b072d0355af6e535( 0 );
            self.insertingarmorplate = 0;
            self.var_780d3560017175cb = 0;
            self setclientomnvar( "ui_inserting_armor_plate", 0 );
            self notify( #"insertArmorComplete" );
        }
        
        return;
    }
    
    isplayerreloading = self isreloading();
    
    if ( isplayerreloading )
    {
        telemetrydata = spawnstruct();
        telemetrydata.player = self;
        telemetrydata.reloadcanceltime = getsystemtimeinmicroseconds();
        telemetrydata.cancelreason = "EQUIP_ARMOR";
        telemetry_utils::function_af2d366f9522f76f( "callback_on_reload_cancel", telemetrydata );
    }
    
    attachmentsarr = [];
    
    if ( getdvarint( @"hash_700b195a7dc4c6a3", 0 ) )
    {
        var_3e3989fb89bc5ce9 = self getcurrentweapon();
        
        if ( var_3e3989fb89bc5ce9 )
        {
            switch ( weapon::getweapongroup( var_3e3989fb89bc5ce9 ) )
            {
                case #"hash_8af0086b038622b5":
                case #"hash_dd616da0b395a0b0":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_ar" ], attachmentsarr );
                    break;
                case #"hash_ab10f9c080fe4faf":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_smg" ], attachmentsarr );
                    break;
                case #"hash_16cf6289ab06bd30":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_sh" ], attachmentsarr );
                    break;
                case #"hash_bef5ec0b3e197ae":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_lmg" ], attachmentsarr );
                    break;
                case #"hash_47368bc0d2ef1565":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_dmr" ], attachmentsarr );
                    break;
                case #"hash_c095d67337b1f5a1":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_sn" ], attachmentsarr );
                    break;
                case #"hash_9d18adab1b65a661":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_la" ], attachmentsarr );
                    break;
                case #"hash_34340d457a63e7f1":
                    attachmentsarr = arraycombine( [ "t10_armor_speedmod_pi" ], attachmentsarr );
                    break;
                case #"hash_86b11ac21f992552":
                case #"hash_a1f27f97be15d620":
                    break;
            }
        }
    }
    
    var_1821cb423ce17d8e = function_f686a55f0291117e();
    armorweaponname = var_1821cb423ce17d8e.armorplateweaponname;
    weaponobj = makeweapon( armorweaponname, attachmentsarr );
    streakinfo = killstreak_utility::createstreakinfo( "", self );
    streakinfo.armorweapon = weaponobj;
    streakinfo.var_53cb7968c54bb61d = val::get( "weapon_switch" ) || val::get( "script_weapon_switch" );
    streakinfo.var_37df6fe5dd599cc0 = 0;
    function_4ea45743d0d10fc0( 1 );
    thread watchcancelnotifies();
    thread watchgameend( streakinfo );
    self.var_d9d0ca76812743fc = self getcurrentweapon();
    switchresult = killstreakdeploy::switchtodeployweapon( weaponobj, streakinfo, &insertarmor, undefined, undefined, undefined, undefined, 0 );
    function_73684d735bbfc62e( self, "Switching to armor weapon with result " + ( switchresult ?? "unknown" ) );
    
    if ( isdefined( switchresult ) && !switchresult )
    {
        self notify( #"try_armor_cancel", "switch_failed" );
    }
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x84e2496a, Offset: 0x4136
// Size: 0x64, Type: bool
function private function_2da49b31fdc4882b( weaponname )
{
    if ( level.gamemodebundle.var_aec4d9d2020f1849 )
    {
        if ( !isxhashasset( weaponname ) )
        {
            weaponname = getxhashasset( weaponname );
        }
        
        if ( weaponname == level.gamemodebundle.var_aec4d9d2020f1849 )
        {
            return true;
        }
    }
    
    return weaponname == "iw9_armor_plate_deploy_mp" || weaponname == "iw9_armor_plate_speed_up_deploy_mp";
}

// Namespace armor
// Params 0, eflags: 0xc
// Checksum 0xd4791a4a, Offset: 0x41a3
// Size: 0x86
function private function_47471ef3973b2d50()
{
    self notify( #"hash_ba5785a8ccc6b24d" );
    self endon( #"hash_ba5785a8ccc6b24d" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"insertArmorComplete" );
    applyarmorcancelplayercommands( 1 );
    val::set( "armor", "weapon_switch", 0 );
    msg = utility::waittill_any_return( "player_switched_weapon", "player_switched_to_grenade", "player_interaction" );
    self notify( #"try_armor_cancel" );
}

// Namespace armor
// Params 0, eflags: 0xc
// Checksum 0xd9961844, Offset: 0x4231
// Size: 0x67
function private function_2c9d11e1e5fb64da()
{
    self notify( #"hash_5f2d0a227fd8aa16" );
    self endon( #"hash_5f2d0a227fd8aa16" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "end_one_hand_armor_insert", "insertArmorComplete", "death", "last_stand_enter" );
    thread function_9db24061984a5290( 1 );
    val::reset( "armor", "weapon_switch" );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x7778b840, Offset: 0x42a0
// Size: 0xc3
function private function_2bc09e274cd103f9()
{
    foreach ( equipment_name in [ "equip_armor_onehanded", "equip_armor_onehanded_quick", "equip_armor_onehanded_quick_30" ] )
    {
        armorweapon = level.equipment.table[ equipment_name ].objweapon;
        
        if ( isdefined( armorweapon ) && self hasweapon( armorweapon ) )
        {
            return armorweapon;
        }
    }
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xbd663c55, Offset: 0x436c
// Size: 0x42
function private function_21291da247b3eea6()
{
    if ( getarmorhealth() < int( self.maxarmorhealth / 3 ) )
    {
        val::reset( "set_heavy_melee_execution", "heavy_melee_execution_victim" );
        return;
    }
    
    val::set( "set_heavy_melee_execution", "heavy_melee_execution_victim", 0 );
}

// Namespace armor
// Params 0
// Checksum 0x6b0244ab, Offset: 0x43b6
// Size: 0x15b
function function_93461bcd5805cfa6()
{
    self endon( #"armor_restoreheldoffhand" );
    self endon( #"death_or_disconnect" );
    var_574ae46f0ed806d = self getheldoffhand();
    
    if ( !isdefined( var_574ae46f0ed806d ) || isnullweapon( var_574ae46f0ed806d ) )
    {
        return;
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( self.var_574ae46f0ed806d );
    
    if ( !isdefined( equipmentref ) )
    {
        return;
    }
    
    if ( equipment_mp::hasequipment( equipmentref ) )
    {
        var_353bde92d62ab2e7 = equipment_mp::getequipmentammo( equipmentref ) ?? 1;
        inventory_utility::_takeweapon( var_574ae46f0ed806d );
        wait 0.05;
        
        if ( equipment_mp::hasequipment( equipmentref ) )
        {
            inventory_utility::_giveweapon( var_574ae46f0ed806d );
            slot = equipment_mp::findequipmentslot( equipmentref );
            assert( isdefined( slot ) && ( slot == "<dev string:x131>" || slot == "<dev string:x139>" ), "<dev string:x143>" + equipmentref + "<dev string:x162>" );
            
            if ( slot == "primary" )
            {
                self assignweaponoffhandprimary( var_574ae46f0ed806d );
            }
            else if ( slot == "secondary" )
            {
                self assignweaponoffhandsecondary( var_574ae46f0ed806d );
            }
            
            equipment_mp::setequipmentammo( equipmentref, var_353bde92d62ab2e7 );
        }
        
        return;
    }
    
    if ( isdefined( level.gametypebundle.pickupgestureweapon ) )
    {
        if ( issameweapon( makeweapon( level.gametypebundle.pickupgestureweapon ), var_574ae46f0ed806d ) )
        {
            self takeweapon( var_574ae46f0ed806d );
        }
    }
}

// Namespace armor
// Params 3
// Checksum 0x9d367a2d, Offset: 0x4519
// Size: 0x1e
function function_1d7e3fe7dfb610bb( equipmentref, slot, objweapon )
{
    
}

// Namespace armor
// Params 2
// Checksum 0x1df8d5d, Offset: 0x453f
// Size: 0x15
function function_174882d3c7ae6c6b( equipmentref, equipmentslot )
{
    
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xff0a44d5, Offset: 0x455c
// Size: 0x28a
function private usearmorplate()
{
    assert( self.maxarmorhealth > 0 );
    
    if ( isdefined( self.armorqueued ) )
    {
        var_e790f293deef7456 = self.armorqueued - 1;
        function_b072d0355af6e535( var_e790f293deef7456 );
    }
    
    newarmorhealth = 0;
    
    if ( isdefined( level.var_6b5a5711823ede8c ) )
    {
        newarmorhealth = self [[ level.var_6b5a5711823ede8c ]]();
    }
    else if ( level.var_69efd410f18748f7 == 1 )
    {
        var_3b4517e2840c4873 = max( 1, function_cb22658f54166b6b() );
        newarmorhealth = int( self.armorhealth + var_3b4517e2840c4873 );
    }
    else
    {
        var_3c4b3ef26764ec25 = self.armorhealth + 5;
        newarmorhealth = clamp( var_3c4b3ef26764ec25, 0, self.maxarmorhealth );
        var_3b4517e2840c4873 = max( 1, function_cb22658f54166b6b() );
        newarmorhealth = int( newarmorhealth / var_3b4517e2840c4873 ) * var_3b4517e2840c4873 + var_3b4517e2840c4873;
    }
    
    if ( isdefined( self.pers[ "telemetry" ] ) && isdefined( self.pers[ "telemetry" ].armor_equipped ) )
    {
        self.pers[ "telemetry" ].armor_equipped++;
    }
    
    setarmorhealth( newarmorhealth );
    currentcount = function_22290101992e4874();
    newcount = maxint( 0, currentcount - 1 );
    function_d3aacadddd06ad10( newcount );
    
    if ( game_utility::function_a43ada404e8c591f() )
    {
        self.pers[ "armor_buy_plates" ] = newcount;
    }
    
    challenges::function_4cfe18f48cc7a55c( self, undefined, level.armorref ?? "equip_armorplate" );
    
    if ( isdefined( self.perks[ "specialty_reduce_regen_delay_on_plate" ] ) && isbrgamemode() )
    {
        if ( !self.isincircle )
        {
            if ( isbrgamemode() )
            {
                playerhealth::forcehealthregen( self, 1, 1 );
            }
            else
            {
                regendelayreduce_delayedregen_cp();
                self notify( #"force_regeneration" );
            }
        }
    }
    
    if ( isdefined( self.armorapplied ) )
    {
        self.armorapplied += 1;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_fb0cbf750a27a0bc" ) )
    {
        utility::callsharedfunc( #"game", #"hash_fb0cbf750a27a0bc" );
    }
    
    callback::callback( #"hash_42a07c459e05796d" );
    self notify( #"armor_plate_inserted" );
    
    if ( getarmorhealth() == self.maxarmorhealth )
    {
        level notify( "equiped_full_armor_" + self.team, self );
    }
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x9a7ca2dd, Offset: 0x47ee
// Size: 0x49
function private regendelayreduce_delayedregen_cp()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"hash_ac4cab938c10995f" );
    self endon( #"hash_ac4cab938c10995f" );
    playerhealth::function_fd91e6d94cab77e7( #"hash_ac4cab938c10995f", 1, 140 );
}

// Namespace armor
// Params 0
// Checksum 0xf735e076, Offset: 0x483f
// Size: 0x20
function function_33fbba4f082f4aec()
{
    return floor( ( self.maxarmorhealth - self.armorhealth ) / function_cb22658f54166b6b() );
}

// Namespace armor
// Params 0
// Checksum 0xf1f2c638, Offset: 0x4868
// Size: 0x6f
function function_cb22658f54166b6b()
{
    if ( isdefined( self.perks[ "specialty_increased_armor_health" ] ) || self.increased_armor_health )
    {
        return int( self.maxarmorhealth / 3 );
    }
    else if ( function_52bd24d06ec049d7() && self.var_cb082b28bfcfde57 && isdefined( self.var_84193fdcc9a49702 ) )
    {
        return [[ self.var_84193fdcc9a49702 ]]();
    }
    
    return level.var_1bfbe247e8d32b1b;
}

// Namespace armor
// Params 0
// Checksum 0x6658f9ec, Offset: 0x48e0
// Size: 0x7
function function_8b76d881e43dd397()
{
    return self function_5250448457db35a2();
}

// Namespace armor
// Params 1
// Checksum 0x55d6ba4e, Offset: 0x48f0
// Size: 0x9f
function function_d1a93ae3582cc2da( reason )
{
    self endon( #"insertArmorComplete" );
    self endon( #"disconnect" );
    
    if ( isdefined( self.currentweapon ) && function_2da49b31fdc4882b( self.currentweapon.basename ) )
    {
        highpriorityweapon = self gethighpriorityweapon();
        
        if ( !isnullweapon( highpriorityweapon ) )
        {
            self clearhighpriorityweapon( highpriorityweapon );
        }
        
        inventory_utility::_takeweapon( self.currentweapon );
        inventory_utility::_switchtoweaponimmediate( self.lastdroppableweaponobj );
    }
    
    self notify( #"armor_cancel", reason );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x6c6b9594, Offset: 0x4997
// Size: 0x135
function private watchcancelnotifies()
{
    self endon( #"insertArmorComplete" );
    self endon( #"disconnect" );
    applyarmorcancelplayercommands();
    thread function_1c35b1b03cd8f3c5();
    thread function_86f11931102fb2a0();
    self.stoparmorinsert = 0;
    
    while ( true )
    {
        childthread function_6ea82c531420f6e();
        childthread function_e902c342f8508dd2();
        self waittill( #"armor_cancel", mainreason, specificreason );
        self notify( #"hash_512ab9f7d8655664" );
        
        if ( mainreason == "try_armor_cancel" && function_8b76d881e43dd397() )
        {
            self setclientomnvar( "ui_armor_forced_notify", gettime() );
            
            if ( self.armorqueued > 1 )
            {
                if ( getdvarint( @"hash_c7714fe0d53c925c", 1 ) == 1 )
                {
                    function_b072d0355af6e535( 1 );
                }
            }
            
            continue;
        }
        
        if ( !isbot( self ) && self.var_8501c5a495b7413d )
        {
            function_5c40d3b27e628a36( mainreason, specificreason );
        }
        
        function_73684d735bbfc62e( self, "Armor cancelled for reason: " + ( mainreason ?? "unknown" ) );
        break;
    }
    
    self notify( #"cancel_all_killstreak_deployments" );
    self.stoparmorinsert = 1;
    self.var_8501c5a495b7413d = 0;
    thread insertarmorcomplete();
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0xab31ea0c, Offset: 0x4ad4
// Size: 0x4f
function private watchgameend( streakinfo )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"armor_plate_done" );
    level waittill( #"game_ended" );
    killstreakdeploy::getridofkillstreakdeployweapon( streakinfo.armorweapon );
}

// Namespace armor
// Params 0, eflags: 0xc
// Checksum 0x3e99219d, Offset: 0x4b2b
// Size: 0x61
function private function_1c35b1b03cd8f3c5()
{
    self notify( #"hash_fc127ee627735f6a" );
    self endon( #"hash_fc127ee627735f6a" );
    self endon( #"disconnect" );
    self endon( #"insertArmorComplete" );
    msg = utility::waittill_any_return( "player_switched_weapon", "player_switched_to_grenade", "player_interaction" );
    self notify( #"try_armor_cancel", msg );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x6b7113e, Offset: 0x4b94
// Size: 0xd1
function private function_86f11931102fb2a0()
{
    self endon( #"disconnect" );
    self endon( #"insertArmorComplete" );
    
    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && !function_2da49b31fdc4882b( self.currentweapon.basename ) )
    {
        if ( self isonladder() )
        {
            self notify( #"try_armor_cancel", "ladder_used" );
        }
        
        waitframe();
    }
    
    while ( isdefined( self.currentweapon ) && function_2da49b31fdc4882b( self.currentweapon.basename ) )
    {
        if ( self isonladder() )
        {
            self notify( #"try_armor_cancel", "ladder_used" );
        }
        
        waitframe();
    }
    
    self notify( #"try_armor_cancel", "armor_unselected" );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x2405d902, Offset: 0x4c6d
// Size: 0x3a
function private function_6ea82c531420f6e()
{
    self endon( #"hash_512ab9f7d8655664" );
    self waittill( #"try_armor_cancel", cancellationreason );
    self notify( #"armor_cancel", "try_armor_cancel", cancellationreason );
}

// Namespace armor
// Params 0, eflags: 0xc
// Checksum 0x637505f3, Offset: 0x4caf
// Size: 0x69
function private function_e902c342f8508dd2()
{
    self notify( #"hash_754754c62073e191" );
    self endon( #"hash_754754c62073e191" );
    self endon( #"hash_512ab9f7d8655664" );
    msg = utility::waittill_any_return( "death", "mantle_start", "last_stand_enter", "scr_change_swim_state", "special_weapon_fired", "armor_plate_done", "skydive_deployparachute" );
    self notify( #"armor_cancel", msg );
}

// Namespace armor
// Params 2, eflags: 0x4
// Checksum 0xbe1e545, Offset: 0x4d20
// Size: 0x5c
function private function_5c40d3b27e628a36( mainreason, specificreason )
{
    telemetrydata = spawnstruct();
    telemetrydata.player = self;
    telemetrydata.mainreason = mainreason;
    telemetrydata.specificreason = specificreason;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_player_armor_auto_apply", telemetrydata );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xd895d72d, Offset: 0x4d84
// Size: 0x9, Type: bool
function private canqueuearmorbydefault()
{
    return !utility::is_player_gamepad_enabled();
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x94a175db, Offset: 0x4d96
// Size: 0x134
function private function_4ea45743d0d10fc0( isusingarmor )
{
    if ( isusingarmor )
    {
        if ( self function_5250448457db35a2() )
        {
            val::set( "armor", "weapon_switch", 0 );
            val::set( "armor", "script_weapon_switch", 0 );
            val::set( "armor", "mantle", 0 );
        }
        
        val::set( "armor", "melee", 0 );
        val::set( "armor", "killstreaks", 0 );
        val::set( "armor", "supers", 0 );
        val::set( "armor", "crate_use", 0 );
        val::set( "armor", "offhand_weapons", 0 );
        val::set( "armor", "offhand_throwback", 0 );
        val::set( "armor", "offhand_weapons", 0 );
        val::set( "armor", "supersprint", 0 );
        
        if ( !level.var_ca972ed4d58fdd30 )
        {
            val::set( "armor", "sprint", 0 );
        }
        
        self function_5e3d4215e59b4473( 0 );
    }
    else
    {
        val::reset_all( "armor" );
        self function_5e3d4215e59b4473( 1 );
    }
    
    self.insertingarmorplate = isusingarmor;
    self setclientomnvar( "ui_inserting_armor_plate", isusingarmor );
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0xc77a36c7, Offset: 0x4ed2
// Size: 0x1f0
function private insertarmor( streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"insertArmorComplete" );
    
    if ( !caninsertarmor() || self.stoparmorinsert )
    {
        return;
    }
    
    currenttime = gettime();
    var_1821cb423ce17d8e = function_f686a55f0291117e();
    var_1c5456e57812327c = currenttime + var_1821cb423ce17d8e.var_64946b5e94b2b140;
    var_b3e5db6969dd616e = var_1821cb423ce17d8e.var_ec446a384416b7d5;
    armorendtime = var_1821cb423ce17d8e.var_64946b5e94b2b140;
    self setclientomnvar( "ui_inserting_armor_plate_timer", var_b3e5db6969dd616e );
    callback::callback( #"hash_6a1b667a8a306b44" );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_combat_action_armor_up" );
    
    while ( currenttime < var_1c5456e57812327c )
    {
        if ( !isdefined( streakinfo.armorweapon ) || streakinfo.armorweapon != self getcurrentweapon() )
        {
            return;
        }
        
        waitframe();
        currenttime = gettime();
    }
    
    usearmorplate();
    self setclientomnvar( "ui_inserting_armor_plate_timer", 0 );
    var_5517460be53dde17 = ( var_b3e5db6969dd616e - armorendtime ) / 1000;
    wait var_5517460be53dde17;
    
    while ( function_6ed236a9c4953f1a() )
    {
        var_1821cb423ce17d8e = function_f686a55f0291117e();
        var_1bdd613a8cee55fc = var_1821cb423ce17d8e.var_c775bc9662041279;
        var_f05d622503456859 = var_1821cb423ce17d8e.var_123322b62e9e145c;
        var_11624a363f806b48 = gettime() + var_f05d622503456859;
        self setclientomnvar( "ui_inserting_armor_plate_timer", var_1bdd613a8cee55fc );
        
        while ( gettime() < var_11624a363f806b48 )
        {
            if ( !isdefined( streakinfo.armorweapon ) || streakinfo.armorweapon != self getcurrentweapon() )
            {
                return;
            }
            
            waitframe();
        }
        
        usearmorplate();
        self setclientomnvar( "ui_inserting_armor_plate_timer", 0 );
        var_3da70c5c0d9aa785 = ( var_1bdd613a8cee55fc - var_f05d622503456859 ) / 1000;
        wait var_3da70c5c0d9aa785;
    }
    
    self notify( #"armor_plate_done" );
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xb83f1343, Offset: 0x50ca
// Size: 0x1b7
function private insertarmorcomplete()
{
    self endon( #"disconnect" );
    self notify( #"insertArmorComplete" );
    val::reset( "armor", "weapon_switch" );
    val::reset( "armor", "script_weapon_switch" );
    
    if ( isdefined( self.currentweapon ) && function_2da49b31fdc4882b( self.currentweapon.basename ) )
    {
        if ( getdvarint( @"scr_use_armor_flow_log", isbrgamemode() ) )
        {
            lastvalidweapon = self.lastdroppableweaponobj;
            
            if ( utility::issharedfuncdefined( #"weapons", #"isCurrentTertiaryWeapon" ) && [[ utility::getsharedfunc( #"weapons", #"isCurrentTertiaryWeapon" ) ]]( self, self.lastnormalweaponobj ) )
            {
                lastvalidweapon = self.lastnormalweaponobj;
            }
            
            function_73684d735bbfc62e( self, "Player trying to switch from armor weapon to " + ( lastvalidweapon ? getweaponbasename( lastvalidweapon ) : "undefined" ) );
        }
        
        if ( isdefined( self.var_d9d0ca76812743fc ) && weapon_utility::isriotshield( self.var_d9d0ca76812743fc ) )
        {
            inventory_utility::_takeweapon( self.currentweapon );
            inventory_utility::domonitoredweaponswitch( self.var_d9d0ca76812743fc );
        }
        else
        {
            killstreakdeploy::getridofkillstreakdeployweapon( self.currentweapon );
        }
        
        function_73684d735bbfc62e( self, "Removed armor weapon from player" );
    }
    
    function_9db24061984a5290();
    val::set( "armor", "supers", 1 );
    
    while ( isdefined( self.currentweapon ) && function_2da49b31fdc4882b( self.currentweapon.basename ) )
    {
        waitframe();
    }
    
    waitframe();
    function_b072d0355af6e535( 0 );
    function_4ea45743d0d10fc0( 0 );
}

// Namespace armor
// Params 0
// Checksum 0xffb6b6fe, Offset: 0x5289
// Size: 0x124, Type: bool
function function_da99cd8fff81be12()
{
    if ( !isalive( self ) || self isparachuting() || self isskydiving() || self isonladder() || self isonascender() )
    {
        return false;
    }
    
    if ( !val::get( "armor" ) )
    {
        return false;
    }
    
    if ( self.inlaststand || isdefined( self.usingremote ) || self.usingascender || player_utility::function_cdedd9a19069ca4c( self ) || self.isjuggernaut || self.carryinghostage )
    {
        return false;
    }
    
    if ( !self.var_41561083a9639b35 && isdefined( self.super ) && self.super.isinuse && !function_d8bdb8f26b3bd15a( self.super.staticdata.ref ) )
    {
        return false;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        seat = vehicle_occupancy::get_occupant_seat( self.vehicle, self );
        
        if ( seat == "driver" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace armor
// Params 0
// Checksum 0x5b0d48db, Offset: 0x53b6
// Size: 0x76, Type: bool
function caninsertarmor()
{
    if ( isdefined( level.zm_mode_modifiers ) && level.zm_mode_modifiers.var_2dc492758425fa76 || self.var_cdbf0145adf184dc )
    {
        return false;
    }
    
    if ( self.armorhealth >= self.maxarmorhealth )
    {
        return false;
    }
    
    currentcount = function_22290101992e4874();
    
    if ( currentcount <= 0 )
    {
        return false;
    }
    
    if ( !function_da99cd8fff81be12() )
    {
        return false;
    }
    
    return true;
}

// Namespace armor
// Params 1
// Checksum 0xdbb1770, Offset: 0x5435
// Size: 0x8a, Type: bool
function function_d8bdb8f26b3bd15a( supername )
{
    if ( !isdefined( supername ) )
    {
        return true;
    }
    
    if ( isdefined( self.super ) && isdefined( self.super.staticdata ) && isdefined( self.super.staticdata.bundle ) && self.super.staticdata.bundle.caninsertarmor )
    {
        return true;
    }
    
    return false;
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0x485ef128, Offset: 0x54c8
// Size: 0x46, Type: bool
function private function_6ed236a9c4953f1a()
{
    if ( !caninsertarmor() )
    {
        return false;
    }
    
    isholdinggamepad = utility::is_player_gamepad_enabled() && self weaponswitchbuttonpressed();
    hasarmorqueue = self.armorqueued > 0;
    return isholdinggamepad || hasarmorqueue;
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0xce13399d, Offset: 0x5517
// Size: 0xbb
function private applyarmorcancelplayercommands( isonehanded )
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "player_switched_weapon", "+weapnext" );
        self notifyonplayercommand( "player_switched_weapon", "+weapprev" );
        self notifyonplayercommand( "player_switched_weapon", "selectweapon1" );
        self notifyonplayercommand( "player_switched_weapon", "selectweapon2" );
        self notifyonplayercommand( "player_switched_weapon", "selectweapon3" );
        self notifyonplayercommand( "player_interaction", "+ads_attack" );
    }
    
    if ( !isonehanded )
    {
        self notifyonplayercommand( "player_interaction", "+attack" );
    }
    
    self notifyonplayercommand( "player_switched_to_grenade", "+smoke" );
    self notifyonplayercommand( "player_switched_to_grenade", "+frag" );
    self notifyonplayercommand( "player_interaction", "+melee_zoom" );
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x373dcdd7, Offset: 0x55da
// Size: 0xbb
function private function_9db24061984a5290( isonehanded )
{
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "player_switched_weapon", "+weapnext" );
        self notifyonplayercommandremove( "player_switched_weapon", "+weapprev" );
        self notifyonplayercommandremove( "player_switched_weapon", "selectweapon1" );
        self notifyonplayercommandremove( "player_switched_weapon", "selectweapon2" );
        self notifyonplayercommandremove( "player_switched_weapon", "selectweapon3" );
        self notifyonplayercommandremove( "player_interaction", "+ads_attack" );
    }
    
    if ( !isonehanded )
    {
        self notifyonplayercommandremove( "player_interaction", "+attack" );
    }
    
    self notifyonplayercommandremove( "player_switched_to_grenade", "+smoke" );
    self notifyonplayercommandremove( "player_switched_to_grenade", "+frag" );
    self notifyonplayercommandremove( "player_interaction", "+melee_zoom" );
}

// Namespace armor
// Params 0
// Checksum 0xda6500ec, Offset: 0x569d
// Size: 0xc, Type: bool
function hashelmet()
{
    return isdefined( self.br_helmetlevel );
}

// Namespace armor
// Params 0
// Checksum 0x8a0dfbb3, Offset: 0x56b2
// Size: 0xd, Type: bool
function hashelmet_agent()
{
    return self.helmethealth > 0;
}

// Namespace armor
// Params 1
// Checksum 0xbf42aab1, Offset: 0x56c8
// Size: 0x4c
function helmetitemtypeforlevel( helmetlevel )
{
    switch ( helmetlevel )
    {
        case 1:
            return "brloot_armor_helmet_1";
        case 2:
            return "brloot_armor_helmet_2";
        case 3:
            return "brloot_armor_helmet_3";
    }
}

// Namespace armor
// Params 2
// Checksum 0x8944a7ae, Offset: 0x571d
// Size: 0x20
function takehelmet( helmetitem, helmetlevel )
{
    self.br_helmetlevel = helmetlevel;
}

// Namespace armor
// Params 1
// Checksum 0xfe6ec28, Offset: 0x5745
// Size: 0x75, Type: bool
function function_df826fddef9a9e3f( armorname )
{
    helmetlevel = 0;
    
    if ( armorname == "equip_helmet_1" )
    {
        helmetlevel = 1;
    }
    else if ( armorname == "equip_helmet_2" )
    {
        helmetlevel = 2;
    }
    else if ( armorname == "equip_helmet_3" )
    {
        helmetlevel = 3;
    }
    
    if ( helmetlevel > 0 )
    {
        if ( !isdefined( self.br_helmetlevel ) || self.br_helmetlevel < helmetlevel )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace armor
// Params 3
// Checksum 0x231f8f98, Offset: 0x57c3
// Size: 0x16a
function damagehelmet_agent( damage, var_a2ad5bdc422fb9ad, attacker )
{
    if ( !isdefined( self.helmethealth ) || self.helmethealth <= 0 )
    {
        return damage;
    }
    
    excessdamage = damage - self.helmethealth;
    self.helmethealth = int( clamp( self.helmethealth - damage, 0, self.maxhelmethealth ) );
    
    if ( self.var_3286ca1ac5a94fb && !self.var_22b2eca117963300 )
    {
        if ( self.helmethealth / self.maxhelmethealth < 0.45 && !self.helmetdamaged && self getscriptablehaspart( "helmet" ) )
        {
            self setscriptablepartstate( "helmet", "damaged" );
            self.helmetdamaged = 1;
        }
    }
    
    if ( self.helmethealth == 0 )
    {
        if ( isdefined( self.var_6252beaf62201a30 ) )
        {
            [[ self.var_6252beaf62201a30 ]]( self, attacker );
        }
        
        if ( !var_a2ad5bdc422fb9ad )
        {
            thread function_56ced462c33a200( attacker );
        }
        
        if ( isdefined( attacker ) )
        {
            attacker.brokehelmet = gettime();
        }
        
        if ( self.var_9592bea2d1afd8d3 )
        {
            return 0;
        }
        
        return excessdamage;
    }
    
    if ( isdefined( attacker ) )
    {
        attacker.hithelmet = gettime();
        thread function_c54cad5aa84d72eb( attacker );
    }
    
    return 0;
}

// Namespace armor
// Params 1
// Checksum 0xd9ba1a83, Offset: 0x5936
// Size: 0x58
function function_c54cad5aa84d72eb( attacker )
{
    wait 0.15;
    
    if ( isalive( self ) )
    {
        if ( isplayer( attacker ) && isalive( attacker ) )
        {
            attacker playsoundtoplayer( "bullet_plr_helmet_impact", attacker, self );
            self playsound( "bullet_npc_helmet_impact", attacker, self );
            return;
        }
        
        self playsound( "bullet_npc_helmet_impact" );
    }
}

// Namespace armor
// Params 1
// Checksum 0x98aee827, Offset: 0x5996
// Size: 0x73
function function_56ced462c33a200( attacker )
{
    wait 0.15;
    
    if ( isalive( self ) )
    {
        if ( isplayer( attacker ) && isalive( attacker ) )
        {
            attacker playsoundtoplayer( "bullet_plr_helmet_break", attacker, self );
            
            if ( soundexists( "mp_helmet_break_alert" ) )
            {
                attacker playsoundtoplayer( "mp_helmet_break_alert", attacker, self );
            }
            
            self playsound( "bullet_npc_helmet_break", attacker, self );
            return;
        }
        
        self playsound( "bullet_npc_helmet_break" );
    }
}

// Namespace armor
// Params 3
// Checksum 0x2453c31b, Offset: 0x5a11
// Size: 0xc6
function damagehelmet( damage, snipershot, impactdir )
{
    if ( !isdefined( snipershot ) || !level.var_2d63618f49cb3b63 )
    {
        snipershot = 0;
    }
    
    damagereduction = 1;
    
    switch ( self.br_helmetlevel )
    {
        case 1:
            damagereduction = 0.85;
            break;
        case 2:
            damagereduction = 0.7;
            break;
        case 3:
            damagereduction = 0.7;
            break;
        default:
            break;
    }
    
    if ( snipershot )
    {
        if ( isdefined( level.onhelmetsniped ) )
        {
            [[ level.onhelmetsniped ]]( self, impactdir );
        }
    }
    
    return damagereduction;
}

// Namespace armor
// Params 3, eflags: 0x4
// Checksum 0x4b295ea9, Offset: 0x5ae0
// Size: 0x195
function private popoffhelmet( impactdir, playerangles, playerorigin )
{
    level endon( #"game_ended" );
    helmettag = self gettagorigin( "j_helmet" );
    
    if ( !isdefined( helmettag ) )
    {
        helmettag = playerorigin + ( 0, 0, 80 );
    }
    
    helmet = spawn( "script_model", self gettagorigin( "j_helmet" ) );
    helmet setmodel( "loot_helmet" );
    helmet.angles = playerangles;
    up = anglestoup( playerangles );
    forward = impactdir;
    vel = vectornormalize( forward + up ) * 2500;
    helmet physicslaunchserver( helmet.origin, vel );
    var_60f1c68fe71a0a7e = 15;
    var_1aac024883ef8293 = 0.1;
    var_60f1c68fe71a0a7e *= 1 / var_1aac024883ef8293;
    previousorigin = helmet.origin;
    
    for ( i = 0; i < var_60f1c68fe71a0a7e ; i++ )
    {
        wait var_1aac024883ef8293;
        compareorigin = previousorigin - helmet.origin;
        
        if ( compareorigin[ 0 ] < 2 && compareorigin[ 1 ] < 2 && compareorigin[ 2 ] < 2 && compareorigin[ 0 ] > -2 && compareorigin[ 1 ] > -2 && compareorigin[ 2 ] > -2 )
        {
            return;
        }
        
        previousorigin = helmet.origin;
    }
    
    helmet delete();
}

// Namespace armor
// Params 2, eflags: 0x4
// Checksum 0xeef2d971, Offset: 0x5c7d
// Size: 0x45
function private onhelmetsniped( victim, impactdir )
{
    if ( isdefined( victim ) )
    {
        victim thread popoffhelmet( impactdir, victim.angles, victim.origin );
    }
    
    self.br_helmetlevel = undefined;
}

// Namespace armor
// Params 0
// Checksum 0xd1aac7b3, Offset: 0x5cca
// Size: 0x4e, Type: bool
function function_c600b2d5e82ce2d5()
{
    if ( isalive( self ) && isdefined( self.armorhealth ) && self.armorhealth < self.maxarmorhealth )
    {
        return true;
    }
    else if ( self.pers[ "armor_buy_plates_instant" ] < 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace armor
// Params 0
// Checksum 0x8f822f7, Offset: 0x5d21
// Size: 0x81
function function_dafd2aecc00237e1()
{
    level endon( #"game_ended" );
    self notify( #"hash_7ad850e6fd0243fd" );
    self endon( #"hash_7ad850e6fd0243fd" );
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    waitframe();
    setarmorhealth( int( clamp( self.armorhealth + self.pers[ "armor_buy_plates_instant" ] * level.var_1bfbe247e8d32b1b, 0, self.maxarmorhealth ) ) );
    self.pers[ "armor_buy_plates_instant" ] = 0;
}

// Namespace armor
// Params 12
// Checksum 0xc80976a9, Offset: 0x5daa
// Size: 0x78c
function function_4875d04d69b22ae( attacker, inflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, unmodifieddamage, partname, calculateonly )
{
    healthdamage = idamage;
    scaleddamage = idamage;
    armordamage = 0;
    lethaldamage = 0;
    
    if ( !level.allowarmor )
    {
        return [ healthdamage, armordamage ];
    }
    
    var_7c3f909210c03e9e = victim hasarmor();
    
    if ( isplayer( attacker ) )
    {
        armorvest_clearhit( attacker );
        armorvest_clearbroke( attacker );
    }
    
    if ( var_7c3f909210c03e9e )
    {
        var_46fe195608b63dbf = function_72d28a46c7d67ff6( attacker, victim, objweapon, smeansofdeath, shitloc, idflags );
        
        if ( !var_46fe195608b63dbf )
        {
            weaponrootname = weapon::getweaponrootname( objweapon );
            weapontype = weaponclass( objweapon );
            var_dab25f734d960262 = function_d0f7407d5f8aaa05( objweapon, weaponrootname, weapontype, smeansofdeath );
            
            if ( smeansofdeath == "MOD_RIFLE_BULLET" && !weapon_utility::isgrenadeweapon( objweapon ) && !weapon_utility::isoffhandweapon( objweapon ) )
            {
                scaleddamage = function_97d9f21c9b1aa9e5( attacker, victim, idflags, scaleddamage, objweapon, smeansofdeath, unmodifieddamage );
                
                if ( function_d00f463957b6cb31( objweapon ) )
                {
                    scaleddamage = function_622c79a346c34eb8( idamage, scaleddamage, attacker, victim, idflags );
                }
            }
            else
            {
                if ( weapon_utility::function_c1972d0d01397a22( objweapon ) && function_1bd5131bdb52924d( attacker, victim ) )
                {
                    scaleddamage = launcherdamagemod( scaleddamage, weaponrootname );
                }
                
                if ( getdvarint( @"hash_d216c825aefa6666", 0 ) && weapon_utility::isoffhandweapon( objweapon ) && function_1bd5131bdb52924d( attacker, victim ) && objweapon.basename != "dragonsbreath_mp" && objweapon.basename != "shock_thunder_mp_br" )
                {
                    scaleddamage = equipmentdamagemod( scaleddamage, weaponrootname );
                }
                
                if ( getdvarint( @"hash_b39c4bff0da4c703", 0 ) && objweapon == level.defaultknifestab && scaleddamage > 135 )
                {
                    scaleddamage = 135;
                }
                
                if ( weaponrootname == "assault_drone_mp" )
                {
                    scaleddamage = assault_drone::function_9b5a8615192cc2f6( inflictor, victim, scaleddamage );
                    healthdamage = scaleddamage;
                }
                else if ( isplayer( victim ) )
                {
                    var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
                    
                    if ( isexplosivedamagemod( smeansofdeath ) )
                    {
                        switch ( weaponrootname )
                        {
                            case #"hash_e5bd5c73b30f4a5":
                            case #"hash_4b87af60037f526f":
                            case #"hash_6547ec525f1340da":
                            case #"hash_a009d256608f52ce":
                            case #"hash_c4b9b21ecac2ced4":
                            case #"hash_d6565ec12efca627":
                                if ( var_ec636abdcf08f7b3 )
                                {
                                    lethaldamage = 1;
                                }
                                
                                break;
                        }
                    }
                    else if ( utility::isimpactdamage( smeansofdeath ) )
                    {
                        switch ( weaponrootname )
                        {
                            case #"hash_34f28162f0f54c6e":
                                if ( damage_utility::function_5d1c04cbc4da6bc4( partname ) || damage_utility::function_facff8bb3d8f891b( partname ) )
                                {
                                    lethaldamage = 1;
                                }
                                
                                break;
                            case #"hash_617feab345ee4f01":
                                if ( damage_utility::function_5d1c04cbc4da6bc4( partname ) )
                                {
                                    lethaldamage = 1;
                                }
                                else if ( damage_utility::function_facff8bb3d8f891b( partname ) )
                                {
                                    scaleddamage = throwstar::function_2e8bc5f09830ff4a();
                                    healthdamage = scaleddamage;
                                }
                                
                                break;
                        }
                    }
                    
                    var_fc609577baf87f68 = lethaldamage && ( !victim.gulag || victim.gulagarena );
                    
                    if ( var_fc609577baf87f68 )
                    {
                        scaleddamage = victim getarmorhealth() + victim.health + 100;
                        healthdamage = scaleddamage;
                    }
                }
            }
            
            if ( smeansofdeath == "MOD_RIFLE_BULLET" )
            {
                scaleddamage = function_4fad8dedc2819f14( attacker, objweapon, smeansofdeath, scaleddamage, var_cdd29ad5d1362c2 );
            }
            
            if ( weaponrootname == "iw9_dm_crossbow" )
            {
                scaleddamage = crossbowdamagemod( scaleddamage, objweapon );
            }
            
            if ( !var_46fe195608b63dbf )
            {
                excessdamage = victim damagearmor( scaleddamage, function_af2c3efc170be304(), attacker, smeansofdeath, undefined, calculateonly, inflictor, objweapon );
            }
            else
            {
                excessdamage = scaleddamage;
            }
            
            armordamage = int( scaleddamage - excessdamage );
            healthdamage = function_56e9bdaa07312281( healthdamage, scaleddamage, excessdamage, armordamage );
            
            if ( var_7c3f909210c03e9e )
            {
                victim.tookvesthit = 1;
                
                if ( isdefined( attacker ) && isdefined( attacker.owner ) && isdefined( inflictor ) && isdefined( inflictor.streakinfo ) && !isplayer( attacker ) )
                {
                    attacker = attacker.owner;
                }
                
                if ( isplayer( attacker ) )
                {
                    armorvest_sethit( attacker );
                    
                    if ( !victim hasarmor() )
                    {
                        armorvest_setbroke( attacker );
                    }
                }
            }
            
            if ( function_d00f463957b6cb31( objweapon ) && smeansofdeath == "MOD_RIFLE_BULLET" )
            {
                function_e57d8181c5a30935( attacker, victim, idflags, scaleddamage, int( healthdamage + armordamage ), objweapon );
            }
            else
            {
                shouldOhkProtect = function_6663e8f14900ff75( smeansofdeath, objweapon, weaponrootname, victim ) && armordamage >= 150;
                var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
                stuckexplosive = var_ec636abdcf08f7b3 && isexplosivedamagemod( smeansofdeath );
                var_220dd947f21ef0a6 = stuckexplosive && getdvarint( @"hash_5c2f4df8bafb4fc0", 1 ) && isdefined( victim.perks[ "specialty_blastshield" ] ) && armordamage >= 130;
                var_aedb662f73402bb8 = level.var_22a02f4a2b8f0faa && isdefined( victim.platecarrierlevel ) && victim function_3988e68b87d5acc0() >= function_bc6363e19ce42a9a();
                doscoreevents = 0;
                
                if ( var_aedb662f73402bb8 )
                {
                    if ( shouldOhkProtect )
                    {
                        if ( healthdamage >= victim.health && !var_dab25f734d960262 )
                        {
                            healthdamage = int( clamp( healthdamage, 0, max( 0, victim.health - 10 ) ) );
                            doscoreevents = 1;
                            
                            if ( function_1dbd044b2950089a( victim, smeansofdeath, objweapon ) )
                            {
                                victim utility::callsharedfunc( #"specialty_one_shot_protection", #"activate" );
                                hitmarker = "hitohkprotect";
                                
                                if ( utility::callsharedfunc( #"hitmarker", #"hash_f905067ba8726ab4", hitmarker ) )
                                {
                                    attacker.var_82381c5b677c4f5f = hitmarker;
                                }
                            }
                        }
                    }
                    else if ( var_220dd947f21ef0a6 )
                    {
                        if ( healthdamage >= victim.health )
                        {
                            healthdamage = int( clamp( healthdamage, 0, max( 0, victim.health - 15 ) ) );
                            
                            if ( isdefined( victim.perks[ "specialty_bomb_squad" ] ) )
                            {
                                victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_bomb_squad" );
                            }
                            else if ( isdefined( victim.perks[ "specialty_eod" ] ) )
                            {
                                victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_eod" );
                            }
                            
                            doscoreevents = 1;
                        }
                    }
                    
                    if ( doscoreevents )
                    {
                        if ( healthdamage < victim.health && isplayer( attacker ) && attacker != victim && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                        {
                            if ( victim.platecarriertype == "brloot_plate_carrier_tempered" )
                            {
                                attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"br_tempered_plate_broken" );
                            }
                        }
                    }
                }
            }
        }
    }
    
    function_21291da247b3eea6();
    return [ healthdamage, armordamage ];
}

// Namespace armor
// Params 4
// Checksum 0x6c05e099, Offset: 0x653f
// Size: 0x6a
function function_56e9bdaa07312281( idamage, scaleddamage, excessdamage, armordamage )
{
    if ( excessdamage > 0 )
    {
        if ( scaleddamage != 0 )
        {
            var_bb030e4fb2baa1c9 = armordamage / scaleddamage;
        }
        else
        {
            var_bb030e4fb2baa1c9 = 0;
        }
        
        modifieddamage = round( idamage * ( 1 - var_bb030e4fb2baa1c9 ) );
    }
    else
    {
        modifieddamage = excessdamage;
    }
    
    return modifieddamage;
}

// Namespace armor
// Params 5
// Checksum 0x71b9853d, Offset: 0x65b2
// Size: 0x81
function function_622c79a346c34eb8( idamage, scaleddamage, eattacker, victim, idflags )
{
    /#
        if ( scaleddamage < idamage )
        {
            assertmsg( "<dev string:x17d>" );
        }
    #/
    
    if ( scaleddamage > idamage )
    {
        weapon_utility::function_853dbbe8f0c9de3( eattacker, victim, idflags, scaleddamage );
        var_f80120c81c8bf08d = scaleddamage - idamage;
        var_f80120c81c8bf08d = weapon_utility::function_ceb194a906bf4a4c( eattacker, victim, idflags, var_f80120c81c8bf08d );
        scaleddamage = idamage + var_f80120c81c8bf08d;
    }
    
    return scaleddamage;
}

// Namespace armor
// Params 6
// Checksum 0xc36c4e04, Offset: 0x663c
// Size: 0x72
function function_e57d8181c5a30935( attacker, victim, idflags, scaleddamage, actualdamagedealt, objweapon )
{
    /#
        if ( actualdamagedealt > scaleddamage )
        {
            assertmsg( "<dev string:x1f1>" + objweapon.basename );
        }
    #/
    
    if ( actualdamagedealt < scaleddamage )
    {
        weapon_utility::function_f6354e5e65144a2e( attacker, victim, idflags, actualdamagedealt - scaleddamage );
    }
}

// Namespace armor
// Params 10
// Checksum 0xb1e9de00, Offset: 0x66b6
// Size: 0x15a
function modifyhelmetdamage( attacker, inflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, skipclamp )
{
    modifieddamage = idamage;
    helmetdamage = 0;
    hashelmet = victim hashelmet_agent();
    
    if ( hashelmet )
    {
        var_72d28a46c7d67ff6 = function_98f284562212c6e0( objweapon, smeansofdeath, idflags );
        hitshield = shitloc == "shield" && smeansofdeath != "MOD_GRENADE_SPLASH";
        
        if ( !var_72d28a46c7d67ff6 && !victim.inlaststand && !hitshield )
        {
            weaponrootname = weapon::getweaponrootname( objweapon );
            weapontype = weaponclass( objweapon );
            scaleddamage = skipclamp ? var_cdd29ad5d1362c2 : function_cb640965e86c8951( attacker, idflags, weapontype, weaponrootname, shitloc, var_cdd29ad5d1362c2, idamage, objweapon, smeansofdeath );
            excessdamage = victim damagehelmet_agent( scaleddamage, function_af2c3efc170be304(), attacker );
            helmetdamage = int( scaleddamage - excessdamage );
            modifieddamage = excessdamage;
        }
    }
    
    return [ modifieddamage, helmetdamage ];
}

// Namespace armor
// Params 1
// Checksum 0x7b0b67e4, Offset: 0x6819
// Size: 0x18, Type: bool
function isbulletpenetration( idflags )
{
    return isdefined( idflags ) && idflags & 8;
}

// Namespace armor
// Params 7
// Checksum 0xda382ad3, Offset: 0x683a
// Size: 0x69
function function_97d9f21c9b1aa9e5( attacker, victim, idflags, idamage, objweapon, smeansofdeath, unmodifieddamage = idamage )
{
    idamage = function_76e85d041a115c8b( attacker, victim, idflags, idamage, objweapon, unmodifieddamage );
    idamage = function_be05e3343d6470c9( idamage, objweapon, unmodifieddamage );
    return idamage;
}

// Namespace armor
// Params 5
// Checksum 0x6b3c4f4f, Offset: 0x68ac
// Size: 0x5a
function function_4fad8dedc2819f14( attacker, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2 )
{
    idamage = damage::handleapammodamage( objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2 );
    idamage = damage::handleapdamage( objweapon, smeansofdeath, idamage, attacker, self );
    idamage = damage::function_ea2af1be925ed0ea( objweapon, idamage );
    return idamage;
}

// Namespace armor
// Params 6
// Checksum 0x499112cf, Offset: 0x690f
// Size: 0xa6
function function_76e85d041a115c8b( attacker, victim, idflags, idamage, objweapon, unmodifieddamage )
{
    var_7c200c7d9d8c01ec = objweapon function_c4ba558eea7af08f();
    
    if ( function_d00f463957b6cb31( objweapon ) && var_7c200c7d9d8c01ec > -1 )
    {
        if ( weapon_utility::function_433cd8ffe864ddc8( attacker, victim, idflags ) )
        {
            return idamage;
        }
    }
    
    modifieddamagescale = 0;
    
    if ( unmodifieddamage != 0 )
    {
        modifieddamagescale = idamage / unmodifieddamage;
    }
    else
    {
        modifieddamagescale = 1;
    }
    
    if ( var_7c200c7d9d8c01ec > -1 && unmodifieddamage < var_7c200c7d9d8c01ec )
    {
        idamage = var_7c200c7d9d8c01ec * modifieddamagescale;
    }
    
    return idamage;
}

// Namespace armor
// Params 3
// Checksum 0xbe28ca28, Offset: 0x69be
// Size: 0x7b
function function_be05e3343d6470c9( idamage, objweapon, unmodifieddamage )
{
    maxarmorclamp = objweapon function_aba0cca397d5e65b();
    
    if ( function_d00f463957b6cb31( objweapon ) && maxarmorclamp > 0 )
    {
        assertmsg( "<dev string:x29a>" + objweapon.basename + "<dev string:x2aa>" );
        maxarmorclamp = -1;
    }
    
    if ( maxarmorclamp > 0 && idamage > maxarmorclamp )
    {
        idamage = maxarmorclamp;
    }
    
    return idamage;
}

// Namespace armor
// Params 9
// Checksum 0x76134cc9, Offset: 0x6a42
// Size: 0x65
function function_cb640965e86c8951( attacker, idflags, weapontype, weaponrootname, shitloc, var_cdd29ad5d1362c2, idamage, objweapon, smeansofdeath )
{
    idamage = damage::handleapdamage( objweapon, smeansofdeath, idamage, attacker, self );
    return idamage;
}

// Namespace armor
// Params 4
// Checksum 0x431728ae, Offset: 0x6ab0
// Size: 0xc7
function clampstepdamage( var_cdd29ad5d1362c2, weapon, stepclamp, idflags )
{
    var_551535f4a3ade4ad = 0;
    
    if ( idflags & 262144 )
    {
        weapondamagetype = 2;
    }
    else
    {
        weapondamagetype = 0;
    }
    
    if ( stepclamp == 4 )
    {
        var_551535f4a3ade4ad = weapon getmid3damage( weapondamagetype );
    }
    else if ( stepclamp == 3 )
    {
        var_551535f4a3ade4ad = weapon getmid2damage( weapondamagetype );
    }
    else if ( stepclamp == 2 )
    {
        var_551535f4a3ade4ad = weapon getmid1damage( weapondamagetype );
    }
    
    if ( var_551535f4a3ade4ad <= 0 )
    {
        var_551535f4a3ade4ad = weapon getmindamage( weapondamagetype );
    }
    
    if ( stepclamp == 1 || var_551535f4a3ade4ad <= 0 )
    {
        var_551535f4a3ade4ad = weapon getmaxdamage( weapondamagetype );
    }
    
    if ( var_cdd29ad5d1362c2 < var_551535f4a3ade4ad )
    {
        return int( var_551535f4a3ade4ad );
    }
    
    return var_cdd29ad5d1362c2;
}

// Namespace armor
// Params 6
// Checksum 0xa472c6e8, Offset: 0x6b7f
// Size: 0xcc, Type: bool
function function_72d28a46c7d67ff6( attacker, victim, objweapon, smeansofdeath, shitloc, idflags )
{
    hitshield = shitloc == "shield" && smeansofdeath != "MOD_GRENADE_SPLASH" && !isdefined( victim.forcehitlocation );
    return function_98f284562212c6e0( objweapon, smeansofdeath, idflags, victim ) || victim.inlaststand || hitshield || victim.var_abdb15f3972c9de3 || isplayer( attacker ) && level.var_501ea37588bd0a84 && attacker.team != victim.team;
}

// Namespace armor
// Params 4
// Checksum 0x9b745dfd, Offset: 0x6c54
// Size: 0x132, Type: bool
function function_98f284562212c6e0( objweapon, smeansofdeath, idflags, victim )
{
    var_eadb663a1292c9e8 = objweapon.basenamehash;
    
    if ( var_eadb663a1292c9e8 == %"danger_circle_br" || var_eadb663a1292c9e8 == %"shock_thunder_mp_br" || var_eadb663a1292c9e8 == %"rex_radiation_dmz" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_UNKNOWN" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_SUICIDE" )
    {
        return true;
    }
    
    if ( isdefined( objweapon.basename ) && isdefined( level.var_35e19e0af705d62e ) && arraycontains( level.var_35e19e0af705d62e, objweapon.basename ) )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_6e7cd93ad8b76500", 0 ) != 0 )
    {
        if ( isdefined( idflags ) && idflags & 2 && !function_1dbd044b2950089a( victim, smeansofdeath, objweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace armor
// Params 1
// Checksum 0x9c07b2b1, Offset: 0x6d8f
// Size: 0x1c, Type: bool
function armorvest_washit( attacker )
{
    return gettime() == attacker.hitarmorvest;
}

// Namespace armor
// Params 1
// Checksum 0x6fc16eb6, Offset: 0x6db4
// Size: 0x1c
function armorvest_sethit( attacker )
{
    attacker.hitarmorvest = gettime();
}

// Namespace armor
// Params 1
// Checksum 0x4c6674e8, Offset: 0x6dd8
// Size: 0x17
function armorvest_clearhit( attacker )
{
    attacker.hitarmorvest = undefined;
}

// Namespace armor
// Params 1
// Checksum 0x6c26c7d8, Offset: 0x6df7
// Size: 0x1c, Type: bool
function armorvest_wasbroke( attacker )
{
    return gettime() == attacker.brokearmorvest;
}

// Namespace armor
// Params 1
// Checksum 0x126dde1, Offset: 0x6e1c
// Size: 0x1c
function armorvest_setbroke( attacker )
{
    attacker.brokearmorvest = gettime();
}

// Namespace armor
// Params 1
// Checksum 0x6e07ce5a, Offset: 0x6e40
// Size: 0x17
function armorvest_clearbroke( attacker )
{
    attacker.brokearmorvest = undefined;
}

// Namespace armor
// Params 0
// Checksum 0xaf4e5d41, Offset: 0x6e5f
// Size: 0xc, Type: bool
function function_af2c3efc170be304()
{
    return istrue( level.var_83afcf8757e058d3 );
}

// Namespace armor
// Params 0
// Checksum 0x6d887317, Offset: 0x6e74
// Size: 0x19, Type: bool
function function_389e3b45d147d61f()
{
    return !self.var_640934ba73e304d6 || level.var_93a154a544c40343;
}

// Namespace armor
// Params 0
// Checksum 0x9bbac1d0, Offset: 0x6e96
// Size: 0x1c, Type: bool
function has_full_armor()
{
    if ( self.armorhealth == self.maxarmorhealth )
    {
        return true;
    }
    
    return false;
}

// Namespace armor
// Params 1
// Checksum 0x7f750809, Offset: 0x6ebb
// Size: 0x2d
function repair_armor( amountrepair )
{
    newarmorhealth = self.armorhealth + amountrepair;
    setarmorhealth( newarmorhealth );
}

// Namespace armor
// Params 4
// Checksum 0xff39e4a5, Offset: 0x6ef0
// Size: 0xdc
function function_6663e8f14900ff75( smeansofdeath, objweapon, weaponrootname, victim )
{
    if ( function_1dbd044b2950089a( victim, smeansofdeath, objweapon ) )
    {
        return 1;
    }
    
    if ( ( weaponrootname == "sat_sh_corso" || weaponrootname == "sat_claymore" ) && !level.var_7de0db416e5d903b )
    {
        return 0;
    }
    
    if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || weaponrootname == "assault_drone_mp" )
    {
        return 1;
    }
    
    if ( weapon_utility::function_c1972d0d01397a22( objweapon ) )
    {
        if ( level.var_7de0db416e5d903b || getdvarint( @"hash_6eba4697f8459b88", 0 ) && isdefined( victim.perks[ "specialty_blastshield" ] ) )
        {
            return 1;
        }
    }
    
    if ( objweapon.inventorytype == "offhand" )
    {
        return 0;
    }
}

// Namespace armor
// Params 4
// Checksum 0x37d91bff, Offset: 0x6fd4
// Size: 0xa1
function function_d0f7407d5f8aaa05( objweapon, weaponrootname, weapontype, smeansofdeath )
{
    if ( level.var_7de0db416e5d903b )
    {
        return 0;
    }
    
    if ( function_1dbd044b2950089a( self, smeansofdeath, objweapon ) && ( self.armorhealth >= self.maxarmorhealth || self.armorhealth >= self.var_7b69ed83088299c2 ) )
    {
        return 0;
    }
    
    if ( weaponrootname == "iw9_dm_crossbow" )
    {
        return 1;
    }
    
    if ( weapontype == "sniper" )
    {
        return 1;
    }
    
    if ( weapontype == "shotgun" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace armor
// Params 3
// Checksum 0x8a6a279d, Offset: 0x707d
// Size: 0x58, Type: bool
function function_1dbd044b2950089a( victim, smeansofdeath, objweapon )
{
    return ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || weaponclass( objweapon ) == "spread" ) && isdefined( victim.perks[ "specialty_one_shot_protection" ] );
}

// Namespace armor
// Params 2
// Checksum 0xcf710663, Offset: 0x70de
// Size: 0x118
function crossbowdamagemod( scaleddamage, objweapon )
{
    modifier = 2;
    exitloop = 0;
    
    foreach ( i in objweapon.attachmentshash )
    {
        if ( exitloop )
        {
            break;
        }
        
        switch ( i )
        {
            case %"ammo_bolt_db":
                modifier = 1.9;
                exitloop = 1;
                break;
            case %"ammo_bolt_he":
                modifier = 1.21;
                exitloop = 1;
                break;
            case %"ammo_bolt_gas":
                modifier = 1.9;
                exitloop = 1;
                break;
            default:
                break;
        }
    }
    
    return int( scaleddamage * modifier );
}

// Namespace armor
// Params 2
// Checksum 0xdd7270df, Offset: 0x71ff
// Size: 0xd4
function equipmentdamagemod( scaleddamage, weaponrootname )
{
    switch ( weaponrootname )
    {
        case #"hash_6a2e4f9c54756dc7":
            modifier = 0.9;
            break;
        case #"hash_5701898d598fdb27":
            modifier = 0.9;
            break;
        case #"hash_34f28162f0f54c6e":
            modifier = 0.8;
            break;
        case #"hash_e5bd5c73b30f4a5":
        case #"hash_4b87af60037f526f":
            modifier = 1.43;
            break;
        case #"hash_f4d2562ef860c1c0":
            modifier = 0.6;
            break;
        case #"hash_6547ec525f1340da":
            modifier = 0.75;
            break;
        default:
            modifier = 1;
            break;
    }
    
    return int( scaleddamage * modifier );
}

// Namespace armor
// Params 2
// Checksum 0x90cc8840, Offset: 0x72dc
// Size: 0xb2
function launcherdamagemod( damage, weaponrootname )
{
    switch ( weaponrootname )
    {
        case #"hash_390ba811ad3f09bc":
            modifier = 0.91;
            break;
        case #"hash_aa607c134dcb8620":
            modifier = 0.86;
            break;
        case #"hash_607145e68712971c":
            modifier = 0.93;
            break;
        case #"hash_326dc2026394652a":
            modifier = 0.95;
            break;
        case #"hash_60bbbd68c3990680":
            modifier = 0.97;
            break;
        default:
            modifier = 1;
            break;
    }
    
    return int( damage * modifier );
}

// Namespace armor
// Params 1
// Checksum 0xc95e8d6c, Offset: 0x7397
// Size: 0xc3, Type: bool
function function_eecfbcb181240dd9( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( !isdefined( weapon.basename ) )
    {
        return false;
    }
    
    switch ( weapon.basename )
    {
        case #"hash_533ad89345613b09":
        case #"hash_af345b501b6a180f":
            return true;
    }
    
    if ( level.gamemodebundle.var_aec4d9d2020f1849 )
    {
        weaponname = weapon.basename;
        
        if ( !isxhashasset( weapon.basename ) )
        {
            weaponname = getxhashasset( weapon.basename );
        }
        
        if ( weaponname == level.gamemodebundle.var_aec4d9d2020f1849 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace armor
// Params 2
// Checksum 0xff00c41f, Offset: 0x7463
// Size: 0x2c, Type: bool
function function_1bd5131bdb52924d( attacker, victim )
{
    if ( isplayer( attacker ) && isplayer( victim ) )
    {
        return true;
    }
    
    return false;
}

// Namespace armor
// Params 1
// Checksum 0x5c053b64, Offset: 0x7498
// Size: 0xee
function function_d8063ec237cd944b( player )
{
    if ( !isdefined( player.platecarriertype ) )
    {
        return 0;
    }
    
    if ( isdefined( level.var_24f2fe5e7b8ea9af[ player.platecarriertype ] ) )
    {
        return level.var_24f2fe5e7b8ea9af[ player.platecarriertype ];
    }
    
    switch ( player.platecarriertype )
    {
        case #"hash_49abfc464753a72c":
            return 1;
        case #"hash_5eaf58877df11b20":
        case #"hash_fbae0f57891595ff":
            return 3;
        case #"hash_4c062079f36e03d6":
        case #"hash_7a904628e42163fd":
            return 2;
        case #"hash_e0c249ab38dcf963":
        case #"hash_ed2b8ec873f222c8":
            return 4;
        case #"hash_da7d38f29eddc709":
            return 5;
        case #"hash_e83d0116aca94743":
            return 6;
        default:
            break;
    }
    
    return 0;
}

// Namespace armor
// Params 1
// Checksum 0x9353df3f, Offset: 0x758f
// Size: 0x1f, Type: bool
function function_d00f463957b6cb31( objweapon )
{
    return isdefined( objweapon ) && weaponclass( objweapon ) == "spread";
}

// Namespace armor
// Params 0
// Checksum 0xe1c9c276, Offset: 0x75b7
// Size: 0x4f
function function_52bd24d06ec049d7()
{
    if ( !isdefined( level.var_5c7269a460306111 ) )
    {
        var_9a6bbd0b0ef0d7bc = getmatchrulesdata( "commonOption", "plateCarrierVariantsEnabled" );
        level.var_5c7269a460306111 = getdvarint( @"hash_aac1a4ea32cf003a", var_9a6bbd0b0ef0d7bc ?? 0 );
    }
    
    return level.var_5c7269a460306111;
}

/#

    // Namespace armor
    // Params 0, eflags: 0x4
    // Checksum 0xc6f17cc6, Offset: 0x760f
    // Size: 0xc, Type: dev
    function private function_956e9e759d3ca0ec()
    {
        assert( isdefined( level ) );
    }

#/

// Namespace armor
// Params 0
// Checksum 0xca1c31ca, Offset: 0x7623
// Size: 0x75
function function_d3aa416001bf116c()
{
    armorplatelootid = 0;
    
    if ( common_item::items_isenabled() )
    {
        armorplatelootid = common_item::items_getlootidfromref( level.armorref ?? "equip_armorplate" );
    }
    else
    {
        armorplatelootid = function_5bc2f16f9885ef8c();
    }
    
    if ( utility::issharedfuncdefined( #"backpack", #"gettotalitemcountinbag" ) )
    {
        return [[ utility::getsharedfunc( #"backpack", #"gettotalitemcountinbag" ) ]]( armorplatelootid );
    }
    
    return 0;
}

// Namespace armor
// Params 0
// Checksum 0x8632a7c3, Offset: 0x76a1
// Size: 0xd
function function_5bc2f16f9885ef8c()
{
    return loot::getlootidfromref( "armor_plate" );
}

// Namespace armor
// Params 5
// Checksum 0x5766ecf9, Offset: 0x76b7
// Size: 0xce
function function_2e65f2dc03880e80( var_515f0d7a8e599564 = 1400, var_de0ac78a9121e969 = 1300, var_4003698bf24495fc = 1000, var_27014a53ab7b7c1 = 900, var_5392fef732673271 = "iw9_armor_plate_deploy_mp" )
{
    return { #var_b4d4fbadf51eda6:1125, #var_7e97fa2c45400bde:1300, #var_f2e3f7eb442cc197:1400, #armorplateweaponname:var_5392fef732673271, #var_123322b62e9e145c:var_27014a53ab7b7c1, #var_c775bc9662041279:var_4003698bf24495fc, #var_64946b5e94b2b140:var_de0ac78a9121e969, #var_ec446a384416b7d5:var_515f0d7a8e599564 };
}

// Namespace armor
// Params 2
// Checksum 0x7642a562, Offset: 0x778e
// Size: 0x55
function function_d5a70920ade0262e( uniquekey, var_1821cb423ce17d8e )
{
    assert( isstring( uniquekey ) && uniquekey.size > 0 );
    
    if ( !isarray( self.var_6965830bbb54e55c ) )
    {
        self.var_6965830bbb54e55c = [];
    }
    
    self.var_6965830bbb54e55c[ uniquekey ] = var_1821cb423ce17d8e;
}

// Namespace armor
// Params 1
// Checksum 0x403e4f9f, Offset: 0x77eb
// Size: 0x3f
function function_521cde7757e75f0b( uniquekey )
{
    assert( isstring( uniquekey ) && uniquekey.size > 0 );
    
    if ( isarray( self.var_6965830bbb54e55c ) )
    {
        self.var_6965830bbb54e55c[ uniquekey ] = undefined;
    }
}

// Namespace armor
// Params 0, eflags: 0x4
// Checksum 0xb7204735, Offset: 0x7832
// Size: 0x138
function private function_f686a55f0291117e()
{
    assert( isplayer( self ) );
    
    if ( self.var_703527c7f78cefa5 )
    {
        return level.var_a79fea38ed90447b;
    }
    
    if ( isdefined( self.perks[ "specialty_faster_plating" ] ) )
    {
        return level.var_aeecf235d5b047d9;
    }
    
    if ( isarray( self.var_6965830bbb54e55c ) && self.var_6965830bbb54e55c.size > 0 )
    {
        var_22d19c4d3fc4a495 = undefined;
        var_430746e96bf040db = undefined;
        
        foreach ( var_1821cb423ce17d8e in self.var_6965830bbb54e55c )
        {
            inserttime = var_1821cb423ce17d8e.var_64946b5e94b2b140 + var_1821cb423ce17d8e.var_123322b62e9e145c;
            
            if ( !isdefined( var_430746e96bf040db ) || inserttime < var_430746e96bf040db )
            {
                var_430746e96bf040db = inserttime;
                var_22d19c4d3fc4a495 = var_1821cb423ce17d8e;
            }
        }
        
        return ( var_22d19c4d3fc4a495 ?? level.var_780fa2e8e71a20b2 );
    }
    
    return level.var_780fa2e8e71a20b2;
}

// Namespace armor
// Params 2
// Checksum 0x24ac1c27, Offset: 0x7973
// Size: 0xce
function function_d6afc5a95480993d( amount, feedbackomnvar )
{
    if ( has_full_armor() )
    {
        return;
    }
    
    if ( self.insertingarmorplate )
    {
        return;
    }
    
    current_count_plates = function_22290101992e4874();
    amount = minint( current_count_plates, amount );
    var_6c33994b56f5413a = level.var_1bfbe247e8d32b1b;
    var_1dd4c0f2d3a26e6 = int( getarmorhealth() / var_6c33994b56f5413a );
    var_c61e0f6a2c45bbfb = int( self.maxarmorhealth / var_6c33994b56f5413a );
    amount = min( var_c61e0f6a2c45bbfb - var_1dd4c0f2d3a26e6, amount );
    repair_armor( var_6c33994b56f5413a * amount );
    new_count_plates = maxint( 0, current_count_plates - amount );
    function_d3aacadddd06ad10( new_count_plates );
    
    if ( feedbackomnvar )
    {
        self setclientomnvar( feedbackomnvar, gettime() );
    }
}

// Namespace armor
// Params 2, eflags: 0x4
// Checksum 0x94f7b2c, Offset: 0x7a49
// Size: 0x50
function private function_73684d735bbfc62e( player, str )
{
    if ( getdvarint( @"scr_use_armor_flow_log", isbrgamemode() ) )
    {
        logstring( "[USE_ARMOR_FLOW] " + ( player.name ?? "Unknown" ) + ": " + str );
    }
}

// Namespace armor
// Params 2
// Checksum 0xdc35a626, Offset: 0x7aa1
// Size: 0x13e
function debugarmor( command, args )
{
    switch ( command )
    {
        case #"hash_8ff3986c5518a2e3":
            foreach ( player in level.players )
            {
                player setarmorhealth( int( args[ 0 ] ), undefined, 1 );
            }
            
            break;
        case #"hash_fdb3d30260644058":
            foreach ( player in level.players )
            {
                player breakarmor();
            }
            
            break;
        default:
            break;
    }
}

// Namespace armor
// Params 1
// Checksum 0x3eff2b12, Offset: 0x7be7
// Size: 0x34, Type: bool
function canusecollectible( player )
{
    heldcount = player function_22290101992e4874();
    maxcount = function_db9ebf086f67fe92();
    return heldcount < maxcount;
}

// Namespace armor
// Params 1, eflags: 0x4
// Checksum 0x4746d1f5, Offset: 0x7c24
// Size: 0x45
function private function_4d48f2e0bbd97a7d( params )
{
    gameplay_sound_fx::function_28103d3430792dce( params.collectible.origin, #"shared_armor_pickup" );
    params.player function_164c824617d7e8d7( 1 );
}

