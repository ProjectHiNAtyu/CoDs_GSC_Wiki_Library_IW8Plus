// scripts\mp\common\perks\perk_deadshot_mp.gsc  (hash_0ce92b48e17e079d.gscc) (size: 1279 Bytes / 0x4ff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe247e88e (3796363406)
// size ...... 1279 (0x4ff)
// includes .. 1   (offset: 0x49f)
// strings ... 7   (offset: 0x4a7)
// dev strs .. 0   (offset: 0x4ff)
// exports ... 6   (offset: 0x2bf)
// cseg ...... 0xc8 + 0x1f7 (0x2bf)
// imports ... 8   (offset: 0x3af)
// animtree1 . 0   (offset: 0x4ff)
// animtree2 . 0   (offset: 0x4ff)
#using scripts\common\callbacks;

#namespace perk_deadshot_mp;

// Namespace perk_deadshot_mp
// Params 0, eflags: 0x1
// Checksum 0x997313e2, Offset: 0xe6
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_deadshot_mp
// Params 1
// Checksum 0x40a25918, Offset: 0x106
// Size: 0x6f
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_deadshot" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_deadshot", &perk_set, &perk_unset, [ "specialty_bulletaccuracy", "specialty_quickdraw" ] );
    }
}

// Namespace perk_deadshot_mp
// Params 0
// Checksum 0xa5955524, Offset: 0x17d
// Size: 0x3a
function perk_set()
{
    self.var_5ebb751ddafea9f7 = 2;
    
    if ( !callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::add( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

// Namespace perk_deadshot_mp
// Params 0
// Checksum 0x6875114b, Offset: 0x1bf
// Size: 0x38
function perk_unset()
{
    self.var_5ebb751ddafea9f7 = undefined;
    
    if ( callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::remove( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

// Namespace perk_deadshot_mp
// Params 1, eflags: 0x4
// Checksum 0xe591964e, Offset: 0x1ff
// Size: 0xc0
function private on_modify_player_damage( params )
{
    if ( !isdefined( params.eattacker.var_5ebb751ddafea9f7 ) )
    {
        return;
    }
    
    if ( params.objweapon.ismelee || params.smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( params.shitloc == "head" || params.shitloc == "neck" || params.shitloc == "helmet" )
    {
        params.idamage *= params.eattacker.var_5ebb751ddafea9f7;
    }
}

