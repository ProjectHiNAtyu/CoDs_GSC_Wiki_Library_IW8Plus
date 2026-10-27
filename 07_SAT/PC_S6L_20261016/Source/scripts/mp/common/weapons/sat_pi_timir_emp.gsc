// scripts\mp\common\weapons\sat_pi_timir_emp.gsc  (hash_016c06a86fae8411.gscc) (size: 3127 Bytes / 0xc37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7934034 (4153622580)
// size ...... 3127 (0xc37)
// includes .. 8   (offset: 0xbab)
// strings ... 6   (offset: 0xbeb)
// dev strs .. 0   (offset: 0xc37)
// exports ... 8   (offset: 0x69f)
// cseg ...... 0xff + 0x5a0 (0x69f)
// imports ... 33  (offset: 0x7df)
// animtree1 . 0   (offset: 0xc37)
// animtree2 . 0   (offset: 0xc37)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\emp_grenade;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\weapons;

#namespace sat_pi_timir_emp;

// Namespace sat_pi_timir_emp
// Params 0, eflags: 0x5
// Checksum 0x1e86552d, Offset: 0x11d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sat_pi_timir_emp", undefined, undefined, &post_main );
}

// Namespace sat_pi_timir_emp
// Params 0, eflags: 0x4
// Checksum 0xcebb6d67, Offset: 0x13e
// Size: 0xb3
function private post_main()
{
    level callback::add( #"player_weapon_fire", &function_eeb6a1bf01175569 );
    level callback::add( #"player_weapon_change", &function_34f8ce13af820017 );
    level callback::add( #"player_spawned", &function_c8c410eea330bcc6 );
    timir_weapon_name = utility::get_scripted_weapon_name( #"timir_pi" );
    
    if ( !timir_weapon_name )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_5c15fd29ca6d7906" ) )
    {
        rootname = weapon::getweaponrootname( timir_weapon_name );
        utility::callsharedfunc( #"zombie_damage", #"hash_5c15fd29ca6d7906", "sat_emp_grenade_timir", rootname );
    }
}

// Namespace sat_pi_timir_emp
// Params 1, eflags: 0x4
// Checksum 0x6c9ac0c6, Offset: 0x1f9
// Size: 0x18b
function private function_eeb6a1bf01175569( params )
{
    objweapon = params.objweapon;
    
    if ( !objweapon hasattachmenthash( %"hash_7686815276769f43" ) )
    {
        return;
    }
    
    if ( objweapon hasattachmenthash( %"hash_10930f1751cd9848" ) )
    {
        grenadeweapon = weapon::buildweapon( "sat_emp_grenade_timir_pap" );
    }
    else if ( objweapon hasattachmenthash( %"hash_777b20a0005a1ab4" ) )
    {
        grenadeweapon = weapon::buildweapon( "sat_emp_grenade_timir_pap4" );
    }
    else
    {
        grenadeweapon = weapon::buildweapon( "sat_emp_grenade_timir_mp" );
    }
    
    viewpos = self getvieworigin();
    angles = self getplayerangles();
    viewdirection = anglestoforward( angles );
    velocity = viewdirection * 1000;
    var_97af8e11439f1936 = weapon::_launchgrenade( grenadeweapon, viewpos, velocity );
    weapons::grenadeinitialize( var_97af8e11439f1936, grenadeweapon );
    var_97af8e11439f1936.trophy_system_should_ignore = 1;
    var_97af8e11439f1936.glgrenadeparent = objweapon;
    [ var_97af8e11439f1936.detonation_radius ] = function_cc6d8e547793427a( objweapon );
    var_46b89ff6ee630785 = !isdefined( self.var_36baa4936a6d825d ) || self.var_36baa4936a6d825d != objweapon;
    
    if ( var_46b89ff6ee630785 )
    {
        thread function_a0aba1ff78ca58f9( objweapon );
    }
    
    emporigin = function_e3f4eda9c472ac5( var_97af8e11439f1936, objweapon );
    
    if ( isdefined( self ) )
    {
        if ( !isdefined( emporigin ) )
        {
            emporigin = viewpos;
        }
        
        emp_grenade::emp_apply_effect( var_97af8e11439f1936, emporigin, 0, 1, 0 );
    }
}

// Namespace sat_pi_timir_emp
// Params 2, eflags: 0x4
// Checksum 0xad327286, Offset: 0x38c
// Size: 0x59
function private function_e3f4eda9c472ac5( var_97af8e11439f1936, objweapon )
{
    var_97af8e11439f1936 endon( #"death" );
    weapon_utility::function_502496613f00eb2a( var_97af8e11439f1936.weapon_object, objweapon );
    utility::waittill_any_timeout( 0.1, "missile_impact" );
    var_97af8e11439f1936 detonate();
    return var_97af8e11439f1936.origin;
}

// Namespace sat_pi_timir_emp
// Params 1, eflags: 0x4
// Checksum 0x1d72a5c3, Offset: 0x3ee
// Size: 0x13f
function private function_a0aba1ff78ca58f9( weapon )
{
    self notify( #"hash_e5d28d4e01a9faa1" );
    self endon( #"death" );
    self endon( #"hash_e5d28d4e01a9faa1" );
    self.var_36baa4936a6d825d = weapon;
    pap_lvl = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
    
    if ( pap_lvl >= 1 )
    {
        rechargetime = 5;
    }
    else
    {
        rechargetime = 10;
    }
    
    clipsize = weaponclipsize( weapon );
    rechargeinterval = 0.1;
    rechargecount = rechargetime / rechargeinterval;
    rechargeammo = 100 / rechargecount;
    
    while ( true )
    {
        wait rechargeinterval;
        
        if ( !self hasweapon( weapon ) )
        {
            self.var_36baa4936a6d825d = undefined;
            return;
        }
        
        var_bebd61b0c3dcc0e1 = self getweaponammoclip( weapon );
        
        if ( var_bebd61b0c3dcc0e1 >= clipsize )
        {
            self playsoundtoplayer( "wpn_pi_timir_fire_emp_plr_charged", self );
            self.var_36baa4936a6d825d = undefined;
            return;
        }
        
        var_bebd61b0c3dcc0e1 = int( min( clipsize, var_bebd61b0c3dcc0e1 + rechargeammo ) );
        self setweaponammoclip( weapon, var_bebd61b0c3dcc0e1 );
        
        if ( var_bebd61b0c3dcc0e1 >= clipsize )
        {
            self playsoundtoplayer( "wpn_pi_timir_fire_emp_plr_charged", self );
            self.var_36baa4936a6d825d = undefined;
            return;
        }
    }
}

// Namespace sat_pi_timir_emp
// Params 1, eflags: 0x4
// Checksum 0xbed17c6c, Offset: 0x535
// Size: 0x141
function private function_34f8ce13af820017( params )
{
    objweapon = params.weapon;
    
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    if ( objweapon hasattachmenthash( %"hash_7686815276769f43" ) )
    {
        var_46b89ff6ee630785 = !isdefined( self.var_36baa4936a6d825d ) || self.var_36baa4936a6d825d != objweapon;
        
        if ( var_46b89ff6ee630785 && self getweaponammoclip( objweapon ) < weaponclipsize( objweapon ) )
        {
            thread function_a0aba1ff78ca58f9( objweapon );
        }
        
        return;
    }
    
    if ( isdefined( self.var_36baa4936a6d825d ) )
    {
        var_7c37841aa03ab4f7 = undefined;
        
        foreach ( weapon in self.primaryweapons )
        {
            if ( weapon hasattachmenthash( %"hash_7686815276769f43" ) )
            {
                var_7c37841aa03ab4f7 = 1;
                break;
            }
        }
        
        if ( !var_7c37841aa03ab4f7 )
        {
            self.var_36baa4936a6d825d = undefined;
            self notify( #"hash_e5d28d4e01a9faa1" );
            return;
        }
    }
}

// Namespace sat_pi_timir_emp
// Params 1, eflags: 0x4
// Checksum 0x27429e9a, Offset: 0x67e
// Size: 0x21
function private function_c8c410eea330bcc6( params )
{
    params.player.var_36baa4936a6d825d = undefined;
}

