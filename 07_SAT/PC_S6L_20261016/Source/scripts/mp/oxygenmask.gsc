// scripts\mp\oxygenmask.gsc  (hash_0f7aa5fb7fefa25a.gscc) (size: 7495 Bytes / 0x1d47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34c3a7aa (885237674)
// size ...... 7495 (0x1d47)
// includes .. 11  (offset: 0x1bc3)
// strings ... 21  (offset: 0x1c1b)
// dev strs .. 1   (offset: 0x1d3b)
// exports ... 30  (offset: 0xf67)
// cseg ...... 0x1c9 + 0xd9e (0xf67)
// imports ... 64  (offset: 0x1417)
// animtree1 . 0   (offset: 0x1d47)
// animtree2 . 0   (offset: 0x1d47)
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\entityheadicons;
#using scripts\mp\supers;

#namespace oxygenmask;

// Namespace oxygenmask
// Params 0
// Checksum 0xfc6ae45, Offset: 0x1e7
// Size: 0xef
function init_oxygenmask()
{
    level.oxygenmaskdata = spawnstruct();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_oxygen_mask" );
    level.oxygenmaskdata.holdweapon = bundle.useweapon;
    
    if ( isdefined( level.oxygenmaskdata.holdweapon ) )
    {
        level.oxygenmaskdata.holdweaponname = getweaponbasename( level.oxygenmaskdata.holdweapon );
    }
    else
    {
        level.oxygenmaskdata.holdweaponname = "iw9_oxygenmask";
    }
    
    level.oxygenmaskdata.var_cb7d292f69599e51 = 99;
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"init" ) )
    {
        [[ utility::getsharedfunc( #"oxygenmask", #"init" ) ]]();
    }
}

// Namespace oxygenmask
// Params 0
// Checksum 0xdabfc960, Offset: 0x2de
// Size: 0xb, Type: bool
function give_oxygenmask()
{
    thread give_oxygenmask_internal();
    return true;
}

// Namespace oxygenmask
// Params 0
// Checksum 0x2a044c17, Offset: 0x2f2
// Size: 0xc, Type: bool
function has_oxygenmask()
{
    return istrue( self.has_oxygenmask );
}

// Namespace oxygenmask
// Params 0
// Checksum 0x100ca3b9, Offset: 0x307
// Size: 0xf4
function oxygenmask_tryshowhint()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"oxygenmask_tryshowhint" );
    self endon( #"oxygenmask_tryshowhint" );
    
    if ( !isdefined( level.oxygenmaskdata.hintsplayed ) )
    {
        level.oxygenmaskdata.hintsplayed = [];
    }
    
    hintdata = level.oxygenmaskdata.hintsplayed;
    entnum = self getentitynumber();
    
    if ( !isdefined( hintdata[ entnum ] ) )
    {
        hintdata[ entnum ] = 0;
    }
    
    nummsg = getdvarint( @"hash_cfa01cde7d01c1e2", 1 );
    
    if ( nummsg <= hintdata[ entnum ] )
    {
        return;
    }
    
    lower_message::setlowermessageomnvar( "rebreather_hint" );
    wait 5;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    hintdata[ entnum ]++;
    level.oxygenmaskdata.hintsplayed = hintdata;
}

// Namespace oxygenmask
// Params 0
// Checksum 0x4b0e7d30, Offset: 0x403
// Size: 0x60, Type: bool
function function_49904dd221cb7d6f()
{
    if ( self.has_oxygenmask )
    {
        /#
            announcement( "<dev string:x24>" );
        #/
        
        if ( soundexists( "cp_oxygenmask_hiss" ) )
        {
            playsoundatpos( self.origin, "cp_oxygenmask_hiss" );
        }
        
        thread remove_oxygenmask();
        
        if ( isdefined( self.var_2c91f06ac4e87201 ) )
        {
            self.var_2c91f06ac4e87201 delete();
        }
        
        return true;
    }
    
    return false;
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x18619841, Offset: 0x46c
// Size: 0x11e
function private give_oxygenmask_internal()
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"drop_oxygenmask" );
    self notify( #"give_oxygenmask" );
    self endon( #"give_oxygenmask" );
    currweapon = self getcurrentweapon();
    
    if ( currweapon.basename != "none" )
    {
        if ( getdvarint( @"hash_44f86dd3c04fba8f", 0 ) )
        {
            self forceplaygestureviewmodel( "ges_visor_down" );
        }
    }
    
    thread oxygenmask_tryshowhint();
    function_5d697a7440144d3b( 0 );
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"ongive" ) )
    {
        self [[ utility::getsharedfunc( #"oxygenmask", #"ongive" ) ]]();
    }
    
    self.has_oxygenmask = 1;
    self.recharging_oxygenmask = undefined;
    thread oxygenmask_handle_death();
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"onequip" ) )
    {
        [[ utility::getsharedfunc( #"oxygenmask", #"onequip" ) ]]();
    }
    
    function_98a2a53ff041554d();
}

// Namespace oxygenmask
// Params 0
// Checksum 0x4cdacc44, Offset: 0x592
// Size: 0x16c
function function_98a2a53ff041554d()
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"drop_oxygenmask" );
    self endon( #"give_oxygenmask" );
    
    while ( true )
    {
        wait 0.05;
        can_use = can_use_oxygenmask();
        trying = function_641ed061a0ccfbfc();
        var_4be03bc8cf6affd5 = isdefined( self getcurrentweapon() ) && self getcurrentweapon().basename == level.oxygenmaskdata.holdweaponname;
        nonplayerstate = isdefined( self.vehicle ) && vehicle_occupancy::get_driver( self.vehicle ) == self || utility::isusingremote();
        
        if ( !var_4be03bc8cf6affd5 && !nonplayerstate )
        {
            thread remove_oxygenmask();
        }
        
        if ( trying && can_use )
        {
            function_9d3e4336af1805b( 1 );
            begin_oxygenmask();
            continue;
        }
        
        if ( trying && !can_use )
        {
            function_9d3e4336af1805b( 0 );
            
            if ( utility::issharedfuncdefined( #"oxygenmask", #"onunusable" ) )
            {
                self thread [[ utility::getsharedfunc( #"oxygenmask", #"onunusable" ) ]]();
            }
            
            continue;
        }
        
        if ( can_use && !trying )
        {
            function_9d3e4336af1805b( 1 );
            continue;
        }
        
        function_9d3e4336af1805b( 0 );
    }
}

// Namespace oxygenmask
// Params 0
// Checksum 0x66e6d3da, Offset: 0x706
// Size: 0x8, Type: bool
function function_c5fe7c2382c44c3b()
{
    return give_oxygenmask();
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0xfb543367, Offset: 0x717
// Size: 0x2
function private oxygenmask_playusesound()
{
    
}

// Namespace oxygenmask
// Params 1, eflags: 0x4
// Checksum 0x8f895fd, Offset: 0x721
// Size: 0x4d
function private function_9d3e4336af1805b( toggle )
{
    if ( self.var_247e5edbb84ad6d6 == toggle )
    {
        return;
    }
    
    self.var_247e5edbb84ad6d6 = toggle;
    
    if ( toggle )
    {
        val::reset_all( "oxygenmask_canfire" );
        return;
    }
    
    val::set( "oxygenmask_canfire", "fire", 0 );
}

// Namespace oxygenmask
// Params 1, eflags: 0x4
// Checksum 0xaf4fa956, Offset: 0x776
// Size: 0x4d
function private function_5d697a7440144d3b( toggle )
{
    if ( self.oxygenmasktoggleads == toggle )
    {
        return;
    }
    
    self.oxygenmasktoggleads = toggle;
    
    if ( toggle )
    {
        val::reset_all( "oxygenmask_canads" );
        return;
    }
    
    val::set( "oxygenmask_canads", "ads", 0 );
}

// Namespace oxygenmask
// Params 1, eflags: 0x4
// Checksum 0xd3136724, Offset: 0x7cb
// Size: 0x3d
function private function_76c5af26aa8345b6( holdweapon )
{
    self.oxygenmask_previousweapon = self getcurrentweapon();
    oxygenmaskweapon = makeweapon( holdweapon );
    inventory_utility::_giveweapon( oxygenmaskweapon );
    self switchtoweaponimmediate( oxygenmaskweapon );
}

// Namespace oxygenmask
// Params 1, eflags: 0x4
// Checksum 0x479fa880, Offset: 0x810
// Size: 0x5a
function private givedeployweapon( deployweaponname )
{
    self endon( #"death_or_disconnect" );
    
    if ( self isgestureplaying() )
    {
        self stopgestureviewmodel();
    }
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
    
    objweapon = makeweapon( deployweaponname );
    result = weapon_utility::giveandfireoffhandreliable( objweapon );
    return result;
}

// Namespace oxygenmask
// Params 1
// Checksum 0x4a2e3273, Offset: 0x873
// Size: 0x32
function set_oxygenmask_state( state )
{
    if ( self.oxygenmask_state != state )
    {
        self.oxygenmask_state = state;
        self notify( #"hash_79ba701f10c67ba7" );
    }
}

// Namespace oxygenmask
// Params 0
// Checksum 0x5750dbfa, Offset: 0x8ad
// Size: 0x1f
function get_oxygenmask_state()
{
    if ( !isdefined( self.oxygenmask_state ) )
    {
        return "";
    }
    
    return self.oxygenmask_state;
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x7e80685d, Offset: 0x8d5
// Size: 0x5f
function private oxygenmask_handle_death()
{
    self endon( #"disconnect" );
    self notify( #"oxygenmask_handle_death" );
    self endon( #"oxygenmask_handle_death" );
    self waittill( #"death" );
    
    if ( !self.has_oxygenmask )
    {
        return;
    }
    
    thread remove_oxygenmask();
    self waittill( #"spawned_player" );
    wait 1;
    give_oxygenmask();
}

// Namespace oxygenmask
// Params 0
// Checksum 0x5a015171, Offset: 0x93c
// Size: 0xd1
function remove_oxygenmask()
{
    self notify( #"drop_oxygenmask" );
    val::reset_all( "oxygenmask" );
    val::reset_all( "oxygenmask_canfire" );
    val::reset_all( "oxygenmask_canads" );
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"onremove" ) )
    {
        [[ utility::getsharedfunc( #"oxygenmask", #"onremove" ) ]]();
    }
    
    self.has_oxygenmask = undefined;
    self.using_oxygenmask = undefined;
    self.oxygenmasktoggleads = undefined;
    self.var_247e5edbb84ad6d6 = undefined;
    currweapon = self getcurrentweapon();
    
    if ( currweapon.basename != "none" )
    {
        if ( getdvarint( @"hash_44f86dd3c04fba8f", 0 ) )
        {
            self forceplaygestureviewmodel( "ges_visor_up" );
        }
    }
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x18c92ef1, Offset: 0xa15
// Size: 0x33, Type: bool
function private function_641ed061a0ccfbfc()
{
    if ( self attackbuttonpressed() || self buttonpressed( "MOUSE1" ) || self.taking_oxygenmask && player_utility::isswimmingunderwater() )
    {
        return true;
    }
    
    return false;
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x7dbad971, Offset: 0xa51
// Size: 0xca, Type: bool
function private can_use_oxygenmask()
{
    if ( !player::isreallyalive() )
    {
        return false;
    }
    
    if ( self.inlaststand )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_73621d9d9f54e301", 0 ) )
    {
        return true;
    }
    
    if ( !self isswimunderwater() )
    {
        return false;
    }
    
    if ( self isswimsprinting() )
    {
        return false;
    }
    
    if ( self israisingweapon() )
    {
        return false;
    }
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        return false;
    }
    
    if ( self.using_oxygenmask )
    {
        return false;
    }
    
    if ( self.recharging_oxygenmask )
    {
        return false;
    }
    
    if ( level.var_c29fe0e802e1dbf7 )
    {
        return false;
    }
    
    if ( self.var_3cc4f67abc216963 )
    {
        return false;
    }
    
    if ( isdefined( self.var_690b6d9c6af0eaf5 ) )
    {
        usetime = 4000;
        
        if ( gettime() < self.var_690b6d9c6af0eaf5 + usetime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x5e6fb6ea, Offset: 0xb24
// Size: 0x14
function private function_115349679abb7695()
{
    return getdvarfloat( @"hash_c5320528e750d996", 0.75 );
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0xdff978d5, Offset: 0xb41
// Size: 0x159
function private begin_oxygenmask()
{
    self endon( #"death" );
    self endon( #"oxygenmask_fail" );
    function_5d697a7440144d3b( 1 );
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"hash_59459f91432966b3" ) )
    {
        [[ utility::getsharedfunc( #"oxygenmask", #"hash_59459f91432966b3" ) ]]();
    }
    
    self.using_oxygenmask = 1;
    self.taking_oxygenmask = undefined;
    self.var_690b6d9c6af0eaf5 = gettime();
    self playlocalsound( "plr_breath_pain_init" );
    thread function_560a22a4e5da7c7f();
    thread function_811e6e959117ab44();
    thread oxygenmask_playusesound();
    self notify( #"hash_dd254884e544564a" );
    level notify( #"hash_dd254884e544564a", self );
    returnmsg = utility::waittill_notify_or_timeout_return( "weapon_fired", 4 );
    
    if ( returnmsg == "weapon_fired" )
    {
        thread function_16e1b53d31dcfba6();
    }
    
    self notify( #"oxygenmask_fired" );
    cleanup_oxygenmask();
    
    if ( utility::issharedfuncdefined( #"oxygenmask", #"onusecomplete" ) )
    {
        self [[ utility::getsharedfunc( #"oxygenmask", #"onusecomplete" ) ]]();
    }
    
    if ( getdvarint( @"hash_1280ac8ef0dd0e07", 0 ) )
    {
        self waittill( #"hash_24ac312579b091f9" );
    }
    
    while ( function_641ed061a0ccfbfc() )
    {
        wait 0.05;
    }
}

// Namespace oxygenmask
// Params 0
// Checksum 0x2ccf2631, Offset: 0xca2
// Size: 0x40
function function_560a22a4e5da7c7f()
{
    self endon( #"oxygenmask_fail" );
    self endon( #"drop_oxygenmask" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 3.32;
    thread function_9d3e4336af1805b( 0 );
}

// Namespace oxygenmask
// Params 0
// Checksum 0x9aff3a4b, Offset: 0xcea
// Size: 0x14
function cleanup_oxygenmask()
{
    self.using_oxygenmask = 0;
    function_5d697a7440144d3b( 0 );
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x1afc6b0a, Offset: 0xd06
// Size: 0x43
function private function_957e87bcfe05b1f7()
{
    self endon( #"death" );
    delay = 1;
    
    if ( self.var_dd5e6e8c9b46a45e )
    {
        delay = 0.1;
    }
    
    self.var_dd5e6e8c9b46a45e = 1;
    wait delay;
    self stopforcedfire();
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0xa423fffc, Offset: 0xd51
// Size: 0xab
function private enable_headicon()
{
    icon = "hud_icon_equipment_oxygen";
    offset = 16;
    drawwalls = 1;
    toshowto = [];
    
    if ( level.players.size == 1 )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] != self )
        {
            toshowto[ toshowto.size ] = level.players[ i ];
        }
    }
    
    self.oxygen_headicon = entityheadicons::setheadicon_singleimage( toshowto, icon, offset, 0, 512, 100, 0, 0, drawwalls, undefined, 1 );
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0xbc1d7df2, Offset: 0xe04
// Size: 0x29
function private disable_headicon()
{
    if ( isdefined( self.oxygen_headicon ) )
    {
        entityheadicons::setheadicon_deleteicon( self.oxygen_headicon );
        self.oxygen_headicon = undefined;
    }
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x78028617, Offset: 0xe35
// Size: 0x8b
function private debug_allow_shoot_while_ufoing()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_oxygenmask" );
    currentstate = 0;
    
    while ( true )
    {
        if ( self isufo() && currentstate == 0 )
        {
            currentstate = 1;
            val::reset_all( "debug_allow_shoot_while_ufoing" );
        }
        else if ( !self isufo() && currentstate == 1 )
        {
            currentstate = 0;
            val::set( "debug_allow_shoot_while_ufoing", "fire", 0 );
        }
        
        wait 0.05;
    }
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0x9cbc5983, Offset: 0xec8
// Size: 0x60
function private function_16e1b53d31dcfba6()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"give_oxygenmask" );
    refreshamt = getdvarint( @"hash_dbb8c128e4b02706", level.oxygenmaskdata.var_cb7d292f69599e51 );
    swim_common::function_e59f9853946b5d19( refreshamt, &function_115349679abb7695 );
}

// Namespace oxygenmask
// Params 0, eflags: 0x4
// Checksum 0xf9b329e0, Offset: 0xf30
// Size: 0x37
function private function_811e6e959117ab44()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self startforcedfire();
    utility::waittill_any( "oxygenmask_fail", "oxygenmask_fired" );
    self stopforcedfire();
}

