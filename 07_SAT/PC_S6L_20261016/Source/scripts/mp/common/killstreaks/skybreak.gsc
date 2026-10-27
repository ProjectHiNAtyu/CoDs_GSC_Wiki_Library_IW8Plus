// scripts\mp\common\killstreaks\skybreak.gsc  (hash_38c189a6f9657de2.gscc) (size: 27000 Bytes / 0x6978 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bd1ec5c (2077355100)
// size ...... 27000 (0x6978)
// includes .. 19  (offset: 0x65d8)
// strings ... 46  (offset: 0x6670)
// dev strs .. 7   (offset: 0x691c)
// exports ... 50  (offset: 0x447c)
// cseg ...... 0x358 + 0x4124 (0x447c)
// imports ... 212 (offset: 0x4c4c)
// animtree1 . 0   (offset: 0x6978)
// animtree2 . 0   (offset: 0x6978)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;

#namespace skybreak;

// Namespace skybreak
// Params 0, eflags: 0x1
// Checksum 0xa642bd11, Offset: 0x376
// Size: 0x1b
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( #"skybreak" ), &init );
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xc3b71a65, Offset: 0x399
// Size: 0x1a6
function private init()
{
    utility::callsharedfunc( #"killstreak", #"registerkillstreak", "skybreak", &function_afc5638c562d8984 );
    namespace_9d8e359c3b1041e5::registervisibilityomnvarforkillstreaksharedfunc( "skybreak", "on", 31 );
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_abbcd9152e41d77f" ) && ![[ utility::getsharedfunc( #"equipment", #"hash_abbcd9152e41d77f" ) ]]() )
    {
        val::group_register( "skybreak_use", [ "usability", "shellshock", "melee", "vehicle_use" ] );
    }
    else
    {
        val::group_register( "skybreak_use", [ "usability", "shellshock", "melee", "vehicle_use", "nvg" ] );
    }
    
    val::group_register( "skybreak_deploy", [ "allow_jump", "killstreaks" ] );
    bundle = level.streakglobals.streakbundles[ "skybreak" ];
    assert( isdefined( bundle.var_20d9c380afa10256 ), "<dev string:x24>" );
    killstreaks::registerkillstreakdamagedealingweapon( "skybreak", bundle.var_20d9c380afa10256, #"large" );
    utility::registersharedfunc( #"skybreak", #"hack", &hack );
    level.skybreakinstances = [];
    
    /#
        setdvarifuninitialized( @"hash_dc4a0e235d5260f", 0 );
        setdvarifuninitialized( @"hash_291fb002facfb96", 0 );
    #/
}

// Namespace skybreak
// Params 2, eflags: 0x4
// Checksum 0x9f406fd0, Offset: 0x547
// Size: 0x58
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.hackduration || !hackeffect.speedscale )
    {
        return;
    }
    
    thread skybreak_disrupt( hackeffect.hackduration * 0.001, hackeffect.speedscale );
}

// Namespace skybreak
// Params 2, eflags: 0x4
// Checksum 0x874c1c4a, Offset: 0x5a7
// Size: 0x87
function private skybreak_disrupt( duration, speedscale )
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    function_db2cb658a8d006ba( 1, speedscale );
    msg = utility::waittill_any_in_array_or_timeout_no_endon_death( [ "death" ], duration );
    
    if ( msg == "death" )
    {
        function_db2cb658a8d006ba( undefined, undefined, 1 );
        return;
    }
    
    function_db2cb658a8d006ba( -1 );
}

// Namespace skybreak
// Params 3, eflags: 0x4
// Checksum 0x9ad95f8d, Offset: 0x636
// Size: 0x21c
function private function_db2cb658a8d006ba( amount, speedscale, fromdeath )
{
    if ( fromdeath || !self || self.isdestroyed )
    {
        self.owner emp_debuff::clear_emp_scramble();
        self.owner setscriptablepartstate( #"hash_fa086db745e2c53e", #"off", 0 );
        return;
    }
    
    if ( !isdefined( self.disruptcounter ) )
    {
        self.disruptcounter = 0;
    }
    
    prevcounter = self.disruptcounter;
    self.disruptcounter += amount;
    
    if ( self.disruptcounter < 0 )
    {
        self.disruptcounter = 0;
        assertmsg( "<dev string:x57>" );
    }
    
    if ( prevcounter == 0 && self.disruptcounter > 0 )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
        self.owner emp_debuff::play_emp_scramble( 5 );
        self.owner setscriptablepartstate( #"hash_fa086db745e2c53e", #"jammed", 0 );
        self setscriptablepartstate( #"hacked", #"active", 0 );
        self.modifiedspeedscale = speedscale;
        
        if ( self.streakinfo.bundle.var_fcc724a754f5b217 )
        {
            function_cff6edcf3007e1a4( 1 );
        }
        
        return;
    }
    
    if ( prevcounter > 0 && self.disruptcounter == 0 )
    {
        self.owner emp_debuff::clear_emp_scramble();
        self.owner setscriptablepartstate( #"hash_fa086db745e2c53e", #"off", 0 );
        self setscriptablepartstate( #"hacked", #"off", 0 );
        self.modifiedspeedscale = undefined;
        
        if ( self.streakinfo.bundle.var_fcc724a754f5b217 )
        {
            function_cff6edcf3007e1a4( -1 );
        }
    }
}

// Namespace skybreak
// Params 1
// Checksum 0x6d18ee20, Offset: 0x85a
// Size: 0x306
function function_afc5638c562d8984( streakinfo )
{
    bundle = streakinfo.bundle;
    
    if ( level.killstreaktriggeredfunc )
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
    
    killstreak_utility::function_7ab4bfe11ada17a( bundle );
    deployweaponobj = makeweapon( bundle.deployweaponname ?? "ks_remote_device_mp" );
    val::group_set( "skybreak_deploy", 0 );
    self function_134cd2c60d3a7edf( 0 );
    killstreak_shared::starttabletscreen( streakinfo.streakname, 0.05, 1 );
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &function_4eafb9f6c40ab8b8, &function_299a22cf1dafbd20 );
    
    if ( !deployresult || level.gameended )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        val::group_reset( "skybreak_deploy" );
        self function_134cd2c60d3a7edf( 1 );
        return 0;
    }
    
    player::_freezecontrols( 1, undefined, "skybreak" );
    streakinfo.streakduration = bundle.skybreakduration ?? 50;
    
    if ( level.killstreakbeginusefunc )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            player::_freezecontrols( 0, 1, "skybreak" );
            vehicle_tracking::function_4f76f5b4541acef1();
            self setclientomnvar( o"ui_using_killstreak_remote", 0 );
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            val::group_reset( "skybreak_deploy" );
            self function_134cd2c60d3a7edf( 1 );
            return 0;
        }
    }
    
    [ startpos, var_12cae67242408ed9 ] = function_2ee02f7fbde1d37d( bundle );
    skybreakvehicle = skybreak_vehicle_create( startpos, streakinfo, var_12cae67242408ed9 );
    
    if ( !skybreakvehicle )
    {
        player::_freezecontrols( 0, 1, "skybreak" );
        self setclientomnvar( o"ui_using_killstreak_remote", 0 );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        val::group_reset( "skybreak_deploy" );
        self function_134cd2c60d3a7edf( 1 );
        return 0;
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( isdefined( level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ] ) )
    {
        self [[ level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ] ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"use", 1, var_65934120c2efeb81 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( bundle.usedsplashref, self );
    }
    
    result = skybreakvehicle skybreak_start();
    player::_freezecontrols( 0, 1, "skybreak" );
    return result;
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x8a6ec01b, Offset: 0xb69
// Size: 0x1ad
function private function_2ee02f7fbde1d37d( bundle )
{
    var_198894386c20aa7 = bundle.var_34053aafce160641 ?? 5000;
    var_9e16db8718912c7b = bundle.var_db20f8a3c081ecd5 ?? 1000;
    var_e2a8aca9068a62f2 = [];
    
    foreach ( skybreakinstance in level.skybreakinstances )
    {
        if ( skybreakinstance.isdestroyed )
        {
            continue;
        }
        
        var_e2a8aca9068a62f2[ var_e2a8aca9068a62f2.size ] = skybreakinstance.var_12cae67242408ed9;
    }
    
    newheight = var_198894386c20aa7;
    
    foreach ( height in arraysort( var_e2a8aca9068a62f2 ) )
    {
        if ( newheight + var_9e16db8718912c7b <= height )
        {
            break;
        }
        
        newheight = height + var_9e16db8718912c7b;
    }
    
    if ( newheight > 10000 )
    {
        assertmsg( "<dev string:x81>" );
        newheight = 10000;
    }
    
    spawnpos = level.mapcenter;
    spawnpos += ( 0, 0, newheight );
    return [ spawnpos, newheight ];
}

// Namespace skybreak
// Params 1
// Checksum 0xf16edff0, Offset: 0xd1f
// Size: 0xe, Type: bool
function function_4eafb9f6c40ab8b8( streakinfo )
{
    return true;
}

// Namespace skybreak
// Params 2
// Checksum 0xab1d372b, Offset: 0xd36
// Size: 0x28
function function_299a22cf1dafbd20( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread function_d72a7323c0823568( 1.3, streakinfo );
    }
}

// Namespace skybreak
// Params 2, eflags: 0x4
// Checksum 0xc6d972c6, Offset: 0xd66
// Size: 0xe7
function private function_d72a7323c0823568( delay, streakinfo )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death", #"disconnect" );
    bundle = streakinfo.bundle;
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( bundle.var_8b43cd747014ec7e )
    {
        thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
    }
    else if ( bundle.var_7afc6ae2d920753d )
    {
        if ( bundle.var_d09f98defa2e28d1 )
        {
            self playlocalsound( bundle.var_d09f98defa2e28d1 );
        }
        
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( { #postfxbundlename:bundle.var_7afc6ae2d920753d } );
    }
    
    self notify( #"skybreak_transition_in" );
}

// Namespace skybreak
// Params 3, eflags: 0x4
// Checksum 0x6c6ccb55, Offset: 0xe55
// Size: 0x354
function private skybreak_vehicle_create( startpos, streakinfo, var_12cae67242408ed9 )
{
    bundle = streakinfo.bundle;
    vehicle_tracking::function_4f76f5b4541acef1();
    spawndata = { #initialvelocity:( 0, 0, 0 ), #owner:self, #vehicletype:bundle.skybreakvehicle, #targetname:"script_vehicle", #modelname:bundle.skybreakmodel, #angles:( 0, 0, 0 ), #origin:startpos };
    skybreakvehicle = vehicle_tracking::spawn_vehicle( spawndata );
    
    if ( !skybreakvehicle )
    {
        thread utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
        utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return;
    }
    
    skybreakvehicle setnodeploy( 1 );
    maxhealth = bundle.maxhealth ?? 2000;
    skybreakvehicle.health = maxhealth;
    skybreakvehicle.maxhealth = maxhealth;
    skybreakvehicle.currenthealth = maxhealth;
    skybreakvehicle.angles = ( 0, 0, 0 );
    skybreakvehicle.owner = self;
    skybreakvehicle.team = self.team;
    skybreakvehicle.teamfriendlyto = self.team;
    skybreakvehicle.streakinfo = streakinfo;
    skybreakvehicle.isdestroyed = 0;
    skybreakvehicle.timeout = streakinfo.streakduration;
    skybreakvehicle.var_12cae67242408ed9 = var_12cae67242408ed9;
    
    /#
        if ( getdvarint( @"hash_2c01d701bac5d9d3", 0 ) )
        {
            skybreakvehicle.timeout = 9999;
        }
    #/
    
    skybreakvehicle setvehicleteam( self.team );
    skybreakvehicle setotherent( self );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        skybreakvehicle [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1 );
    }
    
    skybreakvehicle namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"hash_c7dd3b1e5f56057a", skybreakvehicle.origin, skybreakvehicle.team, skybreakvehicle.owner, skybreakvehicle );
    vehicle_tracking::register_instance( skybreakvehicle, skybreakvehicle.owner, skybreakvehicle.owner.team );
    vehicle_occupancy::register_instance( skybreakvehicle );
    skybreakvehicle function_620ea4f7a46db56a();
    skybreakvehicle function_d2b8ee2e1275daaf( 1 );
    skybreakvehicle function_6a4bed1cbdcc8027( 10000 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        skybreakvehicle [[ var_32dbca3143d9c4a5 ]]( 0, 0, 0 );
    }
    
    level.skybreakinstances[ level.skybreakinstances.size ] = skybreakvehicle;
    return skybreakvehicle;
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x4b2341ac, Offset: 0x11b2
// Size: 0xe9
function private function_ff66b63cb9e56198()
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death" );
    self setscriptablepartstate( #"body_visibility", #"hidden", 0 );
    self setscriptablepartstate( #"fx", #"hidden", 0 );
    self setscriptablepartstate( #"body_transition", #"intro_pre_init", 0 );
    wait 2;
    self setscriptablepartstate( #"body_visibility", #"visible", 0 );
    self setscriptablepartstate( #"fx", #"idle", 0 );
    
    if ( !self.streakinfo.bundle.var_fcc724a754f5b217 )
    {
        self setscriptablepartstate( #"body_transition", #"hash_abc92642a5a0dfd2", 0 );
    }
    
    self notify( #"skybreak_intro_sequence_finished" );
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x983665b2, Offset: 0x12a3
// Size: 0xf1, Type: bool
function private skybreak_start()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    thread function_ff66b63cb9e56198();
    msg = self.owner utility::waittill_any_return( "skybreak_transition_in", "death" );
    
    if ( msg != "skybreak_transition_in" )
    {
        thread function_e069e8170c61c970();
        return false;
    }
    
    function_88ad3ccaf9be8e18();
    thread function_7f3fc4061662bfba();
    thread function_e271a8d8ba49f334();
    thread function_1b825cc35f4fbc41();
    thread function_3152696e7ecb6a33();
    thread function_f8ae929f35c4b04b();
    bundle = self.streakinfo.bundle;
    
    if ( bundle.var_cf81133380510462 )
    {
        thread function_a3eac34f90c4a3c1();
        thread function_e1d3533715070bac();
    }
    
    if ( bundle.var_fcc724a754f5b217 )
    {
        thread function_a42bfa7cd503d8e1();
    }
    
    return true;
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xf43b1a15, Offset: 0x139d
// Size: 0x39
function private function_88ad3ccaf9be8e18()
{
    function_30ff31fa0c9487f0();
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    function_e665fefd85f348b7();
    function_93ae976ec6cd0cd2();
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x6561fdeb, Offset: 0x13de
// Size: 0x16a
function private function_93ae976ec6cd0cd2()
{
    self setcandamage( 1 );
    scorepopup = "destroyed_" + "skybreak";
    vodestroyed = "skybreak" + "_destroyed";
    destroyedsplash = "callout_destroyed_" + "skybreak";
    premoddamagecallback = &function_4a55d2d6384bf6d5;
    postmoddamagecallback = &function_4ad23772f55098;
    deathcallback = &function_e069e8170c61c970;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( "skybreak", self, scorepopup, vodestroyed, destroyedsplash, undefined, undefined, premoddamagecallback, postmoddamagecallback, deathcallback );
    bundle = self.streakinfo.bundle;
    lightdamagethreshold = ( bundle.var_97b1249f6f88defd ?? 0.75 ) * self.maxhealth;
    mediumdamagethreshold = ( bundle.var_cb76792c0608a432 ?? 0.5 ) * self.maxhealth;
    heavydamagethreshold = ( bundle.var_4f2619ff6aef6322 ?? 0.25 ) * self.maxhealth;
    assert( lightdamagethreshold > mediumdamagethreshold && mediumdamagethreshold > heavydamagethreshold, "<dev string:xd8>" );
    killstreak_utility::function_b555369eba6b0252( 1, lightdamagethreshold, &function_bf5c314d90896275 );
    killstreak_utility::function_b555369eba6b0252( 2, mediumdamagethreshold, &function_b01d88a9452d57a6 );
    killstreak_utility::function_b555369eba6b0252( 3, heavydamagethreshold, &function_ae84a9e985f96e5c );
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xc8d2b310, Offset: 0x1550
// Size: 0xcc, Type: bool
function private function_4a55d2d6384bf6d5( damagedata )
{
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = self.streakinfo.bundle;
        damagedata.iskillstreak = 1;
        damagedata.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( damagedata.attacker, damagedata.objweapon, damagedata.meansofdeath, damagedata.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, damagedata );
    }
    
    return true;
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x95e04532, Offset: 0x1625
// Size: 0x3c, Type: bool
function private function_4ad23772f55098( damagedata )
{
    self.currenthealth -= damagedata.damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x942c608d, Offset: 0x166a
// Size: 0x1b
function private function_bf5c314d90896275()
{
    self setscriptablepartstate( #"body_damage_light", #"on", 0 );
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xef39dee6, Offset: 0x168d
// Size: 0x1b
function private function_b01d88a9452d57a6()
{
    self setscriptablepartstate( #"body_damage_medium", #"on", 0 );
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x21480053, Offset: 0x16b0
// Size: 0x3f
function private function_ae84a9e985f96e5c()
{
    self setscriptablepartstate( #"body_damage_heavy", #"on", 0 );
    
    if ( self.owner )
    {
        self.owner setclienttriggeraudiozone( "kls_sat_skybreak_damaged", 0.5 );
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xbb86117d, Offset: 0x16f7
// Size: 0x179
function private function_e665fefd85f348b7()
{
    if ( !level.skybreakmapbounds )
    {
        worldbounds = getnavbounds();
        worldmidpoint = worldbounds.midpoint;
        var_41642016dd09f4ff = int( worldbounds.halfsize[ 0 ] );
        var_f2ab902bc98cc80 = int( worldbounds.halfsize[ 1 ] );
        buffer = self.streakinfo.bundle.var_27e85bbb5517de6b ?? 1000;
        level.skybreakmapbounds = { #var_f7dad9487a0a9b9c:worldmidpoint + ( var_41642016dd09f4ff * -1 - buffer, var_f2ab902bc98cc80 * -1 - buffer, 0 ), #var_f7dad8487a0a9969:worldmidpoint + ( var_41642016dd09f4ff + buffer, var_f2ab902bc98cc80 * -1 - buffer, 0 ), #outercornerb:worldmidpoint + ( var_41642016dd09f4ff + buffer, var_f2ab902bc98cc80 + buffer, 0 ), #outercornera:worldmidpoint + ( var_41642016dd09f4ff * -1 - buffer, var_f2ab902bc98cc80 + buffer, 0 ), #var_29827dae51b7c7cd:worldmidpoint + ( var_41642016dd09f4ff * -1, var_f2ab902bc98cc80 * -1, 0 ), #var_298276ae51b7b868:worldmidpoint + ( var_41642016dd09f4ff, var_f2ab902bc98cc80 * -1, 0 ), #innercornerb:worldmidpoint + ( var_41642016dd09f4ff, var_f2ab902bc98cc80, 0 ), #innercornera:worldmidpoint + ( var_41642016dd09f4ff * -1, var_f2ab902bc98cc80, 0 ), #offsetbuffer:buffer, #midpoint:( worldmidpoint[ 0 ], worldmidpoint[ 1 ], 0 ) };
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xf3aacd3a, Offset: 0x1878
// Size: 0x40b
function private function_1b825cc35f4fbc41()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    var_64995079a0bda966 = self function_7fcf4bbd01d894de();
    epsilon = 1.19209e-07;
    var_a83718a4f78a6dc3 = 0.001;
    var_9d8e288d4d2a1acf = 1 / ( level.framedurationseconds ?? 0.016 );
    var_b7c3e451da78ea5d = level.skybreakmapbounds.offsetbuffer / 63360;
    acceleration = ( squared( var_64995079a0bda966 ) - squared( var_a83718a4f78a6dc3 ) ) / 2 * var_b7c3e451da78ea5d / 3600 * var_9d8e288d4d2a1acf;
    
    while ( true )
    {
        var_b144eeece46c4bc4 = self function_7fcf4bbd01d894de();
        var_99fe855ad95af888 = self.modifiedspeedscale ? var_64995079a0bda966 * self.modifiedspeedscale : var_64995079a0bda966;
        
        if ( utility::function_f1534d42bbbf62e( self.origin, level.skybreakmapbounds.innercornera, level.skybreakmapbounds.innercornerb, level.skybreakmapbounds.var_29827dae51b7c7cd ) )
        {
            if ( var_b144eeece46c4bc4 != var_99fe855ad95af888 )
            {
                self function_5a9a3101070af0ea( var_99fe855ad95af888 );
            }
        }
        else
        {
            if ( utility::function_f1534d42bbbf62e( self.origin, level.skybreakmapbounds.outercornera, level.skybreakmapbounds.outercornerb, level.skybreakmapbounds.var_f7dad9487a0a9b9c ) )
            {
                var_8b7d7c7047eb577a = level.skybreakmapbounds.midpoint - self.origin;
                movingdirection = self vehicle_getvelocity();
                dot = vectordot2( movingdirection, var_8b7d7c7047eb577a, 1 );
                
                if ( dot > epsilon )
                {
                    newspeed = min( var_b144eeece46c4bc4 + acceleration, var_99fe855ad95af888 );
                }
                else
                {
                    newspeed = max( var_b144eeece46c4bc4 - acceleration, var_a83718a4f78a6dc3 );
                }
            }
            else
            {
                newspeed = var_a83718a4f78a6dc3;
            }
            
            if ( newspeed != var_b144eeece46c4bc4 )
            {
                self function_5a9a3101070af0ea( newspeed );
            }
        }
        
        /#
            if ( getdvarint( @"hash_291fb002facfb96", 0 ) )
            {
                line( level.skybreakmapbounds.innercornera, level.skybreakmapbounds.innercornerb, ( 0, 255, 0 ) );
                line( level.skybreakmapbounds.innercornerb, level.skybreakmapbounds.var_298276ae51b7b868, ( 0, 255, 0 ) );
                line( level.skybreakmapbounds.var_298276ae51b7b868, level.skybreakmapbounds.var_29827dae51b7c7cd, ( 0, 255, 0 ) );
                line( level.skybreakmapbounds.var_29827dae51b7c7cd, level.skybreakmapbounds.innercornera, ( 0, 255, 0 ) );
                line( level.skybreakmapbounds.outercornera, level.skybreakmapbounds.outercornerb, ( 255, 0, 0 ) );
                line( level.skybreakmapbounds.outercornerb, level.skybreakmapbounds.var_f7dad8487a0a9969, ( 255, 0, 0 ) );
                line( level.skybreakmapbounds.var_f7dad8487a0a9969, level.skybreakmapbounds.var_f7dad9487a0a9b9c, ( 255, 0, 0 ) );
                line( level.skybreakmapbounds.var_f7dad9487a0a9b9c, level.skybreakmapbounds.outercornera, ( 255, 0, 0 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x4cc9e777, Offset: 0x1c8b
// Size: 0x2b6
function private function_30ff31fa0c9487f0()
{
    bundle = self.streakinfo.bundle;
    var_cd54d50998b40567 = { #var_add2dd471396e6f9:[ "specialty_hack_immunity" ], #var_de21f97c06719266:undefined, #var_b837f83cb74d3833:1, #var_35a846a6bc3711bd:self.streakinfo.streakduration };
    self.owner player::setusingremote( self.streakinfo.streakname, 1, 1, var_cd54d50998b40567 );
    self.owner val::group_set( "skybreak_use", 0 );
    self.owner.restoreangles = self.owner.angles;
    self.owner setplayerangles( self.angles );
    self.owner usevehicle( self, 0 );
    killstreak_utility::movingplatform_playerlink( self.owner );
    self.owner killstreak_shared::function_9fc2f7ee10890d99( self.streakinfo.streakname );
    self.owner setclientomnvar( o"ui_killstreak_health", 1 );
    self.owner painvisionoff();
    self.owner killstreak_shared::killstreak_savenvgstate();
    thread function_37b30f74fb1203a3( self.owner, self.timeout, 0 );
    thread function_74d189775afc4060( 0.6 );
    alertfulllength = self.timeout / 4;
    var_c3193942aa25f78 = 0.25;
    var_28e5801bce7f4815 = 0.65;
    var_b84c3eae995cb030 = 0.001;
    var_ed6c729701a7f3ed = 0.05;
    endtime = gettime() + utility::function_4b74c15943231980( self.timeout );
    thread killstreak_shared::function_585fb909f40d8659( endtime, alertfulllength, var_c3193942aa25f78, var_28e5801bce7f4815, var_b84c3eae995cb030, var_ed6c729701a7f3ed );
    self.owner killstreak_shared::function_2f6864f010a9890d( { #var_b7a68f2e2c6a8ba1:self, #bundle:bundle } );
    self.playersfx = spawn( "script_origin", self.origin );
    self.playersfx showonlytoplayer( self.owner );
    self.playersfx linkto( self );
    self.owner setclienttriggeraudiozone( "kls_sat_skybreak", 0.5 );
    
    if ( bundle.var_da83886af12f3ecc )
    {
        self.owner ai::set_ignoreme( 1 );
    }
    
    self.ispiloted = 1;
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x8b1a5c6a, Offset: 0x1f49
// Size: 0x29c
function private function_c2888db9fd5d88e()
{
    self notify( #"hash_e2f8b9fb37bb5cf0" );
    self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( !self.owner || !self.ispiloted )
    {
        return;
    }
    
    if ( self.owner isvehicleactive() )
    {
        self.owner leavevehicle( 0 );
    }
    
    self.owner player::clearusingremote( 1 );
    self.owner val::group_reset( "skybreak_use" );
    self.owner val::group_reset( "skybreak_deploy" );
    killstreak_utility::movingplatform_playerunlink( self.owner );
    level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self.owner );
    self.owner thread killstreak_shared::function_b3302c4317df36c6();
    self.owner ai::set_ignoreme( 0 );
    
    if ( self.playersfx )
    {
        self.playersfx delete();
    }
    
    self.owner clearclienttriggeraudiozone( 0.5 );
    bundle = self.streakinfo.bundle;
    self.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( { #postfxbundlename:bundle.var_c379e3aef2bbc30e } );
    self.owner painvisionon();
    self.owner killstreak_shared::function_76bbbe12ce816ed2();
    self.owner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "skybreak", "off" );
    self.owner killstreak_shared::killstreak_restorenvgstate();
    bundle = self.streakinfo.bundle;
    
    if ( bundle.var_d30c20664d0c31fd )
    {
        self.owner thread killstreak_utility::function_7018f59706013760( bundle );
    }
    else
    {
        if ( bundle.var_d8ddf669bf22ef2a )
        {
            self.owner playlocalsound( bundle.var_d8ddf669bf22ef2a );
        }
        
        self.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( {} );
        
        if ( bundle.var_3813167e0e3c702 )
        {
            self.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( { #postfxbundlename:bundle.var_3813167e0e3c702 } );
        }
    }
    
    self.owner function_134cd2c60d3a7edf( 1 );
    self.ispiloted = 0;
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x78e7c943, Offset: 0x21ed
// Size: 0x35
function private function_74d189775afc4060( delay )
{
    wait delay;
    
    if ( self.owner )
    {
        self.owner namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "skybreak", "on" );
    }
}

// Namespace skybreak
// Params 3, eflags: 0x4
// Checksum 0x7452651b, Offset: 0x222a
// Size: 0xe0
function private function_37b30f74fb1203a3( owner, lifetime, infinite )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    level endon( #"game_ended", #"round_end" );
    
    if ( infinite || !isdefined( lifetime ) || lifetime <= 0 )
    {
        owner setclientomnvar( o"ui_killstreak_lifetime", 1 );
        return;
    }
    
    lifetimems = lifetime * 1000;
    endtimems = gettime() + lifetimems;
    
    while ( true )
    {
        timeleftms = endtimems - gettime();
        
        if ( timeleftms <= 0 )
        {
            owner setclientomnvar( o"ui_killstreak_lifetime", 0 );
            break;
        }
        
        owner setclientomnvar( o"ui_killstreak_lifetime", timeleftms / lifetimems );
        waitframe();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x3af706fb, Offset: 0x2312
// Size: 0x7f
function private function_3152696e7ecb6a33()
{
    self endon( #"death" );
    thread utility::callsharedfunc( #"killstreak", #"allowridekillstreakplayerexit", "leaving" );
    utility::function_f755811828e739dd( self.timeout, self.owner, "disconnect", self.owner, "joined_team", self.owner, "joined_spectators", level, "game_ended", level, "round_end", self, "killstreakExit" );
    thread function_e069e8170c61c970();
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x6c8203f3, Offset: 0x2399
// Size: 0x113
function private function_e271a8d8ba49f334()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death", #"hash_e2f8b9fb37bb5cf0" );
    bundle = self.streakinfo.bundle;
    var_490710493c595f57 = ( bundle.var_e875672a473a391c ?? 3 ) * 1000;
    
    if ( var_490710493c595f57 <= 0 )
    {
        return;
    }
    
    self.var_d38698971ffc5b5e = 0;
    self.var_fe006ee7f5ed99de = 0;
    var_f32284186f7cd01b = -1;
    
    while ( true )
    {
        timeremainingsec = max( 0, ( ( self.var_d38698971ffc5b5e ?? 0 ) - gettime() ) * 0.001 );
        
        if ( timeremainingsec != var_f32284186f7cd01b )
        {
            progress = 1 - timeremainingsec / var_490710493c595f57 * 0.001;
            self.owner setclientomnvar( o"hash_89b55795eae02ac3", progress );
        }
        
        var_f32284186f7cd01b = timeremainingsec;
        waitframe();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xfc00a1f2, Offset: 0x24b4
// Size: 0x137
function private function_e1d3533715070bac()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death", #"hash_e2f8b9fb37bb5cf0" );
    bundle = self.streakinfo.bundle;
    var_c912a8669935421b = ( bundle.var_27eed8f59f3dcc69 ?? 10 ) * 1000;
    
    if ( var_c912a8669935421b <= 0 )
    {
        return;
    }
    
    self.var_7ec256656c4a822a = 0;
    self.var_bbad8b4f584550ca = 0;
    self.owner setclientomnvar( o"hash_dceb5d1476a2f3bc", 0 );
    var_f32284186f7cd01b = -1;
    
    while ( true )
    {
        timeremainingsec = max( 0, ( ( self.var_7ec256656c4a822a ?? 0 ) - gettime() ) * 0.001 );
        
        if ( timeremainingsec != var_f32284186f7cd01b )
        {
            progress = 1 - timeremainingsec / var_c912a8669935421b * 0.001;
            self.owner setclientomnvar( o"hash_5d3eec7eed56dcef", progress == 1 ? 0 : progress );
        }
        
        var_f32284186f7cd01b = timeremainingsec;
        waitframe();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x5a109adb, Offset: 0x25f3
// Size: 0x42f
function private function_7f3fc4061662bfba()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self.owner notifyonplayercommand( "skybreak_fire", "+attack" );
    bundle = self.streakinfo.bundle;
    weapon = makeweapon( bundle.var_20d9c380afa10256 );
    launchoffset = ( bundle.var_2546695385c47462 ?? 0, bundle.var_25466a5385c47695 ?? 0, bundle.var_2546675385c46ffc ?? 0 );
    var_72f10ed8d403b48d = bundle.var_cf81133380510462 ? ( bundle.var_739ef86ce2700862 ?? 3 ) * 1000 : 0;
    var_490710493c595f57 = ( bundle.var_e875672a473a391c ?? 3 ) * 1000;
    var_5fbf3f7506c46f93 = ( bundle.var_d837e36d51d856fa ?? 0, bundle.var_d837e46d51d8592d ?? 0, bundle.var_d837e16d51d85294 ?? -300 );
    var_a4469d573a02a7a4 = bundle.var_81b966813cfb7ca8 ?? 0.2;
    self.var_c8fc459ce68936be = 0;
    self.var_d9dad5f970b5acdc = 0;
    
    if ( bundle.var_7c1f5e38045e18f > 0 )
    {
        self.ammocount = bundle.var_7c1f5e38045e18f;
        haslimitedammo = 1;
        self.owner setclientomnvar( "ui_veh_ammo_1", self.ammocount );
    }
    
    while ( true )
    {
        self.owner waittill( #"skybreak_fire" );
        
        if ( haslimitedammo && self.ammocount <= 0 )
        {
            if ( self.streakinfo.bundle.var_33172055fa0fb722 )
            {
                self.owner playlocalsound( self.streakinfo.bundle.var_33172055fa0fb722 );
            }
            
            continue;
        }
        
        /#
            function_d5c13c07df23f34b();
        #/
        
        currenttime = gettime();
        
        if ( currenttime < self.var_c8fc459ce68936be || currenttime < self.var_d9dad5f970b5acdc )
        {
            continue;
        }
        
        launchpos = self gettagorigin( "tag_barrel" ) + launchoffset;
        launchvelocity = var_5fbf3f7506c46f93 + self vehicle_getvelocity() * var_a4469d573a02a7a4;
        missile = self.owner namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( weapon, launchpos, launchvelocity, undefined, 1 );
        
        if ( missile )
        {
            self.var_c8fc459ce68936be = currenttime + var_72f10ed8d403b48d;
            self.var_d9dad5f970b5acdc = currenttime + var_490710493c595f57;
            self.var_d38698971ffc5b5e = max( self.var_c8fc459ce68936be, self.var_d9dad5f970b5acdc );
            
            if ( bundle.var_cf81133380510462 )
            {
                self.var_7ec256656c4a822a = max( self.var_7ec256656c4a822a, self.var_c8fc459ce68936be );
            }
            
            self.var_fe006ee7f5ed99de = self.var_d38698971ffc5b5e - currenttime;
            self.owner earthquakeforplayer( bundle.var_f6569a26973b0ac1 ?? 0.1, bundle.var_3de85d18f517591d ?? 0.3, self.origin, bundle.var_dcabd22d70b11b03 ?? 500 );
            missile.launchpos = launchpos;
            missile.launchvelocity = launchvelocity;
            function_82fb2d49476f0156( missile );
            missile thread function_d9786163e48580cb();
            
            if ( haslimitedammo )
            {
                self.ammocount--;
                self.owner setclientomnvar( "ui_veh_ammo_1", self.ammocount );
                
                if ( self.ammocount <= 0 )
                {
                    if ( bundle.var_68ccd0148f94845d )
                    {
                        thread function_e069e8170c61c970();
                        return;
                    }
                    else
                    {
                        continue;
                    }
                }
            }
            
            thread function_36241c36956ca2fd( var_490710493c595f57 * 0.001 );
        }
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xb60a21f9, Offset: 0x2a2a
// Size: 0xda
function private function_36241c36956ca2fd( missilecooldown )
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    
    if ( self.streakinfo.bundle.var_f95e62c396545186 )
    {
        self.owner playlocalsound( self.streakinfo.bundle.var_f95e62c396545186 );
    }
    
    wait missilecooldown;
    
    if ( self.streakinfo.bundle.var_899333ac962fab3c )
    {
        self.owner playlocalsound( self.streakinfo.bundle.var_899333ac962fab3c );
    }
}

// Namespace skybreak
// Params 0
// Checksum 0x4cb69d4c, Offset: 0x2b0c
// Size: 0xb4
function function_f8ae929f35c4b04b()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( #"round_end" );
    currentfov = self.owner playerads();
    self.owner setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
    
    while ( true )
    {
        var_fa3b8d0109b9108f = self.owner playerads();
        
        if ( var_fa3b8d0109b9108f != currentfov )
        {
            currentfov = var_fa3b8d0109b9108f;
            self.owner setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
        }
        
        waitframe();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x8f04c104, Offset: 0x2bc8
// Size: 0x2d4
function private function_a3eac34f90c4a3c1()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !level callback::exists( #"hash_c0e3f7df1c23e95f", &function_58f04f2a7c2ca2bc ) )
    {
        level callback::add( #"hash_c0e3f7df1c23e95f", &function_58f04f2a7c2ca2bc );
    }
    
    thread function_71cd6d87c524c55d();
    self.owner notifyonplayercommand( "skybreak_radar_ping", "+smoke" );
    bundle = self.streakinfo.bundle;
    var_72f10ed8d403b48d = ( bundle.var_739ef86ce2700862 ?? 3 ) * 1000;
    var_c912a8669935421b = ( bundle.var_27eed8f59f3dcc69 ?? 10 ) * 1000;
    var_cea01fea2acf2763 = int( bundle.var_ed5c62eae4089e97 ?? 1000 );
    var_aad232af8e5db622 = int( ( bundle.var_70e8578aa9f05ff7 ?? 1.5 ) * 1000 );
    var_ea8a4da1ab310f9f = int( bundle.var_272111447ab1c6bb ?? -1 );
    var_b280259d963f712 = bundle.var_9b385c46cd9601be ?? -1;
    var_e1d4fd77260a6215 = bundle.var_ed4c85d0cb6e2d9 ?? -1;
    self.var_c8fc459ce68936be = 0;
    self.var_dd7dfa429d087208 = 0;
    
    while ( true )
    {
        if ( isbot( self.owner ) )
        {
            waitframe();
        }
        else
        {
            self.owner waittill( #"skybreak_radar_ping" );
        }
        
        currenttime = gettime();
        
        if ( currenttime < self.var_c8fc459ce68936be || currenttime < self.var_dd7dfa429d087208 )
        {
            continue;
        }
        
        self.var_c8fc459ce68936be = currenttime + var_72f10ed8d403b48d;
        self.var_dd7dfa429d087208 = currenttime + var_c912a8669935421b;
        self.var_7ec256656c4a822a = max( self.var_c8fc459ce68936be, self.var_dd7dfa429d087208 );
        
        if ( isdefined( self.var_d38698971ffc5b5e ) )
        {
            self.var_d38698971ffc5b5e = max( self.var_d38698971ffc5b5e, self.var_c8fc459ce68936be );
        }
        
        self.var_bbad8b4f584550ca = self.var_7ec256656c4a822a - currenttime;
        
        if ( bundle.var_d60c9cb56ef33874 )
        {
            self.owner playlocalsound( bundle.var_d60c9cb56ef33874 );
        }
        
        thread function_a42acfc49e1d46a9();
        triggerportableradarpingteam( self.origin, self.team, var_cea01fea2acf2763, var_aad232af8e5db622, var_ea8a4da1ab310f9f, var_b280259d963f712, var_e1d4fd77260a6215, 1, self.owner, 0, !isdefined( bundle.var_3abd1378e8dfc2a5 ), 1, 1 );
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x14d4a1b1, Offset: 0x2ea4
// Size: 0x74
function private function_a42acfc49e1d46a9()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death", #"hash_e2f8b9fb37bb5cf0" );
    self.owner setclientomnvar( o"hash_dceb5d1476a2f3bc", 1 );
    wait 1;
    self.owner setclientomnvar( o"hash_dceb5d1476a2f3bc", 0 );
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x61783649, Offset: 0x2f20
// Size: 0x314
function private function_71cd6d87c524c55d()
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    bundle = self.streakinfo.bundle;
    var_eccff8899f017d1b = bundle.var_9ed3ca4cb653125b ?? 3;
    var_bd76421b4e2d546e = function_1bf3a084cfe14025( 20 );
    self.var_642041f4e49be3cb = [];
    self.var_b6a88905a41c3e91 = [];
    assert( bundle.var_3abd1378e8dfc2a5 );
    
    while ( true )
    {
        playsfx = undefined;
        self.owner waittill( #"hash_467ae620d091a892", enemies );
        
        if ( !isarray( enemies ) )
        {
            continue;
        }
        
        foreach ( enemy in enemies )
        {
            if ( !enemy || !isdefined( enemy.origin ) )
            {
                continue;
            }
            
            if ( enemy isplayerghost() )
            {
                continue;
            }
            
            if ( !isdefined( enemy.var_9e243339d0f01aa ) )
            {
                enemy.var_9e243339d0f01aa = [];
            }
            
            enemy.var_9e243339d0f01aa[ enemy.var_9e243339d0f01aa.size ] = self.owner;
            
            if ( !enemy callback::exists( #"player_death", &function_574cc61beac179da ) )
            {
                enemy callback::add( #"player_death", &function_574cc61beac179da );
            }
            
            enemyentnum = enemy.entnum ?? utility::get_entity_number( enemy );
            var_e77c347cbd6e6883 = self.var_b6a88905a41c3e91[ enemyentnum ];
            
            if ( !isdefined( var_e77c347cbd6e6883.pingindex ) )
            {
                pingindex = self.owner calloutmarkerping::createcallout( var_bd76421b4e2d546e, undefined, enemyentnum );
                
                if ( !isdefined( pingindex ) )
                {
                    assertmsg( "<dev string:x136>" );
                    continue;
                }
                
                playsfx = 1;
                var_e77c347cbd6e6883 = { #pingindex:pingindex, #enemy:enemy };
                self.var_642041f4e49be3cb[ self.var_642041f4e49be3cb.size ] = var_e77c347cbd6e6883;
                self.var_b6a88905a41c3e91[ enemyentnum ] = var_e77c347cbd6e6883;
                
                if ( var_e77c347cbd6e6883.enemy && isdefined( self.owner.enemytargetmarkergroup ) )
                {
                    targetmarkergroupsetextrastate( self.owner.enemytargetmarkergroup, var_e77c347cbd6e6883.enemy, 1 );
                }
            }
            
            thread function_1635c3e3459208e9( enemyentnum, var_eccff8899f017d1b );
        }
        
        if ( playsfx )
        {
            self.owner playlocalsound( bundle.var_3abd1378e8dfc2a5 );
        }
    }
}

// Namespace skybreak
// Params 2, eflags: 0x4
// Checksum 0xe2f1997b, Offset: 0x323c
// Size: 0x1c9
function private function_1635c3e3459208e9( enemyentnum, durationsec )
{
    level endon( #"game_ended", #"round_end" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    var_fb797494ef536192 = hashcat( #"hash_268128e174019c6e", enemyentnum );
    self notify( var_fb797494ef536192 );
    self endon( var_fb797494ef536192 );
    pinginfo = self.var_b6a88905a41c3e91[ enemyentnum ];
    pinginfo.enemy utility::waittill_any_timeout( durationsec, "skybreak_pinged_victim_early_timeout" );
    pinginfo = self.var_b6a88905a41c3e91[ enemyentnum ];
    
    if ( isdefined( pinginfo.pingindex ) )
    {
        if ( pinginfo.enemy )
        {
            if ( isarray( pinginfo.enemy.var_9e243339d0f01aa ) && arraycontains( pinginfo.enemy.var_9e243339d0f01aa, self.owner ) )
            {
                pinginfo.enemy.var_9e243339d0f01aa = arrayremove( pinginfo.enemy.var_9e243339d0f01aa, self.owner );
            }
            
            if ( isdefined( self.owner.enemytargetmarkergroup ) )
            {
                targetmarkergroupsetextrastate( self.owner.enemytargetmarkergroup, pinginfo.enemy, 0 );
            }
        }
        
        if ( self.owner )
        {
            self.owner calloutmarkerping::function_7c0ee9d4b604e6d6( pinginfo.pingindex );
        }
        
        self.var_642041f4e49be3cb = arrayremove( self.var_642041f4e49be3cb, pinginfo );
        self.var_b6a88905a41c3e91[ enemyentnum ] = undefined;
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x59d2897d, Offset: 0x340d
// Size: 0x30
function private function_58f04f2a7c2ca2bc( params )
{
    if ( params.player )
    {
        params.player notify( #"skybreak_pinged_victim_early_timeout" );
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x7b8dec55, Offset: 0x3445
// Size: 0xe1
function private function_574cc61beac179da( params )
{
    foreach ( pingowner in self.var_9e243339d0f01aa )
    {
        if ( params.attacker != pingowner )
        {
            pingowner thread points::doscoreevent( #"skybreak_assist" );
        }
    }
    
    self endon( #"disconnect" );
    self.var_9e243339d0f01aa = undefined;
    
    if ( callback::exists( #"player_death", &function_574cc61beac179da ) )
    {
        callback::remove( #"player_death", &function_574cc61beac179da );
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x423b6143, Offset: 0x352e
// Size: 0x472
function private function_82fb2d49476f0156( missile )
{
    missile.streakinfo = self.streakinfo;
    missile.trophy_system_should_ignore = 1;
    missile setentityowner( self.owner );
    missile setotherent( self.owner );
    missile.owner = self.owner;
    missile.team = self.owner.team;
    missile setcandamage( 1 );
    missile.maxhealth = self.streakinfo.bundle.var_f23ad08d9ac199b4 ?? 10;
    missile.health = missile.maxhealth;
    missile thread damage::monitordamage( missile.health, "hitequip", &skybreak_missile_explode );
    missile setmagicgrenadecollision( 0 );
    missile utility::delaycall( 0.1, &setmagicgrenadecollision, 1 );
    contents = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
    ignoreents = [ self, missile ];
    missile.timeouttime = 10;
    missile.targetinfo = utility::function_d0e6aed2d8648374( missile.origin, missile.launchvelocity, undefined, contents, ignoreents, missile.timeouttime );
    minimapicon = self.streakinfo.bundle.var_243e3a20984e46d8;
    
    if ( minimapicon )
    {
        missile.minimapid = missile utility::callsharedfunc( #"game", #"createobjective", minimapicon, missile.team, 0, 1, 1, "icon_medium" );
        
        if ( isdefined( missile.minimapid ) )
        {
            function_38c992e07c477802( missile.minimapid, 1 );
            function_461834c350793158( missile.minimapid, 1 );
            function_46a5a0ae8a411d8d( missile.minimapid, self.streakinfo.bundle.var_b6be9e47d42db49 ?? 10000 );
            function_a9992b78cd05e28b( missile.minimapid, self.streakinfo.bundle.var_743f8fcfa046d18f ?? 10000 );
            function_82408b23a25468f3( missile.minimapid, missile.targetinfo.position );
        }
    }
    
    var_ea23bc6a62838cac = self.streakinfo.bundle.var_b9e08d5b249f8088;
    
    if ( var_ea23bc6a62838cac )
    {
        missile.var_586d82661ee4fcc1 = spawn( "script_model", missile.targetinfo.position );
        
        if ( self.streakinfo.bundle.var_5713ea0b7141ba42 )
        {
            missile.var_586d82661ee4fcc1 setmodel( self.streakinfo.bundle.var_5713ea0b7141ba42 );
        }
        else
        {
            missile.var_586d82661ee4fcc1 setmodel( "tag_origin" );
        }
        
        missile.var_586d82661ee4fcc1 setentityowner( missile.owner );
        missile.var_586d82661ee4fcc1 setotherent( missile.owner );
        missile.var_586d82661ee4fcc1.owner = missile.owner;
        missile thread function_4c37b4d8c6236813( #"hash_f77fab92f729df6d", self.streakinfo.bundle.var_d6e3938ee5ae3e17, self.streakinfo.bundle.var_ee861397806ba0d4 );
        missile thread function_4c37b4d8c6236813( #"hash_6f7b4c4fb460c81e", self.streakinfo.bundle.var_fc62ca52046efac, self.streakinfo.bundle.var_9c40c486aeaade2b );
    }
    
    self.owner killstreak_shared::function_dab42d4ffc561af3( missile, [ "explode" ] );
}

// Namespace skybreak
// Params 3, eflags: 0x4
// Checksum 0x50907615, Offset: 0x39a8
// Size: 0x9f
function private function_4c37b4d8c6236813( partstate, startdelay, duration )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death" );
    
    if ( startdelay )
    {
        wait startdelay;
    }
    
    if ( !self.var_586d82661ee4fcc1 )
    {
        return;
    }
    
    self.var_586d82661ee4fcc1 setscriptablepartstate( partstate, #"on", 0 );
    
    if ( !duration )
    {
        return;
    }
    
    wait duration;
    
    if ( self.var_586d82661ee4fcc1 )
    {
        self.var_586d82661ee4fcc1 setscriptablepartstate( partstate, #"off", 0 );
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xc5c70224, Offset: 0x3a4f
// Size: 0x6e
function private skybreak_missile_explode( damagedata )
{
    if ( isplayer( damagedata.attacker ) && self.owner && player_utility::playersareenemies( self.owner, damagedata.attacker ) )
    {
        damagedata.attacker thread points::doscoreevent( #"hash_fafbff65ea99e48e" );
    }
    
    if ( self )
    {
        self detonate();
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0x6829debe, Offset: 0x3ac5
// Size: 0xf4
function private function_d9786163e48580cb()
{
    level endon( #"game_ended", #"round_end" );
    utility::waittill_any_timeout( self.timeouttime, "explode" );
    bundle = self.streakinfo.bundle;
    earthquake( bundle.var_ce6a91f04611752d ?? 0.3, bundle.var_467ebd89868fb99 ?? 0.5, self.origin, bundle.var_32a5977118d1dd27 ?? 700 );
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            utility::callsharedfunc( #"game", #"returnobjectiveid", self.minimapid );
        }
    }
    
    if ( self.var_586d82661ee4fcc1 )
    {
        self.var_586d82661ee4fcc1 delete();
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xbbb245cf, Offset: 0x3bc1
// Size: 0x27d
function private function_e069e8170c61c970( damagedata )
{
    profilestart();
    
    if ( !self || self.isdestroyed )
    {
        profilestop();
        return;
    }
    
    if ( self.owner )
    {
        self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( damagedata )
    {
        delay = 0.3;
        self setscriptablepartstate( #"explode", #"on", 0 );
        
        if ( self.owner )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed" );
        }
    }
    else
    {
        delay = 0.3;
        self setscriptablepartstate( #"body_transition", #"outro_start", 0 );
    }
    
    level.skybreakinstances = arrayremove( level.skybreakinstances, self );
    function_c2888db9fd5d88e();
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    vehicle_tracking::deregister_instance( self );
    vehicle_occupancy::deregister_instance( self );
    
    if ( level callback::exists( #"hash_c0e3f7df1c23e95f", &function_58f04f2a7c2ca2bc ) )
    {
        level callback::remove( #"hash_c0e3f7df1c23e95f", &function_58f04f2a7c2ca2bc );
    }
    
    foreach ( pinginfo in self.var_642041f4e49be3cb )
    {
        if ( isdefined( self.owner ) && isdefined( pinginfo.pingindex ) )
        {
            self.owner calloutmarkerping::function_7c0ee9d4b604e6d6( pinginfo.pingindex );
        }
    }
    
    self.var_642041f4e49be3cb = [];
    self.var_b6a88905a41c3e91 = [];
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"defender_cleanup" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    self notify( #"death" );
    thread skybreak_vehicle_delete( delay );
    profilestop();
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xfa70be69, Offset: 0x3e46
// Size: 0x1b
function private skybreak_vehicle_delete( delay )
{
    wait delay;
    
    if ( self )
    {
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace skybreak
// Params 0, eflags: 0x4
// Checksum 0xdcf1829b, Offset: 0x3e69
// Size: 0xe6
function private function_a42bfa7cd503d8e1()
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    bundle = self.streakinfo.bundle;
    utility::waittill_any_timeout( 2, "skybreak_intro_sequence_finished" );
    skybreak_active_camo_on( 1 );
    self setscriptablepartstate( #"body_transition", #"hash_abc92642a5a0dfd2", 0 );
    self.var_4e654892b667b9ae = 0;
    breakduration = bundle.var_2016d57f5f20be12 ?? 5;
    
    while ( true )
    {
        utility::waittill_any_ents( self.owner, "skybreak_fire", self, "damage" );
        function_cff6edcf3007e1a4( 1 );
        utility::delaycall( breakduration, &function_cff6edcf3007e1a4, -1 );
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0x5b2aba24, Offset: 0x3f57
// Size: 0xde
function private function_cff6edcf3007e1a4( amount )
{
    if ( !self || self.isdestroyed )
    {
        return;
    }
    
    oldcount = self.var_4e654892b667b9ae;
    self.var_4e654892b667b9ae += amount;
    
    if ( self.var_4e654892b667b9ae < 0 )
    {
        self.var_4e654892b667b9ae = 0;
        assertmsg( "<dev string:x176>" );
    }
    
    if ( oldcount > 0 && self.var_4e654892b667b9ae == 0 )
    {
        skybreak_active_camo_on( 0 );
        self.owner setclientomnvar( o"hash_a46c704d4bf27397", 0 );
        return;
    }
    
    if ( oldcount == 0 && self.var_4e654892b667b9ae > 0 )
    {
        function_8f6d51998128edd4( 0 );
        self.owner setclientomnvar( o"hash_a46c704d4bf27397", 1 );
    }
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xf5500874, Offset: 0x403d
// Size: 0x163
function private skybreak_active_camo_on( immediate )
{
    bundle = self.streakinfo.bundle;
    function_ab8230d40e82bc8f( self );
    
    if ( immediate )
    {
        self setscriptablepartstate( #"active_camo_fx", #"on_final", 0 );
    }
    else
    {
        var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
        var_7a410fddc7930849 = var_c1b0780ae18afce2 && !( var_c1b0780ae18afce2 == #"on" || var_c1b0780ae18afce2 == #"on_final" );
        
        if ( var_7a410fddc7930849 )
        {
            self setscriptablepartstate( #"active_camo_fx", #"on", 0 );
            
            if ( self.owner && bundle.var_a17ef190eb58c756 )
            {
                self.owner playlocalsound( bundle.var_a17ef190eb58c756 );
            }
        }
    }
    
    if ( self.owner )
    {
        self.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( { #postfxbundlename:bundle.var_c379e3aef2bbc30e } );
    }
    
    self setscriptablepartstate( #"fx", #"hidden", 0 );
    killstreak::function_80e13cda8d6717d7( 0 );
    self.var_c3c4d711e69d5ab9 = 1;
}

// Namespace skybreak
// Params 1, eflags: 0x4
// Checksum 0xb7132dff, Offset: 0x41a8
// Size: 0x15c
function private function_8f6d51998128edd4( immediate )
{
    bundle = self.streakinfo.bundle;
    
    if ( immediate )
    {
        self setscriptablepartstate( #"active_camo_fx", #"deactivate_final", 0 );
    }
    else
    {
        var_c1b0780ae18afce2 = self getscriptablepartstate( #"active_camo_fx", 1, 1 );
        var_1aa82dbdaa4abbaa = var_c1b0780ae18afce2 && ( var_c1b0780ae18afce2 == #"on" || var_c1b0780ae18afce2 == #"on_final" );
        
        if ( var_1aa82dbdaa4abbaa )
        {
            self setscriptablepartstate( #"active_camo_fx", #"deactivate", 0 );
            
            if ( self.owner && bundle.var_6e88d62f430d900d )
            {
                self.owner playlocalsound( bundle.var_6e88d62f430d900d );
            }
        }
    }
    
    if ( self.owner )
    {
        self.owner [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( { #postfxbundlename:bundle.var_c379e3aef2bbc30e } );
    }
    
    self setscriptablepartstate( #"fx", #"idle", 0 );
    killstreak::function_80e13cda8d6717d7( 1 );
    self.var_c3c4d711e69d5ab9 = undefined;
}

/#

    // Namespace skybreak
    // Params 0, eflags: 0x4
    // Checksum 0xf9fda8ad, Offset: 0x430c
    // Size: 0x170, Type: dev
    function private function_d5c13c07df23f34b()
    {
        if ( !isbot( self.owner ) || !getdvarint( @"hash_dc4a0e235d5260f", 0 ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                host = player;
                break;
            }
        }
        
        if ( !host )
        {
            return;
        }
        
        angles = host getplayerangles();
        fwd = anglestoforward( angles );
        eye = host geteye();
        end = eye + fwd * 10000;
        trace = trace::ray_trace( eye, end, [ host ] );
        
        if ( !isvector( trace[ "<dev string:x1b4>" ] ) )
        {
            return;
        }
        
        targetpos = ( trace[ "<dev string:x1b4>" ][ 0 ], trace[ "<dev string:x1b4>" ][ 1 ], self.origin[ 2 ] );
        self function_3054541584df8ab4( 1 );
        self vehicle_teleport( targetpos, self.angles );
        waitframe();
        self function_3054541584df8ab4( 0 );
    }

#/
