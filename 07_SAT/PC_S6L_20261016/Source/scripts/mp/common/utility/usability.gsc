// scripts\mp\common\utility\usability.gsc  (hash_7cbfe210db707399.gscc) (size: 2002 Bytes / 0x7d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb242c16 (3945016342)
// size ...... 2002 (0x7d2)
// includes .. 0   (offset: 0x7d2)
// strings ... 0   (offset: 0x7d2)
// dev strs .. 0   (offset: 0x7d2)
// exports ... 9   (offset: 0x57a)
// cseg ...... 0x58 + 0x522 (0x57a)
// imports ... 6   (offset: 0x6e2)
// animtree1 . 0   (offset: 0x7d2)
// animtree2 . 0   (offset: 0x7d2)
#namespace usability;

// Namespace usability
// Params 1
// Checksum 0xd1bb5f2, Offset: 0x76
// Size: 0x9c
function setselfusable( caller )
{
    self makeusable();
    
    foreach ( player in level.players )
    {
        if ( player != caller )
        {
            self disableplayeruse( player );
            continue;
        }
        
        self enableplayeruse( player );
    }
}

// Namespace usability
// Params 0
// Checksum 0x135d2a68, Offset: 0x11a
// Size: 0x7a
function setallunusable()
{
    foreach ( player in level.players )
    {
        self disableplayeruse( player );
    }
}

// Namespace usability
// Params 1
// Checksum 0x21d3d14a, Offset: 0x19c
// Size: 0x1b
function maketeamusable( team )
{
    self makeusable();
    thread _updateteamusable( team );
}

// Namespace usability
// Params 1
// Checksum 0x59d8a51, Offset: 0x1bf
// Size: 0xbc
function _updateteamusable( team )
{
    self endon( #"death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
        }
        
        level waittill( #"joined_team" );
    }
}

// Namespace usability
// Params 2
// Checksum 0x778a9284, Offset: 0x283
// Size: 0x25
function makeenemyusable( owner, var_ff1e87ed03e2d434 )
{
    self makeusable();
    thread _updateenemyusable( owner, var_ff1e87ed03e2d434 );
}

// Namespace usability
// Params 2
// Checksum 0x97631d2a, Offset: 0x2b0
// Size: 0x1ad
function _updateenemyusable( owner, var_ff1e87ed03e2d434 )
{
    self endon( #"death" );
    team = owner.team;
    
    for ( ;; )
    {
        if ( level.teambased )
        {
            foreach ( player in level.players )
            {
                if ( var_ff1e87ed03e2d434 )
                {
                    if ( player.team != team || player == owner )
                    {
                        self enableplayeruse( player );
                    }
                    else
                    {
                        self disableplayeruse( player );
                    }
                    
                    continue;
                }
                
                if ( player.team != team )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                self disableplayeruse( player );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( var_ff1e87ed03e2d434 )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                if ( player != owner )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                self disableplayeruse( player );
            }
        }
        
        level waittill( #"joined_team" );
    }
}

// Namespace usability
// Params 1
// Checksum 0xde4d5d4a, Offset: 0x465
// Size: 0x91
function notusableforjoiningplayers( owner )
{
    self notify( #"hash_96c6f62d408b7564" );
    self endon( #"death" );
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    self endon( #"hash_96c6f62d408b7564" );
    self endon( #"makeExplosiveUnusable" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( isdefined( self ) && isdefined( player ) && player != owner )
        {
            self disableplayeruse( player );
        }
    }
}

// Namespace usability
// Params 2
// Checksum 0xb8186ecf, Offset: 0x4fe
// Size: 0x7c
function notusableafterownerchange( owner, equipment )
{
    self notify( #"hash_10aab7556cadcad7" );
    self endon( #"death" );
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    self endon( #"hash_10aab7556cadcad7" );
    self endon( #"makeExplosiveUnusable" );
    
    while ( true )
    {
        equipment waittill( #"ownerChanged" );
        self disableplayeruse( owner );
    }
}

