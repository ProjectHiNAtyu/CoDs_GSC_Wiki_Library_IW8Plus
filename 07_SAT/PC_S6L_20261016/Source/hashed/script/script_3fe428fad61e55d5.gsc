// script_3fe428fad61e55d5  (hash_3fe428fad61e55d5.gscc) (size: 3922 Bytes / 0xf52 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5b02b35 (3316656949)
// size ...... 3922 (0xf52)
// includes .. 4   (offset: 0xd8a)
// strings ... 27  (offset: 0xdaa)
// dev strs .. 0   (offset: 0xf52)
// exports ... 6   (offset: 0xace)
// cseg ...... 0x2fc + 0x7d2 (0xace)
// imports ... 13  (offset: 0xbbe)
// animtree1 . 0   (offset: 0xf52)
// animtree2 . 0   (offset: 0xf52)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;

#namespace ob_exotic_weapons;

// Namespace ob_exotic_weapons
// Params 0, eflags: 0x1
// Checksum 0x4b92ea19, Offset: 0x31a
// Size: 0x406
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_392a02d2215c3496 );
    system::function_eca4bddb3f37e51b();
    level.var_f7d8c385fccc43b4[ "sat_sn_baltic_mp" ] = &function_6e241c31302c29f0;
    agent_utils::register_soldier_damage_callback( &function_f4138abeeda58196 );
    utility::registersharedfunc( #"exotic_weapons", #"hash_30545f2ddec3de8e", &ob_augments_on_player_connect );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"lightray_big_game", "lightmend_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"lightray_dual_action", "lightmend_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"lightray_booster_shot", "lightmend_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shatterblast_big_game", "shatterblast_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shatterblast_blast_chain", "shatterblast_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shatterblast_blast_shield", "shatterblast_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"brainrot_big_game", "brainrot_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"brainrot_bloat", "brainrot_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"brainrot_plague", "brainrot_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"cryofreeze_big_game", "cryofreeze_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"cryofreeze_ice_cloud", "cryofreeze_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"cryofreeze_aoe_proc", "cryofreeze_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shadowvortex_big_game", "shadowvortex_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shadowvortex_topple_danger", "shadowvortex_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"shadowvortex_blackhole", "shadowvortex_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"napalmburst_big_game", "napalmburst_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"napalmburst_petrol", "napalmburst_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"napalmburst_pyro", "napalmburst_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"deadwire_big_game", "deadwire_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"deadwire_chain_lightning", "deadwire_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"deadwire_lightning_strike", "deadwire_exotic_mod_3" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"fw_big_game", "fw_exotic_mod_1" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"fw_fire_wheel", "fw_exotic_mod_2" );
    utility::callsharedfunc( #"zombie", #"hash_5ce026fb7bbda595", #"fw_farfalle", "fw_exotic_mod_3" );
}

// Namespace ob_exotic_weapons
// Params 1
// Checksum 0x5cecd799, Offset: 0x728
// Size: 0x1fb
function function_392a02d2215c3496( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "lightmend_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "lightmend_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "lightmend_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shatterblast_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shatterblast_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shatterblast_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "brainrot_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "brainrot_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "brainrot_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "cryofreeze_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "cryofreeze_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "cryofreeze_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shadowvortex_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shadowvortex_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "shadowvortex_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "napalmburst_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "napalmburst_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "napalmburst_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "deadwire_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "deadwire_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "deadwire_exotic_mod_3" );
        level [[ params.var_bf34439fc0ca3cec ]]( "fw_exotic_mod_1" );
        level [[ params.var_bf34439fc0ca3cec ]]( "fw_exotic_mod_2" );
        level [[ params.var_bf34439fc0ca3cec ]]( "fw_exotic_mod_3" );
    }
}

// Namespace ob_exotic_weapons
// Params 0
// Checksum 0xcda8fe06, Offset: 0x92b
// Size: 0xe0
function ob_augments_on_player_connect()
{
    obsettings = level.var_bb86f77304f193c4;
    zombie_augments_array = obsettings.zombie_augments;
    
    foreach ( var_358c2e9b08399e08 in zombie_augments_array )
    {
        if ( var_358c2e9b08399e08.augmentbundle )
        {
            zombie_augment_player = getscriptbundle( var_358c2e9b08399e08.augmentbundle );
            utility::callsharedfunc( #"zombie", #"hash_d99535fac86238ac", zombie_augment_player.augmentname, 1 );
        }
    }
}

// Namespace ob_exotic_weapons
// Params 1
// Checksum 0x1b0a52c9, Offset: 0xa13
// Size: 0x40
function function_f4138abeeda58196( dmg_struct )
{
    if ( dmg_struct.objweapon.basename == "sat_sn_baltic_mp" )
    {
        idamage = function_6e241c31302c29f0( dmg_struct );
    }
    
    return idamage;
}

// Namespace ob_exotic_weapons
// Params 1
// Checksum 0x50eb7ef3, Offset: 0xa5c
// Size: 0x71
function function_6e241c31302c29f0( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( dmg_struct.smeansofdeath == "MOD_EXPLOSIVE_BULLET" && dmg_struct.objweapon hasattachmenthash( %"sat_ub_crossbar_sn_baltic" ) && dmg_struct.shitloc == "none" )
    {
        idamage /= 5;
    }
    
    return idamage;
}

