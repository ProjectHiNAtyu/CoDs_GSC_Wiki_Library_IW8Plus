// script_536192092a8b8825  (hash_536192092a8b8825.gscc) (size: 1812 Bytes / 0x714 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13f34763 (334710627)
// size ...... 1812 (0x714)
// includes .. 3   (offset: 0x6b4)
// strings ... 4   (offset: 0x6cc)
// dev strs .. 0   (offset: 0x714)
// exports ... 9   (offset: 0x3f4)
// cseg ...... 0xb7 + 0x33d (0x3f4)
// imports ... 12  (offset: 0x55c)
// animtree1 . 0   (offset: 0x714)
// animtree2 . 0   (offset: 0x714)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace specialty_melee_without_swap;

// Namespace specialty_melee_without_swap
// Params 0, eflags: 0x1
// Checksum 0x1228826b, Offset: 0xd5
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_melee_without_swap
// Params 1
// Checksum 0x74165730, Offset: 0xf5
// Size: 0xf2
function registerperk( params )
{
    bundle = level.perkbundles[ "specialty_melee_without_swap" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    specialties = [];
    
    foreach ( specialty in bundle.specialties )
    {
        specialties[ specialties.size ] = specialty.bundle;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_melee_without_swap", &function_97ff12cdb830f579, &function_fea7d15986542ea0, [ "specialty_hand_to_hand" ] );
    }
}

// Namespace specialty_melee_without_swap
// Params 0
// Checksum 0x2184b3d8, Offset: 0x1ef
// Size: 0x1d
function function_b767ad1975b3f2fb()
{
    bundle = level.perkbundles[ "specialty_melee_without_swap" ];
}

// Namespace specialty_melee_without_swap
// Params 0, eflags: 0x4
// Checksum 0xb298f1f1, Offset: 0x214
// Size: 0x9
function private function_97ff12cdb830f579()
{
    thread function_9a7642863ee4d60e();
}

// Namespace specialty_melee_without_swap
// Params 0, eflags: 0x4
// Checksum 0xc970126b, Offset: 0x225
// Size: 0x2b
function private function_fea7d15986542ea0()
{
    self notify( #"hash_11453263d2e9457c" );
    self.meleewithoutswap = undefined;
    val::set( "meleewithoutswap", "weapon_switch", 1 );
}

// Namespace specialty_melee_without_swap
// Params 0, eflags: 0xc
// Checksum 0x7ca4cb29, Offset: 0x258
// Size: 0x70
function private function_9a7642863ee4d60e()
{
    self notify( #"hash_76ce082c5a448503" );
    self endon( #"hash_76ce082c5a448503" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_11453263d2e9457c" );
    
    while ( true )
    {
        self waittill( #"weapon_change", newweapon );
        
        if ( weapon::function_597e1c0b6df2fada( newweapon.basename ) )
        {
            thread monitormelee( newweapon );
        }
    }
}

// Namespace specialty_melee_without_swap
// Params 1, eflags: 0xc
// Checksum 0xd6442f84, Offset: 0x2d0
// Size: 0x9a
function private monitormelee( var_11a4e37204810f49 )
{
    self notify( #"hash_b0751a785e83e2dd" );
    self endon( #"hash_b0751a785e83e2dd" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_11453263d2e9457c" );
    self endon( #"weapon_change" );
    
    while ( !self meleebuttonpressed() )
    {
        waitframe();
    }
    
    var_7634e6877c7e7f5f = self function_ca1904a5dd87fd53();
    
    if ( var_7634e6877c7e7f5f && var_7634e6877c7e7f5f != var_11a4e37204810f49 )
    {
        return;
    }
    
    val::set( "meleewithoutswap", "weapon_switch", 0 );
    self.meleewithoutswap = 1;
    thread function_2c37ba348b355142( var_11a4e37204810f49 );
}

// Namespace specialty_melee_without_swap
// Params 1, eflags: 0xc
// Checksum 0x3d1ca4a1, Offset: 0x372
// Size: 0x82
function private function_2c37ba348b355142( var_11a4e37204810f49 )
{
    self notify( #"hash_aa7638cbe155aa62" );
    self endon( #"hash_aa7638cbe155aa62" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_11453263d2e9457c" );
    
    while ( true )
    {
        self waittill( #"weapon_change", newweapon );
        
        if ( newweapon == var_11a4e37204810f49 )
        {
            self.meleewithoutswap = undefined;
            val::set( "meleewithoutswap", "weapon_switch", 1 );
            return;
        }
    }
}

