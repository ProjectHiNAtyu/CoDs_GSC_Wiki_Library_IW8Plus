// scripts\mp\zm\gametypes\zm_guided.gsc  (hash_393deb7ee0a7683a.gscc) (size: 2173 Bytes / 0x87d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd13340e (219362318)
// size ...... 2173 (0x87d)
// includes .. 7   (offset: 0x7b5)
// strings ... 2   (offset: 0x7ed)
// dev strs .. 7   (offset: 0x805)
// exports ... 7   (offset: 0x46d)
// cseg ...... 0x6e + 0x3ff (0x46d)
// imports ... 17  (offset: 0x585)
// animtree1 . 0   (offset: 0x87d)
// animtree2 . 0   (offset: 0x87d)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\magicbox;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_guided;

// Namespace zm_guided
// Params 0
// Checksum 0x308a9dec, Offset: 0x8c
// Size: 0x111
function main()
{
    zm_rb::main();
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = spawnstruct();
    }
    
    level.directed_mode.var_f1879f50f4eeaca3 = [];
    level.directed_mode.var_fcdcd383b4f959ed = "";
    
    if ( !isdefined( level.directed_mode.var_23edf8dfb11e1bf ) )
    {
        level.directed_mode.var_23edf8dfb11e1bf = [];
    }
    
    if ( !isdefined( level.directed_mode.var_8c6c59fc89ab90d1 ) )
    {
        level.directed_mode.var_8c6c59fc89ab90d1 = [];
    }
    
    utility::registersharedfunc( #"directed_mode", #"get_interact_func", &get_interact_func );
    utility::registersharedfunc( #"directed_mode", #"get_interact_string", &get_interact_string );
    level thread zm_quest::update_round_cap( 3, 1, 0 );
    level magicbox::function_2e49cd8681e36211( 1 );
    callback::add( "doorbuy_opened", &on_doorbuy_opened );
    zm_exfil_sat::function_5f8dd7f4c8fd2bd9();
}

// Namespace zm_guided
// Params 1, eflags: 0x4
// Checksum 0x3bebfd30, Offset: 0x1a5
// Size: 0x6e
function private on_doorbuy_opened( params )
{
    if ( isdefined( params.door.var_fc824b622a52db8d[ 0 ].s_doorbuy.var_11e530db74c0a830 ) )
    {
        level thread zm_quest::update_round_cap( params.door.var_fc824b622a52db8d[ 0 ].s_doorbuy.var_11e530db74c0a830 );
    }
}

// Namespace zm_guided
// Params 2
// Checksum 0x9b5092ca, Offset: 0x21b
// Size: 0xa0
function register_interact_func( ref, func )
{
    assert( game_utility::getgametype() == "<dev string:x24>", "<dev string:x2e>" );
    assert( isxhash( ref ) || isxhashasset( ref ), "<dev string:x70>" );
    assert( isfunction( func ), "<dev string:x84>" );
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = { #var_8c6c59fc89ab90d1:[], #var_23edf8dfb11e1bf:[] };
    }
    
    level.directed_mode.var_23edf8dfb11e1bf[ ref ] = func;
}

// Namespace zm_guided
// Params 1
// Checksum 0x5e224fa0, Offset: 0x2c3
// Size: 0x7c
function get_interact_func( ref )
{
    assert( game_utility::getgametype() == "<dev string:x24>", "<dev string:x2e>" );
    assert( isxhash( ref ) || isxhashasset( ref ), "<dev string:x70>" );
    assert( isdefined( level.directed_mode.var_23edf8dfb11e1bf[ ref ] ), "<dev string:xa2>" );
    return level.directed_mode.var_23edf8dfb11e1bf[ ref ];
}

// Namespace zm_guided
// Params 2
// Checksum 0xa22e35a0, Offset: 0x348
// Size: 0xa0
function register_interact_string( ref, loc )
{
    assert( game_utility::getgametype() == "<dev string:x24>", "<dev string:x2e>" );
    assert( isxhash( ref ) || isxhashasset( ref ), "<dev string:x70>" );
    assert( isistring( loc ), "<dev string:xc4>" );
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = { #var_8c6c59fc89ab90d1:[], #var_23edf8dfb11e1bf:[] };
    }
    
    level.directed_mode.var_8c6c59fc89ab90d1[ ref ] = loc;
}

// Namespace zm_guided
// Params 1
// Checksum 0x456964a5, Offset: 0x3f0
// Size: 0x7c
function get_interact_string( ref )
{
    assert( game_utility::getgametype() == "<dev string:x24>", "<dev string:x2e>" );
    assert( isxhash( ref ) || isxhashasset( ref ), "<dev string:x70>" );
    assert( isdefined( level.directed_mode.var_8c6c59fc89ab90d1[ ref ] ), "<dev string:xda>" );
    return level.directed_mode.var_8c6c59fc89ab90d1[ ref ];
}

