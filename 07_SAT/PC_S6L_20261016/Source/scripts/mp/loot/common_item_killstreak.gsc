// scripts\mp\loot\common_item_killstreak.gsc  (hash_281f743dd62ba3d7.gscc) (size: 4772 Bytes / 0x12a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0450b0e (3225750286)
// size ...... 4772 (0x12a4)
// includes .. 7   (offset: 0x11bc)
// strings ... 9   (offset: 0x11f4)
// dev strs .. 2   (offset: 0x128c)
// exports ... 15  (offset: 0xabc)
// cseg ...... 0x135 + 0x987 (0xabc)
// imports ... 40  (offset: 0xd14)
// animtree1 . 0   (offset: 0x12a4)
// animtree2 . 0   (offset: 0x12a4)
#using scripts\common\system;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_killstreak;

// Namespace item_killstreak
// Params 0, eflags: 0x5
// Checksum 0x60183432, Offset: 0x153
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_killstreak", #"common_item", &init_item_killstreak, undefined );
}

// Namespace item_killstreak
// Params 0
// Checksum 0x2b125db1, Offset: 0x17c
// Size: 0xf5
function init_item_killstreak()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "killstreak" );
    common_item::function_84174b793b5fe9a7( "killstreak", #"use", &use_killstreak );
    common_item::function_84174b793b5fe9a7( "killstreak", #"canautouse", &function_304e314f76418110 );
    common_item::function_84174b793b5fe9a7( "killstreak", #"hash_9e49dfaa7c147654", &can_use_killstreak );
    common_item::function_84174b793b5fe9a7( "killstreak", #"getcurrent", &get_current_killstreak );
    common_item::function_84174b793b5fe9a7( "killstreak", #"removecurrent", &remove_current_killstreak );
    common_item::function_84174b793b5fe9a7( "killstreak", #"hash_f6ad22d767ebd714", &is_killstreak_stackable );
    common_item::function_84174b793b5fe9a7( "killstreak", #"hash_bbbee9a6b48de857", &function_74d5a9db851ea0c9 );
    
    if ( !isdefined( level.var_5c489f2dd81149e9 ) )
    {
        level.var_5c489f2dd81149e9 = common_inventory::inventory_isenabled();
    }
    
    level.deathretainstreaks = 1;
}

// Namespace item_killstreak
// Params 4
// Checksum 0x8d0bd9bd, Offset: 0x279
// Size: 0x1d1
function use_killstreak( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( iskillstreakavailable() )
    {
        var_8fb8e1fb220cca48 = get_current_killstreak();
        
        if ( function_f5e8b104c25141e3( var_8fb8e1fb220cca48, itembundle ) && !itembundle.useCountAsKillstreakAmmo )
        {
            if ( !killstreaks::function_ce0ad321aa7e1461() )
            {
                assertmsg( "<dev string:x24>" );
                return item.count;
            }
            
            newcount = var_8fb8e1fb220cca48.count + 1;
            killstreaks::function_3e9a1bf9f40e3614( 1, newcount );
            return ( item.count - 1 );
        }
        
        if ( function_12f628d536965d9() )
        {
            self notify( #"hash_9594de332bd9c38c", "weapon_change" );
        }
        
        if ( item.var_9d84756796dfbd69 )
        {
            spawnoptions = var_981c264073bf1154;
            
            if ( !isdefined( spawnoptions ) )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            }
            
            common_item::function_61c2c0251e742ffd( var_8fb8e1fb220cca48.name, var_8fb8e1fb220cca48.count, spawnoptions );
        }
        
        killstreaks::removekillstreak( 1 );
    }
    
    source = item.loot_source ?? "other";
    blueprintindex = equipment_utility::function_9b440a99b2f01ec9( itembundle.ref );
    killstreaks::awardkillstreak( itembundle.ref, source, undefined, undefined, undefined, 1, blueprintindex, item.var_245b79f81d8bea18 );
    
    if ( itembundle.useCountAsKillstreakAmmo )
    {
        itemcount = common_item::function_974a788b833e282b( item );
        
        if ( isbrgamemode() )
        {
            self setclientomnvar( "ui_br_weapon_streak_ammo", itemcount );
        }
        
        self.pers[ "held_killstreak_init_count" ] = itemcount;
        return 0;
    }
    
    return item.count - 1;
}

// Namespace item_killstreak
// Params 4
// Checksum 0xca572531, Offset: 0x453
// Size: 0x9c, Type: bool
function can_use_killstreak( itembundle, item, autouse, allowswap )
{
    if ( ( isdefined( self.triggeringstreak ) || self.enabledequipdeployvfx || function_12f628d536965d9() ) && self.interactions_disabled )
    {
        return false;
    }
    
    if ( iskillstreakavailable() )
    {
        var_8fb8e1fb220cca48 = get_current_killstreak();
        
        if ( !isdefined( var_8fb8e1fb220cca48 ) )
        {
            assertmsg( "<dev string:xb0>" );
            return false;
        }
        
        if ( !function_f5e8b104c25141e3( var_8fb8e1fb220cca48, itembundle ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace item_killstreak
// Params 4
// Checksum 0xb33529fb, Offset: 0x4f8
// Size: 0x74
function function_304e314f76418110( itembundle, item, autouse, allowswap )
{
    if ( isdefined( self.triggeringstreak ) || self.enabledequipdeployvfx || function_12f628d536965d9() )
    {
        return 0;
    }
    
    if ( iskillstreakavailable() )
    {
        var_8fb8e1fb220cca48 = get_current_killstreak();
        return function_f5e8b104c25141e3( var_8fb8e1fb220cca48, itembundle );
    }
    
    return 1;
}

// Namespace item_killstreak
// Params 1
// Checksum 0xe7548680, Offset: 0x575
// Size: 0x18e
function get_current_killstreak( params )
{
    if ( isdefined( self.streakdata.streaks ) && iskillstreakavailable() )
    {
        streakitem = killstreaks::getkillstreakinslot( 1 );
        ref = streakitem.streakname;
        
        if ( isdefined( ref ) )
        {
            name = common_item_database::function_a4f0a21951180013( ref );
            
            if ( isdefined( name ) )
            {
                useCountAsKillstreakAmmo = getscriptbundlefieldvalue( name, #"useCountAsKillstreakAmmo" );
                itemcount = streakitem.quantity;
                weaponname = streakitem.streaksetupinfo.weaponname;
                
                if ( useCountAsKillstreakAmmo && isdefined( weaponname ) )
                {
                    if ( isdefined( self.pers[ "held_killstreak_init_count" ] ) )
                    {
                        itemcount = self.pers[ "held_killstreak_init_count" ];
                    }
                    else if ( isdefined( self.pers[ "held_killstreak_clip_count" ][ weaponname ] ) && isdefined( self.pers[ "held_killstreak_ammo_count" ][ weaponname ] ) )
                    {
                        itemcount = self.pers[ "held_killstreak_clip_count" ][ weaponname ] + ( self.pers[ "held_killstreak_clip_count_left" ][ weaponname ] ?? 0 ) + ( function_fbb6adbc1a89658a( weaponname ) ? 0 : self.pers[ "held_killstreak_ammo_count" ][ weaponname ] );
                    }
                }
                
                return { #ref:ref, #count:itemcount, #name:name };
            }
        }
    }
}

// Namespace item_killstreak
// Params 1
// Checksum 0x5be42f44, Offset: 0x70c
// Size: 0x218
function remove_current_killstreak( params )
{
    var_8fb8e1fb220cca48 = get_current_killstreak( params );
    countremaining = 0;
    
    if ( var_8fb8e1fb220cca48 )
    {
        if ( params.count )
        {
            countremaining = var_8fb8e1fb220cca48.count - params.count;
        }
        
        var_872f54566a2cfa33 = 0;
        
        if ( countremaining > 0 )
        {
            killstreaks::function_3e9a1bf9f40e3614( 1, countremaining );
        }
        else
        {
            streakitem = self.streakdata.streaks[ 1 ];
            
            if ( streakitem.streakname == self.var_f1883f6e151e0ab.streakname )
            {
                streakinfo = self.var_f1883f6e151e0ab;
            }
            else if ( self.var_ec0bb630fbaa253a[ streakitem.streaksetupinfo.weaponname ] )
            {
                streakinfo = self.var_ec0bb630fbaa253a[ streakitem.streaksetupinfo.weaponname ];
            }
            else if ( streakitem.streakname == self.streakinfo.streakname )
            {
                streakinfo = self.streakinfo;
            }
            
            if ( streakinfo )
            {
                var_872f54566a2cfa33 = !killstreaks::function_8145b006d0b9ee93( streakinfo );
            }
            
            killstreaks::removekillstreak( 1, streakinfo );
            killstreaks::updatekillstreakuislot( 1 );
        }
        
        useCountAsKillstreakAmmo = getscriptbundlefieldvalue( var_8fb8e1fb220cca48.name, "useCountAsKillstreakAmmo" );
        
        if ( useCountAsKillstreakAmmo == 1 )
        {
            return { #var_245b79f81d8bea18:streakinfo.var_245b79f81d8bea18, #count:var_8fb8e1fb220cca48.count, #name:var_8fb8e1fb220cca48.name };
        }
        
        var_42698d12fe8d2dd9 = var_8fb8e1fb220cca48.count - countremaining;
        
        if ( var_872f54566a2cfa33 && var_42698d12fe8d2dd9 > 0 )
        {
            var_42698d12fe8d2dd9 -= 1;
        }
        
        return { #count:var_42698d12fe8d2dd9, #name:var_8fb8e1fb220cca48.name };
    }
    
    return {};
}

// Namespace item_killstreak
// Params 0
// Checksum 0x4feb0deb, Offset: 0x92d
// Size: 0x19, Type: bool
function hasanykillstreak()
{
    return isdefined( self.streakdata.streaks[ 1 ] );
}

// Namespace item_killstreak
// Params 1
// Checksum 0x190096cb, Offset: 0x94f
// Size: 0x2f, Type: bool
function haskillstreak( killstreakref )
{
    return self.streakdata.streaks[ 1 ].streakname == killstreakref;
}

// Namespace item_killstreak
// Params 0
// Checksum 0x16486634, Offset: 0x987
// Size: 0x41, Type: bool
function iskillstreakavailable()
{
    streakitem = self.streakdata.streaks[ 1 ];
    return streakitem.streakname && streakitem.available == 1;
}

// Namespace item_killstreak
// Params 0
// Checksum 0xd3628d84, Offset: 0x9d1
// Size: 0x11
function function_12f628d536965d9()
{
    return killstreak_utility::iskillstreakdeployweapon( self.currentweapon );
}

// Namespace item_killstreak
// Params 2, eflags: 0x4
// Checksum 0x93ea0a09, Offset: 0x9eb
// Size: 0x5d, Type: bool
function private function_f5e8b104c25141e3( currentitem, newitembundle )
{
    if ( !currentitem )
    {
        return true;
    }
    
    if ( currentitem.ref == newitembundle.ref )
    {
        maxcount = common_item::function_38334193bd9b5956( newitembundle );
        return ( currentitem.count < maxcount );
    }
    
    return true;
}

// Namespace item_killstreak
// Params 1
// Checksum 0xbb135cd8, Offset: 0xa51
// Size: 0x4a, Type: bool
function is_killstreak_stackable( newitembundle )
{
    currentitem = get_current_killstreak();
    
    if ( !currentitem || currentitem.ref != newitembundle.ref )
    {
        return false;
    }
    
    return function_f5e8b104c25141e3( currentitem, newitembundle );
}

// Namespace item_killstreak
// Params 2
// Checksum 0xd4d2863c, Offset: 0xaa4
// Size: 0x17, Type: bool
function function_74d5a9db851ea0c9( params, var_8fb8e1fb220cca48 )
{
    return true;
}

