// scripts\mp\ob\supers\grappling_hook_super.gsc  (hash_7db2bc64ba97debb.gscc) (size: 2504 Bytes / 0x9c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe05b79f (3188045727)
// size ...... 2504 (0x9c8)
// includes .. 5   (offset: 0x940)
// strings ... 2   (offset: 0x968)
// dev strs .. 2   (offset: 0x9b0)
// exports ... 13  (offset: 0x38c)
// cseg ...... 0x7d + 0x30f (0x38c)
// imports ... 33  (offset: 0x594)
// animtree1 . 0   (offset: 0x9c8)
// animtree2 . 0   (offset: 0x9c8)
#using script_25f7d83c36862807;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace grappling_hook_super;

// Namespace grappling_hook_super
// Params 0, eflags: 0x5
// Checksum 0x5db4522a, Offset: 0x9b
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace grappling_hook_super
// Params 1, eflags: 0x4
// Checksum 0xc9e5abb4, Offset: 0xbb
// Size: 0x2f
function private register( params )
{
    namespace_e6b8ff332c074970::register( "super_grappling_hook", &set_super, &unset_super, &begin_use, &end_use, undefined, undefined, undefined );
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0x14b92cb8, Offset: 0xf2
// Size: 0x30
function private set_super()
{
    assert( supers_mp::getsuperslot( "<dev string:x24>" ) == #"tactical", "<dev string:x39>" );
    namespace_e6b8ff332c074970::setsuper( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0x49809d67, Offset: 0x12a
// Size: 0xe
function private unset_super()
{
    namespace_e6b8ff332c074970::unsetsuper( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 1, eflags: 0x4
// Checksum 0x8600e0b2, Offset: 0x140
// Size: 0x29
function private on_ammo_used( callbackparams )
{
    namespace_e6b8ff332c074970::function_8b5c1e5efaeccd48( "super_grappling_hook", callbackparams, &onmiss, &function_44acf016f264110c, &function_f5003f9cde4967d5 );
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0x2aa3dd1a, Offset: 0x171
// Size: 0x26, Type: bool
function private begin_use()
{
    return namespace_e6b8ff332c074970::beginuse( "super_grappling_hook", &onmiss, &function_44acf016f264110c, &function_f5003f9cde4967d5, &cancel, &on_ammo_used );
}

// Namespace grappling_hook_super
// Params 2, eflags: 0x4
// Checksum 0xb8528b0e, Offset: 0x1a0
// Size: 0x20, Type: bool
function private end_use( fromdeath, attacker )
{
    return namespace_e6b8ff332c074970::function_44fb742853607576( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 1, eflags: 0x4
// Checksum 0x826a12bb, Offset: 0x1c9
// Size: 0x18
function private cancel( params )
{
    namespace_e6b8ff332c074970::canceluse( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0x7a1d9004, Offset: 0x1e9
// Size: 0xe
function private onmiss()
{
    namespace_e6b8ff332c074970::onmiss( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0x8af3551c, Offset: 0x1ff
// Size: 0x6c
function private function_44acf016f264110c()
{
    namespace_e6b8ff332c074970::function_44acf016f264110c( "super_grappling_hook" );
    var_2381886e8f4b7940 = utility::callsharedfunc( "super_grappling_hook", #"hash_14c5c7f6eecd5b36" );
    var_9bc82e62b9f5162e = 0 == utility::callsharedfunc( "super_grappling_hook", #"hash_ae0f197de9d113e2" );
    
    if ( var_2381886e8f4b7940 )
    {
        supers_mp::refundsuper( #"tactical" );
        thread function_403b142263042172( var_9bc82e62b9f5162e );
    }
}

// Namespace grappling_hook_super
// Params 0, eflags: 0x4
// Checksum 0xad3f7a0a, Offset: 0x273
// Size: 0xe
function private function_f5003f9cde4967d5()
{
    namespace_e6b8ff332c074970::function_f5003f9cde4967d5( "super_grappling_hook" );
}

// Namespace grappling_hook_super
// Params 1, eflags: 0xc
// Checksum 0x19095f07, Offset: 0x289
// Size: 0x103
function private function_403b142263042172( var_b85fd808ff9066d4 )
{
    self notify( #"hash_4fca486c97a46448" );
    self endon( #"hash_4fca486c97a46448" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"kill_grappling_hook_upgrade" );
    
    while ( true )
    {
        var_6daa921e4ef1e86c = !self.grapple.ispulling && self isonground();
        var_5e854b0cbbd22214 = var_b85fd808ff9066d4 && self iswingsuitdeployed();
        
        if ( var_6daa921e4ef1e86c || var_5e854b0cbbd22214 )
        {
            ref = equipment_mp::getcurrentequipment( "secondary" );
            maxammo = equipment_mp::getequipmentmaxammo( ref );
            ammo = equipment_mp::getequipmentammo( ref );
            equipment_mp::decrementequipmentslotammo( "secondary", 1 );
            
            if ( ammo == maxammo )
            {
                supers_mp::setsuperbasepoints( 0, 1, #"tactical" );
            }
            
            break;
        }
        
        wait 0.1;
    }
}

