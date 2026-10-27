// script_226d1866513930fa  (hash_226d1866513930fa.gscc) (size: 17541 Bytes / 0x4485 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcabf77d4 (3401545684)
// size ...... 17541 (0x4485)
// includes .. 17  (offset: 0x4285)
// strings ... 13  (offset: 0x430d)
// dev strs .. 16  (offset: 0x43b9)
// exports ... 33  (offset: 0x2a9d)
// cseg ...... 0x185 + 0x2918 (0x2a9d)
// imports ... 157 (offset: 0x2fc5)
// animtree1 . 0   (offset: 0x4485)
// animtree2 . 0   (offset: 0x4485)
#using script_e9bca00ec07d3c6;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\game_utility;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\equipment;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\stealth\manager;

#namespace ai_spawn_director;

// Namespace ai_spawn_director
// Params 0, eflags: 0x1
// Checksum 0x733eca9, Offset: 0x1a3
// Size: 0xd4
function autoexec function_4dd4cd43833daebb()
{
    level.var_16f375d1b0d1c224 = &function_6264db93bb2211;
    level.var_322ef03826a64697 = &function_5a90810f896d048a;
    level.var_a611f05444297343 = &function_31e214c79accbf7f;
    level.var_801f708fff2ed632 = &function_dbeaf1ed058249d0;
    level.var_cbd34096ae9d0004 = &function_abd1be0fa09342d8;
    level.var_c95e61c4fc8e049 = &function_ff5ebca79a7b0e2b;
    level.var_d965725bfca1652e = &function_49dbddf4b5b98aa8;
    level.var_a402a9ac5ac1adee = &function_383d7347c9819340;
    level.var_cdd64fc68a01b0 = &function_9844bf67a5461dc4;
    level.var_3db6b836941d6d4d = &function_3d0136e393468462;
    level.var_88cc975aac78e7df = &function_5e40887ae6f906be;
    
    /#
        level.var_5bcac48b7e338dce = &function_4a48542b24f83cc6;
        level.var_e807ae7cef74a307 = &function_40879d5cc59959fe;
        level.var_96589ceaddbba0e6 = &replay_analytics;
    #/
    
    level.var_b652537ae1e39415 = 1;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x13b5e95, Offset: 0x27f
// Size: 0x272
function function_6264db93bb2211( agent, data, spawn_anim_alias_list )
{
    agent endon( #"death" );
    
    if ( isdefined( agent.animname ) )
    {
        restoreanimname = agent.animname;
    }
    
    agent.animname = "ai_spawn_director";
    
    if ( !isarray( spawn_anim_alias_list ) )
    {
        spawn_anim_alias_list = [ spawn_anim_alias_list ];
    }
    
    for ( spawn_anim_index = 0; spawn_anim_index < spawn_anim_alias_list.size ; spawn_anim_index++ )
    {
        var_c19b41e13945c26 = spawn_anim_index == spawn_anim_alias_list.size - 1;
        spawn_anim_alias = spawn_anim_alias_list[ spawn_anim_index ];
        level.scr_anim[ agent.animname ][ spawn_anim_alias ] = spawn_anim_alias;
        
        if ( agent utility::function_4c656524ecb504d6( spawn_anim_alias ) && agent asm::asm_lookupanimfromaliasifexists( "animscripted", spawn_anim_alias ) >= 0 )
        {
            if ( data.var_f40d13031ef5df3 )
            {
                animscripted_origin = data.origin;
                var_adf5e39c149b95a1 = 10;
                
                if ( abs( agent utility::function_80505911b6822d3( spawn_anim_alias )[ 2 ] ) > var_adf5e39c149b95a1 )
                {
                    animscripted_origin = data.animscripted_origin;
                }
                
                agent utility::animscriptedagent( spawn_anim_alias, "spawn_end", animscripted_origin, data.angles, "spawn_animating" );
                break;
            }
            
            movedelta = agent utility::function_80505911b6822d3( spawn_anim_alias );
            angledelta = agent utility::function_f59c00aad3d87ab9( spawn_anim_alias );
            movedelta = rotatevector( movedelta, data.angles );
            startorigin = data.origin - movedelta;
            startangles = ( data.angles[ 0 ], angleclamp( data.angles[ 1 ] - angledelta ), data.angles[ 2 ] );
            testorigin = ( startorigin[ 0 ], startorigin[ 1 ], data.origin[ 2 ] );
            var_214d9dbfaa603b12 = !navtrace( data.origin, testorigin, agent, 0 );
            
            if ( var_c19b41e13945c26 || var_214d9dbfaa603b12 )
            {
                agent utility::animscriptedagent( spawn_anim_alias, "spawn_end", startorigin, startangles, "spawn_animating" );
                break;
            }
        }
    }
    
    if ( restoreanimname )
    {
        agent.animname = restoreanimname;
        return;
    }
    
    agent.animname = undefined;
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x38c5737a, Offset: 0x4f9
// Size: 0x42
function function_abd1be0fa09342d8()
{
    thread stealth_manager_cpmp::monitor_death_thread( level.stealth.damage_auto_range, level.stealth.damage_sight_range, level.stealth.var_4819c1af33f93f1e );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xe3dd1ca6, Offset: 0x543
// Size: 0x7b
function function_5a90810f896d048a( var_30b4822d70c44a1 )
{
    if ( !var_30b4822d70c44a1 )
    {
        requestid = self.directorrequestid;
        
        if ( isdefined( level.var_a20b02d86621e9ed[ requestid ][ "DirectorKilledAI" ] ) )
        {
            callbackstruct = level.var_a20b02d86621e9ed[ requestid ][ "DirectorKilledAI" ];
            thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata );
        }
    }
    
    agent_utils::despawnagent();
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x77f3bb7c, Offset: 0x5c6
// Size: 0x110
function function_383d7347c9819340( requestid, data )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self hide();
    utility::delaycall( 0.5, &show );
    self function_6bb4fe624d472bf3( 1 );
    waitframe();
    
    if ( data.smokebombinfil )
    {
        thread function_5a0c5c8c494a96b7( data );
    }
    else if ( data.custominfil )
    {
        data.origin = data.parachute_start_pos;
        thread function_5e40887ae6f906be( data );
    }
    
    level.var_e2531c6b0833956d = &function_3bf3890f4bfe722b;
    level.var_23472e00aeec245f = &function_ca6907e8a64a5381;
    
    if ( !isdefined( level.var_5e4d3c587acb273d ) )
    {
        level.var_5e4d3c587acb273d = getdvarint( @"hash_8fcbfd9a48aa5c5c", 1 );
    }
    
    self [[ level.var_8ef3e1bd276011eb ]]( data.parachute_start_pos, data.parachute_end_pos, undefined, 0, 3 );
    function_cd73d5a41d9796c6( requestid );
    _precombat( data );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xe21436af, Offset: 0x6de
// Size: 0x14
function private function_3bf3890f4bfe722b( animname )
{
    self scriptmodelplayanim( animname );
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0xc7b88224, Offset: 0x6fa
// Size: 0x3d
function private function_ca6907e8a64a5381( pos, angles, bsetorigin )
{
    if ( bsetorigin )
    {
        self setorigin( pos, 0 );
        return;
    }
    
    if ( isdefined( angles ) )
    {
        self setplayerangles( angles );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x108e68d3, Offset: 0x73f
// Size: 0x3e
function private function_5a0c5c8c494a96b7( data )
{
    self endon( #"death" );
    self waittill( #"hash_837c415c31f841e0" );
    function_3d0136e393468462( self.landing_spot, self.directorrequestid );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xbae79816, Offset: 0x785
// Size: 0x251
function private function_3d0136e393468462( grenadeloc, requestid )
{
    if ( !isdefined( level.var_b7f0da7ac80e9755[ requestid ] ) )
    {
        level.var_b7f0da7ac80e9755[ requestid ] = [];
    }
    
    var_c4e0a1de65373bfa = [];
    
    foreach ( var_e6b2169840aaa3e in level.var_b7f0da7ac80e9755[ requestid ] )
    {
        if ( gettime() < var_e6b2169840aaa3e.endtime )
        {
            var_c4e0a1de65373bfa[ var_c4e0a1de65373bfa.size ] = var_e6b2169840aaa3e;
        }
    }
    
    level.var_b7f0da7ac80e9755[ requestid ] = var_c4e0a1de65373bfa;
    
    foreach ( var_e6b2169840aaa3e in level.var_b7f0da7ac80e9755[ requestid ] )
    {
        if ( distancesquared( grenadeloc, var_e6b2169840aaa3e.origin ) < 30625 )
        {
            return;
        }
    }
    
    /#
        if ( getdvarint( @"hash_876ad02b2995d446", 0 ) == 1 )
        {
            sphere( grenadeloc, sqrt( 30625 ), ( 1, 0, 0 ), 1, int( 160 ) );
        }
    #/
    
    smokegrenadeweapon = equipment_mp::getweaponfromequipmentref( "equip_smoke" );
    
    if ( isdefined( smokegrenadeweapon ) )
    {
        smokegrenadeent = magicgrenademanual( smokegrenadeweapon.basename, grenadeloc, ( 0, 0, -10 ), 0 );
        thread utility::delaythread( 0.05, &utility::play_sound_in_space, "smoke_grenade_expl_trans", smokegrenadeent.origin );
        var_e6b2169840aaa3e = spawnstruct();
        var_e6b2169840aaa3e.origin = smokegrenadeent.origin;
        var_e6b2169840aaa3e.endtime = gettime() + 8000;
        level.var_b7f0da7ac80e9755[ requestid ][ level.var_b7f0da7ac80e9755[ requestid ].size ] = var_e6b2169840aaa3e;
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x8345350f, Offset: 0x9de
// Size: 0x143
function private function_5e40887ae6f906be( data )
{
    rootpart = data.var_94654d69cf1fe557;
    offsetforward = anglestoforward( data.angles ) * data.var_bb14ca646f014c6f[ 0 ];
    offsetright = anglestoright( data.angles ) * data.var_bb14ca646f014c6f[ 1 ];
    offsetup = anglestoup( data.angles ) * data.var_bb14ca646f014c6f[ 2 ];
    var_d9bc77085abb66c0 = offsetforward + offsetright + offsetup;
    scriptableangles = combineangles( data.angles, data.var_26f814b25a85020d );
    infilscriptable = spawnscriptable( data.var_586750f761586b3, data.origin + var_d9bc77085abb66c0, scriptableangles );
    infilscriptable setscriptablepartstate( rootpart, data.var_bcb5c9e91d2117a7 );
    wait data.var_24ada7b3f042e1a8;
    
    if ( isdefined( infilscriptable ) )
    {
        infilscriptable setscriptablepartstate( rootpart, data.var_c56260e2f2f1e4e9 );
        wait 1;
        
        if ( isdefined( infilscriptable ) )
        {
            infilscriptable freescriptable();
        }
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x9090122b, Offset: 0xb29
// Size: 0x7e5
function private function_ff5ebca79a7b0e2b( requestid, team, vehicleinfostruct )
{
    level endon( #"game_ended" );
    assert( isdefined( team ) );
    
    if ( isdefined( level.var_ad5e0ea91bb718a4 ) )
    {
        elapsed = gettime() - level.var_ad5e0ea91bb718a4;
        
        if ( utility::function_6f5d2e1f1ff70482( elapsed ) < 1 )
        {
            wait randomfloatrange( 1, 3 );
        }
    }
    
    vehicle = vehicleinfostruct.vehicle;
    vehicle_index = vehicleinfostruct.vehicle_index;
    vehiclepathtargetname = vehicleinfostruct.vehiclepathtargetname;
    riders = vehicleinfostruct.riders;
    unload_pos = vehicleinfostruct.unload_pos;
    skinoverride = vehicleinfostruct.skinoverride;
    var_59895721eaa7afbd = vehicleinfostruct.var_dd45d245730c6c45;
    
    if ( var_59895721eaa7afbd )
    {
        var_28e67715cd82b1e8 = vehicleinfostruct.var_28e67715cd82b1e8;
    }
    
    vehicle_ref = undefined;
    
    foreach ( vehicleref in level.var_a7bf93687486b5ba )
    {
        if ( vehicleref.vehicle == vehicle )
        {
            vehicle_ref = vehicleref.ref;
            break;
        }
    }
    
    assert( isdefined( vehicle_ref ), "<dev string:x24>" + vehicle );
    vehiclenodestart = undefined;
    vehiclenodeunload = undefined;
    
    if ( isdefined( vehicle_index ) )
    {
        vehiclenodestart = getvehiclenode( vehicle_index );
    }
    else
    {
        assert( isdefined( vehiclepathtargetname ), "<dev string:x3b>" + vehicle );
        vehiclenodeunload = utility::getstruct( vehiclepathtargetname, "targetname" );
        
        if ( !vehiclenodeunload )
        {
            script::demoforcesre( "AI Spawn Director missing vehicle path " + vehiclepathtargetname );
        }
        
        vehiclenodestart = vehiclenodeunload namespace_37f5741ccbccb7a::function_b13c15ac4de13156();
        
        if ( !vehiclenodestart )
        {
            script::demoforcesre( "AI Spawn Director vehicle path has no valid start node " + vehiclepathtargetname );
        }
        
        vehiclenodeunload namespace_37f5741ccbccb7a::function_224b7b468e4613ec( vehiclenodestart );
    }
    
    if ( var_59895721eaa7afbd )
    {
        var_28e67715cd82b1e8.origin = vehiclenodestart.origin + ( 0, 0, 128 );
        var_28e67715cd82b1e8.angles = vehiclenodestart.angles;
        level thread function_5e40887ae6f906be( var_28e67715cd82b1e8 );
    }
    
    spawndata = {};
    spawndata.var_6434572d2f2dc708 = hashcat( %"vehiclebundle:", vehicle_ref );
    spawndata.spawnnode = vehiclenodestart;
    spawndata.is_landed = 0;
    spawndata.vehicle_ref = vehicle_ref;
    spawndata.var_b3d18d4778197ab5 = 0;
    spawndata.heli_team = team;
    spawndata.skinoverride = skinoverride;
    spawndata.requestid = requestid;
    spawndata.var_7b27ef0169596da0 = 1;
    
    if ( utility::issharedfuncdefined( vehicle_ref, #"spawn" ) )
    {
        heli = [[ utility::getsharedfunc( vehicle_ref, #"spawn" ) ]]( spawndata );
    }
    else
    {
        heli = namespace_37f5741ccbccb7a::ai_spawn_director_heli_spawn( spawndata.spawnnode, spawndata.is_landed, spawndata.vehicle_ref, spawndata.var_b3d18d4778197ab5, spawndata.heli_team, undefined, spawndata.skinoverride, spawndata.requestid );
    }
    
    if ( !isdefined( heli ) )
    {
        foreach ( rider in riders )
        {
            rider function_a0ce0fd087a726d0( 1 );
        }
        
        return;
    }
    
    heli sentientpoolmanager::registersentient( "Level_Vehicle", heli.team );
    callbackstruct = _lookup_callback( "OnVehicleSpawned", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        foreach ( entry in callbackstruct )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, heli );
        }
    }
    
    if ( isdefined( vehicle_index ) )
    {
        if ( !utility::issharedfuncdefined( vehicle_ref, #"infil" ) )
        {
            heli namespace_37f5741ccbccb7a::ai_spawn_director_heli_init();
            level.vehicles.damagecallbacks.deathcallbacks[ heli vehicle::get_ref() ] = &function_608bdf52803a2bb0;
        }
        
        if ( utility::issharedfuncdefined( vehicle_ref, #"loadAI" ) )
        {
            heli [[ utility::getsharedfunc( vehicle_ref, #"loadAI" ) ]]( riders );
        }
        else
        {
            heli namespace_37f5741ccbccb7a::ai_spawn_director_heli_load_ai( riders );
        }
        
        foreach ( rider in riders )
        {
            rider.var_a6ecefe6814132d4 = undefined;
        }
        
        vehicle_occupancy::set_team( heli, team );
        
        if ( utility::issharedfuncdefined( vehicle_ref, #"infil" ) )
        {
            heli thread [[ utility::getsharedfunc( vehicle_ref, #"infil" ) ]]( requestid, vehiclenodestart );
        }
        else if ( heli vehicle_ai::has_anim_intro() )
        {
            heli thread function_fc657db8a56df06a( requestid, vehiclenodestart );
        }
        else
        {
            heli thread function_2daa2cadaeec244a( requestid, unload_pos, vehiclenodestart );
        }
        
        heli thread function_8e5fd6ee7c16e173( requestid );
        return;
    }
    
    heli endon( #"death" );
    heli thread function_8e5fd6ee7c16e173( requestid );
    heli function_d2b8ee2e1275daaf( 1 );
    heli vehphys_forcekeyframedmotion();
    heli vehicle_interact::set_visibility( 0 );
    heli.script_vehicle_selfremove = 1;
    
    if ( utility::issharedfuncdefined( vehicle_ref, #"loadAI" ) )
    {
        heli [[ utility::getsharedfunc( vehicle_ref, #"loadAI" ) ]]( riders );
    }
    else
    {
        heli namespace_37f5741ccbccb7a::ai_spawn_director_heli_load_ai( riders );
    }
    
    foreach ( rider in riders )
    {
        rider thread function_d01c01d2ae601d33( requestid, unload_pos );
        rider.var_a6ecefe6814132d4 = undefined;
    }
    
    vehicle_occupancy::set_team( heli, team );
    wait 1;
    
    if ( utility::issharedfuncdefined( vehicle_ref, #"infil" ) )
    {
        heli thread [[ utility::getsharedfunc( vehicle_ref, #"infil" ) ]]( requestid, vehiclenodestart, vehiclenodeunload, riders );
        return;
    }
    
    heli vehicle_interact::set_visibility( 1 );
    heli thread namespace_37f5741ccbccb7a::function_7ac76e1b9d949c1e( vehiclenodeunload.ground_pos, requestid );
    heli thread namespace_37f5741ccbccb7a::function_2ca63bc8e2eee252( requestid );
    
    if ( !isdefined( vehiclenodeunload.var_19ef9c5f3c3fe4aa ) )
    {
        heli vehphys_setdefaultmotion();
        heli.choices = vehiclenodeunload.choices;
        heli vehicle_paths::vehicle_paths_helicopter( vehiclenodestart );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xf0e0442a, Offset: 0x1316
// Size: 0x37, Type: bool
function private function_608bdf52803a2bb0( data )
{
    chopper_support::choppersupport_handledeathdamage( data );
    self notify( #"death" );
    self.burningdown = undefined;
    thread vehicle::explode( data, 0 );
    return true;
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x33e04b9e, Offset: 0x1356
// Size: 0x8
function private function_9844bf67a5461dc4()
{
    self vehicleclearanims();
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x6d701009, Offset: 0x1366
// Size: 0x518
function private function_49dbddf4b5b98aa8( requestid, team, vehicleinfostruct )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_ad5e0ea91bb718a4 ) )
    {
        elapsed = gettime() - level.var_ad5e0ea91bb718a4;
        
        if ( utility::function_6f5d2e1f1ff70482( elapsed ) < 1 )
        {
            wait randomfloatrange( 1, 3 );
        }
    }
    
    assert( isdefined( vehicleinfostruct.vehicle_index ), "<dev string:x7a>" );
    vehicle = vehicleinfostruct.vehicle;
    vehicle_index = vehicleinfostruct.vehicle_index;
    riders = vehicleinfostruct.riders;
    unload_pos = vehicleinfostruct.unload_pos;
    skinoverride = vehicleinfostruct.skinoverride;
    assert( isarray( riders ) && riders.size > 0, "<dev string:xdd>" + vehicle );
    var_59895721eaa7afbd = vehicleinfostruct.var_dd45d245730c6c45;
    
    if ( var_59895721eaa7afbd )
    {
        var_28e67715cd82b1e8 = vehicleinfostruct.var_28e67715cd82b1e8;
    }
    
    vehiclenodestart = getvehiclenode( vehicle_index );
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = vehiclenodestart.origin;
    vehiclespawndata.angles = vehiclenodestart.angles;
    vehiclespawndata.var_305ce2bb6ec0993d = skinoverride;
    vehiclespawndata.initai = 1;
    vehicle_ref = undefined;
    
    foreach ( vehicleref in level.var_a7bf93687486b5ba )
    {
        if ( vehicleref.vehicle == vehicle )
        {
            vehicle_ref = vehicleref.ref;
            break;
        }
    }
    
    if ( isdefined( vehicle_ref ) )
    {
        if ( isdefined( level.var_bda580f876415726 ) )
        {
            [[ level.var_bda580f876415726 ]]( requestid, vehicle_ref, vehiclespawndata );
        }
        
        if ( var_59895721eaa7afbd )
        {
            var_28e67715cd82b1e8.origin = vehiclenodestart.origin;
            var_28e67715cd82b1e8.angles = vehiclenodestart.angles;
            level thread function_5e40887ae6f906be( var_28e67715cd82b1e8 );
        }
        
        spawnedvehicle = vehicle::spawn( vehicle_ref, vehiclespawndata );
        
        if ( isdefined( spawnedvehicle ) )
        {
            function_3b2957f0d5f9eb4a( requestid, spawnedvehicle );
            level.var_ad5e0ea91bb718a4 = gettime();
            spawnedvehicle thread function_8e5fd6ee7c16e173( requestid );
            spawnedvehicle endon( #"death" );
            callbackstruct = _lookup_callback( "OnVehicleSpawned", requestid );
            
            if ( isdefined( callbackstruct ) )
            {
                foreach ( entry in callbackstruct )
                {
                    thread [[ entry.fncallback ]]( requestid, entry.userdata, spawnedvehicle );
                }
            }
            
            vehicle_interact::allow_use( spawnedvehicle, 0 );
            assert( isarray( riders ) && riders.size > 0, "<dev string:xdd>" + spawnedvehicle.vehiclename );
            spawnedvehicle function_abadd6786f1c47f1( riders );
            
            foreach ( guy in riders )
            {
                spawnedvehicle thread function_ce51f0ff56cd0a9a( guy );
            }
            
            spawnedvehicle vehicle_ai::load( riders, 1 );
            utility::array_wait( riders, "entervehicle" );
            
            foreach ( guy in riders )
            {
                guy.var_a6ecefe6814132d4 = undefined;
            }
            
            spawnedvehicle notify( #"vehicle_loaded" );
            vehicle_occupancy::set_team( spawnedvehicle, team );
            spawnedvehicle function_9419b995f7b80fe3( spawnedvehicle, spawnedvehicle.origin, vehicle_index, vehiclenodestart.speed );
            spawnedvehicle thread function_431a955cdf4541d6( requestid, unload_pos );
            spawnedvehicle thread function_9b4d7efab3d65703( requestid );
        }
        
        return;
    }
    
    assertmsg( "<dev string:xfd>" + vehicle );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xd5877409, Offset: 0x1886
// Size: 0x3d
function private function_ce51f0ff56cd0a9a( rider )
{
    self endon( #"vehicle_loaded" );
    self waittill( #"death" );
    rider.var_a6ecefe6814132d4 = undefined;
    rider notify( #"loaded" );
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x38691e72, Offset: 0x18cb
// Size: 0x8d
function private function_2daa2cadaeec244a( requestid, unload_pos, vehiclenodestart )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    thread namespace_37f5741ccbccb7a::ai_spawn_director_heli_follow_path( vehiclenodestart, undefined );
    self waittill( #"hash_f9c98fc69d6a7e14" );
    unload_pos = namespace_37f5741ccbccb7a::ai_spawn_director_heli_finddroplocation( unload_pos );
    var_7416e534b8956ddb = namespace_37f5741ccbccb7a::function_d3c71c9947aada0b( unload_pos );
    function_41ad9a970079b31e( requestid, vehiclenodestart.origin, var_7416e534b8956ddb );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x32cbe1a2, Offset: 0x1960
// Size: 0x6e
function private function_fc657db8a56df06a( requestid, vehiclenodestart )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    var_7416e534b8956ddb = namespace_37f5741ccbccb7a::function_c2902224b0903337( vehiclenodestart, vehiclenodestart.origin );
    function_41ad9a970079b31e( requestid, vehiclenodestart.origin, var_7416e534b8956ddb );
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x6d4d69f, Offset: 0x19d6
// Size: 0xee
function private function_41ad9a970079b31e( requestid, return_to_pos, var_7416e534b8956ddb )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    foreach ( agent in var_7416e534b8956ddb )
    {
        if ( isdefined( agent ) && agent.isactive )
        {
            agent function_87d2160f1f99c092( requestid );
        }
    }
    
    function_2479114e5ee014dc( requestid );
    thread namespace_37f5741ccbccb7a::ai_spawn_director_heli_land( return_to_pos );
    self waittill( #"ai_spawn_director_heli_landed" );
    namespace_37f5741ccbccb7a::ai_spawn_director_heli_cleanup();
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xc6c612da, Offset: 0x1acc
// Size: 0x15
function private function_31e214c79accbf7f( agent )
{
    agent game_utility_common::removefromcharactersarray();
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x5234e999, Offset: 0x1ae9
// Size: 0x2c
function private function_dbeaf1ed058249d0( name, key )
{
    array = utility::getstructarray( name, key );
    return array;
}

/#

    // Namespace ai_spawn_director
    // Params 0, eflags: 0x4
    // Checksum 0xaa877437, Offset: 0x1b1e
    // Size: 0xbd, Type: dev
    function private function_4a48542b24f83cc6()
    {
        self endon( #"death" );
        influencesum = getplayerinfluenceatposition( self.origin, 1 );
        randomnesslerp = randomfloatrange( 0, 0.5 );
        influencelerp = clamp( influencesum / 4, 0, 1 ) * 0.5;
        weight = randomnesslerp + influencelerp;
        a = 60;
        b = 10;
        waittime = a * ( 1 - weight ) + b * weight;
        waittime = clamp( waittime, b, a );
        wait waittime;
        self kill();
    }

    // Namespace ai_spawn_director
    // Params 1, eflags: 0x4
    // Checksum 0xe3fc455b, Offset: 0x1be3
    // Size: 0x1ec, Type: dev
    function private function_40879d5cc59959fe( test_string )
    {
        level notify( #"hash_b86dd70e75339297" );
        level endon( #"hash_b86dd70e75339297" );
        test_params = strtok( test_string, "<dev string:x129>" );
        test_types = [];
        should_move = 0;
        should_kill = 0;
        run_all = 0;
        
        foreach ( param in test_params )
        {
            switch ( param )
            {
                case #"hash_5f937e1deca2a44f":
                case #"hash_8b3de9dcd39c0dc6":
                case #"hash_b8b717134133c2d8":
                    test_types[ test_types.size ] = param;
                    break;
                case #"hash_20cd76d83c2f7487":
                    should_move = 1;
                    break;
                case #"hash_b5868715305a78a7":
                    should_kill = 1;
                    break;
                case #"hash_c482c6c109150a4":
                    run_all = 1;
                    break;
            }
        }
        
        foreach ( test_type in test_types )
        {
            if ( run_all )
            {
                function_ed0db21f13a803f0( test_type, 0, 0 );
                function_ed0db21f13a803f0( test_type, 0, 1 );
                function_ed0db21f13a803f0( test_type, 1, 0 );
                function_ed0db21f13a803f0( test_type, 1, 1 );
                continue;
            }
            
            function_ed0db21f13a803f0( test_type, should_move, should_kill );
        }
    }

    // Namespace ai_spawn_director
    // Params 3, eflags: 0x4
    // Checksum 0xb2fa6ef9, Offset: 0x1dd7
    // Size: 0x14d, Type: dev
    function private function_ed0db21f13a803f0( test_name, should_move, should_kill )
    {
        setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
        setdvar( @"hash_fe20797ad12b2dbe", should_kill );
        
        if ( isdefined( level.var_cb55b6cfd5f1581b ) )
        {
            foreach ( influenceobject in level.var_cb55b6cfd5f1581b )
            {
                function_6d4d9bed05f4a44e( influenceobject );
            }
        }
        
        level.var_cb55b6cfd5f1581b = [];
        thread function_5a01dd619b1237e6( test_name, should_move );
        wait 5;
        full_test_name = test_name;
        full_test_name += should_move ? "<dev string:x157>" : "<dev string:x15f>";
        full_test_name += should_kill ? "<dev string:x16b>" : "<dev string:x174>";
        iprintlnbold( "<dev string:x180>" + full_test_name );
        
        if ( should_kill )
        {
            wait 240;
        }
        else
        {
            wait 60;
        }
        
        setdvar( @"hash_53043691f4ede34", full_test_name );
        iprintlnbold( "<dev string:x187>" + full_test_name );
        waitframe();
    }

    // Namespace ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x70e1237d, Offset: 0x1f2c
    // Size: 0x5b, Type: dev
    function private function_5a01dd619b1237e6( test_name, should_move )
    {
        level notify( #"hash_4dc4869f45de5f3d" );
        level endon( #"hash_4dc4869f45de5f3d" );
        function_12f4fa8367c6f7b( test_name, should_move, 24000 );
        wait 24;
        
        while ( true )
        {
            wait 0.5;
            function_12f4fa8367c6f7b( test_name, should_move, 500 );
        }
    }

    // Namespace ai_spawn_director
    // Params 3, eflags: 0x4
    // Checksum 0xc3503d1c, Offset: 0x1f8f
    // Size: 0x114, Type: dev
    function private function_12f4fa8367c6f7b( test_name, should_move, duration )
    {
        navbounds = getnavbounds();
        navbounds.halfsize *= 0.8;
        worldmin = navbounds.midpoint - navbounds.halfsize;
        worldmax = navbounds.midpoint + navbounds.halfsize;
        player_count = getdvarint( @"party_maxplayers", 48 );
        level.var_9e8ede6f0c848507 = 0;
        
        switch ( test_name )
        {
            case #"hash_8b3de9dcd39c0dc6":
                function_1bcad4a7680c368( player_count, should_move, worldmin, worldmax, duration );
                break;
            case #"hash_5f937e1deca2a44f":
                function_b0be8e72eebb6d81( player_count, should_move, worldmin, worldmax, duration );
                break;
            case #"hash_b8b717134133c2d8":
                function_5b9664ef947dc19e( player_count, should_move, worldmin, worldmax, duration );
                break;
        }
    }

    // Namespace ai_spawn_director
    // Params 5, eflags: 0x4
    // Checksum 0x16187680, Offset: 0x20ab
    // Size: 0x1de, Type: dev
    function private function_1bcad4a7680c368( player_count, should_move, worldmin, worldmax, duration )
    {
        squad_count = int( player_count / 4 );
        var_425faa46edd987f8 = int( floor( sqrt( squad_count ) ) );
        var_61c6523e75feafaf = int( squad_count / var_425faa46edd987f8 );
        xsize = worldmax[ 0 ] - worldmin[ 0 ];
        ysize = worldmax[ 1 ] - worldmin[ 1 ];
        xincrement = xsize / var_425faa46edd987f8;
        yincrement = ysize / var_61c6523e75feafaf;
        var_f73e959f756dea03 = [ ( 0, 0, 0 ), ( 500, 0, 0 ), ( 0, 500, 0 ), ( 500, 500, 0 ) ];
        
        for ( xindex = 0; xindex < var_425faa46edd987f8 ; xindex++ )
        {
            xpos = worldmin[ 0 ] + xindex * xincrement;
            
            for ( yindex = 0; yindex < var_61c6523e75feafaf ; yindex++ )
            {
                ypos = worldmin[ 1 ] + yindex * yincrement;
                var_e6d3876dc945e6f5 = ( xpos, ypos, 1172 );
                
                foreach ( var_1c68caa3117cc882 in var_f73e959f756dea03 )
                {
                    function_9a2aadd9e3d7bcf( var_e6d3876dc945e6f5 + var_1c68caa3117cc882, should_move, duration );
                }
            }
        }
    }

    // Namespace ai_spawn_director
    // Params 5, eflags: 0x4
    // Checksum 0x9b337039, Offset: 0x2291
    // Size: 0x112, Type: dev
    function private function_b0be8e72eebb6d81( player_count, should_move, worldmin, worldmax, duration )
    {
        var_425faa46edd987f8 = int( floor( sqrt( player_count ) ) );
        var_61c6523e75feafaf = int( player_count / var_425faa46edd987f8 );
        xsize = worldmax[ 0 ] - worldmin[ 0 ];
        ysize = worldmax[ 1 ] - worldmin[ 1 ];
        xincrement = xsize / var_425faa46edd987f8;
        yincrement = ysize / var_61c6523e75feafaf;
        
        for ( xindex = 0; xindex < var_425faa46edd987f8 ; xindex++ )
        {
            xpos = worldmin[ 0 ] + xindex * xincrement;
            
            for ( yindex = 0; yindex < var_61c6523e75feafaf ; yindex++ )
            {
                ypos = worldmin[ 1 ] + yindex * yincrement;
                var_e6d3876dc945e6f5 = ( xpos, ypos, 1172 );
                function_9a2aadd9e3d7bcf( var_e6d3876dc945e6f5, should_move, duration );
            }
        }
    }

    // Namespace ai_spawn_director
    // Params 5, eflags: 0x4
    // Checksum 0x5f37bfd5, Offset: 0x23ab
    // Size: 0x55, Type: dev
    function private function_5b9664ef947dc19e( player_count, should_move, worldmin, worldmax, duration )
    {
        function_b0be8e72eebb6d81( player_count / 2, should_move, worldmin, worldmax, duration );
        function_1bcad4a7680c368( player_count / 2, should_move, worldmin, worldmax, duration );
    }

    // Namespace ai_spawn_director
    // Params 2, eflags: 0x4
    // Checksum 0x441edc8b, Offset: 0x2408
    // Size: 0x99, Type: dev
    function private function_aefc1c3376297406( var_e6d3876dc945e6f5, timeoffset )
    {
        var_fe6367e851478950 = 57.2958;
        x = ( gettime() + timeoffset ) / 1000;
        x /= getdvarfloat( @"hash_f1961fe2a6c4855b", 10 );
        x *= var_fe6367e851478950;
        moveradius = getdvarfloat( @"hash_de5359935bb10538", 5000 );
        var_e6d3876dc945e6f5 += ( sin( x ) * moveradius, cos( x ) * moveradius, 0 );
        return var_e6d3876dc945e6f5;
    }

    // Namespace ai_spawn_director
    // Params 3, eflags: 0x4
    // Checksum 0x42741017, Offset: 0x24a9
    // Size: 0x13c, Type: dev
    function private function_9a2aadd9e3d7bcf( var_e6d3876dc945e6f5, should_move, duration )
    {
        closesttacpoint = findclosesttacpoint( var_e6d3876dc945e6f5 );
        
        if ( isdefined( closesttacpoint ) )
        {
            var_e6d3876dc945e6f5 = closesttacpoint.origin;
        }
        
        var_e247acc07f0d97b2 = var_e6d3876dc945e6f5;
        
        if ( should_move )
        {
            var_e6d3876dc945e6f5 = function_aefc1c3376297406( var_e6d3876dc945e6f5, 0 );
            var_4130a5b55977f81e = function_aefc1c3376297406( var_e247acc07f0d97b2, 3000 );
            orientedbox( var_4130a5b55977f81e, ( 1000, 1000, 1000 ), ( 0, 0, 0 ), ( 1, 0, 1 ), 0, int( duration / level.frameduration ) );
        }
        
        var_e6d3876dc945e6f5 = getclosestpointonnavmesh( var_e6d3876dc945e6f5, "<dev string:x18c>", 0, 0, 1 );
        
        if ( !isdefined( level.var_9e8ede6f0c848507 ) )
        {
            level.var_9e8ede6f0c848507 = 0;
        }
        
        if ( isdefined( level.var_cb55b6cfd5f1581b[ level.var_9e8ede6f0c848507 ] ) )
        {
            function_dafceb36d16ed736( level.var_cb55b6cfd5f1581b[ level.var_9e8ede6f0c848507 ], var_e6d3876dc945e6f5 );
        }
        else
        {
            level.var_cb55b6cfd5f1581b[ level.var_9e8ede6f0c848507 ] = function_45620799fe2b84d1( var_e6d3876dc945e6f5, 4, 1 );
        }
        
        level.var_9e8ede6f0c848507++;
    }

    // Namespace ai_spawn_director
    // Params 1
    // Checksum 0xec7d3826, Offset: 0x25ed
    // Size: 0x33f, Type: dev
    function replay_analytics( tablename )
    {
        level notify( #"hash_4dc4869f45de5f3d" );
        level notify( #"replay_analytics" );
        level endon( #"replay_analytics" );
        level.var_321234013c78f085 = [];
        childthread function_8307d72b58a88cc7();
        iprintlnbold( "<dev string:x192>" + tablename );
        numrows = tablelookupgetnumrows( tablename );
        var_80ee2f6578468cfe = undefined;
        playbackstarttime = undefined;
        
        for ( rowindex = 3; rowindex < numrows ; rowindex++ )
        {
            event = tablelookupbyrow( tablename, rowindex, 0 );
            entnum = int( tablelookupbyrow( tablename, rowindex, 2 ) );
            eventtype = tablelookupbyrow( tablename, rowindex, 3 );
            timestamp = int( tablelookupbyrow( tablename, rowindex, 1 ) );
            
            if ( event != "<dev string:x1a4>" )
            {
                rowindex++;
                continue;
            }
            
            if ( !isdefined( var_80ee2f6578468cfe ) )
            {
                var_80ee2f6578468cfe = timestamp;
                playbackstarttime = gettime();
            }
            
            speedmul = getdvarint( @"hash_4d697dbebbd5e599", 10 );
            
            if ( speedmul <= 0 )
            {
                speedmul = 1;
            }
            
            timedelta = timestamp - var_80ee2f6578468cfe;
            timedelta /= speedmul;
            targetservertime = playbackstarttime + timedelta;
            
            if ( targetservertime > gettime() )
            {
                wait float( targetservertime - gettime() ) / 1000;
            }
            
            switch ( eventtype )
            {
                case #"hash_cbfb23135a2db9a1":
                    pos_x = float( tablelookupbyrow( tablename, rowindex, 4 ) );
                    pos_y = float( tablelookupbyrow( tablename, rowindex, 5 ) );
                    level.var_321234013c78f085[ entnum ] = spawnstruct();
                    level.var_321234013c78f085[ entnum ].startpos = ( pos_x, pos_y, 0 );
                    level.var_321234013c78f085[ entnum ].startpos = getclosestpointonnavmesh( level.var_321234013c78f085[ entnum ].startpos, "<dev string:x18c>", 0, 0, 1 );
                    level.var_321234013c78f085[ entnum ].endpos = level.var_321234013c78f085[ entnum ].startpos;
                    level.var_321234013c78f085[ entnum ].starttime = gettime();
                    level.var_321234013c78f085[ entnum ].name = tablelookupbyrow( tablename, rowindex, 7 );
                    break;
                case #"hash_82b3bcf2299864ac":
                    if ( isdefined( level.var_321234013c78f085[ entnum ] ) )
                    {
                        pos_x = float( tablelookupbyrow( tablename, rowindex, 4 ) );
                        pos_y = float( tablelookupbyrow( tablename, rowindex, 5 ) );
                        level.var_321234013c78f085[ entnum ].startpos = level.var_321234013c78f085[ entnum ].endpos;
                        level.var_321234013c78f085[ entnum ].endpos = getclosestpointonnavmesh( ( pos_x, pos_y, 0 ), "<dev string:x18c>", 0, 0, 1 );
                        level.var_321234013c78f085[ entnum ].starttime = gettime();
                    }
                    
                    break;
            }
        }
        
        iprintlnbold( "<dev string:x1c4>" );
    }

    // Namespace ai_spawn_director
    // Params 0
    // Checksum 0xa65aca0d, Offset: 0x2934
    // Size: 0x169, Type: dev
    function function_8307d72b58a88cc7()
    {
        while ( isdefined( level.var_321234013c78f085 ) )
        {
            speedmul = getdvarint( @"hash_4d697dbebbd5e599", 10 );
            totallerptime = 30 / speedmul;
            
            foreach ( playerstruct in level.var_321234013c78f085 )
            {
                timediff = ( gettime() - playerstruct.starttime ) / 1000;
                lerptime = clamp( timediff / totallerptime, 0, 1 );
                var_e6d3876dc945e6f5 = vectorlerp( playerstruct.startpos, playerstruct.endpos, lerptime );
                function_45620799fe2b84d1( var_e6d3876dc945e6f5, 4, 1, 1000 );
                print3d( var_e6d3876dc945e6f5, playerstruct.name, ( 1, 1, 1 ), 1, 10, 20, 1 );
                sphere( var_e6d3876dc945e6f5, 100, ( 0.88, 0.44, 0.88 ), 0, 20 );
            }
            
            wait 1;
        }
    }

#/
