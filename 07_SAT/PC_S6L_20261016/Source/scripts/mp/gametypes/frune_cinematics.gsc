// scripts\mp\gametypes\frune_cinematics.gsc  (hash_70413bfc82c28dc7.gscc) (size: 1875 Bytes / 0x753 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ef68a7d (519473789)
// size ...... 1875 (0x753)
// includes .. 3   (offset: 0x70b)
// strings ... 4   (offset: 0x723)
// dev strs .. 0   (offset: 0x753)
// exports ... 5   (offset: 0x483)
// cseg ...... 0x9b + 0x3e8 (0x483)
// imports ... 15  (offset: 0x54b)
// animtree1 . 0   (offset: 0x753)
// animtree2 . 0   (offset: 0x753)
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\utility;

#namespace frune_cinematics;

// Namespace frune_cinematics
// Params 0
// Checksum 0x7d14c4a2, Offset: 0xb9
// Size: 0x32
function init()
{
    if ( getdvarint( @"hash_6f3357d1c86aa3c1", 1 ) )
    {
        level thread function_bda772536e8623ca();
        level callback::add( #"hash_6cd8138b7ddba849", &function_415ed4c7fc6c6f1b );
    }
}

// Namespace frune_cinematics
// Params 0, eflags: 0xc
// Checksum 0x2961ef4e, Offset: 0xf3
// Size: 0x230
function private function_bda772536e8623ca()
{
    self notify( #"hash_47c42cdd8150365c" );
    self endon( #"hash_47c42cdd8150365c" );
    level endon( #"game_ended" );
    level waittill( #"match_start_real_countdown", countdownduration );
    
    if ( countdownduration > 2 )
    {
        wait countdownduration - 2;
    }
    
    game[ #"frune_tuning" ].var_15be1c6b49bd819d = 1;
    var_2bd7c18f5f8edad7 = [];
    
    foreach ( player in level.players )
    {
        if ( player.freeruninfo.var_60182941a9b030ae && !player.freeruninfo.var_1f220541f4ab586 )
        {
            player.freeruninfo.var_1f220541f4ab586 = 1;
            var_2bd7c18f5f8edad7[ var_2bd7c18f5f8edad7.size ] = player;
            level thread utility::fadetoblackforplayer( player, 1, 0.6 );
        }
    }
    
    wait 0.6;
    stopcinematicforall();
    
    foreach ( player in var_2bd7c18f5f8edad7 )
    {
        if ( isdefined( player ) )
        {
            level thread utility::fadetoblackforplayer( player, 0, 0.6 );
        }
    }
    
    foreach ( player in level.players )
    {
        player utility::function_232160414793eaa0( 0 );
    }
}

// Namespace frune_cinematics
// Params 1, eflags: 0x4
// Checksum 0x8a36ab6b, Offset: 0x32b
// Size: 0x13
function private function_415ed4c7fc6c6f1b( params )
{
    thread function_dbd82f3e03a65244();
}

// Namespace frune_cinematics
// Params 0, eflags: 0xc
// Checksum 0x56ddf1a1, Offset: 0x346
// Size: 0x13d
function private function_dbd82f3e03a65244()
{
    self notify( #"hash_c13d226b70740985" );
    self endon( #"hash_c13d226b70740985" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::ent_flag_wait( "bink_complete" );
    
    if ( !self )
    {
        return;
    }
    
    hud_util::fade_out( 0, "black" );
    utility::ent_flag_wait_or_timeout( "loading_done", 2 );
    
    if ( !self )
    {
        return;
    }
    
    if ( !game[ #"frune_tuning" ].var_15be1c6b49bd819d )
    {
        self.freeruninfo.var_60182941a9b030ae = 1;
        self playcinematicforplayer( "sat_mp_freerun2_intro", 1 );
        utility::function_232160414793eaa0( 1 );
        thread hud_util::fade_in( 0.5 );
        wait 8.5;
        self.freeruninfo.var_60182941a9b030ae = 0;
        
        if ( !self.freeruninfo.var_1f220541f4ab586 )
        {
            self.freeruninfo.var_1f220541f4ab586 = 1;
            level thread utility::fadetoblackforplayer( self, 1, 0.6 );
            wait 1;
            
            if ( !self )
            {
                return;
            }
            
            level thread utility::fadetoblackforplayer( self, 0, 0.6 );
        }
        
        utility::function_232160414793eaa0( 0 );
        return;
    }
    
    thread hud_util::fade_in( 0.5 );
}

