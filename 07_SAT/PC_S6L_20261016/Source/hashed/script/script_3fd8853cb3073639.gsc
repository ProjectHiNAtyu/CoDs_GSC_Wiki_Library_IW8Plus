// script_3fd8853cb3073639  (hash_3fd8853cb3073639.gscc) (size: 1253 Bytes / 0x4e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf49b5ce6 (4103822566)
// size ...... 1253 (0x4e5)
// includes .. 1   (offset: 0x47d)
// strings ... 8   (offset: 0x485)
// dev strs .. 0   (offset: 0x4e5)
// exports ... 4   (offset: 0x315)
// cseg ...... 0xe4 + 0x231 (0x315)
// imports ... 7   (offset: 0x3b5)
// animtree1 . 0   (offset: 0x4e5)
// animtree2 . 0   (offset: 0x4e5)
#using scripts\common\logging\playtest_logger;

#namespace namespace_7aeb49bf61a4f83a;

// Namespace namespace_7aeb49bf61a4f83a
// Params 0
// Checksum 0x394fe5a7, Offset: 0x102
// Size: 0x73
function function_a03a0535dc1c3af4()
{
    level.var_e607236b193eb0c1.var_60fef2e8ce64f16e = playtest_logger::function_81cc4ca859a01d68( @"hash_f8e7847542ad87b", @"hash_bfeb32393a504e8f", @"hash_244177c72e87bc3a", @"hash_5f935cd5ee9fab40", @"hash_a76f700f0eb898ea", @"hash_6059bf7ed76ee50e", @"hash_64dfae6dacf0c865", "ACTIVITY SPAWNER LOG " );
    return level.var_e607236b193eb0c1.var_60fef2e8ce64f16e;
}

// Namespace namespace_7aeb49bf61a4f83a
// Params 4
// Checksum 0x4bd48ba6, Offset: 0x17e
// Size: 0xe1
function function_aa43680a6e4d0721( logtext, associateddvar = @"hash_2d8c42c7641d527", var_67d2d1f57293b4cf = undefined, loglevel = 1 )
{
    var_f69a60212c696d06 = getdvarint( @"hash_7ac6de63251d9ee7", 0 );
    var_bd0695d8ecfd4739 = !getdvarint( associateddvar, 1 );
    
    if ( var_f69a60212c696d06 || var_bd0695d8ecfd4739 )
    {
        return;
    }
    
    logtext = "( " + gettime() + " ) " + logtext;
    
    if ( isstruct( var_67d2d1f57293b4cf ) )
    {
        logtext += function_c37f5f99c108da30( var_67d2d1f57293b4cf );
    }
    
    var_60fef2e8ce64f16e = level.var_e607236b193eb0c1.var_60fef2e8ce64f16e;
    
    if ( !isdefined( var_60fef2e8ce64f16e ) )
    {
        var_60fef2e8ce64f16e = function_a03a0535dc1c3af4();
    }
    
    playtest_logger::function_b3bbbcdc1984dae9( logtext, loglevel, var_60fef2e8ce64f16e );
}

// Namespace namespace_7aeb49bf61a4f83a
// Params 1, eflags: 0x4
// Checksum 0x98bf7fe8, Offset: 0x267
// Size: 0xad
function private function_c37f5f99c108da30( var_67d2d1f57293b4cf )
{
    var_657a3abce2509b48 = " activity: category = " + var_67d2d1f57293b4cf.class + " type = " + var_67d2d1f57293b4cf.type + ", variant = " + var_67d2d1f57293b4cf.name;
    
    if ( isdefined( var_67d2d1f57293b4cf.region.index ) )
    {
        var_657a3abce2509b48 = var_657a3abce2509b48 + ", region = " + var_67d2d1f57293b4cf.region.index;
    }
    
    if ( isdefined( var_67d2d1f57293b4cf.var_e43d97c215c8145e ) )
    {
        var_657a3abce2509b48 = var_657a3abce2509b48 + ", activity difficulty tier = " + var_67d2d1f57293b4cf.var_e43d97c215c8145e;
    }
    
    return var_657a3abce2509b48;
}

