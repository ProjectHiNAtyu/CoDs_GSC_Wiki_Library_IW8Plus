// scripts\mp\autopilot.gsc  (hash_642082e8edba5663.gscc) (size: 3629 Bytes / 0xe2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x355613db (894833627)
// size ...... 3629 (0xe2d)
// includes .. 6   (offset: 0xd91)
// strings ... 7   (offset: 0xdc1)
// dev strs .. 0   (offset: 0xe2d)
// exports ... 11  (offset: 0x705)
// cseg ...... 0xe5 + 0x620 (0x705)
// imports ... 42  (offset: 0x8bd)
// animtree1 . 0   (offset: 0xe2d)
// animtree2 . 0   (offset: 0xe2d)
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_util;

#namespace autopilot;

// Namespace autopilot
// Params 3
// Checksum 0xaa914884, Offset: 0x103
// Size: 0x133
function initialize( var_56da166135602a9f, var_9ec61746afb314e2, var_41823fbec6e42cc0 )
{
    assert( !isdefined( level.autopilot ) );
    level.autopilot = spawnstruct();
    level.autopilot.var_3564d4561f8e39f6 = &function_7beafe7feb64f319;
    level.autopilot.var_94abf03bbaf9fe40 = &function_fdbe338ebfc9287d;
    level.autopilot.var_c4f4308cd814658d = var_56da166135602a9f ?? &function_361fa6c2c4638a39;
    level.autopilot.var_4f8260d1c5f43ba1 = var_9ec61746afb314e2 ?? &function_cada5d214acf3668;
    
    if ( isdefined( var_41823fbec6e42cc0 ) )
    {
        if ( isarray( var_41823fbec6e42cc0 ) )
        {
            assert( var_41823fbec6e42cc0.size != 0 );
            level.autopilot.var_b70508c0fd60adb0 = var_41823fbec6e42cc0;
            level.autopilot.var_4a9712fc1e07a8e1 = &function_12308b38368141e2;
        }
        else
        {
            assert( isfunction( var_41823fbec6e42cc0 ) );
            level.autopilot.var_4a9712fc1e07a8e1 = var_41823fbec6e42cc0;
        }
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0x6a192ea4, Offset: 0x23e
// Size: 0x197
function private function_7beafe7feb64f319()
{
    while ( !isdefined( level.bot_variables_initialized ) )
    {
        waitframe();
    }
    
    self notify( #"enter_autopilot" );
    
    if ( getdvarint( @"scr_autopilot_hud", 1 ) == 1 )
    {
        if ( !scripted_widgets::is_active( "autopilot_indicator" ) )
        {
            scripted_widgets::create( "autopilot_indicator", "scripted_widget_generic_text" );
            scripted_widgets::function_f15c5dfb6c0f57c7( "autopilot_indicator", "locstring_index", getlocstringindex( &"SHARED_HINTSTRINGS/AUTOPILOT" ) );
            scripted_widgets::set_state( "autopilot_indicator", "BottomCenter" );
            scripted_widgets::set_position( "autopilot_indicator", 0, -150, 1, 2 );
        }
    }
    
    self function_960e507a760027e5( 1 );
    self.entity_number = self getentitynumber();
    assert( isdefined( level.autopilot ) );
    
    if ( isdefined( level.autopilot.var_4f8260d1c5f43ba1 ) )
    {
        self [[ level.autopilot.var_4f8260d1c5f43ba1 ]]();
    }
    
    if ( !isdefined( self.var_f188ea8f251285a0 ) )
    {
        self.var_f188ea8f251285a0 = 1;
    }
    
    bots_util_mp::bot_set_difficulty( "regular" );
    bots::function_7226c9d17a3ed27( self.var_f188ea8f251285a0, 1 );
    
    if ( self botgetdifficultysetting( "advancedPersonality" ) && self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        bots_personality::function_cc26fb6ecde979dc( 0 );
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        self._blackboard = self getaiblackboard();
    }
    
    if ( self.var_f188ea8f251285a0 )
    {
        bots::function_da11fef8993884fd();
    }
    
    self.var_f188ea8f251285a0 = 0;
    bots::function_abd267784d89d474();
    bots::bot_restart_think_threads();
    thread watchgameendthread();
    thread watchdeaththread();
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0xa362b9c8, Offset: 0x3dd
// Size: 0x43
function private watchgameendthread()
{
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level waittill( #"game_ended" );
    self.pers[ #"hash_1d057e7863454d0e" ] = 1;
    self playerexitautopilotmode();
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0xaaeaa1b6, Offset: 0x428
// Size: 0x4f
function private watchdeaththread()
{
    self endon( #"exit_autopilot" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    self.pers[ #"hash_1d057e7863454d0e" ] = 1;
    self playerexitautopilotmode();
}

// Namespace autopilot
// Params 1, eflags: 0x4
// Checksum 0xe9ab413a, Offset: 0x47f
// Size: 0x3d
function private onplayerspawned( params )
{
    if ( !self.pers[ #"hash_1d057e7863454d0e" ] )
    {
        return;
    }
    
    self.pers[ #"hash_1d057e7863454d0e" ] = undefined;
    self function_ffb0711adb6d8d0d();
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0x9dc09ebe, Offset: 0x4c4
// Size: 0xb6
function private function_fdbe338ebfc9287d()
{
    self notify( #"exit_autopilot" );
    
    if ( scripted_widgets::is_active( "autopilot_indicator" ) )
    {
        scripted_widgets::destroy( "autopilot_indicator" );
    }
    
    assert( isdefined( level.autopilot ) );
    
    if ( isdefined( level.autopilot.var_4a9712fc1e07a8e1 ) )
    {
        self [[ level.autopilot.var_4a9712fc1e07a8e1 ]]();
    }
    
    if ( isalive( self ) )
    {
        bots::bot_post_death_func();
    }
    
    bots::function_2bc9768ae531395e();
    self._blackboard = undefined;
    self function_960e507a760027e5( 0 );
    
    if ( isalive( self ) && getdvarfloat( @"hash_876e1130767adf57", -1 ) > 0 )
    {
        thread function_3ce1c38d17ea81f7();
    }
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0xb1183980, Offset: 0x582
// Size: 0xa9
function private function_3ce1c38d17ea81f7()
{
    self endon( #"disconnect" );
    self endon( #"enter_autopilot" );
    afktime = 0;
    
    while ( true )
    {
        prev_origin = self.origin;
        prev_angles = self getplayerangles();
        wait 1;
        afktime += 1;
        
        if ( distance( prev_origin, self.origin ) > 5 || distance( prev_angles, self getplayerangles() ) > 5 )
        {
            afktime = 0;
        }
        
        if ( afktime >= getdvarfloat( @"hash_876e1130767adf57", -1 ) )
        {
            self function_ffb0711adb6d8d0d();
        }
    }
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0x1de3120d, Offset: 0x633
// Size: 0x22, Type: bool
function private function_361fa6c2c4638a39()
{
    if ( !isalive( self ) )
    {
        self.pers[ #"hash_1d057e7863454d0e" ] = undefined;
        return false;
    }
    
    return true;
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0x6752cc24, Offset: 0x65e
// Size: 0x2
function private function_cada5d214acf3668()
{
    
}

// Namespace autopilot
// Params 0, eflags: 0x4
// Checksum 0xe81a6690, Offset: 0x668
// Size: 0x9d
function private function_12308b38368141e2()
{
    assert( isdefined( level.autopilot.var_b70508c0fd60adb0 ) );
    
    foreach ( signal in level.autopilot.var_b70508c0fd60adb0 )
    {
        self notify( signal );
    }
}

