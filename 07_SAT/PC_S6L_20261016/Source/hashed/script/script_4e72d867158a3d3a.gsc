// script_4e72d867158a3d3a  (hash_4e72d867158a3d3a.gscc) (size: 1327 Bytes / 0x52f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9401689d (2483120285)
// size ...... 1327 (0x52f)
// includes .. 3   (offset: 0x4e3)
// strings ... 4   (offset: 0x4fb)
// dev strs .. 0   (offset: 0x52f)
// exports ... 5   (offset: 0x31b)
// cseg ...... 0xc2 + 0x259 (0x31b)
// imports ... 9   (offset: 0x3e3)
// animtree1 . 0   (offset: 0x52f)
// animtree2 . 0   (offset: 0x52f)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_33624f85d78f33f0;

// Namespace namespace_33624f85d78f33f0
// Params 0, eflags: 0x5
// Checksum 0x71736cdb, Offset: 0xe0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"tasman_dm", undefined, &init, undefined );
}

// Namespace namespace_33624f85d78f33f0
// Params 0, eflags: 0x4
// Checksum 0x62893d2, Offset: 0x101
// Size: 0xb8
function private init()
{
    weapon_name = utility::get_scripted_weapon_name( #"tasman_dm" );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = weapon_name;
    
    if ( !isdefined( level.var_35e19e0af705d62e ) )
    {
        level.var_35e19e0af705d62e = [];
    }
    
    level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = weapon_name;
    
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = weapon_name;
    level callback::add( "on_add_pap_attachments", &on_add_pap_attachment, weapon_name );
}

// Namespace namespace_33624f85d78f33f0
// Params 2, eflags: 0x4
// Checksum 0x7c080949, Offset: 0x1c1
// Size: 0xc9
function private on_add_pap_attachment( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_reflex04_dmr" ) )
    {
        index = attachment_exist( params.attachments, "sat_zm_dm_tasman_pack" );
        index2 = attachment_exist( params.attachments, "sat_zm_dm_corrupted_tasman_pack" );
        
        if ( isdefined( index ) || isdefined( index2 ) )
        {
            params.attachments[ params.attachments.size ] = "sat_reflex04_dmr";
        }
    }
}

// Namespace namespace_33624f85d78f33f0
// Params 2, eflags: 0x4
// Checksum 0x92339d90, Offset: 0x292
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

