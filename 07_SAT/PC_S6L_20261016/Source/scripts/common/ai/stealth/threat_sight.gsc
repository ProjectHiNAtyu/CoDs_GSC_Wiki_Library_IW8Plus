// scripts\common\ai\stealth\threat_sight.gsc  (hash_1d517e4b72132535.gscc) (size: 5090 Bytes / 0x13e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dce2267 (1036919399)
// size ...... 5090 (0x13e2)
// includes .. 1   (offset: 0x13ae)
// strings ... 3   (offset: 0x13b6)
// dev strs .. 0   (offset: 0x13e2)
// exports ... 15  (offset: 0xcae)
// cseg ...... 0xd9 + 0xbd5 (0xcae)
// imports ... 38  (offset: 0xf06)
// animtree1 . 0   (offset: 0x13e2)
// animtree2 . 0   (offset: 0x13e2)
#using scripts\common\utility;

#namespace threat_sight;

// Namespace threat_sight
// Params 1
// Checksum 0x667f7c63, Offset: 0xf7
// Size: 0x241
function threat_sight_set_enabled( enabled )
{
    assert( isdefined( level.stealth ) );
    wasenabled = getstealththreatsightenabled();
    setstealththreatsightenabled( enabled );
    threat_sight_set_dvar( enabled );
    
    if ( enabled )
    {
        foreach ( player in level.players )
        {
            if ( player function_5c766d1d0140b86( "ui_stealth_system_enabled" ) )
            {
                player setclientomnvar( "ui_stealth_system_enabled", 1 );
            }
        }
    }
    
    if ( !enabled && wasenabled )
    {
        level notify( #"threat_sight_disabled" );
        
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_stealth_system_enabled", 0 );
            player thread threat_sight_player_sight_audio_cleanup();
            player thread function_20918bc0487a3915();
        }
    }
    else if ( enabled && !wasenabled )
    {
        level notify( #"threat_sight_enabled" );
    }
    
    allai = getaiarray();
    
    foreach ( guy in allai )
    {
        if ( isalive( guy ) && isdefined( guy.threatsightstate ) )
        {
            guy setthreatsightstate( guy.threatsightstate );
        }
    }
    
    if ( enabled && !wasenabled )
    {
        level thread threat_sight_player_sight_audio_thread();
        level thread function_5ff82d249c936b0b();
    }
}

// Namespace threat_sight
// Params 1
// Checksum 0x8ab02450, Offset: 0x340
// Size: 0x35
function threat_sight_set_dvar( enabled )
{
    if ( enabled && !getstealththreatsightenabled() )
    {
        return;
    }
    
    setsaveddvar( @"ai_threatsight", enabled );
    level thread threat_sight_set_dvar_display( enabled );
}

// Namespace threat_sight
// Params 1
// Checksum 0x972237e4, Offset: 0x37d
// Size: 0x61
function threat_sight_set_dvar_display( enabled )
{
    self notify( #"threat_sight_set_dvar_display" );
    self endon( #"threat_sight_set_dvar_display" );
    
    if ( !enabled )
    {
        wait 1;
    }
    
    if ( getdvarint( @"ai_threatusedisplay", 0 ) )
    {
        setsaveddvar( @"ai_threatsightdisplay", enabled );
    }
    
    setdvar( @"hash_21b72d8c9ff7a1b3", enabled );
}

// Namespace threat_sight
// Params 0
// Checksum 0x8363389c, Offset: 0x3e6
// Size: 0x22
function threat_sight_enabled()
{
    if ( !getdvarint( @"ai_threatsight" ) )
    {
        return 0;
    }
    
    if ( self == level )
    {
        return getstealththreatsightenabled();
    }
    
    return 1;
}

// Namespace threat_sight
// Params 2
// Checksum 0x6d3e4fd2, Offset: 0x411
// Size: 0xa2
function threat_sight_player_entity_state_set( ai, statename )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    switch ( statename )
    {
        case #"hash_9a31640cc41d3ff3":
            ai setthreatsight( self, 0 );
            break;
        case #"hash_e21b072df2b47f94":
            if ( isdefined( ai.enemy ) && ai.enemy == self )
            {
                ai setthreatsight( self, 1 );
            }
            
            break;
        case #"hash_e8bc3da4af287c2d":
            ai setthreatsight( self, 0 );
            break;
    }
}

// Namespace threat_sight
// Params 2
// Checksum 0x57086d61, Offset: 0x4bb
// Size: 0x13f
function threat_sight_force_visible( othersentient, durationseconds )
{
    self function_4925679368869b06( othersentient, durationseconds );
    end = gettime() + int( 1000 * durationseconds );
    entnum = othersentient getentitynumber();
    
    if ( !isdefined( self.stealth.force_visible ) )
    {
        self.stealth.force_visible = [];
    }
    
    if ( isdefined( self.stealth.force_visible[ entnum ] ) )
    {
        self.stealth.force_visible[ entnum ].end = max( self.stealth.force_visible[ entnum ].end, end );
    }
    else
    {
        self.stealth.force_visible[ entnum ] = spawnstruct();
        self.stealth.force_visible[ entnum ].end = end;
    }
    
    self.stealth.force_visible[ entnum ].ent = othersentient;
    thread threat_sight_force_visible_thread();
}

// Namespace threat_sight
// Params 0
// Checksum 0x6c83d571, Offset: 0x602
// Size: 0x252
function threat_sight_force_visible_thread()
{
    if ( self.stealth.force_visible_thread )
    {
        return;
    }
    
    self notify( #"threat_sight_force_visible_thread" );
    self endon( #"threat_sight_force_visible_thread" );
    self endon( #"death" );
    self.stealth.force_visible_thread = 1;
    waittime = 0.05;
    
    while ( self.stealth.force_visible.size > 0 )
    {
        now = gettime();
        remove = [];
        
        foreach ( key, forcedvis in self.stealth.force_visible )
        {
            if ( now < forcedvis.end && issentient( forcedvis.ent ) && !self cansee( forcedvis.ent ) )
            {
                if ( isplayer( forcedvis.ent ) )
                {
                    newthreat = self getthreatsight( forcedvis.ent );
                    stealthmaxthreat = getstealthmaxthreat( forcedvis.ent );
                    forcedvis.ent thread threat_sight_player_sight_audio( 1, max( stealthmaxthreat, newthreat ) );
                }
                
                continue;
            }
            
            remove[ remove.size ] = key;
        }
        
        foreach ( key in remove )
        {
            self.stealth.force_visible[ key ] = undefined;
        }
        
        wait waittime;
    }
    
    self.stealth.force_visible = undefined;
    self.stealth.force_visible_thread = undefined;
}

// Namespace threat_sight
// Params 0
// Checksum 0x8c480ce8, Offset: 0x85c
// Size: 0x123
function threat_sight_player_sight_audio_thread()
{
    level endon( #"threat_sight_disabled" );
    
    if ( !isdefined( level.stealth.fnthreatsightplayersightaudio ) )
    {
        level utility::flag_wait( "threat_sight_audio_enabled" );
        assert( isdefined( level.stealth.fnthreatsightplayersightaudio ) );
    }
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( getdvarfloat( @"ai_threatsightfakethreat" ) <= 0 )
        {
            foreach ( player in level.players )
            {
                if ( !isalive( player ) || !isdefined( player.stealth ) )
                {
                    continue;
                }
                
                player thread threat_sight_player_sight_audio( getstealththreatsightanycansee( player ), getstealthmaxthreat( player ) );
            }
        }
        
        waitframe();
    }
}

// Namespace threat_sight
// Params 0
// Checksum 0xfef3accc, Offset: 0x987
// Size: 0x123
function function_5ff82d249c936b0b()
{
    level endon( #"threat_sight_disabled" );
    
    if ( !isdefined( level.stealth.var_ae213a088f33e772 ) )
    {
        level utility::flag_wait( "threat_sight_rumble_enabled" );
        assert( isdefined( level.stealth.var_ae213a088f33e772 ) );
    }
    
    while ( !isdefined( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( getdvarfloat( @"ai_threatsightfakethreat" ) <= 0 )
        {
            foreach ( player in level.players )
            {
                if ( !isalive( player ) || !isdefined( player.stealth ) )
                {
                    continue;
                }
                
                player thread threat_sight_player_sight_rumble( getstealththreatsightanycansee( player ), getstealthmaxthreat( player ) );
            }
        }
        
        waitframe();
    }
}

// Namespace threat_sight
// Params 2
// Checksum 0x77e0931c, Offset: 0xab2
// Size: 0xb2
function threat_sight_fake( origin, amount )
{
    self notify( #"threat_sight_fake" );
    self endon( #"threat_sight_fake" );
    setsaveddvar( @"ai_threatsightfakethreat", amount );
    setsaveddvar( @"ai_threatsightfakex", origin[ 0 ] );
    setsaveddvar( @"ai_threatsightfakey", origin[ 1 ] );
    setsaveddvar( @"ai_threatsightfakez", origin[ 2 ] );
    stealthmaxthreat = getstealthmaxthreat( self );
    
    while ( amount > 0 )
    {
        thread threat_sight_player_sight_audio( 1, max( stealthmaxthreat, amount ) );
        wait 0.15;
    }
    
    thread threat_sight_player_sight_audio( 0, max( stealthmaxthreat, amount ) );
}

// Namespace threat_sight
// Params 3
// Checksum 0x5c9a3cab, Offset: 0xb6c
// Size: 0x5d
function threat_sight_player_sight_audio( anycansee, maxthreat, willdebugprint )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnthreatsightplayersightaudio ) )
    {
        self thread [[ level.stealth.fnthreatsightplayersightaudio ]]( anycansee, maxthreat, willdebugprint );
    }
}

// Namespace threat_sight
// Params 0
// Checksum 0x3739cfe4, Offset: 0xbd1
// Size: 0x3d
function threat_sight_player_sight_audio_cleanup()
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnthreatsightplayersightaudiocleanup ) )
    {
        self thread [[ level.stealth.fnthreatsightplayersightaudiocleanup ]]();
    }
}

// Namespace threat_sight
// Params 2
// Checksum 0x9223ac49, Offset: 0xc16
// Size: 0x53
function threat_sight_player_sight_rumble( anycansee, maxthreat )
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.var_ae213a088f33e772 ) )
    {
        self thread [[ level.stealth.var_ae213a088f33e772 ]]( anycansee, maxthreat );
    }
}

// Namespace threat_sight
// Params 0
// Checksum 0xbcc769d4, Offset: 0xc71
// Size: 0x3d
function function_20918bc0487a3915()
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.var_808af9e51b9c548a ) )
    {
        self thread [[ level.stealth.var_808af9e51b9c548a ]]();
    }
}

