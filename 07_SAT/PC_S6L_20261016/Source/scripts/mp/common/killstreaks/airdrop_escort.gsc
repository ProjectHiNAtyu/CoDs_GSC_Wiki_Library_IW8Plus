// scripts\mp\common\killstreaks\airdrop_escort.gsc  (hash_2e13fba0234d3dc4.gscc) (size: 37041 Bytes / 0x90b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x362dbee8 (908967656)
// size ...... 37041 (0x90b1)
// includes .. 27  (offset: 0x89f1)
// strings ... 75  (offset: 0x8ac9)
// dev strs .. 18  (offset: 0x8f8d)
// exports ... 84  (offset: 0x59e5)
// cseg ...... 0x617 + 0x53ce (0x59e5)
// imports ... 292 (offset: 0x6705)
// animtree1 . 2   (offset: 0x9069)
// animtree2 . 3   (offset: 0x9081)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\chopper_gunner;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\turret_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;

#namespace airdrop_escort;

// Namespace airdrop_escort
// Params 0
// Checksum 0xcd1ab9e1, Offset: 0x635
// Size: 0xb9
function airdrop_escort_init()
{
    assert( isdefined( level.cratedropdata ), "<dev string:x24>" );
    
    if ( utility::issharedfuncdefined( #"airdrop_escort", #"init" ) )
    {
        [[ utility::getsharedfunc( #"airdrop_escort", #"init" ) ]]();
    }
    
    level function_72c63d7fd9560db1();
    level init_airdrop_escort_anims();
    level init_airdrop_escort_vo();
    level callback::add( #"hash_244314ef9125e636", &airdrop_escort_onplayerdeath );
    utility::registersharedfunc( #"airdrop_escort", #"dronegun_emp", &airdrop_escort_dronegun_emp );
    utility::registersharedfunc( #"airdrop_escort", #"hack", &hack );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x43b2a836, Offset: 0x6f6
// Size: 0x11e
function function_72c63d7fd9560db1()
{
    level.var_2441a790d317049c = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.var_6e06dd97fa85e7d1[ teamname ] = 0;
    }
    
    level.cratedropdata.escortchoppers = [];
    
    /#
        setdevdvarifuninitialized( @"hash_f8c88d9bcfa63da3", 0 );
        setdevdvarifuninitialized( @"hash_e9159b47fbb642af", 0 );
        setdevdvarifuninitialized( @"hash_94edbe8b5c5b8dd0", 0 );
        setdevdvarifuninitialized( @"scr_airdrop_escort_type", "<dev string:x7d>" );
        setdevdvarifuninitialized( @"hash_3691ec01fdbbe775", 0 );
        setdevdvarifuninitialized( @"hash_e840b848fd3fd3c9", 0 );
        setdevdvarifuninitialized( @"hash_3df9619fef03b423", 0 );
        setdevdvarifuninitialized( @"hash_f767cd931c8c9305", 0 );
    #/
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x5cf3dccc, Offset: 0x81c
// Size: 0x10
function init_airdrop_escort_anims()
{
    function_15edbebc83a32aba();
    function_76b8bffa6b200215();
}

#using_animtree( "script_model" );

// Namespace airdrop_escort
// Params 0
// Checksum 0x50fa1068, Offset: 0x834
// Size: 0x52
function function_15edbebc83a32aba()
{
    level.scr_animtree[ "ks_airdrop_escort_crate" ] = #animtree;
    level.scr_anim[ "ks_airdrop_escort_crate" ][ "crate_push_out_left" ] = %iw9_mp_esc_airdrop_pack_l;
    level.scr_anim[ "ks_airdrop_escort_crate" ][ "crate_push_out_right" ] = %iw9_mp_esc_airdrop_pack_r;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace airdrop_escort
// Params 0
// Checksum 0x2e170b5f, Offset: 0x88e
// Size: 0x33
function function_76b8bffa6b200215()
{
    level.scr_animtree[ "ks_airdrop_escort_heli" ] = #animtree;
    level.scr_anim[ "ks_airdrop_escort_heli" ][ "vehicle_doors_open" ] = %iw9_mp_esc_airdrop_helidoors;
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xc835cb9f, Offset: 0x8c9
// Size: 0x7e
function init_airdrop_escort_vo()
{
    game[ "dialog" ][ "airdrop_escort" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "airdrop_escort" + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "airdrop_escort" + "_destroyed" ] = "killstreak_team_leader" + "_crash";
    game[ "dialog" ][ "airdrop_escort" + "_spotted_target" ] = "killstreak_remote_operator" + "_target_spotted_single";
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xf7edcb7d, Offset: 0x94f
// Size: 0x22
function function_a471dd93a9304d5f()
{
    streakinfo = killstreak_utility::createstreakinfo( "airdrop_escort", self );
    return function_fb85603965ac497a( streakinfo );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x6e4765a4, Offset: 0x97a
// Size: 0x182, Type: bool
function function_795bcdc05c9eace8()
{
    level.var_2441a790d317049c++;
    var_b6bcf4d1037711a8 = 1;
    
    if ( game_utility::islargemap() )
    {
        var_b6bcf4d1037711a8 = 2;
    }
    
    if ( level.cratedropdata.escortchoppers.size >= var_b6bcf4d1037711a8 || level.cratedropdata.escortchoppers.size + level.incomingallchoppersupports > var_b6bcf4d1037711a8 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        level.var_2441a790d317049c--;
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.var_6e06dd97fa85e7d1[ self.team ]++;
        
        if ( killstreak_utility::getnumactivekillstreakperteam( self.team, level.cratedropdata.escortchoppers ) + level.var_6e06dd97fa85e7d1[ self.team ] > var_b6bcf4d1037711a8 )
        {
            level.var_2441a790d317049c--;
            level.var_6e06dd97fa85e7d1[ self.team ]--;
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO" );
            }
            
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    return true;
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x32b458cf, Offset: 0xb05
// Size: 0x36
function function_b7bfb6ef6ed9a93e()
{
    level.var_2441a790d317049c--;
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.var_6e06dd97fa85e7d1[ self.team ]--;
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xb3a44a8, Offset: 0xb43
// Size: 0x304
function function_fb85603965ac497a( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return 0;
    }
    
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "airdrop_escort" ];
    
    if ( bundle.var_ea2bc5fac224bd01 && !level.killstreakweaponmap[ bundle.var_ea2bc5fac224bd01 ] )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "airdrop_escort", bundle.var_ea2bc5fac224bd01, #"large" );
    }
    
    deployweaponobj = makeweapon( bundle.deployweaponname ?? "ks_gesture_phone_mp" );
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, deployweaponobj );
    
    if ( !deployresult )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        return 0;
    }
    
    streakinfo.streakduration = bundle.var_110153a0f2fc14e0 ?? 60;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return 0;
        }
    }
    
    var_e02a6d8483578273 = isdefined( bundle.inplaylimits ) && bundle.inplaylimits.size > 0;
    
    if ( !var_e02a6d8483578273 )
    {
        if ( !function_795bcdc05c9eace8() )
        {
            return 0;
        }
    }
    
    if ( utility::issharedfuncdefined( #"vehicle", #"incrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"incrementfauxvehiclecount" ) ]]();
    }
    
    useresult = function_fe4fcae6b5300dcc( self, self.origin, "overwatch", streakinfo );
    
    if ( !var_e02a6d8483578273 )
    {
        function_b7bfb6ef6ed9a93e();
    }
    
    if ( !useresult )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "airdrop_escort", self.origin );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "airdrop_escort", self );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "airdrop_escort" + "_use", #"use", 1, var_65934120c2efeb81 );
    killstreak_utility::function_e4f54128963e182( "airdrop_escort_turret_ballistics_mp" );
    return useresult;
}

// Namespace airdrop_escort
// Params 4
// Checksum 0x9e2b39e2, Offset: 0xe50
// Size: 0x5f, Type: bool
function function_fe4fcae6b5300dcc( owner, position, escorttype, streakinfo )
{
    escortheli = function_ddd3316e3a4a5b39( owner, owner.team, position, escorttype, streakinfo );
    
    if ( !isdefined( escortheli ) )
    {
        return false;
    }
    
    escortheli thread function_1043e04896114883( escorttype );
    return true;
}

// Namespace airdrop_escort
// Params 5
// Checksum 0x6b4fdb79, Offset: 0xeb8
// Size: 0xbb5
function function_ddd3316e3a4a5b39( owner, team, position, escorttype, streakinfo )
{
    vehicle_tracking::function_4f76f5b4541acef1();
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
    }
    
    heightoffset = ( 0, 0, 1000 + ( level.var_a79151b196b4e70c ?? 0 ) );
    var_f05c77bf02ca97c2 = heightoffset + ( 0, 0, 1000 );
    approachangles = owner.angles + ( 0, 180, 0 );
    pathgoal = position + var_f05c77bf02ca97c2;
    pathstart = pathgoal - anglestoforward( approachangles ) * 15000;
    bundle = streakinfo.bundle;
    
    if ( ( bundle.var_4ae9e70a0cc4d70d ?? #"level_heli_goals" ) == #"level_heli_goals" && !game_utility::islargemap() && isdefined( level.heli_structs_entrances ) && level.heli_structs_entrances.size > 0 )
    {
        var_53eeea462a8fe959 = randomint( level.heli_structs_entrances.size );
        entrancestruct = level.heli_structs_entrances[ var_53eeea462a8fe959 ];
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"findtargetstruct" ) )
        {
            goalstruct = [[ utility::getsharedfunc( #"chopper_gunner", #"findtargetstruct" ) ]]( entrancestruct.script_linkto, level.heli_structs_goals );
            
            if ( isdefined( goalstruct ) )
            {
                var_f05c77bf02ca97c2 = ( 0, 0, goalstruct.origin[ 2 ] + 1000 );
                var_ef058b074a4eda1d = entrancestruct.origin * ( 1, 1, 0 ) + var_f05c77bf02ca97c2;
                var_78591ed6a66cbafe = goalstruct.origin * ( 1, 1, 0 ) + var_f05c77bf02ca97c2;
                entranceforward = vectornormalize( var_78591ed6a66cbafe - var_ef058b074a4eda1d );
                pathstart = var_ef058b074a4eda1d;
                pathgoal = var_78591ed6a66cbafe + entranceforward * 1000;
                approachangles = vectortoangles( entranceforward );
            }
            else
            {
                /#
                    owner iprintlnbold( "<dev string:x87>" + entrancestruct.script_linkto + "<dev string:x97>" );
                #/
            }
        }
    }
    
    vehiclename = bundle.deployedvehicle ?? "veh_airdrop_escort_mp_phys";
    vehiclemodelname = bundle.var_e0230db751877a59 ?? "veh9_mil_air_heli_hind_mp";
    escortheli = vehicle_tracking::spawn_helicopter( undefined, pathstart, approachangles, vehiclename, vehiclemodelname );
    
    if ( !isdefined( escortheli ) )
    {
        return;
    }
    
    escortheli.bundle = bundle;
    
    if ( !isdefined( team ) )
    {
        team = "neutral";
    }
    
    if ( team != "neutral" )
    {
        escortheli setvehicleteam( team );
    }
    
    modifiedlifetime = bundle.var_110153a0f2fc14e0 ?? 60;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
    #/
    
    helohealth = bundle.maxhealth ?? 2000;
    
    /#
        if ( getdvarint( @"hash_3df9619fef03b423", 0 ) > 0 )
        {
            helohealth = 10;
        }
    #/
    
    var_9f96e551be6779fa = function_ad09b6f1c77b2c03( self.team );
    pathstart += ( 0, 0, var_9f96e551be6779fa );
    pathgoal += ( 0, 0, var_9f96e551be6779fa );
    escortheli.infilspeed = bundle.var_52c9d4ec2e5227aa;
    escortheli.speed = 100;
    escortheli.accel = 50;
    escortheli.lifetime = modifiedlifetime;
    escortheli.health = helohealth;
    escortheli.maxhealth = helohealth;
    escortheli.currenthealth = helohealth;
    escortheli.team = team;
    escortheli.owner = owner;
    escortheli.streakinfo = streakinfo;
    escortheli.streakinfo.var_bbd40c52f0758e34 = 1;
    escortheli.streakname = streakinfo.streakname;
    escortheli.flaresreservecount = 1;
    escortheli.pathstart = pathstart;
    escortheli.pathgoal = pathgoal;
    escortheli.currentaction = undefined;
    escortheli.patrolradius = 1000;
    escortheli.heightoffset = heightoffset;
    escortheli.entranceheightoffset = var_f05c77bf02ca97c2;
    escortheli.droplocation = position;
    escortheli.escorttype = escorttype;
    escortheli.animname = "ks_airdrop_escort_heli";
    escortheli.var_9f96e551be6779fa = var_9f96e551be6779fa;
    escortheli.var_9d378a2d9d07d239 = bundle.var_9b97c2cac93aa266;
    escortheli.var_57fc77af24a8791e = &function_ae6edf60b5cc7eaa;
    escortheli.var_bdc51be80cbeef82 = bundle.var_bdc51be80cbeef82;
    escortheli turret::function_537d073bfb1366da( bundle, owner );
    escortheli airdrop_escort_setupdamagefunctionality( streakinfo.streakname );
    escortheli setmaxpitchroll( 15, 15 );
    escortheli vehicle_setspeed( escortheli.speed, escortheli.accel );
    escortheli sethoverparams( 50, 5, 2.5 );
    escortheli setturningability( 1 );
    escortheli setyawspeed( 50, 25, 25, 0.5 );
    escortheli setotherent( owner );
    escortheli setcandamage( 1 );
    escortheli setneargoalnotifydist( 1000 );
    escortheli function_d2b8ee2e1275daaf( 1 );
    escortheli setturretscriptcontrolled( 1 );
    
    if ( !escortheli hascomponent( "c2p" ) )
    {
        escortheli addcomponent( "c2p" );
    }
    
    level thread killstreak_utility::function_6348c97b79ee8a08( escortheli, owner, &airdrop_escort_explode );
    
    if ( utility::issharedfuncdefined( #"airdrop_escort", #"attachxrays" ) )
    {
        escortheli = [[ utility::getsharedfunc( #"airdrop_escort", #"attachxrays" ) ]]( escortheli );
    }
    
    escortheli emp_debuff::set_start_emp_callback( &airdrop_escort_empstarted );
    escortheli emp_debuff::set_clear_emp_callback( &airdrop_escort_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        escortheli.ksempapplycallback = &function_4649e5fdd0004900;
    }
    
    if ( escortheli getscriptablehaspart( #"blinking_lights" ) )
    {
        escortheli setscriptablepartstate( #"blinking_lights", #"on", 0 );
    }
    
    escortheli setscriptablepartstate( "engine", "on", 0 );
    shouldspawnturret = !bundle.var_83d4a056dafdb9d0;
    
    /#
        escortheli thread chopper_gunner::function_3e61d70aeabde5b3();
    #/
    
    if ( shouldspawnturret )
    {
        turret_tag = escortheli tagexists( #"tag_turret" ) ? #"tag_turret" : #"tag_gunner_brass1";
        escortheli.turret = spawnturret( "misc_turret", escortheli gettagorigin( turret_tag ), bundle.var_442269833ef7493a ?? "airdrop_escort_turret_ballistics_mp" );
        escortheli.turret setmodel( bundle.var_e7baf60640512b36 ?? "veh9_mil_air_heli_hind_turret_mp" );
        escortheli.turret.owner = escortheli.owner;
        escortheli.turret.team = escortheli.team;
        escortheli.turret.angles = escortheli.angles;
        escortheli.turret.streakinfo = escortheli.streakinfo;
        escortheli.turret.disabled = 0;
        escortheli.turret.targetstate = undefined;
        escortheli.turret linkto( escortheli, turret_tag );
        escortheli.turret setturretteam( escortheli.team );
        escortheli.turret setturretmodechangewait( 0 );
        escortheli.turret setmode( "manual" );
        escortheli.turret setotherent( escortheli.owner );
        escortheli.turret setdefaultdroppitch( 45 );
        escortheli.turret.var_9cc64b926699342e = 1;
    }
    else
    {
        escortheli.turret = escortheli;
        escortheli.turret.var_9cc64b926699342e = 0;
    }
    
    groundtargetorigin = escortheli.origin - ( 0, 0, 100 ) + anglestoforward( escortheli.angles ) * 500;
    escortheli.turret.groundtargetent = spawn( "script_model", groundtargetorigin );
    escortheli.turret.groundtargetent setmodel( "tag_origin" );
    escortheli.turret.groundtargetent linkto( escortheli.turret );
    escortheli.turret.groundtargetent dontinterpolate();
    
    if ( escortheli.turret.var_9cc64b926699342e )
    {
        escortheli.turret settargetentity( escortheli.turret.groundtargetent );
    }
    
    escortheli.killcament = spawn( "script_model", escortheli.turret gettagorigin( escortheli.turret tagexists( #"bi_center" ) ? #"bi_center" : #"tag_origin" ) );
    escortheli.killcament linkto( escortheli, "tag_origin", ( -1000, 0, 700 ), ( 0, 0, 0 ) );
    escortheli.turret.killcament = escortheli.killcament;
    
    if ( isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
        {
            escortheli [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( escortheli.streakname, "Killstreak_Air", owner, 0, bundle.headicon_enable, 100 );
        }
        
        if ( team != "neutral" )
        {
            escortheli sentientpoolmanager::registersentient( "Killstreak_Air", owner );
        }
    }
    
    escortheli utility::callsharedfunc( #"flare_system", #"defender_init", escortheli.flaresreservecount, 15, 3, 1, 1 );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_9dfc6caeaa94af03", escortheli.origin, escortheli.team, escortheli.owner, escortheli );
    }
    
    level.cratedropdata.escortchoppers = arraycombineunique( level.cratedropdata.escortchoppers, [ escortheli ] );
    return escortheli;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xd750f7, Offset: 0x1a76
// Size: 0x16a
function airdrop_escort_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "airdrop_escort" + "_destroyed";
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_2a2b25f1e58ea995;
    var_d188942a41771ea1 = &function_b71e65c8e50e3a67;
    premoddamagecallback = &airdrop_escort_premodifydamage;
    postmoddamagecallback = &airdrop_escort_postmodifydamage;
    deathcallback = &airdrop_escort_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    bundle = self.bundle;
    lightdamagethreshold = bundle.var_3c99571637b13cb3 ?? 1500;
    mediumdamagethreshold = bundle.var_5cba4c7b9a78f5a8 ?? 1000;
    heavydamagethreshold = bundle.var_306657a4cf77379e ?? 500;
    killstreak_utility::function_b555369eba6b0252( 1, lightdamagethreshold, &function_461dbc07d7d7b3f7 );
    killstreak_utility::function_b555369eba6b0252( 2, mediumdamagethreshold, &function_16f650ed10ae0ee0 );
    killstreak_utility::function_b555369eba6b0252( 3, heavydamagethreshold, &function_87da86eef09a895e );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xcd714870, Offset: 0x1be8
// Size: 0x17
function function_2a2b25f1e58ea995( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x81beae86, Offset: 0x1c07
// Size: 0xc
function function_b71e65c8e50e3a67( streakname )
{
    
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x5e0e6704, Offset: 0x1c1b
// Size: 0x117, Type: bool
function airdrop_escort_premodifydamage( data )
{
    /#
        if ( getdvarint( @"hash_3df9619fef03b423", 0 ) > 0 )
        {
            self.var_9d378a2d9d07d239 = 0;
        }
    #/
    
    if ( self.var_9d378a2d9d07d239 && data.attacker === self.owner && isdefined( self.owner ) )
    {
        return false;
    }
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = self.bundle;
        data.iskillstreak = 1;
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    
    return true;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x23698060, Offset: 0x1d3b
// Size: 0xfb, Type: bool
function airdrop_escort_postmodifydamage( data )
{
    attacker = data.attacker;
    damage = data.damage;
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    
    if ( !isdefined( self.var_57b4f05eb0eb149 ) )
    {
        if ( self.currenthealth / self.maxhealth <= 0.5 )
        {
            self.var_57b4f05eb0eb149 = 1;
            
            if ( self.owner )
            {
                self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"taking_damage", 1 );
            }
        }
    }
    
    if ( isdefined( self.var_7e833ce89ba46839 ) )
    {
        if ( isdefined( attacker.guid ) )
        {
            self.var_7e833ce89ba46839[ attacker.guid ] = gettime();
        }
    }
    
    return true;
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x4dd91eb7, Offset: 0x1e3f
// Size: 0x12
function function_461dbc07d7d7b3f7()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x1acc270c, Offset: 0x1e59
// Size: 0x12
function function_16f650ed10ae0ee0()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xe5ba3d4e, Offset: 0x1e73
// Size: 0x12
function function_87da86eef09a895e()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xcd9876fb, Offset: 0x1e8d
// Size: 0x3a, Type: bool
function airdrop_escort_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    killstreak::function_80e13cda8d6717d7( 0 );
    thread function_5e11a94edc9c8b4a( self.killedbyweapon );
    return true;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xd277c95a, Offset: 0x1ed0
// Size: 0xc3
function function_5e11a94edc9c8b4a( weaponkilledby )
{
    self endon( #"explode" );
    self.owner thread killstreaks::function_649e7dd0bd47ed08( self.streakinfo, getdvarfloat( @"hash_2c20dac7438222f8", 2.5 ) );
    bundle = self.bundle;
    var_99d89690609c7fb2 = 1;
    
    if ( !bundle.var_2508682345adcd67 )
    {
        iskillstreakweaponfunc = level.sharedfuncs[ #"killstreak" ][ #"iskillstreakweapon" ];
        
        if ( isdefined( iskillstreakweaponfunc ) && [[ iskillstreakweaponfunc ]]( weaponkilledby ) )
        {
            var_99d89690609c7fb2 = 0;
        }
    }
    
    if ( var_99d89690609c7fb2 )
    {
        airdrop_escort_crash( 150, weaponkilledby );
    }
    
    thread airdrop_escort_explode();
}

// Namespace airdrop_escort
// Params 3
// Checksum 0xd6c51922, Offset: 0x1f9b
// Size: 0x227
function airdrop_escort_crash( speed, weaponkilledby, var_efd6abd0ea217b3d )
{
    self endon( #"explode" );
    self clearlookatent();
    self notify( #"crashing" );
    playsoundatpos( self.origin, "exp_escort_helo" );
    self setmaxpitchroll( 10, 50 );
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    bundle = self.bundle;
    mindistance = bundle.var_9a34a6c279ea5695 ?? 500;
    maxdistance = bundle.var_9a5890c27a12a0eb ?? 4000;
    distance = randomintrange( mindistance, maxdistance );
    var_61f902b2dd6fc262 = chopper_gunner::choppergunner_findcrashposition( distance, bundle.crashzoffset ?? 1100 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        if ( bundle.var_8ca30ca22499a703 )
        {
            var_61f902b2dd6fc262 = chopper_gunner::choppergunner_findcrashposition( mindistance, bundle.crashzoffset ?? 1100 );
            
            if ( !isdefined( var_61f902b2dd6fc262 ) )
            {
                var_61f902b2dd6fc262 = self.origin - ( 0, 0, bundle.crashzoffset ?? 1100 );
            }
        }
        else
        {
            return;
        }
    }
    
    /#
        if ( var_efd6abd0ea217b3d )
        {
            sphere( var_61f902b2dd6fc262, 100, ( 0, 1, 0 ), 0, 500 );
            line( self.origin, var_61f902b2dd6fc262, ( 0, 1, 0 ), 1, 0, 500 );
        }
    #/
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread chopper_gunner::choppergunner_spinout( speed );
    self setscriptablepartstate( #"spinout", #"on" );
    
    if ( bundle.var_437d79d0d4c77860 )
    {
        self function_d2b8ee2e1275daaf( 0 );
        self vehphys_enablecollisioncallback( 1 );
        thread traceforanycollision();
        crashtime = bundle.var_59c1f28fba40f5b5 ?? 5;
        utility::waittill_any_timeout( crashtime, "collision" );
        self notify( #"stop_trace_for_any_collision" );
        self function_d2b8ee2e1275daaf( 1 );
        self vehphys_enablecollisioncallback( 0 );
    }
    
    killstreak_utility::function_daa9374e3f6779a5( "airdrop_escort" );
}

// Namespace airdrop_escort
// Params 0, eflags: 0xc
// Checksum 0x3bb4acad, Offset: 0x21ca
// Size: 0x111
function private traceforanycollision()
{
    self notify( #"hash_92fd96d0a588c569" );
    self endon( #"hash_92fd96d0a588c569" );
    self endon( #"traceforanycollision", #"death", #"stop_trace_for_any_collision" );
    ignorelist = [ self, self.turret ];
    
    while ( true )
    {
        currentpos = self.origin;
        velocity = self vehicle_getvelocity();
        testpos = currentpos + velocity * level.framedurationseconds;
        collisiontrace = trace::sphere_trace( currentpos, testpos, 250, ignorelist );
        
        /#
            if ( getdvarint( @"hash_e840b848fd3fd3c9", 0 ) > 0 )
            {
                thread debug_utility::drawsphere( testpos, 250, level.framedurationseconds, ( 1, 0, 0 ) );
            }
        #/
        
        if ( isdefined( collisiontrace ) )
        {
            if ( collisiontrace[ "hittype" ] != "hittype_none" )
            {
                self notify( #"collision" );
            }
        }
        
        waitframe();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x476defba, Offset: 0x22e3
// Size: 0xe
function airdrop_escort_getcratedropcaststart( position )
{
    return position;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xa3127482, Offset: 0x22fa
// Size: 0x1a6
function function_1043e04896114883( escorttype )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    thread airdrop_escort_watchdisowned();
    thread airdrop_escort_watchgameendleave();
    self setvehgoalpos( self.pathgoal, 1 );
    
    if ( isdefined( self.infilspeed ) )
    {
        self vehicle_setspeedimmediate( self.infilspeed );
    }
    
    self waittill( #"near_goal" );
    self vehicle_setspeed( int( self.speed / 4 ), int( self.accel / 4 ) );
    self setneargoalnotifydist( 300 );
    thread airdrop_escort_watchlifetime();
    self waittill( #"goal" );
    
    if ( escorttype == "crate" )
    {
        self.defaultaction = "heli_patrol";
        self.defaultactionfunc = &airdrop_escort_patrolfield;
        thread function_d3cc7edc7f66308();
        wait 1;
    }
    else
    {
        self.defaultaction = "heli_overwatch";
        self.defaultactionfunc = &function_bb606bfa60e0a703;
        
        if ( self.owner )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"arrive", 1 );
        }
        
        thread function_bb606bfa60e0a703();
        
        if ( self.bundle.var_41a138042da8063f )
        {
            thread function_7c893d8f64799c54();
        }
    }
    
    thread function_47ad1226ec0b0129( self.turret );
    
    if ( !self.turret.var_9cc64b926699342e )
    {
        thread function_b63649a4701bb409();
    }
}

// Namespace airdrop_escort
// Params 1, eflags: 0xc
// Checksum 0x947ef57a, Offset: 0x24a8
// Size: 0xaf
function private function_b1b3b8f7f5848ed5( duration )
{
    self notify( #"hash_b03c0cd9cfdda9d4" );
    self endon( #"hash_b03c0cd9cfdda9d4" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self.turret notify( #"lost_target" );
    airdrop_escort_empstarted();
    self setscriptablepartstate( #"hacked", #"disabled", 0 );
    wait duration / 1000;
    airdrop_escort_empcleared();
    self setscriptablepartstate( #"hacked", #"off", 0 );
}

// Namespace airdrop_escort
// Params 2, eflags: 0x4
// Checksum 0xad1a0200, Offset: 0x255f
// Size: 0xa1
function private hack( hackeffect, attacker )
{
    if ( hackeffect.hackduration )
    {
        if ( self.owner )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
        }
        
        thread function_b1b3b8f7f5848ed5( hackeffect.hackduration );
        return;
    }
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed_hacked" );
    }
    
    self.explosionowner = attacker;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xbfbd2239, Offset: 0x2608
// Size: 0x22
function airdrop_escort_empstarted( data )
{
    self.turret.disabled = 1;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x2781b8b2, Offset: 0x2632
// Size: 0x21
function airdrop_escort_empcleared( fromdeath )
{
    self.turret.disabled = 0;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x96bcbb, Offset: 0x265b
// Size: 0x1a
function function_4649e5fdd0004900( data )
{
    if ( isdefined( self ) )
    {
        airdrop_escort_handledeathdamage( data );
    }
}

// Namespace airdrop_escort
// Params 2
// Checksum 0x2e16379e, Offset: 0x267d
// Size: 0x97
function airdrop_escort_dronegun_emp( data, time )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self notify( #"airdrop_escort_dronegunhit" );
    self endon( #"airdrop_escort_dronegunhit" );
    self.turret notify( #"lost_target" );
    airdrop_escort_empstarted();
    self.var_2b50670318ad3e02 = 1;
    wait time;
    self.var_2b50670318ad3e02 = undefined;
    airdrop_escort_empcleared();
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xae9fd31d, Offset: 0x271c
// Size: 0xdb
function airdrop_escort_watchlifetime()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self.lifetimeendtime = int( self.lifetime * 1000 + gettime() );
    halflifetime = self.lifetime * 0.5;
    wait halflifetime;
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"time_check", 1 );
    }
    
    wait halflifetime;
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"time_out", 1 );
    }
    
    thread airdrop_escort_leave();
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x541c4e50, Offset: 0x27ff
// Size: 0x8a
function airdrop_escort_watchdisowned()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    
    if ( !isdefined( self.owner ) || self.owner.team != self.team )
    {
        thread airdrop_escort_leave();
        return;
    }
    
    self.owner utility::waittill_any( "joined_team", "disconnect" );
    thread airdrop_escort_leave();
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x82b98772, Offset: 0x2891
// Size: 0x9c
function airdrop_escort_watchgameendleave()
{
    self endon( #"death", #"explode", #"crashing", #"leaving" );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread airdrop_escort_leave();
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xdda74db, Offset: 0x2935
// Size: 0x225
function function_d3cc7edc7f66308()
{
    self endon( #"death", #"explode", #"crashing", #"leaving" );
    self.owner endon( #"disconnect" );
    dooranim = level.scr_anim[ "ks_airdrop_escort_heli" ][ "vehicle_doors_open" ];
    dooranimlength = getanimlength( dooranim );
    thread animation::anim_single_solo( self, "vehicle_doors_open" );
    wait dooranimlength;
    streaknames = [];
    numcrates = 2;
    crateindex = 0;
    crateowner = self.owner;
    crateteam = self.team;
    cratetype = isdefined( self.owner ) ? "killstreak" : "killstreak_no_owner";
    crateorigin = self gettagorigin( "body_animate_jnt" );
    crateangles = self.angles;
    cratedestination = self.droplocation;
    hasnophysics = 0;
    var_e9a9d186782e327b = 0;
    skipminimapicon = 0;
    animname = "crate_push_out_left";
    
    for ( i = 0; i < numcrates ; i++ )
    {
        streakname = undefined;
        
        if ( streaknames.size > 0 )
        {
            streakname = airdrop::getrandomkillstreak( streaknames );
        }
        else
        {
            streakname = airdrop::getrandomkillstreak();
        }
        
        cratedropdata = airdrop::getkillstreakcratedatabystreakname( streakname, 0 );
        
        if ( crateindex >= 1 )
        {
            animname = "crate_push_out_right";
            crateindex = 0;
        }
        
        crate = airdrop::createcrate( crateowner, crateteam, cratetype, crateorigin, crateangles, cratedestination, hasnophysics, var_e9a9d186782e327b, cratedropdata, skipminimapicon );
        crate.streakinfo = self.streakinfo;
        crate.animname = "ks_airdrop_escort_crate";
        crate animation::setanimtree();
        thread airdrop_escort_dropcrate( crate, animname, "body_animate_jnt" );
        streaknames[ streaknames.size ] = streakname;
        crateindex++;
        wait 0.5;
    }
}

// Namespace airdrop_escort
// Params 3
// Checksum 0xcd047c5d, Offset: 0x2b62
// Size: 0x75
function airdrop_escort_dropcrate( crate, animname, animtag )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    animation::anim_single_solo( crate, animname, animtag );
    crate stopanimscripted();
    crate airdrop::cratephysicson();
}

// Namespace airdrop_escort
// Params 3
// Checksum 0x27cfefa6, Offset: 0x2bdf
// Size: 0x32, Type: bool
function function_2fe4ed1e522e7eab( startingpos, currenttarget, rangesquared )
{
    return distance2dsquared( startingpos, currenttarget.origin ) <= rangesquared;
}

// Namespace airdrop_escort
// Params 3
// Checksum 0x1dcc38fa, Offset: 0x2c1a
// Size: 0x32, Type: bool
function function_7cc3cecf65b5ec98( startingpos, currenttarget, rangesquared )
{
    return distance2dsquared( startingpos, currenttarget.origin ) <= rangesquared;
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x5fa70ba7, Offset: 0x2c55
// Size: 0x110
function airdrop_escort_patrolfield()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"heli_attack" );
    level endon( #"game_ended" );
    self notify( #"heli_patrol" );
    self.currentaction = "heli_patrol";
    self clearlookatent();
    self setneargoalnotifydist( 300 );
    startingangle = 0;
    
    while ( true )
    {
        if ( self.currentaction == "heli_attack" )
        {
            waitframe();
            continue;
        }
        
        newgoal = self.pathgoal + anglestoforward( ( 0, startingangle, 0 ) ) * int( self.patrolradius / 1.2 );
        
        /#
            level thread debug_utility::drawsphere( newgoal, 100, 5, ( 1, 1, 1 ) );
        #/
        
        startingangle += 90;
        airdrop_escort_movetolocation( newgoal, 0 );
        
        if ( startingangle >= 360 )
        {
            startingangle = 0;
        }
        
        wait 0.5;
    }
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x736cdf40, Offset: 0x2d6d
// Size: 0xb3
function function_bb606bfa60e0a703()
{
    if ( !self.owner )
    {
        return;
    }
    
    self endon( #"death", #"explode", #"crashing", #"leaving", #"heli_attack", #"heli_guard_location" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self notify( #"heli_overwatch" );
    self.currentaction = "heli_overwatch";
    self clearlookatent();
    self setlookatent( self.owner );
    
    while ( true )
    {
        airdrop_escort_movetolocation( self.owner, 1 );
        waitframe();
    }
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xb48cf00a, Offset: 0x2e28
// Size: 0xc9
function function_6e67c49f2985e561()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self endon( #"heli_attack" );
    self endon( #"heli_overwatch" );
    level endon( #"game_ended" );
    
    if ( !self.var_14e157060657afca )
    {
        assertmsg( "<dev string:xa6>" );
        function_4cbce4ccb29e85ef();
        return;
    }
    
    self notify( #"heli_guard_location" );
    self.currentaction = "heli_guard_location";
    self clearlookatent();
    self setlookatent( self.var_14e157060657afca );
    
    while ( self.var_14e157060657afca )
    {
        airdrop_escort_movetolocation( self.var_14e157060657afca, 1 );
        waitframe();
    }
}

// Namespace airdrop_escort
// Params 1, eflags: 0x4
// Checksum 0x739e35e2, Offset: 0x2ef9
// Size: 0x63
function private function_ad09b6f1c77b2c03( team )
{
    if ( !isdefined( team ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_3eb415f3b0b5fc83[ team ] ) )
    {
        if ( !isdefined( level.var_3eb415f3b0b5fc83 ) )
        {
            level.var_3eb415f3b0b5fc83 = [];
        }
        
        level.var_3eb415f3b0b5fc83[ team ] = level.var_3eb415f3b0b5fc83.size * 300;
    }
    
    return level.var_3eb415f3b0b5fc83[ team ];
}

// Namespace airdrop_escort
// Params 2
// Checksum 0x27a03f99, Offset: 0x2f65
// Size: 0x28b
function airdrop_escort_movetolocation( target, forcestopatgoal )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self notify( #"escort_moving" );
    self endon( #"escort_moving" );
    newpos = undefined;
    testtarget = target;
    
    if ( !isvector( target ) )
    {
        testtarget = target.origin;
    }
    
    ignorelist = [ self, self.turret ];
    var_15fa92b63caaaf1b = level.var_2cd8c4ce0ea66936 ?? trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1 );
    
    while ( true )
    {
        currentpos = self.origin;
        initialgoalpos = testtarget * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
        obstructiontrace = trace::sphere_trace( currentpos, initialgoalpos, 350, ignorelist );
        obstructed = 0;
        xpos = testtarget[ 0 ];
        ypos = testtarget[ 1 ];
        
        if ( isdefined( obstructiontrace ) )
        {
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                xpos = obstructiontrace[ "position" ][ 0 ];
                ypos = obstructiontrace[ "position" ][ 1 ];
                obstructed = 1;
            }
        }
        
        var_c093364bdec06d41 = undefined;
        
        if ( level.cratedropdata.escortchoppers.size > 1 && level.cratedropdata.escortchoppers[ 0 ] == self )
        {
            var_c093364bdec06d41 = level.cratedropdata.escortchoppers;
        }
        
        properz = chopper_support::getcorrectheight( xpos, ypos, 20, 512, var_c093364bdec06d41, var_15fa92b63caaaf1b );
        newpos = ( xpos, ypos, properz );
        
        if ( !obstructed )
        {
            obstructiontrace = trace::sphere_trace( currentpos, newpos, 350, ignorelist );
            
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                xpos = obstructiontrace[ "position" ][ 0 ];
                ypos = obstructiontrace[ "position" ][ 1 ];
                obstructed = 1;
            }
            
            properz = chopper_support::getcorrectheight( xpos, ypos, 20, 512, var_c093364bdec06d41, var_15fa92b63caaaf1b );
            newpos = ( xpos, ypos, properz );
        }
        
        stopatgoal = 0;
        
        if ( forcestopatgoal && !obstructed )
        {
            stopatgoal = forcestopatgoal;
        }
        
        self setvehgoalpos( newpos, stopatgoal );
        utility::waittill_any( "near_goal" );
        
        if ( !obstructed )
        {
            break;
        }
    }
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x4de360bd, Offset: 0x31f8
// Size: 0x277
function airdrop_escort_leave()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self clearlookatent();
    self setmaxpitchroll( 0, 0 );
    self notify( #"leaving" );
    self.var_b8aae568e66b4bc7 = 1;
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "airdrop_escort" + "_leave", #"leave", 1 );
    var_afb8f3b781e97c77 = 3;
    flightheightoffset = ( 0, 0, 1000 );
    var_7de37a63fdf1b0f = self.origin + flightheightoffset;
    leavestart = undefined;
    leavegoal = undefined;
    leaveangles = undefined;
    var_be0a736337c0a870 = ( 0, 0, self.var_9f96e551be6779fa );
    
    while ( var_afb8f3b781e97c77 > 0 )
    {
        flightpath = killstreak_utility::function_9c51f918f2c46115( var_7de37a63fdf1b0f, self.angles, 350, 25000 );
        
        if ( isdefined( flightpath.end ) )
        {
            leavestart = flightpath.start + var_be0a736337c0a870;
            leavegoal = flightpath.end + var_be0a736337c0a870;
            leaveangles = flightpath.angles;
            break;
        }
        
        var_7de37a63fdf1b0f += ( 0, 0, 1000 );
        var_afb8f3b781e97c77--;
        wait 0.05;
    }
    
    if ( !isdefined( leavegoal ) )
    {
        thread airdrop_escort_explode();
        return;
    }
    
    turnspeed = 150;
    ascendspeed = 50;
    self setyawspeed( turnspeed, 50, 25, 0 );
    self settargetyaw( leaveangles[ 1 ] );
    self vehicle_setspeed( ascendspeed, 25 );
    pathgoal = leavestart;
    self setvehgoalpos( pathgoal, 1 );
    utility::waittill_any_timeout( 3, "goal" );
    failsafetime = 0;
    
    while ( failsafetime < 2 )
    {
        currentyaw = ( 0, self.angles[ 1 ], 0 );
        yawdiff = leaveangles - currentyaw;
        
        if ( abs( yawdiff[ 1 ] ) < 5 )
        {
            break;
        }
        
        failsafetime += level.framedurationseconds;
        waitframe();
    }
    
    self setmaxpitchroll( 15, 15 );
    self vehicle_setspeed( 150, self.accel );
    self setvehgoalpos( leavegoal, 1 );
    self setneargoalnotifydist( 1000 );
    utility::waittill_any_timeout( 10, "near_goal" );
    thread airdrop_escort_cleanup( 0 );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xa4bf2489, Offset: 0x3477
// Size: 0x6d
function airdrop_escort_explode()
{
    if ( self.isexploding )
    {
        return;
    }
    
    self notify( #"explode" );
    self.isexploding = 1;
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed", 1 );
    }
    
    function_c4e3922085f5dcae();
    wait 0.35;
    airdrop_escort_cleanup( 1 );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x4c9ca71c, Offset: 0x34ec
// Size: 0xbb
function function_c4e3922085f5dcae()
{
    bundle = self.bundle;
    
    if ( bundle.var_867935d07aec268e )
    {
        self.health = 9999;
        attacker = self.explosionowner ?? self.owner ?? self;
        self radiusdamage( self.origin, bundle.var_fb110c17ae2595f3 ?? 625, bundle.var_4dc9acccb4ce5279 ?? 200, bundle.var_4da69eccb4a7ebf7 ?? 200, attacker, "MOD_EXPLOSIVE", bundle.var_ea2bc5fac224bd01, undefined, undefined, undefined, 0 );
    }
    
    self setscriptablepartstate( "explode", "on", 0 );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x658ea212, Offset: 0x35af
// Size: 0x1d0
function airdrop_escort_cleanup( wasdestroyed )
{
    if ( self.iscleaning )
    {
        return;
    }
    
    self.iscleaning = 1;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    turret::function_2ef86cb867c53ac1( self.owner );
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:xf7>", self.owner );
        }
    #/
    
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    self stoploopsound();
    
    if ( isdefined( self.turret ) )
    {
        if ( isdefined( self.turret.groundtargetent ) )
        {
            self.turret.groundtargetent delete();
        }
        
        if ( self.turret.var_9cc64b926699342e )
        {
            self.turret setentityowner( undefined );
            self.turret delete();
        }
    }
    
    if ( isdefined( self.testtarget ) )
    {
        self.testtarget delete();
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    function_3049cf4cb603f6d3();
    level.cratedropdata.escortchoppers = arrayremove( level.cratedropdata.escortchoppers, self );
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
    self.owner.var_2caafa207b756de9 = undefined;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x27574033, Offset: 0x3787
// Size: 0x262
function function_47ad1226ec0b0129( turret )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    /#
        thread function_18f1bde1fcff2060();
        thread function_ec865325b756ca73();
    #/
    
    childthread airdrop_escort_watchturretfire();
    bundle = self.bundle;
    attackrange = bundle.var_65af38e80a0eebea ?? 4000;
    
    while ( true )
    {
        var_35a5abbad083d57a = getdvarint( @"hash_94edbe8b5c5b8dd0", 0 );
        
        if ( turret.disabled )
        {
            waitframe();
            continue;
        }
        
        if ( self.currentaction == "heli_overwatch" || self.currentaction == "heli_guard_location" )
        {
            var_a0377684de9b63f6 = 1;
            
            if ( self.currentaction == "heli_overwatch" )
            {
                goallocation = self.owner.origin;
            }
            else
            {
                goallocation = self.var_14e157060657afca.origin;
            }
            
            if ( bundle.var_2348f0cb9bb80f81 && goallocation )
            {
                if ( !isdefined( self.var_f8c2edcc79d3e405 ) )
                {
                    self.var_f8c2edcc79d3e405 = squared( bundle.var_ee191f964ccd7b2d ?? 2100 );
                }
                
                /#
                    if ( getdvarint( @"hash_3691ec01fdbbe775", 0 ) > 0 )
                    {
                        self.var_f8c2edcc79d3e405 = squared( getdvarint( @"hash_3691ec01fdbbe775", 0 ) );
                    }
                #/
                
                if ( distancesquared( self.origin, goallocation ) < self.var_f8c2edcc79d3e405 )
                {
                    var_a0377684de9b63f6 = 0;
                }
            }
            
            if ( self.currentaction == "heli_overwatch" && var_a0377684de9b63f6 )
            {
                self waittill( #"near_goal" );
            }
        }
        
        if ( !var_35a5abbad083d57a )
        {
            besttargetdata = turret::turret_getbesttargetdata( turret, bundle, attackrange, 1, 0, 0, "lost_target", @"hash_f8c88d9bcfa63da3" );
            
            if ( isdefined( besttargetdata ) )
            {
                function_f5fea8d2713ceb28( besttargetdata );
            }
            
            if ( self.currentaction != self.defaultaction )
            {
                self thread [[ self.defaultactionfunc ]]();
                wait bundle.var_f37d58d103b32e48 ?? 2;
            }
        }
        
        wait 0.05;
    }
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xbdd42e91, Offset: 0x39f1
// Size: 0x6d
function airdrop_escort_watchturretfire()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.turret waittill( #"missile_fire", projectile );
        projectile.streakinfo = self.streakinfo;
        projectile.killcament = self.killcament;
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x184d34d2, Offset: 0x3a66
// Size: 0x29c
function function_f5fea8d2713ceb28( targetdata )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"heli_patrol" );
    self endon( #"heli_overwatch" );
    self endon( #"heli_guard_location" );
    bundle = self.bundle;
    assert( isdefined( bundle ) );
    attackdelay = bundle.var_910575b006687572 ?? 1;
    
    if ( isdefined( self.owner ) && self.owner player::isreallyalive() && ( !isdefined( self.lastfiretime ) || self.lastfiretime + 15000 <= gettime() ) )
    {
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "airdrop_escort" + "_spotted_target", #"spotted_single", 1 );
        self.lastfiretime = gettime();
    }
    
    self notify( #"heli_attack" );
    self.currentaction = "heli_attack";
    turret = self.turret;
    playertotarget = turret::function_93d9d997ab45c443( targetdata );
    var_91ee89318c722966 = turret::function_9d37296f838c74c6( targetdata );
    airdrop_escort_settargetstate( "target_normal" );
    self setlookatent( playertotarget );
    self setvehgoalpos( self.origin + anglestoforward( self.angles ) * 500, 1 );
    
    if ( !isdefined( self.previousbesttarget ) || isdefined( self.previousbesttarget ) && self.previousbesttarget != playertotarget && !isdefined( self.var_2b50670318ad3e02 ) )
    {
        var_51c7610d3b8a2032 = playertotarget;
        var_6675b0888e2dbc2 = function_1bf3a084cfe14025( 4 );
        newpingindex = self.owner calloutmarkerping::function_a3f0d6526c09f579( var_6675b0888e2dbc2, var_51c7610d3b8a2032.origin + ( 0, 0, 50 ) );
        self.owner thread calloutmarkerping::predicted_timeout( newpingindex );
        thread function_e2d13cc661b0e7e8( playertotarget, bundle.var_bdfd642df9e33780 ?? 5 );
    }
    
    airdrop_escort_watchforlosttarget( targetdata );
    airdrop_escort_lockontarget( targetdata, bundle.var_83820b454087fe24 ?? 10 );
    
    while ( function_ca2d893250c8cae4() && turret::function_8202b7c43f73cc3b( turret, playertotarget ) )
    {
        wait attackdelay;
        function_d590c234b8e38559( targetdata );
    }
    
    return "stopped_firing";
}

// Namespace airdrop_escort
// Params 2
// Checksum 0xa2077ffe, Offset: 0x3d0b
// Size: 0x75
function function_e2d13cc661b0e7e8( playertotarget, delay )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    self notify( #"new_prev_target" );
    self endon( #"new_prev_target" );
    self.previousbesttarget = playertotarget;
    wait delay;
    self.previousbesttarget = undefined;
}

// Namespace airdrop_escort
// Params 2
// Checksum 0x84e71a52, Offset: 0x3d88
// Size: 0x1ed
function airdrop_escort_lockontarget( targetdata, anglethreshold )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"heli_patrol" );
    turret = self.turret;
    var_c0ef1f44663b3883 = undefined;
    var_91ee89318c722966 = turret::function_9d37296f838c74c6( targetdata );
    playertotarget = turret::function_93d9d997ab45c443( targetdata );
    var_baba9b5c08d6048c = 0;
    sfxplayer = undefined;
    
    if ( isdefined( var_91ee89318c722966 ) )
    {
        var_c0ef1f44663b3883 = var_91ee89318c722966.origin;
    }
    else
    {
        if ( isplayer( playertotarget ) )
        {
            var_c0ef1f44663b3883 = playertotarget gettagorigin( "j_mainroot" );
        }
        else
        {
            var_c0ef1f44663b3883 = playertotarget.origin;
        }
        
        var_baba9b5c08d6048c = 1;
        sfxplayer = playertotarget;
    }
    
    if ( var_baba9b5c08d6048c )
    {
        bundle = self.bundle;
        var_7d4c9e01851913b2 = bundle.var_b80a8f729ed47b5d;
        
        if ( isdefined( var_7d4c9e01851913b2 ) )
        {
            sfxplayer playsoundtoplayer( var_7d4c9e01851913b2, sfxplayer, self );
        }
        
        var_8f400b9bbb94574f = bundle.var_6b56e69895ef114;
        
        if ( isdefined( var_8f400b9bbb94574f ) && isdefined( sfxplayer.team ) )
        {
            sfxplayer playsoundtoteam( var_8f400b9bbb94574f, sfxplayer.team, sfxplayer, self );
        }
        
        var_44cd830f4494b362 = bundle.var_b393c7f30197ca53;
        enemyteam = team_utility::getotherteam( sfxplayer.team );
        
        if ( isdefined( var_44cd830f4494b362 ) && isdefined( enemyteam ) )
        {
            sfxplayer playsoundtoteam( var_44cd830f4494b362, enemyteam, undefined, self );
        }
    }
    
    /#
        thread function_94fb2d2ae8ea1c7a( var_c0ef1f44663b3883 );
    #/
    
    airdrop_escort_setattackpoint( var_c0ef1f44663b3883 );
    
    while ( !function_1e11cde21031fbde( turret.groundtargetent.origin, anglethreshold ) )
    {
        waitframe();
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xabf31308, Offset: 0x3f7d
// Size: 0x11e
function airdrop_escort_onplayerdeath( params )
{
    self.var_882d267c27a8de00 = undefined;
    bundle = level.streakglobals.streakbundles[ "airdrop_escort" ];
    
    if ( isdefined( params.inflictor.streakname ) && params.inflictor.streakname === "airdrop_escort" )
    {
        params.inflictor thread function_33e6f2d98471f57b();
        
        if ( params.inflictor.bundle )
        {
            bundle = params.inflictor.bundle;
        }
    }
    
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( params.objweapon.basename == bundle.var_ea2bc5fac224bd01 )
    {
        attacker.var_ce0ad07ff09a1aca = 1;
    }
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x67038f77, Offset: 0x40a3
// Size: 0xd9
function function_33e6f2d98471f57b()
{
    self notify( #"hash_325ff92f264acaa2" );
    self endon( #"hash_325ff92f264acaa2" );
    
    if ( !isdefined( self.killcount ) )
    {
        self.killcount = 0;
    }
    
    self.killcount += 1;
    
    if ( self.killcount == 1 )
    {
        wait 7;
    }
    else if ( self.killcount == 2 )
    {
        wait 6;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    dialogueref = self.killcount > 3 ? "kill_multiple" : "kill_" + self.killcount;
    self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, getxhash( dialogueref ), 1 );
    self.killcount = undefined;
}

// Namespace airdrop_escort
// Params 0
// Checksum 0xee660bed, Offset: 0x4184
// Size: 0x4d
function function_ae6edf60b5cc7eaa()
{
    self notify( #"hash_a6a219627967f4d5" );
    self endon( #"hash_a6a219627967f4d5" );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"hit", 0 );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x7d2ba09f, Offset: 0x41d9
// Size: 0x2fb
function function_d590c234b8e38559( targetdata )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"heli_patrol" );
    turret = self.turret;
    turret endon( #"lost_target" );
    bundle = self.bundle;
    assert( isdefined( bundle ) );
    assert( isdefined( turret.streakinfo ) );
    var_c0ef1f44663b3883 = undefined;
    var_91ee89318c722966 = turret::function_9d37296f838c74c6( targetdata );
    playertotarget = turret::function_93d9d997ab45c443( targetdata );
    var_8b44fe7522d0325c = 0;
    prevshotsfired = turret.streakinfo.shots_fired;
    turretfiretime = weaponfiretime( "airdrop_escort_turret_ballistics_mp" );
    var_fa8dbfa1e9f8db1c = bundle.var_3f63778b11d42cff ?? 80;
    attackradius = var_fa8dbfa1e9f8db1c;
    var_80ce1d717a54538d = bundle.var_9f3acc30756eaf05 ?? 5;
    var_24cdf52574569236 = bundle.var_b9b6036cba81c90a ?? 12;
    burstcount = bundle.var_edf7fd285fa352b8 ?? 15;
    var_f4e45737d7eb56f1 = !bundle.var_74826148b190cd96;
    
    if ( turret::turret_hastarget( turret ) && isdefined( playertotarget ) )
    {
        if ( !isdefined( playertotarget.var_882d267c27a8de00 ) )
        {
            playertotarget.var_882d267c27a8de00 = [];
        }
        
        selfentitynumber = self getentitynumber();
        var_5337c7c2adb78830 = isdefined( playertotarget.var_882d267c27a8de00[ selfentitynumber ] );
        
        if ( var_5337c7c2adb78830 )
        {
            var_f4e45737d7eb56f1 = 1;
        }
        
        playertotarget.var_882d267c27a8de00[ selfentitynumber ] = 1;
    }
    else
    {
        var_f4e45737d7eb56f1 = 1;
    }
    
    var_914347154062b408 = undefined;
    
    if ( !var_f4e45737d7eb56f1 )
    {
        var_914347154062b408 = attackradius * 2;
        attackradius *= 3;
    }
    
    while ( turret::turret_hastarget( turret ) && var_8b44fe7522d0325c < burstcount )
    {
        if ( isdefined( var_91ee89318c722966 ) )
        {
            var_c0ef1f44663b3883 = var_91ee89318c722966.origin;
        }
        else if ( isplayer( playertotarget ) )
        {
            var_c0ef1f44663b3883 = playertotarget gettagorigin( "j_mainroot" );
        }
        else
        {
            var_c0ef1f44663b3883 = playertotarget.origin;
        }
        
        airdrop_escort_setattackpoint( var_c0ef1f44663b3883, attackradius, var_914347154062b408 );
        
        if ( var_f4e45737d7eb56f1 )
        {
            if ( var_8b44fe7522d0325c == var_80ce1d717a54538d )
            {
                attackradius = int( var_fa8dbfa1e9f8db1c / 2 );
            }
            else if ( var_8b44fe7522d0325c >= var_24cdf52574569236 )
            {
                attackradius = undefined;
            }
        }
        
        if ( turret.var_9cc64b926699342e )
        {
            turret shootturret();
            turret.streakinfo.shots_fired++;
            wait turretfiretime;
        }
        else
        {
            turret requestfireweapon();
            waitframe();
        }
        
        var_8b44fe7522d0325c = turret.streakinfo.shots_fired - prevshotsfired;
    }
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0xde6b201c, Offset: 0x44dc
// Size: 0x7b
function private function_b63649a4701bb409()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"vehicle_turret_fire", param1, param2, projectile );
        turret = self.turret;
        
        if ( isdefined( turret.streakinfo ) )
        {
            turret.streakinfo.shots_fired++;
        }
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xe9e7c13c, Offset: 0x455f
// Size: 0xb4
function airdrop_escort_watchforlosttarget( targetdata )
{
    turret = self.turret;
    playertarget = turret::function_93d9d997ab45c443( targetdata );
    thread airdrop_escort_watchforlosttargetaction( playertarget, "death_or_disconnect" );
    thread airdrop_escort_watchforlosttargetaction( turret, "target_broke_los" );
    thread airdrop_escort_watchforlosttargetaction( turret, "target_outside_valid_range" );
    thread airdrop_escort_watchforlosttargetaction( turret, "target_timeout" );
    thread airdrop_escort_watchforlosttargetaction( turret, "target_last_stand" );
    thread airdrop_escort_watchforlosttargetaction( turret, "target_meatshield_victim" );
    thread airdrop_escort_watchtargetlos( targetdata );
    thread airdrop_escort_watchtargetrange( targetdata );
    thread airdrop_escort_watchtargettimeout( targetdata );
    thread airdrop_escort_watchforlaststand( targetdata );
    thread function_c89a2cdab0064cb9( targetdata );
}

// Namespace airdrop_escort
// Params 2
// Checksum 0x2c7234fa, Offset: 0x461b
// Size: 0x81
function airdrop_escort_watchforlosttargetaction( ent, actionnotify )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"crashing" );
    turret = self.turret;
    turret endon( #"lost_target" );
    ent waittill( actionnotify );
    function_938854927135e95e();
    turret notify( #"lost_target" );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x21187082, Offset: 0x46a4
// Size: 0x55, Type: bool
function function_ca2d893250c8cae4()
{
    turret = self.turret;
    hastarget = turret::turret_hastarget( turret );
    canattack = !isdefined( self.iscrashing ) && !isdefined( self.isleaving );
    return hastarget && canattack;
}

// Namespace airdrop_escort
// Params 3
// Checksum 0x2f63e186, Offset: 0x4702
// Size: 0x14a
function airdrop_escort_setattackpoint( attackpoint, var_91663d154088e5c2, var_914347154062b408 )
{
    point = attackpoint;
    turret = self.turret;
    groundtarget = turret.groundtargetent;
    
    if ( isdefined( var_91663d154088e5c2 ) )
    {
        if ( groundtarget islinked() )
        {
            groundtarget unlink();
        }
        
        randdist = randomintrange( var_914347154062b408 ?? 0, var_91663d154088e5c2 );
        randangle = randomint( 360 );
        x = attackpoint[ 0 ] + randdist * cos( randangle );
        y = attackpoint[ 1 ] + randdist * sin( randangle );
        z = attackpoint[ 2 ];
        point = ( x, y, z );
        groundtarget.origin = point;
    }
    else
    {
        if ( groundtarget islinked() )
        {
            groundtarget unlink();
        }
        
        groundtarget linkto( turret::function_f459998ab742b981( turret ), "tag_origin", ( 0, 0, 30 ), ( 0, 0, 0 ) );
    }
    
    if ( !turret.var_9cc64b926699342e )
    {
        turret setturrettargetent( groundtarget, undefined, 0 );
    }
    
    turret.var_9edea43533eceaec = 1;
}

// Namespace airdrop_escort
// Params 2
// Checksum 0xb2d18041, Offset: 0x4854
// Size: 0xfe, Type: bool
function function_1e11cde21031fbde( targetorigin, anglethreshold )
{
    turret = self.turret;
    
    if ( !turret.var_9edea43533eceaec )
    {
        return false;
    }
    
    if ( !isdefined( turret.var_d106d6fda95efdf7 ) )
    {
        turret.var_d106d6fda95efdf7 = turret tagexists( #"tag_flash" ) ? #"tag_flash" : #"tag_origin";
    }
    
    turretforward = anglestoforward( turret gettagangles( turret.var_d106d6fda95efdf7 ) );
    turretorigin = turret.var_9cc64b926699342e ? turret.origin : turret gettagorigin( turret.var_d106d6fda95efdf7 );
    targetdisplace = targetorigin - turretorigin;
    anglediff = math::anglebetweenvectors( turretforward, targetdisplace );
    
    if ( anglediff <= anglethreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xa5b142f0, Offset: 0x495b
// Size: 0xd0
function airdrop_escort_watchtargetlos( targetdata )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret = self.turret;
    turret endon( #"lost_target" );
    losttime = undefined;
    tolerance = 500;
    targetplayer = turret::function_93d9d997ab45c443( targetdata );
    
    while ( true )
    {
        canseetarget = turret::turret_canseetarget( turret, targetplayer );
        
        if ( !canseetarget )
        {
            if ( !isdefined( losttime ) )
            {
                losttime = gettime();
            }
            
            if ( gettime() - losttime > tolerance )
            {
                airdrop_escort_settargetstate( "target_broke_los" );
                break;
            }
        }
        else
        {
            losttime = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x11728f54, Offset: 0x4a33
// Size: 0x14c
function airdrop_escort_watchtargetrange( targetdata )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret = self.turret;
    turret endon( #"lost_target" );
    targetplayer = turret::function_93d9d997ab45c443( targetdata );
    bundle = self.bundle;
    targetrange = bundle.var_2d452a1c1a21523f ?? 5000;
    attackrange = bundle.var_65af38e80a0eebea ?? 4000;
    var_6e0a3cb055f6df35 = targetrange * targetrange;
    var_4acb411805ff1078 = attackrange * attackrange;
    
    while ( true )
    {
        startingpos = self.owner.origin;
        
        if ( self.escorttype == "crate" )
        {
            startingpos = self.pathgoal;
        }
        
        if ( function_2fe4ed1e522e7eab( startingpos, targetplayer, var_6e0a3cb055f6df35 ) )
        {
            if ( !function_7cc3cecf65b5ec98( startingpos, targetplayer, var_4acb411805ff1078 ) )
            {
                airdrop_escort_movetolocation( targetplayer, 1 );
                wait 1;
            }
        }
        else
        {
            airdrop_escort_settargetstate( "target_outside_valid_range" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace airdrop_escort
// Params 1
// Checksum 0x77fa5d65, Offset: 0x4b87
// Size: 0x8d
function airdrop_escort_watchtargettimeout( targetdata )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret = self.turret;
    turret endon( #"lost_target" );
    bundle = self.bundle;
    assert( isdefined( bundle ) );
    wait bundle.var_89f3b03ca21a0608 ?? 5;
    airdrop_escort_settargetstate( "target_timeout" );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xae42e6d6, Offset: 0x4c1c
// Size: 0x96
function airdrop_escort_watchforlaststand( targetdata )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret = self.turret;
    turret endon( #"lost_target" );
    targetplayer = turret::function_93d9d997ab45c443( targetdata );
    canattacklaststand = turret::function_c711ec5bf4080c5f( targetdata );
    
    if ( canattacklaststand )
    {
        return;
    }
    
    targetplayer waittill( #"last_stand_enter" );
    airdrop_escort_settargetstate( "target_last_stand" );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xd0c58b14, Offset: 0x4cba
// Size: 0x7e
function function_c89a2cdab0064cb9( targetdata )
{
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"death" );
    turret = self.turret;
    turret endon( #"lost_target" );
    targetplayer = turret::function_93d9d997ab45c443( targetdata );
    targetplayer waittill( #"meatshield_victim_start" );
    airdrop_escort_settargetstate( "target_meatshield_victim" );
}

// Namespace airdrop_escort
// Params 1
// Checksum 0xbced4bba, Offset: 0x4d40
// Size: 0x30
function airdrop_escort_settargetstate( targetstate )
{
    turret = self.turret;
    turret::turret_settargetstate( turret, targetstate );
    turret notify( targetstate );
}

// Namespace airdrop_escort
// Params 0
// Checksum 0x8a1b9ea7, Offset: 0x4d78
// Size: 0xa2
function function_938854927135e95e()
{
    turret = self.turret;
    
    if ( turret.groundtargetent islinked() )
    {
        turret.groundtargetent unlink();
    }
    
    groundtargetorigin = self.origin - ( 0, 0, 100 ) + anglestoforward( self.angles ) * 500;
    turret.groundtargetent.origin = groundtargetorigin;
    turret.groundtargetent linkto( self );
    turret.var_9edea43533eceaec = 0;
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0xef9e2a04, Offset: 0x4e22
// Size: 0xc3
function private airdrop_escort_getownerlookat()
{
    starttrace = self.owner getvieworigin();
    
    if ( self.owner getcamerathirdperson() )
    {
        starttrace = self.owner getcamerathirdpersonorigin();
    }
    
    var_998a4e1962619609 = 50000;
    endtrace = starttrace + anglestoforward( self.owner getplayerangles() ) * var_998a4e1962619609;
    ignoreents = self.owner namespace_9d8e359c3b1041e5::playerkillstreakgetownerlookatignoreentssharedfunc();
    trace = trace::ray_trace( starttrace, endtrace, ignoreents );
    
    if ( trace[ "hittype" ] && trace[ "hittype" ] != "hittype_none" )
    {
        endpos = trace[ "position" ];
    }
    
    return endpos;
}

// Namespace airdrop_escort
// Params 0, eflags: 0xc
// Checksum 0x1811a700, Offset: 0x4eee
// Size: 0x232
function private function_7c893d8f64799c54()
{
    self notify( #"hash_55fb9776ffb7dde9" );
    self endon( #"hash_55fb9776ffb7dde9" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death", #"explode", #"crashing", #"leaving" );
    thread function_f4d8732d48194a6c();
    var_b033b1ccf03ecb20 = 500;
    killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/AIRDROP_ESCORT_GUARD_LOCATION", #"guard_location", 1, undefined, var_b033b1ccf03ecb20 );
    self.useobj.useobjid = #"guard_location";
    
    while ( true )
    {
        self.useobj waittill( #"trigger" );
        
        if ( self.useobj.useobjid == #"guard_location" )
        {
            if ( function_ddbedc549e4cd38f() )
            {
                killstreak_utility::function_79acee879fb17c4a( self.owner, self.streakinfo.streakname );
                killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/AIRDROP_ESCORT_GUARD_OWNER", #"guard_owner", 1, undefined, var_b033b1ccf03ecb20 );
                self.useobj.useobjid = #"guard_owner";
            }
            
            continue;
        }
        
        if ( self.useobj.useobjid == #"guard_owner" )
        {
            function_4cbce4ccb29e85ef();
            killstreak_utility::function_79acee879fb17c4a( self.owner, self.streakinfo.streakname );
            killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/AIRDROP_ESCORT_GUARD_LOCATION", #"guard_location", 1, undefined, var_b033b1ccf03ecb20 );
            self.useobj.useobjid = #"guard_location";
        }
    }
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0xe34803c8, Offset: 0x5128
// Size: 0xc0, Type: bool
function private function_ddbedc549e4cd38f()
{
    endpos = airdrop_escort_getownerlookat();
    
    if ( !endpos || outofbounds::ispointinoutofbounds( endpos, self.owner.team ) )
    {
        if ( self.owner )
        {
            self.owner hud_message::showerrormessage( %"killstreaks/cannot_be_placed" );
        }
        
        return false;
    }
    
    self.var_14e157060657afca = airdrop_escort_createmarker( self.owner, endpos );
    self.defaultaction = "heli_guard_location";
    self.defaultactionfunc = &function_6e67c49f2985e561;
    self.var_14e157060657afca setscriptablepartstate( #"marker", #"guard_location", 0 );
    thread function_6e67c49f2985e561();
    return true;
}

// Namespace airdrop_escort
// Params 0, eflags: 0xc
// Checksum 0xb24e9c5e, Offset: 0x51f1
// Size: 0x48
function private function_4b543dee1e1a9610()
{
    self notify( #"hash_102321dd698c6d36" );
    self endon( #"hash_102321dd698c6d36" );
    self.var_14e157060657afca setscriptablepartstate( #"marker", #"guard_owner", 0 );
    wait 0.1;
    function_3049cf4cb603f6d3();
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0x26dee201, Offset: 0x5241
// Size: 0x2c
function private function_4cbce4ccb29e85ef()
{
    thread function_4b543dee1e1a9610();
    self.defaultaction = "heli_overwatch";
    self.defaultactionfunc = &function_bb606bfa60e0a703;
    thread function_bb606bfa60e0a703();
}

// Namespace airdrop_escort
// Params 2, eflags: 0x4
// Checksum 0x1eb56372, Offset: 0x5275
// Size: 0xd3
function private airdrop_escort_createmarker( owner, markerorigin )
{
    markerent = spawn( "script_model", markerorigin );
    
    if ( self.bundle.var_bcf585b2b6fe45c5 )
    {
        markerent setmodel( self.bundle.var_bcf585b2b6fe45c5 );
    }
    else
    {
        markerent setmodel( "tag_origin" );
    }
    
    markerent.owner = owner;
    markerent setentityowner( owner );
    markerent setotherent( owner );
    markerent.objidnum = utility::callsharedfunc( #"game", #"requestobjectiveid", 99 );
    assert( isdefined( markerent.objidnum ), "<dev string:x119>" );
    markerent airdrop_escort_setmarkerobjective();
    return markerent;
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0x7e22629b, Offset: 0x5351
// Size: 0x4e
function private function_3049cf4cb603f6d3()
{
    if ( self && self.var_14e157060657afca )
    {
        self.var_14e157060657afca objidpoolmanager::returnobjectiveid( self.var_14e157060657afca.objidnum );
        self.var_14e157060657afca delete();
        self.var_14e157060657afca = undefined;
    }
}

// Namespace airdrop_escort
// Params 0, eflags: 0xc
// Checksum 0x5c4a7d35, Offset: 0x53a7
// Size: 0x3c
function private function_f4d8732d48194a6c()
{
    self notify( #"hash_d69763ee32b1e95d" );
    self endon( #"hash_d69763ee32b1e95d" );
    utility::waittill_any( "death", "explode", "crashing", "leaving" );
    function_3049cf4cb603f6d3();
}

// Namespace airdrop_escort
// Params 0, eflags: 0x4
// Checksum 0xbf107467, Offset: 0x53eb
// Size: 0xf6
function private airdrop_escort_setmarkerobjective()
{
    self.icon = self.bundle.var_864af28e64550bfb ?? "hud_icon_killstreak_escort_airdrop";
    objidpoolmanager::function_e4d6a71507372662( self.objidnum, 0 );
    objidpoolmanager::objective_add_objective( self.objidnum, "current", undefined, self.icon, "icon_small" );
    objidpoolmanager::update_objective_onentity( self.objidnum, self );
    objidpoolmanager::objective_playermask_single( self.objidnum, self.owner );
    objidpoolmanager::update_objective_setzoffset( self.objidnum, 50 );
    objidpoolmanager::objective_set_play_intro( self.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( self.objidnum, 0 );
    objidpoolmanager::update_objective_setbackground( self.objidnum, 1 );
    objidpoolmanager::function_79ca076cf9eccbd9( self.objidnum, 1 );
    objidpoolmanager::update_objective_ownerclient( self.objidnum, self.owner );
}

/#

    // Namespace airdrop_escort
    // Params 0
    // Checksum 0xcbb1dc59, Offset: 0x54e9
    // Size: 0xab, Type: dev
    function function_18f1bde1fcff2060()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"explode" );
        self endon( #"leaving" );
        turret = self.turret;
        
        while ( true )
        {
            debugtarget = getdvarint( @"hash_e9159b47fbb642af", 0 );
            
            if ( !debugtarget )
            {
                waitframe();
                continue;
            }
            
            level thread debug_utility::drawsphere( turret.groundtargetent.origin, 25, 0.05, ( 1, 0, 0 ) );
            wait 0.05;
        }
    }

    // Namespace airdrop_escort
    // Params 1
    // Checksum 0x15354dfa, Offset: 0x559c
    // Size: 0xc3, Type: dev
    function function_94fb2d2ae8ea1c7a( var_7677cdeeda5e168b )
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"explode" );
        self endon( #"leaving" );
        self.owner endon( #"hash_9b9b62f2b61f70fe" );
        turret = self.turret;
        turret endon( #"lost_target" );
        
        while ( true )
        {
            debugtarget = getdvarint( @"hash_e9159b47fbb642af", 0 );
            
            if ( !debugtarget )
            {
                waitframe();
                continue;
            }
            
            level thread debug_utility::drawsphere( var_7677cdeeda5e168b, 50, 0.05, ( 1, 1, 0 ) );
            wait 0.05;
        }
    }

    // Namespace airdrop_escort
    // Params 0
    // Checksum 0x63cf2250, Offset: 0x5667
    // Size: 0x107, Type: dev
    function function_ec865325b756ca73()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"explode" );
        self endon( #"leaving" );
        turret = self.turret;
        escortowner = self.owner;
        escortowner notifyonplayercommand( "<dev string:x14f>", "<dev string:x164>" );
        escortowner notifyonplayercommand( "<dev string:x14f>", "<dev string:x16e>" );
        
        while ( true )
        {
            debugtarget = getdvarint( @"hash_94edbe8b5c5b8dd0", 0 );
            
            if ( !debugtarget )
            {
                waitframe();
                continue;
            }
            
            escortowner waittill( #"hash_9b9b62f2b61f70fe" );
            
            if ( !turret::turret_hastarget( turret ) )
            {
                childthread function_2b6881f9ceb4c96f();
                continue;
            }
            
            function_938854927135e95e();
            self.owner iprintlnbold( "<dev string:x179>" + self.defaultaction );
            turret::turret_cleartarget( turret );
            self thread [[ self.defaultactionfunc ]]();
        }
    }

    // Namespace airdrop_escort
    // Params 0
    // Checksum 0xeb865876, Offset: 0x5776
    // Size: 0x26f, Type: dev
    function function_2b6881f9ceb4c96f()
    {
        self notify( #"hash_2283a54723bbb0c8" );
        self endon( #"hash_2283a54723bbb0c8" );
        self endon( #"heli_patrol" );
        self notify( #"heli_attack" );
        self.currentaction = "<dev string:x18b>";
        bundle = self.bundle;
        assert( isdefined( bundle ) );
        attackdelay = bundle.var_910575b006687572 ?? 1;
        var_c0ef1f44663b3883 = undefined;
        targettracestart = self.owner getvieworigin();
        targettraceend = targettracestart + anglestoforward( self.owner getplayerangles() ) * 50000;
        targettrace = trace::ray_trace( targettracestart, targettraceend, self, trace::create_contents( 1, 1, 0, 1, 0, 1, 0, 1, 1 ) );
        
        if ( targettrace[ "<dev string:x197>" ] != "<dev string:x19f>" )
        {
            var_c0ef1f44663b3883 = targettrace[ "<dev string:x1ac>" ];
        }
        else
        {
            return;
        }
        
        testtarget = undefined;
        
        if ( !isdefined( self.testtarget ) )
        {
            testtarget = spawn( "<dev string:x1b5>", var_c0ef1f44663b3883 );
            testtarget setmodel( "<dev string:x1c2>" );
            testtarget dontinterpolate();
            testtarget.angles = self.owner.angles;
            self.testtarget = testtarget;
        }
        else
        {
            testtarget = self.testtarget;
            testtarget.origin = var_c0ef1f44663b3883;
        }
        
        targetdata = spawnstruct();
        targetdata.targetplayer = testtarget;
        targetdata.targetvehicle = undefined;
        targetdata.attackvehicle = 0;
        targetdata.attacklaststand = 0;
        targetdata.attackparachute = 0;
        turret = self.turret;
        playertotarget = turret::function_93d9d997ab45c443( targetdata );
        self.owner iprintlnbold( "<dev string:x1cd>" );
        turret::turret_settarget( turret, targetdata );
        self setlookatent( testtarget );
        self setvehgoalpos( self.origin + anglestoforward( self.angles ) * 500, 1 );
        airdrop_escort_lockontarget( targetdata );
        
        while ( function_ca2d893250c8cae4() && turret::function_8202b7c43f73cc3b( turret, playertotarget ) )
        {
            wait attackdelay;
            function_d590c234b8e38559( targetdata );
        }
    }

#/
