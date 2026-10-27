// script_5adc0ee463b8a974  (hash_5adc0ee463b8a974.gscc) (size: 13492 Bytes / 0x34b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaeaf21ba (2930713018)
// size ...... 13492 (0x34b4)
// includes .. 3   (offset: 0x31fc)
// strings ... 20  (offset: 0x3214)
// dev strs .. 19  (offset: 0x33a4)
// exports ... 18  (offset: 0x2900)
// cseg ...... 0x22b + 0x26d5 (0x2900)
// imports ... 43  (offset: 0x2bd0)
// animtree1 . 0   (offset: 0x34b4)
// animtree2 . 0   (offset: 0x34b4)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\gametypes\arena;

#namespace gunfight_loadouts;

// Namespace gunfight_loadouts
// Params 0, eflags: 0x5
// Checksum 0xfe92e86a, Offset: 0x249
// Size: 0xcb
function private autoexec __autoexec__()
{
    if ( !getmatchrulesdata( "arenaData", "enableGunfightLoadouts" ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_3b19f01999cbbafb", 0 ) )
    {
        function_a13baa61697856d6();
        return;
    }
    
    gamemode_bundle = getgamemodescriptbundle();
    weapon_list = getscriptbundle( gamemode_bundle.weaponlist );
    equipment_list = getscriptbundle( gamemode_bundle.equipment_list );
    game[ #"gunfight_loadouts" ] = {};
    game[ #"gunfight_loadouts" ].weapons = read_in_weapons( weapon_list.weapons );
    game[ #"gunfight_loadouts" ].equipment = function_4c24d9ae17c2f073( equipment_list.equipment_list );
}

// Namespace gunfight_loadouts
// Params 0
// Checksum 0xae7cf7ca, Offset: 0x31c
// Size: 0x57
function get_weapon_category_count()
{
    if ( !isdefined( game[ #"gunfight_loadouts" ] ) )
    {
        return;
    }
    
    if ( game[ #"gunfight_loadouts" ].var_2790e6cfb2311b22 )
    {
        return game[ #"gunfight_loadouts" ].var_9903bc162ff277a2;
    }
    
    return game[ #"gunfight_loadouts" ].weapons.size;
}

// Namespace gunfight_loadouts
// Params 1
// Checksum 0x83bbc883, Offset: 0x37c
// Size: 0x160
function function_2c1d142864561f9a( equipment_ref_name )
{
    if ( !isdefined( game[ #"gunfight_loadouts" ] ) )
    {
        return;
    }
    
    if ( game[ #"gunfight_loadouts" ].var_2790e6cfb2311b22 )
    {
        return function_73d40914ffec2199( equipment_ref_name );
    }
    
    foreach ( equipment_type_list in game[ #"gunfight_loadouts" ].equipment )
    {
        foreach ( equipment_struct in equipment_type_list )
        {
            if ( equipment_struct.ref_name == equipment_ref_name )
            {
                return equipment_struct.var_12ca294d970418e6;
            }
        }
    }
    
    assertmsg( "<dev string:x24>" + "<dev string:x39>" + "<dev string:x68>" + "<dev string:x6b>" + equipment_ref_name );
}

// Namespace gunfight_loadouts
// Params 2
// Checksum 0x4b5e6fa9, Offset: 0x4e5
// Size: 0x9fd
function get_randomized_loadouts( count = 32, var_d78817de46e790f )
{
    if ( !isdefined( game[ #"gunfight_loadouts" ] ) )
    {
        return [];
    }
    
    if ( count < 1 )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x9f>" + "<dev string:x68>" + "<dev string:xca>" );
        return [];
    }
    
    if ( game[ #"gunfight_loadouts" ].var_2790e6cfb2311b22 )
    {
        return function_d52d51082a6bde70( var_d78817de46e790f, count );
    }
    
    var_414cc5aa3e663b5b = getdvar( @"hash_a5573c0a71470a8e" );
    var_6b0271539849bf57 = getdvar( @"hash_e199116013186202" );
    var_90b51f6ffcf21619 = getdvar( @"hash_b2cb304cd9a1cd71" );
    var_43db58468a81b45e = getdvar( @"hash_55ff438f45cd051e" );
    var_eedcb7760a31a7ad = function_c17ed2ea1787e58( var_414cc5aa3e663b5b );
    var_191b2960542b4699 = function_c17ed2ea1787e58( var_6b0271539849bf57 );
    
    if ( var_eedcb7760a31a7ad )
    {
        var_414cc5aa3e663b5b = var_eedcb7760a31a7ad.var_7068c97ad157148;
        
        foreach ( attachment_string in var_eedcb7760a31a7ad.attachments )
        {
            if ( attachment_string && attachment_string != "none" )
            {
                var_414cc5aa3e663b5b += "+" + attachment_string;
            }
        }
        
        logstring( "[GUNFIGHT LOADOUTS] " + "gunfight_loadouts::get_randomized_loadouts" + ": " + "Primary weapon override => " + var_414cc5aa3e663b5b );
    }
    
    if ( var_191b2960542b4699 )
    {
        var_6b0271539849bf57 = var_191b2960542b4699.var_7068c97ad157148;
        
        foreach ( attachment_string in var_191b2960542b4699.attachments )
        {
            if ( attachment_string && attachment_string != "none" )
            {
                var_6b0271539849bf57 += "+" + attachment_string;
            }
        }
        
        logstring( "[GUNFIGHT LOADOUTS] " + "gunfight_loadouts::get_randomized_loadouts" + ": " + "Secondary weapon override => " + var_6b0271539849bf57 );
    }
    
    if ( var_90b51f6ffcf21619 && var_90b51f6ffcf21619 != "" )
    {
        logstring( "[GUNFIGHT LOADOUTS] " + "gunfight_loadouts::get_randomized_loadouts" + ": " + "Lethal equipment override => " + var_90b51f6ffcf21619 );
    }
    
    if ( var_43db58468a81b45e && var_43db58468a81b45e != "" )
    {
        logstring( "[GUNFIGHT LOADOUTS] " + "gunfight_loadouts::get_randomized_loadouts" + ": " + "Tactical equipment override => " + var_43db58468a81b45e );
    }
    
    out_array = [];
    weapon_class_hashes = [];
    var_eb750f356d273aba = 0;
    lethal_equipment_index = 0;
    tactical_equipment_index = 0;
    var_d7d2b6c904facc30 = { #max_attachments:getmatchrulesdata( "arenaData", "maxWeaponAttachments" ), #apex_chance:getmatchrulesdata( "arenaData", "apexAttachmentChance" ) };
    
    do
    {
        if ( weapon_class_hashes.size == 0 )
        {
            foreach ( weapon_category_hash, weapon_category_struct in game[ #"gunfight_loadouts" ].weapons )
            {
                weapon_class_hashes[ weapon_class_hashes.size ] = weapon_category_hash;
                var_eb750f356d273aba += weapon_category_struct.weight;
            }
        }
        
        weapon_category_hashes = [ var_d78817de46e790f, #"weapon_pistol" ];
        
        if ( !isdefined( var_d78817de46e790f ) )
        {
            while ( true )
            {
                var_53bb5308f78d6246 = randomintrange( 1, var_eb750f356d273aba );
                var_bf255a7af8a3789 = undefined;
                
                foreach ( weapon_category_hash in arrayrandomize( weapon_class_hashes ) )
                {
                    weapon_category_struct = game[ #"gunfight_loadouts" ].weapons[ weapon_category_hash ];
                    var_53bb5308f78d6246 -= weapon_category_struct.weight;
                    
                    if ( var_53bb5308f78d6246 <= 0 )
                    {
                        var_bf255a7af8a3789 = weapon_category_hash;
                        break;
                    }
                }
                
                if ( weapon_category_hashes[ 0 ] == var_bf255a7af8a3789 )
                {
                    continue;
                }
                
                weapon_class_hashes = arrayremove( weapon_class_hashes, var_bf255a7af8a3789 );
                weapon_category_hashes[ 0 ] = var_bf255a7af8a3789;
                var_eb750f356d273aba -= weapon_category_struct.weight;
                break;
            }
            
            weapon_category_to_remove = weapon_category_hashes[ 0 ] == #"weapon_dmr" ? #"weapon_sniper" : weapon_category_hashes[ 0 ] == #"weapon_sniper" ? #"weapon_dmr" : undefined;
            
            if ( weapon_category_to_remove )
            {
                weapon_class_hashes = arrayremove( weapon_class_hashes, weapon_category_to_remove );
                var_61de970726f3311a = game[ #"gunfight_loadouts" ].weapons[ weapon_category_to_remove ];
                var_eb750f356d273aba -= var_61de970726f3311a.weight;
            }
            
            if ( weapon_class_hashes.size == 0 )
            {
                var_d78817de46e790f = weapon_category_hashes[ 0 ];
                var_2ef507aa6f11671c = 1;
                continue;
            }
        }
        else if ( var_2ef507aa6f11671c )
        {
            var_d78817de46e790f = undefined;
            var_2ef507aa6f11671c = undefined;
        }
        
        if ( weapon_category_hashes[ 0 ] == #"weapon_pistol" )
        {
            weapon_category_hashes[ 1 ] = undefined;
        }
        
        weapon_configs = [];
        
        for ( i = 0; i < weapon_category_hashes.size ; i++ )
        {
            weapon_category_struct = game[ #"gunfight_loadouts" ].weapons[ weapon_category_hashes[ i ] ];
            weapon_category_struct.weapon_index++;
            
            if ( weapon_category_struct.weapon_index == weapon_category_struct.weapons.size )
            {
                weapon_category_struct.weapons = arrayrandomize( weapon_category_struct.weapons );
                weapon_category_struct.weapon_index = 0;
            }
            
            var_b87c8459d148bf6a = weapon_category_struct.weapons[ weapon_category_struct.weapon_index ];
            var_60c39b5d0d6b8fc6 = var_b87c8459d148bf6a.var_8a6e63cd4ed74efe[ var_b87c8459d148bf6a.var_624cf7fe8109fa26 ];
            var_b87c8459d148bf6a.var_624cf7fe8109fa26++;
            
            if ( var_b87c8459d148bf6a.var_624cf7fe8109fa26 == var_b87c8459d148bf6a.var_8a6e63cd4ed74efe.size )
            {
                var_b87c8459d148bf6a.var_8a6e63cd4ed74efe = arrayrandomize( var_b87c8459d148bf6a.var_8a6e63cd4ed74efe );
                var_b87c8459d148bf6a.var_624cf7fe8109fa26 = 0;
            }
            
            weapon_configs[ weapon_configs.size ] = { #var_60c39b5d0d6b8fc6:var_60c39b5d0d6b8fc6, #var_7068c97ad157148:var_b87c8459d148bf6a.var_7068c97ad157148 };
        }
        
        loadout_struct = {};
        loadout_struct.primary_weapon = {};
        loadout_struct.primary_weapon.var_7068c97ad157148 = weapon_configs[ 0 ].var_7068c97ad157148;
        loadout_struct.primary_weapon.attachments = function_13524e16d5a81a46( weapon_configs[ 0 ].var_60c39b5d0d6b8fc6, var_d7d2b6c904facc30 );
        
        if ( isdefined( weapon_configs[ 1 ] ) )
        {
            loadout_struct.secondary_weapon = {};
            loadout_struct.secondary_weapon.var_7068c97ad157148 = weapon_configs[ 1 ].var_7068c97ad157148;
            loadout_struct.secondary_weapon.attachments = function_13524e16d5a81a46( weapon_configs[ 1 ].var_60c39b5d0d6b8fc6, var_d7d2b6c904facc30 );
        }
        else
        {
            loadout_struct.secondary_weapon = {};
            loadout_struct.secondary_weapon.var_7068c97ad157148 = "rex_me_tacknifea";
            loadout_struct.secondary_weapon.attachments = [ "none", "none", "none", "none", "none", "none" ];
        }
        
        loadout_struct.lethal_equipment_name = game[ #"gunfight_loadouts" ].equipment[ #"lethal" ][ lethal_equipment_index ].ref_name;
        loadout_struct.tactical_equipment_name = game[ #"gunfight_loadouts" ].equipment[ #"tactical" ][ tactical_equipment_index ].ref_name;
        lethal_equipment_index++;
        tactical_equipment_index++;
        
        if ( lethal_equipment_index == game[ #"gunfight_loadouts" ].equipment[ #"lethal" ].size )
        {
            game[ #"gunfight_loadouts" ].equipment[ #"lethal" ] = arrayrandomize( game[ #"gunfight_loadouts" ].equipment[ #"lethal" ] );
            lethal_equipment_index = 0;
        }
        
        if ( tactical_equipment_index == game[ #"gunfight_loadouts" ].equipment[ #"tactical" ].size )
        {
            game[ #"gunfight_loadouts" ].equipment[ #"tactical" ] = arrayrandomize( game[ #"gunfight_loadouts" ].equipment[ #"tactical" ] );
            tactical_equipment_index = 0;
        }
        
        if ( var_eedcb7760a31a7ad )
        {
            loadout_struct.primary_weapon = var_eedcb7760a31a7ad;
        }
        
        if ( var_191b2960542b4699 )
        {
            loadout_struct.secondary_weapon = var_191b2960542b4699;
        }
        
        if ( var_90b51f6ffcf21619 && var_90b51f6ffcf21619 != "" )
        {
            loadout_struct.lethal_equipment_name = var_90b51f6ffcf21619;
        }
        
        if ( var_43db58468a81b45e && var_43db58468a81b45e != "" )
        {
            loadout_struct.tactical_equipment_name = var_43db58468a81b45e;
        }
        
        out_array[ out_array.size ] = loadout_struct;
    }
    while ( out_array.size < count );
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x8f8000b3, Offset: 0xeeb
// Size: 0x315
function private read_in_weapons( weapon_list )
{
    out_array = [];
    
    foreach ( weapon_data_struct in arrayrandomize( weapon_list ) )
    {
        if ( !isdefined( weapon_data_struct.weapondata ) )
        {
            continue;
        }
        
        weapon_bundle_hash = hashcat( %"weapondata:", weapon_data_struct.weapondata );
        weapon_bundle = getscriptbundle( weapon_bundle_hash );
        
        if ( !isdefined( weapon_bundle ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x109>" + "<dev string:x68>" + "<dev string:x12c>" + weapon_bundle_hash );
            continue;
        }
        
        if ( weapon_bundle.var_7805e7e39b98782f )
        {
            continue;
        }
        
        if ( !isdefined( weapon_bundle.var_3f4bf205a8800fe1 ) || weapon_bundle.var_73e76beb8c5959e8.size == 0 )
        {
            logstring( "[GUNFIGHT LOADOUTS] " + "gunfight_loadouts::read_in_weapons" + ": " + "Failed to find any valid Gunny archetypes on weapondata bundle => " + weapon_bundle_hash );
            continue;
        }
        
        var_761e9ee8a39a7584 = hashcat( %"hash_231e89190f5116c0", weapon_bundle.classdata );
        var_2a8f6633be8e5ab3 = getscriptbundle( var_761e9ee8a39a7584 );
        
        if ( !isdefined( var_2a8f6633be8e5ab3 ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x109>" + "<dev string:x68>" + "<dev string:x151>" + var_761e9ee8a39a7584 );
            continue;
        }
        
        if ( var_2a8f6633be8e5ab3.gunfightweight == 0 )
        {
            continue;
        }
        
        weapon_class_hash = getxhash( var_2a8f6633be8e5ab3.classreference );
        
        if ( !isdefined( out_array[ weapon_class_hash ] ) )
        {
            weapon_class_struct = {};
            weapon_class_struct.weapons = [];
            weapon_class_struct.weapon_index = 0;
            weapon_class_struct.weight = var_2a8f6633be8e5ab3.gunfightweight;
            out_array[ weapon_class_hash ] = weapon_class_struct;
        }
        
        var_b87c8459d148bf6a = {};
        var_b87c8459d148bf6a.var_7068c97ad157148 = weapon_bundle.ref;
        var_b87c8459d148bf6a.var_8a6e63cd4ed74efe = [];
        var_b87c8459d148bf6a.var_624cf7fe8109fa26 = 0;
        
        foreach ( var_bc4314627d153177 in arrayrandomize( weapon_bundle.var_3f4bf205a8800fe1 ) )
        {
            var_b87c8459d148bf6a.var_8a6e63cd4ed74efe[ var_b87c8459d148bf6a.var_8a6e63cd4ed74efe.size ] = var_bc4314627d153177.var_f7fbce655ee22ca4;
        }
        
        out_array[ weapon_class_hash ].weapons[ out_array[ weapon_class_hash ].weapons.size ] = var_b87c8459d148bf6a;
    }
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0xb582a911, Offset: 0x1209
// Size: 0x1b3
function private function_4c24d9ae17c2f073( equipment_list )
{
    out_array = [];
    
    foreach ( equipment_struct in arrayrandomize( equipment_list ) )
    {
        if ( !isdefined( equipment_struct.bundle ) )
        {
            continue;
        }
        
        equipment_bundle = getscriptbundle( equipment_struct.bundle );
        
        if ( !isdefined( equipment_bundle ) )
        {
            assertmsg( "<dev string:x24>" + "<dev string:x17b>" + "<dev string:x68>" + "<dev string:x1a0>" + equipment_struct.bundle );
            continue;
        }
        
        if ( equipment_bundle.equipmenttype != "lethal" && equipment_bundle.equipmenttype != "tactical" )
        {
            continue;
        }
        
        if ( !equipment_bundle.var_333ed0d0441d88ae )
        {
            continue;
        }
        
        ref_name = equipment_struct.ref;
        var_12ca294d970418e6 = istrue( equipment_bundle.var_8c540b4f748d7da1 );
        
        if ( !isdefined( out_array[ getxhash( equipment_bundle.equipmenttype ) ] ) )
        {
            out_array[ getxhash( equipment_bundle.equipmenttype ) ] = [];
        }
        
        out_array[ getxhash( equipment_bundle.equipmenttype ) ][ out_array[ getxhash( equipment_bundle.equipmenttype ) ].size ] = { #var_12ca294d970418e6:var_12ca294d970418e6, #ref_name:ref_name };
    }
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x54859e6b, Offset: 0x13c5
// Size: 0xb9
function private function_c17ed2ea1787e58( weapon_string )
{
    if ( !weapon_string || weapon_string == "" )
    {
        return;
    }
    
    string_tokens = strtok( weapon_string, "," );
    out_struct = { #attachments:[], #var_7068c97ad157148:string_tokens[ 0 ] };
    
    for ( i = 1; i < string_tokens.size ; i++ )
    {
        if ( isdefined( string_tokens[ i ] ) )
        {
            out_struct.attachments[ out_struct.attachments.size ] = string_tokens[ i ];
            continue;
        }
        
        out_struct.attachments[ out_struct.attachments.size ] = "none";
    }
    
    return out_struct;
}

// Namespace gunfight_loadouts
// Params 0, eflags: 0x4
// Checksum 0x66ae06b1, Offset: 0x1487
// Size: 0xbd
function private function_a13baa61697856d6()
{
    var_cd6d759b2c772946 = game_utility_mp::function_4b7180ed8c2e9742( #"gunfightloadouts" );
    assert( isdefined( var_cd6d759b2c772946 ), "<dev string:x1c4>" );
    game[ #"gunfight_loadouts" ] = { #var_2790e6cfb2311b22:1 };
    game[ #"gunfight_loadouts" ].weapons = function_11a658df0ae9869c( var_cd6d759b2c772946.weapons );
    game[ #"gunfight_loadouts" ].var_3d885aaf4265ba27 = function_c75e61c27f869ca1( var_cd6d759b2c772946.lethalequipment );
    game[ #"gunfight_loadouts" ].var_86b9c7a364825874 = function_c75e61c27f869ca1( var_cd6d759b2c772946.tacticalequipment );
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0xf6cf1036, Offset: 0x154c
// Size: 0x8f
function private function_73d40914ffec2199( equipment_ref_name )
{
    equipment_key = !isxhash( equipment_ref_name ) ? getxhash( equipment_ref_name ) : equipment_ref_name;
    equipment_struct = game[ #"gunfight_loadouts" ].var_3d885aaf4265ba27[ equipment_key ];
    
    if ( !isdefined( equipment_struct ) )
    {
        equipment_struct = game[ #"gunfight_loadouts" ].var_86b9c7a364825874[ equipment_key ];
    }
    
    assert( isdefined( equipment_struct ), "<dev string:x1f6>" + equipment_ref_name );
    return equipment_struct.var_e56ecf593f2803da;
}

// Namespace gunfight_loadouts
// Params 2, eflags: 0x4
// Checksum 0x66d86b08, Offset: 0x15e4
// Size: 0x571
function private function_d52d51082a6bde70( weapon_category_hash, count = 32 )
{
    out_array = [];
    var_d9cabb6603e8cf2c = getdvarint( @"hash_11b0a3b910c49eb6", 0 );
    random_weapon_categories = !isdefined( weapon_category_hash );
    lethal_equipment_keys = getarraykeys( game[ #"gunfight_loadouts" ].var_3d885aaf4265ba27 );
    tactical_equipment_keys = getarraykeys( game[ #"gunfight_loadouts" ].var_86b9c7a364825874 );
    var_6ed00e4da4803016 = [ #"ar", #"smg", #"lmg", #"shotgun", #"sniper", #"pistol" ];
    var_dc6fef9f60627b9d = utility::queue_create( var_6ed00e4da4803016.size - 1 );
    
    if ( weapon_category_hash )
    {
        switch ( weapon_category_hash )
        {
            case #"weapon_battle":
            case #"weapon_assault":
                weapon_category_hash = #"ar";
                break;
            case #"weapon_smg":
                weapon_category_hash = #"smg";
                break;
            case #"weapon_lmg":
                weapon_category_hash = #"lmg";
                break;
            case #"weapon_shotgun":
                weapon_category_hash = #"shotgun";
                break;
            case #"weapon_dmr":
            case #"weapon_sniper":
                weapon_category_hash = #"sniper";
                break;
            case #"weapon_pistol":
                weapon_category_hash = #"pistol";
                break;
            case #"weapon_projectile":
                weapon_category_hash = #"launcher";
                break;
            case #"weapon_melee":
            case #"weapon_melee2":
                weapon_category_hash = #"melee";
                break;
            default:
                assertmsg( "<dev string:x24>" + "<dev string:x22b>" + "<dev string:x68>" + "<dev string:x262>" + weapon_category_hash );
                return [];
        }
    }
    
    while ( out_array.size < count )
    {
        loadout_struct = {};
        
        if ( var_d9cabb6603e8cf2c )
        {
            [ _, loadout_struct.primary_weapon ] = function_1a665a9cf93b4584( #"melee" );
            loadout_struct.secondary_weapon = {};
            loadout_struct.secondary_weapon.var_7068c97ad157148 = "none";
            loadout_struct.secondary_weapon.attachments = [ "none", "none", "none", "none", "none", "none" ];
        }
        else
        {
            if ( random_weapon_categories )
            {
                random_index = randomint( var_6ed00e4da4803016.size );
                weapon_category_hash = var_6ed00e4da4803016[ random_index ];
                
                if ( utility::queue_isfull( var_dc6fef9f60627b9d ) && utility::queue_size( var_dc6fef9f60627b9d ) > 0 )
                {
                    if ( !isdefined( var_6ed00e4da4803016 ) )
                    {
                        var_6ed00e4da4803016 = [];
                    }
                    
                    var_6ed00e4da4803016[ var_6ed00e4da4803016.size ] = utility::queue_peek( var_dc6fef9f60627b9d );
                    var_dc6fef9f60627b9d = utility::queue_dequeue( var_dc6fef9f60627b9d );
                }
                
                var_dc6fef9f60627b9d = utility::queue_enqueue( var_dc6fef9f60627b9d, weapon_category_hash );
                var_6ed00e4da4803016 = arrayremove( var_6ed00e4da4803016, weapon_category_hash );
            }
            
            [ var_63b2b755e6265a7b, loadout_struct.primary_weapon ] = function_1a665a9cf93b4584( weapon_category_hash );
            
            if ( var_63b2b755e6265a7b == #"sidearm" )
            {
                var_289a16ad1fec27ff = randomint( 100 ) < 10 ? #"launcher" : #"melee";
                [ _, loadout_struct.secondary_weapon ] = function_1a665a9cf93b4584( var_289a16ad1fec27ff );
            }
            else if ( weapon_category_hash != #"melee" )
            {
                [ _, loadout_struct.secondary_weapon ] = function_1a665a9cf93b4584( #"pistol" );
            }
            else
            {
                loadout_struct.secondary_weapon = {};
                loadout_struct.secondary_weapon.var_7068c97ad157148 = "none";
                loadout_struct.secondary_weapon.attachments = [ "none", "none", "none", "none", "none", "none" ];
            }
        }
        
        lethal_equipment_index = function_49003adb8f6b4928( 0, lethal_equipment_keys.size - 1, lethal_equipment_index );
        tactical_equipment_index = function_49003adb8f6b4928( 0, tactical_equipment_keys.size - 1, tactical_equipment_index );
        lethal_equipment_key = lethal_equipment_keys[ lethal_equipment_index ];
        tactical_equipment_key = tactical_equipment_keys[ tactical_equipment_index ];
        loadout_struct.lethal_equipment_name = game[ #"gunfight_loadouts" ].var_3d885aaf4265ba27[ lethal_equipment_key ].ref_name;
        loadout_struct.tactical_equipment_name = game[ #"gunfight_loadouts" ].var_86b9c7a364825874[ tactical_equipment_key ].ref_name;
        
        if ( !isdefined( out_array ) )
        {
            out_array = [];
        }
        
        out_array[ out_array.size ] = loadout_struct;
    }
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x2d74b469, Offset: 0x1b5e
// Size: 0x2f0
function private function_11a658df0ae9869c( weapons_list )
{
    out_struct = {};
    use_blueprints = arena::function_7edf0599605cd8ec();
    game[ #"gunfight_loadouts" ].var_9903bc162ff277a2 = 0;
    
    foreach ( var_b87c8459d148bf6a in weapons_list )
    {
        if ( var_b87c8459d148bf6a.ignore )
        {
            continue;
        }
        
        assert( var_b87c8459d148bf6a.weaponcategory != "<dev string:x282>", "<dev string:x287>" + var_b87c8459d148bf6a.rootweaponname + "<dev string:x290>" );
        configuration_data = use_blueprints ? function_9a05c5608c91ad70( var_b87c8459d148bf6a ) : function_70d2531b7f447907( var_b87c8459d148bf6a );
        
        if ( isdefined( configuration_data ) )
        {
            if ( !isdefined( out_struct.unused ) )
            {
                out_struct.unused = [];
            }
            
            if ( !isdefined( out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ] ) )
            {
                out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ] = {};
            }
            
            if ( !isdefined( out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ].unused ) )
            {
                out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ].unused = [];
            }
            
            if ( !isdefined( out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ].unused[ var_b87c8459d148bf6a.rootweaponname ] ) )
            {
                out_struct.unused[ var_b87c8459d148bf6a.weaponcategory ].unused[ var_b87c8459d148bf6a.rootweaponname ] = configuration_data;
            }
        }
        
        game[ #"gunfight_loadouts" ].var_9903bc162ff277a2++;
    }
    
    queue_size = out_struct.unused.size - 1;
    
    if ( queue_size > 0 )
    {
        out_struct.used = utility::queue_create( queue_size );
    }
    
    foreach ( weapon_category_struct in out_struct.unused )
    {
        queue_size = weapon_category_struct.unused.size - 1;
        
        if ( queue_size > 0 )
        {
            weapon_category_struct.used = utility::queue_create( queue_size );
        }
    }
    
    return out_struct;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x30352f45, Offset: 0x1e57
// Size: 0x279
function private function_70d2531b7f447907( var_b87c8459d148bf6a )
{
    if ( !isdefined( var_b87c8459d148bf6a.configurations ) || var_b87c8459d148bf6a.configurations.size == 0 )
    {
        return;
    }
    
    out_struct = {};
    out_struct.unused = [];
    
    foreach ( configuration_struct in var_b87c8459d148bf6a.configurations )
    {
        if ( configuration_struct.ignore )
        {
            continue;
        }
        
        if ( !isdefined( out_struct.unused[ configuration_struct.playstylecategory ] ) )
        {
            out_struct.unused[ configuration_struct.playstylecategory ] = {};
        }
        
        if ( !isdefined( out_struct.unused[ configuration_struct.playstylecategory ].unused ) )
        {
            out_struct.unused[ configuration_struct.playstylecategory ].unused = [];
        }
        
        out_struct.unused[ configuration_struct.playstylecategory ].unused[ out_struct.unused[ configuration_struct.playstylecategory ].unused.size ] = function_a6b0c48144bad27e( configuration_struct.attachments );
    }
    
    queue_size = out_struct.unused.size - 1;
    
    if ( queue_size > 0 )
    {
        out_struct.used = utility::queue_create( out_struct.unused.size - 1 );
    }
    
    foreach ( var_e105cdc5bcfe84e2 in out_struct.unused )
    {
        queue_size = var_e105cdc5bcfe84e2.unused.size - 1;
        
        if ( queue_size > 0 )
        {
            var_e105cdc5bcfe84e2.used = utility::queue_create( queue_size );
        }
    }
    
    return out_struct;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x2810101a, Offset: 0x20d9
// Size: 0x279
function private function_9a05c5608c91ad70( var_b87c8459d148bf6a )
{
    if ( !isdefined( var_b87c8459d148bf6a.blueprints ) || var_b87c8459d148bf6a.blueprints.size == 0 )
    {
        return;
    }
    
    out_struct = {};
    out_struct.unused = [];
    
    foreach ( blueprint_struct in var_b87c8459d148bf6a.blueprints )
    {
        if ( blueprint_struct.ignore )
        {
            continue;
        }
        
        if ( !isdefined( out_struct.unused[ blueprint_struct.playstylecategory ] ) )
        {
            out_struct.unused[ blueprint_struct.playstylecategory ] = {};
        }
        
        if ( !isdefined( out_struct.unused[ blueprint_struct.playstylecategory ].unused ) )
        {
            out_struct.unused[ blueprint_struct.playstylecategory ].unused = [];
        }
        
        out_struct.unused[ blueprint_struct.playstylecategory ].unused[ out_struct.unused[ blueprint_struct.playstylecategory ].unused.size ] = function_a6b0c48144bad27e( blueprint_struct.attachments );
    }
    
    queue_size = out_struct.unused.size - 1;
    
    if ( queue_size > 0 )
    {
        out_struct.used = utility::queue_create( out_struct.unused.size - 1 );
    }
    
    foreach ( var_e105cdc5bcfe84e2 in out_struct.unused )
    {
        queue_size = var_e105cdc5bcfe84e2.unused.size - 1;
        
        if ( queue_size > 0 )
        {
            var_e105cdc5bcfe84e2.used = utility::queue_create( queue_size );
        }
    }
    
    return out_struct;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0x69e88178, Offset: 0x235b
// Size: 0x9b
function private function_a6b0c48144bad27e( attachments_list )
{
    out_array = [];
    
    foreach ( attachment_struct in attachments_list )
    {
        if ( !isdefined( out_array ) )
        {
            out_array = [];
        }
        
        out_array[ out_array.size ] = attachment_struct.attachmentname;
    }
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 1, eflags: 0x4
// Checksum 0xe044d187, Offset: 0x23ff
// Size: 0xd0
function private function_c75e61c27f869ca1( equipment_list )
{
    out_array = [];
    
    foreach ( equipment_struct in equipment_list )
    {
        if ( !isdefined( equipment_struct.equipmentname ) )
        {
            continue;
        }
        
        out_array[ getxhash( equipment_struct.equipmentname ) ] = { #var_e56ecf593f2803da:equipment_struct.disabledelay, #ref_name:equipment_struct.equipmentname };
    }
    
    return out_array;
}

// Namespace gunfight_loadouts
// Params 2, eflags: 0x4
// Checksum 0x6fca8e0d, Offset: 0x24d8
// Size: 0x32e
function private function_1a665a9cf93b4584( var_fed5411ea4689cc7, use_blueprints )
{
    weapon_category_struct = game[ #"gunfight_loadouts" ].weapons.unused[ var_fed5411ea4689cc7 ];
    
    if ( !isdefined( weapon_category_struct ) )
    {
        assertmsg( "<dev string:x2ae>" + var_fed5411ea4689cc7 );
        return;
    }
    
    weapon_list = weapon_category_struct.unused;
    var_207bdd32734f25fa = getarraykey( weapon_list, randomint( weapon_list.size ) );
    var_b87c8459d148bf6a = weapon_list[ var_207bdd32734f25fa ];
    
    if ( isdefined( weapon_category_struct.used ) )
    {
        if ( utility::queue_isfull( weapon_category_struct.used ) && utility::queue_size( weapon_category_struct.used ) > 0 )
        {
            weapon_category_pair = utility::queue_peek( weapon_category_struct.used );
            weapon_category_struct.used = utility::queue_dequeue( weapon_category_struct.used );
            weapon_list[ weapon_category_pair[ 0 ] ] = weapon_category_pair[ 1 ];
        }
        
        weapon_category_struct.used = utility::queue_enqueue( weapon_category_struct.used, [ var_207bdd32734f25fa, var_b87c8459d148bf6a ] );
        weapon_category_struct.unused[ var_207bdd32734f25fa ] = undefined;
    }
    
    playstyle_list = var_b87c8459d148bf6a.unused;
    playstyle_key = getarraykey( playstyle_list, randomint( playstyle_list.size ) );
    playstyle_struct = playstyle_list[ playstyle_key ];
    
    if ( isdefined( var_b87c8459d148bf6a.used ) )
    {
        if ( utility::queue_isfull( var_b87c8459d148bf6a.used ) && utility::queue_size( var_b87c8459d148bf6a.used ) > 0 )
        {
            var_22b24092c8cfed8b = utility::queue_peek( var_b87c8459d148bf6a.used );
            var_b87c8459d148bf6a.used = utility::queue_dequeue( var_b87c8459d148bf6a.used );
            playstyle_list[ var_22b24092c8cfed8b[ 0 ] ] = var_22b24092c8cfed8b[ 1 ];
        }
        
        var_b87c8459d148bf6a.used = utility::queue_enqueue( var_b87c8459d148bf6a.used, [ playstyle_key, playstyle_struct ] );
        var_b87c8459d148bf6a.unused[ playstyle_key ] = undefined;
    }
    
    configuration_list = playstyle_struct.unused;
    configuration_key = randomint( configuration_list.size );
    attachment_list = configuration_list[ configuration_key ];
    
    if ( isdefined( playstyle_struct.used ) )
    {
        if ( utility::queue_isfull( playstyle_struct.used ) && utility::queue_size( playstyle_struct.used ) > 0 )
        {
            if ( !isdefined( configuration_list ) )
            {
                configuration_list = [];
            }
            
            configuration_list[ configuration_list.size ] = utility::queue_peek( playstyle_struct.used );
            playstyle_struct.used = utility::queue_dequeue( playstyle_struct.used );
        }
        
        playstyle_struct.used = utility::queue_enqueue( playstyle_struct.used, attachment_list );
        configuration_list = arrayremove( configuration_list, attachment_list );
    }
    
    return [ playstyle_key, { #attachments:attachment_list, #var_7068c97ad157148:var_207bdd32734f25fa } ];
}

// Namespace gunfight_loadouts
// Params 3, eflags: 0x4
// Checksum 0x9cc9553, Offset: 0x280f
// Size: 0xf0
function private function_49003adb8f6b4928( min, max, exclude )
{
    out = undefined;
    
    if ( !isdefined( exclude ) )
    {
        out = randomintrange( min, max + 1 );
    }
    else if ( isarray( exclude ) )
    {
        out = min + randomint( max - min - exclude.size );
        
        foreach ( value in arraysort( exclude ) )
        {
            if ( out < value )
            {
                break;
            }
            
            out++;
        }
    }
    else
    {
        out = min + randomint( max - min );
        
        if ( out >= exclude )
        {
            out++;
        }
    }
    
    return out;
}

