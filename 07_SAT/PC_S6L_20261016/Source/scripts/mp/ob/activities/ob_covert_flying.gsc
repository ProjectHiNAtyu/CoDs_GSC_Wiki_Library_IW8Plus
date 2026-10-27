// scripts\mp\ob\activities\ob_covert_flying.gsc  (hash_2b761df6f360638d.gscc) (size: 3326 Bytes / 0xcfe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa245db49 (2722487113)
// size ...... 3326 (0xcfe)
// includes .. 4   (offset: 0xcae)
// strings ... 3   (offset: 0xcce)
// dev strs .. 1   (offset: 0xcf2)
// exports ... 10  (offset: 0x77e)
// cseg ...... 0xb7 + 0x6c7 (0x77e)
// imports ... 32  (offset: 0x90e)
// animtree1 . 0   (offset: 0xcfe)
// animtree2 . 0   (offset: 0xcfe)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_covert_utility;

#namespace ob_covert_flying;

// Namespace ob_covert_flying
// Params 0, eflags: 0x5
// Checksum 0x150a19ec, Offset: 0xd5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_covert_flying", undefined, undefined, &init_gameplay );
}

// Namespace ob_covert_flying
// Params 0, eflags: 0x4
// Checksum 0xb841434f, Offset: 0xf6
// Size: 0x72
function private init_gameplay()
{
    if ( !getdvarint( @"scr_sat_ob_covert_flying", 1 ) )
    {
        return;
    }
    
    if ( level.is_quest_story_mission )
    {
        return;
    }
    
    ob_covert_utility::function_ca660988c89ba0b1();
    level.var_2a17909a75002f85 = spawnstruct();
    level.var_2a17909a75002f85.var_29efdb6c1417ca1 = [];
    level.var_2a17909a75002f85.var_5f64ce8efc842df6 = [];
    thread function_c4722f3812ef7bb8();
    
    /#
        thread function_bbdad85e46a41933();
    #/
}

// Namespace ob_covert_flying
// Params 0, eflags: 0x4
// Checksum 0xe3e0dbc8, Offset: 0x170
// Size: 0x1cd
function private function_c4722f3812ef7bb8()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player && player isskydiving() )
            {
                if ( !arraycontains( level.var_2a17909a75002f85.var_29efdb6c1417ca1, player ) && !arraycontains( level.var_2a17909a75002f85.var_5f64ce8efc842df6, player ) )
                {
                    player thread function_f1043d66cf4d1e33();
                    player thread player_touching_monitor();
                    level.var_2a17909a75002f85.var_29efdb6c1417ca1[ level.var_2a17909a75002f85.var_29efdb6c1417ca1.size ] = player;
                }
            }
        }
        
        foreach ( player in level.var_2a17909a75002f85.var_29efdb6c1417ca1 )
        {
            if ( player && !player isskydiving() )
            {
                player notify( #"hash_5337a9ee24495b6a" );
                level.var_2a17909a75002f85.var_29efdb6c1417ca1 = arrayremove( level.var_2a17909a75002f85.var_29efdb6c1417ca1, player );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_covert_flying
// Params 0
// Checksum 0x56d0935a, Offset: 0x345
// Size: 0x98
function function_f1043d66cf4d1e33()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_5337a9ee24495b6a" );
    var_a2efaa1efefc49dc = getdvarint( @"hash_4d1d0f657d3debe8", 8000 );
    starttime = -1;
    var_7aaa4a0ed09455ee = 0;
    
    while ( true )
    {
        if ( function_386c04bf5098b49() )
        {
            if ( starttime < 0 )
            {
                starttime = gettime();
            }
            
            var_7aaa4a0ed09455ee = gettime() - starttime;
        }
        else
        {
            starttime = -1;
            var_7aaa4a0ed09455ee = 0;
        }
        
        self.var_a12a0fa9b7c7362e = var_7aaa4a0ed09455ee >= var_a2efaa1efefc49dc;
        waitframe();
    }
}

// Namespace ob_covert_flying
// Params 0
// Checksum 0xc48394e7, Offset: 0x3e5
// Size: 0xc4
function player_touching_monitor()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_5337a9ee24495b6a" );
    enttouching = undefined;
    
    while ( true )
    {
        self waittill( #"touch", enttouching );
        
        if ( enttouching && enttouching is_valid_ai() )
        {
            if ( self.var_a12a0fa9b7c7362e )
            {
                self playsoundtoplayer( "uin_ob_ec_flying_impact", self );
                var_295cea9484b9a76e = getdvarint( @"hash_46bcb66af5aad380", 1300 );
                enttouching dodamage( var_295cea9484b9a76e, self.origin, self, undefined, "MOD_EXPLOSIVE" );
                waitframe();
                
                if ( self && enttouching )
                {
                    if ( utility::is_dead_or_dying( enttouching ) )
                    {
                        thread function_8bcb7582e3d498d7( self );
                    }
                }
                
                return;
            }
        }
    }
}

// Namespace ob_covert_flying
// Params 0, eflags: 0x4
// Checksum 0x61f9ca41, Offset: 0x4b1
// Size: 0x11, Type: bool
function private function_386c04bf5098b49()
{
    return self isskydiving() && !self isinfreefall();
}

// Namespace ob_covert_flying
// Params 0, eflags: 0x4
// Checksum 0xbc05fd23, Offset: 0x4cb
// Size: 0xe, Type: bool
function private is_valid_ai()
{
    if ( isai( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_covert_flying
// Params 1, eflags: 0x4
// Checksum 0xc015dc32, Offset: 0x4e2
// Size: 0xe7
function private function_8bcb7582e3d498d7( player )
{
    level endon( #"game_ended" );
    level.var_2a17909a75002f85.var_5f64ce8efc842df6[ level.var_2a17909a75002f85.var_5f64ce8efc842df6.size ] = player;
    level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"hash_efc27a44b70f66c1", #player:player } );
    wait 2;
    
    if ( !player )
    {
        return;
    }
    
    rewardspawnorigin = player.origin + anglestoforward( player.angles ) * 60;
    rewardspawnorigin = getclosestpointonnavmesh( rewardspawnorigin );
    rewardspawnorigin = utility::drop_to_ground( rewardspawnorigin, 100 );
    rewardspawnorigin += ( 0, 0, 15 );
    ob_covert_utility::covert_spawn_reward( "itemspawnlist:sat_ob_cover_flying_itemspawnlist", rewardspawnorigin, ( 0, 0, 0 ) );
}

/#

    // Namespace ob_covert_flying
    // Params 0, eflags: 0x4
    // Checksum 0x5fb7ab15, Offset: 0x5d1
    // Size: 0x1ad, Type: dev
    function private function_bbdad85e46a41933()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_83d4f2cfde3f327a", 0 ) )
            {
                foreach ( player in level.var_2a17909a75002f85.var_29efdb6c1417ca1 )
                {
                    if ( player == level.players[ 0 ] )
                    {
                        textcolor = player.var_a12a0fa9b7c7362e ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                        printtoscreen2d( 50, 350, "<dev string:x24>" + player.var_a12a0fa9b7c7362e, textcolor );
                    }
                    
                    enemies = getaiarrayinradius( player.origin, 10000 );
                    
                    foreach ( enemy in enemies )
                    {
                        sphere( enemy.origin, 20, ( 1, 0, 0 ) );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
