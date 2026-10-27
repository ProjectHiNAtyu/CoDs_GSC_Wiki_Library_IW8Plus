// script_73805a7d72edcbab  (hash_73805a7d72edcbab.gscc) (size: 3671 Bytes / 0xe57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21754d37 (561335607)
// size ...... 3671 (0xe57)
// includes .. 2   (offset: 0xdcf)
// strings ... 8   (offset: 0xddf)
// dev strs .. 2   (offset: 0xe3f)
// exports ... 12  (offset: 0x887)
// cseg ...... 0xfa + 0x78d (0x887)
// imports ... 29  (offset: 0xa67)
// animtree1 . 0   (offset: 0xe57)
// animtree2 . 0   (offset: 0xe57)
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\airdrop;

#namespace namespace_e14671bfc73f6500;

// Namespace namespace_e14671bfc73f6500
// Params 0
// Checksum 0x98a2e734, Offset: 0x118
// Size: 0x193
function function_95dd81f3161b763f()
{
    level.elite_ironclad.bunker_hatches = getentarray( "cq_hatch", #script_noteworthy );
    
    foreach ( hatch in level.elite_ironclad.bunker_hatches )
    {
        forward = anglestoforward( hatch.angles );
        right = anglestoright( hatch.angles );
        up = anglestoup( hatch.angles );
        hinge_pos = hatch.origin + forward * 43.211 + right * -1.649 * -1 + up * 0;
        pivot = spawn( "script_origin", hinge_pos );
        pivot.angles = hatch.angles;
        hatch linkto( pivot );
        hatch.pivot = pivot;
        hatch.state = #"open";
        
        if ( getdvarint( @"hash_853626e41efec2e5", 0 ) == 0 )
        {
            function_fe8cf3990e2e4cb0( hatch );
        }
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 1
// Checksum 0x6fd2391b, Offset: 0x2b3
// Size: 0x138
function function_b7ac27ac5cb3126f( position )
{
    level endon( #"game_ended" );
    var_6465d4893550e6c1 = getdvarint( @"hash_a353af43e8b24574", 1 );
    var_484e5187236c71c2 = getdvarint( @"hash_335ee4106d778c93", 1 );
    var_49259c98876206e3 = 180;
    
    while ( true )
    {
        scriptables = getscriptablearrayinradius( undefined, undefined, position, var_49259c98876206e3 );
        
        /#
            sphere( position, var_49259c98876206e3, ( 1, 0, 0 ), 0, 20 );
        #/
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable.streakref == "airdrop_crate" && var_6465d4893550e6c1 )
            {
                scriptable airdrop::destroycrate( 1 );
            }
            
            if ( scriptable vehicle::is_vehicle() && var_484e5187236c71c2 )
            {
                scriptable explode_vehicle( undefined );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 1, eflags: 0x4
// Checksum 0x4692243, Offset: 0x3f3
// Size: 0xa0
function private explode_vehicle( inflictor )
{
    if ( self.rcxdtype )
    {
        return;
    }
    
    if ( self.helperdronetype )
    {
        return;
    }
    
    if ( self.targetname && self.targetname == "veh_sat_mini_sentry" )
    {
        return;
    }
    
    damage_data = spawnstruct();
    damage_data.inflictor = inflictor;
    damage_data.objweapon = undefined;
    damage_data.meansofdeath = "MOD_UNKNOWN";
    damage_data.attacker = inflictor;
    vehicle::explode( damage_data, 1 );
    waitframe();
    self delete();
}

// Namespace namespace_e14671bfc73f6500
// Params 1
// Checksum 0x1eff03f7, Offset: 0x49b
// Size: 0x40
function function_160bda82ad64eb2d( position )
{
    bunker_hatches = arraycopy( level.elite_ironclad.bunker_hatches );
    bunker_hatches = arraysort( bunker_hatches, position, &function_8823fbe4007b72bc );
    return bunker_hatches[ 0 ];
}

// Namespace namespace_e14671bfc73f6500
// Params 3
// Checksum 0x64aca568, Offset: 0x4e4
// Size: 0x5a, Type: bool
function function_8823fbe4007b72bc( a, b, position )
{
    var_ee571a0f68c75ae2 = distancesquared( a.origin, position );
    var_ee57190f68c758af = distancesquared( b.origin, position );
    return var_ee571a0f68c75ae2 < var_ee57190f68c758af;
}

// Namespace namespace_e14671bfc73f6500
// Params 2
// Checksum 0x5da22c45, Offset: 0x547
// Size: 0x6e
function function_57187b3d0e82cd9c( bunker_hatch, time_to_open = 0.1 )
{
    if ( bunker_hatch.state == #"closed" )
    {
        bunker_hatch.pivot rotatepitch( -135, time_to_open );
        bunker_hatch.state = #"open";
        bunker_hatch playsound( "evt_bunker_hatch_open" );
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 2
// Checksum 0xe1f8555d, Offset: 0x5bd
// Size: 0x62
function function_fe8cf3990e2e4cb0( bunker_hatch, time_to_open = 0.1 )
{
    if ( bunker_hatch.state == #"open" )
    {
        bunker_hatch.pivot rotatepitch( 135, time_to_open );
        bunker_hatch.state = #"closed";
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 0
// Checksum 0xdbbda1fb, Offset: 0x627
// Size: 0x11f
function set_bunker_kill_brushes()
{
    level.elite_ironclad.bunker_kill_brushes = [];
    
    if ( !getdvarint( @"hash_4a252b44c3dd0db3", 0 ) )
    {
        var_4f0c543357a5f85d = getentarray( "cq_killbrush_bunker_stairs", #script_noteworthy );
        level.elite_ironclad.bunker_kill_brushes = getentarray( "cq_killbrush_bunker", #script_noteworthy );
        
        foreach ( trigger in level.elite_ironclad.bunker_kill_brushes )
        {
            trigger.stair = function_b036b01891701294( trigger.origin, var_4f0c543357a5f85d );
            trigger thread function_466ab3bc9796737f();
            trigger.stair thread function_466ab3bc9796737f();
        }
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 0, eflags: 0x4
// Checksum 0x8274483f, Offset: 0x74e
// Size: 0x53
function private function_466ab3bc9796737f()
{
    while ( !self.disable )
    {
        self waittill( #"trigger", player );
        
        if ( !self.disable && isplayer( player ) && isalive( player ) )
        {
            player suicide();
        }
    }
}

// Namespace namespace_e14671bfc73f6500
// Params 2, eflags: 0x4
// Checksum 0x5da30c9c, Offset: 0x7a9
// Size: 0x38
function private function_b036b01891701294( position, array )
{
    bunker_kill_brushes = arraycopy( array );
    bunker_kill_brushes = arraysort( bunker_kill_brushes, position, &function_8823fbe4007b72bc );
    return bunker_kill_brushes[ 0 ];
}

// Namespace namespace_e14671bfc73f6500
// Params 1
// Checksum 0x5f5b4fbf, Offset: 0x7ea
// Size: 0x9d
function function_b823cb475a92c33c( origin )
{
    if ( level.elite_ironclad.bunker_kill_brushes.size )
    {
        kill_brush_bunker = function_b036b01891701294( origin, level.elite_ironclad.bunker_kill_brushes );
        assert( kill_brush_bunker, "<dev string:x24>" + origin );
        kill_brush_bunker.disable = 1;
        assert( kill_brush_bunker.stair, "<dev string:x64>" + origin );
        kill_brush_bunker.stair.disable = 1;
    }
}

