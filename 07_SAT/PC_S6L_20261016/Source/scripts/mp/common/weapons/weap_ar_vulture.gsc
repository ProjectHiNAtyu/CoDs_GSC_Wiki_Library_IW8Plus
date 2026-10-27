// scripts\mp\common\weapons\weap_ar_vulture.gsc  (hash_7eb702eaf50021d1.gscc) (size: 1622 Bytes / 0x656 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14d8cb5d (349752157)
// size ...... 1622 (0x656)
// includes .. 3   (offset: 0x5ee)
// strings ... 4   (offset: 0x606)
// dev strs .. 0   (offset: 0x656)
// exports ... 5   (offset: 0x3ea)
// cseg ...... 0xf3 + 0x2f7 (0x3ea)
// imports ... 11  (offset: 0x4b2)
// animtree1 . 0   (offset: 0x656)
// animtree2 . 0   (offset: 0x656)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace weap_ar_vulture;

// Namespace weap_ar_vulture
// Params 0, eflags: 0x5
// Checksum 0x3996ca14, Offset: 0x111
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"vulture_ar", undefined, &init, undefined );
}

// Namespace weap_ar_vulture
// Params 0, eflags: 0x4
// Checksum 0xe2e386b4, Offset: 0x132
// Size: 0x31
function private init()
{
    weapon_name = utility::get_scripted_weapon_name( #"vulture_ar" );
    level callback::add( "on_add_pap_attachments", &on_add_pap_attachment, weapon_name );
}

// Namespace weap_ar_vulture
// Params 2, eflags: 0x4
// Checksum 0xc0fac215, Offset: 0x16b
// Size: 0x1ee
function private on_add_pap_attachment( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_underbarrel_dual_fire_ar_vulture_pap" ) )
    {
        index = attachment_exist( params.attachments, "sat_underbarrel_dual_fire_ar_vulture" );
        pap_lvl = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", params.weapon );
        
        if ( pap_lvl >= 3 )
        {
            papindex = attachment_exist( params.attachments, "sat_underbarrel_dual_fire_ar_vulture_pap" );
        }
        else
        {
            papindex = undefined;
        }
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_underbarrel_dual_fire_ar_vulture_pap";
            params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture" ] = undefined;
            return;
        }
        
        if ( isdefined( papindex ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture_pap" ];
            params.attachments[ papindex ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_underbarrel_dual_fire_ar_vulture_pap4";
            params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture_pap4" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_underbarrel_dual_fire_ar_vulture_pap" ] = undefined;
        }
    }
}

// Namespace weap_ar_vulture
// Params 2, eflags: 0x4
// Checksum 0xfa36e59, Offset: 0x361
// Size: 0x88
function private attachment_exist( attachments, target )
{
    foreach ( index, name in attachments )
    {
        if ( name == target )
        {
            return index;
        }
    }
}

