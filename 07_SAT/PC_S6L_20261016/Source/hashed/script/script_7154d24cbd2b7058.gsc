// script_7154d24cbd2b7058  (hash_7154d24cbd2b7058.gscc) (size: 15168 Bytes / 0x3b40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12606671 (308307569)
// size ...... 15168 (0x3b40)
// includes .. 15  (offset: 0x36a8)
// strings ... 39  (offset: 0x3720)
// dev strs .. 35  (offset: 0x398c)
// exports ... 39  (offset: 0x22c4)
// cseg ...... 0x34e + 0x1f76 (0x22c4)
// imports ... 109 (offset: 0x28dc)
// animtree1 . 0   (offset: 0x3b40)
// animtree2 . 0   (offset: 0x3b40)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;

#namespace namespace_a58c83961abd2620;

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x5
// Checksum 0x305a9dfa, Offset: 0x36c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_jackalope_haunt", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_a58c83961abd2620
// Params 0
// Checksum 0x64c55ed7, Offset: 0x395
// Size: 0x5e
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_init:&on_init, #name:"mtc_jackalope_haunt" };
    br_map_quest::register( quest );
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x97c9cce1, Offset: 0x3fb
// Size: 0x28
function private on_init()
{
    setup_variables();
    function_1a00a5a2ba836d4d();
    function_970d564ac5226b2e();
    setup_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0xe515b863, Offset: 0x42b
// Size: 0x2
function private on_prematch_end()
{
    
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0xd8c87508, Offset: 0x435
// Size: 0x139
function private on_infil()
{
    level.jackalope.pickup_jackalope = spawn_quest_item( level.jackalope.pickup_jackalope, %"hash_61f1ca4da2d524df" );
    level.jackalope.pickup_carrot = spawn_quest_item( level.jackalope.pickup_carrot, %"hash_24acca94aac47297" );
    level.jackalope.cauldron setscriptablepartstate( "cauldron_interact", "usable" );
    
    foreach ( molotov in level.jackalope.molotovs )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( molotov.origin );
        molotov = common_item::function_61c2c0251e742ffd( %"itemspawnentry:wz_sat_item_lethal_molotov", undefined, spawn_options );
    }
}

// Namespace namespace_a58c83961abd2620
// Params 2, eflags: 0x4
// Checksum 0x42caf36c, Offset: 0x576
// Size: 0x7d
function private spawn_quest_item( spawn_struct, item_spawn_entry )
{
    spawn_options = common_item::function_bc5ff2958b71a708( spawn_struct.origin, spawn_struct.angles );
    itembundle = getscriptbundle( item_spawn_entry );
    itembundle = common_item::function_aa1699f78ccb3f3d( itembundle );
    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawn_options );
    item.critical = 1;
    return item;
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x310ffed8, Offset: 0x5fc
// Size: 0x2
function private on_disabled()
{
    
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x7652cf8c, Offset: 0x606
// Size: 0xf
function private setup_variables()
{
    level.jackalope = spawnstruct();
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0xcefdbde6, Offset: 0x61d
// Size: 0x2fd
function private function_1a00a5a2ba836d4d()
{
    jackalope_locs = utility::getstructarray( "jackalope_spawn", "script_noteworthy" );
    level.jackalope.pickup_jackalope = arrayrandomize( jackalope_locs )[ 0 ];
    carrot_locs = utility::getstructarray( "carrot_spawn", "script_noteworthy" );
    level.jackalope.pickup_carrot = arrayrandomize( carrot_locs )[ 0 ];
    level.jackalope.cauldron = getent( "jackalope_cauldron", "targetname" );
    assert( level.jackalope.cauldron, "<dev string:x24>" );
    level.jackalope.cauldron.jack_model = utility::spawn_model( "saw_mc_jackalope_dead_01", level.jackalope.cauldron.origin + ( 0, 3, 14 ), ( 0, 0, -12.7926 ) );
    level.jackalope.cauldron.jack_model hide();
    level.jackalope.cauldron.carrot_models = [];
    
    foreach ( offset in [ ( -8, -5, 14 ), ( -3, -10, 14 ), ( 1, -6, 14 ), ( 6, -4, 14 ) ] )
    {
        angles = ( randomint( 360 ), randomint( 360 ), 0 );
        var_8934f07d34e81dcd = utility::spawn_model( "foliage_garden_carrot_01_destr_s1_f1", level.jackalope.cauldron.origin + offset, angles );
        var_8934f07d34e81dcd hide();
        level.jackalope.cauldron.carrot_models[ level.jackalope.cauldron.carrot_models.size ] = var_8934f07d34e81dcd;
    }
    
    level.jackalope.fire_pit = getentitylessscriptablearray( "jackalope_fire_pit", "script_noteworthy" )[ 0 ];
    assert( level.jackalope.fire_pit, "<dev string:x7b>" );
    level.jackalope.molotovs = utility::getstructarray( "jackalope_molotov", "script_noteworthy" );
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x4927930a, Offset: 0x922
// Size: 0x268
function private function_970d564ac5226b2e()
{
    cauldron = level.jackalope.cauldron;
    cauldron.var_37a8994003118f0e = getdvarint( @"hash_6677a6f29a4defdd", 30 );
    cauldron.var_9e3e38694931f3ec = getdvarint( @"hash_4e65091d69153fb1", 20 );
    cauldron.var_dfa25a0fe5c32a3 = getdvarint( @"hash_ccdeb67d1b944d66", 15 );
    cauldron.var_ad2ce5d08c5fd0fd = getdvarint( @"hash_4e905740542a9a16", 15 );
    level.jackalope.buffs = [];
    level.jackalope.buffs[ "ammo" ] = { #percent:getdvarint( @"hash_d97134c81fda71d0", 50 ), #timeout:getdvarint( @"hash_b6cf7453d9d4caee", 15 ), #enabled:1 };
    level.jackalope.buffs[ "armor" ] = { #percent:getdvarint( @"hash_24f06aee0a399e13", 33 ), #timeout:getdvarint( @"hash_77a6b5737edc0695", 5 ), #enabled:1 };
    level.jackalope.buffs[ "grenade" ] = { #percent:getdvarint( @"hash_99fb9730cc4186d0", 50 ), #timeout:getdvarint( @"hash_7759d6bc863bdfee", 10 ), #enabled:1 };
    level.jackalope.buffs[ "powerup" ] = { #multiplier:getdvarfloat( @"hash_2e09c571152cdb9a", 2 ), #percent:getdvarint( @"hash_c132a6f8a42c437a", 10 ), #timeout:getdvarint( @"hash_c38de8e63813ad08", 60 ), #enabled:1 };
    level.jackalope.buffs[ "magicbox" ] = { #percent:getdvarint( @"hash_355ced3bb1fe329b", 66 ), #timeout:getdvarint( @"hash_443316654ed1ae3d", 30 ), #enabled:1 };
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x2970de4a, Offset: 0xb92
// Size: 0x45
function private setup_callbacks()
{
    assert( level.jackalope.cauldron, "<dev string:xec>" );
    interaction::register_scriptable_interact( level.jackalope.cauldron getlinkedscriptableinstance(), &cauldron_used );
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0xf3f95b1c, Offset: 0xbdf
// Size: 0x1d3
function private cauldron_used( player )
{
    has_jackalope = player br_quest_inventory::has_quest_item( "wz_consumable_quest_jackalope_s6" );
    has_carrot = player br_quest_inventory::has_quest_item( "wz_consumable_quest_jackalope_carrot_s6" );
    cauldron = level.jackalope.cauldron;
    
    if ( !cauldron.var_61a344dcd02a01f2 && has_jackalope )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_jackalope_s6", 1 );
        cauldron.jack_model show();
        cauldron.var_61a344dcd02a01f2 = 1;
        playsoundatpos( cauldron.jack_model.origin, "evt_jackalope_corpse_place" );
        level.jackalope.fire_pit scriptable::scriptable_adddamagedcallback( &fire_pit_damaged );
    }
    
    if ( !cauldron.var_602e3270d8e9b515 && has_carrot )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_jackalope_carrot_s6", 1 );
        
        foreach ( var_8934f07d34e81dcd in cauldron.carrot_models )
        {
            var_8934f07d34e81dcd show();
        }
        
        playsoundatpos( cauldron.carrot_models[ 0 ].origin, "evt_jackalope_carrot_place" );
        cauldron.var_602e3270d8e9b515 = 1;
    }
    
    if ( cauldron.var_61a344dcd02a01f2 && cauldron.var_602e3270d8e9b515 )
    {
        cauldron setscriptablepartstate( "cauldron_interact", "unusable" );
    }
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x92c6bbfe, Offset: 0xdba
// Size: 0x1ef
function private function_c54f38d8da65a04e()
{
    level endon( #"game_ended" );
    self endon( #"hash_6d53bf72d256c677" );
    wait self.var_37a8994003118f0e - self.var_dfa25a0fe5c32a3;
    self.jack_model moveto( self.jack_model.origin - ( 0, 0, 7 ), self.var_dfa25a0fe5c32a3 );
    self.jack_model utility::delaycall( self.var_dfa25a0fe5c32a3, &delete );
    wait self.var_dfa25a0fe5c32a3;
    
    if ( !level callback::exists( #"player_item_pickup", &function_81e4e1b8de875156 ) )
    {
        level callback::add( #"player_item_pickup", &function_81e4e1b8de875156 );
    }
    
    self.reward_tier = 1;
    cauldron_give_reward();
    
    if ( !self.var_602e3270d8e9b515 )
    {
        return;
    }
    
    wait self.var_9e3e38694931f3ec - self.var_dfa25a0fe5c32a3;
    
    foreach ( var_8934f07d34e81dcd in self.carrot_models )
    {
        var_8934f07d34e81dcd moveto( var_8934f07d34e81dcd.origin - ( 0, 0, 8 ), self.var_dfa25a0fe5c32a3 );
        var_8934f07d34e81dcd utility::delaycall( self.var_dfa25a0fe5c32a3, &delete );
    }
    
    wait self.var_dfa25a0fe5c32a3;
    self.reward_tier++;
    self.reward freescriptable();
    cauldron_give_reward();
    wait self.var_ad2ce5d08c5fd0fd;
    self.reward_tier--;
    self.reward freescriptable();
    cauldron_give_reward();
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x958bc1, Offset: 0xfb1
// Size: 0xce
function private cauldron_give_reward()
{
    spawn_origin = self.origin + ( 0, 0, 14 );
    spawn_angles = ( 0, 0, 0 );
    spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
    playsoundatpos( spawn_origin, "evt_jackalope_reward_float_up" );
    reward_asset = self.reward_tier < 2 ? %"hash_574c545c87e5afc8" : %"hash_655f52ca314c1467";
    itembundle = getscriptbundle( reward_asset );
    itembundle = common_item::function_aa1699f78ccb3f3d( itembundle );
    self.reward = common_item::function_61c2c0251e742ffd( itembundle, 1, spawn_options );
    self.reward.critical = 1;
}

// Namespace namespace_a58c83961abd2620
// Params 11, eflags: 0x4
// Checksum 0xfe72c393, Offset: 0x1087
// Size: 0x169
function private fire_pit_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) || instance.type != "mp_saw_manticore_s6_jackalope_fire_pit" )
    {
        return;
    }
    
    var_30fffcd4b846cbe4 = objweapon.basename != "sat_molotov_wz" || objweapon.basename != "sat_thermite_wz";
    
    if ( !var_30fffcd4b846cbe4 )
    {
        return;
    }
    
    instance setscriptablepartstate( "base", "lit" );
    instance setscriptablepartstate( "sfx", "start_fire" );
    level.jackalope.cauldron setscriptablepartstate( "cauldron_interact", "unusable" );
    level.jackalope.cauldron setscriptablepartstate( "fx", "bubble" );
    eattacker thread points::doscoreevent( #"hash_918e98c2b4080ef0" );
    eattacker damagefeedback::updatedamagefeedback( "standard", 0 );
    scriptable::function_dc174fecebb79952( &fire_pit_damaged );
    level.jackalope.cauldron thread function_c54f38d8da65a04e();
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0xe4fc66af, Offset: 0x11f8
// Size: 0x25f
function private function_81e4e1b8de875156( params )
{
    if ( params.itembundlename != %"hash_574c545c87e5afc8" && params.itembundlename != %"hash_655f52ca314c1467" )
    {
        return;
    }
    
    level callback::remove( #"player_item_pickup", &function_81e4e1b8de875156 );
    thread function_c22a02216a26e536();
    level.jackalope.cauldron notify( #"hash_6d53bf72d256c677" );
    level.jackalope.fire_pit setscriptablepartstate( "sfx", "fire_end" );
    level.jackalope.cauldron setscriptablepartstate( "fx", "off" );
    self.buffs = [];
    self.buffs[ "ammo" ] = level.jackalope.buffs[ "ammo" ];
    self.buffs[ "armor" ] = level.jackalope.buffs[ "armor" ];
    self.buffs[ "grenade" ] = level.jackalope.buffs[ "grenade" ];
    callback::add( #"reload_start", &function_43d8a13c1fdf293d );
    callback::add( #"reload", &function_150dc9d993a6b9c3 );
    callback::add( #"hash_42a07c459e05796d", &function_2f5f9a0b91c5541b );
    callback::add( #"grenade_fire", &function_97f1dda4e4e56eca );
    
    if ( params.itembundlename == %"hash_655f52ca314c1467" )
    {
        self.buffs[ "powerup" ] = level.jackalope.buffs[ "powerup" ];
        self.buffs[ "magicbox" ] = level.jackalope.buffs[ "magicbox" ];
        
        if ( !isdefined( level.jackalope.var_3c1a1044bbbac1e0 ) )
        {
            level.jackalope.var_3c1a1044bbbac1e0 = 0;
        }
        
        level.powerup_timeout_override = &function_a4795446384dcca4;
        callback::add( #"hash_8daeabb90e45c6bc", &function_ed53e374e6c9cfcb );
        callback::add( "magicbox_used", &function_a0092dd26d5c25c8 );
    }
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0xf6c09d1b, Offset: 0x145f
// Size: 0x22
function private function_c22a02216a26e536()
{
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    function_f04699a454e53f07();
}

// Namespace namespace_a58c83961abd2620
// Params 0, eflags: 0x4
// Checksum 0x29878bad, Offset: 0x1489
// Size: 0x9c
function private function_f04699a454e53f07()
{
    callback::remove( #"reload_start", &function_43d8a13c1fdf293d );
    callback::remove( #"reload", &function_150dc9d993a6b9c3 );
    callback::remove( #"hash_42a07c459e05796d", &function_2f5f9a0b91c5541b );
    callback::remove( #"grenade_fire", &function_97f1dda4e4e56eca );
    level.powerup_timeout_override = undefined;
    callback::remove( #"hash_8daeabb90e45c6bc", &function_ed53e374e6c9cfcb );
    callback::remove( "magicbox_used", &function_a0092dd26d5c25c8 );
    level callback::add( #"player_item_pickup", &function_81e4e1b8de875156 );
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x6758b475, Offset: 0x152d
// Size: 0x93
function private function_43d8a13c1fdf293d( params )
{
    weapon = self.currentprimaryweapon;
    var_95632217f84d8c21 = item_ammo::function_b162feeed34a4640( weapon );
    clip_size = weaponclipsize( weapon );
    var_f988b8439c91d529 = self getweaponammoclip( weapon );
    var_7a113e424d452972 = clip_size - var_f988b8439c91d529;
    self.buffs[ "ammo" ].reload_data = { #var_7a113e424d452972:var_7a113e424d452972, #var_95632217f84d8c21:var_95632217f84d8c21 };
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x8e7b4227, Offset: 0x15c8
// Size: 0xea
function private function_150dc9d993a6b9c3( params )
{
    if ( !self.buffs[ "ammo" ].enabled )
    {
        return;
    }
    
    if ( !utility::percent_chance( self.buffs[ "ammo" ].percent ) )
    {
        return;
    }
    
    weapon = self.currentprimaryweapon;
    reload_data = self.buffs[ "ammo" ].reload_data;
    
    if ( isdefined( weapon ) && isdefined( reload_data ) )
    {
        thread points::doscoreevent( #"hash_12db4967e130a39" );
        item_ammo::function_d668d164f515b571( self, weapon, reload_data.var_7a113e424d452972 );
        function_92f691b79a2db6b8( reload_data.var_95632217f84d8c21, reload_data.var_7a113e424d452972 );
    }
    
    thread function_8d5ddd01781ed747( self.buffs[ "ammo" ] );
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x9f190dc3, Offset: 0x16ba
// Size: 0xf2
function private function_2f5f9a0b91c5541b( params )
{
    if ( !self.buffs[ "armor" ].enabled )
    {
        return;
    }
    
    if ( !utility::percent_chance( self.buffs[ "armor" ].percent ) )
    {
        return;
    }
    
    thread points::doscoreevent( #"hash_df472c7cd5403c9a" );
    armor::function_164c824617d7e8d7( 1 );
    fake_pickup = { #count:1, #ref:level.armorref };
    var_4c48fad50fa1fc28 = [ fake_pickup ];
    
    if ( utility::issharedfuncdefined( #"game", #"showStockLootFeed" ) )
    {
        level thread [[ utility::getsharedfunc( #"game", #"showStockLootFeed" ) ]]( self, var_4c48fad50fa1fc28 );
    }
    
    thread function_8d5ddd01781ed747( self.buffs[ "armor" ] );
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0xf2967dec, Offset: 0x17b4
// Size: 0x17a
function private function_97f1dda4e4e56eca( params )
{
    if ( !self.buffs[ "grenade" ].enabled )
    {
        return;
    }
    
    if ( !utility::percent_chance( self.buffs[ "grenade" ].percent ) )
    {
        return;
    }
    
    foreach ( offhand_wep in self.offhandinventory )
    {
        if ( offhand_wep.basename != params.grenade.weapon_name || offhand_wep.basename == "sat_armorplate_wz" )
        {
            continue;
        }
        
        thread points::doscoreevent( #"hash_91ad342b25a43cdb" );
        weap_ref = equipment_mp::getequipmentreffromweapon( offhand_wep );
        equipment_mp::incrementequipmentammo( weap_ref, 1 );
        thread function_8d5ddd01781ed747( self.buffs[ "grenade" ] );
        lootitem_type = common_item::function_105527001e21028d( params.grenade.bundle.lootid );
        function_92f691b79a2db6b8( lootitem_type, 1 );
        break;
    }
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x1970080, Offset: 0x1936
// Size: 0x81
function private function_a4795446384dcca4( wait_time )
{
    if ( !self.buffs[ "powerup" ].enabled )
    {
        return wait_time;
    }
    
    if ( !utility::percent_chance( self.buffs[ "powerup" ].percent ) )
    {
        return wait_time;
    }
    
    wait_time *= 2;
    thread points::doscoreevent( #"hash_50bf31092add1c61" );
    thread function_8d5ddd01781ed747( self.buffs[ "powerup" ] );
    return wait_time;
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0xb230b301, Offset: 0x19c0
// Size: 0x64
function private function_a0092dd26d5c25c8( params )
{
    if ( level.jackalope.raygun_spawned )
    {
        return;
    }
    
    thread points::doscoreevent( #"hash_b3dc6b00270c19a1" );
    level.var_a28a6b70b096f4e5 = "wz_item_weapon_pi_ray_gun_lege";
    level.jackalope.raygun_spawned = 1;
    wait 1;
    level.var_a28a6b70b096f4e5 = undefined;
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x23c9fbeb, Offset: 0x1a2c
// Size: 0xbb
function private function_ed53e374e6c9cfcb( params )
{
    if ( !self.buffs[ "magicbox" ].enabled )
    {
        return;
    }
    
    if ( !utility::percent_chance( self.buffs[ "magicbox" ].percent ) )
    {
        return;
    }
    
    thread points::doscoreevent( #"hash_507518cc1b2f709c" );
    refund = int( params.cost / 2 );
    utility::callsharedfunc( #"points", #"add_currency", refund );
    function_92f691b79a2db6b8( "wz_consumable_plunder_epic_2", refund );
    thread function_8d5ddd01781ed747( self.buffs[ "magicbox" ] );
}

// Namespace namespace_a58c83961abd2620
// Params 2, eflags: 0x4
// Checksum 0xaafa8fb6, Offset: 0x1aef
// Size: 0x96
function private function_92f691b79a2db6b8( ref, count )
{
    var_4c48fad50fa1fc28 = [];
    fake_pickup = spawnstruct();
    fake_pickup.count = count;
    fake_pickup.ref = ref;
    var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fake_pickup;
    
    if ( utility::issharedfuncdefined( #"game", #"showStockLootFeed" ) && var_4c48fad50fa1fc28.size > 0 )
    {
        level thread [[ utility::getsharedfunc( #"game", #"showStockLootFeed" ) ]]( self, var_4c48fad50fa1fc28 );
    }
}

// Namespace namespace_a58c83961abd2620
// Params 1, eflags: 0x4
// Checksum 0x8bb332a4, Offset: 0x1b8d
// Size: 0x5b
function private function_8d5ddd01781ed747( buff_struct )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !buff_struct.enabled )
    {
        return;
    }
    
    buff_struct.enabled = 0;
    wait buff_struct.timeout;
    buff_struct.enabled = 1;
}

/#

    // Namespace namespace_a58c83961abd2620
    // Params 0
    // Checksum 0xd1db94ae, Offset: 0x1bf0
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0x681cf19a, Offset: 0x1bfd
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xf47070ae, Offset: 0x1c11
    // Size: 0xbe, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x139>" + "<dev string:x148>" + "<dev string:x15c>" );
        devgui::add_devgui_func( "<dev string:x15e>", "<dev string:x184>", &function_697a3812b85410ee );
        devgui::add_devgui_func( "<dev string:x1a0>", "<dev string:x1bf>", &function_40a18e7520b96926 );
        devgui::add_devgui_func( "<dev string:x1e4>", "<dev string:x1fb>", &function_4f46af49a30f1e4f );
        devgui::add_devgui_func( "<dev string:x218>", "<dev string:x22c>", &function_871044ccb2efd62e );
        devgui::add_devgui_func( "<dev string:x246>", "<dev string:x254>", &debug_spawn_molotov );
        devgui::function_cd4e263c1f3018ae( "<dev string:x268>", "<dev string:x27d>", &function_cc6ba1db4adeef1b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x296>", "<dev string:x2b3>", &function_cc6ba1db4adeef1b );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0x2bd45ea2, Offset: 0x1cd7
    // Size: 0x28, Type: dev
    function private function_697a3812b85410ee()
    {
        if ( !getdvarint( @"hash_9287166521131382", 0 ) )
        {
            function_ce39cca693f76a12();
            return;
        }
        
        function_80aa7657694541a4();
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0x1d1f9f8a, Offset: 0x1d07
    // Size: 0x198, Type: dev
    function private function_40a18e7520b96926()
    {
        var_5b735f3136b34424 = level.jackalope.buffs[ "<dev string:x2cc>" ].percent == getdvarint( @"hash_d97134c81fda71d0", 50 );
        debug_text = var_5b735f3136b34424 ? "<dev string:x2d1>" : "<dev string:x2e2>";
        iprintlnbold( debug_text );
        level.jackalope.buffs[ "<dev string:x2cc>" ].percent = var_5b735f3136b34424 ? 100 : getdvarint( @"hash_d97134c81fda71d0", 50 );
        level.jackalope.buffs[ "<dev string:x2f6>" ].percent = var_5b735f3136b34424 ? 100 : getdvarint( @"hash_77a6b5737edc0695", 5 );
        level.jackalope.buffs[ "<dev string:x2fc>" ].percent = var_5b735f3136b34424 ? 100 : getdvarint( @"hash_99fb9730cc4186d0", 50 );
        level.jackalope.buffs[ "<dev string:x304>" ].percent = var_5b735f3136b34424 ? 100 : getdvarint( @"hash_c38de8e63813ad08", 60 );
        level.jackalope.buffs[ "<dev string:x30c>" ].percent = var_5b735f3136b34424 ? 100 : getdvarint( @"hash_443316654ed1ae3d", 30 );
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xe877f017, Offset: 0x1ea7
    // Size: 0xf0, Type: dev
    function private function_ce39cca693f76a12()
    {
        level endon( #"game_ended" );
        level endon( #"hash_d15d48061e75b232" );
        
        while ( !level.jackalope.pickup_jackalope && !level.jackalope.pickup_carrot )
        {
            waitframe();
        }
        
        setdvar( @"hash_9287166521131382", 1 );
        iprintlnbold( "<dev string:x315>" );
        
        if ( level.jackalope.pickup_jackalope )
        {
            debug::sphere( level.jackalope.pickup_jackalope, 10, "<dev string:x347>", undefined, "<dev string:x34d>", "<dev string:x34d>", 0 );
        }
        
        if ( level.jackalope.pickup_carrot )
        {
            debug::sphere( level.jackalope.pickup_carrot, 10, "<dev string:x36b>", undefined, "<dev string:x34d>", "<dev string:x34d>", 0 );
        }
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xcd618146, Offset: 0x1f9f
    // Size: 0x2a, Type: dev
    function private function_80aa7657694541a4()
    {
        setdvar( @"hash_9287166521131382", 0 );
        iprintlnbold( "<dev string:x372>" );
        level notify( #"hash_d15d48061e75b232" );
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xb426cf83, Offset: 0x1fd1
    // Size: 0xa3, Type: dev
    function private function_4f46af49a30f1e4f()
    {
        bundle = common_item::function_cf68ad18114498b2( "<dev string:x3a5>" );
        spawn_options = common_item::function_bc5ff2958b71a708( level.player.origin + anglestoforward( level.player getplayerangles() ) * 30 + ( 0, 0, 50 ), -1 * level.player getplayerangles() );
        spawn_options.critical = 1;
        spawn_options.var_f35b5b18b029c493 = 0;
        item = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xf3a63ee4, Offset: 0x207c
    // Size: 0xa3, Type: dev
    function private function_871044ccb2efd62e()
    {
        bundle = common_item::function_cf68ad18114498b2( "<dev string:x3c6>" );
        spawn_options = common_item::function_bc5ff2958b71a708( level.player.origin + anglestoforward( level.player getplayerangles() ) * 30 + ( 0, 0, 50 ), -1 * level.player getplayerangles() );
        spawn_options.critical = 1;
        spawn_options.var_f35b5b18b029c493 = 0;
        item = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
    }

    // Namespace namespace_a58c83961abd2620
    // Params 0, eflags: 0x4
    // Checksum 0xe3ba47f4, Offset: 0x2127
    // Size: 0x91, Type: dev
    function private debug_spawn_molotov()
    {
        spawn_options = common_item::function_bc5ff2958b71a708( level.player.origin + anglestoforward( level.player getplayerangles() ) * 30 + ( 0, 0, 50 ), -1 * level.player getplayerangles() );
        spawn_options.critical = 1;
        spawn_options.var_f35b5b18b029c493 = 0;
        item = common_item::items_spawnitemfromscriptable( "<dev string:x3ee>", 1, spawn_options );
    }

    // Namespace namespace_a58c83961abd2620
    // Params 1, eflags: 0x4
    // Checksum 0xa169b054, Offset: 0x21c0
    // Size: 0x104, Type: dev
    function private function_cc6ba1db4adeef1b( params )
    {
        spawn_origin = level.player.origin + anglestoforward( level.player getplayerangles() ) * 30 + ( 0, 0, 25 );
        spawn_angles = ( 0, 0, 0 );
        spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
        reward_asset = int( params[ 0 ] ) == 0 ? %"hash_574c545c87e5afc8" : %"hash_655f52ca314c1467";
        itembundle = getscriptbundle( reward_asset );
        itembundle = common_item::function_aa1699f78ccb3f3d( itembundle );
        
        if ( !callback::exists( #"player_item_pickup", &function_81e4e1b8de875156 ) )
        {
            level callback::add( #"player_item_pickup", &function_81e4e1b8de875156 );
        }
        
        item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawn_options );
    }

#/
