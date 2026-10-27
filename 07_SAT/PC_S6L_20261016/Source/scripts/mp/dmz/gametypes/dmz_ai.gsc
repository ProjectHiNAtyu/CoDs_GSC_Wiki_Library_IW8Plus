// scripts\mp\dmz\gametypes\dmz_ai.gsc  (hash_3974b3af2266f240.gscc) (size: 2101 Bytes / 0x835 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee857d73 (4001725811)
// size ...... 2101 (0x835)
// includes .. 4   (offset: 0x799)
// strings ... 10  (offset: 0x7b9)
// dev strs .. 0   (offset: 0x835)
// exports ... 7   (offset: 0x3c5)
// cseg ...... 0x143 + 0x282 (0x3c5)
// imports ... 24  (offset: 0x4dd)
// animtree1 . 0   (offset: 0x835)
// animtree2 . 0   (offset: 0x835)
#using scripts\common\utility;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;

#namespace dmz_ai;

// Namespace dmz_ai
// Params 0
// Checksum 0x6f269510, Offset: 0x161
// Size: 0xd4
function init()
{
    if ( getdvarfloat( @"hash_3545ca86ff96cb37", 0.34 ) != 0 )
    {
        utility::registersharedfunc( #"ai", #"droplootonagentdeath", &ai_loot::droplootonagentdeath );
    }
    
    ai_loot::function_69b4db6b064345dc();
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    setsaveddvar( @"ai_shoulddohesherecallout", 1 );
    function_303d9de75f8fd9da( 1 );
    level thread function_f41cc2658fd4e591();
    level thread function_8cf85e9dc78419ad();
    level._effect[ "vfx_gameplay_tier2_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier2_helmet_pop" );
    level._effect[ "vfx_gameplay_tier3_helmet_pop" ] = loadfxasset( "vfx_iw9_gameplay_mp_tier3_helmet_pop" );
    utility::registersharedfunc( #"ai", #"hash_20c2ab7ea23d2e1e", &overrideagent );
}

// Namespace dmz_ai
// Params 0
// Checksum 0x8f99574a, Offset: 0x23d
// Size: 0x38
function function_f41cc2658fd4e591()
{
    waittime = getdvarint( @"hash_ba0cc4a1f73de4c", 10 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    ai_mp_controller::function_7415f2b98f305b24( 0 );
    ai_mp_controller::function_37d99639a8500c2f( 1 );
}

// Namespace dmz_ai
// Params 0
// Checksum 0x796a0b51, Offset: 0x27d
// Size: 0x2e
function function_8cf85e9dc78419ad()
{
    waittime = getdvarint( @"hash_e1b4b41af9d69b3b", 15 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    ai_mp_controller::function_e61fc070bb8a111e();
}

// Namespace dmz_ai
// Params 0, eflags: 0x4
// Checksum 0xd10c76fc, Offset: 0x2b3
// Size: 0x1b
function private overrideagent()
{
    if ( !isdefined( self.tier ) )
    {
        return;
    }
}

// Namespace dmz_ai
// Params 0
// Checksum 0x89a4c684, Offset: 0x349
// Size: 0x3a, Type: bool
function function_fb0f68f6b97f7f6c()
{
    assert( isagent( self ) );
    return utility::callsharedfunc( #"wolf", #"iswolf" ) || self.unittype == "dog";
}

// Namespace dmz_ai
// Params 0
// Checksum 0xa5ae6d6e, Offset: 0x38c
// Size: 0x38, Type: bool
function isfriendly()
{
    assert( isagent( self ) );
    return isdefined( self.classname ) && isalive( self ) && issubstr( self.classname, "ally" );
}

