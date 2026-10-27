// scripts\mp\equipmentdeploy.gsc  (hash_7ab4ac6c3525b2d3.gscc) (size: 9160 Bytes / 0x23c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d9a65b1 (1033528753)
// size ...... 9160 (0x23c8)
// includes .. 10  (offset: 0x2128)
// strings ... 28  (offset: 0x2178)
// dev strs .. 9   (offset: 0x2338)
// exports ... 25  (offset: 0x1490)
// cseg ...... 0x2af + 0x11e1 (0x1490)
// imports ... 71  (offset: 0x1878)
// animtree1 . 0   (offset: 0x23b8)
// animtree2 . 1   (offset: 0x23b8)
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

#namespace equipmentdeploy;

// Namespace equipmentdeploy
// Params 4
// Checksum 0xa540db80, Offset: 0x2cd
// Size: 0x106
function function_d62d4ed3d2025edd( equip, gestureweaponobj, canuseinair, var_e4d45ab849b00ea5 )
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
    
    if ( equip.isdeploying )
    {
        return 0;
    }
    
    assert( isdefined( gestureweaponobj ) && gestureweaponobj.basename != "<dev string:x24>", "<dev string:x29>" + equip.ref + "<dev string:x35>" );
    function_1f56055df4a4e1a4( equip );
    thread function_4fd9e5d3093695e( equip, gestureweaponobj );
    result = weapon_utility::giveandfireoffhandreliable( gestureweaponobj );
    equip notify( #"hash_5253d4e5cb8f29fd" );
    function_4d100056292ef4a6( equip );
    
    if ( self.inlaststand )
    {
        thread function_78f2f5e216e93440( gestureweaponobj );
    }
    
    return result;
}

// Namespace equipmentdeploy
// Params 1
// Checksum 0x3fcefb83, Offset: 0x3dc
// Size: 0x39
function function_78f2f5e216e93440( gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"last_stand_finished" );
    self takeweapon( gestureweaponobj );
}

// Namespace equipmentdeploy
// Params 2
// Checksum 0xab65d09f, Offset: 0x41d
// Size: 0x5b
function function_4fd9e5d3093695e( equip, gestureweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    equip endon( #"hash_5253d4e5cb8f29fd" );
    self waittill( #"cancel_all_equip_deployments" );
    self takeweapon( gestureweaponobj );
}

#using_animtree( "script_model" );

// Namespace equipmentdeploy
// Params 10
// Checksum 0xa6c33439, Offset: 0x480
// Size: 0x209, Type: bool
function function_1ffe9de0e0c0e564( equip, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, waittime, skipfirstraise, isimmediate )
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
    tabletanimlength = getanimlength( deployanim ) - getdvarfloat( @"hash_f3ecd996c84fad86", 0.433 );
    
    if ( isdefined( waittime ) )
    {
        tabletanimlength = waittime;
    }
    
    function_1f56055df4a4e1a4( equip );
    val::set( "equipDeploy", "allow_movement", 0 );
    val::set( "equipDeploy", "allow_jump", 0 );
    val::set( "equipDeploy", "usability", 0 );
    val::set( "equipDeploy", "melee", 0 );
    val::set( "equipDeploy", "offhand_weapons", 0 );
    val::set( "equipDeploy", "supers", 0 );
    val::set( "equipDeploy", "killstreaks", 0 );
    switchresult = function_758e54afecdb4bc0( weaponobj, equip, &function_aeb72bc8cd561c78, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate );
    
    if ( isdefined( self ) && player::isreallyalive() )
    {
        val::reset_all( "equipDeploy" );
    }
    
    if ( !switchresult )
    {
        function_4d100056292ef4a6( equip );
        
        if ( isdefined( self ) )
        {
            killstreak_shared::stoptabletscreen( equip.ref );
        }
        
        return false;
    }
    
    animresult = function_9f32e9a0ab186ddc( equip, tabletanimlength, var_572ea452a1bc65ed );
    function_4d100056292ef4a6( equip );
    return istrue( animresult );
}

// Namespace equipmentdeploy
// Params 8
// Checksum 0x4677f45, Offset: 0x692
// Size: 0x19a, Type: bool
function function_465d5501b11f1b36( equip, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
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
    
    if ( equip.isdeploying )
    {
        return false;
    }
    
    function_1f56055df4a4e1a4( equip );
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x24>", "<dev string:x29>" + equip.ref + "<dev string:x73>" );
    switchresult = function_758e54afecdb4bc0( weaponobj, equip, &function_aeb72bc8cd561c78, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        function_4d100056292ef4a6( equip );
        return false;
    }
    
    if ( isdefined( equip ) && isdefined( equip.var_21f1b0b4d8d3ea8f ) )
    {
        val::group_set( equip.var_21f1b0b4d8d3ea8f, 0 );
        firedresult = function_3f2073978241821e( equip, firednotify, weaponobj, weaponfiredcallback );
        val::group_reset( equip.var_21f1b0b4d8d3ea8f );
    }
    else
    {
        val::set( "firedDeploy", "offhand_weapons", 0 );
        firedresult = function_3f2073978241821e( equip, firednotify, weaponobj, weaponfiredcallback );
        val::reset_all( "firedDeploy" );
    }
    
    function_4d100056292ef4a6( equip );
    return istrue( firedresult );
}

// Namespace equipmentdeploy
// Params 7
// Checksum 0xc835111c, Offset: 0x835
// Size: 0xd6
function function_992ef917e31e3fa4( equip, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback )
{
    assert( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x24>", "<dev string:x29>" + equip.ref + "<dev string:x73>" );
    function_1f56055df4a4e1a4( equip );
    cleanupwaitfunc = keepweapon ? &function_aeb72bc8cd561c78 : undefined;
    switchresult = function_758e54afecdb4bc0( weaponobj, equip, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !switchresult )
    {
        function_4d100056292ef4a6( equip );
        return 0;
    }
    
    function_4d100056292ef4a6( equip );
    return 1;
}

// Namespace equipmentdeploy
// Params 3, eflags: 0x4
// Checksum 0x6212c651, Offset: 0x913
// Size: 0x1a5, Type: bool
function private function_9f32e9a0ab186ddc( equip, animlength, var_572ea452a1bc65ed )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( var_572ea452a1bc65ed ) )
    {
        var_572ea452a1bc65ed = 1;
    }
    
    alias = "iw9_killstreak_tablet_gear";
    self playlocalsound( alias );
    player::setusingremote( equip.ref );
    objidpoolmanager::objective_unpin_player( self.pinnedobjid, self );
    self.remoteunpinned = 1;
    player::_freezecontrols( 1, undefined, "equipDeploy" );
    thread function_f8d16d603e3ff23c();
    
    if ( var_572ea452a1bc65ed )
    {
        thread function_4d5f07cf677200b3( animlength - 0.3 );
    }
    
    thread function_71baaa0924ac4dc9( equip );
    thread function_38bd19a2bd0bbc7c();
    
    if ( animlength > 0 )
    {
        killstreak_shared::starttabletscreen( equip.ref, 0.05 );
    }
    
    result = utility::waittill_any_timeout( animlength, "death", "weapon_change", "cancel_all_equip_deployments" );
    self notify( #"hash_45aa1c6db81cd245" );
    player::_freezecontrols( 0, undefined, "equipDeploy" );
    badplayerstate = !self isonground() && !player_utility::function_2e61ffcf29281b15() || self isonladder() || self isinfreefall() || self isparachuting();
    
    if ( result != "timeout" || badplayerstate )
    {
        self notify( #"equip_finished_with_deploy_weapon" );
        self stoplocalsound( "mp_killstreak_tablet_gear" );
        killstreak_shared::stoptabletscreen( equip.ref );
        self notify( #"cancel_remote_sequence" );
        return false;
    }
    
    self notify( #"hash_f5c8864fef988d68" );
    return true;
}

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0xeda3e285, Offset: 0xac1
// Size: 0x43
function private function_71baaa0924ac4dc9( equip )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"equip_finished_with_deploy_weapon" );
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote( 1 );
    }
}

// Namespace equipmentdeploy
// Params 0, eflags: 0x4
// Checksum 0xb16e7083, Offset: 0xb0c
// Size: 0x5e
function private function_38bd19a2bd0bbc7c()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_f5c8864fef988d68" );
    self endon( #"cancel_remote_sequence" );
    
    while ( true )
    {
        if ( !self isonground() && !player_utility::function_2e61ffcf29281b15() )
        {
            self notify( #"cancel_all_equip_deployments" );
            break;
        }
        
        waitframe();
    }
}

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0x737f6bc5, Offset: 0xb72
// Size: 0xa8
function private function_4d5f07cf677200b3( timedelay )
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

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0x1f614790, Offset: 0xc22
// Size: 0x25
function private function_4d100056292ef4a6( equip )
{
    equip.isdeploying = 0;
    val::reset_all( "deployStart" );
}

// Namespace equipmentdeploy
// Params 0, eflags: 0x4
// Checksum 0x1cfdaa44, Offset: 0xc4f
// Size: 0x35
function private function_f8d16d603e3ff23c()
{
    self endon( #"disconnect" );
    self endon( #"hash_45aa1c6db81cd245" );
    level waittill( #"round_switch" );
    player::_freezecontrols( 0, undefined, "equipDeploy" );
}

// Namespace equipmentdeploy
// Params 9
// Checksum 0xba1e0f70, Offset: 0xc8c
// Size: 0x12c
function function_758e54afecdb4bc0( deployweaponobj, equip, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate )
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
    givencallbackresult = function_8f71d8cdb129632c( equip, weapongivencallback );
    
    if ( !givencallbackresult )
    {
        inventory_utility::_takeweapon( deployweaponobj );
        return 0;
    }
    
    thread function_945b178df7020cdf( equip, deployweaponobj );
    thread function_535a4db1d305a85( equip, deployweaponobj );
    switchresult = inventory_utility::domonitoredweaponswitch( deployweaponobj, istrue( isimmediate ) );
    equip notify( #"hash_98ad369312642743" );
    
    if ( isdefined( weaponswitchendedcallback ) )
    {
        self thread [[ weaponswitchendedcallback ]]( equip, switchresult );
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
    
    thread function_ec6d0d6b81a130d( switchresult, equip, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback );
    return switchresult;
}

// Namespace equipmentdeploy
// Params 6, eflags: 0x4
// Checksum 0x96f02f80, Offset: 0xdc1
// Size: 0x156
function private function_ec6d0d6b81a130d( switchresult, equip, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( cleanupwaitfunc ) )
    {
        self [[ cleanupwaitfunc ]]( equip );
    }
    
    if ( self hasweapon( deployweaponobj ) )
    {
        remotetabletweapon = function_bf7edeca320462bc( deployweaponobj.basename );
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
            
            killstreak_shared::stoptabletscreen( equip.ref, dofdelay, 1 );
            player::_freezelookcontrols( 1 );
        }
        
        if ( isdefined( weaponcleanupcallback ) )
        {
            self [[ weaponcleanupcallback ]]( equip, switchresult, deployweaponobj );
        }
        else
        {
            function_3beed3d6d573c137( deployweaponobj );
        }
        
        val::reset_all( "cleanupDeployWeapon" );
        
        if ( remotetabletweapon )
        {
            player::_freezelookcontrols( 0 );
        }
    }
    
    if ( isdefined( weapontakencallback ) )
    {
        self [[ weapontakencallback ]]( equip );
    }
}

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0x2c398ebf, Offset: 0xf1f
// Size: 0x55
function private function_3beed3d6d573c137( deployweaponobj )
{
    inventory_utility::getridofweapon( deployweaponobj, istrue( self.var_45ab03788f1a0a4d ) );
    self.var_45ab03788f1a0a4d = undefined;
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.basename == "none" )
    {
        inventory_utility::forcevalidweapon();
    }
}

// Namespace equipmentdeploy
// Params 2, eflags: 0x4
// Checksum 0x533957d6, Offset: 0xf7c
// Size: 0x67
function private function_945b178df7020cdf( equip, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    equip endon( #"hash_98ad369312642743" );
    self waittill( #"cancel_all_equip_deployments" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace equipmentdeploy
// Params 1
// Checksum 0xefd0888a, Offset: 0xfeb
// Size: 0x5c
function function_bf7edeca320462bc( weapon )
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

// Namespace equipmentdeploy
// Params 2, eflags: 0x4
// Checksum 0x39f37a82, Offset: 0x1050
// Size: 0x83
function private function_535a4db1d305a85( equip, deployweaponobj )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    equip endon( #"hash_98ad369312642743" );
    self waittill( #"melee_swipe_start" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( deployweaponobj );
        return;
    }
    
    inventory_utility::_takeweapon( deployweaponobj );
    thread inventory_utility::domonitoredweaponswitch( self.lastdroppableweaponobj );
}

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0x58e3a7ef, Offset: 0x10db
// Size: 0x69
function private function_1f56055df4a4e1a4( equip )
{
    assert( !equip.isdeploying, "<dev string:xb4>" + equip.ref + "<dev string:xc5>" );
    equip.isdeploying = 1;
    val::set( "deployStart", "crate_use", 0 );
    val::set( "deployStart", "ascender_use", 0 );
}

// Namespace equipmentdeploy
// Params 2, eflags: 0x4
// Checksum 0x5582aeab, Offset: 0x114c
// Size: 0x55
function private function_8f71d8cdb129632c( equip, weapongivencallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"cancel_all_equip_deployments" );
    
    if ( isdefined( weapongivencallback ) )
    {
        return self [[ weapongivencallback ]]( equip );
    }
    
    return 1;
}

// Namespace equipmentdeploy
// Params 1, eflags: 0x4
// Checksum 0xad95bd2a, Offset: 0x11aa
// Size: 0x86
function private function_aeb72bc8cd561c78( equip )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    childthread function_c07ce6821f622220( self, "equip_finished_with_deploy_weapon" );
    childthread function_c07ce6821f622220( self, "cancel_all_equip_deployments" );
    childthread function_c07ce6821f622220( self, "weapon_change" );
    
    while ( true )
    {
        self waittill( #"equip_finished_with_deploy_weapon", result );
        
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

// Namespace equipmentdeploy
// Params 2, eflags: 0x4
// Checksum 0xc5eecba3, Offset: 0x1238
// Size: 0x35
function private function_c07ce6821f622220( ent, finishednotify )
{
    self endon( #"equip_finished_with_deploy_weapon" );
    ent waittill( finishednotify );
    self notify( #"equip_finished_with_deploy_weapon", finishednotify );
}

// Namespace equipmentdeploy
// Params 1
// Checksum 0x5453d688, Offset: 0x1275
// Size: 0xa8
function function_82b5d051ce3f3271( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xf4>" );
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
    
    mapweapon = utility::get_scripted_weapon_name( #"super_remote_map" );
    remotedevice = utility::get_scripted_weapon_name( #"hash_ad32c496b9288302" );
    var_e3d49e7eab9776e9 = weapon == mapweapon || weapon == remotedevice;
    return var_e3d49e7eab9776e9;
}

// Namespace equipmentdeploy
// Params 4
// Checksum 0xe7d30dbb, Offset: 0x1326
// Size: 0x169, Type: bool
function function_3f2073978241821e( equip, firednotify, var_bee4d0e47f9fa8d1, weaponfiredcallback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"weapon_change" );
    self endon( #"cancel_all_equip_deployments" );
    
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
                firedresult = [[ weaponfiredcallback ]]( equip, firedweaponobj, firedprojectile );
                
                if ( !isdefined( firedresult ) )
                {
                    assert( isdefined( firedresult ), "<dev string:x128>" );
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
                    assertmsg( "<dev string:x18b>" );
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

