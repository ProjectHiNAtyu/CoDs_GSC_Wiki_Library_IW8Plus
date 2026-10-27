// scripts\mp\maps\mp_wz2_sierra\mp_wz2_sierra_light.gsc  (hash_640aa4f4c948c7b6.gscc) (size: 2075 Bytes / 0x81b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa489a3f1 (2760483825)
// size ...... 2075 (0x81b)
// includes .. 2   (offset: 0x7a3)
// strings ... 4   (offset: 0x7b3)
// dev strs .. 4   (offset: 0x7eb)
// exports ... 8   (offset: 0x3d7)
// cseg ...... 0x8f + 0x348 (0x3d7)
// imports ... 22  (offset: 0x517)
// animtree1 . 0   (offset: 0x81b)
// animtree2 . 0   (offset: 0x81b)
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;

#namespace mp_wz2_sierra_light;

// Namespace mp_wz2_sierra_light
// Params 0
// Checksum 0xe9f67bcf, Offset: 0xad
// Size: 0x59
function init()
{
    if ( getdvarint( @"hash_c5eb2c59d570426e", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_560c9148c0f76ee4", 0 ) == 0 )
    {
        function_4b55d096e876d56e();
    }
    else
    {
        function_e2c6de109391b81a();
    }
    
    /#
        utility::registersharedfunc( #"zxl", #"hash_92c69cebc395b9e7", &runcommand );
    #/
}

// Namespace mp_wz2_sierra_light
// Params 0, eflags: 0x4
// Checksum 0x583858c4, Offset: 0x10e
// Size: 0x5a
function private function_e2c6de109391b81a()
{
    function_7aee8a80a20e0ab4( 1023, 4, 0 );
    setsuncolorandintensity( 0.85, 0.97, 1, 0.075 );
    setskyrotation( ( 0, 33, 180 ) );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    thread function_d52c1d487c69ab39( 1, "mp_wz2_sierra_pm_transient", "time_of_day", "pm" );
}

// Namespace mp_wz2_sierra_light
// Params 0, eflags: 0x4
// Checksum 0x61023ad9, Offset: 0x170
// Size: 0x5c
function private function_4b55d096e876d56e()
{
    function_7aee8a80a20e0ab4( 1023, 1, 0 );
    setsuncolorandintensity( 1, 0.9471, 0.8549, 0.29 );
    setskyrotation( ( 0, 14, 0 ) );
    
    /#
        iprintlnbold( "<dev string:x36>" );
    #/
    
    thread function_d52c1d487c69ab39( 0, "mp_wz2_sierra_pm_transient", "time_of_day", "" );
}

// Namespace mp_wz2_sierra_light
// Params 4
// Checksum 0x732b0e37, Offset: 0x1d4
// Size: 0x67
function function_d52c1d487c69ab39( soundbank_load, soundbank_name, context_type, context_value )
{
    level endon( #"game_ended" );
    
    if ( soundbank_load )
    {
        audio_utility::snd_transient_load( soundbank_name );
    }
    else
    {
        audio_utility::snd_transient_unload( soundbank_name );
    }
    
    level waittill( #"player_spawned" );
    setglobalsoundcontext( context_type, context_value, 0.5 );
}

/#

    // Namespace mp_wz2_sierra_light
    // Params 0, eflags: 0x4
    // Checksum 0xe7841832, Offset: 0x243
    // Size: 0x6f, Type: dev
    function private function_ac6a0ace52996e88()
    {
        if ( !isdefined( level.var_fc96529fadaeaa84 ) )
        {
            level.var_fc96529fadaeaa84 = 0;
        }
        
        if ( level.var_fc96529fadaeaa84 == 0 )
        {
            iprintlnbold( "<dev string:x46>" );
            wait 2;
            level.var_fc96529fadaeaa84 = 1;
            level thread function_dc9ece2939982145();
            return;
        }
        
        iprintlnbold( "<dev string:x5d>" );
        level notify( #"light_test_end" );
        level.var_fc96529fadaeaa84 = 0;
    }

    // Namespace mp_wz2_sierra_light
    // Params 0, eflags: 0xc
    // Checksum 0x49c1db01, Offset: 0x2ba
    // Size: 0x64, Type: dev
    function private function_dc9ece2939982145()
    {
        self notify( #"hash_e995f6da158386cb" );
        self endon( #"hash_e995f6da158386cb" );
        level endon( #"game_ended" );
        level endon( #"light_test_end" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_560c9148c0f76ee4", 0 ) == 0 )
            {
                thread function_e2c6de109391b81a();
            }
            else
            {
                thread function_4b55d096e876d56e();
            }
            
            wait 10;
        }
    }

    // Namespace mp_wz2_sierra_light
    // Params 1, eflags: 0x4
    // Checksum 0x53ea1c9a, Offset: 0x326
    // Size: 0xb1, Type: dev
    function private runcommand( args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        command = args[ 0 ];
        var_9912188aea0e7f7e = args.size >= 2 ? args[ 1 ] : undefined;
        
        switch ( getxhash( command ) )
        {
            case #"day":
                setdvar( @"hash_560c9148c0f76ee4", 0 );
                function_4b55d096e876d56e();
                break;
            case #"night":
                setdvar( @"hash_560c9148c0f76ee4", 1 );
                function_e2c6de109391b81a();
                break;
            case #"test":
                thread function_ac6a0ace52996e88();
                break;
        }
    }

#/
