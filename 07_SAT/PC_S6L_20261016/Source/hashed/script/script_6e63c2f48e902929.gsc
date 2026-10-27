// script_6e63c2f48e902929  (hash_6e63c2f48e902929.gscc) (size: 1612 Bytes / 0x64c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14022349 (335684425)
// size ...... 1612 (0x64c)
// includes .. 5   (offset: 0x560)
// strings ... 15  (offset: 0x588)
// dev strs .. 0   (offset: 0x64c)
// exports ... 4   (offset: 0x348)
// cseg ...... 0x139 + 0x20f (0x348)
// imports ... 13  (offset: 0x3e8)
// animtree1 . 0   (offset: 0x64c)
// animtree2 . 0   (offset: 0x64c)
#using script_2ca6208126895e3a;
#using script_2e1a76894f0067ae;
#using script_3ca54102ae92b950;
#using scripts\mp\compass;
#using scripts\mp\load;

#namespace mp_sat_sm_liminal;

// Namespace mp_sat_sm_liminal
// Params 0
// Checksum 0xcee060f5, Offset: 0x157
// Size: 0x7c
function main()
{
    namespace_2e55331231724f8::main();
    namespace_ffd2cc6af1912e45::main();
    namespace_5e5a63bc62a43913::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_sm_liminal" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    thread function_5bf968bd18c75093();
}

// Namespace mp_sat_sm_liminal
// Params 0
// Checksum 0x623682ef, Offset: 0x1db
// Size: 0xbb
function function_5bf968bd18c75093()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    var_a8a61fbc954b8087 = getdvarint( @"hash_230ea6a64978bd5d" );
    
    if ( !isdefined( var_a8a61fbc954b8087 ) || var_a8a61fbc954b8087 <= 0 )
    {
        var_a8a61fbc954b8087 = randomintrange( 1, 4 );
        setdvar( @"hash_230ea6a64978bd5d", var_a8a61fbc954b8087 );
    }
    
    if ( var_a8a61fbc954b8087 == 1 )
    {
        level.layout = "version1";
    }
    
    if ( var_a8a61fbc954b8087 == 2 )
    {
        level.layout = "version2";
    }
    
    if ( var_a8a61fbc954b8087 == 3 )
    {
        level.layout = "version3";
    }
    
    setareaswapstate( "mp_sat_sm_liminal_areaswap", level.layout );
    thread function_1c228b9e723eb064( var_a8a61fbc954b8087 );
}

// Namespace mp_sat_sm_liminal
// Params 1
// Checksum 0x68634990, Offset: 0x29e
// Size: 0xaa
function function_1c228b9e723eb064( var_a8a61fbc954b8087 )
{
    level endon( #"game_ended" );
    var_452b8949a709d954 = var_a8a61fbc954b8087;
    
    while ( !isdvardefined( @"hash_230ea6a64978bd5d" ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        while ( var_452b8949a709d954 == getdvarint( @"hash_230ea6a64978bd5d" ) )
        {
            waitframe();
        }
        
        var_452b8949a709d954 = getdvarint( @"hash_230ea6a64978bd5d" );
        
        if ( var_452b8949a709d954 == 1 )
        {
            layout = "version1";
        }
        
        if ( var_452b8949a709d954 == 2 )
        {
            layout = "version2";
        }
        
        if ( var_452b8949a709d954 == 3 )
        {
            layout = "version3";
        }
        
        setareaswapstate( "mp_sat_sm_liminal_areaswap", layout );
    }
}

