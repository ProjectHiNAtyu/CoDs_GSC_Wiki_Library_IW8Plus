// script_1924b557dd30ebee  (hash_1924b557dd30ebee.gscc) (size: 6153 Bytes / 0x1809 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2fca6fd (3539773181)
// size ...... 6153 (0x1809)
// includes .. 10  (offset: 0x172d)
// strings ... 9   (offset: 0x177d)
// dev strs .. 2   (offset: 0x17f1)
// exports ... 16  (offset: 0xee5)
// cseg ...... 0xf2 + 0xdf3 (0xee5)
// imports ... 50  (offset: 0x1165)
// animtree1 . 0   (offset: 0x1809)
// animtree2 . 0   (offset: 0x1809)
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\music_and_dialog;

#namespace namespace_1ff0dda307309968;

// Namespace namespace_1ff0dda307309968
// Params 1
// Checksum 0x35de2d19, Offset: 0x110
// Size: 0x75
function dmztask_getspawndata( data )
{
    level.clearprops = spawnstruct();
    level.clearprops.circleradius = getdvarint( @"hash_fe6626ef02d8f40c", 300 );
    level.clearprops.circlepadding = getdvarint( @"hash_336efda7c2d0eef", 700 );
    activity_manager::function_f61a1f535aab4194( data, &function_b3d4c89a13551cfc, function_f233db853fbce92a() );
}

/#

    // Namespace namespace_1ff0dda307309968
    // Params 0
    // Checksum 0xe879c061, Offset: 0x18d
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x2d>" );
    }

#/

// Namespace namespace_1ff0dda307309968
// Params 2
// Checksum 0xc16da49f, Offset: 0x1ab
// Size: 0xba
function function_b3d4c89a13551cfc( activity, fortress )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_1162e8d707e4519b;
    task.funcs[ "onTeamStart" ] = &function_3a9bc66a7ee1c2f8;
    task.funcs[ "onTeamAssigned" ] = &function_9dcf3a6e858b3bc;
    task.fortress = fortress;
    task.node = fortress;
    task.ref = "dmz_clear_fortress";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_1ff0dda307309968
// Params 0
// Checksum 0x5f791a8d, Offset: 0x26e
// Size: 0x15f
function function_1162e8d707e4519b()
{
    self.killed = 0;
    circlelocation = dmz_task_utils::function_c7ccd46fc59f189d( self.fortress.origin, level.clearprops.circleradius );
    dmz_task_utils::function_b3476f99a8e21fa2( self.fortress.origin + ( 0, 0, 750 ) );
    dmz_task_utils::function_13fe84cb824c72a8( "Hostage_Dmz", [ circlelocation ], level.clearprops.circleradius + level.clearprops.circlepadding );
    
    if ( !self.fortress.spawnedagents )
    {
        self.fortress waittill( #"spawned_agents" );
    }
    
    self.var_7834991e33c46f05 = function_21731490db22dc16();
    
    if ( !isdefined( self.var_7834991e33c46f05 ) || self.var_7834991e33c46f05.size == 0 )
    {
        dmz_task_utils::task_ended();
        return;
    }
    
    self.var_201f4c833bf35ea0 = self.var_7834991e33c46f05.size;
    self.activity.origin = self.fortress.origin;
    thread function_ec575b8de2afe52c();
    self.initialized = 1;
    self notify( #"task_initialized" );
}

// Namespace namespace_1ff0dda307309968
// Params 1
// Checksum 0x889e02d2, Offset: 0x3d5
// Size: 0x56
function function_3a9bc66a7ee1c2f8( teamname )
{
    self endon( #"end_task" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"clear_fort_approach", teamname );
}

// Namespace namespace_1ff0dda307309968
// Params 1
// Checksum 0x23dbb721, Offset: 0x433
// Size: 0x7f
function function_9dcf3a6e858b3bc( teamname )
{
    self endon( #"end_task" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"clear_fort_assigned", teamname );
    thread function_c01220e3266a3b33( teamname );
    dmz_task_utils::task_showsplashtoteam( "dmz_clear_fort_assigned", teamname );
    dmz_task_utils::function_18b83232055b1325( teamname );
    thread dmz_task_utils::function_96037ebc29937337( teamname );
}

// Namespace namespace_1ff0dda307309968
// Params 2
// Checksum 0x1c79cca, Offset: 0x4ba
// Size: 0x70
function function_65f5c3523949fd65( agent, killer )
{
    if ( isdefined( killer ) && isdefined( killer.team ) && arraycontains( self.var_7834991e33c46f05, agent ) )
    {
        function_8dac79ec2df0939();
        
        if ( self.var_7834991e33c46f05.size == 1 )
        {
            thread function_27595d4825e4f51a( killer.team );
        }
        
        function_fce38740ffcb113f( killer, agent );
    }
}

// Namespace namespace_1ff0dda307309968
// Params 0
// Checksum 0x79142a93, Offset: 0x532
// Size: 0x158
function function_ec575b8de2afe52c()
{
    while ( true )
    {
        ai = utility::charactersnear( self.fortress.origin, 3000, 0 );
        var_28654821c71bb1e5 = [];
        
        foreach ( guy in ai )
        {
            foreach ( volume in self.fortress.fortressvolumes )
            {
                if ( ispointinvolume( guy.origin, volume ) )
                {
                    var_28654821c71bb1e5[ var_28654821c71bb1e5.size ] = guy;
                }
            }
        }
        
        if ( !var_28654821c71bb1e5.size )
        {
            function_974b43c2b69b3bc2( self.teams[ 0 ] );
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_1ff0dda307309968
// Params 1
// Checksum 0xc5118ded, Offset: 0x692
// Size: 0xaa
function function_974b43c2b69b3bc2( teamname )
{
    self notify( #"end_task" );
    ai_mp_controller::function_52ec288d11c14408( &function_65f5c3523949fd65, self );
    dmz_task_utils::function_3ff46488beb193c7();
    dmz_task_utils::function_e23cad864e9e2023();
    
    if ( isdefined( teamname ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"clear_fort_success", teamname );
        dmz_task_utils::function_c64a66646904bc1( "dmz_clear_fort_complete", "clear", self.activity.cashreward, teamname );
        dmz_task_utils::function_e533421ccebd7d79( teamname );
        thread music_and_dialog::dmz_activity_win( teams::getteamdata( teamname, "players" ) );
    }
    
    waitframe();
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_1ff0dda307309968
// Params 1, eflags: 0x4
// Checksum 0xc924f0cb, Offset: 0x744
// Size: 0x19d
function private function_27595d4825e4f51a( teamname )
{
    self endon( #"end_task" );
    wait 15;
    
    while ( true )
    {
        players = teams::getteamdata( teamname, "players" );
        
        foreach ( ai in self.var_7834991e33c46f05 )
        {
            playertotarget = undefined;
            mindist = 1000000000;
            
            foreach ( player in players )
            {
                distancetoplayer = distance( ai.origin, player.origin );
                
                if ( distancetoplayer < mindist )
                {
                    mindist = distancetoplayer;
                    playertotarget = player;
                }
            }
            
            if ( !isdefined( playertotarget ) )
            {
                continue;
            }
            
            if ( !ai cansee( playertotarget ) && mindist > 50 && mindist < 500 )
            {
                ai_behavior::behavior_combatRushOrigin( ai, playertotarget.origin );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_1ff0dda307309968
// Params 0, eflags: 0x4
// Checksum 0x7650470, Offset: 0x8e9
// Size: 0xb5
function private function_f233db853fbce92a()
{
    possiblefortresses = ai_fortress::function_227fd362aaa3252c();
    nodes = [];
    
    if ( !isdefined( possiblefortresses ) )
    {
        return nodes;
    }
    
    foreach ( fort in possiblefortresses )
    {
        if ( ai_fortress::function_c4cc2f9a17167e1b( fort ) )
        {
            continue;
        }
        
        fort.fortress = fort;
        nodes[ nodes.size ] = fort;
    }
    
    return nodes;
}

// Namespace namespace_1ff0dda307309968
// Params 0, eflags: 0x4
// Checksum 0x7d505e44, Offset: 0x9a7
// Size: 0x167
function private function_21731490db22dc16()
{
    if ( !isdefined( self.fortress ) )
    {
        return;
    }
    
    allai = level.agentarray;
    
    if ( !isdefined( allai ) || allai.size == 0 )
    {
        return;
    }
    
    validai = [];
    
    if ( self.fortress.fortressvolumes.size == 0 )
    {
        return validai;
    }
    
    foreach ( guy in allai )
    {
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        foreach ( volume in self.fortress.fortressvolumes )
        {
            if ( ispointinvolume( guy.origin, volume ) )
            {
                validai[ validai.size ] = guy;
            }
        }
    }
    
    return validai;
}

// Namespace namespace_1ff0dda307309968
// Params 0, eflags: 0x4
// Checksum 0xec394725, Offset: 0xb17
// Size: 0x128
function private function_8dac79ec2df0939()
{
    numdead = 0;
    deadai = [];
    
    foreach ( ai in self.var_7834991e33c46f05 )
    {
        if ( !isalive( ai ) )
        {
            deadai[ deadai.size ] = ai;
            numdead++;
        }
    }
    
    foreach ( ai in deadai )
    {
        self.var_7834991e33c46f05 = arrayremove( self.var_7834991e33c46f05, ai );
    }
    
    self.killed += numdead;
}

// Namespace namespace_1ff0dda307309968
// Params 2, eflags: 0x4
// Checksum 0xedcb13da, Offset: 0xc47
// Size: 0xd0
function private function_fce38740ffcb113f( killer, agent )
{
    if ( self.killed >= self.var_201f4c833bf35ea0 || self.var_7834991e33c46f05.size == 0 )
    {
        if ( isdefined( agent ) )
        {
            self.mission.objpos = agent.origin;
            self.mission.objangles = agent.angles;
        }
        
        if ( isdefined( killer ) && isdefined( killer.team ) && activity_manager::activity_currenttask( self.activity, killer.team ) == self )
        {
            function_974b43c2b69b3bc2( killer.team );
            return;
        }
        
        function_974b43c2b69b3bc2();
    }
}

// Namespace namespace_1ff0dda307309968
// Params 1, eflags: 0x4
// Checksum 0x9fa9ed2b, Offset: 0xd1f
// Size: 0x1c6
function private function_c01220e3266a3b33( team )
{
    self endon( #"end_task" );
    
    while ( true )
    {
        players = teams::getteamdata( team, "players" );
        mindistsq = 100000;
        minorigin = ( 0, 0, 0 );
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            distsq = distance2dsquared( self.fortress.origin, player.origin );
            
            if ( mindistsq > distsq )
            {
                mindistsq = distsq;
                minorigin = player.origin;
            }
        }
        
        foreach ( volume in self.fortress.fortressvolumes )
        {
            if ( ispointinvolume( minorigin, volume ) )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"clear_fort_entered", team );
                return;
            }
        }
        
        wait 1;
    }
}

