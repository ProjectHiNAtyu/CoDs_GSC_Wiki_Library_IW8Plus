// scripts\mp\common\killstreaks\chopper_gunner.gsc  (hash_1fc69d7d13b84ced.gscc) (size: 50241 Bytes / 0xc441 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x103cd7b8 (272422840)
// size ...... 50241 (0xc441)
// includes .. 21  (offset: 0xb6d5)
// strings ... 167 (offset: 0xb77d)
// dev strs .. 34  (offset: 0xc23d)
// exports ... 99  (offset: 0x7d3d)
// cseg ...... 0xd5b + 0x6fe2 (0x7d3d)
// imports ... 330 (offset: 0x8cb5)
// animtree1 . 2   (offset: 0xc3e9)
// animtree2 . 4   (offset: 0xc401)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;

#namespace chopper_gunner;

// Namespace chopper_gunner
// Params 0
// Checksum 0xda58157e, Offset: 0xd79
// Size: 0xe5
function init()
{
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"init" ) )
    {
        [[ utility::getsharedfunc( #"chopper_gunner", #"init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_5053673c4770b74", 0 );
        setdevdvarifuninitialized( @"hash_f3fcf3899fa2e1b0", 0 );
        setdevdvarifuninitialized( @"hash_a34a2f5a7d33e3bb", 0 );
        setdevdvarifuninitialized( @"hash_804b68f93e7911ba", 1 );
        setdevdvarifuninitialized( @"hash_6dcbef72bd1fd758", 0 );
        setdevdvarifuninitialized( @"hash_c1fa04efebbe3e6b", -1 );
    #/
    
    level function_3283e1ed784c01f9();
    level function_a66b4a639a085b1f();
    level init_choppergunner_anims();
    level init_choppergunner_vo();
    level init_choppergunner_fx();
    level function_39aa94c66ebe8b75();
    utility::registersharedfunc( #"chopper_gunner", #"dronegun_emp", &function_3964e2cd04789498 );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x6d620129, Offset: 0xe66
// Size: 0x230
function function_3283e1ed784c01f9()
{
    level.choppergunners = [];
    level.heli_pilot_mesh = game_utility::getlocaleent( "heli_pilot_mesh" );
    
    if ( isdefined( level.heli_pilot_mesh ) )
    {
        level.heli_pilot_mesh hide();
    }
    
    if ( level.mapname == "mp_embassy" )
    {
        level.heli_structs_entrances[ 2 ] = undefined;
        
        if ( isint( 2 ) )
        {
            function_cdc669dbc8ea2101( level.heli_structs_entrances );
        }
    }
    
    level.incomingallchoppergunners = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.incomingchoppergunners[ teamname ] = 0;
    }
    
    if ( !isdefined( level.var_8564f62cdf263f2a ) )
    {
        level.var_8564f62cdf263f2a = spawnstruct();
    }
    
    if ( !isdefined( level.var_8564f62cdf263f2a.streak_name ) )
    {
        level.var_8564f62cdf263f2a.streak_name = "chopper_gunner";
    }
    
    if ( !isdefined( level.var_8564f62cdf263f2a.visibility_omnvar ) )
    {
        level.var_8564f62cdf263f2a.visibility_omnvar = 6;
    }
    
    bundle = level.streakglobals.streakbundles[ level.var_8564f62cdf263f2a.streak_name ];
    level.var_8564f62cdf263f2a.bundle = bundle;
    level.var_8564f62cdf263f2a.deploy_weapon_name = bundle.deployweaponname ?? "ks_remote_device_mp";
    level.var_8564f62cdf263f2a.show_cockpit = bundle.var_38fdef69368013bf ?? 1;
    killstreak_utility::registervisibilityomnvarforkillstreak( level.var_8564f62cdf263f2a.streak_name, "on", level.var_8564f62cdf263f2a.visibility_omnvar );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x7a902e96, Offset: 0x109e
// Size: 0x60
function function_a66b4a639a085b1f()
{
    val::group_register( "chopperGunnerUse", [ "killstreaks", "allow_movement", "fire", "weapon_switch", "melee", "usability", "shellshock", "allow_jump", "offhand_weapons" ] );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xad543085, Offset: 0x1106
// Size: 0x12
function init_choppergunner_anims()
{
    level choppergunner_pilotanims();
    level choppergunner_vehicleanims();
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x33499b57, Offset: 0x1120
// Size: 0x1e1
function init_choppergunner_vo()
{
    streak_name = level.var_8564f62cdf263f2a.streak_name;
    game[ "dialog" ][ streak_name + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ streak_name + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ streak_name + "_engage" ] = "killstreak_remote_operator" + "_engage";
    game[ "dialog" ][ streak_name + "_random_radio" ] = "killstreak_remote_operator" + "_radio_chatter";
    game[ "dialog" ][ streak_name + "_attack_single" ] = "killstreak_remote_operator" + "_target_attack_single";
    game[ "dialog" ][ streak_name + "_attack_multi" ] = "killstreak_remote_operator" + "_target_attack_multi";
    game[ "dialog" ][ streak_name + "_flares" ] = "killstreak_remote_operator" + "_flare_release";
    game[ "dialog" ][ streak_name + "_light_damage" ] = "killstreak_remote_operator" + "_light_damage";
    game[ "dialog" ][ streak_name + "_med_damage" ] = "killstreak_remote_operator" + "_med_damage";
    game[ "dialog" ][ streak_name + "_heavy_damage" ] = "killstreak_remote_operator" + "_heavy_damage";
    game[ "dialog" ][ streak_name + "_killconf_single" ] = "killstreak_remote_operator" + "_confirm_kill_single";
    game[ "dialog" ][ streak_name + "_killconf_multi" ] = "killstreak_remote_operator" + "_confirm_kill_multi";
    game[ "dialog" ][ streak_name + "_killconf_missile" ] = "killstreak_remote_operator" + "_confirm_kill_missile";
    game[ "dialog" ][ streak_name + "_lockedon" ] = "killstreak_remote_operator" + "_missile_lock_warning";
    game[ "dialog" ][ streak_name + "_reattack" ] = "killstreak_remote_operator" + "_reattack";
    game[ "dialog" ][ streak_name + "_crash" ] = "killstreak_remote_operator" + "_crash";
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x2060b3c7, Offset: 0x1309
// Size: 0x2
function init_choppergunner_fx()
{
    
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x298b677, Offset: 0x1313
// Size: 0xc2
function function_39aa94c66ebe8b75()
{
    bundle = level.streakglobals.streakbundles[ level.var_8564f62cdf263f2a.streak_name ];
    
    if ( isdefined( bundle.var_673e7e05312bed70 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_673e7e05312bed70 );
    }
    
    if ( isdefined( bundle.var_6b520631d06d0eb6 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_6b520631d06d0eb6 );
    }
    
    if ( isdefined( level.choppervisionset ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.choppervisionset );
    }
    
    if ( bundle.var_4ed121bccb3ee0a7 != "" )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_4ed121bccb3ee0a7 ?? "chopper_color_mp" );
    }
}

// Namespace chopper_gunner
// Params 0, eflags: 0x4
// Checksum 0xd3b3e84b, Offset: 0x13dd
// Size: 0x97
function private function_155e941d6c04bc46()
{
    bundle = level.streakglobals.streakbundles[ level.var_8564f62cdf263f2a.streak_name ];
    fullscreenfxparams = { #visionset:bundle.var_673e7e05312bed70 ?? level.choppervisionset, #postfxbundlename:bundle.var_65e1322ab9fbe786 };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace chopper_gunner
// Params 0, eflags: 0x4
// Checksum 0x8c25f3d2, Offset: 0x147c
// Size: 0x97
function private function_6eb46f15d49c54aa()
{
    bundle = level.streakglobals.streakbundles[ level.var_8564f62cdf263f2a.streak_name ];
    fullscreenfxparams = { #visionset:bundle.var_6b520631d06d0eb6 ?? level.choppervisionset, #postfxbundlename:bundle.var_bb47001b41f0c291 };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace chopper_gunner
// Params 1, eflags: 0x4
// Checksum 0xf63a644b, Offset: 0x151b
// Size: 0x39
function private function_3fd6c39596383083( var_effab7a63f64cd3d )
{
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( { #postfxbundlename:var_effab7a63f64cd3d } );
}

#using_animtree( "script_model" );

// Namespace chopper_gunner
// Params 0
// Checksum 0x63aaa50, Offset: 0x155c
// Size: 0x71
function choppergunner_pilotanims()
{
    level.scr_animtree[ "ks_chopper_gunner_pilot" ] = #animtree;
    level.scr_anim[ "ks_chopper_gunner_pilot" ][ "pilot_intro" ] = %iw9_mp_ks_ahotel64_intro_player;
    level.scr_anim[ "ks_chopper_gunner_pilot" ][ "pilot_missile_crash" ] = %iw9_mp_ks_ahotel64_crash_player;
    level.scr_anim[ "ks_chopper_gunner_pilot" ][ "pilot_shot_crash" ] = %iw9_mp_ks_ahotel64_shot_player;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace chopper_gunner
// Params 0
// Checksum 0x66af0cc6, Offset: 0x15d5
// Size: 0x33
function choppergunner_vehicleanims()
{
    level.scr_animtree[ "ks_chopper_gunner_vehicle_camera" ] = #animtree;
    level.scr_anim[ "ks_chopper_gunner_vehicle_camera" ][ "vehicle_intro" ] = %iw9_mp_ks_ahotel64_intro_heli;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xce2a0a4e, Offset: 0x1610
// Size: 0xe, Type: bool
function weapongivenchoppergunner( streakinfo )
{
    return true;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xc9290574, Offset: 0x1627
// Size: 0x30
function tryusechoppergunner()
{
    streakinfo = killstreak_utility::createstreakinfo( level.var_8564f62cdf263f2a.streak_name, self );
    return tryusechoppergunnerfromstruct( streakinfo );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x391376fb, Offset: 0x1660
// Size: 0x335, Type: bool
function tryusechoppergunnerfromstruct( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"using_remote" );
    var_87fc2c034785a46c = function_439ef9fd679fbe1f( streakinfo );
    
    if ( !var_87fc2c034785a46c )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    if ( streakinfo.var_5f6323f481451013 )
    {
        val::set( "chopperGunner", "ads", 0 );
    }
    
    var_6e519cf217378eb1 = function_a37ba1bdee56c596( streakinfo );
    level.incomingallchoppergunners--;
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.incomingchoppergunners[ self.team ]--;
    }
    
    if ( !var_6e519cf217378eb1 )
    {
        val::reset_all( "chopperGunner" );
        
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 1 );
    }
    
    thirdperson = 0;
    
    /#
        thirdperson = getdvarint( @"hash_5053673c4770b74", 0 );
        
        if ( thirdperson )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        }
    #/
    
    choppergunner = startchoppergunnerintro( self, streakinfo, thirdperson );
    self prestreamasset( "entity", choppergunner, 1000 );
    
    if ( level.killstreak_emp_initialized )
    {
        choppergunner.ksempapplycallback = &choppergunner_empapplied;
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    
    if ( !isdefined( choppergunner ) )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( "chopper_gunner", self.origin );
    }
    
    used_splash_ref = streakinfo.bundle.usedsplashref;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    choppergunner thread function_75689d621768771( self, thirdperson );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_c37713377413111f" ) )
    {
        choppergunner [[ utility::getsharedfunc( #"killstreak", #"hash_c37713377413111f" ) ]]();
    }
    
    choppergunner function_620ea4f7a46db56a();
    return true;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xd271fba2, Offset: 0x199e
// Size: 0x2e6, Type: bool
function function_439ef9fd679fbe1f( streakinfo )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"incrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"incrementfauxvehiclecount" ) ]]();
    }
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        }
        
        return false;
    }
    
    var_766d9694d6cd52f7 = 1;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"currentactivevehiclecount" ) && utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
    {
        if ( [[ utility::getsharedfunc( #"killstreak", #"currentactivevehiclecount" ) ]]() >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() || level.fauxvehiclecount + var_766d9694d6cd52f7 >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
            }
            
            return false;
        }
    }
    
    level.incomingallchoppergunners++;
    var_831582ca4552dceb = 1;
    
    if ( game_utility::islargemap() )
    {
        var_831582ca4552dceb = 2;
    }
    
    if ( level.choppergunners.size >= var_831582ca4552dceb || level.choppergunners.size + level.incomingallchoppergunners > var_831582ca4552dceb )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        level.incomingallchoppergunners--;
        return false;
    }
    
    if ( game_utility::islargemap() && level.teambased )
    {
        var_5e219028e700ef20 = 1;
        level.incomingchoppergunners[ self.team ]++;
        
        if ( killstreak_utility::getnumactivekillstreakperteam( self.team, level.choppergunners ) + level.incomingchoppergunners[ self.team ] > var_5e219028e700ef20 )
        {
            level.incomingallchoppergunners--;
            level.incomingchoppergunners[ self.team ]--;
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/max_friendly_chopper_gunner" );
            }
            
            return false;
        }
    }
    
    if ( level.gameended )
    {
        return false;
    }
    
    return true;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x6c96fc5f, Offset: 0x1c8d
// Size: 0xa2, Type: bool
function function_a37ba1bdee56c596( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( !streakinfo.var_5f6323f481451013 )
    {
        deployweaponname = level.var_8564f62cdf263f2a.deploy_weapon_name;
        deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, &weapongivenchoppergunner, undefined, undefined, undefined, deployweaponname );
        
        if ( !deployresult )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace chopper_gunner
// Params 3
// Checksum 0x7d9be9b, Offset: 0x1d38
// Size: 0x1130
function startchoppergunnerintro( owner, streakinfo, thirdperson )
{
    bundle = streakinfo.bundle;
    owner disablephysicaldepthoffieldscripting();
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = ( 0, 0, 0 );
    
    if ( isdefined( heightent ) && !game_utility::islargemap() )
    {
        heightoffset = ( 0, 0, heightent.origin[ 2 ] - 1000 );
        
        if ( heightoffset[ 2 ] > 4000 )
        {
            setglobalsoundcontext( "airstrikeheight", "high" );
        }
        else if ( heightoffset[ 2 ] > 3000 )
        {
            setglobalsoundcontext( "airstrikeheight", "medium" );
        }
    }
    else
    {
        heightoffset = ( 0, 0, 2000 );
    }
    
    /#
        var_526fa115c3fc4688 = getdvarint( @"hash_f3fcf3899fa2e1b0", 0 );
        heightoffset += ( 0, 0, var_526fa115c3fc4688 );
    #/
    
    pathgoal = ( owner.origin + anglestoforward( owner.angles ) * 2000 ) * ( 1, 1, 0 );
    pathgoal += heightoffset;
    angles = owner.angles;
    
    if ( level.heli_structs_entrances.size > 0 )
    {
        var_53eeea462a8fe959 = randomint( level.heli_structs_entrances.size );
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_2ebe6213013cff11" ) )
        {
            var_53eeea462a8fe959 = level utility::callsharedfunc( #"chopper_gunner", #"hash_2ebe6213013cff11", owner.origin );
        }
        
        /#
            debugindex = getdvarint( @"hash_c1fa04efebbe3e6b", -1 );
            
            if ( debugindex != -1 )
            {
                var_53eeea462a8fe959 = debugindex;
            }
        #/
        
        entrancestruct = level.heli_structs_entrances[ var_53eeea462a8fe959 ];
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"findtargetstruct" ) )
        {
            goalstruct = [[ utility::getsharedfunc( #"chopper_gunner", #"findtargetstruct" ) ]]( entrancestruct.script_linkto, level.heli_structs_goals );
            
            if ( isdefined( goalstruct ) )
            {
                newheightoffset = level.var_8564f62cdf263f2a.bundle.var_1f6bb13385e47617 ?? 200;
                heightoffset = function_fecaeb63c3696c82( ( 0, 0, goalstruct.origin[ 2 ] + newheightoffset ) );
                
                /#
                    var_526fa115c3fc4688 = getdvarint( @"hash_f3fcf3899fa2e1b0", 0 );
                    heightoffset += ( 0, 0, var_526fa115c3fc4688 );
                #/
                
                var_ef058b074a4eda1d = entrancestruct.origin * ( 1, 1, 0 ) + heightoffset;
                var_78591ed6a66cbafe = goalstruct.origin * ( 1, 1, 0 ) + heightoffset;
                entranceforward = vectornormalize( var_78591ed6a66cbafe - var_ef058b074a4eda1d );
                pathgoal = var_78591ed6a66cbafe + entranceforward * 500;
                angles = vectortoangles( entranceforward );
                
                /#
                    level thread debug_utility::drawsphere( var_ef058b074a4eda1d, 20, 60, ( 1, 0, 0 ) );
                    level thread debug_utility::drawline( var_ef058b074a4eda1d, var_78591ed6a66cbafe, 60, ( 1, 1, 1 ) );
                    level thread debug_utility::drawsphere( var_78591ed6a66cbafe, 20, 60, ( 0, 1, 0 ) );
                #/
            }
            else
            {
                /#
                    owner iprintlnbold( "<dev string:x24>" + entrancestruct.script_linkto + "<dev string:x34>" );
                #/
            }
        }
    }
    else if ( owner.infinite_chopper && level.script == "cp_so_aniyah" )
    {
        if ( level.players.size > 1 )
        {
            ground_players = arrayremove( level.players, owner );
        }
        else
        {
            ground_players = level.players;
        }
        
        selected_player = utility::array_random( ground_players );
        selected_player_pos = ( selected_player.origin[ 0 ], selected_player.origin[ 1 ], 1750 );
        
        while ( level.objective_locations.size == 0 )
        {
            waitframe();
        }
        
        closest_objective = function_47c86977a18df38b( level.objective_locations, selected_player_pos );
        closest_objective_pos = ( closest_objective.origin[ 0 ], closest_objective.origin[ 1 ], 1750 );
        obj_to_player = vectornormalize( selected_player_pos - closest_objective_pos );
        pathgoal = closest_objective_pos - obj_to_player * 1000;
        angles = vectortoangles( obj_to_player );
    }
    else if ( isdefined( streakinfo.var_85efcf1c5b41189b ) )
    {
        entranceinfo = [[ streakinfo.var_85efcf1c5b41189b ]]( owner );
        pathgoal = entranceinfo.pathgoal;
        angles = entranceinfo.angles;
    }
    else
    {
        owner iprintlnbold( "Level is missing heli structs, please set them up!" );
        heightoffset = function_fecaeb63c3696c82( heightoffset );
        pathgoal = pathgoal * ( 1, 1, 0 ) + heightoffset;
    }
    
    if ( isdefined( level.sharedfuncs[ #"chopper_gunner" ][ #"playintro" ] ) )
    {
        var_564761d3ad4cbf81 = utility::callsharedfunc( #"chopper_gunner", #"playintro", pathgoal, angles, bundle );
        owner function_6eb46f15d49c54aa();
    }
    
    choppergunnervehicle = "veh_apache_mp_phys";
    choppergunnermodel = "veh9_mil_air_heli_ahotel64_mp";
    
    if ( getdvarint( @"hash_f9d055c32419e2f2", 0 ) > 0 || owner.infinite_chopper && level.script == "cp_so_aniyah" )
    {
        choppergunnervehicle = "veh_apache_cp_so_aniyah";
    }
    
    choppergunner = function_1b78ca2e1a266d39( thirdperson, streakinfo, var_564761d3ad4cbf81, angles, choppergunnervehicle, choppergunnermodel );
    
    if ( !isdefined( choppergunner ) )
    {
        return;
    }
    
    choppergunner vehphys_forcekeyframedmotion();
    choppergunner function_d2b8ee2e1275daaf( 1 );
    level thread killstreak_utility::function_6348c97b79ee8a08( choppergunner, owner, &choppergunner_explode );
    modifiedlifetime = 45;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            modifiedlifetime = 9999;
        }
    #/
    
    choppergunner.speed = 100;
    choppergunner.accel = 50;
    choppergunner.lifetime = modifiedlifetime;
    choppergunner.team = owner.team;
    choppergunner.owner = owner;
    choppergunner.owner.vehicle = choppergunner;
    choppergunner.angles = angles;
    choppergunner.streakinfo = streakinfo;
    choppergunner.streakname = streakinfo.streakname;
    choppergunner.flaresreservecount = 1;
    choppergunner.pathgoal = pathgoal;
    choppergunner.missilesleft = getdvarint( @"hash_52bf6045193decbf", 8 );
    choppergunner.animname = "ks_chopper_gunner_vehicle_camera";
    choppergunner.infinite_chopper = istrue( owner.infinite_chopper );
    choppergunner.ispiloted = 1;
    choppergunner.heightoffset = heightoffset;
    choppergunner.var_4d91de78824da316 = streakinfo.bundle.var_87e70486c3d654f6;
    outofbounds::registerentforoob( choppergunner, "killstreak" );
    utility::registersharedfunc( bundle.var_dcdf13c9876edf1b, #"interactswithoobtrigger", &function_e4a3e1b8ed7b4b26 );
    utility::registersharedfunc( bundle.var_dcdf13c9876edf1b, #"hash_3365a912c11d2ba0", &function_f0c10f3224c0381e );
    choppergunner.var_bdc51be80cbeef82 = bundle.var_bdc51be80cbeef82;
    choppergunner.killcament = spawn( "script_model", choppergunner gettagorigin( choppergunner tagexists( #"tag_camera_turret" ) ? #"tag_camera_turret" : #"tag_origin" ) );
    originoffset = ( bundle.var_15869b5e2c380579 ?? 0, bundle.var_15869a5e2c380346 ?? 0, bundle.var_1586995e2c380113 ?? 0 );
    choppergunner.killcament linkto( choppergunner, "tag_origin", originoffset, ( 0, 0, 0 ) );
    choppergunner.interiorlighting = owner function_47f7381f126f7ff2( "chopper_interior_probe" );
    choppergunner setvehicleteam( choppergunner.team );
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"attachxrays" ) )
    {
        choppergunner = [[ utility::getsharedfunc( #"chopper_gunner", #"attachxrays" ) ]]( choppergunner );
    }
    
    choppergunner thread choppergunner_watchintrodisown( "disconnect", streakinfo );
    choppergunner thread choppergunner_watchintrodisown( "joined_team", streakinfo );
    choppergunner thread choppergunner_watchintrodisown( "joined_spectator", streakinfo );
    choppergunner thread choppergunner_watchintrodisown( "player_fatal_death", streakinfo );
    maxhealth = choppergunner.health;
    
    if ( level.istacops )
    {
        maxhealth = 1000;
    }
    
    choppergunner.health = maxhealth;
    choppergunner.maxhealth = maxhealth;
    choppergunner.currenthealth = maxhealth;
    choppergunner sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    choppergunner choppergunner_setupdamagefunctionality( streakinfo.streakname );
    level.choppergunners[ level.choppergunners.size ] = choppergunner;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        choppergunner [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    if ( !choppergunner.var_17e473e12ced7138 )
    {
        choppergunner setmaxpitchroll( 15, 15 );
        choppergunner sethoverparams( 50, 5, 2.5 );
        choppergunner setturningability( 1 );
        choppergunner setyawspeed( 500, 100, 25, 0.5 );
        choppergunner setneargoalnotifydist( 5000 );
    }
    
    choppergunner setotherent( owner );
    choppergunner setcandamage( 1 );
    choppergunner choppergunner_setspeed( choppergunner.speed, choppergunner.accel );
    choppergunner setscriptablepartstate( "blinking_lights", "on", 0 );
    choppergunner setscriptablepartstate( "interior_light", "off", 0 );
    choppergunner setscriptablepartstate( "engine", "on", 0 );
    choppergunner setscriptablepartstate( #"thrusters", #"dynamic", 0 );
    
    /#
        choppergunner thread function_3e61d70aeabde5b3();
    #/
    
    if ( choppergunner.var_c8a15f1bbaf32456 )
    {
        choppergunner.turret = choppergunner;
        var_8a9b17e7cd21a2e6 = "tag_origin";
    }
    else
    {
        turretmodel = "veh9_mil_air_heli_ahotel64_turret";
        turret_ref = function_3f99f2b5945fed8f();
        choppergunner.turret = spawnturret( "misc_turret", choppergunner gettagorigin( "tag_turret" ), turret_ref );
        choppergunner.turret setmodel( turretmodel );
        choppergunner.turret.owner = owner;
        choppergunner.turret.team = owner.team;
        choppergunner.turret.angles = choppergunner.angles;
        choppergunner.turret.streakinfo = streakinfo;
        choppergunner.turret linkto( choppergunner, "tag_turret" );
        choppergunner.turret setturretteam( owner.team );
        choppergunner.turret setturretmodechangewait( 0 );
        choppergunner.turret setmode( "manual" );
        choppergunner.turret setotherent( owner );
        choppergunner.turret setdefaultdroppitch( 45 );
        var_8a9b17e7cd21a2e6 = "ks_chopper_gunner_turret_mp";
    }
    
    var_864c0a052449055 = choppergunner.tags.var_795c9a23417e649c ?? "tag_gun_l";
    choppergunner.mpod1 = spawn( "script_model", choppergunner gettagorigin( var_864c0a052449055 ) );
    choppergunner.mpod1 setmodel( var_8a9b17e7cd21a2e6 );
    choppergunner.mpod1.angles = choppergunner.angles;
    choppergunner.mpod1.owner = choppergunner.owner;
    choppergunner.mpod1.team = choppergunner.team;
    choppergunner.mpod1 linkto( choppergunner, var_864c0a052449055 );
    choppergunner.mpod1 setentityowner( owner );
    choppergunner.mpod1 setotherent( owner );
    var_c967ceb2bcc437ea = choppergunner.tags.var_bf973a4d1cadadc9 ?? "tag_gun_r";
    choppergunner.mpod2 = spawn( "script_model", choppergunner gettagorigin( var_c967ceb2bcc437ea ) );
    choppergunner.mpod2 setmodel( var_8a9b17e7cd21a2e6 );
    choppergunner.mpod2.angles = choppergunner.angles;
    choppergunner.mpod2.owner = choppergunner.owner;
    choppergunner.mpod2.team = choppergunner.team;
    choppergunner.mpod2 linkto( choppergunner, var_c967ceb2bcc437ea );
    choppergunner.mpod2 setentityowner( owner );
    choppergunner.mpod2 setotherent( owner );
    var_990a640b7547ae9 = bundle.var_548a479154607cd5;
    
    if ( player_utility::getplayersuperfaction( owner ) == 1 )
    {
        var_990a640b7547ae9 = bundle.var_aac0f26b365dbc27;
    }
    
    if ( var_990a640b7547ae9 )
    {
        choppergunner.pilot = spawn( "script_model", choppergunner gettagorigin( "tag_origin" ) );
        choppergunner.pilot setmodel( var_990a640b7547ae9 );
        choppergunner.pilot.angles = choppergunner.angles;
        choppergunner.pilot linkto( choppergunner, "tag_origin" );
        choppergunner.pilot.animname = "ks_chopper_gunner_pilot";
        choppergunner.pilot animation::setanimtree();
    }
    
    level notify( #"matchrecording_chopper", choppergunner );
    self notify( #"chopper_gunner_used" );
    
    if ( !thirdperson )
    {
        shellshock_utility_cpmp::_stopshellshock();
        self.restoreangles = self getplayerangles();
        val::group_set( "chopperGunnerUse", 0 );
        
        /#
        #/
        
        self setcinematicmotionoverride( "player_chopper_gunner_ride_mp" );
        thread killstreak_utility::function_785239235d790099( "80_instant_noscale", 1 );
        self setclientomnvar( "ui_apache_screens_state", 1 );
        
        if ( choppergunner.showcockpit && choppergunner.pilot )
        {
            self cameralinkto( choppergunner.pilot, "tag_camera", 1, 1 );
        }
        
        self painvisionoff();
        killstreak_shared::killstreak_savenvgstate();
        choppergunner playsoundtoplayer( "mp_killstreak_apache_transition_lr", self );
    }
    
    killstreak_utility::playkillstreaktacomdialog( choppergunner.streakinfo, streakinfo.streakname + "_use", #"use", 1, undefined, "pilot" );
    var_9b493d9de01b76af = utility::get_notetrack_time( level.scr_anim[ "ks_chopper_gunner_pilot" ][ "pilot_intro" ], "camera_zoom" );
    var_35df31df1f9922a3 = getanimlength( level.scr_anim[ "ks_chopper_gunner_vehicle_camera" ][ "vehicle_intro" ] );
    choppergunner.var_7b78317bb6edb22e = var_35df31df1f9922a3 - var_9b493d9de01b76af;
    
    if ( isdefined( level.sharedfuncs[ #"chopper_gunner" ][ #"playintro" ] ) )
    {
        choppergunner.var_7b78317bb6edb22e = 0;
    }
    else
    {
        choppergunner thread function_e4e8ed8e95386f4e( thirdperson, var_35df31df1f9922a3 );
        choppergunner thread animation::anim_single_solo( choppergunner, "vehicle_intro" );
        anim_bone = choppergunner.tags.pilotanimate ?? "body_animate_jnt";
        
        if ( choppergunner.pilot )
        {
            choppergunner thread animation::anim_single_solo( choppergunner.pilot, "pilot_intro", anim_bone );
        }
        
        choppergunner function_e80653b547ad109d( choppergunner.interiorlighting );
        choppergunner choppergunner_startfadetransition( var_9b493d9de01b76af, thirdperson, 0.1 );
        choppergunner unlink_probe( choppergunner.interiorlighting );
    }
    
    if ( !isdefined( choppergunner ) || choppergunner.isexploding )
    {
        return;
    }
    
    choppergunner notify( #"start_chopper_use" );
    return choppergunner;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xbe5c4e6a, Offset: 0x2e71
// Size: 0xe
function function_f0c10f3224c0381e()
{
    self notify( #"killstreakexit" );
}

// Namespace chopper_gunner
// Params 2
// Checksum 0x486ba08a, Offset: 0x2e87
// Size: 0x2d, Type: bool
function function_e4a3e1b8ed7b4b26( trigger, vehicle )
{
    if ( trigger.targetname != "VTOL_OutOfBounds" )
    {
        return false;
    }
    
    return true;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x144ee41, Offset: 0x2ebd
// Size: 0xff
function choppergunner_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_59e7a04161418b9b;
    var_d188942a41771ea1 = &function_dcfbafd2c23e0b9d;
    premoddamagecallback = &choppergunner_premodifydamage;
    postmoddamagecallback = &choppergunner_postmodifydamage;
    deathcallback = &choppergunner_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    killstreak_utility::function_b555369eba6b0252( 1, 1500, &function_42794ce52e6f954d );
    killstreak_utility::function_b555369eba6b0252( 2, 1000, &function_353597c52f63292e );
    killstreak_utility::function_b555369eba6b0252( 3, 500, &function_dc420b2e60aa0c0c );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xde7c509, Offset: 0x2fc4
// Size: 0x17
function function_59e7a04161418b9b( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xf20e5c29, Offset: 0x2fe3
// Size: 0x152
function function_dcfbafd2c23e0b9d( streakname )
{
    weaponname = "thermite_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 30;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "thermite_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 80;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_bolt_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 11;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
    
    weaponname = "semtex_xmike109_mp";
    weaponhitsperattack = 1;
    var_ffcfe5819a7a67f1 = 18;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace chopper_gunner
// Params 2
// Checksum 0x7c257870, Offset: 0x313d
// Size: 0x13a
function choppergunner_watchintrodisown( exitaction, streakinfo )
{
    chopperowner = self.owner;
    self endon( #"death" );
    self endon( #"exit_chopper_intro" );
    self endon( #"start_chopper_use" );
    level endon( #"game_ended" );
    chopperowner waittill( exitaction );
    
    if ( exitaction == "disconnect" )
    {
        level.incomingallchoppergunners--;
        
        if ( game_utility::islargemap() && level.teambased )
        {
            level.incomingchoppergunners[ self.team ]--;
        }
    }
    
    if ( isdefined( chopperowner ) )
    {
        chopperowner cameraunlink();
        chopperowner disablephysicaldepthoffieldscripting();
        chopperowner val::group_reset( "chopperGunnerUse" );
        chopperowner val::reset_all( "chopperGunner" );
        chopperowner killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        chopperowner setclientomnvar( "ui_apache_screens_state", 0 );
        chopperowner painvisionon();
        chopperowner killstreak_shared::killstreak_restorenvgstate();
        chopperowner killstreak_utility::killstreak_setmainvision( "" );
        chopperowner killstreak_utility::function_f1c03b279632ba1e();
        level thread game_utility::fadetoblackforplayer( chopperowner, 0 );
    }
    
    thread choppergunner_explode();
    self notify( #"exit_chopper_intro" );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xafc3c5c, Offset: 0x327f
// Size: 0x3b, Type: bool
function choppergunner_waitintroanimtime( time )
{
    self endon( #"death" );
    self endon( #"exit_chopper_intro" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( time );
    return true;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x1aeba4cd, Offset: 0x32c3
// Size: 0x88
function choppergunner_playdofintroeffects()
{
    self endon( #"death" );
    self endon( #"exit_chopper_intro" );
    self.owner endon( #"disconnect" );
    self.owner enablephysicaldepthoffieldscripting();
    self.owner setphysicaldepthoffield( 4, 5000, 10, 10 );
    wait 2;
    self.owner setphysicaldepthoffield( 4, 20, 5, 10 );
    wait 1.5;
    self.owner setphysicaldepthoffield( 4, 1, 3, 10 );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x36d9bc6e, Offset: 0x3353
// Size: 0x8f
function choppergunner_camerashake( choppergunner )
{
    choppergunner endon( #"death" );
    choppergunner endon( #"explode" );
    choppergunner endon( #"leaving" );
    choppergunner endon( #"crashing" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self earthquakeforplayer( 0.01, 0.1, choppergunner gettagorigin( "tag_origin" ), 1000 );
        self playrumbleonentity( "damage_light" );
        wait 0.1;
    }
}

// Namespace chopper_gunner
// Params 2
// Checksum 0x5f5f95b3, Offset: 0x33ea
// Size: 0x74f
function function_75689d621768771( gunner, thirdperson )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    wait self.var_7b78317bb6edb22e;
    bundle = self.streakinfo.bundle;
    
    if ( isdefined( level.sharedfuncs[ #"chopper_gunner" ][ #"playintro" ] ) )
    {
        self.owner function_3fd6c39596383083( bundle.var_bb47001b41f0c291 );
    }
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
    }
    
    gunner = self.owner;
    gunner disablephysicaldepthoffieldscripting();
    
    if ( !thirdperson )
    {
        gunner.usingchoppergunner = 1;
        gunner val::set( "chopperGunner", "allow_movement", 1 );
        gunner val::set( "chopperGunner", "fire", 1 );
        gunner val::set( "chopperGunner", "ads", 1 );
        gunner cameraunlink();
        gunner thread killstreak_utility::function_785239235d790099( "default" );
        gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", self.lifetime, 0 );
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_2035c3300ee598c7" ) )
        {
            self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_2035c3300ee598c7" ) ]]( 1 );
        }
        else
        {
            choppergunner_updatetargetmarkergroups( 1, bundle );
        }
    }
    
    if ( isdefined( level.choppervisionset ) )
    {
        self.currentvisionset = level.choppervisionset;
    }
    
    if ( !isdefined( self.playersfx ) )
    {
        self.playersfx = spawn( "script_origin", self.origin );
        self.playersfx linkto( self );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_fd6c8efa17b475bf" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_fd6c8efa17b475bf" ) ]]();
    }
    else
    {
        weapon_utility::setlockedoncallback( self, &choppergunner_lockedoncallback );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_7a22056416abf8db" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_7a22056416abf8db" ) ]]();
    }
    else
    {
        weapon_utility::setlockedonremovedcallback( self, &choppergunner_lockedonremovedcallback );
    }
    
    self setcandamage( 1 );
    
    if ( bundle.var_4ed121bccb3ee0a7 != "" )
    {
        choppergunner_setmainvision( bundle.var_4ed121bccb3ee0a7 ?? "chopper_color_mp" );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"handlethermalswitch" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"handlethermalswitch" ) ]]( thirdperson );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_f3394fa941d2f2c8" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_f3394fa941d2f2c8" ) ]]( thirdperson );
    }
    
    thread choppergunner_watchturretfire( thirdperson );
    thread choppergunner_watchgameendleave( thirdperson );
    thread choppergunner_watchownerexitaction( "disconnect" );
    thread choppergunner_watchownerexitaction( "joined_team" );
    thread choppergunner_watchownerexitaction( "joined_spectator" );
    thread choppergunner_watchownerexitaction( "team_kill_punish" );
    thread choppergunner_watchownerexitaction( "player_fatal_death" );
    thread function_801b864f1cad757a();
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"handlemissilefire" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"handlemissilefire" ) ]]( thirdperson );
    }
    else
    {
        thread choppergunner_handlemissilefire( thirdperson );
    }
    
    if ( !self.infinite_chopper )
    {
        thread choppergunner_watchlifetime( thirdperson );
        self.owner setclientomnvar( "ui_killstreak_countdown", gettime() + int( self.lifetime * 1000 ) );
    }
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"watchlifetimecountdown" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"watchlifetimecountdown" ) ]]( self.owner, self.lifetime, self.infinite_chopper );
    }
    
    /#
        if ( thirdperson )
        {
            thread function_3aa658b96ce9e128();
            thread function_1d4b1316a6d66ddc();
            thread function_15485d42fe7106b9();
        }
    #/
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_1b30f8a402dc719c" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_1b30f8a402dc719c" ) ]]();
    }
    else if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        self thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &choppergunner_handlemissiledetection );
    }
    
    if ( !thirdperson )
    {
        if ( isdefined( level.choppervisionset ) )
        {
            self.currentvisionset = level.choppervisionset;
        }
        
        if ( self.currentvisionset )
        {
            gunner killstreak_utility::killstreak_setmainvision( self.currentvisionset );
        }
        
        gunner killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
        gunner setclientomnvar( "ui_apache_screens_state", 0 );
        gunner setclientomnvar( "ui_apache_controls", 1 );
        gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", self.missilesleft );
        gunner setclientomnvar( "ui_killstreak_health", self.health / self.maxhealth );
        gunner setclientomnvar( "ui_killstreak_flares", self.flaresreservecount );
        gunner setclientomnvar( "ui_killstreak_damage_state", 0 );
        self.playersfx playloopsound( "veh_apache_killstreak_amb_lr" );
        
        if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_d4135776a51dee3c" ) )
        {
            gunner [[ utility::getsharedfunc( #"chopper_gunner", #"hash_d4135776a51dee3c" ) ]]();
        }
        else
        {
            gunner setclienttriggeraudiozonepartialwithfade( "apache_killstreak", 1.5, "mix", "filter" );
        }
    }
    
    if ( gunner.ksempd )
    {
        choppergunner_handledeathdamage( gunner.var_c7dc16398800176e );
    }
    
    if ( !thirdperson )
    {
        choppergunner_takecontrol();
    }
    else
    {
        function_b19eb54669cbc3fc( self.origin, 1, 50, 1, 0 );
    }
    
    if ( self vehicle_isphysveh() )
    {
        self vehphys_setdefaultmotion();
    }
    
    thread choppergunner_watchearlyexit( thirdperson );
    var_4b740e30ada5e748 = function_fe82e3076da2a699();
    choppergunner_setspeed( var_4b740e30ada5e748.speed, var_4b740e30ada5e748.accel );
    hostmigration::waitlongdurationwithpause( 3 );
    
    if ( isdefined( level.heli_pilot_mesh ) )
    {
        /#
            var_526fa115c3fc4688 = getdvarint( @"hash_f3fcf3899fa2e1b0", 0 );
            
            if ( var_526fa115c3fc4688 != 0 )
            {
                return;
            }
        #/
        
        level.heli_pilot_mesh show();
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x463f1715, Offset: 0x3b41
// Size: 0xdf
function function_fe82e3076da2a699()
{
    speedsettings = spawnstruct();
    speedsettings.speed = 40;
    speedsettings.accel = 20;
    
    switch ( level.mapname )
    {
        case #"hash_1373c0a36e3cab54":
        case #"hash_81b84d832a53ee33":
        case #"hash_afcbd31dbcac0848":
        case #"hash_c23b803a5c7be5f3":
        case #"hash_dfa04d97b4cc9b44":
            speedsettings.speed = 25;
            speedsettings.accel = 15;
            break;
        case #"hash_150cb4659bbe6335":
        case #"hash_52f1fb3b7304621d":
        case #"hash_ae56d5b65ad78351":
            speedsettings.speed = 30;
            speedsettings.accel = 20;
            break;
    }
    
    return speedsettings;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x8b70cc80, Offset: 0x3c29
// Size: 0x87
function function_fecaeb63c3696c82( var_33c36f3e1ff4a937 )
{
    newheightoffset = var_33c36f3e1ff4a937;
    
    switch ( level.mapname )
    {
        case #"hash_52f1fb3b7304621d":
        case #"hash_81b84d832a53ee33":
        case #"hash_c23b803a5c7be5f3":
            newheightoffset += ( 0, 0, 300 );
            break;
        case #"hash_4c82fa7758456cd5":
            newheightoffset += ( 0, 0, 3000 );
            break;
    }
    
    return newheightoffset;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x787da886, Offset: 0x3cb9
// Size: 0x55
function choppergunner_lockedoncallback()
{
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_lockedon", #"locked_on", undefined, undefined, "pilot" );
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x121b81c5, Offset: 0x3d16
// Size: 0x1c
function choppergunner_lockedonremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace chopper_gunner
// Params 2
// Checksum 0xe356e742, Offset: 0x3d3a
// Size: 0x88
function choppergunner_updatetargetmarkergroups( togglestate, bundle )
{
    if ( togglestate )
    {
        params = { #var_4ef38b0aefb507c6:bundle.var_f057b69340b14a5c, #var_d33b439c3dce3f3d:bundle.var_598d79add3230927, #hideoverlaytargetmarkerfriendly:bundle.var_3f3a323868e1d507 };
        self.owner killstreak_shared::killstreak_assigntargetmarkers( params );
        return;
    }
    
    self.owner killstreak_shared::function_b3302c4317df36c6();
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xa9917a33, Offset: 0x3dca
// Size: 0x3d
function choppergunner_watchendstrobefx( choppergunner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    choppergunner utility::waittill_any( "death", "leaving" );
    self delete();
}

// Namespace chopper_gunner
// Params 3
// Checksum 0xee08ba07, Offset: 0x3e0f
// Size: 0x8f
function choppergunner_startfadetransition( timedelay, thirdperson, fadetoblacktime )
{
    self endon( #"death" );
    self endon( #"exit_chopper_intro" );
    
    if ( self.var_17e473e12ced7138 )
    {
        wait timedelay + fadetoblacktime;
        return;
    }
    
    hostmigration::waitlongdurationwithpause( timedelay );
    
    if ( !thirdperson )
    {
        level thread game_utility::fadetoblackforplayer( self.owner, 1, fadetoblacktime );
    }
    
    hostmigration::waitlongdurationwithpause( fadetoblacktime );
    
    if ( !thirdperson )
    {
        level thread game_utility::fadetoblackforplayer( self.owner, 0, fadetoblacktime );
    }
}

/#

    // Namespace chopper_gunner
    // Params 0
    // Checksum 0xba42ff7e, Offset: 0x3ea6
    // Size: 0xc1, Type: dev
    function function_3aa658b96ce9e128()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        turret_ref = function_3f99f2b5945fed8f();
        self.currentdebugweapon = turret_ref;
        choppergunnerowner = self.owner;
        choppergunnerowner notifyonplayercommand( "<dev string:x43>", "<dev string:x5f>" );
        missile_ref = "<dev string:x69>";
        
        while ( true )
        {
            choppergunnerowner waittill( #"hash_c6ed176edb39374a" );
            
            if ( self.currentdebugweapon == turret_ref )
            {
                self.currentdebugweapon = missile_ref;
            }
            else
            {
                self.currentdebugweapon = turret_ref;
            }
            
            choppergunnerowner iprintlnbold( "<dev string:x80>" + self.currentdebugweapon );
        }
    }

    // Namespace chopper_gunner
    // Params 0
    // Checksum 0xb81202b6, Offset: 0x3f6f
    // Size: 0xf7, Type: dev
    function function_1d4b1316a6d66ddc()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        choppergunnerowner = self.owner;
        choppergunnerowner notifyonplayercommand( "<dev string:x9b>", "<dev string:xb8>" );
        choppergunnerowner notifyonplayercommand( "<dev string:x9b>", "<dev string:xc3>" );
        self.var_5aef583c6b1681c4 = spawn( "<dev string:xcd>", self.origin );
        self.var_5aef583c6b1681c4 setmodel( "<dev string:xda>" );
        self.var_5aef583c6b1681c4 dontinterpolate();
        
        if ( self.turret.var_c8a15f1bbaf32456 )
        {
            self setturretscriptcontrolled( 1 );
        }
        
        while ( true )
        {
            choppergunnerowner waittill( #"hash_5261a63acff6840e" );
            
            if ( isdefined( self.testtargetent ) )
            {
                self clearlookatent();
                self.testtargetent delete();
            }
            
            thread function_d033924c771e9520( choppergunnerowner, self.currentdebugweapon );
        }
    }

    // Namespace chopper_gunner
    // Params 2
    // Checksum 0x244e7d66, Offset: 0x406e
    // Size: 0x1f8, Type: dev
    function function_d033924c771e9520( choppergunnerowner, weaponname )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        choppergunnerowner endon( #"disconnect" );
        choppergunnerowner endon( #"hash_5261a63acff6840e" );
        choppergunnerowner endon( #"hash_c6ed176edb39374a" );
        var_22ac029c5bc2ac90 = weaponfiretime( weaponname );
        targettracestart = choppergunnerowner getvieworigin();
        targettraceend = targettracestart + anglestoforward( choppergunnerowner getplayerangles() ) * 50000;
        targettrace = trace::ray_trace( targettracestart, targettraceend, self, trace::create_contents( 1, 1, 0, 1, 0, 1, 0, 1, 1 ) );
        fireposition = undefined;
        
        if ( targettrace[ "<dev string:xe5>" ] != "<dev string:xed>" )
        {
            fireposition = targettrace[ "<dev string:xfa>" ];
        }
        
        if ( !isdefined( fireposition ) )
        {
            return;
        }
        
        self.var_5aef583c6b1681c4.origin = fireposition;
        turret_ref = function_3f99f2b5945fed8f();
        
        if ( weaponname == turret_ref )
        {
            if ( self.turret.var_c8a15f1bbaf32456 )
            {
                self setturrettargetent( self.var_5aef583c6b1681c4 );
            }
            else
            {
                self.turret snaptotargetentity( self.var_5aef583c6b1681c4 );
            }
        }
        
        self.testtargetent = spawn( "<dev string:xcd>", fireposition );
        self setlookatent( self.testtargetent );
        
        while ( true )
        {
            if ( weaponname == turret_ref )
            {
                if ( self.turret.var_c8a15f1bbaf32456 )
                {
                    self requestfireweapon( 0 );
                }
                else
                {
                    self.turret shootturret();
                }
            }
            else
            {
                choppergunnerowner notify( #"shoot_missile", fireposition );
            }
            
            sphere( self.var_5aef583c6b1681c4.origin, 50, ( 1, 1, 0 ), 0, int( var_22ac029c5bc2ac90 ) );
            wait var_22ac029c5bc2ac90;
        }
    }

    // Namespace chopper_gunner
    // Params 0
    // Checksum 0x282d3dbb, Offset: 0x426e
    // Size: 0xec, Type: dev
    function function_15485d42fe7106b9()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        choppergunnerowner = self.owner;
        choppergunnerowner notifyonplayercommand( "<dev string:x103>", "<dev string:x120>" );
        choppergunnerowner notifyonplayercommand( "<dev string:x103>", "<dev string:x128>" );
        choppergunner_setspeed( 40, 45 );
        self.debugpathing = 0;
        
        while ( true )
        {
            choppergunnerowner waittill( #"hash_b17bc7bb8eb5697f" );
            
            if ( !self.debugpathing )
            {
                self.debugpathing = 1;
                choppergunnerowner iprintlnbold( "<dev string:x136>" );
            }
            else
            {
                self.debugpathing = 0;
                choppergunnerowner iprintlnbold( "<dev string:x14d>" );
                choppergunnerowner notify( #"stop_pathing" );
                function_b19eb54669cbc3fc( self.pathgoal, 1, 50, 1, 0 );
                continue;
            }
            
            thread function_f7db001dbda891a5( choppergunnerowner );
        }
    }

    // Namespace chopper_gunner
    // Params 1
    // Checksum 0x236e0a44, Offset: 0x4362
    // Size: 0xb7, Type: dev
    function function_f7db001dbda891a5( choppergunnerowner )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        choppergunnerowner endon( #"stop_pathing" );
        startingangle = 0;
        
        while ( true )
        {
            newgoal = self.origin + anglestoforward( ( 0, startingangle, 0 ) ) * 2000;
            sphere( newgoal, 50, ( 1, 1, 1 ), 0, 40 );
            startingangle += 20;
            function_b19eb54669cbc3fc( newgoal, 0, 50, 1, 0 );
            
            if ( startingangle >= 360 )
            {
                startingangle = 0;
            }
            
            wait 0.5;
        }
    }

#/

// Namespace chopper_gunner
// Params 1
// Checksum 0xc7e2a1ea, Offset: 0x4421
// Size: 0x17e
function choppergunner_handledangerzone( thirdperson )
{
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"death" );
    level endon( #"game_ended" );
    zone = undefined;
    zonepos = self.origin;
    zoneteam = self.team;
    zoneowner = self.owner;
    zoneparentent = self;
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        zone = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_da07c9d4d8bfe468", zonepos, zoneteam, zoneowner, zoneparentent );
    }
    
    if ( isdefined( zone ) && utility::issharedfuncdefined( #"spawn", #"getcodehandlefromscripthandle" ) )
    {
        codeid = [[ utility::getsharedfunc( #"spawn", #"getcodehandlefromscripthandle" ) ]]( zone );
        
        while ( true )
        {
            surfacetrace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 20000 ), self );
            
            if ( surfacetrace[ "hittype" ] != "hittype_none" )
            {
                spawninfluencepointsetposition( codeid, surfacetrace[ "position" ] );
            }
            
            hostmigration::waitlongdurationwithpause( 0.25 );
        }
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x6358b761, Offset: 0x45a7
// Size: 0x46
function choppergunner_handlethermalswitch( thirdperson )
{
    if ( !thirdperson )
    {
        choppergunnerowner = self.owner;
        choppergunnerowner thread player_utility::watchthermalinputchange();
        choppergunner_handlethermalswitchinternal();
        
        if ( isdefined( choppergunnerowner ) )
        {
            choppergunnerowner player_utility::stopwatchingthermalinputchange();
        }
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x62fb157e, Offset: 0x45f5
// Size: 0x19a
function choppergunner_handlethermalswitchinternal()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    choppergunnerowner = self.owner;
    thermaltoggle = 0;
    thermalstate = 0;
    thermalvisionset = killstreak_utility::function_2c6a2b2cb28d923a();
    var_b66d8e96f3afda0b = self.currentvisionset;
    
    if ( utility::isnightmap() )
    {
        choppergunnerowner player_utility::setthermalvision( 1, 12, 1000 );
        self.currentvisionset = thermalvisionset;
        choppergunnerowner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_flir_mp", #"top", self.lifetime, 0 );
        thermaltoggle = 1;
    }
    
    for ( thermalstate = 1; true ; thermalstate = 0 )
    {
        choppergunnerowner setclientomnvar( "ui_killstreak_thermal_mode", thermalstate );
        choppergunnerowner killstreak_utility::killstreak_setmainvision( self.currentvisionset );
        choppergunnerowner waittill( #"switch_thermal_mode" );
        choppergunnerowner notify( #"hash_9aafd1be0198f1b7", !thermaltoggle );
        
        if ( !thermaltoggle )
        {
            choppergunnerowner player_utility::setthermalvision( 1, 12, 1000 );
            self.currentvisionset = thermalvisionset;
            choppergunnerowner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_flir_mp", #"top", self.lifetime, 0 );
            thermaltoggle = 1;
            thermalstate = 1;
            continue;
        }
        
        choppergunner_setmainvision( var_b66d8e96f3afda0b );
        choppergunnerowner player_utility::setthermalvision( 0 );
        choppergunnerowner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", self.lifetime, 0 );
        thermaltoggle = 0;
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x5d72a886, Offset: 0x4797
// Size: 0x64
function choppergunner_setmainvision( var_89271af7741deb82 )
{
    if ( isdefined( level.choppervisionset ) )
    {
        self.owner killstreak_utility::killstreak_setmainvision( level.choppervisionset );
        self.currentvisionset = level.choppervisionset;
        return;
    }
    
    self.owner killstreak_utility::killstreak_setmainvision( var_89271af7741deb82 );
    self.currentvisionset = var_89271af7741deb82;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xc886d641, Offset: 0x4803
// Size: 0x4b4
function choppergunner_handlemissilefire( thirdperson )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    choppergunnerowner = self.owner;
    choppergunnerowner notifyonplayercommand( "shoot_missile", "+frag" );
    self.missilefireside = undefined;
    missilecounter = 0;
    var_390f6405f49ed1c0 = 4;
    var_85cc0db7a1e0dc02 = getdvarint( @"hash_52bf6045193decbf", 8 );
    
    while ( true )
    {
        choppergunnerowner waittill( #"shoot_missile", var_b8e2379deb5a344 );
        
        if ( self.infinite_chopper )
        {
            if ( self.missilesleft == var_85cc0db7a1e0dc02 )
            {
                childthread choppergunner_refillmissiles();
            }
        }
        
        missilecounter++;
        self.streakinfo.shots_fired++;
        
        if ( missilecounter > var_390f6405f49ed1c0 )
        {
            missilecounter = 1;
        }
        
        self.owner earthquakeforplayer( 0.25, 0.4, self.turret.origin, 150 );
        self.owner playrumbleonentity( "damage_heavy" );
        missilepod = self.mpod1;
        
        if ( !isdefined( self.missilefireside ) || self.missilefireside == "right" )
        {
            self.missilefireside = "left";
            missilepod = self.mpod1;
        }
        else
        {
            self.missilefireside = "right";
            missilepod = self.mpod2;
        }
        
        var_15c82a8d238fe5f5 = self.turret.var_c8a15f1bbaf32456 ? self : missilepod;
        var_15c82a8d238fe5f5 thread choppergunner_firemissilefx( missilecounter );
        turretviewpos = self.turret gettagorigin( self.tags.missileorigin ?? "tag_pivot" );
        var_4cad6d273c18f7d6 = anglestoforward( self.turret gettagangles( self.tags.missileforward ?? "tag_player" ) );
        missileorigin = missilepod.origin * ( 1, 1, 0 ) + ( 0, 0, turretviewpos[ 2 ] );
        missilestart = missileorigin + var_4cad6d273c18f7d6 * 100;
        missileend = missileorigin + var_4cad6d273c18f7d6 * 1000;
        targettracestart = self.owner getvieworigin();
        var_a51ec63ad16cfc41 = anglestoforward( self.owner getplayerangles() );
        targettraceend = targettracestart + var_a51ec63ad16cfc41 * 50000;
        ignorelist = [ self, self.turret, missilepod ];
        targettrace = trace::ray_trace( targettracestart, targettraceend, ignorelist, trace::create_contents( 1, 1, 0, 1, 0, 1, 0, 1, 1 ) );
        fireposition = targettrace[ "position" ];
        
        if ( isdefined( var_b8e2379deb5a344 ) )
        {
            fireposition = var_b8e2379deb5a344;
        }
        
        /#
            debugmissile = getdvarint( @"hash_a34a2f5a7d33e3bb", 0 );
            
            if ( debugmissile )
            {
                level thread debug_utility::drawline( missilestart, missileend, 10, ( 1, 1, 1 ) );
                level thread debug_utility::drawsphere( missilestart, 20, 10, ( 0, 1, 0 ) );
                level thread debug_utility::drawsphere( missileend, 20, 10, ( 1, 1, 0 ) );
                level thread debug_utility::drawsphere( fireposition, 20, 10, ( 1, 0, 0 ) );
            }
        #/
        
        missile_ref = "chopper_gunner_proj_mp";
        missile = weapon_utility::_magicbullet( makeweapon( missile_ref ), missilestart, missileend, choppergunnerowner );
        missile thread choppergunner_watchmissilestate( fireposition );
        missile thread choppergunner_watchexplosioninfluencepoint( self.owner );
        self notify( #"fired_missile", missile );
        missile.streakinfo = self.streakinfo;
        self.missilesleft--;
        choppergunnerowner setclientomnvar( "ui_killstreak_weapon_1_ammo", self.missilesleft );
        
        if ( self.missilesleft == 0 )
        {
            /#
                if ( thirdperson )
                {
                    missilecounter = 0;
                    self.missilesleft = getdvarint( @"hash_52bf6045193decbf", 8 );
                    choppergunnerowner setclientomnvar( "<dev string:x164>", self.missilesleft );
                    continue;
                }
            #/
            
            if ( self.infinite_chopper )
            {
                self waittill( #"missiles_refilled" );
                continue;
            }
            
            break;
        }
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xd4bb03ce, Offset: 0x4cbf
// Size: 0x75
function choppergunner_refillmissiles()
{
    self endon( #"missiles_refilled" );
    reload_duration = getdvarfloat( @"hash_2f91da9928400cbd", 8 );
    hostmigration::waitlongdurationwithpause( reload_duration );
    self.missilesleft = getdvarint( @"hash_52bf6045193decbf", 8 );
    self.owner setclientomnvar( "ui_killstreak_weapon_1_ammo", self.missilesleft );
    self notify( #"missiles_refilled" );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xedb36c54, Offset: 0x4d3c
// Size: 0xcd
function choppergunner_watchturretfire( thirdperson )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.turret waittill( #"missile_fire", missile );
        self.owner earthquakeforplayer( 0.15, 0.1, self.turret.origin, 150 );
        missile.streakinfo = self.streakinfo;
        self.streakinfo.shots_fired++;
        missile thread choppergunner_watchexplosioninfluencepoint( self.owner );
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xb258ff3f, Offset: 0x4e11
// Size: 0x4f
function choppergunner_firemissilefx( missileindex )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "fire_missile_" + missileindex, "on", 0 );
    wait 1;
    self setscriptablepartstate( "fire_missile_" + missileindex, "off", 0 );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x963ae2bb, Offset: 0x4e68
// Size: 0x31
function choppergunner_watchmissilestate( missiletargetpos )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.05 );
    
    if ( isdefined( self ) )
    {
        self missile_settargetpos( missiletargetpos );
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x812dd64d, Offset: 0x4ea1
// Size: 0xa9
function choppergunner_watchlifetime( thirdperson )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    lifetime = self.lifetime;
    hostmigration::waitlongdurationwithpause( lifetime );
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_leave", #"leave", 1, undefined, "pilot" );
    thread choppergunner_leave( thirdperson );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xd330f4a4, Offset: 0x4f52
// Size: 0xca
function choppergunner_watchgameendleave( thirdperson )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    thread choppergunner_leave( thirdperson );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x9867dbae, Offset: 0x5024
// Size: 0x16d
function function_72ebf2213d77c3d6( thirdperson )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( thirdperson )
    {
        return;
    }
    
    chopperbasefov = 65;
    lerptime = 0.25;
    currentfov = chopperbasefov;
    var_410a4bdf33c3b252 = 30;
    timeheld = 0;
    playedvision = 0;
    self.owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
    
    while ( true )
    {
        if ( self.owner adsbuttonpressed() )
        {
            timeheld += 0.05;
            
            if ( timeheld >= lerptime )
            {
                timeheld = lerptime;
            }
            
            if ( !playedvision )
            {
                self.owner killstreak_shared::function_8bd91ec764c0390b( "killstreak_ads_shutter" );
                playedvision = 1;
            }
        }
        else if ( timeheld > 0 )
        {
            timeheld -= 0.05;
            
            if ( timeheld <= 0 )
            {
                timeheld = 0;
            }
            
            if ( playedvision )
            {
                playedvision = 0;
            }
        }
        
        if ( timeheld >= 0 )
        {
            timeperc = timeheld / lerptime * 100;
            currentfov = int( timeperc * ( var_410a4bdf33c3b252 - chopperbasefov ) / 100 + chopperbasefov );
        }
        
        self.owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
        wait 0.05;
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xf6313cdc, Offset: 0x5199
// Size: 0x7b
function choppergunner_watchownerexitaction( exitaction )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self.owner waittill( exitaction );
    
    if ( exitaction == "player_fatal_death" )
    {
        thread choppergunner_leave();
        return;
    }
    
    thread choppergunner_returnplayer( 0, 0 );
    thread choppergunner_explode();
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xe6a4517f, Offset: 0x521c
// Size: 0x251
function choppergunner_watchtargets()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_engage", #"engage", undefined, undefined, "pilot" );
    hostmigration::waitlongdurationwithpause( 5 );
    
    while ( true )
    {
        visibletargets = [];
        
        foreach ( player in level.players )
        {
            if ( self.owner worldpointinreticle_circle( player.origin, 80, 100 ) )
            {
                if ( level.teambased && player.team == self.team )
                {
                    continue;
                }
                
                if ( player == self.owner )
                {
                    continue;
                }
                
                ignorelist = [ self, self.turret ];
                
                if ( !killstreak_utility::streakcanseetarget( self.turret gettagorigin( "tag_flash" ), player gettagorigin( "j_head" ), ignorelist ) )
                {
                    continue;
                }
                
                if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
                {
                    continue;
                }
                
                visibletargets = choppergunner_getnearbytargets( player );
                break;
            }
            
            wait 0.05;
        }
        
        if ( visibletargets.size > 0 && visibletargets.size < 2 )
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_attack_single", #"spotted_single", undefined, undefined, "pilot" );
        }
        else if ( visibletargets.size >= 2 )
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_attack_multi", #"spotted_multi", undefined, undefined, "pilot" );
        }
        
        wait randomintrange( 5, 15 );
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x53931f44, Offset: 0x5475
// Size: 0xf1
function choppergunner_getnearbytargets( maintarget )
{
    nearplayers = utility::playersincylinder( maintarget.origin, 300 );
    nearbytargets = [];
    
    foreach ( player in nearplayers )
    {
        if ( level.teambased && player.team != maintarget.team )
        {
            continue;
        }
        
        if ( !level.teambased && player == self.owner )
        {
            continue;
        }
        
        nearbytargets[ nearbytargets.size ] = player;
    }
    
    return nearbytargets;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x8ed9177c, Offset: 0x556f
// Size: 0x198
function function_801b864f1cad757a()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self.var_def1d41fdfcdaa7 = 0;
    self.var_5b044033d5ec9a1a = undefined;
    childthread choppergunner_watchkills();
    childthread function_8a9066bbcf56cac();
    missile_ref = "chopper_gunner_proj_mp";
    
    while ( true )
    {
        if ( self.var_def1d41fdfcdaa7 != 0 )
        {
            wait 2;
            
            if ( self.var_def1d41fdfcdaa7 >= 1 && self.var_5b044033d5ec9a1a == missile_ref )
            {
                killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_killconf_missile", #"hit_missile", undefined, undefined, "pilot" );
            }
            else if ( self.var_def1d41fdfcdaa7 == 1 )
            {
                killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_killconf_single", #"hit", undefined, undefined, "pilot" );
            }
            else if ( self.var_def1d41fdfcdaa7 >= 2 )
            {
                killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_killconf_multi", #"kill_multi", undefined, undefined, "pilot" );
            }
            
            self.var_def1d41fdfcdaa7 = 0;
            self.var_5b044033d5ec9a1a = undefined;
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xd55845e2, Offset: 0x570f
// Size: 0x5a
function choppergunner_watchkills()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_kill_buffered", recentkills, var_95795539e2a8343 );
        
        if ( isdefined( recentkills ) && isstring( var_95795539e2a8343 ) )
        {
            self.var_def1d41fdfcdaa7++;
            self.var_5b044033d5ec9a1a = var_95795539e2a8343;
        }
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xcadf34, Offset: 0x5771
// Size: 0x5a
function function_8a9066bbcf56cac()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_agent_kill_buffered", recentkills, weaponname );
        
        if ( isdefined( recentkills ) && isstring( weaponname ) )
        {
            self.var_def1d41fdfcdaa7++;
            self.var_5b044033d5ec9a1a = weaponname;
        }
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xa6570a81, Offset: 0x57d3
// Size: 0x2bb
function choppergunner_leave( thirdperson )
{
    self endon( #"death" );
    self endon( #"crashing" );
    thread choppergunner_returnplayer( 0, thirdperson );
    self setscriptablepartstate( #"camera_turret", #"show", 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 0 );
    }
    
    self clearlookatent();
    self notify( #"leaving" );
    self.isleaving = 1;
    var_afb8f3b781e97c77 = 3;
    flightheightoffset = ( 0, 0, 1000 );
    var_7de37a63fdf1b0f = self.origin + flightheightoffset;
    leavestart = undefined;
    leavegoal = undefined;
    leaveangles = undefined;
    
    while ( var_afb8f3b781e97c77 > 0 )
    {
        flightpath = killstreak_utility::function_9c51f918f2c46115( var_7de37a63fdf1b0f, self.angles, 400, 15000 );
        
        if ( isdefined( flightpath.end ) )
        {
            leavestart = flightpath.start;
            leavegoal = flightpath.end;
            leaveangles = flightpath.angles;
            break;
        }
        
        var_7de37a63fdf1b0f += ( 0, 0, 1000 );
        var_afb8f3b781e97c77--;
        wait 0.05;
    }
    
    if ( !isdefined( leavegoal ) )
    {
        thread choppergunner_explode();
        return;
    }
    
    turnspeed = 100;
    ascendspeed = 50;
    
    if ( !self.var_17e473e12ced7138 )
    {
        self setmaxpitchroll( 0, 0 );
        self setyawspeed( turnspeed, 50, 25, 0 );
        self settargetyaw( leaveangles[ 1 ] );
    }
    
    choppergunner_setspeed( ascendspeed, 25 );
    pathgoal = leavestart;
    function_b19eb54669cbc3fc( pathgoal, 1, 50, 1, 0 );
    utility::waittill_any_timeout( 3, "goal", "near_goal" );
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
    
    if ( !self.var_17e473e12ced7138 )
    {
        self setmaxpitchroll( 15, 15 );
    }
    
    choppergunner_setspeed( 150, self.accel );
    function_b19eb54669cbc3fc( leavegoal, 1, 1000, 1, 0 );
    utility::waittill_any_timeout( 10, "near_goal" );
    self notify( #"gone" );
    thread choppergunner_delete( 0 );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x34091b2f, Offset: 0x5a96
// Size: 0x55
function choppergunner_getpathend()
{
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xd8a7afe0, Offset: 0x5af4
// Size: 0xb6, Type: bool
function choppergunner_premodifydamage( data )
{
    if ( !level.var_deb9d2b3de25799b )
    {
        return true;
    }
    
    var_2e92350940c6845e = level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ];
    
    if ( !isdefined( var_2e92350940c6845e ) )
    {
        return true;
    }
    
    data.damage = self [[ var_2e92350940c6845e ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, self.streakinfo.bundle.var_20cb8f4e47f3353e, data );
    return true;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x8ad0975b, Offset: 0x5bb3
// Size: 0x161, Type: bool
function choppergunner_postmodifydamage( data )
{
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( isdefined( self.owner ) && self.owner isusingchoppergunner() )
    {
        var_44320290cb66d730 = "light";
        
        if ( isexplosivedamagemod( type ) )
        {
            if ( ceil( damage / self.maxhealth ) >= 0.33 )
            {
                self.owner earthquakeforplayer( 0.25, 0.2, self.turret.origin, 150 );
                self.owner playrumbleonentity( "damage_heavy" );
                var_44320290cb66d730 = "heavy";
            }
            else
            {
                self.owner earthquakeforplayer( 0.15, 0.15, self.turret.origin, 150 );
                self.owner playrumbleonentity( "damage_light" );
            }
        }
        
        if ( self.currentvisionset )
        {
            self.owner killstreak_shared::function_9fd22f7d1a941d8a( self.currentvisionset, var_44320290cb66d730 );
        }
    }
    
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xcb8f5103, Offset: 0x5d1d
// Size: 0x54
function function_42794ce52e6f954d()
{
    self setscriptablepartstate( "body_damage_light", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_light_damage", #"damage_light", undefined, undefined, "pilot" );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x429167c7, Offset: 0x5d79
// Size: 0x54
function function_353597c52f63292e()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_med_damage", #"damage_medium", undefined, undefined, "pilot" );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xefa9a0b8, Offset: 0x5dd5
// Size: 0x54
function function_dc420b2e60aa0c0c()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
    self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_heavy_damage", #"damage_heavy", undefined, undefined, "pilot" );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x1c9c9a9e, Offset: 0x5e31
// Size: 0x3f, Type: bool
function choppergunner_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    thread function_d282f17a8baa6108( data.attacker, data.objweapon );
    return true;
}

// Namespace chopper_gunner
// Params 2
// Checksum 0xa51eb81a, Offset: 0x5e79
// Size: 0xae
function function_d282f17a8baa6108( attacker, killedbyweapon )
{
    self endon( #"explode" );
    thirdperson = 0;
    
    /#
        thirdperson = getdvarint( @"hash_5053673c4770b74", 0 );
    #/
    
    shouldcrash = 1;
    
    if ( isdefined( self.owner ) && self.owner isusingchoppergunner() )
    {
        thread choppergunner_returnplayer( shouldcrash, thirdperson );
    }
    
    if ( shouldcrash )
    {
        function_e80653b547ad109d( self.interiorlighting );
        choppergunner_crash( 150, killedbyweapon );
        unlink_probe( self.interiorlighting );
    }
    
    thread choppergunner_explode();
}

// Namespace chopper_gunner
// Params 3
// Checksum 0x288b58df, Offset: 0x5f2f
// Size: 0x32f
function choppergunner_crash( speed, weaponkilledby, var_efd6abd0ea217b3d )
{
    self endon( #"explode" );
    self.iscrashing = 1;
    self clearlookatent();
    self notify( #"crashing" );
    self setscriptablepartstate( "engine_explosion", "on", 0 );
    self function_81aef1578a91f39e();
    
    if ( !self.var_17e473e12ced7138 )
    {
        self setmaxpitchroll( 10, 50 );
        self setneargoalnotifydist( 100 );
    }
    
    choppergunner_setspeed( speed, 20, 20 );
    glassdamagestate = "missile_damage";
    
    if ( weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        glassdamagestate = "bullet_damage";
    }
    
    self setscriptablepartstate( "glass", glassdamagestate, 0 );
    bundle = self.streakinfo.bundle;
    mindistance = bundle.var_9a34a6c279ea5695 ?? 500;
    maxdistance = bundle.var_9a5890c27a12a0eb ?? 4000;
    distance = randomintrange( mindistance, maxdistance );
    var_61f902b2dd6fc262 = choppergunner_findcrashposition( distance, bundle.crashzoffset ?? 1100 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        if ( bundle.var_8ca30ca22499a703 )
        {
            var_61f902b2dd6fc262 = choppergunner_findcrashposition( mindistance, bundle.crashzoffset ?? 1100 );
            
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
    
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_crash", #"destroyed", 1, undefined, "pilot" );
    function_b19eb54669cbc3fc( var_61f902b2dd6fc262, 0, 100, 0, 1 );
    thread choppergunner_spinout( speed, bundle.var_eb725408b25c95db ?? 35 );
    crashanim = "pilot_missile_crash";
    
    if ( weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        crashanim = "pilot_shot_crash";
    }
    
    anim_bone = self.tags.pilotanimate ?? "body_animate_jnt";
    thread animation::anim_single_solo( self.pilot, crashanim, anim_bone );
    
    if ( bundle.var_437d79d0d4c77860 )
    {
        self function_d2b8ee2e1275daaf( 0 );
        self vehphys_enablecollisioncallback( 1 );
        thread traceforanycollision();
        crashtime = bundle.var_59c1f28fba40f5b5 ?? 5;
        msg = utility::waittill_any_timeout( crashtime, "collision", "near_goal" );
        self notify( #"stop_trace_for_any_collision" );
        self function_d2b8ee2e1275daaf( 1 );
        self vehphys_enablecollisioncallback( 0 );
    }
    
    killstreak_utility::function_daa9374e3f6779a5( self.streakinfo.streakname, "pilot" );
}

// Namespace chopper_gunner
// Params 0, eflags: 0xc
// Checksum 0x87d8f4bc, Offset: 0x6266
// Size: 0xda
function private traceforanycollision()
{
    self notify( #"hash_e3446e50a1c4f492" );
    self endon( #"hash_e3446e50a1c4f492" );
    self endon( #"traceforanycollision", #"death", #"stop_trace_for_any_collision" );
    ignorelist = [ self, self.turret ];
    
    while ( true )
    {
        currentpos = self.origin;
        velocity = self vehicle_getvelocity();
        testpos = currentpos + velocity * level.framedurationseconds;
        collisiontrace = trace::sphere_trace( currentpos, testpos, 250, ignorelist );
        
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

// Namespace chopper_gunner
// Params 2
// Checksum 0xf3c08a11, Offset: 0x6348
// Size: 0xc3
function choppergunner_spinout( speed, acceleration )
{
    self endon( #"death" );
    yawspeed = 0;
    
    if ( self.var_17e473e12ced7138 )
    {
        self function_eb88c4e66edbc855( "p2p", "turnYawDegrees", angleclamp( self.angles[ 1 ] - 90 ) );
        
        while ( true )
        {
            yawspeed += acceleration * level.framedurationseconds;
            self function_eb88c4e66edbc855( "p2p", "turnYawSpeed", yawspeed );
            waitframe();
        }
        
        return;
    }
    
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] - speed * 0.6 );
        wait 0.5;
    }
}

// Namespace chopper_gunner
// Params 2
// Checksum 0xa7ee6b79, Offset: 0x6413
// Size: 0x1c6
function choppergunner_findcrashposition( crashdist, crashzoffset )
{
    crashstart = self.origin;
    crashoffset = ( 0, 0, crashzoffset );
    crashpos = undefined;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    
    /#
        if ( getdvarint( @"hash_f767cd931c8c9305", 0 ) > 0 )
        {
            crashend = crashstart - ( 0, 0, crashzoffset );
            crashpos = crashend;
            return crashpos;
        }
    #/
    
    crashend = crashstart + jetforward * crashdist - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetforward * crashdist - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + jetright * crashdist - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetright * crashdist - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward + jetright ) - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward - jetright ) - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetright - jetforward ) - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) - crashoffset;
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    return crashpos;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x1339b8a2, Offset: 0x65e2
// Size: 0x8d
function choppergunner_explode()
{
    if ( self.isexploding )
    {
        return;
    }
    
    self notify( #"explode" );
    self.isexploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_ballistics_mp" );
    }
    
    self setscriptablepartstate( "explode", "on", 0 );
    self setscriptablepartstate( "explode_smoke", "on", 0 );
    wait 0.35;
    thread choppergunner_delete( 1 );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x83b33404, Offset: 0x6677
// Size: 0x1c0
function choppergunner_delete( wasdestroyed )
{
    if ( self.iscleaning )
    {
        return;
    }
    
    self.iscleaning = 1;
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x180>", self.owner );
        }
    #/
    
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    self stoploopsound();
    
    if ( isdefined( self.pilot ) )
    {
        self.pilot delete();
    }
    
    if ( isdefined( self.firetarget ) )
    {
        self.firetarget delete();
    }
    
    if ( !self.turret.var_c8a15f1bbaf32456 )
    {
        self.turret setentityowner( undefined );
        self.turret delete();
    }
    
    if ( isdefined( self.mpod1 ) )
    {
        self.mpod1 setentityowner( undefined );
        self.mpod1 delete();
    }
    
    if ( isdefined( self.mpod2 ) )
    {
        self.mpod2 setentityowner( undefined );
        self.mpod2 delete();
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( self.owner )
    {
        self.owner.vehicle = undefined;
    }
    
    level.choppergunners = arrayremove( level.choppergunners, self );
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace chopper_gunner
// Params 2
// Checksum 0x628d1fff, Offset: 0x683f
// Size: 0x34d
function choppergunner_returnplayer( crashing, thirdperson )
{
    streakinfo = self.streakinfo;
    namespace_9d8e359c3b1041e5::clearoobsharedfunc( self, 1 );
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_2035c3300ee598c7" ) )
    {
        self thread [[ utility::getsharedfunc( #"chopper_gunner", #"hash_2035c3300ee598c7" ) ]]( 0 );
    }
    else
    {
        choppergunner_updatetargetmarkergroups( 0, streakinfo.bundle );
    }
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( streakinfo );
    }
    
    choppergunnerowner = self.owner;
    
    if ( !isdefined( choppergunnerowner ) )
    {
        return;
    }
    
    thread function_da837bd2386d4592( choppergunnerowner, crashing, thirdperson, streakinfo );
    choppergunnerowner notify( #"hash_cb7ac9afa735aa" );
    choppergunnerowner endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        choppergunnerowner [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 0 );
    }
    
    if ( isdefined( level.heli_pilot_mesh ) )
    {
        level.heli_pilot_mesh hide();
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx stoploopsound();
        self.playersfx delete();
    }
    
    choppergunner_lockedonremovedcallback();
    
    if ( utility::issharedfuncdefined( #"chopper_gunner", #"hash_c69023575532af09" ) )
    {
        choppergunnerowner [[ utility::getsharedfunc( #"chopper_gunner", #"hash_c69023575532af09" ) ]]();
    }
    else
    {
        choppergunnerowner clearclienttriggeraudiozone( 0.5 );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( isdefined( choppergunnerowner ) )
    {
        if ( !thirdperson )
        {
            choppergunnerowner val::set( "chopperGunner", "allow_movement", 0 );
            choppergunnerowner clearcinematicmotionoverride();
            choppergunnerowner player_utility::setthermalvision( 0 );
            function_fe2123dba85371ec( choppergunnerowner );
            choppergunnerowner killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
            choppergunnerowner setclientomnvar( "ui_apache_controls", 0 );
            choppergunnerowner killstreak_utility::killstreak_setmainvision( "" );
            choppergunnerowner shellshock_utility_cpmp::_stopshellshock();
            function_f8b152a9556b2f05();
            
            if ( crashing && self.showcockpit )
            {
                wait 0.05;
                choppergunnerowner setclientomnvar( "ui_apache_screens_state", 2 );
                choppergunnerowner thread killstreak_utility::function_785239235d790099( "80_instant_noscale" );
                choppergunnerowner cameralinkto( self.pilot, "tag_camera", 1, 1 );
                choppergunnerowner playlocalsound( "mp_killstreak_apache_death_plr" );
                
                if ( !self.isexploding )
                {
                    self waittill( #"explode" );
                }
                
                choppergunnerowner killstreak_utility::killstreak_setmainvision( "killstreak_static" );
                choppergunnerowner cameraunlink();
                wait 1;
                choppergunnerowner killstreak_utility::killstreak_setmainvision( "" );
            }
            
            choppergunnerowner val::group_reset( "chopperGunnerUse" );
            choppergunnerowner val::reset_all( "chopperGunner" );
            level thread killstreak_utility::restorekillstreakplayerangles( choppergunnerowner );
            choppergunnerowner killstreak_utility::function_f1c03b279632ba1e();
            choppergunnerowner setclientomnvar( "ui_apache_screens_state", 0 );
            choppergunnerowner painvisionon();
            choppergunnerowner killstreak_shared::killstreak_restorenvgstate();
            choppergunnerowner.usingchoppergunner = undefined;
        }
    }
    
    choppergunnerowner notify( #"chopperGunner_finished_crash_anim" );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace chopper_gunner
// Params 4
// Checksum 0x2033acd9, Offset: 0x6b94
// Size: 0xeb
function function_da837bd2386d4592( owner, crashing, thirdperson, streakinfo )
{
    if ( !crashing )
    {
        return;
    }
    
    self endon( #"explode" );
    owner endon( #"disconnect" );
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    /#
        iprintln( "<dev string:x1a1>" );
    #/
    
    if ( !thirdperson )
    {
        owner killstreak_utility::killstreak_setmainvision( "killstreak_static" );
        owner cameraunlink();
        owner killstreak_utility::killstreak_setmainvision( "" );
        level thread killstreak_utility::restorekillstreakplayerangles( owner );
        owner killstreak_utility::function_f1c03b279632ba1e();
        owner setclientomnvar( "ui_apache_screens_state", 0 );
        owner painvisionon();
        owner killstreak_shared::killstreak_restorenvgstate();
        owner.usingchoppergunner = undefined;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x5ab3f707, Offset: 0x6c87
// Size: 0x82
function choppergunner_watchearlyexit( thirdperson )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]( "leaving" );
    }
    
    self waittill( #"killstreakexit" );
    thread choppergunner_leave( thirdperson );
}

// Namespace chopper_gunner
// Params 4
// Checksum 0xa98ac166, Offset: 0x6d11
// Size: 0x1ce
function choppergunner_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
            {
                missiletarget thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( undefined, fxtagoverride );
            }
            
            missiletarget killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_flares", #"flares", undefined, undefined, "pilot" );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
            {
                missiletarget [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( player );
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xdfc64143, Offset: 0x6ee7
// Size: 0xc, Type: bool
function isusingchoppergunner()
{
    return isdefined( self.usingchoppergunner );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0xe1ec4b4a, Offset: 0x6efc
// Size: 0x9b
function choppergunner_watchexplosioninfluencepoint( owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"explode", position );
    owner notify( #"gunner_turret_impact", position );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_eafb9a6b88def4ca", position, owner.team, owner );
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x58cda6a2, Offset: 0x6f9f
// Size: 0x1a
function choppergunner_empapplied( data )
{
    if ( isdefined( self ) )
    {
        choppergunner_handledeathdamage( data );
    }
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x4fe60f20, Offset: 0x6fc1
// Size: 0xa4
function function_47f7381f126f7ff2( probe_name )
{
    lighting_info = spawnstruct();
    
    if ( isent( probe_name ) )
    {
        probe = getent( probe_name, #script_noteworthy );
    }
    else
    {
        probe = spawnstruct();
        
        /#
            self iprintln( "<dev string:x1ec>" );
        #/
    }
    
    lighting_info.probe = probe;
    var_fb2126a779c39960 = [];
    var_fb2126a779c39960[ "pos" ] = probe.origin;
    var_fb2126a779c39960[ "rot" ] = probe.angles;
    lighting_info.var_1bce669644d2d203 = var_fb2126a779c39960;
    return lighting_info;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x6ca3f5e, Offset: 0x706e
// Size: 0x5d
function function_e80653b547ad109d( lighting_info )
{
    if ( !isent( lighting_info ) )
    {
        return;
    }
    
    /#
        self.owner iprintln( "<dev string:x254>" );
    #/
    
    lighting_info.probe linkto( self, "tag_origin", ( 109, 0, -62 ), ( 0, 0, 0 ) );
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x202248d6, Offset: 0x70d3
// Size: 0x8b
function unlink_probe( lighting_info )
{
    if ( !isent( lighting_info ) )
    {
        return;
    }
    
    /#
        self.owner iprintln( "<dev string:x279>" );
    #/
    
    lighting_info.probe unlink();
    lighting_info.probe.origin = lighting_info.var_1bce669644d2d203[ "pos" ];
    lighting_info.probe.angles = lighting_info.var_1bce669644d2d203[ "rot" ];
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xf299ce4e, Offset: 0x7166
// Size: 0x15
function function_3f99f2b5945fed8f()
{
    turretweapon = "chopper_gunner_turret_ballistics_mp";
    return turretweapon;
}

// Namespace chopper_gunner
// Params 1
// Checksum 0x82459301, Offset: 0x7184
// Size: 0x319
function function_3964e2cd04789498( data )
{
    self endon( #"death" );
    self notify( #"hash_8dc47e77aac736f4" );
    self endon( #"hash_8dc47e77aac736f4" );
    self.owner endon( #"chopperGunner_finished_crash_anim" );
    self.owner endon( #"exit_chopper_intro" );
    thread function_a18c03cc875b3866();
    
    if ( !isdefined( self.var_fd125a9888e9226e ) && self.flaresreservecount > 0 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( undefined );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
        
        return;
    }
    
    if ( self.flaresreservecount > 0 && self.var_fd125a9888e9226e <= gettime() - 10000 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( undefined );
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
    }
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x3dbdb75d, Offset: 0x74a5
// Size: 0x153
function function_a18c03cc875b3866()
{
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.1, self.owner, "chopperGunner_finished_crash_anim", self.owner, "exit_chopper_intro", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
    result = utility::waittill_any_ents_or_timeout_return( 0.05, self.owner, "chopperGunner_finished_crash_anim", self.owner, "exit_chopper_intro", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.25, self.owner, "chopperGunner_finished_crash_anim", self.owner, "exit_chopper_intro", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
}

/#

    // Namespace chopper_gunner
    // Params 1
    // Checksum 0x4b373509, Offset: 0x7600
    // Size: 0x57, Type: dev
    function function_3adffbd34d9ff189( choppergunner )
    {
        choppergunner endon( #"death" );
        choppergunner endon( #"near_goal" );
        
        while ( true )
        {
            vehiclespeed = choppergunner vehicle_getspeed();
            self iprintln( "<dev string:x2a0>" + vehiclespeed );
            wait 0.5;
        }
    }

    // Namespace chopper_gunner
    // Params 0
    // Checksum 0x3662fe6d, Offset: 0x765f
    // Size: 0xb7, Type: dev
    function function_3e61d70aeabde5b3()
    {
        self endon( #"death" );
        self.owner endon( #"disconnect" );
        self.owner notifyonplayercommand( "<dev string:x2b1>", "<dev string:x2c4>" );
        state = "<dev string:x2cd>";
        
        while ( true )
        {
            var_365ab9759a17d92c = getdvarint( @"hash_6dcbef72bd1fd758", 0 );
            
            if ( !var_365ab9759a17d92c )
            {
                waitframe();
                continue;
            }
            
            self.owner waittill( #"hash_324fa67f349daf6c" );
            
            if ( state == "<dev string:x2cd>" )
            {
                state = "<dev string:x2d0>";
            }
            else
            {
                state = "<dev string:x2cd>";
            }
            
            self setscriptablepartstate( "<dev string:x2d4>", state, 0 );
        }
    }

    // Namespace chopper_gunner
    // Params 0
    // Checksum 0x764d0322, Offset: 0x771e
    // Size: 0x5c, Type: dev
    function function_2f712098557be2ca()
    {
        self endon( #"death" );
        wait 10;
        data = damage_utility::packdamagedata( self.owner, self, 1, self.currentprimaryweapon, "<dev string:x2db>", self );
        function_3964e2cd04789498( data );
        wait 10;
        function_3964e2cd04789498( data );
    }

#/

// Namespace chopper_gunner
// Params 6
// Checksum 0x1f8a7177, Offset: 0x7782
// Size: 0x203
function function_1b78ca2e1a266d39( thirdperson, streakinfo, origin, angles, choppergunnervehicle, choppergunnermodel )
{
    bundle = streakinfo.bundle;
    spawndata = { #targetname:streakinfo.streakname, #modelname:bundle.var_bd2f60b1744ba88f ?? choppergunnermodel, #vehicletype:bundle.var_dcdf13c9876edf1b ?? choppergunnervehicle, #angles:angles, #origin:origin };
    var_17e473e12ced7138 = bundle.var_221eaa299ea33f73 ?? 0;
    
    if ( var_17e473e12ced7138 )
    {
        choppergunner = vehicle_tracking::spawn_vehicle( spawndata );
        choppergunner addcomponent( "p2p" );
    }
    else
    {
        if ( !thirdperson )
        {
            spawndata.owner = self;
        }
        
        choppergunner = vehicle_tracking::spawn_helicopter( spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname );
    }
    
    choppergunner.var_17e473e12ced7138 = var_17e473e12ced7138;
    choppergunner.var_c8a15f1bbaf32456 = bundle.var_69932bf281e04309 ?? 0;
    choppergunner.tags = { #pilotanimate:bundle.var_c4cc2b8692cccd13, #missileforward:bundle.var_b2124c1d76e7fcbf, #missileorigin:bundle.var_7e8fec4141229264, #var_bf973a4d1cadadc9:bundle.var_536279728142411d, #var_795c9a23417e649c:bundle.var_f4a0483b32790ba8 };
    choppergunner.showcockpit = level.var_8564f62cdf263f2a.show_cockpit;
    return choppergunner;
}

// Namespace chopper_gunner
// Params 5
// Checksum 0x63535a65, Offset: 0x798e
// Size: 0x56
function function_b19eb54669cbc3fc( goalpos, stopatgoal, var_5197ba25f206c925, var_33a7f54f64823521, goalheightenable )
{
    if ( self.var_17e473e12ced7138 )
    {
        function_62998b8d900c5bd6( goalpos, stopatgoal, var_5197ba25f206c925, var_33a7f54f64823521, goalheightenable );
        return;
    }
    
    self setvehgoalpos( goalpos, stopatgoal );
}

// Namespace chopper_gunner
// Params 3
// Checksum 0xb8d83168, Offset: 0x79ec
// Size: 0x56
function choppergunner_setspeed( speed, acceleration, deceleration )
{
    if ( self.var_17e473e12ced7138 )
    {
        function_e37e82c2c3bb1d66( speed );
        return;
    }
    
    if ( acceleration && !deceleration )
    {
        deceleration = acceleration / 2;
    }
    
    self vehicle_setspeed( speed, acceleration, deceleration );
}

// Namespace chopper_gunner
// Params 0
// Checksum 0xede1c071, Offset: 0x7a4a
// Size: 0x6e
function choppergunner_takecontrol()
{
    if ( self.turret.var_c8a15f1bbaf32456 )
    {
        self.owner usevehicle( self, 0 );
    }
    else
    {
        self.owner remotecontrolturret( self.turret );
        self.owner remotecontrolvehicle( self );
    }
    
    self.driver = self.owner;
    self.ispiloted = 1;
}

// Namespace chopper_gunner
// Params 0
// Checksum 0x3751a268, Offset: 0x7ac0
// Size: 0x72
function function_f8b152a9556b2f05()
{
    if ( self.turret.var_c8a15f1bbaf32456 )
    {
        if ( self.owner isvehicleactive() )
        {
            self.owner leavevehicle();
        }
    }
    else
    {
        self.owner remotecontrolturretoff( self.turret );
        self.owner remotecontrolvehicleoff();
    }
    
    self.driver = undefined;
    self.ispiloted = 0;
}

// Namespace chopper_gunner
// Params 0, eflags: 0x4
// Checksum 0x3ce9da46, Offset: 0x7b3a
// Size: 0x19
function private function_16e3390b51f287b0()
{
    assert( self hascomponent( "<dev string:x2e9>" ), "<dev string:x2ed>" );
}

// Namespace chopper_gunner
// Params 1, eflags: 0x4
// Checksum 0x1a171e8, Offset: 0x7b5b
// Size: 0x2b
function private function_e37e82c2c3bb1d66( speedmph )
{
    function_16e3390b51f287b0();
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speedmph ) );
}

// Namespace chopper_gunner
// Params 5, eflags: 0x4
// Checksum 0x3c8a8799, Offset: 0x7b8e
// Size: 0xa6
function private function_62998b8d900c5bd6( goalpoint, stopatgoal, goaldistance, var_33a7f54f64823521, goalheightenable )
{
    function_16e3390b51f287b0();
    self function_eb88c4e66edbc855( "p2p", "reachGoal2DEnable", var_33a7f54f64823521 );
    self function_eb88c4e66edbc855( "p2p", "stopAtGoal", stopatgoal );
    self function_eb88c4e66edbc855( "p2p", "stopAtGoalOscillationFrequency", 0.25 );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", goalpoint );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", goaldistance );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", goalheightenable );
}

// Namespace chopper_gunner
// Params 2, eflags: 0x4
// Checksum 0x5139b4a7, Offset: 0x7c3c
// Size: 0x101
function private function_e4e8ed8e95386f4e( thirdperson, followduration )
{
    self endon( #"death" );
    self endon( #"exit_chopper_intro" );
    level endon( #"game_ended" );
    
    if ( thirdperson || self.showcockpit )
    {
        return;
    }
    
    forwardangles = anglestoforward( self.angles );
    followerorigin = self.origin - forwardangles * 1500 + ( 0, 0, 400 );
    follower = spawn( "script_model", followerorigin );
    follower setmodel( "tag_origin" );
    follower.angles = self.angles;
    follower linkto( self );
    self.owner cameralinkto( follower, "tag_origin", 0, 1 );
    wait followduration + 0.5;
    self.owner cameraunlink();
    follower delete();
}

