// script_3b5f1fa53313feda  (hash_3b5f1fa53313feda.gscc) (size: 23931 Bytes / 0x5d7b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2c9831c (3804857116)
// size ...... 23931 (0x5d7b)
// includes .. 16  (offset: 0x584b)
// strings ... 55  (offset: 0x58cb)
// dev strs .. 34  (offset: 0x5baf)
// exports ... 54  (offset: 0x3d73)
// cseg ...... 0x5a7 + 0x37cc (0x3d73)
// imports ... 139 (offset: 0x45e3)
// animtree1 . 0   (offset: 0x5d7b)
// animtree2 . 0   (offset: 0x5d7b)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\frune_checkpoints;
#using scripts\mp\gametypes\frune_free_run_evo;
#using scripts\mp\hud_message;
#using scripts\mp\parachute;

#namespace namespace_c41f357b2d127aee;

// Namespace namespace_c41f357b2d127aee
// Params 0
// Checksum 0xa08b8c18, Offset: 0x5c5
// Size: 0x222
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "equipment_initialized" );
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_ead9a471818e10f8 = getdvarint( @"hash_ce76be92437dc326", modeinfo.frune_bundle.var_903e2b05d5c9ce3d ?? 1 );
    parachute::initparachutedvars();
    function_af36cac9d0867dc5();
    initializepickups();
    function_3afe7242ec69f93c();
    level callback::add( #"grenade_fire", &grenade_fire );
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x42>", "<dev string:x51>", &function_ee76c11f06780c35, helptext, "<dev string:x55>", undefined );
        }
        
        helptext = "<dev string:x5a>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x81>", "<dev string:x51>", &function_f2dc1a1a59e6ca5c, helptext, "<dev string:x55>", undefined );
        }
        
        helptext = "<dev string:x92>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xbc>", "<dev string:x51>", &function_20e56e4583dc6f39, helptext, "<dev string:x55>", undefined );
        }
        
        helptext = "<dev string:xd2>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xfd>", "<dev string:x51>", &function_79ce3097593244a9, helptext, "<dev string:x55>", undefined );
        }
        
        helptext = "<dev string:x112>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x133>", "<dev string:x51>", &function_73c02a986e15c740, helptext, "<dev string:x55>", undefined );
        }
    #/
    
    level notify( #"hash_f75c923c050b621d" );
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0x4
// Checksum 0x4f7d9b4d, Offset: 0x7ef
// Size: 0x24d
function private initializepickups()
{
    pickuplist = getentarray( "pickup", "script_noteworthy" );
    
    foreach ( pickup in pickuplist )
    {
        ismotorcycle = pickup.script_label == "motorcycle";
        removemotorcycle = pickup.script_objective == "remove_motorcycle";
        iswingsuit = pickup.script_label == "wingsuit";
        isequipment = equipment_mp::isequipment( pickup.script_label );
        var_e99eaef8842a6200 = utility::getstruct( pickup.target, "targetname" );
        groundresult = function_dd0db1ba44ccf570( var_e99eaef8842a6200.origin, var_e99eaef8842a6200.angles );
        scriptable = spawnscriptable( "mp_sat_free_run_evo_pickup", groundresult.position, groundresult.angles );
        modelpart = function_18afec90da10540e( pickup.script_parameters );
        var_7c3b92b7428f4a0d = function_355da31eba541753( pickup.script_parameters );
        pickup.pickupinfo = { #itemname:pickup.script_label ?? "", #isequipment:isequipment, #iswingsuit:iswingsuit, #removemotorcycle:removemotorcycle, #ismotorcycle:ismotorcycle, #var_7c3b92b7428f4a0d:var_7c3b92b7428f4a0d, #modelpart:modelpart, #scriptable:scriptable, #pickupentity:pickup };
        scriptable utility::function_32b24db3127bff40( modelpart, #"idle" );
        function_39452db4a26a0b01( pickup.pickupinfo );
        trigger::makeenterexittrigger( pickup, &function_b3f0339fb0a4c7ac, &function_fece5436aeb3b032 );
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x584d4e3d, Offset: 0xa44
// Size: 0x10f
function private function_dd0db1ba44ccf570( position, angles )
{
    startposition = position + ( 0, 0, 50 );
    endposition = position + ( 0, 0, -50 );
    contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water" ] );
    result = trace::sphere_trace( startposition, endposition, 10, undefined, contents );
    
    if ( result[ "hittype" ] == "hittype_none" )
    {
        groundposition = position;
        groundangles = angles;
    }
    else
    {
        groundposition = result[ "position" ];
        groundangles = generateaxisanglesfromupvector( result[ "normal" ], angles );
    }
    
    /#
        logprint( "<dev string:x145>" + position + "<dev string:x150>" + groundposition + "<dev string:x161>" );
    #/
    
    return { #angles:groundangles, #position:groundposition };
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x4a9d7f80, Offset: 0xb5c
// Size: 0x3c
function private function_355da31eba541753( params )
{
    if ( !params )
    {
        return 1;
    }
    
    switch ( params )
    {
        case #"hash_e0ab8121710cb5fe":
            return 0;
        default:
            return 1;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0xe87d5561, Offset: 0xba0
// Size: 0x151
function private function_18afec90da10540e( params )
{
    if ( !params )
    {
        return #"pistol";
    }
    
    switch ( params )
    {
        case #"hash_e0ab8121710cb5fe":
            return #"motorcycle";
        case #"hash_8188d7d9ca79f635":
            return #"wingsuit";
        case #"hash_ae279455b66a158c":
            return #"wingsuit_nobase";
        case #"hash_16cd760e0326c848":
            return #"pistol";
        case #"hash_51a4f48532822a9c":
            return #"ar";
        case #"hash_cc0002dee5de3520":
            return #"smg";
        case #"hash_8a6b24761cfa1343":
            return #"smg_nobase";
        case #"hash_b487f80c4a23b46b":
            return #"shotgun";
        case #"hash_45367d77feb5acc7":
            return #"ballisticknife";
        case #"hash_8a4886e4eef091b6":
            return #"grapple";
        case #"hash_ee7e29433727e9d9":
            return #"grapple_nobase";
        case #"hash_5cb80d05093ce74f":
            return #"hash_33dfa2ca586996f9";
        default:
            assertmsg( "<dev string:x164>" );
            return #"pistol";
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x7d580c81, Offset: 0xcf9
// Size: 0x59
function private function_39452db4a26a0b01( pickupinfo )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.pickuplist ) )
    {
        modeinfo.pickuplist = [];
    }
    
    modeinfo.pickuplist[ modeinfo.pickuplist.size ] = pickupinfo;
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0x4
// Checksum 0x1964c563, Offset: 0xd5a
// Size: 0x8c
function private function_3afe7242ec69f93c()
{
    var_83e2b0ac466a281e = getentarray( "temp_clear_loadout", "script_noteworthy" );
    
    foreach ( trigger in var_83e2b0ac466a281e )
    {
        trigger thread function_6ddc7b5b564fd80c();
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x8c42421a, Offset: 0xdee
// Size: 0x40
function private function_47f57f55a7b21d59( var_8aed0568bba4554a )
{
    targetplayer = frune_checkpoints::function_689377905ae386ba( var_8aed0568bba4554a );
    
    if ( !targetplayer && isalive( var_8aed0568bba4554a ) && isplayer( var_8aed0568bba4554a ) )
    {
        targetplayer = var_8aed0568bba4554a;
    }
    
    return targetplayer;
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0x4
// Checksum 0x4b282a43, Offset: 0xe37
// Size: 0x73
function private function_6ddc7b5b564fd80c()
{
    level endon( #"game_ended" );
    modeinfo = game[ #"frune_tuning" ];
    
    while ( true )
    {
        self waittill( #"trigger", var_8aed0568bba4554a );
        targetplayer = function_47f57f55a7b21d59( var_8aed0568bba4554a );
        
        if ( !targetplayer )
        {
            continue;
        }
        
        function_b90bc384cbf8537a( targetplayer, modeinfo.emptyloadout );
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2
// Checksum 0x97cef8e, Offset: 0xeb2
// Size: 0x74
function function_1801310b8744ec73( zoneindex, checkpointindex )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ] )
    {
        return modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ];
    }
    
    assertmsg( "<dev string:x186>" + zoneindex + "<dev string:x1aa>" + checkpointindex );
    return modeinfo.emptyloadout;
}

// Namespace namespace_c41f357b2d127aee
// Params 3, eflags: 0x4
// Checksum 0xdf8715e0, Offset: 0xf2f
// Size: 0x68
function private function_364f0b9c79dbcd7d( zoneindex, checkpointindex, loadout )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.var_d0140de3a3dd8bc0[ zoneindex ] ) )
    {
        modeinfo.var_d0140de3a3dd8bc0[ zoneindex ] = [];
    }
    
    modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ] = loadout;
}

// Namespace namespace_c41f357b2d127aee
// Params 2
// Checksum 0xc4ada66c, Offset: 0xf9f
// Size: 0x1b2
function function_b90bc384cbf8537a( player, currentloadout )
{
    /#
        modeinfo = game[ #"frune_tuning" ];
        
        if ( modeinfo.var_23a26c9f664b6db2 )
        {
            return;
        }
    #/
    
    if ( currentloadout.equipment.motorcycle )
    {
        function_8e86fdaac3c0ddf6( player );
    }
    else
    {
        function_a250bbf53925ba8f( player );
    }
    
    if ( currentloadout.equipment.wingsuit )
    {
        function_fab6ca1b33c459a1( player );
    }
    else
    {
        function_12d19bf2de37e954( player );
    }
    
    if ( currentloadout.equipment.lethal )
    {
        function_a0893f97810aa85b( player, currentloadout.equipment.lethal );
    }
    else
    {
        function_fdded9a4f276c824( player );
    }
    
    if ( currentloadout.equipment.tactical )
    {
        function_a0893f97810aa85b( player, currentloadout.equipment.tactical );
    }
    else
    {
        function_ebc318f881f86d1b( player );
    }
    
    if ( currentloadout.weapons.weaponprimary )
    {
        giveweaponpickup( player, currentloadout.weapons.weaponprimary );
    }
    else
    {
        function_4041d647f84d8284( player );
    }
    
    if ( currentloadout.weapons.weaponprimary && player getcurrentweapon() != currentloadout.weapons.weaponprimary )
    {
        player switchtoweaponimmediate( currentloadout.weapons.weaponprimary );
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1
// Checksum 0x95b05ec2, Offset: 0x1159
// Size: 0x27
function function_b51d5e13aaac51cf( player )
{
    function_453dc4fee393c18c( player );
    function_90f530e92794426c( player );
    function_a3ee9703ea9da3ee( player );
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0xdd82767d, Offset: 0x1188
// Size: 0x86
function private function_c9696336ee100d71( player, weaponname )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.pickupweapons ) )
    {
        modeinfo.pickupweapons = [];
    }
    
    if ( !isdefined( modeinfo.pickupweapons[ weaponname ] ) )
    {
        modeinfo.pickupweapons[ weaponname ] = weapon::buildweapon( weaponname );
    }
    
    giveweaponpickup( player, modeinfo.pickupweapons[ weaponname ] );
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0xf4f47220, Offset: 0x1216
// Size: 0x96
function private giveweaponpickup( player, weapon )
{
    if ( player.current_weapon && player.current_weapon != weapon )
    {
        player takeweapon( player.current_weapon );
    }
    
    if ( !player hasweapon( weapon ) )
    {
        player utility::function_32b24db3127bff40( #"hash_833f34a204b95ec", #"on" );
        player giveweapon( weapon );
        player inventory_utility::_switchtoweaponimmediate( weapon );
        player.current_weapon = weapon;
        player thread function_f519d0f7cbdce61b();
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0xa2a325b2, Offset: 0x12b4
// Size: 0x5a
function private function_4041d647f84d8284( player )
{
    if ( !player.current_weapon )
    {
        return;
    }
    
    player takeweapon( player.current_weapon );
    var_aee4a26061377908 = weapon::buildweapon( "t10_me_fists" );
    player inventory_utility::_switchtoweaponimmediate( var_aee4a26061377908 );
    player.current_weapon = undefined;
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x43aa463c, Offset: 0x1316
// Size: 0xb9
function private function_a0893f97810aa85b( player, equipmentname )
{
    if ( !player )
    {
        return;
    }
    
    var_15d6b1f0804a8a02 = player equipment_mp::hasequipment( equipmentname );
    
    if ( var_15d6b1f0804a8a02 )
    {
        return;
    }
    
    if ( equipmentname == "equip_grappling_hook" )
    {
        player hud_message::showsplash( "free_run_grappling_hook_acquired", undefined, undefined, undefined, undefined, undefined, 1 );
        player thread function_24012f7ecccc24fa();
    }
    
    player utility::function_32b24db3127bff40( #"hash_18f20281e99d20e7", #"on" );
    equipmentslot = level.equipment.table[ equipmentname ].defaultslot;
    player equipment_mp::giveequipment( equipmentname, equipmentslot );
    player thread function_f519d0f7cbdce61b();
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x22e89d0, Offset: 0x13d7
// Size: 0x1a
function private function_fdded9a4f276c824( player )
{
    player equipment_mp::takeequipment( "primary" );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0xbe942b49, Offset: 0x13f9
// Size: 0x1a
function private function_ebc318f881f86d1b( player )
{
    player equipment_mp::takeequipment( "secondary" );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x4a5c05ae, Offset: 0x141b
// Size: 0x2d
function private function_26ebb630b1b2ed88( params )
{
    if ( isplayer( self ) )
    {
        self.operatorcustomization.suit = "sat_wingsuit_mp_frune";
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1
// Checksum 0x8850d827, Offset: 0x1450
// Size: 0x116
function function_1c6d21480ed20b1f( player )
{
    level endon( #"game_ended" );
    player callback::add( #"hash_1c82c96d0d334fcc", &function_26ebb630b1b2ed88 );
    
    while ( player )
    {
        player waittill( #"skydive_deployparachute" );
        
        if ( !player )
        {
            return;
        }
        
        if ( player.suit == "sat_wingsuit_mp_frune" )
        {
            player attach( %"c_sat_gear_wingsuit_flaps_01" );
            player thread parachute::infilparachutevfx( 1, 0 );
        }
        
        var_7fc83b11ade25e3f = [ "skydive_end", "last_stand_enter", "death_or_disconnect" ];
        
        if ( getdvarint( @"hash_511a0b121e17b192", 1 ) == 1 )
        {
            var_7fc83b11ade25e3f[ var_7fc83b11ade25e3f.size ] = "skydive_touch";
        }
        
        player utility::waittill_any_in_array( var_7fc83b11ade25e3f );
        
        if ( !player )
        {
            return;
        }
        
        if ( player.suit == "sat_wingsuit_mp_frune" )
        {
            player detach( %"c_sat_gear_wingsuit_flaps_01" );
            player setshowcontrail( 0 );
        }
        
        if ( player.inlaststand )
        {
            player skydive_interrupt();
        }
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x42f50fde, Offset: 0x156e
// Size: 0x115
function private function_8e86fdaac3c0ddf6( player )
{
    if ( player.freeruninfo.motorcycleequipped )
    {
        return;
    }
    
    player.freeruninfo.motorcycleequipped = 1;
    player utility::function_32b24db3127bff40( #"hash_f61b98462db40b35", #"on" );
    spawndata = { #vehicletype:"veh_sat_derived_port_civ_lnd_dirt_bike", #script_vehicleref:"veh_sat_civ_lnd_dirt_bike_mp", #script_vehiclebundle:%"hash_d82d59c77d9522c", #modelname:"xcomp_veh_sat_civ_triumph_motorcycle_tf250x_mpx_vehphys", #angles:player.angles, #origin:player.origin };
    player.spawnedvehicle = vehicle::default_spawn( spawndata.script_vehiclebundle, spawndata, undefined );
    player.spawnedvehicle.owningplayer = player;
    player usevehicle( player.spawnedvehicle, 0, 0 );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x8de2a2c9, Offset: 0x168b
// Size: 0xe8
function private function_a250bbf53925ba8f( player )
{
    player.freeruninfo.motorcycleequipped = 0;
    
    if ( !player.spawnedvehicle )
    {
        return;
    }
    
    player.spawnedvehicle vehicle_damage::set_can_damage( 0 );
    player leavevehicle( 1 );
    player.spawnedvehicle vehicle_damage::clear_visuals( undefined, undefined, 1 );
    player.spawnedvehicle setscriptablepartstate( "visibility", "hide", 0 );
    player.spawnedvehicle stopsounds();
    vehicle_compass::vehicle_hide( player.spawnedvehicle );
    vehicle_damage::deregister_instance( player.spawnedvehicle );
    vehicle_interact::deregister_instance( player.spawnedvehicle );
    vehicle_tracking::deregister_instance( player.spawnedvehicle );
    player.spawnedvehicle delete();
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x664c5b09, Offset: 0x177b
// Size: 0xab
function private function_fab6ca1b33c459a1( player )
{
    if ( player.freeruninfo.wingsuitequipped )
    {
        return;
    }
    
    player.freeruninfo.wingsuitequipped = 1;
    player.redeployenabled = 1;
    player function_197ef48187159d23();
    player skydive_setdeploymentstatus( 1 );
    player skydive_setbasejumpingstatus( 1 );
    player utility::function_32b24db3127bff40( #"hash_113a923a6d8726c2", #"on" );
    player.suit = "sat_wingsuit_mp_frune";
    player.operatorcustomization.suit = "sat_wingsuit_mp_frune";
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x5635e034, Offset: 0x182e
// Size: 0x66
function private function_12d19bf2de37e954( player )
{
    player.freeruninfo.wingsuitequipped = 0;
    player.redeployenabled = 0;
    
    if ( game[ #"frune_tuning" ].var_ead9a471818e10f8 )
    {
        player skydive_end();
    }
    
    player function_197ef48187159d23();
    player skydive_setdeploymentstatus( 0 );
    player skydive_setbasejumpingstatus( 0 );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0xedc1c1ea, Offset: 0x189c
// Size: 0x6d
function private grenade_fire( grenadedata )
{
    grenade = grenadedata.grenade;
    
    if ( !function_defe58d54b682791( grenade.weapon_object ) )
    {
        return;
    }
    
    grenade thread function_81a9f9ccf5d3d62e( grenade, grenade.owner, grenade.owner.freeruninfo.var_2da2754256feb51b );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x85da670d, Offset: 0x1911
// Size: 0x95, Type: bool
function private function_defe58d54b682791( weaponobj )
{
    if ( weaponobj.basenamehash == game[ #"frune_tuning" ].warmachineloadout.weapons.weaponprimary.basenamehash || weaponobj.basenamehash == game[ #"frune_tuning" ].nembusloadout.weapons.weaponprimary.basenamehash )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_c41f357b2d127aee
// Params 3, eflags: 0x4
// Checksum 0x2e82a294, Offset: 0x19af
// Size: 0x258
function private function_81a9f9ccf5d3d62e( grenade, player, var_8b9f5a3a6252169f )
{
    level endon( #"game_ended" );
    level endon( #"death" );
    grenade utility::waittill_any( "death", "explode" );
    
    if ( !player || !grenade )
    {
        return;
    }
    
    targets = getscriptablearrayinradius( "scriptable_mp_sat_freerun_shootable_target_01", #classname, grenade.origin, 275 );
    
    foreach ( shootabletarget in targets )
    {
        shootabletarget dodamage( 100, grenade.origin, player, grenade, "MOD_PROJECTILE" );
    }
    
    /#
        modeinfo = game[ #"frune_tuning" ];
        
        if ( modeinfo.grenadedebugenabled )
        {
            if ( !isdefined( modeinfo.var_7ff75fa6d306a5f7 ) )
            {
                modeinfo.var_7ff75fa6d306a5f7 = { #grenadespots:[], #grenadeindex:0 };
            }
            
            grenadeinfo = modeinfo.var_7ff75fa6d306a5f7;
            grenadeinfo.grenadeindex = ( grenadeinfo.grenadeindex + 1 ) % 5;
            grenadeinfo.grenadespots[ grenadeinfo.grenadeindex ] = grenade.origin;
        }
    #/
    
    if ( !var_8b9f5a3a6252169f )
    {
        return;
    }
    
    var_36424711de9aaaa5 = player.origin - grenade.origin;
    distancetoplayer = length( var_36424711de9aaaa5 );
    var_f0b7174bef3b9406 = 1 - distancetoplayer / 300;
    
    if ( var_f0b7174bef3b9406 > 0 )
    {
        player function_a4a572d8d09b0f46();
        player setorigin( player.origin + ( 0, 0, 20 ) );
        impulsescale = 500 + var_f0b7174bef3b9406 * 600;
        impulsedirection = vectornormalize( var_36424711de9aaaa5 );
        player knockback( impulsedirection, impulsescale, 1 );
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0xcf97a79, Offset: 0x1c0f
// Size: 0x7c
function private function_348163df00acd739( trigger, ent )
{
    if ( !isdefined( trigger.var_e59ed3bd8a6a3176 ) )
    {
        trigger.var_e59ed3bd8a6a3176 = [];
    }
    
    entnum = utility::get_entity_number( ent );
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    if ( !arraycontains( trigger.var_e59ed3bd8a6a3176, entnum ) )
    {
        trigger.var_e59ed3bd8a6a3176[ trigger.var_e59ed3bd8a6a3176.size ] = entnum;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x74a50fa6, Offset: 0x1c93
// Size: 0x69
function private function_34cd62ca09e001bc( trigger, ent )
{
    if ( !isdefined( trigger.var_e59ed3bd8a6a3176 ) )
    {
        trigger.var_e59ed3bd8a6a3176 = [];
    }
    
    entnum = utility::get_entity_number( ent );
    
    if ( !isdefined( entnum ) )
    {
        return;
    }
    
    trigger.var_e59ed3bd8a6a3176 = arrayremove( trigger.var_e59ed3bd8a6a3176, entnum );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x9dc128a3, Offset: 0x1d04
// Size: 0x1c, Type: bool
function private function_49786ced3997725f( trigger )
{
    return trigger.var_e59ed3bd8a6a3176.size ?? 0;
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x41d67907, Offset: 0x1d29
// Size: 0xf4
function private function_ab337e4c7f76e817( trigger, ent )
{
    switch ( trigger.pickupinfo.var_7c3b92b7428f4a0d )
    {
        case 0:
            if ( trigger.pickupinfo.var_7c3b92b7428f4a0d == 0 )
            {
                function_348163df00acd739( trigger, ent );
            }
            
            trigger.pickupinfo.scriptable utility::function_32b24db3127bff40( trigger.pickupinfo.modelpart, #"active_hold" );
            break;
        case 1:
        default:
            trigger.pickupinfo.scriptable utility::function_32b24db3127bff40( trigger.pickupinfo.modelpart, #"active" );
            break;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x4777134, Offset: 0x1e25
// Size: 0xbb
function private function_296b86e4d5bab9ad( trigger, ent )
{
    switch ( trigger.pickupinfo.var_7c3b92b7428f4a0d )
    {
        case 0:
            function_34cd62ca09e001bc( trigger, ent );
            touchingcount = function_49786ced3997725f( trigger );
            
            if ( touchingcount == 0 )
            {
                trigger.pickupinfo.scriptable utility::function_32b24db3127bff40( trigger.pickupinfo.modelpart, #"idle" );
            }
            
            break;
        case 1:
        default:
            break;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0x612b0b51, Offset: 0x1ee8
// Size: 0x158
function private function_b3f0339fb0a4c7ac( var_b37d5221d1f6697a, trigger )
{
    if ( !trigger.pickupinfo )
    {
        assertmsg( "<dev string:x1b8>" );
        return;
    }
    
    function_ab337e4c7f76e817( trigger, var_b37d5221d1f6697a );
    targetplayer = function_47f57f55a7b21d59( var_b37d5221d1f6697a );
    
    if ( !targetplayer )
    {
        return;
    }
    
    if ( trigger.pickupinfo.ismotorcycle )
    {
        function_8e86fdaac3c0ddf6( targetplayer );
    }
    
    if ( trigger.pickupinfo.removemotorcycle )
    {
        function_a250bbf53925ba8f( targetplayer );
    }
    
    if ( trigger.pickupinfo.iswingsuit )
    {
        targetplayer notify( #"hash_2d24f0b2e15c3f12" );
        function_fab6ca1b33c459a1( targetplayer );
        return;
    }
    
    if ( trigger.pickupinfo.isequipment )
    {
        function_a0893f97810aa85b( targetplayer, trigger.pickupinfo.itemname );
        return;
    }
    
    customweapon = function_e3eeb7d2c1528535( trigger.pickupinfo.itemname );
    
    if ( customweapon )
    {
        giveweaponpickup( targetplayer, customweapon );
        return;
    }
    
    function_c9696336ee100d71( targetplayer, trigger.pickupinfo.itemname );
}

// Namespace namespace_c41f357b2d127aee
// Params 2, eflags: 0x4
// Checksum 0xdaaaa867, Offset: 0x2048
// Size: 0x3c
function private function_fece5436aeb3b032( var_b37d5221d1f6697a, trigger )
{
    if ( !trigger.pickupinfo )
    {
        assertmsg( "<dev string:x1b8>" );
        return;
    }
    
    function_296b86e4d5bab9ad( trigger, var_b37d5221d1f6697a );
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x9c63ab5e, Offset: 0x208c
// Size: 0x14f
function private function_e3eeb7d2c1528535( param )
{
    switch ( param )
    {
        case #"hash_900cb96c552c5e8e":
            weapon = game[ #"frune_tuning" ].smgloadout.weapons.weaponprimary;
            return weapon;
        case #"hash_fa18d2f6bd57925a":
            weapon = game[ #"frune_tuning" ].rifleloadout.weapons.weaponprimary;
            return weapon;
        case #"hash_23209741b93850b5":
            weapon = game[ #"frune_tuning" ].shotgunloadout.weapons.weaponprimary;
            return weapon;
        case #"hash_719417cb1de832b6":
            weapon = game[ #"frune_tuning" ].pistolloadout.weapons.weaponprimary;
            return weapon;
        case #"hash_8bee78c0cf0771d9":
            weapon = game[ #"frune_tuning" ].warmachineloadout.weapons.weaponprimary;
            return weapon;
        default:
            return;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0xc
// Checksum 0x1c20daab, Offset: 0x21e3
// Size: 0x64
function private function_24012f7ecccc24fa()
{
    self notify( #"hash_3f3a6c5f56984c3c" );
    self endon( #"hash_3f3a6c5f56984c3c" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    result = utility::waittill_any_timeout( 3, "frun_killzone_death" );
    
    if ( result == "frun_killzone_death" )
    {
        hud_message::function_c7ef9b0007b5092d();
        hud_message::function_cb764616620ad77();
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0x4
// Checksum 0xd7d95935, Offset: 0x224f
// Size: 0x33
function private function_f519d0f7cbdce61b()
{
    level endon( #"game_ended" );
    self setclientomnvar( "ui_free_run_show_item_equip", 1 );
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self setclientomnvar( "ui_free_run_show_item_equip", 0 );
}

// Namespace namespace_c41f357b2d127aee
// Params 0
// Checksum 0x62e4bd14, Offset: 0x228a
// Size: 0x13c
function function_3abb5b856fc03d10()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( self )
    {
        primaryweapons = self getweaponslistprimaries();
        
        foreach ( weapon in primaryweapons )
        {
            self givemaxammo( weapon );
            self setweaponammostock( weapon, weaponmaxammo( weapon ) );
        }
        
        itemweapons = self getweaponslistitems();
        
        foreach ( weapon in itemweapons )
        {
            self setweaponammoclip( weapon, weapon.clipsize );
            self cancelreload();
        }
        
        wait 1;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0xcd6c1116, Offset: 0x23ce
// Size: 0x51
function private function_a3ee9703ea9da3ee( player )
{
    if ( !player )
    {
        return;
    }
    
    if ( !player.current_weapon )
    {
        return;
    }
    
    player setweaponammoclip( player.current_weapon, player.current_weapon.clipsize );
    player cancelreload();
}

// Namespace namespace_c41f357b2d127aee
// Params 1
// Checksum 0xeecb586d, Offset: 0x2427
// Size: 0x97
function function_453dc4fee393c18c( player )
{
    if ( !player )
    {
        return;
    }
    
    equipmentname = player.freeruninfo.var_caed4acc269c7041.equipment.tactical;
    
    if ( !equipmentname )
    {
        return;
    }
    
    equipmentslot = level.equipment.table[ equipmentname ].defaultslot;
    player equipment_mp::takeequipment( equipmentslot );
    player equipment_mp::giveequipment( equipmentname, equipmentslot );
    player thread function_f519d0f7cbdce61b();
}

// Namespace namespace_c41f357b2d127aee
// Params 1, eflags: 0x4
// Checksum 0x2d4191e3, Offset: 0x24c6
// Size: 0xe4
function private function_90f530e92794426c( player )
{
    if ( !player )
    {
        return;
    }
    
    tactical = player.freeruninfo.var_caed4acc269c7041.equipment.tactical;
    
    if ( !tactical )
    {
        return;
    }
    
    hasequipment = player equipment_mp::hasequipment( tactical );
    
    if ( !hasequipment )
    {
        return;
    }
    
    player notify( "halt_ammo_increment_" + tactical );
    player.freeruninfo.var_7a42da03265f33d8 = 0;
    equipmentslot = level.equipment.table[ tactical ].defaultslot;
    weaponobj = player equipment_mp::function_65267b7e18646851( equipmentslot );
    stockmax = weaponmaxammo( weaponobj );
    player equipment_mp::setequipmentammo( tactical, stockmax );
}

// Namespace namespace_c41f357b2d127aee
// Params 1
// Checksum 0x58192619, Offset: 0x25b2
// Size: 0x16f
function function_35a441a1867a3b39( player )
{
    self notify( #"hash_f195044fb29e4207" );
    self endon( #"hash_f195044fb29e4207" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_aa4094dbfbb439f1 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player.freeruninfo.var_7a42da03265f33d8 ) )
    {
        player.freeruninfo.var_7a42da03265f33d8 = 0;
    }
    
    while ( player )
    {
        var_df13804dd2917a58 = equipment_mp::function_65267b7e18646851( "secondary" );
        
        if ( var_df13804dd2917a58 )
        {
            tacticalref = equipment_mp::function_fdc4a655fbde0dec( var_df13804dd2917a58.basenamehash );
            stockmax = weaponmaxammo( var_df13804dd2917a58 );
            ammo = player getammocount( var_df13804dd2917a58 );
            var_2abdee1d030e1d32 = ammo + player.freeruninfo.var_7a42da03265f33d8;
            
            if ( var_2abdee1d030e1d32 < stockmax )
            {
                player.freeruninfo.var_7a42da03265f33d8 += 1;
                player thread function_5c63162780da56c5( player, tacticalref, modeinfo.var_cdcc4702644fb40d, modeinfo.var_b6baa88473a824e1 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_c41f357b2d127aee
// Params 4, eflags: 0x4
// Checksum 0x6d56afdc, Offset: 0x2729
// Size: 0xae
function private function_5c63162780da56c5( player, equipmentref, delayseconds, incrementamount )
{
    player endon( "halt_ammo_increment_" + equipmentref );
    wait delayseconds;
    
    if ( !player.freeruninfo.var_7a42da03265f33d8 )
    {
        return;
    }
    
    player.freeruninfo.var_7a42da03265f33d8 -= 1;
    
    if ( !player equipment_mp::hasequipment( equipmentref ) )
    {
        return;
    }
    
    currammo = equipment_mp::getequipmentammo( equipmentref );
    player equipment_mp::setequipmentammo( equipmentref, currammo + incrementamount );
}

// Namespace namespace_c41f357b2d127aee
// Params 0, eflags: 0x4
// Checksum 0x3b3f4981, Offset: 0x27df
// Size: 0xe5f
function private function_af36cac9d0867dc5()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_d0140de3a3dd8bc0 = [];
    
    if ( !isdefined( modeinfo.var_42d571237e382000 ) )
    {
        modeinfo.var_42d571237e382000 = [];
    }
    
    var_b058c14dcdd7c9ce = weapon::buildweapon( "sat_pi_alcor_mp" );
    var_6667c234859a81d5 = [ function_2e5ecdd8ac47f308( var_b058c14dcdd7c9ce, "scope" )[ 3 ], function_2e5ecdd8ac47f308( var_b058c14dcdd7c9ce, "muzzle" )[ 3 ] ];
    var_b058c14dcdd7c9ce = var_b058c14dcdd7c9ce withattachments( var_6667c234859a81d5 );
    var_c0ebc28939e578d = weapon::buildweapon( "sat_sh_shepherd_mp" );
    var_3eeda5bffd1c68da = [ function_2e5ecdd8ac47f308( var_c0ebc28939e578d, "scope" )[ 3 ], function_2e5ecdd8ac47f308( var_c0ebc28939e578d, "frontpiece" )[ 2 ], function_2e5ecdd8ac47f308( var_c0ebc28939e578d, "magazine" )[ 2 ], function_2e5ecdd8ac47f308( var_c0ebc28939e578d, "reargrip" )[ 3 ], function_2e5ecdd8ac47f308( var_c0ebc28939e578d, "backpiece" )[ 3 ] ];
    var_c0ebc28939e578d = var_c0ebc28939e578d withattachments( var_3eeda5bffd1c68da );
    var_2fc221b953f49fa0 = weapon::buildweapon( "sat_sm_gecko_mp" );
    var_300c8e6b260b097b = [ function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "scope" )[ 3 ], function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "magazine" )[ 3 ], function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "reargrip" )[ 1 ], function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "underbarrel" )[ 4 ], function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "muzzle" )[ 2 ], function_2e5ecdd8ac47f308( var_2fc221b953f49fa0, "dynamic" )[ 3 ] ];
    var_2fc221b953f49fa0 = var_2fc221b953f49fa0 withattachments( var_300c8e6b260b097b );
    var_5c5d3505f7a5f49d = weapon::buildweapon( "sat_ar_macaw_mp" );
    var_3bd190ad4811346 = [ function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "scope" )[ 2 ], function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "magazine" )[ 1 ], function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "frontpiece" )[ 2 ], function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "reargrip" )[ 4 ], function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "backpiece" )[ 1 ], function_2e5ecdd8ac47f308( var_5c5d3505f7a5f49d, "conversionkit" )[ 2 ] ];
    var_5c5d3505f7a5f49d = var_5c5d3505f7a5f49d withattachments( var_3bd190ad4811346 );
    var_c2a3c27a7fa24c1a = weapon::buildweapon( "sat_ks_warmachine" );
    var_ab5195cdb98e80fd = weapon::buildweapon( "sat_sl_nembus" );
    grapplename = "equip_grappling_hook";
    weaponnone = { #weaponprimary:0 };
    weaponpistol = { #weaponprimary:var_b058c14dcdd7c9ce };
    weaponshotgun = { #weaponprimary:var_c0ebc28939e578d };
    weaponsmg = { #weaponprimary:var_2fc221b953f49fa0 };
    weaponrifle = { #weaponprimary:var_5c5d3505f7a5f49d };
    var_b383665c73a24c08 = { #weaponprimary:var_ab5195cdb98e80fd };
    weaponwarmachine = { #weaponprimary:var_c2a3c27a7fa24c1a };
    equipmentnone = { #motorcycle:0, #wingsuit:0, #lethal:0, #tactical:0 };
    equipmentgrapple = { #motorcycle:0, #wingsuit:0, #lethal:0, #tactical:grapplename };
    equipmentwingsuit = { #motorcycle:0, #wingsuit:1, #lethal:0, #tactical:0 };
    equipmentmotorcycle = { #motorcycle:1, #wingsuit:0, #lethal:0, #tactical:0 };
    empty = { #equipment:equipmentnone, #weapons:weaponnone, #debugname:#"empty" };
    modeinfo.pistolloadout = { #equipment:equipmentnone, #weapons:weaponpistol, #debugname:#"pistol" };
    modeinfo.shotgunloadout = { #equipment:equipmentnone, #weapons:weaponshotgun, #debugname:#"shotgun" };
    modeinfo.smgloadout = { #equipment:equipmentnone, #weapons:weaponsmg, #debugname:#"smg" };
    modeinfo.rifleloadout = { #equipment:equipmentnone, #weapons:weaponrifle, #debugname:#"rifle" };
    modeinfo.warmachineloadout = { #equipment:equipmentnone, #weapons:weaponwarmachine, #debugname:#"warmachine" };
    modeinfo.nembusloadout = { #equipment:equipmentnone, #weapons:var_b383665c73a24c08, #debugname:#"hash_33dfa2ca586996f9" };
    assaultriflegrapple = { #equipment:equipmentgrapple, #weapons:weaponrifle, #debugname:#"assaultriflegrapple" };
    smggrapple = { #equipment:equipmentgrapple, #weapons:weaponsmg, #debugname:#"smggrapple" };
    grapple = { #equipment:equipmentgrapple, #weapons:weaponnone, #debugname:#"grapple" };
    wingsuit = { #equipment:equipmentwingsuit, #weapons:weaponnone, #debugname:#"wingsuit" };
    motorcycle = { #equipment:equipmentmotorcycle, #weapons:weaponnone, #debugname:#"motorcycle" };
    modeinfo.emptyloadout = empty;
    function_364f0b9c79dbcd7d( 1, 1, empty );
    function_364f0b9c79dbcd7d( 1, 2, empty );
    function_364f0b9c79dbcd7d( 1, 3, empty );
    function_364f0b9c79dbcd7d( 1, 4, empty );
    function_364f0b9c79dbcd7d( 1, 5, empty );
    function_364f0b9c79dbcd7d( 1, 6, empty );
    function_364f0b9c79dbcd7d( 1, 7, empty );
    function_364f0b9c79dbcd7d( 1, 8, empty );
    function_364f0b9c79dbcd7d( 1, 9, empty );
    function_364f0b9c79dbcd7d( 1, 10, empty );
    function_364f0b9c79dbcd7d( 1, 11, empty );
    function_364f0b9c79dbcd7d( 1, 12, empty );
    function_364f0b9c79dbcd7d( 1, 13, empty );
    function_364f0b9c79dbcd7d( 1, 14, empty );
    function_364f0b9c79dbcd7d( 1, 15, empty );
    function_364f0b9c79dbcd7d( 1, 16, empty );
    function_364f0b9c79dbcd7d( 1, 17, wingsuit );
    function_364f0b9c79dbcd7d( 1, 18, wingsuit );
    function_364f0b9c79dbcd7d( 1, 19, empty );
    function_364f0b9c79dbcd7d( 2, 1, empty );
    function_364f0b9c79dbcd7d( 2, 2, empty );
    function_364f0b9c79dbcd7d( 2, 3, empty );
    function_364f0b9c79dbcd7d( 2, 4, empty );
    function_364f0b9c79dbcd7d( 2, 5, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 6, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 7, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 8, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 9, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 10, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 11, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 12, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 13, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 14, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 15, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 16, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 17, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 18, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 19, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 20, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 2, 21, wingsuit );
    function_364f0b9c79dbcd7d( 2, 22, wingsuit );
    function_364f0b9c79dbcd7d( 2, 23, wingsuit );
    function_364f0b9c79dbcd7d( 2, 24, empty );
    function_364f0b9c79dbcd7d( 3, 1, empty );
    function_364f0b9c79dbcd7d( 3, 2, grapple );
    function_364f0b9c79dbcd7d( 3, 3, grapple );
    function_364f0b9c79dbcd7d( 3, 4, grapple );
    function_364f0b9c79dbcd7d( 3, 5, grapple );
    function_364f0b9c79dbcd7d( 3, 6, grapple );
    function_364f0b9c79dbcd7d( 3, 7, grapple );
    function_364f0b9c79dbcd7d( 3, 8, grapple );
    function_364f0b9c79dbcd7d( 3, 9, grapple );
    function_364f0b9c79dbcd7d( 3, 10, grapple );
    function_364f0b9c79dbcd7d( 3, 11, grapple );
    function_364f0b9c79dbcd7d( 3, 12, grapple );
    function_364f0b9c79dbcd7d( 3, 13, grapple );
    function_364f0b9c79dbcd7d( 3, 14, grapple );
    function_364f0b9c79dbcd7d( 3, 15, grapple );
    function_364f0b9c79dbcd7d( 3, 16, wingsuit );
    function_364f0b9c79dbcd7d( 3, 17, wingsuit );
    function_364f0b9c79dbcd7d( 3, 18, wingsuit );
    function_364f0b9c79dbcd7d( 3, 19, empty );
    function_364f0b9c79dbcd7d( 4, 1, empty );
    function_364f0b9c79dbcd7d( 4, 2, empty );
    function_364f0b9c79dbcd7d( 4, 3, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 4, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 5, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 6, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 7, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 8, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 9, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 10, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 11, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 12, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 13, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 14, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 15, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 16, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 4, 17, empty );
    function_364f0b9c79dbcd7d( 4, 18, wingsuit );
    function_364f0b9c79dbcd7d( 4, 19, wingsuit );
    function_364f0b9c79dbcd7d( 4, 20, wingsuit );
    function_364f0b9c79dbcd7d( 4, 21, empty );
    function_364f0b9c79dbcd7d( 5, 1, empty );
    function_364f0b9c79dbcd7d( 5, 2, empty );
    function_364f0b9c79dbcd7d( 5, 3, empty );
    function_364f0b9c79dbcd7d( 5, 4, empty );
    function_364f0b9c79dbcd7d( 5, 5, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 5, 6, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 5, 7, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 5, 8, smggrapple );
    function_364f0b9c79dbcd7d( 5, 9, smggrapple );
    function_364f0b9c79dbcd7d( 5, 10, smggrapple );
    function_364f0b9c79dbcd7d( 5, 11, smggrapple );
    function_364f0b9c79dbcd7d( 5, 12, smggrapple );
    function_364f0b9c79dbcd7d( 5, 13, smggrapple );
    function_364f0b9c79dbcd7d( 5, 14, smggrapple );
    function_364f0b9c79dbcd7d( 5, 15, wingsuit );
    function_364f0b9c79dbcd7d( 5, 16, wingsuit );
    function_364f0b9c79dbcd7d( 5, 17, wingsuit );
    function_364f0b9c79dbcd7d( 5, 18, wingsuit );
    function_364f0b9c79dbcd7d( 5, 19, empty );
    function_364f0b9c79dbcd7d( 6, 1, empty );
    function_364f0b9c79dbcd7d( 6, 2, empty );
    function_364f0b9c79dbcd7d( 6, 3, empty );
    function_364f0b9c79dbcd7d( 6, 4, modeinfo.shotgunloadout );
    function_364f0b9c79dbcd7d( 6, 5, modeinfo.shotgunloadout );
    function_364f0b9c79dbcd7d( 6, 6, modeinfo.shotgunloadout );
    function_364f0b9c79dbcd7d( 6, 7, modeinfo.shotgunloadout );
    function_364f0b9c79dbcd7d( 6, 8, modeinfo.shotgunloadout );
    function_364f0b9c79dbcd7d( 6, 9, empty );
    function_364f0b9c79dbcd7d( 6, 10, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 11, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 12, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 13, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 14, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 15, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 16, modeinfo.warmachineloadout );
    function_364f0b9c79dbcd7d( 6, 17, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 6, 18, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 6, 19, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 6, 20, modeinfo.smgloadout );
    function_364f0b9c79dbcd7d( 6, 21, empty );
    function_364f0b9c79dbcd7d( 7, 1, empty );
}

/#

    // Namespace namespace_c41f357b2d127aee
    // Params 2, eflags: 0x4
    // Checksum 0x8699b0c1, Offset: 0x3646
    // Size: 0x43, Type: dev
    function private function_ee76c11f06780c35( host, args )
    {
        player = frune_free_run_evo::function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player function_8e86fdaac3c0ddf6( player );
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 2, eflags: 0x4
    // Checksum 0x9cc0cf51, Offset: 0x3691
    // Size: 0x43, Type: dev
    function private function_f2dc1a1a59e6ca5c( host, args )
    {
        player = frune_free_run_evo::function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player function_a250bbf53925ba8f( player );
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 2, eflags: 0x4
    // Checksum 0x6bc66c90, Offset: 0x36dc
    // Size: 0x95, Type: dev
    function private function_20e56e4583dc6f39( host, args )
    {
        player = frune_free_run_evo::function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player.freeruninfo.var_2da2754256feb51b = !player.freeruninfo.var_2da2754256feb51b;
        iprintlnbold( "<dev string:x1f2>" + ( player.freeruninfo.var_2da2754256feb51b ? "<dev string:x200>" : "<dev string:x208>" ) );
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 2, eflags: 0x4
    // Checksum 0x2422d525, Offset: 0x3779
    // Size: 0x5a, Type: dev
    function private function_79ce3097593244a9( host, args )
    {
        modeinfo = game[ #"frune_tuning" ];
        modeinfo.grenadedebugenabled = !modeinfo.grenadedebugenabled;
        level thread function_ce514dc9203b7043( modeinfo.grenadedebugenabled );
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 1, eflags: 0xc
    // Checksum 0x5f067952, Offset: 0x37db
    // Size: 0xe2, Type: dev
    function private function_ce514dc9203b7043( enabled )
    {
        self notify( #"hash_6d272a28d3172316" );
        self endon( #"hash_6d272a28d3172316" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
        while ( true )
        {
            foreach ( spot in modeinfo.var_7ff75fa6d306a5f7.grenadespots )
            {
                sphere( spot, 275, ( 1, 0.5, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 2, eflags: 0x4
    // Checksum 0xd4318b87, Offset: 0x38c5
    // Size: 0x5a, Type: dev
    function private function_73c02a986e15c740( host, args )
    {
        modeinfo = game[ #"frune_tuning" ];
        modeinfo.var_bac503e24d8f8844 = !modeinfo.var_bac503e24d8f8844;
        level thread function_a9c02626fff980a4( modeinfo.var_bac503e24d8f8844 );
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 1, eflags: 0xc
    // Checksum 0x656df61f, Offset: 0x3927
    // Size: 0x61, Type: dev
    function private function_a9c02626fff980a4( enabled )
    {
        self notify( #"hash_875b6d9afc8bea7" );
        self endon( #"hash_875b6d9afc8bea7" );
        
        if ( !enabled )
        {
            return;
        }
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            function_2921875b18149d44( player );
            waitframe();
        }
    }

    // Namespace namespace_c41f357b2d127aee
    // Params 1, eflags: 0x4
    // Checksum 0x7dbc901f, Offset: 0x3990
    // Size: 0x3e3, Type: dev
    function private function_2921875b18149d44( player )
    {
        loadout = player.freeruninfo.var_caed4acc269c7041;
        
        if ( !loadout )
        {
            printtoscreen2d( 75, 400, "<dev string:x211>", ( 0.75, 0.75, 0.75 ), 2 );
            return;
        }
        
        heightoffset = 400;
        printtoscreen2d( 75, heightoffset, "<dev string:x220>" + getxhashsourcename( loadout.debugname ), ( 1, 1, 0 ), 2 );
        primaryweaponname = player.current_weapon ? weapon::getweaponname( player.current_weapon ) : "<dev string:x22b>";
        var_b61b926b00be17db = ( 0.75, 0.75, 0.75 );
        
        if ( player.current_weapon )
        {
            var_b61b926b00be17db = player.current_weapon === loadout.weapons.weaponprimary ? ( 0, 1, 0 ) : ( 1, 0.5, 0 );
        }
        
        heightoffset += 40;
        printtoscreen2d( 75, heightoffset, "<dev string:x230>" + primaryweaponname, var_b61b926b00be17db, 2 );
        wingsuitactual = player.freeruninfo.wingsuitequipped;
        wingsuitcolor = ( 0.75, 0.75, 0.75 );
        
        if ( wingsuitactual != loadout.equipment.wingsuit )
        {
            wingsuitcolor = ( 1, 0.5, 0 );
        }
        else if ( wingsuitactual )
        {
            wingsuitcolor = ( 0, 1, 0 );
        }
        
        heightoffset += 40;
        printtoscreen2d( 75, heightoffset, "<dev string:x23a>" + ( wingsuitactual ? "<dev string:x245>" : "<dev string:x24a>" ), wingsuitcolor, 2 );
        tacticalactual = player equipment_mp::getcurrentequipment( "<dev string:x250>" );
        tacticalname = tacticalactual ? tacticalactual : "<dev string:x22b>";
        tacticalcolor = ( 0.75, 0.75, 0.75 );
        
        if ( tacticalactual )
        {
            tacticalcolor = tacticalactual === loadout.equipment.tactical ? ( 0, 1, 0 ) : ( 1, 0.5, 0 );
        }
        
        heightoffset += 40;
        printtoscreen2d( 75, heightoffset, "<dev string:x25a>" + tacticalname, tacticalcolor, 2 );
        lethalactual = player equipment_mp::getcurrentequipment( "<dev string:x265>" );
        lethalname = lethalactual ? lethalactual : "<dev string:x22b>";
        lethalcolor = ( 0.75, 0.75, 0.75 );
        
        if ( lethalactual )
        {
            lethalcolor = lethalactual === loadout.equipment.lethal ? ( 0, 1, 0 ) : ( 1, 0.5, 0 );
        }
        
        heightoffset += 40;
        printtoscreen2d( 75, heightoffset, "<dev string:x26d>" + lethalname, lethalcolor, 2 );
        motorcycleactual = player.freeruninfo.motorcycleequipped;
        motorcyclecolor = ( 0.75, 0.75, 0.75 );
        
        if ( motorcycleactual != loadout.equipment.motorcycle )
        {
            motorcyclecolor = ( 1, 0.5, 0 );
        }
        else if ( motorcycleactual )
        {
            motorcyclecolor = ( 0, 1, 0 );
        }
        
        heightoffset += 40;
        printtoscreen2d( 75, heightoffset, "<dev string:x276>" + ( motorcycleactual ? "<dev string:x245>" : "<dev string:x24a>" ), motorcyclecolor, 2 );
    }

#/
