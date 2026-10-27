// scripts\mp\ob\activities\ob_covert_parkour.gsc  (hash_100df1f75bb075ba.gscc) (size: 5273 Bytes / 0x1499 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bccc16c (2077016428)
// size ...... 5273 (0x1499)
// includes .. 7   (offset: 0x13e5)
// strings ... 10  (offset: 0x141d)
// dev strs .. 0   (offset: 0x1499)
// exports ... 12  (offset: 0xd6d)
// cseg ...... 0x17a + 0xbf3 (0xd6d)
// imports ... 39  (offset: 0xf4d)
// animtree1 . 0   (offset: 0x1499)
// animtree2 . 0   (offset: 0x1499)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\supers\teleport;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\ob\activities\ob_covert_utility;
#using scripts\mp\ob\supers\mega_jump;

#namespace ob_covert_parkour;

// Namespace ob_covert_parkour
// Params 0, eflags: 0x5
// Checksum 0x63f54b1e, Offset: 0x198
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_covert_parkour", undefined, undefined, &init_gameplay );
}

// Namespace ob_covert_parkour
// Params 0, eflags: 0x4
// Checksum 0xdaa66f0, Offset: 0x1b9
// Size: 0x2ab
function private init_gameplay()
{
    level.var_3d3aa757f9edca6c = spawnstruct();
    level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1 = [];
    level.var_3d3aa757f9edca6c.starttriggers = [];
    level.var_3d3aa757f9edca6c.endtriggers = [];
    level.var_3d3aa757f9edca6c.lavatriggers = [];
    level.var_3d3aa757f9edca6c.var_a8a8293e43b2f52b = getnoentvolumearray( "covert_parkour_path_trigger", #script_noteworthy );
    level.var_3d3aa757f9edca6c.markers = getentitylessscriptablearray( "covert_parkour_markers", #script_noteworthy );
    
    if ( !getdvarint( @"scr_sat_ob_covert_parkour", 1 ) || level.is_quest_story_mission || level.var_3d3aa757f9edca6c.var_a8a8293e43b2f52b.size <= 0 )
    {
        thread hide_all_markers( 5 );
        return;
    }
    
    ob_covert_utility::function_ca660988c89ba0b1();
    
    foreach ( triggerent in level.var_3d3aa757f9edca6c.var_a8a8293e43b2f52b )
    {
        if ( issubstr( triggerent.targetname, "covert_parkour_path_trigger_start" ) )
        {
            level.var_3d3aa757f9edca6c.starttriggers[ level.var_3d3aa757f9edca6c.starttriggers.size ] = triggerent;
            continue;
        }
        
        if ( issubstr( triggerent.targetname, "covert_parkour_path_trigger_end" ) )
        {
            level.var_3d3aa757f9edca6c.endtriggers[ level.var_3d3aa757f9edca6c.endtriggers.size ] = triggerent;
            continue;
        }
        
        if ( issubstr( triggerent.targetname, "covert_parkour_path_trigger_lava" ) )
        {
            level.var_3d3aa757f9edca6c.lavatriggers[ level.var_3d3aa757f9edca6c.lavatriggers.size ] = triggerent;
        }
    }
    
    if ( level.var_3d3aa757f9edca6c.starttriggers.size <= 0 || level.var_3d3aa757f9edca6c.endtriggers.size <= 0 || level.var_3d3aa757f9edca6c.lavatriggers.size <= 0 )
    {
        return;
    }
    
    thread function_80566ef288558f1();
    
    /#
        thread function_129cd72eb2d4d49e();
    #/
}

// Namespace ob_covert_parkour
// Params 0, eflags: 0x4
// Checksum 0x842e1276, Offset: 0x46c
// Size: 0x12b
function private function_80566ef288558f1()
{
    level endon( #"game_ended" );
    
    while ( level.var_3d3aa757f9edca6c.starttriggers.size > 0 )
    {
        foreach ( player in level.players )
        {
            if ( player && !arraycontains( level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1, player ) )
            {
                touchent = player getistouchingentities( level.var_3d3aa757f9edca6c.starttriggers );
                
                if ( touchent && touchent.size > 0 )
                {
                    level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1[ level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1.size ] = player;
                    player thread function_a05926b0ec94ff7d( touchent[ 0 ] );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ob_covert_parkour
// Params 1
// Checksum 0xc84a4b06, Offset: 0x59f
// Size: 0x12a
function function_a05926b0ec94ff7d( var_2a1e6b73f0c0bd1e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_d63b4d52c676760 = function_56e408d4d4d71f07( var_2a1e6b73f0c0bd1e );
    self playsoundtoplayer( "uin_ob_ec_starter", self );
    
    while ( true )
    {
        if ( !self.var_d63b4d52c676760 )
        {
            stop_monitor_player( self );
            return;
        }
        
        touchent = self getistouchingentities( level.var_3d3aa757f9edca6c.lavatriggers );
        
        if ( touchent && touchent.size > 0 || function_fb22c4d7da8aedd2() )
        {
            self playsoundtoplayer( "uin_ob_ec_fail", self );
            stop_monitor_player( self );
            return;
        }
        
        if ( self istouching( self.var_d63b4d52c676760 ) )
        {
            if ( arraycontains( level.var_3d3aa757f9edca6c.endtriggers, self.var_d63b4d52c676760 ) )
            {
                self playsoundtoplayer( "uin_ob_ec_finish", self );
                complete_covert( var_2a1e6b73f0c0bd1e, self, self.var_d63b4d52c676760 );
                stop_monitor_player( self );
                return;
            }
            
            self.var_d63b4d52c676760 = function_56e408d4d4d71f07( self.var_d63b4d52c676760 );
        }
        
        wait 0.1;
    }
}

// Namespace ob_covert_parkour
// Params 1, eflags: 0x4
// Checksum 0x913bed09, Offset: 0x6d1
// Size: 0x44
function private stop_monitor_player( player )
{
    player.var_d63b4d52c676760 = undefined;
    level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1 = arrayremove( level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1, player );
}

// Namespace ob_covert_parkour
// Params 3, eflags: 0x4
// Checksum 0x93205226, Offset: 0x71d
// Size: 0x12f
function private complete_covert( var_2a1e6b73f0c0bd1e, player, endtrigger )
{
    level.var_3d3aa757f9edca6c.starttriggers = arrayremove( level.var_3d3aa757f9edca6c.starttriggers, var_2a1e6b73f0c0bd1e );
    set_markers_state( var_2a1e6b73f0c0bd1e, 1, 0 );
    
    if ( endtrigger.target )
    {
        rewardstruct = utility::getstruct( endtrigger.target, "targetname" );
        
        if ( rewardstruct )
        {
            level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"hash_bb4dd3a6d8438047", #player:player } );
            ob_covert_utility::covert_spawn_reward( "itemspawnlist:sat_ob_cover_parkour_itemspawnlist", rewardstruct.origin, rewardstruct.angles );
            return;
        }
    }
    
    level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"hash_bb4dd3a6d8438047", #player:player } );
    ob_covert_utility::covert_spawn_reward( "itemspawnlist:sat_ob_cover_parkour_itemspawnlist", endtrigger.origin, endtrigger.angles );
}

// Namespace ob_covert_parkour
// Params 1, eflags: 0x4
// Checksum 0x9017ea95, Offset: 0x854
// Size: 0xaf
function private function_56e408d4d4d71f07( trigger )
{
    if ( isdefined( trigger ) )
    {
        foreach ( vol in level.var_3d3aa757f9edca6c.var_a8a8293e43b2f52b )
        {
            if ( vol && vol.targetname == trigger.target )
            {
                return vol;
            }
        }
    }
}

// Namespace ob_covert_parkour
// Params 3, eflags: 0x4
// Checksum 0x6912f92d, Offset: 0x90b
// Size: 0x110
function private set_markers_state( var_31524a8e1e1d798d, visible, active )
{
    foreach ( marker in level.var_3d3aa757f9edca6c.markers )
    {
        if ( marker.target != var_31524a8e1e1d798d.targetname )
        {
            continue;
        }
        
        if ( visible )
        {
            if ( active )
            {
                marker setscriptablepartstate( #"base", #"active" );
            }
            else
            {
                marker setscriptablepartstate( #"base", #"inactive" );
            }
            
            continue;
        }
        
        marker setscriptablepartstate( #"base", #"hidden" );
    }
}

// Namespace ob_covert_parkour
// Params 1, eflags: 0x4
// Checksum 0x57bdd4d1, Offset: 0xa23
// Size: 0xc1
function private hide_all_markers( delay = 0 )
{
    level endon( #"game_ended" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    foreach ( marker in level.var_3d3aa757f9edca6c.markers )
    {
        marker setscriptablepartstate( #"base", #"hidden" );
    }
}

// Namespace ob_covert_parkour
// Params 0, eflags: 0x4
// Checksum 0x4dad0096, Offset: 0xaec
// Size: 0x3e, Type: bool
function private function_fb22c4d7da8aedd2()
{
    if ( self isskydiving() )
    {
        return true;
    }
    
    if ( self function_41360f0bcfc012aa() )
    {
        return true;
    }
    
    if ( player_utility::function_c0192d3e90f65e0e( self ) )
    {
        return true;
    }
    
    if ( teleport::function_29441fcf4c563596() )
    {
        return true;
    }
    
    if ( super_mega_jump::function_d030d60e3764de0f() )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace ob_covert_parkour
    // Params 0, eflags: 0x4
    // Checksum 0x518948c2, Offset: 0xb33
    // Size: 0x23a, Type: dev
    function private function_129cd72eb2d4d49e()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_460622ef6d06ed9d", 0 ) )
            {
                foreach ( triggerent in level.var_3d3aa757f9edca6c.var_a8a8293e43b2f52b )
                {
                    spherecolor = ( 1, 0.65, 0 );
                    
                    if ( arraycontains( level.var_3d3aa757f9edca6c.starttriggers, triggerent ) )
                    {
                        spherecolor = ( 0, 1, 0 );
                    }
                    else if ( arraycontains( level.var_3d3aa757f9edca6c.endtriggers, triggerent ) )
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
                
                foreach ( player in level.var_3d3aa757f9edca6c.var_29efdb6c1417ca1 )
                {
                    if ( player.var_d63b4d52c676760 )
                    {
                        sphere( player.var_d63b4d52c676760.origin, 30, ( 1, 1, 0 ) );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
