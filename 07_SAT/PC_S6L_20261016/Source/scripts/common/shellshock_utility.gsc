// scripts\common\shellshock_utility.gsc  (hash_6853191397ec0259.gscc) (size: 5590 Bytes / 0x15d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c5e7e87 (2623438471)
// size ...... 5590 (0x15d6)
// includes .. 3   (offset: 0x147a)
// strings ... 16  (offset: 0x1492)
// dev strs .. 10  (offset: 0x155e)
// exports ... 19  (offset: 0xce2)
// cseg ...... 0x158 + 0xb8a (0xce2)
// imports ... 39  (offset: 0xfda)
// animtree1 . 0   (offset: 0x15d6)
// animtree2 . 0   (offset: 0x15d6)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;

#namespace shellshock_utility;

// Namespace shellshock_utility
// Params 0
// Checksum 0x3a2b9965, Offset: 0x176
// Size: 0x1ed
function init()
{
    level._effect[ "melee_spray" ] = loadfxasset( level.gamemodebundle.var_a6fad0bfb41724f5 );
    level._effect[ "melee_spray_3d" ] = loadfxasset( level.gamemodebundle.var_7769079bc3899d62 );
    level.enableshellshockfunc = &enableshellshockfunc;
    level.disableshellshockfunc = &disableshellshockfunc;
    level.shockpriorities = [];
    level.shockpriorities[ #"top" ] = 0;
    level.shockpriorities[ #"flash" ] = 1;
    level.shockpriorities[ #"stun" ] = 2;
    level.shockpriorities[ #"gas" ] = 3;
    level.shockpriorities[ #"poison" ] = 4;
    level.shockpriorities[ #"explosion" ] = 5;
    level.shockpriorities[ #"damage" ] = 6;
    level.shockpriorities[ #"bottom" ] = 7;
    level.shockinterruptdelayfuncs[ #"top" ] = &shellshock_interruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"flash" ] = &shellshock_flashinterruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"stun" ] = &shellshock_stuninterruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"gas" ] = &shellshock_gasinterruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"poison" ] = &shellshock_gasinterruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"explosion" ] = &shellshock_interruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"damage" ] = &shellshock_damageinterruptdelayfunc;
    level.shockinterruptdelayfuncs[ #"bottom" ] = &shellshock_nointerruptdelayfunc;
}

// Namespace shellshock_utility
// Params 5
// Checksum 0x254aa7b, Offset: 0x36b
// Size: 0x23e
function _shellshock( name, category, duration, animationresponse, interruptdelayms )
{
    if ( !isdefined( interruptdelayms ) )
    {
        if ( isdefined( level.shockinterruptdelayfuncs[ category ] ) )
        {
            interruptdelayms = [[ level.shockinterruptdelayfuncs[ category ] ]]( name, duration );
            
            if ( !isdefined( interruptdelayms ) )
            {
                assertmsg( "<dev string:x24>" + getxhashsourcename( name ) + "<dev string:x44>" + getxhashsourcename( category ) + "<dev string:x54>" );
                interruptdelayms = 0;
            }
        }
        else
        {
            assertmsg( "<dev string:x69>" + getxhashsourcename( category ) + "<dev string:x9f>" );
            interruptdelayms = 0;
        }
    }
    
    var_a14652a58d8856be = gettime() + interruptdelayms;
    
    if ( category != "top" )
    {
        if ( !val::get( "shellshock" ) )
        {
            return 0;
        }
    }
    
    if ( isdefined( self.shockcategory ) )
    {
        curpriority = level.shockpriorities[ self.shockcategory ];
        newpriority = level.shockpriorities[ category ];
        
        if ( !isdefined( newpriority ) )
        {
            assert( isdefined( level.shockpriorities ), "<dev string:xa1>" );
            assert( isxhash( category ), "<dev string:xd6>" );
            assert( isdefined( level.shockpriorities[ category ] ), "<dev string:x10f>" );
            newpriority = 0;
        }
        
        if ( newpriority > curpriority )
        {
            if ( gettime() < self.shockinterrupttime )
            {
                return 0;
            }
        }
        else if ( newpriority == curpriority )
        {
            if ( var_a14652a58d8856be < self.shockinterrupttime )
            {
                return 0;
            }
        }
    }
    
    self.shockname = name;
    self.shockcategory = category;
    self.shockinterrupttime = var_a14652a58d8856be;
    assert( isxhashasset( self.shockname ) );
    var_1be66dbfcdfae631 = 0;
    
    if ( isdefined( self.perks[ "specialty_dauntless" ] ) || self.perks[ "specialty_poise_stagger_immunity" ] || self.var_b4300d21ff2d6a8e )
    {
        var_1be66dbfcdfae631 = 1;
    }
    
    if ( isdefined( animationresponse ) )
    {
        self shellshock( name, duration, animationresponse, var_1be66dbfcdfae631 );
    }
    else
    {
        self shellshock( name, duration, 0, var_1be66dbfcdfae631 );
    }
    
    thread shellshock_cleanup( duration );
}

// Namespace shellshock_utility
// Params 1, eflags: 0xc
// Checksum 0x951c6b42, Offset: 0x5b1
// Size: 0x5d
function private shellshock_cleanup( duration )
{
    self notify( #"hash_f045ad0473abce11" );
    self endon( #"hash_f045ad0473abce11" );
    self endon( #"disconnect" );
    self endon( #"_stopshellshock" );
    wait duration;
    self.shockname = undefined;
    self.shockcategory = undefined;
    self.shockinterrupttime = undefined;
}

// Namespace shellshock_utility
// Params 1
// Checksum 0xdecdd35, Offset: 0x616
// Size: 0x49
function _stopshellshock( fromdeath )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"_stopshellshock" );
    
    if ( !fromdeath )
    {
        self stopshellshock();
    }
    
    self.shockname = undefined;
    self.shockcategory = undefined;
    self.shockinterrupttime = undefined;
}

// Namespace shellshock_utility
// Params 0
// Checksum 0xba62fc93, Offset: 0x667
// Size: 0x2
function enableshellshockfunc()
{
    
}

// Namespace shellshock_utility
// Params 0
// Checksum 0x607db346, Offset: 0x671
// Size: 0xf
function disableshellshockfunc()
{
    _stopshellshock( namespace_9d8e359c3b1041e5::isalivesharedfunc() );
}

// Namespace shellshock_utility
// Params 2
// Checksum 0xecb539da, Offset: 0x688
// Size: 0x1a
function shellshock_interruptdelayfunc( name, duration )
{
    return 250;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0xcefd3a34, Offset: 0x6ab
// Size: 0x8f
function shellshock_flashinterruptdelayfunc( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case %"flash_grenade_mp":
            if ( utility::issharedfuncdefined( #"shellshock", #"flashinterruptdelayfunc" ) )
            {
                interruptdelay = [[ utility::getsharedfunc( #"shellshock", #"flashinterruptdelayfunc" ) ]]( duration );
            }
            
            break;
        default:
            assertmsg( "<dev string:x188>" );
            break;
    }
    
    return interruptdelay;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0x532c2431, Offset: 0x743
// Size: 0x1af
function shellshock_stuninterruptdelayfunc( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case %"hash_100dc26b14e0f9f":
        case %"rex_akilo_radiation_wave":
        case %"zm_ai_callisto_stun_shock":
        case %"sound_veil_reduced_mp":
        case %"concussion_grenade_mp":
        case %"hash_2c54c3375bf797cb":
        case %"concussion_grenade_tac_mask_mp":
        case %"sound_veil_mp":
        case %"concussion_grenade_flashed_mp":
        case %"emp":
        case %"rex_poison_mp":
        case %"hash_56e9bc574acd9d63":
        case %"suppression_rounds_mp":
        case %"bomb_stun_mp":
        case %"hash_6a0f96eeec41b5b6":
        case %"hash_6a78e0ea87d21472":
        case %"hash_6a78e1ea87d21625":
        case %"hash_7086cdd1816e7832":
        case %"sat_concussion_grenade_mp":
            if ( utility::issharedfuncdefined( #"shellshock", #"concussioninterruptdelayfunc" ) )
            {
                interruptdelay = [[ utility::getsharedfunc( #"shellshock", #"concussioninterruptdelayfunc" ) ]]( duration );
            }
            
            break;
        case %"thermobaric_grenade":
            if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_shellshock_interrupt_delay" ) )
            {
                interruptdelay = [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_shellshock_interrupt_delay" ) ]]( duration );
            }
            
            break;
        default:
            assertmsg( "<dev string:x1c8>" );
            break;
    }
    
    return interruptdelay;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0x10a20bc9, Offset: 0x8fb
// Size: 0x98
function shellshock_gasinterruptdelayfunc( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case %"gas_grenade_light_mp":
        case %"gas_grenade_heavy_mp":
            if ( utility::issharedfuncdefined( #"shellshock", #"gasinterruptdelayfunc" ) )
            {
                interruptdelay = [[ utility::getsharedfunc( #"shellshock", #"gasinterruptdelayfunc" ) ]]( duration );
            }
            
            break;
        default:
            interruptdelay = shellshock_interruptdelayfunc( duration );
            break;
    }
    
    return interruptdelay;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0x94175ece, Offset: 0x99c
// Size: 0x8c
function shellshock_damageinterruptdelayfunc( name, duration )
{
    interruptdelay = undefined;
    
    switch ( name )
    {
        case %"last_stand_mp":
            if ( utility::issharedfuncdefined( #"shellshock", #"laststandinterruptdelayfunc" ) )
            {
                interruptdelay = [[ utility::getsharedfunc( #"shellshock", #"laststandinterruptdelayfunc" ) ]]( duration );
            }
            
            break;
        default:
            interruptdelay = shellshock_interruptdelayfunc( duration );
            break;
    }
    
    return interruptdelay;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0xdefa58ac, Offset: 0xa31
// Size: 0x16, Type: bool
function shellshock_nointerruptdelayfunc( name, duration )
{
    return false;
}

// Namespace shellshock_utility
// Params 2
// Checksum 0xdc5b1d81, Offset: 0xa50
// Size: 0xbf
function bloodmeleeeffect( objweapon, position )
{
    self endon( #"disconnect" );
    
    if ( !isdismembermentenabled() )
    {
        return;
    }
    
    scriptablestate = usescriptablemeleeblood( objweapon );
    
    if ( isdefined( scriptablestate ) )
    {
        thread activatemeleeblood( scriptablestate );
        return;
    }
    
    if ( !function_ddf16b3ce5089ee() )
    {
        string_array = [ "death", "disconnect" ];
        
        if ( isdefined( position ) )
        {
            thread play_fx_with_entity( level._effect[ "melee_spray_3d" ], string_array, 1.5, position );
            return;
        }
        
        thread play_fx_with_entity( level._effect[ "melee_spray" ], string_array, 1.5, self geteye() );
    }
}

// Namespace shellshock_utility
// Params 1
// Checksum 0x87c93305, Offset: 0xb17
// Size: 0x63
function usescriptablemeleeblood( objweapon )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.receiver ) ) )
    {
        return;
    }
    
    if ( function_533fe8b97a62433f( objweapon ) )
    {
        return "bloodFXNova";
    }
    
    if ( isdoomchainsaw( objweapon ) )
    {
        return "bloodFXDoom";
    }
    
    if ( objweapon.receiver == "iw9_me_sword01" )
    {
        return "bloodFX";
    }
    
    return;
}

// Namespace shellshock_utility
// Params 1
// Checksum 0x47c2d3da, Offset: 0xb82
// Size: 0x60, Type: bool
function function_533fe8b97a62433f( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( !( isdefined( weapon.basename ) && isdefined( weapon.variantid ) ) )
    {
        return false;
    }
    
    if ( weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace shellshock_utility
// Params 1
// Checksum 0x7b494fdd, Offset: 0xbeb
// Size: 0x4b, Type: bool
function isdoomchainsaw( weapon )
{
    if ( isdefined( weapon ) && isdefined( weapon.receiver ) )
    {
        if ( weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace shellshock_utility
// Params 1
// Checksum 0x15f906c6, Offset: 0xc3f
// Size: 0x37
function activatemeleeblood( state )
{
    self endon( #"disconnect" );
    self setscriptablepartstate( "meleeBlood", state );
    waitframe();
    waitframe();
    self setscriptablepartstate( "meleeBlood", "neutral" );
}

// Namespace shellshock_utility
// Params 4
// Checksum 0xbd193203, Offset: 0xc7e
// Size: 0x64
function play_fx_with_entity( fx, string_array, timeout, position )
{
    var_7841cb48614d9df4 = namespace_9d8e359c3b1041e5::spawnfxforclientsharedfunc( fx, position, self );
    triggerfx( var_7841cb48614d9df4 );
    var_7841cb48614d9df4 namespace_9d8e359c3b1041e5::setfxkilldefondeletesharedfunc();
    utility::waittill_any_in_array_or_timeout( string_array, timeout );
    
    if ( isdefined( var_7841cb48614d9df4 ) )
    {
        var_7841cb48614d9df4 delete();
    }
}

