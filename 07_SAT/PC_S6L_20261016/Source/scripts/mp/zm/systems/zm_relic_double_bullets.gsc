// scripts\mp\zm\systems\zm_relic_double_bullets.gsc  (hash_2d10569578747f4c.gscc) (size: 961 Bytes / 0x3c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbb247fe (3149023230)
// size ...... 961 (0x3c1)
// includes .. 3   (offset: 0x391)
// strings ... 0   (offset: 0x3a9)
// dev strs .. 2   (offset: 0x3a9)
// exports ... 6   (offset: 0x199)
// cseg ...... 0x58 + 0x141 (0x199)
// imports ... 9   (offset: 0x289)
// animtree1 . 0   (offset: 0x3c1)
// animtree2 . 0   (offset: 0x3c1)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_double_bullets;

// Namespace zm_relic_double_bullets
// Params 0, eflags: 0x5
// Checksum 0xa30ad1aa, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_bc5ccef015c33ac7", undefined, &init_relic_extra_bullet_cost, undefined );
}

// Namespace zm_relic_double_bullets
// Params 0
// Checksum 0x2ec13f93, Offset: 0x97
// Size: 0xa
function init_relic_extra_bullet_cost()
{
    level thread function_a5ea686cb367cc69();
}

// Namespace zm_relic_double_bullets
// Params 0
// Checksum 0x3396c8e5, Offset: 0xa9
// Size: 0x1c
function function_a5ea686cb367cc69()
{
    zm_relics::register_relic_functions( #"extra_bullet_cost", &function_9ee84d01d9be345d, &function_55ba0801b7e5dcb0 );
}

// Namespace zm_relic_double_bullets
// Params 0
// Checksum 0xbb84559, Offset: 0xcd
// Size: 0x7e
function function_9ee84d01d9be345d()
{
    params = {};
    params.var_786c9fa7547cf486 = level.zm_relic_modifiers[ #"extra_bullet_cost" ].var_c424a3ded13d25ce;
    
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_extra_bullet_cost", params );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_double_bullets
// Params 0
// Checksum 0xb982fb13, Offset: 0x153
// Size: 0x46
function function_55ba0801b7e5dcb0()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_extra_bullet_cost" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x49>" );
    #/
}

