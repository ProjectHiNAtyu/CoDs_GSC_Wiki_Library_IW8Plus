// script_223617093c01de94  (hash_223617093c01de94.gscc) (size: 829 Bytes / 0x33d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbdc11a49 (3183549001)
// size ...... 829 (0x33d)
// includes .. 2   (offset: 0x309)
// strings ... 3   (offset: 0x319)
// dev strs .. 0   (offset: 0x33d)
// exports ... 5   (offset: 0x199)
// cseg ...... 0x89 + 0x110 (0x199)
// imports ... 6   (offset: 0x261)
// animtree1 . 0   (offset: 0x33d)
// animtree2 . 0   (offset: 0x33d)
#using scripts\common\callbacks;
#using scripts\mp\equipment;

#namespace specialty_extra_tactical;

// Namespace specialty_extra_tactical
// Params 0, eflags: 0x1
// Checksum 0xde47d081, Offset: 0xa7
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_extra_tactical
// Params 1
// Checksum 0x160fe16e, Offset: 0xc7
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_extra_tactical", &function_997a78ae40f108cb, &function_716d794586ab2746, [] );
    }
}

// Namespace specialty_extra_tactical
// Params 0
// Checksum 0xee41abf4, Offset: 0x109
// Size: 0xc
function function_716d794586ab2746()
{
    self.var_298c5ef409ca127 = undefined;
}

// Namespace specialty_extra_tactical
// Params 0
// Checksum 0xaa61cd11, Offset: 0x11d
// Size: 0x7c
function function_997a78ae40f108cb()
{
    ref = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( !isdefined( ref ) || ref == "none" )
    {
        return;
    }
    
    allowlist = self.var_9842326056fd7207.var_f4496f23a43c6c9f;
    
    if ( isdefined( allowlist ) && arraycontains( allowlist, ref ) )
    {
        self.var_298c5ef409ca127 = self.var_9842326056fd7207.var_24bd8e6fe855b8b ?? 1;
    }
}

