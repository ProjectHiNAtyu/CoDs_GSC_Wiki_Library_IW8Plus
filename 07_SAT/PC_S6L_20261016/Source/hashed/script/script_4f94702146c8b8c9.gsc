// script_4f94702146c8b8c9  (hash_4f94702146c8b8c9.gscc) (size: 2007 Bytes / 0x7d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf96589da (4184181210)
// size ...... 2007 (0x7d7)
// includes .. 4   (offset: 0x733)
// strings ... 8   (offset: 0x753)
// dev strs .. 0   (offset: 0x7d7)
// exports ... 8   (offset: 0x497)
// cseg ...... 0xd0 + 0x3c7 (0x497)
// imports ... 12  (offset: 0x5d7)
// animtree1 . 0   (offset: 0x7d7)
// animtree2 . 0   (offset: 0x7d7)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\magicbox;

#namespace namespace_ad703e086558d464;

// Namespace namespace_ad703e086558d464
// Params 0, eflags: 0x5
// Checksum 0xf6632ed9, Offset: 0xee
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "respin_cycle", #"bgb", &__init__, undefined );
}

// Namespace namespace_ad703e086558d464
// Params 0
// Checksum 0x96fc649f, Offset: 0x113
// Size: 0x39
function __init__()
{
    bgb::register( "respin_cycle", "activated", 1, undefined, undefined, &validation, &activation );
    magicbox::function_1b154b89e87377fa( &function_bf0a20dea694ba5a );
    magicbox::function_cdf03392d756db87( &function_50b499fb02124867 );
}

// Namespace namespace_ad703e086558d464
// Params 0
// Checksum 0xcf1c0077, Offset: 0x154
// Size: 0xc8
function activation()
{
    self endon( #"disconnect" );
    
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( magicbox.var_37f3a4cd8252c9f0 === self && isdefined( magicbox.mdl_current_weapon.interact ) )
        {
            magicbox.mdl_current_weapon.interact notify( #"force_respin" );
        }
    }
}

// Namespace namespace_ad703e086558d464
// Params 0
// Checksum 0x83e4d901, Offset: 0x224
// Size: 0xa0, Type: bool
function validation()
{
    foreach ( magicbox in level.var_1bbb5557537e2c0c )
    {
        if ( magicbox.var_37f3a4cd8252c9f0 === self && isdefined( magicbox.mdl_current_weapon.interact ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_ad703e086558d464
// Params 3
// Checksum 0x319abd77, Offset: 0x2cd
// Size: 0x4a
function function_bf0a20dea694ba5a( player, str_override_rarity, var_4b076b5c2a1741db )
{
    if ( player bgb::is_enabled( "respin_cycle" ) || str_override_rarity != "ultra" && var_4b076b5c2a1741db )
    {
        return level.var_54989577c4e434aa;
    }
}

// Namespace namespace_ad703e086558d464
// Params 2
// Checksum 0xcbda6e0e, Offset: 0x320
// Size: 0x162
function function_50b499fb02124867( player, var_7d1e4a14aabf85b3 )
{
    str_override_rarity = undefined;
    
    if ( var_7d1e4a14aabf85b3 == "force_respin" )
    {
        switch ( self.str_weapon_rarity )
        {
            case #"hash_209fa8900070d83d":
            case #"hash_778bb52ecd08072d":
                str_override_rarity = utility::choose_from_weighted_array( [ "blue", "purple", "orange" ], [ 50, 90, 100 ] );
                break;
            case #"hash_598a30e44f53045f":
            case #"hash_95068103fe897bc8":
                str_override_rarity = utility::choose_from_weighted_array( [ "purple", "orange" ], [ 80, 100 ] );
                break;
            case #"hash_35bb3bd014c77f4b":
            case #"hash_d6c98e710a88aa4a":
                str_override_rarity = "orange";
                break;
            case #"hash_22aea56c1711fd5":
                str_override_rarity = "ultra";
                break;
            default:
                str_override_rarity = utility::choose_from_weighted_array( [ "green", "blue", "purple", "orange" ], [ 50, 80, 95, 100 ] );
                break;
        }
    }
    
    return str_override_rarity;
}

// Namespace namespace_ad703e086558d464
// Params 1, eflags: 0x4
// Checksum 0xabe43759, Offset: 0x48b
// Size: 0xc
function private function_4354f2d91058a846( player )
{
    
}

