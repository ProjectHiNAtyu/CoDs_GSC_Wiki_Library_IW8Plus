// script_4a9826f56ea1144  (hash_04a9826f56ea1144.gscc) (size: 2052 Bytes / 0x804 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f9b1389 (2409304969)
// size ...... 2052 (0x804)
// includes .. 4   (offset: 0x794)
// strings ... 5   (offset: 0x7b4)
// dev strs .. 0   (offset: 0x804)
// exports ... 6   (offset: 0x418)
// cseg ...... 0xdb + 0x33d (0x418)
// imports ... 22  (offset: 0x508)
// animtree1 . 0   (offset: 0x804)
// animtree2 . 0   (offset: 0x804)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace specialty_overcharge_field_upgrade;

// Namespace specialty_overcharge_field_upgrade
// Params 0, eflags: 0x1
// Checksum 0x9029c5d2, Offset: 0xf9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_overcharge_field_upgrade
// Params 1
// Checksum 0x4602bcae, Offset: 0x119
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_overcharge_field_upgrade", &function_ce16a1929c792bad, &function_78dfd387d6168678, [] );
    }
}

// Namespace specialty_overcharge_field_upgrade
// Params 0
// Checksum 0x829e3b4e, Offset: 0x15b
// Size: 0x10f
function function_ce16a1929c792bad()
{
    var_285aef9e90d5b24b = self.var_9842326056fd7207.var_7f51fbc2a4951e75 ?? 1.4;
    val::set( "specialty_overcharge_field_upgrade", "field_upgrade_recharge_mult", var_285aef9e90d5b24b );
    
    if ( isbrgamemode() )
    {
        if ( getdvarint( @"hash_8c032d1b63113ba0", 0 ) != 0 )
        {
            return;
        }
        
        self.var_760a3e04da86556f = 1;
        self.var_eba31f12191a731f = getdvarint( @"hash_5873a982b260e538", 1 );
        self.overclockcharge = 0;
        superammo = equipment_mp::getequipmentslotammo( "super" );
        
        if ( isdefined( supers_mp::getcurrentsuper() ) && superammo > 0 )
        {
            if ( supers_mp::function_31f00fe6e0334d03() )
            {
                equipment_mp::setequipmentslotammo( "super", 0 );
                supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
            }
        }
        else if ( isdefined( supers_mp::getcurrentsuper() ) )
        {
            self setclientomnvar( "ui_perk_package_state", 3 );
        }
    }
    else if ( !isdefined( self.overclockcharge ) )
    {
        self.overclockcharge = 0;
    }
    
    thread function_af441d34200168cb();
}

// Namespace specialty_overcharge_field_upgrade
// Params 0
// Checksum 0xc345f3cd, Offset: 0x272
// Size: 0xd6
function function_78dfd387d6168678()
{
    val::reset( "specialty_overcharge_field_upgrade", "field_upgrade_recharge_mult" );
    
    if ( isdefined( self.var_8b8b3732177535fd ) )
    {
        self.var_8b8b3732177535fd = undefined;
    }
    
    if ( self.var_ad3d5ed8f39cd225 > 1 )
    {
        self.var_ad3d5ed8f39cd225 -= 1;
    }
    
    if ( isbrgamemode() )
    {
        if ( isdefined( supers_mp::getcurrentsuper() ) )
        {
            supers_mp::function_1f9b6b3c1d1f1404( 0 );
            
            if ( supers_mp::getcurrentsuperpoints() < supers_mp::getsuperpointsneeded() )
            {
                if ( !supers_mp::issuperinuse() )
                {
                    supers_mp::setsuperbasepoints( 0 );
                    thread supers_mp::expendsuper();
                    self setclientomnvar( "ui_perk_package_state", 0 );
                }
            }
        }
    }
    
    if ( isdefined( self.var_760a3e04da86556f ) )
    {
        self.var_760a3e04da86556f = undefined;
    }
    
    if ( isdefined( self.var_eba31f12191a731f ) )
    {
        self.var_eba31f12191a731f = undefined;
    }
    
    self notify( #"hash_d7dd9df0039ce9b9" );
}

// Namespace specialty_overcharge_field_upgrade
// Params 0
// Checksum 0xe37a1ddd, Offset: 0x350
// Size: 0xc8
function function_af441d34200168cb()
{
    self notify( #"hash_30bfc6d0819b3263" );
    self endon( #"hash_30bfc6d0819b3263" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d7dd9df0039ce9b9" );
    
    while ( !isdefined( self.var_760a3e04da86556f ) )
    {
        self waittill( #"super_use_charging" );
        waitframe();
        
        if ( self.super.isinuse )
        {
            continue;
        }
        
        if ( !supers_mp::function_31f00fe6e0334d03() )
        {
            continue;
        }
        
        if ( self.overclockcharge > 0 && supers_mp::issupercharging() )
        {
            supers_mp::givesuperpoints( self.overclockcharge + ( level.var_d8c17916fed09937 ?? 0 ), undefined, undefined, undefined, 1 );
            self.overclockcharge = 0;
            self setclientomnvar( "ui_super_second_progress", 0 );
        }
    }
}

