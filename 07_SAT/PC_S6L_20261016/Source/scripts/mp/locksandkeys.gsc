// scripts\mp\locksandkeys.gsc  (hash_57d3850a12cf1d8f.gscc) (size: 64380 Bytes / 0xfb7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63d0d5db (1674630619)
// size ...... 64380 (0xfb7c)
// includes .. 27  (offset: 0xdf38)
// strings ... 333 (offset: 0xe010)
// dev strs .. 6   (offset: 0xfb2c)
// exports ... 82  (offset: 0xb3c4)
// cseg ...... 0x1ad8 + 0x98ec (0xb3c4)
// imports ... 199 (offset: 0xc094)
// animtree1 . 0   (offset: 0xfb7c)
// animtree2 . 0   (offset: 0xfb7c)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\scriptable_door;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\telemetry_dmz;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\telemetry_mp;

#namespace locksandkeys;

// Namespace locksandkeys
// Params 0
// Checksum 0x4d654d, Offset: 0x1af6
// Size: 0xc9
function init()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    function_a62af2362b289eec();
    scriptable::scriptable_addusedcallbackbypart( "maphint_lock", &function_7bbcd16bf438811c );
    scriptable::scriptable_addusedcallbackbypart( "maphint_lock_interior", &function_3c73f5993e58f3c1 );
    scriptable_door::function_25c67271e41d8eee( &function_b429ccd735f39c09 );
    scriptable_door::function_c0049536af4b1117( &function_259cc760433a6ea4 );
    scriptable_door::function_369c460bb0ed0820( &doorunlocked );
    scriptable_door::function_b5d32f7fadb9b184( &function_58e43886aca316d3 );
    scriptable_door::function_a152092746ef29b0( &function_90e3ce3d2325a47f );
    function_cf0a289172e0b581();
    function_e620bce5dc20b6c();
    function_7b3d8b9f17d300e9();
    function_a871fde76b6093c9();
    function_584df56c69b53deb();
    function_94f3be340119a53();
    
    if ( getdvarint( @"hash_befe97e1c6fd91b7", 0 ) == 1 )
    {
        function_10126b2e259f0ef1();
    }
    
    /#
        level thread debug_showkeys();
    #/
}

// Namespace locksandkeys
// Params 0
// Checksum 0x67b8a436, Offset: 0x1bc7
// Size: 0x29
function function_94f3be340119a53()
{
    if ( !isdefined( level.var_952f94684868bbb1 ) )
    {
        level.var_952f94684868bbb1 = getnoentvolumearray( "locked_space_volume", #script_noteworthy );
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0xf36c4c9c, Offset: 0x1bf8
// Size: 0x50
function function_cf0a289172e0b581()
{
    level.var_621f7bbf74943efa = [];
    level.var_621f7bbf74943efa[ "onPickup" ] = [];
    level.var_621f7bbf74943efa[ "onDrop" ] = [];
    level.var_621f7bbf74943efa[ "onMatchStart" ] = [];
    level.var_621f7bbf74943efa[ "onExtract" ] = [];
}

// Namespace locksandkeys
// Params 2
// Checksum 0x90824052, Offset: 0x1c50
// Size: 0xe7, Type: bool
function function_5087e01b35080ccf( scriptable, player )
{
    var_9f2622b55d26ca5a = scriptable.activitykey == player.activitykey;
    var_ebe12de71ab4905b = scriptable.activitykey == player.var_5d9db2a2abd65925;
    var_7e46c39c0a26a71 = isdefined( scriptable.task ) && scriptable.task.completed && isdefined( scriptable.task.teams ) && isdefined( player.team ) && arraycontains( scriptable.task.teams, player.team );
    return var_9f2622b55d26ca5a || var_ebe12de71ab4905b || var_7e46c39c0a26a71;
}

// Namespace locksandkeys
// Params 2
// Checksum 0xa98a4d6d, Offset: 0x1d40
// Size: 0x301
function function_b429ccd735f39c09( scriptable, player )
{
    keyname = undefined;
    
    if ( scriptable.var_b607797768a7d9db )
    {
        return scriptable.var_b607797768a7d9db;
    }
    
    if ( isstring( scriptable.keyname ) )
    {
        keyname = scriptable.keyname;
    }
    else
    {
        return;
    }
    
    if ( isdefined( scriptable.node.origin ) && isdefined( scriptable.interiororigin ) && distance2dsquared( scriptable.interiororigin, player.origin ) < distance2dsquared( scriptable.node.origin, player.origin ) )
    {
        return &"mp_dmz_locks/unlock_deadbolt";
    }
    
    if ( function_9bc16d6d18aa192a( scriptable.keyname ) )
    {
        consumablename = getsubstr( scriptable.keyname, 9, scriptable.keyname.size );
        keylootid = loot::function_d3e3bcaea591a6a2( consumablename );
    }
    else
    {
        keylootid = loot::getlootidfromref( "loot_key_" + scriptable.keyname );
    }
    
    if ( isdefined( scriptable.activitykey ) )
    {
        if ( function_5087e01b35080ccf( scriptable, player ) )
        {
            if ( isdefined( scriptable.activitytype ) )
            {
                return function_175c0568ca5b8b75( scriptable.activitytype );
            }
            else
            {
                return function_175c0568ca5b8b75( keyname );
            }
        }
        else if ( scriptable.var_fd6a9fa1008c262 )
        {
            return function_25646546862df074( player, keyname );
        }
    }
    
    if ( isdefined( keylootid ) )
    {
        if ( player common_inventory::function_da96a2b63b35a3f8( keylootid ) || function_5e8332c102eb9882( player, scriptable.keyname ) )
        {
            return function_175c0568ca5b8b75( keyname );
        }
        else if ( function_a449b6a4ef6848b4( player ) && keyname != "stuck" )
        {
            if ( keyname == "fortress" && ( !isdefined( scriptable.activitykey ) || !function_5087e01b35080ccf( scriptable, player ) ) )
            {
                return function_175c0568ca5b8b75( "stronghold_with_skeleton" );
            }
            else if ( scriptable.var_a6b48371e5bbf63a )
            {
                return function_25646546862df074( player, keyname );
            }
            else
            {
                if ( utility::issharedfuncdefined( #"hash_574755c194e2ec60", #"hash_90cda67399ec924c" ) )
                {
                    keyname = player utility::callsharedfunc( #"hash_574755c194e2ec60", #"hash_90cda67399ec924c", keyname );
                }
                
                return function_175c0568ca5b8b75( keyname );
            }
        }
        else
        {
            return function_25646546862df074( player, keyname );
        }
    }
    else if ( function_a449b6a4ef6848b4( player ) && keyname != "stuck" )
    {
        if ( utility::issharedfuncdefined( #"hash_574755c194e2ec60", #"hash_90cda67399ec924c" ) )
        {
            keyname = player utility::callsharedfunc( #"hash_574755c194e2ec60", #"hash_90cda67399ec924c", keyname );
        }
        
        return function_175c0568ca5b8b75( keyname );
    }
    else
    {
        return function_25646546862df074( player, keyname );
    }
    
    return &"mp_dmz_locks/locked";
}

// Namespace locksandkeys
// Params 3
// Checksum 0x5a43db3c, Offset: 0x204a
// Size: 0x180, Type: bool
function function_81454a65df6d7d9a( scriptablename, player, scriptable )
{
    if ( function_b15dc053d65af220( scriptablename ) )
    {
        return false;
    }
    
    itemdef = common_item::function_526c97ebc6cff445( scriptablename );
    defaultlootid = undefined;
    
    if ( isdefined( itemdef ) && isdefined( itemdef.lootid ) )
    {
        defaultlootid = itemdef.lootid;
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        if ( defaultlootid )
        {
            defaultbundle = common_item::function_b202b16941992cca( defaultlootid );
            index = player common_inventory_groups::function_e7c426ab761c55e4( 131, defaultbundle, defaultlootid );
            
            if ( isdefined( index ) )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( defaultlootid ) && player common_inventory::function_da96a2b63b35a3f8( defaultlootid ) || function_5e8332c102eb9882( player, scriptablename ) )
    {
        return true;
    }
    
    if ( isdefined( scriptable ) && scriptable.var_a6b48371e5bbf63a )
    {
        return false;
    }
    else
    {
        foreach ( key in level.keysskeleton )
        {
            keyid = loot::getlootidfromref( key );
            
            if ( isdefined( keyid ) && player common_inventory::function_da96a2b63b35a3f8( keyid ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace locksandkeys
// Params 1, eflags: 0x4
// Checksum 0x7a5908b6, Offset: 0x21d3
// Size: 0x58, Type: bool
function private function_b15dc053d65af220( scriptablename )
{
    if ( !isdefined( scriptablename ) || scriptablename == "" )
    {
        return true;
    }
    
    array = [ "loot_key_stuck", "loot_key_lockedoneside", "loot_key_unlocked_keypad" ];
    
    if ( arraycontains( array, scriptablename ) )
    {
        return true;
    }
    
    return false;
}

// Namespace locksandkeys
// Params 1
// Checksum 0xbd32a60b, Offset: 0x2234
// Size: 0x9e, Type: bool
function function_a449b6a4ef6848b4( player )
{
    foreach ( key in level.keysskeleton )
    {
        keylootid = loot::getlootidfromref( key );
        
        if ( player common_inventory::function_da96a2b63b35a3f8( keylootid ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace locksandkeys
// Params 3
// Checksum 0xbf8e3c1, Offset: 0x22db
// Size: 0x3b2
function function_85302682f75230c0( scriptable, player, var_867f7d84083437ee )
{
    success = 0;
    deadbolt = 0;
    
    if ( !isdefined( scriptable.node.origin ) )
    {
        return [ 0, 0 ];
    }
    
    if ( isdefined( scriptable.interiororigin ) && distance2dsquared( scriptable.interiororigin, player.origin ) < distance2dsquared( scriptable.node.origin, player.origin ) )
    {
        if ( !var_867f7d84083437ee )
        {
            success = 1;
            deadbolt = 1;
        }
        else
        {
            tracecontents = trace::create_default_contents( 1 );
            traceresults = trace::ray_trace( player.origin + ( 0, 0, 16 ), scriptable.interiororigin, player, tracecontents );
            
            if ( traceresults[ "hittype" ] == "hittype_none" || scriptable.var_8275475c30350366 )
            {
                success = 1;
                deadbolt = 1;
            }
        }
    }
    
    if ( isdefined( scriptable.activitykey ) )
    {
        if ( function_5087e01b35080ccf( scriptable, player ) )
        {
            success = 1;
        }
        else if ( scriptable.var_fd6a9fa1008c262 )
        {
            success = 0;
        }
    }
    
    if ( isstring( scriptable.keyname ) )
    {
        if ( scriptable.keyname == "TESTUNIQUEDOOR" )
        {
            success = 1;
        }
        
        if ( scriptable.keyname == "completely_locked" )
        {
            return [ 0, 0 ];
        }
        
        if ( scriptable.keyname == "only_breacher_charge" && function_81454a65df6d7d9a( scriptable.keyname, player, scriptable ) )
        {
            success = 1;
        }
        
        keyname = scriptable.keyname;
        var_48f655ccdfba2ea3 = isdefined( scriptable.node.script_noteworthy ) && ( scriptable.node.script_noteworthy == "lockMe_interior" || scriptable.node.script_noteworthy == "lockme_interior" );
        
        if ( var_48f655ccdfba2ea3 )
        {
            keyname = scriptable.keyname + "_interior";
        }
        
        if ( isdefined( scriptable.fortress ) && scriptable.keyname == "fortress" && activity_manager::function_6ca6a856d360b94e( player.team, scriptable.fortress ) )
        {
            success = 1;
        }
        
        if ( function_9bc16d6d18aa192a( keyname ) )
        {
            if ( function_81454a65df6d7d9a( keyname, player, scriptable ) || function_5e8332c102eb9882( player, keyname ) )
            {
                success = 1;
            }
        }
        else if ( function_81454a65df6d7d9a( "loot_key_" + keyname, player, scriptable ) && !scriptable.var_fd6a9fa1008c262 )
        {
            success = 1;
        }
        
        var_8ad0a9b29210a3f1 = isdefined( scriptable.fortress ) && isdefined( scriptable.fortress.name ) && level.var_b0a8e372a58999a0;
        
        if ( !deadbolt && !var_48f655ccdfba2ea3 && var_8ad0a9b29210a3f1 )
        {
            tier = scriptable.fortress br_strongholds::function_999adf66330f4aa8();
            
            if ( tier == "black" )
            {
                success = function_dfdbeff1663148c2( player, scriptable.fortress.tierkeys, "loot_multi_key_fortress", level.var_fdfb55e1da90e6b7 );
            }
        }
    }
    
    return [ success, deadbolt ];
}

// Namespace locksandkeys
// Params 3
// Checksum 0x3df6709e, Offset: 0x2696
// Size: 0x119
function function_259cc760433a6ea4( scriptable, player, var_867f7d84083437ee )
{
    success = 0;
    deadbolt = 0;
    [ success, deadbolt ] = function_85302682f75230c0( scriptable, player, var_867f7d84083437ee );
    
    if ( var_867f7d84083437ee && isdefined( scriptable.node.origin ) )
    {
        if ( !success )
        {
            playsoundatpos( scriptable.node.origin, "mp_door_locked" );
        }
        else
        {
            scriptable.deadboltunlock = deadbolt;
            
            if ( deadbolt )
            {
                playsoundatpos( scriptable.node.origin, "mp_door_unlock_deadbolt" );
            }
            else
            {
                playsoundatpos( scriptable.node.origin, "mp_door_unlock_key" );
                
                if ( level.var_8c38a90f22c07e9f && isplayer( player ) )
                {
                    player playlocalsound( level.var_8c38a90f22c07e9f );
                }
            }
        }
    }
    
    return success;
}

// Namespace locksandkeys
// Params 2
// Checksum 0x3ad3ead0, Offset: 0x27b8
// Size: 0x30e
function function_9e0cea3f28929d05( scriptable, unlocker )
{
    if ( isdefined( scriptable ) && scriptable.type == "locked_cache_prompt" )
    {
        return;
    }
    
    var_c7f51d2f16dc2a59 = getdvarint( @"hash_291ad74097993a0a", 1 ) == 1;
    var_9e80c41bbb74aef4 = 0;
    isstronghold = 0;
    isfortress = 0;
    players = teams::getteamdata( unlocker.team, "players" );
    
    if ( isdefined( scriptable ) )
    {
        keyname = scriptable.keyname;
        function_811b43bcf105ad7d( unlocker, keyname );
    }
    
    if ( isdefined( scriptable.fortress ) )
    {
        isstronghold = !scriptable.fortress.ishero;
        isfortress = istrue( scriptable.fortress.ishero );
        
        if ( isdefined( scriptable.fortress.unlockedby ) )
        {
            if ( !var_c7f51d2f16dc2a59 )
            {
                var_ea91508402a118ee = 0;
                
                foreach ( player in players )
                {
                    if ( arraycontains( scriptable.fortress.unlockedby, player ) )
                    {
                        var_ea91508402a118ee = 1;
                        break;
                    }
                }
                
                if ( !var_ea91508402a118ee )
                {
                    scriptable.fortress.unlockedby = arraycombineunique( scriptable.fortress.unlockedby, players );
                    var_9e80c41bbb74aef4 = 1;
                }
            }
        }
        else
        {
            scriptable.fortress.unlockedby = [];
            scriptable.fortress.unlockedby = arraycombineunique( scriptable.fortress.unlockedby, players );
            var_9e80c41bbb74aef4 = 1;
        }
    }
    else
    {
        var_9e80c41bbb74aef4 = 1;
    }
    
    if ( !var_9e80c41bbb74aef4 )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.doorsunlocked ) )
        {
            player.doorsunlocked = 0;
        }
        
        player.doorsunlocked++;
        
        if ( isfortress )
        {
            player points::doscoreevent( #"dmz_fortress_unlocked" );
            continue;
        }
        
        if ( isstronghold )
        {
            player points::doscoreevent( #"dmz_stronghold_unlocked" );
            continue;
        }
        
        player points::doscoreevent( #"dmz_door_unlocked" );
    }
}

// Namespace locksandkeys
// Params 3
// Checksum 0xc57ac257, Offset: 0x2ace
// Size: 0x14f
function function_d39456776fcadb79( rootkeyname, player, noskeleton )
{
    defaultlootid = common_item::function_cb980b90c836804e( rootkeyname );
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        if ( defaultlootid )
        {
            defaultbundle = common_item::function_b202b16941992cca( defaultlootid );
            index = player common_inventory_groups::function_e7c426ab761c55e4( 131, defaultbundle, defaultlootid );
            
            if ( isdefined( index ) )
            {
                return [ rootkeyname, 1 ];
            }
        }
    }
    
    if ( isdefined( defaultlootid ) && player common_inventory::function_da96a2b63b35a3f8( defaultlootid ) )
    {
        return [ rootkeyname, 0 ];
    }
    
    if ( !noskeleton )
    {
        foreach ( key in level.keysskeleton )
        {
            keyid = loot::getlootidfromref( key );
            
            if ( isdefined( keyid ) && player common_inventory::function_da96a2b63b35a3f8( keyid ) )
            {
                return [ key, 1 ];
            }
        }
    }
    
    return [ undefined, undefined ];
}

// Namespace locksandkeys
// Params 1
// Checksum 0x5b9da0c6, Offset: 0x2c26
// Size: 0x2c
function function_741733f682405a26( var_41e0771a2ecb08cd )
{
    var_41e0771a2ecb08cd = script::strip_suffix( var_41e0771a2ecb08cd, "_worn" );
    var_41e0771a2ecb08cd = script::strip_suffix( var_41e0771a2ecb08cd, "_used" );
    return var_41e0771a2ecb08cd;
}

// Namespace locksandkeys
// Params 2
// Checksum 0xaf1b58ca, Offset: 0x2c5b
// Size: 0x70
function doorunlocked( scriptable, player )
{
    if ( isdefined( scriptable.connecteddoor ) )
    {
        scriptable.connecteddoor scriptabledoorfreeze( 0 );
    }
    
    if ( isdefined( scriptable.var_de79f5d2971427a8 ) )
    {
        scriptable thread [[ scriptable.var_de79f5d2971427a8 ]]( scriptable, player );
    }
    
    if ( !scriptable.deadboltunlock )
    {
        player thread function_9701b52d0b43d209( scriptable, player );
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x362999c1, Offset: 0x2cd3
// Size: 0x197
function function_9701b52d0b43d209( scriptable, player )
{
    player endon( #"death_or_disconnect" );
    savedorigin = scriptable.origin;
    
    if ( isstring( scriptable.keyname ) )
    {
        keyname = undefined;
        
        if ( scriptable.keyname )
        {
            keyname = scriptable.keyname;
        }
        else
        {
            keyname = "loot_key_" + scriptable.keyname;
        }
        
        if ( keyname == "only_breacher_charge" )
        {
            var_9fe1889b3afee254 = 1;
            scriptablename = "key_door_breacher";
        }
        else
        {
            [ scriptablename, var_9f8edff2695a53fd ] = function_d39456776fcadb79( keyname, player );
            var_9fe1889b3afee254 = scriptablename && arraycontains( level.keysskeleton, scriptablename );
        }
        
        if ( var_9fe1889b3afee254 )
        {
            player utility::callsharedfunc( #"hash_574755c194e2ec60", #"hash_7f9e30207fc0077b", scriptable, scriptablename, var_9f8edff2695a53fd );
        }
        
        if ( scriptable.keyname == "fortress" && isdefined( scriptablename ) && !var_9fe1889b3afee254 )
        {
            function_9e0cea3f28929d05( scriptable, player );
            return;
        }
        
        if ( isdefined( scriptable.activitykey ) && function_5087e01b35080ccf( scriptable, player ) )
        {
            return;
        }
        
        if ( isdefined( scriptablename ) )
        {
            function_9e0cea3f28929d05( scriptable, player );
            keybundle = common_item::function_80af1e9daffacc7d( scriptablename );
            
            if ( !keybundle.var_441f3cb34764fe0c )
            {
                function_a0508bbac82301( keyname, player );
            }
        }
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x75698b03, Offset: 0x2e72
// Size: 0x125
function function_a0508bbac82301( keyname, player )
{
    [ scriptablename, var_9f8edff2695a53fd ] = function_d39456776fcadb79( keyname, player );
    keylootid = common_item::function_cb980b90c836804e( scriptablename );
    
    if ( common_inventory_groups::inventorygroup_enabled() && var_9f8edff2695a53fd )
    {
        keybundle = common_item::function_b202b16941992cca( keylootid );
        index = player common_inventory_groups::function_e7c426ab761c55e4( 131, keybundle, keylootid );
        [ var_95d8b7c27566d4fc, _ ] = player common_inventory_groups::function_db5a1ed29a9116b2();
        [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( var_95d8b7c27566d4fc, index );
        player common_inventory_groups::function_97033a5afde2ac9b( undefined, undefined, row, column );
    }
    else
    {
        player common_inventory::function_d1993196b2bcf62d( keylootid, 1 );
    }
    
    wait 1;
    playsoundatpos( player.origin, "mp_door_key_break" );
}

// Namespace locksandkeys
// Params 4
// Checksum 0x1a18dc86, Offset: 0x2f9f
// Size: 0x81, Type: bool
function function_dfdbeff1663148c2( player, numkeys, keyname, teamkeys )
{
    keylootid = loot::getlootidfromref( keyname );
    keycount = 0;
    
    if ( !isdefined( numkeys ) )
    {
        return false;
    }
    
    if ( teamkeys )
    {
        keycount = player br_default_inventory::function_f901b681f79c70b9( keylootid );
    }
    else
    {
        keycount = player common_inventory::function_4ae597f1950505a0( keylootid );
    }
    
    if ( !isdefined( keycount ) )
    {
        return false;
    }
    
    if ( keycount >= numkeys )
    {
        return true;
    }
    
    return false;
}

// Namespace locksandkeys
// Params 3
// Checksum 0x7ad2ff1d, Offset: 0x3029
// Size: 0x2e
function function_c9f45c822b486ee4( category, keyname, callback )
{
    level.var_621f7bbf74943efa[ category ][ keyname ] = callback;
}

// Namespace locksandkeys
// Params 0
// Checksum 0xe5f47c18, Offset: 0x305f
// Size: 0x14d
function function_774c7440eb2cceab()
{
    if ( isdefined( level.uniquedoors ) )
    {
        return;
    }
    
    level.uniquedoors = [];
    keys = getarraykeys( level.struct_class_names[ "script_noteworthy" ] );
    
    foreach ( key in keys )
    {
        if ( issubstr( tolower( key ), "uniquedoor" ) )
        {
            foreach ( node in level.struct_class_names[ "script_noteworthy" ][ key ] )
            {
                level.uniquedoors = function_f4d67875159a0119( node, level.uniquedoors, getsubstr( key, 11 ), 1 );
            }
        }
    }
}

// Namespace locksandkeys
// Params 0, eflags: 0x4
// Checksum 0x50184460, Offset: 0x31b4
// Size: 0x9c
function private function_f9c635d61426abe9()
{
    function_774c7440eb2cceab();
    
    foreach ( door in level.uniquedoors )
    {
        if ( door.doubledoor )
        {
            door scriptabledoorfreeze( 1 );
            continue;
        }
        
        lockscriptabledoor( door );
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x49e0af7a, Offset: 0x3258
// Size: 0x86
function lockscriptabledoor( door, var_4f297361f387d9bf = 0 )
{
    door scriptabledoorlock();
    
    if ( var_4f297361f387d9bf )
    {
        door.var_a6b48371e5bbf63a = 1;
    }
    
    /#
        if ( getdvarint( @"hash_8a57ffd7078e4429", 0 ) == 1 )
        {
            sphere( door.origin, 150, var_4f297361f387d9bf ? ( 1, 0, 0 ) : ( 0, 1, 0 ), 0, 10000 );
        }
    #/
}

// Namespace locksandkeys
// Params 1
// Checksum 0x30418cea, Offset: 0x32e6
// Size: 0x32
function unlockscriptabledoor( door )
{
    door scriptabledoorunlock();
    
    if ( isdefined( door.connecteddoor ) )
    {
        door.connecteddoor scriptabledoorunlock();
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x3c0d0588, Offset: 0x3320
// Size: 0x42
function function_1778869f89e5e16a( struct )
{
    if ( isdefined( struct.target ) )
    {
        doors = getentitylessscriptablearray( struct.target, #targetname );
        return doors;
    }
}

// Namespace locksandkeys
// Params 6
// Checksum 0xcfe4c2cf, Offset: 0x336a
// Size: 0x48
function function_7bbcd16bf438811c( instance, part, state, player, bautouse, usestring )
{
    level thread function_2ac7944f3d7256a7( instance, part, state, player, bautouse );
}

// Namespace locksandkeys
// Params 5
// Checksum 0xf00cce5c, Offset: 0x33ba
// Size: 0x11d
function function_2ac7944f3d7256a7( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( "maphint_lock", "off" );
    playsoundatpos( instance.origin, "emt_bunk_red_button_press" );
    
    if ( getdvarint( @"hash_5556498dffa596fb", 0 ) == 1 || player common_inventory::function_da96a2b63b35a3f8( instance.keylootid ) )
    {
        playsoundatpos( instance.origin, "br_keypad_confirm" );
        unlockscriptabledoor( instance.door );
        instance.interiorhint setscriptablepartstate( "maphint_lock_interior", "off" );
        
        if ( isdefined( instance.door.var_de79f5d2971427a8 ) )
        {
            [[ instance.door.var_de79f5d2971427a8 ]]( instance.door, player );
        }
        
        return;
    }
    
    wait 1;
    instance setscriptablepartstate( "maphint_lock", instance.keyname );
}

// Namespace locksandkeys
// Params 6
// Checksum 0x8a1d204d, Offset: 0x34df
// Size: 0x48
function function_3c73f5993e58f3c1( instance, part, state, player, bautouse, usestring )
{
    level thread function_5970ac5d492caad8( instance, part, state, player, bautouse );
}

// Namespace locksandkeys
// Params 5
// Checksum 0x2de77b7c, Offset: 0x352f
// Size: 0xd8
function function_5970ac5d492caad8( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( "maphint_lock_interior", "off" );
    playsoundatpos( instance.origin, "emt_bunk_red_button_press" );
    wait 1;
    playsoundatpos( instance.origin, "br_keypad_confirm" );
    unlockscriptabledoor( instance.door );
    instance.exteriorhint setscriptablepartstate( "maphint_lock", "off" );
    
    if ( isdefined( instance.door.var_de79f5d2971427a8 ) )
    {
        [[ instance.door.var_de79f5d2971427a8 ]]( instance.door, player );
    }
}

// Namespace locksandkeys
// Params 6
// Checksum 0xd022ff41, Offset: 0x360f
// Size: 0x3d3
function function_f4d67875159a0119( node, var_96014805038d9f44, keyname, highpriority, shouldlock, var_10d2731df8e071e2 )
{
    if ( !var_96014805038d9f44 )
    {
        var_96014805038d9f44 = [];
    }
    
    index = var_96014805038d9f44.size;
    doors = scriptable_door_utility::scriptable_door_get_in_radius( node.origin, 75, 75 );
    doorswap = 0;
    
    foreach ( door in doors )
    {
        if ( isdefined( door.type ) && issubstr( door.type, "invisible" ) )
        {
            doorswap = 1;
            break;
        }
    }
    
    if ( doorswap )
    {
        var_c32728a2aa8f6689 = [];
        
        foreach ( door in doors )
        {
            if ( isdefined( door.type ) && issubstr( door.type, "invisible" ) )
            {
                door setscriptablepartstate( "door", "closed" );
                var_c32728a2aa8f6689[ var_c32728a2aa8f6689.size ] = door;
                continue;
            }
            
            door setscriptablepartstate( "door", "invisible" );
        }
        
        doors = var_c32728a2aa8f6689;
    }
    
    if ( doors.size == 2 )
    {
        doors[ 0 ].connecteddoor = doors[ 1 ];
        doors[ 1 ].connecteddoor = doors[ 0 ];
        
        if ( false )
        {
            thread debug::drawsphere( node.origin, 75, 900, ( 0, 1, 0 ) );
        }
    }
    
    if ( isdefined( doors ) )
    {
        foreach ( door in doors )
        {
            if ( isdefined( door ) )
            {
                if ( shouldlock )
                {
                    door.shouldlock = shouldlock;
                }
                
                if ( door.var_63069d6d381d6f42 && !highpriority )
                {
                    continue;
                }
                
                if ( !isdefined( door.keyname ) )
                {
                    door.keyname = keyname;
                }
                
                door.var_10d2731df8e071e2 = var_10d2731df8e071e2;
                var_96014805038d9f44[ index ] = door;
                var_96014805038d9f44[ index ].var_825726f11627973a = node.origin;
                var_96014805038d9f44[ index ].node = node;
                
                if ( highpriority )
                {
                    var_96014805038d9f44[ index ].var_63069d6d381d6f42 = 1;
                }
                
                forward = anglestoforward( node.angles ?? ( 0, 0, 0 ) );
                var_96014805038d9f44[ index ].interiororigin = door.var_825726f11627973a - forward * 25;
                var_96014805038d9f44[ index ].outerorigin = door.var_825726f11627973a + forward * 60;
                
                if ( false )
                {
                    thread debug::drawline( node.origin, var_96014805038d9f44[ index ].interiororigin, 300, ( 1, 0, 0 ) );
                }
            }
            
            index++;
        }
    }
    
    return var_96014805038d9f44;
}

// Namespace locksandkeys
// Params 0
// Checksum 0x8b76b07d, Offset: 0x39eb
// Size: 0x13d
function function_a871fde76b6093c9()
{
    level.uniqueblockers = [];
    keys = getarraykeys( level.struct_class_names[ "targetname" ] );
    
    foreach ( key in keys )
    {
        if ( issubstr( key, "uniqueBlocker" ) )
        {
            foreach ( node in level.struct_class_names[ "targetname" ][ key ] )
            {
                if ( isdefined( node.script_noteworthy ) )
                {
                    level.uniqueblockers[ level.uniqueblockers.size ] = node;
                }
            }
        }
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x9f8b2d53, Offset: 0x3b30
// Size: 0xb2
function function_584df56c69b53deb()
{
    foreach ( node in level.uniqueblockers )
    {
        scriptable = spawnscriptable( "fortress_scriptable_props", node.origin, node.angles );
        scriptable setscriptablepartstate( "scriptable_prop", node.script_noteworthy );
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0xa04d3d34, Offset: 0x3bea
// Size: 0xa4
function function_25646546862df074( player, keyname )
{
    string = level.doorstrings[ "locked_no_key" ][ tolower( keyname ) ];
    
    if ( function_a449b6a4ef6848b4( player ) )
    {
        if ( isdefined( level.doorstrings[ "locked_no_key_cant_breach" ][ tolower( keyname ) ] ) )
        {
            string = level.doorstrings[ "locked_no_key_cant_breach" ][ tolower( keyname ) ];
        }
    }
    
    if ( !isdefined( string ) )
    {
        println( "<dev string:x24>" + keyname );
        string = level.doorstrings[ "locked_no_key" ][ "stuck" ];
    }
    
    return string;
}

// Namespace locksandkeys
// Params 1
// Checksum 0x4f10d5be, Offset: 0x3c97
// Size: 0x5e
function function_175c0568ca5b8b75( doorname )
{
    string = level.doorstrings[ "locked_has_key" ][ tolower( doorname ) ];
    
    if ( !isdefined( string ) )
    {
        println( "<dev string:x5f>" + doorname );
        string = level.doorstrings[ "locked_has_key" ][ "stuck" ];
    }
    
    return string;
}

// Namespace locksandkeys
// Params 0
// Checksum 0x1edde162, Offset: 0x3cfe
// Size: 0x48
function lockedspaces_init()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "create_script_initialized" );
    
    /#
        setdvar( @"scr_lockedspaces_debug", 0 );
        level thread debug_lockedspaces();
    #/
    
    customloot_init();
    function_264d6df31b55827();
}

// Namespace locksandkeys
// Params 0
// Checksum 0xdc59c31b, Offset: 0x3d4e
// Size: 0xc5
function function_264d6df31b55827()
{
    level.lockedspaces = [];
    var_91d8349703fcdb54 = level.struct_class_names[ "script_noteworthy" ][ "lockedSpace" ];
    
    if ( !isdefined( var_91d8349703fcdb54 ) )
    {
        return;
    }
    
    foreach ( mainnode in var_91d8349703fcdb54 )
    {
        function_89544928c2f58bb8( mainnode );
        lockedspace_activate( mainnode );
        level.lockedspaces[ level.lockedspaces.size ] = mainnode;
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x7c4edd0f, Offset: 0x3e1b
// Size: 0x295
function function_89544928c2f58bb8( var_f1b6ace4fe9a0592 )
{
    nodes = arraycombine( utility::getstructarray( var_f1b6ace4fe9a0592.target, "targetname" ), getentarray( var_f1b6ace4fe9a0592.target, #targetname ) );
    var_f1b6ace4fe9a0592.lockeddoors = [];
    var_f1b6ace4fe9a0592.var_c6ae840b3c497571 = [];
    var_f1b6ace4fe9a0592.var_570cb11292b0a7ec = [];
    var_f1b6ace4fe9a0592.props = [];
    
    foreach ( node in nodes )
    {
        if ( !isdefined( node.angles ) )
        {
            node.angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( node.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( tolower( node.script_noteworthy ) )
        {
            case #"hash_cd0ffa281c8e3a8":
                keyname = tolower( node.script_keynameoverride ) ?? tolower( var_f1b6ace4fe9a0592.targetname );
                var_f1b6ace4fe9a0592.lockeddoors = function_f4d67875159a0119( node, var_f1b6ace4fe9a0592.lockeddoors, keyname, 0 );
                break;
            case #"hash_a0a74a8a22d1d16":
                var_f1b6ace4fe9a0592.var_c6ae840b3c497571 = function_f4d67875159a0119( node, var_f1b6ace4fe9a0592.var_c6ae840b3c497571, "stuck", 0 );
                break;
            case #"hash_df8921e339df1f80":
                node.isnotebook = 1;
                var_f1b6ace4fe9a0592.var_570cb11292b0a7ec[ var_f1b6ace4fe9a0592.var_570cb11292b0a7ec.size ] = node;
                break;
            case #"hash_db521e4972a48a9d":
                node.isnote = 1;
                var_f1b6ace4fe9a0592.var_570cb11292b0a7ec[ var_f1b6ace4fe9a0592.var_570cb11292b0a7ec.size ] = node;
                break;
            case #"hash_55425b6c36803a4c":
                node.iskey = 1;
                var_f1b6ace4fe9a0592.var_570cb11292b0a7ec[ var_f1b6ace4fe9a0592.var_570cb11292b0a7ec.size ] = node;
                break;
            default:
                var_f1b6ace4fe9a0592.props[ var_f1b6ace4fe9a0592.props.size ] = node;
                break;
        }
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x322f3e19, Offset: 0x40b8
// Size: 0x1d0
function lockedspace_activate( var_23fce58e976cab2f, var_48aa31f0038f1538 )
{
    foreach ( door in var_23fce58e976cab2f.lockeddoors )
    {
        lockscriptabledoor( door );
        door.var_8394ad5b75fda5da = 1;
        
        if ( isdefined( var_48aa31f0038f1538 ) )
        {
            door.var_de79f5d2971427a8 = var_48aa31f0038f1538;
            continue;
        }
        
        door.var_de79f5d2971427a8 = &function_c23b62df83561dfd;
    }
    
    foreach ( door in var_23fce58e976cab2f.var_c6ae840b3c497571 )
    {
        lockscriptabledoor( door );
    }
    
    ai_fortress::function_cf5ef24f85e09a66( var_23fce58e976cab2f );
    
    foreach ( node in var_23fce58e976cab2f.var_570cb11292b0a7ec )
    {
        function_15ad1b46a9f3a787( node, node.name, undefined, node.droptoground );
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x3f80ed24, Offset: 0x4290
// Size: 0x9a, Type: bool
function function_9894956c856a7904( origin )
{
    if ( !isdefined( level.var_952f94684868bbb1 ) )
    {
        return false;
    }
    
    foreach ( volume in level.var_952f94684868bbb1 )
    {
        if ( ispointinvolume( origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace locksandkeys
// Params 2
// Checksum 0x9bc50867, Offset: 0x4333
// Size: 0x3c
function function_c23b62df83561dfd( scriptable, player )
{
    callback::callback( #"player_unlock_door", { #player:player, #door:scriptable } );
}

/#

    // Namespace locksandkeys
    // Params 0
    // Checksum 0x1d2ac382, Offset: 0x4377
    // Size: 0xf9, Type: dev
    function debug_lockedspaces()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_lockedspaces_debug", 0 ) == 1 )
            {
                foreach ( var_f1b6ace4fe9a0592 in level.lockedspaces )
                {
                    sphere( var_f1b6ace4fe9a0592.origin, 128, ( 0, 0, 1 ) );
                    print3d( var_f1b6ace4fe9a0592.origin + ( 0, 0, 550 ), var_f1b6ace4fe9a0592.targetname, ( 1, 1, 1 ), 1, 2, 20 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace locksandkeys
// Params 0
// Checksum 0x108792a5, Offset: 0x4478
// Size: 0x53
function function_f999be7710e1ec1f()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    setdvar( @"ui_bunker_keypad_active", 1 );
    utility::flag_wait( "create_script_initialized" );
    
    /#
        if ( getdvarint( @"hash_4dbb51714a050bac", 0 ) )
        {
            function_1ac951c731b488dd();
            level thread function_f090a84b9c46e2ce();
        }
    #/
}

// Namespace locksandkeys
// Params 0
// Checksum 0x733b380a, Offset: 0x44d3
// Size: 0xa5
function function_1ac951c731b488dd()
{
    level.keypadspaces = [];
    var_a041dbbfbbc9746e = level.struct_class_names[ "script_noteworthy" ][ "keypadSpace" ];
    
    if ( !var_a041dbbfbbc9746e.size )
    {
        return;
    }
    
    foreach ( mainnode in var_a041dbbfbbc9746e )
    {
        function_e892ccf6aa665346( mainnode );
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x6877ad86, Offset: 0x4580
// Size: 0x41a
function function_e892ccf6aa665346( var_8eb7e69cf4bdbc20 )
{
    if ( !isdefined( level.keypadspaces ) )
    {
        level.keypadspaces = [];
    }
    
    level.keypadspaces[ level.keypadspaces.size ] = var_8eb7e69cf4bdbc20;
    nodes = arraycombine( utility::getstructarray( var_8eb7e69cf4bdbc20.target, "targetname" ), getentarray( var_8eb7e69cf4bdbc20.target, #targetname ), getentitylessscriptablearray( var_8eb7e69cf4bdbc20.target, #targetname ) );
    var_8eb7e69cf4bdbc20.poiname = utility::callsharedfunc( #"poi", #"hash_aef520fb6136be05", var_8eb7e69cf4bdbc20.origin );
    var_8eb7e69cf4bdbc20.lockeddoors = [];
    var_8eb7e69cf4bdbc20.var_c6ae840b3c497571 = [];
    var_8eb7e69cf4bdbc20.scriptablelocs = [];
    var_8eb7e69cf4bdbc20.keypads = [];
    var_8eb7e69cf4bdbc20.props = [];
    
    foreach ( node in nodes )
    {
        if ( !isdefined( node.angles ) )
        {
            node.angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( node.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( tolower( node.script_noteworthy ) )
        {
            case #"hash_cd0ffa281c8e3a8":
                keyname = "unlocked_keypad";
                var_8eb7e69cf4bdbc20.lockeddoors = function_f4d67875159a0119( node, var_8eb7e69cf4bdbc20.lockeddoors, keyname, 0 );
                break;
            case #"hash_a0a74a8a22d1d16":
                var_8eb7e69cf4bdbc20.var_c6ae840b3c497571 = function_f4d67875159a0119( node, var_8eb7e69cf4bdbc20.var_c6ae840b3c497571, "stuck", 0 );
                break;
            case #"hash_ed260afa6d25e89d":
                var_8eb7e69cf4bdbc20.scriptablelocs[ var_8eb7e69cf4bdbc20.scriptablelocs.size ] = node;
                break;
            case #"hash_387f00b2a5462771":
                node.var_de8aa6d6863192ac = &function_9c5eab328c9105f;
                node.keypadSpace = var_8eb7e69cf4bdbc20;
                var_8eb7e69cf4bdbc20.keypads[ var_8eb7e69cf4bdbc20.keypads.size ] = node;
                break;
            default:
                var_8eb7e69cf4bdbc20.props[ var_8eb7e69cf4bdbc20.props.size ] = node;
                break;
        }
    }
    
    foreach ( keypad in var_8eb7e69cf4bdbc20.keypads )
    {
        closestdoor = undefined;
        
        foreach ( door in var_8eb7e69cf4bdbc20.lockeddoors )
        {
            if ( !closestdoor )
            {
                closestdoor = door;
                continue;
            }
            
            if ( distance2dsquared( keypad.origin, door.origin ) < distance2dsquared( keypad.origin, closestdoor.origin ) )
            {
                closestdoor = door;
            }
        }
        
        if ( closestdoor )
        {
            keypad.door = closestdoor;
            closestdoor.keypad = keypad;
        }
    }
}

// Namespace locksandkeys
// Params 5
// Checksum 0xbb00b3c6, Offset: 0x49a2
// Size: 0x28c
function function_46553588ca6b705c( var_e2b00bd3531717a9, keycode, var_5fffa35393e4ed79, var_48aa31f0038f1538, var_a2df0c82c76f136f )
{
    foreach ( door in var_e2b00bd3531717a9.lockeddoors )
    {
        lockscriptabledoor( door );
        
        if ( isdefined( var_48aa31f0038f1538 ) )
        {
            door.var_de79f5d2971427a8 = var_48aa31f0038f1538;
            continue;
        }
        
        door.var_de79f5d2971427a8 = &function_9c5eab328c9105f;
    }
    
    foreach ( door in var_e2b00bd3531717a9.var_c6ae840b3c497571 )
    {
        lockscriptabledoor( door );
    }
    
    ai_fortress::function_cf5ef24f85e09a66( var_e2b00bd3531717a9 );
    
    foreach ( keypad in var_e2b00bd3531717a9.keypads )
    {
        keypad setscriptablepartstate( "keypad", "on_locked" );
        
        if ( utility::issharedfuncdefined( #"keypad", #"hash_662e1ccdca478f2e" ) )
        {
            utility::callsharedfunc( #"keypad", #"hash_662e1ccdca478f2e", keypad, 4, undefined, undefined, keycode );
        }
    }
    
    if ( var_5fffa35393e4ed79 || var_a2df0c82c76f136f )
    {
        scriptableloc = utility::array_random( var_e2b00bd3531717a9.scriptablelocs );
        
        if ( var_a2df0c82c76f136f )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( scriptableloc.origin, scriptableloc.angles );
            return common_item::function_57b88e025e5fb03e( var_a2df0c82c76f136f, undefined, spawnoptions );
        }
        
        if ( var_5fffa35393e4ed79 )
        {
            return spawnscriptable( var_5fffa35393e4ed79, scriptableloc.origin, scriptableloc.angles );
        }
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x4c23dbbc, Offset: 0x4c36
// Size: 0x99
function function_9c5eab328c9105f( scriptable, player )
{
    callback::callback( #"player_unlock_door", { #player:player, #door:scriptable } );
    
    if ( scriptable.door )
    {
        unlockscriptabledoor( scriptable.door );
    }
    
    if ( scriptable getscriptablehaspart( "keypad" ) )
    {
        keypad = scriptable;
    }
    else
    {
        keypad = scriptable.keypad;
    }
    
    keypad setscriptablepartstate( "keypad", "on_unlocked" );
}

// Namespace locksandkeys
// Params 0
// Checksum 0xfb96c392, Offset: 0x4cd7
// Size: 0x8b
function function_f090a84b9c46e2ce()
{
    foreach ( keypadSpace in level.keypadspaces )
    {
        function_46553588ca6b705c( keypadSpace, 1234, "interactable_note_mysterious_letter" );
    }
    
    level thread function_2ac2bf8e94a24110();
}

// Namespace locksandkeys
// Params 0, eflags: 0xc
// Checksum 0xcf02a657, Offset: 0x4d6a
// Size: 0x120
function private function_2ac2bf8e94a24110()
{
    self notify( #"hash_315d28e3c7147bcc" );
    self endon( #"hash_315d28e3c7147bcc" );
    
    while ( true )
    {
        foreach ( keypadSpace in level.keypadspaces )
        {
            foreach ( keypad in keypadSpace.keypads )
            {
                thread debug::drawsphere( keypad.origin, 32, level.framedurationseconds );
            }
        }
        
        waitframe();
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x7460382, Offset: 0x4e92
// Size: 0x132
function customloot_init()
{
    var_e069a284f565a725 = getdvar( @"hash_64ddcf029687ca8b", "mp/loot/br/dmz/lootset_custom_nodes.csv" );
    level.var_570cb11292b0a7ec = [];
    numrows = tablelookupgetnumrows( var_e069a284f565a725 );
    
    for ( i = 0; i < numrows ; i++ )
    {
        var_fd0fee515114325 = tablelookupbyrow( var_e069a284f565a725, i, 0 );
        
        if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) )
        {
            level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] = [];
        }
        
        lootitemtype = tablelookupbyrow( var_e069a284f565a725, i, 1 );
        dropchance = int( tablelookupbyrow( var_e069a284f565a725, i, 2 ) );
        lootitemoverride = tablelookupbyrow( var_e069a284f565a725, i, 3 );
        var_c800e3e42139ab19 = tablelookupbyrow( var_e069a284f565a725, i, 4 );
        level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ lootitemtype ] = spawnstruct();
        level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ lootitemtype ].dropchance = dropchance;
        level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ lootitemtype ].lootitemoverride = lootitemoverride;
        level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ lootitemtype ].var_c800e3e42139ab19 = var_c800e3e42139ab19;
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0xf7a9e83d, Offset: 0x4fcc
// Size: 0xab, Type: bool
function function_8fc1882385727dd( node )
{
    if ( !isdefined( node.classname ) || !isent( node ) )
    {
        return false;
    }
    
    var_bfd203be2d9c2d21 = node isscriptable();
    isnote = issubstr( node.classname, "note" );
    
    if ( isnote )
    {
        node.isnote = isnote;
    }
    
    iskey = issubstr( node.classname, "key" );
    
    if ( iskey )
    {
        node.iskey = isnote;
    }
    
    return var_bfd203be2d9c2d21 && ( isnote || iskey );
}

// Namespace locksandkeys
// Params 2
// Checksum 0x990bbca, Offset: 0x5080
// Size: 0x430
function function_902ec65e8afae1a7( node, var_fd0fee515114325 )
{
    var_fd0fee515114325 = tolower( var_fd0fee515114325 );
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) )
    {
        assertmsg( "<dev string:x9c>" + var_fd0fee515114325 );
        return;
    }
    
    if ( node.iskey )
    {
        if ( !function_d86a7ac55d81d9f7( var_fd0fee515114325, "key" ) )
        {
            percentagespawn = 0;
        }
        else
        {
            percentagespawn = level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "key" ].dropchance;
        }
        
        if ( percentagespawn == 0 )
        {
            return;
        }
        
        roll = randomint( 100 );
        
        if ( roll < percentagespawn )
        {
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( node.origin, node.angles );
            iscritical = 0;
            keyname = "loot_key_fortress";
            lootitemoverride = level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "key" ].lootitemoverride;
            
            if ( lootitemoverride )
            {
                keyname = lootitemoverride;
                
                if ( issubstr( keyname, "loot_key" ) )
                {
                    iscritical = 1;
                }
            }
            
            tokens = strtok( keyname, "_" );
            
            if ( tokens[ 0 ] == "tier1Key" )
            {
                keyname = function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, tokens[ 1 ] );
            }
            else if ( tokens[ 0 ] == "tier2Key" )
            {
                keyname = function_6cfc3c4b7773481c( 0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20, tokens[ 1 ] );
            }
            else if ( tokens[ 0 ] == "tier3Key" )
            {
                keyname = function_6cfc3c4b7773481c( 0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20, tokens[ 1 ] );
            }
            else if ( tokens[ 0 ] == "heroKey" )
            {
                keyname = function_6cfc3c4b7773481c( 0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, tokens[ 1 ] );
            }
            
            spawnoptions.critical = iscritical;
            scriptable = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( keyname, 1, spawnoptions );
            
            if ( iscritical )
            {
                scriptable.criticalitem = 1;
            }
        }
        
        return;
    }
    
    if ( node.isnote || node.isnotebook )
    {
        if ( isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "noteAlreadyPlaced" ] ) )
        {
            return;
        }
        else
        {
            level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "noteAlreadyPlaced" ] = 1;
        }
        
        if ( !function_d86a7ac55d81d9f7( var_fd0fee515114325, "note" ) )
        {
            percentagespawn = 0;
        }
        else
        {
            percentagespawn = level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "note" ].dropchance;
        }
        
        if ( percentagespawn == 0 )
        {
            return;
        }
        
        roll = randomint( 100 );
        
        if ( roll < percentagespawn )
        {
            notename = level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "note" ].lootitemoverride;
            
            if ( !isdefined( notename ) || notename == "" )
            {
                return;
            }
            
            offset = ( 0, 0, 0 );
            
            if ( game_utility::function_87c1e942653b7c63() )
            {
                if ( node.isnotebook )
                {
                    if ( issubstr( notename, "_note_" ) )
                    {
                        offset = ( -90, 0, 0 );
                    }
                    else
                    {
                        offset = ( 90, 0, 0 );
                    }
                }
                else if ( node.isnote )
                {
                    if ( issubstr( notename, "_notebook_" ) )
                    {
                        offset = ( 90, 0, 0 );
                    }
                    else
                    {
                        offset = ( 90, 0, 0 );
                    }
                }
            }
            else if ( game_utility::function_238d71fc76232bef() )
            {
                if ( notename == "interactable_notebook_sealion_scared01" )
                {
                    node.angles = ( 0, 0, 0 );
                }
                else if ( node.isnote )
                {
                    offset = ( 90, 0, 0 );
                }
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( node.origin, node.angles + offset );
            spawnoptions.critical = 1;
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( notename, 1, spawnoptions );
            scriptable.criticalitem = 1;
        }
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x828883c1, Offset: 0x54b8
// Size: 0x8f, Type: bool
function function_d86a7ac55d81d9f7( var_fd0fee515114325, itemtype )
{
    if ( !( isdefined( var_fd0fee515114325 ) && isdefined( itemtype ) ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ itemtype ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ itemtype ].dropchance ) )
    {
        return false;
    }
    
    if ( !isint( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ itemtype ].dropchance ) )
    {
        return false;
    }
    
    return true;
}

// Namespace locksandkeys
// Params 5
// Checksum 0x54007f57, Offset: 0x5550
// Size: 0x174
function function_15ad1b46a9f3a787( lootstruct, itemname, addedoffset = ( 0, 0, 0 ), droptoground = 1, var_e770bde56acf95a6 = 1 )
{
    if ( !itemname )
    {
        itemname = lootstruct.script_noteworthy;
    }
    
    itembundlename = common_item_database::function_ca9ca606e66b5911( itemname );
    
    if ( !itembundlename )
    {
        itembundlename = common_item_database::function_a4f0a21951180013( itemname );
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( droptoground )
    {
        origin = utility::drop_to_ground( lootstruct.origin, 50, -200 ) + addedoffset;
    }
    else
    {
        origin = lootstruct.origin;
    }
    
    if ( isdefined( itembundle ) )
    {
        spawnoptions = { #dropradiusscale:1, #var_8d4f327170228364:1, #var_23d3495c57d61bdf:1, #var_90cdc5dbcd319e5d:1, #var_9161cf0784b6951d:1, #baseangles:lootstruct.angles, #baseorigin:origin, #spawnpositionindex:0 };
        spawneditem = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    }
    
    if ( spawneditem && var_e770bde56acf95a6 )
    {
        spawneditem.critical = 1;
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x8bb22590, Offset: 0x56cc
// Size: 0x11c
function lockedcache_init()
{
    level thread function_51046be5facc7d42();
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    cachenodes = utility::getstructarray( "lockedCache", "targetname" );
    
    foreach ( cachenode in cachenodes )
    {
        cachearray = getentitylessscriptablearray( undefined, undefined, cachenode.origin, 64, "body" );
        
        if ( !isdefined( cachearray ) )
        {
            continue;
        }
        
        cachearray = sortbydistance( cachearray, cachenode.origin );
        cache = cachearray[ 0 ];
        
        if ( !isdefined( cache ) )
        {
            continue;
        }
        
        cache function_73460afa8b9e1c41( cachenode.origin, cachenode.script_noteworthy ?? "generic" );
    }
}

// Namespace locksandkeys
// Params 3, eflags: 0x4
// Checksum 0xe42080ed, Offset: 0x57f0
// Size: 0xe6
function private function_73460afa8b9e1c41( origin, keyname, unlockstate )
{
    self.unlockstate = unlockstate ?? "closed_usable";
    self.islockedcache = 1;
    self.keyname = keyname;
    self.canplaysound = 1;
    common_cache::function_e35d5e97bd22367( &function_46f32a09ac4bc555 );
    self.interact_hint_callback = &function_c9ffb48c8afe10c1;
    self.var_1e6940caec363c36 = &function_890aee000572be;
    
    if ( isdefined( self.entity ) )
    {
        self.entity.keyname = keyname;
        self.entity.islockedcache = 1;
        self.entity.interact_hint_callback = &function_c9ffb48c8afe10c1;
        self.entity.var_1e6940caec363c36 = &function_890aee000572be;
    }
    
    return self;
}

// Namespace locksandkeys
// Params 4, eflags: 0x4
// Checksum 0xf529a846, Offset: 0x58df
// Size: 0xda
function private function_1675ec271517e09d( origin, keyname, lockstate, unlockstate )
{
    lockstate = lockstate ?? "closed_usable";
    self setscriptablepartstate( "body", lockstate );
    self.unlockstate = unlockstate ?? "closed_usable";
    self.islockedcache = 1;
    self.keyname = keyname;
    self.canplaysound = 1;
    scriptable = spawnscriptable( "locked_cache_prompt", origin );
    scriptable setscriptablepartstate( "locked_cache_prompt", keyname == "generic_no_key" ? "on_no_key" : "on" );
    scriptable.keyname = keyname;
    scriptable.cache = self;
    scriptable.canplaysound = 1;
    return scriptable;
}

// Namespace locksandkeys
// Params 4
// Checksum 0xc8f5bbc2, Offset: 0x59c2
// Size: 0x33
function lockedcache_lock( origin, keyname, lockstate, unlockstate )
{
    return function_1675ec271517e09d( origin, keyname, lockstate, unlockstate );
}

// Namespace locksandkeys
// Params 0
// Checksum 0x73c37959, Offset: 0x59fe
// Size: 0xb0
function lockedcache_unlock()
{
    self setscriptablepartstate( "body", self.unlockstate ?? "closed_usable" );
    self.islockedcache = 0;
    common_cache::function_e35d5e97bd22367( undefined );
    self.interact_hint_callback = undefined;
    self.var_1e6940caec363c36 = undefined;
    
    if ( isdefined( self.entity ) )
    {
        self.entity.var_ae5aacb4681e18e9 = undefined;
        self.entity.interact_hint_callback = undefined;
        self.entity.var_1e6940caec363c36 = undefined;
        self.entity.keyname = undefined;
        self.entity.islockedcache = undefined;
    }
}

// Namespace locksandkeys
// Params 1, eflags: 0x4
// Checksum 0xed1296f9, Offset: 0x5ab6
// Size: 0x36
function private function_71569cf4702ba5d8( keyname )
{
    if ( keyname == "firefightTestContainer" )
    {
        keyname = "fortress";
    }
    
    if ( !function_9bc16d6d18aa192a( keyname ) )
    {
        keyname = "loot_key_" + keyname;
    }
    
    return keyname;
}

// Namespace locksandkeys
// Params 2
// Checksum 0x25a03b4c, Offset: 0x5af5
// Size: 0x40, Type: bool
function function_890aee000572be( usable, player )
{
    if ( !isdefined( usable.keyname ) )
    {
        return false;
    }
    
    return function_81454a65df6d7d9a( function_71569cf4702ba5d8( usable.keyname ), player );
}

// Namespace locksandkeys
// Params 2
// Checksum 0xcde7c811, Offset: 0x5b3e
// Size: 0x129
function function_c9ffb48c8afe10c1( usable, player )
{
    s = spawnstruct();
    keyname = usable.keyname;
    
    if ( !isdefined( keyname ) )
    {
        s.type = "HINT_NOBUTTON";
        s.icon = "ui_menu_icon_lock";
        s.string = &"hash_706f86211823e2a2";
        return s;
    }
    
    if ( keyname == "firefightTestContainer" )
    {
        usable.keyname = "fortress";
    }
    
    lootkeyname = function_71569cf4702ba5d8( usable.keyname );
    
    if ( !function_81454a65df6d7d9a( lootkeyname, player ) )
    {
        s.icon = "icon_door_locked";
    }
    
    s.type = "HINT_BUTTON";
    s.string = function_b429ccd735f39c09( usable, player );
    
    if ( !isdefined( s.string ) )
    {
        s.string = &"mp_dmz_locks/locked";
    }
    
    usable.keyname = keyname;
    return s;
}

// Namespace locksandkeys
// Params 1, eflags: 0x4
// Checksum 0xcf660a4b, Offset: 0x5c70
// Size: 0x17b
function private function_1f92458c5884b89e( instance )
{
    itemnames = getscriptablelootcachecontents( instance );
    
    if ( isarray( itemnames ) )
    {
        return itemnames;
    }
    
    if ( isdefined( level.commonitem.var_f4a0cd0e44af4832 ) )
    {
        var_4c34217b8aa62d30 = level.commonitem.var_f4a0cd0e44af4832;
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + var_4c34217b8aa62d30, [ #"hash_32a95aa45b53f917" ] );
        
        if ( isdefined( var_16d763e03ef0bbc.var_a72bc938c97bce90 ) )
        {
            foreach ( cacheentry in var_16d763e03ef0bbc.var_a72bc938c97bce90 )
            {
                if ( cacheentry.scriptkey == getxhash( instance.type ) && isdefined( cacheentry.itemspawnlist ) && isdefined( cacheentry.itemspawnquantity ) )
                {
                    spawnlist = hashcat( %"itemspawnlist:", cacheentry.itemspawnlist );
                    common_cache::function_a136b84fc5c0dfab( instance, spawnlist, cacheentry.itemspawnquantity, 1 );
                    break;
                }
            }
        }
    }
    
    return [];
}

// Namespace locksandkeys
// Params 6
// Checksum 0xedf16e88, Offset: 0x5df4
// Size: 0x424
function function_46f32a09ac4bc555( instance, part, state, player, bautouse, usestring )
{
    backpackkeyname = function_71569cf4702ba5d8( instance.keyname );
    
    if ( !function_81454a65df6d7d9a( backpackkeyname, player ) )
    {
        player hud_message::showerrormessage( function_5e2ec4516259a320( instance.keyname ) );
        
        if ( instance.canplaysound )
        {
            instance.canplaysound = 0;
            playsoundatpos( instance.origin, "mp_door_locked" );
            return 0;
        }
        
        wait 3;
        instance.canplaysound = 1;
        return 0;
    }
    
    player thread function_9701b52d0b43d209( instance, player );
    playsoundatpos( instance.origin, "mp_door_unlock_key" );
    savedkeyname = instance.keyname;
    
    if ( instance.keyname == "crash_lrg_2" )
    {
        grenadeorigin = instance.origin + ( 0, 0, 42 );
        grenade = magicgrenademanual( "gas_grenade_mp", grenadeorigin, ( 0, 0, 1 ), 0.1 );
        grenade.owner = player;
        player thread gas_grenade::gas_used( grenade );
    }
    
    itemarray = function_e842399cc012b42c( savedkeyname );
    instance.var_e2bbc1702d7a3c00 = &function_1f92458c5884b89e;
    instance lockedcache_unlock();
    common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    instance.var_e2bbc1702d7a3c00 = undefined;
    
    foreach ( item in itemarray )
    {
        itemtable = item.var_c800e3e42139ab19;
        
        if ( !isdefined( itemtable ) )
        {
            continue;
        }
        
        ref = undefined;
        
        if ( arraycontains( level.br_plunder.names, item.lootitemoverride ) )
        {
            var_7ac972d600c67dcf = 0;
            
            foreach ( plunderindex, plundername in level.br_plunder.names )
            {
                if ( plundername == item.lootitemoverride )
                {
                    var_7ac972d600c67dcf = plunderindex;
                    break;
                }
            }
            
            count = level.br_plunder.quantity[ var_7ac972d600c67dcf ];
        }
        else if ( issubstr( item.lootitemoverride, "brloot_weapon" ) )
        {
            count = 1;
        }
        else if ( level.var_bfa750d9db209a4b )
        {
            count = "";
            
            if ( isdefined( level.br_pickups.counts[ item.lootitemoverride ] ) )
            {
                count = level.br_pickups.counts[ item.lootitemoverride ];
            }
        }
        else
        {
            count = tablelookup( level.brloottablename, 1, item.lootitemoverride, 4 );
            
            if ( count == "" )
            {
                lootid = loot::getlootidfromref( item.lootitemoverride );
                count = tablelookup( level.brloottablename, 5, lootid, 4 );
            }
        }
        
        itembundlename = common_item_database::function_ca9ca606e66b5911( item.lootitemoverride );
        common_cache::cache_additem( instance, itembundlename, count, undefined, player );
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x6ffcbfd3, Offset: 0x6220
// Size: 0x5ba
function function_51046be5facc7d42()
{
    level.var_b95dc4b6b9b1b53b = [];
    level.var_b95dc4b6b9b1b53b[ "fortress" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_FORTRESS";
    level.var_b95dc4b6b9b1b53b[ "generic_no_key" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_GENERIC_NO_KEY";
    level.var_b95dc4b6b9b1b53b[ "key_test_01" ] = "REX_DMZ_LOCKS/NEEDS_KEYCARD";
    level.var_b95dc4b6b9b1b53b[ "rex_loot_key_test_01" ] = "REX_DMZ_LOCKS/NEEDS_KEYCARD";
    utility::flag_wait( "scriptables_ready" );
    
    if ( game_utility::function_87c1e942653b7c63() )
    {
        level.var_b95dc4b6b9b1b53b[ "airport_lounge" ] = %"mp_dmz_locks/cache_locked_airport_lounge";
        level.var_b95dc4b6b9b1b53b[ "baggage_handling" ] = %"mp_dmz_locks/cache_locked_baggage_handling";
        level.var_b95dc4b6b9b1b53b[ "end_runway" ] = %"mp_dmz_locks/cache_locked_end_runway";
        level.var_b95dc4b6b9b1b53b[ "caves_bench_container" ] = %"mp_dmz_locks/cache_locked_caves_bench_container";
        level.var_b95dc4b6b9b1b53b[ "powerstation_container" ] = %"mp_dmz_locks/cache_locked_powersubstation_container";
        level.var_b95dc4b6b9b1b53b[ "gravesite_container" ] = %"mp_dmz_locks/cache_locked_gravesite_container";
        level.var_b95dc4b6b9b1b53b[ "waterpit_container" ] = %"mp_dmz_locks/cache_locked_waterpit_container";
        level.var_b95dc4b6b9b1b53b[ "underwater_ship" ] = %"mp_dmz_locks/cache_locked_underwater_ship";
        level.var_b95dc4b6b9b1b53b[ "clocktower_container" ] = %"mp_dmz_locks/cache_locked_clocktower_container";
        level.var_b95dc4b6b9b1b53b[ "hydro_island_room" ] = %"mp_dmz_locks/cache_locked_hydro_island_room";
        level.var_b95dc4b6b9b1b53b[ "ship_bridge" ] = %"mp_dmz_locks/cache_locked_ship_bridge";
        level.var_b95dc4b6b9b1b53b[ "ship_center" ] = %"mp_dmz_locks/cache_locked_ship_center";
        level.var_b95dc4b6b9b1b53b[ "fishing_box_dock" ] = %"mp_dmz_locks/cache_locked_fishing_box_dock";
        level.var_b95dc4b6b9b1b53b[ "underthebridge" ] = %"mp_dmz_locks/cache_locked_underbridge";
        level.var_b95dc4b6b9b1b53b[ "tower_hill" ] = %"mp_dmz_locks/cache_locked_tower_hill";
        level.var_b95dc4b6b9b1b53b[ "canal_uw_container" ] = %"mp_dmz_locks/cache_locked_canal_uw_container";
        level.var_b95dc4b6b9b1b53b[ "hallway_locker" ] = %"mp_dmz_locks/cache_locked_hallway_locker";
        level.var_b95dc4b6b9b1b53b[ "control_room" ] = %"mp_dmz_locks/cache_locked_control_room";
        level.var_b95dc4b6b9b1b53b[ "ship_above_water" ] = %"mp_dmz_locks/cache_locked_ship_above_water";
        level.var_b95dc4b6b9b1b53b[ "sunken_ship" ] = %"mp_dmz_locks/cache_locked_sunken_ship";
        level.var_b95dc4b6b9b1b53b[ "underground_passage" ] = %"mp_dmz_locks/cache_locked_underground_passage";
        level.var_b95dc4b6b9b1b53b[ "police_locker" ] = %"mp_dmz_locks/cache_locked_police_locker";
        level.var_b95dc4b6b9b1b53b[ "end_pyro_tunnel" ] = %"mp_dmz_locks/cache_locked_end_pyro_tunnel";
        level.var_b95dc4b6b9b1b53b[ "crash_wp_case" ] = %"mp_dmz_locks/cache_locked_crash_wp_case";
        level.var_b95dc4b6b9b1b53b[ "crash_lrg_1" ] = %"mp_dmz_locks/cache_locked_crash_lrg_1";
        level.var_b95dc4b6b9b1b53b[ "crash_lrg_2" ] = %"mp_dmz_locks/cache_locked_crash_lrg_2";
        level.var_b95dc4b6b9b1b53b[ "crash_sm_1" ] = %"mp_dmz_locks/cache_locked_crash_sm_1";
        level.var_b95dc4b6b9b1b53b[ "crash_sm_2" ] = %"mp_dmz_locks/cache_locked_crash_sm_2";
        level.var_b95dc4b6b9b1b53b[ "crash_sm_3" ] = %"mp_dmz_locks/cache_locked_crash_sm_3";
        level.var_b95dc4b6b9b1b53b[ "crash_briefcase_1" ] = %"mp_dmz_locks/cache_locked_crash_briefcase_1";
        level.var_b95dc4b6b9b1b53b[ "dc_toolbox_1" ] = %"mp_dmz_locks/cache_locked_dc_toolbox_1";
        level.var_b95dc4b6b9b1b53b[ "dc_briefcase_1" ] = %"mp_dmz_locks/cache_locked_dc_briefcase_1";
        return;
    }
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        level.var_b95dc4b6b9b1b53b[ "sealion_castle_armory" ] = %"mp_dmz_locks/cache_locked_sealion_castle_armory";
        level.var_b95dc4b6b9b1b53b[ "sealion_couple_fight_bag" ] = %"mp_dmz_locks/cache_locked_sealion_couple_bag";
        level.var_b95dc4b6b9b1b53b[ "sealion_farmers_toolbox" ] = %"mp_dmz_locks/cache_locked_sealion_farmers_toolbox";
        level.var_b95dc4b6b9b1b53b[ "sealion_hotel_workers_office_fridge" ] = %"mp_dmz_locks/cache_locked_sealion_office_fridge";
        level.var_b95dc4b6b9b1b53b[ "sealion_knocked_over_workers_toolbox" ] = %"mp_dmz_locks/cache_locked_sealion_worker_toolbox";
        level.var_b95dc4b6b9b1b53b[ "sealion_lost_travelers_bag" ] = %"mp_dmz_locks/cache_locked_sealion_travelers_bag";
        level.var_b95dc4b6b9b1b53b[ "sealion_misplaced_crate" ] = %"mp_dmz_locks/cache_locked_sealion_misplaced_crate";
        level.var_b95dc4b6b9b1b53b[ "sealion_observatory_thrown_fridge" ] = %"mp_dmz_locks/cache_locked_sealion_observatory_fridge";
        level.var_b95dc4b6b9b1b53b[ "sealion_shadow_company_toolbox" ] = %"mp_dmz_locks/cache_locked_sealion_shadow_toolbox";
        level.var_b95dc4b6b9b1b53b[ "sealion_shipwreck_cargo_crate" ] = %"mp_dmz_locks/cache_locked_sealion_shipwreck_crate";
        level.var_b95dc4b6b9b1b53b[ "sealion_town_canal_crate" ] = %"mp_dmz_locks/cache_locked_sealion_canal_crate";
        return;
    }
    
    if ( game_utility::function_36de887ad1f5532e() )
    {
        level.var_b95dc4b6b9b1b53b[ "de_city_hall" ] = %"mp_dmz_locks/cache_locked_delta_cityhall";
        level.var_b95dc4b6b9b1b53b[ "de_museum_02" ] = %"mp_dmz_locks/cache_locked_delta_newmuseum";
        level.var_b95dc4b6b9b1b53b[ "de_museum_01" ] = %"mp_dmz_locks/cache_locked_delta_oldmuseum";
        level.var_b95dc4b6b9b1b53b[ "de_tunnel_01" ] = %"mp_dmz_locks/cache_locked_delta_sewers";
        level.var_b95dc4b6b9b1b53b[ "de_shopping_mall" ] = %"mp_dmz_locks/cache_locked_delta_shoppingmall";
        level.var_b95dc4b6b9b1b53b[ "de_hangar_01" ] = %"mp_dmz_locks/cache_locked_delta_stables";
        level.var_b95dc4b6b9b1b53b[ "de_homeboat_01" ] = %"mp_dmz_locks/cache_locked_delta_sunkenhouse";
        level.var_b95dc4b6b9b1b53b[ "de_under_bridge" ] = %"mp_dmz_locks/cache_locked_delta_underbridge";
        level.var_b95dc4b6b9b1b53b[ "de_stage_01" ] = %"mp_dmz_locks/cache_locked_delta_university";
        level.var_b95dc4b6b9b1b53b[ "de_windmill" ] = %"mp_dmz_locks/cache_locked_delta_windmill";
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x79b107c1, Offset: 0x67e2
// Size: 0x3c
function function_5e2ec4516259a320( keyname )
{
    errorstring = level.var_b95dc4b6b9b1b53b[ keyname ];
    
    if ( !isdefined( errorstring ) )
    {
        errorstring = level.var_b95dc4b6b9b1b53b[ "fortress" ];
    }
    
    return errorstring;
}

// Namespace locksandkeys
// Params 1
// Checksum 0xca548ed4, Offset: 0x6827
// Size: 0x259
function function_e842399cc012b42c( var_fd0fee515114325 )
{
    itemarray = [];
    
    if ( isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) )
    {
        foreach ( potentialitem in level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] )
        {
            tokens = strtok( potentialitem.lootitemoverride, "_" );
            
            if ( tokens[ 0 ] == "tier1Key" )
            {
                potentialitem.lootitemoverride = function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20, tokens[ 1 ] );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "tier2Key" )
            {
                potentialitem.lootitemoverride = function_6cfc3c4b7773481c( 0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20, tokens[ 1 ] );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "tier3Key" )
            {
                potentialitem.lootitemoverride = function_6cfc3c4b7773481c( 0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20, tokens[ 1 ] );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "heroKey" )
            {
                potentialitem.lootitemoverride = function_6cfc3c4b7773481c( 0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20, tokens[ 1 ] );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "weaponPistol" )
            {
                potentialitem.lootitemoverride = lootcache_getrandomweapon( "pistol" );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "weaponRare" )
            {
                potentialitem.lootitemoverride = lootcache_getrandomweapon( "rare" );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( tokens[ 0 ] == "weaponEpic" )
            {
                potentialitem.lootitemoverride = lootcache_getrandomweapon( "epic" );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            roll = randomint( 100 );
            
            if ( roll < potentialitem.dropchance )
            {
                itemarray[ itemarray.size ] = potentialitem;
            }
        }
    }
    
    return itemarray;
}

// Namespace locksandkeys
// Params 0
// Checksum 0x3d74810d, Offset: 0x6a89
// Size: 0xb45
function function_e620bce5dc20b6c()
{
    level.var_89ba75fe669670c4 = [];
    level.keysskeleton = [ "loot_key_skeleton", "loot_key_skeleton_used", "loot_key_skeleton_worn", "key_door_breacher" ];
    level.var_dbc763981a7a23ab = [];
    level.var_dbc763981a7a23ab[ 1 ] = [];
    level.var_dbc763981a7a23ab[ 2 ] = [];
    level.var_dbc763981a7a23ab[ 3 ] = [];
    level.var_dbc763981a7a23ab[ 4 ] = [];
    level.var_dbc763981a7a23ab[ "1_sabacrash" ] = [];
    level.var_dbc763981a7a23ab[ "2_sabacrash" ] = [];
    level.var_dbc763981a7a23ab[ "3_sabacrash" ] = [];
    level.var_dbc763981a7a23ab[ "4_sabacrash" ] = [];
    level.var_dbc763981a7a23ab[ "1_b21" ] = [];
    level.var_dbc763981a7a23ab[ "1_sealion" ] = [];
    level.var_dbc763981a7a23ab[ "2_sealion" ] = [];
    level.var_dbc763981a7a23ab[ "3_sealion" ] = [];
    level.var_dbc763981a7a23ab[ "4_sealion" ] = [];
    level.var_dbc763981a7a23ab[ "1_delta" ] = [];
    level.var_dbc763981a7a23ab[ "2_delta" ] = [];
    level.var_dbc763981a7a23ab[ "3_delta" ] = [];
    level.var_dbc763981a7a23ab[ "4_delta" ] = [];
    function_34c0a35533f87da5( 1, "hydro_storage", 1 );
    function_34c0a35533f87da5( 1, "airport_lounge", 1 );
    function_34c0a35533f87da5( 1, "baggage_handling", 1 );
    function_34c0a35533f87da5( 1, "caves_bench_container", 1 );
    function_34c0a35533f87da5( 1, "undershack", 1 );
    function_34c0a35533f87da5( 1, "gravehouse", 1 );
    function_34c0a35533f87da5( 1, "powerstation_container", 1 );
    function_34c0a35533f87da5( 1, "gravesite_container", 1 );
    function_34c0a35533f87da5( 1, "mobile_office", 1 );
    function_34c0a35533f87da5( 1, "groundskeepers", 1 );
    function_34c0a35533f87da5( 1, "clocktower_container", 1 );
    function_34c0a35533f87da5( 1, "hydro_island_room", 1 );
    function_34c0a35533f87da5( 1, "fishing_box_dock", 1 );
    function_34c0a35533f87da5( 1, "supply_rooms", 1 );
    function_34c0a35533f87da5( 1, "power_substation", 1 );
    function_34c0a35533f87da5( 1, "cell_phone_shop", 1 );
    function_34c0a35533f87da5( 1, "underthebridge", 1 );
    function_34c0a35533f87da5( 1, "police_academy_barracks", 1 );
    function_34c0a35533f87da5( 1, "tv_station", 1 );
    function_34c0a35533f87da5( 1, "shopping_booth", 1 );
    function_34c0a35533f87da5( 1, "yumyum_burger", 1 );
    function_34c0a35533f87da5( 1, "tower_hill", 1 );
    function_34c0a35533f87da5( 1, "canal_uw_container", 1 );
    function_34c0a35533f87da5( 1, "small_confer_room", 1 );
    function_34c0a35533f87da5( 1, "hallway_locker", 1 );
    function_34c0a35533f87da5( 1, "north_guard_shack", 1 );
    function_34c0a35533f87da5( 1, "south_guard_shack", 1 );
    function_34c0a35533f87da5( 1, "fortbarrack1", 1 );
    function_34c0a35533f87da5( 1, "office_quarters1", 1 );
    function_34c0a35533f87da5( 1, "sunken_2nd_office", 1 );
    function_34c0a35533f87da5( 1, "sira_apartment", 1 );
    function_34c0a35533f87da5( 1, "gaming_room", 1 );
    function_34c0a35533f87da5( 1, "fishing_shack", 1 );
    function_34c0a35533f87da5( 1, "spotters_view", 1 );
    function_34c0a35533f87da5( 1, "grocery_office", 1 );
    function_34c0a35533f87da5( 1, "neigh_storage_room", 1 );
    function_34c0a35533f87da5( 1, "crane_building", 1 );
    function_34c0a35533f87da5( 1, "underwater_ship", 1 );
    function_34c0a35533f87da5( 2, "hydro_apt" );
    function_34c0a35533f87da5( 2, "conference_room" );
    function_34c0a35533f87da5( 2, "end_runway", 1 );
    function_34c0a35533f87da5( 2, "cliffroom" );
    function_34c0a35533f87da5( 2, "poppyhome" );
    function_34c0a35533f87da5( 2, "waterpit_container", 1 );
    function_34c0a35533f87da5( 2, "lighthouse_room" );
    function_34c0a35533f87da5( 2, "ship_bridge", 1 );
    function_34c0a35533f87da5( 2, "ship_center", 1 );
    function_34c0a35533f87da5( 2, "policestation", 1 );
    function_34c0a35533f87da5( 2, "smugglers_warehouse" );
    function_34c0a35533f87da5( 2, "interrogation_room" );
    function_34c0a35533f87da5( 2, "police_lockerroom" );
    function_34c0a35533f87da5( 2, "apartment_closet" );
    function_34c0a35533f87da5( 2, "tv_computer_room" );
    function_34c0a35533f87da5( 2, "destroyed_telescope" );
    function_34c0a35533f87da5( 2, "scientist_apartment" );
    function_34c0a35533f87da5( 2, "control_room" );
    function_34c0a35533f87da5( 2, "end_pyro_tunnel" );
    function_34c0a35533f87da5( 2, "munitions_storage", 1 );
    function_34c0a35533f87da5( 2, "car_shop" );
    function_34c0a35533f87da5( 2, "sunken_top_office" );
    function_34c0a35533f87da5( 2, "hotel_room1" );
    function_34c0a35533f87da5( 2, "ship_above_water" );
    function_34c0a35533f87da5( 2, "dressing_room" );
    function_34c0a35533f87da5( 2, "apartment_snipernest" );
    function_34c0a35533f87da5( 2, "underground_passage" );
    function_34c0a35533f87da5( 3, "maintenance" );
    function_34c0a35533f87da5( 3, "safe_house" );
    function_34c0a35533f87da5( 3, "western_storage" );
    function_34c0a35533f87da5( 3, "secret_comms", 1 );
    function_34c0a35533f87da5( 3, "post_office" );
    function_34c0a35533f87da5( 3, "antiquities_office", 1 );
    function_34c0a35533f87da5( 3, "quiet_bedroom" );
    function_34c0a35533f87da5( 3, "server_room" );
    function_34c0a35533f87da5( 3, "hotel_room2", 1 );
    function_34c0a35533f87da5( 3, "sunken_ship" );
    function_34c0a35533f87da5( 3, "sec_camera_room" );
    function_34c0a35533f87da5( 3, "mountain_top" );
    function_34c0a35533f87da5( 4, "civic_center", 1 );
    function_34c0a35533f87da5( 4, "embassy", 1 );
    function_34c0a35533f87da5( 4, "fort", 1 );
    function_34c0a35533f87da5( 4, "sira_mall", 1 );
    function_34c0a35533f87da5( 4, "resort_entrance", 1 );
    function_34c0a35533f87da5( 4, "police_academy", 1 );
    function_34c0a35533f87da5( 4, "post_office_stronghold", 1 );
    function_34c0a35533f87da5( 4, "control_tower", 1 );
    function_34c0a35533f87da5( 4, "exhume_warehouse", 1 );
    function_34c0a35533f87da5( "1_sabacrash", "crash_sm_1" );
    function_34c0a35533f87da5( "1_sabacrash", "crash_wp_case" );
    function_34c0a35533f87da5( "1_sabacrash", "sealion_port_managers_office" );
    function_34c0a35533f87da5( "1_sabacrash", "sealion_castle_armory" );
    function_34c0a35533f87da5( "2_sabacrash", "crash_sm_2" );
    function_34c0a35533f87da5( "2_sabacrash", "crash_wp_case" );
    function_34c0a35533f87da5( "2_sabacrash", "sealion_ferry_tourist_information_booth" );
    function_34c0a35533f87da5( "2_sabacrash", "sealion_misplaced_crate" );
    function_34c0a35533f87da5( "3_sabacrash", "crash_sm_3" );
    function_34c0a35533f87da5( "3_sabacrash", "crash_wp_case" );
    function_34c0a35533f87da5( "3_sabacrash", "sealion_water_treatment_control_center" );
    function_34c0a35533f87da5( "3_sabacrash", "sealion_port_harbor_control" );
    function_34c0a35533f87da5( "4_sabacrash", "crash_lrg_1" );
    function_34c0a35533f87da5( "4_sabacrash", "crash_lrg_2" );
    function_34c0a35533f87da5( "4_sabacrash", "crash_briefcase_1" );
    function_34c0a35533f87da5( "1_b21", "red_door", 1 );
    function_34c0a35533f87da5( "1_b21", "blue_door", 1 );
    function_34c0a35533f87da5( "1_b21", "green_door", 1 );
    function_34c0a35533f87da5( "1_b21", "black_door", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_shadow_company_toolbox", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_castle_armory", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_beach_club_bathroom", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_hotel_room_403", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_hotel_workers_office_fridge", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_port_managers_office", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_shipwreck_cargo_crate", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_farmers_toolbox", 1 );
    function_34c0a35533f87da5( "1_sealion", "sealion_couple_fight_bag", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_misplaced_crate", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_knocked_over_workers_toolbox", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_observatory_thrown_fridge" );
    function_34c0a35533f87da5( "2_sealion", "sealion_lab_office", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_town_canal_crate", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_ferry_tourist_information_booth", 1 );
    function_34c0a35533f87da5( "2_sealion", "sealion_lost_travelers_bag" );
    function_34c0a35533f87da5( "3_sealion", "sealion_water_treatment_control_center", 1 );
    function_34c0a35533f87da5( "3_sealion", "sealion_port_harbor_control" );
    function_34c0a35533f87da5( "3_sealion", "sealion_castle", 1 );
    function_34c0a35533f87da5( "3_sealion", "sealion_cityhall", 1 );
    function_34c0a35533f87da5( "4_sealion", "sealion_castle", 1 );
    function_34c0a35533f87da5( "4_sealion", "sealion_cityhall", 1 );
    function_34c0a35533f87da5( "1_delta", "de_city_hall", 1 );
    function_34c0a35533f87da5( "1_delta", "de_museum_02", 1 );
    function_34c0a35533f87da5( "1_delta", "de_museum_01", 1 );
    function_34c0a35533f87da5( "1_delta", "de_tunnel_01" );
    function_34c0a35533f87da5( "1_delta", "de_shopping_mall" );
    function_34c0a35533f87da5( "1_delta", "de_hangar_01" );
    function_34c0a35533f87da5( "1_delta", "de_homeboat_01" );
    function_34c0a35533f87da5( "1_delta", "de_under_bridge" );
    function_34c0a35533f87da5( "1_delta", "de_stage_01", 1 );
    function_34c0a35533f87da5( "1_delta", "de_windmill", 1 );
    function_34c0a35533f87da5( "2_delta", "de_animal_care", 1 );
    function_34c0a35533f87da5( "2_delta", "de_shops_02", 1 );
    function_34c0a35533f87da5( "2_delta", "de_bike_parking_02", 1 );
    function_34c0a35533f87da5( "2_delta", "de_firestation_01", 1 );
    function_34c0a35533f87da5( "2_delta", "de_waterhome_04" );
    function_34c0a35533f87da5( "2_delta", "de_homeboat_08" );
    function_34c0a35533f87da5( "2_delta", "de_stadium", 1 );
    function_34c0a35533f87da5( "2_delta", "de_cruise_terminal", 1 );
    function_34c0a35533f87da5( "2_delta", "de_block_01" );
    function_34c0a35533f87da5( "3_delta", "delta_oldmuseum", 1 );
    function_34c0a35533f87da5( "3_delta", "delta_stadium", 1 );
    function_34c0a35533f87da5( "3_delta", "delta_trainstation", 1 );
    function_34c0a35533f87da5( "4_delta", "delta_aquarium", 1 );
    function_34c0a35533f87da5( "4_delta", "delta_cityhall", 1 );
    function_34c0a35533f87da5( "4_delta", "delta_firestation", 1 );
    function_34c0a35533f87da5( "4_delta", "delta_terminal", 1 );
    
    /#
    #/
}

// Namespace locksandkeys
// Params 3
// Checksum 0x6d887069, Offset: 0x75d6
// Size: 0x78
function function_34c0a35533f87da5( category, keyname, var_4db8a0a3942ed87d )
{
    level.var_dbc763981a7a23ab[ category ][ level.var_dbc763981a7a23ab[ category ].size ] = keyname;
    
    if ( var_4db8a0a3942ed87d )
    {
        if ( !isdefined( level.var_89ba75fe669670c4[ category ] ) )
        {
            level.var_89ba75fe669670c4[ category ] = [];
        }
        
        level.var_89ba75fe669670c4[ category ][ level.var_89ba75fe669670c4[ category ].size ] = keyname;
    }
}

// Namespace locksandkeys
// Params 5
// Checksum 0xbc335812, Offset: 0x7656
// Size: 0xde
function function_9f6bed63bb2485e( categories, categoryweights, pristinechance, usedchance, wornchance )
{
    chosencategory = utility::random_weighted( categories, categoryweights );
    
    if ( !( isdefined( chosencategory ) && isdefined( level.var_89ba75fe669670c4[ chosencategory ] ) ) || level.var_89ba75fe669670c4[ chosencategory ].size == 0 )
    {
        return;
    }
    
    key = utility::array_random( level.var_89ba75fe669670c4[ chosencategory ] );
    durabilitysuffix = utility::random_weighted( [ "", "_used", "_worn" ], [ pristinechance, usedchance, wornchance ] );
    
    if ( !isdefined( durabilitysuffix ) )
    {
        return;
    }
    
    return "loot_key_" + key + durabilitysuffix;
}

// Namespace locksandkeys
// Params 12
// Checksum 0x1dbd0910, Offset: 0x773d
// Size: 0x32a
function function_6cfc3c4b7773481c( tier1ok, tier2ok, tier3ok, herook, tier1chance, tier2chance, tier3chance, herochance, pristinechance, usedchance, wornchance, mapnameoverride )
{
    possibletiers = [];
    totaltickets = 0;
    
    if ( tier1ok )
    {
        if ( isdefined( tier1chance ) )
        {
            totaltickets += tier1chance;
            possibletiers[ 1 ] = tier1chance;
        }
        else
        {
            totaltickets += 1;
            possibletiers[ 1 ] = 1;
        }
    }
    
    if ( tier2ok )
    {
        if ( isdefined( tier2chance ) )
        {
            totaltickets += tier2chance;
            possibletiers[ 2 ] = tier2chance;
        }
        else
        {
            totaltickets += 1;
            possibletiers[ 2 ] = 1;
        }
    }
    
    if ( tier3ok )
    {
        if ( isdefined( tier2chance ) )
        {
            totaltickets += tier3chance;
            possibletiers[ 3 ] = tier3chance;
        }
        else
        {
            totaltickets += 1;
            possibletiers[ 3 ] = 1;
        }
    }
    
    if ( herook )
    {
        if ( isdefined( herochance ) )
        {
            totaltickets += herochance;
            possibletiers[ 4 ] = herochance;
        }
        else
        {
            totaltickets += 1;
            possibletiers[ 4 ] = 1;
        }
    }
    
    roll = randomint( totaltickets );
    chancetotal = 0;
    var_c8a50e71413e866b = undefined;
    
    foreach ( tier, tierchance in possibletiers )
    {
        chancetotal += tierchance;
        
        if ( roll < chancetotal )
        {
            var_c8a50e71413e866b = tier;
            break;
        }
    }
    
    var_ffa15161145fad4e = [];
    var_dd7b3870ff034804 = 0;
    
    if ( isdefined( pristinechance ) )
    {
        var_dd7b3870ff034804 += pristinechance;
        var_ffa15161145fad4e[ "" ] = pristinechance;
    }
    
    if ( isdefined( usedchance ) )
    {
        var_dd7b3870ff034804 += usedchance;
        var_ffa15161145fad4e[ "_used" ] = usedchance;
    }
    
    if ( isdefined( wornchance ) )
    {
        var_dd7b3870ff034804 += wornchance;
        var_ffa15161145fad4e[ "_worn" ] = wornchance;
    }
    
    if ( var_ffa15161145fad4e.size == 0 )
    {
        var_e2e41147eff9a9b0 = utility::array_random( [ "", "_worn", "_used" ] );
    }
    else
    {
        roll = randomint( var_dd7b3870ff034804 );
        chancetotal = 0;
        var_e2e41147eff9a9b0 = undefined;
        
        foreach ( quality, var_bc2d23586e5475d7 in var_ffa15161145fad4e )
        {
            chancetotal += var_bc2d23586e5475d7;
            
            if ( roll < chancetotal )
            {
                var_e2e41147eff9a9b0 = quality;
                break;
            }
        }
    }
    
    if ( isdefined( mapnameoverride ) )
    {
        var_c8a50e71413e866b = var_c8a50e71413e866b + "_" + mapnameoverride;
    }
    
    keyname = utility::array_random( level.var_dbc763981a7a23ab[ var_c8a50e71413e866b ] );
    lootkeyname = "loot_key_" + keyname + var_e2e41147eff9a9b0;
    return lootkeyname;
}

// Namespace locksandkeys
// Params 2
// Checksum 0xf7b4893b, Offset: 0x7a70
// Size: 0xe2, Type: bool
function function_5e8332c102eb9882( player, basekey )
{
    if ( !isdefined( level.var_8ad7672a58c93068 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_8ad7672a58c93068[ basekey ] ) )
    {
        return false;
    }
    
    foreach ( keyname in level.var_8ad7672a58c93068[ basekey ] )
    {
        consumablename = getsubstr( keyname, 9, keyname.size );
        keylootid = loot::function_d3e3bcaea591a6a2( consumablename );
        
        if ( player common_inventory::function_da96a2b63b35a3f8( keylootid ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace locksandkeys
// Params 0
// Checksum 0xf558d034, Offset: 0x7b5b
// Size: 0x7b5
function function_7b3d8b9f17d300e9()
{
    level.lockedcache = spawnstruct();
    level.lockedcache.var_e7f5e44895b34df7 = [];
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ] = [];
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ] = [];
    level.lockedcache.var_e7f5e44895b34df7[ "pistol" ] = [];
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_br_msecho_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_la_rpapa7_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_dm_pgolf1_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_dm_la700_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_br_soscar14_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sh_charlie725_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sh_mviktor_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_lm_ahotel_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_lm_kilo21_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_ar_mike4_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_ar_kilo53_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sm_papa90_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "rare" ][ level.lockedcache.var_e7f5e44895b34df7[ "rare" ].size ] = "brloot_weapon_sm_alpha57_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_golf3_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_br_msecho_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_mike14_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_sa700_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_dm_scromeo_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_sh_mbravo_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_lm_foxtrot_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_lm_rkilo_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_kilo53_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_augolf_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_ar_akilo_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_sm_victor_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_br_soscar14_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_sm_alpha57_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "epic" ][ level.lockedcache.var_e7f5e44895b34df7[ "epic" ].size ] = "brloot_weapon_la_juliet_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "pistol" ][ level.lockedcache.var_e7f5e44895b34df7[ "pistol" ].size ] = "brloot_weapon_pi_decho_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "pistol" ][ level.lockedcache.var_e7f5e44895b34df7[ "pistol" ].size ] = "brloot_weapon_pi_golf17_epic";
    level.lockedcache.var_e7f5e44895b34df7[ "pistol" ][ level.lockedcache.var_e7f5e44895b34df7[ "pistol" ].size ] = "brloot_weapon_pi_golf18_lege";
    level.lockedcache.var_e7f5e44895b34df7[ "pistol" ][ level.lockedcache.var_e7f5e44895b34df7[ "pistol" ].size ] = "brloot_weapon_pi_swhiskey_lege";
}

// Namespace locksandkeys
// Params 1
// Checksum 0x1c1e8b86, Offset: 0x8318
// Size: 0x44
function lootcache_getrandomweapon( category )
{
    if ( !isdefined( level.lockedcache.var_e7f5e44895b34df7[ category ] ) )
    {
        return;
    }
    
    return utility::array_random( level.lockedcache.var_e7f5e44895b34df7[ category ] );
}

// Namespace locksandkeys
// Params 2
// Checksum 0xefc48b6a, Offset: 0x8365
// Size: 0x1f7
function function_811b43bcf105ad7d( player, keyused )
{
    if ( !isdefined( keyused ) )
    {
        logprint( "'keyUsed' is undefined. Parameter [1], 'keyUsed'" );
    }
    
    if ( !isdefined( player ) )
    {
        logprint( "'player' is undefined. Parameter [0], 'player'" );
        return;
    }
    
    if ( !isplayer( player ) )
    {
        logprint( "'player' object passed in is not a Player . Parameter [0], 'player'" );
        return;
    }
    
    keytype = keyused ?? #"undefined";
    
    if ( isplayer( player ) )
    {
        playerpositionx = player.origin[ 0 ];
        playerpositiony = player.origin[ 1 ];
        playerpositionz = player.origin[ 2 ];
        playerrotationpitch = player.angles[ 0 ];
        playerrotationyaw = player.angles[ 1 ];
        playerrotationroll = player.angles[ 2 ];
        matchtime = telemetry_utils::get_time_from_match_start( gettime() ) ?? 0;
        lpconlevel = telemetry_dmz::function_3ae64a84c6590538();
        teamid = telemetry_mp::function_e9916990e84fae44( player ) ?? #"undefined";
        player dlog_recordplayerevent( "dlog_event_dmz_keycard_used", [ "key_type", getxhash( keytype ), "player_position_x", playerpositionx, "player_position_y", playerpositiony, "player_position_z", playerpositionz, "player_rotation_pitch", playerrotationpitch, "player_rotation_yaw", playerrotationyaw, "player_rotation_roll", playerrotationroll, "lpcon_level", getxhash( lpconlevel ), "team_id", getxhash( teamid ), "match_time_elapsed", matchtime ] );
    }
}

// Namespace locksandkeys
// Params 2
// Checksum 0x5cf16fc9, Offset: 0x8564
// Size: 0x8a
function function_90e3ce3d2325a47f( scriptable, player )
{
    if ( scriptable.var_10d2731df8e071e2 )
    {
        var_543d1bf3e10c0848 = utility::callsharedfunc( #"hash_574755c194e2ec60", #"hash_e5b6316c6bda4944", scriptable.var_10d2731df8e071e2 );
    }
    
    if ( var_543d1bf3e10c0848 && isdefined( level.doorstrings[ "open" ][ var_543d1bf3e10c0848 ] ) )
    {
        return level.doorstrings[ "open" ][ var_543d1bf3e10c0848 ];
    }
    
    return &"mp/door_use_open";
}

// Namespace locksandkeys
// Params 2
// Checksum 0x6306824b, Offset: 0x85f7
// Size: 0x8a
function function_58e43886aca316d3( scriptable, player )
{
    if ( scriptable.var_10d2731df8e071e2 )
    {
        var_543d1bf3e10c0848 = utility::callsharedfunc( #"hash_574755c194e2ec60", #"hash_e5b6316c6bda4944", scriptable.var_10d2731df8e071e2 );
    }
    
    if ( var_543d1bf3e10c0848 && isdefined( level.doorstrings[ "close" ][ var_543d1bf3e10c0848 ] ) )
    {
        return level.doorstrings[ "close" ][ var_543d1bf3e10c0848 ];
    }
    
    return &"mp/door_use_close";
}

// Namespace locksandkeys
// Params 0
// Checksum 0xfc3407a, Offset: 0x868a
// Size: 0x4d
function function_a62af2362b289eec()
{
    if ( isdefined( level.doorstrings ) )
    {
        return;
    }
    
    level.doorstrings = [];
    level.doorstrings[ "locked_no_key" ] = [];
    level.doorstrings[ "locked_has_key" ] = [];
    level.doorstrings[ "open" ] = [];
}

/#

    // Namespace locksandkeys
    // Params 0
    // Checksum 0xca0676a3, Offset: 0x86df
    // Size: 0x37, Type: dev
    function function_65dbf6843c462339()
    {
        while ( true )
        {
            randomkey = function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 10, 70, 20 );
            println( randomkey );
            waitframe();
        }
    }

    // Namespace locksandkeys
    // Params 0
    // Checksum 0xc16816c8, Offset: 0x871e
    // Size: 0x3be, Type: dev
    function debug_showkeys()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_add2748481956623", 0 ) == 1 )
            {
                lootitems = getentitylessscriptablearray();
                var_6d2f8b8a218a4134 = [];
                var_f234efe0dc4d3f2c = [];
                cachelocs = [];
                
                foreach ( item in lootitems )
                {
                    switch ( item.type )
                    {
                        case #"hash_8709a7ef11ecdbea":
                            var_6d2f8b8a218a4134[ var_6d2f8b8a218a4134.size ] = item.origin;
                            continue;
                        case #"hash_183cb58bad34bd86":
                        case #"hash_19ba8d41970911ad":
                        case #"hash_33a1ab3969e0b64e":
                        case #"hash_417c605750c7baa5":
                        case #"hash_b1814c3921b5bcf2":
                        case #"hash_b5b4216883bf84b8":
                            cachelocs[ cachelocs.size ] = item;
                            continue;
                    }
                    
                    if ( isdefined( item.type ) && ( issubstr( item.type, "<dev string:x16e>" ) || issubstr( item.type, "<dev string:x177>" ) ) )
                    {
                        var_f234efe0dc4d3f2c[ var_f234efe0dc4d3f2c.size ] = item.origin;
                    }
                }
                
                foreach ( cache in cachelocs )
                {
                    cacheitems = getscriptablelootcachecontents( cache );
                    
                    foreach ( item in cacheitems )
                    {
                        if ( item == "<dev string:xd3>" )
                        {
                            var_6d2f8b8a218a4134[ var_6d2f8b8a218a4134.size ] = cache.origin;
                            continue;
                        }
                        
                        if ( issubstr( item, "<dev string:x16e>" ) || issubstr( item, "<dev string:x177>" ) )
                        {
                            var_f234efe0dc4d3f2c[ var_f234efe0dc4d3f2c.size ] = cache.origin;
                        }
                    }
                }
                
                color = ( 0, 1, 0 );
                
                foreach ( loc in var_6d2f8b8a218a4134 )
                {
                    thread debug::drawsphere( loc, 32, 1, color );
                }
                
                color = ( 0, 0, 1 );
                
                foreach ( loc in var_f234efe0dc4d3f2c )
                {
                    thread debug::drawsphere( loc, 32, 1, color );
                }
            }
            
            wait 1;
        }
    }

#/

// Namespace locksandkeys
// Params 0
// Checksum 0x77847b58, Offset: 0x8ae4
// Size: 0x1a3
function function_10126b2e259f0ef1()
{
    var_c1d0e2748c1fce2f = utility::getstructarray( "debugKey", "script_noteworthy" );
    utility::flag_wait( "items_database_init" );
    
    foreach ( var_744a8b815801e066 in var_c1d0e2748c1fce2f )
    {
        if ( !isdefined( var_744a8b815801e066.keyname ) && isdefined( var_744a8b815801e066.targetname ) )
        {
            var_f751a0575703f42c = getsubstr( var_744a8b815801e066.targetname, 9, var_744a8b815801e066.targetname.size );
        }
        else
        {
            var_f751a0575703f42c = getsubstr( var_744a8b815801e066.keyname, 9, var_744a8b815801e066.keyname.size );
        }
        
        itembundlename = common_item_database::function_a4f0a21951180013( var_f751a0575703f42c );
        itembundle = getscriptbundle( itembundlename );
        
        if ( isdefined( itembundle ) )
        {
            spawnoptions = { #dropradiusscale:1, #var_8d4f327170228364:1, #var_23d3495c57d61bdf:1, #var_90cdc5dbcd319e5d:1, #var_9161cf0784b6951d:1, #baseangles:var_744a8b815801e066.angles, #baseorigin:var_744a8b815801e066.origin, #spawnpositionindex:0 };
            common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
        }
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x591bc19d, Offset: 0x8c8f
// Size: 0x9e3
function function_508b4e40015a34bf()
{
    precachestring( &"mp_dmz_locks/locked_hydro_storage" );
    precachestring( &"mp_dmz_locks/locked_hydro_apt" );
    precachestring( &"mp_dmz_locks/locked_hydro_weapondrop" );
    precachestring( &"mp_bio_lab/cache_locked_red_door" );
    precachestring( &"mp_bio_lab/cache_locked_blue_door" );
    precachestring( &"mp_bio_lab/cache_locked_green_door" );
    precachestring( &"mp_bio_lab/cache_locked_black_door" );
    precachestring( &"mp_bio_lab/cache_locked_gold_door" );
    precachestring( &"mp_dmz_locks/locked_trapper_door" );
    precachestring( &"mp_dmz_locks/locked_resort_entrance" );
    precachestring( &"mp_dmz_locks/locked_firefighttest01" );
    precachestring( &"mp_dmz_locks/locked_conference_room" );
    precachestring( &"mp_dmz_locks/locked_airport_maintenance" );
    precachestring( &"mp_dmz_locks/locked_underground_shack" );
    precachestring( &"mp_dmz_locks/locked_cliff_room" );
    precachestring( &"mp_dmz_locks/locked_graveyard_house" );
    precachestring( &"mp_dmz_locks/locked_poppy_home" );
    precachestring( &"mp_dmz_locks/locked_western_storage" );
    precachestring( &"mp_dmz_locks/locked_mobile_office" );
    precachestring( &"mp_dmz_locks/locked_crane_building" );
    precachestring( &"mp_dmz_locks/locked_police_lockerroom" );
    precachestring( &"mp_dmz_locks/locked_smugglers_warehouse" );
    precachestring( &"mp_dmz_locks/locked_power_substation" );
    precachestring( &"mp_dmz_locks/locked_cell_phone_shop" );
    precachestring( &"mp_dmz_locks/locked_police_academy_barracks" );
    precachestring( &"mp_dmz_locks/locked_police_academy_lockerroom" );
    precachestring( &"mp_dmz_locks/locked_post_office" );
    precachestring( &"mp_dmz_locks/locked_tv_station" );
    precachestring( &"mp_dmz_locks/locked_shopping_booth" );
    precachestring( &"mp_dmz_locks/locked_apartment_closet" );
    precachestring( &"mp_dmz_locks/locked_north_guard_shack" );
    precachestring( &"mp_dmz_locks/locked_south_guard_shack" );
    precachestring( &"mp_dmz_locks/locked_fort_barrack1" );
    precachestring( &"mp_dmz_locks/locked_antiquities_office" );
    precachestring( &"mp_dmz_locks/locked_munitions_storage" );
    precachestring( &"mp_dmz_locks/locked_officequarters1" );
    precachestring( &"mp_dmz_locks/locked_officequarters2" );
    precachestring( &"mp_dmz_locks/locked_quiet_bedroom" );
    precachestring( &"mp_dmz_locks/locked_auto_shop_sunken" );
    precachestring( &"mp_dmz_locks/locked_server_room" );
    precachestring( &"mp_dmz_locks/locked_sunken_office" );
    precachestring( &"mp_dmz_locks/locked_sunken_second_office" );
    precachestring( &"mp_dmz_locks/locked_hotel_room1" );
    precachestring( &"mp_dmz_locks/locked_hotel_room2" );
    precachestring( &"mp_dmz_locks/locked_dressing_room" );
    precachestring( &"mp_dmz_locks/locked_sec_camera_room" );
    precachestring( &"mp_dmz_locks/locked_gaming_room" );
    precachestring( &"mp_dmz_locks/locked_fish_shack" );
    precachestring( &"mp_dmz_locks/locked_mountain_top_room" );
    precachestring( &"mp_dmz_locks/locked_spotters_view" );
    precachestring( &"mp_dmz_locks/locked_grocery_office" );
    precachestring( &"mp_dmz_locks/locked_neigh_storage_room" );
    precachestring( &"mp_dmz_locks/locked_apartment_closet" );
    precachestring( &"mp_dmz_locks/locked_apartment_snipernest" );
    precachestring( &"mp_dmz_locks/locked_destroyed_telescope" );
    precachestring( &"mp_dmz_locks/locked_groundskeepers" );
    precachestring( &"mp_dmz_locks/locked_lighthouse_room" );
    precachestring( &"mp_dmz_locks/locked_safe_room" );
    precachestring( &"mp_dmz_locks/locked_scientist_apartment" );
    precachestring( &"mp_dmz_locks/locked_secret_comms" );
    precachestring( &"mp_dmz_locks/locked_shopping_booth" );
    precachestring( &"mp_dmz_locks/locked_sira_apartment" );
    precachestring( &"mp_dmz_locks/locked_small_confer_room" );
    precachestring( &"mp_dmz_locks/locked_supply_room" );
    precachestring( &"mp_dmz_locks/locked_tv_computer_room" );
    precachestring( &"mp_dmz_locks/locked_yum_burger" );
    precachestring( &"mp_dmz_locks/locked_interrogation_room" );
    precachestring( &"mp_dmz_locks/locked_control_tower" );
    precachestring( &"mp_dmz_locks/locked_exhume_warehouse" );
    precachestring( &"mp_dmz_locks/locked_fort" );
    precachestring( &"mp_dmz_locks/locked_police_academy" );
    precachestring( &"mp_dmz_locks/locked_sira_mall" );
    precachestring( &"mp_dmz_locks/locked_civic_center" );
    precachestring( &"mp_dmz_locks/locked_embassy" );
    precachestring( &"mp_dmz_locks/locked_post_office_stronghold" );
    precachestring( &"mp_biobunker/boss_key_a_name" );
    precachestring( &"mp_biobunker/boss_key_b_name" );
    precachestring( &"mp_biobunker/hub_key_a_name" );
    precachestring( &"mp_biobunker/hub_key_b_name" );
    precachestring( &"mp_biobunker/water_key_a_name" );
    precachestring( &"mp_biobunker/water_key_b_name" );
    precachestring( &"mp_biobunker/rad_key_a_name" );
    precachestring( &"mp_biobunker/rad_key_b_name" );
    precachestring( &"mp_biobunker/workshop_key_need" );
    precachestring( &"mp_biobunker/stairwell_key_need" );
    precachestring( &"mp_biobunker/stairwell_key_unlock" );
    precachestring( &"mp_biobunker/workshop_key_unlock" );
    precachestring( &"mp_dmz_locks/locked_cartel_warehouse" );
    precachestring( &"mp_dmz_locks/locked_skeleton_room" );
    precachestring( &"mp_dmz_locks/unlock_quarry_storage" );
    precachestring( &"mp_dmz_locks/unlock_quarry_control" );
    precachestring( &"mp_dmz_locks/unlock_quarry_office" );
    precachestring( &"mp_dmz_locks/unlock_hydro_storage" );
    precachestring( &"mp_dmz_locks/unlock_hydro_apt" );
    precachestring( &"mp_dmz_locks/unlock_hydro_weapondrop" );
    precachestring( &"mp_dmz_locks/unlock_trapper_door" );
    precachestring( &"mp_dmz_locks/unlock_resort_entrance" );
    precachestring( &"mp_dmz_locks/unlock_firefighttest01" );
    precachestring( &"mp_dmz_missions/trap_door_unlock" );
    precachestring( &"mp_dmz_locks/unlock_conference_room" );
    precachestring( &"mp_dmz_locks/unlock_airport_maintenance" );
    precachestring( &"mp_dmz_locks/unlock_underground_shack" );
    precachestring( &"mp_dmz_locks/unlock_cliff_room" );
    precachestring( &"mp_dmz_locks/unlock_graveyard_house" );
    precachestring( &"mp_dmz_locks/unlock_poppy_home" );
    precachestring( &"mp_dmz_locks/unlock_western_storage" );
    precachestring( &"mp_dmz_locks/unlock_mobile_office" );
    precachestring( &"mp_dmz_locks/unlock_crane_building" );
    precachestring( &"mp_dmz_locks/unlock_police_lockerroom" );
    precachestring( &"mp_dmz_locks/unlock_smugglers_warehouse" );
    precachestring( &"mp_dmz_locks/unlock_power_substation" );
    precachestring( &"mp_dmz_locks/unlock_cell_phone_shop" );
    precachestring( &"mp_dmz_locks/unlock_police_academy_barracks" );
    precachestring( &"mp_dmz_locks/unlock_police_academy_lockerroom" );
    precachestring( &"mp_dmz_locks/unlock_post_office" );
    precachestring( &"mp_dmz_locks/unlock_tv_station" );
    precachestring( &"mp_dmz_locks/unlock_shopping_booth" );
    precachestring( &"mp_dmz_locks/unlock_apartment_closet" );
    precachestring( &"mp_dmz_locks/unlock_control_room" );
    precachestring( &"mp_dmz_locks/unlock_north_guard_shack" );
    precachestring( &"mp_dmz_locks/unlock_south_guard_shack1" );
    precachestring( &"mp_dmz_locks/unlock_fort_barrack1" );
    precachestring( &"mp_dmz_locks/unlock_antiquities_office" );
    precachestring( &"mp_dmz_locks/unlock_munitions_storage" );
    precachestring( &"mp_dmz_locks/unlock_office_quarters1" );
    precachestring( &"mp_dmz_locks/unlock_office_quarters2" );
    precachestring( &"mp_dmz_locks/unlock_quiet_bedroom" );
    precachestring( &"mp_dmz_locks/unlock_auto_shop_sunken" );
    precachestring( &"mp_dmz_locks/unlock_server_room" );
    precachestring( &"mp_dmz_locks/unlock_sunken_office" );
    precachestring( &"mp_dmz_locks/unlock_sunken_second_office" );
    precachestring( &"mp_dmz_locks/unlock_hotel_room1" );
    precachestring( &"mp_dmz_locks/unlock_hotel_room2" );
    precachestring( &"mp_dmz_locks/unlock_dressing_room" );
    precachestring( &"mp_dmz_locks/unlock_sec_camera_room" );
    precachestring( &"mp_dmz_locks/unlock_gaming_room" );
    precachestring( &"mp_dmz_locks/unlock_fish_shack" );
    precachestring( &"mp_dmz_locks/unlock_mountain_top_room" );
    precachestring( &"mp_dmz_locks/unlock_spotters_view" );
    precachestring( &"mp_dmz_locks/unlock_grocery_office" );
    precachestring( &"mp_dmz_locks/unlock_neigh_storage_room" );
    precachestring( &"mp_dmz_locks/unlock_apartment_closet" );
    precachestring( &"mp_dmz_locks/unlock_apartment_snipernest" );
    precachestring( &"mp_dmz_locks/unlock_destroyed_telescope" );
    precachestring( &"mp_dmz_locks/unlock_groundskeepers" );
    precachestring( &"mp_dmz_locks/unlock_lighthouse_room" );
    precachestring( &"mp_dmz_locks/unlock_safe_house" );
    precachestring( &"mp_dmz_locks/unlock_scientist_apartment" );
    precachestring( &"mp_dmz_locks/unlock_secret_comms" );
    precachestring( &"mp_dmz_locks/unlock_shopping_booth" );
    precachestring( &"mp_dmz_locks/unlock_sira_apartment" );
    precachestring( &"mp_dmz_locks/unlock_small_confer_room" );
    precachestring( &"mp_dmz_locks/unlock_supply_room" );
    precachestring( &"mp_dmz_locks/unlock_tv_computer_room" );
    precachestring( &"mp_dmz_locks/unlock_yum_burger" );
    precachestring( &"mp_dmz_locks/unlock_interrogation_room" );
    precachestring( &"mp_dmz_locks/unlock_control_tower" );
    precachestring( &"mp_dmz_locks/unlock_exhume_warehouse" );
    precachestring( &"mp_dmz_locks/unlock_fort" );
    precachestring( &"mp_dmz_locks/unlock_police_academy" );
    precachestring( &"mp_dmz_locks/unlock_sira_mall" );
    precachestring( &"mp_dmz_locks/unlock_civic_center" );
    precachestring( &"mp_dmz_locks/unlock_embassy" );
    precachestring( &"mp_dmz_locks/unlock_post_office_stronghold" );
    precachestring( &"mp_dmz_locks/unlock_cartel_warehouse" );
    precachestring( &"mp_dmz_locks/unlock_skeleton_room" );
    
    if ( game_utility::function_36de887ad1f5532e() )
    {
        precachestring( &"mp_dmz_locks/locked_delta_aquarium" );
        precachestring( &"mp_dmz_locks/unlock_delta_aquarium" );
        precachestring( &"mp_dmz_locks/locked_delta_cityhall" );
        precachestring( &"mp_dmz_locks/unlock_delta_cityhall" );
        precachestring( &"mp_dmz_locks/locked_delta_firestation" );
        precachestring( &"mp_dmz_locks/unlock_delta_firestation" );
        precachestring( &"mp_dmz_locks/locked_delta_oldmuseum" );
        precachestring( &"mp_dmz_locks/unlock_delta_oldmuseum" );
        precachestring( &"mp_dmz_locks/locked_delta_stadium" );
        precachestring( &"mp_dmz_locks/unlock_delta_stadium" );
        precachestring( &"mp_dmz_locks/locked_delta_terminal" );
        precachestring( &"mp_dmz_locks/unlock_delta_terminal" );
        precachestring( &"mp_dmz_locks/locked_delta_trainstation" );
        precachestring( &"mp_dmz_locks/unlock_delta_trainstation" );
    }
}

// Namespace locksandkeys
// Params 0
// Checksum 0x46d8d950, Offset: 0x967a
// Size: 0x1d28
function function_2a6c42549c9815e2()
{
    level.doorstrings = [];
    level.doorstrings[ "locked_no_key" ] = [];
    level.doorstrings[ "locked_has_key" ] = [];
    level.doorstrings[ "open" ] = [];
    level.doorstrings[ "locked_no_key" ][ "quarry_storage" ] = &"mp_dmz_locks/locked_quarry_storage";
    level.doorstrings[ "locked_no_key" ][ "quarry_control" ] = &"mp_dmz_locks/locked_quarry_control";
    level.doorstrings[ "locked_no_key" ][ "quarry_office" ] = &"mp_dmz_locks/locked_quarry_office";
    level.doorstrings[ "locked_no_key" ][ "hydro_storage" ] = &"mp_dmz_locks/locked_hydro_storage";
    level.doorstrings[ "locked_no_key" ][ "hydro_apt" ] = &"mp_dmz_locks/locked_hydro_apt";
    level.doorstrings[ "locked_no_key" ][ "hydro_weapondrop" ] = &"mp_dmz_locks/locked_hydro_weapondrop";
    level.doorstrings[ "locked_no_key" ][ "hostage_door" ] = &"mp_dmz_missions/locked_hostage_door";
    level.doorstrings[ "locked_no_key" ][ "trap" ] = &"mp_dmz_locks/locked_fortress";
    level.doorstrings[ "locked_no_key" ][ "trapper_door" ] = &"mp_dmz_locks/locked_trapper_door";
    level.doorstrings[ "locked_no_key" ][ "resort_entrance" ] = &"mp_dmz_locks/locked_resort_entrance";
    level.doorstrings[ "locked_no_key" ][ "firefighttest01" ] = &"mp_dmz_locks/locked_firefighttest01";
    level.doorstrings[ "locked_no_key" ][ "biolab_door" ] = &"mp_dmz_locks/locked";
    level.doorstrings[ "locked_no_key" ][ "high_security" ] = &"mp_bio_lab/cache_locked_security_room";
    level.doorstrings[ "locked_no_key" ][ "third_floor" ] = &"mp_bio_lab/cache_locked_security_room";
    level.doorstrings[ "locked_no_key" ][ "red_door" ] = &"mp_bio_lab/cache_locked_red_door";
    level.doorstrings[ "locked_no_key" ][ "blue_door" ] = &"mp_bio_lab/cache_locked_blue_door";
    level.doorstrings[ "locked_no_key" ][ "green_door" ] = &"mp_bio_lab/cache_locked_green_door";
    level.doorstrings[ "locked_no_key" ][ "black_door" ] = &"mp_bio_lab/cache_locked_black_door";
    level.doorstrings[ "locked_no_key" ][ "gold_door" ] = &"mp_bio_lab/cache_locked_gold_door";
    level.doorstrings[ "locked_no_key" ][ "armory_room" ] = &"mp_bio_lab/cache_locked_armory_room";
    level.doorstrings[ "locked_no_key" ][ "conference_room" ] = &"mp_dmz_locks/locked_conference_room";
    level.doorstrings[ "locked_no_key" ][ "maintenance" ] = &"mp_dmz_locks/locked_airport_maintenance";
    level.doorstrings[ "locked_no_key" ][ "undershack" ] = &"mp_dmz_locks/locked_underground_shack";
    level.doorstrings[ "locked_no_key" ][ "cliffroom" ] = &"mp_dmz_locks/locked_cliff_room";
    level.doorstrings[ "locked_no_key" ][ "gravehouse" ] = &"mp_dmz_locks/locked_graveyard_house";
    level.doorstrings[ "locked_no_key" ][ "poppyhome" ] = &"mp_dmz_locks/locked_poppy_home";
    level.doorstrings[ "locked_no_key" ][ "western_storage" ] = &"mp_dmz_locks/locked_western_storage";
    level.doorstrings[ "locked_no_key" ][ "mobile_office" ] = &"mp_dmz_locks/locked_mobile_office";
    level.doorstrings[ "locked_no_key" ][ "crane_building" ] = &"mp_dmz_locks/locked_crane_building";
    level.doorstrings[ "locked_no_key" ][ "policestation" ] = &"mp_dmz_locks/locked_police_lockerroom";
    level.doorstrings[ "locked_no_key" ][ "smugglers_warehouse" ] = &"mp_dmz_locks/locked_smugglers_warehouse";
    level.doorstrings[ "locked_no_key" ][ "power_substation" ] = &"mp_dmz_locks/locked_power_substation";
    level.doorstrings[ "locked_no_key" ][ "cell_phone_shop" ] = &"mp_dmz_locks/locked_cell_phone_shop";
    level.doorstrings[ "locked_no_key" ][ "police_academy_barracks" ] = &"mp_dmz_locks/locked_police_academy_barracks";
    level.doorstrings[ "locked_no_key" ][ "police_lockerroom" ] = &"mp_dmz_locks/locked_police_academy_lockerroom";
    level.doorstrings[ "locked_no_key" ][ "post_office" ] = &"mp_dmz_locks/locked_post_office";
    level.doorstrings[ "locked_no_key" ][ "tv_station" ] = &"mp_dmz_locks/locked_tv_station";
    level.doorstrings[ "locked_no_key" ][ "shopping_booth" ] = &"mp_dmz_locks/locked_shopping_booth";
    level.doorstrings[ "locked_no_key" ][ "apartment_closet" ] = &"mp_dmz_locks/locked_apartment_closet";
    level.doorstrings[ "locked_no_key" ][ "north_guard_shack" ] = &"mp_dmz_locks/locked_north_guard_shack";
    level.doorstrings[ "locked_no_key" ][ "south_guard_shack" ] = &"mp_dmz_locks/locked_south_guard_shack";
    level.doorstrings[ "locked_no_key" ][ "fortbarrack1" ] = &"mp_dmz_locks/locked_fort_barrack1";
    level.doorstrings[ "locked_no_key" ][ "antiquities_office" ] = &"mp_dmz_locks/locked_antiquities_office";
    level.doorstrings[ "locked_no_key" ][ "munitions_storage" ] = &"mp_dmz_locks/locked_munitions_storage";
    level.doorstrings[ "locked_no_key" ][ "office_quarters1" ] = &"mp_dmz_locks/locked_officequarters1";
    level.doorstrings[ "locked_no_key" ][ "office_quarters2" ] = &"mp_dmz_locks/locked_officequarters2";
    level.doorstrings[ "locked_no_key" ][ "quiet_bedroom" ] = &"mp_dmz_locks/locked_quiet_bedroom";
    level.doorstrings[ "locked_no_key" ][ "car_shop" ] = &"mp_dmz_locks/locked_auto_shop_sunken";
    level.doorstrings[ "locked_no_key" ][ "server_room" ] = &"mp_dmz_locks/locked_server_room";
    level.doorstrings[ "locked_no_key" ][ "sunken_top_office" ] = &"mp_dmz_locks/locked_sunken_office";
    level.doorstrings[ "locked_no_key" ][ "sunken_2nd_office" ] = &"mp_dmz_locks/locked_sunken_second_office";
    level.doorstrings[ "locked_no_key" ][ "hotel_room1" ] = &"mp_dmz_locks/locked_hotel_room1";
    level.doorstrings[ "locked_no_key" ][ "hotel_room2" ] = &"mp_dmz_locks/locked_hotel_room2";
    level.doorstrings[ "locked_no_key" ][ "dressing_room" ] = &"mp_dmz_locks/locked_dressing_room";
    level.doorstrings[ "locked_no_key" ][ "sec_camera_room" ] = &"mp_dmz_locks/locked_sec_camera_room";
    level.doorstrings[ "locked_no_key" ][ "gaming_room" ] = &"mp_dmz_locks/locked_gaming_room";
    level.doorstrings[ "locked_no_key" ][ "fishing_shack" ] = &"mp_dmz_locks/locked_fish_shack";
    level.doorstrings[ "locked_no_key" ][ "mountain_top" ] = &"mp_dmz_locks/locked_mountain_top_room";
    level.doorstrings[ "locked_no_key" ][ "spotters_view" ] = &"mp_dmz_locks/locked_spotters_view";
    level.doorstrings[ "locked_no_key" ][ "grocery_office" ] = &"mp_dmz_locks/locked_grocery_office";
    level.doorstrings[ "locked_no_key" ][ "neigh_storage_room" ] = &"mp_dmz_locks/locked_neigh_storage_room";
    level.doorstrings[ "locked_no_key" ][ "apartment_closet" ] = &"mp_dmz_locks/locked_apartment_closet";
    level.doorstrings[ "locked_no_key" ][ "apartment_snipernest" ] = &"mp_dmz_locks/locked_apartment_snipernest";
    level.doorstrings[ "locked_no_key" ][ "destroyed_telescope" ] = &"mp_dmz_locks/locked_destroyed_telescope";
    level.doorstrings[ "locked_no_key" ][ "groundskeepers" ] = &"mp_dmz_locks/locked_groundskeepers";
    level.doorstrings[ "locked_no_key" ][ "lighthouse_room" ] = &"mp_dmz_locks/locked_lighthouse_room";
    level.doorstrings[ "locked_no_key" ][ "safe_house" ] = &"mp_dmz_locks/locked_safe_room";
    level.doorstrings[ "locked_no_key" ][ "scientist_apartment" ] = &"mp_dmz_locks/locked_scientist_apartment";
    level.doorstrings[ "locked_no_key" ][ "secret_comms" ] = &"mp_dmz_locks/locked_secret_comms";
    level.doorstrings[ "locked_no_key" ][ "shopping_booth" ] = &"mp_dmz_locks/locked_shopping_booth";
    level.doorstrings[ "locked_no_key" ][ "sira_apartment" ] = &"mp_dmz_locks/locked_sira_apartment";
    level.doorstrings[ "locked_no_key" ][ "small_confer_room" ] = &"mp_dmz_locks/locked_small_confer_room";
    level.doorstrings[ "locked_no_key" ][ "supply_rooms" ] = &"mp_dmz_locks/locked_supply_room";
    level.doorstrings[ "locked_no_key" ][ "tv_computer_room" ] = &"mp_dmz_locks/locked_tv_computer_room";
    level.doorstrings[ "locked_no_key" ][ "yumyum_burger" ] = &"mp_dmz_locks/locked_yum_burger";
    level.doorstrings[ "locked_no_key" ][ "interrogation_room" ] = &"mp_dmz_locks/locked_interrogation_room";
    level.doorstrings[ "locked_no_key" ][ "control_tower" ] = &"mp_dmz_locks/locked_control_tower";
    level.doorstrings[ "locked_no_key" ][ "civic_center" ] = &"mp_dmz_locks/locked_civic_center";
    level.doorstrings[ "locked_no_key" ][ "sira_mall" ] = &"mp_dmz_locks/locked_sira_mall";
    level.doorstrings[ "locked_no_key" ][ "fort" ] = &"mp_dmz_locks/locked_fort";
    level.doorstrings[ "locked_no_key" ][ "exhume_warehouse" ] = &"mp_dmz_locks/locked_exhume_warehouse";
    level.doorstrings[ "locked_no_key" ][ "post_office_stronghold" ] = &"mp_dmz_locks/locked_post_office_stronghold";
    level.doorstrings[ "locked_no_key" ][ "police_academy" ] = &"mp_dmz_locks/locked_police_academy";
    level.doorstrings[ "locked_no_key" ][ "embassy" ] = &"mp_dmz_locks/locked_embassy";
    level.doorstrings[ "locked_no_key" ][ "blacksite" ] = &"mp_dmz_locks/locked_blacksite";
    level.doorstrings[ "locked_no_key" ][ "br_fortress" ] = &"mp_dmz_locks/locked_br_fortress";
    level.doorstrings[ "locked_no_key" ][ "cartel_warehouse" ] = &"mp_dmz_locks/locked_cartel_warehouse";
    level.doorstrings[ "locked_no_key" ][ "skeleton_key" ] = &"mp_dmz_locks/locked_skeleton_room";
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        level.doorstrings[ "locked_no_key" ][ "sealion_beach_club_bathroom" ] = &"mp_dmz_locks/locked_sealion_beachclub_bathroom";
        level.doorstrings[ "locked_no_key" ][ "sealion_ferry_tourist_information_booth" ] = &"mp_dmz_locks/locked_sealion_ferry_booth";
        level.doorstrings[ "locked_no_key" ][ "sealion_hotel_room_403" ] = &"mp_dmz_locks/locked_sealion_hotel_room_403";
        level.doorstrings[ "locked_no_key" ][ "sealion_lab_office" ] = &"mp_dmz_locks/locked_sealion_lab_office";
        level.doorstrings[ "locked_no_key" ][ "sealion_port_harbor_control" ] = &"mp_dmz_locks/locked_sealion_port_harbor_control";
        level.doorstrings[ "locked_no_key" ][ "sealion_port_managers_office" ] = &"mp_dmz_locks/locked_sealion_port_manager_office";
        level.doorstrings[ "locked_no_key" ][ "sealion_water_treatment_control_center" ] = &"mp_dmz_locks/locked_sealion_watertreatment_cc";
        level.doorstrings[ "locked_no_key" ][ "sealion_castle" ] = &"mp_dmz_locks/locked_sealion_castle";
        level.doorstrings[ "locked_no_key" ][ "sealion_cityhall" ] = &"mp_dmz_locks/locked_sealion_cityhall";
    }
    
    if ( game_utility::function_36de887ad1f5532e() )
    {
        level.doorstrings[ "locked_no_key" ][ "delta_aquarium" ] = &"mp_dmz_locks/locked_delta_aquarium";
        level.doorstrings[ "locked_no_key" ][ "delta_cityhall" ] = &"mp_dmz_locks/locked_delta_cityhall";
        level.doorstrings[ "locked_no_key" ][ "delta_firestation" ] = &"mp_dmz_locks/locked_delta_firestation";
        level.doorstrings[ "locked_no_key" ][ "delta_oldmuseum" ] = &"mp_dmz_locks/locked_delta_oldmuseum";
        level.doorstrings[ "locked_no_key" ][ "delta_stadium" ] = &"mp_dmz_locks/locked_delta_stadium";
        level.doorstrings[ "locked_no_key" ][ "delta_terminal" ] = &"mp_dmz_locks/locked_delta_terminal";
        level.doorstrings[ "locked_no_key" ][ "delta_trainstation" ] = &"mp_dmz_locks/locked_delta_trainstation";
        level.doorstrings[ "locked_no_key" ][ "de_animal_care" ] = &"mp_dmz_locks/cache_locked_delta_animalcare";
        level.doorstrings[ "locked_no_key" ][ "de_shops_02" ] = &"mp_dmz_locks/cache_locked_delta_apartment";
        level.doorstrings[ "locked_no_key" ][ "de_bike_parking_02" ] = &"mp_dmz_locks/cache_locked_delta_bikeparking";
        level.doorstrings[ "locked_no_key" ][ "de_firestation_01" ] = &"mp_dmz_locks/cache_locked_delta_firestation";
        level.doorstrings[ "locked_no_key" ][ "de_waterhome_04" ] = &"mp_dmz_locks/cache_locked_delta_floatinghouse";
        level.doorstrings[ "locked_no_key" ][ "de_homeboat_08" ] = &"mp_dmz_locks/cache_locked_delta_homeboat";
        level.doorstrings[ "locked_no_key" ][ "de_stadium" ] = &"mp_dmz_locks/cache_locked_delta_stadium";
        level.doorstrings[ "locked_no_key" ][ "de_cruise_terminal" ] = &"mp_dmz_locks/cache_locked_delta_cruiseterminal";
        level.doorstrings[ "locked_no_key" ][ "de_block_01" ] = &"mp_dmz_locks/cache_locked_delta_townhouse";
    }
    
    if ( game_utility::function_67dc374c04e4d121() )
    {
        level.doorstrings[ "locked_no_key" ][ "biobunker_fortress" ] = &"mp_dmz_locks/locked_biobunker_fortress";
        level.doorstrings[ "locked_no_key" ][ "datacenter_saferoom" ] = &"mp_biobunker/data_center_safe_door_locked";
        level.doorstrings[ "locked_no_key" ][ "code_on_wall_saferoom" ] = &"mp_biobunker/code_on_wall_safe_door_locked";
        level.doorstrings[ "locked_no_key" ][ "biobunker_stairwell_worn" ] = &"mp_biobunker/stairwell_key_need";
        level.doorstrings[ "locked_no_key" ][ "biobunker_workshop_worn" ] = &"mp_biobunker/workshop_key_need";
    }
    
    level.doorstrings[ "locked_has_key" ][ "quarry_storage" ] = &"mp_dmz_locks/unlock_quarry_storage";
    level.doorstrings[ "locked_has_key" ][ "quarry_control" ] = &"mp_dmz_locks/unlock_quarry_control";
    level.doorstrings[ "locked_has_key" ][ "quarry_office" ] = &"mp_dmz_locks/unlock_quarry_office";
    level.doorstrings[ "locked_has_key" ][ "hydro_storage" ] = &"mp_dmz_locks/unlock_hydro_storage";
    level.doorstrings[ "locked_has_key" ][ "hydro_apt" ] = &"mp_dmz_locks/unlock_hydro_apt";
    level.doorstrings[ "locked_has_key" ][ "hydro_weapondrop" ] = &"mp_dmz_locks/unlock_hydro_weapondrop";
    level.doorstrings[ "locked_has_key" ][ "hostage_door" ] = &"mp_dmz_missions/unlock_hostage_door";
    level.doorstrings[ "locked_has_key" ][ "trap" ] = &"mp_dmz_missions/trap_door_unlock";
    level.doorstrings[ "locked_has_key" ][ "trapper_door" ] = &"mp_dmz_locks/unlock_trapper_door";
    level.doorstrings[ "locked_has_key" ][ "resort_entrance" ] = &"mp_dmz_locks/unlock_resort_entrance";
    level.doorstrings[ "locked_has_key" ][ "firefighttest01" ] = &"mp_dmz_locks/unlock_firefighttest01";
    level.doorstrings[ "locked_has_key" ][ "biolab_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "red_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "blue_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "green_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "black_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "gold_door" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "armory_room" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "third_floor" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "high_security" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "conference_room" ] = &"mp_dmz_locks/unlock_conference_room";
    level.doorstrings[ "locked_has_key" ][ "maintenance" ] = &"mp_dmz_locks/unlock_airport_maintenance";
    level.doorstrings[ "locked_has_key" ][ "undershack" ] = &"mp_dmz_locks/unlock_underground_shack";
    level.doorstrings[ "locked_has_key" ][ "cliffroom" ] = &"mp_dmz_locks/unlock_cliff_room";
    level.doorstrings[ "locked_has_key" ][ "gravehouse" ] = &"mp_dmz_locks/unlock_graveyard_house";
    level.doorstrings[ "locked_has_key" ][ "poppyhome" ] = &"mp_dmz_locks/unlock_poppy_home";
    level.doorstrings[ "locked_has_key" ][ "western_storage" ] = &"mp_dmz_locks/unlock_western_storage";
    level.doorstrings[ "locked_has_key" ][ "mobile_office" ] = &"mp_dmz_locks/unlock_mobile_office";
    level.doorstrings[ "locked_has_key" ][ "crane_building" ] = &"mp_dmz_locks/unlock_crane_building";
    level.doorstrings[ "locked_has_key" ][ "policestation" ] = &"mp_dmz_locks/unlock_police_lockerroom";
    level.doorstrings[ "locked_has_key" ][ "smugglers_warehouse" ] = &"mp_dmz_locks/unlock_smugglers_warehouse";
    level.doorstrings[ "locked_has_key" ][ "power_substation" ] = &"mp_dmz_locks/unlock_power_substation";
    level.doorstrings[ "locked_has_key" ][ "cell_phone_shop" ] = &"mp_dmz_locks/unlock_cell_phone_shop";
    level.doorstrings[ "locked_has_key" ][ "police_academy_barracks" ] = &"mp_dmz_locks/unlock_police_academy_barracks";
    level.doorstrings[ "locked_has_key" ][ "police_lockerroom" ] = &"mp_dmz_locks/unlock_police_academy_lockerroom";
    level.doorstrings[ "locked_has_key" ][ "post_office" ] = &"mp_dmz_locks/unlock_post_office";
    level.doorstrings[ "locked_has_key" ][ "tv_station" ] = &"mp_dmz_locks/unlock_tv_station";
    level.doorstrings[ "locked_has_key" ][ "shopping_booth" ] = &"mp_dmz_locks/unlock_shopping_booth";
    level.doorstrings[ "locked_has_key" ][ "apartment_closet" ] = &"mp_dmz_locks/unlock_apartment_closet";
    level.doorstrings[ "locked_has_key" ][ "control_room" ] = &"mp_dmz_locks/unlock_control_room";
    level.doorstrings[ "locked_has_key" ][ "north_guard_shack" ] = &"mp_dmz_locks/unlock_north_guard_shack";
    level.doorstrings[ "locked_has_key" ][ "south_guard_shack" ] = &"mp_dmz_locks/unlock_south_guard_shack1";
    level.doorstrings[ "locked_has_key" ][ "fortbarrack1" ] = &"mp_dmz_locks/unlock_fort_barrack1";
    level.doorstrings[ "locked_has_key" ][ "antiquities_office" ] = &"mp_dmz_locks/unlock_antiquities_office";
    level.doorstrings[ "locked_has_key" ][ "munitions_storage" ] = &"mp_dmz_locks/unlock_munitions_storage";
    level.doorstrings[ "locked_has_key" ][ "office_quarters1" ] = &"mp_dmz_locks/unlock_office_quarters1";
    level.doorstrings[ "locked_has_key" ][ "office_quarters2" ] = &"mp_dmz_locks/unlock_office_quarters2";
    level.doorstrings[ "locked_has_key" ][ "quiet_bedroom" ] = &"mp_dmz_locks/unlock_quiet_bedroom";
    level.doorstrings[ "locked_has_key" ][ "car_shop" ] = &"mp_dmz_locks/unlock_auto_shop_sunken";
    level.doorstrings[ "locked_has_key" ][ "server_room" ] = &"mp_dmz_locks/unlock_server_room";
    level.doorstrings[ "locked_has_key" ][ "sunken_top_office" ] = &"mp_dmz_locks/unlock_sunken_office";
    level.doorstrings[ "locked_has_key" ][ "sunken_2nd_office" ] = &"mp_dmz_locks/unlock_sunken_second_office";
    level.doorstrings[ "locked_has_key" ][ "hotel_room1" ] = &"mp_dmz_locks/unlock_hotel_room1";
    level.doorstrings[ "locked_has_key" ][ "hotel_room2" ] = &"mp_dmz_locks/unlock_hotel_room2";
    level.doorstrings[ "locked_has_key" ][ "dressing_room" ] = &"mp_dmz_locks/unlock_dressing_room";
    level.doorstrings[ "locked_has_key" ][ "sec_camera_room" ] = &"mp_dmz_locks/unlock_sec_camera_room";
    level.doorstrings[ "locked_has_key" ][ "gaming_room" ] = &"mp_dmz_locks/unlock_gaming_room";
    level.doorstrings[ "locked_has_key" ][ "fishing_shack" ] = &"mp_dmz_locks/unlock_fish_shack";
    level.doorstrings[ "locked_has_key" ][ "mountain_top" ] = &"mp_dmz_locks/unlock_mountain_top_room";
    level.doorstrings[ "locked_has_key" ][ "spotters_view" ] = &"mp_dmz_locks/unlock_spotters_view";
    level.doorstrings[ "locked_has_key" ][ "grocery_office" ] = &"mp_dmz_locks/unlock_grocery_office";
    level.doorstrings[ "locked_has_key" ][ "neigh_storage_room" ] = &"mp_dmz_locks/unlock_neigh_storage_room";
    level.doorstrings[ "locked_has_key" ][ "apartment_closet" ] = &"mp_dmz_locks/unlock_apartment_closet";
    level.doorstrings[ "locked_has_key" ][ "apartment_snipernest" ] = &"mp_dmz_locks/unlock_apartment_snipernest";
    level.doorstrings[ "locked_has_key" ][ "destroyed_telescope" ] = &"mp_dmz_locks/unlock_destroyed_telescope";
    level.doorstrings[ "locked_has_key" ][ "groundskeepers" ] = &"mp_dmz_locks/unlock_groundskeepers";
    level.doorstrings[ "locked_has_key" ][ "lighthouse_room" ] = &"mp_dmz_locks/unlock_lighthouse_room";
    level.doorstrings[ "locked_has_key" ][ "safe_house" ] = &"mp_dmz_locks/unlock_safe_house";
    level.doorstrings[ "locked_has_key" ][ "scientist_apartment" ] = &"mp_dmz_locks/unlock_scientist_apartment";
    level.doorstrings[ "locked_has_key" ][ "secret_comms" ] = &"mp_dmz_locks/unlock_secret_comms";
    level.doorstrings[ "locked_has_key" ][ "shopping_booth" ] = &"mp_dmz_locks/unlock_shopping_booth";
    level.doorstrings[ "locked_has_key" ][ "sira_apartment" ] = &"mp_dmz_locks/unlock_sira_apartment";
    level.doorstrings[ "locked_has_key" ][ "small_confer_room" ] = &"mp_dmz_locks/unlock_small_confer_room";
    level.doorstrings[ "locked_has_key" ][ "supply_rooms" ] = &"mp_dmz_locks/unlock_supply_room";
    level.doorstrings[ "locked_has_key" ][ "tv_computer_room" ] = &"mp_dmz_locks/unlock_tv_computer_room";
    level.doorstrings[ "locked_has_key" ][ "yumyum_burger" ] = &"mp_dmz_locks/unlock_yum_burger";
    level.doorstrings[ "locked_has_key" ][ "interrogation_room" ] = &"mp_dmz_locks/unlock_interrogation_room";
    level.doorstrings[ "locked_has_key" ][ "control_tower" ] = &"mp_dmz_locks/unlock_control_tower";
    level.doorstrings[ "locked_has_key" ][ "civic_center" ] = &"mp_dmz_locks/unlock_civic_center";
    level.doorstrings[ "locked_has_key" ][ "sira_mall" ] = &"mp_dmz_locks/unlock_sira_mall";
    level.doorstrings[ "locked_has_key" ][ "fort" ] = &"mp_dmz_locks/unlock_fort";
    level.doorstrings[ "locked_has_key" ][ "exhume_warehouse" ] = &"mp_dmz_locks/unlock_exhume_warehouse";
    level.doorstrings[ "locked_has_key" ][ "post_office_stronghold" ] = &"mp_dmz_locks/unlock_post_office_stronghold";
    level.doorstrings[ "locked_has_key" ][ "police_academy" ] = &"mp_dmz_locks/unlock_police_academy";
    level.doorstrings[ "locked_has_key" ][ "embassy" ] = &"mp_dmz_locks/unlock_embassy";
    level.doorstrings[ "locked_has_key" ][ "blacksite" ] = &"mp_dmz_locks/unlock_blacksite";
    level.doorstrings[ "locked_has_key" ][ "cartel_warehouse" ] = &"mp_dmz_locks/unlock_cartel_warehouse";
    level.doorstrings[ "locked_has_key" ][ "skeleton_key" ] = &"mp_dmz_locks/unlock_skeleton_room";
    level.doorstrings[ "locked_has_key" ][ "stuck" ] = &"mp_dmz_locks/unlock_door";
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        level.doorstrings[ "locked_has_key" ][ "sealion_beach_club_bathroom" ] = &"mp_dmz_locks/unlock_sealion_beachclub_bathroom";
        level.doorstrings[ "locked_has_key" ][ "sealion_ferry_tourist_information_booth" ] = &"mp_dmz_locks/unlock_sealion_ferry_booth";
        level.doorstrings[ "locked_has_key" ][ "sealion_hotel_room_403" ] = &"mp_dmz_locks/unlock_sealion_hotel_room_403";
        level.doorstrings[ "locked_has_key" ][ "sealion_lab_office" ] = &"mp_dmz_locks/unlock_sealion_lab_office";
        level.doorstrings[ "locked_has_key" ][ "sealion_port_harbor_control" ] = &"mp_dmz_locks/unlock_sealion_port_harbor_control";
        level.doorstrings[ "locked_has_key" ][ "sealion_port_managers_office" ] = &"mp_dmz_locks/unlock_sealion_port_manager_office";
        level.doorstrings[ "locked_has_key" ][ "sealion_water_treatment_control_center" ] = &"mp_dmz_locks/unlock_sealion_watertreatment_cc";
        level.doorstrings[ "locked_has_key" ][ "sealion_castle" ] = &"mp_dmz_locks/unlock_sealion_castle";
        level.doorstrings[ "locked_has_key" ][ "sealion_cityhall" ] = &"mp_dmz_locks/unlock_sealion_cityhall";
    }
    
    if ( game_utility::function_36de887ad1f5532e() )
    {
        level.doorstrings[ "locked_has_key" ][ "delta_aquarium" ] = &"mp_dmz_locks/unlock_delta_aquarium";
        level.doorstrings[ "locked_has_key" ][ "delta_cityhall" ] = &"mp_dmz_locks/unlock_delta_cityhall";
        level.doorstrings[ "locked_has_key" ][ "delta_firestation" ] = &"mp_dmz_locks/unlock_delta_firestation";
        level.doorstrings[ "locked_has_key" ][ "delta_oldmuseum" ] = &"mp_dmz_locks/unlock_delta_oldmuseum";
        level.doorstrings[ "locked_has_key" ][ "delta_stadium" ] = &"mp_dmz_locks/unlock_delta_stadium";
        level.doorstrings[ "locked_has_key" ][ "delta_terminal" ] = &"mp_dmz_locks/unlock_delta_terminal";
        level.doorstrings[ "locked_has_key" ][ "delta_trainstation" ] = &"mp_dmz_locks/unlock_delta_trainstation";
        level.doorstrings[ "locked_has_key" ][ "de_animal_care" ] = &"mp_dmz_locks/cache_unlock_delta_animalcare";
        level.doorstrings[ "locked_has_key" ][ "de_shops_02" ] = &"mp_dmz_locks/cache_unlock_delta_apartment";
        level.doorstrings[ "locked_has_key" ][ "de_bike_parking_02" ] = &"mp_dmz_locks/cache_unlock_delta_bikeparking";
        level.doorstrings[ "locked_has_key" ][ "de_firestation_01" ] = &"mp_dmz_locks/cache_unlock_delta_firestation";
        level.doorstrings[ "locked_has_key" ][ "de_waterhome_04" ] = &"mp_dmz_locks/cache_unlock_delta_floatinghouse";
        level.doorstrings[ "locked_has_key" ][ "de_homeboat_08" ] = &"mp_dmz_locks/cache_unlock_delta_homeboat";
        level.doorstrings[ "locked_has_key" ][ "de_stadium" ] = &"mp_dmz_locks/cache_unlock_delta_stadium";
        level.doorstrings[ "locked_has_key" ][ "de_cruise_terminal" ] = &"mp_dmz_locks/cache_unlock_delta_cruiseterminal";
        level.doorstrings[ "locked_has_key" ][ "de_block_01" ] = &"mp_dmz_locks/cache_unlock_delta_townhouse";
    }
    
    if ( game_utility::function_67dc374c04e4d121() )
    {
        level.doorstrings[ "locked_has_key" ][ "biobunker_fortress" ] = &"mp_dmz_locks/unlock_biobunker_fortress";
        level.doorstrings[ "locked_has_key" ][ "datacenter_saferoom" ] = &"mp_biobunker/data_center_safe_door_unlock";
        level.doorstrings[ "locked_has_key" ][ "code_on_wall_saferoom" ] = &"mp_biobunker/data_center_safe_door_unlock";
        level.doorstrings[ "locked_has_key" ][ "biobunker_workshop_worn" ] = &"mp_biobunker/workshop_key_unlock";
        level.doorstrings[ "locked_has_key" ][ "biobunker_stairwell_worn" ] = &"mp_biobunker/stairwell_key_unlock";
    }
}

// Namespace locksandkeys
// Params 1
// Checksum 0x9819614d, Offset: 0xb3aa
// Size: 0x19, Type: bool
function function_9bc16d6d18aa192a( keyname )
{
    return isdefined( level.var_5cb55d50047df6d2[ keyname ] );
}

