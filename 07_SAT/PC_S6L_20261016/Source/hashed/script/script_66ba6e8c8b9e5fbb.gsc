// script_66ba6e8c8b9e5fbb  (hash_66ba6e8c8b9e5fbb.gscc) (size: 2691 Bytes / 0xa83 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5be205e (3854442590)
// size ...... 2691 (0xa83)
// includes .. 6   (offset: 0x9d3)
// strings ... 9   (offset: 0xa03)
// dev strs .. 0   (offset: 0xa83)
// exports ... 9   (offset: 0x5db)
// cseg ...... 0xe7 + 0x4f4 (0x5db)
// imports ... 23  (offset: 0x743)
// animtree1 . 0   (offset: 0xa83)
// animtree2 . 0   (offset: 0xa83)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\weapon;

#namespace specialty_blastshield;

// Namespace specialty_blastshield
// Params 0, eflags: 0x1
// Checksum 0x38fc2c51, Offset: 0x105
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_blastshield
// Params 1
// Checksum 0x6413f655, Offset: 0x125
// Size: 0x3f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_blastshield", &setspecialty, &unsetspecialty, [], &initspecialty );
    }
}

// Namespace specialty_blastshield
// Params 0
// Checksum 0x8d2635a2, Offset: 0x16c
// Size: 0x5c
function initspecialty()
{
    utility::registersharedfunc( #"specialty_blastshield", #"perkactivation", &perkactivation );
    utility::registersharedfunc( #"specialty_blastshield", #"hash_792f3fd5f432ec37", &modify_blast_shield_damage );
    utility::registersharedfunc( #"specialty_blastshield", #"hash_4caa4d716053e6b8", &damage_should_ignore_blast_shield );
}

// Namespace specialty_blastshield
// Params 0
// Checksum 0x6da81ece, Offset: 0x1d0
// Size: 0xf2
function setspecialty()
{
    perks::function_70e4256c5fb41ada( "specialty_blastshield" );
    
    if ( !isdefined( self.var_11734fe9e9882f0c ) )
    {
        self.var_11734fe9e9882f0c = self.var_9842326056fd7207.var_11734fe9e9882f0c ?? 0;
    }
    
    if ( !isdefined( self.var_94867890f56871bb ) )
    {
        self.var_94867890f56871bb = self.var_9842326056fd7207.var_94867890f56871bb ?? 0;
    }
    
    if ( !isdefined( self.var_4ba3184b566e5bc0 ) )
    {
        self.var_4ba3184b566e5bc0 = self.var_9842326056fd7207.var_4ba3184b566e5bc0 ?? 0.65;
    }
    
    if ( !isdefined( self.var_d3a03808fc24ed83 ) )
    {
        self.var_d3a03808fc24ed83 = self.var_9842326056fd7207.var_d3a03808fc24ed83 ?? 0.8;
    }
    
    if ( !isdefined( self.var_6b2d2d42e2a81cd5 ) )
    {
        self.var_6b2d2d42e2a81cd5 = self.var_9842326056fd7207.var_6b2d2d42e2a81cd5 ?? 0;
    }
}

// Namespace specialty_blastshield
// Params 0
// Checksum 0xc72e3e92, Offset: 0x2ca
// Size: 0xc
function unsetspecialty()
{
    self.var_11734fe9e9882f0c = undefined;
}

// Namespace specialty_blastshield
// Params 4
// Checksum 0xa6746eeb, Offset: 0x2de
// Size: 0xd6
function modify_blast_shield_damage( damage, attacker, victim, var_86bf4af62ca75ed7 )
{
    maxhealth = victim.maxhealth ?? getmatchrulesdata( "commonOption", "maxHealth" );
    maxarmorhealth = 0;
    
    if ( getdvarint( @"hash_d8236cfce8b896b2", 1 ) )
    {
        maxarmorhealth = victim.maxarmorhealth ?? 0;
    }
    
    blastdamagemod = victim.var_4ba3184b566e5bc0;
    var_815afc8398b6ad53 = victim.var_d3a03808fc24ed83 * int( maxhealth + maxarmorhealth );
    var_ed30eb0c259df2de = int( damage * blastdamagemod );
    
    if ( attacker != victim )
    {
        var_ed30eb0c259df2de = clamp( var_ed30eb0c259df2de, 0, var_815afc8398b6ad53 );
    }
    
    return var_ed30eb0c259df2de;
}

// Namespace specialty_blastshield
// Params 0
// Checksum 0x9d06c210, Offset: 0x3bd
// Size: 0x9c
function perkactivation()
{
    if ( isdefined( self.var_773b81cf576594e5[ "specialty_blastshield" ] ) )
    {
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
        {
            perks::function_ef056eae4d523635( self.var_773b81cf576594e5[ "specialty_blastshield" ], 1 );
            perks::function_142df1226093bce0( self.var_773b81cf576594e5[ "specialty_blastshield" ] );
            return;
        }
        
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"center" )
        {
            perks::activateperk( self.var_773b81cf576594e5[ "specialty_blastshield" ] );
        }
    }
}

// Namespace specialty_blastshield
// Params 6
// Checksum 0x31f4d82b, Offset: 0x461
// Size: 0x179, Type: bool
function damage_should_ignore_blast_shield( attacker, victim, objweapon, smeansofdeath, inflictor, hitloc )
{
    if ( smeansofdeath == "MOD_GRENADE" && !victim.var_94867890f56871bb )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_PROJECTILE" )
    {
        return true;
    }
    
    if ( ( smeansofdeath == "MOD_FIRE" || isexplosivedamagemod( smeansofdeath ) ) == 0 )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_EXPLOSIVE_BULLET" && hitloc != "none" )
    {
        return true;
    }
    
    if ( attacker == victim && !victim.var_11734fe9e9882f0c )
    {
        return true;
    }
    
    if ( victim damage_utility::isstuckdamage( inflictor, smeansofdeath ) && !inflictor.bundle.var_223e0db0df10c803 && !self.var_6b2d2d42e2a81cd5 )
    {
        return true;
    }
    
    if ( weapon::weaponignoresblastshield( objweapon, hitloc ) )
    {
        return true;
    }
    
    if ( isdefined( victim ) && isdefined( inflictor ) && isbrgamemode() && victim.isjuggernaut && inflictor vehicle::is_vehicle() )
    {
        return true;
    }
    
    equipbundle = utility::callsharedfunc( #"equipment", #"getequipmentbundlefromweaponname", objweapon.basename );
    
    if ( equipbundle && equipbundle.equipmenttype == "tactical" )
    {
        return true;
    }
    
    return false;
}

