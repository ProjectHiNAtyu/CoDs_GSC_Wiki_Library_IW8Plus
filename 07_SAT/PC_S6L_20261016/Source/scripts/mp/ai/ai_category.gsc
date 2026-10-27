// scripts\mp\ai\ai_category.gsc  (hash_14003b3684e50190.gscc) (size: 1891 Bytes / 0x763 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfeede578 (4277003640)
// size ...... 1891 (0x763)
// includes .. 0   (offset: 0x763)
// strings ... 0   (offset: 0x763)
// dev strs .. 0   (offset: 0x763)
// exports ... 11  (offset: 0x483)
// cseg ...... 0x58 + 0x42b (0x483)
// imports ... 10  (offset: 0x63b)
// animtree1 . 0   (offset: 0x763)
// animtree2 . 0   (offset: 0x763)
#namespace ai_category;

// Namespace ai_category
// Params 1
// Checksum 0x4bb6d13c, Offset: 0x76
// Size: 0x4f
function function_e6e323e14b12152e( enemy )
{
    killtype = function_ea92743bd5b0d5ec( enemy );
    
    if ( killtype != #"unknown" )
    {
        return killtype;
    }
    
    kiaevent = enemy.kiastring;
    return function_8fa8f5e4f2f44342( kiaevent );
}

// Namespace ai_category
// Params 1
// Checksum 0xc4b5c754, Offset: 0xce
// Size: 0x4c, Type: bool
function function_4c80eeabb07939c1( kiaevent )
{
    enemycategory = function_8fa8f5e4f2f44342( kiaevent );
    return enemycategory == #"elite" || enemycategory == #"hvt" || enemycategory == #"boss";
}

// Namespace ai_category
// Params 1
// Checksum 0x48282b14, Offset: 0x123
// Size: 0x2c, Type: bool
function function_76252ef8d8fa6517( kiaevent )
{
    enemycategory = function_8fa8f5e4f2f44342( kiaevent );
    return enemycategory == #"special";
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0x69a1ae02, Offset: 0x158
// Size: 0xac
function private function_8fa8f5e4f2f44342( kiaevent )
{
    if ( !isdefined( kiaevent ) )
    {
        return #"unknown";
    }
    
    if ( !isxhash( kiaevent ) )
    {
        assert( 0, kiaevent );
        kiaevent = getxhash( kiaevent );
    }
    
    if ( function_5dbf4f8faf650d96( kiaevent ) )
    {
        return #"normal";
    }
    
    if ( function_91b5a2a1252a6d3b( kiaevent ) )
    {
        return #"advanced";
    }
    
    if ( function_19ecec66a92b2c6( kiaevent ) )
    {
        return #"special";
    }
    
    if ( function_786f64fc312e11a6( kiaevent ) )
    {
        return #"elite";
    }
    
    if ( function_8118ddc033efe230( kiaevent ) )
    {
        return #"boss";
    }
    
    return #"unknown";
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0x3d233685, Offset: 0x20d
// Size: 0x53
function private function_ea92743bd5b0d5ec( enemy )
{
    if ( !isdefined( enemy.aicategory ) )
    {
        return #"unknown";
    }
    
    if ( isxhash( enemy.aicategory ) )
    {
        return enemy.aicategory;
    }
    
    return getxhash( enemy.aicategory );
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0xf1a1354, Offset: 0x269
// Size: 0xb7
function private function_5dbf4f8faf650d96( kiastring )
{
    switch ( kiastring )
    {
        case #"hash_12321caf6868c4":
        case #"vermin_kia":
        case #"rusher_kia":
        case #"armoredzombie_kia":
        case #"sniper_kia":
        case #"mannequin_kia":
        case #"guildbot_kia":
        case #"zombie_kia":
        case #"shielded_kia":
        case #"grenadier_kia":
        case #"parasite_kia":
        case #"soldier_kia":
            return 1;
        default:
            return 0;
    }
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0xaaa9bc7e, Offset: 0x328
// Size: 0xd, Type: bool
function private function_91b5a2a1252a6d3b( kiastring )
{
    return false;
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0x1aed3427, Offset: 0x33e
// Size: 0x9f
function private function_19ecec66a92b2c6( kiastring )
{
    switch ( kiastring )
    {
        case #"hash_e1bee4c99e310fb":
        case #"jugg_kia":
        case #"zombie_kia_special":
        case #"mangler_kia":
        case #"mimic_kia":
        case #"hellhound_kia":
        case #"hash_93feb7481aabde43":
        case #"ghoul_kia":
        case #"shocktroop_kia":
        case #"disciple_kia":
            return 1;
        default:
            return 0;
    }
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0x8c52b0ac, Offset: 0x3e5
// Size: 0x57
function private function_786f64fc312e11a6( kiastring )
{
    switch ( kiastring )
    {
        case #"sniper_hvt_kia":
        case #"zombie_kia_elite":
        case #"hash_dc33f009d8da637a":
        case #"hash_f723bebcd7a6dbc7":
            return 1;
        default:
            return 0;
    }
}

// Namespace ai_category
// Params 1, eflags: 0x4
// Checksum 0x86de7c0e, Offset: 0x444
// Size: 0x3f
function private function_8118ddc033efe230( kiastring )
{
    switch ( kiastring )
    {
        case #"zombie_kia_boss":
        case #"zombie_kia_boss_kala_arm":
            return 1;
        default:
            return 0;
    }
}

