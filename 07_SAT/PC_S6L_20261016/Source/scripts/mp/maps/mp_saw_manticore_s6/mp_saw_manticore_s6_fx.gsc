// scripts\mp\maps\mp_saw_manticore_s6\mp_saw_manticore_s6_fx.gsc  (hash_60b594340bf7b44e.gscc) (size: 1269 Bytes / 0x4f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1d23f4a (3251781450)
// size ...... 1269 (0x4f5)
// includes .. 2   (offset: 0x485)
// strings ... 6   (offset: 0x495)
// dev strs .. 0   (offset: 0x4f5)
// exports ... 5   (offset: 0x25d)
// cseg ...... 0x105 + 0x158 (0x25d)
// imports ... 12  (offset: 0x325)
// animtree1 . 0   (offset: 0x4f5)
// animtree2 . 0   (offset: 0x4f5)
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;

#namespace mp_saw_manticore_s6_fx;

// Namespace mp_saw_manticore_s6_fx
// Params 0
// Checksum 0x70551956, Offset: 0x123
// Size: 0x34
function main()
{
    level._effect[ "waterfall_enter" ] = loadfxasset( "vfx_saw_levels_mp_saw_manticore_waterfall_spray_cam" );
    utility::add_fx( "waterfall_exit", "vfx_iw9_core_swimming_swim_exit_water_screen" );
    level thread function_4ba7117a3eb4cd68();
}

// Namespace mp_saw_manticore_s6_fx
// Params 0, eflags: 0x4
// Checksum 0x94228645, Offset: 0x15f
// Size: 0x35
function private function_4ba7117a3eb4cd68()
{
    var_f9b4712ba8392ac7 = getnoentvolumearray( "waterfall_entrance", #targetname )[ 0 ];
    trigger::makeenterexittrigger( var_f9b4712ba8392ac7, &waterfall_enter, &waterfall_exit );
}

// Namespace mp_saw_manticore_s6_fx
// Params 2, eflags: 0x4
// Checksum 0x83bd6743, Offset: 0x19c
// Size: 0x44
function private waterfall_enter( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        var_14feab19470e7b37 = utility::getfx( "waterfall_enter" );
        playfxontagforclients( var_14feab19470e7b37, ent, "tag_eye", ent );
    }
}

// Namespace mp_saw_manticore_s6_fx
// Params 2, eflags: 0x4
// Checksum 0x8f7d92ec, Offset: 0x1e8
// Size: 0x75
function private waterfall_exit( ent, trigger )
{
    if ( isplayer( ent ) )
    {
        fx = utility::getfx( "waterfall_exit" );
        playfxontagforclients( fx, ent, "tag_eye", ent );
        var_14feab19470e7b37 = utility::getfx( "waterfall_enter" );
        stopfxontagforclients( var_14feab19470e7b37, ent, "tag_eye", ent );
        killfxontag( var_14feab19470e7b37, ent, "tag_eye" );
    }
}

