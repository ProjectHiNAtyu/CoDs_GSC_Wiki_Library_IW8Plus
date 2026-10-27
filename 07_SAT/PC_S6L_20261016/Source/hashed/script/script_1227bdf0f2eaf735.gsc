// script_1227bdf0f2eaf735  (hash_1227bdf0f2eaf735.gscc) (size: 1102 Bytes / 0x44e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58d46ee7 (1490317031)
// size ...... 1102 (0x44e)
// includes .. 3   (offset: 0x402)
// strings ... 3   (offset: 0x41a)
// dev strs .. 0   (offset: 0x44e)
// exports ... 7   (offset: 0x1ce)
// cseg ...... 0x77 + 0x157 (0x1ce)
// imports ... 10  (offset: 0x2e6)
// animtree1 . 0   (offset: 0x44e)
// animtree2 . 0   (offset: 0x44e)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\magicbox;

#namespace namespace_72c943209a0510e6;

// Namespace namespace_72c943209a0510e6
// Params 0, eflags: 0x5
// Checksum 0x7b32fb0d, Offset: 0x95
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "wonderbar", #"bgb", &__init__, undefined );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xad8adda2, Offset: 0xba
// Size: 0x38
function __init__()
{
    bgb::register( "wonderbar", "event", &event, undefined, &disable );
    magicbox::function_1b154b89e87377fa( &function_bf0a20dea694ba5a );
    level.var_c7164a558fe3d921 = &function_c7164a558fe3d921;
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0x56ba2081, Offset: 0xfa
// Size: 0x33
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_wonderbar" );
    self waittill( #"hash_b0358cd4c78b6b45" );
    bgb::function_b62ba460d1b3dac9( "wonderbar" );
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0x3f795441, Offset: 0x135
// Size: 0xe
function disable()
{
    self notify( #"kill_wonderbar" );
}

// Namespace namespace_72c943209a0510e6
// Params 3
// Checksum 0x1ecd4dae, Offset: 0x14b
// Size: 0x4a
function function_bf0a20dea694ba5a( player, str_override_rarity, var_4b076b5c2a1741db )
{
    if ( player bgb::is_enabled( "wonderbar" ) || str_override_rarity == "ultra" && var_4b076b5c2a1741db )
    {
        return level.var_8b6bf63f61fe01f9;
    }
}

// Namespace namespace_72c943209a0510e6
// Params 0
// Checksum 0xecf26484, Offset: 0x19e
// Size: 0x2f
function function_c7164a558fe3d921()
{
    if ( self.var_37f3a4cd8252c9f0 bgb::is_enabled( "wonderbar" ) )
    {
        self.var_37f3a4cd8252c9f0 notify( #"hash_b0358cd4c78b6b45" );
        return 0;
    }
}

