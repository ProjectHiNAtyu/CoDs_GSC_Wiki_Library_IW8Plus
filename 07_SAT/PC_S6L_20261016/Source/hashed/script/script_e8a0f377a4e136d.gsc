// script_e8a0f377a4e136d  (hash_0e8a0f377a4e136d.gscc) (size: 874 Bytes / 0x36a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1cc7fb8e (482868110)
// size ...... 874 (0x36a)
// includes .. 2   (offset: 0x346)
// strings ... 1   (offset: 0x356)
// dev strs .. 0   (offset: 0x36a)
// exports ... 6   (offset: 0x192)
// cseg ...... 0x6f + 0x123 (0x192)
// imports ... 7   (offset: 0x282)
// animtree1 . 0   (offset: 0x36a)
// animtree2 . 0   (offset: 0x36a)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_athletics;

// Namespace specialty_athletics
// Params 0, eflags: 0x1
// Checksum 0x1cb4da1d, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_c33a4d5d657845b8 );
}

// Namespace specialty_athletics
// Params 1
// Checksum 0x73d5fbad, Offset: 0xad
// Size: 0x5d
function function_c33a4d5d657845b8( params )
{
    bundle = level.perkbundles[ "specialty_athletics" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_athletics", &setathletics, &unsetathletics, [] );
    }
}

// Namespace specialty_athletics
// Params 0
// Checksum 0xfbbc833c, Offset: 0x112
// Size: 0x9
function setathletics()
{
    thread function_78a973e75f15cafa();
}

// Namespace specialty_athletics
// Params 0
// Checksum 0x7ae1a2b3, Offset: 0x123
// Size: 0xe
function unsetathletics()
{
    self notify( #"athletics_unset" );
}

// Namespace specialty_athletics
// Params 0
// Checksum 0xb71856ed, Offset: 0x139
// Size: 0x59
function function_78a973e75f15cafa()
{
    self endon( #"disconnect" );
    self endon( #"athletics_unset" );
    sprintactive = 0;
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            if ( !sprintactive )
            {
                namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_athletics" );
                sprintactive = 1;
            }
        }
        else
        {
            sprintactive = 0;
        }
        
        wait 0.5;
    }
}

