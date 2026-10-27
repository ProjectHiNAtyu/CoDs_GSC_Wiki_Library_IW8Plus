// scripts\common\damage_tuning.gsc  (hash_439fa02b5251fa5b.gscc) (size: 2703 Bytes / 0xa8f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x876793ff (2271712255)
// size ...... 2703 (0xa8f)
// includes .. 0   (offset: 0xa6b)
// strings ... 0   (offset: 0xa6b)
// dev strs .. 3   (offset: 0xa6b)
// exports ... 6   (offset: 0x813)
// cseg ...... 0x58 + 0x7bb (0x813)
// imports ... 10  (offset: 0x903)
// animtree1 . 0   (offset: 0xa8f)
// animtree2 . 0   (offset: 0xa8f)
#namespace damage_tuning;

// Namespace damage_tuning
// Params 0
// Checksum 0x92086e0d, Offset: 0x76
// Size: 0x4c
function init()
{
    level.var_deb9d2b3de25799b = isdefined( level.gametypebundle ) && level.gametypebundle.var_82bc75c9ed13b34d;
    
    /#
        if ( getdvarint( @"hash_e600610a3da3e873", 0 ) > 0 )
        {
            level.var_deb9d2b3de25799b = 0;
        }
    #/
}

// Namespace damage_tuning
// Params 1
// Checksum 0xef9a258d, Offset: 0xca
// Size: 0x14e
function function_c851d31a9ad2e67( bundle )
{
    if ( isarray( bundle.var_20cb8f4e47f3353e.damagemultipliers ) && bundle.var_20cb8f4e47f3353e.damagemultipliers.size == 0 )
    {
        bundle.var_20cb8f4e47f3353e.damagemultipliers = undefined;
    }
    
    if ( isarray( bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e ) && bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e.size == 0 )
    {
        bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e = undefined;
    }
    
    if ( isarray( bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500 ) && bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500.size == 0 )
    {
        bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500 = undefined;
    }
    
    if ( !isdefined( bundle.var_20cb8f4e47f3353e.damagemultipliers ) && !isdefined( bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e ) && !isdefined( bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500 ) )
    {
        bundle.var_20cb8f4e47f3353e = undefined;
    }
}

// Namespace damage_tuning
// Params 2
// Checksum 0xe0e30619, Offset: 0x220
// Size: 0x1bc
function function_8118e38bf1ed06de( damagedata, var_20cb8f4e47f3353e )
{
    if ( !level.var_deb9d2b3de25799b )
    {
        return 0;
    }
    
    var_468292eb981ddd5e = var_20cb8f4e47f3353e.var_468292eb981ddd5e;
    
    if ( !isdefined( var_468292eb981ddd5e ) )
    {
        return 0;
    }
    
    meansofdeath = damagedata.meansofdeath;
    
    if ( isstring( meansofdeath ) )
    {
        meansofdeath = getxhash( meansofdeath );
    }
    
    thisweaponclass = weaponclass( damagedata.objweapon );
    
    if ( isstring( thisweaponclass ) )
    {
        thisweaponclass = getxhash( thisweaponclass );
    }
    
    if ( !isdefined( thisweaponclass ) )
    {
        thisweaponclass = #"unspecified_weapon_class";
    }
    
    if ( !isdefined( meansofdeath ) )
    {
        meansofdeath = #"unspecified_mod";
    }
    
    var_f79fbe845fe4b22e = damagedata.objweapon.damagemodcategory ?? #"";
    
    foreach ( var_bc51cf55c449daf4 in var_468292eb981ddd5e )
    {
        if ( var_bc51cf55c449daf4.weaponclass && var_bc51cf55c449daf4.weaponclass != thisweaponclass )
        {
            continue;
        }
        
        if ( var_bc51cf55c449daf4.meansofdeath && var_bc51cf55c449daf4.meansofdeath != meansofdeath )
        {
            continue;
        }
        
        if ( var_bc51cf55c449daf4.damagemodcategory && var_bc51cf55c449daf4.damagemodcategory != var_f79fbe845fe4b22e )
        {
            continue;
        }
        
        return var_bc51cf55c449daf4.var_468292eb981ddd5e;
    }
    
    return 0;
}

// Namespace damage_tuning
// Params 7
// Checksum 0x964f6014, Offset: 0x3e5
// Size: 0x3ec
function getmodifieddamageusingdamagetuning( attacker, objweapon, mod, damageamount, maxhealth, var_20cb8f4e47f3353e, data )
{
    inflictor = data.inflictor;
    iskillstreak = data.iskillstreak || data.biskillstreak;
    hitstokill = var_20cb8f4e47f3353e.var_16354dd59a9c5500;
    
    /#
        if ( hitstokill )
        {
            if ( !isdefined( maxhealth ) )
            {
                assertmsg( "<dev string:x24>" );
            }
        }
    #/
    
    if ( isdefined( hitstokill ) && isdefined( maxhealth ) )
    {
        if ( isstring( mod ) )
        {
            mod = getxhash( mod );
        }
        
        thisweaponclass = weaponclass( objweapon );
        
        if ( isstring( thisweaponclass ) )
        {
            thisweaponclass = getxhash( thisweaponclass );
        }
        
        if ( !isdefined( thisweaponclass ) )
        {
            thisweaponclass = #"unspecified_weapon_class";
        }
        
        if ( !isdefined( mod ) )
        {
            mod = #"unspecified_mod";
        }
        
        var_f79fbe845fe4b22e = objweapon.damagemodcategory ?? #"";
        
        foreach ( var_6b65935644fbd600 in hitstokill )
        {
            if ( var_6b65935644fbd600.weaponclass && var_6b65935644fbd600.weaponclass != thisweaponclass )
            {
                continue;
            }
            
            if ( var_6b65935644fbd600.meansofdeath && var_6b65935644fbd600.meansofdeath != mod )
            {
                continue;
            }
            
            if ( var_6b65935644fbd600.damagemodcategory && var_6b65935644fbd600.damagemodcategory != var_f79fbe845fe4b22e )
            {
                continue;
            }
            
            hitstokillamount = var_6b65935644fbd600.hitstokill;
            
            if ( hitstokillamount <= 0 )
            {
                assertmsg( "<dev string:x6b>" + hitstokillamount + "<dev string:x78>" );
                continue;
            }
            
            var_7ee550b53f0a7079 = 1;
            
            if ( iskillstreak && inflictor.var_7ee550b53f0a7079 )
            {
                var_7ee550b53f0a7079 = inflictor.var_7ee550b53f0a7079;
            }
            
            return int( ceil( float( maxhealth ) / hitstokillamount * var_7ee550b53f0a7079 ) );
        }
    }
    
    multipliers = var_20cb8f4e47f3353e.damagemultipliers;
    
    if ( isdefined( multipliers ) )
    {
        if ( isstring( mod ) )
        {
            mod = getxhash( mod );
        }
        
        if ( !isdefined( thisweaponclass ) )
        {
            thisweaponclass = weaponclass( objweapon );
        }
        
        if ( isstring( thisweaponclass ) )
        {
            thisweaponclass = getxhash( thisweaponclass );
        }
        
        if ( !isdefined( thisweaponclass ) )
        {
            thisweaponclass = #"unspecified_weapon_class";
        }
        
        if ( !isdefined( mod ) )
        {
            mod = #"unspecified_mod";
        }
        
        if ( !isdefined( var_f79fbe845fe4b22e ) )
        {
            var_f79fbe845fe4b22e = objweapon.damagemodcategory ?? #"";
        }
        
        foreach ( currentmultiplier in multipliers )
        {
            if ( currentmultiplier.weaponclass && currentmultiplier.weaponclass != thisweaponclass )
            {
                continue;
            }
            
            if ( currentmultiplier.meansofdeath && currentmultiplier.meansofdeath != mod )
            {
                continue;
            }
            
            if ( currentmultiplier.damagemodcategory && currentmultiplier.damagemodcategory != var_f79fbe845fe4b22e )
            {
                continue;
            }
            
            return int( ceil( currentmultiplier.multiplier * damageamount ) );
        }
    }
    
    return int( damageamount );
}

// Namespace damage_tuning
// Params 2
// Checksum 0x5d805087, Offset: 0x7da
// Size: 0x39
function setupdamagetuning( var_20cb8f4e47f3353e, maxhealth )
{
    if ( !level.var_deb9d2b3de25799b )
    {
        return;
    }
    
    self.var_20cb8f4e47f3353e = var_20cb8f4e47f3353e;
    self.maxhealth = maxhealth;
}

