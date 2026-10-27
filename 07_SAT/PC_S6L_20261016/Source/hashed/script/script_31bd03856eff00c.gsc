// script_31bd03856eff00c  (hash_031bd03856eff00c.gscc) (size: 1139 Bytes / 0x473 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7e496e4 (3353646820)
// size ...... 1139 (0x473)
// includes .. 3   (offset: 0x44f)
// strings ... 1   (offset: 0x467)
// dev strs .. 0   (offset: 0x473)
// exports ... 5   (offset: 0x237)
// cseg ...... 0x6f + 0x1c8 (0x237)
// imports ... 12  (offset: 0x2ff)
// animtree1 . 0   (offset: 0x473)
// animtree2 . 0   (offset: 0x473)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;

#namespace specialty_extraammo;

// Namespace specialty_extraammo
// Params 0, eflags: 0x1
// Checksum 0x1b5d284, Offset: 0x8d
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_extraammo
// Params 1
// Checksum 0x520f9982, Offset: 0xad
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_extraammo", &setextraammo, &unsetextraammo, [] );
    }
}

// Namespace specialty_extraammo
// Params 0
// Checksum 0xb59c7969, Offset: 0xef
// Size: 0x132
function setextraammo()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_extraammo" );
    level endon( #"game_ended" );
    
    if ( self.gettingloadout )
    {
        self waittill( #"giveloadout" );
    }
    else if ( getdvarint( @"hash_1b094f58542d35ac", isbrgamemode() ) )
    {
        return;
    }
    
    var_c45e22da95328d92 = utility::callsharedfunc( #"game", #"isCommonItemEnabled" );
    playerprimaries = weapon::getvalidextraammoweapons();
    
    if ( var_c45e22da95328d92 )
    {
        utility::callsharedfunc( #"ammo", #"hash_f3333d9b5f4eebfb", playerprimaries, 0, 0, 1 );
        return;
    }
    
    foreach ( primary in playerprimaries )
    {
        if ( isdefined( primary ) && !isnullweapon( primary ) )
        {
            self givemaxammo( primary );
        }
    }
}

// Namespace specialty_extraammo
// Params 0
// Checksum 0x710eb7ff, Offset: 0x229
// Size: 0xe
function unsetextraammo()
{
    self notify( #"unset_extraammo" );
}

