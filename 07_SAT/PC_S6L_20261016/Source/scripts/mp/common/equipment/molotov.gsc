// scripts\mp\common\equipment\molotov.gsc  (hash_501664a0dffc664d.gscc) (size: 45072 Bytes / 0xb010 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1554d3d2 (357880786)
// size ...... 45072 (0xb010)
// includes .. 18  (offset: 0xa9cc)
// strings ... 71  (offset: 0xaa5c)
// dev strs .. 34  (offset: 0xae74)
// exports ... 105 (offset: 0x7960)
// cseg ...... 0x548 + 0x7418 (0x7960)
// imports ... 242 (offset: 0x89c8)
// animtree1 . 0   (offset: 0xb010)
// animtree2 . 0   (offset: 0xb010)
#using scripts\common\ai;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\elevators;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\weapons;

#namespace molotov;

// Namespace molotov
// Params 0, eflags: 0x5
// Checksum 0xac73e40b, Offset: 0x566
// Size: 0x2eb
function private autoexec molotov_init()
{
    utility::flag_wait( "equipment_initialized" );
    assert( !isdefined( level.molotov ), "<dev string:x24>" );
    leveldata = {};
    level.molotov = leveldata;
    bundle = molotov_get_bundle();
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level.molotovdamagethrottle = throttle::throttle_initialize( "molotovDamageThrottle", 2, 0.05 );
    leveldata.maxpools = getdvarint( @"hash_541e147e1379b35e", 100 );
    leveldata.maxcastsperframe = getdvarint( @"hash_3b54ad814e59b401", 8 );
    leveldata.immediatecleanup = getdvarint( @"hash_ec13dc5b3ae7d79c", 1 ) > 0;
    leveldata.uniquepoolid = 0;
    leveldata.scriptables = [];
    leveldata.triggers = [];
    leveldata.frametimestamp = 0;
    leveldata.caststhisframe = 0;
    level.g_effect[ "vfx_burn_med_low" ] = loadfxasset( bundle.molotov_vfx_burn_med_low ?? "vfx_iw8_weap_fire_molotov_mtov_ontag_med_low" );
    level.g_effect[ "vfx_burn_sml_low" ] = loadfxasset( bundle.molotov_vfx_burn_sml_low ?? "vfx_iw8_weap_fire_molotov_mtov_ontag_sml_low" );
    level.g_effect[ "vfx_burn_sml_head_low" ] = loadfxasset( bundle.var_92a6b3fc6c5b0d08 ?? "vfx_iw8_weap_fire_molotov_mtov_ontag_head_low" );
    
    if ( !isdefined( level.var_5026f1e2b78e3e22 ) )
    {
        level.var_5026f1e2b78e3e22 = getdvarint( @"hash_b989c0df1f8105ff", 0 ) > 0;
    }
    
    function_2bf65de4c6c31289( bundle );
    utility::registersharedfunc( #"molotov", #"molotov_simulate_impact", &molotov_simulate_impact );
    utility::registersharedfunc( #"molotov", #"molotov_burn_for_time", &molotov_burn_for_time );
    weapons::registerusedcallback( "molotov", &molotov_used );
    callback::add( #"player_death", &molotov_on_player_death );
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        callback::add( #"smoke_spawned", &function_48a9cd9f27dcf8b6 );
    }
    
    equipment_mp::registercallback( "equip_molotov", "onGive", &molotov_on_give );
    equipment_mp::registercallback( "equip_molotov", "onTake", &molotov_on_take );
    equipment_mp::registercallback( "equip_molotov", "onPlayerDamaged", &molotov_on_player_damaged );
    utility::registersharedfunc( #"molotov", #"onplayerkilled", &molotov_clear_fx );
    utility::registersharedfunc( #"molotov", #"clearplayerburning", &molotov_clear_burning );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #equipref:"equip_molotov" } );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xa513e039, Offset: 0x859
// Size: 0x724
function private function_2bf65de4c6c31289( bundle )
{
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8 ) )
    {
        bundle.var_f6f5ac8ff65f04a8 = {};
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.maxents ) )
    {
        bundle.var_f6f5ac8ff65f04a8.maxents = 1;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.triggerradius ) )
    {
        bundle.var_f6f5ac8ff65f04a8.triggerradius = 30;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.triggerheight ) )
    {
        bundle.var_f6f5ac8ff65f04a8.triggerheight = 55;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.triggeroffset ) )
    {
        bundle.var_f6f5ac8ff65f04a8.triggeroffset = 15;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.startdelayms ) )
    {
        bundle.var_f6f5ac8ff65f04a8.startdelayms = 0;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.var_3493a072c1acd244 ) )
    {
        bundle.var_f6f5ac8ff65f04a8.var_3493a072c1acd244 = 0;
    }
    
    if ( !isdefined( bundle.var_f6f5ac8ff65f04a8.typeid ) )
    {
        bundle.var_f6f5ac8ff65f04a8.typeid = "coreCenter";
    }
    
    if ( !isdefined( bundle.coredata ) )
    {
        bundle.coredata = {};
    }
    
    if ( !isdefined( bundle.coredata.distforward ) )
    {
        bundle.coredata.distforward = 50;
    }
    
    if ( !isdefined( bundle.coredata.distdown ) )
    {
        bundle.coredata.distdown = 50;
    }
    
    if ( !isdefined( bundle.coredata.distup ) )
    {
        bundle.coredata.distup = 25;
    }
    
    if ( !isdefined( bundle.coredata.maxcasts ) )
    {
        bundle.coredata.maxcasts = 4;
    }
    
    if ( !isdefined( bundle.coredata.maxfails ) )
    {
        bundle.coredata.maxfails = 3;
    }
    
    if ( !isdefined( bundle.coredata.maxents ) )
    {
        bundle.coredata.maxents = 1;
    }
    
    if ( !isdefined( bundle.coredata.distforwardwall ) )
    {
        bundle.coredata.distforwardwall = 25;
    }
    
    if ( !isdefined( bundle.coredata.triggerradius ) )
    {
        bundle.coredata.triggerradius = 30;
    }
    
    if ( !isdefined( bundle.coredata.triggerheight ) )
    {
        bundle.coredata.triggerheight = 55;
    }
    
    if ( !isdefined( bundle.coredata.triggeroffset ) )
    {
        bundle.coredata.triggeroffset = 15;
    }
    
    if ( !isdefined( bundle.coredata.startdelayms ) )
    {
        bundle.coredata.startdelayms = 100;
    }
    
    if ( !isdefined( bundle.coredata.var_3493a072c1acd244 ) )
    {
        bundle.coredata.var_3493a072c1acd244 = 50;
    }
    
    if ( !isdefined( bundle.coredata.typeid ) )
    {
        bundle.coredata.typeid = "core";
    }
    
    if ( !isdefined( bundle.tendrildata ) )
    {
        bundle.tendrildata = {};
    }
    
    if ( !isdefined( bundle.tendrildata.distforward ) )
    {
        bundle.tendrildata.distforward = 15;
    }
    
    if ( !isdefined( bundle.tendrildata.distdown ) )
    {
        bundle.tendrildata.distdown = 50;
    }
    
    if ( !isdefined( bundle.tendrildata.distup ) )
    {
        bundle.tendrildata.distup = 25;
    }
    
    if ( !isdefined( bundle.tendrildata.maxcasts ) )
    {
        bundle.tendrildata.maxcasts = 17;
    }
    
    if ( !isdefined( bundle.tendrildata.maxfails ) )
    {
        bundle.tendrildata.maxfails = 3;
    }
    
    if ( !isdefined( bundle.tendrildata.maxents ) )
    {
        bundle.tendrildata.maxents = 3;
    }
    
    if ( !isdefined( bundle.tendrildata.firstforwarddist ) )
    {
        bundle.tendrildata.firstforwarddist = 85;
    }
    
    if ( !isdefined( bundle.tendrildata.firstforwardmindist ) )
    {
        bundle.tendrildata.firstforwardmindist = 8;
    }
    
    if ( !isdefined( bundle.tendrildata.distforwardwall ) )
    {
        bundle.tendrildata.distforwardwall = 8;
    }
    
    if ( !isdefined( bundle.tendrildata.firstforwarddistwall ) )
    {
        bundle.tendrildata.firstforwarddistwall = 44;
    }
    
    if ( !isdefined( bundle.tendrildata.triggerradius ) )
    {
        bundle.tendrildata.triggerradius = 10;
    }
    
    if ( !isdefined( bundle.tendrildata.triggerheight ) )
    {
        bundle.tendrildata.triggerheight = 55;
    }
    
    if ( !isdefined( bundle.tendrildata.triggeroffset ) )
    {
        bundle.tendrildata.triggeroffset = 15;
    }
    
    if ( !isdefined( bundle.tendrildata.startdelayms ) )
    {
        bundle.tendrildata.startdelayms = 100;
    }
    
    if ( !isdefined( bundle.tendrildata.var_3493a072c1acd244 ) )
    {
        bundle.tendrildata.var_3493a072c1acd244 = 50;
    }
    
    if ( !isdefined( bundle.tendrildata.typeid ) )
    {
        bundle.tendrildata.typeid = "tendril";
    }
}

// Namespace molotov
// Params 4, eflags: 0x4
// Checksum 0xece8b015, Offset: 0xf85
// Size: 0x2e
function private molotov_on_give( equipmentref, slot, variantid, attachments )
{
    thread molotov_watch_fx();
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0x4f294dfe, Offset: 0xfbb
// Size: 0x21
function private molotov_on_take( equipmentref, slot )
{
    self notify( #"molotov_taken" );
}

// Namespace molotov
// Params 2
// Checksum 0x8ca8b19d, Offset: 0xfe4
// Size: 0x21b
function molotov_used( grenade, launchangles )
{
    grenade endon( #"death" );
    grenade endon( #"molotov_water_impact" );
    
    if ( !isdefined( launchangles ) )
    {
        launchangles = self getgunangles();
    }
    
    launchtimems = gettime();
    launchvelocity = anglestoforward( launchangles ) * 940 + anglestoup( launchangles ) * 120;
    grenade thread delayshow( 0.03 );
    thread molotov_cleanup_grenade( grenade );
    thread function_a37d84a174765cbb( grenade );
    grenade waittill( #"missile_stuck", stuckto, hitpart, var_61c69ee04fb623e, hitvelocity, position, normal, var_4ca36b89aa230d40 );
    
    if ( isdefined( level.gamemodemolotovfunc ) )
    {
        [[ level.gamemodemolotovfunc ]]( grenade, self );
    }
    
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, -800 * traveltime );
    waitframe();
    
    foreach ( player in level.players )
    {
        player notify( #"hash_559ad6ce148c89f3", grenade );
    }
    
    bundle = molotov_get_bundle( grenade );
    grenade playsound( bundle.molotov_impact_sound_alias ?? #"hash_470a8a8093ea41e9" );
    
    if ( isdefined( stuckto ) && ( isplayer( stuckto ) || isagent( stuckto ) ) )
    {
        thread molotov_stuck_player( grenade, stuckto, launchangles, impactvelocity );
        return;
    }
    
    if ( !isdefined( stuckto ) )
    {
        stuckto = var_4ca36b89aa230d40.linkedparent;
    }
    
    thread molotov_stuck( grenade, stuckto, launchangles, impactvelocity );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x2061893, Offset: 0x1207
// Size: 0x3f
function private delayshow( delaytime )
{
    self endon( #"death" );
    wait delaytime;
    
    if ( isdefined( self ) && !self.exploding )
    {
        self setscriptablepartstate( "visibility", "show", 0 );
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x54123c87, Offset: 0x124e
// Size: 0x41
function private function_a37d84a174765cbb( grenade )
{
    grenade endon( #"death" );
    grenade waittill( #"hash_c167e145cfc24a47", doorscriptable );
    grenade.var_c4aa8bf8393e8d4d = doorscriptable;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xa03d80e, Offset: 0x1297
// Size: 0x3a
function private function_d32b5815c40c931d( grenade )
{
    grenade endon( #"explode" );
    self endon( #"death" );
    grenade waittill( #"missile_water_impact" );
    grenade delete();
}

// Namespace molotov
// Params 4
// Checksum 0x9ebd759f, Offset: 0x12d9
// Size: 0x1c9
function molotov_stuck( grenade, stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( grenade.angles );
    right = anglestoright( launchangles );
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = molotov_rebuild_angles_up_right( up, right );
    }
    else
    {
        angles = molotov_rebuild_angles_up_forward( up, forward );
    }
    
    grenade.angles = angles;
    grenade.exploding = 1;
    grenade setscriptablepartstate( "effects", "explode", 0 );
    grenade missilehidetrail();
    grenade.prevent_knockdown = 1;
    grenade notify( #"death" );
    var_45ab019a47105f0 = undefined;
    bundle = molotov_get_bundle( grenade );
    
    if ( isdefined( bundle ) )
    {
        var_45ab019a47105f0 = bundle.var_cf8ce83ba0793f46;
    }
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        if ( utility::callsharedfunc( #"smokemanager", #"hash_eee3d7a747ac525b", grenade.origin ) )
        {
            grenade thread clearmolotov();
        }
    }
    else
    {
        level callback::callback( #"hash_851f50ff5797e453", { #grenade:grenade } );
    }
    
    callback::callback( #"on_molotov_impact", { #grenade:grenade, #bundle:bundle } );
    molotov_simulate_impact( grenade, grenade.origin, angles, stuckto, impactvelocity, gettime(), var_45ab019a47105f0 );
}

// Namespace molotov
// Params 4, eflags: 0x4
// Checksum 0x19c78ffb, Offset: 0x14aa
// Size: 0x2d5
function private molotov_stuck_player( grenade, stuckto, launchangles, impactvelocity )
{
    weapons::grenadestuckto( grenade, stuckto, 1, undefined, 0 );
    bundle = molotov_get_bundle( grenade );
    stuckto thread molotov_burn_for_time( bundle.var_f81d0343e92b24c6 ?? 6, self, grenade, grenade );
    
    if ( isplayer( grenade.owner ) )
    {
        if ( bundle.var_1f4bee5755e890bd )
        {
            grenade.owner thread points::doscoreevent( #"molotov_direct_hit" );
        }
        
        grenade.owner thread gamelogic_mp::threadedsetweaponstatbyname( grenade.weapon_object, 1, "special_hits" );
    }
    
    if ( isplayer( stuckto ) && soundexists( "eqp_molotov_bottle_break" ) )
    {
        stuckto playlocalsound( "eqp_molotov_bottle_break" );
    }
    
    grenade.exploding = 1;
    grenade setscriptablepartstate( "effects", "explode", 0 );
    grenade missilehidetrail();
    impactvelocity *= ( 0, 0, 1 );
    caststart = grenade.origin;
    castdir = ( 0, 0, -1 );
    castend = caststart + castdir * 128;
    contents = molotov_get_cast_contents();
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    callback::callback( #"on_molotov_impact", { #grenade:grenade, #bundle:bundle } );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        casthitnorm = castresults[ 0 ][ "normal" ];
        casthitent = castresults[ 0 ][ "entity" ];
        castend -= casthitnorm * 1;
        d = vectordot( castend - caststart, castdir );
        t = sqrt( 2 * d / 800 );
        up = casthitnorm;
        right = anglestoright( launchangles );
        impactangles = molotov_rebuild_angles_up_right( up, right );
        grenade.prevent_knockdown = 1;
        var_45ab019a47105f0 = undefined;
        bundle = molotov_get_bundle( grenade );
        
        if ( isdefined( bundle ) )
        {
            var_45ab019a47105f0 = bundle.var_cf8ce83ba0793f46;
        }
        
        thread molotov_simulate_impact( grenade, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000, var_45ab019a47105f0 );
        return;
    }
    
    grenade notify( #"death" );
    level callback::callback( #"hash_851f50ff5797e453", { #grenade:grenade } );
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xacd76246, Offset: 0x1787
// Size: 0x50
function private molotovbadplace( impactorigin )
{
    if ( !bots_util::bot_bots_enabled_or_added() && !utility::level_supports_ai() )
    {
        return;
    }
    
    badplace = function_72d497037a6d71fb( impactorigin, ( 150, 150, 100 ), ( 0, 0, 0 ) );
    return badplace;
}

// Namespace molotov
// Params 7
// Checksum 0x301445cd, Offset: 0x17e0
// Size: 0x852
function molotov_simulate_impact( grenade, impactorigin, impactangles, impactent, impactvelocity, impacttime, customscriptable )
{
    owner = grenade.owner;
    impactnormal = anglestoup( impactangles );
    caststart = impactorigin + impactnormal * 1;
    castend = caststart + impactnormal * 25;
    contents = molotov_get_cast_contents();
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ] - impactnormal * 1;
    }
    
    /#
        if ( level.dbgmolodrawhits )
        {
            line( caststart, castend, castresults.size > 0 ? ( 1, 0, 0 ) : ( 0, 0, 1 ), 1, 0, 10000 );
        }
    #/
    
    borigin = castend;
    burnsource = grenade;
    burnsource thread molotov_cleanup_burn_source();
    burnid = molotov_get_next_burning_id();
    coneimpact = 0;
    impactdot = vectordot( vectornormalize( impactvelocity ), -1 * impactnormal );
    
    if ( impactdot < 0.96593 )
    {
        coneimpact = 1;
    }
    
    shareddata = molotov_create_shared_data( owner, impacttime, burnsource, burnid );
    
    if ( !burnsource.nonavobstacle )
    {
        shareddata.badplace = molotovbadplace( impactorigin );
    }
    
    shareddata thread molotov_cleanup();
    grenade function_a4ebfb83ec0621b9( &molotov_burn_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            if ( isarray( elevators ) )
            {
                foreach ( arrelevator in elevators )
                {
                    arrelevator thread elevators::isentitytouchingdoortrigger( grenade );
                }
                
                continue;
            }
            
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    utility::function_969f9f5596dba07a( grenade, &molotov_burn_destroy );
    id = "coreCenter";
    branchdata = function_d314556c83ef2be5( id );
    branch = molotov_create_branch( shareddata, branchdata, undefined, impactorigin, impactangles, impactent );
    branch.var_c4aa8bf8393e8d4d = grenade.var_c4aa8bf8393e8d4d;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x4e>";
    #/
    
    var_c88cfb86ecd5d10c = 65;
    var_a5e62bf1bdbc8d5e = 115;
    bundle = molotov_get_bundle();
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        sidepreventstarttime = gettime() + branchdata.var_3493a072c1acd244;
    }
    else
    {
        sidepreventstarttime = gettime() + branchdata.startdelayms;
    }
    
    id = "core";
    branchdata = function_d314556c83ef2be5( id );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_forward_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x55>";
    #/
    
    forward = anglestoforward( impactangles );
    right = anglestoright( impactangles );
    up = anglestoup( impactangles );
    branchdata = function_d314556c83ef2be5( id );
    bforward = forward * -1;
    bright = right * -1;
    bup = up;
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x5b>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, var_c88cfb86ecd5d10c );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_right_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x60>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_c88cfb86ecd5d10c );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = &molotov_branch_create_left_tendril_cone;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x71>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, var_a5e62bf1bdbc8d5e );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x81>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_a5e62bf1bdbc8d5e );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = &molotov_branch_create_tendril_radial;
    
    if ( coneimpact )
    {
        oncompletedfunc = undefined;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:x91>";
    #/
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        function_4aef1d33801e87b8( id, coneimpact, shareddata, borigin, impactangles, impactent, sidepreventstarttime, forward, right, up, var_c88cfb86ecd5d10c, var_a5e62bf1bdbc8d5e );
    }
    
    molotov_register_cast( shareddata );
    var_411769c9c589263d = level.molotov.bundledata.var_b32a97501465a765;
    
    foreach ( branch in shareddata.branches )
    {
        branch thread molotov_start_branch( customscriptable, var_411769c9c589263d, grenade );
        utility::delaythread( 10, &molotov_cleanup_branch, branch, 1 );
    }
}

// Namespace molotov
// Params 12, eflags: 0x4
// Checksum 0xbe1b562a, Offset: 0x203a
// Size: 0x5d7
function private function_4aef1d33801e87b8( id, coneimpact, shareddata, borigin, impactangles, impactent, sidepreventstarttime, forward, right, up, var_c88cfb86ecd5d10c, var_a5e62bf1bdbc8d5e )
{
    branchdata = function_d314556c83ef2be5( id );
    oncompletedfunc = coneimpact ? &molotov_branch_create_forward_tendril_cone : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, impactangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xa0>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = forward * -1;
    bright = right * -1;
    bup = up;
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = coneimpact ? undefined : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xac>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, var_c88cfb86ecd5d10c );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = coneimpact ? &molotov_branch_create_right_tendril_cone : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xb7>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_c88cfb86ecd5d10c );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = coneimpact ? &molotov_branch_create_left_tendril_cone : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xce>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, var_a5e62bf1bdbc8d5e );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = coneimpact ? undefined : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xe4>";
    #/
    
    branchdata = function_d314556c83ef2be5( id );
    bforward = rotatepointaroundvector( up, forward, -1 * var_a5e62bf1bdbc8d5e );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    oncompletedfunc = coneimpact ? undefined : &molotov_branch_create_tendril_radial;
    branch = molotov_create_branch( shareddata, branchdata, undefined, borigin, bangles, impactent, 0, sidepreventstarttime, oncompletedfunc );
    branch.branchdata.distforward *= 2;
    branch.branchdata.distforwardwall *= 2;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    /#
        branch.id = "<dev string:xfa>";
    #/
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x708b024f, Offset: 0x2619
// Size: 0x53
function private function_33057acf01c07b64()
{
    self endon( #"entitydeleted" );
    flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( self.shareddata.burnsource ) )
    {
        self.shareddata.burnsource delete();
    }
    
    molotov_cleanup_pool( self, 1 );
}

// Namespace molotov
// Params 0
// Checksum 0x43828e9f, Offset: 0x2674
// Size: 0x192
function molotov_cleanup()
{
    self.burnsource utility::waittill_notify_or_timeout( "entitydeleted", 6.75 );
    endtime = gettime() + utility::function_4b74c15943231980( 10 );
    
    while ( gettime() < endtime )
    {
        branchesterminated = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch.iscomplete )
            {
                branchesterminated = 0;
                break;
            }
            
            if ( !branchesterminated )
            {
                break;
            }
        }
        
        if ( branchesterminated )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( self.burnsource && !self.burnsource.var_aa9f5a40a2f4cec1 )
    {
        self.burnsource.var_aa9f5a40a2f4cec1 = 1;
        thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.burnsource.origin, #attacker:self.owner, #ent:self.burnsource } );
    }
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
}

// Namespace molotov
// Params 4
// Checksum 0x708697da, Offset: 0x280e
// Size: 0x118
function molotov_create_shared_data( owner, impacttime, burnsource, burnid )
{
    shareddata = spawnstruct();
    shareddata.owner = owner;
    shareddata.team = owner.team;
    shareddata.impacttime = impacttime;
    shareddata.burnsource = burnsource;
    shareddata.burnid = burnid;
    shareddata.branches = [];
    shareddata.scriptablecount = 0;
    shareddata.caststotal = 0;
    shareddata.caststhisframe = 0;
    shareddata.frametimestamp = gettime();
    shareddata.castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    burnsource.shareddata = shareddata;
    return shareddata;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x1948789a, Offset: 0x292f
// Size: 0x52
function private molotov_register_cast( shareddata )
{
    shareddata.caststotal++;
    shareddata.caststhisframe++;
    shareddata.frametimestamp = gettime();
    leveldata = molotov_get_level_data();
    leveldata.caststhisframe++;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x11816628, Offset: 0x2989
// Size: 0x80
function private molotov_register_scriptable( shareddata )
{
    shareddata.scriptablecount++;
    leveldata = molotov_get_level_data();
    leveldata.scriptables[ leveldata.scriptables.size ] = self;
    println( "<dev string:x10f>" + leveldata.scriptables.size );
    
    if ( leveldata.scriptables.size > leveldata.maxpools )
    {
        molotov_delete_oldest_scriptable();
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x26f698a6, Offset: 0x2a11
// Size: 0xa2
function private molotov_register_trigger( trigger )
{
    leveldata = molotov_get_level_data();
    leveldata.triggers[ leveldata.triggers.size ] = self;
    
    /#
        if ( isent( self ) )
        {
            println( "<dev string:x147>" + self getentitynumber() + "<dev string:x16f>" + leveldata.triggers.size );
        }
        else
        {
            println( "<dev string:x17d>" + leveldata.triggers.size );
        }
    #/
    
    if ( leveldata.triggers.size > leveldata.maxpools )
    {
        molotov_delete_oldest_trigger();
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xf5c74940, Offset: 0x2abb
// Size: 0x42
function private molotov_delete_scriptable()
{
    leveldata = molotov_get_level_data();
    leveldata.scriptables = arrayremove( leveldata.scriptables, self );
    self notify( #"death" );
    self freescriptable();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xf33a074c, Offset: 0x2b05
// Size: 0x7e
function private molotov_delete_trigger()
{
    leveldata = molotov_get_level_data();
    leveldata.triggers = arrayremove( leveldata.triggers, self );
    
    /#
        if ( isent( self ) )
        {
            println( "<dev string:x1a6>" + self getentitynumber() + "<dev string:x16f>" + leveldata.triggers.size );
        }
        else
        {
            println( "<dev string:x1cc>" + leveldata.triggers.size );
        }
    #/
    
    self delete();
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x84f259f2, Offset: 0x2b8b
// Size: 0x4a
function private molotov_delete_oldest_scriptable( immediate )
{
    leveldata = molotov_get_level_data();
    scriptable = leveldata.scriptables[ 0 ];
    function_b0a61a125aa9480d( immediate, scriptable, scriptable.trigger );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x5fe13d8a, Offset: 0x2bdd
// Size: 0x4b
function private molotov_delete_oldest_trigger( immediate )
{
    leveldata = molotov_get_level_data();
    trigger = leveldata.triggers[ 0 ];
    function_b0a61a125aa9480d( immediate, trigger.scriptable, trigger );
}

// Namespace molotov
// Params 3, eflags: 0x4
// Checksum 0x87d57ceb, Offset: 0x2c30
// Size: 0xe6
function private function_b0a61a125aa9480d( immediate, scriptable, trigger )
{
    leveldata = molotov_get_level_data();
    immediate = immediate || leveldata.immediatecleanup;
    
    if ( scriptable )
    {
        if ( !immediate )
        {
            leveldata.scriptables = arrayremove( leveldata.scriptables, scriptable );
            leveldata.triggers = arrayremove( leveldata.triggers, trigger );
            trigger.scriptable thread molotov_pool_end();
            println( "<dev string:x1f3>" + leveldata.scriptables.size );
            return;
        }
        
        scriptable thread molotov_delete_scriptable();
        println( "<dev string:x242>" + leveldata.scriptables.size );
    }
    
    if ( trigger )
    {
        trigger thread molotov_delete_trigger();
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x23bd0843, Offset: 0x2d1e
// Size: 0xaf, Type: bool
function private molotov_can_cast_this_frame( shareddata )
{
    if ( shareddata.frametimestamp < gettime() )
    {
        shareddata.frametimestamp = gettime();
        shareddata.caststhisframe = 0;
    }
    
    if ( shareddata.caststhisframe >= 3 )
    {
        return false;
    }
    
    leveldata = molotov_get_level_data();
    
    if ( leveldata.frametimestamp < gettime() )
    {
        leveldata.frametimestamp = gettime();
        leveldata.caststhisframe = 0;
    }
    
    if ( leveldata.caststhisframe >= leveldata.maxcastsperframe )
    {
        return false;
    }
    
    return true;
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0xfa34e6fa, Offset: 0x2dd6
// Size: 0x129
function private molotov_shared_data_is_complete( var_4a9d8dc725fefd, customscriptable )
{
    iscomplete = 0;
    maxcasts = 60;
    maxents = 30;
    
    if ( self.caststotal >= maxcasts )
    {
        iscomplete = 1;
    }
    else if ( self.scriptablecount >= maxents )
    {
        iscomplete = 1;
    }
    else if ( var_4a9d8dc725fefd )
    {
        var_fda75b85789eb4d3 = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch molotov_branch_is_complete( 1, 1, customscriptable ) )
            {
                var_fda75b85789eb4d3 = 0;
                break;
            }
        }
        
        if ( var_fda75b85789eb4d3 )
        {
            iscomplete = 1;
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        molotov_store_branch_ents();
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xf02e17a, Offset: 0x2f08
// Size: 0x141
function private molotov_store_branch_ents()
{
    shareddata = self;
    
    if ( isdefined( self.shareddata ) )
    {
        shareddata = self.shareddata;
    }
    
    if ( !isdefined( shareddata.oldbranchents ) )
    {
        shareddata.oldbranchents = [];
    }
    
    foreach ( branch in self.branches )
    {
        foreach ( ent in branch.ents )
        {
            if ( isdefined( ent ) )
            {
                shareddata.oldbranchents[ shareddata.oldbranchents.size ] = ent;
            }
        }
    }
}

// Namespace molotov
// Params 9
// Checksum 0x25836d4, Offset: 0x3051
// Size: 0x128
function molotov_create_branch( shareddata, branchdata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc )
{
    branch = spawnstruct();
    branch.shareddata = shareddata;
    branch.branchdata = structcopy( branchdata );
    branch.startingorigin = startingorigin;
    branch.startingangles = startingangles;
    branch.startingstuckto = startingstuckto;
    branch.startingcasttype = startingcasttype;
    branch.oncompletedfunc = oncompletedfunc;
    branch.ents = [];
    branch.branches = [];
    branch.hitpositions = [];
    branch.hittypes = [];
    branch.casts = 0;
    branch.castfails = 0;
    branch.preventstarttime = preventstarttime;
    return branch;
}

// Namespace molotov
// Params 3
// Checksum 0xe08fbfb6, Offset: 0x3182
// Size: 0x987
function molotov_start_branch( customscriptable, var_411769c9c589263d, grenade )
{
    self endon( #"cleanup_branch" );
    self endon( #"death" );
    
    /#
        childthread molotov_branch_draw_hits();
    #/
    
    if ( !isdefined( self.preventstarttime ) )
    {
        self.preventstarttime = gettime();
    }
    
    if ( !isdefined( self.startingcasttype ) )
    {
        if ( !self.shareddata molotov_shared_data_is_complete( undefined, customscriptable ) )
        {
            pool = molotov_branch_create_pool( self.startingorigin, self.startingangles, self.startingstuckto, customscriptable, grenade );
            
            if ( pool )
            {
                pool childthread molotov_pool_start();
            }
            
            self.iscomplete = 1;
            self.shareddata molotov_shared_data_is_complete( 1, customscriptable );
            
            /#
                self.hitpositions[ self.hitpositions.size ] = self.startingorigin;
                self.hittypes[ self.hittypes.size ] = 1;
            #/
        }
        
        return;
    }
    
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;
    endtime = gettime() + utility::function_4b74c15943231980( 10 );
    
    while ( gettime() < endtime )
    {
        if ( self.shareddata molotov_shared_data_is_complete( undefined, customscriptable ) )
        {
            break;
        }
        
        if ( molotov_branch_is_complete( undefined, 1, customscriptable ) )
        {
            break;
        }
        
        if ( !molotov_can_cast_this_frame( self.shareddata ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.casttype == 0 )
        {
            firstforwardmodanglesfunc = self.branchdata.firstforwardmodanglesfunc;
            
            if ( isdefined( firstforwardmodanglesfunc ) )
            {
                self.castangles = [[ firstforwardmodanglesfunc ]]( self.castangles );
                self.branchdata.firstforwardmodanglesfunc = undefined;
                self.branchdata.iswallcast = undefined;
            }
        }
        
        if ( !isdefined( self.iswallcast ) )
        {
            updot = vectordot( anglestoup( self.castangles ), ( 0, 0, 1 ) );
            self.iswallcast = updot > -0.81915 && updot <= 0.5;
            
            if ( isdefined( self.branchdata.firstforwarddist ) )
            {
                if ( self.iswallcast && isdefined( self.branchdata.firstforwarddistwall ) )
                {
                    self.branchdata.firstforwarddist = self.branchdata.firstforwarddistwall;
                    self.branchdata.firstforwarddistwall = undefined;
                }
                else
                {
                    self.branchdata.firstforwarddistwall = undefined;
                }
            }
        }
        
        self.castdir = molotov_get_cast_dir( self.castangles, self.casttype );
        self.castend = self.caststart + self.castdir * molotov_get_cast_dist( self.casttype, self.branchdata, self.iswallcast );
        casthitpos = undefined;
        casthitnorm = undefined;
        casthitent = undefined;
        casthitangles = undefined;
        var_99b6ebae3e03efff = physics_raycast( self.caststart, self.castend, self.shareddata.castcontents, undefined, 1, "physicsquery_closest", 1, 1 );
        castresult = var_99b6ebae3e03efff[ 0 ];
        var_99b6ebae3e03efff = [];
        casthit = isdefined( castresult );
        
        if ( casthit )
        {
            casthitpos = castresult[ "position" ];
            casthitnorm = castresult[ "normal" ];
            casthitent = castresult[ "entity" ];
            var_14924c3ff7660950 = castresult[ "surfaceflags" ];
            casthittype = castresult[ "hittype" ];
            var_cf2dd5cc0612b411 = castresult[ "scriptable" ];
            
            if ( var_411769c9c589263d )
            {
                if ( physics_getsurfacetypefromflags( var_14924c3ff7660950 )[ "name" ] == "surftype_water" )
                {
                    return;
                }
            }
            
            if ( casthittype == "hittype_scriptable" && var_cf2dd5cc0612b411 && var_cf2dd5cc0612b411 scriptableisdoor() )
            {
                self.var_c4aa8bf8393e8d4d = var_cf2dd5cc0612b411;
            }
        }
        
        castresult = undefined;
        
        /#
            if ( level.dbgmolodrawhits )
            {
                end = casthitpos ?? self.castend;
                color = casthit ? ( 1, 0, 0 ) : ( 0, 0, 1 );
                line( self.caststart, end, color, 1, 0, 10000 );
                sphere( end, 2, color, 0, 10000 );
                print3d( ( self.caststart + end ) / 2, self.id + "<dev string:x290>" + self.casts, color, 1, 0.15, 10000, 1 );
            }
        #/
        
        switch ( self.casttype )
        {
            case 3:
                if ( casthit && !isdefined( self.shareddata.badplace ) )
                {
                    self.shareddata.badplace = molotovbadplace( casthitpos );
                }
            case 0:
                if ( casthit )
                {
                    molotov_branch_register_cast( self.casttype, 0, casthitpos );
                    shouldcreatepool = 1;
                    
                    if ( isdefined( self.branchdata.firstforwarddist ) )
                    {
                        castvec = casthitpos - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.branchdata.firstforwarddist -= castdist;
                        
                        if ( self.branchdata.firstforwarddist > self.branchdata.firstforwardmindist )
                        {
                            shouldcreatepool = 0;
                        }
                        else
                        {
                            self.branchdata.firstforwarddist = undefined;
                        }
                    }
                    
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    
                    if ( shouldcreatepool )
                    {
                        stuckto = casthitent ?? var_cf2dd5cc0612b411.linkedparent;
                        ent = molotov_branch_create_pool( casthitpos, casthitangles, stuckto, customscriptable, grenade );
                        
                        if ( ent )
                        {
                            ent childthread molotov_pool_start();
                        }
                    }
                    
                    self.casttype = 2;
                    self.caststart = casthitpos + casthitnorm * 1;
                    self.castangles = casthitangles;
                    self.iswallcast = undefined;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    
                    if ( isdefined( self.branchdata.firstforwarddist ) )
                    {
                        castvec = self.castend - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.branchdata.firstforwarddist -= castdist;
                        
                        if ( self.branchdata.firstforwarddist <= self.branchdata.firstforwardmindist )
                        {
                            self.branchdata.firstforwarddist = undefined;
                        }
                    }
                    
                    self.casttype = 1;
                    self.caststart = self.castend;
                }
                
                break;
            case 1:
                if ( casthit )
                {
                    casthitangles = molotov_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    stuckto = casthitent ?? var_cf2dd5cc0612b411.linkedparent;
                    ent = molotov_branch_create_pool( casthitpos, casthitangles, stuckto, customscriptable, grenade );
                    
                    if ( ent )
                    {
                        ent childthread molotov_pool_start();
                    }
                    
                    normdot = vectordot( anglestoup( self.castangles ), casthitnorm );
                    
                    if ( normdot < 0.9848 )
                    {
                        molotov_branch_register_cast( self.casttype, 2, casthitpos );
                        self.casttype = 2;
                        self.caststart = casthitpos + casthitnorm * 1;
                        self.castangles = casthitangles;
                    }
                    else
                    {
                        molotov_branch_register_cast( self.casttype, 1, casthitpos );
                        self.casttype = 0;
                    }
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.caststart = self.castend;
                }
                
                break;
            case 2:
                if ( casthit )
                {
                    molotov_branch_register_cast( self.casttype, 3, casthitpos );
                    self.casttype = 0;
                    self.caststart = casthitpos + casthitnorm * 1;
                }
                else
                {
                    molotov_branch_register_cast( self.casttype, undefined, undefined );
                    self.casttype = 0;
                }
                
                break;
        }
        
        waittillframeend();
    }
    
    self.iscomplete = 1;
    self.shareddata molotov_shared_data_is_complete( 1, customscriptable );
}

// Namespace molotov
// Params 3, eflags: 0x4
// Checksum 0xcb39be9f, Offset: 0x3b11
// Size: 0x274
function private molotov_branch_is_complete( var_4a9d8dc725fefd, var_c29347975be16889, customscriptable )
{
    iscomplete = 0;
    var_fda75b85789eb4d3 = undefined;
    
    if ( !var_c29347975be16889 )
    {
        iscomplete = self.shareddata molotov_shared_data_is_complete( undefined, customscriptable );
    }
    
    if ( !iscomplete )
    {
        if ( self.forcecomplete )
        {
            iscomplete = 1;
        }
        else if ( self.castfails >= self.branchdata.maxfails )
        {
            iscomplete = 1;
        }
        else if ( self.casts >= self.branchdata.maxcasts )
        {
            iscomplete = 1;
        }
        else if ( self.ents.size >= self.branchdata.maxents )
        {
            iscomplete = 1;
        }
        else if ( var_4a9d8dc725fefd && self.branches.size > 0 )
        {
            var_fda75b85789eb4d3 = 1;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( var_4a9d8dc725fefd, var_c29347975be16889, customscriptable ) )
                {
                    var_fda75b85789eb4d3 = 0;
                    break;
                }
            }
            
            if ( var_fda75b85789eb4d3 )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete && !self.iscomplete )
    {
        oncompletedfunc = self.oncompletedfunc;
        self.oncompletedfunc = undefined;
        
        if ( isdefined( oncompletedfunc ) )
        {
            self [[ oncompletedfunc ]]( customscriptable );
        }
        
        if ( var_fda75b85789eb4d3 )
        {
            iscomplete = 0;
            
            foreach ( branch in self.branches )
            {
                if ( !branch molotov_branch_is_complete( 1, var_c29347975be16889, customscriptable ) )
                {
                    var_fda75b85789eb4d3 = 0;
                    break;
                }
            }
            
            if ( var_fda75b85789eb4d3 )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
        molotov_store_branch_ents();
        self.branches = [];
    }
    
    return iscomplete;
}

// Namespace molotov
// Params 3, eflags: 0x4
// Checksum 0xc1b2239, Offset: 0x3d8e
// Size: 0x19d
function private molotov_branch_register_cast( casttype, casthittype, hitposition )
{
    molotov_register_cast( self.shareddata );
    self.casts++;
    
    if ( isdefined( casthittype ) )
    {
        if ( casthittype == 0 || casthittype == 1 || casthittype == 2 )
        {
            self.castfails = 0;
        }
    }
    else if ( casttype == 1 )
    {
        self.castfails++;
    }
    
    /#
        debugmsg = undefined;
        
        if ( isdefined( casthittype ) )
        {
            debugmsg = undefined;
            
            switch ( casthittype )
            {
                case 0:
                    debugmsg = "<dev string:x29b>";
                    break;
                case 1:
                    debugmsg = "<dev string:x2a7>";
                    break;
                case 2:
                    debugmsg = "<dev string:x2b0>";
                    break;
                case 3:
                    debugmsg = "<dev string:x2c0>";
                    break;
            }
            
            self.hitpositions[ self.hitpositions.size ] = hitposition;
            self.hittypes[ self.hittypes.size ] = casthittype;
        }
        else
        {
            switch ( casttype )
            {
                case 0:
                    debugmsg = "<dev string:x2c7>";
                    break;
                case 1:
                    debugmsg = "<dev string:x2cf>";
                    break;
                case 2:
                    debugmsg = "<dev string:x2d9>";
                    break;
                case 3:
                    debugmsg = "<dev string:x2dc>";
                    break;
            }
        }
        
        if ( level.var_569988d90e2df561 )
        {
            if ( isdefined( debugmsg ) )
            {
                println( debugmsg );
            }
        }
    #/
}

// Namespace molotov
// Params 10, eflags: 0x4
// Checksum 0xa4794ee3, Offset: 0x3f33
// Size: 0x1e8
function private molotov_create_pool( origin, angles, stuckto, owner, burnsource, burnid, starttime, branchdata, orientation, customscriptable )
{
    scriptablename = customscriptable ?? "equip_molotov_pool_mp_p";
    
    if ( burnsource.weapon_name == "gas_can_mp" )
    {
        scriptablename = "equip_propane_tank_pool_br";
    }
    
    genericblueprintpayload = isdefined( burnsource.blueprintdefindex ) ? [ #"genericblueprint", burnsource.blueprintdefindex ] : undefined;
    scriptable = spawnscriptable( scriptablename, origin, angles, undefined, genericblueprintpayload );
    scriptable utility::function_8a74027bdea84771( &molotov_delete_scriptable );
    scriptable.stuckto = stuckto;
    scriptable.owner = owner;
    scriptable.burnsource = burnsource;
    scriptable.burnid = burnid;
    scriptable.starttime = starttime;
    scriptable.branchdata = branchdata;
    scriptable.orientation = orientation;
    
    if ( isent( stuckto ) )
    {
        offset = rotatevectorinverted( origin - stuckto.origin, stuckto.angles );
        angleoffset = combineangles( invertangles( stuckto.angles ), angles );
        scriptable utility::scriptable_setparententity( stuckto, offset, angleoffset );
    }
    
    if ( isdefined( self.var_c4aa8bf8393e8d4d ) )
    {
        scriptable.var_c4aa8bf8393e8d4d = self.var_c4aa8bf8393e8d4d;
        scriptable thread function_844fc7687ed733ca( self.var_c4aa8bf8393e8d4d );
    }
    
    scriptable thread molotov_watch_cleanup_pool();
    return scriptable;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x7e958df5, Offset: 0x4124
// Size: 0xff
function private function_844fc7687ed733ca( doorscriptable )
{
    self endon( #"death" );
    ent = spawn( "script_model", ( doorscriptable.origin[ 0 ], doorscriptable.origin[ 1 ], self.origin[ 2 ] ) );
    ent.angles = ( 0, 0, 0 );
    posoffset = rotatevectorinverted( self.origin - ent.origin, ent.angles );
    angleoffset = combineangles( invertangles( ent.angles ), self.angles );
    var_8653a2e48feb6721 = doorscriptable scriptabledoorangle();
    waitframe();
    utility::scriptable_setparententity( ent, posoffset, angleoffset );
    
    while ( true )
    {
        ent.angles = ( 0, doorscriptable scriptabledoorangle() - var_8653a2e48feb6721, 0 );
        waitframe();
    }
}

// Namespace molotov
// Params 5
// Checksum 0xd0759d11, Offset: 0x422b
// Size: 0x207
function molotov_branch_create_pool( origin, angles, stuckto, customscriptable, grenade )
{
    up = anglestoup( angles );
    dot = vectordot( up, ( 0, 0, 1 ) );
    bundle = molotov_get_bundle();
    orientation = self.shareddata.orientation ?? "";
    
    if ( dot <= -0.81915 )
    {
        if ( self.branchdata.typeid == "tendril" && bundle.var_ac0813437bce24ec )
        {
            self.forcecomplete = 1;
            return;
        }
        
        orientation = "Ceil";
    }
    else if ( dot <= 0.5 )
    {
        orientation = "Wall";
    }
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        starttime = self.preventstarttime + self.branchdata.var_3493a072c1acd244;
    }
    else
    {
        starttime = self.preventstarttime + self.branchdata.startdelayms;
    }
    
    scriptable = molotov_create_pool( origin, angles, stuckto, self.shareddata.owner, self.shareddata.burnsource, self.shareddata.burnid, starttime, self.branchdata, orientation, customscriptable );
    self.preventstarttime = starttime;
    self.ents[ self.ents.size ] = scriptable;
    scriptable molotov_register_scriptable( self.shareddata );
    return scriptable;
}

// Namespace molotov
// Params 0
// Checksum 0xe0202b3, Offset: 0x443b
// Size: 0xac
function molotov_pool_start()
{
    if ( self.started )
    {
        return;
    }
    
    self.started = 1;
    self endon( #"death" );
    self endon( #"molotov_pool_end" );
    
    while ( gettime() < self.starttime )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.ended = 0;
    molotov_watch_pool();
    endimmediate = 0;
    
    if ( isdefined( self.burnsource.var_5b038f631de3ad97 ) )
    {
        endimmediate = istrue( self.burnsource.var_5b038f631de3ad97.endimmediate );
    }
    
    thread molotov_pool_end( endimmediate );
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xce23c149, Offset: 0x44ef
// Size: 0x1a1
function private molotov_watch_pool()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    
    if ( isalive( self.stuckto ) )
    {
        self.stuckto endon( #"death" );
    }
    
    self notify( #"hash_180aa49f2e9b9170" );
    self.trigger = molotov_create_pool_trigger( self.branchdata.triggerradius, self.branchdata.triggerheight, self.branchdata.triggeroffset );
    molotov_pool_update_scriptable();
    
    if ( isdefined( self.burnsource.var_5b038f631de3ad97 ) )
    {
        flame_duration_min = self.burnsource.var_5b038f631de3ad97.var_17b6db336154419b ?? 6.5;
        flame_duration_max = self.burnsource.var_5b038f631de3ad97.flamemaxduration ?? 6.75;
        
        if ( flame_duration_min == flame_duration_max )
        {
            burnloopduration = flame_duration_min;
        }
        else
        {
            burnloopduration = randomfloatrange( flame_duration_min, flame_duration_max );
        }
    }
    else
    {
        bundle = molotov_get_bundle( self.burnsource );
        burnloopduration = randomfloatrange( bundle.var_b4261d601af6a28a ?? 6.5, bundle.var_797382a688d68a64 ?? 6.75 );
    }
    
    if ( bundle.var_58cff294430da3ad )
    {
        thread function_e7da09d5090e0fad( burnloopduration );
    }
    
    wait burnloopduration;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x93407627, Offset: 0x4698
// Size: 0x61
function private function_e7da09d5090e0fad( loopduration )
{
    self endon( #"death" );
    self endon( #"molotov_pool_end" );
    self function_70576dbab4f88e19( "molotovLoopDuration", 0 );
    var_96cedc791ce2d454 = loopduration / 2;
    wait var_96cedc791ce2d454;
    
    if ( utility::function_de1f80d93273abf5() )
    {
        self function_70576dbab4f88e19( "molotovLoopDuration", 1 );
    }
}

// Namespace molotov
// Params 1
// Checksum 0xb5315501, Offset: 0x4701
// Size: 0xb0
function molotov_pool_end( immediate )
{
    self endon( #"death" );
    
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self.dyingdown = 1;
    self notify( #"molotov_pool_end" );
    molotov_pool_update_scriptable();
    bundle = molotov_get_bundle( self.burnsource );
    
    if ( !immediate )
    {
        wait bundle.var_1a52d576e5c859bb ?? 1;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread molotov_delete_trigger();
    }
    
    if ( !immediate )
    {
        wait 3.5;
    }
    
    thread molotov_delete_scriptable();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x2f9e6e04, Offset: 0x47b9
// Size: 0x1c
function private molotov_watch_cleanup_pool()
{
    self endon( #"death" );
    molotov_watch_cleanup_pool_internal();
    thread molotov_delete_scriptable();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xdeea9314, Offset: 0x47dd
// Size: 0x5b
function private molotov_watch_cleanup_pool_internal()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    
    if ( isalive( self.stuckto ) )
    {
        self.stuckto endon( #"death" );
    }
    
    self waittill( #"forever" );
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0xf0b99777, Offset: 0x4840
// Size: 0x65
function private function_1bd51045bb440e71( doorscriptable, triggeroffset )
{
    self endon( #"death" );
    
    while ( true )
    {
        self.origin = doorscriptable.origin - anglestoup( doorscriptable.angles ) * triggeroffset;
        self.angles = doorscriptable.angles;
        waitframe();
    }
}

// Namespace molotov
// Params 3, eflags: 0x4
// Checksum 0x2fca7179, Offset: 0x48ad
// Size: 0x276
function private molotov_create_pool_trigger( triggerradius, triggerheight, triggeroffset )
{
    shouldstick = isent( self.stuckto ) && ( !isai( self.stuckto ) || isalive( self.stuckto ) );
    triggerclassname = shouldstick ? "trigger_rotatable_radius" : "noent_volume_trigger_radius";
    origin = self.origin - anglestoup( self.angles ) * triggeroffset;
    
    if ( triggerclassname == "noent_volume_trigger_radius" && self.orientation == "Ceil" )
    {
        origin -= ( 0, 0, triggerheight );
    }
    
    triggerspawnflags = level.var_ddb0652fbf187f6e ?? 0;
    trigger = spawn( triggerclassname, origin, triggerspawnflags, triggerradius, triggerheight );
    trigger.angles = self.angles;
    trigger.scriptable = self;
    self.trigger = trigger;
    
    /#
        if ( level.dbgmolodrawhits )
        {
            cylinder( origin, origin + ( 0, 0, triggerheight ), triggerradius, ( 1, 0, 0 ), 0, 10000 );
        }
    #/
    
    if ( shouldstick )
    {
        trigger enablelinkto();
        trigger linkto( self.stuckto );
    }
    else if ( isdefined( self.var_c4aa8bf8393e8d4d ) )
    {
        trigger thread function_1bd51045bb440e71( self.var_c4aa8bf8393e8d4d, triggeroffset );
    }
    
    if ( triggerclassname == "trigger_rotatable_radius" )
    {
        trigger hide();
    }
    
    struct = spawnstruct();
    struct.trigger = trigger;
    struct.attacker = self.owner;
    struct.inflictor = self.burnsource;
    struct.killcament = self.burnsource;
    struct.burnid = self.burnid;
    struct.stuckto = self.stuckto;
    struct.starttime = self.starttime;
    struct.playersintrigger = [];
    trigger.struct = struct;
    struct thread molotov_watch_pool_trigger_enter();
    struct thread molotov_watch_pool_trigger_exit();
    struct thread molotov_cleanup_pool_trigger();
    trigger molotov_register_trigger();
    return trigger;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x7e6d4abf, Offset: 0x4b2c
// Size: 0x1b9
function private molotov_watch_pool_trigger_enter()
{
    if ( isdefined( self.inflictor ) )
    {
        self.inflictor endon( #"death" );
    }
    
    level endon( #"game_ended" );
    self.trigger endon( #"death" );
    self.attacker endon( #"disconnect" );
    self.attacker endon( #"joined_team" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", entity );
        
        if ( !isplayer( entity ) && !isagent( entity ) && !( entity vehicle::is_vehicle() && vehicle_damage::get_data( entity vehicle::get_ref() ).var_24bf434df6ca4c8b ) && !function_d115d9398073878d( entity ) )
        {
            continue;
        }
        
        if ( isplayer( entity ) && !player::isreallyalive( entity ) )
        {
            continue;
        }
        
        if ( entity.isjuggernaut && entity.juggcontext.var_307d13ca97e891d9 )
        {
            continue;
        }
        
        entnum = entity getentitynumber();
        
        if ( isdefined( self.playersintrigger[ entnum ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ entnum ] = entity;
        entity molotov_start_burning( self.attacker, self.inflictor, self.killcament, self.stuckto, self.burnid, self.starttime );
        waittime = level.gamemodebundle.var_acf417e8577b1168;
        
        if ( isdefined( waittime ) )
        {
            wait waittime;
        }
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x834442b8, Offset: 0x4ced
// Size: 0x11d
function private molotov_watch_pool_trigger_exit()
{
    level endon( #"game_ended" );
    self.trigger endon( #"death" );
    
    while ( true )
    {
        foreach ( playerentnum, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player istouching( self.trigger ) )
            {
                continue;
            }
            
            self.playersintrigger[ playerentnum ] = undefined;
            
            if ( utility::callsharedfunc( #"phosphorous_shots", #"hash_48a422748ecc9bde" ) )
            {
                player utility::callsharedfunc( #"phosphorous_shots", #"hash_ab5112d64a237129" );
            }
            
            player molotov_stop_burning( self.burnid );
        }
        
        waitframe();
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x10674633, Offset: 0x4e12
// Size: 0xf9
function private molotov_cleanup_pool_trigger()
{
    level endon( #"game_ended" );
    molotov_cleanup_pool_trigger_end_early();
    
    foreach ( playerentnum, player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        self.playersintrigger[ playerentnum ] = undefined;
        player molotov_stop_burning( self.burnid );
    }
    
    if ( isvalidmissile( self.inflictor ) )
    {
        self.inflictor forcehidegrenadehudwarning( 1 );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread molotov_delete_trigger();
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xf504a470, Offset: 0x4f13
// Size: 0x6f
function private molotov_cleanup_pool_trigger_end_early()
{
    self.trigger endon( #"death" );
    self.attacker endon( #"disconnect" );
    self.attacker endon( #"joined_team" );
    
    if ( isalive( self.stuckto ) )
    {
        self.stuckto endon( #"death" );
    }
    
    self waittill( #"forever" );
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0x5f2e995e, Offset: 0x4f8a
// Size: 0x126
function private function_c0f1cedb65e4270c( state, bundle )
{
    if ( bundle.var_27b3c1e001f19263.size > 0 )
    {
        foreach ( override_state in bundle.var_27b3c1e001f19263 )
        {
            if ( !( isdefined( override_state.locationtype ) && isdefined( override_state.firetype ) && isdefined( override_state.overridestate ) ) )
            {
                continue;
            }
            
            locationstr = override_state.locationtype;
            
            if ( override_state.locationtype == "Ground" )
            {
                locationstr = "";
            }
            
            defaultstatename = override_state.firetype + locationstr;
            
            if ( defaultstatename === state )
            {
                return override_state.overridestate;
            }
        }
    }
    
    return state;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xe34d68e1, Offset: 0x50b9
// Size: 0xe6
function private molotov_pool_update_scriptable()
{
    bundle = molotov_get_bundle( self.burnsource );
    state = self.branchdata.typeid + ( self.dyingdown ? "DieDown" : "" ) + self.orientation;
    state = function_c0f1cedb65e4270c( state, bundle );
    self setscriptablepartstate( "effects", state, 0 );
    
    if ( bundle.var_b2bcc33572c0bd72 && self.branchdata.typeid == "coreCenter" && !self.dyingdown && isdefined( self.owner.team ) )
    {
        self function_474bcbb86b733bef( "effects", self.owner.team );
    }
}

// Namespace molotov
// Params 11, eflags: 0x4
// Checksum 0x341edd9, Offset: 0x51a7
// Size: 0x200
function private molotov_branch_create_sub_branch( id, starttime, firstforwarddist, firstforwardmindist, firstforwardmodanglesfunc, firstforwarddistwall, maxcasts, maxents, startbranch, customscriptable, branchid )
{
    shareddata = self.shareddata;
    branchdata = function_d314556c83ef2be5( id );
    
    if ( isdefined( self.branchdata ) )
    {
        if ( self.castfails > self.branchdata.maxfails )
        {
            return;
        }
        
        if ( self.castfails > branchdata.maxfails )
        {
            return;
        }
    }
    
    if ( isdefined( firstforwarddist ) )
    {
        branchdata.firstforwarddist = firstforwarddist;
    }
    
    if ( isdefined( firstforwardmindist ) )
    {
        branchdata.firstforwardmindist = firstforwardmindist;
    }
    
    if ( isdefined( firstforwardmodanglesfunc ) )
    {
        branchdata.firstforwardmodanglesfunc = firstforwardmodanglesfunc;
    }
    
    if ( isdefined( firstforwarddistwall ) )
    {
        branchdata.firstforwarddistwall = firstforwarddistwall;
    }
    
    if ( isdefined( maxcasts ) )
    {
        branchdata.maxcasts = maxcasts;
    }
    
    if ( isdefined( maxents ) )
    {
        branchdata.maxents = maxents;
    }
    
    branch = molotov_create_branch( shareddata, branchdata, self, self.caststart, self.castangles, undefined, self.casttype, self.preventstarttime );
    
    /#
        branch.id = branchid;
    #/
    
    branch.castfails = self.castfails;
    self.branches[ self.branches.size ] = branch;
    shareddata.branches[ shareddata.branches.size ] = branch;
    
    if ( startbranch )
    {
        branch thread molotov_start_branch( customscriptable );
        utility::delaythread( 10, &molotov_cleanup_branch, branch, 1 );
    }
    
    return branch;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x78bf9f43, Offset: 0x53b0
// Size: 0x3e
function private molotov_branch_create_forward_tendril_cone( customscriptable )
{
    branch = molotov_branch_create_sub_branch( "tendril", self.preventstarttime, 35, 8, undefined, 44, undefined, undefined, 1, customscriptable, "forward_tendril_cone" );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xecc1e598, Offset: 0x53f6
// Size: 0x42
function private molotov_branch_create_left_tendril_cone( customscriptable )
{
    branch = molotov_branch_create_sub_branch( "tendril", self.preventstarttime, 35, 8, &molotov_left_tendril_mod_angles, 44, undefined, undefined, 1, customscriptable, "left_tendril_cone" );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x1bc11520, Offset: 0x5440
// Size: 0x42
function private molotov_branch_create_right_tendril_cone( customscriptable )
{
    branch = molotov_branch_create_sub_branch( "tendril", self.preventstarttime, 35, 8, &molotov_right_tendril_mod_angles, 44, undefined, undefined, 1, customscriptable, "right_tendril_cone" );
}

// Namespace molotov
// Params 1
// Checksum 0x9163da4a, Offset: 0x548a
// Size: 0x44
function molotov_branch_create_tendril_radial( customscriptable )
{
    branch = molotov_branch_create_sub_branch( "tendril", self.preventstarttime, 35, 8, &molotov_tendril_mod_angles_radial, 44, 6, 1, 1, customscriptable, "tendril_radial" );
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0x92cb3b4c, Offset: 0x54d6
// Size: 0x6a
function private molotov_rotate_angles_about_up( angles, amount )
{
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    right = undefined;
    forward = rotatepointaroundvector( up, forward, amount );
    right = vectornormalize( vectorcross( forward, up ) );
    up = vectorcross( right, forward );
    return axistoangles( forward, right, up );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xe282e082, Offset: 0x5549
// Size: 0x29
function private molotov_left_tendril_mod_angles( angles )
{
    amount = randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x54770a3, Offset: 0x557b
// Size: 0x2c
function private molotov_right_tendril_mod_angles( angles )
{
    amount = -1 * randomfloatrange( 50, 75 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xc5f3142c, Offset: 0x55b0
// Size: 0x29
function private molotov_tendril_mod_angles_radial( angles )
{
    amount = randomfloatrange( -60, 60 );
    return molotov_rotate_angles_about_up( angles, amount );
}

// Namespace molotov
// Params 0
// Checksum 0x6330d97e, Offset: 0x55e2
// Size: 0x17
function molotov_cleanup_burn_source()
{
    self endon( #"death" );
    wait 20;
    self delete();
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x13196a70, Offset: 0x5601
// Size: 0x31
function private molotov_cleanup_grenade( grenade )
{
    grenade endon( #"death" );
    utility::waittill_any( "disconnect", "joined_team" );
    grenade delete();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xa50a7754, Offset: 0x563a
// Size: 0x22
function private molotov_get_level_data()
{
    assert( isdefined( level.molotov ), "<dev string:x2e1>" );
    return level.molotov;
}

// Namespace molotov
// Params 1
// Checksum 0xd1557395, Offset: 0x5665
// Size: 0xae
function function_d314556c83ef2be5( castid )
{
    bundle = molotov_get_bundle();
    
    if ( castid == "coreCenter" )
    {
        return structcopy( bundle.var_f6f5ac8ff65f04a8 );
    }
    else if ( castid == "core" )
    {
        return structcopy( bundle.coredata );
    }
    else if ( castid == "tendril" )
    {
        return structcopy( bundle.tendrildata );
    }
    else if ( castid == "cone" )
    {
        return structcopy( bundle.conedata );
    }
    
    assertmsg( "<dev string:x318>" + castid );
    return bundle.tendrildata;
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0xfa6c3754, Offset: 0x571c
// Size: 0x71
function private molotov_get_cast_dir( angles, casttype )
{
    switch ( casttype )
    {
        case 0:
            return anglestoforward( angles );
        case 1:
            return ( -1 * anglestoup( angles ) );
        case 2:
            return anglestoup( angles );
        case 3:
            return self.var_b823966cf8de67e1;
    }
}

// Namespace molotov
// Params 3, eflags: 0x4
// Checksum 0xb2ffc8e3, Offset: 0x5796
// Size: 0xca
function private molotov_get_cast_dist( casttype, branchdata, iswallcast )
{
    switch ( casttype )
    {
        case 0:
            if ( isdefined( branchdata.firstforwarddist ) )
            {
                return branchdata.firstforwarddist;
            }
            else if ( iswallcast && isdefined( branchdata.distforwardwall ) )
            {
                return branchdata.distforwardwall;
            }
            else
            {
                return branchdata.distforward;
            }
        case 1:
            return branchdata.distdown;
        case 2:
            return branchdata.distup;
        case 3:
            return branchdata.conedist;
    }
}

// Namespace molotov
// Params 0
// Checksum 0xfd5c3aa, Offset: 0x5869
// Size: 0x34
function molotov_get_cast_contents()
{
    return physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
}

// Namespace molotov
// Params 2
// Checksum 0x45d806e9, Offset: 0x58a6
// Size: 0x3d
function molotov_rebuild_angles_up_right( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace molotov
// Params 2
// Checksum 0x5b4f92d8, Offset: 0x58ec
// Size: 0x3d
function molotov_rebuild_angles_up_forward( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace molotov
// Params 1
// Checksum 0x7f6e39b2, Offset: 0x5932
// Size: 0xe2
function molotov_get_bundle( grenade )
{
    outbundle = undefined;
    
    if ( !isdefined( level ) )
    {
        return outbundle;
    }
    
    if ( isdefined( level.var_66fd79d91a313ecc ) && isdefined( grenade ) )
    {
        outbundle = [[ level.var_66fd79d91a313ecc ]]( grenade );
        
        if ( isdefined( outbundle ) )
        {
            return outbundle;
        }
    }
    
    if ( !isdefined( level.molotov ) )
    {
        return outbundle;
    }
    
    if ( !isdefined( level.molotov.bundledata ) )
    {
        bundledata = equipment_mp::getEquipmentBundleFromWeaponName( "molotov_mp" );
        
        if ( !isdefined( bundledata ) )
        {
            bundledata = level.equipment.table[ "equip_molotov" ].bundle;
        }
        
        level.molotov.bundledata = bundledata;
    }
    
    outbundle = level.molotov.bundledata;
    return outbundle;
}

// Namespace molotov
// Params 6, eflags: 0x4
// Checksum 0x418bad3c, Offset: 0x5a1d
// Size: 0x9f
function private molotov_start_burning( attacker, inflictor, killcament, stuckto, id, starttime )
{
    if ( isunderwater() )
    {
        return;
    }
    
    if ( utility::function_92f6c5dd7f8b6166( "molotov", attacker.team ) )
    {
        return;
    }
    
    if ( !isdefined( id ) )
    {
        assert( isdefined( attacker ), "<dev string:x32e>" );
    }
    
    function_4c1d64175bda61ba();
    function_31e0900547dc4545( attacker, inflictor, killcament, stuckto, id, starttime );
    player::codcastersetplayerstatuseffect( "fire", -1 );
    thread molotov_update_burning();
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x79b84eb9, Offset: 0x5ac4
// Size: 0x82
function private molotov_stop_burning( id )
{
    info = molotov_get_burning_info();
    
    if ( !isdefined( info ) )
    {
        return;
    }
    
    source = molotov_get_burning_source( info, id );
    
    if ( isdefined( source ) )
    {
        if ( source.count > 0 )
        {
            source.count--;
        }
        
        if ( source.count == 0 )
        {
            info.sources[ source.id ] = undefined;
        }
    }
}

// Namespace molotov
// Params 4
// Checksum 0xcc3a312b, Offset: 0x5b4e
// Size: 0x6b
function molotov_burn_for_time( time, attacker, inflictor, killcament )
{
    self endon( #"death_or_disconnect" );
    self endon( #"clear_burning" );
    id = molotov_get_next_burning_id();
    molotov_start_burning( attacker, inflictor, killcament, self, id );
    wait time;
    molotov_stop_burning( id );
}

// Namespace molotov
// Params 4
// Checksum 0xdf063454, Offset: 0x5bc1
// Size: 0x6e
function function_574ec38e92d90ce9( note, attacker, inflictor, killcament )
{
    self endon( #"death_or_disconnect" );
    self endon( #"clear_burning" );
    id = molotov_get_next_burning_id();
    molotov_start_burning( attacker, inflictor, killcament, self, id );
    self waittill( note );
    molotov_stop_burning( id );
}

// Namespace molotov
// Params 1
// Checksum 0xc5965ea6, Offset: 0x5c37
// Size: 0x125
function molotov_clear_burning( immediate )
{
    self notify( #"clear_burning" );
    
    if ( isdefined( self.burninginfo.sources ) )
    {
        foreach ( source in self.burninginfo.sources )
        {
            self.burninginfo.sources[ source.id ] = undefined;
        }
    }
    
    if ( isagent( self ) )
    {
        level thread ai::remove_blackboard_isburning( self );
    }
    
    player::codcastersetplayerstatuseffect( "fire", 0 );
    self.burninginfo = undefined;
    
    if ( isplayer( self ) && callback::exists( #"on_player_clear_burning", &function_ae70f0a027613cba ) )
    {
        callback::remove( #"on_player_clear_burning", &function_ae70f0a027613cba );
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x215fb86b, Offset: 0x5d64
// Size: 0x21
function private function_ae70f0a027613cba( params )
{
    if ( level.var_5026f1e2b78e3e22 )
    {
        molotov_clear_burning( 1 );
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xc8a57435, Offset: 0x5d8d
// Size: 0x5a5
function private molotov_update_burning()
{
    self endon( #"death_or_disconnect" );
    self endon( #"clear_burning" );
    level endon( #"game_ended" );
    self notify( #"update_burning" );
    self endon( #"update_burning" );
    thread molotov_cleanup_burning();
    info = molotov_get_burning_info();
    
    if ( gettime() <= info.updatetimestamp )
    {
        waitframe();
    }
    
    var_dda038722457ed1 = 0;
    
    while ( isalive( self ) || self.var_68d56cb9e7f0999a )
    {
        info = molotov_get_burning_info();
        
        if ( isunderwater() )
        {
            thread molotov_clear_burning();
        }
        
        foreach ( source in info.sources )
        {
            if ( !source molotov_burning_source_is_valid() )
            {
                info.sources[ source.id ] = undefined;
            }
        }
        
        if ( info.sources.size > 0 )
        {
            info.timeoff = 0;
            info.timeon += 0.05;
            damagedealt = 0;
            
            if ( info.timetodamage <= 0 || !info.firstdamagedone )
            {
                damagingsource = undefined;
                highestdamage = 0;
                
                foreach ( source in info.sources )
                {
                    if ( info.sources.size > 1 )
                    {
                        foo = 1;
                    }
                    
                    damage = function_a0ee25f16dc19376( source, info.timeon );
                    
                    if ( damage > highestdamage )
                    {
                        damagingsource = source;
                        highestdamage = damage;
                    }
                }
                
                if ( isdefined( damagingsource ) )
                {
                    damageorigin = function_cc517a513d29e460( damagingsource );
                    burnbundle = damagingsource.bundle;
                    meansofdeath = burnbundle.means_of_death ?? "MOD_EXPLOSIVE";
                    self.var_553ae45c1a5786fb = gettime();
                    inflictor = undefined;
                    
                    if ( isdefined( damagingsource.inflictor ) )
                    {
                        inflictor = damagingsource.inflictor;
                    }
                    
                    if ( isagent( self ) && !var_dda038722457ed1 )
                    {
                        molotovburnenemy( damageorigin );
                        var_dda038722457ed1 = 1;
                    }
                    
                    if ( burnbundle.var_e64e0870a69922db && damage >= self.health )
                    {
                        throttle::throttle_wait_in_queue( level.molotovdamagethrottle, self );
                    }
                    
                    if ( !isdefined( self ) )
                    {
                        return;
                    }
                    
                    if ( isdefined( burnbundle.var_61041a515545d346 ) && highestdamage >= self.health )
                    {
                        self.var_e797f68de73ece4e = burnbundle.var_61041a515545d346;
                    }
                    
                    if ( damagingsource.var_a1914c698c2f3b20 )
                    {
                        cacheowner = function_217d26d5d72e60e1( damagingsource.attacker );
                        
                        if ( isplayer( cacheowner ) )
                        {
                            var_f0b03a609b4a60b = damagingsource.var_f0b03a609b4a60b ?? damagingsource.var_a1914c698c2f3b20;
                            cacheowner weapon_utility::function_502496613f00eb2a( damagingsource.var_a1914c698c2f3b20, var_f0b03a609b4a60b );
                        }
                    }
                    
                    damageflags = 65536;
                    
                    if ( burnbundle.molotov_damage_flags )
                    {
                        molotov_damage_flags = isarray( burnbundle.molotov_damage_flags ) ? burnbundle.molotov_damage_flags : [ burnbundle.molotov_damage_flags ];
                        
                        foreach ( flag in molotov_damage_flags )
                        {
                            damageflags |= flag;
                        }
                    }
                    
                    if ( self.var_68d56cb9e7f0999a && !self isscriptable() )
                    {
                        self scriptabledodamage( highestdamage, inflictor, damagingsource.attacker, damageorigin, undefined, meansofdeath, damagingsource.var_a1914c698c2f3b20 );
                    }
                    else
                    {
                        self dodamage( highestdamage, damageorigin, damagingsource.attacker, inflictor, meansofdeath, damagingsource.var_a1914c698c2f3b20, "none", undefined, damageflags );
                    }
                    
                    damagedealt = 1;
                    info.firstdamagedone = 1;
                    info.timetodamage = burnbundle.var_29dd3c8b7a515774 ?? 0.25;
                }
            }
            
            if ( !damagedealt )
            {
                info.timetodamage -= 0.05;
            }
        }
        else
        {
            info.timeoff += 0.05;
            
            if ( info.timeoff >= 0.25 )
            {
                thread molotov_clear_burning();
            }
        }
        
        info.updatetimestamp = gettime();
        wait 0.05;
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x135d933a, Offset: 0x633a
// Size: 0x5e
function private function_217d26d5d72e60e1( attacker )
{
    if ( !attacker )
    {
        return;
    }
    
    if ( !isplayer( attacker ) )
    {
        if ( isplayer( attacker.owner ) )
        {
            return attacker.owner;
        }
        else if ( isplayer( attacker.var_bd22ba6c600a23a3 ) )
        {
            return attacker.var_bd22ba6c600a23a3;
        }
    }
    
    return attacker;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xbb5e815c, Offset: 0x63a1
// Size: 0x4a
function private function_cc517a513d29e460( source )
{
    if ( isdefined( source.inflictor ) )
    {
        return source.inflictor.origin;
    }
    
    return source.attacker.origin;
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0x97dc0dad, Offset: 0x63f3
// Size: 0x2cc
function private function_a0ee25f16dc19376( source, timeon )
{
    burnbundle = source.bundle;
    damageorigin = function_cc517a513d29e460( source );
    
    if ( burnbundle.var_4aadd79a2305447 )
    {
        if ( !isdefined( source.starttime ) )
        {
            source.starttime = gettime();
        }
        
        timeon = ( gettime() - source.starttime ) / 1000;
    }
    
    if ( !self.var_3343534bd4a927d8 )
    {
        var_1e45fc87d4c6c493 = self damageconetrace( damageorigin );
    }
    else
    {
        var_1e45fc87d4c6c493 = 1;
    }
    
    if ( var_1e45fc87d4c6c493 == 0 )
    {
        return 0;
    }
    
    bundle = molotov_get_bundle();
    var_f5e5cfd6c2b781f1 = bundle.var_c7709714d768097c && source.inflictor.weapon_object && source.inflictor.weapon_object hasattachmenthash( bundle.var_c7709714d768097c );
    stage3time = burnbundle.var_726e9b33a65af54f ?? 1.5;
    stage2time = burnbundle.var_209153533613c440 ?? 0.5;
    
    if ( var_f5e5cfd6c2b781f1 )
    {
        damage = burnbundle.var_47d856eff90235e9 ?? 0;
    }
    else
    {
        damage = burnbundle.var_c3f25b11c2247a29 ?? 0;
    }
    
    if ( timeon > stage3time )
    {
        if ( var_f5e5cfd6c2b781f1 )
        {
            damage = burnbundle.var_eb99e6b002e495d3 ?? 0;
        }
        else
        {
            damage = burnbundle.var_7ceb375188b38c13 ?? 0;
        }
    }
    else if ( timeon > stage2time )
    {
        if ( var_f5e5cfd6c2b781f1 )
        {
            damage = burnbundle.var_51784736e1613a44 ?? 0;
        }
        else
        {
            damage = burnbundle.var_78880e1476d45684 ?? 0;
        }
    }
    
    if ( isplayer( self ) )
    {
        damage_scalar = burnbundle.var_13727c7357581d8d ?? 1;
        damage *= damage_scalar;
    }
    
    if ( ( isplayer( self ) || isagent( self ) ) && self ismeatshieldvictim() )
    {
        damage *= level.meatshieldhealthscale ?? 1;
    }
    
    damage *= var_1e45fc87d4c6c493;
    
    if ( burnbundle.var_9053adff1df4a849 && isdefined( source.stuckto ) && source.stuckto == self )
    {
        if ( damage >= self.health )
        {
            damage = self.health - 1;
        }
    }
    
    if ( isdefined( burnbundle.damage_override_func ) )
    {
        override_damage = self [[ burnbundle.damage_override_func ]]( source );
        
        if ( isdefined( override_damage ) && override_damage != -1 )
        {
            return override_damage;
        }
    }
    
    return damage;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x47e11930, Offset: 0x66c8
// Size: 0x96
function private molotovburnenemy( origin )
{
    if ( self._blackboard )
    {
        self._blackboard.isburning = 1;
    }
    
    self.burningdirection = undefined;
    right = anglestoright( self.angles );
    tomolotov = vectornormalize( origin - self.origin );
    
    if ( vectordot( right, tomolotov ) > 0 )
    {
        self.burningdirection = "right";
        return;
    }
    
    self.burningdirection = "left";
}

// Namespace molotov
// Params 0
// Checksum 0x3c371c8a, Offset: 0x6766
// Size: 0x29, Type: bool
function molotov_is_burning()
{
    info = molotov_get_burning_info();
    return isdefined( info ) && info.sources.size > 0;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xba23661, Offset: 0x6798
// Size: 0xc0
function private function_4c1d64175bda61ba()
{
    if ( !isdefined( self.burninginfo ) )
    {
        info = spawnstruct();
        info.timeon = 0;
        info.timeoff = 0;
        info.timetodamage = 0.25;
        info.updatetimestamp = 0;
        info.victim = self;
        info.sources = [];
        info.firstdamagedone = 0;
        self.burninginfo = info;
        
        if ( isplayer( self ) && !callback::exists( #"on_player_clear_burning", &function_ae70f0a027613cba ) )
        {
            callback::add( #"on_player_clear_burning", &function_ae70f0a027613cba );
        }
    }
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x3a6399c6, Offset: 0x6860
// Size: 0x15
function private molotov_get_burning_info( create )
{
    return self.burninginfo;
}

// Namespace molotov
// Params 6, eflags: 0x4
// Checksum 0xdfd69add, Offset: 0x687e
// Size: 0x235
function private function_31e0900547dc4545( attacker, inflictor, killcament, stuckto, id, starttime )
{
    info = molotov_get_burning_info();
    
    if ( !isdefined( info.sources[ id ] ) )
    {
        source = spawnstruct();
        source.attacker = attacker;
        source.inflictor = inflictor;
        source.hasinflictor = isdefined( inflictor );
        source.killcament = killcament;
        source.stuckto = stuckto;
        source.info = info;
        source.id = id;
        source.starttime = starttime;
        source.count = 1;
        source.var_f0b03a609b4a60b = inflictor.weapon_object;
        
        if ( !source.var_f0b03a609b4a60b && inflictor.weapon_name )
        {
            if ( inflictor.weapon_name == "napalm_burst_augment" )
            {
                inflictor.weapon_name = %"sat_molotov_zm_napalmburst";
            }
            
            source.var_f0b03a609b4a60b = utility::function_64003742d8f5c781( inflictor.weapon_name );
        }
        
        var_2a6de227f53419d = isdefined( inflictor.var_5b038f631de3ad97 ) && ( isplayer( self ) || inflictor.var_5b038f631de3ad97.var_35807474702938c6 && isagent( self ) );
        
        if ( var_2a6de227f53419d )
        {
            source.bundle = inflictor.var_5b038f631de3ad97;
        }
        else
        {
            source.bundle = molotov_get_bundle( inflictor );
        }
        
        source.var_a1914c698c2f3b20 = utility::function_64003742d8f5c781( source.bundle.useweapon ?? "molotov_mp" );
        info.sources[ id ] = source;
        return;
    }
    
    info.sources[ id ].count++;
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0xedde2c20, Offset: 0x6abb
// Size: 0x31
function private molotov_get_burning_source( info, id )
{
    source = info.sources[ id ];
    return source;
}

// Namespace molotov
// Params 0
// Checksum 0xb865b6b3, Offset: 0x6af5
// Size: 0x142, Type: bool
function molotov_burning_source_is_valid()
{
    if ( !isdefined( self.attacker ) )
    {
        return false;
    }
    
    if ( !isdefined( self.info.victim ) )
    {
        return false;
    }
    
    if ( isplayer( self.info.victim ) && !player::isreallyalive( self.info.victim ) )
    {
        return false;
    }
    
    if ( self.attacker != self.info.victim && !player_utility::playersareenemies( self.attacker, self.info.victim ) && isdefined( self.inflictor ) && !self.inflictor.friendlyfireexception && !function_d115d9398073878d( self.info.victim ) && !self.info.victim.var_68d56cb9e7f0999a )
    {
        return false;
    }
    
    if ( self.hasinflictor && !isdefined( self.inflictor ) )
    {
        return false;
    }
    
    if ( self.count <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace molotov
// Params 0
// Checksum 0xec32519f, Offset: 0x6c40
// Size: 0x52
function molotov_get_next_burning_id()
{
    leveldata = molotov_get_level_data();
    
    if ( !isdefined( leveldata.burningid ) )
    {
        leveldata.burningid = 0;
    }
    
    id = leveldata.burningid;
    leveldata.burningid++;
    return id;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x676a8d0a, Offset: 0x6c9b
// Size: 0x28
function private molotov_cleanup_burning()
{
    self notify( #"cleanup_burning" );
    self endon( #"cleanup_burning" );
    childthread molotov_cleanup_burning_on_death();
    childthread molotov_cleanup_burning_on_game_end();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xdbee7a8b, Offset: 0x6ccb
// Size: 0x3c
function private molotov_cleanup_burning_on_death()
{
    self endon( #"disconnect" );
    self endon( #"clear_burning" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    thread molotov_clear_burning( 1 );
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xc40cbdda, Offset: 0x6d0f
// Size: 0x2e
function private molotov_cleanup_burning_on_game_end()
{
    self endon( #"death_or_disconnect" );
    self endon( #"clear_burning" );
    level waittill( #"game_ended" );
    thread molotov_clear_burning();
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0x2a88c844, Offset: 0x6d45
// Size: 0xad, Type: bool
function private molotov_on_player_damaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    bundle = molotov_get_bundle();
    
    if ( data.attacker )
    {
        hitmarkersoundalias = utility::callsharedfunc( #"hud", #"hash_785d65fc31ffd85", 0 );
        
        if ( hitmarkersoundalias )
        {
            data.attacker playlocalsound( hitmarkersoundalias );
        }
    }
    
    data.victim thread damage_effects::enableburnfxfortime( 0.5, undefined, bundle.var_a0477622ba8b51c8, bundle.var_d399d81ccb8fce5d );
    return true;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xec37973b, Offset: 0x6dfb
// Size: 0x79
function private molotov_on_player_death( data )
{
    if ( !( isdefined( data.attacker ) && isdefined( data.victim ) ) || data.attacker == data.victim || !( data.inflictor.equipmentref == "equip_molotov" ) )
    {
        return;
    }
    
    data.inflictor thread function_70f83f8498993333();
}

// Namespace molotov
// Params 0, eflags: 0xc
// Checksum 0x9e4a96af, Offset: 0x6e7c
// Size: 0x8b
function private function_70f83f8498993333()
{
    self notify( #"hash_d44d468df933b29e" );
    self endon( #"hash_d44d468df933b29e" );
    self endon( #"death" );
    
    if ( !isdefined( self.var_de70aa57113c48c3 ) )
    {
        self.var_de70aa57113c48c3 = 0;
    }
    
    self.var_de70aa57113c48c3++;
    
    if ( isdefined( self.owner ) && self.var_de70aa57113c48c3 % 2 == 0 )
    {
        self.owner thread points::doscoreevent( #"double_molotov" );
    }
    
    wait 2;
    self.var_de70aa57113c48c3 = 0;
}

// Namespace molotov
// Params 1, eflags: 0x4
// Checksum 0xaa1519c2, Offset: 0x6f0f
// Size: 0x28a
function private function_48a9cd9f27dcf8b6( params )
{
    bundle = molotov_get_bundle();
    grenades = getentarrayinradius( "grenade", #classname, params.origin, params.radius );
    
    if ( grenades && grenades.size > 0 )
    {
        foreach ( grenade in grenades )
        {
            if ( grenade.equipmentref == "equip_molotov" )
            {
                grenade thread clearmolotov();
            }
        }
    }
    
    if ( level.molotov.scriptables )
    {
        var_e1d36039d0a50cc2 = [];
        
        foreach ( mscriptable in level.molotov.scriptables )
        {
            var_ae72a4375a0d5cd5 = params.origin[ 2 ] - 10;
            toppoint = params.origin[ 2 ] + params.height + 10;
            
            if ( utility::ispointinsidecircle( mscriptable.origin, params.origin, params.radius ) && mscriptable.origin[ 2 ] >= var_ae72a4375a0d5cd5 && mscriptable.origin[ 2 ] <= toppoint )
            {
                var_e1d36039d0a50cc2[ var_e1d36039d0a50cc2.size ] = mscriptable;
            }
        }
        
        foreach ( item in var_e1d36039d0a50cc2 )
        {
            item thread molotov_pool_end( 1 );
        }
    }
}

// Namespace molotov
// Params 0
// Checksum 0x514303c3, Offset: 0x71a1
// Size: 0xa4
function clearmolotov()
{
    if ( !self )
    {
        return;
    }
    
    if ( !self.var_aa9f5a40a2f4cec1 )
    {
        self.var_aa9f5a40a2f4cec1 = 1;
        thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #attacker:self.owner, #ent:self } );
    }
    
    bundle = molotov_get_bundle( self );
    var_184e4da13be19a8c = bundle.var_184e4da13be19a8c ?? 0.5;
    wait var_184e4da13be19a8c;
    molotov_burn_destroy( 1 );
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xf1ed30cf, Offset: 0x724d
// Size: 0xd0
function private molotov_watch_fx()
{
    self notify( #"hash_945ace4911ac05f2" );
    self endon( #"hash_945ace4911ac05f2" );
    self endon( #"death_or_disconnect" );
    bundle = molotov_get_bundle();
    var_b2a6b1f0e1ac6518 = bundle.useweapon ?? "molotov_mp";
    var_ae464a13e88741b4 = 0;
    
    while ( true )
    {
        var_9a829255481a6f05 = 0;
        objweapon = self getheldoffhand();
        
        if ( !isnullweapon( objweapon ) && objweapon.basename == var_b2a6b1f0e1ac6518 )
        {
            var_9a829255481a6f05 = 1;
        }
        
        if ( var_9a829255481a6f05 && !var_ae464a13e88741b4 )
        {
            thread molotov_begin_fx();
        }
        else if ( var_ae464a13e88741b4 && !var_9a829255481a6f05 )
        {
            thread molotov_end_fx();
        }
        
        var_ae464a13e88741b4 = var_9a829255481a6f05;
        waitframe();
    }
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x5518bd05, Offset: 0x7325
// Size: 0x81
function private molotov_begin_fx()
{
    self endon( #"death_or_disconnect" );
    self endon( #"molotov_end_fx" );
    self.playingmolotovwickfx = 1;
    self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
    self setscriptablepartstate( "equipMtovFXView", "active", 0 );
    waittime = 0.4;
    wait waittime;
    self setscriptablepartstate( "equipMtovFXWorld", "active", 0 );
    self waittill( #"offhand_fired" );
    waitframe();
    thread molotov_end_fx();
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0x467d5689, Offset: 0x73ae
// Size: 0x46
function private molotov_end_fx()
{
    self notify( #"molotov_end_fx" );
    
    if ( self.playingmolotovwickfx )
    {
        self setscriptablepartstate( "equipMtovFXWorld", "neutral", 0 );
        self setscriptablepartstate( "equipMtovFXView", "neutral", 0 );
    }
    
    self.playingmolotovwickfx = undefined;
}

// Namespace molotov
// Params 0
// Checksum 0x2a2da137, Offset: 0x73fc
// Size: 0x15
function molotov_clear_fx()
{
    self notify( #"hash_945ace4911ac05f2" );
    thread molotov_end_fx();
}

// Namespace molotov
// Params 2, eflags: 0x4
// Checksum 0x83fa0ba3, Offset: 0x7419
// Size: 0xcd
function private molotov_cleanup_branch( branch, immediate )
{
    branch notify( #"cleanup_branch" );
    
    if ( isdefined( branch.ents ) )
    {
        foreach ( scriptable in branch.ents )
        {
            if ( isdefined( scriptable ) )
            {
                scriptable thread molotov_pool_end( immediate );
            }
        }
    }
    
    if ( isdefined( branch.shareddata ) )
    {
        branch.shareddata = undefined;
    }
}

// Namespace molotov
// Params 2
// Checksum 0x3cd9fd23, Offset: 0x74ee
// Size: 0x171
function molotov_cleanup_pool( grenade, immediate )
{
    if ( isdefined( grenade.shareddata ) )
    {
        if ( isdefined( grenade.shareddata.branches ) )
        {
            foreach ( branch in grenade.shareddata.branches )
            {
                molotov_cleanup_branch( branch, immediate );
            }
        }
        
        if ( isdefined( grenade.shareddata.oldbranchents ) )
        {
            foreach ( scriptable in grenade.shareddata.oldbranchents )
            {
                if ( isdefined( scriptable ) )
                {
                    scriptable thread molotov_pool_end( immediate );
                }
            }
        }
        
        grenade.shareddata = undefined;
    }
}

// Namespace molotov
// Params 1
// Checksum 0x39a0b271, Offset: 0x7667
// Size: 0x46
function molotov_burn_destroy( immediate )
{
    molotov_cleanup_pool( self, istrue( immediate ) );
    
    if ( isdefined( self.shareddata.burnsource ) )
    {
        self.shareddata.burnsource delete();
    }
}

// Namespace molotov
// Params 1
// Checksum 0xe0189222, Offset: 0x76b5
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace molotov
// Params 0, eflags: 0x4
// Checksum 0xe98178ca, Offset: 0x76d4
// Size: 0x19, Type: bool
function private isunderwater()
{
    return ( isplayer( self ) || isagent( self ) ) && self isswimunderwater();
}

/#

    // Namespace molotov
    // Params 0
    // Checksum 0xbfd34b6c, Offset: 0x76f6
    // Size: 0x1a4, Type: dev
    function molotov_branch_draw_hits()
    {
        while ( true )
        {
            if ( self.shareddata.iscomplete )
            {
                break;
            }
            
            if ( self.iscomplete )
            {
                break;
            }
            
            if ( level.dbgmolodrawhits )
            {
                ids = getarraykeys( self.hitpositions );
                
                foreach ( id in ids )
                {
                    hitposition = self.hitpositions[ id ];
                    hittype = self.hittypes[ id ];
                    function_754027d2d07f55e9( hitposition, hittype, 0.05 );
                }
            }
            
            wait 0.05;
        }
        
        if ( level.dbgmolodrawhits )
        {
            ids = getarraykeys( self.hitpositions );
            
            foreach ( id in ids )
            {
                hitposition = self.hitpositions[ id ];
                hittype = self.hittypes[ id ];
                function_754027d2d07f55e9( hitposition, hittype, 5 );
            }
        }
    }

    // Namespace molotov
    // Params 3, eflags: 0x4
    // Checksum 0x4081cdff, Offset: 0x78a2
    // Size: 0xbe, Type: dev
    function private function_754027d2d07f55e9( hitposition, hittype, duration )
    {
        color = undefined;
        
        switch ( hittype )
        {
            case 0:
                color = ( 1, 1, 0 );
                break;
            case 2:
                color = ( 1, 0, 0 );
                break;
            case 3:
                color = ( 0, 0, 1 );
                break;
            default:
                color = ( 1, 1, 1 );
                break;
        }
        
        thread debug::drawsphere( hitposition, 2, duration, color );
    }

#/
