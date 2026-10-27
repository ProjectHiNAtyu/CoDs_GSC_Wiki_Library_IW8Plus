// scripts\common\vehicle_upgrade.gsc  (hash_13535550b56b5ec3.gscc) (size: 5157 Bytes / 0x1425 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x180ab63d (403355197)
// size ...... 5157 (0x1425)
// includes .. 4   (offset: 0x1359)
// strings ... 12  (offset: 0x1379)
// dev strs .. 0   (offset: 0x1425)
// exports ... 19  (offset: 0xc05)
// cseg ...... 0x189 + 0xa7c (0xc05)
// imports ... 36  (offset: 0xefd)
// animtree1 . 0   (offset: 0x1425)
// animtree2 . 0   (offset: 0x1425)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;

#namespace vehicle_upgrade;

// Namespace vehicle_upgrade
// Params 0
// Checksum 0xbff3c2c6, Offset: 0x1a7
// Size: 0x4f
function init()
{
    scriptable::scriptable_addusedcallbackbypart( "upgrade_usable", &function_555cf768f48c097e );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_61d43ca2b136d4ed", &handle_player_interaction );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_bd5fa758a67e4379", &function_d324610dbdb1aee4 );
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x88b25558, Offset: 0x1fe
// Size: 0x4e
function handle_player_interaction( vehicleref )
{
    vehicle = self;
    vehicle.script_instance = self getlinkedscriptableinstance();
    vehicle.script_instance.interact_hint_callback = &set_upgrade_prompt;
    vehicle thread function_5511c990e83b0a68();
}

// Namespace vehicle_upgrade
// Params 2
// Checksum 0x802f46c3, Offset: 0x254
// Size: 0x78
function set_upgrade_prompt( instance, player )
{
    s = { #string:&"", #type:"HINT_NOBUTTON" };
    
    if ( function_55f408090cad4211( player ) )
    {
        return s;
    }
    
    s.type = "HINT_BUTTON";
    s.string = &"aar/vehicle_upgrade";
    return s;
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x5df87c90, Offset: 0x2d5
// Size: 0x47, Type: bool
function function_55f408090cad4211( player )
{
    if ( getdvarint( @"hash_98cc64407c256ad2", 0 ) == 0 )
    {
        return true;
    }
    
    if ( player function_b4a6ff1e58474720() )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_d43f79c2d0026514", 0 ) == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_upgrade
// Params 6
// Checksum 0x3450e182, Offset: 0x325
// Size: 0x52
function function_555cf768f48c097e( instance, part, state, player, bautouse, usestring )
{
    if ( instance )
    {
        player function_8f9de6fc66c687bf( instance.entity );
    }
}

// Namespace vehicle_upgrade
// Params 3, eflags: 0x40 variadic
// Checksum 0x94a45a0b, Offset: 0x37f
// Size: 0x4d
function function_a8bc38dd8ee1c269( funcname, ... )
{
    if ( !utility::issharedfuncdefined( #"vehicle_upgrade", funcname ) )
    {
        return;
    }
    
    self [[ utility::getsharedfunc( #"vehicle_upgrade", funcname ) ]]( flat_args( vararg, varargcount ) );
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x7ea518b8, Offset: 0x3d4
// Size: 0x3a
function function_4ab62476b8ca3897( bundlename )
{
    if ( !bundlename )
    {
        return 0;
    }
    
    var_35ee2c14286abce4 = getscriptbundlefieldvalue( bundlename, #"upgrades" );
    return var_35ee2c14286abce4.var_ef90568e6118ac66;
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0x253f1268, Offset: 0x417
// Size: 0x6d
function function_5511c990e83b0a68()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.var_74ee74786dc78183 = 0;
    self.upgradeinstalled = [];
    self.activecamostate = "none";
    
    while ( true )
    {
        waitframe();
        
        if ( self.occupants[ "driver" ] )
        {
            function_dd454c217bcaad73( self.occupants[ "driver" ] );
        }
    }
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x375eaf66, Offset: 0x48c
// Size: 0x146
function function_dd454c217bcaad73( driver )
{
    vehicle = self;
    
    foreach ( upgradeentry in vehicle.var_32ec4ae63b9c728d )
    {
        switch ( upgradeentry.button )
        {
            case #"hash_d8eecb842ee1ff3d":
                buttonpressed = driver attackbuttonpressed();
                break;
            case #"hash_10f0141a11602380":
                buttonpressed = driver hornbuttonpressed();
                break;
            case #"hash_ad3f4c96bdffbd6c":
                buttonpressed = driver sprintbuttonpressed();
                break;
            case #"hash_8bda341f1df69bb":
                buttonpressed = driver meleebuttonpressed();
                break;
            case #"hash_fc12441dd3f2a49e":
                continue;
        }
        
        if ( buttonpressed && !upgradeentry.wasbuttonpressed )
        {
            vehicle function_cfc600655f4c9b5f( upgradeentry.type );
        }
        
        upgradeentry.wasbuttonpressed = buttonpressed;
    }
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x5237f000, Offset: 0x5da
// Size: 0x1c0
function function_cfc600655f4c9b5f( var_fe3a61cb138c47ba )
{
    vehicle = self;
    
    switch ( var_fe3a61cb138c47ba )
    {
        case #"hash_78fbf6fc12d91800":
            vehicle function_a8bc38dd8ee1c269( #"hash_7865b38aec589d83", "Active_Camo" );
            break;
        case #"hash_8cf7707048c56910":
            vehicle function_a8bc38dd8ee1c269( #"hash_8f2a7f9d99b4781c" );
            break;
        case #"hash_7f08b9f5853dd2b":
            currenttime = gettime();
            cooldownduration = getdvarfloat( @"hash_f6124c9e0e051884", 3 ) * 1000;
            
            if ( currenttime - vehicle.var_74ee74786dc78183 >= cooldownduration )
            {
                vehicle function_a8bc38dd8ee1c269( #"launch_smoke_screen" );
                vehicle.var_74ee74786dc78183 = currenttime;
            }
            
            break;
        case #"hash_dc5c9a6c7dbb9a45":
            vehicle function_a8bc38dd8ee1c269( #"activate_emp" );
            break;
        case #"hash_530fe7b36ee59286":
            vehicle function_a8bc38dd8ee1c269( #"hash_7865b38aec589d83", "Constant_Radar" );
            break;
        case #"hash_ddfc597c77e40794":
            vehicle function_a8bc38dd8ee1c269( #"hash_5fa634f22b7339b7" );
            vehicle.var_74ee74786dc78183 = gettime();
            break;
        case #"hash_ac1008c44e824ee4":
            vehicle function_a8bc38dd8ee1c269( #"hash_6ce4c060253a4423" );
            break;
        case #"hash_41cfdcd09cdc53ba":
            vehicle function_a8bc38dd8ee1c269( #"hash_7865b38aec589d83", "Perception" );
            break;
        case #"hash_884477e113c01b3d":
            vehicle function_a8bc38dd8ee1c269( #"hash_7865b38aec589d83", "Engineer_Perk" );
            break;
    }
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0xc7bb5874, Offset: 0x7a2
// Size: 0x1b
function get_vehicle_upgrade_data()
{
    return getscriptbundlefieldvalue( vehicle::function_451bd53633bae879( vehicle::get_ref() ), #"upgrades" );
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0x3e60d014, Offset: 0x7c6
// Size: 0x43
function get_level_up_upgrade( newlevel )
{
    var_35ee2c14286abce4 = get_vehicle_upgrade_data();
    var_213c18f6f764fab1 = var_35ee2c14286abce4.var_54324f91ef43fb3d[ newlevel ];
    return var_213c18f6f764fab1.upgradeentries[ 0 ];
}

// Namespace vehicle_upgrade
// Params 1
// Checksum 0xcc6f453a, Offset: 0x812
// Size: 0x1e
function function_8f9de6fc66c687bf( vehicle )
{
    function_a8bc38dd8ee1c269( #"hash_5d621ce51a25bcb1", vehicle );
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0x3fee2de7, Offset: 0x838
// Size: 0x26
function function_d324610dbdb1aee4()
{
    vehicle = self;
    vehicle.currentlevel = -1;
    vehicle function_9df9728803989c17();
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0x68c1c0b8, Offset: 0x866
// Size: 0x112
function function_9df9728803989c17()
{
    vehicle = self;
    nextlevel = ( vehicle.currentlevel ?? 0 ) + 1;
    var_35ee2c14286abce4 = get_vehicle_upgrade_data();
    
    foreach ( upgradeentry in var_35ee2c14286abce4.var_54324f91ef43fb3d[ nextlevel ].upgradeentries )
    {
        vehicle function_9ee1ba274963a183( upgradeentry.type, upgradeentry );
        
        if ( !isdefined( vehicle.var_32ec4ae63b9c728d ) )
        {
            vehicle.var_32ec4ae63b9c728d = [];
        }
        
        vehicle.var_32ec4ae63b9c728d[ vehicle.var_32ec4ae63b9c728d.size ] = upgradeentry;
    }
    
    vehicle.currentlevel = nextlevel;
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0x634d15b7, Offset: 0x980
// Size: 0x12
function function_dff68430fce18542()
{
    function_a8bc38dd8ee1c269( #"hash_44c93c33e390e0cf" );
}

// Namespace vehicle_upgrade
// Params 2
// Checksum 0x612eb021, Offset: 0x99a
// Size: 0x251
function function_9ee1ba274963a183( var_4b58c4bf2872fb96, upgradeentry )
{
    vehicle = self;
    
    if ( var_4b58c4bf2872fb96 && !vehicle.upgradeinstalled[ var_4b58c4bf2872fb96 ] )
    {
        switch ( var_4b58c4bf2872fb96 )
        {
            case #"hash_78fbf6fc12d91800":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "Active_Camo", upgradeentry );
                break;
            case #"hash_8cf7707048c56910":
                vehicle function_a8bc38dd8ee1c269( #"hash_969e1230c993fa5f", upgradeentry );
                break;
            case #"hash_7f08b9f5853dd2b":
                vehicle function_a8bc38dd8ee1c269( #"hash_c8f6ffeb88e0b906" );
                break;
            case #"hash_dd6ee151a48ef501":
                vehicle function_a8bc38dd8ee1c269( #"hash_709a849183e9aeac", upgradeentry );
                break;
            case #"hash_ac1008c44e824ee4":
                vehicle function_a8bc38dd8ee1c269( #"hash_6ce4c060253a4423" );
                break;
            case #"hash_dc5c9a6c7dbb9a45":
                vehicle function_a8bc38dd8ee1c269( #"hash_18a511d87bcc9c48" );
                break;
            case #"hash_884477e113c01b3d":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "Engineer_Perk", upgradeentry );
                break;
            case #"hash_654a72ee51d508c9":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "See_Safes", upgradeentry );
                vehicle function_a8bc38dd8ee1c269( #"hash_3bbb5a2695442238", "See_Safes", 1 );
                vehicle function_a8bc38dd8ee1c269( #"hash_3ed6ad10d8ca834" );
                break;
            case #"hash_ddfc597c77e40794":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "Active_Camo", upgradeentry );
                vehicle function_a8bc38dd8ee1c269( #"hash_c8f6ffeb88e0b906" );
                break;
            case #"hash_41cfdcd09cdc53ba":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "Perception", upgradeentry );
                break;
            case #"hash_530fe7b36ee59286":
                vehicle function_a8bc38dd8ee1c269( #"hash_fea4e2b6ae3c3db6", "Constant_Radar", upgradeentry );
                break;
        }
        
        vehicle.upgradeinstalled[ var_4b58c4bf2872fb96 ] = 1;
        vehicle setscriptablepartstate( "upgrades", "levelup", 0 );
    }
    
    vehicle vehicle_damage::set_health( vehicle.maxhealth );
}

// Namespace vehicle_upgrade
// Params 0
// Checksum 0x584b0506, Offset: 0xbf3
// Size: 0x11
function function_b4a6ff1e58474720()
{
    return function_a8bc38dd8ee1c269( #"hash_5559a03ad8c2a04b" );
}

