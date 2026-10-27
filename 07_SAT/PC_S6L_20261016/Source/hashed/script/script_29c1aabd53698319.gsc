// script_29c1aabd53698319  (hash_29c1aabd53698319.gscc) (size: 990 Bytes / 0x3de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66eaddcc (1726668236)
// size ...... 990 (0x3de)
// includes .. 3   (offset: 0x39a)
// strings ... 2   (offset: 0x3b2)
// dev strs .. 0   (offset: 0x3de)
// exports ... 5   (offset: 0x202)
// cseg ...... 0x8b + 0x177 (0x202)
// imports ... 7   (offset: 0x2ca)
// animtree1 . 0   (offset: 0x3de)
// animtree2 . 0   (offset: 0x3de)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace specialty_frangible_resist;

// Namespace specialty_frangible_resist
// Params 0, eflags: 0x1
// Checksum 0xd40013d7, Offset: 0xa9
// Size: 0x54
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    utility::registersharedfunc( #"specialty_frangible_resist", #"hash_e03a171fd81a1b93", &function_70148a3b75d48754 );
    utility::registersharedfunc( #"specialty_frangible_resist", #"hash_5a93f6e77e6f2e69", &function_c7b4a2056c63e4a0 );
}

// Namespace specialty_frangible_resist
// Params 1
// Checksum 0xc708e41d, Offset: 0x105
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_frangible_resist", undefined, undefined, [] );
    }
}

// Namespace specialty_frangible_resist
// Params 1
// Checksum 0xf2550a2, Offset: 0x13f
// Size: 0x5c
function function_70148a3b75d48754( time )
{
    if ( isdefined( self.perks[ "specialty_frangible_resist" ] ) )
    {
        if ( isdefined( self.perks[ "specialty_veteran" ] ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
        }
        
        return ( 1 + getdvarfloat( @"hash_cfc1f984f402559f", -0.5 ) );
    }
    
    return 1;
}

// Namespace specialty_frangible_resist
// Params 1
// Checksum 0x463c3384, Offset: 0x1a4
// Size: 0x5d
function function_c7b4a2056c63e4a0( time )
{
    if ( isdefined( self.perks[ "specialty_frangible_resist" ] ) )
    {
        if ( isdefined( self.perks[ "specialty_veteran" ] ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
        }
        
        time *= 1 + getdvarfloat( @"hash_47984606bec7ddf7", -0.5 );
    }
    
    return time;
}

