// scripts\mp\loot\common_item_gasmask.gsc  (hash_76125e8a73a1539c.gscc) (size: 11654 Bytes / 0x2d86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cdc4a0c (1826376204)
// size ...... 11654 (0x2d86)
// includes .. 16  (offset: 0x2b36)
// strings ... 28  (offset: 0x2bb6)
// dev strs .. 0   (offset: 0x2d86)
// exports ... 32  (offset: 0x18e6)
// cseg ...... 0x297 + 0x164f (0x18e6)
// imports ... 112 (offset: 0x1de6)
// animtree1 . 0   (offset: 0x2d86)
// animtree2 . 0   (offset: 0x2d86)
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_headgear;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\execution;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\operator;

#namespace item_gasmask;

// Namespace item_gasmask
// Params 0, eflags: 0x5
// Checksum 0x9d68940d, Offset: 0x2b5
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_gasmask", #"common_item", &init_item_gasmask, undefined );
}

// Namespace item_gasmask
// Params 0
// Checksum 0x8581f44d, Offset: 0x2de
// Size: 0x2ca
function init_item_gasmask()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.var_548004405d16dcf8 = &gasmaskon;
    level.var_7518fcc73a6d4676 = &gasmaskoff;
    level.var_54435197068ab340 = &breakgasmask;
    level.var_86b2744d03f868ae = getdvarint( @"hash_41e94c252e1d9247", 1 );
    level.var_4b60a7229234fbc6 = getdvarint( @"hash_e04e2774c39ed0d1", 1 );
    level.var_c623a0da9f4c58f4 = getdvarfloat( @"hash_27f5f1d2bc0ef94c", 0.75 );
    level.var_f429e096d2187a8 = common_item::items_getlootidfromref( "gas_mask" );
    level.var_3ac157c668b1a0e9 = common_item::items_getlootidfromref( "gas_mask_durable" );
    level.var_87429588d071cc8b = common_item::items_getlootidfromref( "rex_gas_mask" );
    level.var_dbcd91101e428c5c = common_item::items_getlootidfromref( "rex_gas_mask_durable" );
    level.hazmatlootid = common_item::items_getlootidfromref( "rex_loot_hazmat_suit" );
    level.var_6a8b6f867f6e7ad4 = [ level.var_f429e096d2187a8, level.var_3ac157c668b1a0e9, level.hazmatlootid, level.var_dbcd91101e428c5c, level.var_87429588d071cc8b ];
    level.droppedgasmasks = [];
    utility::registersharedfunc( #"gasmask", #"breakgasmask", &breakgasmask );
    utility::registersharedfunc( #"gasmask", #"hash_59aa8233cd359656", &function_219547e563ff9527 );
    utility::registersharedfunc( #"gasmask", #"hash_4750baa59df72a2a", &function_a22d30f46052d3b3 );
    utility::registersharedfunc( #"gasmask", #"equipgasmask", &equipgasmask );
    utility::registersharedfunc( #"gasmask", #"removegasmask", &removegasmask );
    
    if ( isbrgamemode() )
    {
        level.var_c7bf4af6240a235 = getdvarint( @"hash_f221cc8f9519efe", 1 );
        level.var_23f1c56f4e75eabc = 1;
        thread gasmask::function_a6b8d9d080e2e59a();
        
        if ( !level.br_circle_disabled )
        {
            br_circle::registercirclecallbacks( 20, &gasmaskdangercircletick, &function_c84a503f674003e0 );
        }
    }
    
    common_item::function_4b30c091d3b04a25( "gasmask" );
    common_item::function_84174b793b5fe9a7( "gasmask", #"use", &use_gasmask );
    common_item::function_84174b793b5fe9a7( "gasmask", #"canautouse", &function_a8a9d2240e009d6b );
    common_item::function_84174b793b5fe9a7( "gasmask", #"getcurrent", &get_current_gasmask );
    common_item::function_84174b793b5fe9a7( "gasmask", #"removecurrent", &remove_current_gasmask );
    common_item::function_84174b793b5fe9a7( "gasmask", #"hash_2cc40f197e06aed7", &function_b98d8380e9b23f43 );
    common_item::function_84174b793b5fe9a7( "gasmask", #"hash_bbbee9a6b48de857", &function_9adcdfccd5ef600 );
}

// Namespace item_gasmask
// Params 4
// Checksum 0xe5592e41, Offset: 0x5b0
// Size: 0x109, Type: bool
function use_gasmask( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( level.var_83525e0328004d3f )
    {
        br_headgear::initheadgear( "gas_mask", self, item.count, itembundle.ref, itembundle.maxcount );
        
        if ( br_headgear::function_f95a396894b1ddad( "gas_mask" ) )
        {
            br_headgear::headgearon( "gas_mask", "all" );
        }
    }
    else
    {
        gasmask::init( item.count, itembundle.ref, itembundle.maxcount );
    }
    
    level.droppedgasmasks = arrayremove( level.droppedgasmasks, item );
    
    if ( hasomnvar( "ui_loadout_gear_index" ) && common_inventory_groups::inventorygroup_enabled() )
    {
        index = common_item::function_4af7d245e50939e7( "LOADOUT_GEAR", itembundle );
        
        if ( isdefined( index ) )
        {
            self setclientomnvar( "ui_loadout_gear_index", index + 1 );
        }
    }
    
    return false;
}

// Namespace item_gasmask
// Params 4
// Checksum 0x20585b6d, Offset: 0x6c2
// Size: 0x49, Type: bool
function function_a8a9d2240e009d6b( itembundle, item, autouse, allowswap )
{
    if ( !itembundle.autopickupenabled )
    {
        return false;
    }
    
    if ( isdefined( self.gasmaskhealth ) )
    {
        return false;
    }
    
    return true;
}

// Namespace item_gasmask
// Params 4
// Checksum 0x4b8e2905, Offset: 0x714
// Size: 0x85
function function_b98d8380e9b23f43( scriptable, count, positioningresults, spawnoptions )
{
    item = spawnscriptable( scriptable, positioningresults.finalorigin, positioningresults.finalangles, undefined, positioningresults.payload, spawnoptions.payload );
    level.droppedgasmasks = arraycombineunique( level.droppedgasmasks, [ item ] );
    return item;
}

// Namespace item_gasmask
// Params 2
// Checksum 0x931aa995, Offset: 0x7a2
// Size: 0x17, Type: bool
function function_9adcdfccd5ef600( params, var_8fb8e1fb220cca48 )
{
    return true;
}

// Namespace item_gasmask
// Params 0
// Checksum 0xdfa675b7, Offset: 0x7c2
// Size: 0x63
function function_a07752441db6bdf8()
{
    gasmask = self;
    level endon( #"game_ended" );
    gasmask endon( #"death" );
    gasmask setscriptablepartstate( gasmask.type, "death" );
    wait 1;
    level.droppedgasmasks = arrayremove( level.droppedgasmasks, gasmask );
    thread common_item::function_869d7676e359a627( gasmask );
}

// Namespace item_gasmask
// Params 1
// Checksum 0x2bcb74fa, Offset: 0x82d
// Size: 0x8a
function get_current_gasmask( params )
{
    if ( gasmask::hasgasmask( self ) && isdefined( self.gasmasktype ) )
    {
        name = common_item_database::function_a4f0a21951180013( self.gasmasktype );
        
        if ( isdefined( name ) )
        {
            return { #dontdrop:self.gasmaskhealth <= 0, #durability:self.gasmaskhealth, #count:self.gasmaskhealth, #name:name };
        }
    }
}

// Namespace item_gasmask
// Params 1
// Checksum 0x752f2474, Offset: 0x8c0
// Size: 0x51
function remove_current_gasmask( params )
{
    var_8fb8e1fb220cca48 = get_current_gasmask( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        function_a22d30f46052d3b3();
        
        if ( hasomnvar( "ui_loadout_gear_index" ) && common_inventory_groups::inventorygroup_enabled() )
        {
            self setclientomnvar( "ui_loadout_gear_index", 0 );
        }
    }
    
    return var_8fb8e1fb220cca48;
}

// Namespace item_gasmask
// Params 0
// Checksum 0xa940a3a7, Offset: 0x91a
// Size: 0x1a
function function_a22d30f46052d3b3()
{
    gasmask::function_2c33204ef69a66f3();
    self.gasmaskequipped = 0;
    thread function_592389abf6573ea9();
}

// Namespace item_gasmask
// Params 0, eflags: 0x4
// Checksum 0xc91dd31d, Offset: 0x93c
// Size: 0x1b
function private function_592389abf6573ea9()
{
    self [[ level.var_7518fcc73a6d4676 ]]( "all" );
    gasmask::function_6f9e12e52b89a696();
}

// Namespace item_gasmask
// Params 1
// Checksum 0x61c71514, Offset: 0x95f
// Size: 0x66
function gasmaskon( request )
{
    if ( level.var_83525e0328004d3f )
    {
        br_headgear::headgearon( "gas_mask", request );
        return;
    }
    
    if ( !isdefined( self.var_5152028633daf0fd ) )
    {
        self.var_5152028633daf0fd = [];
    }
    
    if ( isdefined( self.var_5152028633daf0fd[ request ] ) )
    {
        return;
    }
    
    self.var_5152028633daf0fd[ request ] = 1;
    thread function_5f3e51e0c6e0318d();
}

// Namespace item_gasmask
// Params 1
// Checksum 0x6055ed5a, Offset: 0x9cd
// Size: 0xeb
function gasmaskoff( request )
{
    if ( level.var_83525e0328004d3f )
    {
        br_headgear::headgearoff( "gas_mask", request );
        return;
    }
    
    if ( !isdefined( self.var_5152028633daf0fd ) )
    {
        self.var_5152028633daf0fd = [];
    }
    
    if ( request == "all" )
    {
        foreach ( request, data in self.var_5152028633daf0fd )
        {
            self.var_5152028633daf0fd[ request ] = undefined;
        }
        
        thread function_5f3e51e0c6e0318d();
        return;
    }
    
    if ( !isdefined( self.var_5152028633daf0fd[ request ] ) )
    {
        return;
    }
    
    self.var_5152028633daf0fd[ request ] = undefined;
    thread function_5f3e51e0c6e0318d();
}

// Namespace item_gasmask
// Params 0
// Checksum 0x78be67d, Offset: 0xac0
// Size: 0xc7
function function_5f3e51e0c6e0318d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( function_c02d020b802afea4() )
    {
        wait 0.1;
    }
    
    if ( self.gasmaskswapinprogress )
    {
        utility::waittill_notify_or_timeout( "gas_mask_swap_complete", 2 );
        waitframe();
    }
    
    self notify( #"hash_398604150509e77b" );
    self endon( #"hash_398604150509e77b" );
    waittillframeend();
    
    if ( self.gasmaskequipped && ( !isdefined( self.var_5152028633daf0fd ) || !self.var_5152028633daf0fd.size ) )
    {
        thread removegasmask();
        return;
    }
    
    if ( !self.gasmaskequipped && isdefined( self.var_5152028633daf0fd ) && self.var_5152028633daf0fd.size )
    {
        thread equipgasmask();
    }
}

// Namespace item_gasmask
// Params 0
// Checksum 0x7b229b7, Offset: 0xb8f
// Size: 0x55
function function_c02d020b802afea4()
{
    player = self;
    delaygesture = 0;
    delaygesture |= player isreloading();
    delaygesture |= player isthrowinggrenade();
    delaygesture |= player isdiving();
    delaygesture |= player issprintsliding();
    delaygesture |= player player::isplayerads();
    return delaygesture;
}

// Namespace item_gasmask
// Params 0
// Checksum 0x8ed4d793, Offset: 0xbed
// Size: 0x57, Type: bool
function function_1f0e76271f226db2()
{
    player = self;
    preventgesture = 0;
    preventgesture |= player isinfreefall();
    preventgesture |= player isparachuting();
    preventgesture |= player isbasejumpavailable();
    
    if ( level.var_4b60a7229234fbc6 != 0 )
    {
        preventgesture |= player isjumping();
    }
    
    return !preventgesture;
}

// Namespace item_gasmask
// Params 0
// Checksum 0xbec3682e, Offset: 0xc4d
// Size: 0x193
function equipgasmask()
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self playsoundtoplayer( "br_gas_mask_on_plr", self );
    self.gasmaskswapinprogress = 1;
    thread delayedattach( 0.2 );
    var_6b4b79136446cdf5 = self getgestureanimlength( "iw9_vm_ges_gasmask_on" );
    assert( 0.2 < var_6b4b79136446cdf5 );
    
    if ( function_1f0e76271f226db2() )
    {
        thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_on", var_6b4b79136446cdf5 );
    }
    
    self setclientomnvar( "ui_gas_mask", 2 );
    
    if ( self.usinghazmat && !self.var_ef3e6839268b54f6 )
    {
        function_13fef16cc0c2d109( self );
        var_5f4537d178f8a049 = getdvarfloat( @"hash_62171a84e10129ab", 0.35 );
        operator::function_44f7d464da13e4f6( %"rex_yara", %"hash_e0e0787cbdf5110" );
    }
    
    wait var_6b4b79136446cdf5;
    self.gasmaskswapinprogress = 0;
    self notify( #"gas_mask_swap_complete" );
    self.gasmaskequipped = 1;
    white_phosphorus::enableloopingcoughaudiosupression();
    callbackparams = { #masktype:undefined, #player:self };
    callback::callback( #"gasmask_equipped", callbackparams );
    
    if ( !self.var_2f8b6417bc00b4a0 && level.gametypebundle.var_bebdb9b3b6bca6c0 )
    {
        self setsoundsubmix( level.gametypebundle.var_bebdb9b3b6bca6c0 );
    }
    
    operator::function_89e5e91ee0fb0836();
    
    if ( self.gasmaskhealth <= 0 )
    {
        breakgasmask();
    }
}

// Namespace item_gasmask
// Params 0
// Checksum 0xd5532dc0, Offset: 0xde8
// Size: 0x129
function removegasmask()
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.gasmaskequipped )
    {
        return;
    }
    
    var_68db086cce640e68 = self.gasmaskhealth <= 0;
    
    if ( var_68db086cce640e68 )
    {
        function_2c33204ef69a66f3();
    }
    
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_off" );
    thread delayeddetach( 1.3 );
    
    if ( self.usinghazmat && self.var_ef3e6839268b54f6 )
    {
        thread function_a06e306a6418cc7f( self );
    }
    
    if ( function_1f0e76271f226db2() )
    {
        thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
    }
    
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 1 );
    wait fadeouttime;
    self.gasmaskswapinprogress = 0;
    self notify( #"gas_mask_swap_complete" );
    
    if ( level.gametypebundle.var_bebdb9b3b6bca6c0 )
    {
        self clearsoundsubmix( level.gametypebundle.var_bebdb9b3b6bca6c0 );
    }
    
    white_phosphorus::disableloopingcoughaudiosupression();
    operator::setgendersoundcontext();
    
    if ( var_68db086cce640e68 )
    {
        function_6f9e12e52b89a696();
    }
}

// Namespace item_gasmask
// Params 0
// Checksum 0xdde9af24, Offset: 0xf19
// Size: 0xb4
function breakgasmask()
{
    if ( !self.gasmaskequipped )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_crack_plr", self );
    thread delayeddetachbreak( 0.6 );
    operator::setgendersoundcontext();
    self playsoundtoplayer( #"br_gas_mask_depleted_plr", self );
    function_2c33204ef69a66f3();
    function_6f9e12e52b89a696();
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_break" );
    thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_break", fadeouttime );
    self forceplaygestureviewmodel( "ges_magma_gas_mask_on" );
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 3 );
    wait fadeouttime;
    self.gasmaskswapinprogress = 0;
    self notify( #"gas_mask_swap_complete" );
    function_219547e563ff9527();
}

// Namespace item_gasmask
// Params 0
// Checksum 0x227ed9da, Offset: 0xfd5
// Size: 0x62
function function_417db22e0343b00a()
{
    if ( !self.gasmaskequipped )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_crack_plr", self );
    operator::setgendersoundcontext();
    
    if ( level.gametypebundle.var_bebdb9b3b6bca6c0 )
    {
        self clearsoundsubmix( level.gametypebundle.var_bebdb9b3b6bca6c0 );
    }
    
    self playsoundtoplayer( #"br_gas_mask_depleted_plr", self );
}

// Namespace item_gasmask
// Params 1
// Checksum 0x15749fe7, Offset: 0x103f
// Size: 0x74
function delayedattach( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    if ( !self.gasmaskattached )
    {
        self attach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskattached = 1;
    }
    
    wait 0.5;
    
    if ( !level.var_23f1c56f4e75eabc )
    {
        gasmask::createoverlay();
    }
}

// Namespace item_gasmask
// Params 1
// Checksum 0x4ef4e5b3, Offset: 0x10bb
// Size: 0xa1
function delayeddetach( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    wait 0.35;
    
    if ( !level.var_23f1c56f4e75eabc )
    {
        gasmask::destroyoverlay();
    }
    
    self notify( #"detach_gasmask" );
    self endon( #"detach_gasmask" );
    
    if ( delaytime > 0.35 )
    {
        wait delaytime - 0.35;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.gasmaskattached )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskattached = undefined;
    }
    
    self.gasmaskequipped = 0;
}

// Namespace item_gasmask
// Params 1
// Checksum 0x4a1b0cd7, Offset: 0x1164
// Size: 0x99
function delayeddetachbreak( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    gasmask::destroyoverlay();
    
    if ( delaytime > 0.1 )
    {
        wait delaytime - 0.1;
    }
    
    self notify( #"detach_gasmask" );
    self endon( #"detach_gasmask" );
    wait 0.1;
    
    if ( self.gasmaskequipped )
    {
        if ( self.gasmaskattached )
        {
            self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
            self.gasmaskattached = undefined;
        }
        
        self.gasmaskequipped = 0;
    }
}

// Namespace item_gasmask
// Params 0
// Checksum 0x14c05ed0, Offset: 0x1205
// Size: 0x90
function function_219547e563ff9527()
{
    if ( !common_inventory::inventory_isenabled() )
    {
        return;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    restocksuccess = function_b0b8992c3598bcba( level.var_3ac157c668b1a0e9 );
    
    if ( !restocksuccess )
    {
        restocksuccess = function_b0b8992c3598bcba( level.var_f429e096d2187a8 );
    }
    
    if ( !restocksuccess )
    {
        restocksuccess = function_b0b8992c3598bcba( level.var_dbcd91101e428c5c );
    }
    
    if ( !restocksuccess )
    {
        restocksuccess = function_b0b8992c3598bcba( level.var_87429588d071cc8b );
    }
    
    if ( !restocksuccess )
    {
        restocksuccess = function_b0b8992c3598bcba( level.hazmatlootid );
    }
}

// Namespace item_gasmask
// Params 1
// Checksum 0x7a6dbcd, Offset: 0x129d
// Size: 0x5c, Type: bool
function function_b0b8992c3598bcba( targetlootid )
{
    backpacksize = common_inventory::function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = common_inventory::inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == targetlootid )
        {
            common_inventory::inventory_equipbackpackitem( i );
            return true;
        }
    }
    
    return false;
}

// Namespace item_gasmask
// Params 0
// Checksum 0xdb2b488e, Offset: 0x1302
// Size: 0x13
function function_2c33204ef69a66f3()
{
    gasmask::function_2c33204ef69a66f3();
    self.headgearrequests = undefined;
}

// Namespace item_gasmask
// Params 0
// Checksum 0x7336509a, Offset: 0x131d
// Size: 0x21
function function_6f9e12e52b89a696()
{
    gasmask::function_6f9e12e52b89a696();
    
    if ( level.var_83525e0328004d3f )
    {
        self setclientomnvar( "ui_gas_mask_opacity_override", 0 );
    }
}

// Namespace item_gasmask
// Params 3
// Checksum 0x134fcbbc, Offset: 0x1346
// Size: 0x275
function gasmaskdangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    circleradiussquared = dangercircleradius * dangercircleradius;
    circleindex = level.br_circle.circleindex;
    
    if ( circleindex > level.br_circle.damagetick.size - 1 )
    {
        circleindex = level.br_circle.damagetick.size - 1;
    }
    
    damagetick = level.br_circle.damagetick[ circleindex ];
    
    if ( isdefined( level.circledamagemultiplier ) )
    {
        damagetick *= level.circledamagemultiplier;
    }
    
    level.droppedgasmasks = function_5713d46873b29625( level.droppedgasmasks );
    
    foreach ( gasmask in level.droppedgasmasks )
    {
        if ( !isdefined( gasmask ) )
        {
            continue;
        }
        
        if ( gasmask.var_69c7f935014de621 )
        {
            continue;
        }
        
        if ( gasmask.inairpocket )
        {
            continue;
        }
        
        if ( br_circle_util::function_4c6afbf2b757376a( gasmask.origin, 0 ) )
        {
            if ( gasmask getscriptablepartstate( "damage_fx" ) == "active" )
            {
                gasmask setscriptablepartstate( "damage_fx", "inactive" );
            }
            
            continue;
        }
        
        if ( distance2dsquared( gasmask.origin, dangercircleorigin ) > circleradiussquared || br_circle_util::function_4c6afbf2b757376a( gasmask.origin, 1 ) )
        {
            curhealth = common_item::function_974a788b833e282b( gasmask );
            
            if ( level.br_circle.circleindex <= level.var_8939aaad719c1058 )
            {
                damagetick *= float( level.var_a497e1f1038f9d84 );
                newhealth = int( curhealth - damagetick );
            }
            else
            {
                newhealth = int( curhealth - damagetick );
            }
            
            if ( newhealth <= 0 )
            {
                gasmask thread function_a07752441db6bdf8();
                continue;
            }
            
            if ( gasmask gasmask::didgasmaskpipschange( curhealth, newhealth ) )
            {
                gasmask setscriptablepartstate( "damage_fx", "active" );
            }
            
            common_item::items_setitemcount( gasmask, newhealth );
        }
    }
}

// Namespace item_gasmask
// Params 0
// Checksum 0x6061c668, Offset: 0x15c3
// Size: 0x249
function function_c84a503f674003e0()
{
    circleindex = level.br_circle.circleindex;
    
    if ( circleindex > level.br_circle.damagetick.size - 1 )
    {
        circleindex = level.br_circle.damagetick.size - 1;
    }
    
    damagetick = level.br_circle.damagetick[ circleindex ];
    
    if ( isdefined( level.circledamagemultiplier ) )
    {
        damagetick *= level.circledamagemultiplier;
    }
    
    level.droppedgasmasks = function_5713d46873b29625( level.droppedgasmasks );
    
    foreach ( gasmask in level.droppedgasmasks )
    {
        if ( !isdefined( gasmask ) )
        {
            continue;
        }
        
        if ( gasmask.var_69c7f935014de621 )
        {
            continue;
        }
        
        if ( gasmask.inairpocket )
        {
            continue;
        }
        
        if ( br_circle_util::function_4c6afbf2b757376a( gasmask.origin, 0 ) )
        {
            if ( gasmask getscriptablepartstate( "damage_fx" ) == "active" )
            {
                gasmask setscriptablepartstate( "damage_fx", "inactive" );
            }
            
            continue;
        }
        
        if ( !br_circle_util::ispointinmulticircledanger( gasmask.origin ) || br_circle_util::function_4c6afbf2b757376a( gasmask.origin, 1 ) )
        {
            curhealth = common_item::function_974a788b833e282b( gasmask );
            
            if ( level.br_circle.circleindex <= level.var_8939aaad719c1058 )
            {
                damagetick *= float( level.var_a497e1f1038f9d84 );
                newhealth = int( curhealth - damagetick );
            }
            else
            {
                newhealth = int( curhealth - damagetick );
            }
            
            if ( newhealth <= 0 )
            {
                gasmask thread function_a07752441db6bdf8();
                continue;
            }
            
            if ( gasmask gasmask::didgasmaskpipschange( curhealth, newhealth ) )
            {
                gasmask setscriptablepartstate( "damage_fx", "active" );
            }
            
            common_item::items_setitemcount( gasmask, newhealth );
        }
    }
}

// Namespace item_gasmask
// Params 1
// Checksum 0x85055537, Offset: 0x1814
// Size: 0x80
function function_13fef16cc0c2d109( player )
{
    dstruct = spawnstruct();
    dstruct.executionref = execution::execution_getrefbyplayer( player );
    dstruct.operator = player.operatorcustomization.operatorref;
    dstruct.skin = player.operatorcustomization.skinref;
    player.var_ef3e6839268b54f6 = dstruct;
}

// Namespace item_gasmask
// Params 1
// Checksum 0xa6320e37, Offset: 0x189c
// Size: 0x4a
function function_a06e306a6418cc7f( player )
{
    player operator::function_44f7d464da13e4f6( player.var_ef3e6839268b54f6.operator, player.var_ef3e6839268b54f6.skin );
    player.var_ef3e6839268b54f6 = undefined;
}

