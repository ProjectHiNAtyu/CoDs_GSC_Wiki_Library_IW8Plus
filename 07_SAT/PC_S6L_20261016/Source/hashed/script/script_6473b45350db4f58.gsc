// script_6473b45350db4f58  (hash_6473b45350db4f58.gscc) (size: 687 Bytes / 0x2af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6df52b7 (3604959927)
// size ...... 687 (0x2af)
// includes .. 1   (offset: 0x29b)
// strings ... 1   (offset: 0x2a3)
// dev strs .. 0   (offset: 0x2af)
// exports ... 5   (offset: 0x163)
// cseg ...... 0x78 + 0xeb (0x163)
// imports ... 4   (offset: 0x22b)
// animtree1 . 0   (offset: 0x2af)
// animtree2 . 0   (offset: 0x2af)
#using scripts\common\callbacks;

#namespace specialty_revived_ally_sound;

// Namespace specialty_revived_ally_sound
// Params 0, eflags: 0x1
// Checksum 0x9d0d3cdf, Offset: 0x96
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_revived_ally_sound
// Params 1
// Checksum 0xec745a44, Offset: 0xb6
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_revived_ally_sound", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_revived_ally_sound
// Params 0
// Checksum 0x978a73bf, Offset: 0xf8
// Size: 0x57
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    
    if ( bundle.var_f53a434099ef6d86 )
    {
        self.var_4a593d6aa991b3e2 = { #isoverride:bundle.var_8f92c78ff64bc02f, #alias:bundle.var_f53a434099ef6d86 };
    }
}

// Namespace specialty_revived_ally_sound
// Params 0
// Checksum 0xd34d0b15, Offset: 0x157
// Size: 0xc
function unsetspecialty()
{
    self.var_4a593d6aa991b3e2 = undefined;
}

