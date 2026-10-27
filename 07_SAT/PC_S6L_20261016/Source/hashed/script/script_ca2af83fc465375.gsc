// script_ca2af83fc465375  (hash_0ca2af83fc465375.gscc) (size: 695 Bytes / 0x2b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d12d692 (2098386578)
// size ...... 695 (0x2b7)
// includes .. 1   (offset: 0x28b)
// strings ... 3   (offset: 0x293)
// dev strs .. 0   (offset: 0x2b7)
// exports ... 3   (offset: 0x187)
// cseg ...... 0xa1 + 0xe6 (0x187)
// imports ... 5   (offset: 0x1ff)
// animtree1 . 0   (offset: 0x2b7)
// animtree2 . 0   (offset: 0x2b7)
#using scripts\asm\asm;

#namespace namespace_69de094c38cf2d84;

// Namespace namespace_69de094c38cf2d84
// Params 0
// Checksum 0xa36cf2d4, Offset: 0xbf
// Size: 0x1a
function function_609bb007d270ea2b()
{
    asm::function_7256f5ba459c840b( self.vehicle_attack_state ?? "vehicle_attack_in" );
}

// Namespace namespace_69de094c38cf2d84
// Params 0
// Checksum 0xa87007e3, Offset: 0xe1
// Size: 0xa5
function function_4a67513563b1f915()
{
    var_2018c76b25f154cc = self.vehicle_attack_leap_intro_state ?? "vehicle_attack_leap_intro";
    
    if ( isdefined( self.asmname ) )
    {
        var_52ea5c225b7a292e = asm::asm_getanim( self.asmname, var_2018c76b25f154cc, "tag_ai_linkto_right" );
        
        if ( isdefined( var_52ea5c225b7a292e ) && var_52ea5c225b7a292e != -1 )
        {
            var_a1751522235d0f1f = asm::asm_getxanim( var_2018c76b25f154cc, var_52ea5c225b7a292e );
            
            if ( isanimation( var_a1751522235d0f1f ) )
            {
                animlength = getanimlength( var_a1751522235d0f1f );
            }
        }
    }
    
    return ( animlength ?? 0.6 ) / self._blackboard.var_53d396aac913b6e9;
}

