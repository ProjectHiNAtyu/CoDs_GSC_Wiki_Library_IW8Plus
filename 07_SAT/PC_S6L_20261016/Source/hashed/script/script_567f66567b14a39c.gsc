// script_567f66567b14a39c  (hash_567f66567b14a39c.gscc) (size: 4050 Bytes / 0xfd2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31a1e659 (832693849)
// size ...... 4050 (0xfd2)
// includes .. 4   (offset: 0xf56)
// strings ... 4   (offset: 0xf76)
// dev strs .. 3   (offset: 0xfae)
// exports ... 14  (offset: 0x936)
// cseg ...... 0xcd + 0x869 (0x936)
// imports ... 35  (offset: 0xb66)
// animtree1 . 0   (offset: 0xfd2)
// animtree2 . 0   (offset: 0xfd2)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\mp\common\utility\player;

#namespace specialty_enemy_proximity_awareness;

// Namespace specialty_enemy_proximity_awareness
// Params 0, eflags: 0x1
// Checksum 0xaf6039ed, Offset: 0xeb
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_enemy_proximity_awareness
// Params 1
// Checksum 0x59330237, Offset: 0x10b
// Size: 0x3f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_enemy_proximity_awareness", &function_50e86c090707a7b8, &function_5b4987bc9da7941f, [], &function_465a9a3a12bbca2e );
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x114ff795, Offset: 0x152
// Size: 0x50
function function_465a9a3a12bbca2e()
{
    level.var_1013c37e11de189a = [];
    var_db9f6a4ca6243429 = 1;
    updaterate = undefined;
    queuelimit = 3;
    level.var_58a4ac2830ab8c23 = throttle::throttle_initialize( "nearby_enemy_cache_throttle", var_db9f6a4ca6243429, updaterate, queuelimit );
    thread function_4756f289e657e354();
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x35aff9a8, Offset: 0x1aa
// Size: 0x95
function function_50e86c090707a7b8()
{
    self.var_2c3d8e5473ea14c0 = self.var_9842326056fd7207.var_f95dd41cb911cdf ?? 985;
    self.var_5b33b51490975a08 = self.var_2c3d8e5473ea14c0 * self.var_2c3d8e5473ea14c0;
    self.var_61bc5181b954da84 = self.var_9842326056fd7207.var_24ad6e20cd94b6e8;
    
    if ( !arraycontains( level.var_1013c37e11de189a, self ) )
    {
        level.var_1013c37e11de189a[ level.var_1013c37e11de189a.size ] = self;
        thread function_9e2662e1b22e197();
        
        /#
            thread function_54acb7fc5fa9ad66();
        #/
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x98e9d0, Offset: 0x247
// Size: 0x65
function function_5b4987bc9da7941f()
{
    if ( arraycontains( level.var_1013c37e11de189a, self ) )
    {
        level.var_1013c37e11de189a = arrayremove( level.var_1013c37e11de189a, self );
        self notify( #"hash_c6e04a3c2f623fd" );
        function_8d329351a1742bb8();
        
        /#
            function_5b55df48ed1e8ca2();
        #/
    }
    
    self.var_2c3d8e5473ea14c0 = undefined;
    self.var_5b33b51490975a08 = undefined;
    self.var_84860fb3139916f9 = undefined;
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x82af08a3, Offset: 0x2b4
// Size: 0x9a
function function_4756f289e657e354()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.var_1013c37e11de189a )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player function_83d39c7aa4638e8a();
        }
        
        waitframe();
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x716578be, Offset: 0x356
// Size: 0x14d
function function_83d39c7aa4638e8a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c6e04a3c2f623fd" );
    var_8d9f8fde8c3205bc = 0;
    
    foreach ( otherplayer in self.var_71155dc4c8ba7582.players )
    {
        if ( !isdefined( otherplayer ) )
        {
            continue;
        }
        
        if ( player::isinlaststand( otherplayer ) )
        {
            continue;
        }
        
        assert( otherplayer != self );
        
        if ( self.team != otherplayer.team && isalive( otherplayer ) && !otherplayer.var_d8921f45ab85950 )
        {
            distsq = distancesquared( self.origin, otherplayer.origin );
            
            if ( distsq <= self.var_5b33b51490975a08 )
            {
                var_8d9f8fde8c3205bc = 1;
                break;
            }
        }
    }
    
    self.var_84860fb3139916f9 = var_8d9f8fde8c3205bc;
    function_3b931665f9ee86f( var_8d9f8fde8c3205bc );
}

// Namespace specialty_enemy_proximity_awareness
// Params 1
// Checksum 0x6e363cd9, Offset: 0x4ab
// Size: 0x56
function function_3b931665f9ee86f( enemynear )
{
    self setclientomnvar( "ui_perk_enemy_nearby", enemynear );
    
    if ( enemynear )
    {
        self notify( #"hash_11819d3ea0f79479" );
        
        if ( self.var_61bc5181b954da84 && isdefined( self.perks[ "specialty_alertness" ] ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_alertness" );
        }
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0, eflags: 0x4
// Checksum 0xbcd05294, Offset: 0x509
// Size: 0x49
function private function_9e2662e1b22e197()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c6e04a3c2f623fd" );
    
    while ( true )
    {
        function_7d8162af5126e739();
        wait 1;
        throttle::throttle_wait_in_queue( level.var_58a4ac2830ab8c23, self );
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0, eflags: 0x4
// Checksum 0x5b6a766e, Offset: 0x55a
// Size: 0x121
function private function_7d8162af5126e739()
{
    if ( !isdefined( self.var_71155dc4c8ba7582 ) )
    {
        self.var_71155dc4c8ba7582 = {};
    }
    
    self.var_71155dc4c8ba7582.players = [];
    ignoredplayer = self;
    nearbyplayers = getplayersinradius( self.origin, self.var_2c3d8e5473ea14c0 * 2, undefined, 0, ignoredplayer );
    
    foreach ( player in nearbyplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team != self.team && player::isreallyalive( player ) )
        {
            self.var_71155dc4c8ba7582.players[ self.var_71155dc4c8ba7582.players.size ] = player;
        }
    }
}

// Namespace specialty_enemy_proximity_awareness
// Params 0
// Checksum 0x23a96202, Offset: 0x683
// Size: 0x18
function function_8d329351a1742bb8()
{
    self setclientomnvar( "ui_perk_enemy_nearby", 0 );
    self.var_71155dc4c8ba7582 = undefined;
}

/#

    // Namespace specialty_enemy_proximity_awareness
    // Params 0
    // Checksum 0xd68aedcf, Offset: 0x6a3
    // Size: 0x1df, Type: dev
    function function_54acb7fc5fa9ad66()
    {
        self endon( #"awareness_debug_cleanup" );
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        
        if ( !isdefined( self.outlinedplayers ) )
        {
            self.outlinedplayers = [];
        }
        
        while ( isdefined( self.perks[ "<dev string:x24>" ] ) )
        {
            if ( getdvarint( @"hash_2033c39d83146094", 0 ) )
            {
                sphere( self.origin, self.var_2c3d8e5473ea14c0 );
                
                foreach ( player in level.players )
                {
                    if ( !isdefined( player ) )
                    {
                        continue;
                    }
                    
                    playeroutlined = 0;
                    
                    if ( player::isreallyalive( player ) )
                    {
                        dist = distance( player.origin, self.origin );
                        
                        if ( dist <= self.var_2c3d8e5473ea14c0 )
                        {
                            playeroutlined = 1;
                            
                            if ( !arraycontains( self.outlinedplayers, player ) )
                            {
                                outline = player.team == self.team ? "<dev string:x48>" : "<dev string:x5e>";
                                player hudoutlineenableforclient( self, outline );
                                self.outlinedplayers[ self.outlinedplayers.size ] = player;
                            }
                        }
                    }
                    
                    if ( !playeroutlined && arraycontains( self.outlinedplayers, player ) )
                    {
                        player hudoutlinedisableforclient( self );
                        self.outlinedplayers = arrayremove( self.outlinedplayers, player );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace specialty_enemy_proximity_awareness
    // Params 0
    // Checksum 0x975de9dd, Offset: 0x88a
    // Size: 0xac, Type: dev
    function function_5b55df48ed1e8ca2()
    {
        self notify( #"awareness_debug_cleanup" );
        
        if ( self.outlinedplayers.size > 0 )
        {
            foreach ( player in self.outlinedplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player hudoutlinedisableforclient( self );
            }
        }
        
        self.outlinedplayers = undefined;
    }

#/
