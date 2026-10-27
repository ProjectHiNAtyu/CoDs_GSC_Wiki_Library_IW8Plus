// scripts\mp\common\perks\sentinel.gsc  (hash_46636592972f2f34.gscc) (size: 1548 Bytes / 0x60c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88128022 (2282913826)
// size ...... 1548 (0x60c)
// includes .. 2   (offset: 0x5e0)
// strings ... 1   (offset: 0x5f0)
// dev strs .. 0   (offset: 0x60c)
// exports ... 8   (offset: 0x34c)
// cseg ...... 0x6e + 0x2de (0x34c)
// imports ... 12  (offset: 0x48c)
// animtree1 . 0   (offset: 0x60c)
// animtree2 . 0   (offset: 0x60c)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;

#namespace sentinel;

// Namespace sentinel
// Params 0, eflags: 0x1
// Checksum 0x59e43fab, Offset: 0x8c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_9d3a1e2263faaa27 );
}

// Namespace sentinel
// Params 1
// Checksum 0xba7cc922, Offset: 0xac
// Size: 0x11b
function function_9d3a1e2263faaa27( params )
{
    bundle = level.perkbundles[ "specialty_sentinel" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_sentinel", &setsentinel, &unsetsentinel );
    }
    
    if ( isdefined( params.var_5109b530c69d18a1 ) )
    {
        level [[ params.var_5109b530c69d18a1 ]]( "specialty_sentinel", &sentinelonkill );
    }
    
    var_ec3f9f1b6f06edac = [];
    
    foreach ( scoreeventstruct in bundle.var_ec3f9f1b6f06edac )
    {
        var_ec3f9f1b6f06edac[ var_ec3f9f1b6f06edac.size ] = scoreeventstruct.scoreevent;
    }
    
    level.var_ec3f9f1b6f06edac = var_ec3f9f1b6f06edac;
}

// Namespace sentinel
// Params 1
// Checksum 0x938cc560, Offset: 0x1cf
// Size: 0x2a
function sentinelonkill( params )
{
    if ( !self.var_7a44face12042213 )
    {
        return;
    }
    
    thread points::doscoreevent( #"sentinel_kill_bonus" );
}

// Namespace sentinel
// Params 1
// Checksum 0xa382677c, Offset: 0x201
// Size: 0xa1
function function_e70124bb42e890b5( params )
{
    if ( self.var_7a44face12042213 )
    {
        return;
    }
    
    if ( !arraycontains( level.var_ec3f9f1b6f06edac, params.event ) )
    {
        return;
    }
    
    self.var_7a44face12042213 = 1;
    bundle = level.perkbundles[ "specialty_sentinel" ];
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        self [[ var_2c124e2ccc1e8842 ]]( bundle, %"hash_64b98a7a0e74cda5" );
    }
    
    thread function_4d94ec7647d9b6d6();
}

// Namespace sentinel
// Params 0
// Checksum 0xff0079f4, Offset: 0x2aa
// Size: 0x21
function setsentinel()
{
    self.var_7a44face12042213 = 0;
    callback::add( #"hash_fa7263897b3164e", &function_e70124bb42e890b5 );
}

// Namespace sentinel
// Params 0
// Checksum 0x68d190cc, Offset: 0x2d3
// Size: 0x21
function unsetsentinel()
{
    self.var_7a44face12042213 = 0;
    callback::remove( #"hash_fa7263897b3164e", &function_e70124bb42e890b5 );
}

// Namespace sentinel
// Params 0
// Checksum 0x2a496693, Offset: 0x2fc
// Size: 0x50
function function_4d94ec7647d9b6d6()
{
    self endon( #"death_or_disconnect" );
    bundle = level.perkbundles[ "specialty_sentinel" ];
    buffduration = bundle.var_1ba056704c2c2b91 ?? 10;
    wait buffduration;
    self.var_7a44face12042213 = 0;
}

