// script_573f1205925f676f  (hash_573f1205925f676f.gscc) (size: 2795 Bytes / 0xaeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8adce3a (2829962810)
// size ...... 2795 (0xaeb)
// includes .. 3   (offset: 0xaaf)
// strings ... 2   (offset: 0xac7)
// dev strs .. 0   (offset: 0xaeb)
// exports ... 11  (offset: 0x663)
// cseg ...... 0x74 + 0x5ef (0x663)
// imports ... 22  (offset: 0x81b)
// animtree1 . 0   (offset: 0xaeb)
// animtree2 . 0   (offset: 0xaeb)
#using script_3f14905e6bfa4fbb;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;

#namespace weapon;

// Namespace weapon
// Params 0
// Checksum 0x87f21740, Offset: 0x92
// Size: 0x99
function initweaponarray()
{
    self.weapons = [];
    
    if ( !isnullweapon( self.primaryweapon ) )
    {
        self.weapons[ self.weapons.size ] = self.primaryweapon;
    }
    
    if ( !isnullweapon( self.secondaryweapon ) )
    {
        self.weapons[ self.weapons.size ] = self.secondaryweapon;
    }
    
    if ( !isnullweapon( self.sidearm ) )
    {
        self.weapons[ self.weapons.size ] = self.sidearm;
    }
}

// Namespace weapon
// Params 0
// Checksum 0x2d6e87f0, Offset: 0x133
// Size: 0xea
function choosebestweapon()
{
    if ( self.forcesidearm )
    {
        return "pistol";
    }
    
    if ( self._blackboard.droppedlmg )
    {
        return "pistol";
    }
    
    bestscore = 0;
    bestweaponclass = undefined;
    
    foreach ( weapon in self.weapons )
    {
        weapclass = weaponclass( weapon );
        score = evalweaponscore( weapclass, weapon );
        
        if ( score > bestscore )
        {
            bestscore = score;
            bestweaponclass = weapclass;
        }
    }
    
    return bestweaponclass;
}

// Namespace weapon
// Params 0
// Checksum 0x6f4ca4a3, Offset: 0x226
// Size: 0x49
function getsidearmdist()
{
    var_c6c89cf83a78b267 = utility_common::isusingsidearm();
    sidearmdist = 409;
    bsniper = self aiissniper( 0 );
    
    if ( bsniper )
    {
        sidearmdist = 512;
    }
    
    if ( var_c6c89cf83a78b267 )
    {
        sidearmdist += 36;
    }
    
    return sidearmdist;
}

// Namespace weapon
// Params 0
// Checksum 0xac1aa134, Offset: 0x278
// Size: 0x80, Type: bool
function withinswitchtopistoldist()
{
    if ( isdefined( self.enemy ) && isdefined( self.sidearm ) && !isnullweapon( self.sidearm ) && !self.disablepistol )
    {
        sidearmdist = getsidearmdist();
        disttoenemysq = distancesquared( self.origin, self.enemy.origin );
        return ( disttoenemysq < sidearmdist * sidearmdist );
    }
    
    return false;
}

// Namespace weapon
// Params 2
// Checksum 0xfade798c, Offset: 0x301
// Size: 0x172
function evalweaponscore( weapclass, weapon )
{
    if ( weapclass == "pistol" )
    {
        if ( weaponclass( self.weapon ) == "rocketlauncher" && self.rocketammo <= 0 )
        {
            return 1000;
        }
        
        if ( canswitchtosidearm( undefined ) != anim.success )
        {
            return 0;
        }
        
        covernode = asm_bb::bb_getcovernode();
        
        if ( utility_common::usingmg() && isdefined( covernode ) && !self iscovervalidagainstenemy( covernode ) )
        {
            return 1000;
        }
        
        if ( checkcoverforsidearm( undefined ) != anim.success )
        {
            return 0;
        }
        
        withindist = withinswitchtopistoldist();
        bsniper = self aiissniper( 0 );
        
        if ( withindist )
        {
            assert( isdefined( self.enemy ) );
            disttoenemysq = distancesquared( self.origin, self.enemy.origin );
            
            if ( bsniper )
            {
                return 1000;
            }
            
            if ( utility_common::usingmg() && disttoenemysq < 16384 )
            {
                return 1000;
            }
            
            if ( utility_common::isusingprimary() && combat::hasatleastammo( 0.1 ) )
            {
                return 10;
            }
            
            return 1000;
        }
        
        return 0;
    }
    else if ( weapclass == "rocketlauncher" )
    {
        if ( self.rocketammo <= 0 )
        {
            return 0;
        }
        
        return 100;
    }
    else
    {
        return 100;
    }
    
    return 100;
}

// Namespace weapon
// Params 1
// Checksum 0x5a031865, Offset: 0x47c
// Size: 0x27
function issniper( task )
{
    if ( self aiissniper() )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace weapon
// Params 1
// Checksum 0xaaa2f6f8, Offset: 0x4ac
// Size: 0x47
function usingsidearm( task )
{
    if ( self.weapon == self.sidearm && !isnullweapon( self.weapon ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace weapon
// Params 1
// Checksum 0x1a6a95bb, Offset: 0x4fc
// Size: 0x88
function shouldswitchtosidearm( task )
{
    if ( usingsidearm( task ) == anim.success )
    {
        return anim.failure;
    }
    
    if ( self.forcesidearm )
    {
        return anim.success;
    }
    
    if ( canswitchtosidearm( task ) != anim.success )
    {
        return anim.failure;
    }
    
    if ( checkcoverforsidearm( task ) != anim.success )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace weapon
// Params 1
// Checksum 0xbfa119ff, Offset: 0x58d
// Size: 0x76
function canswitchtosidearm( task )
{
    if ( self.disablepistol )
    {
        return anim.failure;
    }
    
    if ( asm_bb::bb_moverequested() && isdefined( self.pathgoalpos ) && length2dsquared( self.velocity ) > 1 )
    {
        return anim.failure;
    }
    
    if ( self.in_melee )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace weapon
// Params 1
// Checksum 0xa2b3254a, Offset: 0x60c
// Size: 0x56
function checkcoverforsidearm( task )
{
    covernode = asm_bb::bb_getcovernode();
    
    if ( isdefined( covernode ) && distance( self.origin, covernode.origin ) < 16 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

