// scripts\mp\common\weapons\gun_shield.gsc  (hash_05ed243ea977ab92.gscc) (size: 6020 Bytes / 0x1784 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87f04bbb (2280672187)
// size ...... 6020 (0x1784)
// includes .. 3   (offset: 0x1638)
// strings ... 13  (offset: 0x1650)
// dev strs .. 1   (offset: 0x1778)
// exports ... 22  (offset: 0xe90)
// cseg ...... 0x153 + 0xd3d (0xe90)
// imports ... 35  (offset: 0x1200)
// animtree1 . 0   (offset: 0x1784)
// animtree2 . 0   (offset: 0x1784)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\callback_group;

#namespace gun_shield;

// Namespace gun_shield
// Params 0
// Checksum 0xd2c95ec4, Offset: 0x171
// Size: 0xdc
function init()
{
    if ( level.gamemodebundle.gunshieldenabled && function_4042d2fbe6237835( #"hash_3d32c35e8ac8445e" ) )
    {
        level.gamemodebundle.gunshieldenabled = 0;
    }
    
    if ( !level.gamemodebundle.gunshieldenabled )
    {
        return;
    }
    
    function_ae3f61230ba94d1( "gunShield_le" );
    function_ae3f61230ba94d1( "gunShield_ri" );
    level.onweapondropcreated callback_group::callback_subscribe( &gunshield_onweaponcreated, level );
    level.onweapondroppickedup callback_group::callback_subscribe( &gunshield_onweaponpickedup, level );
    level callback::add( #"player_death", &function_fdded5931503737d );
    level callback::add( #"hash_d9bade91bf637702", &function_fdded5931503737d );
    level callback::add( #"player_weapon_change", &function_5ebbb1f91e2134c2 );
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xa5df3d51, Offset: 0x255
// Size: 0xaf
function private function_ae3f61230ba94d1( partname )
{
    if ( !isdefined( level.var_24bc17eff58aa2df ) )
    {
        level.var_24bc17eff58aa2df = spawnstruct();
    }
    
    if ( !isdefined( level.var_24bc17eff58aa2df.partdata ) )
    {
        level.var_24bc17eff58aa2df.partdata = [];
    }
    
    statearr = [];
    statearr[ 0 ] = function_c37d0cafdf9dcf86( partname, "new", 0 );
    statearr[ 1 ] = function_c37d0cafdf9dcf86( partname, "med_dmg", 50 );
    statearr[ 2 ] = function_c37d0cafdf9dcf86( partname, "destroyed", 100 );
    level.var_24bc17eff58aa2df.partdata[ partname ] = statearr;
}

// Namespace gun_shield
// Params 3, eflags: 0x4
// Checksum 0xae5d2cb0, Offset: 0x30c
// Size: 0x4c
function private function_c37d0cafdf9dcf86( partname, statename, damagethreshold )
{
    struct = spawnstruct();
    struct.scriptablestatename = statename;
    struct.damagethreshold = damagethreshold;
    return struct;
}

// Namespace gun_shield
// Params 0, eflags: 0x4
// Checksum 0x76e6354a, Offset: 0x361
// Size: 0xb
function private function_e539b145986ad48f()
{
    return self.var_d75e248ea30872bf;
}

// Namespace gun_shield
// Params 1
// Checksum 0x44628632, Offset: 0x375
// Size: 0x6d
function function_5ebbb1f91e2134c2( params )
{
    if ( isdefined( params.lastweapon ) && hasgunshield( params.lastweapon ) )
    {
        unset_gunshield();
    }
    
    if ( isdefined( params.weapon ) && hasgunshield( params.weapon ) )
    {
        set_gunshield( params.weapon );
    }
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xd4c9402a, Offset: 0x3ea
// Size: 0x1e5
function private set_gunshield( objweapon )
{
    if ( !level.gamemodebundle.gunshieldenabled )
    {
        return;
    }
    
    if ( !isdefined( self.var_2add38b6cc4ee67e ) )
    {
        self.var_2add38b6cc4ee67e = [];
    }
    
    if ( self isalternatemode( objweapon, 1, 0 ) )
    {
        objweapon = objweapon getnoaltweapon();
    }
    
    var_d75e248ea30872bf = function_94a870e0327f1476( objweapon );
    
    if ( !isdefined( var_d75e248ea30872bf ) )
    {
        var_d75e248ea30872bf = function_80d1036055e876ef( objweapon );
        newarray = [];
        newarray[ newarray.size ] = var_d75e248ea30872bf;
        
        foreach ( data in self.var_2add38b6cc4ee67e )
        {
            foreach ( weapon in self.primaryweapons )
            {
                if ( data.weapon == weapon )
                {
                    newarray[ newarray.size ] = data;
                }
            }
        }
        
        self.var_2add38b6cc4ee67e = newarray;
    }
    
    self.var_d75e248ea30872bf = var_d75e248ea30872bf;
    self setscriptablepartstate( "gunShield_le", var_d75e248ea30872bf.parts[ "gunShield_le" ].state, 0 );
    self setscriptablepartstate( "gunShield_ri", var_d75e248ea30872bf.parts[ "gunShield_ri" ].state, 0 );
    thread function_2ef69112ff392bf4();
}

// Namespace gun_shield
// Params 0, eflags: 0x4
// Checksum 0x5ed1c8d9, Offset: 0x5d7
// Size: 0xc
function private unset_gunshield()
{
    self.var_d75e248ea30872bf = undefined;
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xb62e921b, Offset: 0x5eb
// Size: 0x17
function private hasgunshield( objweapon )
{
    return getweaponhasperk( objweapon, "specialty_gunshield" );
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0x2a9b9723, Offset: 0x60b
// Size: 0x58
function private function_94a870e0327f1476( objweapon )
{
    for ( i = 0; i < self.var_2add38b6cc4ee67e.size ; i++ )
    {
        if ( self.var_2add38b6cc4ee67e[ i ].weapon == objweapon )
        {
            return self.var_2add38b6cc4ee67e[ i ];
        }
    }
}

// Namespace gun_shield
// Params 1
// Checksum 0x90b798d5, Offset: 0x66b
// Size: 0x20
function function_fdded5931503737d( params )
{
    self.var_2add38b6cc4ee67e = undefined;
    self.var_d75e248ea30872bf = undefined;
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0x485fefa0, Offset: 0x693
// Size: 0x73
function private function_e14340502c29acc0( objweapon )
{
    newarray = [];
    
    for ( i = 0; i < self.var_2add38b6cc4ee67e.size ; i++ )
    {
        if ( self.var_2add38b6cc4ee67e[ i ].weapon != objweapon )
        {
            newarray[ newarray.size ] = self.var_2add38b6cc4ee67e[ i ];
        }
    }
    
    self.var_2add38b6cc4ee67e = newarray;
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0x15bc0896, Offset: 0x70e
// Size: 0x73
function private function_80d1036055e876ef( weapon )
{
    gunshielddata = spawnstruct();
    gunshielddata.parts = [];
    gunshielddata.parts[ "gunShield_le" ] = function_b6dc9bc5c34be6aa( "gunShield_le" );
    gunshielddata.parts[ "gunShield_ri" ] = function_b6dc9bc5c34be6aa( "gunShield_ri" );
    gunshielddata.weapon = weapon;
    return gunshielddata;
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xd1d5327e, Offset: 0x78a
// Size: 0x4c
function private function_b6dc9bc5c34be6aa( partname )
{
    partdata = spawnstruct();
    partdata.health = 300;
    partdata.state = "new";
    self setscriptablepartstate( partname, "new", 0 );
    return partdata;
}

// Namespace gun_shield
// Params 3
// Checksum 0xbe04e0e4, Offset: 0x7df
// Size: 0x90
function gunshield_onweaponpickedup( weaponentity, var_5b2075a06ef16da1, weaponobj )
{
    if ( !isdefined( weaponentity.gunshielddata ) )
    {
        return;
    }
    
    gunshielddata = weaponentity.gunshielddata;
    
    if ( isdefined( var_5b2075a06ef16da1.var_2add38b6cc4ee67e ) )
    {
        var_5b2075a06ef16da1.var_2add38b6cc4ee67e[ var_5b2075a06ef16da1.var_2add38b6cc4ee67e.size ] = gunshielddata;
        return;
    }
    
    var_5b2075a06ef16da1.var_2add38b6cc4ee67e = [];
    var_5b2075a06ef16da1.var_2add38b6cc4ee67e[ 0 ] = gunshielddata;
}

// Namespace gun_shield
// Params 3
// Checksum 0xc8295cb2, Offset: 0x877
// Size: 0xb1
function gunshield_onweaponcreated( weaponentity, droppingplayer, weaponobj )
{
    if ( !( isdefined( weaponentity ) && isdefined( droppingplayer ) ) )
    {
        return;
    }
    
    gunshielddata = droppingplayer function_94a870e0327f1476( weaponobj );
    
    if ( !isdefined( gunshielddata ) )
    {
        return;
    }
    
    weaponentity setscriptablepartstate( "gunShield_le", gunshielddata.parts[ "gunShield_le" ].state, 0 );
    weaponentity setscriptablepartstate( "gunShield_ri", gunshielddata.parts[ "gunShield_ri" ].state, 0 );
    weaponentity.gunshielddata = gunshielddata;
    droppingplayer function_e14340502c29acc0( weaponobj );
}

// Namespace gun_shield
// Params 4
// Checksum 0xbd541a96, Offset: 0x930
// Size: 0x149
function gunshield_ondamage( scriptableent, idamage, bonename, eattacker )
{
    gunshielddata = function_e539b145986ad48f();
    
    if ( !isdefined( gunshielddata ) )
    {
        return;
    }
    
    if ( scriptableent.isdestroyed )
    {
        return;
    }
    
    if ( getdvarint( @"hash_6ce346498d3080e2", 0 ) )
    {
        gunshielddata.parts[ "gunShield_le" ].health = gunshielddata.parts[ "gunShield_le" ].health - idamage;
        gunshielddata.parts[ "gunShield_ri" ].health = gunshielddata.parts[ "gunShield_ri" ].health - idamage;
        function_7751a8f12595b6ca( scriptableent, "gunShield_le", gunshielddata );
        function_7751a8f12595b6ca( scriptableent, "gunShield_ri", gunshielddata );
        return;
    }
    
    part = gunshield_getpartname( bonename );
    gunshielddata.parts[ part ].health -= idamage;
    function_7751a8f12595b6ca( scriptableent, part, gunshielddata );
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xa1b936d9, Offset: 0xa81
// Size: 0xad
function private gunshield_getpartname( bonenamehash )
{
    partname = "";
    
    switch ( bonenamehash )
    {
        case #"hash_11ad88bf3ac2fdf9":
            partname = "gunShield_le";
            break;
        case #"hash_3e3ab13dca7914bc":
            partname = "gunShield_le";
            break;
        case #"hash_b51db3dadf0644e":
            partname = "gunShield_le";
            break;
        case #"hash_1205b0bf3b0db7c7":
            partname = "gunShield_ri";
            break;
        case #"hash_d58032f1f2647fa6":
            partname = "gunShield_ri";
            break;
        case #"hash_7c628f20e630524":
            partname = "gunShield_ri";
            break;
    }
    
    return partname;
}

// Namespace gun_shield
// Params 3, eflags: 0x4
// Checksum 0xfda42ef4, Offset: 0xb37
// Size: 0x157
function private function_7751a8f12595b6ca( scriptableent, partname, gunshielddata )
{
    damagetaken = 300 - gunshielddata.parts[ partname ].health;
    damagestates = level.var_24bc17eff58aa2df.partdata[ partname ];
    assert( isdefined( damagestates ), "<dev string:x24>" );
    scriptablestatename = "";
    
    foreach ( state in damagestates )
    {
        if ( damagetaken >= state.damagethreshold )
        {
            scriptablestatename = state.scriptablestatename;
        }
    }
    
    if ( scriptablestatename != "" && scriptablestatename != gunshielddata.parts[ partname ].state )
    {
        scriptableent setscriptablepartstate( partname, scriptablestatename, 0 );
        gunshielddata.parts[ partname ].state = scriptablestatename;
    }
}

// Namespace gun_shield
// Params 1, eflags: 0x4
// Checksum 0xa1fb7219, Offset: 0xc96
// Size: 0xe6
function private gunshield_flinch( eattacker )
{
    class = weaponclass( eattacker getcurrentweapon() );
    flinch = 0;
    
    switch ( class )
    {
        case #"hash_8cdaf2e4ecfe5b51":
            flinch = 0.4;
            break;
        case #"hash_719417cb1de832b6":
            flinch = 0.1;
            break;
        case #"hash_900cb96c552c5e8e":
            flinch = 0.1;
            break;
        case #"hash_690c0d6a821b42e":
            flinch = 0.5;
            break;
        case #"hash_fa24dff6bd60a12d":
            flinch = 0.5;
            break;
        case #"hash_6191aaef9f922f96":
            flinch = 0.8;
            break;
    }
    
    self viewkick( 0, self.origin );
    self earthquakeforplayer( 0.04, 0.1, self.origin, 10 );
}

// Namespace gun_shield
// Params 0, eflags: 0x4
// Checksum 0x7b9546b, Offset: 0xd84
// Size: 0x64
function private function_2ef69112ff392bf4()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"weapon_change" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started" );
        childthread function_246f62c0a92ea3c3();
        self setscriptablepartstate( "gunShield_le", "stowed", 0 );
        self setscriptablepartstate( "gunShield_ri", "stowed", 0 );
    }
}

// Namespace gun_shield
// Params 0
// Checksum 0x37c36d7c, Offset: 0xdf0
// Size: 0xa0
function function_246f62c0a92ea3c3()
{
    self notify( #"hash_5749ab4eefffbb9a" );
    self endon( #"hash_5749ab4eefffbb9a" );
    
    while ( true )
    {
        utility::waittill_any( "weapon_switch_canceled", "grenade_pullback", "offhand_pullback", "grenade_fire", "offhand_fired" );
        self setscriptablepartstate( "gunShield_le", self.var_d75e248ea30872bf.parts[ "gunShield_le" ].state, 0 );
        self setscriptablepartstate( "gunShield_ri", self.var_d75e248ea30872bf.parts[ "gunShield_ri" ].state, 0 );
    }
}

