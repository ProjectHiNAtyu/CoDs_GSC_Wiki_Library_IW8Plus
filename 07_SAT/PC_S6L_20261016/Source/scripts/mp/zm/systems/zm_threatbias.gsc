// scripts\mp\zm\systems\zm_threatbias.gsc  (hash_32ed100212e5414e.gscc) (size: 1848 Bytes / 0x738 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x925419da (2454985178)
// size ...... 1848 (0x738)
// includes .. 2   (offset: 0x6c4)
// strings ... 6   (offset: 0x6d4)
// dev strs .. 0   (offset: 0x738)
// exports ... 6   (offset: 0x3d8)
// cseg ...... 0xdc + 0x2fc (0x3d8)
// imports ... 16  (offset: 0x4c8)
// animtree1 . 0   (offset: 0x738)
// animtree2 . 0   (offset: 0x738)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zm_threatbias;

// Namespace zm_threatbias
// Params 0, eflags: 0x5
// Checksum 0x5dd0e05, Offset: 0xfa
// Size: 0x136
function private autoexec init()
{
    level.threatbias_teams = [ "team_two_hundred", "team_players", "ignored_by_zombies" ];
    
    foreach ( threatbias_team in level.threatbias_teams )
    {
        if ( !threatbiasgroupexists( threatbias_team ) )
        {
            createthreatbiasgroup( threatbias_team );
        }
    }
    
    setignoremegroup( "ignored_by_zombies", "team_two_hundred" );
    level callback::add( #"player_spawned", &function_13b44aa789560876 );
    level callback::add( "on_agent_spawned", &function_1fe0963c623edfc7 );
    utility::registersharedfunc( #"player", #"hash_d1ade7b3c059cba9", &function_7852f419c0d0211c );
    utility::registersharedfunc( #"ai", #"hash_d1ade7b3c059cba9", &function_f43555c7933ed3d3 );
    utility::flag_wait( "sentientpoolmanager_initialized" );
    setignoremegroup( "Tactical_Static", "team_two_hundred" );
}

// Namespace zm_threatbias
// Params 1, eflags: 0x4
// Checksum 0x350b62a2, Offset: 0x238
// Size: 0x17
function private function_13b44aa789560876( params )
{
    self setthreatbiasgroup( "team_players" );
}

// Namespace zm_threatbias
// Params 1, eflags: 0x4
// Checksum 0x5fc00fec, Offset: 0x257
// Size: 0x39
function private function_1fe0963c623edfc7( params )
{
    if ( isdefined( self.team ) && threatbiasgroupexists( self.team ) )
    {
        self setthreatbiasgroup( self.team );
    }
}

// Namespace zm_threatbias
// Params 2, eflags: 0x4
// Checksum 0xb9a96712, Offset: 0x298
// Size: 0x86
function private function_7852f419c0d0211c( source, var_1a52166ad44834e7 )
{
    assert( isplayer( self ) );
    assert( isstring( source ) );
    
    if ( !isdefined( self.a_ignored_by_zombies ) )
    {
        self.a_ignored_by_zombies = [];
    }
    
    self.a_ignored_by_zombies[ source ] = var_1a52166ad44834e7 ? 1 : undefined;
    
    if ( self.a_ignored_by_zombies.size > 0 )
    {
        self setthreatbiasgroup( "ignored_by_zombies" );
        return;
    }
    
    self setthreatbiasgroup( "team_players" );
}

// Namespace zm_threatbias
// Params 2, eflags: 0x4
// Checksum 0x26725edc, Offset: 0x326
// Size: 0xb2
function private function_f43555c7933ed3d3( source, var_1a52166ad44834e7 )
{
    assert( !isplayer( self ) );
    assert( isstring( source ) );
    
    if ( !isdefined( self.a_ignored_by_zombies ) )
    {
        self.a_ignored_by_zombies = [];
    }
    
    self.a_ignored_by_zombies[ source ] = var_1a52166ad44834e7 ? 1 : undefined;
    
    if ( self.a_ignored_by_zombies.size > 0 )
    {
        self setthreatbiasgroup( "ignored_by_zombies" );
        return;
    }
    
    if ( isdefined( self.team ) && threatbiasgroupexists( self.team ) )
    {
        self setthreatbiasgroup( self.team );
        return;
    }
    
    self setthreatbiasgroup();
}

