// script_617fb9590f1af59a  (hash_617fb9590f1af59a.gscc) (size: 1647 Bytes / 0x66f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x205d4139 (542982457)
// size ...... 1647 (0x66f)
// includes .. 2   (offset: 0x62f)
// strings ... 1   (offset: 0x63f)
// dev strs .. 0   (offset: 0x66f)
// exports ... 12  (offset: 0x1f7)
// cseg ...... 0x73 + 0x184 (0x1f7)
// imports ... 21  (offset: 0x3d7)
// animtree1 . 0   (offset: 0x66f)
// animtree2 . 0   (offset: 0x66f)
#using script_25f7d83c36862807;
#using scripts\common\callbacks;

#namespace namespace_a6faf1ef37255d91;

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x5
// Checksum 0xfc439fe9, Offset: 0x91
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace namespace_a6faf1ef37255d91
// Params 1, eflags: 0x4
// Checksum 0xa55dc0bd, Offset: 0xb1
// Size: 0x2f
function private register( params )
{
    namespace_e6b8ff332c074970::register( "super_grappling_hook_sm", &set_super, &unset_super, &begin_use, &end_use, undefined, undefined, undefined );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0xea843aab, Offset: 0xe8
// Size: 0xe
function private set_super()
{
    namespace_e6b8ff332c074970::setsuper( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0x2538f66e, Offset: 0xfe
// Size: 0xe
function private unset_super()
{
    namespace_e6b8ff332c074970::unsetsuper( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 1, eflags: 0x4
// Checksum 0x159dd65d, Offset: 0x114
// Size: 0x29
function private on_ammo_used( callbackparams )
{
    namespace_e6b8ff332c074970::function_8b5c1e5efaeccd48( "super_grappling_hook_sm", callbackparams, &onmiss, &function_44acf016f264110c, &function_f5003f9cde4967d5 );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0xb93eeb99, Offset: 0x145
// Size: 0x26, Type: bool
function private begin_use()
{
    return namespace_e6b8ff332c074970::beginuse( "super_grappling_hook_sm", &onmiss, &function_44acf016f264110c, &function_f5003f9cde4967d5, &cancel, &on_ammo_used );
}

// Namespace namespace_a6faf1ef37255d91
// Params 2, eflags: 0x4
// Checksum 0xd4eae06b, Offset: 0x174
// Size: 0x20, Type: bool
function private end_use( fromdeath, attacker )
{
    return namespace_e6b8ff332c074970::function_44fb742853607576( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 1, eflags: 0x4
// Checksum 0xeed279de, Offset: 0x19d
// Size: 0x18
function private cancel( params )
{
    namespace_e6b8ff332c074970::canceluse( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0x16a5fb61, Offset: 0x1bd
// Size: 0xe
function private onmiss()
{
    namespace_e6b8ff332c074970::onmiss( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0x6f67a0a3, Offset: 0x1d3
// Size: 0xe
function private function_44acf016f264110c()
{
    namespace_e6b8ff332c074970::function_44acf016f264110c( "super_grappling_hook_sm" );
}

// Namespace namespace_a6faf1ef37255d91
// Params 0, eflags: 0x4
// Checksum 0xc187116f, Offset: 0x1e9
// Size: 0xe
function private function_f5003f9cde4967d5()
{
    namespace_e6b8ff332c074970::function_f5003f9cde4967d5( "super_grappling_hook_sm" );
}

