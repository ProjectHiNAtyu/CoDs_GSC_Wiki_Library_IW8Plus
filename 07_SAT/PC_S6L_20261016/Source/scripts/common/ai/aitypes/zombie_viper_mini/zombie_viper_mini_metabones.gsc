// scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini_metabones.gsc  (hash_01a75ae6a450dc37.gscc) (size: 1389 Bytes / 0x56d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b5622b9 (995500729)
// size ...... 1389 (0x56d)
// includes .. 5   (offset: 0x4bd)
// strings ... 10  (offset: 0x4e5)
// dev strs .. 1   (offset: 0x561)
// exports ... 3   (offset: 0x2b9)
// cseg ...... 0xfc + 0x1bd (0x2b9)
// imports ... 14  (offset: 0x331)
// animtree1 . 0   (offset: 0x56d)
// animtree2 . 0   (offset: 0x56d)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini;
#using scripts\common\metabone;
#using scripts\common\values;

#namespace zombie_viper_mini_metabones;

// Namespace zombie_viper_mini_metabones
// Params 0, eflags: 0x1
// Checksum 0x97ff138e, Offset: 0x11a
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_viper_mini";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_viper_mini_metabones
// Params 1, eflags: 0x4
// Checksum 0x1e4ad2d1, Offset: 0x143
// Size: 0x176
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        
        if ( issubstr( metabone_name, "armor" ) )
        {
            metabone::set_metabone_state( metabone_name, "exposed" );
            
            if ( metabone_name == "chest_reactor_armor" )
            {
                metabone::set_metabone_active( "chest_reactor", 1 );
            }
        }
        else
        {
            metabone::set_metabone_state( metabone_name, "destroyed" );
            
            if ( metabone_name == "left_launcher" )
            {
                self._blackboard.var_e6eb6b873938dee6 |= 2;
            }
            else if ( metabone_name == "right_launcher" )
            {
                self._blackboard.var_e6eb6b873938dee6 |= 1;
            }
            
            if ( ( self._blackboard.var_e6eb6b873938dee6 & 2 ) != 0 && ( self._blackboard.var_e6eb6b873938dee6 & 1 ) != 0 )
            {
                zombie_viper_mini::force_self_destruct();
            }
        }
        
        if ( !zombie_stun::is_stunned() && !self isintraverse() && isalive( self ) && val::get( "special_pain" ) )
        {
            asm::function_7256f5ba459c840b( "special_pain_in" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

