// scripts\mp\loot\common_item_equipment.gsc  (hash_5440ce5a82ec5485.gscc) (size: 5356 Bytes / 0x14ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd917a07 (3180427783)
// size ...... 5356 (0x14ec)
// includes .. 8   (offset: 0x141c)
// strings ... 7   (offset: 0x145c)
// dev strs .. 0   (offset: 0x14ec)
// exports ... 19  (offset: 0xb40)
// cseg ...... 0xc6 + 0xa7a (0xb40)
// imports ... 50  (offset: 0xe38)
// animtree1 . 0   (offset: 0x14ec)
// animtree2 . 0   (offset: 0x14ec)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_equipment;

// Namespace item_equipment
// Params 0, eflags: 0x5
// Checksum 0xcdc5fd48, Offset: 0xe4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_equipment", #"common_item", &init_item_equipment, undefined );
}

// Namespace item_equipment
// Params 0
// Checksum 0xd6240dbd, Offset: 0x10d
// Size: 0x197
function init_item_equipment()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( isdefined( level.init_item_equipment_override ) )
    {
        [[ level.init_item_equipment_override ]]();
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "lethal" );
    common_item::function_84174b793b5fe9a7( "lethal", #"use", &use_equipment );
    common_item::function_84174b793b5fe9a7( "lethal", #"canautouse", &function_d626232f300ceace );
    common_item::function_84174b793b5fe9a7( "lethal", #"getcurrent", &function_e9df1741d677f1bb );
    common_item::function_84174b793b5fe9a7( "lethal", #"removecurrent", &remove_current_lethal );
    common_item::function_84174b793b5fe9a7( "lethal", #"bundlenamefromlootid", &function_b0aeb46b6ba652ce );
    common_item::function_4b30c091d3b04a25( "tactical" );
    common_item::function_84174b793b5fe9a7( "tactical", #"use", &use_equipment );
    common_item::function_84174b793b5fe9a7( "tactical", #"canautouse", &function_d626232f300ceace );
    common_item::function_84174b793b5fe9a7( "tactical", #"getcurrent", &function_c6a7cabfb1d70632 );
    common_item::function_84174b793b5fe9a7( "tactical", #"removecurrent", &remove_current_tactical );
    common_item::function_84174b793b5fe9a7( "tactical", #"bundlenamefromlootid", &function_b0aeb46b6ba652ce );
    common_item::function_84174b793b5fe9a7( "tactical", #"hash_bbbee9a6b48de857", &function_c1153b41bc916961 );
    utility::registersharedfunc( #"game", #"dropItem_equipment_lethal", &function_9284c2e247c9ac39 );
    
    if ( !isdefined( level.var_6b152f29f8944b74 ) )
    {
        level.var_6b152f29f8944b74 = &function_977e49cde3cbd864;
    }
}

// Namespace item_equipment
// Params 2
// Checksum 0x91441317, Offset: 0x2ac
// Size: 0x5c
function function_c877e2896418fa3e( currentequipment, newequipment )
{
    if ( currentequipment == newequipment )
    {
        return 1;
    }
    else if ( utility::issharedfuncdefined( #"game", #"hash_f6616377f8919cc4" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_f6616377f8919cc4" ) ]]( currentequipment, newequipment );
    }
    
    return 0;
}

// Namespace item_equipment
// Params 4
// Checksum 0x95264d1d, Offset: 0x311
// Size: 0xda, Type: bool
function function_d626232f300ceace( itembundle, item, autouse, allowswap )
{
    equipmentslot = get_equipment_slot( common_item::function_16e8c106491eeaca( itembundle ) );
    currentequipment = equipment_mp::getcurrentequipment( equipmentslot );
    
    if ( !isdefined( currentequipment ) && autouse && level.gametypebundle.var_8226917cb16499e6 )
    {
        return true;
    }
    
    if ( isdefined( currentequipment ) )
    {
        var_f38a66b01ff221c1 = function_c877e2896418fa3e( currentequipment, itembundle.ref );
        
        if ( autouse && !var_f38a66b01ff221c1 )
        {
            return false;
        }
        
        if ( var_f38a66b01ff221c1 )
        {
            ammo = equipment_mp::getequipmentammo( currentequipment );
            maxammo = equipment_mp::getequipmentmaxammo( currentequipment );
            return ( ammo < maxammo );
        }
    }
    
    return false;
}

// Namespace item_equipment
// Params 4
// Checksum 0xce309d11, Offset: 0x3f4
// Size: 0x1be
function use_equipment( itembundle, item, autouse, var_981c264073bf1154 )
{
    var_9bbd26cfd0cde740 = get_equipment_slot( common_item::function_16e8c106491eeaca( itembundle ) );
    var_f4b0a2a06524db11 = itembundle.ref;
    var_3b70db2e052ec282 = common_item::function_974a788b833e282b( item );
    var_550fc828bcda6dbc = equipment_mp::getequipmentmaxammo( var_f4b0a2a06524db11, var_9bbd26cfd0cde740 );
    var_862c75e398f063b9 = 0;
    var_81cb4c86e0b928b2 = equipment_mp::getcurrentequipment( var_9bbd26cfd0cde740 );
    var_f38a66b01ff221c1 = function_c877e2896418fa3e( var_81cb4c86e0b928b2, var_f4b0a2a06524db11 );
    var_a34a4a722e352a9e = var_81cb4c86e0b928b2;
    
    if ( isdefined( var_81cb4c86e0b928b2 ) && var_f38a66b01ff221c1 )
    {
        var_f09b72d01267fc3f = equipment_mp::getequipmentammo( var_81cb4c86e0b928b2 );
        var_3b70db2e052ec282 += var_f09b72d01267fc3f;
    }
    
    if ( var_3b70db2e052ec282 > var_550fc828bcda6dbc )
    {
        var_862c75e398f063b9 = var_3b70db2e052ec282 - var_550fc828bcda6dbc;
        var_3b70db2e052ec282 = var_550fc828bcda6dbc;
    }
    
    variantid = undefined;
    
    if ( isdefined( self.var_8cf9648fae56099c ) )
    {
        variantid = self.var_8cf9648fae56099c[ var_f4b0a2a06524db11 ];
    }
    
    if ( !isdefined( var_81cb4c86e0b928b2 ) || !var_f38a66b01ff221c1 )
    {
        equipment_mp::giveequipment( var_f4b0a2a06524db11, var_9bbd26cfd0cde740, undefined, variantid );
        var_a34a4a722e352a9e = var_f4b0a2a06524db11;
    }
    
    if ( itembundle.var_2b0a27d4be7d298b )
    {
        var_3b70db2e052ec282 = 1;
        var_862c75e398f063b9 = 0;
        var_1e85e11349b64813 = equipment_mp::getcallback( var_f4b0a2a06524db11, "equipmentDurabilitySet" );
        
        if ( isdefined( var_1e85e11349b64813 ) )
        {
            self thread [[ var_1e85e11349b64813 ]]( item.count );
        }
    }
    
    equipment_mp::setequipmentammo( var_a34a4a722e352a9e, var_3b70db2e052ec282 );
    callback::callback( #"common_item_equipment_used", { #ammo:var_3b70db2e052ec282, #ref:var_a34a4a722e352a9e, #slot:var_9bbd26cfd0cde740 } );
    self notify( #"equipment_used" );
    return var_862c75e398f063b9;
}

// Namespace item_equipment
// Params 1
// Checksum 0xabc45881, Offset: 0x5bb
// Size: 0x3a
function get_equipment_slot( itemtype )
{
    switch ( itemtype )
    {
        case #"hash_339227cb650975db":
            return "primary";
        case #"hash_850999d7864fa3b4":
            return "secondary";
    }
}

// Namespace item_equipment
// Params 1
// Checksum 0x82a38180, Offset: 0x5fe
// Size: 0xc7
function function_ba3a484954eaadec( slot )
{
    var_a34a4a722e352a9e = equipment_mp::getcurrentequipment( slot );
    
    if ( isdefined( var_a34a4a722e352a9e ) )
    {
        name = common_item_database::function_a4f0a21951180013( var_a34a4a722e352a9e );
        
        if ( isdefined( name ) )
        {
            durability = 0;
            itembundle = common_item::function_90c3e0c1fd55d6b6( name );
            
            if ( itembundle.var_2b0a27d4be7d298b )
            {
                var_7e81aabe6ca3a45f = equipment_mp::getcallback( var_a34a4a722e352a9e, "equipmentDurabilityGet" );
                
                if ( isdefined( var_7e81aabe6ca3a45f ) )
                {
                    profilestart();
                    durability = self [[ var_7e81aabe6ca3a45f ]]();
                    profilestop();
                }
            }
            
            durability = durability == 0 ? undefined : durability;
            return { #durability:durability, #count:equipment_mp::getequipmentammo( var_a34a4a722e352a9e ), #name:name };
        }
    }
}

// Namespace item_equipment
// Params 1
// Checksum 0x260ca769, Offset: 0x6ce
// Size: 0x17
function function_e9df1741d677f1bb( params )
{
    return function_ba3a484954eaadec( "primary" );
}

// Namespace item_equipment
// Params 1
// Checksum 0xd46833b0, Offset: 0x6ee
// Size: 0x17
function function_c6a7cabfb1d70632( params )
{
    return function_ba3a484954eaadec( "secondary" );
}

// Namespace item_equipment
// Params 1
// Checksum 0x1dc789ad, Offset: 0x70e
// Size: 0x19
function remove_current_lethal( params )
{
    return remove_current( "primary", params );
}

// Namespace item_equipment
// Params 1
// Checksum 0x99543117, Offset: 0x730
// Size: 0x19
function remove_current_tactical( params )
{
    return remove_current( "secondary", params );
}

// Namespace item_equipment
// Params 2
// Checksum 0x79eab425, Offset: 0x752
// Size: 0x135
function remove_current( slot, params )
{
    var_8fb8e1fb220cca48 = function_ba3a484954eaadec( slot );
    
    if ( params.var_374a2fec695f49d8 || var_8fb8e1fb220cca48.count > 0 )
    {
        currentref = equipment_mp::getcurrentequipment( slot );
        newcount = 0;
        
        if ( params.count >= 0 && params.count <= var_8fb8e1fb220cca48.count )
        {
            newcount = var_8fb8e1fb220cca48.count - params.count;
        }
        
        newdurability = 0;
        
        if ( var_8fb8e1fb220cca48.durability >= 0 )
        {
            newdurability = var_8fb8e1fb220cca48.durability;
        }
        
        newdurability = newdurability == 0 ? undefined : newdurability;
        
        if ( newcount == 0 )
        {
            equipment_mp::takeequipment( slot );
        }
        else
        {
            equipment_mp::setequipmentammo( currentref, newcount );
        }
        
        return { #durability:newdurability, #count:var_8fb8e1fb220cca48.count - newcount, #name:var_8fb8e1fb220cca48.name };
    }
}

// Namespace item_equipment
// Params 1
// Checksum 0xe5ce9ea6, Offset: 0x890
// Size: 0x78
function function_9284c2e247c9ac39( quantity )
{
    lethaldata = function_e9df1741d677f1bb();
    
    if ( !isdefined( lethaldata.name ) )
    {
        return;
    }
    
    dropquantity = min( lethaldata.count, quantity );
    
    if ( dropquantity <= 0 )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    common_item::function_61c2c0251e742ffd( lethaldata.name, dropquantity, spawnoptions );
}

// Namespace item_equipment
// Params 2
// Checksum 0x1ca80cad, Offset: 0x910
// Size: 0x79
function function_c1153b41bc916961( params, var_8fb8e1fb220cca48 )
{
    var_9eefcc4457251a8c = params.count ?? var_8fb8e1fb220cca48.count;
    
    if ( params.var_eb659d64b0476d5c === var_8fb8e1fb220cca48.ref || isdefined( var_8fb8e1fb220cca48.durability ) && isdefined( params.count ) )
    {
        var_9eefcc4457251a8c = 1;
    }
    
    return var_9eefcc4457251a8c;
}

// Namespace item_equipment
// Params 1
// Checksum 0x816ffdf5, Offset: 0x992
// Size: 0x7d
function function_b0aeb46b6ba652ce( lootid )
{
    blueprintindex = function_4d465a88a4c974d3( lootid );
    
    if ( isdefined( blueprintindex ) && blueprintindex != 0 )
    {
        variantref = loot::function_f54ecb89dfab8e8c( lootid );
        baseref = equipment_mp::function_e7be0aab8fa729de( variantref );
        return level.commonitem.var_4d60369c227dcd1e[ baseref ];
    }
    
    return level.commonitem.var_47078f33898179f4[ lootid ];
}

// Namespace item_equipment
// Params 3, eflags: 0x4
// Checksum 0x5fb95f99, Offset: 0xa18
// Size: 0x29
function private function_977e49cde3cbd864( player, slot, ref )
{
    thread function_7f67e0f9b0374138( player, slot, ref );
}

// Namespace item_equipment
// Params 1, eflags: 0x4
// Checksum 0xeef0f380, Offset: 0xa49
// Size: 0x14, Type: bool
function private function_c152184acb935c40( ref )
{
    return ref == "equip_c4";
}

// Namespace item_equipment
// Params 3, eflags: 0xc
// Checksum 0x57840857, Offset: 0xa66
// Size: 0xda
function private function_7f67e0f9b0374138( player, slot, ref )
{
    self notify( #"hash_82e33c81d4ddff6c" );
    self endon( #"hash_82e33c81d4ddff6c" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( level.gametypebundle.var_fc1320d238ceacf7 )
    {
        if ( function_c152184acb935c40( ref ) )
        {
            return;
        }
        
        while ( player isthrowinggrenade() || player isgestureplaying() )
        {
            waitframe();
        }
        
        currentref = equipment_mp::getcurrentequipment( slot );
        bundle = equipment_mp::function_c90a9aa89b223dd7( currentref );
        
        if ( currentref == ref )
        {
            if ( player vehicle::is_in_vehicle() && bundle.var_68fab76d8d8dc6ce )
            {
                return;
            }
            
            player equipment_mp::takeequipment( slot );
        }
    }
}

