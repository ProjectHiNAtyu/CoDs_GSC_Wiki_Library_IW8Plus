// script_4c2f18e1956d75b5  (hash_4c2f18e1956d75b5.gscc) (size: 3246 Bytes / 0xcae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x296edd4b (695131467)
// size ...... 3246 (0xcae)
// includes .. 2   (offset: 0xc4e)
// strings ... 4   (offset: 0xc5e)
// dev strs .. 2   (offset: 0xc92)
// exports ... 11  (offset: 0x7ba)
// cseg ...... 0xbf + 0x6fb (0x7ba)
// imports ... 25  (offset: 0x972)
// animtree1 . 0   (offset: 0xcae)
// animtree2 . 0   (offset: 0xcae)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace specialty_nearest_enemy_footsteps;

// Namespace specialty_nearest_enemy_footsteps
// Params 0, eflags: 0x1
// Checksum 0xe39d933, Offset: 0xdd
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_nearest_enemy_footsteps
// Params 1
// Checksum 0x11ec4f2, Offset: 0xfd
// Size: 0x39
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_nearest_enemy_footsteps", &function_a771433689b3cac3, &function_a1b14ca79d57d8cc );
    }
}

// Namespace specialty_nearest_enemy_footsteps
// Params 0, eflags: 0x4
// Checksum 0x187385b7, Offset: 0x13e
// Size: 0xb9
function private function_a771433689b3cac3()
{
    if ( !isdefined( self.var_fd9d7f7f762f857b ) )
    {
        self.var_fd9d7f7f762f857b = {};
    }
    
    info = self.var_fd9d7f7f762f857b;
    
    if ( !isdefined( info.questcircle ) )
    {
        info.questcircle = spawnquestcircle( "EnemyRecentFootsteps", self.origin[ 0 ], self.origin[ 1 ], 5, self );
    }
    
    if ( !isdefined( info.questcircle ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    info.var_7b0518dea64e7beb = 0;
    info.questcircle hide();
    info.owner = self;
    thread function_dd154b5c5d751519();
}

// Namespace specialty_nearest_enemy_footsteps
// Params 0, eflags: 0x4
// Checksum 0xe9ffcc59, Offset: 0x1ff
// Size: 0x15
function private function_a1b14ca79d57d8cc()
{
    self notify( #"hash_778ec671494e3499" );
    thread function_c2b409cee0634e();
}

// Namespace specialty_nearest_enemy_footsteps
// Params 0, eflags: 0xc
// Checksum 0x3af88acb, Offset: 0x21c
// Size: 0x8e
function private function_c2b409cee0634e()
{
    self notify( #"hash_d5a6a4b075a85ad8" );
    self endon( #"hash_d5a6a4b075a85ad8" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    
    if ( !isdefined( self.perks[ "specialty_nearest_enemy_footsteps" ] ) )
    {
        info = self.var_fd9d7f7f762f857b;
        
        if ( info )
        {
            if ( info.questcircle )
            {
                info.questcircle delete();
            }
            
            self.var_fd9d7f7f762f857b = undefined;
        }
    }
}

// Namespace specialty_nearest_enemy_footsteps
// Params 0, eflags: 0xc
// Checksum 0x29790e4a, Offset: 0x2b2
// Size: 0xdd
function private function_dd154b5c5d751519()
{
    self notify( #"hash_e9d13ed8f2c96340" );
    self endon( #"hash_e9d13ed8f2c96340" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"hash_778ec671494e3499" );
    wait 0.2;
    info = self.var_fd9d7f7f762f857b;
    
    while ( true )
    {
        if ( info.var_7b0518dea64e7beb )
        {
            wait 0.25;
            continue;
        }
        
        if ( info.var_89931584b6108720 > gettime() )
        {
            wait ( info.var_89931584b6108720 - gettime() ) * 0.001;
        }
        
        info.var_89931584b6108720 = undefined;
        showdelaytime = function_6f8541638c6b8ad( info );
        
        if ( isdefined( showdelaytime ) )
        {
            wait showdelaytime + ( level.framedurationseconds ?? 0.016 );
        }
        
        wait 0.25;
    }
}

// Namespace specialty_nearest_enemy_footsteps
// Params 2, eflags: 0xc
// Checksum 0x631c7981, Offset: 0x397
// Size: 0x13d
function private showquestcircletoplayer( var_94c5d19b4be712c9, showdelaytime )
{
    self notify( #"hash_c79e603548db2a2f" );
    self endon( #"hash_c79e603548db2a2f" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_94c5d19b4be712c9 endon( #"death_or_disconnect" );
    var_8ff12f0ed9a70c5d = var_94c5d19b4be712c9.origin;
    wait showdelaytime;
    info = self.var_fd9d7f7f762f857b;
    
    if ( !isdefined( info.questcircle ) )
    {
        assertmsg( "<dev string:x44>" );
        return;
    }
    
    info.questcircle.origin = var_8ff12f0ed9a70c5d;
    info.questcircle showtoplayer( self );
    info.var_7b0518dea64e7beb = 1;
    var_94c5d19b4be712c9 [[ level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ] ]]( self.entnum ?? utility::get_entity_number( self ) );
    info.var_3b21240f12107230 = 1;
    thread watchdeath( info, var_94c5d19b4be712c9 );
    var_94c5d19b4be712c9 thread watchdeath( info, var_94c5d19b4be712c9 );
    wait 0.25;
    level hidequestcircle( info, var_94c5d19b4be712c9 );
}

// Namespace specialty_nearest_enemy_footsteps
// Params 2, eflags: 0xc
// Checksum 0x54e42a94, Offset: 0x4dc
// Size: 0x50
function private watchdeath( var_fd9d7f7f762f857b, var_94c5d19b4be712c9 )
{
    self notify( #"hash_f2b99bf3a4079715" );
    self endon( #"hash_f2b99bf3a4079715" );
    level endon( #"game_ended" );
    utility::waittill_any( "death_or_disconnect" );
    level hidequestcircle( var_fd9d7f7f762f857b, var_94c5d19b4be712c9 );
}

// Namespace specialty_nearest_enemy_footsteps
// Params 2, eflags: 0xc
// Checksum 0x94c4edc1, Offset: 0x534
// Size: 0x110
function private hidequestcircle( info, var_94c5d19b4be712c9 )
{
    self notify( #"hash_d64ce09d6bf15dd1" );
    self endon( #"hash_d64ce09d6bf15dd1" );
    profilestart();
    
    if ( !isdefined( info ) || !info.var_7b0518dea64e7beb )
    {
        profilestop();
        return;
    }
    
    info.var_7b0518dea64e7beb = 0;
    
    if ( var_94c5d19b4be712c9 && info.var_3b21240f12107230 )
    {
        info.var_3b21240f12107230 = undefined;
        
        if ( info.owner )
        {
            var_94c5d19b4be712c9 [[ level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ] ]]( info.owner.entnum ?? utility::get_entity_number( info.owner ) );
        }
    }
    
    if ( !isdefined( info.questcircle ) )
    {
        assertmsg( "<dev string:x44>" );
        profilestop();
        return;
    }
    
    info.questcircle hide();
    info.var_89931584b6108720 = gettime() + 10000;
    profilestop();
}

// Namespace specialty_nearest_enemy_footsteps
// Params 1, eflags: 0x4
// Checksum 0xbe144549, Offset: 0x64c
// Size: 0x16d
function private function_6f8541638c6b8ad( info )
{
    candidates = function_51b8ce76eb43aed5( self.origin, 5, 5, 1, 0, undefined, self.team );
    var_94c5d19b4be712c9 = undefined;
    var_872d2a0fdc9ee079 = undefined;
    
    if ( candidates.size > 0 )
    {
        foreach ( candidate in candidates )
        {
            if ( !isplayer( candidate ) )
            {
                continue;
            }
            
            if ( !candidate issprinting() )
            {
                continue;
            }
            
            if ( isdefined( candidate.perks[ "specialty_ghost" ] ) )
            {
                continue;
            }
            
            if ( !isdefined( var_94c5d19b4be712c9 ) )
            {
                var_94c5d19b4be712c9 = candidate;
                var_872d2a0fdc9ee079 = distance2dsquared( self.origin, candidate.origin );
                continue;
            }
            
            var_71088ec5f7931827 = distance2dsquared( self.origin, candidate.origin );
            
            if ( var_71088ec5f7931827 < var_872d2a0fdc9ee079 )
            {
                var_94c5d19b4be712c9 = candidate;
                var_872d2a0fdc9ee079 = var_71088ec5f7931827;
            }
        }
        
        if ( isdefined( var_94c5d19b4be712c9 ) )
        {
            showdelaytime = randomfloatrange( 0.001, 5 );
            thread showquestcircletoplayer( var_94c5d19b4be712c9, showdelaytime );
        }
    }
    
    return showdelaytime;
}

