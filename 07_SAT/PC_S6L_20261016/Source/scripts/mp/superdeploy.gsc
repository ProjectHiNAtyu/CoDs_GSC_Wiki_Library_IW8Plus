// scripts\mp\superdeploy.gsc  (hash_2b499275e54a90c0.gscc) (size: 9282 Bytes / 0x2442 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x100bbcdf (269204703)
// size ...... 9282 (0x2442)
// includes .. 10  (offset: 0x219a)
// strings ... 28  (offset: 0x21ea)
// dev strs .. 10  (offset: 0x23aa)
// exports ... 25  (offset: 0x1502)
// cseg ...... 0x2af + 0x1253 (0x1502)
// imports ... 71  (offset: 0x18ea)
// animtree1 . 0   (offset: 0x2432)
// animtree2 . 1   (offset: 0x2432)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\objidpoolmanager;

#namespace superdeploy;

// Namespace superdeploy
// Params 4
// Checksum 0xead4c08a, Offset: 0x2cd
// Size: 0x118
function superdeploy_dogesturedeploy( superinfo, gestureweaponobj, canuseinair, var_e4d45ab849b00ea5 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !canuseinair )
    {
        if ( !self isonground() )
        {
            return 0;
        }
    }
    
    if ( !var_e4d45ab849b00ea5 )
    {
        if ( !self isswimming() )
        {
            return 0;
        }
    }
    
    if ( self isonladder() )
    {
        return 0;
    }
    
    if ( self.super.isdeploying )
    {
        return 0;
    }
    
    assert( isdefined( gestureweaponobj ) && gestureweaponobj.basename != "<dev string:x24>", "<dev string:x29>" + superinfo.staticdata.ref + "<dev string:x31>" );
    function_ba3e14ecf146c4c7( superinfo );
    thread function_73ddc8cbdac91799( superinfo, gestureweaponobj );
    result = weapon_utility::giveandfireoffhandreliable( gestureweaponobj );
    superinfo notify( #"hash_5253d4e5cb8f29fd" );
    function_2364462c5f9943fb( superinfo );
    
    if ( self.inlaststand )
    {
        thread function_23548d9b5a17f297( gestureweaponobj );
    }
    
    return result;
}

// Namespace superdeploy
// Params 1
// Checksum 0xe918818e, Offset: 0x3ee
// Size: 0x39
function function_23548d9b5a17f297( gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"last_stand_finished" );
    self takeweapon( gestureweaponobj );
}

// Namespace superdeploy
// Params 2
// Checksum 0x58058228, Offset: 0x42f
// Size: 0x5b
function function_73ddc8cbdac91799( superinfo, gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    superinfo endon( #"hash_5253d4e5cb8f29fd" );
    self waittill( #"cancel_all_super_deployments" );
    self takeweapon( gestureweaponobj );
}

#using_animtree( "script_model" );

// Namespace superdeploy
// Params 10
// Checksum 0x72cd106d, Offset: 0x492
// Size: 0x213, Type: bool
function superdeploy_doweapontabletdeploy( superinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, waittime, skipfirstraise, isimmediate )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        return false;
    }
    
    weaponbasename = "super_remote_device_mp";
    
    if ( isdefined( var_199122e4d3f907ba ) )
    {
        weaponbasename = var_199122e4d3f907ba;
    }
    
    weaponobj = makeweapon( weaponbasename );
    deployanim = %vm_ks_tablet_super_remote_raise;
    tabletanimlength = getanimlength( deployanim ) - getdvarfloat( @"hash_8416696fd33ebf85", 0.433 );
    
    if ( isdefined( waittime ) )
    {
        tabletanimlength = waittime;
    }
    
    function_ba3e14ecf146c4c7( superinfo );
    val::set( "superDeploy", "allow_movement", 0 );
    val::set( "superDeploy", "allow_jump", 0 );
    val::set( "superDeploy", "usability", 0 );
    val::set( "superDeploy", "melee", 0 );
    val::set( "superDeploy", "offhand_weapons", 0 );
    val::set( "superDeploy", "supers", 0 );
    val::set( "superDeploy", "killstreaks", 0 );
    switchresult = function_6101275e96a30319( weaponobj, superinfo, &function_94bc797a420bf87f, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate );
    
    if ( isdefined( self ) && player::isreallyalive() )
    {
        val::reset_all( "superDeploy" );
    }
    
    if ( !switchresult )
    {
        function_2364462c5f9943fb( superinfo );
        
        if ( isdefined( self ) )
        {
            killstreak_shared::stoptabletscreen( superinfo.staticdata.ref );
        }
        
        return false;
    }
    
    animresult = function_84c84b1471b384eb( superinfo, tabletanimlength, var_572ea452a1bc65ed );
    function_2364462c5f9943fb( superinfo );
    return istrue( animresult );
}

// Namespace superdeploy
// Params 8
// Checksum 0xebdb0918, Offset: 0x6ae
// Size: 0x1ac, Type: bool
function superdeploy_doweaponfireddeploy( superinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self.super.isdeploying )
    {
        return false;
    }
    
    function_ba3e14ecf146c4c7( superinfo );
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x24>", "<dev string:x6f>" + superinfo.staticdata.ref + "<dev string:x7f>" );
    switchresult = function_6101275e96a30319( weaponobj, superinfo, &function_94bc797a420bf87f, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        function_2364462c5f9943fb( superinfo );
        return false;
    }
    
    if ( isdefined( superinfo ) && isdefined( superinfo.var_21f1b0b4d8d3ea8f ) )
    {
        val::group_set( superinfo.var_21f1b0b4d8d3ea8f, 0 );
        firedresult = function_75868a792d3663df( superinfo, firednotify, weaponobj, weaponfiredcallback );
        val::group_reset( superinfo.var_21f1b0b4d8d3ea8f );
    }
    else
    {
        val::set( "firedDeploy", "offhand_weapons", 0 );
        firedresult = function_75868a792d3663df( superinfo, firednotify, weaponobj, weaponfiredcallback );
        val::reset_all( "firedDeploy" );
    }
    
    function_2364462c5f9943fb( superinfo );
    return istrue( firedresult );
}

// Namespace superdeploy
// Params 7
// Checksum 0x5df77f7b, Offset: 0x863
// Size: 0xe0
function superdeploy_doweaponswitchdeploy( superinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback )
{
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x24>", "<dev string:x6f>" + superinfo.staticdata.ref + "<dev string:x7f>" );
    function_ba3e14ecf146c4c7( superinfo );
    cleanupwaitfunc = keepweapon ? &function_94bc797a420bf87f : undefined;
    switchresult = function_6101275e96a30319( weaponobj, superinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        function_2364462c5f9943fb( superinfo );
        return 0;
    }
    
    function_2364462c5f9943fb( superinfo );
    return 1;
}

// Namespace superdeploy
// Params 3, eflags: 0x4
// Checksum 0x499f8e73, Offset: 0x94b
// Size: 0x1c3, Type: bool
function private function_84c84b1471b384eb( superinfo, animlength, var_572ea452a1bc65ed )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( var_572ea452a1bc65ed ) )
    {
        var_572ea452a1bc65ed = 1;
    }
    
    alias = "iw9_killstreak_tablet_gear";
    self playlocalsound( alias );
    player::setusingremote( superinfo.staticdata.ref );
    objidpoolmanager::objective_unpin_player( self.pinnedobjid, self );
    self.remoteunpinned = 1;
    player::_freezecontrols( 1, undefined, "superDeploy" );
    thread function_cc1be19825853859();
    
    if ( var_572ea452a1bc65ed )
    {
        thread function_dbd52427b05f0f70( animlength - 0.3 );
    }
    
    thread function_c81f0bf9a21c5ffe( superinfo );
    thread function_5cbba138f12b7529();
    
    if ( animlength > 0 )
    {
        killstreak_shared::starttabletscreen( superinfo.staticdata.ref, 0.05 );
    }
    
    result = utility::waittill_any_timeout( animlength, "death", "weapon_change", "cancel_all_super_deployments" );
    self notify( #"hash_ca93f66971ad0010" );
    player::_freezecontrols( 0, undefined, "superDeploy" );
    badplayerstate = !self isonground() && !player_utility::function_2e61ffcf29281b15() || self isonladder() || self isinfreefall() || self isparachuting();
    
    if ( result != "timeout" || badplayerstate )
    {
        self notify( #"super_finished_with_deploy_weapon" );
        self stoplocalsound( "mp_killstreak_tablet_gear" );
        killstreak_shared::stoptabletscreen( superinfo.staticdata.ref );
        self notify( #"cancel_remote_sequence" );
        return false;
    }
    
    self notify( #"hash_f5c8864fef988d68" );
    return true;
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0x38e66f9d, Offset: 0xb17
// Size: 0x43
function private function_c81f0bf9a21c5ffe( superinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"super_finished_with_deploy_weapon" );
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote( 1 );
    }
}

// Namespace superdeploy
// Params 0, eflags: 0x4
// Checksum 0x529bb7c3, Offset: 0xb62
// Size: 0x5e
function private function_5cbba138f12b7529()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_f5c8864fef988d68" );
    self endon( #"cancel_remote_sequence" );
    
    while ( true )
    {
        if ( !self isonground() && !player_utility::function_2e61ffcf29281b15() )
        {
            self notify( #"cancel_all_super_deployments" );
            break;
        }
        
        waitframe();
    }
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0x4a2406c9, Offset: 0xbc8
// Size: 0xa8
function private function_dbd52427b05f0f70( timedelay )
{
    self endon( #"disconnect" );
    result = utility::waittill_any_timeout( timedelay, "cancel_remote_sequence" );
    
    if ( !isdefined( result ) || result == "cancel_remote_sequence" )
    {
        return;
    }
    
    if ( player::isreallyalive() )
    {
        self playlocalsound( "mp_killstreak_transition_whoosh" );
        level thread game_utility::fadetoblackforplayer( self, 1, 0.3 );
        result = utility::waittill_any_timeout( 0.7, "death" );
        
        if ( !isdefined( result ) || result == "death" )
        {
            self stoplocalsound( "mp_killstreak_transition_whoosh" );
        }
        
        level thread game_utility::fadetoblackforplayer( self, 0, 0.3 );
    }
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0x59a2e38e, Offset: 0xc78
// Size: 0x25
function private function_2364462c5f9943fb( superinfo )
{
    superinfo.isdeploying = 0;
    val::reset_all( "deployStart" );
}

// Namespace superdeploy
// Params 0, eflags: 0x4
// Checksum 0xcecdbd0, Offset: 0xca5
// Size: 0x35
function private function_cc1be19825853859()
{
    self endon( #"disconnect" );
    self endon( #"hash_ca93f66971ad0010" );
    level waittill( #"round_switch" );
    player::_freezecontrols( 0, undefined, "superDeploy" );
}

// Namespace superdeploy
// Params 9
// Checksum 0xe8329310, Offset: 0xce2
// Size: 0x12c
function function_6101275e96a30319( deployweaponobj, superinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( self hasweapon( deployweaponobj ) )
    {
        return 0;
    }
    
    if ( !isdefined( skipfirstraise ) )
    {
        skipfirstraise = 1;
    }
    
    inventory_utility::_giveweapon( deployweaponobj, 0, 0, skipfirstraise );
    givencallbackresult = function_b0f2e932c78cd77( superinfo, weapongivencallback );
    
    if ( !givencallbackresult )
    {
        inventory_utility::_takeweapon( deployweaponobj );
        return 0;
    }
    
    thread function_d3a0fb5c5409692e( superinfo, deployweaponobj );
    thread function_4ee00ea1673c4636( superinfo, deployweaponobj );
    switchresult = inventory_utility::domonitoredweaponswitch( deployweaponobj, istrue( isimmediate ) );
    superinfo notify( #"hash_98ad369312642743" );
    
    if ( isdefined( weaponswitchendedcallback ) )
    {
        self thread [[ weaponswitchendedcallback ]]( superinfo, switchresult );
    }
    
    waitframe();
    
    if ( !switchresult )
    {
        cleanupwaitfunc = undefined;
    }
    
    if ( !player::isreallyalive() )
    {
        return 0;
    }
    
    thread function_12dd7619ac35b6ce( switchresult, superinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback );
    return switchresult;
}

// Namespace superdeploy
// Params 6, eflags: 0x4
// Checksum 0xe85dd352, Offset: 0xe17
// Size: 0x160
function private function_12dd7619ac35b6ce( switchresult, superinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( cleanupwaitfunc ) )
    {
        self [[ cleanupwaitfunc ]]( superinfo );
    }
    
    if ( self hasweapon( deployweaponobj ) )
    {
        remotetabletweapon = function_dac4a41a0ff10a48( deployweaponobj.basename );
        val::set( "cleanupDeployWeapon", "melee", 0 );
        val::set( "cleanupDeployWeapon", "offhand_weapons", 0 );
        
        if ( remotetabletweapon )
        {
            val::set( "cleanupDeployWeapon", "mantle", 0 );
            val::set( "cleanupDeployWeapon", "allow_movement", 0 );
            dofdelay = 0.5;
            
            if ( !player::isreallyalive( self ) )
            {
                dofdelay = 0;
            }
            
            killstreak_shared::stoptabletscreen( superinfo.staticdata.ref, dofdelay, 1 );
            player::_freezelookcontrols( 1 );
        }
        
        if ( isdefined( weaponcleanupcallback ) )
        {
            self [[ weaponcleanupcallback ]]( superinfo, switchresult, deployweaponobj );
        }
        else
        {
            function_7c4a8b450b390216( deployweaponobj );
        }
        
        val::reset_all( "cleanupDeployWeapon" );
        
        if ( remotetabletweapon )
        {
            player::_freezelookcontrols( 0 );
        }
    }
    
    if ( isdefined( weapontakencallback ) )
    {
        self [[ weapontakencallback ]]( superinfo );
    }
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0x53345892, Offset: 0xf7f
// Size: 0x55
function private function_7c4a8b450b390216( deployweaponobj )
{
    inventory_utility::getridofweapon( deployweaponobj, istrue( self.var_45ab03788f1a0a4d ) );
    self.var_45ab03788f1a0a4d = undefined;
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.basename == "none" )
    {
        inventory_utility::forcevalidweapon();
    }
}

// Namespace superdeploy
// Params 2, eflags: 0x4
// Checksum 0x89734f6c, Offset: 0xfdc
// Size: 0x67
function private function_d3a0fb5c5409692e( superinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    superinfo endon( #"hash_98ad369312642743" );
    self waittill( #"cancel_all_super_deployments" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace superdeploy
// Params 1
// Checksum 0xa1ea9115, Offset: 0x104b
// Size: 0x5c
function function_dac4a41a0ff10a48( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapobj ) )
    {
        return 0;
    }
    
    remotetabletweapon = 0;
    
    switch ( weapobj.basenamehash )
    {
        case %"super_remote_device_mp":
            remotetabletweapon = 1;
            break;
    }
    
    return remotetabletweapon;
}

// Namespace superdeploy
// Params 2, eflags: 0x4
// Checksum 0xa817e2, Offset: 0x10b0
// Size: 0x83
function private function_4ee00ea1673c4636( superinfo, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    superinfo endon( #"hash_98ad369312642743" );
    self waittill( #"melee_swipe_start" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
        return;
    }
    
    inventory_utility::_takeweapon( deployweaponobj );
    thread inventory_utility::domonitoredweaponswitch( self.lastdroppableweaponobj );
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0x959d5cec, Offset: 0x113b
// Size: 0x73
function private function_ba3e14ecf146c4c7( superinfo )
{
    assert( !superinfo.isdeploying, "<dev string:xc0>" + superinfo.staticdata.ref + "<dev string:xd1>" );
    superinfo.isdeploying = 1;
    val::set( "deployStart", "crate_use", 0 );
    val::set( "deployStart", "ascender_use", 0 );
}

// Namespace superdeploy
// Params 2, eflags: 0x4
// Checksum 0xfe2b4d40, Offset: 0x11b6
// Size: 0x55
function private function_b0f2e932c78cd77( superinfo, weapongivencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"cancel_all_super_deployments" );
    
    if ( isdefined( weapongivencallback ) )
    {
        return self [[ weapongivencallback ]]( superinfo );
    }
    
    return 1;
}

// Namespace superdeploy
// Params 1, eflags: 0x4
// Checksum 0xa46c41c9, Offset: 0x1214
// Size: 0x86
function private function_94bc797a420bf87f( superinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    childthread function_c7b36288a3737d5( self, "super_finished_with_deploy_weapon" );
    childthread function_c7b36288a3737d5( self, "cancel_all_super_deployments" );
    childthread function_c7b36288a3737d5( self, "weapon_change" );
    
    while ( true )
    {
        self waittill( #"super_finished_with_deploy_weapon", result );
        
        if ( result == "weapon_change" )
        {
            if ( utility::isusingremote() )
            {
                continue;
            }
        }
        
        break;
    }
}

// Namespace superdeploy
// Params 2, eflags: 0x4
// Checksum 0xa6f1e280, Offset: 0x12a2
// Size: 0x35
function private function_c7b36288a3737d5( ent, finishednotify )
{
    self endon( #"super_finished_with_deploy_weapon" );
    ent waittill( finishednotify );
    self notify( #"super_finished_with_deploy_weapon", finishednotify );
}

// Namespace superdeploy
// Params 1
// Checksum 0xb6dc67d2, Offset: 0x12df
// Size: 0xb0
function function_2417190da7fa263e( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x100>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = weapon::getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    var_e3d49e7eab9776e9 = 0;
    mapweapon = utility::get_scripted_weapon_name( #"super_remote_map" );
    remotedevice = utility::get_scripted_weapon_name( #"hash_ad32c496b9288302" );
    
    if ( weapon == mapweapon || weapon == remotedevice )
    {
        var_e3d49e7eab9776e9 = 1;
    }
    
    return var_e3d49e7eab9776e9;
}

// Namespace superdeploy
// Params 4
// Checksum 0xae7738b8, Offset: 0x1398
// Size: 0x169, Type: bool
function function_75868a792d3663df( superinfo, firednotify, var_bee4d0e47f9fa8d1, weaponfiredcallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"weapon_change" );
    self endon( #"cancel_all_super_deployments" );
    
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
                firedresult = [[ weaponfiredcallback ]]( superinfo, firedweaponobj, firedprojectile );
                
                if ( !isdefined( firedresult ) )
                {
                    assert( isdefined( firedresult ), "<dev string:x134>" );
                    return false;
                }
                else if ( firedresult == "failure" )
                {
                    return false;
                }
                else if ( firedresult == "continue" )
                {
                    continue;
                }
                else if ( firedresult == "success" )
                {
                    return true;
                }
                else
                {
                    assertmsg( "<dev string:x197>" );
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

