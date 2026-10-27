// scripts\mp\common\perks\perk_d_mod_mp.gsc  (hash_1d7461fb41a22ffe.gscc) (size: 1216 Bytes / 0x4c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c1bcc1c (2619067420)
// size ...... 1216 (0x4c0)
// includes .. 2   (offset: 0x474)
// strings ... 4   (offset: 0x484)
// dev strs .. 0   (offset: 0x4c0)
// exports ... 6   (offset: 0x25c)
// cseg ...... 0xb3 + 0x1a9 (0x25c)
// imports ... 10  (offset: 0x34c)
// animtree1 . 0   (offset: 0x4c0)
// animtree2 . 0   (offset: 0x4c0)
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace perk_d_mod_mp;

// Namespace perk_d_mod_mp
// Params 0, eflags: 0x1
// Checksum 0x837b4116, Offset: 0xd1
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_d_mod_mp
// Params 1
// Checksum 0xaca12c7a, Offset: 0xf1
// Size: 0x66
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_d_mod" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_d_mod", &perk_set, &perk_unset, [ "specialty_bulletpenetration" ] );
    }
}

// Namespace perk_d_mod_mp
// Params 0
// Checksum 0xe49c692c, Offset: 0x15f
// Size: 0x50
function perk_set()
{
    val::set( "specialty_d_mod_mp", "fire_time_scale", 80 );
    self.var_199a32a103256add = 1.5;
    
    if ( !callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::add( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

// Namespace perk_d_mod_mp
// Params 0
// Checksum 0xa035b79e, Offset: 0x1b7
// Size: 0x49
function perk_unset()
{
    val::reset( "specialty_d_mod_mp", "fire_time_scale" );
    self.var_199a32a103256add = undefined;
    
    if ( callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::remove( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

// Namespace perk_d_mod_mp
// Params 1, eflags: 0x4
// Checksum 0x6b6f96a0, Offset: 0x208
// Size: 0x54
function private on_modify_player_damage( params )
{
    if ( !isdefined( params.eattacker.var_199a32a103256add ) )
    {
        return;
    }
    
    params.idamage *= params.eattacker.var_199a32a103256add;
}

