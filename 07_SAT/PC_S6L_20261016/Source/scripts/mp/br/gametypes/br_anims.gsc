// scripts\mp\br\gametypes\br_anims.gsc  (hash_6f63cd4045c57150.gscc) (size: 553 Bytes / 0x229 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa837cbc8 (2822228936)
// size ...... 553 (0x229)
// includes .. 2   (offset: 0x219)
// strings ... 0   (offset: 0x229)
// dev strs .. 0   (offset: 0x229)
// exports ... 4   (offset: 0xed)
// cseg ...... 0x58 + 0x95 (0xed)
// imports ... 5   (offset: 0x18d)
// animtree1 . 0   (offset: 0x229)
// animtree2 . 0   (offset: 0x229)
#using scripts\common\utility;
#using scripts\mp\common\equipment\fulton;

#namespace br_anims;

// Namespace br_anims
// Params 0, eflags: 0x5
// Checksum 0x9d68adf, Offset: 0x76
// Size: 0x20
function private autoexec function_ed01b1192a45ba0d()
{
    utility::registersharedfunc( #"br", #"animsinit", &init );
}

// Namespace br_anims
// Params 0
// Checksum 0x6a4836d1, Offset: 0x9e
// Size: 0x17
function init()
{
    level.var_d98e7957aed6acf1 = &function_faccffe15b0719f9;
    fulton::fulton_initanims();
}

// Namespace br_anims
// Params 1
// Checksum 0xa2b076d6, Offset: 0xbd
// Size: 0x2f
function function_faccffe15b0719f9( animname )
{
    if ( !isdefined( level.br_anim[ animname ] ) )
    {
        return 0;
    }
    
    return getanimlength( level.br_anim[ animname ] );
}

