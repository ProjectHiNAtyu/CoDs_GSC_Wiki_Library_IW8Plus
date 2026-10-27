// scripts\mp\loot\common_item_super.gsc  (hash_05419a3cef3ae9d6.gscc) (size: 8902 Bytes / 0x22c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf859c7ec (4166633452)
// size ...... 8902 (0x22c6)
// includes .. 11  (offset: 0x21b2)
// strings ... 7   (offset: 0x220a)
// dev strs .. 3   (offset: 0x22a2)
// exports ... 25  (offset: 0x122a)
// cseg ...... 0xc5 + 0x1165 (0x122a)
// imports ... 99  (offset: 0x1612)
// animtree1 . 0   (offset: 0x22c6)
// animtree2 . 0   (offset: 0x22c6)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\supers;

#namespace item_super;

// Namespace item_super
// Params 0, eflags: 0x5
// Checksum 0x1c510fc1, Offset: 0xe3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_super", #"common_item", &init_item_super, undefined );
}

// Namespace item_super
// Params 0
// Checksum 0xe81756f0, Offset: 0x10c
// Size: 0x1bd
function init_item_super()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "super" );
    common_item::function_84174b793b5fe9a7( "super", #"use", &use_super );
    common_item::function_84174b793b5fe9a7( "super", #"canautouse", &function_e208cd5f6a9243bd );
    common_item::function_84174b793b5fe9a7( "super", #"getcurrent", &get_current_super );
    common_item::function_84174b793b5fe9a7( "super", #"removecurrent", &remove_current_super );
    common_item::function_84174b793b5fe9a7( "super", #"hash_e8583c899ddff7b", &init_item_scriptable_callback );
    common_item::function_84174b793b5fe9a7( "super", #"hash_f6ad22d767ebd714", &is_super_stackable );
    common_item::function_84174b793b5fe9a7( "super", #"hash_bbbee9a6b48de857", &function_dbdf9c9abd362642 );
    common_item::function_84174b793b5fe9a7( "super", #"database_additem", &function_9bc4f1c0bbfde875 );
    common_item::function_84174b793b5fe9a7( "super", #"hash_2d3b76ff260f2d68", &function_d037c055d259f36d );
    common_item::function_84174b793b5fe9a7( "super", #"hash_88b286fbc68ce7b", &function_20e0f4122e415f1f );
    common_item::function_4b30c091d3b04a25( "zmsuper" );
    common_item::function_84174b793b5fe9a7( "zmsuper", #"use", &use_super );
    common_item::function_84174b793b5fe9a7( "zmsuper", #"canautouse", &function_e208cd5f6a9243bd );
    common_item::function_84174b793b5fe9a7( "zmsuper", #"getcurrent", &get_current_super );
    common_item::function_84174b793b5fe9a7( "zmsuper", #"removecurrent", &remove_current_super );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"on_super_use_finished", &on_super_use_finished );
}

// Namespace item_super
// Params 1
// Checksum 0xec34d665, Offset: 0x2d1
// Size: 0x43
function function_20e0f4122e415f1f( itembundle )
{
    if ( itembundle.subtype == "reward_box" )
    {
        return utility::callsharedfunc( #"super_reward_box", #"hash_121591f26cee3f2b", itembundle );
    }
    
    return common_item::function_e044c3e813daec3a( itembundle );
}

// Namespace item_super
// Params 1
// Checksum 0x8285bc75, Offset: 0x31d
// Size: 0x50
function function_9bc4f1c0bbfde875( itembundlename )
{
    if ( !isdefined( level.var_65446ed3963c7ec ) )
    {
        level.var_65446ed3963c7ec = [];
    }
    
    superref = getscriptbundlefieldvalue( itembundlename, #"ref" );
    
    if ( superref )
    {
        level.var_65446ed3963c7ec[ superref ] = itembundlename;
    }
}

// Namespace item_super
// Params 0
// Checksum 0x8c49fe54, Offset: 0x375
// Size: 0x22, Type: bool
function function_5084cb9d1f6a62f1()
{
    return level.var_cb688bf3bffbe209 || level.gametypebundle.var_7535b4a548b924d8;
}

// Namespace item_super
// Params 1
// Checksum 0xa460cd2f, Offset: 0x3a0
// Size: 0x49
function on_player_spawned( sparams )
{
    if ( !function_5084cb9d1f6a62f1() && isdefined( self.super ) && !level.gametypebundle.var_4711421c232d5c6b )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded() );
    }
}

// Namespace item_super
// Params 4
// Checksum 0xd5b9c4a3, Offset: 0x3f1
// Size: 0x1e3
function use_super( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !function_cf6094e50df8b2a1( itembundle ) )
    {
        return item.count;
    }
    
    super = get_current_super();
    var_b68da4dbbee688f1 = super.count ?? 0;
    var_f342872d44313fa6 = var_b68da4dbbee688f1 + 1;
    superref = level.superglobals.refoverrides[ itembundle.ref ].overrideref ?? itembundle.ref;
    superbundle = supers_mp::function_5ffd3dfa9cc1e8de( superref );
    immediate = 1;
    
    if ( superbundle.isinfinite && level.gametypebundle.var_743495f857f6ad69 )
    {
        immediate = 0;
    }
    
    perkpackage::perkpackage_giveimmediate( superref, undefined, undefined, undefined, immediate );
    
    if ( ( isbrgamemode() || isdmzgamemode() ) && immediate )
    {
        thread function_29fd1dfadda94ad6( superref );
    }
    
    currentref = supers_mp::getcurrentsuperref();
    
    if ( currentref != superref )
    {
        equipment_mp::giveequipment( superref, "super" );
    }
    
    supers_mp::function_35c926889c754091( item, self );
    
    if ( !immediate )
    {
        var_f342872d44313fa6 = 0;
    }
    
    equipment_mp::setequipmentammo( superref, var_f342872d44313fa6 );
    
    if ( itembundle.subtype == "reward_box" )
    {
        utility::callsharedfunc( #"super_reward_box", #"hash_ea0b962830327cec", itembundle, item );
    }
    
    if ( itembundle.var_2b0a27d4be7d298b )
    {
        supers_mp::function_d22e4b5721a063eb();
        supers_mp::function_b8c330b10d1729bb( item.count, "all" );
        
        if ( isbrgamemode() || isdmzgamemode() )
        {
            function_4c6bf43db9f13d3d();
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace item_super
// Params 1, eflags: 0xc
// Checksum 0x4d21444a, Offset: 0x5dd
// Size: 0xb0
function private function_29fd1dfadda94ad6( itemref )
{
    self notify( #"hash_52e8ab8d1d2f2c85" );
    self endon( #"hash_52e8ab8d1d2f2c85" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    currentsuper = supers_mp::getcurrentsuper();
    
    if ( !isdefined( currentsuper ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_perk_package_state", 3 );
    self setclientomnvar( "ui_perk_package_super1", supers_mp::getsuperid( itemref ) );
    thread supers_mp::function_5c28588f733c7388( currentsuper.timeremaining, level.trophy.timeout );
    thread supers_mp::handlesuperuistatechange( 2 );
}

// Namespace item_super
// Params 1
// Checksum 0x4a728c33, Offset: 0x695
// Size: 0x64
function is_super_stackable( newitembundle )
{
    super = get_current_super();
    
    if ( !isdefined( super ) )
    {
        return 0;
    }
    
    var_10c287547af80258 = getscriptbundle( super.name );
    
    if ( var_10c287547af80258.ref != newitembundle.ref )
    {
        return 0;
    }
    
    return function_c797cbc436d674e8( var_10c287547af80258 );
}

// Namespace item_super
// Params 1, eflags: 0x4
// Checksum 0x44ef85a6, Offset: 0x702
// Size: 0x48, Type: bool
function private function_c797cbc436d674e8( itembundle )
{
    super = get_current_super();
    
    if ( !isdefined( super ) )
    {
        return true;
    }
    
    maxcount = common_item::function_5f3f8e423378acd6( itembundle );
    return super.count < maxcount;
}

// Namespace item_super
// Params 1, eflags: 0x4
// Checksum 0xa53b88eb, Offset: 0x753
// Size: 0xdc
function private function_cf6094e50df8b2a1( itembundle )
{
    super = get_current_super();
    currentsuperref = supers_mp::getcurrentsuperref();
    
    if ( !isdefined( super ) )
    {
        if ( !supers_mp::superhastimedusage() )
        {
            if ( supers_mp::issuperinuse() && isdefined( currentsuperref ) )
            {
                var_d1a79d6f77a8a26f = supers_mp::function_5ffd3dfa9cc1e8de( currentsuperref );
                
                if ( isdefined( var_d1a79d6f77a8a26f ) && var_d1a79d6f77a8a26f.var_c0173d56a214d0a9 )
                {
                    return 1;
                }
            }
            
            return !supers_mp::issuperinuse();
        }
        
        return 1;
    }
    
    if ( currentsuperref == itembundle.ref )
    {
        return function_c797cbc436d674e8( itembundle );
    }
    
    if ( supers_mp::issuperinuse() )
    {
        var_f9ea5e53aee4df32 = supers_mp::function_5ffd3dfa9cc1e8de( currentsuperref );
        
        if ( isdefined( var_f9ea5e53aee4df32 ) && var_f9ea5e53aee4df32.var_c0173d56a214d0a9 )
        {
            return 1;
        }
    }
    
    return !supers_mp::issuperinuse();
}

// Namespace item_super
// Params 0
// Checksum 0x50cb5189, Offset: 0x837
// Size: 0x8f
function function_4c6bf43db9f13d3d()
{
    if ( !level.allowsupers )
    {
        supers_mp::superearned();
        return;
    }
    
    var_5a3c88492f192508 = isdefined( self.super.staticdata.useweapon );
    bulletsfired = supers_mp::function_e33f44960be55a1f( 1 );
    var_140160807b4fc9f4 = supers_mp::getsuperpointsneeded();
    pointsreduced = supers_mp::function_88ef58d2fa3e72c0( self.super, var_5a3c88492f192508 ) * bulletsfired * var_140160807b4fc9f4;
    supers_mp::setsuperbasepoints( var_140160807b4fc9f4 - pointsreduced );
}

// Namespace item_super
// Params 4
// Checksum 0x2d8197cc, Offset: 0x8ce
// Size: 0x49, Type: bool
function function_e208cd5f6a9243bd( itembundle, item, autouse, allowswap )
{
    if ( !itembundle.autopickupenabled )
    {
        return false;
    }
    
    return !( supers_mp::issuperready() || supers_mp::issuperinuse() );
}

// Namespace item_super
// Params 1
// Checksum 0x829ed1ae, Offset: 0x920
// Size: 0x112
function get_current_super( params )
{
    ref = supers_mp::getcurrentsuperref();
    
    if ( isdefined( ref ) )
    {
        if ( supers_mp::issuperinuse() )
        {
            superbundle = supers_mp::function_5ffd3dfa9cc1e8de( ref );
            
            if ( !isdefined( superbundle ) || !superbundle.var_c0173d56a214d0a9 )
            {
                return;
            }
        }
        
        name = common_item_database::function_a4f0a21951180013( ref );
        
        if ( isdefined( name ) )
        {
            count = supers_mp::function_6b9f009cbd685872() ?? equipment_mp::getequipmentammo( ref );
            var_82e6f59d88569413 = supers_mp::function_80e360decf364829( supers_mp::function_e48058725c0c163a() );
            
            if ( supers_mp::function_2041e16ed18271bc( params.slot ) && isbrgamemode() )
            {
                count = 1;
            }
            
            durability = var_82e6f59d88569413 ?? supers_mp::function_9e6dc95ca52d8e3f();
            durability = durability == 0 ? undefined : durability;
            return { #durability:durability, #count:count, #ref:ref, #name:name };
        }
    }
}

// Namespace item_super
// Params 2
// Checksum 0xad602356, Offset: 0xa3b
// Size: 0x89
function function_dbdf9c9abd362642( params, var_8fb8e1fb220cca48 )
{
    var_9eefcc4457251a8c = params.count ?? var_8fb8e1fb220cca48.count;
    
    if ( params.var_eb659d64b0476d5c === var_8fb8e1fb220cca48.ref || isdefined( var_8fb8e1fb220cca48.durability ) && isdefined( params.count ) && !params.isdrop )
    {
        var_9eefcc4457251a8c = 1;
    }
    
    return var_9eefcc4457251a8c;
}

// Namespace item_super
// Params 1
// Checksum 0xb6fb42f4, Offset: 0xacd
// Size: 0x43
function function_29d00f616a50acca( slot )
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( !isdefined( self.var_b998ed8037cc3462 ) )
    {
        self.var_b998ed8037cc3462 = [];
    }
    
    self.var_b998ed8037cc3462[ slot ] = 1;
}

// Namespace item_super
// Params 1
// Checksum 0x27223a03, Offset: 0xb18
// Size: 0x40
function function_56f77a921662306c( slot )
{
    assert( isplayer( self ), "<dev string:x4c>" );
    assert( self.var_b998ed8037cc3462, "<dev string:x74>" );
    self.var_b998ed8037cc3462[ slot ] = undefined;
}

// Namespace item_super
// Params 2
// Checksum 0x782562d2, Offset: 0xb60
// Size: 0x2a1
function remove_current_super( params, dontclear )
{
    var_8fb8e1fb220cca48 = get_current_super( params );
    
    if ( var_8fb8e1fb220cca48 )
    {
        if ( supers_mp::function_2041e16ed18271bc( params.slot ) && isbrgamemode() && !level.gametypebundle.var_cc52d9f5f6cd611c )
        {
            return { #durability:0, #actualcount:0, #count:0, #itembundlename:var_8fb8e1fb220cca48.name };
        }
        
        var_9eefcc4457251a8c = function_dbdf9c9abd362642( var_8fb8e1fb220cca48, params );
        newcount = maxint( var_8fb8e1fb220cca48.count - var_9eefcc4457251a8c, 0 );
        countremoved = maxint( var_8fb8e1fb220cca48.count - newcount, 0 );
        ref = supers_mp::getcurrentsuperref();
        
        if ( newcount == 0 )
        {
            supers_mp::function_78d95dc7f8d14c64( supers_mp::function_e48058725c0c163a() );
            supers_mp::setsuperbasepoints( 0, 0, params.slot );
            var_4b90a9fdd7e0f710 = self.var_b998ed8037cc3462 && self.var_b998ed8037cc3462[ params.slot ];
            
            if ( !dontclear && !var_4b90a9fdd7e0f710 )
            {
                fieldupgrade1 = params.slot == #"tactical" ? self.overridefieldupgrade1 : undefined;
                fieldupgrade2 = params.slot == #"tactical" ? undefined : self.overridefieldupgrade2;
                perkpackage::perkpackage_giveoverridefieldupgrades( fieldupgrade1, fieldupgrade2 );
                supers_mp::clearsuper( undefined, undefined, undefined, params.slot );
            }
        }
        else
        {
            equipment_mp::setequipmentammo( ref, newcount );
            
            if ( isdefined( var_8fb8e1fb220cca48.durability ) )
            {
                supers_mp::function_78d95dc7f8d14c64( supers_mp::function_e48058725c0c163a() );
                durability = supers_mp::function_80e360decf364829( supers_mp::function_e48058725c0c163a() );
                supers_mp::function_b8c330b10d1729bb( durability, "all" );
            }
        }
    }
    
    var_42698d12fe8d2dd9 = var_8fb8e1fb220cca48.durability ?? countremoved;
    actualcount = isdefined( var_8fb8e1fb220cca48.durability ) ? countremoved : undefined;
    return { #name:var_8fb8e1fb220cca48.name, #durability:var_42698d12fe8d2dd9, #actualcount:actualcount, #count:var_42698d12fe8d2dd9, #itembundlename:var_8fb8e1fb220cca48.name };
}

// Namespace item_super
// Params 1
// Checksum 0x32d93018, Offset: 0xe0a
// Size: 0xb5
function on_super_use_finished( sparams )
{
    if ( !common_inventory::inventory_isenabled() )
    {
        return;
    }
    
    self endon( #"disconnect" );
    var_eee83410cdd14455 = function_6b242c6234d165fb();
    
    if ( !var_eee83410cdd14455 )
    {
        return;
    }
    
    super = get_current_super();
    
    if ( isdefined( super ) && super.count > 1 )
    {
        function_29fd1dfadda94ad6( super.ref );
        self.var_33129007db246c94 = 1;
        return;
    }
    
    if ( !function_5084cb9d1f6a62f1() )
    {
        dontclear = level.gametypebundle.var_55fb9b892515fb1a;
        remove_current_super( sparams, dontclear );
    }
}

// Namespace item_super
// Params 0, eflags: 0x4
// Checksum 0x879b1475, Offset: 0xec7
// Size: 0x3d, Type: bool
function private function_6b242c6234d165fb()
{
    self endon( #"remove_super" );
    superinfo = supers_mp::getcurrentsuper();
    
    while ( issameweapon( self getheldoffhand(), superinfo.weaponobj ) )
    {
        waitframe();
    }
    
    return true;
}

// Namespace item_super
// Params 1
// Checksum 0x2da18a3a, Offset: 0xf0d
// Size: 0x5a
function function_ea946b46f6cd671f( superref )
{
    scriptable = common_item::function_70d4affb770e8103( superref );
    item = spawnstruct();
    item.type = scriptable;
    item.count = common_item::function_598dd39282efb544( 1 );
    common_item::function_2b5e2ff57d5f392( item, 0 );
}

// Namespace item_super
// Params 4, eflags: 0x4
// Checksum 0xe6c7db22, Offset: 0xf6f
// Size: 0x32
function private init_item_scriptable_callback( player, item, itembundle, spawnoptions )
{
    player supers_mp::function_bfbe7cd057368e6e( itembundle, item );
}

// Namespace item_super
// Params 5, eflags: 0x4
// Checksum 0x6dab717f, Offset: 0xfa9
// Size: 0x3e
function private function_d037c055d259f36d( index, itembundle, lootid, quantity, fromgroup )
{
    thread function_8dc661192e2c4571( index, itembundle, lootid, quantity, fromgroup );
}

// Namespace item_super
// Params 5, eflags: 0x4
// Checksum 0x55edcafb, Offset: 0xfef
// Size: 0x23b
function private function_8dc661192e2c4571( index, itembundle, lootid, quantity, fromgroup )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.var_bff7e064af1fd31f )
    {
        return;
    }
    
    self.var_bff7e064af1fd31f = 1;
    weaponname = supers_mp::getsuperweapon( itembundle.ref );
    
    if ( !weaponname )
    {
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ itembundle.ref ];
    
    if ( !staticdata )
    {
        return;
    }
    
    weaponobj = makeweapon( weaponname );
    fromfuncs = common_inventory_groups::function_987405ff5ee23e99( fromgroup );
    
    if ( !fromfuncs.getfunc )
    {
        return;
    }
    
    [ inventorygroup, _ ] = self [[ fromfuncs.var_65a6f7922d118cdd ]]();
    [ fromrow, fromcolumn ] = common_inventory_groups::function_12ee5af12df204b4( inventorygroup, index );
    item = [[ fromfuncs.getfunc ]]( fromrow, fromcolumn, 1 );
    
    if ( !item )
    {
        return;
    }
    
    var_a5bc9c8c270532d1 = isdefined( staticdata.var_49661824f9845c52 );
    
    if ( fromgroup == 2 && !var_a5bc9c8c270532d1 )
    {
        remove_current_super();
    }
    else if ( fromgroup == 1 )
    {
        if ( var_a5bc9c8c270532d1 )
        {
            common_inventory_groups::function_71e4fb4e9d5af271( fromrow, fromcolumn, fromgroup, 2, 1, item );
        }
        else
        {
            originalquantity = common_inventory::inventory_getquantityatbackpackindex( index );
            common_inventory::inventory_setbackpackitematindex( index, lootid, 0 );
        }
    }
    
    result = supers_mp::function_d629c90761cd2a1c( weaponobj, 1 );
    
    if ( var_a5bc9c8c270532d1 && result )
    {
        supers_mp::beginsuperuse();
    }
    else if ( !result )
    {
        if ( fromgroup == 2 || var_a5bc9c8c270532d1 )
        {
            common_item::function_2b5e2ff57d5f392( item, undefined, 0 );
        }
        else
        {
            common_inventory::inventory_setbackpackitematindex( index, lootid, originalquantity, item );
        }
    }
    
    self.var_bff7e064af1fd31f = undefined;
}

