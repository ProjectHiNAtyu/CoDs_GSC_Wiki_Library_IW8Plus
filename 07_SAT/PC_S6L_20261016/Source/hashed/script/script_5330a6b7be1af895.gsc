// script_5330a6b7be1af895  (hash_5330a6b7be1af895.gscc) (size: 509 Bytes / 0x1fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x478885fe (1200129534)
// size ...... 509 (0x1fd)
// includes .. 1   (offset: 0x1d9)
// strings ... 2   (offset: 0x1e1)
// dev strs .. 0   (offset: 0x1fd)
// exports ... 2   (offset: 0x119)
// cseg ...... 0x71 + 0xa8 (0x119)
// imports ... 4   (offset: 0x169)
// animtree1 . 0   (offset: 0x1fd)
// animtree2 . 0   (offset: 0x1fd)
#using scripts\asm\asm;

#namespace namespace_4b36059e132389a0;

// Namespace namespace_4b36059e132389a0
// Params 0
// Checksum 0xbbe15e4e, Offset: 0x8f
// Size: 0x89, Type: bool
function get_necrotic_beam_anim_length()
{
    var_51bd92a96b2f2068 = 10;
    
    if ( isdefined( self.asmname ) )
    {
        var_8eee94d91eab4f36 = asm::asm_getanim( self.asmname, "necrotic_beam", "beam" );
        
        if ( isdefined( var_8eee94d91eab4f36 ) && var_8eee94d91eab4f36 != -1 )
        {
            var_f57a421e6cace9f7 = asm::asm_getxanim( "necrotic_beam", var_8eee94d91eab4f36 );
            
            if ( isanimation( var_f57a421e6cace9f7 ) )
            {
                animlength = getanimlength( var_f57a421e6cace9f7 );
            }
        }
    }
    
    return animlength ?? var_51bd92a96b2f2068;
}

