// script_13d927d1fbe8598c  (hash_13d927d1fbe8598c.gscc) (size: 1195 Bytes / 0x4ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x351a6377 (890921847)
// size ...... 1195 (0x4ab)
// includes .. 2   (offset: 0x443)
// strings ... 7   (offset: 0x453)
// dev strs .. 0   (offset: 0x4ab)
// exports ... 3   (offset: 0x2c7)
// cseg ...... 0xc3 + 0x204 (0x2c7)
// imports ... 9   (offset: 0x33f)
// animtree1 . 0   (offset: 0x4ab)
// animtree2 . 0   (offset: 0x4ab)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_de55c573adee23bd;

// Namespace namespace_de55c573adee23bd
// Params 0
// Checksum 0x51459cab, Offset: 0xe1
// Size: 0x13
function init_zombie_abom_melee()
{
    callback::add( "zombie_melee", &function_c3194a5c73cfdbc );
}

// Namespace namespace_de55c573adee23bd
// Params 1, eflags: 0x4
// Checksum 0xbf06f06c, Offset: 0xfc
// Size: 0x1cb
function private function_c3194a5c73cfdbc( params )
{
    if ( isplayer( params.var_2d2aab21299551f8 ) )
    {
        player = params.var_2d2aab21299551f8;
        is_tail_whip = self asmgetcurrentstate( self.asmname ) == "tail_whip";
        
        if ( is_tail_whip )
        {
            player utility::knockback_flat( player.origin - self.origin, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4b21328d748b4f09 );
            return;
        }
        
        utility::function_32b24db3127bff40( "melee", "melee" );
        player utility::function_32b24db3127bff40( "abomBiteVFX", "vfx_start" );
        player utility::knockback_flat( player.origin - self.origin, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a49c21ad20f88853 );
        currtime = gettime();
        
        if ( self.var_68170d90ad1f853d != player || !isdefined( self.var_a43f5b8beade6401 ) || currtime - self.var_a43f5b8beade6401 > 2000 )
        {
            self.var_6ba7c799d4828da4 = 0;
        }
        
        self.var_6ba7c799d4828da4++;
        self.var_a43f5b8beade6401 = currtime;
        self.var_68170d90ad1f853d = player;
        
        if ( self.var_6ba7c799d4828da4 >= 3 || params.var_2d2aab21299551f8.health <= 0 || params.var_2d2aab21299551f8.inlaststand )
        {
            self.var_6ba7c799d4828da4 = 0;
            self function_786bb6aa1b76c7ee( "roar_end_time", 1000 );
            self function_786bb6aa1b76c7ee( "multi_bite_roar_time", currtime + 3000 );
        }
    }
}

