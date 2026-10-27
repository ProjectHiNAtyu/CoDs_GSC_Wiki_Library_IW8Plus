// script_11d21fa5947d39aa  (hash_11d21fa5947d39aa.gscc) (size: 2553 Bytes / 0x9f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8e34dcd (4175646157)
// size ...... 2553 (0x9f9)
// includes .. 4   (offset: 0x99d)
// strings ... 5   (offset: 0x9bd)
// dev strs .. 0   (offset: 0x9f9)
// exports ... 9   (offset: 0x545)
// cseg ...... 0xa4 + 0x4a1 (0x545)
// imports ... 26  (offset: 0x6ad)
// animtree1 . 0   (offset: 0x9f9)
// animtree2 . 0   (offset: 0x9f9)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_9041bd74b4ce6aee;

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0x5
// Checksum 0x9cde5742, Offset: 0xc2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e05480c52c7f6e8b", undefined, undefined, &post_main );
}

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0x1
// Checksum 0xdcdd9f21, Offset: 0xe3
// Size: 0x18
function autoexec main()
{
    level callback::add( #"missile_fire", &function_85a13dae44241367 );
}

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0x4
// Checksum 0xe7cbcc45, Offset: 0x103
// Size: 0x3b
function private post_main()
{
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_17fdfda41f9aa95a );
    }
}

// Namespace namespace_9041bd74b4ce6aee
// Params 1, eflags: 0x4
// Checksum 0x6349b4c1, Offset: 0x146
// Size: 0xfb
function private function_85a13dae44241367( var_1257ca33be4bdda3 )
{
    missile = var_1257ca33be4bdda3.missile;
    
    if ( !missile.weapon_object hasattachmenthash( %"sat_bar_spear_ar_falcon" ) )
    {
        return;
    }
    
    owner = missile.owner;
    
    if ( !isdefined( owner.var_29944b4dfaa4a29 ) )
    {
        owner.var_29944b4dfaa4a29 = [];
    }
    
    owner.var_29944b4dfaa4a29 = function_5713d46873b29625( owner.var_29944b4dfaa4a29 );
    owner.var_29944b4dfaa4a29[ owner.var_29944b4dfaa4a29.size ] = missile;
    
    if ( owner.var_29944b4dfaa4a29.size > 4 )
    {
        owner.var_29944b4dfaa4a29[ 0 ] function_59fce2d6f9e30f09();
        owner.var_29944b4dfaa4a29[ 0 ] = undefined;
        function_cdc669dbc8ea2101( owner.var_29944b4dfaa4a29 );
    }
    
    missile thread function_87c35f06a1d64169();
    owner thread function_7969e7cd68600ef8();
}

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0xc
// Checksum 0x5c98b7c7, Offset: 0x249
// Size: 0xc1
function private function_7969e7cd68600ef8()
{
    self notify( #"hash_4fb66f3415174fe0" );
    self endon( #"hash_4fb66f3415174fe0" );
    level utility::waittill_any_ents( self, "disconnect", level, "game_ended" );
    
    if ( self.var_29944b4dfaa4a29 )
    {
        foreach ( spear in self.var_29944b4dfaa4a29 )
        {
            spear function_59fce2d6f9e30f09();
        }
    }
    
    if ( self )
    {
        self.var_29944b4dfaa4a29 = undefined;
    }
}

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0x4
// Checksum 0xb66b8716, Offset: 0x312
// Size: 0x18
function private function_87c35f06a1d64169()
{
    self endon( #"death" );
    wait 10;
    function_59fce2d6f9e30f09();
}

// Namespace namespace_9041bd74b4ce6aee
// Params 0, eflags: 0x4
// Checksum 0x6fbef66f, Offset: 0x332
// Size: 0xc
function private function_59fce2d6f9e30f09()
{
    if ( self )
    {
        self delete();
    }
}

// Namespace namespace_9041bd74b4ce6aee
// Params 1, eflags: 0x4
// Checksum 0x56b5869c, Offset: 0x346
// Size: 0x1fe
function private function_17fdfda41f9aa95a( dmg_struct )
{
    if ( dmg_struct.sweapon.basename != "sat_ar_falcon_mp" )
    {
        return dmg_struct.idamage;
    }
    
    if ( dmg_struct.smeansofdeath != "MOD_MELEE" )
    {
        return dmg_struct.idamage;
    }
    
    if ( !dmg_struct.objweapon hasattachmenthash( %"sat_bar_spear_ar_falcon" ) )
    {
        return dmg_struct.idamage;
    }
    
    idamage = dmg_struct.idamage;
    
    if ( isdefined( dmg_struct.einflictor ) )
    {
        clipsize = dmg_struct.einflictor getweaponammoclip( dmg_struct.sweapon );
    }
    
    var_951c89546ec50477 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isplayer( dmg_struct.eattacker ) )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
    }
    
    if ( clipsize == 1 && var_951c89546ec50477 > 0 )
    {
        current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        
        if ( utility::issharedfuncdefined( #"zombie_utils", #"get_zombie_round_difficulty" ) )
        {
            boss_round = isalive( self ) ? utility::callsharedfunc( #"zombie_utils", #"get_zombie_round_difficulty" ) : undefined;
        }
        
        if ( isdefined( boss_round ) )
        {
            var_4feed796664d10af = int( max( current_round, boss_round ) );
        }
        else
        {
            var_4feed796664d10af = current_round;
        }
        
        base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", var_4feed796664d10af );
        
        if ( isdefined( base_zombie_max_health ) )
        {
            idamage = int( max( base_zombie_max_health * 1.55, idamage ) );
        }
    }
    else
    {
        idamage = 200;
    }
    
    return idamage;
}

