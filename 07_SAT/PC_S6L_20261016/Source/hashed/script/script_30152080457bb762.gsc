// script_30152080457bb762  (hash_30152080457bb762.gscc) (size: 40684 Bytes / 0x9eec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdeb376d6 (3736303318)
// size ...... 40684 (0x9eec)
// includes .. 16  (offset: 0x8d1c)
// strings ... 211 (offset: 0x8d9c)
// dev strs .. 12  (offset: 0x9e50)
// exports ... 53  (offset: 0x743c)
// cseg ...... 0x1156 + 0x62e6 (0x743c)
// imports ... 124 (offset: 0x7c84)
// animtree1 . 0   (offset: 0x9eec)
// animtree2 . 0   (offset: 0x9eec)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\scriptable_door;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\points;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item_database;

#namespace namespace_2745d12b842cc671;

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x61d18ea1, Offset: 0x1174
// Size: 0x270
function init()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    precachestring( &"mp_dmz_locks/locked_fortress" );
    precachestring( &"mp_dmz_locks/stuck" );
    precachestring( &"mp_dmz_locks/locked_testuniquedoor" );
    precachestring( &"mp_dmz_locks/locked" );
    precachestring( &"mp_dmz_locks/locked_fort_barrack1" );
    precachestring( &"mp_dmz_locks/locked_antiquities_office" );
    precachestring( &"mp_dmz_locks/locked_munitions_storage" );
    precachestring( &"mp_dmz_locks/locked_officequarters1" );
    precachestring( &"mp_dmz_locks/locked_officequarters2" );
    precachestring( &"mp_dmz_locks/locked_quiet_bedroom" );
    precachestring( &"jup_ob_item_generics/human_fortress_locked_allforone" );
    precachestring( &"jup_ob_item_generics/human_fortress_locked_chemist" );
    precachestring( &"jup_ob_item_generics/human_fortress_locked_maestro" );
    precachestring( &"jup_ob_item_generics/human_fortress_locked_rainmaker" );
    precachestring( &"jup_ob_item_generics/human_stronghold_locked" );
    precachestring( &"mp_dmz_locks/unlock_fortress" );
    precachestring( &"mp_dmz_locks/unlock_testuniquedoor" );
    precachestring( &"mp_dmz_locks/unlock_door" );
    precachestring( &"mp_dmz_locks/unlock_deadbolt" );
    precachestring( &"mp_dmz_missions/trap_door_unlock" );
    precachestring( &"mp_dmz_locks/unlock_fort_barrack1" );
    precachestring( &"mp_dmz_locks/unlock_antiquities_office" );
    precachestring( &"mp_dmz_locks/unlock_munitions_storage" );
    precachestring( &"mp_dmz_locks/unlock_office_quarters1" );
    precachestring( &"mp_dmz_locks/unlock_office_quarters2" );
    precachestring( &"mp_dmz_locks/unlock_quiet_bedroom" );
    precachestring( &"jup_ob_item_generics/unlock_human_fortress_allforone" );
    precachestring( &"jup_ob_item_generics/unlock_human_fortress_chemist" );
    precachestring( &"jup_ob_item_generics/unlock_human_fortress_maestro" );
    precachestring( &"jup_ob_item_generics/unlock_human_fortress_rainmaker" );
    precachestring( &"jup_ob_item_generics/unlock_human_stronghold" );
    scriptable::scriptable_addusedcallbackbypart( "maphint_lock", &function_7bbcd16bf438811c );
    scriptable::scriptable_addusedcallbackbypart( "maphint_lock_interior", &function_3c73f5993e58f3c1 );
    scriptable_door::function_25c67271e41d8eee( &function_b429ccd735f39c09 );
    scriptable_door::function_c0049536af4b1117( &function_259cc760433a6ea4 );
    scriptable_door::function_369c460bb0ed0820( &doorunlocked );
    function_2a6c42549c9815e2();
    function_cf0a289172e0b581();
    function_e620bce5dc20b6c();
    
    if ( getdvarint( @"scr_disable_unique_doors", 0 ) != 1 )
    {
        function_f9c635d61426abe9();
    }
    
    function_a871fde76b6093c9();
    function_584df56c69b53deb();
    level.var_952f94684868bbb1 = getnoentvolumearray( "locked_space_volume", #script_noteworthy );
    
    /#
        level thread debug_showkeys();
    #/
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0xe4d9831a, Offset: 0x13ec
// Size: 0x50
function function_cf0a289172e0b581()
{
    level.var_621f7bbf74943efa = [];
    level.var_621f7bbf74943efa[ "onPickup" ] = [];
    level.var_621f7bbf74943efa[ "onDrop" ] = [];
    level.var_621f7bbf74943efa[ "onMatchStart" ] = [];
    level.var_621f7bbf74943efa[ "onExtract" ] = [];
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0xfac567f8, Offset: 0x1444
// Size: 0x53, Type: bool
function function_46da5d3784eb9b40( targetlootid )
{
    backpacksize = common_inventory::function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = common_inventory::inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == targetlootid )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0xa077596f, Offset: 0x14a0
// Size: 0x195
function function_b429ccd735f39c09( scriptable, player )
{
    if ( isdefined( scriptable.interiororigin ) && isdefined( scriptable.node ) )
    {
        if ( distance2dsquared( scriptable.interiororigin, player.origin ) < distance2dsquared( scriptable.node.origin, player.origin ) && !isdefined( scriptable.var_c71f7490eecb2cfe ) )
        {
            return &"mp_dmz_locks/unlock_deadbolt";
        }
    }
    
    if ( isstring( scriptable.keyname ) )
    {
        if ( isdefined( level.is_quest_story_mission ) )
        {
            return &"mp_dmz_locks/locked";
        }
        
        keylootid = loot::getlootidfromref( "loot_key_" + scriptable.keyname );
        
        if ( scriptable.activitykey == player.activitykey )
        {
            if ( isdefined( scriptable.activitytype ) )
            {
                return function_175c0568ca5b8b75( scriptable.activitytype );
            }
            else
            {
                return function_175c0568ca5b8b75( scriptable.keyname );
            }
        }
        else if ( isdefined( keylootid ) && player function_46da5d3784eb9b40( keylootid ) )
        {
            return function_175c0568ca5b8b75( scriptable.keyname );
        }
        else if ( scriptable.var_f9e62ae32b47b896 )
        {
            return function_175c0568ca5b8b75( scriptable.keyname );
        }
        else
        {
            return function_25646546862df074( scriptable.keyname );
        }
    }
    
    return &"mp_dmz_locks/locked";
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x1131d713, Offset: 0x163e
// Size: 0xea, Type: bool
function function_81454a65df6d7d9a( scriptablename, player )
{
    defaultlootid = loot::getlootidfromref( scriptablename );
    
    if ( isdefined( defaultlootid ) && player function_46da5d3784eb9b40( defaultlootid ) && defaultlootid != 0 )
    {
        return true;
    }
    
    usedlootid = loot::getlootidfromref( scriptablename + "_used" );
    
    if ( isdefined( usedlootid ) && player function_46da5d3784eb9b40( usedlootid ) && usedlootid != 0 )
    {
        return true;
    }
    
    wornlootid = loot::getlootidfromref( scriptablename + "_worn" );
    
    if ( isdefined( wornlootid ) && player function_46da5d3784eb9b40( wornlootid ) && wornlootid != 0 )
    {
        return true;
    }
    
    var_ee0171bfea63e2ec = loot::getlootidfromref( scriptablename + "_worn_jup" );
    
    if ( isdefined( var_ee0171bfea63e2ec ) && player function_46da5d3784eb9b40( var_ee0171bfea63e2ec ) && var_ee0171bfea63e2ec != 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2745d12b842cc671
// Params 3
// Checksum 0xa3032595, Offset: 0x1731
// Size: 0x33f
function function_259cc760433a6ea4( scriptable, player, var_867f7d84083437ee )
{
    success = 0;
    deadbolt = 0;
    var_196dc9ce8df1961c = isdefined( scriptable ) && isdefined( scriptable.node );
    
    if ( !var_196dc9ce8df1961c )
    {
        return 0;
    }
    
    if ( distance2dsquared( scriptable.interiororigin, player.origin ) < distance2dsquared( scriptable.node.origin, player.origin ) )
    {
        success = 1;
        deadbolt = 1;
    }
    
    if ( isdefined( scriptable.var_c71f7490eecb2cfe ) )
    {
        success = 0;
        deadbolt = 0;
    }
    
    if ( isstring( scriptable.keyname ) )
    {
        if ( scriptable.keyname == "TESTUNIQUEDOOR" )
        {
            success = 1;
        }
        
        keyname = scriptable.keyname;
        var_48f655ccdfba2ea3 = isdefined( scriptable.node.script_noteworthy ) && ( scriptable.node.script_noteworthy == "lockMe_interior" || scriptable.node.script_noteworthy == "lockme_interior" );
        
        if ( var_48f655ccdfba2ea3 )
        {
            keyname = scriptable.keyname + "_interior";
        }
        
        if ( function_81454a65df6d7d9a( "loot_key_" + keyname, player ) )
        {
            success = 1;
        }
        else if ( isdefined( scriptable.fortress ) && activity_manager::function_6ca6a856d360b94e( player.team, scriptable.fortress ) && scriptable.keyname == "fortress" )
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
    
    if ( scriptable.activitykey == player.activitykey )
    {
        success = 1;
    }
    
    if ( scriptable.var_f9e62ae32b47b896 )
    {
        success = 1;
    }
    
    if ( var_867f7d84083437ee )
    {
        if ( !success )
        {
            playsoundatpos( scriptable.node.origin, "mp_door_locked" );
        }
        else if ( deadbolt )
        {
            playsoundatpos( scriptable.node.origin, "mp_door_unlock_deadbolt" );
        }
        else
        {
            var_c912f290defbfb5f = "mp_door_unlock_key";
            
            if ( isdefined( scriptable.var_bf9b84f5b2d60f24 ) )
            {
                var_c912f290defbfb5f = scriptable.var_bf9b84f5b2d60f24;
            }
            
            playsoundatpos( scriptable.node.origin, var_c912f290defbfb5f );
        }
    }
    
    return success;
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x4de58765, Offset: 0x1a79
// Size: 0x2f8
function function_9e0cea3f28929d05( scriptable, unlocker )
{
    var_c7f51d2f16dc2a59 = getdvarint( @"hash_291ad74097993a0a", 1 ) == 1;
    var_9e80c41bbb74aef4 = 0;
    isstronghold = 0;
    isfortress = 0;
    players = [];
    players[ players.size ] = unlocker;
    
    if ( utility::issharedfuncdefined( #"squad_utility", #"hash_ca8a81a3ee73b2f6" ) )
    {
        players = unlocker [[ utility::getsharedfunc( #"squad_utility", #"hash_ca8a81a3ee73b2f6" ) ]]();
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

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0xc50ea952, Offset: 0x1d79
// Size: 0x131
function function_d39456776fcadb79( rootkeyname, player )
{
    var_ee0171bfea63e2ec = loot::getlootidfromref( rootkeyname + "_worn_jup" );
    
    if ( isdefined( var_ee0171bfea63e2ec ) && player function_46da5d3784eb9b40( var_ee0171bfea63e2ec ) && var_ee0171bfea63e2ec != 0 )
    {
        return [ rootkeyname + "_worn_jup", 2 ];
    }
    
    wornlootid = loot::getlootidfromref( rootkeyname + "_worn" );
    
    if ( isdefined( wornlootid ) && player function_46da5d3784eb9b40( wornlootid ) && wornlootid != 0 )
    {
        return [ rootkeyname + "_worn", 2 ];
    }
    
    usedlootid = loot::getlootidfromref( rootkeyname + "_used" );
    
    if ( isdefined( usedlootid ) && player function_46da5d3784eb9b40( usedlootid ) && usedlootid != 0 )
    {
        return [ rootkeyname + "_used", 1 ];
    }
    
    defaultlootid = loot::getlootidfromref( rootkeyname );
    
    if ( isdefined( defaultlootid ) && player function_46da5d3784eb9b40( defaultlootid ) && defaultlootid != 0 )
    {
        return [ rootkeyname, 0 ];
    }
    
    return [ undefined, undefined ];
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x6f096cbb, Offset: 0x1eb3
// Size: 0xb3
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
    
    if ( distance2dsquared( scriptable.interiororigin, player.origin ) > distance2dsquared( scriptable.node.origin, player.origin ) || isdefined( scriptable.var_c71f7490eecb2cfe ) )
    {
        player thread function_9701b52d0b43d209( scriptable, player );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0xf6e5ec71, Offset: 0x1f6e
// Size: 0x127
function function_9701b52d0b43d209( scriptable, player )
{
    player endon( #"death_or_disconnect" );
    
    if ( function_8e35e1e94a7cedc1( scriptable ) )
    {
        [ scriptablename, keylevel ] = function_d39456776fcadb79( "loot_key_" + scriptable.keyname, player );
        
        if ( isdefined( scriptablename ) && isdefined( keylevel ) )
        {
            keylootid = loot::getlootidfromref( scriptablename );
            var_995b2e38b94f5ea0 = function_ae5d9b7deff0179b( "loot_key_" + scriptable.keyname, keylevel );
            
            if ( !isdefined( var_995b2e38b94f5ea0 ) )
            {
                soundorigin = scriptable.origin;
                wait 1;
                playsoundatpos( soundorigin, "mp_door_key_break" );
                player common_inventory::function_d1993196b2bcf62d( keylootid );
            }
            else
            {
                index = player common_inventory::function_d57aa72eb94634f9( keylootid );
                player common_inventory::inventory_setbackpackitematindex( index, var_995b2e38b94f5ea0, 1 );
            }
            
            function_9e0cea3f28929d05( scriptable, player );
        }
    }
    
    if ( !function_8e35e1e94a7cedc1( scriptable ) )
    {
        function_9e0cea3f28929d05( scriptable, player );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 1, eflags: 0x4
// Checksum 0x9cef4df1, Offset: 0x209d
// Size: 0x4e, Type: bool
function private function_8e35e1e94a7cedc1( scriptable )
{
    if ( isstring( scriptable.keyname ) )
    {
        return ( !issubstr( scriptable.keyname, "fortress" ) && !issubstr( scriptable.keyname, "human_stronghold" ) );
    }
    
    return false;
}

// Namespace namespace_2745d12b842cc671
// Params 4
// Checksum 0x5022bae0, Offset: 0x20f4
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
        keycount = player br_default_inventory::function_1c4df4a60ee9b86a( keylootid );
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

// Namespace namespace_2745d12b842cc671
// Params 3
// Checksum 0x6d67309b, Offset: 0x217e
// Size: 0x2e
function function_c9f45c822b486ee4( category, keyname, callback )
{
    level.var_621f7bbf74943efa[ category ][ keyname ] = callback;
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0xb716092a, Offset: 0x21b4
// Size: 0x12d
function function_774c7440eb2cceab()
{
    if ( isdefined( level.uniquedoors ) )
    {
        return;
    }
    
    level.uniquedoors = [];
    
    foreach ( key, nodes in level.struct_class_names[ "script_noteworthy" ] )
    {
        if ( issubstr( tolower( key ), "uniquedoor" ) )
        {
            foreach ( node in nodes )
            {
                level.uniquedoors = locksandkeys::function_f4d67875159a0119( node, level.uniquedoors, getsubstr( key, 11 ), 1 );
            }
        }
    }
}

// Namespace namespace_2745d12b842cc671
// Params 0, eflags: 0x4
// Checksum 0xb939a5c9, Offset: 0x22e9
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

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x13c336d9, Offset: 0x238d
// Size: 0x13
function lockscriptabledoor( door )
{
    door scriptabledoorlock();
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x27f4436c, Offset: 0x23a8
// Size: 0x32
function unlockscriptabledoor( door )
{
    door scriptabledoorunlock();
    
    if ( isdefined( door.connecteddoor ) )
    {
        door.connecteddoor scriptabledoorunlock();
    }
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0xa048f003, Offset: 0x23e2
// Size: 0xbf
function function_bfec62fe69e3f84b( button )
{
    button setscriptablepartstate( #"arcwire_transmitter", #"standby" );
    doors = getentitylessscriptablearray( button.target, #targetname );
    
    foreach ( door in doors )
    {
        door notify( #"activate", button );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0xd2412038, Offset: 0x24a9
// Size: 0x42
function function_1778869f89e5e16a( struct )
{
    if ( isdefined( struct.target ) )
    {
        doors = getentitylessscriptablearray( struct.target, #targetname );
        return doors;
    }
}

// Namespace namespace_2745d12b842cc671
// Params 6
// Checksum 0x21a8e77f, Offset: 0x24f3
// Size: 0x48
function function_7bbcd16bf438811c( instance, part, state, player, bautouse, usestring )
{
    level thread function_2ac7944f3d7256a7( instance, part, state, player, bautouse );
}

// Namespace namespace_2745d12b842cc671
// Params 5
// Checksum 0x40e37b8a, Offset: 0x2543
// Size: 0x15c
function function_2ac7944f3d7256a7( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( "maphint_lock", "off" );
    playsoundatpos( instance.origin, "emt_bunk_red_button_press" );
    playsoundatpos( instance.origin, "br_keypad_confirm" );
    
    if ( isdefined( instance.door ) )
    {
        unlockscriptabledoor( instance.door );
    }
    else if ( isdefined( instance.button ) )
    {
        function_bfec62fe69e3f84b( instance.button );
    }
    
    if ( instance.interiorhint )
    {
        instance.interiorhint setscriptablepartstate( #"maphint_lock_interior", #"off" );
    }
    
    if ( isdefined( instance.door.var_de79f5d2971427a8 ) )
    {
        [[ instance.door.var_de79f5d2971427a8 ]]( instance.door, player );
    }
    
    if ( isdefined( instance.button.var_cebadb03a69247f8 ) )
    {
        [[ instance.button.var_cebadb03a69247f8 ]]( instance.button, player );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 6
// Checksum 0x645105fd, Offset: 0x26a7
// Size: 0x48
function function_3c73f5993e58f3c1( instance, part, state, player, bautouse, usestring )
{
    level thread function_5970ac5d492caad8( instance, part, state, player, bautouse );
}

// Namespace namespace_2745d12b842cc671
// Params 5
// Checksum 0xd9c8169d, Offset: 0x26f7
// Size: 0x149
function function_5970ac5d492caad8( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( "maphint_lock_interior", "off" );
    playsoundatpos( instance.origin, "emt_bunk_red_button_press" );
    wait 1;
    playsoundatpos( instance.origin, "br_keypad_confirm" );
    
    if ( isdefined( instance.door ) )
    {
        unlockscriptabledoor( instance.door );
    }
    else if ( isdefined( instance.button ) )
    {
        function_bfec62fe69e3f84b( instance.button );
    }
    
    instance.exteriorhint setscriptablepartstate( "maphint_lock", "off" );
    
    if ( isdefined( instance.door.var_de79f5d2971427a8 ) )
    {
        [[ instance.door.var_de79f5d2971427a8 ]]( instance.door, player );
    }
    
    if ( isdefined( instance.button.var_cebadb03a69247f8 ) )
    {
        [[ instance.button.var_cebadb03a69247f8 ]]( instance.button, player );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 8
// Checksum 0xa140fecc, Offset: 0x2848
// Size: 0x50b
function function_f4d67875159a0119( node, var_96014805038d9f44, keyname, highpriority, var_da376b2c2626fde4, var_d2c6b418df056acb, var_1d6fe999fcc2690c, var_c885c80d530064b5 )
{
    index = var_96014805038d9f44.size;
    var_5cc1cfa65c91128f = 75;
    var_230e8efe569a9e52 = 75;
    
    if ( isdefined( var_1d6fe999fcc2690c ) )
    {
        var_5cc1cfa65c91128f = var_1d6fe999fcc2690c;
    }
    
    if ( isdefined( var_c885c80d530064b5 ) )
    {
        var_230e8efe569a9e52 = var_c885c80d530064b5;
    }
    
    doors = get_scriptable_door_in_radius( node.origin, var_5cc1cfa65c91128f, var_230e8efe569a9e52, var_d2c6b418df056acb );
    var_b900b87f1fda6bc6 = 0;
    
    foreach ( door in doors )
    {
        if ( isdefined( door.type ) && issubstr( door.type, "invisible" ) )
        {
            var_b900b87f1fda6bc6 = 1;
            break;
        }
    }
    
    if ( var_b900b87f1fda6bc6 )
    {
        var_c32728a2aa8f6689 = [];
        
        foreach ( door in doors )
        {
            if ( isdefined( door.type ) && issubstr( door.type, "invisible" ) )
            {
                if ( var_da376b2c2626fde4 )
                {
                    continue;
                }
                else
                {
                    door setscriptablepartstate( "door", "closed" );
                    var_c32728a2aa8f6689[ var_c32728a2aa8f6689.size ] = door;
                }
                
                continue;
            }
            
            if ( var_da376b2c2626fde4 )
            {
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
        doors[ 1 ].doubledoor = 1;
        
        /#
            if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
            {
                thread debug::drawsphere( node.origin, var_5cc1cfa65c91128f, 900, ( 0, 1, 0 ) );
                thread debug::drawline( node.origin, doors[ 0 ].origin, 900, ( 0, 1, 0 ) );
                thread debug::drawline( node.origin, doors[ 1 ].origin, 900, ( 0, 0, 1 ) );
            }
        #/
    }
    
    /#
        if ( doors.size > 2 )
        {
            println( "<dev string:x24>" + node.origin + "<dev string:x7f>" + doors.size + "<dev string:x8f>" + var_5cc1cfa65c91128f + "<dev string:xa0>" + var_230e8efe569a9e52 );
        }
    #/
    
    if ( isdefined( doors ) )
    {
        foreach ( door in doors )
        {
            if ( isdefined( door ) )
            {
                /#
                    if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
                    {
                        thread debug::drawsphere( door.origin, 2.5, 900, ( 0, 0, 0 ) );
                    }
                #/
                
                if ( door.var_63069d6d381d6f42 && !highpriority )
                {
                    println( "<dev string:xb1>" + door.origin );
                    continue;
                }
                
                var_96014805038d9f44[ index ] = door;
                var_96014805038d9f44[ index ].keyname = keyname;
                var_96014805038d9f44[ index ].var_825726f11627973a = node.origin;
                var_96014805038d9f44[ index ].node = node;
                
                if ( highpriority )
                {
                    var_96014805038d9f44[ index ].var_63069d6d381d6f42 = 1;
                }
                
                forward = anglestoforward( node.angles ?? ( 0, 0, 0 ) );
                var_96014805038d9f44[ index ].interiororigin = door.var_825726f11627973a - forward * 25;
                var_96014805038d9f44[ index ].outerorigin = door.var_825726f11627973a + forward * 60;
                
                if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
                {
                    thread debug::drawline( node.origin, var_96014805038d9f44[ index ].interiororigin, 300, ( 1, 0, 0 ) );
                }
            }
            
            index++;
        }
    }
    
    return var_96014805038d9f44;
}

// Namespace namespace_2745d12b842cc671
// Params 4
// Checksum 0x5a5c2c1, Offset: 0x2d5c
// Size: 0x117
function get_scriptable_door_in_radius( position, radius, maxheightdiff, doors = getentitylessscriptablearray( undefined, undefined, position, radius, "door" ) )
{
    filtereddoors = [];
    
    foreach ( door in doors )
    {
        if ( !door scriptableisdoor() )
        {
            continue;
        }
        
        if ( distance2dsquared( door.origin, position ) < radius * radius )
        {
            if ( isdefined( maxheightdiff ) )
            {
                heightdiff = abs( door.origin[ 2 ] - position[ 2 ] );
                
                if ( heightdiff <= maxheightdiff )
                {
                    filtereddoors[ filtereddoors.size ] = door;
                }
                
                continue;
            }
            
            filtereddoors[ filtereddoors.size ] = door;
        }
    }
    
    return filtereddoors;
}

// Namespace namespace_2745d12b842cc671
// Params 4
// Checksum 0xc5a03568, Offset: 0x2e7c
// Size: 0x11c
function function_3387024fc85970f7( position, radius = 75, maxheightdiff = 75, var_83065fb2f12fbcab = getentitylessscriptablearray( undefined, undefined, position, radius, "arcwire_transmitter" ) )
{
    filteredscriptables = [];
    
    foreach ( item in var_83065fb2f12fbcab )
    {
        if ( distance2dsquared( item.origin, position ) < radius * radius )
        {
            if ( isdefined( maxheightdiff ) )
            {
                heightdiff = abs( item.origin[ 2 ] - position[ 2 ] );
                
                if ( heightdiff <= maxheightdiff )
                {
                    filteredscriptables[ filteredscriptables.size ] = item;
                }
                
                continue;
            }
            
            filteredscriptables[ filteredscriptables.size ] = item;
        }
    }
    
    return filteredscriptables;
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x20c187b6, Offset: 0x2fa1
// Size: 0x11d
function function_a871fde76b6093c9()
{
    level.uniqueblockers = [];
    
    foreach ( key, nodes in level.struct_class_names[ "targetname" ] )
    {
        if ( issubstr( key, "uniqueBlocker" ) )
        {
            foreach ( node in nodes )
            {
                if ( isdefined( node.script_noteworthy ) )
                {
                    level.uniqueblockers[ level.uniqueblockers.size ] = node;
                }
            }
        }
    }
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x4d1dd03a, Offset: 0x30c6
// Size: 0xb2
function function_584df56c69b53deb()
{
    foreach ( node in level.uniqueblockers )
    {
        scriptable = spawnscriptable( "fortress_scriptable_props", node.origin, node.angles );
        scriptable setscriptablepartstate( "scriptable_prop", node.script_noteworthy );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x56c0c37f, Offset: 0x3180
// Size: 0x1760
function function_2a6c42549c9815e2()
{
    level.doorstrings = [];
    level.doorstrings[ "locked_no_key" ] = [];
    level.doorstrings[ "locked_has_key" ] = [];
    level.doorstrings[ "open" ] = [];
    level.doorstrings[ "locked_no_key" ][ "fortress" ] = &"mp_dmz_locks/locked_fortress";
    level.doorstrings[ "locked_no_key" ][ "stuck" ] = &"mp_dmz_locks/stuck";
    level.doorstrings[ "locked_no_key" ][ "testuniquedoor" ] = &"mp_dmz_locks/locked_testuniquedoor";
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
    level.doorstrings[ "locked_no_key" ][ "fortbarrack1_rr" ] = &"mp_dmz_locks/locked_fort_barrack1";
    level.doorstrings[ "locked_no_key" ][ "antiquities_office_rr" ] = &"mp_dmz_locks/locked_antiquities_office";
    level.doorstrings[ "locked_no_key" ][ "munitions_storage_rr" ] = &"mp_dmz_locks/locked_munitions_storage";
    level.doorstrings[ "locked_no_key" ][ "office_quarters1_rr" ] = &"mp_dmz_locks/locked_officequarters1";
    level.doorstrings[ "locked_no_key" ][ "office_quarters2" ] = &"mp_dmz_locks/locked_officequarters2";
    level.doorstrings[ "locked_no_key" ][ "quiet_bedroom_rr" ] = &"mp_dmz_locks/locked_quiet_bedroom";
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
    level.doorstrings[ "locked_no_key" ][ "human_fortress_rainmaker" ] = &"jup_ob_item_generics/human_fortress_locked_rainmaker";
    level.doorstrings[ "locked_no_key" ][ "human_fortress_maestro" ] = &"jup_ob_item_generics/human_fortress_locked_maestro";
    level.doorstrings[ "locked_no_key" ][ "human_fortress_chemist" ] = &"jup_ob_item_generics/human_fortress_locked_chemist";
    level.doorstrings[ "locked_no_key" ][ "human_fortress_allforone" ] = &"jup_ob_item_generics/human_fortress_locked_allforone";
    level.doorstrings[ "locked_no_key" ][ "human_stronghold" ] = &"jup_ob_item_generics/human_stronghold_locked";
    level.doorstrings[ "locked_no_key" ][ "vault" ] = &"jup_ob_objectives/vault_locked";
    level.doorstrings[ "locked_no_key" ][ "military_fob" ] = &"mp_jup_bigmap_locks/military_fob_locked";
    level.doorstrings[ "locked_has_key" ][ "stuck" ] = &"mp_dmz_locks/unlock_door";
    level.doorstrings[ "locked_has_key" ][ "fortress" ] = &"mp_dmz_locks/unlock_fortress";
    level.doorstrings[ "locked_has_key" ][ "testuniquedoor" ] = &"mp_dmz_locks/unlock_testuniquedoor";
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
    level.doorstrings[ "locked_has_key" ][ "fortbarrack1_rr" ] = &"mp_dmz_locks/unlock_fort_barrack1";
    level.doorstrings[ "locked_has_key" ][ "antiquities_office_rr" ] = &"mp_dmz_locks/unlock_antiquities_office";
    level.doorstrings[ "locked_has_key" ][ "munitions_storage_rr" ] = &"mp_dmz_locks/unlock_munitions_storage";
    level.doorstrings[ "locked_has_key" ][ "office_quarters1_rr" ] = &"mp_dmz_locks/unlock_office_quarters1";
    level.doorstrings[ "locked_has_key" ][ "office_quarters2" ] = &"mp_dmz_locks/unlock_office_quarters2";
    level.doorstrings[ "locked_has_key" ][ "quiet_bedroom_rr" ] = &"mp_dmz_locks/unlock_quiet_bedroom";
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
    level.doorstrings[ "locked_has_key" ][ "human_fortress_rainmaker" ] = &"jup_ob_item_generics/unlock_human_fortress_rainmaker";
    level.doorstrings[ "locked_has_key" ][ "human_fortress_maestro" ] = &"jup_ob_item_generics/unlock_human_fortress_maestro";
    level.doorstrings[ "locked_has_key" ][ "human_fortress_chemist" ] = &"jup_ob_item_generics/unlock_human_fortress_chemist";
    level.doorstrings[ "locked_has_key" ][ "human_fortress_allforone" ] = &"jup_ob_item_generics/unlock_human_fortress_allforone";
    level.doorstrings[ "locked_has_key" ][ "human_stronghold" ] = &"jup_ob_item_generics/unlock_human_stronghold";
    level.doorstrings[ "locked_has_key" ][ "vault" ] = &"jup_ob_objectives/vault_locked";
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0xabdf6abc, Offset: 0x48e8
// Size: 0x4c
function function_25646546862df074( doorname )
{
    string = level.doorstrings[ "locked_no_key" ][ tolower( doorname ) ];
    
    if ( !isdefined( string ) )
    {
        string = level.doorstrings[ "locked_no_key" ][ "stuck" ];
    }
    
    return string;
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x2c864473, Offset: 0x493d
// Size: 0x4c
function function_175c0568ca5b8b75( doorname )
{
    string = level.doorstrings[ "locked_has_key" ][ tolower( doorname ) ];
    
    if ( !isdefined( string ) )
    {
        string = level.doorstrings[ "locked_has_key" ][ "stuck" ];
    }
    
    return string;
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x98fccdc0, Offset: 0x4992
// Size: 0x3c
function lockedspaces_init()
{
    if ( getdvarint( @"hash_5cb759b2fdb8657a", 1 ) == 0 )
    {
        return;
    }
    
    utility::flag_wait( "lockedspaces_create_script_initialized" );
    customloot_init();
    function_264d6df31b55827();
    
    /#
        level thread debug_lockedspaces();
    #/
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0xc53784c3, Offset: 0x49d6
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

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x9d53e386, Offset: 0x4aa3
// Size: 0x243
function function_89544928c2f58bb8( var_f1b6ace4fe9a0592 )
{
    nodes = arraycombine( utility::getstructarray( var_f1b6ace4fe9a0592.target, "targetname" ), getentarray( var_f1b6ace4fe9a0592.target, #targetname ) );
    var_f1b6ace4fe9a0592.lockeddoors = [];
    var_f1b6ace4fe9a0592.var_c6ae840b3c497571 = [];
    var_f1b6ace4fe9a0592.var_570cb11292b0a7ec = [];
    
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
                var_f1b6ace4fe9a0592.lockeddoors = function_f4d67875159a0119( node, var_f1b6ace4fe9a0592.lockeddoors, tolower( var_f1b6ace4fe9a0592.targetname ), 0 );
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
        }
    }
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0xddc9001c, Offset: 0x4cee
// Size: 0x27c
function lockedspace_activate( var_23fce58e976cab2f, var_48aa31f0038f1538 )
{
    foreach ( door in var_23fce58e976cab2f.lockeddoors )
    {
        lockscriptabledoor( door );
        
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
    
    scriptables = getentitylessscriptablearray( var_23fce58e976cab2f.target, #targetname, var_23fce58e976cab2f.origin, 3000 );
    
    foreach ( scriptable in scriptables )
    {
        if ( isdefined( scriptable.classname ) && issubstr( scriptable.classname, "scriptable_blocker" ) )
        {
            scriptable setscriptablepartstate( "state", "visible" );
        }
    }
    
    foreach ( node in var_23fce58e976cab2f.var_570cb11292b0a7ec )
    {
        function_902ec65e8afae1a7( node, var_23fce58e976cab2f.targetname );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x5b536062, Offset: 0x4f72
// Size: 0x8a, Type: bool
function function_9894956c856a7904( origin )
{
    foreach ( volume in level.var_952f94684868bbb1 )
    {
        if ( ispointinvolume( origin, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x44276b13, Offset: 0x5005
// Size: 0x56
function function_c23b62df83561dfd( scriptable, player )
{
    player callback::callback( "ob_locked_space_unlocked", { #scriptable:scriptable } );
    callback::callback( #"player_unlock_door", { #player:player, #door:scriptable } );
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0xcede00cb, Offset: 0x5063
// Size: 0xeb
function function_ae5d9b7deff0179b( scriptablename, keylevel )
{
    assert( isdefined( keylevel ), "<dev string:x11c>" );
    assert( isdefined( scriptablename ), "<dev string:x160>" );
    
    if ( !( isdefined( scriptablename ) && isdefined( keylevel ) ) )
    {
        return;
    }
    
    switch ( keylevel )
    {
        case 0:
            var_eedbe8e304e8b8e9 = loot::getlootidfromref( scriptablename + "_used" );
            assert( isdefined( var_eedbe8e304e8b8e9 ), "<dev string:x1aa>" + scriptablename );
            
            if ( !isdefined( var_eedbe8e304e8b8e9 ) )
            {
                return;
            }
            
            return var_eedbe8e304e8b8e9;
        case 1:
            var_eedbe8e304e8b8e9 = loot::getlootidfromref( scriptablename + "_worn" );
            assert( isdefined( var_eedbe8e304e8b8e9 ), "<dev string:x1aa>" + scriptablename + "<dev string:x1d1>" );
            
            if ( !isdefined( var_eedbe8e304e8b8e9 ) )
            {
                return;
            }
            
            return var_eedbe8e304e8b8e9;
        case 2:
            return;
        default:
            return;
    }
}

/#

    // Namespace namespace_2745d12b842cc671
    // Params 0
    // Checksum 0xfdbd6e00, Offset: 0x5156
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

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x134e1a02, Offset: 0x5257
// Size: 0x144
function customloot_init()
{
    if ( getdvarint( @"hash_1e9f946374cb994b", 0 ) )
    {
        return;
    }
    
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

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0xe01c27bb, Offset: 0x53a3
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

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x6e555b16, Offset: 0x5457
// Size: 0x391
function function_902ec65e8afae1a7( node, var_fd0fee515114325 )
{
    if ( getdvarint( @"hash_1e9f946374cb994b", 0 ) )
    {
        return;
    }
    
    var_fd0fee515114325 = tolower( var_fd0fee515114325 );
    
    if ( node.iskey )
    {
        if ( !function_d86a7ac55d81d9f7( var_fd0fee515114325, "key" ) )
        {
            percentagespawn = -1;
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
            
            if ( keyname == "tier1Key" )
            {
                keyname = locksandkeys::function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20 );
            }
            else if ( keyname == "tier2Key" )
            {
                keyname = locksandkeys::function_6cfc3c4b7773481c( 0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20 );
            }
            else if ( keyname == "tier3Key" )
            {
                keyname = locksandkeys::function_6cfc3c4b7773481c( 0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20 );
            }
            else if ( keyname == "heroKey" )
            {
                keyname = locksandkeys::function_6cfc3c4b7773481c( 0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20 );
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( node.origin, node.angles );
            
            if ( iscritical )
            {
                spawnoptions.critical = 1;
            }
            
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
        if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) || isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "noteAlreadyPlaced" ] ) )
        {
            return;
        }
        else
        {
            level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "noteAlreadyPlaced" ] = 1;
        }
        
        if ( !function_d86a7ac55d81d9f7( var_fd0fee515114325, "note" ) )
        {
            percentagespawn = -1;
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
            
            if ( node.isnotebook )
            {
                if ( issubstr( notename, "_note_" ) )
                {
                    offset = ( -90, 0, 0 );
                }
            }
            else if ( node.isnote )
            {
                if ( issubstr( notename, "_notebook_" ) )
                {
                    offset = ( 90, 0, 0 );
                }
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( node.origin, node.angles + offset );
            spawnoptions.critical = 1;
            scriptable = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( notename, 1, spawnoptions );
            scriptable.criticalitem = 1;
        }
    }
}

// Namespace namespace_2745d12b842cc671
// Params 2
// Checksum 0x60c69711, Offset: 0x57f0
// Size: 0x9b, Type: bool
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
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "key" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "key" ].dropchance ) )
    {
        return false;
    }
    
    if ( !isint( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ][ "key" ].dropchance ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x47d6dd8d, Offset: 0x5894
// Size: 0x19d
function lockedcache_init()
{
    function_51046be5facc7d42();
    scriptable::scriptable_addusedcallbackbypart( "locked_cache_prompt", &lockedcache_onuse );
    cachenodes = utility::getstructarray( "lockedCache", "targetname" );
    
    foreach ( cachenode in cachenodes )
    {
        cachearray = getentitylessscriptablearray( undefined, undefined, cachenode.origin, 64, "body" );
        
        if ( !isdefined( cachearray ) )
        {
            continue;
        }
        
        cache = cachearray[ 0 ];
        
        if ( !isdefined( cache ) )
        {
            continue;
        }
        
        cache setscriptablepartstate( "body", "closed_locked" );
        forward = anglestoforward( cache.angles );
        scriptable = spawnscriptable( "locked_cache_prompt", cachenode.origin );
        scriptable setscriptablepartstate( "locked_cache_prompt", "on" );
        
        if ( isdefined( cachenode.script_noteworthy ) )
        {
            scriptable.keyname = cachenode.script_noteworthy;
        }
        else
        {
            scriptable.keyname = "generic";
        }
        
        scriptable.cache = cache;
        scriptable.canplaysound = 1;
        cache.islockedcache = 1;
    }
}

// Namespace namespace_2745d12b842cc671
// Params 6
// Checksum 0xcd9e4a5b, Offset: 0x5a39
// Size: 0x3cf
function lockedcache_onuse( instance, part, state, player, bautouse, usestring )
{
    backpackkeyname = instance.keyname;
    
    if ( instance.keyname == "firefightTestContainer" )
    {
        backpackkeyname = "gravesite_container";
    }
    
    if ( !function_81454a65df6d7d9a( "loot_key_" + backpackkeyname, player ) )
    {
        player hud_message::showerrormessage( function_5e2ec4516259a320( backpackkeyname ) );
        
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
    
    cache = instance.cache;
    player thread function_9701b52d0b43d209( instance, player );
    playsoundatpos( instance.origin, "mp_door_unlock_key" );
    savedkeyname = instance.keyname;
    instance freescriptable();
    wait 1;
    cache setscriptablepartstate( "body", "closed_usable" );
    items = getscriptablelootcachecontents( cache );
    cache.containertype = 3;
    common_cache::function_a09e7cf5bad99b64( cache, items, undefined, player );
    itemarray = function_e842399cc012b42c( savedkeyname );
    
    foreach ( item in itemarray )
    {
        itemtable = item.var_c800e3e42139ab19;
        
        if ( !isdefined( itemtable ) )
        {
            continue;
        }
        
        if ( arraycontains( level.br_plunder.names, item.lootitemoverride ) )
        {
            lootid = loot::getlootidfromref( "cash" );
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
        else
        {
            lootid = loot::getlootidfromref( item.lootitemoverride );
            
            if ( level.var_bfa750d9db209a4b )
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
                    count = tablelookup( level.brloottablename, 1, "brloot_" + item.lootitemoverride, 4 );
                }
            }
        }
        
        itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
        common_cache::cache_additem( cache, itembundlename, count );
    }
}

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0x9a42c67c, Offset: 0x5e10
// Size: 0x1ef
function function_51046be5facc7d42()
{
    level.var_b95dc4b6b9b1b53b = [];
    level.var_b95dc4b6b9b1b53b[ "fortress" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_FORTRESS";
    level.var_b95dc4b6b9b1b53b[ "airport_lounge" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_AIRPORT_LOUNGE";
    level.var_b95dc4b6b9b1b53b[ "baggage_handling" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_BAGGAGE_HANDLING";
    level.var_b95dc4b6b9b1b53b[ "end_runway" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_END_RUNWAY";
    level.var_b95dc4b6b9b1b53b[ "caves_bench_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_CAVES_BENCH_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "powerstation_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_POWERSUBSTATION_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "gravesite_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_GRAVESITE_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "waterpit_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_WATERPIT_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "underwater_ship" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERWATER_SHIP";
    level.var_b95dc4b6b9b1b53b[ "clocktower_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_CLOCKTOWER_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "hydro_island_room" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_HYDRO_ISLAND_ROOM";
    level.var_b95dc4b6b9b1b53b[ "ship_bridge" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_BRIDGE";
    level.var_b95dc4b6b9b1b53b[ "ship_center" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_CENTER";
    level.var_b95dc4b6b9b1b53b[ "fishing_box_dock" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_FISHING_BOX_DOCK";
    level.var_b95dc4b6b9b1b53b[ "underthebridge" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERBRIDGE";
    level.var_b95dc4b6b9b1b53b[ "tower_hill" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_TOWER_HILL";
    level.var_b95dc4b6b9b1b53b[ "canal_uw_container" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_CANAL_UW_CONTAINER";
    level.var_b95dc4b6b9b1b53b[ "hallway_locker" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_HALLWAY_LOCKER";
    level.var_b95dc4b6b9b1b53b[ "control_room" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_CONTROL_ROOM";
    level.var_b95dc4b6b9b1b53b[ "ship_above_water" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_SHIP_ABOVE_WATER";
    level.var_b95dc4b6b9b1b53b[ "sunken_ship" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_SUNKEN_SHIP";
    level.var_b95dc4b6b9b1b53b[ "underground_passage" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_UNDERGROUND_PASSAGE";
    level.var_b95dc4b6b9b1b53b[ "police_locker" ] = "MP_DMZ_LOCKS/CACHE_LOCKED_POLICE_LOCKER";
}

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x6e04c847, Offset: 0x6007
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

// Namespace namespace_2745d12b842cc671
// Params 1
// Checksum 0x621ef5c, Offset: 0x604c
// Size: 0x1c4
function function_e842399cc012b42c( var_fd0fee515114325 )
{
    itemarray = [];
    
    if ( isdefined( level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] ) )
    {
        foreach ( potentialitem in level.var_570cb11292b0a7ec[ var_fd0fee515114325 ] )
        {
            if ( potentialitem.lootitemoverride == "tier1Key" )
            {
                potentialitem.lootitemoverride = locksandkeys::function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 20, 60, 20 );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( potentialitem.lootitemoverride == "tier2Key" )
            {
                potentialitem.lootitemoverride = locksandkeys::function_6cfc3c4b7773481c( 0, 1, 0, 0, 0, 1, 0, 0, 20, 60, 20 );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( potentialitem.lootitemoverride == "tier3Key" )
            {
                potentialitem.lootitemoverride = locksandkeys::function_6cfc3c4b7773481c( 0, 0, 1, 0, 0, 0, 1, 0, 20, 60, 20 );
                itemarray[ itemarray.size ] = potentialitem;
                continue;
            }
            
            if ( potentialitem.lootitemoverride == "heroKey" )
            {
                potentialitem.lootitemoverride = locksandkeys::function_6cfc3c4b7773481c( 0, 0, 0, 1, 0, 0, 0, 1, 20, 60, 20 );
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

// Namespace namespace_2745d12b842cc671
// Params 0
// Checksum 0xea3bb0aa, Offset: 0x6219
// Size: 0xb07
function function_e620bce5dc20b6c()
{
    level.var_dbc763981a7a23ab = [];
    level.var_dbc763981a7a23ab[ 1 ] = [];
    level.var_dbc763981a7a23ab[ 2 ] = [];
    level.var_dbc763981a7a23ab[ 3 ] = [];
    level.var_dbc763981a7a23ab[ 4 ] = [];
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "hydro_storage";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "airport_lounge";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "baggage_handling";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "caves_bench_container";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "undershack";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "gravehouse";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "powerstation_container";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "gravesite_container";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "mobile_office";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "groundskeepers";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "clocktower_container";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "hydro_island_room";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "fishing_box_dock";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "supply_rooms";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "power_substation";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "cell_phone_shop";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "underthebridge";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "police_academy_barracks";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "tv_station";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "shopping_booth";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "yumyum_burger";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "tower_hill";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "canal_uw_container";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "small_confer_room";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "hallway_locker";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "north_guard_shack";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "south_guard_shack";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "fortbarrack1";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "office_quarters1";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "sunken_2nd_office";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "sira_apartment";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "gaming_room";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "fishing_shack";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "spotters_view";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "grocery_office";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "neigh_storage_room";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "crane_building";
    level.var_dbc763981a7a23ab[ 1 ][ level.var_dbc763981a7a23ab[ 1 ].size ] = "underwater_ship";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "hydro_apt";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "conference_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "end_runway";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "cliffroom";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "poppyhome";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "waterpit_container";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "lighthouse_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "ship_bridge";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "ship_center";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "policestation";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "smugglers_warehouse";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "interrogation_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "police_lockerroom";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "apartment_closet";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "tv_computer_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "destroyed_telescope";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "scientist_apartment";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "control_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "end_pyro_tunnel";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "munitions_storage";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "car_shop";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "sunken_top_office";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "hotel_room1";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "ship_above_water";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "dressing_room";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "apartment_snipernest";
    level.var_dbc763981a7a23ab[ 2 ][ level.var_dbc763981a7a23ab[ 2 ].size ] = "underground_passage";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "maintenance";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "safe_house";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "western_storage";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "secret_comms";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "post_office";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "antiquities_office";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "quiet_bedroom";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "server_room";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "hotel_room2";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "sunken_ship";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "sec_camera_room";
    level.var_dbc763981a7a23ab[ 3 ][ level.var_dbc763981a7a23ab[ 3 ].size ] = "mountain_top";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "civic_center";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "embassy";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "fort";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "sira_mall";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "resort_entrance";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "police_academy";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "post_office_stronghold";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "control_tower";
    level.var_dbc763981a7a23ab[ 4 ][ level.var_dbc763981a7a23ab[ 4 ].size ] = "exhume_warehouse";
    
    /#
    #/
}

// Namespace namespace_2745d12b842cc671
// Params 11
// Checksum 0x72bcce52, Offset: 0x6d28
// Size: 0x30e
function function_6cfc3c4b7773481c( tier1ok, tier2ok, tier3ok, herook, tier1chance, tier2chance, tier3chance, herochance, pristinechance, usedchance, wornchance )
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
    
    keyname = utility::array_random( level.var_dbc763981a7a23ab[ var_c8a50e71413e866b ] );
    lootkeyname = "loot_key_" + keyname + var_e2e41147eff9a9b0;
    return lootkeyname;
}

/#

    // Namespace namespace_2745d12b842cc671
    // Params 0
    // Checksum 0x244a5378, Offset: 0x703f
    // Size: 0x37, Type: dev
    function function_65dbf6843c462339()
    {
        while ( true )
        {
            randomkey = locksandkeys::function_6cfc3c4b7773481c( 1, 0, 0, 0, 1, 0, 0, 0, 10, 70, 20 );
            println( randomkey );
            waitframe();
        }
    }

    // Namespace namespace_2745d12b842cc671
    // Params 0
    // Checksum 0x2f243378, Offset: 0x707e
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
                    
                    if ( isdefined( item.type ) && ( issubstr( item.type, "<dev string:x272>" ) || issubstr( item.type, "<dev string:x27b>" ) ) )
                    {
                        var_f234efe0dc4d3f2c[ var_f234efe0dc4d3f2c.size ] = item.origin;
                    }
                }
                
                foreach ( cache in cachelocs )
                {
                    cacheitems = getscriptablelootcachecontents( cache );
                    
                    foreach ( item in cacheitems )
                    {
                        if ( item == "<dev string:x1d7>" )
                        {
                            var_6d2f8b8a218a4134[ var_6d2f8b8a218a4134.size ] = cache.origin;
                            continue;
                        }
                        
                        if ( issubstr( item, "<dev string:x272>" ) || issubstr( item, "<dev string:x27b>" ) )
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
