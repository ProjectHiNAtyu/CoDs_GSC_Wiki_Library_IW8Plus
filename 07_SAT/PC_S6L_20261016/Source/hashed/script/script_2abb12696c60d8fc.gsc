// script_2abb12696c60d8fc  (hash_2abb12696c60d8fc.gscc) (size: 858 Bytes / 0x35a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97ca2d28 (2546609448)
// size ...... 858 (0x35a)
// includes .. 2   (offset: 0x336)
// strings ... 1   (offset: 0x346)
// dev strs .. 0   (offset: 0x35a)
// exports ... 6   (offset: 0x19e)
// cseg ...... 0x6f + 0x12f (0x19e)
// imports ... 6   (offset: 0x28e)
// animtree1 . 0   (offset: 0x35a)
// animtree2 . 0   (offset: 0x35a)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_dexterity;

// Namespace specialty_dexterity
// Params 0, eflags: 0x1
// Checksum 0x27560d51, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_3e3a98bb3e45e7cf );
}

// Namespace specialty_dexterity
// Params 1
// Checksum 0xfad77677, Offset: 0xad
// Size: 0x5d
function function_3e3a98bb3e45e7cf( params )
{
    bundle = level.perkbundles[ "specialty_dexterity" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_dexterity", &setdexterity, &unsetdexterity, [] );
    }
}

// Namespace specialty_dexterity
// Params 0
// Checksum 0x9a1f2f02, Offset: 0x112
// Size: 0x29
function setdexterity()
{
    self.var_6c90b007e13f1832 = self.var_9842326056fd7207.var_ffd905a8f24b4ed1 ?? 0;
    thread activatedexterity();
}

// Namespace specialty_dexterity
// Params 0
// Checksum 0xd945a30f, Offset: 0x143
// Size: 0x18
function unsetdexterity()
{
    self.var_6c90b007e13f1832 = undefined;
    self notify( #"dexterity_unset" );
}

// Namespace specialty_dexterity
// Params 0
// Checksum 0x3ed726d2, Offset: 0x163
// Size: 0x3b
function activatedexterity()
{
    self endon( #"disconnect" );
    self endon( #"dexterity_unset" );
    
    while ( true )
    {
        self waittill( #"dexterity_activated" );
        namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_dexterity" );
    }
}

