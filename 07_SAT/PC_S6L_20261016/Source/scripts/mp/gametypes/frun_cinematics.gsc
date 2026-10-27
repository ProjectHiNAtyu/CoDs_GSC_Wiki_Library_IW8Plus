// scripts\mp\gametypes\frun_cinematics.gsc  (hash_4f254352cca9ac3a.gscc) (size: 1928 Bytes / 0x788 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95c184aa (2512487594)
// size ...... 1928 (0x788)
// includes .. 4   (offset: 0x738)
// strings ... 4   (offset: 0x758)
// dev strs .. 0   (offset: 0x788)
// exports ... 5   (offset: 0x490)
// cseg ...... 0x9a + 0x3f6 (0x490)
// imports ... 16  (offset: 0x558)
// animtree1 . 0   (offset: 0x788)
// animtree2 . 0   (offset: 0x788)
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\utility;
#using scripts\mp\gametypes\frun_free_run;

#namespace frun_cinematics;

// Namespace frun_cinematics
// Params 0
// Checksum 0x380f367, Offset: 0xb8
// Size: 0x32
function init()
{
    if ( getdvarint( @"hash_6f3357d1c86aa3c1", 1 ) )
    {
        level thread function_bda772536e8623ca();
        level callback::add( #"hash_6cd8138b7ddba849", &function_415ed4c7fc6c6f1b );
    }
}

// Namespace frun_cinematics
// Params 0, eflags: 0xc
// Checksum 0x55c2efd6, Offset: 0xf2
// Size: 0x236
function private function_bda772536e8623ca()
{
    self notify( #"hash_6fddea6a09bfd739" );
    self endon( #"hash_6fddea6a09bfd739" );
    level endon( #"game_ended" );
    level waittill( #"match_start_real_countdown", countdownduration );
    
    if ( countdownduration > 2 )
    {
        wait countdownduration - 2;
    }
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_15be1c6b49bd819d = 1;
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

// Namespace frun_cinematics
// Params 1, eflags: 0x4
// Checksum 0xf4a29cae, Offset: 0x330
// Size: 0x13
function private function_415ed4c7fc6c6f1b( params )
{
    thread function_dbd82f3e03a65244();
}

// Namespace frun_cinematics
// Params 0, eflags: 0xc
// Checksum 0x223267f7, Offset: 0x34b
// Size: 0x145
function private function_dbd82f3e03a65244()
{
    self notify( #"hash_85f48044544cb41c" );
    self endon( #"hash_85f48044544cb41c" );
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
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_15be1c6b49bd819d )
    {
        self.freeruninfo.var_60182941a9b030ae = 1;
        self playcinematicforplayer( "sat_mp_freerun_intro", 1 );
        utility::function_232160414793eaa0( 1 );
        thread hud_util::fade_in( 0.5 );
        wait 7.5;
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

