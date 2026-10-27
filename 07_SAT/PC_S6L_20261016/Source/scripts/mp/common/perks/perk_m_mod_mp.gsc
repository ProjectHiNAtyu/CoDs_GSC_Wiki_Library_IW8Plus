// scripts\mp\common\perks\perk_m_mod_mp.gsc  (hash_227e30d9789ca7ef.gscc) (size: 905 Bytes / 0x389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63a1905b (1671532635)
// size ...... 905 (0x389)
// includes .. 2   (offset: 0x351)
// strings ... 3   (offset: 0x361)
// dev strs .. 0   (offset: 0x389)
// exports ... 6   (offset: 0x1b9)
// cseg ...... 0xa4 + 0x115 (0x1b9)
// imports ... 6   (offset: 0x2a9)
// animtree1 . 0   (offset: 0x389)
// animtree2 . 0   (offset: 0x389)
#using scripts\common\callbacks;
#using scripts\mp\playerhealth;

#namespace perk_m_mod_mp;

// Namespace perk_m_mod_mp
// Params 0, eflags: 0x1
// Checksum 0xff5fdae4, Offset: 0xc2
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_m_mod_mp
// Params 1
// Checksum 0xc58e04f4, Offset: 0xe2
// Size: 0x6f
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_m_mod" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_m_mod", &perk_set, &perk_unset, [ "specialty_fastermelee", "specialty_melee_without_swap" ] );
    }
}

// Namespace perk_m_mod_mp
// Params 0
// Checksum 0xb3ef99f5, Offset: 0x159
// Size: 0x9
function perk_set()
{
    thread function_585b5d86632f183b();
}

// Namespace perk_m_mod_mp
// Params 0
// Checksum 0x60175d80, Offset: 0x16a
// Size: 0xe
function perk_unset()
{
    self notify( #"hash_57b69f44fdb975cf" );
}

// Namespace perk_m_mod_mp
// Params 0, eflags: 0x4
// Checksum 0x6a0fe2b6, Offset: 0x180
// Size: 0x39
function private function_585b5d86632f183b()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_57b69f44fdb975cf" );
    
    while ( true )
    {
        self waittill( #"melee_fired" );
        playerhealth::forcehealthregen( self, 1 );
    }
}

