// scripts\mp\ob\systems\ob_worldevent_manager.gsc  (hash_309a79ed153f54e7.gscc) (size: 15422 Bytes / 0x3c3e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x905608f0 (2421557488)
// size ...... 15422 (0x3c3e)
// includes .. 7   (offset: 0x35ce)
// strings ... 94  (offset: 0x3606)
// dev strs .. 0   (offset: 0x3c3e)
// exports ... 18  (offset: 0x2a56)
// cseg ...... 0xd3d + 0x1d19 (0x2a56)
// imports ... 55  (offset: 0x2d26)
// animtree1 . 0   (offset: 0x3c3e)
// animtree2 . 0   (offset: 0x3c3e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_resource_manager;

#namespace ob_worldevent_manager;

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x1c14141c, Offset: 0xd5b
// Size: 0xc
function private function_91b983adeae795fc()
{
    return "GetTime()=" + gettime();
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x1
// Checksum 0xd79b9067, Offset: 0xd70
// Size: 0x14
function autoexec init()
{
    level callback::add( "activities_registered", &_on_activities_registered );
}

// Namespace ob_worldevent_manager
// Params 1, eflags: 0x4
// Checksum 0xf48b3cfd, Offset: 0xd8c
// Size: 0xba3
function private _on_activities_registered( params )
{
    level callback::remove( "activities_registered", &_on_activities_registered );
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Should Disable Activities in Global Event Radius? " + function_2f9f158f3bc5e040() );
    }
    
    isenabled = getdvarint( @"wem_enabled", 0 ) != 0;
    
    if ( !isenabled )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "System is disabled, skipping initialization..." );
        }
        
        function_c14e9a5df08c3209();
        return;
    }
    
    if ( !ob_activity_manager::function_81e8b9df4d6b3a72() )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "OB Activity Manager is disabled, skipping initialization..." );
        }
        
        function_c14e9a5df08c3209();
        return;
    }
    
    var_190f91517abe2986 = [ "REV_OB_POI_BOSS", "REV_OB_VTOL_BOSS", "REV_OB_SCORPIO_UNLOCK", "REV_OB_HAUNTING" ];
    var_f3c0d5f4cf0b24c3 = [ "Global" ];
    var_efc71ae0aa46761e = [ "REV_OB_HAUNTING" ];
    var_d3136da1bcd73390 = [];
    
    foreach ( var_a98d07f7a054ff29 in var_f3c0d5f4cf0b24c3 )
    {
        foreach ( var_7f1aed26656a53b0 in level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ] )
        {
            foreach ( activitytype in var_190f91517abe2986 )
            {
                foreach ( activityinstance in var_7f1aed26656a53b0[ activitytype ] )
                {
                    if ( !ob_activity_manager::function_f1d8de22c8cc2109( activityinstance, [] ) )
                    {
                        if ( function_17db6ead98f0669c() )
                        {
                            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Skipping activity instance that is disabled via dvar: Class=" + activityinstance.class + " Type=" + activityinstance.type + " Name=" + activityinstance.name );
                        }
                        
                        continue;
                    }
                    
                    if ( !isdefined( var_d3136da1bcd73390[ activitytype ] ) )
                    {
                        var_d3136da1bcd73390[ activitytype ] = { #instances:[], #type:activitytype };
                    }
                    
                    var_d3136da1bcd73390[ activitytype ].instances[ var_d3136da1bcd73390[ activitytype ].instances.size ] = activityinstance;
                    
                    if ( function_17db6ead98f0669c() )
                    {
                        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Adding possible activity instance: Class=" + activityinstance.class + " Type=" + activityinstance.type + " Name=" + activityinstance.name );
                    }
                }
            }
        }
    }
    
    foreach ( activitytype, var_f0d4b4c367212349 in var_d3136da1bcd73390 )
    {
        var_36f3a7970e60a031 = hashcat( @"hash_c1ee7c87c9366ef2", activitytype );
        var_6046fb397501fbfb = getdvarint( var_36f3a7970e60a031, 1 );
        
        if ( var_6046fb397501fbfb >= 1 )
        {
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Adding activity type entry for " + activitytype + " with weight " + var_6046fb397501fbfb );
            }
            
            var_f0d4b4c367212349.weight = var_6046fb397501fbfb;
            continue;
        }
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Removing activity type " + activitytype + ", it has invalid weight " + var_6046fb397501fbfb );
        }
        
        var_d3136da1bcd73390[ activitytype ] = undefined;
    }
    
    if ( var_d3136da1bcd73390.size == 0 )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "No valid activity types found, skipping initialization..." );
        }
        
        function_c14e9a5df08c3209();
        return;
    }
    
    if ( isdefined( level.var_a80ded1786689dd2 ) )
    {
        msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "WorldEvent Manager has already been initialized, skipping double initialization...";
        assertmsg( msg );
        logstring( msg );
        function_c14e9a5df08c3209();
        return;
    }
    
    var_3a02e1dd8a723d51 = function_d9be60cd504481c9();
    var_d283458dadfb48c6 = clamp( getdvarfloat( @"hash_4d4031a9d357d2c1", 0 ), 0, 1 );
    
    if ( var_d283458dadfb48c6 > 0 )
    {
        dieroll = randomfloatrange( 0, 1 );
        
        if ( dieroll <= var_d283458dadfb48c6 )
        {
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Had " + var_d283458dadfb48c6 * 100 + "% chance of no events, die roll failed, picking 0 events this match..." );
            }
            
            var_3a02e1dd8a723d51 = 0;
        }
    }
    
    var_f9d7841bb1ce64a1 = function_c76e755411f27173( var_d3136da1bcd73390, var_3a02e1dd8a723d51 );
    currenttimeinseconds = int( utility::function_6f5d2e1f1ff70482( gettime() ) );
    level.var_a80ded1786689dd2 = spawnstruct();
    level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1 = var_f9d7841bb1ce64a1;
    level.var_a80ded1786689dd2.var_7f2933490dcf54f1 = undefined;
    level.var_a80ded1786689dd2.var_918af3aa0a4e2b14 = 0;
    level.var_a80ded1786689dd2.var_5ec24bbc3f80d4f4 = currenttimeinseconds + getdvarint( @"hash_a632056eb6b91446", 600 );
    level.var_a80ded1786689dd2.var_f26606f9693bb1de = currenttimeinseconds + getdvarint( @"hash_dd4b579330faeef8", 1800 );
    
    if ( function_2f9f158f3bc5e040() )
    {
        utility::registersharedfunc( #"hash_473f3455c9e039dc", #"hash_48250594acbc3a15", &function_4c40230f6c41bf4 );
        utility::registersharedfunc( #"hash_473f3455c9e039dc", #"hash_463ebc02d3a3b4a4", &function_2f9f158f3bc5e040 );
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Shared Funcs Registered" );
        }
    }
    
    foreach ( activity in level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1 )
    {
        var_c0e6423baf2bd4dd = function_2f9f158f3bc5e040() && activity.type == "REV_OB_POI_BOSS";
        
        if ( arraycontains( var_efc71ae0aa46761e, activity.type ) || var_c0e6423baf2bd4dd )
        {
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Special Case Early Activity Spawning: Class=" + activity.class + " Type=" + activity.type + " Name=" + activity.name );
            }
            
            cleanupsummary = {};
            var_cab76a05327e1527 = ob_resource_manager::function_ecad2cf1cfb8379e( activity.class, activity.type, activity.name, activity.var_622af9ed9146813f.activityresources, cleanupsummary );
            
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Resource Cleanup Summary: Required Entities: " + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "entities" ] + ", Required Scriptables:" + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "scriptables" ] + ", Required Vehicles:" + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "vehicles" ] + ", Force Shutdown Activities:" + cleanupsummary.var_e43253eb66526600 + cleanupsummary.var_aea72c7f42d1b235 );
            }
            
            if ( !var_cab76a05327e1527 )
            {
                msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Failed to make space in the resource budget for world event, skipping spawn attempt: Class=" + activity.class + " Type=" + activity.type + " Name=" + activity.name;
                assertmsg( msg );
                logstring( msg );
                continue;
            }
            
            var_154d4f03c6916f4b = { #var_50c1af2c54647af8:1 };
            activityinstance = ob_activity_utility::function_fe0fd74238abb635( activity.type, activity.name, activity.class, var_154d4f03c6916f4b );
            
            if ( activityinstance )
            {
                if ( function_17db6ead98f0669c() )
                {
                    logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Successfully spawned Special Case Early world event: Type=" + activityinstance.type + " Name=" + activityinstance.varianttag );
                }
                
                if ( var_c0e6423baf2bd4dd )
                {
                    level.var_a80ded1786689dd2.var_49b84de435120dab = 1;
                    level.var_a80ded1786689dd2.var_7f2933490dcf54f1 = activityinstance;
                }
                else
                {
                    activity.var_bc4301abc024397a = activityinstance;
                }
                
                continue;
            }
            
            msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Tried and Failed to spawn world event, skipping spawn attempt: Class=" + activity.class + " Type=" + activity.type + " Name=" + activity.name;
            assertmsg( msg );
            logstring( msg );
        }
    }
    
    var_9bc71b7985619305 = function_9f4d87a30a40fd37( level.var_a80ded1786689dd2.var_5ec24bbc3f80d4f4 );
    
    if ( isdefined( var_9bc71b7985619305 ) )
    {
        function_fe4ff2f34dff707a( var_9bc71b7985619305 );
    }
    else
    {
        msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Failed to generate random spawn time for initial event, this shouldn't be possible! MinTime=" + level.var_a80ded1786689dd2.var_5ec24bbc3f80d4f4 + " MaxTime=" + level.var_a80ded1786689dd2.var_f26606f9693bb1de;
        assertmsg( msg );
        logstring( msg );
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Initialization complete, will spawn " + level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size + " world events" );
    }
    
    level thread function_9edde7a0161493b0();
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x295a234b, Offset: 0x1937
// Size: 0xbc
function private function_c14e9a5df08c3209()
{
    if ( getdvarint( @"hash_966b52e88462c2bb", 0 ) != 0 )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Scorpio is force enabled, skipping entity cleanup..." );
        }
        
        return;
    }
    
    var_9d6fda34b828cfd5 = utility::getsharedfunc( #"scorpio", #"remove_ents" );
    
    if ( isdefined( var_9d6fda34b828cfd5 ) )
    {
        [[ var_9d6fda34b828cfd5 ]]();
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Cleaned up Scorpio entities" );
        }
        
        return;
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Scorpio entity cleanup function was not defined, skipping entity cleanup" );
    }
}

// Namespace ob_worldevent_manager
// Params 2, eflags: 0x4
// Checksum 0xd5c9da38, Offset: 0x19fb
// Size: 0x2e5
function private function_c76e755411f27173( var_fed379a4b295d9c7, var_94e17ec0ed40ebbb )
{
    var_d80b0f2f4df5c773 = 0;
    var_d34b3e0c6a64a0b9 = [];
    
    if ( var_94e17ec0ed40ebbb > var_fed379a4b295d9c7.size )
    {
        if ( function_1e47d0f02219cab2() )
        {
            logstring( "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Supposed to pick " + var_94e17ec0ed40ebbb + " activities but there are only " + var_fed379a4b295d9c7.size + " options, clamping to " + var_fed379a4b295d9c7.size + " picks" );
        }
        
        var_94e17ec0ed40ebbb = var_fed379a4b295d9c7.size;
    }
    
    i = 0;
    
    while ( i < var_94e17ec0ed40ebbb )
    {
        pickedworldevent = utility::random_weighted_struct( var_fed379a4b295d9c7 );
        
        if ( !isdefined( pickedworldevent ) )
        {
            errormessage = "Failed to pick random event to trigger. This shouldn't be possible. Possible events are -";
            
            foreach ( activitytype, activityinstances in var_fed379a4b295d9c7 )
            {
                errormessage += " " + activitytype + ": weight=" + activityinstances.weight + " instances=" + activityinstances.instances.size;
            }
            
            msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + errormessage;
            assertmsg( msg );
            logstring( msg );
            break;
        }
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Picked activity type " + pickedworldevent.type + ". Removing the entry for that type so it can't be picked again in the future" );
        }
        
        var_fed379a4b295d9c7[ pickedworldevent.type ] = undefined;
        
        if ( pickedworldevent.type == "REV_OB_SCORPIO_UNLOCK" )
        {
            var_d80b0f2f4df5c773 = 1;
        }
        
        if ( pickedworldevent.instances.size == 0 )
        {
            msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Activity type " + pickedworldevent.type + " has no instances to pick from. This shouldn't be possible";
            assertmsg( msg );
            logstring( msg );
        }
        else
        {
            var_6a6b79249cb3576c = randomint( pickedworldevent.instances.size );
            var_d34b3e0c6a64a0b9[ pickedworldevent.type ] = pickedworldevent.instances[ var_6a6b79249cb3576c ];
            
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Pick specific activity instance " + var_d34b3e0c6a64a0b9[ pickedworldevent.type ].name );
            }
        }
        
        i += 1;
    }
    
    if ( !var_d80b0f2f4df5c773 )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "We did not pick the Scorpio event to spawn, triggering Scorpio-specific cleanup..." );
        }
        
        function_c14e9a5df08c3209();
    }
    
    return var_d34b3e0c6a64a0b9;
}

// Namespace ob_worldevent_manager
// Params 1, eflags: 0x4
// Checksum 0x30945d82, Offset: 0x1ce9
// Size: 0xbf
function private function_9f4d87a30a40fd37( mintimeseconds )
{
    maxtimeseconds = level.var_a80ded1786689dd2.var_f26606f9693bb1de;
    
    if ( mintimeseconds > maxtimeseconds )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Can't generate random trigger time, min time(" + mintimeseconds + ") > max time(" + maxtimeseconds + ") which means we've passed the allowed event spawning time range" );
        }
        
        return;
    }
    
    var_b33a2c46d3406e69 = randomintrange( mintimeseconds, maxtimeseconds );
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Generated random trigger time " + var_b33a2c46d3406e69 + " in range [" + mintimeseconds + ", " + maxtimeseconds + ")" );
    }
    
    return var_b33a2c46d3406e69;
}

// Namespace ob_worldevent_manager
// Params 1, eflags: 0x4
// Checksum 0xf2132991, Offset: 0x1db1
// Size: 0xb3
function private function_fe4ff2f34dff707a( timeinseconds )
{
    if ( isdefined( timeinseconds ) )
    {
        var_b72885a7bbb2cc3a = timeinseconds * 1000;
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Next world event to be triggered at " + var_b72885a7bbb2cc3a + " (" + var_b72885a7bbb2cc3a - gettime() + "ms from now)" );
        }
        
        level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 = var_b72885a7bbb2cc3a;
        return;
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Clearing trigger timer, no more events will be spawned" );
    }
    
    level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 = undefined;
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0xfd930f41, Offset: 0x1e6c
// Size: 0xbf, Type: bool
function private function_f89b2371742f6c3d()
{
    if ( isdefined( level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 ) )
    {
        if ( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size > 0 )
        {
            return true;
        }
    }
    
    if ( isdefined( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 ) )
    {
        return true;
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Update loop ending, nextTriggerTime=" + level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 + ", activitiesToSpawn.size:" + level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size + ", currentlyRunningActivity:" + level.var_a80ded1786689dd2.var_7f2933490dcf54f1 );
    }
    
    return false;
}

// Namespace ob_worldevent_manager
// Params 1, eflags: 0x4
// Checksum 0xe4a9a03d, Offset: 0x1f34
// Size: 0x14e
function private function_9edde7a0161493b0( instances )
{
    level endon( #"game_ended" );
    
    while ( function_f89b2371742f6c3d() )
    {
        var_699d53f037f3975e = getdvarint( @"hash_15212b39b23a32c8", 5 );
        wait var_699d53f037f3975e;
        
        if ( function_2f9f158f3bc5e040() && level.var_a80ded1786689dd2.var_49b84de435120dab )
        {
            activitystate = activity_instance_common::getactivitystate( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 );
            
            if ( activitystate == "Active" )
            {
                continue;
            }
        }
        else if ( isdefined( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 ) )
        {
            continue;
        }
        
        /#
            forcetrigger = getdvarint( @"hash_8f732eb3a22e3f52", 0 );
            
            if ( forcetrigger )
            {
                currenttimeinseconds = utility::function_6f5d2e1f1ff70482( gettime() );
                function_fe4ff2f34dff707a( currenttimeinseconds );
                setdvar( @"hash_8f732eb3a22e3f52", 0 );
            }
        #/
        
        if ( gettime() >= level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 )
        {
            _trigger_world_event();
        }
    }
    
    level.var_a80ded1786689dd2 = undefined;
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Nothing more for us to do, shutting down..." );
    }
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x98ecf38d, Offset: 0x208a
// Size: 0x584, Type: bool
function private _trigger_world_event()
{
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Trying to trigger world event..." );
    }
    
    while ( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size > 0 )
    {
        if ( function_2f9f158f3bc5e040() && level.var_a80ded1786689dd2.var_49b84de435120dab && level.var_a80ded1786689dd2.var_7f2933490dcf54f1 )
        {
            activity_instance_common::function_46135a69bddfec2c( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 );
            level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1[ level.var_a80ded1786689dd2.var_7f2933490dcf54f1.type ] = undefined;
            
            if ( function_17db6ead98f0669c() )
            {
                logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Special Case Early activity variant: " + level.var_a80ded1786689dd2.var_7f2933490dcf54f1.varianttag + " has been told to begin" );
            }
            
            level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1 = arrayremove( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1, level.var_a80ded1786689dd2.var_7f2933490dcf54f1 );
        }
        else
        {
            var_76025ae0314c1d10 = utility::array_random( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1 );
            
            if ( var_76025ae0314c1d10.var_bc4301abc024397a )
            {
                level.var_a80ded1786689dd2.var_7f2933490dcf54f1 = var_76025ae0314c1d10.var_bc4301abc024397a;
                activity_instance_common::function_46135a69bddfec2c( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 );
                var_76025ae0314c1d10.var_bc4301abc024397a = undefined;
            }
            else
            {
                cleanupsummary = {};
                var_cab76a05327e1527 = ob_resource_manager::function_ecad2cf1cfb8379e( var_76025ae0314c1d10.class, var_76025ae0314c1d10.type, var_76025ae0314c1d10.name, var_76025ae0314c1d10.var_622af9ed9146813f.activityresources, cleanupsummary );
                
                if ( function_17db6ead98f0669c() )
                {
                    logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Resource Cleanup Summary: Required Entities: " + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "entities" ] + ", Required Scriptables:" + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "scriptables" ] + ", Required Vehicles:" + cleanupsummary.var_107ec35884b5f30.var_ebc56c8eb6ccfb37[ "vehicles" ] + ", Force Shutdown Activities:" + cleanupsummary.var_e43253eb66526600 + cleanupsummary.var_aea72c7f42d1b235 );
                }
                
                if ( !var_cab76a05327e1527 )
                {
                    msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Failed to make space in the resource budget for world event, skipping spawn attempt: Class=" + var_76025ae0314c1d10.class + " Type=" + var_76025ae0314c1d10.type + " Name=" + var_76025ae0314c1d10.name;
                    assertmsg( msg );
                    logstring( msg );
                    continue;
                }
                
                if ( function_17db6ead98f0669c() )
                {
                    logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "World Event activity Type: " + var_76025ae0314c1d10.type + " Name: " + var_76025ae0314c1d10.name + " now Spawning" );
                }
                
                level.var_a80ded1786689dd2.var_7f2933490dcf54f1 = ob_activity_utility::function_fe0fd74238abb635( var_76025ae0314c1d10.type, var_76025ae0314c1d10.name, var_76025ae0314c1d10.class );
            }
            
            level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1 = arrayremove( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1, var_76025ae0314c1d10 );
        }
        
        if ( !isdefined( level.var_a80ded1786689dd2.var_7f2933490dcf54f1 ) )
        {
            if ( var_76025ae0314c1d10 )
            {
                msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Failed to spawn world event: Class=" + var_76025ae0314c1d10.class + " Type=" + var_76025ae0314c1d10.type + " Name=" + var_76025ae0314c1d10.name;
                assertmsg( msg );
                logstring( msg );
            }
            else
            {
                msg = "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Failure - WEM has no current running activity instance when it should have already spawned the POI Boss";
                assertmsg( msg );
                logstring( msg );
            }
            
            continue;
        }
        
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Successfully spawned world event: Type=" + level.var_a80ded1786689dd2.var_7f2933490dcf54f1.type + " Name=" + level.var_a80ded1786689dd2.var_7f2933490dcf54f1.varianttag );
        }
        
        if ( level.var_a80ded1786689dd2.var_918af3aa0a4e2b14 == 0 )
        {
            activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_fcc58003b239b84e );
        }
        
        level.var_a80ded1786689dd2.var_918af3aa0a4e2b14 += 1;
        level.var_a80ded1786689dd2.var_a6eb84cd04c5b7d8 = undefined;
        return true;
    }
    
    if ( function_1e47d0f02219cab2() )
    {
        logstring( "[OB_WEM] ERROR: " + function_91b983adeae795fc() + " - " + "Unable to trigger an event, none were available or all attempts failed" );
    }
    
    return false;
}

// Namespace ob_worldevent_manager
// Params 1, eflags: 0x4
// Checksum 0x8213d986, Offset: 0x2617
// Size: 0x1ad
function private function_fcc58003b239b84e( relevantinfostruct )
{
    activityinstance = self;
    
    if ( activityinstance != level.var_a80ded1786689dd2.var_7f2933490dcf54f1 )
    {
        return;
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "Current world event has ended: Class=" + activityinstance.category + " Type=" + activityinstance.type + " Name=" + activityinstance.varianttag );
    }
    
    level.var_a80ded1786689dd2.var_7f2933490dcf54f1 = undefined;
    
    if ( level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size == 0 )
    {
        if ( function_17db6ead98f0669c() )
        {
            logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "We've spawned all " + level.var_a80ded1786689dd2.var_918af3aa0a4e2b14 + " world events we needed to, all done!" );
        }
        
        return;
    }
    
    if ( function_17db6ead98f0669c() )
    {
        logstring( "[OB_WEM] " + function_91b983adeae795fc() + " - " + "We've spawned " + level.var_a80ded1786689dd2.var_918af3aa0a4e2b14 + " world events, " + level.var_a80ded1786689dd2.var_f9d7841bb1ce64a1.size + " more to go. Setting up the timer for the next one..." );
    }
    
    var_346ee0d32c9c8b17 = getdvarint( @"hash_20d436bb3d064d8c", 120 );
    currenttimeinseconds = int( utility::function_6f5d2e1f1ff70482( gettime() ) );
    var_a679fc580a477839 = currenttimeinseconds + var_346ee0d32c9c8b17;
    var_9bc71b7985619305 = function_9f4d87a30a40fd37( var_a679fc580a477839 );
    function_fe4ff2f34dff707a( var_9bc71b7985619305 );
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0xc5e5de1f, Offset: 0x27cc
// Size: 0x11
function private function_50f0671f7ff09179()
{
    return getdvarint( @"hash_24751641c5a6c025", 1 );
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x3be6aaa8, Offset: 0x27e6
// Size: 0xb, Type: bool
function private function_17db6ead98f0669c()
{
    return function_50f0671f7ff09179() >= 2;
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x1e05956, Offset: 0x27fa
// Size: 0xb, Type: bool
function private function_1e47d0f02219cab2()
{
    return function_50f0671f7ff09179() >= 1;
}

// Namespace ob_worldevent_manager
// Params 0, eflags: 0x4
// Checksum 0x26b710de, Offset: 0x280e
// Size: 0x11
function private function_d9be60cd504481c9()
{
    return getdvarint( @"hash_4c10a6a080adc2a5", 1 );
}

// Namespace ob_worldevent_manager
// Params 1
// Checksum 0x18e8fb20, Offset: 0x2828
// Size: 0x214, Type: bool
function function_4c40230f6c41bf4( activitycenter )
{
    if ( function_2f9f158f3bc5e040() && level.var_a80ded1786689dd2.var_49b84de435120dab )
    {
        event = level.var_a80ded1786689dd2.var_7f2933490dcf54f1;
        
        if ( event.type == "REV_OB_POI_BOSS" )
        {
            if ( !level.var_a80ded1786689dd2.poiorigin )
            {
                center = utility::getstruct( event.varianttag, "script_noteworthy" );
                bossstructs = utility::getstructarray( center.target, "targetname" );
                
                foreach ( struct in bossstructs )
                {
                    if ( struct.script_noteworthy == "s_boss_tether_data" )
                    {
                        if ( !isdefined( level.var_a80ded1786689dd2.poiorigin ) )
                        {
                            level.var_a80ded1786689dd2.poiorigin = struct.origin;
                        }
                        
                        if ( !isdefined( level.var_a80ded1786689dd2.poiradius ) )
                        {
                            level.var_a80ded1786689dd2.poiradius = struct.radius;
                        }
                        
                        break;
                    }
                }
            }
            
            if ( level.var_a80ded1786689dd2.poiorigin && level.var_a80ded1786689dd2.poiradius && distance2dsquared( activitycenter, level.var_a80ded1786689dd2.poiorigin ) < level.var_a80ded1786689dd2.poiradius * level.var_a80ded1786689dd2.poiradius )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_worldevent_manager
// Params 0
// Checksum 0x66f2bded, Offset: 0x2a45
// Size: 0x10
function function_2f9f158f3bc5e040()
{
    return getdvarint( @"hash_aa49f83186d5be08", 0 );
}

