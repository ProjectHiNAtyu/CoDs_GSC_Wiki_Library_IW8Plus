// scripts\mp\common\equipment\bunkerbuster.gsc  (hash_324387a2fac81207.gscc) (size: 19394 Bytes / 0x4bc2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xddfecbd2 (3724463058)
// size ...... 19394 (0x4bc2)
// includes .. 21  (offset: 0x4822)
// strings ... 48  (offset: 0x48ca)
// dev strs .. 4   (offset: 0x4b8a)
// exports ... 44  (offset: 0x2f3e)
// cseg ...... 0x36e + 0x2bd0 (0x2f3e)
// imports ... 146 (offset: 0x361e)
// animtree1 . 0   (offset: 0x4bc2)
// animtree2 . 0   (offset: 0x4bc2)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\outofbounds;
#using scripts\mp\riotshield;
#using scripts\mp\weapons;

#namespace bunkerbuster;

// Namespace bunkerbuster
// Params 0, eflags: 0x1
// Checksum 0xf42e4d6a, Offset: 0x38c
// Size: 0x82
function autoexec init()
{
    utility::flag_wait( "equipment_initialized" );
    utility::registersharedfunc( #"bunkerbuster", #"isbunkerbustergl", &isbunkerbustergl );
    utility::registersharedfunc( #"bunkerbuster", #"dronegun_emp", &dronegun_emp );
    weapons::registerusedcallback( "bunkerbuster", &used );
    equipment_mp::registercallback( "equip_bunkerbuster", "onPlayerDamaged", &on_player_damaged );
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_drill", &gl_used );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x618c0580, Offset: 0x416
// Size: 0x16
function private emp_applied( data )
{
    destroy( 1, 0 );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x36fef383, Offset: 0x435
// Size: 0x38
function private function_d34c517263178c70( data )
{
    self endon( #"death" );
    self setscriptablepartstate( #"shoot", #"explode", 0 );
    waitframe();
    self detonate();
}

// Namespace bunkerbuster
// Params 3
// Checksum 0xdc8f5e2, Offset: 0x475
// Size: 0x335
function gl_used( glgrenade, isgl, objweapon )
{
    glgrenade endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    stuckdata = spawnstruct();
    var_2c76eff819eaf3d = objweapon.basename == "jup_jp26_la_mike32_mp";
    
    if ( var_2c76eff819eaf3d )
    {
        childthread equipment_mp::function_a6d3e652b9c9f89c( stuckdata );
        childthread equipment_mp::function_efd7fb0edc3f4f6d( stuckdata );
    }
    else
    {
        childthread function_d164551305416c10( glgrenade, stuckdata );
        childthread monitorunderwater( glgrenade, stuckdata );
    }
    
    glgrenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    self notify( #"hash_aa0f957df202266c" );
    var_b544679be0cb8872 = var_2c76eff819eaf3d ? "equip_bunkerbuster_mike32" : "equip_bunkerbuster_gl";
    tableinfo = weapon::getequipmenttableinfo( var_b544679be0cb8872 );
    assert( isdefined( tableinfo ), "<dev string:x24>" );
    visualweapon = tableinfo.bundle.useweapon;
    assert( isdefined( visualweapon ) );
    grenade = weapon::_launchgrenade( visualweapon, glgrenade.origin, ( 0, 0, 0 ) );
    weapons::grenadeinitialize( grenade, makeweapon( visualweapon ) );
    grenade.angles = glgrenade.angles;
    grenade.glgrenadeparent = objweapon;
    grenade.glgrenade = glgrenade;
    grenade.var_84944d70bd5e9c2d = 1;
    grenade.stuckdata = stuckdata;
    
    if ( isdefined( stuckto ) )
    {
        if ( isplayer( stuckto ) || isagent( stuckto ) )
        {
            if ( stuckto player::isreallyalive() )
            {
                weapons::grenadestuckto( grenade, stuckto, 1 );
                
                if ( isdefined( stuckpart ) )
                {
                    grenade linkto( stuckto, stuckpart );
                }
                else
                {
                    grenade linkto( stuckto, "j_spine4", ( 0, 0, 0 ) );
                }
            }
        }
        else if ( shouldlink( stuckto, stuckpart ) )
        {
            if ( isdefined( stuckpart ) && stuckpart != "scriptbrushmodeldummy" && stuckto.classname != "script_brushmodel" && isdefined( stuckto.model ) && modelhastag( stuckto.model, stuckpart ) )
            {
                grenade linkto( stuckto, stuckpart );
            }
            else
            {
                grenade linkto( stuckto );
            }
        }
        
        grenade.stuckdata.stuckto = stuckto;
        grenade thread function_299398447facbe9a( stuckto );
    }
    else
    {
        staticlink = utility::spawn_script_origin( glgrenade.origin, normal );
        grenade linkto( staticlink );
        grenade.staticlink = staticlink;
    }
    
    glgrenade thread entity::deleteatframeend();
    grenade thread watchunlink();
    grenade thread function_b03adef181897f38();
    thread used( grenade );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x169af4f9, Offset: 0x7b2
// Size: 0x32a
function private function_fc5314bb16dadbc1( grenade )
{
    weaponref = grenade.weapon_name;
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_object.basenamehash );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"burrow_offset", @"hash_e3ecbcc6d770d476", bundle.burrow_offset, 50 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"riot_shield_offset", @"hash_3550d36068c86a93", bundle.riot_shield_offset, 12 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"hash_a6b93ce1cbf6b921", @"hash_8766c486f2519ffb", bundle.var_ec944352b5148454, 300 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"hash_22f9b30f10107181", @"hash_6bffd30022e9bcab", bundle.var_82a5ffd1841764f6, 0 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"burrowed_step", @"hash_e3ecbcc6d770d476", bundle.burrowed_step, 50 );
    equipment_utility::function_19ac700f043604( weaponref, #"hash_cc1222273c597c90", @"hash_f1406ba08fa573e", bundle.var_541a39493b36c347, 0 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"hash_4f2f60d1d1a21c2f", @"hash_36b6fe748db87bee", bundle.var_6b3b9253f4cfa0, 20 );
    equipment_utility::function_2d044a0367c41bbf( weaponref, #"character_stuck_num_ticks", @"hash_d7df18c5f0ec5694", bundle.player_stuck_num_ticks, 5 );
    equipment_utility::function_19ac700f043604( weaponref, #"hash_f757078747615c42", @"hash_6eb6ba9e7ce00943", bundle.var_2a0026d3391d0669, 0.6 );
    equipment_utility::function_19ac700f043604( weaponref, #"fuse_timer", @"bunkerbuster_fuse_timer", bundle.fuse_timer, 1 );
    equipment_utility::function_19ac700f043604( weaponref, #"round_burst_time", @"hash_b75d73bdceff168f", bundle.round_burst_time, 0.5 );
    
    if ( !isdefined( level.bunkerbuster_params ) )
    {
        level.bunkerbuster_params = [];
    }
    
    if ( !isdefined( level.bunkerbuster_params[ weaponref ] ) )
    {
        level.bunkerbuster_params[ weaponref ] = spawnstruct();
    }
    
    params = level.bunkerbuster_params[ weaponref ];
    params.var_ffede5929d4960cc = bundle.var_ffede5929d4960cc ?? 200;
    params.explosion_offset = bundle.explosion_offset ?? 8;
    params.fuse_timer_vehicle_stuck = bundle.fuse_timer_vehicle_stuck ?? 3;
    params.fuse_timer_character_stuck = bundle.fuse_timer_player_stuck ?? 1.5;
    assert( isdefined( bundle.var_fbb1de3d23080f97 ), "<dev string:x81>" );
    assert( isdefined( bundle.var_ed39a593cd6faa6e ), "<dev string:xb0>" );
    params.burrowed_model_name = bundle.var_fbb1de3d23080f97;
    params.round_weapon_name = bundle.var_ed39a593cd6faa6e;
}

// Namespace bunkerbuster
// Params 1
// Checksum 0x40371241, Offset: 0xae4
// Size: 0xf5
function used( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"explode" );
    grenade endon( #"death" );
    function_fc5314bb16dadbc1( grenade );
    grenade thread watchdisowned();
    grenade thread monitordeath();
    grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &emp_applied, undefined, undefined );
    
    if ( level.var_36218e71baa7e689 )
    {
        grenade.var_c5ccf9dff3b5e393 = &emp_applied;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = grenade;
    }
    
    if ( isdefined( grenade.stuckdata ) )
    {
        stuckdata = grenade.stuckdata;
    }
    else
    {
        stuckdata = grenade equipment_mp::function_ea51ae6c8436d3cd();
    }
    
    utility::function_969f9f5596dba07a( grenade, &on_crushed );
    handlestuck( grenade, stuckdata );
}

// Namespace bunkerbuster
// Params 0
// Checksum 0x94f21659, Offset: 0xbe1
// Size: 0x20
function on_crushed()
{
    destroy( 1, 0 );
    
    if ( isdefined( self ) && self islinked() )
    {
        self unlink();
    }
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x26972173, Offset: 0xc09
// Size: 0x253
function private handlestuck( grenade, stuckdata )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_object.basenamehash );
    
    if ( isdefined( bundle.var_e3bdf2afe4da740 ) )
    {
        grenade.origin += anglestoup( grenade.angles ) * bundle.var_e3bdf2afe4da740;
    }
    
    var_fc9829fd02078b92 = equipment_utility::function_ba332b3b54d2a9c4( grenade.weapon_name, #"hash_cc1222273c597c90" );
    wait var_fc9829fd02078b92;
    grenade setscriptablepartstate( #"effects", #"plant", 0 );
    stuckto = stuckdata.stuckto;
    isunderwater = stuckdata.isunderwater;
    grenade thread watchgameended();
    
    if ( isunderwater )
    {
        underwater( grenade );
        return;
    }
    
    if ( isdefined( stuckto ) )
    {
        if ( !isplayer( stuckto ) )
        {
            if ( isagent( stuckto ) )
            {
                ai::function_9b5d55d642edff87( grenade, stuckto );
            }
            
            grenade childthread equipment_mp::function_2c8f51009c3dd68f( stuckto, &destroy, 0 );
        }
        
        grenade.stuckto = stuckto;
        
        if ( isplayer( stuckto ) || isagent( stuckto ) && !stuckto.ishostage )
        {
            characterstuck( grenade, stuckto, istrue( grenade.riotshieldhit ) );
        }
        else if ( stuckto.classname == "grenade" || stuckto.classname == "misc_turret" || stuckto.classname == "scriptable" || stuckto.ishostage )
        {
            miscstuck( grenade );
        }
        else if ( stuckto.classname == "script_vehicle" )
        {
            vehicledig( grenade, stuckto );
        }
        else
        {
            grenade thread function_6e7ca2abbe1dd0e6();
            surfacedig( grenade );
        }
        
        return;
    }
    
    grenade thread function_6e7ca2abbe1dd0e6();
    surfacedig( grenade );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x4b6062d5, Offset: 0xe64
// Size: 0x31
function private underwater( grenade )
{
    grenadestate = "dig_fail";
    function_82033037bd9f2284( grenade, grenadestate );
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x913b6513, Offset: 0xe9d
// Size: 0x31
function private miscstuck( grenade )
{
    grenadestate = "dig_fail";
    function_82033037bd9f2284( grenade, grenadestate );
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 3, eflags: 0x4
// Checksum 0x618c74e1, Offset: 0xed6
// Size: 0x5e
function private characterstuck( grenade, stuckto, hasriotshield )
{
    grenade.owner thread gamelogic_mp::threadedsetweaponstatbyname( grenade.weapon_object, 1, "special_hits" );
    
    if ( hasriotshield )
    {
        function_3bf221df595178c( grenade, stuckto );
        return;
    }
    
    function_abd07bcd46314050( grenade, stuckto );
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x2626ea56, Offset: 0xf3c
// Size: 0xb0
function private function_3bf221df595178c( grenade, stuckto )
{
    victim = stuckto;
    grenadestate = "dig_success";
    fwdvec = anglestoup( grenade.angles ) * -1;
    offsetunits = equipment_utility::function_ba332b3b54d2a9c4( grenade.weapon_name, #"riot_shield_offset" );
    offset = fwdvec * offsetunits;
    function_82033037bd9f2284( grenade, grenadestate, offset, fwdvec );
    
    if ( !grenade.var_caf8ecadb8b4bebe )
    {
        weapons::grenadestuckto( grenade, victim );
    }
    
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x445b0110, Offset: 0xff4
// Size: 0x81
function private function_abd07bcd46314050( grenade, stuckto )
{
    victim = stuckto;
    grenadestate = "character_stuck";
    var_7f3fdce4d25dd061 = weapon_utility::function_7f3fdce4d25dd061( grenade );
    weapons::grenadestuckto( grenade, victim, 0, var_7f3fdce4d25dd061 );
    function_82033037bd9f2284( grenade, grenadestate );
    
    if ( isdefined( victim ) )
    {
        weapons::grenadestuckto( grenade, victim, 1 );
        victim childthread function_da6da7df14efd244( grenade );
    }
    
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0xa40563c9, Offset: 0x107d
// Size: 0xd1
function private function_da6da7df14efd244( grenade )
{
    weapref = grenade.weapon_name;
    var_4c9d59d7b1e2db8a = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"hash_4f2f60d1d1a21c2f" );
    numticks = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"character_stuck_num_ticks" );
    maxtime = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"hash_f757078747615c42" );
    self playlocalsound( "eqp_bunkerbuster_drill_npc" );
    
    for ( curticks = 0; curticks < numticks ; curticks++ )
    {
        self dodamage( var_4c9d59d7b1e2db8a, grenade.origin, grenade.owner, grenade, "MOD_BLEEDOUT", grenade.weapon_object, "torso_upper" );
        wait maxtime / numticks;
    }
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0xf4116cc1, Offset: 0x1156
// Size: 0x996
function private surfacedig( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    weapref = grenade.weapon_name;
    upvec = anglestoup( grenade.angles );
    var_71fc6be57dab260a = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"burrow_offset" );
    offset = var_71fc6be57dab260a;
    ignorearray = [ grenade ];
    
    if ( isdefined( grenade.glgrenade ) )
    {
        ignorearray[ ignorearray.size ] = grenade.glgrenade;
    }
    
    var_fd98cc64cf588635 = upvec * -1;
    var_e74d998f05ab62f4 = vectornormalize( vectorcross( var_fd98cc64cf588635, ( 0, 0, 1 ) ) );
    var_8aaa9c8e1d52b0d8 = grenade.bundle.var_1f3b1aeabd70d392;
    var_b47e72e0d309dd6b = 32;
    var_5dbee09bef289d60 = 8;
    var_e02a9a6235f7735f = var_b47e72e0d309dd6b * var_fd98cc64cf588635;
    var_6ddb0ce56ff8542d = var_5dbee09bef289d60 * var_e74d998f05ab62f4;
    var_ef6b4a0d0f1ba487 = var_fd98cc64cf588635 * 0.24;
    var_30cbb231d5dbab4a = var_fd98cc64cf588635 * 5;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, !grenade.bundle.var_64f595ec1c7a35c9, 0, 0 );
    var_bbaa9006aeef8092 = grenade.origin;
    var_4c2b74cad96380e0 = var_bbaa9006aeef8092;
    surfacenormal = anglestoup( grenade.angles );
    var_f5bca36ff7f71085 = 0;
    var_c239eb77adf611f4 = level.bunkerbuster_params[ weapref ].var_ffede5929d4960cc;
    var_75ea007b72bcd2f3 = vectordot( surfacenormal, ( 0, 0, 1 ) ) > -0.707 && vectordot( surfacenormal, ( 0, 0, 1 ) ) <= 0.707;
    var_deba9c557a966064 = grenade.bundle.var_b3db7fe6979950dc;
    
    while ( offset <= var_c239eb77adf611f4 )
    {
        tracebackoffset = var_fd98cc64cf588635 * offset;
        endorigin = grenade.origin + tracebackoffset;
        traceback = trace::ray_trace( endorigin, var_bbaa9006aeef8092, ignorearray, tracecontents, 1 );
        
        if ( traceback[ "hittype" ] != "hittype_none" )
        {
            var_e585abe4c0c66fd4 = traceback[ "position" ];
            
            if ( var_75ea007b72bcd2f3 && var_deba9c557a966064 )
            {
                closestnavmeshpoint = utility::function_5918594658d3ffba( endorigin, 0, undefined, 2000 );
                
                if ( !isdefined( closestnavmeshpoint ) )
                {
                    /#
                        level thread utility::draw_line_for_time( endorigin, var_bbaa9006aeef8092, 1, 0, 0, 100 );
                    #/
                    
                    offset += length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
                
                tracepos = var_e585abe4c0c66fd4 + traceback[ "normal" ] * 2;
                trace = trace::ray_trace( closestnavmeshpoint, tracepos, ignorearray, tracecontents, 1 );
                
                /#
                    level thread utility::draw_line_for_time( closestnavmeshpoint, tracepos, 0, 0, 0, 100 );
                #/
                
                if ( trace[ "hittype" ] != "hittype_none" && trace[ "fraction" ] < 0.7 )
                {
                    /#
                        level thread debug_utility::drawsphere( trace[ "<dev string:xdd>" ], 2, 100, ( 1, 0, 0 ) );
                        level thread debug_utility::drawsphere( trace[ "<dev string:xdd>" ], 2, 100, ( 0, 0, 1 ) );
                        level thread debug_utility::drawsphere( trace[ "<dev string:xdd>" ], 2, 100, ( 1, 0, 0 ) );
                    #/
                    
                    offset += length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
            }
            
            if ( var_8aaa9c8e1d52b0d8 )
            {
                var_bab36b86cf8b2701 = trace::ray_trace( var_e585abe4c0c66fd4 - var_ef6b4a0d0f1ba487, var_e585abe4c0c66fd4 + var_e02a9a6235f7735f, ignorearray, tracecontents, 1 );
                
                if ( var_bab36b86cf8b2701[ "hittype" ] != "hittype_none" )
                {
                    var_bbaa9006aeef8092 = var_bab36b86cf8b2701[ "position" ] + var_ef6b4a0d0f1ba487;
                    offset = length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
                
                additionaltraceback = trace::ray_trace( var_e585abe4c0c66fd4 + var_e02a9a6235f7735f, var_e585abe4c0c66fd4 + var_ef6b4a0d0f1ba487, ignorearray, tracecontents, 1 );
                
                if ( additionaltraceback[ "hittype" ] != "hittype_none" )
                {
                    var_bbaa9006aeef8092 = additionaltraceback[ "position" ] - var_ef6b4a0d0f1ba487;
                    offset = length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
                
                /#
                    if ( getdvarint( @"scr_bunkerbuster_debug", 0 ) )
                    {
                        utility::draw_capsule( var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a + var_6ddb0ce56ff8542d, 5, 5, undefined, ( 1, 0, 0 ), undefined, 1000 );
                        utility::draw_capsule( var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a - var_6ddb0ce56ff8542d, 5, 5, undefined, ( 1, 1, 0 ), undefined, 1000 );
                    }
                #/
                
                var_1fb13f91d253cb66 = trace::ray_trace( var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a + var_6ddb0ce56ff8542d, var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a, ignorearray, tracecontents, 1 );
                
                if ( var_1fb13f91d253cb66[ "hittype" ] != "hittype_none" )
                {
                    var_bbaa9006aeef8092 = var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a;
                    offset = length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
                
                var_d856e8f28aabb5ed = trace::ray_trace( var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a - var_6ddb0ce56ff8542d, var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a, ignorearray, tracecontents, 1 );
                
                if ( var_d856e8f28aabb5ed[ "hittype" ] != "hittype_none" )
                {
                    var_bbaa9006aeef8092 = var_e585abe4c0c66fd4 + var_30cbb231d5dbab4a;
                    offset = length( var_bbaa9006aeef8092 - grenade.origin ) + var_71fc6be57dab260a;
                    continue;
                }
            }
            
            if ( grenade.bundle.var_5180afd79f75e3d9 )
            {
                var_c65abeaaea1eb625 = 30;
                var_951e3b60f0bb4e76 = ( 0, 0, -1 );
                
                if ( vectordot( var_951e3b60f0bb4e76, var_fd98cc64cf588635 ) > cos( var_c65abeaaea1eb625 ) )
                {
                    var_4b3d0f38dc06ac68 = 8000;
                    var_419b67aac73011a8 = trace::ray_trace( var_e585abe4c0c66fd4, var_e585abe4c0c66fd4 + var_951e3b60f0bb4e76 * var_4b3d0f38dc06ac68, ignorearray, tracecontents, 1 );
                    
                    if ( var_419b67aac73011a8[ "hittype" ] == "hittype_none" )
                    {
                        var_f5bca36ff7f71085 = 0;
                        break;
                    }
                }
            }
            
            var_f5bca36ff7f71085 = 1;
            var_4c2b74cad96380e0 = var_e585abe4c0c66fd4 - grenade.origin;
            surfacenormal = vectornormalize( var_e585abe4c0c66fd4 - grenade.origin );
            
            /#
                if ( getdvarint( @"scr_bunkerbuster_debug", 0 ) )
                {
                    level thread utility::draw_line_for_time( var_4c2b74cad96380e0 + grenade.origin, grenade.origin, 1, 0, 0, 100 );
                }
            #/
            
            break;
        }
        
        offset += var_71fc6be57dab260a;
    }
    
    if ( var_f5bca36ff7f71085 )
    {
        var_f5bca36ff7f71085 = function_72b7866a662142c3( grenade, var_4c2b74cad96380e0, surfacenormal );
    }
    
    worldup = anglestoup( self getworldupreferenceangles() );
    grenadeup = anglestoup( grenade.angles );
    dotresult = vectordot( vectornormalize( worldup ), vectornormalize( grenadeup ) );
    grenade.var_ae56ff01670735f = dotresult >= -0.5 && dotresult <= 0.5;
    
    if ( dotresult >= -0.1 && dotresult <= 0.1 )
    {
        grenade.surfaceorientation = "wall";
    }
    else if ( dotresult > 0.9 && dotresult <= 1 )
    {
        grenade.surfaceorientation = "floor";
    }
    else if ( dotresult < -0.9 && dotresult >= -1 )
    {
        grenade.surfaceorientation = "ceiling";
    }
    else
    {
        grenade.surfaceorientation = "other";
    }
    
    grenadestate = var_f5bca36ff7f71085 ? "dig_success" : "dig_fail";
    function_82033037bd9f2284( grenade, grenadestate, var_4c2b74cad96380e0, surfacenormal );
    var_255353f280022bf9 = getdvarfloat( @"hash_dcc19c96af625740", 0 );
    wait var_255353f280022bf9;
    
    if ( var_f5bca36ff7f71085 )
    {
        var_582d55b3e4561c63 = 0;
        killcamorigin = undefined;
        horizontaloffset = var_e74d998f05ab62f4 * 100;
        
        for ( i = 0; i < 12 && !var_582d55b3e4561c63 ; i++ )
        {
            tracecontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0 );
            traceorigin = var_e585abe4c0c66fd4 + var_fd98cc64cf588635 * ( 200 - i % 3 * 50 ) + ( i < 6 ? ( 0, 0, 0 ) : ( 0, 0, -50 ) ) + horizontaloffset * ( i % 6 < 3 ? 1 : -1 );
            raytrace = trace::ray_trace( traceorigin, var_e585abe4c0c66fd4, undefined, tracecontents );
            
            if ( raytrace[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
            
            killcamorigin = traceorigin;
            var_582d55b3e4561c63 = 1;
        }
        
        if ( isdefined( killcamorigin ) )
        {
            killcament = spawn( "script_model", killcamorigin );
            killcament setmodel( "tag_origin" );
            grenade.killcament = killcament;
        }
        
        function_d246427ac87f501e( grenade, var_4c2b74cad96380e0, surfacenormal );
    }
    else
    {
        killcament = spawn( "script_model", grenade.origin + ( 0, 0, 30 ) );
        killcament setmodel( "tag_origin" );
        killcament linkto( grenade );
        killcament setscriptmoverkillcam( "offset explosive", 30, 120 );
        grenade.killcament = killcament;
    }
    
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 5, eflags: 0x4
// Checksum 0xb36410d6, Offset: 0x1af4
// Size: 0x213
function private function_82033037bd9f2284( grenade, digstate, spawnoffset, referencevec, var_4c8f7d3da135e81 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    spawnpoint = grenade.origin;
    
    if ( isdefined( spawnoffset ) )
    {
        spawnpoint = spawnoffset + grenade.origin;
    }
    
    if ( !isdefined( referencevec ) )
    {
        referencevec = anglestoforward( grenade.angles );
    }
    
    if ( digstate == "dig_fail" )
    {
        effectsent = utility::spawn_script_origin( spawnpoint, grenade.angles );
        effectsent.var_be6e8f5c5d18acc = 1;
        grenade.effectsent = effectsent;
        grenade setscriptablepartstate( #"effects", #"hash_22fcd1168b964b59", 0 );
        grenade setscriptablepartstate( #"danger-icon", #"on", 0 );
        return;
    }
    
    effectsent = spawn( "script_model", spawnpoint );
    effectsent.var_be6e8f5c5d18acc = 1;
    effectsent.angles = vectortoangles( referencevec );
    effectsent setmodel( level.bunkerbuster_params[ grenade.weapon_name ].burrowed_model_name );
    effectsent linkto( grenade );
    grenade.effectsent = effectsent;
    
    if ( digstate == "character_stuck" && isdismembermentenabled() && !var_4c8f7d3da135e81 )
    {
        grenade setscriptablepartstate( #"effects", #"hash_4e2bd5c955e4cf99", 0 );
        return;
    }
    
    grenade setscriptablepartstate( #"effects", #"hash_b04371758cf73ff4", 0 );
    var_85ce8f0dcb898163 = getdvarfloat( @"hash_dd3f674055086845", 0.75 );
    wait var_85ce8f0dcb898163;
    effectsent setscriptablepartstate( #"thermal_lance", #"active", 0 );
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0xceb6a2e2, Offset: 0x1d0f
// Size: 0xd9
function private waitdetonate( grenade, grenadestate )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"explode" );
    grenade endon( #"death" );
    weapref = grenade.weapon_name;
    bunkerbuster_params = level.bunkerbuster_params[ weapref ];
    burrowtime = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"fuse_timer" );
    
    if ( grenadestate == "vehicle_stuck" )
    {
        burrowtime = bunkerbuster_params.fuse_timer_vehicle_stuck;
    }
    
    if ( grenadestate == "player_stuck" )
    {
        burrowtime = bunkerbuster_params.fuse_timer_character_stuck;
    }
    
    wait getdvarfloat( @"hash_4e0c2a5ace3abb90", burrowtime );
    _detonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x51bcf765, Offset: 0x1df0
// Size: 0x5a
function private vehicledig( grenade, vehicle )
{
    weapon_utility::function_b2f98346d4b4da5( vehicle, self.team );
    grenadestate = "vehicle_stuck";
    grenade.vehicleent = vehicle;
    function_82033037bd9f2284( grenade, grenadestate );
    waitdetonate( grenade, grenadestate );
}

// Namespace bunkerbuster
// Params 3, eflags: 0x4
// Checksum 0xc0cd5d49, Offset: 0x1e52
// Size: 0xd9
function private function_d246427ac87f501e( grenade, spawnoffset, surfacenormal )
{
    spawnpoint = grenade.origin;
    
    if ( isdefined( spawnoffset ) )
    {
        spawnpoint += spawnoffset;
    }
    
    /#
        if ( getdvarint( @"scr_bunkerbuster_debug", 0 ) )
        {
            level thread utility::draw_angles( grenade.effectsent.angles, grenade.effectsent.origin, ( 1, 0, 0 ), 1000, 20 );
        }
    #/
    
    grenade setscriptablepartstate( #"effects", #"hash_b04371758cf73ff4", 0 );
    grenade.effectsent setscriptablepartstate( #"danger-icon", #"on", 0 );
}

// Namespace bunkerbuster
// Params 3, eflags: 0x4
// Checksum 0xad5ece3d, Offset: 0x1f33
// Size: 0x81
function private function_72b7866a662142c3( grenade, burrowoffset, surfacevec )
{
    offset = getdvarint( @"hash_8feb82dd51a5a0c2", 25 );
    burrowpoint = burrowoffset + grenade.origin;
    burrowpoint += surfacevec * offset;
    isoob = outofbounds::ispointinoutofbounds( burrowpoint, self.team );
    
    if ( isoob )
    {
        return 0;
    }
    
    return 1;
}

// Namespace bunkerbuster
// Params 2
// Checksum 0xd22930bd, Offset: 0x1fbc
// Size: 0x533
function _detonate( grenade, grenadestate )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    weapref = grenade.weapon_name;
    bunkerbuster_params = level.bunkerbuster_params[ weapref ];
    stuckto = grenade.stuckto;
    
    if ( isdefined( stuckto ) && ( grenadestate == "vehicle_stuck" || grenadestate == "character_stuck" ) )
    {
        function_778348405760767f( grenade );
    }
    else if ( grenadestate == "dig_success" )
    {
        var_cb3a743c62872d8a = grenade.effectsent.angles;
        var_e8265b465ca696f1 = grenade.effectsent.origin;
        velocityvec = ( 0, 0, 0 );
        roundspawnorigin = var_e8265b465ca696f1 + anglestoup( grenade.angles ) * -1 * bunkerbuster_params.explosion_offset;
        var_2769371b99dc7ac7 = isdefined( grenade.riotshieldvictim ) && grenade.riotshieldvictim riotshield::riotshield_hasweapon();
        
        if ( var_2769371b99dc7ac7 )
        {
            roundspawnorigin = grenade.riotshieldvictim gettagorigin( "j_spine4" );
        }
        else
        {
            velocityvec += anglestoforward( var_cb3a743c62872d8a ) * getdvarint( @"hash_8766c486f2519ffb", 300 );
            
            if ( grenade.var_ae56ff01670735f )
            {
                velocityvec += anglestoup( var_cb3a743c62872d8a ) * getdvarint( @"hash_6bffd30022e9bcab", 0 ) * -1;
            }
            
            velocityvec += function_36cd00eb5990c564();
        }
        
        weapon_object = namespace_de7b719e85d98dcc::function_59f0aef415632a71( grenade, "explosiveRoundWeapon" ) ?? weapon_utility::function_d2c8356dc369d9ce( bunkerbuster_params.round_weapon_name );
        grenade.explodingent = weapon::_launchgrenade( weapon_object, roundspawnorigin, velocityvec, 100, 1 );
        grenade.explodingent.weapon_object = weapon_object;
        weapons::grenadeinitialize( grenade.explodingent, grenade.explodingent.weapon_object );
        grenade.explodingent namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade.explodingent, &function_d34c517263178c70, undefined, undefined );
        grenade.explodingent.glgrenadeparent = grenade.glgrenadeparent;
        grenade.explodingent.angles = var_cb3a743c62872d8a;
        grenade.explodingent setscriptablepartstate( #"shoot", #"shoot", 0 );
        grenade setscriptablepartstate( #"effects", #"shoot", 0 );
        grenade.explodingent.var_cad106e30bb98d88 = 1;
        grenade.explodingent.surfaceorientation = grenade.surfaceorientation;
        grenade.explodingent setscriptablepartstate( #"danger-icon", #"on", 0 );
        
        if ( isdefined( grenade.effectsent ) )
        {
            grenade.effectsent setscriptablepartstate( #"danger-icon", #"off", 0 );
        }
        
        if ( isdefined( grenade.killcament ) )
        {
            grenade.explodingent.killcament = grenade.killcament;
        }
        
        if ( var_2769371b99dc7ac7 )
        {
            weapons::grenadestuckto( grenade.explodingent, grenade.riotshieldvictim, 1 );
        }
        
        grenade.explodingent.angles = var_cb3a743c62872d8a;
        grenade.explodingent setscriptablepartstate( #"shoot", #"shoot", 0 );
        grenade setscriptablepartstate( #"effects", #"shoot", 0 );
        bursttime = equipment_utility::function_ba332b3b54d2a9c4( weapref, #"round_burst_time" );
        grenade.explodingent utility::waittill_any_timeout( bursttime, "missile_stuck" );
        
        if ( isdefined( grenade.explodingent ) )
        {
            grenade.explodingent setscriptablepartstate( #"shoot", #"explode", 0 );
        }
    }
    else
    {
        grenade setscriptablepartstate( #"effects", #"explode_drill_fail", 0 );
    }
    
    wait 0.1;
    
    if ( isdefined( grenade.explodingent ) )
    {
        grenade.explodingent.detonated = 1;
        grenade.explodingent detonate();
        
        if ( isdefined( grenade.glgrenadeparent ) )
        {
            self.var_41d1470f095bbfc8 = grenade.glgrenadeparent;
            thread clearlastusedgl();
        }
    }
    
    grenade thread destroy( 0, grenadestate == "dig_success" ? 1 : 0 );
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x26235b84, Offset: 0x24f7
// Size: 0x61
function private function_778348405760767f( grenade )
{
    stuckto = grenade.stuckto;
    
    if ( stuckto.classname == "script_vehicle" )
    {
        function_614ada8c91bb9dfb( grenade, stuckto );
        return;
    }
    
    if ( isplayer( stuckto ) || isagent( stuckto ) )
    {
        function_10fefe0472ada352( grenade, stuckto );
    }
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0xe9ec20a9, Offset: 0x2560
// Size: 0x6e
function private function_36cd00eb5990c564()
{
    returnvec = ( 0, 0, 0 );
    movingplatform = self getmovingplatformparent();
    
    if ( isdefined( movingplatform ) )
    {
        velvec = movingplatform.velocity;
        
        if ( !isdefined( velvec ) && movingplatform vehicle::is_vehicle() )
        {
            velvec = movingplatform vehicle_getvelocity();
        }
        
        if ( isdefined( velvec ) )
        {
            returnvec += velvec;
        }
    }
    
    return returnvec;
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x4313fb7d, Offset: 0x25d7
// Size: 0x181
function private function_614ada8c91bb9dfb( grenade, vehicle )
{
    if ( isdefined( vehicle ) )
    {
        grenade.effectsent setscriptablepartstate( #"thermal_lance", #"neutral", 0 );
        weapon_utility::function_83acd124c7845a3e( vehicle, self.team );
        var_8d125612181e965 = vehicle.health / vehicle.maxhealth;
        
        if ( !vehicle::function_977daeae4e2f0e30( vehicle, self.team ) && vehicle::has_data( vehicle vehicle::get_ref() ) && vehicle vehicle_damage::get_state() == "heavy" )
        {
            if ( isdefined( vehicle_damage::get_data( vehicle vehicle::get_ref() ) ) )
            {
                vehicleweaponname = vehicle_damage::get_weapon_string( vehicle vehicle::get_ref() );
                
                if ( isdefined( vehicleweaponname ) )
                {
                    damagedata = spawnstruct();
                    damagedata.inflictor = vehicle;
                    damagedata.objweapon = makeweapon( vehicleweaponname );
                    damagedata.meansofdeath = "MOD_EXPLOSIVE";
                    damagedata.attacker = grenade.owner;
                    damagedata.objweapon = makeweapon( vehicleweaponname );
                    exitdata = { #nocorpse:1 };
                    vehicle vehicle_occupancy::kill_occupants( vehicle, damagedata, exitdata );
                }
            }
        }
    }
    
    grenade setscriptablepartstate( #"effects", #"explode_vehicle", 0 );
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x492799c9, Offset: 0x2760
// Size: 0x5d
function private function_10fefe0472ada352( grenade, player )
{
    if ( isdismembermentenabled() || isagent( player ) )
    {
        grenade setscriptablepartstate( #"effects", #"hash_a4c5da136fbb9439", 0 );
        return;
    }
    
    grenade setscriptablepartstate( #"effects", #"explode_drill_fail", 0 );
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0xd432808d, Offset: 0x27c5
// Size: 0x40
function private watchdisowned()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self.owner utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    thread destroy();
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0xd82cb769, Offset: 0x280d
// Size: 0x41
function private watchgameended()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.effectsent ) )
        {
            self.effectsent delete();
        }
        
        self delete();
    }
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0x16d094ee, Offset: 0x2856
// Size: 0x17f
function private function_6e7ca2abbe1dd0e6()
{
    level endon( #"start_game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    var_2048085c1ad8861 = 30;
    var_5cbee90934d28905 = var_2048085c1ad8861 * var_2048085c1ad8861;
    var_aa7e5239d0e0fd3c = 150;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( self.origin, player.origin ) < var_5cbee90934d28905 && abs( self.origin[ 2 ] - player.origin[ 2 ] ) <= var_aa7e5239d0e0fd3c / 2 && vectordot( vectornormalize( player.origin - self.origin ), anglestoup( self.angles ) ) > 0 )
            {
                player dodamage( 1, self.origin, self, self.owner, "MOD_TRIGGER_HURT", self.weapon_object, "none", undefined, 65536 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace bunkerbuster
// Params 2
// Checksum 0x497efa7e, Offset: 0x29dd
// Size: 0xc1
function destroy( immediate, var_f5bca36ff7f71085 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"explode" );
    
    if ( !isdefined( self ) || self.exploding )
    {
        return;
    }
    
    self.exploding = 1;
    
    if ( var_f5bca36ff7f71085 )
    {
        var_135139249ff54607 = getdvarfloat( @"hash_a72d28a8eef62114", 0.5 );
        wait var_135139249ff54607;
    }
    else
    {
        function_d56c373baa0a05d7();
        self detonate();
        return;
    }
    
    self setscriptablepartstate( #"effects", #"destroy", 0 );
    
    if ( !immediate )
    {
        wait 0.25;
    }
    
    function_d56c373baa0a05d7();
    self delete();
}

// Namespace bunkerbuster
// Params 0
// Checksum 0xd1047c45, Offset: 0x2aa6
// Size: 0x9
function dronegun_emp()
{
    thread destroy();
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0xf7651bf7, Offset: 0x2ab7
// Size: 0x2e
function private monitordeath()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self waittill( #"death" );
    function_d56c373baa0a05d7();
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0x97a680d8, Offset: 0x2aed
// Size: 0xa5
function private function_d56c373baa0a05d7()
{
    if ( self.killcament )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.effectsent ) )
    {
        bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_object.basenamehash );
        
        if ( bundle.var_25b1481ad53e4316 > 0 )
        {
            self.effectsent thread function_e2b30cceb2ada19f( bundle.var_25b1481ad53e4316 );
        }
        else
        {
            self.effectsent delete();
        }
    }
    
    if ( isdefined( self.staticlink ) )
    {
        self.staticlink delete();
    }
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x8b756125, Offset: 0x2b9a
// Size: 0x21
function private function_e2b30cceb2ada19f( delay )
{
    level endon( #"game_ended" );
    wait delay;
    self delete();
}

// Namespace bunkerbuster
// Params 1
// Checksum 0x6cd6a8e5, Offset: 0x2bc3
// Size: 0x83
function on_player_damaged( data )
{
    grenade = data.inflictor;
    victim = data.victim;
    
    if ( data.meansofdeath == "MOD_IMPACT" && data.hitloc == "shield" )
    {
        grenade.riotshieldhit = 1;
        
        if ( isdefined( victim ) )
        {
            grenade.riotshieldvictim = victim;
        }
    }
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0x6e79c161, Offset: 0x2c4e
// Size: 0x49
function private function_d164551305416c10( glgrenade, stuckdata )
{
    self endon( #"hash_aa0f957df202266c" );
    glgrenade waittill( #"hash_c167e145cfc24a47", scriptablereturned );
    stuckdata.var_4ca36b89aa230d40 = scriptablereturned;
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0xbddda950, Offset: 0x2c9f
// Size: 0x3d
function private monitorunderwater( glgrenade, stuckdata )
{
    self endon( #"hash_aa0f957df202266c" );
    glgrenade waittill( #"missile_water_impact" );
    stuckdata.isunderwater = 1;
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0x39f3dae3, Offset: 0x2ce4
// Size: 0x41
function private watchunlink()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    self waittill( #"unlinkgrenade" );
    
    if ( self islinked() )
    {
        self unlink();
    }
}

// Namespace bunkerbuster
// Params 1, eflags: 0x4
// Checksum 0x7e06c341, Offset: 0x2d2d
// Size: 0x46
function private function_299398447facbe9a( stuckto )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    
    while ( isdefined( stuckto ) )
    {
        waitframe();
    }
    
    self notify( #"unlinkgrenade" );
}

// Namespace bunkerbuster
// Params 0, eflags: 0x4
// Checksum 0xa3b791d7, Offset: 0x2d7b
// Size: 0xe8
function private function_b03adef181897f38()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    
    if ( isdefined( self.stuckdata ) && isdefined( self.stuckdata.var_4ca36b89aa230d40 ) && self.stuckdata.var_4ca36b89aa230d40 scriptableisdoor() )
    {
        var_5e216732175e8f7d = self.stuckdata.var_4ca36b89aa230d40 scriptabledoorangle();
        
        while ( true )
        {
            wait 0.1;
            
            if ( !isdefined( self.stuckdata.var_4ca36b89aa230d40 ) )
            {
                break;
            }
            
            doordegrees = self.stuckdata.var_4ca36b89aa230d40 scriptabledoorangle();
            
            if ( doordegrees != var_5e216732175e8f7d )
            {
                break;
            }
        }
        
        self notify( #"unlinkgrenade" );
    }
}

// Namespace bunkerbuster
// Params 2, eflags: 0x4
// Checksum 0xd1054ebe, Offset: 0x2e6b
// Size: 0x43, Type: bool
function private shouldlink( stuckto, stuckpart )
{
    if ( stuckto.code_classname == "scriptable" )
    {
        return false;
    }
    
    if ( stuckto.targetname == "dropped_weapon" )
    {
        return false;
    }
    
    return true;
}

// Namespace bunkerbuster
// Params 0, eflags: 0xc
// Checksum 0x7a55f6f1, Offset: 0x2eb7
// Size: 0x33
function private clearlastusedgl()
{
    self notify( #"hash_cc52e6a5ff61ac0d" );
    self endon( #"hash_cc52e6a5ff61ac0d" );
    self endon( #"disconnect" );
    wait 1;
    self.var_41d1470f095bbfc8 = undefined;
}

// Namespace bunkerbuster
// Params 1
// Checksum 0x4728ae3b, Offset: 0x2ef2
// Size: 0x21, Type: bool
function isbunkerbuster( weapon )
{
    return weapon.var_5e3a1c87edc1edd5 == #"bunkerbuster";
}

// Namespace bunkerbuster
// Params 1
// Checksum 0xfb08830f, Offset: 0x2f1c
// Size: 0x21, Type: bool
function isbunkerbustergl( weapon )
{
    return weapon.var_5e3a1c87edc1edd5 == #"bunkerbuster_grenade_launcher";
}

