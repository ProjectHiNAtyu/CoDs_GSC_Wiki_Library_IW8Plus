// scripts\mp\common\killstreaks\mutant_injection_shared.gsc  (hash_311ceee0479ff157.gscc) (size: 45429 Bytes / 0xb175 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfdbeea0e (4257147406)
// size ...... 45429 (0xb175)
// includes .. 31  (offset: 0xa595)
// strings ... 151 (offset: 0xa68d)
// dev strs .. 5   (offset: 0xb075)
// exports ... 89  (offset: 0x7285)
// cseg ...... 0xd3b + 0x654a (0x7285)
// imports ... 290 (offset: 0x806d)
// animtree1 . 0   (offset: 0xb0b1)
// animtree2 . 12  (offset: 0xb0b1)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\matchdata;
#using scripts\mp\mtx_weapon;
#using scripts\mp\operator;
#using scripts\mp\parachute;
#using scripts\mp\playerhealth;
#using scripts\mp\teams;

#namespace mutant_injection_shared;

// Namespace mutant_injection_shared
// Params 0, eflags: 0x1
// Checksum 0xcd637f5b, Offset: 0xd59
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( #"zm_minj", &init );
}

// Namespace mutant_injection_shared
// Params 0
// Checksum 0xf62007f6, Offset: 0xd78
// Size: 0x180
function init()
{
    initkillstreak();
    scene::function_85b13b837056bc8b( &exit_mutant_injection_igc );
    utility::registersharedfunc( #"mutant_injection", #"force_exit_mutant_injection", &function_d2137a316b39f44a );
    utility::registersharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", &function_6fa2b0b46d2abcf7 );
    utility::registersharedfunc( #"mutant_injection", #"hash_e7b746f6b1c554e2", &function_7b49c94999eac823 );
    utility::registersharedfunc( #"mutant_injection", #"remove_mutant_injection", &function_2b562b60a3d69e6f );
    utility::registersharedfunc( #"mutant_injection", #"jumpwatcher", &function_971088f00ed2508b );
    utility::registersharedfunc( #"mutant_injection", #"hash_2f590838fdf8226f", &function_99c9f95e96f25130 );
    utility::registersharedfunc( #"mutant_injection", #"toggle_allows", &function_cfe6a5fed7778f67 );
    callback::add( #"player_item_pickup", &on_item_pickup );
    callback::add( #"hash_6998a4a69df2653", &function_ecdca0c410f5f75a );
    callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( "on_player_warp", &on_player_warp_callback );
    
    /#
        setdvarifuninitialized( @"hash_96b98824693e429", 0 );
    #/
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"init" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"init" ) ]]();
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xb48af0a9, Offset: 0xf00
// Size: 0x30
function private onavailable( streakitem )
{
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "zm_minj", utility::get_scripted_weapon_name( #"mutant_injection_cannon" ), #"low" );
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x9fa1fa68, Offset: 0xf38
// Size: 0x115, Type: bool
function private tryusemutantinjection( streakinfo )
{
    config = getconfig();
    assert( isdefined( config ), "<dev string:x24>" );
    setcontext( config, streakinfo );
    assert( isdefined( self.micontext ), "<dev string:x62>" );
    self.mutant_injection_start_time = undefined;
    
    if ( !canactivate() )
    {
        return false;
    }
    
    utility::callsharedfunc( #"killstreak", #"preparemutantinjection", self );
    mutantinjectionsuccess = makemutantinjection();
    utility::callsharedfunc( #"killstreak", #"cleanupmutantinjection", self );
    
    if ( !mutantinjectionsuccess )
    {
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
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
    
    /#
        if ( self.var_d43bbb33841dcc9d )
        {
            self.var_d43bbb33841dcc9d = undefined;
        }
    #/
    
    thread watchmutantinjection();
    return true;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x675829c2, Offset: 0x1056
// Size: 0x100
function private initkillstreak()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "zm_minj", &tryusemutantinjection, &onavailable );
        
        if ( isdefined( level.mutant_injection_variants ) )
        {
            foreach ( minj_variant_name in level.mutant_injection_variants )
            {
                self [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( minj_variant_name, &tryusemutantinjection, &onavailable );
            }
        }
    }
    
    killstreak_utility::registervisibilityomnvarforkillstreak( "zm_minj", "on", 17 );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x97f4daab, Offset: 0x115e
// Size: 0x345
function private watchmutantinjection()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.micontext.miconfig.var_d275b9f0df73d46f && self.mutantinjectiontransformed )
    {
        msg = [];
    }
    else
    {
        msg = utility::waittill_any_return_params( "mutantinjection_start", "mutant_injection_transform_interrupt" );
    }
    
    if ( msg[ "message" ] == "mutant_injection_transform_interrupt" )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:self.micontext.streakinfo } );
        
        if ( self.mutantinjectiontransformed )
        {
            instant_exit = msg[ 0 ] == "mutant_injecton_instant_exit";
            function_2b562b60a3d69e6f( 0, instant_exit );
        }
        
        return;
    }
    
    self enableplayerbreathsystem( 0 );
    self setsoundsubmix( "cer_zm_mutantinjection_duration_plr" );
    killstreak_utility::function_d546aaa588f088c3( "zm_minj", "on" );
    self setclientomnvar( "ui_exit_progress", 0 );
    endons = [ "mutantinjection_end", "death_or_disconnect" ];
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_2a99682c5fc5e5ab" ) )
    {
        thread utility::callsharedfunc( #"mutant_injection", #"hash_2a99682c5fc5e5ab", endons );
    }
    else
    {
        player::function_ba055eee4438741e( "exit_mutant_injection", "stance", &tryexiting, undefined, endons, 1, &function_1617690e741ab65b, "gamepad_only" );
        player::function_ba055eee4438741e( "exit_mutant_injection", "movedown", &tryexiting, undefined, endons, 1, &function_1617690e741ab65b, "kbm_only" );
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"overridetimeout" ) )
    {
        thread utility::callsharedfunc( #"mutant_injection", #"overridetimeout", [ "mutantinjection_end", "mutantinjection_exit" ] );
    }
    else
    {
        thread function_f78e95f89df37e96( [ "mutantinjection_end", "mutantinjection_exit" ] );
    }
    
    msg = utility::waittill_any_return( "mutant_injection_time_out", "mutantinjection_end", "mutantinjection_exit" );
    
    /#
        while ( getdvarint( @"hash_96b98824693e429", 0 ) == 1 )
        {
            waitframe();
        }
    #/
    
    ground_trace_start_time = gettime();
    ground_trace_start_origin = self.origin;
    close_dist_sqr = 225;
    
    while ( !self isonground() && !self isswimming() && !self isswimunderwater() )
    {
        waitframe();
        
        if ( gettime() - ground_trace_start_time >= 1000 && distancesquared( self.origin, ground_trace_start_origin ) <= close_dist_sqr )
        {
            break;
        }
    }
    
    self clearsoundsubmix( "cer_zm_mutantinjection_duration_plr" );
    self enableplayerbreathsystem( 1 );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.micontext.streakinfo } );
    killstreak_utility::function_d546aaa588f088c3( "zm_minj", "off" );
    
    if ( self.ismutantinjection )
    {
        istimeout = msg == "mutant_injection_time_out";
        thread function_2b562b60a3d69e6f( istimeout, self.micontext.miconfig.var_573b7ef5186ac8c6 );
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x581f790d, Offset: 0x14ab
// Size: 0x71
function private tryexiting( var_c1fa5c1e922e62d6 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_exit_progress", 1 );
        wait 0.1;
        self.var_7c3f6f044dd61c1 = undefined;
        self notify( #"mutantinjection_exit" );
        self setclientomnvar( "ui_exit_progress", 0 );
    }
}

// Namespace mutant_injection_shared
// Params 3, eflags: 0x4
// Checksum 0xbbdb4e6a, Offset: 0x1524
// Size: 0x9a
function private function_1617690e741ab65b( var_c1fa5c1e922e62d6, progress, iscomplete )
{
    var_4659d2db90ce8d11 = !iscomplete && progress == 0;
    var_396cd01eb7f30190 = 0;
    
    if ( var_4659d2db90ce8d11 )
    {
        self.var_7c3f6f044dd61c1 = undefined;
    }
    else if ( progress > 0 )
    {
        if ( !isdefined( self.var_7c3f6f044dd61c1 ) )
        {
            self.var_7c3f6f044dd61c1 = gettime() - progress;
        }
        
        var_396cd01eb7f30190 = ( gettime() - self.var_7c3f6f044dd61c1 ) / 1000;
    }
    
    self setclientomnvar( "ui_exit_progress", var_396cd01eb7f30190 );
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x435115a5, Offset: 0x15c6
// Size: 0x1aa
function private function_f78e95f89df37e96( endnotes )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isarray( endnotes ) )
    {
        foreach ( note in endnotes )
        {
            self endon( note );
        }
    }
    
    streakname = function_3033707e7b408423();
    bundle = level.streakglobals.streakbundles[ streakname ];
    streak_time = bundle.mutantinjectiondata.duration > 0 ? bundle.mutantinjectiondata.duration : 45;
    duration = utility::function_4b74c15943231980( streak_time );
    start_time = gettime();
    self.mutant_injection_end_time = start_time + duration;
    self.mutant_injection_start_time = start_time;
    
    while ( gettime() < self.mutant_injection_end_time )
    {
        time_progress = ( self.mutant_injection_end_time - gettime() ) / duration;
        self setclientomnvar( "ui_zm_zm_minj_progress", time_progress );
        waitframe();
    }
    
    self setclientomnvar( "ui_zm_zm_minj_progress", 0 );
    self.mutant_injection_end_time = undefined;
    self.mutant_injection_start_time = undefined;
    self notify( #"mutant_injection_time_out" );
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0x68f995ba, Offset: 0x1778
// Size: 0x21
function function_4860a77f84a3ed4d( adjust_time )
{
    self.mutant_injection_end_time += adjust_time;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xe5748e3b, Offset: 0x17a1
// Size: 0xb
function private exit_mutant_injection_igc()
{
    function_d2137a316b39f44a( 1 );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xe49cee30, Offset: 0x17b4
// Size: 0x42
function private function_5316ad8325da7f35()
{
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
    }
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0xf074c5a5, Offset: 0x17fe
// Size: 0x4ef
function private setcontext( miconfig, streakinfo )
{
    if ( !isdefined( self.micontext ) )
    {
        self.micontext = {};
    }
    
    micontext = self.micontext;
    micontext.miconfig = miconfig;
    micontext.streakinfo = streakinfo;
    micontext.var_a9c6c85962429e1c = self.operatorcustomization.operatorref;
    micontext.var_716d2096928c8cab = self.operatorcustomization.skinref;
    micontext.prevexecution = undefined;
    micontext.var_7b7aea5124610b5e = undefined;
    micontext.var_20a634c3d7f708bf = &function_8c25aa430f650eb5;
    
    if ( isdefined( self.operatorcustomization.execution ) )
    {
        micontext.prevexecution = self.operatorcustomization.execution;
        micontext.var_7b7aea5124610b5e = execution::execution_getpropweaponbyref( micontext.prevexecution );
    }
    
    var_4e696c1264ef4e4a = self getcamerathirdperson();
    
    if ( var_4e696c1264ef4e4a )
    {
        micontext.var_5828aa3111d7fa78 = 1;
    }
    
    if ( self getweaponslistprimaries().size > 1 )
    {
        micontext.lastweaponobj = self getcurrentweapon();
        micontext.weapstructs = [];
        weaplist = self getweaponslistprimaries();
        meleeoverrideweapon = self getweaponmeleeslot();
        
        foreach ( weap in weaplist )
        {
            ismeleeoverrideweapon = !isnullweapon( meleeoverrideweapon ) && weap == meleeoverrideweapon;
            
            if ( !weap.isalternate )
            {
                weapstruct = {};
                weapstruct.weaponobj = weap;
                weapstruct.clipammo = self getweaponammoclip( weap );
                weapstruct.stockammo = self getweaponammostock( weap );
                weapstruct.var_31b84291bf81176d = self function_8eb1b5d840aac85d( weap );
                weapstruct.ismeleeoverrideweapon = ismeleeoverrideweapon;
                altweapon = weap getaltweapon();
                weapstruct.altclipammo = self getweaponammoclip( altweapon );
                weapstruct.altstockammo = self getweaponammostock( altweapon );
                micontext.weapstructs[ micontext.weapstructs.size ] = weapstruct;
            }
        }
    }
    
    streakname = function_3033707e7b408423();
    bundle = level.streakglobals.streakbundles[ streakname ];
    weaponinfo = getweaponinfo( bundle.mutantinjectiondata.ismeleeonly );
    micontext.weapon = weaponinfo.primaryweapon;
    micontext.weaponVariantID = miconfig.var_11c7412d6ca58160 ?? -1;
    micontext.bundle = bundle;
    micontext.deployweaponobj = makeweapon( bundle.deployweaponname );
    micontext.var_cd7fbd135a81723f = bundle.mutantinjectiondata.var_cd7fbd135a81723f ?? 1;
    micontext.var_f4cfb89f123543d9 = bundle.mutantinjectiondata.var_f4cfb89f123543d9 ?? 0;
    micontext.validstance = function_7554b9424397983( miconfig );
    micontext.bundleoperator = bundle.mutantinjectiondata.operator;
    micontext.bundlesuit = bundle.mutantinjectiondata.suit;
    micontext.bundleskin = bundle.mutantinjectiondata.operatorskin;
    micontext.var_69224c24ef535a12 = 1;
    
    if ( bundle.mutantinjectiondata.ismeleeonly )
    {
        micontext.miconfig.allows[ "fire" ] = 0;
        micontext.ismeleeonly = 1;
    }
    
    if ( micontext.lastweaponobj.isalternate )
    {
        micontext.lastweaponobj = micontext.lastweaponobj getnoaltweapon();
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"setcontext" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"setcontext" ) ]]( miconfig, streakinfo );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x3e334622, Offset: 0x1cf5
// Size: 0x239, Type: bool
function private canactivate()
{
    if ( function_620f88a1b583b28b() )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( self.var_ff2e0673e13ac2ee )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isalive( self ) || self.inlaststand )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( isdefined( self.carrier ) || utility::isusingremote() || !self isonground() )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( self.var_d1c4c78b9fb7d153 )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( self isswitchingweapon() )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    bundle = level.streakglobals.streakbundles[ "zm_minj" ];
    var_1ac1cdf8bd22438a = bundle.mutantinjectiondata.var_1ac1cdf8bd22438a ?? 5;
    hit_water = is_hit_water( var_1ac1cdf8bd22438a );
    
    if ( hit_water )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( self isdiving() )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( isweapon( self.micontext.lastweaponobj ) && isnullweapon( self.micontext.lastweaponobj ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( self.micontext.validstance ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( self.micontext.streakinfo ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( self.micontext.bundle.deployweaponname ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( self.micontext.deployweaponobj ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"canactivate" ) )
    {
        if ( !self [[ utility::getsharedfunc( #"mutant_injection", #"canactivate" ) ]]() )
        {
            function_5316ad8325da7f35();
            return false;
        }
    }
    
    return true;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xf08c4805, Offset: 0x1f37
// Size: 0x163, Type: bool
function private makemutantinjection()
{
    activeoperator = function_eb473d6ac5f83a82().operator;
    operatorrefs = operator::getoperatorrefs();
    
    if ( activeoperator && !isdefined( operatorrefs[ activeoperator ] ) )
    {
        operator::function_449035ab2454100( activeoperator );
    }
    
    allows = [];
    allows[ "disallow_loot_but_auto_loot" ] = 1;
    allows[ "damage" ] = 0;
    allows[ "supers" ] = 0;
    function_cfe6a5fed7778f67( allows, 0 );
    
    if ( self.micontext.miconfig.var_d275b9f0df73d46f )
    {
    }
    else
    {
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponswitchdeploysharedfunc( self.micontext.streakinfo, self.micontext.deployweaponobj, 1 );
        
        if ( !deployresult )
        {
            function_cfe6a5fed7778f67( allows, 1 );
            return false;
        }
    }
    
    if ( namespace_9d8e359c3b1041e5::issuperinusesharedfunc() )
    {
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            self thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0, 0, 1 );
        }
    }
    
    thread starttransformation();
    self.streakinfo = self.micontext.streakinfo;
    self.streakinfo.kills = 0;
    return true;
}

#using_animtree( "script_model" );

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x348d7127, Offset: 0x20a3
// Size: 0xb4, Type: bool
function private function_f247f77ac7ba541a( deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    thread function_28574f8ad2fa1b99();
    animlength = getanimlength( %t10_mstr_mangler_1p_transformation ) - 0.5;
    msg = utility::waittill_any_timeout( animlength, "mutant_injecton_instant_exit", "weapon_change", "cancel_all_killstreak_deployments" );
    self notify( #"hash_f5c8864fef988d68" );
    val::set( "mutant_injection_no_weapon_raise", "weapon", 0 );
    inventory_utility::_takeweapon( deployweaponobj );
    val::reset_all( "mutant_injection_no_weapon_raise" );
    
    if ( isdefined( msg ) && msg != "timeout" )
    {
        return false;
    }
    
    return true;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x18d836db, Offset: 0x2160
// Size: 0x69
function private function_28574f8ad2fa1b99()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f5c8864fef988d68" );
    
    while ( true )
    {
        canceldeployment = 0;
        
        if ( player_utility::isswimmingunderwater() )
        {
            canceldeployment = 1;
        }
        
        if ( canceldeployment )
        {
            self notify( #"cancel_all_killstreak_deployments" );
            self notify( #"mutant_injecton_instant_exit" );
            break;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0x6816d93d, Offset: 0x21d1
// Size: 0x139
function private function_20a634c3d7f708bf( player, isactive )
{
    playersquadindex = player.sessionsquadid;
    var_25f925f48ee1e217 = player.sessionuimemberindex;
    
    if ( !squad_utility::issquadmode() )
    {
        var_25f925f48ee1e217 = 0;
        player function_47457b9ec007482e( "ui_is_player_at_squad_index_mutant", var_25f925f48ee1e217, 1, isactive );
    }
    else if ( var_25f925f48ee1e217 != -1 )
    {
        foreach ( squadplayer in level.players )
        {
            if ( squadplayer.sessionsquadid == playersquadindex )
            {
                squadplayer function_47457b9ec007482e( "ui_is_player_at_squad_index_mutant", var_25f925f48ee1e217, 1, isactive );
            }
        }
    }
    
    micontext = self.micontext;
    
    if ( isdefined( micontext.var_20a634c3d7f708bf ) )
    {
        self [[ micontext.var_20a634c3d7f708bf ]]( { #isactive:isactive } );
    }
}

#using_animtree( "playerasm" );

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xcb85bdf6, Offset: 0x2312
// Size: 0x95a
function private starttransformation()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.ismutantinjection = 1;
    function_261c3b5b33fbad35( self );
    self setclientomnvar( "is_zm_minj", 1 );
    function_20a634c3d7f708bf( self, 1 );
    val::set( "mutant_injection_hide_perks", "show_perks", 0 );
    level thread function_414ddb49e4cd2b25();
    val::set( "mutant_injection_disallow_grab", "allow_grab", 0 );
    gas_grenade::gas_updateplayereffects();
    gas_grenade::gas_clear();
    
    if ( self.health < self.maxhealth )
    {
        playerhealth::forcehealthregen( self );
    }
    
    weapon_utility::saveweaponstates();
    
    if ( isdefined( self.micontext.miconfig.pre_allows ) )
    {
        function_cfe6a5fed7778f67( self.micontext.miconfig.pre_allows, 0 );
    }
    
    function_67fb1a947bc1fccb();
    utility::function_32b24db3127bff40( "zm_minj_transform_in", "vfx_on" );
    
    if ( self.micontext.miconfig.var_d275b9f0df73d46f )
    {
        need_exit = 0;
    }
    else
    {
        need_exit = !function_f247f77ac7ba541a( self.micontext.deployweaponobj );
    }
    
    /#
        if ( self.var_d0cbfedfe2b9906b )
        {
            need_exit = 0;
        }
    #/
    
    if ( !need_exit )
    {
        while ( true )
        {
            hitwater = is_hit_water();
            
            if ( self isonground() && !hitwater )
            {
                break;
            }
            
            if ( hitwater )
            {
                function_5316ad8325da7f35();
                need_exit = 1;
                break;
            }
            
            waitframe();
        }
        
        if ( !need_exit )
        {
            validstance = function_7554b9424397983( self.micontext.miconfig );
            
            if ( !isdefined( validstance ) )
            {
                function_5316ad8325da7f35();
                need_exit = 1;
            }
        }
    }
    
    if ( need_exit )
    {
        if ( isdefined( self.micontext.miconfig.pre_allows ) )
        {
            function_cfe6a5fed7778f67( self.micontext.miconfig.pre_allows, 1 );
        }
        
        val::reset_all( "mutant_injection_disallow_grab" );
        function_251f818850fdb794( self );
        self setclientomnvar( "is_zm_minj", 0 );
        function_20a634c3d7f708bf( self, 0 );
        val::reset_all( "mutant_injection_hide_perks" );
        self.ismutantinjection = undefined;
        
        if ( !self.micontext.miconfig.disablerefund )
        {
            var_7039ccb93e83d1e7 = function_3033707e7b408423();
            namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( var_7039ccb93e83d1e7, "other", undefined, undefined, undefined, 1 );
        }
        
        if ( isdefined( self.micontext.lastweaponobj ) )
        {
            inventory_utility::_switchtoweaponimmediate( self.micontext.lastweaponobj );
        }
        
        function_55199c384a3f84f3();
        utility::function_32b24db3127bff40( "zm_minj_transform_in", "off" );
        self notify( #"mutant_injection_transform_interrupt" );
        return;
    }
    
    callback::callback( #"hash_5b8b82c2527d7aa2", { #streak_name:function_3033707e7b408423() } );
    function_e214e57b2601c478();
    self freezecontrols( 1 );
    var_4e696c1264ef4e4a = self getcamerathirdperson();
    
    if ( !var_4e696c1264ef4e4a )
    {
        self setcamerathirdperson( 1 );
    }
    
    mtx_weapon::function_4bafd0f14b064f2a();
    
    if ( self getweaponslistprimaries().size > 1 )
    {
        weaplist = self getweaponslistprimaries();
        
        foreach ( weap in weaplist )
        {
            item_weapon::function_e570f94856126417( weap );
            item_weapon::function_9e7275fa51ace996( weap, "mutantinjection_starttransformation" );
        }
        
        foreach ( weap in weaplist )
        {
            inventory_utility::_takeweapon( weap );
        }
    }
    
    injectionweapon = weapon::buildweapon( self.micontext.weapon, undefined, undefined, undefined, self.micontext.weaponVariantID );
    inventory_utility::_giveweapon( injectionweapon, self.micontext.weaponVariantID );
    inventory_utility::_switchtoweaponimmediate( injectionweapon );
    weapon::fixupplayerweapons( self, self.micontext.weapon );
    self.micontext.weaponobj = injectionweapon;
    equipmentinfo = function_a12fa9194f151302();
    
    if ( equipmentinfo.primaryequipment )
    {
        equipment_mp::giveequipment( equipmentinfo.primaryequipment, "primary" );
        equipment_mp::setequipmentammo( equipmentinfo.primaryequipment, equipmentinfo.var_c547153026652d56 );
    }
    
    if ( equipmentinfo.secondaryequipment )
    {
        equipment_mp::giveequipment( equipmentinfo.secondaryequipment, "secondary" );
        equipment_mp::setequipmentammo( equipmentinfo.secondaryequipment, equipmentinfo.var_6a168be0e4faa066 );
    }
    
    foreach ( perk, unused in self.micontext.miconfig.perks )
    {
        perk::giveperk( perk );
    }
    
    function_cfe6a5fed7778f67( self.micontext.miconfig.allows, 0 );
    thread function_2323a0783b6b083();
    operatorinfo = function_eb473d6ac5f83a82();
    function_fc3bb3b83b7479b6( operatorinfo.operator, operatorinfo.skin, operatorinfo.suit, operatorinfo.var_69224c24ef535a12 );
    players = getplayersinradius( self.origin, 200 );
    utility::player_prestream_assets( "mutant_injection", "entity", players, 200, 5 );
    killstreak_utility::function_bea4bda17e40ffb0( self );
    
    if ( self.micontext.miconfig.infiniteammo )
    {
        thread weapon::infiniteammothread( self.micontext.miconfig.infiniteammoupdaterate, [ self.micontext.weapon ] );
    }
    
    if ( self.micontext.miconfig.var_60e112d2e106b00a )
    {
        self function_60e112d2e106b00a();
    }
    
    var_1a51232331718d97 = self.micontext.validstance != self getstance();
    
    if ( var_1a51232331718d97 )
    {
        self setstance( self.micontext.validstance );
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"starttransformation" ) )
    {
        [[ utility::getsharedfunc( #"mutant_injection", #"starttransformation" ) ]]();
    }
    
    val::set( "mutant_injection_transformation", "fire", 0 );
    self.get_cannon_fire_params = &get_cannon_fire_params;
    
    while ( !function_3b53a4500e5d3c9( %t10_mstr_mangler_wm_trans_02, self ) )
    {
        waitframe();
    }
    
    utility::function_32b24db3127bff40( "zm_minj_transform_in", "off" );
    
    if ( self.micontext.miconfig.var_bf95338539967227 )
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_in", "vfx_quick_on" );
    }
    else
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_in", "vfx_on" );
    }
    
    bundle = level.streakglobals.streakbundles[ function_3033707e7b408423() ];
    
    if ( !bundle.mutantinjectiondata.ismeleeonly )
    {
        utility::function_32b24db3127bff40( "zm_minj_ambient_vfx", "vfx_on" );
    }
    
    if ( self.micontext.miconfig.var_bf95338539967227 )
    {
        waitframe();
    }
    else
    {
        self playanimscriptsceneevent( "scripted_scene", "t10_mstr_mangler_wm_trans_02", 0 );
        transform_time = getanimlength( %t10_mstr_mangler_wm_trans_02 );
        msg = utility::waittill_any_timeout( transform_time, "mutant_injecton_instant_exit" );
    }
    
    need_instant_exit = 0;
    
    if ( msg == "mutant_injecton_instant_exit" )
    {
        need_instant_exit = 1;
    }
    
    self freezecontrols( 0 );
    val::reset_all( "mutant_injection_transformation" );
    
    if ( need_instant_exit )
    {
        self notify( #"mutant_injection_transform_interrupt", "mutant_injecton_instant_exit" );
        callback::callback( #"hash_347b41546632b85a", {} );
    }
    else
    {
        completetransformation();
    }
    
    self setclientomnvar( "is_zm_minj", 0 );
    self.mutantinjectiontransformed = 1;
}

// Namespace mutant_injection_shared
// Params 0
// Checksum 0x602e43d7, Offset: 0x2c74
// Size: 0xc1
function function_a12fa9194f151302()
{
    primaryequipment = equipment_mp::function_fdc4a655fbde0dec( self.micontext.miconfig.var_58bcf9d6158779a5 );
    secondaryequipment = equipment_mp::function_fdc4a655fbde0dec( self.micontext.miconfig.var_7fad5fc3b9a96735 );
    return { #var_6a168be0e4faa066:self.micontext.miconfig.var_c547153026652d56, #secondaryequipment:secondaryequipment, #var_c547153026652d56:self.micontext.miconfig.var_c547153026652d56, #primaryequipment:primaryequipment };
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0x84a90646, Offset: 0x2d3e
// Size: 0x6a
function getweaponinfo( ismeleeonly )
{
    bundleweapon = ismeleeonly ? utility::get_scripted_weapon_name( #"mutant_injection_nocannon" ) : utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
    return { #primaryweapon:self.micontext.miconfig.var_713f9d5e379bc549 ?? bundleweapon };
}

// Namespace mutant_injection_shared
// Params 0
// Checksum 0xd162a1db, Offset: 0x2db1
// Size: 0x103
function function_eb473d6ac5f83a82()
{
    return { #suit:level.var_75c7b100ae39fcf1 ?? self.micontext.miconfig.suit ?? self.micontext.bundlesuit ?? "t10_mstr_mangler_suit_mp", #skin:self.micontext.miconfig.operatorskin ?? self.micontext.bundleskin ?? %"t10_mstr_mangler_skin", #operator:self.micontext.miconfig.operator ?? self.micontext.bundleoperator ?? %"t10_mstr_mangler_skin", #var_69224c24ef535a12:self.micontext.var_69224c24ef535a12 ?? 0 };
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xdf4055fc, Offset: 0x2ebd
// Size: 0x52
function private function_8c25aa430f650eb5( params )
{
    if ( params.isactive )
    {
        self.game_extrainfo |= 67108864;
        return;
    }
    
    self.game_extrainfo &= ~int( 67108864 );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xa4d13595, Offset: 0x2f17
// Size: 0x127
function private completetransformation()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "used_" + "zm_minj", self );
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"completetransformation" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"completetransformation" ) ]]();
    }
    
    thread function_153748775f30c5a5();
    thread function_b65d74d942428161();
    thread function_11e58cee78c4514d();
    thread function_5a74d9bfe1b88fe3();
    thread function_8046a37b225cdb6b();
    thread function_61b9548d6f1916f9();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"mutant_injection" ][ #"hash_2f590838fdf8226f" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"jumpwatcher" ) )
    {
        self thread [[ utility::getsharedfunc( #"mutant_injection", #"jumpwatcher" ) ]]();
    }
    
    thread function_598605774ad9dfaf();
    init_mutant_injection_analytics();
    thread function_f9b44ab40cbf5ef9();
    self notify( #"mutantinjection_start" );
}

// Namespace mutant_injection_shared
// Params 2
// Checksum 0xadcb49bf, Offset: 0x3046
// Size: 0x7bc
function function_2b562b60a3d69e6f( istimeout = 0, skipanimation = 0 )
{
    assert( self.ismutantinjection );
    assert( isdefined( self.micontext ) );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.ismutantinjection = 0;
    self notify( #"mutantinjection_end" );
    self setclientomnvar( "is_zm_minj", 1 );
    killstreak_utility::function_d546aaa588f088c3( function_3033707e7b408423(), "off" );
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"removemutantinjection" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"removemutantinjection" ) ]]( istimeout, skipanimation );
    }
    
    restore_fov();
    self setclientomnvar( "is_zm_minj_sprint", 0 );
    utility::function_32b24db3127bff40( "sprint_vfx", "off" );
    self setclientomnvar( "ui_zm_mutant_injection_underwater", 0 );
    val::reset_all( "mutant_injection_in_water" );
    val::set( "mutant_injection_transformation", "fire", 0 );
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    
    if ( miconfig.infiniteammo )
    {
        weapon::stopinfiniteammothread();
    }
    
    val::set( "transformation_ignore_me", "ignoreme", 1 );
    utility::function_32b24db3127bff40( "zm_minj_ambient_vfx", "off" );
    
    if ( self.var_bded870341f32d15 || self.var_d6a4e00f6028b307 )
    {
        if ( !self.micontext.miconfig.disablerefund )
        {
            if ( !isdefined( self.mutant_injection_start_time ) || gettime() - self.mutant_injection_start_time < 10000 )
            {
                namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "zm_minj", "other", undefined, undefined, undefined, 1 );
            }
        }
    }
    
    if ( !self.var_d6a4e00f6028b307 && !skipanimation )
    {
        if ( self.var_e8a960b35e9155d5 )
        {
            utility::function_32b24db3127bff40( "deep_water_transform_cam", "vfx_on" );
            wait 0.1;
            self.var_e8a960b35e9155d5 = undefined;
        }
        else
        {
            utility::function_32b24db3127bff40( "zm_minj_transform_out", "vfx_on" );
            self freezecontrols( 1 );
            self playanimscriptsceneevent( "scripted_scene", "t10_mstr_mangler_3p_transformation_out", 0 );
            transform_time = getanimlength( %t10_mstr_mangler_3p_transformation_out );
            msg = utility::waittill_any_timeout( transform_time, "mutant_injecton_instant_exit" );
            self freezecontrols( 0 );
        }
    }
    else if ( self.micontext.miconfig.var_573b7ef5186ac8c6 )
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_out", "off" );
        waitframe();
        utility::function_32b24db3127bff40( "zm_minj_transform_out", "vfx_quick_on" );
        waitframe();
    }
    
    thread function_e386548b0ab21fb9( 3, "transformation_ignore_me" );
    val::reset_all( "mutant_injection_transformation" );
    val::reset_all( "mutant_injection_transform_ignore_collision" );
    killstreak_utility::function_c463ddccb4054cc2( self );
    
    if ( isalive( self ) && !self.inlaststand )
    {
        weaponinfo = getweaponinfo();
        
        if ( isdefined( weaponinfo.primaryweapon ) )
        {
            inventory_utility::_takeweapon( weaponinfo.primaryweapon );
        }
        
        equipmentinfo = function_a12fa9194f151302();
        
        if ( isdefined( equipmentinfo.primaryequipment ) )
        {
            equipment_mp::takeequipment( "primary" );
        }
        
        if ( isdefined( equipmentinfo.secondaryequipment ) )
        {
            equipment_mp::takeequipment( "secondary" );
        }
        
        if ( isdefined( micontext.weapstructs ) )
        {
            foreach ( weapstruct in micontext.weapstructs )
            {
                var_5cf54f29417bb032 = 0;
                
                if ( micontext.lastweaponobj == weapstruct.weaponobj )
                {
                    var_5cf54f29417bb032 = 1;
                }
                
                inventory_utility::_giveweapon( weapstruct.weaponobj, undefined, undefined, 1, weapstruct.var_31b84291bf81176d );
                self setweaponammoclip( weapstruct.weaponobj, weapstruct.clipammo );
                self setweaponammostock( weapstruct.weaponobj, weapstruct.stockammo );
                item_weapon::function_d6a514964e1e7f2c( weapstruct.weaponobj );
                altweapon = weapstruct.weaponobj getaltweapon();
                
                if ( !isnullweapon( altweapon ) )
                {
                    self setweaponammoclip( altweapon, weapstruct.altclipammo );
                    self setweaponammostock( altweapon, weapstruct.altstockammo );
                }
                
                if ( weapstruct.ismeleeoverrideweapon )
                {
                    self assignweaponmeleeslot( weapstruct.weaponobj );
                }
                
                if ( var_5cf54f29417bb032 )
                {
                    lastweaponobj = weapon_utility::restoreweaponstates( weapstruct.weaponobj );
                    inventory_utility::_switchtoweaponimmediate( lastweaponobj );
                }
                
                weapon::fixupplayerweapons( self, weapstruct.weaponobj );
            }
        }
        
        if ( self.var_61e46de61996b0b )
        {
            self.var_61e46de61996b0b = undefined;
            
            if ( utility::issharedfuncdefined( #"mutant_injection", #"give_ammo" ) )
            {
                self [[ utility::getsharedfunc( #"mutant_injection", #"give_ammo" ) ]]();
            }
        }
        
        foreach ( perk, unused in miconfig.perks )
        {
            perk::removeperk( perk );
        }
    }
    
    if ( !micontext.var_5828aa3111d7fa78 )
    {
        self setcamerathirdperson( 0 );
    }
    
    if ( isdefined( miconfig.pre_allows ) )
    {
        function_cfe6a5fed7778f67( miconfig.pre_allows, 1 );
    }
    
    function_cfe6a5fed7778f67( miconfig.allows, 1 );
    
    if ( miconfig.var_60e112d2e106b00a )
    {
        self function_7d73d6786e51ae1f();
    }
    
    function_fc3bb3b83b7479b6( micontext.var_a9c6c85962429e1c, micontext.var_716d2096928c8cab, micontext.var_ed533e1eca97ee );
    self.get_cannon_fire_params = undefined;
    function_20a634c3d7f708bf( self, 0 );
    
    if ( !self.var_d6a4e00f6028b307 && !skipanimation )
    {
        utility::function_32b24db3127bff40( "zm_minj_transform_end", "vfx_on" );
    }
    
    function_a684aad5b33bef00();
    function_55199c384a3f84f3();
    mtx_weapon::function_7b8972f2b1aa0a67();
    function_e479e3b1052bdd4a();
    self setclientomnvar( "is_zm_minj", 0 );
    val::reset_all( "mutant_injection_hide_perks" );
    self.mutantinjectiontransformed = undefined;
    function_251f818850fdb794( self );
    callback::callback( #"hash_d558db2dac47d5f7", { #istimeout:istimeout } );
    val::reset_all( "mutant_injection_disallow_grab" );
    
    if ( isdefined( level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ] ) )
    {
        streakinfo = self.streakinfo;
        self.streakinfo = undefined;
        self [[ level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ] ]]( streakinfo );
    }
    
    self.micontext = undefined;
    self notify( #"returned_to_human" );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xe6a2d6aa, Offset: 0x380a
// Size: 0x605
function private getconfig()
{
    if ( utility::issharedfuncdefined( #"mutant_injection", #"getconfig" ) )
    {
        config = [[ utility::getsharedfunc( #"mutant_injection", #"getconfig" ) ]]();
    }
    
    if ( !isdefined( config ) )
    {
        config = {};
    }
    
    config.infiniteammo = 1;
    config.var_60e112d2e106b00a = 1;
    config.infiniteammoupdaterate = 0.5;
    
    if ( !isdefined( config.pre_allows ) )
    {
        config.pre_allows = [];
    }
    
    if ( !isdefined( config.pre_allows[ "damage" ] ) )
    {
        config.pre_allows[ "damage" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "killstreaks" ] ) )
    {
        config.pre_allows[ "killstreaks" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "crouch" ] ) )
    {
        config.pre_allows[ "crouch" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "prone" ] ) )
    {
        config.pre_allows[ "prone" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "swimming_underwater" ] ) )
    {
        config.pre_allows[ "swimming_underwater" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "equipment_primary" ] ) )
    {
        config.pre_allows[ "equipment_primary" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "equipment_secondary" ] ) )
    {
        config.pre_allows[ "equipment_secondary" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "supers" ] ) )
    {
        config.pre_allows[ "supers" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "weapon_pickup" ] ) )
    {
        config.pre_allows[ "weapon_pickup" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "offhand_weapons" ] ) )
    {
        config.pre_allows[ "offhand_weapons" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "offhand_throwback" ] ) )
    {
        config.pre_allows[ "offhand_throwback" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "weapon_switch" ] ) )
    {
        config.pre_allows[ "weapon_switch" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "mantle" ] ) )
    {
        config.pre_allows[ "mantle" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "ascender_use" ] ) )
    {
        config.pre_allows[ "ascender_use" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "crate_use" ] ) )
    {
        config.pre_allows[ "crate_use" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "interactions" ] ) )
    {
        config.pre_allows[ "interactions" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "dtp" ] ) )
    {
        config.pre_allows[ "dtp" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "ladder" ] ) )
    {
        config.pre_allows[ "ladder" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "vehicle_use" ] ) )
    {
        config.pre_allows[ "vehicle_use" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "disallow_loot_but_auto_loot" ] ) )
    {
        config.pre_allows[ "disallow_loot_but_auto_loot" ] = 1;
    }
    
    if ( !isdefined( config.pre_allows[ "allow_toggle_third_person" ] ) )
    {
        config.pre_allows[ "allow_toggle_third_person" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "allow_scripted_bgb_use" ] ) )
    {
        config.pre_allows[ "allow_scripted_bgb_use" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "allow_revive_teammate" ] ) )
    {
        config.pre_allows[ "allow_revive_teammate" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "armor" ] ) )
    {
        config.pre_allows[ "armor" ] = 0;
    }
    
    if ( !isdefined( config.pre_allows[ "allow_emote" ] ) )
    {
        config.pre_allows[ "allow_emote" ] = 0;
    }
    
    if ( parachute::isparachutegametype() )
    {
        if ( !isdefined( config.pre_allows[ "base_jumping" ] ) )
        {
            config.pre_allows[ "base_jumping" ] = 0;
        }
    }
    
    if ( !isdefined( config.allows ) )
    {
        config.allows = [];
    }
    
    if ( !isdefined( config.allows[ "flashed" ] ) )
    {
        config.allows[ "flashed" ] = 0;
    }
    
    if ( !isdefined( config.allows[ "stunned" ] ) )
    {
        config.allows[ "stunned" ] = 0;
    }
    
    if ( !isdefined( config.allows[ "shellshock" ] ) )
    {
        config.allows[ "shellshock" ] = 0;
    }
    
    if ( !isdefined( config.allows[ "slide" ] ) )
    {
        config.allows[ "slide" ] = 0;
    }
    
    if ( !isdefined( config.allows[ "execution_attack" ] ) )
    {
        config.allows[ "execution_attack" ] = 1;
    }
    
    if ( !isdefined( config.allows[ "execution_victim" ] ) )
    {
        config.allows[ "execution_victim" ] = 0;
    }
    
    if ( !isdefined( config.allows[ "stance_change" ] ) )
    {
        config.allows[ "stance_change" ] = 0;
    }
    
    if ( !isdefined( config.perks ) )
    {
        config.perks = [];
    }
    
    if ( !isdefined( config.perks[ "specialty_sharp_focus" ] ) )
    {
        config.perks[ "specialty_sharp_focus" ] = 1;
    }
    
    return config;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xfb45d3de, Offset: 0x3e18
// Size: 0x5b
function private function_3033707e7b408423()
{
    if ( self.var_9d3e2d06ce7e8383 )
    {
        return self.var_9d3e2d06ce7e8383;
    }
    
    if ( self.micontext.streakinfo.streakname )
    {
        return self.micontext.streakinfo.streakname;
    }
    
    return "zm_minj";
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x7ab4d263, Offset: 0x3e7c
// Size: 0xb3
function private function_a6884e9623901d81( stanceoverride )
{
    curstance = self getstance();
    
    if ( isdefined( stanceoverride ) )
    {
        curstance = stanceoverride;
    }
    
    switch ( curstance )
    {
        case #"hash_3fed0cbd303639eb":
            top = self.origin + ( 0, 0, 48 );
            break;
        case #"hash_d91940431ed7c605":
            top = self.origin + ( 0, 0, 20 );
            break;
        default:
            top = self.origin + ( 0, 0, 70 );
            break;
    }
    
    return top;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xd23410df, Offset: 0x3f38
// Size: 0x1a5
function private function_7554b9424397983( miconfig )
{
    validstance = undefined;
    curstance = self getstance();
    
    if ( curstance != "stand" )
    {
        var_657e7ffe33b8d4f1 = !isdefined( miconfig.pre_allows[ "crouch" ] ) || miconfig.pre_allows[ "crouch" ];
        var_b64b12f21408f6b3 = !isdefined( miconfig.pre_allows[ "prone" ] ) || miconfig.pre_allows[ "prone" ];
        
        if ( !var_657e7ffe33b8d4f1 && !var_b64b12f21408f6b3 )
        {
            canstand = function_3acd94f25a167f42( "stand", miconfig.var_48388e1c9593fba0 );
            validstance = canstand ? "stand" : validstance;
        }
        else if ( curstance == "crouch" )
        {
            if ( !var_657e7ffe33b8d4f1 )
            {
                canstand = function_3acd94f25a167f42( "stand", miconfig.var_48388e1c9593fba0 );
                validstance = canstand ? "stand" : validstance;
            }
            else
            {
                validstance = "crouch";
            }
        }
        else if ( curstance == "prone" )
        {
            if ( !var_b64b12f21408f6b3 )
            {
                if ( var_657e7ffe33b8d4f1 )
                {
                    cancrouch = function_3acd94f25a167f42( "crouch", miconfig.var_48388e1c9593fba0 );
                    validstance = cancrouch ? "crouch" : validstance;
                }
                else
                {
                    canstand = function_3acd94f25a167f42( "stand", miconfig.var_48388e1c9593fba0 );
                    validstance = canstand ? "stand" : validstance;
                }
            }
            else
            {
                validstance = "prone";
            }
        }
    }
    else
    {
        validstance = curstance;
    }
    
    return validstance;
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0xa488df10, Offset: 0x40e6
// Size: 0xbf, Type: bool
function private function_3acd94f25a167f42( stance, radius = 15 )
{
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1 );
    start_pos = self.origin + ( 0, 0, 10 + radius );
    top = function_a6884e9623901d81( stance );
    end_pos = top - ( 0, 0, radius );
    trace = trace::sphere_trace( start_pos, end_pos, radius, [ self ], contentoverride, 1 );
    
    if ( trace[ "fraction" ] < 1 && !isdefined( trace[ "entity" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0x80654de4, Offset: 0x41ae
// Size: 0xf4
function private function_cfe6a5fed7778f67( allows, allowed )
{
    if ( !allowed )
    {
        foreach ( allow_name, used in allows )
        {
            allow_name = tolower( allow_name );
            val::set( "mutantinjection", allow_name, used );
        }
        
        if ( !level.disablemount )
        {
            val::set( "mutantinjection_mount", "mount_top", 0 );
            val::set( "mutantinjection_mount", "mount_side", 0 );
        }
        
        return;
    }
    
    val::reset_all( "mutantinjection" );
    
    if ( !level.disablemount )
    {
        val::reset_all( "mutantinjection_mount" );
    }
}

// Namespace mutant_injection_shared
// Params 4, eflags: 0x4
// Checksum 0xedd37838, Offset: 0x42aa
// Size: 0x2eb
function private function_fc3bb3b83b7479b6( operator, skin, suitoverride, var_69224c24ef535a12 )
{
    self function_16332a7775f10aa9();
    self.operatorcustomization.skinref = skin;
    body = operator::function_4e6b11f7340acc24( skin );
    self.operatorcustomization.suit = suitoverride ?? utility::function_f825237e0eda5adf();
    gender = operator::getoperatorgender( operator );
    clothtype = operator::function_b1788ccf1b3c0ae9( skin );
    geartype = operator::function_d633420b529828e8( skin );
    self setoperatorcustomization( operator, skin );
    bodymodelname = var_69224c24ef535a12 ? body : self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    bodymodelname = teams::function_7c810013ad96976( bodymodelname, headmodelname );
    player::_setsuit( self.operatorcustomization.suit );
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    self setmodel( bodymodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
    
    self notify( #"set_operator" );
    
    if ( gender == "1" )
    {
        self setclientgender( "female" );
        self.operatorcustomization.gender = "female";
    }
    else
    {
        self setclientgender( "" );
        self.operatorcustomization.gender = "male";
    }
    
    if ( !isdefined( clothtype ) || clothtype == "" )
    {
        clothtype = "vestlight";
    }
    
    if ( isdefined( self.operatorcustomization.clothtype ) && self.operatorcustomization.clothtype != clothtype )
    {
        self.operatorcustomization.clothtype = clothtype;
        self setclothtype( getxhash( clothtype ) );
    }
    
    if ( !isdefined( geartype ) || geartype == "" )
    {
        geartype = "millghtgr";
    }
    
    if ( isdefined( self.operatorcustomization.geartype ) && self.operatorcustomization.geartype != geartype )
    {
        self.operatorcustomization.geartype = geartype;
        self setgeartype( getxhash( geartype ) );
    }
    
    self.operatorcustomization.reactiveoperator = operator::getreactiveoperator( skin );
    
    if ( isdefined( self.operatorcustomization.reactiveoperator ) && self.operatorcustomization.reactiveoperator != "" )
    {
        self function_184d7ec010cfaa92( self.operatorcustomization.reactiveoperator );
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x87f63c7a, Offset: 0x459d
// Size: 0xb3
function private get_cannon_fire_params( target_pos )
{
    const_forward_offset = 25;
    const_right_offset = 25;
    const_up_offset = 10;
    angles = self getplayerangles();
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    start = self geteye() + forward * const_forward_offset + right * const_right_offset + ( 0, 0, const_up_offset );
    var_ee6433c31961982d = vectornormalize( target_pos - start );
    
    if ( vectordot( forward, var_ee6433c31961982d ) < 0.7071 )
    {
        var_ee6433c31961982d = forward;
    }
    
    return [ start, var_ee6433c31961982d ];
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x44c61627, Offset: 0x4659
// Size: 0x3b0
function private function_b65d74d942428161()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    
    while ( true )
    {
        self waittill( #"melee_swipe_start" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        melee_attack_variant = clampint( self function_29ce8f3d1f41fe0f(), 0, 2 );
        
        if ( melee_attack_variant != 1 )
        {
            utility::function_32b24db3127bff40( "meleeSwipeVfx", "melee_swipe" );
        }
        
        velocity = self getvelocity();
        speed = length( velocity );
        
        if ( speed < 1 )
        {
            var_2954fd3cae940eb8 = [ %t10_mstr_mangler_stand_base_idle_melee_01, %t10_mstr_mangler_stand_base_idle_melee_02, %t10_mstr_mangler_stand_base_idle_melee_03 ];
        }
        
        if ( speed <= 40 )
        {
            var_2954fd3cae940eb8 = [ %t10_mstr_mangler_walk_08_melee_01, %t10_mstr_mangler_walk_08_melee_02, %t10_mstr_mangler_walk_08_melee_03 ];
        }
        else
        {
            var_2954fd3cae940eb8 = [ %t10_mstr_mangler_run_8_melee_01, %t10_mstr_mangler_run_8_melee_02, %t10_mstr_mangler_run_8_melee_03 ];
        }
        
        melee_anim_alias = var_2954fd3cae940eb8[ melee_attack_variant ];
        hit_start_time = 0.05;
        wait hit_start_time;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        hit_end_time = getanimlength( melee_anim_alias ) * 0.7;
        hit_end_time_ms = gettime() + hit_end_time * 1000;
        hit_targets = [];
        
        while ( gettime() < hit_end_time_ms )
        {
            if ( self isinexecutionattack() )
            {
                break;
            }
            
            view_pos = self geteye();
            v_forward = anglestoforward( self.angles );
            start_pos = self.origin + v_forward * -10;
            var_4c6bd9e09dac787c = view_pos[ 2 ] - self.origin[ 2 ];
            var_ce15d835a4e62710 = 164;
            potential_target_dist = sqrt( var_4c6bd9e09dac787c * var_4c6bd9e09dac787c + var_ce15d835a4e62710 * var_ce15d835a4e62710 );
            potential_targets = getnearbytargets( potential_target_dist );
            var_f6b638171a47759a = 1;
            
            foreach ( target in potential_targets )
            {
                if ( !isalive( target ) )
                {
                    continue;
                }
                
                if ( !can_melee_target( target, view_pos, v_forward, start_pos, var_4c6bd9e09dac787c ) )
                {
                    continue;
                }
                
                hit_targets = function_5713d46873b29625( hit_targets );
                
                if ( arraycontains( hit_targets, target ) )
                {
                    continue;
                }
                
                hit_targets[ hit_targets.size ] = target;
                var_82327358fb237f91 = randomfloatrange( -3, 3 );
                var_82327258fb237d5e = randomfloatrange( -3, 3 );
                n_random_z = randomfloatrange( 5, 10 );
                var_70f94cee22fb8c5c = vectornormalize( target.origin - self.origin + ( var_82327358fb237f91, var_82327258fb237d5e, n_random_z ) );
                is_melee_kill = do_melee_hit( target, var_70f94cee22fb8c5c, 1 );
                
                if ( is_melee_kill && isdefined( self.mutant_injection_analytics ) )
                {
                    self.mutant_injection_analytics.melee_kills++;
                }
                
                if ( var_f6b638171a47759a && is_melee_kill )
                {
                    if ( melee_attack_variant != 1 )
                    {
                        utility::function_32b24db3127bff40( "meleeVfx", "melee_kill" );
                        var_f6b638171a47759a = 0;
                    }
                }
            }
            
            function_31e4db59f180f478();
            waitframe();
            
            if ( !isdefined( self ) )
            {
                return;
            }
        }
    }
}

// Namespace mutant_injection_shared
// Params 5, eflags: 0x4
// Checksum 0x21a9a9db, Offset: 0x4a11
// Size: 0x10f, Type: bool
function private can_melee_target( target, view_pos, v_forward, start_pos, height_tolerance )
{
    if ( !function_a3f71ecb6eb404cc( target ) )
    {
        return false;
    }
    
    target_pos = target getcentroid();
    
    if ( view_pos[ 2 ] - target_pos[ 2 ] > height_tolerance )
    {
        /#
            if ( getdvarint( @"hash_76a471980b295cbc", 0 ) == 1 )
            {
                line( view_pos, target_pos, ( 255, 0, 0 ), 1, 1, 200 );
            }
        #/
        
        return false;
    }
    
    [ bound_radius ] = target getboundshalfsize();
    melee_range_tolerance = 64 + bound_radius;
    dist_sq = distance2dsquared( view_pos, target_pos );
    
    if ( dist_sq > melee_range_tolerance * melee_range_tolerance )
    {
        /#
            if ( getdvarint( @"hash_76a471980b295cbc", 0 ) == 1 )
            {
                line( view_pos, target_pos, ( 255, 0, 0 ), 1, 1, 200 );
            }
        #/
        
        return false;
    }
    
    return true;
}

// Namespace mutant_injection_shared
// Params 5, eflags: 0x4
// Checksum 0x17028c0e, Offset: 0x4b29
// Size: 0x1b4
function private do_melee_hit( var_5ddea964f429e3cf, var_da20088ae67ad678, dismember, var_d08f7f9485419066 = 3, mod )
{
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_9b359784e8530f5" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"hash_9b359784e8530f5" ) ]]( var_5ddea964f429e3cf, var_da20088ae67ad678, dismember, var_d08f7f9485419066 );
    }
    
    if ( var_5ddea964f429e3cf.aicategory == "normal" )
    {
        if ( var_d08f7f9485419066 >= 1 )
        {
            var_5ddea964f429e3cf val::set( "mutant_injection_insta_kill", "kill_on_damage", 1 );
        }
    }
    
    n_damage = function_c059fcb8b93ffa03( var_5ddea964f429e3cf, var_d08f7f9485419066 );
    weaponobj = self getcurrentweapon();
    
    if ( !weaponobj )
    {
        weaponobj = self.micontext.weaponobj;
        
        if ( !weaponobj )
        {
            weapon_name = self.micontext.weapon ?? utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
            weaponobj = makeweapon( weapon_name );
        }
    }
    
    if ( !isdefined( mod ) )
    {
        mod = "MOD_MELEE";
    }
    
    var_5ddea964f429e3cf.mutant_injection_damage = 1;
    idflags = 65536;
    idflags |= 536870912;
    idflags |= 1073741824;
    var_5ddea964f429e3cf dodamage( n_damage, var_5ddea964f429e3cf.origin + ( 0, 0, 30 ), self, self, mod, weaponobj, "torso_upper", undefined, idflags );
    var_5ddea964f429e3cf.mutant_injection_damage = 0;
    is_melee_kill = var_5ddea964f429e3cf.health == 0;
    return is_melee_kill;
}

// Namespace mutant_injection_shared
// Params 2
// Checksum 0xd61ac1cb, Offset: 0x4ce6
// Size: 0x5f
function function_c059fcb8b93ffa03( target, damagescale )
{
    n_damage = 0;
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_d2f6004b101d75ea" ) )
    {
        n_damage = self [[ utility::getsharedfunc( #"mutant_injection", #"hash_d2f6004b101d75ea" ) ]]( target, damagescale );
    }
    
    return n_damage;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x4586ef71, Offset: 0x4d4e
// Size: 0x216
function private function_31e4db59f180f478()
{
    forward = anglestoforward( self.angles );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1 );
    radius = 30;
    height = 80;
    capsule_height = height - 17;
    startpos = self.origin + ( 0, 0, 17 );
    delta = forward * 25;
    endpos = startpos + delta;
    trace = trace::capsule_trace( startpos, endpos, radius, capsule_height, undefined, [ self ], contents, 1 );
    
    if ( trace[ "fraction" ] < 1 )
    {
        if ( isdefined( trace[ "entity" ] ) )
        {
            hitent = trace[ "entity" ];
            
            if ( isdefined( level.var_74ce31936c52d68f ) )
            {
                foreach ( struct in level.var_74ce31936c52d68f )
                {
                    if ( struct.clip == hitent || struct.mdl == hitent )
                    {
                        if ( isdefined( struct.mdl ) && !struct.damaged )
                        {
                            struct.damaged = 1;
                            hitent.var_ee0ca1e0846829f = 1;
                            hitpos = trace[ "position" ] ?? startpos;
                            struct.mdl dodamage( 1000, hitpos, self, self, "MOD_IMPACT" );
                            level.var_74ce31936c52d68f = arrayremove( level.var_74ce31936c52d68f, struct );
                            level thread function_5b7d0a03eb846e2c( self );
                        }
                        
                        break;
                    }
                }
            }
        }
    }
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0xdd8d454f, Offset: 0x4f6c
// Size: 0x55
function getnearbytargets( radius )
{
    potentialtargets = [];
    
    if ( utility::issharedfuncdefined( #"mutant_injection", #"getnearbytargets" ) )
    {
        potentialtargets = self [[ utility::getsharedfunc( #"mutant_injection", #"getnearbytargets" ) ]]( radius );
    }
    
    return potentialtargets;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xb1e5dfb8, Offset: 0x4fca
// Size: 0x47, Type: bool
function private function_a3f71ecb6eb404cc( target )
{
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_63554db87d064a6b" ) )
    {
        return istrue( self [[ utility::getsharedfunc( #"mutant_injection", #"hash_63554db87d064a6b" ) ]]( target ) );
    }
    
    return false;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xd0fe7e29, Offset: 0x501a
// Size: 0x45
function private function_5da7e225cbfb13ae( target )
{
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_737633f5a317c5cf" ) )
    {
        self [[ utility::getsharedfunc( #"mutant_injection", #"hash_737633f5a317c5cf" ) ]]( target );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x45076fd5, Offset: 0x5068
// Size: 0x37a
function private function_11e58cee78c4514d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    bundle = level.streakglobals.streakbundles[ function_3033707e7b408423() ];
    hit_targets = [];
    sprint_start_time = undefined;
    self.var_6a4bb79e1d89e380 = 0;
    
    while ( true )
    {
        speed = length( self getvelocity() );
        
        if ( !self isonground() || !self issprinting() || speed < 190 )
        {
            self.var_6a4bb79e1d89e380 = 0;
            var_48ee71281f56f926 = undefined;
            sprint_start_time = undefined;
            waitframe();
            continue;
        }
        
        if ( !isdefined( sprint_start_time ) )
        {
            sprint_start_time = gettime();
        }
        
        if ( gettime() - sprint_start_time <= 300 )
        {
            self.var_6a4bb79e1d89e380 = 0;
            var_48ee71281f56f926 = undefined;
            waitframe();
            continue;
        }
        
        function_31e4db59f180f478();
        function_19dbea8a701ed9cf();
        
        if ( !self.var_6a4bb79e1d89e380 )
        {
            hit_targets = [];
            self.var_6a4bb79e1d89e380 = 1;
            var_48ee71281f56f926 = gettime();
        }
        
        if ( isdefined( var_48ee71281f56f926 ) && isdefined( self.mutant_injection_end_time ) )
        {
            var_40ea21c9d03f10b8 = ( bundle.mutantinjectiondata.var_2589d19962e454c8 ?? 0 ) * 0.001;
            timer_reduce = int( ( gettime() - var_48ee71281f56f926 ) * var_40ea21c9d03f10b8 );
            function_4860a77f84a3ed4d( timer_reduce * -1 );
            var_48ee71281f56f926 = gettime();
        }
        
        currentpos = self.origin;
        forward = anglestoforward( self.angles );
        right = anglestoright( self.angles );
        potential_targets = getnearbytargets( 80 );
        var_a5d700a05e77292d = 0;
        
        foreach ( target in potential_targets )
        {
            if ( !isalive( target ) )
            {
                continue;
            }
            
            if ( !function_a3f71ecb6eb404cc( target ) )
            {
                continue;
            }
            
            var_ee6433c31961982d = vectornormalize( target.origin - currentpos ) ?? ( 0, 0, 0 );
            dot = vectordot( forward, var_ee6433c31961982d );
            
            if ( dot <= 0 )
            {
                continue;
            }
            
            if ( arraycontains( hit_targets, target ) )
            {
                continue;
            }
            
            hit_targets[ hit_targets.size ] = target;
            var_d08f7f9485419066 = 0.51;
            
            if ( dot > cos( 15 ) )
            {
                var_d08f7f9485419066 = 1;
            }
            
            do_melee_hit( target, var_ee6433c31961982d, 0, var_d08f7f9485419066, "MOD_IMPACT" );
            rightstr = vectordot( right, var_ee6433c31961982d ) > 0 ? "right" : "left";
            charge_hit_part = "charge_hit_" + rightstr;
            utility::function_32b24db3127bff40( charge_hit_part, "attack_hit" );
            var_a5d700a05e77292d = 1;
            
            if ( isalive( target ) )
            {
                function_5da7e225cbfb13ae( target );
                continue;
            }
            
            if ( isdefined( self.mutant_injection_analytics ) )
            {
                self.mutant_injection_analytics.sprint_kills++;
            }
        }
        
        if ( var_a5d700a05e77292d )
        {
            level thread function_5b7d0a03eb846e2c( self );
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 2
// Checksum 0xf3154bef, Offset: 0x53ea
// Size: 0x6e
function function_4bce4409afd4c4c6( clip, model )
{
    if ( !isdefined( level.var_74ce31936c52d68f ) )
    {
        level.var_74ce31936c52d68f = [];
    }
    
    struct = spawnstruct();
    struct.mdl = model;
    struct.clip = clip;
    level.var_74ce31936c52d68f[ level.var_74ce31936c52d68f.size ] = struct;
}

// Namespace mutant_injection_shared
// Params 3
// Checksum 0xdb59180e, Offset: 0x5460
// Size: 0x85
function function_7b49c94999eac823( scriptable, check_should_die, var_3695bbaa5fc2bea )
{
    if ( !isdefined( level.var_873e14114c1fde81 ) )
    {
        level.var_873e14114c1fde81 = [];
    }
    
    struct = spawnstruct();
    struct.scriptable = scriptable;
    struct.check_should_die = check_should_die;
    struct.var_3695bbaa5fc2bea = var_3695bbaa5fc2bea;
    level.var_873e14114c1fde81[ level.var_873e14114c1fde81.size ] = struct;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x934ede9, Offset: 0x54ed
// Size: 0x119
function private function_19dbea8a701ed9cf()
{
    if ( !isdefined( level.var_873e14114c1fde81 ) )
    {
        return;
    }
    
    level.var_873e14114c1fde81 = function_5713d46873b29625( level.var_873e14114c1fde81 );
    
    foreach ( index, sbl in level.var_873e14114c1fde81 )
    {
        scriptable = sbl.scriptable;
        
        if ( !isdefined( scriptable ) )
        {
            level.var_873e14114c1fde81[ index ] = undefined;
            continue;
        }
        
        if ( sbl.check_should_die )
        {
            should_die = scriptable [[ sbl.check_should_die ]]( self );
            
            if ( should_die )
            {
                if ( sbl.var_3695bbaa5fc2bea )
                {
                    scriptable [[ sbl.var_3695bbaa5fc2bea ]]();
                    level.var_873e14114c1fde81[ index ] = undefined;
                }
            }
        }
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x37c3c0b5, Offset: 0x560e
// Size: 0x7c
function private function_5b7d0a03eb846e2c( player )
{
    if ( !isdefined( player.var_1242add814c91d87 ) || gettime() > player.var_1242add814c91d87 )
    {
        var_4fdac44e2c8cefd9 = 1;
        player.var_1242add814c91d87 = gettime() + var_4fdac44e2c8cefd9 * 1000;
        player playrumbleonentity( "damage_heavy" );
        player earthquakeforplayer( 0.3, var_4fdac44e2c8cefd9, player.origin, 100 );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xf3afc872, Offset: 0x5692
// Size: 0xd3
function private function_5a74d9bfe1b88fe3()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"mutantinjection_end" );
    wassprinting = 0;
    
    while ( true )
    {
        issprinting = self issprinting() && length( self getvelocity() ) >= 190;
        
        if ( issprinting && !wassprinting )
        {
            self setclientomnvar( "is_zm_minj_sprint", 1 );
            utility::function_32b24db3127bff40( "sprint_vfx", "vfx_on" );
            function_828d34ed38962d9e( 20, 0.5 );
            wassprinting = 1;
        }
        else if ( !issprinting && wassprinting )
        {
            self setclientomnvar( "is_zm_minj_sprint", 0 );
            utility::function_32b24db3127bff40( "sprint_vfx", "deactivate" );
            function_828d34ed38962d9e( undefined, 0.5 );
            wassprinting = 0;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0x63945a85, Offset: 0x576d
// Size: 0xa0
function private function_828d34ed38962d9e( fov_increase, fov_time )
{
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    if ( !isdefined( fov_increase ) )
    {
        fov_value = self.defaultbasefov;
    }
    else if ( self ispcplayer() )
    {
        fov_value = clamp( self.defaultbasefov + fov_increase, 30, 110 );
    }
    else
    {
        fov_value = clamp( self.defaultbasefov + fov_increase, 30, 170 );
    }
    
    if ( !isdefined( fov_time ) )
    {
        fov_time = 0;
    }
    
    self modifybasefov( fov_value, fov_time );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xb3a39000, Offset: 0x5815
// Size: 0x19
function private restore_fov()
{
    function_828d34ed38962d9e( undefined, 0.5 );
    self.defaultbasefov = undefined;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x84507fdf, Offset: 0x5836
// Size: 0x97, Type: bool
function private is_hit_water( var_7331c5c47ee98dfb )
{
    if ( utility::issharedfuncdefined( #"mutant_injection", #"hash_1fbae8a038b35137" ) )
    {
        can_ignore = utility::callsharedfunc( #"mutant_injection", #"hash_1fbae8a038b35137", self.origin );
        
        if ( can_ignore )
        {
            return false;
        }
    }
    
    if ( !isdefined( var_7331c5c47ee98dfb ) )
    {
        var_7331c5c47ee98dfb = 30;
    }
    
    hitwater = utility::ispointinwater( self.origin + ( 0, 0, var_7331c5c47ee98dfb ) );
    return hitwater || self isswimming() || self isswimunderwater();
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x77f32275, Offset: 0x58d6
// Size: 0x166
function private function_8046a37b225cdb6b()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"mutantinjection_end" );
    var_8b70c093b54025dc = 500;
    var_53c3329955b0781c = 0.2;
    var_76a52e1071a44a99 = 1000;
    var_feaeb51dafb9aea = 0;
    wasswimming = 0;
    starttime = gettime();
    
    while ( true )
    {
        hitshallows = is_hit_water( 0 );
        self setclientomnvar( "ui_zm_mutant_injection_underwater", hitshallows ? 1 : 0 );
        hitwater = is_hit_water();
        currenttime = gettime();
        
        if ( hitwater )
        {
            if ( !wasswimming )
            {
                val::set( "mutant_injection_in_water", "sprint", 0 );
                val::set( "mutant_injection_in_water", "move_speed_scale", var_53c3329955b0781c );
                var_feaeb51dafb9aea = currenttime;
                wasswimming = 1;
            }
            else if ( var_feaeb51dafb9aea + var_8b70c093b54025dc < currenttime )
            {
                val::reset_all( "mutant_injection_in_water" );
                
                if ( var_feaeb51dafb9aea - starttime <= var_76a52e1071a44a99 )
                {
                    namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "zm_minj", "other", undefined, undefined, undefined, 1 );
                }
                
                self.var_e8a960b35e9155d5 = 1;
                self notify( #"mutantinjection_end" );
                return;
            }
        }
        else if ( wasswimming )
        {
            val::reset_all( "mutant_injection_in_water" );
            var_feaeb51dafb9aea = 0;
            wasswimming = 0;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0x996b75b0, Offset: 0x5a44
// Size: 0x32
function private function_e386548b0ab21fb9( time, str_id )
{
    level endon( #"game_ended" );
    wait time;
    
    if ( isdefined( self ) )
    {
        val::reset_all( str_id );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x818b0668, Offset: 0x5a7e
// Size: 0x3e
function private function_61b9548d6f1916f9()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self waittill( #"zmb_max_ammo" );
    self.var_61e46de61996b0b = 1;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0xc
// Checksum 0x3077af79, Offset: 0x5ac4
// Size: 0x223
function private function_414ddb49e4cd2b25()
{
    self notify( #"hash_41c9373f6179622e" );
    self endon( #"hash_41c9373f6179622e" );
    level endon( #"game_ended" );
    level.mi_spectators = [];
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( player.sessionstate == "spectator" )
        {
            level.mi_spectators[ level.mi_spectators.size ] = player;
        }
    }
    
    level thread function_d72ef63f02f1a122( "mi_end_watch_spectator" );
    
    while ( true )
    {
        level.mi_spectators = function_5713d46873b29625( level.mi_spectators );
        
        foreach ( player in level.mi_spectators )
        {
            spectating_mutant_injection = 0;
            
            if ( player.sessionstate == "spectator" )
            {
                spectating_player = player getspectatingplayer();
                
                if ( isdefined( spectating_player ) && ( spectating_player.ismutantinjection || spectating_player.mutantinjectiontransformed ) )
                {
                    spectating_mutant_injection = 1;
                }
            }
            
            if ( spectating_mutant_injection )
            {
                if ( !player.spectating_mutant_injection )
                {
                    player forcethirdpersonwhenspectating();
                    player.spectating_mutant_injection = 1;
                }
                
                continue;
            }
            
            if ( player.spectating_mutant_injection )
            {
                player function_21de5aadd2856aa7();
                player.spectating_mutant_injection = undefined;
            }
        }
        
        if ( !function_59a4573e60f12459() )
        {
            level notify( #"mi_end_watch_spectator" );
            return;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xba47b953, Offset: 0x5cef
// Size: 0x85
function private function_d72ef63f02f1a122( end_notify )
{
    level endon( #"game_ended" );
    
    if ( isdefined( end_notify ) )
    {
        level endon( end_notify );
    }
    
    if ( !isdefined( level.mi_spectators ) )
    {
        level.mi_spectators = [];
    }
    
    while ( true )
    {
        level waittill( #"joined_spectators", player );
        
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        level.mi_spectators[ level.mi_spectators.size ] = player;
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xd7c0d3bb, Offset: 0x5d7c
// Size: 0x39
function private function_261c3b5b33fbad35( player )
{
    if ( !isdefined( level.var_8ec1fcfdeaa2fa21 ) )
    {
        level.var_8ec1fcfdeaa2fa21 = [];
    }
    
    level.var_8ec1fcfdeaa2fa21[ level.var_8ec1fcfdeaa2fa21.size ] = player;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x1f8d2b71, Offset: 0x5dbd
// Size: 0x3c
function private function_251f818850fdb794( player )
{
    assert( isdefined( level.var_8ec1fcfdeaa2fa21 ) );
    
    if ( isdefined( player ) )
    {
        level.var_8ec1fcfdeaa2fa21 = arrayremove( level.var_8ec1fcfdeaa2fa21, player );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x6d73887f, Offset: 0x5e01
// Size: 0x33, Type: bool
function private function_59a4573e60f12459()
{
    if ( isdefined( level.var_8ec1fcfdeaa2fa21 ) )
    {
        level.var_8ec1fcfdeaa2fa21 = function_5713d46873b29625( level.var_8ec1fcfdeaa2fa21 );
        return ( level.var_8ec1fcfdeaa2fa21.size > 0 );
    }
    
    return false;
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0xeed4458d, Offset: 0x5e3d
// Size: 0xfc
function function_6fa2b0b46d2abcf7( instant_exit )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.var_d6a4e00f6028b307 )
    {
        return;
    }
    
    if ( !instant_exit && self.var_bded870341f32d15 )
    {
        return;
    }
    
    if ( instant_exit )
    {
        self.var_d6a4e00f6028b307 = 1;
        self.var_bded870341f32d15 = undefined;
        self notify( #"mutant_injecton_instant_exit" );
    }
    else
    {
        self endon( #"mutant_injecton_instant_exit" );
        self.var_bded870341f32d15 = 1;
    }
    
    if ( self.ismutantinjection )
    {
        if ( instant_exit )
        {
            if ( self.mutantinjectiontransformed )
            {
                self notify( #"mutantinjection_end" );
            }
        }
        else
        {
            if ( !self.mutantinjectiontransformed )
            {
                self waittill( #"mutantinjection_start" );
                waitframe();
            }
            
            self notify( #"mutantinjection_end" );
        }
    }
    
    while ( self.mutantinjectiontransformed )
    {
        waitframe();
    }
    
    self.var_d6a4e00f6028b307 = undefined;
    self.var_bded870341f32d15 = undefined;
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0x3f58d97, Offset: 0x5f41
// Size: 0x154
function function_d2137a316b39f44a( instant_exit )
{
    level endon( #"game_ended" );
    disallow_mutant_injection();
    
    foreach ( player in level.players )
    {
        player thread function_6fa2b0b46d2abcf7( instant_exit );
    }
    
    while ( true )
    {
        has_mutant_injection = 0;
        
        foreach ( player in level.players )
        {
            if ( player.ismutantinjection || player.mutantinjectiontransformed )
            {
                has_mutant_injection = 1;
                break;
            }
        }
        
        if ( !has_mutant_injection )
        {
            level utility::delaythread( level.framedurationseconds, &allow_mutant_injection );
            return;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x3da970c3, Offset: 0x609d
// Size: 0xd
function private disallow_mutant_injection()
{
    level.disallow_mutant_injection = 1;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x776ba7c7, Offset: 0x60b2
// Size: 0xc
function private allow_mutant_injection()
{
    level.disallow_mutant_injection = undefined;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x19a242e5, Offset: 0x60c6
// Size: 0xc, Type: bool
function private function_620f88a1b583b28b()
{
    return istrue( level.disallow_mutant_injection );
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0xc
// Checksum 0x5c1c107f, Offset: 0x60db
// Size: 0x1f6
function private function_99c9f95e96f25130()
{
    self notify( #"hash_8f05f45cd7d31770" );
    self endon( #"hash_8f05f45cd7d31770" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_49974990b105362e = "outline_nodepth_zmplayer1";
    
    if ( self.sessionuimemberindex >= 0 )
    {
        var_49974990b105362e = "outline_nodepth_zmplayer" + self.sessionuimemberindex + 1;
    }
    
    hud_outline_players = [];
    
    while ( self.ismutantinjection )
    {
        allies = teams::getfriendlyplayers( self.team );
        
        foreach ( player in allies )
        {
            if ( player.visibilitymode_outline )
            {
                continue;
            }
            
            if ( isbot( player ) )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                hud_outline_players = disable_hudoutline( player, hud_outline_players );
                continue;
            }
            
            if ( self == player )
            {
                continue;
            }
            
            need_outline = 0;
            dist_sqrd = distancesquared( self.origin, player.origin );
            
            if ( dist_sqrd >= 10000 && dist_sqrd <= 1000000 )
            {
                eye_pos = player geteye();
                angles = player getplayerangles();
                
                if ( utility::within_fov( eye_pos, angles, self geteye(), cos( 90 ) ) )
                {
                    need_outline = 1;
                }
            }
            
            if ( need_outline )
            {
                hud_outline_players = enable_hudoutline( player, var_49974990b105362e, hud_outline_players );
                continue;
            }
            
            hud_outline_players = disable_hudoutline( player, hud_outline_players );
        }
        
        wait 0.4;
    }
    
    hud_outline_players = function_5713d46873b29625( hud_outline_players );
    
    if ( hud_outline_players.size )
    {
        self hudoutlinedisableforclients( hud_outline_players );
    }
}

// Namespace mutant_injection_shared
// Params 3, eflags: 0x4
// Checksum 0x3b8d4902, Offset: 0x62d9
// Size: 0x4b
function private enable_hudoutline( other_player, var_49974990b105362e, hud_outline_players )
{
    hud_outline_players = function_5713d46873b29625( hud_outline_players );
    
    if ( !hud_outline_players.size || !arraycontains( hud_outline_players, other_player ) )
    {
        self hudoutlineenableforclient( other_player, var_49974990b105362e );
        hud_outline_players[ hud_outline_players.size ] = other_player;
    }
    
    return hud_outline_players;
}

// Namespace mutant_injection_shared
// Params 2, eflags: 0x4
// Checksum 0x9be4a94a, Offset: 0x632d
// Size: 0x41
function private disable_hudoutline( other_player, hud_outline_players )
{
    hud_outline_players = function_5713d46873b29625( hud_outline_players );
    
    if ( hud_outline_players.size && arraycontains( hud_outline_players, other_player ) )
    {
        self hudoutlinedisableforclient( other_player );
        hud_outline_players = arrayremove( hud_outline_players, other_player );
    }
    
    return hud_outline_players;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x24f1f1e3, Offset: 0x6377
// Size: 0xb3
function private function_971088f00ed2508b()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    isjumping = 0;
    var_742a326b07556b9f = undefined;
    
    while ( true )
    {
        if ( self isjumping() || !self isonground() )
        {
            if ( !isjumping )
            {
                isjumping = 1;
                var_742a326b07556b9f = gettime();
            }
        }
        else if ( isjumping )
        {
            isjumping = 0;
            jumpduration = gettime() - var_742a326b07556b9f;
            
            if ( jumpduration >= 1500 )
            {
                utility::function_32b24db3127bff40( "land_vfx", "lrg_vfx_on" );
            }
            else
            {
                utility::function_32b24db3127bff40( "land_vfx", "sml_vfx_on" );
            }
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x9f000c26, Offset: 0x6432
// Size: 0x1e
function private try_play_vo( alias )
{
    if ( soundexists( alias ) )
    {
        dialogue::say( alias );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x22669b62, Offset: 0x6458
// Size: 0x8f
function private function_153748775f30c5a5()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    thread try_play_vo( "dx_zm_amim_minj_mang_mutantinjectspawnin" );
    
    if ( !soundexists( "dx_zm_amim_minj_mang_mutantinjectspawnout" ) )
    {
        return;
    }
    
    while ( !isdefined( self.mutant_injection_end_time ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( self.mutant_injection_end_time && self.mutant_injection_end_time - gettime() <= 10000 )
        {
            thread try_play_vo( "dx_zm_amim_minj_mang_mutantinjectspawnout" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x7f648140, Offset: 0x64ef
// Size: 0x4b
function private function_2c5f5babb946cfc7()
{
    if ( isdefined( self.var_6b958148a872a40 ) && gettime() - self.var_6b958148a872a40 < 3000 )
    {
        return;
    }
    
    if ( randomint( 100 ) <= 10 )
    {
        self.var_6b958148a872a40 = gettime();
        thread try_play_vo( "dx_zm_amim_minj_mang_mutantinjectkill" );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xd45dba, Offset: 0x6542
// Size: 0xeb
function private function_2323a0783b6b083()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    
    if ( !val::get( "allow_revive_teammate" ) )
    {
        self.hiddenreviveents = [];
        
        while ( true )
        {
            foreach ( entnum, ent in level.laststandreviveents )
            {
                if ( !isdefined( self.hiddenreviveents[ entnum ] ) && isdefined( ent ) )
                {
                    ent disableplayeruse( self );
                    self.hiddenreviveents[ entnum ] = ent;
                }
            }
            
            wait 0.1;
        }
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xcc4a3097, Offset: 0x6635
// Size: 0xa6
function private function_a684aad5b33bef00()
{
    if ( val::get( "allow_revive_teammate" ) && isdefined( self.hiddenreviveents ) )
    {
        foreach ( ent in self.hiddenreviveents )
        {
            if ( isdefined( ent ) )
            {
                ent enableplayeruse( self );
            }
        }
        
        self.hiddenreviveents = undefined;
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xa25de2ea, Offset: 0x66e3
// Size: 0x7d
function private function_598605774ad9dfaf()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    val::set( "mutant_injection_transform_ignore_collision", "unresolved_collisions", 0 );
    prev_origin = self.origin;
    
    while ( true )
    {
        if ( distancesquared( prev_origin, self.origin ) > 2 )
        {
            val::reset_all( "mutant_injection_transform_ignore_collision" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x1468b43a, Offset: 0x6768
// Size: 0xa5
function private function_67fb1a947bc1fccb()
{
    foreach ( turret in level.turrets )
    {
        if ( isdefined( turret.useownerobj ) && turret.owner == self )
        {
            turret.useownerobj namespace_9d8e359c3b1041e5::disableplayerusesharedfunc( self );
        }
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x74188ac4, Offset: 0x6815
// Size: 0xa5
function private function_55199c384a3f84f3()
{
    foreach ( turret in level.turrets )
    {
        if ( isdefined( turret.useownerobj ) && turret.owner == self )
        {
            turret.useownerobj namespace_9d8e359c3b1041e5::enableplayerusesharedfunc( self );
        }
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xf5f78347, Offset: 0x68c2
// Size: 0x5e
function private on_player_warp_callback( params )
{
    if ( !params.player.ismutantinjection )
    {
        return;
    }
    
    player = params.player;
    
    if ( player.mutantinjectiontransformed )
    {
        player utility::function_32b24db3127bff40( "zm_minj_transform_in", "off" );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x68f031de, Offset: 0x6928
// Size: 0xc1
function private function_f9b44ab40cbf5ef9()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self endon( #"hash_3d677b7e1c78cd10" );
    
    while ( true )
    {
        if ( self.micontext.weapon )
        {
            weaponobj = self.micontext.weaponobj ?? makeweapon( self.micontext.weapon );
            
            if ( self getcurrentweapon() != weaponobj )
            {
                if ( !self hasweapon( weaponobj ) )
                {
                    inventory_utility::_giveweapon( weaponobj, undefined, undefined, 1 );
                }
                
                inventory_utility::_switchtoweaponimmediate( weaponobj );
                wait 1;
                continue;
            }
        }
        
        wait 0.1;
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0xeb8883c, Offset: 0x69f1
// Size: 0x17f
function private on_ai_killed( params )
{
    if ( isdefined( params.eattacker ) && params.eattacker.ismutantinjection )
    {
        attacker = params.eattacker;
        
        if ( attacker.streakinfo.streakname != "zm_minj" )
        {
            return;
        }
        
        if ( isdefined( params.sweapon ) && isdefined( attacker.micontext.weapon ) )
        {
            weaponobj = attacker.micontext.weaponobj ?? makeweapon( attacker.micontext.weapon );
            
            if ( params.sweapon != weaponobj )
            {
                return;
            }
        }
        
        if ( isdefined( attacker.streakinfo.kills ) )
        {
            attacker.streakinfo.kills++;
        }
        
        if ( isdefined( params.smeansofdeath ) && ( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
        {
            if ( isdefined( attacker.mutant_injection_analytics.cannon_kills ) )
            {
                attacker.mutant_injection_analytics.cannon_kills++;
            }
        }
        
        attacker thread function_2c5f5babb946cfc7();
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0xf27cea58, Offset: 0x6b78
// Size: 0x41
function private init_mutant_injection_analytics()
{
    analytics = {};
    analytics.sprint_kills = 0;
    analytics.melee_kills = 0;
    analytics.cannon_kills = 0;
    self.mutant_injection_analytics = analytics;
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x27e54c77, Offset: 0x6bc1
// Size: 0x16a
function private function_e479e3b1052bdd4a()
{
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    game_type = game_utility::getgametype();
    map_name = game_utility::getmapname();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    cannon_kills = self.mutant_injection_analytics.cannon_kills ?? 0;
    melee_kills = self.mutant_injection_analytics.melee_kills ?? 0;
    sprint_kills = self.mutant_injection_analytics.sprint_kills ?? 0;
    self dlog_recordplayerevent( "dlog_event_player_zm_minj_end", [ "map_name", map_name, "game_type", game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", time, "cannon_kills", cannon_kills, "melee_kills", melee_kills, "sprint_kills", sprint_kills ] );
    self.mutant_injection_analytics = undefined;
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x5fcad068, Offset: 0x6d33
// Size: 0x152
function private on_item_pickup( params )
{
    if ( isdefined( params.itembundle ) && params.itembundle.ref === "zm_minj" )
    {
        time = matchdata::gettimefrommatchstart( gettime() );
        time = int( clamp( time, 0, 2147483647 ) );
        game_type = game_utility::getgametype();
        map_name = game_utility::getmapname();
        playlist_id = 0;
        playlist_name = "";
        
        if ( game_utility_mp::matchmakinggame() )
        {
            playlist_id = getplaylistid();
            playlist_name = getplaylistname();
        }
        
        self dlog_recordplayerevent( "dlog_event_player_zm_minj_pickup", [ "map_name", map_name, "game_type", game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", time, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
    }
}

// Namespace mutant_injection_shared
// Params 1, eflags: 0x4
// Checksum 0x6c0df612, Offset: 0x6e8d
// Size: 0x152
function private function_ecdca0c410f5f75a( params )
{
    if ( isdefined( params.item ) && params.item.itemref === "zm_minj" )
    {
        time = matchdata::gettimefrommatchstart( gettime() );
        time = int( clamp( time, 0, 2147483647 ) );
        game_type = game_utility::getgametype();
        map_name = game_utility::getmapname();
        playlist_id = 0;
        playlist_name = "";
        
        if ( game_utility_mp::matchmakinggame() )
        {
            playlist_id = getplaylistid();
            playlist_name = getplaylistname();
        }
        
        self dlog_recordplayerevent( "dlog_event_player_zm_minj_crafted", [ "map_name", map_name, "game_type", game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", time, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
    }
}

// Namespace mutant_injection_shared
// Params 0, eflags: 0x4
// Checksum 0x83a2fd3, Offset: 0x6fe7
// Size: 0x11a
function private function_e214e57b2601c478()
{
    time = matchdata::gettimefrommatchstart( gettime() );
    time = int( clamp( time, 0, 2147483647 ) );
    game_type = game_utility::getgametype();
    map_name = game_utility::getmapname();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    self dlog_recordplayerevent( "dlog_event_player_zm_minj_used", [ "map_name", map_name, "game_type", game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "matchtime_ms", time, "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ] ] );
}

// Namespace mutant_injection_shared
// Params 1
// Checksum 0x7b6ef781, Offset: 0x7109
// Size: 0x4c
function function_fe7d53f7d5d0d792( var_ae0304b47d4d08f )
{
    if ( !isdefined( level.mutant_injection_variants ) )
    {
        level.mutant_injection_variants = [];
    }
    
    if ( !arraycontains( level.mutant_injection_variants, var_ae0304b47d4d08f ) )
    {
        level.mutant_injection_variants[ level.mutant_injection_variants.size ] = var_ae0304b47d4d08f;
    }
}

/#

    // Namespace mutant_injection_shared
    // Params 0
    // Checksum 0x44a0732c, Offset: 0x715d
    // Size: 0xd9, Type: dev
    function function_50daa7ab3c558bab()
    {
        mi_player = undefined;
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                mi_player = player;
            }
        }
        
        if ( isdefined( mi_player ) && !mi_player.ismutantinjection && !mi_player.var_d43bbb33841dcc9d )
        {
            mi_player.var_d43bbb33841dcc9d = 1;
            mi_player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( "<dev string:xa5>", "<dev string:xad>", undefined, undefined, undefined, 1 );
        }
    }

    // Namespace mutant_injection_shared
    // Params 0
    // Checksum 0x40fb6264, Offset: 0x723e
    // Size: 0x1a, Type: dev
    function function_663e93cb28525637()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb3>", @"hash_96b98824693e429" );
    }

    // Namespace mutant_injection_shared
    // Params 0
    // Checksum 0xdcf8bd28, Offset: 0x7260
    // Size: 0xe, Type: dev
    function function_f7772824238349df()
    {
        level thread function_d2137a316b39f44a( 0 );
    }

    // Namespace mutant_injection_shared
    // Params 0
    // Checksum 0x8312803a, Offset: 0x7276
    // Size: 0xf, Type: dev
    function function_30d6debfc33678ce()
    {
        level thread function_d2137a316b39f44a( 1 );
    }

#/
