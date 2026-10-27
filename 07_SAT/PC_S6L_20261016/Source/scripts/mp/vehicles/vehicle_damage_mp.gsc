// scripts\mp\vehicles\vehicle_damage_mp.gsc  (hash_47ddc686cd783c08.gscc) (size: 1117 Bytes / 0x45d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b2bde8f (1798037135)
// size ...... 1117 (0x45d)
// includes .. 6   (offset: 0x42d)
// strings ... 0   (offset: 0x45d)
// dev strs .. 0   (offset: 0x45d)
// exports ... 5   (offset: 0x1fd)
// cseg ...... 0x58 + 0x1a5 (0x1fd)
// imports ... 12  (offset: 0x2c5)
// animtree1 . 0   (offset: 0x45d)
// animtree2 . 0   (offset: 0x45d)
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\utility\points;
#using scripts\mp\events;
#using scripts\mp\rank;
#using scripts\mp\vehicles\damage;

#namespace vehicle_damage_mp;

// Namespace vehicle_damage_mp
// Params 0
// Checksum 0xfebe8d8b, Offset: 0x76
// Size: 0xb6
function vehicle_damage_mp_init()
{
    utility::registersharedfunc( #"vehicle_damage", #"setPreModDamageCallback", &damage::set_pre_mod_damage_callback );
    utility::registersharedfunc( #"vehicle_damage", #"setPostModDamageCallback", &damage::set_post_mod_damage_callback );
    utility::registersharedfunc( #"vehicle_damage", #"setDeathCallback", &damage::set_death_callback );
    utility::registersharedfunc( #"vehicle_damage", #"givescore", &vehicle_damage_givescore );
    utility::registersharedfunc( #"vehicle_damage", #"giveaward", &vehicle_damage_giveaward );
    utility::registersharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon", &vehicle_setuphitdamageoverrideforweapon );
}

// Namespace vehicle_damage_mp
// Params 3
// Checksum 0xf84fadf1, Offset: 0x134
// Size: 0x39
function vehicle_damage_givescore( ref, objweapon, var_f6852c1452a96a07 )
{
    if ( var_f6852c1452a96a07 )
    {
        rank::scoreeventpopup( ref );
        return;
    }
    
    points::doscoreevent( ref, objweapon );
}

// Namespace vehicle_damage_mp
// Params 3
// Checksum 0xdf18a278, Offset: 0x175
// Size: 0x37
function vehicle_damage_giveaward( ref, objweapon, var_f6852c1452a96a07 )
{
    thread events::killeventtextpopup( ref );
    
    if ( !var_f6852c1452a96a07 )
    {
        points::doscoreevent( ref, objweapon );
    }
}

// Namespace vehicle_damage_mp
// Params 4
// Checksum 0x5e81ca41, Offset: 0x1b4
// Size: 0x49
function vehicle_setuphitdamageoverrideforweapon( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, vehiclename )
{
    if ( isdefined( weaponhitsperattack ) )
    {
        vehicle_damage::set_weapon_hit_damage_data_for_vehicle( weaponname, weaponhitsperattack, vehiclename );
    }
    
    if ( isdefined( var_ffcfe5819a7a67f1 ) )
    {
        vehicle_damage::set_vehicle_hit_damage_data_for_weapon( vehiclename, var_ffcfe5819a7a67f1, weaponname );
    }
}

