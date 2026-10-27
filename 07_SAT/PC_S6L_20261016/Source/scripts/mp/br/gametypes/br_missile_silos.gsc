// scripts\mp\br\gametypes\br_missile_silos.gsc  (hash_30f7130e30d1d913.gscc) (size: 13756 Bytes / 0x35bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bf80e80 (1006112384)
// size ...... 13756 (0x35bc)
// includes .. 10  (offset: 0x32f8)
// strings ... 32  (offset: 0x3348)
// dev strs .. 13  (offset: 0x3520)
// exports ... 43  (offset: 0x1e50)
// cseg ...... 0x283 + 0x1bcd (0x1e50)
// imports ... 119 (offset: 0x2508)
// animtree1 . 0   (offset: 0x35bc)
// animtree2 . 0   (offset: 0x35bc)
#using script_209a67eebb325da8;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\structspawnconfig;

#namespace br_missile_silos;

// Namespace br_missile_silos
// Params 0
// Checksum 0xfc2e8004, Offset: 0x2a1
// Size: 0x211
function main()
{
    waitframe();
    
    if ( !getdvarint( @"hash_9d28618b108b5283", 0 ) )
    {
        return;
    }
    
    level.var_6378577eed3fcc4e = spawnstruct();
    level.var_6378577eed3fcc4e.silos = [];
    level.var_6378577eed3fcc4e.var_d40f24fc292df33d = getdvarint( @"hash_faa9c468afb332af", 1 );
    level.var_6378577eed3fcc4e.capturetype = getdvarint( @"hash_e45819dc2ceb297e", 0 );
    level.var_6378577eed3fcc4e.capturetime = getdvarfloat( @"hash_aae48d9633d43c5", 20 );
    level.var_6378577eed3fcc4e.var_8fb6eb7a73d5c9c9 = getdvarint( @"hash_de2821e1e8645670", 1 );
    level.var_6378577eed3fcc4e.var_2228372d171736fc = getdvarint( @"hash_77140a057cf0a92b", 0 );
    level.var_6378577eed3fcc4e.var_5bc3cc713df6dc0 = getdvarint( @"hash_417f6b4e942f227f", 0 );
    level.var_6378577eed3fcc4e.siloscaptured = 0;
    function_8d9a04d510d29496();
    
    if ( getdvarint( @"hash_f6d437ee9daa50b8", 0 ) && getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        structspawnconfig::function_7418a260adaec05( "missile_silo", &function_6b91211f833df2e6 );
        structspawnconfig::function_8c0a09968efe9138( "missile_silo", &function_975b15ffccb5a56 );
    }
    else
    {
        var_20f81d0096ec6499 = function_6b91211f833df2e6( "missile_silo" );
        
        if ( isdefined( var_20f81d0096ec6499 ) )
        {
            foreach ( var_ef261b541f302a70 in var_20f81d0096ec6499 )
            {
                missilesilo = function_975b15ffccb5a56( "missile_silo", var_ef261b541f302a70 );
            }
        }
    }
    
    /#
        debuginit();
    #/
}

// Namespace br_missile_silos
// Params 0, eflags: 0x4
// Checksum 0x3295ed31, Offset: 0x4ba
// Size: 0x2e4
function private function_8d9a04d510d29496()
{
    if ( level.mapname == "mp_br_mechanics" )
    {
        tempstruct = spawnstruct();
        tempstruct.targetname = "missile_silo";
        tempstruct.origin = ( 3400, -3200, 0 );
        tempstruct.angles = ( 0, 0, 0 );
        utility::addstruct( tempstruct );
        level.var_6378577eed3fcc4e.var_4da5b3172cb36de1 = [ 10000 ];
        level.var_6378577eed3fcc4e.var_7f2398058bbfe3cb = [ 3 ];
        level.var_6378577eed3fcc4e.var_20a2f0495ad1833 = [ ( 177, 1200, 40 ) ];
    }
    
    if ( level.mapname == "mp_saba2_proto_s5" || level.mapname == "mp_saba2" )
    {
        var_d4bc10dc56ab819e = 10000;
        level.var_6378577eed3fcc4e.var_4da5b3172cb36de1 = [ var_d4bc10dc56ab819e, var_d4bc10dc56ab819e - 800, var_d4bc10dc56ab819e + 200, var_d4bc10dc56ab819e + 400, var_d4bc10dc56ab819e - 300, var_d4bc10dc56ab819e + 700, var_d4bc10dc56ab819e - 200, var_d4bc10dc56ab819e + 1000 ];
        var_576745158cc0bf24 = 5;
        level.var_6378577eed3fcc4e.var_7f2398058bbfe3cb = [ var_576745158cc0bf24, var_576745158cc0bf24 - 0.1, var_576745158cc0bf24 + 0.13, var_576745158cc0bf24 + 0.1, var_576745158cc0bf24 + 0.18, var_576745158cc0bf24 - 0.15, var_576745158cc0bf24, var_576745158cc0bf24 + 0.1 ];
        level.var_6378577eed3fcc4e.var_20a2f0495ad1833 = [ ( -1806.97, -11596.5, 5294.05 ), ( -440.972, -12776.4, 5051.07 ), ( -5258.94, -17427.5, 5430.07 ), ( -3419.82, -21350.2, 5949.89 ), ( -1598.65, -15929.8, 5473.98 ), ( 264.945, -13409.3, 5047.08 ), ( 3402.99, -11880.2, 5040.73 ), ( 2357.62, -10102.6, 5554.93 ) ];
        level.var_6378577eed3fcc4e.var_d525babf5ecd9e69 = 1;
        level.var_6378577eed3fcc4e.var_fb322070435e1801 = 1;
        level.var_6378577eed3fcc4e.var_d1aa42c2cd15d482 = "test_observatory";
        level.var_6378577eed3fcc4e.var_1308fabd0fb40baa = "after";
        level.var_6378577eed3fcc4e.var_9c20184563bc75cc = 13;
    }
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x92f98eb2, Offset: 0x7a6
// Size: 0x19
function private function_6b91211f833df2e6( structname )
{
    return utility::getstructarray( structname, "targetname" );
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0xdf150bf6, Offset: 0x7c8
// Size: 0x9b
function private function_975b15ffccb5a56( structname, var_691606400ea4f869 )
{
    angles = var_691606400ea4f869.angles ?? ( 0, 0, 0 );
    missilesilo = spawnscriptable( "missile_silo", var_691606400ea4f869.origin, angles );
    thread function_d41850f68bba9211( missilesilo );
    thread function_c1cd20b996cd0a3f( missilesilo );
    level.var_6378577eed3fcc4e.silos[ level.var_6378577eed3fcc4e.silos.size ] = missilesilo;
    return missilesilo;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x295bcdc6, Offset: 0x86c
// Size: 0x34
function private spawnmissile( origin )
{
    missile = magicgrenademanual( "missile_silo_missile_proj", origin, ( 0, 0, 0 ), 50 );
    return missile;
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0xfeea66b1, Offset: 0x8a9
// Size: 0x31
function private function_1337da83b83f75d3( origin, velocity )
{
    missile = magicgrenademanual( "missile_silo_cluster_missile_proj", origin, velocity, 50 );
    return missile;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x84d8c1aa, Offset: 0x8e3
// Size: 0x31
function private function_b87a64a98f71b55a( origin )
{
    explosion = spawn( "script_model", origin );
    explosion setmodel( "ks_toma_strike_cluster_mp" );
    return explosion;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x93709eb2, Offset: 0x91d
// Size: 0x31
function private function_f2a2ac2ad8c2a519( origin )
{
    missiledriver = spawn( "script_model", origin );
    missiledriver setmodel( "tag_origin" );
    return missiledriver;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0xc5c11ef0, Offset: 0x957
// Size: 0x31
function private function_ffa3c91341927e32( origin )
{
    explosion = spawn( "script_model", origin );
    explosion setmodel( "ks_toma_strike_cluster_mp" );
    return explosion;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x32a1b89, Offset: 0x991
// Size: 0x51
function private function_3e2d2533e76effb5( missilesilo )
{
    proximitytrigger = spawn( "noent_volume_trigger_radius", missilesilo.origin, 0, 1000, 500 );
    proximitytrigger.missilesilo = missilesilo;
    missilesilo.proximitytrigger = proximitytrigger;
    return proximitytrigger;
}

// Namespace br_missile_silos
// Params 3, eflags: 0x4
// Checksum 0xd82f992d, Offset: 0x9eb
// Size: 0xcf
function private function_7dd503902fa48e74( missilesilo, origin, showprogress )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    missilesilo.objid = objid;
    objidpoolmanager::objective_add_objective( objid, "current", origin + ( 0, 0, 50 ), "hud_icon_objective_defend_point_friendly" );
    objidpoolmanager::update_objective_setbackground( objid, 1 );
    
    if ( level.var_6378577eed3fcc4e.var_5bc3cc713df6dc0 )
    {
        objidpoolmanager::objective_playermask_hidefromall( objid );
    }
    else
    {
        objidpoolmanager::objective_playermask_showtoall( objid );
    }
    
    objidpoolmanager::objective_set_play_intro( objid, 1 );
    objidpoolmanager::function_9d4895ed38151e46( objid, 1 );
    objidpoolmanager::update_objective_description( objid, &"mp_br_ingame/missile_silo" );
    objidpoolmanager::objective_show_progress( objid, istrue( showprogress ) );
    return objid;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0xf81ee8f8, Offset: 0xac3
// Size: 0x7c
function private function_c1cd20b996cd0a3f( missilesilo )
{
    level endon( #"game_ended" );
    missilesilo endon( #"death" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    switch ( level.var_6378577eed3fcc4e.capturetype )
    {
        case 0:
            function_674e16d0a3f60e19( missilesilo );
            break;
        case 1:
            function_f7dc099de60928b2( missilesilo );
            break;
    }
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x9ba73db0, Offset: 0xb47
// Size: 0x198
function private function_f7dc099de60928b2( missilesilo )
{
    proximitytrigger = function_3e2d2533e76effb5( missilesilo );
    proximitytrigger endon( #"death" );
    function_7dd503902fa48e74( missilesilo, proximitytrigger.origin, 1 );
    missilesilo.var_8a1a42c8da230dff = 0;
    missilesilo.var_d299ed0069eb247c = 0;
    objective_setpinned( missilesilo.objid, 1 );
    trigger::makeenterexittrigger( proximitytrigger, &function_7635ce578a295992, &function_312cd9d4ac0f02b2, undefined, undefined, &function_bd3841f792f3f5a );
    var_ab0a4c952afafc1c = 0;
    
    while ( !missilesilo.iscaptured )
    {
        if ( missilesilo.var_8a1a42c8da230dff > 0 )
        {
            var_ab0a4c952afafc1c += 0.2;
            function_a663e1a67f10d0d( missilesilo, var_ab0a4c952afafc1c );
            
            if ( var_ab0a4c952afafc1c >= level.var_6378577eed3fcc4e.capturetime )
            {
                foreach ( player in proximitytrigger.triggerenterents )
                {
                    objidpoolmanager::function_6ac40386d1cd0d9a( missilesilo.objid, player );
                }
                
                function_f89b6666ab2fd450( missilesilo );
                break;
            }
        }
        
        wait 0.2;
    }
    
    if ( isdefined( missilesilo.proximitytrigger ) )
    {
        missilesilo.proximitytrigger delete();
    }
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x1173db47, Offset: 0xce7
// Size: 0xc3
function private function_f89b6666ab2fd450( missilesilo )
{
    if ( missilesilo.iscaptured )
    {
        return;
    }
    
    function_81b623d664b135e7( missilesilo );
    dmz_s5_reveal::function_5cad385308614c90( missilesilo );
    level.var_6378577eed3fcc4e.siloscaptured++;
    missilesilo.iscaptured = 1;
    
    if ( level.var_6378577eed3fcc4e.siloscaptured == level.var_6378577eed3fcc4e.var_2228372d171736fc )
    {
        thread function_4bb25d9e1d820b6b();
        return;
    }
    
    switch ( level.var_6378577eed3fcc4e.var_8fb6eb7a73d5c9c9 )
    {
        case 1:
            thread function_460f6c026dfb5be7( missilesilo );
            break;
        case 0:
            break;
    }
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x4c8fe5a2, Offset: 0xdb2
// Size: 0xc
function private function_674e16d0a3f60e19( missilesilo )
{
    
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0xbc13800f, Offset: 0xdc6
// Size: 0x57
function private function_81b623d664b135e7( missilesilo )
{
    if ( isdefined( missilesilo.objid ) && missilesilo.objid != -1 )
    {
        objidpoolmanager::returnobjectiveid( missilesilo.objid );
        missilesilo.objid = undefined;
        missilesilo notify( #"deleted_objective" );
    }
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x6793a60e, Offset: 0xe25
// Size: 0x4e
function private function_d41850f68bba9211( missilesilo )
{
    level endon( #"game_ended" );
    missilesilo waittill( #"death" );
    function_81b623d664b135e7( missilesilo );
    
    if ( isdefined( missilesilo.proximitytrigger ) )
    {
        missilesilo.proximitytrigger delete();
    }
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x4fe9bb06, Offset: 0xe7b
// Size: 0x6c
function private function_a663e1a67f10d0d( missilesilo, captureprogress )
{
    missilesilo.var_d299ed0069eb247c = min( 1, captureprogress / level.var_6378577eed3fcc4e.capturetime );
    
    if ( isdefined( missilesilo.objid ) )
    {
        objidpoolmanager::objective_set_progress( missilesilo.objid, missilesilo.var_d299ed0069eb247c );
    }
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x4609b30a, Offset: 0xeef
// Size: 0x1c, Type: bool
function private function_bd3841f792f3f5a( ent, proximitytrigger )
{
    return !isplayer( ent );
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x2a4888b3, Offset: 0xf14
// Size: 0x81
function private function_7635ce578a295992( ent, proximitytrigger )
{
    objidpoolmanager::objective_playermask_addshowplayer( proximitytrigger.missilesilo.objid, ent );
    objidpoolmanager::function_72efeaceb614613a( proximitytrigger.missilesilo.objid, ent, 1, 2, &"mp_br_ingame/arming_silo" );
    missilesilo = proximitytrigger.missilesilo;
    missilesilo.var_8a1a42c8da230dff++;
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x7fd4407c, Offset: 0xf9d
// Size: 0x56
function private function_312cd9d4ac0f02b2( ent, proximitytrigger )
{
    objidpoolmanager::function_6ac40386d1cd0d9a( proximitytrigger.missilesilo.objid, ent );
    missilesilo = proximitytrigger.missilesilo;
    missilesilo.var_8a1a42c8da230dff--;
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0x3538910d, Offset: 0xffb
// Size: 0xc
function private function_460f6c026dfb5be7( missilesilo )
{
    
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x9e19ca1d, Offset: 0x100f
// Size: 0x3e
function private function_f40e37f5acc4a327( missilesilo, targetorigin )
{
    missiledata = function_81e4c78502de5dd( missilesilo.origin, targetorigin );
    function_d0df67c8347f2a03( missilesilo, missiledata );
}

// Namespace br_missile_silos
// Params 0, eflags: 0x4
// Checksum 0xc0b2cd35, Offset: 0x1055
// Size: 0x2ff
function private function_4bb25d9e1d820b6b()
{
    coordinatedattack = level.var_6378577eed3fcc4e.coordinatedattack;
    level.var_9692849deec271 = 1;
    
    foreach ( missilesilo in level.var_6378577eed3fcc4e.silos )
    {
        thread function_f89b6666ab2fd450( missilesilo );
    }
    
    var_a8c47c855cedc48b = 0;
    
    while ( !var_a8c47c855cedc48b )
    {
        waitframe();
        var_a8c47c855cedc48b = 1;
        
        foreach ( missilesilo in level.var_6378577eed3fcc4e.silos )
        {
            if ( missilesilo.state != "ready" )
            {
                var_a8c47c855cedc48b = 0;
                break;
            }
        }
    }
    
    utility::script_func( "missile_silos_ready_to_fire" );
    
    foreach ( missilesilo in level.var_6378577eed3fcc4e.silos )
    {
        var_ed66979b23ce3bd3 = 0;
        missiledata = function_81e4c78502de5dd( missilesilo.origin, ( 0, 0, 0 ), 0, 0, var_ed66979b23ce3bd3 );
        thread function_d0df67c8347f2a03( missilesilo, missiledata );
    }
    
    level thread utility::set_area_swap_state( level.var_6378577eed3fcc4e.coordinatedattack.var_b50f26231e5f98a4, level.var_6378577eed3fcc4e.coordinatedattack.var_50943990d5167ee8, level.var_6378577eed3fcc4e.coordinatedattack.var_2285ca38a513196 );
    wait 16.5;
    
    foreach ( player in level.players )
    {
        player earthquakeforplayer( 0.2, 5.5, player.origin, 300 );
    }
}

// Namespace br_missile_silos
// Params 5, eflags: 0x4
// Checksum 0xa832890d, Offset: 0x135c
// Size: 0x161
function private function_81e4c78502de5dd( missileorigin, targetorigin, var_938edcb4fdced032, diveheightoverride, var_ed66979b23ce3bd3 )
{
    var_675122affae37f78 = 1;
    groundtraceheight = 1000;
    groundtracecontents = trace::create_default_contents( var_675122affae37f78 );
    groundtrace = trace::ray_trace( targetorigin + ( 0, 0, groundtraceheight ), targetorigin - ( 0, 0, groundtraceheight ), undefined, groundtracecontents );
    var_94f5bc30d5909ed2 = targetorigin;
    
    if ( groundtrace[ "hittype" ] != "hittype_none" )
    {
        var_94f5bc30d5909ed2 = groundtrace[ "position" ];
    }
    
    var_73710c2d307d54ba = vectornormalize2( missileorigin - var_94f5bc30d5909ed2 );
    diveheight = diveheightoverride ?? 10000;
    divestartorigin = ( var_94f5bc30d5909ed2[ 0 ], var_94f5bc30d5909ed2[ 1 ], diveheight );
    missiledata = spawnstruct();
    missiledata.targetorigin = var_94f5bc30d5909ed2;
    missiledata.divestartorigin = divestartorigin + var_73710c2d307d54ba * 20000;
    missiledata.diveendorigin = vectorlerp( missiledata.divestartorigin, missiledata.targetorigin, 0.6 );
    missiledata.traveldelayseconds = var_938edcb4fdced032 ?? 8;
    missiledata.shoulddive = var_ed66979b23ce3bd3 ?? 1;
    return missiledata;
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x273a8fbb, Offset: 0x14c6
// Size: 0xe5
function private function_d0df67c8347f2a03( missilesilo, missiledata )
{
    earthquake( 0.3, 1.2, missilesilo.origin, 2000 );
    missilespawnorigin = coordtransform( ( 0, 205, 30 ), missilesilo.origin, missilesilo.angles );
    missile = spawnmissile( missilespawnorigin );
    missiledriver = function_f2a2ac2ad8c2a519( missilespawnorigin );
    missile linkto( missiledriver, "tag_origin" );
    function_59fe693ab89a3dfa( missile, missiledriver );
    
    if ( missiledata.shoulddive )
    {
        function_64da416f9722123a( missile, missiledriver, missiledata );
        missiledive( missiledriver, missiledata );
        thread function_906249b03a0c020d( missile, missiledata );
        thread missileexplode( missile, missiledriver );
    }
    
    missile delete();
    missiledriver delete();
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x95030606, Offset: 0x15b3
// Size: 0x7e
function private function_59fe693ab89a3dfa( missile, missiledriver )
{
    missile setscriptablepartstate( "trail", "active" );
    missile setscriptablepartstate( "launch", "active" );
    var_dd2c64be4bdbd588 = 5;
    var_bfd8978e55658b0a = missiledriver.origin + ( 0, 0, 10000 );
    missiledriver moveto( var_bfd8978e55658b0a, var_dd2c64be4bdbd588, 0.8, 0 );
    wait var_dd2c64be4bdbd588;
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x41993ab1, Offset: 0x1639
// Size: 0x67
function private function_1880e4b8589d594( missileorigin, lookatorigin )
{
    missileforward = vectornormalize( lookatorigin - missileorigin );
    missileright = vectornormalize( vectorcross( missileforward, ( 0, 0, 1 ) ) );
    missileup = vectornormalize( vectorcross( missileright, missileforward ) );
    return axistoangles( missileright, missileup, missileforward );
}

// Namespace br_missile_silos
// Params 3, eflags: 0x4
// Checksum 0x27fa9879, Offset: 0x16a9
// Size: 0xc5
function private function_64da416f9722123a( missile, missiledriver, missiledata )
{
    missile setscriptablepartstate( "launch", "neutral" );
    missile setscriptablepartstate( "trail", "neutral" );
    missile setscriptablepartstate( "visibility", "hide" );
    wait missiledata.traveldelayseconds;
    missiledriver.origin = missiledata.divestartorigin;
    missiledriver.angles = function_1880e4b8589d594( missiledata.divestartorigin, missiledata.targetorigin );
    missiledriver dontinterpolate();
    missile setscriptablepartstate( "trail", "active" );
    missile setscriptablepartstate( "visibility", "show" );
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0xb7a63bac, Offset: 0x1776
// Size: 0x64
function private missiledive( missiledriver, missiledata )
{
    var_dd2c64be4bdbd588 = 2;
    missiledriver.angles = function_1880e4b8589d594( missiledata.divestartorigin, missiledata.diveendorigin );
    missiledriver moveto( missiledata.diveendorigin, var_dd2c64be4bdbd588, 0, 0 );
    wait var_dd2c64be4bdbd588;
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0xcf73b9a1, Offset: 0x17e2
// Size: 0xc6
function private function_906249b03a0c020d( missile, missiledata )
{
    missileorigin = missile.origin;
    
    for ( var_42596aaed334ce8c = 0; var_42596aaed334ce8c < 5 ; var_42596aaed334ce8c++ )
    {
        targetorigin = missiledata.targetorigin + utility::function_d8f5310928e6277f() * 800;
        initialvelocity = vectornormalize( targetorigin - missileorigin ) * 8000;
        spawnorigin = missileorigin + utility::randomonunitsphere() * 100;
        clustermissile = function_1337da83b83f75d3( spawnorigin, initialvelocity );
        clustermissile setscriptablepartstate( "trail", "active" );
        thread function_762e234bc0b442ec( clustermissile );
        waitframe();
    }
}

// Namespace br_missile_silos
// Params 2, eflags: 0x4
// Checksum 0x946dc92e, Offset: 0x18b0
// Size: 0x66
function private missileexplode( missile, missiledriver )
{
    missile delete();
    explosion = function_ffa3c91341927e32( missiledriver.origin );
    explosion setotherent( missiledriver );
    explosion setentityowner( missiledriver );
    explosion setscriptablepartstate( "explode_large", "active", 1 );
    wait 2;
    explosion delete();
}

// Namespace br_missile_silos
// Params 1, eflags: 0x4
// Checksum 0xc4821567, Offset: 0x191e
// Size: 0x89
function private function_762e234bc0b442ec( clustermissile )
{
    impactinfo = clustermissile killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact", "death" );
    
    if ( impactinfo.msg != "death" && isdefined( clustermissile ) )
    {
        explosion = function_b87a64a98f71b55a( clustermissile.origin );
        explosion setscriptablepartstate( "explode_large", "active", 1 );
        wait 2;
        clustermissile delete();
        explosion delete();
    }
}

/#

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0xd870062e, Offset: 0x19af
    // Size: 0x15, Type: dev
    function private debuginit()
    {
        level thread debuginitdevgui();
        level thread debugmonitor();
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0x213c487d, Offset: 0x19cc
    // Size: 0x86, Type: dev
    function private debuginitdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x45>", &function_d5aa419a88c92829 );
        devgui::add_devgui_func( "<dev string:x68>", "<dev string:x7b>", &function_dbf1fa3db5510289 );
        devgui::add_devgui_func( "<dev string:xa2>", "<dev string:xc4>", &function_8af1a5c3ea6e032a );
        devgui::add_devgui_func( "<dev string:xf2>", "<dev string:x10f>", &function_af4ad1b6f51d3975 );
        devgui::add_devgui_func( "<dev string:x140>", "<dev string:x15a>", &function_f883f416e90a6afa );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0x25738b4a, Offset: 0x1a5a
    // Size: 0x181, Type: dev
    function private debugmonitor()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_16734a8f907b290e", 0 ) )
            {
                setdvar( @"hash_16734a8f907b290e", 0 );
                thread function_8af1a5c3ea6e032a();
            }
            
            if ( getdvarint( @"hash_727280a5c36eced6", 0 ) )
            {
                setdvar( @"hash_727280a5c36eced6", 0 );
                thread function_dbf1fa3db5510289();
            }
            
            if ( getdvarint( @"hash_73afa658efa999bf", 0 ) )
            {
                for ( var_92522d0f5c0010ed = 0; var_92522d0f5c0010ed < level.var_6378577eed3fcc4e.silos.size ; var_92522d0f5c0010ed++ )
                {
                    missilesilo = level.var_6378577eed3fcc4e.silos[ var_92522d0f5c0010ed ];
                    line( missilesilo.origin, missilesilo.origin + ( 0, 0, 8000 ), ( 0, 0, 1 ), 1, 0, 1 );
                    print3d( missilesilo.origin, "<dev string:x188>" + var_92522d0f5c0010ed, ( 0, 0, 1 ), 1, 1, 1, 0 );
                }
            }
            
            if ( getdvarint( @"hash_18da932e2ddb8815", 0 ) )
            {
                setdvar( @"hash_18da932e2ddb8815", 0 );
                thread function_af4ad1b6f51d3975();
            }
            
            if ( getdvarint( @"hash_8e4eeba3f3dfbfe5", 0 ) )
            {
                setdvar( @"hash_8e4eeba3f3dfbfe5", 0 );
                thread function_f883f416e90a6afa();
            }
        }
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0xd1267d95, Offset: 0x1be3
    // Size: 0x30, Type: dev
    function private function_d5aa419a88c92829()
    {
        showlocations = getdvarint( @"hash_73afa658efa999bf", 0 );
        setdvar( @"hash_73afa658efa999bf", !showlocations );
    }

    // Namespace br_missile_silos
    // Params 1, eflags: 0x4
    // Checksum 0xa71d6875, Offset: 0x1c1b
    // Size: 0xd4, Type: dev
    function private function_653afbd7e9c9c7be( origin )
    {
        var_9668633603748100 = undefined;
        closestsilo = undefined;
        
        foreach ( missilesilo in level.var_6378577eed3fcc4e.silos )
        {
            dist = distancesquared( origin, missilesilo.origin );
            
            if ( !isdefined( closestsilo ) || dist < var_9668633603748100 )
            {
                closestsilo = missilesilo;
                var_9668633603748100 = dist;
            }
        }
        
        return closestsilo;
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0x7b357fa2, Offset: 0x1cf7
    // Size: 0x6a, Type: dev
    function private function_8af1a5c3ea6e032a()
    {
        player = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        closestsilo = function_653afbd7e9c9c7be( player.origin );
        
        if ( isdefined( closestsilo ) )
        {
            iprintln( "<dev string:x196>" + player.name );
            function_f40e37f5acc4a327( closestsilo, player.origin );
        }
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0x732583, Offset: 0x1d69
    // Size: 0xc, Type: dev
    function private function_dbf1fa3db5510289()
    {
        thread function_4bb25d9e1d820b6b();
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0x4912ac94, Offset: 0x1d7d
    // Size: 0x43, Type: dev
    function private function_af4ad1b6f51d3975()
    {
        player = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        closestsilo = function_653afbd7e9c9c7be( player.origin );
        thread function_f89b6666ab2fd450( closestsilo );
    }

    // Namespace br_missile_silos
    // Params 0, eflags: 0x4
    // Checksum 0xd1ed34f9, Offset: 0x1dc8
    // Size: 0x88, Type: dev
    function private function_f883f416e90a6afa()
    {
        foreach ( missilesilo in level.var_6378577eed3fcc4e.silos )
        {
            thread function_f89b6666ab2fd450( missilesilo );
        }
    }

#/
