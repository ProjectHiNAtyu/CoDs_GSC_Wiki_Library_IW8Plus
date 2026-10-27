// scripts\mp\audio.gsc  (hash_2cc9b45597129ee2.gscc) (size: 2513 Bytes / 0x9d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8ecfa28 (4176280104)
// size ...... 2513 (0x9d1)
// includes .. 2   (offset: 0x945)
// strings ... 9   (offset: 0x955)
// dev strs .. 1   (offset: 0x9c5)
// exports ... 9   (offset: 0x5b5)
// cseg ...... 0xbb + 0x4fa (0x5b5)
// imports ... 19  (offset: 0x71d)
// animtree1 . 0   (offset: 0x9d1)
// animtree2 . 0   (offset: 0x9d1)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\audio_utility;

#namespace audio;

// Namespace audio
// Params 0
// Checksum 0x8b164ff, Offset: 0xd9
// Size: 0xa7
function init_audio()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    audio_utility::snd_init();
    init_reverb();
    table = level.gamemodebundle.var_d1cdb60b9e472f14;
    
    if ( isdefined( table ) )
    {
        soundsettimescalefactorfromtable( table );
    }
    
    if ( level.gamemodebundle.var_6a3bebcd253aae9f )
    {
        setdvar( @"cg_ballisticsstopwhizbyinsounds", 0 );
        setdvar( @"cg_ballisticsstopwhizbyoutsounds", 0 );
    }
    
    level callback::add( #"player_connect", &onplayerconnectaudioinit );
    level thread function_5b9514e060bb4725();
}

// Namespace audio
// Params 0
// Checksum 0x7dfb22a2, Offset: 0x188
// Size: 0x4c
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.gametypebundle ) )
    {
        if ( isdefined( level.gametypebundle.var_f71fd9de615029ca ) )
        {
            audio_utility::snd_transient_load( level.gametypebundle.var_f71fd9de615029ca );
        }
    }
}

// Namespace audio
// Params 1
// Checksum 0x538f83e5, Offset: 0x1dc
// Size: 0xc6
function onplayerconnectaudioinit( params )
{
    apply_reverb( "default" );
    var_1ee4c3bce9c6db21 = level.gamemodebundle.var_1ee4c3bce9c6db21;
    
    if ( level.gametypebundle.var_319a3b8afacdacd5 )
    {
        var_1ee4c3bce9c6db21 = level.gametypebundle.var_1ee4c3bce9c6db21;
    }
    
    if ( !var_1ee4c3bce9c6db21 )
    {
        self setplayermusicstate( "" );
    }
    
    if ( getdvarint( @"scr_thirdperson" ) == 1 )
    {
        setglobalsoundcontext( "thirdpersonmode", "on" );
    }
    
    function_5c27dd1174d9bd45();
    table = level.gamemodebundle.var_fae025ac87021b9b;
    
    if ( isdefined( table ) )
    {
        soundsettimescalefactorfromtable( table );
    }
}

// Namespace audio
// Params 0
// Checksum 0xc829650f, Offset: 0x2aa
// Size: 0xa8
function function_5c27dd1174d9bd45()
{
    var_40c850a241cf3962 = 1;
    
    if ( isdefined( level.gametypebundle ) )
    {
        if ( isdefined( level.gametypebundle.var_361ca2d552aaf5df ) )
        {
            self setsoundsubmix( level.gametypebundle.var_361ca2d552aaf5df );
        }
        
        if ( level.gametypebundle.var_af994b4383485379 )
        {
            var_40c850a241cf3962 = 0;
        }
    }
    
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( isdefined( level.gamemodebundle.var_f81431160b9a870a ) )
        {
            if ( var_40c850a241cf3962 )
            {
                self setsoundsubmix( level.gamemodebundle.var_f81431160b9a870a );
            }
        }
    }
}

// Namespace audio
// Params 0
// Checksum 0x9c56ca1f, Offset: 0x35a
// Size: 0x1f
function init_reverb()
{
    add_reverb( "default", "generic", 0.15, 0.9, 2 );
}

// Namespace audio
// Params 5
// Checksum 0x939739c7, Offset: 0x381
// Size: 0xa7
function add_reverb( name, type, wetlevel, drylevel, fadetime )
{
    assert( isdefined( type ) );
    assert( isdefined( wetlevel ) );
    assert( isdefined( drylevel ) );
    reverb = [];
    is_roomtype_valid( type );
    reverb[ "roomtype" ] = type;
    reverb[ "wetlevel" ] = wetlevel;
    reverb[ "drylevel" ] = drylevel;
    reverb[ "fadetime" ] = fadetime;
    level.audio.reverb_settings[ name ] = reverb;
}

// Namespace audio
// Params 1
// Checksum 0x34f8f615, Offset: 0x430
// Size: 0x171
function is_roomtype_valid( type )
{
    /#
        switch ( type )
        {
            case #"hash_cb77b3d8a372e08":
            case #"hash_fc258a369439547":
            case #"hash_1b4f1c09bc30f8b7":
            case #"hash_1c5d5131b5fa462e":
            case #"hash_3d9ccd28b21cb88e":
            case #"hash_3e5e0a1ebaebcc7d":
            case #"hash_3f9f17c1662d120a":
            case #"hash_4bdd565aad97d89e":
            case #"hash_4d3e369017db8fda":
            case #"hash_5ff8e011d5b9d1c8":
            case #"hash_67c4c671ba316fb9":
            case #"hash_6929fc3845c34be3":
            case #"hash_8944a3af59c61e8b":
            case #"hash_8a6d0b4f5207c46b":
            case #"hash_9e7f75efc4013b79":
            case #"hash_a1800029963e0fb8":
            case #"hash_af68187c92c7fbc0":
            case #"hash_afe4256f96628234":
            case #"hash_b445759ac0026f01":
            case #"hash_c16009bb5fe873b1":
            case #"hash_dc295829b4ceffa2":
            case #"hash_de1caed68cb47987":
            case #"hash_e991ce5bbbefabf9":
            case #"hash_ed5b5dc2ce86f143":
            case #"hash_f1a23e97c35685da":
            case #"hash_f67bf6cfc4a6bc7a":
                return;
            default:
                assertmsg( type + "<dev string:x10a>" );
                break;
        }
    #/
}

// Namespace audio
// Params 1
// Checksum 0xc454c9e1, Offset: 0x5a9
// Size: 0xc
function apply_reverb( name )
{
    
}

