// script_20c120b1e408a3ae  (hash_20c120b1e408a3ae.gscc) (size: 2197 Bytes / 0x895 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf3755c (183727452)
// size ...... 2197 (0x895)
// includes .. 3   (offset: 0x811)
// strings ... 6   (offset: 0x829)
// dev strs .. 0   (offset: 0x895)
// exports ... 7   (offset: 0x52d)
// cseg ...... 0xd2 + 0x45b (0x52d)
// imports ... 16  (offset: 0x645)
// animtree1 . 0   (offset: 0x895)
// animtree2 . 0   (offset: 0x895)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_405c764b198631d8;

// Namespace namespace_405c764b198631d8
// Params 0, eflags: 0x5
// Checksum 0x3f3e972f, Offset: 0xf0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_6613cc629cc0296b", undefined, &init, undefined );
}

// Namespace namespace_405c764b198631d8
// Params 0, eflags: 0x4
// Checksum 0xe755c5a4, Offset: 0x111
// Size: 0xea
function private init()
{
    var_8d73b02173c92675 = utility::get_scripted_weapon_name( #"raygun_mark_2" );
    assert( isdefined( var_8d73b02173c92675 ) );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = var_8d73b02173c92675;
    
    if ( !isdefined( level.var_35e19e0af705d62e ) )
    {
        level.var_35e19e0af705d62e = [];
    }
    
    level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = var_8d73b02173c92675;
    
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = var_8d73b02173c92675;
    level.var_f7d8c385fccc43b4[ var_8d73b02173c92675 ] = &function_4a85aee53ee7389a;
    callback::add( #"hash_47152191e641a442", &function_8311147f6bbc8a77 );
    level callback::add( "on_add_pap_attachments", &function_6c5eb3576be0351e, var_8d73b02173c92675 );
}

// Namespace namespace_405c764b198631d8
// Params 1
// Checksum 0xc883c4be, Offset: 0x203
// Size: 0x46
function function_4a85aee53ee7389a( dmg_struct )
{
    if ( self.aicategory == "boss" )
    {
        dmg_struct.idamage *= 0.3;
    }
    
    return dmg_struct.idamage;
}

// Namespace namespace_405c764b198631d8
// Params 1, eflags: 0x4
// Checksum 0xd41da0f, Offset: 0x252
// Size: 0x53, Type: bool
function private function_8311147f6bbc8a77( params )
{
    if ( issubstr( params.newweapon.basename, "raygun" ) && issubstr( params.oldweapon.basename, "raygun" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_405c764b198631d8
// Params 2, eflags: 0x4
// Checksum 0x2ac31c1c, Offset: 0x2ae
// Size: 0x1ee
function private function_6c5eb3576be0351e( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_rec_raygunmark2_pap" ) )
    {
        index = attachment_exist( params.attachments, "sat_rec_raygunmark2" );
        pap_lvl = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", params.weapon );
        
        if ( pap_lvl >= 3 )
        {
            papindex = attachment_exist( params.attachments, "sat_rec_raygunmark2_pap" );
        }
        else
        {
            papindex = undefined;
        }
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_raygunmark2_pap";
            params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2" ] = undefined;
            return;
        }
        
        if ( isdefined( papindex ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2_pap" ];
            params.attachments[ papindex ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_raygunmark2_pap4";
            params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2_pap4" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_raygunmark2_pap" ] = undefined;
        }
    }
}

// Namespace namespace_405c764b198631d8
// Params 2, eflags: 0x4
// Checksum 0x5c3a9fb8, Offset: 0x4a4
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

