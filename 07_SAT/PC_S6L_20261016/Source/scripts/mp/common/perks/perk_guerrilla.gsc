// scripts\mp\common\perks\perk_guerrilla.gsc  (hash_7054137eaf4167e6.gscc) (size: 792 Bytes / 0x318 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8641370 (3362001776)
// size ...... 792 (0x318)
// includes .. 1   (offset: 0x2e8)
// strings ... 3   (offset: 0x2f0)
// dev strs .. 0   (offset: 0x318)
// exports ... 6   (offset: 0x16c)
// cseg ...... 0x9c + 0xd0 (0x16c)
// imports ... 5   (offset: 0x25c)
// animtree1 . 0   (offset: 0x318)
// animtree2 . 0   (offset: 0x318)
#using scripts\common\callbacks;

#namespace perk_guerrilla;

// Namespace perk_guerrilla
// Params 0, eflags: 0x1
// Checksum 0x57873ab2, Offset: 0xba
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_71883647e87f9448 );
}

// Namespace perk_guerrilla
// Params 1
// Checksum 0x869bc332, Offset: 0xda
// Size: 0x74
function function_71883647e87f9448( params )
{
    bundle = level.perkbundles[ "specialty_guerrilla" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_guerrilla", &setguerrilla, &unsetguerrilla, [ "specialty_ghost", "specialty_heartbreaker" ], &initguerrilla );
    }
}

// Namespace perk_guerrilla
// Params 0, eflags: 0x4
// Checksum 0x7a3a0e0c, Offset: 0x156
// Size: 0x2
function private initguerrilla()
{
    
}

// Namespace perk_guerrilla
// Params 0, eflags: 0x4
// Checksum 0x1f502082, Offset: 0x160
// Size: 0x2
function private setguerrilla()
{
    
}

// Namespace perk_guerrilla
// Params 0, eflags: 0x4
// Checksum 0x2fe794ec, Offset: 0x16a
// Size: 0x2
function private unsetguerrilla()
{
    
}

