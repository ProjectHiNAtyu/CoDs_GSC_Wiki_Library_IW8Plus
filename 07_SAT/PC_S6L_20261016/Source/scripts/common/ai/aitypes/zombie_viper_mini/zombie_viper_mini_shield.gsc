// scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini_shield.gsc  (hash_4e2ccef041d697aa.gscc) (size: 1062 Bytes / 0x426 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34b3bfd2 (884195282)
// size ...... 1062 (0x426)
// includes .. 2   (offset: 0x3ca)
// strings ... 4   (offset: 0x3da)
// dev strs .. 2   (offset: 0x40e)
// exports ... 3   (offset: 0x24e)
// cseg ...... 0xb1 + 0x19d (0x24e)
// imports ... 9   (offset: 0x2c6)
// animtree1 . 0   (offset: 0x426)
// animtree2 . 0   (offset: 0x426)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\utility;

#namespace zombie_viper_mini_shield;

// Namespace zombie_viper_mini_shield
// Params 2
// Checksum 0x6ed50119, Offset: 0xcf
// Size: 0x7f
function activate_chest_reactor_shield( healthpct, params )
{
    if ( self.chest_reactor_shield_enabled )
    {
        return;
    }
    
    self.chest_reactor_shield_enabled = 1;
    
    if ( self getscriptablehaspart( "chest_reactor_shield" ) )
    {
        self setscriptablepartstate( "chest_reactor_shield", "on" );
    }
    else
    {
        assertmsg( "<dev string:x24>" + "<dev string:x4d>" );
    }
    
    zombie_utils::function_584d912c70295d81( healthpct, [ "chest_reactor" ] );
    zombie_utils::function_dfae6a5bd222c586( &function_bd884ba71cdcb279 );
}

// Namespace zombie_viper_mini_shield
// Params 1, eflags: 0x4
// Checksum 0x4574eace, Offset: 0x156
// Size: 0xf7
function private function_bd884ba71cdcb279( params )
{
    if ( self.chest_reactor_shield_enabled )
    {
        b_shielded = 1;
        
        if ( isdefined( self.var_45f2beaaf602ef55 ) && ( isdefined( params.shitloc ) && arraycontains( self.var_45f2beaaf602ef55, params.shitloc ) || isdefined( params.partname ) && arraycontains( self.var_45f2beaaf602ef55, params.partname ) || isdefined( params.metabonename ) && arraycontains( self.var_45f2beaaf602ef55, params.metabonename ) ) )
        {
            b_shielded = 0;
        }
        
        if ( b_shielded )
        {
            var_1d4d1f382e7d2c0c = utility::getfx( "zombie_viper_mini_damage_impact_shield" );
            
            if ( isdefined( var_1d4d1f382e7d2c0c ) )
            {
                playfx( var_1d4d1f382e7d2c0c, params.vpoint );
            }
        }
    }
    
    return params.idamage;
}

