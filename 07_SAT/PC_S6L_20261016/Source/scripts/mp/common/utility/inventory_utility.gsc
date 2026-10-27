// scripts\mp\common\utility\inventory_utility.gsc  (hash_02bf5529af94c9a0.gscc) (size: 8173 Bytes / 0x1fed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe34f3553 (3813619027)
// size ...... 8173 (0x1fed)
// includes .. 4   (offset: 0x1d85)
// strings ... 22  (offset: 0x1da5)
// dev strs .. 22  (offset: 0x1ee5)
// exports ... 24  (offset: 0x10c5)
// cseg ...... 0x24c + 0xe79 (0x10c5)
// imports ... 70  (offset: 0x1485)
// animtree1 . 0   (offset: 0x1fed)
// animtree2 . 0   (offset: 0x1fed)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace inventory_utility;

// Namespace inventory_utility
// Params 5
// Checksum 0x3ffc78df, Offset: 0x26a
// Size: 0x9a
function _giveweapon( weapon, variant = -1, dualwieldoverride, usedbefore = utility::shouldskipfirstraise(), var_31b84291bf81176d )
{
    /#
        if ( getdvarint( @"hash_111ef391787da7e1", 0 ) == 1 )
        {
            usedbefore = 0;
            self iprintlnbold( "<dev string:x24>" );
        }
    #/
    
    self giveweapon( weapon, variant, istrue( dualwieldoverride ), -1, usedbefore, istrue( var_31b84291bf81176d ) );
    callback::callback( #"player_weapon_give", { #weapon:weapon } );
}

// Namespace inventory_utility
// Params 1
// Checksum 0xd9211307, Offset: 0x30c
// Size: 0x4e
function _switchtoweapon( weapon )
{
    if ( isweapon( weapon ) || isstring( weapon ) )
    {
        /#
            debugweaponchangeprint( "<dev string:x41>", weapon );
        #/
        
        self switchtoweapon( weapon );
        return;
    }
    
    assertmsg( "<dev string:x56>" + weapon );
}

// Namespace inventory_utility
// Params 1
// Checksum 0xe24e25ab, Offset: 0x362
// Size: 0x25
function _switchtoweaponimmediate( weapon )
{
    /#
        debugweaponchangeprint( "<dev string:x7e>", weapon );
    #/
    
    self switchtoweaponimmediate( weapon );
}

// Namespace inventory_utility
// Params 1
// Checksum 0x79d09f6b, Offset: 0x38f
// Size: 0x108
function _takeweapon( weapon )
{
    /#
        if ( getdvarint( @"hash_e6a5211d6811a3e", 0 ) != 0 )
        {
            debugweaponchangeprint( "<dev string:x9c>", weapon );
            
            if ( iscurrentweapon( weapon ) )
            {
                println( "<dev string:xad>" );
            }
        }
    #/
    
    if ( isweapon( weapon ) && isnullweapon( weapon ) )
    {
        assertmsg( "<dev string:xc9>" );
        return;
    }
    
    var_f3cb828363807f0e = 0;
    
    if ( isweapon( weapon ) )
    {
        var_f3cb828363807f0e = self gethighpriorityweapon() == weapon;
    }
    else
    {
        assert( isstring( weapon ) );
        var_f3cb828363807f0e = getcompleteweaponname( self gethighpriorityweapon() ) == weapon;
    }
    
    if ( var_f3cb828363807f0e )
    {
        weaponstring = weapon;
        
        if ( !isstring( weaponstring ) && isweapon( weapon ) )
        {
            weaponstring = getcompleteweaponname( weapon );
        }
        
        assertmsg( "<dev string:xed>" + weaponstring + "<dev string:x131>" );
        self clearhighpriorityweapon( weapon );
    }
    
    self takeweapon( weapon );
    callback::callback( #"player_weapon_take" );
}

// Namespace inventory_utility
// Params 1
// Checksum 0xaf26edc2, Offset: 0x49f
// Size: 0x8a
function takeweaponwhensafe( weapon )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        var_342a2e2a90f812bd = 0;
        
        if ( !iscurrentweapon( weapon ) )
        {
            meleeoverrideweapon = self getweaponmeleeslot();
            
            if ( !isnullweapon( meleeoverrideweapon ) && self.currentweapon == meleeoverrideweapon )
            {
                var_342a2e2a90f812bd = 0;
            }
            else
            {
                var_342a2e2a90f812bd = 1;
            }
        }
        
        if ( var_342a2e2a90f812bd )
        {
            break;
        }
        
        waitframe();
    }
    
    _takeweapon( weapon );
}

// Namespace inventory_utility
// Params 0
// Checksum 0xeb141c40, Offset: 0x531
// Size: 0x26
function getcurrentmonitoredweaponswitchweapon()
{
    validatehighpriorityflag();
    currenthighpriorityweapon = self gethighpriorityweapon();
    
    if ( isnullweapon( currenthighpriorityweapon ) )
    {
        return;
    }
    
    return currenthighpriorityweapon;
}

// Namespace inventory_utility
// Params 0
// Checksum 0x2b28c7d6, Offset: 0x560
// Size: 0x9, Type: bool
function isanymonitoredweaponswitchinprogress()
{
    return isdefined( getcurrentmonitoredweaponswitchweapon() );
}

// Namespace inventory_utility
// Params 1
// Checksum 0xf7329079, Offset: 0x572
// Size: 0x41, Type: bool
function isswitchingtoweaponwithmonitoring( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    currentswitchweapon = getcurrentmonitoredweaponswitchweapon();
    return currentswitchweapon == weaponobj && !iscurrentweapon( weaponobj );
}

// Namespace inventory_utility
// Params 2
// Checksum 0xd24f44af, Offset: 0x5bc
// Size: 0x158, Type: bool
function candomonitoredswitchtoweapon( weapon, var_e90b0e794aa74425 )
{
    if ( !self hasweapon( weapon ) )
    {
        return false;
    }
    
    if ( !val::get( "weapon" ) )
    {
        return false;
    }
    
    if ( !var_e90b0e794aa74425 && !val::get( "weapon_switch" ) && !val::get( "script_weapon_switch" ) )
    {
        return false;
    }
    
    if ( self isviewmodelanimplaying() )
    {
        return false;
    }
    
    currenthighpriorityweapon = getcurrentmonitoredweaponswitchweapon();
    
    if ( isdefined( currenthighpriorityweapon ) )
    {
        weaponbasename = getweaponbasename( weapon );
        newweaponhaspriority = 0;
        
        if ( weaponbasename == "briefcase_bomb_mp" || weaponbasename == "briefcase_bomb_defuse_mp" || weaponbasename == "briefcase_silent_mp" || weaponbasename == "briefcase_defuse_silent_mp" || weaponbasename == "counter_attack_bomb_mp" || weaponbasename == "counter_attack_bomb_defuse_mp" || weaponbasename == "counter_attack_bomb_silent_mp" || weaponbasename == "counter_attack_bomb_defuse_silent_mp" || weaponbasename == "briefcase_bomb_mp_nuke" || weaponbasename == "iw9_cyberemp_mp" || weaponbasename == "iw7_tdefball_mp" || weaponbasename == "rex_hijack_bomb_carry_mp" )
        {
            newweaponhaspriority = 1;
        }
        else if ( weaponinventorytype( currenthighpriorityweapon ) == "primary" )
        {
            newweaponhaspriority = 1;
        }
        
        if ( !newweaponhaspriority )
        {
            return false;
        }
    }
    
    if ( iscurrentweapon( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace inventory_utility
// Params 1
// Checksum 0x569b35f8, Offset: 0x71d
// Size: 0x4f
function abortmonitoredweaponswitch( weapon )
{
    /#
        debugweaponchangeprint( "<dev string:x14f>", weapon );
    #/
    
    assert( !iscurrentweapon( weapon ), "<dev string:x159>" );
    
    if ( self gethighpriorityweapon() == weapon )
    {
        self clearhighpriorityweapon( weapon );
    }
    
    _takeweapon( weapon );
}

// Namespace inventory_utility
// Params 4
// Checksum 0xf3eed548, Offset: 0x775
// Size: 0x167
function domonitoredweaponswitch( weapon, switchimmediate, var_e90b0e794aa74425, canceloffhand )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    /#
        debugweaponchangeprint( "<dev string:x1a3>", weapon );
    #/
    
    if ( !candomonitoredswitchtoweapon( weapon, var_e90b0e794aa74425 ) )
    {
        /#
            debugweaponchangeprint( "<dev string:x1c7>", weapon );
        #/
        
        return 0;
    }
    
    if ( isanymonitoredweaponswitchinprogress() )
    {
        self clearhighpriorityweapon( getcurrentmonitoredweaponswitchweapon() );
    }
    
    self sethighpriorityweapon( weapon );
    
    if ( switchimmediate )
    {
        _switchtoweaponimmediate( weapon );
    }
    
    while ( true )
    {
        if ( iscurrentweapon( weapon ) )
        {
            validatehighpriorityflag();
            
            /#
                debugweaponchangeprint( "<dev string:x1f2>", weapon );
            #/
            
            return 1;
        }
        
        if ( !self ishighpriorityweapon( weapon ) || !self hasweapon( weapon ) )
        {
            /#
                debugweaponchangeprint( "<dev string:x218>", weapon );
            #/
            
            return 0;
        }
        
        if ( !val::get( "weapon" ) || !var_e90b0e794aa74425 && !val::get( "weapon_switch" ) && !val::get( "script_weapon_switch" ) )
        {
            /#
                debugweaponchangeprint( "<dev string:x25a>", weapon );
            #/
            
            self clearhighpriorityweapon( weapon );
            return 0;
        }
        
        if ( canceloffhand && !isnullweapon( self getheldoffhand() ) )
        {
            self canceloffhands();
        }
        
        waitframe();
    }
}

// Namespace inventory_utility
// Params 0
// Checksum 0xb44d5e8f, Offset: 0x8e4
// Size: 0x7
function function_17bee3f2e45888ee()
{
    return "iw9_gunless_mp";
}

// Namespace inventory_utility
// Params 0
// Checksum 0x97f96dd7, Offset: 0x8f4
// Size: 0x7
function function_772803634a9c0f0a()
{
    return "iw9_gunless_quickdrop_mp";
}

// Namespace inventory_utility
// Params 1
// Checksum 0xef38ef91, Offset: 0x904
// Size: 0x1a
function givegunlessweapon( switchimmediate )
{
    return function_9ecb1e4c6649d1c2( switchimmediate, function_17bee3f2e45888ee() );
}

// Namespace inventory_utility
// Params 1
// Checksum 0xd2ac5b99, Offset: 0x927
// Size: 0x1a
function function_c13571020bd38158( switchimmediate )
{
    return function_9ecb1e4c6649d1c2( switchimmediate, function_772803634a9c0f0a() );
}

// Namespace inventory_utility
// Params 2
// Checksum 0x64b4fb37, Offset: 0x94a
// Size: 0xf2
function function_9ecb1e4c6649d1c2( switchimmediate, weaponname )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    if ( isdefined( self.gunnlessweapon ) )
    {
        return;
    }
    
    gunless = makeweapon( weaponname );
    _giveweapon( gunless, undefined, undefined, 1 );
    self.gunnlessweapon = gunless;
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x28f>" );
    
    if ( !isdefined( switchimmediate ) )
    {
        switchimmediate = 0;
    }
    
    success = domonitoredweaponswitch( gunless, switchimmediate );
    
    if ( !success )
    {
        _takeweapon( gunless );
        forcevalidweapon();
    }
    
    val::reset( "gunless", "script_weapon_switch" );
    println( self.name + "<dev string:x2b7>" );
    return success;
}

// Namespace inventory_utility
// Params 1
// Checksum 0x7f20da45, Offset: 0xa45
// Size: 0x169
function takegunlessweapon( restoredweapon )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) )
    {
        return;
    }
    
    if ( !self hasweapon( self.gunnlessweapon ) )
    {
        self.gunnlessweapon = undefined;
        return;
    }
    
    if ( utility::ent_flag_exist( "swapLoadout_pending" ) && utility::ent_flag( "swapLoadout_pending" ) )
    {
        utility::ent_flag_wait( "swapLoadout_complete" );
    }
    
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x2df>" );
    
    while ( isdefined( self.gunnlessweapon ) && self hasweapon( self.gunnlessweapon ) )
    {
        if ( !iscurrentweapon( self.gunnlessweapon ) )
        {
            abortmonitoredweaponswitch( self.gunnlessweapon );
        }
        else
        {
            _takeweapon( self.gunnlessweapon );
            
            if ( isweapon( restoredweapon ) )
            {
                domonitoredweaponswitch( restoredweapon );
                
                if ( self getcurrentweapon().basename == "none" )
                {
                    forcevalidweapon();
                }
            }
            else
            {
                forcevalidweapon();
            }
        }
        
        waitframe();
    }
    
    self.gunnlessweapon = undefined;
    val::reset( "gunless", "script_weapon_switch" );
    println( self.name + "<dev string:x307>" );
}

// Namespace inventory_utility
// Params 0
// Checksum 0xf2867b51, Offset: 0xbb6
// Size: 0x25
function validatehighpriorityflag()
{
    currentweapon = self getcurrentweapon();
    
    if ( self ishighpriorityweapon( currentweapon ) )
    {
        self clearhighpriorityweapon( currentweapon );
    }
}

// Namespace inventory_utility
// Params 2
// Checksum 0x8fd63968, Offset: 0xbe3
// Size: 0x147, Type: bool
function getridofweapon( weapon, switchimmediate )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !self hasweapon( weapon ) )
    {
        return false;
    }
    
    if ( !iscurrentweapon( weapon ) )
    {
        _takeweapon( weapon );
        return true;
    }
    
    while ( isanymonitoredweaponswitchinprogress() )
    {
        waitframe();
    }
    
    if ( !iscurrentweapon( weapon ) )
    {
        _takeweapon( weapon );
        return true;
    }
    
    lastvalidweapon = self.lastdroppableweaponobj;
    
    if ( utility::issharedfuncdefined( #"weapons", #"isCurrentTertiaryWeapon" ) && [[ utility::getsharedfunc( #"weapons", #"isCurrentTertiaryWeapon" ) ]]( self, self.lastnormalweaponobj ) )
    {
        lastvalidweapon = self.lastnormalweaponobj;
    }
    
    switchresult = domonitoredweaponswitch( lastvalidweapon, switchimmediate );
    
    if ( isai( self ) || isautopilot( self ) )
    {
        self switchtoweaponimmediate( nullweapon() );
        switchresult = 1;
    }
    
    _takeweapon( weapon );
    self notify( #"hash_caf664dbe9872771" );
    
    if ( !switchresult && !isdefined( self.vehicle ) )
    {
        forcevalidweapon();
    }
    
    return true;
}

// Namespace inventory_utility
// Params 1
// Checksum 0x3daded0e, Offset: 0xd33
// Size: 0x24e
function forcevalidweapon( bestweaponobj )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( isnullweapon( self getcurrentweapon() ) )
    {
        if ( self isswitchingweapon() || isanymonitoredweaponswitchinprogress() )
        {
            waitframe();
            continue;
        }
        
        var_fdce5d6df27760eb = bestweaponobj;
        
        if ( self.isjuggernaut )
        {
            var_a3742a26443de44b = self.juggcontext.juggconfig.classstruct.loadoutprimary;
            
            if ( self.juggcontext.juggconfig.getminigunweaponfunc )
            {
                var_a3742a26443de44b = self [[ self.juggcontext.juggconfig.getminigunweaponfunc ]]();
            }
            
            if ( self.juggcontext.juggconfig.useweaponpickups )
            {
                if ( self.lastdroppableweaponobj && self hasweapon( self.lastdroppableweaponobj ) )
                {
                    var_a3742a26443de44b = self.lastdroppableweaponobj;
                }
                else
                {
                    currentprimaries = getcurrentprimaryweaponsminusalt();
                    
                    if ( currentprimaries.size > 0 )
                    {
                        var_a3742a26443de44b = currentprimaries[ 0 ];
                    }
                }
            }
            
            var_fdce5d6df27760eb = isstring( var_a3742a26443de44b ) ? makeweapon( var_a3742a26443de44b ) : var_a3742a26443de44b;
        }
        else
        {
            currentprimaries = getcurrentprimaryweaponsminusalt();
            
            if ( !isdefined( var_fdce5d6df27760eb ) || !self hasweapon( var_fdce5d6df27760eb ) )
            {
                if ( ( !isdefined( self.lastdroppableweaponobj ) || self.lastdroppableweaponobj.basename == "none" ) && !self hasweapon( level.defaultfist ) )
                {
                    assertmsg( "<dev string:x32f>" );
                    break;
                }
                
                if ( self hasweapon( self.lastdroppableweaponobj ) )
                {
                    var_fdce5d6df27760eb = self.lastdroppableweaponobj;
                }
                else if ( currentprimaries.size > 0 )
                {
                    var_fdce5d6df27760eb = currentprimaries[ 0 ];
                }
            }
            
            if ( self hasweapon( level.defaultfist ) )
            {
                if ( currentprimaries.size == 1 )
                {
                    var_fdce5d6df27760eb = currentprimaries[ 0 ];
                }
                else if ( currentprimaries.size == 2 && self hasweapon( level.defaultknifestab ) )
                {
                    if ( weapon::isfistweapon( currentprimaries[ 0 ] ) )
                    {
                        var_fdce5d6df27760eb = currentprimaries[ 0 ];
                    }
                    else
                    {
                        var_fdce5d6df27760eb = currentprimaries[ 1 ];
                    }
                }
            }
        }
        
        domonitoredweaponswitch( var_fdce5d6df27760eb );
        waitframe();
    }
}

// Namespace inventory_utility
// Params 1
// Checksum 0x46c7f5db, Offset: 0xf89
// Size: 0x2d
function iscurrentweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return issameweapon( self getcurrentweapon(), weaponobj, 1 );
}

// Namespace inventory_utility
// Params 0
// Checksum 0x389ff0a1, Offset: 0xfbf
// Size: 0x9d
function getcurrentprimaryweaponsminusalt()
{
    primaryweapons = [];
    currentweapons = self getweaponslistprimaries();
    
    foreach ( weapon in currentweapons )
    {
        if ( !weapon.isalternate )
        {
            primaryweapons[ primaryweapons.size ] = weapon;
        }
    }
    
    return primaryweapons;
}

/#

    // Namespace inventory_utility
    // Params 2
    // Checksum 0x182193da, Offset: 0x1065
    // Size: 0x60, Type: dev
    function debugweaponchangeprint( message, weapon )
    {
        weaponstring = undefined;
        
        if ( isstring( weapon ) )
        {
            weaponstring = weapon;
        }
        else
        {
            weaponstring = getcompleteweaponname( weapon );
        }
        
        if ( getdvarint( @"hash_e6a5211d6811a3e", 0 ) != 0 )
        {
            println( message + "<dev string:x391>" + weaponstring );
        }
    }

#/
