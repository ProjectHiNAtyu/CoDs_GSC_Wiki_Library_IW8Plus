// scripts\mp\common\supers\super_launchers.gsc  (hash_3bdb006c4be26d1c.gscc) (size: 1942 Bytes / 0x796 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d65954 (97933652)
// size ...... 1942 (0x796)
// includes .. 1   (offset: 0x77e)
// strings ... 1   (offset: 0x786)
// dev strs .. 0   (offset: 0x796)
// exports ... 10  (offset: 0x42a)
// cseg ...... 0x77 + 0x3b3 (0x42a)
// imports ... 14  (offset: 0x5ba)
// animtree1 . 0   (offset: 0x796)
// animtree2 . 0   (offset: 0x796)
#using scripts\common\utility;

#namespace super_launchers;

// Namespace super_launchers
// Params 0, eflags: 0x1
// Checksum 0x574c42f6, Offset: 0x95
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"super_launcher", #"init", &super_launchers_init );
}

// Namespace super_launchers
// Params 0
// Checksum 0x42dcdc04, Offset: 0xbd
// Size: 0x98
function super_launchers_init()
{
    utility::registersharedfunc( #"super_launcher", #"launcher_set", &super_launcher_set );
    utility::registersharedfunc( #"super_launcher", #"launcher_unset", &super_launcher_unset );
    utility::registersharedfunc( #"super_launcher", #"launcher_begin_use", &function_f7041c9292e185ae );
    utility::registersharedfunc( #"super_launcher", #"hash_8a3d7d37704cafeb", &function_960391f7aab8f446 );
    utility::registersharedfunc( #"super_launcher", #"launcher_repeat", &function_642068e75b1eeb6e );
}

// Namespace super_launchers
// Params 0
// Checksum 0xe8ceaf28, Offset: 0x15d
// Size: 0x195
function function_642068e75b1eeb6e()
{
    if ( !utility::issharedfuncdefined( #"supers", #"setsuperisactive" ) || !utility::issharedfuncdefined( #"supers", #"hash_45a211ad5df3fd3" ) || !utility::issharedfuncdefined( #"supers", #"hash_8335f6d0d955d36" ) )
    {
        return;
    }
    
    self [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 1 );
    superinfo = self [[ utility::getsharedfunc( #"supers", #"hash_45a211ad5df3fd3" ) ]]();
    clipammo = superinfo.staticdata.useweaponclipammo;
    stockammo = superinfo.staticdata.useweaponstockammo;
    
    if ( isdefined( superinfo.var_af5bd93c7223b946 ) )
    {
        clipammo = superinfo.var_af5bd93c7223b946;
    }
    
    if ( isdefined( superinfo.var_c25aa4af3452dc6 ) )
    {
        stockammo = superinfo.var_c25aa4af3452dc6;
    }
    
    result = [[ utility::getsharedfunc( #"supers", #"hash_8335f6d0d955d36" ) ]]( superinfo.staticdata.useweapon, clipammo, stockammo );
    
    if ( result )
    {
        self [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 1 );
    }
    else
    {
        self [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 0 );
    }
    
    return result;
}

// Namespace super_launchers
// Params 0
// Checksum 0x299b11be, Offset: 0x2fb
// Size: 0x13, Type: bool
function function_f7041c9292e185ae()
{
    function_fc4842358d04761c( 0 );
    thread function_c4eb67f282a14190();
    return true;
}

// Namespace super_launchers
// Params 1
// Checksum 0x11f13b0a, Offset: 0x317
// Size: 0x15
function function_960391f7aab8f446( fromdeath )
{
    function_fc4842358d04761c( 1 );
}

// Namespace super_launchers
// Params 0
// Checksum 0x5f877452, Offset: 0x334
// Size: 0xf
function super_launcher_set()
{
    self setclientomnvar( "ui_block_fu_not_ready_error", 1 );
}

// Namespace super_launchers
// Params 0
// Checksum 0x8478099d, Offset: 0x34b
// Size: 0x22
function super_launcher_unset()
{
    self setclientomnvar( "ui_block_fu_not_ready_error", 0 );
    self.var_5f87feddcabb8ed = undefined;
    self.var_db30b7b119be2144 = undefined;
}

// Namespace super_launchers
// Params 1
// Checksum 0x58ff6fc1, Offset: 0x375
// Size: 0x28
function function_fc4842358d04761c( b_value = 0 )
{
    if ( b_value )
    {
        self enableweaponpickup();
        return;
    }
    
    self disableweaponpickup();
}

// Namespace super_launchers
// Params 0
// Checksum 0x6dca059d, Offset: 0x3a5
// Size: 0x85
function function_c4eb67f282a14190()
{
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finish" );
    self endon( #"end_super_select" );
    
    if ( !self.perkpackagedata.istwomode )
    {
        return;
    }
    
    self waittill( #"weapon_change" );
    self [[ utility::getsharedfunc( #"supers", #"setsuperisactive" ) ]]( 0 );
    self [[ utility::getsharedfunc( #"supers", #"setsuperisinuse" ) ]]( 0 );
}

