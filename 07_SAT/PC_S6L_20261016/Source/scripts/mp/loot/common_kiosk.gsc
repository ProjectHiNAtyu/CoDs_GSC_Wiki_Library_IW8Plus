// scripts\mp\loot\common_kiosk.gsc  (hash_35fb601da585a5f6.gscc) (size: 33897 Bytes / 0x8469 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4bb250f7 (1269977335)
// size ...... 33897 (0x8469)
// includes .. 26  (offset: 0x7e31)
// strings ... 91  (offset: 0x7f01)
// dev strs .. 4   (offset: 0x8439)
// exports ... 93  (offset: 0x550d)
// cseg ...... 0x707 + 0x4e06 (0x550d)
// imports ... 212 (offset: 0x6395)
// animtree1 . 0   (offset: 0x8469)
// animtree2 . 0   (offset: 0x8469)
#using script_16ea1b94f0f381b3;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\interact_utils;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\loot\common_barter;
#using scripts\mp\loot\common_gunbench;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_kiosk_data;
#using scripts\mp\structspawnconfig;

#namespace common_kiosk;

// Namespace common_kiosk
// Params 0, eflags: 0x5
// Checksum 0xae8721fd, Offset: 0x725
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_kiosk", #"common_item", &init_kiosk, undefined );
}

// Namespace common_kiosk
// Params 0
// Checksum 0xcb657ab3, Offset: 0x74e
// Size: 0x9
function init_kiosk()
{
    thread init_kiosk_thread();
}

// Namespace common_kiosk
// Params 0
// Checksum 0x36a51f9, Offset: 0x75f
// Size: 0x520
function init_kiosk_thread()
{
    ui::lui_registercallback( "br_cancel_purchase", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_item_purchase", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_loadout_purchase", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_team_revive", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_team_revive_all", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_biometric_scan_keycard_exchange", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "br_biometric_scan_consumable_exchange", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "sell_item", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "sell_all_item", &function_b3a53c6f76c87dda );
    ui::lui_registercallback( "sell_all_valuables", &function_b3a53c6f76c87dda );
    level.common_armory_kiosk = spawnstruct();
    level.common_armory_kiosk.instances = [];
    level.common_armory_kiosk.var_fc040a52119313ae = 0;
    level.common_armory_kiosk.var_971f20e392d7da1f = "active";
    usingssc = 0;
    
    if ( function_5274212108b240d3() )
    {
        if ( level.gametypebundle.var_4065642a742c142d )
        {
            usingssc = 1;
            thread initssc();
        }
    }
    else
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    
    if ( isdefined( level.br_armory_kiosk_enabled ) )
    {
        return;
    }
    
    while ( !level.gametypestarted )
    {
        waitframe();
    }
    
    thread waitforprematchdone();
    level.br_armory_kiosk_enabled = 0;
    buystationref = "";
    
    if ( function_5274212108b240d3() )
    {
        level.br_armory_kiosk_enabled = istrue( level.gametypebundle.var_9eab91d8c6448383 );
        buystationref = level.gametypebundle.var_88e227745251a5d3 ?? "";
        setomnvar( "ui_buy_mode", istrue( level.gametypebundle.var_ba3b46f2f6d72e6 ) );
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        level.var_6a8e88d5a8429194.var_d52cfd7261c25075 = level.br_armory_kiosk_enabled;
    }
    
    if ( getdvar( @"br_buy_station", "" ) != "" )
    {
        buystationref = getdvar( @"br_buy_station" );
    }
    
    level.var_60d5b7c260e6353e = getdvarint( @"hash_bbbc98d8b5fe5572", 1 );
    level.var_57bd3795b7064dcd = getdvarint( @"hash_c947122379b41b9f", 5000 );
    
    if ( level.br_armory_kiosk_enabled )
    {
        level.common_kiosk_data = spawnstruct();
        level.common_kiosk_data common_kiosk_data::initialize();
        
        if ( isdefined( buystationref ) && buystationref != "" )
        {
            function_70af9883d65d43fb( buystationref );
        }
        
        scriptable::scriptable_addusedcallback( &armorykioskused );
        scriptable::scriptable_addautousecallback( &armorykioskused );
        level.var_85fce9bda77a32d0 = getdvarint( @"br_kiosk_itemdrop_spawn_override", 1 );
        level.var_6f7fce2d77242e55 = getdvarfloat( @"hash_624b1f6964c696d", 180 );
        level.randomanglemax = getdvarfloat( @"hash_69c62cae4d7929c9", 10 );
        level.itemdropdistance = getdvarfloat( @"hash_9c3612143e0ad401", 1 );
        
        if ( !usingssc )
        {
            instances = function_21e181699df32d49();
            
            if ( isdefined( level.var_190a8d6a5539850d ) )
            {
                [[ level.var_190a8d6a5539850d ]]( instances );
            }
            else if ( level.gametypebundle.var_af8d1fd441909129 )
            {
                function_4250aa4d244b7ff2( instances );
            }
            else
            {
                numspawned = 0;
                kiosks = [];
                
                foreach ( instance in instances )
                {
                    kiosk = function_2282260e9dc07a4b( instance, numspawned );
                    kiosks[ kiosks.size ] = kiosk;
                    numspawned++;
                }
                
                setspawninstances( kiosks );
            }
        }
        
        level.common_armory_kiosk.var_fc040a52119313ae = numspawned;
        
        if ( getdvarint( @"hash_4ba96869b73bdc82", 0 ) )
        {
            buystationref = "br_shopInventory_chocolate";
        }
        
        if ( buystationref != "" )
        {
            setbuystation( buystationref );
        }
        
        if ( isdefined( level.var_4318c8bea60cf625.var_a417fc940cd953b9 ) )
        {
            potentialbuystations = [[ level.var_4318c8bea60cf625.var_a417fc940cd953b9 ]]();
        }
        else
        {
            potentialbuystations = getdvar( @"scr_buy_station_pool" );
        }
        
        if ( potentialbuystations )
        {
            buystationrefs = strtok( potentialbuystations, "," );
            buystationrefs = arrayrandomize( buystationrefs );
            
            for ( var_e38807773a2e6fab = 0; var_e38807773a2e6fab < buystationrefs.size ; var_e38807773a2e6fab++ )
            {
                buystationref = buystationrefs[ var_e38807773a2e6fab ];
                function_7b41071a148cdb79( buystationref );
            }
        }
        
        function_e86f80f00a71942();
        
        if ( getdvar( @"hash_22fcf0c2a5d714c2" ) )
        {
            function_f687bd211d712b96();
        }
        
        utility::flag_set( "br_kiosk_initialized" );
    }
}

// Namespace common_kiosk
// Params 0
// Checksum 0xb534339e, Offset: 0xc87
// Size: 0x3f, Type: bool
function function_5274212108b240d3()
{
    if ( !common_item::items_isenabled() )
    {
        return false;
    }
    
    if ( !level.gametypebundle.var_c4017808ddc790a2 )
    {
        return false;
    }
    
    if ( getdvarint( @"scr_enable_common_kiosk", 1 ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace common_kiosk
// Params 1
// Checksum 0x3c518bc0, Offset: 0xccf
// Size: 0x1e
function function_70af9883d65d43fb( buystationref )
{
    level.common_kiosk_data common_kiosk_data::function_70af9883d65d43fb( buystationref );
}

// Namespace common_kiosk
// Params 2
// Checksum 0xc9436718, Offset: 0xcf5
// Size: 0x5b
function function_5cf3d883ddbd18c7( buystationindex, player )
{
    buystationref = level.common_kiosk_data common_kiosk_data::function_bc4c6e4a3e7d611a( buystationindex );
    
    if ( isdefined( buystationref ) && buystationref != "" )
    {
        function_70af9883d65d43fb( buystationref );
        player setclientomnvar( "ui_buystation_override", buystationindex );
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x36ce4bcc, Offset: 0xd58
// Size: 0x25
function function_7b41071a148cdb79( buystationref )
{
    level.common_kiosk_data common_kiosk_data::function_7b41071a148cdb79( buystationref );
    function_e86f80f00a71942();
}

// Namespace common_kiosk
// Params 0
// Checksum 0xcfdfda41, Offset: 0xd85
// Size: 0x11
function function_c3950de54d46edf()
{
    return level.common_kiosk_data common_kiosk_data::function_c3950de54d46edf();
}

// Namespace common_kiosk
// Params 0
// Checksum 0x8fd7ba02, Offset: 0xd9f
// Size: 0x11
function function_35ca093604c118e6()
{
    return level.common_kiosk_data common_kiosk_data::function_f848553e07fc98a7();
}

// Namespace common_kiosk
// Params 1
// Checksum 0xc504b75d, Offset: 0xdb9
// Size: 0x1d
function function_c6883cb97d900a3b( var_317f3ab12fa62d40 )
{
    return level.common_kiosk_data common_kiosk_data::function_c6883cb97d900a3b( var_317f3ab12fa62d40 );
}

// Namespace common_kiosk
// Params 0
// Checksum 0xaec968, Offset: 0xddf
// Size: 0x21, Type: bool
function function_7d8fb6819851b1f2()
{
    return level.gametypebundle.var_493473e493cdb185 ?? %"br_plunder_box";
}

// Namespace common_kiosk
// Params 0
// Checksum 0x46f935f4, Offset: 0xe09
// Size: 0x4d
function initssc()
{
    level endon( #"game_ended" );
    utility::flag_wait( "ssc_initialized" );
    structspawnconfig::function_7418a260adaec05( "buy_station", &function_8fb217c80c784261 );
    structspawnconfig::function_8c0a09968efe9138( "buy_station", &function_170f3c6c5edd882c );
    structspawnconfig::function_36050499b5f48983( "buy_station", &function_1a496a229e8cc6f7 );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x646e3982, Offset: 0xe5e
// Size: 0xb7
function function_8fb217c80c784261( structname )
{
    scriptables = getentitylessscriptablearray( function_7d8fb6819851b1f2() );
    structs = utility::getstructarray( level.gametypebundle.var_7438ed64f7a7ef1e, "targetname" );
    
    if ( isdefined( level.common_armory_kiosk.var_fac8ead806250fe9 ) )
    {
        return ( level.common_armory_kiosk.var_fac8ead806250fe9 ? scriptables : structs );
    }
    
    if ( scriptables.size > 0 )
    {
        level.common_armory_kiosk.var_fac8ead806250fe9 = 1;
        return scriptables;
    }
    
    level.common_armory_kiosk.var_fac8ead806250fe9 = 0;
    return structs;
}

// Namespace common_kiosk
// Params 2
// Checksum 0x907483b3, Offset: 0xf1e
// Size: 0xab
function function_170f3c6c5edd882c( structname, station )
{
    if ( isstruct( station ) )
    {
        if ( !isdefined( level.common_armory_kiosk.var_940cbeb74e784467 ) )
        {
            level.common_armory_kiosk.var_940cbeb74e784467 = [];
        }
        
        level.common_armory_kiosk.var_940cbeb74e784467[ level.common_armory_kiosk.var_940cbeb74e784467.size ] = station;
    }
    else
    {
        level.common_armory_kiosk.instances[ level.common_armory_kiosk.instances.size ] = station;
        function_c2aeca6951d7641e( station );
    }
    
    return station;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xdca90d97, Offset: 0xfd2
// Size: 0x120
function function_1a496a229e8cc6f7( structname )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.common_armory_kiosk.var_940cbeb74e784467 ) )
    {
        foreach ( location in level.common_armory_kiosk.var_940cbeb74e784467 )
        {
            kiosk = function_2282260e9dc07a4b( location, level.common_armory_kiosk.instances.size );
            level.common_armory_kiosk.instances[ level.common_armory_kiosk.instances.size ] = kiosk;
        }
    }
    
    level.common_armory_kiosk.sscinstances = undefined;
    utility::flag_set( "buy_stations_spawned" );
    function_6429f67365dadd21();
}

// Namespace common_kiosk
// Params 1
// Checksum 0x2bf6450d, Offset: 0x10fa
// Size: 0x2e
function setbuystation( stationref )
{
    setdvar( @"br_buy_station", stationref );
    level.common_kiosk_data common_kiosk_data::function_70af9883d65d43fb( stationref );
}

// Namespace common_kiosk
// Params 0
// Checksum 0x6fbec8c1, Offset: 0x1130
// Size: 0x19, Type: bool
function function_5c2447fa1580c330()
{
    return level.common_armory_kiosk.instances ?? [];
}

// Namespace common_kiosk
// Params 0
// Checksum 0xd3dd8e06, Offset: 0x1152
// Size: 0x7c
function function_21e181699df32d49()
{
    if ( !level.br_armory_kiosk_enabled )
    {
        return;
    }
    
    allspawninstances = [];
    
    if ( level.gametypebundle.var_dd3b68148170b229 && isdefined( level.gametypebundle.var_7438ed64f7a7ef1e ) )
    {
        allspawninstances = utility::getstructarray( level.gametypebundle.var_7438ed64f7a7ef1e, "targetname" );
    }
    else
    {
        allspawninstances = getentitylessscriptablearray( function_7d8fb6819851b1f2() );
    }
    
    return allspawninstances;
}

// Namespace common_kiosk
// Params 1
// Checksum 0x75d71752, Offset: 0x11d7
// Size: 0x39
function function_ea4e5fb141e28d6e( onspawnfunc )
{
    if ( !isdefined( level.var_742e2e06c6c0aada ) )
    {
        level.var_742e2e06c6c0aada = [];
    }
    
    level.var_742e2e06c6c0aada[ level.var_742e2e06c6c0aada.size ] = onspawnfunc;
}

// Namespace common_kiosk
// Params 1
// Checksum 0x33e11b99, Offset: 0x1218
// Size: 0x39
function function_b08c98be8b26da9a( conditional )
{
    if ( !isdefined( level.var_2be7b673ec98968e ) )
    {
        level.var_2be7b673ec98968e = [];
    }
    
    level.var_2be7b673ec98968e[ level.var_2be7b673ec98968e.size ] = conditional;
}

// Namespace common_kiosk
// Params 2
// Checksum 0xf9135325, Offset: 0x1259
// Size: 0xa1
function shouldspawnkiosk( kiosk, area )
{
    shouldspawn = 1;
    
    foreach ( conditional in level.var_2be7b673ec98968e )
    {
        shouldspawn = shouldspawn && [[ conditional ]]( kiosk, area );
    }
    
    return shouldspawn;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xf3c81d99, Offset: 0x1303
// Size: 0x39
function function_34c8a2803f1f0cb4( overridefunc )
{
    if ( !isdefined( level.var_b526bd14542117a4 ) )
    {
        level.var_b526bd14542117a4 = [];
    }
    
    level.var_b526bd14542117a4[ level.var_b526bd14542117a4.size ] = overridefunc;
}

// Namespace common_kiosk
// Params 2
// Checksum 0x41df44a6, Offset: 0x1344
// Size: 0x9e
function function_d56f3ed300f99977( kiosk, area )
{
    foreach ( overridefunc in level.var_b526bd14542117a4 )
    {
        overrideindex = [[ overridefunc ]]( kiosk, area );
        
        if ( isdefined( overrideindex ) )
        {
            return overrideindex;
        }
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0xef71cf47, Offset: 0x13eb
// Size: 0x30
function setspawninstances( instances )
{
    assert( isarray( instances ) );
    level.common_armory_kiosk.instances = instances;
}

// Namespace common_kiosk
// Params 1
// Checksum 0x3db3693e, Offset: 0x1423
// Size: 0x5d
function function_27da31038bf50233( instance )
{
    assert( isdefined( level.common_armory_kiosk.instances ) );
    stationsspawned = level.common_armory_kiosk.instances.size;
    scriptedkiosk = function_2282260e9dc07a4b( instance, stationsspawned );
    return scriptedkiosk;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xd3c8c31e, Offset: 0x1489
// Size: 0x1d
function function_9d041619b6fccf18( buystationref )
{
    return level.common_kiosk_data common_kiosk_data::function_9d041619b6fccf18( buystationref );
}

// Namespace common_kiosk
// Params 2
// Checksum 0xb7cf4a20, Offset: 0x14af
// Size: 0x19e
function function_2282260e9dc07a4b( instance, stationsspawned )
{
    if ( isdefined( instance.var_553cc8efe969a2a8 ) )
    {
        buystationindex = function_9d041619b6fccf18( instance.var_553cc8efe969a2a8 );
    }
    else
    {
        buystationsinuse = function_c3950de54d46edf();
        
        if ( isdefined( buystationsinuse ) && buystationsinuse.size > 0 )
        {
            buystationindex = function_9c81111e1ef4084b( stationsspawned, buystationsinuse )[ "index" ];
        }
    }
    
    kioskscriptable = spawnscriptable( function_7d8fb6819851b1f2(), instance.origin, instance.angles );
    
    if ( gamelogic_mp::inprematch() )
    {
        hideobjective( kioskscriptable );
        kioskscriptable.visible = 0;
    }
    else
    {
        kioskscriptable setscriptablepartstate( "br_plunder_box", "visible" );
        showobjective( kioskscriptable );
        kioskscriptable.visible = 1;
    }
    
    if ( isdefined( buystationindex ) )
    {
        kioskscriptable.overrideindex = buystationindex;
    }
    
    if ( isdefined( level.var_742e2e06c6c0aada ) )
    {
        foreach ( spawnfunc in level.var_742e2e06c6c0aada )
        {
            [[ spawnfunc ]]( kioskscriptable, instance );
        }
    }
    
    instance.scriptable = kioskscriptable;
    function_9bd56003858f6090( instance );
    function_c2aeca6951d7641e( kioskscriptable );
    return kioskscriptable;
}

// Namespace common_kiosk
// Params 0
// Checksum 0x1dc20378, Offset: 0x1656
// Size: 0x94
function function_95f13d141203a55b()
{
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        if ( isdefined( armorykiosk.visible ) )
        {
            function_cd2eb56f7058384a( armorykiosk );
        }
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x8829625e, Offset: 0x16f2
// Size: 0x157
function function_cd2eb56f7058384a( armorykiosk )
{
    if ( !isdefined( armorykiosk ) )
    {
        return;
    }
    
    currentstate = armorykiosk getscriptablepartstate( "br_plunder_box" );
    openstates = [ "open", "opening", "firesale_open", "firesale_opening" ];
    newstate = arraycontains( openstates, currentstate ) ? "closing" : "disabled";
    armorykiosk setscriptablepartstate( "br_plunder_box", newstate );
    hideobjective( armorykiosk );
    armorykiosk.visible = undefined;
    armorykiosk.disabled = 1;
    
    foreach ( player in level.players )
    {
        if ( player.common_kiosk == armorykiosk )
        {
            player _closepurchasemenuwithresponse( 2 );
        }
    }
    
    level notify( "buystation_kill_callout_" + armorykiosk.origin );
    function_6429f67365dadd21();
    function_468713a0473770af( armorykiosk );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x42ec2bb5, Offset: 0x1851
// Size: 0x64
function function_50a87808f478947f( armorykiosk )
{
    if ( !isdefined( armorykiosk ) )
    {
        return;
    }
    
    if ( armorykiosk.var_96c948fbd84c94a6 )
    {
        return;
    }
    
    armorykiosk setscriptablepartstate( "br_plunder_box", "visible" );
    showobjective( armorykiosk );
    armorykiosk.visible = 1;
    armorykiosk.disabled = undefined;
    function_6429f67365dadd21();
    function_c2aeca6951d7641e( armorykiosk );
}

// Namespace common_kiosk
// Params 0, eflags: 0x4
// Checksum 0x42e74045, Offset: 0x18bd
// Size: 0xd6
function private function_6429f67365dadd21()
{
    count = 0;
    
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        if ( armorykiosk.visible && !armorykiosk.disabled )
        {
            count++;
        }
    }
    
    level.common_armory_kiosk.var_fc040a52119313ae = count;
    
    if ( hasomnvar( "ui_game_count_enabled_buy_station" ) )
    {
        setomnvar( "ui_game_count_enabled_buy_station", count );
    }
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x8c3a0bff, Offset: 0x199b
// Size: 0x127
function private function_9bd56003858f6090( buystationstruct )
{
    if ( !common_gunbench::function_2ab0b4dca8482b09() )
    {
        return;
    }
    
    if ( !isdefined( buystationstruct.target ) )
    {
        return;
    }
    
    buystationtargets = utility::getstructarray( buystationstruct.target, "targetname" );
    
    foreach ( struct in buystationtargets )
    {
        if ( struct.script_noteworthy == "workbench" )
        {
            if ( !isdefined( struct.angles ) )
            {
                struct.angles = ( 0, 0, 0 );
            }
            
            workbench = spawnscriptable( "br_workbench", struct.origin, struct.angles );
            workbench setscriptablepartstate( "br_workbench", "visible" );
            return;
        }
    }
}

// Namespace common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x55d8c23, Offset: 0x1aca
// Size: 0x29
function private function_9c81111e1ef4084b( buystationindex, buystationarray )
{
    if ( buystationarray.size == 0 )
    {
        return;
    }
    
    buystationindex %= buystationarray.size;
    return buystationarray[ buystationindex ];
}

// Namespace common_kiosk
// Params 3, eflags: 0x4
// Checksum 0x3224c0b3, Offset: 0x1afc
// Size: 0x4a
function private function_e2aeb62ca13cd7ab( buystationarray, field, value )
{
    for ( var_401adea5abbefc49 = 0; var_401adea5abbefc49 < buystationarray.size ; var_401adea5abbefc49++ )
    {
        if ( buystationarray[ var_401adea5abbefc49 ][ field ] == value )
        {
            return buystationarray[ var_401adea5abbefc49 ];
        }
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x5a1123c4, Offset: 0x1b4f
// Size: 0x1e
function function_57fdad70d0f27d87( itemref )
{
    level.common_kiosk_data common_kiosk_data::function_57fdad70d0f27d87( itemref );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xc3cddc6a, Offset: 0x1b75
// Size: 0x1f8
function function_4250aa4d244b7ff2( allinstances )
{
    var_3362151420ccc05f = [];
    kioskareas = [];
    var_26cd51d484486c80 = [];
    var_a52ed5fd2fe6d954 = 1;
    
    if ( isdefined( level.gametypebundle.var_6673598f153c1ebc ) )
    {
        var_a52ed5fd2fe6d954 = level.gametypebundle.var_6673598f153c1ebc;
    }
    
    for ( kioskindex = 0; kioskindex < allinstances.size ; kioskindex++ )
    {
        kiosk = allinstances[ kioskindex ];
        poi_definition = kiosk.script_poi ?? kiosk.poi;
        
        if ( !isdefined( poi_definition ) )
        {
            continue;
        }
        
        if ( !isdefined( var_3362151420ccc05f[ poi_definition ] ) )
        {
            var_3362151420ccc05f[ poi_definition ] = [];
            kioskareas[ kioskareas.size ] = poi_definition;
        }
        
        var_3362151420ccc05f[ poi_definition ][ var_3362151420ccc05f[ poi_definition ].size ] = kiosk;
    }
    
    kioskareas = arrayrandomize( kioskareas );
    
    foreach ( kioskarea in kioskareas )
    {
        if ( !utility::callsharedfunc( #"poi", #"area_isareaactive", kioskarea ) )
        {
            continue;
        }
        
        var_4118ade3707e7df = var_3362151420ccc05f[ kioskarea ];
        
        if ( var_a52ed5fd2fe6d954 > var_4118ade3707e7df.size )
        {
            var_a52ed5fd2fe6d954 = var_4118ade3707e7df.size;
        }
        
        var_4118ade3707e7df = utility::array_slice( arrayrandomize( var_4118ade3707e7df ), 0, var_a52ed5fd2fe6d954 );
        
        for ( kioskindex = 0; kioskindex < var_4118ade3707e7df.size ; kioskindex++ )
        {
            if ( !shouldspawnkiosk( var_4118ade3707e7df[ kioskindex ], kioskarea ) )
            {
                continue;
            }
            
            kioskscriptable = function_2282260e9dc07a4b( var_4118ade3707e7df[ kioskindex ], kioskindex );
            kioskscriptable.overrideindex = function_d56f3ed300f99977( var_4118ade3707e7df[ kioskindex ], kioskarea );
            var_26cd51d484486c80[ var_26cd51d484486c80.size ] = kioskscriptable;
        }
    }
    
    setspawninstances( var_26cd51d484486c80 );
}

// Namespace common_kiosk
// Params 2
// Checksum 0xb2303440, Offset: 0x1d75
// Size: 0xc6, Type: bool
function canusebuystation( instance, player )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( player utility::callsharedfunc( #"gametype", #"playerskipkioskuse", instance ) )
    {
        return false;
    }
    
    if ( ( !player player::isreallyalive() || player.inlaststand ) && !game_utility::function_a43ada404e8c591f() )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player.iscarrying )
    {
        player namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( "MP/FIELD_UPGRADE_CANNOT_USE" );
        return false;
    }
    
    if ( !instance.visible || instance.disabled )
    {
        return false;
    }
    
    return true;
}

// Namespace common_kiosk
// Params 6
// Checksum 0x22ee8edf, Offset: 0x1e44
// Size: 0x299
function armorykioskused( instance, part, state, player, bautouse, usestring )
{
    if ( !common_item::function_f107d23d5275a951( instance.type, "kiosk" ) )
    {
        return;
    }
    
    if ( bautouse && !function_d6a575a95d5f637b() )
    {
        return;
    }
    
    if ( instance.activetasks.size > 0 && level.timedrun_quest.var_5503ee709e8dec0c != 1 )
    {
        foreach ( task in instance.activetasks )
        {
            if ( isdefined( task.type.funcs[ "onBuyStationUsed" ] ) )
            {
                var_e6f767217733738f = task [[ task.type.funcs[ "onBuyStationUsed" ] ]]( instance, part, state, player, bautouse, usestring );
                
                if ( var_e6f767217733738f )
                {
                    return;
                }
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        player = self;
    }
    
    if ( bautouse && !isdefined( player.armorykioskpurchaseallowed ) )
    {
        player.armorykioskpurchaseallowed = 0;
    }
    
    if ( !canusebuystation( instance, player ) )
    {
        if ( bautouse )
        {
            player.armorykioskpurchaseallowed = 0;
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"biometricscan", #"reportkeycardcount" ) )
    {
        [[ utility::getsharedfunc( #"biometricscan", #"reportkeycardcount" ) ]]( player );
    }
    
    if ( bautouse )
    {
        if ( !player.armorykioskpurchaseallowed )
        {
            function_2d1d175f54b0caf3( instance, player );
        }
    }
    else
    {
        if ( player.insertingarmorplate )
        {
            player notify( #"try_armor_cancel" );
        }
        
        if ( !isdefined( state ) )
        {
            player thread _runpurchasemenu( instance );
        }
        else if ( state == "visible" )
        {
            if ( isdefined( instance ) )
            {
                instance setscriptablepartstate( "br_plunder_box", "opening" );
                instance thread kioskfixupproneplayers();
            }
            
            player thread _runpurchasemenu( instance );
        }
        else if ( state == "opening" || state == "open" )
        {
            player thread _runpurchasemenu( instance );
        }
    }
    
    player notify( "buystation_kill_callout_" + instance.origin );
}

// Namespace common_kiosk
// Params 0
// Checksum 0x71bdb4e9, Offset: 0x20e5
// Size: 0x10
function function_d6a575a95d5f637b()
{
    return getdvarint( @"br_kiosk_quick_purchase_enabled", 0 );
}

// Namespace common_kiosk
// Params 0
// Checksum 0x9a82d2ca, Offset: 0x20fe
// Size: 0x142
function function_e86f80f00a71942()
{
    if ( !bots_util::function_deef484b5b3a3977() )
    {
        return;
    }
    
    buystationsinuse = level.common_kiosk_data common_kiosk_data::function_c3950de54d46edf();
    
    foreach ( buystationref, buystationdata in buystationsinuse )
    {
        data_list = [];
        
        foreach ( itemref, itemdata in buystationdata[ "items" ] )
        {
            cost = itemdata[ "cost" ];
            
            if ( isdefined( cost ) )
            {
                data_list[ data_list.size ] = { #cost:cost, #itemref:itemref };
            }
        }
        
        function_f21571be914848ac( buystationref, data_list );
    }
}

// Namespace common_kiosk
// Params 0
// Checksum 0x5176d27d, Offset: 0x2248
// Size: 0x12c
function kioskfixupproneplayers()
{
    if ( !getdvarint( @"hash_636451c6314df097", 1 ) )
    {
        return;
    }
    
    radius = getdvarfloat( @"hash_3990f3347374d18e", 300 );
    closeplayers = function_6a293b884c444a20( level.players, self.origin, radius );
    
    foreach ( player in closeplayers )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player getstance() != "prone" )
        {
            continue;
        }
        
        halfsize = player getboundshalfsize();
        radius = halfsize[ 0 ];
        height = 2 * halfsize[ 2 ];
        
        if ( capsuletracepassed( player.origin, radius, height, undefined, 0, 0 ) )
        {
            continue;
        }
        
        player setstance( "crouch", 1 );
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x52953d08, Offset: 0x237c
// Size: 0x2f7
function _runpurchasemenu( kiosk )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    
    if ( !isdefined( kiosk.playersusing ) )
    {
        kiosk.playersusing = [];
    }
    
    kiosk.playersusing[ kiosk.playersusing.size ] = player;
    player.common_kiosk = kiosk;
    player.var_d98abf47f4c28e28 = kiosk;
    player interact_utils::function_6b4911d1597d7dc6( #"kiosk_interact" );
    
    if ( isdefined( level.var_87a21a3e41dc2e5d ) )
    {
        [[ level.var_87a21a3e41dc2e5d ]]( kiosk, player );
    }
    
    if ( isdefined( level.var_4318c8bea60cf625.var_92ac319b7cccf588 ) )
    {
        [[ level.var_4318c8bea60cf625.var_92ac319b7cccf588 ]]( kiosk, player );
    }
    
    var_2919a9eff82d3b38 = function_1c9b60b9dfaef240( kiosk );
    
    if ( isdefined( var_2919a9eff82d3b38 ) )
    {
        player setclientomnvar( "ui_buystation_limited_item_amount", var_2919a9eff82d3b38 );
    }
    
    var_3885ffe7721e0058 = function_993fabb597004d08( kiosk );
    
    if ( isdefined( var_3885ffe7721e0058 ) )
    {
        player setclientomnvar( "ui_buystation_random_item_selections", var_3885ffe7721e0058 );
    }
    
    if ( !isint( kiosk ) && isdefined( kiosk.overrideindex ) )
    {
        function_5cf3d883ddbd18c7( kiosk.overrideindex, player );
    }
    else if ( isdefined( level.var_b72044e6a28b0fee ) && !player.var_c305bd7c24a54d39 )
    {
        function_5cf3d883ddbd18c7( level.var_b72044e6a28b0fee, player );
    }
    
    player setclientomnvar( "ui_buystation_purchase_response", 0 );
    openvalue = 0;
    
    if ( player.common_kiosk.isdeployablekiosk )
    {
        openvalue |= 16;
    }
    else
    {
        openvalue |= 2;
    }
    
    isfiresale = iskioskfiresaleactiveforplayer( player.common_kiosk, player );
    var_17ae2801091c4687 = function_c892a782bb09e4b8( player.common_kiosk, player );
    
    if ( var_17ae2801091c4687 )
    {
        openvalue |= 256;
        utility::function_704b6016a179b4ab( level.var_4318c8bea60cf625.var_8c37d124818e1233, player, "reward" );
    }
    
    if ( isfiresale )
    {
        openvalue |= 4;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_7f47fbd312ba1bb5" ) )
    {
        openvalue |= utility::callsharedfunc( #"gametype", #"hash_7f47fbd312ba1bb5", player );
    }
    
    if ( level.brgametype.respawnenable )
    {
        openvalue |= 64;
    }
    
    if ( common_barter::isenabled() )
    {
        barteroverride = common_barter::function_25c795dfd37affe4( player, kiosk );
        player setclientomnvar( "ui_barter_list_index", barteroverride );
    }
    
    player setclientomnvar( "ui_buystation_open", openvalue );
    player.armorykioskpurchaseallowed = 1;
    player thread _watchtoautoclosemenu( kiosk );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xa50ffc80, Offset: 0x267b
// Size: 0x97
function _watchtoautoclosemenu( kiosk )
{
    player = self;
    player endon( #"disconnect" );
    player notify( #"hash_af164706b76a3248" );
    player endon( #"hash_af164706b76a3248" );
    player childthread _proximitywatcher( kiosk );
    utility::waittill_any_ents( player, "death", player, "last_stand_enter", player, "meatshield_victim_start", player, "pushed_too_far", level, "game_ended", player, "player_isHaywire" );
    player interact_utils::function_2589dc899a6731de( #"kiosk_interact" );
    player _closepurchasemenuwithresponse( 2 );
}

// Namespace common_kiosk
// Params 2
// Checksum 0x1774d331, Offset: 0x271a
// Size: 0x49
function function_2d1d175f54b0caf3( kiosk, player )
{
    player.common_kiosk = kiosk;
    player.var_d98abf47f4c28e28 = kiosk;
    player.armorykioskpurchaseallowed = 1;
    player thread function_fe79a9fdbf05ad55( kiosk );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xe03f91a4, Offset: 0x276b
// Size: 0x8a
function function_fe79a9fdbf05ad55( kiosk )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    player childthread function_ebc5b9cb20d7ef2( kiosk );
    utility::waittill_any_ents( player, "last_stand_enter", player, "meatshield_victim_start", player, "exit_quick_purchase_zone" );
    
    if ( isdefined( player ) )
    {
        player.armorykioskpurchaseallowed = 0;
        player interact_utils::function_2589dc899a6731de( #"kiosk_interact" );
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x512012e9, Offset: 0x27fd
// Size: 0x85
function function_ebc5b9cb20d7ef2( kiosk )
{
    player = self;
    var_73df111cf32046f7 = getdvarint( @"hash_c37f7e3bb9eca843", 0 );
    maxdistsquared = var_73df111cf32046f7 * var_73df111cf32046f7;
    
    while ( true )
    {
        if ( !isdefined( kiosk ) || distancesquared( player.origin, kiosk.origin ) > maxdistsquared )
        {
            player notify( #"exit_quick_purchase_zone" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x3a4dbc87, Offset: 0x288a
// Size: 0x94
function _proximitywatcher( kiosk )
{
    player = self;
    var_b3e005a39a3a3821 = 64;
    var_73df111cf32046f7 = getdvarfloat( @"hash_ecd52993b5dab130", 128 ) + var_b3e005a39a3a3821;
    maxdistsquared = var_73df111cf32046f7 * var_73df111cf32046f7;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !kiosk || distancesquared( player.origin, kiosk.origin ) > maxdistsquared )
        {
            player notify( #"pushed_too_far" );
            break;
        }
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0xdea6e6d6, Offset: 0x2926
// Size: 0x137
function _closepurchasemenuwithresponse( var_8ff852348df82557 )
{
    player = self;
    
    if ( var_8ff852348df82557 == 1 && getdvarint( @"hash_ed6e4ffa933af621", 0 ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_buystation_purchase_response", var_8ff852348df82557 );
    player setclientomnvar( "ui_buystation_open", 1 );
    player setclientomnvar( "ui_buystation_override", -1 );
    vehicle_interact::function_f8ec5cbb44385eaa( player.var_d5168c882218a620, player );
    
    if ( isdefined( player.common_kiosk ) )
    {
        if ( isdefined( player.common_kiosk ) && isdefined( player.common_kiosk.playersusing ) && arraycontains( player.common_kiosk.playersusing, player ) )
        {
            player.common_kiosk.playersusing = arrayremove( player.common_kiosk.playersusing, player );
        }
    }
    
    player.common_kiosk = undefined;
    player.var_c305bd7c24a54d39 = undefined;
    player.var_d5168c882218a620 = undefined;
    player.armorykioskpurchaseallowed = undefined;
    player interact_utils::function_2589dc899a6731de( #"kiosk_interact" );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xe7da8a69, Offset: 0x2a65
// Size: 0x35
function _purchasemenuclosedbyclient( player )
{
    player _closepurchasemenuwithresponse( 0 );
    player notify( #"hash_af164706b76a3248" );
    player interact_utils::function_2589dc899a6731de( #"kiosk_interact" );
}

// Namespace common_kiosk
// Params 2
// Checksum 0x81b3f0fa, Offset: 0x2aa2
// Size: 0x27
function function_89c427f6b73d6543( buystationindex, itemref )
{
    return level.common_kiosk_data common_kiosk_data::function_a841bf1534cb9fa2( buystationindex, itemref );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x863e352c, Offset: 0x2ad2
// Size: 0x23
function function_a841bf1534cb9fa2( itemref )
{
    return function_675027aaa5409ff5( level.common_kiosk_data common_kiosk_data::function_148539293b639735(), itemref );
}

// Namespace common_kiosk
// Params 2
// Checksum 0xa32b2e58, Offset: 0x2afe
// Size: 0xe0
function function_675027aaa5409ff5( itemref, player )
{
    var_6f76a0e807bff063 = undefined;
    
    if ( isplayer( player ) && isdefined( player.common_kiosk ) && isdefined( player.common_kiosk.overrideindex ) )
    {
        var_6f76a0e807bff063 = player.common_kiosk.overrideindex;
    }
    
    buystationindex = var_6f76a0e807bff063 ?? level.common_kiosk_data common_kiosk_data::function_148539293b639735();
    itemcost = function_89c427f6b73d6543( buystationindex, itemref );
    
    if ( isdefined( level.var_4318c8bea60cf625.var_52f28106b1df1c8 ) )
    {
        newcost = [[ level.var_4318c8bea60cf625.var_52f28106b1df1c8 ]]( itemref, player );
        itemcost = newcost ?? itemcost;
    }
    
    return itemcost;
}

// Namespace common_kiosk
// Params 2
// Checksum 0xdd88f53a, Offset: 0x2be7
// Size: 0xa6, Type: bool
function function_4dadc09f274b2e0d( var_317f3ab12fa62d40, var_193f0696ae04f08 )
{
    if ( level.var_15b5fff339fcb92.var_5657dbfb2cbc2972 && var_317f3ab12fa62d40 == "supplyDropBR" )
    {
        reduction = level.var_15b5fff339fcb92.reductionamount * ( getomnvar( "ui_br_circle_num" ) - 1 );
        newcost = var_193f0696ae04f08 - reduction;
        
        if ( newcost < level.var_15b5fff339fcb92.minimumprice )
        {
            newcost = level.var_15b5fff339fcb92.minimumprice;
        }
    }
    
    return newcost ?? var_193f0696ae04f08;
}

// Namespace common_kiosk
// Params 2
// Checksum 0x5a987e56, Offset: 0x2c96
// Size: 0x3d3
function _getactualcost( player, itemdata )
{
    if ( player.var_403f571c4b488e5f > 0 )
    {
        return 0;
    }
    
    isfiresale = iskioskfiresaleactiveforplayer( player.common_kiosk, player );
    var_b3e018e7ffb33b05 = isdefined( player.perks[ "specialty_br_cheaper_kiosk" ] );
    finalcost = itemdata.cost;
    costinfo = {};
    callback::callback( #"hash_dc33f16e6a7b79cf", { #costinfo:costinfo, #itemdata:itemdata, #player:player } );
    
    if ( itemdata.scalingcost.var_1a60d414d536634a )
    {
        foreach ( cost in itemdata.scalingcost.var_ab77dc84310ea00f )
        {
            if ( cost.weaponrarity == costinfo.weaponrarity )
            {
                finalcost = cost.cost;
                break;
            }
        }
    }
    
    var_193f0696ae04f08 = function_675027aaa5409ff5( itemdata.entryref, player );
    var_193f0696ae04f08 = function_4dadc09f274b2e0d( itemdata.entryref, var_193f0696ae04f08 );
    
    if ( isdefined( var_193f0696ae04f08 ) )
    {
        finalcost = var_193f0696ae04f08;
    }
    
    var_fca64d021f97047c = getdvar( hashcat( @"scr_", itemdata.ref, "_cost_override" ), "" );
    
    if ( var_fca64d021f97047c != "" )
    {
        var_38bf6aab791decfd = strtok( var_fca64d021f97047c, "," );
        var_cbcd7339cd8a89e7 = ( level.teamdata[ player.team ][ "players" ].size ?? 1 ) - 1;
        
        if ( var_38bf6aab791decfd.size > 0 )
        {
            var_51765ce4c248f9f8 = var_38bf6aab791decfd.size <= var_cbcd7339cd8a89e7 ? var_38bf6aab791decfd.size - 1 : var_cbcd7339cd8a89e7;
            finalcost = int( var_38bf6aab791decfd[ var_51765ce4c248f9f8 ] );
        }
        else
        {
            script::demoforcesre( "Invalid \"scr_" + itemdata.ref + "_cost_override\" dvar value. Value: \"" + var_fca64d021f97047c + "\"." );
        }
    }
    
    if ( itemdata.ref == "teamrevive" && isbot( itemdata.revivedteammate ) )
    {
        finalcost = int( finalcost * 0.5 );
    }
    
    finaldiscount = 0;
    
    if ( isfiresale )
    {
        finaldiscount += itemdata.firesalediscount;
    }
    else if ( var_b3e018e7ffb33b05 )
    {
        finaldiscount += itemdata.perkdiscount;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_8933f7ac72925c18" ) )
    {
        finaldiscount += utility::callsharedfunc( #"gametype", #"hash_8933f7ac72925c18", player );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_90c29aa67d10cd2b" ) && itemdata.ref == "teamrevive" )
    {
        finaldiscount += utility::callsharedfunc( #"gametype", #"hash_90c29aa67d10cd2b" );
    }
    
    if ( isfiresale && utility::function_704b6016a179b4ab( level.var_4318c8bea60cf625.var_508a9518dc74e748, player ) && utility::function_704b6016a179b4ab( level.var_4318c8bea60cf625.var_8c5111eb81abe768, itemdata ) )
    {
        finaldiscount = 100;
    }
    
    if ( finaldiscount > 0 )
    {
        finalcost = _applysalesdiscount( finalcost, finaldiscount );
    }
    
    return finalcost;
}

// Namespace common_kiosk
// Params 2
// Checksum 0x6fd59711, Offset: 0x3072
// Size: 0x5d
function _applysalesdiscount( originalprice, discount )
{
    if ( !isdefined( discount ) || discount == 0 )
    {
        return originalprice;
    }
    else if ( discount == 100 )
    {
        return 0;
    }
    
    fraction = ( 100 - discount ) * 0.01;
    return int( floor( originalprice * fraction + 0.5 ) );
}

// Namespace common_kiosk
// Params 2
// Checksum 0xce0a8f0b, Offset: 0x30d8
// Size: 0x4c, Type: bool
function iskioskfiresaleactiveforplayer( kiosk, player )
{
    if ( isdefined( level.var_4318c8bea60cf625.firesaleactiveforplayer ) && [[ level.var_4318c8bea60cf625.firesaleactiveforplayer ]]( kiosk, player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 2
// Checksum 0x3f3d7400, Offset: 0x312d
// Size: 0x4c, Type: bool
function function_c892a782bb09e4b8( kiosk, player )
{
    if ( isdefined( level.var_4318c8bea60cf625.var_ecd93599094b26cd ) && [[ level.var_4318c8bea60cf625.var_ecd93599094b26cd ]]( kiosk, player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xa5ab6e9a, Offset: 0x3182
// Size: 0x1d
function function_74433c19fcc10b90( itemindex )
{
    return level.common_kiosk_data common_kiosk_data::function_74433c19fcc10b90( itemindex );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x6ebf9697, Offset: 0x31a8
// Size: 0x1e
function function_b3a53c6f76c87dda( value )
{
    onarmorykioskpurchase( self.var_b458a7ace288c777, value );
}

// Namespace common_kiosk
// Params 2
// Checksum 0x1b8b1377, Offset: 0x31ce
// Size: 0x974
function onarmorykioskpurchase( channel, purchaseindex )
{
    player = self;
    kiosk = player.common_kiosk;
    
    if ( isdefined( level.var_4318c8bea60cf625.var_ea56078d44169b8 ) )
    {
        if ( ![[ level.var_4318c8bea60cf625.var_ea56078d44169b8 ]]( player, channel ) )
        {
            return;
        }
    }
    else if ( !player.armorykioskpurchaseallowed && !level.var_dbdd35c475d50ae3 )
    {
        return;
    }
    
    if ( isdefined( level.var_4318c8bea60cf625.onarmorykioskpurchase ) )
    {
        player [[ level.var_4318c8bea60cf625.onarmorykioskpurchase ]]( channel, purchaseindex );
    }
    
    if ( channel == "br_cancel_purchase" )
    {
        _purchasemenuclosedbyclient( player );
        return;
    }
    
    if ( channel == "br_item_purchase" )
    {
        itemdata = function_74433c19fcc10b90( purchaseindex );
        assert( isdefined( itemdata ) );
        cost = player _getactualcost( player, itemdata );
        currencytype = level.gametypebundle.currencytype ?? #"essence";
        str_item_currency = currency::function_2570aaa28fdae0ad( itemdata.entryref ) ?? currencytype;
        str_ref_override = undefined;
        itembundlename = undefined;
        
        if ( player currency::can_afford( str_item_currency, cost ) )
        {
            if ( !function_a3a8490ca41b030( kiosk, itemdata.entryref ) )
            {
                return;
            }
            
            params = spawnstruct();
            params.player = player;
            params.cost = cost;
            params.itemdata = itemdata;
            params.kiosk = kiosk;
            
            if ( !callback::response( 2, #"hash_440e335c78393d75", params ) )
            {
                return;
            }
            
            player callback::callback( #"hash_8daeabb90e45c6bc", params );
            function_b402b2318d41f582( kiosk, itemdata.entryref );
            var_2919a9eff82d3b38 = function_1c9b60b9dfaef240( kiosk );
            
            if ( isdefined( var_2919a9eff82d3b38 ) )
            {
                foreach ( usingplayer in kiosk.playersusing )
                {
                    if ( isdefined( usingplayer ) )
                    {
                        usingplayer setclientomnvar( "ui_buystation_limited_item_amount", var_2919a9eff82d3b38 );
                    }
                }
            }
            
            itemtype = itemdata.type;
            
            if ( callback::response( 0, #"hash_8ba167d45892409f", { #player:player, #itemdata:itemdata } ) )
            {
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            
            if ( itemtype == "fieldupgrade" )
            {
                itemtype = "super";
            }
            else if ( itemdata.entryref == "armorBundle" )
            {
                itemtype = "armor";
                fakeitem = { #fromcache:1, #count:5, #type:"brloot_armor_plate" };
                itemcallbacks = player common_item::function_9f00d6361edd38ce( itemtype );
                
                if ( [[ itemcallbacks.funcs[ #"canautouse" ] ]]() )
                {
                    fakeitem.count = player [[ itemcallbacks.funcs[ #"use" ] ]]( undefined, fakeitem, 0 );
                }
                
                if ( fakeitem.count > 0 )
                {
                    itembundlename = common_item_database::function_a4f0a21951180013( level.armorref ?? "equip_armorplate" );
                    itembundle = getscriptbundle( itembundlename );
                    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
                    player common_item::function_61c2c0251e742ffd( itembundle, fakeitem.count, spawnoptions );
                }
                
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            else if ( itemdata.entryref == "reviveToken" )
            {
                str_ref_override = "brloot_self_revive";
            }
            else if ( itemtype == "persistent" )
            {
                player utility::callsharedfunc( #"loot", #"hash_533a821691e2894a", itemdata.ref );
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            else if ( itemtype == "weapon" )
            {
                if ( level.var_e298f874f79103ed )
                {
                    itembundlename = "itemspawnentry:" + itemdata.ref;
                }
            }
            else if ( itemdata.entryref == "br_aether_upgrade_primary" )
            {
                utility::callsharedfunc( #"super_br_aether_upgrade", #"kiosk_purchase_upgrade", player, #"primary_0" );
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            else if ( itemdata.entryref == "br_aether_upgrade_secondary" )
            {
                utility::callsharedfunc( #"super_br_aether_upgrade", #"kiosk_purchase_upgrade", player, #"primary_1" );
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            else if ( itemtype == "vehicle" )
            {
                itemcallbacks = player common_item::function_9f00d6361edd38ce( "vehicle_spawner" );
                itembundle = getscriptbundle( "itemspawnentry:" + itemdata.ref );
                assert( itembundle, "<dev string:x24>" + itemdata.ref );
                assert( isdefined( itemcallbacks.funcs[ #"hash_d2edc28305c6e147" ] ), "<dev string:x53>" );
                player [[ itemcallbacks.funcs[ #"hash_d2edc28305c6e147" ] ]]( itembundle );
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                player _closepurchasemenuwithresponse( 2 );
                return;
            }
            else if ( itemtype == "action" )
            {
                params = { #player:player, #itemdata:itemdata };
                callback::callback( #"hash_2c631dc23e0ee99b", params );
                function_6844a81292fae38d( player, itemdata, itemtype, itemdata.entryref, undefined, cost, currencytype );
                return;
            }
            
            str_item_ref = str_ref_override ?? itemdata.ref;
            
            if ( !isdefined( itembundlename ) )
            {
                itembundlename = common_item_database::function_a4f0a21951180013( str_item_ref );
            }
            
            assert( isdefined( itembundlename ), "<dev string:x92>" + str_item_ref + "<dev string:xb5>" );
            itembundle = getscriptbundle( itembundlename );
            scriptable_name = itembundle.scriptable;
            fakeitem = spawnstruct();
            fakeitem.type = scriptable_name;
            fakeitem.count = common_item::function_ea3b3088d82fd357( itembundle );
            fakeitem.fromcache = 1;
            fakeitem.kiosk = kiosk;
            obtainresult = player common_item::function_96119bed8ab4c5d9( fakeitem, 0, 1 );
            
            if ( !obtainresult )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
                player common_item::function_61c2c0251e742ffd( itembundle, fakeitem.count, spawnoptions );
            }
            
            lootid = common_item::function_779887309ec71dfe( itembundle );
            typestring = common_item::function_16e8c106491eeaca( itembundle );
            player common_item::items_analytics( undefined, undefined, undefined, lootid, undefined, typestring, undefined, undefined, fakeitem.type, player.origin, fakeitem.count, cost );
            function_6844a81292fae38d( player, itemdata, itemtype, str_item_ref, lootid, cost, currencytype );
        }
        
        return;
    }
    
    if ( channel == "br_loadout_purchase" )
    {
        if ( isdefined( level.var_2efce60698127142 ) )
        {
            player thread [[ level.var_2efce60698127142 ]]( purchaseindex );
        }
        
        return;
    }
    
    if ( channel == "br_team_revive" )
    {
        if ( isdefined( level.var_b4a0865dad65fa19 ) )
        {
            player thread [[ level.var_b4a0865dad65fa19 ]]( purchaseindex );
        }
        
        return;
    }
    
    if ( channel == "br_team_revive_all" )
    {
        if ( isdefined( level.var_952b959a42f49b29 ) )
        {
            player thread [[ level.var_952b959a42f49b29 ]]( purchaseindex );
        }
        
        return;
    }
    
    if ( channel == "br_biometric_scan_keycard_exchange" )
    {
        if ( utility::issharedfuncdefined( #"biometricscan", #"handlekeycardexchange" ) )
        {
            itemdata = [[ utility::getsharedfunc( #"biometricscan", #"handlekeycardexchange" ) ]]( player, kiosk, purchaseindex );
            
            if ( isdefined( itemdata ) )
            {
                function_75dbb34857ca590b( player, itemdata, itemdata.type );
            }
        }
        
        return;
    }
    
    if ( channel == "br_biometric_scan_consumable_exchange" )
    {
        if ( isdefined( level.var_b30d859af2609680 ) )
        {
            [[ level.var_b30d859af2609680 ]]( player, kiosk, purchaseindex );
            player setclientomnvar( "ui_biometric_scan_consumable_loot_id", 0 );
        }
        
        return;
    }
    
    if ( channel == "sell_item" )
    {
        itemindex = common_inventory::function_6cc5b271aaea14b1( purchaseindex );
        function_fbb00cd8ac4f2285( self, itemindex );
        return;
    }
    
    if ( channel == "sell_all_item" )
    {
        itemindex = common_inventory::function_6cc5b271aaea14b1( purchaseindex );
        function_fbb00cd8ac4f2285( self, itemindex, 1 );
        return;
    }
    
    if ( channel == "sell_all_valuables" )
    {
        for ( itemindex = 0; itemindex < common_inventory::function_9cd65c8312048802() ; itemindex++ )
        {
            function_fbb00cd8ac4f2285( self, itemindex, 1 );
        }
    }
}

// Namespace common_kiosk
// Params 4
// Checksum 0x9cc1737f, Offset: 0x3b4a
// Size: 0x142, Type: bool
function function_ab8446ed6aa283a5( isfriendlyfire, eattacker, idamage, objweapon )
{
    victim = self;
    var_888364eb6510ab1b = undefined;
    
    if ( isdefined( eattacker ) )
    {
        var_888364eb6510ab1b = eattacker vehicle::is_vehicle() || isplayer( eattacker );
    }
    
    if ( !isplayer( victim ) || !isdefined( eattacker ) || !var_888364eb6510ab1b || !isdefined( objweapon ) || !isdefined( idamage ) )
    {
        return false;
    }
    
    var_f084464d62220a9 = victim.common_kiosk;
    var_80648ee7afdf5741 = level.var_60d5b7c260e6353e && !weapon::function_d991bdc544c7f2d0( objweapon ) && idamage > 1;
    var_f88ee11ed9271c0a = victim function_6b7200de96879b6();
    var_5cd89e86e3663182 = isdefined( victim.var_db815c5786e51932 ) && gettime() - victim.var_db815c5786e51932 < level.var_57bd3795b7064dcd ? 1 : 0;
    
    if ( var_f084464d62220a9 && var_80648ee7afdf5741 && var_f88ee11ed9271c0a && !isfriendlyfire && !var_5cd89e86e3663182 )
    {
        victim.var_db815c5786e51932 = gettime();
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 7
// Checksum 0xe69964, Offset: 0x3c95
// Size: 0x15c
function function_6844a81292fae38d( player, itemdata, itemtype, itemref, lootid, cost, currencytype )
{
    str_item_currency = currency::function_2570aaa28fdae0ad( itemdata.entryref ) ?? currencytype;
    player currency::function_b5fe1e05c892a7f3( str_item_currency, cost, #"buystation", itemref );
    
    if ( !isdefined( self.pers[ "currency_spent" ] ) )
    {
        self.pers[ "currency_spent" ] = cost;
    }
    else
    {
        self.pers[ "currency_spent" ] = self.pers[ "currency_spent" ] + cost;
    }
    
    if ( !isdefined( player.accessedbuystations ) )
    {
        player.accessedbuystations = [];
    }
    
    var_209fdcce39fd01cf = 0;
    
    if ( player.common_kiosk && !arraycontains( player.accessedbuystations, player.common_kiosk ) )
    {
        player.accessedbuystations[ player.accessedbuystations.size ] = player.common_kiosk;
        var_209fdcce39fd01cf = 1;
    }
    
    player challenges::onkioskpurchaseitem( itemtype, itemdata.ref, lootid, 1, cost, var_209fdcce39fd01cf );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xbed849d8, Offset: 0x3df9
// Size: 0x1d
function hideobjective( kiosk )
{
    kiosk setscriptablepartstate( "objective", "none" );
}

// Namespace common_kiosk
// Params 1
// Checksum 0xcc19a9a8, Offset: 0x3e1e
// Size: 0x46
function showobjective( kiosk )
{
    assert( level.common_armory_kiosk.var_971f20e392d7da1f );
    kiosk setscriptablepartstate( "objective", level.common_armory_kiosk.var_971f20e392d7da1f );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x94875da0, Offset: 0x3e6c
// Size: 0xb7
function function_b79826984f9eb5fd( itemref )
{
    var_aa39aa89e16428af = currency::function_87fbe1244fd5eddd();
    
    if ( isdefined( var_aa39aa89e16428af ) && isdefined( var_aa39aa89e16428af.var_6d57fe60a29cffc6 ) )
    {
        foreach ( var_ee9b2321287cf264 in var_aa39aa89e16428af.var_6d57fe60a29cffc6 )
        {
            if ( var_ee9b2321287cf264.var_1f8b0a4fc895be4a == itemref )
            {
                return var_ee9b2321287cf264;
            }
        }
    }
}

// Namespace common_kiosk
// Params 3
// Checksum 0x5b2662e0, Offset: 0x3f2b
// Size: 0x20e
function function_fbb00cd8ac4f2285( player, itemslotindex, sellall )
{
    lootid = common_inventory::inventory_getlootidatbackpackindex( itemslotindex );
    
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        return;
    }
    
    var_825718e0662d3fc6 = 1;
    quantity = common_inventory::inventory_getquantityatbackpackindex( itemslotindex );
    
    if ( sellall )
    {
        var_825718e0662d3fc6 = quantity;
    }
    
    itembundle = common_item::function_b202b16941992cca( lootid );
    
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    itemref = itembundle.ref;
    var_997b5ca9527079c9 = function_b79826984f9eb5fd( itemref );
    
    if ( isdefined( itemref ) && isdefined( var_997b5ca9527079c9 ) && isdefined( var_997b5ca9527079c9.var_a1973d13374bd69e ) )
    {
        gametypebundle = getgametypescriptbundle();
        cashmultiplier = gametypebundle.var_a428f72f50986a04 ?? 1;
        cashvalue = var_825718e0662d3fc6 * var_997b5ca9527079c9.var_a1973d13374bd69e * cashmultiplier;
        var_4151769dbb2c435a = var_825718e0662d3fc6;
        lootid = common_item::function_779887309ec71dfe( itembundle );
        typestring = common_item::function_16e8c106491eeaca( itembundle );
        player common_item::items_analytics( undefined, undefined, undefined, undefined, lootid, typestring, undefined, undefined, itemref, player.origin, var_4151769dbb2c435a );
        currencybundle = currency::get_currency_bundle( var_997b5ca9527079c9.var_b60e4cb0347ea4a );
        
        if ( isdefined( currencybundle ) )
        {
            player currency::add_currency_amount( currencybundle.currencyname, cashvalue, #"sold" );
        }
        
        player common_inventory::inventory_setbackpackitematindex( itemslotindex, lootid, quantity - var_4151769dbb2c435a );
        params = spawnstruct();
        params.bundle = common_item::function_b202b16941992cca( lootid );
        params.ref = itemref;
        params.value = cashvalue;
        params.quantitysold = var_825718e0662d3fc6;
        params.lootid = lootid;
        player callback::callback( #"kiosk_item_sold", params );
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0x733aa022, Offset: 0x4141
// Size: 0xa6
function br_kiosk_init( callbacks )
{
    level.var_4318c8bea60cf625 = callbacks;
    
    if ( getmatchrulesdata( "commonOption", "buyStationBuybackEnabled" ) )
    {
        assert( isdefined( level.var_4318c8bea60cf625.var_5a140345b0fdc9ad ) );
        level.var_b4a0865dad65fa19 = &br_kiosk_br_team_revive;
        assert( isdefined( level.var_4318c8bea60cf625.var_31c4496a390b83dc ) );
        level.var_952b959a42f49b29 = &br_kiosk_br_team_revive_all;
    }
    
    assert( isdefined( level.var_4318c8bea60cf625.purchaseloadout ) );
    level.var_2efce60698127142 = &br_kiosk_br_loadout;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xa25cafd3, Offset: 0x41ef
// Size: 0x78
function private br_kiosk_br_team_revive( purchaseindex )
{
    player = self;
    kiosk = player.common_kiosk;
    assert( isdefined( level.var_4318c8bea60cf625.var_5a140345b0fdc9ad ) );
    self [[ level.var_4318c8bea60cf625.var_5a140345b0fdc9ad ]]( purchaseindex, kiosk, &_closepurchasemenuwithresponse, &function_a1c1cc5cf66f2de9, &_getactualcost, &function_75dbb34857ca590b );
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x4e0c8a52, Offset: 0x426f
// Size: 0x78
function private br_kiosk_br_team_revive_all( purchaseindex )
{
    player = self;
    kiosk = player.common_kiosk;
    assert( isdefined( level.var_4318c8bea60cf625.var_31c4496a390b83dc ) );
    self [[ level.var_4318c8bea60cf625.var_31c4496a390b83dc ]]( purchaseindex, kiosk, &_closepurchasemenuwithresponse, &function_a1c1cc5cf66f2de9, &_getactualcost, &function_75dbb34857ca590b );
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xed802f5b, Offset: 0x42ef
// Size: 0x78
function private br_kiosk_br_loadout( purchaseindex )
{
    player = self;
    kiosk = player.common_kiosk;
    assert( isdefined( level.var_4318c8bea60cf625.purchaseloadout ) );
    self [[ level.var_4318c8bea60cf625.purchaseloadout ]]( purchaseindex, kiosk, &_closepurchasemenuwithresponse, &function_a1c1cc5cf66f2de9, &_getactualcost, &function_75dbb34857ca590b );
}

// Namespace common_kiosk
// Params 1
// Checksum 0x2fcabb93, Offset: 0x436f
// Size: 0x1d
function function_a1c1cc5cf66f2de9( itemref )
{
    return level.common_kiosk_data common_kiosk_data::function_a1c1cc5cf66f2de9( itemref );
}

// Namespace common_kiosk
// Params 4, eflags: 0x4
// Checksum 0x38267c46, Offset: 0x4395
// Size: 0x1f9
function private function_75dbb34857ca590b( player, itemdata, itemtyperef, quantity )
{
    cost = player _getactualcost( player, itemdata );
    currencytype = level.gametypebundle.currencytype ?? #"essence";
    str_item_currency = currency::function_2570aaa28fdae0ad( itemdata.entryref ) ?? currencytype;
    player currency::function_b5fe1e05c892a7f3( str_item_currency, cost, #"buystation", itemdata.entryref );
    lootid = itemdata.lootid;
    
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        lootid = loot::getlootidfromref( itemdata.ref );
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
            lootid = loot::function_d3e3bcaea591a6a2( itemdata.ref );
            
            if ( !isdefined( lootid ) )
            {
                lootid = 0;
            }
        }
    }
    
    if ( !isdefined( quantity ) )
    {
        quantity = 1;
    }
    
    var_209fdcce39fd01cf = 0;
    
    if ( !isdefined( player.accessedbuystations ) )
    {
        player.accessedbuystations = [];
    }
    
    if ( player.common_kiosk && !arraycontains( player.accessedbuystations, player.common_kiosk ) )
    {
        player.accessedbuystations[ player.accessedbuystations.size ] = player.common_kiosk;
        var_209fdcce39fd01cf = 1;
    }
    
    if ( isdefined( itemtyperef ) )
    {
        player challenges::onkioskpurchaseitem( itemtyperef, itemdata.ref, lootid, quantity, cost, var_209fdcce39fd01cf );
    }
    
    if ( itemdata.type != "biometric_scan_keycard" )
    {
        if ( utility::issharedfuncdefined( #"biometricscan", #"updatefreeitemcount" ) )
        {
            [[ utility::getsharedfunc( #"biometricscan", #"updatefreeitemcount" ) ]]( player, -1 );
        }
    }
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xe90adbfa, Offset: 0x4596
// Size: 0x15c, Type: bool
function private function_d2fc541046c37ab4( kiosk )
{
    if ( getdvarint( @"hash_8bd31284e87b0865", 1 ) == 0 )
    {
        return false;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( kiosk.index ) ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_5f15a3e117466c52", 0 ) == 1 )
        {
            kiosk.overrideindex = undefined;
            kiosk.var_15a1ac5dcc500532 = undefined;
        }
    #/
    
    var_3d4f914b2d061fef = getsystemtime();
    var_787f496728ddade7 = level.common_kiosk_data common_kiosk_data::function_51fc0412ca4334bf();
    
    if ( !isdefined( kiosk.overrideindex ) && var_787f496728ddade7 > 0 )
    {
        var_28af1a6126e00278 = ( kiosk.index + var_3d4f914b2d061fef ) % var_787f496728ddade7;
        kiosk.overrideindex = level.common_kiosk_data common_kiosk_data::function_5bc68da613540d2e( var_28af1a6126e00278 );
    }
    
    if ( !isdefined( kiosk.var_15a1ac5dcc500532 ) && isdefined( level.var_b60df4c8e09fbe23 ) && level.var_b60df4c8e09fbe23.size > 0 )
    {
        var_d643c0be2e002913 = ( kiosk.index + var_3d4f914b2d061fef ) % level.var_b60df4c8e09fbe23.size;
        var_ee855171605e51cd = level.var_b60df4c8e09fbe23[ var_d643c0be2e002913 ];
        kiosk.var_15a1ac5dcc500532 = var_ee855171605e51cd[ "index" ];
    }
    
    return true;
}

// Namespace common_kiosk
// Params 1
// Checksum 0x117e390, Offset: 0x46fb
// Size: 0x1e
function function_b1b75e4a51094d62( index )
{
    level.common_kiosk_data common_kiosk_data::function_bf67e32fb61fec07( index );
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xd772eb15, Offset: 0x4721
// Size: 0x64
function private function_102866f824ac6d9( kiosk )
{
    if ( !function_d2fc541046c37ab4( kiosk ) )
    {
        return;
    }
    
    if ( isdefined( kiosk.overrideindex ) && !level.common_kiosk_data common_kiosk_data::function_6a04888539a8ebbd( kiosk.overrideindex ) )
    {
        function_b1b75e4a51094d62( kiosk.overrideindex );
    }
    
    return kiosk.overrideindex;
}

// Namespace common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x89217b53, Offset: 0x478e
// Size: 0x8e
function private function_7e70da22cf0dfa6a( buystationsarray, buystationindex )
{
    foreach ( buystationdata in buystationsarray )
    {
        if ( buystationdata[ "index" ] == buystationindex )
        {
            return buystationdata;
        }
    }
}

// Namespace common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x841c296c, Offset: 0x4825
// Size: 0x124, Type: bool
function private function_852d84f3761bca70( var_ff9868b785ff9ce3, kioskindex )
{
    buystationdata = level.common_kiosk_data common_kiosk_data::function_e7774bf19f7a50f5( var_ff9868b785ff9ce3 );
    
    if ( isdefined( buystationdata ) )
    {
        buystationstock = spawnstruct();
        buystationstock.defindex = var_ff9868b785ff9ce3;
        buystationstock.stock = [];
        
        foreach ( var_5016f46d98f3477c, var_e485a4d261fe5c1a in buystationdata[ "items" ] )
        {
            buystationstock.stock[ var_5016f46d98f3477c ] = var_e485a4d261fe5c1a[ "defaultStock" ];
            
            if ( callback::response( 0, #"hash_a20e721cf931b9d0", { #itemkey:var_5016f46d98f3477c } ) )
            {
                buystationstock.stock[ var_5016f46d98f3477c ] = 0;
            }
        }
        
        level.buystationstock[ kioskindex ] = buystationstock;
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 2
// Checksum 0xddd2b02e, Offset: 0x4952
// Size: 0x110, Type: bool
function restockbuystation( var_ff9868b785ff9ce3, kioskindex )
{
    if ( !level.buystationstock[ kioskindex ] )
    {
        return false;
    }
    
    buystationdata = level.common_kiosk_data common_kiosk_data::function_e7774bf19f7a50f5( var_ff9868b785ff9ce3 );
    
    if ( buystationdata )
    {
        foreach ( var_5016f46d98f3477c, var_e485a4d261fe5c1a in buystationdata[ "items" ] )
        {
            level.buystationstock[ kioskindex ].stock[ var_5016f46d98f3477c ] = var_e485a4d261fe5c1a[ "defaultStock" ];
            
            if ( callback::response( 0, #"hash_a20e721cf931b9d0", { #itemkey:var_5016f46d98f3477c } ) )
            {
                level.buystationstock[ kioskindex ].stock[ var_5016f46d98f3477c ] = 0;
            }
        }
    }
    
    return true;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xf574223c, Offset: 0x4a6b
// Size: 0xd6, Type: bool
function private function_4563779f87eaade6( kiosk )
{
    if ( getdvarint( @"hash_b0634929cd39973b", 1 ) == 0 )
    {
        return false;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( kiosk.index ) ) )
    {
        return false;
    }
    
    if ( !isdefined( function_c3950de54d46edf() ) )
    {
        return false;
    }
    
    var_ff9868b785ff9ce3 = function_102866f824ac6d9( kiosk );
    
    if ( !isdefined( var_ff9868b785ff9ce3 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.buystationstock ) )
    {
        level.buystationstock = [];
    }
    
    if ( isdefined( level.buystationstock[ kiosk.index ] ) && level.buystationstock[ kiosk.index ].defindex == var_ff9868b785ff9ce3 )
    {
        return true;
    }
    
    if ( function_852d84f3761bca70( var_ff9868b785ff9ce3, kiosk.index ) )
    {
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x80812a60, Offset: 0x4b4a
// Size: 0xe3
function private function_1c9b60b9dfaef240( kiosk )
{
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    itemspacked = 0;
    var_7f58eb0d2ef8b238 = 0;
    var_c7db5572b24fae99 = function_b37e534a00251768( kiosk );
    
    foreach ( var_fa48d0db5f59b870 in var_c7db5572b24fae99 )
    {
        if ( isdefined( var_fa48d0db5f59b870 ) )
        {
            assert( 0 <= var_fa48d0db5f59b870 && var_fa48d0db5f59b870 <= 3 );
            assert( itemspacked < 16 );
            var_7f58eb0d2ef8b238 |= var_fa48d0db5f59b870 << 2 * itemspacked;
            itemspacked++;
        }
    }
    
    return var_7f58eb0d2ef8b238;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xc0cb40aa, Offset: 0x4c36
// Size: 0x185
function private function_b37e534a00251768( kiosk )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    var_6366af1ea39abf2d = level.buystationstock[ kiosk.index ].defindex;
    buystationdata = level.common_kiosk_data common_kiosk_data::function_e7774bf19f7a50f5( var_6366af1ea39abf2d );
    var_a5c448d707ffda75 = isdefined( buystationdata ) ? buystationdata[ "items" ] : undefined;
    assert( isdefined( var_a5c448d707ffda75 ) );
    isfiresale = iskioskfiresaleactiveforplayer( kiosk, player );
    itemstocks = [];
    var_eb3c060658ee0b1f = 0;
    
    foreach ( itemkey, itemstock in level.buystationstock[ kiosk.index ].stock )
    {
        if ( isdefined( itemstock ) )
        {
            ishidden = !isfiresale && var_a5c448d707ffda75[ itemkey ][ "hidden" ];
            
            if ( ishidden )
            {
                itemstocks[ var_eb3c060658ee0b1f ] = 0;
            }
            else
            {
                itemstocks[ var_eb3c060658ee0b1f ] = itemstock;
            }
        }
        
        var_eb3c060658ee0b1f++;
    }
    
    return itemstocks;
}

// Namespace common_kiosk
// Params 2, eflags: 0x4
// Checksum 0xbd94a884, Offset: 0x4dc4
// Size: 0x89
function private function_b402b2318d41f582( kiosk, var_317f3ab12fa62d40 )
{
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    itemstock = level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ];
    
    if ( isdefined( itemstock ) )
    {
        level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ] = itemstock > 0 ? itemstock - 1 : 0;
    }
}

// Namespace common_kiosk
// Params 1
// Checksum 0xd63c5c2d, Offset: 0x4e55
// Size: 0xac
function function_8e75a0bbf4978d44( var_317f3ab12fa62d40 )
{
    foreach ( kiosk in level.buystationstock )
    {
        if ( kiosk.stock && kiosk.stock[ var_317f3ab12fa62d40 ] )
        {
            kiosk.stock[ var_317f3ab12fa62d40 ] = 0;
        }
    }
}

// Namespace common_kiosk
// Params 2
// Checksum 0x1bad9810, Offset: 0x4f09
// Size: 0x5b, Type: bool
function function_a3a8490ca41b030( kiosk, var_317f3ab12fa62d40 )
{
    if ( function_4563779f87eaade6( kiosk ) )
    {
        itemstock = level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ];
        
        if ( isdefined( itemstock ) )
        {
            return ( itemstock > 0 );
        }
    }
    
    return true;
}

// Namespace common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x57f03008, Offset: 0x4f6d
// Size: 0x124, Type: bool
function private function_a299a6bcc22b544e( var_ff9868b785ff9ce3, kioskindex )
{
    buystationdata = level.common_kiosk_data common_kiosk_data::function_e7774bf19f7a50f5( var_ff9868b785ff9ce3 );
    
    if ( isdefined( buystationdata ) )
    {
        var_f4f7339936f9daae = spawnstruct();
        var_f4f7339936f9daae.defindex = var_ff9868b785ff9ce3;
        var_f4f7339936f9daae.randomselections = [];
        
        foreach ( var_5016f46d98f3477c, var_e485a4d261fe5c1a in buystationdata[ "items" ] )
        {
            var_f4f7339936f9daae.randomselections[ var_5016f46d98f3477c ] = var_e485a4d261fe5c1a[ "isRandomlySelected" ];
            
            if ( callback::response( 0, #"hash_72f5a6e1ba95ac81", { #itemkey:var_5016f46d98f3477c } ) )
            {
                var_f4f7339936f9daae.randomselections[ var_5016f46d98f3477c ] = 0;
            }
        }
        
        level.var_f4f7339936f9daae[ kioskindex ] = var_f4f7339936f9daae;
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x316066f7, Offset: 0x509a
// Size: 0xd6, Type: bool
function private function_c0abf8027df7f1b8( kiosk )
{
    if ( getdvarint( @"hash_2f0e4762f460592e", 0 ) == 1 )
    {
        return false;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( kiosk.index ) ) )
    {
        return false;
    }
    
    if ( !isdefined( function_c3950de54d46edf() ) )
    {
        return false;
    }
    
    var_ff9868b785ff9ce3 = function_102866f824ac6d9( kiosk );
    
    if ( !isdefined( var_ff9868b785ff9ce3 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_f4f7339936f9daae ) )
    {
        level.var_f4f7339936f9daae = [];
    }
    
    if ( isdefined( level.var_f4f7339936f9daae[ kiosk.index ] ) && level.var_f4f7339936f9daae[ kiosk.index ].defindex == var_ff9868b785ff9ce3 )
    {
        return true;
    }
    
    if ( function_a299a6bcc22b544e( var_ff9868b785ff9ce3, kiosk.index ) )
    {
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x60323c80, Offset: 0x5179
// Size: 0xca
function private function_993fabb597004d08( kiosk )
{
    if ( !function_c0abf8027df7f1b8( kiosk ) )
    {
        return;
    }
    
    itemspacked = 0;
    var_323be4de0e66242e = 0;
    var_73e4a9938e76a621 = function_6b45f82f5c3ae97e( kiosk );
    
    foreach ( var_d6d38ad33f00aa28 in var_73e4a9938e76a621 )
    {
        if ( isdefined( var_d6d38ad33f00aa28 ) )
        {
            assert( itemspacked < 32 );
            var_323be4de0e66242e |= var_d6d38ad33f00aa28 << itemspacked;
            itemspacked++;
        }
    }
    
    return var_323be4de0e66242e;
}

// Namespace common_kiosk
// Params 1, eflags: 0x4
// Checksum 0x32eabce2, Offset: 0x524c
// Size: 0x149
function private function_6b45f82f5c3ae97e( kiosk )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !function_c0abf8027df7f1b8( kiosk ) )
    {
        return;
    }
    
    var_2c9779b496ba134c = level.var_f4f7339936f9daae[ kiosk.index ].defindex;
    buystationdata = level.common_kiosk_data common_kiosk_data::function_e7774bf19f7a50f5( var_2c9779b496ba134c );
    var_a5c448d707ffda75 = isdefined( buystationdata ) ? buystationdata[ "items" ] : undefined;
    assert( isdefined( var_a5c448d707ffda75 ) );
    var_73e4a9938e76a621 = [];
    var_621aea5e6ff6b8d7 = 0;
    
    foreach ( isRandomlySelected in level.var_f4f7339936f9daae[ kiosk.index ].randomselections )
    {
        if ( isdefined( isRandomlySelected ) )
        {
            var_73e4a9938e76a621[ var_621aea5e6ff6b8d7 ] = isRandomlySelected;
            var_621aea5e6ff6b8d7++;
        }
    }
    
    return var_73e4a9938e76a621;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xc391dcac, Offset: 0x539e
// Size: 0x59, Type: bool
function function_d3af9092c4c99795( var_317f3ab12fa62d40 )
{
    itemdata = level.common_kiosk_data common_kiosk_data::function_98010bc27337cc99( var_317f3ab12fa62d40 );
    
    if ( itemdata.type == "teamrevive" )
    {
        return true;
    }
    
    if ( isdefined( common_item::function_cf68ad18114498b2( itemdata.ref ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace common_kiosk
// Params 1
// Checksum 0xf3ae928b, Offset: 0x5400
// Size: 0x1d
function function_831cebfde57b193f( var_317f3ab12fa62d40 )
{
    return level.common_kiosk_data common_kiosk_data::function_561b8e8b8ed4c18b( var_317f3ab12fa62d40 );
}

// Namespace common_kiosk
// Params 0
// Checksum 0x398b7811, Offset: 0x5426
// Size: 0xd2
function waitforprematchdone()
{
    if ( level.skipprematch )
    {
        utility::flag_wait( "buy_stations_spawned" );
    }
    else
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        armorykiosk setscriptablepartstate( "br_plunder_box", "visible" );
        showobjective( armorykiosk );
        armorykiosk.visible = 1;
    }
    
    function_6429f67365dadd21();
}

// Namespace common_kiosk
// Params 0
// Checksum 0x2d483eb3, Offset: 0x5500
// Size: 0xd
function function_f687bd211d712b96()
{
    level.var_dbdd35c475d50ae3 = 1;
}

