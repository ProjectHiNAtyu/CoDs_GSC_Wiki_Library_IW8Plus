// scripts\mp\ob\activities\ob_covert_underwater.gsc  (hash_029ef36b2a442583.gscc) (size: 5973 Bytes / 0x1755 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43ba8bfe (1136299006)
// size ...... 5973 (0x1755)
// includes .. 5   (offset: 0x16a5)
// strings ... 11  (offset: 0x16cd)
// dev strs .. 0   (offset: 0x1755)
// exports ... 15  (offset: 0xf51)
// cseg ...... 0x193 + 0xdbe (0xf51)
// imports ... 42  (offset: 0x11a9)
// animtree1 . 0   (offset: 0x1755)
// animtree2 . 0   (offset: 0x1755)
#using scripts\common\scriptable;
#using scripts\common\swim_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_covert_utility;

#namespace ob_covert_underwater;

// Namespace ob_covert_underwater
// Params 0, eflags: 0x5
// Checksum 0xeb7c189c, Offset: 0x1b1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_covert_underwater", undefined, undefined, &init_gameplay );
}

// Namespace ob_covert_underwater
// Params 0, eflags: 0x4
// Checksum 0x3eae8110, Offset: 0x1d2
// Size: 0x1c9
function private init_gameplay()
{
    if ( !getdvarint( @"scr_sat_ob_covert_underwater", 1 ) )
    {
        return;
    }
    
    if ( level.is_quest_story_mission )
    {
        return;
    }
    
    ob_covert_utility::function_ca660988c89ba0b1();
    level.var_fc42d3458476acb = spawnstruct();
    level.var_fc42d3458476acb.var_29efdb6c1417ca1 = [];
    level.var_fc42d3458476acb.starttriggers = [];
    level.var_fc42d3458476acb.var_a8a8293e43b2f52b = getnoentvolumearray( "covert_underwater_path_trigger", #script_noteworthy );
    level.var_fc42d3458476acb.var_491847e095ef9a1d = getentitylessscriptablearray( "covert_underwater_portal", #script_noteworthy );
    
    if ( level.var_fc42d3458476acb.var_a8a8293e43b2f52b.size <= 0 )
    {
        return;
    }
    
    foreach ( triggerent in level.var_fc42d3458476acb.var_a8a8293e43b2f52b )
    {
        if ( issubstr( triggerent.targetname, "covert_underwater_path_trigger_start" ) )
        {
            level.var_fc42d3458476acb.starttriggers[ level.var_fc42d3458476acb.starttriggers.size ] = triggerent;
        }
    }
    
    if ( level.var_fc42d3458476acb.starttriggers.size <= 0 )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "sat_ob_cover_underwater_portal", &function_154c71bd0a2ec74b );
    function_e9c1e1b72474021e();
    thread function_250e0b329483e4d6();
    
    /#
        thread function_97429e71dab64419();
    #/
}

// Namespace ob_covert_underwater
// Params 0, eflags: 0x4
// Checksum 0x888da581, Offset: 0x3a3
// Size: 0x16b
function private function_e9c1e1b72474021e()
{
    pathindex = 0;
    
    foreach ( starttrigger in level.var_fc42d3458476acb.starttriggers )
    {
        starttrigger.var_699b5576e94a9210 = pathindex;
        
        for ( curpoint = function_56e408d4d4d71f07( starttrigger ); isdefined( curpoint ) ; curpoint = function_56e408d4d4d71f07( curpoint ) )
        {
            curpoint.var_699b5576e94a9210 = pathindex;
            
            foreach ( portal in level.var_fc42d3458476acb.var_491847e095ef9a1d )
            {
                if ( portal.target == curpoint.targetname )
                {
                    portal.var_699b5576e94a9210 = pathindex;
                }
            }
        }
        
        pathindex++;
    }
}

// Namespace ob_covert_underwater
// Params 0, eflags: 0x4
// Checksum 0x37d8b5e2, Offset: 0x516
// Size: 0x124
function private function_250e0b329483e4d6()
{
    level endon( #"game_ended" );
    
    while ( level.var_fc42d3458476acb.starttriggers.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player && !arraycontains( level.var_fc42d3458476acb.var_29efdb6c1417ca1, player ) )
            {
                touchent = player getistouchingentities( level.var_fc42d3458476acb.starttriggers );
                
                if ( touchent && touchent.size > 0 )
                {
                    starttrigger = touchent[ 0 ];
                    
                    if ( starttrigger )
                    {
                        function_f83808dbc3089857( starttrigger.var_699b5576e94a9210, 1 );
                        thread monitor_player( player, starttrigger );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_covert_underwater
// Params 2, eflags: 0x4
// Checksum 0x19017c9e, Offset: 0x642
// Size: 0x53
function private monitor_player( player, starttrigger )
{
    level.var_fc42d3458476acb.var_29efdb6c1417ca1[ level.var_fc42d3458476acb.var_29efdb6c1417ca1.size ] = player;
    player function_a05926b0ec94ff7d( starttrigger );
    stop_monitor_player( player );
}

// Namespace ob_covert_underwater
// Params 1, eflags: 0x4
// Checksum 0xe8d343a, Offset: 0x69d
// Size: 0x136
function private stop_monitor_player( exitingplayer )
{
    pathid = exitingplayer.var_a9e8314de753f7fb.var_699b5576e94a9210;
    var_4b817d03ea31828f = 1;
    
    foreach ( player in level.var_fc42d3458476acb.var_29efdb6c1417ca1 )
    {
        if ( player && player != exitingplayer && player.var_a9e8314de753f7fb && player.var_a9e8314de753f7fb.var_699b5576e94a9210 == pathid )
        {
            var_4b817d03ea31828f = 0;
            break;
        }
    }
    
    if ( var_4b817d03ea31828f )
    {
        function_f83808dbc3089857( pathid, 0 );
    }
    
    exitingplayer.var_a9e8314de753f7fb = undefined;
    level.var_fc42d3458476acb.var_29efdb6c1417ca1 = arrayremove( level.var_fc42d3458476acb.var_29efdb6c1417ca1, exitingplayer );
}

// Namespace ob_covert_underwater
// Params 1
// Checksum 0xafb6d1e3, Offset: 0x7db
// Size: 0x110
function function_a05926b0ec94ff7d( var_2a1e6b73f0c0bd1e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_a9e8314de753f7fb = function_56e408d4d4d71f07( var_2a1e6b73f0c0bd1e );
    function_6af0fbab0720efb7( self );
    self playsoundtoplayer( "uin_ob_ec_starter", self );
    
    while ( true )
    {
        if ( !self.var_a9e8314de753f7fb )
        {
            return;
        }
        
        if ( !self isswimunderwater() )
        {
            self playsoundtoplayer( "uin_ob_ec_fail", self );
            return;
        }
        
        if ( self istouching( self.var_a9e8314de753f7fb ) )
        {
            function_6af0fbab0720efb7( self );
            
            if ( !isdefined( self.var_a9e8314de753f7fb.target ) || issubstr( self.var_a9e8314de753f7fb.target, "covert_underwater_reward" ) )
            {
                self playsoundtoplayer( "uin_ob_ec_finish", self );
                complete_covert( var_2a1e6b73f0c0bd1e, self, self.var_a9e8314de753f7fb );
                return;
            }
            
            self playsoundtoplayer( "uin_ob_ec_swim_ping", self );
            self.var_a9e8314de753f7fb = function_56e408d4d4d71f07( self.var_a9e8314de753f7fb );
        }
        
        wait 0.1;
    }
}

// Namespace ob_covert_underwater
// Params 1, eflags: 0x4
// Checksum 0x3d91d373, Offset: 0x8f3
// Size: 0x1c
function private function_6af0fbab0720efb7( player )
{
    player swim_common::function_e59f9853946b5d19( 95, &function_fac1d46d1ed0f91e );
}

// Namespace ob_covert_underwater
// Params 0, eflags: 0x4
// Checksum 0xc325dbad, Offset: 0x917
// Size: 0x7
function private function_fac1d46d1ed0f91e()
{
    return 0.75;
}

// Namespace ob_covert_underwater
// Params 1, eflags: 0x4
// Checksum 0xb9312d1a, Offset: 0x927
// Size: 0xaf
function private function_56e408d4d4d71f07( trigger )
{
    if ( isdefined( trigger ) )
    {
        foreach ( vol in level.var_fc42d3458476acb.var_a8a8293e43b2f52b )
        {
            if ( vol && vol.targetname == trigger.target )
            {
                return vol;
            }
        }
    }
}

// Namespace ob_covert_underwater
// Params 6
// Checksum 0xa0216bcb, Offset: 0x9de
// Size: 0x77
function function_154c71bd0a2ec74b( instance, part, state, player, bautouse, usestring )
{
    destination = function_56e408d4d4d71f07( instance );
    
    if ( destination )
    {
        player setorigin( destination.origin );
        player setplayerangles( destination.angles, 0 );
    }
}

// Namespace ob_covert_underwater
// Params 3, eflags: 0x4
// Checksum 0x620a673f, Offset: 0xa5d
// Size: 0xd8
function private complete_covert( var_2a1e6b73f0c0bd1e, player, endtrigger )
{
    function_f83808dbc3089857( var_2a1e6b73f0c0bd1e.var_699b5576e94a9210, 0 );
    level.var_fc42d3458476acb.starttriggers = arrayremove( level.var_fc42d3458476acb.starttriggers, var_2a1e6b73f0c0bd1e );
    
    if ( endtrigger.target )
    {
        rewardstruct = utility::getstruct( endtrigger.target, "targetname" );
        
        if ( rewardstruct )
        {
            ob_covert_utility::covert_spawn_reward( "itemspawnlist:sat_ob_cover_underwater_itemspawnlist", rewardstruct.origin, rewardstruct.angles );
            return;
        }
    }
    
    ob_covert_utility::covert_spawn_reward( "itemspawnlist:sat_ob_cover_underwater_itemspawnlist", endtrigger.origin, endtrigger.angles );
}

// Namespace ob_covert_underwater
// Params 2, eflags: 0x4
// Checksum 0x2a431271, Offset: 0xb3d
// Size: 0xda
function private function_f83808dbc3089857( pathid, enabled )
{
    foreach ( portal in level.var_fc42d3458476acb.var_491847e095ef9a1d )
    {
        if ( portal.var_699b5576e94a9210 == pathid )
        {
            if ( enabled )
            {
                portal setscriptablepartstate( #"sat_ob_cover_underwater_portal", #"usable" );
                continue;
            }
            
            portal setscriptablepartstate( #"sat_ob_cover_underwater_portal", #"inactive" );
        }
    }
}

/#

    // Namespace ob_covert_underwater
    // Params 0, eflags: 0x4
    // Checksum 0x114b32bf, Offset: 0xc1f
    // Size: 0x332, Type: dev
    function private function_97429e71dab64419()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_168550e064eadd0c", 0 ) )
            {
                foreach ( triggerent in level.var_fc42d3458476acb.var_a8a8293e43b2f52b )
                {
                    spherecolor = ( 0, 0, 1 );
                    
                    if ( arraycontains( level.var_fc42d3458476acb.starttriggers, triggerent ) )
                    {
                        spherecolor = ( 0, 1, 0 );
                    }
                    else if ( !isdefined( triggerent.target ) )
                    {
                        spherecolor = ( 1, 0, 0 );
                    }
                    
                    orientedbox( triggerent.origin, triggerent.size_max + triggerent.size_min, triggerent.angles, spherecolor );
                    nexttrigger = function_56e408d4d4d71f07( triggerent );
                    
                    if ( nexttrigger )
                    {
                        line( triggerent.origin, nexttrigger.origin, ( 0, 0, 1 ) );
                    }
                }
                
                foreach ( portal in level.var_fc42d3458476acb.var_491847e095ef9a1d )
                {
                    if ( portal )
                    {
                        portalcolor = ( 0.3, 0, 0.3 );
                        
                        if ( portal getscriptablepartstate( #"sat_ob_cover_underwater_portal", 1 ) == #"usable" )
                        {
                            portalcolor = ( 1, 0, 1 );
                        }
                    }
                    
                    sphere( portal.origin, 40, portalcolor );
                    nexttrigger = function_56e408d4d4d71f07( portal );
                    
                    if ( nexttrigger )
                    {
                        line( portal.origin, nexttrigger.origin, portalcolor );
                    }
                }
                
                foreach ( player in level.var_fc42d3458476acb.var_29efdb6c1417ca1 )
                {
                    if ( player.var_a9e8314de753f7fb )
                    {
                        sphere( player.var_a9e8314de753f7fb.origin, 30, ( 1, 1, 0 ) );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
