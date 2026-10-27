// script_113c055774e81279  (hash_113c055774e81279.gscc) (size: 7345 Bytes / 0x1cb1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd704d019 (3607416857)
// size ...... 7345 (0x1cb1)
// includes .. 5   (offset: 0x1bd9)
// strings ... 12  (offset: 0x1c01)
// dev strs .. 2   (offset: 0x1c99)
// exports ... 27  (offset: 0x109d)
// cseg ...... 0x142 + 0xf5b (0x109d)
// imports ... 58  (offset: 0x14d5)
// animtree1 . 0   (offset: 0x1cb1)
// animtree2 . 0   (offset: 0x1cb1)
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_weapon;

#namespace item_weapon;

// Namespace item_weapon
// Params 1
// Checksum 0x948692e8, Offset: 0x160
// Size: 0x3b
function function_63dba3f1cd062a21( player )
{
    if ( !isdefined( level.var_63dba3f1cd062a21 ) )
    {
        level.var_63dba3f1cd062a21 = getdvarint( @"bg_weaponautograboptionsenabled", 0 ) == 1;
    }
    
    return level.var_63dba3f1cd062a21;
}

// Namespace item_weapon
// Params 1
// Checksum 0xbb02cb09, Offset: 0x1a4
// Size: 0x1c, Type: bool
function function_28143f0282865199( player )
{
    return function_63dba3f1cd062a21() && player isautograbweaponsenabled();
}

// Namespace item_weapon
// Params 0
// Checksum 0x795812c3, Offset: 0x1c9
// Size: 0x19
function function_57a0f488d5351461()
{
    if ( function_63dba3f1cd062a21() )
    {
        function_9260a68ef51eadd4();
        function_5e3affd749e81e72();
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x3a4fc668, Offset: 0x1ea
// Size: 0x12
function function_f44a4de9017bc034()
{
    if ( function_63dba3f1cd062a21() )
    {
        thread function_74bf79adac47688();
    }
}

// Namespace item_weapon
// Params 0, eflags: 0x4
// Checksum 0xfe1642fc, Offset: 0x204
// Size: 0x3d
function private function_74bf79adac47688()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"naked_spawn" );
        function_ae9eca5a586c142e();
        function_5e3affd749e81e72();
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0xee2ebc3f, Offset: 0x249
// Size: 0x89
function function_9260a68ef51eadd4()
{
    level.var_ac2570c2ab9eb50c = [];
    var_912d9a16509f33fb = getdvar( @"weapon_class_groups_for_auto_grab_table", "mp/automatism/weapon_class_groups_for_auto_grab.csv" );
    var_9e26a5b4b5f77693 = tablelookupgetnumrows( var_912d9a16509f33fb );
    
    for ( row = 0; row < var_9e26a5b4b5f77693 ; row++ )
    {
        weaponclass = tablelookupbyrow( var_912d9a16509f33fb, row, 0 );
        groupindex = int( tablelookupbyrow( var_912d9a16509f33fb, row, 1 ) );
        level.var_ac2570c2ab9eb50c[ weaponclass ] = groupindex;
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x83562797, Offset: 0x2da
// Size: 0x72
function function_5e3affd749e81e72()
{
    if ( isdefined( level.br_standard_loadout ) )
    {
        weaponslots = [ "Primary", "Secondary", "Tertiary" ];
        
        for ( weaponslot = 0; weaponslot < weaponslots.size ; weaponslot++ )
        {
            level.var_f6580548b0ea50af[ weaponslot ] = function_a05eb1fa34c01cea( level.br_standard_loadout, weaponslot, weaponslots[ weaponslot ] );
        }
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0x17da304e, Offset: 0x354
// Size: 0x127
function function_a05eb1fa34c01cea( loadout, slot, slotstring )
{
    /#
        if ( slot < 0 || slot >= weapon::getslotcount() )
        {
            assertmsg( "<dev string:x24>" + slot + "<dev string:x32>" );
        }
    #/
    
    maxattachments = weapon::getmaxattachments( slot, "wildcard_none" );
    basestring = "loadout" + slotstring;
    
    if ( !isdefined( loadout[ basestring ] ) )
    {
        return;
    }
    
    weaponattachments = [];
    var_17fd4284c6d5b9f = [];
    var_498a24b85741dd03 = basestring + "Attachment";
    var_6627111ff19b06b3 = "";
    
    for ( attachmentindex = 0; attachmentindex < maxattachments ; attachmentindex++ )
    {
        if ( attachmentindex != 0 )
        {
            var_6627111ff19b06b3 = var_498a24b85741dd03 + attachmentindex + 1;
        }
        else
        {
            var_6627111ff19b06b3 = var_498a24b85741dd03;
        }
        
        if ( isdefined( loadout[ var_6627111ff19b06b3 ] ) )
        {
            weaponattachments[ attachmentindex ] = loadout[ var_6627111ff19b06b3 ];
            var_17fd4284c6d5b9f[ attachmentindex ] = 0;
        }
    }
    
    return weapon::buildweapon( loadout[ basestring ], weaponattachments, loadout[ basestring + "Camo" ], loadout[ basestring + "Reticle" ], loadout[ basestring + "VariantID" ], var_17fd4284c6d5b9f );
}

// Namespace item_weapon
// Params 1
// Checksum 0x159d1e8c, Offset: 0x484
// Size: 0x61
function function_bfcc5ad5feb047df( weaponobj )
{
    hasweapon = 0;
    count = level.var_676d872087fa8b61.size;
    
    for ( index = 0; !hasweapon && index < count ; index++ )
    {
        hasweapon = issameweapon( level.var_676d872087fa8b61[ index ], weaponobj );
    }
    
    return hasweapon;
}

// Namespace item_weapon
// Params 2
// Checksum 0xa0cc7510, Offset: 0x4ee
// Size: 0x7f
function function_b587015c9a00ba69( weaponobj, var_cb53d7bc86f9e80d )
{
    baseweaponname = weapon::getweaponrootname( weaponobj );
    count = var_cb53d7bc86f9e80d.size;
    
    for ( index = 0; index < count ; index++ )
    {
        if ( var_cb53d7bc86f9e80d[ index ] == baseweaponname && !function_bfcc5ad5feb047df( weaponobj ) )
        {
            level.var_676d872087fa8b61[ level.var_676d872087fa8b61.size ] = weaponobj;
            break;
        }
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x65804281, Offset: 0x575
// Size: 0x11e
function function_bb1805fd7926c331()
{
    level.var_676d872087fa8b61 = [];
    
    if ( level.usegulag )
    {
        assert( isdefined( level.gulagloadouts ) );
        var_cb53d7bc86f9e80d = [];
        var_1169135bf3093491 = getdvar( @"scr_initial_slot_after_gulag_base_weapons_table", "mp/automatism/initial_slot_after_gulag_base_weapons_table.csv" );
        
        if ( tableexists( var_1169135bf3093491 ) )
        {
            rowscount = tablelookupgetnumrows( var_1169135bf3093491 );
            
            for ( row = 0; row < rowscount ; row++ )
            {
                baseweaponname = tablelookupbyrow( var_1169135bf3093491, row, 0 );
                var_cb53d7bc86f9e80d[ row ] = baseweaponname;
            }
            
            count = level.gulagloadouts.size;
            
            for ( index = 0; index < count ; index++ )
            {
                var_97deed8247c28795 = function_a05eb1fa34c01cea( level.gulagloadouts[ index ], "Primary" );
                var_930ef225c8d6dca5 = function_a05eb1fa34c01cea( level.gulagloadouts[ index ], "Secondary" );
                function_b587015c9a00ba69( var_97deed8247c28795, var_cb53d7bc86f9e80d );
                function_b587015c9a00ba69( var_930ef225c8d6dca5, var_cb53d7bc86f9e80d );
            }
        }
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xf40a86c6, Offset: 0x69b
// Size: 0xff
function function_80e6df5ba3fa18dc( weapon )
{
    var_25277b7be782b566 = 0;
    
    if ( isdefined( level.br_standard_loadout ) )
    {
        if ( !isdefined( level.var_f6580548b0ea50af ) )
        {
            function_5e3affd749e81e72();
        }
        
        foreach ( var_64cecf84ada5fb08 in level.var_f6580548b0ea50af )
        {
            var_25277b7be782b566 = weapon.basename == var_64cecf84ada5fb08.basename;
            
            if ( var_25277b7be782b566 )
            {
                break;
            }
        }
    }
    
    if ( !var_25277b7be782b566 && isdefined( self.gulag ) )
    {
        if ( !isdefined( level.var_676d872087fa8b61 ) )
        {
            function_bb1805fd7926c331();
        }
        
        var_25277b7be782b566 = function_bfcc5ad5feb047df( weapon );
    }
    
    return var_25277b7be782b566;
}

// Namespace item_weapon
// Params 2
// Checksum 0x60be9d9e, Offset: 0x7a3
// Size: 0x6b, Type: bool
function function_ba446b891ce68f75( pickup, weapon )
{
    ammotype = item_ammo::function_b162feeed34a4640( weapon );
    
    if ( isdefined( ammotype ) )
    {
        var_cacf1c338f527afd = item_ammo::function_44b52f17768fb1c6( self, weapon );
        return ( var_cacf1c338f527afd > 0 || pickup.count > 0 || pickup.countlefthand > 0 );
    }
    
    return true;
}

// Namespace item_weapon
// Params 0
// Checksum 0x42412d25, Offset: 0x817
// Size: 0x35
function function_ae9eca5a586c142e()
{
    self.weaponslotblocked = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        self.weaponslotblocked[ i ] = 0;
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0x2f94bdd2, Offset: 0x854
// Size: 0x58
function function_6abda6c351ce2014( slotindex )
{
    slotblocked = 0;
    
    if ( getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        if ( !isdefined( self.weaponslotblocked ) )
        {
            function_ae9eca5a586c142e();
        }
        
        slotblocked = slotindex < 2 && self.weaponslotblocked[ slotindex ];
    }
    
    return slotblocked;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xa8bfc713, Offset: 0x8b5
// Size: 0xd6
function private function_9fbef11aac532591( weaponobj )
{
    var_ec6c1f7f31fbc819 = weapon::ismeleeonly( weaponobj );
    var_6149963298362332 = var_ec6c1f7f31fbc819 ? self.meleeweapons : self.primaryweapons;
    var_92334bd050235d91 = [];
    
    foreach ( var_5c33a9022be9c0a7 in var_6149963298362332 )
    {
        if ( !isnullweapon( var_5c33a9022be9c0a7 ) && !weapon::isbackuppistol( var_5c33a9022be9c0a7 ) )
        {
            var_92334bd050235d91[ var_92334bd050235d91.size ] = var_5c33a9022be9c0a7;
        }
    }
    
    return var_92334bd050235d91;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x187d9460, Offset: 0x994
// Size: 0x2c
function private function_79453a2306e89ca5( weaponobj )
{
    var_ec6c1f7f31fbc819 = weapon::ismeleeonly( weaponobj );
    return var_ec6c1f7f31fbc819 ? 1 : 2;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xcb3e6367, Offset: 0x9c9
// Size: 0x85, Type: bool
function private function_ac044512bbf7e161( weaponobj )
{
    var_92334bd050235d91 = function_9fbef11aac532591( weaponobj );
    freeslots = function_79453a2306e89ca5( weaponobj );
    
    for ( weaponslotindex = 0; weaponslotindex < var_92334bd050235d91.size ; weaponslotindex++ )
    {
        var_5c33a9022be9c0a7 = var_92334bd050235d91[ weaponslotindex ];
        
        if ( !weapon::isfistweapon( var_5c33a9022be9c0a7 ) && ( function_6abda6c351ce2014( weaponslotindex ) || !function_80e6df5ba3fa18dc( var_5c33a9022be9c0a7 ) ) )
        {
            freeslots--;
        }
    }
    
    return freeslots > 0;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x6a3a5810, Offset: 0xa57
// Size: 0x59
function private function_846b2e029c0acc83( weaponobj )
{
    groupindex = level.var_ac2570c2ab9eb50c[ weaponclass( weaponobj.basename ) ];
    priority = self function_572ba997c08260a2( groupindex );
    return { #priority:priority, #groupindex:groupindex };
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xed7beceb, Offset: 0xab9
// Size: 0xef
function private function_16f7f80beb9cae0b( weaponobj )
{
    var_ec6c1f7f31fbc819 = weapon::ismeleeonly( weaponobj );
    
    if ( var_ec6c1f7f31fbc819 )
    {
        return function_ac044512bbf7e161( weaponobj );
    }
    
    var_db02f34dd4f721ee = function_846b2e029c0acc83( weaponobj );
    var_7746e3e9ecf31195 = 0;
    var_92334bd050235d91 = function_9fbef11aac532591( weaponobj );
    
    for ( weaponslotindex = 0; weaponslotindex < var_92334bd050235d91.size ; weaponslotindex++ )
    {
        primaryweaponobj = var_92334bd050235d91[ weaponslotindex ];
        
        if ( function_6abda6c351ce2014( weaponslotindex ) )
        {
            continue;
        }
        
        if ( weapon::isfistweapon( primaryweaponobj ) )
        {
            var_7746e3e9ecf31195 = 1;
        }
        
        var_5af76206ca584edc = function_846b2e029c0acc83( primaryweaponobj );
        
        if ( var_5af76206ca584edc.groupindex == var_db02f34dd4f721ee.groupindex )
        {
            return 0;
        }
        
        if ( var_5af76206ca584edc.priority < var_db02f34dd4f721ee.priority )
        {
            var_7746e3e9ecf31195 = 1;
        }
    }
    
    return var_7746e3e9ecf31195;
}

// Namespace item_weapon
// Params 3
// Checksum 0xee6d642e, Offset: 0xbb1
// Size: 0x213
function function_f8765284c26da663( itembundle, item, weaponobj )
{
    if ( player::isplayerads() || getdvarint( @"hash_9fc90311ef111afd", 0 ) && player::isincombat() )
    {
        return 0;
    }
    
    if ( self.insertingarmorplate )
    {
        return 0;
    }
    
    var_c5e5ae3401f77b2c = self.primaryinventory;
    
    for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
    {
        var_421a8e537d82e2ee = var_c5e5ae3401f77b2c[ i ];
        
        if ( function_5ac30ad8bde2e072( weaponobj, var_421a8e537d82e2ee ) && function_46d840bd6268e2ce( var_421a8e537d82e2ee ) )
        {
            return 0;
        }
    }
    
    var_9ae0005e5a4b0f86 = getdvarint( @"hash_ef63562e5f3b14d0", 0 );
    currenttime = gettime();
    var_7746e3e9ecf31195 = !isdefined( self.var_6a41bd6cabbd5185 ) || currenttime - self.var_6a41bd6cabbd5185 > var_9ae0005e5a4b0f86;
    var_ec6c1f7f31fbc819 = weapon::ismeleeonly( weaponobj );
    
    if ( var_7746e3e9ecf31195 && !var_ec6c1f7f31fbc819 && self function_43828fa3bd1fb0e4() )
    {
        var_7746e3e9ecf31195 = function_ba446b891ce68f75( item, weaponobj );
    }
    
    if ( var_7746e3e9ecf31195 && self function_895629dc2757d1a8() )
    {
        var_7746e3e9ecf31195 = !function_80e6df5ba3fa18dc( weaponobj );
    }
    
    if ( var_7746e3e9ecf31195 )
    {
        if ( self function_cd13a7d9389fc669() )
        {
            var_7746e3e9ecf31195 = function_ac044512bbf7e161( weaponobj );
        }
        else if ( self function_ff17c4599c4c2a1c() )
        {
            var_7746e3e9ecf31195 = function_16f7f80beb9cae0b( weaponobj );
        }
    }
    
    if ( self function_bfe15f18944cd3d9() )
    {
        baseweaponname = weapon::getweaponrootname( weaponobj );
        var_e26d9f1bddd19e27 = 0;
        
        for ( i = 0; !var_e26d9f1bddd19e27 && i < self.primaryweapons.size ; i++ )
        {
            var_31aae3e924108b71 = weapon::getweaponrootname( self.primaryweapons[ i ] );
            
            if ( var_31aae3e924108b71 == baseweaponname )
            {
                playerweaponrarity = function_fb81bd2fe070faa6( self.primaryweapons[ i ] );
                var_a39d1e202dca141d = itembundle.rarity;
                var_e26d9f1bddd19e27 = playerweaponrarity < var_a39d1e202dca141d;
            }
        }
        
        var_7746e3e9ecf31195 = var_e26d9f1bddd19e27;
    }
    
    return var_7746e3e9ecf31195;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x5c906ac7, Offset: 0xdcd
// Size: 0xa3
function private function_d471a74b2963b442( newweapon )
{
    var_92334bd050235d91 = function_9fbef11aac532591( newweapon );
    var_a5cb646476a709ad = undefined;
    
    for ( weaponslotindex = 0; weaponslotindex < var_92334bd050235d91.size ; weaponslotindex++ )
    {
        primaryweaponobj = var_92334bd050235d91[ weaponslotindex ];
        
        if ( function_a9352cb53e91dc48( primaryweaponobj, newweapon ) )
        {
            var_a5cb646476a709ad = primaryweaponobj;
            break;
        }
        
        if ( weapon::isfistweapon( primaryweaponobj ) )
        {
            var_a5cb646476a709ad = primaryweaponobj;
            continue;
        }
        
        if ( !var_a5cb646476a709ad && function_80e6df5ba3fa18dc( primaryweaponobj ) )
        {
            var_a5cb646476a709ad = primaryweaponobj;
        }
    }
    
    return [ function_1464d1c9177c4934( var_a5cb646476a709ad ), var_a5cb646476a709ad ];
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x5ea736f8, Offset: 0xe79
// Size: 0xe2
function private function_478218c16e9d3114( newweapon )
{
    var_ec6c1f7f31fbc819 = weapon::ismeleeonly( newweapon );
    
    if ( var_ec6c1f7f31fbc819 )
    {
        return function_d471a74b2963b442( newweapon );
    }
    
    var_db02f34dd4f721ee = function_846b2e029c0acc83( newweapon );
    var_92334bd050235d91 = function_9fbef11aac532591( newweapon );
    var_a5cb646476a709ad = undefined;
    
    for ( weaponslotindex = 0; weaponslotindex < var_92334bd050235d91.size ; weaponslotindex++ )
    {
        if ( !function_6abda6c351ce2014( weaponslotindex ) )
        {
            primaryweaponobj = var_92334bd050235d91[ weaponslotindex ];
            
            if ( weapon::isfistweapon( primaryweaponobj ) )
            {
                var_a5cb646476a709ad = primaryweaponobj;
            }
            
            weaponclasspriority = function_846b2e029c0acc83( primaryweaponobj );
            
            if ( weaponclasspriority.priority < var_db02f34dd4f721ee.priority )
            {
                var_a5cb646476a709ad = primaryweaponobj;
            }
        }
    }
    
    return [ function_1464d1c9177c4934( var_a5cb646476a709ad ), var_a5cb646476a709ad ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x285d9cc8, Offset: 0xf64
// Size: 0x3c
function function_44ec91a3fb826ea0( newweapon )
{
    if ( self function_cd13a7d9389fc669() )
    {
        return function_d471a74b2963b442( newweapon );
    }
    else if ( self function_ff17c4599c4c2a1c() )
    {
        return function_478218c16e9d3114( newweapon );
    }
    
    return [ undefined, undefined ];
}

// Namespace item_weapon
// Params 2
// Checksum 0xb2fc41d9, Offset: 0xfa9
// Size: 0x83
function function_bad773b9b72597f4( weaponobj, blocked )
{
    if ( !isdefined( self.weaponslotblocked ) )
    {
        function_ae9eca5a586c142e();
    }
    
    weaponcount = min( 2, self.primaryweapons.size );
    
    for ( i = 0; i < weaponcount ; i++ )
    {
        if ( issameweapon( self.primaryweapons[ i ], weaponobj ) )
        {
            self.weaponslotblocked[ i ] = blocked;
            break;
        }
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0xa47b6111, Offset: 0x1034
// Size: 0x68
function function_f8629dd2f572af28( item, player, time )
{
    maxtimekeeping = getdvarint( @"hash_5eff4677b208a6b8", 45000 );
    
    if ( getdvarint( @"hash_1445bea2674012b9", 0 ) )
    {
        return [ 1, maxtimekeeping / 1000 ];
    }
    
    return [ 0, 0 ];
}

