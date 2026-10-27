// scripts\autotests\mp\autotests_utility_challenges.gsc  (hash_61b557d17c1f3277.gscc) (size: 1954 Bytes / 0x7a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x219a3b09 (563755785)
// size ...... 1954 (0x7a2)
// includes .. 2   (offset: 0x6ee)
// strings ... 10  (offset: 0x6fe)
// dev strs .. 0   (offset: 0x7a2)
// exports ... 6   (offset: 0x48a)
// cseg ...... 0x12d + 0x35d (0x48a)
// imports ... 10  (offset: 0x57a)
// animtree1 . 0   (offset: 0x7a2)
// animtree2 . 0   (offset: 0x7a2)
#using scripts\autotests\autotests;
#using scripts\common\ae_utility;

#namespace autotests_utility_challenges;

// Namespace autotests_utility_challenges
// Params 1
// Checksum 0x1ac0153d, Offset: 0x14b
// Size: 0x58
function function_ec5150f285dadced( player )
{
    curweapon = player getcurrentweapon();
    return { #idflags:0, #shitloc:"none", #sweapon:curweapon, #einflictor:player, #eattacker:player };
}

// Namespace autotests_utility_challenges
// Params 3
// Checksum 0xa32c4034, Offset: 0x1ac
// Size: 0x13c
function function_8b505f893e829f0d( player, bitfield, bitname )
{
    playermodifiers = function_75bd15d1eac906f9( player, bitfield );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( ( playermodifiers ? "Succeeded" : "Failed" ) + " to find kill bitfield for " + bitfield, playermodifiers, "scripts/autotests/mp/autotests_utility_challenges.gsc", 29 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_dfeff6d3f5644ccf = ae_utility::function_2d1565a236387b2( getxhash( bitfield ), getxhash( bitname ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could find ae event bit " + bitname, isdefined( var_dfeff6d3f5644ccf ), "scripts/autotests/mp/autotests_utility_challenges.gsc", 33 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( ( isbitset( var_dfeff6d3f5644ccf, playermodifiers ) ? "Succeeded" : "Failed" ) + " to set bit for " + bitfield + " with name " + bitname, isbitset( var_dfeff6d3f5644ccf, playermodifiers ), "scripts/autotests/mp/autotests_utility_challenges.gsc", 35 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace autotests_utility_challenges
// Params 3
// Checksum 0xe4428070, Offset: 0x2f0
// Size: 0xff
function function_563ec914068ea0e6( player, bitfield, bitname )
{
    playermodifiers = function_75bd15d1eac906f9( player, bitfield );
    
    if ( !playermodifiers )
    {
        return;
    }
    
    var_dfeff6d3f5644ccf = ae_utility::function_2d1565a236387b2( getxhash( bitfield ), getxhash( bitname ) );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could find ae event bit " + bitname + "?", isdefined( var_dfeff6d3f5644ccf ), "scripts/autotests/mp/autotests_utility_challenges.gsc", 55 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( ( isbitset( var_dfeff6d3f5644ccf, playermodifiers ) ? "Succeeded" : "Failed" ) + " to set bit for " + bitfield + " with name " + bitname, isbitset( var_dfeff6d3f5644ccf, playermodifiers ), "scripts/autotests/mp/autotests_utility_challenges.gsc", 57 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace autotests_utility_challenges
// Params 2, eflags: 0x4
// Checksum 0xafdcfe6c, Offset: 0x3f7
// Size: 0x5f
function private function_75bd15d1eac906f9( player, bitfield )
{
    cachedmask = 0;
    
    switch ( bitfield )
    {
        case #"hash_7261e53b095a681a":
            cachedmask = player.modifiers[ "mask" ];
            break;
        default:
            break;
    }
    
    return cachedmask;
}

// Namespace autotests_utility_challenges
// Params 2, eflags: 0x4
// Checksum 0x34dfbc8, Offset: 0x45f
// Size: 0x2a
function private isbitset( aebit, value )
{
    mask = 1 << aebit;
    return value & mask;
}

