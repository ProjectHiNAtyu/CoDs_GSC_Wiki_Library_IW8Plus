// script_7cab86232cdd30ba  (hash_7cab86232cdd30ba.gscc) (size: 4599 Bytes / 0x11f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35de4c1b (903760923)
// size ...... 4599 (0x11f7)
// includes .. 3   (offset: 0x106b)
// strings ... 20  (offset: 0x1083)
// dev strs .. 3   (offset: 0x11d3)
// exports ... 15  (offset: 0xa0f)
// cseg ...... 0x1de + 0x831 (0xa0f)
// imports ... 30  (offset: 0xc67)
// animtree1 . 0   (offset: 0x11f7)
// animtree2 . 0   (offset: 0x11f7)
#using scripts\common\progression_utility;
#using scripts\mp\class;
#using scripts\mp\playerachievements;

#namespace player_progression_achievements;

// Namespace player_progression_achievements
// Params 0, eflags: 0x4
// Checksum 0xed26081b, Offset: 0x1fc
// Size: 0x55
function private function_608d80e79011724f()
{
    if ( isdefined( level.var_86d6d54de22b6720 ) )
    {
        return;
    }
    
    var_4fa46bb6a2edd482 = level.projectbundle.var_67327f8e51cb3a75;
    
    if ( !isdefined( var_4fa46bb6a2edd482 ) || var_4fa46bb6a2edd482 == 0 )
    {
        level.var_86d6d54de22b6720 = 48944;
    }
    
    level.var_86d6d54de22b6720 = var_4fa46bb6a2edd482;
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xf24b6504, Offset: 0x259
// Size: 0x129
function function_7a54e5cc7d9e8e90()
{
    function_608d80e79011724f();
    
    if ( !isdefined( level.var_86d6d54de22b6720 ) || level.var_86d6d54de22b6720 == 0 )
    {
        return;
    }
    
    validplayers = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.pers[ "progressionVerified" ] ) || player iscodcaster() || isai( player ) )
        {
            continue;
        }
        
        player.pers[ "verifiedInitialXP" ] = 0;
        player.pers[ "verifiedPrestige" ] = 0;
        player.pers[ "progressionVerified" ] = 0;
        validplayers[ validplayers.size ] = player;
    }
    
    function_6e150ba45a6aa08( validplayers, level.var_86d6d54de22b6720 );
    level.var_686e16e6fe5b5443 = 1;
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xa06e5a56, Offset: 0x38a
// Size: 0xba
function function_776a3b17ae4523c()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !level.var_686e16e6fe5b5443 || !isdefined( level.var_86d6d54de22b6720 ) || level.var_86d6d54de22b6720 == 0 )
    {
        return;
    }
    
    if ( player iscodcaster() || isai( player ) || isdefined( player.pers[ "progressionVerified" ] ) )
    {
        return;
    }
    
    player.pers[ "verifiedInitialXP" ] = 0;
    player.pers[ "verifiedPrestige" ] = 0;
    player.pers[ "progressionVerified" ] = 0;
    self function_fdf029c4be6546a3( level.var_86d6d54de22b6720 );
}

// Namespace player_progression_achievements
// Params 2
// Checksum 0x9e8ba56b, Offset: 0x44c
// Size: 0x38d
function function_f9c086937d2a8eb2( achievementid, progressdata )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( achievementid == level.var_86d6d54de22b6720 )
    {
        xp_progress_id = int( playerachievements::function_a550b9c75bcbee5e( "xp" ) );
        rank_progress_id = int( playerachievements::function_a550b9c75bcbee5e( "rank" ) );
        prestige_progress_id = int( playerachievements::function_a550b9c75bcbee5e( "prestige" ) );
        bp_bc_loyalty_progress_id = int( playerachievements::function_a550b9c75bcbee5e( "bc_loyalty" ) );
        xp = 0;
        prestige = 0;
        bp_bc_loyalty = 0;
        
        for ( index = 0; index < progressdata.progress_values.size ; index++ )
        {
            progress_id = int( progressdata.progress_values[ index ].progress_id );
            
            if ( progress_id == xp_progress_id )
            {
                xp = progressdata.progress_values[ index ].progress;
                continue;
            }
            
            if ( progress_id == prestige_progress_id )
            {
                prestige = progressdata.progress_values[ index ].progress;
                continue;
            }
            
            if ( progress_id == bp_bc_loyalty_progress_id )
            {
                bp_bc_loyalty = progressdata.progress_values[ index ].progress;
            }
        }
        
        player_reported_xp = player function_ad429e448c443545();
        player_reported_prestige = player function_89de54a4f43714a4();
        
        if ( xp != player_reported_xp || prestige != player_reported_prestige )
        {
            event_data = [ "player_reported_xp", player_reported_xp, "player_reported_prestige", player_reported_prestige, "server_received_xp", xp, "server_received_prestige", prestige, "player_xp_at_comparison", player.pers[ "rankxp" ], "player_xp_earned_in_match", player.pers[ "prestige" ] ];
            dlog_recordevent( "dlog_event_sv_progression_validation_failure", event_data );
        }
        
        player.pers[ "verifiedInitialXP" ] = xp;
        player.pers[ "verifiedPrestige" ] = prestige;
        player.pers[ "progressionVerified" ] = 1;
        player.pers[ "rankxp" ] = xp;
        player.pers[ "prestige" ] = prestige;
        
        if ( !isdefined( player.pers[ "telemetry" ] ) )
        {
            player.pers[ "telemetry" ] = spawnstruct();
        }
        
        player.pers[ "telemetry" ].xp_at_start = xp;
        player.pers[ "telemetry" ].rank_at_start = player progression_utility::getrankforxp( xp );
        player.pers[ "telemetry" ].progression_verified = 1;
        player.pers[ "telemetry" ].prestige_at_start = prestige;
        player.pers[ "telemetry" ].blackcell_loyalty = bp_bc_loyalty;
        println( "<dev string:x24>" + player.name + "<dev string:x5f>" + xp + "<dev string:x65>" + prestige );
    }
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xc3dd320f, Offset: 0x7e1
// Size: 0x1e
function function_a14a1871d0fbd201()
{
    assert( isplayer( self ) );
    return self.pers[ "progressionVerified" ];
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xd7b3b752, Offset: 0x808
// Size: 0x6a
function function_ad429e448c443545()
{
    assert( isplayer( self ) );
    
    if ( !self hasplayerdata() )
    {
        return 0;
    }
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        return int( max( self getplayerdata( level.loadoutsgroup, "playerState", "xp" ), 0 ) );
    }
    
    return int( max( self getplayerdata( level.loadoutsgroup, "squadMembers", "player_xp" ), 0 ) );
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x64113932, Offset: 0x87a
// Size: 0x26
function function_1f72ecc33fd16c37()
{
    assert( isplayer( self ) );
    
    if ( !self hasplayerdata() )
    {
        return 0;
    }
    
    return progression_utility::getrankforxp( function_ad429e448c443545() );
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x6c204cdf, Offset: 0x8a9
// Size: 0x6a
function function_89de54a4f43714a4()
{
    assert( isplayer( self ) );
    
    if ( !self hasplayerdata() )
    {
        return 0;
    }
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        return int( max( self getplayerdata( level.loadoutsgroup, "playerState", "prestige" ), 0 ) );
    }
    
    return int( max( self getplayerdata( level.loadoutsgroup, "squadMembers", "season_rank" ), 0 ) );
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x64de74ae, Offset: 0x91b
// Size: 0x1e
function function_f1463e2fc3079b2e()
{
    assert( isplayer( self ) );
    return self.pers[ "verifiedInitialXP" ];
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x3904792, Offset: 0x942
// Size: 0x1b
function function_7a2ab5e27a9084d0()
{
    assert( isplayer( self ) );
    return progression_utility::getrankforxp( function_f1463e2fc3079b2e() );
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x81031cff, Offset: 0x966
// Size: 0x1e
function function_613f2ac0acef366f()
{
    assert( isplayer( self ) );
    return self.pers[ "verifiedPrestige" ];
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0x74bb65eb, Offset: 0x98d
// Size: 0x25
function function_fbde1ca37c2aeeb6()
{
    assert( isplayer( self ) );
    
    if ( function_a14a1871d0fbd201() )
    {
        return function_f1463e2fc3079b2e();
    }
    
    return function_ad429e448c443545();
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xae1d8545, Offset: 0x9bb
// Size: 0x25
function function_1682192f91884908()
{
    assert( isplayer( self ) );
    
    if ( function_a14a1871d0fbd201() )
    {
        return function_7a2ab5e27a9084d0();
    }
    
    return function_1f72ecc33fd16c37();
}

// Namespace player_progression_achievements
// Params 0
// Checksum 0xff4fec4d, Offset: 0x9e9
// Size: 0x25
function getprestige()
{
    assert( isplayer( self ) );
    
    if ( function_a14a1871d0fbd201() )
    {
        return function_613f2ac0acef366f();
    }
    
    return function_89de54a4f43714a4();
}

