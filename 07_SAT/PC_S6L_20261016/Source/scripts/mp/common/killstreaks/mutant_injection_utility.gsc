// scripts\mp\common\killstreaks\mutant_injection_utility.gsc  (hash_4775ad0a02cebe9c.gscc) (size: 34909 Bytes / 0x885d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x898bbc2 (144227266)
// size ...... 34909 (0x885d)
// includes .. 26  (offset: 0x80ad)
// strings ... 117 (offset: 0x817d)
// dev strs .. 4   (offset: 0x882d)
// exports ... 73  (offset: 0x5795)
// cseg ...... 0x8e4 + 0x4eb1 (0x5795)
// imports ... 234 (offset: 0x62fd)
// animtree1 . 0   (offset: 0x885d)
// animtree2 . 0   (offset: 0x885d)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\execution;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\mtx_weapon;
#using scripts\mp\operator;
#using scripts\mp\parachute;
#using scripts\mp\playerhealth;
#using scripts\mp\teams;

#namespace mutant_injection_utility;

// Namespace mutant_injection_utility
// Params 1
// Checksum 0xaa00859b, Offset: 0x902
// Size: 0xa1
function init( var_d31dc7187a8cc4db )
{
    level callback::add( "on_player_warp", &on_player_warp_callback );
    scene::function_85b13b837056bc8b( &exit_mutant_injection_igc );
    utility::registersharedfunc( #"mutant_injection", #"force_exit_mutant_injection", &function_d2137a316b39f44a );
    utility::registersharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", &function_6fa2b0b46d2abcf7 );
    
    if ( utility::issharedfuncdefined( var_d31dc7187a8cc4db, #"init" ) )
    {
        self [[ utility::getsharedfunc( var_d31dc7187a8cc4db, #"init" ) ]]();
    }
    
    /#
        setdvarifuninitialized( @"hash_96b98824693e429", 0 );
    #/
}

// Namespace mutant_injection_utility
// Params 2
// Checksum 0x9df72e44, Offset: 0x9ab
// Size: 0x324
function watchmutantinjection( var_14be0963e56d73dc, exitcallback )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    msg = utility::waittill_any_return_params( "mutantinjection_start", "mutant_injection_transform_interrupt" );
    
    if ( msg[ "message" ] == "mutant_injection_transform_interrupt" )
    {
        streakinfo = self.micontext.streakinfo;
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        killstreak_utility::function_d546aaa588f088c3( function_3033707e7b408423(), "off" );
        
        if ( self.mutantinjectiontransformed )
        {
            instant_exit = msg[ 0 ] == "mutant_injecton_instant_exit";
            function_2b562b60a3d69e6f( 0, instant_exit );
        }
        
        return;
    }
    
    self enableplayerbreathsystem( 0 );
    
    if ( isdefined( var_14be0963e56d73dc ) )
    {
        self [[ var_14be0963e56d73dc ]]( {} );
    }
    
    category = self.micontext.var_d31dc7187a8cc4db;
    endons = [ "mutantinjection_end", "death_or_disconnect" ];
    
    if ( isdefined( category ) && utility::issharedfuncdefined( category, #"hash_2a99682c5fc5e5ab" ) )
    {
        thread utility::callsharedfunc( category, #"hash_2a99682c5fc5e5ab", endons );
    }
    else
    {
        player::function_ba055eee4438741e( "exit_mutant_injection", "stance", &tryexiting, undefined, endons, 1, &function_1617690e741ab65b, "gamepad_only" );
        player::function_ba055eee4438741e( "exit_mutant_injection", "movedown", &tryexiting, undefined, endons, 1, &function_1617690e741ab65b, "kbm_only" );
    }
    
    if ( isdefined( category ) && utility::issharedfuncdefined( category, #"overridetimeout" ) )
    {
        thread utility::callsharedfunc( category, #"overridetimeout", [ "mutantinjection_end", "mutantinjection_exit" ] );
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
    
    self enableplayerbreathsystem( 1 );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.micontext.streakinfo } );
    
    if ( isdefined( exitcallback ) )
    {
        self [[ exitcallback ]]( {} );
    }
    
    if ( self.ismutantinjection )
    {
        istimeout = msg == "mutant_injection_time_out";
        thread function_2b562b60a3d69e6f( istimeout, self.micontext.miconfig.var_573b7ef5186ac8c6 );
    }
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x981cc18, Offset: 0xcd7
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

// Namespace mutant_injection_utility
// Params 3, eflags: 0x4
// Checksum 0x73c18dc5, Offset: 0xd50
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x2720a7d5, Offset: 0xdf2
// Size: 0x13a
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
    
    start_time = gettime();
    duration = function_a6afc2674dc54f35();
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x2d6e4d94, Offset: 0xf34
// Size: 0xb
function private exit_mutant_injection_igc()
{
    function_d2137a316b39f44a( 1 );
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xb5025b25, Offset: 0xf47
// Size: 0x42
function private function_5316ad8325da7f35()
{
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
    }
}

// Namespace mutant_injection_utility
// Params 4
// Checksum 0xab4ccab4, Offset: 0xf91
// Size: 0x455
function function_64a3fcac1c224b2c( miconfig, streakinfo, var_d31dc7187a8cc4db, var_670a40b7ce7cfaab )
{
    if ( !isdefined( self.micontext ) )
    {
        self.micontext = {};
    }
    
    micontext = self.micontext;
    micontext.miconfig = miconfig;
    micontext.streakinfo = streakinfo;
    micontext.var_d31dc7187a8cc4db = var_d31dc7187a8cc4db;
    micontext.var_670a40b7ce7cfaab = var_670a40b7ce7cfaab;
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
    
    if ( self getweaponslistprimaries().size >= 1 )
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
                
                if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) && weap == self.var_3bf72dcd2775aa78 )
                {
                    weapstruct.var_e1a61529a3bbae4 = 1;
                }
                
                micontext.weapstructs[ micontext.weapstructs.size ] = weapstruct;
            }
        }
    }
    
    miweapon = utility::get_scripted_weapon_name( var_670a40b7ce7cfaab );
    micontext.weapon = miweapon;
    bundle = level.streakglobals.streakbundles[ function_3033707e7b408423() ];
    micontext.bundle = bundle;
    micontext.deployweaponobj = makeweapon( bundle.deployweaponname );
    micontext.var_cd7fbd135a81723f = bundle.mutantinjectiondata.var_cd7fbd135a81723f ?? 1;
    micontext.var_f4cfb89f123543d9 = bundle.mutantinjectiondata.var_f4cfb89f123543d9 ?? 0;
    micontext.validstance = function_7554b9424397983( miconfig );
    
    if ( micontext.lastweaponobj.isalternate )
    {
        micontext.lastweaponobj = micontext.lastweaponobj getnoaltweapon();
    }
    
    if ( utility::issharedfuncdefined( var_d31dc7187a8cc4db, #"setcontext" ) )
    {
        self [[ utility::getsharedfunc( var_d31dc7187a8cc4db, #"setcontext" ) ]]( miconfig, streakinfo );
    }
}

// Namespace mutant_injection_utility
// Params 1
// Checksum 0x172c120, Offset: 0x13ee
// Size: 0x244, Type: bool
function canactivate( streak_name )
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
    
    micontext = self.micontext;
    bundle = level.streakglobals.streakbundles[ streak_name ];
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
    
    if ( self getweaponslistprimaries().size >= 1 && isnullweapon( micontext.lastweaponobj ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( micontext.validstance ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( micontext.streakinfo ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( micontext.bundle.deployweaponname ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( !isdefined( micontext.deployweaponobj ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    current_weapon = self getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( current_weapon ) )
    {
        function_5316ad8325da7f35();
        return false;
    }
    
    if ( utility::issharedfuncdefined( micontext.var_d31dc7187a8cc4db, #"canactivate" ) )
    {
        if ( !self [[ utility::getsharedfunc( micontext.var_d31dc7187a8cc4db, #"canactivate" ) ]]() )
        {
            function_5316ad8325da7f35();
            return false;
        }
    }
    
    return true;
}

// Namespace mutant_injection_utility
// Params 2
// Checksum 0xac4bb3db, Offset: 0x163b
// Size: 0xb6, Type: bool
function function_f247f77ac7ba541a( deployweaponobj, var_b4eba598fb469999 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    thread function_28574f8ad2fa1b99();
    animlength = getanimlength( var_b4eba598fb469999 ) - 0.5;
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x494683ce, Offset: 0x16fa
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

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0x830c64f9, Offset: 0x176b
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

// Namespace mutant_injection_utility
// Params 1
// Checksum 0x270fa606, Offset: 0x18ac
// Size: 0x18a
function starttransformation( skin )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.ismutantinjection = 1;
    function_261c3b5b33fbad35( self );
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    
    if ( isstring( micontext.mi_omnvar ) )
    {
        self setclientomnvar( micontext.mi_omnvar, 1 );
    }
    
    if ( !self.var_a327dbacf3205a5f )
    {
        function_20a634c3d7f708bf( self, 1 );
    }
    
    level thread function_414ddb49e4cd2b25();
    thread function_61b9548d6f1916f9();
    val::set( "mutant_injection_disallow_grab", "allow_grab", 0 );
    gas_grenade::gas_updateplayereffects();
    
    if ( self.health < self.maxhealth )
    {
        playerhealth::forcehealthregen( self );
    }
    
    weapon_utility::saveweaponstates();
    
    if ( isdefined( miconfig.pre_allows ) )
    {
        function_cfe6a5fed7778f67( miconfig.pre_allows, 0 );
    }
    
    function_67fb1a947bc1fccb();
    
    if ( isstring( micontext.transform_in_part ) )
    {
        utility::function_32b24db3127bff40( micontext.transform_in_part, "vfx_on" );
    }
    
    if ( skin )
    {
        body = operator::function_4e6b11f7340acc24( skin );
        head = operator::function_115f78fb5f506daa( skin );
        utility::player_prestream_assets( "mutant_injection", "model", [ body, head ], 200, 10 );
    }
}

// Namespace mutant_injection_utility
// Params 3
// Checksum 0x94eb35df, Offset: 0x1a3e
// Size: 0x6aa
function function_8b2421e41e3a9eb1( need_exit, suit, operatorskin )
{
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    streakname = function_3033707e7b408423();
    
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
            validstance = function_7554b9424397983( miconfig );
            
            if ( !isdefined( validstance ) )
            {
                function_5316ad8325da7f35();
                need_exit = 1;
            }
        }
    }
    
    if ( need_exit )
    {
        if ( isdefined( miconfig.pre_allows ) )
        {
            function_cfe6a5fed7778f67( miconfig.pre_allows, 1 );
        }
        
        val::reset_all( "mutant_injection_disallow_grab" );
        
        if ( isstring( micontext.mi_omnvar ) )
        {
            self setclientomnvar( micontext.mi_omnvar, 0 );
        }
        
        if ( !self.var_a327dbacf3205a5f )
        {
            function_20a634c3d7f708bf( self, 0 );
        }
        
        function_251f818850fdb794( self );
        namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( streakname, "other", undefined, undefined, undefined, 1 );
        
        if ( isdefined( micontext.lastweaponobj ) )
        {
            inventory_utility::_switchtoweaponimmediate( micontext.lastweaponobj );
        }
        
        function_55199c384a3f84f3();
        
        if ( isstring( micontext.transform_in_part ) )
        {
            utility::function_32b24db3127bff40( micontext.transform_in_part, "off" );
        }
        
        self notify( #"mutant_injection_transform_interrupt" );
        return;
    }
    
    callback::callback( #"hash_5b8b82c2527d7aa2", { #streakname:streakname } );
    self freezecontrols( 1 );
    var_4e696c1264ef4e4a = self getcamerathirdperson();
    
    if ( !var_4e696c1264ef4e4a )
    {
        self setcamerathirdperson( 1 );
    }
    
    mtx_weapon::function_4bafd0f14b064f2a();
    
    if ( self getweaponslistprimaries().size >= 1 )
    {
        weaplist = self getweaponslistprimaries();
        
        foreach ( weap in weaplist )
        {
            item_weapon::function_e570f94856126417( weap );
            item_weapon::function_9e7275fa51ace996( weap, "mutantinjection_transformation" );
        }
        
        foreach ( weap in weaplist )
        {
            inventory_utility::_takeweapon( weap );
        }
    }
    
    inventory_utility::_giveweapon( micontext.weapon );
    thread function_7fb6068aaf818f97( 0.5, micontext.weapon );
    weapon::fixupplayerweapons( self, micontext.weapon );
    
    if ( miconfig.var_60e112d2e106b00a )
    {
        self function_60e112d2e106b00a();
    }
    
    foreach ( perk, unused in miconfig.perks )
    {
        perk::giveperk( perk );
    }
    
    function_cfe6a5fed7778f67( miconfig.allows, 0 );
    thread function_2323a0783b6b083();
    
    if ( isdefined( suit ) && isdefined( operatorskin ) )
    {
        operator = operator::function_30f20ce375c4ee40( operatorskin );
        function_fc3bb3b83b7479b6( operator, operatorskin, suit, micontext.var_69224c24ef535a12 );
    }
    else
    {
        assert( 0, "<dev string:x24>" );
    }
    
    players = getplayersinradius( self.origin, 200, undefined, undefined, [ self ] );
    
    foreach ( player in players )
    {
        player utility::player_prestream_assets( "mutant_injection", "entity", self, 200, 10 );
    }
    
    killstreak_utility::function_bea4bda17e40ffb0( self );
    
    if ( miconfig.infiniteammo )
    {
        thread weapon::infiniteammothread( miconfig.infiniteammoupdaterate, [ micontext.weapon ] );
    }
    
    var_1a51232331718d97 = micontext.validstance != self getstance();
    
    if ( var_1a51232331718d97 )
    {
        self setstance( micontext.validstance );
    }
    
    if ( utility::issharedfuncdefined( micontext.var_d31dc7187a8cc4db, #"starttransformation" ) )
    {
        [[ utility::getsharedfunc( micontext.var_d31dc7187a8cc4db, #"starttransformation" ) ]]();
    }
    
    val::set( "mutant_injection_transformation", "fire", 0 );
    
    if ( !self.var_a327dbacf3205a5f )
    {
        killstreak_utility::function_d546aaa588f088c3( streakname, "on" );
        self setclientomnvar( "ui_zm_zm_minj_progress", 1 );
        self setclientomnvar( "ui_exit_progress", 0 );
    }
    
    if ( micontext.miconfig.var_bf95338539967227 )
    {
        if ( isstring( micontext.transform_in_part ) )
        {
            utility::function_32b24db3127bff40( micontext.transform_in_part, "vfx_quick_on" );
        }
        
        waitframe();
    }
    else if ( micontext.var_8152e2282f3b3caa )
    {
        msg = self [[ micontext.var_8152e2282f3b3caa ]]( {} );
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
    
    if ( isstring( micontext.mi_omnvar ) )
    {
        self setclientomnvar( micontext.mi_omnvar, 0 );
    }
    
    self.mutantinjectiontransformed = 1;
}

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0xfe310513, Offset: 0x20f0
// Size: 0x4f
function private function_7fb6068aaf818f97( wait_time, weapon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    wait wait_time;
    
    if ( self hasweapon( weapon ) )
    {
        inventory_utility::_switchtoweapon( weapon );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x7ea1cadf, Offset: 0x2147
// Size: 0x148
function private completetransformation()
{
    micontext = self.micontext;
    streakname = function_3033707e7b408423();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "used_" + streakname, self );
    }
    
    if ( utility::issharedfuncdefined( micontext.var_d31dc7187a8cc4db, #"completetransformation" ) )
    {
        self [[ utility::getsharedfunc( micontext.var_d31dc7187a8cc4db, #"completetransformation" ) ]]();
    }
    
    thread function_153748775f30c5a5();
    
    if ( micontext.var_20b536a9378bf072 )
    {
        thread function_11e58cee78c4514d();
    }
    
    thread function_5a74d9bfe1b88fe3();
    thread function_8046a37b225cdb6b();
    
    if ( utility::issharedfuncdefined( micontext.var_d31dc7187a8cc4db, #"hash_2f590838fdf8226f" ) )
    {
        self thread [[ utility::getsharedfunc( micontext.var_d31dc7187a8cc4db, #"hash_2f590838fdf8226f" ) ]]();
    }
    else
    {
        thread function_99c9f95e96f25130();
    }
    
    thread function_971088f00ed2508b( streakname );
    thread function_598605774ad9dfaf();
    
    if ( isdefined( micontext.var_8f3bcdac5d9009b ) )
    {
        self [[ micontext.var_8f3bcdac5d9009b ]]( {} );
    }
    
    self notify( #"mutantinjection_start" );
}

// Namespace mutant_injection_utility
// Params 2
// Checksum 0xb31cd737, Offset: 0x2297
// Size: 0x7a4
function function_2b562b60a3d69e6f( istimeout = 0, skipanimation = 0 )
{
    assert( self.ismutantinjection );
    assert( isdefined( self.micontext ) );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.ismutantinjection = 0;
    self notify( #"mutantinjection_end" );
    micontext = self.micontext;
    miconfig = micontext.miconfig;
    streakname = function_3033707e7b408423();
    
    if ( isstring( micontext.mi_omnvar ) )
    {
        self setclientomnvar( micontext.mi_omnvar, 1 );
    }
    
    if ( utility::issharedfuncdefined( micontext.var_d31dc7187a8cc4db, #"removemutantinjection" ) )
    {
        self [[ utility::getsharedfunc( micontext.var_d31dc7187a8cc4db, #"removemutantinjection" ) ]]( istimeout, skipanimation );
    }
    
    if ( isdefined( micontext.var_e38f13b5654b5514 ) )
    {
        self [[ micontext.var_e38f13b5654b5514 ]]( istimeout, skipanimation );
    }
    
    restore_fov();
    
    if ( isstring( micontext.var_be28f4c5f7e79a1 ) )
    {
        self setclientomnvar( micontext.var_be28f4c5f7e79a1, 0 );
    }
    
    self setclientomnvar( "ui_zm_mutant_injection_underwater", 0 );
    val::reset_all( "mutant_injection_in_water" );
    val::set( "mutant_injection_transformation", "fire", 0 );
    
    if ( miconfig.infiniteammo )
    {
        weapon::stopinfiniteammothread();
    }
    
    val::set( "transformation_ignore_me", "ignoreme", 1 );
    
    if ( self.var_bded870341f32d15 || self.var_d6a4e00f6028b307 )
    {
        if ( !isdefined( self.mutant_injection_start_time ) || gettime() - self.mutant_injection_start_time < 10000 )
        {
            namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( streakname, "other", undefined, undefined, undefined, 1 );
        }
    }
    
    if ( !self.var_d6a4e00f6028b307 && !skipanimation )
    {
        if ( self.var_e8a960b35e9155d5 )
        {
            if ( isdefined( micontext.deep_water_transform_cam_part ) )
            {
                utility::function_32b24db3127bff40( micontext.deep_water_transform_cam_part, "vfx_on" );
            }
            
            wait 0.1;
            self.var_e8a960b35e9155d5 = undefined;
        }
        else
        {
            self freezecontrols( 1 );
            
            if ( isdefined( micontext.var_3dad763ff705788d ) )
            {
                self [[ micontext.var_3dad763ff705788d ]]( {} );
            }
            
            self freezecontrols( 0 );
        }
    }
    else if ( isstring( micontext.transform_in_part ) && micontext.miconfig.var_573b7ef5186ac8c6 )
    {
        utility::function_32b24db3127bff40( micontext.transform_in_part, "off" );
        waitframe();
        utility::function_32b24db3127bff40( micontext.transform_in_part, "vfx_quick_on" );
        waitframe();
    }
    
    killstreak_utility::function_d546aaa588f088c3( streakname, "off" );
    thread function_e386548b0ab21fb9( 3, "transformation_ignore_me" );
    val::reset_all( "mutant_injection_transformation" );
    val::reset_all( "mutant_injection_transform_ignore_collision" );
    killstreak_utility::function_c463ddccb4054cc2( self );
    
    if ( isalive( self ) && !self.inlaststand )
    {
        if ( isdefined( micontext.weapon ) )
        {
            inventory_utility::_takeweapon( micontext.weapon );
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
                
                if ( weapstruct.var_e1a61529a3bbae4 && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) )
                {
                    self.var_3bf72dcd2775aa78 = weapstruct.weaponobj;
                }
                
                weapon::fixupplayerweapons( self, weapstruct.weaponobj );
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
    
    function_fc3bb3b83b7479b6( micontext.var_a9c6c85962429e1c, micontext.var_716d2096928c8cab );
    self.get_cannon_fire_params = undefined;
    
    if ( isdefined( micontext.var_b602c5d0276c5b6 ) )
    {
        var_647d934381f24be2 = !self.var_d6a4e00f6028b307 && !skipanimation;
        self [[ micontext.var_b602c5d0276c5b6 ]]( { #var_647d934381f24be2:var_647d934381f24be2 } );
    }
    
    function_a684aad5b33bef00();
    function_55199c384a3f84f3();
    mtx_weapon::function_7b8972f2b1aa0a67();
    
    if ( isstring( micontext.mi_omnvar ) )
    {
        self setclientomnvar( micontext.mi_omnvar, 0 );
    }
    
    if ( !self.var_a327dbacf3205a5f )
    {
        function_20a634c3d7f708bf( self, 0 );
    }
    
    self.mutantinjectiontransformed = undefined;
    function_251f818850fdb794( self );
    callback::callback( #"hash_d558db2dac47d5f7", { #streakname:streakname, #istimeout:istimeout } );
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

// Namespace mutant_injection_utility
// Params 2
// Checksum 0xe8bf1b57, Offset: 0x2a43
// Size: 0x32e
function function_a4d6e1d92b3d3491( config, var_d31dc7187a8cc4db )
{
    if ( utility::issharedfuncdefined( var_d31dc7187a8cc4db, #"getconfig" ) )
    {
        config = [[ utility::getsharedfunc( var_d31dc7187a8cc4db, #"getconfig" ) ]]();
    }
    
    if ( !isdefined( config ) )
    {
        config = {};
    }
    
    config.infiniteammo = 1;
    config.var_60e112d2e106b00a = 1;
    config.infiniteammoupdaterate = 0.5;
    config.pre_allows = [];
    config.pre_allows[ "damage" ] = 0;
    config.pre_allows[ "killstreaks" ] = 0;
    config.pre_allows[ "crouch" ] = 0;
    config.pre_allows[ "prone" ] = 0;
    config.pre_allows[ "swimming_underwater" ] = 0;
    config.pre_allows[ "equipment_primary" ] = 0;
    config.pre_allows[ "equipment_secondary" ] = 0;
    config.pre_allows[ "supers" ] = 0;
    config.pre_allows[ "weapon_pickup" ] = 0;
    config.pre_allows[ "offhand_weapons" ] = 0;
    config.pre_allows[ "offhand_throwback" ] = 0;
    config.pre_allows[ "weapon_switch" ] = 0;
    config.pre_allows[ "mantle" ] = 0;
    config.pre_allows[ "ascender_use" ] = 0;
    config.pre_allows[ "crate_use" ] = 0;
    config.pre_allows[ "interactions" ] = 0;
    config.pre_allows[ "dtp" ] = 0;
    config.pre_allows[ "ladder" ] = 0;
    config.pre_allows[ "vehicle_use" ] = 0;
    config.pre_allows[ "disallow_loot_but_auto_loot" ] = 1;
    config.pre_allows[ "allow_toggle_third_person" ] = 0;
    config.pre_allows[ "allow_scripted_bgb_use" ] = 0;
    config.pre_allows[ "allow_revive_teammate" ] = 0;
    config.pre_allows[ "armor" ] = 0;
    config.pre_allows[ "allow_emote" ] = 0;
    
    if ( parachute::isparachutegametype() )
    {
        config.pre_allows[ "base_jumping" ] = 0;
    }
    
    config.allows = [];
    config.allows[ "flashed" ] = 0;
    config.allows[ "stunned" ] = 0;
    config.allows[ "shellshock" ] = 0;
    config.allows[ "slide" ] = 0;
    config.allows[ "execution_attack" ] = 1;
    config.allows[ "execution_victim" ] = 0;
    config.allows[ "stance_change" ] = 0;
    config.perks = [];
    config.perks[ "specialty_sharp_focus" ] = 1;
    return config;
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xba6abbed, Offset: 0x2d7a
// Size: 0x2b, Type: bool
function private function_3033707e7b408423()
{
    return self.var_9d3e2d06ce7e8383 ?? self.micontext.streakinfo.streakname;
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0xb2ae11cc, Offset: 0x2dae
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x1a2ed370, Offset: 0x2e6a
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

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0x6c921cbf, Offset: 0x3018
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

// Namespace mutant_injection_utility
// Params 2
// Checksum 0x487f8e4f, Offset: 0x30e0
// Size: 0xf4
function function_cfe6a5fed7778f67( allows, allowed )
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

// Namespace mutant_injection_utility
// Params 4, eflags: 0x4
// Checksum 0xda2bd1c, Offset: 0x31dc
// Size: 0x2ff
function private function_fc3bb3b83b7479b6( operator, skin, suitoverride, var_69224c24ef535a12 )
{
    self function_16332a7775f10aa9();
    self.operatorcustomization.operatorref = operator;
    self.operatorcustomization.skinref = skin;
    operator = operator::function_30f20ce375c4ee40( skin );
    self.operatorcustomization.suit = suitoverride ?? utility::function_f825237e0eda5adf();
    gender = operator::getoperatorgender( operator );
    clothtype = operator::function_b1788ccf1b3c0ae9( skin );
    geartype = operator::function_d633420b529828e8( skin );
    self setoperatorcustomization( operator, skin );
    bodymodelname = var_69224c24ef535a12 ? operator::function_4e6b11f7340acc24( skin ) : self getcustomizationbody();
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

// Namespace mutant_injection_utility
// Params 5, eflags: 0x4
// Checksum 0x20b399e7, Offset: 0x34e3
// Size: 0x19c
function private function_71574eba36ad278d( var_5ddea964f429e3cf, var_da20088ae67ad678, dismember, var_d08f7f9485419066 = 3, mod )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_9b359784e8530f5" ) )
    {
        self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_9b359784e8530f5" ) ]]( var_5ddea964f429e3cf, var_da20088ae67ad678, dismember, var_d08f7f9485419066 );
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
    
    if ( !isdefined( weaponobj ) )
    {
        weapon_name = self.micontext.weapon;
        weaponobj = makeweapon( weapon_name );
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
    var_4dff55ce3b07f329 = var_5ddea964f429e3cf.health == 0;
    return var_4dff55ce3b07f329;
}

// Namespace mutant_injection_utility
// Params 2
// Checksum 0x878474de, Offset: 0x3688
// Size: 0x73
function function_c059fcb8b93ffa03( target, damagescale )
{
    n_damage = 0;
    
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_d2f6004b101d75ea" ) )
    {
        n_damage = self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_d2f6004b101d75ea" ) ]]( target, damagescale );
    }
    
    return n_damage;
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xb557aded, Offset: 0x3704
// Size: 0x217
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
    
    if ( isdefined( trace[ "entity" ] ) && isdefined( level.var_74ce31936c52d68f ) && trace[ "fraction" ] < 1 )
    {
        hitent = trace[ "entity" ];
        
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

// Namespace mutant_injection_utility
// Params 1
// Checksum 0x8c13f05a, Offset: 0x3923
// Size: 0x69
function getnearbytargets( radius )
{
    potentialtargets = [];
    
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"getnearbytargets" ) )
    {
        potentialtargets = self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"getnearbytargets" ) ]]( radius );
    }
    
    return potentialtargets;
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0xe07b6aad, Offset: 0x3995
// Size: 0x5b, Type: bool
function private function_a3f71ecb6eb404cc( target )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_63554db87d064a6b" ) )
    {
        return istrue( self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_63554db87d064a6b" ) ]]( target ) );
    }
    
    return false;
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x8160cb3c, Offset: 0x39f9
// Size: 0x59
function private function_5da7e225cbfb13ae( target )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_737633f5a317c5cf" ) )
    {
        self [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_737633f5a317c5cf" ) ]]( target );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x56d967ab, Offset: 0x3a5b
// Size: 0x368
function private function_11e58cee78c4514d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    hit_targets = [];
    sprint_start_time = undefined;
    is_moving_attack = 0;
    var_351060baffe07228 = self.micontext.var_351060baffe07228;
    
    while ( self.ismutantinjection )
    {
        speed = length( self getvelocity() );
        
        if ( !self isonground() || !self issprinting() || speed < 190 )
        {
            if ( is_moving_attack && var_351060baffe07228 )
            {
                val::reset_all( "mutant_injection_moving_attack" );
            }
            
            is_moving_attack = 0;
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
            is_moving_attack = 0;
            var_48ee71281f56f926 = undefined;
            waitframe();
            continue;
        }
        
        function_31e4db59f180f478();
        function_19dbea8a701ed9cf();
        
        if ( !is_moving_attack )
        {
            hit_targets = [];
            is_moving_attack = 1;
            var_48ee71281f56f926 = gettime();
            
            if ( var_351060baffe07228 )
            {
                val::set( "mutant_injection_moving_attack", "allow_jump", 0 );
            }
        }
        
        if ( isdefined( var_48ee71281f56f926 ) && isdefined( self.mutant_injection_end_time ) )
        {
            timer_reduce = int( ( gettime() - var_48ee71281f56f926 ) * 0.5 );
            self.mutant_injection_end_time -= timer_reduce;
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
            var_ee6433c31961982d = ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 );
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
            
            function_71574eba36ad278d( target, var_ee6433c31961982d, 0, var_d08f7f9485419066, "MOD_IMPACT" );
            rightstr = vectordot( right, var_ee6433c31961982d ) > 0 ? "right" : "left";
            charge_hit_part = "charge_hit_" + rightstr;
            utility::function_32b24db3127bff40( charge_hit_part, "attack_hit" );
            var_a5d700a05e77292d = 1;
            
            if ( isalive( target ) )
            {
                function_5da7e225cbfb13ae( target );
            }
        }
        
        if ( var_a5d700a05e77292d )
        {
            level thread function_5b7d0a03eb846e2c( self );
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) && is_moving_attack && var_351060baffe07228 )
    {
        val::reset_all( "mutant_injection_moving_attack" );
    }
}

// Namespace mutant_injection_utility
// Params 2
// Checksum 0x3b0f8840, Offset: 0x3dcb
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xc898626d, Offset: 0x3e41
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x665d75a0, Offset: 0x3f62
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x4810043f, Offset: 0x3fe6
// Size: 0x13a
function private function_5a74d9bfe1b88fe3()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    wassprinting = 0;
    sprint_vfx_part = self.micontext.sprint_vfx_part;
    
    while ( true )
    {
        issprinting = self issprinting() && length( self getvelocity() ) >= 190;
        
        if ( issprinting && !wassprinting )
        {
            if ( isstring( self.micontext.var_be28f4c5f7e79a1 ) )
            {
                self setclientomnvar( self.micontext.var_be28f4c5f7e79a1, 1 );
            }
            
            utility::function_32b24db3127bff40( sprint_vfx_part, "vfx_on" );
            function_828d34ed38962d9e( 20, 0.5 );
            wassprinting = 1;
        }
        else if ( !issprinting && wassprinting )
        {
            if ( isstring( self.micontext.var_be28f4c5f7e79a1 ) )
            {
                self setclientomnvar( self.micontext.var_be28f4c5f7e79a1, 0 );
            }
            
            utility::function_32b24db3127bff40( sprint_vfx_part, "deactivate" );
            function_828d34ed38962d9e( undefined, 0.5 );
            wassprinting = 0;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0xab8e992a, Offset: 0x4128
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x7bb953af, Offset: 0x41d0
// Size: 0x19
function private restore_fov()
{
    function_828d34ed38962d9e( undefined, 0.5 );
    self.defaultbasefov = undefined;
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0xd5cecaca, Offset: 0x41f1
// Size: 0xab, Type: bool
function private is_hit_water( var_7331c5c47ee98dfb )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_1fbae8a038b35137" ) )
    {
        can_ignore = utility::callsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_1fbae8a038b35137", self.origin );
        
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xde8dd03c, Offset: 0x42a5
// Size: 0x159
function private function_8046a37b225cdb6b()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    var_feaeb51dafb9aea = 0;
    wasswimming = 0;
    starttime = gettime();
    str_id = "mutant_injection_in_water";
    
    while ( isdefined( self.micontext.streakinfo ) )
    {
        hitshallows = is_hit_water( 0 );
        self setclientomnvar( "ui_zm_mutant_injection_underwater", hitshallows ? 1 : 0 );
        hitwater = is_hit_water();
        currenttime = gettime();
        
        if ( hitwater )
        {
            if ( !wasswimming )
            {
                val::set( str_id, "sprint", 0 );
                val::set( str_id, "move_speed_scale", 0.2 );
                var_feaeb51dafb9aea = currenttime;
                wasswimming = 1;
            }
            else if ( var_feaeb51dafb9aea + 500 < currenttime )
            {
                val::reset_all( str_id );
                
                if ( var_feaeb51dafb9aea - starttime <= 1000 )
                {
                    namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( function_3033707e7b408423(), "other", undefined, undefined, undefined, 1 );
                }
                
                self.var_e8a960b35e9155d5 = 1;
                self notify( #"mutantinjection_end" );
                return;
            }
        }
        else if ( wasswimming )
        {
            val::reset_all( str_id );
            var_feaeb51dafb9aea = 0;
            wasswimming = 0;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0xc8f5c0a5, Offset: 0x4406
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x834e5670, Offset: 0x4440
// Size: 0x5d
function private function_61b9548d6f1916f9()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"returned_to_human" );
    self endon( #"mutant_injection_transform_interrupt" );
    self endon( #"mutant_injecton_instant_exit" );
    self waittill( #"zmb_max_ammo" );
    self.var_61e46de61996b0b = 1;
    thread function_6da75f3867ace823();
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x6791c40, Offset: 0x44a5
// Size: 0x7c
function private function_6da75f3867ace823()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_d31dc7187a8cc4db = self.micontext.var_d31dc7187a8cc4db;
    utility::waittill_any( "returned_to_human", "mutant_injection_transform_interrupt", "mutant_injecton_instant_exit" );
    
    if ( self && self.var_61e46de61996b0b )
    {
        self.var_61e46de61996b0b = undefined;
        utility::callsharedfunc( var_d31dc7187a8cc4db, #"give_ammo" );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0xc
// Checksum 0xf86d6cd6, Offset: 0x4529
// Size: 0x223
function private function_414ddb49e4cd2b25()
{
    self notify( #"hash_41112af90dcfda08" );
    self endon( #"hash_41112af90dcfda08" );
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x725d7afc, Offset: 0x4754
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x38f2febb, Offset: 0x47e1
// Size: 0x4d
function private function_261c3b5b33fbad35( player )
{
    if ( !isdefined( level.var_8ec1fcfdeaa2fa21 ) )
    {
        level.var_8ec1fcfdeaa2fa21 = [];
    }
    
    if ( isdefined( player ) )
    {
        player.ismutantinjection = 1;
        level.var_8ec1fcfdeaa2fa21[ level.var_8ec1fcfdeaa2fa21.size ] = player;
    }
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x68a67c18, Offset: 0x4836
// Size: 0x47
function private function_251f818850fdb794( player )
{
    assert( isdefined( level.var_8ec1fcfdeaa2fa21 ) );
    
    if ( isdefined( player ) )
    {
        player.ismutantinjection = undefined;
        level.var_8ec1fcfdeaa2fa21 = arrayremove( level.var_8ec1fcfdeaa2fa21, player );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xa5694bd0, Offset: 0x4885
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

// Namespace mutant_injection_utility
// Params 1
// Checksum 0xbf4af098, Offset: 0x48c1
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

// Namespace mutant_injection_utility
// Params 1
// Checksum 0xcbef4e38, Offset: 0x49c5
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x6c37c5d6, Offset: 0x4b21
// Size: 0xd
function private disallow_mutant_injection()
{
    level.disallow_mutant_injection = 1;
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x26f512d2, Offset: 0x4b36
// Size: 0xc
function private allow_mutant_injection()
{
    level.disallow_mutant_injection = undefined;
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x483cf7f0, Offset: 0x4b4a
// Size: 0xc, Type: bool
function private function_620f88a1b583b28b()
{
    return istrue( level.disallow_mutant_injection );
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xd82a562, Offset: 0x4b5f
// Size: 0x1de
function private function_99c9f95e96f25130()
{
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

// Namespace mutant_injection_utility
// Params 3, eflags: 0x4
// Checksum 0xf3978aad, Offset: 0x4d45
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

// Namespace mutant_injection_utility
// Params 2, eflags: 0x4
// Checksum 0xca7a1c5f, Offset: 0x4d99
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x474443bc, Offset: 0x4de3
// Size: 0x102
function private function_971088f00ed2508b( streakname )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    isjumping = 0;
    var_742a326b07556b9f = undefined;
    bundle = level.streakglobals.streakbundles[ streakname ];
    var_94a44d7fe21f582c = bundle.mutantinjectiondata.var_94a44d7fe21f582c;
    
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
            
            if ( var_94a44d7fe21f582c && jumpduration >= 1500 )
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x571acf89, Offset: 0x4eed
// Size: 0x1e
function private try_play_vo( alias )
{
    if ( soundexists( alias ) )
    {
        dialogue::say( alias );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xb8deb3bd, Offset: 0x4f13
// Size: 0xf4
function private function_153748775f30c5a5()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    spawn_in_vo = self.micontext.var_2a98d44fe713fb03 ?? "dx_zm_amim_minj_mang_mutantinjectspawnin";
    spawn_out_vo = self.micontext.var_1d9535c6c67503a0 ?? "dx_zm_amim_minj_mang_mutantinjectspawnout";
    var_2b56d945b49028d9 = self.micontext.var_39b704daa079a6ba ?? 10000;
    thread try_play_vo( spawn_in_vo );
    
    if ( !soundexists( spawn_out_vo ) )
    {
        return;
    }
    
    while ( !isdefined( self.mutant_injection_end_time ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( self.mutant_injection_end_time && self.mutant_injection_end_time - gettime() <= var_2b56d945b49028d9 )
        {
            thread try_play_vo( spawn_out_vo );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace mutant_injection_utility
// Params 0
// Checksum 0x111c0e1b, Offset: 0x500f
// Size: 0xb3
function function_2c5f5babb946cfc7()
{
    kill_vo_interval = self.micontext.var_a7707e55f9da5643 ?? 3000;
    kill_vo_chance = self.micontext.var_e56cd7ee7716366e ?? 10;
    kill_vo_alias = self.micontext.var_7248c2df9e1f1532 ?? "dx_zm_amim_minj_mang_mutantinjectkill";
    
    if ( isdefined( self.var_6b958148a872a40 ) && gettime() - self.var_6b958148a872a40 < kill_vo_interval )
    {
        return;
    }
    
    if ( randomint( 100 ) <= kill_vo_chance )
    {
        self.var_6b958148a872a40 = gettime();
        thread try_play_vo( kill_vo_alias );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0xcfa35a0c, Offset: 0x50ca
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x33d3721, Offset: 0x51bd
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x6a472145, Offset: 0x526b
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x45f6012f, Offset: 0x52f0
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

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x25863fd1, Offset: 0x539d
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

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x7cb71624, Offset: 0x544a
// Size: 0x87
function private on_player_warp_callback( params )
{
    if ( !params.player.ismutantinjection )
    {
        return;
    }
    
    player = params.player;
    
    if ( player.mutantinjectiontransformed && player.micontext.transform_in_part )
    {
        player utility::function_32b24db3127bff40( player.micontext.transform_in_part, "off" );
    }
}

// Namespace mutant_injection_utility
// Params 0, eflags: 0x4
// Checksum 0x8417cb3, Offset: 0x54d9
// Size: 0x7a
function private function_a6afc2674dc54f35()
{
    bundle = level.streakglobals.streakbundles[ function_3033707e7b408423() ];
    streak_time = bundle.mutantinjectiondata.duration > 0 ? bundle.mutantinjectiondata.duration : 45;
    duration = utility::function_4b74c15943231980( streak_time );
    return duration;
}

// Namespace mutant_injection_utility
// Params 1
// Checksum 0x6a570fc1, Offset: 0x555c
// Size: 0x93
function function_d56f1bba158cb4d6( adjust_time )
{
    if ( self.ismutantinjection && isdefined( self.mutant_injection_end_time ) )
    {
        duration = function_a6afc2674dc54f35();
        last_end_time = self.mutant_injection_end_time;
        self.mutant_injection_end_time += adjust_time;
        self.mutant_injection_end_time = int( clamp( self.mutant_injection_end_time, gettime(), gettime() + duration ) );
        return ( self.mutant_injection_end_time - last_end_time );
    }
    
    return 0;
}

// Namespace mutant_injection_utility
// Params 1, eflags: 0x4
// Checksum 0x175a9653, Offset: 0x55f8
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

/#

    // Namespace mutant_injection_utility
    // Params 1
    // Checksum 0x8cbab0bb, Offset: 0x5652
    // Size: 0xf4, Type: dev
    function function_50daa7ab3c558bab( params )
    {
        mi_player = undefined;
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                mi_player = player;
            }
        }
        
        streakname = params[ 0 ] ?? "<dev string:x5a>";
        
        if ( isdefined( mi_player ) && !mi_player.ismutantinjection && !mi_player.var_d43bbb33841dcc9d )
        {
            mi_player.var_d43bbb33841dcc9d = 1;
            mi_player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( streakname, "<dev string:x62>", undefined, undefined, undefined, 1 );
        }
    }

    // Namespace mutant_injection_utility
    // Params 0
    // Checksum 0x1165d771, Offset: 0x574e
    // Size: 0x1a, Type: dev
    function function_663e93cb28525637()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x68>", @"hash_96b98824693e429" );
    }

    // Namespace mutant_injection_utility
    // Params 0
    // Checksum 0x14e27e87, Offset: 0x5770
    // Size: 0xe, Type: dev
    function function_f7772824238349df()
    {
        level thread function_d2137a316b39f44a( 0 );
    }

    // Namespace mutant_injection_utility
    // Params 0
    // Checksum 0x4b084395, Offset: 0x5786
    // Size: 0xf, Type: dev
    function function_30d6debfc33678ce()
    {
        level thread function_d2137a316b39f44a( 1 );
    }

#/
