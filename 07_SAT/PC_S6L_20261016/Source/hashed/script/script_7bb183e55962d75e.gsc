// script_7bb183e55962d75e  (hash_7bb183e55962d75e.gscc) (size: 1354 Bytes / 0x54a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9dd567e (2849855102)
// size ...... 1354 (0x54a)
// includes .. 3   (offset: 0x4b6)
// strings ... 10  (offset: 0x4ce)
// dev strs .. 0   (offset: 0x54a)
// exports ... 6   (offset: 0x2fe)
// cseg ...... 0xbf + 0x23f (0x2fe)
// imports ... 7   (offset: 0x3ee)
// animtree1 . 0   (offset: 0x54a)
// animtree2 . 0   (offset: 0x54a)
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;

#namespace namespace_2607576961b0ac9d;

// Namespace namespace_2607576961b0ac9d
// Params 4
// Checksum 0x3185953c, Offset: 0xdd
// Size: 0x34, Type: bool
function function_34db69b2632f401a( asmname, statename, tostatename, params )
{
    if ( zombie_base_dismemberment::is_crawling() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_2607576961b0ac9d
// Params 4
// Checksum 0x5724c0f0, Offset: 0x11a
// Size: 0x103
function choosestandingdeathanim( asmname, statename, params, bmoving )
{
    if ( !isdefined( self.damageyaw ) )
    {
        self.damageyaw = 0;
    }
    
    alias = "left";
    
    if ( self.damageyaw > 135 || self.damageyaw <= -135 )
    {
        alias = "forward";
    }
    else if ( self.damageyaw > 45 && self.damageyaw <= 135 )
    {
        alias = "right";
    }
    else if ( self.damageyaw > -45 && self.damageyaw <= 45 )
    {
        alias = "backward";
    }
    
    damage_taken_type = function_47a6783f727dd81e();
    
    if ( damage_taken_type != "light" )
    {
        alias += "_" + damage_taken_type;
    }
    
    deathanim = asm::asm_lookupanimfromalias( statename, alias );
    return deathanim;
}

// Namespace namespace_2607576961b0ac9d
// Params 3
// Checksum 0x2b643027, Offset: 0x226
// Size: 0x3e
function playdeathanim( asmname, statename, params )
{
    self animmode( "gravity" );
    self animmode( "angle deltas" );
    utility::playanim( asmname, statename );
}

// Namespace namespace_2607576961b0ac9d
// Params 3
// Checksum 0xbceb745b, Offset: 0x26c
// Size: 0x2a
function choosemovingdeathanim( asmname, statename, params )
{
    return choosestandingdeathanim( asmname, statename, params, 1 );
}

// Namespace namespace_2607576961b0ac9d
// Params 0
// Checksum 0xf7446d62, Offset: 0x29f
// Size: 0x5e
function function_47a6783f727dd81e()
{
    var_a23d03a1ea6788b2 = "light";
    
    if ( isexplosivedamagemod( self.damagemod ) )
    {
        var_a23d03a1ea6788b2 = "explosive";
    }
    else
    {
        ratio = self.damagetaken / self.maxhealth;
        
        if ( ratio > 0.7 )
        {
            var_a23d03a1ea6788b2 = "heavy";
        }
    }
    
    return var_a23d03a1ea6788b2;
}

