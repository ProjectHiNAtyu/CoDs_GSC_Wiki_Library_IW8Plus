// scripts\mp\loot\common_item_generic.gsc  (hash_6c59fbff35e230b8.gscc) (size: 9486 Bytes / 0x250e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdafe2ba2 (3674090402)
// size ...... 9486 (0x250e)
// includes .. 16  (offset: 0x22ee)
// strings ... 30  (offset: 0x236e)
// dev strs .. 0   (offset: 0x250e)
// exports ... 15  (offset: 0x1826)
// cseg ...... 0x493 + 0x1393 (0x1826)
// imports ... 73  (offset: 0x1a7e)
// animtree1 . 0   (offset: 0x250e)
// animtree2 . 0   (offset: 0x250e)
#using script_30a19d5ee7e2506d;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\health_chunks;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_generic;

// Namespace item_generic
// Params 0, eflags: 0x5
// Checksum 0xd163d459, Offset: 0x4b1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_generic", #"common_item", &init_item_generic, undefined );
}

// Namespace item_generic
// Params 0
// Checksum 0xc5864fe2, Offset: 0x4da
// Size: 0x9b
function init_item_generic()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "generic" );
    common_item::function_84174b793b5fe9a7( "generic", #"use", &function_c8d64b4eff824cff );
    common_item::function_84174b793b5fe9a7( "generic", #"canautouse", &function_21c67edfac35c297 );
    common_item::function_84174b793b5fe9a7( "generic", #"hash_9e49dfaa7c147654", &function_8a263df80be41be8 );
    common_item::function_84174b793b5fe9a7( "generic", #"hash_2d3b76ff260f2d68", &function_e84dc6fcb81ebb97 );
    common_item::function_84174b793b5fe9a7( "generic", #"hash_e2da6c78fc49f200", &function_8645741d3ca3bbbd );
}

// Namespace item_generic
// Params 4
// Checksum 0xbd50684, Offset: 0x57d
// Size: 0x49c
function function_c8d64b4eff824cff( itembundle, item, autouse, var_981c264073bf1154 )
{
    remainderquantity = item.count;
    
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_d42d44f53610ee5":
                use_weapon_case( itembundle, item );
                return 0;
            case #"hash_7eee054ac1766fba":
                remainderquantity = function_b96e553c890dc5c5( itembundle, item );
                break;
            case #"hash_37276153aa1bb01d":
                callback::callback( "quest_item_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                return 0;
            case #"hash_9bbb9bc426bb5e34":
                function_e542fd635af0fc27( itembundle, item );
                return 0;
            case #"hash_e5983adf81a0fa82":
                thread utility::callsharedfunc( #"scavenger_bag", #"onscavengerbagpickup", item );
                return 0;
            case #"hash_fe3fcfddba61609b":
                callback::callback( "scripted_item_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                return 0;
            case #"hash_bc5899d010bb3872":
                callback::callback( "scripted_item_mutagen_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                return 0;
            case #"hash_9ff845c6bef56822":
                if ( itembundle.var_ed07e6a8ba4aaa6e && !disguise::function_bc13e7208281eb0c() && thread disguise::disguise_tryuse( undefined, item.count, itembundle ) )
                {
                    return 0;
                }
                else
                {
                    return item.count;
                }
            case #"hash_bf5597954aaed3d7":
                str_intel_name = itembundle.ref;
                
                if ( isdefined( item.owningplayer ) )
                {
                    if ( item.owningplayer == self )
                    {
                        thread utility::callsharedfunc( #"intel", #"collect_intel", str_intel_name, item );
                        return 0;
                    }
                    else
                    {
                        item disablescriptableplayeruse( self );
                        return item.count;
                    }
                }
                else
                {
                    thread utility::callsharedfunc( #"intel", #"collect_intel", str_intel_name, item );
                    return 0;
                }
            case #"hash_13d1f84d0ae96a5f":
                callback::callback( "trophy_item_used", { #player:self, #pickupent:{ #stackable:1, #instance:item, #scriptablename:item.type } } );
                return 0;
            case #"hash_52ae8c38ce1ee65b":
                used = utility::callsharedfunc( #"item_select", #"item_select_used", { #player:self, #instance:item, #itembundle:itembundle } );
                
                if ( used )
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            case #"hash_d3ba65df32deac9d":
                if ( item.spawnoptions )
                {
                    item.spawnoptions.baseorigin = item.origin;
                    item.spawnoptions.baseangle = item.angles;
                    level thread common_inventory::function_993f81a1c4d8bbc1( item.spawnoptions );
                }
                
                return 0;
            case #"hash_45cdb36c0bf3d896":
                thread utility::callsharedfunc( #"powertier", #"power_tier_kill_reward_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                return 0;
            case #"hash_7d741988b469f796":
                thread utility::callsharedfunc( #"skill_track_starter", #"skill_track_starter_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                return 0;
            case #"hash_4ac8b1d8f399fa27":
                if ( !self.haswingsuit )
                {
                    thread utility::callsharedfunc( #"wingsuit", #"wingsuit_used", { #player:self, #scriptable:item, #bundle:itembundle } );
                    return 0;
                }
                
                return 1;
            default:
                return item.count;
        }
    }
    
    return remainderquantity;
}

// Namespace item_generic
// Params 4
// Checksum 0x52e43f8e, Offset: 0xa22
// Size: 0xd5
function function_21c67edfac35c297( itembundle, item, autouse, allowswap )
{
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_e5983adf81a0fa82":
                return ( itembundle.autopickupenabled && item.owningplayer == self );
            case #"hash_13d1f84d0ae96a5f":
                return istrue( itembundle.autopickupenabled );
            case #"hash_fe3fcfddba61609b":
                return callback::response( 2, "scripted_item_can_autouse", { #player:self, #scriptable:item, #bundle:itembundle } );
            default:
                return 0;
        }
    }
    
    return 0;
}

// Namespace item_generic
// Params 4
// Checksum 0x8203a19c, Offset: 0xb00
// Size: 0x1ba
function function_8a263df80be41be8( itembundle, item, autouse, allowswap )
{
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_9bbb9bc426bb5e34":
                return function_5cbcc09ac08b9ca4( itembundle, item );
            case #"hash_37276153aa1bb01d":
                return callback::response( 2, #"quest_item_can_use", { #player:self, #scriptable:item, #bundle:itembundle } );
            case #"hash_d42d44f53610ee5":
            case #"hash_9b9519b2b0a96f04":
            case #"hash_bf5597954aaed3d7":
            case #"hash_fe3fcfddba61609b":
                return callback::response( 2, "scripted_item_can_use", { #player:self, #scriptable:item, #bundle:itembundle } );
            case #"hash_13d1f84d0ae96a5f":
            case #"hash_45cdb36c0bf3d896":
            case #"hash_52ae8c38ce1ee65b":
            case #"hash_7d741988b469f796":
            case #"hash_bc5899d010bb3872":
            case #"hash_d3ba65df32deac9d":
                return 1;
            case #"hash_e5983adf81a0fa82":
                return ( item.owningplayer == self && callback::response( 2, "scripted_item_can_use", { #player:self, #scriptable:item, #bundle:itembundle } ) );
            case #"hash_4ac8b1d8f399fa27":
                return !self.haswingsuit;
            default:
                return 0;
        }
    }
    
    return 0;
}

// Namespace item_generic
// Params 5
// Checksum 0x756977d0, Offset: 0xcc3
// Size: 0x1ce
function function_e84dc6fcb81ebb97( index, itembundle, lootid, quantity, fromgroup )
{
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_904f383e75c98a7c":
                namespace_80cbeb966e2dcff0::function_7cc4c87531b98831( index, itembundle, lootid, quantity, fromgroup );
                break;
            case #"hash_1a91004edd2f0090":
                namespace_80cbeb966e2dcff0::function_9323d9f60a457f5d( index, itembundle, lootid, quantity, fromgroup );
                break;
            case #"hash_9ff845c6bef56822":
                if ( !disguise::function_bc13e7208281eb0c() && disguise::disguise_tryuse( self, quantity, itembundle ) )
                {
                    return 0;
                }
                
                break;
            case #"hash_fb9b2f1526a93a29":
                thread function_6d1058758fcd02d4( index, itembundle, lootid, quantity, fromgroup );
                break;
            case #"hash_7eee054ac1766fba":
                return 1;
            case #"hash_d42d44f53610ee5":
                return use_weapon_case( itembundle, undefined, index, lootid, quantity );
            case #"hash_9bbb9bc426bb5e34":
                return function_e542fd635af0fc27( itembundle, undefined, index, lootid, quantity );
            case #"hash_bf5597954aaed3d7":
                str_intel_name = itembundle.ref;
                thread utility::callsharedfunc( #"intel", #"collect_intel", str_intel_name );
                return 0;
            case #"hash_fe3fcfddba61609b":
                callback::callback( #"hash_985630f7063043cd", { #player:self, #scriptable:undefined, #bundle:itembundle } );
                return 0;
            case #"hash_4f378764ff9d179c":
            default:
                break;
        }
    }
    
    if ( itembundle.var_a4398f449de22222 )
    {
        thread common_item::function_88fc33fa5edff36e( index, itembundle, lootid, quantity, fromgroup );
        return;
    }
}

// Namespace item_generic
// Params 5
// Checksum 0x3752b196, Offset: 0xe99
// Size: 0x14d
function use_weapon_case( itembundle, item, index, lootid, quantity = 1 )
{
    itemweapon = 0;
    itemweaponname = "";
    
    switch ( itembundle.ref )
    {
        case #"hash_acd8a83eccffc813":
            itemweaponname = "obloot_weapon_pi_raygun";
            break;
        case #"hash_f95d139ef5a97442":
            itemweaponname = "obloot_weapon_ar_dg2";
            break;
        case #"hash_55a8fd741e7314d3":
            itemweaponname = "obloot_weapon_la_plasmagun";
            break;
        case #"hash_18424477527e0e16":
            itemweaponname = "obloot_offhand_aether_blade";
            break;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    itemweapon = common_item::items_spawnitemfromscriptable( itemweaponname, undefined, spawnoptions );
    
    if ( isdefined( itemweapon ) )
    {
        if ( isweapon( itemweapon.weaponobj ) )
        {
            itemweapon.count = common_item::function_598dd39282efb544( weaponmaxammo( itemweapon.weaponobj ) );
        }
        else
        {
            itemweapon.count = 1;
        }
        
        common_item::function_96119bed8ab4c5d9( itemweapon, 0 );
    }
    else
    {
        return quantity;
    }
    
    self playsoundtoplayer( #"uin_ob_pickup_weaponcase_used", self );
    return quantity - 1;
}

// Namespace item_generic
// Params 5
// Checksum 0xba870a42, Offset: 0xfef
// Size: 0x1ab
function function_e542fd635af0fc27( itembundle, item, index, lootid, quantity = 1 )
{
    vehiclemodel = "";
    vehicleref = "";
    vehicletype = "";
    
    switch ( itembundle.ref )
    {
        case #"hash_edb432dc3df35133":
            vehiclemodel = "veh_jup_motocycle_blood_burner";
            vehicleref = %"hash_1b24b36c27a04014";
            vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
            break;
        default:
            return quantity;
    }
    
    forwardoffset = anglestoforward( self.angles ) * 150;
    nav_spawn_point = utility::function_5918594658d3ffba( self.origin + forwardoffset, 150 );
    
    if ( !isdefined( nav_spawn_point ) )
    {
        nav_spawn_point = getclosestpointonnavmesh( self.origin + forwardoffset );
    }
    
    self playsoundtoplayer( "uin_ob_pickup_weaponcase_used", self );
    spawndata = spawnstruct();
    spawndata.origin = nav_spawn_point;
    spawndata.angles = self.angles;
    spawndata.owner = self;
    spawndata.vehicleoverride = vehicletype;
    spawndata.script_modelname = vehiclemodel;
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    self.itemvehiclespawn = vehicle::spawn( vehicleref, spawndata );
    
    if ( !isdefined( self.itemvehiclespawn ) )
    {
        return quantity;
    }
    
    return quantity - 1;
}

// Namespace item_generic
// Params 2
// Checksum 0xbfb7e9b5, Offset: 0x11a3
// Size: 0xe7, Type: bool
function function_5cbcc09ac08b9ca4( itembundle, item )
{
    vehicleref = "";
    
    switch ( itembundle.ref )
    {
        case #"hash_edb432dc3df35133":
            vehicleref = %"hash_1b24b36c27a04014";
            
            if ( level.mapname != "mp_jup_bigmap" && level.mapname != "mp_sat_ob_core_features" )
            {
                hud_message::showerrormessage( "MP/VEHICLE_PURCHASE_FAILED" );
                return false;
            }
            
            if ( isdefined( self.itemvehiclespawn ) )
            {
                hud_message::showerrormessage( "MP/VEHICLE_PURCHASE_FAILED" );
                return false;
            }
            
            if ( !self isonground() || self isswimming() )
            {
                hud_message::showerrormessage( "MP/VEHICLE_PURCHASE_FAILED" );
                return false;
            }
            
            break;
    }
    
    if ( vehicle_tracking::function_279695c41be653f( vehicleref ) || !vehicle_tracking::can_spawn_vehicle() )
    {
        hud_message::showerrormessage( "KILLSTREAKS/TOO_MANY_VEHICLES" );
        return false;
    }
    
    return true;
}

// Namespace item_generic
// Params 2
// Checksum 0xf46cf2b2, Offset: 0x1293
// Size: 0x38, Type: bool
function function_b96e553c890dc5c5( itembundle, item )
{
    if ( isdefined( level.var_b5de30d26ddb6403 ) )
    {
        [[ level.var_b5de30d26ddb6403 ]]( #"recon_points_loot" );
    }
    
    return false;
}

// Namespace item_generic
// Params 5
// Checksum 0x6027065f, Offset: 0x12d4
// Size: 0x144
function drop_generic_item( itembundle, count, origin, angles, overridelifetime )
{
    itembundlename = common_item_database::function_a4f0a21951180013( itembundle.ref );
    var_7c170ceae0649b57 = [ #"teamselect", self getentitynumber() ];
    
    if ( itembundle.subtype == "lootcase" )
    {
        if ( isdefined( level.var_73146839de56839 ) )
        {
            [ item, itembundle ] = self [[ level.var_73146839de56839 ]]( origin, angles, 0, 0, var_7c170ceae0649b57 );
        }
    }
    else
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_61c2c0251e742ffd( itembundle, count, spawnoptions );
    }
    
    common_item::items_additemautopickupcooldownforplayer( self, item, 300 );
    params = spawnstruct();
    params.item = item;
    params.itembundle = itembundle;
    params.itembundlename = itembundlename;
    params.payload = var_7c170ceae0649b57;
    callback::callback( #"player_item_drop", params );
}

// Namespace item_generic
// Params 5
// Checksum 0xb3b3fc4e, Offset: 0x1420
// Size: 0x1ce
function function_6d1058758fcd02d4( index, itembundle, lootid, quantity, fromgroup )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( itembundle.var_de6eb6af9c97e34 ) )
    {
        gestureweapon = makeweapon( itembundle.var_de6eb6af9c97e34 );
        result = weapon_utility::giveandfireoffhandreliable( gestureweapon );
        
        if ( !result )
        {
            return;
        }
    }
    
    if ( common_inventory::inventory_isenabled() )
    {
        currentquantity = common_inventory::inventory_getquantityatbackpackindex( index );
        lootid = common_inventory::inventory_getlootidatbackpackindex( index );
        common_inventory::inventory_setbackpackitematindex( index, lootid, currentquantity - 1 );
    }
    
    if ( itembundle.foodhealth )
    {
        health_chunks::incrementchunks( self, itembundle.foodhealth, undefined, 0, 0.5, 0.25 );
    }
    
    if ( itembundle.foodduration )
    {
        if ( itembundle.var_d736391712acc68f )
        {
            val::set( "food_buff", "move_speed_scale", itembundle.var_d736391712acc68f );
            self lerpfovbypreset( "zombiedefault" );
        }
        
        if ( itembundle.var_5834bc01e31b2bbb )
        {
            self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( "specialty_supersprint_enhanced" );
        }
        
        utility::waittill_any_timeout( itembundle.foodduration, "death", "last_stand_enter" );
        
        if ( itembundle.var_5834bc01e31b2bbb )
        {
            self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( "specialty_supersprint_enhanced" );
        }
        
        if ( itembundle.var_d736391712acc68f )
        {
            self lerpfovbypreset( "default_2seconds" );
        }
        
        val::reset_all( "food_buff" );
    }
}

// Namespace item_generic
// Params 3, eflags: 0x4
// Checksum 0x956c1a66, Offset: 0x15f6
// Size: 0xbe
function private function_c294b45d46183b80( player, itembundle, item )
{
    teamplayers = teams::getteamdata( player.team, "players" );
    
    foreach ( teamplayer in teamplayers )
    {
        if ( teamplayer != player )
        {
            teamplayer common_item::function_96119bed8ab4c5d9( structcopy( item ), 0 );
        }
    }
}

// Namespace item_generic
// Params 5
// Checksum 0x652bbdc0, Offset: 0x16bc
// Size: 0x16a
function function_8645741d3ca3bbbd( player, itembundle, item, groupindex, slot )
{
    slotindex = isdefined( slot ) ? slot.index : undefined;
    additionaldata = item.additionaldata ?? common_inventory_groups::function_af51bdd9c1c5acd3( groupindex, slotindex );
    
    if ( itembundle.var_a25179a74c8df2c5 && !additionaldata.firstlooted )
    {
        additionaldata.firstlooted = 1;
        common_inventory_groups::function_228fbf34ff2066d7( groupindex, slotindex, additionaldata );
        function_c294b45d46183b80( player, itembundle, item );
    }
    
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_9ff845c6bef56822":
                if ( itembundle.var_ed07e6a8ba4aaa6e && !disguise::function_bc13e7208281eb0c() && thread disguise::disguise_tryuse( undefined, item.count, itembundle ) )
                {
                    backpackkey = common_inventory::function_211a16b41e71f692();
                    self setplayerdata( level.var_6f9b00680ed002d8, backpackkey, slot.index, "lootID", 0 );
                    self setplayerdata( level.var_6f9b00680ed002d8, backpackkey, slot.index, "quantity", 0 );
                }
                
                break;
        }
    }
}

