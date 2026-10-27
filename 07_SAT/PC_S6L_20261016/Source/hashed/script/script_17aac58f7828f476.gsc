// script_17aac58f7828f476  (hash_17aac58f7828f476.gscc) (size: 2615 Bytes / 0xa37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a3296b5 (439522997)
// size ...... 2615 (0xa37)
// includes .. 1   (offset: 0x9db)
// strings ... 1   (offset: 0x9e3)
// dev strs .. 5   (offset: 0x9ef)
// exports ... 6   (offset: 0x723)
// cseg ...... 0x6f + 0x6b4 (0x723)
// imports ... 14  (offset: 0x813)
// animtree1 . 0   (offset: 0xa37)
// animtree2 . 0   (offset: 0xa37)
#using scripts\common\utility;

#namespace namespace_ce77b5e0fc016a5a;

// Namespace namespace_ce77b5e0fc016a5a
// Params 0
// Checksum 0x5762fc97, Offset: 0x8d
// Size: 0x20
function init_scaling_damage()
{
    utility::registersharedfunc( #"zombie", #"hash_e27e55920dabe660", &function_c0f17eb03e09d5ef );
}

// Namespace namespace_ce77b5e0fc016a5a
// Params 1
// Checksum 0x8f7db455, Offset: 0xb5
// Size: 0x41c
function function_c0f17eb03e09d5ef( fixed_round_number )
{
    if ( level.var_9209eecc9aff21ad )
    {
        return;
    }
    
    assert( isdefined( fixed_round_number ), "<dev string:x24>" );
    
    if ( !isdefined( fixed_round_number ) )
    {
        return;
    }
    
    if ( isdefined( fixed_round_number ) )
    {
        roundnumber = fixed_round_number;
    }
    
    if ( !isdefined( self.var_d6894f01a36b4ff3.damagescriptbundle ) )
    {
        return;
    }
    
    scriptbundle_name = self.var_d6894f01a36b4ff3.damagescriptbundle;
    scriptbundle_name = function_80df64beed5df7f9( scriptbundle_name );
    
    if ( !isdefined( level.ai_damage_bundles ) )
    {
        level.ai_damage_bundles = [];
    }
    
    if ( !isdefined( level.ai_damage_bundles[ scriptbundle_name ] ) )
    {
        damage_bundle = getscriptbundle( "damagescalinground:" + scriptbundle_name );
        
        if ( !isdefined( damage_bundle ) )
        {
            assert( "<dev string:x61>" + ( self.subclass ?? "<dev string:x8b>" ) );
            return;
        }
        
        level.ai_damage_bundles[ scriptbundle_name ] = damage_bundle;
    }
    else
    {
        damage_bundle = level.ai_damage_bundles[ scriptbundle_name ];
    }
    
    assert( isdefined( damage_bundle ) );
    self.melee_damage_multiplier = get_round_damage_multiplier( damage_bundle.meleedamagescaling, roundnumber );
    
    if ( damage_bundle.var_897c9e5b20825119 && fixed_round_number >= damage_bundle.var_897c9e5b20825119 )
    {
        self.var_f1cb4f6133640cfe = 1;
    }
    
    if ( isdefined( self.melee_damage_base ) && isdefined( self.melee_damage_multiplier ) )
    {
        self.var_6c41e8e873b7594e = int( ceil( self.melee_damage_base * self.melee_damage_multiplier ) );
        
        if ( damage_bundle.var_7977644af14eab4e )
        {
            self.var_6c41e8e873b7594e = minint( self.var_6c41e8e873b7594e, damage_bundle.maxdamagecap );
        }
    }
    
    self.ranged_damage_multiplier = get_round_damage_multiplier( damage_bundle.rangeddamagescaling, roundnumber );
    
    if ( isdefined( self.grenadeweapon ) && isdefined( self.ranged_damage_multiplier ) )
    {
        self.ranged_grenade_damage = int( ceil( self.grenadeweapon getmaxdamage( 0 ) * self.ranged_damage_multiplier ) );
        
        if ( damage_bundle.var_7977644af14eab4e )
        {
            self.ranged_grenade_damage = minint( self.ranged_grenade_damage, damage_bundle.maxdamagecap );
        }
    }
    
    self.leap_damage_multiplier = get_round_damage_multiplier( damage_bundle.leapdamagescaling, roundnumber );
    
    if ( isdefined( self._blackboard.leapattackdamage ) )
    {
        self._blackboard.leapattackdamage = int( ceil( self.var_d6894f01a36b4ff3.leapattackdamage * self.leap_damage_multiplier ) );
        
        if ( damage_bundle.var_7977644af14eab4e )
        {
            self._blackboard.leapattackdamage = minint( int( self._blackboard.leapattackdamage ), damage_bundle.maxdamagecap );
        }
    }
    
    self.armor_health_damage_multiplier = get_round_damage_multiplier( damage_bundle.armorhealthdamagescaling, roundnumber );
    self.var_7977644af14eab4e = damage_bundle.var_7977644af14eab4e;
    self.maxdamagecap = damage_bundle.maxdamagecap;
    
    foreach ( var_6f6f8178cb8841e4 in damage_bundle.customdamagescaling ?? [] )
    {
        if ( !isdefined( self.var_fe048a2106d8ef00 ) )
        {
            self.var_fe048a2106d8ef00 = [];
        }
        
        self.var_fe048a2106d8ef00[ var_6f6f8178cb8841e4.damagename ] = get_round_damage_multiplier( var_6f6f8178cb8841e4.damagescaling, roundnumber );
    }
    
    self.var_577dec43cf1caedf = function_98183e142462be83( damage_bundle.var_c67d81698c5d806c, roundnumber );
}

// Namespace namespace_ce77b5e0fc016a5a
// Params 2, eflags: 0x4
// Checksum 0x135a0a2f, Offset: 0x4d9
// Size: 0xb1
function private get_round_damage_multiplier( damage_array, round_num )
{
    if ( damage_array.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = damage_array.size - 1; i >= 0 ; i-- )
        {
            if ( damage_array[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:x8c>" + ( self.subclass ?? "<dev string:x8b>" ) );
                return 1;
            }
            
            if ( round_num >= damage_array[ i ].startround )
            {
                return damage_array[ i ].damagemultiplier;
            }
            
            var_78a63f139cf07707 = damage_array[ i ].startround;
        }
    }
    
    return 1;
}

// Namespace namespace_ce77b5e0fc016a5a
// Params 2, eflags: 0x4
// Checksum 0xde22cb87, Offset: 0x593
// Size: 0xb1
function private function_98183e142462be83( attackers_array, round_num )
{
    if ( attackers_array.size > 0 )
    {
        var_78a63f139cf07707 = undefined;
        
        for ( i = attackers_array.size - 1; i >= 0 ; i-- )
        {
            if ( attackers_array[ i ].startround >= var_78a63f139cf07707 )
            {
                assert( "<dev string:x8c>" + ( self.subclass ?? "<dev string:x8b>" ) );
                return 1;
            }
            
            if ( round_num >= attackers_array[ i ].startround )
            {
                return attackers_array[ i ].maxattackers;
            }
            
            var_78a63f139cf07707 = attackers_array[ i ].startround;
        }
    }
    
    return 1;
}

// Namespace namespace_ce77b5e0fc016a5a
// Params 1, eflags: 0x4
// Checksum 0x253787ac, Offset: 0x64d
// Size: 0xd5
function private function_80df64beed5df7f9( scriptbundle )
{
    var_8d983a6167fdc6d6 = scriptbundle;
    
    foreach ( scriptbundle_struct in level.gametypebundle.var_e3501b33c18021fd ?? [] )
    {
        if ( scriptbundle_struct.originaldamage === hashcat( %"damagescalinground:", scriptbundle ) )
        {
            var_8d983a6167fdc6d6 = scriptbundle_struct.newdamage;
        }
    }
    
    assert( var_8d983a6167fdc6d6, "<dev string:xdd>" + scriptbundle );
    return var_8d983a6167fdc6d6;
}

