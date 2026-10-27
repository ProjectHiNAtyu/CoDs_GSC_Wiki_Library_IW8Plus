// scripts\mp\common\killstreaks\killstreakdeploy.gsc  (hash_35ea2ad71d73089b.gscc) (size: 19275 Bytes / 0x4b4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x477382e9 (1198752489)
// size ...... 19275 (0x4b4b)
// includes .. 18  (offset: 0x45b7)
// strings ... 70  (offset: 0x4647)
// dev strs .. 13  (offset: 0x4a63)
// exports ... 37  (offset: 0x2ddb)
// cseg ...... 0x6c4 + 0x2717 (0x2ddb)
// imports ... 145 (offset: 0x33a3)
// animtree1 . 0   (offset: 0x4b1b)
// animtree2 . 3   (offset: 0x4b1b)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\talking_gun;

#namespace killstreakdeploy;

// Namespace killstreakdeploy
// Params 3
// Checksum 0xac00587f, Offset: 0x6e2
// Size: 0x22e, Type: bool
function candeploykillstreak( streakinfo, deployweaponobj, var_9e428c3b74527aba = 1 )
{
    if ( isbrgamemode() )
    {
        if ( level.killstreakrounddelay > 0 )
        {
            if ( isdefined( level.starttime_prematchdone ) )
            {
                timepassed = ( gettime() - level.starttime_prematchdone ) / 1000;
                
                if ( timepassed < level.killstreakrounddelay )
                {
                    var_3ea04ac7d9b90e83 = int( level.killstreakrounddelay - timepassed );
                    utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/unavailable_for_n", var_3ea04ac7d9b90e83 );
                    return false;
                }
            }
        }
    }
    else if ( !killstreak_utility::killstreakcanbeusedatroundstart( streakinfo.streakname ) )
    {
        if ( level.killstreakrounddelay > 0 )
        {
            assert( level.graceperiod >= level.killstreakrounddelay, "<dev string:x24>" + level.graceperiod + "<dev string:x38>" + level.killstreakrounddelay );
            
            if ( level.graceperiod - level.ingraceperiod < level.killstreakrounddelay )
            {
                optionalparam = level.killstreakrounddelay - level.graceperiod - level.ingraceperiod;
                
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/unavailable_for_n", optionalparam );
                }
                
                return false;
            }
        }
    }
    
    if ( isdefined( deployweaponobj ) )
    {
        errormsg = candeploykillstreakweapon( streakinfo, deployweaponobj );
        
        if ( isdefined( errormsg ) )
        {
            if ( streakinfo.streakname == "tacticalCamera" || streakinfo.streakname == "loadout_drop" )
            {
                return false;
            }
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) && var_9e428c3b74527aba )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( errormsg );
            }
            
            return false;
        }
    }
    
    return true;
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x2b2f9a9e, Offset: 0x919
// Size: 0x197
function ondeploystart( streakinfo )
{
    if ( !isdefined( streakinfo ) )
    {
        return;
    }
    
    assert( !streakinfo.isdeploying, "<dev string:x72>" + streakinfo.streakname + "<dev string:x83>" );
    streakinfo.isdeploying = 1;
    streakinfo.owner.isdeploying = 1;
    streakinfo.owner setclientomnvar( "ui_mobile_killstreak_is_deploying", 1 );
    streakinfo.owner thread function_7237fd627c424c4a( streakinfo );
    
    if ( common_inventory::function_5c64d2b24a8c3e18() )
    {
        self.var_70c4022c00e0abb9 = self getclientomnvar( "ui_br_inventory_disabled" );
        
        if ( !self.var_70c4022c00e0abb9 )
        {
            self setclientomnvar( "ui_br_inventory_disabled", 1 );
        }
    }
    
    if ( !getdvarint( @"hash_f69c3fd3c964b7b6" ) )
    {
        streakinfo.owner val::set( "deploy", "interactions", 0 );
        streakinfo.owner val::set( "deploy", "crate_use", 0 );
        streakinfo.owner val::set( "deploy", "ascender_use", 0 );
    }
    
    if ( isbot( streakinfo.owner ) && isdefined( streakinfo.owner._blackboard ) )
    {
        streakinfo.owner._blackboard.var_eeb71bc2f03775fc = 1;
    }
    
    if ( isdefined( level.var_fb6491c4ee5eaf0d ) )
    {
        thread [[ level.var_fb6491c4ee5eaf0d ]]( streakinfo );
    }
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0xcbe1f41, Offset: 0xab8
// Size: 0x1f0
function ondeployfinished( streakinfo, b_failed )
{
    streakinfo.isdeploying = 0;
    streakinfo.owner.isdeploying = 0;
    streakinfo.owner setclientomnvar( "ui_mobile_killstreak_is_deploying", 0 );
    
    if ( common_inventory::function_5c64d2b24a8c3e18() )
    {
        if ( !self.var_70c4022c00e0abb9 )
        {
            self setclientomnvar( "ui_br_inventory_disabled", 0 );
        }
        
        self.var_70c4022c00e0abb9 = undefined;
    }
    
    streakinfo.owner val::reset_all( "deploy" );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( isdefined( level.var_8547e3f3b843ca02 ) )
    {
        thread [[ level.var_8547e3f3b843ca02 ]]( streakinfo );
    }
    
    if ( isbot( streakinfo.owner ) && isdefined( streakinfo.owner._blackboard ) )
    {
        streakinfo.owner._blackboard.var_eeb71bc2f03775fc = 0;
    }
    
    switch ( streakinfo.streakname )
    {
        case #"hash_413c38e72fe8b5bf":
            if ( utility::ismp() )
            {
                streakinfo.owner setsoundsubmix( bundle.gunship_soundsubmix ?? "jup_mp_kls_gunship", 1 );
            }
            
            break;
        case #"hash_cf0ef5bef19a311b":
            streakinfo.owner setsoundsubmix( "jup_global_kls_wheelson", 1 );
            break;
        case #"hash_349713b5ad494dda":
            streakinfo.owner setsoundsubmix( "jup_global_kls_chopper_gunner", 1 );
            break;
    }
    
    if ( b_failed )
    {
        streakinfo notify( #"killstreak_failed_use" );
        
        if ( utility::isusingremote() )
        {
            player::clearusingremote();
        }
    }
    
    streakinfo notify( #"deploy_finished" );
}

// Namespace killstreakdeploy
// Params 0
// Checksum 0x5cc26d96, Offset: 0xcb0
// Size: 0xe
function streakdeploy_cancelalldeployments()
{
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace killstreakdeploy
// Params 4
// Checksum 0xc150c085, Offset: 0xcc6
// Size: 0x172
function streakdeploy_dogesturedeploy( streakinfo, gestureweaponobj, var_48e9b160167e8daf, var_3a955ee3361f5fc8 = 1 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !candeploykillstreak( streakinfo, gestureweaponobj ) )
    {
        self setclientomnvar( "ui_killstreak_cannot_be_used", 1 );
        return 0;
    }
    
    assert( isdefined( gestureweaponobj ) && gestureweaponobj.basename != "<dev string:xb3>", "<dev string:xb8>" + streakinfo.streakname + "<dev string:xc5>" );
    ondeploystart( streakinfo );
    thread watchforcancelduringgesture( streakinfo, gestureweaponobj );
    result = weapon_utility::giveandfireoffhandreliable( gestureweaponobj, var_48e9b160167e8daf );
    phonegesture = issubstr( gestureweaponobj.basename, "phone" );
    
    if ( result && phonegesture && var_3a955ee3361f5fc8 )
    {
        killstreak_utility::function_f45c61b25dd7ae02( streakinfo.streakname );
    }
    
    streakinfo notify( #"hash_5253d4e5cb8f29fd" );
    ondeployfinished( streakinfo );
    
    if ( self.inlaststand )
    {
        thread watchlaststandend( gestureweaponobj );
    }
    
    var_509f1389516f94d5 = level.streakglobals.streakbundles[ streakinfo.streakname ].var_509f1389516f94d5;
    
    if ( var_509f1389516f94d5 > 0 )
    {
        wait var_509f1389516f94d5;
    }
    
    return result;
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0xf0adb41, Offset: 0xe41
// Size: 0x5b
function watchforcancelduringgesture( streakinfo, gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    streakinfo endon( #"hash_5253d4e5cb8f29fd" );
    self waittill( #"cancel_all_killstreak_deployments" );
    self takeweapon( gestureweaponobj );
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x3250638f, Offset: 0xea4
// Size: 0x39
function watchlaststandend( gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"last_stand_exit" );
    self takeweapon( gestureweaponobj );
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0xe3487fef, Offset: 0xee5
// Size: 0x7a
function function_7237fd627c424c4a( streakinfo )
{
    self endon( #"cancel_all_killstreak_deployments" );
    streakinfo endon( #"deploy_finished" );
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_mobile_killstreak_is_deploying", 0 );
        
        if ( common_inventory::function_5c64d2b24a8c3e18() )
        {
            self setclientomnvar( "ui_br_inventory_disabled", 0 );
        }
        
        self.isdeploying = 0;
        val::reset_all( "deploy" );
    }
}

// Namespace killstreakdeploy
// Params 8
// Checksum 0x9f2622d1, Offset: 0xf67
// Size: 0x116, Type: bool
function streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_3a21d446a2f14d2c )
{
    if ( !candeploykillstreak( streakinfo, weaponobj ) )
    {
        return false;
    }
    
    ondeploystart( streakinfo );
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:xb3>", "<dev string:xb8>" + streakinfo.streakname + "<dev string:x103>" );
    waitfunc = var_3a21d446a2f14d2c ?? &waituntilfinishedwithdeployweapon;
    cleanupwaitfunc = keepweapon ? waitfunc : undefined;
    shouldskipfirstraise = streakinfo.usedbefore ?? 1;
    switchresult = switchtodeployweapon( weaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, shouldskipfirstraise );
    
    if ( !switchresult )
    {
        ondeployfinished( streakinfo );
        return false;
    }
    
    ondeployfinished( streakinfo );
    return true;
}

// Namespace killstreakdeploy
// Params 8
// Checksum 0x85cdc35d, Offset: 0x1086
// Size: 0x1aa, Type: bool
function streakdeploy_doweaponfireddeploy( streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !candeploykillstreak( streakinfo, weaponobj ) )
    {
        return false;
    }
    
    ondeploystart( streakinfo );
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:xb3>", "<dev string:xb8>" + streakinfo.streakname + "<dev string:x144>" );
    switchresult = switchtodeployweapon( weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        ondeployfinished( streakinfo );
        return false;
    }
    
    if ( isdefined( streakinfo ) && isdefined( streakinfo.var_21f1b0b4d8d3ea8f ) )
    {
        val::group_set( streakinfo.var_21f1b0b4d8d3ea8f, 0 );
        self.var_296ecaac501ba30d = streakinfo.var_21f1b0b4d8d3ea8f;
        firedresult = watchdeployweaponfired( streakinfo, firednotify, weaponobj, weaponfiredcallback );
        val::group_reset( streakinfo.var_21f1b0b4d8d3ea8f );
        self.var_296ecaac501ba30d = undefined;
    }
    else
    {
        val::set( "firedDeploy", "interactions", 0 );
        val::set( "firedDeploy", "offhand_weapons", 0 );
        firedresult = watchdeployweaponfired( streakinfo, firednotify, weaponobj, weaponfiredcallback );
        val::reset_all( "firedDeploy" );
    }
    
    ondeployfinished( streakinfo );
    return istrue( firedresult );
}

#using_animtree( "script_model" );

// Namespace killstreakdeploy
// Params 12
// Checksum 0x319828b8, Offset: 0x1239
// Size: 0x2f5, Type: bool
function streakdeploy_doweapontabletdeploy( streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, var_35a34784f1c6d395, var_9e428c3b74527aba, var_75defa1f64eb375a, var_37ae78e0de4a6e53, var_2eb4962448d3a1cb )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    weaponobj = undefined;
    
    if ( var_37ae78e0de4a6e53 )
    {
        weaponobj = var_37ae78e0de4a6e53;
        weaponbasename = weaponobj.basename;
    }
    else
    {
        weaponbasename = var_199122e4d3f907ba ?? "ks_remote_device_mp";
        attachments = getweapondefaultattachments( weaponbasename );
        weaponobj = makeweapon( weaponbasename, attachments );
    }
    
    deployanim = %vm_ks_tablet_tap_raise;
    var_9cf39e077c45398 = 1;
    
    if ( weaponbasename == "ks_remote_nuke_mp" )
    {
        deployanim = %vm_ks_tablet_tac_nuke_raise;
        var_9cf39e077c45398 = 0;
    }
    else if ( weaponbasename == "ks_rcxd_remote_mp" )
    {
        deployanim = %t10_vm_offhand_2h_rcxd_remote_in;
        var_9cf39e077c45398 = 0;
    }
    
    remotetabletweapon = killstreak_utility::function_8bec29aceea719c3( weaponobj );
    tabletanimlength = getanimlength( deployanim );
    
    if ( var_9cf39e077c45398 )
    {
        tabletanimlength -= 1;
    }
    
    if ( isdefined( var_35a34784f1c6d395 ) )
    {
        tabletanimlength = var_35a34784f1c6d395;
    }
    
    if ( !candeploykillstreak( streakinfo, weaponobj, var_9e428c3b74527aba ) )
    {
        return false;
    }
    
    ondeploystart( streakinfo );
    
    if ( !var_75defa1f64eb375a )
    {
        thread streakdeploy_playtabletdeploydialog( streakinfo );
    }
    
    val::set( "streakDeploy", "allow_movement", 0 );
    val::set( "streakDeploy", "allow_jump", 0 );
    val::set( "streakDeploy", "usability", 0 );
    val::set( "streakDeploy", "melee", 0 );
    val::set( "streakDeploy", "offhand_weapons", 0 );
    val::set( "streakDeploy", "supers", 0 );
    val::set( "streakDeploy", "killstreaks", 0 );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( isdefined( bundle.var_b3fb9f5453fca2ad ) )
    {
        self playlocalsound( bundle.var_b3fb9f5453fca2ad );
    }
    
    if ( bundle.var_bdb1da9d20af596b )
    {
        thread talking_gun::talkinggun_killstreakactivated( self, bundle.var_deacd172b5999f0c );
    }
    
    switchresult = switchtodeployweapon( weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, undefined, var_2eb4962448d3a1cb );
    
    if ( isdefined( self ) && player::isreallyalive() )
    {
        val::reset_all( "streakDeploy" );
        
        if ( remotetabletweapon )
        {
            player::_freezelookcontrols( 0 );
        }
    }
    
    if ( !switchresult )
    {
        ondeployfinished( streakinfo, 1 );
        return false;
    }
    
    animresult = watchdeployweaponanimtransition( streakinfo, tabletanimlength, var_572ea452a1bc65ed );
    ondeployfinished( streakinfo, !animresult );
    return istrue( animresult );
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x55c6e98b, Offset: 0x1537
// Size: 0x72
function streakdeploy_playtabletdeploydialog( streakinfo )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.5 );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
}

// Namespace killstreakdeploy
// Params 7
// Checksum 0x90003ced, Offset: 0x15b1
// Size: 0x14e, Type: bool
function streakdeploy_dothrowbackmarkerdeploy( streakinfo, weaponoverride, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    weapon = "throwback_marker_mp";
    
    if ( isdefined( weaponoverride ) )
    {
        weapon = weaponoverride;
    }
    
    streakinfo.deployweaponobj = makeweapon( weapon );
    weaponobj = streakinfo.deployweaponobj;
    
    if ( !candeploykillstreak( streakinfo, weaponobj ) )
    {
        return false;
    }
    
    ondeploystart( streakinfo );
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:xb3>", "<dev string:xb8>" + streakinfo.streakname + "<dev string:x144>" );
    switchresult = switchtodeployweapon( weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        ondeployfinished( streakinfo, 1 );
        return false;
    }
    
    firedresult = watchdeployweaponfired( streakinfo, "grenade_fire", weaponobj, weaponfiredcallback );
    ondeployfinished( streakinfo );
    return istrue( firedresult );
}

// Namespace killstreakdeploy
// Params 9
// Checksum 0x3c627931, Offset: 0x1708
// Size: 0x306
function switchtodeployweapon( deployweaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, var_2eb4962448d3a1cb )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isstring( deployweaponobj ) && !isweapon( deployweaponobj ) )
    {
        /#
            iprintlnbold( "<dev string:x184>" );
            
            if ( isdefined( deployweaponobj ) )
            {
                println( "<dev string:x1b4>" + deployweaponobj );
            }
        #/
        
        return 0;
    }
    
    alreadyhasweapon = isdefined( streakinfo ) && isdefined( streakinfo.streakname ) && self hasweapon( deployweaponobj ) && streakinfo.streakname != "false_flag" && streakinfo.streakname != "hand_cannon";
    
    if ( namespace_9d8e359c3b1041e5::function_f67fae8ef25c92b9() && namespace_9d8e359c3b1041e5::function_c1109cf6be986e40( deployweaponobj ) || namespace_9d8e359c3b1041e5::function_5d1edee14e4e4443( deployweaponobj ) )
    {
        streakinfo.deployweaponobj = deployweaponobj;
        givencallbackresult = callweapongivencallback( streakinfo, weapongivencallback );
        
        if ( !givencallbackresult )
        {
            return 0;
        }
        
        switchresult = 1;
        streakinfo notify( #"hash_98ad369312642743" );
    }
    else
    {
        if ( alreadyhasweapon )
        {
            return 0;
        }
        
        if ( !isdefined( skipfirstraise ) )
        {
            skipfirstraise = 1;
        }
        
        dualwieldoverride = isweapon( deployweaponobj ) && weapon::isakimbo( deployweaponobj );
        inventory_utility::_giveweapon( deployweaponobj, 0, dualwieldoverride, skipfirstraise );
        streakinfo.deployweaponobj = deployweaponobj;
        givencallbackresult = callweapongivencallback( streakinfo, weapongivencallback );
        
        if ( !givencallbackresult )
        {
            inventory_utility::_takeweapon( deployweaponobj );
            return 0;
        }
        
        self dlog_recordplayerevent( "dlog_event_killstreak_tablet", [ "file_line_info", "After switchToDeployWeapon" ] );
        thread watchforcancelduringweaponswitch( streakinfo, deployweaponobj );
        
        if ( !isdefined( streakinfo.var_37df6fe5dd599cc0 ) || streakinfo.var_37df6fe5dd599cc0 )
        {
            thread function_c6b9ec7ae4eab65a( streakinfo, deployweaponobj );
        }
        
        thread function_2eda8a0be53f444b( streakinfo, deployweaponobj );
        
        if ( var_2eb4962448d3a1cb )
        {
            thread function_eec70f27a410b6a9( streakinfo, deployweaponobj );
        }
        
        switchresult = inventory_utility::domonitoredweaponswitch( deployweaponobj, isbot( self ) || isautopilot( self ), streakinfo.var_53cb7968c54bb61d );
        streakinfo notify( #"hash_98ad369312642743" );
    }
    
    if ( isdefined( weaponswitchendedcallback ) )
    {
        self thread [[ weaponswitchendedcallback ]]( streakinfo, switchresult );
    }
    
    callback::callback( #"hash_d5b0824925e14094", { #switchresult:switchresult, #streakinfo:streakinfo } );
    result = utility::waittill_notify_or_timeout_return( "cancel_all_killstreak_deployments", level.framedurationseconds );
    
    if ( result == "cancel_all_killstreak_deployments" )
    {
        thread cleanupdeployweapon( switchresult, streakinfo, deployweaponobj, undefined, weaponcleanupcallback, weapontakencallback );
        return 0;
    }
    
    if ( !switchresult )
    {
        cleanupwaitfunc = undefined;
    }
    
    if ( self ismeatshieldvictim() )
    {
        cleanupwaitfunc = undefined;
    }
    
    if ( !player::isreallyalive() )
    {
        return 0;
    }
    
    thread cleanupdeployweapon( switchresult, streakinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback );
    return switchresult;
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0xa4a0fbb4, Offset: 0x1a17
// Size: 0x55
function callweapongivencallback( streakinfo, weapongivencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"cancel_all_killstreak_deployments" );
    
    if ( isdefined( weapongivencallback ) )
    {
        return self [[ weapongivencallback ]]( streakinfo );
    }
    
    return 1;
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0x1b608322, Offset: 0x1a75
// Size: 0x67
function watchforcancelduringweaponswitch( streakinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    streakinfo endon( #"hash_98ad369312642743" );
    self waittill( #"cancel_all_killstreak_deployments" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0x951df05a, Offset: 0x1ae4
// Size: 0xb0
function function_c6b9ec7ae4eab65a( streakinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    streakinfo endon( #"hash_98ad369312642743" );
    
    if ( streakinfo.streakname == "" )
    {
        self waittill( #"melee_swipe_start" );
    }
    else
    {
        utility::waittill_any( "melee_swipe_start", "br_pickup_scriptable" );
    }
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
        return;
    }
    
    inventory_utility::_takeweapon( deployweaponobj );
    thread inventory_utility::domonitoredweaponswitch( self.lastdroppableweaponobj, isbot( self ) );
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0xeb9ce284, Offset: 0x1b9c
// Size: 0x67
function function_2eda8a0be53f444b( streakinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    streakinfo endon( #"hash_98ad369312642743" );
    self waittill( #"meatshield_victim_grabbed" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0x80d5e707, Offset: 0x1c0b
// Size: 0x6b
function function_eec70f27a410b6a9( streakinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    streakinfo endon( #"hash_98ad369312642743" );
    
    while ( !self.oob )
    {
        waitframe();
    }
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace killstreakdeploy
// Params 4
// Checksum 0x2f2c92c5, Offset: 0x1c7e
// Size: 0x18e, Type: bool
function watchdeployweaponfired( streakinfo, firednotify, var_bee4d0e47f9fa8d1, weaponfiredcallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"weapon_change" );
    self endon( #"cancel_all_killstreak_deployments" );
    
    while ( true )
    {
        firedweaponobj = undefined;
        firedprojectile = undefined;
        
        switch ( firednotify )
        {
            case #"hash_21a23ad4b32e4f8e":
                self waittill( firednotify, firedweaponobj );
                break;
            case #"hash_77f5cb8818a754f0":
                self waittill( firednotify, firedweaponobj );
                break;
            case #"hash_3989359e2b52d1ba":
            case #"hash_f309e6283a942e38":
                self waittill( firednotify, firedprojectile, firedweaponobj );
                break;
            default:
                self waittill( firednotify );
                break;
        }
        
        if ( firedweaponobj == var_bee4d0e47f9fa8d1 )
        {
            if ( isdefined( weaponfiredcallback ) )
            {
                firedresult = [[ weaponfiredcallback ]]( streakinfo, firedweaponobj, firedprojectile );
                
                if ( !isdefined( firedresult ) )
                {
                    assert( isdefined( firedresult ), "<dev string:x1c9>" );
                    return false;
                }
                else if ( firedresult == "failure" )
                {
                    return false;
                }
                else if ( firedresult == "continue" )
                {
                    if ( isdefined( level.killstreakweaponfiredcontinue ) )
                    {
                        [[ level.killstreakweaponfiredcontinue ]]();
                    }
                    
                    continue;
                }
                else if ( firedresult == "success" )
                {
                    return true;
                }
                else
                {
                    assertmsg( "<dev string:x22c>" );
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace killstreakdeploy
// Params 0
// Checksum 0x81706913, Offset: 0x1e15
// Size: 0x129
function function_d09933f18bf42803()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_7696840d412d69e9 = function_151489d36a34d5d5();
    playersnearby = getplayersinradius( player.origin, var_7696840d412d69e9, var_7696840d412d69e9, 0, player );
    var_b82454c5543e09d7 = [];
    
    foreach ( playernearby in playersnearby )
    {
        var_b82454c5543e09d7 = arraycombineunique( var_b82454c5543e09d7, [ playernearby.team ] );
    }
    
    if ( var_b82454c5543e09d7.size <= 0 )
    {
        return;
    }
    
    player function_7b4f73a93178f87d( 6, var_b82454c5543e09d7, player, 1 );
    waitframe();
    var_89995953c4dc2bc = getdvarint( @"hash_e676739a33ee2b89", 1000 );
    player function_71c7c5be98d11198( var_b82454c5543e09d7, var_89995953c4dc2bc, 1 );
    player function_7b4f73a93178f87d( 6, var_b82454c5543e09d7, player, 0 );
}

// Namespace killstreakdeploy
// Params 3
// Checksum 0x9166fbc7, Offset: 0x1f46
// Size: 0x232, Type: bool
function watchdeployweaponanimtransition( streakinfo, animlength, var_572ea452a1bc65ed )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( var_572ea452a1bc65ed ) )
    {
        var_572ea452a1bc65ed = 1;
    }
    
    alias = "iw9_ks_tablet_ui_sequence_plr";
    
    switch ( streakinfo.streakname )
    {
        case #"hash_195360490caa3220":
        case #"hash_de3d319cd367bcba":
            alias = "mp_killstreak_mgb_tablet";
            break;
    }
    
    self playlocalsound( alias );
    player::setusingremote( streakinfo.streakname );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    
    if ( bundle.var_51ea776563ec1fcc )
    {
        self.var_1df90882c6490925 = 1;
    }
    
    if ( isdefined( self.pinnedobjid ) )
    {
        objidpoolmanager::objective_unpin_player( self.pinnedobjid, self );
        self.remoteunpinned = 1;
    }
    
    player::_freezecontrols( 1, undefined, "killstreakDeploy" );
    thread unfreezecontrolsonroundend();
    
    if ( var_572ea452a1bc65ed )
    {
        thread startweapontabletfadetransition( animlength - 0.3, streakinfo );
    }
    
    thread watchweapontabletstop( streakinfo );
    thread watchweapontabletcallinpos( streakinfo );
    killstreak_shared::starttabletscreen( streakinfo.streakname, 0.05 );
    result = utility::waittill_any_timeout( animlength, "death", "last_stand_enter", "weapon_change", "cancel_all_killstreak_deployments", "meatshield_victim_grabbed" );
    self.var_1df90882c6490925 = undefined;
    self notify( #"hash_d0a8957ba68f92dd" );
    player::_freezecontrols( 0, undefined, "killstreakDeploy" );
    
    if ( result != "timeout" || !self isonground() && !player_utility::function_2e61ffcf29281b15() && !issubstr( streakinfo.streakname, "nuke" ) || self isonladder() )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        self stoplocalsound( alias );
        killstreak_shared::stoptabletscreen( streakinfo.streakname );
        self notify( #"cancel_remote_sequence" );
        return false;
    }
    
    self notify( #"hash_f5c8864fef988d68" );
    return true;
}

// Namespace killstreakdeploy
// Params 0
// Checksum 0x43c7bb86, Offset: 0x2181
// Size: 0x35
function unfreezecontrolsonroundend()
{
    self endon( #"disconnect" );
    self endon( #"hash_d0a8957ba68f92dd" );
    level waittill( #"round_switch" );
    player::_freezecontrols( 0, undefined, "killstreakDeploy" );
}

// Namespace killstreakdeploy
// Params 2, eflags: 0x4
// Checksum 0x28d6f882, Offset: 0x21be
// Size: 0xcc
function private startweapontabletfadetransition( timedelay, streakinfo )
{
    self endon( #"disconnect" );
    result = utility::waittill_any_timeout( timedelay, "cancel_remote_sequence" );
    
    if ( !isdefined( result ) || result == "cancel_remote_sequence" )
    {
        return;
    }
    
    if ( player::isreallyalive() )
    {
        if ( isdefined( streakinfo ) && streakinfo.streakname != "pac_sentry" )
        {
            self playlocalsound( "mp_killstreak_transition_whoosh" );
        }
        
        level thread game_utility::fadetoblackforplayer( self, 1, 0.3 );
        result = utility::waittill_any_timeout( 0.7, "death" );
        
        if ( !isdefined( result ) || result == "death" )
        {
            self stoplocalsound( "mp_killstreak_transition_whoosh" );
        }
        
        level thread game_utility::fadetoblackforplayer( self, 0, 0.3 );
    }
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x3f624c0d, Offset: 0x2292
// Size: 0x13f
function watchweapontabletstop( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    streakinfo waittill( #"killstreak_finished_with_deploy_weapon" );
    var_ec96691f3a2c45c0 = !isdefined( streakinfo.var_ec96691f3a2c45c0 ) || streakinfo.var_ec96691f3a2c45c0;
    
    if ( utility::isusingremote() && var_ec96691f3a2c45c0 )
    {
        if ( streakinfo.var_e8b8649e71024d0 )
        {
            utility::delaycall( streakinfo.var_e8b8649e71024d0, &player::clearusingremote );
        }
        else
        {
            player::clearusingremote();
        }
    }
    
    switch ( streakinfo.streakname )
    {
        case #"hash_413c38e72fe8b5bf":
            if ( utility::ismp() )
            {
                bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
                self clearsoundsubmix( bundle.gunship_soundsubmix ?? "jup_mp_kls_gunship", 1 );
            }
            
            break;
        case #"hash_cf0ef5bef19a311b":
            self clearsoundsubmix( "jup_global_kls_wheelson", 1 );
            break;
        case #"hash_349713b5ad494dda":
            self clearsoundsubmix( "jup_global_kls_chopper_gunner", 1 );
            break;
    }
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0xca3e22e9, Offset: 0x23d9
// Size: 0xe3
function watchweapontabletcallinpos( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_f5c8864fef988d68" );
    self endon( #"cancel_remote_sequence" );
    
    while ( true )
    {
        if ( !self isonground() )
        {
            canceldeployment = 1;
            
            if ( player_utility::isswimmingunderwater() )
            {
                if ( killstreak_utility::ismapselectkillstreak( streakinfo.streakname ) )
                {
                    canceldeployment = 0;
                }
            }
            else if ( player_utility::function_2e61ffcf29281b15() )
            {
                if ( killstreak_utility::isridekillstreak( streakinfo.streakname ) || killstreak_utility::ismapselectkillstreak( streakinfo.streakname ) )
                {
                    canceldeployment = 0;
                }
            }
            else if ( killstreak_utility::function_c29a6186f91aaa2c( streakinfo.streakname ) )
            {
                canceldeployment = 0;
            }
            
            if ( canceldeployment )
            {
                wait 0.05;
                streakdeploy_cancelalldeployments();
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0xcd8e358d, Offset: 0x24c4
// Size: 0x15
function function_f3a27337346fe76e( streakinfo )
{
    waituntilfinishedwithdeployweapon( streakinfo );
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x141f0fe7, Offset: 0x24e1
// Size: 0xbf
function waituntilfinishedwithdeployweapon( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    childthread function_c1b247fe7d481d2a( streakinfo, "killstreak_finished_with_deploy_weapon" );
    childthread function_c1b247fe7d481d2a( self, "cancel_all_killstreak_deployments" );
    childthread function_c1b247fe7d481d2a( self, "weapon_change" );
    childthread function_c1b247fe7d481d2a( self, "meatshield_victim_grabbed" );
    
    while ( true )
    {
        self waittill( #"hash_9594de332bd9c38c", result );
        
        if ( isdefined( result ) )
        {
            if ( result == "weapon_change" && utility::isusingremote() )
            {
                continue;
            }
            
            if ( result == "meatshield_victim_grabbed" && utility::isusingremote() )
            {
                continue;
            }
        }
        
        break;
    }
    
    self notify( #"hash_dbf5e49c24d7fdc8" );
}

// Namespace killstreakdeploy
// Params 2, eflags: 0x4
// Checksum 0x9ddd5c43, Offset: 0x25a8
// Size: 0x35
function private function_c1b247fe7d481d2a( ent, finishednotify )
{
    self endon( #"hash_dbf5e49c24d7fdc8" );
    ent waittill( finishednotify );
    self notify( #"hash_9594de332bd9c38c", finishednotify );
}

// Namespace killstreakdeploy
// Params 6, eflags: 0x4
// Checksum 0xfa528bb4, Offset: 0x25e5
// Size: 0x20a
function private cleanupdeployweapon( switchresult, streakinfo, weaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( cleanupwaitfunc ) )
    {
        self [[ cleanupwaitfunc ]]( streakinfo );
    }
    
    if ( self hasweapon( weaponobj ) )
    {
        remotetabletweapon = killstreak_utility::function_8bec29aceea719c3( weaponobj );
        mapselectkillstreak = killstreak_utility::ismapselectkillstreak( streakinfo.streakname );
        isnukeweapon = streakinfo.streakname == "nuke" || streakinfo.streakname == "nuke_multi";
        val::set( "deployCleanup", "melee", 0 );
        val::set( "deployCleanup", "offhand_weapons", 0 );
        val::set( "deployCleanup", "attackeraccuracy", 0.2 );
        bundle = getgamemodescriptbundle();
        
        if ( bundle.var_a07189fb13c2c942 && !streakinfo.bundle.var_9be5a9a4b9c9fe0e )
        {
            val::set( "deployCleanup", "ignoreme", 1 );
        }
        
        if ( remotetabletweapon )
        {
            val::set( "deployCleanup", "mantle", 0 );
            val::set( "deployCleanup", "allow_movement", 0 );
            killstreak_shared::stoptabletscreen( streakinfo.streakname, 0.5, 1 );
            player::_freezelookcontrols( 1 );
        }
        else if ( mapselectkillstreak )
        {
            val::set( "deployCleanup", "mantle", 0 );
            
            if ( isnukeweapon )
            {
                killstreak_shared::stoptabletscreen( streakinfo.streakname );
            }
        }
        
        if ( isdefined( weaponcleanupcallback ) )
        {
            self [[ weaponcleanupcallback ]]( streakinfo, switchresult, weaponobj );
        }
        else
        {
            getridofkillstreakdeployweapon( weaponobj );
        }
        
        val::reset_all( "deployCleanup" );
        
        if ( remotetabletweapon )
        {
            player::_freezelookcontrols( 0 );
        }
    }
    
    if ( isdefined( weapontakencallback ) )
    {
        self [[ weapontakencallback ]]( streakinfo );
    }
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0xc6156231, Offset: 0x27f7
// Size: 0x7c
function getridofkillstreakdeployweapon( weaponobj )
{
    if ( self gethighpriorityweapon() == weaponobj )
    {
        self clearhighpriorityweapon( weaponobj );
    }
    
    inventory_utility::getridofweapon( weaponobj, istrue( self.var_45ab03788f1a0a4d ) );
    self.var_45ab03788f1a0a4d = undefined;
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.basename == "none" )
    {
        if ( vehicle_occupancy::function_3080323254ba6900( self ) )
        {
            thread function_37df53dfe3ae16d2();
            return;
        }
        
        inventory_utility::forcevalidweapon();
    }
}

// Namespace killstreakdeploy
// Params 0
// Checksum 0xf0e44ea8, Offset: 0x287b
// Size: 0x26
function function_37df53dfe3ae16d2()
{
    self endon( #"death_or_disconnect" );
    utility::waittill_any( "exit_vehicle", "vehicle_seat_exit" );
    inventory_utility::forcevalidweapon();
}

// Namespace killstreakdeploy
// Params 1, eflags: 0x4
// Checksum 0x1d16f235, Offset: 0x28a9
// Size: 0x5f, Type: bool
function private function_bec8cec10d268cfd( objweapon )
{
    currentweapon = self getcurrentweapon().basename;
    killstreakweapon = objweapon.basename;
    
    if ( function_9670f0716ada309b( currentweapon ) && isdefined( killstreakweapon ) && !function_9670f0716ada309b( killstreakweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0x8942d37c, Offset: 0x2911
// Size: 0x62, Type: bool
function function_9670f0716ada309b( currentweapon )
{
    switch ( currentweapon )
    {
        case #"hash_cca6939578fa49a":
        case #"hash_1898ea54a0bc6404":
        case #"hash_51ff17772177a957":
        case #"hash_5fee2c6097070f10":
        case #"hash_879b8ea58093f02c":
        case #"hash_e03f05f611764899":
            return true;
    }
    
    return false;
}

// Namespace killstreakdeploy
// Params 2
// Checksum 0x55f793e3, Offset: 0x297c
// Size: 0x410
function candeploykillstreakweapon( streakinfo, objweapon )
{
    if ( self getcurrentweapon().basename == "none" )
    {
        waitframe();
    }
    
    if ( !isbrgamemode() && level.gameended )
    {
        return get_cannot_be_used_message();
    }
    
    if ( level.gamemodebundle.var_658f1267b9d6619d && killstreak_utility::function_2910a801443e6b84( objweapon ) && self isreloading() )
    {
        return get_cannot_be_used_message();
    }
    
    if ( isdefined( objweapon ) && self hasweapon( objweapon ) && objweapon.basename != "false_flag_t10_wz" && objweapon.basename != "t10_ks_handcannon_wz2" && !namespace_9d8e359c3b1041e5::function_c1109cf6be986e40( objweapon ) && !namespace_9d8e359c3b1041e5::function_5d1edee14e4e4443( objweapon ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( isdefined( objweapon ) && function_bec8cec10d268cfd( objweapon ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( !val::get( "weapon_switch" ) || !val::get( "weapon" ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( utility::isusingremote() )
    {
        return get_cannot_be_used_message();
    }
    
    if ( self.oob )
    {
        return get_cannot_be_used_message( "oob" );
    }
    
    if ( streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon" || streakinfo.streakname == "pac_sentry" || streakinfo.streakname == "turret_drone" )
    {
        if ( self.isinsideelevator )
        {
            return get_cannot_be_used_message();
        }
    }
    
    if ( self.hashostage )
    {
        return get_cannot_be_used_message();
    }
    
    if ( self isonladder() )
    {
        return get_cannot_be_used_message();
    }
    
    if ( self ismantling() )
    {
        return get_cannot_be_used_message();
    }
    
    if ( self function_65267a768ced48a0() || player_utility::isswimmingunderwater() )
    {
        var_ed82a5c49b8ce14b = objweapon ?? utility::function_64003742d8f5c781( streakinfo.weaponname );
        
        if ( !function_e7842eaf92fbf7f( var_ed82a5c49b8ce14b ) || killstreak_utility::isridekillstreak( streakinfo.streakname ) || killstreak_utility::function_f30fd40c050e5557( streakinfo.streakname ) )
        {
            return get_cannot_be_used_message( "water" );
        }
    }
    else if ( player_utility::function_2e61ffcf29281b15() )
    {
        var_ed82a5c49b8ce14b = objweapon ?? utility::function_64003742d8f5c781( streakinfo.weaponname );
        
        if ( !function_b6a8a9a45d1a5738( var_ed82a5c49b8ce14b ) || killstreak_utility::function_f30fd40c050e5557( streakinfo.streakname ) )
        {
            return get_cannot_be_used_message( "water" );
        }
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        if ( self isparachuting() )
        {
            return get_cannot_be_used_message();
        }
        
        if ( !killstreak_utility::function_c29a6186f91aaa2c( streakinfo.streakname ) )
        {
            return get_cannot_be_used_message();
        }
    }
    
    if ( self isdiving() )
    {
        return get_cannot_be_used_message();
    }
    
    currentgrenade = weapon::getgrenadeinpullback();
    
    if ( isdefined( currentgrenade ) && weapon::issuperweapon( currentgrenade ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( level.var_803f9c2f9e8064b == 1 && isdefined( level.munitions_airborne ) && arraycontains( level.munitions_airborne, streakinfo.streakname ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( level.var_803f9c2f9e8064b == 1 && isdefined( level.supers_airborne ) && arraycontains( level.supers_airborne, streakinfo.streakname ) )
    {
        return %"MP/CANNOT_USE_GENERIC";
    }
    
    if ( isdefined( streakinfo ) && streakinfo.streakname == "juggernaut" && getdvarint( @"hash_d2d7564ba2f2f9d", 0 ) )
    {
        return get_cannot_be_used_message();
    }
    
    if ( utility::issharedfuncdefined( streakinfo.streakname, #"hash_43597075da251a73" ) )
    {
        if ( !self [[ utility::getsharedfunc( streakinfo.streakname, #"hash_43597075da251a73" ) ]]( streakinfo ) )
        {
            return %"killstreaks/cannot_be_used";
        }
    }
}

// Namespace killstreakdeploy
// Params 1
// Checksum 0xce2630bc, Offset: 0x2d95
// Size: 0x46
function get_cannot_be_used_message( messagetype )
{
    if ( messagetype == "oob" )
    {
        return %"killstreaks/cannot_be_used_outofbounds";
    }
    
    if ( messagetype == "water" )
    {
        return %"hash_1e07c961246b829c";
    }
    
    return %"killstreaks/cannot_be_used";
}

