// scripts\mp\augments\z_mod_augments.gsc  (hash_748681890847053f.gscc) (size: 3081 Bytes / 0xc09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93832ad4 (2474846932)
// size ...... 3081 (0xc09)
// includes .. 4   (offset: 0xb91)
// strings ... 6   (offset: 0xbb1)
// dev strs .. 1   (offset: 0xbfd)
// exports ... 9   (offset: 0x705)
// cseg ...... 0xd6 + 0x62f (0x705)
// imports ... 27  (offset: 0x86d)
// animtree1 . 0   (offset: 0xc09)
// animtree2 . 0   (offset: 0xc09)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\equipment;

#namespace z_mod_augments;

// Namespace z_mod_augments
// Params 0, eflags: 0x5
// Checksum 0x78154973, Offset: 0xf4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"z_mod_augments", undefined, &init_z_mod_augments, undefined );
}

// Namespace z_mod_augments
// Params 0
// Checksum 0x443fb189, Offset: 0x115
// Size: 0x6d
function init_z_mod_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"grenade_fire", &function_cadf2d49d2505379 );
    callback::add( #"on_adrenaline_used", &on_adrenaline_used );
    callback::add( "zm_packed_weapon_non_augment", &function_6aa78523c1e4e229 );
}

// Namespace z_mod_augments
// Params 1
// Checksum 0xf46fab92, Offset: 0x18a
// Size: 0xc
function function_288f120db5b6defb( params )
{
    
}

// Namespace z_mod_augments
// Params 1
// Checksum 0x514d35e2, Offset: 0x19e
// Size: 0xdc
function function_9e09844df6bf44c7( params )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"z_mod_pack_mule" ) )
    {
        primary_weapons = self getweaponslistprimaries();
        
        foreach ( weapon in primary_weapons )
        {
            current_stock_ammo = self getweaponammostock( weapon );
            max_stock_ammo = utility::get_max_stock_ammo( weapon, 0 );
            
            if ( current_stock_ammo > max_stock_ammo )
            {
                self setweaponammostock( weapon, max_stock_ammo );
            }
        }
    }
}

// Namespace z_mod_augments
// Params 1
// Checksum 0x64baeaa3, Offset: 0x282
// Size: 0x23
function on_adrenaline_used( params )
{
    params.was_adrenaline = 1;
    function_cadf2d49d2505379( params );
}

// Namespace z_mod_augments
// Params 1
// Checksum 0x97c2e1cd, Offset: 0x2ad
// Size: 0x11a
function function_cadf2d49d2505379( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_free_throw" ) )
    {
        if ( isdefined( params.grenade.equipmentref ) || params.was_adrenaline )
        {
            percentchance = level.zombie_augments[ #"z_mod_free_throw" ].var_bdac387423954252 ?? 0.25;
            percentchance *= 100;
            ref = params.grenade.equipmentref;
            
            if ( params.was_adrenaline )
            {
                params.grenade = {};
                ref = "equip_adrenaline";
            }
            
            if ( ref != "equip_combataxe" )
            {
                if ( utility::percent_chance( percentchance ) )
                {
                    println( "<dev string:x24>" );
                    params.grenade.is_free_grenade = 1;
                    equipment_mp::incrementequipmentammo( ref );
                }
            }
        }
    }
}

// Namespace z_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x888e94a5, Offset: 0x3cf
// Size: 0x30
function private function_9dc60f118603d711( weapon )
{
    self endon( #"death_or_disconnect" );
    
    while ( !self hasweapon( weapon ) || self isswitchingweapon() )
    {
        waitframe();
    }
}

// Namespace z_mod_augments
// Params 1
// Checksum 0xf3e907a1, Offset: 0x407
// Size: 0x2fe
function function_6aa78523c1e4e229( params )
{
    self endon( #"death_or_disconnect" );
    var_a75ddc371981ddbe = params.var_101633ed971732ba;
    
    if ( isdefined( var_a75ddc371981ddbe ) )
    {
        function_9dc60f118603d711( var_a75ddc371981ddbe );
        waitframe();
    }
    else
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_multi_pack" ) && !level.zm_mode_modifiers.var_63da2ef147f344a4 )
    {
        if ( !isdefined( self.var_d5e9cda5ffc651c5 ) )
        {
            self.var_d5e9cda5ffc651c5 = 0;
        }
        
        percentchance = level.zombie_augments[ #"z_mod_multi_pack" ].var_8c228a1f06f37e98 ?? 0.25;
        percentchance *= 100;
        increasechance = self.var_d5e9cda5ffc651c5 * 25;
        percentchance += increasechance;
        percentchance = clamp( percentchance, 0, 100 );
        
        if ( utility::percent_chance( percentchance ) )
        {
            self.var_d5e9cda5ffc651c5 = 0;
            primaries = self getweaponslistprimaries();
            var_dc69483a8a00cde9 = utility::callsharedfunc( #"zombie", #"get_pap_level", var_a75ddc371981ddbe );
            primaries_copy = primaries;
            
            foreach ( weapon in primaries )
            {
                if ( weapon == var_a75ddc371981ddbe )
                {
                    primaries_copy = arrayremove( primaries_copy, weapon );
                }
            }
            
            var_b371ef2bbc8d8a50 = [];
            
            foreach ( weapon in primaries_copy )
            {
                if ( utility::callsharedfunc( #"pack_a_punch", #"hash_1d402cf8c2699623", weapon ) )
                {
                    packlevel = utility::callsharedfunc( #"zombie", #"get_pap_level", weapon );
                    
                    if ( packlevel < var_dc69483a8a00cde9 )
                    {
                        var_b371ef2bbc8d8a50[ var_b371ef2bbc8d8a50.size ] = weapon;
                    }
                }
            }
            
            if ( var_b371ef2bbc8d8a50.size > 0 )
            {
                weaponindex = randomintrange( 0, var_b371ef2bbc8d8a50.size );
                var_5a4589b715ea817e = var_b371ef2bbc8d8a50[ weaponindex ];
                level_to_start = utility::callsharedfunc( #"zombie", #"get_pap_level", var_5a4589b715ea817e );
                
                if ( isdefined( var_5a4589b715ea817e ) )
                {
                    utility::callsharedfunc( #"pack_a_punch", #"pap_weapon", var_5a4589b715ea817e, level_to_start, undefined, undefined, undefined, 0, 1, var_dc69483a8a00cde9 );
                }
            }
            
            return;
        }
        
        self.var_d5e9cda5ffc651c5++;
    }
}

