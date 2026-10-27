// scripts\mp\loot\common_item_armor_upgrade.gsc  (hash_6bad4c5b6279bb41.gscc) (size: 6217 Bytes / 0x1849 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93330e51 (2469596753)
// size ...... 6217 (0x1849)
// includes .. 10  (offset: 0x1775)
// strings ... 8   (offset: 0x17c5)
// dev strs .. 1   (offset: 0x183d)
// exports ... 23  (offset: 0xde9)
// cseg ...... 0x12d + 0xcbc (0xde9)
// imports ... 51  (offset: 0x1181)
// animtree1 . 0   (offset: 0x1849)
// animtree2 . 0   (offset: 0x1849)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace common_item_armor_upgrade;

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x5
// Checksum 0xba848440, Offset: 0x14b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_armor_upgrade", #"common_item", &init, undefined );
}

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa069a0bc, Offset: 0x174
// Size: 0x106
function private init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "armor_upgrade" );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"hash_9e49dfaa7c147654", &function_a81a02d94be755da );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"use", &function_303d0568cc79734e );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"getcurrent", &function_2db46c4fb8d3ce0e );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"removecurrent", &function_5e71150683da2d94 );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"hash_bbbee9a6b48de857", &function_68e401d37124f79d );
    common_item::function_84174b793b5fe9a7( "armor_upgrade", #"database_additem", &function_85292bc96b415719 );
    callback::add( #"hash_440e335c78393d75", &function_3bd16ccf9c18f57 );
    utility::registersharedfunc( #"common_item_armor_upgrade", #"repair", &function_d8643825ce5be53d );
    utility::registersharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6", &function_4358f4d5f3960e32 );
}

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x4
// Checksum 0x443c5955, Offset: 0x282
// Size: 0x69
function private function_985e2ae9b059865e()
{
    if ( level.common_item_armor_upgrade.var_c2eeee4b53b1eec6 )
    {
        return;
    }
    
    if ( !isdefined( level.common_item_armor_upgrade ) )
    {
        level.common_item_armor_upgrade = {};
    }
    
    level.common_item_armor_upgrade.var_c2eeee4b53b1eec6 = 1;
    damage::function_3232791951a34daf( &modifydamagetaken );
    damage::function_e91c31c1d200656d( &modifyhittype );
    damage::function_6d459163ecf4555d( &modifydflags );
}

// Namespace common_item_armor_upgrade
// Params 4, eflags: 0x4
// Checksum 0x86438c8c, Offset: 0x2f3
// Size: 0x81, Type: bool
function private function_a81a02d94be755da( itembundle, item, autouse, allowswap )
{
    var_b7446be426d7a5b9 = function_6ff88a6c06e0d683( itembundle.ref );
    var_6c8d6fa014a94cee = function_4358f4d5f3960e32();
    
    if ( var_6c8d6fa014a94cee.var_a0d2f50366f91ac1 && var_6c8d6fa014a94cee.tier >= var_b7446be426d7a5b9.tier )
    {
        return false;
    }
    
    return true;
}

// Namespace common_item_armor_upgrade
// Params 4, eflags: 0x4
// Checksum 0xc0899c6f, Offset: 0x37d
// Size: 0xc1
function private function_303d0568cc79734e( item_bundle, item, autouse, var_981c264073bf1154 )
{
    level function_985e2ae9b059865e();
    
    if ( isdefined( self.armor_upgrade ) )
    {
        assertmsg( "<dev string:x24>" );
        return item.count;
    }
    
    self.armor_upgrade = { #durability:item.count, #name:item_bundle.ref };
    function_28f58bbf059eb2e1();
    
    if ( item_bundle.ref == "wz_consumable_armor_upgrade_level_3" && getdvarint( @"hash_1775711c7d476516", 0 ) )
    {
        perk::giveperk( "specialty_tempered_effect" );
    }
    
    return 0;
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf1b2c502, Offset: 0x447
// Size: 0x75
function private function_2db46c4fb8d3ce0e( params )
{
    if ( isdefined( self.armor_upgrade ) )
    {
        return { #durability:self.armor_upgrade.durability, #count:self.armor_upgrade.durability, #name:common_item_database::function_a4f0a21951180013( self.armor_upgrade.name ) };
    }
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0xdebfd32c, Offset: 0x4c5
// Size: 0xb9
function private function_5e71150683da2d94( params )
{
    var_8e55470971ff753a = function_2db46c4fb8d3ce0e( params );
    var_2b8270f9680da17a = function_4358f4d5f3960e32();
    self.armor_upgrade = undefined;
    function_28f58bbf059eb2e1();
    
    if ( params.spawnoptions.isdeathevent && isdefined( var_8e55470971ff753a ) && !var_2b8270f9680da17a.var_60e53495c3091af9 )
    {
        return;
    }
    
    if ( params.beingreplaced && !var_2b8270f9680da17a.var_160bb77f70ce8c44 )
    {
        return;
    }
    
    return { #count:var_8e55470971ff753a.durability, #name:var_8e55470971ff753a.name };
}

// Namespace common_item_armor_upgrade
// Params 2, eflags: 0x4
// Checksum 0x800c9d30, Offset: 0x587
// Size: 0x17, Type: bool
function private function_68e401d37124f79d( params, var_8fb8e1fb220cca48 )
{
    return true;
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc65c8312, Offset: 0x5a7
// Size: 0xe7
function private function_85292bc96b415719( itembundlename )
{
    if ( !isdefined( level.common_item_armor_upgrade ) )
    {
        level.common_item_armor_upgrade = {};
    }
    
    if ( !isdefined( level.common_item_armor_upgrade.types ) )
    {
        level.common_item_armor_upgrade.types = [];
    }
    
    bundle = getscriptbundlefieldvalues( itembundlename, [ #"ref", #"armorupgrade", #"maxcount" ] );
    level.common_item_armor_upgrade.types[ bundle.ref ] = bundle.armorupgrade;
    level.common_item_armor_upgrade.types[ bundle.ref ].maxdurability = bundle.maxcount;
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf79c0403, Offset: 0x696
// Size: 0x22
function private function_6ff88a6c06e0d683( name )
{
    return level.common_item_armor_upgrade.types[ name ];
}

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x4
// Checksum 0x2830c9c1, Offset: 0x6c1
// Size: 0x1b
function private function_4358f4d5f3960e32()
{
    return function_6ff88a6c06e0d683( self.armor_upgrade.name );
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0x63466f69, Offset: 0x6e5
// Size: 0x70
function private function_7c744128279f1029( damage )
{
    if ( function_4358f4d5f3960e32().var_f732806edba0e368 )
    {
        return;
    }
    
    self.armor_upgrade.durability -= damage;
    
    if ( self.armor_upgrade.durability <= 0 )
    {
        function_5e71150683da2d94();
    }
    
    function_28f58bbf059eb2e1();
}

// Namespace common_item_armor_upgrade
// Params 1
// Checksum 0x8a541a74, Offset: 0x75d
// Size: 0x77
function function_d8643825ce5be53d( amount )
{
    var_6c8d6fa014a94cee = function_4358f4d5f3960e32();
    
    if ( !var_6c8d6fa014a94cee )
    {
        return;
    }
    
    if ( !isdefined( amount ) )
    {
        amount = var_6c8d6fa014a94cee.maxdurability;
    }
    
    self.armor_upgrade.durability = min( self.armor_upgrade.durability + amount, var_6c8d6fa014a94cee.maxdurability );
    function_28f58bbf059eb2e1();
}

// Namespace common_item_armor_upgrade
// Params 11, eflags: 0x4
// Checksum 0xe972fa09, Offset: 0x7dc
// Size: 0x1d7
function private modifydamagetaken( attacker, inflictor, victim, damage, weaponobj, meansofdeath, hitloc, dflags, var_cdd29ad5d1362c2, partname, unmodifieddamage )
{
    if ( !isdefined( victim.armor_upgrade ) )
    {
        return damage;
    }
    
    if ( armor::function_72d28a46c7d67ff6( attacker, victim, weaponobj, meansofdeath, hitloc ) )
    {
        return damage;
    }
    
    var_6c8d6fa014a94cee = victim function_4358f4d5f3960e32();
    
    if ( damage_utility::isheadshot( hitloc, meansofdeath, attacker ) && var_6c8d6fa014a94cee.var_c7e4dd1c64e6c191 )
    {
        return damage;
    }
    
    damagetakenscale = var_6c8d6fa014a94cee.damagetakenscale ?? 1;
    var_d35dfaa71f890f36 = 0;
    var_af2f09ad2b14f4bc = 0;
    
    if ( !var_6c8d6fa014a94cee.var_2110816f22f3360c )
    {
        damagetaken = int( damage * damagetakenscale );
    }
    else
    {
        armorhealth = victim.armorhealth ?? 0;
        
        if ( damagetakenscale == 0 )
        {
            var_d35dfaa71f890f36 = armorhealth == 0 ? 0 : 9223372036854775807;
        }
        else
        {
            var_d35dfaa71f890f36 = int( ceil( armorhealth / damagetakenscale ) );
        }
        
        var_44109a4563bcd15d = min( damage, var_d35dfaa71f890f36 );
        var_af2f09ad2b14f4bc = damage - var_44109a4563bcd15d;
        var_5670ba54ea7d0cca = int( floor( var_44109a4563bcd15d * damagetakenscale ) );
        var_348fffbfe45893bd = var_af2f09ad2b14f4bc;
        damagetaken = var_5670ba54ea7d0cca + var_348fffbfe45893bd;
    }
    
    damageabsorbed = damage - damagetaken;
    
    if ( damageabsorbed > 0 )
    {
        victim function_930fb5f832f5a757( damageabsorbed, var_af2f09ad2b14f4bc > 0 || damage == var_d35dfaa71f890f36 );
        victim function_7c744128279f1029( damageabsorbed );
    }
    
    return damagetaken;
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0x3eb957ad, Offset: 0x9bc
// Size: 0xca
function private function_705d5fed0a031036( id )
{
    squadindex = self.sessionuimemberindex;
    
    if ( squadindex == -1 )
    {
        squadindex = self.var_64f4581741c21af7;
    }
    
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( teammate in teammates )
    {
        teammate setclientomnvar( "ui_armor_upgrade_id_squad_index_" + squadindex, id );
    }
}

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x4
// Checksum 0x52d2932c, Offset: 0xa8e
// Size: 0xa1
function private function_28f58bbf059eb2e1()
{
    callback::callback( #"hash_12899373e61ab1f9", undefined );
    var_6c8d6fa014a94cee = function_4358f4d5f3960e32();
    var_f7b70ab15eeea9e0 = self.armor_upgrade ? common_item::items_getlootidfromref( self.armor_upgrade.name ) : 0;
    self setclientomnvar( "ui_armor_upgrade_id", var_f7b70ab15eeea9e0 );
    function_705d5fed0a031036( var_f7b70ab15eeea9e0 );
    self setclientomnvar( "ui_armor_upgrade_durability", var_6c8d6fa014a94cee ? self.armor_upgrade.durability / var_6c8d6fa014a94cee.maxdurability : 0 );
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0x88a96d85, Offset: 0xb37
// Size: 0x86, Type: bool
function private function_3bd16ccf9c18f57( params )
{
    if ( params.itemdata.entryref != "br_armor_upgrade_repair" )
    {
        return true;
    }
    
    player = params.player;
    var_6c8d6fa014a94cee = player function_4358f4d5f3960e32();
    
    if ( !var_6c8d6fa014a94cee )
    {
        return false;
    }
    
    if ( player.armor_upgrade.durability >= var_6c8d6fa014a94cee.maxdurability )
    {
        return false;
    }
    
    return true;
}

// Namespace common_item_armor_upgrade
// Params 0
// Checksum 0xdd2488d8, Offset: 0xbc6
// Size: 0x27
function function_f27b907473c3182()
{
    if ( self.armor_upgrade_last_hit.time != gettime() )
    {
        return;
    }
    
    return self.armor_upgrade_last_hit;
}

// Namespace common_item_armor_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa816c875, Offset: 0xbf6
// Size: 0xc
function private function_6b4f8cb4f86d2473()
{
    self.armor_upgrade_last_hit = undefined;
}

// Namespace common_item_armor_upgrade
// Params 2, eflags: 0x4
// Checksum 0xaa0164f1, Offset: 0xc0a
// Size: 0x6f
function private function_930fb5f832f5a757( damageabsorbed, var_26f3b5a20f1e75c0 )
{
    self.armor_upgrade_last_hit = structcopy( self.armor_upgrade );
    self.armor_upgrade_last_hit.time = gettime();
    self.armor_upgrade_last_hit.damage_absorbed = damageabsorbed;
    self.armor_upgrade_last_hit.var_49c93de237ddc18d = var_26f3b5a20f1e75c0;
}

// Namespace common_item_armor_upgrade
// Params 2, eflags: 0x4
// Checksum 0xbff68c4c, Offset: 0xc81
// Size: 0xc6
function private modifyhittype( hittype, params )
{
    var_f3df702d52b4be = params.victim function_f27b907473c3182();
    
    if ( !var_f3df702d52b4be )
    {
        return;
    }
    
    didbreak = 0;
    var_6c8d6fa014a94cee = function_6ff88a6c06e0d683( var_f3df702d52b4be.name );
    
    if ( !var_6c8d6fa014a94cee.var_f732806edba0e368 )
    {
        didbreak |= var_f3df702d52b4be.damage_absorbed >= var_f3df702d52b4be.durability;
    }
    
    if ( var_6c8d6fa014a94cee.var_2110816f22f3360c )
    {
        didbreak |= var_f3df702d52b4be.var_49c93de237ddc18d;
    }
    
    return didbreak ? var_6c8d6fa014a94cee.var_b0321037937be14 : var_6c8d6fa014a94cee.var_bfb2584393966856;
}

// Namespace common_item_armor_upgrade
// Params 1, eflags: 0x4
// Checksum 0x3d8be255, Offset: 0xd50
// Size: 0x98
function private modifydflags( params )
{
    var_f3df702d52b4be = params.victim function_f27b907473c3182();
    
    if ( !var_f3df702d52b4be )
    {
        return params.idflags;
    }
    
    var_6c8d6fa014a94cee = function_6ff88a6c06e0d683( var_f3df702d52b4be.name );
    tier = var_6c8d6fa014a94cee.tier;
    
    if ( tier > 0 && tier < 4 )
    {
        return ( params.idflags | tier << 35 );
    }
    
    return params.idflags;
}

