// scripts\mp\ob\systems\ob_livingworld_manager.gsc  (hash_7c869acb179ae390.gscc) (size: 1211 Bytes / 0x4bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc566ac5b (3311840347)
// size ...... 1211 (0x4bb)
// includes .. 2   (offset: 0x49f)
// strings ... 1   (offset: 0x4af)
// dev strs .. 0   (offset: 0x4bb)
// exports ... 5   (offset: 0x2ab)
// cseg ...... 0x69 + 0x242 (0x2ab)
// imports ... 10  (offset: 0x373)
// animtree1 . 0   (offset: 0x4bb)
// animtree2 . 0   (offset: 0x4bb)
#using scripts\mp\flags;
#using scripts\mp\gametypes\ob;

#namespace ob_livingworld_manager;

// Namespace ob_livingworld_manager
// Params 0, eflags: 0x4
// Checksum 0x7ef792de, Offset: 0x87
// Size: 0x52
function private _is_enabled()
{
    if ( isdvardefined( @"hash_2c7bc0555ff25362" ) )
    {
        return ( getdvarint( @"hash_2c7bc0555ff25362", 0 ) != 0 );
    }
    
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( isdefined( var_bb86f77304f193c4 ) )
    {
        return var_bb86f77304f193c4.var_9109845f41fe6aa0.isenabled;
    }
    
    return 0;
}

// Namespace ob_livingworld_manager
// Params 0, eflags: 0x4
// Checksum 0x3583943e, Offset: 0xe2
// Size: 0x50
function private function_3026db559aef29cc()
{
    if ( isdvardefined( @"hash_e7be6eb1919a1ede" ) )
    {
        return getdvarint( @"hash_e7be6eb1919a1ede", 0 );
    }
    
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( isdefined( var_bb86f77304f193c4 ) )
    {
        return var_bb86f77304f193c4.var_9109845f41fe6aa0.var_9f489f4ec9998360;
    }
    
    return 0;
}

// Namespace ob_livingworld_manager
// Params 0, eflags: 0x1
// Checksum 0x7f9218f7, Offset: 0x13b
// Size: 0x14
function autoexec function_40a5c3d46d5190f5()
{
    if ( !_is_enabled() )
    {
        return;
    }
    
    thread function_296258d93807872a();
}

// Namespace ob_livingworld_manager
// Params 0, eflags: 0x4
// Checksum 0xd2fded74, Offset: 0x157
// Size: 0x154
function private function_296258d93807872a()
{
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    var_bdae6c8a8b7a1e0c = function_3026db559aef29cc();
    wait var_bdae6c8a8b7a1e0c;
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    foreach ( var_9aca2686f3f733c in var_bb86f77304f193c4.var_9109845f41fe6aa0.var_cbf13fe4d276200f )
    {
        scriptables = getentitylessscriptablearray( var_9aca2686f3f733c.scriptablename, #classname );
        
        foreach ( scriptable in scriptables )
        {
            scriptable setscriptablepartstate( var_9aca2686f3f733c.partname, var_9aca2686f3f733c.partstatename, 0 );
        }
    }
}

