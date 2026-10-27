// script_10565ccf5e259f17  (hash_10565ccf5e259f17.gscc) (size: 1536 Bytes / 0x600 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa0b7c329 (2696397609)
// size ...... 1536 (0x600)
// includes .. 4   (offset: 0x59c)
// strings ... 4   (offset: 0x5bc)
// dev strs .. 0   (offset: 0x600)
// exports ... 5   (offset: 0x39c)
// cseg ...... 0xbb + 0x2e1 (0x39c)
// imports ... 11  (offset: 0x464)
// animtree1 . 0   (offset: 0x600)
// animtree2 . 0   (offset: 0x600)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_c7e678ad1cc5e25;

// Namespace namespace_c7e678ad1cc5e25
// Params 0, eflags: 0x5
// Checksum 0x80ab2da5, Offset: 0xd9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sat_pi_alcor_pap", undefined, &init, undefined );
}

// Namespace namespace_c7e678ad1cc5e25
// Params 0, eflags: 0x4
// Checksum 0xf7f0d2ac, Offset: 0xfa
// Size: 0xb8
function private init()
{
    weapon_name = utility::get_scripted_weapon_name( #"sat_pi_alcor_pap" );
    
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

// Namespace namespace_c7e678ad1cc5e25
// Params 2, eflags: 0x4
// Checksum 0x83ebd2ce, Offset: 0x1ba
// Size: 0x151
function private on_add_pap_attachment( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( game_utility::function_d68874417f3eea5c() )
    {
        index = attachment_exist( params.attachments, "sat_stock_akimbo_pi_alcor" );
        
        if ( !isdefined( index ) )
        {
            params.attachments[ params.attachments.size ] = "sat_stock_akimbo_pi_alcor";
        }
    }
    
    if ( params.weapon canuseattachment( "sat_rec_pi_alcor_pap" ) )
    {
        index = attachment_exist( params.attachments, "sat_rec_pi_alcor" );
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_pi_alcor" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_pi_alcor_pap";
            params.var_f1614eef81f0bdd2[ "sat_rec_pi_alcor_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_pi_alcor" ] = undefined;
        }
    }
}

// Namespace namespace_c7e678ad1cc5e25
// Params 2, eflags: 0x4
// Checksum 0x9470f045, Offset: 0x313
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

