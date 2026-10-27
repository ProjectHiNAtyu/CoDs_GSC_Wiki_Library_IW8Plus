// script_41ebfc8983280c07  (hash_41ebfc8983280c07.gscc) (size: 2141 Bytes / 0x85d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7f8fdff (2818113023)
// size ...... 2141 (0x85d)
// includes .. 3   (offset: 0x809)
// strings ... 4   (offset: 0x821)
// dev strs .. 1   (offset: 0x851)
// exports ... 8   (offset: 0x451)
// cseg ...... 0x8f + 0x3c2 (0x451)
// imports ... 22  (offset: 0x591)
// animtree1 . 0   (offset: 0x85d)
// animtree2 . 0   (offset: 0x85d)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;

#namespace namespace_3d2c5588152a774f;

// Namespace namespace_3d2c5588152a774f
// Params 0, eflags: 0x5
// Checksum 0xbf0981cf, Offset: 0xad
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_123d5a5b0ea951c0", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_3d2c5588152a774f
// Params 0, eflags: 0x4
// Checksum 0xb876f8ac, Offset: 0xd6
// Size: 0x74
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"explosive", &function_a3e10cb868818fa8 );
    utility::registersharedfunc( #"can_airdrop_package", #"explosive", &utility::always_true );
    utility::registersharedfunc( #"hash_c0543f4480543c68", #"explosive", &function_c5b39721baa42b17 );
}

// Namespace namespace_3d2c5588152a774f
// Params 1, eflags: 0x4
// Checksum 0x6673f002, Offset: 0x152
// Size: 0xc
function private function_a3e10cb868818fa8( airdropsettings )
{
    
}

// Namespace namespace_3d2c5588152a774f
// Params 6, eflags: 0x4
// Checksum 0x5b13d41c, Offset: 0x166
// Size: 0x1ae
function private function_c5b39721baa42b17( airdropsettings, dropposition, dropdestination, dropangles, initialvelocity, var_e9a9d186782e327b = 1 )
{
    level endon( #"game_ended" );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    assert( isdefined( packagesettings.packagemodel ), "<dev string:x24>" );
    explosivepackage = spawn( "script_model", dropposition );
    explosivepackage.angles = dropangles ?? ( 0, 0, 0 );
    explosivepackage setmodel( packagesettings.packagemodel );
    explosivepackage.spawnorigin = dropposition;
    launchvelocity = initialvelocity ?? ( 0, 0, 0 );
    
    if ( !var_e9a9d186782e327b )
    {
        explosivepackage.var_fe2a17068a3c0fa6 = &function_e9cf037fbca20abb;
        explosivepackage.var_1967d030207bed9d = launchvelocity;
        explosivepackage.var_2282b030b6510534 = 0;
        explosivepackage.var_2282b130b6510767 = 0;
        explosivepackage.var_2282b230b651099a = 0;
    }
    else
    {
        explosivepackage physicslaunchserver( ( 0, 0, 0 ), launchvelocity );
        explosivepackage physics_registerforcollisioncallback();
    }
    
    explosivepackage thread airdrop_scriptbundle::function_4c121ea2c29854e8( airdropsettings );
    explosivepackage airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_f35f0e2b6123474f", airdropsettings );
    explosivepackage thread function_8a4927e9ae203aaf( airdropsettings );
    return explosivepackage;
}

// Namespace namespace_3d2c5588152a774f
// Params 0, eflags: 0x4
// Checksum 0x50a6286d, Offset: 0x31d
// Size: 0xbe
function private function_e9cf037fbca20abb()
{
    launchvelocity = self.var_1967d030207bed9d;
    var_2bcba263e70c41db = self.var_2282b030b6510534;
    var_2bcba163e70c3fa8 = self.var_2282b130b6510767;
    var_2bcba463e70c4641 = self.var_2282b230b651099a;
    self.var_fe2a17068a3c0fa6 = undefined;
    self.var_1967d030207bed9d = undefined;
    self.var_2282b030b6510534 = undefined;
    self.var_2282b130b6510767 = undefined;
    self.var_2282b230b651099a = undefined;
    self unlink();
    self physicslaunchserver( ( 0, 0, 0 ), launchvelocity );
    self physics_registerforcollisioncallback();
    bodyid = self physics_getbodyid( 0 );
    physics_setbodyangvel( bodyid, var_2bcba263e70c41db, var_2bcba163e70c3fa8, var_2bcba463e70c4641 );
}

// Namespace namespace_3d2c5588152a774f
// Params 1, eflags: 0x4
// Checksum 0xe9b245ee, Offset: 0x3e3
// Size: 0x56
function private function_8a4927e9ae203aaf( airdropsettings )
{
    explosivepackage = self;
    level endon( #"game_ended" );
    explosivepackage endon( #"death" );
    explosivepackage function_af20b74bbd0b55f5();
    explosivepackage utility::function_7c10ea82c1e305b8( "explosion", "exploding" );
    waitframe();
    explosivepackage delete();
}

// Namespace namespace_3d2c5588152a774f
// Params 0, eflags: 0x4
// Checksum 0x5114b75c, Offset: 0x441
// Size: 0x10
function private function_af20b74bbd0b55f5()
{
    utility::waittill_any_timeout( 8, "collision" );
}

