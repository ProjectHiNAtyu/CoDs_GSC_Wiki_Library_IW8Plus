// script_154621d20003b0c6  (hash_154621d20003b0c6.gscc) (size: 1467 Bytes / 0x5bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47a43cf8 (1201945848)
// size ...... 1467 (0x5bb)
// includes .. 2   (offset: 0x5ab)
// strings ... 0   (offset: 0x5bb)
// dev strs .. 0   (offset: 0x5bb)
// exports ... 8   (offset: 0x2f7)
// cseg ...... 0x58 + 0x29f (0x2f7)
// imports ... 13  (offset: 0x437)
// animtree1 . 0   (offset: 0x5bb)
// animtree2 . 0   (offset: 0x5bb)
#using script_38b3a2dd00d469d7;
#using scripts\mp\gametypes\obj_dogtag;

#namespace namespace_fd1678a9e856701d;

// Namespace namespace_fd1678a9e856701d
// Params 0
// Checksum 0xdef75913, Offset: 0x76
// Size: 0x8b
function register()
{
    function_34418aaddea36cc3();
    namespace_65703d98c062a7d0::register_task( #"killdrops", { #description:undefined, #title:undefined, #var_d510f1926ab220cf:1, #defaulttimelimit:level.var_4e147a96a4a5740d.taskduration ?? 120, #var_a689daceff70fb12:25, #callbacks:{ #end:&end, #begin:&begin } } );
}

// Namespace namespace_fd1678a9e856701d
// Params 1
// Checksum 0xdc2a2e09, Offset: 0x109
// Size: 0x33
function begin( task )
{
    level.dogtagsenabled = 1;
    level.dogtagenemyonusecb = &dogtagenemyonusecb;
    level.var_4302726c8b918b9a = &function_19e77df9da6b6d91;
}

// Namespace namespace_fd1678a9e856701d
// Params 1
// Checksum 0xbe61eb3f, Offset: 0x144
// Size: 0x1d
function end( task )
{
    level.dogtagsenabled = 0;
    function_803d2ef310c9defa();
}

// Namespace namespace_fd1678a9e856701d
// Params 0, eflags: 0x4
// Checksum 0xec26be0f, Offset: 0x169
// Size: 0x24
function private function_34418aaddea36cc3()
{
    if ( isdefined( level.dogtags ) && isdefined( level.dogtagdata ) )
    {
        return;
    }
    
    obj_dogtag::init();
}

// Namespace namespace_fd1678a9e856701d
// Params 0, eflags: 0x4
// Checksum 0x600af612, Offset: 0x195
// Size: 0x8b
function private function_803d2ef310c9defa()
{
    if ( !isdefined( level.dogtags ) )
    {
        return;
    }
    
    foreach ( dogtag in level.dogtags )
    {
        thread obj_dogtag::removetag( dogtag, 0 );
    }
}

// Namespace namespace_fd1678a9e856701d
// Params 1, eflags: 0x4
// Checksum 0x4bb5471d, Offset: 0x228
// Size: 0x51
function private function_19e77df9da6b6d91( deathdata )
{
    if ( !isplayer( deathdata.victim ) || !isplayer( deathdata.attacker ) )
    {
        return 0;
    }
    
    return deathdata.victim obj_dogtag::shouldspawntags( deathdata.attacker );
}

// Namespace namespace_fd1678a9e856701d
// Params 1
// Checksum 0x7ff30599, Offset: 0x282
// Size: 0x75
function dogtagenemyonusecb( player )
{
    if ( !isplayer( player ) || !player.team )
    {
        return;
    }
    
    task = level.var_1304fc1c8fb51e7b.active;
    
    if ( task.taskreference != #"killdrops" )
    {
        return;
    }
    
    player namespace_65703d98c062a7d0::function_3e454447aae37e67( player.team, 1 );
}

