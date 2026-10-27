// scripts\mp\ob\skills\skill_damage_upgrade.gsc  (hash_48437a83a49fc22f.gscc) (size: 4755 Bytes / 0x1293 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x970f1f85 (2534350725)
// size ...... 4755 (0x1293)
// includes .. 6   (offset: 0x123f)
// strings ... 3   (offset: 0x126f)
// dev strs .. 0   (offset: 0x1293)
// exports ... 15  (offset: 0xa8b)
// cseg ...... 0x83 + 0xa08 (0xa8b)
// imports ... 47  (offset: 0xce3)
// animtree1 . 0   (offset: 0x1293)
// animtree2 . 0   (offset: 0x1293)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\weapon;

#namespace skill_damage_upgrade;

// Namespace skill_damage_upgrade
// Params 0, eflags: 0x1
// Checksum 0x7459b7be, Offset: 0xa1
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"damage_upgrade", &init );
}

// Namespace skill_damage_upgrade
// Params 0
// Checksum 0xf7cf48b, Offset: 0xc0
// Size: 0xa7
function init()
{
    utility::registersharedfunc( #"damage_upgrade", #"ongiveskill", &function_a9f11ead789f9fea );
    utility::registersharedfunc( #"damage_upgrade", #"hash_4aa03f4559ac50a5", &function_e8c8ee8ca60f201d );
    utility::registersharedfunc( #"damage_upgrade", #"hash_b39175d78cf5b360", &function_4e3fca69a0a31ad8 );
    utility::registersharedfunc( #"zombie_damage", #"hash_8a5422fcea1951e4", &function_d58c577b1023f91 );
    agent_utils::register_soldier_damage_callback( &function_e164d2298e7c1492 );
    level callback::add( #"player_weapon_change", &function_dfa1b067caaef69c );
    level.var_37f0dad872bed468 = 1;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0x8bd0617a, Offset: 0x16f
// Size: 0x9a, Type: bool
function function_a9f11ead789f9fea( skill_bundle )
{
    if ( skill_bundle )
    {
        self setclientomnvar( "ui_ob_damage_skill_level", skill_bundle.skilllevel + 1 );
        weapon = self getcurrentweapon();
        function_8131dfe794fe4065( weapon );
        self.var_4e1122995a3e50c8 = skill_bundle.var_c7aca2b75351002a;
        self.brainrot_damage_multiplier = skill_bundle.brainrotdamagemultiplier;
        self.var_f6ce3f6c3c2ead86 = { #bundle:skill_bundle };
        callback::add( #"hash_2346898712859996", &function_88c286ecff22b8f0 );
        return true;
    }
    
    return false;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0xe007f767, Offset: 0x212
// Size: 0x5d, Type: bool
function function_e8c8ee8ca60f201d( skill_bundle )
{
    if ( isdefined( self.var_f6ce3f6c3c2ead86 ) )
    {
        if ( callback::exists( #"hash_2346898712859996", &function_88c286ecff22b8f0 ) )
        {
            callback::remove( #"hash_2346898712859996", &function_88c286ecff22b8f0 );
        }
        
        self.var_4e1122995a3e50c8 = undefined;
        self.var_f6ce3f6c3c2ead86 = undefined;
        return true;
    }
    
    return false;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0xbc7d86, Offset: 0x278
// Size: 0x45
function function_74f9d24eca55d091( eattacker )
{
    if ( !isplayer( eattacker ) )
    {
        if ( eattacker.owner && isplayer( eattacker.owner ) )
        {
            return eattacker.owner;
        }
    }
    
    return eattacker;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0x98d224a4, Offset: 0x2c6
// Size: 0x6d, Type: bool
function function_e0ae1c99e3cff099( weapon )
{
    if ( !self.var_f6ce3f6c3c2ead86.bundle.var_cd03153b05e9f3da )
    {
        return false;
    }
    
    if ( utility::callsharedfunc( #"skill", #"hash_51e6fd623b95a9a9", weapon, self.var_f6ce3f6c3c2ead86.bundle.var_cd03153b05e9f3da ) )
    {
        return true;
    }
    
    return false;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0x9229c348, Offset: 0x33c
// Size: 0xb2
function function_e164d2298e7c1492( dmgstruct )
{
    if ( dmgstruct.idflags && dmgstruct.idflags & 65536 )
    {
        return dmgstruct.idamage;
    }
    
    objweapon = dmgstruct.objweapon;
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_854b475a5070719a" ) )
    {
        objweapon = utility::callsharedfunc( #"zombie_damage", #"hash_854b475a5070719a", objweapon, dmgstruct.eattacker );
    }
    
    return function_d58c577b1023f91( dmgstruct.idamage, objweapon, dmgstruct.eattacker );
}

// Namespace skill_damage_upgrade
// Params 3
// Checksum 0x2f66f885, Offset: 0x3f7
// Size: 0x132
function function_d58c577b1023f91( idamage, objweapon, eattacker )
{
    oldeattacker = eattacker;
    eattacker = function_74f9d24eca55d091( eattacker );
    
    if ( function_4b95dfff7e92a5da( eattacker, objweapon, oldeattacker ) )
    {
        skilllevel = eattacker.activeskills[ #"damage_upgrade" ] ?? -1;
        obsettings = level.var_bb86f77304f193c4;
        
        if ( obsettings && isdefined( skilllevel ) )
        {
            switch ( skilllevel )
            {
                case -1:
                    return ( idamage * ( obsettings.var_e5b77a357b6033fd ?? 1 ) );
                case 0:
                    return ( idamage * ( obsettings.var_92b58f9e5491e9a4 ?? 4 ) );
                case 1:
                    return ( idamage * ( obsettings.var_92b5929e5491f03d ?? 8 ) );
                case 2:
                    return ( idamage * ( obsettings.var_92b5919e5491ee0a ?? 12 ) );
                case 3:
                    return ( idamage * ( obsettings.var_92b58c9e5491e30b ?? 16 ) );
            }
        }
    }
    
    return idamage;
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0x4eab4d90, Offset: 0x532
// Size: 0x1d8
function function_88c286ecff22b8f0( params )
{
    damagingweapon = params.objweapon;
    attacker = params.eattacker;
    
    if ( isplayer( attacker ) && attacker.activeskills && attacker != params.victim && !attacker function_e0ae1c99e3cff099( damagingweapon ) )
    {
        skilllevel = self.activeskills[ #"damage_upgrade" ];
        obsettings = level.var_bb86f77304f193c4;
        
        if ( obsettings && isdefined( skilllevel ) )
        {
            switch ( skilllevel )
            {
                case -1:
                    params.idamage *= obsettings.var_8733f3a9540b9e0e ?? 1;
                    break;
                case 0:
                    params.idamage *= obsettings.var_62df1c63d58d048d ?? 1.2;
                    break;
                case 1:
                    params.idamage *= obsettings.var_62df1963d58cfdf4 ?? 1.4;
                    break;
                case 2:
                    params.idamage *= obsettings.var_62df1a63d58d0027 ?? 1.6;
                    break;
                case 3:
                    params.idamage *= obsettings.var_62df1763d58cf98e ?? 1.8;
                    break;
            }
        }
    }
}

// Namespace skill_damage_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe76be62a, Offset: 0x712
// Size: 0x196
function private function_8131dfe794fe4065( weapon )
{
    if ( weapon && self.activeskills )
    {
        if ( weapon::isbackuppistol( weapon ) )
        {
            return;
        }
        
        var_e5c7b99409eb1f8b = function_4e3fca69a0a31ad8( weapon );
        
        if ( var_e5c7b99409eb1f8b && !weapon hasattachment( var_e5c7b99409eb1f8b ) )
        {
            new_weapon = weapon withattachment( var_e5c7b99409eb1f8b );
        }
        
        if ( new_weapon )
        {
            clipammo = self getweaponammoclip( weapon );
            stockammo = self getweaponammostock( weapon );
            clipsizeold = weaponclipsize( weapon );
            clipsizenew = weaponclipsize( new_weapon );
            
            if ( clipammo == clipsizeold )
            {
                clipammo = clipsizenew;
            }
            
            var_546a2a6e5ffaf81a = utility::get_max_stock_ammo( weapon, 0 );
            var_606e326e67df2a95 = utility::get_max_stock_ammo( new_weapon, 0 );
            
            if ( stockammo == var_546a2a6e5ffaf81a )
            {
                stockammo = var_606e326e67df2a95;
            }
            else if ( stockammo == clipsizeold * 2 )
            {
                stockammo = clipsizenew * 2;
            }
            
            ammomod = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", weapon );
            self takeweapon( weapon );
            self giveweapon( new_weapon, 0, 0, -1, 1 );
            
            if ( weapon::function_6b74ecd475e99b4( new_weapon ) )
            {
                weapon::function_b4c9549dee5d0fc5( new_weapon );
            }
            else if ( weapon::ismeleeonly( new_weapon ) )
            {
                self assignweaponmeleeslot( new_weapon );
            }
            
            self switchtoweapon( new_weapon );
            self setweaponammoclip( new_weapon, clipammo );
            self setweaponammostock( new_weapon, stockammo );
            
            if ( ammomod )
            {
                utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", new_weapon, ammomod );
            }
        }
    }
}

// Namespace skill_damage_upgrade
// Params 1
// Checksum 0x1d534eec, Offset: 0x8b0
// Size: 0x7b
function function_4e3fca69a0a31ad8( weapon )
{
    skilllevel = self.activeskills[ #"damage_upgrade" ];
    
    if ( !isdefined( skilllevel ) || skilllevel < 0 || skilllevel > 3 )
    {
        return;
    }
    
    skilllevel++;
    gametypekey = "ob";
    
    if ( skilllevel )
    {
        gametypekey += "_tier" + skilllevel;
    }
    
    var_e5c7b99409eb1f8b = getgametypeattachment( weapon, gametypekey );
    return var_e5c7b99409eb1f8b;
}

// Namespace skill_damage_upgrade
// Params 1, eflags: 0x4
// Checksum 0xb24e5b3b, Offset: 0x934
// Size: 0x2c
function private function_dfa1b067caaef69c( params )
{
    weapon = params.weapon;
    function_8131dfe794fe4065( weapon );
}

// Namespace skill_damage_upgrade
// Params 3, eflags: 0x4
// Checksum 0x45fe1165, Offset: 0x968
// Size: 0xac, Type: bool
function private function_4b95dfff7e92a5da( eattacker, damagingweapon, oldeattacker )
{
    if ( !isplayer( eattacker ) || !eattacker.activeskills )
    {
        return false;
    }
    
    if ( eattacker function_e0ae1c99e3cff099( damagingweapon ) || self.var_51facf23c1a1e4a8 )
    {
        return false;
    }
    
    if ( is_super_weapon( eattacker, damagingweapon ) )
    {
        return true;
    }
    
    if ( eattacker.isequipment || oldeattacker.isequipment || damagingweapon.isequipment || weapon::isweaponequipment( damagingweapon ) || weapon::iskillstreakweapon( damagingweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_damage_upgrade
// Params 2, eflags: 0x4
// Checksum 0x762cbd33, Offset: 0xa1d
// Size: 0x6d
function private is_super_weapon( eattacker, objweapon )
{
    var_897afd39d0a1399c = eattacker.super.weaponobj;
    var_28ad4d962dc90b43 = eattacker.tacticalsuper.weaponobj;
    issuperweapon = var_897afd39d0a1399c == objweapon || var_28ad4d962dc90b43 == objweapon;
    return issuperweapon;
}

