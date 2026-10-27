// script_2be31009a4044baf  (hash_2be31009a4044baf.gscc) (size: 13047 Bytes / 0x32f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe39ee1a4 (3818840484)
// size ...... 13047 (0x32f7)
// includes .. 11  (offset: 0x309b)
// strings ... 36  (offset: 0x30f3)
// dev strs .. 4   (offset: 0x32c7)
// exports ... 29  (offset: 0x211f)
// cseg ...... 0x3a4 + 0x1d7b (0x211f)
// imports ... 75  (offset: 0x25a7)
// animtree1 . 0   (offset: 0x32f7)
// animtree2 . 0   (offset: 0x32f7)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\frun_free_run;
#using scripts\mp\hud_message;
#using scripts\mp\parachute;

#namespace namespace_e36fb96d2958d7cd;

// Namespace namespace_e36fb96d2958d7cd
// Params 0
// Checksum 0xafeb5fb6, Offset: 0x3c2
// Size: 0x270
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "equipment_initialized" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.frun_bundle ) )
    {
        modeinfo.frun_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frun" );
    }
    
    modeinfo.var_ead9a471818e10f8 = getdvarint( @"hash_a24fea534ad598c1", modeinfo.frun_bundle.var_ecb66d17a43fd66c ?? 1 );
    parachute::initparachutedvars();
    function_af36cac9d0867dc5();
    pickuplist = getentarray( "pickup", "script_noteworthy" );
    
    foreach ( pickup in pickuplist )
    {
        iswingsuit = pickup.script_label == "wingsuit";
        isequipment = equipment_mp::isequipment( pickup.script_label );
        var_e99eaef8842a6200 = utility::getstruct( pickup.target, "targetname" );
        groundresult = function_dd0db1ba44ccf570( var_e99eaef8842a6200.origin, var_e99eaef8842a6200.angles );
        scriptable = spawnscriptable( "mp_sat_freerun_pickup", groundresult.position, groundresult.angles );
        modelpart = function_18afec90da10540e( pickup.script_parameters );
        pickup.pickupinfo = { #itemname:pickup.script_label ?? "", #isequipment:isequipment, #iswingsuit:iswingsuit, #modelpart:modelpart, #scriptable:scriptable, #pickupentity:pickup };
        scriptable utility::function_32b24db3127bff40( modelpart, #"idle" );
        function_39452db4a26a0b01( pickup.pickupinfo );
        trigger::makeenterexittrigger( pickup, &function_b3f0339fb0a4c7ac );
    }
    
    level notify( #"hash_f75c923c050b621d" );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 2, eflags: 0x4
// Checksum 0xe60075da, Offset: 0x63a
// Size: 0xd4
function private function_dd0db1ba44ccf570( position, angles )
{
    endposition = position + ( 0, 0, -50 );
    contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water" ] );
    result = trace::ray_trace( position, endposition, undefined, contents );
    
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
    
    return { #angles:groundangles, #position:groundposition };
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0xc874afab, Offset: 0x717
// Size: 0xf9
function private function_18afec90da10540e( params )
{
    if ( !params )
    {
        return #"pistol";
    }
    
    switch ( params )
    {
        case #"hash_8188d7d9ca79f635":
            return #"wingsuit";
        case #"hash_16cd760e0326c848":
            return #"pistol";
        case #"hash_51a4f48532822a9c":
            return #"ar";
        case #"hash_cc0002dee5de3520":
            return #"smg";
        case #"hash_b487f80c4a23b46b":
            return #"shotgun";
        case #"hash_45367d77feb5acc7":
            return #"ballisticknife";
        case #"hash_8a4886e4eef091b6":
            return #"grapple";
        case #"hash_ee7e29433727e9d9":
            return #"grapple_nobase";
        default:
            assertmsg( "<dev string:x24>" );
            return #"pistol";
    }
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0x7b2596d3, Offset: 0x818
// Size: 0x54
function private function_39452db4a26a0b01( pickupinfo )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.pickuplist ) )
    {
        modeinfo.pickuplist = [];
    }
    
    modeinfo.pickuplist[ modeinfo.pickuplist.size ] = pickupinfo;
}

// Namespace namespace_e36fb96d2958d7cd
// Params 2
// Checksum 0x92ffd0a0, Offset: 0x874
// Size: 0x6f
function function_1801310b8744ec73( zoneindex, checkpointindex )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ] )
    {
        return modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ];
    }
    
    assertmsg( "<dev string:x46>" + zoneindex + "<dev string:x6a>" + checkpointindex );
    return modeinfo.emptyloadout;
}

// Namespace namespace_e36fb96d2958d7cd
// Params 3, eflags: 0x4
// Checksum 0xd9fa8fb2, Offset: 0x8ec
// Size: 0x63
function private function_364f0b9c79dbcd7d( zoneindex, checkpointindex, loadout )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.var_d0140de3a3dd8bc0[ zoneindex ] ) )
    {
        modeinfo.var_d0140de3a3dd8bc0[ zoneindex ] = [];
    }
    
    modeinfo.var_d0140de3a3dd8bc0[ zoneindex ][ checkpointindex ] = loadout;
}

// Namespace namespace_e36fb96d2958d7cd
// Params 2
// Checksum 0xa1a071e4, Offset: 0x957
// Size: 0x108
function function_b90bc384cbf8537a( player, currentloadout )
{
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
        return;
    }
    
    function_4041d647f84d8284( player );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1
// Checksum 0xc04569d, Offset: 0xa67
// Size: 0x27
function function_b51d5e13aaac51cf( player )
{
    function_453dc4fee393c18c( player );
    function_90f530e92794426c( player );
    function_a3ee9703ea9da3ee( player );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 2, eflags: 0x4
// Checksum 0x46014953, Offset: 0xa96
// Size: 0x81
function private function_c9696336ee100d71( player, weaponname )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace namespace_e36fb96d2958d7cd
// Params 2, eflags: 0x4
// Checksum 0x55876e50, Offset: 0xb1f
// Size: 0x96
function private giveweaponpickup( player, weapon )
{
    if ( player.current_weapon && player.current_weapon != weapon )
    {
        player takeweapon( player.current_weapon );
    }
    
    if ( !player hasweapon( weapon ) )
    {
        player utility::function_32b24db3127bff40( #"frun_equipment_pickup_weapon", #"on" );
        player giveweapon( weapon );
        player inventory_utility::_switchtoweaponimmediate( weapon );
        player.current_weapon = weapon;
        player thread function_f519d0f7cbdce61b();
    }
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0x3b172ded, Offset: 0xbbd
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

// Namespace namespace_e36fb96d2958d7cd
// Params 2, eflags: 0x4
// Checksum 0x7e8896f2, Offset: 0xc1f
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
    
    player utility::function_32b24db3127bff40( #"frun_equipment_pickup_grapple", #"on" );
    equipmentslot = level.equipment.table[ equipmentname ].defaultslot;
    player equipment_mp::giveequipment( equipmentname, equipmentslot );
    player thread function_f519d0f7cbdce61b();
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0x66424f3, Offset: 0xce0
// Size: 0x1a
function private function_fdded9a4f276c824( player )
{
    player equipment_mp::takeequipment( "primary" );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0xbade866a, Offset: 0xd02
// Size: 0x1a
function private function_ebc318f881f86d1b( player )
{
    player equipment_mp::takeequipment( "secondary" );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0xc09b675e, Offset: 0xd24
// Size: 0x2d
function private function_26ebb630b1b2ed88( params )
{
    if ( isplayer( self ) )
    {
        self.operatorcustomization.suit = "sat_wingsuit_mp_frun";
    }
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1
// Checksum 0x8c1a7504, Offset: 0xd59
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
        
        if ( player.suit == "sat_wingsuit_mp_frun" )
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
        
        if ( player.suit == "sat_wingsuit_mp_frun" )
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

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0x51b5d76d, Offset: 0xe77
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
    player utility::function_32b24db3127bff40( #"frun_equipment_pickup_wingsuit", #"on" );
    player.suit = "sat_wingsuit_mp_frun";
    player.operatorcustomization.suit = "sat_wingsuit_mp_frun";
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0x50487a4a, Offset: 0xf2a
// Size: 0x6e
function private function_12d19bf2de37e954( player )
{
    player.freeruninfo.wingsuitequipped = 0;
    player.redeployenabled = 0;
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_ead9a471818e10f8 )
    {
        player skydive_end();
    }
    
    player function_197ef48187159d23();
    player skydive_setdeploymentstatus( 0 );
    player skydive_setbasejumpingstatus( 0 );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 2, eflags: 0x4
// Checksum 0xbc170d31, Offset: 0xfa0
// Size: 0x10a
function private function_b3f0339fb0a4c7ac( var_b37d5221d1f6697a, trigger )
{
    if ( !isplayer( var_b37d5221d1f6697a ) || !isalive( var_b37d5221d1f6697a ) )
    {
        return;
    }
    
    if ( !trigger.pickupinfo )
    {
        assertmsg( "<dev string:x78>" );
        return;
    }
    
    trigger.pickupinfo.scriptable utility::function_32b24db3127bff40( trigger.pickupinfo.modelpart, #"active" );
    
    if ( trigger.pickupinfo.iswingsuit )
    {
        var_b37d5221d1f6697a notify( #"hash_2d24f0b2e15c3f12" );
        function_fab6ca1b33c459a1( var_b37d5221d1f6697a );
        return;
    }
    
    if ( trigger.pickupinfo.isequipment )
    {
        function_a0893f97810aa85b( var_b37d5221d1f6697a, trigger.pickupinfo.itemname );
        return;
    }
    
    function_c9696336ee100d71( var_b37d5221d1f6697a, trigger.pickupinfo.itemname );
}

// Namespace namespace_e36fb96d2958d7cd
// Params 0, eflags: 0xc
// Checksum 0x186a7788, Offset: 0x10b2
// Size: 0x64
function private function_24012f7ecccc24fa()
{
    self notify( #"hash_1942a035708a047e" );
    self endon( #"hash_1942a035708a047e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    result = utility::waittill_any_timeout( 3, "frun_killzone_death" );
    
    if ( result == "frun_killzone_death" )
    {
        hud_message::function_c7ef9b0007b5092d();
        hud_message::function_cb764616620ad77();
    }
}

// Namespace namespace_e36fb96d2958d7cd
// Params 0, eflags: 0x4
// Checksum 0xd393f416, Offset: 0x111e
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

// Namespace namespace_e36fb96d2958d7cd
// Params 0
// Checksum 0xb01e72a2, Offset: 0x1159
// Size: 0xb5
function function_3abb5b856fc03d10()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( self )
    {
        var_3df86f0b126863ab = self getweaponslistprimaries();
        
        foreach ( weapon in var_3df86f0b126863ab )
        {
            self givemaxammo( weapon );
            self setweaponammostock( weapon, weaponmaxammo( weapon ) );
        }
        
        wait 1;
    }
}

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0xc926bc35, Offset: 0x1216
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

// Namespace namespace_e36fb96d2958d7cd
// Params 1
// Checksum 0x777f5032, Offset: 0x126f
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

// Namespace namespace_e36fb96d2958d7cd
// Params 1, eflags: 0x4
// Checksum 0xb4f599bc, Offset: 0x130e
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

// Namespace namespace_e36fb96d2958d7cd
// Params 1
// Checksum 0xc39a1937, Offset: 0x13fa
// Size: 0x16a
function function_35a441a1867a3b39( player )
{
    self notify( #"hash_c34f0a1fa606d793" );
    self endon( #"hash_c34f0a1fa606d793" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace namespace_e36fb96d2958d7cd
// Params 4, eflags: 0x4
// Checksum 0x691c02ff, Offset: 0x156c
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

// Namespace namespace_e36fb96d2958d7cd
// Params 0, eflags: 0x4
// Checksum 0x90c759b8, Offset: 0x1622
// Size: 0xafd
function private function_af36cac9d0867dc5()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.var_42d571237e382000 ) )
    {
        modeinfo.var_42d571237e382000 = [];
    }
    
    var_a0271e100a3c0bcc = weapon::buildweapon( "sat_pi_orion_mp" );
    var_2e846b5d576006e3 = weapon::buildweapon( "sat_pi_atlas_mp" );
    var_b058c14dcdd7c9ce = weapon::buildweapon( "sat_pi_timir_mp" );
    var_e32432bad14200ac = weapon::buildweapon( "sat_me_ballisticknife" );
    var_c0ebc28939e578d = weapon::buildweapon( "sat_sh_akita_mp" );
    var_2fc221b953f49fa0 = weapon::buildweapon( "sat_sm_zebra_mp" );
    var_5c5d3505f7a5f49d = weapon::buildweapon( "sat_ar_condor_mp" );
    grapplename = "equip_grappling_hook";
    weaponnone = { #weaponprimary:0 };
    var_e09cb946e0cb85bb = { #weaponprimary:var_a0271e100a3c0bcc };
    var_a97f7e3860d786ba = { #weaponprimary:var_2e846b5d576006e3 };
    weaponpistol = { #weaponprimary:var_b058c14dcdd7c9ce };
    weaponknife = { #weaponprimary:var_e32432bad14200ac };
    weaponshotgun = { #weaponprimary:var_c0ebc28939e578d };
    weaponsmg = { #weaponprimary:var_2fc221b953f49fa0 };
    weaponrifle = { #weaponprimary:var_5c5d3505f7a5f49d };
    equipmentnone = { #wingsuit:0, #lethal:0, #tactical:0 };
    equipmentgrapple = { #wingsuit:0, #lethal:0, #tactical:grapplename };
    equipmentwingsuit = { #wingsuit:1, #lethal:0, #tactical:0 };
    empty = { #equipment:equipmentnone, #weapons:weaponnone, #debugname:#"empty" };
    burstpistol = { #equipment:equipmentnone, #weapons:var_e09cb946e0cb85bb, #debugname:#"burstpistol" };
    autopistol = { #equipment:equipmentnone, #weapons:var_a97f7e3860d786ba, #debugname:#"autopistol" };
    pistol = { #equipment:equipmentnone, #weapons:weaponpistol, #debugname:#"pistol" };
    knife = { #equipment:equipmentnone, #weapons:weaponknife, #debugname:#"knife" };
    shotgun = { #equipment:equipmentnone, #weapons:weaponshotgun, #debugname:#"shotgun" };
    smg = { #equipment:equipmentnone, #weapons:weaponsmg, #debugname:#"smg" };
    rifle = { #equipment:equipmentnone, #weapons:weaponrifle, #debugname:#"rifle" };
    assaultriflegrapple = { #equipment:equipmentgrapple, #weapons:weaponrifle, #debugname:#"assaultriflegrapple" };
    grapple = { #equipment:equipmentgrapple, #weapons:weaponnone, #debugname:#"grapple" };
    wingsuit = { #equipment:equipmentwingsuit, #weapons:weaponnone, #debugname:#"wingsuit" };
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
    function_364f0b9c79dbcd7d( 2, 1, empty );
    function_364f0b9c79dbcd7d( 2, 2, empty );
    function_364f0b9c79dbcd7d( 2, 3, empty );
    function_364f0b9c79dbcd7d( 2, 4, empty );
    function_364f0b9c79dbcd7d( 2, 5, empty );
    function_364f0b9c79dbcd7d( 2, 6, empty );
    function_364f0b9c79dbcd7d( 2, 7, empty );
    function_364f0b9c79dbcd7d( 2, 8, empty );
    function_364f0b9c79dbcd7d( 2, 9, empty );
    function_364f0b9c79dbcd7d( 2, 10, empty );
    function_364f0b9c79dbcd7d( 2, 11, empty );
    function_364f0b9c79dbcd7d( 2, 12, empty );
    function_364f0b9c79dbcd7d( 2, 13, empty );
    function_364f0b9c79dbcd7d( 2, 14, empty );
    function_364f0b9c79dbcd7d( 3, 1, empty );
    function_364f0b9c79dbcd7d( 3, 2, autopistol );
    function_364f0b9c79dbcd7d( 3, 3, autopistol );
    function_364f0b9c79dbcd7d( 3, 4, autopistol );
    function_364f0b9c79dbcd7d( 3, 5, autopistol );
    function_364f0b9c79dbcd7d( 3, 6, autopistol );
    function_364f0b9c79dbcd7d( 3, 7, autopistol );
    function_364f0b9c79dbcd7d( 3, 8, autopistol );
    function_364f0b9c79dbcd7d( 3, 9, autopistol );
    function_364f0b9c79dbcd7d( 3, 10, autopistol );
    function_364f0b9c79dbcd7d( 3, 11, autopistol );
    function_364f0b9c79dbcd7d( 4, 1, empty );
    function_364f0b9c79dbcd7d( 4, 2, empty );
    function_364f0b9c79dbcd7d( 4, 3, empty );
    function_364f0b9c79dbcd7d( 4, 4, empty );
    function_364f0b9c79dbcd7d( 4, 5, empty );
    function_364f0b9c79dbcd7d( 4, 6, smg );
    function_364f0b9c79dbcd7d( 4, 7, smg );
    function_364f0b9c79dbcd7d( 4, 8, smg );
    function_364f0b9c79dbcd7d( 4, 9, smg );
    function_364f0b9c79dbcd7d( 4, 10, smg );
    function_364f0b9c79dbcd7d( 4, 11, smg );
    function_364f0b9c79dbcd7d( 4, 12, smg );
    function_364f0b9c79dbcd7d( 4, 13, smg );
    function_364f0b9c79dbcd7d( 4, 14, smg );
    function_364f0b9c79dbcd7d( 4, 15, smg );
    function_364f0b9c79dbcd7d( 4, 16, smg );
    function_364f0b9c79dbcd7d( 5, 1, empty );
    function_364f0b9c79dbcd7d( 5, 2, grapple );
    function_364f0b9c79dbcd7d( 5, 3, grapple );
    function_364f0b9c79dbcd7d( 5, 4, grapple );
    function_364f0b9c79dbcd7d( 5, 5, grapple );
    function_364f0b9c79dbcd7d( 5, 6, grapple );
    function_364f0b9c79dbcd7d( 5, 7, grapple );
    function_364f0b9c79dbcd7d( 5, 8, grapple );
    function_364f0b9c79dbcd7d( 6, 1, grapple );
    function_364f0b9c79dbcd7d( 6, 2, grapple );
    function_364f0b9c79dbcd7d( 6, 3, grapple );
    function_364f0b9c79dbcd7d( 6, 4, grapple );
    function_364f0b9c79dbcd7d( 6, 5, grapple );
    function_364f0b9c79dbcd7d( 6, 6, grapple );
    function_364f0b9c79dbcd7d( 6, 7, grapple );
    function_364f0b9c79dbcd7d( 6, 8, grapple );
    function_364f0b9c79dbcd7d( 6, 9, grapple );
    function_364f0b9c79dbcd7d( 6, 10, grapple );
    function_364f0b9c79dbcd7d( 6, 11, grapple );
    function_364f0b9c79dbcd7d( 6, 12, grapple );
    function_364f0b9c79dbcd7d( 6, 13, empty );
    function_364f0b9c79dbcd7d( 7, 1, empty );
    function_364f0b9c79dbcd7d( 7, 2, shotgun );
    function_364f0b9c79dbcd7d( 7, 3, shotgun );
    function_364f0b9c79dbcd7d( 7, 4, shotgun );
    function_364f0b9c79dbcd7d( 7, 5, shotgun );
    function_364f0b9c79dbcd7d( 7, 6, shotgun );
    function_364f0b9c79dbcd7d( 7, 7, shotgun );
    function_364f0b9c79dbcd7d( 7, 8, shotgun );
    function_364f0b9c79dbcd7d( 7, 9, shotgun );
    function_364f0b9c79dbcd7d( 7, 10, shotgun );
    function_364f0b9c79dbcd7d( 7, 11, shotgun );
    function_364f0b9c79dbcd7d( 7, 12, shotgun );
    function_364f0b9c79dbcd7d( 7, 13, shotgun );
    function_364f0b9c79dbcd7d( 7, 14, shotgun );
    function_364f0b9c79dbcd7d( 7, 15, shotgun );
    function_364f0b9c79dbcd7d( 7, 16, shotgun );
    function_364f0b9c79dbcd7d( 8, 1, empty );
    function_364f0b9c79dbcd7d( 8, 2, rifle );
    function_364f0b9c79dbcd7d( 8, 3, rifle );
    function_364f0b9c79dbcd7d( 8, 4, rifle );
    function_364f0b9c79dbcd7d( 8, 5, rifle );
    function_364f0b9c79dbcd7d( 8, 6, rifle );
    function_364f0b9c79dbcd7d( 8, 7, rifle );
    function_364f0b9c79dbcd7d( 8, 8, rifle );
    function_364f0b9c79dbcd7d( 8, 9, assaultriflegrapple );
    function_364f0b9c79dbcd7d( 8, 10, assaultriflegrapple );
    function_364f0b9c79dbcd7d( 8, 11, assaultriflegrapple );
    function_364f0b9c79dbcd7d( 8, 12, assaultriflegrapple );
    function_364f0b9c79dbcd7d( 9, 1, empty );
    function_364f0b9c79dbcd7d( 9, 2, pistol );
    function_364f0b9c79dbcd7d( 9, 3, knife );
    function_364f0b9c79dbcd7d( 9, 4, pistol );
    function_364f0b9c79dbcd7d( 9, 5, pistol );
    function_364f0b9c79dbcd7d( 9, 6, pistol );
    function_364f0b9c79dbcd7d( 9, 7, pistol );
    function_364f0b9c79dbcd7d( 9, 8, pistol );
    function_364f0b9c79dbcd7d( 9, 9, pistol );
    function_364f0b9c79dbcd7d( 9, 10, pistol );
    function_364f0b9c79dbcd7d( 9, 11, autopistol );
    function_364f0b9c79dbcd7d( 9, 12, shotgun );
    function_364f0b9c79dbcd7d( 9, 13, rifle );
    function_364f0b9c79dbcd7d( 9, 14, empty );
    function_364f0b9c79dbcd7d( 9, 15, rifle );
    function_364f0b9c79dbcd7d( 9, 16, burstpistol );
    function_364f0b9c79dbcd7d( 9, 17, empty );
    function_364f0b9c79dbcd7d( 10, 1, empty );
    function_364f0b9c79dbcd7d( 10, 2, wingsuit );
    function_364f0b9c79dbcd7d( 10, 3, wingsuit );
    function_364f0b9c79dbcd7d( 10, 4, wingsuit );
    function_364f0b9c79dbcd7d( 10, 5, wingsuit );
    function_364f0b9c79dbcd7d( 10, 6, wingsuit );
    function_364f0b9c79dbcd7d( 10, 7, wingsuit );
    function_364f0b9c79dbcd7d( 10, 8, wingsuit );
    function_364f0b9c79dbcd7d( 10, 9, wingsuit );
    function_364f0b9c79dbcd7d( 10, 10, empty );
    function_364f0b9c79dbcd7d( 10, 11, empty );
    function_364f0b9c79dbcd7d( 11, 1, empty );
}

