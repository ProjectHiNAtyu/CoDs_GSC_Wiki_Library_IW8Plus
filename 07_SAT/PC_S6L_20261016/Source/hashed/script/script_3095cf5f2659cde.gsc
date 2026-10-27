// script_3095cf5f2659cde  (hash_03095cf5f2659cde.gscc) (size: 936 Bytes / 0x3a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x566d16cc (1449989836)
// size ...... 936 (0x3a8)
// includes .. 4   (offset: 0x36c)
// strings ... 2   (offset: 0x38c)
// dev strs .. 0   (offset: 0x3a8)
// exports ... 4   (offset: 0x1ec)
// cseg ...... 0x78 + 0x174 (0x1ec)
// imports ... 8   (offset: 0x28c)
// animtree1 . 0   (offset: 0x3a8)
// animtree2 . 0   (offset: 0x3a8)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\laststand;

#namespace namespace_d9325bef6644379d;

// Namespace namespace_d9325bef6644379d
// Params 0, eflags: 0x5
// Checksum 0xc23f6508, Offset: 0x96
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"phoenix_up_zm", "phoenix_up", &pre_main, undefined );
}

// Namespace namespace_d9325bef6644379d
// Params 0, eflags: 0x4
// Checksum 0xf9877ab7, Offset: 0xbb
// Size: 0x1c
function private pre_main()
{
    utility::registersharedfunc( "phoenix_up", #"activation", &function_817d950dda3d14a );
}

// Namespace namespace_d9325bef6644379d
// Params 0
// Checksum 0xb8a5279d, Offset: 0xdf
// Size: 0x10d
function function_817d950dda3d14a()
{
    players = level.players;
    
    foreach ( player in players )
    {
        if ( self.team != player.team )
        {
            continue;
        }
        
        var_9d4c98c8e1cd476c = 0;
        
        if ( isdefined( level.var_6965477c3d0b042a ) && self [[ level.var_6965477c3d0b042a ]]( player, 1, 1 ) )
        {
            var_9d4c98c8e1cd476c = 1;
        }
        else if ( player.inlaststand )
        {
            var_9d4c98c8e1cd476c = 1;
        }
        
        if ( var_9d4c98c8e1cd476c )
        {
            player thread namespace_6616340f3419ea2d::function_cc02815a6734823c();
            player playlocalsound( #"hash_3a4755d3fdba9362" );
            player laststand::function_75e6bc3d39e1f2bb( self, "last_stand_bgb" );
        }
    }
}

