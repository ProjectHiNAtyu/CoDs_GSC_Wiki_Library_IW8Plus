// script_3aa63d236f429fc3  (hash_3aa63d236f429fc3.gscc) (size: 1224 Bytes / 0x4c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x341acb7d (874171261)
// size ...... 1224 (0x4c8)
// includes .. 5   (offset: 0x458)
// strings ... 6   (offset: 0x480)
// dev strs .. 0   (offset: 0x4c8)
// exports ... 5   (offset: 0x25c)
// cseg ...... 0xe2 + 0x17a (0x25c)
// imports ... 11  (offset: 0x324)
// animtree1 . 0   (offset: 0x4c8)
// animtree2 . 0   (offset: 0x4c8)
#using script_31ee2a173f3499b7;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;

#namespace ztron_fate_shield;

// Namespace ztron_fate_shield
// Params 0, eflags: 0x5
// Checksum 0x6d345f35, Offset: 0x100
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_fate_shield", #"ztron_fate", undefined, &init );
}

// Namespace ztron_fate_shield
// Params 0
// Checksum 0x869c85e2, Offset: 0x129
// Size: 0x2e
function init()
{
    ztron_fate::function_4b268a9ddf9d18b4( 5, #"shield", &activate, &deactivate, "ztron_fate_rock_shield", "ztron_fate_shield", "dx_zm_ztr4_anno_anz4_d4fatedvsh", 0 );
}

// Namespace ztron_fate_shield
// Params 1
// Checksum 0x76be539f, Offset: 0x15f
// Size: 0xf2
function activate( loadgame )
{
    if ( loadgame )
    {
        return;
    }
    
    namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( int( max( self.ztron.score.bombs, 2 ) ) );
    roll = randomint( 100 );
    
    if ( roll < 5 )
    {
        itemref = "ztron_boxing_glove";
    }
    else if ( roll < 50 )
    {
        itemref = "ztron_barrel";
    }
    else
    {
        itemref = "ztron_sawblade";
    }
    
    ztron_item::function_d2dd7af394ebdbdd( itemref, 0 );
    
    if ( self.ztron.var_4095e0b1332ea87 > 0 && self.ztron.upgradeMask & 134217728 )
    {
        self.ztron.var_6fe8ea86c8758aec = self.ztron.var_4095e0b1332ea87;
        ztron_ui::function_38a72e402dc87ace();
    }
}

// Namespace ztron_fate_shield
// Params 0
// Checksum 0x92f78896, Offset: 0x259
// Size: 0x2
function deactivate()
{
    
}

