// scripts\mp\gametypes\skirmish_objective_director.gsc  (hash_0463bd284119a8f5.gscc) (size: 14935 Bytes / 0x3a57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33527d7e (861044094)
// size ...... 14935 (0x3a57)
// includes .. 4   (offset: 0x3667)
// strings ... 51  (offset: 0x3687)
// dev strs .. 22  (offset: 0x394b)
// exports ... 32  (offset: 0x2ab3)
// cseg ...... 0x5b7 + 0x24fc (0x2ab3)
// imports ... 51  (offset: 0x2fb3)
// animtree1 . 0   (offset: 0x3a57)
// animtree2 . 0   (offset: 0x3a57)
#using script_33cd8a7250381109;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\gametypes\skirmish_activity_manager;

#namespace skirmish_objective_director;

// Namespace skirmish_objective_director
// Params 0
// Checksum 0xacc82592, Offset: 0x5d5
// Size: 0x33
function init()
{
    if ( level.var_b5887d2493fadea5 )
    {
        return;
    }
    
    level.var_b5887d2493fadea5 = spawnstruct();
    function_4c996ce225c8d2c5();
    level thread phasetimer();
    level thread mainloop();
}

// Namespace skirmish_objective_director
// Params 1
// Checksum 0xdd1aff05, Offset: 0x610
// Size: 0x127
function function_2114675f9ffa581c( skrzone )
{
    config = level.var_b5887d2493fadea5.config;
    state = level.var_b5887d2493fadea5.state;
    regionname = config.var_ba4384943f39b4c5[ skrzone ];
    
    if ( !isdefined( regionname ) )
    {
        return;
    }
    
    state.var_cc14bec5b48b3733--;
    state.var_cc14bec5b48b3733 = max( 0, state.var_cc14bec5b48b3733 );
    state.var_d05ae32d0c9bd66++;
    state.regionstate[ regionname ].var_5b110820daa2b673++;
    logstring( "[SKIRMISH_OD] Objective activated on " + skrzone + " (Active: " + state.var_d05ae32d0c9bd66 + ", Pending: " + state.var_cc14bec5b48b3733 + ", Total: " + state.var_d05ae32d0c9bd66 + state.var_cc14bec5b48b3733 + ")" );
    state.regionstate[ regionname ].lastspawntime = gettime();
}

// Namespace skirmish_objective_director
// Params 2
// Checksum 0x93f45c17, Offset: 0x73f
// Size: 0x173
function function_57c69d94c84eb0cb( skrzone, ishvs = 0 )
{
    config = level.var_b5887d2493fadea5.config;
    state = level.var_b5887d2493fadea5.state;
    regionname = config.var_ba4384943f39b4c5[ skrzone ];
    
    if ( !isdefined( regionname ) )
    {
        return;
    }
    
    state.var_d05ae32d0c9bd66--;
    state.regionstate[ regionname ].var_5b110820daa2b673--;
    logstring( "[SKIRMISH_OD] Objective completed on " + skrzone + " (Active: " + state.var_d05ae32d0c9bd66 + ", Pending: " + state.var_cc14bec5b48b3733 + ", Total: " + state.var_d05ae32d0c9bd66 + state.var_cc14bec5b48b3733 + ")" );
    state.var_d05ae32d0c9bd66 = max( 0, state.var_d05ae32d0c9bd66 );
    state.regionstate[ regionname ].var_5b110820daa2b673 = max( 0, state.regionstate[ regionname ].var_5b110820daa2b673 );
    
    if ( ishvs )
    {
        state.var_f40e740af6304ede[ skrzone ] = gettime();
        return;
    }
    
    state.var_2fba060b22874665[ skrzone ] = gettime();
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0xbb623b4d, Offset: 0x8ba
// Size: 0xea
function private function_4c996ce225c8d2c5()
{
    level.var_b5887d2493fadea5.config = spawnstruct();
    level.var_b5887d2493fadea5.mapsettings = game_utility_mp::function_cb7ed8e67866f9d0( "skirmishmapsettings" );
    level.var_b5887d2493fadea5.var_a373032416a5028c = [ #"destroy" ];
    
    if ( level.var_85b177faa9935b2a.var_61c006b49d4bc07d )
    {
        if ( !isdefined( level.var_b5887d2493fadea5.var_a373032416a5028c ) )
        {
            level.var_b5887d2493fadea5.var_a373032416a5028c = [];
        }
        
        level.var_b5887d2493fadea5.var_a373032416a5028c[ level.var_b5887d2493fadea5.var_a373032416a5028c.size ] = #"secure";
    }
    
    loadregions();
    function_9d7c80a52b294c38();
    function_dc3b993ef45055b7();
    function_47eb6de101594fe9();
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x20dc1aec, Offset: 0x9ac
// Size: 0x1c3
function private loadregions()
{
    mapsettings = level.var_b5887d2493fadea5.mapsettings;
    config = level.var_b5887d2493fadea5.config;
    
    foreach ( regiondef in mapsettings.regiondefinitions )
    {
        var_8b938e4e3dca3201 = regiondef.var_8b938e4e3dca3201 ? strtok( regiondef.var_8b938e4e3dca3201, "," ) : [];
        region = { #iscenter:regiondef.iscenter ?? 0, #zones:var_8b938e4e3dca3201, #regionname:regiondef.regionname ?? "" };
        config.regions[ region.regionname ] = region;
        
        foreach ( zone in var_8b938e4e3dca3201 )
        {
            config.var_ba4384943f39b4c5[ zone ] = region.regionname;
        }
    }
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x416c1c64, Offset: 0xb77
// Size: 0x178
function private function_9d7c80a52b294c38()
{
    mapsettings = level.var_b5887d2493fadea5.mapsettings;
    phasecaps = [];
    
    foreach ( phase in mapsettings.var_d753732bc4681dd3 )
    {
        regioncaps = [];
        regioncaps[ "axis" ] = phase.var_22acea759eb4f865 ?? 0;
        regioncaps[ "centerAxis" ] = phase.var_c101138add41cccc ?? 0;
        regioncaps[ "centerAllies" ] = phase.var_5d4fd641ccce6fa7 ?? 0;
        regioncaps[ "allies" ] = phase.var_dee58576a034ceb2 ?? 0;
        phasestruct = { #regioncaps:regioncaps, #targetcount:phase.targetobjectives ?? 0, #lengthseconds:phase.phaselength ?? 0 };
        
        if ( !isdefined( phasecaps ) )
        {
            phasecaps = [];
        }
        
        phasecaps[ phasecaps.size ] = phasestruct;
    }
    
    level.var_b5887d2493fadea5.config.phasecaps = phasecaps;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x56e46b15, Offset: 0xcf7
// Size: 0x160
function private function_dc3b993ef45055b7()
{
    mapsettings = level.var_b5887d2493fadea5.mapsettings;
    var_db1851ed00a2f79f = [];
    
    foreach ( tier in mapsettings.var_7e8b062a58e5615e )
    {
        weights = [];
        weights[ "axis" ] = tier.var_e37e9bc7e1054874 ?? 0;
        weights[ "centerAxis" ] = tier.var_32acf7a2df79c16 ?? 0;
        weights[ "centerAllies" ] = tier.var_6236ca3bf2424065 ?? 0;
        weights[ "allies" ] = tier.var_1bc0130bf015b9b3 ?? 0;
        tierstruct = { #weights:weights, #scorediff:tier.scorediff ?? 0 };
        
        if ( !isdefined( var_db1851ed00a2f79f ) )
        {
            var_db1851ed00a2f79f = [];
        }
        
        var_db1851ed00a2f79f[ var_db1851ed00a2f79f.size ] = tierstruct;
    }
    
    level.var_b5887d2493fadea5.config.var_db1851ed00a2f79f = var_db1851ed00a2f79f;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x9d5d207d, Offset: 0xe5f
// Size: 0x220
function private function_47eb6de101594fe9()
{
    state = { #regionstate:[], #var_cc14bec5b48b3733:0, #var_d05ae32d0c9bd66:0, #var_51c5b52b49a5aa71:0, #var_c14f99f22705edf6:0 };
    config = level.var_b5887d2493fadea5.config;
    
    foreach ( regionname, region in config.regions )
    {
        state.regionstate[ regionname ] = { #lastspawntime:0, #var_5b110820daa2b673:0 };
    }
    
    state.var_2fba060b22874665 = [];
    state.var_f40e740af6304ede = [];
    inittime = gettime();
    
    foreach ( regionname, region in config.regions )
    {
        foreach ( zonename in region.zones )
        {
            state.var_2fba060b22874665[ zonename ] = inittime;
            state.var_f40e740af6304ede[ zonename ] = inittime;
        }
    }
    
    level.var_b5887d2493fadea5.state = state;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x1c96750f, Offset: 0x1087
// Size: 0xc8
function private phasetimer()
{
    while ( !skirmish_activity_manager::function_4401e8c9415a6961() )
    {
        waitframe();
    }
    
    config = level.var_b5887d2493fadea5.config;
    state = level.var_b5887d2493fadea5.state;
    
    for ( i = 0; i < config.phasecaps.size - 1 ; i++ )
    {
        phase = config.phasecaps[ i ];
        
        if ( phase.lengthseconds > 0 )
        {
            wait phase.lengthseconds;
        }
        
        state.var_c14f99f22705edf6++;
        logstring( "[SKIRMISH_OD] PhaseTimer: Advanced to phase " + state.var_c14f99f22705edf6 );
    }
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x2491a31d, Offset: 0x1157
// Size: 0x6f
function private mainloop()
{
    level endon( #"game_ended" );
    
    if ( level.var_b5887d2493fadea5.debugmode )
    {
        logstring( "[SKIRMISH_OD] Main loop disabled - debug mode active" );
        return;
    }
    
    if ( level.var_85b177faa9935b2a.startdelay )
    {
        wait level.var_85b177faa9935b2a.startdelay;
    }
    
    while ( true )
    {
        waitframe();
        function_e5c605c023cbaa4a();
        wait 0.5;
    }
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0xa4bdb7d9, Offset: 0x11ce
// Size: 0xf6
function private function_e5c605c023cbaa4a()
{
    if ( !function_863e7606b98fa736() )
    {
        return;
    }
    
    state = level.var_b5887d2493fadea5.state;
    state.var_cc14bec5b48b3733++;
    logstring( "[SKIRMISH_OD] Initiating spawn (Active: " + state.var_d05ae32d0c9bd66 + ", Pending: " + state.var_cc14bec5b48b3733 + ", Total: " + state.var_d05ae32d0c9bd66 + state.var_cc14bec5b48b3733 + ")" );
    success = function_6a4e57a8eeddc86();
    
    if ( !success )
    {
        state.var_cc14bec5b48b3733--;
        state.var_cc14bec5b48b3733 = max( 0, state.var_cc14bec5b48b3733 );
        logstring( "[SKIRMISH_OD] Spawn failed, decremented pending " + "(Active: " + state.var_d05ae32d0c9bd66 + ", Pending: " + state.var_cc14bec5b48b3733 + ")" );
    }
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x76eb3468, Offset: 0x12cc
// Size: 0x13a
function private function_6a4e57a8eeddc86()
{
    ishvs = function_c38614df15f4fdd();
    
    if ( ishvs )
    {
        regionname = ishvs.regionname;
        zone = ishvs.zonename;
    }
    else
    {
        regionname = selectregion();
        
        if ( !isdefined( regionname ) )
        {
            return;
        }
        
        zone = selectzone( regionname, ishvs );
        
        if ( !zone )
        {
            fallbackregions = function_de30e6aa8921b7f4( regionname );
            
            if ( !fallbackregions.size )
            {
                return;
            }
            
            fallbackregion = selectregion( fallbackregions );
            
            if ( !isdefined( fallbackregion ) )
            {
                return;
            }
            
            zone = selectzone( fallbackregion, ishvs );
            
            if ( zone )
            {
                logstring( "[SKIRMISH_OD] Fallback: Selected region '" + fallbackregion + "' after '" + regionname + "' had no valid zones" );
                regionname = fallbackregion;
            }
        }
    }
    
    if ( !isdefined( zone ) )
    {
        return;
    }
    
    activitytype = function_72bddd6782c13013( zone, ishvs );
    
    if ( !isdefined( activitytype ) )
    {
        return;
    }
    
    activitystruct = function_380436aa1444d97b( zone, activitytype );
    
    if ( !isdefined( activitystruct ) )
    {
        return;
    }
    
    activitystruct.ishvs = ishvs;
    activitystruct.activityparams.var_51f5a92414c2f4f8 = ishvs;
    skirmish_activity_manager::function_387d8b4109af4dc9( activitystruct );
    return 1;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0xafd94e80, Offset: 0x140f
// Size: 0xc7
function private function_a493b34c312d039f()
{
    config = level.var_b5887d2493fadea5.config;
    regions = config.regions;
    centerregions = [];
    
    foreach ( regionname, region in regions )
    {
        if ( region.iscenter )
        {
            if ( !isdefined( centerregions ) )
            {
                centerregions = [];
            }
            
            centerregions[ centerregions.size ] = regionname;
        }
    }
    
    return centerregions;
}

// Namespace skirmish_objective_director
// Params 1, eflags: 0x4
// Checksum 0x7134eb54, Offset: 0x14df
// Size: 0xce
function private function_de30e6aa8921b7f4( var_f64026fa6ad11ae3 )
{
    config = level.var_b5887d2493fadea5.config;
    allregions = getarraykeys( config.regions );
    filteredregions = [];
    
    foreach ( regionname in allregions )
    {
        if ( regionname != var_f64026fa6ad11ae3 )
        {
            if ( !isdefined( filteredregions ) )
            {
                filteredregions = [];
            }
            
            filteredregions[ filteredregions.size ] = regionname;
        }
    }
    
    return filteredregions;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x19957216, Offset: 0x15b6
// Size: 0x14e
function private function_c38614df15f4fdd()
{
    if ( !namespace_ccc9a50b2d185e5::function_89260e62e38ccc70() )
    {
        return;
    }
    
    centerregions = function_a493b34c312d039f();
    
    if ( !centerregions.size )
    {
        return;
    }
    
    regionname = selectregion( centerregions );
    
    if ( !isdefined( regionname ) )
    {
        return;
    }
    
    zonename = selectzone( regionname, 1 );
    
    if ( zonename )
    {
        logstring( "[SKIRMISH_OD] HVS: Selected center region '" + regionname + "', zone '" + zonename + "'" );
        return { #zonename:zonename, #regionname:regionname };
    }
    
    foreach ( fallbackregion in centerregions )
    {
        if ( fallbackregion == regionname )
        {
            continue;
        }
        
        zonename = selectzone( fallbackregion, 1 );
        
        if ( zonename )
        {
            logstring( "[SKIRMISH_OD] HVS: Fallback to center region '" + fallbackregion + "', zone '" + zonename + "'" );
            return { #zonename:zonename, #regionname:fallbackregion };
        }
    }
    
    logstring( "[SKIRMISH_OD] HVS: No valid HVS zones in center regions, falling back to normal spawn" );
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0xb2735464, Offset: 0x170d
// Size: 0xb7, Type: bool
function private function_863e7606b98fa736()
{
    if ( !skirmish_activity_manager::function_4401e8c9415a6961() )
    {
        return false;
    }
    
    state = level.var_b5887d2493fadea5.state;
    config = level.var_b5887d2493fadea5.config;
    currentphase = config.phasecaps[ state.var_c14f99f22705edf6 ];
    
    if ( currentphase.targetcount == 0 )
    {
        logstring( "[SKIRMISH_OD] canSpawn: Blocked - Phase " + state.var_c14f99f22705edf6 + " has targetCount = 0" );
        return false;
    }
    
    if ( state.var_d05ae32d0c9bd66 >= currentphase.targetcount )
    {
        return false;
    }
    
    return true;
}

// Namespace skirmish_objective_director
// Params 1, eflags: 0x4
// Checksum 0x40c64a61, Offset: 0x17cd
// Size: 0x78
function private selectregion( allowedregions )
{
    scorediff = getscorediff();
    chosentier = function_3677608236533c32( scorediff );
    
    if ( !isdefined( chosentier ) )
    {
        return;
    }
    
    regioncaps = function_ce8e276222079023();
    
    if ( !isdefined( regioncaps ) )
    {
        return;
    }
    
    weightedregions = function_6dba5e94a2c20c1b( allowedregions, chosentier, regioncaps );
    selectedregion = function_89d3b13cb3456edd( weightedregions );
    return selectedregion;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0xc928d1db, Offset: 0x184e
// Size: 0x2e
function private getscorediff()
{
    scoreallies = getteamscore( "allies" );
    scoreaxis = getteamscore( "axis" );
    return scoreallies - scoreaxis;
}

// Namespace skirmish_objective_director
// Params 1, eflags: 0x4
// Checksum 0x7612d11e, Offset: 0x1885
// Size: 0x1b0
function private function_3677608236533c32( scorediff )
{
    var_db1851ed00a2f79f = level.var_b5887d2493fadea5.config.var_db1851ed00a2f79f;
    
    if ( !var_db1851ed00a2f79f.size )
    {
        logstring( "[SKIRMISH_OD] Error: No weight tiers defined!" );
        return;
    }
    
    var_99993af8ac8925a7 = scorediff >= 0 ? -1 : 1;
    
    foreach ( tier in var_db1851ed00a2f79f )
    {
        tiervalue = tier.scorediff;
        
        if ( scorediff >= 0 && tiervalue >= 0 || scorediff < 0 && tiervalue <= 0 )
        {
            if ( scorediff >= 0 )
            {
                if ( tiervalue <= scorediff && tiervalue > var_99993af8ac8925a7 )
                {
                    chosentier = tier;
                    var_99993af8ac8925a7 = tiervalue;
                }
                
                continue;
            }
            
            if ( tiervalue >= scorediff && tiervalue < var_99993af8ac8925a7 )
            {
                chosentier = tier;
                var_99993af8ac8925a7 = tiervalue;
            }
        }
    }
    
    if ( !chosentier )
    {
        logstring( "[SKIRMISH_OD] Error: No matching tier for scoreDiff = " + scorediff );
        return;
    }
    
    scoreallies = getteamscore( "allies" );
    scoreaxis = getteamscore( "axis" );
    
    /#
        logstring( "<dev string:x24>" + chosentier.scorediff + "<dev string:x48>" + scorediff + "<dev string:x56>" + scoreallies + "<dev string:x61>" + scoreaxis + "<dev string:x6a>" );
    #/
    
    return chosentier;
}

// Namespace skirmish_objective_director
// Params 0, eflags: 0x4
// Checksum 0x3f72472, Offset: 0x1a3e
// Size: 0x91
function private function_ce8e276222079023()
{
    phaseidx = level.var_b5887d2493fadea5.state.var_c14f99f22705edf6;
    phasecaps = level.var_b5887d2493fadea5.config.phasecaps;
    
    if ( phaseidx >= phasecaps.size )
    {
        logstring( "[SKIRMISH_OD] Error: phaseIdx " + phaseidx + " out of bounds (size " + phasecaps.size + ")" );
        return;
    }
    
    phase = phasecaps[ phaseidx ];
    return phase.regioncaps;
}

// Namespace skirmish_objective_director
// Params 3, eflags: 0x4
// Checksum 0x6d66446, Offset: 0x1ad8
// Size: 0x23f
function private function_6dba5e94a2c20c1b( allowedregions, chosentier, regioncaps )
{
    regions = level.var_b5887d2493fadea5.config.regions;
    
    if ( !allowedregions )
    {
        allowedregions = getarraykeys( regions );
    }
    
    regionstate = level.var_b5887d2493fadea5.state.regionstate;
    weightedregions = [];
    totalweight = 0;
    
    foreach ( regionname in allowedregions )
    {
        region = regions[ regionname ];
        
        if ( !region )
        {
            continue;
        }
        
        weight = chosentier.weights[ regionname ] ?? 0;
        cap = regioncaps[ regionname ] ?? 0;
        active = regionstate[ regionname ].var_5b110820daa2b673 ?? 0;
        
        if ( active >= cap )
        {
            weight = 0;
        }
        
        if ( weight > 0 )
        {
            var_7c392294d47cd3d7 = 0;
            
            foreach ( zonename in region.zones )
            {
                zonestruct = level.var_85b177faa9935b2a.skrzone[ zonename ];
                
                if ( !zonestruct )
                {
                    continue;
                }
                
                if ( skirmish_activity_manager::function_9c74a5326de344db( zonestruct ) )
                {
                    var_7c392294d47cd3d7 = 1;
                    break;
                }
            }
            
            if ( !var_7c392294d47cd3d7 )
            {
                weight = 0;
            }
        }
        
        if ( weight > 0 )
        {
            weightedregions[ regionname ] = weight;
            totalweight += weight;
        }
    }
    
    return weightedregions;
}

// Namespace skirmish_objective_director
// Params 1, eflags: 0x4
// Checksum 0xe7146aef, Offset: 0x1d20
// Size: 0x11a
function private function_89d3b13cb3456edd( weightedregions )
{
    totalweight = 0;
    
    foreach ( regionname, weight in weightedregions )
    {
        totalweight += weight;
    }
    
    if ( totalweight == 0 )
    {
        logstring( "[SKIRMISH_OD] No eligible regions (all weights = 0)" );
        return;
    }
    
    pick = randomint( totalweight );
    accum = 0;
    
    foreach ( regionname, weight in weightedregions )
    {
        accum += weight;
        
        if ( pick < accum )
        {
            return regionname;
        }
    }
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0x6707f2e8, Offset: 0x1e43
// Size: 0xc4
function private selectzone( regionname, ishvs )
{
    config = level.var_b5887d2493fadea5.config;
    region = config.regions[ regionname ];
    
    if ( !isdefined( region ) )
    {
        return;
    }
    
    if ( !region.zones.size )
    {
        logstring( "[SKIRMISH_OD] Error: Region '" + regionname + "' has no zones defined" );
        return;
    }
    
    availablezones = function_5d40215d89ef8ef7( region, regionname );
    
    if ( !isdefined( availablezones ) )
    {
        return;
    }
    
    var_7d1c9722d44e02c3 = function_708bffacfc5ba54d( availablezones, regionname, ishvs );
    
    if ( !isdefined( var_7d1c9722d44e02c3 ) )
    {
        return;
    }
    
    selectedzone = function_92c82ba6d5811f7a( var_7d1c9722d44e02c3, ishvs );
    return selectedzone;
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0xe3d00020, Offset: 0x1f10
// Size: 0x105
function private function_5d40215d89ef8ef7( region, regionname )
{
    availablezones = [];
    
    foreach ( zonename in region.zones )
    {
        zonestruct = level.var_85b177faa9935b2a.skrzone[ zonename ];
        
        if ( !zonestruct )
        {
            continue;
        }
        
        if ( skirmish_activity_manager::function_9c74a5326de344db( zonestruct ) )
        {
            if ( !isdefined( availablezones ) )
            {
                availablezones = [];
            }
            
            availablezones[ availablezones.size ] = zonename;
        }
    }
    
    if ( !availablezones.size )
    {
        logstring( "[SKIRMISH_OD] Region '" + regionname + "': All " + region.zones.size + " zones on cooldown or active" );
        return;
    }
    
    return availablezones;
}

// Namespace skirmish_objective_director
// Params 3, eflags: 0x4
// Checksum 0x700b8b87, Offset: 0x201e
// Size: 0x18e
function private function_708bffacfc5ba54d( availablezones, regionname, ishvs )
{
    activezones = level.var_85b177faa9935b2a.var_6e5a676bf1a0208f;
    var_7d1c9722d44e02c3 = [];
    var_b76ecbf8181e68f8 = availablezones.size;
    
    /#
        function_51b2408ec54d0831( activezones, availablezones.size, regionname );
    #/
    
    foreach ( zonename in availablezones )
    {
        zonestruct = level.var_85b177faa9935b2a.skrzone[ zonename ];
        
        if ( !zonestruct || !zonestruct.location )
        {
            continue;
        }
        
        if ( ishvs && !function_f511afb183352273( zonestruct ) )
        {
            /#
                logstring( "<dev string:x6c>" + zonename + "<dev string:x81>" );
            #/
            
            continue;
        }
        
        if ( function_1812fc68b72215f8( zonestruct, activezones ) )
        {
            if ( !isdefined( var_7d1c9722d44e02c3 ) )
            {
                var_7d1c9722d44e02c3 = [];
            }
            
            var_7d1c9722d44e02c3[ var_7d1c9722d44e02c3.size ] = zonename;
            
            /#
                logstring( "<dev string:x6c>" + zonename + "<dev string:xa2>" );
            #/
        }
    }
    
    if ( !var_7d1c9722d44e02c3.size )
    {
        if ( var_b76ecbf8181e68f8 > 0 )
        {
            logstring( "[SKIRMISH_OD] Region '" + regionname + "': All " + var_b76ecbf8181e68f8 + " available zones too close to active objectives" );
        }
        
        return;
    }
    
    return var_7d1c9722d44e02c3;
}

// Namespace skirmish_objective_director
// Params 1, eflags: 0x4
// Checksum 0x50b29267, Offset: 0x21b5
// Size: 0x71, Type: bool
function private function_f511afb183352273( zonestruct )
{
    hasdestroy = zonestruct.activities[ #"destroy" ].size > 0;
    hassecure = level.var_85b177faa9935b2a.var_61c006b49d4bc07d && zonestruct.activities[ #"secure" ].size > 0;
    return hasdestroy || hassecure;
}

// Namespace skirmish_objective_director
// Params 3, eflags: 0x4
// Checksum 0x71edd8f6, Offset: 0x222f
// Size: 0xec
function private function_51b2408ec54d0831( activezones, var_b7c3e05998ceb2df, regionname )
{
    var_622ed0d9d4699e76 = "";
    
    foreach ( activezone in activezones )
    {
        if ( activezone.zonename )
        {
            var_622ed0d9d4699e76 += activezone.zonename + " ";
        }
    }
    
    /#
        logstring( "<dev string:xba>" + regionname + "<dev string:xd4>" + var_b7c3e05998ceb2df + "<dev string:xe1>" + activezones.size + "<dev string:xf1>" + var_622ed0d9d4699e76 + "<dev string:x101>" );
    #/
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0x27609b8d, Offset: 0x2323
// Size: 0x30e
function private function_92c82ba6d5811f7a( var_7d1c9722d44e02c3, ishvs )
{
    if ( var_7d1c9722d44e02c3.size <= 0 )
    {
        return;
    }
    
    if ( var_7d1c9722d44e02c3.size == 1 )
    {
        return var_7d1c9722d44e02c3[ 0 ];
    }
    
    state = level.var_b5887d2493fadea5.state;
    now = gettime();
    weights = [];
    totalweight = 0;
    var_b9164179cc19a5b9 = ishvs ? state.var_f40e740af6304ede : state.var_2fba060b22874665;
    
    foreach ( zonename in var_7d1c9722d44e02c3 )
    {
        last = var_b9164179cc19a5b9[ zonename ];
        var_be363ee24b7a4842 = ( now - last ) / 1000;
        weight = 1 + var_be363ee24b7a4842 / 60;
        weights[ zonename ] = weight;
        totalweight += weight;
    }
    
    /#
        weightslog = "<dev string:x103>";
        
        foreach ( zonename, weight in weights )
        {
            var_be363ee24b7a4842 = ( now - var_b9164179cc19a5b9[ zonename ] ) / 1000;
            weightslog += zonename + "<dev string:x104>" + int( var_be363ee24b7a4842 ) + "<dev string:x106>" + int( weight * 100 ) / 100 + "<dev string:x109>";
        }
        
        logstring( "<dev string:x10c>" + ( ishvs ? "<dev string:x11b>" : "<dev string:x11f>" ) + "<dev string:x123>" + weightslog + "<dev string:x133>" + int( totalweight * 100 ) / 100 );
    #/
    
    roll = randomfloat( totalweight );
    accum = 0;
    
    foreach ( zonename, weight in weights )
    {
        accum += weight;
        
        if ( roll <= accum )
        {
            selectedzone = zonename;
            break;
        }
    }
    
    if ( selectedzone )
    {
        probability = int( weights[ selectedzone ] / totalweight * 10000 ) / 100;
        logstring( "[SKIRMISH_OD] " + ( ishvs ? "HVS" : "Dom" ) + " Selected: '" + selectedzone + "' (roll=" + int( roll * 100 ) / 100 + ", probability=" + probability + "%)" );
    }
    
    return selectedzone;
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0xb8f4b657, Offset: 0x263a
// Size: 0x1c8
function private function_72bddd6782c13013( zone, ishvs )
{
    if ( !ishvs )
    {
        return #"dom";
    }
    
    zonestruct = level.var_85b177faa9935b2a.skrzone[ zone ];
    
    if ( !isdefined( zonestruct ) )
    {
        return;
    }
    
    hvstypes = level.var_b5887d2493fadea5.var_a373032416a5028c;
    supportedtypes = [];
    
    foreach ( hvstype in hvstypes )
    {
        if ( zonestruct.activities[ hvstype ].size > 0 )
        {
            if ( !isdefined( supportedtypes ) )
            {
                supportedtypes = [];
            }
            
            supportedtypes[ supportedtypes.size ] = hvstype;
        }
    }
    
    if ( !supportedtypes.size )
    {
        logstring( "[SKIRMISH_OD] Zone '" + zone + "': No HVS activity types available" );
        return;
    }
    
    if ( supportedtypes.size == 1 )
    {
        return supportedtypes[ 0 ];
    }
    
    lasttype = level.var_85b177faa9935b2a.var_5dedeaf91756ad1c;
    
    if ( !lasttype )
    {
        return supportedtypes[ randomint( supportedtypes.size ) ];
    }
    
    foreach ( hvstype in supportedtypes )
    {
        if ( hvstype != lasttype )
        {
            return hvstype;
        }
    }
    
    return supportedtypes[ randomint( supportedtypes.size ) ];
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0x36c283bc, Offset: 0x280b
// Size: 0x166
function private function_380436aa1444d97b( zone, activitytype )
{
    zonestruct = level.var_85b177faa9935b2a.skrzone[ zone ];
    
    if ( !isdefined( zonestruct ) )
    {
        return;
    }
    
    activities = zonestruct.activities[ activitytype ];
    
    if ( !activities.size )
    {
        return;
    }
    
    validactivities = [];
    
    foreach ( activity in activities )
    {
        var_c67b0d1efae62556 = utility::function_4b74c15943231980( activity.cooldowntime );
        
        if ( activity.lastendtime )
        {
            elapsedtime = gettime() - activity.lastendtime;
            
            if ( elapsedtime <= var_c67b0d1efae62556 )
            {
                continue;
            }
        }
        
        if ( !isdefined( validactivities ) )
        {
            validactivities = [];
        }
        
        validactivities[ validactivities.size ] = activity;
    }
    
    if ( !validactivities.size )
    {
        logstring( "[SKIRMISH_OD] Zone '" + zone + "': All activities of type '" + activitytype + "' on cooldown" );
        return;
    }
    
    selectedactivity = validactivities[ randomint( validactivities.size ) ];
    return selectedactivity;
}

// Namespace skirmish_objective_director
// Params 2, eflags: 0x4
// Checksum 0xe1482fc0, Offset: 0x297a
// Size: 0x138
function private function_1812fc68b72215f8( zonestruct, activezones )
{
    if ( !isdefined( zonestruct ) )
    {
        return;
    }
    
    if ( !isdefined( zonestruct.location ) )
    {
        return;
    }
    
    if ( !activezones.size )
    {
        return 1;
    }
    
    var_44b6fac0db4c401a = level.var_fd5a14340d3320e9 * 2;
    var_44bad8c0db4feb2b = level.var_fd5a14340d3320e9;
    
    foreach ( activezone in activezones )
    {
        if ( !activezone.location )
        {
            continue;
        }
        
        var_706b8595a5393122 = distance( zonestruct.location, activezone.location );
        
        if ( var_706b8595a5393122 < var_44b6fac0db4c401a )
        {
            return 0;
        }
        
        distance2d = distance2d( zonestruct.location, activezone.location );
        
        if ( distance2d < var_44bad8c0db4feb2b )
        {
            return 0;
        }
    }
    
    return 1;
}

