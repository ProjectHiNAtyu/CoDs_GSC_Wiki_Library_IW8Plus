// script_78ccefe0f4e75476  (hash_78ccefe0f4e75476.gscc) (size: 3795 Bytes / 0xed3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a1a21ae (2048532910)
// size ...... 3795 (0xed3)
// includes .. 7   (offset: 0xe47)
// strings ... 5   (offset: 0xe7f)
// dev strs .. 0   (offset: 0xed3)
// exports ... 15  (offset: 0x7eb)
// cseg ...... 0xa4 + 0x747 (0x7eb)
// imports ... 35  (offset: 0xa43)
// animtree1 . 0   (offset: 0xed3)
// animtree2 . 0   (offset: 0xed3)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;

#namespace namespace_d148c146d510ccd8;

// Namespace namespace_d148c146d510ccd8
// Params 0, eflags: 0x1
// Checksum 0xa67d0da8, Offset: 0xc2
// Size: 0x19
function autoexec init()
{
    if ( common_item::items_isenabled() )
    {
        level.init_item_perk_override = &function_7fbefcaff444fcce;
    }
}

// Namespace namespace_d148c146d510ccd8
// Params 0
// Checksum 0x31d4fde1, Offset: 0xe3
// Size: 0x90
function function_7fbefcaff444fcce()
{
    common_item::function_4b30c091d3b04a25( "perk" );
    common_item::function_84174b793b5fe9a7( "perk", #"use", &useperk );
    common_item::function_84174b793b5fe9a7( "perk", #"canautouse", &canautouse );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_9e49dfaa7c147654", &function_b61432f518934c0f );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_2d3b76ff260f2d68", &function_adfb1042da94470f );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_e2da6c78fc49f200", &function_5cf54d96a17a99ed );
}

// Namespace namespace_d148c146d510ccd8
// Params 4
// Checksum 0xbd475981, Offset: 0x17b
// Size: 0x28, Type: bool
function canautouse( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace namespace_d148c146d510ccd8
// Params 4
// Checksum 0x6bdc87fe, Offset: 0x1ac
// Size: 0x31, Type: bool
function useperk( itembundle, item, autouse, var_981c264073bf1154 )
{
    thread perkused( itembundle );
    return false;
}

// Namespace namespace_d148c146d510ccd8
// Params 5, eflags: 0x4
// Checksum 0xae25995e, Offset: 0x1e6
// Size: 0x68
function private function_adfb1042da94470f( index, bundle, lootid, count, fromgroup )
{
    additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( fromgroup, index );
    thread perkused( bundle, additionaldata.var_14173f781428be8b );
    return isdefined( count ) ? count - 1 : 0;
}

// Namespace namespace_d148c146d510ccd8
// Params 5, eflags: 0x4
// Checksum 0x7acbd0a2, Offset: 0x257
// Size: 0x83
function private function_5cf54d96a17a99ed( player, itembundle, item, groupindex, slot )
{
    additionaldata = item.additionaldata ?? common_inventory_groups::function_af51bdd9c1c5acd3( groupindex, slot.index );
    additionaldata.var_14173f781428be8b = gettime();
    common_inventory_groups::function_228fbf34ff2066d7( groupindex, slot.index, additionaldata );
}

// Namespace namespace_d148c146d510ccd8
// Params 2
// Checksum 0xba9c710b, Offset: 0x2e2
// Size: 0x1ab
function perkused( itembundle, var_14173f781428be8b )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    perk = itembundle.ref;
    perkbundle = level.perkbundles[ perk ];
    var_939d17e9f88245bc = isdefined( var_14173f781428be8b ) ? gettime() - var_14173f781428be8b : 0;
    br_analytics::function_9e4ae8c5b22fc08a( self.origin, perk, var_939d17e9f88245bc, perkbundle.duration );
    self notify( "bongo_perk_used_" + perk );
    self endon( "bongo_perk_used_" + perk );
    var_ab181f30bb7e1c4a = isdefined( self.perks[ perk ] ) ? perk : undefined;
    
    if ( !isdefined( self.perks[ perk ] ) )
    {
        perk::giveperk( perk );
        
        if ( !isdefined( self.lootperks ) )
        {
            self.lootperks = [];
        }
        
        self.lootperks[ self.lootperks.size ] = perk;
    }
    
    thread function_173a7a25c20d9891( var_ab181f30bb7e1c4a );
    self playsoundtoplayer( #"hash_14a911826c591f69", self );
    lootid = common_item::function_779887309ec71dfe( itembundle );
    challenges::function_37e945722d6497f3( self, "activate_perk", 1, undefined, lootid );
    utility::waittill_any_in_array_or_timeout( [ "death" ], perkbundle.duration ?? getdvarint( @"hash_90f571cb0e947922", 180 ) );
    
    if ( isdefined( self.perks[ perk ] ) )
    {
        function_e8f7de6823c055cc( perk );
        thread function_173a7a25c20d9891();
        self playsoundtoplayer( #"hash_7c608197352a8120", self );
    }
}

// Namespace namespace_d148c146d510ccd8
// Params 4
// Checksum 0xd78fad53, Offset: 0x495
// Size: 0x29, Type: bool
function function_b61432f518934c0f( itembundle, item, autouse, allowswap )
{
    return true;
}

// Namespace namespace_d148c146d510ccd8
// Params 2
// Checksum 0xd61376ad, Offset: 0x4c7
// Size: 0x7e
function function_e8f7de6823c055cc( perk, removeperkfromplayer = 1 )
{
    if ( isdefined( perk ) && isdefined( self.lootperks ) && arraycontains( self.lootperks, perk ) )
    {
        self.lootperks = arrayremove( self.lootperks, perk );
        
        if ( removeperkfromplayer && isdefined( self.perks[ perk ] ) )
        {
            perk::removeperk( perk );
        }
        
        return 1;
    }
}

// Namespace namespace_d148c146d510ccd8
// Params 0
// Checksum 0x7a50d9d, Offset: 0x54d
// Size: 0xa1
function function_70a5afcd0e05c214()
{
    if ( self.lootperks )
    {
        foreach ( perk in self.lootperks )
        {
            if ( isdefined( self.perks[ perk ] ) )
            {
                perk::removeperk( perk );
            }
        }
    }
    
    self.lootperks = undefined;
}

// Namespace namespace_d148c146d510ccd8
// Params 1
// Checksum 0x8796bdfc, Offset: 0x5f6
// Size: 0x1e
function onplayerdeath( data )
{
    data.victim function_173a7a25c20d9891();
}

// Namespace namespace_d148c146d510ccd8
// Params 0
// Checksum 0x7a31bf90, Offset: 0x61c
// Size: 0xaf
function function_7f245ad6b70c39c9()
{
    var_9d16f7c3b9d75309 = isdefined( self.lootperks ) ? arraycopy( self.lootperks ) : [];
    
    foreach ( perk in var_9d16f7c3b9d75309 )
    {
        if ( !isdefined( self.perks[ perk ] ) )
        {
            var_9d16f7c3b9d75309 = arrayremove( var_9d16f7c3b9d75309, perk );
        }
    }
    
    return var_9d16f7c3b9d75309;
}

// Namespace namespace_d148c146d510ccd8
// Params 1
// Checksum 0x779daddd, Offset: 0x6d4
// Size: 0x64
function function_173a7a25c20d9891( refreshperk )
{
    self endon( #"death_or_disconnect" );
    lootedperks = function_7f245ad6b70c39c9();
    
    if ( refreshperk )
    {
        lootedperks = arrayremove( lootedperks, refreshperk );
    }
    
    packeddata = packperks( lootedperks );
    self setclientomnvar( "ui_br_perks_looted", packeddata );
    
    if ( refreshperk )
    {
        waitframe();
        function_173a7a25c20d9891();
    }
}

// Namespace namespace_d148c146d510ccd8
// Params 1, eflags: 0x4
// Checksum 0xa4882a0c, Offset: 0x740
// Size: 0xaa
function private packperks( perks )
{
    packeddata = 0;
    
    if ( isdefined( perks ) )
    {
        foreach ( perkref in perks )
        {
            perkid = perks::function_6a1d4ff37648a594( perkref );
            
            if ( isdefined( perkid ) )
            {
                packeddata |= 1 << perkid;
            }
        }
    }
    
    return packeddata;
}

